unit untDigObsBoleto;

interface

uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiSimples, Mask, MaskEditFocus, EditFocus, untfuncoesSimples,
  ComCtrls, Buttons, ExtCtrls, StrUtils, Menus, AppEvnts, untFuncoesGenerica, untConstantes,
  Uni, BitBtnLockedIncrem, untTypesSistema, frxClass, frxExportCSVTestabilidade,
  Math, Vcl.DBCtrls, DBEditFocus, untBancos, untFuncoes, QColorLabel;

type
  TfrmDigObsBoleto = class(TfrmPaiSimples)
    pnlBotoesBaixa: TPanel;
    pnlFundo: TPanel;
    pnlDuplics: TPanel;
    btnSairDig: TBitBtnLocked;
    btnSalvar: TBitBtnLocked;
    pnlHeader: TPanel;
    pnl1: TPanel;
    Label4: TLabel;
    edtObservacao1: TEditFocus;
    pnl2: TPanel;
    Label5: TLabel;
    edtObservacao2: TEditFocus;
    pnl3: TPanel;
    Label6: TLabel;
    edtObservacao3: TEditFocus;
    pnl5: TPanel;
    Label8: TLabel;
    edtObservacao5: TEditFocus;
    chkSel1: TCheckBox;
    pnl4: TPanel;
    Label7: TLabel;
    edtObservacao4: TEditFocus;
    chkSel2: TCheckBox;
    chkSel3: TCheckBox;
    chkSel4: TCheckBox;
    chkSel5: TCheckBox;
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  protected
  public
    { Public declarations }
    blnConfirma: Boolean;
    strSelObs: String;

end;

implementation

uses untPai, Data.DB;

{$R *.dfm}

procedure TfrmDigObsBoleto.btnSairClick(Sender: TObject);
Begin
  Close;
End;

procedure TfrmDigObsBoleto.btnSalvarClick(Sender: TObject);
begin
  inherited;
  strSelObs := Concat(IIF(chkSel1.Checked,'1_',''),
                      IIF(chkSel2.Checked,'2_',''),
                      IIF(chkSel3.Checked,'3_',''),
                      IIF(chkSel4.Checked,'4_',''),
                      IIF(chkSel5.Checked,'5_',''));
  blnConfirma := True;
  Close;
end;

procedure TfrmDigObsBoleto.FormShow(Sender: TObject);
begin
  inherited;

  blnConfirma := False;

  chkSel1.Checked := Not fEmptyStr(edtObservacao1.Text);
  chkSel2.Checked := Not fEmptyStr(edtObservacao2.Text);
  chkSel3.Checked := Not fEmptyStr(edtObservacao3.Text);
  chkSel4.Checked := Not fEmptyStr(edtObservacao4.Text);
  chkSel5.Checked := Not fEmptyStr(edtObservacao5.Text);

  pSetFocus(btnSalvar);
end;

End.
