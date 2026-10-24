unit untIConfTinta;

interface

  uses {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(VER300)} Uni {$ELSE} ZDataset {$IFEND};

Type
  IConfTinta = Interface
    function fRetornaDataset: {$IF Defined(VER250) Or Defined(UNIDAC) Or Defined(VER300)} TUniQuery {$ELSE} TZQuery {$IFEND};

    function fGet(strCodCfg: String): String;
    function fGetInteger(strCodCfg: String): Integer;
    function fGetBoolean(strCodcfg: String): Boolean;
    function fGetDouble(strCodCfg: String): Double;
    function fGetDate(strCodCfg: String): TDateTime;
    
    procedure pSet(strCodCfg: String; strValCfg: string);
    procedure pSetInteger(strCodCfg: String; intValCfg: Integer);
    procedure pSetBoolean(strCodCfg: String; blnValCfg: Boolean);
    procedure pSetDouble(strCodCfg: String;fltValCfg: Double);
    procedure pSetDate(strCodCfg: String; dtaValCfg: TDateTime);

    procedure pInsereCodigo(strCodCfg, strDescri, strDefault, strProPri: String);

  End;

implementation

end.
