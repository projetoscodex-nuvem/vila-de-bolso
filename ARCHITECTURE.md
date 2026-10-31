# Arquitetura inicial

## Stack

Godot 4.x estável, GDScript, renderer Compatibility para 2D. A versão exata não foi fixada nesta preparação; M0.1 deve escolher uma release estável oficial, registrar versão e origem e usar templates de exportação da mesma release. Sem C#, engine própria ou backend.

A escolha de versão do Android SDK/JDK deve seguir a documentação da release selecionada. A página estável consultada recomenda JDK 17; isso não prova ambiente pronto. Definir minSdk e aparelhos de referência antes do teste físico, com base no suporte efetivo da engine e aparelho do proprietário, sem declarar compatibilidade com todo Android.

## Responsabilidades

- domain/: estado de tabuleiro, validação, pontuação, ofertas, objetivos e progressão, sem dependência de nós visuais.
- data/: definições de peças, terrenos, ofertas, metas e versões de regras/templates.
- persistence/: serialização, validação, migração, backup e gravação segura.
- presentation/: menu, reino, fase, resultado, tutorial e configurações.
- tests/: casos headless do domínio e persistência; fixtures sem efeito no perfil real.
- scripts/: setup, verificação e exportação repetíveis.
- assets/: somente arquivos necessários e suas licenças.
- reports/: evidências de marcos e smoke tests, sem saves pessoais desnecessários.

Não implementar todas as camadas antecipadamente: criar somente o necessário ao marco. Um único projeto Godot, componentes pequenos e recursos/dados simples.

## Tabuleiro e reino

Cada fase contém 20 × 20 = 400 células com terrain e piece opcional. Região possui region_id estável, posição no macro mapa, template_id/version e rules_version. No arranjo 2 × 3, coordenada global lógica = (region_col × phase_width + x, region_row × phase_height + y), com phase_width = phase_height = 20 nesta baseline, resultando em 40 × 60 = 2.400 células. Dimensões ficam em dados/configuração, sem espalhar números mágicos por UI, scoring ou save. Rios de borda pertencem aos terrenos das regiões; reservar suas células no template. Não inventar uma coluna extra de água que quebre o encaixe. Mundo finito: esta mudança não requer streaming, servidor ou geração infinita.

Renderer do reino lê o mesmo snapshot que a visita local. Não deduzir construções apenas de score e não gerar povoado substituto. Alinhamento visual/contagem exatos dos mockups não são dados canônicos; os templates reais serão definidos em arquivos e validados.

Construções de regiões diferentes não interagem nas regras. Caminhos podem ser decoração automática derivada da vila, sem ocupar célula nem alterar score; não introduzir uma sétima peça necessária.

## Dados de uma partida

session_id, region_id ou sandbox_id, template/rules/offer_versions, sequência de ofertas, offer_cursor, terrain, placed_pieces, turn_count, rerolls_remaining, undo_remaining, snapshot de desfazer, tutorial_state, pontuação e objetivos. Campos derivados devem ser recalculados/conferidos no carregamento, não confiados cegamente.

## Save local

Em user://, JSON versionado ou recurso equivalente justificado. Envelope: schema_version, app_version, rules_version e revision. Conter settings, progresso, vilas concluídas, recordes e tentativa ativa. Gravação em temporário no mesmo diretório, fechamento e substituição controlada; conservar último save válido. Testar falha/interrupção. Não alegar atomicidade de uma sequência de múltiplos arquivos.

Fechar/pausar solicita salvamento sem depender apenas de callbacks finais: salvar após ações relevantes. Reabrir restaura oferta e quotas, não apenas o terreno. A integração de uma vila atualiza snapshot e desbloqueio no mesmo envelope.

Rejogar usa tentativa separada até confirmação de substituição; recorde e vila exibida têm identidades distintas. Atualização de template não pode redesenhar silenciosamente vilas existentes. Migração somente com regra explícita, validação e cópia de segurança.

## Cloud e Android

Build em linha de comando, sem depender de desktop gráfico ou emulador com aceleração. Verificar CPU, disco e memória antes de instalar SDK. Criar scripts idempotentes e registrar versões. Instalação feita em uma tarefa não equivale a setup persistente do ambiente; instruir como usar o script no setup e republicar após mudanças.

APK debug para teste físico; artefato disponibilizado por download da tarefa quando suportado ou artifact de CI. Não comitar binário no Git. Em CI, permissões mínimas e execução manual inicial, com limites de conta verificados antes de consumir recursos. Signing de release e Play Store somente em etapa separada.

## Segredos e rede

O jogo não precisa de internet. Ferramentas de desenvolvimento podem baixar fontes oficiais. Sem chave de API de IA. Keystore de produção e credenciais ficam fora do repositório. Não registrar senhas/tokens em relatórios. Uma debug key reproduzível ou preservada apenas em ambiente apropriado evita reinstalação surpresa; documentar se a troca de chave exigir desinstalar e perder save.

## Câmera e entrada — obrigatório desde M0.1

MapViewport/CameraController separados de BoardState e KingdomState. Uma Camera2D ou solução equivalente controla posição/zoom. HUD em CanvasLayer/Control equivalente não acompanha o mundo. GestureRouter arbitra UI, TAP_CANDIDATE, PAN, PINCH e CANCELLED. Não distribuir o mesmo toque como clique de construção e gesto de câmera.

ScreenToWorld → WorldToCell deve ser função verificável sob pan/zoom/offset de HUD. Screen-to-world da fase usa origem local; reino aplica posição da região. Usar colisões/retângulos de UI e consumo de evento para não mover mapa por baixo dos botões. Dedos adicionais, cancelamento e app em segundo plano limpam gestos transitórios.

Zoom tem limites configuráveis por viewport; o foco da pinça deve permanecer aproximadamente sob os dedos. Clamp impede perder o mapa fora da tela. Visão geral opcional calcula enquadramento; início/restauração usa escala de interação, sem forçar fit-all. Ao entrar numa fase nova, centralizar em área construível inicial identificada no template.

Persistir posição/zoom da câmera do reino e de cada fase visitada como estado de apresentação versionado, separado das peças. Validar/clamp ao carregar e após mudança de viewport. Não salvar dedos/gesto ativo nem prévia pendente. Se posição salva for inválida, recentrar sem apagar progresso. Consultar MAP_AND_CAMERA.md.

Verificações headless podem provar matemática e transições de gestos sintéticos. Sensação de navegação, oclusão por dedos e precisão da pinça continuam NOT_RUN sem teste no Android.
