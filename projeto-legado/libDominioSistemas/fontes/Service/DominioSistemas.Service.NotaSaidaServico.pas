unit DominioSistemas.Service.NotaSaidaServico;

interface

uses
  System.Generics.Collections, DominioSistemas.Core.DocumentoInterface,
  DominioSistemas.Core.ApiClientInterface ;

type
  TNotaSaidaServico = class(TInterfacedObject, IDocumento)
  private
    FXML: TDictionary<String, String>;
    function fGerarXMLServico(const AParamDoc: TParamDocumento): String ;
  public
    constructor Create(const AParamDoc: TParamDocumento);
    destructor Destroy(); override ;
    function fGetXML: TDictionary<String, String>;
    function fEnviarParaAPI(const AApi: IApiClient): String;
  end ;

implementation

uses
  System.SysUtils, DominioSistemas.Core.Utils, DominioSistemas.Service.GerarXml,
  Data.DB, DominioSistemas.Infra.Repository ;

{ TNotaSaidaServico }

constructor TNotaSaidaServico.Create(const AParamDoc: TParamDocumento);
var
  LPathXmlServico: String ;
begin
  FXML := TDictionary<String, String>.Create ;
  LPathXmlServico := fGerarXMLServico(AParamDoc) ;
  FXML.Add('file[]', LPathXmlServico) ;
end;

destructor TNotaSaidaServico.Destroy;
begin
  FreeAndNil(FXML) ;
  inherited;
end;

function TNotaSaidaServico.fEnviarParaAPI(const AApi: IApiClient): String;
begin
  Result := AApi.fPostNotaFiles('/invoice/v3/batches', FXML) ;
  TFuncUtils.pApagarArquivosXML(FXML) ;
end;

function TNotaSaidaServico.fGerarXMLServico(
  const AParamDoc: TParamDocumento): String;
var
  LConsulta: TDataSet ;
  LConteudoXML: String ;
begin
  Result := '' ;
  LConsulta := TMySQLRepository.fGetInformacaoNotaServicoEntrada(AParamDoc, tdSaidaServico, '002') ;
  try
    if not LConsulta.IsEmpty then
    begin
      LConteudoXML := TGerarXml.fXmlServico(LConsulta, TFuncUtils.fNotaServicoCancelada(AParamDoc)) ;
      Result := TFuncUtils.fGerarArquivoXML(AParamDoc.NumDoc + '_' + AParamDoc.CodEmp, LConteudoXML, 'NFServico') ;
    end ;
  finally
    FreeAndNil(LConsulta) ;
  end ;
end;

function TNotaSaidaServico.fGetXML: TDictionary<String, String>;
begin
  Result := FXML ;
end;

end.
