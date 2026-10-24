unit untTRetRegistroCat42FatoGeradorNaoRealizado;

interface

uses System.Generics.Collections,
     untTItemNotaUtilizadoCat,
     untTCompraCatFactory,
     untTItemNotaFiscal,
     untTRetRegistroCat,
     untTDadosAbertura,
     untTRegistroCat,
     untTNotaFiscal,
     untICompraCat;

type
  TRetRegistroCat42FatoGeradorNaoRealizado = class(TRetRegistroCat)
  public
    function fRetRegistroCat(notas: TObjectList<TNotaFiscal>;
                             abertura: TDadosAbertura;
                             listaNotasUtilizadas: TObjectList<TItemNotaUtilizadoCat>): TObjectList<TRegistroCat>; override;
  end;

implementation

uses untFuncoes, untTipo;

{ TRetRegistroCat42FatoGeradorNaoRealizado }

function TRetRegistroCat42FatoGeradorNaoRealizado.fRetRegistroCat(notas: TObjectList<TNotaFiscal>; abertura: TDadosAbertura;
  listaNotasUtilizadas: TObjectList<TItemNotaUtilizadoCat>): TObjectList<TRegistroCat>;
  var
    objCompraCat: ICompraCat;
    registro: TRegistroCat;
    item: TItemNotaFiscal;
    nota: TNotaFiscal;
begin
  objCompraCat := TCompraCatFactory.fRetCompraCat(Cat42);

  Result := listaRegistros;

  listaRegistros.Clear;
  for nota in notas do
  begin
    if nota.strCfop1 = '5927' then
    begin
      for item in nota.itensNota do
      begin
        registro := TRegistroCat.Create;

        //retorna uma lista de TItemNota para cada compra utilizada a partir da qtde vendida
        registro.tolDadosCompra := objCompraCat.fRetCompraCat(nota.dtaDtaEnt, abertura, item, listaNotasUtilizadas);
        registro.strCodigoProduto := item.strCodIte;
        registro.strEnquadramento := '2';
        registro.dadosVenda := item;

        listaRegistros.Add(registro);
      end;
    end;
  end;
end;

end.

