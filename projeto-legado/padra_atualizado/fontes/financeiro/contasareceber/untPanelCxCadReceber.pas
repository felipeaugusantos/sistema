unit untPanelCxCadReceber;

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
  untPnlPesqCadRec,
  BitBtnLockedIncrem;

Type

  TPanelCxCadReceber = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlPesqCadRecClass;
  public
    frmPnlCon: TfrmPnlPesqCadRec;
    constructor Create(TfrmPnlCon: TfrmPnlPesqCadRecClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta : TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
  End;

implementation

{ TPanelCxCadReceber }

constructor TPanelCxCadReceber.Create(TfrmPnlCon: TfrmPnlPesqCadRecClass);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
end;

procedure TPanelCxCadReceber.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta : TUniClientDataSet);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.cdsConsulta := cdsConsulta;
  frmPanel  := frmPnlCon;
  With frmPnlCon Do
  Begin
    DropControl.Height := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;
end;

procedure TPanelCxCadReceber.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  frmPnlCon.FormKeyDown(Self, Key, Shift);
end;

end.
