unit Faturamento.Impostos.Servicos.Disponiveis;

interface

uses Faturamento.Impostos.Interfaces.Servicos.Disponiveis,
  Faturamento.Impostos.Interfaces.Servicos.Disponiveis.ipi,
  Faturamento.Impostos.Servicos.Disponiveis.ipi,
  Faturamento.Impostos.Interfaces.Servicos.Disponiveis.IcmsSt,
  Faturamento.Impostos.Servicos.Disponiveis.IcmsSt,
  Faturamento.Impostos.Interfaces.Servicos.Disponiveis.IcmsEfetivo,
  Faturamento.Impostos.Servicos.Disponiveis.IcmsEfetivo,
  Faturamento.Impostos.Interfaces.Servicos.Disponiveis.FcpDifal,
  Faturamento.Impostos.Servicos.Disponiveis.FcpDifal;


type
  TFaturamentoImpostosServicosDisponiveis = class(TInterfacedObject, IFaturamentoImpostosServicosDisponiveis)
  public
    function Ipi: IFaturamentoImpostosServicosDisponiveisIpi;
    function IcmsSt: IFaturamentoImpostosServicosDisponiveisIcmsSt;
    function IcmsEfetivo: IFaturamentoImpostosServicosDisponiveisIcmsEfetivo;
    function FcpDifal: IFaturamentoImpostosServicosDisponiveisFcpDifal;
  end;

  function GetFaturamentoImpostosService(): IFaturamentoImpostosServicosDisponiveis; stdcall;

implementation

{ TFaturamentoImpostosServicosDisponiveis }

function TFaturamentoImpostosServicosDisponiveis.FcpDifal: IFaturamentoImpostosServicosDisponiveisFcpDifal;
begin
  Result := TFaturamentoImpostosServicosDisponiveisFcpDifal.New();
end;

function TFaturamentoImpostosServicosDisponiveis.IcmsEfetivo: IFaturamentoImpostosServicosDisponiveisIcmsEfetivo;
begin
  Result := TFaturamentoImpostosServicosDisponiveisIcmsEfetivo.New();
end;

function TFaturamentoImpostosServicosDisponiveis.IcmsSt: IFaturamentoImpostosServicosDisponiveisIcmsSt;
begin
  Result := TFaturamentoImpostosServicosDisponiveisIcmsSt.New();
end;

function TFaturamentoImpostosServicosDisponiveis.Ipi: IFaturamentoImpostosServicosDisponiveisIpi;
begin
  Result := TFaturamentoImpostosServicosDisponiveisIpi.New();
end;

function GetFaturamentoImpostosService(): IFaturamentoImpostosServicosDisponiveis; stdcall;
begin
  Result := TFaturamentoImpostosServicosDisponiveis.Create;
end;

exports GetFaturamentoImpostosService;

end.
