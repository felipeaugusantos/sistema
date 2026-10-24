unit untICadastroTintaBaseAutomotivaStandox;

interface

uses
  untICadastroTintaBaseAutomotiva;

Type
  TStringArrayDox = Array Of String;
  ICadastroTintaBaseAutomotivaStandox = Interface(ICadastroTintaBaseAutomotiva)
    function fGetCampoPesoGrama(): String;
    function fGetLabelPesoGrama(): String;
    function fGetCampoTipo(): String;
    function fGetLabelTipo(): String;
    function fGetCampoLinha(): String;
    function fGetLabelLinha(): String;
    function fGetCampoEmpresa(): String;
    function fGetLabelEmpresa(): String;
  End;

implementation

end.
