{*******************************************************}
{* CLASSE CRIADA PARA NOVA FUNÇÃO DE CONSULTA DE ITENS *}
{****************************************************JU*}
unit untPanelCxCadLote;

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
  untPnlDadosCadLote,
  BitBtnLockedIncrem;

Type

  TPanelCxCadLote = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosCadLoteClass;
  public
    frmPnlCon: TfrmPnlDadosCadLote;
    strCodIte: String;
    strEspDoc: String;
    constructor Create(TfrmPnlCon: TfrmPnlDadosCadLoteClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta : TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
  End;


implementation
constructor TPanelCxCadLote.Create(TfrmPnlCon: TfrmPnlDadosCadLoteClass);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
end;

procedure TPanelCxCadLote.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta : TUniClientDataSet);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.cdsConsulta := cdsConsulta;
  frmPnlCon.strCodIte   := strCodIte;
  frmPnlCon.strEspDoc   := strEspDoc;
  frmPanel  := frmPnlCon;

  With frmPnlCon Do
  Begin
    DropControl.Height  := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;
end;

procedure TPanelCxCadLote.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  frmPnlCon.FormKeyDown(Self, Key, Shift);
end;

end.
