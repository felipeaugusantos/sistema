unit untBaixaChequesCustodia;

interface

uses
  Windows, Types, Classes, Controls, StdCtrls, untPaiSimples, Grids, DBGridCitel, DBGrids,
  Mask, Uni, MaskEditFocus, ComCtrls, Buttons, ExtCtrls, DB, Menus, EditFocus,
  AppEvnts, UniClientDataSet, untFuncoesSimples, BitBtnLockedIncrem, untTypesSistema,
  frxClass, frxExportCSVTestabilidade,  CxProgressBar, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore,
  cxDateUtils,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxDataControllerConditionalFormattingRulesManagerDialog,untBuscaCheques,
  untTBanChqRepository, untTBanCtpRepository;

type
  TfrmBaixaChequesCustodia = class(TfrmPaiSimples)
    pnlAux1: TPanel;
    pnlDadosDup: TPanel;
    Label5: TLabel;
    Nome: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    pnlInformativos: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    pnlBotoesBaixa: TPanel;
    pnlCabecalho: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    pnlAux2: TPanel;
    pnlTotais: TPanel;
    Label23: TLabel;
    label9: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label11: TLabel;
    Label15: TLabel;
    Label20: TLabel;
    edtCodBco: TEditFocus;
    edtNomBco: TEditFocus;
    edtNumAge: TEditFocus;
    edtConCor: TEditFocus;
    edtNumChq: TEditFocus;
    edtNomEmi: TEditFocus;
    edtEndere: TEditFocus;
    edtFone01: TEditFocus;
    edtNumNot: TEditFocus;
    edtDtaVen: TEditFocus;
    edtValChq: TEditFocus;
    edtChqSelecionados: TEditFocus;
    edtTotalSelecionado: TEditFocus;
    edtValorTotal: TEditFocus;
    edtTotalCheques: TEditFocus;
    lbl2: TLabel;
    lbl1: TLabel;
    edtDesEmpresa: TEditFocus;
    edtCodEmpresa: TEditFocus;
    lblEmpresa: TLabel;
    btnConfirma: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmTodos: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    btnIniBus: TBitBtnLocked;
    btnCarrCheques: TBitBtnLocked;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    mskCadFin: TcxDateEdit;
    mskCadIni: TcxDateEdit;
    dbgCheques: TcxGrid;
    dbgChequesDados: TcxGridDBTableView;
    dbgChequesDadosCHQ_CODBCO: TcxGridDBColumn;
    dbgChequesDadosCHQ_NUMCHQ: TcxGridDBColumn;
    dbgChequesDadosCHQ_CODEMP: TcxGridDBColumn;
    dbgChequesDadosCHQ_DTAVEN: TcxGridDBColumn;
    dbgChequesDadosCHQ_VALCHQ: TcxGridDBColumn;
    dbgChequesDadosCHQ_MARDES: TcxGridDBColumn;
    dbgChequesNivel: TcxGridLevel;
    FlwPnlBotoesBaixa: TFlowPanel;
    procedure btnSairBaixaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnDesmTodosClick(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnCarrChequesClick(Sender: TObject);
    procedure dbgChequesDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure dbgChequesDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    frmBuscaCheques : TfrmBuscaCheques;
    cdsCheque: TUniClientDataSet;
    dtsCheque: TDataSource;

    cdsChequesDeposito: TUniClientDataSet;

    strPorCus: String;
    dtaDtaCus: TDateTime;
    strObsCus: String;
    strDocCus: String;
    strNumLot: String;

    strValorFiltro: String;
    strCampoFiltro: String;

    strCtaBai : String;
    strPorBai : String;
    strNomPorBai : String;
    strCtaDeb : String;
    strPorDeb : String;

    AValorTarifaDescAntec: Double;
    AValorTaxaDescAntec  : Double;
    APlanoContasAntecipacao: String;
    AFornecedorAntecipacao: String;

    strHistorChq : String;

    procedure pAtualizaTemporaria;
    procedure pCalculaTotalCheques(edtQtdChq, edtValTot: TEditFocus; blnFiltrar: Boolean);
    procedure pLimpaDados;
    procedure pAtualizaDados(DataSet: TDataSet);

    procedure pSelecionaCheque;
    procedure pMarcaCheque(blnMarcar: Boolean; blnMarcarTodos: Boolean = False);
    function  fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    function  fDesmarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pStep(pgbStatus: TcxProgressBar);

    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    function fCustodiaCheques(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fExportaTXT(strCodBco: String): Boolean;

    procedure pBuscaIni;
    procedure pBuscaProx;

    function fDigInfoCheque : Boolean;
    function fMaiorDtaCad: TDate;

    procedure pDestravaCheques;
    function fDigInfoBaixaDeposito: Boolean;
    procedure pRealizaDepositoDeCheques;
    function  fBaixaCheques(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pVerificaHistoricoCheque(strHistorico, strDtaVenc, strDtaDep, strContaDep, strPortador: String);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    arrEmpresa : TConsultasArray;
    strEmpresa : String;

    arrSeqLan: TStringArray;
  end;


implementation

uses SysUtils, Graphics, Forms, MaskUtils, StrUtils, untBaixaDigCustodia,
   untCadChq, UniDataSetProvider, untFuncoesGenerica, untFuncoesConsulta,
   untConsultas, untTCadChqRepository, untGravando, Variants, untRemChq, untBaixaAnalitica,
   untfuncoes, untMovBan;


{$R *.dfm}

procedure TfrmBaixaChequesCustodia.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  pLimpaDados;
  Close;
end;

function TfrmBaixaChequesCustodia.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodEmpresa) Then
    Begin
      If fEmptyStr(edtCodEmpresa.Text) Then
        edtDesEmpresa.Text := 'TODOS';

    End

    {*****************************************}
    {* VALIDAÇÃO DATA DE CADASTRO            *}
    {**************************************LE*}

    Else If (Sender = mskCadFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text)) And (StrToDateDef(mskCadFin.Text,0) <= 0) Then
      Begin
        fMensagem('', 'A Data Final informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text))  And (Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      If Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text)) And (fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) Then
        Begin
          fMensagem('','O campo Data Inicial deve ser preechindo!',['&O k']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskCadFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) Then
          Begin
            If StrToDate(mskCadIni.Text) > StrToDate(mskCadFin.Text) Then
            Begin
              fMensagem('','A Data Inicial deve ser menor que a data final!',['&O K']);
              Result := False;
              Sender := mskCadIni;
            End;
          End;
        End;
    End
    Else
    If (Sender = mskCadIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text))) And (StrToDateDef(mskCadIni.Text,0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskCadIni;
        End;
    End
    {*****************************************}
    {* VALIDAÇÃO DATA DE VENCIMENTO          *}
    {**************************************LE*}
    Else If (Sender = mskDtaFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (StrToDateDef(mskDtaFin.Text,0) <= 0) Then
      Begin
        fMensagem('', 'A Data Final informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))  And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
        Begin
          fMensagem('','O campo Data Inicial deve ser preechindo!',['&O k']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A Data Inicial deve ser menor que a data final!',['&O K']);
              Result := False;
              Sender := mskDtaIni;
            End;
          End;
        End;
    End
    Else
    If (Sender = mskDtaIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) And (StrToDateDef(mskDtaIni.Text,0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIni;
        End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaChequesCustodia.pAtualizaTemporaria;
  Var
    strSQL: String;
    qryCheque: TUniQuery;
    dspCheque: TUniDataSetProvider;
begin
  Try
    pDestravaCheques;
    cdsCheque.Close;
    qryCheque := fCriaQuery(Self);
    dspCheque := TUniDataSetProvider.Create(Self);
    dspCheque.DataSet := qryCheque;
    cdsCheque.SetProvider(dspCheque);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  Q.AUTOINCREM, ';
    strSQL := strSQL + '  Q.CHQ_CODBCO, ';
    strSQL := strSQL + '  B.BCO_NOMBCO AS CHQ_NOMBCO, ';
    strSQL := strSQL + '  Q.CHQ_NUMAGE, ';
    strSQL := strSQL + '  Q.CHQ_CONCOR, ';
    strSQL := strSQL + '  Q.CHQ_NUMCHQ, ';
    strSQL := strSQL + '  Q.CHQ_CODCLI, ';
    strSQL := strSQL + '  Q.CHQ_NOMEMI, ';
    strSQL := strSQL + '  Q.CHQ_ENDERE, ';
    strSQL := strSQL + '  Q.CHQ_TELEMI, ';
    strSQL := strSQL + '  Q.CHQ_CGCCPF, ';
    strSQL := strSQL + '  Q.CHQ_C_G_C_, ';
    strSQL := strSQL + '  Q.CHQ_DTACAD, ';
    strSQL := strSQL + '  Q.CHQ_DTAVEN, ';
    strSQL := strSQL + '  Q.CHQ_VALCHQ, ';
    strSQL := strSQL + '  Q.CHQ_HIST01, ';
    strSQL := strSQL + '  Q.CHQ_HIST02, ';
    strSQL := strSQL + '  Q.CHQ_CTADEP, ';
    strSQL := strSQL + '  Q.CHQ_DOCDEP, ';
    strSQL := strSQL + '  Q.CHQ_CODPOR, ';
    strSQL := strSQL + '  Q.CHQ_CODCTA, ';
    strSQL := strSQL + '  Q.CHQ_DTADEV, ';
    strSQL := strSQL + '  Q.CHQ_MOTDEV, ';
    strSQL := strSQL + '  Q.CHQ_DTARDP, ';
    strSQL := strSQL + '  Q.CHQ_FORREP, ';
    strSQL := strSQL + '  Q.CHQ_OBSREP, ';
    strSQL := strSQL + '  Q.CHQ_DTAREP, ';
    strSQL := strSQL + '  Q.CHQ_RESCAI, ';
    strSQL := strSQL + '  Q.CHQ_CODEMP, ';
    strSQL := strSQL + '  Q.CHQ_NUMNOT, ';
    strSQL := strSQL + '  Q.CHQ_DTACUS, ';
    strSQL := strSQL + '  Q.CHQ_PORCUS, ';
    strSQL := strSQL + '  Q.CHQ_DOCUME, ';
    strSQL := strSQL + '  Q.CHQ_INCCTR, ';
    strSQL := strSQL + '  Q.CHQ_HISTOR, ';
    strSQL := strSQL + '  Q.CHQ_DOCCUS, ';
    strSQL := strSQL + '  Q.CHQ_LOTCUS, ';
    strSQL := strSQL + '  Q.CHQ_PORDEB, ';
    strSQL := strSQL + '  Q.CHQ_CTADEB, ';
    strSQL := strSQL + '  Q.CHQ_MOTDV2, ';
    strSQL := strSQL + '  Q.CHQ_DTADP2, ';
    strSQL := strSQL + '  Q.CHQ_DTADV2, ';
    strSQL := strSQL + '  Q.CHQ_SEQCOM, ';
    strSQL := strSQL + '  Q.CHQ_DTATRA, ';
    strSQL := strSQL + '  Q.CHQ_SEQCON, ';
    strSQL := strSQL + '  Q.CHQ_EMPRCX, ';
    strSQL := strSQL + '  Q.CHQ_DEVDEF, ';
    strSQL := strSQL + '  Q.CHQ_CODVEN, ';
    strSQL := strSQL + '  Q.CHQ_SEQTRF, ';
    strSQL := strSQL + '  Q.CHQ_DUPDEV, ';
    strSQL := strSQL + '  Q.CHQ_DUPDEP, ';
    strSQL := strSQL + '  Q.CHQ_CTDPSV, ';
    strSQL := strSQL + '  Q.CHQ_CTDBSV, ';
    strSQL := strSQL + '  Q.CHQ_PRDBSV, ';
    strSQL := strSQL + '  Q.CHQ_CDCTSV, ';
    strSQL := strSQL + '  Q.CHQ_CDPRSV, ';
    strSQL := strSQL + '  Q.CHQ_TELCHE, ';
    strSQL := strSQL + '  Q.CHQ_TELNUM, ';
    strSQL := strSQL + '  Q.CHQ_SEQDEP, ';
    strSQL := strSQL + '  Q.CHQ_CODOPE, ';
    strSQL := strSQL + '  Q.CHQ_CODCMC, ';
    strSQL := strSQL + '  CAST(IF(Q.CHQ_DTADP2 IS NULL, Q.CHQ_DTADEP, Q.CHQ_DTADP2) AS DATE) AS CHQ_DTADEP, ';
    strSQL := strSQL + '  " " AS CHQ_MARDES ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCHQ Q, ';
    strSQL := strSQL + '  CADBCO B ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  Q.CHQ_CODBCO = B.BCO_CODBCO AND ';
    strSQL := strSQL + '  Q.CHQ_DTAREP IS NULL AND ';
    strSQL := strSQL + '  ((Q.CHQ_DTADEP IS NULL) OR ((Q.CHQ_DTADP2 IS NULL) AND (Q.CHQ_DTADEV IS NOT NULL))) AND ';
    strSQL := strSQL + '  Q.CHQ_DTACUS IS NULL AND ';
    strSQL := strSQL + '  Q.CHQ_INCCTR = "N" ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) Then
      strSQL := strSQL + '  AND Q.CHQ_DTACAD BETWEEN :CADINI AND :CADFIN ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      strSQL := strSQL + '  AND Q.CHQ_DTAVEN BETWEEN :DTAINI AND :DTAFIN ';

    strSQL := strSQL + '  AND (CHQ_NAODEP = "N" OR CURRENT_DATE >= CHQ_DTAVEN ) ';

    If Not fEmptyStr(edtCodEmpresa.Text) Then
      strSQL := strSQL + fStrLocate(edtCodEmpresa, arrEmpresa, 'Q.CHQ_CODEMP', 'CODEMP');

    With qryCheque Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) Then
      Begin
        ParamByName('CADINI').AsDateTime := StrToDateTime(mskCadIni.Text);
        ParamByName('CADFIN').AsDateTime := StrToDateTime(mskCadFin.Text);
      End;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
      Begin
        ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
        ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
      End;

      pSetaParam(edtCodEmpresa.Text, arrEmpresa, strEmpresa, 'CODEMP', qryCheque);

      Open;

      If Not IsEmpty Then
      Begin
        pSetaClient(qryCheque);
        cdsCheque.Open;
        TFloatField(cdsCheque.FieldByName('CHQ_VALCHQ')).DisplayFormat := '#,##0.00';
      End;

      Close;

    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmBaixaChequesCustodia.pAtualizaTemporaria]');
    End;
  End;
 //
  cdsCheque.SetProvider(nil);
  FreeAndNil(dspCheque);
  FreeAndNil(qryCheque);
end;

procedure TfrmBaixaChequesCustodia.pCalculaTotalCheques(edtQtdChq,
  edtValTot: TEditFocus; blnFiltrar: Boolean);
  Var
    cdsGen: TUniClientDataSet;
    fldGen: TAggregateField;
begin
  Try
    cdsGen := TUniClientDataSet.Create(Self);
    fldGen := TAggregateField.Create(Self);
    With fldGen Do
    Begin
      Name          := 'cdsGenCHQ_TOTCHQ';
      FieldName     := 'CHQ_TOTCHQ';
      DataSet       := cdsGen;
      Expression    := 'SUM(CHQ_VALCHQ)';
      DisplayFormat := '#,##0.00';
      Active        := True;
    End;
    cdsGen.AggregatesActive := True;
    cdsGen.Data := cdsCheque.Data;

    With cdsGen Do
    Begin
      If blnFiltrar Then
      Begin
        Filtered := False;
        Filter := 'CHQ_MARDES = ''M''';
        Filtered := True;
      End;

      If Not cdsGen.IsEmpty Then
      Begin
        edtQtdChq.Text := IntToStr(RecordCount);
        If Not fEmptyStr(TAggregateField(FieldByName('CHQ_TOTCHQ')).Value) Then
          edtValTot.Text := FormatFloat('#,##0.00', TAggregateField(FieldByName('CHQ_TOTCHQ')).Value)
        Else
          edtValTot.Text := '0,00';
      End
      Else
      Begin
        edtQtdChq.Text := '0';
        edtValTot.Text := '0,00';
      End;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmBaixaChequesCustodia.pCalculaTotalCheques]');
    End;
  End;

  FreeAndNil(fldGen);
  FreeAndNil(cdsGen);
end;

procedure TfrmBaixaChequesCustodia.pDestravaCheques;
Var
  prcScroll: TprcScroll;
begin
  With cdsCheque Do
  Begin
    If Not Active Then
      Exit;

    pDisableControls(cdsCheque, prcScroll);
    OnFilterRecord := Nil;
    Filter := 'CHQ_MARDES=' + QuotedStr('M');
    Filtered := True;

    First;
    While Not Eof do
    begin
      If FieldByName('CHQ_MARDES').AsString = 'M' Then
        fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);

      Next;
    end;
    Filter := '';
    Filtered := False;
    OnFilterRecord := pFilterRecord;
  End;
  pEnableControls(cdsCheque, prcScroll);
end;

procedure TfrmBaixaChequesCustodia.pAtualizaDados(DataSet: TDataSet);
begin
  If cdsCheque.ControlsDisabled = False Then
  Begin
    edtCodBco.Text := DataSet.FieldByName('CHQ_CODBCO').AsString;
    edtNomBco.Text := DataSet.FieldByName('CHQ_NOMBCO').AsString;
    edtNumAge.Text := DataSet.FieldByName('CHQ_NUMAGE').AsString;
    edtConCor.Text := DataSet.FieldByName('CHQ_CONCOR').AsString;
    edtNumChq.Text := DataSet.FieldByName('CHQ_NUMCHQ').AsString;
    edtNomEmi.Text := DataSet.FieldByName('CHQ_NOMEMI').AsString;
    edtEndere.Text := DataSet.FieldByName('CHQ_ENDERE').AsString;
    edtFone01.Text := fFormataFone(DataSet.FieldByName('CHQ_TELEMI').AsString);
    edtNumNot.Text := DataSet.FieldByName('CHQ_NUMNOT').AsString;
    edtDtaVen.Text := DataSet.FieldByName('CHQ_DTAVEN').AsString;
    edtValChq.Text := FormatFloat('#,##0.00', DataSet.FieldByName('CHQ_VALCHQ').AsFloat);
  End;
end;

procedure TfrmBaixaChequesCustodia.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskCadIni);
end;

procedure TfrmBaixaChequesCustodia.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  pLimpaDados;
end;

procedure TfrmBaixaChequesCustodia.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CADCHQ';

  strPorCus := '';
  dtaDtaCus := 0.0;
  strObsCus := '';
  strDocCus := '';

  cdsCheque := TUniClientDataSet.Create(Self);
  cdsCheque.OnFilterRecord := pFilterRecord;
  cdsCheque.AfterScroll    := pAtualizaDados;

  dtsCheque := fCriaDataSource(cdsCheque);
  dbgChequesDados.DataController.DataSource := dtsCheque;
end;

procedure TfrmBaixaChequesCustodia.pMarcaCheque(blnMarcar: Boolean; blnMarcarTodos: Boolean = False);
begin
  With cdsCheque Do
  Begin
    If blnMarcar Then
    Begin
      If Not fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, True, False) Then
      Begin
        If Not blnMarcarTodos Then
          fMensagem('ATENÇÃO!', 'Esse cheque está sendo utilizado por outra estação: ' + fGetHostLock('CADCHQ' + FieldByName('AUTOINCREM').AsString), ['&Ok']);
        Exit;
      End;
    End
    Else
      fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);

    Edit;
    FieldByName('CHQ_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
    Post;
  End;
end;

procedure TfrmBaixaChequesCustodia.pSelecionaCheque;
begin
  If cdsCheque.FieldByName('CHQ_MARDES').AsString <> 'M' Then
    pMarcaCheque(True)
  Else
    pMarcaCheque(False);

 pCalculaTotalCheques(edtChqSelecionados, edtTotalSelecionado, True);
end;

procedure TfrmBaixaChequesCustodia.dbgChequesDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
  Var
  strMarDes : String;
begin
  inherited;

  With cdsCheque Do
  Begin
    If Not Active Then
      Exit;

   strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgChequesDadosCHQ_MARDES.Index]);

    If strMardes = 'M' Then
      If (Not AViewInfo.Selected) Then
        ACanvas.Font.Color := clBlue;
  End;

end;

procedure TfrmBaixaChequesCustodia.dbgChequesDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) And (Not cdsCheque.IsEmpty) Then
  Begin
    pSelecionaCheque;
    dbgChequesDados.NavigatorButtons.Next.Click;
    pSetFocus(dbgCheques);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(mskCadIni);
  End;

end;

procedure TfrmBaixaChequesCustodia.edtCodEmpresaExit(Sender: TObject);
begin
  inherited;
  If Not edtCodEmpresa.ReadOnly Then
    pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmBaixaChequesCustodia.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************IV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrEmpresa, False, True) Then
  Begin
    If fValidaCampos(edtCodEmpresa,False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaChequesCustodia.pLimpaDados;
begin
  edtCodBco.Clear;
  edtNomBco.Clear;
  edtNumAge.Clear;
  edtConCor.Clear;
  edtNumChq.Clear;
  edtNomEmi.Clear;
  edtEndere.Clear;
  edtFone01.Clear;
  edtNumNot.Clear;
  edtDtaVen.Clear;
  edtValChq.Clear;

  edtTotalCheques.Clear;
  edtValorTotal.Clear;

  edtChqSelecionados.Clear;
  edtTotalSelecionado.Clear;

  mskCadIni.Clear;
  mskCadFin.Clear;
  mskDtaIni.Clear;
  mskDtaFin.Clear;

  strNumLot := '';

  pDestravaCheques;

  cdsCheque.Close;
end;

procedure TfrmBaixaChequesCustodia.btnCarrChequesClick(Sender: TObject);
begin
  inherited;
   If Not fValidaCampos(mskDtaIni, False) And
     Not fValidaCampos(mskDtaFin, False)  Or
     Not fValidaCampos(mskDtaIni, False)  Or
     Not fValidaCampos(mskDtaFin, False)  Then
     Exit;

   If Not fValidaCampos(mskCadIni, False) And
      Not fValidaCampos(mskCadFin, False)  Or
      Not fValidaCampos(mskCadIni, False)  Or
      Not fValidaCampos(mskCadFin, False)  Then
      Exit;


  TfrmGravando.fExecutarModal(pAtualizaTemporaria,'Aguarde... Carregando Cheques.','');

  if cdsCheque.IsEmpty then
  begin
    fMensagem('', 'Não há cheques a serem enviados para custódia!', ['&O k']);
    pSetFocus(mskCadIni);
    blnMudarFoco := False;
  End;

  If Not cdsCheque.IsEmpty Then
  Begin
    pCalculaTotalCheques(edtTotalCheques, edtValorTotal, False);
    pCalculaTotalCheques(edtChqSelecionados, edtTotalSelecionado, True);
    pSetFocus(dbgCheques);
  End
  Else
    pLimpaDados ;

end;

procedure TfrmBaixaChequesCustodia.btnConfirmaClick(Sender: TObject);
Begin
  inherited;

  If (Not cdsCheque.Active) Or (edtChqSelecionados.Text = '0') Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos um registro!', ['&Ok']);
    Exit;
  End;

  If (Not fEmptyStr(edtTotalSelecionado.Text))  And
     (fStrToFloat(edtTotalSelecionado.Text) > 0) Then
  Begin
    If fDigInfoCheque Then
    Begin
      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.fExecutarAcao := fCustodiaCheques;
      frmGravando.lblGravando.Caption := 'Aguarde... Enviando Cheques para Custódia.';
      frmGravando.ShowModal;
      pFreeAndNil(frmGravando);

      If Not fEmptyStr(strNumLot) Then
        fMensagem('', 'Arquivo de Custódia de Cheques gerado com sucesso!' +
                      #13#10 + 'Número do Lote: ' + strNumLot + '.', ['&Ok'])
      Else
        fMensagem('', 'Rotina de custódia de cheques gerada com sucesso!', ['&Ok']);

      pRealizaDepositoDeCheques();

      pAtualizaTemporaria;
      If Not cdsCheque.IsEmpty Then
      Begin
        pCalculaTotalCheques(edtTotalCheques, edtValorTotal, False);
        pCalculaTotalCheques(edtChqSelecionados, edtTotalSelecionado, True);
      End
      Else
        pLimpaDados;
    End;
    pSetFocus(Self);
  End;

end;

function TfrmBaixaChequesCustodia.fCustodiaCheques(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    repCadChq: TCadChqRepository;
begin

  Application.ProcessMessages;
  fStartTransaction;

  Try

    With cdsCheque Do
    Begin
      DisableControls;
      Try
        First;
        repCadChq := TCadChqRepository.Create;
        pgbStatus.Position := 0;
        pgbStatus.Properties.Max := RecordCount;

        While Not Eof Do
        Begin
          pStep(pgbStatus);
          If FieldByName('CHQ_MARDES').AsString = 'M' Then
          Begin

            pCustodiaCheque(FieldByName('CHQ_CODBCO').AsString,
                            FieldByName('CHQ_NUMAGE').AsString,
                            FieldByName('CHQ_CONCOR').AsString,
                            FieldByName('CHQ_NUMCHQ').AsString,
                            FieldByName('CHQ_CODEMP').AsString,
                            strPorCus,
                            dtaDtaCus,
                            strDocCus,
                            strNumLot);

            fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);

            {********************}
            {* GRAVAR NO LOGCHQ *}
            {*****************JU*}
            repCadChq.pGravaLog(FieldByName('CHQ_CODBCO').AsString, FieldByName('CHQ_NUMAGE').AsString,
                                FieldByName('CHQ_CONCOR').AsString, FieldByName('CHQ_NUMCHQ').AsString,
                                'SELECAO CUSTODIA (frmBaixaChequesCustodia.fCustodiaCheques)');
          End;

          Next;
        End;
      Finally
        EnableControls;
      End;

    End;
    FreeAndNil(repCadChq);
    Result := True;
    fCommit;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[fCustodiaCheques]');
    End;
  End;

end;


procedure TfrmBaixaChequesCustodia.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;


  If (Key = VK_F5) Then
  Begin
    btnIniBus.Click;
  End

  Else If (Key = VK_F6) Then
  Begin
    btnLocProx.Click;
  End

  Else If (Key = VK_F8) Then
  Begin
    btnDesmTodos.Click;
  End

  Else If (Key = VK_F7) Then
  Begin
    btnMarcarTodos.Click;
  End

  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;

end;

procedure TfrmBaixaChequesCustodia.FormShow(Sender: TObject);
begin
  inherited;
  strNumLot := '';
end;

procedure TfrmBaixaChequesCustodia.btnMarcarTodosClick(Sender: TObject);
begin
  If (Not cdsCheque.Active) Or (cdsCheque.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário ter registros para marcar!', ['&Ok']);
    Exit;
  End;

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fMarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Marcando Cheques.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
end;

procedure TfrmBaixaChequesCustodia.btnDesmTodosClick(Sender: TObject);
begin

  If (Not cdsCheque.Active) Or (edtChqSelecionados.Text = '0') Then
  Begin
    fMensagem('', 'É necessário ter registros para desmarcar!', ['&Ok']);
    Exit;
  End;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fDesmarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando Cheques.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);

end;

procedure TfrmBaixaChequesCustodia.btnIniBusClick(Sender: TObject);
begin
  inherited;
  If cdsCheque.IsEmpty Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos um cheque!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmBuscaCheques, frmBuscaCheques);
    frmBuscaCheques.lblDtaFil.Caption := 'Dta. Ven.';
    frmBuscaCheques.ShowModal;
    TfrmGravando.fExecutarModal(pBuscaIni,'Aguarde... Localizando Cheque.','');
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmBaixaCheques.btnIniBusClick]');
    End;
  End;

  pFreeAndNil(frmBuscaCheques);
end;

procedure TfrmBaixaChequesCustodia.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;

procedure TfrmBaixaChequesCustodia.btnLocProxClick(Sender: TObject);
begin
  inherited;

  If cdsCheque.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um cheque!', ['&Ok']);
    Exit;
  End;
  TfrmGravando.fExecutarModal(pBuscaProx,'Aguarde... Localizando Cheque.','');

end;

function TfrmBaixaChequesCustodia.fExportaTXT(strCodBco: String): Boolean;
  Var
    remChq: TRemChq;
begin

  Result := True;

  Try
    strNumLot := '';

    remChq := TRemChq.fCriaRemChq(Self, strCodBco, cdsCheque, fStrToFloat(edtTotalSelecionado.Text), StrToInt(edtChqSelecionados.Text), dtaDtaCus);

    If Not Assigned(remChq) Then
      Result := False
    Else
      strNumLot := remChq.strNumLot;

  Except
    Result := False;
    pMensagensErro('Não foi possivel criar o arquivo remessa custódia de cheques!' ,'TfrmBaixaChequesCustodia.fExportaTXT');
  End;

end;

function TfrmBaixaChequesCustodia.fMaiorDtaCad: TDate;
Var
  cdsTmp : TUniClientDataSet;
begin
  cdsTmp := TUniClientDataSet.Create(Self);
  Try
    cdsTmp.Data := cdsCheque.Data;
    cdsTmp.Filter := 'CHQ_MARDES = ' + QuotedStr('M');
    cdsTmp.Filtered := True;

    cdsTmp.First;
    Result := cdsTmp.FieldByName('CHQ_DTACAD').AsDateTime;

    While not cdsTmp.Eof Do
    Begin
      If ((Not cdsTmp.FieldByName('CHQ_DTACAD').IsNull) And
          (Result < cdsTmp.FieldByName('CHQ_DTACAD').AsDateTime))Then
        Result := cdsTmp.FieldByName('CHQ_DTACAD').AsDateTime;

      cdsTmp.Next;
    End;
  Finally
    FreeAndNil(cdsTmp);
  End;
end;

function TfrmBaixaChequesCustodia.fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
Begin

  With cdsCheque Do
  Begin

    First;
    pgbStatus.position := 0 ;
    pgbStatus.Properties.Max := RecordCount;
    DisableControls;
    While Not Eof Do
    Begin
      pStep(pgbStatus);
      pMarcaCheque(True, True);
      Next;
    End;

  End;
  pCalculaTotalCheques(edtChqSelecionados, edtTotalSelecionado, True);
  cdsCheque.EnableControls;
  cdsCheque.First;
  Result := True;

End;

function TfrmBaixaChequesCustodia.fDesmarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
Begin

  With cdsCheque Do
  Begin
    DisableControls;

    First;
    pgbStatus.position := 0 ;
    pgbStatus.Properties.Max := RecordCount;

    While Not Eof Do
    Begin
      If FieldByName('CHQ_MARDES').AsString = 'M' Then
      Begin
        pStep(pgbStatus);
        pMarcaCheque(False);
      End;
    Next;
    End;
  End;
  pCalculaTotalCheques(edtChqSelecionados, edtTotalSelecionado, True);
  cdsCheque.EnableControls;
  cdsCheque.First;
  Result := True;
End;

procedure TfrmBaixaChequesCustodia.pStep(pgbStatus: TcxProgressBar);
Begin

  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.position := pgbStatus.position + 1;
    Application.ProcessMessages;
  End;

End;

procedure TfrmBaixaChequesCustodia.pBuscaIni;
Begin

  If (Not fEmptyStr(frmBuscaCheques.strValorFiltro)) Then
  Begin
    strValorFiltro := frmBuscaCheques.strValorFiltro;
    strCampoFiltro := frmBuscaCheques.strCampoFiltro;

    If strCampoFiltro = 'CHQ_DTACAD' Then
      strCampoFiltro := 'CHQ_DTAVEN';

    If Not cdsCheque.FindFirst Then
    Begin
      fMensagem('ATENÇÃO!', 'Não há cheques para serem enviados para custódia!', ['&O k']);
    End;

    pSetFocus(dbgCheques);
  End;

End;

procedure TfrmBaixaChequesCustodia.pBuscaProx;
Begin

  If (Not cdsCheque.IsEmpty) And (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    If Not cdsCheque.FindNext Then
      fMensagem('ATENÇÃO!', 'Busca concluída!', ['&O k']);
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);


End;

function TfrmBaixaChequesCustodia.fDigInfoCheque   : Boolean;
Var
    blnConfirma: Boolean;
    blnExporta : Boolean;
    strCodBco: String;
    frmBaixaDigCustodia : TfrmBaixaDigCustodia;
Begin

  blnExporta := False;

  Try
    pCriarFormularios(TfrmBaixaDigCustodia, frmBaixaDigCustodia);
    frmBaixaDigCustodia.dtaDtaCad      := fMaiorDtaCad;
    If Not fEmptyStr(strPorCus) Then
    Begin
      frmBaixaDigCustodia.edtCodPor.Text := strPorCus;
      frmBaixaDigCustodia.mskDtaRep.Text := DateToStr(dtaDtaCus);
      frmBaixaDigCustodia.edtDocCus.Text := strDocCus;
    End;
    frmBaixaDigCustodia.ShowModal;

    blnConfirma := frmBaixaDigCustodia.blnConfirma;
    strPorCus   := frmBaixaDigCustodia.strPorCus;
    dtaDtaCus   := frmBaixaDigCustodia.dtaDtaCus;
    strDocCus   := frmBaixaDigCustodia.strDocCus;
    blnExporta  := frmBaixaDigCustodia.blnExporta;
    If blnExporta Then
      strCodBco := frmBaixaDigCustodia.strCodBco;
  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmBaixaChequesCustodia.fDigInfoCheque]');
    End;
  End;

  pFreeAndNil(frmBaixaDigCustodia);

  If blnConfirma Then
  Begin

    If fMensagem('', 'Confirma custódia dos cheques selecionados?', ['&Sim', '&Não']) <> 1 Then
    Begin
      blnConfirma := False;
    End;

  End;

  If blnConfirma And (blnExporta) Then
  Begin
    cdsCheque.DisableControls;
    Try
      blnConfirma := fExportaTXT(strCodBco);
    Finally
      cdsCheque.EnableControls;
    End;
  End
  Else
    strNumLot := '';

  Result := blnConfirma;

End;

Procedure TfrmBaixaChequesCustodia.pRealizaDepositoDeCheques();
 Var
     blnTemAcesso : Boolean;
Begin

  If fCfgSis('ACUDEP', varBoolean) Then
  Begin

     blnTemAcesso := fVerificaAcessoSistema('frmBaixaCheques');

     If blnTemAcesso Then
     Begin
        If fDigInfoBaixaDeposito Then
           fMensagem('ATENÇÃO!', 'Depósito de cheques concluídos com sucesso!', ['&Ok']);
     End
     Else
        fMensagem('ATENÇÃO!', 'Usuário sem acesso á rotina de depósito de cheques !', ['&Ok']);

  End;

End;

function TfrmBaixaChequesCustodia.fDigInfoBaixaDeposito : Boolean;
var
 Key: Char;
 frmBaixaAnalitica : TfrmBaixaAnalitica;
 strCodEmpresas: TStringList;
 strEmpSemAcesso: String;
Begin

  {*****************************************}
  {* PEDE PORTADOR E CENTRO DE CUSTO       *}
  {**************************************MV*}

  Try
    Application.ProcessMessages;
    pCriarFormularios(TfrmBaixaAnalitica, frmBaixaAnalitica);

    frmBaixaAnalitica.blnVemBxCh   := False;
    frmBaixaAnalitica.AMostrarDescontoAntecipacao := False;

    if strPorCus <> '' then
    begin
      frmBaixaAnalitica.edtPorBai.Text := strPorCus;
      Key := #13;
      frmBaixaAnalitica.edtPorBaiKeyPress(nil, Key);
      frmBaixaAnalitica.edtPorBai.Enabled := False;
    end;

    frmBaixaAnalitica.blnChecaPortador            := True;
    frmBaixaAnalitica.AMostrarDescontoAntecipacao := True;
    frmBaixaAnalitica.edtValorTotalCheques.Text   := edtTotalSelecionado.Text;
    frmBaixaAnalitica.AValorTaxa                  := 0;
    frmBaixaAnalitica.ShowModal;

    strCtaBai     := frmBaixaAnalitica.strCtaBai;
    strPorBai     := frmBaixaAnalitica.strPorBai;
    strNomPorBai  := frmBaixaAnalitica.strNomPorBai;
    strCtaDeb     := frmBaixaAnalitica.strCtaDeb;
    strPorDeb     := frmBaixaAnalitica.strPorDeb;

    if frmBaixaAnalitica.AValorTaxa > 0 then
    begin
      AValorTaxaDescAntec     := frmBaixaAnalitica.AValorTaxa;
      AValorTarifaDescAntec   := frmBaixaAnalitica.AValorTarifaAntecipacao;
      APlanoContasAntecipacao := frmBaixaAnalitica.APlanoContasDescAntec;
      AFornecedorAntecipacao  := frmBaixaAnalitica.AFornecedorDescAntec;
    end;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmBaixaCheques.fBaixaCheques]');
    End;
  End;

  Result := frmBaixaAnalitica.blnConfirma;

  If Result Then
  Begin

    cdsChequesDeposito := TUniClientDataSet.Create(Self);
    pCloneDataSet(cdsChequesDeposito, cdsCheque);

    cdsChequesDeposito.Filtered := False;
    cdsChequesDeposito.Filter   := 'CHQ_MARDES = ''M''';
    cdsChequesDeposito.Filtered := True;

    strCodEmpresas := fDatasetDistinctField(cdsChequesDeposito, 'CHQ_CODEMP');

    If Not fEmptyStr(strPorBai) Then
    Begin
      If Not fEmpresasTemAcessoPortador(strPorBai, strCodEmpresas, strEmpSemAcesso) Then
      Begin
        fMensagem('ATENÇÃO!', Format('Empresa(s) sem acesso ao cadastro do [Portador Crédito] informado (%s): %s. Operação abortada!', [strPorBai, strEmpSemAcesso]), ['&OK']);
        strCodEmpresas.Free;
        Exit(False);
      End;
    End;

    If Not fEmptyStr(strPorDeb) Then
    Begin
      If Not fEmpresasTemAcessoPortador(strPorDeb, strCodEmpresas, strEmpSemAcesso) Then
      Begin
        fMensagem('ATENÇÃO!', Format('Empresa(s) sem acesso ao cadastro do [Portador Débito] informado (%s): %s. Operação abortada!', [strPorDeb, strEmpSemAcesso]), ['&OK']);
        strCodEmpresas.Free;
        Exit(False);
      End;
    End;

    pCriarFormularios(TfrmGravando,frmGravando);
    frmGravando.fExecutarAcao := fBaixaCheques;
    frmGravando.lblGravando.Caption := 'Aguarde... Realizando o Depósito do(s) Cheque(s).';
    frmGravando.ShowModal;
    pFreeAndNil(frmGravando);

    strCodEmpresas.Free;
  End;

  pFreeAndNil(frmBaixaAnalitica);

End;

// Deposito
function TfrmBaixaChequesCustodia.fBaixaCheques(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    blnBaiAna     : Boolean;
    fltValMovBan  : Double;
    strSeqLan     : String;
    strHisBai     : String;
    strPortador   : String;
    strPortadorDeb: String;
    arrBaixas     : Array Of TBaixaCheque;
    strSeqDep     : String;
    repCadChq     : TCadChqRepository;
    lstBanChq     : TBanChqRepository;
    fltValorBaixa : Double;
    strCodPorFix  : String;
    strCtaDep : String;
    dtaDtaDeposito : TDateTime;
begin

  fltValorBaixa :=  0;
  strCodPorFix  := '';

  fltValMovBan := 0.0;
  SetLength(arrBaixas, 0);

  dtaDtaDeposito := dtaDtaCus; // Grava a mesma data da custodia informada;

  strSeqDep := '';

  blnBaiAna := (fCfgSis('CHQ_AS') = 'A');

  Application.ProcessMessages;
  With cdsChequesDeposito Do
  Begin
    {*************************************************}
    {* ALTERANDO A ORDEM DO CLIENTDATASET PARA BAIXA *}
    {**********************************************AN*}
    IndexFieldNames := 'CHQ_MARDES';

    First;
    DisableControls;
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := RecordCount;

    fStartTransaction;

    Try

      lstBanChq := TBanChqRepository.Create;
      repCadChq := TCadChqRepository.Create;

      While Not Eof Do
      Begin
        pStep(pgbStatus);

        {*****************************************}
        {* CASO NÃO ESTEJA MARCADA, NÃO FAZ NADA *}
        {**************************************MV*}
        If (FieldByName('CHQ_MARDES').AsString = 'M') Then
        Begin

          {********************************************}
          {* BAIXA ANALITICA: 1 MOVBAN P/ CADA CHEQUE *}
          {*****************************************MV*}
          If blnBaiAna Then
          Begin

            strHisBai := 'DEPOSITO CHEQUE No. ' + FieldByName('CHQ_NUMCHQ').AsString;

            strPortador := strPorBai;

            lstBanChq.pClear;
            lstBanChq.fAdd(FieldByName('CHQ_CODBCO').AsString,
                           FieldByName('CHQ_NUMAGE').AsString,
                           FieldByName('CHQ_CONCOR').AsString,
                           FieldByName('CHQ_NUMCHQ').AsString,
                           FieldByName('CHQ_CODCLI').AsString,
                           FieldByName('CHQ_NOMEMI').AsString,
                           FieldByName('CHQ_HIST01').AsString,
                           FieldByName('CHQ_HIST02').AsString,
                           FieldByName('CHQ_CODEMP').AsString,
                           '',
                           FieldByName('CHQ_VALCHQ').AsFloat);

            strSeqLan := fGravaMovBan(strCtaBai,                            // Centro de Custo
                                      strPortador,                          // Portador da Baixa
                                      strLoginUsuarioLogado,                // Operador da Baixa
                                      dtaDtaDeposito,                       // Data do Lançamento
                                      fTime(),                              // Hora do Lançamento
                                      FieldByName('CHQ_NUMCHQ').AsString,   // Numero do Documento
                                      'C',                                  // Credito / Debito
                                      VS_strCodEmp,                         // Empresa da Baixa
                                      FieldByName('CHQ_VALCHQ').AsFloat,    // Valor Do Lançamento
                                      strHisBai,                            // Histórico 1
                                      '',                                   // Histórico 2
                                      '',                                   // Cliente da Duplicata
                                      '',                                   // Fornecedor da Duplicata
                                      FieldByName('CHQ_NUMCHQ').AsString,   // Número da Duplicata
                                      0,                                    // Sequencial de Baixa
                                      '',                                   // Parcela da Duplicata
                                      '',                                   // Empresa da Duplicata
                                      '',                                   // Série
                                      //'',                                 // Sequencial de Lançamento
                                      '',                                   // Código do Evento
                                      '',                                   // Documento da Baixa
                                      lstBanChq.fGetList                    // Log Bancário
                                     );

            If fEmptyStr(strSeqLan) Then
            Begin
              Break;
            End;

            if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
            begin
               SetLength(arrSeqLan, Length(arrSeqLan) + 1);
               arrSeqLan[Length(arrSeqLan)-1] := strSeqLan;
            end;

            {**********************************************}
            {* CASO ESTEJA DIGITADO A OPÇÃO DE DÉBITO     *}
            {* GRAVA UM MOVBAN TIPO "D" PARA CADA CHEQUE  *}
            {*******************************************LU*}
            If (Not fEmptyStr(strPorDeb)) Then
            Begin
                strPortadorDeb := strPorDeb;

                lstBanChq.pClear;
                lstBanChq.fAdd(FieldByName('CHQ_CODBCO').AsString,
                               FieldByName('CHQ_NUMAGE').AsString,
                               FieldByName('CHQ_CONCOR').AsString,
                               FieldByName('CHQ_NUMCHQ').AsString,
                               FieldByName('CHQ_CODCLI').AsString,
                               FieldByName('CHQ_NOMEMI').AsString,
                               FieldByName('CHQ_HIST01').AsString,
                               FieldByName('CHQ_HIST02').AsString,
                               FieldByName('CHQ_CODEMP').AsString,
                               '',
                               FieldByName('CHQ_VALCHQ').AsFloat);

                strSeqLan := fGravaMovBan(strCtaDeb,                            // Centro de Custo
                                          strPortadorDeb,                       // Portador do débito
                                          strLoginUsuarioLogado,                // Operador da Baixa
                                          dtaDtaDeposito,                       // Data do Lançamento
                                          fTime(),                              // Hora do Lançamento
                                          FieldByName('CHQ_NUMCHQ').AsString,   // Numero do Documento
                                          'D',                                  // Credito / Debito
                                          VS_strCodEmp,                         // Empresa da Baixa
                                          FieldByName('CHQ_VALCHQ').AsFloat,    // Valor Do Lançamento
                                          strHisBai,                            // Histórico 1
                                          '',                                   // Histórico 2
                                          '',                                   // Cliente da Duplicata
                                          '',                                   // Fornecedor da Duplicata
                                          FieldByName('CHQ_NUMCHQ').AsString,   // Número da Duplicata
                                          0,                                    // Sequencial de Baixa
                                          '',                                   // Parcela da Duplicata
                                          '',                                   // Empresa da Duplicata
                                          '',                                   // Série
                                          //'',                                 // Sequencial de Lançamento
                                          '',                                   // Código do Evento
                                          '',                                   // Documento da Baixa
                                          lstBanChq.fGetList                    // Log Bancário
                                         );

                If fEmptyStr(strSeqLan) Then
                Begin
                  Break;
                End;

              End;

          End
          Else
          Begin
              {********************************************}
              {TOTALIZA PARA GRAVAR SINTÉTICO              }
              {********************************************}
              fltValMovBan := fltValMovBan + FieldByName('CHQ_VALCHQ').AsFloat;
          End;

          If (Not blnBaiAna) Then
          Begin
            strPortador    := strPorBai;
            strPortadorDeb := strPorDeb;
          End;

          {*******************************************}
          {* FORMATA HISTÓRICO DO CHEQUE             *}
          {****************************************AC*}
          pVerificaHistoricoCheque(FieldbyName('CHQ_HISTOR').AsString,
                                   DateToStr(FieldbyName('CHQ_DTAVEN').AsDateTime),
                                   DateToStr(dtaDtaDeposito),
                                   strCtaDep,
                                   strPorBai+'-'+strNomPorBai);

          pDepositaCheque(FieldByName('CHQ_CODBCO').AsString,
                          FieldByName('CHQ_NUMAGE').AsString,
                          FieldByName('CHQ_CONCOR').AsString,
                          FieldByName('CHQ_NUMCHQ').AsString,
                          FieldByName('CHQ_CODEMP').AsString,
                          FieldByName('CHQ_CTADEP').AsString,
                          dtaDtaDeposito,
                          strSeqLan,
                          strPorBai,
                          strCtaBai,
                          strHistorChq,
                          strPorDeb,
                          strCtaDeb,
                          0,
                          strSeqDep,
                          '',
                          '',
                          IIF(AValorTaxaDescAntec > 0, AValorTaxaDescAntec, 0));

          {*************************************}
          {* INSERE OS VALORES NO ARRAY DO LOG *}
          {**********************************JU*}
          repCadChq.pGravaLog(FieldByName('CHQ_CODBCO').AsString, FieldByName('CHQ_NUMAGE').AsString,
                              FieldByName('CHQ_CONCOR').AsString, FieldByName('CHQ_NUMCHQ').AsString,
                              'BAIXA (frmBaixaChequesCustodia.fBaixaCheques)');

          fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);
        End;

        Next;
      End;

      FreeAndNil(repCadChq);

      If Not blnBaiAna Then
      Begin

         {*****************************************}
         {* GRAVA O MOVBAN SINTETIZADO POR DATA   *}
         {* DATA UNICA NO CASO                    *}
         {**************************************MV*}
          strPortador := strPorBai;

          strSeqLan := fGravaMovBan(strCtaBai,                        // Centro de Custo
                                    strPortador,                      // Portador da Baixa
                                    strLoginUsuarioLogado,            // Operador da Baixa
                                    dtaDtaDeposito,                   // Data do Lançamento
                                    fTime(),                          // Hora do Lançamento
                                    'CHQ.DIVER.',                     // Numero do Documento
                                    'C',                              // Credito / Debito
                                    VS_strCodEmp,                     // Empresa da Baixa
                                    fltValMovBan,                     // Valor Do Lançamento
                                    'DEP. CHEQUES DIVERSOS',          // Histórico 1
                                    '',                               // Histórico 2
                                    '',                               // Cliente da Duplicata
                                    '',                               // Fornecedor da Duplicata
                                    '',                               // Número da Duplicata
                                    0,                                // Sequencial de Baixa
                                    '',                               // Parcela da Duplicata
                                    '',                               // Empresa da Duplicata
                                    '',                               // Série
                                    '',                               // Código do Evento
                                    '',                               // Documento da Baixa
                                    lstBanChq.fGetList                // Log Bancário
                                   );

          {**********************************************}
          {* CASO ESTEJA DIGITADO A OPÇÃO DE DÉBITO     *}
          {* GRAVA UM MOVBAN TIPO "D"                   *}
          {*******************************************LU*}
          If (Not fEmptyStr(strPorDeb)) Then
          Begin
            strPortadorDeb := strPorDeb;

            strSeqLan := fGravaMovBan(strCtaDeb,                        // Centro de Custo
                                      strPortadorDeb,                   // Portador do Débito
                                      strLoginUsuarioLogado,            // Operador da Baixa
                                      dtaDtaDeposito,                   // Data do Lançamento
                                      fTime(),                          // Hora do Lançamento
                                      'CHQ.DIVER.',                     // Numero do Documento
                                      'D',                              // Credito / Debito
                                      VS_strCodEmp,                     // Empresa da Baixa
                                      fltValMovBan,                     // Valor Do Lançamento
                                      'DEP. CHEQUES DIVERSOS',          // Histórico 1
                                      '',                               // Histórico 2
                                      '',                               // Cliente da Duplicata
                                      '',                               // Fornecedor da Duplicata
                                      '',                               // Número da Duplicata
                                      0,                                // Sequencial de Baixa
                                      '',                               // Parcela da Duplicata
                                      '',                               // Empresa da Duplicata
                                      '',                               // Série
                                      '',                               // Código do Evento
                                      '',                               // Documento da Baixa
                                      lstBanChq.fGetList                // Log Bancário
                                     );

          End;

      End;

      fCommit;
      Result := True;

      //NÃO RETIRAR
      cdsCheque.EnableControls;
      cdsCheque.EmptyDataSet;

      fMensagem('ATENÇÃO!', 'Sequencial de fechamento: ' + strSeqDep, ['&Ok']);

    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        If Pos('AUT001 - ', E.Message) = 0 Then
          pMensagensErro(E.Message, '[fBaixaCheques]')
        Else
          pMensagemOK(StringReplace(E.Message, 'AUT001 - ', EmptyStr, [rfReplaceAll]));
      End;
    End;

    FreeAndNil(lstBanChq);

    IndexFieldNames := '';
  End;

  cdsCheque.EnableControls;

end;

procedure TfrmBaixaChequesCustodia.pVerificaHistoricoCheque(strHistorico, strDtaVenc, strDtaDep, strContaDep, strPortador: String);
  Var
    strFormata: String;
    strValores: String;
begin

  strValores := '';
  strValores := ' ' + fPadR(strDtaVenc,18,' ');
  strValores := strValores + fPadR(strDtaDep,16,' ');
  strValores := strValores + fPadR(strContaDep,17,' ');
  strValores := strValores + fPadR(strPortador,31,' ');

  If (strHistorico = '') Then
  Begin
    strFormata := ' Data Vencimento   Data Depósito   Conta Depósito   Portador Crédito '+#13#10;
    strFormata := strFormata + ' ---------------   -------------   --------------   ---------------- '+#13#10;
    strFormata := strFormata + strValores;
  End
  Else
  Begin
    strFormata := strHistorico+#13#10;
    strFormata := strFormata + strValores;
  End;

  strHistorChq := strFormata;
  strFormata   := '';
  strValores   := '';

end;

end.

