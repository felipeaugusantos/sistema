unit untPanelCxTintaNova;

interface

Uses
  ExtCtrls,
  Forms,
  Controls,
  ComCtrls,
  UniClientDataSet,
  SysUtils,
  Classes,
  untClassPanelCx,
  untConsultaCompTintaNovaCx,
  untTypesSistema,
  BitBtnLockedIncrem, untPnlBotoesAcoesNovaConsulta;


  Type

  TPanelCxTintaNova = Class(TPanelCx)
  private
    FtpoCon: TTipoConsultaTinta;
    FTabPre: String;
    FTfrmCo: TfrmConsultaCompTintaNovaCxClass;

  public

    frmConsulta: TfrmConsultaCompTintaNovaCx;

    constructor Create(TfrmConsulta: TfrmConsultaCompTintaNovaCxClass;
                       tipoConsulta: TTipoConsultaTinta;
                       strTabPre: String); reintroduce;

    Procedure pCriaForm(NewDockSite: TWinControl; DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta : TUniClientDataSet); override;

    Procedure pKeyDown(var Key: Word; Shift: TShiftState); override;

  End;

implementation

constructor TPanelCxTintaNova.Create(TfrmConsulta: TfrmConsultaCompTintaNovaCxClass;
                   tipoConsulta: TTipoConsultaTinta; strTabPre: String);
Begin
  Inherited Create;
  FtpoCon := tipoConsulta;
  FTabPre := strTabPre;
  FTfrmCo := TfrmConsulta;
End;

Procedure TPanelCxTintaNova.pCriaForm(NewDockSite: TWinControl;
    DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
    cdsSubConsulta : TUniClientDataSet);
Begin

  frmConsulta := FTfrmCo.Create(Application, FtpoCon, FTabPre);
  frmConsulta.cdsConsulta := cdsConsulta;

  frmPanel := frmConsulta;

  With frmConsulta Do
  Begin
    DropControl.Height  := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;

End;

Procedure TPanelCxTintaNova.pKeyDown(var Key: Word; Shift: TShiftState);
Begin
  frmConsulta.FormKeyDown(Self, Key, Shift);
End;

end.
