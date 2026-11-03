# Alternativa concreta de CI manual — inativa

A [receita YAML](M0_1_ANDROID_MANUAL.yml) usa os mesmos scripts e lock da branch do PR #2. Está em reports/ci, não em .github/workflows: **não foi ativada ou executada**, não consome runner e não produz um APK por existir no repositório. Nenhum limite da conta foi presumido como aprovado.

## Condições antes de executar

1. Proprietário conferir em Settings → Actions se GitHub Actions e as actions fixadas são permitidas, e em Billing/Usage/Artifacts os limites e eventual custo/armazenamento da conta. Ser repositório público ou ter permissão de push não comprova esses limites. A tentativa de consultar actions/permissions pelo conector retornou INVALID_ARGUMENT (endpoint não admitido pela ferramenta); isso não equivale a Actions desabilitado ou permissão negada pelo GitHub. Billing/quota não foram confirmados; portanto nenhum dispatch está autorizado por inferência.
2. Revisar a receita: ubuntu-24.04 padrão, timeout de 30 minutos, uma execução por vez, contents:read, sem persistir credenciais no checkout, sem secrets, actions fixadas por SHA oficial e retenção de artefatos de três dias. Não usar runner maior/pago ou ampliar orçamento automaticamente. Verificar espaço do runner antes do setup (o script exige ao menos 4 GB livres).
3. Ativação requer uma mudança de configuração separadamente revisada: o GitHub exige o workflow no branch padrão para oferecer workflow_dispatch. Copiar a receita para .github/workflows/m0-1-android.yml no branch padrão somente por fluxo autorizado. Isso não foi feito nesta tarefa; não requer integrar o código do PR #2 ou fazer seu merge automaticamente.
4. Depois de permissões/limites confirmados e configuração aprovada, executar manualmente pela página Actions, informando o **SHA completo revisado** da implementação do PR #2 e marcando account_limits_verified. O default é false e o job não inicia sem essa confirmação. Não usar uma branch móvel como fonte da build.

## Resultado verificável

O runner baixa ferramentas de fontes oficiais com os hashes existentes, executa 157 checks de componentes, a suíte adicional da entrada Input/GUI e os testes Python com fixtures, e tenta a exportação real. Não muda versões para contornar falhas; se o catálogo SDK divergir do lock, interrompe e preserva o diagnóstico.

Somente após exportação/validação/assinatura bem sucedidas é enviado o artefato debug com APK, SHA-256 e export_result.json. Diagnósticos são disponibilizados separadamente em caso de falha. SDK, caches, keystore e fixtures de teste não são enviados como APK ou comitados. Um sucesso de fixture no teste Python não libera o upload de APK: a etapa de exportação usa o processo real e deve sair com zero.

Registrar URL/run ID/SHA da fonte, resultado e hash do APK efetivo no relatório antes de pedir teste no celular. Até existir essa evidência, CI, APK e testes físicos continuam NOT_RUN/BLOCKED, conforme o caso. Não criar release ou publicar jogo.

Fontes das actions verificadas pela API: [checkout v4](https://github.com/actions/checkout/tree/11d5960a326750d5838078e36cf38b85af677262) e [upload-artifact v4](https://github.com/actions/upload-artifact/tree/ea165f8d65b6e75b540449e92b4886f43607fa02).
