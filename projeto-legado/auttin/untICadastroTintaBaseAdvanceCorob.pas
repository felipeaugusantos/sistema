unit untICadastroTintaBaseAdvanceCorob;

interface

uses
  untICadastroTintaBase;

Type
  ICadastroTintaBaseAdvanceCorob = Interface(ICadastroTintaBase)
    function fGetCampoProdKey(): String;
    function fGetLabelProdKey(): String;
    function fGetCampoSubKey(): String;
    function fGetLabelSubKey(): String;
  End;

implementation

end.
