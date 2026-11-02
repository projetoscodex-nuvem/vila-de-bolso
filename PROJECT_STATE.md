# Estado do projeto

Data: 01/11/2026 (UTC). Baseline: v0.2. Estado: **DOCUMENTATION_V0_2_IMPORTED — AJUSTES DA REVISÃO EXTERNA DOCUMENTADOS**.

## DECISÃO

Executar somente importação/reconciliação documental. M0.1 **NÃO INICIADO**; nenhuma instalação de engine autorizada nesta tarefa. Android offline em retrato; fases e reino maiores que o viewport, com arrasto/zoom e HUD fixa. Protótipo: fase 20 × 20, reino 40 × 60, seis regiões 2 × 3, 60 colocações e 62 ofertas. Números sujeitos a testes; requisito de câmera confirmado e obrigatório desde M0.1.

Revisão externa de 01/11/2026: somente esclarecer a função dos PNGs legados e registrar D026 como pendência de desfazer para M1/M2, sem escolher nova regra. D026 não bloqueia a fundação M0.1; este marco continua dependendo de nova tarefa explícita.

## IMPLEMENTAÇÃO

CONFIRMADO: repositório https://github.com/projetoscodex-nuvem/vila-de-bolso, público segundo API GitHub. Base inicial `work`, correspondente à `main` remota em `f1b59a2ab0f148abc71f0caf91a102a79e122cee`, com árvore limpa: README.md e PROJECT_CONTEXT.md v0.1 e Vila_de_Bolso_M0_v0_2.zip.

Importados os 28 arquivos do ZIP diretamente na raiz/pasta references, reconciliando os dois Markdown do mesmo projeto. Acrescentado [relatório](reports/IMPORT_V0_2_REPORT.md), atualizado estado/continuidade e preservados ZIP/manifesto original e histórico Git. PROJECT_CONTEXT.md é canônico; nenhum alias ou documento de outro projeto encontrado. Branch de entrega: `docs/importacao-v0-2`; sem merge automático. CONFIRMADO: commit `ebaa7abe53445e8a2b35a03cf4d1543a8eeb07ce` salvo e verificado no remoto; [draft PR #1](https://github.com/projetoscodex-nuvem/vila-de-bolso/pull/1) aberto, sem merge. Esta atualização posterior registra a evidência de entrega; cabeça final consultável no PR. O relatório registra comandos e confirmação remota.

CONFIRMADO: Git 2.52.0 e Python 3.12.14 disponíveis no ambiente Linux x86_64 desta tarefa; leitura do remoto funciona com permissão de rede do sandbox. Isso não comprova setup Godot/Android ou ambiente reutilizável. Sem código de jogo, câmera implementada, APK ou progresso de campanha nesta árvore.

CONFIRMADO em 01/11/2026: o PR #1 permanecia aberto, draft e sem merge, com cabeça `03d177a020ff673c209017fc0e640998c30fc7e4`, igual ao último commit revisado; nenhuma alteração posterior encontrada na conferência inicial. GAME_DESIGN.md agora atribui a definição/validação dos terrenos e encaixes aos templates, limitando os PNGs a estilo e paleta. D026 registra a sequência “colocar → trocar oferta → desfazer”, com oferta, cursor e quota de trocas ainda por definir antes de implementar desfazer em M1/M2. Estado, handoff, changelog e relatório sincronizados; verificador atualizado para incluir GAME_DESIGN.md nas diferenças esperadas frente ao ZIP.

## TESTE

PASS: segurança de caminhos/tipos, CRC do ZIP, cobertura e 27 hashes do manifesto original, comparação prévia dos arquivos existentes. Verificador repetido após o commit `ebaa7abe53445e8a2b35a03cf4d1543a8eeb07ce`, com árvore limpa: PASS. Conferências da árvore reconciliada e comandos/resultados em [reports/IMPORT_V0_2_REPORT.md](reports/IMPORT_V0_2_REPORT.md).

Os resultados acima são históricos da importação. As verificações e o snapshot dos ajustes de 01/11/2026 constam na seção “Atendimento à revisão externa” do relatório; a nova reconciliação tem dez arquivos diferentes do ZIP, incluindo GAME_DESIGN.md, e 18 idênticos. ZIP e manifesto originais preservados.

Engine, gestos/câmera em execução, domínio/gameplay, save real, exportação/instalação APK, toque, desempenho, balanceamento e diversão: **NOT_RUN**. Testes documentais não comprovam funcionamento do jogo.

## VALIDADO

Somente importação/reconciliação e verificações documentais registradas. PNGs legacy_v0_1 são estilo, não layout/câmera atuais. Aceite da importação pelo proprietário ainda pendente.

## PENDÊNCIA

Revisar a entrega e resolver a integração pelo fluxo Git do proprietário. A visibilidade pública diverge da previsão privada do pacote; registrada sem alterar configuração nem presumir necessidade de mudança. Licença autoral segue indefinida. Em futura tarefa M0.1: fixar ferramentas e provar câmera/gestos e APK, com teste físico separado. Balanceamento e dimensões finais dependem de protótipo; câmera navegável não é pendência de escopo.

D026: decidir oferta ativa, cursor e quota de trocas para “colocar → trocar oferta → desfazer” antes de implementar desfazer em M1/M2. Nenhuma escolha feita nesta tarefa; não bloqueia M0.1.

## PRÓXIMO PASSO

Revisar os ajustes de GAME_DESIGN.md, a pendência D026 e a nova seção do relatório no PR #1. Após revisão, o proprietário enviará PROMPT_M0_1_CODEX.md v0.2 em nova tarefa explícita. O prompt foi apenas importado, não executado.
