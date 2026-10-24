unit untFatFormulSelTintas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  CheckLst, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmFatFormulSelTintas = class(TfrmPaiConfirma)
    chkLisTin: TCheckListBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Function fSelecionouTinta: Boolean;
  public
    { Public declarations }
  end;

var
  frmFatFormulSelTintas: TfrmFatFormulSelTintas;

implementation
uses untFuncoesSimples;
{$R *.dfm}


procedure TfrmFatFormulSelTintas.FormShow(Sender: TObject);
begin
  inherited;
  FlwBotoes.Visible := True;
end;

Function TfrmFatFormulSelTintas.fSelecionouTinta: Boolean;
  Var
    intIndice: Integer;
Begin
  Result := False;
  For intIndice := 0 To chkLisTin.Count - 1 Do
    If chkLisTin.Checked[intIndice] Then
    Begin
      Result := True;
      Exit;
    End;
End;

procedure TfrmFatFormulSelTintas.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = mrOk) Then
  Begin
    If fSelecionouTinta Then
    Begin
      If Not fPergunta('Confirma a baixa das formulações?') Then
        Action := canone;
    End Else
    Begin
      pMensagemOk('Nemhuma tinta selecionada!');
       Action := canone;
    End;

  End;
end;

end.
