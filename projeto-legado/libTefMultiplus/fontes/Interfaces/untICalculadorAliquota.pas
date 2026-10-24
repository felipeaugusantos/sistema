unit untICalculadorAliquota;

interface

type
  ICalculadorAliquota = interface
    ['{A18A640F-368A-4FF2-814A-B77D69B8106E}']
    Function fCalculaAliquota(strCodIte, strImpDir: String): Double;
  end;

implementation

end.
