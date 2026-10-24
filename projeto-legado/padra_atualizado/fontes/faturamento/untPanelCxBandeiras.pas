unit untPanelCxBandeiras;

interface

uses
  ExtCtrls,
  Forms,
  Controls,
  ComCtrls,
  UniClientDataSet,
  SysUtils,
  Classes,
  untPnlDadosBandeiras,
  untClassPanelCx,
  BitBtnLockedIncrem ;

Type
  TPanelCxBandeiras = Class(TPanelCx)
  private
    FfrmBandeirasClass: TfrmPnlDadosBandeirasClass;
  public
    FfrmBandeiras: TfrmPnlDadosBandeiras;
    constructor Create(TfrmPnlCon: TfrmPnlDadosBandeirasClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl; DropControl: TControl;
      cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked; cdsSubConsulta: TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
  End;

implementation

{ TPanelCxBandeiras }

constructor TPanelCxBandeiras.Create(TfrmPnlCon: TfrmPnlDadosBandeirasClass);
begin
  inherited Create;
  FfrmBandeirasClass := TfrmPnlCon;
end;

procedure TPanelCxBandeiras.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta: TUniClientDataSet);
begin
  FfrmBandeiras := FfrmBandeirasClass.Create(Application);
  //FfrmBandeiras.cdsConsulta := cdsConsulta;
  frmPanel  := FfrmBandeiras;
  DropControl.Height  := FfrmBandeiras.ClientHeight;
  FfrmBandeiras.ManualDock(TPageControl(DropControl), Nil, alClient);
  FfrmBandeiras.Show;
end;

procedure TPanelCxBandeiras.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  FfrmBandeiras.FormKeyDown(Self, Key, Shift);
end;

end.
