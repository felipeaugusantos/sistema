unit Faturamento.Impostos.Interfaces.ZerarImpostos.Difal;

interface

type
  IParametrosRegraZerarImpostosDifal = interface
    ['{1DD0B4C2-BFAB-4BB6-ADAF-ABDB9F9957B2}']

    function ClienteOrgaoPublico: Boolean; overload;
    function ClienteOrgaoPublico(AValue: Boolean): IParametrosRegraZerarImpostosDifal; overload;

    function ClienteOrgaoPublicoDifal: Boolean; overload;
    function ClienteOrgaoPublicoDifal(AValue: Boolean): IParametrosRegraZerarImpostosDifal; overload;

    function VendaPresencial: Boolean; overload;
    function VendaPresencial(AValue: Boolean): IParametrosRegraZerarImpostosDifal; overload;
  end;

  IRegraImpostosZerarImpostosDifal = interface
    ['{58BE6C34-F4CF-4F76-A103-A7E73368C164}']

    function ZerarValorDoDifal(const AParametros: IParametrosRegraZerarImpostosDifal): Boolean;
  end;

implementation

end.
