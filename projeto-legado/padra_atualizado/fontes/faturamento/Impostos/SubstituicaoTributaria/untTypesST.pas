unit untTypesST;

interface

type
  TParametrosRegrasSTSimulada = record
    TotalGeralDoItem: Double;
    ClienteConsumidorFinal: Boolean;
    CodigoDaSubstituicaoTributaria: String;
    TipoDaAbreviacaoFiscal: String;
    ValorDoIva: Double;
    AliquotaDaSubstituicaoTributariaDoItem: Double;
    PercentualDaBaseDaSubstituicaoTributariaDoItem: Double;
    EspecieDoDocumento: String;
    DentroDoEstado: Boolean;
    DentroDoEstadoCFOP: Boolean;
    AtividadeConstrutora: Boolean;
  end;

  TParametrosCalculoIva = record
    PercentualDoIvaAbreviacao: Double;
    CodigoDaSituacaoTributaria: String;
    CodigoDaSubstituicaoTributaria: String;
    TipoDaAbreviacaoFiscal: String;
    DentroDoEstado: Boolean;
    TotalGeralDoItem: Double;
    ValorDeIpiDoItem: Double;
    AliquotaDeIcmsDoItem: Double;
    AliquotaDaSubstituicaoTributariaDoItem: Double;
    DocumentoParaFornecedor: Boolean;
    ExisteNaTabelaCEDEM: Boolean;
  end;

  TResultadoCalculoIva = record
    ValorDoIva: Double;
    ValorDoIvaMatriz: Double;
    ValorDoIvaStMatriz: Double;
    ClienteIVAEspMT: Double;
  end;

  IResultadoTributacaoIva = interface
    ['{7C1D9026-58E4-4798-B82B-AB3AAE9C5B97}']
    function ResultadoDoCalculoDoIva(const NullParameter: String): TResultadoCalculoIva;
  end;

  ICalculoIva = interface
    ['{91803AA1-18E7-485F-B81A-537E7EE8F5B9}']
    function CalcularValorIva(const NullParameter: String): TResultadoCalculoIva;
  end;

  TResultadoRegrasSTSimulada = record
    BaseDaSubstituicaoTributariaSimulada: Double;
    AliquotaDaSubstituicaoTributariaSimulada: Double;
    ValorDaSubstituicaoTributariaSimulada: Double;
  end;

implementation

end.
