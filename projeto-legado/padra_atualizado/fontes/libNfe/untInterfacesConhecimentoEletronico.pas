unit untInterfacesConhecimentoEletronico;

interface

uses untConhecimentoEletronico, untInterfaces;

Type
  IFonteDadosConhecimento = Interface(IInterface)
    function fGetConhecimento(strNumeroConhecimento: String; blnConsulta: Boolean=False): TConhecimentoEletronico;
    function fGetConhecimentoCompacto(strNumeroConhecimento: String): TConhecimentoEletronico;
  End;

Type
  IIntegracaoConhecimentoEletronico = Interface(IInterface)
    function fEnviarConhecimento(conhecimento: TConhecimentoEletronico): Boolean;
    function fProcessarConhecimento(conhecimento: TConhecimentoEletronico): TRetornoNFE;
    procedure pImprimirConhecimento(conhecimento: TConhecimentoEletronico; strImpressora: String; strForcarImpressaoPDF: String = 'N');
    function fCancelarConhecimento(conhecimento: TConhecimentoEletronico; strJustificativa, strNomeUsuario: String): Boolean;
    function fInsucessoNaEntrega(conhecimento: TConhecimentoEletronico; strChaveAcessoNfe, strMotivo, strJustificativa, strHashEntrega, strHashData: String): TRetornoNFE;
    function fCancelamentoInsucessoNaEntrega(conhecimento: TConhecimentoEletronico): TRetornoNFE;
    function fConfirmacaoDeEntrega(conhecimento: TConhecimentoEletronico; strChaveAcessoNfe, strDocumentoRecebedor, strNomeRecebedor, strHashEntrega, strHashData: String): TRetornoNFE;
    function fCancelamentoConfirmacaoDeEntrega(conhecimento: TConhecimentoEletronico): TRetornoNFE;
  End;

implementation

end.
