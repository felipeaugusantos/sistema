unit untCfgBalancas;

interface

uses
  Windows, Classes, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, ComboBoxFocus, BitBtnLockedIncrem, Controls, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCfgBalancas = class(TfrmPai)
    pnlCentral: TPanel;
    lbl3: TLabel;
    lbl4: TLabel;
    cbbModBal: TComboBoxFocus;
    cbbPorta: TComboBoxFocus;
    lbl1: TLabel;
    cbbBaud: TComboBoxFocus;
    lbl2: TLabel;
    cbbDataBt: TComboBoxFocus;
    lbl5: TLabel;
    cbbParity: TComboBoxFocus;
    lbl6: TLabel;
    cbbStop: TComboBoxFocus;
    lbl7: TLabel;
    cbbHandsh: TComboBoxFocus;
    btnGravar: TBitBtnLocked;
    Label1: TLabel;
    edtDigIni: TEditFocus;
    chkDivQtd: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    procedure pGravarArqIni;
    procedure pCarregarArqIni;
  public
    { Public declarations }
  end;

var
  frmCfgBalancas: TfrmCfgBalancas;

implementation

uses
   Forms, untFuncoesSimples;

{$R *.dfm}

{ TfrmCfgBalancas }

procedure TfrmCfgBalancas.pCarregarArqIni;
begin
  cbbModBal.Text    := fCfgSisL('MODBAL');
  cbbPorta.Text     := fCfgSisL('COMBAL');
  cbbBaud.Text      := fCfgSisL('RATBAL');
  cbbDataBt.Text    := fCfgSisL('BITBAL');
  cbbParity.Text    := fCfgSisL('PARBAL');
  cbbStop.Text      := fCfgSisL('STOBAL');
  cbbHandsh.Text    := fCfgSisL('HANBAL');
  edtDigIni.Text    := fCfgSisL('DIGBAL');
  chkDivQtd.Checked := fCfgSisL('DVQBAL') = 'S';
end;

procedure TfrmCfgBalancas.pGravarArqIni;
begin
  fAtuCfgSis('MODBAL', cbbModBal.Text);
  fAtuCfgSis('COMBAL', cbbPorta.Text);
  fAtuCfgSis('RATBAL', cbbBaud.Text);
  fAtuCfgSis('BITBAL', cbbDataBt.Text);
  fAtuCfgSis('PARBAL', cbbParity.Text);
  fAtuCfgSis('STOBAL', cbbStop.Text);
  fAtuCfgSis('HANBAL', cbbHandsh.Text);
  fAtuCfgSis('DIGBAL', edtDigIni.Text);
  fAtuCfgSis('DVQBAL', IIF(chkDivQtd.Checked, 'S', 'N'));
end;

procedure TfrmCfgBalancas.FormShow(Sender: TObject);
begin
  inherited;
  pCarregarArqIni;
  pSetFocus(cbbModBal);
end;

procedure TfrmCfgBalancas.btnGravarClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) And (fMensagem('', 'Confirma alterações?', ['&Sim', '&Não']) = 1) Then
  Begin
    pGravarArqIni;
    Close;
    ModalResult := mrOk;
  End;
end;

end.
