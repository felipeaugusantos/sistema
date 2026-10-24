unit BancoDoBrasil.Model.LancamentoExtrato;

interface

uses
  System.SysUtils, System.Classes,ContasBancarias.Model.ContaBancaria;

type
  TLancamentoExtrato = Record
    Agencia: string;                     // Número da agência
    Conta: string;                       // Número da conta
    IndicadorTipoLancamento: string;     // Tipo do lançamento (1=efetivado, 2=futuro)
    DataLancamento: TDate;               // Data do lançamento
    DataMovimento: TDate;                // Data do movimento
    CodigoAgenciaOrigem: Integer;        // Código da agência de origem
    NumeroLote: Integer;                 // Número do lote
    NumeroDocumento: Int64;              // Número do documento
    CodigoHistorico: Integer;            // Código do histórico
    TextoDescricaoHistorico: string;     // Descrição do histórico
    TextoDescricaoSubHistorico: String;  // Descricao Sub-Historico
    ValorLancamento: Double;             // Valor do lançamento
    IndicadorSinalLancamento: string;    // Sinal (D=débito, C=crédito)
    TextoInformacaoComplementar: string; // Informação complementar
    NumeroCpfCnpjContrapartida: string;  // CPF/CNPJ da contrapartida
    IndicadorTipoPessoaContrapartida: string; // Tipo da pessoa (F=física, J=jurídica)
    CodigoBancoContrapartida: Integer;   // Código do banco da contrapartida
    CodigoAgenciaContrapartida: Integer; // Agência da contrapartida
    NumeroContaContrapartida: string;    // Conta da contrapartida
    TextoDvContaContrapartida: string;   // Dígito verificador da conta
    OperadorImportacao: string;          // Operador da Importação
    DataImportacao: TDate;               // Data da importação
    HoraDaImportacao: TTime;             // Hora da importação
    UrlImportacao: string;               // Url da Importacao
    TextoIdentificadorUnicoTransacao: string; // Id da Transação no banco
    ContaBancaria: TContaBancaria;
  end;

implementation

end.
