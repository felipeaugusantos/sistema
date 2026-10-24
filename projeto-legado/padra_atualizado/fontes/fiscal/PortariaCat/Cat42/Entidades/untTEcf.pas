unit untTEcf;

interface

type
  TEcf = class
    private
      FCodigo: string;
      FNumeroSerie: string;
      FModelo: string;
      FNumUsu: string;
    public
      property strCodigo: string read FCodigo write FCodigo;
      property strNumeroSerie: string read FNumeroSerie write FNumeroSerie;
      property strNumUsu: string read FNumUsu write FNumUsu;
      property strModelo: string read FModelo write FModelo;
  end;

implementation

end.
