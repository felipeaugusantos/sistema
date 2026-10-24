unit untPanelCxDefeito;

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
  untPnlDadosDefeito,
  BitBtnLockedIncrem;

Type
  TPanelCxDefeito = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosDefeitoClass;
  public
    frmPnlCon : TfrmPnlDadosDefeito;
    strNomForm: String;
    constructor Create(TfrmPnlCon: TfrmPnlDadosDefeitoClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet;
                        btnConfirma: TBitBtnLocked;
                        cdsSubConsulta: TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
  End;

implementation

{ TPanelCxPedOrc }

constructor TPanelCxDefeito.Create(TfrmPnlCon: TfrmPnlDadosDefeitoClass);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
end;

procedure TPanelCxDefeito.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet;
  btnConfirma: TBitBtnLocked;
  cdsSubConsulta: TUniClientDataSet);
begin
  inherited;
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.strNomForm := strNomForm;

  frmPanel  := frmPnlCon;
  pgcDropControl := DropControl;
  With frmPnlCon Do
  Begin
    DropControl.Height := ClientHeight - ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;
end;

procedure TPanelCxDefeito.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
end;

end.
