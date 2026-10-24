unit untICadastroTintaBaseAutomotiva;

interface

uses
  untICadastroTinta;

Type
  ICadastroTintaBaseAutomotiva = Interface(ICadastroTinta)
    function fGetCampoCodigo(): String;
    function fGetLabelCodigo(): String;
    function fGetCampoDescricao(): String;
    function fGetLabelDescricao(): String;
    function fGetCampoEmbalagem(): String;
    function fGetLabelEmbalagem(): String;
    function fGetCampoPesoEspecifico(): String;
    function fGetLabelPesoEspecifico(): String;
    function fGetCampoCodItem(): String;
    function fGetLabelCodItem(): String;
    function fGetCampoCusto(): String;
    function fGetLabelCusto(): String;
    function fGetCampoMargem(): String;
    function fGetLabelMargem(): String;
    function fGetCampoVenda(): String;
    function fGetLabelVenda(): String;
    function fGetSqlUpdateCnvMl(): string;
  End;

implementation

end.
