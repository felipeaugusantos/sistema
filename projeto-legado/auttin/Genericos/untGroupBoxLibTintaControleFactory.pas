unit untGroupBoxLibTintaControleFactory;

interface

uses
  untAbstractLibTintaControleFactory, ExtCtrls, Controls, untLibTintaControleFactory,
  untILibTintaControleVisual, StdCtrls;

type
  TGroupBoxLibTintaControleFactory = class(TAbstractLibTintaControleFactory)
  protected
    function GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
      const parent: TControl): TControl; override;
  end;


implementation

{ TGroupBoxLibTintaControleFactory }

function TGroupBoxLibTintaControleFactory.GetControleClasse(
  const libTintaControleVisual: ILibTintaControleVisual;
  const parent: TControl): TControl;
begin
  Result := TGroupBox.Create(parent);
end;

initialization
  TLibTintaControleFactory.Registrar('TGroupBox', TGroupBoxLibTintaControleFactory.Create);

end.
