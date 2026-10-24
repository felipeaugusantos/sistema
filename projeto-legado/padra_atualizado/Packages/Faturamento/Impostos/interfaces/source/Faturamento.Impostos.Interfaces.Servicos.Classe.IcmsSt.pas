unit Faturamento.Impostos.Interfaces.Servicos.Classe.IcmsSt;

interface

uses Faturamento.Impostos.Interfaces.IcmsSt;

type
  IFaturamentoImpostosServicosClasseIcmsSt = interface
    ['{253B4114-1583-4DA9-AB12-4F60A3C98575}']

    function CalcularValorIcmsSt: IResultadoServicosClasseIcmsSt;
    function CalcularValorIcmsStFinal: IResultadoServicosClasseIcmsSt;
  end;

implementation

end.
