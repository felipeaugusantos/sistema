unit untISaldosColorantes;

interface

type
  ISaldoColorante = interface
    ['{0401EAF2-155E-4BCE-97BD-4A7083F51DCD}']
    function GetIDTinta    : Integer;
    function GetDescTinta  : string;
    function GetCodIte     : string;
    function GetDesIte     : string;
    function GetCodCol     : String;
    function GetQtdFormula : Double;
    function GetBasCol     : string;

    property IDTinta    : Integer    read GetIDTinta;
    property DescTinta  : string     read GetDescTinta;
    property CodIte     : string     read GetCodIte;
    property DesIte     : string     read GetDesIte;
    property CodCol     : String     read GetCodCol;
    property QtdFormula : Double     read GetQtdFormula;
    property BasCol     : string     read GetBasCol;
  end;

  ISaldosColorantes = interface
    ['{4C027BAF-9761-49D6-9725-085EDE4B07BF}']
    function GetSaldoColorante(const index : Integer): ISaldoColorante;
    function GetCont                       : Integer;

    property SaldoColorante[const index    : Integer]: ISaldoColorante read GetSaldoColorante; default;
    property Cont                          : Integer                   read GetCont;
  end;

implementation

end.
