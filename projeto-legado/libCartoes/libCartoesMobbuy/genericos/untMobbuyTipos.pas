unit untMobbuyTipos;

interface

Uses System.Classes, System.SysUtils, System.Generics.Collections;

const
  NOME_CONCILIACAO  = 'MOBBUY';
  AUTCOM_STYLE_NAME = 'Sapphire Kamri';

type
  TMobbuyRegistroPgto = class
  public
    CodigoEstabelecimento,
    TipoRegistro,
    DataTransacao,
    DataVenda,
    DataImportacao,
    DataPagamento,
    DescricaoBandeira,
    Tipo,
    Lancamento,
    NumNSU,
    Autorizacao,
    Status,
    Parcela,
    TotalParcelas,
    Chave,
    NomeCedente,
    CodigoBanco,
    NumConta,
    DigitoConta,
    CodAgencia,
    CessaoId,
    CessaoNF: String;

    ValorBruto,
    ValorDesconto,
    ValorLiquido: Double;
  end;

  TParcelaVenda = class
  public
    Parcela: String;
    Plano: String;
    Antecipado: string;
    ArquivoPagamento: string;
    DataPagamento: string;
    DataVencimento: string;
    DataVencimentoOriginal: string;
    StatusPagamento: string;
    ValorOriginalParcela: Double;
    ValorPagamento: Double;
  end;

  TVendaAnalitica = class
  public
    Autorizacao: string;
    Bandeira: string;
    CpfCnpjStr: string;
    Data: string;
    DthrRegistro: string;
    Estabelecimento: string;
    Hora: string;
    LiquidoEC: Double;
    Movimento: String;
    Nsu: string;
    NsuOriginal: string;
    Operacao: string;
    POS: string;
    Parceiro: string;
    Parcela: String;
    Produto: string;
    Registro: Int64;
    Serial: string;
    Taxa: Currency;
    TerminalId: string;
    ValorParcela: Double;
    ValorTransacao: Double;
    Parcelas: TObjectList<TParcelaVenda>;
    constructor Create;
    destructor Destroy; override;
  end;

type
  TMobbuyRegistroVenda = class
  public
    MovTrnID              : string;
    CodigoEstabelecimento : string;
    DataTransacao         : string;
    DataVenda             : string;
    HoraVenda             : string;
    PosNumero             : string;
    PosNumeroSerie        : string;
    NumeroCartao          : string;
    NSU                   : string;
    Autorizacao           : string;
    CodigoTransacao       : string;
    TipoProduto           : string;
    BandeiraCodigo        : string;
    DescricaoBandeira     : string;
    QuantidadeParcelas    : Integer;
    ValorTransacao        : Currency;
    ValorDescontoVenda    : Currency;
    ValorLiquidoSub       : Currency;
    ValorLiquidoEst       : Currency;
    GbpTxaAdm             : Currency;
    GbpTxaInt             : Currency;
    GbpTxaAnt             : Currency;
    BfaCustoCapital       : Currency;
    BfaTxaAdm             : Currency;
    BfaTxaFin             : Currency;
    BfaCustoTransacao     : Currency;
    BfaTarifaCredito      : Currency;
    BfaTxaAnt             : Currency;
    ParceiroCodigo        : string;
    ParceiroNome          : string;
    TaxaEfetivaAdq        : Double;
    TaxaEfetivaGlobal     : Double;
    MotivoAjusteCod       : string;
    MOB_TIPO              : string;
    MOB_TIPREG            : string;
    MOB_STATUS            : string;
    DataImportacao        : string;
  end;

type
  TMobbuyRegistroParcela = class
  public
    MovTrnID           : string;
    IdMovimentoParcela : Int64;
    NumPV              : string;
    DataTransacao      : string;
    DataVenda          : string;
    DataPagamento      : string;
    NumNSU             : string;
    CodAut             : string;
    NumPar             : Integer;
    TotPar             : Integer;
    DtaVct             : string;
    Status             : string;
    DtaLiq             : string;
    ParBru             : Currency;
    PagLiq             : Currency;
    Pag                : Currency;
    TxAdm              : Currency;
    CstPln             : Currency;
    CstEst             : Currency;
    TxFin              : Currency;
    TarCre             : Currency;
    ArbLot             : Integer;
    ArbSeq             : Integer;
    ArbLot2            : Integer;
    AnpDesc            : string;
    AnpNum             : string;
    Concil             : Integer;
  end;

  TMobbuyRegistroAjuste = class
  public
    CodigoEstabelecimento : string;
    CNPJ                  : string;
    DataPagamento         : string;
    DataVenda             : string;
    DataExpedicao         : string;
    DataImportacao        : string;
    NSU                   : string;
    Autorizacao           : string;
    NumeroDebito          : string;
    NumeroPedido          : string;
    Tipo                  : string;
    TipReg                : string;
    Status                : string;
    MotivoCod             : string;
    Desaju                : string;
    ValorAjuste           : Currency;
    ValorPago             : Currency;
    Conciliado            : Integer;
  end;

implementation

constructor TVendaAnalitica.Create;
begin
  inherited;

  Parcelas := TObjectList<TParcelaVenda>.Create(True);
end;

destructor TVendaAnalitica.Destroy;
begin
  If Assigned(Parcelas) Then
    FreeAndNil(Parcelas);
  inherited;
end;

end.

