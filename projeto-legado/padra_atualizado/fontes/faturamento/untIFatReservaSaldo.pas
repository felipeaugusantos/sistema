unit untIFatReservaSaldo;

interface

type
  TTipoReservaSaldo = (trsTodos = 1,
                       trsPedidoVenda,
                       trsGarantia,
                       trsOrdemProducao,
                       trsPedidoVendaCli,
                       trsPedidoVendaFil,
                       trsEnderecamento,
                       trsTransferencia,
                       trsExterno,
                       trsPedidoBaixaEntregaFuturaSaldoFisico,
                       trsPedidoBaixaEntregaFuturaReservSaldo,
                       trsLocalizacaoCritica);

  TTipoFiltroDocumento = (tfdTodos,
                          tfdFiltrarDocumento,
                          tfdIgnorarDocumento,
                          tfdIgnorarDocumentosOnda);

  IReservaParametros = Interface
  ['{699CD8E0-3FAA-40B9-A825-82CC69097885}']
    function SeqFdo(Const Value: String): IReservaParametros; Overload;
    function CodigoItem(Const Value: String): IReservaParametros; Overload;
    function CodEmpresa(Const Value: String): IReservaParametros; Overload;
    function NumeroLote(Const Value: String): IReservaParametros; Overload;
    function EmpresaItem(Const Value: String): IReservaParametros; Overload;
    function ConverterML(Const Value: Boolean): IReservaParametros; Overload;
    function EhAuditoria(Const Value: Boolean): IReservaParametros; Overload;
    function EhReprocesso(Const Value: Boolean): IReservaParametros; Overload;
    function CodItemAcabado(Const Value: String): IReservaParametros; Overload;
    function EmpItemAcabado(Const Value: String): IReservaParametros; Overload;
    function EhAtualizacao(Const Value: Boolean): IReservaParametros; Overload;
    function NumeroDocumento(Const Value: String): IReservaParametros; Overload;
    function FiltrarEmpresa(Const Value: Boolean): IReservaParametros; Overload;
    function QtdDiaPrevisao(Const Value: Integer): IReservaParametros; Overload;
    function DtaPrevisaoFinal(Const Value: TDate): IReservaParametros; Overload;
    function DtaPrevisaoInicial(Const Value: TDate): IReservaParametros; Overload;
    function ApenasSemRequisicao(Const Value: Boolean): IReservaParametros; Overload;
    function TipoReserva(Const Value: TTipoReservaSaldo): IReservaParametros; Overload;
    function ApenasPedidosLiberados(Const Value: Boolean): IReservaParametros; Overload;
    function DesconsideraPedidosCorte(Const Value: Boolean): IReservaParametros; Overload;
    function DesconsideraPedidosEnderecamento(Const Value: Boolean): IReservaParametros; Overload;
    function TipoFiltroDocumento(Const Value: TTipoFiltroDocumento): IReservaParametros; Overload;
    function TabelaAudit(Const Value: String): IReservaParametros; Overload;

    function SeqFdo: String; Overload;
    function CodigoItemBase: String;
    function ItemEhPigmento: Boolean;
    function CodigoItem: String; Overload;
    function CodEmpresa: String; Overload;
    function NumeroLote: String; Overload;
    function EmpresaItem: String; Overload;
    function EhAuditoria: Boolean; Overload;
    function ConverterML: Boolean; Overload;
    function EhReprocesso: Boolean; Overload;
    function CodItemAcabado: String; Overload;
    function EmpItemAcabado: String; Overload;
    function EhAtualizacao: Boolean; Overload;
    function NumeroDocumento: String; Overload;
    function FiltrarEmpresa: Boolean; Overload;
    function QtdDiaPrevisao: Integer; Overload;
    function DtaPrevisaoFinal: TDate; Overload;
    function DtaPrevisaoInicial: TDate; Overload;
    function ApenasSemRequisicao: Boolean; Overload;
    function TipoReserva: TTipoReservaSaldo; Overload;
    function ApenasPedidosLiberados: Boolean; Overload;
    function DesconsideraPedidosCorte: Boolean; Overload;
    function DesconsideraPedidosEnderecamento: Boolean; Overload;
    function TipoFiltroDocumento: TTipoFiltroDocumento; Overload;

    function fCodEmp: String;
    function fEquals(Const AValue: IReservaParametros): Boolean;

    function ItemContratoLocacao(Const Value: Boolean): IReservaParametros; Overload;
    function ItemContratoLocacao: Boolean; Overload;

    function OndaDeSeparacao(Const Value: String): IReservaParametros; Overload;
    function OndaDeSeparacao: String; Overload;

    function MotFutAConsiderar(Const Value: String): IReservaParametros; Overload;
    function MotFutAConsiderar: String; Overload;

    function TabelaAudit: String; Overload;
  end;

  ISaldoReservado = Interface
  ['{3565616B-FB97-4F4E-9928-AD0E6A219EF2}']
    function fGetQuantidade: Double;
    function fGetTabelaDocumentos(ATabela: String = '';
                                  ASomenteEstrutura: Boolean = False): String;
  end;

  IUpdateReserva = Interface
  ['{426C3BC6-0879-4025-A387-11F7C2D2984C}']
    function fExecutarItem: IUpdateReserva;
    function fExecutarLote: IUpdateReserva;
  end;

  IInvokerUpdateReserva = Interface
  ['{3E08E785-7FA2-43FC-94BC-C5BBED5CDE5C}']
    procedure pAdd(ACommand: IUpdateReserva);
    function fExecutarItem: IInvokerUpdateReserva;
    function fExecutarLote: IInvokerUpdateReserva;
  end;

implementation

end.
