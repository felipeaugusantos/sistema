{**********************************************************************************************}
{* TDBEditFocusLibTintaControleFactory: classe especializada em construir um controle visual  *}
{* do tipo TDBEditFocus                                                                       *}
{******************************************************************************************PH**}
unit untDBEditFocusLibTintaControleFactory;

interface

uses
  untAbstractLibTintaControleFactory, ExtCtrls, Controls, untLibTintaControleFactory,
  Windows, Classes, StdCtrls, untILibTintaControleVisual, DBEditFocus;

type
  TDBEditFocusLibTintaControleFactory = class(TAbstractLibTintaControleFactory)
  protected
    function GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
      const parent: TControl): TControl; override;
  end;

implementation

type
  TDBEditFocus = class(DBEditFocus.TDBEditFocus)
  published
    property Text;
  end;


{ TDBEditFocusLibTintaControleFactory }

function TDBEditFocusLibTintaControleFactory.GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
  const parent: TControl): TControl;
begin
  Result := TDBEditFocus.Create(parent);
end;

initialization
  TLibTintaControleFactory.Registrar('TDBEditFocus', TDBEditFocusLibTintaControleFactory.Create);

end.
