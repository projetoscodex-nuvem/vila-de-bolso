# Roteiro até uma versão completa

Um marco por entrega revisável. A primeira tarefa é a importação documental v0.2 se os arquivos ainda não estiverem na raiz; M0.1 é a primeira tarefa de implementação, somente quando enviada explicitamente. O roadmap define o destino, não autoriza executar tudo em uma única tarefa.

| Marco | Entrega | Critério de saída |
| --- | --- | --- |
| M0.1 | Fundação, câmera e prova Android | Versões/scripts; reino 40 × 60; fase1 20 × 20; arrasto, pinça, limites, HUD fixa, seleção sem conflito; testes de dados/câmera e APK debug exportado; teste físico separado |
| M1 | Partida básica | Seis peças, terreno válido, ofertas, 60 colocações, pontuação, prévia e resultado reproduzível |
| M2 | Continuidade e experiência mobile | Save/retomada, trocas, desfazer, objetivos genéricos, tutorial funcional, distribuição livre fixada e testes no aparelho |
| M3 | Reino e campanha completa | Seis terrenos/ofertas/metas provados, integração real dos snapshots, visita, rejogar/substituir e recordes |
| M4 | Conteúdo e acabamento | Modo livre, assets/licenças, áudio, acessibilidade, configurações e refinamento do ritmo |
| M5 | Release candidate 1.0 | Campanha concluível do início ao fim no Android, offline, compatibilidade e estabilidade documentadas, pacote e documentação de release |

## M0.1 em detalhe

Provar a cadeia repositório → projeto Godot com mapas grandes e câmera funcional → verificação headless → APK → instalação/gestos no Android. O último passo é do proprietário; usar NOT_RUN até seu relato. Mapas 3/6 e 6/6 podem aparecer em fixtures de teste, não como progresso real do perfil. Não implementar ainda pontuação, loja, economia, campanha inteira ou arte final.

Se a exportação estiver bloqueada pela infraestrutura, entregar fonte, scripts e diagnóstico verificável; marcar M0.1 PARCIAL/BLOCKED, não aprovado. Corrigir esse bloqueio antes de tratar Android como comprovado. Não trocar engine ou alvo por conveniência sem decisão registrada.

## Portões de qualidade

- M1: provar matemática e partida completa antes de multiplicar fases.
- M2: confirmar legibilidade e toque em Android antes de arte final.
- M3: cada meta tem solução reproduzível; os seis terrenos realmente encaixam.
- M4: observar se jogador entende os bônus e deseja repetir; ajustar conteúdo com evidência.
- M5: aprovação do proprietário sobre APK concreto, identificado por versão/hash, sem testes críticos pendentes.

## Definição de concluído

Uma pessoa nova aprende no tutorial, completa as seis regiões, vê suas vilas preservadas, fecha/reabre sem perder progresso, visita/rejoga com segurança, usa modo livre e configurações, e joga offline no Android declarado como suportado. Créditos/licenças completos, builds repetíveis, documentação coerente e defeitos bloqueantes resolvidos.

Publicação na Play Store não é pré-requisito para concluir a versão jogável nem está autorizada automaticamente. Não estimar datas ou garantir consumo de créditos sem medir o primeiro ciclo.

## Validação específica da mudança

Dimensões 20 × 20, orçamento de 60 colocações e áreas construíveis maiores devem ser reavaliados após o primeiro teste; não aumentar conteúdo automaticamente para justificar mapa grande. No M1/M2, verificar se deslocamento não torna a partida cansativa ou dissolve a pressão espacial. Movimento da câmera deve estar pronto no M0.1, não adiado como acabamento.
