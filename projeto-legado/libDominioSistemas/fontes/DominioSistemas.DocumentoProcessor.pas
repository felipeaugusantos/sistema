unit DominioSistemas.DocumentoProcessor;

interface

uses
  DominioSistemas.Core.DocumentoInterface,
  DominioSistemas.Core.AutenticacaoInterface,
  DominioSistemas.Core.ConsultaInterface,
  DominioSistemas.Core.ApiClientInterface, Data.DB ;

  procedure pRegisterDocumentoFactories;
  function  fProcessarDocumento(const ATipo: TTipoDocumentoDominio;
                                const AApi: IApiClient;
                                const AParamDoc: TParamDocumento): String;
  function fRetornaAccessToken(const ACodEmp: String): String ;
  function fRetornaXIntegrationKey(const ACodEmp: String): String ;
  function fConsultarProtocoloDocumento(const AApi: IApiClient; const AProtocolo: String): String ;
  function fConsultarAtivacaoCliente(const AApi: IApiClient): TInfoAtivacao ;
  function fGerarIntegrationKeyApp(const AApi: IApiClient): String ;
  function fListarDocumentos(const ATipo: TTipoDocumentoDominio;
                             const ACodEmp: String;
                             const ADataIni, ADataFim: TDateTime;
                             const AChaveAcesso: String): TDataSet ;
  function fListarDocumentosJaProcessados(const ATipo: TTipoDocumentoDominio;
                                          const ACodEmp: String;
                                          const ADataIni, ADataFim: TDateTime): TDataSet ;
  function fListarDocumentosProcessamentoPendente(const ATipo: TTipoDocumentoDominio;
                                                  const ACodEmp: String): TDataSet ;

implementation

uses
  DominioSistemas.Core.DocumentoFactoryRegistry,
  DominioSistemas.Factories.NotaSaidaMercadoriaFactory,
  DominioSistemas.Factories.NotaEntradaMercadoriaFactory,
  DominioSistemas.Factories.NotaSaidaServicoFactory,
  DominioSistemas.Factories.NotaEntradaServicoFactory,
  DominioSistemas.Factories.NotaConhecimentoTransporteFactory,
  DominioSistemas.Factories.AutenticacaoFactory,
  DominioSistemas.Factories.ConsultaFactory,
  DominioSistemas.Factories.DadosDocumentosFactory ;

  procedure pRegisterDocumentoFactories;
  begin
    TDocumentoFactoryRegistry.RegisterFactory(
      tdSaidaMercadoria,
      TNotaSaidaMercadoriaFactory.New
    );

    TDocumentoFactoryRegistry.RegisterFactory(
      tdEntradaMercadoria,
      TNotaEntradaMercadoriaFactory.New
    );

    TDocumentoFactoryRegistry.RegisterFactory(
      tdSaidaServico,
      TNotaSaidaServicoFactory.New
    );

    TDocumentoFactoryRegistry.RegisterFactory(
      tdEntradaServico,
      TNotaEntradaServicoFactory.New
    );

    TDocumentoFactoryRegistry.RegisterFactory(
      tdConhecimentoTransporte,
      TNotaConhecimentoTransporteFactory.New
    );

  end;

  function fProcessarDocumento(const ATipo: TTipoDocumentoDominio;
                               const AApi: IApiClient;
                               const AParamDoc: TParamDocumento): String;
  var
    LFactory: IDocumentoFactory;
    LDocumento: IDocumento;
  begin
    LFactory := TDocumentoFactoryRegistry.GetFactory(ATipo);
    LDocumento := LFactory.fCriarDocumento(AParamDoc);
    Result := LDocumento.fEnviarParaAPI(AApi);
  end ;

  function fConsultarProtocoloDocumento(const AApi: IApiClient; const AProtocolo: String): String ;
  begin
    Result := TConsultaFactory.New.fProtocolo.fProcessamento(AApi, AProtocolo);
  end ;

  function fConsultarAtivacaoCliente(const AApi: IApiClient): TInfoAtivacao ;
  begin
    Result := TConsultaFactory.New.fAtivacao.fInformacao(AApi) ;
  end ;

  function fGerarIntegrationKeyApp(const AApi: IApiClient): String ;
  begin
    Result := TConsultaFactory.New.fAtivacao.fGerarIntegrationKeyApp(AApi) ;
  end ;

  function fRetornaAccessToken(const ACodEmp: String): String ;
  begin
    Result := TAutenticacaoFactory.New.fCriar.fGetAccessToken(ACodEmp) ;
  end ;

  function fRetornaXIntegrationKey(const ACodEmp: String): String ;
  begin
    Result := TAutenticacaoFactory.New.fCriar.fGetXIntegrationKey(ACodEmp) ;
  end ;

  function fListarDocumentos(const ATipo: TTipoDocumentoDominio;
                             const ACodEmp: String;
                             const ADataIni, ADataFim: TDateTime;
                             const AChaveAcesso: String): TDataSet ;
  begin
    Result := TDadosDocumentosFactory.New.fListar(ATipo).fDocumentos(ACodEmp, ADataIni, ADataFim, AChaveAcesso) ;
  end ;

  function fListarDocumentosJaProcessados(const ATipo: TTipoDocumentoDominio;
                                          const ACodEmp: String;
                                          const ADataIni, ADataFim: TDateTime): TDataSet ;
  begin
    Result := TDadosDocumentosFactory.New.fListar(ATipo).fDocumentosJaProcessados(ACodEmp, ADataIni, ADataFim) ;
  end;

  function fListarDocumentosProcessamentoPendente(const ATipo: TTipoDocumentoDominio;
                                                  const ACodEmp: String): TDataSet ;
  begin
    Result := TDadosDocumentosFactory.New.fListar(ATipo).fDocumentosProcessamentoPendente(ACodEmp) ;
  end;

initialization
  pRegisterDocumentoFactories ;

end.
