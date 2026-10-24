unit untAncoraResultBuscaProduto;

interface

uses untAncoraBase;

type
  TAncoraResultBuscaProduto = class;
  TArrayOfTAncoraResultBuscaProduto = Array of TAncoraResultBuscaProduto;
  TAncoraResultBuscaProdutoResultados = class;

  TAncoraResultBuscaProduto = class
  private
    FCodigoRedeAncora  :Double;
    FNome              :String;
    FDescricao         :String;
    FCNA               :String;
    FFabricante        :String;
    FFornecedor        :String;
    FCodigoFornecedor  :String;
    FMarca             :String;
    FPreco             :Double;
    FFamilia           :String;
    FLinha             :String;
    FEAN               :String;
    FPeso              :String;
    FNCM               :String;
    FUnVenda           :String;
    FUnCompra          :String;
    FEstoque           :Double;
  public
    property CodigoRedeAncora :Double Read FCodigoRedeAncora write FCodigoRedeAncora;
    property Nome             :String Read FNome             write FNome            ;
    property Descricao        :String Read FDescricao        write FDescricao       ;
    property CNA              :String Read FCNA              write FCNA             ;
    property Fabricante       :String Read FFabricante       write FFabricante      ;
    property Fornecedor       :String Read FFornecedor       write FFornecedor      ;
    property CodigoFornecedor :String Read FCodigoFornecedor write FCodigoFornecedor;
    property Marca            :String Read FMarca            write FMarca           ;
    property Preco            :Double Read FPreco            write FPreco           ;
    property Familia          :String Read FFamilia          write FFamilia         ;
    property Linha            :String Read FLinha            write FLinha           ;
    property EAN              :String Read FEAN              write FEAN             ;
    property Peso             :String Read FPeso             write FPeso            ;
    property NCM              :String Read FNCM              write FNCM             ;
    property UnVenda          :String Read FUnVenda          write FUnVenda         ;
    property UnCompra         :String Read FUnCompra         write FUnCompra        ;
    property Estoque          :Double Read FEstoque          write FEstoque         ;
  end;

  TAncoraResultBuscaProdutoResultados = class(TAncoraJson)
  private
    FResultados: TArrayOfTAncoraResultBuscaProduto;
  public
    property Resultados: TArrayOfTAncoraResultBuscaProduto read FResultados write FResultados;
  end;

implementation

end.


