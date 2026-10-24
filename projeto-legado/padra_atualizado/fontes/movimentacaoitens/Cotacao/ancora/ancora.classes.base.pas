unit Ancora.Classes.Base;

interface

uses REST.Client, REST.Authenticator.Basic, Data.Bind.Components,
     Data.Bind.ObjectScope, REST.Types, System.SysUtils,
     Classes, System.SyncObjs, REST.Json,
     System.JSON, System.IOUtils, System.StrUtils,
     Ancora.Classes.EndPoint, Forms, Windows,
     Cotacao.ApiPrecos.BaseParam,
     untFuncoesSimples;


  Type

  TipoRedeAncoraCallApi = (tracaProfile, tracaFullSearch, tracaPricesStocks);

  TRedeAncoraBase = class
  private
    function fGetURL: String;
    function fGetToken: String;
    procedure pCriaRestClient;
    procedure pCriaRestRequest;
  protected
    FInicioComunicacao: TDatetime;
    FFimComunicacao: TDatetime;
    raRESTClient: TRESTClient;
    raRESTRequest: TRESTRequest;
    raRESTResponse: TRESTResponse;
//    raHTTPBasicAuthenticator: THTTPBasicAuthenticator;
    procedure pSetaParametroJsonBody(AJson: String);
  public
    TempoComunicacao: TDateTime;
    blnSalvarJson: Boolean;
    function fExecute(ATipoRedeAncoraCallApi: TipoRedeAncoraCallApi; AParamns: TBaseParamApi; Ret: TProc<TBaseParamApi>): String; virtual;
    constructor Create; virtual;
    destructor Destroy; override;
  end;

implementation

{ TRedeAncoraBase }

constructor TRedeAncoraBase.Create;
begin
//  raHTTPBasicAuthenticator := THTTPBasicAuthenticator.Create('', '');
  raRESTResponse := TRESTResponse.Create(nil);
  raRESTResponse.ContentType := 'application/json';
  pCriaRestClient;
  pCriaRestRequest;
  blnSalvarJson := False;
end;

destructor TRedeAncoraBase.Destroy;
begin
  FreeAndNil(raRESTResponse);
  FreeAndNil(raRESTClient);
  FreeAndNil(raRESTRequest);

  inherited;
end;

function TRedeAncoraBase.fExecute(ATipoRedeAncoraCallApi: TipoRedeAncoraCallApi;
  AParamns: TBaseParamApi; Ret: TProc<TBaseParamApi>): String;
  var JsonEnvio: String;

begin
  Try
    AParamns.RetornoApi.Sucess := False;
    AParamns.RetornoApi.Falha := '';

    case ATipoRedeAncoraCallApi of
      tracaFullSearch,
      tracaProfile: raRESTRequest.Method := rmGET;
      tracaPricesStocks: raRESTRequest.Method := rmPOST;
    End;

    case ATipoRedeAncoraCallApi of
      tracaProfile: raRESTClient.BaseURL :=  fGetURL + '/profile';
      tracaFullSearch: raRESTClient.BaseURL :=  fGetURL + '/products/full-search?' + TParamnsFullSearch(AParamns).fMontaParam;
      tracaPricesStocks: raRESTClient.BaseURL :=  fGetURL + '/products/prices-stocks';
    end;

    JsonEnvio := AParamns.JsonEnvioBody;
    pSetaParametroJsonBody(JsonEnvio);

    raRESTRequest.Execute;


    TempoComunicacao := FFimComunicacao  - FInicioComunicacao;


    AParamns.RetornoApi.StatusCode := raRESTResponse.StatusCode;
    AParamns.RetornoApi.Retorno := raRESTResponse.Content;
    AParamns.RetornoApi.Sucess := AParamns.RetornoApi.StatusCode = 200;

    If Assigned(Ret) Then
      Ret(AParamns);
  Except
    on e: Exception do
    begin
      AParamns.RetornoApi.StatusCode := 0;
      AParamns.RetornoApi.Retorno := e.message;
      AParamns.RetornoApi.Falha := e.message;
      AParamns.RetornoApi.Sucess := False;
    end;
  End;
end;

function TRedeAncoraBase.fGetToken: String;
begin
  Result := fCfgSis('ANCTOK'); //acea0e72322c94474146f939413d8e89';
end;

function TRedeAncoraBase.fGetURL: String;
begin
    Result := fCfgSis('ANCURL'); //https://app.redeancora.com.br/b2b/api/docs/api/integration
end;

procedure TRedeAncoraBase.pCriaRestClient;
begin
  raRESTClient := TRESTClient.Create(fGetURL);
//  raRESTClient.Authenticator := raHTTPBasicAuthenticator;
  raRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  raRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  raRESTClient.BaseURL := 'https://staging.redeancora.com.br/b2b/app/api/integration';
  raRESTClient.Params.Clear;
  raRESTClient.HandleRedirects := True;
  raRESTClient.RaiseExceptionOn500 := False;
  raRESTClient.SynchronizedEvents := True;
end;

procedure TRedeAncoraBase.pCriaRestRequest;
begin
  raRESTRequest := TRESTRequest.Create(nil);
  raRESTRequest.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  raRESTRequest.AcceptCharSet := 'UTF-8, *;q=0.8';

  raRESTRequest.Client := raRESTClient;
  raRESTRequest.Response := raRESTResponse;
  raRESTRequest.SynchronizedEvents := False;

  raRESTRequest.Params.AddItem.Kind  := pkHTTPHEADER;
  raRESTRequest.Params[0].name := 'X-API-KEY';
  raRESTRequest.Params[0].Value := fGetToken;
  raRESTRequest.Params[0].Options := [poDoNotEncode];

end;


procedure TRedeAncoraBase.pSetaParametroJsonBody(AJson: String);
begin
  If AJson.IsEmpty Then
    Exit;

  raRESTRequest.Params.AddItem.Kind  := pkREQUESTBODY;
  raRESTRequest.Params[raRESTRequest.Params.Count -1].name := '';
  raRESTRequest.Params[raRESTRequest.Params.Count -1].Value := AJson;
  raRESTRequest.Params[raRESTRequest.Params.Count -1].ContentType := ctAPPLICATION_JSON;
end;

end.



