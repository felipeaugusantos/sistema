unit untCadCondPagtoEspecialProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxCheckBox, QColorLabel, cxGridDBTableView, cxGridCitel, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridBandedTableView,
  cxGridDBBandedTableView, cxClasses, cxGridCustomView, cxGrid, Vcl.StdCtrls,
  EditFocus, Vcl.Mask, MaskEditFocus, Vcl.DBCtrls, DBEditFocus, Vcl.CheckLst,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Datasnap.DBClient,
  UniClientDataSet, MemDS, DBAccess, Uni, untGravando, System.StrUtils,
  cxProgressBar, untTypesSistema;

Type
  TParametroProduto = record
    strCodIte: String;
    strDesIte: String;
    strCodFab: String;
    strUnidad: String;
    strDesmar: String;
    strSalFis: String;
    strSalDis: String;
    fltPerEst: Double;
    fltPreCusEdt: Double;
    fltPreVenEdt: Double;
    fltPerDes: Double;
    fltPreCusIte: Double;
    fltOutVal: Double;
    fltIcmSai: Double;
    fltImpFed: Double;
    fltDesOpe: Double;
    fltPreMed: Double;
    fltPreUlt: Double;
    fltImpUlt: Double;
    fltIpiEnt: Double;
    fltPreCom: Double;
    strPreDol: String;
    strEmpresasSelecionadas: String;
  end;

type
  TfrmCadCondPagtoEspecialProdutos = class(TfrmPaiCad)
    pnlEmpresa: TPanel;
    Label16: TLabel;
    clbEmpresa: TCheckListBox;
    pnlprin: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbeCodCes: TDBEditFocus;
    dbeDesCes: TDBEditFocus;
    dbeDtaIni: TDBEditFocus;
    dbeDtaFim: TDBEditFocus;
    pnlGrid: TPanel;
    cxgItens: TcxGridCitel;
    cxgItensTableView: TcxGridDBBandedTableViewCitel;
    cxgItensICE_CODITE: TcxGridDBBandedColumn;
    cxgItensITE_DESITE: TcxGridDBBandedColumn;
    cxgItensUNI_SIGUNI: TcxGridDBBandedColumn;
    cxgItensMAR_DESMAR: TcxGridDBBandedColumn;
    cxgItensITE_SALDOS: TcxGridDBBandedColumn;
    cxgItensITE_SALDIS: TcxGridDBBandedColumn;
    cxgItensITE_PRECUS: TcxGridDBBandedColumn;
    cxgItensITE_PREMED: TcxGridDBBandedColumn;
    cxgItensITE_PREULT: TcxGridDBBandedColumn;
    cxgItensITE_IMPULT: TcxGridDBBandedColumn;
    cxgItenslevel: TcxGridLevel;
    tbsCondPag: TTabSheet;
    cxgCndPag: TcxGridCitel;
    cxgCndPagTableView: TcxGridDBTableViewCitel;
    cxgCndPagTableViewCODCND: TcxGridDBColumn;
    cxgCndPagTableViewDESCND: TcxGridDBColumn;
    cxgCndPagLevel: TcxGridLevel;
    pnlCndPag: TPanel;
    ColorLabel2: TColorLabel;
    btnIncCndPag: TBitBtnLocked;
    dtsCondPagEsp: TDataSource;
    dtsCadCes: TDataSource;
    cxgItensITE_CODFAB: TcxGridDBBandedColumn;
    cdsCndPag: TUniClientDataSet;
    cdsCndPagCODCND: TStringField;
    cdsCndPagCNDPAG: TStringField;
    dtsCndPag: TDataSource;
    cxgCndPagTableViewCNDPAG: TcxGridDBColumn;
    pnlFiltrosProd: TPanel;
    edtUnidade: TEditFocus;
    Label12: TLabel;
    edtCodIte: TEditFocus;
    edtDesIte: TEditFocus;
    Label4: TLabel;
    edtDesGrupo: TEditFocus;
    mskLinhaGrupo: TMaskEditFocus;
    Label9: TLabel;
    Label11: TLabel;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtFornecedor: TEditFocus;
    Label10: TLabel;
    btnConfirmar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    cdsCndPagDESCND: TStringField;
    cdsCndPagSTATUS: TStringField;
    edtDescrUnidade: TEditFocus;
    btnCadastroCondPagto: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure dtsCondPagEspStateChange(Sender: TObject);
    procedure dbeDtaIniEnter(Sender: TObject);
    procedure dbeDtaFimEnter(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodIteEnter(Sender: TObject);
    procedure edtCodIteExit(Sender: TObject);
    procedure edtCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure cxgItensTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnIncCndPagClick(Sender: TObject);
    procedure cxgCndPagTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure btnCadastroCondPagtoClick(Sender: TObject);
    procedure edtUnidadeExit(Sender: TObject);

  private
    { Private declarations }
    cdsCadCes: TUniClientDataSet;
    qryCadCes: TUniQuery;
    qryCadUni: TUniQuery;
    qryCondPag: TUniQuery;

    strEmpSelAnt: String;
    strIteAtu: string;
    FInseriuItem: Boolean;

    stlCondAltLck: TStringList; // ARMAZENA CONDICÃO QUE ESTÁ SENDO ALTERADA

    strCodCesExc, strCodEmpExc, strSequencialExc: String;

    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pOpenQueryCadCes;
    procedure pCarregaEmpresa;
    procedure pCarregaCondicoes(strAutIncCes: String);
    procedure pLimpaDadosItem;
    function fCarregaItens(strCodCes: String): Boolean;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pMarcarEmpresas(strEmpresas: String);
    function fGetEmpresasSelecionadas: String;
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pEnableDisablePanel(Panel: TPanel; blnEnabled: Boolean = True);
    function fItemJaCadastrado(strCodIte: String): Boolean;
    function fIncluirProdutoCds(var strMsgProJaInc, strMsgProIncOu: String;
      Parametros: TParametroProduto): Boolean;
    function fAdicionaItem(pgbStatus: TcxProgressBar): Boolean;
    procedure pAdicionaItem;
    procedure pDeletaItensAssociacao(strAutInc: String);
    function Gravar(AProgress: TcxProgressBar = Nil;
      strAutoIncremCondEsp: String = ''): Boolean;
    procedure pGravarEmpresas(strAutIncCes: String;
      pgbStatus: TcxProgressBar = Nil);
    procedure pGravarCondicoes(strAutIncCes: String; pgbStatus: TcxProgressBar);
    function fGravarAssociacao(pgbStatus: TcxProgressBar): Boolean;
    procedure pDestravaELimpaStlCondLck;
    function fRetornaChaveLckCond: String;
    function fTravaERegistraStlCondLck: Boolean;
    procedure pAlteraStatusTemp(strStatus: String);
    procedure pInsereDEL_ITECES;
    procedure pInsereDEL_CESEMP;
    procedure pInsereDEL_CNDCES;
    function fExcluirAssociacao(pgbStatus: TcxProgressBar): Boolean;
    procedure pCarregaDados;
    function fSqlWhere(strCesAtu, strCodIte: String): String;
    function fItemCadastradoAssociacao(strCesAtu, strCodIte, strEmpSel: String;
      dtaDtaIni, dtaDtaFim: TDateTime; Var strMsgCes: String): Boolean;
    function fAdicionaCondPagtoEsp(pgbStatus: TcxProgressBar): Boolean;
    procedure pAdicionaCondPagtoEsp;
    procedure pAlteraStatusCondPag(strStatus: String);
    function fTemFiltroSelecionado: Boolean;
    procedure pDeletarCondicoes(strAutIncCes: String;
      pgbStatus: TcxProgressBar);
    procedure pReajustarBotoesRodape;
    function fSqlDefault: String;
    procedure pAdicionaCDS(qryGen: TUniQuery; Var strMsgProJaInc: String;
      Var strMsgProIncOu: String);
    procedure pExibirMensagemTrava(strMsgProJaInc: String;
      strMsgProIncOu: String);
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean)
      : Boolean; override;

  public
    { Public declarations }

  end;

implementation

{$R *.dfm}

Uses untFuncoesSimples, untObservacao, untConsultas, untCadCondicoes;

procedure TfrmCadCondPagtoEspecialProdutos.btnAlterarClick(Sender: TObject);
begin
  If (Not cdsCadCes.IsEmpty) Then
    If (fTravaERegistraStlCondLck) Then
      Exit;
  inherited;

  { ************************************************ }
  { * POR CAUSA DA TRAVA DE REDEATUALIZO IMAGINANDO* }
  { * QUE OUTRO USUARIO ALTEROU EM OUTRA ESTAÇÃO   * }
  { **********************************************LE }
  pCarregaDados;

  If (blnAlterou) Then
  Begin
    pgcDados.ActivePageIndex := 0;
    pHabilitaCodigo(dbeCodCes, dbeDesCes, False);
    cxgItens.Refresh;
    pAfterScroll(Nil);
  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.btnCadastroCondPagtoClick(
  Sender: TObject);
begin
  inherited;
  pCriarForm(TfrmCadCondicoes);
end;

procedure TfrmCadCondPagtoEspecialProdutos.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaDados;

  pLimpaDadosItem;
  pAfterScroll(Nil);

  If stlCondAltLck.Count > 0 Then
    pDestravaELimpaStlCondLck;

  pgcDados.ActivePageIndex := 0;
end;

procedure TfrmCadCondPagtoEspecialProdutos.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimpaDadosItem;
end;

procedure TfrmCadCondPagtoEspecialProdutos.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  if (not fTemFiltroSelecionado) then
  Begin
    if not fPergunta
      ('Nenhum filtro foi selecionado. Deseja incluir TODOS os produtos cadastrados?')
    then
      Exit;
  End;

  FInseriuItem := False;
  If (fVerificaCampos()) Then
  Begin
    pAdicionaItem;
    pLimpaDadosItem;
    edtCodIte.Enabled := True;
    FInseriuItem := True;
  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.btnExcluirClick(Sender: TObject);
Var
  strGetHost: String;
begin
  strGetHost := '';
  strGetHost := fGetHostLock(fRetornaChaveLckCond);
  If Not fEmptyStr(strGetHost) Then
  Begin
    fMensagem('Atenção',
      'Esta associação de condições especiais está sendo alterada em outra estação - '
      + strGetHost + '.' + #13 +
      'Aguarde a liberação para dar continuidade.', ['&Ok']);
    Exit;
  End;

  strCodCesExc := qryTabela.FieldByName('CES_CODIGO').AsString;
  strCodEmpExc := fGetEmpresasSelecionadas;
  strSequencialExc := qryTabela.FieldByName('AUTOINCREM').AsString;

  Try
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
    Try
      strMensagemExclusao :=
        'Deseja realmente excluir a associação de condições especiais completa?';
      inherited;
      If (blnExcluiu) Then
      Begin
        Try
          If fChamaTelaGravando(fExcluirAssociacao) Then
            fCommit
          Else
            fRollBack;
        Except
          On E: Exception Do
          Begin
            fRollBack;
            pMensagensErro(E.Message,
              '[TfrmCadCondPagtoEspecialProdutos.btnExcluirClick]');
          End;
        End;
      End
      Else
        fRollBack;
    Finally
      blnStartTransactionNoPaiMasCommitRoolBackNoFilho := False;
    End;
    pgcDados.ActivePageIndex := 0;
    pCarregaDados;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnExcluirClick]');
    End;
  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.btnGravarClick(Sender: TObject);
begin
  pgcDados.ActivePage := tbsGeral;

  If fEmptyStr(fGetEmpresasSelecionadas) Then
  Begin
    fMensagem('', 'Selecione alguma empresa!', ['&OK']);
    pSetFocus(clbEmpresa);
    Exit;
  End;

  If (Not fValidaCampos(dbeDesCes, True)) Then
    Exit;

  If (Not fValidaCampos(dbeDtaIni, True))  Or (Not fValidaCampos(dbeDtaFim, True)) then
    Exit;

  If ((Not cdsCadCes.Active) Or (cdsCadCes.IsEmpty)) Then
  Begin
    fMensagem('', 'Inclua os itens da associação!', ['&OK']);
    Exit;
  End;

  If (cdsCndPag.IsEmpty) Then
  Begin
    fMensagem('','Selecionar ao menos uma condição de pagamento especial!',['&OK']);
    pgcDados.ActivePage := tbsCondPag;
    pSetFocus(btnIncCndPag);
    Exit;
  End;

  Try
    fChamaTelaGravando(fGravarAssociacao);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  If stlCondAltLck.Count > 0 Then
    pDestravaELimpaStlCondLck;
end;

procedure TfrmCadCondPagtoEspecialProdutos.btnIncCndPagClick(Sender: TObject);
Var
  chrKey: Char;
  arrCondPag: TConsultasArray;

begin
  { ****************************************************** }
  { * NOVA CONSULTA DE CONDIÇÕES DE PAGAMENTO ESPECIAIS * }
  { ***************************************************KM* }
  chrKey := '/';
  If fPesqCondEsp(Self, Nil, Nil, qryCondPag, chrKey, arrCondPag, False) Then
    pAdicionaCondPagtoEsp;
end;

procedure TfrmCadCondPagtoEspecialProdutos.btnIncluirClick(Sender: TObject);
Var
  intContador: Integer;
begin
  inherited;
  pgcDados.ActivePageIndex := 0;
  cdsCndPag.EmptyDataSet;

  fCarregaItens('');
  pCarregaCondicoes('');
  pHabilitaCodigo(dbeCodCes, dbeDesCes, False);
  pDeletaTemporaria;

  { ********************************** }
  { * SELECIONANDO TODAS AS EMPRESAS * }
  { *******************************LU* }
  For intContador := 0 To clbEmpresa.Items.Count - 1 Do
  Begin
    clbEmpresa.Checked[intContador] := True;
  End;

  pLimpaDadosItem;
end;

procedure TfrmCadCondPagtoEspecialProdutos.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrAssociacoes: TConsultasArray;
begin
  pgcDados.ActivePageIndex := 0;

  { ****************************************************** }
  { * NOVA CONSULTA DE ASSOCIACAO DE CONDIÇÕES ESPECIAIS * }
  { ***************************************************KM* }
  chrKey := '/';
  If fPesqAssociacaoCondEsp(Self, Nil, Nil, qryTabela, chrKey,
    arrAssociacoes) Then
  Begin
    pCarregaDados;
  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.cxgCndPagTableViewKeyDown
  (Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And (btnIncCndPag.Enabled) Then
  Begin
    If (cdsCndPag.Active) And (Not cdsCndPag.IsEmpty) Then
      pAlteraStatusCondPag('D');
  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.cxgItensTableViewKeyDown
  (Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And (dtsCondPagEsp.State In dsEditModes) Then
  Begin
    If (cdsCadCes.Active) And (Not cdsCadCes.IsEmpty) Then
      pAlteraStatusTemp('D');
  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.dbeDtaFimEnter(Sender: TObject);
begin
  inherited;
  If (qryTabela.State = dsInsert) Then
    dbeDtaFim.Text := DateToStr(VS_Date);

end;

procedure TfrmCadCondPagtoEspecialProdutos.dbeDtaIniEnter(Sender: TObject);
begin
  inherited;
  If (qryTabela.State = dsInsert) Then
    dbeDtaIni.Text := DateToStr(VS_Date);

end;

procedure TfrmCadCondPagtoEspecialProdutos.dtsCondPagEspStateChange
  (Sender: TObject);
begin
  inherited;
  pEnableDisablePanel(pnlprin, qryTabela.State In [dsInsert, dsEdit]);
  pEnableDisablePanel(pnlCndPag, qryTabela.State In [dsInsert, dsEdit]);
end;

procedure TfrmCadCondPagtoEspecialProdutos.edtCodIteEnter(Sender: TObject);
begin
  inherited;
  strIteAtu := edtCodIte.Text;
end;

procedure TfrmCadCondPagtoEspecialProdutos.edtCodIteExit(Sender: TObject);
begin
  inherited;
  If edtCodIte.ReadOnly Then
    Exit;

  If not fEmptyStr(edtCodIte.Text) Then
  Begin
    edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
    edtUnidade.Text := fRetUnidadeItem(edtCodIte.Text);
    edtDescrUnidade.Text := fRetNomUnidade(edtUnidade.Text);
  End;

  edtDesIte.Enabled := False;

  If fEmptyStr(edtDesIte.Text) And (Not fEmptyStr(edtCodIte.Text)) Then
  Begin
    fMensagem('AVISO', 'Código do Produto não encontrado.', ['&O K']);
    edtCodIte.Clear;
    pSetFocus(edtCodIte);
  End;

end;

procedure TfrmCadCondPagtoEspecialProdutos.edtCodIteKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
  qryConIte: TUniQuery;
begin
  inherited;

  If edtCodIte.ReadOnly Then
    Exit;

  Try
    qryConIte := fCriaQuery(Self);
    if fPesqItem(conIteSimples, Self, edtCodIte, edtDesIte, qryConIte, Key,arrSel, True, nil, 'Consulta de Itens', '1') then
    Begin
      If fValidaCampos(edtCodIte, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryConIte);
  End;

end;

procedure TfrmCadCondPagtoEspecialProdutos.edtFornecedorExit(Sender: TObject);
begin
  inherited;

  If edtFornecedor.ReadOnly Then
    Exit;

  If fEmptyStr(edtFornecedor.Text) Then
    edtDesFornecedor.Text := 'TODOS'
  Else
    edtDesFornecedor.Text := fRetNomFornecedor(edtFornecedor.Text);

  edtDesFornecedor.Enabled := False;

  If fEmptyStr(edtDesFornecedor.Text) And
    (Not fEmptyStr(edtFornecedor.Text)) Then
  Begin
    fMensagem('AVISO', 'Código do fornecedor não encontrado.', ['&O K']);
    edtFornecedor.Clear;
    pSetFocus(edtFornecedor);
  End;

end;

procedure TfrmCadCondPagtoEspecialProdutos.edtFornecedorKeyPress
  (Sender: TObject; var Key: Char);
Var
  arrFornec: TConsultasArray;
begin
  inherited;
  If edtFornecedor.ReadOnly Then
    Exit;

  { ********************************* }
  { * NOVA CONSULTA DE FORNECEDORES * }
  { ******************************RV* }
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil,
    Key, arrFornec) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.edtMarcaExit(Sender: TObject);
begin
  inherited;

  If edtMarca.ReadOnly Then
    Exit;

  If fEmptyStr(edtMarca.Text) Then
    edtDesMarca.Text := 'TODOS'
  Else
    edtDesMarca.Text := fRetNomMarca(edtMarca.Text);

  edtDesMarca.Enabled := False;

  If fEmptyStr(edtDesMarca.Text) And (Not fEmptyStr(edtMarca.Text)) Then
  Begin
    fMensagem('AVISO', 'Código da marca não encontrado.', ['&O K']);
    edtMarca.Clear;
    pSetFocus(edtMarca);
  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrMarca: TConsultasArray;
begin
  inherited;

  If edtMarca.ReadOnly Then
    Exit;

  { *************************** }
  { * NOVA CONSULTA DE MARCAS * }
  { ************************DP* }
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrMarca) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadCondPagtoEspecialProdutos.edtUnidadeExit(Sender: TObject);
begin
  inherited;
  If edtUnidade.ReadOnly Then
    Exit;

  If fEmptyStr(edtUnidade.Text) Then
    edtDescrUnidade.Text := 'TODOS'
  Else
    edtDescrUnidade.Text := fRetNomUnidade(edtUnidade.Text);

  edtDescrUnidade.Enabled := False;

  If fEmptyStr(edtDescrUnidade.Text) And (Not fEmptyStr(edtUnidade.Text))  Then
  Begin
    fMensagem('AVISO','Unidade não encontrada.', ['&O K']);
    edtUnidade.Clear;
    pSetFocus(edtUnidade);
  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.edtUnidadeKeyPress(Sender: TObject;
  var Key: Char);
var
  chrKey: Char;
  arrUnidades: TConsultasArray;
begin
  inherited;

  { ***************************** }
  { * NOVA CONSULTA DE UNIDADES * }
  { **************************AC* }
  chrKey := Key;
  if fPesqUnidade(Self, edtUnidade, edtDescrUnidade, Nil, qryCadUni, chrKey, arrUnidades)
  then
  begin
    If fValidaCampos(edtUnidade, True) Then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmCadCondPagtoEspecialProdutos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCadUni);
  FreeAndNil(cdsCadCes);
  FreeAndNil(qryCadCes);
  FreeAndNil(qryCondPag);

  If Assigned(stlCondAltLck) Then
  Begin
    pDestravaELimpaStlCondLck;
    FreeAndNil(stlCondAltLck);
  End;

end;

procedure TfrmCadCondPagtoEspecialProdutos.FormCreate(Sender: TObject);
begin
  inherited;
  { Se resolução disponível for inferior ou igual à (1024 x 768), maximiza tela! }
  If (Screen.Width <= 1366) Or ((Screen.Height - VS_HEIGHT_START_MENU_WINDOWS)
    < 768) Then
    Self.WindowState := wsMaximized;

  strNomeTabela := 'CADCES';
  strNomeCampo := 'CES_CODIGO';

  qryTabela := fCriarQuery('SELECT * FROM CADCES WHERE FALSE', Self);
  qryTabela.AfterOpen := pAfterOpen;
  qryTabela.AfterScroll := pAfterScroll;
  dtsCondPagEsp.DataSet := qryTabela;
  cdsCndPag.CreateDataSet;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodCes;

  stlCondAltLck := TStringList.Create;
  btnCadastroCondPagto.Visible := (fCfgSis('USACND', varBoolean));

  pCriaTemporaria;
end;

procedure TfrmCadCondPagtoEspecialProdutos.FormResize(Sender: TObject);
begin
  inherited;
  pReajustarBotoesRodape;
end;

procedure TfrmCadCondPagtoEspecialProdutos.pCriaTemporaria;
begin
  cdsCadCes := TUniClientDataSet.Create(Self);
  qryCadCes := fCriaQuery(Self);
  qryCadUni := fCriaQuery(Self);
  qryCondPag := fCriaQuery(Self);
end;

procedure TfrmCadCondPagtoEspecialProdutos.pDeletaTemporaria;
begin
  If cdsCadCes.Active Then
    cdsCadCes.EmptyDataSet;
end;

function TfrmCadCondPagtoEspecialProdutos.fCarregaItens
  (strCodCes: String): Boolean;
Var
  strSQL: String;
begin
  pDeletaTemporaria;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ICE_CODITE, ';
  strSQL := strSQL + '  ITE_DESITE, ';
  strSQL := strSQL + '  ITE_CODFAB, ';
  strSQL := strSQL + '  UNI_SIGUNI, ';
  strSQL := strSQL + '  ITE_REFERE, ';
  strSQL := strSQL + '  MAR_DESMAR, ';
  strSQL := strSQL + fSQLSaldoDisponivel('', True) + ' AS ITE_SALDIS, ';
  strSQL := strSQL +
    '  (ITE_SALDOS + ITE_QTEF_A + ITE_QTEF_F + ITE_QTEF_P + ITE_QTPDBF) AS ITE_SALFIS, ';
  strSQL := strSQL + '  "A" AS ICE_STATUS, ';
  // VALORES DO CADASTRO DE PRODUTOS
  strSQL := strSQL + '  ITE_PRECUS, ';
  strSQL := strSQL + '  ITE_OUTVAL, ';
  strSQL := strSQL + '  ITE_ICMSAI, ';
  strSQL := strSQL + '  ITE_IMPFED, ';
  strSQL := strSQL + '  ITE_DESOPE, ';
  strSQL := strSQL + '  IFNULL(ITE_PREMED, 0.00) AS ITE_PREMED, ';
  strSQL := strSQL + '  IFNULL(ITE_PREULT, 0.00) AS ITE_PREULT, ';
  strSQL := strSQL + '  IFNULL(ITE_IMPULT, 0.00) AS ITE_IMPULT, ';
  strSQL := strSQL + '  ITE_IPIENT, ';
  strSQL := strSQL + '  ITE_PRECOM, ';
  strSQL := strSQL + '  ITECES.ICE_SEQGER, ';
  strSQL := strSQL + '  ITECES.ICE_CODEMP, ';
  strSQL := strSQL + '  ITECES.ICE_ULTALT, ';
  strSQL := strSQL + '  CADCES.AUTOINCREM AS AUTINC_CONDPAGESP ';
  strSQL := strSQL + ' FROM CADCES ';
  strSQL := strSQL +
    '  INNER JOIN ITECES ON ITECES.ICE_SEQGER = CADCES.AUTOINCREM ';
  strSQL := strSQL +
    '  INNER JOIN CADITE ON CADITE.ITE_CODITE = ITECES.ICE_CODITE ';
  strSQL := strSQL +
    '  INNER JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ';
  strSQL := strSQL +
    '  INNER JOIN CADUNI ON CADUNI.UNI_CODUNI = CADITE.ITE_CODUNI ';
  strSQL := strSQL +
    '  INNER JOIN CADMAR ON CADMAR.MAR_CODMAR = CADITE.ITE_CODMAR ';
  strSQL := strSQL + ' WHERE ITEGER.ITE_CODEMP = ' + QuotedStr(VS_strCodEmp);
  strSQL := strSQL + '  AND CADCES.CES_CODIGO = :CODCES';

  qryCadCes.Close;
  qryCadCes.SQL.Clear;
  qryCadCes.SQL.Add(strSQL);
  qryCadCes.ParamByName('CODCES').AsString := strCodCes;
  TfrmGravando.fExecutarModalA(pOpenQueryCadCes,
    'Aguarde, Carregando itens da Condição Especial ...', '');

  dtsCadCes.DataSet := nil;

  If Assigned(cdsCadCes) Then
    FreeAndNil(cdsCadCes);

  cdsCadCes := fCriaClientDatset(qryCadCes, False, Self);
  cdsCadCes.Filter := 'ICE_STATUS <> ' + QuotedStr('D');
  cdsCadCes.Filtered := True;

  // VALORES DO CADASTRO DE PRODUTOS
  TFloatField(cdsCadCes.FieldByName('ITE_PRECUS')).DisplayFormat := '#,##0.00';
  TFloatField(cdsCadCes.FieldByName('ITE_PREMED')).DisplayFormat := '#,##0.00';
  TFloatField(cdsCadCes.FieldByName('ITE_PREULT')).DisplayFormat := '#,##0.00';
  TFloatField(cdsCadCes.FieldByName('ITE_IMPULT')).DisplayFormat := '#,##0.00';

  // SALDO
  TFloatField(cdsCadCes.FieldByName('ITE_SALFIS')).DisplayFormat := '#,##0.000';
  TFloatField(cdsCadCes.FieldByName('ITE_SALDIS')).DisplayFormat := '#,##0.000';

  dtsCadCes.DataSet := cdsCadCes;

  Result := True;
end;

procedure TfrmCadCondPagtoEspecialProdutos.pOpenQueryCadCes;
begin
  qryCadCes.Open;
end;

procedure TfrmCadCondPagtoEspecialProdutos.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaEmpresa;
  pgcDados.ActivePageIndex := 0;
  pAfterScroll(Nil);
  pSetaCodIte(dbeCodCes);
  pSetaCodIte(edtCodIte);
  pReajustarBotoesRodape;
end;

procedure TfrmCadCondPagtoEspecialProdutos.pCarregaEmpresa;
Var
  qryGen: TUniQuery;
  intContador: Integer;
Begin
  Try
    qryGen := fCriaQuery;
    clbEmpresa.Items.Clear;
    qryGen.SQL.Clear;
    qryGen.SQL.Add
      ('SELECT CONCAT(EMP_CODEMP," - ", EMP_NOMEMP) AS EMPNOM FROM CADEMP ORDER BY CONCAT(EMP_CODEMP," - ", EMP_NOMEMP)');
    qryGen.Open;
    qryGen.First;
    While Not qryGen.Eof Do
    Begin
      clbEmpresa.Items.Add(qryGen.FieldByName('EMPNOM').AsString);
      qryGen.Next;
    End;
    qryGen.Close;

    { ******************************** }
    { * SELECIONA TODAS AS EMPRESAS  * }
    { *****************************LU* }
    For intContador := 0 To clbEmpresa.Items.Count - 1 Do
      clbEmpresa.Checked[intContador] := True;
  Finally
    FreeAndNil(qryGen);
  End;
End;

procedure TfrmCadCondPagtoEspecialProdutos.pCarregaCondicoes
  (strAutIncCes: String);
Var
  qryCndCes: TUniQuery;
begin
  Try
    qryCndCes := fCriaQuery(Self);
    qryCndCes.SQL.Add
      ('SELECT CNDCES.*, CADCND.CND_CODIGO, CADCND.CND_DESCRI, CADCND.CND_CNDPAG,  "A" AS STATUS FROM CNDCES INNER JOIN CADCND ON CND_CODIGO = CES_CODCND WHERE CES_SEQGER = :SEQGER ORDER BY CADCND.CND_CODIGO');
    qryCndCes.ParamByName('SEQGER').AsString := strAutIncCes;
    qryCndCes.Open;

    cdsCndPag.DisableControls;
    cdsCndPag.EmptyDataSet;

    While (Not qryCndCes.Eof) Do
    Begin
      cdsCndPag.Append;
      cdsCndPag.FieldByName('CODCND').AsString :=
        qryCndCes.FieldByName('CND_CODIGO').AsString;
      cdsCndPag.FieldByName('DESCND').AsString :=
        qryCndCes.FieldByName('CND_DESCRI').AsString;
      cdsCndPag.FieldByName('CNDPAG').AsString :=
        fFormataCondPag(qryCndCes.FieldByName('CND_CNDPAG').AsString);
      cdsCndPag.FieldByName('STATUS').AsString :=
        qryCndCes.FieldByName('STATUS').AsString;
      cdsCndPag.Post;

      qryCndCes.Next;
    End;

    cdsCndPag.Filter := 'STATUS <> ' + QuotedStr('D');
    cdsCndPag.Filtered := True;
    cdsCndPag.EnableControls;
  Finally
    FreeAndNil(qryCndCes);
  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.pLimpaDadosItem;
Var
  intContador: Integer;
begin
  For intContador := 0 To Self.ComponentCount - 1 Do
  Begin
    If Components[intContador] is TMaskEdit Then
      TMaskEdit(Self.Components[intContador]).Clear;
    If Components[intContador] is TEditFocus Then
      TEditFocus(Self.Components[intContador]).Clear;
  End;

  btnConfirmar.Tag := 0;
  edtCodIte.Enabled := True;
  edtCodIte.Clear;
end;

procedure TfrmCadCondPagtoEspecialProdutos.pAfterOpen(DataSet: TDataSet);
begin
  if DataSet.Active then
  begin
    if DataSet.FindField('ICE_DTAINI') <> nil then
      TDateField(DataSet.FieldByName('ICE_DTAINI')).EditMask := '99/99/9999';

    if DataSet.FindField('ICE_DTAFIM') <> nil then
      TDateField(DataSet.FieldByName('ICE_DTAFIM')).EditMask := '99/99/9999';
  end;
end;

procedure TfrmCadCondPagtoEspecialProdutos.pAfterScroll(DataSet: TDataSet);
Var
  strEmpresas: string;
begin
  strEmpresas := fCampoTabela('GROUP_CONCAT(CES_CODEMP)', 'CESEMP',
    ['CES_SEQGER'], [qryTabela.FieldByName('AUTOINCREM').AsString]);
  pMarcarEmpresas(strEmpresas);
  strEmpSelAnt := fGetEmpresasSelecionadas;
  pnlEmpresa.Enabled := (qryTabela.State In [dsInsert, dsEdit]);
end;

procedure TfrmCadCondPagtoEspecialProdutos.pMarcarEmpresas(strEmpresas: String);
Var
  intContador: Integer;
begin
  For intContador := 0 To clbEmpresa.Items.Count - 1 Do
  Begin
    If Pos(LeftStr(clbEmpresa.Items[intContador], 3), strEmpresas) > 0 Then
      clbEmpresa.Checked[intContador] := True
    Else
      clbEmpresa.Checked[intContador] := False;
  End;
end;

function TfrmCadCondPagtoEspecialProdutos.fGetEmpresasSelecionadas: String;
Var
  intContador: Integer;
begin
  Result := '';
  clbEmpresa.Items.BeginUpdate;
  try
    For intContador := 0 To clbEmpresa.Items.Count - 1 Do
    Begin
      If clbEmpresa.Checked[intContador] Then
        Result := Result + LeftStr(clbEmpresa.Items[intContador], 3) + '_';
    End;
  finally
    clbEmpresa.Items.EndUpdate;
  end;
end;

procedure TfrmCadCondPagtoEspecialProdutos.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('CES_CODIGO');
  stlCamInd.Add('CES_DESCRI');
  stlCamInd.Add('CES_DTAINI');

  stlDesInd.Add('Código');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Data Inicial');
end;

procedure TfrmCadCondPagtoEspecialProdutos.pEnableDisablePanel(Panel: TPanel;
  blnEnabled: Boolean = True);
Var
  intContador: Integer;
begin
  If (Panel = pnlprin) Then
  Begin
    dbeCodCes.Enabled := blnEnabled;
    dbeDesCes.Enabled := blnEnabled;
    dbeDtaIni.Enabled := blnEnabled;
    dbeDtaFim.Enabled := blnEnabled;
    For intContador := 0 To Self.ComponentCount - 1 Do
    Begin
      If Components[intContador] is TMaskEdit Then
        TMaskEdit(Self.Components[intContador]).Enabled := blnEnabled;
      If Components[intContador] is TEditFocus Then
        TEditFocus(Self.Components[intContador]).Enabled := blnEnabled;
    End;
    btnConfirmar.Enabled := blnEnabled;
    btnCancelaItem.Enabled := blnEnabled;
  End
  Else If (Panel = pnlCndPag) Then
  Begin
    btnIncCndPag.Enabled := blnEnabled;
    btnCadastroCondPagto.Enabled := blnEnabled;
  End;
end;

function TfrmCadCondPagtoEspecialProdutos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
Var
  strMsgPro: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeDesCes) Then
    Begin
      If (fEmptyStr(dbeDesCes.Text)) Then
      Begin
        fMensagem('ATENÇÃO!',
          'A descrição da associação deve ser preenchida!', ['&Ok']);
        Result := False;
      End
    End

    Else If (Sender = dbeDtaIni) Then
    Begin

      If (dbeDtaIni.Enabled) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(dbeDtaIni.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'A data inicial deve ser preenchida!', ['&OK']);
          Result := False;
        End
        Else If (qryTabela.State = dsInsert) And
          (StrToDate(dbeDtaIni.Text) < VS_Date) Then
        Begin
          fMensagem('ATENÇÃO',
            'A data inicial deve ser maior ou igual à data atual!', ['&O K']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = dbeDtaFim) Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(dbeDtaFim.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A data final deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If Not fValidaPeriodo(dbeDtaIni.Text, dbeDtaFim.Text) Then
      Begin
        fMensagem('ATENÇÃO!',
          'A data final deve ser maior ou igual à data inicial!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodIte) And (Not edtCodIte.ReadOnly) Then
    Begin

      If (fEmptyStr(edtCodIte.Text)) Then
      // se for branco carrega todos na descricao
        edtDesIte.Text := 'TODOS'
      Else
      Begin
        If edtCodIte.Text <> strIteAtu then
          edtDesIte.Text := fRetNomProduto(edtCodIte.Text);

        If (fEmptyStr(edtDesIte.Text)) Then // caso nao seja encontrado
        Begin
          fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If fItemJaCadastrado(edtCodIte.Text) Then
        // verifica se o item já esta cadastrado
        Begin
          If (blnBuscaPorChave) Then
          Begin
            fMensagem('ATENÇÃO!',
              'Esse item já está nesta Associação!', ['&Ok']);
            Result := False;
          End;
        End
        Else
        Begin
          If (fItemCadastradoAssociacao(dbeCodCes.Text, edtCodIte.Text,
            fGetEmpresasSelecionadas, StrToDate(dbeDtaIni.Text),
            StrToDate(dbeDtaFim.Text), strMsgPro)) Then
          // verifica se já está cadastrado em outra associação
          Begin
            Try
              pCriarFormularios(TfrmObservacao, frmObservacao);
              frmObservacao.lblMensagem.Caption := 'ATENÇÃO';
              frmObservacao.memObs.Texto :=
                'Esse item já está em outra associação!' + #10#13 + strMsgPro;
              frmObservacao.ShowModal;
            Except
              On E: Exception Do
              Begin
                pMensagensErro(E.Message,
                  '[TfrmCadCondPagtoEspecialProdutos.pAdicionaItem]');
              End;
            End;
            pFreeAndNil(frmObservacao);
            Result := False;
          End;
        End;
      End;
    End
    Else If (Sender = edtUnidade) Then
    Begin
      If (fEmptyStr(edtUnidade.Text)) Then  // se for branco carrega todos na descricao
        edtDescrUnidade.Text := 'TODOS'
      Else
      Begin
        edtDescrUnidade.Text := fRetNomUnidade(edtUnidade.Text);
        If (fEmptyStr(edtDescrUnidade.Text)) Then // caso nao seja encontrado
        Begin
          fMensagem('ATENÇÃO!', 'Essa unidade não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadCondPagtoEspecialProdutos.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;

  If mskLinhaGrupo.ReadOnly Then
    Exit;

  If fEmptyStr(mskLinhaGrupo.Text) Then
    edtDesGrupo.Text := 'TODOS'
  Else
    edtDesGrupo.Text := fRetNomeLinhaGrupo(mskLinhaGrupo.Text);

  edtDesGrupo.Enabled := False;

  If fEmptyStr(edtDesGrupo.Text) And (Not fEmptyStr(mskLinhaGrupo.Text)) Then
  Begin
    fMensagem('AVISO', 'Código da linha/grupo não encontrado.', ['&O K']);
    mskLinhaGrupo.Clear;
    pSetFocus(mskLinhaGrupo);
  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.mskLinhaGrupoKeyPress
  (Sender: TObject; var Key: Char);
Var
  arrGrupos: TConsultasArray;
begin
  inherited;

  If mskLinhaGrupo.ReadOnly Then
    Exit;

  { ******************************** }
  { * NOVA CONSULTA DE LINHA/GRUPO * }
  { *****************************RV* }
  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, Nil, Key, arrGrupos) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmCadCondPagtoEspecialProdutos.fItemJaCadastrado
  (strCodIte: String): Boolean;
Var
  prcScroll: TprcScroll;
begin
  Try
    pDisableControls(cdsCadCes, prcScroll);

    Result := cdsCadCes.Locate('ICE_CODITE', strCodIte, []);

  Finally
    pEnableControls(cdsCadCes, prcScroll);
  End;

end;

function TfrmCadCondPagtoEspecialProdutos.fAdicionaItem
  (pgbStatus: TcxProgressBar): Boolean;
Var
  qryGen: TUniQuery;
  strMsgProJaInc: String; // ARMAZENA OS ITENS JÁ INCLUSOS NESTA ASSOCIAÇÃO
  strMsgProIncOu: String; // ARMAZENA OS ITENS JÁ INCLUSOS OUTRA ASSOCIAÇÃO
  prcScroll: TprcScroll;

begin
  Result := False;
  pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando Produto(s)...');

  Try
    qryGen := fCriaQuery;

    pDisableControls(cdsCadCes, prcScroll);

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add(fSqlDefault);
    If (Not fEmptyStr(edtCodIte.Text)) Then
      qryGen.ParamByName('CODITE').AsString := edtCodIte.Text;

    If Not fEmptyStr(mskLinhaGrupo.Text) Then
      qryGen.ParamByName('CODGRU').AsString := mskLinhaGrupo.Text;

    If Not fEmptyStr(edtFornecedor.Text) Then
      qryGen.ParamByName('CODFOR').AsString := edtFornecedor.Text;

    If Not fEmptyStr(edtMarca.Text) Then
      qryGen.ParamByName('CODMAR').AsString := edtMarca.Text;

    If Not fEmptyStr(edtUnidade.Text) Then
      qryGen.ParamByName('CODUNI').AsString := edtUnidade.Text;
    qryGen.Open;

    If qryGen.RecordCount = 0 Then
      fMensagem('', 'Nenhum Produto foi encontrado para essas condições!',
        ['&OK'], 0)
    Else
    Begin
      strMsgProJaInc := '';
      strMsgProIncOu := '';

      pInfoStatusGravacao(pgbStatus, 'Aguarde, Carregando Produto(s)...',
        qryGen.RecordCount);

      While Not qryGen.Eof Do
      Begin
        pStepStatusGravacao(pgbStatus);
        pAdicionaCDS(qryGen, strMsgProJaInc, strMsgProIncOu);

        qryGen.Next;
      End;

      Result := True;
    End;
    pExibirMensagemTrava(strMsgProJaInc, strMsgProIncOu);

    pEnableControls(cdsCadCes, prcScroll);

    cxgItens.Refresh;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function TfrmCadCondPagtoEspecialProdutos.fIncluirProdutoCds(var strMsgProJaInc,
  strMsgProIncOu: String; Parametros: TParametroProduto): Boolean;
var
  strMsgPro: String;
begin
  If (fItemCadastradoAssociacao(IIF(dbeCodCes.Text <> '', dbeCodCes.Text, ''),
    Parametros.strCodIte, Parametros.strEmpresasSelecionadas,
    StrToDate(dbeDtaIni.Text), StrToDate(dbeDtaFim.Text), strMsgPro)) Then
  Begin
    strMsgProIncOu := strMsgProIncOu + strMsgPro + #13#10;
  End

  Else If (fItemJaCadastrado(Parametros.strCodIte)) Then
  Begin
    strMsgProJaInc := strMsgProJaInc + Parametros.strCodIte + '  -  ' +
      Parametros.strDesIte + #13#10;
  End

  Else
  Begin
    { *************************** }
    { * INCLUI OU ALTERA O ITEM * }
    { ************************JB* }
    If (btnConfirmar.Tag > 0) Then
    Begin
      cdsCadCes.Edit;
      cdsCadCes.FieldByName('ICE_STATUS').AsString := 'E';
    End
    Else
    Begin
      cdsCadCes.Insert;
      cdsCadCes.FieldByName('ICE_STATUS').AsString := 'A';
    End;

    cdsCadCes.FieldByName('ICE_CODITE').AsString := Parametros.strCodIte;
    cdsCadCes.FieldByName('ITE_CODFAB').AsString := Parametros.strCodFab;
    cdsCadCes.FieldByName('ITE_DESITE').AsString := Parametros.strDesIte;
    cdsCadCes.FieldByName('UNI_SIGUNI').AsString := Parametros.strUnidad;
    cdsCadCes.FieldByName('MAR_DESMAR').AsString := Parametros.strDesmar;

    cdsCadCes.FieldByName('ITE_SALFIS').AsString := Parametros.strSalFis;
    cdsCadCes.FieldByName('ITE_SALDIS').AsString := Parametros.strSalDis;

    cdsCadCes.FieldByName('ITE_PRECUS').AsFloat := Parametros.fltPreCusIte;
    cdsCadCes.FieldByName('ITE_OUTVAL').AsFloat := Parametros.fltOutVal;
    cdsCadCes.FieldByName('ITE_ICMSAI').AsFloat := Parametros.fltIcmSai;
    cdsCadCes.FieldByName('ITE_IMPFED').AsFloat := Parametros.fltImpFed;

    if Parametros.fltPreMed > 0 then
      cdsCadCes.FieldByName('ITE_PREMED').AsFloat := Parametros.fltPreMed;

    if Parametros.fltPreUlt > 0 then
      cdsCadCes.FieldByName('ITE_PREULT').AsFloat := Parametros.fltPreUlt;

    if Parametros.fltImpUlt > 0 then
      cdsCadCes.FieldByName('ITE_IMPULT').AsFloat := Parametros.fltImpUlt;

    cdsCadCes.FieldByName('ITE_IPIENT').AsFloat := Parametros.fltIpiEnt;
    cdsCadCes.FieldByName('ITE_PRECOM').AsFloat := Parametros.fltPreCom;
    cdsCadCes.Post;
  End;

  Result := fEmptyStr(strMsgProJaInc + strMsgProIncOu);
end;

procedure TfrmCadCondPagtoEspecialProdutos.pAdicionaItem;
Begin
  Try
    fChamaTelaGravando(fAdicionaItem);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
End;

function TfrmCadCondPagtoEspecialProdutos.fGravarAssociacao
  (pgbStatus: TcxProgressBar): Boolean;
Var
  strDesCes: String;
  dtaDtaIni: TDateTime;
  dtaDtaFin: TDateTime;
  strMsgPro, strMsgProFInal: String;
  prcScroll: TprcScroll;
  strEmpresasSelecionadas: String;
  strSequencial: String;
begin
  pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Associação...');

  { ********************************************** }
  { * VERIFICA SE ALGUMA EMPRESA FOI SELECIONADA * }
  { *******************************************LU* }
  Result := False;

  strDesCes := dbeDesCes.Text;
  dtaDtaIni := StrToDate(dbeDtaIni.Text);
  dtaDtaFin := StrToDate(dbeDtaFim.Text);

  pnlInfo.Caption := 'Gerando Registros!!!';

  Try

    pDisableControls(cdsCadCes, prcScroll);

    strMsgProFInal := '';

    pInfoStatusGravacao(pgbStatus, 'Aguarde... Validando Itens...',
      cdsCadCes.RecordCount);

    cdsCadCes.First;

    { *************************************************************************** }
    { * ANTES DE GRAVAR OS ITENS VERIFICA NOVAMENTE SE ELES NÃO ESTAO EM OUTRAS * }
    { * PROMOÇÕES VIGENTES - FOI NECESSÁRIO VERIFICAR AQUI NOVAMENTE POR CAUSA  * }
    { * DA INCLUSAO DA OPÇÃO DE HERANÇA DE PROMOÇÃO                             * }
    { ************************************************************************LU* }
    strEmpresasSelecionadas := fGetEmpresasSelecionadas;

    While Not cdsCadCes.Eof Do
    Begin
      pStepStatusGravacao(pgbStatus);
      fItemCadastradoAssociacao(dbeCodCes.Text,
        cdsCadCes.FieldByName('ICE_CODITE').AsString, fGetEmpresasSelecionadas,
        dtaDtaIni, dtaDtaFin, strMsgPro);

      If Not fEmptyStr(strMsgPro) Then
        strMsgProFInal := strMsgProFInal + strMsgPro + #13#10;

      cdsCadCes.Next;
    End;

    cdsCadCes.First;

    If Not fEmptyStr(strMsgProFInal) Then
    Begin
      Result := False;

      Try
        pCriarFormularios(TfrmObservacao, frmObservacao);
        frmObservacao.lblMensagem.Caption :=
          'Associação não gravada! O(s) item(s) abaixo já estão em outras associações vigentes:';
        frmObservacao.memObs.Texto := strMsgProFInal;
        frmObservacao.ShowModal;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message,
            '[TfrmCadCondPagtoEspecialProdutos.btnGravarClick]');
        End;
      End;

      pFreeAndNil(frmObservacao);

      pnlInfo.Caption := '';
      pEnableControls(cdsCadCes, prcScroll);

      Exit;
    End;

    { ******************************** }
    { * COMEÇA A GRAVAR A ASSOCIAÇÃO * }
    { *****************************LU* }
    fStartTransaction;

    pDeletarCondicoes(qryTabela.FieldByName('AUTOINCREM').AsString, pgbStatus);

    pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Associação...');

    If qryTabela.State = dsBrowse Then
      qryTabela.Insert;

    If qryTabela.State = dsInsert Then
    Begin
      qryTabela.FieldByName('CES_CODIGO').AsString := fAtualizaProCod('CADCES', 'CES_CODIGO', '', 1, Nil,
        function (const AValue: String) : String
        begin
          Result := Concat(VS_strCodEmp, AValue);
        end
      );
      qryTabela.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADCES', VS_strCodEmp);;
    End;
    qryTabela.FieldByName('CES_CODEMP').AsString := VS_strCodEmp;
    qryTabela.FieldByName('CES_DESCRI').AsString := strDesCes;
    qryTabela.FieldByName('CES_DTAINI').AsDateTime := dtaDtaIni;
    qryTabela.FieldByName('CES_DTAFIM').AsDateTime := dtaDtaFin;
    qryTabela.FieldByName('CES_ULTALT').AsDateTime := fNow;
    qryTabela.Post;

    pInfoStatusGravacao(pgbStatus,
      'Aguarde... Deletando Itens Condição Especial...');
    pDeletaItensAssociacao(qryTabela.FieldByName('AUTOINCREM').AsString);

    pInfoStatusGravacao(pgbStatus,
      'Aguarde... Gravando Itens Condição Especial...', cdsCadCes.RecordCount);
    strSequencial := qryTabela.FieldByName('AUTOINCREM').AsString;

    If (Not Gravar(pgbStatus, strSequencial)) Then
    Begin
      fRollBack;
      fMensagem('', 'Ocorreu um erro na gravação da ITECES!', ['&OK']);
      pEnableControls(cdsCadCes, prcScroll);
      Exit;
    End;
    pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Empresas...',
      clbEmpresa.Items.Count);
    pGravarEmpresas(strSequencial, pgbStatus);

    pGravarCondicoes(strSequencial, pgbStatus);
    pEnableControls(cdsCadCes, prcScroll);

    pnlInfo.Caption := '';

    pInfoStatusGravacao(pgbStatus,
      'Gravação da Condição Especial Concluída... Carregando Dados.');

    fCommit;

    pDeletaTemporaria;
    pLimpaDadosItem;
    fCarregaItens(dbeCodCes.Text);
    pSetButton(qryTabela, btnIncluir, btnGravar, btnExcluir, btnCancela,
      btnAlterar, btnPesquisa, btnSair);
    pEnabled(Self, False);
    pSetFocus(btnIncluir);
    pAfterScroll(Nil);
    pgcDados.ActivePageIndex := 0;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pEnableControls(cdsCadCes, prcScroll);
      pnlInfo.Caption := '';
      pMensagensErro(E.Message,
        '[TfrmCadCondPagtoEspecialProdutos.btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.pDeletaItensAssociacao
  (strAutInc: String);
Var
  strSQL: String;
  qryGenPro: TUniQuery;
begin
  Try
    qryGenPro := fCriaQuery(nil);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ITECES WHERE ICE_SEQGER = :AUTINC ';

    qryGenPro.Close;
    qryGenPro.SQL.Clear;
    qryGenPro.SQL.Add(strSQL);
    qryGenPro.ParamByName('AUTINC').AsString := strAutInc;
    qryGenPro.ExecSQL;
    qryGenPro.Close;

  Finally
    FreeAndNil(qryGenPro);
  End;

end;

function TfrmCadCondPagtoEspecialProdutos.Gravar
  (AProgress: TcxProgressBar = Nil; strAutoIncremCondEsp: String = ''): Boolean;
Var
  LInsert: String;
  LValues: String;
  LIndex: Integer;
begin
  Result := True;

  Application.ProcessMessages;
  Try
    LInsert := '';
    LInsert := LInsert + ' INSERT INTO ITECES( ';
    LInsert := LInsert + '    ICE_SEQGER, ';
    LInsert := LInsert + '    ICE_CODITE, ';
    LInsert := LInsert + '    ICE_ULTALT, ';
    LInsert := LInsert + '    ICE_CODEMP) VALUES ';

    LValues := '';
    If Assigned(AProgress) Then
      AProgress.Properties.Max := cdsCadCes.RecordCount;

    LIndex := 1;
    cdsCadCes.First;
    while not cdsCadCes.Eof do
    Begin
      If LValues <> '' Then
        LValues := LValues + ', ';

      LValues := LValues + '( ' + strAutoIncremCondEsp.QuotedString;
      LValues := LValues + ', ' + QuotedStr(cdsCadCes.FieldByName('ICE_CODITE')
        .AsString);
      LValues := LValues + ', CURRENT_DATE';
      LValues := LValues + ', ' + VS_strCodEmp.QuotedString + ') ';

      If Not fExecutaSQL(LInsert + LValues) Then
        Exit(False);

      If Assigned(AProgress) Then
        AProgress.Position := LIndex;

      Application.ProcessMessages;
      LValues := '';
      LIndex := LIndex + 1;

      cdsCadCes.Next;
    End;
  Finally

  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.pGravarEmpresas(strAutIncCes: String;
  pgbStatus: TcxProgressBar = Nil);
Var
  qryGen: TUniQuery;
  intContador: Integer;
begin
  qryGen := fCriaQuery(Self);
  try
    qryGen.SQL.Add('DELETE FROM CESEMP WHERE CES_SEQGER = :SEQGER');
    qryGen.ParamByName('SEQGER').AsString := strAutIncCes;
    qryGen.ExecSQL;

    qryGen.SQL.Clear;
    qryGen.SQL.Add
      ('INSERT INTO CESEMP (CES_SEQGER, CES_CODEMP) VALUES (:SEQGER, :CODEMP) ');

    For intContador := 0 To clbEmpresa.Items.Count - 1 Do
    Begin
      pStepStatusGravacao(pgbStatus);

      If clbEmpresa.Checked[intContador] Then
      Begin
        qryGen.Close;
        qryGen.ParamByName('SEQGER').AsString := strAutIncCes;
        qryGen.ParamByName('CODEMP').AsString :=
          LeftStr(clbEmpresa.Items[intContador], 3);
        qryGen.ExecSQL;
      End;
    End;
  finally
    FreeAndNil(qryGen);
  end;
end;

procedure TfrmCadCondPagtoEspecialProdutos.pGravarCondicoes
  (strAutIncCes: String; pgbStatus: TcxProgressBar);
Var
  qryCndPro: TUniQuery;
begin
  if cdsCndPag.IsEmpty then
    Exit;

  pInfoStatusGravacao(pgbStatus, 'Aguarde... Gravando Condições Pagamento...');

  Try
    qryCndPro := fCriaQuery(Self);
    qryCndPro.SQL.Clear;
    qryCndPro.SQL.Add
      ('INSERT INTO CNDCES(CES_SEQGER, CES_CODCND) VALUES(:SEQGER, :CES_CODCND)');

    cdsCndPag.DisableControls;
    cdsCndPag.First;
    While (Not cdsCndPag.Eof) Do
    Begin
      pStepStatusGravacao(pgbStatus);

      qryCndPro.Close;
      qryCndPro.ParamByName('SEQGER').AsString := strAutIncCes;
      qryCndPro.ParamByName('CES_CODCND').AsString :=
        cdsCndPag.FieldByName('CODCND').AsString;
      qryCndPro.ExecSQL;

      cdsCndPag.Next;
    End;
    cdsCndPag.EnableControls;
  Finally
    FreeAndNil(qryCndPro);
  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.pDestravaELimpaStlCondLck;
Var
  intAux: Integer;
Begin
  For intAux := 0 To stlCondAltLck.Count - 1 Do
    fLock_Unlock(stlCondAltLck[intAux], False, False);

  stlCondAltLck.Clear;
End;

function TfrmCadCondPagtoEspecialProdutos.fTravaERegistraStlCondLck: Boolean;
Var
  strAux: String;
begin
  Result := False;
  strAux := fRetornaChaveLckCond;
  If Not fLock_Unlock(strAux, True, False) Then
  Begin
    fMensagem('Atenção',
      'Esta associação de condições especiais está sendo alterada em outra estação - '
      + fGetHostLock(strAux) + '.' + #13 +
      'Aguarde a liberação para dar continuidade !', ['&Ok']);
    Result := True;
  End
  Else
    stlCondAltLck.Add(strAux);
end;

function TfrmCadCondPagtoEspecialProdutos.fRetornaChaveLckCond: String;
begin
  Result := 'CONDESP_' + qryTabela.FieldByName('CES_CODIGO').AsString + '_' +
    qryTabela.FieldByName('CES_CODEMP').AsString;
end;

function TfrmCadCondPagtoEspecialProdutos.fExcluirAssociacao
  (pgbStatus: TcxProgressBar): Boolean;
Var
  prcScroll: TprcScroll;
begin
  pDisableControls(cdsCadCes, prcScroll);
  pInfoStatusGravacao(pgbStatus,
    'Aguarde, Excluindo Itens da Associação de Condições Especiais...',
    cdsCadCes.RecordCount);

  While Not cdsCadCes.Eof Do
  Begin
    pStepStatusGravacao(pgbStatus);
    pAlteraStatusTemp('D');
    // Next não é necessário aqui.
  End;

  pInsereDEL_ITECES;
  pInsereDEL_CESEMP;
  pInsereDEL_CNDCES;

  pDeletaTemporaria;

  blnExcluiu := False;

  pEnableControls(cdsCadCes, prcScroll);

  pCarregaCondicoes(qryTabela.FieldByName('AUTOINCREM').AsString);
  pAfterScroll(Nil);

  Result := True;
end;

procedure TfrmCadCondPagtoEspecialProdutos.pAlteraStatusTemp(strStatus: String);
begin
  cdsCadCes.Edit;
  cdsCadCes.FieldByName('ICE_STATUS').AsString := strStatus;
  cdsCadCes.Post;
end;

procedure TfrmCadCondPagtoEspecialProdutos.pInsereDEL_ITECES;
Var
  qryInsert: TUniQuery;
  cdsProAux: TUniClientDataSet;
Begin
  Try

    cdsProAux := TUniClientDataSet.Create(Self);
    cdsProAux.Data := cdsCadCes.Data;

    cdsProAux.DisableControls;
    cdsProAux.Filtered := False;
    cdsProAux.Filter := ' ICE_STATUS = ' + QuotedStr('D');
    cdsProAux.Filtered := True;
    cdsProAux.First;

    qryInsert := fCriaQuery(Self);

    While Not cdsProAux.Eof Do
    Begin
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add('INSERT INTO DEL_ITECES ( ');
      qryInsert.SQL.Add('  ICE_SEQGER, ');
      qryInsert.SQL.Add('  ICE_CODITE, ');
      qryInsert.SQL.Add('  ICE_CODEMP, ');
      qryInsert.SQL.Add('  OPEDEL    , ');
      qryInsert.SQL.Add('  DTADEL    , ');
      qryInsert.SQL.Add('  HORDEL    , ');
      qryInsert.SQL.Add('  ICE_ULTALT )');

      qryInsert.SQL.Add('  VALUES ( ');

      qryInsert.SQL.Add('  :SEQGER, ');
      qryInsert.SQL.Add('  :CODITE, ');
      qryInsert.SQL.Add('  :CODEMP, ');
      qryInsert.SQL.Add('  :OPEDEL, ');
      qryInsert.SQL.Add('  :DTADEL, ');
      qryInsert.SQL.Add('  :HORDEL, ');
      qryInsert.SQL.Add('  :ULTALT )');

      qryInsert.ParamByName('SEQGER').AsString :=
        cdsProAux.FieldByName('ICE_SEQGER').AsString;
      qryInsert.ParamByName('CODITE').AsString :=
        cdsProAux.FieldByName('ICE_CODITE').AsString;
      qryInsert.ParamByName('CODEMP').AsString :=
        cdsProAux.FieldByName('ICE_CODEMP').AsString;
      qryInsert.ParamByName('ULTALT').AsDateTime :=
        cdsProAux.FieldByName('ICE_ULTALT').AsDateTime;
      qryInsert.ParamByName('OPEDEL').AsString := VS_strCodEmp;
      qryInsert.ParamByName('DTADEL').asDate := fRetDataServidor;
      qryInsert.ParamByName('HORDEL').asTime := fRetHoraServidor;
      qryInsert.ExecSQL;

      cdsProAux.Next;
    End;
    cdsProAux.EnableControls;
  Finally
    If Assigned(cdsProAux) Then
      FreeAndNil(cdsProAux);
    If Assigned(qryInsert) Then
      FreeAndNil(qryInsert);
  End;

end;

procedure TfrmCadCondPagtoEspecialProdutos.pInsereDEL_CESEMP;
Var
  qryInsert: TUniQuery;
Begin
  Try
    qryInsert := fCriaQuery(Self);

    qryInsert.SQL.Clear;
    qryInsert.SQL.Add('INSERT INTO DEL_CESEMP (');
    qryInsert.SQL.Add('  CES_SEQGER, ');
    qryInsert.SQL.Add('  CES_CODEMP, ');
    qryInsert.SQL.Add('  CES_ULTALT, ');
    qryInsert.SQL.Add('  CES_HORALT, ');
    qryInsert.SQL.Add('  OPEDEL    , ');
    qryInsert.SQL.Add('  DTADEL    , ');
    qryInsert.SQL.Add('  HORDEL    ) ');

    qryInsert.SQL.Add('  SELECT CES_SEQGER, ');
    qryInsert.SQL.Add('  CES_CODEMP, ');
    qryInsert.SQL.Add('  CES_ULTALT, ');
    qryInsert.SQL.Add('  CES_HORALT, ');
    qryInsert.SQL.Add('  :OPEDEL, ');
    qryInsert.SQL.Add('  :DTADEL, ');
    qryInsert.SQL.Add('  :HORDEL  ');
    qryInsert.SQL.Add('  FROM CESEMP ');
    qryInsert.SQL.Add('  WHERE CES_SEQGER = :SEQGER ');
    qryInsert.SQL.Add('  AND LOCATE(CES_CODEMP,:CODEMP) > 0 ');

    qryInsert.ParamByName('SEQGER').AsString := strSequencialExc;
    qryInsert.ParamByName('CODEMP').AsString := strCodEmpExc;
    qryInsert.ParamByName('OPEDEL').AsString := VS_strCodEmp;
    qryInsert.ParamByName('DTADEL').asDate := fRetDataServidor;
    qryInsert.ParamByName('HORDEL').asTime := fRetHoraServidor;
    qryInsert.ExecSQL;
  Finally
    If Assigned(qryInsert) Then
      FreeAndNil(qryInsert);
  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.pInsereDEL_CNDCES;
Var
  qryInsert: TUniQuery;
Begin
  Try
    qryInsert := fCriaQuery(Self);
    cdsCndPag.First;
    While Not cdsCndPag.Eof Do
    Begin
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add('INSERT INTO DEL_CNDCES (');
      qryInsert.SQL.Add('  CES_SEQGER, ');
      qryInsert.SQL.Add('  CES_CODCND, ');
      qryInsert.SQL.Add('  OPEDEL    , ');
      qryInsert.SQL.Add('  DTADEL    , ');
      qryInsert.SQL.Add('  HORDEL    ) ');

      qryInsert.SQL.Add('  VALUES    ( ');

      qryInsert.SQL.Add('  :SEQGER, ');
      qryInsert.SQL.Add('  :CODCND, ');
      qryInsert.SQL.Add('  :OPEDEL, ');
      qryInsert.SQL.Add('  :DTADEL, ');
      qryInsert.SQL.Add('  :HORDEL  )');

      qryInsert.ParamByName('SEQGER').AsString := strSequencialExc;
      qryInsert.ParamByName('CODCND').AsString :=
        cdsCndPag.FieldByName('CODCND').AsString;
      qryInsert.ParamByName('OPEDEL').AsString := VS_strCodEmp;
      qryInsert.ParamByName('DTADEL').asDate := fRetDataServidor;
      qryInsert.ParamByName('HORDEL').asTime := fRetHoraServidor;

      qryInsert.ExecSQL;

      cdsCndPag.Next;
    End;
  Finally
    If Assigned(qryInsert) Then
      FreeAndNil(qryInsert);
  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.pCarregaDados;
begin
  pDeletaTemporaria;
  fCarregaItens(dbeCodCes.Text);
  pAfterScroll(Nil);

  If (btnAlterar.Enabled) Then
    pSetFocus(btnAlterar);

  pCarregaCondicoes(qryTabela.FieldByName('AUTOINCREM').AsString);
end;

function TfrmCadCondPagtoEspecialProdutos.fItemCadastradoAssociacao(strCesAtu,
  strCodIte, strEmpSel: String; dtaDtaIni, dtaDtaFim: TDateTime;
  Var strMsgCes: String): Boolean;
Var
  strSQL: String;
  qryGenCes: TUniQuery;
  stlCes: TStringList;
begin
  stlCes := TStringList.Create;

  Try
    strMsgCes := '';
    stlCes.Clear;

    qryGenCes := fCriaQuery(nil);

    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  DISTINCT CES_CODIGO, ICE_CODITE, ITE_DESITE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCES C ';
    strSQL := strSQL +
      '  INNER JOIN ITECES    ON C.AUTOINCREM = ITECES.ICE_SEQGER ';
    strSQL := strSQL +
      '  INNER JOIN CESEMP CE ON C.AUTOINCREM = CE.CES_SEQGER  ';
    strSQL := strSQL +
      '  INNER JOIN CADITE I  ON (I.ITE_CODITE = ITECES.ICE_CODITE) ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + fSqlWhere(strCesAtu, strCodIte);

    qryGenCes.Close;
    qryGenCes.SQL.Clear;
    qryGenCes.SQL.Add(strSQL);
    qryGenCes.ParamByName('DTAINI').asDate := dtaDtaIni;
    qryGenCes.ParamByName('DTAFIM').asDate := dtaDtaFim;
    qryGenCes.ParamByName('CODEMP').AsString := strEmpSel;

    If (Not fEmptyStr(strCesAtu)) Then
      qryGenCes.ParamByName('CODIGO').AsString := strCesAtu;

    qryGenCes.Open;

    If (qryGenCes.RecordCount > 0) Then
    Begin
      Repeat
        If (Not fEmptyStr(strCodIte)) Then
        Begin
          strMsgCes := qryGenCes.FieldByName('ICE_CODITE').AsString + ' - ' +
            Trim(qryGenCes.FieldByName('ITE_DESITE').AsString);
          If stlCes.IndexOf(strMsgCes) < 0 Then
            stlCes.Add(strMsgCes);
        End;

        qryGenCes.Next;
      Until qryGenCes.Eof;

      If (Not fEmptyStr(strCodIte)) And (stlCes.Count > 0) Then
        strMsgCes := stlCes.CommaText
      Else
        strMsgCes := '';
    End;

    Result := (qryGenCes.RecordCount > 0);
    qryGenCes.Close;
  Finally
    FreeAndNil(qryGenCes);
    FreeAndNil(stlCes);
  End;
end;

function TfrmCadCondPagtoEspecialProdutos.fSqlWhere(strCesAtu,
  strCodIte: String): String;
Var
  strSQL: String;
Begin
  strSQL := '';

  If Not fEmptyStr(strCodIte) Then
  begin
    if Length(strCodIte) = 5 then
      strCodIte := strCodIte.QuotedString;

    strSQL := strSQL + '  ICE_CODITE IN (' + strCodIte + ') AND ';
  end
  Else
    strSQL := strSQL + '  ICE_CODITE = :CODITE AND ';

  strSQL := strSQL + '  LOCATE(CE.CES_CODEMP,:CODEMP) > 0 AND ';

  strSQL := strSQL + '  ( ';
  strSQL := strSQL + '    :DTAINI BETWEEN CES_DTAINI AND CES_DTAFIM OR ';
  strSQL := strSQL + '    :DTAFIM BETWEEN CES_DTAINI AND CES_DTAFIM    ';
  strSQL := strSQL + '  )  ';

  If (Not fEmptyStr(strCesAtu)) Then
    strSQL := strSQL + '  AND CES_CODIGO <> :CODIGO ';

  Result := strSQL;
End;

function TfrmCadCondPagtoEspecialProdutos.fAdicionaCondPagtoEsp
  (pgbStatus: TcxProgressBar): Boolean;
Begin
  cdsCndPag.DisableControls;

  qryCondPag.First;
  while not qryCondPag.Eof do
  Begin
    if (not cdsCndPag.Locate('CODCND', qryCondPag.FieldByName('CND_CODIGO')
      .AsString, [])) then
    Begin
      cdsCndPag.Append;
      cdsCndPag.FieldByName('CODCND').AsString :=
        qryCondPag.FieldByName('CND_CODIGO').AsString;
      cdsCndPag.FieldByName('DESCND').AsString :=
        qryCondPag.FieldByName('CND_DESCRI').AsString;
      cdsCndPag.FieldByName('CNDPAG').AsString :=
        fFormataCondPag(qryCondPag.FieldByName('CND_CNDPAG').AsString);
      cdsCndPag.FieldByName('STATUS').AsString := 'I';
      cdsCndPag.Post;
    End;

    qryCondPag.Next;
  End;
  cdsCndPag.EnableControls;
  Result := True;
End;

procedure TfrmCadCondPagtoEspecialProdutos.pAdicionaCondPagtoEsp;
Begin
  Try
    fChamaTelaGravando(fAdicionaCondPagtoEsp);
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;
End;

procedure TfrmCadCondPagtoEspecialProdutos.pAlteraStatusCondPag
  (strStatus: String);
begin
  cdsCndPag.Edit;
  cdsCndPag.FieldByName('STATUS').AsString := strStatus;
  cdsCndPag.Post;
end;

function TfrmCadCondPagtoEspecialProdutos.fTemFiltroSelecionado: Boolean;
Var
  intContador: Integer;
begin
  Result := False;
  For intContador := 0 To Self.ComponentCount - 1 Do
  Begin
    If (Components[intContador] is TMaskEdit) Then
    Begin
      if TMaskEdit(Self.Components[intContador]).TabStop = True then
        Result := (not fEmptyStr(TMaskEdit(Self.Components[intContador]).Text));
    End;
    If Components[intContador] is TEditFocus Then
    Begin
      if TEditFocus(Self.Components[intContador]).TabStop = True then
        Result := (not fEmptyStr(TEditFocus(Self.Components
          [intContador]).Text));
    End;

    if Result then
      Break;
  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.pDeletarCondicoes
  (strAutIncCes: String; pgbStatus: TcxProgressBar);
Var
  qryCndPro: TUniQuery;
begin
  Try
    qryCndPro := fCriaQuery(Self);
    qryCndPro.SQL.Add('DELETE FROM CNDCES WHERE CES_SEQGER = :SEQGER');
    qryCndPro.ParamByName('SEQGER').AsString := strAutIncCes;
    qryCndPro.ExecSQL;
  Finally
    FreeAndNil(qryCndPro);
  End;
end;

procedure TfrmCadCondPagtoEspecialProdutos.pReajustarBotoesRodape;
begin
  If Not untFuncoesSimples.blnUsuarioLogadoUtilizaModoClassico Then
    btnSair.Left := FlwBotoes.Width - btnSair.Width - 4
  Else
    btnSair.Left := FlwBotoes.Width - btnSair.Width - 2;
end;

function TfrmCadCondPagtoEspecialProdutos.fSqlDefault: String;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADITE.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '  CADITE.ITE_CODFAB AS CODFAB, ';
  strSQL := strSQL + '  CADITE.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '  CADITE.ITE_CODGRU AS CODGRU, ';
  strSQL := strSQL + '  UNI_SIGUNI AS UNIDAD, ';
  strSQL := strSQL + '  MAR_DESMAR AS DESMAR, ';
  strSQL := strSQL +
    '  (ITEGER.ITE_SALDOS + ITEGER.ITE_QTEF_A + ITEGER.ITE_QTEF_F + ITEGER.ITE_QTEF_P + ITEGER.ITE_QTPDBF) AS ITE_SALFIS, ';
  strSQL := strSQL + fSQLSaldoDisponivel('ITEGER', True) + ' AS ITE_SALDIS, ';
  strSQL := strSQL + '  ITEGER.ITE_PRECUS AS PRECUS, ';
  strSQL := strSQL + '  ITEGER.ITE_PREMED AS PREMED, ';
  strSQL := strSQL + '  ITEGER.ITE_PREULT AS PREULT, ';
  strSQL := strSQL + '  ITEGER.ITE_IMPULT AS IMPULT, ';
  strSQL := strSQL + '  ITEGER.ITE_OUTVAL AS OUTVAL, ';
  strSQL := strSQL + '  ITEGER.ITE_ICMSAI AS ICMSAI, ';
  strSQL := strSQL + '  ITEGER.ITE_IMPFED AS IMPFED, ';
  strSQL := strSQL + '  ITEGER.ITE_DESOPE AS DESOPE, ';

  strSQL := strSQL + '  ITE_IPIENT AS IPIENT, ';
  strSQL := strSQL + '  ITE_PRECOM AS PRECOM ';

  strSQL := strSQL + '  FROM CADITE ';
  strSQL := strSQL +
    ' INNER JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE ';
  strSQL := strSQL + '                  AND ITEGER.ITE_CODEMP = ' +
    QuotedStr(VS_strCodEmp) + ' ';
  strSQL := strSQL +
    ' INNER JOIN CADMAR ON CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR ';
  strSQL := strSQL +
    ' INNER JOIN CADUNI ON CADITE.ITE_CODUNI = CADUNI.UNI_CODUNI ';
  strSQL := strSQL + ' WHERE CADITE.ITE_ITEATI = "S" ';

  If (Not fEmptyStr(edtCodIte.Text)) Then
    strSQL := strSQL + '  AND CADITE.ITE_CODITE = :CODITE  ';

  If Not fEmptyStr(mskLinhaGrupo.Text) Then
  Begin
    If RightStr(mskLinhaGrupo.Text, 3) = '000' Then
      strSQL := strSQL + '  AND LEFT(ITE_CODGRU,3) = LEFT(:CODGRU,3) '
    Else
      strSQL := strSQL + '  AND ITE_CODGRU = :CODGRU ';
  End;

  If Not fEmptyStr(edtFornecedor.Text) Then
    strSQL := strSQL + '  AND ITE_CODFOR = :CODFOR ';

  If Not fEmptyStr(edtMarca.Text) Then
    strSQL := strSQL + '  AND ITE_CODMAR = :CODMAR ';

  If Not fEmptyStr(edtUnidade.Text) Then
    strSQL := strSQL + '  AND ITE_CODUNI = :CODUNI ';

  strSQL := strSQL + ' ORDER BY CADITE.ITE_DESITE ';

  Result := strSQL;
End;

procedure TfrmCadCondPagtoEspecialProdutos.pAdicionaCDS(qryGen: TUniQuery;
  Var strMsgProJaInc: String; Var strMsgProIncOu: String);
Var
  Parametro: TParametroProduto;
Begin
  Parametro.strCodIte := qryGen.FieldByName('CODITE').AsString;
  Parametro.strDesIte := qryGen.FieldByName('DESITE').AsString;
  Parametro.strCodFab := qryGen.FieldByName('CODFAB').AsString;
  Parametro.strUnidad := qryGen.FieldByName('UNIDAD').AsString;
  Parametro.strDesmar := qryGen.FieldByName('DESMAR').AsString;
  Parametro.strSalFis := qryGen.FieldByName('ITE_SALFIS').AsString;
  Parametro.strSalDis := qryGen.FieldByName('ITE_SALDIS').AsString;
  Parametro.fltPreCusIte := qryGen.FieldByName('PRECUS').AsFloat;
  Parametro.fltOutVal := qryGen.FieldByName('OUTVAL').AsFloat;
  Parametro.fltIcmSai := qryGen.FieldByName('ICMSAI').AsFloat;
  Parametro.fltImpFed := qryGen.FieldByName('IMPFED').AsFloat;
  Parametro.fltDesOpe := qryGen.FieldByName('DESOPE').AsFloat;

  If qryGen.FindField('PREMED') <> nil Then
    Parametro.fltPreMed := qryGen.FieldByName('PREMED').AsFloat;

  If qryGen.FindField('PREULT') <> nil Then
    Parametro.fltPreUlt := qryGen.FieldByName('PREULT').AsFloat;

  If qryGen.FindField('IMPULT') <> nil Then
    Parametro.fltImpUlt := qryGen.FieldByName('IMPULT').AsFloat;

  Parametro.fltIpiEnt := qryGen.FieldByName('IPIENT').AsFloat;
  Parametro.fltPreCom := qryGen.FieldByName('PRECOM').AsFloat;
  Parametro.strEmpresasSelecionadas := fGetEmpresasSelecionadas;;

  fIncluirProdutoCds(strMsgProJaInc, strMsgProIncOu, Parametro);
End;

procedure TfrmCadCondPagtoEspecialProdutos.pExibirMensagemTrava
  (strMsgProJaInc: String; strMsgProIncOu: String);
Var
  intObs: Integer;
Begin
  intObs := 0;
  If (Not fEmptyStr(strMsgProJaInc + strMsgProIncOu)) Then
  Begin
    Try
      pCriarFormularios(TfrmObservacao, frmObservacao);
      frmObservacao.lblMensagem.Caption :=
        'O(s) item(s) abaixo possuem as seguintes observações:';

      If Not fEmptyStr(strMsgProIncOu) Then
      Begin
        Inc(intObs);
        frmObservacao.memObs.Lines.Add(IntToStr(intObs) + ' - ' +
          'Produtos que estão vigentes em outras Associações de Condições Especiais: '
          + #13#10 + strMsgProIncOu + #13#10);
      End;

      If Not fEmptyStr(strMsgProJaInc) Then
      Begin
        Inc(intObs);
        frmObservacao.memObs.Lines.Add(IntToStr(intObs) + ' - ' +
          'Produtos que estão vigente nesta Associação de Condição Especial: ' +
          #13#10 + strMsgProJaInc + #13#10);
      End;
      frmObservacao.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,
          '[TfrmCadCondPagtoEspecialProdutos.pAdicionaItem]');
      End;
    End;
    pFreeAndNil(frmObservacao);
  End;
End;

end.
