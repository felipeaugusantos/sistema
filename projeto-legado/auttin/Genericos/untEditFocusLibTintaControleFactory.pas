{**********************************************************************************************}
{* TDBEditFocusLibTintaControleFactory: classe especializada em construir um controle visual  *}
{* do tipo TDBEditFocus                                                                       *}
{******************************************************************************************PH**}
unit untEditFocusLibTintaControleFactory;

interface

uses
  untAbstractLibTintaControleFactory, ExtCtrls, Controls, untLibTintaControleFactory,
  Windows, Classes, StdCtrls, untILibTintaControleVisual, EditFocus;

type
  TEditFocusLibTintaControleFactory = class(TAbstractLibTintaControleFactory)
  protected
    function GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
      const parent: TControl): TControl; override;
  end;

implementation

{ TEditFocusLibTintaControleFactory }

function TEditFocusLibTintaControleFactory.GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
  const parent: TControl): TControl;
begin
  Result := TEditFocus.Create(parent);
end;

initialization
  TLibTintaControleFactory.Registrar('TEditFocus', TEditFocusLibTintaControleFactory.Create);

end.
