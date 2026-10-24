{**************************************************************************************}
{* TLibTintaControleVisualImplementacaoFactory: classe especializada em construir um  *}
{* controle visual de acordo com a string de implementação                            *}
{**********************************************************************************PH**}
unit untLibTintaControleVisualImplementacaoFactory;

interface

uses
  untAbstractLibTintaControleFactory, ExtCtrls, Controls, untLibTintaControleFactory,
  Windows, Classes, StdCtrls, untILibTintaControleVisual, Buttons, EditFocus, DBEditFocus,
  DBGridCitel, DBGrids;

type
  TLibTintaControleVisualImplementacaoFactory = class(TAbstractLibTintaControleFactory)
  private
    class var blnRegistrados: Boolean;
    class procedure RegistrarCompoentes;
  protected
    function GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
      const parent: TControl): TControl; override;
  end;

implementation

uses
  untComponentFactory;

{ TDBEditFocusLibTintaControleFactory }

function TLibTintaControleVisualImplementacaoFactory.GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
  const parent: TControl): TControl;
begin
  if not blnRegistrados then
    RegistrarCompoentes;

  Result := TComponentFactory.StringToComponent(libTintaControleVisual.Implementacao) as TControl;
  if Assigned(parent) then
    parent.InsertComponent(Result);
end;

class procedure TLibTintaControleVisualImplementacaoFactory.RegistrarCompoentes;
begin
  RegisterClasses([TSpeedButton, TEditFocus, TDBEditFocus, TLabel, TDBGridCitel]);
  blnRegistrados := True;
end;

initialization
  TLibTintaControleVisualImplementacaoFactory.blnRegistrados := False;
  TLibTintaControleFactory.Registrar('TLibTintaControleVisualImplementacao', TLibTintaControleVisualImplementacaoFactory.Create);

end.
