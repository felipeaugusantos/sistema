unit untTCadPrv;

interface

Uses Classes, DateUtils, StrUtils, SysUtils, Uni, Aurelius.Mapping.Attributes, Aurelius.Types.Nullable;

type
  [Entity]
  [Table('CADPRV')]
  [UniqueKey('PRV_CODPRV')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TCadPrv = class
  private
    [Column('AUTOINCREM', [TColumnProp.Required], 20)]
    FAUTOINCREM: String;

    [Column('PRV_CODPRV', [TColumnProp.Required])]
    FPRV_CODPRV: Integer;

    [Column('PRV_NOMPRV', [TColumnProp.Required], 50)]
    FPRV_NOMPRV: String;

    [Column('PRV_URSMTP', [TColumnProp.Required], 250)]
    FPRV_URSMTP: String;

    [Column('PRV_PORPRV', [TColumnProp.Required])]
    FPRV_PORPRV: Integer;

    [Column('PRV_LIMARQ', [TColumnProp.Required])]
    FPRV_LIMARQ: Integer;

    [Column('PRV_LIMPHR', [TColumnProp.Required])]
    FPRV_LIMPHR: Integer;

    [Column('PRV_URIMAP', [], 250)]
    FPRV_URIMAP: Nullable<String>;

    [Column('PRV_PTIMAP', [], 0)]
    FPRV_PTIMAP: Nullable<Integer>;

    [Column('PRV_SSLSAI', [TColumnProp.Required], 3)]
    FPRV_SSLSAI: String;

    [Column('PRV_SSLENT', [TColumnProp.Required], 3)]
    FPRV_SSLENT: String;

    [Column('PRV_GRVENV', [TColumnProp.Required], 3)]
    FPRV_GRVENV: String;

  public
    constructor Create;

    function fGetPRV_SSLSAI: String;
    function fGetPRV_SSLEnt: String;
    function fGetPRV_GRVENV: String;

    property AUTOINCREM: String            Read FAUTOINCREM Write FAUTOINCREM;
    property PRV_CODPRV: Integer           Read FPRV_CODPRV Write FPRV_CODPRV;
    property PRV_NOMPRV: String            Read FPRV_NOMPRV Write FPRV_NOMPRV;
    property PRV_URSMTP: String            Read FPRV_URSMTP Write FPRV_URSMTP;
    property PRV_PORPRV: Integer           Read FPRV_PORPRV Write FPRV_PORPRV;
    property PRV_LIMARQ: Integer           Read FPRV_LIMARQ Write FPRV_LIMARQ;
    property PRV_LIMPHR: Integer           Read FPRV_LIMPHR Write FPRV_LIMPHR;
    property PRV_URIMAP: Nullable<String>  Read FPRV_URIMAP Write FPRV_URIMAP;
    property PRV_PTIMAP: Nullable<Integer> Read FPRV_PTIMAP Write FPRV_PTIMAP;
    property PRV_SSLSAI: String            Read fGetPRV_SSLSAI Write FPRV_SSLSAI;
    property PRV_SSLENT: String            Read fGetPRV_SSLENT Write FPRV_SSLENT;
    property PRV_GRVENV: String            Read fGetPRV_GRVENV Write FPRV_GRVENV;
  end;

implementation

{ TCadPrv }

constructor TCadPrv.Create;
begin
  FAUTOINCREM := '';
  FPRV_CODPRV := 0;
  FPRV_NOMPRV := '';
  FPRV_URSMTP := '';
  FPRV_PORPRV := 0;
  FPRV_LIMARQ := 0;
  FPRV_LIMPHR := 0;
  FPRV_URIMAP := '';
  FPRV_PTIMAP := 0;
  FPRV_SSLSAI := '';
  FPRV_SSLENT := '';
  FPRV_GRVENV := '';
end;

function TCadPrv.fGetPRV_SSLENT: String;
begin
  If (Self.FPRV_SSLENT = 'N') Then
    Result := 'Não'
  Else
    Result := 'Sim';
end;

function TCadPrv.fGetPRV_SSLSAI: String;
begin
  If (Self.FPRV_SSLSAI = 'N') Then
    Result := 'Não'
  Else
    Result := 'Sim';
end;

function TCadPrv.fGetPRV_GRVENV: String;
begin
  If (Self.FPRV_GRVENV = 'N') Then
    Result := 'Não'
  Else
    Result := 'Sim';
end;

end.
