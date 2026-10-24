unit Contabilidade.Interfaces.TAuditoriaLancamentos;

interface

uses
  Uni, UniClientDataSet, Data.DB, System.Generics.Collections,
  Contabilidade.Interfaces;

type
  TOperadorFiltro = (
    foIgual,        // =
    foDiferente,    // <>
    foMaior,        // >
    foMaiorIgual,   // >=
    foMenor,        // <
    foMenorIgual,   // <=
    foLike,         // LIKE
    foNotLike,      // NOT LIKE
    foEm,           // IN (...)
    foNaoEm,        // NOT IN (...)
    foEntre,        // BETWEEN x AND y
    foEhNulo,       // IS NULL
    foNaoEhNulo     // IS NOT NULL
  );

  TValoresArray = array of Variant;

  TParFiltroLog = record
    Coluna: string;
    Operador: TOperadorFiltro;
    Valor: Variant;
  end;
  TArrayFiltrosLog = TArray<TParFiltroLog>;

  TInfoColuna = record
    Tipo: TFieldType;
    Tamanho: Integer;
  end;
  TMapaColunas = TDictionary<string, TInfoColuna>;

  IAuditoriaLancamentosService = interface
    ['{1802F562-4365-44C6-9DA6-83DC89F01BED}']
    function fCarregarRegistrosAtuaisLancon(
      const AFiltros: TArrayFiltrosLog;
      const ATipo: TPesquisaLancamentoContabil): TUniQuery;
    function fCarregarLancamentosAlteradosLancon(
      const AAutoInc, AIncDoc: string): TUniClientDataSet;
    function fCarregarRegistroAtualParcon(const ASeqPar: String): TUniQuery;
    function fCarregarRegistrosAlteradosParcon(
      const ASeqPar: String): TUniClientDataSet;
    function fCarregarRegistroAtualParNco(const ASeqPar: String): TUniQuery;
    function fCarregarRegistrosAlteradosParNco(
      const ASeqPar: String): TUniClientDataSet;
    function fCarregarRegistroAtualCmpPar(const ASeqPar: String): TUniQuery;
    function fCarregarRegistrosAlteradosCmpPar(
      const ASeqPar: String): TUniClientDataSet;
    function fCarregarRegistroAtualPorNco(const ACodigo: String): TUniQuery;
    function fCarregarRegistrosAlteradosPorNco(
      const ACodigo: String): TUniClientDataSet;
    function fCarregarRegistroAtualCliNco(const ACodigo: String): TUniQuery;
    function fCarregarRegistrosAlteradosCliNco(
      const ACodigo: String): TUniClientDataSet;
    function fCarregarRegistroAtualForNco(const ACodigo: String): TUniQuery;
    function fCarregarRegistrosAlteradosForNco(
      const ACodigo: String): TUniClientDataSet;
    function fCarregarRegistroAtualBanNco(const ACodigo: String): TUniQuery;
    function fCarregarRegistrosAlteradosBanNco(
      const ACodigo: String): TUniClientDataSet;
    function fCarregarRegistroAtualCtaNco(const ACodigo: String): TUniQuery;
    function fCarregarRegistrosAlteradosCtaNco(
      const ACodigo: String): TUniClientDataSet;
  end;

  TParFiltroLogHelper = record helper for TParFiltroLog
    class function Igual       (const AColuna: string; const AValor: Variant): TParFiltroLog; static;
    class function Diferente   (const AColuna: string; const AValor: Variant): TParFiltroLog; static;
    class function Maior       (const AColuna: string; const AValor: Variant): TParFiltroLog; static;
    class function MaiorIgual  (const AColuna: string; const AValor: Variant): TParFiltroLog; static;
    class function Menor       (const AColuna: string; const AValor: Variant): TParFiltroLog; static;
    class function MenorIgual  (const AColuna: string; const AValor: Variant): TParFiltroLog; static;
    class function Like        (const AColuna: string; const APadrao: string): TParFiltroLog; static;
    class function NotLike     (const AColuna: string; const APadrao: string): TParFiltroLog; static;
    class function Contem      (const AColuna: string; const AValor: string): TParFiltroLog; static;
    class function ComecaCom   (const AColuna: string; const AValor: string): TParFiltroLog; static;
    class function Em          (const AColuna: string; const AValores: TValoresArray): TParFiltroLog; static;
    class function NaoEm       (const AColuna: string; const AValores: TValoresArray): TParFiltroLog; static;
    class function Entre       (const AColuna: string; const AInicio, AFim: Variant): TParFiltroLog; static;
    class function EhNulo      (const AColuna: string): TParFiltroLog; static;
    class function NaoEhNulo   (const AColuna: string): TParFiltroLog; static;
  end;

implementation

uses
  Variants, SysUtils;

{ TParFiltroLogHelper }

class function TParFiltroLogHelper.ComecaCom(const AColuna,
  AValor: string): TParFiltroLog;
begin
  Result.Coluna   := AColuna;
  Result.Operador := foLike;
  Result.Valor    := AValor + '%';
end;

class function TParFiltroLogHelper.Contem(const AColuna,
  AValor: string): TParFiltroLog;
begin
  Result.Coluna   := AColuna;
  Result.Operador := foLike;
  Result.Valor    := '%' + AValor + '%';
end;

class function TParFiltroLogHelper.Diferente(const AColuna: string;
  const AValor: Variant): TParFiltroLog;
begin
  Result.Coluna   := AColuna;
  Result.Operador := foDiferente;
  Result.Valor    := AValor;
end;

class function TParFiltroLogHelper.EhNulo(const AColuna: string): TParFiltroLog;
begin
  Result.Coluna   := AColuna;
  Result.Operador := foEhNulo;
  Result.Valor    := Null;
end;

class function TParFiltroLogHelper.Em(const AColuna: string;
  const AValores: TValoresArray): TParFiltroLog;
var
  LArr: Variant;
  LCnt: Integer;
begin
  LArr := VarArrayCreate([0, High(AValores)], varVariant);
  for LCnt := 0 to High(AValores) do
  begin
    LArr[LCnt] := AValores[LCnt];
  end;

  Result.Coluna   := AColuna;
  Result.Operador := foEm;
  Result.Valor    := LArr;
end;

class function TParFiltroLogHelper.Entre(const AColuna: string; const AInicio,
  AFim: Variant): TParFiltroLog;
var
  LArr: Variant;
begin
  LArr := VarArrayCreate([0, 1], varVariant);
  LArr[0] := AInicio;
  LArr[1] := AFim;

  Result.Coluna   := AColuna;
  Result.Operador := foEntre;
  Result.Valor    := LArr;
end;

class function TParFiltroLogHelper.Igual(const AColuna: string;
  const AValor: Variant): TParFiltroLog;
begin
  Result.Coluna   := AColuna;
  Result.Operador := foIgual;
  Result.Valor    := AValor;
end;

class function TParFiltroLogHelper.Like(const AColuna,
  APadrao: string): TParFiltroLog;
begin
  Result.Coluna   := AColuna;
  Result.Operador := foLike;
  Result.Valor    := APadrao;  // caller controla os '%'
end;

class function TParFiltroLogHelper.Maior(const AColuna: string;
  const AValor: Variant): TParFiltroLog;
begin
  Result.Coluna   := AColuna;
  Result.Operador := foMaior;
  Result.Valor    := AValor;
end;

class function TParFiltroLogHelper.MaiorIgual(const AColuna: string;
  const AValor: Variant): TParFiltroLog;
begin
  Result.Coluna   := AColuna;
  Result.Operador := foMaiorIgual;
  Result.Valor    := AValor;
end;

class function TParFiltroLogHelper.Menor(const AColuna: string;
  const AValor: Variant): TParFiltroLog;
begin
  Result.Coluna   := AColuna;
  Result.Operador := foMenor;
  Result.Valor    := AValor;
end;

class function TParFiltroLogHelper.MenorIgual(const AColuna: string;
  const AValor: Variant): TParFiltroLog;
begin
  Result.Coluna   := AColuna;
  Result.Operador := foMenorIgual;
  Result.Valor    := AValor;
end;

class function TParFiltroLogHelper.NaoEhNulo(
  const AColuna: string): TParFiltroLog;
begin
  Result.Coluna   := AColuna;
  Result.Operador := foNaoEhNulo;
  Result.Valor    := Null;
end;

class function TParFiltroLogHelper.NaoEm(const AColuna: string;
  const AValores: TValoresArray): TParFiltroLog;
var
  LArr: Variant;
  LCnt: Integer;
begin
  if Length(AValores) = 0 then
    raise Exception.CreateFmt(
      'Filtro NOT IN em "%s" requer ao menos um valor.', [AColuna]);

  LArr := VarArrayCreate([0, High(AValores)], varVariant);
  for LCnt := 0 to High(AValores) do
    LArr[LCnt] := AValores[LCnt];

  Result.Coluna   := AColuna;
  Result.Operador := foNaoEm;
  Result.Valor    := LArr;
end;

class function TParFiltroLogHelper.NotLike(const AColuna,
  APadrao: string): TParFiltroLog;
begin
  Result.Coluna   := AColuna;
  Result.Operador := foNotLike;
  Result.Valor    := APadrao;  // caller controla os '%'
end;

end.
