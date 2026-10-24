unit untICadastroTintaColorantesEmbalagem;

interface

uses
  untICadastroTintaColorantes;

Type
  ICadastroTintaColorantesEmbalagem = Interface(ICadastroTintaColorantes)
    function fGetCampoEmbalagem(): String;
    function fGetLabelEmbalagem(): String;
  End;

implementation

end.
