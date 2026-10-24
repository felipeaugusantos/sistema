unit untPanelCxPedOrc;

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
  untPnlDadosPedOrc,
  BitBtnLockedIncrem,
  Winapi.Windows;

Type

  TPanelCxPedOrc = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosPedOrcClass;
    FEspDoc: String;
    FCRM : Boolean;
    FPermitirExibirTodosOsPedidos: Boolean;
    FMarcarExibirTodosOsPedidos: Boolean;
  public
    frmPnlCon: TfrmPnlDadosPedOrc;
    constructor Create(TfrmPnlCon: TfrmPnlDadosPedOrcClass; strEspDoc: String; blnCRM: Boolean = False; blnPermitirExibirTodosOsPedidos: Boolean = False; blnMarcarExibirTodosOsPedidos: Boolean = False); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta : TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;

  End;

implementation

{ TPanelCxPedOrc }

constructor TPanelCxPedOrc.Create(TfrmPnlCon: TfrmPnlDadosPedOrcClass; strEspDoc: String; blnCRM: Boolean; blnPermitirExibirTodosOsPedidos: Boolean; blnMarcarExibirTodosOsPedidos: Boolean);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
  FEspDoc := strEspDoc;
  FCRM    := blnCRM;
  FPermitirExibirTodosOsPedidos := blnPermitirExibirTodosOsPedidos;
  FMarcarExibirTodosOsPedidos := blnMarcarExibirTodosOsPedidos;
end;

procedure TPanelCxPedOrc.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta : TUniClientDataSet);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.cdsConsulta := cdsConsulta;
  frmPnlCon.strEspDoc   := FEspDoc;
  frmPnlCon.blnCRM      := FCRM;
  frmPnlCon.blnPermitirExibirTodosOsPedidos := FPermitirExibirTodosOsPedidos;
  frmPnlCon.blnMarcarExibirTodosOsPedidos := FMarcarExibirTodosOsPedidos;
  frmPanel  := frmPnlCon;
  frmPnlCon.objPanel := Self;
  frmPnlCon.objPanel.FOnBeforeListaSelecaoAdd :=  frmPnlCon.OnBeforeListaSelecaoAdd;
  frmPnlCon.objPanel.FOnAfterListaSelecaoRemove :=  frmPnlCon.OnAfterListaSelecaoRemove;

  prcAtualizar := nil;
  prcIniciouNavegacaoGridConsulta := frmPnlCon.pIniciouNavegacaoGridConsulta;
  prcParouNavegacaoGridConsulta := frmPnlCon.pParouNavegacaoGridConsulta;

  With frmPnlCon Do
  Begin
    DropControl.Height  := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;

  prcValidaTemFiltro := frmPnlCon.pValidaTemFiltro;
end;

procedure TPanelCxPedOrc.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  frmPnlCon.FormKeyDown(Self, Key, Shift);
end;

end.
