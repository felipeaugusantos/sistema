unit DominioSistemas.Service.NotaSaidaMercadoria;

interface

uses
  System.Generics.Collections, DominioSistemas.Core.DocumentoInterface,
  DominioSistemas.Core.ApiClientInterface ;

type
  TNotaSaidaMercadoria = class(TInterfacedObject, IDocumento)
  private
    FXML: TDictionary<String, String>;
    function fXMLDocumentoCancelado(const AParamDoc: TParamDocumento; const AXmlOriginal: String): String ;
  public
    constructor Create(const AParamDoc: TParamDocumento);
    destructor Destroy(); override ;
    function fGetXML: TDictionary<String, String>;
    function fEnviarParaAPI(const AApi: IApiClient): String;
  end ;

implementation

uses
  DominioSistemas.Infra.Repository, System.SysUtils, DominioSistemas.Core.Utils,
  Data.DB, DominioSistemas.Service.GerarXml ;

{ TNotaSaidaMercadoria }

constructor TNotaSaidaMercadoria.Create(const AParamDoc: TParamDocumento);
var
  LInfoXml: String ;
  LPathXml: String ;
  LImportada: Boolean ;
begin
  FXML := TDictionary<String, String>.Create ;
  // XML do documento
  LInfoXml := TMySQLRepository.fBuscaXMLDocumento(AParamDoc, LImportada) ;
  LInfoXml := fXMLDocumentoCancelado(AParamDoc, LInfoXml) ;

  LPathXml := TFuncUtils.fGerarArquivoXML(AParamDoc.Acesso, LInfoXml) ;
  FXML.Add('file[]', LPathXml) ;
end;

destructor TNotaSaidaMercadoria.Destroy;
begin
  FreeAndNil(FXML) ;
  inherited;
end;

function TNotaSaidaMercadoria.fGetXML: TDictionary<String, String>;
begin
  Result := FXML ;
end;

function TNotaSaidaMercadoria.fXMLDocumentoCancelado(
  const AParamDoc: TParamDocumento; const AXmlOriginal: String): String;
var
  LConsulta: TDataSet ;
begin
  Result := AXmlOriginal ;

  if AParamDoc.Status <> '02' then
    Exit ;

  LConsulta := TMySQLRepository.fGetInformacaoNotaCancelada(AParamDoc) ;
  try
    if LConsulta.IsEmpty then
      Exit ;

    Result := TGerarXml.fXmlCancelamentoNfe(LConsulta, AXmlOriginal)
  finally
    FreeAndNil(LConsulta) ;
  end ;

end;

function TNotaSaidaMercadoria.fEnviarParaAPI(const AApi: IApiClient): String;
begin
  Result := AApi.fPostNotaFiles('/invoice/v3/batches', FXML) ;
  TFuncUtils.pApagarArquivosXML(FXML) ;
end;

end.
