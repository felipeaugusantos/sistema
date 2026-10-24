unit untPanelCxDiariaNegociacao;

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
  untPnlDadosEquNegociacaoDiarias,
  BitBtnLockedIncrem;

Type

  TPanelCxDiarias = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosEquNegociacaoDiariasClass;
  public
    strNomForm: string;
    frmPnlCon: TfrmPnlDadosEquNegociacaoDiarias;
    constructor Create(TfrmPnlCon: TfrmPnlDadosEquNegociacaoDiariasClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
  End;

implementation

{ TPanelCxDiarias }

constructor TPanelCxDiarias.Create(TfrmPnlCon: TfrmPnlDadosEquNegociacaoDiariasClass);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
end;

procedure TPanelCxDiarias.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.cdsConsulta := cdsConsulta;
  frmPanel  := frmPnlCon;

  DropControl.Height  := frmPnlCon.ClientHeight;
  frmPnlCon.ManualDock(TPageControl(DropControl), Nil, alClient);
  frmPnlCon.Show;
end;

procedure TPanelCxDiarias.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  
end;

end.
