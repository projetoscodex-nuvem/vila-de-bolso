# Estado do projeto

03/11/2026 (UTC). Baseline v0.2. **M0_1_APK_VERIFIED_DELIVERY_BLOCKED — APK GERADO / ENTREGA NÃO CONCLUÍDA**.

**Atualização vigente:** [retomada da entrega em uma única execução](reports/M0_1_DELIVERY_RESUME.md). Última API confirma repositório PUBLIC após reversão manual do proprietário. Nova sessão reportada tem rede, mas falta autenticação e ZIP; original preserva ZIP, porém continua sem rede de API. Resolver login na sessão com rede e gerar novamente do fonte corrigido2858a75 se não houver acesso ao artefato, registrando novo hash. Não devolver a tarefa indefinidamente ao executor original. Fatos históricos abaixo mantidos com seus snapshots.

## DECISÃO

Corrigir somente inicialização/empacotamento M0.1, na branch feat/m0-1-foundation / PR #2 draft/sem merge. Cabeça inicial conferida em 0c4296c; main documental 2d80844 permanece sem implementação. Godot 4.6.3/GDScript/Compatibility, Android retrato/offline, Gradle desativado, SDKs herdados, ETC2/ASTC ativo e lock 24/36 preservados. Fase 20 × 20, reino 40 × 60, 60 colocações/62 ofertas futuras; sem M1 ou alteração de D026.

## IMPLEMENTAÇÃO

Seleção explícita de cena, seis scripts e ícone no preset resources; dados/licença mantidos e exclusões de testes/ferramentas/relatórios/privados preservadas. Gate do exportador verifica dependências remapeadas/compiladas e cena/menu em Godot isolada antes de PASS/assinatura/hash. Nenhum recurso local da fonte pode completar o pacote no teste. Fluxo, UI, entrada, câmeras, save e gameplay não alterados.

## TESTE

- Projeto: PASS, 40 testes Python, 163 checks Godot, 44 Input sintéticos, smoke 15 frames, proveniência/links/parâmetros e diff.
- Pacote: PASS, 15 casos de regressão. ZIP e PCK reais gerados pelo preset carregam cena/menu em bootstrap separado; filtro scenes anterior reproduz cinco scripts ausentes. Mutações negativas e wrapper APK são fixtures identificadas, sem APK Android novo.
- Android físico: OWNER_REPORTED instalou APK fonte 60f2491, SHA-256 fb7abe176c9d96eef0131a6a654e06e77ff645fce7dbd96e9a7029a9da0307d7; abriu com tela clara/sem menu: inicialização visual FAIL. Demais testes NOT_RUN.
- Novo APK: PASS neste ambiente, fonte exata 2858a75b8742b3cf63d81293f7728d32647674b3 com checkout limpo. Wrapper/runtime/assinatura zero; manifesto 24/36/compile36, sem uses-permission, ARMv7/ARM64. 56.448.943 bytes; SHA-256 6a6dbeaa9c6f20c9cf8b4c8ce331afa51870d12d2b91585007908c6883f21a73. Novo físico NOT_RUN.
- Ambiente: permissão adicional de rede por comando funcionou; JVM usou proxy explícito e ANDROID_USER_HOME gravável em .tools. JDK/SDK/templates instalados com versões/hashes fixados; EPERM padrão e falhas anteriores preservados como históricos, sem mudança global/CI.

## VALIDADO

Omissão reproduzida e correção do pacote demonstrada no host, inclusive .remap/.gdc/PCK e cena com botões visíveis na árvore UI headless. Relação com a tela Android é hipótese forte; sem execução física da correção. Resultados históricos do build 60f2491 (assinatura/manifesto/CRC/hash) preservados e superados para aceite pelo FAIL do proprietário.

[Relatório atual e comandos](reports/M0_1_STARTUP_FIX_REPORT.md), [histórico M0.1](reports/M0_1_REPORT.md), [build antigo](reports/M0_1_ANDROID_BUILD_REPORT.md). SHA exato testado e publicado é conciliado no PR #2 após gravação; evidências versionadas identificam o snapshot de working tree.

## PENDÊNCIA

APK novo produzido, conteúdo/runtime/assinatura/manifesto/hash validados; falta instalar/abrir no Android. Não declarar menu renderizado ou correção física a partir do headless. Modelo/Android do aparelho e logcat se repetir a falha. M0.1 sem aceite; D026 PENDING para antes do desfazer em M1/M2.

## PRÓXIMO PASSO

O desenvolvedor concluiu a exportação aqui; não delegar a compilação ao proprietário/ChatGPT Work. Baixar o novo arquivo da tarefa e testar primeiro o menu offline conforme o [relatório do APK](reports/M0_1_LOCAL_APK_2858A75_REPORT.md). A assinatura debug mudou: atualização sobre o antigo pode ser recusada; desinstalar apaga o save local, portanto só remover se aceitar essa perda. Sem CI, merge, release ou M1.

Fonte do binário:2858a75. Commit posterior é somente documental, sem reconstruir/renomear a origem do APK. M0.1 continua sem aceite.


## Bloqueio de entrega —03/11/2026 UTC

OWNER_REPORTED: links internos de APK e ZIP falharam no aplicativo Android ("Não foi possível abrir o arquivo"). Arquivos locais conferidos, com o mesmo SHA-256; isso é falha de entrega, não um novo teste de execução do jogo. Não há anexo binário confirmado nesta sessão. Um canal privado de arquivos precisa ser conectado; Dropbox foi sugerido e ainda não está conectado. Não repetir os caminhos internos como links de download, não recompilar o mesmo APK para corrigir transporte e não publicar release/CI por inferência. Fonte2858a75 e novo Android físico NOT_RUN preservados.


## Canal de entrega autorizado —03/11/2026 UTC

Proprietário escolheu GitHub Releases após tornar o repositório privado; Dropbox deixou de ser necessário. Autorização já concedida para essa sequência. Tentativa CLI bloqueada no proxy (api.github.com/ uploads.github.com: túnel403); naquela tentativa o repositório continuava PUBLIC; após mudança manual do proprietário, PRIVATE foi confirmado, ainda sem release/upload. Falta liberar esses destinos na rede do ambiente e então verificar autenticação CLI. ZIP/checksum/notas preparados; nunca enviar binário antes de confirmar private=true. [Plano e evidências](reports/M0_1_PRIVATE_RELEASE_STATUS.md).


Privacidade confirmada após ação manual do proprietário: private=true/visibility=private. A tentativa subsequente de criar rascunho de release retornou POST Forbidden no proxy; consulta autenticada confirma zero releases. Falta somente acesso técnico da CLI à API/uploads (e validação de sua autenticação após liberar a rede), não nova aprovação de publicação privada. Fonte/binário2858a75 inalterados; físico NOT_RUN.


## Publicação do ambiente confirmada pelo proprietário

OWNER_REPORTED confirmou que salvou e publicou os domínios corretamente; screenshots mostram api.github.com e uploads.github.com. Mesmo depois, ambiente desta conversa continua na revisão4 aplicada/enforced, custom_allowed_hosts=[] e gh api user retorna Forbidden. Não pedir ao proprietário para repetir publicação/seleção/privatização: a alteração publicada não está refletida na execução vinculada. O mecanismo exato da plataforma não foi diagnosticado, e as ferramentas aqui não editam/revinculam a instância. Próximo passo: nova execução selecionando o ambiente publicado; conferir política aplicada/autenticação e retomar release privada já autorizada. Não excluir o ambiente/conversa atual que preserva o ZIP; se a nova execução não encontrar os artefatos, o desenvolvedor deve recuperar/regerar a partir do fonte2858a75 com hashes/versões fixados e registrar a nova origem/hash, sem fingir reutilização.
