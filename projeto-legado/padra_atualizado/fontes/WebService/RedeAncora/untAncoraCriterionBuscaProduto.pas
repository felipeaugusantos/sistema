unit untAncoraCriterionBuscaProduto;

interface

uses untAncoraBase;

type
  TAncoraCriterionBuscaProduto = class;
  TAncoraCriterionBuscaProdutoFiltros = class;

  TAncoraCriterionBuscaProduto = class(TAncoraJson)
  private
    FFiltros: TAncoraCriterionBuscaProdutoFiltros;
  public
    constructor Create;
    destructor Destroy; override;
    property Filtros: TAncoraCriterionBuscaProdutoFiltros read FFiltros write FFiltros;
  end;

  TAncoraCriterionBuscaProdutoFiltros = class
  private
    FCnpj: string;
    FProdutoCNA: string;
    FProdutoCodigoFornecedor: string;
  public
    property Cnpj: string read FCnpj write FCnpj;
    property ProdutoCNA: string read FProdutoCNA write FProdutoCNA;
    property ProdutoCodigoFornecedor: string read FProdutoCodigoFornecedor write FProdutoCodigoFornecedor;
  end;

implementation

{ TAncoraCriterionBuscaProdutos }

constructor TAncoraCriterionBuscaProduto.Create;
begin
  FFiltros := TAncoraCriterionBuscaProdutoFiltros.Create;
end;

destructor TAncoraCriterionBuscaProduto.Destroy;
begin
  FFiltros.Free;
  inherited;
end;

end.
























