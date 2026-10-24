unit Contabilidade.Model.PlanoContas;

interface

type
  TPlanoContas = class
  private
    FCodigo: string;
    FDescricao: string;
    FContaContabil: string;
  public
    property strCodigo: string read FCodigo write FCodigo;
    property strDescricao: string read FDescricao write FDescricao;
    property strContaContabil: string read FContaContabil write FContaContabil;
  end;

implementation

end.
