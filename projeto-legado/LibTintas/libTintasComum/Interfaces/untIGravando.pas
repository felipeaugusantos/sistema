{*************************************************************************************}
{* Interface que representa a implementação de uma tela com progresso e log de texto *}
{**********************************************************************************PH*}
unit untIGravando;

interface

uses
  untStatusGravando;

type
  IGravando = interface
    function GetTexto: String;
    procedure SetTexto(strTexto: string);
    function GetStatus: TStatusGravando;

    procedure RegistrarProgresso(intInicio, intAtual, intFinal: Integer);
    procedure AnimarEsperar;
    procedure Cancelar;

    property Texto: string read GetTexto write SetTexto;
    property Status: TStatusGravando read GetStatus;
  end;

implementation

end.
