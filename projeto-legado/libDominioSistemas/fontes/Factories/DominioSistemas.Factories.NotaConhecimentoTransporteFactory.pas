unit DominioSistemas.Factories.NotaConhecimentoTransporteFactory;

interface

uses
  DominioSistemas.Core.DocumentoInterface ;

type
  TNotaConhecimentoTransporteFactory = class(TInterfacedObject, IDocumentoFactory)
  public
    function fCriarDocumento(const AParamDoc: TParamDocumento): IDocumento;
    class function New: IDocumentoFactory ;
  end;

implementation

uses
  DominioSistemas.Service.NotaConhecimentoTransporte ;

{ TNotaConhecimentoTransporteFactory }

function TNotaConhecimentoTransporteFactory.fCriarDocumento(
  const AParamDoc: TParamDocumento): IDocumento;
begin
  Result := TNotaConhecimentoTransporte.Create(AParamDoc);
end;

class function TNotaConhecimentoTransporteFactory.New: IDocumentoFactory;
begin
  Result := Self.Create ;
end;

end.
