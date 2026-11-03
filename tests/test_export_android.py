"""Isolated exporter fixtures. ZIP payloads and signatures here are FAKE, not APKs.

Every tool invocation is replaced by a runner; these tests never run Godot, Java,
apksigner or a network request, and never create a distributable Android binary.
"""
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
import zipfile

spec = importlib.util.spec_from_file_location('vila_export', Path(__file__).resolve().parents[1] / 'scripts/export_android.py')
exporter = importlib.util.module_from_spec(spec)
spec.loader.exec_module(exporter)
VERSION = '4.6.3.stable.official.7d41c59c4'


class ExportAttemptFixtures(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='vila-export-fixture-NOT-REAL-APK-')
        self.root = Path(self.temp.name)
        (self.root / 'scripts').mkdir()
        (self.root / 'scripts/toolchain.lock.json').write_text(json.dumps({'godot_version': VERSION}))
        self.build = self.root / 'build'
        self.build.mkdir()
        self.output = self.build / 'vila-de-bolso-m0.1-debug.apk'
        self.output.write_bytes(b'PREVIOUS FIXTURE ARTIFACT - NOT A REAL APK')
        self.prior = self.output.read_bytes()
        self.result = self.build / 'export_result.json'
        self.result.write_text(json.dumps({'attempt_id': 'prior', 'status': 'PASS', 'sha256': 'old-fixture-hash'}))
        self.env = {'GODOT_BIN': str(self.root / 'fake-godot')}
        for name in ['jdk/bin/java', 'jdk/bin/javac', 'jdk/bin/keytool',
                     'android-sdk/platform-tools/adb', 'android-sdk/build-tools/36.1.0/apksigner',
                     'data/godot/export_templates/4.6.3.stable/android_debug.apk',
                     'data/godot/export_templates/4.6.3.stable/android_release.apk', 'debug.keystore']:
            path = self.root / '.tools' / name
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text('fixture only')
        self.failure = ''
        self.calls = []

    def tearDown(self):
        self.temp.cleanup()

    def runner(self, command, **kwargs):
        self.calls.append(command)
        # Stale PASS must already be invalidated before even checking the engine.
        live = json.loads(self.result.read_text())
        self.assertEqual(live['status'], 'RUNNING')
        self.assertNotEqual(live['attempt_id'], 'prior')
        if '--version' in command:
            if self.failure == 'version_timeout':
                raise subprocess.TimeoutExpired(command, 30)
            if self.failure == 'missing_tool':
                raise FileNotFoundError('fixture: Godot missing')
            return subprocess.CompletedProcess(command, 0, 'wrong version' if self.failure == 'version' else VERSION + '\n')
        if '-genkeypair' in command:
            return subprocess.CompletedProcess(command, 1, 'fixture: keytool failed')
        if '--export-debug' in command:
            if self.failure == 'export_error' or self.failure == 'dependency':
                return subprocess.CompletedProcess(command, 7, 'fixture: exporter failed')
            if self.failure == 'export_timeout':
                self.output.write_bytes(b'partial fixture')
                raise subprocess.TimeoutExpired(command, 1, output='fixture partial log')
            if self.failure == 'cancel':
                raise KeyboardInterrupt()
            if self.failure == 'missing_output':
                return subprocess.CompletedProcess(command, 0, 'fixture: no artifact')
            if self.failure == 'invalid_zip':
                self.output.write_bytes(b'not zip')
            else:
                with zipfile.ZipFile(self.output, 'w') as package:
                    if self.failure != 'manifest':
                        package.writestr('AndroidManifest.xml', b'FAKE MANIFEST - NOT AN ANDROID BINARY')
                    package.writestr('assets/data/world.json', b'fixture-data-payload')
                if self.failure == 'crc':
                    self.output.write_bytes(self.output.read_bytes().replace(b'fixture-data-payload', b'fixture-data-damaged'))
            return subprocess.CompletedProcess(command, 0, 'fixture: fake ZIP generated')
        if '--godot' in command:
            if self.failure == 'runtime_timeout':
                raise subprocess.TimeoutExpired(command, 60)
            return subprocess.CompletedProcess(command, 1 if self.failure == 'runtime' else 0,
                'fixture only: FAIL' if self.failure in ('runtime', 'runtime_no_marker') else
                'PASS: isolated exported runtime dependencies, scene and visible menu (SIMULATED FIXTURE)')
        if 'verify' in command:
            if self.failure == 'signature_exception':
                raise subprocess.CalledProcessError(1, command, output='fixture bad signature')
            if self.failure == 'signature_timeout':
                raise subprocess.TimeoutExpired(command, 60)
            return subprocess.CompletedProcess(command, 1 if self.failure == 'signature' else 0, 'fixture signature result')
        self.fail('unexpected command: ' + repr(command))

    def attempt(self, failure=''):
        self.failure = failure
        record, code = exporter.run_export(self.root, runner=self.runner, environ=self.env, export_timeout=1)
        self.assertEqual(json.loads(self.result.read_text()), record)
        self.assertIsNotNone(record['finished_at'])
        self.assertNotEqual(record['attempt_id'], 'prior')
        self.assertEqual(json.loads((Path(record['attempt_directory']) / 'result.json').read_text()), record)
        return record, code

    def failed(self, failure, stage, status='FAIL'):
        record, code = self.attempt(failure)
        self.assertEqual(record['status'], status)
        self.assertEqual(record['stage'], stage)
        self.assertNotEqual(code, 0)
        self.assertNotIn('apk', record)
        self.assertNotIn('sha256', record)
        self.assertFalse(self.output.exists())
        self.assertEqual(Path(record['previous_artifacts']['previous-debug.apk']).read_bytes(), self.prior)
        self.assertEqual(json.loads(Path(record['previous_artifacts']['result']).read_text())['status'], 'PASS')
        return record

    def test_signature_failure_replaces_old_pass_and_preserves_artifacts(self):
        record = self.failed('signature', 'signature')
        self.assertEqual(record['signature_exit_code'], 1)
        self.assertTrue(Path(record['unverified_artifact']).exists())

    def test_missing_runtime_dependencies_prevent_success_and_signature(self):
        record = self.failed('runtime', 'runtime_validation')
        self.assertEqual(record['runtime_validation_exit_code'], 1)
        self.assertFalse(any('verify' in command for command in self.calls))

    def test_runtime_zero_without_marker_is_not_success(self):
        self.failed('runtime_no_marker', 'runtime_validation')

    def test_runtime_timeout_replaces_old_pass(self):
        self.failed('runtime_timeout', 'runtime_validation', 'BLOCKED')

    def test_signature_exception_also_finalizes(self):
        self.failed('signature_exception', 'signature')

    def test_signature_timeout_also_finalizes(self):
        self.assertTrue(self.failed('signature_timeout', 'signature', 'BLOCKED')['timed_out'])

    def test_missing_manifest(self):
        self.failed('manifest', 'apk_validation')

    def test_invalid_zip(self):
        self.failed('invalid_zip', 'apk_validation')

    def test_missing_artifact(self):
        self.failed('missing_output', 'apk_validation')

    def test_corrupt_zip_crc(self):
        self.failed('crc', 'apk_validation')

    def test_export_error(self):
        self.assertEqual(self.failed('export_error', 'export')['exit_code'], 7)

    def test_export_timeout_archives_partial_file(self):
        record = self.failed('export_timeout', 'export', 'BLOCKED')
        self.assertTrue(record['timed_out'])
        self.assertEqual(Path(record['unverified_artifact']).read_bytes(), b'partial fixture')

    def test_missing_dependency(self):
        (self.root / '.tools/android-sdk/platform-tools/adb').unlink()
        record = self.failed('dependency', 'export', 'BLOCKED')
        self.assertIn('android-sdk/platform-tools/adb', record['missing_dependencies'])

    def test_wrong_engine_version(self):
        self.failed('version', 'version', 'BLOCKED')

    def test_version_timeout(self):
        self.failed('version_timeout', 'version', 'BLOCKED')

    def test_missing_engine(self):
        self.failed('missing_tool', 'version', 'BLOCKED')

    def test_invalid_lock(self):
        (self.root / 'scripts/toolchain.lock.json').write_text('{bad')
        self.failed('', 'configuration')

    def test_keytool_failure(self):
        (self.root / '.tools/debug.keystore').unlink()
        self.failed('', 'keystore')

    def test_interruption_does_not_leave_pass(self):
        record, code = self.attempt('cancel')
        self.assertEqual(record['status'], 'CANCELLED')
        self.assertEqual(code, 130)

    def test_success_fixture_only_after_signature_verification(self):
        record, code = self.attempt()
        self.assertEqual((record['status'], code), ('PASS', 0))
        self.assertEqual(record['sha256'], hashlib.sha256(self.output.read_bytes()).hexdigest())
        self.assertTrue(any('verify' in c for c in self.calls))
        # This is intentionally a fake ZIP under a disposable fixture root.
        self.assertIn('NOT-REAL-APK', str(self.root))

    def test_repeated_attempts_keep_separate_history(self):
        first, _ = self.attempt()
        second, _ = self.attempt()
        self.assertNotEqual(first['attempt_id'], second['attempt_id'])
        self.assertEqual(json.loads(Path(second['previous_artifacts']['result']).read_text())['attempt_id'], first['attempt_id'])
        self.assertTrue(Path(first['attempt_directory']).exists())
        self.assertTrue(Path(second['previous_artifacts']['previous-debug.apk']).exists())


if __name__ == '__main__':
    unittest.main()
