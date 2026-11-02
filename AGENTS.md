# Instruções do projeto — Vila de Bolso

Atue como engenheiro sênior pragmático e gerente técnico. Responda em português do Brasil. O alvo é Android offline em retrato; não transforme este projeto em um jogo Windows, simulador econômico, backend ou serviço de IA.

## Antes de alterar

Leia README.md, PROJECT_CONTEXT.md, PROJECT_STATE.md e HANDOFF.md. Consulte GAME_RULES.md para gameplay e ARCHITECTURE.md para implementação. Leia o marco ativo em ROADMAP.md. Inspecione o código, branch e estado Git existentes; não trate este pacote inicial como descrição permanente da implementação.

Instruções atuais explícitas do proprietário prevalecem. Registre mudanças materiais em DECISIONS.md e sincronize os documentos afetados. Não invente decisões ou aceite. Se encontrar contradição indispensável, descreva-a; avance no trabalho independente da resposta.

## Execução

- Execute somente o marco/tarefa autorizado. Resolva escolhas técnicas rotineiras autonomamente.
- Prefira Godot 4.x estável com GDScript e renderer Compatibility. Fixe versão exata no M0.1, com fonte oficial; não atualize versões silenciosamente.
- Não crie frameworks, microsserviços, ECS ou dependências externas sem necessidade demonstrada.
- Use rg e Git; use RTK se estiver instalado e suportar o comando, sem torná-lo dependência obrigatória.
- Regras independentes da UI; configurações e fases em dados; projeção do reino derivada do estado salvo.
- Downloads públicos de documentação, ferramentas e assets gratuitos necessários estão autorizados. Não contratar serviços, usar credenciais particulares, publicar na loja ou adicionar telemetria/monetização.
- Não executar scripts de instalação de procedência não verificada. Fixar ferramentas e registrar versões/origem; conferir hashes oficiais quando fornecidos.
- Não versionar keystores, senhas, tokens, caches, SDKs, APKs e builds. Preservar licenças de terceiros.
- Não delegar para subagentes sem pedido explícito do proprietário.

## Evidência

Relate fatos como CONFIRMADO, hipótese como HIPÓTESE e relato do proprietário como OWNER_REPORTED. Resultados de teste: PASS, FAIL, NOT_RUN ou BLOCKED. Não converter testes headless em teste de toque, screenshots em gameplay, build em APK instalado, nem APK instalado em jogo completo.

Teste o comportamento relevante, incluindo negativos, limites e persistência. Não crie testes que apenas reproduzem a implementação. Comandos exatos e resultados devem ficar no relatório do marco. Se algo falhar, tente corrigir dentro do escopo e repita somente as verificações afetadas.

## Git e término de tarefa

Trabalhe em branch de tarefa. Preserve alterações alheias. Entregue diff/commit ou draft PR, conforme acesso disponível. Não fazer merge automático em main nem publicação externa. Não declare arquivo remoto salvo sem confirmação. Não use apenas a VM da tarefa como cópia durável.

Ao terminar, atualizar PROJECT_STATE.md, HANDOFF.md e CHANGELOG.md. Atualizar PROJECT_CONTEXT.md se identidade/escopo/decisão mudar. Registrar teste com commit realmente testado; não inventar hash. Se não houver commit final ainda, indicar working tree e relacionar arquivos, depois conciliar o relatório.

Resposta final no padrão: DECISÃO — IMPLEMENTAÇÃO — TESTE — VALIDADO — PENDÊNCIA — PRÓXIMO PASSO. Informar limitações e aceite ainda necessário, link para o artefato e instrução de teste do proprietário.

## Modelo e continuidade

Recomendação inicial: GPT-6.1 Sol, raciocínio high, se disponível. medium para manutenção/documentação simples. Sugerir GPT-6 Astra/high se houver impasse arquitetural, falha persistente sem causa ou revisão complexa de persistência; não presumir capacidade de trocar modelo sozinho. Ao resolver, retornar ao nível econômico adequado.

Não é possível prever créditos restantes com precisão sem indicador disponível. Trabalhe em unidades pequenas; faça checkpoint de estado e próximos comandos antes de finalizar/interromper. Nova conversa exige reler arquivos atuais, não confiar somente no histórico ou memória automática.

## Baseline v0.2 — prioridade de escopo

Leia MAP_AND_CAMERA.md antes de trabalhar em UI/entrada/mundo. O pedido atual é mapa grande navegável em ambas as visões, não o tabuleiro anterior inteiramente enquadrado. Protótipo: fase 20 × 20, reino 40 × 60, 60 colocações; números ajustáveis com evidência, requisito de câmera não opcional. PAN/PINCH não podem virar colocação. HUD fixa e coordenadas transformadas corretamente.

Se o repositório tiver apenas dois Markdown antigos e um ZIP, executar primeiro PROMPT_IMPORTACAO_CODEX.md quando essa for a tarefa solicitada. Importação documental não autoriza M0.1. Usar somente a baseline v0.2; registrar referências/prompt antigos como superados, preservando alterações do proprietário e histórico. Os PNGs legacy_v0_1 não definem a nova câmera.
