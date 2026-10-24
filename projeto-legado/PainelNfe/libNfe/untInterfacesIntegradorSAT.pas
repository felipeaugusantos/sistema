unit untInterfacesIntegradorSAT;

interface

Const
  INT_SAT_ARQUIVO_PROCESSADO : String = 'AP';
  INT_SAT_ARQUIVO_COM_ERRO : String = 'AE';

type
  TTipoParametroIntegrador = (tpiInt, tpiGuid, tpiString, tpiDecimal, tpiDatetime, tpiBool);

const
  C_TipoParametroIntegrador : Array[TTipoParametroIntegrador] Of String =
    ('int', 'Guid', 'string', 'decimal', 'datetime', 'bool');

type
  TrecParametrosIntegrador = record
    strNome: String;
    strValor: AnsiString;
    tipoPar: TTipoParametroIntegrador;
    blnCData: Boolean;
  end;

type
  TParametrosIntegrador = Array Of TrecParametrosIntegrador;

type
  TrecVFPeEnvioPagto = record
    strChaveAcessoValidador: String;
    strChaveRequisicao: String;
    strEstabelecimento: String;
    strSerialPos: String;
    strCnpjContrib: String;
    fltValorOperacaoSujeitaIcms: Double;
    fltValorTotalVenda: Double;
    strCodigoLoja: String;
    strCodigoPDV: String;
    strCpfCli: String;
    strCidadeCli: String;
    intQtdParcelas: Integer;
    intQtdItens: Integer;
    dtaDtaTransacao: TDateTime;
    fltValorTotalProduto: Double;
    strCelular: String;
    strBairro: String;
    fltValorUnitarioProdutoEmCentavos: Double;
    strNomeDoCliente: String;
    strEstado: String;
    strEndereco: String;
    strCep: String;
    strOrigemPagto: String;
    fltValorTransacao: Double;
    fltIcmsBase: Double;
  end;

type
  TrecVFPeRespostaSolicitacaoPagto = record
    intIdPagamento : Integer;
    strMensagem: String;
  end;

type
  TrecVFPeRespostaPagtoRealizado = record
    strCodigoAutorizacao: String;
    strBin: String;
    strDonoCartao: String;
    strDataExpiracao: String;
    strInstituicaoFinanceira: String;
    strParcelas : String;
    strUltimosQuatroDigitos: String;
    strCodigoPagamento: String;
    strValorPagamento : String;
    strIdFila : String;
    strTipo : String;
    strXML : String;
  end;

type
  IIntegradorSAT = Interface(IInterface)
    function fEnviarPagamento(intNumeroSessao: Integer; recVFPeEnvioPagto: TrecVFPeEnvioPagto): TrecVFPeRespostaSolicitacaoPagto;
    function fEnviarDadosVenda(intNumeroSessao: Integer; strCodAtivacao: AnsiString; strNumDoc, strVendaXML: AnsiString): String;
    function fCancelarUltimaVenda(intNumeroSessao: Integer; strCodAtivacao, strChave, strDadosCancelamento: AnsiString): String;
    function fRespostaFiscal(intNumeroSessao, idFila: Integer; strChaveAcessoValidador, strChaveAcesso, strNsu, strNumeroAprovacao, strBandeira, strAdquirente, strCnpj, strImpressaoFiscal, strNumeroDocumento: String): String;
    function fVerificarStatusValidador(intNumeroSessao, idFila: Integer; strChaveAcessoValidador, strCnpj: String): TrecVFPeRespostaPagtoRealizado;
    function fEnviarStatusPagamento(intNumeroSessao, intIdFila: Integer; strChaveAcessoValidador, strCodigoAutorizacao,
      strBin, strDonoCartao, strDataExpiracao, strInstituicaoFinanceira, strParcelas, strCodigoPagto, strTipo, strUltimosQuatroDigitos: String; fltValorPagto: Double): String;
    function fConsultarMFe(intNumeroSessao: Integer): String;
    function fSatAtivo(intNumeroSessao: Integer; var strMsgInt: String): Boolean;
  End;

implementation

end.
