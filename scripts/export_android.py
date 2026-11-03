#!/usr/bin/env python3
"""One durable result per export attempt, including unsuccessful validations.

Module import has no side effects. Tests supply isolated roots and a fake runner;
only the CLI invokes the real Godot/keytool/apksigner processes.
"""
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import uuid
import zipfile

ROOT = Path(__file__).resolve().parents[1]


class ExportFailure(Exception):
    def __init__(self, message, status='FAIL'):
        super().__init__(message)
        self.status = status


def timestamp():
    return datetime.now(timezone.utc).isoformat()


def atomic_json(path, value):
    temporary = path.with_suffix(path.suffix + '.tmp')
    temporary.write_text(json.dumps(value, indent=2, ensure_ascii=False) + '\n')
    temporary.replace(path)


def run_export(root=ROOT, runner=None, environ=None, export_timeout=180):
    """Return (record, CLI exit code); all normal error paths finalize the record."""
    root = Path(root).resolve()
    runner = subprocess.run if runner is None else runner
    env = dict(os.environ if environ is None else environ)
    tools, build = root / '.tools', root / 'build'
    build.mkdir(parents=True, exist_ok=True)
    attempt_id = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S%fZ') + '-' + uuid.uuid4().hex[:8]
    attempt = build / 'export_attempts' / attempt_id
    attempt.mkdir(parents=True)
    result_path = build / 'export_result.json'
    log_path = build / 'export_android.log'
    output = build / 'vila-de-bolso-m0.1-debug.apk'
    record = {
        'schema_version': 2, 'attempt_id': attempt_id, 'started_at': timestamp(),
        'finished_at': None, 'status': 'RUNNING', 'stage': 'initialization',
        'command': [], 'exit_code': None, 'missing_dependencies': [],
        'previous_artifacts': {}, 'attempt_directory': str(attempt),
    }
    logs = []
    exit_code = 2

    def persist():
        atomic_json(attempt / 'result.json', record)
        atomic_json(result_path, record)

    def execute(command, timeout):
        logs.append('$ ' + ' '.join(map(str, command)) + '\n')
        try:
            result = runner(command, env=env, stdout=subprocess.PIPE,
                            stderr=subprocess.STDOUT, text=True, timeout=timeout)
        except subprocess.TimeoutExpired as error:
            partial = error.stdout or ''
            logs.append(partial.decode(errors='replace') if isinstance(partial, bytes) else partial)
            record['timed_out'] = True
            raise
        logs.append(result.stdout or '')
        return result

    try:
        # Archive the preceding result before invalidating PASS. No subprocess
        # or toolchain validation is allowed before a fresh RUNNING is written.
        if result_path.exists():
            result_path.replace(attempt / 'previous_result.json')
            record['previous_artifacts']['result'] = str(attempt / 'previous_result.json')
        persist()
        for path, name in [(output, 'previous-debug.apk'), (log_path, 'previous-export_android.log')]:
            if path.exists():
                target = attempt / name
                path.replace(target)
                record['previous_artifacts'][name] = str(target)
        persist()
        record['stage'] = 'configuration'
        lock = json.loads((root / 'scripts/toolchain.lock.json').read_text())
        binary = env.get('GODOT_BIN')
        if not binary:
            selector = tools / 'godot.path'
            binary = selector.read_text().strip() if selector.exists() else shutil.which('godot')
        if not binary:
            raise ExportFailure('Godot não encontrada; execute scripts/setup.sh', 'BLOCKED')
        record['stage'] = 'version'
        result = execute([binary, '--version'], 30)
        if result.returncode != 0 or result.stdout.strip() != lock['godot_version']:
            raise ExportFailure('Versão Godot não corresponde ao lock', 'BLOCKED')
        java, sdk = tools / 'jdk', tools / 'android-sdk'
        templates = tools / 'data/godot/export_templates/4.6.3.stable'
        required = [java / 'bin/java', java / 'bin/javac', java / 'bin/keytool',
                    sdk / 'platform-tools/adb', sdk / 'build-tools/36.1.0/apksigner',
                    templates / 'android_debug.apk', templates / 'android_release.apk']
        record['missing_dependencies'] = [str(path.relative_to(tools)) for path in required if not path.is_file()]
        settings = tools / 'config/godot/editor_settings-4.6.tres'
        settings.parent.mkdir(parents=True, exist_ok=True)
        settings.write_text('[gd_resource type="EditorSettings" format=3]\n\n[resource]\n'
                            'export/android/java_sdk_path = ' + json.dumps(str(java)) + '\n'
                            'export/android/android_sdk_path = ' + json.dumps(str(sdk)) + '\n')
        if not record['missing_dependencies']:
            record['stage'] = 'keystore'
            key = tools / 'debug.keystore'
            if not key.exists():
                result = execute([str(java / 'bin/keytool'), '-genkeypair', '-keystore', str(key),
                                  '-storepass', 'android', '-alias', 'androiddebugkey', '-keypass', 'android',
                                  '-dname', 'CN=Android Debug,O=Vila de Bolso,C=BR',
                                  '-keyalg', 'RSA', '-validity', '10000'], 60)
                if result.returncode != 0:
                    raise ExportFailure('Falha ao gerar keystore debug')
            env.update(JAVA_HOME=str(java), GODOT_ANDROID_KEYSTORE_DEBUG_PATH=str(key),
                       GODOT_ANDROID_KEYSTORE_DEBUG_USER='androiddebugkey', GODOT_ANDROID_KEYSTORE_DEBUG_PASSWORD='android')
        record['stage'] = 'export'
        record['command'] = [binary, '--headless', '--path', str(root), '--export-debug', 'Android Debug', str(output)]
        persist()
        # Attempt Godot export even when dependencies are missing, retaining its diagnosis.
        result = execute(record['command'], export_timeout)
        record['exit_code'] = result.returncode
        if record['missing_dependencies']:
            raise ExportFailure('Toolchain Android incompleta; consulte missing_dependencies e o log', 'BLOCKED')
        if result.returncode != 0:
            raise ExportFailure('Godot retornou erro de exportação')
        record['stage'] = 'apk_validation'
        if not output.is_file() or not zipfile.is_zipfile(output):
            raise ExportFailure('A tentativa não produziu um APK ZIP válido')
        with zipfile.ZipFile(output) as apk:
            if apk.testzip() is not None:
                raise ExportFailure('CRC inválido no APK')
            required_members = {'AndroidManifest.xml', 'assets/data/world.json'}
            if not required_members.issubset(apk.namelist()):
                raise ExportFailure('APK não contém manifesto ou dados esperados')
        record['stage'] = 'runtime_validation'
        result = execute([sys.executable, str(root / 'scripts/check_runtime_pack.py'),
                          str(output), '--godot', binary], 60)
        record['runtime_validation_exit_code'] = result.returncode
        if result.returncode != 0 or 'PASS: isolated exported runtime dependencies, scene and visible menu' not in result.stdout:
            raise ExportFailure('Dependências/cena/menu do APK falharam no runtime Godot isolado')
        record['stage'] = 'signature'
        result = execute([str(sdk / 'build-tools/36.1.0/apksigner'), 'verify', str(output)], 60)
        record['signature_exit_code'] = result.returncode
        if result.returncode != 0:
            raise ExportFailure('Falha de verificação da assinatura pelo apksigner')
        record.update(status='PASS', stage='complete', apk=str(output),
                      sha256=hashlib.sha256(output.read_bytes()).hexdigest(), bytes=output.stat().st_size)
        exit_code = 0
    except ExportFailure as error:
        record.update(status=error.status, error=str(error))
    except subprocess.TimeoutExpired as error:
        record.update(status='BLOCKED', timed_out=True, error=f'Timeout na etapa {record["stage"]} ({error.timeout}s)')
    except KeyboardInterrupt:
        record.update(status='CANCELLED', error='Tentativa interrompida')
        exit_code = 130
    except Exception as error:
        record.update(status='BLOCKED' if isinstance(error, FileNotFoundError) else 'FAIL',
                      error=f'{type(error).__name__}: {error}')
    finally:
        if record['status'] != 'PASS' and output.exists():
            # A failed/partial APK is evidence, never the current installable artifact.
            unverified = attempt / 'unverified-debug.apk'
            try:
                output.replace(unverified)
                record['unverified_artifact'] = str(unverified)
            except OSError as error:
                record['artifact_archive_error'] = str(error)
        record['finished_at'] = timestamp()
        record['wrapper_exit_code'] = exit_code
        log = ''.join(logs) + '\n' + record.get('error', '') + '\n'
        (attempt / 'export.log').write_text(log)
        log_path.write_text(log)
        persist()
    return record, exit_code


def main():
    record, code = run_export()
    print(json.dumps(record, indent=2, ensure_ascii=False))
    return code


if __name__ == '__main__':
    sys.exit(main())
