unit untCieloTipos;

interface

Uses System.SysUtils;

Type
  TRegistroCieloPgto015 = record
    TipoRegistro,
    CodigoEstabelecimento,
    EstabelecimentoVenda,
    CodigoBandeira,
    TipoLiquidacao,
    TipoTransacao,
    StatusPgto,
    TipoLancamento,
    TipoLancamentoOriginal,
    DataPagamento,
    DataEnvioBanco,
    DataVencimentoOriginal,
    NumeroNF,

    URsPendentes,
    URsReenviadas,
    URsNegociadas,

    TipoAntecipacao,
    NumeroAntecipacao,

    ChaveUR,

    CodigoBanco,
    CodigoAgencia,
    CodigoConta,
    DigitoConta,

    IndicativoGravame: String;

    ValorBrutoUR,
    ValorTaxaUR,
    ValorLiquidoUR,

    TaxaAntecipacao: Double;

    NumeroParcela,
    TotalParcelas,
    CodigoAutorizacao,
    CodigoAjuste,
    FormaPagameto,
    NumeroCartao,
    NumeroNSU,
    NumeroTID,
    CodigoPedido,
    CodigoVenda,
    CodigoOriginalVenda,
    NumeroOperacao,
    TipoCartao,
    TipoCaptura,

    DataTransacao,
    DataCaptura,
    DataMovimento,
    DataMovimentoOriginal,

    GrupoCartoes,

    MeioCaptura,
    NumeroTerminal :String;

    ValorBrutoVenda,
    ValorBrutoParcela,
    ValorTaxaRecebaRapido,
    ValorTaxaMDR,

    ValorComissao,
    ValorComissaoMinima,
    ValorTarifaAdministrativa,
    ValorLiquidoVenda,

    ValorAjuste: Double;

    QuantidadeLancamentosUR,
    IndicativoRecebaRapido,
    IndicativoTaxaZero,
    IndicativoTransacaoRejeitada,
    IndicativoTardia,

    CodigoTransacaoContrato,
    NumeroLote,
    NumeroTransacaoProcessada,
    MotivoRejeicao,

    OrigemAjuste,
    TipoNegociacao,
    VencimentoOriginal,

    DataArquivo,
    NomeArquivo,
    TipoArquivo: String;

    CalculaLiqDeb: Boolean;

    VersaoArquivo: String;
  End;

Type
  TArrRegistroCieloPgto015  = Array Of TRegistroCieloPgto015;

TRegistroPgto = Record
    strTipReg: String;
    strCodEst: String;
    strNum_RO: String;
    strDtaApr: String;
    strDtaPag: String;
    fltRO_Bru: Double;
    fltRO_Com: Double;
    fltRO_Rej: Double;
    fltRO_Liq: Double;
    strCodBco: String;
    strCodAge: String;
    strNumCco: String;
    strStatus: String;
    strNumAnt: String;
    fltBruAnt: Double;
    fltPorCom: Double;
    strNumCar: String;
    strDtaVen: String;
    fltValPar: Double;
    strNumPar: String;
    strTotPar: String;
    strCodAut: String;
    strCodPID: String;
    strNumNSU: String;
    fltValTot: Double;
    fltValPro: Double;
    strNum_NF: String;
    strNumTer: String;
    strDtaAnt: String;
    strTipCar: String;
    strNomArq: String;
    strDtaArq: String;
    strTipFin: String;
    strTipTra: String;
    fltLiqAnt: Double;
    strRO_Deb: String;
    fltLiqDeb: Double;
    CalculaLiqDeb: Boolean;

    OrigemAjuste,
    CodigoProduto,
    CodigoBandeira,
    TipoNegociacao,
    VencimentoOriginal,

    VersaoArquivo: String;
  End;

  TEstruturaPgto = Record
    strDescri: String;
    strTipCmp: String;
  End;

  TArrRegistroCieloPgto  = Array Of TRegistroPgto;

  TArrEstruturaCieloPgto  = Array Of TEstruturaPgto;

  {* Conciliação Ajustes - Por Região *}
  TRegistroCartaoEstabelecimentoPorRegiao = class
  private
    FNumLiberacao: String;
    FNSU: String;
    FDtaVencimento: TDate;
    FDtaCadastro: TDate;
    FDtaVenda: TDate;
    FValor: Double;
    FValorSemTaxa: Double;
    FParcela: String;
    FCodigoEmpresa: String;
    FNomeEmpresa: String;
  public
    property NumLiberacao: String read FNumLiberacao;
    property NSU: String read FNSU;
    property DtaVencimento: TDate read FDtaVencimento;
    property DtaCadastro: TDate read FDtaCadastro;
    property DtaVenda: TDate read FDtaVenda;
    property Valor: Double read FValor;
    property ValorSemTaxa: Double read FValorSemTaxa;
    property Parcela: String read FParcela;
    property CodigoEmpresa: String read FCodigoEmpresa;
    property NomeEmpresa: String read FNomeEmpresa;

    constructor Create(
      ANumLiberacao: String;
      ANSU: String;
      ADtaVencimento: TDate;
      ADtaCadastro: TDate;
      ADtaVenda: TDate;
      AValor: Double;
      AValorSemTaxa: Double;
      AParcela: String;
      ACodigoEmpresa: String;
      ANomeEmpresa: String);
  end;

  TFuncaoRetornaCodigoEmpresa = reference to function(ANumLiberacao, ANSU, AParcela: String; ADtaVenda: TDate): String;

  {* Exclusão arquivos *}
  type
  IOperadora = interface
    function fGetColunaDTAARQ: string;
    function fGetColunaNOMARQ: string;
    function fGetColunaCONCIL: string;
    function fGetDireitoAcesso: string;
    function fGetNomeRotina: string;
    function fGetTabela: string;
    function fGetNomeOperadora: string;

    property ColunaDTAARQ: string read fGetColunaDTAARQ;
    property ColunaNOMARQ: string read fGetColunaNOMARQ;
    property ColunaCONCIL: string read fGetColunaCONCIL;
    property DireitoAcesso: string read fGetDireitoAcesso;
    property NomeRotina: string read fGetNomeRotina;
    property Tabela: string read fGetTabela;
    property NomeOperadora: string read fGetNomeOperadora;
  end;

  TCieloExclusao = class(TInterfacedObject, IOperadora)
  private
    function fGetColunaDTAARQ: string;
    function fGetColunaNOMARQ: string;
    function fGetColunaCONCIL: string;
    function fGetDireitoAcesso: string;
    function fGetNomeOperadora: string;
    function fGetNomeRotina: string;
    function fGetTabela: string;
  end;

implementation

{ TRegistroCartaoEstabelecimentoPorRegiao }

constructor TRegistroCartaoEstabelecimentoPorRegiao.Create(ANumLiberacao,
  ANSU: String; ADtaVencimento, ADtaCadastro, ADtaVenda: TDate; AValor,
  AValorSemTaxa: Double; AParcela: string; ACodigoEmpresa: String;
  ANomeEmpresa: String);
begin
  FNumLiberacao := ANumLiberacao;
  FNSU := ANSU;
  FDtaVencimento := ADtaVencimento;
  FDtaCadastro := ADtaCadastro;
  FDtaVenda := ADtaVenda;
  FValor := AValor;
  FValorSemTaxa := AValorSemTaxa;
  FParcela := AParcela;
  FCodigoEmpresa := ACodigoEmpresa;
  FNomeEmpresa := ANomeEmpresa;
end;

{ TCieloExclusao }

function TCieloExclusao.fGetColunaCONCIL: string;
begin
  Result := 'CIE_CONCIL';
end;

function TCieloExclusao.fGetColunaDTAARQ: string;
begin
  Result := 'CIE_DTAARQ';
end;

function TCieloExclusao.fGetColunaNOMARQ: string;
begin
  Result := 'CIE_NOMARQ';
end;

function TCieloExclusao.fGetDireitoAcesso: string;
begin
  Result := 'mnuExcluirArquivoDaCielo';
end;

function TCieloExclusao.fGetNomeOperadora: string;
begin
  Result := 'Cielo';
end;

function TCieloExclusao.fGetNomeRotina: string;
begin
  Result := 'Excluir arquivos importados da Cielo';
end;

function TCieloExclusao.fGetTabela: string;
begin
  Result := 'CIE_CIPGTO';
end;

end.
