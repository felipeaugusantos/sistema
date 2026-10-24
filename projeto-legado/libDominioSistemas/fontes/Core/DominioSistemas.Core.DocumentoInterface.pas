unit DominioSistemas.Core.DocumentoInterface;

interface

uses
  System.Generics.Collections, DominioSistemas.Core.ApiClientInterface ;

type
  TParamDocumento = record
    NumDoc: String ;
    EspDoc: String ;
    CodEmp: String ;
    Serie_: String ;
    Tip_Fc: String ;
    ForCli: String ;
    Acesso: String ;
    OriDoc: String ;
    Status: String ;
  end ;

  IDocumento = interface
    ['{015E8D32-7B41-44F7-948E-C43FAF78D872}']
    function fGetXML: TDictionary<String, String>;
    function fEnviarParaAPI(const AApi: IAPIClient): String;
  end ;

  IDocumentoFactory = interface
    ['{C12A3241-10BB-436D-954F-5DF362C10F30}']
    function fCriarDocumento(const AParamDoc: TParamDocumento): IDocumento;
  end ;

  TTipoDocumentoDominio = (tdSaidaMercadoria, tdSaidaServico, tdEntradaMercadoria, tdEntradaServico, tdConhecimentoTransporte) ;
  TTipoDocumentosDominio =  set of TTipoDocumentoDominio;

const
  REPLACE_PARAMETROS           = '/*FILTRO_ADICIONAL*/' ;
  REPLACE_PARAMETROS_CANCELADO = '/*FILTRO_ADICIONAL_CANCELADO*/' ;
  ABREV_TIPO_DOCUMENTO : Array[TTipoDocumentoDominio] Of String = ('SAI-PRO',
                                                                   'SAI-SER',
                                                                   'ENT-PRO',
                                                                   'ENT-SER',
                                                                   'CON-TRA') ;

  DESCRICAO_TIPO_DOCUMENTO : Array[TTipoDocumentoDominio] Of String = ('NF Saída',
                                                                       'NF Saída Serviço',
                                                                       'NF Entrada',
                                                                       'NF Entrada Serviço',
                                                                       'NF Conhecimento Transporte') ;

  NOTA_FISCAL = '01';
  NOTA_FISCAL_SERVICO_TRANSPORTE = '07';
  CONHECIMENTO_TRANSPORTE_RODOVIARIO = '08';
  NOTA_FISCAL_ELETRONICA = '55';
  CONHECIMENTO_TRANSPORTE_ELETRONICO = '57';
  MANIFESTO_ELETRONICO_DOCUMENTOS_FISCAIS = '58';
  CUPOM_FISCAL_ELETRONICO = '59';
  NOTA_FISCAL_FATURA_ELETRONICA_COMUNICACAO = '62';
  BILHETE_PASSAGEM_ELETRONICO = '63';
  NOTA_FISCAL_CONSUMIDOR_ELETRONICA = '65';
  NOTA_FISCAL_ENERGIA_ELETRICA_ELETRONICA = '66';
  CONHECIMENTO_TRANSPORTE_ELETRONICO_OUTROS_SERVICOS = '67';

implementation

end.
