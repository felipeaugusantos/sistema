unit IdOpenSSL_ExtraHeaders;

interface

uses
  IdCTypes, IdGlobal, IdSSLOpenSSLHeaders;

type
  // A callback correta deve usar TIdC_INT
  ppassword_cb = function(
    buffer: PAnsiChar;
    size: TIdC_INT;
    rwflag: TIdC_INT;
    userdata: Pointer
  ): TIdC_INT; cdecl;

  // Ponteiro para EVP_PKEY
  PEVP_PKEY = Pointer;
  PPEVP_PKEY = ^PEVP_PKEY;

function PEM_read_bio_PUBKEY(bp: PBIO; x: PPEVP_PKEY; cb: ppassword_cb; u: Pointer): PEVP_PKEY; cdecl;
function PEM_read_bio_RSA_PUBKEY(bp: PBIO; x: PPRSA; cb: ppassword_cb; u: Pointer): PRSA; cdecl;
function EVP_PKEY_get1_RSA(pkey: PEVP_PKEY): PRSA; cdecl;

implementation

const
  {$IFDEF LINUX}
    LIB_CRYPTO = 'libcrypto.so';
  {$ELSE}
    LIB_CRYPTO = 'libcrypto-1_1.dll';
  {$ENDIF}

function PEM_read_bio_PUBKEY;     external LIB_CRYPTO;
function PEM_read_bio_RSA_PUBKEY; external LIB_CRYPTO;
function EVP_PKEY_get1_RSA;       external LIB_CRYPTO;

end.

