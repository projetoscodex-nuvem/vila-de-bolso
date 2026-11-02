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

Atualização de 01/11/2026: o código abaixo agora inclui GAME_DESIGN.md nas diferenças esperadas. Os resultados e contagens das seções históricas de 31/10 foram preservados; para reproduzir aquele snapshot, usar o relatório do commit `03d177a020ff673c209017fc0e640998c30fc7e4`. Resultados desta revisão constam na seção de atendimento à revisão externa ao final.

```python
from pathlib import Path, PurePosixPath
import zipfile, hashlib, json, stat, re, subprocess
root = Path('/workspace/vila-de-bolso').resolve()
archive = root / 'Vila_de_Bolso_M0_v0_2.zip'
assert hashlib.sha256(archive.read_bytes()).hexdigest() == 'e5df94aeabd7eeca57dd844b1cface0108f929dc90ba41e6dd2c07f699755697'
reconciled = {'README.md', 'PROJECT_CONTEXT.md', 'PROJECT_STATE.md', 'HANDOFF.md', 'DECISIONS.md', 'CHANGELOG.md', 'ASSETS_AND_LICENSES.md', 'GITHUB_CODEX_CLOUD_SETUP.md', 'PACKAGING_REPORT.md', 'GAME_DESIGN.md'}
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
print(f'PASS: ZIP seguro; CRC; SHA-256; manifesto {len(manifest)}/{len(manifest)}; {len(names)} arquivos; {len(changed)} reconciliados; {len(names) - len(changed)} idênticos ao pacote')
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
review_base = '03d177a020ff673c209017fc0e640998c30fc7e4'
review_files = {'GAME_DESIGN.md', 'DECISIONS.md', 'PROJECT_STATE.md', 'HANDOFF.md', 'CHANGELOG.md', 'reports/IMPORT_V0_2_REPORT.md'}
review_changed = set(subprocess.check_output(['git','diff',review_base,'--name-only'],cwd=root,text=True).splitlines())
assert review_changed == review_files, review_changed
assert subprocess.check_output(['git','diff',review_base,'--','Vila_de_Bolso_M0_v0_2.zip','MANIFEST_SHA256.json','GAME_RULES.md','PACKAGE_VERSION.json','MAP_AND_CAMERA.md','references'],cwd=root) == b''
subprocess.run(['git','diff',review_base,'--check'],cwd=root,check=True)
print(f'PASS: revisão altera somente {len(review_changed)} Markdown autorizados; ZIP, manifesto, regras, parâmetros, câmera e referências preservados frente ao commit revisado')
```

### Resultados

PASS: SHA-256 do ZIP preservado; CRC de todas as entradas; caminhos relativos seguros; ausência de symlinks/tipos especiais e colisões de nomes; cobertura exata do manifesto e 27/27 hashes.

PASS: inventário de 28 arquivos extraídos; 19 idênticos ao ZIP, nove documentos reconciliados; quatro PNGs legacy e manifesto originais intactos; árvore final com 30 arquivos e 22 Markdown não vazios em UTF-8.

PASS: todos os links Markdown locais resolvem; parâmetros v0.2 consistentes em metadados e documentos operacionais; câmera/arrasto/zoom presentes; nenhuma especificação numérica antiga ativa; AGENTS.md abaixo de 32 KiB; nenhum projeto Godot, script de jogo ou APK adicionado; `git diff --check` sem erros nas alterações rastreadas.

NOT_RUN: engine, câmera/gestos em execução, gameplay, save real, exportação/instalação APK, Android físico, desempenho, balanceamento e diversão. Nenhum teste de jogo foi simulado ou inferido das verificações documentais.

## VALIDADO

Somente conteúdo documental, integridade e reconciliação nos limites acima. O snapshot inicialmente verificado da working tree foi gravado em `ebaa7abe53445e8a2b35a03cf4d1543a8eeb07ce`; o verificador foi repetido nesse commit com árvore limpa e todos os resultados PASS. Esta atualização posterior acrescenta evidência real de commit/push/draft PR, sem mudar especificações ou iniciar implementação. A verificação do commit final é registrada também no draft PR.

## PENDÊNCIA

Revisão e aceite do proprietário sobre esta importação. Visibilidade pública registrada como divergência factual preservada; licença autoral segue indefinida. Ferramentas, câmera funcional, APK e teste físico pertencem à futura tarefa M0.1; não foram iniciados.

## PRÓXIMO PASSO

Revisar diff/draft PR, README.md, PROJECT_CONTEXT.md, MAP_AND_CAMERA.md e este relatório, sem executar o prompt de implementação. Após revisão, enviar PROMPT_M0_1_CODEX.md v0.2 em nova tarefa explicitamente autorizada. Não é necessário testar jogo nesta entrega documental.

## Registro de entrega

CONFIRMADO: commit documental `ebaa7abe53445e8a2b35a03cf4d1543a8eeb07ce`, criado e verificado com árvore limpa; push da branch `docs/importacao-v0-2` concluído e SHA conferido por `git ls-remote`. A `main` permaneceu em `f1b59a2ab0f148abc71f0caf91a102a79e122cee`.

CONFIRMADO: [draft PR #1](https://github.com/projetoscodex-nuvem/vila-de-bolso/pull/1), criado em 31/10/2026, aberto, draft=true e merged=false, base main e head docs/importacao-v0-2. Fontes/documentos/referências estão salvos no GitHub nessa branch; não foram integrados à main. Esta atualização de evidência é um commit documental posterior; a cabeça final pode ser consultada no PR. O verificador temporário também está transcrito integralmente neste relatório, sem depender da persistência de /tmp.

Comandos de gravação e confirmação efetivamente usados:

```bash
git diff --cached --check
git commit -m "docs: importar e reconciliar baseline Vila de Bolso v0.2"
python /tmp/vila_verify_import.py
git status --short --branch
git rev-parse HEAD
git push -u origin docs/importacao-v0-2
git ls-remote origin refs/heads/docs/importacao-v0-2 refs/heads/main
```

O draft PR foi criado pela ferramenta GitHub, com base main e draft=true. Nenhum merge, publicação de jogo ou instalação de ferramentas foi realizado. O aceite humano desta importação continua pendente.


## Atendimento à revisão externa — 01/11/2026 (UTC)

### Escopo e base conferida

Solicitação do proprietário: somente ajustes documentais da revisão externa no PR #1, sem subagentes, instalação de Godot/SDK, escolha de regra nova ou início de M0.1. A conferência remota pela API GitHub confirmou PR aberto, draft e sem merge, branch docs/importacao-v0-2 e cabeça `03d177a020ff673c209017fc0e640998c30fc7e4`, igual ao último commit revisado. A base main continuava em `f1b59a2ab0f148abc71f0caf91a102a79e122cee`; nenhuma alteração posterior encontrada na conferência inicial.

O checkout local estava limpo em a20de55, com a mesma árvore `6bcf28ee297f091af82b094221b6440f0e2bcd8a` do commit remoto revisado. O commit remoto foi obtido pela API GitHub e importado no Git local com verificação do SHA do objeto; o ponteiro local da branch foi alinhado ao remoto mantendo o checkpoint `checkpoint/importacao-v0-2-local`. Nenhum conteúdo foi descartado. A sincronização desta revisão usa as ferramentas GitHub para leitura, criação de árvore/commit e avanço da branch, sem depender de uma sessão de Git HTTP que ficou interrompida durante a tentativa anterior.

### Ajustes atendidos

- GAME_DESIGN.md, “Reino persistente”: terrenos, geografia e encaixes serão definidos e validados nos templates; PNGs legacy_v0_1 orientam somente estilo/paleta, sem definir geografia, dimensões, câmera ou layout funcional.
- DECISIONS.md: D026 registrada como PENDING antes de implementar desfazer em M1/M2. Especificar a sequência “colocar → trocar oferta → desfazer”, incluindo oferta ativa, cursor e quota de trocas. Nenhuma solução foi escolhida ou implementada; GAME_RULES.md permanece intacto. D026 não bloqueia a fundação M0.1, que não foi iniciada.
- PROJECT_STATE.md, HANDOFF.md e CHANGELOG.md atualizados com os ajustes, limites e próximo passo.
- Este relatório preserva os resultados históricos e acrescenta esta seção. O verificador transcrito foi atualizado para incluir GAME_DESIGN.md entre os arquivos reconciliados e conferir os seis Markdown autorizados frente ao commit revisado.

Arquivos efetivamente alterados nesta revisão: GAME_DESIGN.md, DECISIONS.md, PROJECT_STATE.md, HANDOFF.md, CHANGELOG.md e reports/IMPORT_V0_2_REPORT.md. Nenhum arquivo novo ou removido.

### Proveniência e contagens

Os resultados de 31/10 acima continuam históricos: nove documentos reconciliados e 19 idênticos ao ZIP, com 37 links locais naquele snapshot. Nesta revisão, GAME_DESIGN.md passa a diferir do pacote por uma alteração solicitada explicitamente; os quatro outros arquivos alterados que pertencem ao ZIP já estavam reconciliados. O relatório é adicional ao pacote e não integra suas 28 entradas. Portanto, agora são dez arquivos reconciliados e 18 idênticos ao ZIP; o verificador compara o conjunto exato de caminhos e imprime as contagens medidas.

Não houve mudança nos totais de 28 arquivos do pacote, 30 arquivos de projeto, 22 Markdown ou 27 hashes do manifesto. ZIP e MANIFEST_SHA256.json originais preservados; o manifesto continua verificando o ZIP recebido, sem ser regenerado para os documentos reconciliados. Os quatro PNGs continuam idênticos ao pacote.

### Verificações desta revisão

Comandos executados em /workspace/vila-de-bolso para extrair o código transcrito do relatório e verificar a árvore atual:

```bash
python - <<'PYCODE'
from pathlib import Path
report = Path('reports/IMPORT_V0_2_REPORT.md').read_text()
code = report.split('```python\n', 1)[1].split('```', 1)[0]
Path('/tmp/vila_verify_import.py').write_text(code)
PYCODE
python /tmp/vila_verify_import.py
git diff 03d177a020ff673c209017fc0e640998c30fc7e4 --check
git diff --cached --check
git status --short --branch
```

Snapshot verificado: working tree da branch docs/importacao-v0-2 sobre `03d177a020ff673c209017fc0e640998c30fc7e4`, com os seis arquivos listados acima. O hash real do commit final e a confirmação de envio da mesma árvore verificada serão registrados na descrição do PR #1 após a gravação e releitura remota, sem antecipar hash neste relatório.

Resultados desta revisão, separados do histórico: PASS para segurança de caminhos/tipos, CRC, SHA-256 do ZIP, manifesto original 27/27, inventário exato, dez diferenças esperadas e 18 arquivos idênticos, integridade dos PNGs, 22 Markdown UTF-8 não vazios, 37 links locais medidos, parâmetros v0.2 e git diff --check. O verificador também confere que somente os seis Markdown autorizados diferem da base revisada e que ZIP, manifesto, GAME_RULES.md, PACKAGE_VERSION.json, MAP_AND_CAMERA.md e references permanecem intactos.

Parâmetros preservados: fase 20 × 20, reino 40 × 60, seis regiões 2 × 3, 60 colocações, 62 ofertas e navegação por arrasto/zoom nas duas visões. Nenhuma verificação documental comprova execução do jogo.

NOT_RUN: Godot/SDK, câmera ou gestos em execução, gameplay, comportamento do desfazer, save real, exportação/instalação APK, Android físico, desempenho e balanceamento. Não foram instaladas ferramentas nem iniciados M0.1/M1/M2.

### Pendência e próximo passo

Aguardar revisão/aceite destes ajustes no PR #1; não fazer merge automaticamente. Após revisão, o proprietário poderá enviar nova tarefa explícita de M0.1. Resolver D026 antes de implementar desfazer em M1/M2, sem tratar a pendência como bloqueio da fundação M0.1. A visibilidade pública e a licença autoral indefinida continuam registradas sem alteração nesta tarefa.
