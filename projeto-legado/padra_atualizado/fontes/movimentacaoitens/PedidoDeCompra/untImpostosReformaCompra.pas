unit untImpostosReformaCompra;

interface

type
  TAliquotasReforma = record
    fltCbs: Double;
    fltIbs: Double;
    fltIs: Double;
    class function fCriar(const AfltCbs, AfltIbs, AfltIs: Double): TAliquotasReforma; static;
    class function fAliquotaValida(const AfltAliquota: Double): Boolean; static;
  end;

  TBaseReforma = record
    fltTotIte: Double;
    fltValFre: Double;
    fltDesAce: Double;
    fltValIcm: Double;
    fltValImp: Double;
    fltValPis: Double;
    fltValCof: Double;
    class function fCriar(const AfltTotIte, AfltValFre, AfltDesAce: Double): TBaseReforma; static;
    function fValor: Double;
  end;

  TValoresReforma = record
    fltCbs: Double;
    fltIbs: Double;
    fltIs: Double;
    function fTotal: Double;
  end;

  TSQLValoresReforma = record
    strCbs: String;
    strIbs: String;
    strIs: String;
    function fTotal: String;
  end;

  TCalculoReformaCompra = class
  private
    class function fArredonda(const AfltValor: Double; const AblnArredonda: Boolean): Double;
  public
    class function fCalcular(const ArecBase: TBaseReforma; const ArecAliquotas: TAliquotasReforma;
                             const AblnArredonda: Boolean): TValoresReforma;
    class function fSQLValores(const AstrBase, AstrAlqCbs, AstrAlqIbs, AstrAlqIs: String): TSQLValoresReforma;
  end;

implementation

uses
  Math;

{ TAliquotasReforma }

class function TAliquotasReforma.fCriar(const AfltCbs, AfltIbs, AfltIs: Double): TAliquotasReforma;
begin
  Result.fltCbs := AfltCbs;
  Result.fltIbs := AfltIbs;
  Result.fltIs  := AfltIs;
end;

class function TAliquotasReforma.fAliquotaValida(const AfltAliquota: Double): Boolean;
begin
  Result := InRange(AfltAliquota, 0, 100);
end;

{ TBaseReforma }

class function TBaseReforma.fCriar(const AfltTotIte, AfltValFre, AfltDesAce: Double): TBaseReforma;
begin
  Result.fltTotIte := AfltTotIte;
  Result.fltValFre := AfltValFre;
  Result.fltDesAce := AfltDesAce;
  Result.fltValIcm := 0;
  Result.fltValImp := 0;
  Result.fltValPis := 0;
  Result.fltValCof := 0;
end;

function TBaseReforma.fValor: Double;
begin
  // vBC do IBS/CBS (NT 2025.002-RTC v1.33, regra UB16-10) com os termos que existem no pedido e na
  // cotacao: vProd liquido de desconto + vFrete + vOutro (despesas acessorias) + vII - vPIS - vCOFINS - vICMS.
  // IPI e ICMS-ST nao entram (LC 214/2025, art. 12, par. 2).
  Result := Max(fltTotIte + fltValFre + fltDesAce + fltValImp - fltValPis - fltValCof - fltValIcm, 0);
end;

{ TValoresReforma }

function TValoresReforma.fTotal: Double;
begin
  Result := fltCbs + fltIbs + fltIs;
end;

{ TSQLValoresReforma }

function TSQLValoresReforma.fTotal: String;
begin
  Result := '(' + strIs + ' + ' + strCbs + ' + ' + strIbs + ')';
end;

{ TCalculoReformaCompra }

class function TCalculoReformaCompra.fArredonda(const AfltValor: Double; const AblnArredonda: Boolean): Double;
begin
  Result := AfltValor;
  If AblnArredonda Then
    Result := RoundTo(AfltValor, -2);
end;

class function TCalculoReformaCompra.fCalcular(const ArecBase: TBaseReforma; const ArecAliquotas: TAliquotasReforma;
                                               const AblnArredonda: Boolean): TValoresReforma;
var
  fltBase: Double;
begin
  // O IS integra a base do CBS/IBS (CF art. 153, par. 6, IV; LC 214/2025, art. 12, par. 1, V)
  fltBase := ArecBase.fValor;
  Result.fltIs  := fArredonda(fltBase * ArecAliquotas.fltIs / 100, AblnArredonda);
  Result.fltCbs := fArredonda((fltBase + Result.fltIs) * ArecAliquotas.fltCbs / 100, AblnArredonda);
  Result.fltIbs := fArredonda((fltBase + Result.fltIs) * ArecAliquotas.fltIbs / 100, AblnArredonda);
end;

class function TCalculoReformaCompra.fSQLValores(const AstrBase, AstrAlqCbs, AstrAlqIbs, AstrAlqIs: String): TSQLValoresReforma;
var
  strBase: String;
begin
  strBase := 'GREATEST(' + AstrBase + ', 0)';
  Result.strIs  := '(' + strBase + ' * ' + AstrAlqIs + ' / 100)';
  Result.strCbs := '((' + strBase + ' + ' + Result.strIs + ') * ' + AstrAlqCbs + ' / 100)';
  Result.strIbs := '((' + strBase + ' + ' + Result.strIs + ') * ' + AstrAlqIbs + ' / 100)';
end;

end.
