unit untGryncashUserCashbackFundsOnStore;

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
  TFundsExclusiveOnStoreClass = class
  private
    FFundsConsideredTransferable: Extended;
    FFundsFromMassCPF: Extended;
    FFundsFromQrCode: Extended;
    FFundsFromTargetedUsers: Extended;
    FFundsFromTransactions: Extended;
    FFundsFromTransfers: Extended;
    FTotalFunds: Extended;
  public
    property fundsConsideredTransferable: Extended read FFundsConsideredTransferable write FFundsConsideredTransferable;
    property fundsFromMassCPF: Extended read FFundsFromMassCPF write FFundsFromMassCPF;
    property fundsFromQrCode: Extended read FFundsFromQrCode write FFundsFromQrCode;
    property fundsFromTargetedUsers: Extended read FFundsFromTargetedUsers write FFundsFromTargetedUsers;
    property fundsFromTransactions: Extended read FFundsFromTransactions write FFundsFromTransactions;
    property fundsFromTransfers: Extended read FFundsFromTransfers write FFundsFromTransfers;
    property totalFunds: Extended read FTotalFunds write FTotalFunds;
  end;

  TCashBackAccountClass = class
  private
    FFunds: Extended;
    FFundsExclusiveOnStore: TFundsExclusiveOnStoreClass;
    FStoreID: Extended;
    FUserCPF: String;
  public
    property funds: Extended read FFunds write FFunds;
    property fundsExclusiveOnStore: TFundsExclusiveOnStoreClass read FFundsExclusiveOnStore write FFundsExclusiveOnStore;
    property storeID: Extended read FStoreID write FStoreID;
    property userCPF: String read FUserCPF write FUserCPF;
    constructor Create;
    destructor Destroy; override;
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

  TUserCashbackFundsOnStore = class
  private
    FCashBackAccount: TCashBackAccountClass;
    FCommonResponse: TCommonResponseClass;
    FUserName: String;
  public
    property cashBackAccount: TCashBackAccountClass read FCashBackAccount write FCashBackAccount;
    property commonResponse: TCommonResponseClass read FCommonResponse write FCommonResponse;
    property userName: String read FUserName write FUserName;
    constructor Create;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TUserCashbackFundsOnStore;
  end;
//END - OBJETOS DE RETORNO - BL


//BEGIN - CONTROLLER - BL
  TControllerUserCashbackFundsOnStore = class
  private
  public
    class function fUserCashbackFundsOnStore(strDocCli: String): TUserCashbackFundsOnStore;
  end;
//END - CONTROLLER - BL

implementation

uses
  untRestApi, untGryncashRestApi;

//BEGIN - MÉTODOS OBJETOS DE RETORNO - BL
{TCashBackAccountClass}
constructor TCashBackAccountClass.Create;
begin
  inherited;
  FFundsExclusiveOnStore := TFundsExclusiveOnStoreClass.Create();
end;

destructor TCashBackAccountClass.Destroy;
begin
  FFundsExclusiveOnStore.free;
  inherited;
end;

{TUserCashbackFundsOnStore}
constructor TUserCashbackFundsOnStore.Create;
begin
  inherited;
  FCommonResponse := TCommonResponseClass.Create();
  FCashBackAccount := TCashBackAccountClass.Create();
end;

destructor TUserCashbackFundsOnStore.Destroy;
begin
  FCommonResponse.free;
  FCashBackAccount.free;
  inherited;
end;

class function TUserCashbackFundsOnStore.FromJsonString(AJsonString: string): TUserCashbackFundsOnStore;
begin
  result := TJson.JsonToObject<TUserCashbackFundsOnStore>(AJsonString)
end;
//END - OBJETOS DE RETORNO - BL


//BEGIN - MÉTODOS CONTROLLER - BL
class function TControllerUserCashbackFundsOnStore.fUserCashbackFundsOnStore(strDocCli: String): TUserCashbackFundsOnStore;
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
    RestRequest.Resource      := 'externalAPI/1/userCashbackFundsOnStore';
    RestRequest.Accept        := 'application/json';
    RestRequest.AcceptCharset := 'UTF-8';

    RestRequest.Params.AddItem('storeID', fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_STORID']), pkGETorPOST);
    RestRequest.Params.AddItem('userCPF', Trim(strDocCli), pkGETorPOST);

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200']) then
    begin
      Result := TUserCashbackFundsOnStore.FromJsonString(JSONRetorno);
      if Result.FCommonResponse.isError then
        if Result.FCommonResponse.statusCode <> -4001 then
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
