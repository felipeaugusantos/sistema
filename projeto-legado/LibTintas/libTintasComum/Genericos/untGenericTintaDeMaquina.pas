unit untGenericTintaDeMaquina;

interface

uses
  untITintaDeMaquina, Classes, untITintaDeMaquinaComponenteComparer,
  untInterfacedObjectNoCount, untITintaDeMaquinaComponente;

type
  TGenericTintaDeMaquina = class(TInterfacedObjectNoCount, ITintaDeMaquina)
  private
    fltDescontoEspecial: Double;
    fltQuantidade: Double;
    lstComponentes: IInterfaceList;
    strDescricao: string;
  public
    constructor Create; overload;
    constructor Create(const strDescricao: string); overload;
    destructor Destroy; override;
    function Adicionar(const tintaDeMaquinaComponente:
        ITintaDeMaquinaComponente): ITintaDeMaquinaComponente;
    function GetCount: Integer;
    function GetDescontoEspecial: Double;
    function GetDescricao: string;
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
    function GetTintaDeMaquinaComponente(const index: Integer): ITintaDeMaquinaComponente;
    procedure Limpar;
    function Localizar(const tintaDeMaquinaComponenteComparer: ITintaDeMaquinaComponenteComparer): ITintaDeMaquinaComponente;
    procedure Remover(const tintaDeMaquinaComponente: ITintaDeMaquinaComponente);
    procedure SetDescontoEspecial(Value: Double);
    procedure SetDescricao(const value: string);
    procedure SetQuantidade(const value: Double);
    function GetUltimoPrecoCompra: Double;
    function GetUltimoPrecoCompraImpostos: Double;
    function GetUltimoPrecoCompraComponentes: Double;
    function GetUltimoPrecoCompraImpostosComponentes: Double;
    function GetUltimoPrecoCompraEmbalagemBase: Double;
    function GetUltimoPrecoCompraImpostosEmbalagemBase: Double;
    function GetPrecoCompraLiquido: Double;
    function GetPrecoCompraLiquidoComponentes: Double;
    function GetPrecoCompraLiquidoEmbalagemBase: Double;
  end;


implementation
uses untTintaDeMaquinaComponenteTipo;
{ TGenericTintaDeMaquina }

{
**************************** TGenericTintaDeMaquina ****************************
}
constructor TGenericTintaDeMaquina.Create;
begin
  Create('');
end;

constructor TGenericTintaDeMaquina.Create(const strDescricao: string);
begin
  inherited Create();
  Self.lstComponentes := TInterfaceList.Create;
  Self.strDescricao := strDescricao;
  Self.fltQuantidade := 1;
end;

destructor TGenericTintaDeMaquina.Destroy;
begin
  inherited Destroy;
end;

function TGenericTintaDeMaquina.Adicionar(const tintaDeMaquinaComponente:
    ITintaDeMaquinaComponente): ITintaDeMaquinaComponente;
begin
  Result := tintaDeMaquinaComponente;
  lstComponentes.Add(tintaDeMaquinaComponente);
end;

function TGenericTintaDeMaquina.GetCount: Integer;
begin
  Result := lstComponentes.Count;
end;

function TGenericTintaDeMaquina.GetDescontoEspecial: Double;
begin
  Result := fltDescontoEspecial;
end;

function TGenericTintaDeMaquina.GetDescricao: string;
begin
  Result := strDescricao;
end;

function TGenericTintaDeMaquina.GetDespesasOperacionais: Double;
begin
  Result := GetDespesasOperacionaisComponentes + GetDespesasOperacionaisEmbalagemBase;
end;

function TGenericTintaDeMaquina.GetDespesasOperacionaisComponentes: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctColoranteImobiliario, tmctBaseAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).DespesasOperacionais;
  end;
end;

function TGenericTintaDeMaquina.GetDespesasOperacionaisEmbalagemBase: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctBaseImobiliaria, tmctEmbalagemAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).DespesasOperacionais;
  end;
end;

function TGenericTintaDeMaquina.GetIcmsSaida: Double;
begin
  Result := GetIcmsSaidaComponentes + GetIcmsSaidaEmbalagemBase;
end;

function TGenericTintaDeMaquina.GetIcmsSaidaComponentes: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctColoranteImobiliario, tmctBaseAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).IcmsSaida;
  end;
end;

function TGenericTintaDeMaquina.GetIcmsSaidaEmbalagemBase: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctBaseImobiliaria, tmctEmbalagemAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).IcmsSaida;
  end;
end;

function TGenericTintaDeMaquina.GetImpostosFederais: Double;
begin
  Result := GetImpostosFederaisComponentes + GetImpostosFederaisEmbalagemBase;
end;

function TGenericTintaDeMaquina.GetImpostosFederaisComponentes: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctColoranteImobiliario, tmctBaseAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).ImpostosFederais;
  end;
end;

function TGenericTintaDeMaquina.GetImpostosFederaisEmbalagemBase: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctBaseImobiliaria, tmctEmbalagemAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).ImpostosFederais;
  end;
end;

function TGenericTintaDeMaquina.GetOutrosValores: Double;
begin
  Result := GetOutrosValoresComponentes + GetOutrosValoresEmbalagemBase;
end;

function TGenericTintaDeMaquina.GetOutrosValoresComponentes: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctColoranteImobiliario, tmctBaseAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).OutrosValores;
  end;
end;

function TGenericTintaDeMaquina.GetOutrosValoresEmbalagemBase: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctBaseImobiliaria, tmctEmbalagemAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).OutrosValores;
  end;
end;

function TGenericTintaDeMaquina.GetPrecoCompraLiquido: Double;
begin
  Result := GetPrecoCompraLiquidoComponentes + GetPrecoCompraLiquidoEmbalagemBase;
end;

function TGenericTintaDeMaquina.GetPrecoCompraLiquidoComponentes: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctColoranteImobiliario, tmctBaseAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).PrecoCompraLiquido;
  end;
end;

function TGenericTintaDeMaquina.GetPrecoCompraLiquidoEmbalagemBase: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctBaseImobiliaria, tmctEmbalagemAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).PrecoCompraLiquido;
  end;
end;

function TGenericTintaDeMaquina.GetPrecoCusto: Double;
begin
  Result := GetPrecoCustoComponentes + GetPrecoCustoEmbalagemBase;
end;

function TGenericTintaDeMaquina.GetPrecoCustoComponentes: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctColoranteImobiliario, tmctBaseAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).PrecoCusto;
  end;
end;

function TGenericTintaDeMaquina.GetPrecoCustoEmbalagemBase: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctBaseImobiliaria, tmctEmbalagemAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).PrecoCusto;
  end;
end;

function TGenericTintaDeMaquina.GetPrecoCustoReal: Double;
begin
  Result := GetPrecoCustoRealComponentes + GetPrecoCustoRealEmbalagemBase;
end;

function TGenericTintaDeMaquina.GetPrecoCustoRealComponentes: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctColoranteImobiliario, tmctBaseAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).PrecoCustoReal;
  end;
end;

function TGenericTintaDeMaquina.GetPrecoCustoRealEmbalagemBase: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctBaseImobiliaria, tmctEmbalagemAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).PrecoCustoReal;
  end;
end;

function TGenericTintaDeMaquina.GetPrecoMedio: Double;
begin
  Result := GetPrecoMedioComponentes + GetPrecoMedioEmbalagemBase;
end;

function TGenericTintaDeMaquina.GetPrecoMedioComponentes: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctColoranteImobiliario, tmctBaseAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).PrecoMedio;
  end;
end;

function TGenericTintaDeMaquina.GetPrecoMedioEmbalagemBase: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctBaseImobiliaria, tmctEmbalagemAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).PrecoMedio;
  end;
end;

function TGenericTintaDeMaquina.GetPrecoVenda: Double;
begin
  Result := GetPrecoVendaComponentes + GetPrecoVendaEmbalagemBase;
end;

function TGenericTintaDeMaquina.GetPrecoVendaComponentes: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctColoranteImobiliario, tmctBaseAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).PrecoVenda;
  end;
end;

function TGenericTintaDeMaquina.GetPrecoVendaEmbalagemBase: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctBaseImobiliaria, tmctEmbalagemAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).PrecoVenda;
  end;
end;

function TGenericTintaDeMaquina.GetQuantidade: Double;
begin
  Result := Self.fltQuantidade;
end;

function TGenericTintaDeMaquina.GetTintaDeMaquinaComponente(const index:
    Integer): ITintaDeMaquinaComponente;
begin
  Result := lstComponentes[index] as ITintaDeMaquinaComponente;
end;

function TGenericTintaDeMaquina.GetUltimoPrecoCompra: Double;
begin
  Result := GetUltimoPrecoCompraComponentes + GetUltimoPrecoCompraEmbalagemBase;
end;

function TGenericTintaDeMaquina.GetUltimoPrecoCompraComponentes: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctColoranteImobiliario, tmctBaseAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).UltimoPrecoCompra;
  end;
end;

function TGenericTintaDeMaquina.GetUltimoPrecoCompraEmbalagemBase: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctBaseImobiliaria, tmctEmbalagemAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).UltimoPrecoCompra;
  end;
end;

function TGenericTintaDeMaquina.GetUltimoPrecoCompraImpostos: Double;
begin
  Result := GetUltimoPrecoCompraImpostosComponentes + GetUltimoPrecoCompraImpostosEmbalagemBase;
end;

function TGenericTintaDeMaquina.GetUltimoPrecoCompraImpostosComponentes: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctColoranteImobiliario, tmctBaseAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).UltimoPrecoCompraImpostos;
  end;
end;

function TGenericTintaDeMaquina.GetUltimoPrecoCompraImpostosEmbalagemBase: Double;
var
  intCont: Integer;
begin
  Result := 0;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if (lstComponentes[intCont] as ITintaDeMaquinaComponente).Tipo in [tmctBaseImobiliaria, tmctEmbalagemAutomotiva] then
      Result := Result + (lstComponentes[intCont] as ITintaDeMaquinaComponente).UltimoPrecoCompraImpostos;
  end;
end;

procedure TGenericTintaDeMaquina.Limpar;
begin
  lstComponentes.Clear;
end;

function TGenericTintaDeMaquina.Localizar(const
    tintaDeMaquinaComponenteComparer: ITintaDeMaquinaComponenteComparer):
    ITintaDeMaquinaComponente;
var
  intCont: Integer;
begin
  Result := nil;
  for intCont := 0 to lstComponentes.Count - 1 do
  begin
    if tintaDeMaquinaComponenteComparer.Igual(lstComponentes[intCont] as ITintaDeMaquinaComponente) then
    begin
      Result := lstComponentes[intCont] as ITintaDeMaquinaComponente;
      Break;
    end;
  end;
end;

procedure TGenericTintaDeMaquina.Remover(const tintaDeMaquinaComponente:
    ITintaDeMaquinaComponente);
begin
  if not Assigned(tintaDeMaquinaComponente) then
    Exit;

  lstComponentes.Remove(tintaDeMaquinaComponente);
end;

procedure TGenericTintaDeMaquina.SetDescontoEspecial(Value: Double);
begin
  Self.fltDescontoEspecial := Value;
end;

procedure TGenericTintaDeMaquina.SetDescricao(const value: string);
begin
  Self.strDescricao := value;
end;

procedure TGenericTintaDeMaquina.SetQuantidade(const value: Double);
begin
  Self.fltQuantidade := value;
end;

end.
