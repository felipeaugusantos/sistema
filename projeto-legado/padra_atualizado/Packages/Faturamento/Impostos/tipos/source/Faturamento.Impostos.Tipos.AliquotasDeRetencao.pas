unit Faturamento.Impostos.Tipos.AliquotasDeRetencao;

interface

uses
  Faturamento.Impostos.Interfaces.AliquotasDeRetencao,
  Faturamento.Impostos.Interfaces.Model;

type
  TParametrosAliquotasDeRetencao = class(TInterfacedObject,IParametrosAliquotasDeRetencao)
  private
    FCodigoDoCliente : String;
    FParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor;
    FClienteConsumidorFinal: Boolean;
  public
    function CodigoDoCliente : String; overload;
    function CodigoDoCliente(AValue: String): IParametrosAliquotasDeRetencao ; overload;

    function ParametrosClienteConsumidor : IParametrosFaturamentoImpostosClienteConsumidor; overload;
    function ParametrosClienteConsumidor(AValue : IParametrosFaturamentoImpostosClienteConsumidor) : IParametrosAliquotasDeRetencao; overload;

    function ClienteConsumidorFinal: Boolean; overload;
    function ClienteConsumidorFinal(AValue: Boolean): IParametrosAliquotasDeRetencao ; overload;

    class function New: IParametrosAliquotasDeRetencao;
  end;

type
  TResultadoAliquotasDeRetencao = class(TInterfacedObject, IResultadoAliquotasDeRetencao)
  private
    FAliquotaIRPJ  : Double;
    FAliquotaPIS   : Double;
    FAliquotaCOFINS: Double;
    FAliquotaCSLL  : Double;

    FAliquotaProdutoIRPJ  : Double;
    FAliquotaProdutoPIS   : Double;
    FAliquotaProdutoCOFINS: Double;
    FAliquotaProdutoCSLL  : Double;

    FValorMinimoRetencaoPisCofinsCsll : Double;
    FValorMinimoRetencaoIRPJ          : Double;
  public
    function AliquotaIRPJ: Double; overload;
    function AliquotaIRPJ(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function AliquotaPIS : Double; overload;
    function AliquotaPIS(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function AliquotaCOFINS: Double; overload;
    function AliquotaCOFINS(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function AliquotaCSLL: Double; overload;
    function AliquotaCSLL(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function AliquotaProdutoIRPJ: Double; overload;
    function AliquotaProdutoIRPJ(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function AliquotaProdutoPIS : Double; overload;
    function AliquotaProdutoPIS(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function AliquotaProdutoCOFINS: Double; overload;
    function AliquotaProdutoCOFINS(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function AliquotaProdutoCSLL: Double; overload;
    function AliquotaProdutoCSLL(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function ValorMinimoRetencaoPisCofinsCsll : Double; overload;
    function ValorMinimoRetencaoPisCofinsCsll(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    function ValorMinimoRetencaoIRPJ : Double; overload;
    function ValorMinimoRetencaoIRPJ(AValue: Double): IResultadoAliquotasDeRetencao; overload;

    class function New: IResultadoAliquotasDeRetencao;
  end;

implementation

function TParametrosAliquotasDeRetencao.ClienteConsumidorFinal: Boolean;
begin
  Result := FClienteConsumidorFinal;
end;

function TParametrosAliquotasDeRetencao.ClienteConsumidorFinal(
  AValue: Boolean): IParametrosAliquotasDeRetencao;
begin
  Result := Self;
  FClienteConsumidorFinal := AValue;
end;

function TParametrosAliquotasDeRetencao.CodigoDoCliente(
  AValue: String): IParametrosAliquotasDeRetencao;
begin
  Result := Self;
  FCodigoDoCliente := AValue;
end;

function TParametrosAliquotasDeRetencao.CodigoDoCliente: String;
begin
  Result := FCodigoDoCliente;
end;

class function TParametrosAliquotasDeRetencao.New: IParametrosAliquotasDeRetencao;
begin
  Result := Self.Create;
end;

function TParametrosAliquotasDeRetencao.ParametrosClienteConsumidor: IParametrosFaturamentoImpostosClienteConsumidor;
begin
  Result := FParametrosClienteConsumidor;
end;

function TParametrosAliquotasDeRetencao.ParametrosClienteConsumidor(
  AValue: IParametrosFaturamentoImpostosClienteConsumidor): IParametrosAliquotasDeRetencao;
begin
  Result := Self;
  FParametrosClienteConsumidor := AValue;
end;

{ TResultadoAliquotasDeRetencao }

function TResultadoAliquotasDeRetencao.AliquotaCOFINS(
  AValue: Double): IResultadoAliquotasDeRetencao;
begin
  Result := Self;
  FAliquotaCOFINS := AValue;
end;

function TResultadoAliquotasDeRetencao.AliquotaCOFINS: Double;
begin
  Result := FAliquotaCOFINS;
end;

function TResultadoAliquotasDeRetencao.AliquotaCSLL(
  AValue: Double): IResultadoAliquotasDeRetencao;
begin
  Result := Self;
  FAliquotaCSLL := AValue;
end;

function TResultadoAliquotasDeRetencao.AliquotaCSLL: Double;
begin
  Result := FAliquotaCSLL;
end;

function TResultadoAliquotasDeRetencao.AliquotaIRPJ(
  AValue: Double): IResultadoAliquotasDeRetencao;
begin
  Result := Self;
  FAliquotaIRPJ := AValue;
end;

function TResultadoAliquotasDeRetencao.AliquotaIRPJ: Double;
begin
  Result := FAliquotaIRPJ;
end;

function TResultadoAliquotasDeRetencao.AliquotaPIS(
  AValue: Double): IResultadoAliquotasDeRetencao;
begin
  Result := Self;
  FAliquotaPIS := AValue;
end;

function TResultadoAliquotasDeRetencao.AliquotaProdutoCOFINS(
  AValue: Double): IResultadoAliquotasDeRetencao;
begin
  Result := Self;
  FAliquotaProdutoCOFINS := AValue;
end;

function TResultadoAliquotasDeRetencao.AliquotaProdutoCOFINS: Double;
begin
  Result := FAliquotaProdutoCOFINS;
end;

function TResultadoAliquotasDeRetencao.AliquotaProdutoCSLL(
  AValue: Double): IResultadoAliquotasDeRetencao;
begin
  Result := Self;
  FAliquotaProdutoCSLL := AValue;
end;

function TResultadoAliquotasDeRetencao.AliquotaProdutoCSLL: Double;
begin
  Result := FAliquotaProdutoCSLL;
end;

function TResultadoAliquotasDeRetencao.AliquotaProdutoIRPJ(
  AValue: Double): IResultadoAliquotasDeRetencao;
begin
  Result := Self;
  FAliquotaProdutoIRPJ := AValue;
end;

function TResultadoAliquotasDeRetencao.AliquotaProdutoIRPJ: Double;
begin
  Result := FAliquotaProdutoIRPJ;
end;

function TResultadoAliquotasDeRetencao.AliquotaProdutoPIS(
  AValue: Double): IResultadoAliquotasDeRetencao;
begin
  Result := Self;
  FAliquotaProdutoPIS := AValue;
end;

function TResultadoAliquotasDeRetencao.AliquotaProdutoPIS: Double;
begin
  Result := FAliquotaProdutoPIS;
end;

function TResultadoAliquotasDeRetencao.AliquotaPIS: Double;
begin
  Result := FAliquotaPIS;
end;

class function TResultadoAliquotasDeRetencao.New: IResultadoAliquotasDeRetencao;
begin
  Result := Self.Create;
end;

function TResultadoAliquotasDeRetencao.ValorMinimoRetencaoIRPJ(
  AValue: Double): IResultadoAliquotasDeRetencao;
begin
  Result := Self;
  FValorMinimoRetencaoIRPJ := AValue;

end;

function TResultadoAliquotasDeRetencao.ValorMinimoRetencaoIRPJ: Double;
begin
  Result := FValorMinimoRetencaoIRPJ;
end;

function TResultadoAliquotasDeRetencao.ValorMinimoRetencaoPisCofinsCsll(
  AValue: Double): IResultadoAliquotasDeRetencao;
begin
  Result := Self;
  FValorMinimoRetencaoPisCofinsCsll := AValue;
end;

function TResultadoAliquotasDeRetencao.ValorMinimoRetencaoPisCofinsCsll: Double;
begin
  Result := FValorMinimoRetencaoPisCofinsCsll;
end;

end.
