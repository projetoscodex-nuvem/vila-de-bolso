# M0.1 — Novo APK gerado pelo desenvolvedor neste ambiente

03/11/2026 (UTC). **APK_VERIFIED_DELIVERY_BLOCKED**, sem aceite de M0.1. PR #2 permanece draft/sem merge, sem CI, release, M1 ou alteração de D026.

## Responsabilidade e ambiente

O desenvolvedor retomou e concluiu a exportação aqui; não é necessário encaminhar a compilação ao ChatGPT Work/proprietário. Esses continuam responsáveis por análise/revisão e teste físico. O encaminhamento anterior ao outro executor foi prematuro: o EPERM era do escopo padrão do processo. A opção suportada do comando `sandbox_permissions=with_additional_permissions` com `additional_permissions.network.enabled=true` permitiu o acesso HTTPS aos hosts oficiais. Não houve alteração da política global, remoção de proxy/CA ou uso de CI.

Depois dos downloads com hash conferido, sdkmanager falhou ao usar cache em /home/agent/.android/cache, fora das raízes graváveis; o log verbose mostrou NoSuchFileException. A execução passou com ANDROID_USER_HOME dentro de .tools e proxy herdado explícito nas propriedades JVM, mantendo HOME e truststore do host. JDK/templates/command-line tools foram reutilizados após cada diagnóstico, sem repetir seus downloads. [Ambiente, versões e hashes oficiais observados](evidence/M0_1_LOCAL_ANDROID_ENVIRONMENT.json). O EPERM e as tentativas anteriores permanecem históricos, sem confundir permissão GitHub com rede do processo.

## Origem e artefato real

- Fonte exata: **2858a75b8742b3cf63d81293f7728d32647674b3**.
- Árvore: **9590bdffc83ad3968a48365a67ce8bdd694f4939**. Checkout conferido limpo antes e depois da exportação; nenhum recurso/preset modificado para gerar o binário.
- Tentativa: **20261103T033447825235Z-e21f9e15**.
- APK: **Vila_de_Bolso_M0_1_2858a75.apk**, 56.448.943 bytes.
- SHA-256: **6a6dbeaa9c6f20c9cf8b4c8ce331afa51870d12d2b91585007908c6883f21a73**.
- ZIP de entrega: **Vila_de_Bolso_M0_1_2858a75_Android.zip**, com APK, SHA256SUMS.txt, ORIGEM.json e LEIA_ANTES_DE_INSTALAR.txt.

Arquivos fora do Git em build/delivery_2858a75/ e build/Vila_de_Bolso_M0_1_2858a75_Android.zip. Os links internos apresentados na resposta falharam no aplicativo Android do proprietário; não constituem upload/anexo nem entrega confirmada. Não foi criada URL pública, release ou workflow. APK, SDK e keystore não foram comitados. O commit posterior deste relatório contém apenas documentos/evidências e não muda a origem do binário.

## Verificações realmente executadas

Godot 4.6.3/GDScript/Compatibility, Android retrato/offline, min/target herdados do template, Gradle falso e ETC2/ASTC mantidos. JDK 21.0.9+10, Platform-Tools 37.0.1, Build-Tools 36.1.0, Platform 36. SHA-256 de JDK/templates/command-line tools comparados ao lock antes de instalar e novamente ao registrar a evidência; propriedades instaladas conferidas.

PASS no commit fonte limpo: **40 testes Python, 163 checks Godot, 44 Input sintéticos, 15 casos de pacote**, smoke 15 frames, proveniência/links/parâmetros e diff. [Log](evidence/M0_1_LOCAL_APK_2858A75_TESTS.txt). Os avisos de fixture/não-APK nesse log pertencem à suíte anterior à exportação; não são a classificação do novo APK real.

PASS da exportação real: Godot/wrapper/runtime_validation/apksigner retornaram zero. O gate abriu **os assets do próprio APK**, por --main-pack, em diretório temporário sem recursos da fonte; configuração inicial, seis scripts carregáveis, remaps/alvos compilados, cena e menu/botões visíveis na árvore UI headless passaram. Os cinco scripts antes ausentes estão presentes como .gdc e .gd.remap, além de main. Cena binária/remap presentes, CRC válido, world.json idêntico à fonte, exclusões de testes/ferramentas/relatórios/referências preservadas.

PASS da conferência independente do resultado do wrapper: assinatura debug v2/v3, manifesto **minSdk 24/targetSdk 36/compileSdk 36**, ARMv7/ARM64, nenhuma uses-permission listada, bytes/hash da cópia de entrega iguais ao APK gerado. Evidências: [resultado por tentativa](evidence/M0_1_LOCAL_APK_2858A75_RESULT.json), [inventário e verificação](evidence/M0_1_LOCAL_APK_2858A75_VERIFICATION.json), [log de exportação/runtime](evidence/M0_1_LOCAL_APK_2858A75_EXPORT.txt), [assinatura](evidence/M0_1_LOCAL_APK_2858A75_SIGNATURE.txt), [manifesto](evidence/M0_1_LOCAL_APK_2858A75_MANIFEST.txt).

O log de exportação versionado normaliza apenas finais de linha e espaços finais para git diff --check; o original integral permanece em build/export_android.log. Resultados, mensagens e códigos não foram alterados.

## Comandos e reprodução do ambiente

Usar o fonte exato e checkout limpo, o proxy/CA herdados e permissão adicional de rede no comando do executor. Não desligar o sandbox global nem remover proxy. Configuração necessária neste ambiente, sem modificar HOME:

```bash
source scripts/env.sh
export ANDROID_USER_HOME="$VILA_ROOT/.tools/android-user"
mkdir -p "$ANDROID_USER_HOME/cache"
```

Para o setup, a JVM recebeu http.proxyHost/http.proxyPort e https.proxyHost/https.proxyPort derivados do proxy HTTP herdado (hostname/porta; sem credenciais na URL); scripts/setup.py manteve seu truststore Java do host. Executar scripts/setup.sh --android com essas propriedades JAVA_TOOL_OPTIONS e a permissão de rede. Não usar --update nem alterar lock/versões. Em seguida, ainda com ANDROID_USER_HOME local:

```bash
git rev-parse HEAD
git status --porcelain
scripts/verify.sh
scripts/export_android.sh
"$ANDROID_SDK_ROOT/build-tools/36.1.0/apksigner" verify --verbose --print-certs build/vila-de-bolso-m0.1-debug.apk
"$ANDROID_SDK_ROOT/build-tools/36.1.0/aapt" dump badging build/vila-de-bolso-m0.1-debug.apk
"$ANDROID_SDK_ROOT/build-tools/36.1.0/aapt" dump permissions build/vila-de-bolso-m0.1-debug.apk
sha256sum build/vila-de-bolso-m0.1-debug.apk
```

O setup instalado não prova persistência em outra tarefa/VM. A chave debug deste ambiente deve ser preservada fora do Git para futuras atualizações de teste. Fonte, logs e evidências estão no GitHub; binário de teste é entregue separadamente.

## Instalação e teste do proprietário

**A chave antiga não está disponível aqui.** O certificado deste APK é e4f74a38b259831ca9131eb795dd66266c60881ac607cbf5e7b49b060fae345b, diferente do certificado antigo d67f6b09fa149061f7a78faca5f3b8991e35d3751b9bcfcc57930081e7743576. O package continua org.projetoscodex.viladebolso.m01 e versionCode1: o Android normalmente recusa atualizar por cima de uma assinatura diferente. Desinstalar o antigo **apaga seu save local de exploração/câmeras**. Só fazer isso se aceitar perder esses dados de teste; para preservá-los, informar o bloqueio antes de desinstalar. Não alegar que o APK antigo contém sua chave privada recuperável.

1. Baixar o APK (ou extrair o ZIP), ler o aviso acima e abrir o arquivo no Android. Se solicitado, permitir instalação para o aplicativo usado para abrir o arquivo.
2. Abrir offline e verificar primeiro título/menu e Explorar reino. Informar modelo/versão Android e PASS/FAIL.
3. Se o menu aparecer, testar Explorar → Planície → Entrar → Voltar, arrasto/pinça/zoom/HUD e fechar/reabrir/Retomar.
4. Se continuar tela clara ou ocorrer crash, precisamos do logcat de abertura, passos e origem/hash deste APK.

**Novo APK: Android físico NOT_RUN até o relato.** O APK antigo60f2491 continua com inicialização visual OWNER_REPORTED FAIL. O headless do APK novo comprova carregamento/layout da UI, não pixels/GPU/toque no aparelho nem a causa completa do sintoma anterior. Não marcar M0.1 como aprovado, iniciar M1 ou resolver D026 nesta entrega.


## Falha de download —03/11/2026 UTC

OWNER_REPORTED: links internos de APK e ZIP falharam no aplicativo Android ("Não foi possível abrir o arquivo"). Arquivos locais conferidos, com o mesmo SHA-256; isso é falha de entrega, não um novo teste de execução do jogo. Não há anexo binário confirmado nesta sessão. Um canal privado de arquivos precisa ser conectado; Dropbox foi sugerido e ainda não está conectado. Não repetir os caminhos internos como links de download, não recompilar o mesmo APK para corrigir transporte e não publicar release/CI por inferência. Fonte2858a75 e novo Android físico NOT_RUN preservados.

O novo cálculo de integridade confirmou56.448.943 bytes e SHA-2566a6dbeaa9c6f20c9cf8b4c8ce331afa51870d12d2b91585007908c6883f21a73. Nenhum byte do APK/ZIP foi alterado para esta correção documental. A sessão não dispõe de ferramenta nativa para anexar arquivos; as ferramentas de repositório conectadas não oferecem upload de binários. Não usar uma URL/caminho inventado ou um serviço público para contornar os limites de publicação. A proposta Dropbox permite buscar transferência privada após conexão e confirmação de suas ferramentas; sugestão não equivale a instalação, conexão ou upload.

Verificações desta atualização: integridade/tamanho locais, links/proveniência/parâmetros via scripts/check_documents.py e git diff --check. Sem mudança em código/runtime, logo os testes do APK fonte2858a75 permanecem históricos, sem alegar nova execução Android ou aprovação.
