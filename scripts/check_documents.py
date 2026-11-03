#!/usr/bin/env python3
"""M0.1 checks. Historical import inventory restrictions intentionally do not apply."""
from pathlib import Path
from configparser import ConfigParser
import hashlib
import json
import re
import subprocess
import zipfile

ROOT = Path(__file__).resolve().parents[1]
BASE = '2d80844b8bc4a147bf428ade00448b5f6d2f02ba'
def check_android_configuration(preset_text, project_text, lock):
    """Check effective INI sections, not substrings in comments/other sections.

    Standard Godot APK templates inherit SDK levels; nonempty Gradle SDK
    overrides are incompatible with this non-Gradle export path.
    """
    preset = ConfigParser(interpolation=None)
    project = ConfigParser(interpolation=None)
    preset.optionxform = str
    project.optionxform = str
    # project.godot has unsectioned config_version metadata before its sections.
    preset.read_string('[godot_metadata]\n' + preset_text)
    project.read_string('[godot_metadata]\n' + project_text)
    assert preset.has_section('preset.0.options'), 'Opções do preset Android ausentes'
    assert project.has_section('rendering'), 'Seção rendering ausente'
    options = preset['preset.0.options']
    assert options.get('gradle_build/use_gradle_build') == 'false', 'Gradle deve permanecer desativado'
    assert options.get('gradle_build/min_sdk') == '""', 'min_sdk deve estar vazio para herdar o template'
    assert options.get('gradle_build/target_sdk') == '""', 'target_sdk deve estar vazio para herdar o template'
    assert project['rendering'].get('textures/vram_compression/import_etc2_astc') == 'true', 'Importação ETC2/ASTC deve estar ativa em rendering'
    assert lock['android']['min_sdk'] == 24, 'Lock deve preservar minSdk esperado 24'
    assert lock['android']['target_sdk'] == 36, 'Lock deve preservar targetSdk esperado 36'
    assert options.get('permissions/internet') == 'false' and options.get('permissions/access_network_state') == 'false', 'Android deve permanecer offline'


def main():
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
    check_android_configuration((ROOT / 'export_presets.cfg').read_text(), (ROOT / 'project.godot').read_text(), lock)
    print('PASS: configuração APK padrão sem Gradle, SDKs herdados (lock 24/36) e ETC2/ASTC ativo')
    assert '| D026 | PENDING' in (ROOT / 'DECISIONS.md').read_text()
    print('PASS: parâmetros v0.2, primeira região desbloqueada, Android offline e D026 pendente')


if __name__ == '__main__':
    main()
