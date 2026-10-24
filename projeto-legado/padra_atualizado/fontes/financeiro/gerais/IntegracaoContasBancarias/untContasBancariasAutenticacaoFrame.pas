unit untContasBancariasAutenticacaoFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, Vcl.DBCtrls,
  DBMemoFocus, Vcl.Buttons, BitBtnLockedIncrem, cxButtons, EditFocus, Vcl.Mask,
  DBEditFocus, MemoFocus, System.StrUtils, cxProgressBar, untTFuncoesAuxiliaresPix;

type
  TfraContasBancariasAutenticacaoFrame = class(TFrame)
    pnlFundo: TPanel;
    pnlChaveAppDev: TPanel;
    lblChaveAppDev: TLabel;
    edtChaveAppDev: TEditFocus;
    pnlChavesClient: TPanel;
    lblClientID: TLabel;
    lblClientSecret: TLabel;
    edtClientID: TEditFocus;
    edtClientSecret: TEditFocus;
    pnlCertificadoPFX: TPanel;
    Label8: TLabel;
    edtArquivoPFX: TEditFocus;
    btnArquivoPFX: TcxButton;
    pnlDadosCertificado: TPanel;
    pnlChaveBasic: TPanel;
    lblChaveBasic: TLabel;
    btnGerarChaveBasic: TBitBtnLocked;
    edtChaveBasic: TMemoFocus;
    pnlCertificados: TPanel;
    lblArquivoCRT: TLabel;
    lblArquivoKey: TLabel;
    edtArquivoCRT: TEditFocus;
    edtArquivoKey: TEditFocus;
    btnArquivoKey: TcxButton;
    btnArquivoCRT: TcxButton;
    lblValidadeCertificado: TLabel;
    edtValidadeCertificado: TEditFocus;
    pnlSenhaCertificado: TPanel;
    edtSenhaCertificado: TEditFocus;
    lblSenhaCertificado: TLabel;
    pnlStatusAPI: TPanel;
    lblMensagem: TLabel;
    pnlAmbiente: TPanel;
    btnValidarDadosPix: TBitBtnLocked;
    lblAmbienteAPITexto: TLabel;
    lblAmbienteAPI: TLabel;
    procedure btnArquivoPFXClick(Sender: TObject);
    procedure btnGerarChaveBasicClick(Sender: TObject);
    procedure btnArquivoCRTClick(Sender: TObject);
    procedure btnArquivoKeyClick(Sender: TObject);
  private
    FCodigoBanco: String;

    function RetornaDadosCertificadoPFX(pgbStatus: TcxProgressBar): Boolean;
    function RetornaValidadeCertificado(pgbStatus: TcxProgressBar): Boolean;
    function RetornaPastaOpenSSL: String;
    procedure LimparCampos;

    function RetornaMensagemBanco(ACodigoBanco: String): String;
    function TodasAsDependenciasEstaoNaPasta(ADiretorioOpenSSL: String): Boolean;
    { Private declarations }
  public
    procedure CarregaCampos(ACodigoBanco: String);
    { Public declarations }
  end;

implementation
Uses untFuncoesSimples, untGravando;
{$R *.dfm}

{ TfraContasBancariasAutenticacaoFrame }

procedure TfraContasBancariasAutenticacaoFrame.btnArquivoCRTClick(
  Sender: TObject);
  Var
    LCaixaDialogo: TOpenDialog;

    LGravando: TfrmGravando;
begin
  LCaixaDialogo := TOpenDialog.Create(nil);
  try
    LCaixaDialogo.Title := 'Selecione o certificado';
    LCaixaDialogo.Filter := 'Arquivos de Certificado (*.crt;*.pem)|*.crt;*.pem';

    LCaixaDialogo.Options := [ofPathMustExist];

    If LCaixaDialogo.Execute Then
    Begin
      edtArquivoCRT.Text := LCaixaDialogo.FileName;

      pCriarFormularios(TfrmGravando, LGravando);
      LGravando.lblGravando.Caption := 'Aguarde... Selecionando certificado.';
      LGravando.fExecutarAcao := RetornaValidadeCertificado;
      LGravando.ShowModal;

      FreeAndNil(LGravando);
    End;
  finally
    LCaixaDialogo.Free;
  end;
end;

procedure TfraContasBancariasAutenticacaoFrame.btnArquivoKeyClick(
  Sender: TObject);
  Var
    LCaixaDialogo: TOpenDialog;
begin
  LCaixaDialogo := TOpenDialog.Create(nil);
  try
    LCaixaDialogo.Title := 'Selecione o arquivo KEY';

    LCaixaDialogo.Options := [ofPathMustExist];

    LCaixaDialogo.Filter := 'Arquivos de Certificado (*.key;*.pem)|*.key;*.pem';

    If LCaixaDialogo.Execute Then
      edtArquivoKey.Text := LCaixaDialogo.FileName;
  finally
    LCaixaDialogo.Free;
  end;
end;

procedure TfraContasBancariasAutenticacaoFrame.btnArquivoPFXClick(Sender: TObject);
  Var
    LCaixaDialogo: TOpenDialog;

    LGravando: TfrmGravando;
begin
  If edtSenhaCertificado.Visible Then
  Begin
    If fEmptyStr(edtSenhaCertificado.Text) Then
    Begin
      fMensagem('ATENÇÃO', 'Para selecionar o arquivo PFX é necessário digitar a senha do certificado.', ['&Ok']);
      Exit;
    End;
  End;

  LCaixaDialogo := TOpenDialog.Create(nil);
  try
    LCaixaDialogo.Title := 'Selecione o arquivo PFX';

    LCaixaDialogo.Options := [ofPathMustExist];

    LCaixaDialogo.Filter := 'Certificado PFX|*.pfx';

    If LCaixaDialogo.Execute Then
    Begin
      edtArquivopfx.Text := LCaixaDialogo.FileName;

      pCriarFormularios(TfrmGravando, LGravando);
      LGravando.lblGravando.Caption := 'Aguarde... Carregando Arquivo PFX.';
      LGravando.fExecutarAcao := RetornaDadosCertificadoPFX;
      LGravando.ShowModal;
      FreeAndNil(LGravando);
    End;
  finally
    LCaixaDialogo.Free;
  end;
end;

procedure TfraContasBancariasAutenticacaoFrame.btnGerarChaveBasicClick(
  Sender: TObject);
begin
  If fEmptyStr(edtClientID.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'O campo Client ID deve ser preenchido.', ['&Ok']);
    pSetFocus(edtClientID);

    Exit;
  End;

  If fEmptyStr(edtClientSecret.Text) Then
  Begin
    fMensagem('ATENÇÃO', 'O campo Client Secret deve ser preenchido.', ['&Ok']);
    pSetFocus(edtClientSecret);

    Exit;
  End;

  If Not fEmptyStr(edtChaveBasic.Text) Then
  Begin
    If fMensagem('ATENÇÃO', 'Já existe dados no campo Autorização Basic. Se utilizar essa função, irá sobrepor seu conteúdo.' + #13 +
                            'Deseja realmente continuar?', ['&Sim', '&Não']) = 2 Then
      Exit;
  End;

 edtChaveBasic.Text := TFuncoesPix.RetornaChaveBasic(edtClientID.Text,
                                                     edtClientSecret.Text);
end;

procedure TfraContasBancariasAutenticacaoFrame.CarregaCampos(ACodigoBanco: String);
begin

  If Trim(ACodigoBanco).IsEmpty Then
    Exit;

  If Not FCodigoBanco.Equals(ACodigoBanco) Then
    LimparCampos;

  FCodigoBanco := ACodigoBanco;

  //seta considerando os paineis de baixo para cima
  pnlStatusAPI.Align := alNone;
  pnlChaveBasic.Align := alNone;
  pnlCertificadoPFX.Align := alNone;
  pnlDadosCertificado.Align := alNone;
  pnlCertificados.Align := alNone;
  pnlChavesClient.Align := alNone;
  pnlChaveAppDev.Align := alNone;

  pnlChaveAppDev.Visible := MatchStr(FCodigoBanco, ['001']);
  pnlChavesClient.Visible := MatchStr(FCodigoBanco, ['001','341']);
  pnlCertificados.Visible := MatchStr(FCodigoBanco, ['341']);
  pnlCertificadoPFX.Visible := MatchStr(FCodigoBanco, ['001']);
  pnlDadosCertificado.Visible := MatchStr(FCodigoBanco, ['001','341']);
  pnlSenhaCertificado.Visible := MatchStr(FCodigoBanco, ['001']);
  pnlChaveBasic.Visible := MatchStr(FCodigoBanco, ['001']);
  pnlStatusAPI.Visible := MatchStr(FCodigoBanco, ['001','341']);

  //seta considerando os paineis de cima para baixa
  pnlChaveAppDev.Align := alTop;
  pnlChavesClient.Align := alTop;
  pnlCertificados.Align := alTop;
  pnlDadosCertificado.Align := alTop;
  pnlCertificadoPFX.Align := alTop;
  pnlChaveBasic.Align := alTop;
  pnlStatusAPI.Align := AlBottom;
  pnlStatusAPI.Align := alTop;


  lblMensagem.Visible := MatchStr(FCodigoBanco, ['001']);
  lblMensagem.Caption := RetornaMensagemBanco(FCodigoBanco);
end;

procedure TfraContasBancariasAutenticacaoFrame.LimparCampos;
begin
  edtChaveAppDev.Clear;
  edtChaveBasic.Clear;
  edtArquivoPFX.Clear;
  edtClientId.Clear;
  edtClientSecret.Clear;
  edtSenhaCertificado.Clear;
  edtValidadeCertificado.Clear;
  lblAmbienteAPI.Caption := 'PRODUÇÃO';
  lblAmbienteAPI.Font.Color := clBlue;
end;

function TfraContasBancariasAutenticacaoFrame.RetornaDadosCertificadoPFX(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    LOpenSSL,
    LComando,
    LArqPem,
    LArqDados,
    LPastaOpenSSL,
    LMensagemErro: String;

    LDados: TStringList;

    LDataCertificado: TDateTime;
begin
  Result := True;

  LPastaOpenSSL := RetornaPastaOpenSSL;

  If LPastaOpenSSL.IsEmpty Then
  Begin
    edtArquivoPfx.Clear;
    Exit(False);
  End;

  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := 3;

  LOpenSSL := LPastaOpenSSL + 'openssl.exe';

  LArqPem  := LPastaOpenSSL + 'certificado.pem';

  LComando := ' /C ' + LOpenSSL + ' pkcs12 -in "' + edtArquivoPFX.Text + '" ';
  LComando := LComando + ' -passin pass:'+ edtSenhaCertificado.Text;
  LComando := LComando + ' -out "' + LArqPem + '" -nokeys';

  DeleteFile(LArqPem);
  Sleep(200);

  If FileExists(LArqPem) Then
  Begin
    fMensagem('ATENÇÃO', 'Apague o arquivo ' + LArqPem + ' para que possa ser gerado um novo.' , ['&Ok'], 0);
    edtArquivoPfx.Clear;
    Exit(False);
  End;

  ExecutaComandoWindows('', 'cmd.exe', PWideChar(LComando), '', SW_HIDE, True);
  Sleep(800);

  pgbStatus.Position := 1;

  //Validade
  LArqDados := LPastaOpenSSL + 'validade.pem';
  LComando := ' /C ' + LOpenSSL + ' x509 -in "' + LArqPem + '" ';
  LComando := LComando + ' -passin pass:'+ edtSenhaCertificado.Text;
  LComando := LComando + ' -noout -enddate > "' + LArqDados + '"';

  ExecutaComandoWindows('', 'cmd.exe', PWideChar(LComando), '', SW_HIDE, True);
  Sleep(800);

  LDataCertificado := RetornaDataValidadeArquivoPEM(LArqDados);
  DeleteFile(LArqDados);

  pgbStatus.Position := 2;

  edtValidadeCertificado.Clear;
  If LDataCertificado = 0 Then
  Begin
    LMensagemErro := 'Não foi possível retornar a validade do certificado selecionado. ' + #13 +
                     'Verifique se é um arquivo válido de certificado';

    If edtSenhaCertificado.Visible Then
      LMensagemErro := LMensagemErro + ' ou se a senha digitada está correta';
    LMensagemErro := LMensagemErro + '.';

    fMensagem('ATENÇÃO', LMensagemErro, ['&Ok']);

    edtArquivoPfx.Clear;
    Exit(False);
  End
  Else
    edtValidadeCertificado.Text := FormatDateTime('dd/mm/yyyy', LDataCertificado);

  pgbStatus.Position := 3;

  FreeAndNil(LDados);

  DeleteFile(LArqDados);
end;

function TfraContasBancariasAutenticacaoFrame.RetornaMensagemBanco(
  ACodigoBanco: String): String;
begin
  Result := EmptyStr;

  If ACodigoBanco.Equals('001') Then
    Result := 'ATENÇÃO: É necessário vincular o certificado cadastrado no Portal Developers do Banco do Brasil.' + #13 +
              '                  Caso não seja feito, o banco não conseguirá realizar a autenticação.';
end;

function TfraContasBancariasAutenticacaoFrame.RetornaPastaOpenSSL: String;
begin
  Result := ExtractFilePath(Application.ExeName);

  Result := Result + 'openssl32\';

  if not TodasAsDependenciasEstaoNaPasta(Result) then
    Exit(EmptyStr);
end;

function TfraContasBancariasAutenticacaoFrame.TodasAsDependenciasEstaoNaPasta(
  ADiretorioOpenSSL: String): Boolean;
const
  LArquivosUtilizados: array of string = ['openssl.exe'];
var
  LArquivo: String;
begin
  Result := True;
  for LArquivo in LArquivosUtilizados do
  begin
    if not FileExists(ADiretorioOpenSSL + LArquivo) then
    begin
      fMensagem('ATENÇÃO', 'O arquivo ' + LArquivo + ' não foi encontrado na pasta ' + ADiretorioOpenSSL, ['&Ok']);
      Exit(False);
    end;
  end;
end;

function TfraContasBancariasAutenticacaoFrame.RetornaValidadeCertificado(pgbStatus: TcxProgressBar): Boolean;
  Var
    LOpenSSL,
    LComando,
    LArqPem,
    LPastaOpenSSL: String;

    LDataCertificado: TDateTime;
begin
  Result := True;

  LPastaOpenSSL := RetornaPastaOpenSSL;

  If LPastaOpenSSL.IsEmpty Then
    Exit(False);

  If pnlSenhaCertificado.Visible Then
  Begin
    If fEmptyStr(edtSenhaCertificado.Text) Then
    Begin
      fMensagem('ATENÇÃO', 'É necessário digitar a senha do certificado antes de selecionar o arquivo.', ['&Ok']);
      edtArquivoCrt.Clear;
      Exit(False);
    End;
  End;

  LOpenSSL := LPastaOpenSSL + 'openssl.exe';

  LArqPem  := LPastaOpenSSL + 'validade.pem';

  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := 2;

  LComando := ' /C ' + LOpenSSL + ' x509 -in "' + edtArquivoCRT.Text + '" ';
  If (Not fEmptyStr(edtSenhaCertificado.Text)) Then
    LComando := LComando + ' -passin pass:'+ edtSenhaCertificado.Text;
  LComando := LComando + ' -noout -enddate > "' + LArqPem + '"';

  DeleteFile(LArqPem);
  Sleep(200);

  If FileExists(LArqPem) Then
  Begin
    fMensagem('ATENÇÃO', 'Apague o arquivo ' + LArqPem + ' para que possa ser gerado um novo.' , ['&Ok'], 0);
    Exit(False);
  End;

  pgbStatus.Position := 1;

  ExecutaComandoWindows('', 'cmd.exe', PWideChar(LComando), '', SW_HIDE, True);
  Sleep(400);

  LDataCertificado := RetornaDataValidadeArquivoPEM(LArqPem);
  edtValidadeCertificado.Clear;
  If LDataCertificado = 0 Then
  Begin
    fMensagem('ATENÇÃO', 'Não foi possível retornar a validade do certificado selecionado. ' + #13 +
                         'Verifique se é um arquivo válido de certificado.', ['&Ok']);

    Result := False;
  End
  Else
    edtValidadeCertificado.Text := FormatDateTime('dd/mm/yyyy', LDataCertificado);

  pgbStatus.Position := 2;

  DeleteFile(LArqPem);
end;

end.
