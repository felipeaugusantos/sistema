unit untTEnvioSMS;

interface

uses
  System.SysUtils, System.Classes, System.JSON, Winapi.ActiveX, idHTTP, IdSSLOpenSSL, untInterfaces,
  StrUtils, Uni, UniClientDataSet, System.IOUtils, Winapi.Windows;

type
  TRetornoSMS = class
  private
    FStatusCode: String;
    FStatusDescription: String;
    FDetailCode: String;
    FDetailDescription: String;
    FParts: Integer;
    FPartsIds: String;
  public
    property strStatusCode: String        Read FStatusCode        Write FStatusCode;
    property strStatusDescription: String Read FStatusDescription Write FStatusDescription;
    property strDetailCode: String        Read FDetailCode        Write FDetailCode;
    property strDetailDescription: String Read FDetailDescription Write FDetailDescription;
    property intParts: Integer            Read FParts             Write FParts;
    property strPartsIds: String          Read FPartsIds          Write FPartsIds;

    constructor Create;
    destructor Destroy; Override;
  end;

  TMensagemSMS = class
  private
    FFrom: String;
    FTo: String;
    FSchedule: String;
    FMsg: String;
    FCallbackOption: String;
    FId: String;
    FAggregatedId: String;

    FRetorno: TRetornoSMS;
  public
    procedure pSetId(Value: String);

    property strFrom: String           Read FFrom;
    property strTo: String             Read FTo             Write FTo;
    property strSchedule: String       Read FSchedule       Write FSchedule;
    property strMsg: String            Read FMsg            Write FMsg;
    property strCallbackOption: String Read FCallbackOption;
    property strId: String             Read FId             Write pSetId;
    property strAggregatedId: String   Read FAggregatedId;
    property objRetorno: TRetornoSMS   Read FRetorno        Write FRetorno;

    constructor Create(strCgcEmp: String);
    destructor Destroy; Override;
  end;

  TEnvioSMS = class
  strict private
    function fGetEntryValue(objJSON: TJSONObject; strElement: String): String;
  private
    FUrlSms: String;
    FUsrSms: String;
    FSenSms: String;
    FCodEmp: String;
    FAutInc: String;

    FHTTP  : TIdHTTP;
    FSSLSocket: TIdSSLIOHandlerSocketOpenSSL;

    FMensagem: TMensagemSMS;

    function  fParseResponse(const strJson: String): TRetornoSMS;
    function  fCriarJSONRequisicao(objMensagem: TMensagemSMS): String;
    function  fGravarSMS(ACodOpe: String = ''): Boolean;
    function  fGetSQLInsert: String;
    function  fProcessarRetornoErro: TRetornoSMS;
  public
    property objMensagem: TMensagemSMS Read FMensagem Write FMensagem;

    constructor Create(strAutInc, strCodEmp, strCgcEmp: String);
    destructor Destroy; Override;

    function fEnviarSMS(ACodOpe: String = ''): TRetornoSMS;
  end;

implementation

{ TEnvioSMS }

uses untFuncoesSimples, untModulo, untConstantes, untThreadUtils;

constructor TEnvioSMS.Create(strAutInc, strCodEmp, strCgcEmp: String);
begin
  inherited Create;

  FCodEmp   := strCodEmp;
  FMensagem := TMensagemSMS.Create(strCgcEmp);
  FMensagem.pSetId(strAutInc);

  FUrlSms := VS_strUrlSms;
  FUsrSms := VS_strUsrSms;
  FSenSms := VS_strSenSms;
  FAutInc := strAutInc;

  FHTTP   := TidHTTP.Create(nil);

  FSSLSocket := TIdSSLIOHandlerSocketOpenSSL.Create(FHTTP);
  FSSLSocket.Destination := '';
  FSSLSocket.Host := '';
  FSSLSocket.Port := 0;
  FSSLSocket.DefaultPort := 0;
  FSSLSocket.SSLOptions.SSLversions := [sslvTLSv1_2];
  FSSLSocket.SSLOptions.Mode := sslmUnassigned;
  FSSLSocket.SSLOptions.VerifyMode := [];
  FSSLSocket.SSLOptions.VerifyDepth := 0;

  FHTTP.IOHandler := FSSLSocket;
end;

destructor TEnvioSMS.Destroy;
begin
  FreeAndNil(FSSLSocket);
  FreeAndNil(FHTTP);
  inherited;
end;

function TEnvioSMS.fCriarJSONRequisicao(objMensagem: TMensagemSMS): String;
begin
  If (Assigned(objMensagem)) Then
  Begin
    objMensagem.strTo := AnsiReplaceStr(objMensagem.strTo, ' ', '');

    If (Copy(objMensagem.strTo, 1, 2) <> '55') Then
      objMensagem.strTo := '55' + objMensagem.strTo;

    If (Length(objMensagem.strTo) <= 11) Then
    Begin
      raise ErroConsultaCadastro.Create('O número de celular é inválido para envio do SMS!' + #13#10 +
                                        'Celular: '  + objMensagem.strTo + #13#10 +
                                        'Mensagem: ' + objMensagem.strMsg);
    End
    Else If (Length(objMensagem.strAggregatedId) <> 8) Then
    Begin
      raise ErroConsultaCadastro.Create('O CNPJ da empresa é inválido para envio do SMS!' + #13#10 +
                                        'CNPJ: '    + objMensagem.strAggregatedId + #13#10 +
                                        'Empresa: ' + FCodEmp);
    End
    Else
    Begin
      Result := '{"sendSmsRequest": ' +
                    '{"from": "'           + objMensagem.strFrom           + '",' +
                    ' "to": "'             + objMensagem.strTo             + '",' +
                    ' "schedule": "'       + objMensagem.strSchedule       + '",' +
                    ' "msg": "'            + objMensagem.strMsg            + '",' +
                    ' "callbackOption": "' + objMensagem.strCallbackOption + '",' +
                    ' "id": "'             + objMensagem.strId             + '",' +
                    ' "aggregateId": "'    + objMensagem.strAggregatedId   + '",' +
                    ' "flashSms": false }' +
                '}';
      Result := AnsiReplaceStr(Result, #$D#$A, ' ');
    End;
  End
  Else
    Result := '';
end;

function TEnvioSMS.fEnviarSMS(ACodOpe: String = ''): TRetornoSMS;
  Var
    strEnvio, strRetorno: TStringStream;
begin
  Result := nil;

  If (fEmptyStr(FUrlSms)) Or (fEmptyStr(FUsrSms)) Or (fEmptyStr(FSenSms)) Then
    Exit;

  strEnvio   := TStringStream.Create(fCriarJSONRequisicao(FMensagem), TEncoding.UTF8);
  strRetorno := TStringStream.Create('');

  Try
    FHTTP.Request.Clear();
    FHTTP.Request.BasicAuthentication := True;
    FHTTP.Request.Username := FUsrSms;
    FHTTP.Request.Password := FSenSms;

    FHTTP.Request.ContentType := 'application/json';
    FHTTP.Request.Accept      := 'application/json';
    FHTTP.Request.Charset     := 'UTF-8';

    FHTTP.Response.ContentType := 'application/json';
    FHTTP.Response.Charset     := 'UTF-8';

    FHTTP.HTTPOptions := FHTTP.HTTPOptions + [hoNoProtocolErrorException];
    FHTTP.Post(FUrlSms, strEnvio, strRetorno);

    If FHTTP.ResponseCode = 200 Then
    Begin
      strRetorno.Seek(0, soFromBeginning);
      FMensagem.FRetorno := fParseResponse(strRetorno.DataString);
    End
    Else
    Begin
      FMensagem.FRetorno := fProcessarRetornoErro();
    End;

    fGravarSMS(ACodOpe);

    If FHTTP.ResponseCode = 401 Then
    Begin
      raise ErroConsultaCadastro.Create('Autorização negada para envio do SMS. ' +
                          'Verifique a sua licença de uso (Configurações [CFG_USRSMS] e [CFG_SENSMS]) e tente novamente.');
    End
    Else If FHTTP.ResponseCode <> 200 Then
    Begin
      raise ErroConsultaCadastro.Create('Ocorreu um erro imprevisto no envio do SMS!' + #13#10 +
                                        'Código do erro: ' + IntToStr(FHTTP.ResponseCode) + #13#10 +
                                        'Descrição do erro: ' + FHTTP.ResponseText);
    End;
  Finally
    If Assigned(strRetorno) Then
      FreeAndNil(strRetorno);
    CoFreeUnusedLibrariesEx(0, 0);
  End;
end;

function TEnvioSMS.fGetSQLInsert: String;
begin
  Result := ' INSERT INTO SMSENV ( ' +
                'AUTOINCREM, ' +
                'SMS_REMETE, ' +
                'SMS_CELULA, ' +
                'SMS_MENSAG, ' +
                'SMS_SCHEDU, ' +
                'SMS_IDENTI, ' +
                'SMS_CBKOPT, ' +
                'SMS_AGGTID, ' +
                'SMS_STACOD, ' +
                'SMS_STADES, ' +
                'SMS_DETCOD, ' +
                'SMS_DETDES, ' +
                'SMS_CODEMP, ' +
                'SMS_CODOPE, ' +
                'SMS_NPARTS, ' +
                'SMS_PARTID, ' +
                'SMS_DTAENV) VALUES ( ' +
                ':AUTINC, ' +
                ':REMETE, ' +
                ':CELULA, ' +
                ':MENSAG, ' +
                ':SCHEDU, ' +
                ':IDENTI, ' +
                ':CBKOPT, ' +
                ':AGGTID, ' +
                ':STACOD, ' +
                ':STADES, ' +
                ':DETCOD, ' +
                ':DETDES, ' +
                ':CODEMP, ' +
                ':CODOPE, ' +
                ':NPARTS, ' +
                ':PARTID, ' +
                ':DTAENV) ' ;
end;

function TEnvioSMS.fGravarSMS(ACodOpe: String = ''): Boolean;
  Var
    qryTemp: TUniQuery;
begin
  Result := False;

  Try
    qryTemp := fCriaQuery(Nil);

    Try
      qryTemp.Close();
      qryTemp.SQL.Text := fGetSQLInsert();
      qryTemp.ParamByName('AUTINC').AsString   := FAutInc;
      qryTemp.ParamByName('REMETE').AsString   := FMensagem.strFrom;
      qryTemp.ParamByName('CELULA').AsString   := FMensagem.strTo;
      qryTemp.ParamByName('MENSAG').AsString   := FMensagem.strMsg;
      qryTemp.ParamByName('SCHEDU').AsString   := FMensagem.strSchedule;
      qryTemp.ParamByName('IDENTI').AsString   := FMensagem.strId;
      qryTemp.ParamByName('CBKOPT').AsString   := FMensagem.strCallbackOption;
      qryTemp.ParamByName('AGGTID').AsString   := FMensagem.strAggregatedId;
      qryTemp.ParamByName('STACOD').AsString   := FMensagem.objRetorno.strStatusCode;
      qryTemp.ParamByName('STADES').AsString   := FMensagem.objRetorno.strStatusDescription;
      qryTemp.ParamByName('DETCOD').AsString   := FMensagem.objRetorno.strDetailCode;
      qryTemp.ParamByName('DETDES').AsString   := FMensagem.objRetorno.strDetailDescription;
      qryTemp.ParamByName('NPARTS').AsInteger  := FMensagem.objRetorno.intParts;
      qryTemp.ParamByName('PARTID').AsString   := FMensagem.objRetorno.strPartsIds;
      qryTemp.ParamByName('CODEMP').AsString   := FCodEmp;
      qryTemp.ParamByName('CODOPE').AsString   := IIF(fEmptyStr(ACodOpe), strLoginUsuarioLogado, ACodOpe);
      qryTemp.ParamByName('DTAENV').AsDateTime := fNow();
      qryTemp.ExecSQL();
    Except
      On E: Exception Do Begin
        pMensagensErro(E.Message, '[TEnvioSMS.fGravarSMS]');
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TEnvioSMS.fGetEntryValue(objJSON: TJSONObject; strElement: String): String;
var
  vJSONPair: TJSONPair;
  vJSONScenarioEntry: TJSONValue;
  vJSONScenarioValue: TJSONString;
begin
  vJSONPair := objJSON.Get(strElement);
  vJSONScenarioEntry := vJSONPair.JsonValue;
  vJSONScenarioValue := vJSONScenarioEntry as TJSONString;
  Result := vJSONScenarioValue.Value;
end;

function TEnvioSMS.fParseResponse(const strJson: String): TRetornoSMS;
  Var
    vObjPrinc,
    sendSmsResponse: TJSONObject;
    parts: TJSONArray;
    vJSONValue: TJSONValue;
begin
  Result  := nil;

  vObjPrinc := TJSONObject.ParseJSONValue( strJson ) as TJSONObject;
  Try
    Try
      if not Assigned(vObjPrinc) then
        Exit(fProcessarRetornoErro);
      
      sendSmsResponse := TJSONObject(vObjPrinc.GetValue('sendSmsResponse'));

      If not Assigned(sendSmsResponse) Then
        Exit(fProcessarRetornoErro);

      Result := TRetornoSMS.Create();
      Result.strStatusCode        := fGetEntryValue(sendSmsResponse, 'statusCode');
      Result.strStatusDescription := fGetEntryValue(sendSmsResponse, 'statusDescription');
      Result.strDetailCode        := fGetEntryValue(sendSmsResponse, 'detailCode');
      Result.strDetailDescription := fGetEntryValue(sendSmsResponse, 'detailDescription');

      parts := TJSONArray(sendSmsResponse.GetValue('parts'));

      if parts = nil then
        Exit;

      Result.intParts    := parts.Count;
      Result.strPartsIds := '';

      for vJSONValue in parts do
        Result.strPartsIds := Result.strPartsIds + fGetEntryValue(vJSONValue as TJSONObject, 'partId') + '|';

      Result.strPartsIds := Copy(Result.strPartsIds, 1, Length(Result.strPartsIds) - 1);

    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[TEnvioSMS.fParseResponse]');
    End;
  Finally
    if Assigned(vObjPrinc) then
      vObjPrinc.Free;
  End;
end;

function TEnvioSMS.fProcessarRetornoErro: TRetornoSMS;
begin
  Result := TRetornoSMS.Create();
  Result.strDetailCode        := IntToStr(FHTTP.ResponseCode);
  Result.strDetailDescription := FHTTP.ResponseText;
end;

{ TMensagemSMS }

constructor TMensagemSMS.Create(strCgcEmp: String);
begin
  FFrom := VS_strRemSms;
  FTo := '';
  FSchedule := '';
  FMsg := '';
  FCallbackOption := 'FINAL';
  FId := '';
  FAggregatedId := Copy(strCgcEmp, 1, 8);

  FRetorno := TRetornoSMS.Create();;
end;

destructor TMensagemSMS.Destroy;
begin
  FreeAndNil(FRetorno);

  inherited;
end;

procedure TMensagemSMS.pSetId(Value: String);
begin
  FId := Value + FAggregatedId;
end;

{ TRetornoSMS }

constructor TRetornoSMS.Create();
begin
  FStatusCode := '';
  FStatusDescription := '';
  FDetailCode := '';
  FDetailDescription := '';
  FParts := 0;
  FPartsIds := '';
end;

destructor TRetornoSMS.Destroy;
begin
  inherited;
end;

end.
