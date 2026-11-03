# M0.1 — APK de teste gerado

**Continuação local em03/11/2026 UTC:** novo APK real do fonte2858a75 gerado pelo desenvolvedor neste ambiente, com checkout limpo, gate de runtime, assinatura e manifesto PASS. [Relatório atual](M0_1_LOCAL_APK_2858A75_REPORT.md). Os BLOCKED/READY/FAIL abaixo pertencem aos snapshots/artefatos históricos descritos; novo Android físico NOT_RUN.

**Atualização de 03/11/2026 UTC:** o proprietário instalou o APK60f2491 e relatou tela clara/sem menu: inicialização visual **FAIL**, demais físicos **NOT_RUN**. O READY_FOR_OWNER_SMOKE e os PASS de build abaixo são históricos. Ver [correção de inicialização/empacotamento](M0_1_STARTUP_FIX_REPORT.md); novo APK ainda não produzido neste processo. Resultados/logs históricos preservados.

Data: 02/11/2026 (America/Sao_Paulo). Estado: **READY_FOR_OWNER_SMOKE**. M0.1 ainda aguarda teste físico e aceite; M1 não iniciado.

## DECISÃO E IMPLEMENTAÇÃO

Continuação autorizada pelo proprietário após revisão de e3bc175. Correção salva no commit **60f2491f1a04001d4903d6e8d12c519df6bafd1b**, na mesma branch feat/m0-1-foundation / PR #2, sem merge. Somente três valores de configuração alterados: overrides min_sdk/target_sdk vazios no preset sem Gradle e import_etc2_astc=true na seção rendering do projeto. O template oficial mantém minSdk 24/targetSdk 36; lock, engine, dados, regras e D026 não mudaram. Verificador documental atualizado e seis checks Godot acrescentados para a configuração de exportação.

A toolchain foi instalada neste executor com scripts/setup.sh --android, mantendo URLs/hashes/versões do lock. Não houve liberação ou alteração de política do sandbox anterior; seu EPERM continua como evidência histórica de outro processo. Não foi ativado CI, release, publicação ou merge. Esta instalação não comprova setup persistente do ambiente Codex Cloud.

## TESTE EXECUTADO

A árvore do commit acima foi conferida limpa antes da exportação. Comandos:

```bash
scripts/setup.sh --android
scripts/verify.sh
scripts/export_android.sh
source scripts/env.sh
"$ANDROID_SDK_ROOT/build-tools/36.1.0/apksigner" verify --verbose --print-certs build/vila-de-bolso-m0.1-debug.apk
"$ANDROID_SDK_ROOT/build-tools/36.1.0/aapt" dump badging build/vila-de-bolso-m0.1-debug.apk
git diff --check
```

PASS: 163 checks Godot de componentes/configuração/cena, 44 regressões pelo fluxo Input e 25 testes Python. Os seis checks novos validam o preset pelo ConfigFile da engine, Gradle desativado, herança dos níveis SDK, importação Android e ausência de permissão Internet. PASS: smoke headless de 15 frames, proveniência, sintaxe e links. Fixtures Python continuam sendo dados simulados, sem representar APKs reais.

PASS: exportação real pela Godot 4.6.3 com retorno zero; wrapper zero e apksigner zero. Tentativa 20261103T023147601253Z-2b9cac94. Início UTC 2026-11-03T02:31:47.601469+00:00; fim UTC 2026-11-03T02:32:22.077362+00:00. Exportação ocorreu em 02/11/2026 no fuso America/Sao_Paulo. O aviso do adb sem daemon/dispositivo conectado foi preservado no log e não impediu exportação ou assinatura. Instalação em aparelho não foi executada.

## ARTEFATO VALIDADO

- Arquivo: vila-de-bolso-m0.1-debug.apk
- Bytes: 56427508
- SHA-256: `fb7abe176c9d96eef0131a6a654e06e77ff645fce7dbd96e9a7029a9da0307d7`
- Package: org.projetoscodex.viladebolso.m01
- versionName 0.0.1-m0.1; versionCode 1
- minSdk 24; targetSdk/compileSdk 36
- ARM64 e ARMv7; assinatura debug v2/v3 válidas
- Nenhuma uses-permission listada pelo aapt
- CRC válido; assets/data/world.json idêntico aos dados do commit; documentação/testes/referências fora do APK

Evidências textuais: [resultado](evidence/M0_1_ANDROID_BUILD_RESULT.json), [manifesto e assinatura](evidence/M0_1_ANDROID_VERIFICATION.txt), [testes](evidence/M0_1_ANDROID_BUILD_TESTS.txt). APK/SDK/cache/chave debug não foram comitados. O pacote de teste entregue na conversa é Vila_de_Bolso_M0_1_60f2491_Android.zip; não é uma release pública. O commit posterior de evidências contém somente documentação/logs e não é a origem do binário: a origem é o commit 60f2491f1a04001d4903d6e8d12c519df6bafd1b.

## PENDÊNCIA — TESTE NO ANDROID

1. Baixar o ZIP, extrair e abrir o APK. Informar modelo do aparelho e versão Android. Se o Android pedir, permitir a instalação para o aplicativo usado para abrir esse arquivo. Não substituir/desinstalar outro aplicativo diante de erro de assinatura sem informar o ocorrido.
2. Abrir offline → Explorar reino. Arrastar nos dois eixos e usar pinça, +/−, Recentrar e Visão geral. A HUD deve ficar fixa; existem partes fora do recorte; cinco regiões continuam bloqueadas.
3. Selecionar Planície → Entrar. Repetir navegação e selecionar célula fora do recorte inicial. Pan/pinça/HUD não podem selecionar por engano. Não há construção, score ou partida neste marco; a arte é geométrica provisória.
4. Voltar ao reino e conferir sua câmera; retornar à fase; fechar/reabrir e Retomar exploração. Conferir restauração e ausência de seleção/gesto pendente. Testar Voltar e interromper durante gesto.
5. Enviar PASS/FAIL e passos de qualquer defeito, incluindo textos cortados, toque, pinça, saltos, crashes e perda de estado.

Android físico, áreas seguras, legibilidade, offline no aparelho, desempenho e aceite: **NOT_RUN**. Não declarar M0.1 aprovado nem iniciar M1 antes do resultado e revisão. D026 continua pendente para M1/M2. Mudança futura da chave debug pode impedir atualização do pacote de teste; não pedir desinstalação que apague dados sem aviso.
