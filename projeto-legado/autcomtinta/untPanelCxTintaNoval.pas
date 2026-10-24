unit untPanelCxTintaNoval;

interface

Uses
  ExtCtrls,
  untClassPanelCx,
  untConsultaCompTintaNovaCx,
  Forms,
  Controls,
  ComCtrls,
  UniClientDataSet,
  untConsultaCompTinta;

Type

  TPanelCxTintaNova = Class(TPanelCx)
  private
    FtpoCon: TTipoConsulta;
    FTabPre: String;
    FTfrmCo: TfrmConsultaCompTintaNovaCxClass;

  public

    frmConsulta : TfrmConsultaCompTintaNovaCx;

    constructor Create(TfrmConsulta: TfrmConsultaCompTintaNovaCxClass;
                       tipoConsulta: TTipoConsulta;
                       strTabPre: String); reintroduce;

    Procedure pCriaForm(NewDockSite: TWinControl; DropControl: TControl;
                        cdsConsulta: TUniClientDataSet); override;
  End;

implementation

constructor TPanelCxTintaNova.Create(TfrmConsulta: TfrmConsultaCompTintaNovaCxClass;
                   tipoConsulta: TTipoConsulta; strTabPre: String);
Begin
  Inherited Create;
  FtpoCon := tipoConsulta;
  FTabPre := strTabPre;
  FTfrmCo := TfrmConsulta;
End;

Procedure TPanelCxTintaNova.pCriaForm(NewDockSite: TWinControl;
    DropControl: TControl; cdsConsulta: TUniClientDataSet);
Begin

  frmConsulta := FTfrmCo.Create(Application, FtpoCon, FTabPre);
  frmConsulta.cdsConsulta := cdsConsulta;

  With frmConsulta Do
  Begin
    DropControl.Height  := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;

End;

end.
