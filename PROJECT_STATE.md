# Estado do projeto

Data: 02/11/2026 (America/Sao_Paulo). Baseline v0.2. Estado: **M0_1_READY_FOR_OWNER_SMOKE — APK GERADO / AGUARDANDO TESTE FÍSICO**.

## DECISÃO

Continuação do M0.1 autorizada pelo proprietário. PR #1 integrado na main 2d80844b8bc4a147bf428ade00448b5f6d2f02ba. PR #2 / feat/m0-1-foundation permanece draft e sem merge. Código corrigido e exportado no commit 60f2491f1a04001d4903d6e8d12c519df6bafd1b. Evidências posteriores são documentais; não confundir seus commits com a origem do APK.

Android retrato offline; Godot 4.6.3/GDScript/Compatibility; fase 20 × 20, reino 40 × 60 em seis regiões 2 × 3. Parâmetros futuros 60 colocações/62 ofertas preservados; sem gameplay completo. D026 continua PENDING para antes do desfazer em M1/M2.

## IMPLEMENTAÇÃO

Menu → reino → região1 → voltar; demais regiões bloqueadas. Arrasto/pinça/botões/limites, HUD fixa, seleção segura e save mínimo de visão/câmeras. Emulação de mouse atende à GUI sem duplicar contatos no mapa; mouse físico preservado. Exportador identifica e finaliza cada tentativa.

Correção Android: níveis SDK herdados do template sem overrides Gradle; importação ETC2/ASTC habilitada. Lock e versões mantidos. Não há construção, pontuação, ofertas em execução ou desfazer. Arte geométrica provisória.

## TESTE

PASS: 163 checks Godot, 44 regressões Input, 25 testes Python, smoke headless, proveniência/links e diff. PASS: instalação da toolchain no executor externo de build; exportação real, assinatura, manifesto/CRC/dados do APK. minSdk 24, targetSdk 36; ARM64/ARMv7. APK 56427508 bytes, SHA-256 `fb7abe176c9d96eef0131a6a654e06e77ff645fce7dbd96e9a7029a9da0307d7`.

O bloqueio EPERM anterior está preservado em [relatório histórico](reports/M0_1_REPORT.md); era de outro processo. A instalação no executor externo não prova ambiente Codex reutilizável. CI não ativado. Android físico e aceite: NOT_RUN.

## VALIDADO

Fonte e APK para smoke, sem declarar jogo completo ou M0.1 aceito. Detalhes e roteiro em [relatório de build](reports/M0_1_ANDROID_BUILD_REPORT.md).

## PENDÊNCIA

Proprietário informar aparelho/Android e testar instalação, navegação/toque, HUD, offline e restauração. D026, licença autoral, balanceamento e compatibilidade física permanecem pendentes.

## PRÓXIMO PASSO

Baixar o pacote Android entregue na conversa e seguir o roteiro do relatório. Reportar PASS/FAIL. Não fazer merge do PR #2 nem avançar para M1 antes do resultado/revisão.


## Verificação complementar — 03/11/2026 (UTC)

Os commits remotos concorrentes 60f2491 e b89b16d foram preservados como ancestrais. Permanecem os três valores corrigidos, os seis checks nativos ConfigFile/ProjectSettings e todos os relatórios/evidências do APK produzido no outro executor. O commit final acrescenta verificação Python por seções e dez regressões negativas/positiva: 35 testes Python, 163 checks de componentes/configuração Godot e 44 Input/GUI PASS. Lock, regras, dados e D026 intactos; sem CI, merge ou M1.

Distinção de origem: a exportação e o hash documentados são do executor externo, fonte 60f2491, registrados em b89b16d; esses registros não foram substituídos. O processo desta verificação permanece EPERM antes de proxy/DNS/TLS, sem JDK/SDK/templates locais, e não executou nova instalação/exportação. O APK não foi baixado nem teve hash recalculado aqui. Testes físicos NOT_RUN.

Devolver o SHA final ao executor que já funcionou para correlacionar/reexportar a entrega e disponibilizar APK/hash, preservando a origem do artefato já existente. Evidência externa não deve ser renomeada como build desse novo commit. O relatório anterior guarda a análise adicional e o bloqueio local; o relatório Android externo continua íntegro.
