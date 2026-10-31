# Decisões

Legenda: OWNER_CONFIRMED = pedido/preferência explícita; CONFIRMADO = fato auditado; BASELINE = decisão de planejamento consolidada para implementação; PENDING = ainda depende de evidência ou escolha.

| ID | Estado | Decisão e motivo |
| --- | --- | --- |
| D001 | OWNER_CONFIRMED | Iniciar o projeto do puzzle de vilas; objetivo de completar um jogo simples com assets gratuitos |
| D002 | OWNER_CONFIRMED | Android como alvo principal, com interface de celular |
| D003 | OWNER_CONFIRMED | Fase concluída incrementa mapa; construções anteriores permanecem |
| D004 | BASELINE | Nome de trabalho Vila de Bolso — Meu Reino; preservar identidade usada na conversa |
| D005 | BASELINE | Godot/GDScript, 2D retrato e offline para reduzir dependências e manter escopo |
| D006 | SUPERSEDED por D015/D016 | Modelo v0.1 de fase pequena inteiramente enquadrada; não implementar esse dimensionamento antigo |
| D007 | BASELINE | Mapa projeta snapshots reais, sem economia/cidadãos entre regiões |
| D008 | BASELINE | Seis peças e pontuação descritas em GAME_RULES.md como valores iniciais ajustáveis |
| D009 | BASELINE | Modo livre separado da campanha; rejogar não destrói vila anterior automaticamente |
| D010 | BASELINE | Um desfazer por partida com restauração de oferta; aceita informação antecipada num puzzle offline e elimina restrição anterior de UI impraticável |
| D011 | BASELINE | Primeiro marco limitado a fundação e prova APK; implementar partida após revisão |
| D012 | BASELINE | Repositório/docs como continuidade canônica; memória automática e contexto de VM não são armazenamento suficiente |
| D013 | PENDING | Release exata Godot, SDK, minSdk, aparelho de referência e orçamento de desempenho: definir com evidência no M0.1/M2 |
| D014 | PENDING | Metas por fase, sequências, curva de dificuldade e satisfação: provar no protótipo |

Mudança futura deve registrar: data, origem/pedido, problema, alternativas, decisão, efeitos em código/dados/save, testes e documentos atualizados. Não renomear propostas como aceite do proprietário. Não alterar regra apenas porque um mockup a representa de outra forma.

## Revisão v0.2 — 29/10/2026

| ID | Estado | Decisão e motivo |
| --- | --- | --- |
| D015 | OWNER_CONFIRMED | Fases e reino maiores que a tela, navegáveis por arrasto e zoom; proprietário pediu corrigir o pacote inteiro antes de enviar ao GitHub |
| D016 | BASELINE_PROTOTYPE | Fase 20 × 20, reino 2 × 3 de regiões = 40 × 60; 60 colocações e 62 ofertas; números iniciais a testar, não aprovados como equilíbrio final |
| D017 | BASELINE | 80–160 células construíveis como meta de conteúdo inicial, respeitando ao menos 60; terreno natural mantém limite espacial e identidade geográfica |
| D018 | BASELINE | HUD fixa, pan/pinch separados de tap/confirmar, zoom por pinça e botões; câmera com limites e restauração própria por visão, desde M0.1 |
| D019 | CONFIRMADO / OWNER_REPORTED | Auditoria em 31/10/2026 confirmou https://github.com/projetoscodex-nuvem/vila-de-bolso, base main f1b59a2ab0f148abc71f0caf91a102a79e122cee e arquivos iniciais README.md, PROJECT_CONTEXT.md e ZIP v0.2; operação pelo celular continua OWNER_REPORTED |
| D020 | BASELINE | ZIP v0.2 pode ser enviado como transporte; Codex extrai/reconcilia antes da implementação. Não exigir envio manual de pastas pelo celular |
| D021 | BASELINE | Mockups anteriores preservados em legacy_v0_1 somente para estilo; não representam câmera/dimensões atuais |

A mudança é documental e de requisitos. Nenhum teste de câmera, engine ou balanceamento foi executado. O aumento do terreno sem ajustar jogadas, ofertas e testes deixaria a especificação incoerente; essas dependências foram revisadas como parâmetros iniciais.

## Importação/reconciliação — 31/10/2026 (UTC)

Origem: solicitação explícita do proprietário e PROMPT_IMPORTACAO_CODEX.md v0.2. Problema: raiz com somente dois Markdown v0.1 e ZIP v0.2; documentos ainda não disponíveis para leitura direta.

| ID | Estado | Decisão e motivo |
| --- | --- | --- |
| D022 | OWNER_CONFIRMED | Executar somente importação/reconciliação v0.2; não instalar engine nem iniciar M0.1. Próxima implementação exige nova tarefa após revisão |
| D023 | CONFIRMADO | README.md e PROJECT_CONTEXT.md existentes são do mesmo projeto; comparação não revelou informação exclusiva removida pela v0.2. Reconciliar na raiz; PROJECT_CONTEXT.md canônico; nenhum alias ou material de outro projeto encontrado |
| D024 | BASELINE | Preservar ZIP, manifesto original e PACKAGING_REPORT.md como proveniência; documentos extraídos/reconciliados são canônicos. Alternativa de regenerar o manifesto original foi descartada para manter verificável o pacote recebido |
| D025 | CONFIRMADO | GitHub informa repositório público, divergindo da previsão inicial de privado em ASSETS_AND_LICENSES.md/guia. Registrar fato e preservar configuração; visibilidade/licença autoral não são alteradas nesta tarefa |

Efeitos: documentação e referências; nenhum código, dado de partida ou save alterado. Evidências, comandos, divergências e arquivos em [relatório de importação](reports/IMPORT_V0_2_REPORT.md). Critérios de câmera D015/D018 permanecem obrigatórios desde M0.1, que não foi iniciado.
