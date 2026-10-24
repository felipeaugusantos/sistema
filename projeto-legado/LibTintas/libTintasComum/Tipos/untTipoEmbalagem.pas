{*********************************************************************************************}
{* Tipos de embalagens automotivas do sistema, caso seja necessário acresentar mais um tipo, *}
{* basta adicionar mais uma constante com o prefixo tt, e somar + 1 ao anterior              *}
{******************************************************************************************AC*}
unit untTipoEmbalagem;

interface

const
  teLitro     = 0;
  teGalao     = teLitro + 1;
  teCopo      = teGalao + 1;
  teSpray     = teCopo  + 1;
  tePoliester = teSpray + 1;
  teDuco      = tePoliester + 1;
  teTambor    = teDuco   + 1;
  teLata      = teTambor + 1;
  teBalde     = teLata   + 1;
  teSintetico = teBalde  + 1;

type
  TTipoEmbalagem = Shortint;

implementation

end.
