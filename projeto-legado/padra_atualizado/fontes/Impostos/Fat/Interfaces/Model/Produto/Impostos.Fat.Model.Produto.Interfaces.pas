unit Impostos.Fat.Model.Produto.Interfaces;

interface

type
  IResultadoImpostosFatModelProduto = interface
    ['{26CCBB8C-7A72-4E72-8A3A-6E3C9E75C78F}']

    function IpiDeSaida: Double; overload;
    function IpiDeSaida(AValue: Double): IResultadoImpostosFatModelProduto; overload;
  end;

  IImpostosFatModelProduto = interface
    ['{81DB7FE1-A50D-491F-99DA-D7DF185095C8}']

    function Consultar(const ACodigoDoProduto: String; const ACodigoDaEmpresa: String): IResultadoImpostosFatModelProduto;
  end;


implementation

end.
