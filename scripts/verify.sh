#!/usr/bin/env bash
set -euo pipefail
source "$(dirname -- "${BASH_SOURCE[0]}")/env.sh"
cd "$VILA_ROOT"
python3 scripts/setup.py
source "$VILA_ROOT/scripts/env.sh"
python3 -m unittest discover -s tests -p 'test_*.py' -v > build/installer_tests.log 2>&1
cat build/installer_tests.log
"$GODOT_BIN" --headless --path . --editor --quit > build/import.log 2>&1
python3 - <<'PY'
from pathlib import Path
text=Path('build/import.log').read_text()
errors=[line for line in text.splitlines() if line.startswith(('ERROR:', 'SCRIPT ERROR:'))]
# Editor TCP listeners cannot bind inside this sandbox. Classify only those exact
# infrastructure diagnostics; every other error (including script parse) fails.
allowed={
 'ERROR: Condition "_sock == -1" is true. Returning: FAILED',
 'ERROR: Condition "err != OK" is true. Returning: ERR_CANT_CREATE',
}
if any(error not in allowed for error in errors):
    print(text)
    raise SystemExit('FAIL: importação Godot; consulte build/import.log')
if errors:
    print('LIMITAÇÃO: listeners TCP do editor indisponíveis no sandbox; build/import.log preservado')
PY
"$GODOT_BIN" --headless --path . --script tests/test_suite.gd > build/tests.log 2>&1
cat build/tests.log
python3 - <<'PY'
from pathlib import Path
import re
text=Path('build/tests.log').read_text()
if 'ERROR:' in text or not re.search(r'M0\.1 checks=\d+ failures=0',text):
    raise SystemExit('FAIL: suíte headless; Godot pode sair com zero mesmo após erro de parse')
PY
"$GODOT_BIN" --headless --path . --script tests/test_input_pipeline.gd > build/input_pipeline.log 2>&1
cat build/input_pipeline.log
python3 - <<'PY'
from pathlib import Path
import re
text=Path('build/input_pipeline.log').read_text()
if 'ERROR:' in text or not re.search(r'M0\.1 input_pipeline checks=\d+ failures=0',text):
    raise SystemExit('FAIL: integração Input/GUI/gestos; consulte build/input_pipeline.log')
PY
"$GODOT_BIN" --headless --path . --quit-after 15 > build/smoke.log 2>&1
python3 - <<'PY'
from pathlib import Path
text=Path('build/smoke.log').read_text()
if 'ERROR:' in text:
    print(text)
    raise SystemExit('FAIL: inicialização da cena principal')
print('PASS: cena principal executou 15 frames headless sem erros')
PY
python3 tests/verify_runtime_export.py > build/runtime_export.log 2>&1
cat build/runtime_export.log
python3 scripts/check_documents.py
git diff --check
