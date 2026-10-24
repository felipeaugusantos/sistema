unit untPanelCxPreNota;


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
  untPnlDadosPreNota,
  BitBtnLockedIncrem;

Type

  TPanelCxPreNota = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosPreNotaClass;
  public
    frmPnlCon: TfrmPnlDadosPreNota;
    constructor Create(TfrmPnlCon: TfrmPnlDadosPreNotaClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta : TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
  End;


implementation

constructor TPanelCxPreNota.Create(TfrmPnlCon: TfrmPnlDadosPreNotaClass);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
end;

procedure TPanelCxPreNota.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta : TUniClientDataSet);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.cdsConsulta := cdsConsulta;
  frmPanel  := frmPnlCon;
  DropControl.Height := frmPanel.ClientHeight;
  frmPanel.ManualDock(TPageControl(DropControl), Nil, alClient);
  frmPnlCon.Show;
end;

procedure TPanelCxPreNota.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
//  frmPnlCon.FormKeyDown(Self, Key, Shift);
end;



end.
