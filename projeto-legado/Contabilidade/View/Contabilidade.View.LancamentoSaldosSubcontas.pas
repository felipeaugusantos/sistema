unit Contabilidade.View.LancamentoSaldosSubcontas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Contabilidade.View.TfrmPaiContabilidade,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxDropDownEdit, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel, cxGrid, cxProgressBar,
  Vcl.CheckLst, Vcl.Mask, MaskEditFocus, Vcl.ComCtrls, cxContainer, untExcel, untGeraExcel,
  ComboBoxFocus, cxTextEdit, cxCurrencyEdit, CurrencyEditFocus, EditFocus, untIZClient, Uni, UniClientDataset,
  Vcl.Grids, Vcl.DBGrids, DBGridCitel, System.Generics.Collections,
  Contabilidade.Classes.TValidaProcessoSaldoInicialSubconta;

type
  TfrmLanSalSub = class(TfrmPaiContabilidade)
    btnGeraExcel: TSpeedButton;
    pgcDados: TPageControl;
    tbsFiltros: TTabSheet;
    lblCodEmp: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    btnCarregar: TBitBtnLocked;
    mskExercicio: TMaskEditFocus;
    cklEmpresas: TCheckListBox;
    tbsDados: TTabSheet;
    pnlBotoesGrid: TPanel;
    btnGravarDadosDigitados: TBitBtnLocked;
    gbDadosLancamento: TGroupBox;
    Label12: TLabel;
    lbValor: TLabel;
    Label3: TLabel;
    lbSubconta: TLabel;
    mskConta: TMaskEditFocus;
    edtConRed: TEditFocus;
    edtDesConta: TEditFocus;
    edtValor: TCurrencyEditFocus;
    edtTipo: TComboBoxFocus;
    edtOpcSubconta: TEditFocus;
    edtCodCliForSubconta: TEditFocus;
    edtNomCliForSubconta: TEditFocus;
    gbBotoes: TGroupBox;
    btnIncluir: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnCancela: TBitBtnLocked;
    Label4: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    GridCitel: TcxGridCitel;
    GridCitelDBTableViewCitel: TcxGridDBTableViewCitel;
    GridCitelDBTableViewCitelINI_EXERCI: TcxGridDBColumn;
    GridCitelDBTableViewCitelINI_CODEMP: TcxGridDBColumn;
    GridCitelDBTableViewCitelNCO_CODCON: TcxGridDBColumn;
    GridCitelDBTableViewCitelNCO_DESCRI: TcxGridDBColumn;
    GridCitelDBTableViewCitelNCO_CONRED: TcxGridDBColumn;
    GridCitelDBTableViewCitelINI_TIP_FC: TcxGridDBColumn;
    GridCitelDBTableViewCitelINI_CLIFOR: TcxGridDBColumn;
    GridCitelDBTableViewCitelINI_SALINI: TcxGridDBColumn;
    GridCitelDBTableViewCitelINI_CREDEB: TcxGridDBColumn;
    GridCitelLevel1: TcxGridLevel;
    pnlGrid: TPanel;
    dbgBuscaConta: TDBGridCitel;
    procedure FormShow(Sender: TObject);
    procedure cklEmpresasClickCheck(Sender: TObject);
    procedure cklEmpresasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCarregarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure pgcDadosChange(Sender: TObject);
    procedure btnGravarDadosDigitadosClick(Sender: TObject);
    procedure GridCitelDBTableViewCitelKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtOpcSubcontaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliForSubcontaKeyPress(Sender: TObject; var Key: Char);
    procedure mskContaKeyPress(Sender: TObject; var Key: Char);
    procedure btnGeraExcelClick(Sender: TObject);
    procedure dbgBuscaContaDblClick(Sender: TObject);
    procedure mskContaClick(Sender: TObject);
    procedure edtConRedClick(Sender: TObject);
    procedure mskContaKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtConRedKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GridCitelDBTableViewCitelDblClick(Sender: TObject);
    procedure btnGravarDadosDigitadosKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    strCnpjBase : String;
    cdsDados : IZClient;
    cdsBusca : IZClient;
    cdsTotPlanco: TUniClientDataset;
    FModoInclusao: Boolean;
    FFiltrou: Boolean;
    FAlterou: Boolean;
    FAlterando: Boolean;
    procedure pCarregaEmpresas ;
    function fSQLDados: String;
    procedure pMarcarEmpresaLogada ;
    function fEmpresasSelecionadas: Integer ;
    function fCnpjSelecionadoIncorreto: Boolean;
    function fPegaCnpjBase: String ;
    function fCarregarDados(pgbProgresso: TcxProgressBar): Boolean;
    procedure pCarregarDados;
    function fGetInEmpresas: String;
    procedure pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
    procedure OnGeraExcel(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
    function fGravarDados(pgbProgresso: TcxProgressBar): Boolean;
    procedure pHabilitaControles(const AHabilitar: Boolean; AAltera: Boolean = false);
    function fTemInformacaoGrid: boolean;
    function fCarregarGridParaCampos: boolean;
    procedure pLimparCampos;
    function fValidaOpcaoSubConta(AedtCampo: TEditFocus): Boolean ;
    function fCarregaCliForSubConta(AedtCodigo, AedtDescricao: TEditFocus; const AstrOpcao: String): Boolean ;
    procedure pCarregaPlanoContabil(const blnBuscaPorChave: Boolean; blnCampoContaReduzida: Boolean = False) ;
    procedure pBuscarConta(dbeTexto: TCustomEdit; blnRed: Boolean; intTag: Integer) ;
    function fMovimentaLinha(const Key: Word; Sender: TObject): Boolean ;
    function fGetIndexFieldNames: String;
    function fGetFiltroSQL: String;
    function fGetCredDebFromEdtTipo: String;
    function fEmpresaEstaFiltrada(ACodEmp: string): Boolean;
    procedure pCarregarTotPlanco;
    procedure pMostraTelaTotal;
    function fConverteEstruturaParaValidacao(ADataset: TDataset): TList<TDadosValidacaoSaldoInicialSub>;
    function fGetEmps: TStrings;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

implementation

uses
  System.StrUtils, untZClient, untTypesSistema, untFuncoesSimples, untConsultas,
  Contabilidade.Funcoes, Contabilidade.Consultas, Contabilidade.View.TotalPlanco,
  Contabilidade.Classes.TControleContabilidade, Contabilidade.Classes.UniQueryAuditoria;

{$R *.dfm}

{ TfrmLanSalSub }

procedure TfrmLanSalSub.btnAlterarClick(Sender: TObject);
begin
  inherited;

  If Not fTemInformacaoGrid Then
    Exit ;

  FModoInclusao := False;

  pHabilitaControles(True, True) ;

  fCarregarGridParaCampos ;

  pSetFocus(edtTipo) ;

  FAlterando := True;
end;

procedure TfrmLanSalSub.btnCancelaClick(Sender: TObject);
begin
  inherited;

  pLimparCampos ;

  FModoInclusao := False ;

  pHabilitaControles(False) ;

  pSetFocus(btnIncluir);

  FAlterando := False;
end;

procedure TfrmLanSalSub.btnCarregarClick(Sender: TObject);
begin
  inherited;

  If FAlterou or FAlterando Then
  Begin
    If fMensagem('ATENÇÃO!', 'Existem alterações não salvas no filtro atual.' + #13 +
      'Descartar alterações ?', ['&Sim', '&Não'], 2) <> 1
    Then
      Exit;
  End;

  If Not fValidaCampos(mskExercicio) Then
    Exit;

  If (fEmpresasSelecionadas = 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Deve ser selecionado uma ou mais empresas!', ['&OK']);
    pSetFocus(cklEmpresas);
    Exit;
  End;

  pCarregarDados;
end;

procedure TfrmLanSalSub.btnExcluirClick(Sender: TObject);
begin
  inherited;

  If Not fTemInformacaoGrid Then
    Exit ;

  If (fMensagem('', 'Deseja excluir o lançamento?', ['&Sim', '&Não'], 2) = 1) Then
  Begin
    cdsDados.Delete ;
    fMensagem('ATENÇÃO!', 'Lançamento excluido com sucesso!', ['&OK']);
    FAlterou := True;
  End;
end;

procedure TfrmLanSalSub.btnGeraExcelClick(Sender: TObject);
begin
  inherited;
  If TGeraExcel.fGerarRelatorio(GridCitelDBTableViewCitel, Self.Caption, OnGeraExcel) Then
    fMensagem('','Arquivo Salvo com Sucesso!', ['&OK']);
end;

procedure TfrmLanSalSub.btnGravarClick(Sender: TObject);
  Var
    blnAtualizar: Boolean;
    cdsAux: TUniClientDataSet;
begin
  inherited;

  blnAtualizar := False;

  If Not fVerificaCampos Then
    Exit;

  If Not fEmpresaEstaFiltrada(edtCodEmp.Text) Then
  Begin
    fMensagem('','A Empresa ' + edtCodEmp.Text + ' não está presente no filtro atual.'
    + #13 + 'Para incluir registros para esta empresa será necessário filtrar novamente.', ['&OK']);
    Exit;
  End;

  cdsAux := TUniClientDataSet.Create(Nil);
  Try
    cdsAux.Data := cdsDados.Data;
    cdsAux.IndexFieldNames := fGetIndexFieldNames;
  
    If cdsAux.FindKey([edtCodEmp.Text, mskExercicio.Text, mskConta.Text, edtOpcSubconta.Text, edtCodCliForSubconta.Text]) Then
    Begin
      blnAtualizar := not FModoInclusao;

      If FModoInclusao Then
      Begin
        blnAtualizar := fMensagem('ATENÇÃO!', 'Já existe um registro cadastrado com a empresa, conta e subconta informadas.'
                        + #13 + 'Deseja atualizar ?', ['&Sim', '&Não']) = 1;
      End;

      If Not blnAtualizar Then
        Exit;
    End
    Else
    Begin
      If Not FModoInclusao Then
      Begin
        fMensagem('ATENÇÃO!', 'Registro não localizado.', ['&Ok']);
        btnCancela.Click;
        Exit;
      End;
    End;

    If (Not FModoInclusao) And (Not blnAtualizar) Then
      Exit;

    If blnAtualizar Then
    Begin
      cdsDados.fGetUniClientDataset.FindKey([edtCodEmp.Text, mskExercicio.Text, mskConta.Text, edtOpcSubconta.Text, edtCodCliForSubconta.Text]);
      cdsDados.Edit
    End
    Else
    Begin
      cdsDados.Append;
      cdsDados.FieldByName('INI_EXERCI').AsString := mskExercicio.Text;
      cdsDados.FieldByName('EMP_CODEMP').AsString := edtCodEmp.Text;
      cdsDados.FieldByName('EMP_NOMEMP').AsString := edtNomEmp.Text;
      cdsDados.FieldByName('NCO_CODCON').AsString := fSemMascaraPlaNco(mskConta.Text);
      cdsDados.FieldByName('NCO_CONRED').AsString := edtConRed.Text;
      cdsDados.FieldByName('NCO_DESCRI').AsString := edtDesConta.Text;
      cdsDados.FieldByName('INI_TIP_FC').AsString := edtOpcSubconta.Text;
      cdsDados.FieldByName('INI_CLIFOR').AsString := edtCodCliForSubconta.Text;
      cdsDados.FieldByName('NOM_CLIFOR').AsString := edtNomCliForSubconta.Text;
    End;

    cdsDados.FieldByName('INI_CREDEB').AsString := fGetCredDebFromEdtTipo;
    cdsDados.FieldByName('INI_SALINI').AsFloat := edtValor.Value;
    cdsDados.FieldByName('INI_DTAALT').AsDateTime := fNow();
    cdsDados.FieldByName('INI_OPEALT').AsString := strLoginUsuarioLogado;

    cdsDados.Post;

    pLimparCampos ;

    FModoInclusao := False;
    FAlterando := False;
    FAlterou := True;

    pHabilitaControles(False) ;

    pSetFocus(btnIncluir);
  Finally
    FreeAndNil(cdsAux);
  End;

end;

procedure TfrmLanSalSub.btnGravarDadosDigitadosClick(Sender: TObject);
begin
  inherited;
  fChamaTelaGravando(fGravarDados);
end;

procedure TfrmLanSalSub.btnGravarDadosDigitadosKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
    btnAlterar.click;
end;

procedure TfrmLanSalSub.btnIncluirClick(Sender: TObject);
begin
  inherited;

  FModoInclusao := True ;

  pHabilitaControles(True) ;

  pSetFocus(edtCodEmp) ;

  FAlterando := True;
end;

procedure TfrmLanSalSub.cklEmpresasClickCheck(Sender: TObject);
  Var
    intSel : Integer;
begin
  inherited;
  intSel := fEmpresasSelecionadas;
  If (intSel = 0) Then
    strCnpjBase := ''
  Else If (intSel = 1) Then
    strCnpjBase := fPegaCnpjBase
  Else
  Begin
    If fCnpjSelecionadoIncorreto Then
      fMensagem('ATENÇÃO!', 'Somente podem estar selecionadas juntas, empresas do mesmo CNPJ base - Matriz/Filiais', ['&OK']);
  End;
end;

procedure TfrmLanSalSub.cklEmpresasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmLanSalSub.dbgBuscaContaDblClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
  If (dbgBuscaConta.Tag = 1) or (dbgBuscaConta.Tag = 11) Then
  Begin
    mskConta.Text := cdsBusca.FieldByName('CODCON').AsString;
    edtConRed.Text := cdsBusca.FieldByName('CONRED').AsString;
    edtDesConta.Text := cdsBusca.FieldByName('DESCON').AsString;
    if dbgBuscaConta.Tag = 1 then
      pSetFocus(mskConta)
    else
      pSetFocus(edtConRed) ;
  End;
end;

procedure TfrmLanSalSub.edtCodCliForSubcontaKeyPress(Sender: TObject; var Key: Char);
  Var
    arrRetornoConsultas: TConsultasArray;
begin                                                           
  inherited;

  If Not fValidaOpcaoSubConta(edtOpcSubconta) Then
  Begin
    pSetFocus(edtOpcSubconta);
    Exit ;
  End ;

  If edtOpcSubconta.Text = 'C' Then //clientes
  Begin
    If fPesqClientesCont(Self, edtCodCliForSubconta, edtNomCliForSubconta, Nil, Key, arrRetornoConsultas, True) Then
    Begin
      If fValidaCampos(edtCodCliForSubconta, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End
  Else // fornecedores
  Begin
    If fPesqFornecedoresCont(Self, edtCodCliForSubconta, edtNomCliForSubconta, Nil, Key, arrRetornoConsultas, True) Then
    Begin
      If fValidaCampos(edtCodCliForSubconta, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End ;
end;

procedure TfrmLanSalSub.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;

  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLanSalSub.edtConRedClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmLanSalSub.edtConRedKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if not fMovimentaLinha(Key, Sender) then
  begin
    pBuscarConta(edtConRed, True, 1);
  end;
end;

procedure TfrmLanSalSub.edtOpcSubcontaKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (not CharInSet(key, [#13, #9])) and (not edtOpcSubconta.ReadOnly) then
  begin
    edtCodCliForSubconta.Clear ;
    edtNomCliForSubconta.Clear ;
  end ;
end;

function TfrmLanSalSub.fCarregaCliForSubConta(AedtCodigo,
  AedtDescricao: TEditFocus; const AstrOpcao: String): Boolean;
  Var
    LstrDescrMensagem: string;
begin
  Result := True ;
  If Not fEmptyStr(AedtCodigo.Text) Then
  Begin
    AedtDescricao.Text := fCarregaCliForBD(AedtCodigo.Text, AstrOpcao) ;
    if AstrOpcao = 'C' then // cliente
      LstrDescrMensagem := 'Esse cliente não está cadastrado!'
    else // fornecedor
      LstrDescrMensagem := 'Esse fornecedor não está cadastrado!' ;

    If fEmptyStr(AedtDescricao.Text) Then
    Begin
      fMensagem('ATENÇÃO!', LstrDescrMensagem, ['&OK']);
      Result := False;
    End;
  End
  Else
  Begin
    AedtDescricao.Clear;
    fMensagem('ATENÇÃO!', 'É necessário informar o código do Cliente/Fornecedor', ['&OK']);
    Result := False;
  End;
end;

function TfrmLanSalSub.fCarregarDados(pgbProgresso: TcxProgressBar): Boolean;
begin
  pInformacao('Aguarde... Carregando', pgbProgresso);
  cdsDados.qryQuery.Close;
  cdsDados.qryQuery.SQL.Text := fSQLDados;
  cdsDados.fAbreClient(True, '[TfrmLanSalSub.fCarregarDados]');
  cdsDados.fGetUniClientDataset.IndexFieldNames := fGetIndexFieldNames;
  TFloatField(cdsDados.FieldByName('INI_SALINI')).DisplayFormat := '##,#0.00';

  If (cdsDados.IsEmpty) Then
    fMensagem('ATENÇÃO!', 'Não há dados para exibir!', ['&OK'])
  Else
  Begin
    cdsDados.First;
    Caption := 'Lançamento de Saldos - Subcontas - Exercício: ' + mskExercicio.Text;
    pgcDados.ActivePage := tbsDados;
    btnGeraExcel.Visible := True;
    pMostraTelaTotal;
  End;

  Result := True;
  FFiltrou := True;
  FAlterou := False;
  FAlterando := False;

  pHabilitaControles(False) ;
end;

function TfrmLanSalSub.fCarregarGridParaCampos: boolean;
begin
  Result := False ;

  If Not fTemInformacaoGrid Then
    Exit ;

  edtCodEmp.Text := cdsDados.FieldByName('EMP_CODEMP').AsString;
  edtNomEmp.Text := cdsDados.FieldByName('EMP_NOMEMP').AsString;
  If cdsDados.FieldByName('INI_CREDEB').AsString.ToUpper = 'C' Then
    edtTipo.ItemIndex := 0
  Else
    edtTipo.ItemIndex := 1;
  mskConta.Text := cdsDados.FieldByName('NCO_CODCON').AsString;
  edtConRed.Text := cdsDados.FieldByName('NCO_CONRED').AsString;
  edtDesConta.Text := cdsDados.FieldByName('NCO_DESCRI').AsString;
  edtOpcSubconta.Text := cdsDados.FieldByName('INI_TIP_FC').AsString;
  edtCodCliForSubconta.Text := cdsDados.FieldByName('INI_CLIFOR').AsString;
  edtNomCliForSubconta.Text := cdsDados.FieldByName('NOM_CLIFOR').AsString;
  edtValor.Value := cdsDados.FieldByName('INI_SALINI').AsFloat;

  Result := True ;
end;

function TfrmLanSalSub.fCnpjSelecionadoIncorreto: Boolean;
  Var
    intCnt : Integer;
    strCnpj : String;
begin
  Result := False;
  For intCnt := 0 To cklEmpresas.Items.Count-1 Do // OITO PRIMEIROS DEVEM SER IGUAIS
  Begin
    If (cklEmpresas.Checked[intCnt]) Then
    Begin
      strCnpj := Copy(cklEmpresas.Items[intCnt], 7, Length(cklEmpresas.Items[intCnt]));
      If (strCnpjBase <> strCnpj) Then
      Begin
        If (LeftStr(strCnpjBase, 8) <> LeftStr(strCnpj, 8)) Then
        Begin
          cklEmpresas.Checked[intCnt] := False;
          Result := True;
          Break;
        End;
      End;
    End;
  End;
end;

function TfrmLanSalSub.fConverteEstruturaParaValidacao(
  ADataset: TDataset): TList<TDadosValidacaoSaldoInicialSub>;
var
  regItem: TDadosValidacaoSaldoInicialSub;
begin
  Result := TList<TDadosValidacaoSaldoInicialSub>.Create;
  ADataSet.First;
  while not ADataset.Eof do
  begin
    FillChar(regItem, sizeOf(regItem), #0);
    regItem.AConta := ADataset.FieldByName('NCO_CODCON').AsString;
    regItem.AEmpresa := ADataset.FieldByName('EMP_CODEMP').AsString;
    try
      regItem.AExercicio := ADataset.FieldByName('INI_EXERCI').AsString;
    except
      regItem.AExercicio := mskExercicio.Text;
    end;
    try
      regItem.AValor := ADataset.FieldByName('INI_SALINI').AsFloat ;
    except
      regItem.AValor := 0;
    end;
    try
      regItem.ACreDeb := (ADataset.FieldByName('INI_CREDEB').AsString)[1];
    except
      regItem.ACreDeb := #0;
    end;
    try
      regItem.ATipFC := (ADataset.FieldByName('INI_TIP_FC').AsString)[1];
    except
      regItem.ATipFC := #0;
    end;
    try
      regItem.ACliFor := ADataset.FieldByName('INI_CLIFOR').AsString;
    except
      regItem.ACliFor := #0;
    end;
    Result.Add(regItem);
    ADataset.Next;
  end;

  ADataset.First;
end;

function TfrmLanSalSub.fEmpresaEstaFiltrada(ACodEmp: string): Boolean;
  Var
    strEmpresas: string;
begin
  Result := False;

  if ACodEmp.IsEmpty then
    Exit;

  strEmpresas := fGetInEmpresas;

  Result := strEmpresas.Contains(ACodEmp);
end;

function TfrmLanSalSub.fEmpresasSelecionadas: Integer;
  Var
    intCnt : Integer;
begin
  Result := 0;
  For intCnt := 0 To cklEmpresas.Items.Count-1 Do
  Begin
    If (cklEmpresas.Checked[intCnt]) Then
      Result := Result + 1;
  End;
end;

function TfrmLanSalSub.fGetCredDebFromEdtTipo: string;
begin
  if edtTipo.ItemIndex = 0 then
    Result := 'C'
  Else
    Result := 'D';
end;

function TfrmLanSalSub.fGetEmps: TStrings;
var
  intCnt : Integer;
begin
  Result := TStringList.Create;
  For intCnt := 0 To cklEmpresas.Items.Count-1 Do
    If (cklEmpresas.Checked[intCnt]) Then
      Result.Add(LeftStr(cklEmpresas.Items[intCnt], 3));
end;

function TfrmLanSalSub.fGetFiltroSQL: string;
begin
  Result := Result + '  AND INI_EXERCI = "' + mskExercicio.Text + '" ';
  Result := Result + '  AND INI_CODEMP IN ' + fGetInEmpresas + ' ';
end;

function TfrmLanSalSub.fGetIndexFieldNames: string;
begin
  Result := 'EMP_CODEMP;INI_EXERCI;NCO_CODCON;INI_TIP_FC;INI_CLIFOR';
end;

function TfrmLanSalSub.fGetInEmpresas: String;
  Var
    intCnt : Integer;
begin
  Result := '';
  For intCnt := 0 To cklEmpresas.Items.Count-1 Do
  Begin
    If (cklEmpresas.Checked[intCnt]) Then
    Begin
      If fEmptyStr(Result) Then
        Result := '"' + LeftStr(cklEmpresas.Items[intCnt], 3) + '"'
      Else
        Result := Result + ', "' + LeftStr(cklEmpresas.Items[intCnt], 3) + '"'
    End;
  End;

  if fEmptyStr(Result) Then
    Result := '"' + VS_strCodEmp + '"';

  Result := '(' + Result + ')';
end;

function TfrmLanSalSub.fGravarDados(pgbProgresso: TcxProgressBar): Boolean;
  Var
    qryInsert: TUniQuery;
    qryDelete: TUniQuery;
    strFiltro: string;
    LDadosValidacao: TList<TDadosValidacaoSaldoInicialSub>;
begin
  Result := False ;
  if (not FFiltrou) or (not fValidaCampos(mskExercicio)) then
    Exit;

  btnGravarDadosDigitados.Enabled := False;
  cdsDados.DisableControls;

  LDadosValidacao := fConverteEstruturaParaValidacao(cdsDados.fGetDataset) ;
  try
    if not TValidaProcessoSaldoInicialSubconta.fValidaDprDet(LDadosValidacao, TMostraMensagemErroValidacao.pMostra, mskExercicio.Text, fGetEmps) then
    begin
      Exit;
    end;

    if not TValidaProcessoSaldoInicialSubconta.fValidaSaldoInicialSubcontasBloco(LDadosValidacao, TMostraMensagemErroValidacao.pMostra, cdsTotPlanco) then
    begin
      Exit ;
    end;
  finally
    FreeAndNil(LDadosValidacao) ;
    btnGravarDadosDigitados.Enabled := True;
    cdsDados.EnableControls;
  end;

  btnGravarDadosDigitados.Enabled := False;
  
  qryInsert := fCriaQueryContabilidade('DPRINI', Self.Name, Self);
  qryDelete := fCriaQueryContabilidade('DPRINI', Self.Name, Self);

  fStartTransaction;
  Try
    Screen.Cursor := crSQLWait;
    strFiltro := fGetFiltroSQL;
    
    qryDelete.Close;
    qryDelete.SQL.Clear;
    
    qryDelete.SQL.Add('SELECT * FROM DPRINI ');
    qryDelete.SQL.Add('WHERE TRUE ');
    qryDelete.SQL.Add(strFiltro);
    qryDelete.Open;
    while not qryDelete.IsEmpty do
    begin
      qryDelete.Delete;
    end;

    qryInsert.Close;
    qryInsert.SQL.Clear;
    
    qryInsert.SQL.Add('SELECT * ');
    qryInsert.SQL.Add('FROM DPRINI ');
    qryInsert.SQL.Add('WHERE TRUE ');
    qryInsert.SQL.Add(strFiltro);
    qryInsert.Open;

    cdsDados.DisableControls;
    Try
      pgbProgresso.Properties.Max := cdsDados.RecordCount;

      cdsDados.First;
      While Not cdsDados.Eof Do
      Begin
        pgbProgresso.Position := cdsDados.RecNo;
        Application.ProcessMessages;

        qryInsert.Append;
        qryInsert.FieldByName('INI_EXERCI').AsString := cdsDados.FieldByName('INI_EXERCI').AsString;
        qryInsert.FieldByName('INI_CODEMP').AsString := cdsDados.FieldByName('EMP_CODEMP').AsString;
        qryInsert.FieldByName('INI_CODCON').AsString := cdsDados.FieldByName('NCO_CODCON').AsString;
        qryInsert.FieldByName('INI_TIP_FC').AsString := cdsDados.FieldByName('INI_TIP_FC').AsString;
        qryInsert.FieldByName('INI_CLIFOR').AsString := cdsDados.FieldByName('INI_CLIFOR').AsString;
        qryInsert.FieldByName('INI_CREDEB').AsString := cdsDados.FieldByName('INI_CREDEB').AsString;
        qryInsert.FieldByName('INI_SALINI').AsFloat  := Abs(cdsDados.FieldByName('INI_SALINI').AsFloat);
        if cdsDados.FieldByName('INI_DTAALT').AsDateTime <= StrToDatetime('01/01/2000 00:00:00') then
          qryInsert.FieldByName('INI_DTAALT').Clear
        else
          qryInsert.FieldByName('INI_DTAALT').AsDateTime := cdsDados.FieldByName('INI_DTAALT').AsDateTime;
        if cdsDados.FieldByName('INI_OPEALT').AsString = '' then
          qryInsert.FieldByName('INI_OPEALT').Clear
        else
          qryInsert.FieldByName('INI_OPEALT').AsString := cdsDados.FieldByName('INI_OPEALT').AsString;
        qryInsert.Post;

        cdsDados.Next;
      End;

      pgbProgresso.Position := 0;

      fCommit;

      Result := True;

      fMensagem('ATENÇÃO!', 'Gravação concluída com sucesso!', ['&OK']);

      FAlterou := False;
      FAlterando := False;

      cdsDados.EmptyDataSet;
      cdsDados.Close;

      pgcDados.ActivePageIndex := 0;
      FFiltrou := False;
      
      pHabilitaControles(False);
    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '[TfrmLanSalSub.fGravarDados]');
      End;
    End;

    cdsDados.EnableControls;
  Finally
    Screen.Cursor := crDefault;
    btnGravarDadosDigitados.Enabled := True;
    FreeAndNil(qryInsert);
    FreeAndNil(qryDelete);
  End;
end;

function TfrmLanSalSub.fMovimentaLinha(const Key: Word;
  Sender: TObject): Boolean;
begin
  Result := False ;
  if not dbgBuscaConta.Visible then
  begin
    exit ;
  end;
  if key = VK_DOWN then
  begin
    if not cdsBusca.fGetDataset.Active then
    begin
      exit ;
    end ;
    cdsBusca.fGetDataset.Next ;
    Result := True ;
  end
  else if key = VK_UP then
  begin
    if not cdsBusca.fGetDataset.Active then
    begin
      exit ;
    end ;
    cdsBusca.fGetDataset.Prior ;
    Result := True ;
  end ;
  if Result then
  begin
    if Sender is TMaskEditFocus then
    begin
      TMaskEditFocus(Sender).Text := cdsBusca.FieldByName('CODCON').AsString;
    end
    else if Sender is TEditFocus then
    begin
      TMaskEditFocus(Sender).Text := cdsBusca.FieldByName('CONRED').AsString;
    end;
  end;
end;

procedure TfrmLanSalSub.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(mskExercicio);
end;

procedure TfrmLanSalSub.FormCreate(Sender: TObject);
begin
  inherited;
  pgcDados.ActivePageIndex := 0;
  mskExercicio.Text := FormatDateTime('yyyy', VS_Date);
  cdsDados := TZClient.Create(Self, '');
  cdsBusca := TZClient.Create(Self, '');
  GridCitelDBTableViewCitel.DataController.DataSource := cdsDados.dtsSource;
  dbgBuscaConta.DataSource := cdsBusca.dtsSource;
  strCnpjBase := '';
  FModoInclusao := False;
  mskConta.EditMask := fMskCon;
  dbgBuscaConta.Visible := False;
  FFiltrou := False;
  FAlterou := False;
  pHabilitaControles(False);
end;

procedure TfrmLanSalSub.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(cdsTotPlanco) then
    FreeAndNil(cdsTotPlanco);
end;

procedure TfrmLanSalSub.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaEmpresas;
  pMarcarEmpresaLogada;
end;

function TfrmLanSalSub.fPegaCnpjBase: String;
  Var
    intCnt : Integer;
begin
  Result := '';
  For intCnt := 0 To cklEmpresas.Items.Count-1 Do // OITO PRIMEIROS DEVEM SER IGUAIS
  Begin
    If (cklEmpresas.Checked[intCnt]) Then
    Begin
      Result := Copy(cklEmpresas.Items[intCnt], 7, Length(cklEmpresas.Items[intCnt]));
      Break;
    End;
  End;
end;

function TfrmLanSalSub.fSQLDados: String;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  NCO_CODCON, NCO_DESCRI, NCO_CONRED, EMP_CODEMP, EMP_NOMEMP, ' ;
  Result := Result + '  IFNULL(FOR_NOMFOR, CLI_NOMCLI) AS NOM_CLIFOR, ' ;
  Result := Result + '  IFNULL(INI_EXERCI, "' + mskExercicio.Text + '") AS INI_EXERCI, ' ;
  Result := Result + '  INI_CLIFOR, ' ;
  Result := Result + '  INI_TIP_FC, ' ;
  Result := Result + '  CAST(COALESCE(DPRINI.INI_DTAALT, "2000-01-01 00:00:00") AS DATETIME) AS INI_DTAALT, ' ;
  Result := Result + '  CAST(COALESCE(DPRINI.INI_OPEALT, "") AS CHAR(3)) AS INI_OPEALT, ' ;
  Result := Result + '  IFNULL(INI_SALINI, 0.00) AS INI_SALINI, ' ;
  Result := Result + '  CAST(COALESCE(INI_CREDEB,"C") AS CHAR(1)) AS INI_CREDEB ' ;
  Result := Result + 'FROM DPRINI ' ;
  Result := Result + 'INNER JOIN CADEMP ' ;
  Result := Result + '  ON EMP_CODEMP = INI_CODEMP ' ;
  Result := Result + 'INNER JOIN PLANCO ' ;
  Result := Result + '  ON  NCO_CODCON = INI_CODCON ' ;
  Result := Result + '  AND NCO_TPLACO = EMP_TPLACO ' ;
  Result := Result + 'LEFT JOIN CADCLI ';
  Result := Result + '  ON  UPPER(INI_TIP_FC) = "C" ' ;
  Result := Result + '  AND CLI_CODCLI = INI_CLIFOR ' ;
  Result := Result + 'LEFT JOIN CADFOR ';
  Result := Result + '  ON  UPPER(INI_TIP_FC) = "F" ' ;
  Result := Result + '  AND FOR_CODFOR = INI_CLIFOR ' ;
  Result := Result + 'WHERE TRUE ' ;
  Result := Result + fGetFiltroSQL;
  Result := Result + fFiltroSQLAtvPas('INI_CODCON');
  Result := Result + '  AND NCO_NATURE = "A" ';
  Result := Result + 'ORDER BY NCO_CODCON, EMP_CODEMP ';
end;

function TfrmLanSalSub.fTemInformacaoGrid: boolean;
begin
  Result := False ;

  if cdsDados.IsEmpty then
    Exit ;

  Result := True ;
end;

function TfrmLanSalSub.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  Try
    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin

      If (Sender = mskExercicio) Then
      Begin
        If fEmptyStr(mskExercicio.Text, True) Then
        Begin
          fMensagem('ATENÇÃO!', 'Obrigatório preenchimento do exercício!', ['&OK']);
          Result := False;
        End;
      End

      Else If (Sender = edtCodEmp) Then
      Begin
        If (Not fEmptyStr(edtCodEmp.Text)) Then
        Begin
          edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtCodEmp.Text], False);
          If (fEmptyStr(edtNomEmp.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
            Result := False;
          End;
        End
        Else
        Begin
          edtNomEmp.Clear;
          fMensagem('ATENÇÃO!', 'Informe a empresa', ['&Ok']);
          Result := False;
        End
      End

      Else If (Sender = mskConta) Then
      Begin
        pCarregaPlanoContabil(blnBuscaPorChave) ;
        If (Not fEmptyStr(fSemMascaraPlaNco(mskConta.Text))) And (fEmptyStr(edtDesConta.Text)) Then
        Begin
          fMensagem('ATENÇÃO!','A Conta informada é inválida ou não aceita subcontas!',['&OK']);
          Result := False;
        End;
      End

      Else If (Sender = edtConRed) Then
      Begin
        if dbgBuscaConta.Visible then
        begin
          dbgBuscaContaDblClick(Nil);
          pCarregaPlanoContabil(blnBuscaPorChave, True) ;
        end;
      End

      Else If (Sender = edtOpcSubconta) Then
      Begin
        Result := fValidaOpcaoSubConta(edtOpcSubconta) ;
      End

      Else If (Sender = edtCodCliForSubconta) Then
      Begin

        If Not fValidaOpcaoSubConta(edtOpcSubconta) Then
        Begin
          pSetFocus(edtOpcSubconta);
          Result := False ;
          Exit ;
        End ;
        Result := fCarregaCliForSubConta(edtCodCliForSubconta, edtNomCliForSubconta, edtOpcSubconta.Text) ;
      End

      Else If (Sender = edtTipo) Then
      Begin
        If edtTipo.ItemIndex < 0 Then
        Begin
          fMensagem('ATENÇÃO!','Informe o tipo de conta.',['&OK']);
          Result := False;
        End;
      End

      Else If (Sender = edtValor) Then
      Begin
        If edtValor.Value < 0 then
        Begin
          fMensagem('ATENÇÃO!','O Saldo inicial deve ser maior ou igual a zero.',['&OK']);
          Result := False;
        End;
      End
    End;
  Finally
    If Not Result Then
      pSetFocus(Sender);
  End;
end;

function TfrmLanSalSub.fValidaOpcaoSubConta(AedtCampo: TEditFocus): Boolean;
begin
  Result := False ;
  If fEmptyStr(AedtCampo.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'O Tipo Subconta deve ser preenchido!', ['&Ok']);
    exit ;
  End
  Else If (AedtCampo.Text <> 'C') And (AedtCampo.Text <> 'F') Then
  Begin
    fMensagem('ATENÇÃO!', 'O Tipo Subconta com valor inválido[C/F]!', ['&Ok']);
    Exit ;
  End;
  Result := True ;
end;

procedure TfrmLanSalSub.GridCitelDBTableViewCitelDblClick(Sender: TObject);
begin
  inherited;
  btnAlterar.Click;
end;

procedure TfrmLanSalSub.GridCitelDBTableViewCitelKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Not tbsFiltros.Enabled Then
    Exit;

  If (Key = VK_ESCAPE) And (pgcDados.ActivePage = tbsDados) Then
    pgcDados.ActivePage := tbsFiltros;
end;

procedure TfrmLanSalSub.mskContaClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmLanSalSub.mskContaKeyPress(Sender: TObject; var Key: Char);
  Var
    strTplaco: string;
    arrPlan: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    strTplaco := fRetTplacoEmpresaLogada(edtCodEmp.Text) ;                                                                                                           
    If Contabilidade.Consultas.fPesqPlanoContabil(Self, mskConta, edtDesConta, Nil, Key, arrPlan, True, strTplaco, True, False, '', False, '', '', '', '', True, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmLanSalSub.mskContaKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if not fMovimentaLinha(Key, Sender) then
  begin
    pBuscarConta(mskConta, False, 1);
  end;
end;

procedure TfrmLanSalSub.OnGeraExcel(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; CorFundo: TCorExcel);
begin

end;

procedure TfrmLanSalSub.pBuscarConta(dbeTexto: TCustomEdit; blnRed: Boolean;
  intTag: Integer);
var
  strTplaco: string ;
begin
  If (fEmptyStr(fSemMascaraPlaNco(dbeTexto.Text), True)) Then
  Begin
    dbgBuscaConta.Visible := False;
    Exit;
  End;

  strTplaco := fRetTplacoEmpresaLogada(edtCodEmp.Text) ;

  dbgBuscaConta.Tag := 0;

  cdsBusca.qryQuery.Close;
  cdsBusca.qryQuery.SQL.Clear;
  cdsBusca.qryQuery.SQL.Add(' SELECT NCO_CODCON AS CODCON, NCO_DESCRI AS DESCON, NCO_CONRED AS CONRED ');
  cdsBusca.qryQuery.SQL.Add('   FROM PLANCO ');
  cdsBusca.qryQuery.SQL.Add('  WHERE TRUE AND NCO_TPLACO = :TPLACO ');
  cdsBusca.qryQuery.ParamByName('TPLACO').AsString := strTplaco ;
  cdsBusca.qryQuery.SQL.Add('  AND NCO_SUBCNT = "S" ');
  If (blnRed) Then
    cdsBusca.qryQuery.SQL.Add('  AND (NCO_CONRED LIKE :CODCON) ')
  Else
    cdsBusca.qryQuery.SQL.Add('  AND (NCO_CODCON LIKE :CODCON) ');

  cdsBusca.qryQuery.SQL.Add('  AND IFNULL(NCO_NATURE,"A") = "A" ') ;

  cdsBusca.qryQuery.ParamByName('CODCON').AsString := '%' + fTiraCaracEspeciais(fSemMascaraPlaNco(dbeTexto.Text), True, True, True, True, True) + '%';
  cdsBusca.qryQuery.SQL.Add('  ORDER BY NCO_CODCON ');

  cdsBusca.fAbreClient(True, '[TfrmLanSalSub.pBuscarConta]');

  If (Not cdsBusca.qryQuery.IsEmpty) Then
  Begin
    If (blnRed) Then
    begin
      if (intTag = 1) then
        cdsBusca.qryQuery.Locate('NCO_CODCON', mskConta.Text, []);
    end;

    dbgBuscaConta.Left := dbeTexto.Left;
    dbgBuscaConta.Top := dbeTexto.Top + dbeTexto.Height + 1;
    dbgBuscaConta.Visible := True;
    dbgBuscaConta.Tag := intTag;
    if blnRed then
    begin
      dbgBuscaConta.Tag := dbgBuscaConta.Tag + 10 ;
    end;
  End
  Else
    dbgBuscaConta.Visible := False;
end;

procedure TfrmLanSalSub.pCarregaEmpresas;
  Var
    qryCadEmp : TUniQuery;
begin
  qryCadEmp := fCriaQuery(Self);
  Try
    qryCadEmp.Close;
    qryCadEmp.SQL.Clear;
    qryCadEmp.SQL.Add(' SELECT CONCAT(EMP_CODEMP, " - ", IFNULL(EMP_C_G_C_,"")) AS EMPRESA ');
    qryCadEmp.SQL.Add('   FROM CADEMP ');
    qryCadEmp.SQL.Add('  WHERE IFNULL(EMP_C_G_C_,"") <> "" ');
    qryCadEmp.SQL.Add('  ORDER BY EMP_CODEMP ');
    qryCadEmp.Open;

    cklEmpresas.Items.Clear;

    qryCadEmp.First;
    While Not qryCadEmp.Eof Do
    Begin
      cklEmpresas.Items.Add(qryCadEmp.FieldByName('EMPRESA').AsString);
      qryCadEmp.Next;
    End;

    qryCadEmp.Close;
  Finally
    FreeAndNil(qryCadEmp);
  End;
end;

procedure TfrmLanSalSub.pCarregaPlanoContabil(const blnBuscaPorChave: Boolean; blnCampoContaReduzida: Boolean);
var
  strSQL: string;
  qryCampos: TUniQuery;
begin
  strSQL := '';
  qryCampos := fCriaQuery;
  Try
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  NCO_DESCRI ';
    strSQL := strSQL + IfThen(not blnCampoContaReduzida,
                       ', NCO_CONRED ');
    strSQL := strSQL + 'FROM PLANCO ';
    strSQL := strSQL + 'WHERE TRUE ';
    strSQL := strSQL + '  AND NCO_CODCON = :CODCON ';
    strSQL := strSQL + '  AND NCO_SUBCNT = "S" ';
    strSQL := strSQL + IfThen(not blnBuscaPorChave,
                       '  AND NCO_TPLACO = :TPLACO ');

    qryCampos.SQL.Add(strSQL);
    qryCampos.ParamByName('CODCON').AsString := fSemMascaraPlaNco(mskConta.Text);
    If Not blnBuscaPorChave Then
      qryCampos.ParamByName('TPLACO').AsString := fRetTplacoEmpresaLogada(edtCodemp.Text);

    qryCampos.Open;

    If qryCampos.RecordCount > 0 Then
    Begin
      edtDesConta.Text := qryCampos.FieldByName('NCO_DESCRI').AsString;
      If Not blnCampoContaReduzida Then
        edtConRed.Text := qryCampos.FieldByName('NCO_CONRED').AsString;
    End;
  Finally
    FreeAndNil(qryCampos);
  End;
end;

procedure TfrmLanSalSub.pCarregarDados;
begin
  fChamaTelaGravando(fCarregarDados);
end;

procedure TfrmLanSalSub.pCarregarTotPlanco;
var
  qryAux: TUniquery;
  strIn: string;
begin
  if Assigned(cdsTotPlanco) then
    FreeAndNil(cdsTotPlanco);

  qryAux := fCriaQuery();
  try
    qryAux.Close;
    qryAux.SQL.Clear;

    strIn := fGetInEmpresas;
    qryAux.SQL.Add('SELECT EMP_CODEMP AS CODEMP, "'+ mskExercicio.Text +'" AS EXERCI, NCO_CODCON AS CODCON, ');
    qryAux.SQL.Add('  ABS(COALESCE(INI_SALINI, 0)) AS SALINI, ');
    qryAux.SQL.Add('  CASE WHEN COALESCE(INI_SALINI, 0) < 0 THEN "C" ELSE "D" END AS DEBCRE ');
    qryAux.SQL.Add('FROM PLANCO ');
    qryAux.SQL.Add('CROSS JOIN CADEMP ');
    qryAux.SQL.Add('LEFT JOIN ( ');
    qryAux.SQL.Add('  SELECT INI_CODEMP, INI_CODCON, ');
    qryAux.SQL.Add('    SUM(CASE WHEN INI_CREDEB = "C" THEN -INI_SALINI ELSE INI_SALINI END) ');
    qryAux.SQL.Add('    AS INI_SALINI ');
    qryAux.SQL.Add('  FROM DPRINI ');
    qryAux.SQL.Add('  WHERE INI_EXERCI = "'+ mskExercicio.Text +'" AND INI_CODEMP IN ' + strIn + ' ');
    qryAux.SQL.Add('  GROUP BY INI_CODEMP, INI_CODCON ');
    qryAux.SQL.Add(') AS DPRINI_AGG ');
    qryAux.SQL.Add('ON NCO_CODCON = INI_CODCON AND EMP_CODEMP = INI_CODEMP ');
    qryAux.SQL.Add('WHERE NCO_SUBCNT = "S" AND NCO_NATURE = "A" ');
    qryAux.SQL.Add('  AND EMP_CODEMP IN ' + strIn + ' ');
    qryAux.SQL.Add('ORDER BY NCO_CODCON, EMP_CODEMP	');

    qryAux.Open;

    cdsTotPlanco := fCriaClientDatset(qryAux);
    cdsTotPlanco.IndexFieldNames := 'CODCON;CODEMP';
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmLanSalSub.pgcDadosChange(Sender: TObject);
begin
  inherited;
  btnGeraExcel.Visible := (pgcDados.ActivePage = tbsDados) And (Not cdsDados.IsEmpty);
end;

procedure TfrmLanSalSub.pHabilitaControles(const AHabilitar: Boolean; AAltera: Boolean = False);
begin
  btnIncluir.Enabled := not AHabilitar ;
  btnGravar.Enabled := AHabilitar ;
  btnCancela.Enabled := AHabilitar ;
  btnAlterar.Enabled := not AHabilitar ;
  btnExcluir.Enabled := not AHabilitar ;
  btnGravarDadosDigitados.Enabled  := not AHabilitar ;
  tbsFiltros.Enabled := not AHabilitar ;

  GridCitel.Enabled := not AHabilitar ;
  btnGeraExcel.Enabled := not AHabilitar ;

  gbDadosLancamento.Enabled := AHabilitar ;

  edtCodEmp.ReadOnly := AHabilitar and AAltera;
  mskConta.ReadOnly := AHabilitar and AAltera;
  edtConRed.ReadOnly := AHabilitar and AAltera;
  edtOpcSubconta.ReadOnly := AHabilitar and AAltera;
  edtCodCliForSubconta.ReadOnly := AHabilitar and AAltera;

  tbsDados.Enabled := FFiltrou;
end;

procedure TfrmLanSalSub.pInformacao(strInfo: String; pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) And (GetParentForm(pgbStatus).FindComponent('lblGravando') <> Nil) Then
  Begin
    TLabel(GetParentForm(pgbStatus).FindComponent('lblGravando')).Caption := strInfo;
    Application.ProcessMessages;
  End;
end;

procedure TfrmLanSalSub.pLimparCampos;
begin
  edtCodEmp.Text := '';
  edtNomEmp.Text := '';
  edtTipo.ItemIndex := -1;
  mskConta.Text := '';
  edtConRed.Text := '';
  edtDesConta.Text := '';
  edtOpcSubConta.Text := '';
  edtCodCliForSubconta.Text := '';
  edtNomCliForSubconta.Text := '';
  edtValor.Value := 0;
end;

procedure TfrmLanSalSub.pMarcarEmpresaLogada;
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To cklEmpresas.Items.Count-1 Do
  Begin
    If LeftStr(cklEmpresas.Items[intCnt], 3) = VS_strCodEmp Then
    Begin
      cklEmpresas.Checked[intCnt] := True;
      strCnpjBase := fPegaCnpjBase;
      Break;
    End;
  End;
end;

procedure TfrmLanSalSub.pMostraTelaTotal;
var
  frmTotalPlanco: TfrmTotalPlanco;
  cdsAux: TUniClientDataset;
begin
  pCarregarTotPlanco;

  cdsAux := TUniClientDataSet.Create(Nil);
  pCriarFormularios(TfrmTotalPlanco, frmTotalPlanco);
  try
    cdsAux.Data := cdsTotPlanco.Data;
    frmTotalPlanco.CdsTot := cdsAux;
    frmTotalPlanco.ShowModal;

    if frmTotalPlanco.Confirmou then
      cdsTotPlanco.Data := cdsAux.Data;

    cdsTotPlanco.First;

  finally
    FreeAndNil(cdsAux);
    FreeAndNil(frmTotalPlanco);
  end;
end;

end.
