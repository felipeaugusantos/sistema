{*********************************************************************************************}
{* TSpeedButtonLibTintaControleFactory: Classe especialista em construir um controle visual  *}
{* do tipo TSpeedButton                                                                      *}
{*****************************************************************************************PH**}
unit untSpeedButtonLibTintaControleFactory;

interface

uses
  untAbstractLibTintaControleFactory, ExtCtrls, Controls, untLibTintaControleFactory,
  Windows, Classes, Buttons, untILibTintaControleVisual;

type
  TSpeedButtonLibTintaControleFactory = class(TAbstractLibTintaControleFactory)
  protected
    function GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
      const parent: TControl): TControl; override;
  end;


implementation

{ TLabelLibTintaControleFactory }

function TSpeedButtonLibTintaControleFactory.GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
  const parent: TControl): TControl;
begin
  Result := TSpeedButton.Create(parent);
end;

initialization
  TLibTintaControleFactory.Registrar('TSpeedButton', TSpeedButtonLibTintaControleFactory.Create);

end.
