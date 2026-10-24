unit Contabilidade.View.LancamentosPeriodicos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiCadContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.StdCtrls, BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, MemDS, DBAccess, Uni,
  Vcl.Mask, Vcl.DBCtrls, DBEditFocus, EditFocus, MaskEditFocus, ComboBoxFocus,
  MemoFocus, Vcl.Grids, Vcl.DBGrids, DBGridCitel, Datasnap.DBClient,
  UniClientDataSet, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, System.Generics.Collections,
  cxContainer, cxTextEdit, cxCurrencyEdit, CurrencyEditFocus,
  Contabilidade.Interfaces;

type
  TfrmLancamentosPeriodicos = class(TfrmPaiCadContabilidade)
    dtsPerGer: TDataSource;
    pnlCapa: TPanel;
    Label1: TLabel;
    dbeCodigo: TDBEditFocus;
    Label2: TLabel;
    dbeDescri: TDBEditFocus;
    Label3: TLabel;
    dbeCodOpe: TDBEditFocus;
    Label4: TLabel;
    dbeDtaAlt: TDBEditFocus;
    Label5: TLabel;
    dbeHraAlt: TDBEditFocus;
    pnlDetalhe: TPanel;
    pnlItemPeriodico: TPanel;
    Label12: TLabel;
    mskContaDebito: TMaskEditFocus;
    edtConDebRed: TEditFocus;
    edtDesContaDebito: TEditFocus;
    lbCCustoDebito: TLabel;
    edtCCustoDebito: TEditFocus;
    edtDesCCustoDebito: TEditFocus;
    lbContaCredito: TLabel;
    mskContaCredito: TMaskEditFocus;
    edtConCreRed: TEditFocus;
    edtDesContaCRedito: TEditFocus;
    lbCCustoCredito: TLabel;
    edtCCustoCredito: TEditFocus;
    edtDesCCustoCredito: TEditFocus;
    lbHisPad: TLabel;
    edtHisPad: TEditFocus;
    edtDesHistPadrao: TEditFocus;
    lbHistor: TLabel;
    edtHistor: TMemoFocus;
    lbTipLan: TLabel;
    edtTipLan: TComboBoxFocus;
    Label15: TLabel;
    edtEmpLan: TEditFocus;
    edtNomEmp: TEditFocus;
    dbgBuscaConta: TDBGridCitel;
    dtsBusca: TDataSource;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    dstDetalhe: TDataSource;
    GridCitel: TcxGridCitel;
    GridCitelTableView: TcxGridDBTableViewCitel;
    GridCitelTableViewAUTOINCREM: TcxGridDBColumn;
    GridCitelTableViewCON_CONDEB: TcxGridDBColumn;
    GridCitelTableViewDES_CONDEB: TcxGridDBColumn;
    GridCitelTableViewCON_CCUSTO: TcxGridDBColumn;
    GridCitelTableViewDES_CCUSTO: TcxGridDBColumn;
    GridCitelTableViewCON_CONCRE: TcxGridDBColumn;
    GridCitelTableViewDES_CONCRE: TcxGridDBColumn;
    GridCitelTableViewCON_CCUSCR: TcxGridDBColumn;
    GridCitelTableViewDES_CCUSCR: TcxGridDBColumn;
    GridCitelTableViewCON_EMPLAN: TcxGridDBColumn;
    GridCitelTableViewCON_HISPAD: TcxGridDBColumn;
    GridCitelTableViewDES_HISPAD: TcxGridDBColumn;
    GridCitelTableViewCON_HISTOR: TcxGridDBColumn;
    GridCitelTableViewCON_TIPLAN: TcxGridDBColumn;
    GridCitelTableViewCON_PARMUL: TcxGridDBColumn;
    GridCitelLevel1: TcxGridLevel;
    lbSubcontaDebito: TLabel;
    edtOpcSubcontaDebito: TEditFocus;
    edtCodCliForSubcontaDebito: TEditFocus;
    lbSubcontaCredito: TLabel;
    edtOpcSubcontaCredito: TEditFocus;
    edtCodCliForSubcontaCredito: TEditFocus;
    GridCitelTableViewCON_CLIFOR: TcxGridDBColumn;
    GridCitelTableViewCON_TIP_FC: TcxGridDBColumn;
    edtNomCliForSubcontaDebito: TEditFocus;
    edtNomCliForSubcontaCredito: TEditFocus;
    edtValor: TCurrencyEditFocus;
    lbValor: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure mskContaDebitoClick(Sender: TObject);
    procedure mskContaDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure mskContaDebitoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtConDebRedClick(Sender: TObject);
    procedure edtConDebRedKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskContaCreditoClick(Sender: TObject);
    procedure mskContaCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure mskContaCreditoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtConCreRedClick(Sender: TObject);
    procedure edtConCreRedKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure edtEmpLanKeyPress(Sender: TObject; var Key: Char);
    procedure edtCCustoDebitoEnter(Sender: TObject);
    procedure edtCCustoCreditoEnter(Sender: TObject);
    procedure edtCCustoDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCCustoCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure edtHisPadKeyPress(Sender: TObject; var Key: Char);
    procedure dbgBuscaContaDblClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure GridCitelTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure edtOpcSubcontaDebitoKeyPress(Sender: TObject; var Key: Char);
    procedure edtOpcSubcontaCreditoKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliForSubcontaDebitoKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtCodCliForSubcontaCreditoKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtEmpLanExit(Sender: TObject);
  private
    { Private declarations }
    FrecSugestaoProximoInsert: TDadosSugestaoInsertLancamentoContabil ;
    FblnFormInCreate: Boolean ;
    FdictDefaultTop: TDictionary<String,Integer> ;
    FdictDefaultHeight: TDictionary<String,Integer> ;
    FblnDebitoComSubconta  : Boolean ;
    FblnCreditoComSubconta : Boolean ;
    FqryPerGer: TUniQuery;
    FqryBusca : TUniQuery;
    FblnExisteCampoNCO_NATURE: boolean ;
    FblnExisteCampoCON_CCUSCR: boolean ;
    FblnExisteCampoCON_CCUSTO: boolean ;
    FblnValidaDetalhe: boolean ;
    FcdsPerDet : TUniClientDataSet;
    FstrSequenAlt: String;
    FModoInclusao: Boolean;
    function fMovimentaLinha(const Key: Word; Sender: TObject): boolean;
    procedure pBuscarConta(dbeTexto: TCustomEdit; blnRed: Boolean;
      intTag: Integer);
    function fCarregaDescricaoConta(const AConta: string): string;
    function fCarregaContaReduzida(const AConta: string): string;
    procedure pDesativaCentroCustoCredito(const AContaContabil: string);
    procedure pDesativaCentroCustoDebito(const AContaContabil: string);
    procedure pCarregaPlanoContabilCredito(const blnBuscaPorChave: Boolean=False;
      blnCampoContaReduzida: Boolean=False);
    procedure pCarregaPlanoContabilDebito(const blnBuscaPorChave: Boolean=False;
      blnCampoContaReduzida: Boolean=False);
    function fCarregaCentroCusto(const ACodigo: string): string;
    function fCarregaHistoricoPadrao(const ACodigo: string): string;
    procedure pCarregaTipoContabeisManutencao;
    function fCriaCdsDados: TUniClientDataSet;
    procedure pCarregaDetalhe(const AstrAuto: string) ;
    procedure pCarregaItemDetalhe ;
    procedure pLimpaItemDetalhe ;
    procedure pGravaTemporariaDetalhe ;
    procedure pApagaItemDetalhe ;
    function fIndexTipLan(const ATipLan: string): integer;
    procedure pHabilitaDetalhe(const AblnHabilita: boolean) ;
    procedure pCamposCentroCusto;
    function fValidaCamposDetalhe:boolean ;
    function fGravaDetalhe(const AstrSeqGer: string):boolean ;
    procedure pReorganizaEntradaDadosSubContasInterno(const AblnCredito, AblnDebito: Boolean) ;
    procedure pReorganizaEntradaDadosSubContas ;
    procedure pRestauraPosicionamentoSubContasDefault ;
    procedure pSalvaPosicionamentoSubContasDefault ;
    procedure pSetCreditoComSubconta(const AValue: Boolean);
    procedure pSetDebitoComSubconta(const AValue: Boolean);
    procedure pEhDebitoComSubConta(const AstrConta, AstrEmpLan: String) ;
    procedure pEhCreditoComSubConta(const AstrConta, AstrEmpLan: String) ;
    function fValidaOpcaoSubConta(AedtCampo: TEditFocus): Boolean ;
    function fCarregaCliForSubConta(AedtCodigo, AedtDescricao: TEditFocus; const AstrOpcao: String): Boolean ;
    procedure pMostraColunasSubConta(const AblnMostrar: Boolean);
    procedure pFormBeginUpdate;
    procedure pFormEndUpdate ;
    property DebitoComSubconta: Boolean read FblnDebitoComSubconta write pSetDebitoComSubconta ;
    property CreditoComSubconta: Boolean read FblnCreditoComSubconta write pSetCreditoComSubconta ;
    procedure pCarregaSugestaoUltimoInsert();
    procedure pSalvaSugestaoUltimoInsert();
  public
    { Public declarations }
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untTypesSistema, Contabilidade.Consultas,
     Contabilidade.Funcoes, untConsultas ,
  Contabilidade.Classes.LancamentosPeriodicos;

procedure TfrmLancamentosPeriodicos.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  FblnValidaDetalhe := True ;
  try
    If Not fVerificaCampos Then
    Begin
      pSetFocus(edtEmpLan) ;
      Exit;
    End;

    if not fPodeIncluirComSubconta(edtCodCliForSubcontaDebito.Visible, edtCodCliForSubcontaCredito.Visible) then
    begin
      fMensagem('ATENÇÃO!', 'Apenas uma conta pode ser informada como subconta!', ['&OK']);
      pSetFocus(edtEmpLan) ;
      Exit;
    end ;

  finally
    FblnValidaDetalhe := False ;
  end ;

  pGravaTemporariaDetalhe ;
  pSalvaSugestaoUltimoInsert ;

  FModoInclusao := True ;

  pLimpaItemDetalhe ;
  pCarregaSugestaoUltimoInsert ;

  pSetFocus(edtEmpLan);

end;

procedure TfrmLancamentosPeriodicos.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
  pHabilitaDetalhe(True) ;
  pCamposCentroCusto ;
  pSetFocus(dbeDescri) ;
end;

procedure TfrmLancamentosPeriodicos.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaDetalhe(dbeCodigo.Field.AsString) ;
  pLimpaItemDetalhe ;
  FillChar(FrecSugestaoProximoInsert, SizeOf(FrecSugestaoProximoInsert), #0);
  pHabilitaDetalhe(False) ;
end;

procedure TfrmLancamentosPeriodicos.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimpaItemDetalhe ;
end;

procedure TfrmLancamentosPeriodicos.btnExcluirClick(Sender: TObject);
begin
  Try
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
    inherited;
    pCarregaDetalhe(dbeCodigo.Field.AsString) ;
    pLimpaItemDetalhe ;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, 'TfrmLancamentosPeriodicos.btnExcluirClick');
      Exit;
    End;
  End;
  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmLancamentosPeriodicos.btnGravarClick(Sender: TObject);
begin
  dbeCodOpe.Field.AsString := strLoginUsuarioLogado ;
  dbeDtaAlt.Field.AsDateTime := VS_Date ;
  dbeHraAlt.Field.AsString := TimeToStr(fTime()) ;
  inherited;
  if fGravaDetalhe(dbeCodigo.Field.AsString) then
  begin
    pCarregaDetalhe(dbeCodigo.Field.AsString) ;
    pLimpaItemDetalhe;
    FillChar(FrecSugestaoProximoInsert, SizeOf(FrecSugestaoProximoInsert), #0);
    pHabilitaDetalhe(False) ;
  end ;
end;

procedure TfrmLancamentosPeriodicos.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
  pHabilitaDetalhe(True) ;
  pCarregaDetalhe(dbeCodigo.Field.AsString) ;
  pCamposCentroCusto ;
  edtTipLan.ItemIndex := fIndexTipLan('MAN') ;
  pSetFocus(dbeDescri) ;
end;

procedure TfrmLancamentosPeriodicos.btnPesquisaClick(Sender: TObject);
Var
  chrKey: Char;
  arrPerGer: TConsultasArray;
begin
  chrKey := '/';
  If fPesqLancamentosPeriodicos(Self, Nil, Nil, qryTabela, chrKey, arrPerGer) Then
  begin
    pCarregaDetalhe(dbeCodigo.Field.AsString) ;
    pLimpaItemDetalhe ;
    pSetFocus(btnAlterar);
  end;
end;

procedure TfrmLancamentosPeriodicos.dbgBuscaContaDblClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
  If (dbgBuscaConta.Tag = 1) or (dbgBuscaConta.Tag = 11) Then
  Begin
    mskContaDebito.Text := FqryBusca.FieldByName('CODCON').AsString;
    pDesativaCentroCustoDebito(mskContaDebito.Text) ;
    edtConDebRed.Text := FqryBusca.FieldByName('CONRED').AsString;
    edtDesContaDebito.Text := FqryBusca.FieldByName('DESCON').AsString;
    pEhDebitoComSubConta(mskContaDebito.Text, edtEmpLan.Text) ;
    if dbgBuscaConta.Tag = 1 then
      pSetFocus(mskContaDebito)
    else
      pSetFocus(edtConDebRed) ;
  End
  Else If (dbgBuscaConta.Tag = 2) or (dbgBuscaConta.Tag = 12) Then
  Begin
    mskContaCredito.Text := FqryBusca.FieldByName('CODCON').AsString;
    pDesativaCentroCustoCredito(mskContaCredito.Text) ;
    edtConCreRed.Text := FqryBusca.FieldByName('CONRED').AsString;
    edtDesContaCredito.Text := FqryBusca.FieldByName('DESCON').AsString;
    pEhCreditoComSubConta(mskContaCredito.Text, edtEmpLan.Text) ;
    if dbgBuscaConta.Tag = 2 then
      pSetFocus(mskContaCredito)
    else
      pSetFocus(edtConCreRed) ;
  End;
end;

procedure TfrmLancamentosPeriodicos.edtCCustoCreditoEnter(Sender: TObject);
begin
  inherited;
  if fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text)) then
  begin
    edtCCustoCredito.Clear ;
    edtDesCCustoCredito.Clear ;
    SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmLancamentosPeriodicos.edtCCustoCreditoKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEvento : TConsultasArray;
begin
  inherited;
  If fPesqEventos(Self, edtCCustoCredito, edtDesCCustoCredito, Nil, Key, arrEvento, True, True) Then
  Begin
    If fValidaCampos(edtCCustoCredito, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLancamentosPeriodicos.edtCCustoDebitoEnter(Sender: TObject);
begin
  inherited;
  if fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text)) then
  begin
    edtCCustoDebito.Clear ;
    edtDesCCustoDebito.Clear ;
    SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmLancamentosPeriodicos.edtCCustoDebitoKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrEvento : TConsultasArray;
begin
  inherited;
  If fPesqEventos(Self, edtCCustoDebito, edtDesCCustoDebito, Nil, Key, arrEvento, True, True) Then
  Begin
    If fValidaCampos(edtCCustoDebito, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLancamentosPeriodicos.edtCodCliForSubcontaCreditoKeyPress(
  Sender: TObject; var Key: Char);
var
  arrRetornoConsultas : TConsultasArray;
begin
  inherited;

  if not fValidaOpcaoSubConta(edtOpcSubcontaCredito) then
  begin
    pSetFocus(edtOpcSubcontaCredito);
    Exit ;
  end ;

  if edtOpcSubcontaCredito.Text = 'C' then //clientes
  begin
    If fPesqClientesCont(Self, edtCodCliForSubcontaCredito, edtNomCliForSubcontaCredito, Nil, Key, arrRetornoConsultas, True) Then
    Begin
      If fValidaCampos(edtCodCliForSubcontaCredito, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end
  else // fornecedores
  begin
    If fPesqFornecedoresCont(Self, edtCodCliForSubcontaCredito, edtNomCliForSubcontaCredito, Nil, Key, arrRetornoConsultas, True) Then
    Begin
      If fValidaCampos(edtCodCliForSubcontaCredito, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end ;
end;

procedure TfrmLancamentosPeriodicos.edtCodCliForSubcontaDebitoKeyPress(
  Sender: TObject; var Key: Char);
var
  arrRetornoConsultas : TConsultasArray;
begin
  inherited;

  if not fValidaOpcaoSubConta(edtOpcSubcontaDebito) then
  begin
    pSetFocus(edtOpcSubcontaDebito);
    Exit ;
  end ;

  if edtOpcSubcontaDebito.Text = 'C' then //clientes
  begin
    If fPesqClientesCont(Self, edtCodCliForSubcontaDebito, edtNomCliForSubcontaDebito, Nil, Key, arrRetornoConsultas, True) Then
    Begin
      If fValidaCampos(edtCodCliForSubcontaDebito, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end
  else // fornecedores
  begin
    If fPesqFornecedoresCont(Self, edtCodCliForSubcontaDebito, edtNomCliForSubcontaDebito, Nil, Key, arrRetornoConsultas, True) Then
    Begin
      If fValidaCampos(edtCodCliForSubcontaDebito, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  end ;
end;

procedure TfrmLancamentosPeriodicos.edtConCreRedClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmLancamentosPeriodicos.edtConCreRedKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not fMovimentaLinha(Key, Sender) then
  begin
    pBuscarConta(edtConCreRed, True, 2);
  end;
end;

procedure TfrmLancamentosPeriodicos.edtConDebRedClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmLancamentosPeriodicos.edtConDebRedKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not fMovimentaLinha(Key, Sender) then
  begin
    pBuscarConta(edtConDebRed, True, 1);
  end;
end;

procedure TfrmLancamentosPeriodicos.edtEmpLanExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtHisPad);
end;

procedure TfrmLancamentosPeriodicos.edtEmpLanKeyPress(Sender: TObject;
  var Key: Char);
var
  arrEmpSel: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpLan, edtNomEmp, Nil, Key, arrEmpSel, False) Then
  Begin
    If fValidaCampos(edtEmpLan) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLancamentosPeriodicos.edtHisPadKeyPress(Sender: TObject;
  var Key: Char);
var
  arrHisPad : TConsultasArray;
begin
  inherited;

  if fEmptyStr(edtEmpLan.Text) then
  begin
    fMensagem('ATENÇÃO!', 'Preencha o código da empresa do lançamento!', ['&OK']);
    pSetFocus(edtEmpLan);
    Key := #0;
    Exit;
  end;

  If fPesqHistoricoPadrao(Self, edtHisPad, edtDesHistPadrao, Nil, Key, arrHisPad, True, edtEmpLan.Text) Then
  Begin
    If fValidaCampos(edtHisPad, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmLancamentosPeriodicos.edtOpcSubcontaCreditoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if not CharInSet(key, [#13, #9]) then
  begin
    edtCodCliForSubcontaCredito.Clear ;
    edtNomCliForSubcontaCredito.Clear ;
  end ;
end;

procedure TfrmLancamentosPeriodicos.edtOpcSubcontaDebitoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  if not CharInSet(key, [#13, #9]) then
  begin
    edtCodCliForSubcontaDebito.Clear ;
    edtNomCliForSubcontaDebito.Clear ;
  end ;
end;

procedure TfrmLancamentosPeriodicos.FormCreate(Sender: TObject);
begin
  inherited;
  FblnFormInCreate := True ;
  FdictDefaultTop    := TDictionary<String,Integer>.Create ;
  FdictDefaultHeight := TDictionary<String,Integer>.Create ;
  pSalvaPosicionamentoSubContasDefault ;
  pReorganizaEntradaDadosSubContasInterno(False, False) ;
  FblnValidaDetalhe := False ;
  FstrSequenAlt := '' ;
  strNomeTabela     := 'PERGER';
  strNomeCampo      := 'AUTOINCREM';

  FblnExisteCampoNCO_NATURE := fCampoExiste('PLANCO', 'NCO_NATURE');

  FblnExisteCampoCON_CCUSCR := fCampoExiste('LANCON', 'CON_CCUSCR');
  FblnExisteCampoCON_CCUSTO := True ;

  if (fCfgExpEcd = 'S') and (fCfgObrCcu = 'N') then
  begin
    FblnExisteCampoCON_CCUSCR := False ;
    FblnExisteCampoCON_CCUSTO := False ;
  end;

  FqryPerGer         := fCriaQuery(Self);
  qryTabela         := FqryPerGer;
  dtsPerGer.DataSet := qryTabela;

  FqryBusca := fCriaQuery(Self);
  dtsBusca.DataSet := FqryBusca;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  pCarregaTipoContabeisManutencao ;

  FcdsPerDet := fCriaCdsDados ;
  dstDetalhe.DataSet := FcdsPerDet ;

  pHabilitaDetalhe(False) ;

  FblnDebitoComSubconta  := False ;
  FblnCreditoComSubconta := False ;
  pMostraColunasSubConta(fCfgDesmembrarSubContaCliFor = 'S') ;
  FblnFormInCreate := False ;
  FillChar(FrecSugestaoProximoInsert, SizeOf(FrecSugestaoProximoInsert), #0);
  FModoInclusao := True ;
end;

procedure TfrmLancamentosPeriodicos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(FcdsPerDet) ;
  FreeAndNil(FqryBusca) ;
  FreeAndNil(FdictDefaultTop) ;
  FreeAndNil(FdictDefaultHeight) ;
end;

procedure TfrmLancamentosPeriodicos.mskContaCreditoClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmLancamentosPeriodicos.mskContaCreditoKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrPlan: TConsultasArray;
  strTplaco: String ;
begin
  If fEntraCons(Key) Then
  Begin
    strTplaco := Contabilidade.Funcoes.fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
    If Contabilidade.Consultas.fPesqPlanoContabil(Self, mskContaCredito, edtDesContaCredito, Nil, Key, arrPlan, True, strTplaco, not FblnExisteCampoNCO_NATURE) Then
      SelectNext(ActiveControl, True, True);

    edtDesContaCredito.Text := fCarregaDescricaoConta(edtDesContaCredito.Text) ;
    edtConCreRed.Text := fCarregaContaReduzida(edtDesContaCredito.Text) ;
    pDesativaCentroCustoCredito(mskContaCredito.Text) ;
    pEhCreditoComSubConta(mskContaCredito.Text, edtEmpLan.Text) ;
  End;
end;

procedure TfrmLancamentosPeriodicos.mskContaCreditoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not fMovimentaLinha(Key, Sender) then
  begin
    pBuscarConta(mskContaCredito, False, 2);
  end;
end;

procedure TfrmLancamentosPeriodicos.mskContaDebitoClick(Sender: TObject);
begin
  inherited;
  dbgBuscaConta.Visible := False;
end;

procedure TfrmLancamentosPeriodicos.mskContaDebitoKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrPlan: TConsultasArray;
  strTplaco: String ;
begin
  If fEntraCons(Key) Then
  Begin
    strTplaco := Contabilidade.Funcoes.fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
    If Contabilidade.Consultas.fPesqPlanoContabil(Self, mskContaDebito, edtDesContaDebito, Nil, Key, arrPlan, True, strTplaco, not FblnExisteCampoNCO_NATURE) Then
      SelectNext(ActiveControl, True, True);

    edtDesContaDebito.Text := fCarregaDescricaoConta(mskContaDebito.Text) ;
    edtConDebRed.Text := fCarregaContaReduzida(mskContaDebito.Text) ;
    pEhDebitoComSubConta(mskContaDebito.Text, edtEmpLan.Text) ;
    pDesativaCentroCustoDebito(mskContaDebito.Text) ;
  End;
end;

procedure TfrmLancamentosPeriodicos.mskContaDebitoKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if not fMovimentaLinha(Key, Sender) then
  begin
    pBuscarConta(mskContaDebito, False, 1);
  end;
end;

procedure TfrmLancamentosPeriodicos.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('GER_DESCRI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('GER_DESCRI');
  stlCamInd.Add('AUTOINCREM');
  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
end;

procedure TfrmLancamentosPeriodicos.pLimpaItemDetalhe;
begin
  edtEmpLan.Clear ;
  edtNomEmp.Clear ;
  mskContaDebito.Clear ;
  edtDesContaDebito.Clear ;
  edtCCustoDebito.Clear ;
  edtDesCCustoDebito.Clear ;
  edtConDebRed.Clear ;
  mskContaCredito.Clear ;
  edtDesContaCredito.Clear ;
  edtCCustoCredito.Clear ;
  edtDesCCustoCredito.Clear ;
  edtConCreRed.Clear ;
  edtHisPad.Clear ;
  edtDesHistPadrao.Clear ;
  edtHistor.Clear ;
  edtValor.Clear;
  edtCodCliForSubcontaDebito.Clear ;
  edtOpcSubcontaDebito.Clear ;
  edtNomCliForSubcontaDebito.Clear ;
  edtCodCliForSubcontaCredito.Clear ;
  edtOpcSubcontaCredito.Clear ;
  edtNomCliForSubcontaCredito.Clear ;
  edtTipLan.ItemIndex := fIndexTipLan('MAN') ;
  DebitoComSubconta := False ;
  CreditoComSubconta := False ;
  FstrSequenAlt := '' ;
end;

procedure TfrmLancamentosPeriodicos.pReorganizaEntradaDadosSubContas;
begin
  if fCfgDesmembrarSubContaCliFor = 'N' then
    Exit ;

  pReorganizaEntradaDadosSubContasInterno(FblnCreditoComSubconta, FblnDebitoComSubconta) ;
end;

procedure TfrmLancamentosPeriodicos.pReorganizaEntradaDadosSubContasInterno(
  const AblnCredito, AblnDebito: Boolean);
const
  INT_ESPACAMENTO = 25 ;
var
  LintValor: Integer ;
begin
  pFormBeginUpdate ;
  try
    lbSubcontaDebito.Visible := AblnDebito ;
    edtCodCliForSubcontaDebito.Visible := AblnDebito ;
    edtNomCliForSubcontaDebito.Visible := AblnDebito ;
    edtOpcSubcontaDebito.Visible := AblnDebito ;

    lbSubcontaCredito.Visible := AblnCredito ;
    edtCodCliForSubcontaCredito.Visible := AblnCredito ;
    edtNomCliForSubcontaCredito.Visible := AblnCredito ;
    edtOpcSubcontaCredito.Visible := AblnCredito ;

    pRestauraPosicionamentoSubContasDefault ;
    LintValor := 0 ;

    if not AblnDebito then
    begin
      lbCCustoDebito.Top := lbCCustoDebito.Top - INT_ESPACAMENTO ;
      edtCCustoDebito.Top := edtCCustoDebito.Top - INT_ESPACAMENTO ;
      edtDesCCustoDebito.Top := edtDesCCustoDebito.Top - INT_ESPACAMENTO ;
      lbContaCredito.Top := lbContaCredito.Top - INT_ESPACAMENTO ;
      mskContaCredito.Top := mskContaCredito.Top - INT_ESPACAMENTO ;
      edtConCreRed.Top := edtConCreRed.Top - INT_ESPACAMENTO ;
      edtDesContaCRedito.Top := edtDesContaCRedito.Top - INT_ESPACAMENTO ;
      lbSubcontaCredito.Top := lbSubcontaCredito.Top - INT_ESPACAMENTO ;
      edtOpcSubcontaCredito.Top := edtOpcSubcontaCredito.Top - INT_ESPACAMENTO ;
      edtCodCliForSubcontaCredito.Top := edtCodCliForSubcontaCredito.Top - INT_ESPACAMENTO ;
      edtNomCliForSubcontaCredito.Top := edtNomCliForSubcontaCredito.Top - INT_ESPACAMENTO ;
      lbCCustoCredito.Top := lbCCustoCredito.Top - INT_ESPACAMENTO ;
      edtCCustoCredito.Top := edtCCustoCredito.Top - INT_ESPACAMENTO ;
      edtDesCCustoCredito.Top := edtDesCCustoCredito.Top - INT_ESPACAMENTO ;
      lbHisPad.Top := lbHisPad.Top - INT_ESPACAMENTO ;
      edtHisPad.Top := edtHisPad.Top - INT_ESPACAMENTO ;
      edtDesHistPadrao.Top := edtDesHistPadrao.Top - INT_ESPACAMENTO ;
      lbHistor.Top := lbHistor.Top - INT_ESPACAMENTO ;
      edtHistor.Top := edtHistor.Top - INT_ESPACAMENTO ;
      lbValor.Top := lbValor.Top - INT_ESPACAMENTO ;
      edtValor.Top := edtValor.Top - INT_ESPACAMENTO ;
      lbTipLan.Top := lbTipLan.Top - INT_ESPACAMENTO ;
      edtTipLan.Top := edtTipLan.Top - INT_ESPACAMENTO ;
      btnAdicionar.Top := btnAdicionar.Top - INT_ESPACAMENTO ;
      btnCancelaItem.Top := btnCancelaItem.Top - INT_ESPACAMENTO ;
      LintValor := LintValor + INT_ESPACAMENTO ;
    end ;

    if not AblnCredito then
    begin
      lbCCustoCredito.Top := lbCCustoCredito.Top - INT_ESPACAMENTO ;
      edtCCustoCredito.Top := edtCCustoCredito.Top - INT_ESPACAMENTO ;
      edtDesCCustoCredito.Top := edtDesCCustoCredito.Top - INT_ESPACAMENTO ;
      lbHisPad.Top := lbHisPad.Top - INT_ESPACAMENTO ;
      edtHisPad.Top := edtHisPad.Top - INT_ESPACAMENTO ;
      edtDesHistPadrao.Top := edtDesHistPadrao.Top - INT_ESPACAMENTO ;
      lbHistor.Top := lbHistor.Top - INT_ESPACAMENTO ;
      edtHistor.Top := edtHistor.Top - INT_ESPACAMENTO ;
      lbValor.Top := lbValor.Top - INT_ESPACAMENTO ;
      edtValor.Top := edtValor.Top - INT_ESPACAMENTO ;
      lbTipLan.Top := lbTipLan.Top - INT_ESPACAMENTO ;
      edtTipLan.Top := edtTipLan.Top - INT_ESPACAMENTO ;
      btnAdicionar.Top := btnAdicionar.Top - INT_ESPACAMENTO ;
      btnCancelaItem.Top := btnCancelaItem.Top - INT_ESPACAMENTO ;
      LintValor := LintValor + INT_ESPACAMENTO ;
    end ;

    pnlItemPeriodico.Height :=  pnlItemPeriodico.Height - LintValor ;
    self.Height :=  self.Height - LintValor ;
  finally
    pFormEndUpdate ;
  end ;

end;

procedure TfrmLancamentosPeriodicos.pRestauraPosicionamentoSubContasDefault;
var
  AprInfoTop: TPair<String,Integer> ;
  Lcmp: TComponent ;
begin
  for AprInfoTop in FdictDefaultTop do
  begin
    Lcmp := self.FindComponent(AprInfoTop.Key) ;
    if Assigned(Lcmp) then
    begin
      TWinControl(Lcmp).Top := AprInfoTop.Value ;
    end ;
  end ;

  Self.Height := FdictDefaultHeight.Items[Self.Name] ;
  pnlItemPeriodico.Height := FdictDefaultHeight.Items[pnlItemPeriodico.Name] ;
end;

procedure TfrmLancamentosPeriodicos.pSalvaPosicionamentoSubContasDefault;
var
  LintCnt: Integer ;
  LcmpParent: TComponent ;
begin
  FdictDefaultTop.Clear ;
  for LintCnt := 0 to self.ComponentCount-1 do
  begin
    LcmpParent := self.Components[LintCnt].GetParentComponent ;
    if Assigned(LcmpParent) then
    begin
      if LcmpParent.Name = pnlItemPeriodico.Name then
      begin
        FdictDefaultTop.Add(self.Components[LintCnt].Name, TWinControl(self.Components[LintCnt]).Top);
      end ;
    end ;
  end ;
  ///Height do Tgroup e TForm
  FdictDefaultHeight.Add(pnlItemPeriodico.Name, pnlItemPeriodico.Height);
  FdictDefaultHeight.Add(Self.Name, Self.Height);
end;

procedure TfrmLancamentosPeriodicos.pSalvaSugestaoUltimoInsert;
begin
  if not FModoInclusao then
    Exit ;

  FillChar(FrecSugestaoProximoInsert, SizeOf(FrecSugestaoProximoInsert), #0);
  FrecSugestaoProximoInsert.strCodEmp := edtEmpLan.Text ;
  FrecSugestaoProximoInsert.fltValor := edtValor.Value ;
  FrecSugestaoProximoInsert.strContaCredito := mskContaCredito.Text ;
  FrecSugestaoProximoInsert.strContaDebito := mskContaDebito.Text ;
  FrecSugestaoProximoInsert.strCentroCustoCredito := edtCCustoCredito.Text ;
  FrecSugestaoProximoInsert.strCentroCustoDebito := edtCCustoDebito.Text ;
  FrecSugestaoProximoInsert.strComplemento := edtHistor.Texto ;
  FrecSugestaoProximoInsert.strHistoricoPadrao := edtHisPad.Text ;
  FrecSugestaoProximoInsert.strTipoFCDebito := edtOpcSubcontaDebito.Text ;
  FrecSugestaoProximoInsert.strClienteFornecedorDebito := edtCodCliForSubcontaDebito.Text ;
  FrecSugestaoProximoInsert.strTipoFCCredito := edtOpcSubcontaCredito.Text ;
  FrecSugestaoProximoInsert.strClienteFornecedorCredito := edtCodCliForSubcontaCredito.Text ;
  FrecSugestaoProximoInsert.strTipoLancamento := edtTipLan.Text ;

end;

procedure TfrmLancamentosPeriodicos.pSetCreditoComSubconta(
  const AValue: Boolean);
begin
  if FblnCreditoComSubconta <> AValue then
  begin
    FblnCreditoComSubconta := AValue ;
    pReorganizaEntradaDadosSubContas;
  end ;
end;

procedure TfrmLancamentosPeriodicos.pSetDebitoComSubconta(const AValue: Boolean);
begin
  if FblnDebitoComSubconta <> AValue then
  begin
    FblnDebitoComSubconta := AValue ;
    pReorganizaEntradaDadosSubContas;
  end ;
end;

function TfrmLancamentosPeriodicos.fMovimentaLinha(const Key: Word;
         Sender: TObject):boolean;
begin
  Result := False ;
  if not dbgBuscaConta.Visible then
  begin
    exit ;
  end;
  if key = VK_DOWN then
  begin
    if not FqryBusca.Active then
    begin
      exit ;
    end ;
    FqryBusca.Next ;
    Result := True ;
  end
  else if key = VK_UP then
  begin
    if not FqryBusca.Active then
    begin
      exit ;
    end ;
    FqryBusca.Prior ;
    Result := True ;
  end ;
  if Result then
  begin
    if Sender is TMaskEditFocus then
    begin
      TMaskEditFocus(Sender).Text := FqryBusca.FieldByName('CODCON').AsString;
    end
    else if Sender is TEditFocus then
    begin
      TMaskEditFocus(Sender).Text := FqryBusca.FieldByName('CONRED').AsString;
    end;
  end;
end;

procedure TfrmLancamentosPeriodicos.pApagaItemDetalhe;
begin
  if not FcdsPerDet.IsEmpty then
  begin
    if fMensagem('', 'Deseja realmente apagar?', ['&Sim', '&Não'], 1) = 1 then
      FcdsPerDet.Delete ;
  end ;
end;

procedure TfrmLancamentosPeriodicos.pBuscarConta(dbeTexto: TCustomEdit; blnRed: Boolean; intTag: Integer);
var
  strTplaco: string ;
begin
  If (fEmptyStr(fSemMascaraPlaNco(dbeTexto.Text), True)) Then
  Begin
    dbgBuscaConta.Visible := False;
    Exit;
  End;

  strTplaco := Contabilidade.Funcoes.fRetTplacoEmpresaLogada(edtEmpLan.Text) ;

  dbgBuscaConta.Tag := 0;

  FqryBusca.Close;
  FqryBusca.SQL.Clear;
  FqryBusca.SQL.Add(' SELECT NCO_CODCON AS CODCON, NCO_DESCRI AS DESCON, NCO_CONRED AS CONRED ');
  FqryBusca.SQL.Add('   FROM PLANCO ');
  FqryBusca.SQL.Add('  WHERE TRUE AND NCO_TPLACO = :TPLACO ');
  FqryBusca.ParamByName('TPLACO').AsString := strTplaco ;
  If (blnRed) Then
    FqryBusca.SQL.Add('  AND (NCO_CONRED LIKE :CODCON) ')
  Else
    FqryBusca.SQL.Add('  AND (NCO_CODCON LIKE :CODCON) ');

  if fCfgCtntsi = 'N' then
  begin
    FqryBusca.SQL.Add(' AND IFNULL(NCO_NATURE,"A") = "A" ') ;
  end ;

  FqryBusca.ParamByName('CODCON').AsString := '%' + fTiraCaracEspeciais(fSemMascaraPlaNco(dbeTexto.Text), True, True, True, True, True) + '%';
  FqryBusca.SQL.Add('  ORDER BY NCO_CODCON ');
  FqryBusca.Open;

  If (Not FqryBusca.IsEmpty) Then
  Begin
    If (blnRed) Then
    begin
      if (intTag = 1) then
        FqryBusca.Locate('NCO_CODCON', mskContaDebito.Text, [])
      else
        FqryBusca.Locate('NCO_CODCON', mskContaCredito.Text, []);
    end;

    dbgBuscaConta.Left := dbeTexto.Left;
    dbgBuscaConta.Top := dbeTexto.Top + dbeTexto.Height + 1;
    dbgBuscaConta.Visible := True;
    dbgBuscaConta.Tag := intTag;
    dbgBuscaConta.BringToFront ;
    if blnRed then
    begin
      dbgBuscaConta.Tag := dbgBuscaConta.Tag + 10 ;
    end;
  End
  Else
    dbgBuscaConta.Visible := False;
end;

function TfrmLancamentosPeriodicos.fCarregaDescricaoConta(
  const AConta: string): string;
var
  strTplaco : string ;
begin
  strTplaco := Contabilidade.Funcoes.fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
  result := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(AConta), strTplaco]);
end;

function TfrmLancamentosPeriodicos.fCarregaContaReduzida(
  const AConta: string): string;
var
  strTplaco : string ;
begin
  strTplaco := Contabilidade.Funcoes.fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
  result := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(AConta), strTplaco]);
end;

procedure TfrmLancamentosPeriodicos.pDesativaCentroCustoCredito(
  const AContaContabil: string);
var
  LPatrim: string ;
  strTplaco: string ;
begin
  if fCfgExpEcd = 'N' then
  begin
    Exit ;
  end;
  if fCfgObrCcu = 'N' then
  begin
    exit ;
  end;
  strTplaco := Contabilidade.Funcoes.fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
  LPatrim := fCampoTabela('NCO_PATRIM', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(AContaContabil), strTplaco]) ;
  if LPatrim = 'S' then
  begin
    edtCCustoCredito.Enabled := False ;
    edtCCustoCredito.Clear ;
    edtDesCCustoCredito.Clear ;
  end;

  if LPatrim = 'N' then
  begin
    if FblnExisteCampoCON_CCUSTO then
    begin
      edtCCustoCredito.Enabled := True ;
    end;
  end;

end;

procedure TfrmLancamentosPeriodicos.pDesativaCentroCustoDebito(
  const AContaContabil: string);
var
  LPatrim: string ;
  strTplaco: string ;
begin
  if fCfgExpEcd = 'N' then
  begin
    Exit ;
  end;

  if fCfgObrCcu = 'N' then
  begin
    exit ;
  end;
  strTplaco := Contabilidade.Funcoes.fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
  LPatrim := fCampoTabela('NCO_PATRIM', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(AContaContabil), strTplaco]) ;
  if LPatrim = 'S' then
  begin
    edtCCustoDebito.Enabled := False ;
    edtCCustoDebito.Clear ;
    edtDesCCustoDebito.Clear ;
  end;

  if LPatrim = 'N' then
  begin
    edtCCustoDebito.Enabled := True ;
  end;
end;

procedure TfrmLancamentosPeriodicos.pEhCreditoComSubConta(const AstrConta,
  AstrEmpLan: String);
var
  LstrConta: String ;
  LstrTplaco: String ;
  LstrSubConta: String ;
begin
  if fCfgDesmembrarSubContaCliFor = 'N' then
    Exit ;

  LstrTplaco := Contabilidade.Funcoes.fRetTplacoEmpresaLogada(AstrEmpLan) ;
  LstrConta := fSemMascaraPlaNco(AstrConta) ;

  LstrSubConta := fCampoTabela('NCO_SUBCNT', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [LstrConta, LstrTplaco], False) ;

  CreditoComSubconta := LstrSubConta = 'S' ;
end;

procedure TfrmLancamentosPeriodicos.pEhDebitoComSubConta(const AstrConta,
  AstrEmpLan: String);
var
  LstrConta: String ;
  LstrTplaco: String ;
  LstrSubConta: String ;
begin
  if fCfgDesmembrarSubContaCliFor = 'N' then
    Exit ;

  LstrTplaco := Contabilidade.Funcoes.fRetTplacoEmpresaLogada(AstrEmpLan) ;
  LstrConta := fSemMascaraPlaNco(AstrConta) ;

  LstrSubConta := fCampoTabela('NCO_SUBCNT', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [LstrConta, LstrTplaco], False) ;

  DebitoComSubconta := LstrSubConta = 'S' ;
end;

procedure TfrmLancamentosPeriodicos.pFormBeginUpdate;
begin
  if FblnFormInCreate then
    Exit ;

  SendMessage(Self.Handle, WM_SETREDRAW, Ord(False), 0);
end;

procedure TfrmLancamentosPeriodicos.pFormEndUpdate;
begin
  if FblnFormInCreate then
    Exit ;

  SendMessage(Self.Handle, WM_SETREDRAW, Ord(True), 0);
  RedrawWindow(Self.Handle, nil, 0, RDW_FRAME or RDW_INVALIDATE or RDW_ALLCHILDREN);
end;

procedure TfrmLancamentosPeriodicos.pGravaTemporariaDetalhe;
begin
  /// incluir
  if FModoInclusao then
  begin
    FcdsPerDet.Append ;
    FcdsPerDet.FieldByName('CON_PARMUL').AsInteger := 0 ;
  end
  else // alterar
    FcdsPerDet.Edit ;

  FcdsPerDet.FieldByName('CON_EMPLAN').AsString := edtEmpLan.Text ;
  FcdsPerDet.FieldByName('CON_CONDEB').AsString := fSemMascaraPlaNco(mskContaDebito.Text) ;
  FcdsPerDet.FieldByName('DES_CONDEB').AsString := edtDesContaDebito.Text ;
  FcdsPerDet.FieldByName('CON_CCUSTO').AsString := edtCCustoDebito.Text ;
  FcdsPerDet.FieldByName('DES_CCUSTO').AsString := edtDesCCustoDebito.Text ;
  FcdsPerDet.FieldByName('CON_CONCRE').AsString := fSemMascaraPlaNco(mskContaCredito.Text) ;
  FcdsPerDet.FieldByName('DES_CONCRE').AsString := edtDesContaCredito.Text ;
  FcdsPerDet.FieldByName('CON_CCUSCR').AsString := edtCCustoCredito.Text ;
  FcdsPerDet.FieldByName('DES_CCUSCR').AsString := edtDesCCustoCredito.Text ;
  FcdsPerDet.FieldByName('CON_HISPAD').AsString := edtHisPad.Text ;
  FcdsPerDet.FieldByName('DES_HISPAD').AsString := edtDesHistPadrao.Text ;
  FcdsPerDet.FieldByName('CON_HISTOR').AsString := edtHistor.Text ;
  FcdsPerDet.FieldByName('CON_VALLAN').AsFloat  := edtValor.Value ;
  FcdsPerDet.FieldByName('CON_TIPLAN').AsString := copy(edtTipLan.Text, 1, 3) ;
  if edtCodCliForSubcontaDebito.Visible then
  begin
    FcdsPerDet.FieldByName('CON_CLIFOR').AsString := edtCodCliForSubcontaDebito.Text ;
    FcdsPerDet.FieldByName('CON_TIP_FC').AsString := edtOpcSubcontaDebito.Text ;
  end
  else if edtCodCliForSubcontaCredito.Visible then
  begin
    FcdsPerDet.FieldByName('CON_CLIFOR').AsString := edtCodCliForSubcontaCredito.Text ;
    FcdsPerDet.FieldByName('CON_TIP_FC').AsString := edtOpcSubcontaCredito.Text ;
  end
  else
  begin
    FcdsPerDet.FieldByName('CON_CLIFOR').clear ;
    FcdsPerDet.FieldByName('CON_TIP_FC').clear ;
  end ;
  FcdsPerDet.Post ;
end;

procedure TfrmLancamentosPeriodicos.pHabilitaDetalhe(
  const AblnHabilita: boolean);
begin
  pnlItemPeriodico.Enabled := AblnHabilita ;
  GridCitel.Enabled := AblnHabilita ;
end;

procedure TfrmLancamentosPeriodicos.pCarregaDetalhe(const AstrAuto: string);
var
  LlstDetalhe : TPeriodicosDetalhe ;
  LobjItem    : TPeriodicoDetalhe ;
  LstrTplaco  : String ;
begin
  FcdsPerDet.DisableControls ;
  LlstDetalhe := TDadosPeriodicoDetalhe.fSelecionaDados(AstrAuto) ;
  try
    ///limpa o clientDataset do Lote
    FcdsPerDet.EmptyDataSet ;
    for LobjItem in LlstDetalhe do
    begin
      LstrTplaco := Contabilidade.Funcoes.fRetTplacoEmpresaLogada(LobjItem.Emplan) ;
      FcdsPerDet.Append ;
      FcdsPerDet.FieldByName('AUTOINCREM').AsInteger := LobjItem.Seqlan ;
      FcdsPerDet.FieldByName('CON_EMPLAN').AsString := LobjItem.Emplan ;
      FcdsPerDet.FieldByName('CON_CONCRE').AsString := LobjItem.Concre ;
      FcdsPerDet.FieldByName('DES_CONCRE').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [LobjItem.Concre, LstrTplaco], False);
      FcdsPerDet.FieldByName('CON_CONDEB').AsString := LobjItem.Condeb ;
      FcdsPerDet.FieldByName('DES_CONDEB').AsString := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [LobjItem.Condeb, LstrTplaco], False) ;
      FcdsPerDet.FieldByName('CON_CCUSCR').AsString := LobjItem.Ccuscr ;
      FcdsPerDet.FieldByName('DES_CCUSCR').AsString := fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [LobjItem.Ccuscr], False) ;
      FcdsPerDet.FieldByName('CON_CCUSTO').AsString := LobjItem.Ccusto ;
      FcdsPerDet.FieldByName('DES_CCUSTO').AsString := fCampoTabela('EVE_DESEVE', 'CADEVE', ['EVE_CODEVE'], [LobjItem.Ccusto], False) ;
      FcdsPerDet.FieldByName('CON_HISPAD').AsInteger := LobjItem.Hispad ;
      FcdsPerDet.FieldByName('DES_HISPAD').AsString := fRetDescHistoricoPadrao(LobjItem.Hispad.ToString, LobjItem.Emplan);
      FcdsPerDet.FieldByName('CON_HISTOR').AsString := LobjItem.Histor ;
      FcdsPerDet.FieldByName('CON_VALLAN').AsFloat := LObjItem.ValLan ;
      FcdsPerDet.FieldByName('CON_TIPLAN').AsString := LobjItem.Tiplan ;
      FcdsPerDet.FieldByName('CON_PARMUL').AsInteger := LobjItem.Parmul ;
      FcdsPerDet.FieldByName('CON_TIPLAN').AsString := LobjItem.Tiplan ;
      FcdsPerDet.FieldByName('CON_CLIFOR').AsString := LobjItem.Clifor ;
      FcdsPerDet.FieldByName('CON_TIP_FC').AsString := LobjItem.Tip_fc ;
      FcdsPerDet.Post ;
    end ;

    if LlstDetalhe.Count = 0 then
      edtTipLan.ItemIndex := fIndexTipLan('MAN') ;

  finally
    FreeAndNil(LlstDetalhe) ;
    FcdsPerDet.EnableControls ;
  end ;

end;

procedure TfrmLancamentosPeriodicos.pCarregaItemDetalhe;
begin
  If Not FcdsPerDet.IsEmpty Then
  begin
    FstrSequenAlt := FcdsPerDet.FieldByName('AUTOINCREM').AsString ;
    edtEmpLan.Text := FcdsPerDet.FieldByName('CON_EMPLAN').AsString ;
    edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpLan.Text]) ;
    mskContaDebito.Text := FcdsPerDet.FieldByName('CON_CONDEB').AsString ;
    edtDesContaDebito.Text := FcdsPerDet.FieldByName('DES_CONDEB').AsString ;
    edtCCustoDebito.Text := FcdsPerDet.FieldByName('CON_CCUSTO').AsString ;
    edtDesCCustoDebito.Text := FcdsPerDet.FieldByName('DES_CCUSTO').AsString ;
    edtConDebRed.Text := fCarregaContaReduzida(mskContaDebito.Text) ;
    mskContaCredito.Text := FcdsPerDet.FieldByName('CON_CONCRE').AsString ;
    edtDesContaCredito.Text := FcdsPerDet.FieldByName('DES_CONCRE').AsString ;
    edtCCustoCredito.Text := FcdsPerDet.FieldByName('CON_CCUSCR').AsString ;
    edtDesCCustoCredito.Text := FcdsPerDet.FieldByName('DES_CCUSCR').AsString ;
    edtConCreRed.Text := fCarregaContaReduzida(mskContaCredito.Text) ;
    edtHisPad.Text := FcdsPerDet.FieldByName('CON_HISPAD').AsString ;
    edtDesHistPadrao.Text := FcdsPerDet.FieldByName('DES_HISPAD').AsString ;
    edtHistor.Text := FcdsPerDet.FieldByName('CON_HISTOR').AsString ;
    edtValor.Value:= FcdsPerDet.FieldByName('CON_VALLAN').AsFloat ;
    edtTipLan.ItemIndex := fIndexTipLan(FcdsPerDet.FieldByName('CON_TIPLAN').AsString) ;
    pEhDebitoComSubConta(mskContaDebito.Text, edtEmpLan.Text) ;
    pEhCreditoComSubConta(mskContaCredito.Text, edtEmpLan.Text) ;
    if edtCodCliForSubcontaDebito.Visible then
    begin
      edtCodCliForSubcontaDebito.Text := FcdsPerDet.FieldByName('CON_CLIFOR').AsString ;
      edtOpcSubcontaDebito.Text := FcdsPerDet.FieldByName('CON_TIP_FC').AsString ;
      edtNomCliForSubcontaDebito.Text := fCarregaCliForBD(edtCodCliForSubcontaDebito.Text, edtOpcSubcontaDebito.Text) ;
    end
    else if edtCodCliForSubcontaCredito.Visible then
    begin
      edtCodCliForSubcontaCredito.Text := FcdsPerDet.FieldByName('CON_CLIFOR').AsString ;
      edtOpcSubcontaCredito.Text := FcdsPerDet.FieldByName('CON_TIP_FC').AsString ;
      edtNomCliForSubcontaCredito.Text := fCarregaCliForBD(edtCodCliForSubcontaCredito.Text, edtOpcSubcontaCredito.Text) ;
    end
    else
    begin
      edtCodCliForSubcontaDebito.Clear ;
      edtOpcSubcontaDebito.Clear ;
      edtNomCliForSubcontaDebito.Clear ;
      edtCodCliForSubcontaCredito.Clear ;
      edtOpcSubcontaCredito.Clear ;
      edtNomCliForSubcontaCredito.Clear ;
    end ;
    FModoInclusao := False ;
  end ;
end;

procedure TfrmLancamentosPeriodicos.pCarregaPlanoContabilCredito(
  const blnBuscaPorChave: Boolean; blnCampoContaReduzida: Boolean);
var
  strTplaco: string ;
begin
  if blnBuscaPorChave then
  begin
    edtDesContaCredito.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaCredito.Text)]);
    if not blnCampoContaReduzida then
    begin
      edtConCreRed.Text := fCampoTabelaPlanco('NCO_CONRED', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaCredito.Text)]);
    end;
  end
  else
  begin
    strTplaco := Contabilidade.Funcoes.fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
    edtDesContaCredito.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaCredito.Text), strTplaco]);
    if not blnCampoContaReduzida then
    begin
      edtConCreRed.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaCredito.Text), strTplaco]);
    end;
  end;
  pEhCreditoComSubConta(mskContaCredito.Text, edtEmpLan.Text) ;
end;

procedure TfrmLancamentosPeriodicos.pCarregaPlanoContabilDebito(
  const blnBuscaPorChave: Boolean; blnCampoContaReduzida: Boolean);
var
  strTplaco : string ;
begin
  if blnBuscaPorChave then
  begin
    edtDesContaDebito.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaDebito.Text)]);
    if not blnCampoContaReduzida then
    begin
      edtConDebRed.Text := fCampoTabelaPlanco('NCO_CONRED', ['NCO_CODCON'], [fSemMascaraPlaNco(mskContaDebito.Text)]);
    end;
  end
  else
  begin
    strTplaco := Contabilidade.Funcoes.fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
    edtDesContaDebito.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), strTplaco]);
    if not blnCampoContaReduzida then
    begin
      edtConDebRed.Text := fCampoTabela('NCO_CONRED', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), strTplaco]);
    end;
  end;
  pEhDebitoComSubConta(mskContaDebito.Text, edtEmpLan.Text) ;
end;

procedure TfrmLancamentosPeriodicos.pCarregaSugestaoUltimoInsert;
var
  LrecSugestaoVazia: TDadosSugestaoInsertLancamentoContabil ;
begin
  if not FModoInclusao then
    Exit ;

  FillChar(LrecSugestaoVazia, SizeOf(LrecSugestaoVazia), #0) ;

  if CompareMem(@FrecSugestaoProximoInsert,
                @LrecSugestaoVazia,
                SizeOf(TDadosSugestaoInsertLancamentoContabil)) then
    Exit ;

  edtEmpLan.Text := FrecSugestaoProximoInsert.strCodEmp ;
  fValidaCampos(edtEmpLan) ;
  edtValor.Value := FrecSugestaoProximoInsert.fltValor ;
  mskContaCredito.Text := FrecSugestaoProximoInsert.strContaCredito ;
  fValidaCampos(mskContaCredito) ;
  mskContaDebito.Text := FrecSugestaoProximoInsert.strContaDebito ;
  fValidaCampos(mskContaDebito) ;
  edtCCustoCredito.Text := FrecSugestaoProximoInsert.strCentroCustoCredito ;
  fValidaCampos(edtCCustoCredito) ;
  edtCCustoDebito.Text := FrecSugestaoProximoInsert.strCentroCustoDebito ;
  fValidaCampos(edtCCustoDebito) ;
  edtHistor.Texto := FrecSugestaoProximoInsert.strComplemento ;
  edtHisPad.Text := FrecSugestaoProximoInsert.strHistoricoPadrao ;
  fValidaCampos(edtHisPad) ;
  edtOpcSubcontaDebito.Text := FrecSugestaoProximoInsert.strTipoFCDebito ;
  edtCodCliForSubcontaDebito.Text := FrecSugestaoProximoInsert.strClienteFornecedorDebito ;
  fValidaCampos(edtCodCliForSubcontaDebito) ;
  edtOpcSubcontaCredito.Text := FrecSugestaoProximoInsert.strTipoFCCredito ;
  edtCodCliForSubcontaCredito.Text := FrecSugestaoProximoInsert.strClienteFornecedorCredito ;
  fValidaCampos(edtCodCliForSubcontaCredito) ;
  edtTipLan.ItemIndex := fIndexTipLan(FrecSugestaoProximoInsert.strTipoLancamento) ;
end;

function TfrmLancamentosPeriodicos.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  strTplaco: string ;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    If (Sender = edtEmpLan) and (fValidaCamposDetalhe) Then
    Begin
      if fEmptyStr(edtEmpLan.Text) then
      begin
        edtNomEmp.Clear;
        Result := True;
      end
      else
      Begin
        edtNomEmp.Text := fCampoTabela('EMP_NOMEMP', 'CADEMP', ['EMP_CODEMP'], [edtEmpLan.Text], False);
        If (fEmptyStr(edtNomEmp.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&Ok']);
          Result := False;
        end;
      End;
    End

    Else If (Sender = mskContaCredito) and (fValidaCamposDetalhe) Then
    Begin
      pCarregaPlanoContabilCredito(blnBuscaPorChave) ;
      pDesativaCentroCustoCredito(mskContaCredito.Text) ;
      If (Not fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) And (fEmptyStr(edtDesContaCredito.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','Conta de Crédito Inválida!',['&OK']);
        Result := False;
      end
      else if (FblnExisteCampoNCO_NATURE) and (Not fEmptyStr(fSemMascaraPlaNco(mskContaCredito.Text))) then
      begin
        strTplaco := Contabilidade.Funcoes.fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
        if (fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaCredito.Text), strTplaco]) = 'S') then
        begin
          fMensagem('ATENÇÃO!','Conta de natureza sintética não pode ser selecionada para o lançamento!',['&OK']);
          Result := False;
        end;
      end;
    End

    Else If (Sender = edtConCreRed) and (fValidaCamposDetalhe) Then
    Begin
      if dbgBuscaConta.Visible then
      begin
        dbgBuscaContaDblClick(Nil);
        pCarregaPlanoContabilCredito(blnBuscaPorChave, True) ;
      end;
    End

    Else If (Sender = mskContaDebito) and (fValidaCamposDetalhe) Then
    Begin
      pCarregaPlanoContabilDebito(blnBuscaPorChave) ;
      pDesativaCentroCustoDebito(mskContaDebito.Text) ;
      If (Not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) And (fEmptyStr(edtDesContaDebito.Text)) Then
      Begin
        fMensagem('ATENÇÃO!','Conta de Débito Inválida!',['&OK']);
        Result := False;
      end
      else if (FblnExisteCampoNCO_NATURE) and (Not fEmptyStr(fSemMascaraPlaNco(mskContaDebito.Text))) then
      begin
        strTplaco := Contabilidade.Funcoes.fRetTplacoEmpresaLogada(edtEmpLan.Text) ;
        if (fCampoTabela('NCO_NATURE', 'PLANCO', ['NCO_CODCON', 'NCO_TPLACO'], [fSemMascaraPlaNco(mskContaDebito.Text), strTplaco]) = 'S') then
        begin
          fMensagem('ATENÇÃO!','Conta de natureza sintética não pode ser selecionada para o lançamento!',['&OK']);
          Result := False;
        end;
      end;
    End

    Else If (Sender = edtConDebRed) and (fValidaCamposDetalhe) Then
    Begin
      if dbgBuscaConta.Visible then
      begin
        dbgBuscaContaDblClick(Nil);
        pCarregaPlanoContabilDebito(blnBuscaPorChave, True) ;
      end;
    End

    Else If (Sender = edtTipLan) and (fValidaCamposDetalhe) Then
    Begin
      if fEmptyStr(edtTipLan.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O Tipo de Lançamento deve ser preenchido!', ['&Ok']);
        Result := False;
      end;
    End

    Else If (Sender = dbeDescri) Then
    Begin
      if fEmptyStr(dbeDescri.Text) then
      begin
        fMensagem('ATENÇÃO!', 'Descrição deve ser preenchida!', ['&Ok']);
        Result := False;
      end;
    End

    Else If (Sender = edtCCustoDebito) and (edtCCustoDebito.Enabled) and (fValidaCamposDetalhe) Then
    Begin
      If Not fEmptyStr(edtCCustoDebito.Text) Then
      Begin
        edtDesCCustoDebito.Text := fCarregaCentroCusto(edtCCustoDebito.Text);
        If fEmptyStr(edtDesCCustoDebito.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesCCustoDebito.Clear;
      End;
    End

    Else If (Sender = edtCCustoCredito)  and (edtCCustoCredito.Enabled) and (fValidaCamposDetalhe) Then
    Begin
      If Not fEmptyStr(edtCCustoCredito.Text) Then
      Begin
        edtDesCCustoCredito.Text := fCarregaCentroCusto(edtCCustoCredito.Text);
        If fEmptyStr(edtDesCCustoCredito.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesCCustoCredito.Clear;
      End;
    End

    else if (Sender = edtHisPad) and (fValidaCamposDetalhe) then
    begin
      If Not fEmptyStr(edtHisPad.Text) Then
      Begin
        edtDesHistPadrao.Text := fCarregaHistoricoPadrao(edtHisPad.Text);
        If fEmptyStr(edtDesHistPadrao.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse histórico padrão não está cadastrado!', ['&OK']);
          Result := False;
        End;
      End
      Else
      Begin
        edtDesHistPadrao.Clear;
      End;

    end
    else if (Sender = edtOpcSubcontaDebito) and (edtOpcSubcontaDebito.Visible) then
    begin
      Result := fValidaOpcaoSubConta(edtOpcSubcontaDebito) ;
    end
    else if (Sender = edtOpcSubcontaCredito) and (edtOpcSubcontaCredito.Visible) then
    begin
      Result := fValidaOpcaoSubConta(edtOpcSubcontaCredito) ;
    end
    else if (Sender = edtCodCliForSubcontaDebito) and (edtCodCliForSubcontaDebito.Visible) then
    begin
      if not fValidaOpcaoSubConta(edtOpcSubcontaDebito) then
      begin
        pSetFocus(edtOpcSubcontaDebito);
        Result := False ;
        Exit ;
      end ;
      Result := fCarregaCliForSubConta(edtCodCliForSubcontaDebito, edtNomCliForSubcontaDebito, edtOpcSubcontaDebito.Text) ;
    end
    else if (Sender = edtCodCliForSubcontaCredito) and (edtCodCliForSubcontaCredito.Visible) then
    begin
      if not fValidaOpcaoSubConta(edtOpcSubcontaCredito) then
      begin
        pSetFocus(edtOpcSubcontaCredito);
        Result := False ;
        Exit ;
      end ;
      Result := fCarregaCliForSubConta(edtCodCliForSubcontaCredito, edtNomCliForSubcontaCredito, edtOpcSubcontaCredito.Text) ;
    end;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmLancamentosPeriodicos.fValidaCamposDetalhe: boolean;
begin
  result := FblnValidaDetalhe or
            edtEmpLan.Focused or
            mskContaDebito.Focused or
            edtConDebRed.Focused or
            edtCCustoDebito.Focused or
            mskContaCredito.Focused or
            edtConCreRed.Focused or
            edtCCustoCredito.Focused or
            edtHisPad.Focused or
            edtHistor.Focused or
            edtValor.Focused or
            edtTipLan.Focused
end;

function TfrmLancamentosPeriodicos.fValidaOpcaoSubConta(
  AedtCampo: TEditFocus): Boolean;
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

procedure TfrmLancamentosPeriodicos.GridCitelTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) Then
    pCarregaItemDetalhe
  Else If (Key = VK_DELETE) Then
    pApagaItemDetalhe
  Else If (Key = VK_ESCAPE) Then
    pSetFocus(edtEmpLan);
end;

function TfrmLancamentosPeriodicos.fCarregaCentroCusto(
  const ACodigo: string): string;
begin
  result := fRetNomEvento(ACodigo) ;
end;

function TfrmLancamentosPeriodicos.fCarregaCliForSubConta(AedtCodigo,
  AedtDescricao: TEditFocus; const AstrOpcao: String): Boolean;
var
  LstrDescrMensagem: String ;
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
  End;
end;

function TfrmLancamentosPeriodicos.fCarregaHistoricoPadrao(
  const ACodigo: string): string;
begin
  if fEmptyStr(edtEmplan.Text) then
  begin
    result := '';
    exit;
  end;

  result := fRetDescHistoricoPadrao(ACodigo, edtEmplan.Text);
end;

procedure TfrmLancamentosPeriodicos.pCarregaTipoContabeisManutencao;
begin
  pCarregaTiposContabeis(edtTipLan, True, True);
end;

function TfrmLancamentosPeriodicos.fCriaCdsDados: TUniClientDataSet;
var
  LField : TFieldDef ;
begin
  Result := TUniClientDataSet.Create(Self);

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'AUTOINCREM';
  LField.DataType := ftInteger;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_PARMUL';
  LField.DataType := ftInteger;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_EMPLAN';
  LField.DataType := ftString;
  LField.Size     := 3;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_CONCRE';
  LField.DataType := ftString;
  LField.Size     := 20;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_CONDEB';
  LField.DataType := ftString;
  LField.Size     := 20;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_HISTOR';
  LField.DataType := ftString;
  LField.Size     := 400;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_VALLAN';
  LField.DataType := ftFloat;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_CCUSTO';
  LField.DataType := ftString;
  LField.Size     := 5;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'CON_CCUSCR';
  LField.DataType := ftString;
  LField.Size     := 5;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'DES_CONDEB';
  LField.DataType := ftString;
  LField.Size     := 50;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'DES_CCUSTO';
  LField.DataType := ftString;
  LField.Size     := 50;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'DES_CCUSCR';
  LField.DataType := ftString;
  LField.Size     := 50;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'DES_CONCRE';
  LField.DataType := ftString;
  LField.Size     := 50;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_HISPAD';
  LField.DataType := ftInteger;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name := 'DES_HISPAD';
  LField.DataType := ftString;
  LField.Size     := 200;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_TIPLAN';
  LField.DataType := ftString;
  LField.Size     := 3;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_MODIFI';
  LField.DataType := ftBoolean;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_CLIFOR';
  LField.DataType := ftString;
  LField.Size     := 8;
  LField.Required := False;

  LField := Result.FieldDefs.AddFieldDef ;
  LField.Name     := 'CON_TIP_FC';
  LField.DataType := ftString;
  LField.Size     := 1;
  LField.Required := False;

  Result.CreateDataSet;

  TFloatField(Result.FieldByName('CON_VALLAN')).DisplayFormat := '#,##0.00';
  Result.FieldByName('CON_CONDEB').EditMask := fMskCon;
  Result.FieldByName('CON_CONCRE').EditMask := fMskCon;
end;

function TfrmLancamentosPeriodicos.fGravaDetalhe(const AstrSeqGer: string): boolean;
var
  LlstDetalhe: TPeriodicosDetalhe ;
  LobjItem: TPeriodicoDetalhe ;
  LintItem: Integer ;
begin
  LlstDetalhe := TPeriodicosDetalhe.Create();
  LintItem := 0 ;
  try
    FcdsPerDet.DisableControls ;
    try
      FcdsPerDet.First ;
      while not FcdsPerDet.Eof do
      begin
        inc(LintItem) ;
        LobjItem := TPeriodicoDetalhe.Create ;
        LobjItem.Seqger := AstrSeqGer ;
        LobjItem.Seqlan := LintItem ;
        LobjItem.Emplan := FcdsPerDet.FieldByName('CON_EMPLAN').AsString ;
        LobjItem.Concre := FcdsPerDet.FieldByName('CON_CONCRE').AsString ;
        LobjItem.Condeb := FcdsPerDet.FieldByName('CON_CONDEB').AsString ;
        LobjItem.Ccuscr := FcdsPerDet.FieldByName('CON_CCUSCR').AsString ;
        LobjItem.Ccusto := FcdsPerDet.FieldByName('CON_CCUSTO').AsString ;
        LobjItem.Hispad := FcdsPerDet.FieldByName('CON_HISPAD').AsInteger ;
        LobjItem.Histor := FcdsPerDet.FieldByName('CON_HISTOR').AsString ;
        LobjItem.ValLan := FCdsPerDet.FieldByName('CON_VALLAN').AsFloat ;
        LobjItem.Tiplan := FcdsPerDet.FieldByName('CON_TIPLAN').AsString ;
        LobjItem.Parmul := FcdsPerDet.FieldByName('CON_PARMUL').AsInteger ;
        LobjItem.Clifor := FcdsPerDet.FieldByName('CON_CLIFOR').AsString ;
        LobjItem.Tip_fc := FcdsPerDet.FieldByName('CON_TIP_FC').AsString ;
        LlstDetalhe.Add(LobjItem) ;

        FcdsPerDet.Next ;
      end ;
    finally
      FcdsPerDet.EnableControls ;
    end ;

    result := TDadosPeriodicoDetalhe.fAtualizaDados(AstrSeqGer, LlstDetalhe) ;

  finally
    FreeAndNil(LlstDetalhe) ;
  end ;
end;

function TfrmLancamentosPeriodicos.fIndexTipLan(
  const ATipLan: string): integer;
var
  intCnt: integer ;
begin
  result := -1 ;
  for intCnt := 0 to edtTipLan.Items.Count -1 do
  begin
    if copy(edtTipLan.Items.Strings[intCnt], 1, 3) = copy(ATipLan, 1, 3) then
    begin
      result := intCnt ;
      break ;
    end;
  end;
end;

procedure TfrmLancamentosPeriodicos.pCamposCentroCusto;
begin
  edtCCustoCredito.Enabled := FblnExisteCampoCON_CCUSCR ;
  edtCCustoDebito.Enabled := FblnExisteCampoCON_CCUSTO ;
end;

procedure TfrmLancamentosPeriodicos.pMostraColunasSubConta(
  const AblnMostrar: Boolean);
begin
  GridCitelTableViewCON_TIP_FC.Visible := AblnMostrar ;
  GridCitelTableViewCON_CLIFOR.Visible := AblnMostrar ;

  GridCitelTableViewCON_TIP_FC.VisibleForCustomization := AblnMostrar ;
  GridCitelTableViewCON_CLIFOR.VisibleForCustomization := AblnMostrar ;
end;

end.
