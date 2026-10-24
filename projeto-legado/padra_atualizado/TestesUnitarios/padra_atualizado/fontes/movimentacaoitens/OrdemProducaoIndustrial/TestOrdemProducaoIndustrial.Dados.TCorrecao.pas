unit TestOrdemProducaoIndustrial.Dados.TCorrecao;

interface

uses
  System.Generics.Collections,

  OrdemProducaoIndustrial.TCorrecao;

  procedure pAlimentaListaCorrecoes(lstCorrecoes : TObjectList<TCorrecao>);

implementation

procedure pAlimentaListaCorrecoes(lstCorrecoes : TObjectList<TCorrecao>);
var
  objCorrecao : TCorrecao;
begin

  objCorrecao := TCorrecao.Create;
  objCorrecao.strCodigo := '00001';
  objCorrecao.strDescricao := 'CT 506 - PRETO';
  objCorrecao.fltQuantidade := -1.5830;
  objCorrecao.fltCusto := 8.6200;
  lstCorrecoes.Add(objCorrecao);

  objCorrecao := TCorrecao.Create;
  objCorrecao.strCodigo := '00002';
  objCorrecao.strDescricao := 'CT 521 AMARELO';
  objCorrecao.fltQuantidade := 1.095;
  objCorrecao.fltCusto := 7.5800;
  lstCorrecoes.Add(objCorrecao);

  objCorrecao := TCorrecao.Create;
  objCorrecao.strCodigo := '00003';
  objCorrecao.strDescricao := 'XILOL';
  objCorrecao.fltQuantidade := 4.5;
  objCorrecao.fltCusto := 5.0500;
  lstCorrecoes.Add(objCorrecao);

end;

end.
