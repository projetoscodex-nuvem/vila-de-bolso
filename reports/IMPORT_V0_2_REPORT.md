# Relatório de importação/reconciliação v0.2

Data: 31/10/2026 (UTC). Escopo: somente documentação. **M0.1 NÃO INICIADO**.

## DECISÃO

Importar somente Vila_de_Bolso_M0_v0_2.zip, sem executar conteúdo do pacote ou instalar ferramentas de jogo. Manter Android offline em retrato, fase 20 × 20, reino 40 × 60, 60 colocações, 62 ofertas e câmera navegável nas duas visões. Requisito de mapas grandes confirmado; números finais e equilíbrio dependem de testes futuros.

## IMPLEMENTAÇÃO

- Repositório confirmado pela API GitHub: https://github.com/projetoscodex-nuvem/vila-de-bolso; branch padrão main; visibilidade pública; acesso de escrita disponível.
- Base local work e HEAD remoto main: `f1b59a2ab0f148abc71f0caf91a102a79e122cee`. Árvore inicial limpa; somente README.md, PROJECT_CONTEXT.md e ZIP v0.2 rastreados.
- Branch desta tarefa: `docs/importacao-v0-2`. Entrega sem merge automático.
- ZIP SHA-256: `e5df94aeabd7eeca57dd844b1cface0108f929dc90ba41e6dd2c07f699755697`. 28 entradas regulares, 7.739.603 bytes descomprimidos; manifesto cobre exatamente 27 arquivos, excluindo a si próprio.
- AGENTS.md lido antes da extração. Todos os documentos/referências foram lidos ou inventariados sem executar código do pacote. Extração seletiva do ZIP v0.2 para a raiz, sem pasta pai intermediária, mantendo references/legacy_v0_1.
- README.md e PROJECT_CONTEXT.md existentes comparados em diff com v0.2 antes de substituição. Mesmo projeto e mesma origem/identidade; nenhuma alteração exclusiva do proprietário foi identificada. Substituídos parâmetros v0.1 superados e preservado histórico Git. Nenhum alias Project.md/VILA_DE_BOLSO_PROJECT_CONTEXT.md ou documento de outro projeto encontrado; PROJECT_CONTEXT.md é canônico.
- Reconciliados nove arquivos em relação ao ZIP: README.md, PROJECT_CONTEXT.md, PROJECT_STATE.md, HANDOFF.md, DECISIONS.md, CHANGELOG.md, ASSETS_AND_LICENSES.md, GITHUB_CODEX_CLOUD_SETUP.md e PACKAGING_REPORT.md. Os outros 19 arquivos importados permanecem byte a byte iguais ao pacote.
- Acrescentado este relatório. Total final esperado: 30 arquivos de projeto rastreados, incluindo ZIP preservado; 22 Markdown.

### Arquivos alterados nesta entrega

Modificados em relação à base Git: README.md e PROJECT_CONTEXT.md.

Adicionados na raiz: .gitignore, AGENTS.md, ARCHITECTURE.md, ASSETS_AND_LICENSES.md, CHANGELOG.md, DECISIONS.md, GAME_DESIGN.md, GAME_RULES.md, GITHUB_CODEX_CLOUD_SETUP.md, HANDOFF.md, MANIFEST_SHA256.json, MAP_AND_CAMERA.md, PACKAGE_VERSION.json, PACKAGING_REPORT.md, PROJECT_STATE.md, PROMPT_CONTINUIDADE.md, PROMPT_IMPORTACAO_CODEX.md, PROMPT_M0_1_CODEX.md, ROADMAP.md, SOURCES.md e TEST_PLAN.md.

Adicionados em subpastas: references/README.md, references/legacy_v0_1/01_fase_android.png, references/legacy_v0_1/02_reino_vazio.png, references/legacy_v0_1/03_reino_parcial.png, references/legacy_v0_1/04_reino_completo.png e reports/IMPORT_V0_2_REPORT.md. Total: 29 caminhos alterados, sendo 2 modificados e 27 adicionados. ZIP existente sem alteração.

### Divergências e proveniência preservadas

1. O pacote previa repositório privado, mas GitHub confirmou público em 31/10/2026. Documentação registra o fato; configuração e licença autoral não foram alteradas. A recomendação Private no guia permanece para criação de um novo repositório.
2. Afirmações de repositório/branch não auditados foram atualizadas nos documentos operacionais com evidências desta tarefa; PACKAGING_REPORT.md preserva os resultados históricos de 29/10, identificados como tais.
3. ASSETS_AND_LICENSES.md dizia que mockups orientavam layout; reconciliado para somente estilo/paleta, conforme MAP_AND_CAMERA.md. Quatro PNGs mantidos sem alteração e sem atribuição indevida de CC0.
4. ZIP e MANIFEST_SHA256.json originais preservados como proveniência. O manifesto verifica o conteúdo original do ZIP; diferenças nos nove documentos reconciliados são esperadas e listadas acima. Não regenerar o manifesto para ocultar essa diferença. Após extração, a leitura canônica é a documentação atual da branch.

Nenhum conflito indispensável ficou sem solução por falta de evidência. Aceite da importação e revisão da entrega seguem pendentes.

## TESTE

Ambiente confirmado: Linux 6.18.57 x86_64, Git 2.52.0, Python 3.12.14. Rede restrita via proxy do ambiente. A primeira leitura remota no sandbox retornou falha de conexão ao proxy; repetida com permissão de rede do sandbox, sem trocar identidade, e concluída com sucesso. Não houve instalação de engine/SDK nem mudança de política de rede do ambiente.

Comandos executados na raiz do repositório:

```bash
git status --short --branch
git remote -v
git log -6 --oneline
git ls-files
git ls-remote --symref origin HEAD refs/heads/main
git rev-parse HEAD
git show --format=fuller --no-patch HEAD
python --version
git --version
uname -srm
git switch -c docs/importacao-v0-2
python /tmp/vila_verify_import.py
git diff --check
```

A comparação prévia utilizou `difflib.unified_diff` entre cada arquivo existente e `ZipFile.read` de README.md/PROJECT_CONTEXT.md. Extração utilizou Python/zipfile, validando caminhos absolutos, traversal, caminhos Windows, tipos/symlinks e destinos reais antes de escrever; não foi usado extractall nem executado conteúdo do pacote. O verificador independente abaixo permite reproduzir as verificações finais; salvar como /tmp/vila_verify_import.py e ajustar apenas root se o checkout estiver em outro local.

### Verificador documental executado

```python
from pathlib import Path, PurePosixPath
import zipfile, hashlib, json, stat, re, subprocess
root = Path('/workspace/vila-de-bolso').resolve()
archive = root / 'Vila_de_Bolso_M0_v0_2.zip'
assert hashlib.sha256(archive.read_bytes()).hexdigest() == 'e5df94aeabd7eeca57dd844b1cface0108f929dc90ba41e6dd2c07f699755697'
reconciled = {'README.md', 'PROJECT_CONTEXT.md', 'PROJECT_STATE.md', 'HANDOFF.md', 'DECISIONS.md', 'CHANGELOG.md', 'ASSETS_AND_LICENSES.md', 'GITHUB_CODEX_CLOUD_SETUP.md', 'PACKAGING_REPORT.md'}
with zipfile.ZipFile(archive) as z:
    names = z.namelist()
    assert len(names) == len(set(n.casefold() for n in names)) == 28
    assert sum(i.file_size for i in z.infolist()) == 7739603
    for i in z.infolist():
        p = PurePosixPath(i.filename)
        assert not p.is_absolute() and '..' not in p.parts and '\\' not in i.filename and ':' not in i.filename
        assert not any(x in ('.git', '.aws', '.codex', '.agents') for x in p.parts)
        assert stat.S_IFMT(i.external_attr >> 16) in (0, stat.S_IFREG)
        target = root.joinpath(*p.parts)
        assert target.resolve().is_relative_to(root)
        assert not any(x.is_symlink() for x in (target, *target.parents))
    assert z.testzip() is None
    manifest = json.loads(z.read('MANIFEST_SHA256.json'))
    assert len(manifest) == 27 and set(manifest) == set(names) - {'MANIFEST_SHA256.json'}
    assert all(hashlib.sha256(z.read(n)).hexdigest() == h for n, h in manifest.items())
    assert all((root / n).is_file() for n in names)
    changed = {n for n in names if (root / n).read_bytes() != z.read(n)}
    assert changed == reconciled, changed
    assert all((root / n).read_bytes() == z.read(n) for n in names if n.startswith('references/'))
    assert (root / 'MANIFEST_SHA256.json').read_bytes() == z.read('MANIFEST_SHA256.json')
print('PASS: ZIP seguro; CRC; SHA-256; manifesto 27/27; 28 arquivos; 9 reconciliados; 19 idênticos ao pacote')
actual = {str(p.relative_to(root)) for p in root.rglob('*') if p.is_file() and '.git' not in p.relative_to(root).parts}
assert actual == set(names) | {'Vila_de_Bolso_M0_v0_2.zip', 'reports/IMPORT_V0_2_REPORT.md'}, actual
mds = sorted(root.rglob('*.md'))
assert len(mds) == 22
links = 0
for p in mds:
    content = p.read_text(encoding='utf-8')
    assert content.strip(), p
    assert not re.search(r'\b7\s*[×xX]\s*7\b|\b30\s+colocações\b|\b32\s+ofertas\b', content), p
    for raw in re.findall(r'!?\[[^\]]*\]\(([^)]+)\)', content):
        dest = raw.strip().split('#')[0]
        if not dest or re.match(r'[a-zA-Z][a-zA-Z0-9+.-]*:', dest):
            continue
        target = (p.parent / dest).resolve()
        assert target.is_relative_to(root) and target.exists(), (p, dest)
        links += 1
print(f'PASS: inventário exato de 30 arquivos; 22 Markdown UTF-8; {links} links locais; nenhum parâmetro antigo ativo')
meta = json.loads((root / 'PACKAGE_VERSION.json').read_text())
p = meta['prototype_parameters']
assert meta['document_version'] == '0.2' and meta['runtime_test_status'] == 'NOT_RUN'
assert (p['phase_width'],p['phase_height'],p['kingdom_width'],p['kingdom_height'],p['placements'],p['offers']) == (20,20,40,60,60,62)
assert p['phase_width'] * p['region_columns'] == p['kingdom_width']
assert p['phase_height'] * p['region_rows'] == p['kingdom_height']
assert p['placements'] + p['rerolls'] == p['offers']
for n in ('README.md','PROJECT_CONTEXT.md','MAP_AND_CAMERA.md','ARCHITECTURE.md','GAME_RULES.md','GAME_DESIGN.md','ROADMAP.md','TEST_PLAN.md','PROMPT_M0_1_CODEX.md','PROJECT_STATE.md','HANDOFF.md'):
    content = (root / n).read_text()
    assert '20 × 20' in content, n
    assert '40 × 60' in content or (n == 'GAME_RULES.md' and 'MAP_AND_CAMERA.md' in content), n
    assert ('zoom' in content.lower() or 'pinça' in content.lower()) and ('arrast' in content.lower() or 'pan' in content.lower()), n
assert (root / 'AGENTS.md').stat().st_size < 32768
assert not any(n.endswith(('.gd','.tscn','.apk','.aab')) or n == 'project.godot' for n in actual)
subprocess.run(['git','diff','--check'],cwd=root,check=True)
subprocess.run(['git','diff','--cached','--check'],cwd=root,check=True)
print('PASS: parâmetros v0.2 e câmera coerentes; referências legacy intactas; AGENTS < 32 KiB; sem projeto/gameplay/APK; git diff --check')
```

### Resultados

PASS: SHA-256 do ZIP preservado; CRC de todas as entradas; caminhos relativos seguros; ausência de symlinks/tipos especiais e colisões de nomes; cobertura exata do manifesto e 27/27 hashes.

PASS: inventário de 28 arquivos extraídos; 19 idênticos ao ZIP, nove documentos reconciliados; quatro PNGs legacy e manifesto originais intactos; árvore final com 30 arquivos e 22 Markdown não vazios em UTF-8.

PASS: todos os links Markdown locais resolvem; parâmetros v0.2 consistentes em metadados e documentos operacionais; câmera/arrasto/zoom presentes; nenhuma especificação numérica antiga ativa; AGENTS.md abaixo de 32 KiB; nenhum projeto Godot, script de jogo ou APK adicionado; `git diff --check` sem erros nas alterações rastreadas.

NOT_RUN: engine, câmera/gestos em execução, gameplay, save real, exportação/instalação APK, Android físico, desempenho, balanceamento e diversão. Nenhum teste de jogo foi simulado ou inferido das verificações documentais.

## VALIDADO

Somente conteúdo documental, integridade e reconciliação nos limites acima. Snapshot inicialmente verificado: working tree desta branch com os 29 caminhos listados. O registro de entrega abaixo será conciliado com commit real e confirmação remota antes da conclusão; hashes não são antecipados.

## PENDÊNCIA

Revisão e aceite do proprietário sobre esta importação. Visibilidade pública registrada como divergência factual preservada; licença autoral segue indefinida. Ferramentas, câmera funcional, APK e teste físico pertencem à futura tarefa M0.1; não foram iniciados.

## PRÓXIMO PASSO

Revisar diff/draft PR, README.md, PROJECT_CONTEXT.md, MAP_AND_CAMERA.md e este relatório, sem executar o prompt de implementação. Após revisão, enviar PROMPT_M0_1_CODEX.md v0.2 em nova tarefa explicitamente autorizada. Não é necessário testar jogo nesta entrega documental.

## Registro de entrega

Preparação local em `docs/importacao-v0-2`. Confirmação de commit e salvamento remoto serão registradas após a execução real, sem afirmar publicação antecipada.
