# untEntGNRE

## Responsabilidade

Tela de digitação de uma guia (`TfrmEntGNRE`, herda `TfrmPaiEdit`): dados da guia e do contas a
pagar na aba 1, itens que terão a guia na aba 2. Não grava no banco — devolve os dados no objeto
`TGnre` recebido e fecha com `mrOk`.

## Caminho

`padra_atualizado/fontes/movimentacaoitens/untEntGNRE.pas` + `.dfm` — encoding cp1252.

## Comportamento

Aberta só por `TGNRE.fTelaGnre` ([untGNRE](untGNRE.md)), que cria o form, define `TipoChamada`,
atribui `objGnre` e `blnEditando` e chama `ShowModal`. A grade de itens liga direto em
`objGnre.cdsItens.dtsSource`: marcar item e alterar valor mexem no conjunto de itens da guia em memória.

- `FormShow` copia as propriedades do `objGnre` para os campos, guarda backup dos itens (`cdsBackup`),
  aplica as configurações de exibição e, em edição, trava os campos (`pSetaEdit`) e foca a autenticação bancária.
- `fValidaCampos` grava cada campo em `objGnreValidaCampos` — um `TGnre` de rascunho cujos *setters*
  lançam exceção quando o valor é inválido — e trata dependências (fornecedor carrega UF/IE/portador e
  dados bancários; vencimento e portador; plano de contas e centro de custo).
- `btnGravarClick` valida tudo, exige item marcado (exceto TCIF/TS), soma dos itens = valor recolhido
  e pagamento antecipado coerente; copia os campos para `objGnre` e fecha com `mrOk`.
- Fechar sem OK restaura os itens do backup.

TCIF e TS (`pSetTipoChamada`) escondem CST, marcação, base de cálculo e rateio; trocam o campo de
valor da grade e do rodapé para `ENT_VLTCIF`/`ENT_VAL_TS` e os títulos da tela e das abas.

Com empresa DARE (`fEhEmpresaDARE`), os textos trocam GNRE pelo nome DARE (`fTrocaNomeGNRE`) e o
frame carrega as guias 7, 4, 5 e 6.

## Configurações que impactam esta unit

| Código CFGSIS | Efeito |
|---------------|--------|
| `PAGGNR` | `1`: "Gravar Contas a pagar da Guia?" marcado e travado. `2`: bloqueia pagamento antecipado; em edição, libera data da guia, vencimento, base e valor |
| `CTPAVI` | Vencimento hoje exige portador |
| `GNRRAT` | `1` mostra "Ratear Valor da GNRE" |
| `VALELE` | Com nota eletrônica, esconde o rateio |
| `IFCPST` | Mostra a coluna "Vr. ST FCP" |
| `AJUGIA` | Desligada esconde as colunas de ICMS/ST/alíquota interna. Ligada sem `GIAINT`/`GIAPRO`: aviso ao abrir |
| `GIAINT`, `GIAPRO` | Conferidas ao abrir quando `AJUGIA` |
| `USACTF` | Pesquisa de plano de contas filtrada pelo fornecedor; valida vínculo e situação ativa |
| `CTPOBE` | Centro de custo obrigatório |

## Tabelas

| Tabela | L/G | Onde |
|--------|-----|------|
| `TIPTRI` / `GUITRI` | L | `OpenQueryTipoTributo` (guias 4, 5, 6, 7) |
| Plano de contas (`pPesquisaCadCta`) | L | `pCarregaCentroCusto` |

As demais leituras (fornecedor, banco, portador, evento) passam por funções de consulta do projeto.

## Métodos

| Método | Tipo | O que faz | Efeito colateral |
|--------|------|-----------|------------------|
| `FormCreate` | evento | Cria rascunho de validação, backup, frame do contas a pagar, query de tributos; aplica `CTPAVI`, `GNRRAT`, `IFCPST` | — |
| `FormShow` | evento | Carrega a guia na tela; ver Comportamento | Backup dos itens |
| `FormClose` | evento | Sem OK, restaura os itens do backup; libera o frame | Restaura `cdsItens` |
| `FormKeyDown` | evento | F4 marca todos, F5 desmarca todos | — |
| `fValidaCampos` | function | Validação campo a campo (ver acima) | Mensagens; foco |
| `fValidaDataVencimento` | function | Vencimento ≥ data da guia | Mensagem |
| `fVerificaTotalGNRE` | function | Valor > 0 e soma dos itens marcados = valor recolhido; senão explica a diferença | Mensagem |
| `VerificaPagtoAntecipado` | function | Pagamento antecipado marcado exige duplicata selecionada | Mensagem |
| `btnGravarClick` | evento | Valida e copia os campos para `objGnre`; `mrOk` | — |
| `btnExcluirClick` ("Limpar tudo") | evento | Limpa os campos e o rascunho | — |
| `btnRateioClick` | evento | Confirma e chama `objGnre.fRateiaGnre` | Altera valores dos itens |
| `btnMarcarTodosClick` / `btnDesmarcarTodosClick` | evento | `pMarcarTodos`; itens travados (`ENT_GNRFIX`) ficam marcados | Altera itens |
| `btnPagAntClick` / `chkPagAntClick` | evento | Seleção de duplicatas de pagamento antecipado | — |
| `btnExportaExcelClick` | evento | Exporta a grade | Arquivo |
| `cxgItensCOMGNRPropertiesChange` | evento | Impede desmarcar item travado | — |
| `cxgItensVALGNRPropertiesChange` | evento | Item não marcado fica com valor 0 | — |
| Rodapé (`...SummaryItemsSummary` / `...GetText`) | evento | Soma só os marcados; fora de edição, joga o total no valor recolhido (e na base, em TCIF/TS) | — |
| `cxgItensViewKeyPress` / `EditKeyPress` | evento | Bloqueia o sinal `-` | — |
| `pCalculaBaseGnre` / `tabDadosShow` | procedure | Tributada com base 0: soma `BASCAL` dos itens marcados | — |
| `pSetTipoChamada` | setter | Ajusta a tela para TCIF/TS | — |
| `pSetaEdit` | procedure | Em edição, desabilita os campos exceto autenticação bancária (e datas/base/valor com `PAGGNR = 2`) | — |
| `pLimparTudo` | procedure | Limpa campos; reaplica `PAGGNR` | — |
| `pCarregaCentroCusto` | procedure | Descrição do plano de contas filtrado | Lê banco |
| `OpenQueryTipoTributo` | procedure | Guias e tributos | Lê banco |
| Pesquisas (`edtCodFor`, `edtCodPor`, `edtBcoGnr`, `fraCtaPagar...`) | evento | Consultas de fornecedor, portador, banco, plano de contas, centro de custo, tributo | — |

## Tela associada (.dfm)

| Componente | Disparo |
|------------|---------|
| `btnGravar` ("&Gravar") | Valida e devolve a guia |
| `btnExcluir` ("&Limpar tudo") | Limpa a guia (oculto em edição) |
| `btnRateio` ("&Ratear Valor da GNRE") | Rateio pelo total dos itens |
| `btnMarcarTodos` / `btnDesmarcarTodos` (F4/F5) | Marcação em massa |
| `btnExportaExcel` | Exporta a grade |
| `chkGnrFin` ("Gravar Contas a pagar da Guia?") | Define `blnGraFin` |
| `chkPagAnt` + `btnPagAnt` | Pagamento antecipado |
| `tabDados` ("1 - Informações da GNRE") | Fornecedor, UF, IE, datas, banco, agência, autenticação, base, valor recolhido, mês/ano, convênio, portador, frame do contas a pagar |
| `tabItens` ("2 - Itens que terão GNRE") | Grade: código, descrição, CST, "Com GNRE", "Valor GNRE", produto, CT-e, % base ST, IVA, bases e valores de ICMS/ST, ST da NF, FCP, valor calculado, NCM |

## Pontos de atenção

- `pSetaEdit` percorre a global `frmEntGNRE`, não `Self` — funciona porque `fTelaGnre` usa essa global.
- `pCalculaBaseGnre` usa `StrToFloat` (trava do pre-commit); `fValidaCampos` usa `With...Do`. Ambos pré-existentes.
- O valor recolhido é sobrescrito pelo total do rodapé sempre que a grade recalcula fora de edição.
- Em edição, `fVerificaTotalGNRE` continua exigindo soma = valor: a guia gravada só passa se os itens
  dela carregarem o valor dela — ver a separação de itens em [untGNRE](untGNRE.md).

## Alterações documentadas

| Data | Requisito/Revisão | O que mudou |
|------|-------------------|-------------|
| 2026-10-16 | Mapeamento (`--analisar`), base r500183 | Documentação inicial da unit inteira; sem alteração de código |
