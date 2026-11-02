# Prompt curto de continuidade

Continuar o projeto **Vila de Bolso — Meu Reino** no marco atualmente autorizado.

Modelo sugerido: GPT-6.1 Sol/high para implementação; medium para manutenção simples. Sugerir Astra/high diante de bloqueio técnico complexo persistente, retornando depois ao nível adequado. Não alegar troca automática de modelo.

Leia AGENTS.md, PROJECT_CONTEXT.md, PROJECT_STATE.md, HANDOFF.md e DECISIONS.md atuais. Confira Git/branch/commit e o código existente. Leia as regras e a arquitetura afetadas pela tarefa. Resuma o estado confirmado e execute apenas o próximo escopo explicitamente autorizado, seguindo ROADMAP.md.

Preserve Android offline vertical, puzzle de vilas e reino montado com estados reais das regiões. Não importar regras de outros projetos. Não assumir testes/aceites a partir de respostas anteriores. Atualize contexto, estado, decisões, handoff e changelog conforme necessário. Entregue evidência e reporte DECISÃO/IMPLEMENTAÇÃO/TESTE/VALIDADO/PENDÊNCIA/PRÓXIMO PASSO.

Se este prompt vier sem tarefa/marco autorizado identificável nos arquivos ou na mensagem, faça a revisão de estado e indique o próximo recorte; não implemente todo o roadmap por inferência.

## Mudança já incorporada na baseline v0.2

O mapa maior não é uma pendência de escopo: é requisito confirmado. Leia MAP_AND_CAMERA.md. A fase inicial é 20 × 20 e o reino 40 × 60, com 60 colocações como parâmetro de protótipo. Arrasto e pinça nas duas visões, HUD fixa, tap separado de navegação. Não usar o antigo plano pequeno nem os PNGs legados como especificação atual.
