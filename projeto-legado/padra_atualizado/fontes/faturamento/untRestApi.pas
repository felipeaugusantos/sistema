{**************************************************ATENÇÃO************************************************}
{*** O OBJETIVO DESSA CLASSE É APENAS FAZER A PONTE ENTRE OS SISTEMAS QUE ESTÃO SENDO INTEGRADOS.      ***}
{***                                                                                                   ***}
{*** PORTANTO:                                                                                         ***}
{*** 1 - ESSA CLASSE NÃO DEVE FAZER INTERAÇÃO COM O USUÁRIO, COMO EXIBIÇÃO DE MENSAGENS E FORMULÁRIOS. ***}
{*** 2 - ESSA CLASSE É COMPARTILHADA ENTRE OUTROS PROJETOS WINDOWS/LINUX, PORTANTO NÃO ADICIONE        ***}
{***     DEPENDÊNCIAS NO USES QUE POSSAM PREJUDICAR OUTROS SISTEMAS.                                   ***}
{*** 3 - UTILIZE SEMPRE O RETORNO DO MÉTODO fExecute E O CONTEÚDO DA var JSONRetorno PARA FAZER AS     ***}
{***     SUAS TRATATIVAS FORA DESSA CLASSE.                                                            ***}
{*** 4 - SE PRECISAR UTILIZAR UMA FUNÇÃO/PROCEDIMENTO QUE ESTEJA EM OUTRA UNIT, UTILIZE-A SEMPRE POR   ***}
{***     REFERÊNCIA(reference to function), POIS ASSIM DISPENSA A NECESSIDADE DE ADICIONAR A UNIT NO   ***}
{***     USES E CONSEQUENTEMENTE NÃO QUEBRA OUTROS PROJETOS.                                           ***}
{***                                                                                                   ***}
{******************************************************************************************************BL*}
unit untRestApi;

interface

uses
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  Rest.Json, System.SysUtils, REST.Authenticator.OAuth, System.Classes,
  REST.Types, strUtils, DateUtils,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client, untConstantes, Uni,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess;

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

    FblnOcultarBodyNoLog: Boolean;

    procedure SetRestClient(const Value: TRestClient);
    procedure SetRestResponse(const Value: TRestResponse);

    property RestResponse: TRestResponse read FRestResponse write SetRestResponse;
    property OAuth2Authenticator: TOAuth2Authenticator read FOAuth2Authenticator ;

    procedure pGravaLog(RestRequest: TRESTRequest; strSeqFgo, strRecurs, strResult: String; intStatus: Integer);
    function fConfigurarApi(): Boolean;

    function GetResponseHeaderValue: string;
  public
    property RestClient: TRestClient read FRestClient write SetRestClient;
    constructor Create(AApi: String; AFuncConfigRest: TfConfigurarRest; ALimitHeader: TLimitHeader = nil; AblnOcultarBodyNoLog: Boolean = False);
    destructor Destroy; Override;
    function fExecute(RestRequest: TRESTRequest; var JSONRetorno: String; StatusCodeRet: Array Of String; strSeqFgo: String = ''): Boolean;
    class function fGetLastLog(strSeqFgo: string): string;

    class procedure pGravaLogApiAvulsa(AstrApi, AstrRecurs, AstrParame, AstrResult: String; AintStatus: Integer);
  end;

  var
    VS_tmrWaitLimit: TDateTime;

implementation

{ TControllerRest }

procedure TControllerRest.SetRestClient(const Value: TRestClient);
begin
  FRestClient := Value;
end;

procedure TControllerRest.SetRestResponse(const Value: TRestResponse);
begin
  FRestResponse := Value;
end;

constructor TControllerRest.Create(AApi: String; AFuncConfigRest: TfConfigurarRest; ALimitHeader: TLimitHeader = nil; AblnOcultarBodyNoLog: Boolean = False);
begin
  FstrApi         := AApi;
  FFuncConfigRest := AFuncConfigRest;
  RestClient      := TRESTClient.Create(nil);
  RestResponse    := TRESTResponse.Create(RestClient);
  FLimitHeader    := ALimitHeader;
  FblnOcultarBodyNoLog := AblnOcultarBodyNoLog;
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
  qryLogAPI: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  strParamE: String;
  i: Integer;
  LstrColunasInsertWindows: String ;
  LstrParansInsertWindows: String ;
begin
 {$IFNDEF LINUX}
  pValidaProCod('LOGAPI');
  LstrColunasInsertWindows := ', LOG_NOMMAQ, LOG_CODEMP ' ;
  LstrParansInsertWindows := ', :NOMMAQ, :CODEMP ' ;
 {$ELSE }
  LstrColunasInsertWindows := '' ;
  LstrParansInsertWindows := '' ;
 {$ENDIF LINUX};

 strParamE := EmptyStr;

  qryLogAPI := fCriaQuery;
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

    qryLogAPI.ParamByName('AUTINC').AsString  := fRetAutoIncrem('LOGAPI', VS_strCodEmp);

    qryLogAPI.ParamByName('DTAENT').AsDate    := Date;
    qryLogAPI.ParamByName('HORENT').AsTime    := fTime();
    qryLogAPI.ParamByName('SEQFGO').AsString  := strSeqFgo;
    qryLogAPI.ParamByName('RECURS').AsString  := strRecurs;

    for i:=0 to RestRequest.Params.Count-1 do
    begin
      if (FblnOcultarBodyNoLog) and (RestRequest.Params[i].Kind = pkREQUESTBODY) then
        Continue;

      strParamE := strParamE + IIF(RestRequest.Params[i].name <> '',RestRequest.Params[i].name+': ','')+RestRequest.Params[i].Value+'; ';
    end;

    qryLogAPI.ParamByName('PARAME').AsString  := strParamE;
    qryLogAPI.ParamByName('RESULT').AsString  := strResult;
    qryLogAPI.ParamByName('STATUS').AsInteger := intStatus;
    qryLogAPI.ParamByName('LOGAPI').AsString  := FstrApi;
    {$IFNDEF LINUX}
    qryLogAPI.ParamByName('NOMMAQ').AsString  := VS_ComputerNetName;
    qryLogAPI.ParamByName('CODEMP').AsString  := VS_strCodEmp;
    {$ENDIF LINUX}
    qryLogAPI.ExecSQL;

  finally
   {$IFNDEF LINUX}
     qryLogAPI.Free;
   {$ENDIF LINUX}
  end;

end;

function TControllerRest.fExecute(RestRequest: TRESTRequest; var JSONRetorno: String; StatusCodeRet: Array Of String; strSeqFgo: String = ''): Boolean;
var
  LstrIncTime: String;
begin
  Result := False;

  if Now < VS_tmrWaitLimit then
  begin
    pGravaLog(RestRequest,
              strSeqFgo,
              IIF(not fEmptyStr(RestRequest.Resource), RestRequest.Resource, RestClient.BaseURL),
              'Aguardando a liberação do limite de requisições da API. Liberação prevista para '+DateTimeToStr(VS_tmrWaitLimit),
              429);
    Exit;
  end;

  try
    if fConfigurarApi() then
    begin
      RestRequest.Response := RestResponse;

      RestRequest.Execute;
      JSONRetorno := Trim(RestResponse.Content);

      pGravaLog(RestRequest, strSeqFgo, RestRequest.Resource, JSONRetorno, RestResponse.StatusCode);

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

      pGravaLog(RestRequest, strSeqFgo, RestRequest.Resource, E.Message, RestResponse.StatusCode);
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

class function TControllerRest.fGetLastLog(strSeqFgo: string): string;
var
  qryLogAPI: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryLogAPI := fCriaQuery;
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
   {$IFNDEF LINUX}
    qryLogAPI.Free;
   {$ENDIF LINUX}
  end;
end;

class procedure TControllerRest.pGravaLogApiAvulsa(AstrApi, AstrRecurs, AstrParame, AstrResult: String; AintStatus: Integer);
var
  qryLogAPI: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
 {$IFNDEF LINUX}
  pValidaProCod('LOGAPI');
 {$ENDIF LINUX};

  qryLogAPI := fCriaQuery;
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

    qryLogAPI.ParamByName('AUTINC').AsString  := fRetAutoIncrem('LOGAPI', VS_strCodEmp);

    qryLogAPI.ParamByName('DTAENT').AsDate    := Date;
    qryLogAPI.ParamByName('HORENT').AsTime    := fTime();
    qryLogAPI.ParamByName('RECURS').AsString  := AstrRecurs;
    qryLogAPI.ParamByName('PARAME').AsString  := AstrParamE;
    qryLogAPI.ParamByName('RESULT').AsString  := AstrResult;
    qryLogAPI.ParamByName('STATUS').AsInteger := AintStatus;
    qryLogAPI.ParamByName('CODEMP').AsString  := VS_strCodEmp;
    qryLogAPI.ParamByName('LOGAPI').AsString  := AstrApi;

    qryLogAPI.ExecSQL;
  finally
   {$IFNDEF LINUX}
     qryLogAPI.Free;
   {$ENDIF LINUX}
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
