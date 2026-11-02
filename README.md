# Vila de Bolso — Meu Reino

Base documental v0.2 — 29/10/2026, America/Sao_Paulo.

Puzzle estratégico 2D, offline, vertical para Android. Cada fase constrói uma vila; o estado real da vila concluída passa a compor uma região fixa do reino. O jogador vê seu reino crescer sem perder as construções anteriores.

**Este repositório contém planejamento e referências, não o jogo implementado.** Importação documental v0.2 realizada em 31/10/2026, sem iniciar M0.1. Repositório confirmado: [projetoscodex-nuvem/vila-de-bolso](https://github.com/projetoscodex-nuvem/vila-de-bolso), público na auditoria. Veja [PROJECT_STATE.md](PROJECT_STATE.md) e o [relatório de importação](reports/IMPORT_V0_2_REPORT.md) para evidências e limites; não há APK ou teste Android nesta entrega.

## Comece aqui

1. Leia [PROJECT_CONTEXT.md](PROJECT_CONTEXT.md), a memória de entrada.
2. Revise a importação na branch `docs/importacao-v0-2` e seu [relatório](reports/IMPORT_V0_2_REPORT.md). O [guia de setup](GITHUB_CODEX_CLOUD_SETUP.md) e o [prompt de importação](PROMPT_IMPORTACAO_CODEX.md) permanecem como referência; não é necessário reenviar/extrair o ZIP nesta branch.
3. Somente após revisar a importação, envie [PROMPT_M0_1_CODEX.md](PROMPT_M0_1_CODEX.md) v0.2 em nova tarefa, autorizando explicitamente a implementação.
4. Após cada entrega, atualize [PROJECT_STATE.md](PROJECT_STATE.md) e [HANDOFF.md](HANDOFF.md).

## Fontes canônicas

| Arquivo | Responsabilidade |
| --- | --- |
| [AGENTS.md](AGENTS.md) | Instruções de trabalho do Codex |
| [PROJECT_CONTEXT.md](PROJECT_CONTEXT.md) | Identidade, contexto e decisões essenciais |
| [GAME_DESIGN.md](GAME_DESIGN.md) | Experiência e funcionalidades |
| [GAME_RULES.md](GAME_RULES.md) | Regras e parâmetros iniciais |
| [ARCHITECTURE.md](ARCHITECTURE.md) | Estrutura técnica e persistência |
| [MAP_AND_CAMERA.md](MAP_AND_CAMERA.md) | Mapas grandes, câmera, arrasto, zoom e gestos |
| [ROADMAP.md](ROADMAP.md) | Marcos, limites e critérios de saída |
| [PROJECT_STATE.md](PROJECT_STATE.md) | Estado efetivamente comprovado |
| [DECISIONS.md](DECISIONS.md) | Decisões e mudanças de direção |
| [TEST_PLAN.md](TEST_PLAN.md) | Verificações técnicas e testes do proprietário |
| [ASSETS_AND_LICENSES.md](ASSETS_AND_LICENSES.md) | Arte, áudio, origem e licenças |
| [HANDOFF.md](HANDOFF.md) | Passagem de contexto ao próximo agente/chat |
| [SOURCES.md](SOURCES.md) | Documentação externa consultada |

As referências visuais estão em [references/README.md](references/README.md). São conceitos gerados por IA; não substituem especificações ou arquivos reais de assets.

## Escopo da primeira versão

Uma campanha de seis regiões em arranjo 2 × 3: cada fase tem 20 × 20 células e o reino composto tem 40 × 60 células. Ambos são maiores que o viewport no zoom de jogo e permitem arrasto com um dedo e pinça para zoom. Seis peças, 60 colocações iniciais por partida, pontuação por vizinhança, mapa persistente, modo livre isolado, tutorial, salvamento, configurações e créditos. Dimensões/quantidade de jogadas são parâmetros de protótipo; o requisito de navegar por câmera em mapas maiores que a tela é confirmado. Balanceamento e desempenho não foram testados.

## Fluxo de trabalho

ChatGPT: planejamento e revisão independente. Codex: engenharia e execução. Proprietário: operação, testes no Android e aceite. Uma etapa revisável por vez. A conclusão de um marco técnico não equivale a validar diversão ou concluir o jogo.

## Versão ativa e referências anteriores

Esta baseline v0.2 substitui a v0.1. O plano anterior de fase pequena inteiramente enquadrada foi superado pelo pedido do proprietário. Não executar prompts antigos nem misturar documentos de versões diferentes. Mockups anteriores ficam em references/legacy_v0_1 e servem somente para estilo/identidade. Os documentos extraídos são canônicos; o ZIP e MANIFEST_SHA256.json preservam a proveniência do pacote original. O manifesto descreve o pacote, não os documentos reconciliados após a importação. PROJECT_CONTEXT.md é a fonte canônica de contexto.
