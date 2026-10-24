unit untICadastroTintaBaseResicolor;

interface

uses
  untICadastroTintaBase;

Type
  ICadastroTintaBaseResicolor = Interface(ICadastroTintaBase)
    function fGetCampoProdKey(): String;
    function fGetLabelProdKey(): String;
    function fGetCampoSubKey(): String;
    function fGetLabelSubKey(): String;
  End;

implementation

end.
