unit untFatDigCodBarrasProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, StdCtrls, EditFocus, frxClass,
  frxExportCSVTestabilidade, AppEvnts, Menus, Buttons, BitBtnLockedIncrem,
  ExtCtrls, untTypesSistema, Data.DB, MemDS, DBAccess, Uni, untLiberacao;

type
  TfrmFatDigCodBarrasProduto = class(TfrmPaiConfirma)
    pnlCodBarProduto: TPanel;
    lblCodBarProduto: TLabel;
    edtCodBarProduto: TEditFocus;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    class function fDigCodBarrasProduto(): String;
  end;

implementation

uses untFuncoesSimples, untFuncFat;

{$R *.dfm}

{ TfrmFatDigCodBarrasProduto }

procedure TfrmFatDigCodBarrasProduto.btnConfirmaClick(Sender: TObject);
begin
  If fVerificaCampos Then
    inherited;
end;

class function TfrmFatDigCodBarrasProduto.fDigCodBarrasProduto(): String;
var
  frmFatDigCodBarrasProduto: TfrmFatDigCodBarrasProduto;
begin
  Result := '';
  pCriarFormularios(TfrmFatDigCodBarrasProduto, frmFatDigCodBarrasProduto);
  Try
    frmFatDigCodBarrasProduto.ShowModal;
    If (frmFatDigCodBarrasProduto.ModalResult = mrOk) Then
      Result := frmFatDigCodBarrasProduto.edtCodBarProduto.Text;
  Finally
    pFreeAndNil(frmFatDigCodBarrasProduto);
  End;
end;

procedure TfrmFatDigCodBarrasProduto.FormShow(Sender: TObject);
begin
  inherited;
  SelectFirst;
end;

function TfrmFatDigCodBarrasProduto.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodBarProduto) Then
    begin
      If fEmptyStr(edtCodBarProduto.Text) Then
      begin
        fMensagem('Atenção', 'Código do Produto é obrigatório!', ['&Ok']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
        btnConfirma.Click;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.
