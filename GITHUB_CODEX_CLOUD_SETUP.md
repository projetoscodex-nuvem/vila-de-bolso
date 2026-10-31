# GitHub e Codex Cloud — pacote corrigido v0.2

Preparado em 29/10/2026. Nomes de telas variam por conta/idioma/disponibilização. Fontes em SOURCES.md. Este guia não confirma acesso à sua conta e não executa mudanças no GitHub.

## Situação atual

Atualização confirmada em 31/10/2026: repositório https://github.com/projetoscodex-nuvem/vila-de-bolso, público, com importação realizada na branch `docs/importacao-v0-2`. Os arquivos iniciais eram README.md, PROJECT_CONTEXT.md e o ZIP v0.2. O fluxo abaixo permanece como guia de importação para uma base ainda não extraída; nesta branch, comece pela revisão de [PROJECT_STATE.md](PROJECT_STATE.md) e do [relatório](reports/IMPORT_V0_2_REPORT.md). Não repetir upload/importação nem iniciar M0.1 sem nova tarefa explícita. OWNER_REPORTED: operação pelo celular. A versão ativa é v0.2; mapas grandes com arrasto/zoom são requisito confirmado, enquanto dimensões e balanceamento de protótipo precisam de testes.

## 1. Caminho recomendado pelo celular

1. Baixe **Vila_de_Bolso_M0_v0_2.zip** atualizado. Não use o pacote antigo.
2. Abra o repositório no navegador do celular e use Add file → Upload files.
3. Envie o ZIP inteiro à raiz e confirme o commit ou fluxo de PR que a interface oferecer. O ZIP é transporte; será extraído pelo Codex.
4. Configure/selecione o ambiente Cloud ligado ao repositório.
5. Envie o conteúdo de PROMPT_IMPORTACAO_CODEX.md, disponibilizado também como arquivo separado. Ele pede somente importação/reconciliação.
6. O Codex deve conferir o ZIP e os arquivos já existentes, extrair documentos à raiz, preservar a pasta references/legacy_v0_1 e reconciliar informações antigas do mesmo projeto sem perder alterações do proprietário.
7. Revise o resultado/branch/PR. Não suponha que a resposta na conversa significa que os arquivos já entraram em main.
8. Após a importação conferida, abra a tarefa de implementação com PROMPT_M0_1_CODEX.md v0.2. Não execute prompt antigo.

Não é obrigatório extrair/enviar pastas manualmente no celular. O ZIP sozinho também não é a forma final do repositório: depois da importação, AGENTS.md, README.md, PROJECT_CONTEXT.md, MAP_AND_CAMERA.md e os demais documentos devem estar visíveis diretamente na raiz.

## Alternativa: enviar arquivos extraídos

Se preferir usar um computador/navegador que preserve diretórios, extraia o ZIP e envie seu CONTEÚDO para a raiz, mantendo references/legacy_v0_1. Compare os dois Markdown existentes antes de substituir. Não criar uma pasta pai extra. Mesmo nesse caminho, confira a baseline v0.2 antes de M0.1. Não é necessário instalar Git/Godot/Android Studio localmente apenas para enviar os arquivos.

## 2. Se o repositório ainda precisar ser criado

Em https://github.com/new, escolha conta correta, nome vila-de-bolso, Private e README inicial; crie o repositório. Não adicionar licença autoral por padrão. O pacote fornece .gitignore. Para quem já criou, pule esta etapa. Depois siga o envio acima. Não é necessário GitHub Copilot para usar o Codex.

## 3. Ambiente Codex Cloud

Fluxo documentado: pela web ou aplicativo de desktop, Work in → Cloud → Select environment → Create environment, ou entrada de ambientes em Settings. No app móvel, o fluxo documentado é selecionar ambiente já publicado. Pelo navegador do celular pode tentar a interface web, inclusive modo de site para computador; não há garantia de que a UI da sua conta permita todas as etapas nesse formato.

1. Entre com conta que tenha acesso ao Codex e conecte GitHub quando solicitado.
2. Confira a conta e autorize somente o repositório necessário, quando houver essa escolha.
3. Selecione vila-de-bolso e use Get started.
4. Inicialmente basta ambiente mínimo com Git, shell, Python 3 e extração ZIP. Se só houver ZIP e dois documentos, avise explicitamente que a primeira tarefa será importação, não build.
5. Não instalar engine nesta tarefa documental. M0.1 depois fixará Godot/templates/Android conforme versão e recursos disponíveis.
6. Mantenha ambiente pessoal/privado quando houver essa opção; sem segredos de produção.
7. Revise configuração e publique com Publish; aguarde Environment published. Publicar ambiente não publica jogo.

Texto de orientação opcional ao setup:

> Este repositório inicia Vila de Bolso, Godot/GDScript Android offline. A primeira tarefa será extrair/reconciliar o pacote v0.2. Prepare Git, shell, Python 3 e leitura ZIP. Não invente APK, teste de jogo ou script ausente. Após importação, M0.1 instalará as ferramentas e implementará uma prova com mapas grandes, arrasto e zoom. Não preciso de backend ou chave de API de IA.

Se mostrar UI legada, use os campos equivalentes do ambiente/repositório, sem misturar instruções de interfaces diferentes. Em divergência bloqueante, informe o texto da tela sem segredos.

## 4. Rede, modelo e primeira implementação

Para importar o ZIP não precisa baixar engine. Em M0.1, permitir downloads oficiais necessários: releases Godot, SDK Android/Google, JDK e, quando usado, Kenney. Conferir domínios exatos/redirecionamentos e espaço; não é uma allowlist completa garantida, não usar espelhos desconhecidos.

Modelo sugerido: Sol/medium para importação, Sol/high para M0.1, se disponíveis. O prompt não muda o seletor sozinho. Não assumir disponibilidade da conta sem conferir a interface.

M0.1 deve produzir scripts repetíveis. Só associar ao setup um comando de script depois de ele existir e ter sido testado; depois republicar e testar uma tarefa nova. Ferramentas instaladas na VM corrente não provam setup reutilizável.

## 5. APK, revisão e continuidade

Gerar APK debug e disponibilizar por download da tarefa quando suportado; alternativa é artifact de CI manual com permissões mínimas e limites de conta conferidos. Não comitar APK/SDK/keystore. APK exportado não significa instalado/testado.

No Android, baixar/instalar seguindo instruções do sistema e executar TEST_PLAN.md: pan nos dois eixos, pinça, botões de zoom, seleção sem colocação acidental, HUD fixa e retomada. Não precisa Godot no celular. Mudança de chave de debug pode impedir atualização: relatar isso antes de pedir desinstalação que apague save.

Trazer relatório, resposta do Codex, branch/commit/PR e APK/hash ou bloqueio. Se o chat não acessar repositório privado, anexar documentos atuais/ZIP relevante. Persistir decisões no GitHub, sem depender da VM ou memória automática.

## Limites reais

A documentação consultada lista uso gráfico de computador/navegador como não suportado no ambiente Codex Cloud de programação. Headless/build não validam toque, legibilidade ou diversão. Estado da VM não é armazenamento permanente. Não há garantia de concluir marcos dentro de um limite de créditos. Não é necessário contratar serviços ou publicar na Play Store para começar.
