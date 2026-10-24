unit Fulfillment.View.PedArqFulFillment;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxButtonEdit, FilenameEditFocus, System.StrUtils;

type
  TfrmPedArqFulFillment = class(TfrmPaiConfirma)
    Label2: TLabel;
    edtNomArq: TFilenameEditFocus;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
  end;

implementation

{$R *.dfm}

Uses
  untFuncoesSimples;

procedure TfrmPedArqFulFillment.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = MrOk Then
  Begin

    If Not fVerificaCampos Then
      Action := caNone;

  End;

end;

function TfrmPedArqFulFillment.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender  = edtNomArq) Then
    Begin

      If fEmptyStr(edtNomArq.Text) Then
      Begin
        fMensagem('ATENÇÃO','O nome do arquivo deve ser preenchido!',['&OK']);
        Result := False;
      End

      Else If Not DirectoryExists(ExtractFileDir(edtNomArq.Text)) Then
      Begin
        pMensagemOk('Pasta ' + ExtractFileDir(edtNomArq.Text) + ' não encontrada!');
        Result := False;
      End

      Else If Not EndsText('.CSV', Trim(UpperCase(edtNomArq.Text))) Then
      Begin
        edtNomArq.Text := Concat(edtNomArq.Text, '.CSV');
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
