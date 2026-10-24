{**********************************************************************************************}
{* TDBMemoFocusLibTintaControleFactory: classe especializada em construir um controle visual  *}
{* do tipo TDBMemoFocus                                                                       *}
{******************************************************************************************PH**}
unit untDBMemoFocusLibTintaControleFactory;

interface

uses
  untAbstractLibTintaControleFactory, ExtCtrls, Controls, untLibTintaControleFactory,
  Windows, Classes, StdCtrls, untILibTintaControleVisual, DBMemoFocus;

type
  TDBMemoFocusLibTintaControleFactory = class(TAbstractLibTintaControleFactory)
  protected
    function GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
      const parent: TControl): TControl; override;
  end;

implementation

type
  TDBMemoFocus = class(DBMemoFocus.TDBMemoFocus)
  published
    property Text;
  end;


{ TDBMemoFocusLibTintaControleFactory }

function TDBMemoFocusLibTintaControleFactory.GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
  const parent: TControl): TControl;
begin
  Result := TDBMemoFocus.Create(parent);
end;

initialization
  TLibTintaControleFactory.Registrar('TDBMemoFocus', TDBMemoFocusLibTintaControleFactory.Create);

end.
