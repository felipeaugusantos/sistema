unit untICadastroTintaBaseAutomotivaDupont;

interface

uses
  untICadastroTintaBaseAutomotiva;

Type
  TStringArrayDup = Array Of String;
  ICadastroTintaBaseAutomotivaDupont = Interface(ICadastroTintaBaseAutomotiva)
    function fGetCampoPesoGrama(): String;
    function fGetLabelPesoGrama(): String;
//    function fGetCampoQualidade(): String;
//    function fGetLabelQualidade(): String;
    function fGetCampoTipo(): String;
    function fGetLabelTipo(): String;
    function fGetCampoLinha(): String;
    function fGetLabelLinha(): String;
    function fGetArrayTipos(): TStringArrayDup;
//    function fGetArrayQualidades(): TStringArray;
    function fGetArrayLinhas(): TStringArrayDup;
    function fGetCampoEmpresa(): String;
    function fGetLabelEmpresa(): String;    
  End;

implementation

end.
