unit DominioSistemas.Infra.APIClient;

interface

uses
  SysUtils,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE}
    REST.Client,
  {$ENDIF}
  System.Classes, REST.Authenticator.OAuth, System.JSON,
  System.Generics.Collections, DominioSistemas.Core.ApiClientInterface,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TGenericMultipartPost = function(
    const ABaseURL, AEndpoint, AMethod, AHeadersJSON, AParamsJSON, AFilesJSON: PChar
  ): PChar; stdcall;


  TAPIClient = class(TInterfacedObject, IAPIClient)
  private
    FAccessToken: String;
    FXIntegrationKey: String;
    FDLLHandle: THandle;
    FPostFunc: TGenericMultipartPost;
    procedure CarregarDLL;
    procedure pPostDLL(const ABaseURL,
                             AEndpoint,
                             APathFiles,
                             AParamHeader,
                             AParamsSimples: string;
                       var   AStatusCode: Integer;
                       var   AContent: string;
                       var   ARequestInfo: string);
    function fGetLatestApiStatus(const AJSONResponse: string): string;
    function fGetFirstErrorFromJson(const AJSONResponse: string): string;
  public
    constructor Create(const AAccessToken, AXIntegrationKey: String); reintroduce;
    destructor Destroy; override;
    function fPostNotaFiles(const AEndpoint: string;
                            const APathsXMLFiles: TDictionary<String,String>): String;
    function fGetDocumentoStatus(const AEndpoint,
                                       AProtocolo: string): String;
    function fGetAtivacaoInfo(const AEndpoint: string): String;
    function fGerarIntegrationKeyApp(const AEndpoint: string): String ;
    procedure pSetIntegrationKeyApp(const AValue: string) ;
  end;

  TApiTokenClient = class
  private
    class var FCachedToken: String;
    class var FCachedTokenDateTime: TDateTime;
    class function fCacheValido: Boolean;
    class function fGerarNovoToken(const ACodEmp: String): String;
  public
    class function fGerarToken(const ACodEmp: String): String ;
    class procedure pInvalidarCache;
  end ;

implementation

uses
  REST.Types, DominioSistemas.Infra.Config,
  DominioSistemas.Infra.Repository, DominioSistemas.Core.Exception,
  REST.Utils, DominioSistemas.Core.Utils, DominioSistemas.Infra.Util,
  {$IFDEF MSWINDOWS}
    Winapi.Windows, Winapi.ActiveX,
  {$ENDIF}
  System.DateUtils, untDominioSistemasRestApi ;


{ TAPIClient }

procedure TAPIClient.CarregarDLL;
begin
  if FDLLHandle = 0 then
  begin
    FDLLHandle := LoadLibrary(DDL_POST);
    if FDLLHandle = 0 then
      raise Exception.Create('Erro ao carregar biblioteca de funções.');

    @FPostFunc := GetProcAddress(FDLLHandle, 'GenericMultipartPost');
    if not Assigned(FPostFunc) then
      raise Exception.Create('Função não encontrada na biblioteca de funções.');
  end;
end;

constructor TAPIClient.Create(const AAccessToken, AXIntegrationKey: String);
begin
  FDLLHandle := 0 ;
  FAccessToken := AAccessToken ;
  FXIntegrationKey := AXIntegrationKey ;
end;

destructor TAPIClient.Destroy;
begin
  if FDLLHandle <> 0 then
  begin
    FreeLibrary(FDLLHandle);
    FDLLHandle := 0;
  end;
  inherited;
end;

function TAPIClient.fGerarIntegrationKeyApp(const AEndpoint: string): String;
var
  LJSONResponse: String;
  LJParamSimples: TJSONObject ;
  LParamSimples: String ;
  LFilesJSON: String ;
  LHeadersJSON: String ;
  LStatusCode: Integer;
  LContent, LRequestInfo: string ;
begin
  Result := '';
  LJSONResponse := '';

  //header
  LHeadersJSON := '';

  // Monta parâmetros simples
  LJParamSimples := TJSONObject.Create;
  try
    LJParamSimples.AddPair('Authorization', TJSONObject.Create
                                            .AddPair('value', Format('Bearer %s', [FAccessToken]))
                                            .AddPair('kind', TJSONNumber.Create(Integer(pkHTTPHEADER)))
                                            .AddPair('contentType', 'application/json'));

    LJParamSimples.AddPair('x-integration-key', TJSONObject.Create
                                                .AddPair('value', FXIntegrationKey)
                                                .AddPair('kind', TJSONNumber.Create(Integer(pkHTTPHEADER)))
                                                .AddPair('contentType', 'application/json'));

    LParamSimples := LJParamSimples.ToString;
  finally
    FreeAndNil(LJParamSimples);
  end;

  LFilesJSON := '' ;

  pPostDLL(TMySQLRepository.fGetUrlApi,
           AEndpoint,
           LFilesJSON,
           LHeadersJSON,
           LParamSimples,
           LStatusCode,
           LContent,
           LRequestInfo) ;

  case LStatusCode of
    200, 201: Result := LContent ;
    400: raise ExceptionDominio.Create('Erro ao consultar informação de ativação[integration-key].');
    401:
      begin
        TApiTokenClient.pInvalidarCache;
        raise ExceptionDominioCredencialInvalida.Create('Credencial inválida.');
      end;
    404: raise ExceptionDominio.Create('Erro 404: ' + fGetFirstErrorFromJson(LContent));
    else
      raise ExceptionDominio.Create('Erro ao obter informação de ativação[integration-key] Código: '+ IntToStr(LStatusCode) +'.');
  end ;
end;

function TAPIClient.fGetAtivacaoInfo(const AEndpoint: string): String;
var
  LControllerRest: TControllerRest;
  LRestRequest: TRestRequest;
  LRetorno: TJSONObject ;
  LJSONResponse : String;
begin
  Result := '';
  LJSONResponse := '';

  LControllerRest := TControllerRest.Create(IDENTIFICADOR_API_DOMINIO, TControllerRestDominioSistemas.fConfigurar);
  LRestRequest := TRestRequest.Create(LControllerRest.RestClient);
  try
    LRestRequest.Resource := AEndpoint;
    LRestRequest.Method := {$IFDEF LINUX} TRestMethod.rmGET {$ELSE} rmGET {$ENDIF} ;

    {$IFDEF LINUX}
      LRestRequest.Params.AddItem('x-integration-key', FXIntegrationKey, pkHTTPHEADER);
      LRestRequest.Params.AddItem('Authorization', 'Bearer ' + FAccessToken, pkHTTPHEADER);
    {$ELSE}
      LRestRequest.Params.Clear ;
      LRestRequest.AddParameter('x-integration-key', FXIntegrationKey, pkHTTPHEADER, [poDoNotEncode]);
      LRestRequest.AddParameter('Authorization', 'Bearer ' + FAccessToken, pkHTTPHEADER, [poDoNotEncode]);
    {$ENDIF}

    if LControllerRest.fExecute(LRestRequest, LJSONResponse, ['200']) then
      Result := LJSONResponse
    else
    begin
      if Assigned(LRestRequest.Response) then
      begin
        case LRestRequest.Response.StatusCode of
          400:
          begin
            try
              LRetorno := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LJSONResponse), 0) as TJSONObject ;
              try
                if LRetorno.GetValue<String>('error') = 'invalid_client' then
                begin
                  TApiTokenClient.pInvalidarCache;
                  raise ExceptionDominioCredencialInvalida.Create('Credencial inválida.');
                end
                else
                  raise ExceptionDominio.Create('Erro ao consultar informação de ativação.');
              finally
                FreeAndNil(LRetorno) ;
              end ;
            except
              on ExceptionDominioCredencial do
                raise;

              on Exception do
                raise ExceptionDominio.Create('Erro ao obter informação de ativação.');
            end;

          end;
          401:
            begin
              TApiTokenClient.pInvalidarCache;
              raise ExceptionDominioCredencialInvalida.Create('Credencial inválida.');
            end;
          404: raise ExceptionDominio.Create('Erro 404: ' + fGetFirstErrorFromJson(LJSONResponse)) ;
          else
            raise ExceptionDominio.Create('Erro ao obter informação de ativação Código: '+ IntToStr(LRestRequest.Response.StatusCode) +'.');
        end;
      end
      else
        raise ExceptionDominio.Create('Falha ao enviar requsição para obter informação de ativação.');
    end;

  finally
    {$IFNDEF LINUX}
      FreeAndNil(LRestRequest) ;
      FreeAndNil(LControllerRest);
    {$ENDIF LINUX}
  end;
end;

function TAPIClient.fGetDocumentoStatus(const AEndpoint, AProtocolo: string): String;
var
  LControllerRest: TControllerRest;
  LRestRequest: TRestRequest;
  LRetorno: TJSONObject ;
  LJSONResponse : String;
begin
  Result := '';
  LJSONResponse := '';

  LControllerRest := TControllerRest.Create(IDENTIFICADOR_API_DOMINIO, TControllerRestDominioSistemas.fConfigurar);
  LRestRequest := TRestRequest.Create(LControllerRest.RestClient);
  try
    LRestRequest.Resource := AEndpoint + '/' + AProtocolo;
    LRestRequest.Method := {$IFDEF LINUX} TRestMethod.rmGET {$ELSE} rmGET {$ENDIF} ;

    {$IFDEF LINUX}
      LRestRequest.Params.AddItem('x-integration-key', FXIntegrationKey, pkHTTPHEADER);
      LRestRequest.Params.AddItem('Authorization', 'Bearer ' + FAccessToken, pkHTTPHEADER);
    {$ELSE}
      LRestRequest.Params.Clear ;
      LRestRequest.AddParameter('x-integration-key', FXIntegrationKey, pkHTTPHEADER, [poDoNotEncode]);
      LRestRequest.AddParameter('Authorization', 'Bearer ' + FAccessToken, pkHTTPHEADER, [poDoNotEncode]);
    {$ENDIF}

    if LControllerRest.fExecute(LRestRequest, LJSONResponse, ['200']) then
      Result := fRemoverAcentuacao(fGetLatestApiStatus(LJSONResponse))
    else
    begin
      if Assigned(LRestRequest.Response) then
      begin
        case LRestRequest.Response.StatusCode of
          400:
          begin
            try
              LRetorno := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LJSONResponse), 0) as TJSONObject ;
              try
                if LRetorno.GetValue<String>('error') = 'invalid_client' then
                begin
                  TApiTokenClient.pInvalidarCache;
                  raise ExceptionDominioCredencialInvalida.Create('Credencial inválida.');
                end
                else
                  raise ExceptionDominio.Create('Erro ao consultar envio documento.');
              finally
                FreeAndNil(LRetorno) ;
              end ;
            except
              on ExceptionDominioCredencial do
                raise;

              on Exception do
                raise ExceptionDominio.Create('Erro ao obter envio documento.');
            end;

          end;
          401:
            begin
              TApiTokenClient.pInvalidarCache;
              raise ExceptionDominioCredencialInvalida.Create('Credencial inválida.');
            end;
          404: Result := fGetFirstErrorFromJson(LJSONResponse) ;
          else
            raise ExceptionDominio.Create('Erro ao obter envio documento Código: '+ IntToStr(LRestRequest.Response.StatusCode) +'.');
        end;
      end
      else
        raise ExceptionDominio.Create('Falha ao enviar requsição para obter token de acesso.');
    end;

  finally
    {$IFNDEF LINUX}
      FreeAndNil(LRestRequest) ;
      FreeAndNil(LControllerRest);
    {$ENDIF}
  end;
end;

function TAPIClient.fGetLatestApiStatus(
  const AJSONResponse: string): string;
var
  LRetorno: TJSONObject;
  LFilesExpanded: TJSONArray;
  LFileItem, LLatestFileItem: TJSONObject;
  LApiStatus: TJSONObject;
  LCode, LMessage, LResult: string;
  LLastApiStatusOn, LLatestApiStatusOn: TDateTime;
  LCnt: Integer;
  LLastApiStatusOnStr: string;
  LStatus: TJSONObject ;
begin
  Result := '';

  LRetorno := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(AJSONResponse), 0) as TJSONObject;
  try
    LFilesExpanded := LRetorno.GetValue('filesExpanded') as TJSONArray;

    LLatestApiStatusOn := 0;
    LLastApiStatusOn   := nOw;
    LLatestFileItem := nil;

    for LCnt := 0 to LFilesExpanded.Count - 1 do
    begin
      LFileItem := LFilesExpanded.Items[LCnt] as TJSONObject;

      LLastApiStatusOnStr := LFileItem.GetValue('lastApiStatusOn').Value;

      try
        LLastApiStatusOn := ISO8601ToDate(LLastApiStatusOnStr);
      except
        on E: Exception do
        begin
          LLastApiStatusOn := nOw ;
        end ;
      end ;

      if LLastApiStatusOn > LLatestApiStatusOn then
      begin
        LLatestApiStatusOn := LLastApiStatusOn;
        LLatestFileItem := LFileItem;
      end;
    end;

    if Assigned(LLatestFileItem) then
    begin
      LApiStatus := LLatestFileItem.GetValue('apiStatus') as TJSONObject;

      LCode := LApiStatus.GetValue('code').Value;
      LMessage := LApiStatus.GetValue('message').Value;

      LResult := LCode + ' ' + LMessage;
    end
    else
    begin
      LStatus := LRetorno.GetValue('status') as TJSONObject ;
      if Assigned(LStatus) then
      begin
        LCode := LStatus.GetValue('code').Value;
        LMessage := LStatus.GetValue('message').Value;
        LResult := LCode + ' ' + LMessage;
      end
      else
      begin
        LResult := 'Nenhum arquivo encontrato!';
      end ;
    end;

    Result := LResult;

  finally
    FreeAndNil(LRetorno);
  end;
end;

function TAPIClient.fPostNotaFiles(const AEndpoint: string;
                                   const APathsXMLFiles: TDictionary<String,String>): String;
var
  LJSON: TJSONObject;
  LStatusCode: Integer;
  LContent, LRequestInfo: string ;
  LHeadersJSON: String ;
  LParamsJSONSimples: TJSONObject ;
  LParamsJSONStringSimples: String ;
  LFilesJSON, LKey: String ;
begin
  Result := '';
  //header
  LHeadersJSON := Format('{"Authorization":"Bearer %s","x-integration-key":"%s","Accept":"application/json"}',
                        [FAccessToken, FXIntegrationKey]);

  //corpo
  LParamsJSONSimples := TJSONObject.Create;
  try
    LParamsJSONSimples.AddPair('query', '{"boxeFile":'+LowerCase(BoolToStr(TMySQLRepository.fUseBoxE, True))+'}');
    LParamsJSONStringSimples := LParamsJSONSimples.ToString;
  finally
    FreeAndNil(LParamsJSONSimples);
  end;

  //arquivos
  LFilesJSON := '[';
  for LKey in APathsXMLFiles.Keys do
    LFilesJSON := LFilesJSON + Format('{"%s":{"path":"%s","contentType":"%s"}},', [LKey, APathsXMLFiles.Items[LKey], 'application/xml']);
  if Length(LFilesJSON) > 1 then
    SetLength(LFilesJSON, Length(LFilesJSON) - 1); // remove última vírgula
  LFilesJSON := LFilesJSON + ']';

  pPostDLL(TMySQLRepository.fGetUrlApi,
           AEndpoint,
           LFilesJSON,
           LHeadersJSON,
           LParamsJSONStringSimples,
           LStatusCode,
           LContent,
           LRequestInfo) ;

  case LStatusCode of
    200, 201:
      begin
        LJSON := TJSONObject.ParseJSONValue(LContent) as TJSONObject;
        try
          if Assigned(LJSON) and (LJSON.GetValue('id') <> nil) then
            Result := LJSON.GetValue<string>('id')
          else
            raise Exception.Create('Resposta inesperada da API: ' + LContent);
        finally
          FreeAndNil(LJSON);
        end;
      end ;
    400: raise ExceptionDominio.Create('Erro ao enviar arquivo.');
    401:
      begin
        TApiTokenClient.pInvalidarCache;
        raise ExceptionDominioCredencialInvalida.Create('Credencial inválida.');
      end;
    404: raise ExceptionDominioUrlInvalida.Create('URL inválida.');
    else
      raise ExceptionDominio.Create('Erro inesperado (' + IntToStr(LStatusCode) + ').');
  end ;

end;

function TAPIClient.fGetFirstErrorFromJson(
  const AJSONResponse: string): string;
var
  LRetorno: TJSONObject;
  LError: TJSONObject;
  LErrors: TJSONArray;
  LFirstError: TJSONObject;
  LReason, LMessage, LResult: string;
begin
  Result := '';

  LRetorno := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(AJSONResponse), 0) as TJSONObject;
  try
    LError := LRetorno.GetValue('error') as TJSONObject;
    LErrors := LError.GetValue('errors') as TJSONArray;

    if LErrors.Count > 0 then
    begin
      LFirstError := LErrors.Items[0] as TJSONObject;

      LReason := LFirstError.GetValue('reason').Value;
      LMessage := LFirstError.GetValue('message').Value;

      LResult := LReason + ' ' + LMessage;
    end
    else
    begin
      LResult := LError.GetValue('message').Value;
    end;

    Result := LResult;

  finally
    FreeAndNil(LRetorno);
  end;
end;

procedure TAPIClient.pPostDLL(const ABaseURL,
                                    AEndpoint,
                                    APathFiles,
                                    AParamHeader,
                                    AParamsSimples: string;
                              var   AStatusCode: Integer;
                              var   AContent: string;
                              var   ARequestInfo: string);
var
  LRetorno: PChar;
  LRetStr: string;
  LJsonRetorno: TJSONObject;
begin
  AStatusCode := -1;
  AContent := '';
  ARequestInfo := '';

  CarregarDLL;

  // Chama a DLL
  LRetorno := FPostFunc(
    PChar(ABaseURL),
    PChar(AEndpoint),
    'POST',
    PChar(AParamHeader),
    PChar(AParamsSimples),
    PChar(APathFiles)
  );

  if Assigned(LRetorno) then
  begin
    try
      LRetStr := string(LRetorno);
    finally
      {$IFDEF LINUX}
        FreeMem(LRetorno);
      {$ELSE}
        CoTaskMemFree(LRetorno);
      {$ENDIF}
    end;

    LJsonRetorno := TJSONObject.ParseJSONValue(LRetStr) as TJSONObject;
    if not Assigned(LJsonRetorno) then
    begin
      TControllerRest.pGravaLogApiAvulsa(IDENTIFICADOR_API_DOMINIO, ABaseURL + AEndpoint, ARequestInfo, AContent, AStatusCode);
      raise Exception.Create('Retorno inválido da DLL');
    end ;

    try
      // Se vier { "error": "... }", dispara exceção
      if LJsonRetorno.GetValue('error') <> nil then
      begin
        TControllerRest.pGravaLogApiAvulsa(IDENTIFICADOR_API_DOMINIO, ABaseURL + AEndpoint, ARequestInfo, AContent, AStatusCode);
        raise Exception.Create(LJsonRetorno.GetValue('error').Value);
      end ;

      // Preenche parâmetros VAR
      AStatusCode := StrToIntDef(LJsonRetorno.GetValue('statusCode').Value, -1);
      AContent := LJsonRetorno.GetValue('content').Value;
      ARequestInfo := LJsonRetorno.GetValue('request').Value;

      TControllerRest.pGravaLogApiAvulsa(IDENTIFICADOR_API_DOMINIO, ABaseURL + AEndpoint, ARequestInfo, AContent, AStatusCode);
    finally
      FreeAndNil(LJsonRetorno);
    end;
  end
  else
    raise Exception.Create('DLL retornou ponteiro nulo');

end;

procedure TAPIClient.pSetIntegrationKeyApp(const AValue: string);
begin
  FXIntegrationKey := AValue ;
end;

{ TApiTokenClient }

class procedure TApiTokenClient.pInvalidarCache;
begin
  FCachedToken := '';
  FCachedTokenDateTime := 0;
end;

class function TApiTokenClient.fCacheValido: Boolean;
var
  LDiffHoras: Double;
begin
  Result := False;
  if (FCachedToken = '') or (FCachedTokenDateTime <= 0) then
    Exit;

  LDiffHoras := (Now - FCachedTokenDateTime) * 24;
  Result := (LDiffHoras >= 0) and (LDiffHoras < 24);
end;

class function TApiTokenClient.fGerarNovoToken(const ACodEmp: String): String;
var
  LControllerRest: TControllerRest;
  LRestRequest: TRestRequest;
  LRetorno: TJSONObject ;

  LJSONResponse : String;

  LClientId: String ;
  LClientSecret: String ;
  LAudience: String ;
begin
  Result := '';
  LJSONResponse := '';

  LClientId := TMySQLRepository.fGetClientId(ACodEmp) ;
  LClientSecret := TMySQLRepository.fGetClientSecret(ACodEmp) ;
  LAudience := TMySQLRepository.fGetAudiense(ACodEmp) ;

  LControllerRest := TControllerRest.Create(IDENTIFICADOR_API_DOMINIO, TControllerRestDominioSistemasToken.fConfigurar);
  LRestRequest := TRestRequest.Create(LControllerRest.RestClient);
  try
    LRestRequest.Resource := '';
    LRestRequest.Method := {$IFDEF LINUX} TRestMethod.rmPOST {$ELSE} rmPOST {$ENDIF} ;

    {$IFDEF LINUX}
      LRestRequest.Params.AddItem('client_id', LClientId, pkGETorPOST);
      LRestRequest.Params.AddItem('client_secret', LClientSecret , pkGETorPOST);
      LRestRequest.Params.AddItem('audience', LAudience , pkGETorPOST);
      LRestRequest.Params.AddItem('grant_type', 'client_credentials' , pkGETorPOST);
    {$ELSE}
      LRestRequest.Params.Clear ;
      LRestRequest.Params.AddItem('client_id', LClientId, pkGETorPOST);
      LRestRequest.Params.AddItem('client_secret', LClientSecret , pkGETorPOST);
      LRestRequest.Params.AddItem('audience', LAudience , pkGETorPOST);
      LRestRequest.Params.AddItem('grant_type', 'client_credentials' , pkGETorPOST);
    {$ENDIF}

    if LControllerRest.fExecute(LRestRequest, LJSONResponse, ['200', '201']) then
    begin
      LRetorno := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LJSONResponse), 0) as TJSONObject ;
      try
        Result := LRetorno.GetValue<String>('access_token') ;
      finally
        FreeAndNil(LRetorno) ;
      end ;
    end
    else
    begin
      if Assigned(LRestRequest.Response) then
      begin
        case LRestRequest.Response.StatusCode of
          400:
          begin
            try
              LRetorno := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(LJSONResponse), 0) as TJSONObject ;
              if LRetorno.GetValue<String>('error') = 'invalid_client' then
                raise ExceptionDominioCredencialInvalida.Create('Credencial inválida.')
              else
                raise ExceptionDominio.Create('Erro ao obter token de acesso.');
            except
              on ExceptionDominioCredencial do
                raise;

              on Exception do
                raise ExceptionDominio.Create('Erro ao obter token de acesso.');
            end;

          end;
          401: raise ExceptionDominioCredencialInvalida.Create('Credencial inválida.');
          404: raise ExceptionDominioUrlInvalida.Create('URL inválida.');
          else
            raise ExceptionDominio.Create('Erro ao obter token de acesso.');
        end;
      end
      else
        raise ExceptionDominio.Create('Falha ao enviar requsição para obter token de acesso.');
    end;

  finally
    {$IFNDEF LINUX}
      FreeAndNil(LRestRequest) ;
      FreeAndNil(LControllerRest);
    {$ENDIF}
  end;
end;

class function TApiTokenClient.fGerarToken(const ACodEmp: String): String;
begin
  if fCacheValido then
  begin
    Result := FCachedToken;
    Exit;
  end;

  // Cache vencido/vazio: gera novo token e atualiza o cache em memória
  try
    Result := fGerarNovoToken(ACodEmp);
    FCachedToken := Result;
    FCachedTokenDateTime := Now;
  except
    // Se falhar a geração, garante que o cache não fica com dado inconsistente
    pInvalidarCache;
    raise;
  end;
end;

end.
