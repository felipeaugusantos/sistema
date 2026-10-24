unit untPanelCxFormula;

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
  untPnlDadosFormula,
  BitBtnLockedIncrem;

Type

  TPanelCxFormula = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosFormulaClass;
  public
    frmPnlCon: TfrmPnlDadosFormula;
    strNomForm: String;
    blnHabilitaCadastro : Boolean;
    constructor Create(TfrmPnlCon: TfrmPnlDadosFormulaClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta: TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;

  End;


implementation

{ TPanelCxItem }

constructor TPanelCxFormula.Create(TfrmPnlCon: TfrmPnlDadosFormulaClass);
begin
  inherited Create;
  FTfrmCo   := TfrmPnlCon;
  blnTemPan := True;
  blnHabilitaCadastro := False;
end;

procedure TPanelCxFormula.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta: TUniClientDataSet);
begin
  inherited;
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.cdsConsulta := cdsConsulta;
  frmPnlCon.pnlCadFormula.Visible := blnHabilitaCadastro;
  frmPnlCon.FConfirma := BtnConfirma;
  frmPanel  := frmPnlCon;

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

procedure TPanelCxFormula.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  frmPnlCon.FormKeyDown(Self, Key, Shift);
end;

end.
