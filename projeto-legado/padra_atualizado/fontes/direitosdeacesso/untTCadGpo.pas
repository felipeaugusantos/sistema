unit untTCadGpo;

interface

uses SysUtils, Generics.Collections, Aurelius.Mapping.Attributes, Aurelius.Types.Blob,
     Aurelius.Types.DynamicProperties, Aurelius.Types.Nullable, Aurelius.Types.Proxy,
     Classes, untFuncoesSimples, untTCadOpe;

Type
  [Entity]
  [Table('CADGPO')]
  [Id('FAUTOINCREM', TIdGenerator.None)]
  TCadGpo = class
  private
    [Column('AUTOINCREM', [TColumnProp.Required], 20)]
    FAUTOINCREM: String;

    [Column('GPO_CODGPO', [TColumnProp.Required], 11)]
    FGPO_CODGPO: Integer;

    [Column('GPO_DESCRI', [TColumnProp.Required], 50)]
    FGPO_DESCRI: String;

    [Column('GPO_DTACAD', [])]
    FGPO_DTACAD: Nullable<TDateTime>;

    [Column('GPO_CODEMP', [], 3)]
    FGPO_CODEMP: Nullable<String>;

    function  fGetDtaCad: String;
    procedure pSetDtaCad(const Value: String);
  public
    Constructor Create;
    Destructor Destroy; Override;

    property AUTOINCREM: String              Read FAUTOINCREM         Write FAUTOINCREM;
    property GPO_CODGPO: Integer             Read FGPO_CODGPO         Write FGPO_CODGPO;
    property GPO_DESCRI: String              Read FGPO_DESCRI         Write FGPO_DESCRI;
    property GPO_DTACAD: Nullable<TDateTime> Read FGPO_DTACAD         Write FGPO_DTACAD;
    property GPO_CODEMP: Nullable<String>    Read FGPO_CODEMP         Write FGPO_CODEMP;

    property strDtaCad : String              Read fGetDtaCad          Write pSetDtaCad;
  end;

implementation

{ TCadGpo }

Constructor TCadGpo.Create;
begin
  FGPO_CODGPO := 0;
  FGPO_DESCRI := '';
end;

Destructor TCadGpo.Destroy;
begin
  inherited;
end;

function  TCadGpo.fGetDtaCad: String;
begin
  if (not FGPO_DTACAD.HasValue) then
    Result := ''
  else
    Result := FormatDateTime('dd/mm/yyyy', FGPO_DTACAD);
end;

procedure TCadGpo.pSetDtaCad(const Value: String);
begin
  if fEmptyStr(Value) then
    FGPO_DTACAD := 0
  else
    FGPO_DTACAD := StrToDate(Value);
end;

end.
