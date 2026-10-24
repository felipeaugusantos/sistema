{***********************************************************}
{* CLASSE CRIADA PARA NOVA FUNÇÃO DE CONSULTA DE ITENS DEV *}
{********************************************************IV*}
unit untPanelCxItemDev;

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
  untPnlDadosItemDev,
  BitBtnLockedIncrem;

Type

  TPanelCxItemDev = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosItemDevClass;
  public
    frmPnlCon: TfrmPnlDadosItemDev;
    strNomForm: String;
    constructor Create(TfrmPnlCon: TfrmPnlDadosItemDevClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta : TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
  End;

implementation
constructor TPanelCxItemDev.Create(TfrmPnlCon: TfrmPnlDadosItemDevClass);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
end;

procedure TPanelCxItemDev.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta : TUniClientDataSet);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.cdsConsulta := cdsConsulta;
  frmPanel  := frmPnlCon;
  frmPnlCon.strNomForm  := strNomForm;

  prcAtualizar := nil;
  prcIniciouNavegacaoGridConsulta := frmPnlCon.pIniciouNavegacaoGridConsulta;
  prcParouNavegacaoGridConsulta := frmPnlCon.pParouNavegacaoGridConsulta;

  With frmPnlCon Do
  Begin
    DropControl.Height  := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;
end;

procedure TPanelCxItemDev.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  frmPnlCon.FormKeyDown(Self, Key, Shift);
end;

end.
