unit Faturamento.Impostos.Tipos.Tributacao.DepoisDoCalculo;

interface

uses Faturamento.Impostos.Interfaces.Tributacao.DepoisDoCalculo;

type
  TParametrosRegrasTributacaoDepoisDoCalculo = class(TInterfacedObject, IParametrosRegrasTributacaoDepoisDoCalculo)
  strict private
    FReducaoRICMPR: Boolean;
    FPercentualDaBaseDaSubstituicaoTributariaDoItem: Double;
    FAliquotaDaSubstituicaoTributariaDoItem: Double;
    FPercentualDeReducaoDaBaseDeIcmsDoItem: Double;
  public
    function ReducaoRICMPR: Boolean; overload;
    function ReducaoRICMPR(AValue: Boolean): IParametrosRegrasTributacaoDepoisDoCalculo; overload;

    function PercentualDaBaseDaSubstituicaoTributariaDoItem: Double; overload;
    function PercentualDaBaseDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosRegrasTributacaoDepoisDoCalculo; overload;

    function AliquotaDaSubstituicaoTributariaDoItem: Double; overload;
    function AliquotaDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosRegrasTributacaoDepoisDoCalculo; overload;

    function PercentualDeReducaoDaBaseDeIcmsDoItem: Double; overload;
    function PercentualDeReducaoDaBaseDeIcmsDoItem(AValue: Double): IParametrosRegrasTributacaoDepoisDoCalculo; overload;

    class function New(): IParametrosRegrasTributacaoDepoisDoCalculo;
  end;

type
  TResultadoRegrasTributacaoDepoisDoCalculo = class(TInterfacedObject, IResultadoRegrasTributacaoDepoisDoCalculo)
  strict private
    FPercentualDaBaseDaSubstituicaoTributariaDoItem: Double;
    FAliquotaDaSubstituicaoTributariaDoItem: Double;
  public
    function PercentualDaBaseDaSubstituicaoTributariaDoItem: Double; overload;
    function PercentualDaBaseDaSubstituicaoTributariaDoItem(AValue: Double): IResultadoRegrasTributacaoDepoisDoCalculo; overload;

    function AliquotaDaSubstituicaoTributariaDoItem: Double; overload;
    function AliquotaDaSubstituicaoTributariaDoItem(AValue: Double): IResultadoRegrasTributacaoDepoisDoCalculo; overload;

    class function New(): IResultadoRegrasTributacaoDepoisDoCalculo;
  end;

implementation

{ TParametrosRegrasTributacaoDepoisDoCalculo }

function TParametrosRegrasTributacaoDepoisDoCalculo.AliquotaDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FAliquotaDaSubstituicaoTributariaDoItem;
end;

function TParametrosRegrasTributacaoDepoisDoCalculo.AliquotaDaSubstituicaoTributariaDoItem(
  AValue: Double): IParametrosRegrasTributacaoDepoisDoCalculo;
begin
  Result := Self;
  FAliquotaDaSubstituicaoTributariaDoItem := AValue;
end;

class function TParametrosRegrasTributacaoDepoisDoCalculo.New: IParametrosRegrasTributacaoDepoisDoCalculo;
begin
  Result := Self.Create;
end;

function TParametrosRegrasTributacaoDepoisDoCalculo.PercentualDaBaseDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FPercentualDaBaseDaSubstituicaoTributariaDoItem;
end;

function TParametrosRegrasTributacaoDepoisDoCalculo.PercentualDaBaseDaSubstituicaoTributariaDoItem(
  AValue: Double): IParametrosRegrasTributacaoDepoisDoCalculo;
begin
  Result := Self;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := AValue;
end;

function TParametrosRegrasTributacaoDepoisDoCalculo.PercentualDeReducaoDaBaseDeIcmsDoItem: Double;
begin
  Result := FPercentualDeReducaoDaBaseDeIcmsDoItem;
end;

function TParametrosRegrasTributacaoDepoisDoCalculo.PercentualDeReducaoDaBaseDeIcmsDoItem(
  AValue: Double): IParametrosRegrasTributacaoDepoisDoCalculo;
begin
  Result := Self;
  FPercentualDeReducaoDaBaseDeIcmsDoItem := AValue;
end;

function TParametrosRegrasTributacaoDepoisDoCalculo.ReducaoRICMPR: Boolean;
begin
  Result := FReducaoRICMPR;
end;

function TParametrosRegrasTributacaoDepoisDoCalculo.ReducaoRICMPR(
  AValue: Boolean): IParametrosRegrasTributacaoDepoisDoCalculo;
begin
  Result := Self;
  FReducaoRICMPR := AValue;
end;

{ TResultadoRegrasTributacaoDepoisDoCalculo }

function TResultadoRegrasTributacaoDepoisDoCalculo.AliquotaDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FAliquotaDaSubstituicaoTributariaDoItem;
end;

function TResultadoRegrasTributacaoDepoisDoCalculo.AliquotaDaSubstituicaoTributariaDoItem(
  AValue: Double): IResultadoRegrasTributacaoDepoisDoCalculo;
begin
  Result := Self;
  FAliquotaDaSubstituicaoTributariaDoItem := AValue;
end;

class function TResultadoRegrasTributacaoDepoisDoCalculo.New: IResultadoRegrasTributacaoDepoisDoCalculo;
begin
  Result := Self.Create;
end;

function TResultadoRegrasTributacaoDepoisDoCalculo.PercentualDaBaseDaSubstituicaoTributariaDoItem: Double;
begin
  Result := FPercentualDaBaseDaSubstituicaoTributariaDoItem;
end;

function TResultadoRegrasTributacaoDepoisDoCalculo.PercentualDaBaseDaSubstituicaoTributariaDoItem(
  AValue: Double): IResultadoRegrasTributacaoDepoisDoCalculo;
begin
  Result := Self;
  FPercentualDaBaseDaSubstituicaoTributariaDoItem := AValue;
end;

end.
