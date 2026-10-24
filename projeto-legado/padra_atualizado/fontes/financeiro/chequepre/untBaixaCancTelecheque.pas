unit untBaixaCancTelecheque;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, UniClientDataSet,
  StdCtrls, EditFocus, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid, Mask,
  MaskEditFocus, AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls, Uni,
  UniDataSetProvider, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  cxContainer, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, cxProgressBar, Datasnap.DBClient,untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog, untBuscaCheques;

type
  TfrmBaixaCancTelecheque = class(TfrmPaiSimples)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    pnlCabecalho: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    pnlAux2: TPanel;
    grdCheques: TcxGrid;
    grdChequesDados: TcxGridDBTableView;
    grdChequesCHQ_CODBCO: TcxGridDBColumn;
    grdChequesCHQ_NUMCHQ: TcxGridDBColumn;
    grdChequesCHQ_CODEMP: TcxGridDBColumn;
    grdChequesCHQ_DTAVEN: TcxGridDBColumn;
    grdChequesCHQ_VALCHQ: TcxGridDBColumn;
    grdChequesCHQ_TELNUM: TcxGridDBColumn;
    grdChequesCHQ_MARDES: TcxGridDBColumn;
    grdChequesNivel: TcxGridLevel;
    pnlAux1: TPanel;
    pnlDadosDup: TPanel;
    Label6: TLabel;
    Nome: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Label13: TLabel;
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
    pnlInformativos: TPanel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    edtChqSelecionados: TEditFocus;
    edtTotalSelecionado: TEditFocus;
    pnlBotoesBaixa: TPanel;
    dtsTemp: TDataSource;
    cdsTotais: TUniClientDataSet;
    lbl1: TLabel;
    BitBtn1: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmTodos: TBitBtnLocked;
    mskVenIni: TcxDateEdit;
    mskVenFin: TcxDateEdit;
    Label5: TLabel;
    mskDevFin: TcxDateEdit;
    mskEnvFin: TcxDateEdit;
    mskDevIni: TcxDateEdit;
    mskEnvIni: TcxDateEdit;
    btnCarrCheques: TBitBtnLocked;
    btnIniBus: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    pnlTotais: TPanel;
    Label23: TLabel;
    label9: TLabel;
    edtValorTotal: TEditFocus;
    edtTotalCheques: TEditFocus;
    FlwPnlBotoesBaixa: TFlowPanel;
    btnSairBaixa: TBitBtnLocked;
    procedure btnSairBaixaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure grdChequesDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdChequesDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnDesmTodosClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnCarrChequesClick(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    frmBuscaCheques : TfrmBuscaCheques;
    strValorFiltro: String;
    strCampoFiltro: String;
    intSelec      : Integer;
    fltSelec      : Double;
    strCodTel     : String;
    strCodPor     : String;
    dtaDtaEnv     : TDateTime;
    strTabCad     : String;
    strTabTel     : String;
    strTabCtr     : String;
    strSeqTel     : String;

    qryTemp: TUniQuery;
    cpvTemp: TUniDataSetProvider;
    cdsTemp: TUniClientDataSet;

    procedure pLimpaDados;
    procedure pCriaTemporaria;
    procedure pSelecionaCheque;
    procedure pAtualizaTemporaria;
    procedure pCalculaValores(blnFiltro: Boolean);
    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    procedure pMarcaCheque(blnMarcar: Boolean; blnAtuGrid: Boolean = True);
    procedure pGravaCancelamento(strSeqChq, strPorOri, strCodEmp, strNumDup: String);
    function fCancelaTelecheque(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fDesmarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pStep(pgbStatus: TcxProgressBar);
    procedure pBuscaIni;
    procedure pBuscaProx;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, Variants, Graphics, StrUtils, untFuncoesGenerica, untFuncoesSimples,
     untCadChq, untTCadChqRepository, untGravando;

{$R *.dfm}

procedure TfrmBaixaCancTelecheque.btnCarrChequesClick(Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(mskVenIni, False) And
     Not fValidaCampos(mskVenFin, False)  Or
     Not fValidaCampos (mskVenIni, False) Or
     Not fValidaCampos (mskVenFin, False) Then
     Exit;

  If Not fValidaCampos(mskDevIni, False) And
     Not fValidaCampos(mskDevFin, False)  Or
     Not fValidaCampos (mskDevIni, False) Or
     Not fValidaCampos (mskDevFin, False) Then
     Exit;

  If Not fValidaCampos(mskEnvIni, False) And
     Not fValidaCampos(mskEnvFin, False)  Or
     Not fValidaCampos (mskEnvIni, False) Or
     Not fValidaCampos (mskEnvFin, False) Then
     Exit;

  pCriaTemporaria;
  TfrmGravando.fExecutarModal(pAtualizaTemporaria,'Aguarde... Carregando Cheques.','');
  pCalculaValores(False);

end;

procedure TfrmBaixaCancTelecheque.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (Not fEmptyStr(edtTotalSelecionado.Text))  And
     (fStrToFloat(edtTotalSelecionado.Text) > 0) Then
  Begin
     If (fMensagem('', 'Confirma cancelamento dos cheques selecionados?', ['&Sim', '&Não']) = 1) Then
     Begin
      pCriarFormularios(TfrmGravando,frmGravando);
      frmGravando.fExecutarAcao := fCancelaTelecheque;
      frmGravando.lblGravando.Caption := 'Aguarde... Cancelando Envio para Telecheque.';
      frmGravando.ShowModal;
      pFreeAndNil(frmGravando);
      pCriaTemporaria;
      If (cdsTemp.RecordCount > 0) Then
      Begin
        pAtualizaDados(Nil);
        pCalculaValores(False);
        cdsTemp.EnableControls;
      End
      Else
        pLimpaDados;
     End;
    pSetFocus(Self);
  End
  Else Begin
    fMensagem('', 'É necessário selecionar ao menos um registro!', ['&Ok']);
    Exit;
  End;
end;

procedure TfrmBaixaCancTelecheque.btnDesmTodosClick(Sender: TObject);
begin
  inherited;

  If (Not cdsTemp.Active) Or (edtChqSelecionados.Text = '0') Then
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

procedure TfrmBaixaCancTelecheque.btnIniBusClick(Sender: TObject);
begin
  inherited;

 If (Not cdsTemp.Active) Or (cdsTemp.IsEmpty) Then
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
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmBuscaCheques);


end;

procedure TfrmBaixaCancTelecheque.btnLocProxClick(Sender: TObject);
begin
  inherited;

  If cdsTemp.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um cheque!', ['&Ok']);
    Exit;
  End;
  TfrmGravando.fExecutarModal(pBuscaProx,'Aguarde... Localizando Cheque.','');
end;

procedure TfrmBaixaCancTelecheque.btnMarcarTodosClick(Sender: TObject);
begin
  inherited;

  If cdsTemp.IsEmpty Then
  Begin
    fMensagem('','É necessário ter registros para marcar!',['&O K']);
    Exit;
  End;

  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fMarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Marcando Cheques.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
end;

procedure TfrmBaixaCancTelecheque.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

function TfrmBaixaCancTelecheque.fCancelaTelecheque(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    repCadChq: TCadChqRepository;
begin
  Application.ProcessMessages;
  fStartTransaction;
  Try
    With cdsTemp Do
    Begin
      First;
      repCadChq := TCadChqRepository.Create;
      pgbStatus.Position := 0;
      pgbStatus.Properties.Max := RecordCount;
      DisableControls;
      While Not Eof Do
      Begin
        pStep(pgbStatus);
        strSeqTel := FieldByName('CHQ_SEQTEL').AsString;
        If (FieldByName('CHQ_MARDES').AsString = 'M') Then
        Begin
          pGravaCancelamento(FieldByName('AUTOINCREM').AsString,
                             FieldByName('CHQ_PORORI').AsString,
                             FieldByName('CHQ_CODEMP').AsString,
                             FieldByName('CHQ_DUPDEV').AsString);

          fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);
          {********************}
          {* GRAVAR NO LOGCHQ *}
          {*****************JU*}
          repCadChq.pGravaLog(FieldByName('CHQ_CODBCO').AsString, FieldByName('CHQ_NUMAGE').AsString,
                              FieldByName('CHQ_CONCOR').AsString, FieldByName('CHQ_NUMCHQ').AsString,
                              'CANCELANEMTO TELECHEQUE(frmBaixaCancTelecheque.fCancelaTelecheque)');
        End;

        Next;
      End;

    End;
    Result := True;
    fCommit;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '');
    End;
  End;
  FreeAndNil(repCadChq);
end;

procedure TfrmBaixaCancTelecheque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Action <> caNone) Then
  Begin
    FreeAndNil(cdsTemp);
  End;
end;

procedure TfrmBaixaCancTelecheque.FormCreate(Sender: TObject);
begin
  inherited;
  qryTemp         := fCriaQuery(Self);
  cdsTemp         := TUniClientDataSet.Create(Self);
  cpvTemp         := TUniDataSetProvider.Create(Self);
  cpvTemp.DataSet := qryTemp;
  dtsTemp.DataSet := cdsTemp;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'CHQ_TOTCHQ';
    FieldName     := 'CHQ_TOTCHQ';
    DataSet       := cdsTotais;
    Expression    := 'SUM(CHQ_VALCHQ)';
    DisplayFormat := '#,##0.00';
    Active        := True;
  End;

  strTabCad     := 'CADCHQ';
  strTabCtr     := 'CADREC';
  strTabTel     := 'CHQTEL';
  strNomeTabela := 'CHQTEL';

  intSelec  := 0;
  fltSelec  := 0;
  dtaDtaEnv := Date;
  strCodTel := '';
  strCodPor := fCfgSis('PORTEL');

  cdsTemp.AfterScroll    := pAtualizaDados;
  cdsTemp.OnFilterRecord := pFilterRecord;
end;

procedure TfrmBaixaCancTelecheque.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End

  Else If (Key = VK_F7) Then
  Begin
    btnMarcarTodos.Click;
  End

  Else If (Key = VK_F5) Then
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
  End;
end;

function TfrmBaixaCancTelecheque.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {*****************************************}
    {* VALIDAÇÃO DATA VENCIMENTO             *}
    {**************************************LE*}

    If (Sender = mskVenFin) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskVenFin.Text))) And (StrToDateDef(mskVenFin.Text,0) <=0) Then
      Begin
        fMensagem('', 'A Data Final informada é inválida! Necessário correção.', ['&O k']);;
        Result := False;
      End
      Else
      If (Not fEmptyStr(fTiraCaracEspeciais(mskVenFin.Text))) And (fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&Ok']);
        Result := False;
        Sender := mskVenIni;
      End
      Else
      If (Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text))) And (fEmptyStr(fTiraCaracEspeciais(mskVenFin.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&Ok']);
        Result := False;
        Sender := mskVenFin;
      End
      Else
      If (Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskVenFin.Text))) Then
      Begin
        If StrToDate(mskVenIni.Text) > StrToDate(mskVenFin.Text) Then
        Begin
          fMensagem('','A data Inicial deve ser menor que a data final!',['&O K']);
          Result := False;
          Sender := mskVenIni;
        End;
      End;
    End
    Else
    If (Sender = mskVenIni) THEN
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text))) And (StrToDateDef(mskVenIni.Text,0)<=0) Then
      Begin
        fMensagem('', 'A Data Inicial informada é inválida! Necessário correção.', ['&O k']);;
        Result := False;
        Sender := mskVenIni;
      End;
    End

    {*****************************************}
    {* VALIDAÇÃO DATA DEVOLUÇÃO              *}
    {**************************************LE*}
    Else
    If (Sender = mskDevFin) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDevFin.Text))) And (StrToDateDef(mskDevFin.Text,0) <=0) Then
      Begin
        fMensagem('', 'A Data Final informada é inválida! Necessário correção.', ['&O k']);;
        Result := False;
      End
      Else
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDevFin.Text))) And (fEmptyStr(fTiraCaracEspeciais(mskDevIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&Ok']);
        Result := False;
        Sender := mskDevIni;
      End
      Else
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDevIni.Text))) And (fEmptyStr(fTiraCaracEspeciais(mskDevFin.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&Ok']);
        Result := False;
        Sender := mskDevFin;
      End
      Else
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDevIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDevFin.Text))) Then
      Begin
        If StrToDate(mskDevIni.Text) > StrToDate(mskDevFin.Text) Then
        Begin
          fMensagem('','A data Inicial deve ser menor que a data final!',['&O K']);
          Result := False;
          Sender := mskVenIni;
        End;
      End;
    End
    Else
    If (Sender = mskDevIni) THEN
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDevIni.Text))) And (StrToDateDef(mskDevIni.Text,0)<=0) Then
      Begin
        fMensagem('', 'A Data Inicial informada é inválida! Necessário correção.', ['&O k']);;
        Result := False;
        Sender := mskVenIni;
      End;
    End
    {*****************************************}
    {* VALIDAÇÃO DATA DE ENVIO               *}
    {**************************************LE*}
    Else
    If (Sender = mskEnvFin) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskEnvFin.Text))) And (StrToDateDef(mskEnvFin.Text,0) <=0) Then
      Begin
        fMensagem('', 'A Data Final informada é inválida! Necessário correção.', ['&O k']);;
        Result := False;
      End
      Else
      If (Not fEmptyStr(fTiraCaracEspeciais(mskEnvFin.Text))) And (fEmptyStr(fTiraCaracEspeciais(mskEnvIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&Ok']);
        Result := False;
        Sender := mskEnvIni;
      End
      Else
      If (Not fEmptyStr(fTiraCaracEspeciais(mskEnvIni.Text))) And (fEmptyStr(fTiraCaracEspeciais(mskEnvFin.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&Ok']);
        Result := False;
        Sender := mskVenFin;
      End
      Else
      If (Not fEmptyStr(fTiraCaracEspeciais(mskEnvIni.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskEnvFin.Text))) Then
      Begin
        If StrToDate(mskEnvIni.Text) > StrToDate(mskEnvFin.Text) Then
        Begin
          fMensagem('','A data Inicial deve ser menor que a data final!',['&O K']);
          Result := False;
          Sender := mskEnvIni;
        End;
      End;
    End
    Else
    If (Sender = mskEnvIni) THEN
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskEnvIni.Text))) And (StrToDateDef(mskEnvIni.Text,0)<=0) Then
      Begin
      fMensagem('', 'A Data Inicial informada é inválida! Necessário correção.', ['&O k']);;
        Result := False;
        Sender := mskEnvIni;
      End;
    End;

  End;
  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaCancTelecheque.grdChequesDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strMarDes: String;
begin
  inherited;
  strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdChequesCHQ_MARDES.Index]);

  If (strMarDes = 'M') Then
    If Not AViewInfo.Selected Then
      ACanvas.Font.Color := clBlue;
end;

procedure TfrmBaixaCancTelecheque.grdChequesDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    pSelecionaCheque;
    pSetFocus(grdCheques);
    grdChequesDados.NavigatorButtons.Next.Click;
  End

  Else If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(mskVenIni);
  End;

end;

procedure TfrmBaixaCancTelecheque.pAtualizaDados(DataSet: TDataSet);
begin
  If cdsTemp.ControlsDisabled = False Then
  Begin
    edtCodBco.Text := cdsTemp.FieldByName('CHQ_CODBCO').AsString;
    edtNomBco.Text := cdsTemp.FieldByName('CHQ_NOMBCO').AsString;
    edtNumAge.Text := cdsTemp.FieldByName('CHQ_NUMAGE').AsString;
    edtConCor.Text := cdsTemp.FieldByName('CHQ_CONCOR').AsString;
    edtNumChq.Text := cdsTemp.FieldByName('CHQ_NUMCHQ').AsString;
    edtNomEmi.Text := cdsTemp.FieldByName('CHQ_NOMEMI').AsString;
    edtEndere.Text := cdsTemp.FieldByName('CHQ_ENDERE').AsString;
    edtFone01.Text := fFormataFone(cdsTemp.FieldByName('CHQ_TELEMI').AsString);
    edtNumNot.Text := cdsTemp.FieldByName('CHQ_NUMNOT').AsString;
    edtDtaVen.Text := cdsTemp.FieldByName('CHQ_DTAVEN').AsString;
    edtValChq.Text := FormatFloat('#,##0.00', cdsTemp.FieldByName('CHQ_VALCHQ').AsFloat);
  End;
end;

procedure TfrmBaixaCancTelecheque.pAtualizaTemporaria;
begin
  With cdsTemp Do
  Begin
    (FieldByName('CHQ_VALCHQ') As TFloatField).DisplayFormat := '#,##0.00';
    First;
    If IsEmpty Then
    Begin
      fMensagem('', 'Não há cheques a serem cancelados!', ['&O k']);
      pSetFocus(mskVenIni);
      blnMudarFoco := False;
    End
    Else
      pSetFocus(grdCheques);
  End;
end;

procedure TfrmBaixaCancTelecheque.pCalculaValores(blnFiltro: Boolean);
begin

  cdsTotais.Data     := cdsTemp.Data;

  If (blnFiltro) And (Not cdsTotais.IsEmpty) Then
  Begin
    cdsTotais.Filtered := True;
    edtTotalSelecionado.Text := FormatFloat('#,##0.00', TAggregateField(cdsTotais.FieldByName('CHQ_TOTCHQ')).Value);
    edtChqSelecionados.Text := IntToStr(cdsTotais.RecordCount);
  End
  Else
  Begin
    edtTotalSelecionado.Text := '0,00';
    edtChqSelecionados.Text := '0';
  End;

  If Not cdsTemp.IsEmpty And Not blnFiltro Then
  Begin
    cdsTotais.Filtered :=  False;
    edtValorTotal.Text := FormatFloat('#,##0.00', TAggregateField(cdsTotais.FieldByName('CHQ_TOTCHQ')).Value);
    edtTotalCheques.Text := IntToStr(cdsTemp.RecordCount);
  End;

end;

procedure TfrmBaixaCancTelecheque.pCriaTemporaria;
  Var
    strSQL: String;
begin
  cdsTemp.Close;
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  Q.AUTOINCREM, ';
  strSQL := strSQL + '  Q.CHQ_CODBCO, ';
  strSQL := strSQL + '  Q.CHQ_NUMAGE, ';
  strSQL := strSQL + '  B.BCO_NOMBCO AS CHQ_NOMBCO, ';
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
  strSQL := strSQL + '  Q.CHQ_DTADEP, ';
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
  strSQL := strSQL + '  LEFT(Q.CHQ_DUPDEV, 12) AS CHQ_DUPDEV, ';
  strSQL := strSQL + '  CAST(IF(Q.CHQ_DTADP2 IS NULL, Q.CHQ_DTADEP, Q.CHQ_DTADP2) AS DATE) AS CHQ_DTADEP, ';
  strSQL := strSQL + '  T.CHQ_SEQTEL, ';
  strSQL := strSQL + '  T.CHQ_PORORI, ';
  strSQL := strSQL + '  T.CHQ_DTAENV, ';
  strSQL := strSQL + '  T.CHQ_DOCUME, ';
  strSQL := strSQL + '  "D" AS CHQ_MARDES ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCHQ Q ';
  strSQL := strSQL + '  JOIN CADBCO       B ON Q.CHQ_CODBCO = B.BCO_CODBCO ';
  strSQL := strSQL + '  INNER JOIN CHQTEL T ON Q.AUTOINCREM = T.CHQ_SEQCHQ ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  T.CHQ_DTAENV IS NOT NULL    AND ';
  strSQL := strSQL + '  (Q.CHQ_DEVDEF = 1           OR  ';
  strSQL := strSQL + '  Q.CHQ_DTADV2 IS NOT NULL)   AND ';
  strSQL := strSQL + '  Q.CHQ_INCCTR = "S"          AND ';
  strSQL := strSQL + '  Q.CHQ_TELCHE = "S" ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
    strSQL := strSQL + '  AND Q.CHQ_DTAVEN BETWEEN :VENINI AND :VENFIN ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDevIni.Text)) Then
    strSQL := strSQL + '  AND Q.CHQ_DTADEV BETWEEN :DEVINI AND :DEVFIN ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskEnvIni.Text)) Then
    strSQL := strSQL + '  AND T.CHQ_DTAENV BETWEEN :ENVINI AND :ENVFIN ';

  strSQL := strSQL + ' ORDER BY CHQ_DTAVEN ';

  With qryTemp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
    Begin
      ParamByName('VENINI').AsDateTime := StrToDateTime(mskVenIni.Text);
      ParamByName('VENFIN').AsDateTime := StrToDateTime(mskVenFin.Text);
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDevIni.Text)) Then
    Begin
      ParamByName('DEVINI').AsDateTime := StrToDateTime(mskDevIni.Text);
      ParamByName('DEVFIN').AsDateTime := StrToDateTime(mskDevFin.Text);
    End;

    If Not fEmptyStr(fTiraCaracEspeciais(mskEnvIni.Text)) Then
    Begin
      ParamByName('ENVINI').AsDateTime := StrToDateTime(mskEnvIni.Text);
      ParamByName('ENVFIN').AsDateTime := StrToDateTime(mskEnvFin.Text);
    End;
    Open;
    pSetaClient(qryTemp);

    cdsTemp.SetProvider(cpvTemp);
    cdsTemp.Open;
  End;
end;

procedure TfrmBaixaCancTelecheque.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;

procedure TfrmBaixaCancTelecheque.pGravaCancelamento(strSeqChq, strPorOri,
  strCodEmp, strNumDup: String);
  Var
    strSQL   : String;
    qryGenChq: TUniQuery;
begin
  Try
    qryGenChq := fCriaQuery(Self);
    Try
      strSQL := '';
      strSQL := strSQL + 'DELETE FROM ';
      strSQL := strSQL + strTabTel + ' ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '    CHQ_SEQTEL = :CHQ_SEQTEL AND ';
      strSQL := strSQL + '    CHQ_SEQCHQ = :CHQ_SEQCHQ ';

      With qryGenChq Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CHQ_SEQTEL').AsString   := strSeqTel;
        ParamByName('CHQ_SEQCHQ').AsString   := strSeqChq;
        ExecSQL;
      End;

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + strTabCad + ' ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  CHQ_CODPOR = :CODPOR ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  AUTOINCREM = :INCREM ';
      With qryGenChq Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODPOR').AsString := strPorOri;
        ParamByName('INCREM').AsString := strSeqChq;
        ExecSQL;
      End;

      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + strTabCtr + ' ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  CTR_CODPOR = :CODPOR ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CTR_PARCEL = "A"     AND ';
      strSQL := strSQL + '  CTR_ESPDOC = "CH"    AND ';
      strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP ';
      With qryGenChq Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODPOR').AsString := strPorOri;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('NUMDUP').AsString := strNumDup;
        ExecSQL;
      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(qryGenChq);
  End;
end;

procedure TfrmBaixaCancTelecheque.pLimpaDados;
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

  edtChqSelecionados.Clear;
  edtTotalSelecionado.Clear;

  mskVenIni.Clear;
  mskVenFin.Clear;
  mskDevIni.Clear;
  mskDevFin.Clear;
  mskEnvIni.Clear;
  mskEnvFin.Clear;

  With cdsTemp Do
  Begin
    If Not Active Then
      Exit;
    DisableControls;
    try
    First;
    while not eof do
    begin
      If FieldByName('CHQ_MARDES').AsString = 'M' Then
      Begin
        fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);
      End;
      Next;
    end;
    active := false;
    finally
      EnableControls;
    end;
  End;


end;

procedure TfrmBaixaCancTelecheque.pMarcaCheque(blnMarcar, blnAtuGrid: Boolean);
begin
  Try
    with cdsTemp do
    begin
      If blnMarcar Then
      Begin
        If Not fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, True, False) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cheque está sendo utilizado por outra estação: ' + fGetHostLock('CADCHQ' + FieldByName('AUTOINCREM').AsString), ['&Ok']);
          Exit;
        End;
      End
      Else
        fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);

      Edit;
      FieldByName('CHQ_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
      Post;
    end;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

  If (blnAtuGrid) Then
  Begin
    pAtualizaTemporaria;
    pCalculaValores(True);
  End;
end;

procedure TfrmBaixaCancTelecheque.pSelecionaCheque;
  Var
    intRecNo: Integer;
begin
  If (Not cdsTemp.Active) Or
     (cdsTemp.IsEmpty)    Then
  Begin
    Exit;
  End;

  intRecNo := cdsTemp.RecNo;
  If (cdsTemp.FieldByName('CHQ_MARDES').AsString <> 'M') Then
  Begin
    pMarcaCheque(True);
  End
  Else
  Begin
    pMarcaCheque(False);
  End;
  cdsTemp.RecNo := intRecNo;
end;

function TfrmBaixaCancTelecheque.fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
Begin

   If cdsTemp.IsEmpty Then
  Begin
    fMensagem('', 'É necessário ter registros para a consulta!', ['&Ok']);
    Result := False;
    Exit;
  End;

  With cdsTemp Do
  Begin

    DisableControls;
    First;

    While (Not Eof) Do
    Begin
      pStep(pgbStatus);
      pMarcaCheque(True, False);
      Next;
    End;

    First;
    EnableControls;

  End;
  pAtualizaTemporaria;
  pCalculaValores(True);


  Result := True;
End;

function TfrmBaixaCancTelecheque.fDesmarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
Begin

  With cdsTemp Do
  Begin

    DisableControls;
    First;

    While (Not Eof) Do
    Begin
      pStep(pgbStatus);
      pMarcaCheque(False, False);
      Next;
    End;

    First;
    EnableControls;

  End;
  pAtualizaTemporaria;
  pCalculaValores(False);


  Result := True;
End;

procedure TfrmBaixaCancTelecheque.pStep(pgbStatus: TcxProgressBar);
Begin

 If Assigned(pgbStatus) Then
 Begin
 pgbStatus.Position := pgbStatus.Position + 1;
 Application.ProcessMessages;
 End;

End;

procedure TfrmBaixaCancTelecheque.pBuscaIni;
Begin

  If (Not fEmptyStr(frmBuscaCheques.strValorFiltro)) Then
  Begin
    strValorFiltro := frmBuscaCheques.strValorFiltro;
    strCampoFiltro := frmBuscaCheques.strCampoFiltro;
    If (strCampoFiltro = 'CHQ_DTACAD') Then
      strCampoFiltro := 'CHQ_DTAVEN';

    If Not cdsTemp.FindFirst Then
    Begin
      fMensagem('ATENÇÃO!', 'Não há cheques a serem cancelados!', ['&O k']);
    End;
  End;

End;

procedure TfrmBaixaCancTelecheque.pBuscaProx;
Begin

  If (cdsTemp.Active) And (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    If Not cdsTemp.FindNext Then
      fMensagem('ATENÇÃO!', 'Não há cheques a serem cancelados!', ['&O k']);
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);

End;

end.
