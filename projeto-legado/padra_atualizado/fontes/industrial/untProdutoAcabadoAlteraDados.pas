unit untProdutoAcabadoAlteraDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Vcl.Mask, Vcl.DBCtrls, MaskEditFocus;

type
  TfrmProdutoAcabadoAlteraDados = class(TfrmPaiConfirma)
    Label6: TLabel;
    edtCodMar: TEditFocus;
    edtDesMar: TEditFocus;
    Label3: TLabel;
    edtLinGru: TEditFocus;
    edtCodGru: TMaskEditFocus;
    procedure edtCodGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
  public
    Class Function fGetDados(Var strCodMar, strCodLin : String) : Boolean;
  protected
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean = False) : Boolean; Override;
  end;

implementation

{$R *.dfm}

uses untTypesSistema, untConsultas, untFuncoesSimples;

procedure TfrmProdutoAcabadoAlteraDados.edtCodMarKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrMarca : TConsultasArray;
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;


end;

class function TfrmProdutoAcabadoAlteraDados.fGetDados(var strCodMar, strCodLin: String): Boolean;
  var
    frmProdutoAcabadoAlteraDados: TfrmProdutoAcabadoAlteraDados;
begin
  Try
    pCriarFormularios(TfrmProdutoAcabadoAlteraDados, frmProdutoAcabadoAlteraDados);
    With frmProdutoAcabadoAlteraDados Do
    Begin
      edtCodMar.Text := strCodMar;
      edtDesMar.Text := fRetNomeMarca(strCodMar);
      edtCodGru.Text := strCodLin;
      edtLinGru.Text := fRetNomeLinhaGrupo(strCodLin);
      frmProdutoAcabadoAlteraDados.ShowModal;
      Result := (frmProdutoAcabadoAlteraDados.ModalResult = MrOK);

      If Result Then
      Begin
        strCodMar := edtCodMar.Text;
        strCodLin := edtCodGru.Text
      End;

    End;
  Finally
    FreeAndNil(frmProdutoAcabadoAlteraDados);
  End;

end;

procedure TfrmProdutoAcabadoAlteraDados.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodMar);
end;

function TfrmProdutoAcabadoAlteraDados.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Result Then
  Begin
    If (Sender = edtCodMar) Then
    Begin
      If fEmptyStr(edtCodMar.Text) Then
      Begin
        Result := (fMensagem('', 'O código da Marca é obrigatório!', ['&OK']) = -1);
      End
      Else
      Begin
        edtDesMar.Text := fRetNomeMarca(edtCodMar.Text);
        If fEmptyStr(edtDesMar.Text) Then
          Result := (fMensagem('', 'O Código da Marca é Inválido!', ['&OK']) = -1);
      End;

    End
    Else If (Sender = edtCodGru) Then
    Begin
      If fEmptyStr(edtCodGru.Text) Then
      Begin
        Result := (fMensagem('', 'O código da Linha/Grupo é obrigatório!', ['&OK']) = -1);
      End
      Else
      Begin
        edtLinGru.Text := fRetNomeLinhaGrupo(edtCodGru.Text);
        If fEmptyStr(edtLinGru.Text) Then
          Result := (fMensagem('', 'O Código da Linha/Grupo é Inválido!', ['&OK']) = -1);
      End;

    End;

  End;

end;

procedure TfrmProdutoAcabadoAlteraDados.edtCodGruKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrGrupos: TConsultasArray;
begin
  inherited;
  If fPesqGrupo(Self, edtCodGru, edtLinGru, Nil, Key, arrGrupos) Then
  Begin
    If fValidaCampos(edtCodGru) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

end.
