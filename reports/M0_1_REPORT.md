# M0.1 — Fundação, câmera e tentativa Android

Registro histórico das primeiras tentativas de 02/11/2026 (UTC), então PARCIAL/BLOCKED. O estado atual passou a READY_FOR_OWNER_SMOKE; consulte [relatório de build Android](M0_1_ANDROID_BUILD_REPORT.md). As evidências anteriores abaixo foram preservadas, sem converter resultados históricos em sucesso retroativo.

Atualização após revisão de `653e9cd`: as seções iniciais registram a entrega original. Seus 157 checks de componentes/cena não cobriam acessibilidade da GUI pelo fluxo Input da Godot. A falha de toque e o risco de resultado de exportação antigo foram tratados na seção “Correções da revisão independente” ao final, com novas evidências. Os resultados históricos não foram convertidos em teste físico.

## DECISÃO

Executar integralmente o escopo M0.1 de PROMPT_M0_1_CODEX.md após a integração documental autorizada. Sem subagentes, backend, conta, internet no jogo, monetização, telemetria, gameplay completo, release ou publicação.

### Integração e base Git

- PR #1: https://github.com/projetoscodex-nuvem/vila-de-bolso/pull/1. Cabeça conferida exatamente em `0733005bb2b83639522596ce63526003fb23cca8`, sem alterações posteriores ao commit aceito pelo proprietário. AGENTS.md dessa branch lido antes da integração.
- Draft retirado e merge normal realizado pela API GitHub com expected_head_sha igual ao commit aprovado e merge_method=merge, preservando os commits. Sem force, rebase/squash ou contorno de bloqueio.
- Merge e main resultante confirmados: **2d80844b8bc4a147bf428ade00448b5f6d2f02ba**. Objeto de merge assinado importado no Git local a partir da API, reconstruído com payload/assinatura e SHA conferido; árvore documental idêntica à aprovada.
- Branch de implementação: **feat/m0-1-foundation**, criada a partir dessa main. Nenhuma implementação diretamente na main. Novo draft PR deve permanecer sem merge.
- Snapshot deste relatório: working tree dessa branch, com os arquivos descritos abaixo. Após gravar a mesma árvore e repetir as verificações no commit real, o SHA e o link do novo draft PR são registrados na resposta final e na descrição do PR, sem inventar o hash do próprio commit no arquivo.

### Ferramentas e fontes oficiais

Godot observada e executada: **4.6.3.stable.official.7d41c59c4**, binário pré-instalado em /opt/godot/4.6.3/Godot_v4.6.3-stable_linux.x86_64. SHA-256 observado do binário: `f64d4ed19fc9df9440321653fcc80df8c6e365ba7b6de0a29e2cfa9fa71bfeb3`. Esse hash é medido no binário local, separado dos hashes oficiais de arquivos de download.

[Release oficial 4.6.3](https://github.com/godotengine/godot-builds/releases/tag/4.6.3-stable) consultada pela API GitHub; URLs, tamanhos e SHA-256 oficiais fixados em [scripts/toolchain.lock.json](../scripts/toolchain.lock.json): ZIP Linux x86_64 `d0bc2113065e481c9c2c2b2c37daa4e8be3fe9e27f0ab9ab0b6096e9a37907f3`, templates da mesma release `3fbe2c0e2dec9d537ab9ec97bcf8da91dcf23357fc51f67092dd068d839290a8`. Não foi alegado que esses arquivos foram baixados nesta tarefa.

[Documentação Android Godot 4.6](https://docs.godotengine.org/en/4.6/tutorials/export/exporting_for_android.html) recomenda JDK 17 e aceita versões superiores; sua lista geral de SDK cita 35. O [source exato da release 4.6.3](https://github.com/godotengine/godot/blob/4.6.3-stable/platform/android/java/app/config.gradle) e o [exportador da mesma release](https://github.com/godotengine/godot/blob/4.6.3-stable/platform/android/export/export_plugin.cpp) fixam minSdk 24, target/compile SDK 36 e Build-Tools 36.1.0. Foram usados esses valores da release na configuração, registrando a divergência da página geral em vez de adivinhar versões.

Toolchain Android escolhida no lock, **ainda não instalada/validada nesta tarefa**: [Temurin JDK 21.0.9+10](https://github.com/adoptium/temurin21-binaries/releases/tag/jdk-21.0.9%2B10), [command-line tools Linux 15859902](https://developer.android.com/studio#command-tools) com SHA-256 oficial, [Platform-Tools 37.0.1](https://developer.android.com/tools/releases/platform-tools), Platform 36/Build-Tools 36.1.0. JDK 21 é compatível com a orientação de aceitar versões superiores; não confundir o JRE 21.0.12.1 do host, sem javac, com o JDK completo do lock. Exportação padrão usando o APK pré-compilado, sem Gradle/custom Java; não foram instalados NDK/CMake/Android Studio/emulador.

## IMPLEMENTAÇÃO

### Projeto e fluxo

- project.godot e scenes/main.tscn: Android retrato, viewport lógico 720 × 1280, GDScript e Compatibility.
- core/world_data.gd e data/world.json: seis IDs/posições estáveis, reino 40 × 60, fase 20 × 20, primeira região liberada e demais bloqueadas. Templates/terreno geométricos provisórios para navegação; não são terrenos finais balanceados nem geografia derivada dos PNGs. Parâmetros futuros 60 colocações/62 ofertas preservados em dados, sem turno, oferta ou progressão de partida.
- core/map_camera.gd: posição/zoom, transformações tela/mundo/célula, recorte inicial estritamente menor que o mapa nos dois eixos, foco de pinça, limites, recentrar e visão geral. Usa transformação explícita equivalente a câmera 2D no Control do mapa; não transforma a HUD.
- core/gesture_router.gd: tap somente ao soltar, limiar configurável em unidades lógicas, pan/pinch/cancelamento e dedos extras; após pinça, o dedo remanescente não pode virar tap. Não há colocação. Limiar inicial 18 é parâmetro de protótipo, sem alegar calibração física universal.
- presentation/main.gd e presentation/map_view.gd: menu → reino → seleção explícita da Planície → Entrar → fase1 → voltar. Arrasto com um dedo, pinça, botões +/−, recentrar/visão geral; mouse/roda para desenvolvimento. Contatos iniciados na HUD não entram na câmera. Seleção invalidada ao navegar/cancelar/pausar/trocar visão. Botão Voltar do Android tratado. Demais regiões permanecem bloqueadas mesmo por chamada programática.
- core/save_store.gd: envelope mínimo JSON com schema_version/app_version/active_view/cameras, temporário, backup do último primário válido, renomeação controlada e proteção contra sobrescrita de save corrompido/desconhecido. Câmeras restauradas/clampadas por visão; dados inválidos de câmera recentram sem apagar progresso. Dedos e seleção nunca são salvos. Não há save de campanha implementado nem promessa de atomicidade entre vários arquivos.

### Ferramentas e arte

[scripts/README.md](../scripts/README.md) explica setup, verificação, exportação, logs e integração futura no setup do ambiente. Setup Linux x86_64 fixa versões e verifica hashes dos downloads oficiais; mantém proxy/CA e não altera HOME. Uma divergência de Platform-Tools é detectada antes de instalar/atualizar esse pacote; ferramentas já corretas são reutilizadas. A parte Android de instalação não foi comprovada de ponta a ponta devido ao bloqueio.

export_presets.cfg usa APK padrão armv7/arm64, minSdk 24/targetSdk 36, package provisório org.projetoscodex.viladebolso.m01, sem permissões internet/rede/armazenamento externo. Exclui docs/ZIP/PNG histórico/testes/ferramentas da exportação. Keystore debug gerado apenas quando a toolchain existe, em .tools fora do Git; nenhuma chave/SDK/cache/APK foi comitada. Não há workflow CI automático ou consumo de runner/billing.

Ícone assets/icon.svg e desenhos geométricos provisórios próprios; nenhum pack Kenney, áudio ou fonte externa incorporado. SHA-256 do ícone: `7f95157bcb4b49a9e7e67e4253bc7ae12ce377c79350418a8c9253196b34c2ec`. O aviso MIT oficial está em [licenses/GODOT_LICENSE.txt](../licenses/GODOT_LICENSE.txt); Créditos apresenta também avisos de terceiros/fontes da engine em execução. A licença autoral do projeto continua indefinida. PNGs legacy_v0_1 são apenas estilo/paleta e permanecem fora do runtime/exportação.

## TESTE

### Ambiente e comandos

Linux 6.18.57 x86_64; Python 3.12.14; Git 2.52.0; Godot 4.6.3; 3 CPUs; MemTotal aproximadamente 10 GB e cerca de 7,94 GB livres em /workspace na preparação. Proxy e política do ambiente inspecionados sem expor credenciais. Não há aparelho Android ou emulador conectado.

Comandos na raiz:

```bash
scripts/setup.sh
scripts/setup.sh
python -m py_compile scripts/setup.py scripts/export_android.py scripts/check_documents.py
bash -n scripts/env.sh scripts/setup.sh scripts/verify.sh scripts/export_android.sh
scripts/verify.sh
scripts/setup.sh --android
scripts/export_android.sh
git diff --check
```

A verificação inclui Godot --headless --editor --quit, Godot --headless --script tests/test_suite.gd, execução da cena principal por 15 frames, scripts/check_documents.py e git diff --check. Os testes usam nomes de save próprios e removem somente seus arquivos; não restauram ou alteram progresso pessoal. O verificador exige marcador final e ausência de erros de script, pois Godot pode sair com zero após erro de parse.

### Resultados locais

| Caso | Resultado e limite |
| --- | --- |
| Godot fixada e setup base idempotente | PASS, duas execuções; nenhuma engine baixada porque a versão correta já estava disponível |
| Limites do instalador | PASS, sete testes Python sem rede: caminhos absolutos/traversal/symlink, extração seletiva, hash inválido e cache verificado |
| Importação de scripts/recursos | PASS sem erro de parse; editor emite erros específicos de listeners TCP do sandbox, classificados separadamente abaixo |
| Dados, IDs, desbloqueio e limites | PASS headless |
| Coordenadas, recorte, pan/zoom, foco, visão geral, clamp e restauração | PASS headless em diferentes viewports/escalas |
| Tap→pan→pinch, dedos extras, cancelamento, pausa e HUD | PASS sintético, sem inferir toque físico |
| Save, backup, temp interrompido, corrupção/schema desconhecido e I/O | PASS; originais inválidos preservados |
| Menu→reino→região1→voltar, seleção explícita, câmeras independentes e reabrir | PASS em cena real headless, incluindo entrada sintética e sinais de botões |
| Suíte final | **157 verificações, zero falhas** |
| Cena principal | PASS por 15 frames headless; sem erro de script, sem inspeção visual de renderização |
| Proveniência, links, parâmetros e diff | PASS: 27 hashes originais, 25 Markdown UTF-8 e 53 links locais; script M0.1 preserva proveniência sem aplicar a antiga restrição documental de inventário/ausência de código |
| Instalação SDK/JDK/templates | BLOCKED por download negado no sandbox |
| Exportação APK debug | BLOCKED, tentativa Godot concreta com exit 1; script retorna 2 e grava export_result.json |
| Android físico, legibilidade, áreas seguras, pinça real, offline, desempenho e diversão | NOT_RUN |

O editor tenta abrir listeners locais e o sandbox retorna os dois diagnósticos `Condition "_sock == -1" ... FAILED` e `Condition "err != OK" ... ERR_CANT_CREATE`, em net_socket_unix.cpp/tcp_server.cpp. São limitações dos serviços de editor, não erro de parsing da aplicação nem prova de que o jogo precisa de internet. Os logs preservam esses erros; o verificador aceita somente essas mensagens exatas, rejeitando qualquer outro ERROR/SCRIPT ERROR. A execução da suíte/cena sem o editor não apresentou esses erros.

### Exportação tentada e diagnóstico

O setup Android tentou baixar o JDK oficial com hash fixado e retornou `BLOCKED: <urlopen error [Errno 1] Operation not permitted>`. Antes, curl pelo proxy também retornou falha de conexão. A tentativa posterior do comando com permissão adicional de rede foi interrompida pelo usuário; nenhum log/arquivo demonstrou sua execução ou instalação. Não houve alegação de rejeição automática, mudança de proxy, desativação de TLS ou tentativa de contornar a política.

O exportador foi executado de fato, apesar das dependências faltantes, para produzir diagnóstico:

```bash
godot --headless --path /workspace/vila-de-bolso --export-debug 'Android Debug' /workspace/vila-de-bolso/build/vila-de-bolso-m0.1-debug.apk
```

Godot exit 1: templates android_debug.apk/android_release.apk não encontrados; Java SDK inválido/sem bin; Android SDK sem platform-tools/adb, build-tools e apksigner. O wrapper registra status BLOCKED e exit 2. Não existe APK nesta entrega e não há SHA-256 de APK a informar. Não foi produzido um binário substituto ou arquivo vazio com extensão APK.

[Evidência da suíte](evidence/M0_1_TESTS.txt), [testes do instalador](evidence/M0_1_INSTALLER_TESTS.txt), [diagnóstico da exportação](evidence/M0_1_EXPORT.txt), [resultado estruturado](evidence/M0_1_EXPORT_RESULT.json) e [tentativa de setup Android](evidence/M0_1_SETUP_ANDROID.txt) acompanham o código. Os logs integrais de trabalho em build/ permanecem locais/ignorados; os arquivos em reports/evidence são cópias textuais intencionais sem credenciais. Os testes do instalador usam respostas em memória e URL example.invalid; não constituem download oficial real ou prova de instalação Android.

## VALIDADO

Fundação e verificações locais descritas, sem gameplay completo ou validação Android. A importação/revisão documental anterior foi aceita explicitamente pelo proprietário e integrada; o aceite não se estende automaticamente a M0.1. ZIP, manifesto, PNGs e [relatório histórico de importação](IMPORT_V0_2_REPORT.md) foram preservados; o verificador antigo pertence ao snapshot documental.

O commit real da mesma árvore testada é identificado na descrição do draft PR após a gravação e verificação pós-commit. A entrega M0.1 permanece PARCIAL/BLOCKED até resolver a cadeia Android. Sem merge do novo PR, sem M1, sem publicação.

## PENDÊNCIA

1. Autorizar/disponibilizar rede no ambiente de execução para os downloads oficiais e repetir scripts/setup.sh --android; validar também essa instalação em ambiente novo após integrar o comando de setup e republicar.
2. Rodar scripts/export_android.sh, verificar assinatura/manifesto e disponibilizar o APK com SHA-256 real por artefato de tarefa ou outro fluxo aprovado; CI manual somente após conferir permissões/limites da conta. SDK, keystore e APK continuam fora do Git.
3. Proprietário informar modelo/Android e executar smoke físico. MinSdk 24 decorre da engine; não comprova suporte em todos os aparelhos Android 7+.
4. Validar margem/áreas seguras, tamanho de texto/botões, limiar de gesto, conforto e desempenho no aparelho. Não foram medidos FPS/memória de sessão/bateria; não há emulador nem screenshot de gameplay validada.
5. D026 continua pendente para antes de desfazer em M1/M2, sem regra nova. Dimensões/balanceamento finais, licença autoral e compatibilidade física permanecem sujeitos a evidência.

## PRÓXIMO PASSO

Revisar a implementação no novo draft PR e resolver exportação Android antes de tratar M0.1 como aprovado ou avançar a M1. A configuração provisória de build e o roteiro estão preparados; não iniciar novos marcos nesta tarefa.

### Roteiro do proprietário quando existir APK

1. Baixar o APK identificado no relatório/PR, conferir SHA-256 e instalar conforme as solicitações do Android. Informar modelo, versão Android e APK/hash. Se houver incompatibilidade de assinatura, avisar antes de desinstalar e perder dados; não usar chave de release nesta prova.
2. Abrir offline. Menu → Explorar reino. Arrastar nos dois eixos, pinçar e usar +/−, Recentrar e Visão geral; conferir terreno fora do recorte e HUD fixa. Tocar uma região bloqueada não deve abri-la.
3. Selecionar Planície e tocar Entrar. Repetir navegação e tocar célula fora do recorte inicial. Pan/pinça e toque na HUD não devem selecionar indevidamente; não existe construção neste marco.
4. Voltar ao reino e conferir sua câmera anterior. Retomar a fase, fechar/reabrir o app e usar Retomar exploração; conferir câmeras independentes e ausência de seleção/gesto pendente. Testar botão Voltar e interrupção durante gesto.
5. Relatar PASS/FAIL e passos de qualquer defeito, incluindo textos cortados/área de toque, pinça, saltos e perda de estado. Um APK instalado continua sem provar jogo completo ou diversão.


## Correções da revisão independente — 02/11/2026 (UTC)

### Base e escopo

Cabeça do PR #2 conferida em `653e9cdab5a5bce956e86b15f6cf734f0f8fceff`, igual ao commit revisado, sem alterações posteriores na conferência inicial. Continuação na branch feat/m0-1-foundation; sem merge, release, publicação, M1 ou resolução de D026. Versões/hashes do lock, 60 colocações/62 ofertas e dimensões 20 × 20 / 40 × 60 preservados.

### Entrada: reprodução e correção

O teste novo, executado antes da correção com a configuração anterior, reproduziu a falha: um ScreenTouch no botão Explorar reino via Input.parse_input_event deixou a visão no menu (três verificações, uma falha). Isso mostra a limitação dos testes antigos que chamavam app._input diretamente e emitiam sinais de botões. O [log de reprodução](evidence/M0_1_INPUT_BEFORE_FIX.txt) é histórico de falha, não um resultado atual.

Correção: project.godot habilita emulate_mouse_from_touch para a GUI; presentation/main.gd devolve somente InputEventMouse de DEVICE_ID_EMULATION ao fluxo da GUI, sem registrá-lo como contato do mapa. ScreenTouch/ScreenDrag continuam sendo a fonte dos gestos de dedos. Mouse físico device=0 continua no caminho de mouse. Não foi implementado um handler paralelo de clique para os botões.

A nova suíte tests/test_input_pipeline.gd injeta eventos pela fila Input e os deixa passar pelo roteamento real da engine. Não chama app._input nem emite pressed como substituto do toque. PASS em **44 verificações**, cobrindo Explorar reino, Entrar, Retomar inclusive após reabrir, +/−, Recentrar, Visão geral e Voltar; um dedo cria exatamente um contato e produz tap/pan, dois produzem pinça, HUD não produz pan/seleção e mouse físico seleciona/arrasta. [Evidência atual](evidence/M0_1_INPUT_AFTER_FIX.txt). São eventos sintéticos na Godot headless; o adaptador de toque e a experiência física Android continuam NOT_RUN.

Os 157 checks anteriores permanecem como componentes/cena e foram repetidos. scripts/verify.sh agora exige também o marcador de sucesso da suíte Input e rejeita seus erros, sem depender somente do código de saída da Godot.

### Exportação: resultado por tentativa

scripts/export_android.py agora é importável sem disparar exportação. A CLI cria um attempt_id único, arquiva o resultado anterior e grava RUNNING antes da validação das ferramentas/subprocessos. Um bloco finally grava o resultado final e o log mesmo para configuração/versão inválida, dependência ausente, erro de exportação, timeout, manifesto/dados/CRC inválidos, erro ou timeout de assinatura e interrupção. PASS, apk e sha256 atuais só são adicionados após conteúdo/assinatura válidos.

Histórico por tentativa em build/export_attempts/<attempt_id>/: previous_result.json, previous-export_android.log e previous-debug.apk identificam o resultado/log/artefato anteriores. Um arquivo novo que falhou ou ficou parcial é preservado como unverified-debug.apk e removido do caminho instalável atual. Os artefatos não são apagados nem reapresentados como sucesso da tentativa nova. Arquivos legados previous-debug.apk não são removidos. Resultado estruturado atual tem schema_version 2, horários, estágio, retorno do processo e retorno do wrapper.

PASS: **25 testes Python**, sendo sete do instalador e 18 novos de exportação. Os novos testes começam com resultado anterior PASS e artefato anterior, verificam RUNNING antes de qualquer ferramenta, falhas de dependência/exportação/timeout/manifesto/CRC/assinatura/versão/keystore, interrupção, preservação de histórico e sucesso somente após verificação. Todos usam raízes temporárias, ZIPs falsos e runner substituto; nenhuma dessas fixtures é um APK, uma assinatura Android real ou um download de ferramenta. [Evidência das fixtures](evidence/M0_1_EXPORT_FIXTURE_TESTS.txt).

### Rede do processo, setup e tentativa Android real

`python scripts/diagnose_network.py` registrou **BLOCKED_BEFORE_PROXY_DNS_TLS**: socket(AF_INET, SOCK_STREAM) retornou PermissionError/errno 1 (EPERM) antes de tentar DNS, conexão ao proxy, TLS ou autorização HTTP. Os hosts github.com, release-assets.githubusercontent.com e dl.google.com constam na configuração, com proxy configurado. Essa permissão declarativa e a conectividade observada do ambiente não concedem automaticamente rede ao processo sandbox. O acesso do conector GitHub é uma capacidade distinta e não foi usado como prova de download pelo Python/curl.

Nenhuma política foi editada, proxy removido, TLS desabilitado ou grant presumido. [Diagnóstico estruturado](evidence/M0_1_NETWORK_RETRY.json). Alterar acesso ao repositório GitHub não corrige uma negação de criação de socket. Uma liberação precisa alcançar o processo de execução pelo fluxo suportado do ambiente/sandbox, ou usar outro executor autorizado; não há evidência de que isso tenha ocorrido aqui.

Depois das correções, `scripts/setup.sh --android` foi executado novamente mantendo URLs/versões/hashes. O download oficial do JDK retornou `urlopen error [Errno 1] Operation not permitted`; [log atual do setup](evidence/M0_1_SETUP_RETRY.txt). `scripts/export_android.sh` também foi executado de fato, e Godot retornou 1 por JDK/SDK/templates ausentes. O wrapper retornou 2, gravou BLOCKED no estágio export, com attempt_id `20261102T203711007145Z-39e0d3db` e horários de início/fim; não herdou PASS ou hash anterior. [Resultado atual](evidence/M0_1_EXPORT_RETRY_RESULT.json) e [log atual](evidence/M0_1_EXPORT_RETRY.txt).

**Nenhum APK real foi produzido nesta retentativa; SHA-256 de APK indisponível.** A validação bem sucedida de uma fixture não muda esse resultado. Instalação e testes físicos seguem NOT_RUN.

### Alternativa concreta, sem execução não autorizada

[Receita CI manual e condições](ci/README.md), com YAML pronto para revisão em reports/ci/M0_1_ANDROID_MANUAL.yml. Está fora de .github/workflows e não foi ativada/dispatchada. Usa runner padrão ubuntu-24.04, timeout 30 minutos, concorrência única, contents:read, actions fixadas por SHA, código de um SHA revisado e retenção de três dias; não usa secrets, não faz push/merge/release e não sobe SDK/keystore/fixtures como APK. Só envia APK e checksum após exportação real com assinatura verificada; diagnóstico fica separado em caso de falha.

As referências das actions foram conferidas pela API oficial e o YAML foi parseado localmente, mas a execução CI é NOT_RUN. A tentativa de consultar actions/permissions pelo conector retornou INVALID_ARGUMENT porque o endpoint não é admitido por essa ferramenta; não foi um 403 do GitHub e não demonstra Actions desabilitado. Billing/quota/armazenamento não foram confirmados. O proprietário precisa verificar essas condições antes de marcar account_limits_verified e consumir recursos. Ativar workflow no branch padrão exige alteração de configuração separadamente aprovada; não foi feito merge do PR #2 para isso.

### Verificações e limites atuais

```bash
source scripts/env.sh
"$GODOT_BIN" --headless --path . --script tests/test_input_pipeline.gd
python -m unittest discover -s tests -p 'test_*.py' -v
python scripts/diagnose_network.py
scripts/setup.sh --android
scripts/export_android.sh
scripts/verify.sh
python -m py_compile scripts/export_android.py scripts/diagnose_network.py tests/test_export_android.py
git diff --check
```

PASS local: 157 checks de componentes/cena, 44 do fluxo Input/GUI, 25 testes Python, cena principal por 15 frames, sintaxe, proveniência/links/parâmetros e diff. Os diagnósticos específicos de listeners do editor continuam separados; nenhuma restrição do verificador antigo de árvore documental foi aplicada à implementação. D026, ZIP, manifesto, PNGs e relatório histórico de importação preservados.

A árvore desta correção é registrada inicialmente como working tree; o commit real testado pós-gravação e a confirmação da cabeça remota são conciliados na descrição do PR #2 e na resposta final, sem antecipar hash neste arquivo. Próximo passo: revisar as correções no mesmo draft PR e resolver rede/toolchain no executor autorizado, ou aprovar/configurar a alternativa manual após conferir permissões/limites. Não tratar M0.1 como aprovado nem iniciar M1. O roteiro físico acima só deve ser executado quando existir APK concreto com hash.
