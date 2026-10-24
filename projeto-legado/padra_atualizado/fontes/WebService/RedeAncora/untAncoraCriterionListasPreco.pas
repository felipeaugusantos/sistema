unit untAncoraCriterionListasPreco;

interface

uses untAncoraBase;

type
  TAncoraCriterionListasPreco = class;
  TAncoraCriterionListasPrecoFiltros = class;

  TAncoraCriterionListasPreco = class(TAncoraJson)
  private
    FFiltros: TAncoraCriterionListasPrecoFiltros;
  public
    constructor Create;
    destructor Destroy; override;
    property Filtros: TAncoraCriterionListasPrecoFiltros read FFiltros write FFiltros;
  end;

  TAncoraCriterionListasPrecoFiltros = class
  private
    FCnpj: string;
    FMarca: string;
    FProdutoCNA: string;
    FProdutoCodigoFornecedor: string;
  public
    property Cnpj: string read FCnpj write FCnpj;
    property Marca: string read FMarca write FMarca;
    property ProdutoCNA: string read FProdutoCNA write FProdutoCNA;
    property ProdutoCodigoFornecedor: string read FProdutoCodigoFornecedor write FProdutoCodigoFornecedor;
  end;

implementation

{ TAncoraCriterionListasPrecos }

constructor TAncoraCriterionListasPreco.Create;
begin
  FFiltros := TAncoraCriterionListasPrecoFiltros.Create;
end;

destructor TAncoraCriterionListasPreco.Destroy;
begin
  FFiltros.Free;
  inherited;
end;

end.
