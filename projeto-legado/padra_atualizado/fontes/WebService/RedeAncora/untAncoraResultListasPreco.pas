unit untAncoraResultListasPreco;

interface

uses untAncoraBase;

type
  TAncoraResultListasPreco = class;
  TArrayOfTAncoraResultListasPreco = Array of TAncoraResultListasPreco;
  TAncoraResultListasPrecoResultados = class;

  TAncoraResultListasPreco = class
  private
    FProdutoCodigoFornecedor: string;
    FCnpj: string;
    FPreco: Double;
    FProdutoCNA: string;
    FMarca: string;
  public
    property Cnpj: string read FCnpj write FCnpj;
    property Marca: string read FMarca write FMarca;
    property ProdutoCNA: string read FProdutoCNA write FProdutoCNA;
    property ProdutoCodigoFornecedor: string read FProdutoCodigoFornecedor write FProdutoCodigoFornecedor;
    property Preco: Double read FPreco write FPreco;
  end;

  TAncoraResultListasPrecoResultados = class(TAncoraJson)
  private
    FResultados: TArrayOfTAncoraResultListasPreco;
  public
    property Resultados: TArrayOfTAncoraResultListasPreco read FResultados write FResultados;
  end;

implementation

end.

