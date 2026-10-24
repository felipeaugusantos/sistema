unit untIFatMostraMargemNovo;

interface

uses untFuncFat, DB, UniClientDataSet;

type
  IFatMostraMargemNovoValidaUnitario = interface
    ['{FE44AD4C-9162-4C1A-A5C6-D05111475EC6}']

    function RetornarAPorcentagemDoDescontoMaximoGerente(fatVenda: TFatVenda; DataSet: TDataSet): Double;
    function RetornarAPorcentagemDoDescontoMaximoSubGerente(fatVenda: TFatVenda; DataSet: TDataSet): Double;
  end;

  IFatMostraMargemNovoAdicionarTinta = interface
    ['{CD235501-9226-4E71-A925-3E57349A568F}']

    function RetornarValorMargemPropostaCustoDoItem(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemPraticadaCustoDoItem(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemPropostaPrecoDeCusto(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemPraticadaPrecoDeCusto(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemBrutaPrecoMedio(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemLiquidaPrecoMedio(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemBrutaPrecoDeUltimaCompra(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemLiquidaPrecoDeUltimaCompra(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemBrutaPrecoDeUltimaCompraComImpostos(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemLiquidaPrecoDeUltimaCompraComImpostos(cdsItens: TUniClientDataSet): Double;

    function fRetornaPrecoCustoRealSub(fltParPrecoCusto: Double; fltParPrecoVenda : Double; cdsItens: TUniClientDataSet; fatVenda: TFatVenda): Double;

    procedure SetDecUni(intDecUni: Integer);

    function RetornarValorMargemPraticadaPrecoDeCustoBruta(cdsItens: TUniClientDataSet): Double;
    function RetornarValorMargemLiquidaPrecoMedioBruta(cdsItens: TUniClientDataSet): Double;
  end;

  IFatMostraMargemNovoBeforePost = interface
    ['{4F10E0FC-677E-4B2C-BBBF-CE6998E29830}']

    function RetornarValorUnitario(DataSet: TDataSet; cdsItens: TUniClientDataSet; fatVenda: TFatVenda; cdsVenda: TUniClientDataSet; strCampoMargem: String): Double;
    function RetornarValorPrecoCusto(DataSet: TDataSet; cdsItens: TUniClientDataSet; fatVenda: TFatVenda ): Double; overload;
    function RetornarValorPrecoCusto(DataSet: TDataSet; cdsItens: TUniClientDataSet; fatVenda: TFatVenda; cdsDados: TUniClientDataSet): Double; overload;
    function RetornarValorTotalDoItem(DataSet: TDataSet; fatVenda: TFatVenda): Double;
    function RetornarValorUnitarioDolar(DataSet: TDataSet): Double;
    function RetornarValorUnitarioComPercentualDeDesconto(DataSet: TDataSet): Double;
    function RetornarPercentualDaMargem(cdsItens: TUniClientDataSet; fatVenda: TFatVenda; strCampoMargem: String): Double;
  end;

  IFatMostraMargemNovoFactory = interface
    ['{91234D38-F5C8-4292-9719-A0A95D562001}']

    function ValidaUnitario: IFatMostraMargemNovoValidaUnitario;
    function AdicionarTinta: IFatMostraMargemNovoAdicionarTinta;
    function BeforePost: IFatMostraMargemNovoBeforePost;
  end;

  IFatMostraMargemNovoController = interface
    ['{ED51D008-C46F-42AA-9F28-835EFE5081E6}']

    function ValidaUnitario: IFatMostraMargemNovoValidaUnitario;
    function AdicionarTinta: IFatMostraMargemNovoAdicionarTinta;
    function BeforePost: IFatMostraMargemNovoBeforePost;
  end;

implementation

end.
