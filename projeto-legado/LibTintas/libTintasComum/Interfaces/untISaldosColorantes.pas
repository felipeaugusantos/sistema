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
//    function GetQtdFormOri : Double;
//    function GetQtdFormAcu : Double;//Acumulado na Venda
//    function GetSaldoML    : Double;
    function GetBasCol     : string;
//    function GetEmpPrd     : string;
    function GetPesGra     : string;
    function GetEmbala     : Double;

    property IDTinta    : Integer    read GetIDTinta;
    property DescTinta  : string     read GetDescTinta;
    property CodIte     : string     read GetCodIte;
    property DesIte     : string     read GetDesIte;
    property CodCol     : String     read GetCodCol;
    property QtdFormula : Double     read GetQtdFormula;
//    property QtdFormOri : Double     read GetQtdFormOri;
//    property QtdFormAcu : Double     read GetQtdFormAcu;//Acumulado na Venda
//    property SaldoML    : Double     read GetSaldoML;
    property BasCol     : string     read GetBasCol;
//    property EmpPrd     : string     read GetEmpPrd;
    property PesGra     : string     read GetPesGra;
    property Embala     : Double     read GetEmbala;
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
