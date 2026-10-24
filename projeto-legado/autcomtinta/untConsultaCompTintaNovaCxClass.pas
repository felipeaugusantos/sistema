unit untConsultaCompTintaNovaCxClass;

interface

Uses
  ExtCtrls,
  untClassPanelCx,
  untConsultaCompTintaNovaCx,
  Forms,
  Controls,
  ComCtrls;

Type

  TConsultaCompTintaNovaCx = Class(TPanelCx)
  private

  public
    TfrmConsulta: TfrmConsultaCompTintaNovaCxClass;

    Procedure pCriaForm(NewDockSite: TWinControl; DropControl: TControl); override;
  End;

implementation

Procedure TConsultaCompTintaNovaCx.pCriaForm(NewDockSite: TWinControl; DropControl: TControl);
Begin

  frmPanel := TfrmConsultaCompTintaNovaCx.Create(Application);

  With frmPanel Do
  Begin
    DropControl.Height  := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;

End;

end.
