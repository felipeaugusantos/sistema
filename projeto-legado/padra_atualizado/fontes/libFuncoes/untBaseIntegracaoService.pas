unit untBaseIntegracaoService;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  untFuncoesSimples, untModulo, Shared.Core,
{$ENDIF}
  System.Classes, System.SysUtils, REST.Types, REST.Json, REST.Client,
  REST.Authenticator.Basic, untTypesSistema;

const
  ACCEPT              = 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  ACCEPT_CHARSET      = 'UTF-8, *;q=0.8';
  CONTENT_TYPE        = 'application/json';
  ACCEPT_TEXT_HTML    = 'text/html; charset=utf-8';
  ACCEPT_OCTET_STREAM = 'application/octet-stream';
  AUTHORIZATION       = 'Authorization';

type
  TRequisicao = class sealed
  strict private
    FRESTClient         : TRESTClient;
    FRESTRequest        : TRESTRequest;
    FBasicAuth          : THTTPBasicAuthenticator;
    FResposta           : TRESTResponse;
    FResourceBase       : String;
    FResourceRequest    : String;
    FResourceComplement : String;
    FResourceComplete   : String;
    FJsonRequisicao     : String;
    FstrApi             : String;

    procedure pClear(const AKind: TRESTRequestParameterKind);
    function fGetFullURL: String;
    function fGetMethod: String;

    procedure pLoadResourceComplete;
    function fResource(const AResource: String): TRequisicao;

    function fGetParams: TRESTRequestParameterList;
    procedure pGravaLog(const AMensagemComplementar: String);

  public
    constructor Create;
    destructor Destroy; override;

    function fBaseURL(const ABaseURL: String): TRequisicao;
    function fBaseResource(const AResourceBase: String): TRequisicao;
    function fRequestResource(const AResourceRequest: String): TRequisicao;
    function fComplementResource(const AResourceComplement: String): TRequisicao;
    function fToken(const AToken: String): TRequisicao;
    function fBasicAuthentication(const AUsername, APassword: String): TRequisicao;
    function fAccept(const AAccept: String): TRequisicao;
    function fAcceptEncoding(const AAcceptEncoding: String): TRequisicao;
    function fAcceptCharset(const AAcceptCharset: String): TRequisicao;
    function fUserAgent(const AName: String): TRequisicao;
    function fContentType(const AContentType: String): TRequisicao;
    function fTimeout(const ATimeout: Integer): TRequisicao;

    function fAddHeader(const AHeader, AValue: String) : TRequisicao;
    function fAddParam(const AParam, AValue: String) : TRequisicao;
    function fBody(const ABody: String;
      const AContentType: TRESTContentType=ctAPPLICATION_JSON): TRequisicao; overload;
    function fBody(const ABody: TStream): TRequisicao; overload;

    function fClearHeaders: TRequisicao;
    function fClearParams: TRequisicao;

    function fAPI(const AValue: String) : TRequisicao;
    procedure pConfigurarRESTClient;
    function fSetMethod(const AMethod: TRESTRequestMethod): TRequisicao;
    function fExecute: TRequisicao;

    property JsonRequisicao : String                    read FJsonRequisicao;
    property strFullURL     : String                    read fGetFullURL;
    property strMethod      : String                    read fGetMethod;
    property Resposta       : TRESTResponse             read FResposta;
    property Params         : TRESTRequestParameterList read fGetParams;

  end;

  TBaseServico = class abstract
  strict private
    FRequisicao      : TRequisicao;
    FResposta        : TRESTResponse;
    FDataHoraRetorno : TDateTime;
    FDataHoraEnvio   : TDateTime;

    function fGetFullURL: String;
    function fGetRespostaContent: String;
    function fGetStatusCode: Integer;

  strict protected
    procedure pClearRequisicao; virtual;
    procedure pPrepararRequisicao; virtual;
    procedure pConfigurarRequisicao; virtual; abstract;
    function fValidaResposta: Boolean; virtual; abstract;
    procedure pExecutarAposResposta(const AblnRetorno: Boolean); virtual;

    property Requisicao : TRequisicao   read FRequisicao;
    property Resposta   : TRESTResponse read FResposta;

    function fGet: TBaseServico;
    function fPut: TBaseServico;
    function fPost: TBaseServico;
    function fDelete: TBaseServico;
    function fPatch: TBaseServico;

    procedure pExecutar;

    property RespostaContent : String    read fGetRespostaContent;
    property FullURL         : String    read fGetFullURL;
    property DataHoraEnvio   : TDateTime read FDataHoraEnvio;
    property DataHoraRetorno : TDateTime read FDataHoraRetorno;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    property StatusCode      : Integer   read fGetStatusCode;
  end;

implementation

uses
  untConstantes, Uni;

{ TRequisicao }

constructor TRequisicao.Create;
begin
  FRESTClient           := TRESTClient.Create(nil);

  FResposta             := TRESTResponse.Create(nil);
  FRESTRequest          := TRESTRequest.Create(nil);
  FRESTRequest.Response := FResposta;
  FRESTRequest.Client   := FRESTClient;

  FBasicAuth            := THTTPBasicAuthenticator.Create(nil);

  FResourceBase         := EmptyStr;
  FResourceRequest      := EmptyStr;
  FResourceComplement   := EmptyStr;
  FResourceComplete     := EmptyStr;
end;

destructor TRequisicao.Destroy;
begin
  FreeAndNil(FBasicAuth);
  FreeAndNil(FRESTClient);
  FreeAndNil(FRESTRequest);

  if Assigned(FResposta) then
    FreeAndNil(FResposta);

  inherited;
end;

function TRequisicao.fAccept(const AAccept: String): TRequisicao;
begin
  Result := Self;

  FRESTClient.Accept := AAccept;
end;

function TRequisicao.fAcceptCharset(const AAcceptCharset: String): TRequisicao;
const
  REQUEST_DEFAULT_ACCEPT_CHARSET = 'utf-8, *;q=0.8';

begin
  Result := Self;

  FRESTClient.AcceptCharset := AAcceptCharset;
end;

function TRequisicao.fAcceptEncoding(
  const AAcceptEncoding: String): TRequisicao;
begin
  Result := Self;

  FRESTRequest.AcceptEncoding := AAcceptEncoding;
end;

function TRequisicao.fAddHeader(const AHeader, AValue: String): TRequisicao;
begin
  Result := Self;

  if AHeader.IsEmpty or AValue.IsEmpty then
    Exit;

  FRESTRequest.AddParameter(AHeader, AValue, pkHTTPHEADER);
end;

function TRequisicao.fAddParam(const AParam, AValue: String): TRequisicao;
begin
  Result := Self;

  if AParam.IsEmpty or AValue.IsEmpty then
    Exit;

  FRESTRequest.AddParameter(AParam, AValue, pkGETorPOST);
end;

function TRequisicao.fAPI(const AValue: String): TRequisicao;
begin
  Result := Self;
  FstrApi := AValue;
end;

function TRequisicao.fBaseResource(const AResourceBase: String): TRequisicao;
begin
  Result := Self;

  FResourceBase := AResourceBase;
end;

function TRequisicao.fBaseURL(const ABaseURL: String): TRequisicao;
begin
  Result := Self;

  FRESTClient.BaseURL := ABaseURL;
end;

function TRequisicao.fBasicAuthentication(const AUsername,
  APassword: String): TRequisicao;
begin
  Result := Self;

  FBasicAuth.Username       := AUsername;
  FBasicAuth.Password       := APassword;
  FRESTClient.Authenticator := FBasicAuth;
end;

function TRequisicao.fBody(const ABody: String;
  const AContentType: TRESTContentType): TRequisicao;
begin
  Result := Self;

  FJsonRequisicao := EmptyStr;
  FRESTRequest.Body.ClearBody;

  if not ABody.IsEmpty then
  begin
    FRESTRequest.Body.Add(ABody, AContentType);
    FJsonRequisicao := ABody;
  end;
end;

function TRequisicao.fBody(const ABody: TStream): TRequisicao;
begin
  Result := Self;

  FJsonRequisicao := EmptyStr;
  FRESTRequest.Body.ClearBody;

  if Assigned(ABody) then
    FRESTRequest.Body.Add(ABody, ctAPPLICATION_OCTET_STREAM);
end;

function TRequisicao.fClearHeaders: TRequisicao;
begin
  Result := Self;

  pClear(pkHTTPHEADER);
end;

function TRequisicao.fClearParams: TRequisicao;
begin
  Result := Self;

  pClear(pkURLSEGMENT);
end;

function TRequisicao.fComplementResource(
  const AResourceComplement: String): TRequisicao;
begin
  Result := Self;

  FResourceComplement := AResourceComplement;
end;

function TRequisicao.fContentType(const AContentType: String): TRequisicao;
begin
  Result := Self;

  FRESTClient.ContentType := AContentType;
end;

function TRequisicao.fExecute: TRequisicao;
var
  LMensagemComplementar: String;
begin
  Result := Self;

  try
    LMensagemComplementar := EmptyStr;
    try
      try
        pLoadResourceComplete;
        FRESTRequest.Execute;
      except
        on E:Exception do
        begin
          LMensagemComplementar := E.Message;
          raise Exception.Create(LMensagemComplementar);
        end;
      end
    finally
      pGravaLog(LMensagemComplementar);
      FResourceRequest := EmptyStr;
    end;
  except
    raise;
  end;
end;

function TRequisicao.fGetFullURL: String;
begin
  Result := FRESTRequest.GetFullRequestURL(True);
end;

function TRequisicao.fGetMethod: String;
begin
  Result := RESTRequestMethodToString(FRESTRequest.Method);
end;

function TRequisicao.fGetParams: TRESTRequestParameterList;
begin
  Result := FRESTRequest.Params;
end;

function TRequisicao.fResource(const AResource: String): TRequisicao;
begin
  Result := Self;

  FRESTRequest.Resource := AResource;
end;

function TRequisicao.fSetMethod(const AMethod: TRESTRequestMethod): TRequisicao;
begin
  Result := Self;

  FRESTRequest.Method := AMethod;
end;

function TRequisicao.fRequestResource(const AResourceRequest: String): TRequisicao;
begin
  Result := Self;

  FResourceRequest := AResourceRequest;
end;

procedure TRequisicao.pLoadResourceComplete;
begin
  try
    FResourceComplete := EmptyStr;

    FResourceComplete := FResourceBase.Trim;

    if not FResourceRequest.IsEmpty then
      FResourceComplete := FResourceComplete
                         + FResourceRequest.Trim;

    if not FResourceComplement.IsEmpty then
      FResourceComplete := FResourceComplete
                         + FResourceComplement.Trim;

  finally
    fResource(FResourceComplete);
  end;
end;

function TRequisicao.fTimeout(const ATimeout: Integer): TRequisicao;
begin
  Result := Self;

  FRESTRequest.Timeout := ATimeout;
end;

function TRequisicao.fToken(const AToken: String): TRequisicao;
begin
  Result := Self;

  if AToken.Trim.IsEmpty then
    Exit;

  if FRESTRequest.Params.IndexOf(AUTHORIZATION) > -1 then
     FRESTRequest.Params.Delete(AUTHORIZATION);

  FRESTRequest.Params.AddHeader(AUTHORIZATION, AToken);
  FRESTRequest.Params.ParameterByName(AUTHORIZATION).Options := [poDoNotEncode];
end;

function TRequisicao.fUserAgent(const AName: String): TRequisicao;
begin
  Result := Self;

  if not AName.IsEmpty then
    FRESTRequest.Client.UserAgent := AName;
end;

procedure TRequisicao.pClear(const AKind: TRESTRequestParameterKind);
var
  i : Integer;
begin
  for i := 0 to Pred(FRESTRequest.Params.Count) do
  begin
    if FRESTRequest.Params.Items[i].Kind = AKind then
      FRESTRequest.Params.Delete(FRESTRequest.Params.Items[i].name);
  end;
end;

procedure TRequisicao.pConfigurarRESTClient;
begin
  FRESTClient.HandleRedirects     := True;
  FRESTClient.RaiseExceptionOn500 := False;
end;

procedure TRequisicao.pGravaLog(const AMensagemComplementar: String);
var
  qryLogAPI   : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  strParamE   : String;
  intContador : Integer;
  {$IFNDEF LINUX}
  LConn       : TCriarConexao;
  {$ENDIF}
begin
  {$IFNDEF LINUX}
  pValidaProCod('LOGAPI');
  LConn := TCriarConexao.Create('TRequisicao.pGravaLog');
  qryLogAPI := fCriaQuery(nil, LConn.objConexao);
  {$ELSE}
  qryLogAPI := fCriaQuery;
  {$ENDIF}
  Try
    Try
      {$IFNDEF LINUX}
      fStartTransaction(LConn.objConexao);
      {$ENDIF}

      qryLogAPI.Close;
      qryLogAPI.SQL.Clear;
      qryLogAPI.SQL.Text := STR_SQL_NAO_REPLICAR
                          + ' INSERT INTO LOGAPI( '
                          + '        AUTOINCREM '
                          + '      , LOG_DTAENT '
                          + '      , LOG_HORENT '
                          + '      , LOG_RECURS '
                          + '      , LOG_PARAME '
                          + '      , LOG_RESULT '
                          + '      , LOG_STATUS '
                          + '      , LOG_LOGAPI '
                          + '      , LOG_NOMMAQ '
                          + '      , LOG_CODEMP '
                          + ') VALUES ( '
                          + '        :AUTINC '
                          + '      , :DTAENT '
                          + '      , :HORENT '
                          + '      , :RECURS '
                          + '      , :PARAME '
                          + '      , :RESULT '
                          + '      , :STATUS '
                          + '      , :LOGAPI '
                          + '      , :NOMMAQ '
                          + '      , :CODEMP '
                          + ') ';

      qryLogAPI.ParamByName('AUTINC').AsString  := fRetAutoIncrem('LOGAPI', VS_strCodEmp);

      qryLogAPI.ParamByName('DTAENT').AsDate    := Date;
      qryLogAPI.ParamByName('HORENT').AsTime    := fTime();
      qryLogAPI.ParamByName('RECURS').AsString  := IIF(Not fEmptyStr(FRestRequest.Resource), FRestRequest.Resource, FRestClient.BaseURL);

      For intContador := 0 To FRestRequest.Params.Count-1 Do
      Begin
        strParamE := strParamE
                   + IIF(FRestRequest.Params[intContador].name <> '', FRestRequest.Params[intContador].name+': ','')
                   + FRestRequest.Params[intContador].Value+'; ';
      End;

      qryLogAPI.ParamByName('PARAME').AsString  := strParamE;
      qryLogAPI.ParamByName('RESULT').AsString  := FResposta.Content
                                                 + IIF(Not fEmptyStr(AMensagemComplementar), #13#10+AMensagemComplementar,'');
      qryLogAPI.ParamByName('STATUS').AsInteger := FResposta.StatusCode;
      If FResposta.StatusCode = 0 Then
        qryLogAPI.ParamByName('STATUS').Clear;

      qryLogAPI.ParamByName('LOGAPI').AsString  := FstrApi;
      qryLogAPI.ParamByName('NOMMAQ').AsString  := VS_ComputerNetName;
      qryLogAPI.ParamByName('CODEMP').AsString  := VS_strCodEmp;
      qryLogAPI.ExecSQL;

      {$IFNDEF LINUX}
      fCommit(LConn.objConexao);
      {$ENDIF}
    Except
      On E:Exception Do
      Begin
        {$IFNDEF LINUX}
        fRollback(LConn.objConexao);
        {$ENDIF}

        raise Exception.Create(E.Message);
      End;
    End;
  Finally
    {$IFNDEF LINUX}
    FreeAndNil(qryLogAPI);
    FreeAndNil(LConn);
    {$ENDIF}
  End;
end;

{ TBaseServico }

constructor TBaseServico.Create;
begin
  FRequisicao := TRequisicao.Create;
  FResposta   := nil;
end;

destructor TBaseServico.Destroy;
begin
  FreeAndNil(FRequisicao);

  if Assigned(FResposta) then
    FResposta := nil;

  inherited;
end;

procedure TBaseServico.pExecutar;
var
  LOk: Boolean;
begin
  LOk := False;

  try
    FDataHoraEnvio := VS_Date + fTime();

    FRequisicao
      .fExecute;
  finally
    try
      FResposta        := FRequisicao.Resposta;
      FDataHoraRetorno := VS_Date + fTime();
      LOk              := fValidaResposta;
    finally
      pExecutarAposResposta(LOk);
    end;
  end;
end;

procedure TBaseServico.pExecutarAposResposta(const AblnRetorno: Boolean);
begin
//As implementações deverão ser realizadas nas classes filhas, caso necessário.
end;

function TBaseServico.fDelete: TBaseServico;
begin
  Result := Self;

  pPrepararRequisicao;

  FRequisicao
    .fSetMethod(rmDELETE);

  pConfigurarRequisicao;
end;

function TBaseServico.fGet: TBaseServico;
begin
  Result := Self;

  pPrepararRequisicao;

  FRequisicao
    .fSetMethod(rmGET);

  pConfigurarRequisicao;
end;

function TBaseServico.fGetFullURL: String;
begin
  Result := FRequisicao.strFullURL;
end;

function TBaseServico.fGetRespostaContent: String;
begin
  Result := FResposta.Content;
end;

function TBaseServico.fGetStatusCode: Integer;
begin
  Result := FResposta.StatusCode;
end;

function TBaseServico.fPatch: TBaseServico;
begin
  Result := Self;

  pPrepararRequisicao;

  FRequisicao
    .fSetMethod(rmPATCH);

  pConfigurarRequisicao;
end;

function TBaseServico.fPost: TBaseServico;
begin
  Result := Self;

  pPrepararRequisicao;

  FRequisicao
    .fSetMethod(rmPOST);

  pConfigurarRequisicao;
end;

procedure TBaseServico.pPrepararRequisicao;
begin
  FRequisicao.pConfigurarRESTClient;
  pClearRequisicao;
end;

function TBaseServico.fPut: TBaseServico;
begin
  Result := Self;

  pPrepararRequisicao;

  FRequisicao
    .fSetMethod(rmPUT);

  pConfigurarRequisicao;
end;

procedure TBaseServico.pClearRequisicao;
begin
  FRequisicao
    .fClearHeaders
    .fClearParams;
end;

end.

