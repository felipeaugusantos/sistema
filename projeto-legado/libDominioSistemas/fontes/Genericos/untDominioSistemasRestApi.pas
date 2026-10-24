unit untDominioSistemasRestApi;

interface

uses
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  Rest.Json, System.SysUtils, REST.Authenticator.OAuth, System.Classes,
  REST.Types, strUtils, DateUtils,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
    Shared.Core,
  {$ELSE }
  REST.Client, untConstantes,
  {$ENDIF LINUX}
  Uni, Data.DB, MemDS, DBAccess;

type
  TfConfigurarRest = reference to function(RestClient: TRestClient; OAuth2Authenticator: TOAuth2Authenticator; RestResponse: TRestResponse): Boolean;

type
  TIncTimeLimit = (tmrSecond, tmrMinute, tmrHour);

type
  TLimitHeader = class
  private
    FstrHeaderField: String;
    FstrSeparator: Char;
    FIncTime: TIncTimeLimit;
  public
    class function fNew: TLimitHeader;
    function f_HeaderField(const Value: String): TLimitHeader;
    function f_Separator(const Value: Char): TLimitHeader;
    function f_IncTime(const Value: TIncTimeLimit): TLimitHeader;
  end;

type
  TControllerRest = class
  private
    FRestClient: TRestClient;
    FRestResponse: TRestResponse;
    FOAuth2Authenticator: TOAuth2Authenticator;

    FFuncConfigRest: TfConfigurarRest;
    FstrApi: String;

    FLimitHeader: TLimitHeader;

    procedure SetRestClient(const Value: TRestClient);
    procedure SetRestResponse(const Value: TRestResponse);

    property RestResponse: TRestResponse read FRestResponse write SetRestResponse;
    property OAuth2Authenticator: TOAuth2Authenticator read FOAuth2Authenticator ;

    procedure pGravaLog(RestRequest: TRESTRequest; strSeqFgo, strRecurs, strResult: String; intStatus: Integer);
    function fConfigurarApi(): Boolean;

    function GetResponseHeaderValue: string;
  public
    property RestClient: TRestClient read FRestClient write SetRestClient;

    constructor Create(AApi: String; AFuncConfigRest: TfConfigurarRest; ALimitHeader: TLimitHeader = nil);
    destructor Destroy; Override;

    class procedure pGravaLogApiAvulsa(AstrApi, AstrRecurs, AstrParame, AstrResult: String; AintStatus: Integer);

    function fExecute(RestRequest: TRESTRequest; var JSONRetorno: String; StatusCodeRet: Array Of String; strSeqFgo: String = '';
     procBeforeExecuteRequest: TProc = nil): Boolean;

    class function fGetLastResult(strSeqFgo: string): string;
    class function fGetLastStatus(strSeqFgo: string): string;
  end;

  var
    VS_tmrWaitLimit: TDateTime;

implementation

uses
  untDominioSistemasFuncoesMultiPlataforma ;

{ TControllerRest }

procedure TControllerRest.SetRestClient(const Value: TRestClient);
begin
  FRestClient := Value;
end;

procedure TControllerRest.SetRestResponse(const Value: TRestResponse);
begin
  FRestResponse := Value;
end;

constructor TControllerRest.Create(AApi: String; AFuncConfigRest: TfConfigurarRest; ALimitHeader: TLimitHeader = nil);
begin
  FstrApi         := AApi;
  FFuncConfigRest := AFuncConfigRest;
  RestClient      := TRESTClient.Create(nil);
  RestResponse    := TRESTResponse.Create(RestClient);
  FLimitHeader    := ALimitHeader;
end;

destructor TControllerRest.Destroy;
begin
  if Assigned(OAuth2Authenticator) then
    OAuth2Authenticator.Free;

  if Assigned(RestResponse) then
    RestResponse.Free;

  if Assigned(RestClient) then
    RestClient.Free;
end;

function TControllerRest.fConfigurarApi(): Boolean;
begin
  Result := False;
  If Assigned(FFuncConfigRest) Then
    Result := FFuncConfigRest(RestClient, OAuth2Authenticator, RestResponse);
end;

procedure TControllerRest.pGravaLog(RestRequest: TRESTRequest; strSeqFgo, strRecurs,
  strResult: String; intStatus: Integer);
var
  qryLogAPI: TUniQuery ;
  strParamE: String;
  i: Integer;
  LstrColunasInsertWindows: String ;
  LstrParansInsertWindows: String ;
begin
 {$IFNDEF LINUX}
  pMultiValidaProCod('LOGAPI');
  LstrColunasInsertWindows := ', LOG_NOMMAQ, LOG_CODEMP ' ;
  LstrParansInsertWindows := ', :NOMMAQ, :CODEMP ' ;
 {$ELSE }
  LstrColunasInsertWindows := '' ;
  LstrParansInsertWindows := '' ;
 {$ENDIF LINUX};

  qryLogAPI := fMultiCriaQuery;
  try
    qryLogAPI.Close;
    qryLogAPI.SQL.Clear;
    qryLogAPI.SQL.Text :=
    STR_SQL_NAO_REPLICAR+
    ' INSERT INTO '+
    '   LOGAPI '+
    '  (AUTOINCREM, '+
    '   LOG_DTAENT, '+
    '   LOG_HORENT, '+
    '   LOG_SEQFGO, '+
    '   LOG_RECURS, '+
    '   LOG_PARAME, '+
    '   LOG_RESULT, '+
    '   LOG_STATUS, '+
    '   LOG_LOGAPI  '+
    LstrColunasInsertWindows +
    '    )          '+
    ' VALUES '+
    '  (:AUTINC,    '+
    '   :DTAENT,    '+
    '   :HORENT,    '+
    '   :SEQFGO,    '+
    '   :RECURS,    '+
    '   :PARAME,    '+
    '   :RESULT,    '+
    '   :STATUS,    '+
    '   :LOGAPI     '+
    LstrParansInsertWindows +
    '    )          ';

    qryLogAPI.ParamByName('AUTINC').AsString  := fMultiRetAutoIncrem('LOGAPI', fMultiVS_strCodEmp);

    qryLogAPI.ParamByName('DTAENT').AsDate    := Date;
    qryLogAPI.ParamByName('HORENT').AsTime    := Time();
    qryLogAPI.ParamByName('SEQFGO').AsString  := strSeqFgo;
    qryLogAPI.ParamByName('RECURS').AsString  := strRecurs;

    for i:=0 to RestRequest.Params.Count-1 do
      strParamE := strParamE + ifThen(RestRequest.Params[i].name <> '',RestRequest.Params[i].name+': ','')+RestRequest.Params[i].Value+'; ';

    qryLogAPI.ParamByName('PARAME').AsString  := strParamE;
    qryLogAPI.ParamByName('RESULT').AsString  := strResult;
    qryLogAPI.ParamByName('STATUS').AsInteger := intStatus;
    qryLogAPI.ParamByName('LOGAPI').AsString  := FstrApi;
    {$IFNDEF LINUX}
    qryLogAPI.ParamByName('NOMMAQ').AsString  := '';
    qryLogAPI.ParamByName('CODEMP').AsString  := fMultiVS_strCodEmp;
    {$ENDIF LINUX}
    qryLogAPI.ExecSQL;

  finally
    qryLogAPI.Free;
  end;

end;

function TControllerRest.fExecute(RestRequest: TRESTRequest; var JSONRetorno: String;
  StatusCodeRet: Array Of String; strSeqFgo: String = '';
  procBeforeExecuteRequest: TProc = nil): Boolean;
var
  LstrIncTime: String;
begin
  Result := False;

  if Now < VS_tmrWaitLimit then
  begin
    pGravaLog(RestRequest,
              strSeqFgo,
              ifthen(not trim(RestRequest.Resource).IsEmpty, RestRequest.Resource, RestClient.BaseURL),
              'Aguardando a liberação do limite de requisições da API. Liberação prevista para '+DateTimeToStr(VS_tmrWaitLimit),
              429);
    Exit;
  end;

  try
    if fConfigurarApi() then
    begin
      RestRequest.Response := RestResponse;

      if Assigned(procBeforeExecuteRequest) then
        procBeforeExecuteRequest;

      RestRequest.Execute;
      JSONRetorno := Trim(RestResponse.Content);

      pGravaLog(RestRequest, strSeqFgo, ifThen(not trim(RestRequest.Resource).IsEmpty, RestRequest.Resource, RestClient.BaseURL), JSONRetorno, RestResponse.StatusCode);

      if MatchStr(RestResponse.StatusCode.ToString, StatusCodeRet) then
        Result := True
      else if Assigned(FLimitHeader) then
      begin
        LstrIncTime := GetResponseHeaderValue;
        case FLimitHeader.FIncTime of
          tmrSecond: VS_tmrWaitLimit := IncSecond(Now, StrToIntDef(LstrIncTime, 0));
          tmrMinute: VS_tmrWaitLimit := IncMinute(Now, StrToIntDef(LstrIncTime, 0));
          tmrHour: VS_tmrWaitLimit := IncHour(Now, StrToIntDef(LstrIncTime, 0));
        end;

        FreeAndNil(FLimitHeader);
      end;
    end;
  except
    on E: Exception do
    begin
      JSONRetorno := E.Message;

      pGravaLog(RestRequest, strSeqFgo, ifThen(not Trim(RestRequest.Resource).IsEmpty, RestRequest.Resource, RestClient.BaseURL), E.Message, RestResponse.StatusCode);
      Result := False;
    end;
  end;
end;

function TControllerRest.GetResponseHeaderValue: string;
var
  sl: TStringList;
begin
  Result := EmptyStr;

  sl := TStringList.Create;
  try
    sl.Assign(RestResponse.Headers);
    sl.NameValueSeparator := FLimitHeader.FstrSeparator;
    Result := sl.Values[FLimitHeader.FstrHeaderField].Trim;
  finally
    sl.Free;
  end;
end;

class function TControllerRest.fGetLastResult(strSeqFgo: string): string;
var
  qryLogAPI: TUniQuery;
begin
  qryLogAPI := fMultiCriaQuery;
  try
    qryLogAPI.SQL.Add('SELECT SQL_NO_CACHE ');
    qryLogAPI.SQL.Add('  LOG_RESULT ');
    qryLogAPI.SQL.Add('FROM ');
    qryLogAPI.SQL.Add('  LOGAPI ');
    qryLogAPI.SQL.Add('WHERE LOG_SEQFGO = "' + strSeqFgo + '" ');
    qryLogAPI.SQL.Add('  AND LOG_DTAENT = CURRENT_DATE ');
    qryLogAPI.SQL.Add('ORDER BY LOG_HORENT DESC ');
    qryLogAPI.SQL.Add('LIMIT 1 ');
    qryLogAPI.Open;
    Result := qryLogAPI.FieldByName('LOG_RESULT').AsString;
  finally
    qryLogAPI.Free;
  end;
end;

class function TControllerRest.fGetLastStatus(strSeqFgo: string): string;
var
  qryLogAPI: TUniQuery ;
begin
  qryLogAPI := fMultiCriaQuery;
  try
    qryLogAPI.SQL.Add('SELECT SQL_NO_CACHE ');
    qryLogAPI.SQL.Add('  LOG_STATUS ');
    qryLogAPI.SQL.Add('FROM ');
    qryLogAPI.SQL.Add('  LOGAPI ');
    qryLogAPI.SQL.Add('WHERE LOG_SEQFGO = "' + strSeqFgo + '" ');
    qryLogAPI.SQL.Add('  AND LOG_DTAENT = CURRENT_DATE ');
    qryLogAPI.SQL.Add('ORDER BY LOG_HORENT DESC ');
    qryLogAPI.SQL.Add('LIMIT 1 ');
    qryLogAPI.Open;
    Result := qryLogAPI.FieldByName('LOG_STATUS').AsString;
  finally
    qryLogAPI.Free;
  end;
end;

class procedure TControllerRest.pGravaLogApiAvulsa(AstrApi, AstrRecurs, AstrParame, AstrResult: String; AintStatus: Integer);
var
  qryLogAPI: TUniQuery ;
begin
 {$IFNDEF LINUX}
  pMultiValidaProCod('LOGAPI');
 {$ENDIF LINUX};

  qryLogAPI := fMultiCriaQuery;
  try
    qryLogAPI.Close;
    qryLogAPI.SQL.Clear;
    qryLogAPI.SQL.Text :=
    STR_SQL_NAO_REPLICAR+
    ' INSERT INTO '+
    '   LOGAPI '+
    '  (AUTOINCREM, '+
    '   LOG_DTAENT, '+
    '   LOG_HORENT, '+
    '   LOG_RECURS, '+
    '   LOG_PARAME, '+
    '   LOG_RESULT, '+
    '   LOG_STATUS, '+
    '   LOG_CODEMP, '+
    '   LOG_LOGAPI) '+
    ' VALUES '+
    '  (:AUTINC,    '+
    '   :DTAENT,    '+
    '   :HORENT,    '+
    '   :RECURS,    '+
    '   :PARAME,    '+
    '   :RESULT,    '+
    '   :STATUS,    '+
    '   :CODEMP,    '+
    '   :LOGAPI)    ';

    qryLogAPI.ParamByName('AUTINC').AsString  := fMultiRetAutoIncrem('LOGAPI', fMultiVS_strCodEmp);

    qryLogAPI.ParamByName('DTAENT').AsDate    := Date;
    qryLogAPI.ParamByName('HORENT').AsTime    := Time();
    qryLogAPI.ParamByName('RECURS').AsString  := AstrRecurs;
    qryLogAPI.ParamByName('PARAME').AsString  := AstrParamE;
    qryLogAPI.ParamByName('RESULT').AsString  := AstrResult;
    qryLogAPI.ParamByName('STATUS').AsInteger := AintStatus;
    qryLogAPI.ParamByName('CODEMP').AsString  := fMultiVS_strCodEmp;
    qryLogAPI.ParamByName('LOGAPI').AsString  := AstrApi;

    qryLogAPI.ExecSQL;
  finally
    qryLogAPI.Free;
  end;
end;

{ TLimitHeader }

class function TLimitHeader.fNew: TLimitHeader;
begin
  Result := TLimitHeader.Create;
end;

function TLimitHeader.f_HeaderField(const Value: String): TLimitHeader;
begin
  FstrHeaderField := Value;
  Result := Self;
end;

function TLimitHeader.f_IncTime(const Value: TIncTimeLimit): TLimitHeader;
begin
  FIncTime := Value;
  Result := Self;
end;

function TLimitHeader.f_Separator(const Value: Char): TLimitHeader;
begin
  FstrSeparator := Value;
  Result := Self;
end;

initialization
  VS_tmrWaitLimit := 0;

end.
