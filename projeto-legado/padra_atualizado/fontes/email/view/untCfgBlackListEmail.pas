unit untCfgBlackListEmail;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, Uni, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, UniCLientDataset,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid;

type
  TfrmCfgBlackListEmail = class(TfrmPai)
    pnlFundo: TPanel;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    grpDadosBlackList: TGroupBox;
    lblNomeProvedor: TLabel;
    edtEmail: TEditFocus;
    lblCliente: TLabel;
    edtCodigoCliente: TEditFocus;
    edtNomeCliente: TEditFocus;
    grdBlacklist: TcxGridCitel;
    grdBlacklistDados: TcxGridDBTableViewCitel;
    grdBlacklistLevel1: TcxGridLevel;
    grdBlacklistDadosBLK_EMAIL_: TcxGridDBColumn;
    grdBlacklistDadosBLK_CODCLI: TcxGridDBColumn;
    grdBlacklistDadosCLI_NOMCLI: TcxGridDBColumn;
    grdBlacklistDadosDATA_INCLUSAO: TcxGridDBColumn;
    grdBlacklistDadosOPERADOR: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodigoClienteKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    FQueryBlackList: TUniQuery;

    FDatasetBlackList: TUniClientDataset;

    procedure CriaTemporaria;

    procedure LimpaCampos;
    procedure HabilitaCamposEditar(AHabilitar: Boolean);

    function RegistroJaExistente: Boolean;

    procedure OnAfterScroll(Dataset: TDataset);
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation
Uses untFuncoesSimples, untConsultas, untPesqAux, untTypesSistema;
{$R *.dfm}

procedure TfrmCfgBlackListEmail.btnCancelaClick(Sender: TObject);
begin
  inherited;
  HabilitaCamposEditar(False);
  OnAfterScroll(FDatasetBlackList);
end;

procedure TfrmCfgBlackListEmail.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If FDatasetBlackList.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Não existe registro selecionado para utilizar a função', ['&Ok']);
    Exit;
  End;

  If fMensagem('ATENÇÃO',
               'Tem certeza que deseja remover o e-mail ' +
                  FDatasetBlackList.FieldByName('BLK_EMAIL_').AsString + ' da Blacklist?',
               ['&Sim', '&Não'], 2) = 1 Then
  Begin
    Try
      fStartTransaction;
      FQueryBlackList.Locate('AUTOINCREM', FDatasetBlackList.FieldByName('AUTOINCREM').AsString, []);
      fVerificaIntegridade(Self.Name, 'EMABLK', FQueryBlackList);

      FQueryBlackList.Delete;
      fCommit;
      FDatasetBlackList.Delete;

      fMensagem('ATENÇÃO', 'Registro excluido com sucesso.', ['&Ok']);
    Except
      On E: Exception Do
      Begin
        fRollback;
        pMensagensErro('Ocorreu um erro ao excluir o registro da Blacklist.' + #13 +
                       'Erro gerado: ' + E.Message, '[TfrmCfgBlackListEmail.btnExcluirClick]');
      End;
    End;

    OnAfterScroll(FDatasetBlackList);
  End;
end;

procedure TfrmCfgBlackListEmail.btnGravarClick(Sender: TObject);
  Var
    LAutoIncrem: String;
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  If RegistroJaExistente Then
  Begin
    pSetFocus(edtEmail);

    Exit;
  End;

  Try
    fStartTransaction;
    FQueryBlackList.Last;
    FQueryBlackList.Append;
    FQueryBlackList.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('EMABLK', VS_strCodEmp);
    FQueryBlackList.FieldByName('BLK_EMAIL_').AsString := edtEmail.Text;
    FQueryBlackList.FieldByName('BLK_CODCLI').AsString := edtCodigoCliente.Text;
    FQueryBlackList.FieldByName('BLK_CODOPE').AsString := strLoginUsuarioLogado;
    FQueryBlackList.FieldByName('BLK_DTACAD').AsDateTime := fRetDataServidor;
    FQueryBlackList.FieldByName('BLK_HORCAD').AsDateTime := fRetHoraServidor;
    FQueryBlackList.Post;
    fCommit;

    LAutoIncrem := FQueryBlackList.FieldByName('AUTOINCREM').AsString;

    CriaTemporaria;
    FDatasetBlackList.Locate('AUTOINCREM', LAutoIncrem, []);
    HabilitaCamposEditar(False);
  Except
    On E: Exception Do
    Begin
      fRollback;

      pMEnsagensErro('Ocorreu um erro ao inserir um novo email na BlackList.' + #13 +
                     'Erro gerado: ' + E.Message, '[TfrmCfgBlackListEmail.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCfgBlackListEmail.btnIncluirClick(Sender: TObject);
begin
  inherited;
  LimpaCampos;
  HabilitaCamposEditar(True);
  pSetFocus(edtEmail);
end;

procedure TfrmCfgBlackListEmail.CriaTemporaria;
begin
  FQueryBlackList := fCriaQuery;
  FQueryBlackList.SQL.Text := 'SELECT B.*, ' +
                              '  CONCAT(DATE_FORMAT(B.BLK_DTACAD, "%Y-%m-%d"), " ", DATE_FORMAT(B.BLK_HORCAD, "%H:%i:%S")) AS DATA_INCLUSAO, ' +
                              '  CONCAT(B.BLK_CODOPE, "-", O.OPE_NOMOPE) AS OPERADOR, ' +
                              '  C.CLI_NOMCLI ' +
                              'FROM EMABLK B ' +
                              'LEFT JOIN CADCLI C ON C.CLI_CODCLI=B.BLK_CODCLI ' +
                              'LEFT JOIN CADOPE O ON O.OPE_CODOPE=B.BLK_CODOPE ' +
                              'ORDER BY B.BLK_EMAIL_, C.CLI_NOMCLI ';
  FQueryBlackList.Open;

  FDatasetBlackList := fCriaClientDatSet(FQueryBlackList);
  FDatasetBlackList.AfterScroll := OnAfterScroll;
  grdBlacklistDados.DataController.DataSource := fCriaDataSource(FDatasetBlackList);

  FQueryBlackList.Close;
  FQueryBlackList.SQL.Text := 'SELECT * FROM EMABLK ORDER BY AUTOINCREM';
  FQueryBlackList.Open;
end;

procedure TfrmCfgBlackListEmail.edtCodigoClienteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    LArrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples,
                  Self,
                  edtCodigoCliente,
                  edtNomeCliente,
                  Nil,
                  Key,
                  LArrClientes) Then
  Begin
    If fValidaCampos(edtCodigoCliente, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCfgBlackListEmail.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(FQueryBlackList);
  FreeAndNil(FDatasetBlackList);
end;

procedure TfrmCfgBlackListEmail.FormCreate(Sender: TObject);
begin
  inherited;
  CriaTemporaria;
end;

procedure TfrmCfgBlackListEmail.FormShow(Sender: TObject);
begin
  inherited;
  HabilitaCamposEditar(False);
end;

function TfrmCfgBlackListEmail.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtEmail) And (grpDadosBlackList.Enabled) Then
    Begin
      If fEmptyStr(edtEmail.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O campo E-mail deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodigoCliente) And (grpDadosBlackList.Enabled) Then
    Begin
      If fEmptyStr(edtCodigoCliente.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O campo Cliente deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        edtNomeCliente.Text := fRetNomCliente(edtCodigoCliente.Text);

        If fEmptyStr(edtNomeCliente.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCfgBlackListEmail.HabilitaCamposEditar(AHabilitar: Boolean);
begin
  grpDadosBlackList.Enabled := AHabilitar;
  btnGravar.Enabled := AHabilitar;
  btnCancela.Enabled := AHabilitar;

  grdBlacklist.Enabled := Not AHabilitar;
  btnIncluir.Enabled := Not AHabilitar;
  btnExcluir.Enabled := Not AHabilitar;
  btnSair.Enabled := Not AHabilitar;

  FDatasetBlackList.EnableControls;
  If AHabilitar Then
    FDatasetBlackList.DisableControls;
end;

procedure TfrmCfgBlackListEmail.LimpaCampos;
begin
  edtEmail.Clear;
  edtCodigoCliente.Clear;
  edtNomeCliente.Clear;
end;

procedure TfrmCfgBlackListEmail.OnAfterScroll(Dataset: TDataset);
begin
  edtEmail.Text := Dataset.FieldByName('BLK_EMAIL_').AsString;
  edtCodigoCliente.Text := Dataset.FieldByName('BLK_CODCLI').AsString;
  edtNomeCliente.Text := Dataset.FieldByName('CLI_NOMCLI').AsString;
end;

function TfrmCfgBlackListEmail.RegistroJaExistente: Boolean;
begin
  Result := FQueryBlackList.Locate('BLK_EMAIL_;BLK_CODCLI',
                                   VarArrayOf([edtEmail.Text,
                                               edtCodigoCliente.Text]),
                                   []);

  If Result Then
    fMensagem('ATENÇÃO', 'Já existe esse e-mail na Blacklist para o cliente selecionado.', ['&Ok']);
end;

end.
