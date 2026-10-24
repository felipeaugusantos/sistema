unit DominioSistemas.Service.NotaEntradaMercadoria;

interface

uses
  System.Generics.Collections, DominioSistemas.Core.DocumentoInterface,
  DominioSistemas.Core.ApiClientInterface, Data.DB ;

type
  TNotaEntradaMercadoria = class(TInterfacedObject, IDocumento)
  private
    FXML: TDictionary<String, String>;
    function fGerarXMLComplementar(const AParamDoc: TParamDocumento; const AXmlOri: String): String ;
    function fPodeGerarXMLComplementar(const AParamDoc: TParamDocumento): Boolean ;
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
  DominioSistemas.Service.GerarXml;

{ TNotaEntradaMercadoria }

constructor TNotaEntradaMercadoria.Create(const AParamDoc: TParamDocumento);
var
  LInfoXmlOri: String ;
  LPathXmlOri: String ;
  LPathXmlComplemento: String ;
  LImportada: Boolean ;
begin
  FXML := TDictionary<String, String>.Create ;
  // XML do documento
  LInfoXmlOri := TMySQLRepository.fBuscaXMLDocumento(AParamDoc, LImportada) ;
  LInfoXmlOri := fXMLDocumentoCancelado(AParamDoc, LInfoXmlOri) ;

  LPathXmlOri := TFuncUtils.fGerarArquivoXML(AParamDoc.Acesso, LInfoXmlOri) ;
  FXML.Add('file[]', LPathXmlOri) ;

  if LImportada and fPodeGerarXMLComplementar(AParamDoc) then
  begin
    LPathXmlComplemento := fGerarXMLComplementar(AParamDoc, LInfoXmlOri) ;
    if not Trim(LPathXmlComplemento).IsEmpty then
      FXML.Add('fileComplement[]', LPathXmlComplemento) ;
  end ;

end;

destructor TNotaEntradaMercadoria.Destroy;
begin
  FreeAndNil(FXML) ;
  inherited;
end;

function TNotaEntradaMercadoria.fEnviarParaAPI(const AApi: IApiClient): String;
begin
  Result := AApi.fPostNotaFiles('/invoice/v3/batches', FXML) ;
  TFuncUtils.pApagarArquivosXML(FXML) ;
end;

function TNotaEntradaMercadoria.fGerarXMLComplementar(
  const AParamDoc: TParamDocumento; const AXmlOri: String): String;
var
  LConsulta : TDataSet ;
  LConteudoXML : String ;
begin
  Result := '' ;
  LConsulta := TMySQLRepository.fGetInformacaoComplementarNfEntrada(AParamDoc, tdEntradaMercadoria, '002') ;
  try
    if not LConsulta.IsEmpty then
    begin
      LConteudoXML := TGerarXml.fComplementoEntrada(LConsulta, AXmlOri) ;
      Result := TFuncUtils.fGerarArquivoXML(AParamDoc.Acesso, LConteudoXML, 'complemento') ;
    end ;
  finally
    FreeAndNil(LConsulta) ;
  end ;
end;

function TNotaEntradaMercadoria.fGetXML: TDictionary<String, String>;
begin
  Result := FXML ;
end;

function TNotaEntradaMercadoria.fPodeGerarXMLComplementar(
  const AParamDoc: TParamDocumento): Boolean;
begin
  Result := trim(AParamDoc.OriDoc).IsEmpty or trim(AParamDoc.OriDoc).Equals('D') ;
end;

function TNotaEntradaMercadoria.fXMLDocumentoCancelado(
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

end.
