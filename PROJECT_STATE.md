# Estado do projeto

Data: 02/11/2026 (UTC). Baseline: v0.2. Estado: **M0_1_PARTIAL_ANDROID_EXPORT_BLOCKED — AGUARDANDO REVISÃO**.

## DECISÃO

CONFIRMADO: proprietário aceitou a importação/revisão documental no commit `0733005bb2b83639522596ce63526003fb23cca8`, autorizou integrar o PR #1 preservando os commits e executar somente M0.1. Cabeça conferida sem alterações posteriores; PR retirado de draft e integrado com merge normal em `2d80844b8bc4a147bf428ade00448b5f6d2f02ba`, confirmado como main remota. Implementação isolada em `feat/m0-1-foundation`, a partir dessa main. Novo PR deve permanecer draft e sem merge.

Android offline em retrato, Godot 4.6.3/GDScript/Compatibility. Fase 20 × 20, reino 40 × 60 em seis regiões 2 × 3; mapas maiores que o viewport inicial, com arrasto/zoom e HUD fixa. Parâmetros futuros de 60 colocações/62 ofertas preservados; nenhuma partida ou regra de desfazer implementada. D026 permanece PENDING antes de implementar desfazer em M1/M2; não bloqueia a fundação.

## IMPLEMENTAÇÃO

Menu → reino vazio → região1 → voltar. Cinco regiões bloqueadas. Dados/IDs e terreno provisório próprios, sem PNGs legados no runtime. Modelo de câmera com transformações tela/mundo/célula, arrasto, pinça, botões +/−, recentrar/visão geral, limites e restauração por visão. Entrada separada da seleção, cancelamento e botão Voltar do Android tratados; nenhuma ação de construir disponível.

Save JSON mínimo versionado para visão/câmeras, com último backup válido; bloqueio de escrita sobre save inválido/desconhecido. Dedos, gesto e seleção não são persistidos. Scripts de setup/verificação/exportação e lock com URLs/hashes oficiais. Arte e ícone geométricos provisórios, avisos de licença da engine acessíveis em Créditos.

Arquivos centrais: project.godot, scenes/, core/, data/world.json, presentation/, tests/, scripts/, export_presets.cfg e licenses/. Evidências e limites em [reports/M0_1_REPORT.md](reports/M0_1_REPORT.md). ZIP, manifesto, PNGs e relatório histórico de importação preservados; sua antiga restrição de árvore documental não se aplica a M0.1.

Correção da revisão do commit 653e9cd: emulação touch→mouse habilitada para a GUI; o controlador de mapa ignora somente mouse DEVICE_ID_EMULATION, sem duplicar contatos e preservando mouse físico. Novo teste de entrada usa Input.parse_input_event para botões/gestos, sem app._input direto ou emissão de pressed. Exportador grava resultado fresco por tentativa, inclusive em timeout/erros de manifesto/assinatura, arquivando resultados/logs/APKs anteriores e isolando artefatos não verificados.

## TESTE

PASS: 157 verificações headless/sintéticas de dados/IDs, regiões bloqueadas, coordenadas, recorte inicial, pan/zoom/limites/foco, cancelamento, toque iniciado na HUD, fluxo da cena, save/backup/corrupção/erro de I/O e retomada com câmeras independentes. PASS: cena principal por 15 frames headless, proveniência/links/parâmetros, sintaxe Python/shell e git diff --check, conforme relatório.

Os 157 checks acima são testes de componentes/cena que usam chamadas diretas e sinais; sua aprovação anterior não comprovava acessibilidade dos botões por toque. A falha do menu foi reproduzida pelo novo teste do fluxo Input e corrigida. Agora PASS: 44 verificações adicionais pela entrada Godot (menu, Entrar, Retomar, zoom, retorno, HUD, tap/pan/pinça e mouse físico) e 25 testes Python: sete do instalador e 18 de exportação com fixtures isoladas, incluindo resultado anterior PASS e falhas de assinatura/manifesto/timeout/dependências. Fixtures não são APK real.

Importação de recursos/scripts sem erro de parse; o editor emite os diagnósticos específicos de listeners TCP indisponíveis no sandbox, classificados separadamente no verificador e preservados no relatório. Engine 4.6.3 disponível e executada; isso não comprova setup reutilizável ou Android.

BLOCKED: download da toolchain Android negado com Operation not permitted no sandbox; tentativa com permissão adicional interrompida sem evidência de instalação. Exportação debug executada pela Godot, exit 1, com templates/JDK/SDK ausentes. Script registra status BLOCKED e exit 2. Nenhum APK ou SHA-256 de APK disponível.

Retentativa desta correção: socket(AF_INET) retornou EPERM no processo antes de proxy/DNS/TLS; hosts oficiais constam na configuração, mas isso não concede rede ao sandbox. Setup real retornou errno 1 e exportação real foi novamente bloqueada; export_result.json agora tem schema 2/attempt_id/horários/erro atual, sem PASS antigo ou hash de APK. [Alternativa CI manual](reports/ci/README.md) entregue inativa, sem dispatch: permissões/limites de Actions/billing/armazenamento não foram confirmados. A consulta actions/permissions não é admitida pelo conector; não interpretar isso como recusa do GitHub ou causa do bloqueio de socket.

NOT_RUN: instalação, toque/pinça físicos, legibilidade/áreas seguras, comportamento offline real, desempenho, bateria/aquecimento, diversão e aceite de M0.1 no aparelho. Testes de pontuação/ofertas/desfazer não pertencem a este marco e não foram executados.

## VALIDADO

Somente as verificações locais descritas. A árvore testada e o commit real da entrega serão conciliados na descrição do novo draft PR e na resposta final após confirmação remota. M0.1 continua PARCIAL/BLOCKED; não aprovado como cadeia Android completa. Aceite documental anterior foi dado pelo proprietário, sem inferir aceite de implementação.

## PENDÊNCIA

Resolver acesso de rede/ferramentas em ambiente autorizado, executar scripts/setup.sh --android e scripts/export_android.sh, obter APK concreto e disponibilizar download com hash. Depois testar no aparelho identificado pelo proprietário. Não criar CI automático sem conferir permissões/limites da conta, não publicar release e não comitar SDK/cache/keystore/APK.

Continuam pendentes D026 (oferta/cursor/quota na sequência colocar → trocar oferta → desfazer antes de M1/M2), licença autoral, aparelho/Android de referência e balanceamento final. A visibilidade pública do repositório permanece inalterada.

## PRÓXIMO PASSO

Revisar o draft PR da branch feat/m0-1-foundation e o relatório. Resolver o bloqueio de exportação e executar o roteiro físico antes de tratar M0.1 como comprovado. Não iniciar M1 nesta tarefa e não fazer merge do PR de implementação automaticamente.
