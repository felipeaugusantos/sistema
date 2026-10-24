unit untTUpdateDupCobLote;

interface

uses
  System.Generics.Collections, System.SysUtils, Data.DB, Uni, Math;

type
  TAtualizadorDupCobLote = class
  private
    class var FInstancia: TAtualizadorDupCobLote;
    FSequenciasCobranca: TList<string>;
    FTamanhoMaximoLote: Integer;
    procedure ExecutarAtualizacaoEmLote(const ASequencias: TArray<string>);
    function GerarClausulaIN(const ASequencias: TArray<string>): string;
    function GetTamanhoLote: Integer;
    procedure SetTamanhoLote(const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AdicionarParaAtualizar(const ASequenciaCobranca: string);
    procedure ExecutarTodasPendentes;
    procedure LimparPendentes;
    function QuantidadePendente: Integer;
    class function ObterInstancia: TAtualizadorDupCobLote;
    class procedure DestruirInstancia;
    property TamanhoLote: Integer read GetTamanhoLote write SetTamanhoLote;
  end;

implementation

uses
  untFuncoesSimples;

{ TAtualizadorDupCobLote }

constructor TAtualizadorDupCobLote.Create;
begin
  inherited;
  FSequenciasCobranca := TList<string>.Create;
  FTamanhoMaximoLote := 200;
end;

destructor TAtualizadorDupCobLote.Destroy;
begin
  try
    ExecutarTodasPendentes;
    FreeAndNil(FSequenciasCobranca);
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
  inherited;
end;

class procedure TAtualizadorDupCobLote.DestruirInstancia;
begin
  FreeAndNil(FInstancia);
end;

procedure TAtualizadorDupCobLote.AdicionarParaAtualizar(const ASequenciaCobranca: string);
begin
  try
    FSequenciasCobranca.Add(ASequenciaCobranca);

    {if FSequenciasCobranca.Count >= FTamanhoMaximoLote then
      ExecutarTodasPendentes;}
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
end;

procedure TAtualizadorDupCobLote.ExecutarTodasPendentes;
var
  LInicio, LFim, LI: Integer;
  LLote: TArray<string>;
begin
  try
    if (FSequenciasCobranca.Count = 0) then
      Exit;

    LInicio := 0;
    while LInicio < FSequenciasCobranca.Count do
    begin
      LFim := Min(LInicio + FTamanhoMaximoLote, FSequenciasCobranca.Count) - 1;
      SetLength(LLote, LFim - LInicio + 1);

      for LI := LInicio to LFim do
        LLote[LI - LInicio] := FSequenciasCobranca[LI];

      ExecutarAtualizacaoEmLote(LLote);
      LInicio := LFim + 1;
    end;

    LimparPendentes;
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
end;

procedure TAtualizadorDupCobLote.ExecutarAtualizacaoEmLote(const ASequencias: TArray<string>);
var
  LUpdate: TUniQuery;
begin
  if Length(ASequencias) = 0 then
    Exit;

  LUpdate := fCriaQuery(nil);
  try
    try


      LUpdate.SQL.Text :=  'UPDATE                               '+
                           ' CADCOB                              '+
                           ' JOIN DUPCOB                         '+
                           '   ON CADCOB.AUTOINCREM = DUP_SEQCOB '+
                           ' SET COB_BAIXAD = "S",               '+
                           '     COB_OPEBAI = :OPEBAI            '+
                           'WHERE DUP_SEQDUP IN(' + GerarClausulaIN(ASequencias) + ')';

      LUpdate.ParamByName('OPEBAI').AsString := strLoginUsuarioLogado;

      LUpdate.ExecSQL;
    except
      on E: Exception do
        Raise Exception.Create('Erro ao atualizar CADCOB em lote: ' + E.Message);
    end;
  finally
    FreeAndNil(LUpdate);
  end;
end;

function TAtualizadorDupCobLote.GerarClausulaIN(const ASequencias: TArray<string>): string;
var
  LContador: Integer;
begin
  Result := '';
  for LContador := 0 to High(ASequencias) do
  begin
    if LContador > 0 then
      Result := Result + ', ';

    Result := Result + QuotedStr(ASequencias[LContador]);
  end;
end;

function TAtualizadorDupCobLote.GetTamanhoLote: Integer;
begin
  Result := FTamanhoMaximoLote;
end;

procedure TAtualizadorDupCobLote.LimparPendentes;
begin
  try
    FSequenciasCobranca.Clear;
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
end;

function TAtualizadorDupCobLote.QuantidadePendente: Integer;
begin
  try
    Result := FSequenciasCobranca.Count;
  except
    on E: Exception do
    begin
      Raise Exception.Create(E.Message);
      Result := 0;
    end;
  end;
end;

procedure TAtualizadorDupCobLote.SetTamanhoLote(const Value: Integer);
begin
  FTamanhoMaximoLote := Value;
end;

class function TAtualizadorDupCobLote.ObterInstancia: TAtualizadorDupCobLote;
begin
  if not Assigned(FInstancia) then
    FInstancia := TAtualizadorDupCobLote.Create;
  Result := FInstancia;
end;

initialization

finalization
  if Assigned(TAtualizadorDupCobLote.FInstancia) then
    FreeAndNil(TAtualizadorDupCobLote.FInstancia);

end.
