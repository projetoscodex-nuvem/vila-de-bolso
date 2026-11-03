# Passagem de contexto — entrega M0.1

03/11/2026, America/Sao_Paulo. **APK_AVAILABLE_FOR_OWNER_SMOKE / OWNER_DOWNLOAD_NOT_CONFIRMED / ANDROID_PHYSICAL_NOT_RUN**.

## Estado vigente

Leia AGENTS.md, PROJECT_CONTEXT.md, PROJECT_STATE.md e [relatório do build disponibilizado](reports/M0_1_WORK_APK_20261103_REPORT.md). Branch feat/m0-1-foundation, PR#2 draft/sem merge. Nenhum código alterado nesta retomada; source APK2858a75, commits posteriores documentais. Sem CI/M1/alteração de D026; fase20×20/reino40×60.

## Nova entrega

ZIP `Vila_de_Bolso_M0_1_2858a75_20261103T204216Z_Android.zip` salvo como arquivo persistente para download na conversa. SHA-256 ZIP `60df741d5c83fb55f6555d0a03dd35fb2b45923dbec319df576a27a651537e1b`; APK `85c1f2303322f3faed22d350d31d3773036cfad4888961aa841484e3647b257e`, 56448943 bytes. Origem `2858a75b8742b3cf63d81293f7728d32647674b3`, árvore `9590bdffc83ad3968a48365a67ce8bdd694f4939`, tentativa `20261103T204216978135Z-7bb9067c`. Este hash é da reconstrução atual, diferente do APK original2858a75 e do defeituoso60f2491. Não reutilizar o último para teste da correção.

PASS:40 Python/163 Godot/44 Input/15 casos de pacote, smoke, proveniência; APK real com seis scripts/remaps, cena/menu headless isolados, assinatura v2/v3, CRC, manifesto24/36/compile36, ARMv7/ARM64 e sem permissões. Físico NOT_RUN; M0.1 sem aceite.

## Próximo passo

Proprietário baixar/extrair e abrir offline; conferir primeiro o menu, informar aparelho/Android/PASS-FAIL. Se passar, roteiro de gestos/navegação/HUD/persistência no pacote. Se falhar, coletar logcat/origem/hash. Assinatura nova pode impedir atualização; desinstalar apaga save local, sem inferir consentimento.

Transferência para download confirmada, download/instalação do proprietário ainda não confirmados. Proprietário propôs fazer upload manual em Releases; isso ainda não ocorreu e requer confirmar privacidade antes de publicar. Não iniciar upload/merge/CI/M1 automaticamente.

## Rede e continuidade

Nesta retomada api.github.com/meta e uploads.github.com responderam200; gh permaneceu sem autenticação. O controle Work foi mostrado ativo pelo proprietário. Não tratar bloqueios antigos de outra execução como atuais, nem confundir login do navegador com CLI. Foi possível instalar ferramentas fixadas e exportar sem mudar HOME/proxy/CA. Nenhuma nova autenticação ou release GitHub realizada.

[Plano anterior](reports/M0_1_DELIVERY_RESUME.md) e [build original](reports/M0_1_LOCAL_APK_2858A75_REPORT.md) preservados como históricos; a entrega vigente é esta reconstrução. Não pedir retorno à execução antiga quando o novo arquivo já está disponível na conversa.
