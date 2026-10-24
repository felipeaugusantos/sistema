{***************************}
{* qryConCli -> CADCLI     *}
{************************JB*}

unit untRcxDigCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Menus, Uni, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

Type
  TDireitoAcesso = Function(ACodigoOperador, ACodigoCliente: String): Boolean Of Object;

type
  TfrmRcxDigCliente = class(TfrmPaiSimples)
    pnlDados: TPanel;
    Label15: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    btnConfirma: TBitBtnLocked;
    btnReimpRecibos: TBitBtnLocked;
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnReimpRecibosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryConCli: TUniQuery;

    FExibeRelatorio: Boolean;

    FDireitoAcesso: TDireitoAcesso;

    FCodigoCLienteInicial: String;

    procedure pCarregaCliente;

    function LiberacaoAlteracaoCliente: Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
    strCodOpe: String;
    strStatus: String;

    property ExibeRelatorio: Boolean read FExibeRelatorio write FExibeRelatorio;
    property CodigoClienteInicial: String read FCodigoCLienteInicial write FCodigoCLienteInicial;

    procedure SetDireitoAcesso(AFuncaoDireitoAcesso: TDireitoAcesso);
  end;


implementation

uses untfuncoesSimples, untPesqAux, untPai, untConsultas, untTypesSistema,
  untRelCtrReimpressaoDocs;

{$R *.dfm}

procedure TfrmRcxDigCliente.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes, True, Nil, False, '', '', True, strCodOpe) Then
  Begin
    If fValidaCampos(edtCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRcxDigCliente.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);

  FExibeRelatorio := True;

  FCodigoCLienteInicial := EmptyStr;
  FDireitoAcesso := Nil;
end;

procedure TfrmRcxDigCliente.FormShow(Sender: TObject);
begin
  inherited;

  btnReimpRecibos.Visible := False;
  If FExibeRelatorio Then
    btnReimpRecibos.Visible := fVerificaAcessoSistema('frmRelCtrReimpressaoDocs');

  If Not fEmptyStr(edtCodCli.Text) Then
  Begin
    pCarregaCliente;
    FCodigoCLienteInicial := edtCodCli.Text;
  End;
end;

function TfrmRcxDigCliente.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (Sender = edtCodCli) Then
  Begin

    If (fEmptyStr(edtCodCli.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O cliente deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pCarregaCliente;
      If (qryConCli.FieldByName('CLI_CODCLI').IsNull) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmRcxDigCliente.LiberacaoAlteracaoCliente: Boolean;
begin
  Result := True;

  If FCodigoClienteInicial.IsEmpty Then
    Exit;

  If Not Assigned(FDireitoAcesso) Then
    Exit;

  If FCodigoClienteInicial.Equals(edtCodCli.Text) Then
    Exit;

  Result := FDireitoAcesso(strCodOpe, edtCodCli.Text);
end;

procedure TfrmRcxDigCliente.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, edtCodCli.Text, True, False, strCodOpe);
  edtNomCli.Text := qryConCli.FieldByName('CLI_NOMCLI').AsString;
  strStatus      := qryConCli.FieldByName('CLI_STATUS').AsString;
end;

procedure TfrmRcxDigCliente.SetDireitoAcesso(
  AFuncaoDireitoAcesso: TDireitoAcesso);
begin
  FDireitoAcesso := AFuncaoDireitoAcesso;
end;

procedure TfrmRcxDigCliente.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    blnConfirma := LiberacaoAlteracaoCliente;

    If blnConfirma Then
      Self.Close;
  End;
end;

procedure TfrmRcxDigCliente.btnReimpRecibosClick(Sender: TObject);
  Var
    frmRelCtrReimpressaoDocs: TfrmRelCtrReimpressaoDocs;
begin
  inherited;
  If (Not fVerificaCampos) Then
    Exit;

  pCriarFormularios(TfrmRelCtrReimpressaoDocs, frmRelCtrReimpressaoDocs);
  With frmRelCtrReimpressaoDocs Do
  Begin
    edtCodCliente.Text := edtCodCli.text;
    edtEspDoc.Text     := 'CC';
    edtCodEmpresa.Text := VS_strCodEmp;
    blnCaixaCC         := True;
    btnImprimir.Click;
    Close;
  End;
  FreeAndNil(frmRelCtrReimpressaoDocs);
end;

procedure TfrmRcxDigCliente.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

end.

