unit untICadastroTintaBaseLukscolor;

interface

uses
  untICadastroTintaBase;

Type
  ICadastroTintaBaseLukscolor = Interface(ICadastroTintaBase)
    function fGetCampoProdKey(): String;
    function fGetLabelProdKey(): String;
    function fGetCampoSubKey(): String;
    function fGetLabelSubKey(): String;
  End;

implementation

end.
