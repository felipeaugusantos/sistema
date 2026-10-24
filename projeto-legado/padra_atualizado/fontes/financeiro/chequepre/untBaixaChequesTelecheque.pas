unit untBaixaChequesTelecheque;

interface

uses
  Windows, Classes, Controls, Forms, untPaiSimples, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, ExtCtrls, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids, EditFocus,
  Uni, UniDataSetProvider, DB, UniClientDataSet, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, frxClass, cxDataStorage, cxEdit, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, untFuncoesSimples, untFuncoesGenerica, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, untTypesSistema, cxNavigator, frxExportCSVTestabilidade, cxContainer,
  dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxProgressBar, Datasnap.DBClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, untBuscaCheques;

type
  TfrmBaixaChequesTelecheque = class(TfrmPaiSimples)
    pnlCabecalho: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    pnlAux2: TPanel;
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
    grdChequesDados: TcxGridDBTableView;
    grdChequesNivel: TcxGridLevel;
    grdCheques: TcxGrid;
    grdChequesCHQ_CODBCO: TcxGridDBColumn;
    grdChequesCHQ_NUMCHQ: TcxGridDBColumn;
    grdChequesCHQ_CODEMP: TcxGridDBColumn;
    grdChequesCHQ_DTAVEN: TcxGridDBColumn;
    grdChequesCHQ_VALCHQ: TcxGridDBColumn;
    grdChequesCHQ_TELNUM: TcxGridDBColumn;
    grdChequesCHQ_MARDES: TcxGridDBColumn;
    cdsTotais: TUniClientDataSet;
    grdChequesCHQ_DTADEV: TcxGridDBColumn;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    lbl4: TLabel;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    btnMarcarTodos: TBitBtnLocked;
    btnDesmTodos: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    btnIniBus: TBitBtnLocked;
    btnCarrCheques: TBitBtnLocked;
    mskDevIni: TcxDateEdit;
    mskDevFin: TcxDateEdit;
    mskVenIni: TcxDateEdit;
    mskVenFin: TcxDateEdit;
    mskCadIni: TcxDateEdit;
    mskCadFin: TcxDateEdit;
    pnlTotais: TPanel;
    Label23: TLabel;
    label9: TLabel;
    edtValorTotal: TEditFocus;
    edtTotalCheques: TEditFocus;
    FlwPnlBotoesBaixa: TFlowPanel;
    procedure btnSairBaixaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dbgrdChequesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure grdChequesDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdChequesDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDesmTodosClick(Sender: TObject);
    procedure btnMarcarTodosClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure btnCarrChequesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    frmBuscaCheques: TfrmBuscaCheques;
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

    arrEmpresa    : TConsultasArray;
    strEmpresa    : String;
    arrPortador   : TConsultasArray;
    strPortador   : String;

    FPais: TPais;

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
    procedure pGravaTeleCheque(strSeqChq, strPorOri, strCodEmp, strNumDup: String);
    procedure pImprimeBordero;
    function  fEnviaTelecheque(pgbStatus: TcxProgressBar = Nil): Boolean;
    function  fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    function  fDesmarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pStep(pgbStatus: TcxProgressBar);
    procedure pBuscaIni;
    procedure pBuscaProx;
    function  fDigInfoBaixa : Boolean;
    procedure pDestravaCheques;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;


implementation

uses SysUtils, Variants, Graphics, StrUtils,
  untBaixaDigTelecheque, untModuloBaixaChequesTelecheque, untConsultas,
  untFuncoesConsulta, untCadChq, untTCadChqRepository,  untGravando;

{$R *.dfm}

{ TfrmBaixaChequesTelecheque }

procedure TfrmBaixaChequesTelecheque.btnCarrChequesClick(Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(mskCadIni, False) And
     Not fValidaCampos(mskCadFin, False) Or
     Not fValidaCampos(mskCadIni,False)  Or
     Not fValidaCampos(mskCadFin,False)  Then
      Exit;

  If Not fValidaCampos(mskVenIni, False) And
     Not fValidaCampos(mskVenFin, False) Or
     Not fValidaCampos(mskVenIni,False)  Or
     Not fValidaCampos(mskVenFin,False)  Then
      Exit;

  If Not fValidaCampos(mskDevIni, False) And
     Not fValidaCampos(mskDevFin, False) Or
     Not fValidaCampos(mskDevIni,False)  Or
     Not fValidaCampos(mskDevFin,False)  Then
      Exit;

  If Not fVerificaCampos Then
    Exit;

  pCriaTemporaria;
  TfrmGravando.fExecutarModal(pAtualizaTemporaria,'Aguarde... Carregando Cheques.','');
  If Not cdsTemp.IsEmpty Then
  Begin
    pCalculaValores(False);
    pSetFocus(grdCheques);
  End
  Else
    pLimpaDados ;
end;

procedure TfrmBaixaChequesTelecheque.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If (Not cdsTemp.Active) Or (edtChqSelecionados.Text = '0') Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos um registro!', ['&Ok']);
    Exit;
  End;

  If (Not fEmptyStr(edtTotalSelecionado.Text))  And
     (fStrToFloat(edtTotalSelecionado.Text) > 0) Then
  Begin

    If fDigInfoBaixa Then
    Begin
      If fMensagem('', 'Confirma envio dos cheques selecionados?', ['&Sim', '&Não']) = 1  Then
      Begin
        pCriarFormularios(TfrmGravando,frmGravando);
        frmGravando.fExecutarAcao :=  fEnviaTelecheque;
        frmGravando.lblGravando.Caption := 'Aguarde... Enviando Cheque(s) para Telecheque.';
        frmGravando.ShowModal;
        pFreeAndNil(frmGravando);

        pImprimeBordero;
        FreeAndNil(cdsTemp);
        pCriaTemporaria;
        If (cdsTemp.RecordCount > 0) Then
        Begin
          pCalculaValores(False);
          cdsTemp.EnableControls;
        End
        Else
         pLimpaDados;
      End;
    End;
    pSetFocus(grdCheques);
  End;
end;

procedure TfrmBaixaChequesTelecheque.btnDesmTodosClick(Sender: TObject);
begin
  inherited;

  If edtChqSelecionados.Text = '0' Then
  Begin
    fMensagem('','É necessário ter registros para desmarcar',['&Ok ']);
    Exit;
  End;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fDesmarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando Cheques.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);

end;

procedure TfrmBaixaChequesTelecheque.btnIniBusClick(Sender: TObject);
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

procedure TfrmBaixaChequesTelecheque.btnLocProxClick(Sender: TObject);
begin
  inherited;
  If cdsTemp.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um cheque!', ['&Ok']);
    Exit;
  End;
  TfrmGravando.fExecutarModal(pBuscaProx,'Aguarde... Localizando Cheque','');
end;

procedure TfrmBaixaChequesTelecheque.btnMarcarTodosClick(Sender: TObject);
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

procedure TfrmBaixaChequesTelecheque.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBaixaChequesTelecheque.dbgrdChequesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    pSelecionaCheque;
    pSetFocus(Self);
    grdChequesDados.NavigatorButtons.Next.Click;
  End;
end;

procedure TfrmBaixaChequesTelecheque.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  If Not edtCodEmp.ReadOnly Then
    pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpresa, Nil, fRetNomeEmpresaSelec, 'da empresa');
end;

procedure TfrmBaixaChequesTelecheque.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************IV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpresa, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaChequesTelecheque.edtCodPorExit(Sender: TObject);
begin
  inherited;
  If Not edtCodPor.ReadOnly Then
    pEdtCodSelectExit(edtCodPor, edtDesPor, arrPortador, Nil, fRetNomPortador, 'do portador');
end;

procedure TfrmBaixaChequesTelecheque.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE PORTADORES *}
  {****************************IV*}
  If fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtDesPor,
                   Nil,
                   Key,
                   arrPortador,
                   True,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmp.Text) Then
  Begin
    If fValidaCampos(edtCodPor, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmBaixaChequesTelecheque.fEnviaTelecheque(pgbStatus: TcxProgressBar = Nil): Boolean;
  Var
    repCadChq: TCadChqRepository;
begin
  Application.ProcessMessages;
  fStartTransaction;
  Try
    strSeqTel := fRetSequencial('SEQTEL');
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
        If (FieldByName('CHQ_MARDES').AsString = 'M') Then
        Begin
          strTabCad     := 'CADCHQ';
          strTabCtr     := 'CADREC';
          strTabTel     := 'CHQTEL';

          pGravaTeleCheque(FieldByName('AUTOINCREM').AsString,
                           FieldByName('CHQ_CDPRSV').AsString,
                           FieldByName('CHQ_CODEMP').AsString,
                           FieldByName('CHQ_DUPDEV').AsString);

          {********************}
          {* GRAVAR NO LOGCHQ *}
          {*****************JU*}
          repCadChq.pGravaLog(FieldByName('CHQ_CODBCO').AsString, FieldByName('CHQ_NUMAGE').AsString,
                              FieldByName('CHQ_CONCOR').AsString, FieldByName('CHQ_NUMCHQ').AsString,
                              'ENVIO PARA TELECHEQUE (frmBaixaChequesTelecheque.fEnviaTelecheque)');

          fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, False);
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

procedure TfrmBaixaChequesTelecheque.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskCadIni);
end;

procedure TfrmBaixaChequesTelecheque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if (Action <> caNone) then
  begin
    FreeAndNil(cdsTemp);
  end;
end;

procedure TfrmBaixaChequesTelecheque.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  pLimpaDados;
end;

procedure TfrmBaixaChequesTelecheque.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'CADCHQ';

  cdsTemp := TUniClientDataSet.Create(Self);

  FPais := fSetaPais;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'CHQ_TOTCHQ';
    FieldName     := 'CHQ_TOTCHQ';
    DataSet       := cdsTotais;
    Expression    := 'SUM(CHQ_VALCHQ)';
    DisplayFormat := '#,##0.00';
    Active        := True;
  End;

  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'CHQ_TOTCHQT';
    FieldName     := 'CHQ_TOTCHQT';
    DataSet       := cdsTemp;
    Expression    := 'SUM(CHQ_VALCHQ)';
    DisplayFormat := '#,##0.00';
    Active        := True;
  End;

  intSelec  := 0;
  fltSelec  := 0;
  dtaDtaEnv := Date;
  strCodTel := '';
  strCodPor := fCfgSis('PORTEL');

end;

procedure TfrmBaixaChequesTelecheque.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(mskCadIni);
  End

  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End

  Else If (Key = VK_F7) Then
  Begin
    btnMarcarTodos.Click;
  End

  Else If (Key = VK_F8) Then
  Begin
    btnDesmTodos.Click;
  End

  Else If (Key = VK_F5) Then
  Begin
    btnIniBus.Click;
  End

  Else If (Key = VK_F6) Then
  Begin
    btnLocProx.Click;
  End;

end;

function TfrmBaixaChequesTelecheque.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*******************************}
    {* VALIDAÇÃO DATA DE CADASTRO  *}
    {****************************LE*}

    If (Sender = mskCadFin) Then
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

    {********************************}
    {* VALIDAÇÃO DATA DE VENCIMENTO *}
    {*****************************LE*}

    Else
    If (Sender = mskVenFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskVenFin.Text)) And (StrToDateDef(mskVenFin.Text,0) <= 0) Then
      Begin
        fMensagem('', 'A Data Final informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(mskVenFin.Text))  And (Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If Not fEmptyStr(fTiraCaracEspeciais(mskVenFin.Text)) And (fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text))) Then
        Begin
          fMensagem('','O campo Data Inicial deve ser preechindo!',['&O k']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskVenFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text))) Then
          Begin
            If StrToDate(mskVenIni.Text) > StrToDate(mskVenFin.Text) Then
            Begin
              fMensagem('','A Data Inicial deve ser menor que a data final!',['&O K']);
              Result := False;
              Sender := mskVenIni;
            End;
          End;
        End;
      End;
    End
    Else
    If (Sender = mskVenIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text))) And (StrToDateDef(mskVenIni.Text,0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskVenIni;
        End;
    End

    {********************************}
    {* VALIDAÇÃO DATA DE DEVOLUÇÃO  *}
    {*****************************LE*}
    Else
    If(Sender = mskDevFin) Then
    Begin
      If(Not fEmptyStr(fTiraCaracEspeciais(mskDevFin.Text))) And (StrToDateDef(mskDevFin.Text,0) <= 0) Then
      Begin
        fMensagem('','A Data Final informada é inválida! Necessário correção.',['&O K']);
        Result := False;
      End
      Else
      If Not(fEmptyStr(fTiraCaracEspeciais(mskDevIni.Text))) And (fEmptyStr(fTiraCaracEspeciais(mskDevFin.Text))) Then
      Begin
        fMensagem('','O campo Data Final deve ser preenchido!',['& O K']);
        Result := False;
      End
      Else
      If Not (fEmptyStr(fTiraCaracEspeciais(mskDevFin.Text))) And (fEmptyStr(fTiraCaracEspeciais(mskDevIni.Text))) Then
      Begin
        fMensagem('','O campo Data Inicial deve ser preenchido!',['& O K']);
        Result := False;
      End
      Else
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDevFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDevIni.Text))) Then
      Begin
        If StrToDate(mskDevIni.Text) > StrToDate(mskDevFin.Text) Then
        Begin
          fMensagem('','A data Inicial deve ser menor que a data final!',['&O K']);
          Result := False;
          Sender := mskDevIni;
        End;
      End
    End
    Else
    If (Sender = mskDevIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDevIni.Text))) And (StrToDateDef(mskDevIni.Text,0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDevIni;
      End;
    End

    Else If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin
        {*REQ*145940**********RP*}
        if (High(arrEmpresa) > 0) Then
        Begin
            If Not fEmpresaTemAcessoPortador(edtCodPor.Text,arrEmpresa) Then
              Result := False;
        End
        Else if Not fEmptyStr(edtCodEmp.Text) And Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End

        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If (fCfgSis('DACPOR', varBoolean)) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&O k']);
            Result := False;
          End;
        End;
      End;

     { If Result Then
      Begin
        pCriaTemporaria;
        pAtualizaTemporaria;
        pCalculaValores;
      End;
            }
    End;

  End;
  
  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmBaixaChequesTelecheque.grdChequesDadosCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
var
  strMarDes: String;
begin
  inherited;
  strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdChequesCHQ_MARDES.Index]);
  If (strMarDes = 'M') Then
  Begin
    ACanvas.Font.Color := clBlue;
  End;
end;

procedure TfrmBaixaChequesTelecheque.grdChequesDadosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
    pSelecionaCheque;
    pSetFocus(Self);
    grdChequesDados.NavigatorButtons.Next.Click;
  End

  Else If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(mskCadIni);
  End;

end;

procedure TfrmBaixaChequesTelecheque.pAtualizaDados(DataSet: TDataSet);
begin
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
end;

procedure TfrmBaixaChequesTelecheque.pAtualizaTemporaria;
begin
  pDestravaCheques;
  With cdsTemp Do
  Begin
    (FieldByName('CHQ_VALCHQ') As TFloatField).DisplayFormat := '#,##0.00';
    First;
    If IsEmpty Then
    Begin
      fMensagem('', 'Não há cheques a serem enviados!', ['&O k']);
      pSetFocus(mskCadIni);
      blnMudarFoco := False;
    End;
  End;
end;

procedure TfrmBaixaChequesTelecheque.pCalculaValores(blnFiltro: Boolean);
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

procedure TfrmBaixaChequesTelecheque.pCriaTemporaria;
  Var
    strSQL: String;
begin
  qryTemp         := fCriaQuery(Self);
  cdsTemp         := TUniClientDataSet.Create(Self);
  cpvTemp         := TUniDataSetProvider.Create(Self);
  cpvTemp.DataSet := qryTemp;
  dtsTemp.DataSet := cdsTemp;

  qryTemp.Close;

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
  strSQL := strSQL + '  DATE_FORMAT(IF(Q.CHQ_DTADV2 IS NULL, Q.CHQ_DTADEV, Q.CHQ_DTADV2),"%d/%m/%Y") AS CHQ_DTADEV, ';
  strSQL := strSQL + '  IF(Q.CHQ_MOTDV2 IS NULL, Q.CHQ_MOTDEV, Q.CHQ_MOTDV2) AS CHQ_MOTDEV, ';
  strSQL := strSQL + '  LEFT(Q.CHQ_DUPDEV, 12) AS CHQ_DUPDEV, ';
  strSQL := strSQL + '  DATE_FORMAT(IF(Q.CHQ_DTADP2 IS NULL, Q.CHQ_DTADEP, Q.CHQ_DTADP2),"%d/%m/%Y") AS CHQ_DTADEP, ';
  strSQL := strSQL + '  T.CHQ_DTAENV, ';
  strSQL := strSQL + '  T.CHQ_SEQTEL, ';
  strSQL := strSQL + '  T.CHQ_DOCUME, ';
  strSQL := strSQL + '  0 AS CONTADOR, ';
  strSQL := strSQL + '  "CADCHQ" AS TABELA, ';
  strSQL := strSQL + '  " " AS CHQ_MARDES ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCHQ Q ';
  strSQL := strSQL + '  JOIN CADBCO      B ON Q.CHQ_CODBCO = B.BCO_CODBCO ';
  strSQL := strSQL + '  LEFT JOIN CHQTEL T ON Q.AUTOINCREM = T.CHQ_SEQCHQ ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  T.CHQ_DTAENV IS NULL        AND ';
  strSQL := strSQL + '  (Q.CHQ_DEVDEF = 1           OR  ';
  strSQL := strSQL + '  Q.CHQ_DTADV2 IS NOT NULL)   AND ';
  strSQL := strSQL + '  Q.CHQ_INCCTR = "S"          AND ';
  strSQL := strSQL + '  Q.CHQ_TELCHE = "S" ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) Then
    strSQL := strSQL + '  AND Q.CHQ_DTACAD BETWEEN :CADINI AND :CADFIN ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskVenIni.Text)) Then
    strSQL := strSQL + '  AND Q.CHQ_DTAVEN BETWEEN :VENINI AND :VENFIN ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDevIni.Text)) Then
    strSQL := strSQL + '  AND Q.CHQ_DTADEV BETWEEN :DEVINI AND :DEVFIN ';

  If Not fEmptyStr(edtCodEmp.Text) Then
    strSQL := strSQL + fStrLocate(edtCodEmp, arrEmpresa, 'Q.CHQ_CODEMP', 'CODEMP');

  If Not fEmptyStr(edtCodPor.Text) Then
    strSQL := strSQL + fStrLocate(edtCodPor, arrPortador, 'Q.CHQ_CODPOR', 'CODPOR')

  Else If fCfgSis('DACPOR', varBoolean) Then
  Begin
    strSQL := strSQL + '  AND (IFNULL(Q.CHQ_CODPOR, "") = "" ';
    strSQL := strSQL + '  OR LOCATE(Q.CHQ_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    strSQL := strSQL + '  AND (IFNULL(Q.CHQ_PORCUS, "") = "" ';
    strSQL := strSQL + '  OR LOCATE(Q.CHQ_PORCUS, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    strSQL := strSQL + '  AND (IFNULL(Q.CHQ_PORDEB, "") = "" ';
    strSQL := strSQL + '  OR LOCATE(Q.CHQ_PORDEB, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    strSQL := strSQL + '  AND (IFNULL(Q.CHQ_PORCHQ, "") = "" ';
    strSQL := strSQL + '  OR LOCATE(Q.CHQ_PORCHQ, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End;

  strSQL := strSQL + ' ORDER BY CHQ_DTAVEN ';

  With qryTemp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If Not fEmptyStr(fTiraCaracEspeciais(mskCadIni.Text)) Then
    Begin
      ParamByName('CADINI').AsDateTime := StrToDateTime(mskCadIni.Text);
      ParamByName('CADFIN').AsDateTime := StrToDateTime(mskCadFin.Text);
    End;

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
    
    If Not fEmptyStr(edtCodEmp.Text) Then
      pSetaParam(edtCodEmp.Text, arrEmpresa, strEmpresa, 'CODEMP', qryTemp);

    If Not fEmptyStr(edtCodPor.Text) Then
      pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR', qryTemp);

    Open;
    pSetaClient(qryTemp);

    cdsTemp.Close;
    cdsTemp.SetProvider(cpvTemp);
    cdsTemp.Open;
  End;
  cdsTemp.AfterScroll    := pAtualizaDados;
  cdsTemp.OnFilterRecord := pFilterRecord;
end;

procedure TfrmBaixaChequesTelecheque.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
end;

procedure TfrmBaixaChequesTelecheque.pGravaTeleCheque(strSeqChq, strPorOri, strCodEmp, strNumDup: String);
  Var
    strSQL   : String;
    qryGenChq: TUniQuery;
begin
  Try
    qryGenChq := fCriaQuery(Self);
    Try
      strSQL := '';
      strSQL := strSQL + 'INSERT INTO ';
      strSQL := strSQL + strTabTel + ' ';
      strSQL := strSQL + '    (CHQ_SEQCHQ, CHQ_PORORI, ';
      strSQL := strSQL + '     CHQ_CODPOR, CHQ_DTAENV, ';
      strSQL := strSQL + '     CHQ_DOCUME, CHQ_SEQTEL, ';
      strSQL := strSQL + '     CHQ_CODEMP, CHQ_CODOPE) ';
      strSQL := strSQL + '  VALUES ';
      strSQL := strSQL + '    (:CHQ_SEQCHQ, :CHQ_PORORI, ';
      strSQL := strSQL + '     :CHQ_CODPOR, :CHQ_DTAENV, ';
      strSQL := strSQL + '     :CHQ_DOCUME, :CHQ_SEQTEL, ';
      strSQL := strSQL + '     :CHQ_CODEMP, :CHQ_CODOPE) ';

      With qryGenChq Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CHQ_SEQCHQ').AsString   := strSeqChq;
        ParamByName('CHQ_PORORI').AsString   := strPorOri;
        ParamByName('CHQ_CODPOR').AsString   := strCodPor;
        ParamByName('CHQ_DTAENV').AsDateTime := dtaDtaEnv;
        ParamByName('CHQ_DOCUME').AsString   := strCodTel;
        ParamByName('CHQ_SEQTEL').AsString   := strSeqTel;
        ParamByName('CHQ_CODEMP').AsString   := VS_strCodEmp;
        ParamByName('CHQ_CODOPE').AsString   := strLoginUsuarioLogado;
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
        ParamByName('CODPOR').AsString := strCodPor;
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
        ParamByName('CODPOR').AsString := strCodPor;
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

procedure TfrmBaixaChequesTelecheque.pImprimeBordero;
  Var
    cdsRel: TUniClientDataSet;
    intCont: Integer;
    strDirImg: String;
begin
  intCont := 0;
  Try
    cdsRel := TUniClientDataSet.Create(Self);
    pCopiaClientDataSet(cdsTemp, cdsRel);
    With cdsTemp Do
    Begin
      First;
      cdsRel.EmptyDataSet;
      While Not Eof Do
      Begin
        If (FieldByName('CHQ_MARDES').AsString = 'M') Then
        Begin
          Inc(intCont);
          cdsRel.Append;
          cdsRel.FieldByName('CONTADOR').AsInteger  := intCont;
          cdsRel.FieldByName('CHQ_C_G_C_').AsString := fFormataCpfCgc(FieldByName('CHQ_C_G_C_').AsString, FPais);
          cdsRel.FieldByName('CHQ_TELNUM').AsString := FieldByName('CHQ_TELNUM').AsString;
          cdsRel.FieldByName('CHQ_CODBCO').AsString := FieldByName('CHQ_CODBCO').AsString;
          cdsRel.FieldByName('CHQ_NUMAGE').AsString := FieldByName('CHQ_NUMAGE').AsString;
          cdsRel.FieldByName('CHQ_NUMCHQ').AsString := FieldByName('CHQ_NUMCHQ').AsString;
          cdsRel.FieldByName('CHQ_MOTDEV').AsString := FieldByName('CHQ_MOTDEV').AsString;
          cdsRel.FieldByName('CHQ_VALCHQ').AsFloat  := FieldByName('CHQ_VALCHQ').AsFloat;
          cdsRel.FieldByName('CHQ_SEQTEL').AsString := strSeqTel;
          cdsRel.FieldByName('CHQ_DOCUME').AsString := strCodTel;
          cdsRel.Post;
        End;
        Next;
      End;
    End;
    cdsRel.First;

    If FileExists(fCfgSis('PATLOG')) Then
      strDirImg := fCfgSis('PATLOG')
    Else
      strDirImg := '';

    pCriarFormularios(TfrmModuloBaixaChequesTelecheque, frmModuloBaixaChequesTelecheque);
    With frmModuloBaixaChequesTelecheque Do
    Begin
      strImagem            := strDirImg;
      strNomeEmp           := fRetNomeEmpresa;
      frxRelatorio.DataSet := cdsRel;
      pPreviewReport(Self.Name, Self.Caption + ' (Bordero)', frxBordero);
    End;
  Finally
    FreeAndNil(frmModuloBaixaChequesTelecheque);
    FreeAndNil(cdsRel);
  End;
end;

procedure TfrmBaixaChequesTelecheque.pLimpaDados;
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
  edtTotalCheques.Clear;
  edtValorTotal.Clear;

  mskCadIni.Clear;
  mskCadFin.Clear;
  mskVenIni.Clear;
  mskVenFin.Clear;
  mskDevIni.Clear;
  mskDevFin.Clear;

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

procedure TfrmBaixaChequesTelecheque.pMarcaCheque(blnMarcar,
  blnAtuGrid: Boolean);
begin
  Try
    with cdsTemp do
    begin
      IF blnMarcar THEN
      BEGIN
        If Not fLock_Unlock('CADCHQ' + FieldByName('AUTOINCREM').AsString, True, False) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cheque está sendo utilizado por outra estação: ' + fGetHostLock('CADCHQ' + FieldByName('AUTOINCREM').AsString), ['&Ok']);
          Exit;
        End;
      END
      ELSE
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

procedure TfrmBaixaChequesTelecheque.pSelecionaCheque;
  Var
    intRecNo: Integer;
begin
  If (Not cdsTemp.Active) Or
     (cdsTemp.IsEmpty)    Then
  Begin
    Exit;
  End;

  if Not fEmpresaTemAcessoPortador(cdsTemp.FieldByName('CHQ_CODPOR').AsString,
                                   VS_strCodEmp) Then
  Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
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

function TfrmBaixaChequesTelecheque.fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
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

      if Not fEmpresaTemAcessoPortador(cdsTemp.FieldByName('CHQ_CODPOR').AsString,VS_strCodEmp) Then
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok'])
      Else
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


function TfrmBaixaChequesTelecheque.fDesmarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
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

procedure TfrmBaixaChequesTelecheque.pStep(pgbStatus: TcxProgressBar);
Begin

  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;

End;

procedure TfrmBaixaChequesTelecheque.pBuscaIni;
Begin

  If (Not fEmptyStr(frmBuscaCheques.strValorFiltro)) Then
  Begin
    strValorFiltro := frmBuscaCheques.strValorFiltro;
    strCampoFiltro := frmBuscaCheques.strCampoFiltro;

    If (strCampoFiltro = 'CHQ_DTACAD') Then
      strCampoFiltro := 'CHQ_DTAVEN';

    If Not cdsTemp.FindFirst Then
    Begin
      fMensagem('ATENÇÃO!', 'Não há cheques devolvidos!', ['&O k']);
    End;
     pSetFocus(grdCheques);
  End;
End;

procedure TfrmBaixaChequesTelecheque.pBuscaProx;
Begin

  If (cdsTemp.Active) And (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    If Not cdsTemp.FindNext Then
      fMensagem('ATENÇÃO!', 'Não há cheques devolvidos!', ['&O k']);
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);
End;


function TfrmBaixaChequesTeleCheque.fDigInfoBaixa : Boolean;
  Var
    blnConfirma : Boolean;
    frmBaixaDigTelecheque : TfrmBaixaDigTelecheque;
Begin
  blnConfirma := False;

  Try
    pCriarFormularios(TfrmBaixaDigTelecheque, frmBaixaDigTelecheque);
    If Not fEmptyStr(strCodTel) Then
    Begin
      frmBaixaDigTelecheque.edtCodTel.Text := strCodTel;
      frmBaixaDigTelecheque.mskDtaEnv.Text := DateToStr(dtaDtaEnv);
    End;
    frmBaixaDigTelecheque.ShowModal;
    blnConfirma:= frmBaixaDigTelecheque.blnConfirma;
    strCodTel   := frmBaixaDigTelecheque.strCodTel;
    dtaDtaEnv   := frmBaixaDigTelecheque.dtaDtaEnv;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

  Result  := blnConfirma;
  pFreeAndNil(frmBaixaDigTelecheque);


End;

procedure TfrmBaixaChequesTeleCheque.pDestravaCheques;
Var
  prcScroll: TprcScroll;
begin
  With cdsTemp Do
  Begin
    If Not Active Then
      Exit;

    pDisableControls(cdsTemp, prcScroll);
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
  pEnableControls(cdsTemp, prcScroll);
end;

end.
