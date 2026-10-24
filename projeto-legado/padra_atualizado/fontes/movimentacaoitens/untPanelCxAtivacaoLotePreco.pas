{*******************************************************}
{* CLASSE CRIADA PARA NOVA FUNÇÃO DE CONSULTA DE ITENS *}
{****************************************************JU*}
unit untPanelCxAtivacaoLotePreco;

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
  untPnlDadosAtivacaoLotePreco,
  BitBtnLockedIncrem;

Type

  TPanelCxAtivacaoLotePreco = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosAtivacaoLotePrecoClass;
  public
    frmPnlCon: TfrmPnlDadosAtivacaoLotePreco;
    constructor Create(TfrmPnlCon: TfrmPnlDadosAtivacaoLotePrecoClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta : TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;

  End;

implementation


constructor TPanelCxAtivacaoLotePreco.Create(TfrmPnlCon: TfrmPnlDadosAtivacaoLotePrecoClass);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
end;

procedure TPanelCxAtivacaoLotePreco.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta : TUniClientDataSet);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPanel  := frmPnlCon;
  DropControl.Height  := frmPnlCon.ClientHeight;
  frmPnlCon.ManualDock(TPageControl(DropControl), Nil, alClient);
  frmPnlCon.Show;
end;

procedure TPanelCxAtivacaoLotePreco.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
{}
end;

end.
