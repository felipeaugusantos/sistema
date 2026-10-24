unit untConfiguracoesLinksAPIBancos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCurrencyEdit, cxImageComboBox, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel,
  cxGrid, EditFocus, ComboBoxFocus, Uni, UniClientDataset, System.StrUtils;

type
  TfrmConfiguracoesLinksAPIBancos = class(TfrmPai)
    pnlTopo: TPanel;
    grdListaLinks: TcxGridCitel;
    grdListaLinksDados: TcxGridDBTableViewCitel;
    grdListaLinksNivel: TcxGridLevel;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    lblLinkRecurso: TLabel;
    edtLinkRecurso: TEditFocus;
    lblBanco: TLabel;
    edtCodigoBanco: TEditFocus;
    edtNomeBanco: TEditFocus;
    lblChaveRecurso: TLabel;
    edtChaveRecurso: TEditFocus;
    lblRotinaRecurso: TLabel;
    cmbRotinaRecurso: TComboBoxFocus;
    lblAmbienteRecurso: TLabel;
    cmbAmbienteRecurso: TComboBoxFocus;
    grdListaLinksDadosLNK_CODBCO: TcxGridDBColumn;
    grdListaLinksDadosLNK_CHAVE_: TcxGridDBColumn;
    grdListaLinksDadosLNK_URLLNK: TcxGridDBColumn;
    grdListaLinksDadosLNK_ROTINA: TcxGridDBColumn;
    grdListaLinksDadosLNK_TIPAMB: TcxGridDBColumn;
    procedure edtCodigoBancoKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
  private
    FDatasetLista,
    FDatasetListaClone,
    FDatasetCloneAlteracoes: TUniClientDataset;

    FDatasourceLista: TDataSource;

    procedure CarregaDatasets;
    procedure CarregaBanco;
    procedure ClonaDatasetLista;

    procedure LimparCampos;
    procedure CarregaDados;
    procedure BotoesEditando(AEditando: Boolean);

    procedure OnAfterScroll(DataSet: TDataSet);

    function RegistroJaCadastrado: Boolean;
    function HouveAlteracoes: Boolean;

    function GravarAlteracoes: Boolean;
    { Private declarations }
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation
Uses untFuncoesSimples, untConsultas, untTypesSistema;
{$R *.dfm}

procedure TfrmConfiguracoesLinksAPIBancos.BotoesEditando(AEditando: Boolean);
begin
  btnIncluir.Enabled := Not AEditando;
  btnAlterar.Enabled := Not AEditando;
  btnExcluir.Enabled := Not AEditando;
  grdListaLinks.Enabled := Not AEditando;
  btnSair.Enabled := Not AEditando;

  btnGravar.Enabled := AEditando;
  btnCancela.Enabled := AEditando;
  pnlTopo.Enabled := AEditando;

  edtCodigoBanco.Enabled := FDatasetLista.State <> dsEdit;
  edtChaveRecurso.Enabled := FDatasetLista.State <> dsEdit;
end;

procedure TfrmConfiguracoesLinksAPIBancos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If FDatasetLista.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Não existe nenhum registro selecionado utilizar essa função.', ['&Ok']);
    pSetFocus(btnIncluir);
    Exit;
  End;

  FDatasetLista.Edit;
  If Not FDatasetLista.FieldByName('ACAO').AsString.Equals('1') Then
    FDatasetLista.FieldByName('ACAO').AsString := '2';

  BotoesEditando(True);

  pSetFocus(edtLinkRecurso);
end;

procedure TfrmConfiguracoesLinksAPIBancos.btnCancelaClick(Sender: TObject);
begin
  inherited;
  FDatasetLista.Cancel;
  BotoesEditando(False);

  pSetFocus(btnIncluir);
end;

procedure TfrmConfiguracoesLinksAPIBancos.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If FDatasetLista.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO', 'Não existe nenhum registro selecionado utilizar essa função.', ['&Ok']);
    pSetFocus(btnIncluir);
    Exit;
  End;

  If fMensagem('ATENÇÃO', 'Deseja realmente excluir o registro selecionado?' + #13 +
                          'Caso excluia um recurso que esteja sendo utilizado, rotinas pararão de funcionar.' + #13 +
                          'Deseja realmente continuar?', ['&Sim', '&Não']) = 2 Then
    Exit;

  If FDatasetLista.FieldByName('ACAO').AsString.Equals('1') Then
    FDatasetLista.Delete
  Else
  Begin
    FDatasetLista.Edit;
    FDatasetLista.FieldByName('ACAO').AsString := '3';
    FDatasetLista.Post;
  End;
end;

procedure TfrmConfiguracoesLinksAPIBancos.btnGravarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
    Exit;

  If FDatasetLista.State = dsInsert Then
  Begin
    If RegistroJaCadastrado Then
    Begin
      fMensagem('ATENÇÃO', 'Essa Chave de Recurso para esse Banco já está cadastrado na tabela.' + #13 +
                           'Para alterar/cadastrar novamente, deve ser selecionado na lista e realizar a alteração.', ['&Ok']);

      pSetFocus(edtCodigoBanco);
      Exit;
    End;
  End;

  FDatasetLista.FieldByName('LNK_CODBCO').AsString := edtCodigoBanco.Text;
  FDatasetLista.FieldByName('LNK_CHAVE_').AsString := edtChaveRecurso.Text;
  FDatasetLista.FieldByName('LNK_URLLNK').AsString := edtLinkRecurso.Text;
  FDatasetLista.FieldByName('LNK_ROTINA').AsString := cmbRotinaRecurso.Text;
  FDatasetLista.FieldByName('LNK_TIPAMB').AsString := IIF(cmbAmbienteRecurso.ItemIndex = 1, 'H', 'P');
  FDatasetLista.Post;

  ClonaDatasetLista;

  BotoesEditando(False);
end;

procedure TfrmConfiguracoesLinksAPIBancos.btnIncluirClick(Sender: TObject);
begin
  inherited;
  LimparCampos;

  FDatasetLista.Last;
  FDatasetLista.Append;
  FDatasetLista.FieldByName('ACAO').AsString := '1';

  cmbAmbienteRecurso.ItemIndex := 0;

  BotoesEditando(True);

  pSetFocus(edtCodigoBanco);
end;

procedure TfrmConfiguracoesLinksAPIBancos.CarregaBanco;
begin
  edtNomeBanco.Text := fCampoTabela('BCO_NOMBCO', 'CADBCO', ['BCO_CODBCO'], [fStrZero(edtCodigoBanco.Text, 3)]);
end;

procedure TfrmConfiguracoesLinksAPIBancos.CarregaDados;
begin
  LimparCampos;

  If FDatasetLista.IsEmpty Then
    Exit;

  edtCodigoBanco.Text := FDatasetLista.FieldByName('LNK_CODBCO').AsString;
  CarregaBanco;

  edtChaveRecurso.Text := FDatasetLista.FieldByName('LNK_CHAVE_').AsString;
  edtLinkRecurso.Text := FDatasetLista.FieldByName('LNK_URLLNK').AsString;
  cmbAmbienteRecurso.ItemIndex := IIF(FDatasetLista.FieldByName('LNK_TIPAMB').AsString.Equals('P'), 0, 1);
  cmbRotinaRecurso.Text := FDatasetLista.FieldByName('LNK_ROTINA').AsString;
end;

procedure TfrmConfiguracoesLinksAPIBancos.CarregaDatasets;
  Var
    LConsulta: TUniQuery;
begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT LNKBCO.*, ' +
                          'CAST("" AS CHAR(1)) AS ACAO ' +
                          'FROM LNKBCO ' +
                          'ORDER BY LNK_CODBCO, LNK_ROTINA, LNK_TIPAMB, LNK_CHAVE_';
    LConsulta.Open;

    FDatasetLista := fCriaClientDatset(LConsulta);
    FDatasetListaClone := fCriaClientDatset(LConsulta);
    FDatasetCloneAlteracoes := fCriaClientDatset(LConsulta);
    FDatasetLista.Filter := 'ACAO<>''3'' ';
    FDatasetLista.Filtered := True;
    FDatasetLista.Open;
    FDatasetListaClone.Open;
    FDatasetCloneAlteracoes.Open;

    FDatasetLista.AfterScroll := OnAfterScroll;
    FDatasetLista.First;

    FDatasourceLista := fCriaDataSource(FDatasetLista);
    FDatasourceLista.AutoEdit := False;
    grdListaLinksDados.DataController.DataSource := FDatasourceLista;
  Finally
    If Assigned(LConsulta) Then
    Begin
      LConsulta.Close;
      FreeAndNil(LConsulta);
    End;
  End;
end;

procedure TfrmConfiguracoesLinksAPIBancos.ClonaDatasetLista;
  Var
    LprcScroll: TprcScroll;

    LRegistroSelecionado: Array[0..1] Of String;
begin
  LRegistroSelecionado[0] := FDatasetLista.FieldByName('LNK_CODBCO').AsString;
  LRegistroSelecionado[1] := FDatasetLista.FieldByName('LNK_CHAVE_').AsString;

  pDisableControls(FDatasetLista, LprcScroll);
  Try
    FDatasetLista.Filtered := False;
    FDatasetLista.First;

    If Assigned(FDatasetCloneAlteracoes) Then
      FreeAndNil(FDatasetCloneAlteracoes);

    FDatasetCloneAlteracoes := fCriaClientDatset(FDatasetLista);
    FDatasetCloneAlteracoes.Open;
  Finally
    FDatasetLista.Filter := 'ACAO<>''3'' ';
    FDatasetLista.Filtered := True;
    If Not FDatasetLista.Locate('LNK_CODBCO;LNK_CHAVE_', VarArrayOf([LRegistroSelecionado[0], LRegistroSelecionado[1]]), []) Then
      FDatasetLista.First;

    pEnableControls(FDatasetLista, LprcScroll);
  End;
end;

procedure TfrmConfiguracoesLinksAPIBancos.edtCodigoBancoKeyPress(
  Sender: TObject; var Key: Char);
  Var
    arrBancos: TConsultasArray;
begin
  inherited;

  If Not pnlTopo.Enabled Then
    Exit;

  {*******************************}
  {* NOVA CONSULTA DE BANCOS     *}
  {****************************RV*}
  If fPesqBanco(Self, edtCodigoBanco, edtNomeBanco, qryTabela, Key, arrBancos) Then
  Begin
    if fValidaCampos(edtCodigoBanco, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfiguracoesLinksAPIBancos.FormClose(Sender: TObject;
  var Action: TCloseAction);
  Var
    LResposta: Integer;

    LprcScroll: TprcScroll;
begin
  inherited;
  If FDatasetLista.State In [dsInsert, dsEdit] Then
  Begin
    fMensagem('ATENÇÃO', 'Existe registro em inclusão/alteração. Confirme ou cancele o registro antes de sair.', ['&Ok']);
    Action := CaNone;
    Exit;
  End;

  pDisableControls(FDatasetLista, LprcScroll);
  Try
    If Not HouveAlteracoes Then
      Exit;

    LResposta := fMensagem('ATENÇÃO', 'Deseja confirmar as alterações realizadas nos links de API dos Bancos?', ['&Sim', '&Não', '&Cancelar']);

    Case LResposta Of
      1:
      Begin
        If Not GravarAlteracoes Then
          Action := CaNone;
      End;
      3:
      Begin
        FDatasetLista.First;
        FDatasetLista.Filter := 'ACAO<>''3'' ';
        FDatasetLista.Filtered := True;
        Action := CaNone;
      End;
    End;
  Finally
    If Action = CaNone Then
      pEnableControls(FDatasetLista, LprcScroll);
  End;
end;

procedure TfrmConfiguracoesLinksAPIBancos.FormDestroy(Sender: TObject);
begin
  If Assigned(FDatasourceLista) Then
    FreeAndNil(FDatasourceLista);

  If Assigned(FDatasetLista) Then
    FreeAndNil(FDatasetLista);

  If Assigned(FDatasetListaClone) Then
    FreeAndNil(FDatasetListaClone);

  If Assigned(FDatasetCloneAlteracoes) Then
    FreeAndNil(FDatasetCloneAlteracoes);

  inherited;
end;

procedure TfrmConfiguracoesLinksAPIBancos.FormShow(Sender: TObject);
begin
  CarregaDatasets;

  inherited;
  BotoesEditando(False);
  CarregaDados;
end;

function TfrmConfiguracoesLinksAPIBancos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtCodigoBanco) Then
    Begin
      If fEmptyStr(edtCodigoBanco.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Banco deve ser preenchido!', ['&OK']);
        Result := False;
      End
      Else
      Begin
        CarregaBanco;
        If Trim(edtNomeBanco.Text).IsEmpty Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Banco não está cadastrado!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If Sender = edtChaveRecurso Then
    Begin
      If fEmptyStr(edtChaveRecurso.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Chave do Recurso deve ser preenchida!', ['&OK']);
        Result := False;
      End;
    End

    Else If Sender = edtLinkRecurso Then
    Begin
      If fEmptyStr(edtLinkRecurso.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Link do Recurso deve ser preenchido!', ['&OK']);
        Result := False;
      End;
    End

    Else If Sender = cmbRotinaRecurso Then
    Begin
      If fEmptyStr(cmbRotinaRecurso.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Rotina do Recurso deve ser selecionado/preenchido!', ['&OK']);
        Result := False;
      End;
    End

    Else If Sender = cmbAmbienteRecurso Then
    Begin
      If cmbAmbienteRecurso.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO!', 'O Ambiente do Recurso deve ser selecionado!', ['&OK']);
        Result := False;
      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmConfiguracoesLinksAPIBancos.GravarAlteracoes: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := False;

  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Text := 'SELECT * FROM LNKBCO';
    LConsulta.Open;

    FDatasetLista.Filter := 'ACAO<>'''' ';
    FDatasetLista.Filtered := True;

    FDatasetLista.First;
    Try
      fStartTransaction;
      While Not FDatasetLista.Eof Do
      Begin
        If MatchStr(FDatasetLista.FieldByname('ACAO').AsString, ['2', '3']) Then
        Begin
          If Not LConsulta.Locate('LNK_CODBCO;LNK_CHAVE_',
                                  VarArrayOf([FDatasetLista.FieldByName('LNK_CODBCO').AsString,
                                  FDatasetLista.FieldByName('LNK_CHAVE_').AsString]), []) Then
            Raise ExceptionAutcom.Create('Registro que foi alterado não está mais na tabela. Recarregue os dados.');
        End;

        If FDatasetLista.FieldByname('ACAO').AsString.Equals('3') Then
        Begin
          LConsulta.Delete;
          FDatasetLista.Next;
          Continue;
        End;

        If FDatasetLista.FieldByname('ACAO').AsString.Equals('1') Then
        Begin
          LConsulta.Last;
          LConsulta.Append;
          LConsulta.FieldByName('LNK_CODBCO').AsString := FDatasetLista.FieldByName('LNK_CODBCO').AsString;
          LConsulta.FieldByName('LNK_CHAVE_').AsString := FDatasetLista.FieldByName('LNK_CHAVE_').AsString;
        End
        Else
          LConsulta.Edit;

        LConsulta.FieldByName('LNK_URLLNK').AsString := FDatasetLista.FieldByName('LNK_URLLNK').AsString;
        LConsulta.FieldByName('LNK_ROTINA').AsString := FDatasetLista.FieldByName('LNK_ROTINA').AsString;
        LConsulta.FieldByName('LNK_TIPAMB').AsString := FDatasetLista.FieldByName('LNK_TIPAMB').AsString;
        LConsulta.Post;

        FDatasetLista.Next;
      End;

      fCommit;

      Result := True;
    Except
      On E: Exception Do
      Begin
        fRollBack;

        If E Is ExceptionAutCom Then
          fMensagem('ATENÇÃO', E.Message, ['&Ok'])
        Else
          pMensagensErro(E.Message, '[TfrmConfiguracoesLinksAPIBancos.GravarAlteracoes]');

        FDatasetLista.Filter := 'ACAO<>''3'' ';
      End;
    End;
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TfrmConfiguracoesLinksAPIBancos.HouveAlteracoes: Boolean;
begin
  Try
    FDatasetLista.Filtered := False;
    FDatasetLista.Filter := 'ACAO<>'''' ';
    FDatasetLista.Filtered := True;

    Result := Not FDatasetLista.IsEmpty;
  Finally
    FDatasetLista.Filter := 'ACAO<>''3'' ';
    FDatasetLista.Filtered := True;
  End;
end;

procedure TfrmConfiguracoesLinksAPIBancos.LimparCampos;
begin
  edtLinkRecurso.Clear;
  edtCodigoBanco.Clear;
  edtNomeBanco.Clear;
  edtChaveRecurso.Clear;
  cmbRotinaRecurso.ItemIndex := -1;
  cmbAmbienteRecurso.ItemIndex := -1;
end;

procedure TfrmConfiguracoesLinksAPIBancos.OnAfterScroll(DataSet: TDataSet);
begin
  CarregaDados;
end;

function TfrmConfiguracoesLinksAPIBancos.RegistroJaCadastrado: Boolean;
begin
  Result := FDatasetListaClone.Locate('LNK_CODBCO;LNK_CHAVE_',
                                      VarArrayOf([edtCodigoBanco.Text, edtChaveRecurso.Text]), []);

  If Not Result Then
    Result := FDatasetCloneAlteracoes.Locate('LNK_CODBCO;LNK_CHAVE_',
                                             VarArrayOf([edtCodigoBanco.Text, edtChaveRecurso.Text]), []);
end;

end.
