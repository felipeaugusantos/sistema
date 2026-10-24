{*********************************************************************************************}
{* Tipos de tintas do sistema, caso seja necessário acresentar mais um tipo, basta adicionar *}
{* mais uma constante com o prefixo tt, e somar + 1 ao anterior                              *}
{******************************************************************************************PH*}
unit untTipoTinta;

interface

const
  ttImobiliaria = 0;
  ttAutomotiva = ttImobiliaria + 1;
  ttIndustrial = ttAutomotiva + 1;

type
  TTipoTinta = Shortint;

implementation

end.
