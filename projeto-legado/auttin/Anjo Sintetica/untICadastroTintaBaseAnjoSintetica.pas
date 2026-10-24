unit untICadastroTintaBaseAnjoSintetica;

interface

uses
  untICadastroTintaBase;

Type
  ICadastroTintaBaseAnjoSintetica = Interface(ICadastroTintaBase)
    function fGetCampoProdKey(): String;
    function fGetLabelProdKey(): String;
    function fGetCampoSubKey(): String;
    function fGetLabelSubKey(): String;
  End;

implementation

end.
