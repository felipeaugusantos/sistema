unit untICadastroTintaColorantes;

interface

uses
  untICadastroTinta;

Type
  ICadastroTintaColorantes = Interface(ICadastroTinta)
    function fGetCampoCodigo(): String;
    function fGetLabelCodigo(): String;
    function fGetCampoItem(): String;
    function fGetLabelItem(): String;
    function fGetCampoDescricao(): String;
    function fGetCampoCusto(): String;
    function fGetLabelCusto(): String;
    function fGetCampoVenda(): String;
    function fGetLabelVenda(): String;
    function fGetCampoMargem(): String;
    function fGetLabelMargem(): String;
    procedure pAtualizaFatorTintometrico;
  End;

implementation

end.
 