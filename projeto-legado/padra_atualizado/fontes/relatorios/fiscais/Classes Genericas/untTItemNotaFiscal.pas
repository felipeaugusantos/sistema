unit untTItemNotaFiscal;

interface

type
  TItemNotaFiscal = class
  private
    FData: TDateTime;
    FNumero: string;
    FSerie: string;
    FCodigoParticipante: string;
    FQuantidade: double;
    FBaseSt: double;
    FValorUnitario: double;
    FTotalProduto: double;
  public
    property dtaData: TDateTime read FData write FData;
    property strNumero: string read FNumero write FNumero;
    property strSerie: string read FSerie write FSerie;
    property strCodigoParticipante: string read FCodigoParticipante write FCodigoParticipante;
    property fltQuantidade: double read FQuantidade write FQuantidade;
    property fltBaseSt: double read FBaseSt write FBaseSt;
    property fltValorUnitario: double read FValorUnitario write FValorUnitario;
    property fltTotalProduto: double read FTotalProduto write FTotalProduto;
  end;

implementation

end.
