unit untEntConfPreNotaFuncoes;

interface

uses DBClient, untFuncoesSimples, sysUtils, Classes, EditFocus, untTypesSistema,
  StdCtrls, untConstantes, UniClientDataSet, Uni, TypesRel, Data.DB, DateUtils,
  StrUtils, untLiberacao, untMsgLiberacao, untFuncoesRel,untEntPreNotaEntradaMotivoLib, untZClient,
  untTDistribuicaoConferencia;

type
  TConferePreNota = class
  private
    { private declarations }
    FcdsConsulta: TUniClientDataSet;
    blnGeraDigEleAutomatica: Boolean;
    strCodIteAtu: String;
    strCodGruAtu: String;
    FTipoDigitacao: String; //Informa se foi digitado manualmente ou leitor "B"=> Bipando "C"=> Manual

    intTabPre: Integer;
    function fGetSQLEmbalagemEntradaMercadorias: String;
    procedure pMarcaInicioConferencia(stlIncNfe: TStringList);
    function fConferenciaIniciada(stlIncNfe: TStringList): boolean;
    function fVerificarDivergencia(cdsCriticas: TUniClientDataSet;qryNotEle: TUniQuery;
                                   edtNotEle, edtCodFor: TEditFocus; Var strOpeCfr: string): Boolean;
    function fUtilizaAgendamentoRecebimento(opcTipoOperacao : TipoOperacaoPreNota = opeConferencia): boolean;
    procedure pAtualizaQtdTotalItem(ACdsDados: TUniClientDataSet; AStrCodIte: String; AFltQtdTotal: Double);
  protected
    { protected declarations }
  public
    { public declarations }
    FstlIncNfe: TStringList;
    blnCofEnd: Boolean;
    strNumDoc: String;
    dtaDtaDoc: TDate;
    strSerDoc: String;
    strOpeLib: String;
    strDiverge: String;
    strCdiFor: String;
    ObjDistribuicaoConferencia: TDistribuicaoConferencia;
    dtaFisDtaEnt: TDate;
    strSeqFgo: String;
    strCodFor: string;
    strIdeDig: String;
    strDocume: String;
    strIncrem: String;
    strAutoincremGERELE : String;
    tpeEtique: TTipoEtiqueta;
    blnGravou: boolean;

    strCtlEst: String;

    strCodDig : String;
    blnPedCompraGarantia : Boolean;
    blnConferenciaIniciada: Boolean;
    blnTrazItensGrid: Boolean;

    Constructor Create;

    Function fRetAutoIncEntrada(strAutGerEle: String): String;

    function fGetSqlPrincipal(blnLike: Boolean): String;
    function fGetSqlConfer(blnLike: Boolean; opcTipoOperacao : TipoOperacaoPreNota = opeConferencia): String;
    function fValidaPedidoSelec(cdsPedidos: TUniClientDataSet; strForSel: String): Boolean;
    function fRegistraItem(blnCodBar, blnCodFab, blnImprimeEtiqueta: Boolean; edtQtdEti,
                          	edtCodIte, edtQtdIte: TEditFocus; blnBarCen: Boolean; cdsConsulta: TUniClientDataSet;
                            qryCfgRel: TUniQuery; strName: TComponentName; rdbCodBar: TRadioButton;
                            stlIncNfe: TStringList): Boolean;
    function fGetSqlItemEtiqueta(strCodIte: String; intQtdIte: Integer; blnTodosItens: boolean = False; strDigEle :String = ''; blnIgnoreUnion: Boolean = False): String;
    function fSomaItem(cdsConsulta: TUniClientDataSet; fltQtdIte: Double; stlIncNfe: TStringList): Boolean;
    function fIncluiItem(cdsConsulta: TUniClientDataSet; strCodIte: String;
                          fltQtdIte: Double; stlIncNfe: TStringList; blnMaxim, blnAtualizarApenasQuantidade: Boolean; fltQtdTotal: Double = 0): Boolean;
    function fListaAutInc(stlIncNfe: TStringList): String;
    function fPosssuiInconsistencias(cdsConsulta, cdsCriticas: TUniClientDataSet; qryNotEle: TUniQuery): Boolean;
    function fItemSemDadosEcommerce(strCodIte: String): Boolean;

    procedure pSetaRequeridos(cdsConsulta: TUniClientDataSet);
    procedure pRetProdutoBarEmb(const strBarEmb: String; var strCodIte: String; var fltEmbala: Double);
    procedure pImprimeEtiqueta(intQtdIte: Integer; cdsConsulta: TUniClientDataSet;
	                          qryCfgRel: TUniQuery; strName: TComponentName; blnTodosItens: boolean = False; strDigEle: string = '');
    procedure pGravaAtualizaGerEle(stlIncNfe: TStringList; cdsConsulta: TUniClientDataSet);
    procedure pLimpaSeqConf(strAutoInc: String);
    procedure pGerarCodigoBarras(Sender: TObject);
    procedure pCarregaItensNotaEletronica(stlIncNfe: TStringList; qryNotEle: TUniQuery; cdsConsulta: TUniClientDataSet);
    Function fGravaConferencia(cdsConsulta, cdsCriticas: TUniClientDataSet;
                          	edtNotEle, edtCodFor: TEditFocus; qryNotEle: TUniQuery; stlIncNfe: TStringList; strOpeCfr: String = ''): Boolean;
    procedure pAtualizaOpeCfr(strCodCfr: String; stlIncNfe: TStringList);
    procedure pVerificaItensAmais(cdsConsulta, cdsCriticas: TUniClientDataSet; qryNotEle: TUniQuery);
    procedure pVerificaItensAmenos(cdsConsulta, cdsCriticas: TUniClientDataSet; qryNotEle: TUniQuery);
    procedure pIncluiCritica(strCodIte,
                             strDesIte,
                             strDesUni,
                             strCodFab,
                             strLocFis: String;
                             fltQtdIte,
                             fltQtdCon,
                             fltSaldos,
                             fltQtdXML: Double;
                             intQtdLot: Integer;
                             cdsCriticas: TUniClientDataSet);
    procedure pLiberaDocumentos(stlIncNfe: TStringList);
    procedure pLimpaConferencia(cdsConsulta: TUniClientDataSet);
    procedure pExcluirItensIncons(cdsConsulta, cdsCriticas: TUniClientDataSet);
    procedure pLimpaDataConf(stlIncNFe: TStringList);
    procedure pCriticas(cdsConsulta, cdsCriticas: TUniClientDataSet; qryNotEle: TUniQuery;
	                      edtNotEle, edtCodFor, edtCodCfr: TEditFocus; blnTelaColetor: Boolean);
    function fValidaQuantidades(cdsConsulta: TUniClientDataSet; opcTipoOperacao : TipoOperacaoPreNota): Boolean;
    procedure pBeforePost(DataSet: TDataSet);
    function fAjustaItem(cdsConsulta: TUniClientDataSet;
      fltQtdIte: Double; stlIncNfe: TStringList): Boolean;
    procedure pFinalizaConferencia;
    function fExisteConferenciaParcial(ACodIte: String = ''): Boolean;
    function fLiberarEnderecamentoParcial: Boolean;
    Function fLiberacaoParaLiberarEnderecamento(edtNotEle: TEditFocus): Boolean;
    Function fLiberacaoParaLimparConferencia(edtNotEle: TEditFocus): Boolean;
    function fConsulta(cdsConsulta: TUniClientDataSet): TConferePreNota;
    function fIncNfe(stlIncNfe: TStringList): TConferePreNota;
    destructor Destroy; override;
  end;

implementation

uses untFatSelecProduto, untPesqAux, untCfgRel, untFuncoesEtiquetas, BitBtnLockedIncrem,
    untFuncFat, untRelEntConferencia, untFuncoesAuxiliares, untFuncoesConsulta, untPcmger,
  untEntConfPreNotaGarantiaDigRefugo, untFuncoesCRM, untTypesCRM,
  untDefineBaixaPedido;

{ TConferePreNota }

Constructor TConferePreNota.Create;
Begin
  strAutoincremGERELE := '';
  blnConferenciaIniciada := False;
  strCtlEst := fCfgSis('CTLEST');
  blnTrazItensGrid := fCfgSis('ITECNF', varBoolean) And fVerificaAcessoSistema('RELCPN');
End;

function TConferePreNota.fConferenciaIniciada(stlIncNfe: TStringList): boolean;
  var qryConsulta: TUniQuery;
begin

  If stlIncNfe.Count = 0 Then
    Exit(True);

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQl.Clear;
    qryConsulta.SQL.Add('SELECT GER_DTAICO FROM GERELE');
    qryConsulta.SQL.Add('WHERE AUTOINCREM = :AUTINC');
    qryConsulta.SQL.Add('  AND IFNULL(GER_DTAICO, "") <> ""');
    qryConsulta.ParamByName('AUTINC').AsString := stlIncNfe[0];
    qryConsulta.Open;
    Result := Not qryConsulta.IsEmpty;
  Finally
    FreeAndNil(qryConsulta);
  End;

end;

function TConferePreNota.fGetSqlConfer(blnLike: Boolean; opcTipoOperacao : TipoOperacaoPreNota): String;
Var LimiteDias: Integer;
begin
  LimiteDias := fCfgSis('CONLDI', varInteger);

  Result := '';
  Result := Result + ' SELECT ';
  Result := Result + '    TAB1.*, ';
  Result := Result + '    (SELECT ';
  Result := Result + '      COUNT(1) ';
  Result := Result + '    FROM ';
  Result := Result + '      FATDOR ';
  Result := Result + '    WHERE FATDOR.FDO_SEQGER = TAB1.SEQFGO ';
  Result := Result + '      AND IFNULL(FDO_QTDBAI, 0) > 0) AS ITE_QTDEND ';
  Result := Result + '  FROM (';

  Result := Result + ' SELECT       ';
  Result := Result + '   NE.AUTOINCREM,         ';
  Result := Result + '   B09_DEMI   AS DTAEMI, ';
  Result := Result + '   IF(IFNULL(GER_ESPNOT, "") = "", "NF", GER_ESPNOT)  AS ESPDOC, ';
  Result := Result + '   B07_SERIE  AS SERDOC, ';
  Result := Result + '   B08_NNF    AS NUMDOC, ';
  Result := Result + '   W07_VPROD + IFNULL(W18_VSERV, 0) - W10_VDESC AS VALDOC, ';
  Result := Result + '   GER_CODFOR AS CODFOR, ';
  Result := Result + '   FOR_NOMFAN AS NOMFOR, ';
  Result := Result + '   FOR_NOMFOR AS RAZSOC, ';
  Result := Result + '   GER_IDEDIG AS IDEDIG, ';
  Result := Result + '   GER_DOCENT AS DOCENT, ';
  Result := Result + '   0          AS MARDES, ';
  Result := Result + '   X27_QVOL   AS QTDVOL, ';
  Result := Result + '   (SELECT GER_DTAENT FROM MOVGER ';
  Result := Result + '     WHERE GER_NUMDOC = NE.GER_DOCENT AND ';
  Result := Result + '           GER_ESPDOC = NE.GER_ESPENT AND ';
  Result := Result + '           GER_CODEMP = NE.GER_CODEMP AND ';
  Result := Result + '           GER_SERIE_ = NE.B07_SERIE  AND ';
  Result := Result + '           GER_CODFOR = NE.GER_CODFOR) AS DTAENT,';

  Result := Result + '   (SELECT FIS_DTAENT FROM CADFIS ';
  Result := Result + '     WHERE FIS_NUMDOC = NE.GER_DOCENT AND ';
  Result := Result + '           FIS_ESPDOC = NE.GER_ESPENT AND ';
  Result := Result + '           FIS_CODEMP = NE.GER_CODEMP AND ';
  Result := Result + '           FIS_TIP_FC = "F" AND ';
  Result := Result + '           FIS_SERIE_ = NE.B07_SERIE  AND ';
  Result := Result + '           FIS_FORCLI = NE.GER_CODFOR) AS FIS_DTAENT,';

  if fUtilizaAgendamentoRecebimento(opcTipoOperacao) then
  Begin
    Result := Result + '   (SELECT IF(SUM(IFNULL(AIT_QTDDEV,0) + IFNULL(AIT_QTDEND,0) + IFNULL(AIT_DIVEND,0)) > 0, "N","S") ';
    Result := Result + '   FROM AGEITE                                                                                      ';
    Result := Result + '   WHERE AIT_SEQGER = AGEREC.AUTOINCREM) AS ARC_PODCAN,                                             ';
  End;

  if fUtilizaAgendamentoRecebimento(opcTipoOperacao) then
    Result := Result + ' ARC_CODIGO AS AGEREC '
  Else
    Result := Result + ' CAST("" AS CHAR(6)) AS AGEREC ';



  Result := Result + '   ,@SEQFGO := (SELECT                    ';
  Result := Result + '   EXTGOR.FGO_SEQFGO           ';
  Result := Result + ' FROM                          ';
  Result := Result + '   EXTGOR                      ';
  Result := Result + ' WHERE FGO_DOCEND IS NOT NULL  ';
  If fCfgSis('SPCDEN', varBoolean) Then
  Begin
    Result := Result + '  AND FGO_DCENUM = B08_NNF        ';
    Result := Result + '  AND FGO_DCEESP = GER_ESPENT     ';
    Result := Result + '  AND FGO_DCESER = B07_SERIE      ';
    Result := Result + '  AND FGO_DCEEMP = GER_CODEMP     ';
    Result := Result + '  AND FGO_DCEFOR = GER_CODFOR     ';
    Result := Result + '  AND FGO_DCETFC = "F") AS SEQFGO ';
  End
  Else
  Begin
    Result := Result + ' AND FGO_DOCEND = CONCAT(                ';
    Result := Result + '                          B08_NNF,       ';
    Result := Result + '                          GER_ESPENT,    ';
    Result := Result + '                          LEFT(CONCAT(B07_SERIE, REPEAT(" ", 3)), 3),  ';
    Result := Result + '                          GER_CODEMP,    ';
    Result := Result + '                          GER_CODFOR,    ';
    Result := Result + '                          "F")) AS SEQFGO ';
  End;


  Result := Result + ' FROM                    ';
  Result := Result + '   GERELE NE             ';

  Result := Result + ' LEFT JOIN CADFOR ON GER_CODFOR = FOR_CODFOR  ';

  if fUtilizaAgendamentoRecebimento(opcTipoOperacao) then
    Result := Result + ' INNER JOIN AGEREC ON ARC_IDEDIG = GER_IDEDIG AND ARC_CODEMP = NE.GER_CODEMP';

  Result := Result + ' WHERE                         ';
  Result := Result + '       GER_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + '   AND GER_DTALIB IS NOT NULL  ';
  Result := Result + '   AND NE.GER_ENTDIR <> "S"       ';
  if not fEmptyStr(strAutoincremGERELE) THEN
     Result := Result + ' AND NE.AUTOINCREM = ' + QuotedStr(strAutoincremGERELE);

  If (opcTipoOperacao = opeConferencia) Then
  Begin
    Result := Result + ' AND GER_DTACON IS NULL ';
    If fConferenciaDepoisDaEntrada Then
    Begin
      Result := Result + ' AND GER_DOCENT IS NOT NULL ';
      If (fCfgSis('WMSPLA', varString) = 'R') Then
        Result := Result + ' AND (IFNULL((SELECT COUNT(1) FROM MOVGER G WHERE G.GER_NUMDOC = NE.GER_DOCENT AND G.GER_ESPDOC = NE.GER_ESPENT AND G.GER_CODEMP = NE.GER_EMPENT AND G.GER_CODFOR = NE.GER_CODFOR AND G.GER_DTAENT IS NOT NULL),0) > 0) ';
    End
    Else
      Result := Result + ' AND GER_DOCENT IS NULL ';

    if Not fUtilizaAgendamentoRecebimento(opcTipoOperacao) then
      Result := Result + ' AND (' + fSQLRetTemCFO_922('NE.AUTOINCREM', 'DETELE') + ') = 0 ';

    { DET_CLARET, só será 1, se todos os itens da nota estiverem com movtri.det_claret = 1, para corrigir a questão do req 410544}
    Result := Result + ' AND ( SELECT ';
    Result := Result + '           CASE ';
    Result := Result + '             WHEN (COUNT(MOVDET.AUTOINCREM) > 0) AND COUNT(*) = '; { Verifica se a contagem é igual e se há pelo menos um registro com DET_CLARET = 1 }
    Result := Result + '                  (SELECT COUNT(1) ';
    Result := Result + '                     FROM MOVDET ';
    Result := Result + '                    INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
    Result := Result + '                    WHERE TRUE AND ';
    Result := Result + '                          DET_NUMDOC = NE.GER_DOCENT AND ';
    Result := Result + '                          DET_ESPDOC = NE.GER_ESPENT AND ';
    Result := Result + '                          DET_CODEMP = NE.GER_CODEMP AND ';
    Result := Result + '                          DET_SERIE_ = NE.B07_SERIE  AND ';
    Result := Result + '                          DET_CODFOR = NE.GER_CODFOR     ';
    Result := Result + '                       ) ';
    Result := Result + '             THEN 1 ';
    Result := Result + '             ELSE 0 ';
    Result := Result + '           END ';
    Result := Result + '         FROM MOVDET ';
    Result := Result + '        INNER JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
    Result := Result + '        WHERE TRUE AND ';
    Result := Result + '              DET_NUMDOC = NE.GER_DOCENT AND ';
    Result := Result + '              DET_ESPDOC = NE.GER_ESPENT AND ';
    Result := Result + '              DET_CODEMP = NE.GER_CODEMP AND ';
    Result := Result + '              DET_SERIE_ = NE.B07_SERIE  AND ';
    Result := Result + '              DET_CODFOR = NE.GER_CODFOR AND ';
    Result := Result + '            MOVTRI.DET_CLARET = 1 ';
    Result := Result + ' ) = 0 ';

  End
  Else
  If (opcTipoOperacao = opeCancelaConferencia) Then
  Begin
    Result := Result + ' AND GER_DTACON IS NOT NULL ';
    If fConferenciaDepoisDaEntrada Then
      Result := Result + ' AND GER_DOCENT IS NOT NULL '
    Else
      Result := Result + ' AND GER_DOCENT IS NULL ';

    If LimiteDias > 0 Then
      Result := Result + ' AND NE.B09_DEMI > DATE_SUB(CURDATE(), INTERVAL '+LimiteDias.ToString+' DAY)';
  End
  Else
  If (opcTipoOperacao = opeCancelaPreNota) Then
  Begin

    Result := Result + ' AND GER_DTACON IS NULL ';
    Result := Result + ' AND (SELECT COUNT(0) FROM PEDELE WHERE PEL_SEQELE = NE.AUTOINCREM) > 0 ';

    If fConferenciaDepoisDaEntrada Then
      Result := Result + ' AND GER_DOCENT IS NULL '
    Else
      Result := Result +  ' AND IF((' + fSQLRetTemCFO_922('NE.AUTOINCREM', 'DETELE') + ') > 0, (GER_DOCENT IS NULL), TRUE) ';

  End;
  If fUtilizaAgendamentoRecebimento(opcTipoOperacao) Then
    Result := Result + 'AND ARC_NOMMOT <> "ENTRADA SIMPLIFICADA - GARANTIA"';

  Result := Result + ' ORDER BY     ';
  Result := Result + '   GER_IDEDIG ';

  Result := Result + ') AS TAB1 WHERE TRUE ';
end;

function TConferePreNota.fGetSqlItemEtiqueta(strCodIte: String;
  intQtdIte: Integer; blnTodosItens: boolean = False; strDigEle :String = ''; blnIgnoreUnion: Boolean = False): String;
  Var
    intIndex,
    intContador: Integer;
    strSQL: String;

  function fDiaSemanaAlfabeto: String;
  begin
    Case DayOfTheWeek(VS_Date) Of
      1 : Result := 'A'; //Domingo
      2 : Result := 'B'; //Segunda
      3 : Result := 'C'; //Terça
      4 : Result := 'D'; //Quarta
      5 : Result := 'E'; //Quinta
      6 : Result := 'F'; //Sexta
      7 : Result := 'G'; //Sabado
    End;
  end;

  function fLoteCriptografado: String;
  begin
    Result := RightStr(IntToStr(YearOf(VS_Date)),2);
    Result := Result + IntToStr(WeekOfTheYear(YearOf(VS_Date)));
    Result := Result + fDiaSemanaAlfabeto;
  end;


  function fRetCamposIBPT: string;
    var
      i: integer;
  Begin
    For i := 1 To 7 Do
    Begin
      If fCfgSis('IMPPAG', varInteger) = 1 Then
      Begin
        //Internacional
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPIT' + IntToStr(i) + ' ,';
        //Federal
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPFT' + IntToStr(i) + ' ,';
        //Estadual
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPET' + IntToStr(i) + ' ,';
        //Municipal
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(ABF_PEIMPG, 0) /100 AS IBPMT' + IntToStr(i) + ' ,';
      End
      Else
      Begin
        //Internacional
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQIMP, 0) /100 AS IBPIT' + IntToStr(i) + ', ';
        //Federal
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQNAC, 0) /100 AS IBPFT' + IntToStr(i) + ', ';
        //Estadual
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQEST, 0) /100 AS IBPET' + IntToStr(i) + ', ';
        //Municipal
        Result := Result + ' ITE_PREVE' + IntToStr(i) + ' * IFNULL(IBP_ALQMUN, 0) /100 AS IBPMT' + IntToStr(i) + ', ';
      End;
    End;
  End;


  function fJoinIBPT: string;
  Begin
    Result := Result + ' LEFT JOIN CADCID EMPEST ON EMPEST.CID_CODCID = E.EMP_CODCID ';
    If fCfgSis('IMPPAG', varInteger) = 1 Then
      Result := Result + ' LEFT JOIN ABFICM ON ABF_ESTADO = EMPEST.CID_ESTADO AND ABF_CODABF = G.ITE_CODABF '
    Else
    begin
      Result := Result + 'LEFT JOIN CADIBP UTI ON UTI.AUTOINCREM = IFNULL((SELECT AUTOINCREM FROM CADIBP FUL ';
      Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
      Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(G.ITE_EXCIPI, "") ';
      Result := Result + '                                                    AND FUL.IBP_N_C_M_ = I.ITE_CLAIPI), ';

      Result := Result + '                                                IFNULL((SELECT MAX(AUTOINCREM) FROM CADIBP FUL ';
      Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
      Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(G.ITE_EXCIPI, "") ';
      Result := Result + '                                                    AND FUL.IBP_N_C_M_ = LEFT(I.ITE_CLAIPI, 4)) , ';
      Result := Result + '                                                    (SELECT MAX(AUTOINCREM) FROM CADIBP FUL ';
      Result := Result + '                                                  WHERE FUL.IBP_ESTADO = EMPEST.CID_ESTADO ';
      Result := Result + '                                                    AND IFNULL(FUL.IBP_E_X___, "") = IFNULL(G.ITE_EXCIPI, "") ';
      Result := Result + '                                                    AND FUL.IBP_N_C_M_ = LEFT(I.ITE_CLAIPI, 2)))) ';
    End;
  End;



begin
  Result := '';
  Result := Result + ' SELECT                      ';
  Result := Result + '     E.EMP_NOMEMP AS NOMEMP,   ';
  Result := Result + '   I.ITE_DESITE AS DESITE,   ';
  Result := Result + '   I.ITE_APLICA AS APLICA,   ';
  Result := Result + '   I.ITE_DESSIM AS DESSIM, ';
  Result := Result + '   I.ITE_REFERE AS REFERE,   ';
  Result := Result + '   I.ITE_CODITE AS CODITE,   ';
  Result := Result + '   I.ITE_CODGRU AS CODGRU,   ';
  Result := Result + '   I.ITE_MENFIS AS MENFIS, ';
  Result := Result + '   I.ITE_MSGLV1 AS MSGLV1, ';
  Result := Result + '   I.ITE_MSGLV2 AS MSGLV2, ';
  Result := Result + '     UNI_SIGUNI AS SIGUNI,   ';

  Result := Result + fRetCamposIBPT;

  If blnTodosItens Then
  Begin
    If not fEmptyStr(strDigEle) Then
      Result := Result + '   D.DIG_QTDITE QTDETI,'
  End
  Else
    Result := Result + '   1 AS QTDETI,';

  Result := Result + '     CAST("" AS CHAR(1)) AS NUMDOC,   ';
  Result := Result + '     CAST("" AS CHAR(1)) AS ESPDOC,   ';
  Result := Result + '     CAST("" AS CHAR(1)) AS SERIE_,   ';
  If strCTLEST = '2' Then
    Result := Result + '  IFNULL(CADLOT.LOT_LOCFIS, G.ITE_LOCFIS) AS LOCFIS, '
  Else
    Result := Result + '  G.ITE_LOCFIS AS LOCFIS, ';
  Result := Result + '  G.ITE_LOCSUP AS LOCSUP, ';
  Result := Result + '   I.ITE_CODFOR AS CODFOR, ';
  Result := Result + '     FOR_NOMFOR AS NOMFOR,   ';

  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '1') + ' AS VALVIS, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '1') + ' AS VALITE, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '1') + ' AS PREVIS, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '1') + ' AS VALPAR, ';

  Result := Result + '   0            AS QTDPAR, ';
  Result := Result + '   0            AS TOTPRA,   ';

  Result := Result + '   I.ITE_CODFAB AS CODFAB,   ';
  Result := Result + '     MAR_DESMAR AS DESMAR,   ';
  Result := Result + '     IPR_PREVEN AS PROMOC,   ';
  Result := Result + ' IFNULL(IPR_PERDES, 0) AS PERDES, ';
  Result := Result + ' IFNULL(IPR_QTDMIN, 0) AS QTDMIN, ';

  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '1') + ' AS PREVE1, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '2') + ' AS PREVE2, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '3') + ' AS PREVE3, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '4') + ' AS PREVE4, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '5') + ' AS PREVE5, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '6') + ' AS PREVE6, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '7') + ' AS PREVE7, ';

  Result := Result + '  CAST("" AS CHAR(1)) AS EMPNOM,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS FANEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS IESEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS CEPEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS BAIRRO,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDNUM,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ENDCMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS CIDEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS ESTEMP,   ';
  Result := Result + '  CAST("" AS CHAR(1)) AS NUMSEQ,   ';

  For intIndex := 0 To 9 Do
  Begin
    Result := Result + ' ( SELECT ITB_QTDEMB                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS QTDEM'+ IntToStr(intIndex) + ', ';

    Result := Result + ' ( SELECT ITB_DESCON                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS DESCO'+ IntToStr(intIndex) + ', ';

    Result := Result + ' ( SELECT ITB_TABPRE                         ';
    Result := Result + '   FROM ITEEMB                               ';
    Result := Result + '   WHERE ITB_CODITE = G.ITE_CODITE      ';
    Result := Result + '     AND ITB_CODEMP = G.ITE_CODEMP      ';
    Result := Result + '   ORDER BY ITB_QTDEMB DESC                  ';
    Result := Result + '   LIMIT '+ IntToStr(intIndex) +',1) AS TABPR'+ IntToStr(intIndex) + ', ';
  End;

  Result := Result + ' I.ITE_DTAALT AS DTAALT,';
  Result := Result + ' I.ITE_CODMAR AS CODMAR,';

  Result := Result + ' G.ITE_AMZETI AS AMZETI,';
  Result := Result + ' I.ITE_ITEATI AS ITEATI,';
  Result := Result + '   CONCAT(I.ITE_CODFAB, " ", MAR_DESMAR) AS FABMAR,  ';
  Result := Result + '   E.EMP_C_G_C_ AS EMPCGC,   ';
  Result := Result + '"' + fLoteCriptografado + '"' + ' AS LOTECR, ';
  Result := Result + '   ITE_SALDOS AS SALDOS, ';
  Result := Result + '   E.EMP_FONDA1 AS FONDA1,  ';
  Result := Result + '   E.EMP_FONDA2 AS FONDA2,  ';
  Result := Result + '   I.ITE_CODBAR AS CODBAR,   ';
  Result := Result + '   IFNULL((SELECT BAR_EMBALA FROM ITEBAR WHERE BAR_CODITE = I.ITE_CODITE AND BAR_CODFOR = "' + LeftStr(strCodFor, 8) + '"  ORDER BY BAR_COMPRA DESC LIMIT 1), I.ITE_EMBALA) AS EMBALA,  ';
  Result := Result + '   CAST("" AS CHAR(1)) AS EMBPRE, ';
  Result := Result + '   CAST("" AS CHAR(1)) AS DESEMB               , ';

  Result := Result + '   G.ITE_TABEMF AS TABEMF, ';
  Result := Result + '   G.ITE_DESFEC AS DESFEC, ';
  Result := Result + '   G.ITE_EMBFEC AS EMBFEC, ';
  Result := Result + '  CAST("" AS CHAR(1)) AS OBSIMP, ';

  Result := Result + '  (SELECT GROUP_CONCAT(CADSEM.SEM_CODSEM) ';
  Result := Result + '     FROM CADSEM ';
  Result := Result + '    WHERE CADSEM.SEM_CODITE = I.ITE_CODITE ';
  Result := Result + '      AND CADSEM.SEM_CODEMP = I.ITE_CODEMP)AS CODSEM, ';


  Result := Result + '  ITE_VALIDA AS VALIDA,';
  Result := Result + '  ITE_ITESAC AS ITESAC, ';
  Result := Result + '  ITE_COMPOS AS COMPOS, ';
  Result := Result + '  ITE_PAISOR AS PAISOR, ';
  Result := Result + '  ITE_ESTMIN AS ESTMIN, ';
  Result := Result + '  ITE_ESTMAX AS ESTMAX, ';
  Result := Result + '  I.ITE_MLTVEN AS MLTVEN, ';
  Result := Result + '  ITE_IPISAI AS IPISAI,  ';

  Result := Result + '  OPE_CODOPE AS OPEIMP, ';
  Result := Result + '  OPE_NOMOPE AS NOMOPE, ';
  Result := Result + '  (SELECT FROM_BASE64(ITE_IMGB64) FROM ITEIMG WHERE ITEIMG.ITE_CODITE = I.ITE_CODITE AND ITEIMG.ITE_PRINCI = "S" ORDER BY ITEIMG.AUTOINCREM DESC LIMIT 1) AS PROIMG, ';
  Result := Result + '   I.ITE_ATICOM AS ATICOM,   ';

  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '1') + ' AS ITE_PREVE1, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '2') + ' AS ITE_PREVE2, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '3') + ' AS ITE_PREVE3, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '4') + ' AS ITE_PREVE4, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '5') + ' AS ITE_PREVE5, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '6') + ' AS ITE_PREVE6, ';
  Result := Result + fGetSQLConsultaItensPrecoValidandoEstrutura('G', '7') + ' AS ITE_PREVE7, ';

  Result := Result + '   I.AUTOINCREM,              ';
  Result := Result + '   FALSE AS IMP_S_N,         ';
  Result := Result + '   CAST("" AS CHAR(1)) AS ALTPRE, ';
  Result := Result + '   FOR_C_G_C_ AS CGCFOR       ';

  {Localizações Adicionais}
  If fCfgSis('CADLOC', varBoolean) Then
  Begin
    Result := Result + ' ,(SELECT                                 ';
    Result := Result + '    GROUP_CONCAT(CADLOC.LOC_DESCRI)      ';
    Result := Result + '  FROM                                   ';
    Result := Result + '    LOCFIS                               ';
    Result := Result + '    INNER JOIN CADLOC ON (CADLOC.LOC_CODLOC = LOCFIS.LOC_LOCFIS AND ';
    Result := Result + '                          CADLOC.LOC_CODEMP = LOCFIS.LOC_CODEMP)    ';
    Result := Result + '  WHERE                                       ';
    Result := Result + '    LOCFIS.LOC_CODITE = I.ITE_CODITE AND ';
    Result := Result + '    LOCFIS.LOC_CODEMP = '+QuotedStr(Vs_strCodEmp)+' AND ';
    Result := Result + '    CADLOC.LOC_ATIVO_ <> "N") AS LOCADI  ';
  End
  Else
  Begin
    Result := Result + ' ,(SELECT                                 ';
    Result := Result + '    GROUP_CONCAT(LOC_LOCFIS)             ';
    Result := Result + '  FROM                                   ';
    Result := Result + '    LOCFIS                               ';
    Result := Result + '  WHERE                                  ';
    Result := Result + '    LOC_CODITE = I.ITE_CODITE AND   ';
    Result := Result + '    LOC_CODEMP = '+QuotedStr(Vs_strCodEmp)+' ) AS LOCADI ';
  End;

  Result := Result + ' FROM                        ';
  If blnTodosItens and Not fEmptyStr(strDigEle) Then
  Begin
    Result := Result + '   DIGELE D ';
    Result := Result + ' INNER JOIN  CADITE I ON I.ITE_CODITE = D.DIG_CODITE ';
  End
  Else
    Result := Result + '   CADITE I  ';

  Result := Result + '   INNER JOIN CADUNI ON I.ITE_CODUNI = UNI_CODUNI ';
  Result := Result + '    LEFT JOIN CADFOR ON  FOR_CODFOR = I.ITE_CODFOR  ';

  Result := Result + '   INNER JOIN ITEGER G ON          ';
  Result := Result + '     I.ITE_CODITE = G.ITE_CODITE AND ';
  Result := Result + '     G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

  If strCTLEST = '2' Then
  Begin
    Result := Result + '  LEFT JOIN CADLOT ON CADLOT.LOT_ARMPRC = "S" AND IFNULL(CADLOT.LOT_LOCFIS, "") <> "" ';
    Result := Result + '                  AND CADLOT.LOT_CODITE = G.ITE_CODITE ';
    Result := Result + '                  AND CADLOT.LOT_CODEMP = G.ITE_CODEMP ';
  End;


  Result := Result + '   INNER JOIN CADMAR ON       ';
  Result := Result + '     MAR_CODMAR = ITE_CODMAR  ';
  Result := Result + '  LEFT JOIN CADOPE ON OPE_CODOPE = "'+strLoginUsuarioLogado+'"';
  Result := Result + '   INNER JOIN CADEMP E ON EMP_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + fJoinIBPT;
  Result := Result + '   LEFT JOIN (SELECT IPR_PREVEN, IPR_CODITE, IPR_PERDES, IPR_QTDMIN  FROM CADPRO JOIN ITEPRO ON CADPRO.AUTOINCREM = ITEPRO.IPR_SEQGER ';
  Result := Result + '                                                        JOIN PROEMP ON CADPRO.AUTOINCREM = PROEMP.PRO_SEQGER ';
  Result := Result + '   WHERE  ';
  Result := Result + '   PROEMP.PRO_CODEMP = :CODEMP AND ' + fCurrentDate + ' BETWEEN PRO_DTAINI AND PRO_DTAFIN) AS TMP ON IPR_CODITE = G.ITE_CODITE ';

  If blnTodosItens Then
  Begin
    If not fEmptyStr(strDigEle) Then
    Begin
      Result := Result + '  WHERE D.DIG_CODEMP = ' + QuotedStr(Vs_strCodEmp);
      Result := Result + '  AND D.DIG_IDEDIG = "' + strDigEle + '"';
    End;
  End
  Else
  Begin
    Result := Result + ' WHERE                      ';
    Result := Result + '   I.ITE_CODITE = ' + QuotedStr(strCodIte);
  End;

  strSQL := Result;
  If not blnIgnoreUnion then
    If Not blnTodosItens Then
      For intContador := 2 to intQtdIte Do
        Result := Result + ' UNION ALL ' + strSQL;

end;

function TConferePreNota.fGetSqlPrincipal(blnLike: Boolean): String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE   ';
  Result := Result + '   NE.GER_CODEMP,      ';
  Result := Result + '   IF(NE.GER_DTACON IS NULL, "N", "S") AS CONFERIDO,  ';
  Result := Result + '   D.AUTOINCREM,       ';
  Result := Result + '   D.DIG_CODITE ITE_CODITE, ';
  Result := Result + '   D.DIG_QTDITE ITE_QTDCON, ';
  Result := Result + '   IF(IFNULL(I.ITE_CODBAR,"") = "", "-", I.ITE_CODBAR) AS ITE_CODBAR, ';
  Result := Result + '   IF(IFNULL(I.ITE_CODFAB,"") = "", "-", I.ITE_CODFAB) AS ITE_CODFAB, ';
  Result := Result + '   IF(IFNULL(I.ITE_DESITE,"") = "", "-", I.ITE_DESITE) AS ITE_DESITE, ';
  Result := Result + '   IF(IFNULL(M.MAR_DESMAR,"") = "", "-", M.MAR_DESMAR) AS MAR_DESMAR, ';

  If fCfgSis('EXIAPL', varBoolean) then
    Result := Result + ' IF(IFNULL(ITE_APLICA,"") = "", "-", ITE_APLICA) AS ITE_APLICA, ';

  Result := Result + '   IF(IFNULL(I.ITE_REFERE,"") = "", "-", I.ITE_REFERE) AS ITE_REFERE, ';
  Result := Result + '   UNI_SIGUNI AS ITE_DESUNI,                                      ';

  If strCTLEST = '2' Then
    Result := Result + '  IFNULL(CADLOT.LOT_LOCFIS, G.ITE_LOCFIS) AS ITE_LOCFIS, '
  Else
    Result := Result + '  IF(IFNULL(ITE_LOCFIS,"") = "", "-", ITE_LOCFIS) AS ITE_LOCFIS, ';

  Result := Result + '   IF(IFNULL(ITE_LOCSUP,"") = "", "-", ITE_LOCSUP) AS ITE_LOCSUP, ';
  Result := Result + '   ITE_SALDOS                                      AS ITE_SALDOS, ';
  Result := Result + '   ITE_FICINS, ';
  Result := Result + '   ITE_CPESOB, ';
  Result := Result + '   IFNULL(I.ITE_PESOIT,0) AS ITE_PESBRU, ';
  Result := Result + '   IFNULL(I.ITE_PESLIQ,0) AS ITE_PESLIQ, ';

  if fConferenciaDepoisDaEntrada Then
  Begin
    Result := Result + fGetSQLEmbalagemEntradaMercadorias + ' AS ITE_EMBALA,  ';
    Result := Result + '   D.DIG_QTDITE / ' + fGetSQLEmbalagemEntradaMercadorias + ' AS ITE_QTDEMB ';
  End
  Else
  Begin
    Result := Result + '                  IF(DET_EMBALA IS NULL OR DET_EMBALA = 0, ' + fSQLEmbala('I', 'F', 'GER_CODFOR', True) + ', DET_EMBALA) AS ITE_EMBALA, ';
    Result := Result + '   D.DIG_QTDITE / IF(DET_EMBALA IS NULL OR DET_EMBALA = 0, ' + fSQLEmbala('I', 'F', 'GER_CODFOR', True) + ', DET_EMBALA) AS ITE_QTDEMB ';
  End;

  If blnTrazItensGrid Then
  Begin
    Result := Result + ', CAST("I" AS CHAR(1)) AS STATUS_CONF, ';
    Result := Result + '0.0000 AS ITE_QTDTOT';
  End;
  Result := Result + '   ,I.ITE_CODUNI ';
  Result := Result + '   ,I.ITE_CODMAR ';
  Result := Result + '   ,0.0000 AS ITE_QTDEDR';
  Result := Result + '   ,(SELECT SUM(DIG_QTDITE) FROM DIGELE D2 WHERE D2.DIG_IDEDIG = D.DIG_IDEDIG AND D2.DIG_CODITE  = D.DIG_CODITE) ITE_QTDCOF';

  Result := Result + ' FROM          ';
  Result := Result + '   DIGELE D    ';
  Result := Result + '   INNER JOIN GERELE NE ON D.DIG_IDEDIG = NE.GER_IDEDIG AND D.DIG_CODEMP = NE.GER_CODEMP ';
  Result := Result + '    LEFT JOIN DETELE DE ON DE.DET_SEQGER = NE.AUTOINCREM AND D.DIG_CODITE = DE.DET_CODITE ';
  Result := Result + '   INNER JOIN CADITE I ON I.ITE_CODITE = DIG_CODITE   ';

  Result := Result + '   INNER JOIN ITEGER G ON G.ITE_CODITE = DIG_CODITE AND ';
  Result := Result + '                          G.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';
  Result := Result + '   LEFT JOIN CADMAR M ON I.ITE_CODMAR = M.MAR_CODMAR AND  ';
  Result := Result + '                          M.MAR_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' ';

  If strCTLEST = '2' Then
  Begin
    Result := Result + '  LEFT JOIN CADLOT ON CADLOT.LOT_ARMPRC = "S" AND IFNULL(CADLOT.LOT_LOCFIS, "") <> "" ';
    Result := Result + '                  AND CADLOT.LOT_CODITE = G.ITE_CODITE ';
    Result := Result + '                  AND CADLOT.LOT_CODEMP = G.ITE_CODEMP ';
  End;

  Result := Result + '   LEFT  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI ';

  If fCfgSis('TABPRF', varBoolean) Then
  Begin
    Result := Result + '  LEFT JOIN ITEFOR F ON F.ITE_CODITE =   I.ITE_CODITE AND ';
    Result := Result + '                        F.ITE_CODFOR =   GER_CODFOR AND ';
    Result := Result + '                        (SELECT COUNT(*) FROM TABPRE      ';
    Result := Result + '                         WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S" ) > 0 ';
  End;

  Result := Result + ' WHERE      ';

  if fEmptyStr(strIdeDig) then
    Result := Result + '   NE.GER_DTACON IS NULL AND ';

  Result := Result + '   D.DIG_CODEMP = ' + QuotedStr(VS_strCodEmp) + ' AND ';
  Result := Result + '   D.DIG_IDEDIG = ' + QuotedStr(strIdeDig);
  Result := Result + ' GROUP BY      ';
  Result := Result + '   D.AUTOINCREM ';
end;

function TConferePreNota.fIncluiItem(cdsConsulta: TUniClientDataSet; strCodIte: String;
  fltQtdIte: Double; stlIncNfe: TStringList; blnMaxim, blnAtualizarApenasQuantidade: Boolean; fltQtdTotal: Double = 0): Boolean;
Var
  strDesIte,
  strCodRef,
  strCodBar,
  strRefere,
  strCodUni,
  strAutInc,
  strCodFab,
  strLocFis,
  strLocSup,
  strMarca,
  strFicIns,
  strAplica: String;
  fltEmbala: Double;
begin
 Result := FALSE;

  pRetProdutoCodBar(strCodIte,
                    strDesIte,
                    strCodRef,
                    strCodBar,
                    strRefere,
                    strCodUni,
                    strCodFab,
                    strLocFis,
                    strLocSup,
                    strFicIns,
                    strAplica,
                    strCtlEst,
                    fltEmbala,
                    Length(strCodIte) > fTamCodIte);

  If fEmptyStr(strDesIte) And (Length(strCodIte) > fTamCodIte) Then
  Begin
    pRetProdutoSimilar(strCodIte,
                       strCodRef,
                       strDesIte,
                       strRefere,
                       strCodUni,
                       strCodFab,
                       strLocFis,
                       strLocSup,
                       strFicIns,
                       strAplica,
                       strCtlEst,
                       fltEmbala);

    If Not fEmptyStr(strDesIte) Then
      strCodBar := strCodIte;
  End;

  If fEmptyStr(strDesIte) Then
    pMensagemSonora('Item ' + strCodIte + ' não encontrado!', blnMaxim)

  Else
  Begin

    strMarca := fRetNomMarcaItem(strCodRef);

    With cdsConsulta Do
    Begin
      cdsConsulta.Tag := 1;

      Try
        If (blnAtualizarApenasQuantidade) And (cdsConsulta.Locate('ITE_CODITE', strCodRef, [])) Then
        Begin
          cdsConsulta.Edit;
          cdsConsulta.FieldByName('ITE_QTDCON').AsFloat := cdsConsulta.FieldByName('ITE_QTDCON').AsFloat + fltQtdIte;
        End
        Else
        Begin
          cdsConsulta.Insert;
          FieldByName('AUTOINCREM').AsString   := strAutInc;
          FieldByName('ITE_CODITE').AsString   := strCodRef;
          FieldByName('ITE_QTDCON').AsFloat    := fltQtdIte;

          FieldByName('ITE_CODBAR').AsString   := IIF(fEmptyStr(strCodBar), '-', strCodBar);
          FieldByName('ITE_DESITE').AsString   := IIF(fEmptyStr(strDesIte), '-', strDesIte);
          FieldByName('ITE_REFERE').AsString   := IIF(fEmptyStr(strRefere), '-', strRefere);
          FieldByName('MAR_DESMAR').AsString   := IIF(fEmptyStr(strMarca), '-', strMarca);
          FieldByName('ITE_DESUNI').AsString   := fRetSiglaUnidade(strCodUni);
          FieldByName('ITE_CODFAB').AsString   := IIF(fEmptyStr(strCodFab), '-', strCodFab);
          FieldByName('ITE_LOCFIS').AsString   := IIF(fEmptyStr(strLocFis), '-', strLocFis);

          FieldByName('ITE_FICINS').AsString   := strFicIns;

          If blnTrazItensGrid Then
            FieldByName('ITE_QTDTOT').AsFloat    := fltQtdTotal;

          If fCfgSis('EXIAPL', varBoolean) then
            FieldByName('ITE_APLICA').AsString   := strAplica;

          If Fields.FindField('ITE_LOCSUP') <> Nil Then
            FieldByName('ITE_LOCSUP').AsString   := IIF(fEmptyStr(strLocSup), '-', strLocSup);

          FieldByName('ITE_EMBALA').AsFloat    := fltEmbala;

          If fltEmbala <> 0 Then
            FieldByName('ITE_QTDEMB').AsFloat    := fltQtdIte / fltEmbala;
        End;

        If fUtilizaDistribuicaoConferenciaPreNota Then
          ObjDistribuicaoConferencia.ConferirItem(strCodIte, fltQtdIte);

        If cdsConsulta.State in [dsInsert, dsEdit] Then
          Post;

        If Assigned(stlIncNfe) Then
          pGravaAtualizaGerEle(stlIncNfe, cdsConsulta);

        Result := TRUE;
      Except

        On E: Exception Do
        Begin
          fRollBack;
          Result := FALSE;
          pMensagensErro(E.Message, '[fIncluiItem]');
        End;

      End;

      cdsConsulta.Tag := 0;

    End;
  End;
end;

function TConferePreNota.fItemSemDadosEcommerce(strCodIte: String): Boolean;
var
  qryAux: TUniQuery;
begin
  Try
  qryAux := fCriaQuery;

    With qryAux, SQL Do
    Begin
      Add(' SELECT                                                                            ');
      Add('  IF(D.ITE_EXPALT IS NULL OR D.ITE_EXPALT = 0,"EM BRANCO", D.ITE_EXPALT) AS EXPALT,');
      Add('  IF(D.ITE_EXPPRO IS NULL OR D.ITE_EXPPRO = 0,"EM BRANCO", D.ITE_EXPPRO) AS EXPPRO,');
      Add('  IF(D.ITE_EXPLAR IS NULL OR D.ITE_EXPLAR = 0,"EM BRANCO", D.ITE_EXPLAR) AS EXPLAR,');
      Add('  IF(C.ITE_PESOIT IS NULL OR C.ITE_PESOIT = 0,"EM BRANCO", D.ITE_EXPALT) AS PESOIT ');
      Add(' FROM                                                                              ');
      Add('  CADITE C                                                                         ');
      Add(' INNER JOIN                                                                        ');
      Add('  DESSIT D ON                                                                      ');
      Add('   C.ITE_CODITE = D.ITE_CODITE                                                     ');
      Add(' WHERE                                                                             ');
      Add('   C.ITE_CODITE = :CODITE                                                          ');
    End;

    qryAux.Close;
    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.Open;

    Result :=     (qryAux.FieldByName('EXPALT').AsString = 'EM BRANCO')
               Or (qryAux.FieldByName('EXPPRO').AsString = 'EM BRANCO')
               Or (qryAux.FieldByName('EXPLAR').AsString = 'EM BRANCO')
               Or (qryAux.FieldByName('PESOIT').AsString = 'EM BRANCO');

  Finally
      FreeAndNil(qryAux);
  End;
end;

function TConferePreNota.fListaAutInc(stlIncNfe: TStringList): String;
Var
  stlLista: TStringList;
  intContador: Integer;
Begin
  stlLista := TStringList.Create;
  stlLista.Text := stlIncNfe.Text;

  For intContador := 0 To stlLista.Count -1 Do
    stlLista[intContador] := QuotedStr(stlLista[intContador]);

  Result := stlLista.CommaText;

  FreeAndNil(stlLista);
end;

procedure TConferePreNota.pMarcaInicioConferencia(stlIncNfe: TStringList);
  var qryAtualizaInicio: TUniQuery;
      intIndex: integer;
begin
  If Not blnConferenciaIniciada Then
  Begin
    blnConferenciaIniciada := fConferenciaIniciada(stlIncNfe);
    If blnConferenciaIniciada Then
      Exit;
  end
  Else
    Exit;

  qryAtualizaInicio := fCriaQuery;
  Try
    qryAtualizaInicio.SQL.Add('UPDATE GERELE SET');
    qryAtualizaInicio.SQL.Add('  GER_DTAICO = :DTAICO,');
    qryAtualizaInicio.SQL.Add('  GER_HORICO = :HORICO');
    qryAtualizaInicio.SQL.Add('WHERE AUTOINCREM = :AUTINC');
    qryAtualizaInicio.SQL.Add('AND IFNULL(GER_DTAICO, "") = ""');
    For intIndex := 0 To stlIncNfe.Count -1 Do
    Begin
      qryAtualizaInicio.ParamByName('AUTINC').AsString := stlIncNfe[intIndex];
      qryAtualizaInicio.ParamByName('DTAICO').AsDate   := VS_Date;
      qryAtualizaInicio.ParamByName('HORICO').AsTime   := fTime();
      qryAtualizaInicio.ExecSQL;
    End;
    blnConferenciaIniciada := True;
  Finally
    FreeAndNil(qryAtualizaInicio);
  End;

end;

function TConferePreNota.fPosssuiInconsistencias(cdsConsulta,
  cdsCriticas: TUniClientDataSet; qryNotEle: TUniQuery): Boolean;
begin
  Result := false;

  If Not cdsConsulta.Active Then
    Exit;

  cdsCriticas.Filtered := FALSE;
  cdsCriticas.EmptyDataSet;

  pVerificaItensAmais(cdsConsulta, cdsCriticas, qryNotEle);
  pVerificaItensAmenos(cdsConsulta, cdsCriticas, qryNotEle);

  cdsCriticas.Filter := '(QTDITE <> QTDCON)';

  cdsCriticas.Filtered := True;
  Result := Not cdsCriticas.IsEmpty;
end;

function TConferePreNota.fRegistraItem(blnCodBar, blnCodFab, blnImprimeEtiqueta: Boolean; edtQtdEti,
	edtCodIte, edtQtdIte: TEditFocus; blnBarCen: Boolean; cdsConsulta: TUniClientDataSet;
  qryCfgRel: TUniQuery; strName: TComponentName; rdbCodBar: TRadioButton; stlIncNfe: TStringList): Boolean;
Var
  strCamBus,
  strCodIte,
  strCodBar: String;
  fltEmbala: Double;
  qryConIte: TUniQuery;
  qryUpdate: TUniQuery;
  blnBuscaCodBar: Boolean;
begin
  pMarcaInicioConferencia(stlIncNfe);

  qryConIte := fCriaQuery;
  qryUpdate := fCriaQuery;

  Result := FALSE;

  fltEmbala := 0;
  strCodIte := '';
  strCamBus := 'ITE_CODFAB';
  blnBuscaCodBar := False;

  FTipoDigitacao:= '';

  If blnCodBar Then
    FTipoDigitacao:= 'B'
  Else
    FTipoDigitacao:= 'C';

  If blnCodBar Or blnBarCen Then
  Begin
    pRetProdutoBarEmb(edtCodIte.Text, strCodIte, fltEmbala);

    If Not fEmptyStr(strCodIte) Then
    Begin
      If fltEmbala <= 0 Then
        fltEmbala := 1;

      edtCodIte.Text := strCodIte;
      edtQtdIte.Text := FloatToStr(fStrToFloat(edtQtdIte.Text) * fltEmbala);

    End;

    If fEmptyStr(strCodIte) And ((Length(edtCodIte.Text) > fTamCodIte) or blnBarCen) Then
    Begin
      strCamBus := 'ITE_CODBAR';

      blnBuscaCodBar := True;
    End
    Else
    Begin
      strCamBus := 'ITE_CODITE';
      edtCodIte.Text := fStrZero(edtCodIte.Text, fTamCodIte);
    End;

  End;

  strCodIte := edtCodIte.Text;

  With cdsConsulta Do
  Begin

    {***************************************}
    {* PESQUISA NO CADASTRO DE SEMELHANTES *}
    {************************************AF*}
    pPesquisaCadSem(Nil, qryConIte, edtCodIte.Text, '', blnBuscaCodBar, blnCodFab);

    If (qryConIte.RecordCount > 1) Then
    Begin
      Try
        pCriarFormularios(TfrmFatSelecProduto, frmFatSelecProduto);
        try
          frmFatSelecProduto.qryItens := qryConIte;
          frmFatSelecProduto.ShowModal;
        finally
          pFreeAndNil(frmFatSelecProduto);
        end;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TfrmEntConferPreNota.fRegistraItem]');
      End;
    End;

    If qryConIte.RecordCount > 0 Then
    Begin
      strCodIte := qryConIte.FieldByName('ITE_CODITE').AsString;
      strCamBus := 'ITE_CODITE';

      if not fExisteItem(strCodIte) then
      begin
        If Not(fEmptyStr(fCfgSis('PRBPNE', varString))) Then
          pMensagemSonora('Item ' + strCodIte + ' não encontrado.', 'PRBPNE')
        Else
          pMensagemSonora('Item ' + strCodIte + ' não encontrado.');
        Result := False;
      end
      else If Not IsItemAtivo(strCodIte) Then
      begin
        pMensagemSonora('Item ' + strCodIte + ' esta inativo.');
        Result := False;
      End
      Else
      Begin
        If Locate(strCamBus,strCodIte,[]) Then
        Begin
          Result := fSomaItem(cdsConsulta, fStrToFloat(edtQtdIte.Text), stlIncNfe);
          ObjDistribuicaoConferencia.ConferirItem(strCodIte, fStrToFloat(edtQtdIte.Text));
        End
        Else
        If Locate(strCamBus,strCodIte,[]) And (Not blnTrazItensGrid) Then
          Result := fSomaItem(cdsConsulta, fStrToFloat(edtQtdIte.Text), stlIncNfe)
        Else
        begin
          if not Assigned(rdbCodBar) then
            Result := fIncluiItem(cdsConsulta, strCodIte, fStrToFloat(edtQtdIte.Text), stlIncNfe, True, True)
          else
            Result := fIncluiItem(cdsConsulta, strCodIte, fStrToFloat(edtQtdIte.Text), stlIncNfe, False, True);
        end;

        If Result Then
        Begin
          If blnCodFab Then
          Begin

            If (edtCodIte.Text = qryConIte.FieldByName('ITE_CODFAB').AsString) Then
            Begin
              strCodIteAtu := qryConIte.FieldByName('ITE_CODITE').AsString;
              strCodGruAtu := qryConIte.FieldByName('ITE_CODGRU').AsString;

              If fEmptyStr(qryConIte.FieldByName('ITE_CODBAR').AsString) And ffrmCodBarra(strCodBar, '', pGerarCodigoBarras) Then
              Begin
                qryUpdate.Close;
                qryUpdate.SQL.Clear;
                qryUpdate.SQL.Add('UPDATE CADITE SET ITE_CODBAR = :CODBAR WHERE AUTOINCREM = :AUTINC');
                qryUpdate.ParamByName('CODBAR').AsString := strCodBar;
                qryUpdate.ParamByName('AUTINC').AsString := qryConIte.FieldByName('AUTITE').AsString;
                qryUpdate.ExecSQL;

                fAtualizaBarFabIte(qryConIte.FieldByName('ITE_CODITE').AsString);
              End;

            End
            Else
            Begin

              If (Not fEmptyStr(qryConIte.FieldByName('AUTSEM').AsString)) And
                 fEmptyStr(qryConIte.FieldByName('BARSEM').AsString) And ffrmCodBarra(strCodBar) Then
              Begin
                qryUpdate.Close;
                qryUpdate.SQL.Clear;
                qryUpdate.SQL.Add('UPDATE CADSEM SET SEM_CODBAR = :CODBAR WHERE AUTOINCREM = :AUTINC');
                qryUpdate.ParamByName('CODBAR').AsString := strCodBar;
                qryUpdate.ParamByName('AUTINC').AsString := qryConIte.FieldByName('AUTSEM').AsString;
                qryUpdate.ExecSQL;

                fAtualizaBarFabIte(qryConIte.FieldByName('ITE_CODITE').AsString);
              End;

            End;

          End;
        End;

        If Result And blnImprimeEtiqueta Then
          pImprimeEtiqueta(StrToIntDef(edtQtdEti.Text,0), cdsConsulta, qryCfgRel, strName);
      End;
    End
    Else
    Begin
      if not Assigned(rdbCodBar) then
      Begin
        pMensagemSonora('Item ' + edtCodIte.Text + ' não existe!', True);
      End
      else
      Begin
        If Not(fEmptyStr(fCfgSis('PRBPNE', varString))) Then
          pMensagemSonora('Item ' + edtCodIte.Text + ' não existe!', 'PRBPNE')
        Else
          pMensagemSonora('Item ' + edtCodIte.Text + ' não existe!');
      End;

    End;
  End;

  edtCodIte.Clear;
  edtQtdIte.Text := FormatFloat(fMskDigitos(fCfgSis('DEQTPC', varInteger)), 1);
  edtQtdEti.Text := fCfgSis('ETICEM');

  FreeAndNil(qryConIte);
  FreeAndNil(qryUpdate);
end;

function TConferePreNota.fSomaItem(cdsConsulta: TUniClientDataSet;
  fltQtdIte: Double; stlIncNfe: TStringList): Boolean;
begin
  Result := FALSE;

  With cdsConsulta Do
  Begin
    Try
      Edit;
      FieldByName('ITE_QTDCON').AsFloat := FieldByName('ITE_QTDCON').AsFloat + fltQtdIte;

      If FieldByName('ITE_EMBALA').AsFloat <> 0 Then
          FieldByName('ITE_QTDEMB').AsFloat := FieldByName('ITE_QTDCON').AsFloat / FieldByName('ITE_EMBALA').AsFloat;

      Post;
      pGravaAtualizaGerEle(stlIncNfe, cdsConsulta);
      Result := TRUE;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fSomaItem]');
      End;
    End;
  End;
end;

function TConferePreNota.fValidaPedidoSelec(cdsPedidos: TUniClientDataSet;
  strForSel: String): Boolean;
begin
  Result := True;

  If (Not fEmptyStr(strForSel)) And (Not SameText(strForSel, cdsPedidos.FieldByName('CODFOR').AsString)) Then
  Begin
    fMensagem('','Selecione documentos de mesmo fornecedor!', ['&Ok']);
    Result := False;
  End;

  (*
  If fConferenciaDepoisDaEntrada And (Not blnCancelamentoPreNota) Then
  Begin
    With cdsPedidos Do
      Result := TDateTime(fCampoTabela('GER_DTAENT', 'MOVGER', ['GER_NUMDOC', 'GER_ESPDOC', 'GER_SERIE_', 'GER_CODFOR', 'GER_CODEMP'],
                                                               [cdsPedidos.FieldByName('NUMDOC').AsString,
                                                                cdsPedidos.FieldByName('ESPDOC').AsString,
                                                                cdsPedidos.FieldByName('SERDOC').AsString,
                                                                cdsPedidos.FieldByName('CODFOR').AsString,
                                                                VS_strCodEmp])) > 0;
    If Not Result Then
      pMensagemOK('O Movimento fiscal deste documento não foi realizado, efetive o movimento fiscal para conferir!');
  End;*)

end;

function TConferePreNota.fValidaQuantidades(
  cdsConsulta: TUniClientDataSet; opcTipoOperacao : TipoOperacaoPreNota): Boolean;
begin
  If Not fUtilizaAgendamentoRecebimento(opcTipoOperacao) Then
    Exit(True);

  Result := cdsConsulta.FieldByName('ARC_PODCAN').AsString = 'S';
end;

procedure TConferePreNota.pAtualizaOpeCfr(strCodCfr: String; stlIncNfe: TStringList);
Var
  qryGerEle: TUniQuery;
  intIndex : Integer;
begin
  qryGerEle := fCriaQuery();
  Try
    With qryGerEle, Sql Do
    Begin
      fStartTransaction;
      Close;
      Clear;
      Add(' UPDATE GERELE               ');
      Add('  SET GER_OPECON  = :OPECON  ');
      Add(' WHERE AUTOINCREM = :AUTINC  ');
      For intIndex := 0 To stlIncNfe.Count -1 Do
      Begin
        ParamByName('OPECON').AsString := strCodCfr;
        ParamByName('AUTINC').AsString := stlIncNfe[intIndex];
        ExecSQL;
      End;
      fCommit;
    End;
  Except
    On e:exception do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[pAtualizaOpeCfr]');
    End;
  End;
  FreeAndNil(qryGerEle);
End;

procedure TConferePreNota.pCarregaItensNotaEletronica(stlIncNfe: TStringList;
  qryNotEle: TUniQuery; cdsConsulta: TUniClientDataSet);
  Var
    strSQL: String;
begin
  Try
    If stlIncNfe.Count = 0 Then
      Exit;

    strSQL := '';
    strSQL := strSQL + ' SELECT       ';
    strSQL := strSQL + '   DE.DET_CODITE  AS CODPRO,     ';

    If (fCfgSis('CNVEMB') <> 'N') Then
    Begin
      strSQL := strSQL + '   SUM(ROUND(ROUND(I10_QCOM, 4) * ';

      if fConferenciaDepoisDaEntrada Then
      Begin

        strSQL := strSQL + fGetSQLEmbalagemEntradaMercadorias

      End Else
      Begin
        strSQL := strSQL + '  IF(GER_UNICOM = "N", 1, ';

        strSQL := strSQL + '    IF(DET_EMBALA IS NULL OR DET_EMBALA = 0, ' + fSQLEmbala('CADITE', 'F', 'GER_CODFOR', True) + ', DET_EMBALA)) ';

      End;

      If fConferenciaDepoisDaEntrada Then
        strSQL := strSQL + ', ' + IntToStr(fCfgSis('DEQTEM', varInteger)) + ')) AS QTDPRO, '
      Else
        strSQL := strSQL + ', ' + IntToStr(fCfgSis('DEQTPC', varInteger)) + ')) AS QTDPRO, ';

    End

    Else
      strSQL := strSQL + '   SUM(ROUND(I10_QCOM, 4)) AS QTDPRO, ';

    strSQL := strSQL + '   ITE_DESITE  AS DESITE,       ';
    strSQL := strSQL + '   UNI_SIGUNI  AS DESUNI,       ';
    strSQL := strSQL + '   CADITE.ITE_CODFAB AS CODFAB, ';

    If strCTLEST = '2' Then
      strSQL := strSQL + '  IFNULL(CADLOT.LOT_LOCFIS, ITE_LOCFIS) AS LOCFIS, '
    Else
      strSQL := strSQL + '   ITE_LOCFIS AS LOCFIS,      ';

    strSQL := strSQL + '   ITE_SALDOS  AS SALDOS,       ';
    strSQL := strSQL + 'NE.GER_OPECON  AS OPECON,       ';

    strSQL := strSQL + '   (SELECT COUNT(AUTOINCREM) ';
    strSQL := strSQL + '      FROM CADLOT L ';
    strSQL := strSQL + '     WHERE L.LOT_CODITE = DE.DET_CODITE ';
    strSQL := strSQL + '       AND L.LOT_CODEMP = ITEGER.ITE_CODEMP) AS QTDLOT ';
    strSQL := strSQL + ' FROM                           ';
    strSQL := strSQL + '   DETELE DE                    ';
    strSQL := strSQL + '   INNER JOIN GERELE NE ON DE.DET_SEQGER = NE.AUTOINCREM ';
    strSQL := strSQL + '   INNER JOIN CADITE ON DE.DET_CODITE = CADITE.ITE_CODITE ';
    strSQL := strSQL + '   INNER JOIN ITEGER ON DE.DET_CODITE = ITEGER.ITE_CODITE AND ITEGER.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);

    If strCTLEST = '2' Then
    Begin
      strSQL := strSQL + '  LEFT JOIN CADLOT ON CADLOT.LOT_ARMPRC = "S" AND IFNULL(CADLOT.LOT_LOCFIS, "") <> "" ';
      strSQL := strSQL + '                  AND CADLOT.LOT_CODITE = ITEGER.ITE_CODITE ';
      strSQL := strSQL + '                  AND CADLOT.LOT_CODEMP = ITEGER.ITE_CODEMP ';
    End;

    strSQL := strSQL + '   LEFT  JOIN CADUNI ON CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI ';

    If fCfgSis('TABPRF', varBoolean) Then
    Begin
      strSQL := strSQL + '  LEFT JOIN ITEFOR F ON F.ITE_CODITE = CADITE.ITE_CODITE AND ';
      strSQL := strSQL + '                        F.ITE_CODFOR =   GER_CODFOR AND ';
      strSQL := strSQL + '                        (SELECT COUNT(*) FROM TABPRE      ';
      strSQL := strSQL + '                         WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S" ) > 0 ';
    End;

    strSQL := strSQL + ' WHERE                        ';
    strSQL := strSQL + '   DE.DET_SEQGER IN (' + fListaAutInc(stlIncNfe) + ')';
    strSQL := strSQL + ' GROUP BY                     ';
    strSQL := strSQL + '   DE.DET_CODITE          ';

    With qryNotEle, SQL Do
    Begin
      Close;
      Clear;
      Add(strSQL);
      Open;
      FieldByName('QTDLOT').ProviderFlags := []
    End;

    If blnTrazItensGrid Then
    Begin
      qryNotEle.First;
      While Not qryNotEle.Eof Do
      Begin
        If (Not cdsConsulta.Locate('ITE_CODITE', qryNotEle.FieldByName('CODPRO').AsString,[])) Then
          fIncluiItem(cdsConsulta, qryNotEle.FieldByName('CODPRO').AsString, 0, Nil, False, False, qryNotEle.FieldByName('QTDPRO').AsFloat)
        Else
          pAtualizaQtdTotalItem(cdsConsulta, qryNotEle.FieldByName('CODPRO').AsString, qryNotEle.FieldByName('QTDPRO').AsFloat);
        qryNotEle.Next;
      End;
    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TConferePreNota.pCarregaItensNotaEletronica]');
    End;
  End;
end;

procedure TConferePreNota.pCriticas(cdsConsulta, cdsCriticas: TUniClientDataSet;
  qryNotEle: TUniQuery; edtNotEle, edtCodFor, edtCodCfr: TEditFocus;
  blnTelaColetor: Boolean);
var
  blnTemDados     : Boolean;
  qryCfgRel: TUniQuery;
  strNomImp : String;
  strTipImp : String;
  strOpeCfr: String;
begin
  if not fVerificaAcessoSistema('RELCPN') Then
  Begin
    fMensagem('', 'Usuario sem permissão de acesso!', ['&O k']);
    Exit;
  End;

  If (Not cdsConsulta.Active) Then
    Exit;

  If Not fPosssuiInconsistencias(cdsConsulta, cdsCriticas, qryNotEle) Then
    fMensagem('', 'Não há inconsistências no Documento!', ['&Ok']);

  If (Not cdsCriticas.Active) Then
    Exit;

  Try

    qryCfgRel := fCriaQuery;

    pCarregaConfImpr(qryCfgRel, 'frmRelEntConferencia');
    fPreImpressao(qryCfgRel, strNomImp, strTipImp, False, 'V');

    strOpeCfr := '';
    if Assigned(edtCodCfr) and not (fEmptyStr(edtCodCfr.Text)) then
      strOpeCfr := edtCodCfr.Text;

    blnTemDados := fVerificarDivergencia(cdsCriticas, qryNotEle, edtNotEle, edtCodFor, strOpeCfr);

    if blnTemDados then
    begin
      if Assigned(prcExecutaRelatorio) then
      begin
        If blnTelaColetor then
        begin
          prcExecutaRelatorio(298, 9589, [], [], [], nil);
        end
        else
        begin
          If strTipImp = 'M' Then
            prcExecutaRelatorio(300, 9591, [], [], [], nil)
          Else
           prcExecutaRelatorio(299, 9590, [], [], [], nil);
        end;
      end;
      
    end;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

end;

procedure TConferePreNota.pExcluirItensIncons(cdsConsulta,
  cdsCriticas: TUniClientDataSet);
begin
  cdsCriticas.First;
  While Not cdsCriticas.Eof Do
  Begin
    If cdsConsulta.Locate('ITE_CODITE', cdsCriticas.FieldByName('CODITE').AsString, []) Then
      cdsConsulta.Delete;
    cdsCriticas.Next;
  end;
end;

procedure TConferePrenota.pLimpaDataConf(stlIncNFe: TStringList);
var
  qryGerEle: TUniQuery;
  I:Integer;
begin
  qryGerEle := fCriaQuery;

  With qryGerEle, SQL Do
  Begin
    Add(' UPDATE GERELE ');
    Add('    SET GER_INDCON = NULL,');
    Add('        GER_INHCON = NULL ');
    Add('WHERE AUTOINCREM = :AUTINC');

    For I := 0 To stlIncNFe.Count - 1 Do
    Begin
      ParamByName('AUTINC').AsString := stlIncNFe.Strings[I];
      ExecSQL;
    End;
  End;

  FreeAndNil(qryGerEle);
end;

procedure TConferePreNota.pGerarCodigoBarras(Sender: TObject);
Var
  edtCodigo: TEditFocus;
begin
  edtCodigo := TEditFocus(TBitBtnLocked(Sender).Parent.FindComponent('edtCodigo'));

  If fCfgSis('TIPBAR') = '2' Then
    edtCodigo.Text := fGeraCodBarraEAN39(strCodIteAtu)
  Else
    edtCodigo.Text := fGeraCodBarraEAN13('1' + fStrZero(strCodIteAtu, 11));
end;

procedure TConferePreNota.pGravaAtualizaGerEle(stlIncNfe: TStringList;
  cdsConsulta: TUniClientDataSet);
var
  qryDigEle: TUniQuery;
  intIndex : Integer;
begin

  qryDigEle := fCriaQuery();
  fStartTransaction;
  Try

    With qryDigEle, Sql Do
    Begin

      If fEmptyStr(strIdeDig) Then
      Begin
        strIdeDig := fAtualizaProCod('DIGELE', 'GER_IDEDIG', 'GERELE');
        objDistribuicaoConferencia.SetIdeDig(strIdeDig);
        Close;
        Clear;

        Add('UPDATE GERELE');
        Add('  SET GER_IDEDIG = :IDEDIG,');
        Add('      GER_INHCON = :INHCON,');
        Add('      GER_INDCON = :INDCON ');
        Add('WHERE AUTOINCREM = :AUTINC ');

        ParamByName('INDCON').AsDate := Date;
        ParamByName('INHCON').AsTime := fTime();

        For intIndex := 0 To stlIncNfe.Count -1 Do
        Begin
          ParamByName('AUTINC').AsString := stlIncNfe[intIndex];
          ParamByName('IDEDIG').AsString := strIdeDig;

          ExecSQL;
        End;

      End;

      Close;
      Clear;

      Add('UPDATE GERELE');
      Add('  SET GER_INHCON = :INHCON,');
      Add('      GER_INDCON = :INDCON ');
      Add('WHERE AUTOINCREM = :AUTINC ');
      Add('    AND GER_INDCON IS NULL ');
      Add('    AND GER_INHCON IS NULL ');

      ParamByName('INDCON').AsDate := Date;
      ParamByName('INHCON').AsTime := fTime();

      For intIndex := 0 To stlIncNfe.Count -1 Do
      Begin
        ParamByName('AUTINC').AsString := stlIncNfe[intIndex];
        ExecSQL;
      End;


      if fEmptyStr(cdsConsulta.FieldByName('AUTOINCREM').AsString) Then
      Begin
        Clear;
        Add('SELECT * FROM DIGELE WHERE FALSE');
        Open;

        qryDigEle.Append;

        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DIGELE', VS_strCodEmp);

        cdsConsulta.Edit;
        cdsConsulta.FieldByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;
        cdsConsulta.Post;

      End
      Else
      Begin
        Clear;
        Add('SELECT * FROM DIGELE WHERE AUTOINCREM = :AUTOIN');

        ParamByName('AUTOIN').AsString := cdsConsulta.FieldByName('AUTOINCREM').AsString;

        Open;

        qryDigEle.Edit;

      End;

      FieldByName('DIG_CODEMP').AsString := VS_strCodEmp;
      FieldByName('DIG_IDEDIG').AsString := strIdeDig;
      FieldByName('DIG_TIPBUS').AsString := FTipoDigitacao;
      FieldByName('DIG_CODITE').AsString := cdsConsulta.FieldByName('ITE_CODITE').AsString;
      FieldByName('DIG_QTDITE').AsFloat  := cdsConsulta.FieldByName('ITE_QTDCON').AsFloat;

      Post;
      fCommit;
    End;
  Except
    On e:exception do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[fIncluiItem]');
    End;
  End;
  FreeAndNil(qryDigEle);
End;

Function TConferePreNota.fRetAutoIncEntrada(strAutGerEle: String): String;
  Var
    qryMovGer: TUniQuery;
    strSQL: String;
Begin
  Result := '';

  qryMovGer := fCriaQuery;
  With qryMovGer Do
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT         ';
    strSQL := strSQL + '   M.AUTOINCREM ';
    strSQL := strSQL + ' FROM           ';
    strSQL := strSQL + '   MOVGER M     ';

    strSQL := strSQL + '   INNER JOIN GERELE NE ON ';
    strSQL := strSQL + '                     NE.GER_DOCENT = M.GER_NUMDOC ';
    strSQL := strSQL + '                 AND NE.GER_ESPENT = M.GER_ESPDOC ';
    strSQL := strSQL + '                 AND NE.GER_CODFOR = M.GER_CODFOR ';
    strSQL := strSQL + '                 AND NE.GER_CODEMP = M.GER_CODEMP ';
    strSQL := strSQL + '                 AND NE.B07_SERIE  = M.GER_SERIE_ ';

    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   NE.AUTOINCREM = :AUTGER ';

    SQL.Text := strSQL;

    ParamByName('AUTGER').AsString := strAutGerEle;

    Open;

    If Not IsEmpty Then
      Result := FieldByName('AUTOINCREM').AsString;

  End;
  FreeAndNil(qryMovGer);
End;

Function TConferePreNota.fGravaConferencia(cdsConsulta, cdsCriticas: TUniClientDataSet;
	edtNotEle, edtCodFor: TEditFocus; qryNotEle: TUniQuery; stlIncNfe: TStringList; strOpeCfr: String = ''): Boolean;
var
    qryDigEle: TUniQuery;
    blnLiberado: Boolean;
    intIndex: Integer;
    strOpeLib: String;
    blnRefugo: Boolean;
    objLiberacao : TLiberacao;
    strLinha: string;
    intMsgRefugo : Integer;
    intOpcao: integer;
    blnTeveConferencia: Boolean;
    const
      cstrTitiColDetalhe = 'Item                                                                Qtd. NFe.         Contagem';
    function fPedeSenhaLiberacao: Boolean;
    var
      blnTelaResumida: Boolean;
    begin

      objLiberacao.objMsgLibera.pAddTexto('Liberação na Conferência de Mercadorias (Pré-Nota) com inconsistências');
      objLiberacao.objMsgLibera.pAddTextoCaption('Documentos'  , edtNotEle.Text, 16);

      if Assigned(edtCodFor) then
      begin
        objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor', edtCodFor.Text, 16);
        blnTelaResumida := False;
        If (Pos('-', edtCodFor.Text) > 0) And (Not fEmptyStr(edtCodFor.Text)) Then
          strCdiFor := SplitString(edtCodFor.Text, '-')[0];
      end
      else
      begin
        objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor', strCodFor     , 16);
        blnTelaResumida := True;
      end;
      //Corpo da mensagem;
      cdsCriticas.Filtered := False;
      cdsCriticas.Filter := 'QTDITE <> QTDCON';
      cdsCriticas.Filtered := True;
      If cdsCriticas.RecordCount > 0 Then
      Begin
        objLiberacao.objMsgRemota.pAddSeparador(95);
        objLiberacao.objMsgRemota.pAddTexto(cstrTitiColDetalhe);
        While Not cdsCriticas.EoF do
        Begin
          strLinha := StringOfChar(' ', 95);
          Insert(Copy(cdsCriticas.FieldByName('CODITE').AsString + ' - ' + cdsCriticas.FieldByName('DESITE').AsString,0, 67), strLinha, 0);
          Insert(cdsCriticas.FieldByName('QTDITE').AsString, strLinha, 79 - Length(cdsCriticas.FieldByName('QTDITE').AsString));
          Insert(cdsCriticas.FieldByName('QTDCON').AsString, strLinha, 95 - Length(cdsCriticas.FieldByName('QTDCON').AsString));
          objLiberacao.objMsgRemota.pAddTexto(Copy(strLinha, 0, 95));
          cdsCriticas.Next;
        End;
      End;
      cdsCriticas.Filtered := False;

      objLiberacao.strDirAce := 'ENTLIB';
      objLiberacao.strSenLib := fCfgSis('SENLBC');
      objLiberacao.strMsgSen := 'Conferência de Mercadorias (Pré-Nota)';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.blnTelaResumida := blnTelaResumida;


      Result := objLiberacao.fLibera;

      strOpeLib := objLiberacao.strOperador;

      If Result Then
      Begin
        pGeraLogLiberacao(strNumDoc, strSerDoc, VS_strCodEmp);
      End
      Else
        strOpeLib := '';
    End;

    function fTeveConferencia(ADataSet: TUniClientDataSet): Boolean;
      var
        bkpFilter: String;
        bkpFiltered: Boolean;
    begin
      Result := False;
      If ADataSet.IsEmpty then
         Exit(False);
      bkpFilter := ADataSet.Filter;
      bkpFiltered := ADataSet.Filtered;
      Try
        ADataSet.Filtered := False;
        ADataSet.Filter := 'ITE_QTDCON > 0';
        ADataSet.Filtered := True;
        result := not ADataSet.IsEmpty;
      finally
        ADataSet.Filter := bkpFilter;
        ADataSet.Filtered := bkpFiltered;
      End;
    end;

begin
  intOpcao := 0;
  objLiberacao := TLiberacao.Create;
  try
    Try
      Result := False;

      blnGravou := True;
      strOpeLib   := '';

      blnLiberado := (Not fPosssuiInconsistencias(cdsConsulta, cdsCriticas, qryNotEle));

      If Not blnLiberado Then
      Begin
        blnLiberado := fPedeSenhaLiberacao;

        If Not blnLiberado Then
        Begin
          blnGravou := False;
          Exit;
        End;
      End;

      If blnPedCompraGarantia And blnLiberado Then
      Begin
        Repeat
          //Quando o produto tem que voltar exatamente para o cliente não é permitdo cancelar a digitação de refugo, é obrigatorio informar todas as qtdes;
          blnRefugo := TfrmEntConfPreNotaGarantiaDigRefugo.fDigitaRefugos(stlIncNfe);
          If not blnRefugo Then
          Begin
            intMsgRefugo := fMensagem('','Não é possível continuar sem informar as baixas da garantia, deseja informar as baixas?' , ['&Sim', '&Não'], 2);

            if intMsgRefugo = 2 Then
            Begin
              blnGravou := False;
              Exit;
            End;

          End;

        Until blnRefugo;

      End;

      blnTeveConferencia := fTeveConferencia(cdsConsulta);

      If (Not blnTeveConferencia) And (fCfgSis('UDEVME', varBoolean)) then
      begin
         intOpcao := fMensagem('','Não teve conferência deseja mandar os items para?', ['Endereçar', 'Devolver'], 1);
         objDistribuicaoConferencia.LiberadoEnderecamentoSemConferencia := intOpcao = 1;
      End;

      fStartTransaction;
      blnGeraDigEleAutomatica := False;
      If (fCfgSis('TIPPNT', varString) = 'D') and fEmptyStr(strIdeDig) then
      begin
        strIdeDig := fAtualizaProCod('DIGELE', 'GER_IDEDIG', 'GERELE');
        objDistribuicaoConferencia.SetIdeDig(strIdeDig);
        blnGeraDigEleAutomatica := True;
      end;
      If  (fCfgSis('TIPPNT', varString) = 'D') and (Not fEmptyStr(strIdeDig)) And (cdsConsulta.IsEmpty) Then
      begin
        blnGeraDigEleAutomatica := True;
      End;

      If (fCfgSis('LOGENT') = 'S') Then
      Begin
        if fVerificarDivergencia(cdsCriticas, qryNotEle, edtNotEle, edtCodFor, strOpeCfr) then
        Begin
          fStartTransaction;
          Result := TfrmEntPreNotaEntradaMotivoLib.fRegistraMotivo(dtaDtaDoc,
                                                               strNumDoc,
                                                               'NF', //recNotEle.strEspDoc,
                                                               strSerDoc,
                                                               strCdiFor,
                                                               VS_strCodEmp,
                                                               'F', //recNotEle.strTipoFc,
                                                               strOpeCfr,
                                                               strDiverge,
                                                               tmEntrada);
          if Not Result then
          begin
            fRollback;
            Exit;
          end
        End;
      End;

      If Not fInTransaction then
        fStartTransaction;

      qryDigEle := fCriaQuery();

      With qryDigEle, SQL Do
      Begin
        cdsConsulta.First;

        Close;
        Clear;

        Add('UPDATE GERELE');
        Add('  SET GER_IDEDIG = :IDEDIG ');

        If blnLiberado Then
        Begin
          Add(' ,GER_DTACON = :DTACON ');
          Add(' ,GER_HORCON = :HORCON ');
          Add(' ,GER_OPECON = :OPECON  ');
        End;
        Add(' ,GER_SEMCON = :SEMCON  ');
        Add(' ,GER_ENDDEV = :ENDDEV  ');
        Add('WHERE AUTOINCREM = :AUTINC');

        For intIndex := 0 To stlIncNfe.Count -1 Do
        Begin
          ParamByName('AUTINC').AsString := stlIncNfe[intIndex];
          ParamByName('IDEDIG').AsString := strIdeDig;

          If blnLiberado Then
          Begin
            ParamByName('DTACON').AsDate   := VS_Date;
            ParamByName('HORCON').AsTime   := fTime();

            If Not fEmptyStr(strOpeLib) Then
              ParamByName('OPECON').AsString := strOpeLib
            Else
              ParamByName('OPECON').AsString := IIF(fEmptyStr(strOpeCfr),strLoginUsuarioLogado, strOpeCfr);
          End;
          ParamByName('SEMCON').AsString := 'S';
          If blnTeveConferencia Then
            ParamByName('SEMCON').AsString := 'N';

          ParamByName('ENDDEV').AsInteger := intOpcao;
          ExecSQL;

          TDefineBaixaPedido.ProcessaStatusPedidoRequisicaoConferencia(stlIncNfe[intIndex]);


          If (VS_strHabilitarCRM) Then
            pGeraHisOcoConferencia(stlIncNfe[intIndex], afcPedidoPreNotaConferida);
        End;

      End;

      FreeAndNil(qryDigEle);
      If (fCfgSis('TIPPNT', varString) = 'D') Then
      begin
        If Not cdsConsulta.IsEmpty Then
          fIncNfe(stlIncNfe).fConsulta(cdsConsulta) .fLiberarEnderecamentoParcial;
        fIncNfe(stlIncNfe).fConsulta(cdsConsulta).pFinalizaConferencia;
      End;
      fCommit;

      Result := True;

      If blnLiberado Then
      Begin
        If not fConferenciaDepoisDaEntrada Then
          pMensagemOk('Documento(s) liberado para entrada de mercadorias!')
        Else
          pMensagemOk('Documento Conferido com Sucesso!');
      End
      Else
      Begin
        pMensagemOk('Existem inconsistências na leitura dos produtos. ' + #13#10 +
                    'Entrar em contato com departamento de compras!');
        blnGravou := False;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '');
      End;
    End;
  finally
    FreeAndNil(objLiberacao);
  end;
end;

procedure TConferePreNota.pImprimeEtiqueta(intQtdIte: Integer; cdsConsulta: TUniClientDataSet;
	qryCfgRel: TUniQuery; strName: TComponentName; blnTodosItens: boolean = False; strDigEle: string = '');
  Var
    qryIteEti: TUniQuery;
    lcdsIteEti: TZClient;
    DataSetEti: TDataSet;
    strNomFil: String;
    prmDllEtq: TParamDllEtiquetas;
    i, x: integer;
begin
  inherited;
  Try
    Try
      qryIteEti := fCriarQuery(fGetSqlItemEtiqueta(cdsConsulta.FieldByName('ITE_CODITE').AsString, intQtdIte, blnTodosItens, strDigEle, (not blnTodosItens)));

      qryIteEti.Open;
      If not blnTodosItens then
      begin
        lcdsIteEti := TZClient.Create(nil, fGetSqlItemEtiqueta(cdsConsulta.FieldByName('ITE_CODITE').AsString, intQtdIte, blnTodosItens, strDigEle, (not blnTodosItens)));
        lcdsIteEti.fAbreClient(False, 'TConferePreNota.pImprimeEtiqueta');
        for i := 2 To intQtdIte do
        begin
          lcdsIteEti.Insert;
          For x := 0 to qryIteEti.Fields.Count -1 do
            lcdsIteEti.Fields[x].Value := qryIteEti.Fields[x].Value;
          lcdsIteEti.Post;
        end;
        DataSetEti := lcdsIteEti;
      End
      Else
        DataSetEti := qryIteEti;
      pCarregaConfImpr(qryCfgRel, strName);
      strNomFil := qryCfgRel.FieldByName('REL_NOMFIL').AsString;

      prmDllEtq := TParamDllEtiquetas.Create;

      prmDllEtq.tpeTipEtq := tpeEtique;
      prmDllEtq.intTabPre := intTabPre;
      prmDllEtq.dtsImpres := DataSetEti;
      prmDllEtq.strNomFil := strNomFil;
      prmDllEtq.strNomFrm := strName;
      prmDllEtq.intNumCop := 1;
      prmDllEtq.blnImpEti := True;
      prmDllEtq.blnUsfrxU := blnTodosItens;

      fImprimeEtiqueta(prmDllEtq, 'fImprimeEtiquetaGeral');

      FreeAndNil(prmDllEtq);

    Except

      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmEntConferPreNota.pImprimeEtiqueta]');
      End;

    End;
  finally
    If Assigned(qryIteEti) then
      FreeAndNil(qryIteEti);
    If not blnTodosItens then
      If Assigned(lcdsIteEti) then
        FreeAndNil(lcdsIteEti);
  End;
end;

procedure TConferePreNota.pIncluiCritica(strCodIte,
                             strDesIte,
                             strDesUni,
                             strCodFab,
                             strLocFis: String;
                             fltQtdIte,
                             fltQtdCon,
                             fltSaldos,
                             fltQtdXML: Double;
                             intQtdLot: Integer;
  cdsCriticas: TUniClientDataSet);
begin
  With cdsCriticas Do
  Begin
    Insert;
    FieldByName('CODITE').AsString := strCodIte;
    FieldByName('DESITE').AsString := strDesIte;
    FieldByName('CODFAB').AsString := strCodFab;
    FieldByName('LOCFIS').AsString := iif(intQtdLot > 0, 'ITEM C/ LOTE', strLocFis);
    FieldByName('DESUNI').AsString := strDesUni;
    FieldByName('QTDITE').AsFloat  := fltQtdIte;
    FieldByName('QTDCON').AsFloat  := fltQtdCon;
    FieldByName('SALDOS').AsFloat  := fltSaldos;
    FieldByName('QTDXML').AsFloat  := fltQtdXML;
    Post;
  End;
end;

procedure TConferePreNota.pLiberaDocumentos(stlIncNfe: TStringList);
Var
  intIndice: Integer;
begin
  For intIndice := 0 To stlIncNfe.Count -1 Do
    fLock_Unlock('NFE' + stlIncNfe[intIndice], False, False);
end;

procedure TConferePreNota.pLimpaConferencia(cdsConsulta: TUniClientDataSet);
begin
  If Not cdsConsulta.isEmpty THen
    cdsConsulta.EmptyDataSet;
end;

procedure TConferePreNota.pLimpaSeqConf(strAutoInc: String);
var
  qryGerEle: TUniQuery;
  erro: String;
begin
  qryGerEle := fCriaQuery;

  With qryGerEle, SQL Do
  Begin
    Try
      Add('UPDATE GERELE');
      Add('   SET GER_IDEDIG = NULL, ');
      Add('       GER_DTACON = NULL, ');
      Add('       GER_HORCON = NULL, ');
      Add('       GER_INHCON = NULL, ');
      Add('       GER_INDCON = NULL, ');
      Add('       GER_OPECON = NULL  ');
      Add(' WHERE AUTOINCREM = :AUTINC');

      ParamByName('AUTINC').AsString := strAutoInc;

      ExecSQL;
      objDistribuicaoConferencia.fCancelaConferenciaBaixada(erro);
    Finally
      FreeAndNil(qryGerEle);
    End;
  End;

end;

procedure TConferePreNota.pRetProdutoBarEmb(const strBarEmb: String;
  var strCodIte: String; var fltEmbala: Double);
Var
  strSQL   : String;
  qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  BAR_CODITE, ';
    strSQL := strSQL + '  BAR_EMBALA  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEBAR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  BAR_CODBAR = :BAREMB ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('BAREMB').AsString := strBarEmb;
      Open;

      strCodIte := FieldByName('BAR_CODITE').AsString;
      fltEmbala := FieldByName('BAR_EMBALA').AsFloat;

      Close;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;
end;

procedure TConferePreNota.pSetaRequeridos(cdsConsulta: TUniClientDataSet);
Var
  intIndex: Integer;
Begin
  With cdsConsulta Do
  For intIndex := 0 To FieldDefs.Count - 1 Do
    FieldDefs[intIndex].Required := FALSE;
end;

procedure TConferePreNota.pVerificaItensAmais(cdsConsulta,
  cdsCriticas: TUniClientDataSet; qryNotEle: TUniQuery);
begin
  With cdsConsulta Do
  Begin
    DisableControls;

    First;
    While Not Eof Do
    Begin
      pIncluiCritica(FieldByName('ITE_CODITE').AsString,
                     FieldByName('ITE_DESITE').AsString,
                     FieldByName('ITE_DESUNI').AsString,
                     FieldByName('ITE_CODFAB').AsString,
                     FieldByName('ITE_LOCFIS').AsString,
                     IIF(qryNotEle.Locate('CODPRO',FieldByName('ITE_CODITE').AsString, []), qryNotEle.FieldByName('QTDPRO').AsFloat, 0),
                     FieldByName('ITE_QTDCON').AsFloat,
                     FieldByName('ITE_SALDOS').AsFloat,
                     IIF(qryNotEle.Locate('CODPRO',FieldByName('ITE_CODITE').AsString, []), qryNotEle.FieldByName('QTDPRO').AsFloat, 0),
                     qryNotEle.FieldByName('QTDLOT').AsInteger,
                     cdsCriticas);
      Next;
    End;

    EnableControls;
  End;
end;

procedure TConferePreNota.pVerificaItensAmenos(cdsConsulta,
  cdsCriticas: TUniClientDataSet; qryNotEle: TUniQuery);
  var DataSetNotifyEvent : TDataSetNotifyEvent;
begin
  DataSetNotifyEvent := cdsConsulta.AfterScroll;
  cdsConsulta.AfterScroll := nil;
  Try
    With cdsConsulta Do
    Begin
      DisableControls;

      qryNotEle.First;

      While Not qryNotEle.Eof Do
      Begin
        cdsConsulta.First;
        If Not Locate('ITE_CODITE',qryNotEle.FieldByName('CODPRO').AsString, []) Then
          pIncluiCritica(qryNotEle.FieldByName('CODPRO').AsString,
                         qryNotEle.FieldByName('DESITE').AsString,
                         qryNotEle.FieldByName('DESUNI').AsString,
                         qryNotEle.FieldByName('CODFAB').AsString,
                         qryNotEle.FieldByName('LOCFIS').AsString,
                         qryNotEle.FieldByName('QTDPRO').AsFloat,
                         0,
                         qryNotEle.FieldByName('SALDOS').AsFloat,
                         qryNotEle.FieldByName('QTDPRO').AsFloat,
                         qryNotEle.FieldByName('QTDLOT').AsInteger,
                         cdsCriticas);
        qryNotEle.Next;
      End;

      EnableControls;
    End;
  Finally
    cdsConsulta.AfterScroll := DataSetNotifyEvent;
  End;
end;

// PASSAR O AUTINC DO DETELE
function TConferePreNota.fGetSQLEmbalagemEntradaMercadorias : String;
Begin
  Result := ' ( ';
  Result := Result + ' SELECT MAX(IF(IFNULL(TRI_EMBALA,1) <= 0, 1, IFNULL(TRI_EMBALA,1))) ';
  Result := Result + ' FROM MOVDET M                                                      ';
  Result := Result + '   INNER JOIN MOVTRI T ON T.DET_SEQGER = M.AUTOINCREM ';
  Result := Result + ' WHERE M.DET_NUMDOC = NE.GER_DOCENT  ';
  Result := Result + '   AND M.DET_ESPDOC = NE.GER_ESPENT  ';
  Result := Result + '   AND M.DET_CODEMP = NE.GER_EMPENT  ';
  Result := Result + '   AND M.DET_SERIE_ = NE.B07_SERIE   ';
  Result := Result + '   AND M.DET_CODFOR = NE.GER_CODFOR  ';
  Result := Result + '   AND M.DET_CODITE = DE.DET_CODITE) ';

End;

function TConferePreNota.fVerificarDivergencia(cdsCriticas: TUniClientDataSet; qryNotEle: TUniQuery;
  edtNotEle, edtCodFor: TEditFocus; var strOpeCfr: string): Boolean;
Var
  qryEntCon: TUniQuery;
  strCodCfr: string;
  blnFil : Boolean;
Begin
  If cdsCriticas.IsEmpty Then
    Exit(False);

  Result := True;
  strDiverge := '';
  cdsCriticas.First;
  Try
    qryEntCon := fCriaQuery;
    qryEntCon.SQL.Clear;
    qryEntCon.SQL.Add('DROP TEMPORARY TABLE IF EXISTS TMP_ENTCON;');
    qryEntCon.SQL.Add('CREATE TEMPORARY TABLE TMP_ENTCON(        ');
    qryEntCon.SQL.Add('  TMP_CODITE VARCHAR(30),                 ');
    qryEntCon.SQL.Add('  TMP_CODFAB VARCHAR(20),                 ');
    qryEntCon.SQL.Add('  TMP_DESITE VARCHAR(70),                 ');
    qryEntCon.SQL.Add('  TMP_DESUNI VARCHAR(5),                  ');
    qryEntCon.SQL.Add('  TMP_LOCFIS VARCHAR(20),                 ');
    qryEntCon.SQL.Add('  TMP_SALDOS DECIMAL(19,4) DEFAULT NULL,  ');
    qryEntCon.SQL.Add('  TMP_QTDXML DECIMAL(19,4) DEFAULT NULL,  ');
    qryEntCon.SQL.Add('  TMP_QTDITE DECIMAL(19,4) DEFAULT NULL,  ');
    qryEntCon.SQL.Add('  TMP_QTDCON DECIMAL(19,4) DEFAULT NULL   ');
    qryEntCon.SQL.Add(');                                        ');
    qryEntCon.ExecSQL;

    qryNotEle.Refresh;

    if not (fEmptyStr(qryNotEle.FieldByName('OPECON').AsString)) then
      strCodCfr := qryNotEle.FieldByName('OPECON').AsString
    else if not fEmptyStr(strOpeCfr) then
      strCodCfr := strOpeCfr
    else
      strCodCfr := strLoginUsuarioLogado;

    {Operador que será gravado na tabela LIBPRN}
    strOpeCfr := strCodCfr;

    If fEmptyStr(strCodFor) And Assigned(edtCodFor) And Not fEmptyStr(edtCodFor.Text) Then
       strCodFor := edtCodFor.Text;

    qryEntCon.SQL.Clear;
    qryEntCon.SQL.Add('SET @MOSTRAQTD = "' + IIF(fVerificaAcessoSistema('ENTCRI', strLoginUsuarioLogado), 'S', 'N') + '";');
    qryEntCon.SQL.Add('SET @PEDIDO = "DOCUMENTO(S): ' + edtNotEle.Text + '";');
    qryEntCon.SQL.Add('SET @LOJA = "LOJA: ' + VS_strCodEmp + ' - ' + fRetNomeEmpresa + '";');
    qryEntCon.SQL.Add('SET @FORNECEDOR = "FORNECEDOR: ' + strCodFor + '";');
    qryEntCon.SQL.Add('SET @CONFERENTE = "CONFERENTE: ' + strCodCfr + ' - ' + fRetNomeOperador(strCodCfr) + '";');
    qryEntCon.ExecSQL;

    blnFil := cdsCriticas.Filtered;
    cdsCriticas.Filtered := False;

    while not cdsCriticas.Eof do
    Begin
      qryEntCon.SQL.Clear;
      qryEntCon.SQL.Add('INSERT INTO TMP_ENTCON(');
      qryEntCon.SQL.Add('  TMP_CODITE, TMP_CODFAB, TMP_DESITE, TMP_DESUNI, TMP_LOCFIS, TMP_SALDOS, TMP_QTDXML, TMP_QTDITE, TMP_QTDCON');
      qryEntCon.SQL.Add(')VALUES(');
      qryEntCon.SQL.Add('  :CODITE, :CODFAB, :DESITE, :DESUNI, :LOCFIS, :SALDOS, :QTDXML, :QTDITE, :QTDCON');
      qryEntCon.SQL.Add(');');
      qryEntCon.ParamByName('CODITE').AsString := cdsCriticas.FieldByName('CODITE').AsString;
      qryEntCon.ParamByName('CODFAB').AsString := cdsCriticas.FieldByName('CODFAB').AsString;
      qryEntCon.ParamByName('DESITE').AsString := cdsCriticas.FieldByName('DESITE').AsString;
      qryEntCon.ParamByName('DESUNI').AsString := cdsCriticas.FieldByName('DESUNI').AsString;
      qryEntCon.ParamByName('LOCFIS').AsString := cdsCriticas.FieldByName('LOCFIS').AsString;
      qryEntCon.ParamByName('SALDOS').AsFloat  := cdsCriticas.FieldByName('SALDOS').AsFloat;
      qryEntCon.ParamByName('QTDXML').AsFloat  := cdsCriticas.FieldByName('QTDXML').AsFloat;
      qryEntCon.ParamByName('QTDITE').AsFloat  := cdsCriticas.FieldByName('QTDITE').AsFloat;
      qryEntCon.ParamByName('QTDCON').AsFloat  := cdsCriticas.FieldByName('QTDCON').AsFloat;
      qryEntCon.ExecSQL;


      If cdsCriticas.FieldByName('QTDCON').AsFloat <> cdsCriticas.FieldByName('QTDITE').AsFloat Then
      Begin
        strDiverge := strDiverge+  cdsCriticas.FieldByName('CODITE').AsString + ' - '  + cdsCriticas.FieldByName('DESITE').AsString +
          'Qtd. Pedido: ' + cdsCriticas.FieldByName('QTDITE').AsString +
          ' Qtd. Conferida: ' + cdsCriticas.FieldByName('QTDCON').AsString + #13;
      End;
      cdsCriticas.Next;
    End;

    cdsCriticas.Filtered := blnFil;
  Finally
    FreeAndNil(qryEntCon)
  End;
End;

function TConferePreNota.fUtilizaAgendamentoRecebimento(opcTipoOperacao : TipoOperacaoPreNota = opeConferencia) : boolean;
begin
  Result := fUsaRotinaWMS And fConferenciaDepoisDaEntrada and (fCfgSis('TPLREC', varString) <> 'N') And (opcTipoOperacao In [opeConferencia, opeCancelaConferencia]);
end;

procedure TConferePreNota.pBeforePost(DataSet: TDataSet);
begin
  If DataSet.FieldByName('ITE_QTDCON').AsFloat = 0 Then
    Exit;

  If DataSet.FieldByName('ITE_QTDCON').AsFloat = DataSet.FieldByName('ITE_QTDTOT').AsFloat Then
    DataSet.FieldByName('STATUS_CONF').AsString := 'C'
  Else
    DataSet.FieldByName('STATUS_CONF').AsString := 'I';
end;

procedure TConferePreNota.pAtualizaQtdTotalItem(ACdsDados: TUniClientDataSet; AStrCodIte: String; AFltQtdTotal: Double);
begin
  ACdsDados.Edit;
  ACdsDados.FieldByName('ITE_QTDTOT').AsFloat := AFltQtdTotal;
  ACdsDados.Post;
end;

function TConferePreNota.fAjustaItem(cdsConsulta: TUniClientDataSet;
  fltQtdIte: Double; stlIncNfe: TStringList): Boolean;
begin
  Result := False;

  With cdsConsulta Do
  Begin
    Try
      Edit;
      FieldByName('ITE_QTDCON').AsFloat := fltQtdIte;
      FieldByName('ITE_QTDEDR').AsFloat := fltQtdIte;

      If FieldByName('ITE_EMBALA').AsFloat <> 0 Then
          FieldByName('ITE_QTDEMB').AsFloat := FieldByName('ITE_QTDCON').AsFloat / FieldByName('ITE_EMBALA').AsFloat;

      ObjDistribuicaoConferencia.DesfazerConferenciaItem(cdsConsulta.FieldByName('ITE_CODITE').AsString);
      ObjDistribuicaoConferencia.ConferirItem(cdsConsulta.FieldByName('ITE_CODITE').AsString, fltQtdIte);

      Post;
      pGravaAtualizaGerEle(stlIncNfe, cdsConsulta);
      Result := TRUE;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[fAjustaItem]');
      End;
    End;
  End;
end;

Function TConferePreNota.fLiberacaoParaLiberarEnderecamento(edtNotEle: TEditFocus): Boolean;
var
  objLiberacao : TLiberacao;
Begin
  If fVerificaAcessoSistema('LIMEND', strLoginUsuarioLogado) Then
    Exit(True);
  objLiberacao := TLiberacao.Create;
  try
    objLiberacao.objMsgLibera.pAddTexto('Liberação na Conferência de Mercadorias (Pré-Nota) ');
    objLiberacao.objMsgLibera.pAddTextoCaption('Documentos'  , edtNotEle.Text, 16);
    objLiberacao.objMsgLibera.pAddTextoCaption('Solicitação:', 'Liberação para endereçar parcialmente o documento', 16);
    objLiberacao.strDirAce := 'LIMEND';
    objLiberacao.strMsgSen := 'Conferência de Mercadorias (Pré-Nota)';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.blnTelaResumida := False;
    Result := objLiberacao.fLibera;
    strOpeLib := objLiberacao.strOperador;
  finally
    FreeAndNil(objLiberacao)
  End;
End;

Function TConferePreNota.fLiberacaoParaLimparConferencia(edtNotEle: TEditFocus): Boolean;
var
  objLiberacao : TLiberacao;
Begin
  If fVerificaAcessoSistema('LIMCON', strLoginUsuarioLogado) Then
    Exit(True);
  objLiberacao := TLiberacao.Create;
  try
    objLiberacao.objMsgLibera.pAddTexto('Liberação na Conferência de Mercadorias (Pré-Nota) ');
    objLiberacao.objMsgLibera.pAddTextoCaption('Documentos'  , edtNotEle.Text, 16);
    objLiberacao.objMsgLibera.pAddTextoCaption('Solicitação:', 'Liberação para limpar a conferência', 16);
    objLiberacao.strDirAce := 'LIMCON';
    objLiberacao.strMsgSen := 'Conferência de Mercadorias (Pré-Nota)';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.blnTelaResumida := False;
    Result := objLiberacao.fLibera;
    strOpeLib := objLiberacao.strOperador;
  finally
    FreeAndNil(objLiberacao)
  End;
End;

function TConferePreNota.fExisteConferenciaParcial(ACodIte: String = ''): Boolean;
Var
  qryDigCon: TUniQuery;
begin
  If Not blnCofEnd then
    Exit(False);
  qryDigCon := fCriaQuery;
  Try
    qryDigCon.SQL.Add('SELECT 1 FROM DIGCON ');
    qryDigCon.SQL.Add(' WHERE DIC_SEQGER = "' + strSeqFgo + '"');
    If not fEmptyStr(ACodIte) Then
      qryDigCon.SQL.Add('   AND DIC_CODITE = "'+ACodIte+'"');
    qryDigCon.SQL.Add('LIMIT 1');
    qryDigCon.Open;
    Result := (Not qryDigCon.IsEmpty) And blnCofEnd;
  Finally
    pFreeAndNil(qryDigCon);
  End;
end;

function TConferePreNota.fIncNfe(stlIncNfe: TStringList): TConferePreNota;
begin
  Result := Self;
  FstlIncNfe := stlIncNfe;
end;

procedure TConferePreNota.pFinalizaConferencia;
Begin
  //Gravar demais itens das notas que não tenham conferencia
  ObjDistribuicaoConferencia.fFinalizaConferencia;
End;

function TConferePreNota.fLiberarEnderecamentoParcial: Boolean;
Begin
  Result := ObjDistribuicaoConferencia.fGravaLiberacaoEnderecamento;
End;

function TConferePreNota.fConsulta(cdsConsulta: TUniClientDataSet): TConferePreNota;
begin
  Result := Self;
  FcdsConsulta := cdsConsulta;
end;

destructor TConferePreNota.Destroy;
begin
  If Assigned(ObjDistribuicaoConferencia) then
    FreeAndNil(ObjDistribuicaoConferencia);
  inherited;
end;




end.
