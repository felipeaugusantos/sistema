unit Delta.Classes.Base;

interface

uses REST.Client, REST.Authenticator.Basic, Data.Bind.Components,
     Data.Bind.ObjectScope, REST.Types, System.SysUtils,
     Classes, System.SyncObjs, REST.Json,
     System.JSON, System.IOUtils, System.StrUtils,
     Delta.Classes.EndPoint, Forms, Windows,
     Cotacao.ApiPrecos.BaseParam,
     untFuncoesSimples;


  Type

  TRedeDeltaBase = class
  private
    procedure pCriaRestClient;
    procedure pCriaRestRequest;
    procedure pSetaParametro(AContentType: TRESTContentType; ARESTRequestParameterKind: TRESTRequestParameterKind; AValue: String; AName: String);

  protected
    raRESTClient: TRESTClient;
    raRESTRequest: TRESTRequest;
    raRESTResponse: TRESTResponse;
  public
    TempoComunicacao: TDateTime;
    function fExecute(AParamns: TBaseParamApi; Ret: TProc<TBaseParamApi>): String; virtual;
    constructor Create; virtual;
    destructor Destroy; override;
  end;

implementation

{ TRedeDeltaBase }

constructor TRedeDeltaBase.Create;
begin
  raRESTResponse := TRESTResponse.Create(nil);
  raRESTResponse.ContentType := 'application/json';
  pCriaRestClient;
  pCriaRestRequest;
end;

destructor TRedeDeltaBase.Destroy;
begin
  FreeAndNil(raRESTResponse);
  FreeAndNil(raRESTClient);
  FreeAndNil(raRESTRequest);
  inherited;
end;

function TRedeDeltaBase.fExecute(AParamns: TBaseParamApi; Ret: TProc<TBaseParamApi>): String;
begin
  Try
    AParamns.RetornoApi.Sucess := False;
    AParamns.RetornoApi.Falha := '';

    raRESTRequest.Method := rmGET;
    raRESTClient.BaseURL :=  fCfgSis('DELURL') + 'consulta_estoque/' + TParamnsConsultaEstoque(AParamns).strCodigoFabrica;
    pSetaParametro(ctNone, pkHTTPHEADER, fCfgSis('DELAPK'), 'apikey');

    raRESTRequest.Execute;

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

procedure TRedeDeltaBase.pCriaRestClient;
begin
  raRESTClient := TRESTClient.Create(fCfgSis('DELURL'));
//  raRESTClient.Authenticator := raHTTPBasicAuthenticator;
  raRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  raRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
  raRESTClient.BaseURL := '';
  raRESTClient.Params.Clear;
  raRESTClient.HandleRedirects := True;
  raRESTClient.RaiseExceptionOn500 := False;
  raRESTClient.SynchronizedEvents := True;
end;

procedure TRedeDeltaBase.pCriaRestRequest;
begin
  raRESTRequest := TRESTRequest.Create(nil);
  raRESTRequest.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
  raRESTRequest.AcceptCharSet := 'UTF-8, *;q=0.8';

  raRESTRequest.Client := raRESTClient;
  raRESTRequest.Response := raRESTResponse;
  raRESTRequest.SynchronizedEvents := False;
end;

procedure TRedeDeltaBase.pSetaParametro(AContentType: TRESTContentType;
  ARESTRequestParameterKind: TRESTRequestParameterKind; AValue: String; AName: String);
begin
  If AValue.IsEmpty Then
    Exit;

  raRESTRequest.Params.AddItem.Kind  := ARESTRequestParameterKind;
  raRESTRequest.Params[raRESTRequest.Params.Count -1].Options := [poDoNotEncode];
  raRESTRequest.Params[raRESTRequest.Params.Count -1].name := AName;
  raRESTRequest.Params[raRESTRequest.Params.Count -1].Value := AValue;
  raRESTRequest.Params[raRESTRequest.Params.Count -1].ContentType := AContentType;
end;


end.



