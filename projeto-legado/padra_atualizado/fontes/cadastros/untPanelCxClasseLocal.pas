unit untPanelCxClasseLocal;

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
  untPnlDadosClasseLocal,
  BitBtnLockedIncrem;

Type

  TPanelCxClasseLocal = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosClasseLocalClass;
  public
    frmPnlCon: TfrmPnlDadosClasseLocal;
    strCodIte : String;
    constructor Create(TfrmPnlCon: TfrmPnlDadosClasseLocalClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta: TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;

  End;


implementation

{ TPanelCxItem }

constructor TPanelCxClasseLocal.Create(TfrmPnlCon: TfrmPnlDadosClasseLocalClass);
begin
  inherited Create;
  FTfrmCo   := TfrmPnlCon;
  blnTemPan := True;
  strCodIte := '';
end;

procedure TPanelCxClasseLocal.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta: TUniClientDataSet);
begin
  inherited;
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.strCodIte := strCodIte;
  frmPanel  := frmPnlCon;

  With frmPnlCon Do
  Begin
    DropControl.Height  := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;
end;

procedure TPanelCxClasseLocal.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
 // frmPnlCon.FormKeyDown(Self, Key, Shift);
end;

end.
