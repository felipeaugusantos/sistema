unit DominioSistemas.Factories.NotaSaidaMercadoriaFactory;

interface

uses
  DominioSistemas.Core.DocumentoInterface ;

type
  TNotaSaidaMercadoriaFactory = class(TInterfacedObject, IDocumentoFactory)
  public
    function fCriarDocumento(const AParamDoc: TParamDocumento): IDocumento;
    class function New: IDocumentoFactory ;
  end;

implementation

uses
  DominioSistemas.Service.NotaSaidaMercadoria ;

{ TNotaSaidaMercadoriaFactory }

function TNotaSaidaMercadoriaFactory.fCriarDocumento(const AParamDoc: TParamDocumento): IDocumento;
begin
  Result := TNotaSaidaMercadoria.Create(AParamDoc);
end;

class function TNotaSaidaMercadoriaFactory.New: IDocumentoFactory;
begin
  Result := Self.Create ;
end;

end.
