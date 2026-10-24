unit untTInsertMovCtrLote;

interface

uses
  System.Generics.Collections, System.SysUtils, Data.DB, Uni, Math;

type
  TMovCtrRecord = record
    AutoIncrem: string;
    AutoIncremContasReceber: string;
    SequencialMovimentacaoBancaria: string;
    EmpresaMovimentacaoBancaria: string;
  end;

  TInseridorMovCtrLote = class
  private
    class var FInstancia: TInseridorMovCtrLote;
    FRegistrosParaInserir: TList<TMovCtrRecord>;
    FTamanhoMaximoLote: Integer;
    procedure ExecutarInsercaoEmLote(const ARegistros: TArray<TMovCtrRecord>);
    function GerarClausulaValues(const ARegistros: TArray<TMovCtrRecord>): string;
    function GetTamanhoLote: Integer;
    procedure SetTamanhoLote(const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AdicionarParaInserir(const AAutoIncremContasReceber, ASequencialMovimentacaoBancaria, AEmpresaMovimentacaoBancaria: string);
    procedure ExecutarTodasPendentes;
    procedure LimparPendentes;
    function QuantidadePendente: Integer;
    class function ObterInstancia: TInseridorMovCtrLote;
    class procedure DestruirInstancia;
    property TamanhoLote: Integer read GetTamanhoLote write SetTamanhoLote;
  end;

implementation

uses
  untFuncoesSimples;

{ TInseridorMovCtrLote }

constructor TInseridorMovCtrLote.Create;
begin
  inherited;
  FRegistrosParaInserir := TList<TMovCtrRecord>.Create;
  FTamanhoMaximoLote := 200;
end;

destructor TInseridorMovCtrLote.Destroy;
begin
  try
    ExecutarTodasPendentes;
    FreeAndNil(FRegistrosParaInserir);
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
  inherited;
end;

class procedure TInseridorMovCtrLote.DestruirInstancia;
begin
  FreeAndNil(FInstancia);
end;

procedure TInseridorMovCtrLote.AdicionarParaInserir(const AAutoIncremContasReceber,
                                                          ASequencialMovimentacaoBancaria,
                                                          AEmpresaMovimentacaoBancaria: string);
var
  LRegistro: TMovCtrRecord;
begin
  try
    LRegistro.AutoIncrem := 'fRetAutoIncrem("MOVCTR", "'+ VS_strCodEmp +'")';
    LRegistro.AutoIncremContasReceber := AAutoIncremContasReceber;
    LRegistro.SequencialMovimentacaoBancaria := ASequencialMovimentacaoBancaria;
    LRegistro.EmpresaMovimentacaoBancaria := AEmpresaMovimentacaoBancaria;

    FRegistrosParaInserir.Add(LRegistro);

    if FRegistrosParaInserir.Count >= FTamanhoMaximoLote then
      ExecutarTodasPendentes;
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
end;

procedure TInseridorMovCtrLote.ExecutarTodasPendentes;
var
  LInicio, LFim, LI: Integer;
  LLote: TArray<TMovCtrRecord>;
begin
  try
    if FRegistrosParaInserir.Count = 0 then
      Exit;

    LInicio := 0;
    while LInicio < FRegistrosParaInserir.Count do
    begin
      LFim := Min(LInicio + FTamanhoMaximoLote, FRegistrosParaInserir.Count) - 1;
      SetLength(LLote, LFim - LInicio + 1);

      for LI := LInicio to LFim do
        LLote[LI - LInicio] := FRegistrosParaInserir[LI];

      ExecutarInsercaoEmLote(LLote);
      LInicio := LFim + 1;
    end;

    LimparPendentes;
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
end;

procedure TInseridorMovCtrLote.ExecutarInsercaoEmLote(const ARegistros: TArray<TMovCtrRecord>);
var
  LInsert: TUniQuery;
begin
  if Length(ARegistros) = 0 then
    Exit;

  LInsert := fCriaQuery(nil);

  try
    try
      LInsert.SQL.Text := 'INSERT INTO MOVCTR ' +
                          '(AUTOINCREM, MOV_AUTCTR, MOV_SEQCTB, MOV_EMPCTB) ' +
                          'VALUES ' + GerarClausulaValues(ARegistros);

      LInsert.ExecSQL;

    except
      on E: Exception do
        Raise Exception.Create(E.Message);
    end;
  finally
    FreeAndNil(LInsert);
  end;
end;

function TInseridorMovCtrLote.GerarClausulaValues(const ARegistros: TArray<TMovCtrRecord>): string;
var
  LContador: Integer;
begin
  Result := '';
  for LContador := 0 to High(ARegistros) do
  begin
    if LContador > 0 then
      Result := Result + ', ';

    Result := Result + Format(
      '(%s, %s, %s, %s)',
      [
        ARegistros[LContador].AutoIncrem,
        QuotedStr(ARegistros[LContador].AutoIncremContasReceber),
        QuotedStr(ARegistros[LContador].SequencialMovimentacaoBancaria),
        QuotedStr(ARegistros[LContador].EmpresaMovimentacaoBancaria)
      ]);
  end;
end;

function TInseridorMovCtrLote.GetTamanhoLote: Integer;
begin
  Result := FTamanhoMaximoLote;
end;

procedure TInseridorMovCtrLote.LimparPendentes;
begin
  try
    FRegistrosParaInserir.Clear;
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
end;

function TInseridorMovCtrLote.QuantidadePendente: Integer;
begin
  try
    Result := FRegistrosParaInserir.Count;
  except
    on E: Exception do
    begin
      Raise Exception.Create(E.Message);
      Result := 0;
    end;
  end;
end;

procedure TInseridorMovCtrLote.SetTamanhoLote(const Value: Integer);
begin
  FTamanhoMaximoLote := Value;
end;

class function TInseridorMovCtrLote.ObterInstancia: TInseridorMovCtrLote;
begin
  if not Assigned(FInstancia) then
    FInstancia := TInseridorMovCtrLote.Create;
  Result := FInstancia;
end;

initialization

finalization
  if Assigned(TInseridorMovCtrLote.FInstancia) then
    FreeAndNil(TInseridorMovCtrLote.FInstancia);

end.
