#!/usr/bin/env python3
"""Validate an exported PCK/ZIP or APK's assets using Godot, outside the source tree.

No templates, Android SDK or network are needed for this host/headless check.
The test driver is the only file copied from the repository. --main-pack loads
the exported project settings as well as its resources.
"""
import argparse
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parents[1]
PASS_MARKER = 'PASS: isolated exported runtime dependencies, scene and visible menu'


def check_pack(artifact, godot, runner=subprocess.run, timeout=45):
    artifact = Path(artifact).resolve()
    if not artifact.is_file():
        raise ValueError('Exported artifact does not exist')
    with tempfile.TemporaryDirectory(prefix='vila-runtime-isolated-') as temp:
        isolated = Path(temp) / 'project'
        isolated.mkdir()
        shutil.copyfile(ROOT / 'scripts/check_runtime_pack.gd', isolated / 'driver.gd')
        pack = artifact
        if artifact.suffix.lower() == '.apk':
            # Godot Android exports resources as assets/* in the APK ZIP.
            # Repack bytes without extracting onto the filesystem or consulting source.
            pack = Path(temp) / 'runtime.zip'
            with zipfile.ZipFile(artifact) as apk, zipfile.ZipFile(pack, 'w') as runtime:
                if apk.testzip() is not None:
                    raise ValueError('APK CRC failure')
                names = set()
                for member in apk.infolist():
                    if not member.filename.startswith('assets/') or member.is_dir():
                        continue
                    name = member.filename[len('assets/'):]
                    if name.startswith('/') or '\\' in name or '..' in name.split('/') or name in names:
                        raise ValueError('Invalid or duplicate APK resource path: ' + name)
                    names.add(name)
                    runtime.writestr(name, apk.read(member))
                if not names:
                    raise ValueError('APK has no Godot assets')
        env = dict(os.environ)
        # No development save or source resource path is shared with the test process.
        for variable, folder in [('XDG_DATA_HOME', 'data'), ('XDG_CONFIG_HOME', 'config'), ('XDG_CACHE_HOME', 'cache')]:
            env[variable] = str(Path(temp) / folder)
        result = runner([str(godot), '--headless', '--path', str(isolated), '--main-pack', str(pack),
                         '--script', str(isolated / 'driver.gd')],
                        cwd=isolated, env=env, text=True, stdout=subprocess.PIPE,
                        stderr=subprocess.STDOUT, timeout=timeout)
        log = result.stdout or ''
        passed = result.returncode == 0 and PASS_MARKER in log and 'ERROR:' not in log
        return passed, log


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('artifact', type=Path)
    parser.add_argument('--godot', default=os.environ.get('GODOT_BIN') or shutil.which('godot'))
    args = parser.parse_args()
    if not args.godot:
        parser.error('Set GODOT_BIN or pass --godot')
    try:
        passed, log = check_pack(args.artifact, args.godot)
    except (OSError, ValueError, zipfile.BadZipFile, subprocess.SubprocessError) as error:
        print(f'FAIL: {type(error).__name__}: {error}')
        return 2
    print(log, end='')
    return 0 if passed else 1


if __name__ == '__main__':
    raise SystemExit(main())
