unit Produto.GS1CNP.Auth;

interface

uses System.SysUtils, System.Classes, Winapi.ActiveX, idHTTP, IdSSLOpenSSL,
  IdAuthentication, IdURI, untFuncoesSimples, System.JSON, Produto.GS1CNP.Http;

type
  TProdutoGS1CNPAuth = class
  private
    class function ParseResponseToken(const AResposta: String): String;
  public
    class function GetAcessToken: string;
  end;

implementation

{ TProdutoGS1CNPAuth }

class function TProdutoGS1CNPAuth.GetAcessToken: string;
Var
  FHTTP: TidHTTP;
  LURL: String;
  LJsonEnvio: String;
  LEnvio : TStringStream;
  LResponse: TStringStream;
begin
  Result := '';

  Try
    LURL := 'https://' + fCfgSis('GCURLA') + '/oauth/access-token';

    FHTTP := TProdutoGS1CNPHttp.New().GetHttp;

    Try
      LJsonEnvio := '{';
      LJsonEnvio := LJsonEnvio + '"grant_type" : "password",';
      LJsonEnvio := LJsonEnvio + '"username" : "' + fCfgSis('GCUSWE') + '",';
      LJsonEnvio := LJsonEnvio + '"password" : "' + fCfgSis('GCSEWE') + '"';
      LJsonEnvio := LJsonEnvio + '}';

      LEnvio := TStringStream.Create(LJsonEnvio, TEncoding.UTF8 );

      LResponse := TStringStream.Create('', TEncoding.UTF8);
      LURL := TIdURI.URLEncode(LURL);

      FHTTP.Post(LURL, LEnvio, LResponse);

      If FHTTP.ResponseCode = 201 Then //201- sucesso e um recurso foi criado
      Begin
        LResponse.Seek(0, soFromBeginning);
        Result := ParseResponseToken(LResponse.DataString);
        Exit;
      End;

      Raise Exception.Create('Ocorreu um erro imprevisto na consulta!' + #13#10 +
                                      'Código do erro: ' + IntToStr(FHTTP.ResponseCode) + #13#10 +
                                      'Descrição do erro: ' + FHTTP.ResponseText);

    Except
//      On E:EIdHTTPProtocolException Do
//      Begin
//        Raise Exception.Create(E.ErrorMessage);
//      End;
      On E: Exception Do
      Begin
        If FHTTP.ResponseCode = 400 Then
          Raise Exception.Create('Não foi possível validar o usuário e senha!' + #13 +
                                 'Erro código 400.')
        Else
          Raise Exception.Create('Ocorreu um erro ao conectar-se ao serviço da GS1/CNP: ' + E.Message);
      End;
    End;
  Finally
    FreeAndNil(LEnvio);
    FreeAndNil(LResponse);
    CoFreeUnusedLibrariesEx(0,0);
  End;
end;

class function TProdutoGS1CNPAuth.ParseResponseToken(const AResposta: String): String;
Var
  LObjPrinc: TJSONObject;
  LJSONPair: TJSONPair;
  LJSONScenarioEntry: TJSONValue;
  LJSONScenarioValue: TJSONString;
begin
  Result  := '';

  Try
    LObjPrinc := TJSONObject.ParseJSONValue( AResposta ) as TJSONObject;

    Try
      If (Assigned(LObjPrinc)) Then
      Begin
        LJSONPair := LObjPrinc.Get('access_token');
        LJSONScenarioEntry := LJSONPair.JsonValue;
        LJSONScenarioValue := LJSONScenarioEntry as TJSONString;
        Result := LJSONScenarioValue.Value;
      End;
    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[TProdutoGS1CNPAuth.ParseResponseToken]');
    End;
  Finally
    pFreeAndNil(LObjPrinc);
  End;
end;

end.
