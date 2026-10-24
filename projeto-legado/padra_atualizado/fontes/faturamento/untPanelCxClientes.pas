unit untPanelCxClientes;

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
  untPnlDadosCliente,
  BitBtnLockedIncrem;

Type

  TPanelCxClientes = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosClienteClass;
  public
    strNomForm: string;
    frmPnlCon: TfrmPnlDadosCliente;
    blnChamadorF11F3 : Boolean;
    blnApenasLegenda : Boolean;
    constructor Create(TfrmPnlCon: TfrmPnlDadosClienteClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta : TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
  End;

implementation

{ TPanelCxClientes }

constructor TPanelCxClientes.Create(TfrmPnlCon: TfrmPnlDadosClienteClass);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
  blnChamadorF11F3 := False;
end;

procedure TPanelCxClientes.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta : TUniClientDataSet);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.cdsConsulta := cdsConsulta;
  frmPanel  := frmPnlCon;
  frmPnlCon.blnFaturamento   := blnChamadorF11F3;
  frmPnlCon.blnApenasLegenda := blnApenasLegenda;

  if (strNomForm = 'frmFatVendas') then
    frmPnlCon.blnFaturamento := True;

  frmPnlCon.blnFatManConsertoEquip := strNomForm = 'frmFatManConsertoEquip';
  if strNomForm = 'frmFatVendas' then
    frmPnlCon.clientHeight := 235;

  If blnApenasLegenda Then
    frmPnlCon.clientHeight := 40;

  With frmPnlCon Do
  Begin
    DropControl.Height  := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;
end;

procedure TPanelCxClientes.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  frmPnlCon.FormKeyDown(Self, Key, Shift);
end;

end.
