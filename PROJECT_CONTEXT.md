# Memória de entrada — Vila de Bolso

Versão documental: 0.1. Data: 29/10/2026 (America/Sao_Paulo).

## Identidade e origem

Nome de trabalho adotado nesta baseline: **Vila de Bolso — Meu Reino**. Nome curto: Vila de Bolso. Sugestão de repositório: vila-de-bolso. Nome comercial e identificador definitivo da aplicação não foram pesquisados/registrados.

O proprietário pediu um jogo simples, intuitivo, interessante, realizável até o fim com Codex e assets gratuitos. A ideia escolhida é um puzzle de posicionamento 2D. Depois dos mockups, o proprietário definiu Android como alvo e gostou da progressão em que cada fase concluída incrementa o mesmo mapa.

## Direção consolidada

- Android como plataforma principal; retrato e toque desde o primeiro protótipo.
- Offline, um jogador, português do Brasil, sem conta, servidor, API de IA ou internet obrigatória.
- Reino de regiões fixas; a montagem local do jogador vira a imagem real daquela região no mapa.
- O reino não é uma imagem pronta revelada por progresso, nem um simulador de população/economia.
- Primeira campanha delimitada pela baseline: seis regiões, organização 2 colunas × 3 linhas.
- Cada fase: tabuleiro 7 × 7; seis peças; 30 colocações; ofertas de três peças; duas trocas por partida.
- Pontuação por quatro vizinhos ortogonais. Metas e valores iniciais precisam de balanceamento.
- Arte pequena e legível, inspirada em Kenney Tiny Town; conceitos gerados não são sprites prontos ou licença CC0 dos packs.
- Fluxo: planejamento/revisão no ChatGPT; engenharia no Codex Cloud; testes e aceite pelo proprietário no Android.

O proprietário autorizou iniciar o projeto e pediu guia GitHub/Cloud, prompt e documentação de continuidade. A quantidade de regiões, detalhes de desfazer e organização técnica são a baseline de implementação aqui consolidada, ainda sujeitos a ajustes registrados após protótipo; não afirmar que foram todos testados ou aprovados individualmente.

## Estado real na criação deste arquivo

PLANNING_BASELINE_READY. Existem documentos e mockups. Não há jogo, APK, ambiente remoto ou repositório confirmados. Nenhum teste de engine ou Android foi executado nesta preparação. Primeiro marco: M0.1, fundação técnica e prova de exportação Android; consultar PROJECT_STATE.md para o estado atual após o início.

## Não confundir com outros projetos

Este projeto é separado do jogo Android de extração, BlockMan, ATLAS, Mundo Medieval e outros. Não importar suas regras, dependências, permissões, documentação ou progresso.

## Continuidade obrigatória

Leia este arquivo junto de PROJECT_STATE.md, HANDOFF.md, DECISIONS.md e os arquivos relevantes à tarefa. Repositório atual é a referência; esta cópia inicial pode ficar desatualizada. Não alegar acesso automático ao código do GitHub em um novo chat: fornecer URL/branch/commit, pacote ou arquivos atuais.

Documentos reduzem perda de contexto; não garantem memória perfeita nem impedem todos os erros de IA. Se não houver mecanismo disponível para escrever memória permanente da conta, preservar esta memória documental e declarar o limite.
