unit untIConsultaTinta;

interface

uses untIConsulta;

Type
  IConsultaTinta = Interface(IConsulta)
    function fGetQtdCamposDescricao(): Integer;
    function fGetCampoDescricao(intIndex: Integer): String;
    function fGetDesCampoDescricao(intIndex: Integer): String;
    procedure pAdicionarCampoDescricao(strNomeCampo: String);
    function fGetDescricao(strAutoincrem: String): String; overload;
    function fGetDescricao(strAutoincrem: String; strCodIte: String): String; overload;
    procedure pLimparDescricao();
    function fGetCampoAutoIncrem(): String;
    function fGetNomeTinta(): String;
    function fGetNomeTabela(): String;
    function fGetSelectAutoIncrem(strAutoIncrem: String): String;
    procedure SetstrLinhaWandaPro(const Value: String);
  End;

implementation

end.
