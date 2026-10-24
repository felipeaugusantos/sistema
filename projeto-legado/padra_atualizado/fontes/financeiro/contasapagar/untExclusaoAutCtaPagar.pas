unit untExclusaoAutCtaPagar;

interface

uses
  Windows, Classes, Controls, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids, Mask,
  MaskEditFocus, EditFocus, ComCtrls, Buttons, ExtCtrls, DB, Menus, Uni, frxClass,
  frxDMPExport, frxDBSet, AppEvnts, UniClientDataSet, untFuncoesSimples,
  CurrencyEditFocus, untReciboCtp, untFastPrintEditor, cxStyles, Math,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGrid, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, untTypesSistema, cxNavigator, frxExportCSVTestabilidade, cxProgressBar,
  Forms, System.Generics.Collections, untTMovBan, untTMovBanRepository,
  cxContainer, cxTextEdit, cxCurrencyEdit,Generics.Defaults,
  dxCore, cxDateUtils, cxMaskEdit, cxDropDownEdit, cxCalendar,
  untTCadPag, untTCadPagRepository, MemoFocus, untAltValor,
  cxDataControllerConditionalFormattingRulesManagerDialog, untLiberacao, untTLock,
  untFechamentoFinanceiro,untMsgLiberacao, dxScreenTip, dxCustomHint, cxHint,
  cxButtons;


type

  TSaidaImpressao = (tsiVideo, tsiImpressao);

  TCtpInfo = record
    strCodFor: String;
    strHist01: String;
    strHist02: String;
  End;

  TModal = Record
    fltDin: Double;
    fltCqV: Double;
    fltOrd: Double;
    fltRep: Double;
    fltTot: Double;
  End;

  TDescontoGeral = Record
    fltValDes: Double;
    fltValBxa: Double;
    blnConfir: Boolean;
    strTipDes: String
  End;

  TfrmExclusaoAutCtaPagar = class(TfrmPaiSimples)
    pnlAux1: TPanel;
    pnlBotoesBaixa: TPanel;
    pnlTotais: TPanel;
    Label21: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    edtQtdDuplicatas: TEditFocus;
    edtQtdSelecionadas: TEditFocus;
    edtValorTotal: TEditFocus;
    edtCodCtaBai: TEditFocus;
    edtDesCtaBai: TEditFocus;
    edtDtaCad: TEditFocus;
    edtPreVis: TEditFocus;
    edtSerie: TEditFocus;
    edtCodEveBai: TEditFocus;
    edtDesEveBai: TEditFocus;
    Label5: TLabel;
    Label18: TLabel;
    edtTotDesconto: TEditFocus;
    edtTotJuros: TEditFocus;
    edtCodVel: TEditFocus;
    Label20: TLabel;
    frxReciboM: TfrxReport;
    frxReciboJ: TfrxReport;
    frxDataset: TfrxDBDataset;
    frxGen: TfrxUserDataSet;
    lblTotVendor: TLabel;
    edtTotVendor: TEditFocus;
    dbgDuplicatasView: TcxGridDBTableView;
    dbgDuplicatasLevel1: TcxGridLevel;
    dbgDuplicatas: TcxGrid;
    dbgDuplicatasCTP_NUMDUP: TcxGridDBColumn;
    dbgDuplicatasCTP_CODEMP: TcxGridDBColumn;
    dbgDuplicatasCTP_DTAVEN: TcxGridDBColumn;
    dbgDuplicatasCTP_USACHQ: TcxGridDBColumn;
    dbgDuplicatasCTP_DESSUJ: TcxGridDBColumn;
    dbgDuplicatasCTP_JURSUJ: TcxGridDBColumn;
    dbgDuplicatasCTP_MULSUJ: TcxGridDBColumn;
    dbgDuplicatasTOTDUP: TcxGridDBColumn;
    dbgDuplicatasCTP_MARDES: TcxGridDBColumn;
    dbgDuplicatasFOR_NOMFOR: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    btnMarcarTodas: TBitBtnLocked;
    BtnSelecionadas: TBitBtnLocked;
    dbgDuplicatasCTP_VEIOBO: TcxGridDBColumn;
    shpMultSel: TShape;
    dbgDuplicatasCTP_CODPOR: TcxGridDBColumn;
    btnDesmarcarTodas: TBitBtnLocked;
    Label3: TLabel;
    edtHistor: TMemoFocus;
    frxDatasetChqEmi: TfrxDBDataset;
    dbgDuplicatasCTP_DTACAD: TcxGridDBColumn;
    btnSairBaixa: TBitBtnLocked;
    FlwPnlBotoesBaixa: TFlowPanel;
    edtOutEnt: TEditFocus;
    dbgDuplicatasCTP_VEIONF: TcxGridDBColumn;
    dbgDuplicatasCTP_SERIE_AG: TcxGridDBColumn;
    dbgDuplicatasCTP_NUMDUP_AG: TcxGridDBColumn;
    dbgDuplicatasCTP_CODEMP_AG: TcxGridDBColumn;
    dbgDuplicatasCTP_CODFOR_AG: TcxGridDBColumn;
    btnHlpImp: TcxButton;
    HintControler: TcxHintStyleController;
    edtTotMulta: TEditFocus;
    lblMulta: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSelecionadasClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure dbgDuplicatasViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgDuplicatasViewDblClick(Sender: TObject);
    procedure dbgDuplicatasViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure btnSairBaixaClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure btnHlpImpExit(Sender: TObject);
    procedure btnHlpImpMouseLeave(Sender: TObject);
  private
    { Private declarations }

    cdsCtaPag: TUniClientDataSet;
    dtsCtaPag: TDataSource;
    objLiberacao  : TLiberacao;
    objLock: TLock;
    blnResult : Boolean;
    cdsClone: TUniClientDataSet;
    qryTmp   : TUniQuery;
    qryCadPag: TUniQuery;
    objFechamento: TFechamentoFinanceiro;
    LTemDuplicataAG: Boolean;
    LMarcarTodos: Boolean;

    procedure pLiberaDupsMarcadas;
    procedure pqryCadPagCTP_DTACADSetText(Sender: TField; const Text: String);
    procedure pRetDupSelecionadas(var intQtdSel: Integer);
    procedure pSelecionaDuplicata;
    procedure pMarcaDuplicata(blnMarcar: Boolean);
    procedure pLimpaEdits;
    procedure pLimpaEditsDuplicata;
    procedure pMarcarDuplicataTela;
    function  fDesmarcarTodos(pgbProgresso: TcxProgressBar): Boolean;
    function  fMarcarTodos(pgbProgresso: TcxProgressBar): Boolean;
    function  fVerificaDupBaixada(strNumDup,
                                 strParcel,
                                 strSerie_,
                                 strCodEmp,
                                 strCodFor: String;
                                 intSeqBai: Integer;
                                 fltTotDup: Double): Boolean;
    function fVerificacoesParaExclusao(pgbProgresso: TcxProgressBar): Boolean;
    function fDuplicatasJaUtilizadasPorOutrosUsuarios: Boolean;
    function fVerificaDuplicatasExcluidas : Boolean;
    procedure pStepStatusSelecao(pgbStatus: TcxProgressBar);
    function fLiberacaoApagarDuplicata: Boolean;
    function fApagarDuplicatas(pgbProgresso: TcxProgressBar): Boolean;
    procedure pClonaDuplicatasMarcadas;
    function fDeleteCADPAG(strAutoInc : String): Boolean;
    procedure pLimpaCTPCom(strCTPCom: String);
    procedure pDeletaCtpDet(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String);
    function fCtpExisteDupDependentes(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String): Boolean;
    function fValidacoesParaExcluir: Boolean;
    function fPedeSenha: Boolean;
    function ExcluirDuplicataGeradaDeKMRodados(AChaveDuplicata: String;
                                               ALimpar: Boolean = False): Boolean;

  protected

    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pCalculaTotalDuplicatas(edtDesconto, edtJuros,edtmulta, edtTotal, edtQuant, edtVendor : TEditFocus; blnFiltrar: Boolean);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fVerificaChqExiste(strCodBco, strNumAge, strConCor, strNumChq: String): Boolean;
  public
    { Public declarations }

    strNumDup,
    strCodEmp,
    strCodFor: String;

    blnIsEmpty : Boolean;
    procedure pAtualizaTemporaria;
  end;

implementation

uses SysUtils, Variants, Graphics, StrUtils, untFuncoes, UniDataSetProvider,
  untPesqAux, untConsultas, untBaixaDigValores, untBaixaSintetica,
  untFuncoesGenerica, untBaixaCtpAnalitica, untBaixaCtpBusca, untPai,
  untCtpFormasPagamento, untQckCtpBordero, untConsDuplicSelec, untCnfBoleto,
  untConstantes, untCtpDigData, untFuncoesConsulta, untQckCopiaCheque, untCadChq,
  untMovBan, untCadPag, untCfgRel, untCadRcxx, untDigValor, untFuncFat,
  untGravando, untTCadChqRepository,
  untTChqEmi, untTChqEmiRepository, untObjectManager, untTBanCtpRepository,
  untLogBan, untTBanChqRepository, untEnviaImpCheque, untLogCtp, untTBanChq,
  untCadCtaPagar, untBaixaDescGeral, untCadEventos,untFormGrid;

{$R *.dfm}

{ TfrmExclusaoAutCtaPagar }

function TfrmExclusaoAutCtaPagar.fPedeSenha: Boolean;
  Var
    strSenha : String;
begin
  Result := True;
  If ((fCfgSis('SENFVU') = 'F')) Then
  Begin
    If ffrmSenha(strSenha) Then
    Begin
      If strSenha = fCfgSis('SEXCTP') Then
      Begin
        Result := True;
      End
      Else
      Begin
         Result := False;
        fMensagem('','Senha incorreta!',['&OK']);
      End;
    End;
  End;
end;

function TfrmExclusaoAutCtaPagar.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmExclusaoAutCtaPagar.fVerificaChqExiste(strCodBco, strNumAge, strConCor, strNumChq: String): Boolean;
  Var
    qryTmpChq: TUniQuery;
    strSQL   : String;
begin

  Result := False;

  qryTmpChq := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + ' SELECT COUNT(*) AS QTDREG  ';
  strSQL := strSQL + ' FROM                       ';
  strSQL := strSQL + '   CHQEMI                   ';
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '   EMI_CODBCO = :CODBCO     ';
  strSQL := strSQL + '   AND EMI_NUMAGE = :NUMAGE ';
  strSQL := strSQL + '   AND EMI_CONCOR = :CONCOR ';
  strSQL := strSQL + '   AND EMI_NUMCHQ = :NUMCHQ ';


  qryTmpChq.Close;
  qryTmpChq.SQL.Clear;
  qryTmpChq.SQL.Add(strSQL);
  qryTmpChq.ParamByName('CODBCO').AsString := strCodBco;
  qryTmpChq.ParamByName('NUMAGE').AsString := strNumAge;
  qryTmpChq.ParamByName('CONCOR').AsString := strConCor;
  qryTmpChq.ParamByName('NUMCHQ').AsString := strNumChq;
  qryTmpChq.Open;


  If qryTmpChq.IsEmpty Then
  Begin
    fMensagem('', 'Já existe um cheque emitido com estes dados Banco: ' + strCodBco +
                  ' Agência: ' + strNumAge + ' Conta: ' + strConCor + ' Cheque: ' + strNumChq + '!',
                  ['&O k']);
    Result := True;
  End;

end;

function TfrmExclusaoAutCtaPagar.fVerificacoesParaExclusao(pgbProgresso: TcxProgressBar): Boolean;
begin
  Result := True;
  cdsClone.First;
  qryTmp := fCriaQuery;
  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := cdsClone.RecordCount;

  While Not cdsClone.Eof Do
  Begin
    If fDuplicatasJaUtilizadasPorOutrosUsuarios Then
    Begin
      fMensagem('ATENÇÃO!', 'Existem duplicatas que estão sendo excluidas e as mesmas foram utilizadas por outro usuário. Realize a pesquisa novamente para efetuar as exclusão corretamente!', ['&OK']);
      FreeAndNil(cdsClone);
      Result:= False;
      Break;
    End;
    {********************************************************************}
    {* REALIZADO ESSE TRATAMENTO DEVIDO AO DESAGRUPAMENTO DE DUPLICATAS *}
    {********************************************************************}
    If Not fVerificaDuplicatasExcluidas Then
    Begin
      fMensagem('ATENÇÃO!', 'Existem duplicatas que foram excluídas por outro usuário. Realize a pesquisa novamente para efetuar as exclusão corretamente!', ['&OK']);
      FreeAndNil(cdsClone);
      Result:=False;
      Break;
    End;
    cdsClone.Next;
    pStepStatusSelecao(pgbProgresso);
  End;
  blnResult := Result;
  pFreeAndNil(qryTmp);
end;

function TfrmExclusaoAutCtaPagar.fVerificaDupBaixada(strNumDup, strParcel, strSerie_,
  strCodEmp, strCodFor: String; intSeqBai: Integer; fltTotDup: Double): Boolean;
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin
  Try
   qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CTP_DTAPAG, ';
    strSQL := strSQL + '  (CTP_VALDUP + IFNULL(CTP_JURSUJ,0) + IFNULL(CTP_MULSUJ,0) + IFNULL(CTP_VENDOR,0) + IFNULL(CTP_OUTENT,0)) -IFNULL(CTP_DESSUJ,0) AS VALORTOTAL ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADPAG ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '   CTP_PARCEL = :PARCEL AND ';

    IF fEmptyStr(strSerie_) THEN
      strSQL := strSQL + '   (CTP_SERIE_ = :SERIE_ OR  CTP_SERIE_ IS NULL) AND '
    ELSE
      strSQL := strSQL + '   CTP_SERIE_ = :SERIE_ AND ';

    strSQL := strSQL + '   CTP_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   CTP_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '   CTP_SEQBAI = :SEQBAI ';

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(strSQL);
    qryGen.ParamByName('NUMDUP').AsString  := strNumDup;
    qryGen.ParamByName('PARCEL').AsString  := strParcel;
    qryGen.ParamByName('SERIE_').AsString  := strSerie_;
    qryGen.ParamByName('CODEMP').AsString  := strCodEmp;
    qryGen.ParamByName('CODFOR').AsString  := strCodFor;
    qryGen.ParamByName('SEQBAI').AsInteger := intSeqBai;
    qryGen.Open;

    If fEmptyStr(qryGen.FieldByName('CTP_DTAPAG').AsString) Then
    begin
      If qryGen.FieldByName('VALORTOTAL').AsFloat <> fltTotDup Then
        Result := True
      Else
        Result := False;
    end
    Else
    begin
      Result := True;
    end;

  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmExclusaoAutCtaPagar.fVerificaDuplicatasExcluidas: Boolean;
  Var
    strSQL   : String;
Begin
  Result := True;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   COUNT(*) AS QTD ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + cdsClone.FieldByName('TABELA').AsString;
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   AUTOINCREM = :AUTINC';

  qryTmp.Params.Clear;
  qryTmp.SQL.Clear;
  qryTmp.SQL.Add(strSQL);
  qryTmp.ParamByName('AUTINC').AsString := cdsClone.FieldByName('AUTOINCREM').AsString;
  qryTmp.Open;

  If Not qryTmp.IsEmpty Then
  Begin
    If qryTmp.FieldByName('QTD').AsInteger = 0 Then
    begin
      Result := False;
    end;
  End
  Else
  begin
    Result := False;
  end;

End;

procedure TfrmExclusaoAutCtaPagar.pAtualizaTemporaria;
  Var
    strSQL: String;
    qryCtaPag: TUniQuery;
    dspCtaPag: TUniDataSetProvider;
begin
  pLiberaDupsMarcadas;

  cdsCtaPag.Filtered := False;
  cdsCtaPag.Close;
  qryCtaPag := fCriaQuery(Self);
  dspCtaPag := TUniDataSetProvider.Create(Self);
  dspCtaPag.DataSet := qryCtaPag;
  cdsCtaPag.SetProvider(dspCtaPag);

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  P.CTP_SERIE_ AS AGRSER, ';
    strSQL := strSQL + '  P.CTP_CODEMP AS AGREMP, ';
    strSQL := strSQL + '  P.CTP_CODFOR AS AGRFOR, ';
    strSQL := strSQL + '  P.CTP_NUMDUP AS NRODUP, ';
    strSQL := strSQL + '  P.CTP_PARCEL AS PARDUP, ';
    strSQL := strSQL + '  P.CTP_CTPCOM,           ';
    strSQL := strSQL + '  CONCAT(P.CTP_NUMDUP, P.CTP_PARCEL) AS CTP_NUMDUP, ';
    strSQL := strSQL + '  P.CTP_CODFOR, ';
    strSQL := strSQL + '  F.FOR_NOMFOR, ';
    strSQL := strSQL + '  F.FOR_FONE01, ';
    strSQL := strSQL + '  F.FOR_F_A_X_, ';
    strSQL := strSQL + '  CONCAT(P.CTP_CODFOR ,"-", F.FOR_NOMFOR) AS CTP_NOMFOR, ';
    strSQL := strSQL + '  F.FOR_C_G_C_, ';
    strSQL := strSQL + '  F.FOR_CGCCPF AS FOR_CGCCPF, ';
    strSQL := strSQL + '  P.CTP_CODEMP, ';
    strSQL := strSQL + '  P.CTP_SERIE_, ';
    strSQL := strSQL + '  E.EMP_NOMEMP, ';
    strSQL := strSQL + '  P.CTP_CODCTA, ';
    strSQL := strSQL + '  C.CTA_DESCTA, ';
    strSQL := strSQL + '  P.CTP_HIST01, ';
    strSQL := strSQL + '  P.CTP_HIST02, ';
    strSQL := strSQL + '  P.CTP_PREVIS, ';
    strSQL := strSQL + '  IF(P.CTP_VEIOBO = "S", "SIM", "NÃO") AS CTP_VEIOBO, ';
    strSQL := strSQL + '  IF(P.CTP_VEIONF = "S", "SIM", "NÃO") AS CTP_VEIONF, ';
    strSQL := strSQL + '  P.CTP_DTACAD, ';
    strSQL := strSQL + '  P.CTP_DTAVEN, ';
    strSQL := strSQL + '  P.CTP_VALORI, ';
    strSQL := strSQL + '  P.CTP_VALDUP, ';
    strSQL := strSQL + '  P.CTP_VALPAG, ';
    strSQL := strSQL + '  P.CTP_DTAPAG, ';
    strSQL := strSQL + '  P.CTP_VALJUR, ';
    strSQL := strSQL + '  P.CTP_VALMUL, ';
    strSQL := strSQL + '  P.CTP_VALDES, ';
    strSQL := strSQL + '  P.CTP_CODEVE, ';
    strSQL := strSQL + '  P.CTP_TIPDOC, ';
    strSQL := strSQL + '  P.CTP_CODVEL, ';
    strSQL := strSQL + '  P.CTP_CODPOR, ';
    strSQL := strSQL + '  CONCAT(P.CTP_CODPOR ,"-", R.POR_NOMPOR) AS CTP_NOMPOR, ';
    strSQL := strSQL + '  P.CTP_PORBAI, ';
    strSQL := strSQL + '  B.POR_NOMPOR, ';
    strSQL := strSQL + '  IF(P.CTP_USACHQ = "S", "SIM", "NÃO") AS CTP_USACHQ, ';
    strSQL := strSQL + '  V.EVE_DESEVE, ';
    strSQL := strSQL + '  IFNULL(P.CTP_DESSUJ, 0) AS CTP_DESSUJ, ';
    strSQL := strSQL + '  IFNULL(P.CTP_JURSUJ, 0) AS CTP_JURSUJ, ';
    strSQL := strSQL + '  IFNULL(P.CTP_MULSUJ, 0) AS CTP_MULSUJ, ';
    strSQL := strSQL + '  IFNULL(P.CTP_VENDOR, 0) AS CTP_VENDOR, ';
    strSQL := strSQL + '  IFNULL(P.CTP_OUTENT, 0) AS CTP_OUTENT, ';
    strSQL := strSQL + '  (P.CTP_VALDUP + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_MULSUJ,0) + IFNULL(P.CTP_VENDOR,0) + IFNULL(CTP_OUTENT,0)) -IFNULL(P.CTP_DESSUJ,0) AS TOTDUP, ';
    strSQL := strSQL + '  " " AS CTP_MARDES, ';
    strSQL := strSQL + '  " " AS CTP_TIPBAI, ';
    strSQL := strSQL + '  " " AS CTP_TIPDES, ';
    strSQL := strSQL + '  P.AUTOINCREM, ';
    strSQL := strSQL + '  "CADPAG" AS TABELA, ';
    strSQL := strSQL + '  CTP_COMPET,         ';
    strSQL := strSQL + '  P.CTP_DINHEI, ';
    strSQL := strSQL + '  P.CTP_CHQAVI, ';
    strSQL := strSQL + '  P.CTP_ORDPAG, ';
    strSQL := strSQL + '  P.CTP_REPCHQ, ';
    strSQL := strSQL + '  P.CTP_SEQBAI, ';
    strSQL := strSQL + '  P.CTP_DTALIB, ';
    strSQL := strSQL + QuotedStr(FormatDateTime('DD/MM/YYYY HH:NN:SS',fNow())) + ' AS HRAFIL ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG P ';
    strSQL := strSQL + '  JOIN CADFOR F ON P.CTP_CODFOR = F.FOR_CODFOR ';
    strSQL := strSQL + '  JOIN CADEMP E ON P.CTP_CODEMP = E.EMP_CODEMP ';
    strSQL := strSQL + '  JOIN CADCTA C ON P.CTP_CODCTA = C.CTA_CODCTA ';

    strSQL := strSQL + ' LEFT JOIN CADEVE V ON P.CTP_CODEVE = V.EVE_CODEVE ';
    strSQL := strSQL + ' LEFT JOIN CADPOR B ON P.CTP_PORBAI = B.POR_CODPOR ';
    strSQL := strSQL + ' LEFT JOIN CADPOR R ON P.CTP_CODPOR = R.POR_CODPOR ';
    strSQL := strSQL + ' WHERE  CTP_NUMDUP = :NUMDUP ';
    strSQL := strSQL + '   AND  CTP_CODEMP = :CODEMP ';
    strSQL := strSQL + '   AND  CTP_CODFOR = :CODFOR ';
    strSQL := strSQL + '   AND  CTP_DTAPAG IS NULL   ';
    strSQL := strSQL + '   AND  CTP_SEQBAI = 0       ';


    qryCtaPag.Close;
    qryCtaPag.SQL.Clear;
    qryCtaPag.SQL.Add(strSQL);

    qryCtaPag.ParamByName('NUMDUP').AsString := strNumDup;
    qryCtaPag.ParamByName('CODEMP').AsString := strCodEmp;
    qryCtaPag.ParamByName('CODFOR').AsString := strCodFor;

    qryCtaPag.Open;

    Application.ProcessMessages;

    If Not qryCtaPag.IsEmpty Then
    Begin
      pSetaClient(qryCtaPag);
      cdsCtaPag.Open;

      (cdsCtaPag.FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsCtaPag.FieldByName('CTP_DESSUJ') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsCtaPag.FieldByName('CTP_JURSUJ') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsCtaPag.FieldByName('CTP_MULSUJ') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsCtaPag.FieldByName('CTP_VENDOR') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsCtaPag.FieldByName('CTP_OUTENT') As TFloatField).DisplayFormat := '#,##0.00';
      (cdsCtaPag.FieldByName('TOTDUP')     As TFloatField).DisplayFormat := '#,##0.00';
      cdsCtaPag.IndexFieldNames := 'CTP_DTAVEN;CTP_CODFOR;CTP_NUMDUP;CTP_CODEMP';
      cdsCtaPag.First;
      Application.ProcessMessages;
      pCalculaTotalDuplicatas(edtTotDesconto, edtTotJuros,edtTotMulta, edtValorTotal, edtQtdDuplicatas, edtTotVendor, False);

    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Não há duplicatas para serem excluidas!', ['&O k']);
      pLimpaEdits;
      pLimpaEditsDuplicata;
      blnIsEmpty := True;
    End;

    qryCtaPag.Close;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmExclusaoAutCtaPagar.pAtualizaTemporaria]');
    End;
  End;


  Application.ProcessMessages;
  objLock.pDestravarTodos;
  cdsCtaPag.SetProvider(nil);
  FreeAndNil(dspCtaPag);
  FreeAndNil(qryCtaPag);
end;

{*****************************************}
{* SOMA O TOTAL DE DUPLICATAS DISPONÍ -  *}
{* VEIS PARA A EXCLUSAO                  *}
{**************************************MT*}
procedure TfrmExclusaoAutCtaPagar.pCalculaTotalDuplicatas(edtDesconto, edtJuros, edtMulta, edtTotal, edtQuant, edtVendor : TEditFocus; blnFiltrar: Boolean);
  Var
    cdsGen: TUniClientDataSet;
    fld001,
    fld002,
    fld003,
    fld004,
    fld005: TAggregateField;
begin
  cdsGen := TUniClientDataSet.Create(Self);

  fld001 := TAggregateField.Create(Self);
  fld001.FieldName := 'FLD001';
  fld001.DataSet := cdsGen;
  fld001.DisplayFormat := '#,##0.00';
  fld001.Expression := 'SUM(CTP_' + IIF(blnFiltrar, 'VALDES', 'DESSUJ') + ')';
  fld001.Active := True;

  fld002 := TAggregateField.Create(Self);
  fld002.FieldName := 'FLD002';
  fld002.DataSet := cdsGen;
  fld002.DisplayFormat := '#,##0.00';
  fld002.Expression := 'SUM(CTP_' + IIF(blnFiltrar, 'VALJUR', 'JURSUJ') + ')';
  fld002.Active := True;

  fld005 := TAggregateField.Create(Self);
  fld005.FieldName := 'FLD005';
  fld005.DataSet := cdsGen;
  fld005.DisplayFormat := '#,##0.00';
  fld005.Expression := 'SUM(CTP_' + IIF(blnFiltrar, 'VALMUL', 'MULSUJ') + ')';
  fld005.Active := True;

  fld003 := TAggregateField.Create(Self);
  fld003.FieldName := 'FLD003';
  fld003.DataSet := cdsGen;
  fld003.DisplayFormat := '#,##0.00';
  fld003.Expression := 'SUM(' + IIF(blnFiltrar, 'CTP_VALPAG', 'TOTDUP') + ')';
  fld003.Active := True;


  fld004 := TAggregateField.Create(Self);
  fld004.FieldName := 'FLD004';
  fld004.DataSet := cdsGen;
  fld004.DisplayFormat := '#,##0.00';
  fld004.Expression := 'SUM(CTP_VENDOR)';
  fld004.Active := True;

  cdsGen.Data := cdsCtaPag.Data;

  If blnFiltrar Then
  Begin
    cdsGen.Filtered := False;
    cdsGen.Filter := 'CTP_MARDES = ''M''';
    cdsGen.Filtered := True;
  End;

  cdsGen.AggregatesActive := True;

  If Not cdsGen.IsEmpty Then
  Begin
    edtDesconto.Text        := FormatFloat('#,##0.00', fld001.Value);
    edtJuros.Text           := FormatFloat('#,##0.00', fld002.Value);
    edtMulta.Text           := FormatFloat('#,##0.00', fld005.Value);
    edtTotal.Text           := FormatFloat('#,##0.00', fld003.Value);
    edtVendor.Text          := FormatFloat('#,##0.00', fld004.Value);
    edtQuant.Text           := IntToStr(cdsGen.RecordCount);
  End
  Else
  Begin
    edtDesconto.Text        := '0,00';
    edtJuros.Text           := '0,00';
    edtMulta.Text           := '0,00';
    edtTotal.Text           := '0,00';
    edtVendor.Text          := '0,00';
    edtQuant.Text           := '0';
  End;


  FreeAndNil(fld001);
  FreeAndNil(fld002);
  FreeAndNil(fld003);
  FreeAndNil(fld004);
  FreeAndNil(cdsGen);
end;

procedure TfrmExclusaoAutCtaPagar.pClonaDuplicatasMarcadas;
begin
  If Not Assigned(cdsClone) Then
    cdsClone := TUniClientDataSet.Create(Self);

  pCloneDataSet(cdsClone, cdsCtaPag);

  cdsClone.Filtered := False;
  cdsClone.Filter := 'CTP_MARDES = ''M''';
  cdsClone.Filtered := True;
end;

procedure TfrmExclusaoAutCtaPagar.pAtualizaDados(DataSet: TDataSet);
begin
  If (Not DataSet.ControlsDisabled) Then
  Begin
    If (DataSet.Active) Then
    Begin
      edtCodEveBai.Text := DataSet.FieldByName('CTP_CODEVE').AsString;
      edtDesEveBai.Text := DataSet.FieldByName('EVE_DESEVE').AsString;
      edtCodCtaBai.Text := DataSet.FieldByName('CTP_CODCTA').AsString;
      edtDesCtaBai.Text := DataSet.FieldByName('CTA_DESCTA').AsString;
      edtDtaCad.Text    := DataSet.FieldByName('CTP_DTACAD').AsString;
      edtHistor.Texto   := DataSet.FieldByName('CTP_HIST01').AsString;
      edtCodVel.Text    := DataSet.FieldByName('CTP_CODVEL').AsString;

      If DataSet.FieldByName('CTP_PREVIS').AsString = 'S' Then
        edtPrevis.Text  := 'SIM'
      Else
        edtPrevis.Text  := 'NÃO';

      edtSerie.Text := DataSet.FieldByName('CTP_SERIE_').AsString;
    End;
  End;
end;

{*****************************************}
{* SELECIONA UMA DUPLICATA               *}
{**************************************MV*}
procedure TfrmExclusaoAutCtaPagar.pSelecionaDuplicata;
begin
  If cdsCtaPag.IsEmpty Then
    Exit;

  If cdsCtaPag.FieldByName('CTP_MARDES').AsString <> 'M' Then
  Begin
    Try
      {*****************************************}
      {* MARCA A DUPLICATA E ATUALIZA A TELA   *}
      {**************************************MV*}
      pMarcarDuplicataTela;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmExclusaoAutCtaPagar.pSelecionaDuplicata]');
      End;
    End;

    pSetFocus(Self);
  End
  Else
  Begin
    pMarcaDuplicata(False);
  End;

  {******************************************}
  {* POSICIONA O CURSOR NO PRÓXIMO REGISTRO *}
  {***************************************ER*}
  dbgDuplicatasView.NavigatorButtons.Next.Click;
end;

procedure TfrmExclusaoAutCtaPagar.pStepStatusSelecao(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

function TfrmExclusaoAutCtaPagar.fValidacoesParaExcluir : Boolean;
  Var
    blnPodeExcluir : Boolean;
begin
  blnPodeExcluir := True;
  Result := True;
  {*****************************************}
  {* FAZ VALIDAÇÕES SOBRE A EMPRESA GEREN- *}
  {* CIAL                                  *}
  {**************************************MV*}
  If Not (fCfgSis('EMPGER', varBoolean)) Then
  Begin
    If (Not fEmptyStr(cdsCtaPag.FieldByName('CTP_CODEMP').AsString)) Then
    Begin
      If cdsCtaPag.FieldByName('CTP_CODEMP').AsString = VS_strCodEmp Then
        blnPodeExcluir := True
      Else
        blnPodeExcluir := False;
    End;
  End;

  If not blnPodeExcluir Then
  Begin
    fMensagem('ATENÇÃO!', 'Uma Loja Filial só pode Excluir Duplicatas por ela Gerada!', ['&O k']);
    Result := False;
    Exit;
  End;

    //FECHAMENTO FINANCEIRO
  if objFechamento.FechamentoFinanceiroJaRealizado(cdsCtaPag.FieldByName('CTP_CODEMP').AsString, cdsCtaPag.FieldByName('CTP_DTACAD').AsDateTime) then
  Begin
    Result := False;
    Exit;
  End;
end;

procedure TfrmExclusaoAutCtaPagar.pMarcarDuplicataTela;
begin
  pMarcaDuplicata(True);
end;

{*****************************************}
{* MARCA UMA DUPLICATA A SER EXCLUIDA    *}
{**************************************MT*}
procedure TfrmExclusaoAutCtaPagar.pMarcaDuplicata(blnMarcar: Boolean);
  Var
    intQtdSel : Integer;
begin
  intQtdSel := 0;

  If blnMarcar Then
  Begin
    If (cdsCtaPag.FieldByName('HRAFIL').AsDateTime < fRetornaUltimaAlteracaoDuplicataCTP(cdsCtaPag.FieldByName('NRODUP').AsString,
                                                                                         cdsCtaPag.FieldByName('PARDUP').AsString,
                                                                                         cdsCtaPag.FieldByName('CTP_SERIE_').AsString,
                                                                                         cdsCtaPag.FieldByName('CTP_CODFOR').AsString,
                                                                                         cdsCtaPag.FieldByName('CTP_CODEMP').AsString)) Then
    Begin
      pMensagemOk('A duplicata que está sendo marcada sofreu uma alteração posterior a pesquisa realizada.' + #13 +
                  'Recarregue as duplicatas e tente novamente.');
      Exit;
    End;

    If EhAgrupamento(
         cdsCtaPag.FieldByName('NRODUP').AsString,
         cdsCtaPag.FieldByName('CTP_CODFOR').AsString,
         cdsCtaPag.FieldByName('CTP_CODEMP').AsString) Then
    Begin
       LTemDuplicataAG := True;
       If Not LMarcarTodos Then
      Begin
         pMensagemOk('A duplicata não pode ser excluída, pois é um agrupamento.' + #13 +
                    'É necessário que seja feito o desagrupamento.');
      End;
      exit;
    End;

    {****************************************************}
    {* CASO SEQBAI = 0, VERIFICA SE HÁ DUPS DEPENDENTES *}
    {* CASO EXISTA BLOQUEIA A EXCLUSÃO                  *}
    {**********************************************AJ*JB*}
    If (cdsCtaPag.FieldByName('CTP_SEQBAI').AsInteger = 0) And
       (fCtpExisteDupDependentes(cdsCtaPag.FieldByName('NRODUP').AsString,
                                 cdsCtaPag.FieldByName('PARDUP').AsString,
                                 cdsCtaPag.FieldByName('CTP_SERIE_').AsString,
                                 cdsCtaPag.FieldByName('CTP_CODEMP').AsString,
                                 cdsCtaPag.FieldByName('CTP_CODFOR').AsString)) Then
    Begin
      fMensagem('','A duplicata não pode ser excluída, pois é originária de uma baixa parcial. ' + #13#10 +
                   ' É necessário estornar as duplicatas dependentes!',['&OK']);
      Exit;
    End;

    If  Not fValidacoesParaExcluir Then
      Exit;

    If Not objLock.fLock_Unlock(cdsCtaPag.FieldByName('TABELA').AsString + cdsCtaPag.FieldByName('AUTOINCREM').AsString, True, False) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esta duplicata está sendo utilizada por outra estação: ' + fGetHostLock(cdsCtaPag.FieldByName('TABELA').AsString + cdsCtaPag.FieldByName('AUTOINCREM').AsString), ['&Ok']);
      Exit;
    End;
  End
  Else
    objLock.fLock_Unlock(cdsCtaPag.FieldByName('TABELA').AsString + cdsCtaPag.FieldByName('AUTOINCREM').AsString, False);

  cdsCtaPag.Edit;
  cdsCtaPag.FieldByName('CTP_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
  cdsCtaPag.Post;

  pRetDupSelecionadas(intQtdSel);
  edtQtdSelecionadas.Text :=  IntToStr(intQtdSel);
end;

procedure TfrmExclusaoAutCtaPagar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pLiberaDupsMarcadas;
end;

procedure TfrmExclusaoAutCtaPagar.FormCreate(Sender: TObject);
begin
  inherited;
  objLiberacao := TLiberacao.create;
  objLock := TLock.Create;

  qryCadPag := fCriarQuery('SELECT * FROM CADPAG WHERE FALSE', Self);
  qryCadPag.FieldByName('CTP_DTACAD').OnSetText := pqryCadPagCTP_DTACADSetText;
  qryCadPag.Open;

  cdsCtaPag := TUniClientDataSet.Create(Self);
  cdsCtaPag.AfterScroll := pAtualizaDados;
  dtsCtaPag := fCriaDataSource(cdsCtaPag);
  dbgDuplicatasView.DataController.DataSource := dtsCtaPag;
  blnIsEmpty := False;
  LTemDuplicataAG := False;
  LMarcarTodos := False;
end;

procedure TfrmExclusaoAutCtaPagar.pqryCadPagCTP_DTACADSetText(Sender: TField; const Text: String);
begin
  If (fEmptyStr(fTiraCaracEspeciais(Text))) Then
    TDateField(Sender).AsVariant := Null
  Else
    TDateField(Sender).AsVariant := Text;
end;

procedure TfrmExclusaoAutCtaPagar.btnConfirmaClick(Sender: TObject);
begin

  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If (StrToIntDef(edtQtdSelecionadas.Text, 0) <= 0) Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;


  pClonaDuplicatasMarcadas;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fVerificacoesParaExclusao;
  frmGravando.lblGravando.Caption := 'Aguarde... Verificando Títulos.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);

  If blnResult Then
  Begin
    If fLiberacaoApagarDuplicata Then
    Begin
      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.fExecutarAcao := fApagarDuplicatas;
      frmGravando.lblGravando.Caption := 'Aguarde... Excluindo Títulos.';
      frmGravando.ShowModal;
      pFreeAndNil(frmGravando);
      pAtualizaTemporaria;
    End;
  End;
end;

procedure TfrmExclusaoAutCtaPagar.btnDesmarcarTodasClick(Sender: TObject);
begin
  inherited;
  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If Not btnDesmarcarTodas.Enabled Then
    Exit;

  If cdsCtaPag.IsEmpty Then
    Exit;

  If (Not btnDesmarcarTodas.Enabled) Then
    Exit;

  pCriarFormularios(TfrmGravando,frmGravando);
  Try
    frmGravando.fExecutarAcao := fDesmarcarTodos;
    frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando Títulos.';
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmExclusaoAutCtaPagar.btnHlpImpClick(Sender: TObject);
begin
  inherited;
  HintControler.ShowHint(Self.Left + btnHlpImp.Left + btnHlpImp.Width,
                         50 + Self.Top + pnlBotoes.Top + btnHlpImp.Top + btnHlpImp.Height,
                         '',
                         'Duplicatas que fazem parte dessa geração automatica e já foram baixadas' + #13#10 +
                         'não serão exibidas na rotina de exclusão automatica! ' + #13#10 +
                         'Deverá ser realizado o estorno da duplicata baixada caso queira excluir a mesma.');

end;

procedure TfrmExclusaoAutCtaPagar.btnHlpImpExit(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmExclusaoAutCtaPagar.btnHlpImpMouseLeave(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmExclusaoAutCtaPagar.pLiberaDupsMarcadas;
begin

  If Not cdsCtaPag.Active Then
    Exit;

  cdsCtaPag.Filtered := False;
  cdsCtaPag.Filter := 'CTP_MARDES = ''M''';
  cdsCtaPag.Filtered := True;

  If Not cdsCtaPag.IsEmpty Then
  Begin
    cdsCtaPag.First;

    While Not cdsCtaPag.Eof Do
    Begin
      objLock.fLock_Unlock(cdsCtaPag.FieldByName('TABELA').AsString + cdsCtaPag.FieldByName('AUTOINCREM').AsString, False);
      cdsCtaPag.Next;
    End;
  End;
end;

procedure TfrmExclusaoAutCtaPagar.pLimpaEdits;
begin
  pLimpaEditsDuplicata;

  cdsCtaPag.AfterScroll := nil;
  Try
    pLiberaDupsMarcadas;
    cdsCtaPag.Filtered := False;
    cdsCtaPag.Close;
  Finally
    cdsCtaPag.AfterScroll := pAtualizaDados;
  End;
end;

procedure TfrmExclusaoAutCtaPagar.pLimpaEditsDuplicata;
begin
  edtQtdDuplicatas.Clear;
  edtQtdSelecionadas.Clear;
  edtValorTotal.Clear;
  edtTotDesconto.Clear;
  edtTotJuros.Clear;
  edtTotVendor.Clear;
  edtOutEnt.Clear;

  edtCodEveBai.Clear;
  edtDesEveBai.Clear;
  edtCodCtaBai.Clear;
  edtDesCtaBai.Clear;
  edtDtaCad.Clear;
  edtCodVel.Clear;
  edtPrevis.Clear;
  edtSerie.Clear;

  edtHistor.Clear;
end;

function TfrmExclusaoAutCtaPagar.fDeleteCADPAG(strAutoInc: String): Boolean;
  Var
    qryDel: TUniQuery;
begin
  Result := True;
  Try
    qryDel := fCriaQuery(Nil);
    Try
      qryDel.Close;
      qryDel.Sql.Clear;
      qryDel.Sql.Add('DELETE FROM CADPAG WHERE AUTOINCREM = :AUTOIN');
      qryDel.ParamByName('AUTOIN').AsString := strAutoInc;
      qryDel.ExecSQL;
    Except
    On E: Exception Do
      Begin
        Result:= False;
        pMensagensErro(E.Message,'[TfrmExclusaoAutCtaPagar.fDeleteCADPAG]');
      End;
    End;
  Finally
    pFreeAndNil(qryDel);
  End;
end;

procedure TfrmExclusaoAutCtaPagar.pLimpaCTPCom(strCTPCom: String);
Var
  qryCTPCom: TUniQuery;
  strSQL   : String;
begin
  qryCTPCom := fCriaQuery(Self);

  Try
    strSQL := '';
    strSQL := strSQL + 'UPDATE CADREC  SET CTR_CTPCOM = NULL WHERE CTR_CTPCOM = :CTPCOM; ';
    strSQL := strSQL + 'UPDATE DUPAGR  SET CTR_CTPCOM = NULL WHERE CTR_CTPCOM = :CTPCOM; ';
    strSQL := strSQL + 'UPDATE CTRCNF  SET CTR_CTPCOM = NULL WHERE CTR_CTPCOM = :CTPCOM; ';
    strSQL := strSQL + 'UPDATE LOGCTR  SET CTR_CTPCOM = NULL WHERE CTR_CTPCOM = :CTPCOM; ';
    strSQL := strSQL + 'UPDATE CADCHQ  SET CHQ_CTPCOM = NULL WHERE CHQ_CTPCOM = :CTPCOM; ';
    strSQL := strSQL + 'UPDATE MOVCAR  SET MCA_CTPCOM = NULL WHERE MCA_CTPCOM = :CTPCOM; ';

    qryCTPCom.Close;
    qryCTPCom.SQL.Clear;
    qryCTPCom.SQL.Add(strSQL);
    qryCTPCom.ParamByName('CTPCOM').AsString := strCTPCom;
    qryCTPCom.ExecSQL;
    qryCTPCom.Close;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[pLimpaCTPCom]');
    End;
  End;

  FreeAndNil(qryCTPCom);
end;


{*******************************************}
{* DELETE UM REGISTRO ESPECÍFICO DE CTPDET *}
{****************************************MV*}
procedure TfrmExclusaoAutCtaPagar.pDeletaCtpDet(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String);
  Var
    strSQL: String;
    qryGenDet: TUniQuery;

begin
  Try

    qryGenDet := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM CTPDET ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
    If (fEmptyStr(strSerie)) Then
      strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) AND '
    Else
      strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';
    strSQL := strSQL + '  CTP_EMPORI = :EMPORI AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR ';


    qryGenDet.Close;
    qryGenDet.SQL.Clear;
    qryGenDet.SQL.Add(strSQL);
    qryGenDet.ParamByName('NUMDUP').AsString := strNumDup;
    qryGenDet.ParamByName('PARCEL').AsString := strParcel;
    If (Not fEmptyStr(strSerie)) Then
      qryGenDet.ParamByName('SERIE_').AsString := strSerie;
    qryGenDet.ParamByName('EMPORI').AsString := strCodEmp;
    qryGenDet.ParamByName('CODFOR').AsString := strCodFor;
    qryGenDet.ExecSQL;


  Finally
    FreeAndNil(qryGenDet);
  End;

end;

function TfrmExclusaoAutCtaPagar.fCtpExisteDupDependentes(strNumDup, strParcel, strSerie,
  strCodEmp, strCodFor: String): Boolean;
  Var
    qryGenDup: TUniQuery;
Begin
  qryGenDup := fCriaQuery(Nil);

  qryGenDup.Close;
  qryGenDup.SQL.Clear;
  qryGenDup.SQL.Add('SELECT ');
  qryGenDup.SQL.Add('  COUNT(*) AS QTD ');
  qryGenDup.SQL.Add('FROM ');
  qryGenDup.SQL.Add('  CADPAG ');
  qryGenDup.SQL.Add('WHERE ');
  qryGenDup.SQL.Add('  CTP_NUMDUP = :NUMDUP AND ');
  qryGenDup.SQL.Add('  CTP_PARCEL = :PARCEL AND ');
  qryGenDup.SQL.Add('  CTP_SERIE_ = :SERIE_ AND ');
  qryGenDup.SQL.Add('  CTP_CODEMP = :CODEMP AND ');
  qryGenDup.SQL.Add('  CTP_CODFOR = :CODFOR AND ');
  qryGenDup.SQL.Add('  CTP_SEQBAI > 0 ');

  qryGenDup.ParamByName('NUMDUP').AsString  := strNumDup;
  qryGenDup.ParamByName('PARCEL').AsString  := strParcel;
  qryGenDup.ParamByName('SERIE_').AsString  := strSerie;
  qryGenDup.ParamByName('CODEMP').AsString  := strCodEmp;
  qryGenDup.ParamByName('CODFOR').AsString  := strCodFor;
  qryGenDup.Open;


  Result := (qryGenDup.FieldByName('QTD').AsInteger) > 0;

  qryGenDup.Close;

  FreeAndNil(qryGenDup);
End;

procedure TfrmExclusaoAutCtaPagar.dbgDuplicatasViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
  If Not cdsCtaPag.Active Then
    Exit;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTP_MARDES.Index]) = 'M' Then
  Begin
    If AViewInfo.Selected Then
      ACanvas.Font.Color := clLime
    Else
      ACanvas.Font.Color := clBlue;
  End;

  If AViewInfo.Item.Caption = 'Veio Boleto?' Then
  Begin
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTP_VEIOBO.Index]) = 'NÃO' Then
      ACanvas.Font.Color := clRed
    Else
    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTP_VEIOBO.Index]) = 'SIM' Then
    Begin
      If AViewInfo.Selected Then
        ACanvas.Font.Color := 13703910
      Else
        ACanvas.Font.Color := 5966692;
    End;
  End;

end;

procedure TfrmExclusaoAutCtaPagar.dbgDuplicatasViewDblClick(Sender: TObject);
begin
  inherited;
  LMarcarTodos := False;
  pSelecionaDuplicata;
end;

procedure TfrmExclusaoAutCtaPagar.dbgDuplicatasViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    pSelecionaDuplicata
  Else if (Key = VK_Escape) Then
  Begin
    btnSair.Click;
  End;
end;

function TfrmExclusaoAutCtaPagar.ExcluirDuplicataGeradaDeKMRodados(
  AChaveDuplicata: String; ALimpar: Boolean): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := True;

  If cdsClone.FieldByname('CTP_SEQBAI').AsInteger <> 0 Then
    Exit;

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT * ' +
                          'FROM MANKMT ' +
                          'WHERE KMT_CTPDOC="' + AChaveDuplicata + '"';

    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin
      If Not ALimpar Then
        Result := fMensagem('ATENÇÃO', 'Essa duplicata foi gerada através de um registro de Km Rodados.' + #13 +
                                       'Deseja realmente excluir a duplicata selecionada?', ['&Sim', '&Não']) = 1
      Else
      Begin
        LConsulta.Edit;
        LConsulta.FieldByName('KMT_CTPDOC').Value := Null;
        LConsulta.Post;
      End;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmExclusaoAutCtaPagar.pRetDupSelecionadas(var intQtdSel: Integer);
  Var
    cdsGen: TUniClientDataSet;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  cdsGen.AggregatesActive := True;
  cdsGen.Data := cdsCtaPag.Data;

  intQtdSel := 0;

  cdsGen.Filtered := False;
  cdsGen.Filter := 'CTP_MARDES = ' + QuotedStr('M');
  cdsGen.Filtered := True;

  If Not cdsGen.IsEmpty Then
  Begin
    intQtdSel := cdsGen.RecordCount;
  End;

  FreeAndNil(cdsGen);
end;


procedure TfrmExclusaoAutCtaPagar.btnMarcarTodasClick(Sender: TObject);
begin
  inherited;
  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If Not btnMarcarTodas.Enabled Then
    Exit;

  If cdsCtaPag.IsEmpty Then
    Exit;

  If (Not btnMarcarTodas.Enabled) Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := fMarcarTodos;
    frmGravando.lblGravando.Caption := 'Aguarde... Marcando Títulos.';
    frmGravando.ShowModal;
  Finally
    pFreeAndNil(frmGravando);
  End;
end;

procedure TfrmExclusaoAutCtaPagar.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmExclusaoAutCtaPagar.fMarcarTodos(pgbProgresso: TcxProgressBar):Boolean;
Begin
  Result := True;
  Application.ProcessMessages;

  Try

    LTemDuplicataAG := False;
    LMarcarTodos := True;

    LTemDuplicataAG := False;
    LMarcarTodos := True;

    cdsCtaPag.DisableControls;
    cdsCtaPag.First;
    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := cdsCtaPag.RecordCount;

    While Not cdsCtaPag.Eof Do
    Begin

      pMarcaDuplicata(False);

      pMarcaDuplicata(True);

      cdsCtaPag.Next;
      pStepStatusSelecao(pgbProgresso);
      Application.ProcessMessages;
    End;
    cdsCtaPag.First;

    If LTemDuplicataAG Then
    Begin
       fMensagem('ATENÇÃO','Alguma(s) duplicata(s) não foi(ram) selecionada(s), pois é(são) duplicata(s) de agrupamento!'+ #13 +
                 'É necessário que seja feito o desagrupamento.', ['&OK']);
       LMarcarTodos := False;
    End;

    If LTemDuplicataAG Then
    Begin
       fMensagem('ATENÇÃO','Alguma(s) duplicata(s) não foi(ram) selecionada(s), pois é(são) duplicata(s) de agrupamento!'+ #13 +
                 'É necessário que seja feito o desagrupamento.', ['&OK']);
       LMarcarTodos := False;
    End;

  Finally
    cdsCtaPag.EnableControls
  End;
end;

function TfrmExclusaoAutCtaPagar.fDesmarcarTodos(pgbProgresso: TcxProgressBar): Boolean;
Begin
  Result := True;

  Try
    cdsCtaPag.DisableControls;
    cdsCtaPag.First;
    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := cdsCtaPag.RecordCount;

    While Not cdsCtaPag.Eof Do
    Begin
      pStepStatusSelecao(pgbProgresso);

      pMarcaDuplicata(False);

      cdsCtaPag.Next;
      Application.ProcessMessages;
    End;
    cdsCtaPag.First;

  Finally
    cdsCtaPag.EnableControls;
  End;
End;

function TfrmExclusaoAutCtaPagar.fDuplicatasJaUtilizadasPorOutrosUsuarios: Boolean;
Begin
  Result := False;

  If fVerificaDupBaixada(cdsClone.FieldByName('NRODUP').AsString,
                         cdsClone.FieldByName('PARDUP').AsString,
                         cdsClone.FieldByName('CTP_SERIE_').AsString,
                         cdsClone.FieldByName('CTP_CODEMP').AsString,
                         cdsClone.FieldByName('CTP_CODFOR').AsString,
                         cdsClone.FieldByName('CTP_SEQBAI').AsInteger,
                         cdsClone.FieldByName('TOTDUP').AsFloat) Then
  begin
    Result := True;
  End;

End;

function TfrmExclusaoAutCtaPagar.fLiberacaoApagarDuplicata: Boolean;
  Var
    sumValDup,
    sumValJur,
    sumValMul,
    sumValDes,
    sumValTot     : Double;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
Begin
  Result := False;

  If (fEmptyStr(fCfgSis('SEXCTP'))) Then
  Begin
    Result := True;
    Exit;
  End;

  If Not fPedeSenha Then
    Exit;

  If (fCfgSis('SENFVU') <> 'F') Then
  Begin

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('EXCLUSÃO DE DUPLICATAS - CONTAS A PAGAR');
    objLiberacao.objMsgLibera.pAddSeparador(83);


    objLiberacao.objMsgLibera.pAddTexto('DADOS DE EXCLUSÃO - DUPLICATAS', alCentro, teAmbos, '', 83);
    objLiberacao.objMsgLibera.pAddSeparador(83);


    objTabela := TRegistroMsgLiberaTabela.Create;
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;

    objLinha.pAddColuna(''  , 'DOCUMENTO'        , 21  , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'FORNECEDOR'       , 30 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'DATA CADASTRO'    , 10  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'DATA VENCIMENTO'  , 10  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'VALOR DUPLICATA'  , 12  , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'DESCONTO'         , 12  , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'JUROS'            , 12  , alDireita   , teAutcom);
    objLinha.pAddColuna(''  , 'MULTA'            , 12  , alDireita   , teAutcom);
    objTabela.lstLinhas.Add(objLinha);
    cdsClone.First;

    While Not cdsClone.Eof Do
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('DUPLICATA'       , cdsClone.FieldByName('CTP_NUMDUP').AsString +' - '+cdsClone.FieldByName('CTP_CODEMP').AsString                          , 21  , alEsquerda );
      objLinha.pAddColuna('FORNECEDOR  '    , cdsClone.FieldByName('CTP_NOMFOR').AsString                                                                             , 30 , alEsquerda );
      objLinha.pAddColuna('DATA CADASTRO'   , FormatDateTime('dd/MM/yyyy', cdsClone.FieldByName('CTP_DTACAD').AsDateTime)                                             , 10  , alCentro   );
      objLinha.pAddColuna('DATA VENCIMENTO' , FormatDateTime('dd/MM/yyyy', cdsClone.FieldByName('CTP_DTAVEN').AsDateTime)                                             , 10  , alCentro   );
      objLinha.pAddColuna('VALOR DUPLICATA' , FloatToStrF(cdsClone.FieldByName('CTP_VALDUP').AsFloat, ffNumber, 12, 2)                                                , 12  , alDireita  );
      objLinha.pAddColuna('DESCONTO'        , FloatToStrF(cdsClone.FieldByName('CTP_DESSUJ').AsFloat, ffNumber, 12, 2)                                                , 12  , alDireita  );
      objLinha.pAddColuna('JUROS'           , FloatToStrF(cdsClone.FieldByName('CTP_JURSUJ').AsFloat, ffNumber, 12, 2)                                                , 12  , alDireita  );
      objLinha.pAddColuna('MULTA'           , FloatToStrF(cdsClone.FieldByName('CTP_MULSUJ').AsFloat, ffNumber, 12, 2)                                                , 12  , alDireita  );
      objTabela.lstLinhas.Add(objLinha);
      cdsClone.Next;
    End;
    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);
    objLiberacao.objMsgLibera.pAddSeparador(83);

    sumValDup := cdsClone.FieldByName('CTP_VALDUP').AsFloat;
    sumValJur := cdsClone.FieldByName('CTP_JURSUJ').AsFloat;
    sumValMul := cdsClone.FieldByName('CTP_MULSUJ').AsFloat;
    sumValDes := cdsClone.FieldByName('CTP_DESSUJ').AsFloat;
    sumValTot := sumValDup + sumValJur + sumValMul - sumValDes;

    objLiberacao.objMsgLibera.pAddTextoCaption('TOTAL', FloatToStrF(sumValTot, ffNumber, 9, 2) , 15, alDireita, teAmbos, '', 15);
    objLiberacao.objMsgLibera.pAddSeparador(83);


    objLiberacao.strDirAce := 'CTPEXCDUP';
    objLiberacao.strSenLib := fCfgSis('SEXCTP');
    objLiberacao.strMsgSen := 'Excluir Duplicata';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.tipCliFor := cfFornecedor;

    If objLiberacao.fLibera Then
    Begin
      Result := True;
    End;
  End;
End;


procedure TfrmExclusaoAutCtaPagar.FormShow(Sender: TObject);
begin
  inherited;

  If (Not fCfgSis('CTPTUD', varBoolean)) Then
  Begin
    btnMarcarTodas.Enabled := False;
    btnMarcarTodas.Visible := False;
    btnConfirma.Left := btnMarcarTodas.Left;
  End;

end;

procedure TfrmExclusaoAutCtaPagar.BtnSelecionadasClick(Sender: TObject);
begin
  inherited;

  If Not btnSelecionadas.Enabled Then
    Exit;

  If Not cdsCtaPag.IsEmpty Then
    frmConsDuplicSelec.pMostraDuplicatasSelecionadas('CADPAG', cdsCtaPag)
  Else
   fMensagem('AVISO', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
end;

procedure TfrmExclusaoAutCtaPagar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Escape) Then
  Begin
    btnSair.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End
  Else If (Key = VK_F7) Then
  Begin
    btnMarcarTodas.Click;
  End
  Else If (Key = VK_F8) Then
  Begin
    btnDesmarcarTodas.Click;
  End
  Else If (Key = VK_F9) Then
  Begin
    BtnSelecionadas.Click;
  End;
end;

procedure TfrmExclusaoAutCtaPagar.FormDestroy(Sender: TObject);
begin
  pLiberaDupsMarcadas;
  FreeAndNil(objLiberacao);

  inherited;
  FreeAndNil(objLock);
end;

function TfrmExclusaoAutCtaPagar.fApagarDuplicatas(pgbProgresso: TcxProgressBar): Boolean;
  Var
    intSeqBai     : Integer;
    strNumDup,
    strParcel,
    strSerie,
    strCodEmp,
    strCodFor,
    strCTPCom,
    strChaveLck   : String;
    blnRatEve     : Boolean;
    objPag        : TCadPag;
    objRep        : TCadPagRepository;
begin
  Result := True;
  cdsClone.First;
  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max := cdsClone.RecordCount;

  While Not cdsClone.Eof Do
  Begin

    strNumDup := cdsClone.FieldByName('NRODUP').AsString;
    strParcel := cdsClone.FieldByName('PARDUP').AsString;
    strSerie  := cdsClone.FieldByName('CTP_SERIE_').AsString;
    strCodEmp := cdsClone.FieldByName('CTP_CODEMP').AsString;
    strCodFor := cdsClone.FieldByName('CTP_CODFOR').AsString;


    strCTPCom := cdsClone.FieldByName('CTP_CTPCOM').AsString;
    intSeqBai := cdsClone.FieldByName('CTP_SEQBAI').AsInteger;

    {*************************************************************}
    {* RETORNA A DUPLICATA ANTES DE EXCLUIR PARA GRAVAR O LOGCTP *}
    {*************************************************************}
    objRep      := TCadPagRepository.Create;
    objPag      := objRep.fRetDuplicata(strNumDup, strParcel, intSeqBai, strCodEmp, strCodFor, strSerie);

    strChaveLck := 'CADPAG' + cdsClone.FieldByName('AUTOINCREM').AsString;

    If fDeleteCADPAG(cdsClone.FieldByName('AUTOINCREM').AsString) Then
    Begin
      If Assigned(objPag) Then
      begin
        untLogCtp.pGravaLogCtp(objPag, 'EXCLUSAO (AUTOMÁTICA)', Self.Name);
        objRep.pGravaDelCadPag(objPag, Self.Name);
      end;

      // Limpa CTPCom de todas tabelas
      If Not fEmptyStr(strCTPCom) Then
        pLimpaCTPCom(strCTPCom);

      {*****************************************}
      {* CASO HAJA ALGUM CTPDET, EXCLUI DA TA- *}
      {* BELA REAL                             *}
      {**************************************MV*}
      If fVerificaCtpDet(strNumDup, strParcel, strSerie, strCodEmp, strCodFor, blnRatEve) Then
      Begin
        pDeletaCtpDet(strNumDup, strParcel, strSerie, strCodEmp, strCodFor);
      End;

      ExcluirDuplicataGeradaDeKMRodados(strNumDup + '-' +
                                        strParcel + '-' +
                                        strCodEmp + '-' +
                                        strCodFor + '-' +
                                        strSerie,
                                        True);


      fLock_Unlock(strChaveLck, False);
    End;


    cdsClone.Next;
    pStepStatusSelecao(pgbProgresso);
  End;
  If Assigned(objRep) Then
    FreeAndNil(objRep);
end;

end.


