{************************************************************************}
{* Interface que representa uma fábrica de componentes onde converte um *}
{* ILibTintaControleVisual em um TControl                               *}
{*********************************************************************PH*}
unit untILibTintaControleFactory;

interface

uses
  untILibTintaControleVisual, Controls;

type
  ILibTintaControleFactory = interface
    ['{2D96A707-C21D-4ADB-A959-BA278A4D13B5}']
    function GetControle(const libTintaControleVisual: ILibTintaControleVisual; const parent: TControl;
      const telaCadLibTintas: ITelaCadLibTintas): TControl;
  end;

implementation

end.
