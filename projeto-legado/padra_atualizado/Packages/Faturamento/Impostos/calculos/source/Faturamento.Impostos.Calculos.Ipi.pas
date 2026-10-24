unit Faturamento.Impostos.Calculos.Ipi;

interface

uses Faturamento.Impostos.Interfaces.Ipi, Faturamento.Impostos.Tipos.Ipi,
  Shared.Functions.Core, Shared.Functions.Configuracoes,
  Shared.Functions.Funcoes.Faturamento;

type
  TCalculoImpostosIPI = class(TInterfacedObject, ICalculoImpostosIPI)
  private
    function RetornarValorIpi(Const AParametros: IParametrosCalculoIPI; Const AValorBaseIpi : Double): Double;

  public
    function CalcularValorIPI(AParametros: IParametrosCalculoIPI): IResultadoCalculoIPI;

    class function New(): ICalculoImpostosIPI;
  end;

//  function CalcularValorIPI(AParametros: IParametrosCalculoIPI): IResultadoCalculoIPI; stdcall;

implementation


//function CalcularValorIPI(AParametros: IParametrosCalculoIPI): IResultadoCalculoIPI; stdcall;
//begin
//  Result := TCalculoImpostosIPI.New.CalcularValorIPI(AParametros);
//end;

{ TCalculoImpostosIPI }

function TCalculoImpostosIPI.CalcularValorIPI(
  AParametros: IParametrosCalculoIPI): IResultadoCalculoIPI;
  Const
    IPITributado = 'T';

  Var
    LValorIPI : Double;
    LBaseIPI  : Double;
begin

  LBaseIPI := AParametros.BaseDoIpi;

  LValorIPI := RetornarValorIpi(AParametros, LBaseIPI);

  If AParametros.ClienteZonaFranca Then
    LValorIPI := 0;

  If (AParametros.SituacaoTributariaIPI <> IPITributado) Then
  Begin
    LValorIPI := 0;
    LBaseIPI  := 0;
  End;

  If AParametros.ClienteDoExterior Then
    LValorIPI := 0;

  If AParametros.AliquotaDeCalculoIPI <= 0 Then
  Begin
    LValorIPI := 0;
    LBaseIPI  := 0;
  End;

  Result :=
    TResultadoCalculoIPI.New
      .ValorCalculadoIPI(LValorIPI)
      .BaseDeCalculoIPI(LBaseIPI)
      .AliquotaDeCalculoIPI(AParametros.AliquotaDeCalculoIPI)
      .ValorCalculadoIPIConsignacao(LValorIPI);
end;

Function TCalculoImpostosIPI.RetornarValorIpi(
 Const AParametros: IParametrosCalculoIPI; Const AValorBaseIpi : Double) : Double;
begin
  Result := objCore.fFormataFloat(AValorBaseIpi * AParametros.AliquotaDeCalculoIPI / 100, 2);
end;

class function TCalculoImpostosIPI.New: ICalculoImpostosIPI;
begin
  Result := Self.Create;
end;

//exports CalcularValorIPI;

end.
