unit untPanelCxServico;

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
  untPnlDadosServico,
  BitBtnLockedIncrem;

Type
  TPanelCxServico = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosServicoClass;
  public
    frmPnlCon: TfrmPnlDadosServico;
    constructor Create(TfrmPnlCon: TfrmPnlDadosServicoClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet;
                        btnConfirma: TBitBtnLocked;
                        cdsSubConsulta : TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
  End;

implementation

{ TPanelCxPedOrc }

constructor TPanelCxServico.Create(TfrmPnlCon: TfrmPnlDadosServicoClass);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
end;

procedure TPanelCxServico.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet;
  btnConfirma: TBitBtnLocked;
  cdsSubConsulta : TUniClientDataSet);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.cdsConsulta := cdsConsulta;
  frmPanel  := frmPnlCon;
  With frmPnlCon Do
  Begin
    DropControl.Height  := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;
end;

procedure TPanelCxServico.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  frmPnlCon.FormKeyDown(Self, Key, Shift);
end;

end.
