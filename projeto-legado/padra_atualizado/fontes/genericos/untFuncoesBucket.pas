unit untFuncoesBucket;

interface

uses
  System.SysUtils,
  System.Classes,
  IdHTTP,
  IdSSLOpenSSL,
  Uni,
  System.SyncObjs,
  System.StrUtils;

type
  TFuncoesBucket = class
  private
    class function fRetornaTimeStampEmMilisegundos: Int64;
  public
    class function fGetAuthorizationBucket(ACodEmp: String = ''): string;
    class function fURLValida(AURL: String): Boolean;
    class function fGetFileFromAPI(const AURLFile: string; ACodEmp: String = ''): TBytesStream;
  end;

Var
  CSGetToken: TCriticalSection;
  MsgTokenJaMostrada: Boolean = False;

const
  TOKEN_VALIDADE_MINUTOS = 10;

implementation

uses
  Api.Client.Loader,
  untFuncoesSimples;

{ TFuncoesBucket }

class function TFuncoesBucket.fURLValida(AURL: String): Boolean;
var
  LDLLApi: String;
begin
  Result := True;

  LDLLApi := GetCurrentDir + '\api.client.dll';
  if not FileExists(LDLLApi) then
    Exit(False);

  if VS_PrefixoCliente.IsEmpty or VS_ChaveCliente.IsEmpty then
    Exit(False);

  if AURL.IsEmpty then
    Exit(False);

  if (AURL = 'INVALID IMAGE') then
    Exit(False);
end;

class function TFuncoesBucket.fGetFileFromAPI(const AURLFile: string; ACodEmp : String = ''): TBytesStream;
var
  HTTP: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  ResponseStream: TMemoryStream;
  LToken: string;
begin
  Result         := nil;
  HTTP           := TIdHTTP.Create(nil);
  SSLHandler     := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  ResponseStream := TMemoryStream.Create;

  try
    try
      LToken := fGetAuthorizationBucket(ACodEmp);
    except
      on E: Exception do
      begin
        if not MsgTokenJaMostrada then
        begin
          pGravarErro(True, E.Message, fRetornaStack);
          MsgTokenJaMostrada := True;
        end;

        LToken := '';
        Exit;
      end;
    end;

    if Length(LToken) = 0 then
    begin
      if not MsgTokenJaMostrada then
      begin
        pGravarErro(True, 'Token de autorização vazio ao buscar imagem.', fRetornaStack);
        MsgTokenJaMostrada := True;
      end;
      Exit;
    end;

    HTTP.IOHandler         := SSLHandler;
    HTTP.Request.UserAgent := 'Mozilla/5.0';
    HTTP.Request.CustomHeaders.Values['Authorization'] := LToken;
    HTTP.HandleRedirects   := True;

    try
      HTTP.Get(AURLFile, ResponseStream);

      ResponseStream.Position := 0;
      Result                  := TBytesStream.Create;
      Result.CopyFrom(ResponseStream, ResponseStream.Size);
      Result.Position         := 0;
    except
      on E: EIdHTTPProtocolException do
      begin
        case E.ErrorCode of
          401:
            pGravarErro(True, 'Acesso negado. O token de autorização expirou ou é inválido.', E.Message);
          403:
            pGravarErro(True, 'Permissão insuficiente para acessar o arquivo solicitado.' + sLineBreak +
                              'Verifique suas credenciais ou permissões de acesso.', E.Message);
          404:
            pGravarErro(True, 'O arquivo solicitado não foi encontrado no bucket.' + sLineBreak +
                              'Verifique o endereço ou nome do arquivo.', E.Message);
        else
          pGravarErro(True, 'Erro HTTP inesperado (' + IntToStr(E.ErrorCode) + '): ' + E.ErrorMessage, E.Message);
        end;
      end;

      on E: Exception do
      begin
        pGravarErro(True, 'Erro ao obter o arquivo da API: ' + E.Message, fRetornaStack);
      end;
    end;

  finally
    ResponseStream.Free;
    SSLHandler.Free;
    HTTP.Free;
  end;
end;

class function TFuncoesBucket.fGetAuthorizationBucket(ACodEmp: String = ''): string;
var
  ChavePublica       : TStringList;
  TimestampRequisicao: Int64;
  LChave, LPrefixo   : String;
  LPrecisaRenovar    : Boolean;
begin
  Result   := '';

  LChave   := VS_ChaveCliente;
  LPrefixo := VS_PrefixoCliente;

  if not ACodEmp.IsEmpty then
  begin
    LChave   := fCfgSis('CLICHP', varString, ACodEmp);
    LPrefixo := fCfgSis('CLIPFX', varString, ACodEmp);

    if LChave.IsEmpty or LPrefixo.IsEmpty then
    begin
      raise Exception.Create('A chave de acesso e/ou prefixo da empresa ' + ACodEmp + ' não está preenchida.');
    end;
  end;

  if (TApiClientLoader.GetInstance.Cache.Token <> '') and
     (Now < TApiClientLoader.GetInstance.Cache.ExpiraEm) then
  begin
    Result := TApiClientLoader.GetInstance.Cache.Token;
    Exit;
  end
  else
    LPrecisaRenovar := True;

  if LPrecisaRenovar then
  begin
    ChavePublica := TStringList.Create;
    try
      ChavePublica.Text :=
        '-----BEGIN PUBLIC KEY-----'  + sLineBreak + LChave + sLineBreak + '-----END PUBLIC KEY-----';

      TimestampRequisicao := fRetornaTimeStampEmMilisegundos;

      try
        Result := TApiClientLoader.GetInstance.GetTokenPrefix(
                    LPrefixo,
                    ChavePublica.Text,
                    TimestampRequisicao,
                    GetCurrentDir + '\LibREST'
                  );

        if Trim(Result) = '' then
        begin
          raise Exception.Create('Token retornado pela DLL é vazio.');
        end;

      except
        on E: Exception do
        begin
          raise;
        end;
      end;

    finally
      FreeAndNil(ChavePublica);
    end;
  End;
end;

class function TFuncoesBucket.fRetornaTimeStampEmMilisegundos: Int64;
var
  LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;
  try
    LConsulta.SQL.Add('SELECT CAST(UNIX_TIMESTAMP(NOW(3)) * 1000 AS UNSIGNED)');
    LConsulta.Open;

    Result := LConsulta.Fields[0].Value;

    LConsulta.Close;
  finally
    FreeAndNil(LConsulta);
  end;
end;

initialization
  CSGetToken := TCriticalSection.Create;

finalization
  CSGetToken.Free;

end.

