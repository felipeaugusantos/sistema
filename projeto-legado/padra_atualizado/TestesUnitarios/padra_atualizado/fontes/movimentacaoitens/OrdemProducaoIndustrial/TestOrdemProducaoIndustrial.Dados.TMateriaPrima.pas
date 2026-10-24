unit TestOrdemProducaoIndustrial.Dados.TMateriaPrima;

interface

uses
  System.Generics.Collections,

  OrdemProducaoIndustrial.TMateriaPrima;

  procedure pAlimentaListaMateriasPrimas(lstMateriasPrimas : TObjectList<TMateriaPrima>);

implementation

procedure pAlimentaListaMateriasPrimas(lstMateriasPrimas : TObjectList<TMateriaPrima>);
var
  objMateriaPrima : TMateriaPrima;
begin

  objMateriaPrima := TMateriaPrima.Create;
  objMateriaPrima.strCodigo := '00001';
  objMateriaPrima.strDescricao := 'RESINA WT 526';
  objMateriaPrima.fltPercentualFormula := 67.0200;
  objMateriaPrima.fltCusto := 7.9000;
  lstMateriasPrimas.Add(objMateriaPrima);

  objMateriaPrima := TMateriaPrima.Create;
  objMateriaPrima.strCodigo := '00002';
  objMateriaPrima.strDescricao := 'ACETATO DE ETILA';
  objMateriaPrima.fltPercentualFormula := 2.0000;
  objMateriaPrima.fltCusto := 5.9500;
  lstMateriasPrimas.Add(objMateriaPrima);

  objMateriaPrima := TMateriaPrima.Create;
  objMateriaPrima.strCodigo := '00003';
  objMateriaPrima.strDescricao := 'ACETATO DE ETILGLICOL';
  objMateriaPrima.fltPercentualFormula := 2.5000;
  objMateriaPrima.fltCusto := 13.9500;
  lstMateriasPrimas.Add(objMateriaPrima);

  objMateriaPrima := TMateriaPrima.Create;
  objMateriaPrima.strCodigo := '00004';
  objMateriaPrima.strDescricao := 'SOLUCAO BYK 306';
  objMateriaPrima.fltPercentualFormula := 0.1000;
  objMateriaPrima.fltCusto := 54.8000;
  lstMateriasPrimas.Add(objMateriaPrima);

  objMateriaPrima := TMateriaPrima.Create;
  objMateriaPrima.strCodigo := '00005';
  objMateriaPrima.strDescricao := 'SOLUCAO BYK 53';
  objMateriaPrima.fltPercentualFormula := 0.1000;
  objMateriaPrima.fltCusto := 33.1000;
  lstMateriasPrimas.Add(objMateriaPrima);

  objMateriaPrima := TMateriaPrima.Create;
  objMateriaPrima.strCodigo := '00006';
  objMateriaPrima.strDescricao := 'SOLUCAO SECANTE PARA SINTETICO';
  objMateriaPrima.fltPercentualFormula := 1.5000;
  objMateriaPrima.fltCusto := 18.8800;
  lstMateriasPrimas.Add(objMateriaPrima);

  objMateriaPrima := TMateriaPrima.Create;
  objMateriaPrima.strCodigo := '00007';
  objMateriaPrima.strDescricao := 'ANTI PELE';
  objMateriaPrima.fltPercentualFormula := 0.1000;
  objMateriaPrima.fltCusto := 17.3800;
  lstMateriasPrimas.Add(objMateriaPrima);

  objMateriaPrima := TMateriaPrima.Create;
  objMateriaPrima.strCodigo := '00008';
  objMateriaPrima.strDescricao := 'CT 506 - PRETO';
  objMateriaPrima.fltPercentualFormula := 10.7800;
  objMateriaPrima.fltCusto := 8.6200;
  lstMateriasPrimas.Add(objMateriaPrima);

  objMateriaPrima := TMateriaPrima.Create;
  objMateriaPrima.strCodigo := '00009';
  objMateriaPrima.strDescricao := 'CT 521 AMARELO';
  objMateriaPrima.fltPercentualFormula := 3.5000;
  objMateriaPrima.fltCusto := 7.5800;
  lstMateriasPrimas.Add(objMateriaPrima);

  objMateriaPrima := TMateriaPrima.Create;
  objMateriaPrima.strCodigo := '00010';
  objMateriaPrima.strDescricao := 'CT 510 BRANCO';
  objMateriaPrima.fltPercentualFormula := 8.4000;
  objMateriaPrima.fltCusto := 11.2200;
  lstMateriasPrimas.Add(objMateriaPrima);

  objMateriaPrima := TMateriaPrima.Create;
  objMateriaPrima.strCodigo := '00010';
  objMateriaPrima.strDescricao := 'XILOL';
  objMateriaPrima.fltPercentualFormula := 4.0000;
  objMateriaPrima.fltCusto := 5.0500;
  lstMateriasPrimas.Add(objMateriaPrima);

end;

end.
