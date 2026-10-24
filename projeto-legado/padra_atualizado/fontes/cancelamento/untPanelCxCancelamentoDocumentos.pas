unit untPanelCxCancelamentoDocumentos;

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
  untPnlDadosCancelamentoDocumentos,
  BitBtnLockedIncrem;

Type

  TPanelCxCancelamentoDocumentos = Class(TPanelCx)

  private
    FTfrmCo: TfrmPnlDadosCancelamentoDocumentosClass;
  public
    frmPnlCon: TfrmPnlDadosCancelamentoDocumentos;
    constructor Create(TfrmPnlCon: TfrmPnlDadosCancelamentoDocumentosClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta: TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
  End;

implementation

{ PanelCxCancelamentoDocumentos }

constructor TPanelCxCancelamentoDocumentos.Create(
  TfrmPnlCon: TfrmPnlDadosCancelamentoDocumentosClass);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
end;

procedure TPanelCxCancelamentoDocumentos.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet;
  btnConfirma: TBitBtnLocked; cdsSubConsulta: TUniClientDataSet);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.cdsConsulta := cdsConsulta;
  frmPanel  := frmPnlCon;
  frmPnlCon.objPanel := Self;
  With frmPnlCon Do
  Begin
    DropControl.Height  := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;
end;

procedure TPanelCxCancelamentoDocumentos.pKeyDown(var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  frmPnlCon.FormKeyDown(Self, Key, Shift);
end;

end.
