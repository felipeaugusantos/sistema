{*****************************************************************************************}
{* Interface que representa a implementação dos dados informados pelo usuario no momento *}
{* da venda                                                                              *}
{**************************************************************************************PH*}
unit untIDigDadosTintometricos;

interface

uses
  untIDataSet, untIDicionario, untISaldosColorantes;

type
  IDigDadosTintometricos = interface
    ['{9A121190-3492-4078-A003-CD48B91E9BFD}']
    function fDigDadosTintometricos(const dtsCadTin: IDataSet;
      const dicRetorno: IDicionario): Boolean;
    function GetDescricaoCor: String;
    function GetCodigoItem: String;
    function GetChaveIteTin: String;
    function GetUnidade: String;
    function GetPrecoVendaTinta: Double;
    function GetPrecoCustoTinta: Double;
    function GetSaldos: ISaldosColorantes;

    property DescricaoCor: String read GetDescricaoCor;
    property CodigoItem: String read GetCodigoItem;
    property ChaveIteTin: String read GetChaveIteTin;
    property Unidade: String read GetUnidade;
    property PrecoVendaTinta: Double read GetPrecoVendaTinta;
    property PrecoCustoTinta: Double read GetPrecoCustoTinta;
  end;

implementation

end.
