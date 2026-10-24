unit Contabilidade.Util.FiltrosLogBuilder;

interface

uses
  System.SysUtils,
  System.Variants,
  System.StrUtils,
  Uni,
  Contabilidade.Interfaces.TAuditoriaLancamentos;

type
  TFiltroLogBuilder = class
  private
    class function fColunaPermitida(const ANome: string;
      const APermitidas: array of string): Boolean; static;
    class function fValorParaArray(const AValor: Variant): TArray<Variant>; static;
  public
    class function fMontarWhere(const APrefixoTabela: string;
      const AFiltros: TArrayFiltrosLog;
      const AColunasPermitidas: array of string): string; static;

    class procedure pAplicarParametros(AQry: TUniQuery;
      const AFiltros: TArrayFiltrosLog); static;
  end;

implementation

class function TFiltroLogBuilder.fColunaPermitida(const ANome: string;
  const APermitidas: array of string): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := Low(APermitidas) to High(APermitidas) do
    if SameText(ANome, APermitidas[i]) then
      Exit(True);
end;

class function TFiltroLogBuilder.fValorParaArray(
  const AValor: Variant): TArray<Variant>;
var
  i, LLow, LHigh: Integer;
begin
  if VarIsArray(AValor) then
  begin
    LLow  := VarArrayLowBound(AValor, 1);
    LHigh := VarArrayHighBound(AValor, 1);
    SetLength(Result, LHigh - LLow + 1);
    for i := LLow to LHigh do
      Result[i - LLow] := AValor[i];
  end
  else
  begin
    SetLength(Result, 1);
    Result[0] := AValor;
  end;
end;

class function TFiltroLogBuilder.fMontarWhere(const APrefixoTabela: string;
  const AFiltros: TArrayFiltrosLog;
  const AColunasPermitidas: array of string): string;
var
  i, j: Integer;
  LParte, LPrefixo: string;
  LValores: TArray<Variant>;
  LTermos: TArray<string>;
begin
  Result := '';

  LPrefixo := '';
  if Trim(APrefixoTabela) <> '' then
    LPrefixo := APrefixoTabela + '.';

  for i := 0 to High(AFiltros) do
  begin
    if not fColunaPermitida(AFiltros[i].Coluna, AColunasPermitidas) then
      raise Exception.CreateFmt(
        'Coluna "%s" nao permitida no filtro.', [AFiltros[i].Coluna]);

    case AFiltros[i].Operador of
      foIgual:       LParte := Format('%s%s = :P%d',        [LPrefixo, AFiltros[i].Coluna, i]);
      foDiferente:   LParte := Format('%s%s <> :P%d',       [LPrefixo, AFiltros[i].Coluna, i]);
      foMaior:       LParte := Format('%s%s > :P%d',        [LPrefixo, AFiltros[i].Coluna, i]);
      foMaiorIgual:  LParte := Format('%s%s >= :P%d',       [LPrefixo, AFiltros[i].Coluna, i]);
      foMenor:       LParte := Format('%s%s < :P%d',        [LPrefixo, AFiltros[i].Coluna, i]);
      foMenorIgual:  LParte := Format('%s%s <= :P%d',       [LPrefixo, AFiltros[i].Coluna, i]);
      foLike:        LParte := Format('%s%s LIKE :P%d',     [LPrefixo, AFiltros[i].Coluna, i]);
      foNotLike:     LParte := Format('%s%s NOT LIKE :P%d', [LPrefixo, AFiltros[i].Coluna, i]);

      foEm, foNaoEm:
        begin
          LValores := fValorParaArray(AFiltros[i].Valor);
          if Length(LValores) = 0 then
            raise Exception.CreateFmt('Filtro IN/NOT IN em "%s" sem valores.',
              [AFiltros[i].Coluna]);

          SetLength(LTermos, Length(LValores));
          for j := 0 to High(LValores) do
            LTermos[j] := Format(':P%d_%d', [i, j]);

          if AFiltros[i].Operador = foEm then
            LParte := Format('%s%s IN (%s)',
              [LPrefixo, AFiltros[i].Coluna, string.Join(', ', LTermos)])
          else
            LParte := Format('%s%s NOT IN (%s)',
              [LPrefixo, AFiltros[i].Coluna, string.Join(', ', LTermos)]);
        end;

      foEntre:
        LParte := Format('%s%s BETWEEN :P%d_INI AND :P%d_FIM',
                         [LPrefixo, AFiltros[i].Coluna, i, i]);

      foEhNulo:      LParte := Format('%s%s IS NULL',       [LPrefixo, AFiltros[i].Coluna]);
      foNaoEhNulo:   LParte := Format('%s%s IS NOT NULL',   [LPrefixo, AFiltros[i].Coluna]);
    else
      raise Exception.Create('Operador de filtro nao suportado.');
    end;

    if Result = '' then
      Result := LParte
    else
      Result := Result + ' AND ' + LParte;
  end;
end;

class procedure TFiltroLogBuilder.pAplicarParametros(AQry: TUniQuery;
  const AFiltros: TArrayFiltrosLog);
var
  i, j: Integer;
  LValores: TArray<Variant>;
begin
  for i := 0 to High(AFiltros) do
  begin
    case AFiltros[i].Operador of
      foIgual, foDiferente, foMaior, foMaiorIgual,
      foMenor, foMenorIgual, foLike, foNotLike:
        AQry.ParamByName(Format('P%d', [i])).Value := AFiltros[i].Valor;

      foEm, foNaoEm:
        begin
          LValores := fValorParaArray(AFiltros[i].Valor);
          for j := 0 to High(LValores) do
            AQry.ParamByName(Format('P%d_%d', [i, j])).Value := LValores[j];
        end;

      foEntre:
        begin
          LValores := fValorParaArray(AFiltros[i].Valor);
          if Length(LValores) <> 2 then
            raise Exception.CreateFmt(
              'Filtro BETWEEN em "%s" requer exatamente 2 valores.',
              [AFiltros[i].Coluna]);
          AQry.ParamByName(Format('P%d_INI', [i])).Value := LValores[0];
          AQry.ParamByName(Format('P%d_FIM', [i])).Value := LValores[1];
        end;

      foEhNulo, foNaoEhNulo:
        ; // operadores sem parametro
    end;
  end;
end;

end.
