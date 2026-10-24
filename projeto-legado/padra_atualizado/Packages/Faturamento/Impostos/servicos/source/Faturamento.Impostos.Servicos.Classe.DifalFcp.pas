unit Faturamento.Impostos.Servicos.Classe.DifalFcp;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Classe.DifalFcp,
     Faturamento.Impostos.Tipos.Servicos.Classe.DifalFcp,
     Faturamento.Impostos.Tipos.FCP,
     Faturamento.Impostos.Interfaces.FCP,
     Faturamento.Impostos.Calculos.FCP,
     Shared.Functions.Types;

type
  TServicosClasseDifalFcp = class(TInterfacedObject, IServicosClasseDifalFcp)
  private
    FParametros: IParametrosClasseDifalFcp;

    function ResultadoCalculoDifalFcp : IResultadoCalculoDifalFcp;
  public
    function CalcularDifalFcp: IResultadoClasseDifalFcp;

    constructor Create(AParametros: IParametrosClasseDifalFcp); overload;

    class function New(AParametros: IParametrosClasseDifalFcp): IServicosClasseDifalFcp;
  end;

implementation

{ TServicosClasseFcp }

function TServicosClasseDifalFcp.CalcularDifalFcp: IResultadoClasseDifalFcp;
var
  LResultadoCalculoDifalFcp: IResultadoCalculoDifalFcp;
begin
  LResultadoCalculoDifalFcp := ResultadoCalculoDifalFcp;

  Result :=
    TResultadoClasseDifalFcp.New
      .ResultadoCalculoDifalFcp(LResultadoCalculoDifalFcp)
      .ParametrosCalculoDifalFcp(FParametros.ParametrosCalculoDifalFcp);
end;

constructor TServicosClasseDifalFcp.Create(AParametros: IParametrosClasseDifalFcp);
begin
  FParametros := AParametros;
end;

class function TServicosClasseDifalFcp.New(AParametros: IParametrosClasseDifalFcp): IServicosClasseDifalFcp;
begin
  Result := Self.Create(AParametros);
end;

function TServicosClasseDifalFcp.ResultadoCalculoDifalFcp: IResultadoCalculoDifalFcp;
begin
  Result :=
    TCalculoImpostosDifalFCP.New
      .CalcularValorDifalFcp(FParametros.ParametrosCalculoDifalFcp);
end;

end.
