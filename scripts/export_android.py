#!/usr/bin/env python3
"""A real export attempt, with retained diagnostics and no fabricated APK/hash."""
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys
import zipfile

ROOT=Path(__file__).resolve().parents[1]
TOOLS=ROOT/'.tools'
LOCK=json.loads((ROOT/'scripts/toolchain.lock.json').read_text())
BUILD=ROOT/'build'
BUILD.mkdir(exist_ok=True)
binary=os.environ.get('GODOT_BIN') or (TOOLS/'godot.path').read_text().strip()
version=subprocess.check_output([binary,'--version'],text=True).strip()
if version != LOCK['godot_version']:
    raise SystemExit('BLOCKED: versão Godot não corresponde ao lock')
java=TOOLS/'jdk'
sdk=TOOLS/'android-sdk'
templates=TOOLS/'data/godot/export_templates/4.6.3.stable/android_debug.apk'
missing=[str(p.relative_to(TOOLS)) for p in [java/'bin/java',java/'bin/javac',java/'bin/keytool',sdk/'platform-tools/adb',sdk/'build-tools/36.1.0/apksigner',templates] if not p.exists()]
settings=TOOLS/'config/godot/editor_settings-4.6.tres'
settings.parent.mkdir(parents=True,exist_ok=True)
settings.write_text('[gd_resource type="EditorSettings" format=3]\n\n[resource]\nexport/android/java_sdk_path = '+json.dumps(str(java))+'\nexport/android/android_sdk_path = '+json.dumps(str(sdk))+'\n')
key=TOOLS/'debug.keystore'
env=os.environ.copy()
if not missing:
    if not key.exists():
        subprocess.run([str(java/'bin/keytool'),'-genkeypair','-keystore',str(key),'-storepass','android','-alias','androiddebugkey','-keypass','android','-dname','CN=Android Debug,O=Vila de Bolso,C=BR','-keyalg','RSA','-validity','10000'],check=True)
    env.update(GODOT_ANDROID_KEYSTORE_DEBUG_PATH=str(key),GODOT_ANDROID_KEYSTORE_DEBUG_USER='androiddebugkey',GODOT_ANDROID_KEYSTORE_DEBUG_PASSWORD='android')
output=BUILD/'vila-de-bolso-m0.1-debug.apk'
if output.exists():
    output.replace(BUILD/'previous-debug.apk')
command=[binary,'--headless','--path',str(ROOT),'--export-debug','Android Debug',str(output)]
result=subprocess.run(command,env=env,stdout=subprocess.PIPE,stderr=subprocess.STDOUT,text=True,timeout=180)
(BUILD/'export_android.log').write_text(result.stdout)
print(result.stdout)
record={'command':command,'exit_code':result.returncode,'missing_dependencies':missing,'status':'BLOCKED'}
if not missing and result.returncode == 0 and output.is_file() and zipfile.is_zipfile(output):
    with zipfile.ZipFile(output) as apk:
        if 'AndroidManifest.xml' not in apk.namelist() or 'assets/data/world.json' not in apk.namelist():
            raise SystemExit('FAIL: APK não contém manifesto ou dados esperados')
    subprocess.run([str(sdk/'build-tools/36.1.0/apksigner'),'verify',str(output)],env={**env,'JAVA_HOME':str(java)},check=True)
    record.update(status='PASS',apk=str(output),sha256=hashlib.sha256(output.read_bytes()).hexdigest(),bytes=output.stat().st_size)
(BUILD/'export_result.json').write_text(json.dumps(record,indent=2)+'\n')
print(json.dumps(record,indent=2))
sys.exit(0 if record['status']=='PASS' else 2)
