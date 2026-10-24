unit untTTodosProdutosMySQLLfe;

interface

uses System.Generics.Collections,
     untTRepositorioEstoque,
     untTRepositorioBasico,
     untTDadosAbertura,
     untTProduto,
     Classes;

type
  TTodosProdutosMySQL = class
  private
    FRepositorioEstoque: TRepositorioEstoque;
    FRepositorio: TRepositorioBasico;
    FAbertura: TDadosAbertura;
  public
    function fRetTodosProdutos(strCodEmp: string; stlProdutos: TStringList; blnNaoRetornarProdutoCAT42_Reg0200: Boolean = False): TObjectList<TProduto>;
    function fRetTodosProdutosEstoque(strCodEmp, strLinGruExcluir: string): TObjectList<TProduto>;

    constructor Create(abertura: TDadosAbertura);
    destructor Destroy; override;
  end;

implementation

{ TTodosProdutosMySQL }

constructor TTodosProdutosMySQL.Create(abertura: TDadosAbertura);
begin
  FRepositorioEstoque := TRepositorioEstoque.Create(FAbertura);
  FRepositorio := TRepositorioBasico.Create;
  FAbertura := abertura
end;

destructor TTodosProdutosMySQL.Destroy;
begin
  FRepositorioEstoque.Free;
  FRepositorio.Free;
  inherited;
end;

function TTodosProdutosMySQL.fRetTodosProdutos(strCodEmp: string; stlProdutos: TStringList; blnNaoRetornarProdutoCAT42_Reg0200: Boolean = False): TObjectList<TProduto>;
begin
  Result := FRepositorio.fRetTodosProdutos(strCodEmp, stlProdutos, blnNaoRetornarProdutoCAT42_Reg0200);
end;

function TTodosProdutosMySQL.fRetTodosProdutosEstoque(strCodEmp, strLinGruExcluir: string): TObjectList<TProduto>;
begin
   Result := nil;
//  Result := FRepositorioEstoque.fRetProdutosEstoquePorTabela(strCodEmp, strLinGruExcluir);
end;

end.
