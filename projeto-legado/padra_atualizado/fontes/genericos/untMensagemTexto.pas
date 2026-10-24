unit untMensagemTexto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls;

type
  TfrmMensagemTexto = class(TfrmPaiEdit)
    mmoInstru: TMemo;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
     Class Procedure pMensagem(strTitulo, strMensagem: String);
  end;

var
  frmMensagemTexto: TfrmMensagemTexto;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmMensagemTexto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_ESCAPE: Close;
  End;

end;

Class Procedure TfrmMensagemTexto.pMensagem(strTitulo, strMensagem: String);
  Var
    frmMensagemTexto: TfrmMensagemTexto;
Begin
  pCriarFormularios(TfrmMensagemTexto, frmMensagemTexto);
  frmMensagemTexto.Caption := strTitulo;
  frmMensagemTexto.mmoInstru.Text := strMensagem;
  frmMensagemTexto.ShowModal;
  pFreeAndNil(frmMensagemTexto);
End;

end.
