unit untDDAAPIAutenticacaoFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, untTFuncoesAuxiliaresPix,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus,
  untGravando, untFuncoesSimples, cxProgressBar, System.StrUtils,
  Vcl.StdCtrls, MemoFocus, Vcl.Buttons, BitBtnLockedIncrem,
  cxButtons, EditFocus, Vcl.ExtCtrls;

type
  TfraDDAAPIAutenticacaoFrame = class(TFrame)
    pnlFundo: TPanel;
    lblAmbienteAPI: TLabel;
    lblAmbienteAPITexto: TLabel;
    lblMensagem: TLabel;
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
    pnlSenhaCertificado: TPanel;
    lblSenhaCertificado: TLabel;
    lblValidadeCertificado: TLabel;
    edtSenhaCertificado: TEditFocus;
    edtValidadeCertificado: TEditFocus;
    pnlChaveBasic: TPanel;
    lblChaveBasic: TLabel;
    btnGerarChaveBasic: TBitBtnLocked;
    edtChaveBasic: TMemoFocus;
    btnValidarDadosPix: TBitBtnLocked;
    procedure btnArquivoPFXClick(Sender: TObject);
    procedure btnGerarChaveBasicClick(Sender: TObject);
  private
    { Private declarations }
    FCodigoBanco: String;

    function RetornaDadosCertificadoPFX(pgbStatus: TcxProgressBar): Boolean;
    function RetornaPastaOpenSSL: String;
    function RetornaMensagemBanco(ACodigoBanco: String): String;
    function TodasAsDependenciasEstaoNaPasta(ADiretorioOpenSSL: String): Boolean;
  public
    { Public declarations }
    procedure CarregaCampos(ACodigoBanco: String);
  end;

implementation

{$R *.dfm}

procedure TfraDDAAPIAutenticacaoFrame.btnArquivoPFXClick(Sender: TObject);
  Var
    LCaixaDialogo: TOpenDialog;

    LGravando: TfrmGravando;
begin
  if edtSenhaCertificado.Visible Then
  begin
    if fEmptyStr(edtSenhaCertificado.Text) Then
    begin
      fMensagem('ATENÇÃO', 'Para selecionar o arquivo PFX é necessário digitar a senha do certificado.', ['&Ok']);
      Exit;
    end;
  end;

  LCaixaDialogo := TOpenDialog.Create(nil);
  try
    LCaixaDialogo.Title := 'Selecione o arquivo PFX';

    LCaixaDialogo.Options := [ofPathMustExist];

    LCaixaDialogo.Filter := 'Certificado PFX|*.pfx';

    if LCaixaDialogo.Execute Then
    begin
      edtArquivopfx.Text := LCaixaDialogo.FileName;

      pCriarFormularios(TfrmGravando, LGravando);
      LGravando.lblGravando.Caption := 'Aguarde... Carregando Arquivo PFX.';
      LGravando.fExecutarAcao := RetornaDadosCertificadoPFX;
      LGravando.ShowModal;
      FreeAndNil(LGravando);
    end;
  finally
    LCaixaDialogo.Free;
  end;
end;

procedure TfraDDAAPIAutenticacaoFrame.btnGerarChaveBasicClick(Sender: TObject);
begin
  if fEmptyStr(edtClientID.Text) then
  begin
    fMensagem('ATENÇÃO', 'O campo Client ID deve ser preenchido.', ['&Ok']);
    pSetFocus(edtClientID);

    Exit;
  end;

  if fEmptyStr(edtClientSecret.Text) Then
  begin
    if FCodigoBanco <> ('756') then
    begin
      fMensagem('ATENÇÃO', 'O campo Client Secret deve ser preenchido.', ['&Ok']);
      pSetFocus(edtClientSecret);
      Exit;
    end;
  end;

  if not fEmptyStr(edtChaveBasic.Text) Then
  begin
    if fMensagem('ATENÇÃO', 'Já existe dados no campo Autorização Basic. Se utilizar essa função, irá sobrepor seu conteúdo.' + #13 +
                            'Deseja realmente continuar?', ['&Sim', '&Não']) = 2 Then
      Exit;
  end;

 edtChaveBasic.Text := TFuncoesPix.RetornaChaveBasic(edtClientID.Text,
                                                     edtClientSecret.Text);
end;

procedure TfraDDAAPIAutenticacaoFrame.CarregaCampos(ACodigoBanco: String);
begin
  FCodigoBanco := ACodigoBanco;

  pnlChaveAppDev.Visible := MatchStr(FCodigoBanco, ['756']);
  pnlChavesClient.Visible := MatchStr(FCodigoBanco, ['756']);
  pnlCertificadoPFX.Visible := MatchStr(FCodigoBanco, ['756']);
  pnlSenhaCertificado.Visible := MatchStr(FCodigoBanco, ['756']);
  pnlChaveBasic.Visible := MatchStr(FCodigoBanco, ['000']);

  lblMensagem.Visible := MatchStr(FCodigoBanco, ['756']);
  lblMensagem.Caption := RetornaMensagemBanco(FCodigoBanco);

  if FCodigoBanco = '756' then
  begin
    lblClientSecret.Visible := False;
    edtClientSecret.Visible := False;
    pnlChavesClient.Height := 24;
  end
  else
  begin
    lblClientSecret.Visible := True;
    edtClientSecret.Visible := True;
    pnlChavesClient.Height := 47;
  end;

end;

function TfraDDAAPIAutenticacaoFrame.RetornaDadosCertificadoPFX(pgbStatus: TcxProgressBar): Boolean;
var
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

  if LPastaOpenSSL.IsEmpty then
  begin
    edtArquivoPfx.Clear;
    Exit(False);
  end;

  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := 3;

  LOpenSSL := LPastaOpenSSL + 'openssl.exe';

  LArqPem  := LPastaOpenSSL + 'certificado.pem';

  LComando := ' /C ' + LOpenSSL + ' pkcs12 -in "' + edtArquivoPFX.Text + '" ';
  LComando := LComando + ' -passin pass:'+ edtSenhaCertificado.Text;
  LComando := LComando + ' -out "' + LArqPem + '" -nokeys';

  DeleteFile(LArqPem);
  Sleep(200);

  if FileExists(LArqPem) then
  begin
    fMensagem('ATENÇÃO', 'Apague o arquivo ' + LArqPem + ' para que possa ser gerado um novo.' , ['&Ok'], 0);
    edtArquivoPfx.Clear;
    Exit(False);
  end;

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
  if LDataCertificado = 0 then
  begin
    LMensagemErro := 'Não foi possível retornar a validade do certificado selecionado. ' + #13 +
                     'Verifique se é um arquivo válido de certificado';

    if edtSenhaCertificado.Visible then
      LMensagemErro := LMensagemErro + ' ou se a senha digitada está correta';
    LMensagemErro := LMensagemErro + '.';

    fMensagem('ATENÇÃO', LMensagemErro, ['&Ok']);

    edtArquivoPfx.Clear;
    Exit(False);
  end
  else
    edtValidadeCertificado.Text := FormatDateTime('dd/mm/yyyy', LDataCertificado);

  pgbStatus.Position := 3;

  FreeAndNil(LDados);

  DeleteFile(LArqDados);
end;

function TfraDDAAPIAutenticacaoFrame.RetornaMensagemBanco(
  ACodigoBanco: string): string;
begin
  if ACodigoBanco.Equals('756') then
    Result := 'ATENÇÃO: É necessário vincular o certificado cadastrado no Portal Developers do Banco Sicoob.' + #13 +
              '                  Caso não seja feito, o banco não conseguirá realizar a autenticação.'
end;

function TfraDDAAPIAutenticacaoFrame.RetornaPastaOpenSSL: string;
begin
  Result := ExtractFilePath(Application.ExeName);
  Result := Result.Replace('autban\', EmptyStr)
                  .Replace('Autban\', EmptyStr)
                  .Replace('AutBan\', EmptyStr)
                  .Replace('AUTBAN\', EmptyStr);

  Result := Result + 'openssl32\';

  if not TodasAsDependenciasEstaoNaPasta(Result) then
    Exit(EmptyStr);
end;

function TfraDDAAPIAutenticacaoFrame.TodasAsDependenciasEstaoNaPasta(
  ADiretorioOpenSSL: string): Boolean;
const
  LArquivosUtilizados: array of string = ['openssl.exe'];
var
  LArquivo: string;
begin
  Result := True;
  for LArquivo in LArquivosUtilizados do
  begin
    if not FileExists(ADiretorioOpenSSL + LArquivo) then
    begin
      fMensagem('ATENÇÃO', 'O arquivo ' +
        LArquivo + ' não foi encontrado na pasta ' +
          ADiretorioOpenSSL, ['&Ok']);
      Exit(False);
    end;
  end;
end;

end.
