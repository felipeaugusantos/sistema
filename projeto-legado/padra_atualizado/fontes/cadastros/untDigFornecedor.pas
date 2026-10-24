unit untDigFornecedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, StdCtrls, EditFocus, AppEvnts, Menus, Buttons,
  BitBtnLockedIncrem, ExtCtrls, untFuncoesSimples, untTypesSistema;

type
  TfrmDigFornecedor = class(TfrmPai)
    pnlGeral: TPanel;
    lblCliFor: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    btnConfirmaDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodForExit(Sender: TObject);
  private
    { Private declarations }
    arrFornecedor: TConsultasArray;
  public
    { Public declarations }
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;


implementation

uses untConsultas,  untFuncoesConsulta;

{$R *.dfm}

{ TfrmDigFornecedor }

procedure TfrmDigFornecedor.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    ModalResult := mrOk;
  End;
end;

procedure TfrmDigFornecedor.edtCodForExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodFor,edtNomFor,
                    arrFornecedor,fRetNomFornecedor,nil,'do Fornecedor');
end;

procedure TfrmDigFornecedor.edtCodForKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtCodFor, edtNomFor, Nil, Key, arrFornecedor, True) Then
  Begin
    fValidaCampos(edtCodFor, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmDigFornecedor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  {*****************************************}
  {* VALIDA FORNECEDOR                     *}
  {**************************************FC*}
  If Sender = edtCodFor Then
  Begin
    If fEmptyStr(edtCodFor.Text) Then
    Begin
      fMensagem('', 'O fornecedor deve ser preenchido!' , ['&Ok']);
      Result := False;
    End
    Else
    Begin
      edtNomFor.Text := fRetNomFornecedor(edtCodFor.Text);

      If fEmptyStr(edtNomFor.Text) Then
      Begin
        fMensagem('AVISO', 'Fornecedor não encontrado!', ['&Ok']);
        Result := False;
      End
      Else If Not fRetStatusFornecedor(edtCodFor.Text) Then
      Begin
        fMensagem('', 'Esse fornecedor está com atividade suspensa!', ['&O k']);
        Result := False;
      End;
    End;
  End;
end;

end.
