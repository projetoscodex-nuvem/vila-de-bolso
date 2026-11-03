# M0.1 — Retomada da entrega em uma única execução

03/11/2026, America/Sao_Paulo. Escopo: concluir entrega do APK corrigido em GitHub Releases; sem merge, CI, M1 ou mudança de D026.

## Estado atual e limites entre execuções

| Origem da evidência | Rede/autenticação | Arquivo |
| --- | --- | --- |
| CONFIRMADO na execução original | Revisão4, API/uploads ausentes da política; gh api user ainda Forbidden | ZIP56.451.737 bytes e APK56.448.943 bytes preservados e hashes novamente conferidos |
| OWNER_REPORTED, retorno de outra execução enviado pelo proprietário | API releases HTTP200, /user401, gh sem autenticação; revisão da política não confirmada | ZIP corrigido não encontrado; não houve recompilação/upload |

Não transferir automaticamente os resultados de uma sessão para a outra. A conexão GitHub App que lê/escreve conteúdo não autentica necessariamente a CLI e não oferece ferramenta de upload de releases nesta integração. Não extrair/ler tokens dessa conexão ou apagar cabeçalhos/variáveis de autenticação herdados para forçar outro acesso.

CONFIRMADO na API autenticada nesta retomada: **repositório atualmente PUBLIC**, após o próprio proprietário ter voltado a público para testar a identificação no painel. Portanto as passagens anteriores “PRIVATE confirmado” eram verdadeiras naquele momento, mas não descrevem o estado atual. Não tratar isso como mudança inesperada pelo executor. A autorização original de distribuição era repositório privado antes da release: confirmar a visibilidade pretendida e cumprir essa condição antes de publicar assets; não inferir autorização pública do histórico antigo.

## Binário corrigido preservado na execução original

- Fonte:2858a75b8742b3cf63d81293f7728d32647674b3.
- ZIP build/Vila_de_Bolso_M0_1_2858a75_Android.zip: SHA-256b34eb6f00260230e3b584c2f9b7867bb4503f4d3dcd4e5e5942ef1a871050064.
- APK build/delivery_2858a75/Vila_de_Bolso_M0_1_2858a75.apk: SHA-2566a6dbeaa9c6f20c9cf8b4c8ce331afa51870d12d2b91585007908c6883f21a73.
- Não são o APK defeituoso60f2491, cujo hash começa fb7abe17 e cuja inicialização visual foi OWNER_REPORTED FAIL.

Esses caminhos só são evidência de localização na execução original, não links de download, anexos nem arquivos garantidos em outra execução. [Build e verificações reais](M0_1_LOCAL_APK_2858A75_REPORT.md).

## Sequência para o desenvolvedor na execução com rede

1. Conferir cabeça remota da branch feat/m0-1-foundation / PR#2, ler documentos atuais e preservar commits posteriores. Confirmar acesso de rede a api.github.com e uploads.github.com; não repetir configuração de domínios quando já houver resposta real do serviço.
2. Resolver autenticação antes de instalar/recompilar. Verificar identidade pelo SDK/CLI normalmente (`gh api user --jq .login`), sem imprimir variáveis/tokens ou ler arquivos secretos. Conexão do plugin não substitui essa verificação.
3. Se a CLI estiver comprovadamente sem autenticação, como no retorno401, o desenvolvedor deve iniciar fluxo oficial de autorização por navegador (`gh auth login --hostname github.com --git-protocol https --web`). Só o proprietário conclui consentimento no navegador. Não pedir token/senha no chat nem comitar código/credencial de login. Usar configuração de credenciais em raiz privada gravável, fora do Git (GH_CONFIG_DIR em .tools, se necessário), preservar mecanismos existentes e conferir armazenamento seguro. Se o ambiente exige vínculo de segredo gerenciado em vez de login, orientar esse vínculo seguro, com acesso limitado ao repositório. Não iniciar login apenas porque uma variável não está visível, nem substituir um token configurado sem diagnosticar seu estado.
4. Conferir visibilidade atual e condição de distribuição privada antes de criar/publicar release. A mudança de visibilidade já foi autorizada para a entrega privada, mas o proprietário voltou a público para teste; não confundir fato atual com as consultas históricas. Confirmar private=true quando a condição privada estiver em vigor.
5. Procurar artefato corrigido com origem e hash verificáveis. Se estiver acessível, reutilizar e verificar; não substituir por APK60f2491. **Se o ZIP só existe na execução original inacessível, não devolver a tarefa a ela indefinidamente:** é válido gerar novo APK do fonte corrigido2858a75 na execução com rede/autenticação. A geração já faz parte do escopo M0.1 autorizado; não é iniciar novo marco.
6. Para novo build: usar checkout limpo do commit exato2858a75 (isolado de alterações alheias); Godot4.6.3/Compatibility e toolchain/hash do lock; min/target herdados, Gradle falso, ETC2/ASTC; configurar diretórios XDG/ANDROID_USER_HOME privados graváveis sem alterar HOME, e proxy/CA herdados. Executar setup/verify/export do fonte, sem atualizar versões. [Roteiro do ambiente original](M0_1_LOCAL_APK_2858A75_REPORT.md) descreve requisitos que podem variar na nova sessão.
7. Validar APK novo real: CRC/dados/scripts compilados/remaps, cena/menu isolados, assinatura, manifesto24/36/compile36/sem rede e SHA-256. Registrar **novo hash, tamanho, assinatura, attempt_id e origem**: recompilar não garante os mesmos bytes/certificado e não pode herdar o hash anterior. Não atribuir fixtures a APK real.
8. Preparar ZIP/checksum/notas com identificação do build; criar rascunho de pré-release no commit fonte, enviar assets, baixar e verificar hashes, então publicar a pré-release no repositório com privacidade confirmada. Não fazer merge nem ativar CI. Dar link real retornado pelo GitHub, não URL presumida/caminho interno.
9. Atualizar relatório/estado/handoff/changelog e PR#2 com evidências separadas das históricas. Novo Android físico permanece NOT_RUN até o relato do proprietário; assinatura diferente pode impedir atualização, e desinstalar apaga save de navegação/câmeras. Não aprovar M0.1 automaticamente.

## Resultado desta retomada original

Arquivo original preservado, sem alteração/reconstrução/upload. Rede original continua bloqueada. Documentação atualizada para corrigir o estado público atual e permitir concluir geração/upload numa única execução acessível, em vez de alternar entre duas sem transferir o arquivo. Checagens pertinentes: integridade local, proveniência/links/parâmetros e git diff --check. Os testes de runtime/build continuam os resultados históricos do fonte2858a75, sem fingir nova execução física.
