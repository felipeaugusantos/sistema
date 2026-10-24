unit untCadastroTintaColorantesEmbalagem;

interface

uses
   untCadastroTinta, untICadastroTintaColorantes, SysUtils,
   untICadastroTintaColorantesEmbalagem,
   untCadastroTintaColorantes;

Type
  TCadastroTintaColorantesEmbalagem = class(TCadastroTintaColorantes, ICadastroTintaColorantesEmbalagem)
  public
    function fGetCampoEmbalagem(): String; virtual; abstract;
    function fGetLabelEmbalagem(): String; virtual; abstract;
  End;

implementation

end.
