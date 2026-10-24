unit untIConsulta;

interface

Type

  IConsulta = Interface
    function fGetCaptionColuna(intPos: Integer): String; overload;
    function fGetNomeCampoColuna(intPos: Integer): String; overload;
    function fGetSelect(blnTodos: Boolean): String;
    function fGetQtdColunas(): Integer;
    function fGetQtdColunasVisiveis(): Integer;
    function fGetNomeCampoColunaVisivel(intPos: Integer): String;
    function fGetCaptionColunaVisivel(intPos: Integer): String;
    function fGetVisivel(intPos: Integer): Boolean;
    function fGetCaptionColuna(strNomeCampo: String): String; overload;
    function fGetNomeCampoColuna(strCaptionColuna: String): String; overload;
    procedure fSetVisivel(intPos: Integer; blnValor: Boolean); overload;
    procedure fSetVisivel(strNomeCampo: String; blnValor: Boolean); overload;
    function fGetPos(strNomeCampo: String): Integer;
    procedure pSalvarConfs();
    procedure fSetPos(strNomeCampo: String; intPos: Integer);
    function fGetDisponivel(intPos: Integer): Boolean; overload;
    function fGetDisponivel(strNomeCampo: String): Boolean; overload;
    function fGetOperador(intIndex: Integer): String; overload;
    function fGetOperador(strNomeCampo: String): String; overload;
    procedure pRestaurarPadrao();
  End;

implementation

end.
