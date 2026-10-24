{*****************************************************************************************************************}
{*  Interface resposável por alguns metodos utilizados no fatvendas, sessa maneira é possivel passar o fatvendas *}
{*  para as outras dll do sistema, sem que todas as dependencias de units sejam adicionadas ao projeto           *}
{**************************************************************************************************************AC*}
unit untICalculadorFatVendasLibTintas;

interface

uses
  DB,Uni;

type
  ICalculadorFatVendasLibTintas = interface
    ['{3ADDA3FC-BC0A-4727-B6D3-2B9DD2C1648A}']
    function fCalculaAliquota(strCodIte, strImpDir: String): Double;

  end;


implementation

end.
