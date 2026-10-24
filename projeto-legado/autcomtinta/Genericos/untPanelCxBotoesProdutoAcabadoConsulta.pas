unit untPanelCxBotoesProdutoAcabadoConsulta;

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
  untPnlBotoesProdutoAcabadoConsulta,
  BitBtnLockedIncrem,
  untIConsultaComp,
  untIConsulta,
  untIDicionario;

Type
  TPanelCxBotoesProdutoAcabadoConsulta = Class(TPanelCx)
  private
  public

    frmPnlCon: TfrmPnlBotoesProdutoAcabadoConsulta;

    constructor Create; reintroduce;

    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet;
                        btnConfirma: TBitBtnLocked;
                        cdsSubConsulta : TUniClientDataSet); override;

    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;

End;


implementation

{ TPanelCxBotoesProdutoAcabadoConsulta }

constructor TPanelCxBotoesProdutoAcabadoConsulta.Create;
begin
  inherited Create;
end;

procedure TPanelCxBotoesProdutoAcabadoConsulta.pCriaForm(NewDockSite: TWinControl;
                                                         DropControl: TControl;
                                                         cdsConsulta: TUniClientDataSet;
                                                         btnConfirma: TBitBtnLocked;
                                                         cdsSubConsulta : TUniClientDataSet);
begin

  inherited;

  frmPnlCon := TfrmPnlBotoesProdutoAcabadoConsulta.Create;
  frmPanel  := frmPnlCon;
  frmPnlCon.cdsConsulta := cdsConsulta;
  frmPnlCon.FobjConfConsulta := FobjConfConsulta;

  DropControl.Height  := frmPnlCon.ClientHeight;
  frmPnlCon.ManualDock(TPageControl(DropControl), Nil, alClient);
  frmPnlCon.Show;

end;

procedure TPanelCxBotoesProdutoAcabadoConsulta.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  frmPnlCon.FormKeyDown(Self, Key, Shift);
end;

end.
