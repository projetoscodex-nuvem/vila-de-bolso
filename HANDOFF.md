# Passagem de contexto

Data: 02/11/2026 (UTC). Baseline ativa: **v0.2 — mapas grandes e navegáveis**. Marco: **M0.1 PARCIAL/BLOCKED na exportação Android**.

## Identidade e direção

Vila de Bolso — Meu Reino: puzzle 2D Android offline vertical. Fase 20 × 20 e reino 40 × 60 de seis regiões 2 × 3, com recorte inicial nos dois eixos, arrasto/zoom e HUD fixa. Parâmetros futuros 60 colocações/62 ofertas mantidos, sem implementar partida. Cada vila concluída deverá preservar suas peças/posições reais no reino nos marcos posteriores. PNGs legacy_v0_1 são somente estilo/paleta, sem definir terreno/geografia/câmera/layout.

Leia AGENTS.md, PROJECT_CONTEXT.md, PROJECT_STATE.md, MAP_AND_CAMERA.md e [relatório M0.1](reports/M0_1_REPORT.md). O relatório histórico de importação está preservado e não impõe “30 arquivos/sem Godot” à implementação.

## Integração confirmada

O proprietário aceitou a documentação em 0733005bb2b83639522596ce63526003fb23cca8 e autorizou retirar o draft/integrar o PR #1 preservando os commits. Cabeça conferida sem alterações posteriores; merge realizado em main `2d80844b8bc4a147bf428ade00448b5f6d2f02ba`. Nenhuma mudança de visibilidade/licença. Repositório: https://github.com/projetoscodex-nuvem/vila-de-bolso, público.

Implementação criada a partir dessa main em **feat/m0-1-foundation**; entrega em novo draft PR, sem merge automático. A descrição do PR e a resposta final identificam o commit real e sua árvore verificada; não assumir salvamento remoto apenas pela existência de arquivos na VM.

## Implementado e verificado localmente

Godot 4.6.3/GDScript/Compatibility, menu → reino → região1 → voltar; demais regiões bloqueadas. Terreno provisório de primitivas, ícone SVG próprio e créditos/avisos da engine. Câmera em ambas as visões, limites, pinça/arrasto/botões/visão geral, seleção sem colocação e HUD fixa. Modelo de dados/câmera/gestos/save separado da apresentação.

Save mínimo versionado guarda visão e câmeras independentes; limpa seleção/contatos em troca de tela, pausa e cancelamento. Preserva backup válido e bloqueia sobrescrita automática de save inválido/desconhecido. Nenhum score, construção, turno, oferta ou desfazer implementado.

Suíte com 157 verificações headless/sintéticas PASS; cena principal por 15 frames e checks de documentação/proveniência/links/parâmetros. Os listeners TCP do editor são indisponíveis no sandbox e geram diagnósticos de infraestrutura durante importação; a execução da cena/suíte não apresentou erro de script. Esses resultados não provam Android físico ou aparência final.

## Bloqueio Android e retomada

SDK, templates Android e JDK completo ausentes. O JRE do host não equivale ao JDK fixado. Download oficial pelo setup retornou Operation not permitted; tentativa com permissão adicional foi interrompida e não demonstrou instalação. O comando real de exportação Godot executou e falhou por essas dependências; **nenhum APK foi produzido**, sem hash fictício.

Em ambiente com rede permitida para fontes oficiais e pelo menos 4 GB livres, usar o [guia de execução](scripts/README.md): scripts/setup.sh --android → scripts/verify.sh → scripts/export_android.sh. Lock registra Godot/templates 4.6.3, JDK 21.0.9+10, command-line tools 15859902, Platform-Tools 37.0.1, Platform 36, Build-Tools 36.1.0, minSdk 24/targetSdk 36. Exportação padrão, sem Gradle/NDK/CMake. Não trocar versões silenciosamente nem substituir Android por outro alvo.

Após APK existir: conferir hash/assinatura, disponibilizar download, registrar aparelho e Android e seguir o smoke do relatório. Instalação, toque/pinça, áreas seguras, offline físico, desempenho e aceite ficam NOT_RUN até relato do proprietário. Não pedir desinstalação que apague progresso sem avisar sobre mudança de chave debug.

## Limites e próximo passo

D026 continua PENDING: especificar oferta ativa, cursor e quota de trocas em “colocar → trocar oferta → desfazer” antes de implementar desfazer em M1/M2. Nenhuma regra foi escolhida. Resolver exportação/gestos físicos de M0.1 antes de avançar; não iniciar M1 nem fazer merge do PR de implementação sem autorização.

OWNER_REPORTED: operação pelo celular. Fonte/relatórios no GitHub são a continuidade durável; .tools/cache/SDK/keystore/logs integrais da VM não são garantia de ambiente reutilizável. Evidências essenciais do bloqueio/testes foram copiadas para reports/evidence e devem acompanhar o commit.
