{******************************************************}
{* Interface que representa as configurações da tinta *}
{***************************************************PH*}
unit untIConfTinta;

interface

Type
  IConfTinta = Interface
    function fGet(strCodCfg: String): String;
    function fGetInteger(strCodCfg: String): Integer;
    function fGetBoolean(strCodcfg: String): Boolean;
    function fGetDouble(strCodCfg: String): Double;
    function fGetDate(strCodCfg: String): TDateTime;

    procedure pSet(strCodCfg: String; strValCfg: String);
    procedure pSetInteger(strCodCfg: String; intValCfg: Integer);
    procedure pSetBoolean(strCodCfg: String; blnValCfg: Boolean);
    procedure pSetDouble(strCodCfg: String;fltValCfg: Double);
    procedure pSetDate(strCodCfg: String; dtaValCfg: TDateTime);

    procedure pInsereCodigo(strCodCfg, strDescri, strDefault: String);


  End;

implementation

end.
