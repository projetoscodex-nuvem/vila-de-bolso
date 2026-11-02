#!/usr/bin/env python3
"""M0.1 checks. Historical import inventory restrictions intentionally do not apply."""
from pathlib import Path
import hashlib
import json
import re
import subprocess
import zipfile

ROOT = Path(__file__).resolve().parents[1]
BASE = '2d80844b8bc4a147bf428ade00448b5f6d2f02ba'
archive = ROOT / 'Vila_de_Bolso_M0_v0_2.zip'
assert hashlib.sha256(archive.read_bytes()).hexdigest() == 'e5df94aeabd7eeca57dd844b1cface0108f929dc90ba41e6dd2c07f699755697'
with zipfile.ZipFile(archive) as package:
    assert package.testzip() is None
    manifest = json.loads(package.read('MANIFEST_SHA256.json'))
    assert set(manifest) == set(package.namelist()) - {'MANIFEST_SHA256.json'}
    assert all(hashlib.sha256(package.read(n)).hexdigest() == h for n, h in manifest.items())
    assert (ROOT / 'MANIFEST_SHA256.json').read_bytes() == package.read('MANIFEST_SHA256.json')
    assert all((ROOT / name).read_bytes() == package.read(name) for name in package.namelist() if name.endswith('.png'))
old_report = subprocess.check_output(['git', 'show', BASE + ':reports/IMPORT_V0_2_REPORT.md'], cwd=ROOT)
assert (ROOT / 'reports/IMPORT_V0_2_REPORT.md').read_bytes() == old_report
print('PASS: ZIP/manifesto/PNGs e relatório histórico preservados; 27 hashes originais')
paths = subprocess.check_output(['git', 'ls-files', '--cached', '--others', '--exclude-standard'], cwd=ROOT, text=True).splitlines()
links = 0
markdown = 0
for name in set(paths):
    if not name.endswith('.md'):
        continue
    content = (ROOT / name).read_text()
    assert content.strip(), name
    markdown += 1
    prose = re.sub(r'```.*?```', '', content, flags=re.S)
    for raw in re.findall(r'!?\[[^\]]*\]\(([^)]+)\)', prose):
        dest = raw.strip().split('#', 1)[0]
        if not dest or re.match(r'[a-zA-Z][a-zA-Z0-9+.-]*:', dest):
            continue
        target = ((ROOT / name).parent / dest).resolve()
        assert target.is_relative_to(ROOT) and target.exists(), (name, dest)
        links += 1
print(f'PASS: {markdown} Markdown UTF-8 não vazios e {links} links locais')
package = json.loads((ROOT / 'PACKAGE_VERSION.json').read_text())['prototype_parameters']
world = json.loads((ROOT / 'data/world.json').read_text())
for key in ('phase_width', 'phase_height', 'kingdom_width', 'kingdom_height'):
    assert world[key] == package[key], key
assert world['placements_future'] == package['placements'] == 60
assert world['offers_future'] == package['offers'] == 62
assert len(world['regions']) == 6
assert [r['id'] for r in world['regions'] if r['unlocked']] == ['region_1']
lock = json.loads((ROOT / 'scripts/toolchain.lock.json').read_text())
assert lock['android']['min_sdk'] == 24 and lock['android']['target_sdk'] == 36
preset = (ROOT / 'export_presets.cfg').read_text()
assert 'permissions/internet=false' in preset and 'permissions/access_network_state=false' in preset
assert 'gradle_build/use_gradle_build=false' in preset
assert 'gradle_build/min_sdk="24"' in preset and 'gradle_build/target_sdk="36"' in preset
assert '| D026 | PENDING' in (ROOT / 'DECISIONS.md').read_text()
print('PASS: parâmetros v0.2, primeira região desbloqueada, Android offline e D026 pendente')
