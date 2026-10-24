unit untContatoLeads;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, untZClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, Vcl.Mask,
  MaskEditFocus, EditFocus, untMskTelefone;

type
  TfrmContatoLeads = class(TfrmPaiConfirma)
    cxgContatosDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgContatosLevel1: TcxGridLevel;
    cxgContatos: TcxGridCitel;
    pnlDados: TPanel;
    edtNomCtt: TEditFocus;
    edtEmaCtt: TEditFocus;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    cxgContatosCLI_NOMCTT: TcxGridDBColumn;
    cxgContatosCLI_TELCTT: TcxGridDBColumn;
    cxgContatosCLI_EMACTT: TcxGridDBColumn;
    edtTelCtt: TMaskEditTelefone;
    procedure cxgContatosDBTableViewCitel1DblClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
  private
    FCodCli : String;
    blnEdit : Boolean;
    cdsCliCtt : TZClient;
    function fGetSQL : String;
    procedure pLimpaEdits;
  public
    class procedure fCadContatoLead(strCodCli : String);
  published
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean; Override;
  end;

implementation

uses
  untFuncoesSimples;

{$R *.dfm}

{ TfrmContatoLeads }

procedure TfrmContatoLeads.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  if not fVerificaCampos Then
    Exit;

  If (not blnEdit) Then
  Begin
    cdsCliCtt.Insert;
    cdsCliCtt.FieldByName('CLI_CODCLI').AsString := FCodCli;
    cdsCliCtt.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CLICTT', VS_strCodEmp);
  End
  Else
    cdsCliCtt.Edit;

  cdsCliCtt.FieldByName('CLI_NOMCTT').AsString := edtNomCtt.Text;
  cdsCliCtt.FieldByName('CLI_TELCTT').AsString := edtEmaCtt.Text;
  cdsCliCtt.FieldByName('CLI_EMACTT').AsString := edtTelCtt.Text;

  cdsCliCtt.Post;
  blnEdit := False;
  pLimpaEdits;
  pSetFocus(edtNomCtt);
end;

procedure TfrmContatoLeads.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  blnEdit := False;
  pLimpaEdits;
end;

procedure TfrmContatoLeads.pLimpaEdits;
Begin
  edtNomCtt.Clear;
  edtEmaCtt.Clear;
  edtTelCtt.Clear;
End;

procedure TfrmContatoLeads.btnConfirmaClick(Sender: TObject);
begin
  //inherited;
  blnVerificaCampos := False;
  cdsCliCtt.ApplyUpdates(-1);
end;

procedure TfrmContatoLeads.cxgContatosDBTableViewCitel1DblClick(
  Sender: TObject);
begin
  inherited;
  edtNomCtt.Text := cdsCliCtt.FieldByName('CLI_NOMCTT').AsString;
  edtEmaCtt.Text := cdsCliCtt.FieldByName('CLI_TELCTT').AsString;
  edtTelCtt.Text := cdsCliCtt.FieldByName('CLI_EMACTT').AsString;

  blnEdit := True;

  pSetFocus(edtNomCtt);

end;

class procedure TfrmContatoLeads.fCadContatoLead(strCodCli: String);
  var
    frmContatoLeads: TfrmContatoLeads;
begin
  pCriarFormularios(TfrmContatoLeads, frmContatoLeads);
  frmContatoLeads.cdsCliCtt := TZClient.Create(frmContatoLeads, frmContatoLeads.fGetSQL);
  frmContatoLeads.cdsCliCtt.qryQuery.ParamByName('CODCLI').AsString:= strCodCli;
  frmContatoLeads.cdsCliCtt.fAbreClient(True, 'TfrmContatoLeads.fCadContatoLead');
  frmContatoLeads.cxgContatosDBTableViewCitel1.DataController.DataSource := frmContatoLeads.cdsCliCtt.dtsSource;
  frmContatoLeads.FCodCli := strCodCli;
  frmContatoLeads.blnEdit := False;
  frmContatoLeads.ShowModal;
  FreeAndNil(frmContatoLeads);
end;

function TfrmContatoLeads.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT CLI_CODCLI, ';
  Result := Result + '        CLI_NOMCTT, ';
  Result := Result + '        CLI_TELCTT, ';
  Result := Result + '        CLI_EMACTT, ';
  Result := Result + '        AUTOINCREM  ';
  Result := Result + ' FROM CLICTT        ';
  Result := Result + ' WHERE CLI_CODCLI = :CODCLI ';
end;

function TfrmContatoLeads.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);
  If Result Then
  Begin
    If (Sender = edtNomCtt) Then
    Begin
      if fEmptyStr(edtNomCtt.Text) Then
      Begin
        Result := fMensagem('', 'Preencha o nome do contato', ['&OK']) = -1;
      End

    End

    Else If (Sender = edtEmaCtt) Then
    Begin
      Result := fEmailValido(edtEmaCtt.Text, True, 'E-mail', False, True);
    End

    Else If (Sender = edtTelCtt) Then
    Begin
      if fEmptyStr(edtTelCtt.Text) Then
      Begin
        Result := fMensagem('', 'Preencha o telefone do contato!', ['&OK']) = -1;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

end.
