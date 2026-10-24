{*******************************************************************************************}
{* TLabelLibTintaControleFactory: Classe especialista em construir um objeto do tipo TEdit *}
{***************************************************************************************PH**}
unit untEditLibTintaControleFactory;

interface

uses
  untAbstractLibTintaControleFactory, ExtCtrls, Controls, untLibTintaControleFactory,
  Windows, Classes, StdCtrls, untILibTintaControleVisual;

type
  TEditLibTintaControleFactory = class(TAbstractLibTintaControleFactory)
  protected
    function GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
      const parent: TControl): TControl; override;
  end;


implementation

{ TEditLibTintaControleFactory }

function TEditLibTintaControleFactory.GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
  const parent: TControl): TControl;
begin
  Result := TEdit.Create(parent);
end;

initialization
  TLibTintaControleFactory.Registrar('TEdit', TEditLibTintaControleFactory.Create);

end.
