# Memória de entrada — Vila de Bolso

Versão documental: 0.2. Data: 29/10/2026 (America/Sao_Paulo).

## Identidade e origem

Nome de trabalho adotado nesta baseline: **Vila de Bolso — Meu Reino**. Nome curto: Vila de Bolso. Sugestão de repositório: vila-de-bolso. Nome comercial e identificador definitivo da aplicação não foram pesquisados/registrados.

O proprietário pediu um jogo simples, intuitivo, interessante, realizável até o fim com Codex e assets gratuitos. A ideia escolhida é um puzzle de posicionamento 2D. Depois dos mockups, o proprietário definiu Android como alvo e gostou da progressão em que cada fase concluída incrementa o mesmo mapa.

## Direção consolidada

- Android como plataforma principal; retrato e toque desde o primeiro protótipo.
- Offline, um jogador, português do Brasil, sem conta, servidor, API de IA ou internet obrigatória.
- Reino de regiões fixas; a montagem local do jogador vira a imagem real daquela região no mapa.
- O reino não é uma imagem pronta revelada por progresso, nem um simulador de população/economia.
- Primeira campanha delimitada pela baseline: seis regiões, organização 2 colunas × 3 linhas.
- Requisito do proprietário: tanto o reino quanto a fase são mapas maiores que o viewport no zoom normal, navegáveis por arrasto com um dedo e pinça para zoom. HUD permanece fixa.
- Parâmetros iniciais v0.2: fase 20 × 20, reino composto 40 × 60; seis peças; 60 colocações; ofertas de três peças; duas trocas e um desfazer por partida. Dimensões e ritmo ainda serão testados, sem retornar silenciosamente ao mapa pequeno.
- Referência normativa de câmera/gestos: MAP_AND_CAMERA.md. Os conceitos anteriores de mapa todo enquadrado são LEGADO_VISUAL, não o layout atual.
- Pontuação por quatro vizinhos ortogonais. Metas e valores iniciais precisam de balanceamento.
- Arte pequena e legível, inspirada em Kenney Tiny Town; conceitos gerados não são sprites prontos ou licença CC0 dos packs.
- Fluxo: planejamento/revisão no ChatGPT; engenharia no Codex Cloud; testes e aceite pelo proprietário no Android.

O proprietário autorizou iniciar o projeto e pediu guia GitHub/Cloud, prompt e documentação de continuidade. Depois esclareceu que imaginou mapas grandes, com arrasto e zoom nas fases e no reino, e pediu corrigir o pacote inteiro antes de enviar o ZIP ao repositório. Esse requisito é OWNER_CONFIRMED. As dimensões 20 × 20 / 40 × 60 e 60 colocações são escolhas iniciais de planejamento, não medidas aprovadas individualmente ou balanceadas. As seis regiões delimitam o primeiro conteúdo; tamanho de campanha pode evoluir em decisão separada.

## Estado real — M0.1, 02/11/2026 (UTC)

CONFIRMADO: o proprietário aceitou a documentação no commit `0733005bb2b83639522596ce63526003fb23cca8` e autorizou retirar o draft e integrar o PR #1, preservando os commits. Cabeça conferida sem alterações posteriores; merge realizado em `2d80844b8bc4a147bf428ade00448b5f6d2f02ba`, confirmado como main remota. Repositório: https://github.com/projetoscodex-nuvem/vila-de-bolso (público). A implementação foi isolada em `feat/m0-1-foundation`, a partir dessa main. Este PROJECT_CONTEXT.md continua canônico; ZIP/manifesto e o relatório de importação permanecem históricos.

CONFIRMADO: M0.1 autorizado nesta tarefa. Projeto Godot 4.6.3/GDScript/Compatibility, menu → reino 40 × 60 → região1 20 × 20 → voltar, câmera por visão, arrasto/pinça/zoom, HUD fixa, seleção e save mínimo implementados e verificados por testes headless/sintéticos. Demais regiões bloqueadas. Sem partida, score, construção ou desfazer. D026 continua pendente antes de implementar desfazer em M1/M2.

Estado **M0_1_APK_VERIFIED_DELIVERY_BLOCKED**: o desenvolvedor gerou novo APK real neste ambiente com o fonte exato2858a75 e checkout limpo. Permissão de rede por comando, proxy JVM e ANDROID_USER_HOME local resolveram o setup sem mudar política global/HOME; ferramentas e hashes fixados preservados. APK 56.448.943 bytes, SHA-256 6a6dbeaa9c6f20c9cf8b4c8ce331afa51870d12d2b91585007908c6883f21a73; dependências/cena/menu headless isolados, assinatura e manifesto 24/36/compile36 PASS. Android físico do novo APK NOT_RUN; antigo60f2491 com inicialização visual OWNER_REPORTED FAIL. Assinatura debug mudou; remover versão antiga apaga save local. Não delegar a compilação ao proprietário/ChatGPT Work. Fonte e evidências no [relatório do novo APK](reports/M0_1_LOCAL_APK_2858A75_REPORT.md), [PROJECT_STATE.md](PROJECT_STATE.md) e [histórico da correção](reports/M0_1_STARTUP_FIX_REPORT.md). Sem aceite, CI/merge/M1 ou alteração de D026.

## Não confundir com outros projetos

Este projeto é separado do jogo Android de extração, BlockMan, ATLAS, Mundo Medieval e outros. Não importar suas regras, dependências, permissões, documentação ou progresso.

## Continuidade obrigatória

Leia este arquivo junto de PROJECT_STATE.md, HANDOFF.md, DECISIONS.md e os arquivos relevantes à tarefa. Repositório atual é a referência; esta cópia inicial pode ficar desatualizada. Não alegar acesso automático ao código do GitHub em um novo chat: fornecer URL/branch/commit, pacote ou arquivos atuais.

Documentos reduzem perda de contexto; não garantem memória perfeita nem impedem todos os erros de IA. Se não houver mecanismo disponível para escrever memória permanente da conta, preservar esta memória documental e declarar o limite.


Atualização de entrega (03/11/2026 UTC): OWNER_REPORTED: links internos de APK e ZIP falharam no aplicativo Android ("Não foi possível abrir o arquivo"). Arquivos locais conferidos, com o mesmo SHA-256; isso é falha de entrega, não um novo teste de execução do jogo. Não há anexo binário confirmado nesta sessão. Um canal privado de arquivos precisa ser conectado; Dropbox foi sugerido e ainda não está conectado. Não repetir os caminhos internos como links de download, não recompilar o mesmo APK para corrigir transporte e não publicar release/CI por inferência. Fonte2858a75 e novo Android físico NOT_RUN preservados.


## Canal de entrega autorizado —03/11/2026 UTC

Proprietário escolheu GitHub Releases após tornar o repositório privado; Dropbox deixou de ser necessário. Autorização já concedida para essa sequência. Tentativa CLI bloqueada no proxy (api.github.com/ uploads.github.com: túnel403); naquela tentativa o repositório continuava PUBLIC; após mudança manual do proprietário, PRIVATE foi confirmado, ainda sem release/upload. Falta liberar esses destinos na rede do ambiente e então verificar autenticação CLI. ZIP/checksum/notas preparados; nunca enviar binário antes de confirmar private=true. [Plano e evidências](reports/M0_1_PRIVATE_RELEASE_STATUS.md).


Privacidade confirmada após ação manual do proprietário: private=true/visibility=private. A tentativa subsequente de criar rascunho de release retornou POST Forbidden no proxy; consulta autenticada confirma zero releases. Falta somente acesso técnico da CLI à API/uploads (e validação de sua autenticação após liberar a rede), não nova aprovação de publicação privada. Fonte/binário2858a75 inalterados; físico NOT_RUN.


Estado vigente de acesso/entrega (03/11/2026, America/Sao_Paulo): repo PUBLIC confirmado após o proprietário reverter para teste; referência PRIVATE anterior é histórica. Execução original guarda ZIP mas API Forbidden; outra execução reportada tem API200/user401 sem ZIP. [Plano atual](reports/M0_1_DELIVERY_RESUME.md): autenticar sessão com rede, recuperar ou gerar novamente do fonte corrigido2858a75 com novo hash/origem, e concluir upload/verificação nessa mesma sessão. Sem repetir configuração já publicada ou pedir token no chat; sem M1/CI/merge/D026.
