unit Faturamento.Margem.Interfaces.MargemBruta;

interface

Uses
  Shared.Functions.Types;

type
  IParametrosServicoMargemBruta = interface
    ['{F8437793-0AEB-44F7-999B-4014DBB09CD4}']

    function ConfiguracaoMargemMarkup: String; overload;
    function ConfiguracaoMargemMarkup(AValue : String) : IParametrosServicoMargemBruta; overload;

    function PrecoDeCusto : Double; overload;
    function PrecoDeCusto(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function PrecoDeVenda : Double; overload;
    function PrecoDeVenda(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function ValorDaMargem: Double; overload;
    function ValorDaMargem(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function IcmsDeSaida : Double; overload;
    function IcmsDeSaida(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function ImpostosFederais : Double; overload;
    function ImpostosFederais(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function DespesasOperacionais : Double; overload;
    function DespesasOperacionais(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function PrecoDeCompra : Double; overload;
    function PrecoDeCompra(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function ValorIcmsSt : Double; overload;
    function ValorIcmsSt(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function CalcularST : Boolean; overload;
    function CalcularST(AValue : Boolean) : IParametrosServicoMargemBruta; overload;

    function ValorDifal : Double; overload;
    function ValorDifal(AValue : Double) : IParametrosServicoMargemBruta; overload;

    function ValorFCP: Double; overload;
    function ValorFCP(AValue: Double) : IParametrosServicoMargemBruta; overload;
  end;

  IParametrosServicoMargemParaMarkup = interface
    ['{A019CBB0-C22C-4DE6-8B6F-D7C0F705BB8C}']
    function ValorDaMargem : Double; overload;
    function ValorDaMargem(AValue : Double) : IParametrosServicoMargemParaMarkup; overload;
  end;

  IParametrosCalculoMargemBruta = interface
    ['{CA03C395-6080-42C9-9E41-F6DA3D077823}']
    function ConfiguracaoMargemMarkup: String; overload;
    function ConfiguracaoMargemMarkup(AValue : String) : IParametrosCalculoMargemBruta; overload;

    function PrecoDeCusto : Double; overload;
    function PrecoDeCusto(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function PrecoDeVenda : Double; overload;
    function PrecoDeVenda(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function ValorDaMargem : Double; overload;
    function ValorDaMargem(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function IcmsDeSaida : Double; overload;
    function IcmsDeSaida(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function ImpostosFederais : Double; overload;
    function ImpostosFederais(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function DespesasOperacionais : Double; overload;
    function DespesasOperacionais(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function PrecoDeCompra : Double; overload;
    function PrecoDeCompra(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function ValorIcmsSt : Double; overload;
    function ValorIcmsSt(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function CalcularST : Boolean; overload;
    function CalcularST(AValue : Boolean) : IParametrosCalculoMargemBruta; overload;

    function ValorDifal : Double; overload;
    function ValorDifal(AValue : Double) : IParametrosCalculoMargemBruta; overload;

    function ValorFCP: Double; overload;
    function ValorFCP(AValue: Double) : IParametrosCalculoMargemBruta; overload;

  end;

  IParametrosCalculoMargemParaMarkup = interface
    ['{A019CBB0-C22C-4DE6-8B6F-D7C0F705BB8C}']
    function ValorDaMargem : Double; overload;
    function ValorDaMargem(AValue : Double) : IParametrosCalculoMargemParaMarkup; overload;
  end;

  IResultadoCalculoMargemBruta = interface
    ['{AD6758BC-368B-4236-A95E-228A94BC1367}']
    function ValorMargemBruta: Double; overload;
    function ValorMargemBruta(AValue: Double) : IResultadoCalculoMargemBruta; overload;

  end;

  IResultadoCalculoMargemParaMarkup = interface
    ['{AD6758BC-368B-4236-A95E-228A94BC1367}']
    function ValorMarkup: Double; overload;
    function ValorMarkup(AValue: Double) : IResultadoCalculoMargemParaMarkup; overload;

  end;


  ICalculoMargemMargemBruta = interface
    ['{255E30DF-302C-4235-91E8-164C9E25365F}']
    function CalculaMargemBruta(const AParametros: IParametrosCalculoMargemBruta): IResultadoCalculoMargemBruta; overload;

    function CalculaMargemParaMarkup(const AParametros: IParametrosCalculoMargemParaMarkup): IResultadoCalculoMargemParaMarkup; overload;
  end;

  IResultadoServicosClasseMargemBruta = interface
    ['{D39072BC-78D8-4044-BF0A-1585B5310AF1}']
    function ParametrosCalculoMargemBruta  : IParametrosCalculoMargemBruta; overload;
    function ParametrosCalculoMargemBruta(AValue : IParametrosCalculoMargemBruta) : IResultadoServicosClasseMargemBruta; overload;

    function ParametrosCalculoMargemParaMarkup: IParametrosCalculoMargemParaMarkup; overload;
    function ParametrosCalculoMargemParaMarkup( AValue : IParametrosCalculoMargemParaMarkup) :IResultadoServicosClasseMargemBruta; overload;

    function ResultadoCalculoMargemBruta: IResultadoCalculoMargemBruta; overload;
    function ResultadoCalculoMargemBruta(AValue: IResultadoCalculoMargemBruta): IResultadoServicosClasseMargemBruta; overload;

    function ResultadoCalculoMargemParaMarkup: IResultadoCalculoMargemParaMarkup; overload;
    function ResultadoCalculoMargemParaMarkup(AValue: IResultadoCalculoMargemParaMarkup): IResultadoServicosClasseMargemBruta; overload;

  end;

implementation

end.
