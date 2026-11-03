# Vila de Bolso — Meu Reino

Base documental v0.2 — 29/10/2026, America/Sao_Paulo.

Puzzle estratégico 2D, offline, vertical para Android. Cada fase constrói uma vila; o estado real da vila concluída passa a compor uma região fixa do reino. O jogador vê seu reino crescer sem perder as construções anteriores.

**Fundação M0.1 em revisão: projeto Godot/GDScript com navegação e seleção, sem partida completa.** A documentação v0.2 foi aceita pelo proprietário e integrada pelo [PR #1](https://github.com/projetoscodex-nuvem/vila-de-bolso/pull/1), preservando os commits, em `2d80844b8bc4a147bf428ade00448b5f6d2f02ba`. Implementação isolada na branch `feat/m0-1-foundation`. APK debug gerado do commit `60f2491`, com assinatura/manifesto conferidos; **aguardando teste físico do proprietário**. O bloqueio anterior do sandbox permanece histórico. Veja o [relatório de build Android](reports/M0_1_ANDROID_BUILD_REPORT.md). Veja [PROJECT_STATE.md](PROJECT_STATE.md) e o [relatório M0.1](reports/M0_1_REPORT.md).

## Comece aqui

1. Leia [PROJECT_CONTEXT.md](PROJECT_CONTEXT.md), a memória de entrada.
2. Leia o [relatório M0.1](reports/M0_1_REPORT.md), com limites, testes e roteiro físico. O [relatório de importação](reports/IMPORT_V0_2_REPORT.md) permanece histórico; sua restrição de árvore documental não se aplica à implementação.
3. Use o [guia de execução](scripts/README.md) para instalar as ferramentas fixadas, verificar o projeto e tentar exportar Android. O [prompt M0.1](PROMPT_M0_1_CODEX.md) é o escopo desta entrega; M1 não foi iniciado.
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
