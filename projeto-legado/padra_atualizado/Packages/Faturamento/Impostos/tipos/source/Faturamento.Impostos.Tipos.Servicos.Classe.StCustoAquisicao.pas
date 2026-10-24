unit Faturamento.Impostos.Tipos.Servicos.Classe.StCustoAquisicao;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Classe.StCustoAquisicao,
  Faturamento.Impostos.Interfaces.STCustoAquisicao;

type
  TParametrosClasseStCustoAquisicao = class(TInterfacedObject, IParametrosClasseStCustoAquisicao)
  private
    FParametrosCalculoStCustoAquisicao: IParametrosCalculoSTCustoAquisicao;
  public
    function ParametrosCalculoStCustoAquisicao: IParametrosCalculoSTCustoAquisicao; overload;
    function ParametrosCalculoStCustoAquisicao(AValue: IParametrosCalculoSTCustoAquisicao): IParametrosClasseStCustoAquisicao; overload;

    class function New(): IParametrosClasseStCustoAquisicao;
  end;

type
  TResultadoClasseStCustoAquisicao = class(TInterfacedObject, IResultadoClasseStCustoAquisicao)
  private
    FResultadoCalculoStCustoAquisicao: IResultadoCalculoSTCustoAquisicao;
    FParametrosCalculoStCustoAquisicao: IParametrosCalculoSTCustoAquisicao;
  public
    function ResultadoCalculoStCustoAquisicao: IResultadoCalculoSTCustoAquisicao; overload;
    function ResultadoCalculoStCustoAquisicao(AValue: IResultadoCalculoSTCustoAquisicao): IResultadoClasseStCustoAquisicao; overload;

    function ParametrosCalculoStCustoAquisicao: IParametrosCalculoSTCustoAquisicao; overload;
    function ParametrosCalculoStCustoAquisicao(AValue: IParametrosCalculoSTCustoAquisicao): IResultadoClasseStCustoAquisicao; overload;

    class function New(): IResultadoClasseStCustoAquisicao;
  end;


implementation

{ TParametrosClasseStCustoAquisicao }

class function TParametrosClasseStCustoAquisicao.New: IParametrosClasseStCustoAquisicao;
begin
  Result := Self.Create;
end;

function TParametrosClasseStCustoAquisicao.ParametrosCalculoStCustoAquisicao: IParametrosCalculoSTCustoAquisicao;
begin
  Result := FParametrosCalculoStCustoAquisicao;
end;

function TParametrosClasseStCustoAquisicao.ParametrosCalculoStCustoAquisicao(
  AValue: IParametrosCalculoSTCustoAquisicao): IParametrosClasseStCustoAquisicao;
begin
  Result := Self;
  FParametrosCalculoStCustoAquisicao := AValue;
end;

{ TResultadoClasseStCustoAquisicao }

class function TResultadoClasseStCustoAquisicao.New: IResultadoClasseStCustoAquisicao;
begin
  Result := Self.Create;
end;

function TResultadoClasseStCustoAquisicao.ParametrosCalculoStCustoAquisicao(
  AValue: IParametrosCalculoSTCustoAquisicao): IResultadoClasseStCustoAquisicao;
begin
  Result := Self;
  FParametrosCalculoStCustoAquisicao := AValue;
end;

function TResultadoClasseStCustoAquisicao.ParametrosCalculoStCustoAquisicao: IParametrosCalculoSTCustoAquisicao;
begin
  Result := FParametrosCalculoStCustoAquisicao;
end;

function TResultadoClasseStCustoAquisicao.ResultadoCalculoStCustoAquisicao: IResultadoCalculoSTCustoAquisicao;
begin
  Result := FResultadoCalculoStCustoAquisicao;
end;

function TResultadoClasseStCustoAquisicao.ResultadoCalculoStCustoAquisicao(
  AValue: IResultadoCalculoSTCustoAquisicao): IResultadoClasseStCustoAquisicao;
begin
  Result := Self;
  FResultadoCalculoStCustoAquisicao := AValue;
end;

end.
