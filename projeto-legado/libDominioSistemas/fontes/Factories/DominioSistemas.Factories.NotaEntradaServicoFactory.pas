unit DominioSistemas.Factories.NotaEntradaServicoFactory;

interface

uses
  DominioSistemas.Core.DocumentoInterface ;

type
  TNotaEntradaServicoFactory = class(TInterfacedObject, IDocumentoFactory)
  public
    function fCriarDocumento(const AParamDoc: TParamDocumento): IDocumento;
    class function New: IDocumentoFactory ;
  end;

implementation

uses
  DominioSistemas.Service.NotaEntradaServico ;

{ TNotaEntradaServicoFactory }

function TNotaEntradaServicoFactory.fCriarDocumento(
  const AParamDoc: TParamDocumento): IDocumento;
begin
  Result := TNotaEntradaServico.Create(AParamDoc);
end;

class function TNotaEntradaServicoFactory.New: IDocumentoFactory;
begin
  Result := Self.Create ;
end;

end.
