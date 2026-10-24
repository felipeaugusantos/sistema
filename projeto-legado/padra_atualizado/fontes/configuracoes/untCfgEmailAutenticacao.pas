unit untCfgEmailAutenticacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, EditFocus,
  Vcl.ExtCtrls, MemoFocus, Vcl.DBCtrls, DBLookupComboBoxFocus, Vcl.Mask,
  DBEditFocus, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, untTCadastroProvedores, untTEnvioEmail,
  System.ImageList, Vcl.ImgList, Data.DB, Uni, UniClientDataSet, UniDataSetProvider, strUtils, JPeg;

type
  TfrmCfgEmailAutenticacao = class(TfrmPaiConfirma)
    Panel1: TPanel;
    grbProvedor: TGroupBox;
    Label34: TLabel;
    lblSenhaEmail: TLabel;
    lblProvedor: TLabel;
    dbeEmailOper: TDBEditFocus;
    lkpProvedores: TDBLookupComboBoxFocus;
    grbAssinaturaEmail: TGroupBox;
    grbAssinaturaTexto: TGroupBox;
    mmoAssinatura: TMemoFocus;
    grbAssinaturaImagem: TGroupBox;
    pnlBotoesAssinatura: TPanel;
    btnAdicionarAssinatura: TBitBtnLocked;
    btnLimparAssinatura: TBitBtnLocked;
    edtSenhaEmail: TEditFocus;
    btnValidarDadosEmail: TBitBtnLocked;
    pnlValidaDadosConta: TPanel;
    btnDadosSmtp: TSpeedButton;
    btnDadosImap: TSpeedButton;
    btnAutenticacaoSmtp: TSpeedButton;
    chkMostrarSenha: TCheckBox;
    imgValidacaoEmail: TImageList;
    dtsCfgEma: TDataSource;
    dlgAssinatura: TOpenDialog;
    imgAssinatura: TImage;
    Label39: TLabel;
    dbeLoginEmail: TDBEditFocus;
    lblRemete: TLabel;
    dbeRemetente: TDBEditFocus;
    btnAjudaGMail: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnValidarDadosEmailClick(Sender: TObject);
    procedure chkMostrarSenhaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAdicionarAssinaturaClick(Sender: TObject);
    procedure btnLimparAssinaturaClick(Sender: TObject);
    procedure btnAjudaGMailClick(Sender: TObject);
    procedure lkpProvedoresClick(Sender: TObject);
    procedure dbeEmailOperChange(Sender: TObject);
    procedure dbeEmailOperExit(Sender: TObject);
  private
    qryCfgEma: TUniQuery;
    cdsCfgEma: TUniClientDataSet;
    objCadPrvController: TCadastroProvedores;

    FEmailIdAzure: String;

    FValidacaoObrigatoria: Boolean;

    procedure pCarregaConfiguracao;
    procedure pCarregaImagem;
    procedure pGravar;

  Protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  public
    strSeqGer: String;
  end;

var
  frmCfgEmailAutenticacao: TfrmCfgEmailAutenticacao;

implementation

{$R *.dfm}

uses
  untFuncoesSimples, untConstantes, untImagemBase64, untRelAjudaMod;

procedure TfrmCfgEmailAutenticacao.btnAdicionarAssinaturaClick(Sender: TObject);
Var
  strImagemAssinatura: String;
begin
  inherited;
  If (dlgAssinatura.Execute()) Then
  Begin
    strImagemAssinatura := dlgAssinatura.Files[0];
    cdsCfgEma.Edit;
    cdsCfgEma.FieldByName('CFG_ASSB64').AsString := fBase64FromFile(strImagemAssinatura);
    pCarregaImagem;
    cdsCfgEma.Post;
  End;
end;

procedure TfrmCfgEmailAutenticacao.btnAjudaGMailClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmRelAjudaMod, frmRelAjudaMod);
    If Not lkpProvedores.ListSource.Dataset.FieldByName('PRV_USAOA2').AsString.Equals('S') Then
      pPreviewReport(Self.Name, 'Registro de ajuda (Configurações Gmail)', frmRelAjudaMod.frxAjudaGmail)
    Else
      pPreviewReport(Self.Name, 'Registro de ajuda (Configurações Outlook/Office 365)', frmRelAjudaMod.frxAjudaOutlook);
  Finally
    FreeAndNil(frmRelAjudaMod);
  End;
end;

procedure TfrmCfgEmailAutenticacao.btnConfirmaClick(Sender: TObject);
begin

  ModalResult := mrOk;

  If (Not fVerificaCampos) Then
  Begin
    ModalResult := mrNone;
    Exit;
  End;

  If FValidacaoObrigatoria Then
  Begin
    fMensagem('ATENÇÃO', 'Os dados de autorização do e-mail foram alterados e ' +
                         'é obrigatória a validação dos dados informados.' + #13 +
                         'Clique em validar dados antes de confirmar as alterações.', ['&Ok']);
    ModalResult := mrNone;
    Exit;
  End;

  pGravar;

  inherited;

end;

procedure TfrmCfgEmailAutenticacao.btnLimparAssinaturaClick(Sender: TObject);
begin
  inherited;
  imgAssinatura.Picture.Assign(nil);
  cdsCfgEma.Edit;
  cdsCfgEma.FieldByName('CFG_ASSB64').Clear;
  cdsCfgEma.Post;
end;

procedure TfrmCfgEmailAutenticacao.btnValidarDadosEmailClick(Sender: TObject);
  Var
    blnConexaoProvedor: Boolean;
    objAutenticacaoEmail: TAutenticacaoEmail;

  procedure pAlterarGlyphButton(Var button: TSpeedButton; intIndexImage: Integer); begin
    button.Glyph.Assign(nil);
    imgValidacaoEmail.GetBitmap(intIndexImage, button.Glyph);
  end;
begin
  If (lkpProvedores.KeyValue = null) Or (fEmptyStr(dbeEmailOper.Text)) Or
    (lkpProvedores.ListSource.Dataset.FieldByName('PRV_USAOA2').AsString.Equals('N') And fEmptyStr(edtSenhaEmail.Text)) Then
  Begin
    fMensagem('AVISO!', 'Informe os dados de autenticação da conta de e-mail!', ['&OK']);

    Exit;
  End;

  FValidacaoObrigatoria := False;

  Try
    btnValidarDadosEmail.Caption := 'Aguarde...';
    btnValidarDadosEmail.Enabled := False;

    pAlterarGlyphButton(btnDadosSmtp, 2);
    pAlterarGlyphButton(btnDadosImap, 2);
    pAlterarGlyphButton(btnAutenticacaoSmtp, 2);

    blnConexaoProvedor := False;

    Application.ProcessMessages;

    objAutenticacaoEmail := TAutenticacaoEmail.Create(strLoginUsuarioLogado,
                                                      dbeEmailOper.Text,
                                                      dbeLoginEmail.Text,
                                                      dbeRemetente.Text,
                                                      edtSenhaEmail.Text,
                                                      lkpProvedores.KeyValue,
                                                      Not lkpProvedores.ListSource.Dataset.FieldByName('PRV_USAOA2').AsString.Equals('S'));

    If TAutenticacaoEmail.fValidarAutenticacaoSmtp(Self, objAutenticacaoEmail, blnConexaoProvedor, True) Then
    Begin
      If (blnConexaoProvedor) Then
        pAlterarGlyphButton(btnDadosSmtp, 0)
      Else
      Begin
        pAlterarGlyphButton(btnDadosSmtp, 1);
        FValidacaoObrigatoria := True;
      End;

      pAlterarGlyphButton(btnAutenticacaoSmtp, 0);

      FEmailIdAzure := objAutenticacaoEmail.EmailIdAzure;
    End
    Else
    Begin
      If (blnConexaoProvedor) Then
        pAlterarGlyphButton(btnDadosSmtp, 0)
      Else
        pAlterarGlyphButton(btnDadosSmtp, 1);

      fMensagem('DADOS SMTP', 'Não foi possível conectar com o servidor SMTP. Verifique o e-Mail e senha informados ou os dados do provedor nas configurações do sistema e tente novamente!', ['&OK']);
      pAlterarGlyphButton(btnAutenticacaoSmtp, 1);

      FValidacaoObrigatoria := True;
    End;

    Application.ProcessMessages;

    If TAutenticacaoEmail.fValidarAutenticacaoImap(objAutenticacaoEmail) Then
      pAlterarGlyphButton(btnDadosImap, 0)
    Else
    Begin
      fMensagem('DADOS IMAP', 'Não foi possível conectar com o servidor IMAP. Verifique o e-Mail e senha informados ou os dados do provedor nas configurações do sistema e tente novamente!', ['&OK']);
      pAlterarGlyphButton(btnDadosImap, 1);

      If Not FValidacaoObrigatoria Then
      Begin
        FValidacaoObrigatoria := objAutenticacaoEmail.strGravaPastaEnviados = 'S';

        If FValidacaoObrigatoria Then
          fMensagem('ATENÇÃO', 'O provedor ' + lkpProvedores.Text + ' está marcado para gravar os e-mails ' +
                               'na pasta "Enviados". Portanto é obrigatória a validação do Provedor Imap.', ['&Ok']);
      End;
    End;

    Application.ProcessMessages;
  Finally
    btnValidarDadosEmail.Caption := 'Validar dados';
    btnValidarDadosEmail.Enabled := True;
    FreeAndNil(objAutenticacaoEmail);
  End;
end;

procedure TfrmCfgEmailAutenticacao.chkMostrarSenhaClick(Sender: TObject);
begin
  inherited;
  If (chkMostrarSenha.Checked) Then
    edtSenhaEmail.PasswordChar := #0
  Else
    edtSenhaEmail.PasswordChar := '*';
end;

procedure TfrmCfgEmailAutenticacao.dbeEmailOperChange(Sender: TObject);
begin
  inherited;
  FValidacaoObrigatoria := True;
end;

procedure TfrmCfgEmailAutenticacao.dbeEmailOperExit(Sender: TObject);
begin
  inherited;
  If (dbeEmailOper.DataSource.DataSet.State In [dsInsert, dsEdit]) Then
  Begin
    If Not FValidacaoObrigatoria Then
      Exit;

    If lkpProvedores.ListSource.DataSet.FieldByName('PRV_USAOA2').AsString.Equals('S') Then
    Begin
      If dbeEmailOper.DataSource.DataSet.FieldByName('CFG_EMAIL_').OldValue <> dbeEmailOper.DataSource.DataSet.FieldByName('CFG_EMAIL_').Value Then
        dbeLoginEmail.DataSource.DataSet.FieldByName('CFG_EMALOG').AsString := dbeEmailOper.Text;
    End;
  End;
end;

procedure TfrmCfgEmailAutenticacao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(objCadPrvController);
  FreeAndNil(cdsCfgEma);
  FreeAndNil(qryCfgEma);
end;

procedure TfrmCfgEmailAutenticacao.FormCreate(Sender: TObject);
begin
  inherited;
  qryCfgEma := fCriaQuery(Self);
end;

procedure TfrmCfgEmailAutenticacao.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaConfiguracao;
  objCadPrvController      := TCadastroProvedores.Create(Self);
  lkpProvedores.ListSource := objCadPrvController.fListarTodosProvedores();

  lkpProvedores.OnClick(lkpProvedores);
end;

function TfrmCfgEmailAutenticacao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = lkpProvedores) Then
    Begin

      If (lkpProvedores.KeyValue = null) Or (lkpProvedores.KeyValue = 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Provedor de e-mail deve ser informado!', ['&O k']);
        Result := False;
      End;

    End

    Else If (Sender = dbeEmailOper) Then
    Begin
      If (fEmptyStr(dbeEmailOper.Text)) then
      Begin
        fMensagem('ATENÇÃO!', 'O e-mail deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (Not fEmailValido(dbeEmailOper.Text, False)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O e-mail informado é inválido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = dbeLoginEmail) Then
    Begin
      If ((lkpProvedores.KeyValue <> null) or (not fEmptyStr(dbeEmailOper.Text)))
        and (fEmptyStr(dbeLoginEmail.Text)) Then
      Begin
        fMensagem('', 'O campo Login deve ser informado!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtSenhaEmail) Then
    Begin
      If (fEmptyStr(edtSenhaEmail.Text)) then
      Begin
        If Not lkpProvedores.ListSource.Dataset.FieldByName('PRV_USAOA2').AsString.Equals('S') Then
        Begin
          fMensagem('ATENÇÃO!', 'A senha do e-mail deve ser preenchida!', ['&O k']);
          Result := False;
        End;
      End ;
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCfgEmailAutenticacao.lkpProvedoresClick(Sender: TObject);
begin
  inherited;
  btnAjudaGmail.Visible := False;

  If fEmptyStr(lkpProvedores.Text) Then
    Exit;

  btnAjudaGmail.Visible := Pos('.gmail.com',
                               Concat(lkpProvedores.ListSource.Dataset.FieldByName('PRV_URIMAP').AsString,
                                      lkpProvedores.ListSource.Dataset.FieldByName('PRV_URSMTP').AsString)
                               .ToLower) > 0;

  lblSenhaEmail.Visible := True;
  edtSenhaEmail.Visible := True;
  chkMostrarSenha.Visible := True;

  If cdsCfgEma.IsEmpty Then
    Exit;

  If fEmptyStr(lkpProvedores.Text) Then
    Exit;

  lblSenhaEmail.Visible := Not lkpProvedores.ListSource.Dataset.FieldByName('PRV_USAOA2').AsString.Equals('S');
  edtSenhaEmail.Visible := lblSenhaEmail.Visible;
  chkMostrarSenha.Visible := lblSenhaEmail.Visible;

  btnAjudaGmail.Visible := Not lblSenhaEmail.Visible;

  FValidacaoObrigatoria := True;
end;

procedure TfrmCfgEmailAutenticacao.pCarregaConfiguracao;
Var
  strSQL: String;
begin

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT                 ';
    strSQL := strSQL + '  *                    ';
    strSQL := strSQL + 'FROM                   ';
    strSQL := strSQL + '  CFGEMA               ';
    strSQL := strSQL + 'WHERE                  ';
    strSQL := strSQL + '  CFG_SEQGER = :SEQGER ';

    qryCfgEma.Close;
    qryCfgEma.SQL.Clear;
    qryCfgEma.SQL.Add(strSQL);
    qryCfgEma.ParamByName('SEQGER').AsString := strSeqGer;
    qryCfgEma.Open;

    cdsCfgEma := fCriaClientDatSet(qryCfgEma);
    cdsCfgEma.Open;

    dtsCfgEma.DataSet := cdsCfgEma;

    pCarregaImagem;
    edtSenhaEmail.Text       := CriptografarSenhaEmail(cdsCfgEma.FieldByName('CFG_SENEMA').AsString);
    mmoAssinatura.Lines.Text := AnsiReplaceStr(cdsCfgEma.FieldByName('CFG_ASSTXT').AsString, STRING_QUEBRA, STRING_ENTER);

    FValidacaoObrigatoria := cdsCfgEma.FieldByName('CFG_EMAIL_').AsString.Trim.IsEmpty;

    FEmailIdAzure := cdsCfgEma.FieldByName('CFG_EMA_ID').AsString;
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmCfgEmailAutenticacao.pCarregaConfiguracao]');
  End;

end;

procedure TfrmCfgEmailAutenticacao.pCarregaImagem;
var
  LPict: TPicture;
begin
  If (Not fEmptyStr(cdsCfgEma.FieldByName('CFG_ASSB64').AsString)) Then
  Begin
    LPict := TPicture.Create();
    Try
      pImagemFromBase64(cdsCfgEma.FieldByName('CFG_ASSB64').AsString, LPict);

      imgAssinatura.Picture.Assign(LPict);
    Finally
      FreeAndNil(LPict);
    End;
  End
  Else
    imgAssinatura.Picture.Assign(nil);
end;

procedure TfrmCfgEmailAutenticacao.pGravar;
Var
  qryGrava: TUniQuery;
  
  function fApagaRegistroAtual: Boolean;
  Begin
    Result := False;

    Try
      qryGrava.Close;
      qryGrava.SQL.Text := 'DELETE FROM CFGEMA WHERE CFG_SEQGER = :SEQGER';
      qryGrava.ParamByName('SEQGER').AsString := strSeqGer;
      qryGrava.ExecSQL;

      Result := True;
    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[fApagaRegistroAtual]');
    End;

  End;

  function fGrava: Boolean;
  Begin

    Result := False;

    Try
      qryGrava.Close;
      qryGrava.SQL.Text := 'SELECT * FROM CFGEMA WHERE FALSE';
      qryGrava.Open;

      qryGrava.Append;
      qryGrava.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('CFGEMA', VS_strCodEmp);
      qryGrava.FieldByName('CFG_CODEMP').AsString  := VS_strCodEmp;
      qryGrava.FieldByName('CFG_SEQGER').AsString  := strSeqGer;
      qryGrava.FieldByName('CFG_CODPRV').AsInteger := cdsCfgEma.FieldByName('CFG_CODPRV').AsInteger;
      qryGrava.FieldByName('CFG_EMAIL_').AsString  := cdsCfgEma.FieldByName('CFG_EMAIL_').AsString;
      qryGrava.FieldByName('CFG_EMALOG').AsString  := cdsCfgEma.FieldByName('CFG_EMALOG').AsString;
      qryGrava.FieldByName('CFG_SENEMA').AsString  := CriptografarSenhaEmail(edtSenhaEmail.Text);
      qryGrava.FieldByName('CFG_ASSTXT').AsString  := mmoAssinatura.Text;
      qryGrava.FieldByName('CFG_REMETE').AsString  := cdsCfgEma.FieldByName('CFG_REMETE').AsString;
      qryGrava.FieldByName('CFG_ASSB64').AsString  := cdsCfgEma.FieldByName('CFG_ASSB64').AsString;
      qryGrava.FieldByName('CFG_EMA_ID').AsString  := FEmailIdAzure;
      qryGrava.Post;

      Result := True;
    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[fApagaRegistroAtual]');
    End;

  End;

begin

  Try

    qryGrava := fCriaQuery(Self);

    If (fApagaRegistroAtual) Then
    Begin
      If (fGrava) Then
        fMensagem('', 'Configuração de e-mail gravada com sucesso!', ['&O k']);
    End;

  Finally
    qryGrava.Close;

    FreeAndNil(qryGrava);
  End;

end;

end.
