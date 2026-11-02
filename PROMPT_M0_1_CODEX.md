# Vila de Bolso — Meu Reino | Prompt de início M0.1 | baseline v0.2

Modelo recomendado: **GPT-6.1 Sol / high**, se disponível. Seletor é configurado pelo proprietário; não alegue mudança automática. Usar medium em manutenção documental simples; sugerir Astra/high somente diante de impasse técnico persistente ou revisão arquitetural complexa. Não usar subagentes sem pedido.

Você é o engenheiro sênior e gerente técnico do projeto. Quero iniciar sua implementação no **Codex Cloud**, com fonte e documentação em GitHub. O objetivo final está descrito nos documentos, mas **execute nesta tarefa somente M0.1**. Faça o trabalho, teste o que puder e entregue resultado revisável; não pare apenas com um plano nem tente terminar todo o jogo de uma vez.

## 1. Contexto obrigatório

Antes de alterar, leia AGENTS.md, README.md, PROJECT_CONTEXT.md, PROJECT_STATE.md e HANDOFF.md. Em seguida leia GAME_DESIGN.md, GAME_RULES.md, MAP_AND_CAMERA.md, ARCHITECTURE.md, ROADMAP.md, TEST_PLAN.md, DECISIONS.md e ASSETS_AND_LICENSES.md. Inspecione a árvore real e o estado Git. Se algum arquivo essencial estiver ausente, procure no repositório; não invente seu conteúdo ou importe contexto de outros projetos.

Este prompt requer documentos v0.2 já extraídos/reconciliados na raiz. Se houver somente o ZIP, execute apenas a tarefa documental de PROMPT_IMPORTACAO_CODEX.md e entregue a importação para revisão; não avance para implementação nesta mesma tarefa nem finja que a importação já ocorreu. As imagens em references/legacy_v0_1 são conceitos anteriores: estilo/paleta apenas, SUPERSEDED para layout, dimensões, câmera e contadores. Não recorte a imagem inteira para simular UI funcional.

## 2. Visão que deve permanecer

**Vila de Bolso — Meu Reino**: puzzle 2D offline Android retrato. O proprietário quer mapas maiores que a tela, com arrasto e zoom nas fases e no reino. Parâmetros iniciais: fase 20 × 20, reino 40 × 60 composto de seis regiões em 2 × 3, 60 colocações. Câmera navegável mostra recorte, com visão geral opcional; não encolher tudo como enquadramento padrão. Seis peças pontuam por vizinhança. Cada vila concluída preserva suas posições no mesmo reino; não gerar povoado substituto. Dimensões/jogadas são iniciais a testar, não um balanceamento comprovado.

Não é simulador econômico/cidadãos. Sem servidor, anúncios, compras, contas, IA no runtime, ranking online ou mudança de plataforma. Sem arte paga. O jogo final inclui campanha, visita/rejogar sem perda involuntária, modo livre isolado, tutorial, save, configurações e créditos.

## 3. Escopo autorizado M0.1

1. Auditar base documental e identificar inconsistências indispensáveis, distinguindo ajustes rotineiros de mudança de escopo.
2. Escolher e fixar release estável oficial da Godot 4.x, GDScript e Compatibility. Registrar fonte, versão e templates correspondentes. Conferir toolchain Android na documentação da versão; não adivinhar SDK/minSdk nem instalar toda a SDK sem medir recursos.
3. Criar projeto Godot enxuto: menu → reino vazio 40 × 60 com seis regiões → região1 20 × 20 → voltar. Câmera funcional em AMBAS as visões: um dedo arrasta, pinça aproxima/afasta, botões de zoom e recentrar/visão geral, limites de posição/escala, HUD fixa. No zoom inicial há terreno real fora do recorte nos dois eixos. Reconhecer tap ao soltar; PAN/PINCH/UI não podem selecionar/construir acidentalmente. Converter coordenadas considerando câmera e viewport. Mouse/roda são apoio de desenvolvimento, não prova do Android.
4. Manter as demais regiões bloqueadas. Não simular partida completa, score, conclusão ou progresso real. Definir IDs/templates de dados e uma estrutura mínima de save versionado; salvar/retomar estado mínimo e posição/zoom próprios do reino e da fase; restaurar com validação/clamp, limpar gestos e prévias transitórias, sem fingir que gameplay existe.
5. Estruturar separação domínio/dados/UI sem arquitetura excessiva. Assets simples próprios/temporários são aceitáveis nesta prova; identificar como provisórios. Não gastar a tarefa produzindo arte final.
6. Criar scripts idempotentes de setup, verificação headless e exportação APK debug, com dependências/versões explicitadas e comandos reproduzíveis. Medir disco/CPU/memória e adaptar instalação ao ambiente real. Não depender de desktop gráfico ou emulador acelerado.
7. Configurar e executar exportação Android; tentar produzir APK debug concreto. Disponibilizar por download da tarefa quando suportado; alternativamente preparar CI manual com artifact, somente após verificar permissões/limites de conta. Não comitar APK, SDK ou keystore no Git.
8. Criar testes úteis para dimensões/IDs, transformação local→reino/tela→célula sob pan/zoom, seleção válida/inválida, limites/enquadramento, transições sintéticas tap→pan→pinch, cancelamento e round trip do estado mínimo/câmera; testar erro de save quando aplicável. Navegação não altera board/oferta/turno. Esses testes não provam gesto físico nem substituem regras de marcos posteriores.
9. Criar reports/M0_1_REPORT.md com ambiente, versões, comandos, resultados, limitações, artefato/hash e instrução de smoke Android.
10. Atualizar PROJECT_STATE.md, HANDOFF.md e CHANGELOG.md; DECISIONS.md/PROJECT_CONTEXT.md se necessário. Não registrar implementações futuras como prontas.

## 4. Critérios de entrega

- Projeto importa/inicia sem erros detectados nas verificações executadas.
- Retrato com menu → reino 40 × 60 → fase1 20 × 20 → voltar; pan/zoom efetivos, HUD fixa, seleção correta fora do recorte inicial e câmera restaurável. Não aceitar apenas mapa inteiramente enquadrado com botões decorativos de zoom.
- Testes headless relevantes executados e resultados relatados com precisão.
- APK debug exportado e disponibilizado, ou bloqueio concreto e diagnosticado marcado como BLOCKED/PARCIAL.
- Scripts repetíveis e instrução para integrar setup do ambiente e republicar. Instalação na VM corrente não basta como prova de persistência do setup.
- Documentação coerente, código revisável em branch e instrução de teste físico.

Um APK exportado não significa APK instalado. Toque, legibilidade, offline no aparelho, desempenho e aceite humano ficam NOT_RUN até execução real. Se a infra impedir exportação, não chame M0.1 de aprovado: entregue a parte concluída e o bloqueio, sem trocar engine/alvo ou inventar binário.

## 5. Segurança, autonomia e economia

Estão autorizados downloads públicos necessários de documentação oficial, ferramentas e assets gratuitos. Não contratar serviços, publicar app, usar segredos de produção ou coletar dados do jogador. Não inserir chave de API: o jogo não precisa de IA em execução. Não conceder permissões extras de Android sem necessidade.

Resolva escolhas rotineiras dentro do escopo e tente corrigir falhas. Se uma ação externa exigir configuração/permissão indisponível, registre exatamente qual e continue o que for independente. Não fabricar resultados. Evite logs enormes sem diagnóstico e testes redundantes; prefira entregas pequenas. Não consegue prever crédito restante sem indicador confiável: deixe checkpoints de contexto e trabalho ao terminar.

## 6. Controle de versão e revisão

Trabalhe em branch do marco, preserve alterações existentes e gere diff/commit ou draft PR conforme capacidades disponíveis. Não fazer merge em main ou release automaticamente. Informar se mudanças ficaram apenas na tarefa. A aprovação do proprietário virá após revisão e smoke, sem exigir confirmação para cada ação reversível já autorizada.

## 7. Resposta final

Use DECISÃO — IMPLEMENTAÇÃO — TESTE — VALIDADO — PENDÊNCIA — PRÓXIMO PASSO. Incluir arquivos relevantes, versão/branch/commit reais, comandos executados, resultados PASS/FAIL/NOT_RUN/BLOCKED, APK e hash se existente, e roteiro curto para o proprietário testar arrasto/pinça nas duas visões, seleção, HUD e retomada. Indicar explicitamente que este marco é uma fundação e não o jogo completo. Não avançar para M1 nesta tarefa.
