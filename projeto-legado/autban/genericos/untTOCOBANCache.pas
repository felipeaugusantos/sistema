unit untTOcoBanCache;

interface

uses
  System.Generics.Collections, Data.DB, Uni;

type
  TOCOBANRecord = record
    OCO_CODOCO: string;
    OCO_MOTIVO: string;
    OCO_DESCRI: string;
    OCO_CODBCO: string;
    OCO_OPCNAB: string;
  end;

  TOCOBANCache = class
  private
    class var FInstance: TOCOBANCache;
    FCache: TDictionary<string, TOCOBANRecord>;
    FUltimoCodBco: string;
    FUltimoOpcNab: string;
    FCacheLoaded: Boolean;
    procedure CarregarCache(const ACodigoBanco, ACnab: string);
    function GerarChave(const ACodigoOcorrencia, ACodigoBanco, ACnab: string): string;
  public
    constructor Create;
    destructor Destroy; override;
    function ObterRegistro(const ACodigoOcorrencia, ACodigoBanco, ACnab: string; out ARegistro: TOCOBANRecord): Boolean;
    procedure RecarregarCache(const ACodigoBanco, ACnab: string);
    class function GetInstance: TOCOBANCache;
    class procedure DestruirInstancia;
  end;

  function ObterDescricaoOcorrencia(const ACodigoOcorrencia, ACodigoBanco, ACnab: string): string;

implementation

uses
  System.SysUtils, untFuncoesSimples;

{ TOCOBANCache }

constructor TOCOBANCache.Create;
begin
  inherited;
  FCache := TDictionary<string, TOCOBANRecord>.Create;
  FUltimoCodBco := '';
  FUltimoOpcNab := '';
  FCacheLoaded := False;
end;

destructor TOCOBANCache.Destroy;
begin
  FCache.Free;
  inherited;
end;

class procedure TOCOBANCache.DestruirInstancia;
begin
  FreeAndNil(FInstance);
end;

procedure TOCOBANCache.CarregarCache(const ACodigoBanco, ACnab: string);
var
  LConsulta: TUniQuery;
  LChave: string;
  LRegistro: TOCOBANRecord;
begin
  // Verifica se já está carregado com esses parâmetros
  if FCacheLoaded and (FUltimoCodBco = ACodigoBanco) and (FUltimoOpcNab = ACnab) then
    Exit;

  FCache.Clear;
  FUltimoCodBco := ACodigoBanco;
  FUltimoOpcNab := ACnab;

  LConsulta := fCriaQuery(Nil);
  try
    LConsulta.SQL.Text := 'SELECT        '+
                          '  OCO_CODOCO, '+
                          '  OCO_MOTIVO, '+
                          '  OCO_DESCRI, '+
                          '  OCO_CODBCO, '+
                          '  OCO_OPCNAB  '+
                          'FROM OCOBAN   '+
                          'WHERE OCO_CODBCO = :CODBCO AND '+
                          '      OCO_OPCNAB = :OPCNAB     ';


    LConsulta.ParamByName('CODBCO').AsString := ACodigoBanco;
    LConsulta.ParamByName('OPCNAB').AsString := ACnab;
    LConsulta.Open;

    while not LConsulta.Eof do
    begin
      LRegistro.OCO_CODOCO := LConsulta.FieldByName('OCO_CODOCO').AsString;
      LRegistro.OCO_MOTIVO := LConsulta.FieldByName('OCO_MOTIVO').AsString;
      LRegistro.OCO_DESCRI := LConsulta.FieldByName('OCO_DESCRI').AsString;
      LRegistro.OCO_CODBCO := LConsulta.FieldByName('OCO_CODBCO').AsString;
      LRegistro.OCO_OPCNAB := LConsulta.FieldByName('OCO_OPCNAB').AsString;

      LChave := GerarChave(LRegistro.OCO_CODOCO, LRegistro.OCO_CODBCO, LRegistro.OCO_OPCNAB);
      FCache.AddOrSetValue(LChave, LRegistro);

      LConsulta.Next;
    end;

    FCacheLoaded := True;
  finally
    LConsulta.Free;
  end;
end;

function TOCOBANCache.GerarChave(const ACodigoOcorrencia, ACodigoBanco, ACnab: string): string;
begin
  Result := ACodigoOcorrencia + '|' + ACodigoBanco + '|' + ACnab;
end;

function TOCOBANCache.ObterRegistro(const ACodigoOcorrencia, ACodigoBanco, ACnab: string;
  out ARegistro: TOCOBANRecord): Boolean;
var
  Chave: string;
begin
  // Garante que o cache está carregado com os parâmetros corretos
  CarregarCache(ACodigoBanco, ACnab);

  Chave := GerarChave(ACodigoOcorrencia, ACodigoBanco, ACnab);
  Result := FCache.TryGetValue(Chave, ARegistro);
end;

procedure TOCOBANCache.RecarregarCache(const ACodigoBanco, ACnab: string);
begin
  FCacheLoaded := False; // Força recarregar
  CarregarCache(ACodigoBanco, ACnab);
end;

class function TOCOBANCache.GetInstance: TOCOBANCache;
begin
  if not Assigned(FInstance) then
    FInstance := TOCOBANCache.Create;
  Result := FInstance;
end;

function ObterDescricaoOcorrencia(const ACodigoOcorrencia, ACodigoBanco, ACnab: string): string;
var
  Registro: TOCOBANRecord;
begin
  // Tenta obter do cache (que será criado/carregado se necessário)
  if TOCOBANCache.GetInstance.ObterRegistro(ACodigoOcorrencia, ACodigoBanco, ACnab, Registro) then
    Result := Registro.OCO_DESCRI
  else
    Result := 'OUTRAS';
end;

initialization

finalization
  if Assigned(TOCOBANCache.FInstance) then
    TOCOBANCache.FInstance.Free;

end.
