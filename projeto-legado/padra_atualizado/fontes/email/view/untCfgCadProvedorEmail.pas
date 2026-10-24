unit untCfgCadProvedorEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, untPai, Data.DB, Vcl.Grids, Vcl.DBGrids,
  DBGridCitel, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxSpinEdit, EditFocus, Uni, untFuncoesSimples,
  System.ImageList, Vcl.ImgList, System.StrUtils, untTCadastroProvedores;

type
  TOperacaoForm = (ofNone, ofIncluir, ofGravar, ofAlterar, ofExcluir, ofCancelar);

  TfrmCfgCadProvedorEmail = class(TfrmPai)
    grpDadosProvedor: TGroupBox;
    grpProvedores: TGroupBox;
    grdProvedores: TDBGridCitel;
    lblNomeProvedor: TLabel;
    lblPortaSmtp: TLabel;
    lblSmtp: TLabel;
    lblLimiteAnexos: TLabel;
    spnPortaSmtp: TcxSpinEdit;
    edtNome: TEditFocus;
    edtSmtp: TEditFocus;
    spnLimite: TcxSpinEdit;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    lblPortaImap: TLabel;
    lblImap: TLabel;
    spnPortaImap: TcxSpinEdit;
    edtImap: TEditFocus;
    btnDadosSmtp: TSpeedButton;
    imgValidacaoEmail: TImageList;
    btnDadosImap: TSpeedButton;
    btnAjuda: TBitBtnLocked;
    chkSSLSai: TCheckBox;
    chkSSLEnt: TCheckBox;
    chkGrvEnv: TCheckBox;
    Label1: TLabel;
    spnLimPHr: TcxSpinEdit;
    btnAjudaProvedores: TBitBtnLocked;
    spnLimiteDestinatarios: TcxSpinEdit;
    lblLimiteDestinatarios: TLabel;
    btnConfiguracoesOAuth2: TBitBtnLocked;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdProvedoresKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure spnPortaSmtpKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure spnLimiteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure spnPortaImapKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDadosSmtpClick(Sender: TObject);
    procedure btnDadosImapClick(Sender: TObject);
    procedure btnAjudaClick(Sender: TObject);
    procedure grdProvedoresDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtSmtpExit(Sender: TObject);
    procedure edtImapExit(Sender: TObject);
    procedure btnAjudaProvedoresClick(Sender: TObject);
    procedure btnConfiguracoesOAuth2Click(Sender: TObject);
  private
    { Private declarations }
    oper: TOperacaoForm;
    objCadPrvController: TCadastroProvedores;

    procedure pAtualizarComponentes(operacao: TOperacaoForm);
    procedure pLimparComponentes();

    procedure ExibeAjudaProvedores;
    procedure ExibeConfiguracoesOAuth2;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untTEnvioEmail, untFuncoesRel, untRelAjudaMod, untCfgCadProvedorOAuth2;

{ TfrmCfgCadProvedorEmail }

procedure TfrmCfgCadProvedorEmail.pAtualizarComponentes(operacao: TOperacaoForm);
begin
  oper := operacao;

  case (operacao) of
    ofNone, ofGravar, ofExcluir, ofCancelar:
      begin
        grpDadosProvedor.Enabled := False;
        grpProvedores.Enabled    := True;
        btnIncluir.Enabled       := True;
        btnGravar.Enabled        := False;
        btnAlterar.Enabled       := True;
        btnExcluir.Enabled       := True;
        btnCancela.Enabled       := False;
        blnFecharComEscape       := True;

        if (oper in [ofGravar, ofCancelar]) then
          oper := ofNone;
      end;
    ofIncluir, ofAlterar:
      begin
        grpDadosProvedor.Enabled := True;
        grpProvedores.Enabled    := False;
        btnIncluir.Enabled       := False;
        btnGravar.Enabled        := True;
        btnAlterar.Enabled       := False;
        btnExcluir.Enabled       := False;
        btnCancela.Enabled       := True;
        blnFecharComEscape       := False;
        pSetFocus(edtNome);
      end;
  end;

  btnDadosSmtp.Glyph.Assign(nil);
  btnDadosImap.Glyph.Assign(nil);
  imgValidacaoEmail.GetBitmap(1, btnDadosSmtp.Glyph);
  imgValidacaoEmail.GetBitmap(1, btnDadosImap.Glyph);

  ExibeConfiguracoesOAuth2;
end;

procedure TfrmCfgCadProvedorEmail.pLimparComponentes();
begin
  edtNome.Text       := '';
  edtSmtp.Text       := '';
  spnPortaSmtp.Value := 0;
  edtImap.Text       := '';
  spnPortaImap.Value := 0;
  spnLimite.Value    := 0;
  spnLimPHr.Value    := 0;
  spnLimiteDestinatarios.Value := 0;
  imgValidacaoEmail.GetBitmap(1, btnDadosSmtp.Glyph);
  imgValidacaoEmail.GetBitmap(1, btnDadosImap.Glyph);
  chkSSLEnt.Checked  := False;
  chkSSLSai.Checked  := False;
  chkGrvEnv.Checked  := False;
end;

procedure TfrmCfgCadProvedorEmail.spnLimiteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_RETURN) then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCfgCadProvedorEmail.spnPortaImapKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_RETURN) then
    btnGravar.Click();
end;

procedure TfrmCfgCadProvedorEmail.spnPortaSmtpKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_RETURN) then
    pSetFocus(chkSSLEnt);
end;

procedure TfrmCfgCadProvedorEmail.btnIncluirClick(Sender: TObject);
begin
  pAtualizarComponentes(ofIncluir);
end;

procedure TfrmCfgCadProvedorEmail.btnSairClick(Sender: TObject);
begin

  if (oper = ofNone) or (fMensagem('ATENÇÃO!',
    'Existe um registro em edição, ao fechar a tela os dados serão descartados. Deseja continuar?',
    ['&Sim','&Não'], 2) = 1) then
    inherited;
end;

procedure TfrmCfgCadProvedorEmail.edtImapExit(Sender: TObject);
begin
  inherited;
  ExibeAjudaProvedores;
  ExibeConfiguracoesOAuth2;
end;

procedure TfrmCfgCadProvedorEmail.edtSmtpExit(Sender: TObject);
begin
  inherited;
  ExibeAjudaProvedores;
  ExibeConfiguracoesOAuth2;
end;

procedure TfrmCfgCadProvedorEmail.FormCreate(Sender: TObject);
begin
  inherited;

  pAtualizarComponentes(ofNone);

  objCadPrvController      := TCadastroProvedores.Create(Self);
  grdProvedores.DataSource := objCadPrvController.fListarTodosProvedores();
end;

procedure TfrmCfgCadProvedorEmail.grdProvedoresDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  inherited;
  If (Column.Field.DataSet.RecNo Mod 2) = 0 Then
    Begin
      grdProvedores.Canvas.Brush.Color := fCfgSis('CORZEB');
      grdProvedores.Canvas.FillRect(Rect);
      grdProvedores.DefaultDrawColumnCell(Rect,DataCol,Column,State);
    End;
end;

procedure TfrmCfgCadProvedorEmail.grdProvedoresKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  if (Key = VK_DELETE) then
    btnExcluir.Click()
  else if (Key = VK_RETURN) then
    btnAlterar.Click()
  else if (Key = VK_ESCAPE) and (oper = ofNone) then
    btnSair.Click();
end;

procedure TfrmCfgCadProvedorEmail.btnGravarClick(Sender: TObject);
  var
    blnConfirma: Boolean;

  procedure pDefinirComponenteFocoValidacao();
  begin
    case (objCadPrvController.campoValidacao) of
      cvNome      : pSetFocus(edtNome);
      cvSmtp      : pSetFocus(edtSmtp);
      cvPortaSmtp : pSetFocus(spnPortaSmtp);
      cvLimite    : pSetFocus(spnLimite);
      cvLimPHr    : pSetFocus(spnLimPHr);
      cvImap      : pSetFocus(edtImap);
      cvPortaImap : pSetFocus(spnPortaImap);
    end;
  end;
begin
  blnConfirma := False;

  case (oper) of
    ofIncluir:
      begin
        blnConfirma := objCadPrvController.fGravar(objCadPrvController.fCriaObjetoCadPrv(edtNome.Text,
                         edtSmtp.Text, edtImap.Text, spnPortaSmtp.Value, spnPortaImap.Value,
                         spnLimite.Value, spnLimPHr.Value, chkSSLEnt.Checked, chkSSLSai.Checked, IIF(chkGrvEnv.Checked,'S','N')), opInserir);
      end;
    ofExcluir:
      begin
        objCadPrvController.objCadPrv := objCadPrvController.fPEsquisaCadPrvByCod(
          grdProvedores.DataSource.DataSet.FieldByName('PRV_CODPRV').AsInteger);

        blnConfirma := objCadPrvController.fGravar(objCadPrvController.objCadPrv, opExcluir);
      end;
    ofAlterar:
      begin
        objCadPrvController.objCadPrv := objCadPrvController.fPEsquisaCadPrvByCod(
          grdProvedores.DataSource.DataSet.FieldByName('PRV_CODPRV').AsInteger);

        objCadPrvController.objCadPrv.Edit;
        objCadPrvController.objCadPrv.FieldByName('PRV_NOMPRV').AsString := edtNome.Text;
        objCadPrvController.objCadPrv.FieldByName('PRV_URSMTP').AsString := edtSmtp.Text;
        objCadPrvController.objCadPrv.FieldByName('PRV_PORPRV').AsInteger := spnPortaSmtp.Value;
        objCadPrvController.objCadPrv.FieldByName('PRV_URIMAP').AsString := edtImap.Text;
        objCadPrvController.objCadPrv.FieldByName('PRV_PTIMAP').AsInteger := spnPortaImap.Value;
        objCadPrvController.objCadPrv.FieldByName('PRV_LIMARQ').AsInteger := spnLimite.Value;
        objCadPrvController.objCadPrv.FieldByName('PRV_LIMPHR').AsInteger := spnLimPHr.Value;
        objCadPrvController.objCadPrv.FieldByName('PRV_LIMDES').AsInteger := spnLimiteDestinatarios.Value;

        If (chkSSLSai.Checked) Then
          objCadPrvController.objCadPrv.FieldByName('PRV_SSLSAI').AsString := 'S'
        Else
          objCadPrvController.objCadPrv.FieldByName('PRV_SSLSAI').AsString := 'N';

        If (chkSSLEnt.Checked) Then
          objCadPrvController.objCadPrv.FieldByName('PRV_SSLENT').AsString := 'S'
        Else
          objCadPrvController.objCadPrv.FieldByName('PRV_SSLENT').AsString := 'N';

        If (chkGrvEnv.Checked) Then
          objCadPrvController.objCadPrv.FieldByName('PRV_GRVENV').AsString := 'S'
        Else
          objCadPrvController.objCadPrv.FieldByName('PRV_GRVENV').AsString := 'N';

        If Not btnConfiguracoesOAuth2.Visible Then
          objCadPrvController.objCadPrv.FieldByName('PRV_USAOA2').AsString := 'N';

        blnConfirma := objCadPrvController.fGravar(objCadPrvController.objCadPrv, opAtualizar);
      end;
  end;

  case (oper) of
    ofIncluir:
      begin
        if (blnConfirma) then
          fMensagem('Confirmação', 'Registro incluído com sucesso!', ['&Ok'])
        else
          pDefinirComponenteFocoValidacao();
      end;
    ofExcluir:
      begin
        if (blnConfirma) then
          fMensagem('Confirmação', 'Registro excluído com sucesso!', ['&Ok']);
      end;
    ofAlterar:
      begin
        if (blnConfirma) then
          fMensagem('Confirmação', 'Registro alterado com sucesso!', ['&Ok'])
        else
          pDefinirComponenteFocoValidacao();
      end;
  end;

  if (blnConfirma) then
  begin
    pLimparComponentes();
    grdProvedores.DataSource := objCadPrvController.fListarTodosProvedores();
    pAtualizarComponentes(ofGravar);
  end;
end;

procedure TfrmCfgCadProvedorEmail.btnExcluirClick(Sender: TObject);
begin
  if (not grdProvedores.DataSource.DataSet.IsEmpty) then
  begin
    pAtualizarComponentes(ofExcluir);
    btnGravar.Click();
  end
  else
    fMensagem('Alerta', 'Selecione um registro para excluir!', ['&Ok']);
end;

procedure TfrmCfgCadProvedorEmail.btnConfiguracoesOAuth2Click(Sender: TObject);
  Var
    LCfgCadProvedorOauth2: TfrmCfgCadProvedorOauth2;
begin
  inherited;

  If oper = ofIncluir Then
  Begin
    fMensagem('ATENÇÃO', 'Para utilizar essa opção, o provedor deve estar em modo de Alteração.', ['&Ok']);

    Exit;
  End;

  pCriarFormularios(TfrmCfgCadProvedorOauth2, LCfgCadProvedorOauth2);

  Try
    LCfgCadProvedorOauth2.lblServidorSMTP.Caption := edtSMTP.Text;
    LCfgCadProvedorOauth2.lblServidorIMAP.Caption := edtImap.Text;

    LCfgCadProvedorOauth2.chkUtilizarOAuth2.Checked := objCadPrvController.objCadPrv.FieldByName('PRV_USAOA2').AsString.Equals('S');
    LCfgCadProvedorOauth2.edtClientID.Text := objCadPrvController.objCadPrv.FieldByName('PRV_CLI_ID').AsString;
    LCfgCadProvedorOauth2.edtClientSecret.Text := objCadPrvController.objCadPrv.FieldByName('PRV_CLISEC').AsString;
    LCfgCadProvedorOauth2.edtTenantID.Text := objCadPrvController.objCadPrv.FieldByName('PRV_TENAID').AsString;

    LCfgCadProvedorOauth2.Provedor := objCadPrvController.objCadPrv.FieldByName('PRV_CODPRV').AsInteger;

    LCfgCadProvedorOauth2.ShowModal;

    If LCfgCadProvedorOauth2.ModalResult <> mrOk Then
      Exit;

    objCadPrvController.objCadPrv.Edit;

    objCadPrvController.objCadPrv.FieldByName('PRV_USAOA2').AsString := 'N';
    If LCfgCadProvedorOauth2.chkUtilizarOAuth2.Checked Then
      objCadPrvController.objCadPrv.FieldByName('PRV_USAOA2').AsString := 'S';

    objCadPrvController.objCadPrv.FieldByName('PRV_CLI_ID').AsString := LCfgCadProvedorOauth2.edtClientID.Text;
    objCadPrvController.objCadPrv.FieldByName('PRV_CLISEC').AsString := LCfgCadProvedorOauth2.edtClientSecret.Text;
    objCadPrvController.objCadPrv.FieldByName('PRV_TENAID').AsString := LCfgCadProvedorOauth2.edtTenantID.Text;

    objCadPrvController.objCadPrv.Post;

    fMensagem('ATENÇÃO', 'Dados de configuração OAuth2 gravados com sucesso.', ['&Ok']);
  Finally
    FreeAndNil(LCfgCadProvedorOauth2);
  End;
end;

procedure TfrmCfgCadProvedorEmail.btnAjudaClick(Sender: TObject);
begin
  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(128, 6061, [],
                        [],
                        [],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmCfgCadProvedorEmail.btnAjudaProvedoresClick(Sender: TObject);
begin
  inherited;
  Try
    pCriarFormularios(TfrmRelAjudaMod, frmRelAjudaMod);

    If Pos('.gmail.com', LowerCase(Concat(edtSmtp.Text, edtImap.Text))) > 0 Then
      pPreviewReport(Self.Name, 'Registro de ajuda (Configurações Gmail)', frmRelAjudaMod.frxAjudaGmail)
    Else
      pPreviewReport(Self.Name, 'Registro de ajuda (Configurações Outlook/Office 365)', frmRelAjudaMod.frxAjudaOutlook);
  Finally
    FreeAndNil(frmRelAjudaMod);
  End;
end;

procedure TfrmCfgCadProvedorEmail.btnAlterarClick(Sender: TObject);
begin
  if grdProvedores.DataSource.DataSet.IsEmpty then
  begin
    fMensagem('Alerta', 'Selecione um registro para alterar!', ['&Ok']);
    Exit;
  End;

  pAtualizarComponentes(ofAlterar);
  edtNome.Text       := grdProvedores.DataSource.DataSet.FieldByName('PRV_NOMPRV').AsString;
  edtSmtp.Text       := grdProvedores.DataSource.DataSet.FieldByName('PRV_URSMTP').AsString;
  spnPortaSmtp.Value := grdProvedores.DataSource.DataSet.FieldByName('PRV_PORPRV').AsInteger;
  edtImap.Text       := grdProvedores.DataSource.DataSet.FieldByName('PRV_URIMAP').AsString;
  spnPortaImap.Value := grdProvedores.DataSource.DataSet.FieldByName('PRV_PTIMAP').AsInteger;
  spnLimite.Value    := grdProvedores.DataSource.DataSet.FieldByName('PRV_LIMARQ').AsInteger;
  spnLimPHr.Value    := grdProvedores.DataSource.DataSet.FieldByName('PRV_LIMPHR').AsInteger;
  spnLimiteDestinatarios.Value := grdProvedores.DataSource.DataSet.FieldByName('PRV_LIMDES').AsInteger;

  ExibeAjudaProvedores;
  ExibeConfiguracoesOAuth2;

  chkSSLSai.Checked := grdProvedores.DataSource.DataSet.FieldByName('PRV_SSLSAI').AsString.Equals('S');
  chkSSLEnt.Checked := grdProvedores.DataSource.DataSet.FieldByName('PRV_SSLENT').AsString.Equals('S');
  chkGrvEnv.Checked := grdProvedores.DataSource.DataSet.FieldByName('PRV_GRVENV').AsString.Equals('S');
end;

procedure TfrmCfgCadProvedorEmail.btnCancelaClick(Sender: TObject);
begin
  pAtualizarComponentes(ofCancelar);
  pLimparComponentes();

  ExibeAjudaProvedores;
  btnConfiguracoesOAuth2.Visible := False;
end;

procedure TfrmCfgCadProvedorEmail.btnDadosImapClick(Sender: TObject);
  procedure pAlterarGlyphButton(Var button: TSpeedButton; intIndexImage: Integer); begin
    button.Glyph.Assign(nil);
    imgValidacaoEmail.GetBitmap(intIndexImage, button.Glyph);
  end;
begin
  If (Not fEmptyStr(edtImap.Text)) And (spnPortaImap.Value > 0) Then Begin
    Try
      btnDadosImap.Caption := 'Aguarde...';
      btnDadosImap.Enabled := False;

      pAlterarGlyphButton(btnDadosImap, 2);

      Application.ProcessMessages;

      If TAutenticacaoEmail.fValidarAutenticacaoImap(Self, strLoginUsuarioLogado, edtImap.Text, spnPortaImap.Value, chkSSLEnt.Checked) Then Begin
        pAlterarGlyphButton(btnDadosImap, 0);
      End Else Begin
        pAlterarGlyphButton(btnDadosImap, 1);
        If (fMensagem('ALERTA', 'Deseja consultar as orientações de configuração de provedores de e-Mail?', ['&Sim', '&Não'], 1) = 1) Then
          btnAjuda.Click();
      End;

      Application.ProcessMessages;
    Finally
      btnDadosImap.Caption := 'Validar';
      btnDadosImap.Enabled := True;
    End;
  End;
end;

procedure TfrmCfgCadProvedorEmail.btnDadosSmtpClick(Sender: TObject);
  procedure pAlterarGlyphButton(Var button: TSpeedButton; intIndexImage: Integer); begin
    button.Glyph.Assign(nil);
    imgValidacaoEmail.GetBitmap(intIndexImage, button.Glyph);
  end;
begin
  If (Not fEmptyStr(edtSmtp.Text)) And (spnPortaSmtp.Value > 0) Then Begin
    Try
      btnDadosSmtp.Caption := 'Aguarde...';
      btnDadosSmtp.Enabled := False;

      pAlterarGlyphButton(btnDadosSmtp, 2);

      Application.ProcessMessages;

      If TAutenticacaoEmail.fValidarAutenticacaoSmtp(Self, strLoginUsuarioLogado, edtSmtp.Text, spnPortaSmtp.Value, chkSSLSai.Checked) Then
        pAlterarGlyphButton(btnDadosSmtp, 0)
      Else
      Begin
        pAlterarGlyphButton(btnDadosSmtp, 1);
        If (fMensagem('ALERTA', 'Deseja consultar as orientações de configuração de provedores de e-mail?', ['&Sim', '&Não'], 1) = 1) Then
          btnAjuda.Click();
      End;

      Application.ProcessMessages;
    Finally
      btnDadosSmtp.Caption := 'Validar';
      btnDadosSmtp.Enabled := True;
    End;
  End;
end;

procedure TfrmCfgCadProvedorEmail.ExibeAjudaProvedores;
begin
  btnAjudaProvedores.Visible := Pos('.gmail.com', LowerCase(Concat(edtSmtp.Text, edtImap.Text))) > 0;

  If Not btnAjudaProvedores.Visible Then
    btnAjudaProvedores.Visible := MatchStr(edtSmtp.Text, ['smtp.office365.com', 'smtp-mail.outlook.com']);
end;

procedure TfrmCfgCadProvedorEmail.ExibeConfiguracoesOAuth2;
begin
  btnConfiguracoesOAuth2.Visible := False;

  If Not fEmptyStr(edtSmtp.Text) Then
    btnConfiguracoesOAuth2.Visible := MatchStr(LowerCase(edtSmtp.Text), ['smtp.office365.com', 'smtp-mail.outlook.com']);
end;

end.
