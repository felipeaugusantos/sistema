unit DominioSistemas.Service.NotaConhecimentoTransporte;

interface

uses
  System.Generics.Collections, DominioSistemas.Core.DocumentoInterface,
  DominioSistemas.Core.ApiClientInterface ;

type
  TNotaConhecimentoTransporte = class(TInterfacedObject, IDocumento)
  private
    FXML: TDictionary<String, String>;
  public
    constructor Create(const AParamDoc: TParamDocumento);
    destructor Destroy(); override ;
    function fGetXML: TDictionary<String, String>;
    function fEnviarParaAPI(const AApi: IApiClient): String;
  end ;

implementation

uses
  DominioSistemas.Infra.Repository, System.SysUtils, DominioSistemas.Core.Utils ;

{ TNotaConhecimentoTransporte }

constructor TNotaConhecimentoTransporte.Create(
  const AParamDoc: TParamDocumento);
var
  LInfoXml: String ;
  LPathXml: String ;
  LImportada: Boolean ;
begin
  FXML := TDictionary<String, String>.Create ;
  // XML do documento
  LInfoXml := TMySQLRepository.fBuscaXMLDocumento(AParamDoc, LImportada) ;
  LPathXml := TFuncUtils.fGerarArquivoXML(AParamDoc.Acesso, LInfoXml) ;
  FXML.Add('file[]', LPathXml) ;
  // XML complemento, caso tenha

end;

destructor TNotaConhecimentoTransporte.Destroy;
begin
  FreeAndNil(FXML) ;
  inherited;
end;

function TNotaConhecimentoTransporte.fEnviarParaAPI(
  const AApi: IApiClient): String;
begin
  Result := AApi.fPostNotaFiles('/invoice/v3/batches', FXML) ;
  TFuncUtils.pApagarArquivosXML(FXML) ;
end;

function TNotaConhecimentoTransporte.fGetXML: TDictionary<String, String>;
begin
  Result := FXML ;
end;

end.
