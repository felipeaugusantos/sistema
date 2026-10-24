unit DominioSistemas.Core.DocumentoFactoryRegistry;

interface

uses
  Generics.Collections, DominioSistemas.Core.DocumentoInterface ;

type
  TDocumentoFactoryRegistry = class
  private
    class var FFactories: TDictionary<TTipoDocumentoDominio, IDocumentoFactory>;
  public
    class constructor Create;
    class destructor Destroy;
    class procedure RegisterFactory(const ATipo: TTipoDocumentoDominio; AFactory: IDocumentoFactory);
    class function GetFactory(const ATipo: TTipoDocumentoDominio): IDocumentoFactory;
  end;

implementation

uses
  System.SysUtils, System.TypInfo ;

{ TDocumentoFactoryRegistry }

class constructor TDocumentoFactoryRegistry.Create;
begin
  FFactories := TDictionary<TTipoDocumentoDominio, IDocumentoFactory>.Create();
end;

class destructor TDocumentoFactoryRegistry.Destroy;
begin
  FreeAndNil(FFactories) ;
end;

class function TDocumentoFactoryRegistry.GetFactory(
  const ATipo: TTipoDocumentoDominio): IDocumentoFactory;
begin
  if not FFactories.TryGetValue(ATipo, Result) then
    raise Exception.CreateFmt('Nenhuma factory registrada para o tipo "%s"', [GetEnumName(TypeInfo(TTipoDocumentoDominio), Ord(ATipo))]);
end;

class procedure TDocumentoFactoryRegistry.RegisterFactory(
  const ATipo: TTipoDocumentoDominio; AFactory: IDocumentoFactory);
begin
  FFactories.AddOrSetValue(ATipo, AFactory);
end;

end.
