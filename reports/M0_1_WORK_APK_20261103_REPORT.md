# M0.1 — APK reconstruído e disponibilizado para teste

03/11/2026, America/Sao_Paulo. **APK_AVAILABLE_FOR_OWNER_SMOKE / OWNER_DOWNLOAD_NOT_CONFIRMED / ANDROID_PHYSICAL_NOT_RUN**.

## DECISÃO

O proprietário autorizou gerar outro APK do fonte corrigido2858a75 quando o ZIP original estivesse inacessível e propôs baixar o ZIP para fazer o upload manual no GitHub. Nesta execução o pacote original não estava disponível. Foi reconstruído o commit exato, sem alterar código, engine, lock, gameplay, D026, M1 ou CI. PR#2 continua draft e sem merge.

## IMPLEMENTAÇÃO E ORIGEM

- Fonte: `2858a75b8742b3cf63d81293f7728d32647674b3`; árvore `9590bdffc83ad3968a48365a67ce8bdd694f4939`; checkout isolado limpo antes/depois.
- Tentativa: `20261103T204216978135Z-7bb9067c`; início `2026-11-03T20:42:16.978586+00:00`; fim `2026-11-03T20:42:34.342907+00:00`.
- APK: `Vila_de_Bolso_M0_1_2858a75_20261103T204216Z.apk`, 56448943 bytes; SHA-256 `85c1f2303322f3faed22d350d31d3773036cfad4888961aa841484e3647b257e`.
- ZIP: `Vila_de_Bolso_M0_1_2858a75_20261103T204216Z_Android.zip`, 56452178 bytes; SHA-256 `60df741d5c83fb55f6555d0a03dd35fb2b45923dbec319df576a27a651537e1b`.
- Certificado SHA-256 `58f9e649a756d4d469755c4e938003a7b98a6fea4db51088220690cffea7055f`.
- ZIP contém APK, SHA256SUMS.txt, ORIGEM_BUILD.json e LEIA_ANTES_DE_INSTALAR.md. Arquivo persistente disponibilizado na conversa; ainda não há confirmação de download pelo proprietário. Nenhum APK, chave privada, SDK ou credencial adicionado ao Git.

Este é um novo build; os hashes6a6dbeaa… do APK original2858a75 e fb7abe17… do APK defeituoso60f2491 continuam históricos. Não atribuir a esta reconstrução os certificados desses builds.

## TESTE E VALIDAÇÃO

PASS real: 40 testes Python, 163 checks Godot, 44 Input sintéticos, smoke15frames, 15 casos de pacote, proveniência27 hashes, parâmetros e diff. Os ZIP/PCK reais são distinguidos das mutações/wrapper simulados. Novo APK real: Godot/wrapper/runtime_validation/apksigner zero; CRC, world.json igual à fonte, seis scripts/remaps presentes, cena/menu headless carregados dos assets do próprio APK fora da fonte, assinatura v2/v3, min24/target36/compile36, ARMv7/ARM64 e nenhuma uses-permission. Não comprova renderização/GPU/toque Android.

Evidências: [resultado da exportação](evidence/M0_1_WORK_APK_20261103_RESULT.json), [inventário/hash/origem](evidence/M0_1_WORK_APK_20261103_VERIFICATION.json), [testes, assinatura e manifesto](evidence/M0_1_WORK_APK_20261103_CHECKS.txt).

## REDE E ENTREGA

O proprietário enviou screenshot com Acesso do Work à rede ativado. O teste desta retomada respondeu HTTP200 em api.github.com/meta e uploads.github.com. Isso confirma alcance HTTP nesta observação; revisão da política não disponível em /etc/codex/network-policy.json. A CLI gh continuou sem autenticação configurada; não houve nova tentativa de login nem uso de tokens do plugin. A rede liberada permitiu instalar JDK/SDK/templates do lock e gerar este APK, preservando proxy/CA/HOME e usando ANDROID_USER_HOME privado em .tools.

A transferência do ZIP para download na conversa foi confirmada pelo serviço de arquivos; não é release no GitHub nem download/instalação do proprietário. Upload GitHub manual proposto pelo proprietário continua pendente e condicionado a repositório privado. Não houve mudança de visibilidade, criação de release, upload GitHub, merge ou CI.

## PENDÊNCIA E PRÓXIMO PASSO

Proprietário baixar/extrair o ZIP e testar primeiro título/menu/Explorar reino offline. Informar modelo, versão Android e PASS/FAIL; se falhar, imagem e logcat da abertura. Se passar, testar reino→Planície→Entrar→Voltar, pan/pinça/zoom/HUD e fechar/reabrir/Retomar. Novo Android físico NOT_RUN; M0.1 sem aceite.

Assinatura diferente das anteriores pode impedir atualização sobre o app instalado. Desinstalar remove o save local de exploração/câmeras; só fazer se o proprietário aceitar perder esses dados. Chave privada fora do Git e do pacote.

## Reprodução

Usar checkout limpo2858a75, Godot4.6.3 e lock existentes. Setup desta execução: scripts/setup.py --android, com ANDROID_USER_HOME local e propriedades de proxy JVM derivadas do proxy herdado, CA do host preservada. Verificações: scripts/verify.sh; scripts/export_android.sh; apksigner verify --verbose --print-certs; aapt dump badging/permissions; CRC e SHA-256. Logs originais em build/ do checkout de build. Documentação posterior não muda a origem2858a75 do APK.
