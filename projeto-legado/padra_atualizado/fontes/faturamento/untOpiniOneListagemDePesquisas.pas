unit untOpiniOneListagemDePesquisas;

interface

uses
  IPPeerClient, Data.Bind.Components, Data.Bind.ObjectScope,
  Rest.Json, System.SysUtils, REST.Authenticator.OAuth, System.Classes,
  REST.Types, strUtils,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni;

type

  TPesquisasOpniOne = class
  private
    FCodigo: Extended;
    FDataFim: String;
    FDataInicio: String;
    FHash: String;
    FNomeEmpresa: String;
    FTitulo: String;
  public
    property Codigo: Extended read FCodigo write FCodigo;
    property DataFim: String read FDataFim write FDataFim;
    property DataInicio: String read FDataInicio write FDataInicio;
    property Hash: String read FHash write FHash;
    property NomeEmpresa: String read FNomeEmpresa write FNomeEmpresa;
    property Titulo: String read FTitulo write FTitulo;
  end;

  TOpiniOneRetornoListagemDePesquisas  = class
  private
    FPesquisas: TArray<TPesquisasOpniOne>;
  public
    property Pesquisas: TArray<TPesquisasOpniOne> read FPesquisas write FPesquisas;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TOpiniOneRetornoListagemDePesquisas;
  end;

  TControllerOpiniOneListagemDePesquisas = class
  private
    class function fListagemDePesquisas(): TOpiniOneRetornoListagemDePesquisas;
  public
    class function fPesquisaEstaVigente(strHashPesquisa: String): Boolean;
    class function fListarPesquisasOpiniOne(): TOpiniOneRetornoListagemDePesquisas;
  end;

implementation

{TOpiniOneRetornoListagemDePesquisas}

uses untOpiniOneAutenticacao, untOpiniOneRestApi, untRestApi;

destructor TOpiniOneRetornoListagemDePesquisas.Destroy;
var
  LPesquisasOpniOne: TPesquisasOpniOne;
begin

 for LPesquisasOpniOne in FPesquisas do
   LPesquisasOpniOne.free;

  inherited;
end;

class function TOpiniOneRetornoListagemDePesquisas.FromJsonString(AJsonString: string): TOpiniOneRetornoListagemDePesquisas;
begin
  Result := TJson.JsonToObject<TOpiniOneRetornoListagemDePesquisas>('{ "Pesquisas": '+AJsonString+'}');
end;

{ TControllerOpiniOneListagemDePesquisas }

class function TControllerOpiniOneListagemDePesquisas.fPesquisaEstaVigente(
  strHashPesquisa: String): Boolean;
var
  OpiniOneRetornoListagemDePesquisas: TOpiniOneRetornoListagemDePesquisas;
  Pesquisa: TPesquisasOpniOne;
begin
  Result := False;

  OpiniOneRetornoListagemDePesquisas := fListagemDePesquisas();
  try
    if Assigned(OpiniOneRetornoListagemDePesquisas) then
    begin
      for Pesquisa in OpiniOneRetornoListagemDePesquisas.Pesquisas do
      begin
        Result := (strHashPesquisa = Pesquisa.Hash);
        if Result then
          Break;
      end;
    end;
  finally
    FreeAndNil(OpiniOneRetornoListagemDePesquisas);
  end;
end;

class function TControllerOpiniOneListagemDePesquisas.fListarPesquisasOpiniOne(): TOpiniOneRetornoListagemDePesquisas;
begin
  Result := fListagemDePesquisas();
end;

class function TControllerOpiniOneListagemDePesquisas.fListagemDePesquisas(): TOpiniOneRetornoListagemDePesquisas;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('OPINIONE', TControllerOpiniOne.fConfigurarOpiniOne);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'pesquisas';
    RestRequest.Method := rmGet;

    RestRequest.Params.AddItem('Token_Autorizacao', TControllerOpiniOneAutenticacao.fRetToken, pkHTTPHEADER);
    RestRequest.Params.AddItem('SomenteVigentes', 'true', pkGETorPOST);

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], '') then
      Result := TOpiniOneRetornoListagemDePesquisas.FromJsonString(JSONRetorno);
  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;

end.
