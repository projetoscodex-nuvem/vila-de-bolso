# Design do jogo

## Promessa

“Construa pequenas vilas, descubra boas combinações e veja seu reino crescer.”

Puzzle estratégico 2D de colocação em mapas maiores que a tela, com aparência acolhedora. Arrastar explora o terreno; pinça aproxima/afasta; tocar seleciona; confirmar constrói. A meta inicial de ritmo, agora com 60 colocações, é aproximadamente 15–25 minutos, uma hipótese a testar e ajustar. Sem cronômetro obrigatório. Profundidade vem de posições, áreas construíveis limitadas e oportunidades futuras.

## Experiência completa

1. Abrir o menu e escolher Continuar, Meu Reino, Modo Livre, Configurações ou Créditos.
2. Ver o reino, regiões concluídas e próxima fase disponível.
3. Entrar na região de 20 × 20 células e ver um recorte do terreno em escala confortável, com objetivos resumidos na HUD. Explorar com arrasto e zoom.
4. Receber três opções de peça. Selecionar uma, tocar em espaço válido e visualizar os efeitos.
5. Confirmar; atualizar vizinhos e pontuação; salvar a jogada; apresentar nova oferta.
6. Usar, se desejar, duas trocas de oferta e um desfazer por partida, conforme GAME_RULES.md.
7. Após 60 colocações, ver pontuação, objetivos e resultado.
8. Ao atingir a meta principal, registrar a vila no reino e liberar a próxima região.
9. Voltar ao mapa e enxergar a montagem preservada. Abrir uma vila concluída para visitar.
10. Completar as seis regiões e receber a tela de reino concluído. Continuar visitando, rejogando ou usando o modo livre.

## Reino persistente

Seis terrenos preparados manualmente e alinhados em 2 × 3. Nomes iniciais: Planície, Lago, Pedreiras, Campina, Bosque, Lagoa. A ordem é linha por linha, da esquerda à direita. Curso d'água, lagos e obstáculos são definidos nos templates e precisam combinar nas bordas. Os mockups ilustram essa geografia, sem definir coordenadas exatas.

Cada região corresponde a uma fase de 20 × 20 células. O reino 2 × 3 tem 40 × 60 células, uma superfície contínua navegável com câmera; o mapa completo não é o enquadramento obrigatório da tela. A visão geral é um comando opcional. Casas, bosques plantados, plantações, moinhos, mercados e poços são projetados a partir do estado real salvo. Não gerar vila decorativa aleatória para representar o resultado. As demais regiões mantêm seus terrenos e estados.

O mapa mostra 0/6, 3/6 e 6/6 como nos conceitos; quantidade e tamanho foram delimitados para uma primeira versão terminável. Não existe renda passiva entre vilas, habitantes simulados, diplomacia ou guerra. Pontos de uma fase não recebem bônus de vizinhos de outra região.

## Progressão e repetição

A campanha libera regiões em sequência. A meta principal concede conclusão; cada objetivo opcional adiciona uma medalha/estrela, total de até três. Metas numéricas e objetivos de cada fase serão definidos e provados no M3; não há valores finais nesta baseline.

Rejogar cria uma tentativa separada. Uma vila concluída não é apagada no começo da repetição. Ao concluir uma nova tentativa válida, perguntar se o proprietário deseja substituir a vila exibida, mostrando o resultado anterior e o novo. Recorde de pontuação e vila exibida são dados separados.

Modo livre usa cópia de um dos terrenos e ofertas por seed, sem afetar campanha. Não exige novo reino procedural ou editor. Rejogar campanha usa as ofertas fixas da fase na mesma versão de regras.

## Interface Android

Retrato. Topo: título compacto/pausa, pontos, colocações e objetivos resumidos. Centro: viewport navegável mostrando parte do terreno de 20 × 20 em zoom confortável. Base: detalhe da peça selecionada, três cartões, Confirmar e Trocar. HUD fixa, independente da câmera. Desfazer deve ser acessível sem poluir a tela, com quota visível. Não encolher todo o terreno para caber como padrão.

Selecionar → tocar no terreno → prévia → confirmar. Arrasto serve à câmera; pinça serve ao zoom. Reconhecer tap somente ao soltar, se não houve gesto de câmera; nenhuma dessas navegações constrói ou consome jogada. Ao começar arrasto/pinça, cancelar a prévia de posição pendente, mantendo o tipo de peça selecionado. Nenhuma instrução depende de hover. Destacar vizinhos afetados e explicar o delta total, inclusive ganhos em peças antigas. Diferenciar por forma/ícone além de cor. Áreas seguras e textos legíveis no aparelho real são critérios de aceite. Ver MAP_AND_CAMERA.md.

Mapa do reino: arrastar percorre o território composto e pinça altera o zoom. Tocar numa região seleciona e abre um painel com Entrar/Visitar; não abrir fase ao finalizar um arrasto. Durante visita, a câmera da fase também permite navegar em modo somente leitura, com botão claro para rejogar. Visão geral afasta para enquadrar o reino apenas quando solicitada. Construções não são editadas na escala minúscula da visão geral.

## Acabamento obrigatório

Tutorial curto na primeira fase, introduzindo as seis peças progressivamente. Feedback de construção discreto, sons curtos, opção de volume e reduzir movimento, salvamento automático, retomada, tratamento de interrupções e créditos.

## Fora da versão 1

Multiplayer, ranking online, contas, anúncios, compras, servidor, IA generativa no runtime, simulação de cidadãos, recursos transitando entre vilas, terra infinita, editor público, campanhas gigantes e versões iOS/Windows comerciais. Versão desktop pode apoiar desenvolvimento, sem criar uma segunda linha de produto.

## Principal hipótese a validar

Combinações geram escolhas contextuais e vontade de repetir. Avaliar se existem peças dominantes, ofertas frustrantes ou excesso de confirmações. Correção de código não comprova diversão; testes do proprietário são necessários antes de ampliar conteúdo.

## Terreno maior sem diluir o puzzle

Um mapa com 400 células não significa 400 espaços livres. Meta de conteúdo inicial: entre 80 e 160 células construíveis por fase, restante com água, rochas e floresta natural, formando clareiras/áreas conectadas visualmente. Os templates e a pressão espacial precisam ser testados; não preencher artificialmente o mapa só para justificar rolagem. As 60 colocações são um orçamento inicial, não uma exigência de ocupar todo o terreno. Não aumentar regiões ou criar mundo infinito nesta mudança.
