unit DominioSistemas.Factories.NotaEntradaMercadoriaFactory;

interface

uses
  DominioSistemas.Core.DocumentoInterface ;

type
  TNotaEntradaMercadoriaFactory = class(TInterfacedObject, IDocumentoFactory)
  public
    function fCriarDocumento(const AParamDoc: TParamDocumento): IDocumento;
    class function New: IDocumentoFactory ;
  end;

implementation

uses
  DominioSistemas.Service.NotaEntradaMercadoria ;

{ TNotaEntradaMercadoriaFactory }

function TNotaEntradaMercadoriaFactory.fCriarDocumento(
  const AParamDoc: TParamDocumento): IDocumento;
begin
  Result := TNotaEntradaMercadoria.Create(AParamDoc);
end;

class function TNotaEntradaMercadoriaFactory.New: IDocumentoFactory;
begin
  Result := Self.Create ;
end;

end.
