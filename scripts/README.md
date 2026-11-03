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

A documentação Godot 4.6 recomenda JDK 17 e aceita versões superiores. O source da release 4.6.3 fixa minSdk 24/targetSdk 36/Build-Tools 36.1.0; esses valores prevalecem sobre os números 35 da página geral 4.6. JDK 21 é usado pelo instalador para compatibilidade com as ferramentas atuais; o JRE 21.0.12.1 do host não é tratado como JDK completo. O bloqueio inicial de outro sandbox foi preservado como histórico. A instalação e exportação passaram no executor de continuação; consulte o [relatório atual](../reports/M0_1_ANDROID_BUILD_REPORT.md), sem presumir persistência da VM.

Resultado esperado quando a toolchain estiver disponível: build/vila-de-bolso-m0.1-debug.apk, build/export_result.json e build/export_android.log. Cada tentativa tem attempt_id e horários próprios e grava RUNNING antes de validar ferramentas. O resultado final é atualizado em finally também em erros de configuração/dependência, exportação, timeout, manifesto, CRC e assinatura; um PASS anterior nunca representa a tentativa atual. PASS e o hash atual só aparecem após verificar CRC/manifesto/dados, carregar dependências/cena/menu do APK em Godot isolada e verificar assinatura. Falha/timeout na etapa runtime_validation também atualiza o resultado e arquiva o artefato não verificado. Falhas retornam código 2 (ou 130 para interrupção) com FAIL/BLOCKED/CANCELLED, sem hash de APK atual.

Histórico, log e APK anteriores são preservados por tentativa em build/export_attempts/<attempt_id>/, com nomes previous_result.json, previous-export_android.log e previous-debug.apk. Um arquivo novo que falhou na validação fica como unverified-debug.apk nesse diretório, fora do caminho instalável atual. Arquivos antigos no caminho legado build/previous-debug.apk não são apagados. Todos esses binários e caches permanecem fora do Git.

Keystore debug é criado em .tools/debug.keystore, com identidade Android Debug padrão, fora do Git; nunca usar essa chave para release. Preservá-lo em um ambiente apropriado permite atualizar o mesmo pacote de teste. Mudança de chave pode impedir atualizar um APK já instalado; não pedir desinstalação que apague progresso sem avisar. O identificador org.projetoscodex.viladebolso.m01 é provisório e exclusivo desta prova.

A exportação usa resources com seleção explícita da cena principal, seis scripts e ícone, além de dados JSON e avisos de licença; exclui documentação, ZIP de transporte, referências históricas, ferramentas e testes. Nenhuma permissão de internet ou armazenamento externo foi solicitada. Não há publicação de release nem workflow automático de CI nesta entrega.

## Verificações e evidências

`verify.sh` executa 40 testes Python (sete do instalador, 21 do resultado de exportação e 12 de configuração Android, todos isolados/sem downloads), importação, os 163 checks de componentes/configuração Godot, 44 regressões do fluxo Input/GUI/gestos, 15 frames da cena principal, proveniência/documentação e git diff --check. A nova suíte usa Input.parse_input_event, sem chamar app._input nem emitir pressed para simular acessibilidade de botões; cobre menu, Entrar, Retomar, zoom, retorno, um/dois dedos, HUD e mouse físico. O projeto habilita mouse emulado para a GUI e o mapa ignora somente eventos DEVICE_ID_EMULATION. Esses testes continuam sintéticos; Android físico é NOT_RUN.

Logs integrais ficam em build/installer_tests.log, build/import.log, build/tests.log, build/input_pipeline.log e build/smoke.log. O verificador exige os dois marcadores Godot finais e rejeita erros de script mesmo se Godot sair com código zero. Somente os dois diagnósticos específicos de listeners TCP do editor indisponíveis no sandbox são classificados separadamente como limitação de infraestrutura; não são escondidos dos logs. Fixtures de exportação são ZIPs falsos em diretórios temporários com runner simulado; não são APKs nem prova de assinatura Android real.

`check_documents.py` preserva ZIP, manifesto, PNGs e o relatório histórico de importação, confere links e parâmetros e reconhece a árvore de implementação. O verificador antigo continua no relatório histórico e deve ser executado apenas no snapshot documental correspondente, nunca como critério de “30 arquivos/sem Godot” para M0.1.

O smoke físico e os limites atuais estão em [reports/M0_1_REPORT.md](../reports/M0_1_REPORT.md). Testes headless/sintéticos não validam toque, legibilidade, pinça real ou desempenho no aparelho.

## Diagnóstico de rede e alternativa

`python scripts/diagnose_network.py` distingue bloqueio de criação de socket do processo de bloqueios posteriores de proxy/DNS/TLS/HTTP, sem remover proxy, alterar política ou expor credenciais. Os hosts configurados como permitidos e o acesso do conector GitHub não comprovam download pelo processo. Na nova tentativa, socket(AF_INET) falhou com EPERM antes da conexão; setup/exportação reais foram repetidos e ficaram BLOCKED.

Uma [receita inativa de CI manual](../reports/ci/README.md) acompanha a entrega. Ela não foi ativada nem executada: permissões/limites de Actions, billing e armazenamento devem ser conferidos pelo proprietário antes de qualquer consumo. Não instalar o workflow no branch padrão ou dispará-lo por inferência nesta tarefa.

## Preset Android confirmado

Com Gradle desativado, min_sdk e target_sdk ficam vazios no preset e herdam os valores do template oficial (esperados no lock: 24/36). O projeto habilita rendering/textures/vram_compression/import_etc2_astc. A suíte verifica esses requisitos antes da exportação; conferir também os níveis no manifesto do APK concreto.


Validação adicional de configuração (03/11/2026 UTC): scripts/check_documents.py lê as seções efetivas e preserva case das chaves, exige overrides vazios/Gradle desativado/ETC2-ASTC em rendering e mantém expectativas 24/36 no lock. Dez regressões Python rejeitam overrides, Gradle ativado, ETC ausente/falso/em seção errada/somente em comentário e mudanças nos níveis esperados. As evidências de build em b89b16d são do executor externo e do código 60f2491; o processo desta verificação continua EPERM e não repetiu instalações nem reexportou o novo SHA.


## Gate de runtime exportado — correção da tela clara

OWNER_REPORTED: APK fonte 60f2491 abriu sem menu; inicialização visual FAIL. A revisão de empacotamento está no [relatório atual](../reports/M0_1_STARTUP_FIX_REPORT.md). O APK histórico assinado não foi validado fisicamente como funcional.

Com GODOT_BIN fixado pelo env.sh, execute `python3 tests/verify_runtime_export.py`: 15 casos incluem export real ZIP/PCK pelo preset Android e rejeição do filtro scenes anterior com cinco preloads ausentes. Os pacotes são carregados em bootstrap temporário sem recursos de runtime locais; .remap/.gdc/.scn são resolvidos pela própria engine. Mutações e wrapper de formato APK são fixtures de simulação; não representam build Android. verify.sh executa essa regressão e guarda logs em build/runtime_export/. O headless exige cena/menu/botões visíveis na árvore UI e dentro do viewport, sem comprovar renderização ou toque no Android.

O exportador chama automaticamente `python3 scripts/check_runtime_pack.py build/vila-de-bolso-m0.1-debug.apk --godot "$GODOT_BIN"` antes de assinatura/PASS. A mesma ferramenta aceita PCK/ZIP. Para APK, repacota somente assets/ sem consultar a fonte; paths inválidos/duplicados são rejeitados. Não exporta o próprio driver, testes, scripts de ferramentas, relatórios ou privados. Erros, ausência de marcador e timeout não podem deixar PASS/hash atual.

Rede local continua EPERM antes de proxy/DNS/TLS e toolchain Android ausente; nenhum novo APK nesta correção. O executor que já funcionou deve usar o commit final exato e checkout limpo, preservar chave debug, seguir os comandos do relatório, conferir manifesto 24/36/permissões, assinatura e novo SHA-256. Não renomear o APK antigo como artefato da correção; físicos restantes NOT_RUN, sem CI/merge/M1.
