unit untPanelCxOPI;

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
  untFuncoesSimples,
  BitBtnLockedIncrem,
  untTypesSistema,
  untPnlDadosOPI;

Type

  TPanelCxOPI = Class(TPanelCx)
  private
    FTfrmCo: TfrmPnlDadosOpiClass;
  protected
  public
    frmPnlOpi: TfrmPnlDadosOPI;
    class function New: TPanelCxOPI; overload;
    constructor Create(AFrmPnl: TfrmPnlDadosOpiClass); reintroduce;
    procedure pKeyDown(var Key: Word; Shift: TShiftState); override;
    procedure pCriaForm(NewDockSite: TWinControl;
                        DropControl: TControl;
                        cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
                        cdsSubConsulta: TUniClientDataSet); override;
  End;

implementation

uses
  untConfiguraConsulta;

constructor TPanelCxOPI.Create(AFrmPnl: TfrmPnlDadosOpiClass);
begin
  inherited Create;
  FTfrmCo := AFrmPnl;
end;

class function TPanelCxOPI.New: TPanelCxOPI;
begin
  Result := Self.Create(TfrmPnlDadosOPI);
end;

procedure TPanelCxOPI.pCriaForm(NewDockSite: TWinControl; DropControl: TControl;
  cdsConsulta: TUniClientDataSet; btnConfirma: TBitBtnLocked;
  cdsSubConsulta: TUniClientDataSet);
begin
  inherited;
  frmPnlOpi := FTfrmCo.Create(Application);
  frmPnlOpi.cdsConsulta        := cdsConsulta;
  frmPanel                     := frmPnlOpi;

  pSetCxControlsScrollbarModeClassic(frmPnlOpi);

  prcParouNavegacaoGridConsulta := frmPnlOpi.pParouNavegacaoGridConsulta;

  pgcDropControl := DropControl;
  With frmPnlOpi Do
  Begin
    DropControl.Height  := ClientHeight;
    ManualDock(TPageControl(DropControl), Nil, alClient);
    Show;
  End;

end;

procedure TPanelCxOPI.pKeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Assigned(frmPnlOpi.OnKeyDown) Then
    frmPnlOpi.OnKeyDown(Self, Key, Shift);
end;

end.
