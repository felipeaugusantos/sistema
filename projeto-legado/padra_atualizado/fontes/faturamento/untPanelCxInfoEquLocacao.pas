unit untPanelCxInfoEquLocacao;

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
  untPnlDadosEquLocacao,
  BitBtnLockedIncrem;

Type

  TPanelCxInfoEquLocacao = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosEquLocacaoClass;
  public
    strNomForm: string;
    frmPnlCon: TfrmPnlDadosEquLocacao;
    constructor Create(TfrmPnlCon: TfrmPnlDadosEquLocacaoClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta: TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
  End;

implementation

{ TPanelCxInfoEquLocacao }

constructor TPanelCxInfoEquLocacao.Create(TfrmPnlCon: TfrmPnlDadosEquLocacaoClass);
begin
  inherited Create;
  FTfrmCo := TfrmPnlCon;
end;

procedure TPanelCxInfoEquLocacao.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta: TUniClientDataSet);
begin
  frmPnlCon := FTfrmCo.Create(Application);
  frmPnlCon.cdsConsulta := cdsConsulta;
  frmPanel  := frmPnlCon;

  prcIniciouNavegacaoGridConsulta := frmPnlCon.pIniciouNavegacaoGridConsulta;
  prcParouNavegacaoGridConsulta   := frmPnlCon.pParouNavegacaoGridConsulta;

  DropControl.Height  := frmPnlCon.ClientHeight;
  frmPnlCon.ManualDock(TPageControl(DropControl), Nil, alClient);
  frmPnlCon.Show;
end;

procedure TPanelCxInfoEquLocacao.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;

end;

end.
