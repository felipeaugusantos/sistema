unit untHerancaCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, Uni;

type
  TfrmHerancaCliente = class(TfrmPai)
    pnlCliente: TPanel;
    lblCliente: TLabel;
    edtDesCli: TEditFocus;
    edtCodCli: TEditFocus;
    btnConfirma: TBitBtnLocked;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    strCodCliente : String;
    blnConfirma   : Boolean;
    qryGenCli     : TUniQuery;
  end;

var
  frmHerancaCliente: TfrmHerancaCliente;

implementation

{$R *.dfm}

uses untFuncoesSimples, untConsultas, untTypesSistema;

procedure TfrmHerancaCliente.btnConfirmaClick(Sender: TObject);
Var
  strSQL : String;
begin

  inherited;

  if not fVerificaCampos then
    Exit;

  strCodCliente := edtCodCli.Text;

  strSQL := '';
  strSQL := 'SELECT * FROM CADCLI WHERE CLI_CODCLI = ' + QuotedStr(edtCodCli.Text);

  With qryGenCli Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    Open;
  End;

  blnConfirma := True;
  Close;

end;

procedure TfrmHerancaCliente.edtCodCliKeyPress(Sender: TObject; var Key: Char);
var
  arrClientes : TConsultasArray;
begin

  inherited;

  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmHerancaCliente.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  qryGenCli   := fCriaQuery(Self);
end;

function TfrmHerancaCliente.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin

    If Sender = edtCodCli Then
    Begin
      edtDesCli.Text := fRetNomCliente(edtCodCli.Text);
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        pMensagemOk('Informe o código do cliente!');
        Result := False;
      End
      Else If fEmptyStr(edtDesCli.Text) Then
      Begin
        pMensagemOk('Cliente não encontrado com este código!');
        Result := False;
      End
    End;

    If Not Result Then
      pSetFocus(Sender);

  End;

end;

end.
