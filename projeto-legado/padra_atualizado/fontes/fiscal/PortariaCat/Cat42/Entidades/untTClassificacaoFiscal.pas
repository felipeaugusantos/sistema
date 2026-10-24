unit untTClassificacaoFiscal;

interface

type
  TClassificacaoFiscal = class
    private
      FCodigo: string;
      FDescricao: string;
    public
      property strCodigo: string read FCodigo write FCodigo;
      property strDescricao: string read FDescricao write FDescricao;
  end;

implementation

end.