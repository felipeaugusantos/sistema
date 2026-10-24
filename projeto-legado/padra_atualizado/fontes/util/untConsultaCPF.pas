unit untConsultaCPF;

interface

uses
  httpsend, synautil, ssl_openssl, blcksock,
  Classes,
  Controls,
  SysUtils,
  untInterfaces,
  Vcl.Imaging.pngimage,
  System.NetEncoding,
  Soap.EncdDecd;

type
  TConsultaCpfReceitaFederal = class
  private
    { private declarations }
    objHttp: THTTPSend;
    respHttp: TStringList;
    function fStringReplace(S, OldPatern, NewPattern: String): String;
    function fParseText(ATexto: String) : String;
    function fPreparaCaptchaIMG(ARetorno: String):String;
    procedure pSalvaCaptchaIMG(ARetorno: String);
    procedure pRealizaConsulta;
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;

    function fObtemCaptcha: Boolean;
    function fRetornaCampo(ATexto: TStringList; ANomeCampo: String): String ;
    function fConsultaCadastro(const ACpf, ADataNasc, ACaptcha: String): TRetornoConsultaCadastro;
  end;

const
  URL_CAPT = 'https://servicos.receita.fazenda.gov.br/Servicos/CPF/ConsultaSituacao/ConsultaPublicaSonoro.asp';
  URL_POST = 'https://servicos.receita.fazenda.gov.br/Servicos/CPF/ConsultaSituacao/ConsultaPublicaExibir.asp';
  TMP_CAPTCHA = 'captcha_cpf.png';
  HTTP_TIMEOUT = 90000;

implementation

uses untFuncoesSimples, untConsultaCNPJ_util;

{ TConsultaCpfReceitaFederal }

constructor TConsultaCpfReceitaFederal.Create;
begin
  objHttp := THTTPSend.Create;
  respHttp := TStringList.Create;

  objHttp.Timeout := HTTP_TIMEOUT;

  objHttp.Sock.ConnectionTimeout   := HTTP_TIMEOUT;
  objHttp.Sock.InterPacketTimeout  := False;
  objHttp.Sock.NonblockSendTimeout := HTTP_TIMEOUT;
  objHttp.Sock.SocksTimeout        := HTTP_TIMEOUT;
  objHttp.Sock.HTTPTunnelTimeout   := HTTP_TIMEOUT;
end;

destructor TConsultaCpfReceitaFederal.Destroy;
begin
  objHttp.Free;
  respHttp.Free;
  inherited;
end;

function TConsultaCpfReceitaFederal.fPreparaCaptchaIMG(ARetorno: String): String;
var
  LPosicao: Integer;
begin
  LPosicao := Pos('src="data:image/png;base64,', ARetorno);
  LPosicao := LPosicao + 26;
  Delete(ARetorno, 1, LPosicao);

  Result := Copy(ARetorno, 1, Pos('">', ARetorno) );
end;

procedure TConsultaCpfReceitaFederal.pSalvaCaptchaIMG(ARetorno: String);
var
  LMemoryStream: TMemoryStream;
  LPngImage: TPngImage;
  LBytes: TBytes;
begin
  ARetorno := fPreparaCaptchaIMG(ARetorno);

  LMemoryStream := TMemoryStream.Create;

  Try
    LBytes := decodebase64(AnsiString(ARetorno));

    if (Length(LBytes) > 0) then
    begin
      LMemoryStream.WriteData(LBytes, Length(LBytes));
      LMemoryStream.position := 0;

      LPngImage := TPngImage.Create;
      Try
        LPngImage.LoadFromStream(LMemoryStream);
        LPngImage.SaveToFile(fRetTemporaryDir + TMP_CAPTCHA);
      Finally
        FreeAndNil(LPngImage);
      End;
    end;

  Finally
    FreeAndNil(LMemoryStream)
  End;
end;

function TConsultaCpfReceitaFederal.fObtemCaptcha: Boolean;
var
  LStringStream: TStringStream;
  LRetorno: String;
begin
  Try
    objHttp.Clear;
    objHttp.HTTPMethod('GET', URL_CAPT);

    Result := (objHttp.ResultCode = 200);

    If Result Then
    Begin
      LStringStream := TStringStream.Create;

      objHttp.Document.SaveToStream(LStringStream);

      LRetorno := LStringStream.DataString;

      pSalvaCaptchaIMG(LRetorno);
    End;

  Except
    On E: Exception Do
      Raise ErroConsultaCadastro.Create('Erro ao obter o captcha: '+ E.Message);
  End;
end;

function TConsultaCpfReceitaFederal.fRetornaCampo(ATexto: TStringList; ANomeCampo: String): String ;
var
  LContador: integer;
  Llinha : String;
begin
  Result := '';

  for LContador := 0 to ATexto.Count-1 do
  begin
    Llinha := ATexto[LContador];
    if Pos(ANomeCampo, Llinha) > 0 then
    begin
      Result := Trim(StringReplace(Llinha, ANomeCampo, ' ',[rfReplaceAll]));
      break;
    end;
  end
end;

function TConsultaCpfReceitaFederal.fConsultaCadastro(const ACpf, ADataNasc, ACaptcha: String): TRetornoConsultaCadastro;
Var
  LRetorno: TStringList;
  LRetentar: Boolean;
  LTentativas: Integer;
  LErro: String;
  LPost: TStringStream;
begin
  Result   := TRetornoConsultaCadastro.Create;

  LRetorno := TStringList.Create;

  Try
    LRetentar   := True;
    LTentativas := 0;

    While LRetentar Do
    Begin
      LPost:= TStringStream.Create('');

      LPost.WriteString('TxtCPF='+ACpf+'&');
      LPost.WriteString('txtDataNascimento='+ADataNasc+'&');
      LPost.WriteString('txtTexto_captcha_serpro_gov_br='+Trim(ACaptcha)+'&');
      LPost.WriteString('Enviar=Consultar');

      LPost.Position:= 0;

      objHttp.Clear;
      objHttp.Document.Position:= 0;
      objHttp.Document.CopyFrom(LPost, LPost.Size);
      objHttp.MimeType := 'application/x-www-form-urlencoded';

      pRealizaConsulta;

      LRetentar := (LTentativas < 5) And
                   (Pos('CaptchaSonoro', respHttp.Text) > 0) And
                   (Pos('Preencha os campos abaixo com os dados solicitados', respHttp.Text) > 0);

      Inc(LTentativas);
    End;

    LErro := fVerificaErros(respHttp.Text);

    If not fEmptyStr(LErro) Then
      Raise ErroConsultaCadastro.Create(LErro);

    LRetorno.Text := fStripHTML(respHttp.Text);
    LRetorno.Text := fParseText(LRetorno.Text);

    pRemoveEmptyLines(LRetorno);

    If (Pos('Data de nascimento informada  está divergente',LRetorno.Text) > 0) Then
      Raise ErroConsultaCadastro.Create('Data de nascimento informada está divergente da constante na base de dados da Secretaria da Receita Federal do Brasil.');

    Result.strCpfCnpj := fRetornaCampo(LRetorno, 'No do CPF:');

    If fEmptyStr(Result.strCpfCnpj) Then
      Raise ErroConsultaCadastro.Create('A validação não foi realizada corretamente, tente novamente.');

    Result.strRazaoSocial       := fRetornaCampo(LRetorno,'Nome:');
    Result.dtaDataNascimento    := StrToDateDef(fRetornaCampo(LRetorno,'Data de Nascimento:'), 0);
    Result.strDescSituacao      := fRetornaCampo(LRetorno,'Situação Cadastral:');
    Result.dtaDataInscricao     := StrToDateDef(fRetornaCampo(LRetorno,'Data da Inscrição:'), 0);
    Result.strDigitoVerificador := fRetornaCampo(LRetorno,'Digito Verificador:');
    Result.blnHabilitado        := (Pos('REGULAR',Result.strDescSituacao) > 0 );

  Finally
    FreeAndNil(LRetorno);
  End;
end;

procedure TConsultaCpfReceitaFederal.pRealizaConsulta;
Var
  contRedirect: Integer;
  strURL, strHeadersOld, strLocation, strMetodo: String;
begin
  respHttp.Clear;

  contRedirect := 0;
  strURL := URL_POST;
  strMetodo := 'POST';

  strHeadersOld := objHttp.Headers.Text;
  objHttp.HTTPMethod(strMetodo, strURL);

  While contRedirect <= 10 Do
  Begin
    Inc(contRedirect);

    Case objHttp.ResultCode Of
      301,302,303,307:
      Begin
        strLocation := fFindInList(objHttp.Headers, 'Location:');
        strLocation := Trim(SeparateLeft(strLocation, ';'));

        If fIsAbsoluteURL(strLocation) Then
          strURL := strLocation
        Else
          strURL := fGetUrlBasePath(strURL) + strLocation;

        objHttp.Clear;
        objHttp.Headers.Text := strHeadersOld;

        If ((objHttp.ResultCode = 303) Or
            (objHttp.ResultCode = 302) Or
            (objHttp.ResultCode = 301)) And
            (strMetodo = 'POST') Then
          objHttp.HTTPMethod('GET', strURL)
        Else
          objHttp.HTTPMethod(strMetodo, strURL);
      End;
    Else
      Break;
    End;
  End;

  respHttp.LoadFromStream(objHttp.Document);

  If objHttp.ResultCode <> 200 Then
    Raise ErroConsultaCadastro.Create('code: '+ IntToStr(objHttp.ResultCode) + sLineBreak +
                                      'error: '+ objHttp.Sock.LastErrorDesc + sLineBreak +
                                      'url: '+ strURL);
end;

function TConsultaCpfReceitaFederal.fStringReplace(S, OldPatern, NewPattern: String): String;
begin
  if pos(OldPatern, S) > 0 then
    Result := StringReplace(S, OldPatern, NewPattern, [rfReplaceAll])
  else
    Result := S;
end;

function TConsultaCpfReceitaFederal.fParseText(ATexto: String): String;
var
  LTexto: String;

begin
  LTexto := UTF8ToString(AnsiString(ATexto));

  LTexto := fStringReplace(LTexto, '&amp;'   , '&');
  LTexto := fStringReplace(LTexto, '&lt;'    , '<');
  LTexto := fStringReplace(LTexto, '&gt;'    , '>');
  LTexto := fStringReplace(LTexto, '&quot;'  , '"');
  LTexto := fStringReplace(LTexto, '&#39;'   , #39);
  LTexto := fStringReplace(LTexto, '&#45;'   , '-');
  LTexto := fStringReplace(LTexto, '&aacute;', 'á');
  LTexto := fStringReplace(LTexto, '&Aacute;', 'Á');
  LTexto := fStringReplace(LTexto, '&acirc;' , 'â');
  LTexto := fStringReplace(LTexto, '&Acirc;' , 'Â');
  LTexto := fStringReplace(LTexto, '&atilde;', 'ã');
  LTexto := fStringReplace(LTexto, '&Atilde;', 'Ã');
  LTexto := fStringReplace(LTexto, '&agrave;', 'à');
  LTexto := fStringReplace(LTexto, '&Agrave;', 'À');
  LTexto := fStringReplace(LTexto, '&eacute;', 'é');
  LTexto := fStringReplace(LTexto, '&Eacute;', 'É');
  LTexto := fStringReplace(LTexto, '&ecirc;' , 'ê');
  LTexto := fStringReplace(LTexto, '&Ecirc;' , 'Ê');
  LTexto := fStringReplace(LTexto, '&iacute;', 'í');
  LTexto := fStringReplace(LTexto, '&Iacute;', 'Í');
  LTexto := fStringReplace(LTexto, '&oacute;', 'ó');
  LTexto := fStringReplace(LTexto, '&Oacute;', 'Ó');
  LTexto := fStringReplace(LTexto, '&otilde;', 'õ');
  LTexto := fStringReplace(LTexto, '&Otilde;', 'Õ');
  LTexto := fStringReplace(LTexto, '&ocirc;' , 'ô');
  LTexto := fStringReplace(LTexto, '&Ocirc;' , 'Ô');
  LTexto := fStringReplace(LTexto, '&uacute;', 'ú');
  LTexto := fStringReplace(LTexto, '&Uacute;', 'Ú');
  LTexto := fStringReplace(LTexto, '&uuml;'  , 'ü');
  LTexto := fStringReplace(LTexto, '&Uuml;'  , 'Ü');
  LTexto := fStringReplace(LTexto, '&ccedil;', 'ç');
  LTexto := fStringReplace(LTexto, '&Ccedil;', 'Ç');
  LTexto := fStringReplace(LTexto, '&apos;'  , '''');

  Result := LTexto;
end;

end.
