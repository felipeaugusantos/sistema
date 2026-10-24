unit untDateTimeFromAPI;

interface

function fTryGetUTCDatetimeFromApi(var ADatetime: TDateTime): Boolean;
function fCurrentUTCDatetimeFromWorldTimeApi(var ADatetime: TDateTime): Boolean;
function fCurrentUTCDatetimeFromWorldClockApi(var ADatetime: TDateTime): Boolean;

implementation

uses
  REST.Types, REST.Client, untFuncoesSimples, SysUtils;

function fCurrentDatetimeFromApi(const AUrl, AField: String): String;
var
  LClient: TRESTClient;
  LRequest: TRESTRequest;
  LResponse: TRESTResponse;
begin
  LClient := nil;
  LRequest := nil;
  LResponse := nil;
  try
    LClient := TRESTClient.Create(nil);
    LClient.ContentType := 'application/json';
    LClient.BaseURL := AUrl;
    LResponse := TRESTResponse.Create(nil);
    LRequest := TRESTRequest.Create(nil);
    LRequest.Accept := 'application/json';
    LRequest.Method := TRESTRequestMethod.rmGET;
    LRequest.Timeout := 5000;
    LRequest.HandleRedirects := True;
    LRequest.Client := LClient;
    LRequest.Response := LResponse;
    LRequest.Execute;
    Result := LResponse.Content;
    Result := TJsonUtils.GetValue<String>(LResponse.Content, AField);
    Result := Format('%s/%s/%s %s:%s', [Copy(Result, 09, 2) { day } ,
      Copy(Result, 06, 2) { mounth } , Copy(Result, 01, 4) { year } ,
      Copy(Result, 12, 2) { hour } , Copy(Result, 15, 2) { minute } ]);
  finally
    LClient.Disconnect;
    LClient.Free;
    LRequest.Free;
    LResponse.Free;
  end;
end;

function fCurrentUTCDatetimeFromWorldTimeApi(var ADatetime: TDateTime): Boolean;
const
  _URL_ = 'http://worldtimeapi.org/api/timezone/etc/utc';
  _FIELD_ = 'datetime';
begin
  try
    ADatetime := StrToDateTimeDef(fCurrentDatetimeFromApi(_URL_, _FIELD_), 0);
    Result := ADatetime <> 0;
  except
    Result := False;
  end;
end;

function fCurrentUTCDatetimeFromWorldClockApi(var ADatetime: TDateTime): Boolean;
const
  _URL_ = 'http://worldclockapi.com/api/json/utc/now';
  _FIELD_ = 'currentDateTime';
begin
  try
    ADatetime := StrToDateTimeDef(fCurrentDatetimeFromApi(_URL_, _FIELD_), 0);
    Result := ADatetime <> 0;
  except
    Result := False;
  end;
end;

function fTryGetUTCDatetimeFromApi(var ADatetime: TDateTime): Boolean;
begin
  If fCurrentUTCDatetimeFromWorldTimeApi(ADatetime) Then
    Exit(True);
  If fCurrentUTCDatetimeFromWorldClockApi(ADatetime) Then
    Exit(True);
  Result := False;
end;

end.


