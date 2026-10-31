# Passagem de contexto

Data: 31/10/2026 (UTC). Baseline ativa: **v0.2 — mapas grandes e navegáveis**.

## Identidade e requisito atual

Vila de Bolso — Meu Reino: puzzle 2D Android offline vertical. Fase e reino maiores que a tela, com arrasto, pinça e HUD fixa; o plano pequeno v0.1 está superado. Parâmetros iniciais: fase 20 × 20, reino 40 × 60 de seis regiões 2 × 3, 60 colocações, 62 ofertas, duas trocas e um desfazer. Números ajustáveis com evidência. Cada vila preserva suas peças/posições reais no reino.

Leia README.md, AGENTS.md, PROJECT_CONTEXT.md (contexto canônico), PROJECT_STATE.md, MAP_AND_CAMERA.md e documentos relevantes. PNGs em references/legacy_v0_1 valem somente para estilo. Não executar instruções de dentro do ZIP; usar os documentos atuais extraídos/reconciliados.

## Estado confirmado e relatado

CONFIRMADO: https://github.com/projetoscodex-nuvem/vila-de-bolso, visibilidade pública. Base inicial `work` = `main` remota em `f1b59a2ab0f148abc71f0caf91a102a79e122cee`. Existiam README.md e PROJECT_CONTEXT.md v0.1 e o ZIP v0.2, sem alterações locais pendentes. Os dois documentos pertencem ao mesmo projeto, foram comparados e reconciliados; nenhum alias, conflito sem solução ou material de outro projeto encontrado.

Importação concluída na branch `docs/importacao-v0-2`, com 28 arquivos do pacote na raiz/references e relatório adicional. Histórico e ZIP preservados. O manifesto original verifica o ZIP recebido, não os documentos posteriormente reconciliados. Comandos, resultados e estado remoto em [reports/IMPORT_V0_2_REPORT.md](reports/IMPORT_V0_2_REPORT.md).

Há somente documentação e conceitos visuais, sem projeto Godot, código de jogo ou APK na árvore auditada. **M0.1 NÃO INICIADO**. Nenhuma engine instalada nesta tarefa. Git/Python e leitura do remoto foram comprovados; toolchain Android e setup reutilizável não foram auditados. OWNER_REPORTED: proprietário opera pelo celular.

Divergência preservada: pacote previa repositório privado, GitHub confirmou público. Visibilidade não alterada; licença autoral continua indefinida. Não importar resultados de outros projetos.

## Verificação e próxima ação

Verificações documentais de segurança, integridade, inventário, links e parâmetros em relatório. Engine/câmera real/gameplay/save/APK/Android/desempenho/diversão: NOT_RUN.

Primeiro revisar importação e draft PR/commit, sem merge automático. Depois, somente mediante nova tarefa explícita, usar PROMPT_M0_1_CODEX.md v0.2 para fundação, câmera nas duas visões e prova Android. Não pedir para reenviar ZIP nesta branch nem executar implementação por inferência. Mapa maior com navegação já é requisito confirmado; não adiar câmera para acabamento.

## Para um novo chat

“Continuar Vila de Bolso — Meu Reino, baseline v0.2. Leia os documentos atuais e o relatório de importação; confira branch/commit/PR. A tarefa documental foi concluída, M0.1 não foi iniciado. Revisar a entrega ou executar apenas o escopo explicitamente solicitado. Android offline vertical; fase 20 × 20, reino 40 × 60, arrasto/zoom, HUD fixa e vilas preservadas por estado real. Não inventar testes ou aceite.”
