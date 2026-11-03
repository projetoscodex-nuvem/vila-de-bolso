"""Installer boundary checks; no real download or Android installation."""
import hashlib
import importlib.util
import io
from pathlib import Path
import stat
import tempfile
import unittest
from unittest.mock import patch
import zipfile

spec = importlib.util.spec_from_file_location('vila_setup', Path(__file__).resolve().parents[1] / 'scripts/setup.py')
setup = importlib.util.module_from_spec(spec)
spec.loader.exec_module(setup)


class SafePackages(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory(prefix='vila-m01-installer-')
        self.root = Path(self.temp.name)
        self.archive = self.root / 'fixture.zip'
        self.destination = self.root / 'tools'

    def tearDown(self):
        self.temp.cleanup()

    def archive_with(self, name, body=b'test'):
        with zipfile.ZipFile(self.archive, 'w') as package:
            package.writestr(name, body)

    def test_regular_file(self):
        self.archive_with('bin/tool', b'expected')
        setup.unzip(self.archive, self.destination)
        self.assertEqual((self.destination / 'bin/tool').read_bytes(), b'expected')

    def test_traversal_cannot_write_outside(self):
        self.archive_with('../outside')
        with self.assertRaises(RuntimeError):
            setup.unzip(self.archive, self.destination)
        self.assertFalse((self.root / 'outside').exists())

    def test_absolute_path_rejected(self):
        self.archive_with('/unexpected_absolute_path')
        with self.assertRaises(RuntimeError):
            setup.unzip(self.archive, self.destination)

    def test_symlink_rejected(self):
        info = zipfile.ZipInfo('link')
        info.create_system = 3
        info.external_attr = (stat.S_IFLNK | 0o777) << 16
        self.archive_with(info, b'../outside')
        with self.assertRaises(RuntimeError):
            setup.unzip(self.archive, self.destination)

    def test_only_selected_templates_extracted(self):
        with zipfile.ZipFile(self.archive, 'w') as package:
            package.writestr('templates/android_debug.apk', b'fixture')
            package.writestr('templates/unused.exe', b'ignored')
        setup.unzip(self.archive, self.destination, {'templates/android_debug.apk': 'android_debug.apk'})
        self.assertEqual({p.name for p in self.destination.iterdir()}, {'android_debug.apk'})

    def test_hash_and_cache_reuse(self):
        payload = b'verified archive bytes'
        fixture = {'url': 'https://example.invalid/fixture.zip', 'sha256': hashlib.sha256(payload).hexdigest()}
        with patch.object(setup, 'CACHE', self.root / 'downloads'), patch.object(setup.urllib.request, 'urlopen', return_value=io.BytesIO(payload)) as download:
            path = setup.download(fixture)
            self.assertEqual(path.read_bytes(), payload)
            self.assertEqual(setup.download(fixture), path)
            self.assertEqual(download.call_count, 1)

    def test_bad_hash_never_becomes_installable_archive(self):
        fixture = {'url': 'https://example.invalid/fixture.zip', 'sha256': '0' * 64}
        with patch.object(setup, 'CACHE', self.root / 'downloads'), patch.object(setup.urllib.request, 'urlopen', return_value=io.BytesIO(b'wrong')):
            with self.assertRaises(RuntimeError):
                setup.download(fixture)
        self.assertFalse((self.root / 'downloads/fixture.zip').exists())


if __name__ == '__main__':
    unittest.main()
