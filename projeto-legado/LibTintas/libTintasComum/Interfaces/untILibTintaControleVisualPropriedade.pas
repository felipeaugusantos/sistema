{********************************************************************************************}
{* Interface que representa uma propriedade de um componente ILibTintaControleVisual,       *}
{* assim é possivel alterar uma propriedade sem ter conhecimento da implementação do objeto *}
{*****************************************************************************************PH*}
unit untILibTintaControleVisualPropriedade;

interface

type
  ILibTintaControleVisualPropriedade = interface
    ['{5DE8B2C0-300D-4574-B1DC-0A383EBC9555}']
    function GetNome: string;

    function GetValue: Variant;
    procedure SetValue(const value: Variant);

    property Nome: string read GetNome;
    property Value: Variant read GetValue write SetValue;
  end;

implementation

end.
