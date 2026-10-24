unit PinPad.Classes.Scope;

interface

uses
  PinPad.Interfaces, Classes ;

const
  DLLPINPADSCOPE = 'scopeapi.dll' ;
  PC_GETINFO_HW:                      Word     = 0 ;
  FILE_TYPE_PNG:                      AnsiChar = '1' ;
  FILE_TYPE_JPG:                      AnsiChar = '2' ;
  FILE_TYPE_GIF:                      AnsiChar = '3' ;
  RCS_ERRO_MODO_ABECS:                LongInt  = $FF90 ;
  RCS_ERRO_TAMANHO_INVALIDO:          LongInt  = $FF91 ;
  RCS_ERRO_ARQUIVO_INVALIDO:          LongInt  = $FF92 ;
  RCS_ERRO_NOME_ARQUIVO_PP_INVALIDO:  LongInt  = $FF93 ;
  RCS_ERRO_TIPO_ARQUIVO_PP_INVALIDO:  LongInt  = $FF94 ;
  PC_NAO_ABERTO_APP:                  LongInt  = 211 ;
  PC_COMMERR:                         LongInt  = 31 ;
  PC_ALREADYOPEN:                     LongInt  = 14 ;
  PC_OK:                              LongInt  = 0  ;
  PC_ANULA:                           LongInt  = 13 ;
  SCO_TRN_EM_ANDAMENTO:               LongInt  = $FE00 ;
  PC_GETDATA_CPF:                     Word     = 7 ;
  PC_GETDATA_CNPJ:                    Word     = 14 ;


type
  PAbecs_PPFile_Iinfo = ^TAbecs_PPFile_Iinfo ;
  TAbecs_PPFile_Iinfo = packed record
    Version:        Integer;                      // 4 bytes - igual ao int em C
    szFileNamePP:   array [0..8] of AnsiChar;     // 9 bytes
    cFileType:      AnsiChar;
    szFileName:     array [0..256] of AnsiChar;   // 257 bytes
    szFilePath:     array [0..320] of AnsiChar;   // 321 bytes
  end;


  TScopePPOpenSecure             = function (_TipoCanal: Word; _Endereco: PAnsiChar): LongInt; stdcall;
  TScopePPClose                  = function (IdleMsg: PAnsiChar): LongInt; stdcall;
  TScopePPDisplay                = function (_Msg: PAnsiChar): LongInt; stdcall;

  TScopePPMMFileLoad             = function (_ptInfoFile: PAbecs_PPFile_Iinfo): LongInt; stdcall;
  TScopePPMMFileList             = function (_ptFileList: PAnsiChar; _ptTamanho: PLongInt): LongInt; stdcall;
  TScopePPMMFileDelete           = function (_ptFileNamePP: PAnsiChar): LongInt; stdcall;
  TScopePPMMDisplayImage         = function (_ptFileNamePP: PAnsiChar): LongInt; stdcall;

  TScopePPStartGetData           = function (_Dado, _TamMin, _TamMax: Word): LongInt; stdcall;
  TScopePPGetData                = function (_LenDado: Word; _Buffer: PAnsiChar): LongInt; stdcall;

  TPinPadCitelScope = class(TInterfacedObject, IPinPadCitel)
  private
    ScopePPOpenSecure: TScopePPOpenSecure ;
    ScopePPClose: TScopePPClose ;
    ScopePPDisplay: TScopePPDisplay ;

    ScopePPMMFileLoad: TScopePPMMFileLoad ;
    ScopePPMMFileList: TScopePPMMFileList ;
    ScopePPMMFileDelete: TScopePPMMFileDelete ;
    ScopePPMMDisplayImage: TScopePPMMDisplayImage ;

    ScopePPStartGetData: TScopePPStartGetData ;
    ScopePPGetData: TScopePPGetData ;

    FstrPorta: AnsiString ;
    FintRspStatus: Integer;
    FLibHandle: THandle;
    FblnPortaEmUso: Boolean ;
    FblnPortaJaAberta: Boolean ;
    FstrMensagemErro: String ;
    function fLoadGPinPad(const AstrPath: String): Boolean;
    function fValidaRetornoScopePPMMFileDelete(const AintRetorno: LongInt; Var AstrMensagem: String): Boolean ;
    function fValidaRetornoScopePPOpenSecure(const AintRetorno: LongInt; Var AstrMensagem: String): Boolean ;
    function fDeletaArquivoNoPinPad(const AstrArquivo: AnsiString): Boolean ;
    function fArrayToString(const AarrValor: array of AnsiChar): AnsiString;
  public
    constructor Create(const AstrPorta, AstrPath: String); reintroduce; overload;
    destructor  Destroy(); override;
    function fObtemDadoPinPadDireto(const ATipoDoc: TPinPadCitelDocumentos): String ;
    procedure pAbrirPorta ;
    procedure pFecharPorta(const AstrMensagem: AnsiString) ;
    procedure pAbortarUltimoComando ;
    procedure pEnviarQrCode(const AstrDiretorio, AstrArquivo: String) ;
    procedure pLimpaQrCode(const AstrMensagem: AnsiString = '') ;
    function fMsgErroAcesso: String ;
  end ;


implementation

uses SysUtils,
     {$IFDEF LINUX}
     Posix.Unistd,
     {$ELSE}
     Winapi.Windows,
     {$ENDIF} StrUtils,
     Vcl.ExtCtrls, Vcl.Forms,
     Vcl.Graphics, AnsiStrings, Math;

procedure pLog(strValor: String);
  const
    _FILE_LOG : String = '.\log_pix.txt';
  Var
    stlLog : TStringList;
    LProcID: String ;
begin
  if not FileExists(_FILE_LOG) then
    Exit ;

 {$IFDEF LINUX}
  LProcID := IntToStr(getpid);
 {$ELSE}
  LProcID := IntToStr(GetCurrentProcessId);
 {$ENDIF}

  stlLog := TStringList.Create;
  Try
    Try
      If FileExists(_FILE_LOG) Then
        stlLog.LoadFromFile(_FILE_LOG);
      stlLog.Add(LProcID + ' - ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', Now()) + ' - ' + strValor);
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


{ TPinPadCitelScope }

constructor TPinPadCitelScope.Create(const AstrPorta, AstrPath: String);
var
  LstrPath: String ;
begin
  pLog('TPinPadCitelScope.Create --> entrou ') ;
  FstrPorta := AnsiString(trim(ReplaceStr(LowerCase(AstrPorta), 'com', ''))) ;
  FstrPorta := AnsiString(IntToStr(StrToIntDef(String(FstrPorta), 6))) ;
  FintRspStatus := 0 ;
  FblnPortaEmUso := False ;
  FblnPortaJaAberta := False ;
  FstrMensagemErro := '' ;

  ScopePPOpenSecure     := Nil ;
  ScopePPClose          := Nil ;
  ScopePPDisplay        := Nil ;

  ScopePPMMFileLoad     := Nil ;
  ScopePPMMFileList     := Nil ;
  ScopePPMMFileDelete   := Nil ;
  ScopePPMMDisplayImage := Nil ;

  ScopePPStartGetData   := Nil ;
  ScopePPGetData        := Nil ;

  pLog('TPinPadCitelScope.Create --> FileExists ') ;

  LstrPath := ExtractFileDir(Application.ExeName) ;

  if Trim(AstrPath) <> '' then
  begin
    LstrPath := AstrPath ;
    if not FileExists(String(PathWithDelim(AnsiString(LstrPath)))+DLLPINPADSCOPE) then
      LstrPath := ExtractFileDir(Application.ExeName) ;
  end ;

  LstrPath := String(PathWithDelim(AnsiString(LstrPath))) ;

  if not FileExists(LstrPath+DLLPINPADSCOPE) then
  begin
    pLog('TPinPadCitelScope.Create --> FileExists --> Exception ') ;
    raise Exception.Create('DLL ['+DLLPINPADSCOPE+'] do Scope não encontrada no diretório do Autcom!') ;
  end ;

  SetDllDirectory(PWideChar(WideString(LstrPath))) ;
  try
    pLog('TPinPadCitelScope.Create --> fLoadGPinPad ') ;
    if not fLoadGPinPad(LstrPath) then
    begin
      pLog('TPinPadCitelScope.Create --> fLoadGPinPad --> Exception') ;
      raise Exception.Create('Problemas ao carregar a DLL ['+DLLPINPADSCOPE+'] do Scope!') ;
    end ;
  finally
    //SetDllDirectory(Nil) ;
  end ;

end;

destructor TPinPadCitelScope.Destroy;
begin
if FLibHandle > HINSTANCE_ERROR then
    FreeLibrary(FLibHandle) ;

  ScopePPOpenSecure     := Nil ;
  ScopePPClose          := Nil ;
  ScopePPDisplay        := Nil ;

  ScopePPMMFileLoad     := Nil ;
  ScopePPMMFileList     := Nil ;
  ScopePPMMFileDelete   := Nil ;
  ScopePPMMDisplayImage := Nil ;

  ScopePPStartGetData   := Nil ;
  ScopePPGetData        := Nil ;

  inherited Destroy;
end;

function TPinPadCitelScope.fArrayToString(
  const AarrValor: array of AnsiChar): AnsiString;
var
  LintCnt: integer;
begin
  Result := '' ;
  for LintCnt := Low(AarrValor) to High(AarrValor) do
    if AarrValor[LintCnt] <> #0 then
      Result := Result + AarrValor[LintCnt] ;
end;

function TPinPadCitelScope.fDeletaArquivoNoPinPad(
  const AstrArquivo: AnsiString): Boolean;
var
  LstrIdArquivoPinPad: AnsiString ;
  LintRet: Integer ;
  LstrMensagemValidacao: String ;
begin
  Result := False ;
  LstrIdArquivoPinPad := AnsiString(AstrArquivo) ;
  LintRet := ScopePPMMFileDelete(PAnsiChar(LstrIdArquivoPinPad));
  if not fValidaRetornoScopePPMMFileDelete(LintRet, LstrMensagemValidacao) then
  begin
    FstrMensagemErro := LstrMensagemValidacao + '[' + Trim(String(AstrArquivo)) + ']' ;
    Exit ;
  end ;
  Result := True ;
end;

function TPinPadCitelScope.fLoadGPinPad(const AstrPath: String): Boolean;
const
  LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR = $00000100 ;
begin

  FLibHandle:= LoadLibraryEx(PChar(AstrPath+DLLPINPADSCOPE),0, LOAD_LIBRARY_SEARCH_DLL_LOAD_DIR) ;
  if FLibHandle <= HINSTANCE_ERROR then
    exit(false);

  ScopePPOpenSecure := GetProcAddress(FLibHandle, PChar('ScopePPOpenSecure'));
  if not Assigned(ScopePPOpenSecure) then
    exit(false);

  ScopePPClose := GetProcAddress(FLibHandle, PChar('ScopePPClose'));
  if not Assigned(ScopePPClose) then
    exit(false);

  ScopePPDisplay := GetProcAddress(FLibHandle, PChar('ScopePPDisplay'));
  if not Assigned(ScopePPDisplay) then
    exit(false);

  ScopePPMMFileLoad := GetProcAddress(FLibHandle, PChar('ScopePPMMFileLoad'));
  if not Assigned(ScopePPMMFileLoad) then
    exit(false);

  ScopePPMMFileList := GetProcAddress(FLibHandle, PChar('ScopePPMMFileList'));
  if not Assigned(ScopePPMMFileList) then
    exit(false);

  ScopePPMMFileDelete := GetProcAddress(FLibHandle, PChar('ScopePPMMFileDelete'));
  if not Assigned(ScopePPMMFileDelete) then
    exit(false);

  ScopePPMMDisplayImage := GetProcAddress(FLibHandle, PChar('ScopePPMMDisplayImage'));
  if not Assigned(ScopePPMMDisplayImage) then
    exit(false);

  ScopePPStartGetData := GetProcAddress(FLibHandle, PChar('ScopePPStartGetData'));
  if not Assigned(ScopePPStartGetData) then
    exit(false);

  ScopePPGetData := GetProcAddress(FLibHandle, PChar('ScopePPGetData'));
  if not Assigned(ScopePPGetData) then
    exit(false);

  Result := True ;
end;

function TPinPadCitelScope.fMsgErroAcesso: String;
begin
  Result := FstrMensagemErro ;
end;

function TPinPadCitelScope.fObtemDadoPinPadDireto(
  const ATipoDoc: TPinPadCitelDocumentos): String;
var
  LintRet: Integer ;
  LstrBuffer: array [0..32] of AnsiChar ;
begin
  {$WARN UNSAFE_CODE OFF}
  ZeroMemory(@LstrBuffer, SizeOf(LstrBuffer));
  {$WARN UNSAFE_CODE ON}

  FstrMensagemErro := '' ;
  pAbrirPorta ;
  if trim(FstrMensagemErro) <> '' then
    Exit ;

  try

    LintRet := ScopePPStartGetData(ifThen(ATipoDoc = ppcdCpf, PC_GETDATA_CPF, PC_GETDATA_CNPJ), 0, ifThen(ATipoDoc = ppcdCpf, 11, 14)) ;
    if LintRet = PC_OK then
    begin
      repeat
        {$WARN UNSAFE_CODE OFF}
        LintRet := ScopePPGetData(Length(LstrBuffer), PAnsiChar(@LstrBuffer)) ;
        {$WARN UNSAFE_CODE ON}

        if LintRet = PC_ANULA then
          Break ;

        if LintRet = PC_OK then
          Break ;

      until (LintRet = SCO_TRN_EM_ANDAMENTO) ;
    end ;

  finally
    pFecharPorta('');
  end ;

  Result := String(fArrayToString(LstrBuffer)) ;
end;

function TPinPadCitelScope.fValidaRetornoScopePPMMFileDelete(
  const AintRetorno: Integer; var AstrMensagem: String): Boolean;
begin
  AstrMensagem := '' ;
  if AintRetorno = PC_OK then
    Exit(True) ;

  Result := False ;
  if AintRetorno = RCS_ERRO_MODO_ABECS then
  begin
    AstrMensagem := 'Chamada válida somente para PINpads ABECS [' + inttostr(AintRetorno) + ']' ;
    Exit ;
  end ;

  if AintRetorno = PC_NAO_ABERTO_APP then
  begin
    AstrMensagem := 'PIN-Pad não foi aberto pela aplicação [' + inttostr(AintRetorno) + ']' ;
    Exit ;
  end ;

  AstrMensagem := 'Erro desconhecido [' + inttostr(AintRetorno) + ']' ;
end;

function TPinPadCitelScope.fValidaRetornoScopePPOpenSecure(
  const AintRetorno: Integer; var AstrMensagem: String): Boolean;
begin
  AstrMensagem := '' ;
  if AintRetorno = PC_OK then
    Exit(True) ;

  if AintRetorno = PC_ALREADYOPEN then
    Exit(True) ;

  Result := False ;
  if AintRetorno = PC_COMMERR then
  begin
    AstrMensagem := 'PIN-Pad provavelmente desconectado ou problemas com a interface serial  [' + inttostr(AintRetorno) + ']' ;
    Exit ;
  end ;

  AstrMensagem := 'Erro desconhecido [' + inttostr(AintRetorno) + ']' ;
end;

procedure TPinPadCitelScope.pAbortarUltimoComando;
begin
  try
    FintRspStatus := ScopePPDisplay(PAnsiChar(AnsiString(' '))) ;
  except
    On E: Exception do
    begin
      FstrMensagemErro := FstrMensagemErro + '[pAbortarUltimoComando] ' + E.Message + #13#10 ;
      pLog(FstrMensagemErro) ;
    end ;
  end;
end;

procedure TPinPadCitelScope.pAbrirPorta;
var
  LstrMensagemValidacao: String ;
begin
  if FblnPortaEmUso then
    Exit ;

  try
    pLog('TPinPadCitelScope.pAbrirPorta --> entrou ') ;
    FintRspStatus := ScopePPOpenSecure(1, PAnsiChar(AnsiString(FstrPorta))) ;
    if not fValidaRetornoScopePPOpenSecure(FintRspStatus, LstrMensagemValidacao) then
    begin
      FstrMensagemErro := LstrMensagemValidacao + ' Porta: ' + String(FstrPorta) ;
      Exit ;
    end ;
    pLog('TPinPadCitelScope.pAbrirPorta --> saiu ') ;
    FblnPortaJaAberta := FintRspStatus = PC_ALREADYOPEN ;
    FblnPortaEmUso := True ;
  except
    On E: Exception do
    begin
      FstrMensagemErro := FstrMensagemErro + '[pAbrirPorta-'+String(FstrPorta)+'] ' + E.Message + #13#10 ;
      pLog(FstrMensagemErro) ;
    end ;
  end ;
end;

procedure TPinPadCitelScope.pEnviarQrCode(const AstrDiretorio, AstrArquivo: String);
const
  ID_ARQUIVO_PINPAD: AnsiString = 'ARQ00001' ;
var
  LstrPathDiretorio: String ;
  LstrNomeArquivoImagem: String ;
  LInfoArquivo:  TAbecs_PPFile_Iinfo;
  LstrIdArquivoPinPad: AnsiString ;
  LstrNomeArquivo: AnsiString ;
  LstrDiretorio: AnsiString ;
begin
  LstrPathDiretorio := AstrDiretorio ;
  LstrNomeArquivoImagem := AstrArquivo ;

  FstrMensagemErro := '' ;
  pAbrirPorta ;
  if trim(FstrMensagemErro) <> '' then
    Exit;

  {$WARN UNSAFE_CODE OFF}
  ZeroMemory(@LInfoArquivo, SizeOf(TAbecs_PPFile_Iinfo));

  LInfoArquivo.Version   := 1;
  LInfoArquivo.cFileType := AnsiChar(FILE_TYPE_PNG);

  LstrIdArquivoPinPad := AnsiString(ID_ARQUIVO_PINPAD);
  LstrNomeArquivo     := AnsiString(LstrNomeArquivoImagem);
  LstrDiretorio       := AnsiString(ReplaceStr(LstrPathDiretorio, '\', '\\'));

  // StrPLCopy: copia no máximo N chars e garante #0 final, sem ler além da fonte
  System.AnsiStrings.StrPLCopy(PAnsiChar(@LInfoArquivo.szFileNamePP), LstrIdArquivoPinPad,
            SizeOf(LInfoArquivo.szFileNamePP) - 1);
  System.AnsiStrings.StrPLCopy(PAnsiChar(@LInfoArquivo.szFileName), LstrNomeArquivo,
            SizeOf(LInfoArquivo.szFileName) - 1);
  System.AnsiStrings.StrPLCopy(PAnsiChar(@LInfoArquivo.szFilePath), LstrDiretorio,
            SizeOf(LInfoArquivo.szFilePath) - 1);

  ScopePPMMFileLoad(@LInfoArquivo) ;
  {$WARN UNSAFE_CODE ON}
  // apaga arquivo temporario da imagem
  if FileExists(LstrPathDiretorio + LstrNomeArquivoImagem) then
    DeleteFile(PWideChar(LstrPathDiretorio + LstrNomeArquivoImagem)) ;

  // mostra o arquivo no visor
  LstrIdArquivoPinPad := AnsiString(ID_ARQUIVO_PINPAD + #0) ;
  ScopePPMMDisplayImage(PAnsiChar(LstrIdArquivoPinPad));

  // deleta o arquivo do PinPad
  fDeletaArquivoNoPinPad(LstrIdArquivoPinPad) ;
end;

procedure TPinPadCitelScope.pFecharPorta(const AstrMensagem: AnsiString);
begin
  if not FblnPortaEmUso then
    Exit ;

  try
    if not FblnPortaJaAberta then
      FintRspStatus := ScopePPClose(PAnsiChar(AnsiString(AstrMensagem))) ;
  Except
    On E: Exception do
    begin
      FstrMensagemErro := FstrMensagemErro + '[pFecharPorta] ' + E.Message + #13#10 ;
      pLog(FstrMensagemErro) ;
    end ;
  end ;

  FblnPortaEmUso := False ;
end;

procedure TPinPadCitelScope.pLimpaQrCode(const AstrMensagem: AnsiString);
begin
  if not FblnPortaEmUso then
    Exit ;

  pAbortarUltimoComando ;
  pFecharPorta(AstrMensagem) ;
end;

end.
