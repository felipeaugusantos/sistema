unit untBaseFechamento;

interface

uses
  Windows, Classes, StdCtrls, untPaiSimples, EditFocus, ComCtrls, Buttons, ExtCtrls,
  Menus, AppEvnts, BitBtnLockedIncrem, Controls, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmBaseFechamento = class(TfrmPaiSimples)
    pnlBotoesConf: TPanel;
    pnlMeses: TPanel;
    Label1: TLabel;
    edtAno: TEditFocus;
    gpbMeses: TGroupBox;
    chkMes01: TCheckBox;
    chkMes02: TCheckBox;
    chkMes03: TCheckBox;
    chkMes04: TCheckBox;
    chkMes05: TCheckBox;
    chkMes06: TCheckBox;
    chkMes07: TCheckBox;
    chkMes08: TCheckBox;
    chkMes09: TCheckBox;
    chkMes10: TCheckBox;
    chkMes11: TCheckBox;
    chkMes12: TCheckBox;
    pnlBarra: TPanel;
    pgbProgresso: TProgressBar;
    btnConfirma: TBitBtnLocked;
    btnSairFechamento: TBitBtnLocked;
    procedure btnSairClick(Sender: TObject);
    procedure chkMes01KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses SysUtils, Forms, untPai, untFuncoesSimples;

{$R *.dfm}

procedure TfrmBaseFechamento.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBaseFechamento.chkMes01KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
  Begin
//    (Sender As TCheckBox).Checked := Not (Sender As TCheckBox).Checked;
    SelectNext(ActiveControl, True, True);
  End
  Else If (Key = VK_Escape) Then
  Begin
    btnSairFechamento.Click;
  End;
  
end;

procedure TfrmBaseFechamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F10) Then
  Begin
    btnConfirma.Click;
  End;
end;

procedure TfrmBaseFechamento.FormCreate(Sender: TObject);
begin
  inherited;
  edtAno.Text := FormatDateTime('yyyy', VS_Date);
end;

end.

