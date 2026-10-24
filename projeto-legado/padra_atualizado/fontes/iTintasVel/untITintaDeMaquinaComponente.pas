unit untITintaDeMaquinaComponente;

interface

uses
  untTintaDeMaquinaComponenteTipo;

type
  ITintaDeMaquinaComponente = interface(IInterface)
    ['{0FAE93C4-0245-4A64-B6CB-89A25C660423}']
    function GetCodIte: string;
    procedure SetCodIte(const Value: string);
    function GetDescricao: string;
    procedure SetDescricao(const Value: string);
    function GetDespesasOperacionais: Double;
    procedure SetDespesasOperacionais(const Value: Double);
    function GetIcmsSaida: Double;
    procedure SetIcmsSaida(const Value: Double);
    function GetImpostosFederais: Double;
    procedure SetImpostosFederais(const Value: Double);
    function GetOutrosValores: Double;
    procedure SetOutrosValores(const Value: Double);
    function GetPrecoCusto: Double;
    procedure SetPrecoCusto(const Value: Double);
    function GetPrecoCustoReal: Double;
    procedure SetPrecoCustoReal(const Value: Double);
    function GetPrecoMedio: Double;
    procedure SetPrecoMedio(const Value: Double);
    function GetPrecoVenda: Double;
    procedure SetPrecoVenda(const Value: Double);
    function GetQuantidade: Double;
    procedure SetQuantidade(const Value: Double);
    function GetTipo: TTintaDeMaquinaComponenteTipo;
    procedure SetTipo(const Value: TTintaDeMaquinaComponenteTipo);
    function GetUltimoPrecoCompra: Double;
    procedure SetUltimoPrecoCompra(const Value: Double);
    function GetUltimoPrecoCompraImpostos: Double;
    procedure SetUltimoPrecoCompraImpostos(const Value: Double);
    function GetPrecoCompraLiquido: Double;
    procedure SetPrecoCompraLiquido(const Value: Double);

    property CodIte: string read GetCodIte write SetCodIte;
    property Descricao: string read GetDescricao write SetDescricao;
    property DespesasOperacionais: Double read GetDespesasOperacionais write SetDespesasOperacionais;
    property IcmsSaida: Double read GetIcmsSaida write SetIcmsSaida;
    property ImpostosFederais: Double read GetImpostosFederais write SetImpostosFederais;
    property OutrosValores: Double read GetOutrosValores write SetOutrosValores;
    property PrecoCusto: Double read GetPrecoCusto write SetPrecoCusto;
    property PrecoCustoReal: Double read GetPrecoCustoReal write SetPrecoCustoReal;
    property PrecoMedio: Double read GetPrecoMedio write SetPrecoMedio;
    property PrecoVenda: Double read GetPrecoVenda write SetPrecoVenda;
    property Quantidade: Double read GetQuantidade write SetQuantidade;
    property Tipo: TTintaDeMaquinaComponenteTipo read GetTipo write SetTipo;
    property UltimoPrecoCompra: Double read GetUltimoPrecoCompra write SetUltimoPrecoCompra;
    property UltimoPrecoCompraImpostos: Double read GetUltimoPrecoCompraImpostos write SetUltimoPrecoCompraImpostos;
    property PrecoCompraLiquido: Double read GetPrecoCompraLiquido write SetPrecoCompraLiquido;    
  end;

implementation

end.
