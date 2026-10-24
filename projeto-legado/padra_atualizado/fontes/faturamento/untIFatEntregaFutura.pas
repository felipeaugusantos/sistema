unit untIFatEntregaFutura;

interface

type
  TTipoEntregaFutura = (tefTodos = 1,
                        tefPrevisao,
                        tefFaltaDeProduto,
                        tefAguardandoCliente,
                        tefPedidoBaixaEntregaFutura);

  TTipoTravaEstoque = (tteTodas,
                       tteNenhuma,
                       tteAutomatica,
                       tteFaltaDeProduto,
                       tteAguardandoClienteEPrevisao,
                       tteAguardandoClienteEFaltaDeProduto);

  ISqlEF = interface
  ['{FD6BB894-A998-4EE2-94CB-07CE8718CCE6}']
    function Build: String;
  end;

  IParamEF = interface
  ['{2642825C-FA7C-4141-8F59-97EAA3E812A0}']
    function Lote(const AValue: String): IParamEF; overload;
    function Lotes(const AValue: String): IParamEF; overload;
    function CodIte(const AValue: String): IParamEF; overload;
    function CodEmp(const AValue: String): IParamEF; overload;
    function PorLote(const AValue: Boolean): IParamEF; overload;
    function PorVenda(const AValue: Boolean): IParamEF; overload;
    function Auditoria(const AValue: Boolean): IParamEF; overload;
    function Reprocesso(Const AValue: Boolean): IParamEF; Overload;
    function ConverteML(const AValue: Boolean): IParamEF; overload;
    function Atualizacao(const AValue: Boolean): IParamEF; overload;
    function Faturamento(const AValue: Boolean): IParamEF; overload;
    function TipoTE(const AValue: TTipoTravaEstoque): IParamEF; overload;
    function TipoEF(const AValue: TTipoEntregaFutura): IParamEF; overload;
    function CalculaQtdPendente(const AValue: Boolean): IParamEF; overload;
    function CodCli(const AValue: String): IParamEF; overload;

    function Lote: String; overload;
    function Lotes: String; overload;
    function CodIte: String; overload;
    function CodEmp: String; overload;
    function PorLote: Boolean; overload;
    function PorVenda: Boolean; overload;
    function Auditoria: Boolean; overload;
    function Reprocesso: Boolean; Overload;
    function ConverteML: Boolean; overload;
    function Atualizacao: Boolean; overload;
    function Faturamento: Boolean; overload;
    function TipoTE: TTipoTravaEstoque; overload;
    function TipoEF: TTipoEntregaFutura; overload;
    function CalculaQtdPendente: Boolean; overload;
    function CodCli: String; overload;
  end;

  IEntregaFutura = interface
  ['{BC430A32-499F-4C28-95E1-24F38EC5A68F}']
    function fGetTabelaDocumentos(ATabela: String = '';
                                  ASomenteEstrutura: Boolean = False): String;
    function Total: Double;
  end;

  IUpdateEF = interface
  ['{34DBE84D-526C-4276-B740-06B706B979AF}']
    procedure Execute;
  end;

  IInvokerUpdateEF = interface
  ['{FAD78567-5364-4E88-BFC3-20AC4DA80A5E}']
    procedure Add(ACommand: IUpdateEF);
    procedure Execute;
  end;

implementation

end.
