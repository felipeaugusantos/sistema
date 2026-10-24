{********************************************************************************************}
{* TLabelLibTintaControleFactory: Classe especialista em construir um objeto do tipo TPanel *}
{****************************************************************************************PH**}
unit untPanelLibTintaControleFactory;

interface

uses
  untAbstractLibTintaControleFactory, ExtCtrls, Controls, untLibTintaControleFactory,
  untILibTintaControleVisual;

type
  TPanelLibTintaControleFactory = class(TAbstractLibTintaControleFactory)
  protected
    function GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
      const parent: TControl): TControl; override;
  end;


implementation

{ TPanelLibTintaControleFactory }

function TPanelLibTintaControleFactory.GetControleClasse(const libTintaControleVisual: ILibTintaControleVisual;
  const parent: TControl): TControl;
begin
  Result := TPanel.Create(parent);
end;

initialization
  TLibTintaControleFactory.Registrar('TPanel', TPanelLibTintaControleFactory.Create);
  
end.
