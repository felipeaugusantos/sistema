unit DominioSistemas.Core.ApiClientInterface;

interface

uses
  System.Generics.Collections ;

type
  IAPIClient = interface
    ['{DD52DFBB-7DA8-44C1-9A65-A9BCA146A572}']
    function fPostNotaFiles(const AEndpoint: string; const APathsXMLFiles: TDictionary<String,String>): String;
    function fGetDocumentoStatus(const AEndpoint, AProtocolo: string): String;
    function fGetAtivacaoInfo(const AEndpoint: string): String;
    function fGerarIntegrationKeyApp(const AEndpoint: string): String ;
    procedure pSetIntegrationKeyApp(const AValue: string) ;
  end ;

implementation

end.
