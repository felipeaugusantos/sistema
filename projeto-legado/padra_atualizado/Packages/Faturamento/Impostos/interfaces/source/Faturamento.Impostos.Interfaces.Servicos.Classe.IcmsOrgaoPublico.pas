unit Faturamento.Impostos.Interfaces.Servicos.Classe.IcmsOrgaoPublico;

interface

uses Faturamento.Impostos.Interfaces.IcmsOrgaoPublico, Faturamento.Impostos.Interfaces.Tributacao,
  Faturamento.Impostos.Interfaces.IcmsSt;

type
  IParametrosClasseIcmsOrgaoPublico = interface
    ['{C5B80BD9-D235-4C01-9CAB-13D5AD7372BB}']

    function ParametrosCalculoIcmsOrgaoPublico: IParametrosCalculoIcmsOrgaoPublico; overload;
    function ParametrosCalculoIcmsOrgaoPublico(AValue: IParametrosCalculoIcmsOrgaoPublico): IParametrosClasseIcmsOrgaoPublico; overload;

    function RegrasTributacaoIcmsSt: IResultadoRegrasTributacaoIcmsSt; overload;
    function RegrasTributacaoIcmsSt(AValue: IResultadoRegrasTributacaoIcmsSt): IParametrosClasseIcmsOrgaoPublico; overload;
  end;

  IResultadoClasseIcmsOrgaoPublico = interface
    ['{DB34779C-60BD-4821-90AA-713116965D39}']

    function ResultadoCalculoIcmsOrgaoPublico: IResultadoCalculoIcmsOrgaoPublico; overload;
    function ResultadoCalculoIcmsOrgaoPublico(AValue: IResultadoCalculoIcmsOrgaoPublico): IResultadoClasseIcmsOrgaoPublico; overload;

    function ParametrosCalculoIcmsOrgaoPublico: IParametrosCalculoIcmsOrgaoPublico; overload;
    function ParametrosCalculoIcmsOrgaoPublico(AValue: IParametrosCalculoIcmsOrgaoPublico): IResultadoClasseIcmsOrgaoPublico; overload;
  end;

  IServicosClasseIcmsOrgaoPublico = Interface
    ['{76A18051-6F09-47AE-9BFE-F5ED760A829F}']

    function CalcularIcmsOrgaoPublico: IResultadoClasseIcmsOrgaoPublico;
    function CalcularIcmsOrgaoPublicoFinal: IResultadoClasseIcmsOrgaoPublico;
  End;


implementation

end.
