unit Shared.Functions.Funcoes.Faturamento.Precos;

interface

uses Shared.Functions.Types, Shared.Functions.Interfaces, Shared.Functions.Core;

type
  TFunctionFuncoesFaturamentoPrecos = class
  private
  public
    class function RegraConvertePrecos(AParametrosMoeda: IParametrosMoedaConvertePrecos; fltPreAtu: Double; moeTipMoe: TTipoMoeda; intDecUni: Integer = 2): Double;
  end;

implementation

{ TFunctionFuncoesFaturamentoPrecos }

class function TFunctionFuncoesFaturamentoPrecos.RegraConvertePrecos(
  AParametrosMoeda: IParametrosMoedaConvertePrecos; fltPreAtu: Double;
  moeTipMoe: TTipoMoeda; intDecUni: Integer): Double;
begin
  Result := 0;

  Case moeTipMoe Of
    moeDolar : Result := objCore.fFormataFloat(fltPreAtu * AParametrosMoeda.ValorDolarVenda, intDecUni);
    moeReal  : Result := objCore.fFormataFloat(fltPreAtu * AParametrosMoeda.ValorRealVenda, intDecUni);
    moePeso  : Result := objCore.fFormataFloat(fltPreAtu * AParametrosMoeda.ValorPesoVenda, intDecUni);
    moeEuro  : Result := objCore.fFormataFloat(fltPreAtu * AParametrosMoeda.ValorEuroVenda, intDecUni);
  End;
end;

end.
