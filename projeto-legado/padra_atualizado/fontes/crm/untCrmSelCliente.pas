unit untCrmSelCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.StdCtrls, EditFocus,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untTypesSistema;

type
  TfrmCrmSelCliente = class(TfrmPaiConfirma)
    pnlFundo: TPanel;
    lblCliente: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure pCarregarCliente;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  untConsultas, untFuncoesSimples;

{$R *.dfm}

procedure TfrmCrmSelCliente.edtCodCliKeyPress(Sender: TObject; var Key: Char);
Var
  arrClientes: TConsultasArray;
begin
  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCrmSelCliente.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtCodCli) Then
    Begin
      If Not (fEmptyStr(edtCodCli.Text)) Then
      Begin
        pCarregarCliente;
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'O cliente precisa ser informado!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCrmSelCliente.pCarregarCliente;
begin
  If fEmptyStr(edtCodCli.Text) Then
  Begin
    edtNomCli.Clear;
    Exit;
  End;

  edtNomCli.Text := fRetNomCliente(edtCodCli.Text)

end;

end.
