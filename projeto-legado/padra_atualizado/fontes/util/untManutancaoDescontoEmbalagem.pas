unit untManutancaoDescontoEmbalagem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, strUtils, Uni,
  frxExportCSVTestabilidade, Vcl.Menus, Vcl.AppEvnts, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, untTypesSistema, cxProgressBar, dxCustomWizardControl,
  dxWizardControl,
  untCustomWizardControl,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, cxCheckBox, cxGridLevel, untZClient,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGridCitel, cxGrid, ComboBoxFocus, EditFocus, QColorLabel,
  Vcl.Mask, MaskEditFocus, Vcl.CheckLst,
  cxDataControllerConditionalFormattingRulesManagerDialog, dxScreenTip,
  Vcl.ComCtrls;

type
  TTipoEmbalagem = (teInserir, teExcluir );

  TfrmManutancaoDescontoEmbalagem = class(TfrmPai)
    dxWizardControl: TdxWizardControl;
    pageEmbalagens: TdxWizardControlPage;
    dxWizardControlPage2: TdxWizardControlPage;
    dxWizardControlPage3: TdxWizardControlPage;
    pnlIteEmb: TPanel;
    pnlFiltros: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label167: TLabel;
    Label14: TLabel;
    Label31: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    edtDesIte: TEditFocus;
    edtRefere: TEditFocus;
    edtCodUni: TEditFocus;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    edtPrdGru: TEditFocus;
    edtDesPrdPro: TEditFocus;
    edtGruCmp: TEditFocus;
    edtDesGruCmp: TEditFocus;
    cmbGiroEstoque: TComboBoxFocus;
    Label8: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    ColorLabel1: TColorLabel;
    Label13: TLabel;
    lbl50: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    edtCodAbr: TEditFocus;
    edtDesAbr: TEditFocus;
    edtClaIPI: TEditFocus;
    edtStatus: TEditFocus;
    edtExcIpi: TEditFocus;
    cxgProdutosLevel: TcxGridLevel;
    cxgProdutosTableView: TcxGridDBTableViewCitel;
    cxgProdutos: TcxGridCitel;
    cxgProdutosTableViewCODITE: TcxGridDBColumn;
    cxgProdutosTableViewDESITE: TcxGridDBColumn;
    cxgProdutosTableViewDESMAR: TcxGridDBColumn;
    cxgProdutosTableViewSIGUNI: TcxGridDBColumn;
    cxgProdutosTableViewSIMNAO: TcxGridDBColumn;
    cxgProdutosTableViewREFERE: TcxGridDBColumn;
    clbEmpresa: TCheckListBox;
    Label10: TLabel;
    pnlIteEmbTopo: TPanel;
    lbl22: TLabel;
    lbl23: TLabel;
    lbl25: TLabel;
    lblPrinCalcRom: TLabel;
    edtEmbFec: TEditFocus;
    edtDesFec: TEditFocus;
    cbxTabEmf: TComboBoxFocus;
    btnAdicionaIteEmb: TBitBtnLocked;
    btnCancelaIteEmb: TBitBtnLocked;
    cmbPriRom: TComboBoxFocus;
    cxgIteEmb: TcxGridCitel;
    cxgIteEmbTableView: TcxGridDBTableViewCitel;
    cxgIteEmbTableViewQTDEMB: TcxGridDBColumn;
    cxgIteEmbTableViewDESCON: TcxGridDBColumn;
    cxgIteEmbTableViewTABPRE: TcxGridDBColumn;
    cxgIteEmbTableViewPRIROM: TcxGridDBColumn;
    cxgIteEmbLevel: TcxGridLevel;
    pnlIteEmbBottom: TPanel;
    Label63: TLabel;
    Label125: TLabel;
    btnNext: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAdicionaIteEmbClick(Sender: TObject);
    procedure btnCancelaIteEmbClick(Sender: TObject);
    procedure cxgIteEmbTableViewDblClick(Sender: TObject);
    procedure cxgIteEmbTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure dxWizardControlPageChanging(Sender: TObject;
      ANewPage: TdxWizardControlCustomPage; var AAllow: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dxWizardControlPageChanged(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAbrKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodUniKeyPress(Sender: TObject; var Key: Char);
    procedure mskLinGruExit(Sender: TObject);
    procedure edtCodMarExit(Sender: TObject);
    procedure edtPrdGruExit(Sender: TObject);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtCodUniExit(Sender: TObject);
    procedure edtCodForExit(Sender: TObject);
    procedure edtCodAbrExit(Sender: TObject);
    procedure dxWizardControlButtonClick(Sender: TObject;
      AKind: TdxWizardControlButtonKind; var AHandled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtEmbFecEnter(Sender: TObject);
    procedure edtEmbFecExit(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
  private
    FdtaDtaDel: TDateTime;
    FenuTipEmb: TTipoEmbalagem;
    cdsIteEmb : TZClient;
    cdsCadIte : TZClient;

    arrLinGru : TConsultasArray;
    arrCodUni : TConsultasArray;
    arrCodMar : TConsultasArray;
    arrPrdGru : TConsultasArray;
    arrGruCmp : TConsultasArray;
    arrCodFor : TConsultasArray;
    arrCodAbr : TConsultasArray;

    strLinGru : String;
    strCodUni : String;
    strCodMar : String;
    strPrdGru : String;
    strGruCmp : String;
    strCodFor : String;
    strCodAbr : String;
    procedure pAbreIteEmb;
    procedure pChecaPrincipalRomaneio;
    procedure pGetTextItbTabPre(Sender: TField; var Text: String;Display: Boolean);
    procedure pSetTextItbTabPre(Sender: TField; const Text: String);
    procedure pGravaDados;
    procedure pCarregaEmpresas;
    procedure pReiniciaProcesso;

    function fGetSQLIteEmb: String;
    function fGetSQLCadIte: String;
    function fAbreDadosCadIte:Boolean;
    function fRetEmpresasSel: String;
    function fGravaProgresso(cxProgress : TCxProgressBar) : Boolean;
    procedure pCriarBackup(strCodEmp, strCodIte: String);
  public
    procedure TipoEmbalagem(enuTipEmb: TTipoEmbalagem);
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; Override;
  end;

var
  frmManutancaoDescontoEmbalagem: TfrmManutancaoDescontoEmbalagem;

implementation

{$R *.dfm}

uses untFuncoesSimples, untFuncoesConsulta, untConsultas, untGravando,
  System.Math;

procedure TfrmManutancaoDescontoEmbalagem.btnAdicionaIteEmbClick(Sender: TObject);
  Var
    strBookMark : TBookMark;
  function fEdtEmbFecText: Double;
  begin
    Result:= fStrToFloat(FormatFloat(fMskDigitos(2), fStrToFloat(edtEmbFec.Text)));
  end;
begin
  inherited;
  If (cdsIteEmb.Tag = Ord(dsInsert)) And (cdsIteEmb.RecordCount = 10) And
     (Not cdsIteEmb.Locate('ITB_QTDEMB', fEdtEmbFecText, [])) Then
  Begin
    fMensagem('','O limite de embalagens com desconto foi atingido!', ['&OK']);
    Exit;
  End;

  If Not fValidaPanel(pnlIteEmbTopo, True) Then
    Exit;

  If cmbPriRom.ItemIndex = 0 Then
  Begin
    Try
      strBookMark := cdsIteEmb.GetBookMark;
      cdsIteEmb.DisableControls;
      cdsIteEmb.First;
      While Not cdsIteEmb.Eof Do
      Begin
        If (cdsIteEmb.FieldByName('ITB_PRIROM').AsString = 'S') Then
        Begin
          cdsIteEmb.Edit;
          cdsIteEmb.FieldByName('ITB_PRIROM').AsString := 'N';
          cdsIteEmb.Post;
          Break;
        End;
        cdsIteEmb.Next;
      End;
    Finally
      cdsIteEmb.BookMark := strBookMark;
      cdsIteEmb.EnableControls;
    End;
  End;

  If (cbxTabEmf.Text <> 'TODAS') then
  begin
    If (cdsIteEmb.Tag = Ord(dsInsert)) And (Not cdsIteEmb.Locate('ITB_QTDEMB;ITB_TABPRE', VarArrayOf([fEdtEmbFecText, cbxTabEmf.Text]), [])) Then
    Begin
      If cdsIteEmb.Locate('ITB_QTDEMB', fEdtEmbFecText, []) and (cdsIteEmb.FieldByName('ITB_TABPRE').AsString = '')  then
      begin
        {Já existe essa quantidade cadastrada, abortar!}
        fMensagem('Aviso', 'Não é possível adicionar essa quantidade, pois a mesma já foi adicionada em "TODAS" as tabelas!', ['&Ok']);
        Exit;
      End
      Else
      begin
        cdsIteEmb.Insert;
        cdsIteEmb.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ITEEMB', VS_strCodEmp);
        cdsIteEmb.FieldByName('ITB_CODITE').AsString  := '';
        cdsIteEmb.FieldByName('ITB_CODEMP').AsString  := VS_strCodEmp;
      End;
    End
    Else
      cdsIteEmb.Edit;
  End
  Else
  Begin
    If (cdsIteEmb.Tag = Ord(dsInsert)) And (Not cdsIteEmb.Locate('ITB_QTDEMB;ITB_TABPRE', VarArrayOf([fEdtEmbFecText, '']), [])) Then
    Begin
      If cdsIteEmb.Locate('ITB_QTDEMB', fEdtEmbFecText, []) then
      begin
        {Já existe essa quantidade cadastrada, abortar!}
        fMensagem('Aviso', 'Não é possível adicionar essa quantidade em "TODAS" as tabelas, pois a mesma já foi adicionada em tabela específica!', ['&Ok']);
        Exit;
      End
      Else
      Begin
        cdsIteEmb.Insert;
        cdsIteEmb.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('ITEEMB', VS_strCodEmp);
        cdsIteEmb.FieldByName('ITB_CODITE').AsString  := '';
        cdsIteEmb.FieldByName('ITB_CODEMP').AsString  := VS_strCodEmp;
      End;
    End
    Else
      cdsIteEmb.Edit;
  end;

  cdsIteEmb.FieldByName('ITB_QTDEMB').AsFloat   := fEdtEmbFecText;
  cdsIteEmb.FieldByName('ITB_DESCON').AsFloat   := fStrToFloat(edtDesFec.Text);
  cdsIteEmb.FieldByName('ITB_TABPRE').AsString  := IfThen(cbxTabEmf.Text <> 'TODAS', cbxTabEmf.Text, '');
  cdsIteEmb.FieldByName('ITB_PRIROM').AsString  := IfThen(cmbPriRom.ItemIndex = 0, 'S', 'N');

  cdsIteEmb.Post;
  btnCancelaIteEmb.Click;

  pChecaPrincipalRomaneio;

end;

procedure TfrmManutancaoDescontoEmbalagem.btnCancelaIteEmbClick(
  Sender: TObject);
begin
  inherited;
  edtEmbFec.Clear;
  edtDesFec.Clear;
  cbxTabEmf.ItemIndex := 0;
  cmbPriRom.ItemIndex := 1;
  cdsIteEmb.Tag := Ord(dsInsert);
  cxgIteEmb.Enabled := True;
  pSetFocus(edtEmbFec);

end;

procedure TfrmManutancaoDescontoEmbalagem.btnNextClick(Sender: TObject);
begin
  inherited;
  If dxWizardControl.ActivePage.PageIndex <> 2 Then
    dxWizardControl.GoToNextPage
  Else
    dxWizardControl.Buttons.Finish.Click;
end;

procedure TfrmManutancaoDescontoEmbalagem.cxgIteEmbTableViewDblClick(
  Sender: TObject);
begin
  inherited;
  If (not cdsIteEmb.Active) Or (cdsIteEmb.RecordCount <= 0) Then
    Exit;

  cxgIteEmb.Enabled := False;
  edtEmbFec.Text := FormatFloat(fMskDigitos(2), cdsIteEmb.FieldByName('ITB_QTDEMB').AsFloat);
  edtDesFec.Text := FormatFloat(fMskDigitos(4), cdsIteEmb.FieldByName('ITB_DESCON').AsFloat);
  If (cdsIteEmb.FieldByName('ITB_PRIROM').AsString = 'S') Then
    cmbPriRom.ItemIndex := 0
  Else
    cmbPriRom.ItemIndex := 1;

  If fEmptyStr(cdsIteEmb.FieldByName('ITB_TABPRE').AsString) Then
    cbxTabEmf.ItemIndex := 0
  Else
    cbxTabEmf.ItemIndex := cbxTabEmf.Items.IndexOf(cdsIteEmb.FieldByName('ITB_TABPRE').AsString);

  cdsIteEmb.Tag := Ord(dsEdit);
  pSetFocus(edtEmbFec);
end;

procedure TfrmManutancaoDescontoEmbalagem.cxgIteEmbTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Shift = [] Then
  Begin
    If Key = VK_DELETE Then
    Begin
      If fMensagem('', 'Deseja apagar o registro?', ['&Sim', '&Não'],2)=1 Then
      Begin
        cdsIteEmb.Delete;
        pChecaPrincipalRomaneio;
      End;
    End
    Else
    If Key = VK_RETURN Then
    Begin
      cxgIteEmbTableViewDblClick(Nil);
    End;
  End;
end;

procedure TfrmManutancaoDescontoEmbalagem.dxWizardControlButtonClick(
  Sender: TObject; AKind: TdxWizardControlButtonKind; var AHandled: Boolean);
begin
  inherited;
  case AKind of
    wcbkFinish:
    Begin
      if (FenuTipEmb = teInserir)
        Or (fMensagem('Atenção!','Deseja realmente excluir os descontos?', ['&Sim', '&Não']) = 1) Then
      pGravaDados;
    End;
  End;
end;

procedure TfrmManutancaoDescontoEmbalagem.dxWizardControlPageChanged(Sender: TObject);
begin
  inherited;
  btnNext.Caption := '&Próximo';
  If dxWizardControl.ActivePage.PageIndex = 1 Then
    pSetFocus(mskLinGru);
  If dxWizardControl.ActivePage.PageIndex = 2 Then
    btnNext.Caption := '&Confirmar';
end;

procedure TfrmManutancaoDescontoEmbalagem.dxWizardControlPageChanging(
  Sender: TObject; ANewPage: TdxWizardControlCustomPage; var AAllow: Boolean);
begin
  inherited;
  If (dxWizardControl.ActivePage.PageIndex = 0)
    And ((FenuTipEmb = teInserir))
  Then
  Begin
    AAllow := cdsIteEmb.RecordCount > 0;
    If not AAllow Then
      fMensagem('','Escolha pelo menos uma embalagem para continuar!', ['&OK']);
  End

  Else
  If (dxWizardControl.ActivePage.PageIndex = 1) And
     (ANewPage.PageIndex = 2) Then
  Begin
    AAllow := fValidaPanel(pnlFiltros, True);
    If AAllow Then
    Begin
      If not fAbreDadosCadIte Then
      Begin
        If FenuTipEmb = teInserir Then
          fMensagem('', 'Não há dados para atualizar!', ['&Ok'])
        Else
          fMensagem('', 'Não há dados para excluir!', ['&Ok']);
        AAllow := False;
      End;
    End;
  End;

end;

procedure TfrmManutancaoDescontoEmbalagem.edtCodAbrExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAbr, edtDesAbr, arrCodAbr, fRetDesAbfIcm, Nil, 'da Abreviação Fiscal');
end;

procedure TfrmManutancaoDescontoEmbalagem.edtCodAbrKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqAbrevFiscal(Self, edtCodAbr, edtDesAbr, Nil, Key, arrCodAbr) Then
  Begin
    If fValidaCampos(edtCodAbr, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmManutancaoDescontoEmbalagem.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor, edtNomFor, arrCodFor, fRetNomFornecedor, nil, 'do Fornecedor');
end;

procedure TfrmManutancaoDescontoEmbalagem.edtCodForKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrCodFor) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmManutancaoDescontoEmbalagem.edtCodMarExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodMar, edtDesMar, arrCodMar, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmManutancaoDescontoEmbalagem.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrCodMar) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmManutancaoDescontoEmbalagem.edtCodUniExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodUni, Nil, arrCodUni, fRetNomUnidade, Nil, 'da Unidade');
end;

procedure TfrmManutancaoDescontoEmbalagem.edtCodUniKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqUnidade(Self, edtCodUni, nil, nil, nil, Key, arrCodUni) Then
  Begin
    If fvalidaCampos(edtCodUni,False) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmManutancaoDescontoEmbalagem.edtEmbFecEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'Os produtos com unidade não fracionada, será truncada a ' +
                     'quantidade';
end;

procedure TfrmManutancaoDescontoEmbalagem.edtEmbFecExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmManutancaoDescontoEmbalagem.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmManutancaoDescontoEmbalagem.edtGruCmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmManutancaoDescontoEmbalagem.edtPrdGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtPrdGru, edtDesPrdPro, arrPrdGru, fRetNomeGrupoProduto, nil, 'do Grupo de Produto');
end;

procedure TfrmManutancaoDescontoEmbalagem.edtPrdGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdPro, Nil, Key, arrPrdGru) Then
  Begin
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmManutancaoDescontoEmbalagem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (dxWizardControl.ActivePage.PageIndex <> 0) Or
     ((dxWizardControl.ActivePage.PageIndex = 0) And (cdsIteEmb.RecordCount > 0)) Then
  Begin
    Action := caNone;
    If fMensagem('', 'Deseja cancelar a operação?', ['&Sim', '&Não'],2) = 1 Then
    Begin
      pReiniciaProcesso;
      If (FenuTipEmb = teExcluir)
        And (dxWizardControl.ActivePage = dxWizardControlPage2) Then
        Action := caFree;
    End;
  End;
end;

procedure TfrmManutancaoDescontoEmbalagem.FormCreate(Sender: TObject);
  Var
    intTabPre : Integer;
begin
  inherited;
  FenuTipEmb := teInserir;
  edtCodAbr.MaxLength :=  IIf(fCfgSis('USASAN') = 'S', 7, 3);
  dxWizardControl.ContentColor := Self.Color;
  cbxTabEmf.Clear;
  cbxTabEmf.Items.Add('TODAS');
  For intTabPre := 1 To Length(VS_strTabPrc) Do
  Begin
    If VS_strTabPrc[intTabPre] = 'S' Then
      cbxTabEmf.Items.Add(IntToStr(intTabPre));
  End;
  cbxTabEmf.ItemIndex := 0;

  cdsIteEmb := TZClient.Create(Self, fGetSQLIteEmb);
  cxgIteEmbTableView.DataController.DataSource := cdsIteEmb.dtsSource;

  edtDesFec.EditFormat:= fMskDigitos(4);
  cmbPriRom.Visible := fCfgSis('VOLROM', varInteger) = 2;
  lblPrinCalcRom.Visible := fCfgSis('VOLROM', varInteger) = 2;
  cxgIteEmbTableViewPRIROM.Visible := fCfgSis('VOLROM', varInteger) = 2;
  If Not cmbPriRom.Visible Then
  Begin
    btnAdicionaIteEmb.Left := btnAdicionaIteEmb.Left - lblPrinCalcRom.Width;
    btnCancelaIteEmb.Left  := btnCancelaIteEmb.Left  - lblPrinCalcRom.Width;
  End;

  pAbreIteEmb;

  cdsCadIte := TZClient.Create(Self);
  cxgProdutosTableView.DataController.DataSource := cdsCadIte.dtsSource;
end;

procedure TfrmManutancaoDescontoEmbalagem.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cdsIteEmb);
  inherited;
end;

procedure TfrmManutancaoDescontoEmbalagem.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
//  inherited;
end;

procedure TfrmManutancaoDescontoEmbalagem.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtEmbFec);
//  dxWizardControl.Buttons.Next.Enabled := False;
  btnNext.Enabled := False;
  dxWizardControl.Pages[0].Activate;
  dxWizardControl.OnPageChanging := dxWizardControlPageChanging;
  dxWizardControl.OnPageChanged  := dxWizardControlPageChanged;

  If FenuTipEmb = teExcluir Then
  Begin
    dxWizardControl.Pages[0].PageVisible := False;
    dxWizardControl.Pages[1].Activate;
    //dxWizardControl.Buttons.Next.Enabled := True;
    btnNext.Enabled := True;
    dxWizardControlPage3.Header.Description := 'Confirme os produtos que serão excluídos. ' +
      'Você pode desmarcar os produtos que não deseja excluir.';
    dxWizardControlPage3.Header.Description := 'Utilize os filtros para escolher ' +
      'os produtos que serão excluidos.';
  End;

  pCarregaEmpresas;
end;

function TfrmManutancaoDescontoEmbalagem.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;
  If Inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If blnBuscaPorChave And (Sender = edtEmbFec) Then
    Begin
      If fStrToFloat(edtEmbFec.Text) <= 0 Then
      Begin
        Result := False;
        fMensagem('','A quantidade deve ser maior que zero!', ['&Ok']);
      End;
    End

    Else If blnBuscaPorChave And (Sender = edtDesFec) Then
    Begin
      If fStrToFloat(edtDesFec.Text) <= 0 Then
      Begin
        Result := False;
        fMensagem('','O percentual de desconto deve ser maior que zero!', ['&Ok']);
      End;
    End

    Else
    If Sender = edtStatus Then
    Begin
      Result := Pos(edtStatus.Text, 'S_N_T_') > 0;
      If not Result Then
        fMensagem('', 'Valor inválido, escolha entre (S)im, (N)ão ou (T)odos!', ['&Ok']);
    End;

  End;
end;

procedure TfrmManutancaoDescontoEmbalagem.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGru, arrLinGru, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);
end;

procedure TfrmManutancaoDescontoEmbalagem.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupo(Self, mskLinGru, edtDesGru, Nil, Key, arrLinGru) Then
  Begin
    if fValidaCampos(mskLinGru, True) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmManutancaoDescontoEmbalagem.pAbreIteEmb;
Begin
  cdsIteEmb.qryQuery.Close;
  cdsIteEmb.fAbreClient(True, 'TfrmManutancaoDescontoEmbalagem.pAbreIteEmb');

  TFloatField(cdsIteEmb.FieldByName('ITB_DESCON')).DisplayFormat := fMskDigitos(4);
  TFloatField(cdsIteEmb.FieldByName('ITB_QTDEMB')).DisplayFormat := fMskDigitos(2);
  TFloatField(cdsIteEmb.FieldByName('ITB_QTDEMB')).Alignment     := taCenter;
  TFloatField(cdsIteEmb.FieldByName('ITB_TABPRE')).Alignment     := taCenter;
  cdsIteEmb.FieldByName('ITB_TABPRE').OnGetText := pGetTextItbTabPre;
  cdsIteEmb.FieldByName('ITB_TABPRE').OnSetText := pSetTextItbTabPre;

  edtEmbFec.EditFormat := fMskDigitos(2);

  If cdsIteEmb.IndexDefs.Count = 0 Then
  Begin
    With cdsIteEmb.IndexDefs.AddIndexDef Do
    Begin
      Name   := 'IDX_cdsIteEmb';
      Fields := 'ITB_QTDEMB';
      Options:= [ixDescending];
    End;
  End;
  cdsIteEmb.IndexName := 'IDX_cdsIteEmb';

  cdsIteEmb.Tag := Ord(dsInsert);
End;

procedure TfrmManutancaoDescontoEmbalagem.pChecaPrincipalRomaneio;
  Var
    strBookMark : TBookMark;
    blnPriRom   : Boolean;
Begin
  If (not cdsIteEmb.Active) or (cdsIteEmb.RecordCount <= 0) Then
    Exit;
  //Checa se existe pelo menos um principal de Romaneio
  blnPriRom := False;
  Try
    strBookMark := cdsIteEmb.GetBookMark;
    cdsIteEmb.DisableControls;
    cdsIteEmb.First;
    While Not cdsIteEmb.Eof Do
    Begin
      If (cdsIteEmb.FieldByName('ITB_PRIROM').AsString = 'S') Then
      Begin
        blnPriRom := True;
        Break;
      End;
      cdsIteEmb.Next;
    End;

    If Not blnPriRom Then
    Begin
      cdsIteEmb.First;
      cdsIteEmb.Edit;
      cdsIteEmb.FieldByName('ITB_PRIROM').AsString := 'S';
      cdsIteEmb.Post;
    End;
  Finally
    cdsIteEmb.BookMark := strBookMark;
    cdsIteEmb.EnableControls;
  End;

  //dxWizardControl.Buttons.Next.Enabled := (cdsIteEmb.RecordCount > 0) ;
  btnNext.Enabled := (cdsIteEmb.RecordCount > 0) ;
End;

procedure TfrmManutancaoDescontoEmbalagem.pSetTextItbTabPre(Sender : TField; Const Text : String);
Begin
  If (Sender.DataSet.RecordCount <= 0) then
    Exit;

  If (Text = 'TODAS') Or fEmptyStr(Text) Then
    Sender.Clear;

End;

procedure TfrmManutancaoDescontoEmbalagem.TipoEmbalagem(
  enuTipEmb: TTipoEmbalagem);
begin
  FenuTipEmb := enuTipEmb;
end;

procedure TfrmManutancaoDescontoEmbalagem.pGetTextItbTabPre(Sender : TField; var Text : String; Display : Boolean);
Begin
  If (Sender.DataSet.RecordCount <= 0) then
    Exit;

  If fEmptyStr(Sender.AsString) Then
    Text := 'TODAS'
  Else
    Text := Sender.AsString;
End;

function TfrmManutancaoDescontoEmbalagem.fGetSQLIteEmb : String;
Begin
  Result := '';
  Result := Result + ' SELECT AUTOINCREM,         ';
  Result := Result + '        ITB_CODITE,         ';
  Result := Result + '        ITB_CODEMP,         ';
  Result := Result + '        ITB_QTDEMB,         ';
  Result := Result + '        ITB_DESCON,         ';
  Result := Result + '        ITB_TABPRE,         ';
  Result := Result + '        ITB_PRIROM          ';
  Result := Result + ' FROM ITEEMB                ';
  Result := Result + ' WHERE FALSE                ';
  Result := Result + ' ORDER BY ITB_QTDEMB DESC   ';
End;

function TfrmManutancaoDescontoEmbalagem.fGetSQLCadIte: String;
begin
  Result := '';
  Result := Result + ' SELECT I.ITE_CODITE AS CODITE,                     ';
  Result := Result + '        I.ITE_DESITE AS DESITE,                     ';
  Result := Result + '        I.ITE_REFERE AS REFERE,                     ';
  Result := Result + '          MAR_DESMAR AS DESMAR,                     ';
  Result := Result + '          UNI_SIGUNI AS SIGUNO,                     ';
  Result := Result + '          "S"        AS SIMNAO                      ';
  Result := Result + ' FROM ITEGER G                                      ';
  Result := Result + ' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE ';
  If FenuTipEmb = teExcluir Then
  Begin
    Result := Result +  ' INNER JOIN ITEEMB ON ITB_CODITE = G.ITE_CODITE ';
    Result := Result +  '                 AND ITB_CODEMP = G.ITE_CODEMP ';
  End;
  Result := Result + ' LEFT  JOIN CADMAR   ON   MAR_CODMAR = I.ITE_CODMAR ';
  Result := Result + ' LEFT  JOIN CADUNI   ON   UNI_CODUNI = I.ITE_CODUNI ';
  Result := Result + ' WHERE G.ITE_CODEMP = :CODEMP                       ';
  Result := Result + fStrLocateLinGru(mskLinGru, arrLinGru, 'I.ITE_CODGRU', 'CODGRU');
  Result := Result + fStrLocate(edtCodMar, arrCodMar, 'I.ITE_CODMAR', 'CODMAR');
  Result := Result + fStrLocate(edtPrdGru, arrPrdGru, 'I.ITE_PRDGRU', 'PRDGRU');
  Result := Result + fStrLocate(edtGruCmp, arrGruCmp, 'I.ITE_GRUCMP', 'GRUCMP');
  Result := Result + fStrLocate(edtCodFor, arrCodFor, 'I.ITE_CODFOR', 'CODFOR');
  Result := Result + fStrLocate(edtCodUni, arrCodUni, 'I.ITE_CODUNI', 'CODUNI');

  If fCfgSIs('TIPABF') = '1' Then
    Result := Result + fStrLocate(edtCodAbr, arrCodAbr, 'I.ITE_CODABF', 'CODABF')
  Else
    Result := Result + fStrLocate(edtCodAbr, arrCodAbr, 'G.ITE_CODABF', 'CODABF');

  If Not fEmptyStr(edtDesIte.Text) Then
    Result := Result + ' AND I.ITE_DESITE LIKE :DESITE ';

  If Not fEmptyStr(edtRefere.Text) Then
    Result := Result + ' AND I.ITE_REFERE LIKE :REFERE ';

  If Not fEmptyStr(edtClaIPI.Text) Then
    Result := Result + ' AND LEFT(I.ITE_CLAIPI,'+IntToStr(Length(edtClaIPI.Text))+') = :CLAIPI ';

  If Not fEmptyStr(edtExcIpi.Text) Then
    Result := Result + ' AND I.ITE_EXCIPI = :EXCIPI ';

  If (Pos(edtStatus.Text, 'SN') > 0) Then
    Result := Result + ' AND I.ITE_ITEATI = :ITEATI ';

  If Not fEmptyStr(cmbGiroEstoque.Text) then
    Result := Result + ' AND I.ITE_NVLGIR = :NVLGIR ';

  Result := Result + ' ORDER BY I.ITE_DESITE ';

end;

function TfrmManutancaoDescontoEmbalagem.fAbreDadosCadIte : Boolean;
Begin
  cdsCadIte.qryQuery.Close;
  cdsCadIte.qryQuery.SQL.Clear;
  cdsCadIte.qryQuery.SQL.Add(fGetSQLCadIte);

  cdsCadIte.qryQuery.ParamByName('CODEMP').AsString := VS_strCodEmp;

  pSetaParam(mskLinGru.Text, arrLinGru, strLinGru, 'CODGRU', cdsCadIte.qryQuery);
  pSetaParam(edtCodMar.Text, arrCodMar, strCodMar, 'CODMAR', cdsCadIte.qryQuery);
  pSetaParam(edtPrdGru.Text, arrPrdGru, strPrdGru, 'PRDGRU', cdsCadIte.qryQuery);
  pSetaParam(edtGruCmp.Text, arrGruCmp, strGruCmp, 'GRUCMP', cdsCadIte.qryQuery);
  pSetaParam(edtCodFor.Text, arrCodFor, strCodFor, 'CODFOR', cdsCadIte.qryQuery);
  pSetaParam(edtCodAbr.Text, arrCodAbr, strCodAbr, 'CODABF', cdsCadIte.qryQuery);
  pSetaParam(edtCodUni.Text, arrCodUni, strCodUni, 'CODUNI', cdsCadIte.qryQuery);

  If Not fEmptyStr(edtDesIte.Text) Then
    cdsCadIte.qryQuery.ParamByName('DESITE').AsString := edtDesIte.Text + '%';

  If Not fEmptyStr(edtRefere.Text) Then
    cdsCadIte.qryQuery.ParamByName('REFERE').AsString := edtRefere.Text + '%';

  If Not fEmptyStr(edtClaIPI.Text) Then
    cdsCadIte.qryQuery.ParamByName('CLAIPI').AsString := edtClaIPI.Text + '%';

  If Not fEmptyStr(edtExcIpi.Text) Then
    cdsCadIte.qryQuery.ParamByName('EXCIPI').AsString := edtExcIpi.Text;

  If (Pos(edtStatus.Text, 'SN') > 0) Then
    cdsCadIte.qryQuery.ParamByName('ITEATI').AsString := edtStatus.Text;

  If Not fEmptyStr(cmbGiroEstoque.Text) then
    cdsCadIte.qryQuery.ParamByName('NVLGIR').AsString := cmbGiroEstoque.Text;

  cdsCadIte.fAbreClient(True, 'TfrmManutancaoDescontoEmbalagem.pAbreDadosCadIte');

  Result := (cdsCadIte.RecordCount > 0);

End;

procedure TfrmManutancaoDescontoEmbalagem.pCarregaEmpresas;
  Var
    qryGen: TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;
    With qryGen, SQL Do
    Begin
      clbEmpresa.Items.Clear;
      Clear;
      Add('SELECT CONCAT(EMP_CODEMP," - ", EMP_NOMEMP) AS EMPNOM FROM CADEMP ORDER BY EMP_CODEMP ');
      Open;
      First;
      While Not Eof Do
      Begin
        clbEmpresa.Items.Add(FieldByName('EMPNOM').AsString);
        Next;
      End;
      clbEmpresa.CheckAll(cbChecked, False, False);

    End;

    clbEmpresa.Enabled := (fCfgSis('TPDCEM', varString) <> '2');
  Finally
    FreeAndNil(qryGen);
  End;
End;

function TfrmManutancaoDescontoEmbalagem.fRetEmpresasSel: String;
  Var
    intContador : Integer;
Begin
  Result := '';
  For intContador := 0 To clbEmpresa.Items.Count -1 Do
  Begin
    If clbEmpresa.Checked[intContador] Then
      Result := Result + LeftStr(clbEmpresa.Items[intContador],3) + '_';
  End;
End;

procedure TfrmManutancaoDescontoEmbalagem.pGravaDados;
Begin
  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGravaProgresso;
    frmGravando.ShowModal;
  Finally
    FreeAndNil(frmGravando);
  End;

End;

procedure TfrmManutancaoDescontoEmbalagem.pCriarBackup(strCodEmp, strCodIte: String);
Var
  qryBackup: TUniQuery;
Begin
  qryBackup   := fCriaQuery;
  Try
    qryBackup.SQL.Clear;
    qryBackup.SQL.Add('INSERT INTO DEL_ITEEMB');
    qryBackup.SQL.Add('(AUTOINCREM,');
    qryBackup.SQL.Add('ITB_CODEMP,');
    qryBackup.SQL.Add('ITB_CODITE,');
    qryBackup.SQL.Add('ITB_DESCON,');
    qryBackup.SQL.Add('ITB_PRIROM,');
    qryBackup.SQL.Add('ITB_QTDEMB,');
    qryBackup.SQL.Add('ITB_TABPRE,');
    qryBackup.SQL.Add('OPEDEL,');
    qryBackup.SQL.Add('DTADEL,');
    qryBackup.SQL.Add('HORDEL)');
    qryBackup.SQL.Add('SELECT ');
    qryBackup.SQL.Add('AUTOINCREM,');
    qryBackup.SQL.Add('ITB_CODEMP,');
    qryBackup.SQL.Add('ITB_CODITE,');
    qryBackup.SQL.Add('ITB_DESCON,');
    qryBackup.SQL.Add('ITB_PRIROM,');
    qryBackup.SQL.Add('ITB_QTDEMB,');
    qryBackup.SQL.Add('ITB_TABPRE,');
    qryBackup.SQL.Add(':OPEDEL,');
    qryBackup.SQL.Add(':DTADEL,');
    qryBackup.SQL.Add(':HORDEL');
    qryBackup.SQL.Add('FROM ITEEMB WHERE');
    qryBackup.SQL.Add('ITB_CODITE = :CODITE');
    qryBackup.SQL.Add('AND ITB_CODEMP = :CODEMP');
    qryBackup.ParamByName('CODEMP').AsString := strCodEmp;
    qryBackup.ParamByName('CODITE').AsString := strCodIte;
    qryBackup.ParamByName('OPEDEL').AsString := strLoginUsuarioLogado;
    qryBackup.ParamByName('DTADEL').AsDateTime := FdtaDtaDel;
    qryBackup.ParamByName('HORDEL').AsString := FormatDateTime('hh:nn:ss', FdtaDtaDel);
    qryBackup.ExecSQL;
  Finally
    FreeAndNil(qryBackup);
  End;
End;

function TfrmManutancaoDescontoEmbalagem.fGravaProgresso(cxProgress: TCxProgressBar): Boolean;
  Var
    qryEmpresa : TUniQuery;
    qryInsert   : TUniQuery;
    qryDelete   : TUniQuery;
    blnUnidadeEFracionada: Boolean;
    blnInserirDesconto: Boolean;
Begin
  Result := True;
  Try
    FdtaDtaDel := fNow;
    blnInserirDesconto := FenuTipEmb = teInserir;

    qryEmpresa := fCriaQuery;
    With qryEmpresa, SQL Do
    Begin
      Close;
      Clear;
      Add(' SELECT EMP_CODEMP FROM CADEMP WHERE LOCATE(EMP_CODEMP, :CODEMP) > 0 ');
      ParamByName('CODEMP').AsString := fRetEmpresasSel;
      Open;
    End;

    qryInsert   := fCriaQuery;
    With qryInsert, SQL Do
    Begin
      Close;
      Clear;
      Add(' INSERT INTO ITEEMB ( AUTOINCREM, ');
      Add('                      ITB_CODITE, ');
      Add('                      ITB_CODEMP, ');
      Add('                      ITB_QTDEMB, ');
      Add('                      ITB_DESCON, ');
      Add('                      ITB_TABPRE, ');
      Add('                      ITB_PRIROM  ');
      Add('                     ) VALUES (   ');
      Add('                      :AUTINC,    ');
      Add('                      :CODITE,    ');
      Add('                      :CODEMP,    ');
      Add('                      :QTDEMB,    ');
      Add('                      :DESCON,    ');
      Add('                      :TABPRE,    ');
      Add('                      :PRIROM)    ');
    End;

    qryDelete   := fCriaQuery;
    With qryDelete, SQL Do
    Begin
      Close;
      Clear;
      Add(' DELETE FROM ITEEMB         ');
      Add(' WHERE ITB_CODITE = :CODITE ');
      Add('   AND ITB_CODEMP = :CODEMP ');
    End;

    Try
      fStartTransaction;

      cxProgress.Properties.Max := cdsCadIte.RecordCount * qryEmpresa.RecordCount;

      cdsCadIte.DisableControls;
      cdsCadIte.Filter  := 'SIMNAO = ' + QuotedStr('S');
      cdsCadIte.Filtered:= True;
      cdsCadIte.First;
      While Not cdsCadIte.Eof  Do
      Begin
        blnUnidadeEFracionada := fUnidadeDoProdutoEhFracionaria(cdsCadIte.FieldByName('CODITE').AsString);

        qryEmpresa.First;
        While Not qryEmpresa.Eof Do
        Begin
          If Not blnInserirDesconto Then
            pCriarBackup(qryEmpresa.FieldByName('EMP_CODEMP').AsString,
              cdsCadIte.FieldByName('CODITE').AsString);

          qryDelete.ParamByName('CODITE').AsString := cdsCadIte.FieldByName('CODITE').AsString;
          qryDelete.ParamByName('CODEMP').AsString := qryEmpresa.FieldByName('EMP_CODEMP').AsString;
          qryDelete.ExecSQL;

          If blnInserirDesconto Then
          Begin
            cdsIteEmb.First;
            While Not cdsIteEmb.Eof Do
            Begin
              qryInsert.ParamByName('AUTINC').AsString := fRetAutoIncrem('ITEEMB', qryEmpresa.FieldByName('EMP_CODEMP').AsString);
              qryInsert.ParamByName('CODITE').AsString := cdsCadIte.FieldByName('CODITE').AsString;
              qryInsert.ParamByName('CODEMP').AsString := qryEmpresa.FieldByName('EMP_CODEMP').AsString;
              If blnUnidadeEFracionada Then
                qryInsert.ParamByName('QTDEMB').AsFloat := cdsIteEmb.FieldByName('ITB_QTDEMB').AsFloat
              Else
                qryInsert.ParamByName('QTDEMB').AsInteger := Floor(cdsIteEmb.FieldByName('ITB_QTDEMB').AsFloat);
              qryInsert.ParamByName('DESCON').AsFloat  := cdsIteEmb.FieldByName('ITB_DESCON').AsFloat;
              qryInsert.ParamByName('TABPRE').AsString := cdsIteEmb.FieldByName('ITB_TABPRE').AsString;
              qryInsert.ParamByName('PRIROM').AsString := cdsIteEmb.FieldByName('ITB_PRIROM').AsString;
              qryInsert.ExecSql;

              cdsIteEmb.Next;
            End;
          End;

          qryEmpresa.Next;

          cxProgress.Position := cxProgress.Position + 1;
          If (Trunc(cxProgress.Position) Mod 10) = 0 Then
            Application.ProcessMessages;
        End;

        cdsCadIte.Next;

      End;

      fCommit;

    Except
      On E : Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(E.Message, '');
      End;
    End;

  Finally
    FreeAndNil(qryEmpresa);
    FreeAndNil(qryInsert  );
    FreeAndNil(qryDelete  );

    cdsCadIte.EnableControls;
    cdsCadIte.Filtered:= False;
    cdsCadIte.Filter  := '';
  End;

  If Result Then
    pReiniciaProcesso;

end;

procedure TfrmManutancaoDescontoEmbalagem.pReiniciaProcesso;
Begin
  mskLinGru.Clear;
  edtDesGru.Clear;
  edtDesIte.Clear;
  edtCodUni.Clear;
  edtRefere.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;
  edtPrdGru.Clear;
  edtDesPrdPro.Clear;
  edtGruCmp.Clear;
  edtDesGruCmp.Clear;
  cmbGiroEstoque.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
  edtCodAbr.Clear;
  edtDesAbr.Clear;
  edtClaIPI.Clear;
  edtExcIpi.Clear;
  edtStatus.Text := 'T';

  pCarregaEmpresas;
  pAbreIteEmb;

  If FenuTipEmb = teInserir Then
  Begin
    dxWizardControl.Pages[0].Activate;
    dxWizardControl.Buttons.Next.Enabled := False;
  End
  Else
  Begin
    dxWizardControl.Pages[1].Activate;
  End;

  pSetFocus(edtEmbFec);
End;


end.

