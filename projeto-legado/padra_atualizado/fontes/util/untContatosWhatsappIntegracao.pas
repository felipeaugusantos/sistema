unit untContatosWhatsappIntegracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, EditFocus,
  Vcl.DBCtrls, DBEditFocus, UniClientDataSet, Data.DB, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Uni, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxProgressBar;

type
  TfrmContatosWhatsappIntegracao = class(TfrmPaiConfirma)
    gpbFiltros: TGroupBox;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    Label6: TLabel;
    lblDtaCad: TLabel;
    lblCidade: TLabel;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    edtUF: TEditFocus;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    lblVendedor: TLabel;
    lblRepresentante: TLabel;
    edtNomRep: TEditFocus;
    edtCodRep: TEditFocus;
    lblRegiao: TLabel;
    edtCodReg: TEditFocus;
    edtNomReg: TEditFocus;
    lblCliente: TLabel;
    edtCodCli: TEditFocus;
    edtDesCli: TEditFocus;
    lblSubRegiao: TLabel;
    edtNomSub: TEditFocus;
    edtCodSub: TEditFocus;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    lblCodEmp: TLabel;
    btnFiltrar: TBitBtnLocked;
    gpbOpcoes: TGroupBox;
    chkAgente: TCheckBox;
    btnCadCli: TBitBtnLocked;
    btnCadOpe: TBitBtnLocked;
    cxgContatos: TcxGridCitel;
    cxgClientesDBTableView: TcxGridDBTableViewCitel;
    cxgContatosClientesDBTableView: TcxGridDBTableViewCitel;
    cxgClientes: TcxGridLevel;
    cxgContatosClientes: TcxGridLevel;
    cxgClientesMARDES: TcxGridDBColumn;
    cxgContatosMARDES: TcxGridDBColumn;
    cxgClientesNOMCTT: TcxGridDBColumn;
    cxgClientesCODCLI: TcxGridDBColumn;
    cxgClientesCELULA: TcxGridDBColumn;
    cxgClientesVENDED: TcxGridDBColumn;
    cxgClientesSITUAC: TcxGridDBColumn;
    cxgContatosAUTINC: TcxGridDBColumn;
    cxgContatosCODCLI: TcxGridDBColumn;
    cxgContatosNOMCTT: TcxGridDBColumn;
    cxgContatosCELULA: TcxGridDBColumn;
    cxgContatosSITUAC: TcxGridDBColumn;
    cxgContatosVENDED: TcxGridDBColumn;
    btnMarcaTodos: TBitBtnLocked;
    btnDesmarcaTodos: TBitBtnLocked;
    lblPessoa: TLabel;
    rdbTodos: TRadioButton;
    rdbFisica: TRadioButton;
    rdbJuridica: TRadioButton;
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSubKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnCadCliClick(Sender: TObject);
    procedure btnCadOpeClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure chkAgenteClick(Sender: TObject);
    procedure cxgClientesDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgContatosClientesDBTableViewCustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure cxgContatosClientesDBTableViewDblClick(Sender: TObject);
    procedure cxgClientesDBTableViewDblClick(Sender: TObject);
    procedure cxgClientesDBTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cxgContatosClientesDBTableViewKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure btnMarcaTodosClick(Sender: TObject);
    procedure btnDesmarcaTodosClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    cdsCadCli,
    cdsCliCtt,
    cdsMantemSelecionados: TUniClientDataSet;

    dtsCadCli,
    dtsCliCtt: TDataSource;

    procedure pCarregaContatos;
    procedure pAlimentaCds(cds: TUniClientDataSet; qryDados, qryDadosAgente: TUniQuery);
    function fRetSqlCadCli: String;
    function fRetSqlCliCtt: String;
    function fRetWhereDataCadastro: String;
    function fRetWhereCliente: String;
    function fRetWhereCidade: String;
    function fRetWhereVendedor: String;
    function fRetWhereRepresentante: String;
    function fRetWhereRegiao: String;
    function fRetWhereSubRegiao: String;
    function fRetWhereEmpresaCadastro: String;
    function fRetWherePessoa: String;
    procedure pSeleciona(cds: TUniClientDataSet; strMarDes: String = '');
    function fMarcaTodos(pgbStatus: TcxProgressBar): Boolean;
    function fMarca(cds: TUniClientDataSet; pgbStatus: TcxProgressBar): Boolean;
    function fDesmarcaTodos(pgbStatus: TcxProgressBar): Boolean;
    function fDesmarca(cds: TUniClientDataSet; pgbStatus: TcxProgressBar): Boolean;
    procedure pMantemSelecionados;
    procedure pGravaSelecionados(cds: TUniClientDataSet);
    procedure pVerificaSelecionados;
    procedure pCriarCds;
    procedure pEnviaContatos;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untQualiZapAddOrEditContact, untConsultas, untTypesSistema,
  untCadClientes, untCadOperadores, untGravando, untConstantes;

procedure TfrmContatosWhatsappIntegracao.FormCreate(Sender: TObject);
begin
  inherited;
  dtsCadCli := fCriaDataSource(cdsCadCli);
  cxgClientesDBTableView.DataController.DataSource := dtsCadCli;

  dtsCliCtt := fCriaDataSource(cdsCliCtt);
  cxgContatosClientesDBTableView.DataController.DataSource := dtsCliCtt;

  cdsMantemSelecionados := TUniClientDataSet.Create(Self);
  cdsMantemSelecionados.FieldDefs.Add('TABELA'     , ftString, 006);
  cdsMantemSelecionados.FieldDefs.Add('AUTOINCREM' , ftString, 020);
  cdsMantemSelecionados.CreateDataSet;
end;

procedure TfrmContatosWhatsappIntegracao.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(dtsCadCli);
  FreeAndNil(dtsCliCtt);

  FreeAndNil(cdsMantemSelecionados);

  if Assigned(cdsCadCli) then
    FreeAndNil(cdsCadCli);

  if Assigned(cdsCliCtt) then
    FreeAndNil(cdsCliCtt);
end;

procedure TfrmContatosWhatsappIntegracao.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F3: if Shift = [ssCtrl] then
             btnMarcaTodos.Click;

    VK_F4: if Shift = [ssCtrl] then
             btnDesmarcaTodos.Click;
  end;
end;

procedure TfrmContatosWhatsappIntegracao.edtCodCidKeyPress(Sender: TObject;
  var Key: Char);
var
  arrCidade: TConsultasArray;
begin
  inherited;
  If fPesqCidade(Self, edtCodCid, edtNomCid, Nil, Nil, Key, arrCidade) Then
    fValidaCampos(edtCodCid, False);
end;

procedure TfrmContatosWhatsappIntegracao.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
var
  arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCli, Nil, Key, arrClientes) Then
    fValidaCampos(edtCodCli, True);
end;

procedure TfrmContatosWhatsappIntegracao.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
var
  arrEmpres: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpres, True, True) Then
    fValidaCampos(edtCodEmp, True);
end;

procedure TfrmContatosWhatsappIntegracao.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
var
  arrRegiao : TConsultasArray;
begin
  inherited;
  If fPesqRegiao(Self, edtCodReg, edtNomReg, Nil, Key, arrRegiao) Then
    fValidaCampos(edtCodReg, True);
end;

procedure TfrmContatosWhatsappIntegracao.edtCodRepKeyPress(Sender: TObject;
  var Key: Char);
var
  arrRep : TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodRep, edtNomRep, nil, Key, arrRep) then
    fValidaCampos(edtCodRep, True);
end;

procedure TfrmContatosWhatsappIntegracao.edtCodSubKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSubReg: TConsultasArray;
begin
  inherited;
  If fPesqSubRegiao(Self, edtCodSub, edtNomSub, Nil, Key, arrSubReg) Then
    fValidaCampos(edtCodSub, True);
end;

procedure TfrmContatosWhatsappIntegracao.edtCodVenKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrVended: TConsultasArray;
begin
  inherited;
  If fPesqOperador(Self, edtCodVen, edtNomVen, nil, Key, arrVended) then
    fValidaCampos(edtCodVen, True);
end;

procedure TfrmContatosWhatsappIntegracao.btnMarcaTodosClick(Sender: TObject);
begin
  inherited;
  fChamaTelaGravando(fMarcaTodos, 'Marcando todos...');
end;

function TfrmContatosWhatsappIntegracao.fMarcaTodos(
  pgbStatus: TcxProgressBar): Boolean;
begin
  Result := fMarca(cdsCadCli, pgbStatus) and fMarca(cdsCliCtt, pgbStatus);
end;

function TfrmContatosWhatsappIntegracao.fMarca(cds: TUniClientDataSet; pgbStatus: TcxProgressBar): Boolean;
begin
  if Assigned(cds) then
  begin
    cds.First;
    cds.DisableControls;
    While Not cds.Eof Do
    begin
      if cds.FieldByName('MARDES').AsString = 'D' then
        pSeleciona(cds);

      cds.Next;
      pProgresso(cds.RecNo, cds.RecordCount, pgbStatus);
    end;
    cds.EnableControls;
  end;
  Result := True;
end;

procedure TfrmContatosWhatsappIntegracao.btnDesmarcaTodosClick(Sender: TObject);
begin
  inherited;
  fChamaTelaGravando(fDesmarcaTodos, 'Desmarcando todos...');
end;

function TfrmContatosWhatsappIntegracao.fDesmarcaTodos(
  pgbStatus: TcxProgressBar): Boolean;
begin
  Result := fDesmarca(cdsCadCli, pgbStatus) and fDesmarca(cdsCliCtt, pgbStatus);
end;

function TfrmContatosWhatsappIntegracao.fDesmarca(cds: TUniClientDataSet; pgbStatus: TcxProgressBar): Boolean;
begin
  if Assigned(cds) then
  begin
    cds.First;
    cds.DisableControls;
    While Not cds.Eof Do
    begin
      if cds.FieldByName('MARDES').AsString = 'M' then
        pSeleciona(cds);

      cds.Next;
      pProgresso(cds.RecNo, cds.RecordCount, pgbStatus);
    end;
    cds.EnableControls;
  end;
  Result := True;
end;

function TfrmContatosWhatsappIntegracao.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender,blnBuscaPorChave)) Then
  Begin

    if Sender = edtCodCli then
    begin
      edtDesCli.Text := IIF(fEmptyStr(edtCodCli.Text), 'TODOS', fRetNomCliente(edtCodCli.Text));
      if fEmptyStr(edtDesCli.Text) then
      begin
        edtCodCli.Clear;
        fMensagem('ATENÇÃO!', 'Cliente não cadastrado!', ['&Ok']);
        Result := False;
      end;
    end

    else if Sender = edtCodCid then
    begin
      edtNomCid.Text := IIF(fEmptyStr(edtCodCid.Text), 'TODOS', fRetNomCidade(edtCodCid.Text));
      if fEmptyStr(edtNomCid.Text) then
      begin
        edtCodCid.Clear;
        fMensagem('ATENÇÃO!', 'Cidade não cadastrada!', ['&Ok']);
        Result := False;
      end;
    end

    else if Sender = edtCodVen then
    begin
      edtNomVen.Text := IIF(fEmptyStr(edtCodVen.Text), 'TODOS', fRetNomVendRep(edtCodVen.Text));
      if fEmptyStr(edtNomVen.Text) then
      begin
        edtCodVen.Clear;
        fMensagem('ATENÇÃO!', 'Vendedor não cadastrado!', ['&Ok']);
        Result := False;
      end;
    end

    else if Sender = edtCodRep then
    begin
      edtNomRep.Text := IIF(fEmptyStr(edtCodRep.Text), 'TODOS', fRetNomVendRep(edtCodRep.Text));
      if fEmptyStr(edtNomRep.Text) then
      begin
        edtCodRep.Clear;
        fMensagem('ATENÇÃO!', 'Representante não cadastrado!', ['&Ok']);
        Result := False;
      end;
    end

    else if Sender = edtCodReg then
    begin
      edtNomReg.Text := IIF(fEmptyStr(edtCodReg.Text), 'TODOS', fRetNomRegiao(edtCodReg.Text));
      if fEmptyStr(edtNomReg.Text) then
      begin
        edtCodReg.Clear;
        fMensagem('ATENÇÃO!', 'Região não cadastrada!', ['&Ok']);
        Result := False;
      end;
    end

    else if Sender = edtCodSub then
    begin
      edtNomSub.Text := IIF(fEmptyStr(edtCodSub.Text), 'TODOS', fRetNomSubRegiao(edtCodSub.Text));
      if fEmptyStr(edtNomSub.Text) then
      begin
        edtCodSub.Clear;
        fMensagem('ATENÇÃO!', 'Sub-Região não cadastrada!', ['&Ok']);
        Result := False;
      end;
    end

    else if Sender = edtCodEmp then
    begin
      edtNomEmp.Text := IIF(fEmptyStr(edtCodEmp.Text), 'TODOS', fRetNomeEmpresa(edtCodEmp.Text));
      if fEmptyStr(edtNomEmp.Text) then
      begin
        edtCodEmp.Clear;
        fMensagem('ATENÇÃO!', 'Empresa não cadastrada!', ['&Ok']);
        Result := False;
      end;
    end;

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmContatosWhatsappIntegracao.btnCadCliClick(Sender: TObject);
var
  LfrmCadClientes: TfrmCadClientes;
begin
  inherited;
  if not fVerificaAcessoSistema('frmCadClientes') then
  begin
    fMensagem('ATENÇÃO!', 'Operador sem acesso ao cadastro de clientes.', ['&Ok']);
    Exit;
  end;

  try
    pCriarFormularios(TfrmCadClientes, LfrmCadClientes);
    LfrmCadClientes.strCodClienteIniciarCadastro := cdsCadCli.FieldByName('CTT_CODCLI').AsString;
    LfrmCadClientes.blnEnviaContatoCitelDesk := False;
    LfrmCadClientes.ShowModal;

    pMantemSelecionados;

    TfrmGravando.fExecutarModal(pCarregaContatos, 'Carregando contatos...', '');
  finally
    pFreeAndNil(LfrmCadClientes);
  end;
end;

procedure TfrmContatosWhatsappIntegracao.btnCadOpeClick(Sender: TObject);
var
  LfrmCadOperadores: TfrmCadOperadores;
begin
  inherited;
  if not fVerificaAcessoSistema('frmCadOperadores') then
  begin
    fMensagem('ATENÇÃO!', 'Operador sem acesso ao cadastro de operadores.', ['&Ok']);
    Exit;
  end;

  try
    pCriarFormularios(TfrmCadOperadores, LfrmCadOperadores);
    LfrmCadOperadores.strCodOperadorIniciarCadastro := cdsCadCli.FieldByName('CTT_CODVEN').AsString;
    LfrmCadOperadores.ShowModal;

    pMantemSelecionados;

    TfrmGravando.fExecutarModal(pCarregaContatos, 'Carregando contatos...', '');
  finally
    pFreeAndNil(LfrmCadOperadores);
  end;
end;

procedure TfrmContatosWhatsappIntegracao.pMantemSelecionados;
begin
  cdsMantemSelecionados.EmptyDataSet;

  pGravaSelecionados(cdsCadCli);
  pGravaSelecionados(cdsCliCtt);
end;

procedure TfrmContatosWhatsappIntegracao.pGravaSelecionados(cds: TUniClientDataSet);
begin
  try
    cds.DisableControls;

    cds.First;
    while not cds.Eof do
    begin
      if cds.FieldByName('MARDES').AsString = 'M' then
      begin
        cdsMantemSelecionados.Append;
        cdsMantemSelecionados.FieldByName('TABELA').AsString := cds.FieldByName('TABELA').AsString;
        cdsMantemSelecionados.FieldByName('AUTOINCREM').AsString := cds.FieldByName('AUTOINCREM').AsString;
        cdsMantemSelecionados.Post;
      end;
      cds.Next;
    end;
  finally
    cds.EnableControls;
  end;
end;

procedure TfrmContatosWhatsappIntegracao.pVerificaSelecionados;
begin
  if cdsMantemSelecionados.IsEmpty then
    Exit;

  cdsMantemSelecionados.First;
  while not cdsMantemSelecionados.Eof do
  begin
    if cdsMantemSelecionados.FieldByName('TABELA').AsString = 'CADCLI' then
    begin
      if cdsCadCli.Locate('TABELA;AUTOINCREM',
                          VarArrayOf(
                          [cdsMantemSelecionados.FieldByName('TABELA').AsString,
                           cdsMantemSelecionados.FieldByName('AUTOINCREM').AsString]),
                          []) then
        pSeleciona(cdsCadCli);
    end
    else
    begin
      if cdsCliCtt.Locate('TABELA;AUTOINCREM',
                          VarArrayOf(
                          [cdsMantemSelecionados.FieldByName('TABELA').AsString,
                           cdsMantemSelecionados.FieldByName('AUTOINCREM').AsString]),
                          []) then
        pSeleciona(cdsCliCtt);
    end;
    cdsMantemSelecionados.Next;
  end;

end;

procedure TfrmContatosWhatsappIntegracao.chkAgenteClick(Sender: TObject);
begin
  inherited;
  cxgClientesVENDED.Visible := chkAgente.Checked;
  TfrmGravando.fExecutarModal(pCarregaContatos, 'Carregando contatos...', '');
end;

procedure TfrmContatosWhatsappIntegracao.btnFiltrarClick(Sender: TObject);
begin
  inherited;
  TfrmGravando.fExecutarModal(pCarregaContatos, 'Carregando contatos...', '');
end;

procedure TfrmContatosWhatsappIntegracao.pCriarCds;
begin
  cdsCadCli := TControllerAddOrEditContact.fCriaCdsContatos;
  dtsCadCli.DataSet := cdsCadCli;
  cdsCadCli.IndexFieldNames := 'CTT_NOMCTT';

  cdsCliCtt := TControllerAddOrEditContact.fCriaCdsContatos;
  dtsCliCtt.DataSet := cdsCliCtt;
end;

procedure TfrmContatosWhatsappIntegracao.pCarregaContatos;
var
  qryClientes,
  qryContatos: TUniQuery;
begin
  if Assigned(cdsCadCli) then
    FreeAndNil(cdsCadCli);

  if Assigned(cdsCliCtt) then
    FreeAndNil(cdsCliCtt);

  pCriarCds;

  cdsCadCli.DisableControls;
  cdsCliCtt.DisableControls;

  qryClientes := fCriaQuery(Self);
  qryContatos := fCriaQuery(Self);
  try
    qryClientes.Close;
    qryClientes.SQL.Text := fRetSqlCadCli;
    qryClientes.Open;
    while not qryClientes.Eof do
    begin
      pAlimentaCds(cdsCadCli, qryClientes, qryClientes);

      qryContatos.Close;
      qryContatos.SQL.Text := fRetSqlCliCtt;
      qryContatos.ParamByName('CODCLI').AsString := qryClientes.FieldByName('CTT_CODCLI').AsString;
      qryContatos.Open;
      while not qryContatos.Eof do
      begin
        pAlimentaCds(cdsCliCtt, qryContatos, qryClientes);
        qryContatos.Next;
      end;

      qryClientes.Next;
    end;

    pVerificaSelecionados;
  finally
    FreeAndNil(qryClientes);
    FreeAndNil(qryContatos);

    cdsCadCli.First;
    cdsCliCtt.First;

    cdsCadCli.EnableControls;
    cdsCliCtt.EnableControls;

    if chkAgente.Checked then
      cxgClientesDBTableView.ApplyBestFit();
  end;
end;

procedure TfrmContatosWhatsappIntegracao.pSeleciona(cds: TUniClientDataSet; strMarDes: String = '');
begin
  if not Assigned(cds) then
    Exit;

  if not cds.Active then
    Exit;

  if cds.IsEmpty then
    Exit;

  if (chkAgente.Checked) and (fEmptyStr(cds.FieldByName('CTT_VENDED').AsString)) then
    Exit;

  cds.Edit;
  if fEmptyStr(strMarDes) then
    cds.FieldByName('MARDES').AsString := IIF(cds.FieldByName('MARDES').AsString = 'D', 'M', 'D')
  else
    cds.FieldByName('MARDES').AsString := strMarDes;

  cds.Post;
end;

function TfrmContatosWhatsappIntegracao.fRetSqlCadCli: String;
begin
  Result := ' SELECT '+
            '   "CADCLI" AS TABELA, '+
            '   CADCLI.AUTOINCREM, '+
            '   CLI_C_E_P_ AS CTT_C_E_P_, '+
            '   CONCAT(CLI_ENDERE, " - ", CLI_BAIRRO) AS CTT_ENDERE, '+
            '   CID_NOMCID AS CTT_NOMCID, '+
            '   CID_ESTADO AS CTT_ESTADO, '+
            '   IBG_NOMPAI AS CTT_PAIS__, '+
            '   CLI_CODCLI AS CTT_CODCLI, '+
            '   CLI_NOMCLI AS CTT_NOMCTT, '+
            '   CLI_C_G_C_ AS CTT_DOCUME, '+
            '   CLI_CELULA AS CTT_CELULA, '+
            '   CLI_EMAIL_ AS CTT_EMAIL_, '+
            '   CLI_CODVEN AS CTT_CODVEN, '+
            '   CONCAT(CLI_CODVEN, " - ", OPE_NOMOPE) AS CTT_VENDED, '+
            '   OPE_IDCIDE AS CTT_IDEAGE, '+
            '   CLI_IDCIDE AS CTT_IDCIDE  '+
            ' FROM '+
            '   CADCLI '+
            ' LEFT JOIN CADCID ON '+
            '   CLI_CODCID = CID_CODCID '+
            ' LEFT JOIN IBG_CADPAI ON '+
            '   CID_CODPAI = IBG_CODPAI '+
            ' LEFT JOIN CADOPE ON '+
            '   CLI_CODVEN = OPE_CODOPE '+
            ' WHERE '+
            '   CLI_STATUS = "A" AND '+
            '   IFNULL(CLI_CELULA, "") <> "" '+
                fRetWhereDataCadastro +
                fRetWhereCliente +
                fRetWhereCidade +
                fRetWhereVendedor +
                fRetWhereRepresentante +
                fRetWhereRegiao +
                fRetWhereSubRegiao +
                fRetWhereEmpresaCadastro +
                fRetWherePessoa +
            ' GROUP BY '+
            '   AUTOINCREM '+
            ' ORDER BY '+
            '   CTT_NOMCTT ';
end;

function TfrmContatosWhatsappIntegracao.fRetSqlCliCtt: String;
begin
  Result := ' SELECT '+
            '   "CLICTT" AS TABELA, '+
            '   CLICTT.AUTOINCREM, '+
            '   "" AS CTT_C_E_P_, '+
            '   CONCAT(CLI_ENDCTT, " - ", CLI_BAICTT) AS CTT_ENDERE, '+
            '   CID_NOMCID AS CTT_NOMCID, '+
            '   CID_ESTADO AS CTT_ESTADO, '+
            '   IBG_NOMPAI AS CTT_PAIS__, '+
            '   CLI_CODCLI AS CTT_CODCLI, '+
            '   CLI_NOMCTT AS CTT_NOMCTT, '+
            '   CLI_NUMCPF AS CTT_DOCUME, '+
            '   CLI_CELCTT AS CTT_CELULA, '+
            '   CLI_EMACTT AS CTT_EMAIL_, '+
            '   CLI_IDCIDE AS CTT_IDCIDE  '+
            ' FROM '+
            '   CLICTT '+
            ' LEFT JOIN CADCID ON '+
            '   CLI_CIDCTT = CID_CODCID '+
            ' LEFT JOIN IBG_CADPAI ON '+
            '   CID_CODPAI = IBG_CODPAI '+
            ' WHERE '+
            '   CLI_CODCLI = :CODCLI AND '+
            '   IFNULL(CLI_CELCTT, "") <> "" '+
            ' GROUP BY '+
            '   AUTOINCREM '+
            ' ORDER BY '+
            '   CLI_NOMCTT ';

end;

procedure TfrmContatosWhatsappIntegracao.pAlimentaCds(cds: TUniClientDataSet; qryDados, qryDadosAgente: TUniQuery);
begin
  cds.Append;
  cds.FieldByName('MARDES').AsString := 'D';
  cds.FieldByName('TABELA').AsString := qryDados.FieldByName('TABELA').AsString;;
  cds.FieldByName('AUTOINCREM').AsString := qryDados.FieldByName('AUTOINCREM').AsString;
  cds.FieldByName('CTT_C_E_P_').AsString := qryDados.FieldByName('CTT_C_E_P_').AsString;
  cds.FieldByName('CTT_ENDERE').AsString := qryDados.FieldByName('CTT_ENDERE').AsString;
  cds.FieldByName('CTT_NOMCID').AsString := qryDados.FieldByName('CTT_NOMCID').AsString;
  cds.FieldByName('CTT_ESTADO').AsString := qryDados.FieldByName('CTT_ESTADO').AsString;
  cds.FieldByName('CTT_PAIS__').AsString := qryDados.FieldByName('CTT_PAIS__').AsString;
  cds.FieldByName('CTT_CODCLI').AsString := qryDados.FieldByName('CTT_CODCLI').AsString;
  cds.FieldByName('CTT_NOMCTT').AsString := qryDados.FieldByName('CTT_NOMCTT').AsString;
  cds.FieldByName('CTT_DOCUME').AsString := qryDados.FieldByName('CTT_DOCUME').AsString;
  cds.FieldByName('CTT_CELULA').AsString := qryDados.FieldByName('CTT_CELULA').AsString;
  cds.FieldByName('CTT_EMAIL_').AsString := qryDados.FieldByName('CTT_EMAIL_').AsString;
  cds.FieldByName('CTT_IDCIDE').AsExtended := qryDados.FieldByName('CTT_IDCIDE').AsExtended;

  cds.FieldByName('CTT_CODVEN').AsString := qryDadosAgente.FieldByName('CTT_CODVEN').AsString;
  if chkAgente.Checked then
  begin
    cds.FieldByName('CTT_IDEAGE').AsExtended := qryDadosAgente.FieldByName('CTT_IDEAGE').AsExtended;

    if cds.FieldByName('CTT_IDEAGE').AsExtended > 0 then
      cds.FieldByName('CTT_VENDED').AsString := IIF(not fEmptyStr(qryDadosAgente.FieldByName('CTT_IDEAGE').AsString),
                                                    'ID: ' + qryDadosAgente.FieldByName('CTT_IDEAGE').AsString + ' / ',
                                                    '') + qryDadosAgente.FieldByName('CTT_VENDED').AsString
    else
      cds.FieldByName('SITUACAO').AsString := 'Não é possível enviar contato sem ID no cadastro do vendedor '+
                                                     qryDadosAgente.FieldByName('CTT_VENDED').AsString;
  end;

  cds.Post;
end;

function TfrmContatosWhatsappIntegracao.fRetWhereDataCadastro: String;
begin
  Result := EmptyStr;

  if fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) then
    Exit;

  if fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) then
    Exit;

  if not fValidaDataStr(mskDtaIni.Text) then
    Exit;

  if not fValidaDataStr(mskDtaFin.Text) then
    Exit;

  Result := ' AND CLI_DTACAD BETWEEN '+
                QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(mskDtaIni.Text)))+
            ' AND '+
                QuotedStr(FormatDateTime('yyyy-mm-dd', StrToDate(mskDtaFin.Text)));
end;

function TfrmContatosWhatsappIntegracao.fRetWhereCliente: String;
begin
  Result := IIF(not fEmptyStr(edtCodCli.Text), ' AND CLI_CODCLI = '+QuotedStr(edtCodCli.Text), '');
end;

function TfrmContatosWhatsappIntegracao.fRetWhereCidade: String;
begin
  Result := IIF(not fEmptyStr(edtCodCid.Text), ' AND CLI_CODCID = '+QuotedStr(edtCodCid.Text), '');
end;

function TfrmContatosWhatsappIntegracao.fRetWhereVendedor: String;
begin
  Result := IIF(not fEmptyStr(edtCodVen.Text), ' AND CLI_CODVEN = '+QuotedStr(edtCodVen.Text), '');
end;

function TfrmContatosWhatsappIntegracao.fRetWhereRepresentante: String;
begin
  Result := IIF(not fEmptyStr(edtCodRep.Text), ' AND CLI_CODREP = '+QuotedStr(edtCodRep.Text), '');
end;

function TfrmContatosWhatsappIntegracao.fRetWhereRegiao: String;
begin
  Result := IIF(not fEmptyStr(edtCodReg.Text), ' AND CLI_CODREG = '+QuotedStr(edtCodReg.Text), '');
end;

function TfrmContatosWhatsappIntegracao.fRetWhereSubRegiao: String;
begin
  Result := IIF(not fEmptyStr(edtCodSub.Text), ' AND CLI_CODSUB = '+QuotedStr(edtCodSub.Text), '');
end;

function TfrmContatosWhatsappIntegracao.fRetWhereEmpresaCadastro: String;
begin
  Result := IIF(not fEmptyStr(edtCodEmp.Text), ' AND CLI_CODEMP = '+QuotedStr(edtCodEmp.Text), '');
end;

function TfrmContatosWhatsappIntegracao.fRetWherePessoa: String;
begin
  Result := EmptyStr;

  if rdbTodos.Checked then
    Exit;

  Result := ' AND CLI_CGCCPF = ' + IIF(rdbFisica.Checked, '2', '1');
end;

procedure TfrmContatosWhatsappIntegracao.cxgClientesDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if not Assigned(cdsCadCli) then
    Exit;

  if not cdsCadCli.Active then
    Exit;

  if (chkAgente.Checked) and (fEmptyStr(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgClientesVENDED.Index]))) then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clRed
    else
      ACanvas.Brush.Color := $008484FF;
  end
  else if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgClientesMARDES.Index]) = 'M' then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clLime
    else
    begin
      ACanvas.Brush.Color := clSkyBlue;
      ACanvas.Font.Color := clBlue;
    end;
  end
  else if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgClientesSITUAC.Index]) = RETORNO_SUCESSO_ENVIO_CONTATO then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clLime
    else
    begin
      ACanvas.Brush.Color := clMoneyGreen;
      ACanvas.Font.Color := clBlack;
    end;
  end;
end;

procedure TfrmContatosWhatsappIntegracao.cxgClientesDBTableViewDblClick(
  Sender: TObject);
begin
  inherited;
  pSeleciona(cdsCadCli);
end;

procedure TfrmContatosWhatsappIntegracao.cxgContatosClientesDBTableViewDblClick(
  Sender: TObject);
begin
  inherited;
  pSeleciona(cdsCliCtt);
end;

procedure TfrmContatosWhatsappIntegracao.cxgClientesDBTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN,
    VK_SPACE: pSeleciona(cdsCadCli);
  end;
end;

procedure TfrmContatosWhatsappIntegracao.cxgContatosClientesDBTableViewCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if not Assigned(cdsCliCtt) then
    Exit;

  if not cdsCliCtt.Active then
    Exit;

  if (chkAgente.Checked) and (fEmptyStr(VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgContatosVENDED.Index]))) then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clRed
    else
      ACanvas.Brush.Color := $00B7B7FF;
  end
  else if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgContatosMARDES.Index]) = 'M' then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clLime
    else
    begin
      ACanvas.Brush.Color := clSkyBlue;
      ACanvas.Font.Color := clBlue;
    end;
  end
  else if VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, cxgContatosSITUAC.Index]) = RETORNO_SUCESSO_ENVIO_CONTATO then
  begin
    if ACanvas.Brush.Color = clHighlight then
      ACanvas.Font.Color := clLime
    else
    begin
      ACanvas.Brush.Color := clMoneyGreen;
      ACanvas.Font.Color := clBlack;
    end;
  end;
end;

procedure TfrmContatosWhatsappIntegracao.cxgContatosClientesDBTableViewKeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN,
    VK_SPACE: pSeleciona(cdsCliCtt);
  end;
end;

procedure TfrmContatosWhatsappIntegracao.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrNone;

  if not Assigned(cdsCadCli) then
    Exit;

  TfrmGravando.fExecutarModal(pEnviaContatos, 'Enviando contatos...', '');
end;

procedure TfrmContatosWhatsappIntegracao.pEnviaContatos;
begin
  try
    try
      cdsCadCli.Filtered := False;
      cdsCadCli.Filter := 'MARDES = '+QuotedStr('M');
      cdsCadCli.Filtered := True;

      if not cdsCadCli.IsEmpty then
        TControllerAddOrEditContact.pAddOrEditContact(cdsCadCli);

      cdsCliCtt.Filtered := False;
      cdsCliCtt.Filter := 'MARDES = '+QuotedStr('M');
      cdsCliCtt.Filtered := True;

      if not cdsCliCtt.IsEmpty then
        TControllerAddOrEditContact.pAddOrEditContact(cdsCliCtt);
    except
      on E: Exception do
        pMensagensErro(E.Message, '[pEnviaContatos]');
    end;

  finally
    cdsCadCli.Filtered := False;
    cdsCadCli.Filter := EmptyStr;

    cdsCliCtt.Filtered := False;
    cdsCliCtt.Filter := EmptyStr;
  end;
end;

end.
