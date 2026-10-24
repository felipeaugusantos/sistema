unit untTRetRegistroCat42VendasInterEstaduais;

interface

uses System.Generics.Collections,
     untTItemNotaUtilizadoCat,
     untTCompraCatFactory,
     untTRetRegistroCat,
     untTDadosAbertura,
     untTRegistroCat,
     untTNotaFiscal,
     untICompraCat,
     SysUtils,
     StrUtils;

type
  TRetRegistroCat42VendasInterEstaduais = class(TRetRegistroCat)
  public
    function fRetRegistroCat(notas: TObjectList<TNotaFiscal>;
                             abertura: TDadosAbertura;
                             listaNotasUtilizadas: TObjectList<TItemNotaUtilizadoCat>): TObjectList<TRegistroCat>; override;
  end;

implementation

uses untTItemNotaFiscal, untFuncoes, untTipo;

{ TRetRegistroCat42VendasIsencao }

function TRetRegistroCat42VendasInterEstaduais.fRetRegistroCat(notas: TObjectList<TNotaFiscal>; abertura: TDadosAbertura;
  listaNotasUtilizadas: TObjectList<TItemNotaUtilizadoCat>): TObjectList<TRegistroCat>;
  var
    objCompraCat: ICompraCat;
    registro: TRegistroCat;
    item: TItemNotaFiscal;
    nota: TNotaFiscal;
begin
  objCompraCat := TCompraCatFactory.fRetCompraCat(Cat42);

  Result := listaRegistros;
  for nota in notas do
  begin
    for item in nota.itensNota do
    begin
      if (Pos(RightStr(item.strCstIcm, 2), '00_10_20') > 0) and (StrToInt(item.strCfop) > 6000) then
      begin
        registro := TRegistroCat.Create;

        //retorna uma lista de TItemNota para cada compra utilizada a partir da qtde vendida
        registro.tolDadosCompra := objCompraCat.fRetCompraCat(nota.dtaDtaEnt, abertura, item, listaNotasUtilizadas);
        registro.strCodigoProduto := item.strCodIte;
        registro.strEnquadramento := '4';
        registro.dadosVenda := item;

        listaRegistros.Add(registro);
      end;
    end;
  end;

end;

end.
