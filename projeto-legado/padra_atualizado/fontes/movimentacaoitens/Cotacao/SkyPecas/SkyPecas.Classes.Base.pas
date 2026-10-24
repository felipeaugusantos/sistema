unit SkyPecas.Classes.Base;

interface

uses REST.Client, REST.Authenticator.Basic, Data.Bind.Components,
     Data.Bind.ObjectScope, REST.Types, System.SysUtils,
     Classes, System.SyncObjs, REST.Json,
     System.JSON, System.IOUtils, System.StrUtils,
     SkyPecas.Classes.EndPoint, Forms, Windows,
     Cotacao.ApiPrecos.BaseParam,
     Cotacao.ApiPrecos.ConstAndTypes,
     untFuncoesSimples, Dialogs, IPPeerClient;

Type
  TTipoRedeSkyCallApi = (trSkyToken, trSkyBuscaPreco);


  TRedeSkyPecasBase = class
  private
    procedure pCriaRestClient;
    procedure pCriaRestRequest;
    procedure pSetToken(const Value: String);
  protected
    FURL: String;
    FUsuario: String;
    FSenha: String;
    FCnpj: string;
    raRESTClient: TRESTClient;
    raRESTRequest: TRESTRequest;
    raRESTResponse: TRESTResponse;
    raHTTPBasicAuthenticator: THTTPBasicAuthenticator;
    FToken: String;
    procedure pSetaParametro(AContentType: TRESTContentType;
      ARESTRequestParameterKind: TRESTRequestParameterKind; AValue: String; AName: String);
  public
    TempoComunicacao: TDateTime;
    blnSalvarJson: Boolean;
    function fExecute(ATipoRedeSkyCallApi: TTipoRedeSkyCallApi; var AParamns: TBaseParamApi; Ret: TProc<TBaseParamApi>; var AFalha: String): String; virtual;
    constructor Create; virtual;
    destructor Destroy; override;
    property Token: String read FToken write pSetToken;
  end;

implementation

{ TSkyPecasBase }

constructor TRedeSkyPecasBase.Create;
begin
  raRESTResponse := TRESTResponse.Create(nil);
  raRESTResponse.ContentType := 'application/json';
  pCriaRestClient;
  pCriaRestRequest;
  blnSalvarJson := True;
  FUsuario := fCfgSis('SKYUSU');
  FSenha   := fCfgSis('SKYPAS');
  FCnpj    := fCfgSis('SKYCNP');
  FURL     := fCfgSis('SKYURL');
end;

destructor TRedeSkyPecasBase.Destroy;
begin
  FreeAndNil(raRESTResponse);
  FreeAndNil(raRESTRequest);
  FreeAndNil(raRESTClient);

  inherited;
end;

function TRedeSkyPecasBase.fExecute(ATipoRedeSkyCallApi: TTipoRedeSkyCallApi; var AParamns: TBaseParamApi;
Ret: TProc<TBaseParamApi>; var AFalha: String): String;
var
  JsonEnvio: String;
  lURL: string;
  lQuery: String;
begin
  lURL := FURL;
  AParamns.RetornoApi.Sucess := False;
  AParamns.RetornoApi.Falha := '';
  raRESTRequest.Params.Clear;
  Try
    case ATipoRedeSkyCallApi of
      trSkyToken: begin
                    raRESTRequest.Method := rmPOST;
                    raRESTClient.BaseURL := lURL + 'usuario/login';
                    TParamSkyAcesso(AParamns).pSetParamnsAutenticacao(FCnpj, FUsuario, FSenha);
                  end;
      trSkyBuscaPreco: begin
                         raRESTRequest.Method := rmGet;
                         raRESTClient.BaseURL := lURL + 'produtos';
                       end;
    end;

    JsonEnvio := AParamns.JsonEnvioBody;

    case ATipoRedeSkyCallApi of
      trSkyToken: pSetaParametro(ctAPPLICATION_JSON, pkREQUESTBODY, JsonEnvio, '');
      trSkyBuscaPreco: Begin
                         lQuery := '';
                         pSetaParametro(ctNone, pkHTTPHEADER, FToken, 'Authorization');
                         pSetaParametro(ctNone, pkHTTPHEADER, TParamSkyConsultaProduto(AParamns).Empresa.ToString, 'CodigoLoja');
                         pSetaParametro(ctNone, pkHTTPHEADER, 'application/json', 'Accept');


                         If Not fEmptyStr(TParamSkyConsultaProduto(AParamns).codigo_barras) Then
                           lQuery := lQuery + IIf(lQuery<> '', '&', '') + 'codigo_barras={codigo_barras}';
                         If Not fEmptyStr(TParamSkyConsultaProduto(AParamns).Marca) Then
                           lQuery := lQuery + IIf(lQuery<> '', '&', '') + 'marca={marca}';
                         If Not fEmptyStr(TParamSkyConsultaProduto(AParamns).codigo_fabrica) Then
                           lQuery := lQuery + IIf(lQuery<> '', '&', '') + 'codigo={codigo}';

                         raRESTClient.BaseURL := raRESTClient.BaseURL + '?' + lQuery;

                         If Not fEmptyStr(TParamSkyConsultaProduto(AParamns).codigo_barras) Then
                           raRESTClient.Params.ParameterByName('codigo_barras').Value := TParamSkyConsultaProduto(AParamns).codigo_barras;
                         If Not fEmptyStr(TParamSkyConsultaProduto(AParamns).Marca) Then
                           raRESTClient.Params.ParameterByName('marca').Value := TParamSkyConsultaProduto(AParamns).marca;
                         If Not fEmptyStr(TParamSkyConsultaProduto(AParamns).codigo_fabrica) Then
                           raRESTClient.Params.ParameterByName('codigo').Value := TParamSkyConsultaProduto(AParamns).codigo_fabrica;
                       End;
    End;

    raRESTRequest.Execute;
    AParamns.RetornoApi.StatusCode := raRESTResponse.StatusCode;
    AParamns.RetornoApi.Retorno := raRESTResponse.Content;
    AParamns.RetornoApi.Sucess := AParamns.RetornoApi.StatusCode = 200;

    If Assigned(Ret) Then
      Ret(AParamns);
    If Not AParamns.RetornoApi.Sucess Then
      AFalha := AParamns.RetornoApi.Falha;
  Except
    on e:Exception do
    Begin
      pMensagensErro(e.message, '[TRedeSkyPecasBase.fExecute]');
      AFalha := e.message;
      AParamns.RetornoApi.StatusCode := raRESTResponse.StatusCode;
      AParamns.RetornoApi.Falha := raRESTResponse.Content;

    End;
  End;

end;

procedure TRedeSkyPecasBase.pCriaRestClient;
begin
  Try
    raRESTClient := TRESTClient.Create('');
    raRESTClient.Accept := 'application/json, text/plain; q=0.9, text/html;q=0.8,';
    raRESTClient.AcceptCharset := 'UTF-8, *;q=0.8';
    raRESTClient.BaseURL := FURL;
    raRESTClient.Params.Clear;
    raRESTClient.HandleRedirects := True;
    raRESTClient.RaiseExceptionOn500 := False;
    raRESTClient.SynchronizedEvents := False;
  Except
    on e: Exception do
    begin
      Showmessage(e.message);
    End;
  End;
end;

procedure TRedeSkyPecasBase.pCriaRestRequest;
begin
  raRESTRequest := TRESTRequest.Create(nil);
  raRESTRequest.Client := raRESTClient;
  raRESTRequest.Response := raRESTResponse;
  raRESTRequest.SynchronizedEvents := False;
end;

procedure TRedeSkyPecasBase.pSetaParametro(AContentType: TRESTContentType;
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

procedure TRedeSkyPecasBase.pSetToken(const Value: String);
begin
  FToken := Value;
end;

end.


