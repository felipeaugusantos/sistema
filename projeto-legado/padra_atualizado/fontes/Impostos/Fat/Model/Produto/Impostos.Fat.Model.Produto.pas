unit Impostos.Fat.Model.Produto;

interface

uses Impostos.Fat.Model.Produto.Interfaces, Impostos.Fat.Model.Produto.Tipos,
  Impostos.Fat.Connections.Functions, Uni, Impostos.Fat.Conexao.Interfaces;

type
  TImpostosFatModelProduto = class sealed(TInterfacedObject, IImpostosFatModelProduto)
  private
    FConexao: TUniConnection;
  public
    function Consultar(const ACodigoDoProduto: String; const ACodigoDaEmpresa: String): IResultadoImpostosFatModelProduto;

    constructor Create;
    class function New(): IImpostosFatModelProduto;
  end;


implementation

{ TImpostosFatModelProduto }

function TImpostosFatModelProduto.Consultar(const ACodigoDoProduto,
  ACodigoDaEmpresa: String): IResultadoImpostosFatModelProduto;
var
  LIpiDeSaida: Double;
begin
  LIpiDeSaida := fCampoTabelaFat('ITE_IPISAI', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [ACodigoDoProduto, ACodigoDaEmpresa], False, '', FConexao);

  Result :=
    TResultadoImpostosFatModelProduto.New
      .IpiDeSaida(LIpiDeSaida);
end;

constructor TImpostosFatModelProduto.Create;
begin
  FConexao := objConexao.Conexao;
end;

class function TImpostosFatModelProduto.New(): IImpostosFatModelProduto;
begin
  Result := Self.Create;
end;

end.
