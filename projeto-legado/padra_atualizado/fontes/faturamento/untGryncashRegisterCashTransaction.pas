unit untGryncashRegisterCashTransaction;

interface

uses
  Generics.Collections,
  Rest.Json,
  REST.Client,
  REST.Types,
  sysUtils,
  System.JSON,
  untFuncoesSimples;

type
//BEGIN - OBJETOS DE RETORNO - BL
  TCommonResponseClass = class
  private
    FDescription: String;
    FIsError: Boolean;
    FStatusCode: Extended;
  public
    property description: String read FDescription write FDescription;
    property isError: Boolean read FIsError write FIsError;
    property statusCode: Extended read FStatusCode write FStatusCode;
  end;

  TRegisterCashTransaction = class
  private
    FCommonResponse: TCommonResponseClass;
    FTransactionID: Extended;
  public
    property commonResponse: TCommonResponseClass read FCommonResponse write FCommonResponse;
    property transactionID: Extended read FTransactionID write FTransactionID;
    constructor Create;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TRegisterCashTransaction;
  end;
//END - OBJETOS DE RETORNO - BL


//BEGIN - CONTROLLER - BL
  TControllerRegisterCashTransaction = class
  private
  public
    class function fRegisterCashTransaction(strDocCli: String; fltVlVend, fltVlChBk: Double): TRegisterCashTransaction;
  end;
//END - CONTROLLER - BL

implementation

uses
  untRestApi, untGryncashRestApi;

//BEGIN - MÉTODOS OBJETOS DE RETORNO
{TRegisterCashTransaction}
constructor TRegisterCashTransaction.Create;
begin
  inherited;
  FCommonResponse := TCommonResponseClass.Create();
end;

destructor TRegisterCashTransaction.Destroy;
begin
  FCommonResponse.free;
  inherited;
end;

class function TRegisterCashTransaction.FromJsonString(AJsonString: string): TRegisterCashTransaction;
begin
  result := TJson.JsonToObject<TRegisterCashTransaction>(AJsonString)
end;
//END - MÉTODOS OBJETOS DE RETORNO - BL


//BEGIN - MÉTODOS CONTROLLER - BL
class function TControllerRegisterCashTransaction.fRegisterCashTransaction(strDocCli: String; fltVlVend, fltVlChBk: Double): TRegisterCashTransaction;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('GRYNCASH', TControllerGryncash.fConfigurarGryncash);
  RestRequest    := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Method        := rmPOST;
    RestRequest.Resource      := 'externalAPI/1/registerCashTransaction';
    RestRequest.Accept        := 'application/json';
    RestRequest.AcceptCharset := 'UTF-8';

    RestRequest.Params.AddItem('ExternalToken',
                               fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_TOKGRY']),
                               pkHTTPHEADER);

    RestRequest.Params.AddItem('storeID',
                               fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_STORID']),
                               pkGETorPOST);

    RestRequest.Params.AddItem('userCPF'                                     , strDocCli              , pkGETorPOST);
    RestRequest.Params.AddItem('transactionAmount'                           , fFloatToSQL(fltVlVend) , pkGETorPOST);
    RestRequest.Params.AddItem('debitingUserCashBack'                        , fFloatToSQL(fltVlChBk) , pkGETorPOST);
    RestRequest.Params.AddItem('overrideUserCashbackDebitOption'             , 'true'                 , pkGETorPOST);
    RestRequest.Params.AddItem('override1MinuteRepeatedTransactionProtection', 'false'                , pkGETorPOST);


    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
    begin
      Result := TRegisterCashTransaction.FromJsonString(JSONRetorno);
      if Result.FCommonResponse.FIsError then
        fMensagem('ATENÇÃO!', Result.FCommonResponse.FDescription , ['&Ok']);
    end
    else
      fMensagem('ATENÇÃO!', 'Serviço Gryncash indisponível!' , ['&Ok']);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;
//END - MÉTODOS CONTROLLER - BL

end.
