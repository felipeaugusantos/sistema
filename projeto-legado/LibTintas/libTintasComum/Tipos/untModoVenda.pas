{*********************************************************************************************}
{* Modo de vendas automotivas do sistema, caso seja necessário acresentar mais um tipo,      *}
{* basta adicionar mais uma constante com o prefixo tt, e somar + 1 ao anterior              *}
{******************************************************************************************AC*}
unit untModoVenda;

interface

const
  mvConcentrado = 0;
  mvDiluido     = mvConcentrado + 1;

type
  TModoVenda = Shortint;

implementation

end.
