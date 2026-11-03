# Estado do projeto

03/11/2026 (UTC). Baseline v0.2. **M0_1_STARTUP_FIX_PARTIAL_BLOCKED — NOVO APK PENDENTE / M0.1 NÃO APROVADO**.

## DECISÃO

Corrigir somente inicialização/empacotamento M0.1, na branch feat/m0-1-foundation / PR #2 draft/sem merge. Cabeça inicial conferida em 0c4296c; main documental 2d80844 permanece sem implementação. Godot 4.6.3/GDScript/Compatibility, Android retrato/offline, Gradle desativado, SDKs herdados, ETC2/ASTC ativo e lock 24/36 preservados. Fase 20 × 20, reino 40 × 60, 60 colocações/62 ofertas futuras; sem M1 ou alteração de D026.

## IMPLEMENTAÇÃO

Seleção explícita de cena, seis scripts e ícone no preset resources; dados/licença mantidos e exclusões de testes/ferramentas/relatórios/privados preservadas. Gate do exportador verifica dependências remapeadas/compiladas e cena/menu em Godot isolada antes de PASS/assinatura/hash. Nenhum recurso local da fonte pode completar o pacote no teste. Fluxo, UI, entrada, câmeras, save e gameplay não alterados.

## TESTE

- Projeto: PASS, 40 testes Python, 163 checks Godot, 44 Input sintéticos, smoke 15 frames, proveniência/links/parâmetros e diff.
- Pacote: PASS, 15 casos de regressão. ZIP e PCK reais gerados pelo preset carregam cena/menu em bootstrap separado; filtro scenes anterior reproduz cinco scripts ausentes. Mutações negativas e wrapper APK são fixtures identificadas, sem APK Android novo.
- Android físico: OWNER_REPORTED instalou APK fonte 60f2491, SHA-256 fb7abe176c9d96eef0131a6a654e06e77ff645fce7dbd96e9a7029a9da0307d7; abriu com tela clara/sem menu: inicialização visual FAIL. Demais testes NOT_RUN.
- Novo APK: BLOCKED neste processo; AF_INET/EPERM antes de proxy/DNS/TLS, JDK/SDK/templates ausentes. Nenhuma instalação/download inviável foi repetida.

## VALIDADO

Omissão reproduzida e correção do pacote demonstrada no host, inclusive .remap/.gdc/PCK e cena com botões visíveis na árvore UI headless. Relação com a tela Android é hipótese forte; sem execução física da correção. Resultados históricos do build 60f2491 (assinatura/manifesto/CRC/hash) preservados e superados para aceite pelo FAIL do proprietário.

[Relatório atual e comandos](reports/M0_1_STARTUP_FIX_REPORT.md), [histórico M0.1](reports/M0_1_REPORT.md), [build antigo](reports/M0_1_ANDROID_BUILD_REPORT.md). SHA exato testado e publicado é conciliado no PR #2 após gravação; evidências versionadas identificam o snapshot de working tree.

## PENDÊNCIA

Exportar novo APK do commit final, validar conteúdo/runtime, assinatura, manifesto 24/36 e hash; instalar/abrir no Android. Não declarar menu renderizado ou correção física a partir do headless. Modelo/Android do aparelho e logcat se repetir a falha. M0.1 sem aceite; D026 PENDING para antes do desfazer em M1/M2.

## PRÓXIMO PASSO

Executor que já tem toolchain: atualizar branch por fast-forward, confirmar SHA final/checkout limpo, executar scripts/verify.sh e scripts/export_android.sh e seguir o relatório. Preservar chave debug, disponibilizar APK/hash identificado pelo novo commit; proprietário testar primeiro menu offline. Sem CI, merge, release ou M1.
