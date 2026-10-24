unit untPanelCxAcessorio;

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
  untPnlDadosAcessorio,
  BitBtnLockedIncrem;

Type
  TPanelCxAcessorio = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosAcessorioClass;
  public
    frmPnlCon : TfrmPnlDadosAcessorio;
    strNomForm: String;
    constructor Create(TfrmPnlCon: TfrmPnlDadosAcessorioClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet;
                        btnConfirma: TBitBtnLocked;
                        cdsSubConsulta: TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
  End;

implementation

{ TPanelCxAcessorio }

constructor TPanelCxAcessorio.Create(TfrmPnlCon: TfrmPnlDadosAcessorioClass);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
end;

procedure TPanelCxAcessorio.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet;
  btnConfirma: TBitBtnLocked;
  cdsSubConsulta: TUniClientDataSet);
begin
  inherited;
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.strNomForm := strNomForm;

  frmPanel  := frmPnlCon;
  pgcDropControl := DropControl;
  DropControl.Height := frmPnlCon.ClientHeight - frmPnlCon.ClientHeight;
  frmPnlCon.ManualDock(TPageControl(DropControl), Nil, alClient);
  frmPnlCon.Show;
end;

procedure TPanelCxAcessorio.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
end;

end.
