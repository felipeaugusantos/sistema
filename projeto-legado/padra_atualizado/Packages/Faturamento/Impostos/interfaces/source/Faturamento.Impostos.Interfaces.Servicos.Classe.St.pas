unit Faturamento.Impostos.Interfaces.Servicos.Classe.St;

interface

uses Faturamento.Impostos.Interfaces.ST, Faturamento.Impostos.Interfaces.Tributacao,
  Faturamento.Impostos.Interfaces.IcmsSt;

type
  IParametrosClasseSt = interface
    ['{3F1BC961-D6D8-49F3-8B6B-B7D43A7FE0CB}']

    function ParametrosCalculoSt: IParametrosCalculoST; overload;
    function ParametrosCalculoSt(AValue: IParametrosCalculoST): IParametrosClasseSt; overload;

    function RegrasTributacaoIcmsSt: IResultadoRegrasTributacaoIcmsSt; overload;
    function RegrasTributacaoIcmsSt(AValue: IResultadoRegrasTributacaoIcmsSt): IParametrosClasseSt; overload;
  end;

  IResultadoClasseSt = interface
    ['{10715878-B223-4B36-934A-8C4EFE5CC1C8}']

    function ResultadoCalculoSt: IResultadoCalculoST; overload;
    function ResultadoCalculoSt(AValue: IResultadoCalculoST): IResultadoClasseSt; overload;

    function ParametrosCalculoSt: IParametrosCalculoST; overload;
    function ParametrosCalculoSt(AValue: IParametrosCalculoST): IResultadoClasseSt; overload;

    function BaseDeCalculoDaSubstituicaoTributariaParaRegraDaAliquota: Double; overload;
    function BaseDeCalculoDaSubstituicaoTributariaParaRegraDaAliquota(AValue: Double): IResultadoClasseSt; overload;
  end;

  IServicosClasseSt = Interface
    ['{2D3AEEDB-DF2D-4810-B93F-702AC048F319}']

    function CalcularSt: IResultadoClasseSt;
    function CalcularStFinal(const AZerarValorDoSt: Boolean): IResultadoClasseSt;
  End;

implementation

end.
