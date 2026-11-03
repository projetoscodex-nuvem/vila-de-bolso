# Passagem de contexto

03/11/2026 (UTC). **M0.1 APK_VERIFIED_DELIVERY_BLOCKED**, sem aceite; APK novo real gerado neste ambiente. Leia AGENTS.md, PROJECT_CONTEXT.md, PROJECT_STATE.md e [relatório atual](reports/M0_1_STARTUP_FIX_REPORT.md).

## Escopo e estado Git

Vila de Bolso — Meu Reino, Android retrato/offline, Godot 4.6.3/GDScript/Compatibility. PR #2 draft/sem merge, branch feat/m0-1-foundation; cabeça inicial desta tarefa 0c4296c. Conferir cabeça remota antes de continuar e preservar commits posteriores. Sem CI/M1, lock/versionamento inalterados e D026 pendente. Fase 20 × 20, reino 40 × 60; 60 colocações/62 ofertas futuras, sem partida completa.

## Falha do proprietário e diagnóstico

OWNER_REPORTED: instalou APK fonte 60f2491f1a04001d4903d6e8d12c519df6bafd1b, SHA-256 fb7abe176c9d96eef0131a6a654e06e77ff645fce7dbd96e9a7029a9da0307d7. Abriu com tela clara sem menu: inicialização visual FAIL. Demais físicos NOT_RUN. Revisão externa reportou cinco scripts ausentes. Reprodução local com preset scenes anterior gerou pacote sem essas dependências; runtime isolado falha no preload. Isso demonstra defeito no pacote, mas a relação com o sintoma Android segue hipótese forte sem logcat/reteste físico.

## Correção e testes

Preset resources lista cena, seis scripts e ícone; inclui dados/licença e exclui testes/ferramentas/relatórios/privados. SDKs vazios/Gradle falso/ETC2-ASTC mantidos. Validador de PCK/ZIP/assets do APK usa Godot em bootstrap temporário separado da fonte, resolve remaps/compilados, carrega cena e verifica menu/botões na árvore UI. Exportador bloqueia PASS/hash se esse gate falhar.

PASS local: 40 testes Python (fixtures identificadas), 163 checks Godot, 44 Input sintéticos, smoke 15 frames, 15 casos de pacote incluindo ZIP/PCK reais, proveniência/links/parâmetros e diff. Headless não comprova pixels/toque/driver Android. Novo APK produzido com fonte 2858a75 e checkout limpo: runtime/assets do APK, assinatura v2/v3 e manifesto 24/36/compile36 PASS; SHA-256 6a6dbeaa9c6f20c9cf8b4c8ce331afa51870d12d2b91585007908c6883f21a73,56.448.943 bytes. A permissão adicional de rede por comando e ANDROID_USER_HOME local resolveram o setup; versões/hashes mantidos, sem alterar HOME ou política global. O [build histórico](reports/M0_1_ANDROID_BUILD_REPORT.md) e logs/hash originais foram preservados; não representam aprovação física nem APK da correção.

## Próximo passo e limites

O desenvolvedor concluiu setup/exportação nesta máquina, sem delegar ao ChatGPT Work/proprietário. O fonte exato do APK é 2858a75b8742b3cf63d81293f7728d32647674b3; os commits seguintes apenas registram documentos/evidências. Entrega na pasta build/delivery_2858a75/ e ZIP build/Vila_de_Bolso_M0_1_2858a75_Android.zip, fora do Git. [Relatório local do APK e roteiro](reports/M0_1_LOCAL_APK_2858A75_REPORT.md). Preservar chave debug fora do Git; ambiente instalado não comprova persistência em outra VM.

Certificado debug diferente do antigo: o Android pode recusar atualizar. Desinstalar apaga o save de navegação/câmeras; só remover se o proprietário aceitar perder esses dados, sem inferir consentimento. Proprietário testar primeiro menu offline com novo APK e informar modelo/Android/PASS/FAIL; se falhar, coletar logcat e origem/hash. Demais físicos do novo binário NOT_RUN. Não aprovar M0.1, iniciar M1/CI/merge ou resolver D026 automaticamente.


## Transferência pendente

OWNER_REPORTED: links internos de APK e ZIP falharam no aplicativo Android ("Não foi possível abrir o arquivo"). Arquivos locais conferidos, com o mesmo SHA-256; isso é falha de entrega, não um novo teste de execução do jogo. Não há anexo binário confirmado nesta sessão. Um canal privado de arquivos precisa ser conectado; Dropbox foi sugerido e ainda não está conectado. Não repetir os caminhos internos como links de download, não recompilar o mesmo APK para corrigir transporte e não publicar release/CI por inferência. Fonte2858a75 e novo Android físico NOT_RUN preservados.


## Canal de entrega autorizado —03/11/2026 UTC

Proprietário escolheu GitHub Releases após tornar o repositório privado; Dropbox deixou de ser necessário. Autorização já concedida para essa sequência. Tentativa CLI bloqueada no proxy (api.github.com/ uploads.github.com: túnel403); naquela tentativa o repositório continuava PUBLIC; após mudança manual do proprietário, PRIVATE foi confirmado, ainda sem release/upload. Falta liberar esses destinos na rede do ambiente e então verificar autenticação CLI. ZIP/checksum/notas preparados; nunca enviar binário antes de confirmar private=true. [Plano e evidências](reports/M0_1_PRIVATE_RELEASE_STATUS.md).


Privacidade confirmada após ação manual do proprietário: private=true/visibility=private. A tentativa subsequente de criar rascunho de release retornou POST Forbidden no proxy; consulta autenticada confirma zero releases. Falta somente acesso técnico da CLI à API/uploads (e validação de sua autenticação após liberar a rede), não nova aprovação de publicação privada. Fonte/binário2858a75 inalterados; físico NOT_RUN.
