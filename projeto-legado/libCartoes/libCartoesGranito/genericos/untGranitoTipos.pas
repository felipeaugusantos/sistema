unit untGranitoTipos;

interface

const
  NOME_CONCILIACAO = 'GRANITO';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

type
  TRegistroMovimentoFinanceiro = record
    TipoRegistro,                 // Tipo de registro do movimento financeiro
    SequencialRegistro,           // Sequencial do registro
    Estabelecimento,              // CNPJ do cliente
    IDTransacao,                  // ID da transação
    DataTransacao,                // Data da transação
    HoraTransacao,                // Hora da transação
    TipoTransacao,                // Tipo de transação
    TipoTransacaoDescricao,       //descrição da transação debito, credito
    BandeiraCartao,               // Bandeira do cartão (2)
    DescricaoBandeiraCartao,       //descricaobandeiracartao,
    DataPagamento,                // Data do pagamento (8)
    DataLancamento,
    TipoLancamento,               // Tipo de localização (1)
    IDTransacaoOriginal,          // ID do tornador (12)
    TipoAjuste,                   // Tipo de ajuste (1)
    DataOrigem,                   // Data de origem (8)
    CodigoSimulacao,              // Código da simulação (10)
    OrigemTransacao,              // Origem (1)
    IdtransacaoECommerce,         //Identificador único da transação E Commerce
    IdtransacaoiDTransacaoCliente,// Identificador da transação E-Commerce  gerado pelo cliente
    IdtransacaoRetCliente,        //Código de retorno da transação E Commerce
    CNPJPrincipal,                // CCNPJ do estabelecimento principal nos  casos de divisão operação
    CNPJParceiro,                 // CNPJ do parceiro (14)
    Banco,                        // Código do banco (3)
    Agencia,                      // Número da agência (5)
    Conta,                        // Número da conta (12)
    TaxaMDR,                      // Taxa de MDR (4)
    TaxaAntecipacao,              // Taxa de antecipação (4)
    TipoRegistroMovimento,        //{0 - Não se aplica  1 - Transação a crédito   2 - Transação a débito ....
    Autorizacao,
    NumeroNSU,                    // Número NSU (32)
    NumeroRecorrente,             // Número do recorrente (10)
    IDProjeto,                    // ID do projeto (4)
    ReferenciaPIX,                // Referência PIX (36)
    NSUPDV,                       // Número NSU DPV (6)
    NumeroPDV,                    // Número do PDV (6)
    CodigoSimulacaoAntecipacao,
    DocumentoVinculado  : string; // Código de simulação de antecipação (10)

    ValorBruto,                   // Valor bruto (15,2)
    ValorTaxaADM,                 // Valor administrativo (15,2)
    ValorTaxaAntecipacao,         // Valor da antecipação (15,2)
    ValorLiquido,                 // Valor líquido (15,2)
    ValorBrutoParcela,            // Valor bruto da parcela (15,2)
    ValorTaxaADMParcela,          // Valor administrativo da parcela (15,2)
    ValorTaxaAntecipacaoParcela,  // Valor antecipação da parcela (15,2)
    ValorLiquidoParcela: Double;  // Valor líquido da parcela (15,2)
    ValorIOF: Double;               // Valor do IOF (15,2)

    QuantidadeParcelas,           // Quantidade de parcelas (INT)
    NumeroParcela: integer;       // Número da parcela (INT)
  end;


  TEstruturaPgto = record
    Descricao: string;
    TipoCampo: string;
  end;

  TArrEstruturaGranitoPgto = Array of TEstruturaPgto;

  TArrRegistroGranitoMovimentoFinanceiro = Array of TRegistroMovimentoFinanceiro;

implementation

end.
