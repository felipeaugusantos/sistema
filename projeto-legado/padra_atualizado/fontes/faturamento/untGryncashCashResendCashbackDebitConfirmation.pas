unit untGryncashCashResendCashbackDebitConfirmation;

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
  TResendCashbackDebitConfirmation = class
  private
    FDescription: String;
    FIsError: Boolean;
    FStatusCode: Extended;
  public
    property description: String read FDescription write FDescription;
    property isError: Boolean read FIsError write FIsError;
    property statusCode: Extended read FStatusCode write FStatusCode;
    class function FromJsonString(AJsonString: string): TResendCashbackDebitConfirmation;
  end;
//END - OBJETOS DE RETORNO - BL


//BEGIN - CONTROLLER - BL
  TControllerResendCashbackDebitConfirmation = class
  private
  public
    class function fResendCashbackDebitConfirmation(strNumPok: String): TResendCashbackDebitConfirmation;
  end;
//END - CONTROLLER - BL

implementation

uses
  untRestApi, untGryncashRestApi;

//BEGIN - MÉTODOS OBJETOS DE RETORNO - BL
class function TResendCashbackDebitConfirmation.FromJsonString(AJsonString: string): TResendCashbackDebitConfirmation;
begin
  result := TJson.JsonToObject<TResendCashbackDebitConfirmation>(AJsonString)
end;
//END - MÉTODOS OBJETOS DE RETORNO - BL


//BEGIN - MÉTODOS CONTROLLER - BL
class function TControllerResendCashbackDebitConfirmation.fResendCashbackDebitConfirmation(strNumPok: String): TResendCashbackDebitConfirmation;
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
    RestRequest.Resource      := 'externalAPI/1/resendCashbackDebitConfirmation';
    RestRequest.Accept        := 'application/json';
    RestRequest.AcceptCharset := 'UTF-8';

    RestRequest.Params.AddItem('ExternalToken',
                               fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_TOKGRY']),
                               pkHTTPHEADER);

    RestRequest.Params.AddItem('transactionID', strNumPok, pkGETorPOST);

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
      Result := TResendCashbackDebitConfirmation.FromJsonString(JSONRetorno);

  finally
    RestRequest.Free;
    ControllerRest.Free;
  end;
end;
//END - MÉTODOS CONTROLLER - BL

end.
