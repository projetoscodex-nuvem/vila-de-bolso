# Plano de testes

Não existe execução de testes do jogo na preparação documental. Este é um plano para os marcos futuros.

## Domínio headless

- Validar 20 × 20 = 400 células por fase, reino 40 × 60, IDs e encaixe entre regiões; meta de conteúdo 80–160 posições construíveis, nunca menos que 60.
- Recusar fora dos limites, terreno proibido e célula ocupada; não consumir turno/oferta nesses erros.
- Testar base e cada bônus, bordas/cantos, diagonais sem efeito, múltiplas fontes sem multiplicação indevida, deltas retroativos.
- Confirmar exemplo do poço +9 e floresta mútua total6; moinho/mercado até quatro vizinhos.
- Quotas, sequência/cursor e última colocação; 60 colocações mesmo após duas trocas.
- Desfazer restaura board/oferta/score; quota não renasce ao reabrir ou desfazer novamente.
- Mesmos dados/seeds/versionamento produzem mesmas ofertas; erros não avançam RNG/cursor.
- Objetivos consultam estado real; falha na meta não libera região.

## Persistência e reino

- Round trip completo com tentativa ativa, ofertas, quotas, tutorial e settings.
- Interromper gravação; save antigo válido continua recuperável. JSON inválido e versão desconhecida não destroem o original.
- Região concluída mantém exatamente suas peças/posições ao desbloquear a próxima e fechar/reabrir.
- Fixtures 0/6, 3/6, 6/6; projeção do mapa equivale aos snapshots, não a arte aleatória.
- Rejogar/cancelar/falhar mantém vila antiga; aceitar substituição atualiza somente a região correta.
- Metas das seis fases possuem solução rastreável válida pelas mesmas regras usadas no jogo.

## Android físico — proprietário

Registrar modelo do aparelho, Android, versão/hash do APK, passos e resultado. Não coletar identificadores pessoais desnecessários.

M0.1: baixar e instalar APK debug; abrir offline; menu → reino → arrastar em dois eixos → aproximar/afastar por pinça → região1 → repetir navegação e selecionar célula fora do recorte inicial → voltar; fechar/reabrir; observar câmera restaurada, HUD fixa, retrato, texto, áreas de gestos e ausência de crash. Pan/pinça não podem construir/selecionar ao soltar. Não há partida completa nesse marco.

M1/M2: seleção e confirmação sem toques acidentais; três peças legíveis; prévia compreensível; 60 colocações; pausa/app em segundo plano e retomada; som desligado/redução de movimento.

M3/M5: concluir campanha, visitar vilas, falhar/repetir, substituição cancelada/aceita, retomar durante fase e após conclusão, modo livre sem alterar reino. Testar offline real.

## Desempenho e apresentação

Medir tempo de frame, memória e comportamento em sessões prolongadas no aparelho de referência; observar aquecimento/bateria. Objetivo inicial de fluidez 60 FPS, sujeito a medir e definir configuração sustentável. Sem alegar que 2D é automaticamente leve. Conferir proporções diferentes de tela e texto ampliado quando aplicável.

## Registro

Cada relatório identifica tarefa, versão/commit, comandos exatos, ambiente, casos PASS/FAIL/NOT_RUN/BLOCKED e artefatos. OWNER_REPORTED separado de reprodução independente. A etapa só é aceita quando suas verificações críticas foram executadas ou uma exceção explícita foi registrada pelo proprietário.

## Câmera e gestos

Testar transformações tela↔mundo↔célula com pan/zoom, quinas e offsets de UI; limites de câmera; cálculo de visão geral; eventos sintéticos TAP→PAN, PAN→PINCH, cancelamento, remoção de um dedo e toques consumidos por UI. Selecionar célula, iniciar gesto e confirmar depois sem novo tap deve ser recusado. Conferir mundo/peças/score/oferta inalterados por navegação.

No aparelho: descobrir partes antes fora da tela, pinçar mantendo foco, navegar com peça selecionada sem construir, usar zoom por botões e recentrar, retomar após interrupção e alternar fase/reino sem saltos que percam a vila. Repetir em zoom afastado e próximo, sob diferentes proporções. Medir fluidez no reino 2.400 células sem presumir necessidade de streaming. Matemática headless não equivale à aprovação do gesto físico.
