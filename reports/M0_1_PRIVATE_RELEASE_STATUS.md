# M0.1 — Repositório privado e release de teste: preparação/bloqueio

**Estado vigente posterior:** repo voltou a PUBLIC por ação do proprietário; há retorno de outra execução com rede200/user401 sem ZIP. Usar [retomada atual](M0_1_DELIVERY_RESUME.md) para evitar devolver a tarefa à execução original bloqueada. As confirmações PRIVATE e instruções abaixo descrevem seus snapshots históricos.

03/11/2026 UTC. O proprietário autorizou tornar projetoscodex-nuvem/vila-de-bolso privado e, somente depois, enviar o ZIP em release. Essa autorização substitui o veto anterior a releases para esta distribuição privada de testes. Sem merge/CI/M1 e sem alteração de D026.

## Estado confirmado

- Repositório **PRIVATE CONFIRMADO** após alteração manual pelo proprietário; API retorna private=true/visibility=private. Conta conectada informa permissão admin. A tentativa anterior via CLI não efetivou a mudança; o sucesso foi a ação manual do proprietário.
- Nenhuma release/asset criado e nenhum upload efetuado. Não enviar binário enquanto private=true não estiver confirmado.
- APK2858a75 preservado:56.448.943 bytes, SHA-2566a6dbeaa9c6f20c9cf8b4c8ce331afa51870d12d2b91585007908c6883f21a73.
- ZIP preparado:56.451.737 bytes, SHA-256b34eb6f00260230e3b584c2f9b7867bb4503f4d3dcd4e5e5942ef1a871050064.
- Notas, checksum externo e plano preparados em build/private_release/, sem publicar e sem incluir SDK/chave/binário no Git.

## Tentativa e diagnóstico

O conector disponível permite ler o repositório/alterar conteúdo, mas não oferece operações de visibilidade/release/upload. A alternativa CLI instalada foi consultada; essa versão não suporta --accept-visibility-change-consequences. Usado o comando suportado:

```bash
gh repo edit projetoscodex-nuvem/vila-de-bolso --visibility private
```

Resultado: `Patch "https://api.github.com/repos/projetoscodex-nuvem/vila-de-bolso": Forbidden`.

Requisições HEAD públicas sem autenticação a api.github.com/meta e uploads.github.com retornaram `Tunnel connection failed: 403 Forbidden`, mesmo com a permissão adicional de rede do comando. Isso demonstra bloqueio de destino no proxy do ambiente, independente de uma operação administrativa autenticada. Não é evidência de falta de admin da conta. Não remover proxy, mudar rota, expor token ou contornar o bloqueio. Após liberar a rede, a autenticação/autorização da CLI ainda precisa ser verificada normalmente.

A configuração atual de rede aplicada não inclui api.github.com nem uploads.github.com. É necessária a alteração desses destinos pelas configurações suportadas do ambiente Cloud, com revisão/aplicação pelo proprietário. A skill de runtime apenas consulta a configuração; não há ferramenta de edição dessa política nesta sessão.

## Plano concreto quando o acesso estiver habilitado

1. Conferir cabeça remota e preservar commits posteriores; validar novamente integridade dos arquivos já gerados.
2. Reconfirmar private=true, já obtido após alteração manual do proprietário; não repetir a mudança de visibilidade.
3. Criar pré-release m0.1-android-test-2858a75, target exato2858a75b8742b3cf63d81293f7728d32647674b3, com o ZIP e SHA256SUMS.txt. Não usar main como fonte do APK e não declarar M0.1 aprovado.
4. Baixar novamente o asset enviado e conferir SHA-256 do ZIP e do APK interno; só então fornecer o link real ao proprietário.
5. Preservar as releases de teste anteriores. O download privado exigirá login GitHub com acesso ao repositório.

Não é necessário Dropbox para o canal escolhido pelo proprietário. Nenhuma nova autorização de privacidade/release precisa ser solicitada: falta acesso técnico à API. Se a configuração de rede mudar, consultar a configuração aplicada antes de repetir; não efetuar tentativas indefinidas sob a mesma negativa.

## Motivo da restrição anterior

Os prompts anteriores incluíam “sem publicar jogo ou release”. O texto não registra justificativa técnica; foi tratado como limite de escopo para não distribuir/publicar prematuramente durante a revisão do M0.1. A intenção aparente era manter implementação/revisão separadas de publicação, não proibir Releases como mecanismo de teste. A nova instrução permite uma release de teste depois de confirmar o repositório privado, sem equivaler a publicação em loja ou aceite do jogo.

[Relatório do APK](M0_1_LOCAL_APK_2858A75_REPORT.md) mantém evidências da compilação. O Android físico desse binário continua NOT_RUN; o APK antigo60f2491 permanece OWNER_REPORTED FAIL visual. Assinatura debug nova diferente, com aviso de perda de save se o proprietário optar por desinstalar o antigo. Sem mudanças de código/runtime nesta atualização: verificações documentais, integridade do pacote e diff pertinentes.


## Continuação após privatização manual

Confirmação pela integração autenticada: private=true e visibility=private. Tentativa de criar rascunho de pré-release com o ZIP e checksum no alvo2858a75:

```bash
gh release create m0.1-android-test-2858a75 build/Vila_de_Bolso_M0_1_2858a75_Android.zip build/private_release/SHA256SUMS.txt --repo projetoscodex-nuvem/vila-de-bolso --target 2858a75b8742b3cf63d81293f7728d32647674b3 --title 'M0.1 Android — teste 2858a75' --notes-file build/private_release/NOTAS_RELEASE.md --draft --prerelease
```

Resultado: `Post "https://api.github.com/repos/projetoscodex-nuvem/vila-de-bolso/releases": Forbidden`. Consulta posterior pela integração: zero releases. Logo nenhum rascunho/upload/link foi criado. Falta habilitar api.github.com e uploads.github.com na política aplicada do ambiente, mantendo o proxy/CA; usuário recebeu os dois domínios exatos. Conexão GitHub App com admin continua funcional para leitura/conteúdo; não confundir com autenticação/rede da CLI. Assim que houver acesso: criar rascunho privado, enviar/verificar assets baixados, então publicar como pré-release privada, sem merge ou CI.


## Após confirmação de publicação do ambiente

OWNER_REPORTED confirmou que salvou e publicou os domínios corretamente; screenshots mostram api.github.com e uploads.github.com. Mesmo depois, ambiente desta conversa continua na revisão4 aplicada/enforced, custom_allowed_hosts=[] e gh api user retorna Forbidden. Não pedir ao proprietário para repetir publicação/seleção/privatização: a alteração publicada não está refletida na execução vinculada. O mecanismo exato da plataforma não foi diagnosticado, e as ferramentas aqui não editam/revinculam a instância. Próximo passo: nova execução selecionando o ambiente publicado; conferir política aplicada/autenticação e retomar release privada já autorizada. Não excluir o ambiente/conversa atual que preserva o ZIP; se a nova execução não encontrar os artefatos, o desenvolvedor deve recuperar/regerar a partir do fonte2858a75 com hashes/versões fixados e registrar a nova origem/hash, sem fingir reutilização.

[Evidência resumida e integridade preservada](evidence/M0_1_RUNTIME_AFTER_ENV_PUBLISH.json). A seleção github-1439079463 corresponde ao ID real do Vila de Bolso, e a integração autenticada lê o repositório privado com admin. Nome genérico não demonstra vínculo quebrado. O bloqueio observado é anterior à autenticação GitHub da CLI. Metadados de diagnóstico retido consultados: nenhum registro disponível; isso não estabelece saúde nem altera o diagnóstico dos probes.
