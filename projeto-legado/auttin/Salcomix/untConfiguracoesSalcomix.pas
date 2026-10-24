unit untConfiguracoesSalcomix;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Mask, FilenameEditFocus, Menus, MaskEditFocus,
  DirectoryEditFocus, StrUtils, AppEvnts, QColorLabel, Uni,
  untConfConsulta, untIConsultaTinta, untIConfTinta, BitBtnLockedIncrem,
  frxClass, frxExportCSVTestabilidade, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxButtonEdit, 
  untFrameDirectoryEditFocus;

type
  TfrmConfiguracoesSalcomix = class(TfrmPaiSimples)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label20: TLabel;
    pnlBotoesConf: TPanel;
    pnlCentral: TPanel;
    pnlCabecalho: TPanel;
    chkUsaFor: TCheckBox;
    chkUsaSal: TCheckBox;
    edtTraSal: TEditFocus;
    edtFatSal: TEditFocus;
    edtNfmSal: TEditFocus;
    Label1: TLabel;
    edtFveSal: TEditFocus;
    Label8: TLabel;
    edtDesProSal: TEditFocus;
    edtProSal: TEditFocus;
    Label13: TLabel;
    ColorLabel4: TColorLabel;
    edtAcuAbs: TEditFocus;
    lblSalIco: TLabel;
    lblSalIsp: TLabel;
    edtSalIco: TEditFocus;
    edtSalIsp: TEditFocus;
    edtDesSalIsp: TEditFocus;
    edtDesSalIco: TEditFocus;
    tbsConfCampos: TTabSheet;
    tbsIntegracaoSalcomix: TTabSheet;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    edtSenha: TEditFocus;
    edtUsuario: TEditFocus;
    edtHost: TEditFocus;
    edtBanco: TEditFocus;
    rdgCalculoFormulacao: TRadioGroup;
    lblSalIba: TLabel;
    edtSalIba: TEditFocus;
    edtDesSalIba: TEditFocus;
    btnSairConf: TBitBtnLocked;
    btnGravarConf: TBitBtnLocked;
    btnRestaurar: TBitBtnLocked;
    Label16: TLabel;
    edtSalIem: TEditFocus;
    edtDesSalIem: TEditFocus;
    Label6: TLabel;
    edtSalIgl: TEditFocus;
    edtDesSalIgl: TEditFocus;
    Label7: TLabel;
    edtDesOpe: TEditFocus;
    Label38: TLabel;
    edtApreve: TEditFocus;
    edtPatSal: TFilenameEditFocus;
    fraPatSalDir: TfraDirectoryEditFocus;
    procedure btnGravarConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnSairConfClick(Sender: TObject);
    procedure edtProSalKeyPress(Sender: TObject; var Key: Char);
    procedure edtSalIemKeyPress(Sender: TObject; var Key: Char);
    procedure edtSalIglKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnRestaurarClick(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
  private
    { Private declarations }

    frmConfConsultaSalcomix: TfrmConfConsulta;
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
    destructor Destroy; override;
    { Public declarations }
  end;

var
  frmConfiguracoesSalcomix: TfrmConfiguracoesSalcomix;

implementation

uses  untFuncoesSimples, untFuncTinta, untTypesSistema, untConsultas;

{$R *.dfm}

{ TfrmConfiguracoesSalcomix }

procedure TfrmConfiguracoesSalcomix.pAtualizaVariaveisGlobais;
begin


end;

procedure TfrmConfiguracoesSalcomix.pCarregaArqIni;
begin
  {*****************************************}
  {* CARREGA DADOS DA SALCOMIX             *}
  {**************************************MV*}

  chkUsaSal.Checked := conf.fGetBoolean('USATIN');
  chkUsaFor.Checked := conf.fGetBoolean('USAFOR');
  edtProSal.Text    := conf.fGet('PROSAL');
  edtDesProSal.Text := fRetNomProduto(edtProSal.Text);
  edtSalIem.Text    := conf.fGet('SALIEM');
  edtDesSalIem.Text := fRetNomProduto(edtSalIem.Text);
  edtSalIgl.Text    := conf.fGet('SALIGL');
  edtDesSalIgl.Text := fRetNomProduto(edtSalIgl.Text);
  edtSalIco.Text    := conf.fGet('SALICO');
  edtDesSalIco.Text := fRetNomProduto(edtSalIco.Text);
  edtSalIsp.Text    := conf.fGet('SALISP');
  edtDesSalIsp.Text := fRetNomProduto(edtSalIsp.Text);
  edtSalIba.Text    := conf.fGet('SALIBA');
  edtDesSalIba.Text := fRetNomProduto(edtSalIba.Text);
  edtTraSal.Text    := conf.fGet('TRASAL');
  edtFatSal.Text    := conf.fGet('FATSAL');
  edtFveSal.Text    := conf.fGet('FVESAL');
  edtNfmSal.Text    := conf.fGet('NFMSAL');

  If fraPatSalDir.Visible Then
    fraPatSalDir.edtDirectory.text := conf.fGet('PATSAL')
  Else
    edtPatSal.Text  := conf.fGet('PATSAL');

  edtAcuAbs.Text    := conf.fGet('ACUABS');
  edtDesOpe.Text    := conf.fGet('DESOPE');
  edtApreve.Text    := conf.fGet('APREVE');
  rdgCalculoFormulacao.ItemIndex := conf.fGetInteger('CALFOR');
  edtSenha.Text   := conf.fGet('SENSQS');
  edtUsuario.Text := conf.fGet('USUSQS');
  edtBanco.Text   := conf.fGet('DATSQS');
  edtHost.Text    := conf.fGet('HOSSQS');
end;

procedure TfrmConfiguracoesSalcomix.pGravaArqIni;
begin
  {*****************************************}
  {* GRAVA DADOS DA SALCOMIX               *}
  {**************************************MV*}

  conf.pSetBoolean('USATIN', chkUsaSal.Checked);
  conf.pSetBoolean('USAFOR', chkUsaFor.Checked);
  conf.pSet('PROSAL', edtProSal.Text);
  conf.pSet('SALIEM', edtSalIem.Text);
  conf.pSet('SALIGL', edtSalIgl.Text);
  conf.pSet('SALICO', edtSalIco.Text);
  conf.pSet('SALISP', edtSalIsp.Text);
  conf.pSet('SALIBA', edtSalIba.Text);
  conf.pSet('TRASAL', edtTraSal.Text);
  conf.pSet('FATSAL', edtFatSal.Text);
  conf.pSet('FVESAL', edtFveSal.Text);
  conf.pSet('NFMSAL', edtNfmSal.Text);

  If fraPatSalDir.Visible Then
    conf.pSet('PATSAL', fraPatSalDir.edtDirectory.text)
  Else
    conf.pSet('PATSAL', edtPatSal.Text);

  conf.pSet('ACUABS', edtAcuAbs.Text);
  conf.pSet('CALFOR', IntToStr(rdgCalculoFormulacao.ItemIndex));
  conf.pSetDouble('DESOPE', fStrToFloat(edtDesOpe.Text));
  conf.pSetDouble('APREVE', fStrToFloat(edtApreve.Text));
  conf.pSet('SENSQS', edtSenha.Text);
  conf.pSet('USUSQS', edtUsuario.Text);
  conf.pSet('DATSQS', edtBanco.Text);
  conf.pSet('HOSSQS', edtHost.Text);
end;

procedure TfrmConfiguracoesSalcomix.btnGravarConfClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin

    If (fMensagem('', 'Confirma dados?', ['&Sim', '&Não']) = 1) Then
    Begin
      pGravaArqIni;

      frmConfConsultaSalcomix.pSalvarConfs;
      
      pAtualizaVariaveisGlobais;
      Close;
    End;

  End;
end;

procedure TfrmConfiguracoesSalcomix.FormCreate(Sender: TObject);
begin
  inherited;
  consulta := fGetConsultaTinta('SAL');
  conf     := fGetConfTinta('SAL');

  {*****************************************}
  {* CRIA AS CONFIGURACOES CASO NAO EXISTA *}
  {**************************************AC*}
  conf.pInsereCodigo('USATIN', 'Utilizar essa tinta de máquina', fArqIniTinta(0, 'SALCOMIX', 'USATIN', ''));
  conf.pInsereCodigo('USAFOR', 'Utilizar formulação', fArqIniTinta(0, 'USA_FORMUL', 'SAL', 'S'));
  conf.pInsereCodigo('PROSAL', 'Produto para venda', fArqIniTinta(0, 'SALCOMIX', 'PROSAL', ''));
  conf.pInsereCodigo('SALIEM', 'Item(Embalagem litro)', fArqIniTinta(0, 'SALCOMIX', 'SALIEM', ''));
  conf.pInsereCodigo('SALIGL', 'Item(Embalagem galão)', fArqIniTinta(0, 'SALCOMIX', 'SALIGL', ''));
  conf.pInsereCodigo('SALICO', 'Item Embalagem para copo', fArqIniTinta(0, 'SALCOMIX', 'SALICO', ''));
  conf.pInsereCodigo('SALISP', 'Item Embalagem para spray', fArqIniTinta(0, 'SALCOMIX', 'SALISP', ''));
  conf.pInsereCodigo('SALIBA', 'Item Embalagem para balde', fArqIniTinta(0, 'SALCOMIX', 'SALIBA', ''));  
  conf.pInsereCodigo('TRASAL', 'Trava para valor de venda SAL_PRE', fArqIniTinta(0, 'SALCOMIX', 'TRASAL', ''));
  conf.pInsereCodigo('FATSAL', 'Fator', fArqIniTinta(0, 'SALCOMIX', 'FATSAL', ''));
  conf.pInsereCodigo('FVESAL', 'Fator para preço de custo', fArqIniTinta(0, 'SALCOMIX', 'FVESAL', '1'));
  conf.pInsereCodigo('NFMSAL', 'Próximo código nova fórmula', fArqIniTinta(0, 'SALCOMIX', 'NFMSAL', ''));
  conf.pInsereCodigo('PATSAL', 'Path para arquivo de fórmulas', fArqIniTinta(0, 'SALCOMIX', 'PATSAL', ''));
  conf.pInsereCodigo('ACUABS', 'Valores de formulação', fArqIniTinta(0, 'SALCOMIX', 'ACUABS', '1'));
  conf.pInsereCodigo('CALFOR', 'Cálculo da formulação', fArqIniTinta(0, 'SALCOMIX', 'CALFOR', '0'));
  conf.pInsereCodigo('SENSQS', 'Senha(Integração com sistema Salcomix)', fArqIniTinta(0, 'SALCOMIX', 'SENSQS', '1nt3gr4c40'));
  conf.pInsereCodigo('USUSQS', 'Usuário(Integração com sistema Salcomix)', fArqIniTinta(0, 'SALCOMIX', 'USUSQS', 'integracao'));
  conf.pInsereCodigo('DATSQS', 'Banco(Integração com sistema Salcomix)', fArqIniTinta(0, 'SALCOMIX', 'DATSQS', 'BASFAplicativosOffline'));
  conf.pInsereCodigo('HOSSQS', 'IP / Host(Integração com sistema Salcomix)', fArqIniTinta(0, 'SALCOMIX', 'HOSSQS', 'TINTAS\BASFAPP'));
  conf.pInsereCodigo('DESOPE', 'Despesas Operacionais da Tinta', '0');
  conf.pInsereCodigo('APREVE', 'Acréscimo Adicional sobre Preço de Venda', '0');

  pCarregaArqIni;
  edtDesProSal.Text        := fRetNomProduto(edtProSal.Text);
  edtDesSalIem.Text        := fRetNomProduto(edtSalIem.Text);
  edtDesSalIgl.Text        := fRetNomProduto(edtSalIgl.Text);
  edtDesSalIco.Text        := fRetNomProduto(edtSalIco.Text);
  edtDesSalIsp.Text        := fRetNomProduto(edtSalIsp.Text);
  edtDesSalIba.Text        := fRetNomProduto(edtSalIba.Text);
  frmConfConsultaSalcomix  := TfrmConfConsulta.Create(Self, tbsConfCampos, Self.Canvas, consulta);
  pgcDados.ActivePageIndex := 0;

  edtPatSal.Dialog.Dialog.Filter := 'Arquivos Texto|*.txt|Todos os arquivos|*.*';

  pSetaCodIte(edtProSal);
  pSetaCodIte(edtSalIem);
  pSetaCodIte(edtSalIgl);
  pSetaCodIte(edtSalIco);
  pSetaCodIte(edtSalIsp);
  pSetaCodIte(edtSalIba);
end;

function TfrmConfiguracoesSalcomix.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtProSal) Then
    Begin
      If (fEmptyStr(edtProSal.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto para venda deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pRetornaDescricaoItem(edtProSal);
        If (fEmptyStr(edtDesProSal.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtSalIem) Then
    Begin
      If Not (fEmptyStr(edtSalIem.Text)) Then
      Begin
        pRetornaDescricaoItem(edtSalIem);
        If (fEmptyStr(edtDesSalIem.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtSalIgl) Then
    Begin
      If Not (fEmptyStr(edtSalIgl.Text)) Then
      Begin
        pRetornaDescricaoItem(edtSalIgl);
        If (fEmptyStr(edtDesSalIgl.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtSalIco) And (edtSalIco.Enabled) Then
    Begin
      If Not (fEmptyStr(edtSalIco.Text)) Then
      Begin
        pRetornaDescricaoItem(edtSalIco);
        If (fEmptyStr(edtDesSalIco.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtSalIsp) And (edtSalIsp.Enabled)  Then
    Begin
      If Not (fEmptyStr(edtSalIsp.Text)) Then
      Begin
        pRetornaDescricaoItem(edtSalIsp);
        If (fEmptyStr(edtDesSalIsp.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtSalIba) And (edtSalIba.Enabled)  Then
    Begin
      If Not (fEmptyStr(edtSalIba.Text)) Then
      Begin
        pRetornaDescricaoItem(edtSalIba);
        If (fEmptyStr(edtDesSalIba.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse produto não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    {*****************************************}
    {* VALIDA CAMPOS DA Salcomix              *}
    {**************************************MV*}
    Else If (Sender = edtTraSal) Then
    Begin

      If fEmptyStr(edtTraSal.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If Length(edtTraSal.Text) <> 3 Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo da trava deve ter exatamente 3 caracteres!', ['&Ok']);
        Result := False;
      End
      Else If Pos(edtTraSal.Text, 'VEN_CUS_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Campo inválido ou inexistente!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtFatSal) Then
    Begin

      If fEmptyStr(edtFatSal.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFatSal.Text) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da trava deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtFveSal) Then
    Begin
      If fEmptyStr(edtFveSal.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator para preço de Custo deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtFveSal.Text) <= 0.0 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator para preço de Custo deve ser maior que Zero!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtNfmSal) Then
    Begin
      If (fEmptyStr(edtNfmSal.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O produto deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtPatSal) And (edtPatSal.Visible) Then
    Begin
      If (fEmptyStr(edtPatSal.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O path para arquivo de fórmulas deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = fraPatSalDir) And (fraPatSalDir.Visible) Then
    Begin
      If (fEmptyStr(fraPatSalDir.edtDirectory.text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O path para arquivo de fórmulas deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = edtAcuAbs) Then
    Begin
      if not (Pos(edtAcuAbs.Text, '12') > 0) then
      begin
        Result := False;
        fMensagem('ATENÇÃO!', 'Só é permitido as opções 1 ou 2!', ['OK']);
      end;
    End
    Else If (Sender = edtDesOpe) Then
    begin
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
    begin
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

procedure TfrmConfiguracoesSalcomix.btnRestaurarClick(Sender: TObject);
begin
  inherited;
  frmConfConsultaSalcomix.pRestaurarPadrao;
end;

procedure TfrmConfiguracoesSalcomix.btnSairConfClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmConfiguracoesSalcomix.edtProSalKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 6)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesSalcomix.edtSalIemKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 6)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesSalcomix.edtSalIglKeyPress(Sender: TObject;
  var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(FindComponent('edtDes' + RightStr(TEdit(Sender).Name, 6)));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmConfiguracoesSalcomix.pConsultaItem(edtItem, edtDesIte: TEdit);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqItem(conIteSimples, Self, edtItem, edtDesIte, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmConfiguracoesSalcomix.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnRestaurar.Visible := (pgcDados.ActivePage = tbsConfCampos);
end;

procedure TfrmConfiguracoesSalcomix.pRetornaDescricaoItem(edtCodIte: TEdit);
  Var
    strNomEdt: String;
    edtDesIte: TEdit;
begin
  strNomEdt := 'edtDes' + RightStr(edtCodIte.Name, 6);
  edtDesIte := TEdit(FindComponent(strNomEdt));

  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmConfiguracoesSalcomix.FormShow(Sender: TObject);
begin
  inherited;
  fraPatSalDir.Left := edtPatSal.Left;
  fraPatSalDir.Width := 368;
  edtPatSal.Visible := False;

  lblSalIco.Enabled := True;
  edtSalIco.Enabled := True;
  lblSalIsp.Enabled := True;
  edtSalIsp.Enabled := True;
  lblSalIba.Enabled := True;
  edtSalIba.Enabled := True;
end;


destructor TfrmConfiguracoesSalcomix.Destroy;
begin
  if Assigned(frmConfConsultaSalcomix) then FreeAndNil(frmConfConsultaSalcomix);  
  inherited;
end;

end.
