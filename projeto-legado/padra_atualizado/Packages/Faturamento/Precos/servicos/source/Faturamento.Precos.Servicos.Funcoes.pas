unit Faturamento.Precos.Servicos.Funcoes;

interface

uses Shared.Functions.Types, Shared.Functions.Core, Shared.Functions.DataSet,
  Shared.Functions.SQL, Shared.Functions.Funcoes.Faturamento.Precos,
  Shared.Functions.Interfaces, Shared.Functions.Tipos;

type
  TFaturamentoPrecosServicosFuncoes = class
  private
  public
    class function ConvertePrecos(fltPreAtu: Double; moeTipMoe: TTipoMoeda; intDecUni: Integer = 2): Double;
  end;

implementation

{ TFaturamentoPrecosServicosFuncoes }

class function TFaturamentoPrecosServicosFuncoes.ConvertePrecos(
  fltPreAtu: Double; moeTipMoe: TTipoMoeda; intDecUni: Integer): Double;
var
  LMyCampoTabela: IMyCampoTabela;
  LParametrosMoeda: IParametrosMoedaConvertePrecos;
begin
  LMyCampoTabela := objCore.fCampoTabelaDados(TFunctionsSQL.GetSelectConvertePrecos);

  LParametrosMoeda :=
    TParametrosMoedaConvertePrecos.New
      .ValorDolarVenda(LMyCampoTabela.FieldByName('MOE_DOLVEN').AsFloat)
      .ValorRealVenda(LMyCampoTabela.FieldByName('MOE_REAVEN').AsFloat)
      .ValorPesoVenda(LMyCampoTabela.FieldByName('MOE_PARVEN').AsFloat)
      .ValorEuroVenda(LMyCampoTabela.FieldByName('MOE_EURVEN').AsFloat);

  Result :=
    TFunctionFuncoesFaturamentoPrecos
      .RegraConvertePrecos(LParametrosMoeda, fltPreAtu, moeTipMoe, intDecUni);
end;

end.
