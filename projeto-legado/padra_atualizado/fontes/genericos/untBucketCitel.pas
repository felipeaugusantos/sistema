unit untBucketCitel;

interface

uses
  System.Classes, System.SysUtils, IdHTTP, IdMultipartFormData, IdSSLOpenSSL, Soap.EncdDecd, IdSSLOpenSSLHeaders,
  System.IOUtils, System.NetEncoding, untTypesSistema, untFuncoesGenerica,
  System.SyncObjs, IdStack,
  {$IFDEF LINUX}
  Services.Core.Utils, Services.Core.Connection.Manager, Services.Core.Settings,
  Services.Core.Connection.Interfaces, Services.Core.Rest, Services.Core.Task.Lock,
  Services.Core.Types, Services.Core.Task.Monitor, Posix.Unistd;
  {$ELSE }
  untFuncoesSimples, Uni, OpenSSL.RSAUtils,
  Winapi.Windows, System.StrUtils, AnsiStrings;
  {$ENDIF LINUX}

  {$IFDEF LINUX}

  const
    LIB_CRYPTO = 'libcrypto.so';

    function PEM_read_bio_PUBKEY(bp: PBIO;
                                 x: PPEVP_PKEY;
                                 cb: Pointer;
                                 u: Pointer): PEVP_PKEY; cdecl; external LIB_CRYPTO;
  {$ENDIF LINUX}

type
  IBucketCitel = interface
    ['{E00ADD00-6641-46F1-8586-C5B80A2562E1}']
    function fUploadFile(ARecArquivo: TRecArquivosGatilhos;
                         const AModulo,
                               APrefixos: String;
                               AblnGravarErro: Boolean = False): String;

    function fGetFile(const AURLFile: String;
                            ACodEmp : String = ''): TBytesStream;
  end;

  TBucketCitel = class(TInterfacedObject, IBucketCitel)
  private
    { Singleton }
    class var FInstance: IBucketCitel;
    class var FInstanceLock: TCriticalSection;

    const
      FTokenGenName      = 'TokenGenerator.exe';
      TOKEN_CACHE_MINUTOS = 10;

    Var
      { Config }
      FChvCliBucket: String;
      FPrxCliBucket: String;
      FUrlCitBucket: String;

      { Cache }
      FTokenCache : string;
      FTokenExpire: TDateTime;
      FTokenCodEmp: string;

      { Lock do token }
      FTokenLock: TCriticalSection;

    constructor Create;
    procedure pConfigurarLibSSL;
    function fRetornaTimeStampEmMilisegundos: Int64;
    function fCriptografa(AConteudo: WideString; AChavePublica: TStringList): AnsiString;
    function fObterAutorizacaoBucket(ACodEmp : String = ''): WideString;
    function fArquivoSalvoBucket(const AUrlBkt: String): Boolean;
    function fTokenCacheValido(const ACodEmp: string): Boolean;
    function fUsaBucket(ACodEmp : String = ''): Boolean;

    {$IFNDEF LINUX}
      function fTokenGeneratorExiste: Boolean;
      function fExecutarTokenGenerator(const AConteudo: string;
                                       const AChavePublicaBase64: string;
                                       out AToken: AnsiString;
                                       out AErro: string): Boolean;
    {$ENDIF LINUX}

  public
    { Singleton Access }
    class function Instance: IBucketCitel;

    destructor Destroy; override;

    { Interface }
    function fUploadFile(ARecArquivo: TRecArquivosGatilhos;
                         const AModulo,
                               APrefixos: String;
                               AblnGravarErro: Boolean = False): String;

    function fGetFile(const AURLFile: String;
                            ACodEmp : String = ''): TBytesStream;
  end;

implementation

{ TBucketCitel }

class function TBucketCitel.Instance: IBucketCitel;
begin
  if not Assigned(FInstance) then
  begin
    FInstanceLock.Enter;
    try
      if not Assigned(FInstance) then
        FInstance := TBucketCitel.Create;
    finally
      FInstanceLock.Leave;
    end;
  end;

  Result := FInstance;
end;

procedure TBucketCitel.pConfigurarLibSSL;
begin
 {$IFDEF LINUX}
  IdOpenSSLSetLibPath(GetCurrentDir);//Forçar libcrypto.so e libssl.so da pasta do programa.
 {$ELSE}
  IdOpenSSLSetLibPath(TPath.GetDirectoryName(ParamStr(0))+'\LibREST');
 {$ENDIF LINUX}
end;

function TBucketCitel.fRetornaTimeStampEmMilisegundos: Int64;
var
  LConsulta: {$IFDEF LINUX}IQuery{$ELSE}TUniQuery{$ENDIF LINUX};
begin
  LConsulta := fCriaQuery;
  try
    LConsulta.SQL.Add('SELECT CAST(UNIX_TIMESTAMP(NOW(3)) * 1000 AS UNSIGNED) AS TIMEUNIX');
    LConsulta.Open;

    Result := LConsulta.FieldByName('TIMEUNIX').Value;

    LConsulta.Close;
  finally
    {$IFNDEF LINUX}
    FreeAndNil(LConsulta);
    {$ENDIF LINUX}
  end;
end;

function TBucketCitel.fTokenCacheValido(const ACodEmp: string): Boolean;
begin
  Result := (FTokenCache <> '') And
            (Now < FTokenExpire) And
            (FTokenCodEmp = ACodEmp);
end;

{$IFDEF LINUX}
function LoadPublicKeyPKCS8(const APem: String): PRSA;
var
  Bio: PBIO;
  PKey: PEVP_PKEY;
  PemAnsi: RawByteString;
begin
  if not IdSSLOpenSSLHeaders.Load then
    raise Exception.Create('OpenSSL não foi carregado');

  if not Assigned(BIO_new_mem_buf) then
    raise Exception.Create('BIO_new_mem_buf não carregado');

  PemAnsi := RawByteString(APem + #0);

  Bio := BIO_new_mem_buf(PAnsiChar(PemAnsi), Length(PemAnsi) - 1);
  if Bio = nil then
    raise Exception.Create('Erro ao criar BIO.');

  try
    PKey := PEM_read_bio_PUBKEY(Bio, nil, nil, nil);
    if PKey = nil then
      raise Exception.Create('Erro ao ler PUBLIC KEY (PKCS#8).');

    Result := EVP_PKEY_get1_RSA(PKey);
    if Result = nil then
      raise Exception.Create('Erro ao extrair RSA da PUBLIC KEY.');
  finally
    BIO_free(Bio);
  end;
end;

function RSAEncryptPKCS1(const ATexto, AChavePem: String): AnsiString;
var
  RSAKey: PRSA;
  InputBytes, OutputBytes: TBytes;
  OutLen: Integer;
begin
  RSAKey := LoadPublicKeyPKCS8(AChavePem);

  try
    // Entrada → UTF8
    InputBytes := TEncoding.UTF8.GetBytes(ATexto);

    // Aloca saída com tamanho da chave
    SetLength(OutputBytes, RSA_size(RSAKey));

    OutLen := RSA_public_encrypt(
      Length(InputBytes),
      @InputBytes[0],
      @OutputBytes[0],
      RSAKey,
      RSA_PKCS1_PADDING
    );

    if OutLen <= 0 then
      raise Exception.Create('Erro ao criptografar RSA.');

    Result := EncodeBase64(OutputBytes, OutLen);
  finally
    RSA_free(RSAKey);
  end;
end;

function TBucketCitel.fCriptografa(AConteudo: WideString; AChavePublica: TStringList): AnsiString;
begin
  Result := RSAEncryptPKCS1(AConteudo, AChavePublica.Text);
end;
{$ELSE}
function TBucketCitel.fCriptografa(AConteudo: WideString; AChavePublica: TStringList): AnsiString;
var
  rsa: TRSAUtil;
  pubkey: TRSAPublicKey;
  outStream: TBytesStream;
begin
  Try
    rsa := TRSAUtil.Create();

    pubkey := TRSAPublicKey.Create();
    pubkey.LoadFromStream(TStringStream.Create(AChavePublica.Text));

    rsa.PublicKey := pubkey;
    outStream := TBytesStream.Create;
    rsa.PublicEncrypt(TStringStream.Create(AConteudo), outStream);

    Result := EncodeBase64(outStream.Bytes, outStream.Size);
  Finally
    if Assigned(outStream) then
      FreeAndNil(outStream);

    if Assigned(pubkey) then
      FreeAndNil(pubkey);

    if Assigned(rsa) then
      FreeAndNil(rsa);
  End;
end;

function TBucketCitel.fTokenGeneratorExiste: Boolean;
var
  ExecPath: string;
begin
  ExecPath := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + FTokenGenName;
  Result   := FileExists(ExecPath);
end;

function TBucketCitel.fExecutarTokenGenerator(const AConteudo: string;
                                              const AChavePublicaBase64: string;
                                              out AToken: AnsiString;
                                              out AErro: string): Boolean;
var
  SA       : TSecurityAttributes;
  ReadPipe,
  WritePipe: THandle;
  StartInfo: TStartupInfo;
  ProcInfo : TProcessInformation;
  Buffer   : array[0..2047] of AnsiChar;
  BytesRead: DWORD;
  CmdLine,
  ExecPath : string;
  Output   : AnsiString;
begin
  ExecPath  := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0))) + FTokenGenName;
  AToken    := '';
  AErro     := '';

  ZeroMemory(@SA, SizeOf(SA));
  SA.nLength        := SizeOf(SA);
  SA.bInheritHandle := True;

  if not CreatePipe(ReadPipe, WritePipe, @SA, 0) then
    RaiseLastOSError;

  try
    ZeroMemory(@StartInfo, SizeOf(StartInfo));
    StartInfo.cb         := SizeOf(StartInfo);
    StartInfo.hStdOutput := WritePipe;
    StartInfo.hStdError  := WritePipe;
    StartInfo.dwFlags    := STARTF_USESTDHANDLES;

    ZeroMemory(@ProcInfo, SizeOf(ProcInfo));

    CmdLine := Format('"%s" "%s" "%s"',
      [ExecPath, AConteudo, AChavePublicaBase64]);

    if not CreateProcess(nil,
                         PChar(CmdLine),
                         nil,
                         nil,
                         True,
                         CREATE_NO_WINDOW,
                         nil,
                         nil,
                         StartInfo,
                         ProcInfo) then
      RaiseLastOSError;

    CloseHandle(WritePipe);
    WritePipe := 0;

    Output := '';

    while ReadFile(ReadPipe, Buffer, SizeOf(Buffer), BytesRead, nil) do
    begin
      if BytesRead = 0 then
        Break;
      Output := Output + Copy(Buffer, 1, BytesRead);
    end;

    WaitForSingleObject(ProcInfo.hProcess, INFINITE);

    CloseHandle(ProcInfo.hProcess);
    CloseHandle(ProcInfo.hThread);

    AToken := Trim(Output);

    if StartsText('ERRO:',String(AToken)) then
    begin
      AErro := String(AToken);
      Exit(False);
    end;

    Result := True;

  finally
    if WritePipe <> 0 then
      CloseHandle(WritePipe);

    CloseHandle(ReadPipe);
  end;
end;

{$ENDIF LINUX}

function TBucketCitel.fObterAutorizacaoBucket(ACodEmp : String = ''): WideString;
var
  LCriptografado: AnsiString;
  LUnixTimestamp: Int64;
  LChavePublica: TStringList;
 {$IFNDEF LINUX}
    LErro:String;
 {$ENDIF LINUX}
begin
  // 1ª Verificação
  if fTokenCacheValido(ACodEmp) then
    Exit(FTokenCache);

  // Thread-Safety
  FTokenLock.Enter;
  try
    // 2ª Verificação
    if fTokenCacheValido(ACodEmp) then
      Exit(FTokenCache);

    pConfigurarLibSSL;

    LChavePublica := TStringList.Create;
    try
      LUnixTimestamp := fRetornaTimeStampEmMilisegundos;

      {$IFDEF LINUX}
        LChavePublica.Text := '-----BEGIN PUBLIC KEY-----' + sLineBreak + FChvCliBucket + sLineBreak + '-----END PUBLIC KEY-----';
        LCriptografado := fCriptografa(FPrxCliBucket+'|'+ IntToStr(LUnixTimestamp), LChavePublica);
      {$ELSE}
        if fTokenGeneratorExiste then
        begin
          if not fExecutarTokenGenerator(FPrxCliBucket+'|'+ IntToStr(LUnixTimestamp),
                                         FChvCliBucket,
                                         LCriptografado,
                                         LErro) then
            raise Exception.Create(LErro);
        end
        else
        begin
          LChavePublica.Text := '-----BEGIN PUBLIC KEY-----' + sLineBreak + FChvCliBucket + sLineBreak + '-----END PUBLIC KEY-----';
          LCriptografado := fCriptografa(FPrxCliBucket+'|'+ IntToStr(LUnixTimestamp), LChavePublica);
        end;
     {$ENDIF LINUX}

      Result := FPrxCliBucket +'|'+ IntToStr(LUnixTimestamp) +'|'+ WideString(LCriptografado);

      Result := StringReplace(Result, #13, '', [rfReplaceAll]);
      Result := StringReplace(Result, #10, '', [rfReplaceAll]);

      // Atualiza o cache
      FTokenCache  := Result;
      FTokenExpire := Now + (TOKEN_CACHE_MINUTOS / 1440);
      FTokenCodEmp := ACodEmp;

    finally
      LChavePublica.Free;
    end;

  finally
    FTokenLock.Leave;
  end;
end;

constructor TBucketCitel.Create;
begin
  inherited;
  FTokenLock := TCriticalSection.Create;
end;

destructor TBucketCitel.Destroy;
begin
  FreeAndNil(FTokenLock);
  inherited;
end;

function TBucketCitel.fArquivoSalvoBucket(const AUrlBkt: String): Boolean;
  Var
    objStream : TBytesStream;
begin
  Result := False;
  objStream := Nil;
  Try
    Try
      objStream := fGetFile(AUrlBkt);

      If Assigned(objStream) Then
        Result := objStream.Size > 0;
    Except
      Result := False;
    End;
  Finally
    If Assigned(objStream) Then
      objStream.Free;
  End;
end;

function TBucketCitel.fUploadFile(ARecArquivo: TRecArquivosGatilhos; const AModulo,
  APrefixos: String; AblnGravarErro: Boolean = False): String;
var
  RequisicaoHTTP: TIdHTTP;
  ParametrosDados: TIdMultiPartFormDataStream;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  RespostaRequisicao,
  LNomArq: String;
  LArquivo: String;
  LToken: String;
  LUrlBkt: String;
begin
  Result := EmptyStr;

  if not fUsaBucket then
    Exit;

  LArquivo := ARecArquivo.Arquivo;

  if fEmptyStr(LArquivo) then
    Exit;

  if fEhArquivoBase64(ARecArquivo.Arquivo) then
    LArquivo := fRetBase64ParaArquivo(ARecArquivo.Arquivo, ARecArquivo.Titulo.Replace(' ', '_') + fGetExtensaoArquivo(ARecArquivo.TipoArquivo));

  try
    LToken := fObterAutorizacaoBucket;
  except
    on E: Exception do
    begin
      if AblnGravarErro then
        pGravarErro(True, E.Message, E.StackTrace);

      Exit;
    end;
  end;

  RequisicaoHTTP  := TIdHTTP.Create(Nil);
  SSLHandler      := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  ParametrosDados := TIdMultiPartFormDataStream.Create;
  Try
    RequisicaoHTTP.IOHandler          := SSLHandler;
    RequisicaoHTTP.HTTPOptions        := [];
    RequisicaoHTTP.HandleRedirects    := True;
    RequisicaoHTTP.Request.Connection := 'keep-alive';
    RequisicaoHTTP.Response.KeepAlive := True;
    RequisicaoHTTP.Request.CustomHeaders.Clear;
    RequisicaoHTTP.Request.UserAgent := 'Mozilla/5.0';
    RequisicaoHTTP.Request.CustomHeaders.Values['Authorization'] := LToken;

    ParametrosDados.AddFile('file', LArquivo, fRetMimeTypeExtensaoArquivo(ExtractFileExt(ExtractFileName(LArquivo))));

    LNomArq := APrefixos + '_' + ExtractFileName(LArquivo);

    Try
      RespostaRequisicao := RequisicaoHTTP.Post(FUrlCitBucket + '/api/document/' + AModulo + '/' + LNomArq, ParametrosDados);

      LUrlBkt := FUrlCitBucket + '/' + RequisicaoHTTP.Response.Location;

      If (RequisicaoHTTP.Response.ResponseCode <> 200) Then
      Begin
        if AblnGravarErro then
          pGravarErro(True, 'TBucketCitel.fUploadFile' + sLineBreak + IntToStr(RequisicaoHTTP.Response.ResponseCode) + ' - ' + RespostaRequisicao);

        Exit;
      End;
    Except
      On E: Exception Do
      Begin
        If (RequisicaoHTTP.Response.ResponseCode = 500) Then
        Begin
          LUrlBkt := FUrlCitBucket + '/' + AModulo + '_' + LNomArq;

          If fArquivoSalvoBucket(LUrlBkt) Then
          Begin
            Result := LUrlBkt;
            Exit;
          End;
        End;

        if AblnGravarErro then
          pGravarErro(True, E.Message, E.StackTrace);

        Exit;
      End;
    End;

    Result := LUrlBkt;
  Finally
    if (fEhArquivoBase64(ARecArquivo.Arquivo)) and (FileExists(LArquivo)) then
      DeleteFile(PChar(LArquivo));

    RequisicaoHTTP.Free;
    SSLHandler.Free;
    ParametrosDados.Free;
  End;
end;

function TBucketCitel.fUsaBucket(ACodEmp : String = ''): Boolean;
begin
  FChvCliBucket := fCfgSis('CLICHP', varString, ACodemp);
  FPrxCliBucket := fCfgSis('CLIPFX', varString, ACodemp);
  FUrlCitBucket := fCfgSis('URLBKT', varString, ACodemp);

  Result := ((not fEmptyStr(FChvCliBucket)) and (not fEmptyStr(FPrxCliBucket)) and (not fEmptyStr(FUrlCitBucket)));
end;

function TBucketCitel.fGetFile(const AURLFile: String; ACodEmp : String = ''): TBytesStream;
const
  C_CONNECT_TIMEOUT = 30000;  // 30s
  C_READ_TIMEOUT    = 60000;  // 60s
  C_MAX_RETRY       = 1;
var
  HTTP: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  ResponseStream: TMemoryStream;
  LToken: String;
  LRetry: Integer;
begin
  Result := nil;

  if not fUsaBucket(ACodEmp) then
    Exit;

  try
    LToken := fObterAutorizacaoBucket(ACodEmp);
  except
    on E: Exception do
    begin
      pGravarErro(True, E.Message, E.StackTrace);
      raise Exception.Create(E.Message);
    end;
  end;

  HTTP           := TIdHTTP.Create(nil);
  SSLHandler     := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  ResponseStream := TMemoryStream.Create;
  try
    if Length(LToken) = 0 then
      raise Exception.Create('Token de autorização vazio');

    HTTP.IOHandler            := SSLHandler;
    HTTP.ConnectTimeout       := C_CONNECT_TIMEOUT;
    HTTP.ReadTimeout          := C_READ_TIMEOUT;
    SSLHandler.ConnectTimeout := C_CONNECT_TIMEOUT;
    HTTP.Request.UserAgent    := 'Mozilla/5.0';
    HTTP.Request.CustomHeaders.Values['Authorization'] := LToken;
    HTTP.HandleRedirects      := True;

    for LRetry := 0 to C_MAX_RETRY do
    begin
      try
        ResponseStream.Clear;

        HTTP.Get(AURLFile, ResponseStream);

        ResponseStream.Position := 0;
        Result                  := TBytesStream.Create;
        Result.CopyFrom(ResponseStream, ResponseStream.Size);
        Result.Position         := 0;

        Exit; // sucesso
      except
        on E: EIdSocketError do
        begin
          if E.LastError = 10060 then
          begin
            pGravarErro(False, Format('Timeout ao conectar (tentativa %d de %d)', [LRetry + 1, C_MAX_RETRY + 1]), E.Message);

            if LRetry < C_MAX_RETRY then
              Sleep(500)  // pequeno backoff
            else
              raise;
          end
          else
            raise;
        end;

        on E: EIdHTTPProtocolException do
        begin
          case E.ErrorCode of
            401:
              pGravarErro(True, 'Acesso negado. O token de autorização expirou ou é inválido.', E.Message);
            403:
              pGravarErro(True, 'Permissão insuficiente para acessar o arquivo solicitado.' + sLineBreak +
                                'Verifique suas credenciais ou permissões de acesso.', E.Message);
            404:
              pGravarErro(True, 'O arquivo solicitado não foi encontrado no bucket.' + sLineBreak +
                                'Verifique o endereço ou nome do arquivo.', E.Message);
          else
            pGravarErro(True, 'Erro HTTP inesperado (' + IntToStr(E.ErrorCode) + '): ' + E.ErrorMessage, E.Message);
          end;

          raise Exception.Create(E.Message);
        end;

        on E: Exception do
        begin
          pGravarErro(True, 'Erro ao obter o arquivo da API: ' + E.Message, E.StackTrace);
          raise Exception.Create(E.Message);
        end;
      end;
    end;

  finally
    ResponseStream.Free;
    SSLHandler.Free;
    HTTP.Free;
  end;
end;

initialization
  TBucketCitel.FInstanceLock := TCriticalSection.Create;

finalization
  TBucketCitel.FInstance := nil;
  FreeAndNil(TBucketCitel.FInstanceLock);

end.
