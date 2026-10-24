unit untGryncashCashTransactionDetails;

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
//BEGIN - OBJETOS DE RETORNO
  TCashTransactionClass = class
  private
    FCashbackCredit: Extended;
    FCashbackDebit: Extended;
    FConfirmedAtAsDateTime: String;
    FStartedAtAsDateTime: String;
    FTransactionID: Extended;
    FTransactionValue: Extended;
    FUserCPF: String;
  public
    property cashbackCredit: Extended read FCashbackCredit write FCashbackCredit;
    property cashbackDebit: Extended read FCashbackDebit write FCashbackDebit;
    property confirmedAtAsDateTime: String read FConfirmedAtAsDateTime write FConfirmedAtAsDateTime;
    property startedAtAsDateTime: String read FStartedAtAsDateTime write FStartedAtAsDateTime;
    property transactionID: Extended read FTransactionID write FTransactionID;
    property transactionValue: Extended read FTransactionValue write FTransactionValue;
    property userCPF: String read FUserCPF write FUserCPF;
  end;

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

  TCashTransactionDetails = class
  private
    FCashTransaction: TCashTransactionClass;
    FCommonResponse: TCommonResponseClass;
  public
    property cashTransaction: TCashTransactionClass read FCashTransaction write FCashTransaction;
    property commonResponse: TCommonResponseClass read FCommonResponse write FCommonResponse;
    constructor Create;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TCashTransactionDetails;
  end;
//END - OBJETOS DE RETORNO - BL


//BEGIN - CONTROLLER - BL
  TControllerCashTransactionDetails = class
  private
  public
    class function fCashTransactionDetails(strNumPok: String): TCashTransactionDetails;
  end;
//END - CONTROLLER - BL

implementation

uses
  untRestApi, untGryncashRestApi;

//BEGIN - MÉTODOS OBJETOS DE RETORNO - BL
{TCashTransactionDetails}
constructor TCashTransactionDetails.Create;
begin
  inherited;
  FCommonResponse := TCommonResponseClass.Create();
  FCashTransaction := TCashTransactionClass.Create();
end;

destructor TCashTransactionDetails.Destroy;
begin
  FCommonResponse.free;
  FCashTransaction.free;
  inherited;
end;

class function TCashTransactionDetails.FromJsonString(AJsonString: string): TCashTransactionDetails;
begin
  result := TJson.JsonToObject<TCashTransactionDetails>(AJsonString)
end;
//END - OBJETOS DE RETORNO - BL


//BEGIN - MÉTODOS CONTROLLER - BL
class function TControllerCashTransactionDetails.fCashTransactionDetails(strNumPok: String): TCashTransactionDetails;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('GRYNCASH', TControllerGryncash.fConfigurarGryncash);
  RestRequest    := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Method        := rmGET;
    RestRequest.Resource      := 'externalAPI/1/cashTransactionDetails';
    RestRequest.Accept        := 'application/json';
    RestRequest.AcceptCharset := 'UTF-8';

    RestRequest.Params.AddItem('ExternalToken',
                               fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_TOKGRY']),
                               pkHTTPHEADER);

    RestRequest.Params.AddItem('transactionID', strNumPok, pkGETorPOST);


    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
      Result := TCashTransactionDetails.FromJsonString(JSONRetorno);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;
//END - MÉTODOS CONTROLLER - BL

end.
