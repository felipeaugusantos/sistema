unit untIEspelhoMargemLucro;

interface

uses UniClientDataSet;

type
  IEspelhoMargemLucro = interface
    ['{0BE68E21-F6E2-4C69-96F1-7D1DEC09E000}']

    function SetCdsItensMargem(AValue: TUniClientDataSet): IEspelhoMargemLucro;
    function SetAutIncMovDet(AValue: String): IEspelhoMargemLucro;
    function SetPosicaoMatrizItens(AValue: Integer): IEspelhoMargemLucro;

    procedure pGravarEspelhoMargemLucro;
  end;

implementation

end.
