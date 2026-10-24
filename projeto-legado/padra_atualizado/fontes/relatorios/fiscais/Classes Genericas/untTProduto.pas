unit untTProduto;

interface

type
  TProduto = class
  private
    FCodigo: string;
    FDescricao: string;
    FUnidade: string;
    FAliquotaST: double;
    FPreco: double;
    FSaldo: double;
    FTotal: double;
  public
    procedure pSetTotal;

    property strCodigo: string read FCodigo write FCodigo;
    property strDescricao: string read FDescricao write FDescricao;
    property strUnidade: string read FUnidade write FUnidade;
    property fltAliquotaST: double read FAliquotaST write FAliquotaST;
    property fltSaldo: double read FSaldo write FSaldo;
    property fltPreco: double read FPreco write FPreco;
    property fltTotal: double read FTotal write FTotal;
  end;

implementation

{ TProduto }

procedure TProduto.pSetTotal;
begin
  FTotal := FSaldo * FPreco;
end;

end.
