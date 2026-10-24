unit Faturamento.Impostos.Regras.Tributacao.DepoisDoCalculo;

interface

uses Faturamento.Impostos.Interfaces.Tributacao.DepoisDoCalculo, Shared.Functions.Core,
  Faturamento.Impostos.Tipos.Tributacao.DepoisDoCalculo, Shared.Functions.Constantes;

type
  TRegraImpostosTributacaoDepoisDoCalculo = class(TInterfacedObject, IRegraImpostosTributacaoDepoisDoCalculo)
  private
    FParametros: IParametrosRegrasTributacaoDepoisDoCalculo;

    FPercentualBaseSubstituicaoTributaria: Double;
    FAliquotaDaSubstituicaoTributaria: Double;
  public
   function ReducaoPercentualBaseSubstituicaoTributaria: IRegraImpostosTributacaoDepoisDoCalculo;
   function AliquotaDaSubstituicaoTributariaDoItem: IRegraImpostosTributacaoDepoisDoCalculo;
   function ResultadoRegrasTributacaoDepoisDoCalculo: IResultadoRegrasTributacaoDepoisDoCalculo;

   constructor Create(AParametros: IParametrosRegrasTributacaoDepoisDoCalculo); overload;

   class function New(AParametros: IParametrosRegrasTributacaoDepoisDoCalculo): IRegraImpostosTributacaoDepoisDoCalculo;
  end;

implementation

{ TRegraImpostosTributacaoDepoisDoCalculo }

function TRegraImpostosTributacaoDepoisDoCalculo.AliquotaDaSubstituicaoTributariaDoItem: IRegraImpostosTributacaoDepoisDoCalculo;
begin
  Result := Self;

  FAliquotaDaSubstituicaoTributaria := FParametros.AliquotaDaSubstituicaoTributariaDoItem;
end;

constructor TRegraImpostosTributacaoDepoisDoCalculo.Create(
  AParametros: IParametrosRegrasTributacaoDepoisDoCalculo);
begin
  FParametros := AParametros;
end;

class function TRegraImpostosTributacaoDepoisDoCalculo.New(
  AParametros: IParametrosRegrasTributacaoDepoisDoCalculo): IRegraImpostosTributacaoDepoisDoCalculo;
begin
  Result := Self.Create(AParametros);
end;

function TRegraImpostosTributacaoDepoisDoCalculo.ReducaoPercentualBaseSubstituicaoTributaria: IRegraImpostosTributacaoDepoisDoCalculo;
begin
  Result := Self;

  FPercentualBaseSubstituicaoTributaria := FParametros.PercentualDaBaseDaSubstituicaoTributariaDoItem;

  If (Not FParametros.ReducaoRICMPR) Then
    Exit;

  FPercentualBaseSubstituicaoTributaria := (100 - objCore.IfFloatZero(FParametros.PercentualDeReducaoDaBaseDeIcmsDoItem, CONST_PERCENTUAL_DIFERIMENTO_RICMS));
end;

function TRegraImpostosTributacaoDepoisDoCalculo.ResultadoRegrasTributacaoDepoisDoCalculo: IResultadoRegrasTributacaoDepoisDoCalculo;
begin
  Result :=
    TResultadoRegrasTributacaoDepoisDoCalculo.New
      .PercentualDaBaseDaSubstituicaoTributariaDoItem(FPercentualBaseSubstituicaoTributaria)
      .AliquotaDaSubstituicaoTributariaDoItem(FAliquotaDaSubstituicaoTributaria);
end;

end.
