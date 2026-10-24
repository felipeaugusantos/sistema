unit untMultiConfirmacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, StdCtrls, MemoFocus, AppEvnts, Menus, Buttons,
  BitBtnLockedIncrem, ExtCtrls, frxClass, frxExportCSVTestabilidade;

type
  TfrmMultiConfirmacao = class(TfrmPaiConfirma)
    memObs: TMemoFocus;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function fMultiConfirmacao(strCaption, strTexto: String): boolean;
  end;

var
  frmMultiConfirmacao: TfrmMultiConfirmacao;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema;

class function TfrmMultiConfirmacao.fMultiConfirmacao(strCaption,
  strTexto: String): boolean;
  var
    LfrmMultiConfirmacao : TfrmMultiConfirmacao;
begin
  If Not VS_ExibirMensagemAoUsuario Then
  Begin
    If Assigned(VS_OnMensagemAoUsuario) Then
      VS_OnMensagemAoUsuario(strCaption + ': ' + strTexto);
    Result := False;
    Exit;
  End;

  pCriarFormularios(TfrmMultiConfirmacao, LfrmMultiConfirmacao);
  Try
    LfrmMultiConfirmacao.Caption := strCaption;
    LfrmMultiConfirmacao.memObs.Texto := strTexto;
    LfrmMultiConfirmacao.ShowModal;
    Result := (LfrmMultiConfirmacao.ModalResult <> mrCancel);
  Finally
    pFreeAndNil(LfrmMultiConfirmacao);
  End;
end;

procedure TfrmMultiConfirmacao.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnConfirma);
end;

end.
