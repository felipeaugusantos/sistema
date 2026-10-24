unit untFuncoesHash;

interface

function fRetHashString(strString: String): String;
function fDescriptografa(strTexto: AnsiString): AnsiString;
function fCriptografa(strTexto: AnsiString): AnsiString;
function fRetHashArquivo(strNomeArq: String): String;

implementation

uses LbClass, LbUtils, LbCipher, SysUtils, untConstantes;

function fRetHashString(strString: String): String;
  Var
    md5: TLbMD5;
    digest: TMD5Digest;
begin
  md5 := TLbMD5.Create(Nil);
  md5.HashString(strString);
  md5.GetDigest(digest);
  Result := BufferToHex(digest, SizeOf(digest));
  FreeAndNil(md5);
end;

function fDescriptografa(strTexto: AnsiString): AnsiString;
  Var
    blowfish: TLbBlowfish;
begin
  blowfish := TLbBlowfish.Create(Nil);
  blowfish.GenerateKey(CHAVE_PRIVADA);
  Result := blowfish.DecryptString(Ansistring(strTexto));
  FreeAndNil(blowfish);
end;

function fCriptografa(strTexto: AnsiString): AnsiString;
  Var
    blowfish: TLbBlowfish;
begin
  blowfish := TLbBlowfish.Create(Nil);
  blowfish.GenerateKey(CHAVE_PRIVADA);
  Result := blowfish.EncryptString(Ansistring(strTexto));
  FreeAndNil(blowfish);
end;

function fRetHashArquivo(strNomeArq: String): String;
  Var
    md5: TLbMD5;
    digest: TMD5Digest;
begin
  md5 := TLbMD5.Create(Nil);
  md5.HashFile(strNomeArq);
  md5.GetDigest(digest);
  Result := BufferToHex(digest, SizeOf(digest));
  FreeAndNil(md5);
end;

end.
