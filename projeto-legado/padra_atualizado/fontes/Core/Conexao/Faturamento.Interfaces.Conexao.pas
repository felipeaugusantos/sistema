unit Faturamento.Interfaces.Conexao;

interface

uses Uni;

type
  IImpostosFatConexao = interface
    ['{8E884435-FCD6-409F-AE5C-E384A22D06BE}']

    function Conexao: TUniConnection;
  end;

  procedure SetarObjConexao(AValue: IImpostosFatConexao);

Var
  objConexao: IImpostosFatConexao;

implementation

procedure SetarObjConexao(AValue: IImpostosFatConexao);
begin
  objConexao := AValue;
end;

end.
