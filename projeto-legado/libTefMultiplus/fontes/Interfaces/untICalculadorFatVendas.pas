{*****************************************************************************************************************}
{*  Interface resposável por alguns metodos utilizados no fatvendas, sessa maneira é possivel passar o fatvendas *}
{*  para as outras dll do sistema, sem que todas as dependencias de units sejam adicionadas ao projeto           *}
{**************************************************************************************************************PP*}

unit untICalculadorFatVendas;

interface

uses
  DB, {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(VER300)} Uni {$ELSE} ZDataSet  {$IFEND};

type
  ICalculadorFatVendas = interface
    ['{A18A640F-368A-4FF2-814A-B77D69B8106E}']
    function fCalculaAliquota(strCodIte, strImpDir: String): Double;
    function fPegaPrecoVenda(qryCadIte: TDataset; strEntSai: String; fltMargem: Double; blnItemEspecial : Boolean = False;
      strIdePro: String = 'NOR'; strTabPreItem: String = ''):Double;
    function GetQryConIte: {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(VER300)} TUniQuery {$ELSE} TZQuery {$IFEND};
    function fPegaPrecoCusto(qryCadIte: TDataset): Double;
    function GetStrClaFis(): string;
    function GetStrOpcDoc(): string;
    function GetStrCodCnd(): string;
    function GetStrCodCli(): string;
    function GetIntPrzMed(): Integer;        
  end;

implementation

end.
