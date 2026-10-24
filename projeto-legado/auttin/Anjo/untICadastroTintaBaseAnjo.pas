unit untICadastroTintaBaseAnjo;

interface

uses
  untICadastroTintaBase;

Type
  ICadastroTintaBaseAnjo = Interface(ICadastroTintaBase)
    function fGetCampoProdKey(): String;
    function fGetLabelProdKey(): String;
    function fGetCampoSubKey(): String;
    function fGetLabelSubKey(): String;
  End;

implementation

end.
