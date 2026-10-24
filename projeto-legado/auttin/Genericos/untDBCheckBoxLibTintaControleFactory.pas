unit untDBCheckBoxLibTintaControleFactory;

interface

uses
  untAbstractLibTintaControleFactory, ExtCtrls, Controls, untLibTintaControleFactory,
  untILibTintaControleVisual, DBCtrls;

type
  TDBCheckBoxLibTintaControleFactory = class(TAbstractLibTintaControleFactory)
  protected
    function GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
      const parent: TControl): TControl; override;
  end;

  TDBCheckBox = class(DBCtrls.TDBCheckBox)
  published
    property Checked;
  end;

implementation

{ TDBCheckBoxLibTintaControleFactory }

function TDBCheckBoxLibTintaControleFactory.GetControleClasse(
  const libTintaControleVisual: ILibTintaControleVisual;
  const parent: TControl): TControl;
begin
  Result := TDBCheckBox.Create(parent);
end;

initialization
  TLibTintaControleFactory.Registrar('TDBCheckBox', TDBCheckBoxLibTintaControleFactory.Create);

end.
