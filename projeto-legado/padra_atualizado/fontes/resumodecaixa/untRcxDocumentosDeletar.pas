unit untRcxDocumentosDeletar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, AppEvnts,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmRcxDocumentosDeletar = class(TfrmPai)
    stgDocumentos: TStringGrid;
    btnConfirmaDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure memTextoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure stgDocumentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

uses untfuncoesSimples;

{$R *.dfm}

procedure TfrmRcxDocumentosDeletar.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fMensagem('', 'Confirma exclusão dos dados?', ['&Sim', '&Não']) = 1) Then
  Begin
    Close;
    ModalResult := mrOk;
  End;
end;

procedure TfrmRcxDocumentosDeletar.btnSairClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrCancel;
end;

procedure TfrmRcxDocumentosDeletar.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If ModalResult <> mrOK Then
  Begin
    If fMensagem('ATENÇÃO', 'Ao escolher pelo cancelamento da exclusão dos documentos, o valor anterior voltará a ser considerado. ' + #13 +
                            'Deseja realmente continuar?', ['&Sim', 'Não'], 2) = 2 Then
      CanClose := False;
    ModalResult := mrCancel;
  End;
end;

procedure TfrmRcxDocumentosDeletar.memTextoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    pSetFocus(btnConfirmaDados);
  End;
end;

procedure TfrmRcxDocumentosDeletar.stgDocumentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
    btnConfirmaDados.Click
  Else If (Key = VK_ESCAPE) Then
    btnSair.Click;
end;

end.

