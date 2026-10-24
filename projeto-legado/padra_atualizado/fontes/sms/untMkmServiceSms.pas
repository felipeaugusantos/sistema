unit untMkmServiceSms;

interface

uses
  Generics.Collections, Rest.Json, sysUtils, REST.Types,
  System.JSON, strUtils, System.Classes, untModulo, untMinioStorageAPICitel,
  {$IFDEF LINUX}
    {$I '..\..\..\core\services.core.uses.inc'},
  {$ELSE }
  untFuncoesSimples, REST.Client,
  {$ENDIF LINUX}
  Data.DB, MemDS, DBAccess, Uni;

type

{*** Begin Objeto Envio ***}

  TMessagesClass = class
  private
    FMessage: String;
    FMsisdn: String;
  public
    property message: String read FMessage write FMessage;
    property msisdn: String read FMsisdn write FMsisdn;

    function f_Message(AValue: String): TMessagesClass;
    function f_Msisdn(AValue: String): TMessagesClass;

    class function fNew: TMessagesClass;
  end;

  TMailingClass = class
  private
    FCost_centre_id: Extended;
    FIdentifier: String;
  public
    property cost_centre_id: Extended read FCost_centre_id write FCost_centre_id;
    property identifier: String read FIdentifier write FIdentifier;

    function f_Cost_centre_id(AValue: Extended): TMailingClass;
    function f_Identifier(AValue: String): TMailingClass;

    class function fNew: TMailingClass;
  end;

  TMkmServiceSms = class
  private
    FMailing: TMailingClass;
    FMessages: TArray<TMessagesClass>;
  public
    property mailing: TMailingClass read FMailing write FMailing;
    property messages: TArray<TMessagesClass> read FMessages write FMessages;

    function f_Mailing(AValue: TMailingClass): TMkmServiceSms;
    function f_Messages(AValue: TMessagesClass): TMkmServiceSms;

    constructor Create;
    destructor Destroy; override;

    class function fNew: TMkmServiceSms;

    function ToJsonString: string;
  end;

{*** End Objeto Envio ***}


{*** Begin Objeto Retorno ***}

  TRetornoMessagesClass = class
  private
    FReference: String;
    FSuccess: Boolean;
  public
    property reference: String read FReference write FReference;
    property success: Boolean read FSuccess write FSuccess;
  end;

  TRetornoMailingClass = class
  private
    FId: String;
  public
    property id: String read FId write FId;
  end;

  TRetornoMkmServiceSms = class
  private
    FMailing: TRetornoMailingClass;
    FMessages: TArray<TRetornoMessagesClass>;
  public
    property mailing: TRetornoMailingClass read FMailing write FMailing;
    property messages: TArray<TRetornoMessagesClass> read FMessages write FMessages;
    constructor Create;
    destructor Destroy; override;
    class function FromJsonString(AJsonString: string): TRetornoMkmServiceSms;
  end;

{*** End Objeto Retorno ***}

  TControllerMkmServiceSms = class
  private
    class function fSend(MkmServiceSms: TMkmServiceSms; conexao: TUniConnection = nil): TRetornoMkmServiceSms;
  public
    class function fSendSms(strAutInc, strCgcEmp, strMsisdn, strMessage, strIdentifier: String; strCodOpe: String = ''; conexao: TUniConnection = nil): Boolean;
  end;

implementation

uses untRestApi, untMkmServiceRestApi, untConstantes;

{ TMessagesClass }

function TMessagesClass.f_Message(AValue: String): TMessagesClass;
begin
  FMessage := AValue;
  Result := Self;
end;

function TMessagesClass.f_Msisdn(AValue: String): TMessagesClass;
begin
  FMsisdn := AValue;
  Result := Self;
end;

class function TMessagesClass.fNew: TMessagesClass;
begin
  Result := TMessagesClass.Create;
end;


{ TMailingClass }

function TMailingClass.f_Cost_centre_id(AValue: Extended): TMailingClass;
begin
  FCost_centre_id := AValue;
  Result := Self;
end;

function TMailingClass.f_Identifier(AValue: String): TMailingClass;
begin
  FIdentifier := AValue;
  Result := Self;
end;

class function TMailingClass.fNew: TMailingClass;
begin
  Result := TMailingClass.Create;
end;


{TMkmServiceSms}

constructor TMkmServiceSms.Create;
begin
  inherited;
  FMailing := TMailingClass.Create();
end;

destructor TMkmServiceSms.Destroy;
var
  LmessagesItem: TMessagesClass;
begin

 for LmessagesItem in FMessages do
   LmessagesItem.free;

  FMailing.free;
  inherited;
end;

function TMkmServiceSms.f_Mailing(AValue: TMailingClass): TMkmServiceSms;
begin
  FMailing := AValue;
  Result := Self;
end;

function TMkmServiceSms.f_Messages(AValue: TMessagesClass): TMkmServiceSms;
begin
  SetLength(FMessages, Length(FMessages)+1);
  FMessages[Length(FMessages)-1] := AValue;
  Result := Self;
end;

class function TMkmServiceSms.fNew: TMkmServiceSms;
begin
  Result := TMkmServiceSms.Create;
end;

function TMkmServiceSms.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(Self);
end;


{TRetornoMkmServiceSms}

constructor TRetornoMkmServiceSms.Create;
begin
  inherited;
  FMailing := TRetornoMailingClass.Create();
end;

destructor TRetornoMkmServiceSms.Destroy;
var
  LmessagesItem: TRetornoMessagesClass;
begin

 for LmessagesItem in FMessages do
   LmessagesItem.free;

  FMailing.free;
  inherited;
end;

class function TRetornoMkmServiceSms.FromJsonString(AJsonString: string): TRetornoMkmServiceSms;
begin
  Result := TJson.JsonToObject<TRetornoMkmServiceSms>(AJsonString)
end;


{ TControllerMkmServiceSms }

class function TControllerMkmServiceSms.fSendSms(strAutInc, strCgcEmp, strMsisdn,
  strMessage, strIdentifier: String; strCodOpe: String = ''; conexao: TUniConnection = nil): Boolean;
const
  SQL_INSERT_SMSENV = STR_SQL_NAO_REPLICAR+
                       ' INSERT INTO SMSENV ( ' +
                       ' AUTOINCREM, ' +
                       ' SMS_REMETE, ' +
                       ' SMS_CELULA, ' +
                       ' SMS_MENSAG, ' +
                       ' SMS_SCHEDU, ' +
                       ' SMS_IDENTI, ' +
                       ' SMS_CBKOPT, ' +
                       ' SMS_AGGTID, ' +
                       ' SMS_STACOD, ' +
                       ' SMS_STADES, ' +
                       ' SMS_DETCOD, ' +
                       ' SMS_DETDES, ' +
                       ' SMS_CODEMP, ' +
                       ' SMS_CODOPE, ' +
                       ' SMS_NPARTS, ' +
                       ' SMS_PARTID, ' +
                       ' SMS_DTAENV) VALUES ( ' +
                       ' :AUTINC, ' +
                       ' :REMETE, ' +
                       ' :CELULA, ' +
                       ' :MENSAG, ' +
                       ' :SCHEDU, ' +
                       ' :IDENTI, ' +
                       ' :CBKOPT, ' +
                       ' :AGGTID, ' +
                       ' :STACOD, ' +
                       ' :STADES, ' +
                       ' :DETCOD, ' +
                       ' :DETDES, ' +
                       ' :CODEMP, ' +
                       ' :CODOPE, ' +
                       ' :NPARTS, ' +
                       ' :PARTID, ' +
                       ' :DTAENV) ' ;
var
  RetornoMkmServiceSms: TRetornoMkmServiceSms;
  qrySmsEnv: TUniQuery;
begin
  Result := False;
  try
    try
      if Length(strMsisdn) < 13 then
        strMsisdn := '55' + strMsisdn;

      RetornoMkmServiceSms := fSend(TMkmServiceSms.fNew()
                                     .f_Mailing(TMailingClass.fNew()
                                                 .f_Identifier(strIdentifier)
                                                 .f_Cost_centre_id(fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_CCUMKM'], True, ''{$IFNDEF LINUX}, conexao{$ENDIF})))
                                     .f_Messages(TMessagesClass.fNew()
                                                 .f_Msisdn(fTiraEspacos(strMsisdn)).
                                                 f_Message(strMessage))
                                    ,conexao);

      if Assigned(RetornoMkmServiceSms) then
      begin
        Result := RetornoMkmServiceSms.messages[0].success;

        qrySmsEnv := fCriaQuery(Nil, conexao);
        try
          qrySmsEnv.Close;
          qrySmsEnv.SQL.Text := SQL_INSERT_SMSENV;
          qrySmsEnv.ParamByName('AUTINC').AsString   := strAutInc;
          qrySmsEnv.ParamByName('REMETE').AsString   := EmptyStr;
          qrySmsEnv.ParamByName('CELULA').AsString   := strMsisdn;
          qrySmsEnv.ParamByName('MENSAG').AsString   := strMessage;
          qrySmsEnv.ParamByName('SCHEDU').AsString   := EmptyStr;
          qrySmsEnv.ParamByName('IDENTI').AsString   := strAutInc + Copy(strCgcEmp, 1, 8);
          qrySmsEnv.ParamByName('CBKOPT').AsString   := EmptyStr;
          qrySmsEnv.ParamByName('AGGTID').AsString   := Copy(strCgcEmp, 1, 8);
          qrySmsEnv.ParamByName('STACOD').AsString   := EmptyStr;
          qrySmsEnv.ParamByName('STADES').AsString   := '"success":true';
          qrySmsEnv.ParamByName('DETCOD').AsString   := '200';
          qrySmsEnv.ParamByName('DETDES').AsString   := RetornoMkmServiceSms.messages[0].reference;
          qrySmsEnv.ParamByName('NPARTS').AsInteger  := 1;
          qrySmsEnv.ParamByName('PARTID').AsString   := RetornoMkmServiceSms.mailing.id;
          qrySmsEnv.ParamByName('CODEMP').AsString   := VS_strCodEmp;
          qrySmsEnv.ParamByName('CODOPE').AsString   := IIF(fEmptyStr(strCodOpe), strLoginUsuarioLogado, strCodOpe);
          qrySmsEnv.ParamByName('DTAENV').AsDateTime := fNow();
          qrySmsEnv.ExecSQL();
        finally
          FreeAndNil(qrySmsEnv);
        end;
      end;
    except
      Result := False;
    end
  finally
    if Assigned(RetornoMkmServiceSms) then
      FreeAndNil(RetornoMkmServiceSms);
  end;
end;

class function TControllerMkmServiceSms.fSend(MkmServiceSms: TMkmServiceSms; conexao: TUniConnection = nil): TRetornoMkmServiceSms;
var
  ControllerRest: TControllerRest;
  RestRequest: TRestRequest;

  JSONRetorno: String;
begin
  Result := nil;

  ControllerRest := TControllerRest.Create('MKOM SMS', TControllerMkmService.fConfigurarMkmService);
  RestRequest := TRestRequest.Create(ControllerRest.RestClient);
  try
    RestRequest.Resource := 'sms/api/transmission/v1';
    RestRequest.Method := rmPOST;    

    RESTRequest.Params.AddItem('',
                                 MkmServiceSms.ToJsonString,
                                 TREstRequestParameterKind.pkREQUESTBODY,
                                 [],
                                 TRESTContentType.ctAPPLICATION_JSON
                               );

    if ControllerRest.fExecute(RestRequest, JSONRetorno, ['200'], '') then
      Result := TRetornoMkmServiceSms.FromJsonString(JSONRetorno);

  finally
    FreeAndNil(RestRequest);
    FreeAndNil(ControllerRest);
    FreeAndNil(MkmServiceSms);
  end;

end;

end.
