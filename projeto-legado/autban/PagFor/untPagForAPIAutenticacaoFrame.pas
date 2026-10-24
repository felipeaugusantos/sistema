unit untPagForAPIAutenticacaoFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, Vcl.DBCtrls,
  DBMemoFocus, Vcl.Buttons, BitBtnLockedIncrem, cxButtons, EditFocus, Vcl.Mask,
  DBEditFocus, MemoFocus, System.StrUtils, cxProgressBar, untTFuncoesAuxiliaresPix;

type
  TfraPagForAPIAutenticacaoFrame = class(TFrame)
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
    lblAmbienteAPI: TLabel;
    lblAmbienteAPITexto: TLabel;
    lblMensagem: TLabel;
    procedure btnArquivoPFXClick(Sender: TObject);
    procedure btnGerarChaveBasicClick(Sender: TObject);
  private
    FCodigoBanco: String;

    function RetornaDadosCertificadoPFX(pgbStatus: TcxProgressBar): Boolean;
    function RetornaPastaOpenSSL: String;

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

{ TfraPagForAPIAutenticacaoFrame }

procedure TfraPagForAPIAutenticacaoFrame.btnArquivoPFXClick(Sender: TObject);
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

procedure TfraPagForAPIAutenticacaoFrame.btnGerarChaveBasicClick(
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

procedure TfraPagForAPIAutenticacaoFrame.CarregaCampos(ACodigoBanco: String);
begin
  FCodigoBanco := ACodigoBanco;

  pnlChaveAppDev.Visible := MatchStr(FCodigoBanco, ['001']);
  pnlChavesClient.Visible := MatchStr(FCodigoBanco, ['001']);
  pnlCertificadoPFX.Visible := MatchStr(FCodigoBanco, ['001']);
  pnlSenhaCertificado.Visible := MatchStr(FCodigoBanco, ['001']);
  pnlChaveBasic.Visible := MatchStr(FCodigoBanco, ['001']);

  lblMensagem.Visible := MatchStr(FCodigoBanco, ['001']);
  lblMensagem.Caption := RetornaMensagemBanco(FCodigoBanco);
end;

function TfraPagForAPIAutenticacaoFrame.RetornaDadosCertificadoPFX(
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

function TfraPagForAPIAutenticacaoFrame.RetornaMensagemBanco(
  ACodigoBanco: String): String;
begin
  Result := EmptyStr;

  If ACodigoBanco.Equals('001') Then
    Result := 'ATENÇÃO: É necessário vincular o certificado cadastrado no Portal Developers do Banco do Brasil.' + #13 +
              '                  Caso não seja feito, o banco não conseguirá realizar a autenticação.';
end;

function TfraPagForAPIAutenticacaoFrame.RetornaPastaOpenSSL: String;
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

function TfraPagForAPIAutenticacaoFrame.TodasAsDependenciasEstaoNaPasta(
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

end.
