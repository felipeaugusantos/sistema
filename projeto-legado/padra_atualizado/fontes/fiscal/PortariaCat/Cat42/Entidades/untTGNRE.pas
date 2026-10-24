unit untTGNRE;

interface

type
  TGNRE = class
    private
      FAutenticacaoBancaria: string;
      FEstadoFavorecido: string;
      FNumero: string;
      FTipoGuia: string;
      FValor: double;
      FDataVencimento: TDateTime;
      FDataGnr: TDateTime;
    public
      property strAutenticacaoBancaria: string read FAutenticacaoBancaria write FAutenticacaoBancaria;
      property strEstadoFavorecido: string read FEstadoFavorecido write FEstadoFavorecido;
      property strNumero: string read FNumero write FNumero;
      property strTipoGuia: string read FTipoGuia write FTipoGuia;
      property fltValor: double read FValor write FValor;
      property dtaDataVencimento: TDateTime read FDataVencimento write FDataVencimento;
      property dtaDataGnr: TDateTime read FDataGnr write FDataGnr;
  end;

implementation

end.