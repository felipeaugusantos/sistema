unit untCadTabelaPrecosHeranca;

interface

uses
  Windows, Controls, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons,
  EditFocus, BitBtnLockedIncrem, Classes, ExtCtrls;

type
  TfrmCadTabelaPrecosHeranca = class(TfrmPaiConfirma)
    Label1: TLabel;
    edtCodTab: TEditFocus;
    edtNomTab: TEditFocus;
    procedure edtCodTabKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadTabelaPrecosHeranca: TfrmCadTabelaPrecosHeranca;

implementation

uses Forms, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadTabelaPrecosHeranca.edtCodTabKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrTabela : TConsultasArray;
begin
  inherited;

  If fPesqTabelaPreco(Self, edtCodTab, edtNomTab, Nil, Key, arrTabela) Then
  Begin
    If fValidaCampos(edtCodTab, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmCadTabelaPrecosHeranca.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodTab) Then
    Begin
      If fEmptyStr(edtCodTab.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o Código da Tabela de Preço!', ['&Ok']);
        Result := False;
      End Else
      Begin
        edtNomTab.Text := fRetNomeTabelaPreco(edtCodTab.Text);
        If fEmptyStr(edtNomTab.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código da Tabela não econtrado!', ['&Ok']);
          Result := False;
        End;
      End;

    End

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

end.

