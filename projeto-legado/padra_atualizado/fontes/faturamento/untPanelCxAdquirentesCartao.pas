unit untPanelCxAdquirentesCartao;

interface

uses
  ExtCtrls,
  Forms,
  Controls,
  ComCtrls,
  UniClientDataSet,
  SysUtils,
  Classes,
  untPnlDadosAdquirentesCartao,
  untClassPanelCx,
  BitBtnLockedIncrem ;

Type
  TPanelCxAdquirentesCartao = Class(TPanelCx)
  private
    FfrmAdquirentesCartaoClass: TfrmPnlDadosAdquirentesCartaoClass;
  public
    FfrmAdquirentesCartao: TfrmPnlDadosAdquirentesCartao;
    constructor Create(TfrmPnlCon: TfrmPnlDadosAdquirentesCartaoClass); reintroduce;
    procedure pCriaForm(NewDockSite: TWinControl; DropControl: TControl;
      cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked; cdsSubConsulta: TUniClientDataSet); override;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
  End;

implementation

{ TPanelCxAdquirentesCartao }

constructor TPanelCxAdquirentesCartao.Create(TfrmPnlCon: TfrmPnlDadosAdquirentesCartaoClass);
begin
  inherited Create;
  FfrmAdquirentesCartaoClass := TfrmPnlCon;
end;

procedure TPanelCxAdquirentesCartao.pCriaForm(NewDockSite: TWinControl;
  DropControl: TControl; cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta: TUniClientDataSet);
begin
  FfrmAdquirentesCartao := FfrmAdquirentesCartaoClass.Create(Application);
  frmPanel  := FfrmAdquirentesCartao;
  DropControl.Height  := FfrmAdquirentesCartao.ClientHeight;
  FfrmAdquirentesCartao.ManualDock(TPageControl(DropControl), Nil, alClient);
  FfrmAdquirentesCartao.Show;
end;

procedure TPanelCxAdquirentesCartao.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  FfrmAdquirentesCartao.FormKeyDown(Self, Key, Shift);
end;

end.
