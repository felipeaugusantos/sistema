unit untPanelCxNFCompra;

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
  untPnlDadosNFCompra,
  BitBtnLockedIncrem,
  Winapi.Windows;

Type

  TPanelCxNFCompra = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosNFCompraClass;
  public
    frmPnlCon: TfrmPnlDadosNFCompra;

    constructor Create(TfrmPnlCon: TfrmPnlDadosNFCompraClass); reintroduce;

    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet;
                        btnConfirma: TBitBtnLocked;
                        cdsSubConsulta: TUniClientDataSet); override;

    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;

  End;

implementation

{ TPanelCxNFCompra }

constructor TPanelCxNFCompra.Create(TfrmPnlCon: TfrmPnlDadosNFCompraClass);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
end;

procedure TPanelCxNFCompra.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta: TUniClientDataSet);
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

procedure TPanelCxNFCompra.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  frmPnlCon.FormKeyDown(Self, Key, Shift);
end;

end.
