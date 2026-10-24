unit untThreadEnviaSMS;

interface

uses
  Classes, Uni, SysUtils, Dialogs, untTEnvioSMS, untTypesSistema, MemData,
  Vcl.Graphics, Winapi.Windows, untThreadUtils, StrUtils, untQualiZapEnqueueMessageToSend, untQualiZapUploadFile,
  untQualizapGenerateDownloadUrl;

type
  TThreadEnviaSMS = class(TSafeThread)
  private
    FTo: String;
    FSchedule: String;
    FMsg: String;
    FAutIncSms: String;
    FCgcEmp: String;
    FEnviado: Boolean;
    FWhatsapp: Boolean;
    FIDFila: String;
    FApiKey: String;
    FArquivos: TArray<TRecArquivosGatilhos>;
    FQrCodePix: String;
    FNomGat: String;
    FUntDis: String;
    FAutIncNotfic: String;
    FUtilizaIntegracaoMKON: Boolean;
    FVarsData: String;
    FTemplateID: Integer;

    function fGetTo: String;
    function fGetSchedule: String;
    function fGetMsg: String;
    function fGetAutIncSms: String;
    function fGetCgcEmp: String;
    function fGetIDFila: String;
    function fGetApiKey: String;
    function fGetQrCodePix: String;
    function fGetNomeGatilho: String;
    function fGetUnitDisparo: String;
    function fGetAutIncNotFic : String;
    function fGetConverteArquivoParaBase64(intContador: Integer): Boolean;
    function fGetMimeType(intContador: Integer): String;
    function fGetUtilizaIntegracaoMKON: Boolean;
    function fGetVariaveisApiOficial: TArray<String>;
    function fGetTemplateID: Integer;
    function fApiOficial(const AIdFila: String): Boolean;

    procedure pEnviaSMS;
    procedure pEnviaWPP;
    procedure pEnviaWPPNaoOficial(const extIdFila: Extended; const strApiKey: String);
    procedure pEnviaWPPOficial(const extIdFila: Extended; const strApiKey: String);
    function fGetArquivoBase64(intContador: Integer): String;
    function fGetExtensaoArquivo(intContador: Integer): String;
    function fGetFileName(intContador: Integer): String;
    function fGetWidth(const AstrBase64: String): Extended;
    function fGetHeight(const AstrBase64: String): Extended;

    procedure pMarcaNotFicPendenteDeEnvio;

    function fUploadFile(const extIdFila: Extended; const strApiKey: String; const intIndexFile: Integer): TReturnUploadFile;
    function fRetUrlArquivo(const AextIdFila: Extended; const AstrApiKey: String; const AfileId: Extended): String;
    function fCriarArquivoPdfUnico: TArray<TRecArquivosGatilhos>;
  protected
    procedure Execute; override;
  public
    procedure ExecuteModal;
    procedure pSetTo(Value: String);
    procedure pSetSchedule(Value: String);
    procedure pSetMsg(Value: String);
    procedure pSetAutIncSms(Value: String);
    procedure pSetCgcEmp(Value: String);
    procedure pSetWhatsapp(Value: Boolean);
    procedure pSetIDFila(Value: String);
    procedure pSetApiKey(Value: String);
    procedure pSetArquivos(Value: TArray<TRecArquivosGatilhos>);
    procedure pSetQrCodePix(Value: String);
    procedure pSetNomeGatilho(Value: String);
    procedure pSetUnitDisparo(Value: String);
    procedure pSetAutIncNotFic(Value: String);
    procedure pSetUtilizaIntegracaoMKON(Value: Boolean);
    procedure pSetVariaveisApiOficial(Value: String);
    procedure pSetTemplateID(Value: Integer);

    property Enviado: Boolean read FEnviado;

    constructor create;
    destructor Destroy; Override;
  end;

implementation

{ TThreadEnviaSMS }

uses untFuncoesSimples, untModulo, untConstantes, untImagemBase64,
     untMkmServiceSms, untRestApi, untGeraPdfLinksWhatsapp;

constructor TThreadEnviaSMS.create;
begin
  inherited create(True);
  FEnviado := False;
end;

procedure TThreadEnviaSMS.ExecuteModal;
begin
  if FWhatsapp then
    pEnviaWPP
  else
    pEnviaSMS;
end;

destructor TThreadEnviaSMS.Destroy;
begin
  inherited;
end;

procedure TThreadEnviaSMS.Execute;
begin
  if FWhatsapp then
    pEnviaWPP
  else
    pEnviaSMS;
end;

function TThreadEnviaSMS.fApiOficial(const AIdFila: String): Boolean;
begin
  Result := (fCampoTabela('FIL_APIOFI', 'CADFIL', ['FIL_IDFILA'], [AIdFila]) = 'S');
end;

function TThreadEnviaSMS.fGetApiKey: String;
begin
  Result := FApiKey;
end;

function TThreadEnviaSMS.fGetAutIncNotFic: String;
begin
  Result := FAutIncNotfic;
end;

function TThreadEnviaSMS.fGetAutIncSms: String;
begin
  Result := FAutIncSms;
end;

function TThreadEnviaSMS.fGetCgcEmp: String;
begin
  Result := FCgcEmp;
end;

function TThreadEnviaSMS.fGetConverteArquivoParaBase64(intContador: Integer): Boolean;
begin
  Result := not fEmptyStr(ExtractFileExt(FArquivos[intContador].Arquivo));
end;

function TThreadEnviaSMS.fGetExtensaoArquivo(intContador: Integer): String;
begin
  case FArquivos[intContador].TipoArquivo of
    tpaPDF   : Result := '.pdf';
    tpaImagem: Result := '.jpeg';
    tpaExcel : Result := '.xls';
    tpaXml   : Result := '.xml';
    tpaDoc   : Result := '.doc';
    else
      Result := '.pdf';
  end;
end;

function TThreadEnviaSMS.fGetUnitDisparo: String;
begin
  Result := FUntDis;
end;

function TThreadEnviaSMS.fGetUtilizaIntegracaoMKON: Boolean;
begin
  Result := FUtilizaIntegracaoMKON;
end;

function TThreadEnviaSMS.fGetVariaveisApiOficial: TArray<String>;
var
  intContador: Integer;
begin
  Result := FVarsData.Split(['_']);

  for intContador := 0 to High(Result) do
  begin
    if fEmptyStr(Result[intContador]) then
      Result[intContador] := 'N/A';
  end;
end;

function TThreadEnviaSMS.fGetIDFila: String;
begin
  Result := FIDFila;
end;

function TThreadEnviaSMS.fGetMimeType(intContador: Integer): String;
begin
  case FArquivos[intContador].TipoArquivo of
    tpaPDF   : Result := 'application/pdf';
    tpaImagem: Result := 'image/jpeg';
    tpaExcel : Result := 'application/msexcel';
    tpaXml   : Result := 'application/xml';
    tpaDoc   : Result := 'application/msword';
    else
      Result := 'application/pdf';
  end;
end;

function TThreadEnviaSMS.fGetMsg: String;
begin
  Result := FMsg;
end;

function TThreadEnviaSMS.fGetNomeGatilho: String;
begin
  Result := FNomGat;
end;

function TThreadEnviaSMS.fGetQrCodePix: String;
begin
  Result := FQrCodePix;
end;

function TThreadEnviaSMS.fGetSchedule: String;
begin
  Result := FSchedule;
end;

function TThreadEnviaSMS.fGetTemplateID: Integer;
begin
  Result := FTemplateID;
end;

function TThreadEnviaSMS.fGetTo: String;
begin
  Result := FTo;
end;

procedure TThreadEnviaSMS.pEnviaSMS;
  Var
    objSms: TEnvioSMS;
begin
  if fGetUtilizaIntegracaoMKON then
    FEnviado := TControllerMkmServiceSms.fSendSms(fGetAutIncSms, fGetCgcEmp(), fGetTo, fGetMsg, fGetNomeGatilho)
  else
  begin
    Try
      objSms := TEnvioSMS.Create(fGetAutIncSms(), VS_strCodEmp, fGetCgcEmp());
      objSms.objMensagem.strTo       := fGetTo();
      objSms.objMensagem.strSchedule := fGetSchedule();
      objSms.objMensagem.strMsg      := fGetMsg();
      objSms.fEnviarSMS();

      FEnviado := objSms.objMensagem.objRetorno.strStatusDescription.ToUpper = 'OK';
    Finally
      FreeAndNil(objSms);
    End;
  end;

  if (not FEnviado) and (not fEmptyStr(fGetAutIncNotFic)) then
    pMarcaNotFicPendenteDeEnvio;
end;

function TThreadEnviaSMS.fUploadFile(const extIdFila: Extended; const strApiKey: String; const intIndexFile: Integer): TReturnUploadFile;
var
  UploadFile: TUploadFile;
  LstrImagemOtimizadaBase64: String;
begin
  UploadFile := TUploadFile.Create;
  try
    UploadFile.queueId := extIdFila;
    UploadFile.apiKey := strApiKey;

    UploadFile.mimeType := fGetMimeType(intIndexFile);
    UploadFile.fileName := fGetFileName(intIndexFile);
    UploadFile.data := fGetArquivoBase64(intIndexFile);
    UploadFile.title := FArquivos[intIndexFile].Titulo;

    if (Pos('image/', UploadFile.mimeType) > 0) then
    begin
      if Copy(UploadFile.data, 1, 4) <> '/9j/' then
        UploadFile.data := ConverterBase64PngParaJpg(UploadFile.data);

      LstrImagemOtimizadaBase64 := UploadFile.data;
      if fOtimizaImagem(LstrImagemOtimizadaBase64) then
        UploadFile.thumbnail := LstrImagemOtimizadaBase64;

      UploadFile.width := fGetWidth(UploadFile.data);
      UploadFile.height := fGetHeight(UploadFile.data);
    end;

    Result := TControllerUploadFile.fUploadFile(UploadFile, fGetAutIncNotFic);
  finally
    FreeAndNil(UploadFile);
  end;
end;

function TThreadEnviaSMS.fRetUrlArquivo(const AextIdFila: Extended; const AstrApiKey: String; const AfileId: Extended): String;
begin
  Result := TGenerateDownloadUrl.fNew.fGenerateUrl(AstrApiKey, AextIdFila, AfileId);
  Result := Result.Replace('download=true', 'download=false');
end;

function TThreadEnviaSMS.fCriarArquivoPdfUnico: TArray<TRecArquivosGatilhos>;
begin
  SetLength(Result, 1);
  Result[0] := TRecArquivosGatilhos.Create('ARQUIVOS', fGerarPdfLinksWhatsappBase64(FArquivos), EmptyStr);
end;

procedure TThreadEnviaSMS.pEnviaWPP;
var
  extIdFila: Extended;
  strApiKey: String;
begin
  extIdFila := StrToFloatDef(fGetIDFila, 0);
  strApiKey := fGetApiKey;

  if fEmptyStr(fGetApiKey) then
    fRetFilaEApiKeyPrincipalWhatsapp(extIdFila, strApiKey);

  if fApiOficial(extIdFila.ToString) then
    pEnviaWPPOficial(extIdFila, strApiKey)
  else
    pEnviaWPPNaoOficial(extIdFila, strApiKey);
end;

procedure TThreadEnviaSMS.pEnviaWPPNaoOficial(const extIdFila: Extended; const strApiKey: String);
var
  EnqueueMessageToSend: TEnqueueMessageToSend;
  ReturnUploadFile: TReturnUploadFile;
  intContador: Integer;
  blnEhPrimeiroEnvio: Boolean;
begin
  FEnviado := False;
  blnEhPrimeiroEnvio := True;
  ReturnUploadFile := nil;

  EnqueueMessageToSend := TEnqueueMessageToSend.Create(False, False, False, False);
  try
    try
      EnqueueMessageToSend.queueId := extIdFila;
      EnqueueMessageToSend.apiKey := strApiKey;
      EnqueueMessageToSend.number := '55'+fTiraCaracEspeciais(fGetTo, True, True, True, True, True, True);
      EnqueueMessageToSend.text := StringReplace(fGetMsg, fGetQrCodePix, '', [rfReplaceAll]);

      if Length(FArquivos) > 0 then
      begin
        for intContador := 0 to Length(FArquivos)-1 do
        begin
          if fEmptyStr(FArquivos[intContador].Arquivo) then
            Continue;

          if (fGetConverteArquivoParaBase64(intContador)) and (not fArquivoExisteNoDiretorio(FArquivos[intContador].Arquivo, 40, 2000)) then
            Exit;

          if not blnEhPrimeiroEnvio then
            EnqueueMessageToSend.text := '';

          ReturnUploadFile := fUploadFile(extIdFila, strApiKey, intContador);
          if Assigned(ReturnUploadFile) then
          begin
            EnqueueMessageToSend.fileId := ReturnUploadFile.fileId;
            EnqueueMessageToSend.file_id := ReturnUploadFile.fileId;
            FEnviado := TControllerEnqueueMessageToSend.fSendMessage(EnqueueMessageToSend,
                                                                     fGetNomeGatilho,
                                                                     fGetUnitDisparo,
                                                                     fGetAutIncNotFic);

            if (blnEhPrimeiroEnvio) and (not fEmptyStr(fGetQrCodePix)) then
            begin
              EnqueueMessageToSend.fileId := 0;
              EnqueueMessageToSend.file_id := 0;
              EnqueueMessageToSend.text := fGetQrCodePix;
              FEnviado := FEnviado and TControllerEnqueueMessageToSend.fSendMessage(EnqueueMessageToSend,
                                                                                    fGetNomeGatilho,
                                                                                    fGetUnitDisparo,
                                                                                    fGetAutIncNotFic);
            end;

            blnEhPrimeiroEnvio := False;
            FreeAndNil(ReturnUploadFile);
          end
          else
          begin
            FEnviado := False;
            Break;
          end;
        end;
      end
      else
      begin
        if not fEmptyStr(EnqueueMessageToSend.text) then
          FEnviado := TControllerEnqueueMessageToSend.fSendMessage(EnqueueMessageToSend,
                                                                       fGetNomeGatilho,
                                                                       fGetUnitDisparo,
                                                                       fGetAutIncNotFic);

        if not fEmptyStr(fGetQrCodePix) then
        begin
          EnqueueMessageToSend.text := fGetQrCodePix;
          FEnviado := TControllerEnqueueMessageToSend.fSendMessage(EnqueueMessageToSend,
                                                                   fGetNomeGatilho,
                                                                   fGetUnitDisparo,
                                                                   fGetAutIncNotFic);
        end;
      end;

    except
      on E: Exception do
      begin
        FEnviado := False;
        pGravarErro(True, 'ERRO WHATSAPP: ' + E.Message, E.StackTrace);
      end;
    end;
  finally
    if (not FEnviado) and (not fEmptyStr(fGetAutIncNotFic)) then
      pMarcaNotFicPendenteDeEnvio;

    FreeAndNil(EnqueueMessageToSend);
  end;
end;

procedure TThreadEnviaSMS.pEnviaWPPOficial(const extIdFila: Extended; const strApiKey: String);
var
  EnqueueMessageToSend: TEnqueueMessageToSend;
  ReturnUploadFile: TReturnUploadFile;
  intContador: Integer;
  blnArquivosProntos: Boolean;
begin
  FEnviado := False;
  ReturnUploadFile := nil;
  blnArquivosProntos := False;

  EnqueueMessageToSend := TEnqueueMessageToSend.Create(False, False, False, False);
  try
    try
      if Length(FArquivos) > 0 then
      begin
        repeat
          for intContador := 0 to Length(FArquivos)-1 do
          begin
            if fEmptyStr(FArquivos[intContador].Arquivo) then
              Continue;

            if (fGetConverteArquivoParaBase64(intContador)) and (not fArquivoExisteNoDiretorio(FArquivos[intContador].Arquivo, 40, 2000)) then
              Exit;

            ReturnUploadFile := fUploadFile(extIdFila, strApiKey, intContador);
            if Assigned(ReturnUploadFile) then
            begin
              FArquivos[intContador].Url := fRetUrlArquivo(extIdFila, strApiKey, ReturnUploadFile.fileId);
              FreeAndNil(ReturnUploadFile);
            end;
          end;

          if Length(FArquivos) = 1 then
            blnArquivosProntos := True
          else
            FArquivos := fCriarArquivoPdfUnico;

        until blnArquivosProntos;
      end;

      EnqueueMessageToSend.text := fGetMsg;
      EnqueueMessageToSend.queueId := extIdFila;
      EnqueueMessageToSend.apiKey := strApiKey;
      EnqueueMessageToSend.templateId := fGetTemplateID;
      EnqueueMessageToSend.number := '55'+fTiraCaracEspeciais(fGetTo, True, True, True, True, True, True);
      EnqueueMessageToSend.varsdata := fGetVariaveisApiOficial;

      if Length(FArquivos) > 0 then
        EnqueueMessageToSend.headerFile := FArquivos[0].Url;

      FEnviado := TControllerEnqueueMessageToSend.fSendMessage(EnqueueMessageToSend,
                                                               fGetNomeGatilho,
                                                               fGetUnitDisparo,
                                                               fGetAutIncNotFic);
    except
      on E: Exception do
      begin
        FEnviado := False;
        pGravarErro(True, 'ERRO WHATSAPP: ' + E.Message, E.StackTrace);
      end;
    end;
  finally
    if (not FEnviado) and (not fEmptyStr(fGetAutIncNotFic)) then
      pMarcaNotFicPendenteDeEnvio;

    FreeAndNil(EnqueueMessageToSend);
  end;
end;

function TThreadEnviaSMS.fGetArquivoBase64(intContador: Integer): String;
begin
  Result := FArquivos[intContador].Arquivo;
  if fGetConverteArquivoParaBase64(intContador) then
    Result := RetornaArquivoBase64(FArquivos[intContador].Arquivo)
end;

function TThreadEnviaSMS.fGetFileName(intContador: Integer): String;
const
  DEFAULT_FILENAME = 'ArquivoWhatsapp';
begin
  Result := FArquivos[intContador].Titulo + fGetExtensaoArquivo(intContador);
  if fEmptyStr(FArquivos[intContador].Titulo) then
    Result := DEFAULT_FILENAME + fGetExtensaoArquivo(intContador);
end;

function TThreadEnviaSMS.fGetWidth(const AstrBase64: String): Extended;
var
  objPicture : TPicture;
begin
  Result := 0;
  objPicture := TPicture.Create;
  try
    pImagemFromBase64(AstrBase64, objPicture);

    Result := objPicture.Width;
  finally
    FreeAndNil(objPicture);
  end;
end;

function TThreadEnviaSMS.fGetHeight(const AstrBase64: String): Extended;
var
  objPicture : TPicture;
begin
  Result := 0;
  objPicture := TPicture.Create;
  try
    pImagemFromBase64(AstrBase64, objPicture);

    Result := objPicture.Height;
  finally
    FreeAndNil(objPicture);
  end;
end;

procedure TThreadEnviaSMS.pMarcaNotFicPendenteDeEnvio;
var
  qryMarEnv: TUniQuery;
begin
  qryMarEnv := fCriaQuery(nil);
  try
    qryMarEnv.Close;
    qryMarEnv.SQL.Text := STR_SQL_NAO_REPLICAR+
    ' UPDATE '+
    '   NOTFIC '+
    ' SET '+
    '   NOT_NOTENV = IF(DATE(NOT_DTAHOR) < CURRENT_DATE, "X", "N"), '+
    '   NOT_INFADI = :INFADI, '+
    IIF(FWhatsapp, 'NOT_ENVWPP', 'NOT_ENVSMS')+' = "S" '+
    ' WHERE '+
    '   AUTOINCREM = :AUTINC ';

    qryMarEnv.ParamByName('AUTINC').AsString := fGetAutIncNotFic;
    qryMarEnv.ParamByName('INFADI').AsString := TControllerRest.fGetLastLog(fGetAutIncNotFic);
    qryMarEnv.ExecSQL;
  finally
    FreeAndNil(qryMarEnv);
  end;
end;

procedure TThreadEnviaSMS.pSetApiKey(Value: String);
begin
  FApiKey := Value;
end;

procedure TThreadEnviaSMS.pSetArquivos(Value: TArray<TRecArquivosGatilhos>);
begin
  FArquivos := Value;
end;

procedure TThreadEnviaSMS.pSetAutIncNotFic(Value: String);
begin
  FAutIncNotFic := Value;
end;

procedure TThreadEnviaSMS.pSetAutIncSms(Value: String);
begin
  FAutIncSms := Value;
end;

procedure TThreadEnviaSMS.pSetCgcEmp(Value: String);
begin
  FCgcEmp := Value;
end;

procedure TThreadEnviaSMS.pSetUnitDisparo(Value: String);
begin
  FUntDis := Value;
end;

procedure TThreadEnviaSMS.pSetUtilizaIntegracaoMKON(Value: Boolean);
begin
  FUtilizaIntegracaoMKON := Value;
end;

procedure TThreadEnviaSMS.pSetVariaveisApiOficial(Value: String);
begin
  FVarsData := Value;
end;

procedure TThreadEnviaSMS.pSetIDFila(Value: String);
begin
  FIDFila := Value;
end;

procedure TThreadEnviaSMS.pSetMsg(Value: String);
begin
  FMsg := Value;
end;

procedure TThreadEnviaSMS.pSetNomeGatilho(Value: String);
begin
  FNomGat := Value;
end;

procedure TThreadEnviaSMS.pSetQrCodePix(Value: String);
begin
  FQrCodePix := Value;
end;

procedure TThreadEnviaSMS.pSetSchedule(Value: String);
begin
  FSchedule := Value;
end;

procedure TThreadEnviaSMS.pSetTo(Value: String);
begin
  FTo := Value;
end;

procedure TThreadEnviaSMS.pSetTemplateID(Value: Integer);
begin
  FTemplateID := Value;
end;

procedure TThreadEnviaSMS.pSetWhatsapp(Value: Boolean);
begin
  FWhatsapp := Value;
end;

end.
