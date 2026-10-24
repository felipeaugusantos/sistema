{*******************************************************}
{* CLASSE CRIADA PARA NOVA FUNÇÃO DE CONSULTA DE ITENS *}
{****************************************************JU*}
unit untPanelCxPedidoCompra;

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
  untPnlDadosPedidoCompra,
  untPnlDadosPedCompra,
  BitBtnLockedIncrem;

Type

  TPanelCxPedidoCompra = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosPedidoCompraClass;
  public
    frmPnlCon: TfrmPnlDadosPedidoCompra;
    constructor Create(TfrmPnlCon: TfrmPnlDadosPedidoCompraClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta: TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
  End;

Type

  TPanelCxPedCompra = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosPedCompraClass;
  public
    frmPnlCon: TfrmPnlDadosPedCompra;
    constructor Create(TfrmPnlCon: TfrmPnlDadosPedCompraClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta: TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
  End;

implementation

constructor TPanelCxPedidoCompra.Create(TfrmPnlCon: TfrmPnlDadosPedidoCompraClass);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
end;

procedure TPanelCxPedidoCompra.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta: TUniClientDataSet);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.cdsConsulta := cdsConsulta;
  frmPnlCon.dtsPedidos.DataSet := cdsConsulta;
  frmPanel  := frmPnlCon;
  With frmPnlCon Do
  Begin
    DropControl.Height := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;
end;

procedure TPanelCxPedidoCompra.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  frmPnlCon.FormKeyDown(Self, Key, Shift);
end;

{ TPanelCxPedCompra }

constructor TPanelCxPedCompra.Create(TfrmPnlCon: TfrmPnlDadosPedCompraClass);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
end;

procedure TPanelCxPedCompra.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta: TUniClientDataSet);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.cdsConsulta := cdsConsulta;

  If Not Assigned(cdsConsulta.FindField(frmPnlCon.dbeObservacoes.DataField)) Then
    frmPnlCon.dbeObservacoes.DataField := '';

  frmPnlCon.dtsPedidos.DataSet := cdsConsulta;
  frmPanel  := frmPnlCon;
  frmPnlCon.objPanel := Self;
  With frmPnlCon Do
  Begin
    DropControl.Height := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;
end;

procedure TPanelCxPedCompra.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  frmPnlCon.FormKeyDown(Self, Key, Shift);
end;

end.
