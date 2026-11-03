# Passagem de contexto — entrega M0.1

03/11/2026, America/Sao_Paulo. **APK_VALIDATED / DELIVERY_BLOCKED / ANDROID_PHYSICAL_NOT_RUN**.

## Leia primeiro

[Retomada atual: autenticar, recuperar ou gerar e enviar na mesma execução](reports/M0_1_DELIVERY_RESUME.md). Este documento substitui as instruções antigas de retornar indefinidamente à execução original por falta de ZIP. Não pedir recompilação ao proprietário ou ao ChatGPT Work: o desenvolvedor executa a geração. O proprietário apenas autoriza acesso seguro e faz o teste físico.

## Git e produto

Repo projetoscodex-nuvem/vila-de-bolso, PR#2 draft/sem merge, branch feat/m0-1-foundation. Ler AGENTS/PROJECT_CONTEXT/PROJECT_STATE e conferir cabeça remota; preservar posteriores. Fonte do APK corrigido2858a75b8742b3cf63d81293f7728d32647674b3; commits posteriores até esta retomada são documentação. Não usar main para exportar a implementação.

Godot4.6.3/GDScript/Compatibility, Android retrato/offline, SDKs herdados, Gradle falso, ETC2/ASTC; lock24/36 intacto. Reino40×60/fase20×20, câmeras/gestos/HUD/seleção/save mínimo; 60 colocações/62 ofertas futuras. Sem partida completa, M1, CI ou alteração de D026.

## Artefatos e evidências

- APK defeituoso60f2491, SHAfb7abe17…0307d7: proprietário instalou e relatou tela clara sem menu (FAIL); demais físicos NOT_RUN.
- Correção2858a75: resources explícitos, cinco preloads antes ausentes agora presentes, gate real de APK isolado da fonte antes de PASS/hash. [Relatório de correção](reports/M0_1_STARTUP_FIX_REPORT.md).
- Build real original2858a75: APK56.448.943 bytes, SHA-2566a6dbeaa9c6f20c9cf8b4c8ce331afa51870d12d2b91585007908c6883f21a73; ZIP56.451.737 bytes, SHA-256b34eb6f00260230e3b584c2f9b7867bb4503f4d3dcd4e5e5942ef1a871050064. Arquivos preservados em build/delivery_2858a75/ e build/Vila_de_Bolso_M0_1_2858a75_Android.zip na execução original; não garantidos em outra sessão. [Resultado real](reports/M0_1_LOCAL_APK_2858A75_REPORT.md).
- PASS original:40 Python/163 Godot/44 Input sintéticos/15 pacote e smoke15frames; exportação/runtime APK/assinatura v2/v3/manifesto24/36/compile36/CRC/dados/hashes. Físico do novo APK NOT_RUN.

## Estado de acesso atual

O proprietário tornou privado e depois voltou a público para teste do painel. A última API confirma **PUBLIC**; não usar as consultas históricas PRIVATE como estado atual. A entrega privada foi autorizada: conferir a visibilidade e cumprir a condição antes de publicar assets.

Execução original:revisão4, hosts ausentes, API Forbidden; guarda ZIP íntegro. O proprietário publicou domínios corretos, mas essa instância não os adotou. Retorno OWNER_REPORTED de nova execução:releases HTTP200, /user401 e gh sem autenticação, ZIP não encontrado. São observações de sessões diferentes. Não repetir publicação dos domínios se a rede efetivamente responde; resolver autenticação segura na sessão com rede.

## Próximo passo concreto

Na execução com rede, iniciar autorização oficial da CLI se confirmado que está sem login; pedir ao proprietário apenas consentimento no navegador, nunca token no chat. Reutilizar arquivo verificável se disponível; **se ausente, gerar novo build do fonte corrigido2858a75**, com toolchain fixada, testes/gate e novo hash/origem reais. Não reutilizar60f2491 nem atribuir ao novo build a assinatura/hash do artefato original. Gerar/enviar/validar download numa única execução, sem devolver a tarefa à original inacessível.

Rascunho de pré-release → upload ZIP/checksum → baixar/conferir → publicar com privacidade confirmada. Registrar relatório, PROJECT_STATE, CHANGELOG, HANDOFF e PR. Não considerar os links internos antigos como entrega. Assinatura debug diferente impede atualização e desinstalar perde save; aviso obrigatório, sem inferir consentimento. Sem merge/CI/M1/aceite; D026 pendente.
