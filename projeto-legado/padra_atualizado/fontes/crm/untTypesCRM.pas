unit untTypesCRM;

interface

resourcestring
  sqlOpePrepte   = 'SELECT PRE_CODOPE AS CODOPE                     '+
                   '  FROM PREPTE                                   '+
                   ' WHERE PRE_DOCABS = :NUMDOC                     '+
                   '   AND PRE_ESPABS = :ESPDOC                     '+
                   '   AND PRE_EMPABS = :CODEMP                     ';

  sqlOpeTransfer = 'SELECT F.FGO_CODVEN AS CODOPE                   '+
                   '  FROM PREPTE P                                 '+
                   '  JOIN FATGOR F ON P.PRE_NUMDOC = F.FGO_NUMDOC  '+
                   '               AND P.PRE_ESPDOC = F.FGO_ESPDOC  '+
                   '               AND P.PRE_EMPDOC = F.FGO_CODEMP  '+
                   ' WHERE P.PRE_DOCABS = :NUMDOC                   '+
                   '   AND P.PRE_ESPABS = :ESPDOC                   '+
                   '   AND P.PRE_EMPABS = :CODEMP                   ';

  sqlOpeSeparador= 'SELECT E.FGO_SEPEXP AS CODOPE                   '+
                   '  FROM EXTGOR E                                 '+
                   '  JOIN FATGOR F ON E.FGO_SEQFGO = F.AUTOINCREM  '+
                   ' WHERE F.FGO_NUMDOC = :NUMDOC                   '+
                   '   AND F.FGO_ESPDOC = :ESPDOC                   '+
                   '   AND F.FGO_CODEMP = :CODEMP                   ';

  sqlOpeBaixaSepExp = 'SELECT IFNULL(E.FGO_OPBXSE,E.FGO_OPEEXP) AS CODOPE '+
                      '  FROM EXTGOR E                                 '+
                      '  JOIN FATGOR F ON E.FGO_SEQFGO = F.AUTOINCREM  '+
                      ' WHERE F.FGO_NUMDOC = :NUMDOC                   '+
                      '   AND F.FGO_ESPDOC = :ESPDOC                   '+
                      '   AND F.FGO_CODEMP = :CODEMP                   ';

  sqlOpeEstorSep = 'SELECT E.FGO_OPESSE AS CODOPE                   '+
                   '  FROM EXTGOR E                                 '+
                   '  JOIN FATGOR F ON E.FGO_SEQFGO = F.AUTOINCREM  '+
                   ' WHERE F.FGO_NUMDOC = :NUMDOC                   '+
                   '   AND F.FGO_ESPDOC = :ESPDOC                   '+
                   '   AND F.FGO_CODEMP = :CODEMP                   ';

  sqlOpeCompra   = 'SELECT G.PCG_CODOPE AS CODOPE                   '+
                   '  FROM PCMGER G                                 '+
                   '  JOIN PCMDET D ON D.PCD_NUMPED = G.PCG_NUMPED  '+
                   '               AND D.PCD_CODEMP = G.PCG_CODEMP  '+
                   '               AND D.PCD_ESPDOC = G.PCG_ESPDOC  '+
                   '               AND D.PCD_NUMCTN = G.PCG_NUMCTN  '+
                   '  JOIN MOVRCD R ON R.RCD_SEQPCD = D.AUTOINCREM  '+
                   ' WHERE R.RCD_DOCPDV = :NUMDOC                   '+
                   '   AND R.RCD_ESPPDV = :ESPDOC                   '+
                   '   AND R.RCD_EMPPDV = :CODEMP                   ';

  sqlVenPedido   = 'SELECT F.FGO_CODVEN AS CODOPE                   '+
                   '  FROM FATGOR F                                 '+
                   ' WHERE F.FGO_NUMDOC = :NUMDOC                   '+
                   '   AND F.FGO_ESPDOC = :ESPDOC                   '+
                   '   AND F.FGO_CODEMP = :CODEMP                   ';

type

  TTriggerCRMGroup = (tcgOrcamentoVenda         = 1,
                      tcgPedidoVenda            = 2,
                      tcgExpedicaoTipo2         = 3,
                      tcgExpedicaoTipo3         = 4,
                      tcgExpedicaoTipo4         = 5,
                      tcgRomaneioComExpedicao234= 6,
                      tcgExpedicaoTipo5         = 7,
                      tcgFormulacaoTinta        = 8,
                      tgcIntegracoes            = 9,
                      tgcFinanceiro             = 10,
                      tgcConfirmacaoDocumento       = 11,
                      tgcGarantia);

  TTriggerCRMItem = (tciInclusaoOrcamento           = 11,
                     tciAlteracaoOrcamento          = 12,
                     tciOrcamentoEmPedido           = 13,
                     tciOrcamentoFaturado           = 14,
                     tciOrcamentoBaixado            = 15,
                     tciInclusaoPedido              = 21,
                     tciImpressaoSeparacao          = 22,
                     tciAlteracaoPedido             = 23,
                     tciPedidoFaturadoParcial       = 24,
                     tciPedidoFaturado              = 25,
                     tciPedidoBaixado               = 26,
                     tciLiberacaoPedido             = 27,
                     tciBaixaExpedicao              = 31,
                     tciBaixaSeparacao              = 47,
                     tciConferenciaExpedicao        = 52,
                     tciInclusaoRomaneio            = 61,
                     tciBaixaRomaneio               = 62,
                     tciInclusaoPreRomaneio         = 71,
                     tciConferenciaExpedicaoRomaneio= 73,
                     tciAtivacaoPreRomaneio         = 76,
                     tciExclusaoRomaneio            = 77,
                     tciRegistroOcorrenciaRomaneio  = 78,
                     tciProducaoTintaMaquina        = 81,
                     tciInclusaoPedOrcIntegracao    = 91,
                     tciAlteracaoPedOrcIntegracao   = 92,
                     tciGeraDuplicata               = 93,
                     tciImpressaoBoleto             = 94,
                     tciGeraRemessaBancaria         = 95,
                     tciCancelaRemessaBancaria      = 96,
                     tciEnviaDuplicataBanco         = 97,
                     tciCancelaEnvioDuplicataBanco  = 98,
                     tciImportaRetornoBancario      = 99,
                     tciBaixaAutomaticaDuplicata    = 32,
                     tciBaixaParcial                = 33,
                     tciBaixaTotal                  = 34,
                     tciEstorno                     = 35,
                     tciAlteraPorDesEvento          = 36,
                     tciGeraDespesaProtesto         = 37,
                     tciRestauraRemessaBancaria     = 38,
                     tciAgrupaDuplicatas            = 39,
                     tciDesagrupaDuplicatas         = 40,
                     tciAcertoContas                = 41,
                     tciGeraDuplicatasReceber       = 42,
                     tciGeraNotaDebito              = 43,
                     tciExcluiDuplicata             = 44,
                     tciAlteracaoCliente            = 45,
                     tciRealizadaConfirmacaoDocumento = 46,
                     tciGarantiaAndamentoPendLibCrd    = 63,
                     tciGarantiaAndamentoPendEnvCli    = 64,
                     tciGarantiaCredito                = 65,
                     tciGarantiaCancelada              = 66,
                     tciGarantiaReposicaoItemConcluida = 67);

const
  TRIGGER_CRM_ITENS_GRUPO_GARANTIA = [tciGarantiaAndamentoPendLibCrd,
                                      tciGarantiaAndamentoPendEnvCli,
                                      tciGarantiaCredito,
                                      tciGarantiaCancelada,
                                      tciGarantiaReposicaoItemConcluida];
Type
  TAcaoFatCRM = (afcNenhum,
                 afcOrcamento,
                 afcOrcamentoEmPedido,
                 afcOrcamentoFaturado,
                 afcPedido,
                 afcPedidoAgReqCompra,
                 afcPedidoReqCompraGerada,
                 afcPedidoAgCompra,
                 afcReqCompraNaoVaiComprar,
                 afcReqCompraPossuiEstoque,
                 afcReqCompraDesvinculada,
                 afcItemDesvinculadoReqCompra,
                 afcCompraEfetuada,
                 afcPDTransferenciaGerado,
                 afcPedidoAgPDTransferencia,
                 afcPedidoAgTransferencia,
                 afcPDTransferenciaFaturado,
                 afcPDTransferenciaBaixado,
                 afcItemDesvinculadoPDTransf,
                 afcPedidoAgEntrega,
                 afcPedidoInclusaoPreNota,
                 afcPedidoCancelaPreNota,
                 afcPedidoCPAgConferencia,
                 afcPedidoPreNotaConferida,
                 afcPedidoAgEntrada,
                 afcPedidoEntradaMercadoria,
                 afcPedidoAgMovimentoFiscal,
                 afcNotaEntAgEnderecamento,
                 afcEnderecamentoFinalizado,
                 afcPedidoLiberado,
                 afcPedidoLiberacaoCancelado,
                 afcPedidoNegado,
                 afcPedidoCorte,
                 afcPedidoConferido,
                 afcPedidoEnderecado,
                 afcPedidoFaturadoParcial,
                 afcPedidoFaturado,
                 afcExpedicao,
                 afcPedidoAgRomaneio,
                 afcRomaneioInclusao,
                 afcRomaneioExclusao,
                 afcRomaneioAlteracao,
                 afcRegistroOcorrenciaRomaneio,
                 afcRomaneioAtivacao,
                 afcRomaneioBaixa,
                 afcRomaneioCancelamento,
                 afcDevolucao,
                 afcExtornoSeparacao,
                 afcPedidoAgSeparacao,
                 afcSeparacaoImpressa,
                 afcPedidoAgFaturamento,
                 afcDocumentoCancelado,
                 afcVendaOrcamento,
                 afcVendaPedido,
                 afcGeraDuplicata,
                 afcImpressaoBoleto,
                 afcGeraRemessaBancaria,
                 afcCancelaRemessaBancaria,
                 afcEnviaDuplicataBanco,
                 afcCancelaEnvioDuplicataBanco,
                 afcImportaRetornoBancario,
                 afcBaixaAutomaticaDuplicata,
                 afcBaixaParcial,
                 afcBaixaTotal,
                 afcEstorno,
                 afcAlteraPorDesEvento,
                 afcGeraDespesaProtesto,
                 afcRestauraRemessaBancaria,
                 afcAgrupaDuplicatas,
                 afcDesagrupaDuplicatas,
                 afcAcertoContas,
                 afcGeraDuplicatasReceber,
                 afcGeraNotaDebito,
                 afcExcluiDuplicata,
                 afcAlteracaoCliente,
                 afcFinalizaOcoExclusaoFatGor,
                 afcBaixaPedidoNaoEntregue,
                 afcConfirmacaoDocumento,
                 afcAlteracaoTemperaturaAtend,
                 afcFaturaPedidoAgrupado,
                 afcReabrirDocumentoFaturado,
                 afcGarantiaAndamentoPendLibCrd,
                 afcGarantiaAndamentoPendEnvCli,
                 afcGarantiaCredito,
                 afcGarantiaCancelada,
                 afcGarantiaReposicaoItemConcluida,
                 afcGarantiaAndamentoPendLibCrd_Confirmacao,
                 afcGarantiaAndamentoPendEnvCli_Confirmacao);

  TTriggerCRMGroupHelper = record Helper for TTriggerCRMGroup
  public
    function fAtivo: Boolean;
    function fGetCodigo: Integer;
    function fGetDescricao: String;
  end;

  TTriggerCRMItemHelper = record Helper for TTriggerCRMItem
  public
    function fAtivo(const tcgGroup: TTriggerCRMGroup): Boolean;
    function fGetCodigo: Integer;
    function fGetSituacao: String;
    function fGetDescricao: String;
    function fPertenceAoGrupo(const tcgGroup: TTriggerCRMGroup): Boolean;
  end;

  TAcaoFatCRMHelper = record Helper for TAcaoFatCRM
  protected
    function fGetSQLOperador: String;
  public
    function fGetDescricao: String;
    function fGetOperador(const strNumDoc, strEspDoc, strCodEmp: String): String;
    function fGetSituacao(const strEspDoc: String = ''; const strEspOrc: String = ''): String;
  end;

  TTipoOperacaoOcorrencia = (tpInclusao, tpAlteracao, tpExclusao);

  TEspDoc = (tpPedido, tpOrcamento);

  tTipoExibicaoOcorrenciasCRM = (tpGrid, tpCalendario);
  tTipoMovimentoTela = (tColapse, tExpand);
  tAreaAjuste = (filtros, historico);

  TTip_Fc = (tpCliente, tpProspecto, tpFornecedor);

  TStatusProspe = (tstNenhum = -1, tstProspeComContatoVendaNaoPassivel = 0, tstProspeSemContatoVendaPassivel = 1, tstProspeComContatoVendaPassivel = 2);

  TOrdCnsLead = (tpNenhum, tpNumLead, tpDatCad, tpCodCli, tpCodOpe, tpCliOpe);

  function fStrToTEspDoc(const strEspDoc: String): TEspDoc;
  function fTEspDocToStr(const aEspDoc: TEspDoc): String;

  function fStrToTTip_Fc(const strTip_Fc: String): TTip_Fc;
  function fTTip_FcToStr(const aTip_Fc: TTip_Fc): String;

  function fStrToTStatusProspe(const strStatus: String): TStatusProspe;
  function fTStatusProspeToStr(const aStatus: TStatusProspe): String;


const
  arrEspDoc : array[TEspDoc] of string = ('PD', 'OR');
  arrTip_Fc: array[TTip_Fc] of string = ('C', 'P', 'F');
  arrStatPro: array[TStatusProspe] of string = ('', 'D', 'I', 'A');
  arrDescStatPro: array[TStatusProspe] of string = ('',
                                                    'D - Prospecto que já foi contactado e não é passível de venda, por qualquer motivo',
                                                    'I - Prospecto que ainda não foi contactado ou foi contactado e é passível de venda, mas não conseguiu iniciar trabalho com ele',
                                                    'A - Prospecto que já foi contactado, é passível de venda, e está sendo trabalhado');
  arrOrdCnsLead: array[TOrdCnsLead] of string = ('Nenhum', 'Num.Lead', 'Data Cadastro', 'Cliente', 'Vendedor', 'Cliente/Vendedor');
  arrOrdSQLCnsL: array[TOrdCnsLead] of string = ('', 'LDG_NUMDOC', 'LDG_DTACAD', 'CODCLI', 'NOM_VEN', 'CODCLI, NOM_VEN');

implementation

uses
  System.SysUtils,
  System.StrUtils,
  System.TypInfo,
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'};
{$ELSE }
  Uni,
  untFuncoesSimples;
{$ENDIF LINUX}

{ TTriggerCRMGroupHelper }

function TTriggerCRMGroupHelper.fAtivo: Boolean;
var
  strTipExp : String;
begin
  strTipExp := fCfgSis('TIPEXP', varString);

  Case Self Of
    tcgExpedicaoTipo2         : Result := (Pos(strTipExp, '2_') > 0);
    tcgExpedicaoTipo3         : Result := (Pos(strTipExp, '3_') > 0);
    tcgExpedicaoTipo4         : Result := (Pos(strTipExp, '4_') > 0);
    tcgRomaneioComExpedicao234: Result := (Pos(strTipExp, '2_3_4_') > 0);
    tcgExpedicaoTipo5         : Result := (Pos(strTipExp, '5_') > 0);
    tcgFormulacaoTinta        : Result := (VS_strUsaTmq = 'S');
  Else
    Result := True;
  End;
end;

function TTriggerCRMGroupHelper.fGetCodigo: Integer;
begin
  Result := Ord(Self) * 100; //Conversão para o grupo 100/200
end;

function TTriggerCRMGroupHelper.fGetDescricao: String;
begin
  Case Self Of
    tcgOrcamentoVenda         : Result := 'Orçamento de Venda';
    tcgPedidoVenda            : Result := 'Pedido de Venda';
    tcgExpedicaoTipo2         : Result := 'Expedição Tipo [2]: Faturamento antes da expedição';
    tcgExpedicaoTipo3         : Result := 'Expedição Tipo [3]: Faturamento depois da expedição';
    tcgExpedicaoTipo4         : Result := 'Expedição Tipo [4]: O pedido não será faturado';
    tcgRomaneioComExpedicao234: Result := 'Romaneio com Expedição Tipo [2/3/4]';
    tcgExpedicaoTipo5         : Result := 'Expedição Tipo [5]: Expedição por romaneio. O pedido não será faturado';
    tcgFormulacaoTinta        : Result := 'Formulação de Tinta de Máquina';
    tgcIntegracoes            : Result := 'Pedidos/Orçamentos - Integrações (WebService/B2B/Força de vendas)';
    tgcFinanceiro             : Result := 'Financeiro';
    tgcConfirmacaoDocumento   : Result := 'Confirmação de Documento';
    tgcGarantia               : Result := 'Garantia';
  Else
    Result := '';
  End;
end;

{ TTriggerCRMItemHelper }

function TTriggerCRMItemHelper.fAtivo(const tcgGroup: TTriggerCRMGroup): Boolean;
var
  strTipExp : String;
begin
  strTipExp := fCfgSis('TIPEXP', varString);

  Case Self Of
    tciPedidoFaturado,
    tciImpressaoSeparacao,
    tciPedidoFaturadoParcial:
      Begin
        If (tcgGroup = tcgPedidoVenda) Then
          Result := (Pos(strTipExp, '1_2_') > 0)
        Else
          Result := True;
      End;
    tciLiberacaoPedido:
      Result := fCfgSis('LIBPED', varBoolean);
    tciBaixaSeparacao:
      Result := fCfgSis('BAISEP', varBoolean);
  Else
    Result := True;
  End;
end;

function TTriggerCRMItemHelper.fGetCodigo: Integer;
var
  LAux: String;
begin
  LAux := IntToStr(Ord(Self));
  LAux := Concat(LeftStr(LAux, 1), '0', RightStr(LAux, 1));
  Result := StrToInt(LAux);
end;

function TTriggerCRMItemHelper.fGetDescricao: String;
begin
  Case Self Of
    tciInclusaoOrcamento            : Result := 'Inclusão do Orçamento';
    tciAlteracaoOrcamento           : Result := 'Alteração do Orçamento';
    tciOrcamentoEmPedido            : Result := 'Transformação do Orçamento em Pedido de Venda';
    tciOrcamentoFaturado            : Result := 'Faturamento do Orçamento em documento de Venda ( F11, VENDA NORMAL )';
    tciOrcamentoBaixado             : Result := '[F10] Baixa de Orçamento que não será entregue';
    tciInclusaoPedido               : Result := 'Inclusão do Pedido';
    tciImpressaoSeparacao           : Result := 'Impressao da Separação';
    tciAlteracaoPedido              : Result := 'Alteração do Pedido';
    tciPedidoFaturadoParcial        : Result := 'Faturamento Parcial do Pedido documento de Venda ( F11, VENDA NORMAL, CONF.DE PEDIDOS, EXPEDIÇÃO  )';
    tciPedidoFaturado               : Result := 'Faturamento Total   do Pedido documento de Venda ( F11, VENDA NORMAL, CONF.DE PEDIDOS, EXPEDIÇÃO  )';
    tciPedidoBaixado                : Result := '[F10] Baixa de Pedido que não será entregue';
    tciLiberacaoPedido              : Result := 'Liberação de Pedido';
    tciBaixaExpedicao               : Result := 'Baixa da Expedicao';
    tciBaixaSeparacao               : Result := 'Baixa da Separação (CFG_BAISEP)';
    tciConferenciaExpedicao         : Result := 'Conferência da Expedição';
    tciInclusaoRomaneio             : Result := 'Inclusão do Pedido no Romaneio  ou  Inclusão do Documento de Venda no Romaneio';
    tciBaixaRomaneio                : Result := 'Baixa do Romaneio';
    tciInclusaoPreRomaneio          : Result := 'Inclusão do Pedido no Pré-Romaneio';
    tciConferenciaExpedicaoRomaneio : Result := 'Conferência da Expedição';
    tciAtivacaoPreRomaneio          : Result := 'Ativação do Pré-Romaneio';
    tciExclusaoRomaneio             : Result := 'Exclusão do Pedido do Romaneio  ou  Exclusão do Documento de Venda do Romaneio';
    tciRegistroOcorrenciaRomaneio   : Result := 'Registro de ocorrências no Romaneio';
    tciProducaoTintaMaquina         : Result := 'Produção de Tinta de Máquina';
    tciInclusaoPedOrcIntegracao     : Result := 'Inclusão de Pedido/Orçamento - Integrações';
    tciAlteracaoPedOrcIntegracao    : Result := 'Alteração de Pedido/Orçamento - Integrações';
    tciGeraDuplicata                : Result := 'Gera nova Duplicata';
    tciImpressaoBoleto              : Result := 'Impressão de Boleto';
    tciGeraRemessaBancaria          : Result := 'Geração de Remessa Bancária';
    tciCancelaRemessaBancaria       : Result := 'Cancelamento de Remessa Bancária';
    tciEnviaDuplicataBanco          : Result := 'Envio de Duplicata ao Banco';
    tciCancelaEnvioDuplicataBanco   : Result := 'Cancelamento de Envio de Duplicata ao Banco';
    tciImportaRetornoBancario       : Result := 'Importação do Arquivo de Retorno';
    tciBaixaAutomaticaDuplicata     : Result := 'Baixa Automática de Duplicata';
    tciBaixaParcial                 : Result := 'Baixa Parcial';
    tciBaixaTotal                   : Result := 'Baixa Total';
    tciEstorno                      : Result := 'Estorno';
    tciAlteraPorDesEvento           : Result := 'Alteração de Portador/Descontada/Evento';
    tciGeraDespesaProtesto          : Result := 'Geração de Despesa de Cobrança de Protesto';
    tciRestauraRemessaBancaria      : Result := 'Restauração de Remessa Bancária';
    tciAgrupaDuplicatas             : Result := 'Agrupamento de Duplicatas';
    tciDesagrupaDuplicatas          : Result := 'Desagrupamento de Duplicatas';
    tciAcertoContas                 : Result := 'Acerto de Contas';
    tciGeraDuplicatasReceber        : Result := 'Geração de Duplicatas a Receber';
    tciGeraNotaDebito               : Result := 'Geração de Nota de Débito';
    tciExcluiDuplicata              : Result := 'Exclusão de Duplicata';
    tciRealizadaConfirmacaoDocumento: Result := 'Realizada Confirmação de Documento';

    tciGarantiaAndamentoPendLibCrd  : Result := 'Recebimento - Em Andamento (Liberação de Crédito)';
    tciGarantiaAndamentoPendEnvCli  : Result := 'Recebimento - Em Andamento (Pendente Envio ao Cliente)';
    tciGarantiaCredito              : Result := 'Recebimento - Crédito Gerado';
    tciGarantiaCancelada            : Result := 'Garantia Cancelada';
    tciGarantiaReposicaoItemConcluida : Result := 'Recebimento - Reposição Item concluída';
  Else
    Result := '';
  End;
end;

function TTriggerCRMItemHelper.fPertenceAoGrupo(const tcgGroup: TTriggerCRMGroup): Boolean;
begin
  Case Self Of
    tciInclusaoOrcamento,
    tciAlteracaoOrcamento,
    tciOrcamentoEmPedido,
    tciOrcamentoFaturado,
    tciOrcamentoBaixado             : Result := (tcgGroup = tcgOrcamentoVenda);
    tciInclusaoPedido,
    tciAlteracaoPedido,
    tciPedidoBaixado,
    tciLiberacaoPedido              : Result := (tcgGroup = tcgPedidoVenda);
    tciImpressaoSeparacao,
    tciPedidoFaturado               : Result := (tcgGroup = tcgPedidoVenda) Or
                                                (tcgGroup = tcgExpedicaoTipo3) Or
                                                (tcgGroup = tcgExpedicaoTipo4) Or
                                                (tcgGroup = tcgExpedicaoTipo5);
    tciPedidoFaturadoParcial        : Result := (tcgGroup = tcgPedidoVenda) Or
                                                (tcgGroup = tcgExpedicaoTipo3) Or
                                                (tcgGroup = tcgExpedicaoTipo4);
    tciBaixaExpedicao               : Result := (tcgGroup = tcgExpedicaoTipo2);
    tciBaixaSeparacao               : Result := (tcgGroup = tcgExpedicaoTipo3) Or
                                                (tcgGroup = tcgExpedicaoTipo4);
    tciConferenciaExpedicao         : Result := (tcgGroup = tcgExpedicaoTipo4);
    tciExclusaoRomaneio,
    tciInclusaoRomaneio             : Result := (tcgGroup = tcgRomaneioComExpedicao234);
    tciBaixaRomaneio                : Result := (tcgGroup = tcgRomaneioComExpedicao234) Or
                                                (tcgGroup = tcgExpedicaoTipo5);
    tciRegistroOcorrenciaRomaneio   : Result := (tcgGroup = tcgRomaneioComExpedicao234) Or
                                                (tcgGroup = tcgExpedicaoTipo5);
    tciInclusaoPreRomaneio,
    tciConferenciaExpedicaoRomaneio,
    tciAtivacaoPreRomaneio          : Result := (tcgGroup = tcgExpedicaoTipo5);
    tciProducaoTintaMaquina         : Result := (tcgGroup = tcgFormulacaoTinta);
    tciInclusaoPedOrcIntegracao,
    tciAlteracaoPedOrcIntegracao    : Result := (tcgGroup = tgcIntegracoes);

    tciGeraDuplicata,
    tciImpressaoBoleto,
    tciGeraRemessaBancaria,
    tciCancelaRemessaBancaria,
    tciEnviaDuplicataBanco,
    tciCancelaEnvioDuplicataBanco,
    tciImportaRetornoBancario,
    tciBaixaAutomaticaDuplicata,
    tciBaixaParcial,
    tciBaixaTotal,
    tciEstorno,
    tciAlteraPorDesEvento,
    tciGeraDespesaProtesto,
    tciRestauraRemessaBancaria,
    tciAgrupaDuplicatas,
    tciDesagrupaDuplicatas,
    tciAcertoContas,
    tciGeraDuplicatasReceber,
    tciGeraNotaDebito,
    tciExcluiDuplicata               : Result := (tcgGroup = tgcFinanceiro);
    tciRealizadaConfirmacaoDocumento : Result := (tcgGroup = tgcConfirmacaoDocumento);

    tciGarantiaAndamentoPendLibCrd,
    tciGarantiaAndamentoPendEnvCli,
    tciGarantiaCredito,
    tciGarantiaCancelada,
    tciGarantiaReposicaoItemConcluida: Result := (tcgGroup = tgcGarantia);

  Else
    Result := False;
  End;
end;

function TTriggerCRMItemHelper.fGetSituacao: String;
begin
  Result := fCampoTabela('TRG_CODSIT', 'CRMTRG', ['TRG_CODTRG'], [IntToStr(Self.fGetCodigo())], False);
end;

{ TAcaoFatCRMHelper }

function TAcaoFatCRMHelper.fGetDescricao: String;
begin
  Case Self Of
    afcOrcamento                  : Result := 'ORÇAMENTO';
    afcOrcamentoEmPedido          : Result := 'ORÇAMENTO - TRANSFORMADO EM PEDIDO';
    afcOrcamentoFaturado          : Result := 'ORÇAMENTO - FATURADO';
    afcPedido                     : Result := 'PEDIDO';
    afcPedidoAgReqCompra          : Result := 'AGUARDANDO REQUISIÇÃO DE COMPRA';
    afcPedidoReqCompraGerada      : Result := 'REQUISIÇÃO DE COMPRA GERADA';
    afcPedidoAgCompra             : Result := 'AGUARDANDO COMPRA';
    afcReqCompraNaoVaiComprar     : Result := 'REQUISIÇÃO NEGADA - NÃO VAI COMPRAR';
    afcReqCompraPossuiEstoque     : Result := 'REQUISIÇÃO NEGADA - POSSUI ESTOQUE';
    afcReqCompraDesvinculada      : Result := 'REQUISIÇÃO DESVINCULADA DO PEDIDO DE COMPRA';
    afcItemDesvinculadoReqCompra  : Result := 'ITEM DESVINCULADO DA REQUISIÇÃO';
    afcCompraEfetuada             : Result := 'COMPRA EFETUADA';
    afcPedidoInclusaoPreNota      : Result := 'INCLUSÃO PRÉ NOTA ENTRADA';
    afcPedidoCancelaPreNota       : Result := 'CONFERÊNCIA/PRÉ NOTA CANCELADA';
    afcPedidoPreNotaConferida     : Result := 'PRÉ NOTA CONFERIDA';
    afcPDTransferenciaGerado      : Result := 'PEDIDO TRANSFERÊNCIA GERADO';
    afcPedidoAgPDTransferencia    : Result := 'AGUARDANDO PEDIDO TRANSFÊRENCIA';
    afcPedidoAgTransferencia      : Result := 'AGUARDANDO TRANSFERÊNCIA';
    afcPDTransferenciaFaturado    : Result := 'PEDIDO TRANSFERÊNCIA FATURADO';
    afcPDTransferenciaBaixado     : Result := 'PEDIDO TRANSFERÊNCIA BAIXADO - NÃO SERÁ ENTREGUE';
    afcItemDesvinculadoPDTransf   : Result := 'ITEM DESVINCULADO DO PEDIDO TRANSFERÊNCIA';
    afcPedidoAgEntrega            : Result := 'AGUARDANDO ENTREGA';
    afcPedidoCPAgConferencia      : Result := 'AGUARDANDO CONFERÊNCIA';
    afcPedidoAgEntrada            : Result := 'AGUARDANDO ENTRADA DE MERCADORIA';
    afcPedidoEntradaMercadoria    : Result := 'ENTRADA DE MERCADORIA';
    afcPedidoAgMovimentoFiscal    : Result := 'AGUARDANDO EFETIVAÇÃO MOVIMENTO FISCAL';
    afcNotaEntAgEnderecamento     : Result := 'AGUARDANDO ENDEREÇAMENTO';
    afcEnderecamentoFinalizado    : Result := 'ENDEREÇAMENTO FINALIZADO';
    afcPedidoLiberado             : Result := 'PEDIDO LIBERADO';
    afcPedidoLiberacaoCancelado   : Result := 'LIBERAÇÃO DO PEDIDO CANCELADA';
    afcPedidoNegado               : Result := 'PEDIDO NEGADO';
    afcPedidoCorte                : Result := 'PEDIDO - CORTE - FALTA DE ESTOQUE';
    afcPedidoConferido            : Result := 'CONFERÊNCIA DE PEDIDO';
    afcPedidoEnderecado           : Result := 'PEDIDO - ENDEREÇADO';
    afcPedidoFaturadoParcial      : Result := 'PEDIDO - FATURADO - PARCIAL';
    afcPedidoFaturado             : Result := 'PEDIDO - FATURADO';
    afcExpedicao                  : Result := 'EXPEDIÇÃO';
    afcPedidoAgRomaneio           : Result := 'AGUARDANDO ROMANEIO ENTREGA';
    afcRomaneioInclusao           : Result := 'ROMANEIO - INCLUSÃO';
    afcRomaneioAlteracao          : Result := 'ROMANEIO - REGRAVADO';
    afcRomaneioExclusao           : Result := 'ROMANEIO - EXCLUSÃO';
    afcRegistroOcorrenciaRomaneio : Result := 'ROMANEIO - REGISTRO OCORRÊNCIA';
    afcRomaneioAtivacao           : Result := 'ROMANEIO - ATIVAÇÃO';
    afcRomaneioBaixa              : Result := 'ROMANEIO - BAIXA';
    afcRomaneioCancelamento       : Result := 'ROMANEIO - CANCELAMENTO';
    afcDevolucao                  : Result := 'FATURADO - DEVOLUÇÃO';
    afcExtornoSeparacao           : Result := 'SEPARAÇÃO ESTORNADA';
    afcPedidoAgSeparacao          : Result := 'AGUARDANDO SEPARAÇÃO';
    afcSeparacaoImpressa          : Result := 'SEPARAÇÃO IMPRESSA';
    afcPedidoAgFaturamento        : Result := 'SEPARAÇÃO FINALIZADA';
    afcDocumentoCancelado         : Result := 'Documento cancelado';
    afcVendaOrcamento             : Result := 'VENDA - ORÇAMENTO';
    afcVendaPedido                : Result := 'VENDA - PEDIDO';
    afcGeraDuplicata              : Result := 'GERA NOVA DUPLICATA';
    afcImpressaoBoleto            : Result := 'IMPRESSÃO DE BOLETO';
    afcGeraRemessaBancaria        : Result := 'GERAÇÃO DE REMESSA BANCÁRIA';
    afcCancelaRemessaBancaria     : Result := 'CANCELAMENTO DE REMESSA BANCÁRIA';
    afcEnviaDuplicataBanco        : Result := 'ENVIO DA DUPLICATA AO BANCO';
    afcCancelaEnvioDuplicataBanco : Result := 'CANCELAMENTO DE ENVIO DE DUPLICATA AO BANCO';
    afcImportaRetornoBancario     : Result := 'IMPORTAÇÃO DO ARQUIVO DE RETORNO';
    afcBaixaAutomaticaDuplicata   : Result := 'BAIXA AUTOMÁTICA DE DUPLICATAS';
    afcBaixaParcial               : Result := 'BAIXA PARCIAL';
    afcBaixaTotal                 : Result := 'BAIXA TOTAL';
    afcEstorno                    : Result := 'ESTORNO';
    afcAlteraPorDesEvento         : Result := 'ALTERAÇÃO DE PORTADOR/DESCONTADA/EVENTO';
    afcGeraDespesaProtesto        : Result := 'GERAÇÃO DE DESPESA DE COBRANÇA DE PROTESTO';
    afcRestauraRemessaBancaria    : Result := 'RESTAURAÇÃO DE REMESSA BANCÁRIA';
    afcAgrupaDuplicatas           : Result := 'AGRUPAMENTO DE DUPLICATAS';
    afcDesagrupaDuplicatas        : Result := 'DESAGRUPAMENTO DE DUPLICATAS';
    afcAcertoContas               : Result := 'ACERTO DE CONTAS';
    afcGeraDuplicatasReceber      : Result := 'GERAÇÃO DE DUPLICATAS À RECEBER';
    afcGeraNotaDebito             : Result := 'GERAÇÃO DE NOTA DE DÉBITO';
    afcExcluiDuplicata            : Result := 'EXCLUSÃO DE DUPLICATA';
    afcAlteracaoCliente           : Result := 'ALTERAÇÃO DE CLIENTE';
    afcFinalizaOcoExclusaoFatGor  : Result := 'EXCLUSÃO DE DOCUMENTO PROCESSO INTERNO';
    afcConfirmacaoDocumento       : Result := 'CONFIRMAÇÃO DE DOCUMENTO';
    afcAlteracaoTemperaturaAtend  : Result := 'ALTERACAO DE TEMPERATURA DE ATENDIMENTO';
    afcFaturaPedidoAgrupado       : Result := 'AGRUPAMENTO DE PEDIDO';

    afcGarantiaAndamentoPendLibCrd,
    afcGarantiaAndamentoPendLibCrd_Confirmacao    : Result := tciGarantiaAndamentoPendLibCrd.fGetDescricao.ToUpper;

    afcGarantiaAndamentoPendEnvCli,
    afcGarantiaAndamentoPendEnvCli_Confirmacao   : Result := tciGarantiaAndamentoPendEnvCli.fGetDescricao.ToUpper;

    afcGarantiaCredito                : Result := tciGarantiaCredito.fGetDescricao.ToUpper;
    afcGarantiaCancelada              : Result := tciGarantiaCancelada.fGetDescricao.ToUpper;
    afcGarantiaReposicaoItemConcluida : Result := tciGarantiaReposicaoItemConcluida.fGetDescricao.ToUpper;
  Else
    Result := '';
  End;
end;

function TAcaoFatCRMHelper.fGetOperador(const strNumDoc, strEspDoc,
  strCodEmp: String): String;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  If (strLoginUsuarioLogado <> 'AUT') And
    (Not (Self In [afcSeparacaoImpressa, afcPedidoAgFaturamento, afcPDTransferenciaGerado]))  Then
  Begin
    Result := strLoginUsuarioLogado;
    Exit;
  End;

  If fEmptyStr(Self.fGetSQLOperador()) Then
  Begin
    Result := strLoginUsuarioLogado;
    Exit;
  End;

  LQry := fCriaQuery();
  Try
    LQry.SQL.Add(Self.fGetSQLOperador());
    LQry.ParamByName('NUMDOC').AsString := strNumDoc;
    LQry.ParamByName('ESPDOC').AsString := strEspDoc;
    LQry.ParamByName('CODEMP').AsString := strCodEmp;

    LQry.Open();

    Result := LQry.FieldByName('CODOPE').AsString;

    If fEmptyStr(Result) Then
      Result := strLoginUsuarioLogado;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  End;
end;

function TAcaoFatCRMHelper.fGetSituacao(const strEspDoc,
  strEspOrc: String): String;
begin
  Case Self Of
    afcOrcamento,
    afcPedido,
    afcPedidoCorte,
    afcAlteracaoCliente:
      Begin
        If strEspDoc = 'OR' Then
        Begin
          If fEmptyStr(strEspOrc) Then
            Result := tciInclusaoOrcamento.fGetSituacao()
          Else
            Result := tciAlteracaoOrcamento.fGetSituacao();
        End
        Else
        Begin
          If fEmptyStr(strEspOrc) Then
            Result :=  tciInclusaoPedido.fGetSituacao()
          Else
            Result := tciAlteracaoPedido.fGetSituacao();
        End;
      End;
    afcOrcamentoEmPedido,
    afcOrcamentoFaturado:
      Begin
        If strEspDoc = 'PD' Then
          Result := tciOrcamentoEmPedido.fGetSituacao()
        Else
          Result := tciOrcamentoFaturado.fGetSituacao();
      End;
    afcPedidoFaturado             : Result := tciPedidoFaturado.fGetSituacao();
    afcPedidoFaturadoParcial      : Result := tciPedidoFaturadoParcial.fGetSituacao();
    afcExpedicao                  : Result := tciBaixaExpedicao.fGetSituacao();
    afcPedidoConferido            : Result := tciConferenciaExpedicao.fGetSituacao();
    afcPedidoEnderecado           : Result := tciOrcamentoEmPedido.fGetSituacao();
    afcPedidoLiberado,
    afcPedidoNegado               : Result := tciLiberacaoPedido.fGetSituacao();
    afcRomaneioBaixa              : Result := tciBaixaRomaneio.fGetSituacao();
    afcRomaneioInclusao           : Result := tciInclusaoRomaneio.fGetSituacao();
    afcRomaneioExclusao           : Result := tciExclusaoRomaneio.fGetSituacao();
    afcRegistroOcorrenciaRomaneio : Result := tciRegistroOcorrenciaRomaneio.fGetSituacao();
    afcRomaneioAtivacao           : Result := tciAtivacaoPreRomaneio.fGetSituacao();
    afcSeparacaoImpressa          : Result := tciImpressaoSeparacao.fGetSituacao();
    afcGeraDuplicata              : Result := tciGeraDuplicata.fGetSituacao();
    afcImpressaoBoleto            : Result := tciImpressaoBoleto.fGetSituacao();
    afcGeraRemessaBancaria        : Result := tciGeraRemessaBancaria.fGetSituacao();
    afcCancelaRemessaBancaria     : Result := tciCancelaRemessaBancaria.fGetSituacao();
    afcEnviaDuplicataBanco        : Result := tciEnviaDuplicataBanco.fGetSituacao();
    afcCancelaEnvioDuplicataBanco : Result := tciCancelaEnvioDuplicataBanco.fGetSituacao();
    afcImportaRetornoBancario     : Result := tciImportaRetornoBancario.fGetSituacao();
    afcBaixaAutomaticaDuplicata   : Result := tciBaixaAutomaticaDuplicata.fGetSituacao();
    afcBaixaParcial               : Result := tciBaixaParcial.fGetSituacao();
    afcBaixaTotal                 : Result := tciBaixaTotal.fGetSituacao();
    afcEstorno                    : Result := tciEstorno.fGetSituacao();
    afcAlteraPorDesEvento         : Result := tciAlteraPorDesEvento.fGetSituacao();
    afcGeraDespesaProtesto        : Result := tciGeraDespesaProtesto.fGetSituacao();
    afcRestauraRemessaBancaria    : Result := tciRestauraRemessaBancaria.fGetSituacao();
    afcAgrupaDuplicatas           : Result := tciAgrupaDuplicatas.fGetSituacao();
    afcDesagrupaDuplicatas        : Result := tciDesagrupaDuplicatas.fGetSituacao();
    afcAcertoContas               : Result := tciAcertoContas.fGetSituacao();
    afcGeraDuplicatasReceber      : Result := tciGeraDuplicatasReceber.fGetSituacao();
    afcGeraNotaDebito             : Result := tciGeraNotaDebito.fGetSituacao();
    afcExcluiDuplicata            : Result := tciExcluiDuplicata.fGetSituacao();
    afcConfirmacaoDocumento       : Result := tciRealizadaConfirmacaoDocumento.fGetSituacao();

    afcGarantiaAndamentoPendLibCrd,
    afcGarantiaAndamentoPendLibCrd_Confirmacao : Result := tciGarantiaAndamentoPendLibCrd.fGetSituacao;

    afcGarantiaAndamentoPendEnvCli,
    afcGarantiaAndamentoPendEnvCli_Confirmacao : Result := tciGarantiaAndamentoPendEnvCli.fGetSituacao;

    afcGarantiaCredito                : Result := tciGarantiaCredito.fGetSituacao;
    afcGarantiaCancelada              : Result := tciGarantiaCancelada.fGetSituacao;
    afcGarantiaReposicaoItemConcluida : Result := tciGarantiaReposicaoItemConcluida.fGetSituacao;
  Else
    Result := '';
  End;
end;

function TAcaoFatCRMHelper.fGetSQLOperador: String;
begin
  Case Self Of
    afcPedidoAgCompra         : Result := sqlOpeCompra;
    afcExtornoSeparacao       : Result := sqlOpeEstorSep;
    afcSeparacaoImpressa      : Result := IIF(fUsaRotinaWMS(), sqlOpeSeparador, '');
    afcPDTransferenciaGerado  : Result := sqlVenPedido;
    afcPedidoAgSeparacao      : Result := sqlVenPedido;
    afcPedidoAgFaturamento    : Result := sqlOpeBaixaSepExp;
    afcPedidoAgTransferencia  : Result := sqlOpeTransfer;
    afcPedidoAgPDTransferencia: Result := sqlOpePrepte;
  Else
    Result := '';
  End;
end;

function fStrToTEspDoc(const strEspDoc: String): TEspDoc;
var
  EspDoc: TEspDoc;
Begin
  Result := tpOrcamento;
  For EspDoc:= Low( arrEspDoc ) To High( arrEspDoc ) Do
  Begin
    If arrEspDoc[ EspDoc ] = strEspDoc Then
    Begin
      Result := EspDoc;
      Exit;
    End;
  End;
End;

function fTEspDocToStr(const aEspDoc: TEspDoc): String;
Begin
  Result := arrEspDoc[aEspDoc];
End;

function fStrToTStatusProspe(const strStatus: String): TStatusProspe;
var
  aStatus: TStatusProspe;
Begin
  Result := tstNenhum;
  For aStatus:= Low( arrStatPro ) To High( arrStatPro ) Do
  Begin
    If arrStatPro[aStatus] = strStatus Then
    Begin
      Result := aStatus;
      Exit;
    End;
  End;
End;

function fTStatusProspeToStr(const aStatus: TStatusProspe): String;
Begin
  Result := arrStatPro[aStatus];
End;

function fStrToTTip_Fc(const strTip_Fc: String): TTip_Fc;
var
  aTip_Fc: TTip_Fc;
Begin
  Result := tpCliente;
  For aTip_Fc:= Low( arrTip_Fc ) To High( arrTip_Fc ) Do
  Begin
    If arrTip_Fc[aTip_Fc] = strTip_Fc Then
    Begin
      Result := aTip_Fc;
      Exit;
    End;
  End;
End;

function fTTip_FcToStr(const aTip_Fc: TTip_Fc): String;
Begin
  Result := arrTip_Fc[aTip_Fc];
End;

end.
