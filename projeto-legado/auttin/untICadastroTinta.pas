unit untICadastroTinta;

interface

uses
  untIConsulta;

Type
  ICadastroTinta = Interface
    function fGetIdePro(): String;
    function fGetNomeTabela(): String;
    function fGetNomeCampo(): String;
    function fGetConsulta(): IConsulta;
    function fGetNomeClasse(): String;
    function fGetCountCamposChave(): Integer;
    function fGetCampoChave(intIndex: Integer): String;
    function fGetNomeTinta(): String;
    function fGetCampoCadIteCodIte(): String;
    function fGetLabelCodIteCodIte(): String;
    function fValidaCampos(strNomeCampo, strValorCampo: String; var strRetorno: String): Boolean;
  End;

implementation

end.
