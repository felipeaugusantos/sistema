unit untICadastroTintaColorantesAdvance;

interface

uses
  untICadastroTintaColorantes;

type
  ICadastroTintaColorantesAdvance = interface(ICadastroTintaColorantes)
    function fGetCampoEmbalagem(): String;
    function fGetLabelEmbalagem(): String;
  end;

implementation

end.
