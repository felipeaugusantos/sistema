unit untGenericTintaDeMaquinaComponente;

interface

uses
  untTintaDeMaquinaComponenteTipo, untITintaDeMaquinaComponente,
   SysUtils;

type
  TGenericTintaDeMaquinaComponente = class(TInterfacedObject,
      ITintaDeMaquinaComponente)
  private
    fltDespesasOperacionais: Double;
    fltIcmsSaida: Double;
    fltImpostosFederais: Double;
    fltOutrosValores: Double;
    fltPrecoCusto: Double;
    fltPrecoCustoReal: Double;
    fltPrecoMedio: Double;
    fltPrecoVenda: Double;
    fltQuantidade: Double;
    strCodIte: string;
    strDescricao: string;
    tmctTipo: TTintaDeMaquinaComponenteTipo;
    fltUltimoPrecoCompra: Double;
    fltUltimoPrecoCompraImpostos: Double;
    fltPrecoCompraLiquido: Double;
  public
    constructor Create(const strCodIte, strDescricao: string; const
        fltDespesasOperacionais, fltIcmsSaida, fltImpostosFederais,
        fltOutrosValores, fltPrecoCusto, fltPrecoCustoReal, fltPrecoMedio,
        fltPrecoVenda, fltQuantidade: Double; const tmctTipo:
        TTintaDeMaquinaComponenteTipo; const fltUltimoPrecoCompra: Double;
        const fltUltimoPrecoCompraImpostos: Double; const fltPrecoCompraLiquido: Double); overload;
    constructor Create(const strCodIte, strDescricao: string; const
        fltDespesasOperacionais, fltIcmsSaida, fltImpostosFederais,
        fltOutrosValores, fltPrecoCusto, fltPrecoCustoReal, fltPrecoMedio,
        fltPrecoVenda, fltQuantidade: Double; const tmctTipo:
        TTintaDeMaquinaComponenteTipo); overload;
    constructor Create(const strCodIte, strDescricao: string; const tmctTipo:
        TTintaDeMaquinaComponenteTipo); overload;
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

procedure pAplicarAcrescimoPrecoVenda(const aComponente: ITintaDeMaquinaComponente; const aPerAcr: Double);

implementation

procedure pAplicarAcrescimoPrecoVenda(const aComponente: ITintaDeMaquinaComponente; const aPerAcr: Double);
begin
  aComponente.PrecoVenda           := aComponente.PrecoVenda           * (1 + aPerAcr);
  aComponente.IcmsSaida            := aComponente.IcmsSaida            * (1 + aPerAcr);
  aComponente.ImpostosFederais     := aComponente.ImpostosFederais     * (1 + aPerAcr);
  aComponente.DespesasOperacionais := aComponente.DespesasOperacionais * (1 + aPerAcr);
end;

{ TTintaDeMaquinaComponente }

{
*********************** TGenericTintaDeMaquinaComponente ***********************
}
constructor TGenericTintaDeMaquinaComponente.Create(const strCodIte,
    strDescricao: string; const fltDespesasOperacionais, fltIcmsSaida,
    fltImpostosFederais, fltOutrosValores, fltPrecoCusto, fltPrecoCustoReal,
    fltPrecoMedio, fltPrecoVenda, fltQuantidade: Double; const tmctTipo:
    TTintaDeMaquinaComponenteTipo; const fltUltimoPrecoCompra: Double;
    const fltUltimoPrecoCompraImpostos: Double; const fltPrecoCompraLiquido: Double);
begin
  inherited Create();
  Self.strCodIte := strCodIte;
  Self.strDescricao := strDescricao;
  Self.fltDespesasOperacionais := fltDespesasOperacionais;
  Self.fltIcmsSaida := fltIcmsSaida;
  Self.fltImpostosFederais := fltImpostosFederais;
  Self.fltOutrosValores := fltOutrosValores;
  Self.fltPrecoCusto := fltPrecoCusto;
  Self.fltPrecoCustoReal := fltPrecoCustoReal;
  Self.fltPrecoMedio := fltPrecoMedio;
  Self.fltPrecoVenda := fltPrecoVenda;
  Self.fltQuantidade := fltQuantidade;
  Self.tmctTipo := tmctTipo;
  Self.fltUltimoPrecoCompra := fltUltimoPrecoCompra;
  Self.fltUltimoPrecoCompraImpostos := fltUltimoPrecoCompraImpostos;
  Self.fltPrecoCompraLiquido := fltPrecoCompraLiquido;
end;

constructor TGenericTintaDeMaquinaComponente.Create(const strCodIte,
    strDescricao: string; const tmctTipo: TTintaDeMaquinaComponenteTipo);
begin
  Create(strCodIte, strDescricao, 0, 0, 0, 0, 0, 0, 0, 0, 0, tmctTipo, 0, 0, 0);
end;

constructor TGenericTintaDeMaquinaComponente.Create(const strCodIte, strDescricao: string; const fltDespesasOperacionais, fltIcmsSaida,
  fltImpostosFederais, fltOutrosValores, fltPrecoCusto, fltPrecoCustoReal, fltPrecoMedio, fltPrecoVenda, fltQuantidade: Double;
  const tmctTipo: TTintaDeMaquinaComponenteTipo);
begin
  Create(strCodIte, strDescricao, fltDespesasOperacionais, fltIcmsSaida, fltImpostosFederais, fltOutrosValores, fltPrecoCusto,
    fltPrecoCustoReal, fltPrecoMedio, fltPrecoVenda, fltQuantidade, tmctTipo, 0, 0, 0);
end;

function TGenericTintaDeMaquinaComponente.GetCodIte: string;
begin
  Result := strCodIte;
end;

procedure TGenericTintaDeMaquinaComponente.SetCodIte(const Value: string);
begin
  Self.strCodIte := value;
end;

function TGenericTintaDeMaquinaComponente.GetDescricao: string;
begin
  Result := strDescricao;
end;

procedure TGenericTintaDeMaquinaComponente.SetDescricao(const Value: string);
begin
  Self.strDescricao := value;
end;

function TGenericTintaDeMaquinaComponente.GetDespesasOperacionais: Double;
begin
  Result := fltDespesasOperacionais;
end;

procedure TGenericTintaDeMaquinaComponente.SetDespesasOperacionais(const Value:
    Double);
begin
  Self.fltDespesasOperacionais := value;
end;

function TGenericTintaDeMaquinaComponente.GetIcmsSaida: Double;
begin
  Result := fltIcmsSaida;
end;

procedure TGenericTintaDeMaquinaComponente.SetIcmsSaida(const Value: Double);
begin
  Self.fltIcmsSaida := value;
end;

function TGenericTintaDeMaquinaComponente.GetImpostosFederais: Double;
begin
  Result := fltImpostosFederais;
end;

procedure TGenericTintaDeMaquinaComponente.SetImpostosFederais(const Value:
    Double);
begin
  Self.fltImpostosFederais := value;
end;

function TGenericTintaDeMaquinaComponente.GetOutrosValores: Double;
begin
  Result := fltOutrosValores;
end;

procedure TGenericTintaDeMaquinaComponente.SetOutrosValores(const Value:
    Double);
begin
  Self.fltOutrosValores := value;
end;

function TGenericTintaDeMaquinaComponente.GetPrecoCompraLiquido: Double;
begin
  Result := fltPrecoCompraLiquido;
end;

function TGenericTintaDeMaquinaComponente.GetPrecoCusto: Double;
begin
  Result := fltPrecoCusto;
end;

procedure TGenericTintaDeMaquinaComponente.SetPrecoCompraLiquido(
  const Value: Double);
begin
  Self.fltPrecoCompraLiquido := Value;
end;

procedure TGenericTintaDeMaquinaComponente.SetPrecoCusto(const Value: Double);
begin
  Self.fltPrecoCusto := value;
end;

function TGenericTintaDeMaquinaComponente.GetPrecoCustoReal: Double;
begin
  Result := fltPrecoCustoReal;
end;

procedure TGenericTintaDeMaquinaComponente.SetPrecoCustoReal(const Value:
    Double);
begin
  Self.fltPrecoCustoReal := value;
end;

function TGenericTintaDeMaquinaComponente.GetPrecoMedio: Double;
begin
  Result := fltPrecoMedio;
end;

procedure TGenericTintaDeMaquinaComponente.SetPrecoMedio(const Value: Double);
begin
  Self.fltPrecoMedio := value;
end;

function TGenericTintaDeMaquinaComponente.GetPrecoVenda: Double;
begin
  Result := fltPrecoVenda;
end;

procedure TGenericTintaDeMaquinaComponente.SetPrecoVenda(const Value: Double);
begin
  Self.fltPrecoVenda := value;
end;

function TGenericTintaDeMaquinaComponente.GetQuantidade: Double;
begin
  Result := fltQuantidade;
end;

procedure TGenericTintaDeMaquinaComponente.SetQuantidade(const Value: Double);
begin
  Self.fltQuantidade := value;
end;

function TGenericTintaDeMaquinaComponente.GetTipo:
    TTintaDeMaquinaComponenteTipo;
begin
  Result := tmctTipo;
end;

function TGenericTintaDeMaquinaComponente.GetUltimoPrecoCompra: Double;
begin
  Result := fltUltimoPrecoCompra;
end;

function TGenericTintaDeMaquinaComponente.GetUltimoPrecoCompraImpostos: Double;
begin
  Result := fltUltimoPrecoCompraImpostos;
end;

procedure TGenericTintaDeMaquinaComponente.SetTipo(const Value:
    TTintaDeMaquinaComponenteTipo);
begin
  Self.tmctTipo := value;
end;

procedure TGenericTintaDeMaquinaComponente.SetUltimoPrecoCompra(const Value: Double);
begin
  Self.fltUltimoPrecoCompra := Value;
end;

procedure TGenericTintaDeMaquinaComponente.SetUltimoPrecoCompraImpostos(const Value: Double);
begin
  Self.fltUltimoPrecoCompraImpostos := Value;
end;

end.

