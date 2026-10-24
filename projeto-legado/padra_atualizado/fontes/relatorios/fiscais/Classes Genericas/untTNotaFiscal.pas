unit untTNotaFiscal;

interface

type
  //valores dos impostos rateados por cfop+alíquota
  TDetalhamentoNotaFiscal = class
  private
    FBaseIcms: double;
    FAliquotaIcms: double;
    FValorIcms: double;
  public
    property fltBaseIcms: double read FBaseIcms write FBaseIcms;
    property fltAliquotaIcms: double read FAliquotaIcms write FAliquotaIcms;
    property fltValorIcms: double read FValorIcms write FValorIcms;
  end;

  TNotaFiscal = class
  private
    FNumero: string;
    FSerie: string;
  public
    property strNumero: string read FNumero write FNumero;
    property strSerie: string read FSerie write FSerie;
  end;

implementation

end.
