unit PinPad.Classes.Gertec;

interface

uses
  PinPad.Interfaces ;

const
  DocumentosTamanhoMax : array[TPinPadCitelDocumentos] of Char = (#11, #14) ;
  DocumentosTipo : array[TPinPadCitelDocumentos] of Integer = (7, 13) ;
  DLLPINPADGERTEC = 'gpinpad-lite3_x86.dll' ;

type
  TPP_Open = function (portName: AnsiString; secure: boolean): integer; stdcall;
  TPP_Close = function (msg: AnsiString): integer; stdcall;
  TabecsGetClearData         = procedure (msgIdx: Int16;
                                          minDig: char;
                                          maxDig: char;
                                          timeout: char); stdcall;
  TabecsGetClearDataResponse = function (cmdOut: PAnsichar;
                                         notifyOut: Pointer): integer; stdcall;
  TgertecQRCode = procedure (usTimeout: Int64; bLineType: char; sLine: AnsiString; sQRCode:AnsiString); stdcall;
  TPP_Abort = procedure (); stdcall;
  Tgpinpad_exception_handler = procedure (errCode: Int16; msg: PChar); stdcall;
  Tpcl_exception_set_uncaught_handler = procedure (handler: Tgpinpad_exception_handler); stdcall;


  TPinPadCitelGertec = class(TInterfacedObject, IPinPadCitel)
  private
    PP_Open: TPP_Open;
    PP_Close: TPP_Close;
    PP_Abort: TPP_Abort;
    gertecQRCode: TgertecQRCode;
    abecsGetClearData: TabecsGetClearData;
    abecsGetClearDataResponse: TabecsGetClearDataResponse;
    cbAux: Tgpinpad_exception_handler;
    pcl_exception_set_uncaught_handler: Tpcl_exception_set_uncaught_handler;

    FstrPorta: AnsiString ;
    FintRspStatus: Integer;
    FLibHandle: THandle;
    FblnPortaEmUso: Boolean ;
    FstrMensagemErro: String ;
    function fLoadGPinPad(const AstrPath: String): Boolean;
    procedure pRequestDadosLimpos(const ATipoDoc: TPinPadCitelDocumentos) ;
    function fResponseDadosLimpos(var AstrRetorno: String): Integer ;
  public
    constructor Create(const AstrPorta, AstrPath: String); reintroduce; overload;
    destructor  Destroy(); override;
    function fObtemDadoPinPadDireto(const ATipoDoc: TPinPadCitelDocumentos): String ;
    procedure pAbrirPorta ;
    procedure pFecharPorta(const AstrMensagem: AnsiString) ;
    procedure pAbortarUltimoComando ;
    procedure pEnviarQrCode(const AstrTextoQrCode, AstrTituloInformativo: String) ;
    procedure pLimpaQrCode(const AstrMensagem: AnsiString = '') ;
    function fMsgErroAcesso: String ;
  end ;

implementation

uses Winapi.Windows, SysUtils, Classes, VCL.Forms, AnsiStrings ;

procedure pLog(strValor: String);
  const
    _FILE_LOG : String = '.\log_pix.txt';
  Var
    stlLog : TStringList;
begin
  if not FileExists(_FILE_LOG) then
    Exit ;

  stlLog := TStringList.Create;
  Try
    Try
      If FileExists(_FILE_LOG) Then
        stlLog.LoadFromFile(_FILE_LOG);
      stlLog.Add(FormatDateTime('dd/mm/yyyy hh:nn:ss', Now()) + ' - ' + strValor);
      stlLog.SaveToFile(_FILE_LOG);
    Finally
      FreeAndNil(stlLog);
    End;
  Except
  end;
end;

function PathWithDelim(const APath : AnsiString) : AnsiString ;
begin
  Result := AnsiString(Trim(String(APath))) ;
  if Result <> '' then
  begin
     {$IfDef FPC}
      Result := IncludeTrailingPathDelimiter(Result);
     {$Else}
      if AnsiStrings.RightStr(Result,1) <> String(PathDelim) then
         Result := Result + PathDelim ;
     {$EndIf}
  end;
end ;

procedure gpinpad_exception_handler(errCode: Int16;
  msg: PChar); stdcall;
var
  LstrMensagemCodigoTraduzido: String ;
begin
  case errCode of
    0 : LstrMensagemCodigoTraduzido := 'PCL_RESULT_OK';
    1 : LstrMensagemCodigoTraduzido := 'PCL_RESULT_RUNTIME_ERROR';
    2 : LstrMensagemCodigoTraduzido := 'PCL_RESULT_ILLEGAL_ARGUMENT';
    3 : LstrMensagemCodigoTraduzido := 'PCL_RESULT_ILLEGAL_STATE';
    4 : LstrMensagemCodigoTraduzido := 'PCL_RESULT_INDEX_OUT_OF_BOUNDS';
    5 : LstrMensagemCodigoTraduzido := 'PCL_RESULT_MALLOC_ERROR';
    6 : LstrMensagemCodigoTraduzido := 'PCL_RESULT_IO_ERROR';
    7 : LstrMensagemCodigoTraduzido := 'PCL_RESULT_TIMEOUT_ERROR';
    8 : LstrMensagemCodigoTraduzido := 'PCL_RESULT_FILE_NOT_FOUND';
    9 : LstrMensagemCodigoTraduzido := 'PCL_RESULT_ENCODING_ERROR';
    10 : LstrMensagemCodigoTraduzido := 'PCL_RESULT_DEVICE_BUSY';
    11 : LstrMensagemCodigoTraduzido := 'PCL_RESULT_PERMISSION_DENIED';
    12 : LstrMensagemCodigoTraduzido := 'PCL_RESULT_PROTOCOL_ERROR';
    13 : LstrMensagemCodigoTraduzido := 'PCL_RESULT_CRYPT_ERROR';
  else
    LstrMensagemCodigoTraduzido := 'PCL_UNKNOW' ;
  end ;

  raise Exception.Create('problemas ao acessar PinPad: [' + errCode.tostring + '-' + LstrMensagemCodigoTraduzido + '] MSG: ' + String(msg));
  SysUtils.Abort;
end;

{ TPinPadCitelGertec }

constructor TPinPadCitelGertec.Create(const AstrPorta, AstrPath: String);
var
  LstrPath: String ;
begin
  pLog('TPinPadCitelGertec.Create --> entrou ') ;
  FstrPorta := AnsiString(AstrPorta) ;
  FintRspStatus := 0 ;
  FblnPortaEmUso := False ;
  FstrMensagemErro := '' ;

  PP_Open := Nil ;
  PP_Close := Nil ;
  abecsGetClearData := Nil ;
  abecsGetClearDataResponse := Nil ;
  PP_Abort := Nil ;
  gertecQRCode := Nil ;
  pcl_exception_set_uncaught_handler := Nil ;
  pLog('TPinPadCitelGertec.Create --> FileExists ') ;

  LstrPath := ExtractFileDir(Application.ExeName) ;

  if Trim(AstrPath) <> '' then
  begin
    LstrPath := AstrPath ;
    if not FileExists(String(PathWithDelim(AnsiString(LstrPath)))+DLLPINPADGERTEC) then
      LstrPath := ExtractFileDir(Application.ExeName) ;
  end ;

  LstrPath := String(PathWithDelim(AnsiString(LstrPath))) ;

  if not FileExists(LstrPath+DLLPINPADGERTEC) then
  begin
    pLog('TPinPadCitelGertec.Create --> FileExists --> Exception ') ;
    raise Exception.Create('DLL ['+DLLPINPADGERTEC+'] da Gertec não encontrada no diretório do Autcom!') ;
  end ;

  SetDllDirectoryA(PAnsiChar(AnsiString(LstrPath))) ;
  try
    pLog('TPinPadCitelGertec.Create --> fLoadGPinPad ') ;
    if not fLoadGPinPad(LstrPath) then
    begin
      pLog('TPinPadCitelGertec.Create --> fLoadGPinPad --> Exception') ;
      raise Exception.Create('Problemas ao carregar a DLL ['+DLLPINPADGERTEC+'] da Gertec!') ;
    end ;
  finally
    SetDllDirectoryA(Nil) ;
  end ;

  cbAux := Tgpinpad_exception_handler(@gpinpad_exception_handler);
  pcl_exception_set_uncaught_handler(cbAux);

end;

destructor TPinPadCitelGertec.Destroy;
begin
  if FLibHandle > HINSTANCE_ERROR then
    FreeLibrary(FLibHandle) ;

  PP_Open := Nil ;
  PP_Close := Nil ;
  abecsGetClearData := Nil ;
  abecsGetClearDataResponse := Nil ;
  PP_Abort := Nil ;
  gertecQRCode := Nil ;
  inherited Destroy;
end;

function TPinPadCitelGertec.fLoadGPinPad(const AstrPath: String): Boolean;
begin
  FLibHandle:= LoadLibrary(pChar(AstrPath+DLLPINPADGERTEC));
  if FLibHandle <= HINSTANCE_ERROR then
    exit(false);

  pcl_exception_set_uncaught_handler := GetProcAddress(FLibHandle, PChar('pcl_exception_set_uncaught_handler@4'));
  if not Assigned(pcl_exception_set_uncaught_handler) then
    exit(false);

  PP_Open := GetProcAddress(FLibHandle, PChar('PP_Open@8'));
  if not Assigned(PP_Open) then
    exit(false);

  PP_Close := GetProcAddress(FLibHandle, PChar('PP_Close@4'));
  if not Assigned(PP_Close) then
    exit(false);

  abecsGetClearData := GetProcAddress(FLibHandle, PChar('abecsGetClearData@16'));
  if not Assigned(abecsGetClearData) then
    exit(false);

  abecsGetClearDataResponse := GetProcAddress(FLibHandle, PChar('abecsGetClearDataResponse@8'));
  if not Assigned(abecsGetClearDataResponse) then
    exit(false);

  PP_Abort := GetProcAddress(FLibHandle, PChar('PP_Abort@0'));
  if not Assigned(PP_Abort) then
    exit(false);

  gertecQRCode := GetProcAddress(FLibHandle, PChar('gertecQRCode@20'));
  if not Assigned(gertecQRCode) then
    exit(false);

  Result := True ;
end;

function TPinPadCitelGertec.fMsgErroAcesso: String;
begin
  Result := FstrMensagemErro ;
end;

function TPinPadCitelGertec.fObtemDadoPinPadDireto(const ATipoDoc: TPinPadCitelDocumentos): String;
var
  LintStatusRetorno: Integer ;
  LstrRetorno: string ;
begin
  Result := '' ;
  LstrRetorno := '' ;
  pAbrirPorta ;
  try
    pRequestDadosLimpos(ATipoDoc) ;
    LintStatusRetorno := -1 ;
    while LintStatusRetorno = -1 do
    begin
      LintStatusRetorno := fResponseDadosLimpos(LstrRetorno) ;
      if LintStatusRetorno = 0 then
        Result := LstrRetorno ;
    end ;
  finally
    pFecharPorta('') ;
  end ;
end;

function TPinPadCitelGertec.fResponseDadosLimpos(var AstrRetorno: String): Integer;
var
  LcharCmdOut : array[0..32] of AnsiChar;
begin
  result := -1 ;
  AstrRetorno := '' ;
  try
    LcharCmdOut := AnsiString('') ;

    result := abecsGetClearDataResponse(LcharCmdOut, nil);

    AstrRetorno :=  String(LcharCmdOut) ;
  except
    On E: Exception do
    begin
      FstrMensagemErro := FstrMensagemErro + '[fResponseDadosLimpos] ' + E.Message + #13#10 ;
      pLog(FstrMensagemErro) ;
    end ;
  end;
end;

procedure TPinPadCitelGertec.pAbortarUltimoComando;
begin
  try
    PP_Abort();
  except
    On E: Exception do
    begin
      FstrMensagemErro := FstrMensagemErro + '[pAbortarUltimoComando] ' + E.Message + #13#10 ;
      pLog(FstrMensagemErro) ;
    end ;
  end;
end;

procedure TPinPadCitelGertec.pAbrirPorta;
begin
  if FblnPortaEmUso then
    exit ;

  try
    pLog('TPinPadCitelGertec.pAbrirPorta --> entrou ') ;
    FintRspStatus := PP_Open(FstrPorta, false);
    pLog('TPinPadCitelGertec.pAbrirPorta --> saiu ') ;
    FblnPortaEmUso := True ;
  except
    On E: Exception do
    begin
      FstrMensagemErro := FstrMensagemErro + '[pAbrirPorta-'+String(FstrPorta)+'] ' + E.Message + #13#10 ;
      pLog(FstrMensagemErro) ;
    end ;
  end ;
end;

procedure TPinPadCitelGertec.pEnviarQrCode(const AstrTextoQrCode, AstrTituloInformativo: String);
var
  LintTimeout: Int64;
  LcharLineType: char;
  LstrLine: AnsiString;
  LstrQRCode: AnsiString;
begin
  try
    pLog('TPinPadCitelGertec.pEnviarQrCode --> entrou ') ;
    pAbrirPorta ;
    pLog('TPinPadCitelGertec.pEnviarQrCode --> pAbrirPorta ') ;
    LintTimeout := 240;
    LcharLineType := '1';
    LstrLine := AnsiString(AstrTituloInformativo);
    LstrQRCode := AnsiString(AstrTextoQrCode) ;

    pLog('TPinPadCitelGertec.pEnviarQrCode --> gertecQRCode --> antes ') ;
    gertecQRCode(LintTimeout, LcharLineType, LstrLine, LstrQRCode);
    pLog('TPinPadCitelGertec.pEnviarQrCode --> gertecQRCode --> depois ') ;
  except
    On E: Exception do
    begin
      FstrMensagemErro := FstrMensagemErro + '[pEnviarQrCode] ' + E.Message + #13#10 ;
      pLog(FstrMensagemErro) ;
    end ;
  end;
end;

procedure TPinPadCitelGertec.pFecharPorta(const AstrMensagem: AnsiString);
begin
  if not FblnPortaEmUso then
    Exit ;

  try
    FintRspStatus := PP_Close(AstrMensagem);
  Except
    On E: Exception do
    begin
      FstrMensagemErro := FstrMensagemErro + '[pFecharPorta] ' + E.Message + #13#10 ;
      pLog(FstrMensagemErro) ;
    end ;
  end ;

  FblnPortaEmUso := False ;
end;

procedure TPinPadCitelGertec.pLimpaQrCode(const AstrMensagem: AnsiString);
begin
  if not FblnPortaEmUso then
    Exit ;

  pAbortarUltimoComando ;
  pFecharPorta(AstrMensagem) ;
end;

procedure TPinPadCitelGertec.pRequestDadosLimpos(const ATipoDoc: TPinPadCitelDocumentos);
var
  LintMsgIdx: Int16;
  LcharMinDig: char;
  LcharMaxDig: char;
  LcharTimeout: char;
begin
  try
    LintMsgIdx := DocumentosTipo[ATipoDoc];
    LcharMinDig := #4;
    LcharMaxDig := DocumentosTamanhoMax[ATipoDoc];
    LcharTimeout := #0;

    abecsGetClearData(LintMsgIdx,
                      LcharMinDig,
                      LcharMaxDig,
                      LcharTimeout);
  except
    On E: Exception do
    begin
      FstrMensagemErro := FstrMensagemErro + '[pRequestDadosLimpos] ' + E.Message + #13#10 ;
      pLog(FstrMensagemErro) ;
    end ;
  end;
end;

end.
