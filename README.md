# Vila de Bolso — Meu Reino

Base documental v0.1 — 29/10/2026, America/Sao_Paulo.

Puzzle estratégico 2D, offline, vertical para Android. Cada fase constrói uma vila; o estado real da vila concluída passa a compor uma região fixa do reino. O jogador vê seu reino crescer sem perder as construções anteriores.

**Este pacote contém planejamento e referências, não o jogo implementado.** Não existe APK, repositório remoto configurado ou teste Android executado nesta entrega.

## Comece aqui

1. Leia [PROJECT_CONTEXT.md](PROJECT_CONTEXT.md), a memória de entrada.
2. Siga [GITHUB_CODEX_CLOUD_SETUP.md](GITHUB_CODEX_CLOUD_SETUP.md).
3. Envie [PROMPT_M0_1_CODEX.md](PROMPT_M0_1_CODEX.md) ao Codex com este conteúdo já no repositório.
4. Após cada entrega, atualize [PROJECT_STATE.md](PROJECT_STATE.md) e [HANDOFF.md](HANDOFF.md).

## Fontes canônicas

| Arquivo | Responsabilidade |
| --- | --- |
| [AGENTS.md](AGENTS.md) | Instruções de trabalho do Codex |
| [PROJECT_CONTEXT.md](PROJECT_CONTEXT.md) | Identidade, contexto e decisões essenciais |
| [GAME_DESIGN.md](GAME_DESIGN.md) | Experiência e funcionalidades |
| [GAME_RULES.md](GAME_RULES.md) | Regras e parâmetros iniciais |
| [ARCHITECTURE.md](ARCHITECTURE.md) | Estrutura técnica e persistência |
| [ROADMAP.md](ROADMAP.md) | Marcos, limites e critérios de saída |
| [PROJECT_STATE.md](PROJECT_STATE.md) | Estado efetivamente comprovado |
| [DECISIONS.md](DECISIONS.md) | Decisões e mudanças de direção |
| [TEST_PLAN.md](TEST_PLAN.md) | Verificações técnicas e testes do proprietário |
| [ASSETS_AND_LICENSES.md](ASSETS_AND_LICENSES.md) | Arte, áudio, origem e licenças |
| [HANDOFF.md](HANDOFF.md) | Passagem de contexto ao próximo agente/chat |
| [SOURCES.md](SOURCES.md) | Documentação externa consultada |

As referências visuais estão em [references/README.md](references/README.md). São conceitos gerados por IA; não substituem especificações ou arquivos reais de assets.

## Escopo da primeira versão

Uma campanha de seis regiões em mapa 2 × 3; tabuleiros 7 × 7; seis tipos de peça; 30 colocações por partida; pontuação por vizinhança; mapa persistente; modo livre isolado da campanha; tutorial, salvamento, configurações e créditos. Metas numéricas e equilíbrio ainda exigem protótipo.

## Fluxo de trabalho

ChatGPT: planejamento e revisão independente. Codex: engenharia e execução. Proprietário: operação, testes no Android e aceite. Uma etapa revisável por vez. A conclusão de um marco técnico não equivale a validar diversão ou concluir o jogo.
