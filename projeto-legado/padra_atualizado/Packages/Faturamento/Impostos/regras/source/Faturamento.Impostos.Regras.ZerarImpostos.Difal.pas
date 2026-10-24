unit Faturamento.Impostos.Regras.ZerarImpostos.Difal;

interface

uses System.StrUtils, Faturamento.Impostos.Interfaces.ZerarImpostos.Difal,
  Faturamento.Impostos.Tipos.ZerarImpostos.Difal, Shared.Functions.Constantes;

type
  TRegraImpostosZerarImpostosDifal = class(TInterfacedObject, IRegraImpostosZerarImpostosDifal)
  private
    function ClienteOrgaoPublico(const AParametros: IParametrosRegraZerarImpostosDifal): Boolean;
  public
    function ZerarValorDoDifal(const AParametros: IParametrosRegraZerarImpostosDifal): Boolean;

    class function New(): IRegraImpostosZerarImpostosDifal;
  end;

implementation

{ TRegraImpostosZerarImpostosDifal }

function TRegraImpostosZerarImpostosDifal.ClienteOrgaoPublico(
  const AParametros: IParametrosRegraZerarImpostosDifal): Boolean;
begin
  Result := False;

  If Not AParametros.ClienteOrgaoPublico Then
    Exit;

  If AParametros.ClienteOrgaoPublicoDifal Then
    Exit;

  Result := True;
end;

class function TRegraImpostosZerarImpostosDifal.New: IRegraImpostosZerarImpostosDifal;
begin
  Result := Self.Create;
end;

function TRegraImpostosZerarImpostosDifal.ZerarValorDoDifal(
  const AParametros: IParametrosRegraZerarImpostosDifal): Boolean;
begin
  Result := True;

  If ClienteOrgaoPublico(AParametros) Then
    Exit;

  If AParametros.VendaPresencial Then
    Exit;

  Result := False;
end;

end.
