unit untDigOperador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass, Vcl.Graphics,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, EditFocus, untTypesSistema;

type
  TfrmDigOperador = class(TfrmPaiConfirma)
    lbl8: TLabel;
    edtCodOpe: TEditFocus;
    edtNomOpe: TEditFocus;
    procedure edtCodOpeKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodOpeExit(Sender: TObject);
  private
    arrCodVen : TConsultasArray;
  public
    Class Function fGetCodOperador(strOpeDefault : String = ''; strCaption : String = '') : String;
    class function fGetCodOperador_ComDescricao(strOpeDefault : String; strCaption : String; var ANomOpe: string): String;

  protected
    function fValidaCampos(Sender : TWinControl; blnBuscarPorChave : Boolean): Boolean; Override;
  end;

implementation

{$R *.dfm}

uses untFuncoesConsulta, untConsultas, untFuncoesSimples;

procedure TfrmDigOperador.edtCodOpeExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodOpe, edtNomOpe, arrCodVen, fRetNomeOperador, nil, 'do Operador');
end;

procedure TfrmDigOperador.edtCodOpeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodOpe, edtNomOpe, nil, Key, arrCodVen, True, True ) Then
  Begin
    If fValidaCampos(edtCodOpe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

class function TfrmDigOperador.fGetCodOperador(strOpeDefault : String; strCaption : String): String;
  var
    frmDigOperador: TfrmDigOperador;
begin
  Result := '';
  pCriarFormularios(TfrmDigOperador, frmDigOperador);
  Try
    If not fEmptyStr(strCaption) Then
      frmDigOperador.Caption := strCaption;

    frmDigOperador.edtCodOpe.Text := strOpeDefault;
    frmDigOperador.edtNomOpe.Text := fRetNomeOperador(strOpeDefault);

    If frmDigOperador.ShowModal = MrOK Then
      Result := frmDigOperador.edtCodOpe.Text;
  Finally
    pFreeAndNil(frmDigOperador);
  End;
end;


class function TfrmDigOperador.fGetCodOperador_ComDescricao(strOpeDefault : String; strCaption : String; var ANomOpe: string): String;
  var
    frmDigOperador: TfrmDigOperador;
begin
  Result := '';
  pCriarFormularios(TfrmDigOperador, frmDigOperador);
  Try
    If not fEmptyStr(strCaption) Then
      frmDigOperador.Caption := strCaption;

    frmDigOperador.edtCodOpe.Text := strOpeDefault;
    frmDigOperador.edtNomOpe.Text := fRetNomeOperador(strOpeDefault);

    If frmDigOperador.ShowModal = MrOK Then
    Begin
      ANomOpe := frmDigOperador.edtNomOpe.Text;
      Result := frmDigOperador.edtCodOpe.Text;
    End;
  Finally
    pFreeAndNil(frmDigOperador);
  End;
end;


function TfrmDigOperador.fValidaCampos(Sender: TWinControl;
  blnBuscarPorChave: Boolean): Boolean;
begin
  Result := True;
  If (Sender = edtCodOpe) Then
  Begin
    If Not fEmptyStr(edtCodOpe.Text) Then
    Begin
      edtNomOpe.Text := fRetNomeOperador(edtCodOpe.Text);
      Result := (Not fEmptyStr(edtNomOpe.Text));
      If (Result) And (Not fOperadorAtivo(edtCodOpe.Text)) Then
      Begin
        pMensagemOK('Atenção! O operador informado '+edtCodOpe.Text+' está inativo. Peça para um responsável ajustar o cadastro ou informe um código válido.');
        Result := False;
      End
      Else If (Not Result) Then
      Begin
        pMensagemOK('Operador não encontrado');
      End;
    End;
  End;
end;

end.
