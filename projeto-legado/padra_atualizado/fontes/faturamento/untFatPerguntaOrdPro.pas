unit untFatPerguntaOrdPro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiEdit, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  ComCtrls, untFatOrdProTintaMaquina, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFatPerguntaOrdPro = class(TfrmPaiEdit)
    chkImpOrd: TCheckBox;
    prgProgresso: TProgressBar;
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strMsgOpr: String;
    oprOdemProducao: TFatOrdProTintaMaquina;
  end;

var
  frmFatPerguntaOrdPro: TfrmFatPerguntaOrdPro;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmFatPerguntaOrdPro.FormShow(Sender: TObject);
begin
  inherited;

  chkImpOrd.Caption := strMsgOpr;

  chkImpOrd.Checked := fCfgSis('SUGODP', VarBoolean);
  //chkEnvLab.Checked := fCfgSis('SUGLAB', VarBoolean);

end;

procedure TfrmFatPerguntaOrdPro.btnSairClick(Sender: TObject);
begin
  inherited;

//  If frmFatPerguntaOrdPro.chkEnvLab.Checked Then
//    oprOdemProducao.pMensagemLaboratorio(prgProgresso);

end;

end.
