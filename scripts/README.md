# Executar a fundação M0.1

Alvo fixado: Linux x86_64, Godot 4.6.3/GDScript/Compatibility. Versões, URLs e SHA-256 oficiais em [toolchain.lock.json](toolchain.lock.json). Não é necessário instalar Godot no celular.

## Ambiente de desenvolvimento

Na raiz do repositório:

```bash
scripts/setup.sh
scripts/verify.sh
source scripts/env.sh
"$GODOT_BIN" --path .
```

O setup reutiliza somente uma Godot cuja versão corresponda exatamente ao lock; se ausente, baixa o ZIP oficial e verifica seu hash. Ferramentas, configurações, cache e saves de desenvolvimento ficam em .tools. Não altera HOME nem remove proxy/CA do ambiente. A instalação desta tarefa não prova setup reutilizável: em um ambiente Cloud novo, configurar `scripts/setup.sh` como comando de setup somente após revisão e então republicar/testar uma nova tarefa. A validação usa um save de testes isolado do save normal.

## Android debug

Com rede autorizada para GitHub/releases, release-assets e dl.google.com, e pelo menos 4 GB livres:

```bash
scripts/setup.sh --android
scripts/verify.sh
scripts/export_android.sh
```

O setup fixa Temurin JDK 21.0.9+10, command-line tools pelo arquivo 15859902 e hash oficial, Platform-Tools 37.0.1, Platform 36 e Build-Tools 36.1.0. O sdkmanager recebe os IDs explícitos do lock; uma revisão divergente de Platform-Tools causa BLOCKED, sem atualizar o lock automaticamente. Não instala Android Studio, emulador, NDK, CMake ou Gradle: esta prova usa o APK pré-compilado oficial com exportação padrão de GDScript. Todas as opções de build Gradle ficam desativadas.

A documentação Godot 4.6 recomenda JDK 17 e aceita versões superiores. O source da release 4.6.3 fixa minSdk 24/targetSdk 36/Build-Tools 36.1.0; esses valores prevalecem sobre os números 35 da página geral 4.6. JDK 21 é usado pelo instalador para compatibilidade com as ferramentas atuais; o JRE 21.0.12.1 do host não é tratado como JDK completo. A instalação Android desta tarefa ficou bloqueada; consulte o relatório antes de alegar repetibilidade dessa etapa.

Resultado esperado quando a toolchain estiver disponível: build/vila-de-bolso-m0.1-debug.apk, build/export_result.json (status, comando, hash real) e build/export_android.log. O script realmente chama Godot --export-debug e só anuncia PASS se existir um APK ZIP válido com dados/manifesto e assinatura verificada pelo apksigner. Falha de exportação retorna código 2 no script e registra BLOCKED; não fornece hash fictício. Um APK anterior, se existente, é preservado como build/previous-debug.apk.

Keystore debug é criado em .tools/debug.keystore, com identidade Android Debug padrão, fora do Git; nunca usar essa chave para release. Preservá-lo em um ambiente apropriado permite atualizar o mesmo pacote de teste. Mudança de chave pode impedir atualizar um APK já instalado; não pedir desinstalação que apague progresso sem avisar. O identificador org.projetoscodex.viladebolso.m01 é provisório e exclusivo desta prova.

A exportação só inclui a cena principal, dependências, dados JSON e avisos de licença; exclui documentação, ZIP de transporte, referências históricas, ferramentas e testes. Nenhuma permissão de internet ou armazenamento externo foi solicitada. Não há publicação de release nem workflow automático de CI nesta entrega.

## Verificações e evidências

`verify.sh` executa sete testes Python dos limites do instalador (sem rede), importação, suíte Godot, 15 frames da cena principal, proveniência/documentação e git diff --check. Logs integrais ficam em build/installer_tests.log, build/import.log, build/tests.log e build/smoke.log. O verificador exige o marcador final de sucesso e rejeita erros de script mesmo se Godot sair com código zero. Somente os dois diagnósticos específicos de listeners TCP do editor indisponíveis no sandbox são classificados separadamente como limitação de infraestrutura; não são escondidos dos logs.

`check_documents.py` preserva ZIP, manifesto, PNGs e o relatório histórico de importação, confere links e parâmetros e reconhece a árvore de implementação. O verificador antigo continua no relatório histórico e deve ser executado apenas no snapshot documental correspondente, nunca como critério de “30 arquivos/sem Godot” para M0.1.

O smoke físico e os limites atuais estão em [reports/M0_1_REPORT.md](../reports/M0_1_REPORT.md). Testes headless/sintéticos não validam toque, legibilidade, pinça real ou desempenho no aparelho.
