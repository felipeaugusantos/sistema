unit untMensagemTravaLote;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, MemoFocus;

type
  TfrmMensagemTravaLote = class(TfrmPaiEdit)
    mmoMensagem: TMemoFocus;
  private
    { Private declarations }
  public
    { Public declarations }
    Class Procedure pMostraTravaLote(strEstacao: String);
  end;

var
  frmMensagemTravaLote: TfrmMensagemTravaLote;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

Class Procedure TfrmMensagemTravaLote.pMostraTravaLote(strEstacao: String);
Begin
  pCriarFormularios(TfrmMensagemTravaLote, frmMensagemTravaLote);
  frmMensagemTravaLote.mmoMensagem.Lines.Add(strEstacao);
  frmMensagemTravaLote.ShowModal;
  pFreeAndNil(frmMensagemTravaLote);
End;

end.
