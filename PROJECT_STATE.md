# Estado do projeto

Data: 31/10/2026 (UTC). Baseline: v0.2. Estado: **DOCUMENTATION_V0_2_IMPORTED — AGUARDANDO REVISÃO**.

## DECISÃO

Executar somente importação/reconciliação documental. M0.1 **NÃO INICIADO**; nenhuma instalação de engine autorizada nesta tarefa. Android offline em retrato; fases e reino maiores que o viewport, com arrasto/zoom e HUD fixa. Protótipo: fase 20 × 20, reino 40 × 60, seis regiões 2 × 3, 60 colocações e 62 ofertas. Números sujeitos a testes; requisito de câmera confirmado e obrigatório desde M0.1.

## IMPLEMENTAÇÃO

CONFIRMADO: repositório https://github.com/projetoscodex-nuvem/vila-de-bolso, público segundo API GitHub. Base inicial `work`, correspondente à `main` remota em `f1b59a2ab0f148abc71f0caf91a102a79e122cee`, com árvore limpa: README.md e PROJECT_CONTEXT.md v0.1 e Vila_de_Bolso_M0_v0_2.zip.

Importados os 28 arquivos do ZIP diretamente na raiz/pasta references, reconciliando os dois Markdown do mesmo projeto. Acrescentado [relatório](reports/IMPORT_V0_2_REPORT.md), atualizado estado/continuidade e preservados ZIP/manifesto original e histórico Git. PROJECT_CONTEXT.md é canônico; nenhum alias ou documento de outro projeto encontrado. Branch de entrega: `docs/importacao-v0-2`; sem merge automático. O relatório registra o estado de salvamento remoto.

CONFIRMADO: Git 2.52.0 e Python 3.12.14 disponíveis no ambiente Linux x86_64 desta tarefa; leitura do remoto funciona com permissão de rede do sandbox. Isso não comprova setup Godot/Android ou ambiente reutilizável. Sem código de jogo, câmera implementada, APK ou progresso de campanha nesta árvore.

## TESTE

PASS: segurança de caminhos/tipos, CRC do ZIP, cobertura e 27 hashes do manifesto original, comparação prévia dos arquivos existentes. Conferências da árvore reconciliada e comandos/resultados em [reports/IMPORT_V0_2_REPORT.md](reports/IMPORT_V0_2_REPORT.md).

Engine, gestos/câmera em execução, domínio/gameplay, save real, exportação/instalação APK, toque, desempenho, balanceamento e diversão: **NOT_RUN**. Testes documentais não comprovam funcionamento do jogo.

## VALIDADO

Somente importação/reconciliação e verificações documentais registradas. PNGs legacy_v0_1 são estilo, não layout/câmera atuais. Aceite da importação pelo proprietário ainda pendente.

## PENDÊNCIA

Revisar a entrega e resolver a integração pelo fluxo Git do proprietário. A visibilidade pública diverge da previsão privada do pacote; registrada sem alterar configuração nem presumir necessidade de mudança. Licença autoral segue indefinida. Em futura tarefa M0.1: fixar ferramentas e provar câmera/gestos e APK, com teste físico separado. Balanceamento e dimensões finais dependem de protótipo; câmera navegável não é pendência de escopo.

## PRÓXIMO PASSO

Revisar README.md, PROJECT_CONTEXT.md, MAP_AND_CAMERA.md e relatório nesta branch/draft PR. Após revisão, o proprietário enviará PROMPT_M0_1_CODEX.md v0.2 em nova tarefa explícita. O prompt foi apenas importado, não executado.
