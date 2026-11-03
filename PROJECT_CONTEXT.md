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

Estado **M0_1_READY_FOR_OWNER_SMOKE**: correção Android salva em 60f2491f1a04001d4903d6e8d12c519df6bafd1b; toolchain instalada e APK exportado/assinado neste executor. minSdk 24/targetSdk 36, sem permissão de Internet. Testes físicos, desempenho, diversão e aceite continuam NOT_RUN. O EPERM do sandbox anterior está preservado como histórico de outro processo, sem alegar que foi liberado ou que o setup é persistente. Fonte e evidências em [PROJECT_STATE.md](PROJECT_STATE.md) e [relatório de build](reports/M0_1_ANDROID_BUILD_REPORT.md). OWNER_REPORTED: operação pelo celular.

## Não confundir com outros projetos

Este projeto é separado do jogo Android de extração, BlockMan, ATLAS, Mundo Medieval e outros. Não importar suas regras, dependências, permissões, documentação ou progresso.

## Continuidade obrigatória

Leia este arquivo junto de PROJECT_STATE.md, HANDOFF.md, DECISIONS.md e os arquivos relevantes à tarefa. Repositório atual é a referência; esta cópia inicial pode ficar desatualizada. Não alegar acesso automático ao código do GitHub em um novo chat: fornecer URL/branch/commit, pacote ou arquivos atuais.

Documentos reduzem perda de contexto; não garantem memória perfeita nem impedem todos os erros de IA. Se não houver mecanismo disponível para escrever memória permanente da conta, preservar esta memória documental e declarar o limite.
