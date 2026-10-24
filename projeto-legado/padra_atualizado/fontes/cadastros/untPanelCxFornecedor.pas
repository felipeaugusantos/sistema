{*******************************************************}
{* CLASSE CRIADA PARA NOVA FUNÇÃO DE CONSULTA DE ITENS *}
{****************************************************JU*}
unit untPanelCxFornecedor;

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
  untPnlDadosFornecedor,
  BitBtnLockedIncrem;

Type

  TPanelCxFornecedor = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosFornecedorClass;
  public
    frmPnlCon: TfrmPnlDadosFornecedor;
    constructor Create(TfrmPnlCon: TfrmPnlDadosFornecedorClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta : TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;

  End;

implementation


constructor TPanelCxFornecedor.Create(TfrmPnlCon: TfrmPnlDadosFornecedorClass);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
end;

procedure TPanelCxFornecedor.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta : TUniClientDataSet);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPanel  := frmPnlCon;
  With frmPnlCon Do
  Begin
    DropControl.Height  := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;
end;

procedure TPanelCxFornecedor.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
{}
end;

end.
