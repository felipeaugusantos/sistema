unit untITintaDeMaquina;

interface

uses
     untITintaDeMaquinaComponente;

type
  ITintaDeMaquina = interface(IInterface)
    ['{F515FF86-59F8-415C-BED8-3997BDF2E015}']
    function GetCount: Integer;
    function GetDescontoEspecial: Double;
    procedure SetDescontoEspecial(Value: Double);
    function GetDescricao: string;
    procedure SetDescricao(const Value: string);
    function GetDespesasOperacionais: Double;
    function GetDespesasOperacionaisComponentes: Double;
    function GetDespesasOperacionaisEmbalagemBase: Double;
    function GetIcmsSaida: Double;
    function GetIcmsSaidaComponentes: Double;
    function GetIcmsSaidaEmbalagemBase: Double;
    function GetImpostosFederais: Double;
    function GetImpostosFederaisComponentes: Double;
    function GetImpostosFederaisEmbalagemBase: Double;
    function GetOutrosValores: Double;
    function GetOutrosValoresComponentes: Double;
    function GetOutrosValoresEmbalagemBase: Double;
    function GetPrecoCusto: Double;
    function GetPrecoCustoComponentes: Double;
    function GetPrecoCustoEmbalagemBase: Double;
    function GetPrecoCustoReal: Double;
    function GetPrecoCustoRealComponentes: Double;
    function GetPrecoCustoRealEmbalagemBase: Double;
    function GetPrecoMedio: Double;
    function GetPrecoMedioComponentes: Double;
    function GetPrecoMedioEmbalagemBase: Double;
    function GetPrecoVenda: Double;
    function GetPrecoVendaComponentes: Double;
    function GetPrecoVendaEmbalagemBase: Double;
    function GetQuantidade: Double;
    procedure SetQuantidade(const Value: Double);
    function GetTintaDeMaquinaComponente(const index: Integer): ITintaDeMaquinaComponente;
    function GetUltimoPrecoCompra: Double;
    function GetUltimoPrecoCompraImpostos: Double;
    function GetUltimoPrecoCompraComponentes: Double;
    function GetUltimoPrecoCompraImpostosComponentes: Double;
    function GetUltimoPrecoCompraEmbalagemBase: Double;
    function GetUltimoPrecoCompraImpostosEmbalagemBase: Double;
    function GetPrecoCompraLiquido: Double;
    function GetPrecoCompraLiquidoComponentes: Double;
    function GetPrecoCompraLiquidoEmbalagemBase: Double;

    property Count: Integer read GetCount;
    property DescontoEspecial: Double read GetDescontoEspecial write SetDescontoEspecial;
    property Descricao: string read GetDescricao write SetDescricao;
    property DespesasOperacionais: Double read GetDespesasOperacionais;
    property DespesasOperacionaisComponentes: Double read GetDespesasOperacionaisComponentes;
    property DespesasOperacionaisEmbalagemBase: Double read GetDespesasOperacionaisEmbalagemBase;
    property IcmsSaida: Double read GetIcmsSaida;
    property IcmsSaidaComponentes: Double read GetIcmsSaidaComponentes;
    property IcmsSaidaEmbalagemBase: Double read GetIcmsSaidaEmbalagemBase;
    property ImpostosFederais: Double read GetImpostosFederais;
    property ImpostosFederaisComponentes: Double read GetImpostosFederaisComponentes;
    property ImpostosFederaisEmbalagemBase: Double read GetImpostosFederaisEmbalagemBase;
    property OutrosValores: Double read GetOutrosValores;
    property OutrosValoresComponentes: Double read GetOutrosValoresComponentes;
    property OutrosValoresEmbalagemBase: Double read GetOutrosValoresEmbalagemBase;
    property PrecoCusto: Double read GetPrecoCusto;
    property PrecoCustoComponentes: Double read GetPrecoCustoComponentes;
    property PrecoCustoEmbalagemBase: Double read GetPrecoCustoEmbalagemBase;
    property PrecoCustoReal: Double read GetPrecoCustoReal;
    property PrecoCustoRealComponentes: Double read GetPrecoCustoRealComponentes;
    property PrecoCustoRealEmbalagemBase: Double read GetPrecoCustoRealEmbalagemBase;
    property PrecoMedio: Double read GetPrecoMedio;
    property PrecoMedioComponentes: Double read GetPrecoMedioComponentes;
    property PrecoMedioEmbalagemBase: Double read GetPrecoMedioEmbalagemBase;
    property PrecoVenda: Double read GetPrecoVenda;
    property PrecoVendaComponentes: Double read GetPrecoVendaComponentes;
    property PrecoVendaEmbalagemBase: Double read GetPrecoVendaEmbalagemBase;
    property Quantidade: Double read GetQuantidade write SetQuantidade;
    property TintaDeMaquinaComponente[const index: Integer]: ITintaDeMaquinaComponente read GetTintaDeMaquinaComponente; default;
    property UltimoPrecoCompra: Double read GetUltimoPrecoCompra;
    property UltimoPrecoCompraImpostos: Double read GetUltimoPrecoCompraImpostos;
    property UltimoPrecoCompraComponentes: Double read GetUltimoPrecoCompraComponentes;
    property UltimoPrecoCompraImpostosComponentes: Double read GetUltimoPrecoCompraImpostosComponentes;
    property UltimoPrecoCompraEmbalagemBase: Double read GetUltimoPrecoCompraEmbalagemBase;
    property UltimoPrecoCompraImpostosEmbalagemBase: Double read GetUltimoPrecoCompraImpostosEmbalagemBase;
    property PrecoCompraLiquido: Double read GetPrecoCompraLiquido;
    property PrecoCompraLiquidoComponentes: Double read GetPrecoCompraLiquidoComponentes;
    property PrecoCompraLiquidoEmbalagemBase: Double read GetPrecoCompraLiquidoEmbalagemBase;    
  end;



implementation

end.
