unit Faturamento.Impostos.Tipos.ZerarImpostos.Difal;

interface

uses Faturamento.Impostos.Interfaces.ZerarImpostos.Difal;

type
  TParametrosRegraZerarImpostosDifal = class(TInterfacedObject, IParametrosRegraZerarImpostosDifal)
  private
    FClienteOrgaoPublico: Boolean;
    FClienteOrgaoPublicoDifal: Boolean;
    FVendaPresencial: Boolean;
  public
    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosRegraZerarImpostosDifal; overload;

    function ClienteOrgaoPublicoDifal: Boolean; overload;
    function ClienteOrgaoPublicoDifal(AValue: Boolean): IParametrosRegraZerarImpostosDifal; overload;

    function VendaPresencial: Boolean; overload;
    function VendaPresencial(AValue: Boolean): IParametrosRegraZerarImpostosDifal; overload;

    class function New(): IParametrosRegraZerarImpostosDifal;
  end;

implementation

{ TParametrosRegraZerarImpostosDifal }

function TParametrosRegraZerarImpostosDifal.ClienteOrgaoPublico: Boolean;
begin
  Result := FClienteOrgaoPublico;
end;

function TParametrosRegraZerarImpostosDifal.ClienteOrgaoPublico(
  AValue: Boolean): IParametrosRegraZerarImpostosDifal;
begin
  Result := Self;
  FClienteOrgaoPublico := AValue;
end;

function TParametrosRegraZerarImpostosDifal.ClienteOrgaoPublicoDifal(
  AValue: Boolean): IParametrosRegraZerarImpostosDifal;
begin
  Result := Self;
  FClienteOrgaoPublicoDifal := AValue;
end;

function TParametrosRegraZerarImpostosDifal.ClienteOrgaoPublicoDifal: Boolean;
begin
  Result := FClienteOrgaoPublicoDifal;
end;

class function TParametrosRegraZerarImpostosDifal.New: IParametrosRegraZerarImpostosDifal;
begin
  Result := Self.Create;
end;

function TParametrosRegraZerarImpostosDifal.VendaPresencial(
  AValue: Boolean): IParametrosRegraZerarImpostosDifal;
begin
  Result := Self;
  FVendaPresencial := AValue;
end;

function TParametrosRegraZerarImpostosDifal.VendaPresencial: Boolean;
begin
  Result := FVendaPresencial;
end;

end.
