unit Faturamento.Impostos.Interfaces.Tributacao.DepoisDoCalculo;

interface

type
  IParametrosRegrasTributacaoDepoisDoCalculo = interface
    ['{12C18B21-FF24-45DD-9818-E99E3566F2A8}']

    function ReducaoRICMPR: Boolean; overload;
    function ReducaoRICMPR(AValue: Boolean): IParametrosRegrasTributacaoDepoisDoCalculo; overload;

    function PercentualDaBaseDaSubstituicaoTributariaDoItem: Double; overload;
    function PercentualDaBaseDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosRegrasTributacaoDepoisDoCalculo; overload;

    function AliquotaDaSubstituicaoTributariaDoItem: Double; overload;
    function AliquotaDaSubstituicaoTributariaDoItem(AValue: Double): IParametrosRegrasTributacaoDepoisDoCalculo; overload;

    function PercentualDeReducaoDaBaseDeIcmsDoItem: Double; overload;
    function PercentualDeReducaoDaBaseDeIcmsDoItem(AValue: Double): IParametrosRegrasTributacaoDepoisDoCalculo; overload;
  end;

  IResultadoRegrasTributacaoDepoisDoCalculo = interface
    ['{6B56F88D-B6C3-45D7-A52B-97C71A6A5FE4}']

    function PercentualDaBaseDaSubstituicaoTributariaDoItem: Double; overload;
    function PercentualDaBaseDaSubstituicaoTributariaDoItem(AValue: Double): IResultadoRegrasTributacaoDepoisDoCalculo; overload;

    function AliquotaDaSubstituicaoTributariaDoItem: Double; overload;
    function AliquotaDaSubstituicaoTributariaDoItem(AValue: Double): IResultadoRegrasTributacaoDepoisDoCalculo; overload;
  end;

  IRegraImpostosTributacaoDepoisDoCalculo = interface
    ['{0E9ED4CE-C1DF-40B4-A41D-7BFEDD15A85A}']

    function ReducaoPercentualBaseSubstituicaoTributaria: IRegraImpostosTributacaoDepoisDoCalculo;
    function AliquotaDaSubstituicaoTributariaDoItem: IRegraImpostosTributacaoDepoisDoCalculo;
    function ResultadoRegrasTributacaoDepoisDoCalculo: IResultadoRegrasTributacaoDepoisDoCalculo;
  end;

implementation

end.
