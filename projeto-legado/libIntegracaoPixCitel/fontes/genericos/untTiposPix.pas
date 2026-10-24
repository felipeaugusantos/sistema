unit untTiposPix;

interface

Uses
{$IFDEF LINUX}
{$ELSE}
  Vcl.Forms,
  WinAPI.Windows,
{$ENDIF}
  System.Classes,  System.SysUtils,
  System.Generics.Collections;

Type
  TDadosToken = class
  public
    Banco,
    Empresa,
    Portador,
    Token: String;

    DataLimite: TDateTime;
  end;

Type
  TDadosCertificado = class
  public
    Banco,
    Empresa,
    Portador,
    ArquivoCRT,
    ArquivoKey,
    ASenhaCertificado: String;
  end;

Type
  TDadosRetornoConversorCertificadoCitel = class
  public
    ArquivoPfx,
    ArquivoCrt,
    ArquivoKey,
    ArquivoRaiz,
    Intermediario01,
    Intermediario02,
    Intermediario03,
    EmpresaCertificado,
    CNPJCertificado,
    DadosCertificado,

    SenhaCertificado: String;
  end;

Type
  TDadosRequisicaoPixAVista = Class(TInterfacedObject)
    Expiracao: Integer;

    TipoDevedor,
    CPFCNPJDevedor,
    NomeDevedor,

    Valor,

    ChavePix,
    SolicitacaoPagador,

    LinkCitel,

    TextoItemShipay,
    TipoCobranca,
    UtilizaShipay,
    Banco208: String;

    InformacoesAdicionais: Array[0..49, 0..49] Of String;
    UtilizaTefScope: String;

    TransactionType: String;
  end;

Type
  TDadosRetornoPixAVista = Class(TInterfacedObject)
    Status,
    Expiracao,
    LinkQrCode,
    TextoQrCode,
    Txid,
    Revisao,

    TipoDoDevedor,
    CPFCNPJDevedor,
    NomeDevedor,

    ChavePix,
    SolicitacaoPagador,
    AutoIncremChavePix,
    AutoIncremMovPix,

    LinkCitel,

    InformacoesAdicionais,

    JsonRetorno,
    JsonRequisicao,
    CriadoPelo,

    OrderRef,
    TipoCobranca,
    UtilizaShipay,
    ChaveParaCreditoCliente,

    DataCriacaoString,

    CodigoEmpresa,
    AutoIncremsFatGor: String;

    Valor: Double;

    DataCriacao: TDateTime;
    UtilizaTefScope: String;
  end;

Type
  TDadosRetornoPixDevolucao = class(TInterfacedObject)
    Id,
    rtrId,
    Status,
    Motivo,

    JsonRetorno: String;

    Valor: Double;

    DataSolicitacao,
    DataDevolucao: TDateTime;
  End;

Type
  TDadosRetornoPixConsulta = class(TInterfacedObject)
  public
    Status,
    Expiracao,
    LinkQrCode,
    TextoQrCode,
    Txid,
    Revisao,
    EndToEndId,

    CPFCNPJDevedor,
    NomeDevedor,

    CPFCNPJPagador,
    NomePagador,

    ChavePix,
    SolicitacaoPagador,
    InformacaoPagador,

    InformacoesAdicionais,

    CodigoEmpresa,
    CodigoPortador,
    PlanoDeContas,
    AutoIncremMovPix,
    AutoIncremChavePix,
    MovbanBaixa,
    SeqLanTransferencia,
    NumeroDoPedido,
    CodigoDoCliente,
    NumeroDasDuplicatas,
    CodigoOperadorRobo,

    JsonRetorno,
    JSonChavePix,
    JSonRequisicao,

    LinkCitel,

    CodigoDoCaixa,
    RecebidoPeloF11,
    OrigemAdiantamento,
    CriadoPelo,

    CodigoOperadorMovPix,
    TxBolCadRec: String;

    Valor,
    ValorPago: Double;

    DataCriacao,
    DataPagamento,
    DataCaixa,
    DataGravacaoMovBan: TDateTime;

    DataCriacaoString,
    DataPagamentoString,

    Devolucoes,

    OrderRef,
    TipoCobranca,
    UtilizaShipay,
    ChaveParaCreditoCliente: String;

    SeqConRecebimento,
    SeqConTransferencia,
    QuantidadeDevolucoes: Integer;

    DadosDevolucao: TList<TDadosRetornoPixDevolucao>;
    UtilizaTefScope: String;
  End;

Type
  TDadosRetornoPixConsultaRecebidos = class
  public
    Status,

    CPFCNPJPagador,
    NomeDevedor,

    NomePagador,
    informacaoPagador,
    TxId,
    EndToEndId,

    Devolucoes: String;

    Valor: Double;

    DataPagamento: TDateTime;
  End;

Type
  TDadosPixDaVenda = record
    GerarPixDaVenda,
    AlterarCondicaoDePagamento,
    JaGerouPix: Boolean;

    TxIdPix,
    EmpresaDoPix,
    QrCodePix,
    TextoDoPix,
    JSonRetorno,
    LinkCitel,

    AutoIncremsPedidosPixGerar,

    TxIdPixRemover,
    EmpresaDoPixRemover,

    UtilizaShipay,

    Homologacao: String;

    ValorDoPix: Double;

    InformacoesAdicionais: Array[0..49, 0..49] Of String;

    ObjetoPixPago: TDadosRetornoPixConsulta;
    LstPixPago: TList<TDadosRetornoPixConsulta>;

    ListaPixPedidos: TList<TDadosRetornoPixAVista>;

    ListaPixGeradosNaTelaQRCode: TStringList;

    RecebidoPorPix,
    PixJaLancadoMOVPIX: String;
  end;

Type
  TPixRemovidoAPI = class
    AutoIncrem,
    JsonRecebido: String;
  End;

Type
  TNovaCobrancaPix = record
    AutoIncrem,
    TxIdPix,
    CodigoEmpresa,
    JsonEnviado,
    JsonRecebidoCriacao,
    JsonRecebidoConsulta,
    Status,
    AutoIncremChavePix,
    CodigoCliente,
    ChaveDocumento: String;

    ValorDocumento: Double;

    Expiracao: Int64;

    DataLocalCriacao,
    DataUltimaConsulta,
    DataLocalPagamento: TDateTime;

    UtilizaShipay: Boolean;
    UtilizaTefScope: String;
  end;

Type
  TDadosWebhook = class
  public
    ClientId,
    ClientSecret,
    Status,
    CNPJCliente,
    MensagemRetorno,
    DataStatus,

    CertificadoCrt,
    CertificadoKey: String;

    ValidadeCertificado: TDateTime;
  end;

Type
  TTipoRequisicaoPix = (trpNenhum,
                        trpToken,
                        trpCriarCobranca,
                        trpConsultarCobranca,
                        trpAlterarCobranca,
                        trpSolicitarDevolucao);

{$IFNDEF LINUX}
Type
  TMonitorRecebimentosPix = class
  strict private
    class function GetExeName: String; static;
  public
    const
      ID_INATIVIDADE_MONITOR = 'TESTE_INATIVIDADE_PIX_%s';
      TEMPO_LIMITE_MONITOR = 30;
      ID_MONITOR = 'MONITOR_RECEBIMENTOS_PIX_%s';
      TENTATIVAS_LOCK_MONITOR = 30;
      PARAMETROS = '%s %s';

    class var ProcessoMonitor: TProcessInformation;
    class var DataUltimaExecucaoMonitor: TDateTime;
    class var Operador: String;

    class property ExeName: string read GetExeName;
  end;
{$ENDIF}

Const
  STATUS_PIX_ATIVO: Array[0..6] of String = ('ATIVA', 'ATIVACC', 'pending', 'pendingv', 'pendingvCC', 'ACTIVE', 'ACTIVECC');
  STATUS_PIX_PAGO: Array[0..2] of String = ('CONCLUIDA', 'approved', 'PAID');
  STATUS_PIX_DEVOLVIDO: Array[0..1] of String = ('DEVOLVIDO', 'refunded');
  PIXMSG_ADT_PARCIAL : String = 'Esse pedido possui um Pix com vinculado e recebido, porém o valor foi recebido de forma parcial.' + #13 +
                                'Para continuar com o faturamento, esse pedido deve ser realizado o Estorno, gerando um crédito ' +
                                'para o cliente do valor do Pix recebido.' + #13 +
                                'Operação cancelada.';

  STATUS_PIX_ATIVO_SQL: String = '"ATIVA", "ATIVACC", "pending", "pendingv", "pendingvCC", "ACTIVE", "ACTIVECC"';
  STATUS_PIX_PAGO_SQL: String = '"CONCLUIDA", "approved", "PAID"';

implementation

{ TMonitorRecebimentosPix }

{$IFNDEF LINUX}
class function TMonitorRecebimentosPix.GetExeName: String;
begin
  Result := 'ConsultaPagamentosPixMonitor.exe';
end;
{$ENDIF}

end.
