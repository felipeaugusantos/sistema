unit Yapay.Api.Rest.Core;


interface

uses
  Vcl.Forms,
  System.Classes,
  Vcl.Dialogs,
  System.Variants,
  System.SysUtils,
  IPPeerClient,
  REST.Client,
  REST.Types;

type
{$M+}
 TApiRestCoreMetodo = (Post, Get, Patch);

 TApiRestCore = class
 strict private
   const
     sTOKEN_VALUE =
      'Token token=%s, ' +
      'type=access_token';

   type
     TApiRestCoreRESTClient = class abstract
     public
       class function Factory: TRESTClient;
     end;

     TApiRestCoreRESTResponse = class abstract
     public
       class function Factory: TRESTResponse;
     end;

     TApiRestCoreRESTRequest = class abstract
     public
       class function Factory: TRESTRequest;
     end;
   var
     FRESTClient: TRESTClient;
     FRESTRequest: TRESTRequest;
     FRESTResponse: TRESTResponse;
     FAccess_Token: string;
     FDebug: Boolean;
     FLog: Boolean;
     FMetodo: TApiRestCoreMetodo;
     FJSONRetorno: string;

   function GetBaseURL: string;
   procedure SetBaseURL(const Value: string);

   function GetJSONEnvio: string;
   procedure SetJSONEnvio(const Value: string);

    function GetAccess_Token: string;
    procedure SetAccess_Token(const Value: string);

    procedure SetMetodo(const Value: TApiRestCoreMetodo);
 published
   property BaseURL: string read GetBaseURL write SetBaseURL;
   property Metodo: TApiRestCoreMetodo read FMetodo write SetMetodo;
   property Debug: Boolean read FDebug write FDebug default False;
   property Log: Boolean read FLog write FLog default False;
   property JSONEnvio: string read GetJSONEnvio write SetJSONEnvio;
   property JSONRetorno: string read FJSONRetorno;
   property Access_Token: string read GetAccess_Token write SetAccess_Token;
 public
   procedure Execute;
   constructor Create; reintroduce;
   destructor Destroy; override;
 end;
{$M-}

implementation

{ TApiRestCore.TApiRestCoreRestClient }

class function TApiRestCore.TApiRestCoreRestClient.Factory: TRESTClient;
begin
  Result := TRESTClient.Create(nil);
  Result.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  Result.AcceptCharset := 'UTF-8, *;q=0.8';
  Result.ContentType := 'application/json';
  Result.Params.Clear;
  Result.HandleRedirects := True;
  Result.RaiseExceptionOn500 := False;
end;

{ TApiRestCore.TApiRestCoreRESTResponse }

class function TApiRestCore.TApiRestCoreRESTResponse.Factory: TRESTResponse;
begin
  Result := TRESTResponse.Create(nil);
end;

{ TApiRestCore.TApiRestCoreRESTRequest }

class function TApiRestCore.TApiRestCoreRESTRequest.Factory: TRESTRequest;
begin
  Result := TRESTRequest.Create(nil);
  Result.Timeout := 3600000;
  Result.Method := TRESTRequestMethod.rmPOST;

  with Result.Params.AddItem do
  begin
    Kind := pkHTTPHEADER;
    Name := 'Authorization';
    Options := [poDoNotEncode];
    Value := NullAsStringValue;
  end;

  with Result.Params.AddItem do
  begin
    Kind := pkREQUESTBODY;
    name := 'body';
    Options := [poDoNotEncode];
    ContentType := ctAPPLICATION_JSON;
  end;

  Result.SynchronizedEvents := False;
end;

{ TApiRestCore }

constructor TApiRestCore.Create;
begin
  inherited;
  FAccess_Token := NullAsStringValue;

  FRESTClient := TApiRestCoreRESTClient.Factory;
  FRESTResponse := TApiRestCoreRESTResponse.Factory;

  FRESTRequest := TApiRestCoreRESTRequest.Factory;
  FRESTRequest.Client := FRESTClient;
  FRESTRequest.Response := FRESTResponse;
end;

destructor TApiRestCore.Destroy;
begin
  if Assigned(FRESTClient) then
    FreeAndNil(FRESTClient);

  if Assigned(FRESTResponse) then
    FreeAndNil(FRESTResponse);

  if Assigned(FRESTRequest) then
    FreeAndNil(FRESTRequest);

  inherited;
end;

procedure TApiRestCore.Execute;
var
  sConteudoLog: TStringList;
  sMensagem: string;
  sCaminhoArquivo: string;

  function ModuleName: string;
  begin
    Result := GetModuleName(hInstance);
  end;

  procedure GravaLog;
  begin
    sCaminhoArquivo := ExtractFileDir(ModuleName) + '\' + ChangeFileExt(ExtractFileName(ModuleName), '.Log');
    if not DirectoryExists(sCaminhoArquivo) then
      ForceDirectories(sCaminhoArquivo);

    sCaminhoArquivo := sCaminhoArquivo + '\API.REST.' + FormatDateTime('yyyy.mm.dd', Date + Time)+ '_' + integer(Self).ToString + '.log';

    sConteudoLog := TStringList.Create;
    try
      if FileExists(sCaminhoArquivo) then
        sConteudoLog.LoadFromFile(sCaminhoArquivo);
      sConteudoLog.Add(sMensagem);

      sConteudoLog.SaveToFile(sCaminhoArquivo);
    finally
      if Assigned(sConteudoLog) then
        sConteudoLog.Free;
    end;
  end;

begin
  sMensagem := 'Envio ' + sLineBreak +
               'Data/Hora: '+ FormatDateTime('dd/mm/yyyy hh:nn:ss:zzz', Date + Time) + sLineBreak +
               'URL: ' + FRESTClient.BaseURL + sLineBreak +
               'Authorization:' + FRESTRequest.Params.ParameterByName('Authorization').Value + sLineBreak +
               'JSON: ' + FRESTRequest.Params.ParameterByName('body').Value;

  if FDebug then
    ShowMessage(sMensagem);

  if FLog then
  begin
    sMensagem :=
      '---------------------------------------------------------------' + sLineBreak +
      sMensagem;

    GravaLog;
  end;

  FRESTRequest.Execute;
  FJSONRetorno := FRESTResponse.Content;

  sMensagem := 'Retorno ' + sLineBreak +
               'Data/Hora: '+ FormatDateTime('dd/mm/yyyy hh:nn:ss:zzz', Date + Time) + sLineBreak +
               'URL: ' + FRESTClient.BaseURL + sLineBreak +
               'Authorization:' + FRESTRequest.Params.ParameterByName('Authorization').Value + sLineBreak +
               'JSON: ' + FRESTResponse.Content;

  if FDebug then
    ShowMessage(sMensagem);

  if FLog then
  begin
    sMensagem := sLineBreak +
                 sMensagem + sLineBreak +
                 '---------------------------------------------------------------';
    GravaLog;
  end;
end;

function TApiRestCore.GetAccess_Token: string;
begin
  result := FAccess_Token;
end;

function TApiRestCore.GetBaseURL: string;
begin
  result := FRESTClient.BaseURL;
end;

function TApiRestCore.GetJSONEnvio: string;
begin
  result := FRESTRequest.Params.ParameterByName('body').Value;
end;

procedure TApiRestCore.SetAccess_Token(const Value: string);
begin
  if FAccess_Token = Value then
    exit;

  FAccess_Token := Value;

  if FAccess_Token = NullAsStringValue then
    FRESTRequest.Params.ParameterByName('Authorization').Value := FAccess_Token
  else
    FRESTRequest.Params.ParameterByName('Authorization').Value :=
      Format(sTOKEN_VALUE, [FAccess_Token]);
end;

procedure TApiRestCore.SetBaseURL(const Value: string);
begin
  FRESTClient.BaseURL := Value;
end;

procedure TApiRestCore.SetJSONEnvio(const Value: string);
begin
  FRESTRequest.Params.ParameterByName('body').Value := Value;
end;

procedure TApiRestCore.SetMetodo(const Value: TApiRestCoreMetodo);
begin
  FMetodo := Value;
  case FMetodo of
    TApiRestCoreMetodo.Post: FRESTRequest.Method := rmPOST;
    TApiRestCoreMetodo.Get: FRESTRequest.Method := rmGET;
    TApiRestCoreMetodo.Patch: FRESTRequest.Method := rmPATCH;
  end;
end;

end.
