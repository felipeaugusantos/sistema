{********************************************************************************************}
{* TLabelLibTintaControleFactory: Classe especialista em construir um objeto do tipo TLabel *}
{****************************************************************************************PH**}
unit untLabelLibTintaControleFactory;

interface

uses
  untAbstractLibTintaControleFactory, ExtCtrls, Controls, untLibTintaControleFactory,
  Windows, Classes, StdCtrls, untILibTintaControleVisual;

type
  TLabelLibTintaControleFactory = class(TAbstractLibTintaControleFactory)
  protected
    function GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
      const parent: TControl): TControl; override;
  end;


implementation

{ TLabelLibTintaControleFactory }

function TLabelLibTintaControleFactory.GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
  const parent: TControl): TControl;
begin
  Result := TLabel.Create(parent);
end;

initialization
  TLibTintaControleFactory.Registrar('TLabel', TLabelLibTintaControleFactory.Create);

end.
