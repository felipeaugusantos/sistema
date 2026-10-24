unit untTRetRegistroCat42VendasConsumidorFinal;

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
     Dialogs;

type
  TRetRegistroCat42VendasConsumidorFinal = class(TRetRegistroCat)
  public
    function fRetRegistroCat(notas: TObjectList<TNotaFiscal>;
                             abertura: TDadosAbertura;
                             listaNotasUtilizadas: TObjectList<TItemNotaUtilizadoCat>): TObjectList<TRegistroCat>; override;
  end;

implementation

uses untTItemNotaFiscal, untFuncoes, untTipo;

{ TRegRegistroCat42VendasConsumidorFinal }

function TRetRegistroCat42VendasConsumidorFinal.fRetRegistroCat(notas: TObjectList<TNotaFiscal>; abertura: TDadosAbertura;
 listaNotasUtilizadas: TObjectList<TItemNotaUtilizadoCat>): TObjectList<TRegistroCat>;
  var
    strPerfilCliente: string;
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
    strPerfilCliente := fGetTipoAbfCliente(nota.participante.strCodigo);

    for item in nota.itensNota do
    begin
      if (StrToInt(item.strCfop) < 6000) and
         ((Pos('NCO', strPerfilCliente) > 0) or (Pos('CCO', strPerfilCliente) > 0) or (Pos('CTA', strPerfilCliente) > 0) or
          (Pos('PRU', strPerfilCliente) > 0) or (Pos('SNA', strPerfilCliente) > 0))then
      begin
        registro := TRegistroCat.Create;

        registro.tolDadosCompra := objCompraCat.fRetCompraCat(nota.dtaDtaEnt, abertura, item, listaNotasUtilizadas);
        registro.strCodigoProduto := item.strCodIte;
        registro.strEnquadramento := '1';
        registro.dadosVenda := item;

        listaRegistros.Add(registro);
      end;
    end;
  end;
end;

end.
