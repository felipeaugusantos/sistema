unit Contabilidade.Interfaces.SharedLucroPresumido;

interface

const
  BASE_CALCULO_IRPJ = 'BASE DE CALCULO – IRPJ' ;
  APURACAO_IRPJ = 'APURACAO – IRPJ' ;
  BASE_CALCULO_CSLL = 'BASE DE CALCULO – CSLL' ;
  APURACAO_CSLL = 'APURACAO – CSLL' ;
  BASE_CALCULO = 'BASE DE CALCULO' ;
  APURACAO = 'APURACAO' ;

type
  TTipoLucroPresumido = (tlpIRPJ, tlpCSLL) ;

  IColunaDetalhePlanco = interface
    ['{94FA4B51-D727-45AA-96BB-A05B42DCDA24}']
    function fRetornaColuna(const AstrValorCodigoDetalhe: String): String ;
  end ;

implementation

end.
