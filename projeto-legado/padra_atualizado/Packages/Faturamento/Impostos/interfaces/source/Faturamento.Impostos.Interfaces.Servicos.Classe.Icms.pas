unit Faturamento.Impostos.Interfaces.Servicos.Classe.Icms;

interface

uses Faturamento.Impostos.Interfaces.Icms, Faturamento.Impostos.Interfaces.Tributacao,
  Faturamento.Impostos.Interfaces.IcmsSt;

type
  IParametrosClasseIcms = interface
    ['{D63C6BE5-06AB-452A-A498-C87EAB784E43}']

    function ParametrosCalculoIcms: IParametrosCalculoIcms; overload;
    function ParametrosCalculoIcms(AValue: IParametrosCalculoIcms): IParametrosClasseIcms; overload;

    function RegrasTributacaoIcmsSt: IResultadoRegrasTributacaoIcmsSt; overload;
    function RegrasTributacaoIcmsSt(AValue: IResultadoRegrasTributacaoIcmsSt): IParametrosClasseIcms; overload;
  end;

  IResultadoClasseIcms = interface
    ['{11BF66E1-81E3-40DC-92B1-2626EE003E00}']

    function ResultadoCalculoIcms: IResultadoCalculoIcms; overload;
    function ResultadoCalculoIcms(AValue: IResultadoCalculoIcms): IResultadoClasseIcms; overload;

    function ParametrosCalculoIcms: IParametrosCalculoIcms; overload;
    function ParametrosCalculoIcms(AValue: IParametrosCalculoIcms): IResultadoClasseIcms; overload;

    function CalculouOValorDoIcms: Boolean; overload;
    function CalculouOValorDoIcms(AValue: Boolean): IResultadoClasseIcms; overload;
  end;

  IServicosClasseIcms = Interface
    ['{525748CA-7559-41EE-8A51-0E8EC9185584}']

    function CalcularIcms: IResultadoClasseIcms;
    function CalcularIcmsFinal(const AZerarValorDoIcms: Boolean): IResultadoClasseIcms;
  End;

implementation

end.
