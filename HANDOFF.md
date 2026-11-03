# Passagem de contexto

Data: 02/11/2026 (America/Sao_Paulo). **M0.1 READY_FOR_OWNER_SMOKE**; ainda sem aceite físico.

## Identidade e escopo

Vila de Bolso — Meu Reino, Android retrato offline, Godot 4.6.3/GDScript/Compatibility. Fase 20 × 20, reino 40 × 60 com seis regiões 2 × 3, arrasto/zoom e HUD fixa. Parâmetros futuros 60 colocações/62 ofertas; PNGs legacy somente estilo. Sem partida, construções ou score nesta fundação. D026 não resolvida.

## Fonte e artefato

Main documental em 2d80844b8bc4a147bf428ade00448b5f6d2f02ba. PR #2 aberto/draft/sem merge, branch feat/m0-1-foundation. Commit fonte do APK: **60f2491f1a04001d4903d6e8d12c519df6bafd1b**. Commit posterior atualiza somente evidências/continuidade; conferir cabeça no PR.

Correções anteriores de toque e resultado por tentativa preservadas. Novos ajustes: min/target SDK vazios no preset sem Gradle para herdar o template, e importação ETC2/ASTC habilitada. Seis checks de configuração acrescentados; verificador documental atualizado. Lock, regras, dados e engine mantidos.

PASS: 163 checks de componentes/configuração, 44 regressões Input, 25 testes Python e smoke headless. Toolchain instalada neste executor, APK exportado/assinado e manifesto conferido (min24/target36). Bytes 56427508; SHA-256 `fb7abe176c9d96eef0131a6a654e06e77ff645fce7dbd96e9a7029a9da0307d7`. Arte geométrica provisória; APK não está no Git. Pacote de teste disponibilizado na conversa. O EPERM observado no sandbox anterior continua histórico; nenhuma política foi contornada nem CI ativado.

## Retomada e próximo passo

Leia AGENTS.md, PROJECT_CONTEXT.md, PROJECT_STATE.md, MAP_AND_CAMERA.md e [relatório de build](reports/M0_1_ANDROID_BUILD_REPORT.md). O [relatório anterior](reports/M0_1_REPORT.md) preserva tentativas bloqueadas e não representa o estado atual do APK. Proprietário deve testar instalação, offline, pan/pinça/botões, seleção, HUD e fechar/reabrir/Retomar, informando modelo/Android e PASS/FAIL.

Android físico, desempenho e aceite: NOT_RUN. Não concluir M0.1, iniciar M1 ou integrar PR #2 automaticamente. SDK/cache/chave são locais e não garantem persistência; o próximo executor deve usar scripts/lock e conferir disponibilidade. D026 continua pendente antes do desfazer em M1/M2. Não importar resultados de outros projetos.
