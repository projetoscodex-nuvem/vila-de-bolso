# Mapas e câmera — especificação v0.2

## Requisito confirmado e parâmetros iniciais

OWNER_CONFIRMED: o proprietário imaginou mapas maiores que a tela e quer navegar com o dedo nas fases e no reino, com zoom. Não é suficiente aumentar sprites ou permitir zoom artificial numa grade pequena sem área para percorrer.

BASELINE_PROTOTYPE: fase 20 × 20 células; seis regiões em 2 × 3; reino lógico 40 × 60 células. Fase tem 400 células, reino 2.400. As dimensões e 60 colocações são escolhas iniciais de planejamento para experimentar, não resultados de teste. Devem permanecer configuráveis. Mudanças por evidência exigem decisão registrada e ajustes de dados/testes; não retornar silenciosamente ao modelo pequeno.

## Enquadramento e navegação

- No zoom inicial de interação, tanto a fase quanto o reino excedem o viewport em largura e altura, num celular de referência em retrato. Há conteúdo real além das quatro bordas do recorte.
- Arrasto com um dedo desloca visualmente o mapa acompanhando o dedo, como arrastar papel; o controlador compensa a posição da câmera no sentido necessário. Não move construções. Inércia é opcional posterior, nunca requisito de M0.1.
- Pinça com dois dedos aproxima/afasta, preservando o foco aproximadamente sob o centro dos dedos.
- Disponibilizar zoom +/− e Recentrar/Visão geral como alternativas de acessibilidade. A visão geral pode mostrar tudo temporariamente; não é o enquadramento normal obrigatório.
- Limites de zoom e posição são calculados/configurados para o terreno e viewport. Não permitir perder o mapa completamente ou confirmar em célula ilegível.
- Em escala afastada de visão geral da fase, tocar uma célula aproxima/seleciona para inspeção; confirmar construção exige escala de interação legível. Não construir ao tentar aproximar.
- Na visão do reino, tocar uma região abre sua seleção/painel; a ação Entrar/Visitar é explícita. Não realizar construção no mapa geral.

## Separação de gestos e ações

| Entrada | Resultado | Efeito em gameplay |
| --- | --- | --- |
| Tap curto no mapa, reconhecido ao soltar | Selecionar célula/região e exibir informação | Nenhuma colocação |
| Um dedo ultrapassa limiar de movimento | PAN; cancela candidato a tap e prévia pendente | Nenhum consumo |
| Segundo dedo entra durante gesto | PINCH; cancela tap/pan anterior como ação | Nenhum consumo |
| Toque em Confirmar na HUD | Construir somente com seleção válida e escala legível | Uma colocação |
| Toque/arrasto em botão ou painel | UI recebe o evento | Câmera não recebe o mesmo gesto |
| Interrupção/cancelamento/retorno ao app | Limpar contatos e gestos transitórios | Não confirmar nem mover peça |

O limiar de tap/arrasto precisa ser configurável e escolhido com teste real, considerando densidade/viewport, sem declarar um número de pixels universal. Ao começar PAN/PINCH, manter tipo de peça selecionado, mas invalidar a posição pendente: após navegar, novo tap define posição e Confirmar pode agir. Isso evita construir numa prévia antiga fora da tela.

## Interface

HUD fixa: pontos/jogadas/objetivos no topo; ofertas e ações na base. O viewport ocupa a área disponível entre painéis. O mundo não rola os botões. Pan/zoom funcionam ao longo do terreno mesmo com uma peça selecionada. O gesto não fica preso ao sprite de uma construção. Durante visita de vila, mesmos controles com edição desabilitada.

## Persistência

Salvar câmera após término de gesto ou de forma limitada, não a cada frame com gravação pesada. Restaurar câmera própria do reino ao voltar de uma fase. Salvar separadamente câmera por fase; preservar construções independentemente da posição da câmera. Seleção de prévia e dedos nunca são restaurados como ações pendentes.

## Critérios de teste M0.1

1. Reino 40 × 60 e fase1 20 × 20 existem em dados com IDs e limites corretos.
2. Navegar para os lados e para cima/baixo mostra células/regiões fora do recorte inicial.
3. Pinça e botões alteram zoom dentro dos limites; Recentrar recupera mapa e Visão geral enquadra quando solicitado.
4. Pan e pinch não produzem seleção final indevida, construção, mudança de oferta ou consumo de jogada.
5. Transformação tela/mundo/célula correta em diferentes posições e escalas, inclusive bordas/cantos e área de HUD.
6. Fechar/reabrir e fase→reino restauram estado de apresentação válido sem alterar dados da vila.
7. Mouse/roda podem auxiliar desenvolvimento, mas não comprovam gestos Android. Sensação, legibilidade, toque e pinça físicos devem ser relatados separadamente.

## Referências antigas

Os quatro PNGs em references/legacy_v0_1 mostram o layout anterior. São válidos como referência de paleta/sprites, mas SUPERSEDED para tamanho de terreno, câmera, enquadramento, quantidade de jogadas e disposição final da UI. Não houve geração de novos mockups nem implementação de câmera nesta revisão documental.
