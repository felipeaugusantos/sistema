{*********************************************************************************}
{* Interface que representa um calculador de preços dos componentes de uma tinta *}
{******************************************************************************PH*}
unit untICalculadorFormula;

interface

type
  ICalculadorFormula = interface
    ['{1B0BE324-FF44-4CFC-A6C1-72B5B7DDCF4D}']
    procedure Calcular;
    procedure Zerar;

    //Imibiliaria
    function GetOutrosValores(): Double;
    function GetIcmsSaida(): Double;
    function GetImpostosFederais(): Double;
    function GetDespesasOperacionais(): Double;

    function GetPrecoMedio(): Double;
    function GetUltimoPrecoCompra(): Double;
    function GetUltimoPrecoCompraImpostos(): Double;
    function GetPrecoCompraLiquido(): Double;

    function GetPrecoCusto(): Double;
    function GetPrecoCustoReal(): Double;
    function GetPrecoVenda(): Double;

    property OutrosValores: Double read GetOutrosValores;
    property IcmsSaida: Double read GetIcmsSaida;
    property ImpostosFederais: Double read GetImpostosFederais;
    property DespesasOperacionais: Double read GetDespesasOperacionais;

    property PrecoMedio: Double read GetPrecoMedio;
    property UltimoPrecoCompra: Double read GetUltimoPrecoCompra;
    property UltimoPrecoCompraImpostos: Double read GetUltimoPrecoCompraImpostos;
    property PrecoCompraLiquido: Double read GetPrecoCompraLiquido;

    property PrecoCusto: Double read GetPrecoCusto;
    property PrecoCustoReal: Double read GetPrecoCustoReal;
    property PrecoVenda: Double read GetPrecoVenda;

  end;

Type
  ICalculadorFormulaAut = interface
    ['{6031B159-1446-46D5-A632-71B900224EEB}']
    procedure Calcular;
    procedure Zerar;

    //Concentrado
    function GetOutrosValoresCon(): Double;
    function GetIcmsSaidaCon(): Double;
    function GetImpostosFederaisCon(): Double;
    function GetDespesasOperacionaisCon(): Double;

    function GetPrecoMedioCon(): Double;
    function GetUltimoPrecoCompraCon(): Double;
    function GetUltimoPrecoCompraImpostosCon(): Double;
    function GetPrecoCompraLiquidoCon(): Double;

    function GetPrecoCustoCon(): Double;
    function GetPrecoCustoRealCon(): Double;
    function GetPrecoVendaCon(): Double;

    property OutrosValoresCon: Double read GetOutrosValoresCon;
    property IcmsSaidaCon: Double read GetIcmsSaidaCon;
    property ImpostosFederaisCon: Double read GetImpostosFederaisCon;
    property DespesasOperacionaisCon: Double read GetDespesasOperacionaisCon;

    property PrecoMedioCon: Double read GetPrecoMedioCon;
    property UltimoPrecoCompraCon: Double read GetUltimoPrecoCompraCon;
    property UltimoPrecoCompraImpostosCon: Double read GetUltimoPrecoCompraImpostosCon;
    property PrecoCompraLiquidoCon: Double read GetPrecoCompraLiquidoCon;

    property PrecoCustoCon: Double read GetPrecoCustoCon;
    property PrecoCustoRealCon: Double read GetPrecoCustoRealCon;
    property PrecoVendaCon: Double read GetPrecoVendaCon;

    //Diluido
    function GetOutrosValoresDil(): Double;
    function GetIcmsSaidaDil(): Double;
    function GetImpostosFederaisDil(): Double;
    function GetDespesasOperacionaisDil(): Double;

    function GetPrecoMedioDil(): Double;
    function GetUltimoPrecoCompraDil(): Double;
    function GetUltimoPrecoCompraImpostosDil(): Double;
    function GetPrecoCompraLiquidoDil(): Double;

    function GetPrecoCustoDil(): Double;
    function GetPrecoCustoRealDil(): Double;
    function GetPrecoVendaDil(): Double;

    property OutrosValoresDil: Double read GetOutrosValoresDil;
    property IcmsSaidaDil: Double read GetIcmsSaidaDil;
    property ImpostosFederaisDil: Double read GetImpostosFederaisDil;
    property DespesasOperacionaisDil: Double read GetDespesasOperacionaisDil;

    property PrecoMedioDil: Double read GetPrecoMedioDil;
    property UltimoPrecoCompraDil: Double read GetUltimoPrecoCompraDil;
    property UltimoPrecoCompraImpostosDil: Double read GetUltimoPrecoCompraImpostosDil;
    property PrecoCompraLiquidoDil: Double read GetPrecoCompraLiquidoDil;

    property PrecoCustoDil: Double read GetPrecoCustoDil;
    property PrecoCustoRealDil: Double read GetPrecoCustoRealDil;
    property PrecoVendaDil: Double read GetPrecoVendaDil;
  end;


implementation

end.
