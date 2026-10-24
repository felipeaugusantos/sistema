unit untLibJWTUtil;

interface

uses JSon ;

Type
  TfGerarTokenRS_ES = function(AstrPayLoad: PWideChar;
                               AstrChavePrivada: PWideChar;
                               AstrChavePublica: PWideChar;
                               AstrToken: PWideChar;
                               AintLenToken: Integer): Integer; stdcall;

  TfGerarParChavesPublicoPrivado = function(AstrChavePublica: PWideChar;
                                            AintChavePublica: Integer;
                                            AstrChavePrivada: PWideChar;
                                            AintChavePrivada: Integer): Integer; stdcall;

  TfValidarParChavesPublicoPrivado = function(AstrChavePublica: PWideChar;
                                              AstrChavePrivada: PWideChar;
                                              AstrMsgValidacao: PWideChar;
                                              AintLenMsgValidacao: Integer): Integer; stdcall;

  TfAes256 = function(AstrInput: PWideChar;
                      AstrOutput: PWideChar;
                      AintLenOutput: integer): Integer; stdcall;

function  fGerarTokenRS256(const AjsonPayLoad: TJSONObject; const AstrChavePrivada: String; const AstrChavePublica: String): string;
function  fGerarTokenRS384(const AjsonPayLoad: TJSONObject; const AstrChavePrivada: String; const AstrChavePublica: String): string;
function  fGerarTokenRS512(const AjsonPayLoad: TJSONObject; const AstrChavePrivada: String; const AstrChavePublica: String): string;
function  fGerarTokenES256(const AjsonPayLoad: TJSONObject; const AstrChavePrivada: String; const AstrChavePublica: String): string;
function  fGerarTokenES256K(const AjsonPayLoad: TJSONObject; const AstrChavePrivada: String; const AstrChavePublica: String): string;
function  fGerarTokenES384(const AjsonPayLoad: TJSONObject; const AstrChavePrivada: String; const AstrChavePublica: String): string;
function  fGerarTokenES512(const AjsonPayLoad: TJSONObject; const AstrChavePrivada: String; const AstrChavePublica: String): string;

procedure pGerarParChavesPublicoPrivado(var AstrChavePrivada, AstrChavePublica: String) ;
function fValidarParChavesPublicoPrivado(const AstrChavePrivada, AstrChavePublica: String; var AstrMsgValidacao: String): Boolean ;

function fRetornaAgoraEmMilisegundos(): Int64 ;

function fCriptografarAes256(const AstrValor: String): String ;
function fDescriptografarAes256(const AstrValor: String): String ;

implementation

uses Winapi.Windows, DateUtils, SysUtils ;

function fRetornaAgoraEmMilisegundos(): Int64 ;
var
  LSistemaTempo: SystemTime;
  LdtaData: TDateTime;
begin
  GetSystemTime(LSistemaTempo);
  LdtaData := EncodeDate(LSistemaTempo.wYear, LSistemaTempo.wMonth, LSistemaTempo.wDay) +
              EncodeTime(LSistemaTempo.wHour, LSistemaTempo.wMinute, LSistemaTempo.wSecond, LSistemaTempo.wMilliseconds);
  Result := MilliSecondsBetween(LdtaData, UnixDateDelta);
end ;

procedure pGerarParChavesPublicoPrivado(var AstrChavePrivada, AstrChavePublica: String) ;
const
  MAXCHAVE = 102400 ;
var
  LstrChavePublica: PWideChar ;
  LstrChavePrivada: PWideChar ;
  LintLen: Integer ;

  Lfunc: TfGerarParChavesPublicoPrivado ;
  LintLibJWT: Cardinal;
begin
  LintLibJWT := LoadLibrary('libJWTOpenSSL.dll');
  if LintLibJWT <> 0 then
  begin
    try
      @Lfunc := GetProcAddress(LintLibJWT, 'fGerarParChavesPublicoPrivado');
      if Assigned(Lfunc) then
      begin
        //buffer para retorno das chaves
        LintLen := 2 * (MAXCHAVE + 1);
        LstrChavePublica := AllocMem(LintLen) ;
        LstrChavePrivada := AllocMem(LintLen) ;
        try
          Lfunc(LstrChavePublica, LintLen, LstrChavePrivada, LintLen) ;
          AstrChavePublica := WideCharToString(LstrChavePublica) ;
          AstrChavePrivada := WideCharToString(LstrChavePrivada) ;
        finally
          FreeMem(LstrChavePublica);
          FreeMem(LstrChavePrivada);
        end ;
      end ;
    finally
      FreeLibrary(LintLibJWT);
    end ;
  end ;
end ;

function fCriptografarAes256(const AstrValor: String): String ;
const
  MAXBUFFER = 102400 ;
var
  Lfunc: TfAes256 ;
  LintLibJWT: Cardinal;

  LstrRetorno: PWideChar ;
  LstrValor: PWideChar ;
  LintLen: Integer ;
begin
  Result := '' ;
  LintLibJWT := LoadLibrary('libJWTOpenSSL.dll');
  if LintLibJWT <> 0 then
  begin
    try
      @Lfunc := GetProcAddress(LintLibJWT, 'fCriptografarAes256');
      if Assigned(Lfunc) then
      begin
        LintLen := 2 * (Length(AstrValor) + 1);
        LstrValor := AllocMem(LintLen) ;
        StringToWideChar(AstrValor, LstrValor, LintLen);

        //buffer para retorno
        LintLen := 2 * (MAXBUFFER + 1);
        LstrRetorno := AllocMem(LintLen) ;

        try
          Lfunc(LstrValor, LstrRetorno, LintLen) ;
          Result := WideCharToString(LstrRetorno) ;
        finally
          FreeMem(LstrRetorno);
          FreeMem(LstrValor);
        end ;
      end ;
    finally
      FreeLibrary(LintLibJWT);
    end ;
  end ;
end ;

function fDescriptografarAes256(const AstrValor: String): String ;
const
  MAXBUFFER = 102400 ;
var
  Lfunc: TfAes256 ;
  LintLibJWT: Cardinal;

  LstrRetorno: PWideChar ;
  LstrValor: PWideChar ;
  LintLen: Integer ;
begin
  Result := '' ;
  LintLibJWT := LoadLibrary('libJWTOpenSSL.dll');
  if LintLibJWT <> 0 then
  begin
    try
      @Lfunc := GetProcAddress(LintLibJWT, 'fDescriptografarAes256');
      if Assigned(Lfunc) then
      begin
        LintLen := 2 * (Length(AstrValor) + 1);
        LstrValor := AllocMem(LintLen) ;
        StringToWideChar(AstrValor, LstrValor, LintLen);

        //buffer para retorno
        LintLen := 2 * (MAXBUFFER + 1);
        LstrRetorno := AllocMem(LintLen) ;

        try
          Lfunc(LstrValor, LstrRetorno, LintLen) ;
          Result := WideCharToString(LstrRetorno) ;
        finally
          FreeMem(LstrRetorno);
          FreeMem(LstrValor);
        end ;
      end ;
    finally
      FreeLibrary(LintLibJWT);
    end ;
  end ;
end ;

function fValidarParChavesPublicoPrivado(const AstrChavePrivada, AstrChavePublica: String; var AstrMsgValidacao: String): Boolean ;
const
  MAXMSG = 128 ;
var
  LstrChavePublica: PWideChar ;
  LstrChavePrivada: PWideChar ;
  LstrMsgRetorno: PWideChar ;
  LintLen: Integer ;
  LintRetorno: Integer ;

  Lfunc: TfValidarParChavesPublicoPrivado ;
  LintLibJWT: Cardinal;
begin
  Result := False ;
  AstrMsgValidacao := '' ;
  LintLibJWT := LoadLibrary('libJWTOpenSSL.dll');
  if LintLibJWT <> 0 then
  begin
    try
      @Lfunc := GetProcAddress(LintLibJWT, 'fValidarParChavesPublicoPrivado');
      if Assigned(Lfunc) then
      begin
        LintLen := 2 * (Length(AstrChavePrivada) + 1);
        LstrChavePrivada := AllocMem(LintLen) ;
        StringToWideChar(AstrChavePrivada, LstrChavePrivada, LintLen);

        LintLen := 2 * (Length(AstrChavePublica) + 1);
        LstrChavePublica := AllocMem(LintLen) ;
        StringToWideChar(AstrChavePublica, LstrChavePublica, LintLen);

        //buffer para retorno das msg
        LintLen := 2 * (MAXMSG + 1);
        LstrMsgRetorno := AllocMem(LintLen) ;
        try
          LintRetorno := Lfunc(LstrChavePublica, LstrChavePrivada, LstrMsgRetorno, LintLen) ;
          Result := LintRetorno = 1 ;

          if not Result then
          begin
            AstrMsgValidacao := WideCharToString(LstrMsgRetorno) ;
          end ;

        finally
          FreeMem(LstrChavePublica);
          FreeMem(LstrChavePrivada);
          FreeMem(LstrMsgRetorno);
        end ;
      end ;
    finally
      FreeLibrary(LintLibJWT);
    end ;
  end ;
end ;

function  fGerarTokenRS_ES(const AjsonPayLoad: TJSONObject; const AstrChavePrivada: String; const AstrChavePublica: String; const AstrTipo: String): string;
const
  MAXTOKEN = 10240 ;
var
  LstrAuxPayLoad: String ;
  LstrChavePrivada: PWideChar ;
  LstrChavePublica : PWideChar ;
  LstrPayLoad: PWideChar ;
  LintLen: Integer ;
  LstrToken: PWideChar ;
  LstrProcNome: PAnsiChar ;

  Lfunc: TfGerarTokenRS_ES ;
  LintLibJWT: Cardinal;
begin
  Result := '' ;
  LintLibJWT := LoadLibrary('libJWT.dll');
  if LintLibJWT <> 0 then
  begin
    try
      LstrProcNome := PAnsiChar(AnsiString('fGerarToken'+AstrTipo)) ;
      @Lfunc := GetProcAddress(LintLibJWT, LstrProcNome);
      if Assigned(Lfunc) then
      begin
        LstrAuxPayLoad := AjsonPayLoad.ToString ;
        LintLen := 2 * (Length(LstrAuxPayLoad) + 1);
        LstrPayLoad := AllocMem(LintLen) ;
        StringToWideChar(LstrAuxPayLoad, LstrPayLoad, LintLen);

        LintLen := 2 * (Length(AstrChavePrivada) + 1);
        LstrChavePrivada := AllocMem(LintLen) ;
        StringToWideChar(AstrChavePrivada, LstrChavePrivada, LintLen);

        LintLen := 2 * (Length(AstrChavePublica) + 1);
        LstrChavePublica := AllocMem(LintLen) ;
        StringToWideChar(AstrChavePublica, LstrChavePublica, LintLen);

        LintLen := 2 * (MAXTOKEN + 1);
        LstrToken := AllocMem(LintLen) ;

        try
          Lfunc(LstrPayLoad, LstrChavePrivada, LstrChavePublica, LstrToken, MAXTOKEN) ;
          result := WideCharToString(LstrToken) ;
        finally
          FreeMem(LstrChavePrivada);
          FreeMem(LstrChavePublica);
          FreeMem(LstrPayLoad);
          FreeMem(LstrToken);
        end ;
      end ;
    finally
      FreeLibrary(LintLibJWT);
    end ;
  end ;
end ;

function  fGerarTokenRS256(const AjsonPayLoad: TJSONObject; const AstrChavePrivada: String; const AstrChavePublica: String): string;
begin
  result := fGerarTokenRS_ES(AjsonPayLoad, AstrChavePrivada, AstrChavePublica, 'RS256') ;
end ;

function  fGerarTokenRS384(const AjsonPayLoad: TJSONObject; const AstrChavePrivada: String; const AstrChavePublica: String): string;
begin
  result := fGerarTokenRS_ES(AjsonPayLoad, AstrChavePrivada, AstrChavePublica, 'RS384') ;
end ;

function  fGerarTokenRS512(const AjsonPayLoad: TJSONObject; const AstrChavePrivada: String; const AstrChavePublica: String): string;
begin
  result := fGerarTokenRS_ES(AjsonPayLoad, AstrChavePrivada, AstrChavePublica, 'RS512') ;
end ;

function  fGerarTokenES256(const AjsonPayLoad: TJSONObject; const AstrChavePrivada: String; const AstrChavePublica: String): string;
begin
  result := fGerarTokenRS_ES(AjsonPayLoad, AstrChavePrivada, AstrChavePublica, 'ES256') ;
end ;

function  fGerarTokenES256K(const AjsonPayLoad: TJSONObject; const AstrChavePrivada: String; const AstrChavePublica: String): string;
begin
  result := fGerarTokenRS_ES(AjsonPayLoad, AstrChavePrivada, AstrChavePublica, 'ES256K') ;
end ;

function  fGerarTokenES384(const AjsonPayLoad: TJSONObject; const AstrChavePrivada: String; const AstrChavePublica: String): string;
begin
  result := fGerarTokenRS_ES(AjsonPayLoad, AstrChavePrivada, AstrChavePublica, 'ES384') ;
end ;

function  fGerarTokenES512(const AjsonPayLoad: TJSONObject; const AstrChavePrivada: String; const AstrChavePublica: String): string;
begin
  result := fGerarTokenRS_ES(AjsonPayLoad, AstrChavePrivada, AstrChavePublica, 'ES512') ;
end ;

end.
