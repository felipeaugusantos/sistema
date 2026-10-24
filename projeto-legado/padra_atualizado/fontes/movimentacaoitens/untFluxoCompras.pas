unit untFluxoCompras;

interface

Uses
  System.Classes,
  System.Threading,
  Vcl.Controls,
  Vcl.ExtCtrls,
  System.Generics.Collections,
  System.SysUtils,
  Vcl.Buttons,
  BitBtnLockedIncrem,
  Math,
  Data.DB,
  cxGrid,
  cxGraphics,
  cxEditRepositoryItems,
  cxGridCustomTableView,
  cxGridBandedTableView,
  cxGridDBBandedTableView,
  cxGridCustomView,
  untEntradaSimplificada,
  untProcessoCompras,
  untZClient,
  dxScreenTip,
  cxClasses,
  dxCustomHint,
  cxHint,
  StrUtils,
  cxGridDBTableView,
  Uni,
  untRequisicaoPedidoCompra,
  untFuncoesPedidoSimples,
  untCadCotItensImpRequisicao
  ;

Type
  TTipoSituacaoCompra = (tscImportacaoXML, tscPreNota, tscConferencia, tscEntrada, tscLotePreco, tscEnderecamento);
  TTipoConferenciaEntrada = (tcPreNota = 1, tcPedidoCompra = 2, tcSenha = 3);

  TOperador = record
    strCodigo: String;
    dtaData: TDate;
    hraHora: TTime;
    blnStatus: Boolean;
  end;

  TFluxoCompras = Class
  const
    LARGURA_SCROLLBAR = 18;
  Private

    objEntradaSimplificada: TEntradaSimplificada;

    LimiteDias: integer;

    FTimerExecuta                      : TTimer; //temporário

    FEditRepositoryTextItem: TcxEditRepositoryTextItem;
    FEditRepositoryButtonVisibleCenter,
    FEditRepositoryButtonInvisibleCenter: TcxEditRepositoryButtonItem;

    FUtilizaDivergenciaFiscal        : boolean;
    FUtilizaConferenciaDepoisEntrada : boolean;
    FUtilizaPlanoRecebimento         : boolean;
    FUtilizaConferenciaAposPlano     : boolean;
    FUtilizaConferenciaEntrada       : boolean;
    FUtilizaPreNota                  : boolean;
    FTipoConferenciaEntrada          : TTipoConferenciaEntrada;
    FUtilizaEfetivacaoMvtoFiscal     : boolean;

    FProcessos                       : TObjectList<TProcessoCompras>;
    FCdsFluxo                        : TZClient;
    FCxgFluxo                        : TcxGrid;
    FCxgFluxoTBV                     : TcxGridDBBandedTableView;
    FUtilizaLotePreco                : boolean;
    FUtilizaEnderecamento            : boolean;
    FUtilizaDevolucaoPreNota         : boolean;

    FBtnCancelar                     : TBitBtnLocked;
    FHintControler                   : TcxHintStyleController;
    FTimerHint: TTimer;
    blnCOFEND: Boolean;
    Const
      STR_PEDIDOS = ' GROUP_CONCAT(DISTINCT CONCAT(PEL_NUMDOC, "-", PEL_ESPDOC, "-", PEL_CODEMP) SEPARATOR "\n") ';
    procedure cdsFluxoAfterScroll(DataSet: TDataSet);
    procedure pCarregaProcessos;
    procedure pCriaColunasCxgFluxo;

    Function fSQLEntradaSimplificada: String;
    function fUsaEfetvacaoFiscalEntradaSimpligicada: Boolean;
//    Function fSQLEntradaSimplificadaLotePrecos: String;

    function fSqlFluxo : String;
    procedure setCxgFluxo(const Value: TcxGrid);
    procedure cxgFluxoTBVCellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
    procedure cxgFluxoTBVKeyPress(Sender: TObject; var Key: Char);
    procedure cxgFluxoTBVMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure pExecutaTimer(Sender: TObject);

    Function fIndexColumnToProcesso(intItemIndex: Integer): Integer;
    procedure pHint(ACellViewInfo: TcxGridTableDataCellViewInfo);
    function fRetornarOperadorEfetivacao(
      tscTipoSituacao: TTipoSituacaoCompra): TOperador;
    function fUtilizarEfetivacaoMovimentoFiscal: Boolean;
  Public

    property blnUtilizaTratamentoCriticas       : boolean                       read FUtilizaDivergenciaFiscal                           ;
    property blnUtilizaConferenciaDepoisEntrada : boolean                       read FUtilizaConferenciaDepoisEntrada                    ;
    property blnUtilizaEfetivacaoMvtoFiscal     : boolean                       read FUtilizaEfetivacaoMvtoFiscal                        ;
    property blnUtilizaPlanoRecebimento         : boolean                       read FUtilizaPlanoRecebimento                            ;
    property blnUtilizaConferenciaAposPlano     : boolean                       read FUtilizaConferenciaAposPlano                        ;
    property blnUtilizaLotePreco                : boolean                       read FUtilizaLotePreco                                   ;
    property blnUtilizaEnderecamento            : boolean                       read FUtilizaEnderecamento                               ;
    property blnUtilizaDevolucaoPreNota         : boolean                       read FUtilizaDevolucaoPreNota                            ;
    property blnUtilizaConferenciaEntrada       : boolean                       read FUtilizaConferenciaEntrada                          ;
    property blnUtilizaPreNota                  : boolean                       read FUtilizaPreNota                                     ;
    property enuTipoConferenciaEntrada          : TTipoConferenciaEntrada       read FTipoConferenciaEntrada                             ;
    property lstProcessos                       : TObjectList<TProcessoCompras> read FProcessos                                          ;
    property cdsFluxo                           : TZClient                      read FCdsFluxo                                           ;
    property cxgFluxo                           : TcxGrid                       read FCxgFluxo                        write setCxgFluxo  ;
    property btnCancelar                        : TBitBtnLocked                 read FBtnCancelar                     write FBtnCancelar ;
    property HintControler                      : TcxHintStyleController        read FHintControler                   write FHintControler;
    property TimerHint                          : TTimer                        read FTimerHint                       write FTimerHint;
    procedure pAtualizaDados;
    procedure pImportaNota;
    procedure pCancelarProcesso;
    procedure pCarregaRequisicoes;
    constructor Create(AEditRepositoryButtonVisibleCenter,
                       AEditRepositoryButtonInvisibleCenter: TcxEditRepositoryButtonItem;
                       AEditRepositoryTextItem: TcxEditRepositoryTextItem);

    destructor Destroy; override;
    function fCriaTemporariaNotas: Boolean;

  End;


implementation

Uses
  untFuncoesSimples, untEntImportacaoNotaEletronica, untTypesSistema;


{ TFluxoCompras }


{ TFluxoCompras }

constructor TFluxoCompras.Create(AEditRepositoryButtonVisibleCenter,
                                 AEditRepositoryButtonInvisibleCenter: TcxEditRepositoryButtonItem;
                                 AEditRepositoryTextItem: TcxEditRepositoryTextItem);
begin
  FCxgFluxo    := nil;
  LimiteDias := fCfgSis('FLUCDI', varInteger);
  blnCOFEND := (fCfgSis('COFEND', varBoolean)) And (fCfgSis('TIPPNT', varString) = 'D');

  FCxgFluxoTBV := nil;
  FBtnCancelar := nil;

  objEntradaSimplificada := TEntradaSimplificada.Create(Nil);

  FEditRepositoryTextItem              := AEditRepositoryTextItem;
  FEditRepositoryButtonVisibleCenter   := AEditRepositoryButtonVisibleCenter;
  FEditRepositoryButtonInvisibleCenter := AEditRepositoryButtonInvisibleCenter;

  FUtilizaDivergenciaFiscal        := fCfgSis('XMLVAL', varInteger) =  2  ;
  FUtilizaConferenciaDepoisEntrada := fCfgSis('TIPPNT', varString)  = 'D' ;
  FUtilizaEfetivacaoMvtoFiscal     := fUtilizarEfetivacaoMovimentoFiscal;
  FUtilizaPlanoRecebimento         := fCfgSis('TPLREC', varString) <> 'N' ;
  FUtilizaConferenciaAposPlano     := fCfgSis('WMSPLA', varString)  = 'R' ;
  FUtilizaLotePreco                := fCfgSis('LOTPRE', varString)  = 'S' ;
  FUtilizaEnderecamento            := fUsaEnderecamento                   ;
  FUtilizaConferenciaEntrada       := fCfgSis('USACON', varString)  = 'S' ;
  FTipoConferenciaEntrada          := TTipoConferenciaEntrada(fCfgSis('CONFME', varInteger));

  FUtilizaPreNota                  := FUtilizaConferenciaEntrada and (FTipoConferenciaEntrada <> tcPedidoCompra);
  FUtilizaDevolucaoPreNota         := fUsaRotinaWMS And (fCfgSis('TIPPNT', varString) = 'D') And (fCfgSis('TPLREC', varString) <> 'N');

  FProcessos := TObjectList<TProcessoCompras>.Create;
  FCdsFluxo := TZClient.Create(nil, fSqlFluxo);

  FCdsFluxo.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

  FCdsFluxo.AfterScroll := cdsFluxoAfterScroll;

  FTimerExecuta := TTimer.Create(nil);
  FTimerExecuta.Enabled  := False;
  FTimerExecuta.Interval := 5;
  FTimerExecuta.OnTimer := pExecutaTimer;

  pCarregaProcessos;

end;

destructor TFluxoCompras.Destroy;
begin
  FreeAndNil(objEntradaSimplificada);
  FreeAndNil(FProcessos);
  FreeAndNil(FCdsFluxo);
  FreeAndNil(FTimerExecuta);
  inherited;
end;

function TFluxoCompras.fCriaTemporariaNotas: Boolean;
var qryCriaTemporaria: TUniQuery;
  strSQL,
  strQtdCon,
  strQtdTotAGEITE: String;
  blnFluPdc: Boolean;
begin
  blnFluPdc := fCfgSis('FLUPDC', varString) = 'S';
  strQtdCon := '';
  strQtdTotAGEITE := '';

  (* Quando esta configurado para utilizar o coletor de dados, so é permitido endereçar pedidos pelo autcom,
   quando o Movimento Fiscal esta efetivado (DET_DTAENT <> NULL) e Documentos não Planejados para Entrada e Conferencia
   via coletor (Documento não esta presente na Tabela AGEDOC.
   ----
   Sendo assim só será permitido o endereçamento de Devoluçoes, e esse endereçamento também poderá ser feito via coletor
  *)

  If FUtilizaDevolucaoPreNota Then
  Begin
    strQtdCon := 'IFNULL((SELECT SUM(DIG_QTDITE) FROM DIGELE WHERE DIG_IDEDIG = ARC_IDEDIG AND DIG_CODEMP = ARC_CODEMP), 0.00)';
    {necessário o subselect pois estava duplicando o valor quando era somente SUM(IFNULL(AIT_QTDTOT, 0)), isso ocorria quando o xml tinha dois pedidos vinculado na PEDELE}
    strQtdTotAGEITE := '(SELECT SUM(IFNULL(AIT_QTDTOT, 0) - IFNULL(AIT_DIVLIB, 0) ) FROM AGEITE WHERE AIT_SEQGER = AGEREC.AUTOINCREM ) ';
  End;

  strSQL := 'DROP TEMPORARY TABLE IF EXISTS TMP_FLUXO_NOTA;';
  strSQL := strSQL + 'CREATE TEMPORARY TABLE TMP_FLUXO_NOTA';

  strSQL := strSQL + ' SELECT   ';

  strSQL := strSQL + '   CAST(NULL AS UNSIGNED) AS TEM_PENDENCIA, ';

  strSQL := strSQL + ' (SELECT COUNT(1) FROM MOVDET ';
  strSQL := strSQL + '          INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  strSQL := strSQL + '          WHERE MOVDET.DET_SEQGER = MOVGER.AUTOINCREM ';
  strSQL := strSQL + '            AND DET_CLARET = 1) DET_CLARET, ';

  strSQL := strSQL + '  GERELE.GER_DTACON,             ';
  strSQL := strSQL + '  GERELE.GER_DOCENT,             ';
  strSQL := strSQL + '  GERELE.GER_ESPENT,             ';
  strSQL := strSQL + '  GERELE.GER_EMPENT,             ';
  strSQL := strSQL + '  GERELE.GER_CODEMP,             ';
  strSQL := strSQL + '  GERELE.GER_CODFOR,             ';
  strSQL := strSQL + '  GERELE.GER_TIP_FC,             ';

  strSQL := strSQL + '  MOVGER.GER_NUMDOC AS NUMDOC,   ';
  strSQL := strSQL + '  MOVGER.GER_ESPDOC AS ESPDOC,   ';
  strSQL := strSQL + '  MOVGER.GER_SERIE_ AS SERIE_,   ';
  strSQL := strSQL + '  MOVGER.GER_CODEMP AS CODEMP,   ';
  strSQL := strSQL + '  MOVGER.GER_CODFOR AS CODFOR,   ';
  strSQL := strSQL + '  MOVGER.GER_TIP_FC AS TIP_FC,   ';
  strSQL := strSQL + '  MOVGER.GER_DTAENT AS DTAENT,   ';
  strSQL := strSQL + '  MOVGER.AUTOINCREM AS AUTGER,   ';

  strSQL := strSQL + '  AGEDOC.ADC_SEQGER, ';
  strSQL := strSQL + '  ADC_CODEMP,                    ';
  strSQL := strSQL + '  A.AUX_ENTSIM,                  ';
  strSQL := strSQL + '  ENTDES.ENT_SEQENT,             ';

  strSQL := strSQL +     QuotedStr(STR_REG_GERAL) +  ' AS ' + TProcessoNotaFiscal.DATA_FIELD_NAME_TIPREG + ', ';

  If FUtilizaPlanoRecebimento Then
  Begin
    strSQL := strSQL + '   @DTAREC := ( SELECT DATE_FORMAT(ARC_DTAREC, "%d/%m/%Y") ';
    strSQL := strSQL + '                   FROM AGEREC ';
    strSQL := strSQL + '                  INNER JOIN AGEDOC ON  ADC_SEQGER = AGEREC.AUTOINCREM ';
    strSQL := strSQL + '                  WHERE ADC_NUMDOC = B08_NNF     ';
    strSQL := strSQL + '                    AND ADC_ESPDOC = GER_ESPDOC  ';
    strSQL := strSQL + '                    AND ADC_SERIE_ = B07_SERIE   ';
    strSQL := strSQL + '                    AND ADC_CODFOR = GERELE.GER_CODFOR  ';
    strSQL := strSQL + '                    AND ADC_CODEMP = GERELE.GER_CODEMP)                         AS '+ TProcessoDataRecebimentoMercadoria.DATA_FIELD_NAME +', ';
  End;

  strSQL := strSQL + '   GERELE.AUTOINCREM,                                                                                                                        ';
  strSQL := strSQL + '   "SEM DIVERGÊNCIA"      																										  AS '+ TProcessoDivergenciaFiscal.DATA_FIELD_NAME         +', ';
  strSQL := strSQL + '   "SEM PENDÊNCIA"                                                              AS '+ TProcessoDivergenciaFiscal.DATA_FIELD_NAME_PENDENCIA +', ';
  strSQL := strSQL + '   GERELE.B09_DEMI                                                              AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_DEMI +', ';
  strSQL := strSQL + '   DATEDIFF(IFNULL(@DTAREC, CURDATE()),GERELE.B09_DEMI)                         AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_DIATRA +', ';
  strSQL := strSQL + '   (SELECT DATE_FORMAT(DUP_DTAVEN, "%d/%m/%Y") FROM DUPELE ' +
                                  ' WHERE DUP_SEQELE = GERELE.AUTOINCREM ORDER BY AUTOINCREM LIMIT 1) AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_DVENC +', ';
  strSQL := strSQL + '   GERELE.W16_VNF                                                               AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_VNF +', ';

  strSQL := strSQL + '   B08_NNF                                                                      AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_NF             +', ';
  strSQL := strSQL + '   "NF"                                                                         AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_ESPECIE        +', ';
  strSQL := strSQL + '   IFNULL(B07_SERIE, "")                                                        AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_SERIE          +', ';

  strSQL := strSQL + '   (SELECT CONCAT(IF(LEFT(I08_CFOP, 1) = "5", "1", "2"), RIGHT(I08_CFOP, 3)) ';
  strSQL := strSQL + '    FROM DETELE WHERE DET_SEQGER = GERELE.AUTOINCREM LIMIT 1)                   AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_CFOP + ', ';

  strSQL := strSQL + '   IF(((SELECT COUNT(1) FROM CADEMP WHERE EMP_FORFIL = GERELE.GER_CODFOR) > 0),"T","C")                                 AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_TRANSF_COMPRA+ ', ';

  strSQL := strSQL + '   FOR_NOMFOR                                                                   AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_FORNECEDOR     +', ';

  strSQL := strSQL + '   IFNULL(GER_MATREV, FOR_MATREV)                                               AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_TIPFOR         +', ';

  if blnFluPdc Then
  begin
    strSQL := strSQL + '   CAST(';
    strSQL := strSQL + '        IF((IFNULL(GER_MATREV, FOR_MATREV) = "M"), ';
    strSQL := strSQL + '            IF((GER_ENTDIR = "N") AND (GER_DTALIB IS NULL AND GER_DTACON IS NOT NULL), "REALIZAR", "REALIZADO" ), ';
    strSQL := strSQL + '            IFNULL(' + STR_PEDIDOS + ', "REALIZAR")) AS CHAR(255)) AS '+ TProcessoPreNota.DATA_FIELD_NAME_PEDIDOS      +', ';
  end
  else
    strSQL := strSQL + '   CAST(IF(IFNULL(GER_MATREV, FOR_MATREV) = "M", "MATERIAL CONSUMO", IFNULL(' + STR_PEDIDOS + ', "REALIZAR")) AS CHAR(255)) AS '+ TProcessoPreNota.DATA_FIELD_NAME_PEDIDOS      +', ';

  strSQL := strSQL + '   IF(IFNULL(GERELE.GER_DOCENT, "") <> "", "REALIZADO", "REALIZAR")     		    AS '+ TProcessoEntradaMercadoria.DATA_FIELD_NAME         +', ';

  strSQL := strSQL + '   IF(IFNULL(GER_MATREV, FOR_MATREV) = "M" , "MATERIAL CONSUMO", ';
  strSQL := strSQL + '   IF((MOVGER.GER_DTAENT IS NOT NULL) OR ((IFNULL(GER_MATREV, FOR_MATREV) = "M") AND (IFNULL(GERELE.GER_DOCENT, "") = "")), "REALIZADO", IF(ENTDES.ENT_SEQENT IS NULL, "REALIZAR", "REALIZADO"))) AS '+ TProcessoEfetivacaoMovimentoFiscal.DATA_FIELD_NAME +', ';

  strSQL := strSQL + '  CAST(NULL AS CHAR(50)) AS ' + TProcessoConferenciaPreNota.DATA_FIELD_NAME + ', ';
  strSQL := strSQL + '  CAST(NULL AS CHAR(50)) AS ' + TProcessoLotePreco.DATA_FIELD_NAME + ', ';
  strSQL := strSQL + ' 	CAST(NULL AS CHAR(50)) AS ' + TProcessoEnderecamento.DATA_FIELD_NAME;

  If FUtilizaDevolucaoPreNota Then
  Begin
    strSQL := strSQL +  ',AGEITE.AIT_QTDTOT ';
    strSQL := strSQL +  ',@TEM_FILKAR_0 := ((SELECT COUNT(1) FROM MOVDET WHERE DET_FILKAR = 0 AND DET_SEQGER = MOVGER.AUTOINCREM) > 0) AS TEM_FILKAR_0 ';
    strSQL := strSQL +  ', IF( IFNULL(GER_MATREV, FOR_MATREV) = "M", "MAT. CONSUMO", IF(IFNULL(AIT_QTDTOT,0)=0 ,IF(@TEM_FILKAR_0, "PENDENTE", "REALIZADO"),IF(SUM(IFNULL(AIT_QTDDEV,0))>0,"REALIZADO",IF('+strQtdCon+ ' < '+ strQtdTotAGEITE + ' ';
    strSQL := strSQL +  ',IF(@TEM_FILKAR_0, "PENDENTE", "REALIZADO"),"REALIZADO"))))  AS ' + TProcessoDevolucaoPreNota.DATA_FIELD_NAME;
  End;

  strSQL := strSQL + ' FROM                                                                                                                                        ';
  strSQL := strSQL + '   GERELE                                                                                                                                    ';

  strSQL := strSQL + '   LEFT JOIN MOVGER ON MOVGER.GER_NUMDOC = GERELE.GER_DOCENT                                                                                 ';
  strSQL := strSQL + ' 									 AND MOVGER.GER_ESPDOC = GERELE.GER_ESPENT                                                                                 ';
  strSQL := strSQL + ' 									 AND MOVGER.GER_CODEMP = GERELE.GER_EMPENT                                                                                 ';
  strSQL := strSQL + ' 									 AND IFNULL(MOVGER.GER_SERIE_, "") = IFNULL(GERELE.B07_SERIE, "") ';
  strSQL := strSQL + ' 									 AND MOVGER.GER_CODFOR = GERELE.GER_CODFOR                                                                                 ';

  strSQL := strSQL + ' 	 LEFT JOIN ENTDES ON ENT_SEQENT = MOVGER.AUTOINCREM                                                                                         ';
  strSQL := strSQL + '   LEFT JOIN AUXMOV A ON A.AUX_SEQGER = MOVGER.AUTOINCREM  ';

  strSQL := strSQL + '   LEFT JOIN PEDELE ON PEDELE.PEL_SEQELE = GERELE.AUTOINCREM                                                                                 ';
  strSQL := strSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = GERELE.GER_CODFOR                                                                                        ';

  strSQL := strSQL + '   LEFT JOIN AGEDOC ON ADC_CODEMP = MOVGER.GER_CODEMP                                                                                        ';
  strSQL := strSQL + '                   AND ADC_CODFOR = MOVGER.GER_CODFOR                                                                                        ';
  strSQL := strSQL + '                   AND ADC_ESPDOC = MOVGER.GER_ESPDOC                                                                                        ';
  strSQL := strSQL + '                   AND ADC_NUMDOC = MOVGER.GER_NUMDOC                                                                                        ';

  If FUtilizaDevolucaoPreNota Then
  Begin
    strSQL := strSQL + '   LEFT JOIN AGEREC ON ADC_SEQGER = AGEREC.AUTOINCREM                                                                                        ';
    strSQL := strSQL + '   LEFT JOIN AGEITE ON AIT_SEQGER = AGEREC.AUTOINCREM                                                                                        ';
  End;

  strSQL := strSQL + '                                                                                                                                             ';
  strSQL := strSQL + ' WHERE GERELE.GER_TIPXML = 0                                                                                                                 ';
  strSQL := strSQL + '   AND GERELE.GER_CODEMP = "'+VS_StrCodEmp+'"';
  If LimiteDias > 0 Then
    strSQL := strSQL + '   AND GERELE.B09_DEMI > DATE_SUB(CURDATE(), INTERVAL '+LimiteDias.ToString+' DAY)';
  strSQL := strSQL + '   AND ((IFNULL(GER_MATREV, FOR_MATREV) <> "M") OR (IFNULL(GERELE.GER_DOCENT, "") = ""))                                                                         ';

  strSQL := strSQL + '                                                                                                                                             ';
  strSQL := strSQL + ' GROUP BY                                                                                                                                    ';
  strSQL := strSQL + ' 		GERELE.AUTOINCREM;                                                                                                                        ';
  strSQL := strSQL + '                                                                                                                                             ';

  strSQL := strSQL + ' UPDATE TMP_FLUXO_NOTA                               ';
  strSQL := strSQL + ' SET                                                 ';

  strSQL := strSQL +   TProcessoConferenciaPreNota.DATA_FIELD_NAME + ' = ';

  strSQL := strSQL + '   IF(' + TProcessoNotaFiscal.DATA_FIELD_NAME_TIPFOR + ' = "M", ';
  strSQL := strSQL + '      "MAT. CONSUMO", ';
  strSQL := strSQL + '      IF(DET_CLARET > 0, ';
  strSQL := strSQL + '         "REALIZADO", ';
  strSQL := strSQL + '         IF((GER_DTACON IS NOT NULL) OR ((' + TProcessoNotaFiscal.DATA_FIELD_NAME_TIPFOR + ' = "M") AND (IFNULL(GER_DOCENT, "") = "")), ';
  strSQL := strSQL + '            "VISUALIZAR", ';
  strSQL := strSQL + '            IF(ENT_SEQENT IS NULL, "REALIZAR", "REALIZADO")))), ';

  strSQL := strSQL +   TProcessoLotePreco.DATA_FIELD_NAME + ' =  ';

  strSQL := strSQL + '   IF(' + TProcessoNotaFiscal.DATA_FIELD_NAME_TIPFOR + ' = "M" , "MAT. CONSUMO", ';

  strSQL := strSQL + '      IF(DET_CLARET > 0, "REALIZADO", ';

  If fExigeConferenciaQuandoConfiguradoConferenciaDepoisEntrada Then
    strSQL := strSQL + '   IF((((DTAENT IS NOT NULL) AND (IFNULL(AUX_ENTSIM, "") <> "S")                                                                            '
  Else
    strSQL := strSQL + '   IF((((AUTGER IS NOT NULL) AND (IFNULL(AUX_ENTSIM, "") <> "S")                                                                            ';

  strSQL := strSQL + '      AND (SELECT                                                                                                                            ';
  strSQL := strSQL + ' 						COUNT(*)                                                                                                                         ';
  strSQL := strSQL + ' 					FROM                                                                                                                               ';
  strSQL := strSQL + ' 						LOTPRE                                                                                                                           ';
  strSQL := strSQL + ' 					WHERE LOTPRE.LTP_NUMDOC = GER_DOCENT                                                                                        ';
  strSQL := strSQL + ' 						AND LOTPRE.LTP_ESPDOC = GER_ESPENT                                                                                        ';
  strSQL := strSQL + ' 						AND LOTPRE.LTP_CODEMP = GER_EMPENT                                                                                        ';
  strSQL := strSQL + ' 						AND IFNULL(LOTPRE.LTP_SERIE_, "") = ' + TProcessoNotaFiscal.DATA_FIELD_NAME_SERIE;
  strSQL := strSQL + ' 						AND LOTPRE.LTP_CODFOR = GER_CODFOR                                                                                        ';
  strSQL := strSQL + ' 						AND LTP_BAIXAD = "N") = 0 )) OR (' + TProcessoNotaFiscal.DATA_FIELD_NAME_TIPFOR + ' = "M"), "REALIZADO", ';

  If fCfgSis('ANTCON', VarBoolean) Then
  Begin
    // AINDA NÃO INCLUIU O LOTE
    strSQL := strSQL + ' IF( (IFNULL(AUX_ENTSIM, "") <> "S") AND                                                                                             ';
    strSQL := strSQL + '     (SELECT                                                                                                                           ';
    strSQL := strSQL + ' 	    COUNT(*)                                                                                                                         ';
    strSQL := strSQL + ' 		FROM                                                                                                                               ';
    strSQL := strSQL + ' 		 LOTPRE                                                                                                                            ';
    strSQL := strSQL + ' 					WHERE LOTPRE.LTP_NUMDOC = GER_DOCENT                                                                                  ';
    strSQL := strSQL + ' 						AND LOTPRE.LTP_ESPDOC = GER_ESPENT                                                                                  ';
    strSQL := strSQL + ' 						AND LOTPRE.LTP_CODEMP = GER_EMPENT                                                                                  ';
    strSQL := strSQL + ' 						AND IFNULL(LOTPRE.LTP_SERIE_, "") = ' + TProcessoNotaFiscal.DATA_FIELD_NAME_SERIE;
    strSQL := strSQL + ' 						AND LOTPRE.LTP_CODFOR = GER_CODFOR) = 0    ';

    strSQL := strSQL + ' 	OR   ';

    // TEM LOTE PARA EFETIVAR
    strSQL := strSQL + '    (SELECT                                                                                                                            ';
    strSQL := strSQL + ' 	    COUNT(*)                                                                                                                         ';
    strSQL := strSQL + ' 		FROM                                                                                                                               ';
    strSQL := strSQL + ' 		 LOTPRE                                                                                                                            ';
    strSQL := strSQL + ' 					WHERE LOTPRE.LTP_NUMDOC = GER_DOCENT                                                                                  ';
    strSQL := strSQL + ' 						AND LOTPRE.LTP_ESPDOC = GER_ESPENT                                                                                  ';
    strSQL := strSQL + ' 						AND LOTPRE.LTP_CODEMP = GER_EMPENT                                                                                  ';
    strSQL := strSQL + ' 						AND IFNULL(LOTPRE.LTP_SERIE_, "") = ' + TProcessoNotaFiscal.DATA_FIELD_NAME_SERIE;
    strSQL := strSQL + ' 						AND LOTPRE.LTP_CODFOR = GER_CODFOR                                                                                  ';
    strSQL := strSQL + ' 						AND LTP_BAIXAD = "N") > 0,   ';

    strSQL := strSQL + '      "REALIZAR", "REALIZADO") ';

  End ELSE
  Begin
    strSQL := strSQL + '      "REALIZAR"';
  End;

  strSQL := strSQL + '  ))), ';

  strSQL := strSQL + TProcessoEnderecamento.DATA_FIELD_NAME + ' = ';

  strSQL := strSQL + '   IF(' + TProcessoNotaFiscal.DATA_FIELD_NAME_TIPFOR + ' = "M" , "MAT. CONSUMO", ';
  strSQL := strSQL + '      IF(DET_CLARET > 0, "REALIZADO", ';

  strSQL := strSQL + '   IF( (DTAENT IS NOT NULL) AND (ADC_CODEMP IS NOT NULL)  AND  ';
  strSQL := strSQL + '        ((SELECT COUNT(*) FROM EXTGOR INNER JOIN FATDOR ON FDO_SEQGER = FGO_SEQFGO WHERE FGO_DOCEND IS NOT NULL AND ';

  If fCfgSis('SPCDEN', varBoolean) Then
  Begin
    strSQL := strSQL + '  FGO_DCENUM = NUMDOC ';
    strSQL := strSQL + '      AND FGO_DCEESP = ESPDOC ';
    strSQL := strSQL + '      AND FGO_DCESER = IFNULL(SERIE_, "") ';
    strSQL := strSQL + '      AND FGO_DCEEMP = CODEMP ';
    strSQL := strSQL + '      AND FGO_DCEFOR = CODFOR ';
    strSQL := strSQL + '      AND FGO_DCETFC = TIP_FC ';
  End
  Else
    strSQL := strSQL + '  FGO_DOCEND = CONCAT(NUMDOC, ESPDOC, RPAD(IFNULL(SERIE_, ""),3," "), CODEMP, CODFOR, TIP_FC) ';

  strSQL := strSQL + ' AND FDO_QTDBAI > 0) > 0)                                                                                     ';
  strSQL := strSQL + '   , "INICIADO PELO COLETOR",                                                                                                                ';


  strSQL := strSQL + '   IF((((DTAENT IS NOT NULL)                                                                                                      ';
  strSQL := strSQL + '      AND (SELECT                                                                                                                            ';
  strSQL := strSQL + ' 						COUNT(*)                                                                                                                         ';
  strSQL := strSQL + ' 					FROM                                                                                                                               ';
  strSQL := strSQL + ' 						EXTGOR                                                                                                                           ';
  strSQL := strSQL + ' 					WHERE FGO_DOCEND IS NOT NULL                                                                                                       ';

  If  fCfgSis('SPCDEN', varBoolean) Then
  Begin
    strSQL := strSQL + ' 	AND FGO_DCENUM = ' + TProcessoNotaFiscal.DATA_FIELD_NAME_NF;
    strSQL := strSQL + ' 	AND FGO_DCEESP IN ("NF","PD")	';
    strSQL := strSQL + ' 	AND FGO_DCESER = ' + TProcessoNotaFiscal.DATA_FIELD_NAME_SERIE;
    strSQL := strSQL + ' 	AND FGO_DCEEMP = GER_CODEMP ';
    strSQL := strSQL + ' 	AND FGO_DCEFOR = GER_CODFOR ';
    strSQL := strSQL + ' 	AND FGO_DCETFC = GER_TIP_FC ';
  End
  Else
  begin
    strSQL := strSQL + ' 					  AND SUBSTRING(FGO_DOCEND, 01, 12)  = ' + TProcessoNotaFiscal.DATA_FIELD_NAME_NF;
    strSQL := strSQL + ' 						AND TRIM(SUBSTRING(FGO_DOCEND, 15, 03)) = ' + TProcessoNotaFiscal.DATA_FIELD_NAME_SERIE;
    strSQL := strSQL + ' 						AND TRIM(SUBSTRING(FGO_DOCEND, 18, 03)) = GER_CODEMP                                                                      ';
    strSQL := strSQL + ' 						AND TRIM(SUBSTRING(FGO_DOCEND, 21, 08))	= GER_CODFOR ';
  End;

  strSQL := strSQL + ' 	) = 0 )) OR (' + TProcessoNotaFiscal.DATA_FIELD_NAME_TIPFOR + ' = "M"), "REALIZADO", IF(ENT_SEQENT IS NULL, "REALIZAR", "REALIZADO"))))), ';

  strSQL := strSQL + '   TEM_PENDENCIA = IF((';
  strSQL := strSQL + '     (ENTRADA_MERCADORIA = "REALIZAR")';
  strSQL := strSQL + '     OR (';
  strSQL := strSQL + '       EFETIVACAO_MOVIMENTO_FISCAL = "REALIZAR"';
  strSQL := strSQL + '     )';

  If FUtilizaLotePreco Then
    strSQL := strSQL + '     OR (LOTE_PRECO = "REALIZAR")';

  strSQL := strSQL + '     OR (ENDERECAMENTO IN ("REALIZAR", "INICIADO PELO COLETOR"))';
  If FUtilizaDevolucaoPreNota Then

    strSQL := strSQL + '     OR (DEV_PRE_NOTA = "PENDENTE")';
  strSQL := strSQL + '   ), 1 ,0);                                                 ';

  strSQL := strSQL + 'ALTER TABLE `TMP_FLUXO_NOTA` ADD KEY `IDX_TEM_PENDENCIA` (`TEM_PENDENCIA`);';

  qryCriaTemporaria := fCriaQuery;
  Try
    Try
      qryCriaTemporaria.SQL.Add(strSQL);
      qryCriaTemporaria.ExecSQL;

  	  Result := True;

    Finally
      FreeAndNil(qryCriaTemporaria);
    End;
  Except
    on e: Exception do
    begin
      Result := False;
      pMensagensErro(e.message, 'Teste Citel');
    end;
  End;
End;

function TFluxoCompras.fSqlFluxo: String;
begin



  Result := 'SELECT ';
  Result := Result + ' DET_CLARET ,';
  Result := Result + ' ADC_SEQGER,  ';
  Result := Result + TProcessoNotaFiscal.DATA_FIELD_NAME_TIPREG + ', ';
  If FUtilizaPlanoRecebimento Then
  Begin
       Result := Result + TProcessoDataRecebimentoMercadoria.DATA_FIELD_NAME +', ';
  End;

  Result := Result + '   AUTOINCREM,  ';
  Result := Result + TProcessoDivergenciaFiscal.DATA_FIELD_NAME         +', ';
  Result := Result + TProcessoDivergenciaFiscal.DATA_FIELD_NAME_PENDENCIA +', ';
  Result := Result + TProcessoNotaFiscal.DATA_FIELD_NAME_DEMI +', ';
  Result := Result + TProcessoNotaFiscal.DATA_FIELD_NAME_DIATRA +', ';
  Result := Result + TProcessoNotaFiscal.DATA_FIELD_NAME_DVENC +', ';
  Result := Result + TProcessoNotaFiscal.DATA_FIELD_NAME_VNF +', ';

  Result := Result + TProcessoNotaFiscal.DATA_FIELD_NAME_NF             +', ';
  Result := Result + TProcessoNotaFiscal.DATA_FIELD_NAME_ESPECIE        +', ';
  Result := Result + TProcessoNotaFiscal.DATA_FIELD_NAME_SERIE          +', ';

  Result := Result + TProcessoNotaFiscal.DATA_FIELD_NAME_CFOP + ', ';

  Result := Result + TProcessoNotaFiscal.DATA_FIELD_NAME_TRANSF_COMPRA+ ', ';

  Result := Result + TProcessoNotaFiscal.DATA_FIELD_NAME_FORNECEDOR     +', ';

  Result := Result + TProcessoNotaFiscal.DATA_FIELD_NAME_TIPFOR         +', ';

  Result := Result + TProcessoPreNota.DATA_FIELD_NAME_PEDIDOS      +', ';

  Result := Result + TProcessoEntradaMercadoria.DATA_FIELD_NAME         +', ';

  Result := Result + TProcessoConferenciaPreNota.DATA_FIELD_NAME        +', ';

  Result := Result + TProcessoEfetivacaoMovimentoFiscal.DATA_FIELD_NAME +', ';

  Result := Result + TProcessoLotePreco.DATA_FIELD_NAME           + ', ';

  Result := Result + TProcessoEnderecamento.DATA_FIELD_NAME;

  If FUtilizaDevolucaoPreNota Then
    Result := Result + ', ' + TProcessoDevolucaoPreNota.DATA_FIELD_NAME + '  ';

  Result := Result + ' FROM TMP_FLUXO_NOTA WHERE TEM_PENDENCIA = 1 ';

  Result := Result + ' UNION ALL                                                                                                                            ';

  Result := Result +   fSQLEntradaSimplificada;


  Result := Result + ' UNION ALL                                                                                                                                   ';
  Result := Result + '                                                                                                                                             ';
  Result := Result + ' SELECT                                                                                                                                      ';
  Result := Result + '   0 AS DET_CLARET, ';
  Result := Result + '   "" AS ADC_SEQGER,  ';
  Result := Result +     QuotedStr(STR_REG_DIVERGENCIA)             +  ' AS ' + TProcessoNotaFiscal.DATA_FIELD_NAME_TIPREG + ', ';
  If FUtilizaPlanoRecebimento Then
    Result := Result + '   @DTAREC := NULL                                 AS ' + TProcessoDataRecebimentoMercadoria.DATA_FIELD_NAME         +',';
  Result := Result + '   X.AUTOINCREM,                                                                                                                               ';
  Result := Result + '   CONCAT(XML_NUMDOC, "-", "NF", "-", XML_SERIE_)  AS '+ TProcessoDivergenciaFiscal.DATA_FIELD_NAME         +',                              ';
  Result := Result + '   (SELECT IF(COUNT(*) > 0, "COM PENDÊNCIA", "SEM PENDÊNCIA") FROM VALPEN WHERE VAL_AUTXML = X.AUTOINCREM) AS '+ TProcessoDivergenciaFiscal.DATA_FIELD_NAME_PENDENCIA +', ';
  Result := Result + '   CAST(NULL AS DATE)                              AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_DEMI +', ';
  Result := Result + '   NULL                                            AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_DIATRA +', ';
  Result := Result + '   CAST(NULL AS DATE)                              AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_DVENC +', ';
  Result := Result + '   0                                               AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_VNF +', ';

  Result := Result + '   CAST(NULL AS CHAR(20))                          AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_NF             +', ';
  Result := Result + '   CAST(NULL AS CHAR(03))                          AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_ESPECIE        +', ';
  Result := Result + '   CAST(NULL AS CHAR(03))                          AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_SERIE          +', ';
  Result := Result + '   CAST(NULL AS CHAR(05))                          AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_CFOP + ', ';
  Result := Result + '   CAST(NULL AS CHAR(01))                          AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_TRANSF_COMPRA + ', ';
  Result := Result + '   FOR_NOMFOR                                      AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_FORNECEDOR     +', ';
  Result := Result + '   FOR_MATREV                                      AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_TIPFOR         +', ';

  Result := Result + '   CAST(NULL AS CHAR(20))                          AS '+ TProcessoPreNota.DATA_FIELD_NAME_PEDIDOS           +',                              ';

  Result := Result + '   "REALIZAR"                                      AS '+ TProcessoConferenciaPreNota.DATA_FIELD_NAME        +',                              ';
  Result := Result + '   "REALIZAR"                                      AS '+ TProcessoEntradaMercadoria.DATA_FIELD_NAME         +',                              ';
  Result := Result + '   "REALIZAR"                                      AS '+ TProcessoEfetivacaoMovimentoFiscal.DATA_FIELD_NAME +',                              ';
  Result := Result + '   "REALIZAR"                                      AS '+ TProcessoLotePreco.DATA_FIELD_NAME                 +',                              ';
  Result := Result + '   "REALIZAR" 			                               AS '+ TProcessoEnderecamento.DATA_FIELD_NAME             ;
  if FUtilizaDevolucaoPreNota Then
    Result := Result + ', ' + '   "PENDENTE" 			                               AS '+ TProcessoDevolucaoPreNota.DATA_FIELD_NAME          ;
  Result := Result + ' FROM                                                                                                                                        ';
  Result := Result + ' 	 XMLVAL X                                                                                                                                    ';

  Result := Result + ' INNER JOIN CADFOR ON FOR_CODFOR = XML_CODFOR ';
  Result := Result + ' WHERE XML_CODEMP = :CODEMP                                                                                                                  ';

  Result := Result + ' ORDER BY                                                                                                                                    ';
  Result := Result + '   DIVERGENCIA_FISCAL DESC, ' + TProcessoNotaFiscal.DATA_FIELD_NAME_NF;
end;

Function TFluxoCompras.fSQLEntradaSimplificada: String;
Begin
  Result := '';
  Result := Result + ' SELECT  ';
  Result := Result + '   0 AS DET_CLARET, ';
  Result := Result + '   "" AS ADC_SEQGER,  ';
  Result := Result +     QuotedStr(STR_REG_ENTRADA_SIMP) +  ' AS ' + TProcessoNotaFiscal.DATA_FIELD_NAME_TIPREG + ', ';

  If FUtilizaPlanoRecebimento Then
    Result := Result + '  @DTAREC := NULL AS ' + TProcessoDataRecebimentoMercadoria.DATA_FIELD_NAME + ', ';

  Result := Result + '   IF( TEM_EFETIVACAO_FISCAL <> "", TEM_EFETIVACAO_FISCAL, IF(TEM_ENDERE <> "", TEM_ENDERE, IF(TEM_LOTPRE <> "", TEM_LOTPRE, ES.AUTOINCREM))) AS AUTOINCREM,   ';  // AUTOINCREM DO MOVGER
  Result := Result + '   "SEM DIVERGÊNCIA"                AS ' + TProcessoDivergenciaFiscal.DATA_FIELD_NAME         + ', ';
  Result := Result + '   "SEM PENDÊNCIA"                  AS ' + TProcessoDivergenciaFiscal.DATA_FIELD_NAME_PENDENCIA +', ';
  Result := Result + '   CAST(NULL AS DATE)               AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_DEMI +', ';
  Result := Result + '   NULL                             AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_DIATRA +', ';
  Result := Result + '   CAST(NULL AS DATE)               AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_DVENC +', ';
  Result := Result + '   0                                AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_VNF +', ';
  Result := Result + '   ES.GER_NUMDOC                    AS ' + TProcessoNotaFiscal.DATA_FIELD_NAME_NF             + ', ';
  Result := Result + '   ES.GER_ESPDOC                    AS ' + TProcessoNotaFiscal.DATA_FIELD_NAME_ESPECIE        + ', ';
  Result := Result + '   IFNULL(ES.GER_SERIE_, "")        AS ' + TProcessoNotaFiscal.DATA_FIELD_NAME_SERIE          + ', ';
  Result := Result + '   IF(LENGTH(ES.GER_CLAFIS) = 4, CONCAT(IF(LEFT(ES.GER_CLAFIS, 1) = "5", "1", "2"), RIGHT(ES.GER_CLAFIS, 3)), "") AS ' + TProcessoNotaFiscal.DATA_FIELD_NAME_CFOP           + ', ';

  Result := Result + '   "T" AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_TRANSF_COMPRA+ ', ';

  Result := Result + '   IFNULL(FD.FOR_NOMFOR, IFNULL(F.FOR_NOMFOR, CLI_NOMCLI)) AS ' + TProcessoNotaFiscal.DATA_FIELD_NAME_FORNECEDOR     + ', ';
  Result := Result + '   "SIMPLIFICADA"                   AS ' + TProcessoNotaFiscal.DATA_FIELD_NAME_TIPFOR         + ', ';

  Result := Result + '  CONCAT(PCG_NUMPED, "-", PCG_ESPDOC, "-", PCG_CODEMP) AS ' + TProcessoPreNota.DATA_FIELD_NAME_PEDIDOS           + ', ';

  If (fCfgSis('CONSIM', varString) = 'C') Or (fCfgSis('EMSRCS', varBoolean)) Then
  Begin
    if fCfgSis('EMSRCS', varBoolean) then
    begin
      Result := Result + '   IF(PCG_BAIXAD = 0, "REALIZAR", "REALIZADO")                  AS ' + TProcessoEntradaMercadoria.DATA_FIELD_NAME         + ', ';
      Result := Result + '   IF(PCG_BAIXAD = 1 AND TEM_CONFERENCIA <> "", "REALIZAR", "ENT. SIMPLIFIC.")                  AS ' + TProcessoConferenciaPreNota.DATA_FIELD_NAME        + ', ';
    end
    else
    begin
      Result := Result + '   IF(PCG_BAIXAD = 0, "ENTRADA SIMPLIFICADA", "REALIZADO")         AS ' + TProcessoEntradaMercadoria.DATA_FIELD_NAME         + ', ';
      Result := Result + '   IF(PCG_BAIXAD = 0, "REALIZAR", "REALIZADO")                     AS ' + TProcessoConferenciaPreNota.DATA_FIELD_NAME        + ', ';
    end;
  End Else
  Begin
    Result := Result + '   IF(PCG_BAIXAD = 0, "REALIZAR", "REALIZADO")                     AS ' + TProcessoEntradaMercadoria.DATA_FIELD_NAME         + ', ';
    Result := Result + '   IF(PCG_BAIXAD = 0, "ENT. SIMPLIFIC.", "REALIZADO")              AS ' + TProcessoConferenciaPreNota.DATA_FIELD_NAME        + ', ';
  End;

  If  fUsaEfetvacaoFiscalEntradaSimpligicada Then
    Result := Result + '   IF(TEM_EFETIVACAO_FISCAL <> "", "REALIZAR", "REALIZADO")           AS ' + TProcessoEfetivacaoMovimentoFiscal.DATA_FIELD_NAME + ', '
  Else
    Result := Result + '   IF(PCG_BAIXAD = 0, "ENT. SIMPLIFIC.", "REALIZADO")           AS ' + TProcessoEfetivacaoMovimentoFiscal.DATA_FIELD_NAME + ', ';

  If fCfgSis('LOTSIM') = 'S' Then
  Begin
    Result := Result + ' IF( (PCG_BAIXAD > 0 AND TEM_LOTPRE <> ""),  "REALIZAR", "ENT. SIMPLIFIC." ) AS ' + TProcessoLotePreco.DATA_FIELD_NAME + ', ';
  End Else
  Begin
    Result := Result + '   IF(TEM_LOTPRE <> "", "REALIZAR", "ENT. SIMPLIFIC.")    	        AS ' + TProcessoLotePreco.DATA_FIELD_NAME  + ', ';
  End;

  Result := Result + '   IF(PCG_BAIXAD > 0 AND TEM_ENDERE <> "", "REALIZAR", "ENT. SIMPLIFIC.")                AS ' + TProcessoEnderecamento.DATA_FIELD_NAME;

  if FUtilizaDevolucaoPreNota Then
    Result := Result + ', ' + '   "PENDENTE" 			                               AS '+ TProcessoDevolucaoPreNota.DATA_FIELD_NAME;

  Result := Result + '  FROM (                                                                                   ';
  Result := Result +      objEntradaSimplificada.fGetSql(False, True);
  Result := Result + ' ) AS ES                                                                                   ';

  Result := Result + '  LEFT JOIN CADFOR F ON F.FOR_CODFOR = ES.GER_CODFOR                                        ';
  Result := Result + '  LEFT JOIN CADCLI C ON C.CLI_CODCLI = ES.GER_CODCLI                                        ';
  Result := Result + '  LEFT JOIN CADFOR FD ON FD.FOR_CODFOR = ES.PCG_CODFOR                                      ';
  Result := Result + '  WHERE ((PCG_BAIXAD = 0) OR ((TEM_LOTPRE <> "") OR (TEM_ENDERE <> "") OR (TEM_EFETIVACAO_FISCAL <> "") OR (TEM_CONFERENCIA <> "")))  '
End;

{
Function TFluxoCompras.fSQLEntradaSimplificadaLotePrecos: String;
Begin
  Result := '';
  Result := Result + ' SELECT                                                                                    ';
  Result := Result + ' (SELECT COUNT(1) FROM MOVDET ';
  Result := Result + '          INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  Result := Result + '          WHERE MOVDET.DET_SEQGER = G.AUTOINCREM ';
  Result := Result + '            AND DET_CLARET = 1) DET_CLARET, ';
  Result := Result +     QuotedStr(STR_REG_LOTE_SIMP) + ' AS ' + TProcessoNotaFiscal.DATA_FIELD_NAME_TIPREG + ', ';

  Result := Result + '    @DTAREC := NULL   AS '+ TProcessoDataRecebimentoMercadoria.DATA_FIELD_NAME +', ';

  Result := Result + '   G.AUTOINCREM,                                                                                   ';  // AUTOINCREM DO MOVGER
  Result := Result + '   "SEM DIVERGÊNCIA"                AS ' + TProcessoDivergenciaFiscal.DATA_FIELD_NAME         + ', ';
  Result := Result + '   "SEM PENDÊNCIA"                  AS ' + TProcessoDivergenciaFiscal.DATA_FIELD_NAME_PENDENCIA +', ';
  Result := Result + '   CAST(NULL AS DATE)               AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_DEMI +', ';
  Result := Result + '   NULL                             AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_DIATRA +', ';
  Result := Result + '   CAST(NULL AS DATE)               AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_DVENC +', ';
  Result := Result + '   0                                AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_VNF +', ';

  Result := Result + '   L.LTP_NUMDOC                     AS ' + TProcessoNotaFiscal.DATA_FIELD_NAME_NF             + ', ';
  Result := Result + '   L.LTP_ESPDOC                     AS ' + TProcessoNotaFiscal.DATA_FIELD_NAME_ESPECIE        + ', ';
  Result := Result + '   IFNULL(L.LTP_SERIE_, "")         AS ' + TProcessoNotaFiscal.DATA_FIELD_NAME_SERIE          + ', ';

  Result := Result + '   G.GER_CLAFIS                     AS ' + TProcessoNotaFiscal.DATA_FIELD_NAME_CFOP           + ', ';
  Result := Result + '   IF(L.LTP_ESPDOC IN( "TE","NF"),"T","C")                                 AS '+ TProcessoNotaFiscal.DATA_FIELD_NAME_TRANSF_COMPRA+ ', ';
  Result := Result + '   F.FOR_NOMFOR                     AS ' + TProcessoNotaFiscal.DATA_FIELD_NAME_FORNECEDOR     + ', ';
  Result := Result + '   "SIMPLIFICADA"                   AS ' + TProcessoNotaFiscal.DATA_FIELD_NAME_TIPFOR         + ', ';

  Result := Result + '   "ENT. SIMPLIFIC."                AS ' + TProcessoPreNota.DATA_FIELD_NAME_PEDIDOS           + ', ';

  Result := Result + '   "REALIZADO"                      AS ' + TProcessoEntradaMercadoria.DATA_FIELD_NAME         + ', ';

  Result := Result + '   "ENT. SIMPLIFIC"                 AS ' + TProcessoConferenciaPreNota.DATA_FIELD_NAME        + ', ';

  Result := Result + '   "ENTRADA SIMPLIFICADA"           AS ' + TProcessoEfetivacaoMovimentoFiscal.DATA_FIELD_NAME + ', ';

  Result := Result + '   "REALIZAR"                       AS ' + TProcessoLotePreco.DATA_FIELD_NAME + ', ';

  Result := Result + '   "ENT. SIMPLIFIC."                AS ' + TProcessoEnderecamento.DATA_FIELD_NAME             + ' ';


  Result := Result + ' FROM                                                                                  ';
  Result := Result + '   LOTPRE L  ';

  Result := Result + ' INNER JOIN MOVDET D ON D.AUTOINCREM = L.LTP_SEQDET  ';

  Result := Result + ' INNER JOIN MOVGER G ON G.AUTOINCREM = D.DET_SEQGER  ';

  Result := Result + ' INNER JOIN AUXMOV A ON A.AUX_SEQGER = G.AUTOINCREM  ';

  Result := Result + ' INNER JOIN CADFOR F ON F.FOR_CODFOR = G.GER_CODFOR   ';

  Result := Result  + ' WHERE ';

  Result := Result  + '       A.AUX_ENTSIM = "S" ';
  Result := Result  + '   AND G.GER_DTAENT IS NOT NULL ';
  Result := Result  + '   AND	L.LTP_BAIXAD = "N" ';
  Result := Result  + '   AND	L.LTP_ESPDOC <> "TE" ';

  If Not (fCfgSis('EMPGER', varBoolean) And fCfgSis('LOTGER', varBoolean)) Then
    Result := Result + ' 	AND L.LTP_CODEMP = "' + VS_strCodEmp + '" ';

  Result := Result + ' GROUP BY ';
  Result := Result + ' 	 D.DET_NUMDOC, ';
  Result := Result + ' 	 D.DET_ESPDOC, ';
  Result := Result + ' 	 D.DET_SERIE_, ';
  Result := Result + ' 	 D.DET_CODFOR, ';
  Result := Result + ' 	 D.DET_CODEMP  ';
End;
}

procedure TFluxoCompras.pCarregaProcessos;
var
  i : integer;
begin

  if FUtilizaDivergenciaFiscal then
    FProcessos.Add( TProcessoDivergenciaFiscal.Create() );

  FProcessos.Add( TProcessoNotaFiscal.Create() );

  if FUtilizaPreNota then
    FProcessos.Add( TProcessoPreNota.Create()    );

  if FUtilizaConferenciaDepoisEntrada then
  begin
    FProcessos.Add( TProcessoEntradaMercadoria.Create() );

    if FUtilizaPreNota then
    begin
      If FUtilizaPlanoRecebimento Then
        FProcessos.Add( TProcessoDataRecebimentoMercadoria.Create() );
      FProcessos.Add( TProcessoConferenciaPreNota.Create() );
      If FUtilizaEfetivacaoMvtoFiscal Then
        FProcessos.Add( TProcessoEfetivacaoMovimentoFiscal.Create() );
    end;
  end
  else
  begin
    If FUtilizaPlanoRecebimento Then
      FProcessos.Add( TProcessoDataRecebimentoMercadoria.Create() );
    if FUtilizaPreNota then
      FProcessos.Add( TProcessoConferenciaPreNota.Create() );
    FProcessos.Add( TProcessoEntradaMercadoria.Create() );
  end;

  if FUtilizaLotePreco then
    FProcessos.Add( TProcessoLotePreco.Create() );

  if FUtilizaEnderecamento then
    FProcessos.Add( TProcessoEnderecamento.Create() );

  if FUtilizaDevolucaoPreNota Then
    FProcessos.Add( TProcessoDevolucaoPreNota.Create() );


  for i := 0 to FProcessos.Count - 1 do
  begin
    FProcessos[i].objComum.OnAposRealizar := pAtualizaDados;

    FProcessos[i].cxEditRepositoryButtonVisibleCenter   := FEditRepositoryButtonVisibleCenter;
    FProcessos[i].cxEditRepositoryButtonInvisibleCenter := FEditRepositoryButtonInvisibleCenter;
    FProcessos[i].cxEditRepositoryTextItem              := FEditRepositoryTextItem;

    if i > 0 then
      FProcessos[i].objComum.objProcessoComumAnterior := FProcessos[i -1].objComum;

    if i < (FProcessos.Count - 1) then
      FProcessos[i].objComum.objProcessoComumSeguinte := FProcessos[i +1].objComum;
  end;

end;

procedure TFluxoCompras.pCarregaRequisicoes;
Var
  objRequisicao: TRequisicaoPedidoCompra;
  recDadGiro: TRecOpcoesGiro;
begin
  inherited;
  If (Not fVerificaAcessoSistema('FLXRQC', strLoginUsuarioLogado)) Then
  Begin
    fMensagem('', 'Usuário sem permissão de acesso!', ['&O k']);
    Exit;
  End;


  FillChar(recDadGiro, SizeOf(recDadGiro), #0);

  recDadGiro.blnConsPedVen := True;
  recDadGiro.blnConsGarPen := True;
  recDadGiro.blnConsOrdPro := True;

  recDadGiro.strNomFrm := 'frmFluxoComprasView';

  objRequisicao := TRequisicaoPedidoCompra.Create;
  Try
    objRequisicao.FstrNumPed := cdsFluxo.FieldByName('NUMERO_DOCUMENTO').AsString;
    objRequisicao.FstrEspDoc := cdsFluxo.FieldByName('TIPO_DOCUMENTO').AsString;
    objRequisicao.FstrCodEmp := VS_strCodEmp;

    objRequisicao.fCarregaRequisicoes('', recDadGiro);

    pCriarFormularios(TfrmCadCotItensImpRequisicao, frmCadCotItensImpRequisicao);
    Try
      frmCadCotItensImpRequisicao.objRequisicao := objRequisicao;
      frmCadCotItensImpRequisicao.ShowModal;
    Finally
      pFreeAndNil(frmCadCotItensImpRequisicao);
    End;
  Finally
    pFreeAndNil(objRequisicao);
  End;
end;

procedure TFluxoCompras.pCriaColunasCxgFluxo;
var
  i : integer;
  cxBand: TcxGridBand;
begin
  if not Assigned(FCxgFluxoTBV) then
    exit;

  for i := 0 to FProcessos.Count - 1 do
  begin
    cxBand := FCxgFluxoTBV.Bands.Add;
    cxBand.Caption := FProcessos[i].objComum.strTitulo;

    FProcessos[i].pConfiguraColumn(FCxgFluxoTBV, cxBand.Index);
  end;

end;

procedure TFluxoCompras.pAtualizaDados();
var
  strAutoincrem : String;
begin
  FCdsFluxo.DisableControls;
  Try

    if FCdsFluxo.Active and (not FCdsFluxo.isEmpty) then
      strAutoincrem := FCdsFluxo.FieldByName('AUTOINCREM').AsString;

    FcdsFluxo.Close;
    FcdsFluxo.qryQuery.Close;
    fCriaTemporariaNotas;
    FcdsFluxo.fAbreClient(True, 'TfrmFluxoProcessoCompras.pAtualizaDados()',  False, True);

    if not FCdsFluxo.Locate('AUTOINCREM', strAutoincrem, []) then
      FCdsFluxo.First;

  finally
    FCdsFluxo.EnableControls;
  end;

end;

procedure TFluxoCompras.setCxgFluxo(const Value: TcxGrid);
begin
  FCxgFluxo    := Value;
  FCxgFluxoTBV := (FCxgFluxo.ActiveView as TcxGridDBBandedTableView);

  FCxgFluxoTBV.OptionsData.Appending        := False;
  FCxgFluxoTBV.OptionsData.CancelOnExit     := False;
  FCxgFluxoTBV.OptionsData.Deleting         := False;
  FCxgFluxoTBV.OptionsData.Editing          := False;
  FCxgFluxoTBV.OptionsData.Inserting        := False;
  FCxgFluxoTBV.OptionsView.HeaderAutoHeight := True;
  FCxgFluxoTBV.OptionsView.CellAutoHeight   := True;
  FCxgFluxoTBV.OptionsView.GroupByBox       := False;
  FCxgFluxoTBV.OptionsView.Footer           := True;
  FCxgFluxoTBV.DataController.DataSource    := FCdsFluxo.dtsSource;

  FCxgFluxoTBV.OnCellClick                  := cxgFluxoTBVCellClick;
  FCxgFluxoTBV.OnKeyPress                   := cxgFluxoTBVKeyPress;
  FCxgFluxoTBV.OnMouseMove                  := cxgFluxoTBVMouseMove;

  pCriaColunasCxgFluxo;
end;

procedure  TFluxoCompras.cxgFluxoTBVMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  AGridSite : TcxGridSite;
  AGridView : TcxGridDBBandedTableView;
  AHitTest  : TcxCustomGridHitTest;
  i : integer;
begin
  if (Sender is TcxGridSite) then
  begin
    AGridSite := Sender as TcxGridSite;
    AGridView := AGridSite.GridView as TcxGridDBBandedTableView;
    if (AGridView.IsControlLocked or AGridView.IsUpdateLocked or AGridView.IsLoading or AGridView.IsDesigning) then
      exit;

    AHitTest  := AGridView.GetHitTest(X, Y);

    if (AHitTest is TcxGridRecordCellHitTest) then
    begin
      i := fIndexColumnToProcesso((AHitTest as TcxGridRecordCellHitTest).Item.Index);

      if (i >= 0) and (i < FProcessos.Count) then
        FProcessos[i].objComum.pMouseMove(AGridSite, X, Y);
    end;
  end;

end;

procedure TFluxoCompras.cxgFluxoTBVCellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  if AButton = TMouseButton.mbRight then
  Begin
    pHint(ACellViewInfo);
  End
  Else If (ACellViewInfo.GridRecord.IsData) and (ACellViewInfo.GridRecord.Index >= 0) then
    FTimerExecuta.Enabled := True;
end;

procedure TFluxoCompras.cxgFluxoTBVKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    FTimerExecuta.Enabled := True;
end;

Function TFluxoCompras.fIndexColumnToProcesso(intItemIndex: Integer): Integer;
Begin

  Result := FCxgFluxoTBV.Columns[intItemIndex].Position.BandIndex;
End;

procedure TFluxoCompras.pExecutaTimer(Sender : TObject);
  Var
    intProcesso: Integer;
begin
  FTimerExecuta.Enabled := False;

  if (FProcessos.Count > 0) and (not FCdsFluxo.isEmpty) then
  begin
    try

      intProcesso := fIndexColumnToProcesso(FCxgFluxoTBV.Controller.FocusedColumn.Index);

      If FProcessos[intProcesso].objComum.fColunaSoDisplay(FCxgFluxoTBV.Controller.FocusedColumn.Index) Then
        Exit;

      If (FProcessos[intProcesso].tprTipoProcesso In [tprConferenciaPreNota]) And
         (FCdsFluxo.FieldByName('TIPFOR').AsString = 'M') Then
        Exit;

      If (FProcessos[intProcesso].tprTipoProcesso <> tprDivergenciaFiscal) And
         (FCdsFluxo.FieldByName('TIPREG').AsString = STR_REG_DIVERGENCIA) Then
        Exit;
      If (FProcessos[intProcesso].tprTipoProcesso = tprEnderecamento) and
         (FCdsFluxo.FieldByName('ADC_SEQGER').AsString <> '') and
         (FUtilizaDevolucaoPreNota) then
      begin
        pMensagemOK('Processo deve ser realizado pelo coletor de dados!');
        Exit;
      end;

      FProcessos[intProcesso].objComum.
        pExecuta(FCdsFluxo.FieldByName(FProcessos[intProcesso].objComum.stlDataFieldName[0].strFieldName).AsString,
                 FCdsFluxo.FieldByName('AUTOINCREM').AsString,
                 FCdsFluxo.FieldByName('TIPFOR').AsString,
                 FCdsFluxo.FieldByName('TIPREG').AsString,
                 TcxGridDBBandedColumn(FCxgFluxoTBV.Controller.FocusedColumn).DataBinding.FieldName,
                 FCdsFluxo.FieldByName('DET_CLARET').AsString);
    Except
      On E: ExceptionMessage do
        pMensagemOK(E.Message);
    end;
  end;

end;

procedure TFluxoCompras.pImportaNota();
begin
  TfrmEntImportacaoNotaEletronica.fImportar(xmlEntradaMercadoria);
  pAtualizaDados();
end;

procedure TFluxoCompras.cdsFluxoAfterScroll(DataSet: TDataSet);
var
  objProcesso : TProcessoCompras;
begin
  if not Assigned(FBtnCancelar) then
    exit;

  for objProcesso in FProcessos do
  begin
    if objProcesso.objComum.fPodeCancelar(DataSet.Fields) then
    begin
      FBtnCancelar.Caption := '[F6] - Cancelar ' + objProcesso.objComum.strTitulo;
      FBtnCancelar.Width := 200;
      FBtnCancelar.Visible := True;
      exit;
    end;
  end;

  FBtnCancelar.Visible := False;
end;

procedure TFluxoCompras.pCancelarProcesso;
var
  objProcesso : TProcessoCompras;
begin
  try
    for objProcesso in FProcessos do
    begin
      if objProcesso.objComum.fPodeCancelar(FCdsFluxo.Fields) then
      begin
        objProcesso.objComum.pCancelar(FCdsFluxo.FieldByName('AUTOINCREM').AsString);
        pAtualizaDados();
        break;
      end;
    end;
  except
    On E: ExceptionMessage do
        pMensagemOK(E.Message);
  end;

end;

procedure TFluxoCompras.pHint(ACellViewInfo: TcxGridTableDataCellViewInfo);
Var
  objDescricao: TStringBuilder;
  strFieldName: String;
  strNome: String;
  strImportacaoXML,
  strPreNota,
  strConferencia,
  strEntrada,
  strLotePreco,
  strEnderecamento,
  strDevolucaoPreNota: String;
  blnSituacao: Boolean;
  objOperador: TOperador;
  intIndex: Integer;
  strValor: String;
begin
  inherited;
  FHintControler.HideHint;
  strFieldName := TcxGridDBColumn(ACellViewInfo.Item).DataBinding.Field.FieldName;

  strImportacaoXML :=  TProcessoNotaFiscal.DATA_FIELD_NAME_NF;
  strPreNota := TProcessoPreNota.DATA_FIELD_NAME_PEDIDOS;
  strConferencia := TProcessoConferenciaPreNota.DATA_FIELD_NAME;
  strEntrada := TProcessoEntradaMercadoria.DATA_FIELD_NAME;
  strLotePreco := TProcessoLotePreco.DATA_FIELD_NAME;
  strEnderecamento := TProcessoEnderecamento.DATA_FIELD_NAME;
  strDevolucaoPreNota := TProcessoDevolucaoPreNota.DATA_FIELD_NAME;

  strValor := TcxGridDBColumn(ACellViewInfo.Item).DataBinding.Field.AsString;
  blnSituacao := strValor <> 'REALIZAR';

  intIndex := AnsiIndexStr(strFieldName,[strImportacaoXML, strPreNota, strConferencia, strEntrada, strLotePreco, strEnderecamento]);
  objOperador := fRetornarOperadorEfetivacao(TTipoSituacaoCompra(intIndex));

  if blnSituacao then
    blnSituacao := objOperador.blnStatus;

  if blnSituacao then
  Begin
    objOperador := fRetornarOperadorEfetivacao(TTipoSituacaoCompra(intIndex));
    objDescricao := TStringBuilder.Create;
    Try
      strNome := fRetNomeOperador(objOperador.strCodigo);
      objDescricao.
        Append('OPERADOR: ').
          Append(objOperador.strCodigo).
          Append(' - ').
          Append(strNome).
        AppendLine.
          Append('DATA: ').
          Append(FormatDateTime('dd/mm/yyyy', objOperador.dtaData)).
        AppendLine.
          Append('HORA: ').
          Append(FormatDateTime('hh:nn', objOperador.hraHora) );
      FHintControler.ShowHint(Mouse.CursorPos.X,Mouse.CursorPos.Y,'', objDescricao.ToString);
      FTimerHint.Enabled := true;
    Finally
      FreeAndNil(objDescricao);
    End;
  End;
End;


function TFluxoCompras.fRetornarOperadorEfetivacao(tscTipoSituacao: TTipoSituacaoCompra): TOperador;
Var
  qryGenerica: TUniQuery;
Begin
  qryGenerica := fCriaQuery;
  Try
    qryGenerica.SQL.Add('SELECT ');
    qryGenerica.SQL.Add('  GERELE.AUTOINCREM,');
    qryGenerica.SQL.Add('  CASE ');
    qryGenerica.SQL.Add('    TIPCPO.TIPCPO ');
    qryGenerica.SQL.Add('    WHEN 0 THEN GERELE.GER_OPELIB ');
    qryGenerica.SQL.Add('    WHEN 1 THEN GERELE.GER_OPELIB ');
    qryGenerica.SQL.Add('    WHEN 2 THEN GERELE.GER_OPECON ');
    qryGenerica.SQL.Add('    WHEN 3 THEN MOVGER.GER_CODVEN ');
    qryGenerica.SQL.Add('    WHEN 4 THEN LOTPRE.LTP_OPEEFE ');
    qryGenerica.SQL.Add('    WHEN 5 THEN DEL_EXTGOR.OPEDEL ');
    qryGenerica.SQL.Add('  END CODOPE,');
    qryGenerica.SQL.Add('  CASE');
    qryGenerica.SQL.Add('    TIPCPO.TIPCPO ');
    qryGenerica.SQL.Add('    WHEN 0 THEN GERELE.GER_DTAIMP ');
    qryGenerica.SQL.Add('    WHEN 1 THEN GERELE.GER_DTALIB ');
    qryGenerica.SQL.Add('    WHEN 2 THEN GERELE.GER_DTACON ');
    qryGenerica.SQL.Add('    WHEN 3 THEN MOVGER.GER_DTAENT ');
    qryGenerica.SQL.Add('    WHEN 4 THEN LOTPRE.LTP_DTAEFE ');
    qryGenerica.SQL.Add('    WHEN 5 THEN DEL_EXTGOR.DTADEL ');
    qryGenerica.SQL.Add('  END DTAOPE,');
    qryGenerica.SQL.Add('  CASE');
    qryGenerica.SQL.Add('    TIPCPO.TIPCPO ');
    qryGenerica.SQL.Add('    WHEN 0 THEN GERELE.GER_HORLIB ');
    qryGenerica.SQL.Add('    WHEN 1 THEN GERELE.GER_HORLIB ');
    qryGenerica.SQL.Add('    WHEN 2 THEN GERELE.GER_HORCON ');
    qryGenerica.SQL.Add('    WHEN 3 THEN MOVGER.GER_HORENT ');
    qryGenerica.SQL.Add('    WHEN 4 THEN LOTPRE.LTP_HOREFE ');
    qryGenerica.SQL.Add('    WHEN 5 THEN DEL_EXTGOR.HORDEL');
    qryGenerica.SQL.Add('  END HRAOPE');
    qryGenerica.SQL.Add(' FROM');
    qryGenerica.SQL.Add('  GERELE');
    qryGenerica.SQL.Add('  JOIN (SELECT :TIPCPO TIPCPO) TIPCPO ON TRUE');
    qryGenerica.SQL.Add('  LEFT JOIN MOVGER ');
    qryGenerica.SQL.Add('    ON MOVGER.GER_NUMDOC = GERELE.GER_DOCENT ');
    qryGenerica.SQL.Add('    AND MOVGER.GER_ESPDOC = GERELE.GER_ESPENT ');
    qryGenerica.SQL.Add('    AND MOVGER.GER_CODEMP = GERELE.GER_EMPENT ');
    qryGenerica.SQL.Add('    AND IFNULL(MOVGER.GER_SERIE_, "") = IFNULL(GERELE.B07_SERIE, "") ');
    qryGenerica.SQL.Add('    AND MOVGER.GER_CODFOR = GERELE.GER_CODFOR ');
    qryGenerica.SQL.Add('    AND TIPCPO = 3');
    qryGenerica.SQL.Add('  LEFT JOIN LOTPRE ');
    qryGenerica.SQL.Add('    ON LOTPRE.LTP_NUMDOC = GERELE.GER_DOCENT ');
    qryGenerica.SQL.Add('    AND LOTPRE.LTP_ESPDOC = GERELE.GER_ESPENT ');
    qryGenerica.SQL.Add('    AND LOTPRE.LTP_CODEMP = GERELE.GER_EMPENT ');
    qryGenerica.SQL.Add('    AND IFNULL(LOTPRE.LTP_SERIE_, "") = IFNULL(GERELE.B07_SERIE, "") ');
    qryGenerica.SQL.Add('    AND LOTPRE.LTP_CODFOR = GERELE.GER_CODFOR ');
    qryGenerica.SQL.Add('    AND TIPCPO = 4');
    qryGenerica.SQL.Add('  LEFT JOIN DEL_EXTGOR ');
    qryGenerica.SQL.Add('    ON DEL_EXTGOR.FGO_DOCEND IS NOT NULL ');
    qryGenerica.SQL.Add('    AND SUBSTRING(DEL_EXTGOR.FGO_DOCEND, 01, 12) = GERELE.B08_NNF ');
    qryGenerica.SQL.Add('    AND TRIM(SUBSTRING(DEL_EXTGOR.FGO_DOCEND, 15, 03)) = IFNULL(GERELE.B07_SERIE, "") ');
    qryGenerica.SQL.Add('    AND TRIM(SUBSTRING(DEL_EXTGOR.FGO_DOCEND, 18, 03)) = GERELE.GER_CODEMP ');
    qryGenerica.SQL.Add('    AND TRIM(SUBSTRING(DEL_EXTGOR.FGO_DOCEND, 21, 08)) = GERELE.GER_CODFOR ');
    qryGenerica.SQL.Add('    AND TIPCPO = 5');
    qryGenerica.SQL.Add('  WHERE GERELE.AUTOINCREM = :AUTOINCREM');
    qryGenerica.ParamByName('TIPCPO').AsInteger := integer(tscTipoSituacao);
    qryGenerica.ParamByName('AUTOINCREM').AsString := cdsFluxo.FieldByName('AUTOINCREM').AsString;
    qryGenerica.Open;

    Result.blnStatus := Not qryGenerica.FieldByName('DTAOPE').IsNull;
    if Result.blnStatus then
    Begin
      Result.strCodigo := qryGenerica.FieldByName('CODOPE').AsString;
      Result.dtaData := qryGenerica.FieldByName('DTAOPE').AsDateTime;
      Result.hraHora := qryGenerica.FieldByName('HRAOPE').AsDateTime;
    End;
  Finally
    FreeAndNil(qryGenerica);
  End;
End;

function TFluxoCompras.fUsaEfetvacaoFiscalEntradaSimpligicada: Boolean;
Begin
  If fUsaRotinaWMS Then
  Begin
    If fConferenciaDepoisDaEntrada And (fCfgSis('TPLREC', varString) <> 'N') Then
      Result := False
    Else
      Result := True;
  End
  Else
    Result := fConferenciaDepoisDaEntrada;
End;

function TFluxoCompras.fUtilizarEfetivacaoMovimentoFiscal: Boolean;
begin
  Result := True;
  If fUsaRotinaWMS and (fConferenciaDepoisDaEntrada And (fCfgSis('TPLREC', varString) <> 'N')) Then
    Result := False
  Else If (Not fUsaRotinaWMS) And (Not fConferenciaDepoisDaEntrada) Then
    Result := False;
end;

end.
