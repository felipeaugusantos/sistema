unit TestOrdemProducaoIndustrial.Dados.TEmbalagem;

interface

uses
  OrdemProducaoIndustrial.Tipos,
  OrdemProducaoIndustrial.TEmbalagem,
  System.Generics.Collections;

  procedure pAlimentaListaEmbalagens3600MiliLitros(enuTipoArredondamento : TTipoArredondamentoComposicao; lstEmbalagens : TObjectList<TEmbalagem>);
  procedure pAlimentaListaEmbalagens900MiliLitros(enuTipoArredondamento : TTipoArredondamentoComposicao; lstEmbalagens : TObjectList<TEmbalagem>);

implementation

procedure pAlimentaListaEmbalagens3600MiliLitros(enuTipoArredondamento : TTipoArredondamentoComposicao; lstEmbalagens : TObjectList<TEmbalagem>);
var
  objEmbalagem : TEmbalagem;
begin

  objEmbalagem := TEmbalagem.Create(enuTipoArredondamento, False);
  objEmbalagem.strCodigo := '00001';
  objEmbalagem.strDescricao := 'LATA TINTAS S/V 1/1';
  objEmbalagem.fltQuantidade := 1.0000;
  objEmbalagem.fltCusto := 6.5700;
  objEmbalagem.fltPeso := 1.3125;
  lstEmbalagens.Add(objEmbalagem);

  objEmbalagem := TEmbalagem.Create(enuTipoArredondamento, False);
  objEmbalagem.strCodigo := '00002';
  objEmbalagem.strDescricao := 'ETIQUETA BRANCA 25X75X4C-RL';
  objEmbalagem.fltQuantidade := 1.0000;
  objEmbalagem.fltCusto := 0.0115;
  objEmbalagem.fltPeso := 6.4587;
  lstEmbalagens.Add(objEmbalagem);

  objEmbalagem := TEmbalagem.Create(enuTipoArredondamento, True);
  objEmbalagem.strCodigo := '00003';
  objEmbalagem.strDescricao := 'ALPFILM PE CONTRATIL 580X70';
  objEmbalagem.fltQuantidade := 0.0140;
  objEmbalagem.fltCusto := 9.8700;
  objEmbalagem.fltPeso := 0.1254;
  lstEmbalagens.Add(objEmbalagem);

end;


procedure pAlimentaListaEmbalagens900MiliLitros(enuTipoArredondamento : TTipoArredondamentoComposicao; lstEmbalagens : TObjectList<TEmbalagem>);
var
  objEmbalagem : TEmbalagem;
begin

  objEmbalagem := TEmbalagem.Create(enuTipoArredondamento, False);
  objEmbalagem.strCodigo := '00001';
  objEmbalagem.strDescricao := 'LATA TINTAS S/V 1/4';
  objEmbalagem.fltQuantidade := 1.0000;
  objEmbalagem.fltCusto := 2.2000;
  objEmbalagem.fltPeso := 1.6253;
  lstEmbalagens.Add(objEmbalagem);

  objEmbalagem := TEmbalagem.Create(enuTipoArredondamento, False);
  objEmbalagem.strCodigo := '00002';
  objEmbalagem.strDescricao := 'ETIQUETA BRANCA 25X75X4C-RL';
  objEmbalagem.fltQuantidade := 1.0000;
  objEmbalagem.fltCusto := 0.0115;
  objEmbalagem.fltPeso := 7.1131;
  lstEmbalagens.Add(objEmbalagem);

  objEmbalagem := TEmbalagem.Create(enuTipoArredondamento, True);
  objEmbalagem.strCodigo := '00003';
  objEmbalagem.strDescricao := 'ALPFILM PE CONTRATIL 580X70';
  objEmbalagem.fltQuantidade := 0.0060;
  objEmbalagem.fltCusto := 9.8700;
  objEmbalagem.fltPeso := 1;
  lstEmbalagens.Add(objEmbalagem);

  objEmbalagem := TEmbalagem.Create(enuTipoArredondamento, True);
  objEmbalagem.strCodigo := '00004';
  objEmbalagem.strDescricao := 'PAPELAO DIVISORIA 200 X 300';
  objEmbalagem.fltQuantidade := 0.1667;
  objEmbalagem.fltCusto := 0.1500;
  objEmbalagem.fltPeso := 0.8961;
  lstEmbalagens.Add(objEmbalagem);

end;

end.
