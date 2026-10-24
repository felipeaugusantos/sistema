unit untITintasDeMaquina;

interface

Type
  ITintasDeMaquina = Interface
    function fGetQtdTintas(): Integer;
    function fGetIdePro(index: Integer): String; overload;
    function fGetIdePro(strNomeTinta: String): String; overload;
    function fGetNomeTinta(index: integer): String; overload;
    function fGetNomeTinta(strIdePro: String): String; overload;
    function fEstaDisponivel(index: Integer): Boolean; overload;
    function fEstaDisponivel(strIdePro: String): Boolean; overload;
    function fGetImobiliarias(): String;
    function fGetIndustriais(): string;
    function fGetAutomotivas(): string;
    function fGetTodosIdePros(): string;
  End;

implementation

end.
