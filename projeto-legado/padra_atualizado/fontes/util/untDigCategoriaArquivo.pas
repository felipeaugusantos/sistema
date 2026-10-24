unit untDigCategoriaArquivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus;

type
  TfrmDigCategoriaArquivo = class(TfrmPaiConfirma)
    Label1: TLabel;
    edtCategoria: TEditFocus;
  private
    { Private declarations }
  public
    class function fDigCategoria: String;
    { Public declarations }
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscarPorChave : Boolean): Boolean; Override;
  end;

var
  frmDigCategoriaArquivo: TfrmDigCategoriaArquivo;

implementation

{$R *.dfm}

uses untFuncoesSimples;

class function TfrmDigCategoriaArquivo.fDigCategoria: String;
  var
    frmDigCategoriaArquivo: TfrmDigCategoriaArquivo;
begin
  Result := '';
  pCriarFormularios(TfrmDigCategoriaArquivo, frmDigCategoriaArquivo);

  If frmDigCategoriaArquivo.ShowModal = mrOK Then
    Result := Trim(frmDigCategoriaArquivo.edtCategoria.Text);

  FreeAndNil(frmDigCategoriaArquivo);
end;

function TfrmDigCategoriaArquivo.fValidaCampos(Sender: TWinControl;
  blnBuscarPorChave: Boolean): Boolean;
begin
  Result := True;
  If (Sender = edtCategoria) Then
  Begin
    If fEmptyStr(edtCategoria.Text) Then
    Begin
      Result := False;
      pMensagemOK('Informe a nova categoria!');
    End
    else If fCampoTabela('COUNT(0)', 'CATARQ', ['CAT_DESCRI'], [Trim(edtCategoria.Text)]) <> '0' Then
    Begin
      Result := False;
      pMensagemOK('Categoria já cadastrada!');
    End;
  End;
end;

end.
