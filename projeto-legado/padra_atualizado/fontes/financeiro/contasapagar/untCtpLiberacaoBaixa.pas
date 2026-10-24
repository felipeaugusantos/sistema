unit untCtpLiberacaoBaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, Data.DB, cxDBData, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  cxMaskEdit, cxDropDownEdit, cxCalendar, cxTextEdit, cxCurrencyEdit,
  CurrencyEditFocus, Vcl.Mask, MaskEditFocus, EditFocus, ComboBoxFocus,
  System.StrUtils, Uni, untTypesSistema, UniDataSetProvider, UniClientDataSet, MemoFocus,
  cxDataControllerConditionalFormattingRulesManagerDialog,untBaixaCtpBusca,
  untFrameCentroCustoEditFocus, untFramePlanoDeContasMaskEdit;

type
  TfrmCtpLiberacaoBaixa = class(TfrmPaiSimples)
    pnlBotoesBaixa: TPanel;
    btnIniBus: TBitBtnLocked;
    btnLocProx: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    btnMarcarTodas: TBitBtnLocked;
    btnDesmarcarTodas: TBitBtnLocked;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    lblCodEmp: TLabel;
    Label24: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    Label11: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtNomEmp: TEditFocus;
    edtCodEmp: TEditFocus;
    chkLimFil: TCheckBox;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtVlrIni: TCurrencyEditFocus;
    edtVlrFin: TCurrencyEditFocus;
    rdgVeioBo: TRadioGroup;
    btnConsultar: TBitBtnLocked;
    mskDtaVenIni: TcxDateEdit;
    mskDtaVenFin: TcxDateEdit;
    pnlAux1: TPanel;
    pnlTotais: TPanel;
    Label21: TLabel;
    Label23: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label7: TLabel;
    Label14: TLabel;
    Label4: TLabel;
    Label13: TLabel;
    edtQtdDuplicatas: TEditFocus;
    edtQtdSelecionadas: TEditFocus;
    edtValorTotal: TEditFocus;
    edtTotalPago: TEditFocus;
    edtCodCtaBai: TEditFocus;
    edtCheque: TEditFocus;
    edtCodEveBai: TEditFocus;
    dbgDuplicatas: TcxGrid;
    dbgDuplicatasView: TcxGridDBTableView;
    dbgDuplicatasCTP_NUMDUP: TcxGridDBColumn;
    dbgDuplicatasCTP_CODEMP: TcxGridDBColumn;
    dbgDuplicatasCTP_CODFOR: TcxGridDBColumn;
    dbgDuplicatasFOR_NOMFOR: TcxGridDBColumn;
    dbgDuplicatasCTP_CODPOR: TcxGridDBColumn;
    dbgDuplicatasCTP_DTAVEN: TcxGridDBColumn;
    dbgDuplicatasTOTDUP: TcxGridDBColumn;
    dbgDuplicatasCTP_MARDES: TcxGridDBColumn;
    dbgDuplicatasLevel1: TcxGridLevel;
    Label3: TLabel;
    Label25: TLabel;
    mskDtaCadIni: TcxDateEdit;
    mskDtaCadFin: TcxDateEdit;
    Label26: TLabel;
    cbxOrigem: TComboBoxFocus;
    btnHlpLin: TBitBtnLocked;
    edtDesEveBai: TEditFocus;
    edtDesCtaBai: TEditFocus;
    Label5: TLabel;
    edtPrevisao: TEditFocus;
    Label8: TLabel;
    edtVeioBoleto: TEditFocus;
    dbgDuplicatasCTP_SERIE_: TcxGridDBColumn;
    dbgDuplicatasCTP_DTACAD: TcxGridDBColumn;
    edtHistor: TMemoFocus;
    FlwPnlBotoesBaixa: TFlowPanel;
    Panel1: TPanel;
    fraCentroCusto: TfraCentroCustoEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    rdgPrevisao: TRadioGroup;
    btnManutencao: TBitBtnLocked;
    dbgDuplicatasCTP_COMPET: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPorExit(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure btnHlpLinClick(Sender: TObject);
    procedure btnSairBaixaClick(Sender: TObject);
    procedure btnConsultarClick(Sender: TObject);
    procedure dbgDuplicatasViewCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure dbgDuplicatasViewDblClick(Sender: TObject);
    procedure dbgDuplicatasViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMarcarTodasClick(Sender: TObject);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure fraCentroCustoedtCodEveExit(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaExit(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnManutencaoClick(Sender: TObject);
  private
    frmBaixaCtpBusca : TfrmBaixaCtpBusca;
    strAceCtp: String;

    qryCadPag: TUniQuery;
    cdsCtaPag: TUniClientDataSet;
    dtsCtaPag: TDataSource;

    qryConEmp: TUniQuery;
    qryConFor: TUniQuery;
    qryConCta: TUniQuery;
    qryConPor: TUniQuery;

    strEmp: String;
    strFornec: String;
    strEvento: String;
    strPortador: String;
    strCentCusto: String;

    strValorFiltro : String;
    strCampoFiltro : String;

    arrEmp: TConsultasArray;
    arrFornec: TConsultasArray;
    arrEvento: TConsultasArray;
    arrPortador: TConsultasArray;
    arrCentCusto: TConsultasArray;

    function fGetEmpAceCtp: String;
    procedure pCarregaFornecedor;
    procedure pCarregaEventos;
    procedure pCarregaCentroCusto;
    procedure pCarregaPortador;
    procedure pCarregaEmpresa;
    procedure pAtualizaTemporaria;
    procedure pLimpaEdits;
    procedure pLimpaEditsDuplicata;
    procedure pCalculaTotalDuplicatas(edtQuant, edtTotal: TEditFocus; blnFiltrar: Boolean);
    procedure pSelecionaDuplicata;
    procedure pMarcaDuplicata(blnMarcar: Boolean);
    procedure pMarcarTodas(blnMarcar: Boolean);
    procedure pConcluiBusca;
    procedure pLocalizaProximaDup;
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);
    procedure pChamarManutencaoCtp;
  protected
    procedure pAtualizaDados(DataSet: TDataSet);
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strAutIncManCtp: String;
    blnVeioMntPagar: Boolean;
  end;


implementation

{$R *.dfm}

uses untFuncoesSimples, untPesqAux, untFuncoesConsulta, untConsultas,
  untMensagemExplicativa,
  untGravando, untTLiberaBaixaPagar, untFuncoesRel, untFuncoesRel2,
  untCadCtaPagar;

{ TfrmCtpLiberacaoBaixa }

procedure TfrmCtpLiberacaoBaixa.btnConfirmaClick(Sender: TObject);
var
  objLibera: TLiberaBaixaPagar;
begin
  inherited;
  If (StrToIntDef(edtQtdSelecionadas.Text, 0) <= 0) Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If fMensagem('Confirmação', 'Confirma a liberação para baixa das duplicatas selecionadas?', ['&Sim', '&Não']) = 2 Then
    Exit;

  objLibera := TLiberaBaixaPagar.Create(Self.Name);
  cdsCtaPag.DisableControls;
  Try
    strValorFiltro := '';
    strCampoFiltro := '';
    With cdsCtaPag Do
    Begin
      Filtered := False;
      Filter := 'CTP_MARDES = ''M''';
      Filtered := True;

      First;
      While Not Eof Do
      Begin
        objLibera.pAddPagar(FieldByName('AUTOINCREM').AsString);
        Next;
      End;

      objLibera.pLiberar;
      fMensagem('', 'Liberação feita com sucesso!', ['&Ok']);
      Self.ModalResult := mrOk;
      blnVeioMntPagar := False;
      strAutIncManCtp := '';
    End;

  Finally
    FreeAndNil(objLibera);

    cdsCtaPag.Filtered := False;
    cdsCtaPag.Filter := '';
    cdsCtaPag.EnableControls;

    If chkLimFil.Checked Then
    Begin
      pLimpaEdits;
      blnMudarFoco := False;
      pSetFocus(edtCodFor);
    End
    Else
      btnConsultar.Click;
  End;
end;

procedure TfrmCtpLiberacaoBaixa.btnConsultarClick(Sender: TObject);
begin
  inherited;
  if fVerificaCampos Then
  Begin
    TfrmGravando.fExecutarModal(pAtualizaTemporaria, 'Aguarde... Carregando Títulos.', '');

    If pnlCabecalho.Visible Then
      pSetFocus(dbgDuplicatas);
  End;
end;

procedure TfrmCtpLiberacaoBaixa.btnDesmarcarTodasClick(Sender: TObject);
begin
  inherited;
  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If Not btnDesmarcarTodas.Visible Then
    Exit;

  If cdsCtaPag.IsEmpty Then
    Exit;

  If (Not btnDesmarcarTodas.Enabled) Then
    Exit;

  pMarcarTodas(False);
end;

procedure TfrmCtpLiberacaoBaixa.btnHlpLinClick(Sender: TObject);
Var
  strMensag: String;
begin
  strMensag := '* Origem Manual são títulos incluídos diretamente pela Manutenção do Contas a Pagar.' + #13#10 +
               '* Origem Automática são títulos incluídos pelas rotinas que alimentam o Contas a Pagar, ' +
               'como por exemplo, Entrada de Mercadorias, Livro Fiscal, etc.';

  Try
    pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
    frmMensagemExplicativa.Caption := 'Instrução';
    frmMensagemExplicativa.mmoInstru.Lines.Add(strMensag);
    frmMensagemExplicativa.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmCtpLiberacaoBaixa.pAbreTelaHelp]')
  End;

  pFreeAndNil(frmMensagemExplicativa);

end;

procedure TfrmCtpLiberacaoBaixa.btnIniBusClick(Sender: TObject);
begin
  inherited;
  If Not btnIniBus.Visible Then
    Exit;

  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmBaixaCtpBusca, frmBaixaCtpBusca);
    if frmBaixaCtpBusca.ShowModal = mrOk then
      pConcluiBusca;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmBaixaCtaPagar.btnIniBusClick]');
    End;
  End;

  pFreeAndNil(frmBaixaCtpBusca);
  pSetFocus(Self);
end;

procedure TfrmCtpLiberacaoBaixa.btnLocProxClick(Sender: TObject);
begin
  inherited;
  If Not btnLocProx.Visible Then
    Exit;

  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If (Not cdsCtaPag.IsEmpty) And (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    pLocalizaProximaDup;
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);
end;

procedure TfrmCtpLiberacaoBaixa.btnManutencaoClick(Sender: TObject);
begin
  inherited;

  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If fVerificaAcessoSistema('frmCadCtaPagar') Then
    pChamarManutencaoCtp
  Else
    pMensagemOk('Operador sem direito de acesso!');

end;

Procedure TfrmCtpLiberacaoBaixa.pChamarManutencaoCtp();
Var
  frmCadCtaPagar: TfrmCadCtaPagar;
Begin

  Try
    pCriarFormularios(TfrmCadCtaPagar, frmCadCtaPagar);
    {***********************************************}
    {* AO INFORMAR O AUTOINCREM ANTES DO SHOWMODAL *}
    {* IRÁ ABRIR A DUPLICATA AUTOMATICAMENTE       *}
    {********************************************JS*}
    frmCadCtaPagar.Position      := poScreenCenter;
    frmCadCtaPagar.strAutoIncrem := cdsCtaPag.FieldByName('AUTOINCREM').AsString;
    frmCadCtaPagar.strOrigem     := 'frmBaixaCtaPagar';
    frmCadCtaPagar.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmBaixaCtaPagar.pChamarManutencaoCtp]');
  End;
  pFreeAndNil(frmCadCtaPagar);

End;

procedure TfrmCtpLiberacaoBaixa.btnMarcarTodasClick(Sender: TObject);
begin
  inherited;
  If cdsCtaPag.IsEmpty Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If Not btnMarcarTodas.Visible Then
    Exit;

  If cdsCtaPag.IsEmpty Then
    Exit;

  If (Not btnMarcarTodas.Enabled) Then
    Exit;

  pMarcarTodas(True);
end;

procedure TfrmCtpLiberacaoBaixa.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmCtpLiberacaoBaixa.dbgDuplicatasViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  With cdsCtaPag Do
  Begin
    {*****************************************}
    {* CASO A TABELA ESTEJA FECHADA, SAI     *}
    {**************************************MV*}
    If Not Active Then
      Exit;

    If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDuplicatasCTP_MARDES.Index]) = 'M' Then
    Begin
      If AViewInfo.Selected Then
        ACanvas.Font.Color := clLime
      Else
        ACanvas.Font.Color := clBlue;
    End;

  End;
end;

procedure TfrmCtpLiberacaoBaixa.dbgDuplicatasViewDblClick(Sender: TObject);
begin
  inherited;
  pSelecionaDuplicata;
end;

procedure TfrmCtpLiberacaoBaixa.dbgDuplicatasViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_RETURN Then
    pSelecionaDuplicata;
end;

procedure TfrmCtpLiberacaoBaixa.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmp, fRetNomeEmpresa, Nil, 'da Empresa', 0, False, 'Código', True);
end;

procedure TfrmCtpLiberacaoBaixa.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp, False, True) Then
  Begin
    If fValidaCampos(edtCodEmp, False) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCtpLiberacaoBaixa.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrFornec, fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmCtpLiberacaoBaixa.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornec, False) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCtpLiberacaoBaixa.edtCodPorExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodPor, edtDesPor, arrPortador, Nil, fRetNomPortador, 'do Portador');
end;

procedure TfrmCtpLiberacaoBaixa.edtCodPorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqPortador(conSimples,
                   Self,
                   edtCodPor,
                   edtDesPor,
                   nil,
                   Key,
                   arrPortador,
                   False,
                   'Consulta de Portadores',
                   '',
                   False,
                   False,
                   edtCodEmp.Text) Then
    If fValidaCampos(edtCodPor) Then
      SelectNext(ActiveControl, True, True);
end;

function TfrmCtpLiberacaoBaixa.fGetEmpAceCtp: String;
begin
  Result:= fCampoTabela('OPE_EMPCTP', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);

  Result := Copy(Result, 0, (Length(Result) -1));

  If Not fEmptyStr(Result) Then
    Result := AnsiReplaceStr(Result,'_', ',');
end;

procedure TfrmCtpLiberacaoBaixa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if (Self.ModalResult <> mrOk) then
    Self.ModalResult := mrCancel;
end;

procedure TfrmCtpLiberacaoBaixa.FormCreate(Sender: TObject);
begin
  inherited;
  strAceCtp := fGetEmpAceCtp;

  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryConPor := fCriarQuery('SELECT * FROM CADPOR WHERE FALSE', Self);

  qryCadPag := fCriarQuery('SELECT * FROM CADPAG WHERE FALSE', Self);
  qryCadPag.Open;

  cdsCtaPag := TUniClientDataSet.Create(Self);
  cdsCtaPag.AfterScroll := pAtualizaDados;
  cdsCtaPag.OnFilterRecord := pFilterRecord;
  dtsCtaPag := fCriaDataSource(cdsCtaPag);
  dbgDuplicatasView.DataController.DataSource := dtsCtaPag;
end;

procedure TfrmCtpLiberacaoBaixa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    If pnlCabecalho.Visible Then
    Begin
      pLimpaEdits;
      blnMudarFoco := False;
      blnVeioMntPagar := False;
      strAutIncManCtp := '';
      pSetFocus(edtCodFor);
    End
    Else
      btnSair.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End
  Else If (Key = VK_F5) Then
  Begin
    btnIniBus.Click;
  End
  Else If (Key = VK_F6) Then
  Begin
    btnLocProx.Click;
  End
  Else If (Key = VK_F7) Then
  Begin
    btnMarcarTodas.Click;
  End
  Else If (Key = VK_F8) Then
  Begin
    btnDesmarcarTodas.Click;
  End
  Else If (Key = VK_F12) Then
  Begin
    btnManutencao.Click;
  End;

end;

procedure TfrmCtpLiberacaoBaixa.FormShow(Sender: TObject);
begin
  inherited;
  If (Not fCfgSis('CTPTUD', varBoolean)) Then
  Begin
    btnMarcarTodas.Enabled := False;
    btnMarcarTodas.Visible := False;
    btnConfirma.Left := btnMarcarTodas.Left;
  End;

  edtCodEmp.Text := IfThen((Pos(LeftStr(VS_strCodEmp,3), strAceCtp) > 0),VS_strCodEmp, '' ); //VS_strCodEmp;
  edtNomEmp.Text := IfThen((Pos(LeftStr(VS_strCodEmp,3), strAceCtp) > 0),fRetNomeEmpresa, '' ); //fRetNomeEmpresa;

  edtVlrFin.Value := 0;
  edtVlrIni.Value := 0;
end;

procedure TfrmCtpLiberacaoBaixa.fraCentroCustoedtCodEveExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(fraCentroCusto.edtCodEve, fraCentroCusto.edtDesEve, arrEvento, fRetNomEvento, Nil, 'do Centro de Custos');
end;

procedure TfrmCtpLiberacaoBaixa.fraPlanoDeContasMskCodCtaExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, arrCentCusto, fRetNomeConta, Nil, 'da Conta',7);

  fraPlanoDeContas.MskCodCtaExit(Sender);
end;

procedure TfrmCtpLiberacaoBaixa.fraPlanoDeContasMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentCusto, False) Then
  Begin
    If fValidaCampos(fraPlanoDeContas.MskCodCta, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCtpLiberacaoBaixa.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O CÓDIGO DO FORNECEDOR         *}
    {**************************************MV*}

    If (Sender = edtCodFor) Then
    Begin
      If (Not fEmptyStr(edtCodFor.Text)) Then
      Begin

        If edtCodFor.Text <> '00000000' Then
           pCarregaFornecedor;

        If fEmptyStr(edtNomFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse fornecedor não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
        edtNomFor.Clear;
    End

    {*****************************************}
    {* VALIDA O CÓDIGO DO EVENTO             *}
    {**************************************LB*}
    Else If (Sender = fraCentroCusto.edtCodEve) Then
    Begin
      If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      Begin

        If fraCentroCusto.edtCodEve.Text <> '00000' Then
           pCarregaEventos;

        If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If (fRetTipoEvento(fraCentroCusto.edtCodEve.Text)='R') Then
        Begin
          fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a receber!',['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        fraCentroCusto.edtDesEve.Clear;
      End;
    End

    Else If (Sender = edtCodEmp) Then
    Begin

      If fEmptyStr(edtCodEmp.Text) Then
        edtNomEmp.Clear
      Else
      Begin

        If edtCodEmp.Text <> '000' Then
           pCarregaEmpresa;

        If fEmptyStr(edtNomEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If (Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0) And (edtNomEmp.Text <> '+1') Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
          Result := False;
        End
        Else If (Pos(LeftStr(edtCodEmp.Text,3), strAceCtp) <= 0) And (edtNomEmp.Text <> '+1') Then
        Begin
          fMensagem('ATENÇÃO!', 'Usuário sem permissão no Baixa contas a pagar desta empresa!', ['&Ok']);
          Result := False;
        End;

      End;

    End

    {***************************************}
    {* VALIDA A DATA DE CADASTRO INICIAL   *}
    {************************************MV*}
    Else If (Sender = mskDtaCadIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
      Begin
        mskDtaCadFin.Clear;
        mskDtaCadFin.Enabled := False;
      End
      Else
      Begin
        mskDtaCadFin.Enabled := True;
      End;
    End

    {***************************************}
    {* VALIDA A DATA DE CADASTRO FINAL     *}
    {************************************MV*}
    Else If (Sender = mskDtaCadFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaCadFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final de cadastro deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaCadIni.Text, mskDtaCadFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final de cadastro deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA A DATA DE VENCIMENTO INICIAL   *}
    {**************************************MV*}
    Else If (Sender = mskDtaVenIni) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(mskDtaVenIni.Text)) Then
      Begin
        mskDtaVenFin.Clear;
        mskDtaVenFin.Enabled := False;
      End
      Else
      Begin
        mskDtaVenFin.Enabled := True;
      End;
    End

    {*****************************************}
    {* VALIDA A DATA DE VENCIMENTO FINAL     *}
    {**************************************MV*}
    Else If (Sender = mskDtaVenFin) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenIni.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(mskDtaVenFin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final de vencimento deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not fValidaPeriodo(mskDtaVenIni.Text, mskDtaVenFin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data Final de vencimento deve ser maior ou igual a Data Inicial!', ['&O k']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtVlrFin) Then
    Begin

      If (edtVlrFin.Value = 0) And (edtVlrIni.Value <> 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor Final deve ser informado!', ['&O k']);
        Result := False;
      End
      Else If (edtVlrFin.Value < edtVlrIni.Value) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor Final deve ser maior ou igual ao Valor Inicial!', ['&O k']);
        Result := False;
      End
      Else If (edtCodEmp.Text <> '000') And (edtNomEmp.Text <> '+1') And (Not fEmptyStr(edtCodEmp.Text))
        And (not (Pos(LeftStr(edtCodEmp.Text,3), strAceCtp) > 0)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a esta empresa!', ['&Ok']);
        Result := False;
      End;
    End
    {***************************************}
    {* VALIDA CENTRO DE CUSTO              *}
    {************************************JU*}
    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin
      If Not fEmptyStr(fTiraCaracEspeciais(fraPlanoDeContas.MskCodCta.Text)) Then
      Begin

        If fraPlanoDeContas.MskCodCta.Text <> '0000000' Then
           pCarregaCentroCusto;

        if fEmptyStr(fraPlanoDeContas.edtDesCta.Text) Then
        Begin
           fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
           Result := False;
        End;
      End
      Else
      Begin
        fraPlanoDeContas.edtDesCta.Clear;
      End;
    End
    {**************************************}
    {* VALIDA O CÓDIGO DO PORTADOR        *}
    {***********************************JU*}
    Else If (Sender = edtCodPor) Then
    Begin
      If Not fEmptyStr(edtCodPor.Text) Then
      Begin

        If edtCodPor.Text <> '00000' Then
           pCarregaPortador;

       if fEmptyStr(EdtDesPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else
        Begin

          {*REQ*145940**********RP*}
          If (High(arrEmp) > 0) Then
          Begin
            If Not fEmpresaTemAcessoPortador(edtCodPor.Text,arrEmp) Then
              Result := False;
          End
          Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text, edtCodEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Você não tem permissão para utilizar este portador!', ['&O k']);
              Result := False;
            End;
          End;

        End;

      End
      Else
        edtDesPor.Clear;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCtpLiberacaoBaixa.pAtualizaDados(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    edtCodCtaBai.Text  := FieldByName('CTP_CODCTA').AsString;
    edtDesCtaBai.Text  := FieldByName('CTA_DESCTA').AsString;
    edtCodEveBai.Text  := FieldByName('CTP_CODEVE').AsString;
    edtDesEveBai.Text  := FieldByName('EVE_DESEVE').AsString;

    edtCheque.Text     := FieldByName('CTP_USACHQ').AsString;
    edtVeioBoleto.Text := FieldByName('CTP_VEIOBO').AsString;
    edtPrevisao.Text   := IIF(FieldByName('CTP_PREVIS').AsString = 'S', 'SIM', 'NÃO');

    edtHistor.Texto    := FieldByName('CTP_HIST01').AsString;
  End;
end;

procedure TfrmCtpLiberacaoBaixa.pAtualizaTemporaria;
  Var
    strSQL: String;
    qryCtaPag: TUniQuery;
    dspCtaPag: TUniDataSetProvider;
begin
  If (fCfgSis('DACPOR', varBoolean)) And
     Not (fEmptyStr(edtCodPor.Text)) Then
  Begin
    If Not fValidaCampos(edtCodPor) Then
    Begin
      blnMudarFoco := False;
      Exit;
    End;
  End;

  cdsCtaPag.Filtered := False;
  cdsCtaPag.Close;
  qryCtaPag := fCriaQuery(Self);
  dspCtaPag := TUniDataSetProvider.Create(Self);
  dspCtaPag.DataSet := qryCtaPag;
  cdsCtaPag.SetProvider(dspCtaPag);

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  P.CTP_NUMDUP AS NRODUP, ';
    strSQL := strSQL + '  P.CTP_PARCEL AS PARDUP, ';
    strSQL := strSQL + '  CONCAT(P.CTP_NUMDUP, P.CTP_PARCEL) AS CTP_NUMDUP, ';
    strSQL := strSQL + '  P.CTP_CODFOR, ';
    strSQL := strSQL + '  F.FOR_NOMFOR, ';
    strSQL := strSQL + '  F.FOR_FONE01, ';
    strSQL := strSQL + '  F.FOR_F_A_X_, ';
    strSQL := strSQL + '  CONCAT(P.CTP_CODFOR ,"-", F.FOR_NOMFOR) AS CTP_NOMFOR, ';
    strSQL := strSQL + '  F.FOR_C_G_C_, ';
    strSQL := strSQL + '  P.CTP_CODEMP, ';
    strSQL := strSQL + '  P.CTP_SERIE_, ';
    strSQL := strSQL + '  E.EMP_NOMEMP, ';
    strSQL := strSQL + '  P.CTP_CODCTA, ';
    strSQL := strSQL + '  C.CTA_DESCTA, ';
    strSQL := strSQL + '  P.CTP_HIST01, ';
    strSQL := strSQL + '  P.CTP_HIST02, ';
    strSQL := strSQL + '  P.CTP_PREVIS, ';
    strSQL := strSQL + '  IF(P.CTP_VEIOBO = "S", "SIM", "NÃO") AS CTP_VEIOBO, ';
    strSQL := strSQL + '  P.CTP_DTACAD, ';
    strSQL := strSQL + '  P.CTP_DTAVEN, ';
    strSQL := strSQL + '  P.CTP_VALORI, ';
    strSQL := strSQL + '  P.CTP_VALDUP, ';
    strSQL := strSQL + '  P.CTP_VALPAG, ';
    strSQL := strSQL + '  P.CTP_DTAPAG, ';
    strSQL := strSQL + '  P.CTP_VALJUR, ';
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
    strSQL := strSQL + '  (P.CTP_VALDUP + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_MULSUJ,0) + IFNULL(P.CTP_VENDOR,0)) -IFNULL(P.CTP_DESSUJ,0) AS TOTDUP, ';
    strSQL := strSQL + '  " " AS CTP_MARDES, ';
    strSQL := strSQL + '  " " AS CTP_TIPBAI, ';
    strSQL := strSQL + '  " " AS CTP_TIPDES, ';
    strSQL := strSQL + '  P.AUTOINCREM, ';
    strSQL := strSQL + '  "CADPAG" AS TABELA, ';
    strSQL := strSQL + '  P.CTP_COMPET, ';
    strSQL := strSQL + '  P.CTP_DINHEI, ';
    strSQL := strSQL + '  P.CTP_CHQAVI, ';
    strSQL := strSQL + '  P.CTP_ORDPAG, ';
    strSQL := strSQL + '  P.CTP_REPCHQ, ';
    strSQL := strSQL + '  P.CTP_SEQBAI  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG P ';
    strSQL := strSQL + '  JOIN CADFOR F ON P.CTP_CODFOR = F.FOR_CODFOR ';
    strSQL := strSQL + '  JOIN CADEMP E ON P.CTP_CODEMP = E.EMP_CODEMP ';
    strSQL := strSQL + '  JOIN CADCTA C ON P.CTP_CODCTA = C.CTA_CODCTA ';
    If (cbxOrigem.ItemIndex in [0, 1]) Then
    Begin
      strSQL := strSQL + '  LEFT JOIN LOGCTP L                    ';
      strSQL := strSQL + '    ON L.CTP_NUMDUP = P.CTP_NUMDUP ';
      strSQL := strSQL + '   AND L.CTP_PARCEL = P.CTP_PARCEL ';
      strSQL := strSQL + '   AND L.CTP_SEQBAI = P.CTP_SEQBAI ';
      strSQL := strSQL + '   AND L.CTP_CODFOR = P.CTP_CODFOR ';
      strSQL := strSQL + '   AND L.CTP_CODEMP = P.CTP_CODEMP ';
      strSQL := strSQL + '   AND L.CTP_SERIE_ = P.CTP_SERIE_ ';
      strSQL := strSQL + '   AND L.CTP_DESCRI = "INCLUSAO" ';
    End;
    strSQL := strSQL + ' LEFT JOIN CADEVE V ON P.CTP_CODEVE = V.EVE_CODEVE ';
    strSQL := strSQL + ' LEFT JOIN CADPOR B ON P.CTP_PORBAI = B.POR_CODPOR ';
    strSQL := strSQL + ' LEFT JOIN CADPOR R ON P.CTP_CODPOR = R.POR_CODPOR ';

    strSQL := strSQL + 'WHERE ';
    {**************************************}
    {* DEVIDO À ALTERAÇÃO DA MINAS TINTAS *}
    {* CRIANDO DIREITO DE ACESSO PARA     *}
    {* PODER OU NÃO ALTERAR O VALOR DA    *}
    {* DUPLICATA AGORA VÃO EXISTIR        *}
    {* REGISTROS NO CADPAG COM VALDUP = 0 *}
    {* E QUE NÃO PODEM SER BAIXADOS       *}
    {*06/07/2012************************JU*}
    strSQL := strSQL + '  (P.CTP_VALDUP + IFNULL(P.CTP_JURSUJ,0) + IFNULL(P.CTP_MULSUJ,0) + IFNULL(P.CTP_VENDOR,0)) -IFNULL(P.CTP_DESSUJ,0) <> 0 AND ';

    If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
      strSQL := strSQL + '  P.CTP_CODEVE = V.EVE_CODEVE AND ';

    Case rdgPrevisao.ItemIndex Of
      0: strSQL := strSQL + '  P.CTP_PREVIS = "S" AND ';
      1: strSQL := strSQL + '  (P.CTP_PREVIS = "N" OR P.CTP_PREVIS IS NULL OR P.CTP_PREVIS = "") AND ';
    End;

    Case rdgVeioBo.ItemIndex Of
      0: strSQL := strSQL + '  P.CTP_VEIOBO = "S" AND ';
      1: strSQL := strSQL + '  (P.CTP_VEIOBO = "N" OR P.CTP_VEIOBO IS NULL OR P.CTP_VEIOBO = "") AND ';
    End;

    strSQL := strSQL + '  P.CTP_DTAPAG IS NULL AND ';
    strSQL := strSQL + '  P.CTP_DTALIB IS NULL AND ';
    strSQL := strSQL + '  P.CTP_SEQBAI = 0 ';

    strSQL := strSQL + fStrLocate(edtCodFor, arrFornec, 'P.CTP_CODFOR', 'CODFOR');

    strSQL := strSQL + fStrLocate(fraCentroCusto.edtCodEve, arrEvento, 'P.CTP_CODEVE', 'CODEVE');

    strSQL := strSQL + fStrLocate(edtCodEmp, arrEmp, 'P.CTP_CODEMP', 'CODEMP');

    strSQL := strSQL + '  AND LOCATE(P.CTP_CODEMP, ' + QuotedStr(strAceCtp) + ') > 0 ';

    If (Not fEmptyStr(edtCodPor.Text)) Then
      strSQL := strSQL + fStrLocate(edtCodPor, arrPortador, 'P.CTP_CODPOR', 'CODPOR')
    Else If fCfgSis('DACPOR', varBoolean) Then
    Begin
      strSQL := strSQL + '  AND (IFNULL(P.CTP_CODPOR, "") = "" ';
      strSQL := strSQL + '  OR LOCATE(P.CTP_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
    End;

    If (cbxOrigem.ItemIndex  = 0) Then
      strSQL := strSQL + '  AND L.CTP_NOMFRM = "frmCadCtaPagar" '
    Else If (cbxOrigem.ItemIndex  = 1) Then
      strSQL := strSQL + '  AND L.CTP_NOMFRM IS NULL ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
      strSQL := strSQL + '  AND P.CTP_DTACAD BETWEEN :DTCINI AND :DTCFIN ';

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenIni.Text)) Then
      strSQL := strSQL + '  AND P.CTP_DTAVEN BETWEEN :DTVINI AND :DTVFIN ';

    If edtVlrFin.Value <> 0 Then
      strSQL := strSQL + '  AND P.CTP_VALORI BETWEEN :VALINI AND :VALFIN ';

    strSQL := strSQL + fStrLocateLinGru(fraPlanoDeContas.MskCodCta, arrCentCusto, 'P.CTP_CODCTA', 'CODCTA');

    If Not fEmptyStr(strAutIncManCtp) Then
      strSQL := strSQL + '  AND P.AUTOINCREM = :AUTINC ';

    With qryCtaPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(strAutIncManCtp) Then
        ParamByName('AUTINC').AsString := strAutIncManCtp;

      pSetaParam(edtCodFor.Text, arrFornec, strFornec, 'CODFOR', qryCtaPag);
      pSetaParam(fraCentroCusto.edtCodEve.Text, arrEvento, strEvento, 'CODEVE', qryCtaPag);
      pSetaParam(edtCodEmp.Text, arrEmp, strEmp, 'CODEMP', qryCtaPag);
      pSetaParam(edtCodPor.Text, arrPortador, strPortador, 'CODPOR' , qryCtaPag);

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaCadIni.Text)) Then
      Begin
        ParamByName('DTCINI').AsDateTime := StrToDate(mskDtaCadIni.Text);
        ParamByName('DTCFIN').AsDateTime := StrToDate(mskDtaCadFin.Text);
      End;

      If Not fEmptyStr(fTiraCaracEspeciais(mskDtaVenIni.Text)) Then
      Begin
        ParamByName('DTVINI').AsDateTime := StrToDate(mskDtaVenIni.Text);
        ParamByName('DTVFIN').AsDateTime := StrToDate(mskDtaVenFin.Text);
      End;

      If edtVlrFin.Value <> 0 Then
      Begin
        ParamByName('VALINI').AsFloat := edtVlrIni.Value;
        ParamByName('VALFIN').AsFloat := edtVlrFin.Value;
      End;

      pSetaParam(fraPlanoDeContas.MskCodCta.Text, arrCentCusto ,strCentCusto ,'CODCTA', qryCtaPag);

      Open;

      Application.ProcessMessages;

      If Not IsEmpty Then
      Begin
        pSetaClient(qryCtaPag);
        cdsCtaPag.Open;
        With cdsCtaPag Do
        Begin
          (FieldByName('CTP_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTP_DESSUJ') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTP_JURSUJ') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTP_MULSUJ') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('CTP_VENDOR') As TFloatField).DisplayFormat := '#,##0.00';
          (FieldByName('TOTDUP')     As TFloatField).DisplayFormat := '#,##0.00';
          IndexFieldNames := 'CTP_DTAVEN;CTP_CODFOR;CTP_NUMDUP;CTP_CODEMP';
          First;
          Application.ProcessMessages;
          pCalculaTotalDuplicatas(edtQtdDuplicatas, edtValorTotal, False);

          Application.ProcessMessages;
          pCalculaTotalDuplicatas(edtQtdSelecionadas, edtTotalPago, True);

          {*********************************************************************}
          {* SE FOR UMA DUPLICATA INFORMADA NA MANUTENÇÃO JÁ SELECIONA A MESMA *}
          {*REQ*101495*******************************************************MO*}
          If Not fEmptystr(strAutIncManCtp) And
             blnVeioMntPagar Then
            pSelecionaDuplicata;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Não há duplicatas para serem liberadas!', ['&O k']);
        If (chkLimFil.Checked) Then
          pLimpaEdits;
        pLimpaEditsDuplicata;
        blnMudarFoco := False;
        pSetFocus(edtCodFor);
      End;

      Close;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCtpLiberacaoBaixa.pAtualizaTemporaria]');
    End;
  End;

  Application.ProcessMessages;
  cdsCtaPag.SetProvider(nil);
  FreeAndNil(dspCtaPag);
  FreeAndNil(qryCtaPag);
end;

procedure TfrmCtpLiberacaoBaixa.pCalculaTotalDuplicatas(edtQuant,
  edtTotal: TEditFocus; blnFiltrar: Boolean);
  Var
    cdsGen: TUniClientDataSet;
    fldVal: TAggregateField;
begin
  cdsGen := TUniClientDataSet.Create(Self);
  fldVal := TAggregateField.Create(Self);
  Try
    With fldVal Do
    Begin
      FieldName := 'FLDVAL';
      DataSet := cdsGen;
      DisplayFormat := '#,##0.00';
      Expression := 'SUM(TOTDUP)';
      Active := True;
    End;

    With cdsGen Do
    Begin
      Data := cdsCtaPag.Data;

      If blnFiltrar Then
      Begin
        Filtered := False;
        Filter := 'CTP_MARDES = ''M''';
        Filtered := True;
      End;

      AggregatesActive := True;

      If Not IsEmpty Then
      Begin
        edtTotal.Text    := FormatFloat('#,##0.00', fldVal.Value);
        edtQuant.Text    := IntToStr(RecordCount);
      End
      Else
      Begin
        edtTotal.Text    := '0,00';
        edtQuant.Text    := '0';
      End;
    End;
  Finally
    FreeAndNil(fldVal);
    FreeAndNil(cdsGen);
  End;
end;

procedure TfrmCtpLiberacaoBaixa.pCarregaCentroCusto;
begin
  pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.MskCodCta.Text);
  With qryConCta Do
  Begin
    fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfrmCtpLiberacaoBaixa.pCarregaEmpresa;
begin
  If Not fEmptyStr(edtCodEmp.Text) Then
  Begin
    edtNomEmp.Text := fRetNomeEmpresaSelec(edtCodEmp.Text);
    pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  End
  Else
    edtNomEmp.Clear;
end;

procedure TfrmCtpLiberacaoBaixa.pCarregaEventos;
begin
  If Not fEmptyStr(fraCentroCusto.edtCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.edtCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmCtpLiberacaoBaixa.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, edtCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
end;

procedure TfrmCtpLiberacaoBaixa.pCarregaPortador;
begin
  pPesquisaCadPor(qryConPor, qryConPor, edtCodPor.Text);
  With qryConPor Do
  Begin
    edtDesPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmCtpLiberacaoBaixa.pConcluiBusca;
begin
  If fEmptyStr(frmBaixaCtpBusca.objFiltro.strValor) Then
    exit;

  cdsCtaPag.Filter := '';
  strValorFiltro := frmBaixaCtpBusca.objFiltro.strValor;
  strCampoFiltro := frmBaixaCtpBusca.objFiltro.strCampo;
  If Not cdsCtaPag.FindFirst Then
    fMensagem('ATENÇÃO!', 'Não há duplicatas que atendam a busca!', ['&O k']);
end;

procedure TfrmCtpLiberacaoBaixa.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  If Not fEmptyStr(strCampoFiltro) Then
  begin
    if CompareText(strCampoFiltro, 'TOTDUP') = 0 then
      Accept := CompareText(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) = 0
    else
      Accept := (Pos(strValorFiltro, DataSet.FieldByName(strCampoFiltro).AsString) > 0);
  end;
end;

procedure TfrmCtpLiberacaoBaixa.pLimpaEdits;
begin
  pLimpaEditsDuplicata;

  edtNomFor.Clear;
  fraPlanoDeContas.edtDesCta.Clear;
  fraCentroCusto.edtDesEve.Clear;
  edtNomEmp.Clear;
  edtDesPor.Clear;

  mskDtaCadIni.Clear;
  mskDtaCadFin.Clear;
  mskDtaVenIni.Clear;
  mskDtaVenFin.Clear;
  fraPlanoDeContas.MskCodCta.Clear;
  edtCodFor.Clear;
  fraCentroCusto.edtCodEve.Clear;
  edtCodEmp.Clear;
  edtCodPor.Clear;
  edtVlrIni.Value := 0;
  edtVlrFin.Value := 0;
  rdgVeioBo.ItemIndex := 2;
  cbxOrigem.ItemIndex := 2;

  cdsCtaPag.AfterScroll := nil;
  Try
    cdsCtaPag.Filtered := False;
    cdsCtaPag.Close;
  Finally
    cdsCtaPag.AfterScroll := pAtualizaDados;
  End;
end;

procedure TfrmCtpLiberacaoBaixa.pLimpaEditsDuplicata;
begin
  edtQtdDuplicatas.Clear;
  edtQtdSelecionadas.Clear;
  edtTotalPago.Clear;
  edtValorTotal.Clear;

  edtCodCtaBai.Clear;
  edtDesCtaBai.Clear;
  edtCodEveBai.Clear;
  edtDesEveBai.Clear;

  edtCheque.Clear;
  edtVeioBoleto.Clear;
  edtPrevisao.Clear;

  edtHistor.Clear;
end;

procedure TfrmCtpLiberacaoBaixa.pLocalizaProximaDup;
begin
  If Not cdsCtaPag.FindNext Then
    fMensagem('ATENÇÃO!', 'Não há duplicatas que atendam a busca!', ['&O k']);
end;

procedure TfrmCtpLiberacaoBaixa.pMarcaDuplicata(blnMarcar: Boolean);
begin
  cdsCtaPag.Edit;
  cdsCtaPag.FieldByName('CTP_MARDES').AsString := IIF(blnMarcar, 'M', 'D');
  cdsCtaPag.Post;
end;

procedure TfrmCtpLiberacaoBaixa.pMarcarTodas(blnMarcar: Boolean);
begin
  With cdsCtaPag Do
  Begin
    Try
      DisableControls;

      First;
      While Not Eof Do
      Begin
        if blnMarcar And Not fEmpresaTemAcessoPortador(FieldByName('CTP_CODPOR').AsString,
                                                       VS_strCodEmp) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          cdsCtaPag.Edit;
          cdsCtaPag.FieldByName('CTP_MARDES').AsString := 'D';
          cdsCtaPag.Post;
        End Else
        pMarcaDuplicata(blnMarcar);

        Next;
      End;
      First;
    Finally
      EnableControls;
    End;
  End;

  pCalculaTotalDuplicatas(edtQtdSelecionadas, edtTotalPago, True);
end;

procedure TfrmCtpLiberacaoBaixa.pSelecionaDuplicata;
begin
  If cdsCtaPag.IsEmpty Then
    Exit;

  if Not fEmpresaTemAcessoPortador(cdsCtaPag.FieldByName('CTP_CODPOR').AsString,VS_strCodEmp) Then
  Begin
        fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
        Exit;
  End;

  If cdsCtaPag.FieldByName('CTP_MARDES').AsString <> 'M' Then
  Begin
    pMarcaDuplicata(True);
    pCalculaTotalDuplicatas(edtQtdSelecionadas, edtTotalPago, True);
  End
  Else
  Begin
    pMarcaDuplicata(False);
    pCalculaTotalDuplicatas(edtQtdSelecionadas, edtTotalPago, True);
  End;

  {******************************************}
  {* POSICIONA O CURSOR NO PRÓXIMO REGISTRO *}
  {***************************************ER*}
  dbgDuplicatasView.NavigatorButtons.Next.Click;
end;

end.
