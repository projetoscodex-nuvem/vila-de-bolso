"""Regressions for standard Godot APK configuration; no Android export implied."""
from copy import deepcopy
import importlib.util
import json
from pathlib import Path
import unittest

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('vila_document_checks', ROOT / 'scripts/check_documents.py')
checks = importlib.util.module_from_spec(spec)
spec.loader.exec_module(checks)


class AndroidConfiguration(unittest.TestCase):
    def setUp(self):
        self.preset = (ROOT / 'export_presets.cfg').read_text()
        self.project = (ROOT / 'project.godot').read_text()
        self.lock = json.loads((ROOT / 'scripts/toolchain.lock.json').read_text())

    def verify(self, preset=None, project=None, lock=None):
        return checks.check_android_configuration(
            self.preset if preset is None else preset,
            self.project if project is None else project,
            self.lock if lock is None else lock)

    def test_repository_inherits_sdk_and_imports_android_textures(self):
        self.verify()

    def test_min_sdk_override_is_rejected(self):
        preset = self.preset.replace('gradle_build/min_sdk=""', 'gradle_build/min_sdk="24"')
        with self.assertRaisesRegex(AssertionError, 'min_sdk deve estar vazio'):
            self.verify(preset=preset)

    def test_target_sdk_override_is_rejected(self):
        preset = self.preset.replace('gradle_build/target_sdk=""', 'gradle_build/target_sdk="36"')
        with self.assertRaisesRegex(AssertionError, 'target_sdk deve estar vazio'):
            self.verify(preset=preset)

    def test_gradle_cannot_be_enabled_as_workaround(self):
        preset = self.preset.replace('gradle_build/use_gradle_build=false', 'gradle_build/use_gradle_build=true')
        with self.assertRaisesRegex(AssertionError, 'Gradle deve permanecer desativado'):
            self.verify(preset=preset)

    def test_disabled_etc2_astc_is_rejected(self):
        project = self.project.replace('import_etc2_astc=true', 'import_etc2_astc=false')
        with self.assertRaisesRegex(AssertionError, 'ETC2/ASTC'):
            self.verify(project=project)

    def test_missing_etc2_astc_is_rejected(self):
        project = self.project.replace('textures/vram_compression/import_etc2_astc=true\n', '')
        with self.assertRaisesRegex(AssertionError, 'ETC2/ASTC'):
            self.verify(project=project)

    def test_etc2_astc_in_wrong_section_is_rejected(self):
        project = self.project.replace('textures/vram_compression/import_etc2_astc=true\n', '')
        project += '\ntextures/vram_compression/import_etc2_astc=true\n'
        with self.assertRaisesRegex(AssertionError, 'ETC2/ASTC'):
            self.verify(project=project)

    def test_expected_min_sdk_stays_locked(self):
        lock = deepcopy(self.lock)
        lock['android']['min_sdk'] = 25
        with self.assertRaisesRegex(AssertionError, 'minSdk esperado 24'):
            self.verify(lock=lock)

    def test_expected_target_sdk_stays_locked(self):
        lock = deepcopy(self.lock)
        lock['android']['target_sdk'] = 35
        with self.assertRaisesRegex(AssertionError, 'targetSdk esperado 36'):
            self.verify(lock=lock)

    def test_comment_cannot_satisfy_etc2_astc_setting(self):
        project = self.project.replace('textures/vram_compression/import_etc2_astc=true', '; textures/vram_compression/import_etc2_astc=true')
        with self.assertRaisesRegex(AssertionError, 'ETC2/ASTC'):
            self.verify(project=project)


if __name__ == '__main__':
    unittest.main()
