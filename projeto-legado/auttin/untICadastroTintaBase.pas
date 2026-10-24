unit untICadastroTintaBase;

interface

uses
  untICadastroTinta;

Type
  ICadastroTintaBase = Interface(ICadastroTinta)
    function fGetCampoCodigo(): String;
    function fGetLabelCodigo(): String;
    function fGetCampoBase(): String;
    function fGetLabelBase(): String;
    function fGetCampoDescricao(): String;
    function fGetLabelDescricao(): String;
    function fGetCampoCodItem(): String;
    function fGetLabelCodItem(): String;
    function fGetCampoUnidade(): String;
    function fGetCampoEmbala(): String;
    function fGetLabelUndiade(): String;
    function fGetCampoCusto(): String;
    function fGetLabelCusto(): String;
    function fGetCampoVenda(): String;
    function fGetLabelVenda(): String;
    function fGetCampoMargem(): String;
    function fGetLabelMargem(): String;
    function fGetFiltro(): String;
  End;

implementation

end.
