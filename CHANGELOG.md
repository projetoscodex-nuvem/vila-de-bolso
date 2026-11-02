# Histórico

## Correções da revisão M0.1 — 02/11/2026 (UTC)

- Reproduzida a falha de toque na GUI via Input.parse_input_event; habilitada emulação touch→mouse para botões e ignorado somente mouse DEVICE_ID_EMULATION nos gestos, preservando mouse físico e evitando contato duplicado/pinça com um dedo.
- Adicionadas 44 verificações pelo fluxo Input/GUI da Godot, sem app._input direto ou emissão de pressed; 157 checks anteriores mantidos como componentes/cena, sem alegar teste físico.
- Exportação com resultado novo por tentativa desde RUNNING até status final, inclusive falhas de dependência/exportação/timeout/manifesto/CRC/assinatura. Resultado/log/APK anteriores arquivados por attempt_id; saída não verificada separada do APK atual.
- Adicionados 18 testes de exportação com fixtures isoladas e runner simulado, totalizando 25 testes Python; nenhuma fixture é APK real.
- Diagnosticado EPERM na criação de socket do processo antes de proxy/DNS/TLS; setup e exportação Android reais repetidos e BLOCKED. Receita CI manual inativa entregue, sem executar ou presumir permissões/limites da conta.
- Atualizados relatório, evidências e continuidade na mesma branch/PR #2, sem merge, release, publicação, M1 ou resolução de D026. Versões/hashes e parâmetros v0.2 preservados; testes físicos NOT_RUN.

## M0.1 — fundação em revisão, Android BLOCKED — 02/11/2026 (UTC)

- Importação/revisão documental aceita pelo proprietário; PR #1 integrado com merge preservando commits em 2d80844b8bc4a147bf428ade00448b5f6d2f02ba. Implementação em branch separada feat/m0-1-foundation.
- Projeto Godot 4.6.3/GDScript/Compatibility, Android retrato e offline; menu → reino 40 × 60 → região1 20 × 20 → voltar. Demais regiões bloqueadas; arte geométrica e ícone provisórios, sem reutilizar PNGs legados como telas.
- Arrasto, pinça, zoom por botões/roda, recentrar/visão geral, limites, recorte inicial, transformação de coordenadas e HUD fixa. Seleção sem ação de construção; cancelamento/pausa/Voltar do Android tratados.
- Save mínimo versionado com câmeras independentes, retomada, backup e preservação de arquivos inválidos. Sem salvar dedos, gestos ou seleção transitória.
- Scripts fixados para setup/verificação/exportação, testes headless de dados/câmera/gestos/save/cena e relatório M0.1 com evidências. Relatório histórico da importação, ZIP e manifesto preservados.
- Exportação debug tentada e marcada PARCIAL/BLOCKED: JDK completo/SDK/templates ausentes e download recusado no sandbox. Nenhum APK ou teste físico Android. Sem CI automático, release, publicação ou merge do novo PR.
- Parâmetros futuros 60 colocações/62 ofertas e D026 pendente preservados. M1 não iniciado; não implementados partida, pontuação, construção, ofertas ou desfazer.

## Ajustes da revisão externa v0.2 — 01/11/2026 (UTC)

- Corrigido GAME_DESIGN.md: terrenos e encaixes serão definidos e validados nos templates; PNGs legacy_v0_1 orientam somente estilo/paleta, sem definir geografia, dimensões, câmera ou layout funcional.
- Registrada D026 como pendência antes de implementar desfazer em M1/M2: sequência “colocar → trocar oferta → desfazer”, incluindo oferta, cursor e quota de trocas. Sem escolha ou implementação de regra nova; não bloqueia a fundação M0.1.
- Atualizados PROJECT_STATE.md e HANDOFF.md e acrescentado atendimento à revisão externa em reports/IMPORT_V0_2_REPORT.md, preservando o histórico da importação.
- Atualizado o verificador transcrito para incluir GAME_DESIGN.md nas diferenças esperadas; dez documentos reconciliados e 18 arquivos idênticos ao pacote. ZIP e manifesto originais preservados.
- Mantidos fase 20 × 20, reino 40 × 60, 60 colocações, 62 ofertas e navegação por arrasto/zoom nas duas visões. M0.1 não iniciado; sem instalação de Godot/SDK, implementação ou testes de jogo/Android.

## Importação v0.2 — 31/10/2026 (UTC)

- Importados 28 arquivos do ZIP v0.2 diretamente à raiz, incluindo quatro PNGs preservados em references/legacy_v0_1, exclusivamente para estilo.
- Reconciliados README.md e PROJECT_CONTEXT.md v0.1 após comparação, mantendo identidade, origem e limites do mesmo projeto; fonte canônica de contexto explicitada.
- Atualizados estado, handoff, decisões, guia e registro de assets com fatos auditados: remoto, base Git, branch de tarefa e visibilidade pública divergente da previsão privada.
- Preservados ZIP e manifesto original como proveniência; PACKAGING_REPORT.md identificado como registro histórico e relatório de importação acrescentado.
- Verificados segurança de caminhos, CRC, 27 hashes do manifesto, links, inventário e consistência dos parâmetros v0.2. Evidências em reports/IMPORT_V0_2_REPORT.md.
- Entrega salva na branch docs/importacao-v0-2 e [draft PR #1](https://github.com/projetoscodex-nuvem/vila-de-bolso/pull/1), sem merge; commit inicial ebaa7abe53445e8a2b35a03cf4d1543a8eeb07ce verificado com árvore limpa, seguido por atualização documental de evidência.
- Somente documentação; M0.1 não iniciado. Nenhuma instalação de engine, código de jogo, APK ou teste de gameplay/Android.

## 0.2 — 29/10/2026

- Incorporado pedido do proprietário: mapas maiores que a tela nas fases e no reino, com arrasto/zoom.
- Parâmetros iniciais: fase 20 × 20, reino 40 × 60, 60 colocações, 62 ofertas e meta de 80–160 células construíveis por fase.
- Acrescentada especificação de câmera/gestos, HUD fixa, seleção segura, limites e persistência de posição/zoom.
- Atualizados arquitetura, regras, testes, roadmap, estado, memória documental e prompts; M0.1 agora exige navegação.
- Novo prompt de importação do ZIP pelo Codex, adequado ao envio pelo celular, preservando/reconciliando os dois Markdown já relatados na raiz.
- Mockups antigos reclassificados como LEGADO_VISUAL; não houve geração de mockups novos.
- Sem código de jogo, testes Android ou validação de equilíbrio nesta revisão.

## 0.1 — 29/10/2026

- Consolidada proposta Vila de Bolso — Meu Reino para Android offline vertical.
- Documentado reino persistente, regras iniciais, arquitetura, roteiro e validação.
- Preparados guia GitHub/Cloud, instruções AGENTS.md, memória documental e prompts.
- Selecionadas quatro referências visuais geradas na conversa.
- Sem código de jogo, APK, testes de runtime ou repositório remoto criado nesta preparação.
