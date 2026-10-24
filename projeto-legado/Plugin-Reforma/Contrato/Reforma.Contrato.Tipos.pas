unit Reforma.Contrato.Tipos;

// Tipos que cruzam a fronteira exe/DLL. Somente records sem classes:
// cada lado tem a sua copia da VCL, entao nenhuma classe atravessa.

interface

const
  QUANTIDADE_TABELAS_PRECO = 7;

  // Campo virtual de IDadosProduto.ValorNumerico, com o numero da tabela no fim (1..7): reducao TARE (%) que
  // a aba 1 do host aplica naquela tabela. So o host que tem TARE na aba 1 (150.x) responde; nos outros o
  // campo nao existe e vem zero, sem reducao.
  CAMPO_REDUCAO_TARE = 'REFTRI_REDUCAO_TARE';
  // Contrato 13 (teste de 2026-10-15): o que a aba 1 mostra da TARE, para a aba 3 exibir igual (somente leitura).
  // CAMPO_PERCENTUAL_TARE + tabela: PRO_REDTAR da tabela, com ou sem o "Utiliza". CAMPO_USA_TARE + tabela: 1 quando a
  // tabela esta marcada para usar a reducao (PRO_USATAR = 'S'). Zero nos hosts sem TARE.
  CAMPO_PERCENTUAL_TARE = 'REFTRI_PERCENTUAL_TARE';
  CAMPO_USA_TARE = 'REFTRI_USA_TARE';

type
  TLadoSimulacao = (lsNovo, lsFuturo);

  TOpcaoCalculo = (ocPrecoVenda, ocMargem);

  TEstadoCadastro = (ecConsulta, ecInclusao, ecAlteracao);

  TDescontosFornecedor = array[1..6] of Double;

  // Valores de configuracao (CFGSIS) ja convertidos pelo host.
  // DecimaisUnitarios ja vem limitado ao tamanho do preco em ITEGER (como a calculadora faz).
  // RecalculaPrecoPelaMargem e VENMAR = 1: recalcular o preco de venda em vez da margem.
  // TabelaAtiva vem de TABPRC ('S'/'N' por tabela, completado com 'N' ate 7).
  TConfiguracaoReforma = record
    DecimaisUnitarios: Integer;
    FormulaCusto: Integer;
    MargemMarkup: Integer;
    UsaSuframa: Boolean;
    ExibeComissao: Boolean;
    ReduzImpostoFederal: Boolean;
    RecalculaPrecoPelaMargem: Boolean;
    // fPreMat: empresa que recebe os precos da matriz. A calculadora nao recalcula custo nem tabelas.
    PrecosDaMatriz: Boolean;
    TabelaAtiva: array[1..QUANTIDADE_TABELAS_PRECO] of Boolean;
    // Tabela padrao da empresa (EMP_TABPAD), usada no Fator Tabela (RN12, exclusivo 150.x).
    TabelaPadrao: Integer;
  end;

  // Os lados Novo e Futuro usam os mesmos campos do produto no host; so CBS, IBS e IS sao novos.
  // Os campos Suframa so valem com UsaSuframa e FormulaCusto = 4; fora disso o host os ignora.
  TCustoEntrada = record
    PrecoCompra: Double;
    Descontos: TDescontosFornecedor;
    IcmsEntrada: Double;
    IpiEntrada: Double;
    FreteEntrada: Double;
    ValorFrete: Double;
    AcrescimoFinanceiro: Double;
    Substituicao: Double;
    SubFederal: Double;
    DescontoAdicional: Double;
    SuframaTcif: Double;
    SuframaTs: Double;
    SuframaDescontoPisCofins: Double;
    SuframaDescontoIcms: Double;
    SuframaFatorRegional: Double;
    ConverterMoeda: Boolean;
  end;

  // Campos do produto como no cadastro: ImpostoFederal = ITE_IMPFED, DespesaOperacional = ITE_DESOPE.
  // O host so aplica a formula.
  TCustoRealEntrada = record
    PrecoCusto: Double;
    OutrosValores: Double;
    IcmsSaida: Double;
    ImpostoFederal: Double;
    DespesaOperacional: Double;
  end;

  // O host resolve sozinho o que depende do produto (ICMS-ST, codigo ABF,
  // estado da empresa) a partir de TabelaPreco e do item em edicao.
  TVendaEntrada = record
    TabelaPreco: Integer;
    PrecoCusto: Double;
    OutrosValores: Double;
    PrecoVenda: Double;
    MargemBruta: Double;
    IcmsSaida: Double;
    ImpostoFederal: Double;
    DespesaOperacional: Double;
    Comissao: Double;
    PrecoCompraLiquido: Double;
    IpiEntrada: Double;
  end;

  TAliquotasReforma = record
    Cbs: Double;
    Ibs: Double;
    ImpostoSeletivo: Double;
  end;

  // REFTRI-01: como a gravacao do produto levou os precos a outra empresa ou a outro item, para a REFPRE acompanhar.
  //  trCopia: precos copiados sem recalculo (grupo de preco ITE_CODGPR; outras empresas sem CFG_INFMAT).
  //  trConfiguracaoPropria: CFG_INFMAT - preco e comissao copiados; a despesa operacional pode ser a da empresa
  //    (DespesaDaEmpresa) e a margem e refeita pelo custo e pelas configuracoes dela, mantendo o preco.
  //  trSoCusto: empresa fora do grupo de preco da matriz alcancada porque a logada e a responsavel pelo fornecedor;
  //    so o custo foi copiado. RecalculaMargem diz se o host refez a margem dela.
  TTipoReplicacao = (trCopia, trConfiguracaoPropria, trSoCusto);

  TAlvoReplicacao = record
    CodigoEmpresa: string;
    CodigoItem: string;
    Tipo: TTipoReplicacao;
    DespesaDaEmpresa: Boolean;
    RecalculaMargem: Boolean;
  end;

  TAlvosReplicacao = array of TAlvoReplicacao;

implementation

end.