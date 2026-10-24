unit untCadDescontoClienteProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, Provider, Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGrids, ComCtrls, Buttons, BitBtnLockedIncrem,
  ExtCtrls, DBCtrls, DBEditFocus, untPaiOrdenaEdit, DBMemoFocus, Gauges,
  cxProgressBar, UniClientDataSet, UniDataSetProvider, MemDS, DBAccess,
  frxClass, frxExportCSVTestabilidade, DBGridCitel, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, untTypesSistema;

type
  TTypeGlobal = (tgAlterar, tgExcluir);

  TfrmCadDescontoClienteProduto = class(TfrmPaiOrdenaEdit)
    Label24: TLabel;
    dbeCodIte: TDBEditFocus;
    cdsConsultaAUTOINCREM: TStringField;
    pnlCliente: TPanel;
    Label4: TLabel;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    cdsConsultaPDS_CODCLI: TStringField;
    cdsConsultaPDS_CODITE: TStringField;
    cdsConsultaITE_DESITE: TStringField;
    cdsConsultaUNI_SIGUNI: TStringField;
    cdsConsultaPDS_CODEMP: TStringField;
    Label5: TLabel;
    dbePerDes: TDBEditFocus;
    dbeDesIte: TDBEditFocus;
    lbl1: TLabel;
    dbeSigUni: TDBEditFocus;
    lbl2: TLabel;
    cdsConsultaPDS_PERDES: TFloatField;
    btnImpABC: TBitBtnLocked;
    btnPesquisaDesc: TBitBtnLocked;
    grdProdutos: TcxGridCitel;
    grdProdutosTv: TcxGridDBTableViewCitel;
    grdProdutoCodIte: TcxGridDBColumn;
    grdProdutoDesIte: TcxGridDBColumn;
    grdProdutosLvl: TcxGridLevel;
    grdProdutoSigUni: TcxGridDBColumn;
    grdProdutoPerDes: TcxGridDBColumn;
    btnAlteracaoGlobal: TBitBtnLocked;
    btnExclusaoGlobal: TBitBtnLocked;
    Label2: TLabel;
    mskLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbePerDesKeyPress(Sender: TObject; var Key: Char);
    procedure cdsConsultaReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure btnImpABCClick(Sender: TObject);
    procedure btnPesquisaDescClick(Sender: TObject);
    procedure grdProdutosTvDblClick(Sender: TObject);
    procedure btnAlteracaoGlobalClick(Sender: TObject);
    procedure btnExclusaoGlobalClick(Sender: TObject);
    procedure mskLinGruExit(Sender: TObject);
    procedure mskLinGruKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    cdsAuxCad: TUniClientDataSet;
    arrProdutos,
    arrGrupos: TConsultasArray;

    procedure pAbreConsulta;
    procedure pHabilitarTela(blnDigitarCliente: Boolean);
    procedure pFecharTabela;
    function fSalvarDesconto: Boolean;
    function fImportarProdutosABC(pgbStatus: TCxProgressBar): Boolean;

    function fAlterarGlobal(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fExcluirGlobal(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fValidarDados(const tgTipo: TTypeGlobal): Boolean;

    procedure pLancamentoProdutos; overload;
    function fLancamentoProdutos(pgbStatus: TcxProgressBar = Nil): Boolean;

    procedure pCarregarProdutosLinhaGrupo;
    procedure pLimparLinhaGrupo;
  protected
    function fGetSql(blnLike: Boolean): String;override;
    function fGetOrderBy: String; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    //procedure pOnStateChange;override;
    procedure pHabilitaControles(Habilitar:Boolean);override;
  public
    { Public declarations }
  end;


implementation

uses untPaiOrdena, untFuncoesSimples,  untConstantes, untConsultas,
  untCadDescontoClienteProdutoSelecionaItens, untFuncoes, untGravando,
  untAlteracaoGlobalDescontoProdutos, untFuncoesConsulta;

{$R *.dfm}

function TfrmCadDescontoClienteProduto.fGetSql(blnLike: Boolean): String;
begin
  Result := ' SELECT ' +
            '   PRODES.*, ' +
            '   (SELECT ITE_DESITE FROM CADITE WHERE ITE_CODITE = PDS_CODITE) AS ITE_DESITE, ' +
            '   (SELECT UNI_SIGUNI FROM CADITE INNER JOIN CADUNI ON ITE_CODUNI = UNI_CODUNI WHERE ITE_CODITE = PDS_CODITE) AS UNI_SIGUNI ' +
            ' FROM ' +
            '   PRODES ' +
            ' WHERE ' +
            '   PDS_CODCLI = ' + QuotedStr(edtCodCli.Text);
end;

function TfrmCadDescontoClienteProduto.fAlterarGlobal(
  pgbStatus: TcxProgressBar): Boolean;
var
  intEtapa,
  intMaximo       : Integer;
  fltPercDesconto : Double;
  frmAlteracao    : TfrmAlteracaoGlobalDescontoProdutos;
begin
  Try
    pCriarFormularios(TfrmAlteracaoGlobalDescontoProdutos, frmAlteracao);
    frmAlteracao.ShowModal;

    fltPercDesconto := frmAlteracao.fltPercDesconto;
  Finally
    pFreeAndNil(frmAlteracao);
  End;

  If (fltPercDesconto <= 0) or (fltPercDesconto > 100) Then
  Begin
    fMensagem('ATENÇÃO!', 'Atenção! Só é permitido informar um desconto maior ' +
                          'que zero e um desconto até 100%.', ['&Ok']);
    Exit(False);
  End;

  Try
    cdsConsulta.DisableControls;

    intEtapa  := 0;
    intMaximo := cdsConsulta.RecordCount;

    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      pInformacao('Aguarde, aplicando o desconto nos itens', pgbStatus);
      pProgresso(fInc(intEtapa), intMaximo, pgbStatus);

      cdsConsulta.Edit;
      cdsConsultaPDS_PERDES.AsFloat := fltPercDesconto;
      cdsConsulta.Post;
      cdsConsulta.ApplyUpdates(0);

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.EnableControls;
  End;

  Result := True;
end;

function TfrmCadDescontoClienteProduto.fExcluirGlobal(
  pgbStatus: TcxProgressBar): Boolean;
var
  intEtapa,
  intMaximo : Integer;
begin
  Try
    intEtapa  := 0;
    intMaximo := cdsConsulta.RecordCount;

    cdsConsulta.DisableControls;

    While cdsConsulta.RecordCount > 0 Do
    Begin
      pInformacao('Aguarde, excluindo os itens e descontos do cliente '+edtCodCli.Text, pgbStatus);
      pProgresso(fInc(intEtapa), intMaximo, pgbStatus);

      cdsConsulta.First;
      cdsConsulta.Delete;
      cdsConsulta.ApplyUpdates(0);
    End;
  Finally
    cdsConsulta.EnableControls;
  End;

  Result := True;
end;

function TfrmCadDescontoClienteProduto.fGetOrderBy: String;
begin
  Result := ' ORDER BY ITE_DESITE ';
end;

procedure TfrmCadDescontoClienteProduto.btnAlteracaoGlobalClick(
  Sender: TObject);
Var
  LfrmAguarde: TfrmGravando;
begin
  inherited;

  If Not fValidarDados(tgAlterar) Then
    Exit;

  Try
    Try
      pCriarFormularios(TfrmGravando, LfrmAguarde);
      LfrmAguarde.fExecutarAcao := fAlterarGlobal;
      LfrmAguarde.ShowModal;

      If LfrmAguarde.blnConfirma Then
      Begin
        fMensagem('ATENÇÃO!', 'Desconto atualizado para todos os produtos.', ['&Ok']);
        pSetFocus(edtCodCli);
      End;
    Finally
      pFreeAndNil(LfrmAguarde);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCadDescontoClienteProduto.btnAlterarClick(Sender: TObject);
begin
  pCloneDataSet(cdsAuxCad, cdsConsulta);
  cdsAuxCad.IndexFieldNames := 'PDS_CODITE';
  inherited;
end;

procedure TfrmCadDescontoClienteProduto.btnExcluirClick(Sender: TObject);
begin
  inherited;
  If blnExcluiu Then
    fSalvarDesconto;
end;

procedure TfrmCadDescontoClienteProduto.btnExclusaoGlobalClick(Sender: TObject);
Var
  LfrmAguarde: TfrmGravando;
begin
  inherited;

  If Not fValidarDados(tgExcluir) Then
    Exit;

  If fMensagem('', 'Deseja realmente excluir todos os produtos e descontos '+
                   'que estão vinculados ao cliente '+edtCodCli.Text+'?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  Try
    Try
      pCriarFormularios(TfrmGravando, LfrmAguarde);
      LfrmAguarde.fExecutarAcao := fExcluirGlobal;
      LfrmAguarde.ShowModal;

      If LfrmAguarde.blnConfirma Then
      Begin
        fMensagem('ATENÇÃO!', 'Produtos e descontos excluídos com sucesso.', ['&Ok']);
        pSetFocus(edtCodCli);
      End;
    Finally
      pFreeAndNil(LfrmAguarde);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCadDescontoClienteProduto.btnGravarClick(Sender: TObject);
begin
  inherited;
  If blnGravou Then
    fSalvarDesconto;
end;

function TfrmCadDescontoClienteProduto.fSalvarDesconto: Boolean;
begin
  Try
    If (cdsConsulta.ChangeCount > 0)  Then
      Result := cdsConsulta.ApplyUpdates(0) = 0
    Else
      Result := True;
  Except
    On E: ExceptionAutCom Do
    Begin
      pMensagensErro(E.Message, '[TZClient.fSalva]');
      Result := False;
    End;

    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TZClient.fSalva]');
      Result := False;
    End;
  End;
end;

procedure TfrmCadDescontoClienteProduto.btnImpABCClick(Sender: TObject);
begin
  inherited;
  If Not (btnImpABC.Enabled And pnlBotoes.Enabled) Then
    Exit;

  Try
    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fImportarProdutosABC;
    frmGravando.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmGravando);
end;

function TfrmCadDescontoClienteProduto.fImportarProdutosABC(pgbStatus: TCxProgressBar): Boolean;
  Var
    strItem: String;
    frmCadDescontoClienteProdutoSelecionaItens : TfrmCadDescontoClienteProdutoSelecionaItens;
begin
  Try
    pCriarFormularios(TfrmCadDescontoClienteProdutoSelecionaItens, frmCadDescontoClienteProdutoSelecionaItens);

    TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := 'Aguarde, Inserindo produtos...';

    If frmCadDescontoClienteProdutoSelecionaItens.ShowModal = mrOk Then
    Begin
      pgbStatus.Properties.Max := Length(frmCadDescontoClienteProdutoSelecionaItens.arrItensSelecionados);
      pgbStatus.Position := 0;

      For strItem In frmCadDescontoClienteProdutoSelecionaItens.arrItensSelecionados Do
      Begin
        pgbStatus.Position := pgbStatus.Position + 1;
        Application.ProcessMessages;

        If Not cdsConsulta.Locate('PDS_CODITE', strItem, []) Then
          btnIncluir.Click
        Else
          btnAlterar.Click;

        dbeCodIte.Field.AsString := strItem;
        dbePerDes.Field.AsFloat  := frmCadDescontoClienteProdutoSelecionaItens.fltPercentualDesconto;

        btnGravar.Click;
      End;
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;

  pFreeAndNil(frmCadDescontoClienteProdutoSelecionaItens);
end;

function TfrmCadDescontoClienteProduto.fLancamentoProdutos(
  pgbStatus: TcxProgressBar): Boolean;
var
  intContador,
  intEtapa,
  intMaximo       : Integer;
  fltPercDesconto : Double;
  frmAlteracao    : TfrmAlteracaoGlobalDescontoProdutos;
begin
  Try
    pCriarFormularios(TfrmAlteracaoGlobalDescontoProdutos, frmAlteracao);
    frmAlteracao.ShowModal;

    fltPercDesconto := frmAlteracao.fltPercDesconto;
  Finally
    pFreeAndNil(frmAlteracao);
  End;

  If (fltPercDesconto <= 0) or (fltPercDesconto > 100) Then
  Begin
    fMensagem('ATENÇÃO!', 'Atenção! Só é permitido informar um desconto maior ' +
                          'que zero e um desconto até 100%.', ['&Ok']);
    Exit(False);
  End;

  Try
    cdsConsulta.DisableControls;

    intEtapa  := 0;
    intMaximo := Length(arrProdutos);

    btnCancela.Click;
    For intContador := 0 to Pred(Length(arrProdutos)) Do
    Begin
      pInformacao('Aguarde, aplicando o desconto nos itens', pgbStatus);
      pProgresso(fInc(intEtapa), intMaximo, pgbStatus);

      If Not cdsConsulta.Locate('PDS_CODITE', arrProdutos[intContador].strCodigo, []) Then
      Begin
        cdsConsulta.Append;
        cdsConsultaAUTOINCREM.AsString := fRetAutoIncrem('PRODES', VS_strCodEmp);
        cdsConsultaPDS_CODEMP.AsString := VS_strCodEmp;
        cdsConsultaPDS_CODCLI.AsString := edtCodCli.Text;
        cdsConsultaPDS_CODITE.AsString := arrProdutos[intContador].strCodigo;
        cdsConsultaITE_DESITE.AsString := fRetNomProduto(arrProdutos[intContador].strCodigo);
        cdsConsultaUNI_SIGUNI.AsString := fRetSiglaUni(fRetUnidadeItem(arrProdutos[intContador].strCodigo));
        cdsConsultaPDS_PERDES.AsFloat  := fltPercDesconto;
        cdsConsulta.Post;

        cdsConsulta.ApplyUpdates(0);
      End;
    End;
  Finally
    cdsConsulta.Last;
    cdsConsulta.EnableControls;
  End;

  Result := True;
end;

procedure TfrmCadDescontoClienteProduto.btnIncluirClick(Sender: TObject);
begin
  pCloneDataSet(cdsAuxCad, cdsConsulta);
  cdsAuxCad.IndexFieldNames := 'PDS_CODITE';
  inherited;
  cdsConsultaPDS_CODCLI.AsString := edtCodCli.Text;
  cdsConsultaPDS_CODEMP.AsString := VS_strCodEmp;
  cdsConsultaAUTOINCREM.AsString := fRetAutoIncrem('PRODES', VS_strCodEmp);

  pLimparLinhaGrupo;
end;

procedure TfrmCadDescontoClienteProduto.btnPesquisaDescClick(Sender: TObject);
begin
  inherited;

  pAbreConsulta; 
end;

procedure TfrmCadDescontoClienteProduto.cdsConsultaReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
  Action := raAbort;
  Raise ExceptionAutCom.Create(E.Message);
end;

procedure TfrmCadDescontoClienteProduto.dbePerDesKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If CharInSet(Key, ['-', '+', '.']) Then Key := #0;
end;

procedure TfrmCadDescontoClienteProduto.dbeCodIteKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqItem(conIteSimples, Self, dbeCodIte, nil, Nil, Key, arrProdutos,
               False,                {* Consulta Simples ou Múltipla (multi select) *}
               Nil,                {* Painel                                      *}
               'Consulta de Itens',
               '1') Then    // Tabela de Preço
  Begin
    If Length(arrProdutos) > 1 Then
      pLancamentoProdutos
    Else
      fValidaCampos(dbeCodIte, True);
  End;
end;

procedure TfrmCadDescontoClienteProduto.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    fValidaCampos(edtCodCli, True);
  End;
end;

procedure TfrmCadDescontoClienteProduto.FormCreate(Sender: TObject);
begin
  inherited;
  strCamChave  := 'AUTOINCREM';
  blnTemSelecao := False;
  blnSelecionaComEspaco := False;
  blnUsaProxCodVirtual := False;
  cdsAuxCad := TUniClientDataSet.Create(Self);
end;

procedure TfrmCadDescontoClienteProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_ESCAPE) And
     ((ActiveControl) <> edtCodCli) And
     (Not (cdsConsulta.State In [dsInsert, dsEdit])) Then
  Begin
    pHabilitarTela(True);
    Key := 0;
  End
  Else If Key = VK_F2 Then
  Begin
    btnAlteracaoGlobal.Click;
    Key := 0;
  End
  Else If Key = VK_F3 Then
  Begin
    btnExclusaoGlobal.Click;
    Key := 0;
  End
  Else If Key = VK_F5 Then
  Begin
    Key := 0;
  End
  Else If Key = VK_F7 Then
  Begin
    btnImpABC.Click;
    Key := 0;
  End
  Else If (grdProdutosTv.Focused) And (cdsConsulta.Active) And (cdsConsulta.RecordCount > 0) And (Key In [VK_RETURN, VK_DELETE]) Then
  begin
    Case Key Of
      VK_RETURN:
        begin
          If btnAlterar.Visible And btnAlterar.Enabled Then
            btnAlterar.Click;
        end;
      VK_DELETE:
        begin
          If btnExcluir.Visible And btnExcluir.Enabled Then
            btnExcluir.Click;
        end;
    End;
  End
  Else
    inherited;
end;

procedure TfrmCadDescontoClienteProduto.FormShow(Sender: TObject);
begin
  inherited;
  pHabilitarTela(True);

  pSetaCodIte(dbeCodIte);
  pSetaCodIte(cdsConsultaPDS_CODITE);

end;

function TfrmCadDescontoClienteProduto.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
begin      
  Result := True;

  If inherited fValidaCampos(Sender, blnBuscaPorChave) Then
  Begin
    If (Sender = dbeCodIte) Then
    Begin
      If fEmptyStr(dbeCodIte.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o código do produto!', ['&Ok']);
        Result := False;
      End
      Else If fEmptyStr(fRetNomProduto(dbeCodIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Código do produto não existe!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        cdsAuxCad.Open;
        If (cdsAuxCad.Locate('PDS_CODITE', dbeCodIte.Text, [])) And  
           ((IfNull(cdsConsultaPDS_CODITE.OldValue, '') <> dbeCodIte.Text) Or (cdsConsulta.State = dsInsert)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Código do produto já utilizado!', ['&Ok']);
          Result := False;
        End
        Else
        Begin
          dbeDesIte.Field.AsString := fRetNomProduto(dbeCodIte.Text);
          dbeSigUni.Field.AsString := fRetSiglaUni(fRetUnidadeItem(dbeCodIte.Text));
        End;
      End;
    End

    Else If (Sender = edtCodCli) And blnBuscaPorChave Then
    Begin
      edtNomCli.Text := fRetNomCliente(edtCodCli.Text);
      If fEmptyStr(edtCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o código do cliente!', ['&Ok']);
        Result := False;
      End
      Else If fEmptyStr(edtNomCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Código do cliente não existe!', ['&Ok']);
        Result := False;
      End
      Else
        pHabilitarTela(False);
    End

    Else If (Sender = dbePerDes) Then
    Begin
      If fStrToFloat(dbePerDes.Text) <= 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o percentual de desconto corretamente!', ['&Ok']);
        Result := False;
      End
      Else If Not fValidaEscala(dbePerDes.Text, 0, 100) Then
      Begin
        fMensagem('ATENÇÃO!', 'Informe o percentual de desconto corretamente!', ['&Ok']);
        Result := False;
      End;
    End;

  End;

  If (Not Result) And (Sender.CanFocus) Then
    pSetFocus(Sender)

end;

function TfrmCadDescontoClienteProduto.fValidarDados(
  const tgTipo: TTypeGlobal): Boolean;
var
  txtTexto: String;
begin
  Result := True;

  If fEmptyStr(edtCodCli.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe o código do cliente.', ['&Ok']);
    Result := False;
  End;

  If (Result) And
     ((Not cdsConsulta.Active) or (cdsConsulta.RecordCount = 0)) Then
  Begin
    If tgTipo = tgAlterar Then
      txtTexto := 'alteração'
    Else If tgTipo = tgExcluir Then
      txtTexto := 'exclusão';

    fMensagem('ATENÇÃO!', 'Para utilizar a '+txtTexto+' global é preciso ter produtos '+
                          'inseridos no grid.', ['&Ok']);
    Result := False;
  End;
end;

procedure TfrmCadDescontoClienteProduto.grdProdutosTvDblClick(Sender: TObject);
Var
  Key: Word;
begin
  inherited;
  Key := VK_RETURN;
  FormKeyDown(dbgConsulta, Key, [ssShift]);
end;

procedure TfrmCadDescontoClienteProduto.mskLinGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinGru, edtDesGru, arrGrupos, fRetNomeLinhaGrupo, Nil, 'da linha/grupo', 6);

  If not fEmptyStr(mskLinGru.Text) Then
    pCarregarProdutosLinhaGrupo;

end;

procedure TfrmCadDescontoClienteProduto.mskLinGruKeyPress(Sender: TObject;
  var Key: Char);
  Var
    blnUsaArray: Boolean;
begin
  inherited;

  blnUsaArray := Length(arrGrupos) > 1;

  If fPesqGrupo(Self, mskLinGru, edtDesGru, Nil, Key, arrGrupos, blnUsaArray) Then
  Begin
    If fValidaCampos(mskLinGru, True) Then
      SelectNext(ActiveControl, True, True);

  End;
end;

procedure TfrmCadDescontoClienteProduto.pHabilitarTela(blnDigitarCliente: Boolean);
begin
  dbgConsulta.Enabled := False;

  pLimpaPesquisa;
  blnMudarFoco        := False;
  pnlCliente.Enabled  := blnDigitarCliente;
  pnlHeader.Enabled   := not blnDigitarCliente;
  pnlPesquisa.Enabled := not blnDigitarCliente;
  pnlBotoes.Enabled   := not blnDigitarCliente;
  grdProdutos.Enabled := not blnDigitarCliente;

  If blnDigitarCliente Then
  Begin
    pFecharTabela;
    edtCodCli.Clear;
    edtNomCli.Clear;
    SelectFirst;
  End
  Else
    pIniciaPesquisa;
end;

procedure TfrmCadDescontoClienteProduto.pLancamentoProdutos;
Var
  LfrmAguarde: TfrmGravando;
begin
  inherited;

  Try
    Try
      pCriarFormularios(TfrmGravando, LfrmAguarde);
      LfrmAguarde.fExecutarAcao := fLancamentoProdutos;
      LfrmAguarde.ShowModal;

      If LfrmAguarde.blnConfirma Then
      Begin
        fMensagem('ATENÇÃO!', 'Desconto atualizado para todos os produtos.', ['&Ok']);
        pSetFocus(edtCodCli);
      End;
    Finally
      pFreeAndNil(LfrmAguarde);
    End;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
end;

procedure TfrmCadDescontoClienteProduto.pLimparLinhaGrupo;
begin
  mskLinGru.Clear;
  edtDesGru.Clear;
end;

{procedure TfrmCadDescontoClienteProduto.pOnStateChange;
begin
  inherited;
  btnImpABC.Enabled := (cdsConsulta.State = dsBrowse);
end;}

procedure TfrmCadDescontoClienteProduto.pAbreConsulta;
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  chrKey := '/';
  If fPesqDescClienteProduto(Self, edtCodCli, NIL, chrKey, arrSel) Then
  Begin
    fValidaCampos(edtCodCli, True);
  End;
end;

procedure TfrmCadDescontoClienteProduto.pCarregarProdutosLinhaGrupo;
  Var
    qryGrupo: TUniQuery;
begin

  qryGrupo := fCriaQuery;

  Try

    qryGrupo.Close;
    qryGrupo.SQL.Clear;

    qryGrupo.SQL.Add('SELECT ');
    qryGrupo.SQL.Add('  ITE_CODITE ');
    qryGrupo.SQL.Add('FROM   ');
    qryGrupo.SQL.Add('  CADITE ');
    qryGrupo.SQL.Add('WHERE  ');
    qryGrupo.SQL.Add('  ITE_CODGRU IN (' + fArrCodigosToLista(mskLinGru.Text, arrGrupos) + ')');

    qryGrupo.Open;

    SetLength(arrProdutos, 0);
    While not qryGrupo.Eof Do
    Begin
      SetLength(arrProdutos, Length(arrProdutos) + 1);
      arrProdutos[Length(arrProdutos) - 1].strCodigo := qryGrupo.FieldByName('ITE_CODITE').AsString;

      qryGrupo.Next;
    End;

  Finally
    FreeAndNil(qryGrupo);
  End;

  If Length(arrProdutos) > 1 Then
    pLancamentoProdutos
  Else
  Begin
    fMensagem('ATENÇÃO!', 'Não foram encontrado produtos para a Linha/Grupo informada: ' + edtDesGru.Text + '.', ['&Ok']);
    pLimparLinhaGrupo;
  End;

end;

procedure TfrmCadDescontoClienteProduto.pFecharTabela;
begin
  qryConsulta.Close;
  cdsConsulta.Close;
end;

procedure TfrmCadDescontoClienteProduto.pHabilitaControles(Habilitar:Boolean);
begin
  inherited pHabilitaControles(Habilitar);
  edtCodCli.Enabled := True;
  edtNomCli.Enabled := True;
end;

end.
