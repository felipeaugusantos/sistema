 unit untTSituacaoPedidoVenda;

interface

uses
  Data.DB,
  System.Classes,
  System.SysUtils,
  System.StrUtils,
  System.Math,
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE }
  Uni,
  CRAccess,
  untUtilMonitor,
  untLegenda,
  Vcl.ExtCtrls,
  UniClientDataSet,
  untFuncoesSimples,
{$ENDIF LINUX}
  untFuncoesGenerica,
  untTypesCRM,
  untAtualizaOcorrenciasCRM,
  System.Generics.Collections;

Const
  spIdMonitorStatus        = 'MONITOR_STATUS_%s';
  spIdInactivityMonitorSta = 'TESTE_INATIVIDADE_%s';
  spStatusMonitorExeName   = 'StatusPedidoMonitor.exe';
  spTimeLimitMonitorStatus = 30;
  spAttemptsLockMonitorSt  = 30;

  { Possíveis situações do pedido de venda }
  spvAgLiberacaoFinCom      = 'Aguardando liberação Financeira/Comercial';
  spvAgLiberacaoCom         = 'Aguardando liberação comercial';
  spvAgLiberacaoFin         = 'Aguardando liberação financeira';
  spvAgRequisicaoCompra     = 'Aguardando requisição de compra';
  spvRequisicaoCompraNegada = 'Requisição de compra negada';
  spvAgCompra               = 'Aguardando compra';
  spvAgPedidoTransferencia  = 'Aguardando pedido de transferência';
  spvAgTransferencia        = 'Aguardando transferência';
  spvAgEntregaCompra        = 'Aguardando entrega de compra';
  spvAgEntregaTransferencia = 'Aguardando entrega de transferência';
  spvAgConferenciaEntrada   = 'Aguardando conferência entrada mercadoria';
  spvAgEntrada              = 'Aguardando entrada mercadoria';
  spvAgMovimentoFiscal      = 'Aguardando efetivação do movimento fiscal';
  spvAgEnderecamento        = 'Aguardando endereçamento';
  spvExtornoSeparacao       = 'Separação estornada';
  spvAgSeparacao            = 'Aguardando separação';
  spvSeparando              = 'Separação Iniciada';
  spvAgConferenciaExp       = 'Aguardando conferência expedição';
  spvAgFaturamento          = 'Aguardando faturamento';
  spvFaturado               = 'Faturado';
  spvBaixado                = 'Baixado';
  spvFaturadoAgCliRet       = 'Faturado - aguardando cliente retirar';
  spvFaturadoAgRomaneio     = 'Faturado - aguardando romaneio entrega';
  spvFaturadoEmTransito     = 'Faturado - em trânsito';
  spvFaturadoEntregue       = 'Faturado - entregue';
  spvLiberacaoNegada        = 'Liberação Negada';
  spvPedidoEmAberto         = 'Pedido em aberto';
  spvFaturadoParcialmente   = 'Faturado Parcialmente';
  spvFaturadoParcAgRomaneio = 'Faturado Parcialmente - aguardando romaneio entrega';
  spvFaturadoParcEmTransito = 'Faturado Parcialmente - em trânsito';
  spvFaturadoParcEntregue   = 'Faturado Parcialmente - entregue';
  spvFaturadoDevTotal       = 'Faturado - Devolvido Totalmente';
  spvAgDiaSemanaFaturamento = 'Aguardando dia/semana de Faturamento';
  spvFaturamentoCancelado   = 'Faturamento Cancelado';
  spvSeparacaoAndamento     = 'Separação em andamento';
  spvConferenciaAndamento   = 'Conferência em andamento';
  spvConferenciaIniciada    = 'Conferência Iniciada';

  { Instruções SQL }
  sqlNaoExisteConferenciaAntesDaEntrada =
                             '      NOT EXISTS (                              '+
                             '      (SELECT                                   '+
                             '        GE.AUTOINCREM                           '+
                             '      FROM                                      '+
                             '        GERELE GE                               '+
                             '        INNER JOIN DETELE DE                    '+
                             '          ON DE.DET_SEQGER = GE.AUTOINCREM      '+
                             '        INNER JOIN PEDELE PD                    '+
                             '          ON GE.AUTOINCREM = PD.PEL_SEQELE      '+
//                           Req: 209742
//                           '        INNER JOIN DIGELE DI                    '+
//                           '          ON GE.GER_CODEMP = DI.DIG_CODEMP      '+
//                           '          AND GE.GER_IDEDIG = DI.DIG_IDEDIG     '+
//                           '          AND DE.DET_CODITE = DI.DIG_CODITE     '+
                             '      WHERE TRUE                                '+
                             '        AND PD.PEL_NUMDOC = PC.PCD_NUMPED       '+
                             '        AND PD.PEL_ESPDOC = PC.PCD_ESPDOC       '+
                             '        AND PD.PEL_CODEMP = PC.PCD_CODEMP)      '+
                             '    )                                           ';

  sqlValorJaRecebidoAdiantamento = ' IFNULL( ' +
      ' ( SELECT '+
      '     SUM( IF(ADT_TIPLAN = "D", ADT_VALLAN * -1, ADT_VALLAN) ) '+
      '   FROM                            '+
      '     ADTCLI                        '+
      '   WHERE ADT_CODCLI = FGO_CODCLI   '+
      '     AND ADT_NUMDOC = FGO_NUMDOC   '+
      '     AND ADT_ESPDOC = FGO_ESPDOC   '+
      '     AND ADT_CODEMP = FGO_CODEMP ), 0) ';

  strFormasPagtoAdiantamento: String = '001_002_006_007_009_012_013_';

  sqlAdiantamento =
    ' SELECT '+
    '   CASE '+
    '     WHEN ' + sqlValorJaRecebidoAdiantamento + ' = 0 THEN "Pendente" '+
    '     WHEN ' + sqlValorJaRecebidoAdiantamento + ' < (FGO_VLRCON - IFNULL(FGO_TOTBRI, 0)) THEN "Parcialmente" '+
    '     ELSE "Realizado" '+
    '   END AS SITADT '+
    ' FROM FATGOR F '+
    ' LEFT JOIN EXTGOR ON EXTGOR.FGO_SEQFGO = F.AUTOINCREM '+
    ' WHERE F.FGO_NUMDOC = :NUMDOC '+
    '   AND F.FGO_ESPDOC = :ESPDOC '+
    '   AND F.FGO_CODEMP = :CODEMP '+
    '   AND LOCATE(FGO_CODFPG, :FORMAS) ';

  sqlPedidosFaturadoEmTransitoAntigos =
    ' SELECT                                                       ' +
    '   AUTOINCREM                                                 ' +
    ' FROM                                                         ' +
    '   FATGOR                                                     ' +
    '   JOIN EXTGOR                                                ' +
    '     ON FGO_SEQFGO = FATGOR.AUTOINCREM                        ' +
    ' WHERE TRUE                                                   ' +
    '   AND FGO_JAFATU = 1                                         ' +
    '   AND FGO_STATUS = 16                                        ' +
    '   AND FGO_ESPDOC = "PD"                                      ' +
    '   AND FGO_CODEMP = :CODEMP                                   ' +
    '   AND FGO_DTAENT < DATE_ADD(CURRENT_DATE, INTERVAL -90 DAY)  ' +
    ' LIMIT 500                                                    ' ;

  sqlPedidosFaturadoAguardandoRomaneioEntregaAntigos =
    ' SELECT                                                       ' +
    '   AUTOINCREM                                                 ' +
    ' FROM                                                         ' +
    '   FATGOR                                                     ' +
    '   JOIN EXTGOR                                                ' +
    '     ON FGO_SEQFGO = FATGOR.AUTOINCREM                        ' +
    ' WHERE TRUE                                                   ' +
    '   AND FGO_JAFATU = 1                                         ' +
    '   AND FGO_STATUS = 18                                        ' +
    '   AND FGO_ESPDOC = "PD"                                      ' +
    '   AND FGO_CODEMP = :CODEMP                                   ' +
    '   AND FGO_DTAENT < DATE_ADD(CURRENT_DATE, INTERVAL -90 DAY)  ' +
    ' LIMIT 500                                                    ' ;

  sqlAtualizaStatusPedidoParaFaturadoOuBaixado =
    ' UPDATE                                                       ' +
    '   FATGOR                                                     ' +
    '   JOIN EXTGOR                                                ' +
    '     ON FGO_SEQFGO = FATGOR.AUTOINCREM                        ' +
    ' SET FGO_STATUS = IF(IFNULL(FGO_MOTBAI, "") <> "", 15, 2)     ' +
    ' WHERE FGO_JAFATU = 1                                         ' +
    '   AND FATGOR.AUTOINCREM = "%s";                              ' ;

  sqlPedidoOS              = ' SELECT ' +
                             '   E.AUTOINCREM, ' +
                             '   EQU_FLXFAS, ' +
                             '   EQU_FLXSIT, ' +
                             '   EQU_FLXCOM, ' +
                             '   EQU_NUMOSE, ' +
                             '   EQU_CODEMP, ' +
                             '   (SELECT IF(COUNT(*) > 0, "S", "N") ' +
                             '    FROM EQUDET ED ' +
                             '    WHERE E.AUTOINCREM = ED.EQU_SEQGER) TEMPRD ' +
                             ' FROM EQUGER E ' +
                             ' WHERE EQU_NUMPED = :NUMDOC ' +
                             '   AND EQU_TIPPED = :ESPDOC ' +
                             '   AND EQU_EMPPED = :CODEMP ' +
                             'UNION ' +
                             'SELECT ' +
                             '   E.AUTOINCREM, ' +
                             '   EQU_FLXFAS, ' +
                             '   EQU_FLXSIT, ' +
                             '   EQU_FLXCOM, ' +
                             '   EQU_NUMOSE, ' +
                             '   EQU_CODEMP, ' +
                             '   (SELECT IF(COUNT(*) > 0, "S", "N") ' +
                             '    FROM EQUDET ED ' +
                             '    WHERE E.AUTOINCREM = ED.EQU_SEQGER) TEMPRD ' +
                             ' FROM EQUGER E ' +
                             ' INNER JOIN EQUGOR EG ON E.AUTOINCREM = EG.FGO_SEQEQU ' +
                             ' INNER JOIN FATGOR FG ON EG.FGO_SEQFGO = FG.AUTOINCREM ' +
                             ' WHERE FGO_NUMDOC = :NUMDOC ' +
                             '   AND FGO_ESPDOC = :ESPDOC ' +
                             '   AND FGO_CODEMP = :CODEMP ';

  sqlUpdateStatusOS        = ' UPDATE EQUGER ' +
                             '   SET EQU_FLXFAS = :FLXFAS, ' +
                             '       EQU_FLXSIT = :FLXSIT, ' +
                             '       EQU_FLXCOM = :FLXCOM  ' +
                             ' WHERE AUTOINCREM = :AUTINC  ';

  sqlInsertLogFluxoOS      = ' INSERT INTO LOGFLX ( ' +
                             '     AUTOINCREM, LOG_DTALOG, LOG_HORLOG, LOG_NUMOSE, ' +
                             '     LOG_CODEMP, LOG_CODOPE, LOG_CODDIG, LOG_FASANT, ' +
                             '     LOG_SITANT, LOG_COMANT, LOG_FASATU, LOG_SITATU, ' +
                             '     LOG_COMATU, LOG_EMPLOG, LOG_FLXLOG) ' +
                             ' VALUES ( ' +
                             '     :AUTOINCREM, :LOG_DTALOG, :LOG_HORLOG, :LOG_NUMOSE, ' +
                             '     :LOG_CODEMP, :LOG_CODOPE, :LOG_CODDIG, :LOG_FASANT, ' +
                             '     :LOG_SITANT, :LOG_COMANT, :LOG_FASATU, :LOG_SITATU, ' +
                             '     :LOG_COMATU, :LOG_EMPLOG, :LOG_FLXLOG)';

  sqlPedidoJaFaturado      = '   AND FGO_JAFATU = 1 ';

  sqlItemPedidoJaFaturado  = '   AND FDO.FDO_JAFATU = 1 ';

  sqlPedidoFaturadoParcialmente = ' AND FGO_JAFATU = 0 ' +
                                  ' AND EXISTS ( ' +
                                  '   (SELECT ' +
                                  '     AUTOINCREM ' +
                                  '   FROM ' +
                                  '     FATDOR ' +
                                  '   WHERE FDO_SEQGER = FG.AUTOINCREM ' +
                                  '     AND ((FDO_JAFATU = 1) OR (FDO_QTDBAI > 0))) ' +
                                  ' ) ';

  sqlItemPedidoFaturadoParcialmente = ' AND FGO_JAFATU = 0 ' +
                                      ' AND FDO.FDO_JAFATU = 0 AND FDO.FDO_QTDBAI > 0 ';

  sqlInformacaoFinanceiraPV= 'SELECT SQL_NO_CACHE G.FGO_CONPAG AS CONPAG,     '+
                             'G.FGO_CODCLI AS CODCLI,                         '+
                             'G.FGO_CODFPG AS CODFPG,                         '+
                             'G.AUTOINCREM AS AUTINC,                         '+
                             'G.FGO_TIPOPE AS TIPOPE,                         '+
                             'SUM(IF(COALESCE(FDO_QTDBAI, 0) = 0,             '+
                             '       FDO_TOTITE - FDO_DESESP + FDO_VALIPI +   '+
                             '       FDO_TOTFRE + FDO_VALRET /*<<REFORMA_FDO>>*/, '+
                             '       ROUND((FDO_TOTITE - FDO_DESESP +         '+
                             '              FDO_VALIPI + FDO_TOTFRE +         '+
                             '              FDO_VALRET /*<<REFORMA_FDO>>*/) -     '+
                             '              IFNULL((SELECT SUM(DET_VLRCON)    '+
                             '                        FROM MOVDET             '+
                             '                       WHERE DET_NUM_PD = FDO_NUMDOC'+
                             '                         AND DET_ESP_PD = FDO_ESPDOC'+
                             '                         AND DET_EMP_PD = FDO_CODEMP'+
                             '                         AND DET_CODITE = FDO_CODITE'+
                             '                         AND DET_IND_PD = FDO_SEQIND' +
                             '                         AND (SELECT            '+
                             '                              COUNT(BRI_SEQDET) '+
                             '                               FROM BRIDET      '+
                             '                              WHERE BRI_SEQDET ='+
                             '                         MOVDET.AUTOINCREM) = 0)'+
                             '              , 0), 2))) AS VLRCON,             '+
                             ' E.FGO_TOTBRI AS TOTBRI,                        '+
                             ' E.FGO_BOLADT AS BOLADT,                        '+
                             ' E.FGO_BOLVEN AS BOLVEN,                        '+
                             '(SELECT DISTINCT IF(IFNULL(FDO_INCFUT,"N") = "N"'+
                             ' , "N", "S")                                    '+
                             '   FROM FATDOR FD                               '+
                             ' LEFT JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO '+
                             '  WHERE FD.FDO_SEQGER = G.AUTOINCREM) AS BENFUT,'+
                             '(SELECT SUM(CTR_VALREC - IFNULL(CTR_VALJUR, 0)  '+
                             '- IFNULL(CTR_VALCOB, 0) + IFNULL(CTR_VALDES, 0))'+
                             '   FROM CADREC                                  '+
                             '  WHERE CTR_NUMDUP = FGO_NUMDOC                 '+
                             '    AND CTR_ESPDOC = FGO_ESPDOC                 '+
                             '    AND CTR_CODEMP = FGO_CODEMP                 '+
                             '    AND CTR_CODCLI = FGO_CODCLI                 '+
                             '    AND CTR_DTAREC IS NOT NULL) AS VALREC,      '+
                             '(SELECT SUM(IF(ADT_TIPLAN = "C", ADT_VALLAN,    '+
                             ' - ADT_VALLAN))                                 '+
                             '   FROM ADTCLI                                  '+
                             '  WHERE ADT_NUMDOC = FGO_NUMDOC                 '+
                             '    AND ADT_ESPDOC = FGO_ESPDOC                 '+
                             '    AND ADT_CODEMP = FGO_CODEMP                 '+
                             '    AND ADT_CODCLI = FGO_CODCLI) AS VALADT,     '+
                             '(SELECT GROUP_CONCAT(F.FPN_CODFPG)              '+
                             '   FROM FPGNEG F                                '+
                             '  WHERE F.FPN_SEQFGO = G.AUTOINCREM) AS FPGNEG, '+
                             'IF(:NPDF11 = "N" AND :NPRF11 = "N" AND :NPLF11 = "N" AND :LOCRET = "N", "N", '+
                             '   (SELECT IF(COUNT(*) > 0, "S", "N")           '+
                             '      FROM FATDOR AS PEDORI                     '+
                             '     WHERE PEDORI.FDO_NUMFAT = G.FGO_NUMDOC     '+
                             '       AND PEDORI.FDO_TIPFAT = G.FGO_ESPDOC     '+
                             '       AND PEDORI.FDO_EMPFAT = G.FGO_CODEMP     '+
                             ')) AS ORIF11                                    '+
                             ' FROM FATGOR G                                  '+
                             ' LEFT JOIN EXTGOR E ON G.AUTOINCREM = E.FGO_SEQFGO'+
                             ' JOIN FATDOR D ON D.FDO_NUMDOC = G.FGO_NUMDOC   '+
                             '              AND D.FDO_ESPDOC = G.FGO_ESPDOC   '+
                             '              AND D.FDO_CODEMP = G.FGO_CODEMP   '+
                             '              AND D.FDO_CODCLI = G.FGO_CODCLI   '+
                             '              AND D.FDO_JAFATU = 0              '+
                             ' WHERE G.FGO_NUMDOC = :NUMDOC                   '+
                             '   AND G.FGO_ESPDOC = :ESPDOC                   '+
                             '   AND G.FGO_CODEMP = :CODEMP                   ';

type
  TEStatusPedidoVenda = (pvPedidoEmAberto,
                         pvBaixado,
                         pvFaturadoParcAgRomaneio,
                         pvFaturadoParcEmTransito,
                         pvFaturadoParcEntregue,
                         pvFaturadoParcialmente,
                         pvFaturadoDevTotal,
                         pvFaturadoAgCliRet,
                         pvFaturadoAgRomaneio,
                         pvFaturadoEmTransito,
                         pvFaturadoEntregue,
                         pvFaturado,
                         pvFaturamentoCancelado,
                         pvLiberacaoNegada,
                         pvAgLiberacaoFinCom,
                         pvAgLiberacaoCom,
                         pvAgLiberacaoFin,
                         pvAgRequisicaoCompra,
                         pvRequisicaoCompraNegada,
                         pvAgCompra,
                         pvAgEntregaCompra,
                         pvAgPedidoTransferencia,
                         pvAgTransferencia,
                         pvAgEntregaTransferencia,
                         pvAgConferenciaEntrada,
                         pvAgEntrada,
                         pvAgMovimentoFiscal,
                         pvAgEnderecamento,
                         pvExtornoSeparacao,
                         pvAgSeparacao,
                         pvSeparando,
                         pvSeparacaoAndamento,
                         pvAgConferenciaExp,
                         pvConferenciaIniciada,
                         pvConferenciaAndamento,
                         pvAgFaturamento,
                         pvAgDiaSemanaFaturamento);

  TESituacaoFinanceira = (sfPendente,
                          sfRecebido);

  TEAdiantamentoPedido = (apPendente,
                          apParcialmente,
                          apRealizado,
                          apLiberado);

  TTipoFaturamento = (tfParcial, tfTotal);

  IGetSQLStatus = Interface
  ['{ED06C657-72E6-46C3-8CBB-4ADFF7711E62}']
    function sqlPedidoEmAberto: String;
    function sqlPedidoVendaBaixado: String;
    function sqlPedidoVendaJaFaturado(ATipFat: TTipoFaturamento): String;
    function sqlPendenteLibComFin: String;
    function sqlPendenteLibComercial: String;
    function sqlPendenteLibFinanceira: String;
    function sqlCompraPendente: String;
    function sqlConferenciaEntradaPendente(AConferenciaDepoisDaEntrada: Boolean): String;
    function sqlConferenciaExpPendente: String;
    function sqlEmSeparacao: String;
    function sqlEmSeparacaoBaiSep: String;
    function sqlEnderecamentoPendente: String;
    function sqlEntradaMercadoriaPend(AConferenciaDepoisDaEntrada: Boolean): String;
    function sqlEntregaPendenteCDTran: String;
    function sqlEntregaPendenteCompraQuandoConferenciaAntesDaEntrada: String;
    function sqlEntregaPendenteCompraQuandoNaoUsaConferencia: String;
    function sqlEntregaPendenteQuandoConferenciaDepoisDaEntrada: String;
    function sqlEntregaPendenteTransf: String;
    function sqlExtornoSeparacao: String;
    function sqlFaturadoNFEmTransito(ATipFat: TTipoFaturamento): String;
    function sqlFaturadoNFEntregue(ATipFat: TTipoFaturamento): String;
    function sqlFaturadoPDEmTransito(ATipFat: TTipoFaturamento): String;
    function sqlFaturadoPDEntregue(ATipFat: TTipoFaturamento): String;
    function sqlFaturamentoPendente: String;
    function sqlMovimentoFiscalPendente(AConferenciaDepoisDaEntrada: Boolean): String;
    function sqlPedidoNegado: String;
    function sqlPedidoTransfPendente: String;
    function sqlRequisicaoCompraNegada: String;
    function sqlRequisicaoPendente: String;
    function sqlRomaneioNFPendente(ATipFat: TTipoFaturamento): String;
    function sqlRomaneioPDPendente(ATipFat: TTipoFaturamento): String;
    function sqlSeparacaoPendente: String;
    function sqlTransferenciaPendente: String;
    function sqlPedidoVendaClienteRetira(ATipFat: TTipoFaturamento): String;
    function sqlFaturadoDevTotal: String;
    function sqlFaturamentoCancelado: String;
    function sqlSeparacaoAndamento: String;
    function sqlConferenciaAndamento: String;
    function sqlConferenciaAndamentoQuandoBaiSepDesligada: String;
    function sqlEmSeparacaoUsandoConferenciaComBaiSepDesligado: String;
    function sqlAguardandoConferenciaComBaiSepDesligado: String;
  end;

  TVerificarStatusSeparacaoConcluidaItem = class sealed
  public const
    strSeparacaoConcluidaItem: String = 'Separação concluída';
  private
    class function sqlSeparacaoConcluida(): String;
    class function sqlSeparacaoConcluidaBaiSep(): String;
  public
    class function CheckStatus(ANumPed, AEspPed, AEmpPed, ACodIte: String): Boolean;
  end;

  TGetSQLStatus = class(TInterfacedObject, IGetSQLStatus)
  public type
    TipoStatus = (statusPedido, statusItemPedido);
  private
    FTipoStatus: TipoStatus;
  protected
    constructor Create(ATipo: TipoStatus);
  public
    class function New(ATipo: TipoStatus): IGetSQLStatus;
  public
    function sqlPedidoEmAberto: String;
    function sqlPedidoVendaBaixado: String;
    function sqlPedidoVendaJaFaturado(ATipFat: TTipoFaturamento): String;
    function sqlPendenteLibComFin: String;
    function sqlPendenteLibComercial: String;
    function sqlPendenteLibFinanceira: String;
    function sqlCompraPendente: String;
    function sqlConferenciaEntradaPendente(AConferenciaDepoisDaEntrada: Boolean): String;
    function sqlConferenciaExpPendente: String;
    function sqlEmSeparacao: String;
    function sqlEmSeparacaoBaiSep: String;
    function sqlEnderecamentoPendente: String;
    function sqlEntradaMercadoriaPend(AConferenciaDepoisDaEntrada: Boolean): String;
    function sqlEntregaPendenteCDTran: String;
    function sqlEntregaPendenteCompraQuandoConferenciaAntesDaEntrada: String;
    function sqlEntregaPendenteCompraQuandoNaoUsaConferencia: String;
    function sqlEntregaPendenteQuandoConferenciaDepoisDaEntrada: String;
    function sqlEntregaPendenteTransf: String;
    function sqlExtornoSeparacao: String;
    function sqlFaturadoNFEmTransito(ATipFat: TTipoFaturamento): String;
    function sqlFaturadoNFEntregue(ATipFat: TTipoFaturamento): String;
    function sqlFaturadoPDEmTransito(ATipFat: TTipoFaturamento): String;
    function sqlFaturadoPDEntregue(ATipFat: TTipoFaturamento): String;
    function sqlFaturamentoPendente: String;
    function sqlMovimentoFiscalPendente(AConferenciaDepoisDaEntrada: Boolean): String;
    function sqlPedidoNegado: String;
    function sqlPedidoTransfPendente: String;
    function sqlRequisicaoCompraNegada: String;
    function sqlRequisicaoPendente: String;
    function sqlRomaneioNFPendente(ATipFat: TTipoFaturamento): String;
    function sqlRomaneioPDPendente(ATipFat: TTipoFaturamento): String;
    function sqlSeparacaoPendente: String;
    function sqlTransferenciaPendente: String;
    function sqlPedidoVendaClienteRetira(ATipFat: TTipoFaturamento): String;
    function sqlFaturadoDevTotal: String;
    function sqlFaturamentoCancelado: String;
    function sqlSeparacaoAndamento: String;
    function sqlConferenciaAndamento: String;
    function sqlConferenciaAndamentoQuandoBaiSepDesligada: String;
    function sqlEmSeparacaoUsandoConferenciaComBaiSepDesligado: String;
    function sqlAguardandoConferenciaComBaiSepDesligado: String;
  end;

  TEStatusPedidoVendaHelper = record helper for TEStatusPedidoVenda
    function fGetImageIdx: Integer;
    function fGetSQL(ATipo: TGetSQLStatus.TipoStatus): String;
    function fGetDescricao: String;
    function fGetId: Integer;
    function fIsUpdateOccurrencyCRM: Boolean;
    function fConsiderarJaFatu: Boolean;
    function fGetAcaFatCRM: TAcaoFatCRM;
    function fUtilizarStatus: Boolean;
    function fIsFaturadoParciamente: Boolean;
    function fUsaEnderecamento: Boolean;
  end;

  TESituacaoFinanceiraHelper = record helper for TESituacaoFinanceira
    function fGetLegendaIdx: Integer;
    function fGetLegendaTexto: String;
  end;

  TEAdiantamentoPedidoHelper = record helper for TEAdiantamentoPedido
    function fGetLegendaIdx: Integer;
    function fGetLegendaTexto: String;
  end;

  IRepositoryStatus = Interface
  ['{47C7C9B7-7A0F-4B55-A18E-93474F081A34}']
    procedure pCheck;
  end;

  IParamStatus = Interface
  ['{BE95E191-694C-4D12-8CA8-3697725AC473}']
    function NumDoc(const AValue: String): IParamStatus; overload;
    function EspDoc(const AValue: String): IParamStatus; overload;
    function CodEmp(const AValue: String): IParamStatus; overload;
    function CodCli(const AValue: String): IParamStatus; overload;
    function SeqFdo(const AValue: String): IParamStatus; overload;

    function NumDoc: String; overload;
    function EspDoc: String; overload;
    function CodEmp: String; overload;
    function CodCli: String; overload;
    function SeqFdo: String; overload;

    function fGetDocument: String;
    function blnImpSfa(const AValue: Boolean): IParamStatus; overload;
    function blnImpSfa: Boolean; overload;

    function blnAuditandoFaturados(const AValue: Boolean): IParamStatus; overload;
    function blnAuditandoFaturados: Boolean; overload;
    function AutoincremFatgor(const AValue : String) : IParamStatus; overload;
    function AutoincremFatgor : String; overload;
  end;

  IStatus = Interface
  ['{32D88338-054B-49AC-B4A3-F1CA664B21D4}']
    function fGetStatus: TEStatusPedidoVenda;
  end;

  TRepositoryStatus = class sealed(TInterfacedObject, IRepositoryStatus)
  const
    sqlSelectStatus = 'SELECT GROUP_CONCAT(STA_CODIGO) AS CODIGOS FROM FGOSTA';

    sqlUpInsertStatus = 'INSERT INTO FGOSTA (STA_CODIGO, STA_DESCRI) VALUES   '+
                        '(:CODIGO, :DESCRI) ON DUPLICATE KEY UPDATE           '+
                        'STA_DESCRI = :DESCRI ';
  private
    function fRetStatusCadastrados: String;
    function fStatusJaCadastrado(LEnum: TEStatusPedidoVenda; strStatusCadastrados: String): Boolean;
  public
    procedure pCheck;

    class function New: IRepositoryStatus;
  end;

  TUpdateStatus = class sealed(TInterfacedObject,
    {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX})
  const
    sqlPedidosNaoFaturados = 'SELECT SQL_NO_CACHE                              '+
                             '       FGO_NUMDOC, FGO_ESPDOC,                   '+
                             '       FGO_CODEMP, FGO_CODCLI,                   '+
                             '       FGO_DTASTA, FGO_HRASTA,                   '+
                             '       FATGOR.AUTOINCREM AS INCGOR               '+
                             '  FROM FATGOR                                    '+
                             '  JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM  '+
                             ' WHERE FGO_ESPDOC = "PD"                         '+
                             '   AND FGO_JAFATU = 0                            '+
                             '   AND IFNULL(FGO_EMP_TE, "") <> FGO_CODEMP      '+
                             '   AND IFNULL(FGO_EMP_CD, "") <> FGO_CODEMP      '+
                             '   AND FGO_CODEMP = :CODEMP                      '+
                             ' HAVING_TIMEDIFF                                 '+
                             'UNION ALL                                        '+
                             ' SELECT                                          '+
                             '       FGO_NUMDOC, FGO_ESPDOC,                   '+
                             '       FGO_CODEMP, FGO_CODCLI,                   '+
                             '       FGO_DTASTA, FGO_HRASTA,                   '+
                             '       FATGOR.AUTOINCREM AS INCGOR               '+
                             '  FROM FATGOR                                    '+
                             '  JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM  '+
                             ' WHERE FGO_ESPDOC = "PD"                         '+
                             '   AND FGO_JAFATU = 0                            '+
                             '   AND FGO_EMP_TE = :CODEMP                      '+
                             ' HAVING_TIMEDIFF                                 '+
                             'UNION ALL                                        '+
                             ' SELECT                                          '+
                             '       FGO_NUMDOC, FGO_ESPDOC,                   '+
                             '       FGO_CODEMP, FGO_CODCLI,                   '+
                             '       FGO_DTASTA, FGO_HRASTA,                   '+
                             '       FATGOR.AUTOINCREM AS INCGOR               '+
                             '  FROM FATGOR                                    '+
                             '  JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM  '+
                             ' WHERE FGO_ESPDOC = "PD"                         '+
                             '   AND FGO_JAFATU = 0                            '+
                             '   AND FGO_EMP_CD = :CODEMP                      '+
                             ' HAVING_TIMEDIFF                                 ';


    sqlStatusAtualPedido   = 'SELECT SQL_NO_CACHE IFNULL(E.FGO_STATUS,0) AS FGO_STATUS '+
                             '  FROM EXTGOR E                                 '+
                             '  JOIN FATGOR F ON E.FGO_SEQFGO = F.AUTOINCREM  '+
                             ' WHERE F.FGO_NUMDOC = :NUMDOC                   '+
                             '   AND F.FGO_ESPDOC = :ESPDOC                   '+
                             '   AND F.FGO_CODEMP = :CODEMP                   ';

    sqlUpdateStatusPedido  = 'UPDATE EXTGOR E                                 '+
                             '  JOIN FATGOR F ON E.FGO_SEQFGO = F.AUTOINCREM  '+
                             'SET E.FGO_STATUS = :STATUS,                     '+
                             ' E.FGO_DTASTA = :DTASTA, FGO_HRASTA = :HRASTA   '+
                             ' WHERE F.FGO_NUMDOC = :NUMDOC                   '+
                             '   AND F.FGO_ESPDOC = :ESPDOC                   '+
                             '   AND F.FGO_CODEMP = :CODEMP                   ';

    sqlInsertAltStaPedidoAutoincrem  = 'INSERT INTO ALTSTA (AUTOINCREM, STA_SEQFGO,     '+
                                       'STA_CODIGO, STA_DTAMUD, STA_HRAMUD )            '+
                                       'SELECT :AUTINC, AUTOINCREM, :STATUS, :DTAMUD,   '+
                                       '  :HRAMUD FROM FATGOR                           '+
                                       ' WHERE FGO_NUMDOC = :NUMDOC                     '+
                                       '   AND FGO_ESPDOC = :ESPDOC                     '+
                                       '   AND FGO_CODEMP = :CODEMP                     ';

    sqlInsertAltStaPedido        = 'INSERT INTO ALTSTA (STA_SEQFGO, STA_CODIGO, STA_DTAMUD, STA_HRAMUD ) '+
                                      '             SELECT AUTOINCREM, :STATUS,    :DTAMUD,    :HRAMUD '+
                                      '               FROM FATGOR '+
                                      '              WHERE FGO_NUMDOC = :NUMDOC '+
                                      '                AND FGO_ESPDOC = :ESPDOC '+
                                      '                AND FGO_CODEMP = :CODEMP ';

    sqlReprocessarStatusItensPedido = ' UPDATE                                '+
                                      '   EXTDOR                              '+
                                      '   JOIN FATDOR                         '+
                                      '     ON FDO_SEQFDO = FATDOR.AUTOINCREM '+
                                      ' SET FDO_REPSTA = "S"                  '+
                                      ' WHERE FDO_NUMDOC = :NUMDOC            '+
                                      '   AND FDO_ESPDOC = :ESPDOC            '+
                                      '   AND FDO_CODEMP = :CODEMP;           ';

    sqlVerificarBaixaSepOS = 'SELECT FG.AUTOINCREM                            '+
                             'FROM FATGOR FG                                  '+
                             'JOIN EXTGOR EG ON FG.AUTOINCREM = EG.FGO_SEQFGO '+
                             'WHERE EG.FGO_OPBXSE IS NULL                     '+
                             '  AND EG.FGO_DTBXSE IS NULL                     '+
                             '  AND EG.FGO_HRBXSE IS NULL                     '+
                             '  AND FG.FGO_NUMDOC = :NUMDOC                   '+
                             '  AND FG.FGO_ESPDOC = :ESPDOC                   '+
                             '  AND FG.FGO_CODEMP = :CODEMP                   ';

    sqlPedidoOSNaoReservado= 'SELECT COUNT(1) QTDE                            '+
                             'FROM FATDOR F                                   '+
                             'JOIN EXTDOR ED ON F.AUTOINCREM = ED.FDO_SEQFDO  '+
                             'WHERE FDO_RESERV = "N"                          '+
                             '  AND ((EXISTS                                  '+
                             '          (SELECT FGO_SEQFGO                    '+
                             '           FROM EQUGOR E                        '+
                             '           WHERE E.FGO_SEQFGO = F.FDO_SEQGER    '+
                             '             AND E.FGO_SEQEQU = :SEQEQU))       '+
                             '  OR (F.FDO_NUMDOC = :NUMDOC                    '+
                             '      AND F.FDO_ESPDOC = :ESPDOC                '+
                             '      AND F.FDO_CODEMP = :CODEMP))              ';

  protected
    FModified : Boolean;
    FParams: IParamStatus;
    FQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    FStatus: TEStatusPedidoVenda;

    constructor Create(AParams: IParamStatus);

    function fCurrentStatus: Integer;
    function fStatusModified: Boolean;

    procedure pVerificaPedidoOS;
    procedure pInsereLogFlxOS(ANumOSe, ACodEmp, AFlxFasAnt, AFlxSitAnt, AFlxComAnt,
      AFlxFas, AFlxSit, AFlxCom: String);
    function fVerificaBaixaSeparacao: Boolean;
    function fVerificaTemItensPedidoNaoReservado(ASeqEqu: String): Boolean;
    function fGetSqlInsertAltStaPedido : String;
    procedure pValidarVS_AltStaBigInt;
    procedure pAtualizarDataHoraDosStatusNaoModificados(const AStatusNaoModificados : TList<String>);
    procedure pUpdateDataHoraStatusNaoModificados(const AAutIncPedidos : String);
    procedure pUpdateReprocessaStatusNaoModificados(const AAutIncPedidos : String);
    procedure pProcessaPedidosNaoModificados(const AStatusNaoModificados : TList<String>);
    procedure SetLockWaitTimeout(const ASeconds : Integer);
    procedure RestoreLockWaitTimeout;
  public
    procedure pExecuteAll;
    procedure pExecute;
    function fExecute : TResultExecute;

    class function New(AParams: IParamStatus = nil):
      {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};

    destructor Destroy; override;
  end;

  TParamStatus = class sealed(TInterfacedObject, IParamStatus)
  protected
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FCodCli: String;
    FSeqFdo: String;
    FblnImpSfa: Boolean;
    FAuditandoFaturados: Boolean;
    FAutoincremFatgor : String;
    constructor Create;
  public
    function NumDoc(const AValue: String): IParamStatus; overload;
    function EspDoc(const AValue: String): IParamStatus; overload;
    function CodEmp(const AValue: String): IParamStatus; overload;
    function CodCli(const AValue: String): IParamStatus; overload;
    function SeqFdo(const AValue: String): IParamStatus; overload;

    function NumDoc: String; overload;
    function EspDoc: String; overload;
    function CodEmp: String; overload;
    function CodCli: String; overload;
    function SeqFdo: String; overload;

    function fGetDocument: String;
    function blnImpSfa(const AValue: Boolean): IParamStatus; overload;
    function blnImpSfa: Boolean; overload;

    function blnAuditandoFaturados(const AValue: Boolean): IParamStatus; overload;
    function blnAuditandoFaturados: Boolean; overload;

    function AutoincremFatgor(const AValue : String) : IParamStatus; overload;
    function AutoincremFatgor : String; overload;

    class function New: IParamStatus;
  end;

  TStatus = class sealed(TInterfacedObject, IStatus)
  protected
    FParams: IParamStatus;
    FQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};

    constructor Create(AParams: IParamStatus);

    function fExisteDados(const AQuery: String): Boolean;

    procedure pExecutaQuery(const AQuery: String);
  public
    destructor Destroy; override;

    function fGetStatus(): TEStatusPedidoVenda;

    class function New(AParams: IParamStatus): IStatus;
  end;

  TSituacaoPedidoVenda = Class(TObject)
  Private
    class var FInstance: TSituacaoPedidoVenda;

    FNumDoc     : String;
    FEspDoc     : String;
    FCodEmp     : String;
{$IFNDEF LINUX}
    FLegenda    : TLegenda;
    FLegendaCompleta: TLegenda;
    FLegendaFin : TLegenda;
    FLegendaAdt : TLegenda;
{$ENDIF LINUX}
    FQrySPV     : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};

    constructor Create;

    class function GetInstance: TSituacaoPedidoVenda;

    function fAddSituacaoFin: String;
    function fAddSituacaoAdt: String;

{$IFNDEF LINUX}
    procedure pSetLegenda;
    procedure pSetLegendaCompleta;
    procedure pSetLegendaFin;
    procedure pSetLegendaAdt;
{$ENDIF LINUX}

  Public
    destructor Destroy; Override;

{$IFNDEF LINUX}
    class function fRetornaLegenda: TLegenda;
    class function fRetornaLegendaCompleta: TLegenda;
    class function fRetornaLegendaFin: TLegenda;
    class function fRetornaLegendaAdt: TLegenda;
{$ENDIF LINUX}

    class function fRetornaSituacaoFinanceira(Const strCodEmp, strNumDoc, strEspDoc: String): String;
    class function fRetornaSituacaoAdiantamento(Const strCodEmp, strNumDoc, strEspDoc: String): String;
  End;

implementation

uses{$IFNDEF LINUX}
  Vcl.Forms,
  untConstantes,
  Winapi.Windows,
{$ENDIF LINUX}
  System.UITypes,
  System.Variants,
  System.DateUtils,
  System.Generics.Defaults,
  untValidaSituacaoFinanceiraPedido;

Var
  VS_blnUTIPEN: Variant;
  VS_AltStaBigInt : String;

{ TSituacaoPedidoVenda }

destructor TSituacaoPedidoVenda.Destroy;
begin
{$IFNDEF LINUX}
  If Assigned(FLegendaFin) Then
    FreeAndNil(FLegendaFin);
  If Assigned(FLegendaAdt) Then
    FreeAndNil(FLegendaAdt);
  If Assigned(FLegenda) Then
    FreeAndNil(FLegenda);
  If Assigned(FLegendaCompleta) Then
    FreeAndNil(FLegendaCompleta);
  If Assigned(FQrySPV) Then
    FreeAndNil(FQrySPV);
{$ENDIF LINUX}
  inherited Destroy;
end;

function TSituacaoPedidoVenda.fAddSituacaoAdt: String;
begin
  Try
    FQrySPV.SQL.Add(sqlAdiantamento);
    FQrySPV.ParamByName('NUMDOC').AsString := FNumDoc;
    FQrySPV.ParamByName('ESPDOC').AsString := FEspDoc;
    FQrySPV.ParamByName('CODEMP').AsString := FCodEmp;
    FQrySPV.ParamByName('FORMAS').AsString := strFormasPagtoAdiantamento+
                                              IfThen( ( fCfgSis('TFPF11', VarBoolean) Or fCfgSis('SFPGPD', VarBoolean) ),
                                              '_016_',
                                              '_008_010_014_016_');
    FQrySPV.Open;

    If Not FQrySPV.isEmpty Then
    Begin
      If FQrySPV.FieldByName('SITADT').AsString = 'Realizado' Then
      Begin
        Result := apRealizado.fGetLegendaTexto;
      End
      Else If FQrySPV.FieldByName('SITADT').AsString = 'Pendente' Then
      Begin
        If (fCfgSis('ADTLIB', varBoolean)) Then
        Begin
          If SameText(TSituacaoPedidoVenda.Create.fRetornaSituacaoFinanceira(FCodEmp, FNumDoc, FEspDoc), 'Recebido') Then
            Result := apLiberado.fGetLegendaTexto
          Else
            Result := apPendente.fGetLegendaTexto;
        End
        Else
        Begin
          Result := apPendente.fGetLegendaTexto;
        End;
      End
      Else If FQrySPV.FieldByName('SITADT').AsString = 'Parcialmente' Then
      Begin
        Result := apParcialmente.fGetLegendaTexto;
      End;
    End
    Else
      Result := '';

  Finally
    FQrySPV.Close;
    FQrySPV.SQL.Clear;
  End;
end;

function TSituacaoPedidoVenda.fAddSituacaoFin: String;
  Var
     blnJaUsouCreditoDeAdiantamento: Boolean;
     fltValRec: Double;
     strConPag: String;
     strPenFin: String;
begin
  Try
    FQrySPV.SQL.Add(sqlInformacaoFinanceiraPV.Replace('/*<<REFORMA_FDO>>*/', fSqlValorReformaFdoRef('D.AUTOINCREM')));
    FQrySPV.ParamByName('NUMDOC').AsString := FNumDoc;
    FQrySPV.ParamByName('ESPDOC').AsString := FEspDoc;
    FQrySPV.ParamByName('CODEMP').AsString := FCodEmp;
    FQrySPV.ParamByName('NPDF11').AsString := fCfgSis('NPDF11', varString);
    FQrySPV.ParamByName('NPRF11').AsString := fCfgSis('NPRF11', varString);
    FQrySPV.ParamByName('NPLF11').AsString := fCfgSis('NPLF11', varString);
    FQrySPV.ParamByName('LOCRET').AsString := fCfgSis('LOCRET', varString);
    FQrySPV.Open;

    blnJaUsouCreditoDeAdiantamento:= False;

    fltValRec := fFormataFloat(FQrySPV.FieldByName('VALADT').AsFloat + FQrySPV.FieldByName('VALREC').AsFloat, 2);
    strConPag := FQrySPV.FieldByName('CONPAG').AsString;

    If ((strConPag = '01000') And (fltValRec > 0) And (fltValRec < FQrySPV.FieldByName('VLRCON').AsFloat)) Or
       ((fltValRec <= 0) And (strConPag <> '01000') And (fConPagComEntrada(strConPag))) Then
    Begin
      blnJaUsouCreditoDeAdiantamento := fJaUsouCreditoDeAdiantamento(FNumDoc,
                                                                     FEspDoc,
                                                                     FCodEmp);
    End;

    If fValidaSituacaoFinanceiraPedido(FQrySPV.FieldByName('CODCLI').AsString,
                                       FEspDoc,
                                       FQrySPV.FieldByName('CODFPG').AsString,
                                       strConPag,
                                       FQrySPV.FieldByName('FPGNEG').AsString,
                                       FQrySPV.FieldByName('AUTINC').AsString,
                                       FQrySPV.FieldByName('TIPOPE').AsString,
                                       FQrySPV.FieldByName('ORIF11').AsString = 'S',
                                       FQrySPV.FieldByName('VLRCON').AsFloat - FQrySPV.FieldByName('TOTBRI').AsFloat,
                                       fltValRec,
                                       FQrySPV.FieldByName('BOLADT').AsFloat,
                                       FQrySPV.FieldByName('BOLVEN').AsString = 'S',
                                       FQrySPV.FieldByName('BENFUT').AsString = 'S',
                                       strPenFin,
                                       blnJaUsouCreditoDeAdiantamento) Then
      Result := sfRecebido.fGetLegendaTexto
    Else
      Result := sfPendente.fGetLegendaTexto;

  Finally
    FQrySPV.Close;
    FQrySPV.SQL.Clear;
  End;
end;

constructor TSituacaoPedidoVenda.Create;
begin
  inherited Create;
  FQrySPV := fCriaQuery();

{$IFNDEF LINUX}
  FLegenda := TLegenda.Create();
  FLegendaCompleta := TLegenda.Create();
  FLegendaFin := TLegenda.Create();
  FLegendaAdt := TLegenda.Create();

  pSetLegenda();
  pSetLegendaCompleta();
  pSetLegendaFin();
  pSetLegendaAdt();
{$ENDIF LINUX}
end;

{$IFNDEF LINUX}
class function TSituacaoPedidoVenda.fRetornaLegenda: TLegenda;
begin
  Result := GetInstance().FLegenda;
end;

class function TSituacaoPedidoVenda.fRetornaLegendaCompleta: TLegenda;
begin
  Result := GetInstance().FLegendaCompleta;
end;

class function TSituacaoPedidoVenda.fRetornaLegendaAdt: TLegenda;
begin
  Result := GetInstance().FLegendaAdt;
end;

class function TSituacaoPedidoVenda.fRetornaLegendaFin: TLegenda;
begin
  Result := GetInstance().FLegendaFin;
end;
{$ENDIF LINUX}

class function TSituacaoPedidoVenda.fRetornaSituacaoAdiantamento(
  const strCodEmp, strNumDoc, strEspDoc: String): String;
  var
    Instance: TSituacaoPedidoVenda;
begin
  Instance := GetInstance();
  Instance.FCodEmp := strCodEmp;
  Instance.FNumDoc := strNumDoc;
  Instance.FEspDoc := strEspDoc;
  Result := Instance.fAddSituacaoAdt();
end;

class function TSituacaoPedidoVenda.fRetornaSituacaoFinanceira(const strCodEmp,
  strNumDoc, strEspDoc: String): String;
  var
    Instance: TSituacaoPedidoVenda;
begin
  Instance := GetInstance();
  Instance.FCodEmp := strCodEmp;
  Instance.FNumDoc := strNumDoc;
  Instance.FEspDoc := strEspDoc;
  Result := Instance.fAddSituacaoFin();
end;

class function TSituacaoPedidoVenda.GetInstance: TSituacaoPedidoVenda;
begin
  If Not Assigned(FInstance) Then
    FInstance := TSituacaoPedidoVenda.Create;
  Result := FInstance;
end;

{$IFNDEF LINUX}
procedure TSituacaoPedidoVenda.pSetLegenda;
  Var
    teSit: TEStatusPedidoVenda;
begin
  FLegenda.Clear;
  For teSit := Low(TEStatusPedidoVenda) To High(TEStatusPedidoVenda) Do
    If teSit.fUtilizarStatus Then
      FLegenda.Add(teSit.fGetDescricao(), teSit.fGetImageIdx());

  FLegenda.TrimExcess;
end;

procedure TSituacaoPedidoVenda.pSetLegendaCompleta;
  Var
    teSit: TEStatusPedidoVenda;
begin
  FLegendaCompleta.Clear;
  For teSit := Low(TEStatusPedidoVenda) To High(TEStatusPedidoVenda) Do
    FLegendaCompleta.Add(teSit.fGetDescricao(), teSit.fGetImageIdx());

  FLegendaCompleta.TrimExcess;
end;


procedure TSituacaoPedidoVenda.pSetLegendaAdt;
  Var
    teSit: TEAdiantamentoPedido;
begin
  For teSit := Low(TEAdiantamentoPedido) To High(TEAdiantamentoPedido) Do
    FLegendaAdt.Add(teSit.fGetLegendaTexto, teSit.fGetLegendaIdx);

  FLegendaAdt.TrimExcess;
end;

procedure TSituacaoPedidoVenda.pSetLegendaFin;
  Var
    teSit: TESituacaoFinanceira;
begin
  For teSit := Low(TESituacaoFinanceira) To High(TESituacaoFinanceira) Do
    FLegendaFin.Add(teSit.fGetLegendaTexto, teSit.fGetLegendaIdx);

  FLegendaFin.TrimExcess;
end;
{$ENDIF LINUX}

{ TEStatusPedidoVendaHelper }

function TEStatusPedidoVendaHelper.fGetId: Integer;
begin
  Case Self Of
    pvAgEnderecamento       : Result := 1;
    pvFaturado              : Result := 2;
    pvAgSeparacao           : Result := 3;
    pvSeparando             : Result := 4;
    pvAgCompra              : Result := 5;
    pvAgPedidoTransferencia : Result := 6;
    pvAgLiberacaoCom        : Result := 7;
    pvAgEntregaCompra       : Result := 8;
    pvAgLiberacaoFin        : Result := 9;
    pvAgLiberacaoFinCom     : Result := 10;
    pvAgFaturamento         : Result := 11;
    pvAgTransferencia       : Result := 12;
    pvAgConferenciaEntrada  : Result := 13;
    pvAgRequisicaoCompra    : Result := 14;
    pvBaixado               : Result := 15;
    pvFaturadoAgRomaneio    : Result := 16;
    pvFaturadoEntregue      : Result := 17;
    pvFaturadoEmTransito    : Result := 18;
    pvLiberacaoNegada       : Result := 19;
    pvAgEntrada             : Result := 20;
    pvPedidoEmAberto        : Result := 21;
    pvAgEntregaTransferencia: Result := 22;
    pvRequisicaoCompraNegada: Result := 23;
    pvExtornoSeparacao      : Result := 24;
    pvAgMovimentoFiscal     : Result := 25;
    pvAgConferenciaExp      : Result := 26;
    pvFaturadoParcialmente  : Result := 27;
    pvFaturadoParcAgRomaneio: Result := 28;
    pvFaturadoParcEmTransito: Result := 29;
    pvFaturadoParcEntregue  : Result := 30;
    pvFaturadoAgCliRet      : Result := 31;
    pvFaturadoDevTotal      : Result := 32;
    pvAgDiaSemanaFaturamento: Result := 33;
    pvFaturamentoCancelado  : Result := 34;
    pvSeparacaoAndamento    : Result := 35;
    pvConferenciaAndamento  : Result := 36;
    pvConferenciaIniciada   : Result := 37;
  Else
    Result := 0;
  End;
end;

function TEStatusPedidoVendaHelper.fGetImageIdx: Integer;
begin
  Result := Pred(Self.fGetId());
end;

function TEStatusPedidoVendaHelper.fGetSQL(ATipo: TGetSQLStatus.TipoStatus): String;
Var
  LGetSQL: IGetSQLStatus;
begin
  LGetSQL := TGetSQLStatus.New(ATipo);
  Case Self Of
    pvPedidoEmAberto        : Result := LGetSQL.sqlPedidoEmAberto;
    pvBaixado               : Result := LGetSQL.sqlPedidoVendaBaixado;
    pvFaturadoParcAgRomaneio:
      Begin
        If (Pos(fCfgSis('OPCROM'), '1_5_') > 0) And (Not (fCfgSis('CONENT', varBoolean))) Then
          Result := LGetSQL.sqlRomaneioPDPendente(tfParcial)
        Else
          Result := LGetSQL.sqlRomaneioNFPendente(tfParcial);
      End;
    pvFaturadoParcEmTransito:
      Begin
        If (Pos(fCfgSis('OPCROM'), '1_5_') > 0) And (Not (fCfgSis('CONENT', varBoolean))) Then
          Result := LGetSQL.sqlFaturadoPDEmTransito(tfParcial)
        Else
          Result := LGetSQL.sqlFaturadoNFEmTransito(tfParcial);
      End;
    pvFaturadoParcEntregue  :
      Begin
        If (Pos(fCfgSis('OPCROM'), '1_5_') > 0) And (Not (fCfgSis('CONENT', varBoolean))) Then
          Result := LGetSQL.sqlFaturadoPDEntregue(tfParcial)
        Else
          Result := LGetSQL.sqlFaturadoNFEntregue(tfParcial);
      End;
    pvFaturadoParcialmente  : Result := LGetSQL.sqlPedidoVendaJaFaturado(tfParcial);
    pvFaturadoAgCliRet      : Result := LGetSQL.sqlPedidoVendaClienteRetira(tfTotal);
    pvFaturadoAgRomaneio    :
      Begin
        If (Pos(fCfgSis('OPCROM'), '1_5_') > 0) And (Not (fCfgSis('CONENT', varBoolean))) Then
          Result := LGetSQL.sqlRomaneioPDPendente(tfTotal)
        Else
          Result := LGetSQL.sqlRomaneioNFPendente(tfTotal);
      End;
    pvFaturadoEmTransito    :
      Begin
        If (Pos(fCfgSis('OPCROM'), '1_5_') > 0) And (Not (fCfgSis('CONENT', varBoolean))) Then
          Result := LGetSQL.sqlFaturadoPDEmTransito(tfTotal)
        Else
          Result := LGetSQL.sqlFaturadoNFEmTransito(tfTotal);
      End;
    pvFaturadoEntregue      :
      Begin
        If (Pos(fCfgSis('OPCROM'), '1_5_') > 0) And (Not (fCfgSis('CONENT', varBoolean))) Then
          Result := LGetSQL.sqlFaturadoPDEntregue(tfTotal)
        Else
          Result := LGetSQL.sqlFaturadoNFEntregue(tfTotal);
      End;
    pvFaturado              : Result := LGetSQL.sqlPedidoVendaJaFaturado(tfTotal);
    pvAgLiberacaoFinCom     : Result := LGetSQL.sqlPendenteLibComFin;
    pvAgLiberacaoCom        : Result := LGetSQL.sqlPendenteLibComercial;
    pvAgLiberacaoFin        : Result := LGetSQL.sqlPendenteLibFinanceira;

    //Req: 153351 (Casa das correias)
    pvAgRequisicaoCompra    : If fUsaRotinaExpedicaoConferenciaRetiraCaixa Then
                                Result := LGetSQL.sqlCompraPendente
                              Else
                                Result := LGetSQL.sqlRequisicaoPendente;

    pvRequisicaoCompraNegada: Result := LGetSQL.sqlRequisicaoCompraNegada;
    pvAgCompra              : Result := LGetSQL.sqlCompraPendente;
    pvAgPedidoTransferencia : Result := LGetSQL.sqlPedidoTransfPendente;
    pvAgTransferencia       : Result := LGetSQL.sqlTransferenciaPendente;
    pvAgEntregaCompra       :
      Begin
        If fCfgSis('USACON', VarBoolean) Then
        Begin
          If (fCfgSis('TIPPNT') = 'D') Then
            Result := LGetSQL.sqlEntregaPendenteQuandoConferenciaDepoisDaEntrada
          Else
            Result := LGetSQL.sqlEntregaPendenteCompraQuandoConferenciaAntesDaEntrada;
        End
        Else
          Result := LGetSQL.sqlEntregaPendenteCompraQuandoNaoUsaConferencia;
      End;
    pvAgEntregaTransferencia:
      Begin
        If (fCfgSis('TIPPNT') = 'D') Then
          Result := LGetSQL.sqlEntregaPendenteCDTran
        Else
          Result := LGetSQL.sqlEntregaPendenteTransf;
      End;
    pvAgConferenciaEntrada  : Result := LGetSQL.sqlConferenciaEntradaPendente(fCfgSis('TIPPNT') = 'D');
    pvAgEntrada             : Result := LGetSQL.sqlEntradaMercadoriaPend(fCfgSis('TIPPNT') = 'D');
    pvAgMovimentoFiscal     : Result := LGetSQL.sqlMovimentoFiscalPendente(fCfgSis('TIPPNT') = 'D');
    pvAgEnderecamento       : Result := LGetSQL.sqlEnderecamentoPendente;
    pvExtornoSeparacao      : Result := LGetSQL.sqlExtornoSeparacao;
    pvAgSeparacao           : Result := LGetSQL.sqlSeparacaoPendente;
    pvSeparando             :
      Begin
        If fCfgSis('BAISEP', varBoolean) Then
          Result := LGetSQL.sqlEmSeparacaoBaiSep
        Else
        Begin
          If fUtilizarStatusDeSeparacaoEConferencia Then
            Result := LGetSQL.sqlEmSeparacaoUsandoConferenciaComBaiSepDesligado
          Else
            Result := LGetSQL.sqlEmSeparacao;
        End;
      End;
    pvAgConferenciaExp      :
      Begin
        If fUtilizarStatusDeSeparacaoEConferencia Then
          Result := LGetSQL.sqlAguardandoConferenciaComBaiSepDesligado
        Else
          Result := LGetSQL.sqlConferenciaExpPendente;
      End;
    pvAgFaturamento         : Result := LGetSQL.sqlFaturamentoPendente;
    pvLiberacaoNegada       : Result := LGetSQL.sqlPedidoNegado;
    pvFaturadoDevTotal      : Result := LGetSQL.sqlFaturadoDevTotal;
    pvFaturamentoCancelado  : Result := LGetSQL.sqlFaturamentoCancelado;
    pvSeparacaoAndamento    :
      Begin
        If fCfgSis('BAISEP', varBoolean) Then
          Result := LGetSQL.sqlSeparacaoAndamento
        Else
          Result := LGetSQL.sqlEmSeparacao;
      End;
    pvConferenciaAndamento  :
      Begin
        If fUtilizarStatusDeSeparacaoEConferencia Then
          Result := LGetSQL.sqlConferenciaAndamentoQuandoBaiSepDesligada
        Else
          Result := LGetSQL.sqlConferenciaAndamento;
      End;
  Else
    Result := '';
  End;
end;

function TEStatusPedidoVendaHelper.fConsiderarJaFatu: Boolean;
begin
  Case Self Of
    pvPedidoEmAberto,
    pvLiberacaoNegada,
    pvAgLiberacaoFinCom,
    pvAgLiberacaoCom,
    pvAgLiberacaoFin,
    pvAgRequisicaoCompra,
    pvRequisicaoCompraNegada,
    pvAgCompra,
    pvAgPedidoTransferencia,
    pvAgTransferencia,
    pvAgEntregaCompra,
    pvAgEntregaTransferencia,
    pvAgConferenciaEntrada,
    pvAgEntrada,
    pvAgMovimentoFiscal,
    pvAgEnderecamento,
    pvExtornoSeparacao,
    pvAgSeparacao,
    pvSeparando,
    pvAgConferenciaExp,
    pvConferenciaAndamento,
    pvSeparacaoAndamento,
    pvAgFaturamento : Result := True;
  Else
    Result := False;
  End;
end;

function TEStatusPedidoVendaHelper.fGetAcaFatCRM: TAcaoFatCRM;
begin
  Case Self Of
    pvAgRequisicaoCompra    : Result := afcPedidoAgReqCompra;
    pvAgCompra              : Result := afcPedidoAgCompra;
    pvAgPedidoTransferencia : Result := afcPedidoAgPDTransferencia;
    pvAgTransferencia       : Result := afcPedidoAgTransferencia;
    pvAgEntregaCompra,
    pvAgEntregaTransferencia: Result := afcPedidoAgEntrega;
    pvAgConferenciaEntrada  : Result := afcPedidoCPAgConferencia;
    pvAgEntrada             : Result := afcPedidoAgEntrada;
    pvAgMovimentoFiscal     : Result := afcPedidoAgMovimentoFiscal;
    pvAgEnderecamento       : Result := afcNotaEntAgEnderecamento;
    pvExtornoSeparacao      : Result := afcExtornoSeparacao;
    pvAgSeparacao           : Result := afcPedidoAgSeparacao;
    pvAgFaturamento         : Result := afcPedidoAgFaturamento;
    pvBaixado               : Result := afcPDTransferenciaBaixado;
    pvFaturadoAgRomaneio,
    pvFaturadoParcAgRomaneio: Result := afcPedidoAgRomaneio;
  Else
    Result := afcNenhum;
  End;
end;

function TEStatusPedidoVendaHelper.fIsUpdateOccurrencyCRM: Boolean;
begin
  Case Self Of
    pvBaixado,
    pvAgCompra,
    pvAgEntrada,
    pvExtornoSeparacao,
    pvAgSeparacao,
    pvAgFaturamento,
    pvAgConferenciaEntrada,
    pvAgMovimentoFiscal,
    pvAgEnderecamento,
    pvAgTransferencia,
    pvAgEntregaCompra,
    pvAgRequisicaoCompra,
    pvFaturadoAgRomaneio,
    pvFaturadoParcAgRomaneio,
    pvAgPedidoTransferencia,
    pvAgEntregaTransferencia : Result := True;
  Else
    Result := False;
  End;
end;

function TEStatusPedidoVendaHelper.fIsFaturadoParciamente: Boolean;
begin
  Result := Self In [pvFaturadoParcAgRomaneio, pvFaturadoParcEmTransito,
    pvFaturadoParcEntregue, pvFaturadoParcialmente];
end;

function TEStatusPedidoVendaHelper.fUsaEnderecamento: Boolean;
begin
  Result := False;
  If fCfgSis('ENTEND', varBoolean) Then
  Begin
    Result := fCfgSis('DEVEND', varBoolean);

    If Not Result Then
      Result := fCfgSis('USACON', varBoolean) And
               (Pos(fCfgSis('CONFME'), '1_3_') > 0);
  End;
end;

function TEStatusPedidoVendaHelper.fUtilizarStatus: Boolean;
begin
  If ((Self = pvSeparando) Or (Self= pvSeparacaoAndamento)) And
     (Not Pos(VS_strTipExp, '3_4_5_') > 0) Then
    Exit(False);

  If (Self = pvAgEnderecamento) Then
    If (Not fUsaEnderecamento) Then
      Exit(False);

  If (Self In [pvFaturadoAgCliRet, pvFaturadoAgRomaneio, pvFaturadoEmTransito,
               pvFaturadoEntregue, pvFaturadoParcAgRomaneio, pvFaturadoParcEmTransito, pvFaturadoParcEntregue]) Then
  Begin
    If (Not (fCfgSis('UTIROM', varBoolean))) Then
      Exit(False);
  End;

  If (Self = pvSeparacaoAndamento) And (fUtilizarStatusDeSeparacaoEConferencia) Then
    Exit(False);

  If (Self In [pvAgConferenciaExp, pvConferenciaAndamento]) Then
  Begin
    If (VS_strTipExp <> '4') And (VS_strTipExp <> '5') Then
      Exit(False);

    If (Not fUtilizarStatusDeSeparacaoEConferencia) Then
    Begin
      If (Not fCfgExpedicaoParcialHabilitada) Then
        Exit(False);

      If Not fCfgSis('BAISEP',varBoolean) Then
        Exit(False);
    End;
  End;

  //Req: 215303
  If Self.fIsFaturadoParciamente Then
    Exit(False);

  Result := True;
end;

function TEStatusPedidoVendaHelper.fGetDescricao: String;
begin
  Case Self Of
    pvPedidoEmAberto        : Result := spvPedidoEmAberto;
    pvBaixado               : Result := spvBaixado;
    pvFaturadoAgCliRet      : Result := spvFaturadoAgCliRet;
    pvFaturadoAgRomaneio    : Result := spvFaturadoAgRomaneio;
    pvFaturadoEmTransito    : Result := spvFaturadoEmTransito;
    pvFaturadoEntregue      : Result := spvFaturadoEntregue;
    pvFaturado              : Result := spvFaturado;
    pvAgLiberacaoFinCom     : Result := spvAgLiberacaoFinCom;
    pvAgLiberacaoCom        : Result := spvAgLiberacaoCom;
    pvAgLiberacaoFin        : Result := spvAgLiberacaoFin;
    pvAgRequisicaoCompra    : Result := spvAgRequisicaoCompra;
    pvRequisicaoCompraNegada: Result := spvRequisicaoCompraNegada;
    pvAgCompra              : Result := spvAgCompra;
    pvAgPedidoTransferencia : Result := spvAgPedidoTransferencia;
    pvAgTransferencia       : Result := spvAgTransferencia;
    pvAgEntregaCompra       : Result := spvAgEntregaCompra;
    pvAgEntregaTransferencia: Result := spvAgEntregaTransferencia;
    pvAgConferenciaEntrada  : Result := spvAgConferenciaEntrada;
    pvAgEntrada             : Result := spvAgEntrada;
    pvAgMovimentoFiscal     : Result := spvAgMovimentoFiscal;
    pvAgEnderecamento       : Result := spvAgEnderecamento;
    pvExtornoSeparacao      : Result := spvExtornoSeparacao;
    pvAgSeparacao           : Result := spvAgSeparacao;
    pvSeparando             : Result := spvSeparando;
    pvAgConferenciaExp      : Result := spvAgConferenciaExp;
    pvAgFaturamento         : Result := spvAgFaturamento;
    pvLiberacaoNegada       : Result := spvLiberacaoNegada;
    pvFaturadoParcialmente  : Result := spvFaturadoParcialmente;
    pvFaturadoParcAgRomaneio: Result := spvFaturadoParcAgRomaneio;
    pvFaturadoParcEmTransito: Result := spvFaturadoParcEmTransito;
    pvFaturadoParcEntregue  : Result := spvFaturadoParcEntregue;
    pvFaturadoDevTotal      : Result := spvFaturadoDevTotal;
    pvAgDiaSemanaFaturamento: Result := spvAgDiaSemanaFaturamento;
    pvFaturamentoCancelado  : Result := spvFaturamentoCancelado;
    pvSeparacaoAndamento    : Result := spvSeparacaoAndamento;
    pvConferenciaAndamento  : Result := spvConferenciaAndamento;
    pvConferenciaIniciada   : Result := spvConferenciaIniciada;
  Else
    Result := '';
  End;
end;

{ TESituacaoFinanceiraHelper }

function TESituacaoFinanceiraHelper.fGetLegendaIdx: Integer;
begin
  Case Self Of
    sfPendente: Result := 0;
    sfRecebido: Result := 1;
  Else
    Result := -1;
  End;
end;

function TESituacaoFinanceiraHelper.fGetLegendaTexto: String;
begin
  Case Self Of
    sfPendente: Result := 'Pendente';
    sfRecebido: Result := 'Recebido';
  Else
    Result := '';
  End;
end;

{ TRepositoryStatus }
function TRepositoryStatus.fRetStatusCadastrados: String;
var
  LQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQuery := fCriaQuery();
  Try
    LQuery.Close;
    LQuery.SQL.Text := sqlSelectStatus;
    LQuery.Open;

    Result := '_' + AnsiReplaceStr(LQuery.FieldByName('CODIGOS').AsString, ',', '_') + '_';
  Finally
{$IFNDEF LINUX}
    FreeAndNil(LQuery);
{$ENDIF LINUX}
  End;
end;

function TRepositoryStatus.fStatusJaCadastrado(LEnum: TEStatusPedidoVenda; strStatusCadastrados: String): Boolean;
begin
  Result := Pos('_'+IntToStr(LEnum.fGetId())+'_', strStatusCadastrados) > 0;
end;

class function TRepositoryStatus.New: IRepositoryStatus;
begin
  Result := TRepositoryStatus.Create();
end;

procedure TRepositoryStatus.pCheck;
var
  LQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LEnum: TEStatusPedidoVenda;
  strStatusCadastrados: String;
begin
  LQuery := fCriaQuery();

  Try
    strStatusCadastrados := fRetStatusCadastrados;

    LQuery.SQL.Add(sqlUpInsertStatus);

    For LEnum := Low(TEStatusPedidoVenda) To High(TEStatusPedidoVenda) Do
    Begin
      if fStatusJaCadastrado(LEnum, strStatusCadastrados) then
        Continue;

      LQuery.ParamByName('CODIGO').AsInteger := LEnum.fGetId();
      LQuery.ParamByName('DESCRI').AsString := LEnum.fGetDescricao();
      LQuery.ExecSQL();
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(LQuery);
{$ENDIF LINUX}
  End;
end;

{ TUpdateStatus }

constructor TUpdateStatus.Create(AParams: IParamStatus);
begin
  FParams := AParams;
  FModified := False;
  FQuery := fCriaQuery();
end;

destructor TUpdateStatus.Destroy;
begin
{$IFNDEF LINUX}
  FreeAndNil(FQuery);
{$ENDIF LINUX}
  inherited;
end;

function TUpdateStatus.fCurrentStatus: Integer;
var
  LQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQuery := fCriaQuery();

  Try
    LQuery.SQL.Add(sqlStatusAtualPedido);
    LQuery.ParamByName('NUMDOC').AsString := FParams.NumDoc();
    LQuery.ParamByName('ESPDOC').AsString := FParams.EspDoc();
    LQuery.ParamByName('CODEMP').AsString := FParams.CodEmp();
    LQuery.Open();

    Result := LQuery.FieldByName('FGO_STATUS').AsInteger;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(LQuery);
{$ENDIF LINUX}
  End;
end;

function TUpdateStatus.fExecute: TResultExecute;
begin
  FillChar(Result, SizeOf(Result), #0);
  pExecute;
  Result.Modified := FModified;
end;

function TUpdateStatus.fGetSqlInsertAltStaPedido: String;
begin
  pValidarVS_AltStaBigInt;
  If (VS_AltStaBigInt = 'S') Then
    Result := sqlInsertAltStaPedido
  Else
    Result := sqlInsertAltStaPedidoAutoincrem;
end;

function TUpdateStatus.fStatusModified: Boolean;
begin
  FStatus := TStatus.New(FParams).fGetStatus();
  Result := (FStatus.fGetId() <> fCurrentStatus());
end;

function TUpdateStatus.fVerificaBaixaSeparacao: Boolean;
var
  LQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  Result := True;

  if (not fCfgSis('FLXSEP', varBoolean)) then
    Exit;

  if (not (FStatus in [pvAgSeparacao, pvExtornoSeparacao, pvSeparando, pvSeparacaoAndamento])) then
    Exit;

  LQuery := fCriaQuery();

  try
    LQuery.SQL.Add(sqlVerificarBaixaSepOS);
    LQuery.ParamByName('NUMDOC').AsString := FParams.NumDoc();
    LQuery.ParamByName('ESPDOC').AsString := FParams.EspDoc();
    LQuery.ParamByName('CODEMP').AsString := FParams.CodEmp();
    LQuery.Open();

    Result := LQuery.IsEmpty;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQuery);
{$ENDIF LINUX}
  end;
end;

function TUpdateStatus.fVerificaTemItensPedidoNaoReservado(ASeqEqu: String): Boolean;
var
  LQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQuery := fCriaQuery();

  try
    LQuery.SQL.Add(sqlPedidoOSNaoReservado);
    LQuery.ParamByName('NUMDOC').AsString := FParams.NumDoc();
    LQuery.ParamByName('ESPDOC').AsString := FParams.EspDoc();
    LQuery.ParamByName('CODEMP').AsString := FParams.CodEmp();
    LQuery.ParamByName('SEQEQU').AsString := ASeqEqu;
    LQuery.Open();

    Result := (LQuery.FieldByName('QTDE').AsInteger > 0);
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQuery);
{$ENDIF LINUX}
  end;
end;

class function TUpdateStatus.New(AParams: IParamStatus = nil):
  {$IFDEF LINUX} ITaskMonitorProcedure {$ELSE } IMonitorProcedure {$ENDIF LINUX};
begin
  Result := TUpdateStatus.Create(AParams);
end;

procedure TUpdateStatus.pExecute;
var
  LQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LTime: TTime;
  LDeveExecutarUpdate : Boolean;
  LOpenedTransaction: Boolean;
begin
  If (Not fCfgSis('EXISTA', varBoolean)) Then
    Exit;

  If FParams.NumDoc().IsEmpty Then
    Exit;

  LQuery := fCriaQuery();
  Try
    FModified := fStatusModified();

    If fExecutandoPeloPortal Then
      Exit;

    LOpenedTransaction := fInTransaction();

    Try
      LQuery.SQL.Clear();

      LTime := RemoveMilliseconds(fTime());
      LDeveExecutarUpdate := FModified Or fEmptyStr(FParams.AutoincremFatgor);

      If (Not LDeveExecutarUpdate) And (Not FModified) Then
      Begin
        {$IFNDEF LINUX}
        if FStatus in [pvAgSeparacao, pvSeparando, pvExtornoSeparacao, pvAgFaturamento, pvSeparacaoAndamento] then
        begin
          If Not LOpenedTransaction Then
            fStartTransaction();
          pVerificaPedidoOS;
          If Not LOpenedTransaction Then
            fCommit();
        end;
        {$ENDIF LINUX}
        Exit;
      End;

      If Not LOpenedTransaction Then
        fStartTransaction();

      If (LDeveExecutarUpdate) Then
      Begin
        //Se nao houve alteracao no status nao vamos replicar o comando que atualiza
        //a data e hora da modificacao do status, ira gerar muitas instrucoes desnecessarias
        //na tabela LOGREP.
        //No entanto, como usamos a data e hora para controlar a proxima verificacao,
        //precisamos continuar atualizando estes campos.
        If Not FModified Then
          LQuery.SQL.Add(STR_SQL_NAO_REPLICAR);

        LQuery.SQL.Add(sqlUpdateStatusPedido);

        If FStatus.fConsiderarJaFatu() Then
          LQuery.SQL.Add('  AND F.FGO_JAFATU = 0 ');

        LQuery.ParamByName('STATUS').AsInteger := FStatus.fGetId();
        LQuery.ParamByName('NUMDOC').AsString := FParams.NumDoc();
        LQuery.ParamByName('ESPDOC').AsString := FParams.EspDoc();
        LQuery.ParamByName('CODEMP').AsString := FParams.CodEmp();
        LQuery.ParamByName('DTASTA').AsDate   := VS_Date;
        LQuery.ParamByName('HRASTA').AsTime := LTime;
        LQuery.ExecSQL();

       {$IFNDEF LINUX}
        LQuery.SQL.Clear();
        LQuery.SQL.Add(sqlReprocessarStatusItensPedido);
        LQuery.ParamByName('NUMDOC').AsString := FParams.NumDoc();
        LQuery.ParamByName('ESPDOC').AsString := FParams.EspDoc();
        LQuery.ParamByName('CODEMP').AsString := FParams.CodEmp();
        LQuery.ExecSQL();
       {$ENDIF}
      End;

      If FModified Then
      Begin
        if (FStatus in [pvAgSeparacao, pvSeparando, pvFaturado, pvFaturadoAgCliRet, pvFaturadoAgRomaneio, pvFaturadoEntregue, pvFaturadoEmTransito,
                        pvFaturadoParcialmente, pvFaturadoParcAgRomaneio, pvFaturadoParcEmTransito, pvFaturadoParcEntregue, pvBaixado,
                        pvExtornoSeparacao, pvAgFaturamento, pvSeparacaoAndamento]) then
          pVerificaPedidoOS;

        LQuery.SQL.Clear();
        LQuery.SQL.Add(fGetSqlInsertAltStaPedido);

        If FStatus.fConsiderarJaFatu() Then
          LQuery.SQL.Add('  AND FGO_JAFATU = 0 ');

        LQuery.ParamByName('STATUS').AsInteger := FStatus.fGetId();
        LQuery.ParamByName('NUMDOC').AsString := FParams.NumDoc();
        LQuery.ParamByName('ESPDOC').AsString := FParams.EspDoc();
        LQuery.ParamByName('CODEMP').AsString := FParams.CodEmp();
        If (fEmptyStr(VS_AltStaBigInt)) Or (VS_AltStaBigInt = 'N') Then
          LQuery.ParamByName('AUTINC').AsString := fRetAutoIncrem('ALTSTA', VS_strCodEmp);
        LQuery.ParamByName('DTAMUD').AsDate   := VS_Date;
        LQuery.ParamByName('HRAMUD').AsTime := LTime;
        LQuery.ExecSQL();

        If VS_strHabilitarCRM And FStatus.fIsUpdateOccurrencyCRM() Then
          TUpdateOccurrenceCRM.New()
            .NumDoc(FParams.NumDoc())
            .EspDoc(FParams.EspDoc())
            .CodEmp(FParams.CodEmp())
            .CodCli(FParams.CodCli())
            .AcaFat(FStatus.fGetAcaFatCRM())
            .blnImpSfa(FParams.blnImpSfa())
            .strNomFrm('[TUpdateStatus.pExecute]')
            .pRun();
      End
      Else If Not FModified Then
      Begin
        {$IFNDEF LINUX}
        if FStatus in [pvAgSeparacao, pvSeparando, pvExtornoSeparacao, pvAgFaturamento, pvSeparacaoAndamento] then
          pVerificaPedidoOS;
        {$ENDIF LINUX}
      End;

      If Not LOpenedTransaction Then
        fCommit();
    Except
      On E: Exception Do
      begin
        If Not LOpenedTransaction Then
          fRollBack();
        Raise;
      end;
    end;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(LQuery);
{$ENDIF LINUX}
  End;
end;

procedure TUpdateStatus.pExecuteAll;
var
  LResultUpdateStatus : TResultExecute;
  LStatusNaoModificados : TList<String>;
  LHavingTimeDiff: string;
begin
  If (Not fCfgSis('EXISTA', varBoolean)) Then
    Exit;

  LStatusNaoModificados := TList<String>.Create;
  Try
    If Not FQuery.Active Or FQuery.Eof Then
    Begin
      LHavingTimeDiff := ' HAVING FGO_DTASTA IS NULL OR (TIMEDIFF(' + fCurrentDateTime +
        ', CONCAT(FGO_DTASTA, " ", FGO_HRASTA)) > "00:10:00") ';

      FQuery.Close;
      FQuery.SQL.Clear;

      FQuery.SQL.Add(
        sqlPedidosNaoFaturados.Replace('HAVING_TIMEDIFF', LHavingTimeDiff)
        + ' ORDER BY FGO_DTASTA, FGO_HRASTA '
        + ' LIMIT 250 ' );

      FQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;
      FQuery.Open();
    End;

    While (Not FQuery.Eof) Do
    Begin
      {$IFDEF LINUX}
      If Not GetParamValue('-s').IsEmpty Then
        Sleep(StrToIntDef(GetParamValue('-s'), 100))
      Else
        Sleep(100);
      {$ENDIF LINUX}

      LResultUpdateStatus := TUpdateStatus.New(TParamStatus.New()
                              .NumDoc(FQuery.FieldByName('FGO_NUMDOC').AsString)
                              .EspDoc(FQuery.FieldByName('FGO_ESPDOC').AsString)
                              .CodEmp(FQuery.FieldByName('FGO_CODEMP').AsString)
                              .CodCli(FQuery.FieldByName('FGO_CODCLI').AsString)
                              .AutoincremFatgor(FQuery.FieldByName('INCGOR').AsString)
                             ).fExecute();

      If (Not LResultUpdateStatus.Modified) Then
        LStatusNaoModificados.Add(FQuery.FieldByName('INCGOR').AsString);

      FQuery.Next();

      If (FQuery.RecNo Mod 50 = 0) Then
        Break;
    End;

    pAtualizarDataHoraDosStatusNaoModificados(LStatusNaoModificados);
  Finally
    LStatusNaoModificados.Free;
  End;
end;

procedure TUpdateStatus.pInsereLogFlxOS(ANumOSe, ACodEmp, AFlxFasAnt,
  AFlxSitAnt, AFlxComAnt, AFlxFas, AFlxSit, AFlxCom: String);
var
  LQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQuery := fCriaQuery();

  try
    LQuery.SQL.Add(sqlInsertLogFluxoOS);
    LQuery.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGFLX', ACodEmp);
    LQuery.ParamByName('LOG_DTALOG').AsDate     := VS_Date;
    LQuery.ParamByName('LOG_HORLOG').AsDateTime := RemoveMilliseconds(fTime());
    LQuery.ParamByName('LOG_NUMOSE').AsString   := ANumOSe;
    LQuery.ParamByName('LOG_CODEMP').AsString   := ACodEmp;
    LQuery.ParamByName('LOG_CODOPE').AsString   := '999';
    LQuery.ParamByName('LOG_CODDIG').AsString   := '999';
    LQuery.ParamByName('LOG_FASANT').AsString   := AFlxFasAnt;
    LQuery.ParamByName('LOG_SITANT').AsString   := AFlxSitAnt;
    LQuery.ParamByName('LOG_COMANT').AsString   := AFlxComAnt;
    LQuery.ParamByName('LOG_FASATU').AsString   := AFlxFas;
    LQuery.ParamByName('LOG_SITATU').AsString   := AFlxSit;
    LQuery.ParamByName('LOG_COMATU').AsString   := AFlxCom;
    LQuery.ParamByName('LOG_EMPLOG').AsString   := VS_strCodEmp;
    LQuery.ParamByName('LOG_FLXLOG').AsString   := 'R';
    LQuery.ExecSQL();
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQuery);
{$ENDIF LINUX}
  end;
end;

procedure TUpdateStatus.pVerificaPedidoOS;
var
  LAutInc,
  LNumOSe,
  LCodEmp,
  LFlxFas,
  LFlxSit,
  LFlxCom,
  LNewSit: String;
  LStatusParaValidarOSEmManutencao: Boolean;
  LQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQuery := fCriaQuery();

  Try
    LQuery.SQL.Add(sqlPedidoOS);
    LQuery.ParamByName('NUMDOC').AsString := FParams.NumDoc();
    LQuery.ParamByName('ESPDOC').AsString := FParams.EspDoc();
    LQuery.ParamByName('CODEMP').AsString := FParams.CodEmp();
    LQuery.Open();

    LAutInc := LQuery.FieldByName('AUTOINCREM').AsString;
    LNumOSe := LQuery.FieldByName('EQU_NUMOSE').AsString;
    LCodEmp := LQuery.FieldByName('EQU_CODEMP').AsString;
    LFlxFas := LQuery.FieldByName('EQU_FLXFAS').AsString;
    LFlxSit := LQuery.FieldByName('EQU_FLXSIT').AsString;
    LFlxCom := LQuery.FieldByName('EQU_FLXCOM').AsString;

    LStatusParaValidarOSEmManutencao := (FStatus in [pvAgSeparacao, pvSeparando, pvExtornoSeparacao, pvAgFaturamento, pvSeparacaoAndamento]);

    if (LQuery.FieldByName('EQU_FLXFAS').AsString = 'M') and ((LQuery.FieldByName('EQU_FLXSIT').AsString = 'AP') or
       (LQuery.FieldByName('EQU_FLXSIT').AsString = 'AS') or (LQuery.FieldByName('EQU_FLXSIT').AsString = 'EM')) and
        LStatusParaValidarOSEmManutencao then
    begin
      if (LQuery.FieldByName('EQU_FLXSIT').AsString = 'AP') and (fVerificaTemItensPedidoNaoReservado(LQuery.FieldByName('AUTOINCREM').AsString)) then
        Exit;

      LNewSit := 'EM';

      if (LQuery.FieldByName('TEMPRD').AsString = 'S') and (not fVerificaBaixaSeparacao) then
        LNewSit := 'AS';

      if (LQuery.FieldByName('EQU_FLXSIT').AsString = LNewSit) then
        Exit;

      LQuery.Close;
      LQuery.SQL.Clear;
      LQuery.SQL.Add(sqlUpdateStatusOS);
      LQuery.ParamByName('AUTINC').AsString := LAutInc;
      LQuery.ParamByName('FLXFAS').AsString := 'M';
      LQuery.ParamByName('FLXSIT').AsString := LNewSit;
      LQuery.ParamByName('FLXCOM').AsString := 'AM';
      LQuery.ExecSQL();

      pInsereLogFlxOS(LNumOSe, LCodEmp, LFlxFas, LFlxSit, LFlxCom, 'M', LNewSit, 'AM');
    end
    else if ((LQuery.FieldByName('EQU_FLXCOM').AsString = 'AF') or (LQuery.FieldByName('EQU_FLXSIT').AsString = 'AF') or
      (LQuery.FieldByName('EQU_FLXCOM').AsString = 'AA')) and
      (not LStatusParaValidarOSEmManutencao) then
    begin
      LQuery.Close;
      LQuery.SQL.Clear;
      LQuery.SQL.Add(sqlUpdateStatusOS);
      LQuery.ParamByName('AUTINC').AsString := LAutInc;

      if (LFlxCom = 'AA') then
      begin
        if (FStatus = pvBaixado) then
        begin
          LQuery.ParamByName('FLXSIT').AsString := 'NF';
          pInsereLogFlxOS(LNumOSe, LCodEmp, LFlxFas, LFlxSit, LFlxCom, 'F', 'NF', 'AA');
        end
        else
        begin
          LQuery.ParamByName('FLXSIT').AsString := 'FA';
          pInsereLogFlxOS(LNumOSe, LCodEmp, LFlxFas, LFlxSit, LFlxCom, 'F', 'FA', 'AA');
        end;

        LQuery.ParamByName('FLXFAS').AsString := 'F';
        LQuery.ParamByName('FLXCOM').AsString := 'AA';
      end
      else if (LFlxCom = 'AF') then
      begin
        if (FStatus = pvBaixado) then
        begin
          LQuery.ParamByName('FLXSIT').AsString := 'NF';
          pInsereLogFlxOS(LNumOSe, LCodEmp, LFlxFas, LFlxSit, LFlxCom, 'F', 'NF', 'AR');
        end
        else
        begin
          LQuery.ParamByName('FLXSIT').AsString := 'FA';
          pInsereLogFlxOS(LNumOSe, LCodEmp, LFlxFas, LFlxSit, LFlxCom, 'F', 'FA', 'AR');
        end;

        LQuery.ParamByName('FLXFAS').AsString := 'F';
        LQuery.ParamByName('FLXCOM').AsString := 'AR';
      end
      else
      begin
        if (FStatus = pvBaixado) then
        begin
          LQuery.ParamByName('FLXSIT').AsString := 'NF';
          pInsereLogFlxOS(LNumOSe, LCodEmp, LFlxFas, LFlxSit, LFlxCom, 'R', 'NF', 'ER');
        end
        else
        begin
          LQuery.ParamByName('FLXSIT').AsString := 'FA';
          pInsereLogFlxOS(LNumOSe, LCodEmp, LFlxFas, LFlxSit, LFlxCom, 'R', 'FA', 'ER');
        end;

        LQuery.ParamByName('FLXFAS').AsString := 'R';
        LQuery.ParamByName('FLXCOM').AsString := 'ER';
      end;

      LQuery.ExecSQL();
    end;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(LQuery);
{$ENDIF LINUX}
  End;
end;

procedure TUpdateStatus.pValidarVS_AltStaBigInt;
  Var
    LQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  If (Not fEmptyStr(VS_AltStaBigInt)) Then
    Exit;
  LQuery := fCriaQuery();
  Try
    Try
      LQuery.SQL.Add(' SELECT INCREMENTO ');
      LQuery.SQL.Add('   FROM ALTSTA ');
      LQuery.SQL.Add('  WHERE FALSE ');
      LQuery.Open;
      VS_AltStaBigInt := 'S';
    Except
      VS_AltStaBigInt := 'N';
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(LQuery);
{$ENDIF LINUX}
  End;
end;

procedure TUpdateStatus.pAtualizarDataHoraDosStatusNaoModificados(const AStatusNaoModificados : TList<String>);
begin
  If AStatusNaoModificados.Count = 0 Then
    Exit;
  pProcessaPedidosNaoModificados(AStatusNaoModificados);
  AStatusNaoModificados.Clear;
end;

procedure TUpdateStatus.pProcessaPedidosNaoModificados(const AStatusNaoModificados : TList<String>);
  Var
    LAutIncPedidos : String;
    LCount : Integer;
    LRecords : Integer;
begin
  LAutIncPedidos := '';
  LRecords := 0;
  For LCount := 0 To Pred(AStatusNaoModificados.Count) Do
  Begin
    If fEmptyStr(AStatusNaoModificados[LCount]) Then
      Continue;
    Inc(LRecords);
    If fEmptyStr(LAutIncPedidos) Then
      LAutIncPedidos := QuotedStr(AStatusNaoModificados[LCount])
    Else
      LAutIncPedidos := LAutIncPedidos + ', ' + QuotedStr(AStatusNaoModificados[LCount]);
    If (LRecords >= 250) Then
    Begin
      pUpdateDataHoraStatusNaoModificados(LAutIncPedidos);
      pUpdateReprocessaStatusNaoModificados(LAutIncPedidos);
      LRecords := 0;
      LAutIncPedidos := '';
    End;
  End;
  If (Not fEmptyStr(LAutIncPedidos)) Then
  Begin
    pUpdateDataHoraStatusNaoModificados(LAutIncPedidos);
    pUpdateReprocessaStatusNaoModificados(LAutIncPedidos);
  End;
end;

procedure TUpdateStatus.pUpdateDataHoraStatusNaoModificados(const AAutIncPedidos : String);
  Var
    LQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    LOpenedTransaction : Boolean;
begin
  LQuery := fCriaQuery();
  Try
    SetLockWaitTimeout(5);
    LQuery.SQL.Clear;
    LQuery.SQL.Add(STR_SQL_NAO_REPLICAR);
    LQuery.SQL.Add(' UPDATE EXTGOR E ');
    LQuery.SQL.Add('   JOIN FATGOR F ON E.FGO_SEQFGO = F.AUTOINCREM ');
    LQuery.SQL.Add('    SET E.FGO_DTASTA = :DTASTA, ');
    LQuery.SQL.Add('        E.FGO_HRASTA = :HRASTA ');
    LQuery.SQL.Add('  WHERE F.AUTOINCREM IN (' + AAutIncPedidos + ')');
    LQuery.ParamByName('DTASTA').AsDate := VS_Date;
    LQuery.ParamByName('HRASTA').AsDateTime := RemoveMilliseconds(fTime());
    LOpenedTransaction := fInTransaction();
    If Not LOpenedTransaction Then
      fStartTransaction();
    LQuery.ExecSQL;
    If Not LOpenedTransaction Then
      fCommit();
  Finally
    RestoreLockWaitTimeout;
{$IFNDEF LINUX}
    FreeAndNil(LQuery);
{$ENDIF LINUX}
  End;
end;

procedure TUpdateStatus.pUpdateReprocessaStatusNaoModificados(const AAutIncPedidos : String);
  Var
    LQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    LOpenedTransaction : Boolean;
begin
  LQuery := fCriaQuery();
  Try
    SetLockWaitTimeout(5);
    LQuery.SQL.Clear;
    LQuery.SQL.Add(' UPDATE EXTDOR ');
    LQuery.SQL.Add('   JOIN FATDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM ');
    LQuery.SQL.Add('    SET FDO_REPSTA = "S" ');
    LQuery.SQL.Add('  WHERE FATDOR.FDO_SEQGER IN (' + AAutIncPedidos + ')');
    LOpenedTransaction := fInTransaction();
    If Not LOpenedTransaction Then
      fStartTransaction();
    LQuery.ExecSQL;
    If Not LOpenedTransaction Then
      fCommit();
  Finally
    RestoreLockWaitTimeout;
{$IFNDEF LINUX}
    FreeAndNil(LQuery);
{$ENDIF LINUX}
  End;
end;

procedure TUpdateStatus.RestoreLockWaitTimeout;
  Var
    LQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQuery := fCriaQuery;
  Try
    Try
      LQuery.SQL.Add('SET SESSION INNODB_LOCK_WAIT_TIMEOUT = @saved_lock_wait;');
      LQuery.ExecSQL;
    Except
    End;
  Finally
    {$IFNDEF LINUX}
    FreeAndNil(LQuery);
    {$ENDIF LINUX}
  End;
end;

procedure TUpdateStatus.SetLockWaitTimeout(const ASeconds: Integer);
  Var
    LQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  LQuery := fCriaQuery;
  Try
    Try
      LQuery.SQL.Add('SET @saved_lock_wait = @@SESSION.INNODB_LOCK_WAIT_TIMEOUT;');
      LQuery.SQL.Add('SET SESSION INNODB_LOCK_WAIT_TIMEOUT = ' + IntToStr(ASeconds) + ';');
      LQuery.ExecSQL;
    Except
    End;
  Finally
    {$IFNDEF LINUX}
    FreeAndNil(LQuery);
    {$ENDIF LINUX}
  End;
end;

{ TParamStatus }

function TParamStatus.CodCli(const AValue: String): IParamStatus;
begin
  FCodCli := AValue;
  Result := Self;
end;

function TParamStatus.CodCli: String;
begin
  Result := FCodCli;
end;

function TParamStatus.blnImpSfa(const AValue: Boolean): IParamStatus;
begin
  FblnImpSfa := AValue;
  Result := Self;
end;

function TParamStatus.blnAuditandoFaturados: Boolean;
begin
  Result := FAuditandoFaturados;
end;

function TParamStatus.blnAuditandoFaturados(
  const AValue: Boolean): IParamStatus;
begin
  FAuditandoFaturados := AValue;
  result := Self;
end;

function TParamStatus.AutoincremFatgor(const AValue: String) : IParamStatus;
begin
  Result := Self;
  FAutoincremFatgor := AValue;
end;

function TParamStatus.AutoincremFatgor: String;
begin
  Result := FAutoincremFatgor;
end;

function TParamStatus.blnImpSfa: Boolean;
begin
  Result := FblnImpSfa;
end;

function TParamStatus.CodEmp: String;
begin
  Result := FCodEmp;
end;

constructor TParamStatus.Create;
begin
  FCodEmp := '';
  FCodCli := '';
  FNumDoc := '';
  FEspDoc := '';
  FSeqFdo := '';
  FblnImpSfa := False;
  FAuditandoFaturados := False;
end;

function TParamStatus.CodEmp(const AValue: String): IParamStatus;
begin
  FCodEmp := AValue;
  Result := Self;
end;

function TParamStatus.EspDoc: String;
begin
  Result := FEspDoc;
end;

function TParamStatus.fGetDocument: String;
begin
  Result := Concat(FNumDoc, '-', FEspDoc, '-', FCodEmp);
end;

function TParamStatus.EspDoc(const AValue: String): IParamStatus;
begin
  FEspDoc := AValue;
  Result := Self;
end;

function TParamStatus.NumDoc(const AValue: String): IParamStatus;
begin
  FNumDoc := AValue;
  Result := Self;
end;

class function TParamStatus.New: IParamStatus;
begin
  Result := TParamStatus.Create();
end;

function TParamStatus.NumDoc: String;
begin
  Result := FNumDoc;
end;

function TParamStatus.SeqFdo: String;
begin
  Result := FSeqFdo;
end;

function TParamStatus.SeqFdo(const AValue: String): IParamStatus;
begin
  FSeqFdo := AValue;
  Result := Self;
end;

{ TStatus }

constructor TStatus.Create(AParams: IParamStatus);
begin
  FParams := AParams;
  FQuery := fCriaQuery();
  If VS_blnUTIPEN = Null Then
    VS_blnUTIPEN := fCampoExiste('EXTGOR', 'FGO_UTIPEN', True);
end;

destructor TStatus.Destroy;
begin
{$IFNDEF LINUX}
    FreeAndNil(FQuery);
{$ENDIF LINUX}
  inherited;
end;

function TStatus.fExisteDados(const AQuery: String): Boolean;
begin
  Try
    pExecutaQuery(AQuery);
    Result := FQuery.FieldByName('QTDE').AsInteger > 0;
  Finally
    FQuery.Close;
    FQuery.SQL.Clear;
  End;
end;

function TStatus.fGetStatus(): TEStatusPedidoVenda;
var
  LEnum: TEStatusPedidoVenda;
  LTipo: TGetSQLStatus.TipoStatus;
  LSQL: String;
  LCodCli: String;
  LChave: String;
begin
  Result := pvAgFaturamento;

  If fEmptyStr(FParams.SeqFdo) then
    LTipo := TGetSQLStatus.TipoStatus.statusPedido
  Else
    LTipo := TGetSQLStatus.TipoStatus.statusItemPedido;

  For LEnum := Low(TEStatusPedidoVenda) To High(TEStatusPedidoVenda) Do
  Begin
    If Not LEnum.fUtilizarStatus() Then
      Continue;

    LSQL := LEnum.fGetSQL(LTipo);

    If fEmptyStr(LSQL) Then
      Continue;

    If LEnum.fConsiderarJaFatu Then
      If FParams.blnAuditandoFaturados Then
        Continue;

    If Not VS_blnUTIPEN Then
      LSQL := LSQL.Replace('EG.FGO_UTIPEN', '"N"').Replace('FGO_UTIPEN', '"N"');

   {$IFNDEF LINUX}
    LSQL := '/* (Código ' + LEnum.fGetId.ToString + ') - Status: ' + LEnum.fGetDescricao + ' */' + LSQL;
   {$ENDIF LINUX}

    If fExisteDados(LSQL) Then
    Begin
      Result := LEnum;

      If Not FParams.blnAuditandoFaturados Then
      Begin
        If (fCfgSis('UTDTFE', varBoolean)) And (Result In [pvAgSeparacao, pvSeparando, pvSeparacaoAndamento, pvExtornoSeparacao, pvAgConferenciaExp, pvConferenciaAndamento, pvConferenciaIniciada, pvAgFaturamento]) Then
        Begin
          LCodCLi := fCampoTabela('FGO_CODCLI', 'FATGOR', ['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP'], [FParams.NumDoc(), FParams.EspDoc(), FParams.CodEmp()], False);

          If Not fEmptyStr(LCodCLi) Then
            If Not fPermiteFaturamentoEntrega(LCodCLi, 'CLI_DMFATU', 'CLI_DSFATU', VS_Date) Then
              Result := pvAgDiaSemanaFaturamento;
        End;

        If (VS_strTipExp = '4') And (fCfgSis('BAISEP', varBoolean)) And (Result = pvAgConferenciaExp) Then
        Begin
          LChave := Concat('FATGOR', FParams.NumDoc(), FParams.EspDoc(), FParams.CodEmp(), '_CONFERENCIA_DOCUMENTO');

          If fVerificaLCKATCNomeParcial(LChave) Then
            Result := pvConferenciaIniciada;
        End;
      End;

      If Not fExecutandoPeloPortal Then
        Break;
    End;
  End;
end;

class function TStatus.New(AParams: IParamStatus): IStatus;
begin
  Result := TStatus.Create(AParams);
end;

procedure TStatus.pExecutaQuery(const AQuery: String);
begin
  FQuery.SQL.Add(AQuery);
  FQuery.ParamByName('NUMDOC').AsString := FParams.NumDoc();
  FQuery.ParamByName('ESPDOC').AsString := FParams.EspDoc();
  FQuery.ParamByName('CODEMP').AsString := FParams.CodEmp();
  If FQuery.FindParam('SEQFDO') <> nil Then
    FQuery.ParamByName('SEQFDO').AsString := FParams.SeqFdo();
  FQuery.Open;
end;

{ TEAdiantamentoPedido }

function TEAdiantamentoPedidoHelper.fGetLegendaIdx: Integer;
begin
  Case Self Of
    apPendente:     Result := 0;
    apParcialmente: Result := 1;
    apRealizado:    Result := 2;
    apLiberado:     Result := 3;
  Else
    Result := -1;
  End;
end;

function TEAdiantamentoPedidoHelper.fGetLegendaTexto: String;
begin
  Case Self Of
    apPendente:     Result := 'Pendente';
    apParcialmente: Result := 'Parcialmente';
    apRealizado:    Result := 'Realizado';
    apLiberado:     Result := 'Liberado';
  Else
    Result := '';
  End;
end;

{ TGetSQLStatus }

constructor TGetSQLStatus.Create(ATipo: TipoStatus);
begin
  Self.FTipoStatus := ATipo;
end;

class function TGetSQLStatus.New(ATipo: TipoStatus): IGetSQLStatus;
begin
  Result := TGetSQLStatus.Create(ATipo);
end;

function TGetSQLStatus.sqlPedidoEmAberto: String;
begin
  Result := '';

  Result := Result +
    'SELECT SQL_NO_CACHE COUNT(0) AS QTDE             '+
    '  FROM FATGOR                                    '+
    '  JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM  '+
    '  JOIN FATDOR ON FDO_SEQGER = FATGOR.AUTOINCREM  '+
    ' WHERE FGO_NUMDOC = :NUMDOC                      '+
    '   AND FGO_ESPDOC = :ESPDOC                      '+
    '   AND FGO_CODEMP = :CODEMP                      '+
    '   AND FGO_EMP_TE IS NULL                        '+
    '   AND FGO_ENT_CD = "N"                          '+
    '   AND IFNULL(FDO_EMPITE, FDO_CODEMP) <> FDO_CODEMP';

  If Self.FTipoStatus = statusItemPedido Then
  Begin
    Result := Result + '  AND FATDOR.AUTOINCREM = :SEQFDO ';
    Result := Result + '  AND FATDOR.FDO_JAFATU = 0 ';
  End
  Else
    Result := Result + '  AND FGO_JAFATU = 0 ';
end;

function TGetSQLStatus.sqlPedidoVendaBaixado: String;
begin
  Result := '';

  Result := Result +
    ' SELECT SQL_NO_CACHE COUNT(1) AS QTDE           '+
    '  FROM FATGOR                                   '+
    '  JOIN EXTGOR ON FATGOR.AUTOINCREM = FGO_SEQFGO ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '  JOIN FATDOR ON FDO_SEQGER = FATGOR.AUTOINCREM ';

  Result := Result +
    ' WHERE FGO_NUMDOC = :NUMDOC                     '+
    '   AND FGO_ESPDOC = :ESPDOC                     '+
    '   AND FGO_CODEMP = :CODEMP                     '+
    '   AND IFNULL(FGO_MOTBAI, "") <> ""             '+
    '   AND FGO_UTIPEN = "N"                         ';

  If Self.FTipoStatus = statusItemPedido Then
  Begin
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';
    Result := Result + '   AND FATDOR.FDO_JAFATU = 1 ';
  End
  Else
    Result := Result + '   AND FGO_JAFATU = 1 ';
end;

function TGetSQLStatus.sqlPedidoVendaClienteRetira(ATipFat: TTipoFaturamento): String;
begin
  Result :=
    'SELECT SQL_NO_CACHE COUNT(1) AS QTDE            '+
    '  FROM FATGOR FG                                '+
    '  JOIN EXTGOR EG ON FG.AUTOINCREM = EG.FGO_SEQFGO'+
    '  JOIN FATDOR FDO ON FDO.FDO_NUMDOC = FG.FGO_NUMDOC'+
    '                 AND FDO.FDO_ESPDOC = FG.FGO_ESPDOC'+
    '                 AND FDO.FDO_CODEMP = FG.FGO_CODEMP'+
    '                 AND FDO.FDO_CODCLI = FG.FGO_CODCLI'+
    '  JOIN EXTDOR ED ON FDO.AUTOINCREM = ED.FDO_SEQFDO'+
    ' WHERE FG.FGO_NUMDOC = :NUMDOC                  '+
    '   AND FG.FGO_ESPDOC = :ESPDOC                  '+
    '   AND FG.FGO_CODEMP = :CODEMP                  '+
    '   AND ED.FDO_CLIBUS = "S"                      '+
    '   AND IFNULL(ED.FDO_INCFUT, "") <> ""          ';

  If Self.FTipoStatus = statusItemPedido Then
  Begin
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';
    Case ATipFat Of
      tfTotal  : Result := Result + sqlItemPedidoJaFaturado;
      tfParcial: Result := Result + sqlItemPedidoFaturadoParcialmente;
    End;
  End
  Else
  Begin
    Case ATipFat Of
      tfTotal  : Result := Result + sqlPedidoJaFaturado;
      tfParcial: Result := Result + sqlPedidoFaturadoParcialmente;
    End;
  End;
end;

function TGetSQLStatus.sqlPedidoVendaJaFaturado(ATipFat: TTipoFaturamento): String;
begin
  Result := '';

  Result := Result +
    'SELECT SQL_NO_CACHE COUNT(1) AS QTDE            '+
    '  FROM FATGOR FG                                '+
    '  JOIN EXTGOR EG ON FG.AUTOINCREM = FGO_SEQFGO  ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '  JOIN FATDOR FDO ON FDO.FDO_SEQGER = FG.AUTOINCREM ';

  Result := Result +
    ' WHERE FGO_NUMDOC = :NUMDOC                     '+
    '   AND FGO_ESPDOC = :ESPDOC                     '+
    '   AND FGO_CODEMP = :CODEMP                     '+
    '   AND (((IFNULL(FGO_MOTBAI, "") = "") AND (FGO_UTIPEN = "N")) OR ((IFNULL(FGO_MOTBAI, "") <> "") AND (FGO_UTIPEN = "S"))) ';

  If Self.FTipoStatus = statusItemPedido Then
  Begin
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';
    Case ATipFat Of
      tfTotal  : Result := Result + sqlItemPedidoJaFaturado;
      tfParcial: Result := Result + sqlItemPedidoFaturadoParcialmente;
    End;
  End
  Else
  Begin
    Case ATipFat Of
      tfTotal  : Result := Result + sqlPedidoJaFaturado;
      tfParcial: Result := Result + sqlPedidoFaturadoParcialmente;
    End;
  End;
end;

function TGetSQLStatus.sqlPendenteLibComercial: String;
begin
  Result := '';

  Result := Result +
    'SELECT SQL_NO_CACHE COUNT(1) AS QTDE            '+
    '  FROM FATGOR                                   ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '  JOIN FATDOR ON FDO_SEQGER = FATGOR.AUTOINCREM ';

  Result := Result +
    ' WHERE FGO_NUMDOC = :NUMDOC                     '+
    '   AND FGO_ESPDOC = :ESPDOC                     '+
    '   AND FGO_CODEMP = :CODEMP                     '+
    '   AND FGO_LIBCOM = 0                           '+
    '   AND FGO_LIBERA <> 0                          ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';
end;

function TGetSQLStatus.sqlPendenteLibComFin: String;
begin
  Result := '';

  Result := Result +
    'SELECT SQL_NO_CACHE COUNT(1) AS QTDE            '+
    '  FROM FATGOR                                   ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '  JOIN FATDOR ON FDO_SEQGER = FATGOR.AUTOINCREM ';

  Result := Result +
    ' WHERE FGO_NUMDOC = :NUMDOC                     '+
    '   AND FGO_ESPDOC = :ESPDOC                     '+
    '   AND FGO_CODEMP = :CODEMP                     '+
    '   AND FGO_LIBCOM = 0                           '+
    '   AND FGO_LIBERA = 0                           ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';
end;

function TGetSQLStatus.sqlPendenteLibFinanceira: String;
begin
  Result := '';

  Result := Result +
    'SELECT SQL_NO_CACHE COUNT(1) AS QTDE            '+
    '  FROM FATGOR                                   ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '  JOIN FATDOR ON FDO_SEQGER = FATGOR.AUTOINCREM ';

  Result := Result +
    ' WHERE FGO_NUMDOC = :NUMDOC                     '+
    '   AND FGO_ESPDOC = :ESPDOC                     '+
    '   AND FGO_CODEMP = :CODEMP                     '+
    '   AND FGO_LIBCOM <> 0                          '+
    '   AND FGO_LIBERA = 0                           ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';
end;

function TGetSQLStatus.sqlRequisicaoPendente: String;
begin
  Result := '';

  Result := Result +
    ' SELECT SQL_NO_CACHE COUNT(1) AS QTDE           '+
    '  FROM PREPRQ                                   ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '  JOIN FATDOR ON FDO_NUMDOC = PRQ_NUMDOC      '+
      '             AND FDO_ESPDOC = PRQ_ESPDOC      '+
      '             AND FDO_CODEMP = PRQ_EMPDOC      '+
      '             AND FDO_CODITE = PRQ_CODITE      ';

  Result := Result +
    ' WHERE PRQ_NUMDOC = :NUMDOC                     '+
    '   AND PRQ_ESPDOC = :ESPDOC                     '+
    '   AND PRQ_EMPDOC = :CODEMP                     '+
    '   AND PRQ_CODREQ IS NULL                       ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';
end;

function TGetSQLStatus.sqlRequisicaoCompraNegada: String;
begin
  Result := '';

  Result := Result +
    ' SELECT SQL_NO_CACHE COUNT(1) AS QTDE           '+
    '  FROM MOVRCD                                   ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '  JOIN FATDOR ON FDO_NUMDOC = RCD_DOCPDV      '+
      '             AND FDO_ESPDOC = RCD_ESPPDV      '+
      '             AND FDO_CODEMP = RCD_EMPPDV      '+
      '             AND FDO_CODITE = RCD_CODITE      ';

  Result := Result +
    ' WHERE RCD_DOCPDV = :NUMDOC                     '+
    '   AND RCD_ESPPDV = :ESPDOC                     '+
    '   AND RCD_EMPPDV = :CODEMP                     '+
    '   AND RCD_REQNEG = "S"                         ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';
end;

function TGetSQLStatus.sqlCompraPendente: String;
begin
  Result := '';

  Result := Result +
    ' SELECT SQL_NO_CACHE COUNT(1) AS QTDE           '+
    '  FROM MOVRCD                                   ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '  JOIN FATDOR ON FDO_NUMDOC = RCD_DOCPDV      '+
      '             AND FDO_ESPDOC = RCD_ESPPDV      '+
      '             AND FDO_CODEMP = RCD_EMPPDV      '+
      '             AND FDO_CODITE = RCD_CODITE      ';

  Result := Result +
    ' WHERE RCD_DOCPDV = :NUMDOC                     '+
    '   AND RCD_ESPPDV = :ESPDOC                     '+
    '   AND RCD_EMPPDV = :CODEMP                     '+
    '   AND RCD_ATETRA = 0                           '+
    '   AND RCD_REQNEG <> "S"                        '+
    '   AND RCD_SEQPCD IS NULL                       ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';
end;

function TGetSQLStatus.sqlPedidoTransfPendente: String;
begin
  Result := '';

  Result := Result +
    ' SELECT SQL_NO_CACHE '+
    '   SUM(TMP.QTDE) AS QTDE '+
    ' FROM '+
    '   ( ' ;

  Result := Result +
    '   SELECT              '+
    '     COUNT(1) AS QTDE  '+
    '   FROM                '+
    '     PREPTE            ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '     JOIN FATDOR ON FDO_NUMDOC = PRE_DOCABS '+
      '                AND FDO_ESPDOC = PRE_ESPABS '+
      '                AND FDO_CODEMP = PRE_EMPABS '+
      '                AND FDO_CODITE = PRE_CODITE ';

  Result := Result +
    '   WHERE PRE_DOCABS = :NUMDOC '+
    '     AND PRE_ESPABS = :ESPDOC '+
    '     AND PRE_EMPABS = :CODEMP '+
    '     AND PRE_NUMDOC IS NULL   ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '   UNION ALL           '+
    '   SELECT              '+
    '     COUNT(1) AS QTDE  '+
    '   FROM                '+
    '     REQVEN            '+
    '     INNER JOIN PREPTE '+
    '       ON PREPTE.AUTOINCREM = SEQ_PREPTE '+
    '     INNER JOIN MOVRCD                   '+
    '       ON MOVRCD.AUTOINCREM = SEQ_MOVRCD ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '     JOIN FATDOR ON FDO_NUMDOC = RCD_DOCPDV '+
      '                AND FDO_ESPDOC = RCD_ESPPDV '+
      '                AND FDO_CODEMP = RCD_EMPPDV '+
      '                AND FDO_CODITE = RCD_CODITE ';

  Result := Result +
    '   WHERE RCD_DOCPDV = :NUMDOC            '+
    '     AND RCD_ESPPDV = :ESPDOC            '+
    '     AND RCD_EMPPDV = :CODEMP            '+
    '     AND PRE_NUMDOC IS NULL              ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';

  Result := Result + ' ) AS TMP ';
end;

function TGetSQLStatus.sqlTransferenciaPendente: String;
begin
  Result := '';

  Result := Result +
    ' SELECT SQL_NO_CACHE    '+
    '  SUM(TMP.QTDE) AS QTDE                         '+
    'FROM                   '+
    '  (SELECT              '+
    '    COUNT(1) AS QTDE                            '+
    '  FROM                 '+
    '    PREPTE PE          '+
    '  JOIN FATGOR FG ON FG.FGO_NUMDOC = PE.PRE_NUMDOC'+
    '                AND FG.FGO_ESPDOC = PE.PRE_ESPDOC'+
    '                AND FG.FGO_CODEMP = PE.PRE_EMPDOC'+
    '  JOIN FATDOR FD ON FD.FDO_NUMDOC = FG.FGO_NUMDOC'+
    '                AND FD.FDO_ESPDOC = FG.FGO_ESPDOC'+
    '                AND FD.FDO_CODEMP = FG.FGO_CODEMP'+
    '                AND FD.FDO_CODITE = PE.PRE_CODITE';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '     JOIN FATDOR FDO ON FDO.FDO_NUMDOC = PE.PRE_DOCABS '+
      '                    AND FDO.FDO_ESPDOC = PE.PRE_ESPABS '+
      '                    AND FDO.FDO_CODEMP = PE.PRE_EMPABS '+
      '                    AND FDO.FDO_CODITE = PE.PRE_CODITE ';

  Result := Result +
    '  WHERE PE.PRE_DOCABS = :NUMDOC                 '+
    '    AND PE.PRE_ESPABS = :ESPDOC                 '+
    '    AND PE.PRE_EMPABS = :CODEMP                 '+
    '    AND ((FD.FDO_JAFATU = 0) OR                 '+
    '    ((FG.FGO_JAFATU = 1) AND IFNULL(FG.FGO_MOTBAI, "") <> ""))';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '  UNION ALL            '+
    '  SELECT               '+
    '    COUNT(1) AS QTDE                            '+
    '  FROM                 '+
    '    REQVEN             '+
    '    INNER JOIN PREPTE ON PREPTE.AUTOINCREM = SEQ_PREPTE'+
    '    INNER JOIN MOVRCD ON MOVRCD.AUTOINCREM = SEQ_MOVRCD'+
    '    INNER JOIN FATGOR ON FGO_NUMDOC = PRE_NUMDOC'+
    '                     AND FGO_ESPDOC = PRE_ESPDOC'+
    '                     AND FGO_CODEMP = PRE_EMPDOC'+
    '    INNER JOIN FATDOR FD ON FD.FDO_NUMDOC = FGO_NUMDOC'+
    '                     AND FD.FDO_ESPDOC = FGO_ESPDOC'+
    '                     AND FD.FDO_CODEMP = FGO_CODEMP'+
    '                     AND FD.FDO_CODITE = RCD_CODITE';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '     JOIN FATDOR FDO ON FDO.FDO_NUMDOC = RCD_DOCPDV '+
      '                    AND FDO.FDO_ESPDOC = RCD_ESPPDV '+
      '                    AND FDO.FDO_CODEMP = RCD_EMPPDV '+
      '                    AND FDO.FDO_CODITE = RCD_CODITE ';

  Result := Result +
    '  WHERE RCD_DOCPDV = :NUMDOC                    '+
    '    AND RCD_ESPPDV = :ESPDOC                    '+
    '    AND RCD_EMPPDV = :CODEMP                    '+
    '    AND ((FD.FDO_JAFATU = 0) OR                    '+
    '    ((FD.FDO_JAFATU = 1) AND IFNULL(FGO_MOTBAI, "") <> ""))';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';

  Result := Result + '  ) TMP ';
end;

function TGetSQLStatus.sqlEntregaPendenteCompraQuandoConferenciaAntesDaEntrada: String;
begin
  Result :=
    '  SELECT               '+
    '    COUNT(0) AS QTDE   '+
    '  FROM                 '+
    '    MOVRCD RD          '+
    '    JOIN PCMDET PC     '+
    '      ON RD.RCD_SEQPCD = PC.AUTOINCREM     ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR ON FDO_NUMDOC = RCD_DOCPDV '+
      '               AND FDO_ESPDOC = RCD_ESPPDV '+
      '               AND FDO_CODEMP = RCD_EMPPDV '+
      '               AND FDO_CODITE = RCD_CODITE ';

  Result := Result +
    '  WHERE TRUE           '+
    '    AND RCD_DOCPDV = :NUMDOC                    '+
    '    AND RCD_ESPPDV = :ESPDOC                    '+
    '    AND RCD_EMPPDV = :CODEMP                    '+
    '    AND ' + sqlNaoExisteConferenciaAntesDaEntrada;

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';
end;

function TGetSQLStatus.sqlEntregaPendenteCompraQuandoNaoUsaConferencia: String;
begin
  Result := '';

  Result := Result +
    ' SELECT SQL_NO_CACHE COUNT(1) AS QTDE            '+
    '  FROM MOVRCD RD       '+
    '  JOIN PCMDET PC ON RD.RCD_SEQPCD = PC.AUTOINCREM';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '  JOIN FATDOR ON FDO_NUMDOC = RCD_DOCPDV '+
      '             AND FDO_ESPDOC = RCD_ESPPDV '+
      '             AND FDO_CODEMP = RCD_EMPPDV '+
      '             AND FDO_CODITE = RCD_CODITE ';

  Result := Result +
    ' WHERE RCD_DOCPDV = :NUMDOC                     '+
    '   AND RCD_ESPPDV = :ESPDOC                     '+
    '   AND RCD_EMPPDV = :CODEMP                     '+
    '   AND PCD_BAIXAD = 0                           ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';
end;

function TGetSQLStatus.sqlEntregaPendenteTransf: String;
begin
  Result := '';

  Result := Result +
    'SELECT SQL_NO_CACHE SUM(TMP.QTDE) AS QTDE       '+
    '  FROM                                          '+
    '  (                                             '+
    '  SELECT COUNT(1) AS QTDE                       '+
    '    FROM EXTGOR ET                              '+
    '    JOIN FATGOR FG ON ET.FGO_SEQFGO = FG.AUTOINCREM'+
    '    JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(   '+
    '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),  '+
    '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),   '+
    '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '  JOIN FATDOR ON FDO_NUMDOC = ET.FGO_NMPDAB '+
      '             AND FDO_ESPDOC = ET.FGO_ESPDAB '+
      '             AND FDO_CODEMP = ET.FGO_EMPDAB '+
      '             AND FDO_CODITE = PD.PCD_CODITE ';

  Result := Result +
    '   WHERE ET.FGO_NMPDAB = :NUMDOC                '+
    '     AND ET.FGO_ESPDAB = :ESPDOC                '+
    '     AND ET.FGO_EMPDAB = :CODEMP                '+
    '     AND PD.PCD_BAIXAD = 0                      ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '  UNION ALL                                     '+
    '  SELECT                                        '+
    '    COUNT(1) AS QTDE                            '+
    '  FROM                                          '+
    '   PREPTE                                       '+
    '   INNER JOIN FATGOR FG                         '+
    '      ON FGO_NUMDOC = PRE_NUMDOC                '+
    '      AND FGO_ESPDOC = PRE_ESPDOC               '+
    '      AND FGO_CODEMP = PRE_EMPDOC               '+
    '   JOIN PCMDET PD                               '+
    '      ON PD.PCD_DOCORI = CONCAT(                '+
    '        LPAD(IFNULL(FG.FGO_NUMFAT, ""), 12, "0"),'+
    '        LPAD(IFNULL(FG.FGO_TIPFAT, ""), 2, " "),'+
    '        LPAD(                                   '+
    '          TRIM(IFNULL(FG.FGO_EMPFAT, "")),      '+
    '          3,                                    '+
    '          "0"                                   '+
    '        )                                       '+
    '      )                                         ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '  JOIN FATDOR ON FDO_NUMDOC = PRE_DOCABS '+
      '             AND FDO_ESPDOC = PRE_ESPABS '+
      '             AND FDO_CODEMP = PRE_EMPABS '+
      '             AND FDO_CODITE = PRE_CODITE ';

  Result := Result +
    '  WHERE PRE_DOCABS = :NUMDOC                    '+
    '    AND PRE_ESPABS = :ESPDOC                    '+
    '    AND PRE_EMPABS = :CODEMP                    '+
    '    AND PD.PCD_BAIXAD = 0                       ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '  UNION ALL                                     '+
    '  SELECT                                        '+
    '    COUNT(1) AS QTDE                            '+
    '  FROM                                          '+
    '    REQVEN                                      '+
    '    INNER JOIN PREPTE                           '+
    '      ON PREPTE.AUTOINCREM = SEQ_PREPTE         '+
    '    INNER JOIN MOVRCD                           '+
    '      ON MOVRCD.AUTOINCREM = SEQ_MOVRCD         '+
    '    INNER JOIN FATGOR FG                        '+
    '      ON FGO_NUMDOC = PRE_NUMDOC                '+
    '      AND FGO_ESPDOC = PRE_ESPDOC               '+
    '      AND FGO_CODEMP = PRE_EMPDOC               '+
    '    JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(   '+
    '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),  '+
    '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),   '+
    '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '  JOIN FATDOR ON FDO_NUMDOC = RCD_DOCPDV '+
      '             AND FDO_ESPDOC = RCD_ESPPDV '+
      '             AND FDO_CODEMP = RCD_EMPPDV '+
      '             AND FDO_CODITE = RCD_CODITE ';

  Result := Result +
    '  WHERE RCD_DOCPDV = :NUMDOC                    '+
    '    AND RCD_ESPPDV = :ESPDOC                    '+
    '    AND RCD_EMPPDV = :CODEMP                    '+
    '    AND PD.PCD_BAIXAD = 0                       ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '  ) TMP                                         ';

end;

function TGetSQLStatus.sqlEntregaPendenteQuandoConferenciaDepoisDaEntrada: String;
begin
  Result := '';

  Result := Result +
    ' SELECT SQL_NO_CACHE SUM(TMP.QTDE) AS QTDE       '+
    '  FROM                 '+
    '  (                    '+
    '  SELECT COUNT(1) AS QTDE                       '+
    '    FROM MOVRCD RD     '+
    '    JOIN PCMDET PC ON RD.RCD_SEQPCD = PC.AUTOINCREM';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR ON FDO_NUMDOC = RCD_DOCPDV '+
      '               AND FDO_ESPDOC = RCD_ESPPDV '+
      '               AND FDO_CODEMP = RCD_EMPPDV '+
      '               AND FDO_CODITE = RCD_CODITE ';

  Result := Result +
    '  LEFT                 '+
    '    JOIN BAIPED BP ON BP.BAI_AUTPED = PC.AUTOINCREM   '+
    ' LEFT JOIN DEFBAI DB ON DB.DEF_AUTPCD =  PC.AUTOINCREM     '+
    '  LEFT                 '+
    '    JOIN MOVDET DT ON DT.AUTOINCREM = BP.BAI_AUTDET'+
    '  LEFT                 '+
    '    JOIN AGEDOC AD ON AD.ADC_NUMDOC = DT.DET_NUMDOC'+
    '                  AND AD.ADC_ESPDOC = DT.DET_ESPDOC'+
    '                  AND AD.ADC_CODEMP = DT.DET_CODEMP'+
    '                  AND AD.ADC_CODFOR = DT.DET_CODFOR'+
    '  LEFT                 '+
    '    JOIN AGEREC AR ON AD.ADC_SEQGER = AR.AUTOINCREM'+
    '   WHERE RCD_DOCPDV = :NUMDOC                   '+
    '     AND RCD_ESPPDV = :ESPDOC                   '+
    '     AND RCD_EMPPDV = :CODEMP                   '+
    '     AND DB.DEF_AUTPCD IS NULL                  '+
    '     AND IFNULL(BP.BAI_QTDPED, 0) < RD.RCD_QTDITE ';
  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '  UNION ALL            '+
    '  SELECT COUNT(1) AS QTDE                       '+
    '    FROM MOVRCD RD     '+
    '    JOIN PCMDET PC ON RD.RCD_SEQPCD = PC.AUTOINCREM';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR ON FDO_NUMDOC = RCD_DOCPDV '+
      '               AND FDO_ESPDOC = RCD_ESPPDV '+
      '               AND FDO_CODEMP = RCD_EMPPDV '+
      '               AND FDO_CODITE = RCD_CODITE ';

  Result := Result +
    '  LEFT                 '+
    '    JOIN BAIPED BP ON BP.BAI_AUTPED = PC.AUTOINCREM   '+
    '  LEFT                 '+
    '    JOIN MOVDET DT ON DT.AUTOINCREM = BP.BAI_AUTDET'+
    '  LEFT                 '+
    '    JOIN AGEDOC AD ON AD.ADC_NUMDOC = DT.DET_NUMDOC'+
    '                  AND AD.ADC_ESPDOC = DT.DET_ESPDOC'+
    '                  AND AD.ADC_CODEMP = DT.DET_CODEMP'+
    '                  AND AD.ADC_CODFOR = DT.DET_CODFOR'+
    '  LEFT                 '+
    '    JOIN AGEREC AR ON AD.ADC_SEQGER = AR.AUTOINCREM'+
    '   WHERE RCD_DOCPDV = :NUMDOC                   '+
    '     AND RCD_ESPPDV = :ESPDOC                   '+
    '     AND RCD_EMPPDV = :CODEMP                   ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '  HAVING SUM(ROUND(BP.BAI_QTDPED, 4)) < MAX(ROUND(RD.RCD_QTDITE, 4))';

  Result := Result + '  ) TMP ';
end;

function TGetSQLStatus.sqlEntregaPendenteCDTran: String;
begin
  Result := '';

  Result := Result +
    ' SELECT SQL_NO_CACHE SUM(TMP.QTDE) AS QTDE       '+
    '  FROM                 '+
    '  (                    '+
    '  SELECT COUNT(1) AS QTDE                       '+
    '    FROM EXTGOR ET     '+
    '    JOIN FATGOR FG ON ET.FGO_SEQFGO = FG.AUTOINCREM'+
    '    JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(   '+
    '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),  '+
    '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),   '+
    '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR ON FDO_NUMDOC = ET.FGO_NMPDAB '+
      '               AND FDO_ESPDOC = ET.FGO_ESPDAB '+
      '               AND FDO_CODEMP = ET.FGO_EMPDAB '+
      '               AND FDO_CODITE = PD.PCD_CODITE ';

  Result := Result +
    '   WHERE ET.FGO_NMPDAB = :NUMDOC                '+
    '     AND ET.FGO_ESPDAB = :ESPDOC                '+
    '     AND ET.FGO_EMPDAB = :CODEMP                '+
    '     AND PD.PCD_BAIXAD = 0                      ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '  UNION ALL                                     '+
    '  SELECT                                        '+
    '    COUNT(1) AS QTDE                            '+
    '  FROM                                          '+
    '   PREPTE                                       '+
    '   INNER JOIN FATGOR FG                         '+
    '      ON FGO_NUMDOC = PRE_NUMDOC                '+
    '      AND FGO_ESPDOC = PRE_ESPDOC               '+
    '      AND FGO_CODEMP = PRE_EMPDOC               '+
    '   JOIN PCMDET PD                               '+
    '      ON PD.PCD_DOCORI = CONCAT(                '+
    '        LPAD(IFNULL(FG.FGO_NUMFAT, ""), 12, "0"),'+
    '        LPAD(IFNULL(FG.FGO_TIPFAT, ""), 2, " "),'+
    '        LPAD(                                   '+
    '          TRIM(IFNULL(FG.FGO_EMPFAT, "")),      '+
    '          3,                                    '+
    '          "0"                                   '+
    '        )                                       '+
    '      )                                         ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR ON FDO_NUMDOC = PRE_DOCABS '+
      '               AND FDO_ESPDOC = PRE_ESPABS '+
      '               AND FDO_CODEMP = PRE_EMPABS '+
      '               AND FDO_CODITE = PRE_CODITE ';

  Result := Result +
    '  WHERE PRE_DOCABS = :NUMDOC                    '+
    '    AND PRE_ESPABS = :ESPDOC                    '+
    '    AND PRE_EMPABS = :CODEMP                    '+
    '    AND PD.PCD_BAIXAD = 0                       ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '  UNION ALL            '+
    '  SELECT               '+
    '    COUNT(1) AS QTDE                            '+
    '  FROM                 '+
    '    REQVEN             '+
    '    INNER JOIN PREPTE                           '+
    '      ON PREPTE.AUTOINCREM = SEQ_PREPTE         '+
    '    INNER JOIN MOVRCD                           '+
    '      ON MOVRCD.AUTOINCREM = SEQ_MOVRCD         '+
    '    INNER JOIN FATGOR FG                        '+
    '      ON FGO_NUMDOC = PRE_NUMDOC                '+
    '      AND FGO_ESPDOC = PRE_ESPDOC               '+
    '      AND FGO_CODEMP = PRE_EMPDOC               '+
    '    JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(   '+
    '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),  '+
    '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),   '+
    '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR ON FDO_NUMDOC = RCD_DOCPDV '+
      '               AND FDO_ESPDOC = RCD_ESPPDV '+
      '               AND FDO_CODEMP = RCD_EMPPDV '+
      '               AND FDO_CODITE = RCD_CODITE ';

  Result := Result +
    '  WHERE RCD_DOCPDV = :NUMDOC                    '+
    '    AND RCD_ESPPDV = :ESPDOC                    '+
    '    AND RCD_EMPPDV = :CODEMP                    '+
    '    AND PD.PCD_BAIXAD = 0                       ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';

  Result := Result + '  ) TMP ';
end;

function TGetSQLStatus.sqlConferenciaAndamento: String;
begin
  Result := '';

  Result := Result +
    'SELECT SQL_NO_CACHE COUNT(1) AS QTDE            '+
    '  FROM                                          '+
    '  (                                             '+
    '  SELECT IF(SUM(FDO_QTDEXP) > 0 AND ((SUM(FDO_QTDITE) - SUM(FDO_QTDBAI)) > SUM(FDO_QTDEXP)), "S", "N") AS TEMEXP, ' +
    '         IF((SUM(FD.FDO_QTDITE) - SUM(FD.FDO_QTDBAI)) = SUM(ED.FDO_QTDEXP), "S", "N") AS EXPTOT ' +
    '    FROM FATGOR FG                              '+
    '    JOIN EXTGOR EG ON FG.AUTOINCREM = EG.FGO_SEQFGO'+
    '    JOIN FATDOR FD ON FD.FDO_NUMDOC = FG.FGO_NUMDOC'+
    '                  AND FD.FDO_ESPDOC = FG.FGO_ESPDOC'+
    '                  AND FD.FDO_CODEMP = FG.FGO_CODEMP'+
    '                  AND FD.FDO_CODCLI = FG.FGO_CODCLI'+
    '                  AND FD.FDO_JAFATU = 0         '+
    '    JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO'+
    '   WHERE FG.FGO_NUMDOC = :NUMDOC                '+
    '     AND FG.FGO_ESPDOC = :ESPDOC                '+
    '     AND FG.FGO_CODEMP = :CODEMP                '+
    '     AND ED.FDO_EXIBSE = "S"                    '+
    '     AND EG.FGO_OPBXSE IS NOT NULL              '+
    '     AND EG.FGO_DTLBEX IS NULL                  '+
    '     AND EG.FGO_HRLBEX IS NULL                  ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FD.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '   GROUP BY FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP  '+
    '   ) TMP                                        '+
    '    WHERE TMP.TEMEXP = "S" AND TMP.EXPTOT = "N" ';
end;

function TGetSQLStatus.sqlConferenciaEntradaPendente(AConferenciaDepoisDaEntrada: Boolean): String;
begin
  Result := '';

  Result := Result +
    ' SELECT SQL_NO_CACHE SUM(QTDE) AS QTDE FROM (    '+
    ' SELECT COUNT(0) AS QTDE                         '+
    '  FROM MOVRCD RD       '+
    '  JOIN PCMDET PC ON RD.RCD_SEQPCD = PC.AUTOINCREM'+
    '  JOIN PEDELE PE ON PE.PEL_NUMDOC = PC.PCD_NUMPED'+
    '                AND PE.PEL_ESPDOC = PC.PCD_ESPDOC'+
    '                AND PE.PEL_CODEMP = PC.PCD_CODEMP'+
    '  JOIN GERELE GE ON GE.AUTOINCREM = PE.PEL_SEQELE'+
    '  JOIN DETELE DE ON DE.DET_SEQGER = GE.AUTOINCREM'+
    '                AND DE.DET_CODITE = PC.PCD_CODITE';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR ON FDO_NUMDOC = RCD_DOCPDV '+
      '               AND FDO_ESPDOC = RCD_ESPPDV '+
      '               AND FDO_CODEMP = RCD_EMPPDV '+
      '               AND FDO_CODITE = RCD_CODITE ';

  Result := Result +
    ' WHERE RCD_DOCPDV = :NUMDOC                     ' +
    '   AND RCD_ESPPDV = :ESPDOC                     ' +
    '   AND RCD_EMPPDV = :CODEMP                     ' +
    '   AND GE.GER_DTACON IS NULL                    ';
  If AConferenciaDepoisDaEntrada Then
    Result := Result + ' AND IFNULL(GE.GER_DOCENT, "") <> "" ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';

  Result := Result +
    'UNION ALL              '+
    ' SELECT COUNT(0) AS QTDE                         '+
    '  FROM EXTGOR ET       '+
    '  JOIN FATGOR FG ON ET.FGO_SEQFGO = FG.AUTOINCREM'+
    '  JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(     '+
    '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),  '+
    '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),   '+
    '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))'+
    '  JOIN PEDELE PE ON PE.PEL_NUMDOC = PD.PCD_NUMPED'+
    '                AND PE.PEL_ESPDOC = PD.PCD_ESPDOC'+
    '                AND PE.PEL_CODEMP = PD.PCD_CODEMP'+
    '  JOIN GERELE GE ON GE.AUTOINCREM = PE.PEL_SEQELE'+
    '  JOIN DETELE DE ON DE.DET_SEQGER = GE.AUTOINCREM'+
    '                AND DE.DET_CODITE = PD.PCD_CODITE';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR ON FDO_NUMDOC = ET.FGO_NMPDAB '+
      '               AND FDO_ESPDOC = ET.FGO_ESPDAB '+
      '               AND FDO_CODEMP = ET.FGO_EMPDAB '+
      '               AND FDO_CODITE = PD.PCD_CODITE ';

  Result := Result +
    ' WHERE ET.FGO_NMPDAB = :NUMDOC                  '+
    '   AND ET.FGO_ESPDAB = :ESPDOC                  '+
    '   AND ET.FGO_EMPDAB = :CODEMP                  '+
    '   AND GE.GER_DTACON IS NULL                    ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';

  Result := Result +
    'UNION ALL              '+
    ' SELECT COUNT(0) AS QTDE                        '+
    '  FROM REQVEN          '+
    '  JOIN PREPTE ON PREPTE.AUTOINCREM = SEQ_PREPTE '+
    '  JOIN MOVRCD RD ON RD.AUTOINCREM = SEQ_MOVRCD  '+
    '  JOIN FATGOR FG ON FGO_NUMDOC = PRE_NUMDOC     '+
    '                AND FGO_ESPDOC = PRE_ESPDOC     '+
    '                AND FGO_CODEMP = PRE_EMPDOC     '+
    '  JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(     '+
    '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),  '+
    '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),   '+
    '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))'+
    '  JOIN PEDELE PE ON PE.PEL_NUMDOC = PD.PCD_NUMPED'+
    '                AND PE.PEL_ESPDOC = PD.PCD_ESPDOC'+
    '                AND PE.PEL_CODEMP = PD.PCD_CODEMP'+
    '  JOIN GERELE GE ON GE.AUTOINCREM = PE.PEL_SEQELE'+
    '  JOIN DETELE DE ON DE.DET_SEQGER = GE.AUTOINCREM'+
    '                AND DE.DET_CODITE = PD.PCD_CODITE';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR ON FDO_NUMDOC = RD.RCD_DOCPDV '+
      '               AND FDO_ESPDOC = RD.RCD_ESPPDV '+
      '               AND FDO_CODEMP = RD.RCD_EMPPDV '+
      '               AND FDO_CODITE = RD.RCD_CODITE ';

  Result := Result +
    ' WHERE RD.RCD_DOCPDV = :NUMDOC                  '+
    '   AND RD.RCD_ESPPDV = :ESPDOC                  '+
    '   AND RD.RCD_EMPPDV = :CODEMP                  '+
    '   AND GE.GER_DTACON IS NULL                    ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';

  Result := Result + ') TMP ';
end;

function TGetSQLStatus.sqlEntradaMercadoriaPend(AConferenciaDepoisDaEntrada: Boolean): String;
begin
  Result := '';

  Result := Result +
    ' SELECT SQL_NO_CACHE SUM(QTDE) AS QTDE           '+
    '  FROM                 '+
    '   (SELECT COUNT(0) AS QTDE                     '+
    '      FROM MOVRCD RD                            '+
    '      JOIN PCMDET PD ON RD.RCD_SEQPCD = PD.AUTOINCREM'+
    '      JOIN PEDELE PE ON PE.PEL_NUMDOC = PD.PCD_NUMPED'+
    '                    AND PE.PEL_ESPDOC = PD.PCD_ESPDOC'+
    '                    AND PE.PEL_CODEMP = PD.PCD_CODEMP'+
    '      JOIN GERELE GE ON GE.AUTOINCREM = PE.PEL_SEQELE'+
    '      JOIN DETELE DE ON DE.DET_SEQGER = GE.AUTOINCREM'+
    '                    AND DE.DET_CODITE = PD.PCD_CODITE'+
    '    LEFT               ';
    If AConferenciaDepoisDaEntrada then
      Result := Result + '   JOIN BAIPED BP ON BP.BAI_AUTPED = PD.AUTOINCREM '+
                         '   LEFT JOIN MOVDET MD ON MD.AUTOINCREM = BP.BAI_AUTDET '
    Else
      Result := Result + '      JOIN BAIREQ BR ON BR.BAI_AUTREQ = RD.AUTOINCREM '  +
                         '    LEFT JOIN MOVDET MD ON MD.AUTOINCREM = BR.BAI_AUTDET ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR ON FDO_NUMDOC = RD.RCD_DOCPDV '+
      '               AND FDO_ESPDOC = RD.RCD_ESPPDV '+
      '               AND FDO_CODEMP = RD.RCD_EMPPDV '+
      '               AND FDO_CODITE = RD.RCD_CODITE ';

  Result := Result +
    '     WHERE RD.RCD_DOCPDV = :NUMDOC              '+
    '       AND RD.RCD_ESPPDV = :ESPDOC              '+
    '       AND RD.RCD_EMPPDV = :CODEMP              '+
    '       AND MD.AUTOINCREM IS NULL                ';

(*
  If AConferenciaDepoisDaEntrada Then
    Result := Result + ' AND IFNULL(GE.GER_DOCENT, "") = "" '
  Else
    Result := Result + '  AND IFNULL(GE.GER_DTACON, "") <> "" ';
*)


  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '    UNION ALL          '+
    '    SELECT COUNT(0) AS QTDE                     '+
    '      FROM EXTGOR ET                            '+
    '      JOIN FATGOR FG ON ET.FGO_SEQFGO = FG.AUTOINCREM'+
    '      JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT( '+
    '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),  '+
    '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),   '+
    '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))'+
    '    LEFT               '+
    '      JOIN MOVDET MD ON MD.DET_NUMDOC = FG.FGO_NUMFAT'+
    '                    AND MD.DET_ESPDOC = IF(FG.FGO_TIPFAT = "TE", "PD", FG.FGO_TIPFAT)'+
    '                    AND MD.DET_EMPCOM = FG.FGO_EMPFAT'+
    '                    AND MD.DET_PEDCOM = PD.PCD_NUMPED'+
    '                    AND MD.DET_CODITE = PD.PCD_CODITE';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR ON FDO_NUMDOC = ET.FGO_NMPDAB '+
      '               AND FDO_ESPDOC = ET.FGO_ESPDAB '+
      '               AND FDO_CODEMP = ET.FGO_EMPDAB '+
      '               AND FDO_CODITE = PD.PCD_CODITE ';

  Result := Result +
    '     WHERE ET.FGO_NMPDAB = :NUMDOC              '+
    '       AND ET.FGO_ESPDAB = :ESPDOC              '+
    '       AND ET.FGO_EMPDAB = :CODEMP              '+
    '       AND PD.PCD_BAIXAD = FALSE                '+
    '       AND MD.AUTOINCREM IS NULL                ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FATDOR.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '    UNION ALL          '+
    '    SELECT COUNT(0) AS QTDE                     '+
    '      FROM REQVEN      '+
    '      JOIN PREPTE ON PREPTE.AUTOINCREM = SEQ_PREPTE'+
    '      JOIN MOVRCD RD ON RD.AUTOINCREM = SEQ_MOVRCD'+
    '      JOIN FATDOR FD ON FD.AUTOINCREM = SEQ_FATDOR '+
    '      JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT( '+
    '            LPAD(IFNULL(FD.FDO_NUMFAT,""),12,"0"),'+
    '            LPAD(IFNULL(FD.FDO_TIPFAT,""),2," "),'+
    '            LPAD(TRIM(IFNULL(FD.FDO_EMPFAT,"")),3,"0"))'+
    '            AND PD.PCD_CODITE = FD.FDO_CODITE   '+
    '    LEFT               '+
    '      JOIN MOVDET MD ON MD.DET_NUMDOC = FD.FDO_NUMFAT'+
    '                    AND MD.DET_ESPDOC = IF(FD.FDO_TIPFAT = "TE", "PD", FD.FDO_TIPFAT)'+
    '                    AND MD.DET_EMPCOM = FD.FDO_EMPFAT'+
    '                    AND MD.DET_PEDCOM = PD.PCD_NUMPED'+
    '                    AND MD.DET_CODITE = PD.PCD_CODITE';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR FDO ON FDO.FDO_NUMDOC = RD.RCD_DOCPDV '+
      '                   AND FDO.FDO_ESPDOC = RD.RCD_ESPPDV '+
      '                   AND FDO.FDO_CODEMP = RD.RCD_EMPPDV '+
      '                   AND FDO.FDO_CODITE = RD.RCD_CODITE ';

  Result := Result +
    '     WHERE RD.RCD_DOCPDV = :NUMDOC              '+
    '       AND RD.RCD_ESPPDV = :ESPDOC              '+
    '       AND RD.RCD_EMPPDV = :CODEMP              '+
    '       AND PD.PCD_BAIXAD = FALSE                '+
    '       AND MD.AUTOINCREM IS NULL                ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';

  Result := Result + '   ) TMP ';
end;

function TGetSQLStatus.sqlMovimentoFiscalPendente(AConferenciaDepoisDaEntrada: Boolean): String;
begin
  Result := '';

  Result := Result +
    ' SELECT SQL_NO_CACHE SUM(QTDE) AS QTDE FROM (    '+
    '  SELECT COUNT(0) AS QTDE                       '+
    '    FROM MOVRCD RD     ' +
    '      JOIN PCMDET PD ON RD.RCD_SEQPCD = PD.AUTOINCREM ';



  If AConferenciaDepoisDaEntrada then
    Result := Result + '   JOIN BAIPED BP ON BP.BAI_AUTPED = PD.AUTOINCREM '+
                       '   JOIN MOVDET MD ON MD.AUTOINCREM = BP.BAI_AUTDET '
  Else
    Result := Result + '    JOIN BAIREQ BR ON BR.BAI_AUTREQ = RD.AUTOINCREM ' +
                       '    JOIN MOVDET MD ON MD.AUTOINCREM = BR.BAI_AUTDET ' ;

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR FDO ON FDO.FDO_NUMDOC = RD.RCD_DOCPDV '+
      '                   AND FDO.FDO_ESPDOC = RD.RCD_ESPPDV '+
      '                   AND FDO.FDO_CODEMP = RD.RCD_EMPPDV '+
      '                   AND FDO.FDO_CODITE = RD.RCD_CODITE ';

  Result := Result +
    '   WHERE RCD_DOCPDV = :NUMDOC                   '+
    '     AND RCD_ESPPDV = :ESPDOC                   '+
    '     AND RCD_EMPPDV = :CODEMP                   '+
    '     AND IFNULL(MD.DET_DTAENT, "") = ""         ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '  UNION ALL            '+
    '  SELECT COUNT(0) AS QTDE                       '+
    '    FROM EXTGOR ET     '+
    '    JOIN FATGOR FG ON ET.FGO_SEQFGO = FG.AUTOINCREM'+
    '    JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(   '+
    '          LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),'+
    '          LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "), '+
    '          LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))'+
    '    JOIN MOVDET MD ON MD.DET_NUMDOC = FG.FGO_NUMFAT'+
    '              		AND MD.DET_ESPDOC = IF(FG.FGO_TIPFAT = "TE", "PD", FG.FGO_TIPFAT)'+
    '              		AND MD.DET_EMPCOM = FG.FGO_EMPFAT'+
    '              		AND MD.DET_PEDCOM = PD.PCD_NUMPED'+
    '              		AND MD.DET_CODITE = PD.PCD_CODITE';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR FDO ON FDO.FDO_NUMDOC = ET.FGO_NMPDAB '+
      '                   AND FDO.FDO_ESPDOC = ET.FGO_ESPDAB '+
      '                   AND FDO.FDO_CODEMP = ET.FGO_EMPDAB '+
      '                   AND FDO.FDO_CODITE = PD.PCD_CODITE ';

  Result := Result +
    '   WHERE ET.FGO_NMPDAB = :NUMDOC                '+
    '     AND ET.FGO_ESPDAB = :ESPDOC                '+
    '     AND ET.FGO_EMPDAB = :CODEMP                '+
    '     AND IFNULL(MD.DET_DTAENT, "") = ""         ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '  UNION ALL            '+
    '  SELECT COUNT(0) AS QTDE                       '+
    '    FROM REQVEN        '+
    '    JOIN PREPTE ON PREPTE.AUTOINCREM = SEQ_PREPTE'+
    '    JOIN MOVRCD RD ON RD.AUTOINCREM = SEQ_MOVRCD'+
    '    JOIN FATGOR FG ON FGO_NUMDOC = PRE_NUMDOC   '+
    '                  AND FGO_ESPDOC = PRE_ESPDOC   '+
    '                  AND FGO_CODEMP = PRE_EMPDOC   '+
    '    JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(   '+
    '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),  '+
    '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),   '+
    '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))'+
    '    JOIN MOVDET MD ON MD.DET_NUMDOC = FG.FGO_NUMFAT'+
    '		              AND MD.DET_ESPDOC = IF(FG.FGO_TIPFAT = "TE", "PD", FG.FGO_TIPFAT)'+
    '                 AND MD.DET_EMPCOM = FG.FGO_EMPFAT'+
    '              		AND MD.DET_PEDCOM = PD.PCD_NUMPED'+
    '              		AND MD.DET_CODITE = PD.PCD_CODITE';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR FDO ON FDO.FDO_NUMDOC = RD.RCD_DOCPDV '+
      '                   AND FDO.FDO_ESPDOC = RD.RCD_ESPPDV '+
      '                   AND FDO.FDO_CODEMP = RD.RCD_EMPPDV '+
      '                   AND FDO.FDO_CODITE = RD.RCD_CODITE ';

  Result := Result +
    '   WHERE RD.RCD_DOCPDV = :NUMDOC                '+
    '     AND RD.RCD_ESPPDV = :ESPDOC                '+
    '     AND RD.RCD_EMPPDV = :CODEMP                '+
    '     AND IFNULL(MD.DET_DTAENT, "") = ""         ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';

  Result := Result + ') TMP ';
end;

function TGetSQLStatus.sqlEnderecamentoPendente: String;
begin
  Result := '';

  Result := Result +
    ' SELECT SQL_NO_CACHE SUM(TMP.QTDE) AS QTDE       '+
    '  FROM                 '+
    '  (                    '+
    '  SELECT COUNT(1) AS QTDE                       '+
    '    FROM               '+
    '    (                  '+
    '    SELECT IF((PD.PCD_BAIXAD = 0 AND IFNULL(GE.GER_DTACON, "") <> "")'+
    '            	OR ((IFNULL(EG.FGO_DOCEND, "") <> "") AND '+
    '                  (IFNULL(FD.FDO_QTDBAI, 0) < IFNULL(FD.FDO_QTDITE, 0))), "N", "S") AS BAIEND'+
    '      FROM MOVRCD RD                            '+
    '      JOIN PCMDET PD ON RD.RCD_SEQPCD = PD.AUTOINCREM'+
    '      JOIN PEDELE PE ON PE.PEL_NUMDOC = PD.PCD_NUMPED'+
    '                    AND PE.PEL_ESPDOC = PD.PCD_ESPDOC'+
    '                    AND PE.PEL_CODEMP = PD.PCD_CODEMP'+
    '      JOIN GERELE GE ON GE.AUTOINCREM = PE.PEL_SEQELE'+
    '      JOIN DETELE DE ON DE.DET_SEQGER = GE.AUTOINCREM'+
    '                    AND DE.DET_CODITE = PD.PCD_CODITE'+
    '      JOIN BAIPED BP ON BP.BAI_AUTPED = PD.AUTOINCREM'+
    '      JOIN MOVDET MD ON MD.AUTOINCREM = BP.BAI_AUTDET'+
    '     LEFT              '+
    '      JOIN EXTGOR EG ON EG.FGO_DOCEND = CONCAT( '+
    '        LPAD(IFNULL(MD.DET_NUMDOC,""),12,"0"),  '+
    '        LPAD(IFNULL(MD.DET_ESPDOC,""), 2,"0"),  '+
    '        RPAD(TRIM(IFNULL(MD.DET_SERIE_,"")),3," "),'+
    '        LPAD(TRIM(IFNULL(MD.DET_CODEMP,"")),3,"0"),'+
    '        LPAD(TRIM(IFNULL(MD.DET_CODFOR,"")),8,"0"),'+
    '        TRIM(IFNULL(MD.DET_TIP_FC, " ")))       '+
    '    LEFT               '+
    '     JOIN FATDOR FD ON FD.FDO_SEQGER = EG.FGO_SEQFGO'+
    '                   AND FD.FDO_CODITE = PD.PCD_CODITE'+
    '    LEFT               '+
    '     JOIN REQVEN Q ON Q.SEQ_MOVRCD = RD.AUTOINCREM';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR FDO ON FDO.FDO_NUMDOC = RD.RCD_DOCPDV '+
      '                   AND FDO.FDO_ESPDOC = RD.RCD_ESPPDV '+
      '                   AND FDO.FDO_CODEMP = RD.RCD_EMPPDV '+
      '                   AND FDO.FDO_CODITE = RD.RCD_CODITE ';
  Result := Result +
    '    WHERE RD.RCD_DOCPDV = :NUMDOC               '+
    '       AND RD.RCD_ESPPDV = :ESPDOC              '+
    '       AND RD.RCD_EMPPDV = :CODEMP              '+
    '       AND IFNULL(Q.SEQ_MOVRCD, "") = ""        ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '    ) TMP              '+
    '  WHERE TMP.BAIEND = "N"                        ';

  Result := Result +
    '  UNION ALL            '+
    '  SELECT COUNT(1) AS QTDE                       '+
    '    FROM PREPTE TE     '+
    '    JOIN FATGOR FG ON TE.PRE_NUMDOC = FG.FGO_NUMDOC'+
    '                  AND TE.PRE_ESPDOC = FG.FGO_ESPDOC'+
    '                  AND TE.PRE_EMPDOC = FG.FGO_CODEMP'+
    '    JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(   '+
    '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),  '+
    '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),   '+
    '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))'+
    '        AND PD.PCD_CODITE = TE.PRE_CODITE       '+
    '    JOIN MOVDET MD ON MD.DET_NUMDOC = FG.FGO_NUMFAT'+
    '                  AND MD.DET_ESPDOC = IF(FG.FGO_TIPFAT = "TE", "PD", FG.FGO_TIPFAT)'+
    '                  AND MD.DET_EMPCOM = FG.FGO_EMPFAT'+
    '                  AND MD.DET_PEDCOM = PD.PCD_NUMPED'+
    '                  AND MD.DET_CODITE = PD.PCD_CODITE'+
    '    JOIN EXTGOR EG ON EG.FGO_DOCEND = CONCAT(   '+
    '        LPAD(IFNULL(MD.DET_NUMDOC,""),12,"0"),  '+
    '        LPAD(IFNULL(MD.DET_ESPDOC,""), 2,"0"),  '+
    '        RPAD(TRIM(IFNULL(MD.DET_SERIE_,"")),3," "),'+
    '        LPAD(TRIM(IFNULL(MD.DET_CODEMP,"")),3,"0"),'+
    '        LPAD(TRIM(IFNULL(MD.DET_CODFOR,"")),8,"0"),'+
    '        TRIM(IFNULL(MD.DET_TIP_FC, " ")))       '+
    '    JOIN FATDOR FD ON FD.FDO_SEQGER = EG.FGO_SEQFGO'+
    '                  AND FD.FDO_CODITE = PD.PCD_CODITE';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR FDO ON FDO.FDO_NUMDOC = TE.PRE_DOCABS '+
      '                   AND FDO.FDO_ESPDOC = TE.PRE_ESPABS '+
      '                   AND FDO.FDO_CODEMP = TE.PRE_EMPABS '+
      '                   AND FDO.FDO_CODITE = TE.PRE_CODITE ';

  Result := Result +
    '   WHERE TE.PRE_DOCABS = :NUMDOC                '+
    '     AND TE.PRE_ESPABS = :ESPDOC                '+
    '     AND TE.PRE_EMPABS = :CODEMP                '+
    '     AND FD.FDO_QTDBAI < FD.FDO_QTDITE          ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '  UNION ALL            '+
    '  SELECT               '+
    '    COUNT(1) AS QTDE                            '+
    '  FROM                 '+
    '    REQVEN             '+
    '    INNER JOIN PREPTE                           '+
    '      ON PREPTE.AUTOINCREM = SEQ_PREPTE         '+
    '    INNER JOIN MOVRCD                           '+
    '      ON MOVRCD.AUTOINCREM = SEQ_MOVRCD         '+
    '    INNER JOIN FATGOR FG                        '+
    '      ON FGO_NUMDOC = PRE_NUMDOC                '+
    '      AND FGO_ESPDOC = PRE_ESPDOC               '+
    '      AND FGO_CODEMP = PRE_EMPDOC               '+
    '    JOIN PCMDET PD ON PD.PCD_DOCORI = CONCAT(   '+
    '        LPAD(IFNULL(FG.FGO_NUMFAT,""),12,"0"),  '+
    '        LPAD(IFNULL(FG.FGO_TIPFAT,""),2," "),   '+
    '        LPAD(TRIM(IFNULL(FG.FGO_EMPFAT,"")),3,"0"))'+
    '        AND PD.PCD_CODITE = RCD_CODITE          '+
    '    JOIN MOVDET MD ON MD.DET_NUMDOC = FG.FGO_NUMFAT'+
    '                  AND MD.DET_ESPDOC = IF(FG.FGO_TIPFAT = "TE", "PD", FG.FGO_TIPFAT)'+
    '                  AND MD.DET_EMPCOM = FG.FGO_EMPFAT'+
    '                  AND MD.DET_PEDCOM = PD.PCD_NUMPED'+
    '                  AND MD.DET_CODITE = PD.PCD_CODITE'+
    '    JOIN EXTGOR EG ON EG.FGO_DOCEND = CONCAT(   '+
    '        LPAD(IFNULL(MD.DET_NUMDOC,""),12,"0"),  '+
    '        LPAD(IFNULL(MD.DET_ESPDOC,""), 2,"0"),  '+
    '        RPAD(TRIM(IFNULL(MD.DET_SERIE_,"")),3," "),'+
    '        LPAD(TRIM(IFNULL(MD.DET_CODEMP,"")),3,"0"),'+
    '        LPAD(TRIM(IFNULL(MD.DET_CODFOR,"")),8,"0"),'+
    '        TRIM(IFNULL(MD.DET_TIP_FC, " ")))       '+
    '    JOIN FATDOR FD ON FD.FDO_SEQGER = EG.FGO_SEQFGO'+
    '                  AND FD.FDO_CODITE = PD.PCD_CODITE';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR FDO ON FDO.FDO_NUMDOC = RCD_DOCPDV '+
      '                   AND FDO.FDO_ESPDOC = RCD_ESPPDV '+
      '                   AND FDO.FDO_CODEMP = RCD_EMPPDV '+
      '                   AND FDO.FDO_CODITE = RCD_CODITE ';

  Result := Result +
    '  WHERE RCD_DOCPDV = :NUMDOC                    '+
    '    AND RCD_ESPPDV = :ESPDOC                    '+
    '    AND RCD_EMPPDV = :CODEMP                    '+
    '    AND FD.FDO_QTDBAI < FD.FDO_QTDITE           ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';

  Result := Result + '  ) TMP ';
end;

function TGetSQLStatus.sqlExtornoSeparacao: String;
begin
  Result := '';

  Result := Result +
    ' SELECT COUNT(1) AS QTDE                          '+
    '  FROM FATGOR FG         '+
    '  JOIN EXTGOR EG ON FG.AUTOINCREM = EG.FGO_SEQFGO ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR FDO ON FDO.FDO_NUMDOC = FGO_NUMDOC '+
      '                   AND FDO.FDO_ESPDOC = FGO_ESPDOC '+
      '                   AND FDO.FDO_CODEMP = FGO_CODEMP ';
  Result := Result +
    ' WHERE FG.FGO_NUMDOC = :NUMDOC                    '+
    '   AND FG.FGO_ESPDOC = :ESPDOC                    '+
    '   AND FG.FGO_CODEMP = :CODEMP                    '+
    '   AND EG.FGO_EXTSEP = "S"                        ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';
end;

function TGetSQLStatus.sqlSeparacaoAndamento: String;
begin
  Result := '';

  Result := Result +
    ' SELECT                                          '+
    '   SQL_NO_CACHE COUNT(1) AS QTDE                 '+
    ' FROM                                            '+
    ' (SELECT                                         '+
    '   FG.AUTOINCREM                                 '+
    ' FROM                                            '+
    '   FATGOR FG                                     '+
    '   JOIN EXTGOR EG                                '+
    '     ON FG.AUTOINCREM = EG.FGO_SEQFGO            '+
    '     JOIN FATDOR FD                              '+
    '       ON FD.FDO_NUMDOC = FG.FGO_NUMDOC          '+
    '       AND FD.FDO_ESPDOC = FG.FGO_ESPDOC         '+
    '       AND FD.FDO_CODEMP = FG.FGO_CODEMP         '+
    '       AND FD.FDO_CODCLI = FG.FGO_CODCLI         '+
    '       AND FD.FDO_JAFATU = 0                     '+
    '     JOIN EXTDOR ED                              '+
    '       ON FD.AUTOINCREM = ED.FDO_SEQFDO          '+
    ' WHERE FG.FGO_NUMDOC = :NUMDOC                   '+
    '   AND FG.FGO_ESPDOC = :ESPDOC                   '+
    '   AND FG.FGO_CODEMP = :CODEMP                   '+
    '   AND IF(                                       '+
    '     FG.FGO_SEPIMP = "N"                         '+
    '     OR IFNULL(FG.FGO_SEPIMP, "") = "",          '+
    '     "0",                                        '+
    '     IF(                                         '+
    '       FG.FGO_SEPIMP = "S",                      '+
    '       "1",                                      '+
    '       FG.FGO_SEPIMP                             '+
    '     )                                           '+
    '   ) <> "0"                                      '+
    '   AND EG.FGO_OPBXSE IS NULL                     '+
    '   AND EG.FGO_DTBXSE IS NULL                     '+
    '   AND EG.FGO_HRBXSE IS NULL                     ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FD.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '   GROUP BY FGO_NUMDOC,                          '+
    '            FGO_ESPDOC,                          '+
    '            FGO_CODEMP                           '+
    '   HAVING SUM(IFNULL(ED.FDO_QTDSEP, 0)) > 0) TMP ';
end;

function TGetSQLStatus.sqlSeparacaoPendente: String;
begin
  Result := '';

  Result := Result +
    ' SELECT SQL_NO_CACHE COUNT(1) AS QTDE            '+
    '  FROM FATGOR          ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR FDO ON FDO.FDO_NUMDOC = FGO_NUMDOC '+
      '                   AND FDO.FDO_ESPDOC = FGO_ESPDOC '+
      '                   AND FDO.FDO_CODEMP = FGO_CODEMP ';

  Result := Result +
    ' WHERE FGO_NUMDOC = :NUMDOC                     '+
    '   AND FGO_ESPDOC = :ESPDOC                     '+
    '   AND FGO_CODEMP = :CODEMP                     '+
    '   AND IF(FGO_SEPIMP = "N" OR IFNULL(FGO_SEPIMP,"") = "",'+
    '          "0",         '+
    '          IF(FGO_SEPIMP = "S",                  '+
    '             "1",      '+
    '             FGO_SEPIMP)) = "0"                 '+
    '   AND FGO_JAFATU = 0                           ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';
end;

function TGetSQLStatus.sqlEmSeparacao: String;
begin
  Result := '';

  Result := Result +
    ' SELECT SQL_NO_CACHE COUNT(1) AS QTDE            '+
    '  FROM                 '+
    '  (                    '+
    '  SELECT IF((SUM(FD.FDO_QTDITE) - SUM(FD.FDO_QTDBAI))'+
    '            = SUM(ED.FDO_QTDEXP), "S", "N") AS EXPTOT'+
    '    FROM FATGOR FG     '+
    '    JOIN FATDOR FD ON FD.FDO_NUMDOC = FG.FGO_NUMDOC'+
    '                  AND FD.FDO_ESPDOC = FG.FGO_ESPDOC'+
    '                  AND FD.FDO_CODEMP = FG.FGO_CODEMP'+
    '                  AND FD.FDO_CODCLI = FG.FGO_CODCLI'+
    '                  AND FD.FDO_JAFATU = 0         '+
    '    JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO'+
    '   WHERE FG.FGO_NUMDOC = :NUMDOC                '+
    '     AND FG.FGO_ESPDOC = :ESPDOC                '+
    '     AND FG.FGO_CODEMP = :CODEMP                '+
    '     AND IF(FG.FGO_SEPIMP = "N" OR IFNULL(FG.FGO_SEPIMP,"") = "",'+
    '           "0",        '+
    '           IF(FG.FGO_SEPIMP = "S",              '+
    '              "1",     '+
    '              FG.FGO_SEPIMP)) <> "0"            ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FD.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '   GROUP BY FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP  '+
    '   ) TMP               '+
    '  WHERE TMP.EXPTOT = "N"                        ';
end;

function TGetSQLStatus.sqlEmSeparacaoBaiSep: String;
begin
  Result := '';

  Result := Result +
    ' SELECT                                          '+
    '   SQL_NO_CACHE COUNT(1) AS QTDE                 '+
    ' FROM                                            '+
    ' (SELECT                                         '+
    '   FG.AUTOINCREM                                 '+
    ' FROM                                            '+
    '   FATGOR FG                                     '+
    '   JOIN EXTGOR EG                                '+
    '     ON FG.AUTOINCREM = EG.FGO_SEQFGO            '+
    '     JOIN FATDOR FD                              '+
    '       ON FD.FDO_NUMDOC = FG.FGO_NUMDOC          '+
    '       AND FD.FDO_ESPDOC = FG.FGO_ESPDOC         '+
    '       AND FD.FDO_CODEMP = FG.FGO_CODEMP         '+
    '       AND FD.FDO_CODCLI = FG.FGO_CODCLI         '+
    '       AND FD.FDO_JAFATU = 0                     '+
    '     JOIN EXTDOR ED                              '+
    '       ON FD.AUTOINCREM = ED.FDO_SEQFDO          '+
    ' WHERE FG.FGO_NUMDOC = :NUMDOC                   '+
    '   AND FG.FGO_ESPDOC = :ESPDOC                   '+
    '   AND FG.FGO_CODEMP = :CODEMP                   '+
    '   AND IF(                                       '+
    '     FG.FGO_SEPIMP = "N"                         '+
    '     OR IFNULL(FG.FGO_SEPIMP, "") = "",          '+
    '     "0",                                        '+
    '     IF(                                         '+
    '       FG.FGO_SEPIMP = "S",                      '+
    '       "1",                                      '+
    '       FG.FGO_SEPIMP                             '+
    '     )                                           '+
    '   ) <> "0"                                      '+
    '   AND EG.FGO_OPBXSE IS NULL                     '+
    '   AND EG.FGO_DTBXSE IS NULL                     '+
    '   AND EG.FGO_HRBXSE IS NULL                     ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FD.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '   GROUP BY FGO_NUMDOC,                          '+
    '            FGO_ESPDOC,                          '+
    '            FGO_CODEMP                           '+
    '   HAVING SUM(IFNULL(ED.FDO_QTDSEP, 0)) <= 0) TMP ';
end;

function TGetSQLStatus.sqlConferenciaExpPendente: String;
begin
  Result := '';

  Result := Result +
    'SELECT SQL_NO_CACHE COUNT(1) AS QTDE            '+
    '  FROM                                          '+
    '  (                                             '+
    '  SELECT IF(SUM(FDO_QTDEXP) > 0 AND ((SUM(FDO_QTDITE) - SUM(FDO_QTDBAI)) > SUM(FDO_QTDEXP)), "S", "N") AS TEMEXP, ' +
    '         IF((SUM(FD.FDO_QTDITE) - SUM(FD.FDO_QTDBAI)) = SUM(ED.FDO_QTDEXP), "S", "N") AS EXPTOT ' +
    '    FROM FATGOR FG                              '+
    '    JOIN EXTGOR EG ON FG.AUTOINCREM = EG.FGO_SEQFGO'+
    '    JOIN FATDOR FD ON FD.FDO_NUMDOC = FG.FGO_NUMDOC'+
    '                  AND FD.FDO_ESPDOC = FG.FGO_ESPDOC'+
    '                  AND FD.FDO_CODEMP = FG.FGO_CODEMP'+
    '                  AND FD.FDO_CODCLI = FG.FGO_CODCLI'+
    '                  AND FD.FDO_JAFATU = 0         '+
    '    JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO'+
    '   WHERE FG.FGO_NUMDOC = :NUMDOC                '+
    '     AND FG.FGO_ESPDOC = :ESPDOC                '+
    '     AND FG.FGO_CODEMP = :CODEMP                '+
    '     AND ED.FDO_EXIBSE = "S"                    '+
    '     AND EG.FGO_OPBXSE IS NOT NULL              '+
    '     AND EG.FGO_DTLBEX IS NULL                  '+
    '     AND EG.FGO_HRLBEX IS NULL                  ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FD.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '   GROUP BY FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP  '+
    '   ) TMP                                        '+
    '    WHERE TMP.TEMEXP = "N"                      ';
end;

function TGetSQLStatus.sqlFaturamentoCancelado: String;
begin
  Result := '';

  Result := Result +
    ' SELECT COUNT(1) AS QTDE                          '+
    '  FROM FATGOR FG         '+
    '  JOIN EXTGOR EG ON FG.AUTOINCREM = EG.FGO_SEQFGO ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR FDO ON FDO.FDO_NUMDOC = FGO_NUMDOC '+
      '                   AND FDO.FDO_ESPDOC = FGO_ESPDOC '+
      '                   AND FDO.FDO_CODEMP = FGO_CODEMP ';
  Result := Result +
    ' WHERE FG.FGO_NUMDOC = :NUMDOC                    '+
    '   AND FG.FGO_ESPDOC = :ESPDOC                    '+
    '   AND FG.FGO_CODEMP = :CODEMP                    '+
    '   AND EG.FGO_CANFAT = 1                          ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';
end;

function TGetSQLStatus.sqlFaturamentoPendente: String;
begin
  Result := '';

  Result := Result +
    ' SELECT SQL_NO_CACHE COUNT(1) AS QTDE           '+
    '  FROM FATGOR                                   ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR FDO ON FDO.FDO_NUMDOC = FGO_NUMDOC '+
      '                   AND FDO.FDO_ESPDOC = FGO_ESPDOC '+
      '                   AND FDO.FDO_CODEMP = FGO_CODEMP ';

  Result := Result +
    ' WHERE FGO_NUMDOC = :NUMDOC                     '+
    '   AND FGO_ESPDOC = :ESPDOC                     '+
    '   AND FGO_CODEMP = :CODEMP                     ';

  If Self.FTipoStatus = statusItemPedido Then
  Begin
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';
    Result := Result + '   AND FDO.FDO_JAFATU = 0 ';
  End
  Else
    Result := Result + '   AND FGO_JAFATU = 0 ';
end;

function TGetSQLStatus.sqlRomaneioPDPendente(ATipFat: TTipoFaturamento): String;
begin
  Result :=
    'SELECT SQL_NO_CACHE COUNT(1) AS QTDE            '+
    '  FROM FATGOR FG                                '+
    '  JOIN EXTGOR EG ON FG.AUTOINCREM = EG.FGO_SEQFGO'+
    '  JOIN FATDOR FDO ON FDO.FDO_NUMDOC = FG.FGO_NUMDOC'+
    '                 AND FDO.FDO_ESPDOC = FG.FGO_ESPDOC'+
    '                 AND FDO.FDO_CODEMP = FG.FGO_CODEMP'+
    '                 AND FDO.FDO_CODCLI = FG.FGO_CODCLI'+
    '                 AND FDO.FDO_ENTFUT = "N"          '+
    '  JOIN EXTDOR ED ON FDO.AUTOINCREM = ED.FDO_SEQFDO'+
    '                AND ED.FDO_ENTRET = "E"         '+
    '  LEFT JOIN ROMDETX R ON FDO.FDO_NUMDOC = R.DET_NUMDOC'+
    '                     AND FDO.FDO_ESPDOC = R.DET_ESPDOC'+
    '                     AND FDO.FDO_CODEMP = R.DET_CODEMP'+
    '                     AND FDO.FDO_CODITE = R.DET_CODITE'+
    ' WHERE FG.FGO_NUMDOC = :NUMDOC                  '+
    '   AND FG.FGO_ESPDOC = :ESPDOC                  '+
    '   AND FG.FGO_CODEMP = :CODEMP                  '+
    '   AND (((IFNULL(FG.FGO_MOTBAI, "") = "") AND (EG.FGO_UTIPEN = "N")) OR ((IFNULL(FG.FGO_MOTBAI, "") <> "") AND (EG.FGO_UTIPEN = "S"))) '+
    '   AND IFNULL(R.AUTOINCREM, "") = ""            ';

  If Self.FTipoStatus = statusItemPedido Then
  Begin
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';
    Case ATipFat Of
      tfTotal  : Result := Result + sqlItemPedidoJaFaturado;
      tfParcial: Result := Result + sqlItemPedidoFaturadoParcialmente;
    End;
  End
  Else
  Begin
    Case ATipFat Of
      tfTotal  : Result := Result + sqlPedidoJaFaturado;
      tfParcial: Result := Result + sqlPedidoFaturadoParcialmente;
    End;
  End;
end;

function TGetSQLStatus.sqlRomaneioNFPendente(ATipFat: TTipoFaturamento): String;
begin
  Result :=
    '  SELECT SQL_NO_CACHE COUNT(1) AS QTDE          '+
    '  FROM FATGOR FG                                '+
    '  JOIN EXTGOR EG ON FG.AUTOINCREM = EG.FGO_SEQFGO'+
    '  JOIN FATDOR FDO ON FDO.FDO_NUMDOC = FG.FGO_NUMDOC'+
    '                AND FDO.FDO_ESPDOC = FG.FGO_ESPDOC'+
    '                AND FDO.FDO_CODEMP = FG.FGO_CODEMP'+
    '                AND FDO.FDO_CODCLI = FG.FGO_CODCLI'+
    '                AND FDO.FDO_ENTFUT = "N"          '+
    '  JOIN EXTDOR ED ON FDO.AUTOINCREM = ED.FDO_SEQFDO'+
    '                AND ED.FDO_ENTRET = "E"      '+
    '  JOIN MOVDET MD ON MD.DET_NUMDOC = FDO.FDO_NUMFAT'+
    '                AND MD.DET_ESPDOC = FDO.FDO_TIPFAT'+
    '                AND MD.DET_CODEMP = FDO.FDO_EMPFAT'+
    '                AND MD.DET_CODITE = FDO.FDO_CODITE'+
    '                AND MD.DET_CODCLI = FDO.FDO_CODCLI'+
    '  LEFT JOIN ROMDETX R ON MD.DET_NUMDOC = R.DET_NUMDOC'+
    '                     AND MD.DET_ESPDOC = R.DET_ESPDOC'+
    '                     AND MD.DET_SERIE_ = R.DET_SERIE_'+
    '                     AND MD.DET_CODEMP = R.DET_CODEMP'+
    '                     AND MD.DET_CODITE = R.DET_CODITE'+
    '                     AND MD.DET_CODCLI = R.DET_CODCLI'+
    ' WHERE FG.FGO_NUMDOC = :NUMDOC                  '+
    '   AND FG.FGO_ESPDOC = :ESPDOC                  '+
    '   AND FG.FGO_CODEMP = :CODEMP                  '+
    '   AND (((IFNULL(FG.FGO_MOTBAI, "") = "") AND (EG.FGO_UTIPEN = "N")) OR ((IFNULL(FG.FGO_MOTBAI, "") <> "") AND (EG.FGO_UTIPEN = "S")))          '+
    '   AND IFNULL(R.AUTOINCREM, "") = ""            ';

  if (fCfgSis('OPCROM', varString) = '3') then
  begin
    Result := Result +
      '   AND (SELECT COUNT(1) '+
      '        FROM NOTDET ND '+
      '        INNER JOIN CNFMNO C ON MNO_SEQGER = ND.DET_SEQGER     '+
      '        LEFT JOIN ROMDETX RD ON ND.DET_NUMDOC = RD.DET_NUMDOC '+
      '                            AND ND.DET_ESPDOC = RD.DET_ESPDOC '+
      '                            AND ND.DET_SERIE_ = RD.DET_SERIE_ '+
      '                            AND ND.DET_CODEMP = RD.DET_CODEMP '+
      '                            AND ND.DET_CODITE = RD.DET_CODITE '+
      '                            AND ND.DET_CODCLI = RD.DET_CODCLI '+
      '        WHERE MD.DET_NUMDOC = MNO_NUMFAT                      '+
      '          AND MD.DET_ESPDOC = MNO_ESPFAT                      '+
      '          AND MD.DET_CODEMP = MNO_EMPFAT                      '+
      '          AND IFNULL(RD.AUTOINCREM, "") <> "") = 0            ';
  end;

  If Self.FTipoStatus = statusItemPedido Then
  Begin
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';
    Case ATipFat Of
      tfTotal  : Result := Result + sqlItemPedidoJaFaturado;
      tfParcial: Result := Result + sqlItemPedidoFaturadoParcialmente;
    End;
  End
  Else
  Begin
    Case ATipFat Of
      tfTotal  : Result := Result + sqlPedidoJaFaturado;
      tfParcial: Result := Result + sqlPedidoFaturadoParcialmente;
    End;
  End;
end;

function TGetSQLStatus.sqlFaturadoPDEmTransito(ATipFat: TTipoFaturamento): String;
begin
  Result :=
    '  SELECT SQL_NO_CACHE COUNT(1) AS QTDE          '+
    '  FROM FATGOR FG                                '+
    '  JOIN EXTGOR EG ON FG.AUTOINCREM = EG.FGO_SEQFGO'+
    '  JOIN FATDOR FDO ON FDO.FDO_NUMDOC = FG.FGO_NUMDOC'+
    '                AND FDO.FDO_ESPDOC = FG.FGO_ESPDOC'+
    '                AND FDO.FDO_CODEMP = FG.FGO_CODEMP'+
    '                AND FDO.FDO_CODCLI = FG.FGO_CODCLI'+
    '                AND FDO.FDO_ENTFUT = "N"          '+
    '  JOIN EXTDOR ED ON FDO.AUTOINCREM = ED.FDO_SEQFDO'+
    '                AND ED.FDO_ENTRET = "E"         '+
    '  JOIN ROMDETX R ON FDO.FDO_NUMDOC = R.DET_NUMDOC'+
    '                 AND FDO.FDO_ESPDOC = R.DET_ESPDOC'+
    '                 AND FDO.FDO_CODEMP = R.DET_CODEMP'+
    '                 AND FDO.FDO_CODITE = R.DET_CODITE'+
    '  JOIN ROMGERX X ON R.DET_SEQGER = X.AUTOINCREM '+
    ' WHERE FG.FGO_NUMDOC = :NUMDOC                  '+
    '   AND FG.FGO_ESPDOC = :ESPDOC                  '+
    '   AND FG.FGO_CODEMP = :CODEMP                  '+
    '   AND (((IFNULL(FG.FGO_MOTBAI, "") = "") AND (EG.FGO_UTIPEN = "N")) OR ((IFNULL(FG.FGO_MOTBAI, "") <> "") AND (EG.FGO_UTIPEN = "S")))          '+
    '   AND IFNULL(X.GER_DTABAI, "") = ""            ';

  If Self.FTipoStatus = statusItemPedido Then
  Begin
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';
    Case ATipFat Of
      tfTotal  : Result := Result + sqlItemPedidoJaFaturado;
      tfParcial: Result := Result + sqlItemPedidoFaturadoParcialmente;
    End;
  End
  Else
  Begin
    Case ATipFat Of
      tfTotal  : Result := Result + sqlPedidoJaFaturado;
      tfParcial: Result := Result + sqlPedidoFaturadoParcialmente;
    End;
  End;
end;

function TGetSQLStatus.sqlFaturadoDevTotal: String;
begin
  //devolução de NF
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE IF(GROUP_CONCAT(DEV_TOTAL) = "S", 1, 0) AS QTDE ';
  Result := Result + ' FROM ';
  Result := Result + '  (SELECT IF(DET.DET_QTDITE = ';
  Result := Result + '             (SELECT IFNULL(SUM(DEV.DET_QTDITE), 0) ';
  Result := Result + '              FROM MOVDET DEV ';
  Result := Result + '              JOIN MOVTRI TRI ON TRI.DET_SEQGER = DEV.AUTOINCREM ';
  Result := Result + '              WHERE TRI.DET_INCDEV = DET.AUTOINCREM), ';
  Result := Result + '             "S","N") AS DEV_TOTAL ';
  Result := Result + '   FROM FATDOR FDO ';
  Result := Result + '   JOIN MOVDET DET ON DET.DET_NUM_PD = FDO.FDO_NUMDOC ';
  Result := Result + '                  AND DET.DET_ESP_PD = FDO.FDO_ESPDOC ';
  Result := Result + '                  AND DET.DET_EMP_PD = FDO.FDO_CODEMP ';
  Result := Result + '                  AND DET.DET_IND_PD = FDO.FDO_SEQIND ';
  Result := Result + '                  AND DET.DET_ESPDOC NOT IN ("MI","FF","PR") ';
  Result := Result + '   WHERE FDO_NUMDOC = :NUMDOC ';
  Result := Result + '     AND FDO_ESPDOC = :ESPDOC ';
  Result := Result + '     AND FDO_CODEMP = :CODEMP ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + ' AND FDO.AUTOINCREM = :SEQFDO ';

  //devolução de NF originada por FF
  Result := Result + '   UNION ';
  Result := Result + '   SELECT IF(CNF.DET_QTDITE = ';
  Result := Result + '             (SELECT IFNULL(SUM(DEV.DET_QTDITE), 0) ';
  Result := Result + '              FROM MOVDET DEV ';
  Result := Result + '              JOIN MOVTRI TRI ON TRI.DET_SEQGER = DEV.AUTOINCREM ';
  Result := Result + '              WHERE TRI.DET_INCDEV = CNF.AUTOINCREM), ';
  Result := Result + '             "S","N") AS DEV_TOTAL ';
  Result := Result + '   FROM FATDOR FDO ';
  Result := Result + '   JOIN MOVDET DET ON DET.DET_NUM_PD = FDO.FDO_NUMDOC ';
  Result := Result + '                  AND DET.DET_ESP_PD = FDO.FDO_ESPDOC ';
  Result := Result + '                  AND DET.DET_EMP_PD = FDO.FDO_CODEMP ';
  Result := Result + '                  AND DET.DET_IND_PD = FDO.FDO_SEQIND ';
  Result := Result + '                  AND DET.DET_ESPDOC IN ("MI","FF") ';
  Result := Result + '   JOIN NOTTRI TRI ON TRI.DET_SEQDET = DET.AUTOINCREM ';
  Result := Result + '   JOIN NOTDET CNF ON CNF.AUTOINCREM = TRI.DET_SEQGER ';
  Result := Result + '   WHERE FDO_NUMDOC = :NUMDOC ';
  Result := Result + '     AND FDO_ESPDOC = :ESPDOC ';
  Result := Result + '     AND FDO_CODEMP = :CODEMP ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + ' AND FDO.AUTOINCREM = :SEQFDO ';

  //devolução de FF
  Result := Result + '   UNION ';
  Result := Result + '   SELECT IF(DET.DET_QTDITE = ';
  Result := Result + '             (SELECT IFNULL(SUM(DEV.DET_QTDITE), 0) ';
  Result := Result + '              FROM MOVDET DEV ';
  Result := Result + '              JOIN MOVTRI TRI ON TRI.DET_SEQGER = DEV.AUTOINCREM ';
  Result := Result + '              WHERE TRI.DET_INCDEV = DET.AUTOINCREM), ';
  Result := Result + '             "S","N") AS DEV_TOTAL ';
  Result := Result + '   FROM FATDOR FDO ';
  Result := Result + '   JOIN MOVDET DET ON DET.DET_NUM_PD = FDO.FDO_NUMDOC ';
  Result := Result + '                  AND DET.DET_ESP_PD = FDO.FDO_ESPDOC ';
  Result := Result + '                  AND DET.DET_EMP_PD = FDO.FDO_CODEMP ';
  Result := Result + '                  AND DET.DET_IND_PD = FDO.FDO_SEQIND ';
  Result := Result + '                  AND DET.DET_ESPDOC IN ("MI","FF") ';
  Result := Result + '   WHERE FDO_NUMDOC = :NUMDOC ';
  Result := Result + '     AND FDO_ESPDOC = :ESPDOC ';
  Result := Result + '     AND FDO_CODEMP = :CODEMP ';
  Result := Result + '     AND NOT EXISTS(SELECT 1 FROM NOTTRI WHERE NOTTRI.DET_SEQDET = DET.AUTOINCREM) ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + ' AND FDO.AUTOINCREM = :SEQFDO ';

  Result := Result + ' ) TMP ';
end;

function TGetSQLStatus.sqlFaturadoNFEmTransito(ATipFat: TTipoFaturamento): String;
begin
  Result :=
    'SELECT SQL_NO_CACHE SUM(TMP.QTDE) AS QTDE '+
    'FROM ( '+
    ' SELECT COUNT(1) AS QTDE                        '+
    '  FROM FATGOR FG                                '+
    '  JOIN EXTGOR EG ON FG.AUTOINCREM = EG.FGO_SEQFGO'+
    '  JOIN FATDOR FDO ON FDO.FDO_NUMDOC = FG.FGO_NUMDOC'+
    '                AND FDO.FDO_ESPDOC = FG.FGO_ESPDOC'+
    '                AND FDO.FDO_CODEMP = FG.FGO_CODEMP'+
    '                AND FDO.FDO_CODCLI = FG.FGO_CODCLI'+
    '                AND FDO.FDO_ENTFUT = "N"          '+
    '  JOIN EXTDOR ED ON FDO.AUTOINCREM = ED.FDO_SEQFDO'+
    '                AND ED.FDO_ENTRET = "E"         '+
    '  JOIN MOVDET MD ON MD.DET_NUMDOC = FDO.FDO_NUMFAT'+
    '                AND MD.DET_ESPDOC = FDO.FDO_TIPFAT'+
    '                AND MD.DET_CODEMP = FDO.FDO_EMPFAT'+
    '                AND MD.DET_CODITE = FDO.FDO_CODITE'+
    '                AND MD.DET_CODCLI = FDO.FDO_CODCLI'+
    '  JOIN ROMDETX R ON MD.DET_NUMDOC = R.DET_NUMDOC'+
    '                AND MD.DET_ESPDOC = R.DET_ESPDOC'+
    '                AND MD.DET_SERIE_ = R.DET_SERIE_'+
    '                AND MD.DET_CODEMP = R.DET_CODEMP'+
    '                AND MD.DET_CODITE = R.DET_CODITE'+
    '                AND MD.DET_CODCLI = R.DET_CODCLI'+
    '  JOIN ROMGERX X ON R.DET_SEQGER = X.AUTOINCREM '+
    ' WHERE FG.FGO_NUMDOC = :NUMDOC                  '+
    '   AND FG.FGO_ESPDOC = :ESPDOC                  '+
    '   AND FG.FGO_CODEMP = :CODEMP                  '+
    '   AND (((IFNULL(FG.FGO_MOTBAI, "") = "") AND (EG.FGO_UTIPEN = "N")) OR ((IFNULL(FG.FGO_MOTBAI, "") <> "") AND (EG.FGO_UTIPEN = "S"))) '+
    '   AND IFNULL(X.GER_DTABAI, "") = ""            ';

  If Self.FTipoStatus = statusItemPedido Then
  Begin
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';
    Case ATipFat Of
      tfTotal  : Result := Result + sqlItemPedidoJaFaturado;
      tfParcial: Result := Result + sqlItemPedidoFaturadoParcialmente;
    End;
  End
  Else
  Begin
    Case ATipFat Of
      tfTotal  : Result := Result + sqlPedidoJaFaturado;
      tfParcial: Result := Result + sqlPedidoFaturadoParcialmente;
    End;
  End;

  if (fCfgSis('OPCROM', varString) = '3') then
  begin
    Result := Result +
      ' UNION '+

      ' SELECT COUNT(1) AS QTDE                           '+
      ' FROM FATGOR FG                                    '+
      ' JOIN EXTGOR EG  ON FG.AUTOINCREM = EG.FGO_SEQFGO  '+
      ' JOIN FATDOR FDO ON FDO.FDO_NUMDOC = FG.FGO_NUMDOC '+
      '                AND FDO.FDO_ESPDOC = FG.FGO_ESPDOC '+
      '                AND FDO.FDO_CODEMP = FG.FGO_CODEMP '+
      '                AND FDO.FDO_CODCLI = FG.FGO_CODCLI '+
      '                AND FDO.FDO_ENTFUT = "N"           '+
      ' JOIN EXTDOR ED  ON FDO.AUTOINCREM = ED.FDO_SEQFDO '+
      '                AND ED.FDO_ENTRET = "E"            '+
      ' JOIN MOVDET MD  ON MD.DET_NUMDOC = FDO.FDO_NUMFAT '+
      '                AND MD.DET_ESPDOC = FDO.FDO_TIPFAT '+
      '                AND MD.DET_CODEMP = FDO.FDO_EMPFAT '+
      '                AND MD.DET_CODITE = FDO.FDO_CODITE '+
      '                AND MD.DET_CODCLI = FDO.FDO_CODCLI '+
      ' JOIN CNFMNO C   ON MD.DET_NUMDOC = MNO_NUMFAT     '+
      '                AND MD.DET_ESPDOC = MNO_ESPFAT     '+
      '                AND MD.DET_CODEMP = MNO_EMPFAT     '+
      ' JOIN NOTDET ND  ON MNO_SEQGER = ND.DET_SEQGER     '+
      ' JOIN ROMDETX R  ON ND.DET_NUMDOC = R.DET_NUMDOC   '+
      '                AND ND.DET_ESPDOC = R.DET_ESPDOC   '+
      '                AND ND.DET_SERIE_ = R.DET_SERIE_   '+
      '                AND ND.DET_CODEMP = R.DET_CODEMP   '+
      '                AND ND.DET_CODITE = R.DET_CODITE   '+
      '                AND ND.DET_CODCLI = R.DET_CODCLI   '+
      ' JOIN ROMGERX X  ON R.DET_SEQGER = X.AUTOINCREM    '+
      ' WHERE FG.FGO_NUMDOC = :NUMDOC                     '+
      '   AND FG.FGO_ESPDOC = :ESPDOC                     '+
      '   AND FG.FGO_CODEMP = :CODEMP                     '+
      '   AND (((IFNULL(FG.FGO_MOTBAI, "") = "") AND (EG.FGO_UTIPEN = "N")) OR ((IFNULL(FG.FGO_MOTBAI, "") <> "") AND (EG.FGO_UTIPEN = "S"))) '+
      '   AND IFNULL(X.GER_DTABAI, "") = ""               ';

    If Self.FTipoStatus = statusItemPedido Then
    Begin
      Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';
      Case ATipFat Of
        tfTotal  : Result := Result + sqlItemPedidoJaFaturado;
        tfParcial: Result := Result + sqlItemPedidoFaturadoParcialmente;
      End;
    End
    Else
    Begin
      Case ATipFat Of
        tfTotal  : Result := Result + sqlPedidoJaFaturado;
        tfParcial: Result := Result + sqlPedidoFaturadoParcialmente;
      End;
    End;
  end;

  Result := Result + ') AS TMP ';
end;

function TGetSQLStatus.sqlFaturadoPDEntregue(ATipFat: TTipoFaturamento): String;
begin
  Result :=
    '  SELECT SQL_NO_CACHE COUNT(1) AS QTDE            '+
    '  FROM FATGOR FG                                '+
    '  JOIN EXTGOR EG ON FG.AUTOINCREM = EG.FGO_SEQFGO'+
    '  JOIN FATDOR FDO ON FDO.FDO_NUMDOC = FG.FGO_NUMDOC'+
    '                AND FDO.FDO_ESPDOC = FG.FGO_ESPDOC'+
    '                AND FDO.FDO_CODEMP = FG.FGO_CODEMP'+
    '                AND FDO.FDO_CODCLI = FG.FGO_CODCLI'+
    '                AND FDO.FDO_ENTFUT = "N"          '+
    '  JOIN EXTDOR ED ON FDO.AUTOINCREM = ED.FDO_SEQFDO'+
    '                AND ED.FDO_ENTRET = "E"         '+
    '  JOIN ROMDETX R ON FDO.FDO_NUMDOC = R.DET_NUMDOC'+
    '                 AND FDO.FDO_ESPDOC = R.DET_ESPDOC'+
    '                 AND FDO.FDO_CODEMP = R.DET_CODEMP'+
    '                 AND FDO.FDO_CODITE = R.DET_CODITE'+
    '  JOIN ROMGERX X ON R.DET_SEQGER = X.AUTOINCREM '+
    ' WHERE FG.FGO_NUMDOC = :NUMDOC                  '+
    '   AND FG.FGO_ESPDOC = :ESPDOC                  '+
    '   AND FG.FGO_CODEMP = :CODEMP                  '+
    '   AND (((IFNULL(FG.FGO_MOTBAI, "") = "") AND (EG.FGO_UTIPEN = "N")) OR ((IFNULL(FG.FGO_MOTBAI, "") <> "") AND (EG.FGO_UTIPEN = "S"))) '+
    '   AND IFNULL(X.GER_DTABAI, "") <> ""           ';

  If Self.FTipoStatus = statusItemPedido Then
  Begin
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';
    Case ATipFat Of
      tfTotal  : Result := Result + sqlItemPedidoJaFaturado;
      tfParcial: Result := Result + sqlItemPedidoFaturadoParcialmente;
    End;
  End
  Else
  Begin
    Case ATipFat Of
      tfTotal  : Result := Result + sqlPedidoJaFaturado;
      tfParcial: Result := Result + sqlPedidoFaturadoParcialmente;
    End;
  End;
end;

function TGetSQLStatus.sqlFaturadoNFEntregue(ATipFat: TTipoFaturamento): String;
begin
  Result :=
    'SELECT SQL_NO_CACHE SUM(TMP.QTDE) AS QTDE '+
    'FROM ( '+
    ' SELECT COUNT(1) AS QTDE                         '+
    ' FROM FATGOR FG                                  '+
    '  JOIN EXTGOR EG ON FG.AUTOINCREM = EG.FGO_SEQFGO'+
    '  JOIN FATDOR FDO ON FDO.FDO_NUMDOC = FG.FGO_NUMDOC'+
    '                AND FDO.FDO_ESPDOC = FG.FGO_ESPDOC'+
    '                AND FDO.FDO_CODEMP = FG.FGO_CODEMP'+
    '                AND FDO.FDO_CODCLI = FG.FGO_CODCLI'+
    '                AND FDO.FDO_ENTFUT = "N"          '+
    '  JOIN EXTDOR ED ON FDO.AUTOINCREM = ED.FDO_SEQFDO'+
    '                AND ED.FDO_ENTRET = "E"         '+
    '  JOIN MOVDET MD ON MD.DET_NUMDOC = FDO.FDO_NUMFAT'+
    '                AND MD.DET_ESPDOC = FDO.FDO_TIPFAT'+
    '                AND MD.DET_CODEMP = FDO.FDO_EMPFAT'+
    '                AND MD.DET_CODITE = FDO.FDO_CODITE'+
    '                AND MD.DET_CODCLI = FDO.FDO_CODCLI'+
    '  JOIN ROMDETX R ON MD.DET_NUMDOC = R.DET_NUMDOC'+
    '                AND MD.DET_ESPDOC = R.DET_ESPDOC'+
    '                AND MD.DET_SERIE_ = R.DET_SERIE_'+
    '                AND MD.DET_CODEMP = R.DET_CODEMP'+
    '                AND MD.DET_CODITE = R.DET_CODITE'+
    '                AND MD.DET_CODCLI = R.DET_CODCLI'+
    '  JOIN ROMGERX X ON R.DET_SEQGER = X.AUTOINCREM '+
    ' WHERE FG.FGO_NUMDOC = :NUMDOC                  '+
    '   AND FG.FGO_ESPDOC = :ESPDOC                  '+
    '   AND FG.FGO_CODEMP = :CODEMP                  '+
    '   AND (((IFNULL(FG.FGO_MOTBAI, "") = "") AND (EG.FGO_UTIPEN = "N")) OR ((IFNULL(FG.FGO_MOTBAI, "") <> "") AND (EG.FGO_UTIPEN = "S"))) ' +
    '   AND IFNULL(X.GER_DTABAI, "") <> ""           ';

  If Self.FTipoStatus = statusItemPedido Then
  Begin
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';
    Case ATipFat Of
      tfTotal  : Result := Result + sqlItemPedidoJaFaturado;
      tfParcial: Result := Result + sqlItemPedidoFaturadoParcialmente;
    End;
  End
  Else
  Begin
    Case ATipFat Of
      tfTotal  : Result := Result + sqlPedidoJaFaturado;
      tfParcial: Result := Result + sqlPedidoFaturadoParcialmente;
    End;
  End;

  if (fCfgSis('OPCROM', varString) = '3') then
  begin
    Result := Result +
      ' UNION '+

      ' SELECT COUNT(1) AS QTDE                           '+
      ' FROM FATGOR FG                                    '+
      ' JOIN EXTGOR EG  ON FG.AUTOINCREM = EG.FGO_SEQFGO  '+
      ' JOIN FATDOR FDO ON FDO.FDO_NUMDOC = FG.FGO_NUMDOC '+
      '                AND FDO.FDO_ESPDOC = FG.FGO_ESPDOC '+
      '                AND FDO.FDO_CODEMP = FG.FGO_CODEMP '+
      '                AND FDO.FDO_CODCLI = FG.FGO_CODCLI '+
      '                AND FDO.FDO_ENTFUT = "N"           '+
      ' JOIN EXTDOR ED  ON FDO.AUTOINCREM = ED.FDO_SEQFDO '+
      '                AND ED.FDO_ENTRET = "E"            '+
      ' JOIN MOVDET MD  ON MD.DET_NUMDOC = FDO.FDO_NUMFAT '+
      '                AND MD.DET_ESPDOC = FDO.FDO_TIPFAT '+
      '                AND MD.DET_CODEMP = FDO.FDO_EMPFAT '+
      '                AND MD.DET_CODITE = FDO.FDO_CODITE '+
      '                AND MD.DET_CODCLI = FDO.FDO_CODCLI '+
      ' JOIN CNFMNO C   ON MD.DET_NUMDOC = MNO_NUMFAT     '+
      '                AND MD.DET_ESPDOC = MNO_ESPFAT     '+
      '                AND MD.DET_CODEMP = MNO_EMPFAT     '+
      ' JOIN NOTDET ND  ON MNO_SEQGER = ND.DET_SEQGER     '+
      ' JOIN ROMDETX R  ON ND.DET_NUMDOC = R.DET_NUMDOC   '+
      '                AND ND.DET_ESPDOC = R.DET_ESPDOC   '+
      '                AND ND.DET_SERIE_ = R.DET_SERIE_   '+
      '                AND ND.DET_CODEMP = R.DET_CODEMP   '+
      '                AND ND.DET_CODITE = R.DET_CODITE   '+
      '                AND ND.DET_CODCLI = R.DET_CODCLI   '+
      ' JOIN ROMGERX X  ON R.DET_SEQGER = X.AUTOINCREM    '+
      ' WHERE FG.FGO_NUMDOC = :NUMDOC                     '+
      '   AND FG.FGO_ESPDOC = :ESPDOC                     '+
      '   AND FG.FGO_CODEMP = :CODEMP                     '+
      '   AND (((IFNULL(FG.FGO_MOTBAI, "") = "") AND (EG.FGO_UTIPEN = "N")) OR ((IFNULL(FG.FGO_MOTBAI, "") <> "") AND (EG.FGO_UTIPEN = "S"))) ' +
      '   AND IFNULL(X.GER_DTABAI, "") <> ""              ';

    If Self.FTipoStatus = statusItemPedido Then
    Begin
      Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';
      Case ATipFat Of
        tfTotal  : Result := Result + sqlItemPedidoJaFaturado;
        tfParcial: Result := Result + sqlItemPedidoFaturadoParcialmente;
      End;
    End
    Else
    Begin
      Case ATipFat Of
        tfTotal  : Result := Result + sqlPedidoJaFaturado;
        tfParcial: Result := Result + sqlPedidoFaturadoParcialmente;
      End;
    End;
  end;

  Result := Result + ') AS TMP ';
end;

function TGetSQLStatus.sqlPedidoNegado: String;
begin
  Result := '';

  Result := Result +
    ' SELECT                           '+
    '   COUNT(1) AS QTDE               '+
    ' FROM                             '+
    '   FATGOR F                       '+
    '   INNER JOIN EXTGOR E ON (E.FGO_SEQFGO = F.AUTOINCREM)    '+
    '   INNER JOIN NEGPED N ON (N.NPD_NUMDOC = F.FGO_NUMDOC AND '+
    '                           N.NPD_CODEMP = F.FGO_CODEMP AND '+
    '                           N.NPD_CODCLI = F.FGO_CODCLI)    ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result +
      '    JOIN FATDOR FDO ON FDO.FDO_NUMDOC = FGO_NUMDOC '+
      '                   AND FDO.FDO_ESPDOC = FGO_ESPDOC '+
      '                   AND FDO.FDO_CODEMP = FGO_CODEMP ';

  Result := Result +
    ' WHERE F.FGO_NUMDOC = :NUMDOC     '+
    '   AND F.FGO_ESPDOC = :ESPDOC     '+
    '   AND F.FGO_CODEMP = :CODEMP     '+
    '   AND E.FGO_ENVLIB = "N"         ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FDO.AUTOINCREM = :SEQFDO ';
end;

function TGetSQLStatus.sqlConferenciaAndamentoQuandoBaiSepDesligada: String;
begin
  Result := '';

  Result := Result +
    'SELECT SQL_NO_CACHE COUNT(1) AS QTDE            '+
    '  FROM                                          '+
    '  (                                             '+
    '  SELECT IF(SUM(FDO_QTDEXP) > 0 AND ((SUM(FDO_QTDITE) - SUM(FDO_QTDBAI)) > SUM(FDO_QTDEXP)), "S", "N") AS TEMEXP, ' +
    '         IF((SUM(FD.FDO_QTDITE) - SUM(FD.FDO_QTDBAI)) = SUM(IFNULL(ED.FDO_QTDSEP, 0)), "S", "N") AS SEPTOT ' +
    '    FROM FATGOR FG                              '+
    '    JOIN EXTGOR EG ON FG.AUTOINCREM = EG.FGO_SEQFGO'+
    '    JOIN FATDOR FD ON FD.FDO_NUMDOC = FG.FGO_NUMDOC'+
    '                  AND FD.FDO_ESPDOC = FG.FGO_ESPDOC'+
    '                  AND FD.FDO_CODEMP = FG.FGO_CODEMP'+
    '                  AND FD.FDO_CODCLI = FG.FGO_CODCLI'+
    '                  AND FD.FDO_JAFATU = 0         '+
    '    JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO'+
    '   WHERE FG.FGO_NUMDOC = :NUMDOC                '+
    '     AND FG.FGO_ESPDOC = :ESPDOC                '+
    '     AND FG.FGO_CODEMP = :CODEMP                '+
    '     AND EG.FGO_DTLBEX IS NULL                  '+
    '     AND EG.FGO_HRLBEX IS NULL                  ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FD.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '   GROUP BY FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP  '+
    '   ) TMP                                        '+
    '    WHERE TMP.TEMEXP = "S" AND TMP.SEPTOT = "S" ';
end;

function TGetSQLStatus.sqlEmSeparacaoUsandoConferenciaComBaiSepDesligado: String;
begin
  Result := '';

  Result := Result +
    ' SELECT SQL_NO_CACHE COUNT(1) AS QTDE            '+
    '  FROM                 '+
    '  (                    '+
    '  SELECT IF((SUM(FD.FDO_QTDITE) - SUM(FD.FDO_QTDBAI))'+
    '            = SUM(ED.FDO_QTDEXP), "S", "N") AS EXPTOT, '+
    '         IF((SUM(FD.FDO_QTDITE) - SUM(FD.FDO_QTDBAI))'+
    '            = SUM(IFNULL(ED.FDO_QTDSEP,0)), "S", "N") AS SEPTOT '+
    '    FROM FATGOR FG     '+
    '    JOIN FATDOR FD ON FD.FDO_NUMDOC = FG.FGO_NUMDOC'+
    '                  AND FD.FDO_ESPDOC = FG.FGO_ESPDOC'+
    '                  AND FD.FDO_CODEMP = FG.FGO_CODEMP'+
    '                  AND FD.FDO_CODCLI = FG.FGO_CODCLI'+
    '                  AND FD.FDO_JAFATU = 0         '+
    '    JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO'+
    '   WHERE FG.FGO_NUMDOC = :NUMDOC                '+
    '     AND FG.FGO_ESPDOC = :ESPDOC                '+
    '     AND FG.FGO_CODEMP = :CODEMP                '+
    '     AND IF(FG.FGO_SEPIMP = "N" OR IFNULL(FG.FGO_SEPIMP,"") = "",'+
    '           "0",        '+
    '           IF(FG.FGO_SEPIMP = "S",              '+
    '              "1",     '+
    '              FG.FGO_SEPIMP)) <> "0"            ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FD.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '   GROUP BY FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP  '+
    '   ) TMP               '+
    '  WHERE TMP.EXPTOT = "N" AND TMP.SEPTOT = "N" ';
end;

function TGetSQLStatus.sqlAguardandoConferenciaComBaiSepDesligado: String;
begin
  Result := '';

  Result := Result +
    'SELECT SQL_NO_CACHE COUNT(1) AS QTDE            '+
    '  FROM                                          '+
    '  (                                             '+
    '  SELECT IF(SUM(FDO_QTDEXP) > 0 AND ((SUM(FDO_QTDITE) - SUM(FDO_QTDBAI)) > SUM(FDO_QTDEXP)), "S", "N") AS TEMEXP, ' +
    '         IF((SUM(FD.FDO_QTDITE) - SUM(FD.FDO_QTDBAI)) = SUM(IFNULL(ED.FDO_QTDSEP,0)), "S", "N") AS SEPTOT ' +
    '    FROM FATGOR FG                              '+
    '    JOIN EXTGOR EG ON FG.AUTOINCREM = EG.FGO_SEQFGO'+
    '    JOIN FATDOR FD ON FD.FDO_NUMDOC = FG.FGO_NUMDOC'+
    '                  AND FD.FDO_ESPDOC = FG.FGO_ESPDOC'+
    '                  AND FD.FDO_CODEMP = FG.FGO_CODEMP'+
    '                  AND FD.FDO_CODCLI = FG.FGO_CODCLI'+
    '                  AND FD.FDO_JAFATU = 0         '+
    '    JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO'+
    '   WHERE FG.FGO_NUMDOC = :NUMDOC                '+
    '     AND FG.FGO_ESPDOC = :ESPDOC                '+
    '     AND FG.FGO_CODEMP = :CODEMP                '+
    '     AND EG.FGO_DTLBEX IS NULL                  '+
    '     AND EG.FGO_HRLBEX IS NULL                  ';

  If Self.FTipoStatus = statusItemPedido Then
    Result := Result + '   AND FD.AUTOINCREM = :SEQFDO ';

  Result := Result +
    '   GROUP BY FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP  '+
    '   ) TMP                                        '+
    '    WHERE TMP.SEPTOT = "S" AND TMP.TEMEXP = "N" ';
end;

{ TVerificarStatusSeparacaoConcluidaItem }

class function TVerificarStatusSeparacaoConcluidaItem.CheckStatus(ANumPed, AEspPed, AEmpPed,
  ACodIte: String): Boolean;
Var
  LQuery: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  Result := False;
  LQuery := fCriaQuery;
  Try
    LQuery.Close;

    If fCfgSis('BAISEP', varBoolean) Then
      LQuery.SQL.Add(sqlSeparacaoConcluidaBaiSep)
    Else
      LQuery.SQL.Add(sqlSeparacaoConcluida);

    LQuery.ParamByName('NUMDOC').AsString := ANumPed;
    LQuery.ParamByName('ESPDOC').AsString := AEspPed;
    LQuery.ParamByName('CODEMP').AsString := AEmpPed;

    LQuery.Open;

    While Not LQuery.Eof Do
    Begin
      If LQuery.FieldByName('CODITE').AsString.Equals(ACodIte) Then
        Exit(True);
      LQuery.Next;
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(LQuery);
{$ENDIF LINUX}
  End;
end;

class function TVerificarStatusSeparacaoConcluidaItem.sqlSeparacaoConcluida: String;
begin
  Result :=
    ' SELECT C.ITE_CODITE AS CODITE, C.ITE_DESITE AS DESITE, C.ITE_CODUNI AS CODUNI, SUM(QTDITE) AS QTDITE, "Separação concluída" AS STATUS '+
    ' FROM CADITE C '+
    ' INNER JOIN(  '+
    '   SELECT IF((SUM(FD.FDO_QTDITE) - SUM(FD.FDO_QTDBAI)) '+
    '             = SUM(ED.FDO_QTDEXP), "S", "N") AS EXPTOT, '+
    '          FD.FDO_CODITE AS CODITE, FD.FDO_QTDITE AS QTDITE '+
    '     FROM FATGOR FG '+
    '     JOIN FATDOR FD ON FD.FDO_NUMDOC = FG.FGO_NUMDOC '+
    '                   AND FD.FDO_ESPDOC = FG.FGO_ESPDOC '+
    '                   AND FD.FDO_CODEMP = FG.FGO_CODEMP '+
    '                   AND FD.FDO_CODCLI = FG.FGO_CODCLI '+
    '                   AND FD.FDO_JAFATU = 0 '+
    '     JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO  '+
    '      WHERE IF(FG.FGO_SEPIMP = "N" OR IFNULL(FG.FGO_SEPIMP,"") = "", '+
    '            "0", '+
    '            IF(FG.FGO_SEPIMP = "S", '+
    '               "1", '+
    '               FG.FGO_SEPIMP)) <> "0" '+
    '      AND FG.FGO_NUMDOC = :NUMDOC '+
    '      AND FG.FGO_ESPDOC = :ESPDOC '+
    '      AND FG.FGO_CODEMP = :CODEMP  '+
     '     AND (FD.FDO_QTDITE - IFNULL(FD.FDO_QTDBAI, 0) = IFNULL(ED.FDO_QTDSEP, 0)) '+
    '    GROUP BY FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP '+
    '    ) T '+
    '    ON(C.ITE_CODITE = T.CODITE) '+
    '   WHERE T.EXPTOT = "N"  '+
    '   GROUP BY CODITE, DESITE, CODUNI, STATUS ';
end;

class function TVerificarStatusSeparacaoConcluidaItem.sqlSeparacaoConcluidaBaiSep: String;
begin
  Result :=
    ' SELECT C.ITE_CODITE AS CODITE, C.ITE_DESITE AS DESITE, C.ITE_CODUNI AS CODUNI, SUM(QTDITE) AS QTDITE, "Separação concluída" AS STATUS '+
    ' FROM CADITE C '+
    ' INNER JOIN( '+
    '   SELECT FD.FDO_CODITE AS CODITE, FD.FDO_QTDITE AS QTDITE  '+
    '    FROM FATGOR FG  '+
    '    JOIN EXTGOR EG ON FG.AUTOINCREM = EG.FGO_SEQFGO '+
    '    JOIN FATDOR FD ON FG.AUTOINCREM = FD.FDO_SEQGER '+
    '    JOIN EXTDOR ED ON FD.AUTOINCREM = ED.FDO_SEQFDO '+
    '   WHERE EG.FGO_OPBXSE IS NULL '+
    '     AND EG.FGO_DTBXSE IS NULL '+
    '     AND EG.FGO_HRBXSE IS NULL '+
    '     AND FG.FGO_NUMDOC = :NUMDOC  '+
    '     AND FG.FGO_ESPDOC = :ESPDOC  '+
    '     AND FG.FGO_CODEMP = :CODEMP '+
    '     AND IF(FG.FGO_SEPIMP = "N" OR IFNULL(FG.FGO_SEPIMP,"") = "", '+
    '            "0", '+
    '            IF(FG.FGO_SEPIMP = "S", '+
    '               "1",  '+
    '               FG.FGO_SEPIMP)) <> "0" '+
    '     AND (FD.FDO_QTDITE - IFNULL(FD.FDO_QTDBAI, 0) = IFNULL(ED.FDO_QTDSEP, 0)) '+
    ' )T '+
    ' ON(C.ITE_CODITE = T.CODITE) '+
    ' GROUP BY CODITE, DESITE, CODUNI, STATUS ';
end;

initialization
  VS_blnUTIPEN := Null;
  VS_AltStaBigInt := '';

finalization
  If Assigned(TSituacaoPedidoVenda.FInstance) Then
    FreeAndNil(TSituacaoPedidoVenda.FInstance);

end.

