unit untTypesMargem;

interface

uses System.Generics.Collections, DB, Classes, UniClientDataSet;

type
  TUserFunction = function (const MethodName: string; var Params: Variant): Variant of Object;

type
  TprcImprimeF4 = procedure (DataSet: TDataSet; dicColunas : TDictionary<String, Boolean>; fncUserFunction: TUserFunction; blnTinta: Boolean; stlFunctions: TStringList) Of Object;

type
  TpCalcularMargemLucro = procedure( blnSomaFreteSugestaoAoCusto,
                                     blnSomaFreteCobradoAoUnitario: Boolean;
                                     var cdsItens: TUniClientDataSet ) Of Object;

type
  TPorcentagemValor = (tpvPorcentagem, tpvValor);

type
  TRecInfVen = record
    dtaDtaEnt : TDateTime;
    fltQtdIte : Double;
    fltTotIte : Double;
    fltDesEsp : Double;
    fltUnitar : Double;
  End;

implementation

end.
