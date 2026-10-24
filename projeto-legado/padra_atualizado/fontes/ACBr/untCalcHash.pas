unit untCalcHash;

interface

Uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, strutils, typinfo, synacode, synautil, Uni,
  ACBr_NTStatus, ACBr_BCrypt, ACBr_NCrypt, ACBr_WinCrypt;

Type
  TSSLDgst = (dgstMD2, dgstMD4, dgstMD5, dgstRMD160, dgstSHA, dgstSHA1, dgstSHA256, dgstSHA512) ;
  TSSLHashOutput = (outHexa, outBase64, outBinary) ;
  TSSLStoreLocation = (slMemory, slLocalMachine, slCurrentUser, slActiveDirectory, slSmartCard);

  TCalcHash = Class(TObject)
  private
     FpStore: HCERTSTORE;
     FpCertContext: PCCERT_CONTEXT;

     FpDFeSSL: Record
                 Senha: AnsiString;
                 StoreName,
                 ArquivoPFX: String;
                 StoreLocation: TSSLStoreLocation;
                 DadosPFX: AnsiString;
               End;

    function CalcHashBase(const AStream: TStream; const Digest: TSSLDgst;
      const ModoSaida: TSSLHashOutput; const Assina: Boolean): AnsiString;

    function CalcHash(const AStream: TStream; const Digest: TSSLDgst;
      const Assina: Boolean): AnsiString;

    procedure OpenSystemStore;

    procedure CarregarCertificadoDeDadosPFX;

  public

    constructor Create;
    destructor Destroy; override;

    procedure CarregarCertificadoDeArquivoPFX;

    function fCalcHash(const BinaryString: AnsiString;
                       const Digest: TSSLDgst; const ModoSaida: TSSLHashOutput; const Assina: Boolean): AnsiString;

    Function fCarregarCertificadoDeArquivoPFX(qryDados: TUniQuery; var strErro: String): Boolean;

  End;

implementation

Uses
  DB, untFuncoesSimples;

Const
  CBufferSize = 32768;  // 32k

constructor TCalcHash.Create;
Begin
  FpStore := Nil;
  FpCertContext := Nil;

  FpDFeSSL.StoreName := 'My';
  FpDFeSSL.StoreLocation := slCurrentUser;
  FpDFeSSL.Senha := '';
End;

destructor TCalcHash.Destroy;
Begin
  If Assigned(FpCertContext) Then
    CertFreeCertificateContext(FpCertContext);
End;

function GetLastErrorAsHexaStr(WinErro: DWORD = 0): String;
begin
  if WinErro = 0 then
    WinErro := GetLastError;

  Result := IntToHex(WinErro, 8);
end;

function MsgErroGetCryptProvider(WinErro: DWORD = 0): String;
begin
  if WinErro = 0 then
    WinErro := GetLastError;

  if WinErro = DWORD( NTE_KEYSET_NOT_DEF ) then
    Result := 'Provedor de Criptografia não encontrado. Verifique a configuração do Certificado'
  else if WinErro = DWORD( NTE_BAD_KEYSET ) then
    Result := 'O recipiente da chave não pôde ser aberto'
  else if WinErro = DWORD( NTE_KEYSET_ENTRY_BAD ) then
    Result := 'Estrutura de Chave obtida no Provedor de Criptografia está corrompida'
  else
    Result := 'Falha em obter Provedor de Criptografia do Certificado. Erro: '+GetLastErrorAsHexaStr(WinErro);
end;

function GetCSPProviderParamDWord(ACryptProvider: HCRYPTPROV; dwParam: DWORD
  ): DWORD;
var
  pdwDataLen: DWORD;
begin
  pdwDataLen := SizeOf(DWORD);
  if not CryptGetProvParam(ACryptProvider, dwParam, @Result, pdwDataLen, 0) then
    raise Exception.Create('GetCSPProviderParamDWord. Erro:'+GetLastErrorAsHexaStr);
end;

function GetCSPProviderIsHardware(ACryptProvider: HCRYPTPROV): Boolean;
var
  ImpType: DWORD;
begin
  ImpType := GetCSPProviderParamDWord(ACryptProvider, PP_IMPTYPE);
  Result := ((ImpType and CRYPT_IMPL_HARDWARE) = CRYPT_IMPL_HARDWARE);
end;

procedure PFXDataToCertContextWinApi(const AData, APass: AnsiString; var AStore,
  ACertContext: Pointer);
var
  PFXBlob: CRYPT_DATA_BLOB;
  PFXCert: PCCERT_CONTEXT;
  wsPass: WideString;
  dwKeySpec: DWORD;
  pfCallerFreeProv: LongBool;
  ProviderOrKeyHandle: HCRYPTPROV_OR_NCRYPT_KEY_HANDLE;
begin
  PFXBlob.cbData := Length(AData);
  PFXBlob.pbData := PBYTE(AData);
  if not PFXIsPFXBlob(PFXBlob) then
    raise Exception.Create('PFXDataToCertContextWinApi: DadosPFX informado não são válidos');

  wsPass := WideString( APass );
  if not PFXVerifyPassword(PFXBlob, LPCWSTR(wsPass), 0) then
    raise Exception.Create('PFXDataToCertContextWinApi: Senha informada está errada');

  AStore := PFXImportCertStore( PFXBlob, LPCWSTR(wsPass),
                                CRYPT_EXPORTABLE {or
                                PKCS12_PREFER_CNG_KSP or
                                PKCS12_INCLUDE_EXTENDED_PROPERTIES});
  if AStore = nil then
    raise Exception.Create(
      'PFXDataToCertContextWinApi: Falha em "PFXImportCertStore" Erro: '+GetLastErrorAsHexaStr);

  // Varre cadeia de certificados lidos, e procura por Certificado do Cliente //
  ACertContext := Nil;
  PFXCert := Nil;
  PFXCert := CertEnumCertificatesInStore(AStore, PCCERT_CONTEXT(PFXCert)^);
  while (PFXCert <> Nil) and (ACertContext = Nil) do
  begin
    // Verificando se o Certificado tem Chave Privada
    pfCallerFreeProv := False;
    ProviderOrKeyHandle := 0;
    dwKeySpec := 0;
    if CryptAcquireCertificatePrivateKey( PFXCert,
                                          CRYPT_ACQUIRE_ALLOW_NCRYPT_KEY_FLAG,
                                          Nil,
                                          ProviderOrKeyHandle,
                                          dwKeySpec,
                                          pfCallerFreeProv) then
    begin
      ACertContext := PFXCert
    end;

    if pfCallerFreeProv and (ProviderOrKeyHandle <> 0) then
      CryptReleaseContext(ProviderOrKeyHandle, 0);

    if ACertContext = Nil then
      PFXCert := CertEnumCertificatesInStore(AStore, PCCERT_CONTEXT(PFXCert)^);
  end;

  if (ACertContext = Nil) then
    raise Exception.Create(
      'PFXDataToCertContextWinApi: Falha ao localizar o Certificado com a Chave Privada.');
end;

procedure TCalcHash.OpenSystemStore;
var
  StoreFlag: DWORD;
  StoreProvider: LPCSTR;
begin
  if (FpStore <> Nil) then
    Exit;

  //TODO: Mapeaer demais tipos
  case FpDFeSSL.StoreLocation of
    slLocalMachine : StoreFlag := CERT_SYSTEM_STORE_LOCAL_MACHINE;
  else
    StoreFlag := CERT_SYSTEM_STORE_CURRENT_USER;
  end;

  {$IfDef DELPHI2009_UP}
   StoreProvider := CERT_STORE_PROV_SYSTEM_W;
  {$ELSE}
   StoreProvider := CERT_STORE_PROV_SYSTEM_A;
  {$ENDIF};

  FpStore := CertOpenStore(
      StoreProvider, 0, 0,
      StoreFlag or CERT_STORE_READONLY_FLAG,
      LPCTSTR( FpDFeSSL.StoreName ) );
  //FpStore := CertOpenSystemStore( 0, LPCTSTR(FpDFeSSL.StoreName) );

  if (FpStore = Nil) then
    raise Exception.Create(
      'TDFeWinCrypt. Erro ao abrir StoreName: ' + FpDFeSSL.StoreName +
      ' Location: ' + IntToStr(Integer(FpDFeSSL.StoreLocation)));
end;

Function TCalcHash.fCarregarCertificadoDeArquivoPFX(qryDados: TUniQuery; var strErro: String): Boolean;
 Var
   mmsLoad: TStream;
Begin
  Result := False;

  Try

    If Not qryDados.FieldByName('CER_ARQPFX').IsNull Then
    Begin
      Result := True;
      mmsLoad := qryDados.CreateBlobStream(qryDados.FieldByName('CER_ARQPFX'), bmRead);

      try
        mmsLoad.Position := 0;
        FpDFeSSL.DadosPFX := ReadStrFromStream(mmsLoad, mmsLoad.Size);
      finally
        FreeAndNil(mmsLoad);
      end;

      FpDFeSSL.Senha := Ansistring(fDecriptar(qryDados.FieldByName('CER_SENHA_').AsString));

      CarregarCertificadoDeDadosPFX;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagemOk('Erro ao ler certificado digital: ' + E.Message);
      strErro := 'Erro ao ler certificado digital: ' + E.Message;
    End;
  End;
End;

procedure TCalcHash.CarregarCertificadoDeArquivoPFX;
var
  PFXStream: TFileStream;
begin
  if not FileExists(FpDFeSSL.ArquivoPFX) then
    raise Exception.Create('Arquivo: ' + FpDFeSSL.ArquivoPFX + ' não encontrado');

  PFXStream := TFileStream.Create(FpDFeSSL.ArquivoPFX, fmOpenRead or fmShareDenyNone);
  try
    PFXStream.Position := 0;
    FpDFeSSL.DadosPFX := ReadStrFromStream(PFXStream, PFXStream.Size);
  finally
    PFXStream.Free;
  end;

  CarregarCertificadoDeDadosPFX;
end;

procedure TCalcHash.CarregarCertificadoDeDadosPFX;
begin
  OpenSystemStore;
  PFXDataToCertContextWinApi( FpDFeSSL.DadosPFX,
                              FpDFeSSL.Senha,
                              FpStore,
                              Pointer(FpCertContext))
end;

function TCalcHash.CalcHash(const AStream: TStream; const Digest: TSSLDgst;
  const Assina: Boolean): AnsiString;
var
  mCryptProvider, mCryptProviderCert: HCRYPTPROV;
  mHash, aHashType: HCRYPTHASH;
  hRSAKey, hSessKey, hExpKey: HCRYPTKEY;
  I: Integer;
  mTotal: Int64;
  mBytesLen, mRead, dwKeySpec, WinErro: DWORD;
  Memory: Pointer;
  mHashBuffer: array [0..1023] of AnsiChar;  // 1024 - Tamanho máximo do maior Hash atual
  pfCallerFreeProv: LongBool;
begin
  Result := '';

  case Digest of
    dgstMD2    : aHashType := CALG_MD2;
    dgstMD4    : aHashType := CALG_MD4;
    dgstMD5    : aHashType := CALG_MD5;
    dgstSHA    : aHashType := CALG_SHA;
    dgstSHA1   : aHashType := CALG_SHA1;
    dgstSHA256 : aHashType := CALG_SHA_256;
    dgstSHA512 : aHashType := CALG_SHA_512;
  else
    raise Exception.Create( 'Digest '+GetEnumName(TypeInfo(TSSLDgst),Integer(Digest))+
                                    ' não suportado em '+ClassName);
  end ;

  mCryptProvider := 0;
  mCryptProviderCert := 0;
  mHash := 0;
  hRSAKey := 0;
  hExpKey := 0;
  hSessKey := 0;
  pfCallerFreeProv := False;
  dwKeySpec := AT_KEYEXCHANGE;

  try
    try
      // Obtendo Contexto de Provedor de Criptografia, com suporte a SHA256 //
      if not CryptAcquireContext( mCryptProvider, Nil, Nil, //PAnsiChar(MS_ENH_RSA_AES_PROV),
                                 PROV_RSA_AES, CRYPT_VERIFYCONTEXT) then
        raise Exception.Create('CryptAcquireContext: '+MsgErroGetCryptProvider);

      if Assina then
      begin
        if not Assigned(FpCertContext) then
          raise Exception.Create('Certificado não pode ser carregado po MS CryptoAPI');

        // TODO: Adicionar suporte a certificados CNG
        // Obtendo o Contexto do Provedor de Criptografia do Certificado //
        if CryptAcquireCertificatePrivateKey( FpCertContext, 0, Nil,
                                              mCryptProviderCert,
                                              dwKeySpec,
                                              pfCallerFreeProv) then
        begin
          if GetCSPProviderIsHardware( mCryptProviderCert ) then
          begin
            CryptReleaseContext(mCryptProvider, 0);
            mCryptProvider := mCryptProviderCert;
            pfCallerFreeProv := False;
          end
          else
          begin
            // Obtendo as chaves do Certificado //
            if CryptGetUserKey(mCryptProviderCert, dwKeySpec, hRSAKey) then
            begin
              // Tentando copiar a chave do Certificado para o nosso Provedor de Criptografia //
              try
                mBytesLen := 0;
                if CryptExportKey( hRSAKey, hSessKey, PRIVATEKEYBLOB, 0, Nil, mBytesLen ) then  // Calcula mBytesLen
                begin
                  Memory := AllocMem(mBytesLen);  // Aloca a memória para receber o Blob
                  try
                    if CryptExportKey( hRSAKey, hSessKey, PRIVATEKEYBLOB, 0, Memory, mBytesLen ) then
                    begin
                      if not CryptImportKey(mCryptProvider, Memory, mBytesLen, hSessKey, 0, hExpKey ) then
                        raise Exception.Create('CryptImportKey');
                    end
                    else
                      raise Exception.Create('CryptExportKey');
                  finally
                    Freemem(Memory);
                  end;
                end
                else
                  raise Exception.Create('CryptExportKey - len');
              except
                { Não foi capaz de Exportar/Copiar a Chave para o nosso Provedor
                  de Criptografia, então vamos usar o Provedor de Criptografia do
                  Certificado }

                CryptReleaseContext(mCryptProvider, 0);
                mCryptProvider := mCryptProviderCert;
                pfCallerFreeProv := False;
              end;
            end
            else
              raise Exception.Create('CryptGetUserKey');
          end
        end
        else
          raise Exception.Create( MsgErroGetCryptProvider );
      end;

      if CryptCreateHash(mCryptProvider, aHashType, 0, 0, mHash) then
      begin
        Memory := Allocmem(CBufferSize);
        try
          mTotal := AStream.Size;
          AStream.Position := 0;
          repeat
            mRead := AStream.Read(Memory^, CBufferSize);
            if mRead > 0 then
            begin
              if not CryptHashData(mHash, Memory, mRead, 0) then
                raise Exception.Create('CryptHashData');
            end;

            mTotal := mTotal - mRead;
          until mTotal < 1;
        finally
          FreeMem(Memory);
        end;

        mBytesLen := Length(mHashBuffer);
        FillChar(mHashBuffer, mBytesLen, #0);

        if Assina then
        begin
          if CryptSignHash(mHash, dwKeySpec, Nil, 0, @mHashBuffer, mBytesLen ) then
          begin
            // MS CryptoAPI retorna assinatura em "Little Endian bit string", invertendo...
            Result := '';
            while (mBytesLen > 256) and (mHashBuffer[mBytesLen-1] = #0) do
              Dec(mBytesLen);

            for I := mBytesLen downto 1 do
              Result := Result + mHashBuffer[I-1];
          end
          else
            raise Exception.Create('CryptSignHash - Assinatura não liberada.');
        end
        else
        begin
          // Obtendo o Hash //
          if CryptGetHashParam(mHash, HP_HASHVAL, @mHashBuffer, mBytesLen, 0) then
            SetString( Result, mHashBuffer, mBytesLen)
          else
            raise Exception.Create('CryptGetHashParam');
        end;
      end
      else
      begin
         WinErro := GetLastError;
         if WinErro = DWORD( NTE_BAD_ALGID  ) then
            raise Exception.Create('O Provedor de Criptografia não suporta o algoritmo: '+
                                   GetEnumName(TypeInfo(TSSLDgst),Integer(Digest)))
         else
           raise Exception.Create('CryptCreateHash');
      end;

    except
      On E: Exception do
      begin
        mCryptProvider := 0;
        raise Exception.Create(E.Message+' , erro: $'+ GetLastErrorAsHexaStr);
      end;
    end;
  finally
    if mHash <> 0 then
      CryptDestroyHash(mHash);

    if hRSAKey <> 0 then
      CryptDestroyKey( hRSAKey );

    if hExpKey <> 0 then
      CryptDestroyKey( hExpKey );

    if pfCallerFreeProv then
      CryptReleaseContext(mCryptProviderCert, 0);

    if mCryptProvider <> 0 then
      CryptReleaseContext(mCryptProvider, 0);
  end;
end;

function TCalcHash.CalcHashBase(const AStream: TStream; const Digest: TSSLDgst;
  const ModoSaida: TSSLHashOutput; const Assina: Boolean): AnsiString;
var
  ABinStr: AnsiString;
begin
  if not Assigned(AStream) then
    raise Exception.Create('Stream inválido');

  if AStream.Size <= 0 then
    raise Exception.Create('Stream vazio');

  ABinStr := CalcHash(AStream, Digest, Assina);

  case ModoSaida of
    outBase64 : Result := AnsiString(Trim(String(EncodeBase64( ABinStr ))));
  //  outHexa   : Result := AsciiToHex( ABinStr ); // TESTAR
  else
    Result := ABinStr;
  end;
end;

function TCalcHash.fCalcHash(const BinaryString: AnsiString;
  const Digest: TSSLDgst; const ModoSaida: TSSLHashOutput; const Assina: Boolean
  ): AnsiString;
Var
   MS : TMemoryStream ;
begin
  MS := TMemoryStream.Create;
  try
    MS.Write( Pointer(BinaryString)^, Length(BinaryString) );
    Result := CalcHashBase( MS, Digest, ModoSaida, Assina );
  finally
    MS.Free ;
  end ;
end;

end.
