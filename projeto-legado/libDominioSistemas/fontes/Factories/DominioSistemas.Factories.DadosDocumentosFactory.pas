unit DominioSistemas.Factories.DadosDocumentosFactory;

interface

uses
  DominioSistemas.Core.DadosDocumentosInterface,
  DominioSistemas.Core.DocumentoInterface ;

type
  TDadosDocumentosFactory = class(TInterfacedObject, IDadosDocumentosFactory)
  public
    function fListar(const ATipo: TTipoDocumentoDominio): IListarDadosDocumentos;
    class function New: TDadosDocumentosFactory ;
  end;

implementation

uses
  DominioSistemas.Infra.Repository ;

{ TDadosDocumentosFactory }

function TDadosDocumentosFactory.fListar(
  const ATipo: TTipoDocumentoDominio): IListarDadosDocumentos;
begin
  case ATipo of
    tdSaidaMercadoria        : Result := TDadosDocumentosSaidaMercadoria.Create(ATipo) ;
    tdEntradaMercadoria      : Result := TDadosDocumentosEntradaMercadoria.Create(ATipo) ;
    tdSaidaServico           : Result := TDadosDocumentosSaidaServico.Create(ATipo) ;
    tdEntradaServico         : Result := TDadosDocumentosEntradaServico.Create(ATipo) ;
    tdConhecimentoTransporte : Result := TDadosDocumentosConhecimentoTransporte.Create(ATipo) ;
  else
    Result := Nil ;
  end ;
end;

class function TDadosDocumentosFactory.New: TDadosDocumentosFactory;
begin
  Result := Self.Create ;
end;

end.
