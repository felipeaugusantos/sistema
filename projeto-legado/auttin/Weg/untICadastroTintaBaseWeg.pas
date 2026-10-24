unit untICadastroTintaBaseWeg;

interface

uses
  untICadastroTintaBase;

Type
  ICadastroTintaBaseWeg = Interface(ICadastroTintaBase)
    function fGetCampoProdKey(): String;
    function fGetLabelProdKey(): String;
    function fGetCampoSubKey(): String;
    function fGetLabelSubKey(): String;
  End;

implementation

end.
