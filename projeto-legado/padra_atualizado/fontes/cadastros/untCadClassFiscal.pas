{***********************}
{* qryConCfo -> CADCFO *}
{********************RV*}
unit untCadClassFiscal;

interface

uses
  Controls, Forms, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls,
  DBCtrls, DBEditFocus, QColorLabel, Menus, AppEvnts, Uni, DB, BitBtnLockedIncrem,
  Mask, Classes, frxClass, frxExportCSVTestabilidade, StrUtils, ComboBoxFocus,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, EditFocus, Windows,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxGridCitel,
  cxCheckBox, untTGerenciaModeloPermitidos;

type
  TfrmCadClassFiscal = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodCfo: TDBEditFocus;
    dbeDescr1: TDBEditFocus;
    Label2: TLabel;
    dbeDescr2: TDBEditFocus;
    dbeDescr3: TDBEditFocus;
    dbeDescr4: TDBEditFocus;
    dbeDescr5: TDBEditFocus;
    Label10: TLabel;
    dbePresta: TDBEditFocus;
    ColorLabel1: TColorLabel;
    pnlFundo: TPanel;
    DBEMNAT01: TDBEditFocus;
    DBEMNAT02: TDBEditFocus;
    Label4: TLabel;
    DBEMNAT03: TDBEditFocus;
    dtsCadCfo: TDataSource;
    PageControl1: TPageControl;
    TabSped: TTabSheet;
    TabNatOpe: TTabSheet;
    grbPlaConSped: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    cbbIndicadorTipoConta: TComboBoxFocus;
    dbeConCon: TDBEditFocus;
    dbeNivel: TDBEditFocus;
    cbbNaturezaContaContabil: TComboBoxFocus;
    chkEnviarSpedFiscal: TDBCheckBox;
    btnIncNat: TBitBtnLocked;
    edtNatOperacao: TEditFocus;
    lblCndPag: TLabel;
    cxgNatOpe: TcxGrid;
    cxgNatOpeView: TcxGridDBTableView;
    cxgNatOpeLevel: TcxGridLevel;
    dtsNatOpe: TDataSource;
    cxgNatOpeViewNAT_CODCFO: TcxGridDBColumn;
    cxgNatOpeViewNAT_DESCRI: TcxGridDBColumn;
    tabCorrelacaoEntMer: TTabSheet;
    grbClaEnt: TGroupBox;
    lblClaSub: TLabel;
    lblClaEnt: TLabel;
    dbeClaSub: TDBEditFocus;
    dbeClaEnt: TDBEditFocus;
    btnCorrelacaoEntMerEmpresas: TBitBtnLocked;
    GroupBox1: TGroupBox;
    cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridCitel1Level1: TcxGridLevel;
    cxGridCitel1: TcxGridCitel;
    dtsModelos: TDataSource;
    cxGridCitel1DBTableViewCitel1Column1: TcxGridDBColumn;
    cxModeloSelecionado: TcxGridDBColumn;
    lblMarcacoes: TLabel;
    popMarcacoes: TPopupMenu;
    MarcarTodos1: TMenuItem;
    DesmarTodos1: TMenuItem;
    InverterSeleo1: TMenuItem;
    Label3: TLabel;
    cxgNatOpeViewNAT_ATIVO_: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbeCodCfoExit(Sender: TObject);
    procedure dbeClaSubKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure dtsCadCfoStateChange(Sender: TObject);
    procedure chkEnviarSpedFiscalClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnIncNatClick(Sender: TObject);
    procedure cxgNatOpeViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dtsCadCfoDataChange(Sender: TObject; Field: TField);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCorrelacaoEntMerEmpresasClick(Sender: TObject);
    procedure lblMarcacoesClick(Sender: TObject);
    procedure MarcarTodos1Click(Sender: TObject);
    procedure DesmarTodos1Click(Sender: TObject);
    procedure InverterSeleo1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cxgNatOpeViewNAT_ATIVO_PropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    { Private declarations }
    qryCadCfo: TUniQuery;
    qryNatOpe: TUniQuery;
    GerenciaModeloPermitidos: TGerenciaModeloPermitidos;

    Function fValidaCorrelacao(dbeClaEnt: TDBEditFocus): Boolean;
    procedure pMostraClassificaoEntrada;
    procedure pHabilitaCamposContaContabil(blnAtiva: Boolean);
    procedure pCarregaNatOperacao;
    procedure pIncluiNatOperacao;
    procedure pAtualizaAtivo(strAutInc, strAtivo: String);
    procedure pAtualizaNatOperacao(strAutInc: String);
    procedure pHabilitabtnCorrelacaoEntMerEmpresas(blnAtiva: Boolean);
    function fAtivarbtnCorrelacaoEntMerEmpresas(blnAtiva: Boolean): Boolean;
    function fVerificaSeExisteNatuzezaNaEntradaDeMercadoria: Boolean;

  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses SysUtils, untfuncoesSimples, untPai, untConsultas, untTypesSistema,
  untCadClassFiscalCorrelacaoEmpresa;

{$R *.dfm}

procedure TfrmCadClassFiscal.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadClassFiscal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  If Assigned(GerenciaModeloPermitidos) Then
    FreeAndNil(GerenciaModeloPermitidos);
  inherited;
end;

procedure TfrmCadClassFiscal.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela     := 'CADCFO';
  strNomeCampo      := 'CFO_CODCFO';

  qryCadCfo         := fCriaQuery(Self);
  qryTabela         := qryCadCfo;
  dtsCadCfo.DataSet := qryTabela;

  qryNatOpe         := fCriaQuery(Self);
  dtsNatOpe.DataSet := qryNatOpe;
  qryNatOpe.SQLDelete.Text := 'DELETE FROM NATCFO WHERE AUTOINCREM = :AUTOINCREM';
  btnIncNat.Enabled := False;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodCfo;
end;

function TfrmCadClassFiscal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {*****************************************}
    {* VALIDA O CFOP                         *}
    {**************************************MV*}
    If (Sender = dbeCodCfo) Then
    Begin
      If (fEmptyStr(dbeCodCfo.Text)) And (dbeCodCfo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O CFOP deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If Length(dbeCodCfo.Text) <> 4 Then
      Begin
        fMensagem('ATENÇÃO!', 'O CFOP Fiscal deve conter exatamente 4 caracteres!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos;
      End;
    End

    {*****************************************}
    {* VALIDA O A DESCRIÇÃO DA CLASS. FISCAL *}
    {**************************************MV*}
    Else If (Sender = dbeDescr1) Then
    Begin
      If fEmptyStr(dbeDescr1.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição da Classificação Fiscal deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA O A PRESTAÇÃO                  *}
    {**************************************MV*}
    Else If (Sender = dbePresta) Then
    Begin
      If (dbePresta.Text <> 'I') And
         (dbePresta.Text <> 'C') And
         (dbePresta.Text <> 'G') Then
      Begin
        fMensagem('ATENÇÃO!', 'A prestação deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeConCon) Then
    Begin
      If (chkEnviarSpedFiscal.Checked) And (fEmptyStr(dbeConCon.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A conta contábil deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeNivel) Then
    Begin
      If (chkEnviarSpedFiscal.Checked) And (fEmptyStr(dbeNivel.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O nível deve ser preenchida!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeClaEnt) Then
    Begin
      Result := fValidaCorrelacao(dbeClaEnt);
    End

    Else If (Sender = dbeClaSub) Then
    Begin
      Result := fValidaCorrelacao(dbeClaSub);
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmCadClassFiscal.fValidaCorrelacao(dbeClaEnt: TDBEditFocus): Boolean;
Begin
  Result := True;

  If Not fEmptyStr(dbeClaEnt.Text) Then
  Begin

    If fEmptyStr(fCampoTabela('CFO_CODCFO', 'CADCFO',  ['CFO_CODCFO'], [dbeClaEnt.Text])) Then
    Begin
      pMensagemOk('Classificação não encontrada!');
      Result := False;
    End Else
    Begin

      If LeftStr(dbeClaEnt.Text, 1) >= '5' Then
      Begin
        pMensagemOk('Correlação de CFOP para Entrada de Mercadorias deve ser uma Classificação de entrada!');
        Result := False;
      End

      Else If ((LeftStr(dbeCodCfo.Text, 1) = '5') And (LeftStr(dbeClaEnt.Text, 1) <> '1')) Or
         ((LeftStr(dbeCodCfo.Text, 1) = '6') And (LeftStr(dbeClaEnt.Text, 1) <> '2')) Or
         ((LeftStr(dbeCodCfo.Text, 1) = '7') And (LeftStr(dbeClaEnt.Text, 1) <> '3')) Then
      Begin
        pMensagemOk('Para CFOPs começadas com 5, 6 e 7 as Classicações para a Entrada de Mercadorias devem começar respectivamente com 1, 2 e 3!');
        Result := False;
      End;

    End;

  End;
End;

procedure TfrmCadClassFiscal.pHabilitabtnCorrelacaoEntMerEmpresas(
  blnAtiva: Boolean);
begin
  btnCorrelacaoEntMerEmpresas.Enabled := fAtivarbtnCorrelacaoEntMerEmpresas(blnAtiva);
end;

procedure TfrmCadClassFiscal.pHabilitaCamposContaContabil(blnAtiva: Boolean);
begin
  cbbIndicadorTipoConta.Enabled := blnAtiva;
  cbbNaturezaContaContabil.Enabled := blnAtiva;
  dbeConCon.Enabled := blnAtiva;
  dbeNivel.Enabled := blnAtiva;
end;

procedure TfrmCadClassFiscal.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CFO_NATOPE');
  stlCampos.Add('CFO_CODCFO');
  stlCampos.Add('CFO_DESCR1+CFO_DESCR2');
  stlCampos.Add('CFO_DESCR3');
  stlCampos.Add('CFO_DESCR4');
  stlCampos.Add('CFO_DESCR5');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CFO_NATOPE');
  stlCamInd.Add('CFO_CODCFO');
  stlCamInd.Add('CFO_DESCR1+CFO_DESCR2');

  stlDesInd.Add('Nat. Operação');
  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição 1 / Descrição 2');
end;

procedure TfrmCadClassFiscal.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pHabilitaCamposContaContabil(False);
  pHabilitabtnCorrelacaoEntMerEmpresas(Not qryTabela.IsEmpty);
  cxModeloSelecionado.Options.Editing := False;
  If Assigned(GerenciaModeloPermitidos) Then
    FreeAndNil(GerenciaModeloPermitidos);
  GerenciaModeloPermitidos := TGerenciaModeloPermitidos.fCarregaModelosPermitidoParaCFop(dbeCodCfo.Text, dtsModelos);

  //fRollBack;
end;

procedure TfrmCadClassFiscal.btnCorrelacaoEntMerEmpresasClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmCadClassFiscalCorrelacaoEmpresa, frmCadClassFiscalCorrelacaoEmpresa);
    frmCadClassFiscalCorrelacaoEmpresa.pHabilitaEdicao(True);
    frmCadClassFiscalCorrelacaoEmpresa.pSetCodCfop(qryTabela.FieldByName('CFO_CODCFO').AsString);
    frmCadClassFiscalCorrelacaoEmpresa.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmCadClassFiscal.btnCorrelacaoEntMerEmpresasClick]');
    End;
  End;
end;

procedure TfrmCadClassFiscal.btnExcluirClick(Sender: TObject);
Var
  blnPodeExcluir: Boolean;
begin
  blnPodeExcluir:= True;
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  cxgNatOpeView.DataController.DataSet.First;
  While Not(cxgNatOpeView.DataController.DataSet.Eof) Do
  Begin

    If fVerificaSeExisteNatuzezaNaEntradaDeMercadoria Then
    Begin
      pMensagemOk('Exclusão não permitida, pois, existe natureza de operação em uso na entrada de mercadoria!');
      blnPodeExcluir:= False;
      break;
    End;

    cxgNatOpeView.DataController.DataSet.Next;
  End;

  Try
    if blnPodeExcluir Then
      inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadClassFiscal.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
  Begin
    fCommit;
    cxModeloSelecionado.Options.Editing := False;
  End
  Else
    fRollBack;

  pHabilitabtnCorrelacaoEntMerEmpresas(Not qryTabela.IsEmpty);
  pCarregaNatOperacao;
end;

procedure TfrmCadClassFiscal.btnGravarClick(Sender: TObject);
begin
  If qryNatOpe.isEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe a natureza da operação!', ['&Ok']);
    Exit;
  End;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    If (qryTabela.State In [dsEdit, dsInsert]) Then
    Begin
      If chkEnviarSpedFiscal.Checked Then
      Begin
        qryTabela.FieldByName('CFO_INDTPC').AsString := IIF(cbbIndicadorTipoConta.ItemIndex = 0, 'A', 'S');
        qryTabela.FieldByName('CFO_NATCON').AsString := Copy(cbbNaturezaContaContabil.Items[cbbNaturezaContaContabil.ItemIndex], 0, 2);
      End;

      If fEmptyStr(qryTabela.FieldByName('CFO_CLAENT').AsString) Then
        qryTabela.FieldByName('CFO_CLAENT').Clear;

      If fEmptyStr(qryTabela.FieldByName('CFO_CLASUB').AsString) Then
        qryTabela.FieldByName('CFO_CLASUB').Clear;
    End;

    If qryNatOpe.State = dsEdit Then
      qryNatOpe.Post;

    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadClassFiscal.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  begin
    Try
      GerenciaModeloPermitidos.Cfop := dbeCodCfo.Text;
      GerenciaModeloPermitidos.pSalva;
      fCommit;
      cxModeloSelecionado.Options.Editing := False;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[untCadClassFiscal.btnGravarClick]');
      End;
    End;

  End
  Else
    fRollBack;

  pHabilitabtnCorrelacaoEntMerEmpresas(True);
end;

procedure TfrmCadClassFiscal.btnIncluirClick(Sender: TObject);
begin
  inherited;

  pHabilitabtnCorrelacaoEntMerEmpresas(False);
  chkEnviarSpedFiscal.Checked := False;
  cbbIndicadorTipoConta.ItemIndex := 0;
  cbbNaturezaContaContabil.ItemIndex := 5;

  pHabilitaCodigo(dbeCodCfo, dbeCodCfo, True);
  pHabilitaCamposContaContabil(False);
  pCarregaNatOperacao;
  If Assigned(GerenciaModeloPermitidos) Then
    FreeAndNil(GerenciaModeloPermitidos);
  GerenciaModeloPermitidos := TGerenciaModeloPermitidos.fCarregaModelosPermitidoParaCFop(dbeCodCfo.Text, dtsModelos);
  cxModeloSelecionado.Options.Editing := True;

  //fStartTransaction;
end;

procedure TfrmCadClassFiscal.btnPesquisaClick(Sender: TObject);
  function fRetNaturezaSelecionada(strNatureza: String): Integer;
  begin
    Result := 0;

    If strNatureza = '01' Then
      Result := 0
    Else If strNatureza = '02' Then
      Result := 1
    Else If strNatureza = '03' Then
      Result := 2
    Else If strNatureza = '04' Then
      Result := 3
    Else If strNatureza = '05' Then
      Result := 4
    Else If strNatureza = '09' Then
      Result := 5
  end;

  Var
    chrKey: Char;
    arrCFOP: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CFOP       *}
  {****************************RV*}
  chrKey := '/';
  If fPesqCFOP(Self, Nil, Nil, qryTabela, chrKey, arrCFOP) Then
  Begin
    cbbIndicadorTipoConta.ItemIndex := IIF(qryTabela.FieldByName('CFO_INDTPC').AsString = 'A', 0, 1);
    cbbNaturezaContaContabil.ItemIndex := fRetNaturezaSelecionada(qryTabela.FieldByName('CFO_NATCON').AsString);

    pCarregaNatOperacao;
    pMostraClassificaoEntrada;
    pSetFocus(btnAlterar);
    pHabilitabtnCorrelacaoEntMerEmpresas(True);
    pHabilitaCamposContaContabil(False);
    If Assigned(GerenciaModeloPermitidos) Then
      FreeAndNil(GerenciaModeloPermitidos);
    GerenciaModeloPermitidos := TGerenciaModeloPermitidos.fCarregaModelosPermitidoParaCFop(dbeCodCfo.Text, dtsModelos);
  End;
end;

procedure TfrmCadClassFiscal.pCarregaNatOperacao;
begin
  With qryNatOpe, SQL do
  Begin
    Close;
    Clear;
    Add('SELECT * FROM NATCFO');
    Add('WHERE NAT_CODCFO = :CODCFO');
    ParamByName('CODCFO').AsString := qryTabela.FieldByName('CFO_CODCFO').AsString ;
    Open;
  End;

end;

procedure TfrmCadClassFiscal.pIncluiNatOperacao;
begin
  if qryCadCfo.state = dsInsert then
  Begin
    If (Not fValidacoesBotaoGravarPai) Then
      Exit;

    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
    Try
      pGravaRegistro;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[untCadClassFiscal.pIncluiNatOperacao]');
      End;
    End;

    If blnGravou Then
      fCommit
    Else
      fRollBack;

    //fStartTransaction;
    blnMudarFoco := True;
    qryTabela.Edit;
    pOnStateChange;
    pEnabled(Self, True);
    blnAlterou := True;
  End;

  qryNatOpe.Append;
  qryNatOpe.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('NATCFO', VS_strCodEmp) ;
  qryNatOpe.FieldByName('NAT_CODCFO').AsString := qryTabela.FieldByName('CFO_CODCFO').AsString ;
  qryNatOpe.FieldByName('NAT_ATIVO_').AsString := 'S' ;
  qryNatOpe.FieldByName('NAT_DESCRI').AsString := edtNatOperacao.Text;
  qryNatOpe.Post;
  edtNatOperacao.Clear;
end;

procedure TfrmCadClassFiscal.btnIncNatClick(Sender: TObject);
begin
  If Not fEmptyStr(edtNatOperacao.Text) Then
    pIncluiNatOperacao
  Else
    fMensagem('ATENÇÃO', 'Necessário escrever a Nat.Operação antes de adicionar!', ['&Ok']);

  pSetFocus(edtNatOperacao);
end;

procedure TfrmCadClassFiscal.pAtualizaAtivo(strAutInc, strAtivo: String);
Var
  qryUpd: TUniQuery;
begin
  qryUpd:= fCriaQuery;

  Try
    qryUpd.Close;
    qryUpd.SQL.Text := 'UPDATE NATCFO SET NAT_ATIVO_ = :ATIVO_ WHERE AUTOINCREM = :AUTINC ';
    qryUpd.ParamByName('ATIVO_').AsString := strAtivo;
    qryUpd.ParamByName('AUTINC').AsString := strAutInc;
    qryUpd.ExecSQL;

  Finally
    FreeAndNil(qryUpd);
  End;
end;

procedure TfrmCadClassFiscal.pAtualizaNatOperacao(strAutInc: String);
begin
  pCarregaNatOperacao;

  qryNatOpe.Locate('AUTOINCREM', strAutInc, []);
end;

procedure TfrmCadClassFiscal.cxgNatOpeViewNAT_ATIVO_PropertiesValidate(
  Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean);
var
  strAtivo: String;
begin
  If not assigned(Sender) Then
    Exit;

  If not (Sender is TcxCheckBox) Then
    Exit;

  strAtivo := IIF(TcxCheckBox(Sender).checked, 'S','N');

  pAtualizaAtivo(qryNatOpe.FieldByName('AUTOINCREM').AsString, strAtivo);

  pAtualizaNatOperacao(qryNatOpe.FieldByName('AUTOINCREM').AsString);

  inherited;

end;

procedure TfrmCadClassFiscal.chkEnviarSpedFiscalClick(Sender: TObject);
begin
  inherited;

  If chkEnviarSpedFiscal.Checked Then
    pHabilitaCamposContaContabil(True)
  Else
    pHabilitaCamposContaContabil(False);
end;


function TfrmCadClassFiscal.fVerificaSeExisteNatuzezaNaEntradaDeMercadoria: Boolean;
Var
  qryGen: TUniQuery;
Begin
  qryGen:= fCriaQuery;
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT * FROM MOVTRI');
    qryGen.SQL.Add('WHERE DET_NATOPE = :NATOPE');
    qryGen.ParamByName('NATOPE').AsString := cxgNatOpeView.DataController.DataSet.FieldByName('NAT_DESCRI').AsString;
    qryGen.Open;

    result:= Not(qryGen.IsEmpty);

  Finally
    FreeAndNil(qryGen);
  End;
End;

procedure TfrmCadClassFiscal.InverterSeleo1Click(Sender: TObject);
begin
  inherited;
  GerenciaModeloPermitidos.pInverte;

end;

procedure TfrmCadClassFiscal.lblMarcacoesClick(Sender: TObject);
  Var
    curPos: TPoint;
begin
  inherited;
  If Not btnGravar.Enabled Then
    Exit;
  GetCursorPos(curPos);
  popMarcacoes.Popup(curPos.X + 2, curPos.Y + 2);

end;

procedure TfrmCadClassFiscal.MarcarTodos1Click(Sender: TObject);
begin
  inherited;
  GerenciaModeloPermitidos.pMarcaTodos;
end;

procedure TfrmCadClassFiscal.cxgNatOpeViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If fVerificaSeExisteNatuzezaNaEntradaDeMercadoria Then
  Begin
    pMensagemOk('Exclusão não permitida, pois, a mesma já se encontra em uso na entrada de mercadoria!');
    Exit;
  End;

  If (Key = VK_DELETE) And btnGravar.Enabled And (not qryNatOpe.isEmpty) Then
  Begin
    If fMensagem('ATENÇÃO!', 'Deseja excluir a natureza da operação selecionada?', ['&Sim', '&Não']) = 2 Then
      cxgNatOpeView.DataController.DataSet.Delete;
  End;
end;

procedure TfrmCadClassFiscal.pMostraClassificaoEntrada;
Begin
  tabCorrelacaoEntMer.TabVisible := LeftStr(dbeCodCfo.Text, 1) >= '5';
End;

procedure TfrmCadClassFiscal.dbeClaSubKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClaEnt: TConsultasArray;
    strFiltro: String;
begin
  inherited;

  strFiltro := 'LEFT(CFO_CODCFO, 1) = ';

  If (LeftStr(dbeCodCfo.Text, 1) = '5') Then
    strFiltro := strFiltro + ' "1" '

  Else If (LeftStr(dbeCodCfo.Text, 1) = '6') Then
    strFiltro := strFiltro + ' "2" '

  Else If (LeftStr(dbeCodCfo.Text, 1) = '7') Then
    strFiltro := strFiltro + ' "3" '

  Else  strFiltro := '';

  If fPesqCFOP(Self, (Sender As TDBEditFocus), Nil, Nil, Key, arrClaEnt, True, strFiltro) Then
    Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadClassFiscal.dbeCodCfoExit(Sender: TObject);
begin
  inherited;
  pMostraClassificaoEntrada;
  If (Not tabCorrelacaoEntMer.TabVisible) And (qryTabela.State In [dsEdit, dsInsert]) Then
  Begin
    dbeClaEnt.Field.Clear;
    dbeClaSub.Field.Clear;
  End;
end;

procedure TfrmCadClassFiscal.DesmarTodos1Click(Sender: TObject);
begin
  inherited;
  GerenciaModeloPermitidos.pDesmarcaTodos;

end;

procedure TfrmCadClassFiscal.dtsCadCfoDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  btnIncNat.Enabled := (qryTabela.state in [dsInsert, dsEdit]) And (not fEmptyStr(qryTabela.FieldByName('CFO_CODCFO').AsString));
  cxgNatOpeView.OptionsData.Deleting := qryTabela.state in [dsInsert, dsEdit];
  cxgNatOpe.Enabled := qryTabela.state in [dsInsert, dsEdit];
end;

procedure TfrmCadClassFiscal.dtsCadCfoStateChange(Sender: TObject);
begin
  inherited;

  If chkEnviarSpedFiscal.Checked Then
  Begin
    If (qryTabela.State In [dsEdit, dsInsert]) Then
      pHabilitaCamposContaContabil(True)
    Else
      pHabilitaCamposContaContabil(False);
  End
  Else
    pHabilitaCamposContaContabil(False);
end;

function TfrmCadClassFiscal.fAtivarbtnCorrelacaoEntMerEmpresas(
  blnAtiva: Boolean): Boolean;
begin
  Result := False;

  If Not blnAtiva Then
    Exit;

  If LeftStr(dbeCodCfo.Text, 1) < '5' Then
    Exit;

  Result := True;
end;

procedure TfrmCadClassFiscal.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodCfo, dbeDescr1, False);

  If chkEnviarSpedFiscal.Checked Then
    pHabilitaCamposContaContabil(True)
  Else
    pHabilitaCamposContaContabil(False);

  pHabilitabtnCorrelacaoEntMerEmpresas(False);
  cxModeloSelecionado.Options.Editing := True;


  //fStartTransaction;
end;

procedure TfrmCadClassFiscal.FormShow(Sender: TObject);
begin
  inherited;
  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;
  pHabilitabtnCorrelacaoEntMerEmpresas(False);
  cxModeloSelecionado.Options.Editing := False;
  PageControl1.ActivePageIndex := 0;
end;

end.

