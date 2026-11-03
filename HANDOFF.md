# Passagem de contexto

03/11/2026 (UTC). **M0.1 STARTUP_FIX_PARTIAL_BLOCKED**, sem aceite. Leia AGENTS.md, PROJECT_CONTEXT.md, PROJECT_STATE.md e [relatório atual](reports/M0_1_STARTUP_FIX_REPORT.md).

## Escopo e estado Git

Vila de Bolso — Meu Reino, Android retrato/offline, Godot 4.6.3/GDScript/Compatibility. PR #2 draft/sem merge, branch feat/m0-1-foundation; cabeça inicial desta tarefa 0c4296c. Conferir cabeça remota antes de continuar e preservar commits posteriores. Sem CI/M1, lock/versionamento inalterados e D026 pendente. Fase 20 × 20, reino 40 × 60; 60 colocações/62 ofertas futuras, sem partida completa.

## Falha do proprietário e diagnóstico

OWNER_REPORTED: instalou APK fonte 60f2491f1a04001d4903d6e8d12c519df6bafd1b, SHA-256 fb7abe176c9d96eef0131a6a654e06e77ff645fce7dbd96e9a7029a9da0307d7. Abriu com tela clara sem menu: inicialização visual FAIL. Demais físicos NOT_RUN. Revisão externa reportou cinco scripts ausentes. Reprodução local com preset scenes anterior gerou pacote sem essas dependências; runtime isolado falha no preload. Isso demonstra defeito no pacote, mas a relação com o sintoma Android segue hipótese forte sem logcat/reteste físico.

## Correção e testes

Preset resources lista cena, seis scripts e ícone; inclui dados/licença e exclui testes/ferramentas/relatórios/privados. SDKs vazios/Gradle falso/ETC2-ASTC mantidos. Validador de PCK/ZIP/assets do APK usa Godot em bootstrap temporário separado da fonte, resolve remaps/compilados, carrega cena e verifica menu/botões na árvore UI. Exportador bloqueia PASS/hash se esse gate falhar.

PASS local: 40 testes Python (fixtures identificadas), 163 checks Godot, 44 Input sintéticos, smoke 15 frames, 15 casos de pacote incluindo ZIP/PCK reais, proveniência/links/parâmetros e diff. Headless não comprova pixels/toque/driver Android. Novo APK não produzido: processo continua EPERM antes de proxy/DNS/TLS e sem toolchain Android; não repetir downloads bloqueados. O [build histórico](reports/M0_1_ANDROID_BUILD_REPORT.md) e logs/hash originais foram preservados; não representam aprovação física nem APK da correção.

## Próximos comandos e limites

No executor que já exportou: preservar alterações e chave debug, atualizar por fast-forward e confirmar SHA final/checkout limpo. Executar scripts/setup.sh --android (reutilizando tools/cache fixados), scripts/verify.sh, scripts/export_android.sh; conferir aapt 24/36/permissões, apksigner e SHA-256 conforme roteiro exato do relatório. O gate de runtime já inspeciona o APK produzido; salvar resultado/attempt_id/logs e entregar binário/hash sem comitar SDK/APK/chave. SHA pós-commit testado fica no PR #2/resposta final.

Proprietário instalar atualização sem apagar dados por inferência, abrir offline e conferir menu. Se falhar, obter logcat e origem/hash/modelo/Android; demais testes continuam NOT_RUN. Se menu aparecer, seguir Explorar/Entrar/Retomar, gestos/HUD e persistência. Não aprovar M0.1 nem iniciar M1 automaticamente; não resolver D026 nesta tarefa.
