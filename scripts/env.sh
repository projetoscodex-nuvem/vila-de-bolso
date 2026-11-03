#!/usr/bin/env bash
# Source this file; do not overwrite HOME or the platform's proxy/trust variables.
VILA_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
export XDG_DATA_HOME="$VILA_ROOT/.tools/data"
export XDG_CONFIG_HOME="$VILA_ROOT/.tools/config"
export XDG_CACHE_HOME="$VILA_ROOT/.tools/cache"
mkdir -p "$XDG_DATA_HOME" "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" "$VILA_ROOT/build"
if [[ -z "${GODOT_BIN:-}" ]]; then
  if [[ -f "$VILA_ROOT/.tools/godot.path" ]]; then
    GODOT_BIN="$(cat "$VILA_ROOT/.tools/godot.path")"
  else
    GODOT_BIN="$(command -v godot || true)"
  fi
fi
export GODOT_BIN
if [[ -d "$VILA_ROOT/.tools/jdk" ]]; then
  export JAVA_HOME="$VILA_ROOT/.tools/jdk"
fi
export ANDROID_SDK_ROOT="$VILA_ROOT/.tools/android-sdk"
