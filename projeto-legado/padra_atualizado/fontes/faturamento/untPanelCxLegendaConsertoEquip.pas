{*******************************************************}
{* CLASSE CRIADA PARA NOVA FUNÇÃO DE CONSULTA DE ITENS *}
{****************************************************JU*}
unit untPanelCxLegendaConsertoEquip;

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
  untPnlLegendaConsertoEquip,
  BitBtnLockedIncrem;

Type

  TPanelCxConsertoEquip = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlLegendaConsertoEquipClass;
  public
    frmPnlCon: TfrmPnlLegendaConsertoEquip;
    blnNegociacao: Boolean;
    strCodCli: String;
    constructor Create(TfrmPnlCon: TfrmPnlLegendaConsertoEquipClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta : TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;

  End;

implementation


constructor TPanelCxConsertoEquip.Create(TfrmPnlCon: TfrmPnlLegendaConsertoEquipClass);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
  blnNegociacao := False;
  strCodCli := '';
end;

procedure TPanelCxConsertoEquip.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta : TUniClientDataSet);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.cdsConsulta := cdsConsulta;
  frmPanel  := frmPnlCon;
  frmPnlCon.objPanel := Self;
  frmPnlCon.objPanel.FOnBeforeListaSelecaoAdd   := frmPnlCon.OnBeforeListaSelecaoAdd;
  frmPnlCon.objPanel.FOnAfterListaSelecaoRemove := frmPnlCon.OnAfterListaSelecaoRemove;
  frmPnlCon.blnNegociacao := blnNegociacao;
  frmPnlCon.strCodCli := strCodCli;

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

procedure TPanelCxConsertoEquip.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  frmPnlCon.FormKeyDown(Self, Key, Shift);
end;

end.
