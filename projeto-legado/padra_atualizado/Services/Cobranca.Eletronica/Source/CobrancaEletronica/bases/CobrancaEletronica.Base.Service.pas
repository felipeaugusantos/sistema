unit CobrancaEletronica.Base.Service;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client,
  {$ENDIF LINUX}
  untRestApi, System.JSON, strUtils, Data.DB, MemDS, DBAccess, Uni;

type
  TBaseServiceCobrancaEletronica = class
  private
    FRestResponse   : TRestResponse;
    FRestRequest    : TRestRequest;
    FMethod         : TRestMethod;
    FBaseResource   : String;
    FResource       : String;
    FControllerRest : TControllerRest;
    FConfigurarRest : TfConfigurarRest;
    FBody           : String;
    FSeqFgo         : String;
    FApi            : String;

    function GetFullURLRequest: String;

    procedure SetBaseResource(const Value: String);
    procedure SetResource(const Value: String);
    procedure SetBody(const Value: String);
    procedure SetApi(const Value: String);
    procedure SetConfigurarRest(const Value: TfConfigurarRest);

  protected
    procedure pClearRequest;
    procedure pLoadConnection; virtual;
    procedure pValidaResposta; virtual; abstract;
    procedure pExecutar;
    procedure pAddQueryParams(const AName, AValue: String);

    property RestRequest    : TRestRequest     read FRestRequest    write FRestRequest;
    property RestResponse   : TRestResponse    read FRestResponse;

    property Method         : TRestMethod      read FMethod         write FMethod;
    property BaseResource   : String                                write SetBaseResource;
    property Resource       : String                                write SetResource;
    property Body           : String                                write SetBody;
    property ConfigurarRest : TfConfigurarRest                      write SetConfigurarRest;
    property Api            : String                                write SetApi;

  public
    constructor Create;

    property Request        : TRestRequest  read FRestRequest;
    property Response       : TRestResponse read FRestResponse;
    property FullURLRequest : String        read GetFullURLRequest;
    property SeqFgo         : String        read FSeqFgo           write FSeqFgo;
  end;

implementation

uses
  CobrancaEletronica.Lib.Types;

{ TControllerPagarMe }

constructor TBaseServiceCobrancaEletronica.Create;
begin
  FRestRequest    := nil;
  FControllerRest := nil;

  FBaseResource   := EmptyStr;
  FResource       := EmptyStr;
  FBody           := EmptyStr;
  FSeqFgo         := EmptyStr;
  FApi            := EmptyStr;

  pLoadConnection;
end;

function TBaseServiceCobrancaEletronica.GetFullURLRequest: String;
begin
  Result := Trim(FControllerRest.RestClient.BaseURL)
          + IfThen(not FBaseResource.IsEmpty,'/',EmptyStr)
          + FBaseResource.Trim
          + FResource.Trim;
end;

procedure TBaseServiceCobrancaEletronica.pAddQueryParams(const AName,
  AValue: String);
begin
    FRestRequest
      .Params
      .AddItem(AName,
               AValue,
               TRESTRequestParameterKind.pkGETorPOST,
               [poDoNotEncode]);
end;

procedure TBaseServiceCobrancaEletronica.pClearRequest;
begin
  FBody     := EmptyStr;
  FResource := EmptyStr;

  while FRestRequest.Params.Count > 0 do
    FRestRequest.Params.Items.Delete(Pred(FRestRequest.Params.Count));
end;

procedure TBaseServiceCobrancaEletronica.pExecutar;
var
  LJsonRetorno : String;
begin
  FRestRequest.Resource := FBaseResource.Trim
                         + FResource.Trim;

  FRestRequest.Method   := FMethod;

  if not FBody.IsEmpty then
  begin
    FRestRequest
      .Params
      .AddItem('',
               FBody,
               TRESTRequestParameterKind.pkREQUESTBODY,
               [],
               TRESTContentType.ctAPPLICATION_JSON);
  end;

  FControllerRest.fExecute(FRestRequest, LJsonRetorno, ['200','201'], FSeqFgo);
  FRestResponse := FRestRequest.Response;
  pValidaResposta;
end;

procedure TBaseServiceCobrancaEletronica.pLoadConnection;
begin
  FControllerRest := TControllerRest.Create(FApi, FConfigurarRest);
  FRestRequest    := TRestRequest.Create(FControllerRest.RestClient);
end;

procedure TBaseServiceCobrancaEletronica.SetApi(const Value: String);
begin
  FApi := Value;
end;

procedure TBaseServiceCobrancaEletronica.SetBaseResource(const Value: String);
begin
  FBaseResource := Value;
end;

procedure TBaseServiceCobrancaEletronica.SetBody(const Value: String);
begin
  FBody := Value;
end;

procedure TBaseServiceCobrancaEletronica.SetConfigurarRest(const Value: TfConfigurarRest);
begin
  FConfigurarRest := Value;
end;

procedure TBaseServiceCobrancaEletronica.SetResource(const Value: String);
begin
  FResource := Value;
end;

end.
