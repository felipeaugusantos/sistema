unit DominioSistemas.Factories.NotaSaidaServicoFactory;

interface

uses
  DominioSistemas.Core.DocumentoInterface ;

type
  TNotaSaidaServicoFactory = class(TInterfacedObject, IDocumentoFactory)
  public
    function fCriarDocumento(const AParamDoc: TParamDocumento): IDocumento;
    class function New: IDocumentoFactory ;
  end;

implementation

uses
  DominioSistemas.Service.NotaSaidaServico ;

{ TNotaSaidaServicoFactory }

function TNotaSaidaServicoFactory.fCriarDocumento(
  const AParamDoc: TParamDocumento): IDocumento;
begin
  Result := TNotaSaidaServico.Create(AParamDoc);
end;

class function TNotaSaidaServicoFactory.New: IDocumentoFactory;
begin
  Result := Self.Create ;
end;

end.
