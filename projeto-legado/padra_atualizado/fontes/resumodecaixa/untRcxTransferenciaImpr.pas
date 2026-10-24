unit untRcxTransferenciaImpr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, dxScreenTip,
  cxClasses, dxCustomHint, cxHint;

type
  TfrmRcxTransferenciaImpr = class(TfrmPai)
    pnlCentral: TPanel;
    chkImpTf: TCheckBox;
    chkImpChq: TCheckBox;
    chkImpCar: TCheckBox;
    btnConfirma: TBitBtnLocked;
    rdgOrdenacao: TRadioGroup;
    HintControler: TcxHintStyleController;
    procedure chkImpTfClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmRcxTransferenciaImpr.chkImpTfClick(Sender: TObject);
begin
  inherited;
  chkImpChq.Enabled := chkImpTf.Checked;
  chkImpCar.Enabled := chkImpTf.Checked;

  If Not chkImpTf.Checked Then
  Begin
    chkImpChq.Checked := False;
    chkImpCar.Checked := False;
  End;
end;

procedure TfrmRcxTransferenciaImpr.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrOk;
end;

procedure TfrmRcxTransferenciaImpr.FormShow(Sender: TObject);
begin
  inherited;
  If fCfgSis('RCXTCC') <> '2' Then
  Begin
    chkImpChq.Visible := False;
    chkImpCar.Visible := False;
    //Height := Height - chkImpChq.Height - chkImpCar.Height;
  End;
  pSetFocus(chkImpTf);
end;

end.
