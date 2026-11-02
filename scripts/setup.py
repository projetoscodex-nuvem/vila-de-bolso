#!/usr/bin/env python3
"""Pinned Linux x86_64 setup. No third-party installer scripts or distro Android SDK.
--android installs only tools needed for the standard APK template (no Gradle/NDK).
"""
import argparse
import hashlib
import json
import os
from pathlib import Path, PurePosixPath
import platform
import shutil
import stat
import subprocess
import sys
import tarfile
import urllib.request
import xml.etree.ElementTree as ET
import zipfile

ROOT = Path(__file__).resolve().parents[1]
TOOLS = ROOT / ".tools"
LOCK = json.loads((ROOT / "scripts/toolchain.lock.json").read_text())
CACHE = TOOLS / "downloads"


def download(spec):
    CACHE.mkdir(parents=True, exist_ok=True)
    target = CACHE / spec["url"].rsplit("/", 1)[-1]
    def matches():
        if not target.exists():
            return False
        with target.open("rb") as stream:
            return hashlib.file_digest(stream, "sha256").hexdigest() == spec["sha256"]
    if not matches():
        temporary = target.with_suffix(target.suffix + ".partial")
        print("Download oficial:", spec["url"], flush=True)
        # Keep the inherited proxy and CA configuration. Never disable TLS checks.
        with urllib.request.urlopen(spec["url"], timeout=30) as response, temporary.open("wb") as stream:
            shutil.copyfileobj(response, stream, 1024 * 1024)
        with temporary.open("rb") as stream:
            if hashlib.file_digest(stream, "sha256").hexdigest() != spec["sha256"]:
                raise RuntimeError("SHA-256 divergiu: " + temporary.name)
        temporary.replace(target)
    return target


def unzip(archive, destination, member_map=None):
    destination.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(archive) as package:
        for entry in package.infolist():
            name = entry.filename
            path = PurePosixPath(name)
            if path.is_absolute() or ".." in path.parts or "\\" in name or ":" in name:
                raise RuntimeError("Caminho inseguro no arquivo")
            mode = entry.external_attr >> 16
            if stat.S_IFMT(mode) not in (0, stat.S_IFREG, stat.S_IFDIR):
                raise RuntimeError("Tipo especial/symlink recusado")
            if member_map is not None:
                if name not in member_map:
                    continue
                relative = member_map[name]
            else:
                relative = name
            target = destination / relative
            if not target.resolve().is_relative_to(destination.resolve()):
                raise RuntimeError("Destino fora da raiz")
            if entry.is_dir():
                target.mkdir(parents=True, exist_ok=True)
            else:
                target.parent.mkdir(parents=True, exist_ok=True)
                with package.open(entry) as source, target.open("wb") as output:
                    shutil.copyfileobj(source, output)
                if mode & 0o111:
                    target.chmod(0o755)


def setup(android):
    if platform.system() != "Linux" or platform.machine() != "x86_64":
        raise RuntimeError("Setup fixado para Linux x86_64; não substituir toolchain silenciosamente")
    TOOLS.mkdir(exist_ok=True)
    free = shutil.disk_usage(ROOT).free
    print(f"Recursos: CPU={os.cpu_count()} disco_livre={free} bytes", flush=True)
    candidates = [os.environ.get("GODOT_BIN"), str(TOOLS / "godot/Godot_v4.6.3-stable_linux.x86_64"), shutil.which("godot")]
    binary = None
    for candidate in candidates:
        if candidate and Path(candidate).is_file():
            output = subprocess.check_output([candidate, "--version"], text=True).strip()
            if output == LOCK["godot_version"]:
                binary = str(Path(candidate).resolve())
                break
    if binary is None:
        unzip(download(LOCK["godot"]), TOOLS / "godot")
        binary = str(TOOLS / "godot/Godot_v4.6.3-stable_linux.x86_64")
        Path(binary).chmod(0o755)
    version = subprocess.check_output([binary, "--version"], text=True).strip()
    if version != LOCK["godot_version"]:
        raise RuntimeError("Versão Godot divergente: " + version)
    (TOOLS / "godot.path").write_text(binary + "\n")
    print("PASS: Godot fixada", version, flush=True)
    if not android:
        return
    if free < 4_000_000_000:
        raise RuntimeError("Espaço insuficiente para downloads/extração Android (mínimo 4 GB livres)")
    # A real JDK (java + javac + keytool), isolated from the host's JRE.
    java = TOOLS / "jdk"
    if not (java / "bin/javac").exists():
        archive = download(LOCK["jdk"])
        staging = TOOLS / "jdk-staging"
        staging.mkdir(exist_ok=True)
        with tarfile.open(archive) as package:
            package.extractall(staging, filter="data")
        extracted = next(p for p in staging.iterdir() if (p / "bin/javac").exists())
        extracted.rename(java)
    java_output = subprocess.check_output([str(java / "bin/java"), "-version"], stderr=subprocess.STDOUT, text=True)
    if LOCK["jdk_version"] not in java_output:
        raise RuntimeError("JDK não corresponde ao lock")
    templates = TOOLS / "data/godot/export_templates/4.6.3.stable"
    if not (templates / "android_debug.apk").exists():
        # Extract only Android templates, not all 1.25 GB of cross-platform tools.
        unzip(download(LOCK["templates"]), templates, {
            "templates/android_debug.apk": "android_debug.apk",
            "templates/android_release.apk": "android_release.apk",
            "templates/version.txt": "version.txt",
        })
    sdk = TOOLS / "android-sdk"
    commandline = sdk / "cmdline-tools/pinned"
    if not (commandline / "bin/sdkmanager").exists():
        archive = download(LOCK["commandline_tools"])
        with zipfile.ZipFile(archive) as package:
            members = {n: n[len("cmdline-tools/"):] for n in package.namelist() if n.startswith("cmdline-tools/") and not n.endswith("/")}
        unzip(archive, commandline, members)
    env = os.environ.copy()
    env.update(JAVA_HOME=str(java), ANDROID_SDK_ROOT=str(sdk))
    # Reuse the managed host's installed CA trust for the downloaded JVM, if present.
    trust = Path("/etc/ssl/certs/java/cacerts")
    if trust.exists():
        env["JAVA_TOOL_OPTIONS"] = env.get("JAVA_TOOL_OPTIONS", "") + " -Djavax.net.ssl.trustStore=" + str(trust)
    manager = str(commandline / "bin/sdkmanager")
    # sdkmanager's platform-tools ID has no version suffix. Check the official
    # catalog BEFORE installation, instead of silently upgrading a pinned SDK.
    platform_properties = sdk / "platform-tools/source.properties"
    expected_revision = "Pkg.Revision=" + LOCK["android"]["platform_tools"]
    if platform_properties.exists():
        if expected_revision not in platform_properties.read_text().replace(" ", ""):
            raise RuntimeError("Platform-Tools instalado diverge do lock; instalação preservada")
    else:
        with urllib.request.urlopen("https://dl.google.com/android/repository/repository2-1.xml", timeout=30) as response:
            catalog = ET.parse(response)
        candidates = [p for p in catalog.findall(".//{*}remotePackage") if p.get("path") == "platform-tools"]
        if not candidates:
            raise RuntimeError("Platform-Tools ausente do catálogo oficial")
        revision = candidates[0].find("{*}revision")
        actual_revision = ".".join(revision.findtext("{*}" + part, "0") for part in ("major", "minor", "micro"))
        if actual_revision != LOCK["android"]["platform_tools"]:
            raise RuntimeError("Catálogo Platform-Tools diverge do lock; nenhuma atualização autorizada")
    subprocess.run([manager, "--sdk_root=" + str(sdk), "--licenses"], input="y\n" * 100, text=True, env=env, check=True, timeout=600)
    packages = [p for p in LOCK["android"]["sdk_packages"] if p != "platform-tools" or not platform_properties.exists()]
    subprocess.run([manager, "--sdk_root=" + str(sdk), *packages], env=env, check=True, timeout=1200)
    properties = (sdk / "platform-tools/source.properties").read_text()
    if "Pkg.Revision=" + LOCK["android"]["platform_tools"] not in properties.replace(" ", ""):
        raise RuntimeError("Platform-Tools divergente do lock; não atualizar lock automaticamente")
    (TOOLS / "installed_android.json").write_text(json.dumps({"jdk": java_output.strip(), "platform_tools": properties, "lock_sha256": hashlib.sha256((ROOT / "scripts/toolchain.lock.json").read_bytes()).hexdigest()}, indent=2))
    print("PASS: Android/JDK/templates instalados; execute scripts/export_android.sh", flush=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--android", action="store_true")
    args = parser.parse_args()
    try:
        setup(args.android)
    except (OSError, ValueError, RuntimeError, subprocess.SubprocessError) as error:
        print("BLOCKED:", error, file=sys.stderr)
        sys.exit(2)
