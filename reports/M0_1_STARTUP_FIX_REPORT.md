# M0.1 — Correção do fechamento de dependências e inicialização

**Continuação local em03/11/2026 UTC:** novo APK real do fonte2858a75 gerado pelo desenvolvedor neste ambiente, com checkout limpo, gate de runtime, assinatura e manifesto PASS. [Relatório atual](M0_1_LOCAL_APK_2858A75_REPORT.md). Os BLOCKED/READY/FAIL abaixo pertencem aos snapshots/artefatos históricos descritos; novo Android físico NOT_RUN.

03/11/2026 (UTC). **PARCIAL/BLOCKED para novo APK; M0.1 não aprovado.** Branch feat/m0-1-foundation, PR #2 draft/sem merge. Cabeça inicial local/remota conferida em 0c4296ccec588b3699db3c78571a02d6e1b0572f, sem alteração posterior nesse momento. Sem subagentes, CI, release, M1 ou alteração de D026.

## Falha física e evidência externa

OWNER_REPORTED: instalou o APK fonte **60f2491f1a04001d4903d6e8d12c519df6bafd1b**, SHA-256 **fb7abe176c9d96eef0131a6a654e06e77ff645fce7dbd96e9a7029a9da0307d7**. Ao abrir, somente tela clara, sem menu: **inicialização visual FAIL**. Instalação relatada como realizada; demais testes físicos **NOT_RUN**. A screenshot foi mencionada pelo proprietário, mas não estava disponível para inspeção direta neste processo. [Registro do relato](evidence/M0_1_STARTUP_OWNER_FAIL.json).

EXTERNAL_REVIEW_REPORTED_BY_OWNER: revisão conferiu o hash do APK e encontrou main.gdc/remap, sem os quatro scripts core e presentation/map_view nem suas versões compiladas/remapeadas. O binário antigo não foi baixado nem reexaminado aqui. Os resultados históricos de exportação, assinatura, CRC e manifesto em [relatório Android](M0_1_ANDROID_BUILD_REPORT.md) e suas evidências foram preservados; eles não demonstravam carregamento das dependências ou menu.

## Causa demonstrada e limite do diagnóstico

CONFIRMADO neste processo: Godot **4.6.3.stable.official.7d41c59c4**, usando o preset Android com export_filter=scenes e somente res://scenes/main.tscn, gera um ZIP real de recursos com presentation/main.gdc/remap e a cena binária/remap, mas sem os cinco scripts que main.gd carrega por preload. Isso foi reproduzido em cópia temporária do projeto; não depende de fabricar uma lista de arquivos. Carregar esse pacote em bootstrap sem core/presentation/scenes/data locais produz erros de preload e reprovação do teste. [Log anterior](evidence/M0_1_STARTUP_BEFORE.txt).

A configuração anterior não fechava as dependências de runtime desta cena nessa versão da engine. A relação dessa omissão com a tela clara no Android é **HIPÓTESE forte**, compatível com o erro reproduzido. Sem logcat, execução Android local ou novo teste físico, não declarar diagnóstico completo nem correção física confirmada. Não houve troca de engine, renderer ou regra de gameplay.

## Correção

- export_presets.cfg: export_filter=resources, com lista explícita da cena inicial, seus seis scripts (main, map_view e quatro core) e ícone. JSON/licença continuam no include_filter; exclusões anteriores mantidas e acrescidas de .git, .env, keystores e export_credentials.cfg. Gradle desativado, SDKs herdados, ETC2/ASTC ativo e lock 24/36 inalterados.
- scripts/check_runtime_pack.py + .gd: executam a Godot em diretório temporário, com bootstrap/driver de teste e perfil XDG próprios. Nenhum recurso de runtime da pasta-fonte é copiado. Godot abre PCK/ZIP por --main-pack, lê project.binary do artefato, exige a configuração da cena inicial e resolve .remap, .scn e .gdc. Para APK, somente os bytes de assets/ são reempacotados em ZIP, sem buscar arquivos faltantes no projeto; paths inválidos/duplicados são rejeitados. O driver verifica scripts carregáveis/instanciáveis, alvos remapeados, dados/licença, diretórios excluídos, instancia a cena, aguarda cinco frames e exige estado menu e três botões visíveis com área dentro do viewport.
- scripts/export_android.py: gate runtime_validation antes da assinatura e de PASS/hash, com log e código de saída próprios. Falha/timeout/marcador ausente finalizam o resultado da tentativa, arquivam o artefato como não verificado e não preservam PASS antigo. Testes do wrapper são fixtures isoladas, nunca assinaturas/APKs reais.
- scripts/check_documents.py e testes: seleção explícita protegida. scripts/verify.sh agora inclui a regressão de exportação/runtime, além dos checks existentes.

## Testes executados

Comandos na raiz, GODOT_BIN selecionado pelo scripts/env.sh:

```bash
source scripts/env.sh
python3 scripts/diagnose_network.py
python3 -m unittest discover -s tests -p 'test_*.py' -v
python3 tests/verify_runtime_export.py
scripts/verify.sh
python3 -m py_compile scripts/check_runtime_pack.py scripts/export_android.py scripts/check_documents.py tests/verify_runtime_export.py tests/test_export_android.py tests/test_android_configuration.py
bash -n scripts/verify.sh scripts/export_android.sh
git diff --check
```

| Camada | Resultado realmente observado |
| --- | --- |
| Projeto/ferramentas | PASS: 40 testes Python (7 setup, 21 wrapper de exportação simulado, 12 configuração), 163 checks Godot, 44 Input sintéticos, smoke de 15 frames |
| Pacote exportado real | PASS: ZIP e PCK gerados pela Godot pelo preset Android, carregados fora da fonte; cena/menu presentes e visíveis na árvore UI headless |
| Regressão anterior real | PASS do detector: export com filtro scenes anterior falha por dependências ausentes; fonte local não oculta omissões |
| Fixtures de pacote | PASS do detector: cinco omissões de scripts, alvo compilado ausente, bytecode corrompido, cena/dados/configuração exportada ausentes e inclusão de tests são rejeitados; wrapper com formato APK e assets reais carrega. Wrapper e mutações são SIMULAÇÃO, sem APK Android nativo |
| Obrigatórios | PASS: proveniência com 27 hashes, ZIP/manifesto/PNGs/relatório histórico, links/parâmetros v0.2 e diff |
| Android | APK antigo: inicialização visual FAIL relatado pelo proprietário. Novo APK/exportação/assinatura/manifesto/hash: BLOCKED neste processo. Outros testes físicos NOT_RUN |

Total da regressão de pacote: **15 casos, zero falhas do detector**. [Resumo e inventário](evidence/M0_1_STARTUP_PACK_RESULTS.json), [ZIP](evidence/M0_1_STARTUP_AFTER_ZIP.txt), [PCK](evidence/M0_1_STARTUP_AFTER_PCK.txt), [verificação agregada](evidence/M0_1_STARTUP_VERIFY.txt). Os hashes do resumo são dos pacotes ZIP/PCK de recursos, **não hashes de APK**. Exportações temporárias podem gerar identificadores internos diferentes; não tratá-las como build byte a byte reproduzível do APK.

O teste headless verifica a cena/UI carregada e layout visível, não pixels renderizados, driver GPU, processo Android, toque físico ou desempenho. Os dois diagnósticos específicos de listeners TCP do editor continuam classificados como limitação do sandbox; logs integrais de import/export ficam em build/runtime_export/. Outros erros causam FAIL, mesmo com exit zero.

## Bloqueio local e instruções ao executor de exportação

[Novo diagnóstico local](evidence/M0_1_STARTUP_NETWORK_LOCAL.json): socket AF_INET retorna EPERM antes de proxy/DNS/TLS. JDK, SDK/apksigner e templates Android do lock continuam ausentes nos caminhos .tools esperados. Nenhum download/instalação inviável foi repetido; **nenhum novo APK foi produzido**. Acesso do conector GitHub é independente da rede do processo. O histórico do build externo permanece válido para o artefato antigo, agora reprovado em inicialização pelo proprietário.

No executor que já exportou, preservar a chave debug e alterações locais. Atualizar a mesma branch por fast-forward e conferir o SHA final informado no PR; só exportar com checkout limpo nesse SHA. Não usar o APK antigo como resultado novo. Com as ferramentas/cache fixados disponíveis:

```bash
git fetch origin feat/m0-1-foundation
git switch feat/m0-1-foundation
git merge --ff-only origin/feat/m0-1-foundation
git rev-parse HEAD
git status --porcelain
scripts/setup.sh --android
scripts/verify.sh
scripts/export_android.sh
source scripts/env.sh
python3 scripts/check_runtime_pack.py build/vila-de-bolso-m0.1-debug.apk
"$ANDROID_SDK_ROOT/build-tools/36.1.0/apksigner" verify --verbose --print-certs build/vila-de-bolso-m0.1-debug.apk
"$ANDROID_SDK_ROOT/build-tools/36.1.0/aapt" dump badging build/vila-de-bolso-m0.1-debug.apk
sha256sum build/vila-de-bolso-m0.1-debug.apk
```

Interromper se SHA divergir, checkout estiver sujo ou alguma verificação falhar. Conferir minSdk 24/targetSdk 36 e ausência de permissões de rede no manifesto; registrar assinatura, conteúdo/runtime, bytes, SHA-256, attempt_id e commit fonte reais. O wrapper já exige CRC, manifesto/dados, dependências/menu isolados e assinatura antes do PASS. Entregar APK/hash por artefato privado da tarefa/conversa, sem Git/release/CI. Não apagar dados do aparelho diante de incompatibilidade de assinatura: preservar a chave anterior ou informar o problema antes de reinstalar.

## Continuidade

Snapshot inicial destes resultados: working tree sobre 0c4296c. O commit exato é materializado e os checks repetidos antes de publicar; seu SHA/árvore/cabeça remota e o resultado pós-commit ficam na descrição do PR #2 e na resposta final, sem inventar hash autorreferente neste arquivo. A evidência agregada versionada corresponde à mesma implementação anterior à gravação do commit.

Depois do novo APK: proprietário abre offline e confirma menu, com modelo/Android; se falhar, coletar logcat do lançamento e anexar origem/hash do APK. Somente após menu visível, continuar Explorar/Entrar/Retomar, gestos/HUD e fechar/reabrir. Esta tarefa não aprova M0.1, não inicia M1 e não resolve D026.
