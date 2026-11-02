# Regras — baseline inicial de protótipo

Versão de regras: proposta 2, baseline documental v0.2. Valores abaixo são candidatos de balanceamento, não validados. Alterações devem ser registradas em DECISIONS.md e refletidas nos dados e testes.

## Terreno e ações

- Fase com terreno 20 × 20 (400 células), coordenadas locais x,y de 0 a 19. Cada peça ocupa uma célula. A tela mostra um recorte por câmera, não a grade inteira obrigatoriamente. Dimensão é parâmetro inicial de protótipo.
- Terreno base: GRASS, WATER, ROCK, NATURAL_FOREST. Apenas GRASS pode receber peça. Meta inicial de conteúdo: 80–160 posições construíveis por fase, nunca menos que as 60 colocações. Esse intervalo precisa de teste; validar por dados de cada template.
- Água, rocha e floresta natural são fixas e não pontuam sozinhas. Não podem ser removidas.
- Construir não exige conexão a estrada, casa ou borda. Diagonais não contam para bônus.
- Peças não giram, não são movidas nem demolidas durante a partida.
- Há 60 colocações confirmadas. Trocar/selecionar/cancelar seleção não consome colocação.
- Todas as peças estão disponíveis no sistema; o tutorial limita apenas sua apresentação guiada. Nenhuma vantagem paga ou atributo permanente.

## Pontuação por peça

| Tipo | Base | Bônus | Teto por peça |
| --- | --- | --- | --- |
| HOUSE / Casa | 2 | +2 se tocar ao menos um bosque; +2 se tocar água | 6 |
| FOREST / Bosque | 1 | +2 se tocar ao menos um outro bosque | 3 |
| FIELD / Plantação | 2 | +3 se tocar água | 5 |
| MILL / Moinho | 1 | +2 por plantação vizinha | 9 |
| MARKET / Mercado | 1 | +2 por casa vizinha | 9 |
| WELL / Poço | 1 | Fornece água aos quatro vizinhos, sem bônus próprio | 1 |

Bosque para adjacência significa FOREST plantado ou NATURAL_FOREST. Água significa WATER natural ou WELL. Várias fontes de água/bosques não multiplicam os bônus booleanos. Moinhos e mercados contam cada vizinho correspondente uma vez. Duas árvores plantadas adjacentes podem bonificar ambas: cada uma passa a valer três, total seis.

Total = soma das peças atuais. Sem renda por turno, juros, combos ocultos ou pontuação cumulativa repetida. Recalcular peças afetadas em todas as direções. A prévia é score(board + peça) − score(board), incluindo alterações em peças antigas. Exemplo: poço adjacente a duas plantações secas e uma casa sem água acrescenta 1 + 3 + 3 + 2 = 9.

## Ofertas e trocas

Uma oferta mostra três tipos distintos. Escolher uma peça descarta as outras duas. Duas trocas por partida substituem a oferta inteira, sem consumir colocação. A nova oferta deve diferir da anterior; pode compartilhar tipos.

Campanha: cada fase terá 62 ofertas pré-computadas, versionadas com a fase. Iniciar usa cursor 0; troca avança um cursor e reduz sua quota; colocação avança um cursor, exceto após a 60ª. Assim, mesmo usando as duas trocas, existem ofertas suficientes. Não há compras nem moedas de construção.

Modo livre: pré-computar a mesma quantidade de ofertas com seed e algoritmo versionado. O algoritmo de distribuição será fixado e testado no M2; evitar sorteios sem limites que produzam longas carências de tipos. Dados de campanha e metas finais ainda não foram produzidos.

## Desfazer e confirmação

Uma colocação pode ser cancelada antes de Confirmar, sem quota. Após confirmar, é permitido **um desfazer por partida**, antes do encerramento. Restaurar a última colocação, pontuação, oferta e cursor exatamente do snapshot; consumir a quota de desfazer de forma persistente. A oferta futura, ao avançar novamente, será a mesma, sem novo sorteio.

Essa decisão admite informação da próxima oferta em um puzzle offline sem ranking competitivo. Substitui a ideia inicial, pouco prática, de permitir desfazer somente antes da próxima oferta ser revelada. Trocas isoladas não são desfeitas. Não desfazer a integração final de uma região por esse botão.

## Resultado e campanha

Depois da 60ª colocação: atingir score_target conclui a fase. Dois objetivos opcionais adicionam estrelas. Metas não serão inventadas como já equilibradas; precisam de ao menos uma solução reproduzível e teste humano.

Falhar na meta: mostrar resultado e oferecer repetir; não substituir a vila antiga, não liberar região seguinte. Uma tentativa ativa é separada da conclusão salva. Para concluir, criar snapshot imutável da vila e atualizar a progressão em uma única transação lógica de salvamento.

## Limites a verificar

Bordas/cantos, terrenos proibidos, ocupação, quota zero, última jogada, repetir confirmação, retorno de pausa, restauração e mudanças de versão. Ao carregar save incompatível/corrompido, não sobrescrever silenciosamente o original nem liberar progresso fictício.

## Câmera não altera gameplay

Arrastar, usar pinça, zoom por botões, Visão geral e Recentrar não consomem turnos, trocas ou desfazer e não modificam terreno/peças/ofertas. Tap de seleção e confirmação são ações distintas. Uma sequência iniciada como arrasto/pinça não pode terminar como colocação. Coordenadas escolhidas são convertidas de tela para mundo e depois para célula, considerando a câmera atual. Scores e objetivos são idênticos em qualquer zoom. Ver MAP_AND_CAMERA.md para os critérios.
