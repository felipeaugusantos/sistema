unit untTiposPagFor;

interface

Uses System.SysUtils, System.Classes, System.StrUtils;

Type
  TTipoPagamento = (tppBoletos,
                    tppGuiaComCodigoBarras,
                    tppTransferencias,
                    tppTransferenciasSalario,
                    tppTransferenciasPix,
                    tppGPS,
                    tppGRU,
                    tppDARF);

Type
  TPagForAPIDadosCarteira = class
  public
    CodigoBanco,
    Configuracao,
    ConfiguracaoSemEmpresa,
    CodigoEmpresa,

    SequencialRemessa,
    CodigoConvenio,
    CodigoCarteira,
    NumeroCarteira,
    CodigoCompromisso,
    Contrato,
    CodigoAgencia,
    DigitoAgencia,
    ContaCorrente,
    DigitoContaCorrente,
    OperacaoConta,

    Portador,
    PlanoDeContas,
    CentroDeCustos,

    DiasCredito,
    AvisoFavorecido,
    SolicitaDataPagto,
    LiberarPagamento,

    ChaveAppAPI,
    ClientId,
    ClientSecret,
    CertificadoPfx,
    SenhaCertificado,
    ChaveBasic,

    Homologacao: String;

    constructor Create(ACodigoBanco, AConfiguracao: String); overload;
  end;

Type
  TPagForRetorno = class
  public
    Tipo,
    AutoIncremDuplicata,
    NumeroDuplicata,
    EmpresaDuplicata,
    CodigoFornecedor,
    ParcelaDuplicata,
    SerieDuplicata,
    SeqBaiDuplicata,
    NumeroLotePagamento,

    IDPagamento,
    BancoFavorecido,
    NossoNumero,
    DataOcorrencia,
    DataPagamento,
    DataVencimento,
    CodigoBarras,

    Desconto,
    ValorDuplicata,
    ValorPago,
    ValorJuros,
    ValorDesconto,

    CodigosOcorrencia,
    MotivosOcorrencia,

    DuplicataExisteCadPag,
    DuplicataNaoBaixada,
    DuplicataDivergente,
    MotivoDivergencia,

    EstadoPagamento: String;

    TipoPagamento: TTipoPagamento;

    constructor Create; overload;
  end;

implementation
Uses untFuncoesSimples;
{ TPagForAPIDadosCarteira }

constructor TPagForAPIDadosCarteira.Create(ACodigoBanco, AConfiguracao: String);

begin
  CodigoBanco := ACodigoBanco;
  Configuracao := AConfiguracao;
  CodigoEmpresa := RightStr(AConfiguracao, 3);
  ConfiguracaoSemEmpresa := LeftStr(AConfiguracao, AConfiguracao.Length - 4);

  SequencialRemessa := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'PROXNUM', '');
  CodigoConvenio := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'CONVENI', '');
  CodigoCarteira := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'CODCART', '');
  NumeroCarteira := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'NUMCART', '');
  CodigoCompromisso := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'CODCOMPROMI', '');
  Contrato := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'IDENTBC', '');
  CodigoAgencia := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'CODAGEN', '');
  DigitoAgencia := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'DIGAGEN', '');
  ContaCorrente := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'NUMCTAC', '');
  DigitoContaCorrente := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'DIGCTAC', '');
  OperacaoConta := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'OPERCONTA', '');

  Portador := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'PORBAI_', '');
  PlanoDeContas := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'CTABAI_', '');
  CentroDeCustos := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'EVECTP_', '');

  DiasCredito := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'DIACRED', '');
  AvisoFavorecido := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'AVISOFA', '');
  SolicitaDataPagto := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'SOLICDT', '');

  LiberarPagamento  := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'LIBPAG_', '');
  if Trim(LiberarPagamento).IsEmpty then
    LiberarPagamento := 'S';

  ChaveAppAPI := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'KEY_USER', '');
  ClientId := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'CLIENT_ID', '');
  ClientSecret := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'CLIENT_SECRET', '');
  CertificadoPfx := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'AUTHPFX', '');
  SenhaCertificado := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'AUTHSEN', '');
  ChaveBasic := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'AUTHORIZATION', '');

  Homologacao := fGetBancoConfig(0, ConfiguracaoSemEmpresa, 'HOMOLOGACAO', '');
end;

{ TPagForRetorno }

constructor TPagForRetorno.Create;
begin
  AutoIncremDuplicata := EmptyStr;
  NumeroDuplicata := EmptyStr;
  EmpresaDuplicata := EmptyStr;
  CodigoFornecedor := EmptyStr;
  ParcelaDuplicata := EmptyStr;
  SerieDuplicata := EmptyStr;
  SeqBaiDuplicata := EmptyStr;

  IDPagamento := EmptyStr;
  BancoFavorecido := EmptyStr;
  NossoNumero := EmptyStr;
  DataOcorrencia := EmptyStr;
  DataPagamento := EmptyStr;
  DataVencimento := EmptyStr;
  CodigoBarras := EmptyStr;

  Desconto := EmptyStr;
  ValorDuplicata := EmptyStr;
  ValorPago := EmptyStr;
  ValorJuros := EmptyStr;
  ValorDesconto := EmptyStr;

  CodigosOcorrencia := EmptyStr;
  MotivosOcorrencia := EmptyStr;

  DuplicataExisteCadPag := 'N';
  DuplicataNaoBaixada := 'N';
  DuplicataDivergente := 'N';
  MotivoDivergencia := EmptyStr;

  TipoPagamento := tppBoletos;
end;

end.
