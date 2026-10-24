unit untConfiguracoesGlasurit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, FilenameEditFocus, Menus, MaskEditFocus,
  DirectoryEditFocus, StrUtils, AppEvnts, QColorLabel, Uni,
  untConfConsulta, untIConsultaTinta, untIConfTinta,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesGlasurit = class(TfrmPaiSimples)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label20: TLabel;
    pnlBotoesConf: TPanel;
    pnlCentral: TPanel;
    chkUsaFor: TCheckBox;
    chkUsaGla: TCheckBox;
    edtTraGla: TEditFocus;
    edtFatGla: TEditFocus;
    edtNfmGla: TEditFocus;
    Label1: TLabel;
    edtFveGla: TEditFocus;
    Label16: TLabel;
    Label6: TLabel;
    edtGlaIem: TEditFocus;
    edtGlaIgl: TEditFocus;
    edtDesGlaIgl: TEditFocus;
    edtDesGlaIem: TEditFocus;
    Label8: TLabel;
    edtDesProGla: TEditFocus;
    edtProGla: TEditFocus;
    Label13: TLabel;
    ColorLabel4: TColorLabel;
    edtAcuAbs: TEditFocus;
    lblGlaIco: TLabel;
    lblGlaIsp: TLabel;
    edtGlaIco: TEditFocus;
    edtGlaIsp: TEditFocus;
    edtDesGlaIsp: TEditFocus;
    edtDesGlaIco: TEditFocus;
    rdgCalculoFormulacao: TRadioGroup;
    tbsConexaoSQLServer: TTabSheet;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    edtSenha: TEditFocus;
    edtUsuario: TEditFocus;
    edtHost: TEditFocus;
    edtBanco: TEditFocus;
    tbsConfCampos: TTabSheet;
    pnlCabecalho: TPanel;
    lblGlaBal: TLabel;
    edtGlaBal: TEditFocus;
    edtDesGlaBal: TEditFocus;
    btnSairConf: TBitBtnLocked;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    Label38: TLabel;
    edtApreve: TEditFocus;
    edtPatGla: TFilenameEditFocus;
    fraPatGlaDir: TfraDirectoryEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairConfClick(Sender: TObject);
    procedure edtProGlaKeyPress(Sender: TObject; var Key: Char);
    procedure edtGlaIemKeyPress(Sender: TObject; var Key: Char);
    procedure edtGlaIglKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private
    { Private declarations }

    qryCadIte: TUniQuery;

    frmConfConsultaGlasurit: TfrmConfConsulta;
    consulta: IConsultaTinta;
    conf: IConfTinta;

    procedure pGravaArqIni;
    procedure pCarregaArqIni;
    procedure pAtualizaVariaveisGlobais;
    procedure pConsultaItem(edtItem, edtDesIte: TEdit);
    procedure pRetornaDescricaoItem(edtCodIte: TEdit);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    destructor Destroy; override;
  end;

var
  frmConfiguracoesGlasurit: TfrmConfiguracoesGlasurit;

implementation

uses untFuncTinta,
     untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmConfiguracoesGlasurit }

procedure TfrmConfiguracoesGlasurit.pAtualizaVariaveisGlobais;
begin


end;

procedure TfrmConfiguracoesGlasurit.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA GLASURIT             *}
  {**************************************MV*}

  chkUsaGla.Checked := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');
  edtProGla.Text    := conf.fGet('PROGLA');
  edtDesProGla.Text := fRetNomProduto(edtProGla.Text);
  edtGlaIem.Text    := conf.fGet('GLAIEM');
  edtDesGlaIem.Text := fRetNomProduto(edtGlaIem.Text);
  edtGlaIgl.Text    := conf.fGet('GLAIGL');
  edtDesGlaIgl.Text := fRetNomProduto(edtGlaIgl.Text);

  edtGlaIco.Text    := conf.fGet('GLAICO');
  edtDesGlaIco.Text := fRetNomProduto(edtGlaIco.Text);

  edtGlaIsp.Text    := conf.fGet('GLAISP');
  edtDesGlaIsp.Text := fRetNomProduto(edtGlaIsp.Text);

  edtGlaBal.Text    := conf.fGet('GLABAL');
  edtDesGlaBal.Text := fRetNomProduto(edtGlaBal.Text);

  edtTraGla.Text    := conf.fGet('TRAGLA');
  edtFatGla.Text    := conf.fGet('FATGLA');
  edtFveGla.Text    := conf.fGet('FVEGLA');
  edtNfmGla.Text    := conf.fGet('NFMGLA');

  If fraPatGlaDir.Visible Then
    fraPatGlaDir.edtDirectory.text := conf.fGet('PATGLA')
  Else
    edtPatGla.Text  := conf.fGet('PATGLA');
  edtAcuAbs.Text    := conf.fGet('ACUABS');

  rdgCalculoFormulacao.ItemIndex := StrToIntDef(conf.fGet('CALFOR'), 0);
  edtSenha.Text   := conf.fGet('SENSQS');
  edtUsuario.Text := conf.fGet('USUSQS');
  edtBanco.Text   := conf.fGet('DATSQS');
  edtHost.Text    := conf.fGet('HOSSQS');
  edtDesOpe.Text    := conf.fGet('DESOPE');
  edtApreve.Text    := conf.fGet('APREVE');

end;

procedure TfrmConfiguracoesGlasurit.pGravaArqIni;
begin
  {*****************************************}
  {* GRAVA DADOS DA GLASURIT               *}
  {**************************************MV*}
  conf.pSetBoolean('USATIN', chkUsaGla.Checked);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked);
  conf.pSet('PROGLA', edtProGla.Text);
  conf.pSet('GLAIEM', edtGlaIem.Text);
  conf.pSet('GLAIGL', edtGlaIgl.Text);

  conf.pSet('GLAICO', edtGlaIco.Text);
  conf.pSet('GLAISP', edtGlaIsp.Text);
  conf.pSet('GLABAL', edtGlaBal.Text);

  conf.pSet('TRAGLA', edtTraGla.Text);
  conf.pSet('FATGLA', edtFatGla.Text);
  conf.pSet('FVEGLA', edtFveGla.Text);
  conf.pSet('NFMGLA', edtNfmGla.Text);

  If fraPatGlaDir.Visible Then
    conf.pSet('PATGLA', fraPatGlaDir.edtDirectory.text)
  Else
    conf.pSet('PATGLA', edtPatGla.Text);

  conf.pSet('ACUABS', edtAcuAbs.Text);

  conf.pSet('CALFOR', IntToStr(rdgCalculoFormulacao.ItemIndex));

  conf.pSet('SENSQS', edtSenha.Text);
  conf.pSet('USUSQS', edtUsuario.Text);
  conf.pSet('DATSQS', edtBanco.Text);
  conf.pSet('HOSSQS', edtHost.Text);

  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));

  frmConfConsultaGlasurit.pSalvarConfs;
end;

procedure TfrmConfiguracoesGlasurit.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin

    If (fMensagem('', 'Confirma dados?', ['&Sim', '&Não']) = 1) Then
    Begin
      pGravaArqIni;
      pAtualizaVariaveisGlobais;
      Close;
    End;

  End;
end;

procedure TfrmConfiguracoesGlasurit.FormCreate(Sender: TObject);
begin
  inherited;
  conf     := fGetConfTinta('GLA');
  consulta := fGetConsultaTinta('GLA');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}
  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'GLASURIT', 'USATIN', ''));
  conf.pInsereCodigo('USAFOR', 'Utilizar formulação', fArqIniTinta(0, 'USA_FORMUL', 'GLA', 'S'));
  conf.pInsereCodigo('PROGLA', 'Produto para venda', fArqIniTinta(0, 'GLASURIT', 'PROGLA', ''));
  conf.pInsereCodigo('GLAIEM', 'Item embalagem (LT)', fArqIniTinta(0, 'GLASURIT', 'GLAIEM', ''));
  conf.pInsereCodigo('GLAIGL', 'Item embalagem (GL)', fArqIniTinta(0, 'GLASURIT', 'GLAIGL', ''));
  conf.pInsereCodigo('GLAICO', 'Item embalagem para Copo', fArqIniTinta(0, 'GLASURIT', 'GLAICO', ''));
  conf.pInsereCodigo('GLAISP', 'Item embalagem para Spray', fArqIniTinta(0, 'GLASURIT', 'GLAISP', ''));
  conf.pInsereCodigo('GLABAL', 'Item embalagem para Balde', fArqIniTinta(0, 'GLASURIT', 'GLABAL', ''));  
  conf.pInsereCodigo('TRAGLA', 'Trava para valor de venda GLA_PRE', fArqIniTinta(0, 'GLASURIT', 'TRAGLA', ''));
  conf.pInsereCodigo('FATGLA', 'Fator', fArqIniTinta(0, 'GLASURIT', 'FATGLA', ''));
  conf.pInsereCodigo('FVEGLA', 'Fator para preço de custo', fArqIniTinta(0, 'GLASURIT', 'FVEGLA', '1'));
  conf.pInsereCodigo('NFMGLA', 'Próximo código Nova Fórmula', fArqIniTinta(0, 'GLASURIT', 'NFMGLA', ''));
  conf.pInsereCodigo('PATGLA', 'Path para arquivo de Fórmulas', fArqIniTinta(0, 'GLASURIT', 'PATGLA', ''));
  conf.pInsereCodigo('ACUABS', 'Valores da Formulação', fArqIniTinta(0, 'GLASURIT', 'ACUABS', '1'));
  conf.pInsereCodigo('CALFOR', 'Cálculo da Formulação', fArqIniTinta(0, 'GLASURIT', 'CALFOR', '0'));
  conf.pInsereCodigo('SENSQS', 'Senha integração sistema glasurit', fArqIniTinta(0, 'GLASURIT', 'SENSQS', '1nt3gr4c40'));
  conf.pInsereCodigo('USUSQS', 'Usuário integração sistema glasurit', fArqIniTinta(0, 'GLASURIT', 'USUSQS', 'integracao'));
  conf.pInsereCodigo('DATSQS', 'Banco integração sistema glasurit', fArqIniTinta(0, 'GLASURIT', 'DATSQS', 'BASFAplicativosOffline'));
  conf.pInsereCodigo('HOSSQS', 'IP / Host integração sistema glasurit', fArqIniTinta(0, 'GLASURIT', 'HOSSQS', 'TINTAS\BASFAPP'));
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pCarregaArqIni;
  frmConfConsultaGlasurit  := TfrmConfConsulta.Create(Self, tbsConfCampos, Self.Canvas, consulta);  
  pgcDados.ActivePageIndex := 0;

  edtPatGla.Dialog.Dialog.Filter := 'Arquivos Texto|*.txt|Todos os arquivos|*.*';

  pSetaCodIte(edtProGla);
  pSetaCodIte(edtGlaIem);
  pSetaCodIte(edtGlaIgl);
  pSetaCodIte(edtGlaIco);
  pSetaCodIte(edtGlaIsp);
  pSetaCodIte(edtGlaBal);
end;

function TfrmConfiguracoesGlasurit.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtProGla) Then
    Begin
      If (fEmptyStr(edtProGla.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto para venda deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pRetornaDescricaoItem(edtProGla);
        If (fEmptyStr(edtDesProGla.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtGlaIem) Then
    Begin
      If Not (fEmptyStr(edtGlaIem.Text)) Then
      Begin
        pRetornaDescricaoItem(edtGlaIem);
        If (fEmptyStr(edtDesGlaIem.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    
    Else If (Sender = edtGlaIgl) Then
    Begin
      If Not (fEmptyStr(edtGlaIgl.Text)) Then
      Begin
        pRetornaDescricaoItem(edtGlaIgl);
        If (fEmptyStr(edtDesGlaIgl.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtGlaIco) And (edtGlaIco.Enabled) Then
    Begin
      If Not (fEmptyStr(edtGlaIco.Text)) Then
      Begin
        pRetornaDescricaoItem(edtGlaIco);
        If (fEmptyStr(edtDesGlaIco.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtGlaIsp) And (edtGlaIsp.Enabled)  Then
    Begin
      If Not (fEmptyStr(edtGlaIsp.Text)) Then
      Begin
        pRetornaDescricaoItem(edtGlaIsp);
        If (fEmptyStr(edtDesGlaIsp.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtGlaBal) And (edtGlaBal.Enabled)  Then
    Begin
      If Not (fEmptyStr(edtGlaBal.Text)) Then
      Begin
        pRetornaDescricaoItem(edtGlaBal);
        If (fEmptyStr(edtDesGlaBal.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End


    {*****************************************}
    {* VALIDA CAMPOS DA Glasurit              *}
    {**************************************MV*}
    Else If (Sender = edtTraGla) Then
    Begin

      If fEmptyStr(edtTraGla.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If Length(edtTraGla.Text) <> 3 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
        Result := False;
      End
      Else If Pos(edtTraGla.Text, 'VEN_CUS_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtFatGla) Then
    Begin

      If fEmptyStr(edtFatGla.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFatGla.Text) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtFveGla) Then
    Begin

      If fEmptyStr(edtFveGla.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator para preço de Custo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFveGla.Text) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator para preço de Custo deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtNfmGla) Then
    Begin

      If (fEmptyStr(edtNfmGla.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto deve ser preenchido!', ['&Ok']);
        Result := False;
      End;

    End

    Else If (Sender = edtPatGla) And (edtPatGla.Visible) Then
    Begin
      If (fEmptyStr(edtPatGla.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O path para arquivo de fórmulas deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = fraPatGlaDir) And (fraPatGlaDir.Visible) Then
    Begin
      If (fEmptyStr(fraPatGlaDir.edtDirectory.text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O path para arquivo de fórmulas deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtAcuAbs) Then
    Begin
      If  Not (Pos(edtAcuAbs.Text, '12') > 0) Then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Só é permitido as opções 1 ou 2!', ['OK']);
      end;
    End

    Else If (Sender = edtDesOpe) Then
    Begin
      If fEmptyStr(edtDesOpe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtDesOpe.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'A Despesa Operacional deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtApreve) Then
    Begin
      If fEmptyStr(edtApreve.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtApreve.Text) < 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Acréscimo Adicional sobre Preço de Venda deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
    End;



  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmConfiguracoesGlasurit.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaGlasurit.pRestaurarPadrao;
end;

procedure TfrmConfiguracoesGlasurit.btnSairConfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmConfiguracoesGlasurit.edtProGlaKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(fComponentByName(tbsGeral, 'edtDes' + RightStr(TEdit(Sender).Name, 6)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesGlasurit.edtGlaIemKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(fComponentByName(tbsGeral, 'edtDes' + RightStr(TEdit(Sender).Name, 6)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesGlasurit.edtGlaIglKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(fComponentByName(tbsGeral, 'edtDes' + RightStr(TEdit(Sender).Name, 6)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesGlasurit.pConsultaItem(edtItem, edtDesIte: TEdit);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqItem(conIteSimples, Self, edtItem, edtDesIte, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesGlasurit.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesGlasurit.pRetornaDescricaoItem(edtCodIte: TEdit);
  Var
    strNomEdt: String;
    edtDesIte: TEdit;
begin
  strNomEdt := 'edtDes' + RightStr(edtCodIte.Name, 6);
  edtDesIte := TEdit(fComponentByName(tbsGeral, strNomEdt));

  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesGlasurit.FormShow(Sender: TObject);
begin
  inherited;
  fraPatGlaDir.Left := edtPatGla.Left;
  fraPatGlaDir.Width := 368;
  edtPatGla.Visible := False;

  lblGlaIco.Enabled := True;
  edtGlaIco.Enabled := True;
  lblGlaIsp.Enabled := True;
  edtGlaIsp.Enabled := True;
  lblGlaBal.Enabled := True;
  edtGlaBal.Enabled := True;

  qryCadIte := fCriaQuery(Self);
end;


destructor TfrmConfiguracoesGlasurit.Destroy;
begin
  if Assigned(frmConfConsultaGlasurit) then FreeAndNil(frmConfConsultaGlasurit);
  
  inherited;
end;

end.
