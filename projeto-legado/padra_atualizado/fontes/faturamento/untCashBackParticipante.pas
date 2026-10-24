unit untCashBackParticipante;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, LabeledEditFocus, EditFocus;

type
  TfrmCashBackParticipante = class(TfrmPai)
    lblParticipante: TLabel;
    edtCashBack: TEditFocus;
    edtTotRes: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblNomeParticipante: TLabel;
    edtTotGer: TEditFocus;
    edtCashDisp: TEditFocus;
    Label5: TLabel;
    btnConfirma: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCashBackChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCashBackParticipante: TfrmCashBackParticipante;

implementation

uses
  untFuncoesSimples, untFuncoes;

{$R *.dfm}

procedure TfrmCashBackParticipante.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  if fStrToFloat(edtCashBack.Text) > fStrToFloat(edtCashDisp.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Valor digitado acima do CashBack disponível!' , ['&Ok']);
    edtCashBack.SetFocus;
    Exit;
  end
  else
  if fStrToFloat(edtCashBack.Text) > fStrToFloat(edtTotGer.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Valor digitado não pode ser superior ao valor da venda!' , ['&Ok']);
    edtCashBack.SetFocus;
    Exit;
  end
  else
  if fStrToFloat(edtCashBack.Text) < 0 then
  begin
    fMensagem('ATENÇÃO!', 'Valor digitado não pode ser menor que zero!' , ['&Ok']);
    edtCashBack.SetFocus;
    Exit;
  end
  else
    ModalResult := mrOk;
end;

procedure TfrmCashBackParticipante.edtCashBackChange(Sender: TObject);
begin
  inherited;
  edtTotRes.Text := fFloatToStrVirgula((fStrToFloat(edtTotGer.Text) - fStrToFloat(edtCashBack.Text)), 12,2);
end;

end.
