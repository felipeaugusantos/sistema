unit Faturamento.Impostos.Servicos.Classe.Fcp;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Classe.Fcp,
  Faturamento.Impostos.Tipos.Servicos.Classe.Fcp,
  Faturamento.Impostos.Calculos.Fcp,
  Faturamento.Impostos.Tipos.Fcp,
  Faturamento.Impostos.Interfaces.Fcp,
  Shared.Functions.Types;

type
  TServicosClasseFcp = class(TInterfacedObject, IServicosClasseFcp)
  private
    FParametros: IParametrosClasseFcp;

    function ResultadoCalculoFcpFinal: IResultadoCalculoFcp;
  public
//    function CalcularFcp: IResultadoClasseFcp;
    function CalcularFcpFinal: IResultadoClasseFcp;

    constructor Create(AParametros: IParametrosClasseFcp); overload;

    class function New(AParametros: IParametrosClasseFcp): IServicosClasseFcp;
  end;

implementation

{ TServicosClasseFcp }

function TServicosClasseFcp.CalcularFcpFinal: IResultadoClasseFcp;
var
  LResultadoCalculoFcp: IResultadoCalculoFcp;
begin
  LResultadoCalculoFcp := ResultadoCalculoFcpFinal;

  Result :=
    TResultadoClasseFcp.New
      .ResultadoCalculoFcp(LResultadoCalculoFcp)
      .ParametrosCalculoFcp(FParametros.ParametrosCalculoFcp)
      .CalculouOValorDoFcp(LResultadoCalculoFcp.SairDoProcedimento);
end;

constructor TServicosClasseFcp.Create(AParametros: IParametrosClasseFcp);
begin
  FParametros := AParametros;
end;

class function TServicosClasseFcp.New(AParametros: IParametrosClasseFcp): IServicosClasseFcp;
begin
  Result := Self.Create(AParametros);
end;

function TServicosClasseFcp.ResultadoCalculoFcpFinal: IResultadoCalculoFcp;
begin
  Result :=
    TCalculoImpostosFCP.New
      .CalcularValorFCP(FParametros.ParametrosCalculoFcp);
end;

end.
