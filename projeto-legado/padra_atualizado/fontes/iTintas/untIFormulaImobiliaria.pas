unit untIFormulaImobiliaria;

interface

uses
  untFuncEspecificas, Classes;

type
  IFormulaImobiliaria = interface
    ['{C102C774-E4C1-4081-A3C2-9D949634FA34}']
    function GetNomeTabelaBase(): string;
    function GetNomeTabelaColorante(): string;
    function GetTextoCalculoValor: string;
    function GetCamposAdicionaisCarregarColorantes: string;
    function GetCalculoColorantePreCus(objColorante: TColoranteImobiliario): Double;
    function GetCalculoColorantePreCu2(objColorante: TColoranteImobiliario): Double;
    function GetCalculoColorantePreVen(objColorante: TColoranteImobiliario): Double;
    function GetCalculoColoranteOutVal(objColorante: TColoranteImobiliario): Double;
    function GetCalculoColoranteIcmSai(objColorante: TColoranteImobiliario): Double;
    function GetCalculoColoranteImpFed(objColorante: TColoranteImobiliario): Double;
    function GetCalculoColoranteDesOpe(objColorante: TColoranteImobiliario): Double;
    function GetCalculoColorantePreMed(objColorante: TColoranteImobiliario): Double;
    function GetCalculoColorantePreUlt(objColorante: TColoranteImobiliario): Double;
    function GetCalculoColoranteImpUlt(objColorante: TColoranteImobiliario): Double;
    function GetCalculoColoranteComLiq(objColorante: TColoranteImobiliario): Double;                
    function GetNomeCampoBaseCusto(): string;
    function GetNomeCampoBaseVenda(): string;
    function GetNomeCampoColoranteCusto(): string;
    function GetNomeCampoColoranteVenda(): string;
    function GetNomeCampoColDesCol(): string;
  end;

implementation

end.

