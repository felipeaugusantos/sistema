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

    function GetOutrosValores(): Double;
    function GetIcmsSaida(): Double;
    function GetImpostosFederais(): Double;
    function GetDespesasOperacionais(): Double;
    function GetPrecoCusto(): Double;
    function GetPrecoCustoReal(): Double;
    function GetPrecoVenda(): Double;

    property OutrosValores: Double read GetOutrosValores;
    property IcmsSaida: Double read GetIcmsSaida;
    property ImpostosFederais: Double read GetImpostosFederais;
    property DespesasOperacionais: Double read GetDespesasOperacionais;
    property PrecoCusto: Double read GetPrecoCusto;
    property PrecoCustoReal: Double read GetPrecoCustoReal;
    property PrecoVenda: Double read GetPrecoVenda;
  end;

implementation

end.
