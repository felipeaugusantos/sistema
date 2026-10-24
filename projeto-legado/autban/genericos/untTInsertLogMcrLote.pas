unit untTInsertLogMcrLote;

interface

uses
  System.Generics.Collections, System.SysUtils, Data.DB, Uni, Math, DateUtils;

type
  TLogMcrRecord = record
    AutoIncrem: string;
    AutoIncremContasReceber: string;
    SequencialMovimentacaoBancaria: string;
    EmpresaMovimentacaoBancaria: string;
    Descricao: string;
    NomeFormulario: string;
  end;

  TInseridorLogMcrLote = class
  private
    class var FInstancia: TInseridorLogMcrLote;
    FRegistrosParaInserir: TList<TLogMcrRecord>;
    FTamanhoMaximoLote: Integer;
    procedure ExecutarInsercaoEmLote(const ARegistros: TArray<TLogMcrRecord>);
    function GerarClausulaValues(const ARegistros: TArray<TLogMcrRecord>): string;
    function GetTamanhoLote: Integer;
    procedure SetTamanhoLote(const Value: Integer);
    function FormatDateTimeForSQL(ADate: TDate): string;
    function FormatTimeForSQL(ATime: TTime): string;
  public
    constructor Create;
    destructor Destroy; override;
    procedure AdicionarParaInserir(const AAutoIncremContasReceber,
                                         ASequencialMovimentacaoBancaria,
                                         AEmpresaMovimentacaoBancaria,
                                         ADescricao,
                                         ANomeFormulario: string);
    procedure ExecutarTodasPendentes;
    procedure LimparPendentes;
    function QuantidadePendente: Integer;
    class function ObterInstancia: TInseridorLogMcrLote;
    class procedure DestruirInstancia;
    property TamanhoLote: Integer read GetTamanhoLote write SetTamanhoLote;
  end;

implementation

uses
  untFuncoesSimples;

{ TInseridorLogMcrLote }

constructor TInseridorLogMcrLote.Create;
begin
  inherited;
  FRegistrosParaInserir := TList<TLogMcrRecord>.Create;
  FTamanhoMaximoLote := 200; // Tamanho padrão do lote
end;

destructor TInseridorLogMcrLote.Destroy;
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

class procedure TInseridorLogMcrLote.DestruirInstancia;
begin
  FreeAndNil(FInstancia);
end;

procedure TInseridorLogMcrLote.AdicionarParaInserir(
  const AAutoIncremContasReceber, ASequencialMovimentacaoBancaria,
  AEmpresaMovimentacaoBancaria, ADescricao, ANomeFormulario: String);
var
  LRegistro: TLogMcrRecord;
begin
  try
    LRegistro.AutoIncrem :=  'fRetAutoIncrem("LOGMCR", "'+ VS_strCodEmp +'")';
    LRegistro.AutoIncremContasReceber := AAutoIncremContasReceber;
    LRegistro.SequencialMovimentacaoBancaria := ASequencialMovimentacaoBancaria;
    LRegistro.EmpresaMovimentacaoBancaria := AEmpresaMovimentacaoBancaria;
    LRegistro.Descricao := ADescricao;
    LRegistro.NomeFormulario := ANomeFormulario;

    FRegistrosParaInserir.Add(LRegistro);

    if FRegistrosParaInserir.Count >= FTamanhoMaximoLote then
      ExecutarTodasPendentes;
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
end;

procedure TInseridorLogMcrLote.ExecutarTodasPendentes;
var
  LInicio, LFim, LI: Integer;
  LLote: TArray<TLogMcrRecord>;
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

procedure TInseridorLogMcrLote.ExecutarInsercaoEmLote(const ARegistros: TArray<TLogMcrRecord>);
var
  LInsert: TUniQuery;
begin
  if Length(ARegistros) = 0 then
    Exit;

  LInsert := fCriaQuery(nil);

  try
    try
      LInsert.SQL.Text := 'INSERT INTO LOGMCR (  '+
                          '  AUTOINCREM,         '+
                          '  MOV_AUTCTR,         '+
                          '  MOV_SEQCTB,         '+
                          '  MOV_EMPCTB,         '+
                          '  MOV_DESCRI,         '+
                          '  MOV_NOMFRM,         '+
                          '  MOV_DTALOG,         '+
                          '  MOV_HORLOG,         '+
                          '  MOV_OPELOG          '+
                          ')      '+
                          'VALUES '+ GerarClausulaValues(ARegistros);

      LInsert.ExecSQL;
    except
      on E: Exception do
        Raise Exception.Create(E.Message);
    end;
  finally
    FreeAndNil(LInsert);
  end;
end;

function TInseridorLogMcrLote.GerarClausulaValues(const ARegistros: TArray<TLogMcrRecord>): string;
var
  LContador: Integer;
  LHoraAlteracao: TTime;
begin
  Result := '';
  LHoraAlteracao := fRetHoraServidor;

  for LContador := 0 to High(ARegistros) do
  begin
    if LContador > 0 then
      Result := Result + ', ';

    Result := Result + Format(
      '(%s, %s, %s, %s, %s, %s, %s, %s, %s)',
      [
        ARegistros[LContador].AutoIncrem,
        QuotedStr(ARegistros[LContador].AutoIncremContasReceber),
        QuotedStr(ARegistros[LContador].SequencialMovimentacaoBancaria),
        QuotedStr(ARegistros[LContador].EmpresaMovimentacaoBancaria),
        QuotedStr(ARegistros[LContador].Descricao),
        QuotedStr(ARegistros[LContador].NomeFormulario),
        FormatDateTimeForSQL(VS_Date),
        QuotedStr(FormatTimeForSQL(LHoraAlteracao)),
        QuotedStr(strLoginUsuarioLogado)
      ]);
  end;
end;

function TInseridorLogMcrLote.FormatDateTimeForSQL(ADate: TDate): string;
begin
  Result := FormatDateTime('YYYY-MM-DD', ADate);
  Result := QuotedStr(Result);
end;

function TInseridorLogMcrLote.FormatTimeForSQL(ATime: TTime): string;
begin
  Result := FormatDateTime('HH:NN:SS', ATime);
end;

function TInseridorLogMcrLote.GetTamanhoLote: Integer;
begin
  Result := FTamanhoMaximoLote;
end;

procedure TInseridorLogMcrLote.LimparPendentes;
begin
  try
    FRegistrosParaInserir.Clear;
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  end;
end;

function TInseridorLogMcrLote.QuantidadePendente: Integer;
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

procedure TInseridorLogMcrLote.SetTamanhoLote(const Value: Integer);
begin
  FTamanhoMaximoLote := Value;
end;

class function TInseridorLogMcrLote.ObterInstancia: TInseridorLogMcrLote;
begin
  if not Assigned(FInstancia) then
    FInstancia := TInseridorLogMcrLote.Create;
  Result := FInstancia;
end;

initialization

finalization
  if Assigned(TInseridorLogMcrLote.FInstancia) then
    FreeAndNil(TInseridorLogMcrLote.FInstancia);

end.
