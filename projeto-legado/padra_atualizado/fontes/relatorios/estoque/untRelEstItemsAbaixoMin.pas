unit untRelEstItemsAbaixoMin;

interface

uses
  SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiRelatorio, RLFilters, RLDraftFilter, Uni,
  QColorLabel, EditFocus, Buttons, ExtCtrls, Mask, MaskEditFocus, StrUtils,
  Menus, Windows, frxDesgn, frxClass, frxDBSet, frxDMPExport, frxExportPDF,
  frxExportHTML, frxExportXLS, frxExportRTF, AppEvnts, untFuncoesRel,
  Math, UniClientDataSet, DB, ComObj, CheckLst, untRelGeraOr, untFuncoesSimples,
  BitBtnLockedIncrem, ComCtrls, RLReport, DateUtils, dxScreenTip, cxClasses,
  dxCustomHint, cxHint, frxExportCSVTestabilidade, untTypesSistema,
  untZClient, cxProgressBar, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, cxGroupBox, untSalvaDadosInterface,
  ComboBoxFocus, untMesesGiro, cxButtons, untTEditFocusWithTConsultasArray;

type
  TfrmRelEstItemsAbaixoMin = class(TfrmPaiRelatorio)
    dlgExcel: TSaveDialog;
    HintControler: TcxHintStyleController;
    btnAltOrc: TBitBtnLocked;
    btnGerOrc: TBitBtnLocked;
    pgbProgresso: TcxProgressBar;
    cxHintStyleController1: TcxHintStyleController;
    frxRelatorioJ: TfrxReport;
    frxSimilares: TfrxDBDataset;
    pgcControl: TPageControl;
    tbsFiltros1: TTabSheet;
    tbsFiltros2: TTabSheet;
    cxGroupBox5: TcxGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label15: TLabel;
    Label14: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label16: TLabel;
    lblEmpresa: TLabel;
    Label3: TLabel;
    lblDescricao: TLabel;
    lblSitPro: TLabel;
    lblSitProExc: TLabel;
    grpDadosNE: TGroupBox;
    Label6: TLabel;
    lblEspecie: TLabel;
    lblSerie: TLabel;
    lblEmpresaNE: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtDocumento: TEditFocus;
    edtEspecie: TEditFocus;
    edtSerie: TEditFocus;
    edtCodEmpresaNE: TEditFocus;
    edtDesEmpresaNE: TEditFocus;
    edtForNot: TEditFocus;
    edtDesForNot: TEditFocus;
    mskDtaEntIni: TMaskEditFocus;
    mskDtaEntFin: TMaskEditFocus;
    mskLinhaGrupo: TMaskEditFocus;
    edtDesGrupo: TEditFocus;
    edtFornecedor: TEditFocus;
    edtDesFornecedor: TEditFocus;
    edtMarca: TEditFocus;
    edtDesMarca: TEditFocus;
    edtDesGruCmp: TEditFocus;
    edtDesCodDep: TEditFocus;
    edtCodDep: TEditFocus;
    edtRefere: TEditFocus;
    edtUnidade: TEditFocus;
    edtAcoObj: TEditFocus;
    edtCodEmpresa: TEditFocus;
    edtDesEmpresa: TEditFocus;
    chkInativoCompra: TCheckBox;
    rdgStatus: TRadioGroup;
    rdgEstMin: TRadioGroup;
    rdgCompraCentr: TRadioGroup;
    rdgNecCompra: TRadioGroup;
    GroupBox4: TcxGroupBox;
    ColorLabel8: TColorLabel;
    edtGirEst: TEditFocus;
    rdgLocFis: TRadioGroup;
    rdgSaldo: TRadioGroup;
    chkImpRef: TCheckBox;
    chkLinGru: TCheckBox;
    edtGruCmp: TEditFocus;
    edtPrdGru: TEditFocus;
    edtDesPrdGru: TEditFocus;
    edtDescri: TEditFocus;
    chkDesIte: TCheckBox;
    rdgLocFisProdSimilar: TRadioGroup;
    rdgImpLis: TRadioGroup;
    edtDesSitPro: TEditFocus;
    edtCodSitPro: TEditFocus;
    edtCodSitProExc: TEditFocus;
    edtDesSitProExc: TEditFocus;
    pnlParamCompras: TPanel;
    rdgTipAbs: TGroupBox;
    chkTipAbaFabrica: TCheckBox;
    chkTipAbaCD: TCheckBox;
    chkTipAbaAmbos: TCheckBox;
    rdgPolEstTipVenda: TGroupBox;
    chkPolEstLoja: TCheckBox;
    chkPolEstFiliais: TCheckBox;
    cxGroupBox4: TcxGroupBox;
    GroupBox1: TGroupBox;
    lblBasGir: TLabel;
    lstBasGir: TCheckListBox;
    rdgVendas: TGroupBox;
    lblSelMes: TLabel;
    lblQtdMesDia: TLabel;
    lblMesDia: TLabel;
    rdbCalcVendaPorDia: TRadioButton;
    rdbCalcVendasPorMes: TRadioButton;
    chkInfMes: TCheckBox;
    edtDias: TEditFocus;
    cmbMeses: TComboBoxFocus;
    GroupBox3: TGroupBox;
    rdbCompras: TRadioButton;
    rdbLocFis: TRadioButton;
    rdbQtdVen: TRadioButton;
    rdbCodFab: TRadioButton;
    rdbEntFut: TRadioButton;
    chkNivelGiro: TCheckBox;
    chkUltCompra: TCheckBox;
    rdgOrdem: TRadioGroup;
    chkImpSimilares: TCheckBox;
    cxGroupBox3: TcxGroupBox;
    chkSalResEmp: TCheckBox;
    chkSalTransf: TCheckBox;
    chkAdicOrdProduAberta: TCheckBox;
    grpEntFut: TcxGroupBox;
    chkFaltaProduto: TCheckBox;
    chkPrevisaoEntrega: TCheckBox;
    chkAguardandoCliente: TCheckBox;
    rdgCalMinMax: TRadioGroup;
    rdgTipoMultiplo: TRadioGroup;
    rdgAnaEmp: TRadioGroup;
    chkPedCom: TCheckBox;
    chkPedComGar: TCheckBox;
    chkPontoExposicao: TCheckBox;
    rdgGirEst: TRadioGroup;
    chkMesAtu: TCheckBox;
    btnHlpImp: TBitBtnLocked;
    cxGroupBox2: TcxGroupBox;
    Label17: TLabel;
    lblPerGra: TLabel;
    edtEmpCD: TEditFocus;
    edtEmpCDDes: TEditFocus;
    chkLocFisCD: TCheckBox;
    chkSalRes: TCheckBox;
    chkLimSal: TCheckBox;
    rdgSaldoCD: TRadioGroup;
    edtPerGra: TEditFocus;
    GroupBox2: TGroupBox;
    edtPerEam: TEditFocus;
    rdbPerEam: TRadioButton;
    rdbDiaEst: TRadioButton;
    edtDiaEst: TEditFocus;
    rdbSemEstSeg: TRadioButton;
    btnHlpMediaVendas: TBitBtnLocked;
    rdbMinSeg: TRadioButton;
    rdbMaxSeg: TRadioButton;
    chkCDNaoPodeAbastecer: TCheckBox;
    chkDescMinMaxCD: TCheckBox;
    chkConsidEstMinCD: TCheckBox;
    procedure mskLinhaGrupoExit(Sender: TObject);
    procedure mskLinhaGrupoKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaGrupo(Var qryCadGru: TUniQuery);
    procedure edtFornecedorExit(Sender: TObject);
    procedure edtFornecedorKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaFornecedor(Var qryCadFor: TUniQuery);
    procedure edtMarcaExit(Sender: TObject);
    procedure edtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaMarca(Var qryCadMar: TUniQuery);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure edtUnidadeExit(Sender: TObject);
    procedure edtCodEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpresaExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAltOrcClick(Sender: TObject);
    procedure edtDestinoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure edtGruCmpExit(Sender: TObject);
    procedure edtGruCmpKeyPress(Sender: TObject; var Key: Char);
    procedure rdbQtdVenClick(Sender: TObject);
    procedure rdbLocFisClick(Sender: TObject);
    procedure rdbComprasClick(Sender: TObject);
    procedure rdbCodFabClick(Sender: TObject);
    procedure edtDocumentoExit(Sender: TObject);
    procedure edtCodEmpresaNEExit(Sender: TObject);
    procedure edtCodEmpresaNEKeyPress(Sender: TObject; var Key: Char);
    procedure edtForNotExit(Sender: TObject);
    procedure edtForNotKeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure rdgTipoMultiploEnter(Sender: TObject);
    procedure rdgTipoMultiploExit(Sender: TObject);
    procedure edtEmpCDKeyPress(Sender: TObject; var Key: Char);
    procedure edtEmpCDExit(Sender: TObject);
    procedure btnGerOrcClick(Sender: TObject);
    procedure edtPrdGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrdGruExit(Sender: TObject);
    procedure edtCodDepKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodDepExit(Sender: TObject);
    procedure lblSelMesClick(Sender: TObject);
    procedure lstBasGirClickCheck(Sender: TObject);
    procedure lstBasGirKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure chkInfMesClick(Sender: TObject);
    Function fRetNroMeses: Integer;
    procedure cmbCalcVendaPorDiaChange(Sender: TObject);
    procedure rdbCalcVendasPorMesClick(Sender: TObject);
    procedure rdbCalcVendaPorDiaClick(Sender: TObject);
    procedure chkLimSalClick(Sender: TObject);
    procedure chkDesIteClick(Sender: TObject);
    procedure chkImpSimilaresClick(Sender: TObject);
    procedure btnHlpMediaVendasClick(Sender: TObject);
    procedure rdbDiaEstClick(Sender: TObject);
    procedure rdbPerEamClick(Sender: TObject);
    procedure rdbSemEstSegClick(Sender: TObject);
    procedure chkCDNaoPodeAbastecerClick(Sender: TObject);
    procedure rdbMinSegClick(Sender: TObject);
    procedure rdgGirEstClick(Sender: TObject);
    procedure edtCodSitProKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodSitProExit(Sender: TObject);
    procedure rdbMaxSegClick(Sender: TObject);
    procedure chkConsidEstMinCDClick(Sender: TObject);
    procedure edtCodSitProExcExit(Sender: TObject);
    procedure edtCodSitProExcKeyPress(Sender: TObject; var Key: Char);
    procedure chkPontoExposicaoClick(Sender: TObject);
    procedure rdgEstMinClick(Sender: TObject);
    procedure btnHlpImpClick(Sender: TObject);
    procedure frxGenGetValue(const VarName: string; var Value: Variant);
    function frxRelatorioJUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }
    FCFGTRITTE: Boolean;
    FItens,
    cdsItens,
    cdsSimilares : TZClient;
    objGeraOR: TRelGeraOR;
    blnUsaInd: Boolean;
    intIndice: Integer;
    intSitPro: Integer;

    objFrmRest: TSalvaInterface;
    strLinFor: String;
    strLinGru: string;
    strLinMar: String;
    strLinEmp: String;
    strLinUni: String;
    strCodDep: String;
    strPrdGru: String;
    strGruCmp: String;
    cdsMeses:  TMesesGiro;
    strMeses: String;
    strSitPro: String;
    strSitProExc: String;

    blnCarregandoDados,
    blnEntFut: Boolean;

    blnPontoExposicao: Boolean;
    blnSitPro: Boolean;


    cdsMinimoSeguranca: TZClient;

    blnFecharForm: Boolean;

    blnExiPct: Boolean;

    procedure pHabilitaOrdemLocFis;
    procedure pGeraExcel(qryDados: TZClient);
    Procedure pAbreQueryItens(strEmpresas: String; qryItens: TZClient; strCodEmpCD: String='');
    procedure pAjustaPontoExposicao(qryItens: TZClient; strField: String = 'NECCOM');
    procedure pAjustaAbastecimento(qryItens: TZClient; blnTrataPercGradativo: Boolean; blnRelatorio: boolean);
    function fRetSQLConsiderarSaldoTransf: String;
    procedure pPopulaCdsSimilares;
    procedure pCriaCdsSimilares;
    function fTemCfgComPontoDeExposicaoAtivo: Boolean;


    procedure pAjustaOpcaoEstCD;

    procedure pCalculaSaldoReservadoCD(cdsItens: TZClient);
    function fCalculaSaldoReservadoCD(pgbStatus: TcxProgressBar): Boolean;

    function fRetNroDiasMedia: Integer;
    function fGetSqlTipoAbstecimento: string;
    function fGetSQLPoliticaEst: string;
    function fGetDescFiltroTipAba: string;
    function fGetDescFiltroPoliticaEst: string;


    Function fGetSqlItens(strEmpresas: String; intIndex: Integer): String;

    function fRetOperadorEstMin: String;
    function fSQLQtdVen(strEmpresa: String = ''; blnSomado: boolean = False): String;
    procedure setMesesVenda;
    function fPegaDataBaseGiro: TDateTime;
    function fContaSelecaoBaseGiro: Integer;
    function fRetSQLOrdemPro(): String;
    Function fSQLPendente: String;
    Function fSQLPendenteGarantia: String;
    Function fSQLNotasEntrada: String;
    Function fEmpSelecionadaIgualEmpLogada: Boolean;

    function fSQLSalEntFut(const AAlias: String = 'G'): String;
    function fGetMotEntFut: String;
    procedure pTratarComponentesVendaPorDia;

    procedure pHabilitaLimeteSaldo(blnHabilita: Boolean);

    function fRetQtdMesesSelecionados: Integer;

    function fChecaMeses: Boolean;

    function fRemoverTodosCaracteresPercentual(Value: String): String;

    procedure pCriaCdsMinimoSeguranca;
    procedure pUtilizarPontoExposicao(pUtilizar: Boolean);
    procedure pMensagemCheckPontoExposicao;
    function fFiltraSimilar(strCodIte: String): Boolean;
    function fRetornaMes(intMes: Integer): string;
    function fRetornaAno(intMes: Integer): string;
  protected
    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;

  public

    { Public declarations }
    fGravaFatGor : TfGravaFatGor;
    fGravaFatDor : TfGravaFatDor;

    objListaMesesVenda : TListaMesesVenda;


    // VARIAVEIS UTILIZADOS PELA GERACAO DO PEDIDO
    strEspDoc : String;
    strMen001 : String;
    strMen002 : String;
    strCodTra : String;
    fltValFre : Double;
    strTipFre : String;
    strTipPed : String;
    strEntFat : String;
    blnOriRcx : Boolean;

    arrLinFor,
    arrLinMar,
    arrLinEmp,
    arrLinUni,
    arrLinGru,
    arrPrdGru,
    arrCodDep,
    arrGruCmp,
    arrSitPro,
    arrSitProExc: TConsultasArray;

    prgProgresso: TcxProgressBar;
  end;

  TTipoSaldoCD = (salNaoLimitado, salPrecentual, salDias);

var
  frmRelEstItemsAbaixoMin: TfrmRelEstItemsAbaixoMin;

implementation

uses untRelEstItemsAbaixoMin_ItensOrc,
     untGeraExcel,
     untPai, untSaldoPedidoCompra,
     untFuncoesConsulta, untConsultas, untMsgValidacaoGeracaoOrcPed,
     untGravando, untConstantes, untIFatReservaSaldo, untTFatReservaSaldo,
  untTLog;

{$R *.dfm}

procedure TfrmRelEstItemsAbaixoMin.mskLinhaGrupoExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(mskLinhaGrupo,edtDesGrupo,arrLinGru, fRetNomeLinhaGrupo,Nil,'da linha/grupo',6);
end;

procedure TfrmRelEstItemsAbaixoMin.mskLinhaGrupoKeyPress(Sender: TObject;
  var Key: Char);

begin
  inherited;

  If fPesqGrupo(Self, mskLinhaGrupo, edtDesGrupo, nil, Key, arrLinGru, False) Then
  Begin
    If fValidaCampos(mskLinhaGrupo, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstItemsAbaixoMin.pCarregaGrupo(Var qryCadGru: TUniQuery);
Begin
  If Not (fEmptyStr(mskLinhaGrupo.Text)) Then
    edtDesGrupo.Text := qryCadGru.FieldByName('GRU_DESGRU').AsString
  Else
    edtDesGrupo.Text := '';
End;

procedure TfrmRelEstItemsAbaixoMin.edtFornecedorExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtFornecedor, edtDesFornecedor, arrLinFor, fRetNomFornecedor, Nil, 'do Fornecedor');
end;

procedure TfrmRelEstItemsAbaixoMin.edtFornecedorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, edtFornecedor, edtDesFornecedor, Nil, Key, arrLinFor, False) Then
  Begin
    If fValidaCampos(edtFornecedor, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstItemsAbaixoMin.edtForNotExit(Sender: TObject);
  Var
    arrForNot : TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtForNot, edtDesForNot, arrForNot, fRetNomFornecedor, Nil, 'do Fornecedor');

end;

procedure TfrmRelEstItemsAbaixoMin.edtForNotKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrForNot : TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, Self, edtForNot, edtDesForNot, nil, Key, arrForNot) Then
  Begin
    If fValidaCampos(edtForNot, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstItemsAbaixoMin.edtGruCmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtGruCmp, edtDesGruCmp, arrGruCmp, Nil, fRetDescGrupoCompra, 'do Grupo de Compra');
end;

procedure TfrmRelEstItemsAbaixoMin.edtGruCmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqGrupoCompra(Self, edtGruCmp, edtDesGruCmp, Nil, Key, arrGruCmp, False) Then
  Begin
    If fValidaCampos(edtGruCmp, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstItemsAbaixoMin.pCarregaFornecedor(Var qryCadFor: TUniQuery);
Begin
  If Not fEmptyStr(edtFornecedor.Text) Then
    edtDesFornecedor.Text := qryCadFor.FieldByName('FOR_NOMFOR').AsString
  Else
    edtDesFornecedor.Text := '';
End;

procedure TfrmRelEstItemsAbaixoMin.edtMarcaExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtMarca, edtDesMarca ,arrLinMar, fRetNomMarca, nil, 'da Marca');
end;

procedure TfrmRelEstItemsAbaixoMin.edtMarcaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {***************************}
  {* NOVA CONSULTA DE MARCAS *}
  {************************DP*}
  If fPesqMarcas(Self, edtMarca, edtDesMarca, Nil, Key, arrLinMar, False) Then
  Begin
    If fValidaCampos(edtMarca, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstItemsAbaixoMin.edtPrdGruExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtPrdGru, edtDesPrdGru, arrPrdGru, fRetNomeGrupoProduto, nil, 'do Grupo de Produto');
end;

procedure TfrmRelEstItemsAbaixoMin.edtPrdGruKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqGrupoProduto(Self, edtPrdGru, edtDesPrdGru, Nil, Key, arrPrdGru, False) Then
  Begin
    If fValidaCampos(edtPrdGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstItemsAbaixoMin.edtCodSitProExcExit(
  Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodSitProExc, edtDesSitProExc, arrSitProExc, fRetNomSituacaoProduto, nil, 'da Situação do Produto');
end;

procedure TfrmRelEstItemsAbaixoMin.edtCodSitProExcKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqSituacaoProduto(Self, edtCodSitProExc, edtDesSitProExc, Nil, Key, arrSitProExc, False) Then
  Begin
    if fValidaCampos(edtCodSitProExc, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstItemsAbaixoMin.edtCodSitProExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodSitPro, edtDesSitPro, arrSitPro, fRetNomSituacaoProduto, nil, 'da Situação do Produto');
end;

procedure TfrmRelEstItemsAbaixoMin.edtCodSitProKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqSituacaoProduto(Self, edtCodSitPro, edtDesSitPro, Nil, Key, arrSitPro, False) Then
  Begin
    if fValidaCampos(edtCodSitPro, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstItemsAbaixoMin.pCarregaMarca(Var qryCadMar: TUniQuery);
Begin
  If Not fEmptyStr(edtMarca.Text) Then
    edtDesMarca.Text := qryCadMar.FieldByName('MAR_DESMAR').AsString
  Else
    edtDesFornecedor.Text := '';
End;

procedure TfrmRelEstItemsAbaixoMin.pCriaCdsMinimoSeguranca;
begin
  cdsMinimoSeguranca := TZClient.Create(Self);
  cdsMinimoSeguranca.qryQuery.SQL.Add('SELECT CAST(""  AS CHAR(7)) AS CODITE, ');
  cdsMinimoSeguranca.qryQuery.SQL.Add('       CAST("N" AS CHAR(1)) AS MINSEG  ');
  cdsMinimoSeguranca.fAbreClient(True, 'TfrmRelEstItemsAbaixoMin.pCriaCdsMinimoSeguranca');
  cdsMinimoSeguranca.IndexFieldNames := 'CODITE';
end;

procedure TfrmRelEstItemsAbaixoMin.pCriaCdsSimilares;
begin
  cdsSimilares := TZClient.Create(Self);
  cdsSimilares.qryQuery.SQL.Add('SELECT G.ITE_CODITE, I.ITE_DESITE, ITE_SALDOS, 0.0000 AS ITE_SALDCD, G.ITE_CODITE AS ITE_PROPRI, I.ITE_REFERE, M.MAR_DESMAR');
  cdsSimilares.qryQuery.SQL.Add('  FROM ITEGER G');
  cdsSimilares.qryQuery.SQL.Add(' INNER JOIN CADITE I ON I.ITE_CODITE = G.ITE_CODITE');
  cdsSimilares.qryQuery.SQL.Add('  LEFT JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR');
  cdsSimilares.qryQuery.SQL.Add(' WHERE FALSE');
  cdsSimilares.fAbreClient(True, 'TfrmRelEstItemsAbaixoMin.pCriaCdsSimilares');
end;

{*****************}
{* VALIDA CAMPOS *}
{**************AF*}
function TfrmRelEstItemsAbaixoMin.fRetOperadorEstMin: String;
begin
  Case rdgEstMin.ItemIndex Of
    0: Result := ' <= ';
    Else Result := ' < ';
  End;
end;


function TfrmRelEstItemsAbaixoMin.fRetornaAno(intMes: Integer): string;
begin
  Result := fStrZero(IntToStr(IIF((MonthOf(VS_Date) - intMes) > 0, YearOf(VS_Date), YearOf(VS_Date) - 1)), 4);
end;

function TfrmRelEstItemsAbaixoMin.fRetornaMes(intMes: Integer): string;
begin
  Result := fStrZero(IntToStr(IIF((MonthOf(VS_Date) - intMes) > 0, (MonthOf(VS_Date) - intMes), (12 + (MonthOf(VS_Date) - intMes)))), 2);
end;

function TfrmRelEstItemsAbaixoMin.fSQLQtdVen(strEmpresa: String = ''; blnSomado: boolean = False): String;
  Var
    intContador: Integer;
    wrdDia, wrdMes, wrdAno: Word;
    intQtdMes: integer;

  function fMontaSQLMes(intAno, intMes, intCont: integer): string;
  Begin

    Result := 'IFNULL((SELECT ' +
                               '   SUM(IFNULL(GIR_QSAI' + fStrZero(intMes, 2) + ', 0)) AS QSAI' + fStrZero(intMes, 2) + ' ' +
                               'FROM ' +
                               '   GIRITE ' +
                               'WHERE ' +
                               '   GIR_CODITE = I.ITE_CODITE ';

    If strEmpresa.IsEmpty Then
      Result := Result + fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP', 'CODEMP')
    Else
      Result := Result + ' AND GIR_CODEMP = ' + strEmpresa;

    Result := Result +         '   AND GIR_A_N_O_ = %d), 0) ' ;

    If blnSomado Then
      Result := Format(Result + ' + ', [intAno])
    Else
      Result := Format(Result + '  AS QSAI' + fStrZero(intCont, 2), [intAno]) +  ', ';
  End;

  function fMontaSQLDias: String;
    Var
      strSQL: String;
  begin
    strSQL := '';
    strSQL := strSQL + '  IFNULL((SELECT ';
    strSQL := strSQL + '     SUM(IF(LEFT(DET_CLAFIS,1) < 5, -DET_QTDITE, DET_QTDITE)) AS QTDITE ';
    strSQL := strSQL + '  FROM ';
    strSQL := strSQL + '     MOVDET ';
    strSQL := strSQL + '  WHERE ';
    strSQL := strSQL + '     DET_DTAENT BETWEEN :DTAINIDIAS AND :DTAFINDIAS AND ';
    strSQL := strSQL + '     DET_PROEMB <> "S" AND ';
    strSQL := strSQL + '     DET_CODITE = I.ITE_CODITE AND ';
    strSQL := strSQL + '     DET_TIP_FC = "C"  AND ';
    strSQL := strSQL + '     DET_CODCLI NOT IN (' + VS_strCliFil + ') AND ';

    strSQL := strSQL + cnsFiltroFFDVTR;

    strSQL := strSQL + '   ((LOCATE(DET_CLAFIS, :CLAVEN) > 0) OR (LOCATE(DET_CLAFIS, :CLADEV) > 0) ';

    If fCfgSis('ENTBRF', varBoolean) Then
      strSQL := strSQL + '     OR (DET_ESPDOC = "BR")) '
    Else
      strSQL := strSQL + '    ) ';

    If strEmpresa.IsEmpty Then
      strSQL := strSQL + fStrLocate(edtCodEmpresa, arrLinEmp, 'DET_CODEMP', 'CODEMP')
    Else
      strSQL := strSQL + ' AND DET_CODEMP = ' + strEmpresa;

    strSQL := strSQL + '  GROUP BY DET_CODITE), 0) ';

    Result := fRetornaSQLSeparandoItensPorDatEntItensPorDatFat(strSQL,
                                                               Nil, //  arrAlias: TParamArrayString=NIL;
                                                               Nil, // arrMacroParaCadaItemDoarrAlias: TParamArrayString=NIL;
                                                               Nil, // arrApenasAsEspecies: TParamArrayString=NIL;
                                                               'DET_', // strPrefixo: String='DET_';
                                                               '+');
  end;


begin
  If rdbCalcVendaPorDia.Checked Then
    Result := fMontaSQLDias
  Else
  Begin
    If Not chkInfMes.Checked Then
    Begin
      intQtdMes := fRetNroMeses;
      DecodeDate(fPegaDataBaseGiro, wrdAno, wrdMes, wrdDia);
      If (wrdMes = 0) Then
      Begin
        wrdMes := 12;
        Dec(wrdAno);
      End;

      For intContador := 1 To intQtdMes Do
      Begin
        Result := Result + fMontaSQLMes(wrdAno, wrdMes, intContador);

        Dec(wrdMes);
        If (wrdMes = 0) Then
        Begin
          wrdMes := 12;
          Dec(wrdAno);
        End;
      End;
    End
    Else
    Begin
      cdsMeses.Filtered := false;
      cdsMeses.Filter := 'SELECI = ' + fQuotedStr('S');
      cdsMeses.Filtered := True;
      cdsMeses.Last;
      intContador := 1;
      While not cdsMeses.BoF do
      Begin
        Result := Result + fMontaSQLMes(cdsMeses.FieldByName('VALANO').AsInteger,
                                     cdsMeses.FieldByName('VALMES').AsInteger, intContador);
        cdsMeses.Prior;
        Inc(intContador);
      End;

    End;
    If blnSomado Then
      Result := Result + '0 ';

    cdsMeses.Filtered := False;
  End;
end;

function TfrmRelEstItemsAbaixoMin.fRetQtdMesesSelecionados: Integer;
Begin
  cdsMeses.Filter := 'SELECI = ' + fQuotedStr('S');
  cdsMeses.Filtered := True;

  Result := cdsMeses.RecordCount;

  cdsMeses.Filtered := False;
End;

function TfrmRelEstItemsAbaixoMin.fChecaMeses: Boolean;
Begin
  If chkInfMes.Checked Then
    Result := fRetQtdMesesSelecionados = StrToIntDef(cmbMeses.Text, 0)
  Else
    Result := True;

  If Not Result Then
  Begin
    cdsMeses.fSelecionaMeses(fRetNroMeses, strMeses);
  End;
End;

function TfrmRelEstItemsAbaixoMin.fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean;
  Var
    intIndex: Integer;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If Sender = edtDocumento Then
    Begin
      edtDocumentoExit(Nil);

      If fEmptyStr(edtDocumento.Text) And blnValidaIndividual Then
      Begin
        blnMudarFoco := False;
        pSetFocus(mskDtaEntIni);
      End;

    End

    Else if (Sender = mskDtaEntIni) And (not fEmptyDate(mskDtaEntIni.Text)) Then
    Begin
      if StrToDateDef(mskDtaEntIni.Text, 0) <= 0 Then
      Begin
        pMensagemOk('Data Inicial Inválida!');
        Result := False;
      End;
    End
    Else
    if (Sender = mskDtaEntFin) And (not fEmptyDate(mskDtaEntFin.Text)) Then
    Begin
      if StrToDateDef(mskDtaEntFin.Text, 0) <= 0 Then
      Begin
        pMensagemOk('Data Final Inválida!');
        Result := False;
      End;
      If Result Then
      Begin
        If StrToDateDef(mskDtaEntFin.Text, 0) < StrToDateDef(mskDtaEntIni.Text, 0) Then
        Begin
          pMensagemOk('A Data Final deve ser Maior ou Igual a Inicial!');
          Result := False;
        End;
      End;
    End

    Else If (rdbCalcVendaPorDia.Checked) And (Sender = edtDias) Then
    Begin

      If fEmptyStr(edtDias.Text) Then
        edtDias.Text := '0';

      If edtDias.Visible Then
      Begin

        If rdbDiaEst.Checked Then
        Begin

          If (StrToIntDef(edtDias.Text, 0) < 1) Then
          Begin
            fMensagem('AVISO','É preciso informar a quantidade de dias para cálculo da média de vendas!', ['&O K']);
            Result := False;
          End

          Else If ((StrToIntDef(edtDias.Text, 0) < 1) Or (StrToIntDef(edtDias.Text, 0) > 1000)) Then
          Begin
            fMensagem('AVISO','A quantidade de dias deve estar entre 1 e 1000.', ['&O K']);
            Result := False;
          End;

        End

        Else If ((StrToIntDef(edtDias.Text, 0) < 0) Or (StrToIntDef(edtDias.Text, 0) > 1000)) Then
        Begin
          fMensagem('AVISO','A quantidade de dias deve estar entre 0 e 1000.', ['&O K']);
          Result := False;
        End;

      End;

    End

    {**************************}
    {* VERIFICA CAMPO DESTINO *}
    {***********************LU*}
    Else If (Sender = edtDestino) Then
    Begin
      If (edtDestino.Text <> 'I') And (edtDestino.Text <> 'V') And (edtDestino.Text <> 'E') Then
      Begin
        fMensagem('','O campo Destino deve ser V, I ou E!',['&O K'],0);
        Result := False;
      End;
    End

    Else If (Sender = edtFornecedor) Then
    Begin
      pDesmarcaLista(edtFornecedor, arrLinFor);
    End

    Else If (Sender = edtMarca) Then
    Begin
      pDesmarcaLista(edtMarca, arrLinMar);
    End

    Else If (Sender = edtUnidade) Then
    Begin
      pDesmarcaLista(edtUnidade, arrLinUni);
    End

    Else
    {******************************}
    {* VALIDA GRUPO DE COMPRA     *}
    {14/08/2012*****************CI*}
    If (Sender = edtGruCmp) Then
    Begin
      pDesmarcaLista(edtGruCmp,arrGruCmp);
    End
    {**************************}
    {*   NIVEL DE GIRO        *}
    {**************************}
    Else If (Sender = edtGirEst) And
       (Pos(edtGirEst.Text, '_T_A_B_C') < 1) Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'Nível de giro de estoque inválido, opções: (T), (A), (B) ou (C).', ['&O k']);
    End


    {**************************}
    {* VERIFICA CAMPO EMPRESA *}
    {***********************LU*}
    Else If (Sender = edtCodEmpresa) Then
    Begin
      If Not fEmptyStr(edtCodEmpresa.Text) Then
      Begin
        If (edtCodEmpresa.Text <> '000') Then
          edtDesEmpresa.Text := fRetNomeEmpresaSelec(edtCodEmpresa.Text);

        If fEmptyStr(edtDesEmpresa.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa não cadastrada!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If Length(arrLinEmp) > 0 Then
          Begin
            For intIndex := Low(arrLinEmp) To High(arrLinEmp) Do
              If Pos(arrLinEmp[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
              Begin
                fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a Empresa ' + arrLinEmp[intIndex].strCodigo + '!', ['&O k']);
                Result := False;
                Break;
              End;
          End
          Else If Pos(edtCodEmpresa.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
            Result := False;
          End;
        End;
      End
      Else pDesmarcaLista(edtCodEmpresa, arrLinEmp);
    End

    Else If (Sender = edtPerEam) Then
    Begin

      If fEmptyStr(edtPerEam.Text) Then
        edtPerEam.Text := '0,00'

      Else If fStrToFloat(edtPerEam.Text) < 0 Then
      Begin
        pMensagemOk('Informe um percentual maior ou igual a zero!');
        Result := False;
      End;

    End

    Else If (Sender = edtDiaEst) Then
    Begin

      If fEmptyStr(edtPerEam.Text) Then
        edtPerEam.Text := '0'

      Else If fStrToFloat(edtDiaEst.Text) < 0 Then
      Begin
        pMensagemOk('Dias de Estoque deve ser maior ou igual a zero!');
        Result := False;
      End;

    End

    Else If (Sender = edtPerGra) Then
    Begin

      If fEmptyStr(edtPerGra.Text) Then
        edtPerGra.Text := '0'

      Else If (fStrToFloat(edtPerGra.Text) < 0) Or (fStrToFloat(edtPerGra.Text) > 100) Then
      Begin
        pMensagemOk('Informe um percentual de abastecimento de 0 a 100!');
        Result := False;
      End

      Else If (fStrToFloat(edtPerGra.Text) > 0) And ((100 Mod StrToIntDef(edtPerGra.Text, 0)) <> 0) Then
      Begin
        pMensagemOk('O percentual de abastecimento dever ser um divisor inteiro de 100!');
        Result := False;
      End

    End Else If (Sender = edtCodSitPro) Then
    Begin

      If fEmptyStr(edtCodSitPro.Text) Then
        edtDesSitPro.Text := ''
      Else
      Begin
        If (edtCodSitPro.Text <> '000') Then
          edtDesSitPro.Text := fRetNomSituacaoProduto(edtCodSitPro.Text);

        If fEmptyStr(edtCodSitPro.Text) Then
        Begin
          pMensagemOk('Código da Situação do Produto não econtrado!');
          Result := False;
        End;
      End;

    End Else If (Sender = edtCodSitProExc) Then
    Begin

      If fEmptyStr(edtCodSitProExc.Text) Then
        edtDesSitProExc.Text := ''
      Else
      Begin
        If (edtCodSitProExc.Text <> '000') Then
          edtDesSitProExc.Text := fRetNomSituacaoProduto(edtCodSitProExc.Text);

        If fEmptyStr(edtCodSitProExc.Text) Then
        Begin
          pMensagemOk('Código da Situação do Produto não econtrado!');
          Result := False;
        End;
      End;

    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

Function TfrmRelEstItemsAbaixoMin.fSQLPendente: String;
  Var
    strEmpAce,
    strSQL: String;

    stlLista: TStringList;
Begin
  strEmpAce := Trim(AnsiReplaceStr(strEmpAcessoUsuarioLogado, '_', ','));
  stlLista  := TStringList.Create;
  stlLista.CommaText := strEmpAce;

  If Length(arrLinEmp) > 0 then
    strSQL := fSQLQuantidadePendenteCompra('I.ITE_CODITE', fArrCodigosToLista(edtCodEmpresa.Text, arrLinEmp), False, False)
  Else
    strSQL := fSQLQuantidadePendenteCompra('I.ITE_CODITE', fCommaText(stlLista, True), False, False);

  Result := strSQL;

  FreeAndNil(stlLista);
End;

Function TfrmRelEstItemsAbaixoMin.fSQLPendenteGarantia: String;
  Var
    strEmpAce,
    strSQL: String;

    stlLista: TStringList;
Begin
  strEmpAce := Trim(AnsiReplaceStr(strEmpAcessoUsuarioLogado, '_', ','));
  stlLista  := TStringList.Create;
  stlLista.CommaText := strEmpAce;

  If Length(arrLinEmp) > 0 then
    strSQL := fSQLQuantidadePendenteCompraGarantia('I.ITE_CODITE', fArrCodigosToLista(edtCodEmpresa.Text, arrLinEmp))
  Else
    strSQL := fSQLQuantidadePendenteCompraGarantia('I.ITE_CODITE', fCommaText(stlLista, True));

  Result := strSQL;

  FreeAndNil(stlLista);
End;

function TfrmRelEstItemsAbaixoMin.fSQLSalEntFut(const AAlias: String = 'G'): String;
begin
  Result := ' 0 ';

  If not blnEntFut Then
    Exit;

  Result := '';

  If (fCfgSis('BEFTRG', VarBoolean)) Then
    Result := Result + ' - ' + fGetSQLSomaCamposEntregaFutura(AAlias);

  If Pos('A', fGetMotEntFut) > 0 Then
    Result := Result + ' + IFNULL(' + AAlias + '.ITE_QTEF_A, 0)';

  If Pos('F', fGetMotEntFut) > 0 Then
    Result := Result + ' + IFNULL(' + AAlias + '.ITE_QTEF_F, 0)';

  If Pos('P', fGetMotEntFut) > 0 Then
    Result := Result + ' + IFNULL(' + AAlias + '.ITE_QTEF_P, 0)';

  If fEmptyStr(Result) Then
    Result := ' 0 ';

  Result := '(' + Result + ')';
end;

Function TfrmRelEstItemsAbaixoMin.fSQLNotasEntrada: String;
  Var
    strSQLProd : String;
Begin
  Result := '';
  {*****************************************************************}
  {* FAZ A CONSULTA EM UM DETERMINADO DOCUMENTO/PERIODO DE ENTRADA *}
  {**************************************************************GB*}
  If (Not fEmptyStr(edtDocumento.Text)) Or ((Not fEmptyDate(mskDtaEntIni.Text)) And (Not fEmptyDate(mskDtaEntFin.Text))) Then
  Begin
    strSQLProd :=              ' SELECT ';
    strSQLProd := strSQLProd + '    DET_CODITE ';
    strSQLProd := strSQLProd + ' FROM ';
    strSQLProd := strSQLProd + '    MOVDET ';
    strSQLProd := strSQLProd + ' WHERE ';

    If (Not fEmptyStr(edtDocumento.Text)) Then
    Begin
      strSQLProd := strSQLProd + ' DET_NUMDOC = :NUMDOC          ';
      strSQLProd := strSQLProd + ' AND DET_ESPDOC = :ESPDOC      ';

      If Not fEmptyStr(edtForNot.Text) Then
        strSQLProd := strSQLProd + ' AND DET_CODFOR = :FORNOT      ';

      If (Not fEmptyStr(edtCodEmpresaNE.Text)) Then
        strSQLProd := strSQLProd + ' AND DET_CODEMP = :CODEMP_NE   ';

      If (Not fEmptyStr(edtSerie.Text)) Then
        strSQLProd := strSQLProd + ' AND DET_SERIE_ = :SERDOC    ';
    End
    Else If ((Not fEmptyDate(mskDtaEntIni.Text)) And (Not fEmptyDate(mskDtaEntFin.Text))) Then
    Begin
      strSQLProd := strSQLProd + ' DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';
      strSQLProd := strSQLProd + ' AND DET_TIP_FC = "F" ';
      strSQLProd := strSQLProd + ' AND (LOCATE(DET_CLAFIS, :CLACOM) > 0) ';
    End;

    Result := strSQLProd;
  End;
End;

Function TfrmRelEstItemsAbaixoMin.fEmpSelecionadaIgualEmpLogada: Boolean;
  Var
    intCont : integer;
Begin
  Result := False;


  If Not fEmptyStr(edtCodEmpresa.Text) Then
  Begin
    If (Length(arrLinEmp) > 0) Then
    Begin
      For intCont := Low(arrLinEmp) To High(arrLinEmp) Do
      Begin
        If SameText(arrLinEmp[intCont].strCodigo, edtEmpCD.Text) Then
        Begin
          Result := True;
          Break;
        End;
      End;
    End;
  End;
End;

Function TfrmRelEstItemsAbaixoMin.fCalculaSaldoReservadoCD(pgbStatus: TcxProgressBar): Boolean;
  Var
    blnOrdPro,
    blnDelete: Boolean;
    fltSalRes: Double;
Begin
  With FItens Do
  Begin
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := RecordCount;
    Application.ProcessMessages;
    blnOrdPro := fCfgSis('ORDPRO', varBoolean);

    First;
    While Not Eof Do
    Begin
      blnDelete := False;


      Edit;
      fltSalRes := TSaldoReservado.New(TReservaParametros.New()
                                         .EmpresaItem(edtEmpCD.Text)
                                         .CodigoItem(FieldByName('CODITE').AsString)
                                         .CodEmpresa(edtEmpCD.Text)
                                         .TipoReserva(trsPedidoVenda)
                                       ).fGetQuantidade() +

                   TSaldoReservado.New(TReservaParametros.New()
                                         .EmpresaItem(edtEmpCD.Text)
                                         .CodigoItem(FieldByName('CODITE').AsString)
                                         .CodEmpresa(edtEmpCD.Text)
                                         .TipoReserva(trsGarantia)
                                       ).fGetQuantidade() +

                   TSaldoReservado.New(
                       TReservaParametros.New()
                         .EmpresaItem(edtEmpCD.Text)
                         .CodigoItem(FieldByName('CODITE').AsString)
                         .CodEmpresa(edtEmpCD.Text)
                         .TipoReserva(trsEnderecamento)
                       ).fGetQuantidade() +

                   IIF(blnOrdPro,
                        TSaldoReservado.New(
                            TReservaParametros.New()
                           .EmpresaItem(edtEmpCD.Text)
                           .CodigoItem(FieldByName('CODITE').AsString)
                           .CodEmpresa(edtEmpCD.Text)
                           .TipoReserva(trsOrdemProducao)
                          ).fGetQuantidade(), 0)+

                   TSaldoReservado.New(
                       TReservaParametros.New()
                         .EmpresaItem(edtEmpCD.Text)
                         .CodigoItem(FieldByName('CODITE').AsString)
                         .CodEmpresa(edtEmpCD.Text)
                         .TipoReserva(trsExterno)
                       ).fGetQuantidade();

      If (fltSalRes < 0) Then
        fltSalRes := 0;

      FieldByName('REALCD').AsFloat := FieldByName('REALCD').AsFloat  - fltSalRes;

      If chkSalRes.Checked Then
        FieldByName('SALDCD').AsFloat := FieldByName('SALDCD').AsFloat - fltSalRes;

      If rdbPerEam.Checked Then
      Begin
        If (RoundTo(FItens.FieldByName('SALDCD').AsFloat * ((100 - fStrToFloat(edtPerEam.Text)) / 100),-4) < 1) Then
          FieldByName('SALDCD').AsFloat := 0
        Else
          FieldByName('SALDCD').AsFloat := Ceil(FItens.FieldByName('SALDCD').AsFloat * ((100 - fStrToFloat(edtPerEam.Text)) / 100));
      End

      Else If rdbDiaEst.Checked Then
      Begin
        FieldByName('MEDIA_CD').AsFloat := (FieldByName('QTDVEN_CD').AsFloat / fRetNroDiasMedia) * 30;

        If FieldByName('SALDCD').AsFloat > 0 Then
        Begin
          FieldByName('SALDCD').AsFloat := Ceil(FieldByName('SALDCD').AsFloat - ((FieldByName('QTDVEN_CD').AsFloat / fRetNroDiasMedia) * fStrToFloat(edtDiaEst.Text)));

          If FieldByName('SALDCD').AsFloat < 0 Then
            FieldByName('SALDCD').AsFloat := 0;
        End;

      End;

      Post;

      Case rdgSaldoCD.ItemIndex Of
        0: Begin
             If Not (FieldByName('SALDCD').AsFloat > 0) Then
               blnDelete := True;
           End;
        1: Begin
             If Not (FieldByName('SALDCD').AsFloat = 0) Then
               blnDelete := True;
           End;
        3: Begin
             If Not (FieldByName('SALDCD').AsFloat < 0) Then
               blnDelete := True;
           End;
      End;

      If blnDelete Then
        Delete
      Else
        Next;

      pgbStatus.Position := pgbStatus.Position + 1;
      Application.ProcessMessages;
    End;
  End;

  Result := True;
End;

procedure TfrmRelEstItemsAbaixoMin.pCalculaSaldoReservadoCD(cdsItens: TZClient);
Begin
  FItens := cdsItens;
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fCalculaSaldoReservadoCD;
  frmGravando.lblGravando.Caption := 'Aguarde, calculando saldo reservado...';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
End;

function TfrmRelEstItemsAbaixoMin.fRetNroDiasMedia: Integer;
begin
  If rdbCalcVendaPorDia.Checked Then
    result :=  StrToIntDef(edtDias.Text, 0)
  Else
    result :=  StrToIntDef(cmbMeses.Text, 0) * 30;
end;

function TfrmRelEstItemsAbaixoMin.fGetSqlTipoAbstecimento: string;
var sqlIn: string;
begin
  sqlIn := '';
  Result := '';
  If chkTipAbaFabrica.Checked then
    sqlIn := '"C"';
  If chkTipAbaCD.Checked then
    sqlIn := sqlIn + IIf(sqlIn = '', '', ',') + '"T"';
  If chkTipAbaAmbos.Checked then
    sqlIn := sqlIn + IIf(sqlIn = '', '', ',') + '"A"';
  If not fEmptyStr(sqlIn) Then
    Result := ' AND G.ITE_TIPABS IN('+sqlIn+') '
end;

function TfrmRelEstItemsAbaixoMin.fGetDescFiltroTipAba: string;
begin
  Result := '';
  If chkTipAbaFabrica.Checked then
    Result := chkTipAbaFabrica.Caption;
  If chkTipAbaCD.Checked then
    Result := Result + IIf(Result = '', '', ',') + chkTipAbaCD.Caption;
  If chkTipAbaAmbos.Checked then
    Result := Result + IIf(Result = '', '', ',') + chkTipAbaAmbos.Caption;
End;

function TfrmRelEstItemsAbaixoMin.fGetDescFiltroPoliticaEst: string;
begin
  Result := '';
  If chkPolEstLoja.Checked then
    Result := chkPolEstLoja.Caption;
  If chkPolEstFiliais.Checked then
    Result := Result + IIf(Result = '', '', ',') + chkPolEstFiliais.Caption;
end;

function TfrmRelEstItemsAbaixoMin.fGetSQLPoliticaEst: string;
begin
  If (chkPolEstLoja.Checked and chkPolEstFiliais.Checked) then
    Exit('');
  If chkPolEstLoja.Checked then
    result := ' AND G.ITE_VNOLCD = "N" ';
  If chkPolEstFiliais.Checked then
    Result := ' AND G.ITE_VNOLCD = "S" ';
end;

procedure TfrmRelEstItemsAbaixoMin.btnImprimirClick(Sender: TObject);
Var
  strSQL: String;
  blnUsaQtdPen: Boolean;
  frxRel: TfrxReport;
  fltGiroVendaDetalheTop, fltGiroVendaTituloTop: Double;
Const
  cSumLot = 'IFNULL((SELECT SUM(LI.LOT_SALDOS) FROM CADLOT LI  WHERE  LI.LOT_CODITE = G.ITE_CODITE AND LI.LOT_CODEMP = CD.ITE_CODEMP AND LI.LOT_ABSAUT  = "N"), 0)';

  procedure pSetaTipoSaldoCDFast(tipSaldoCD: TTipoSaldoCD; strAliquota: String);
  begin
    TfrxMemoView(frxRel.FindObject('rllSalREALCD')).Visible := tipSaldoCD <> salNaoLimitado;
    TfrxMemoView(frxRel.FindObject('rllSal')).Visible       := tipSaldoCD <> salNaoLimitado;
    TfrxMemoView(frxRel.FindObject('rllSalCont')).Visible   := tipSaldoCD <> salNaoLimitado;

    Case tipSaldoCD Of
      salPrecentual: Begin
                       TfrxMemoView(frxRel.FindObject('rllLabelSaldCdAlq')).Memo.Clear;
                       TfrxMemoView(frxRel.FindObject('rllLabelSaldCdAlq')).Memo.Add('% SALDO');
                     End;

      salDias:       Begin
                       TfrxMemoView(frxRel.FindObject('rllSalLimCD')).Memo.Clear;
                       TfrxMemoView(frxRel.FindObject('rllSalLimCD')).Memo.Add('LIMITADO CD');
                     End;
    End;
  end;

begin
  If Not fChecaMeses Then
    Exit;

  pnlInfo.Caption := 'Gerando Relatório...';
  pnlInfo.Repaint;

  inherited;
  If blnImprime Then
  Begin

    blnEntFut := (chkFaltaProduto.Checked) or (chkPrevisaoEntrega.Checked) or (chkAguardandoCliente.Checked) Or (fCfgSis('BEFTRG', VarBoolean));

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
    strSQL := strSQL + '  LEFT(I.ITE_CODGRU,3) AS LINHA, ';
    strSQL := strSQL + '  CONCAT(LEFT(I.ITE_CODGRU,3), ".", RIGHT(I.ITE_CODGRU,3)) AS GRUPO,         ';
    strSQL := strSQL + ' CONCAT(I.ITE_CODGRU, ".", I.ITE_CODITE) AS GRUITE, ';
    strSQL := strSQL + ' CONCAT(LEFT(I.ITE_CODGRU,3), ".000", " - ", ';
    strSQL := strSQL + '       (SELECT GRU_DESGRU FROM CADGRU ';
    strSQL := strSQL + '        WHERE GRU_CODGRU = CONCAT(LEFT(I.ITE_CODGRU,3),"","000"))) AS LINDES, ';
    strSQL := strSQL + ' CONCAT(LEFT(I.ITE_CODGRU,3), ".", RIGHT(I.ITE_CODGRU,3), " - ", ';
    strSQL := strSQL + '       (SELECT GRU_DESGRU FROM CADGRU ';
    strSQL := strSQL + '        WHERE GRU_CODGRU = I.ITE_CODGRU)) AS GRUDES, ';

    strSQL := strSQL + '  I.ITE_CODFOR AS CODFOR, ';
    strSQL := strSQL + ' CONCAT(I.ITE_CODFOR, " - ", FOR_NOMFOR) AS FORNEC, ';

    strSQL := strSQL + '  I.ITE_CODITE AS CODITE, ';
    strSQL := strSQL + '  I.ITE_CNV_ML AS CNV_ML, ';
    strSQL := strSQL + '  IFNULL(GUN_DESCRI,"OUTROS") AS UNIGRU, ';

    strSQL := strSQL + '  CD.ITE_LOCFIS AS LOCFIS, ';
    strSQL := strSQL + '  CD.ITE_LOCSUP AS LOCSUP, ';

    If fUsaRotinaWMS Then
    begin
      strSQL := strSQL + ' IFNULL((SELECT ';
      strSQL := strSQL + '	  CONCAT(IFNULL(ITE_LOCFIS,""), GROUP_CONCAT(DISTINCT IFNULL(CADLOC.LOC_CODLOC,""))) AS LOCALIZACAO';
      strSQL := strSQL + '  FROM ITEGER';
      strSQL := strSQL + '  INNER JOIN LOCITE ON ITE_CODEMP = LCI_CODEMP';
      strSQL := strSQL + '                    AND ITE_CODITE =  LCI_CODITE';
      strSQL := strSQL + '  INNER JOIN CADLOC ON CADLOC.AUTOINCREM = LCI_LOCFIS';
      strSQL := strSQL + '                    AND LOC_CODEMP = ITE_CODEMP';
      strSQL := strSQL + '  WHERE ITE_CODITE = G.ITE_CODITE AND ITE_CODEMP = G.ITE_CODEMP),"") FISEMP, ';
    end
    else
      strSQL := strSQL + '  G.ITE_LOCFIS AS FISEMP, ';

    strSQL := strSQL + '  G.ITE_LOCSUP AS SUPEMP, ';

    If chkNivelGiro.Checked THen
      strSQL := strSQL + '   IF(TIPGIR.SIS_VALCFG = "S", G.ITE_NIVGIR, I.ITE_NVLGIR) AS NIVGIR,   ';

    If chkUltCompra.Checked Then
    Begin
      strSQL := strSQL + 'G.ITE_PREULT, ';
      strSQL := strSQL + 'LEFT(CONCAT(G.ITE_FORULT, '+
                         '                     "-", '+
                         '(SELECT FOR_NOMFOR FROM CADFOR WHERE FOR_CODFOR = G.ITE_FORULT)), '+
                         ' 35) AS ULTFOR,  ';
    End;

    strSQL := strSQL + '  I.ITE_DESITE AS DESITE, ';
    strSQL := strSQL + '  I.ITE_REFERE AS REFERE, ';
    strSQL := strSQL + '  I.ITE_CODUNI AS UNIDAD, ';
    strSQL := strSQL + '  UNI_SIGUNI AS SIGUNI,   ';
    strSQL := strSQL + '  I.ITE_CODMAR AS CODMAR, ';
    strSQL := strSQL + '  M.MAR_DESMAR AS DESMAR, ';

    if fCfgSis('CFTFSA', varBoolean) then
      strSQL := strSQL + '  (SELECT ITF.ITE_CODFAB FROM ITEFOR ITF WHERE ITF.ITE_CODITE = I.ITE_CODITE AND ITF.ITE_CODFOR = I.ITE_CODFOR AND ITF.ITE_CODEMP = ' + IIF(fEmptyStr(edtCodEmpresa.Text), QuotedStr(VS_strCodEmp), 'G.ITE_CODEMP') + ' LIMIT 1) AS CODFAB, '
    else
      strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, ';

    strSQL := strSQL + '  G.ITE_DTAULT AS DTAULT, ';
    strSQL := strSQL + '  G.ITE_PREULT AS PREULT, ';

    strSQL := strSQL + '  IF(IFNULL(I.ITE_MLTVEN, 0) <= 0, 1, I.ITE_MLTVEN) AS MLTVEN, ';
    strSQL := strSQL + '  IFNULL(G.ITE_ABAMLT, "N") AS ABAMLT, ';
    strSQL := strSQL + '  IF(IFNULL(ITE_MLTCOM, 0) <= 0, 1, ITE_MLTCOM) AS MLTCOM, ';

    strSQL := strSQL + '  "------" AS COMPRA, ';

    If rdbDiaEst.Checked Then
    Begin
      strSQL := strSQL + ' (' + fSQLQtdVen('CD.ITE_CODEMP', True) + ') AS QTDVEN_CD, ';
      strSQL := strSQL + ' CAST(NULL AS DECIMAL(12,4)) AS MEDIA_CD, ';
    End;

    //----------------------------------------------------------------------- SALDCD
    blnUsaQtdPen := (Not fCfgSis('BEFTRG', VarBoolean)) Or fUsaQtdPendenteEntregaFutura;
    strSQL := strSQL + '  IFNULL(CD.ITE_SALDOS, 0) + ' +  IIf(blnUsaQtdPen, fGetSQLSomaCamposEntregaFutura('CD'), '0') + ' AS SALFIS, ';
    strSQL := strSQL + '  ROUND(IFNULL((CD.ITE_SALDOS) ';

    If fUsaRotinaWMS Then
    Begin
      strSQL := strSQL + ' - IFNULL('+cSumLot + ', 0)                                ';
    End;

    Case fCfgSis('CALSAL', varInteger) Of
      1: strSQL := strSQL + ' + IFNULL(CD.ITE_QTEF_A, 0) + IFNULL(CD.ITE_QTEF_F, 0) + IFNULL(CD.ITE_QTEF_P, 0) ';
      2: ;
      3: strSQL := strSQL + ' + IFNULL(CD.ITE_QTEF_F, 0) ';
      4: strSQL := strSQL + ' + IFNULL(CD.ITE_QTEF_A, 0) + IFNULL(CD.ITE_QTEF_P, 0) ';
      5: strSQL := strSQL + ' + IFNULL(CD.ITE_QTEF_A, 0) + IFNULL(CD.ITE_QTEF_F, 0) ';
    End;

    strSQL := strSQL + '  , 0) ';

    If rdbPerEam.Checked And (Not chkSalRes.Checked) Then
      strSQL := strSQL + ' * ((100- ' + ReplaceStr(edtPerEam.Text, ',', '.') + ') / 100) ';

    strSQL := strSQL  + ',4) AS SALDCD, ';
    //---------------------------------------------------------------------------------------------------------------------


    strSQL := strSQL + '  ROUND(IFNULL((CD.ITE_SALDOS)  ';

    If fUsaRotinaWMS Then
    Begin
      strSQL := strSQL + ' - IFNULL('+cSumLot + ' ,0)                                ';
    End;

    Case fCfgSis('CALSAL', varInteger) Of
      1: strSQL := strSQL + ' + IFNULL(CD.ITE_QTEF_A, 0) + IFNULL(CD.ITE_QTEF_F, 0) + IFNULL(CD.ITE_QTEF_P, 0) ';
      2: ;
      3: strSQL := strSQL + ' + IFNULL(CD.ITE_QTEF_F, 0) ';
      4: strSQL := strSQL + ' + IFNULL(CD.ITE_QTEF_A, 0) + IFNULL(CD.ITE_QTEF_P, 0) ';
      5: strSQL := strSQL + ' + IFNULL(CD.ITE_QTEF_A, 0) + IFNULL(CD.ITE_QTEF_F, 0) ';
    End;

    strSQL := strSQL + '  ,0),4) AS REALCD, ';

    strSQL := strSQL  + '  CD.ITE_ESTMIN AS CD_ESTMIN, ';
    strSQL := strSQL  + '  CD.ITE_ESTMAX AS CD_ESTMAX, ';

    strSQL := strSQL + '  SUM(G.ITE_SALDOS + ' + fSQLSalEntFut + ' - ' + fSQLSalResAbaixoMin(chkSalResEmp) + ' + ' + fRetSQLConsiderarSaldoTransf + ') AS SALDOS, ';

    strSQL := strSQL + '  SUM(IFNULL(G.ITE_ESTMIN, 0)) AS ESTMIN, ';
    strSQL := strSQL + '  SUM(G.ITE_ESTMAX) AS ESTMAX, ';
    strSQL := strSQL + '  ' + fGetSQLSomaCamposEntregaFutura() + ' AS ENTFUT, ';

    If rdgCalMinMax.ItemIndex = 0 Then
      strSQL := strSQL + '  SUM(IFNULL(G.ITE_ESTMIN, 0)) AS ESTCAL, '
    Else
      strSQL := strSQL + '  SUM(G.ITE_ESTMAX) AS ESTCAL, ';

    strSQL := strSQL + '  SUM((IFNULL(G.ITE_ESTMIN, 0) - (G.ITE_SALDOS + ' + fSQLSalEntFut  + ' - ' + fSQLSalResAbaixoMin(chkSalResEmp) + ' + ' + fRetSQLConsiderarSaldoTransf + '))) AS SALMIN, ';
    strSQL := strSQL + '  IFNULL(PONEXP.SIS_VALCFG, "N") AS PONEXP, ';
    strSQL := strSQL + '  G.ITE_PONEXP, ';
    strSQL := strSQL + '  CAST(CEIL((';

    If rdgCalMinMax.ItemIndex = 0 Then
      strSQL := strSQL + '  SUM(IFNULL(G.ITE_ESTMIN, 0)) '
      Else
      strSQL := strSQL + '  SUM(G.ITE_ESTMAX) ';

    strSQL := strSQL + ' - (SUM(G.ITE_SALDOS + ' + fRetSQLOrdemPro + ' + ' +
                                                   fSQLSalEntFut   + ' - ' +
                                                   fSQLSalResAbaixoMin(chkSalResEmp)      + ' + ' +
                                                   fRetSQLConsiderarSaldoTransf + ' )) ';

    If chkPedCom.Checked And chkPedComGar.Checked Then
      strSQL := strSQL + ' - ' + fSQLPendente

    Else If chkPedCom.Checked Then
      strSQL := strSQL + ' - (' + fSQLPendente + ' - ' + fSQLPendenteGarantia + ') '

    Else If chkPedComGar.Checked Then
      strSQL := strSQL + ' - ' + fSQLPendenteGarantia;

    strSQL := strSQL + '  )) AS DECIMAL(14, 4)) AS NECCOM, ';
    
    strSQL := strSQL + ' SUM(' +fRetSQLOrdemPro + ') AS ORDPRO, ';

    strSQL := strSQL + ' IFNULL(G.ITE_SALTRA, 0) AS  TEPEND, ';

    strSQL := strSQL + ' CAST("  " AS CHAR(5)) AS LIMSAL, ';

    strSQL := strSQL + fSQLPendente + ' - ' + fSQLPendenteGarantia + ' AS QTDPEN, ';

    strSQL := strSQL + fSQLPendenteGarantia + ' AS QTDPEN_GAR, ';

    If rdbEntFut.Checked Then
      strSQL := strSQL + ' ' + fGetSQLSomaCamposEntregaFutura() + ' AS ENTFUT, '
    Else
      strSQL := strSQL + ' 0 AS ENTFUT, ';

    If (rdbQtdVen.Checked) Then
    Begin

      If rdbCalcVendaPorDia.Checked Then
      Begin
        strSQL := strSQL + fSQLQtdVen('', True) + ' AS QTDVEN ';
      End
      Else
      Begin
        strSQL := strSQL + fSQLQtdVen;
        strSQL := strSQL + fSQLQtdVen('', True) + ' AS QTDVEN ';
      End;

    End
    Else
      strSQL := strSQL + ' 0 AS QTDVEN ';

    if fCfgSis('EPVSAM', varBoolean) then
    begin
      strSQL := strSQL + '  , SUM(IFNULL((SELECT ';
      strSQL := strSQL + '    SUM(FDO_QTDITE - FDO_QTDBAI) ';
      strSQL := strSQL + '  FROM ';
      strSQL := strSQL + '    FATDOR F ';
      strSQL := strSQL + '    JOIN FATGOR ON FATGOR.AUTOINCREM = FDO_SEQGER  ';
      strSQL := strSQL + '    INNER JOIN EXTGOR E ON FATGOR.AUTOINCREM = E.FGO_SEQFGO ';
      strSQL := strSQL + '  WHERE ';
      strSQL := strSQL + '    FDO_CODITE = G.ITE_CODITE AND ';
      strSQL := strSQL + '    FDO_CODEMP = G.ITE_CODEMP AND ';
      strSQL := strSQL + '    FDO_ESPDOC = "PD" AND ';
      strSQL := strSQL + '    IFNULL(E.FGO_LOC_PD, "N") <> "S" AND ';
      strSQL := strSQL + '    FDO_JAFATU = 0), 0)) AS PEDVEN ';
    end
    else
      strSQL := strSQL + '  , 0 AS PEDVEN ';

    if (rdgGirEst.ItemIndex > 0) then
    begin
      if(chkMesAtu.Checked) then
        strSQL := strSQL + '  , IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(0)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(0))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) as mesAtual ';

      strSQL := strSQL + ' ,  IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(1)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(1))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) as mes01 ';
      strSQL := strSQL + ' ,  IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(2)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(2))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) as mes02 ';
      strSQL := strSQL + ' ,  IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(3)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(3))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) as mes03 ';

      if rdgGirEst.ItemIndex > 1 then
      begin
        strSQL := strSQL + ' ,  IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(4)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(4))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) as mes04 ';
        strSQL := strSQL + ' ,  IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(5)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(5))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) as mes05 ';
        strSQL := strSQL + ' ,  IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(6)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(6))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) as mes06 ';
      end;

      if rdgGirEst.ItemIndex > 2 then
      begin
        strSQL := strSQL + ' ,  IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(7)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(7))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) as mes07 ';
        strSQL := strSQL + ' ,  IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(8)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(8))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) as mes08 ';
        strSQL := strSQL + ' ,  IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(9)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(9))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) as mes09 ';
        strSQL := strSQL + ' ,  IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(10) + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(10)) + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) as mes10 ';
        strSQL := strSQL + ' ,  IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(11) + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(11)) + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) as mes11 ';
        strSQL := strSQL + ' ,  IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(12) + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(12)) + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) as mes12 ';
      end;
    end;

    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE I ';
    strSQL := strSQL + '  LEFT JOIN CADMAR M  ON M.MAR_CODMAR =  I.ITE_CODMAR ';
    strSQL := strSQL + '        JOIN ITEGER G  ON I.ITE_CODITE =  G.ITE_CODITE ';
    strSQL := strSQL + '  LEFT JOIN CFGSIS PONEXP ON PONEXP.SIS_CODEMP = G.ITE_CODEMP AND PONEXP.SIS_CODCFG = "CFG_PONEXP" ';

    strSQL := strSQL + '  LEFT  JOIN ITEGER CD ON CD.ITE_CODITE = G.ITE_CODITE AND CD.ITE_CODEMP = ' + QuotedStr(edtEmpCD.Text);

    strSQL := strSQL + '  INNER JOIN CADFOR   ON FOR_CODFOR = I.ITE_CODFOR ';
    strSQL := strSQL + '  INNER JOIN CADUNI   ON UNI_CODUNI = I.ITE_CODUNI ';

    strSQL := strSQL + '  LEFT  JOIN ITEGUN   ON I.ITE_CODUNI = ITEGUN.GUN_CODUNI ';
    strSQL := strSQL + '  LEFT  JOIN CADGUN   ON ITEGUN.GUN_CODIGO = CADGUN.GUN_CODIGO ';
    strSQL := strSQL + '  INNER JOIN CADEMP   ON EMP_CODEMP = G.ITE_CODEMP ';
    strSQL := strSQL + '  LEFT JOIN CFGSIS TIPGIR ON TIPGIR.SIS_CODEMP = G.ITE_CODEMP AND TIPGIR.SIS_CODCFG = "CFG_TIPGIR" ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + 'TRUE ';

    if FCFGTRITTE then
      strSQL := strSQL + ' AND IFNULL(I.ITE_TRITTE, "N") = "S" ';

    //  Filtra Nivel de giro
    If edtGirEst.Text <> 'T' Then
      strSQL := strSQL + ' AND IF( TIPGIR.SIS_VALCFG = "S", G.ITE_NIVGIR, I.ITE_NVLGIR ) = ' + QuotedStr(edtGirEst.Text);

    If rdgAnaEmp.ItemIndex = 0 Then
    Begin
      strSQL := strSQL + ' AND G.ITE_SALDOS + ' +  fSQLSalEntFut + ' - ' + fSQLSalResAbaixoMin(chkSalResEmp) + ' + ' +
                                                   fRetSQLConsiderarSaldoTransf + fRetOperadorEstMin ;
      if chkPontoExposicao.Checked Then
        strSQL := strSQL + ' IF(PONEXP.SIS_VALCFG = "S" AND  IFNULL(G.ITE_PONEXP, 0) > IFNULL(G.ITE_ESTMIN, 0), IFNULL(G.ITE_PONEXP, 0), IFNULL(G.ITE_ESTMIN, 0)) '
      Else
        strSQL := strSQL + ' IFNULL(G.ITE_ESTMIN,0 ) ';

      Case rdgSaldo.ItemIndex Of
        0: strSQL := strSQL + '  AND G.ITE_SALDOS + ' + fSQLSalEntFut + ' - ' + fSQLSalResAbaixoMin(chkSalResEmp) + ' + ' + fRetSQLConsiderarSaldoTransf + ' > 0 ';
        1: strSQL := strSQL + '  AND G.ITE_SALDOS + ' + fSQLSalEntFut + ' - ' + fSQLSalResAbaixoMin(chkSalResEmp) + ' + ' + fRetSQLConsiderarSaldoTransf + ' = 0 ';
        3: strSQL := strSQL + '  AND G.ITE_SALDOS + ' + fSQLSalEntFut + ' - ' + fSQLSalResAbaixoMin(chkSalResEmp) + ' + ' + fRetSQLConsiderarSaldoTransf + ' < 0 ';
      End;

      Case rdgSaldoCD.ItemIndex Of
        0: Begin
              strSQL := strSQL + '  AND IFNULL(CD.ITE_SALDOS ,0) > 0 ';
           End;
        1: Begin
              strSQL := strSQL + '  AND IFNULL(CD.ITE_SALDOS ,0) = 0 ';
           End;
        3: Begin
              strSQL := strSQL + '  AND IFNULL(CD.ITE_SALDOS ,0) < 0 ';
           End;
      End;
    End;

    Case rdgCompraCentr.ItemIndex Of
      0: strSQL := strSQL + '  AND (G.ITE_CPRCEN = "S" AND G.ITE_EMPCEN =  ' + QuotedStr(edtEmpCD.Text) + ')';
      1: strSQL := strSQL + '  AND ((G.ITE_CPRCEN = "N") OR (G.ITE_EMPCEN <> ' + QuotedStr(edtEmpCD.Text) + '))';
    End;

    If blnExiPct Then
    Begin
      strSQL := strSQL + fGetSqlTipoAbstecimento;
      strSQL := strSQL + fGetSQLPoliticaEst;
    End;

    If Not fEmptyStr(mskLinhaGrupo.Text) Then
      strSQL := strSQL + fStrLocateLinGru(mskLinhaGrupo, arrLinGru, 'ITE_CODGRU','CODGRU');

    strSQL := strSQL + fStrLocate(edtFornecedor, arrLinFor, 'I.ITE_CODFOR', 'CODFOR');
    strSQL := strSQL + fStrLocate(edtMarca,      arrLinMar, 'I.ITE_CODMAR', 'CODMAR');
    strSQL := strSQL + fStrLocate(edtUnidade,    arrLinUni, 'I.ITE_CODUNI', 'CODUNI');
    strSQL := strSQL + fStrLocate(edtCodEmpresa, arrLinEmp, 'G.ITE_CODEMP', 'CODEMP');
    strSQL := strSQL + fStrLocate(edtCodDep,     arrCodDep, 'I.ITE_CODDEP', 'CODDEP');
    strSQL := strSQL + fStrLocate(edtPrdGru,     arrPrdGru, 'I.ITE_PRDGRU', 'PRDGRU');

    if blnSitPro Then
    Begin
      Case intSitPro Of
        1: strSQL := strSQL + fStrLocate(edtCodSitPro, arrSitPro, 'I.ITE_SITPRO', 'SITPRO');
        2: strSQL := strSQL + fStrLocate(edtCodSitPro, arrSitPro, 'G.ITE_SITPRO', 'SITPRO');
      End;

      Case intSitPro Of
        1: strSQL := strSQL + fStrLocate(edtCodSitProExc, arrSitProExc, 'I.ITE_SITPRO', 'SITPROEXC', False, True);
        2: strSQL := strSQL + fStrLocate(edtCodSitProExc, arrSitProExc, 'G.ITE_SITPRO', 'SITPROEXC', False, True);
      End;
    End;

    {*****************************}
    { FILTRO "GRUPO DE COMPRAS"  *}
    {14/08/2012****************CI*}
    strSql := strSQL + fStrLocate(edtGruCmp,     arrGruCmp, 'I.ITE_GRUCMP', 'GRUCMP');

    If chkLocFisCD.Checked Then
    Begin

      Case rdgLocFis.ItemIndex Of
        0: Begin
             strSQL := strSQL + ' AND IFNULL(CD.ITE_LOCFIS, "") <> "" ';
           End;
        1: Begin
             strSQL := strSQL + ' AND IFNULL(CD.ITE_LOCFIS, "") = "" ';
           End;
      End;

    End Else
    Begin

      Case rdgLocFis.ItemIndex Of
        0: strSQL := strSQL + ' AND IFNULL(G.ITE_LOCFIS, "") <> "" ';
        1: strSQL := strSQL + ' AND IFNULL(G.ITE_LOCFIS, "") =  "" ';
      End;

    End;

    If chkDescMinMaxCD.Checked Then
    Begin
      strSQL := strSQL + '  AND IFNULL(CD.ITE_ESTMIN, 0) > 0 ';
      strSQL := strSQL + '  AND CD.ITE_ESTMAX > 0 ';
    End;

    If not fEmptyStr(fRemoverTodosCaracteresPercentual(edtDescri.Text)) Then
      strSQL := strSQL  + ' AND I.ITE_DESITE LIKE :DESITE ';

    If not fEmptyStr(fRemoverTodosCaracteresPercentual(edtAcoObj.Text)) Then
      strSQL := strSQL  + ' AND I.ITE_ACOOBJ LIKE :ACOOBJ ';

    If Not fEmptyStr(fRemoverTodosCaracteresPercentual(edtRefere.Text)) Then
      strSQL := strSQL + '  AND I.ITE_REFERE LIKE :REFERE ';

    //*****************************************//
    // FILTRAR STATUS (ATIVO, INATIVO , TODOS)*//
    // DO PRODUTO                             *//
    //***************************************RL//
    If rdgStatus.ItemIndex = 0 Then
      strSQL := strSQL + ' AND I.ITE_ITEATI = ' + QuotedStr('S') + ' '
    Else If rdgStatus.ItemIndex = 1 Then
      strSQL := strSQL + ' AND I.ITE_ITEATI = ' + QuotedStr('N') + ' ';

    Case rdgImpLis.ItemIndex Of
      0: strSQL := strSQL + ' AND G.ITE_IMPLIS  = "S" ';
      1: strSQL := strSQL + ' AND G.ITE_IMPLIS  = "N" ';
    End;

    {******************************************************}
    {* FILTRO PARA EXCLUIR INATIVOS DE COMPRA DA LISTAGEM *}
    {************************************************ GB **}
    If not chkInativoCompra.Checked Then
      strSQL := strSQL + '  AND I.ITE_ATICOM = "S" ';

    if Not fEmptyStr(fSQLNotasEntrada) then
      strSQL := strSQL + ' AND I.ITE_CODITE IN ( ' + fSQLNotasEntrada + ' )';

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + ' G.ITE_CODITE ';

    If rdgNecCompra.ItemIndex = 0 Then
    Begin
      strSQL := strSQL + 'HAVING ';
      If chkPontoExposicao.Checked Then
        strSQL := strSQL + '   IF(PONEXP = "S", IF(NECCOM < ITE_PONEXP, ITE_PONEXP, NECCOM), NECCOM)> 0 '
      Else
        strSQL := strSQL + '  NECCOM > 0 ';
    End;

    If rdgAnaEmp.ItemIndex = 1 Then
    Begin

      If Pos('HAVING', strSQL) <= 0 Then
        strSQL := strSQL + '  HAVING '
      Else
        strSQL := strSQL + '  AND ';

      strSQL := strSQL + '  SALDOS ' + fRetOperadorEstMin + ' ESTMIN  ';

      Case rdgSaldo.ItemIndex Of
        0: strSQL := strSQL + ' AND SALDOS > 0 ';
        1: strSQL := strSQL + ' AND SALDOS = 0 ';
        3: strSQL := strSQL + ' AND SALDOS < 0 ';
      End;

      Case rdgSaldoCD.ItemIndex Of
        0: Begin
              strSQL := strSQL + '  AND REALCD > 0 ';
           End;
        1: Begin
              strSQL := strSQL + '  AND REALCD = 0 ';
           End;
        3: Begin
              strSQL := strSQL + '  AND REALCD < 0 ';
           End;
      End;

    End;

    If chkSalRes.Checked Then
    Begin
       Case rdgSaldoCD.ItemIndex Of
        0: strSQL := strSQL + ifthen(Pos('HAVING', strSQL) <= 0, ' HAVING ', ' AND ') + ' SALDCD > 0 ';
        1: strSQL := strSQL + ifthen(Pos('HAVING', strSQL) <= 0, ' HAVING ', ' AND ') + ' SALDCD = 0 ';
        3: strSQL := strSQL + ifthen(Pos('HAVING', strSQL) <= 0, ' HAVING ', ' AND ') + ' SALDCD < 0 ';
      End;
    End;


    strSQL := strSQL + 'ORDER BY ';

    Case rdgOrdem.ItemIndex of
      1: strSQL := strSQL + '  I.ITE_CODGRU, ';
      2: strSQL := strSQL + '  I.ITE_CODFOR, ';
      3: strSQL := strSQL + '  MAR_DESMAR, ';
      4: strSQL := strSQL + '  LOCFIS, ';
      5: strSQL := strSQL + '  UNIGRU, LOCFIS, LOCSUP, ';
      6: strSQL := strSQL + '  SIGUNI, ';
    end;

    strSQL := strSQL + '  I.ITE_DESITE ';

    With cdsItens, qryQuery Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (rdbCalcVendaPorDia.Checked) And (rdbQtdVen.Checked) Then
      Begin
        ParamByName('DTAINIDIAS').AsDate := IncDay(Date, - StrToIntDef(edtDias.Text, 0));
        ParamByName('DTAFINDIAS').AsDate := Date;

        ParamByName('CLAVEN').AsString := VS_strClaVen;
        ParamByName('CLADEV').AsString := VS_strClaDev;
      End;

      pSetaParam(mskLinhaGrupo.Text, arrLinGru, strLinGru, 'CODGRU', qryQuery);

      pSetaParam(edtFornecedor.Text, arrLinFor, strLinFor, 'CODFOR', qryQuery);
      pSetaParam(edtMarca.Text,      arrLinMar, strLinMar, 'CODMAR', qryQuery);
      pSetaParam(edtCodEmpresa.Text, arrLinEmp, strLinEmp, 'CODEMP', qryQuery);
      pSetaParam(edtUnidade.Text,    arrLinUni, strLinUni, 'CODUNI', qryQuery);
      pSetaParam(edtCodDep.Text,     arrCodDep, strCodDep, 'CODDEP', qryQuery);
      pSetaParam(edtPrdGru.Text,     arrPrdGru, strPrdGru, 'PRDGRU', qryQuery);

      if blnSitPro Then
      begin
          pSetaParam(edtCodSitPro.Text, arrSitPro, strSitPro, 'SITPRO', qryQuery);
          pSetaParam(edtCodSitProExc.Text, arrSitProExc, strSitProExc, 'SITPROEXC', qryQuery);
      end;

      {*****************************************}
      { PARAMETRO DO FILTRO "GRUPO DE COMPRAS" *}
      {14/08/2012****************************CI*}
      pSetaParam(edtGruCmp.Text,     arrGruCmp, strGruCmp, 'GRUCMP', qryQuery);

      If Not fEmptyStr(fRemoverTodosCaracteresPercentual(edtRefere.Text)) Then
        ParamByName('REFERE').AsString := edtRefere.Text + '%';

      If Not fEmptyStr(fRemoverTodosCaracteresPercentual(edtDescri.Text)) Then
        ParamByName('DESITE').AsString := edtDescri.Text + '%';

      If Not fEmptyStr(fRemoverTodosCaracteresPercentual(edtAcoObj.Text)) Then
        ParamByName('ACOOBJ').AsString := edtAcoObj.Text + '%';

      If Not fEmptyStr(edtDocumento.Text) Then
      Begin
        ParamByName('NUMDOC').AsString    := edtDocumento.Text;
        ParamByName('ESPDOC').AsString    := edtEspecie.Text;

        If Not fEmptyStr(edtCodEmpresaNE.Text) then
          ParamByName('CODEMP_NE').AsString := edtCodEmpresaNE.Text;

        If Not fEmptyStr(edtSerie.Text) Then
          ParamByName('SERDOC').AsString := edtSerie.Text;

        If Not fEmptyStr(edtForNot.Text) Then
          ParamByName('FORNOT').AsString := edtForNot.Text;

      End;

      If (Not fEmptyDate(mskDtaEntIni.Text)) And (Not fEmptyDate(mskDtaEntFin.Text)) Then
      Begin
        ParamByName('CLACOM').AsString := VS_strClaCom;
        ParamByName('DTAINI').AsDate := StrToDate(mskDtaEntIni.Text);
        ParamByName('DTAFIN').AsDate := StrToDate(mskDtaEntFin.Text);
      End;

      Try
        fAbreClient(True, 'TfrmRelEstItemsAbaixoMin.btnImprimirClick');

        If chkSalRes.Checked Or rdbDiaEst.Checked Then  // VAI REPROCESSAR
          pCalculaSaldoReservadoCD(cdsItens);
        pAjustaPontoExposicao(cdsItens);
        pAjustaAbastecimento(cdsItens, False, True);
        If chkImpSimilares.Checked Then
          pPopulaCdsSimilares();

      Except
        On E: Exception do
        Begin
          ShowMessage(E.Message);
        End;
      End;

    End;

    If Not cdsItens.IsEmpty Then
    Begin

      If blnOriRcx Then
      Begin
        //nao deve gerar o relatorio
      End

      Else If edtDestino.Text = 'E' Then
        pGeraExcel(cdsItens)
      Else

      Begin

        Try

          frxRel := frxRelatorioJ;

          frxRelatorio.DataSet := cdsItens;

          // Início - Deixando do jeito original

          TfrxMemoView(frxRel.FindObject('rllLabelSaldCdAlq')).Memo.Clear;
          TfrxMemoView(frxRel.FindObject('rllLabelSaldCdAlq')).Memo.Add('SALDO');

          TfrxMemoView(frxRel.FindObject('rllSalLimCD')).Memo.Clear;
          TfrxMemoView(frxRel.FindObject('rllSalLimCD')).Memo.Add('CD');

          TfrxMemoView(frxRel.FindObject('rllCodEmp')).Memo.Clear;
          TfrxMemoView(frxRel.FindObject('rllCodEmp')).Memo.Add('ATUAL');

          TfrxGroupHeader(frxRel.FindObject('GroupHeader2')).Visible := False;

          TfrxMemoView(frxRel.FindObject('rllDias')).Memo.Clear;
          TfrxMemoView(frxRel.FindObject('rllDias')).Memo.Add('ÚLT. 90 DIAS');

          TfrxMemoView(frxRel.FindObject('rllReferencia')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbRefere')).Visible := True;

          TfrxMemoView(frxRel.FindObject('rllPedVen')).Visible := False;
          TfrxMemoView(frxRel.FindObject('rdbPedVen')).Visible := False;

          TfrxMemoView(frxRel.FindObject('rllSal')).Memo.Clear;
          TfrxMemoView(frxRel.FindObject('rllSal')).Memo.Add('SALDO');

          TfrxMemoView(frxRel.FindObject('rllSalCont')).Memo.Clear;
          TfrxMemoView(frxRel.FindObject('rllSalCont')).Memo.Add('DISP. CD');

          TfrxMemoView(frxRel.FindObject('rllSalREALCD')).Memo.Clear;
          TfrxMemoView(frxRel.FindObject('rllSalREALCD')).Memo.Add('[frxRelatorio."REALCD"]');

          TfrxMemoView(frxRel.FindObject('rllDescricao')).Top    := 21.01577;
          TfrxMemoView(frxRel.FindObject('rllDescricao')).Left   := 15.11812;
          TfrxMemoView(frxRel.FindObject('rllNivelGiro')).Top    := 21.1496063;
          TfrxMemoView(frxRel.FindObject('rllNivelGiro')).Left   := 504.94488189;
          TfrxMemoView(frxRel.FindObject('rllGiro')).Top         := 11.2519563;
          TfrxMemoView(frxRel.FindObject('rllGiro')).Left        := 504.92122689;
          TfrxMemoView(frxRel.FindObject('rdbDescri')).Top       := 11.11812;
          TfrxMemoView(frxRel.FindObject('rdbDescri')).Left      := 15.094465;
          TfrxMemoView(frxRel.FindObject('rdbDescri')).Width     := 300.09462;

          TfrxMemoView(frxRel.FindObject('rllPdCmpGar')).Visible := True;
          TfrxMemoView(frxRel.FindObject('rdbPdCmpGar')).Visible := True;

          TfrxMemoView(frxRel.FindObject('rdbUltFor')).Top       := 11.2519563;
          TfrxMemoView(frxRel.FindObject('rllSaldEstMinCD')).Top := 11.2519563;
          TfrxMemoView(frxRel.FindObject('rdbPdCmpGar')).Top     := 11.2519563;
          TfrxMemoView(frxRel.FindObject('rdbLocSup')).Top       := 11.2519563;
          TfrxMemoView(frxRel.FindObject('rdbPedVen')).Top       := 11.2519563;

          TfrxGroupHeader(frxRel.FindObject('GroupHeader1')).Condition := 'frxRelatorio."CODFOR"';

          TfrxMasterData(frxRel.FindObject('rlbDetalhe')).Height := 26.45669291;
          TfrxHeader(frxRel.FindObject('rlbTitulo')).Height      := 36.66141732;

          // Fim - Deixando do jeito original

          If rdbPerEam.Checked Then
            pSetaTipoSaldoCDFast(salPrecentual, FloatToStr(100 - StrToFloat(edtPerEam.Text)))

          Else If rdbDiaEst.Checked Then
            pSetaTipoSaldoCDFast(salDias, '')

          Else
            pSetaTipoSaldoCDFast(salNaoLimitado, '');

          frxSimilares.DataSet := cdsSimilares;

          frxRel.Script.Variables['NOMREL'] := 'RELATORIO DE PRODUTOS COM SALDO ABAIXO DO MINIMO';

          TfrxMemoView(frxRel.FindObject('rllLimSal')).Visible := chkLimSal.Checked;

          TfrxMemoView(frxRel.FindObject('rllEstMinCD')).Visible       := chkConsidEstMinCD.Checked;
          TfrxMemoView(frxRel.FindObject('rllSaldEstMinCD')).Visible  := chkConsidEstMinCD.Checked;

          If Not fEmptyStr(edtFornecedor.Text) Then
            frxRel.Script.Variables['ORDEM'] := 'FORNECEDOR: ' + edtFornecedor.Text + ' - ' + edtDesFornecedor.Text
          Else
            frxRel.Script.Variables['ORDEM'] := 'FORNECEDOR: TODOS';

          If Not fEmptyStr(mskLinhaGrupo.Text) Then
            frxRel.Script.Variables['GRUPO'] := 'LINHA/GRUPO: ' + mskLinhaGrupo.Text + ' - ' + edtDesGrupo.Text
          Else
            frxRel.Script.Variables['GRUPO'] := 'LINHA/GRUPO INICIAL: TODOS';

          If Not fEmptyStr(edtUnidade.Text) Then
            frxRel.Script.Variables['UNIDADE'] := 'UNIDADE: ' + edtUnidade.Text
          Else
            frxRel.Script.Variables['UNIDADE'] := 'UNIDADE: TODAS';

          If Not fEmptyStr(edtMarca.Text) Then
            frxRel.Script.Variables['MARCAORD'] := 'MARCA: ' + edtMarca.Text + ' - ' + edtDesMarca.Text
          Else
            frxRel.Script.Variables['MARCAORD'] := 'MARCA: TODAS';

          frxRel.Script.Variables['GRUCMP'] := fStrTitulo(edtGruCmp.Text, edtDesGruCmp, arrGruCmp, strGruCmp, 'GRUPO DE COMPRAS');

          If Not fEmptyStr(fRemoverTodosCaracteresPercentual(edtRefere.Text)) Then
            frxRel.Script.Variables['REFERENCIA'] := 'REFERENCIA: ' + edtRefere.Text
          Else
            frxRel.Script.Variables['REFERENCIA'] := 'REFERENCIA: TODAS';

          If Not fEmptyStr(fRemoverTodosCaracteresPercentual(edtDescri.Text)) Then
            frxRel.Script.Variables['DESCRI'] := 'DESCRIÇÃO: ' + edtDescri.Text
          Else
            frxRel.Script.Variables['DESCRI'] := 'DESCRIÇÃO: TODAS';

          If Not fEmptyStr(edtCodEmpresa.Text) Then
          Begin
            If edtCodEmpresa.Text <> '000' Then
            Begin
              TfrxMemoView(frxRel.FindObject('rllCodEmp')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllCodEmp')).Memo.Add(edtCodEmpresa.Text);
            End;
            frxRel.Script.Variables['EMPRESA'] := fStrTitulo(edtCodEmpresa.Text,  edtDesEmpresa,    arrLinEmp, strLinEmp, 'EMPRESA');
          End
          Else
            frxRel.Script.Variables['EMPRESA'] := 'EMPRESA: TODAS';

          frxRel.Script.Variables['LOCFIL'] := 'LOCALIZACAO FISICA: ' + UpperCase(fTiraCaracEspeciais(rdgLocFis.Items[rdgLocFis.ItemIndex]));

          If Not fEmptyStr(edtCodSitPro.Text) Then
            frxRel.Script.Variables['SITPRO'] := fStrTitulo(edtCodSitPro.Text,  edtDesSitPro,  arrSitPro, strSitPro, 'SITUACAO PRODUTO')
          Else
            frxRel.Script.Variables['SITPRO'] := 'SITUACAO PRODUTO: TODAS';

          If Not fEmptyStr(edtCodSitProExc.Text) Then
            frxRel.Script.Variables['SITPROEXC'] := fStrTitulo(edtCodSitProExc.Text,  edtDesSitProExc,  arrSitProExc, strSitProExc, 'SITUACAO PRODUTO A EXCLUIR')
          Else
            frxRel.Script.Variables['SITPROEXC'] := 'SITUACAO PRODUTO: TODAS';

          Case rdgOrdem.ItemIndex of
            0,
            4,
            6,
            3:
            begin
              TfrxGroupHeader(frxRel.FindObject('GroupHeader1')).Visible := False;
            end;
            1: //Linha Grupo
            begin
              TfrxMemoView(frxRel.FindObject('rllFornecedor')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllFornecedor')).Memo.Add('Linha: [frxRelatorio."LINDES"]');
              TfrxGroupHeader(frxRel.FindObject('GroupHeader1')).Condition := 'frxRelatorio."LINHA"';
              TfrxGroupHeader(frxRel.FindObject('GroupHeader1')).Visible := True;
              TfrxGroupHeader(frxRel.FindObject('GroupHeader2')).Visible := True;
              // rlbGrupo3.PageBreaking := pbNone;
            end;
            5: //Grupo de Unidade + Loc. Físicao + Loc.Super Est.
            begin
              TfrxMemoView(frxRel.FindObject('rllFornecedor')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllFornecedor')).Memo.Add('Grupo: [frxRelatorio."UNIGRU"]');
              TfrxGroupHeader(frxRel.FindObject('GroupHeader1')).Condition := 'frxRelatorio."UNIGRU"';
              TfrxGroupHeader(frxRel.FindObject('GroupHeader1')).Visible := True;
              // rlbGrupo3.PageBreaking := pbBeforePrint;
            end;
            2: // Fornecedor
            Begin
              TfrxMemoView(frxRel.FindObject('rllFornecedor')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllFornecedor')).Memo.Add('Fornecedor: [frxRelatorio."FORNEC"]');
              TfrxGroupHeader(frxRel.FindObject('GroupHeader1')).Condition := 'frxRelatorio."CODFOR"';
              TfrxGroupHeader(frxRel.FindObject('GroupHeader1')).Visible := True;
              // rlbGrupo3.PageBreaking := pbNone;
            End;
          End;

          TfrxMemoView(frxRel.FindObject('rllNivelGiro')).Visible := chkNivelGiro.Checked;
          TfrxMemoView(frxRel.FindObject('rllGiro')).Visible := chkNivelGiro.Checked;

          TfrxMemoView(frxRel.FindObject('rllUltFor')).Visible := chkUltCompra.Checked;
          TfrxMemoView(frxRel.FindObject('rdbULTFOR')).Visible := chkUltCompra.Checked;

          If rdbCompras.Checked Then
          Begin
            TfrxMemoView(frxRel.FindObject('rllCompras')).Visible := True;
            TfrxMemoView(frxRel.FindObject('rdbRisco')).Visible   := True;

            TfrxMemoView(frxRel.FindObject('rllCodFab')).Visible  := False;
            TfrxMemoView(frxRel.FindObject('rdbFabrica')).Visible := False;

            TfrxMemoView(frxRel.FindObject('rllLocFis')).Visible  := False;
            TfrxMemoView(frxRel.FindObject('rdbLocFis')).Visible  := False;

            TfrxMemoView(frxRel.FindObject('rllLocSup')).Visible  := False;
            TfrxMemoView(frxRel.FindObject('rdbLocSup')).Visible  := False;

            TfrxMemoView(frxRel.FindObject('rllQtdVen')).Visible  := False;
            TfrxMemoView(frxRel.FindObject('rllDias')).Visible    := False;
            TfrxMemoView(frxRel.FindObject('rdbQtdVen')).Visible  := False;

            TfrxMemoView(frxRel.FindObject('rllEntFut1')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rllEntFut2')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rdbEntFut')).Visible  := False;

          End

          Else If self.rdbCodFab.Checked Then
          Begin
            TfrxMemoView(frxRel.FindObject('rllCompras')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rdbRisco')).Visible   := False;

            TfrxMemoView(frxRel.FindObject('rllCodFab')).Visible  := True;
            TfrxMemoView(frxRel.FindObject('rdbFabrica')).Visible := True;

            TfrxMemoView(frxRel.FindObject('rllLocFis')).Visible  := False;
            TfrxMemoView(frxRel.FindObject('rdbLocFis')).Visible  := False;

            TfrxMemoView(frxRel.FindObject('rllLocSup')).Visible  := False;
            TfrxMemoView(frxRel.FindObject('rdbLocSup')).Visible  := False;

            TfrxMemoView(frxRel.FindObject('rllQtdVen')).Visible  := False;
            TfrxMemoView(frxRel.FindObject('rllDias')).Visible    := False;
            TfrxMemoView(frxRel.FindObject('rdbQtdVen')).Visible  := False;

            TfrxMemoView(frxRel.FindObject('rllEntFut1')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rllEntFut2')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rdbEntFut')).Visible  := False;

          End

          Else If self.rdbLocFis.Checked Then
          Begin
            TfrxMemoView(frxRel.FindObject('rllCompras')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rdbRisco')).Visible   := False;

            TfrxMemoView(frxRel.FindObject('rllCodFab')).Visible  := False;
            TfrxMemoView(frxRel.FindObject('rdbFabrica')).Visible := False;

            TfrxMemoView(frxRel.FindObject('rllLocFis')).Visible  := True;
            TfrxMemoView(frxRel.FindObject('rdbLocFis')).Visible  := True;

            TfrxMemoView(frxRel.FindObject('rllLocSup')).Visible  := True;
            TfrxMemoView(frxRel.FindObject('rdbLocSup')).Visible  := True;

            TfrxMemoView(frxRel.FindObject('rllQtdVen')).Visible  := False;
            TfrxMemoView(frxRel.FindObject('rllDias')).Visible    := False;
            TfrxMemoView(frxRel.FindObject('rdbQtdVen')).Visible  := False;

            TfrxMemoView(frxRel.FindObject('rllEntFut1')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rllEntFut2')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rdbEntFut')).Visible  := False;

          End

          Else If self.rdbQtdVen.Checked Then
          Begin
            TfrxMemoView(frxRel.FindObject('rllCompras')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rdbRisco')).Visible   := False;

            TfrxMemoView(frxRel.FindObject('rllCodFab')).Visible  := False;
            TfrxMemoView(frxRel.FindObject('rdbFabrica')).Visible := False;

            TfrxMemoView(frxRel.FindObject('rllLocFis')).Visible  := False;
            TfrxMemoView(frxRel.FindObject('rdbLocFis')).Visible  := False;

            TfrxMemoView(frxRel.FindObject('rllLocSup')).Visible  := False;
            TfrxMemoView(frxRel.FindObject('rdbLocSup')).Visible  := False;

            TfrxMemoView(frxRel.FindObject('rllQtdVen')).Visible  := True;
            TfrxMemoView(frxRel.FindObject('rllDias')).Visible    := True;

            If rdbCalcVendaPorDia.Checked Then
            Begin
              If strToIntDef(EdtDias.Text, 0) = 1 Then
              Begin
                TfrxMemoView(frxRel.FindObject('rllDias')).Memo.Clear;
                TfrxMemoView(frxRel.FindObject('rllDias')).Memo.Add('ÚLT. ' + EdtDias.Text + ' DIA');
              End
              Else
              Begin
                TfrxMemoView(frxRel.FindObject('rllDias')).Memo.Clear;
                TfrxMemoView(frxRel.FindObject('rllDias')).Memo.Add('ÚLT. ' + EdtDias.Text + ' DIAS');
              End;
            End
            Else
            Begin
              TfrxMemoView(frxRel.FindObject('rllDias')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllDias')).Memo.Add(cmbMeses.Text + ' MESES');
            End;

            TfrxMemoView(frxRel.FindObject('rdbQtdVen')).Visible := True;

            TfrxMemoView(frxRel.FindObject('rllEntFut1')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rllEntFut2')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rdbEntFut')).Visible  := False;

          End
          Else If self.rdbEntFut.Checked Then
          Begin
            TfrxMemoView(frxRel.FindObject('rllCompras')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rdbRisco')).Visible   := False;

            TfrxMemoView(frxRel.FindObject('rllCodFab')).Visible  := False;
            TfrxMemoView(frxRel.FindObject('rdbFabrica')).Visible := False;

            TfrxMemoView(frxRel.FindObject('rllLocFis')).Visible  := False;
            TfrxMemoView(frxRel.FindObject('rdbLocFis')).Visible  := False;

            TfrxMemoView(frxRel.FindObject('rllLocSup')).Visible  := False;
            TfrxMemoView(frxRel.FindObject('rdbLocSup')).Visible  := False;

            TfrxMemoView(frxRel.FindObject('rllQtdVen')).Visible  := False;
            TfrxMemoView(frxRel.FindObject('rllDias')).Visible    := False;
            TfrxMemoView(frxRel.FindObject('rdbQtdVen')).Visible  := False;

            TfrxMemoView(frxRel.FindObject('rllEntFut1')).Visible := True;
            TfrxMemoView(frxRel.FindObject('rllEntFut2')).Visible := True;
            TfrxMemoView(frxRel.FindObject('rdbEntFut')).Visible  := True;

          End;

          If Not chkImpRef.Checked Then
          Begin
            TfrxMemoView(frxRel.FindObject('rllReferencia')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rdbRefere')).Visible     := False;
          End;

          If chkDesIte.Checked Then
          Begin

            If chkConsidEstMinCD.Checked Then
            Begin
              TfrxMemoView(frxRel.FindObject('rllSal')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllSal')).Memo.Add('ESTOQUE');
              TfrxMemoView(frxRel.FindObject('rllSalCont')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllSalCont')).Memo.Add('MIN. CD');
              TfrxMemoView(frxRel.FindObject('rllSalREALCD')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllSalREALCD')).Memo.Add('[frxRelatorio."CD_ESTMIN"]');
            End
            Else If rdbMaxSeg.Checked Then
            Begin
              TfrxMemoView(frxRel.FindObject('rllSal')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllSal')).Memo.Add('ESTOQUE');
              TfrxMemoView(frxRel.FindObject('rllSalCont')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllSalCont')).Memo.Add('MAX. CD');
              TfrxMemoView(frxRel.FindObject('rllSalREALCD')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllSalREALCD')).Memo.Add('[frxRelatorio."CD_ESTMAX"]');
            End;

            TfrxMemoView(frxRel.FindObject('rllDescricao')).Top := 9.55906;
            TfrxMemoView(frxRel.FindObject('rllDescricao')).Left := 44.598485;

            TfrxMemoView(frxRel.FindObject('rllNivelGiro')).Top := 9.55906;
            TfrxMemoView(frxRel.FindObject('rllNivelGiro')).Left := 321.26005;

            TfrxMemoView(frxRel.FindObject('rllGiro')).Top := 2.44093999999999;
            TfrxMemoView(frxRel.FindObject('rllGiro')).Left := 321.236395;

            TfrxMemoView(frxRel.FindObject('rdbDescri')).Top := 2.44093999999999;
            TfrxMemoView(frxRel.FindObject('rdbDescri')).Left := 44.57483;

            If (blnUsaInd Or (chkAdicOrdProduAberta.Checked)) Then
              TfrxMemoView(frxRel.FindObject('rdbDescri')).Width := 128.50397118
            Else
              TfrxMemoView(frxRel.FindObject('rdbDescri')).Width := 196.913385826772;

            TfrxMemoView(frxRel.FindObject('rllPdCmpGar')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rdbPdCmpGar')).Visible := False;

            TfrxMemoView(frxRel.FindObject('rdbUltFor')).Top       := 2.44093999999999;
            TfrxMemoView(frxRel.FindObject('rllSaldEstMinCD')).Top := 2.44093999999999;
            TfrxMemoView(frxRel.FindObject('rdbPdCmpGar')).Top     := 2.44093999999999;
            TfrxMemoView(frxRel.FindObject('rdbLocSup')).Top       := 2.44093999999999;
            TfrxMemoView(frxRel.FindObject('rdbPedVen')).Top       := 2.44093999999999;

            TfrxMasterData(frxRel.FindObject('rlbDetalhe')).Height := 16.251968503937;
            TfrxHeader(frxRel.FindObject('rlbTitulo')).Height := 23.4330708661417;

          End;

          if fCfgSis('EPVSAM', varBoolean) then
          begin
            TfrxMemoView(frxRel.FindObject('rllLocSup')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rdbLocSup')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rllPedVen')).Visible := True;
            TfrxMemoView(frxRel.FindObject('rdbPedVen')).Visible := True;
          end;

          frxRel.Script.Variables['SALRES'] := 'DESCONTAR SALDO RESERVADO DO SALDO DA EMPRESA? ' + IfThen(chkSalResEmp.Checked, 'S', 'N');
          frxRel.Script.Variables['SALENTFUT'] := 'CONSIDERAR ENTREGA FUTURA PENDENTE? ' + fGetMotEntFut;

          If rdgOrdem.ItemIndex = 1 Then
          Begin
            TfrxMemoView(frxRel.FindObject('rdbDesIteGru')).Visible := False;
            TfrxMemoView(frxRel.FindObject('rllGrupoTit')).Visible := False;
          End
          Else
          Begin
            TfrxMemoView(frxRel.FindObject('rdbDesIteGru')).Visible := chkLinGru.Checked;
            TfrxMemoView(frxRel.FindObject('rllGrupoTit')).Visible := chkLinGru.Checked;
          end;

          TfrxMemoView(frxRel.FindObject('rllReferencia')).Visible := chkImpRef.Checked;
          TfrxMemoView(frxRel.FindObject('rdbRefere')).Visible := chkImpRef.Checked;

          TfrxMemoView(frxRel.FindObject('rdbOrdPro')).Visible := (blnUsaInd Or (chkAdicOrdProduAberta.Checked));
          TfrxMemoView(frxRel.FindObject('rllOrdPro')).Visible := (blnUsaInd Or (chkAdicOrdProduAberta.Checked));

          TfrxMemoView(frxRel.FindObject('rllZebra')).Highlight.Color := StrToIntDef(fCfgSis('CORZEB'), clSilver);

          if rdgGirEst.ItemIndex > 0  then
          begin
            TfrxMasterData(frxRel.FindObject('rlbDetalhe')).Height := TfrxMasterData(frxRel.FindObject('rlbDetalhe')).Height + TfrxMemoView(frxRel.FindObject('rdbMes01')).Height;
            TfrxHeader(frxRel.FindObject('rlbTitulo')).Height := TfrxHeader(frxRel.FindObject('rlbTitulo')).Height + TfrxMemoView(frxRel.FindObject('rllMes01')).Height;

            fltGiroVendaDetalheTop := TfrxMasterData(frxRel.FindObject('rlbDetalhe')).Height - TfrxMemoView(frxRel.FindObject('rdbMes01')).Height;
            fltGiroVendaTituloTop := TfrxHeader(frxRel.FindObject('rlbTitulo')).Height - TfrxMemoView(frxRel.FindObject('rllMes01')).Height;

            if chkMesAtu.Checked then
            begin
              TfrxMemoView(frxRel.FindObject('rdbMesAtual')).Top := fltGiroVendaDetalheTop;

              TfrxMemoView(frxRel.FindObject('rllMesAtual')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllMesAtual')).Memo.Add(fRetornaMes(0) + '/' + fRetornaAno(0));
              TfrxMemoView(frxRel.FindObject('rllMesAtual')).Top := fltGiroVendaTituloTop;
            end;

            TfrxMemoView(frxRel.FindObject('rdbMes01')).Top := fltGiroVendaDetalheTop;
            TfrxMemoView(frxRel.FindObject('rdbMes02')).Top := fltGiroVendaDetalheTop;
            TfrxMemoView(frxRel.FindObject('rdbMes03')).Top := fltGiroVendaDetalheTop;

            TfrxMemoView(frxRel.FindObject('rllMes01')).Top := fltGiroVendaTituloTop;
            TfrxMemoView(frxRel.FindObject('rllMes01')).Memo.Clear;
            TfrxMemoView(frxRel.FindObject('rllMes01')).Memo.Add(fRetornaMes(1) + '/' + fRetornaAno(1));

            TfrxMemoView(frxRel.FindObject('rllMes02')).Memo.Clear;
            TfrxMemoView(frxRel.FindObject('rllMes02')).Memo.Add(fRetornaMes(2) + '/' + fRetornaAno(2));
            TfrxMemoView(frxRel.FindObject('rllMes02')).Top := fltGiroVendaTituloTop;

            TfrxMemoView(frxRel.FindObject('rllMes03')).Memo.Clear;
            TfrxMemoView(frxRel.FindObject('rllMes03')).Memo.Add(fRetornaMes(3) + '/' + fRetornaAno(3));
            TfrxMemoView(frxRel.FindObject('rllMes03')).Top := fltGiroVendaTituloTop;

            if rdgGirEst.ItemIndex > 1  then
            begin
              TfrxMemoView(frxRel.FindObject('rdbMes04')).Top := fltGiroVendaDetalheTop;
              TfrxMemoView(frxRel.FindObject('rdbMes05')).Top := fltGiroVendaDetalheTop;
              TfrxMemoView(frxRel.FindObject('rdbMes06')).Top := fltGiroVendaDetalheTop;

              TfrxMemoView(frxRel.FindObject('rllMes04')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllMes04')).Memo.Add(fRetornaMes(4) + '/' + fRetornaAno(4));
              TfrxMemoView(frxRel.FindObject('rllMes04')).Top := fltGiroVendaTituloTop;

              TfrxMemoView(frxRel.FindObject('rllMes05')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllMes05')).Memo.Add(fRetornaMes(5) + '/' + fRetornaAno(5));
              TfrxMemoView(frxRel.FindObject('rllMes05')).Top := fltGiroVendaTituloTop;

              TfrxMemoView(frxRel.FindObject('rllMes06')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllMes06')).Memo.Add(fRetornaMes(6) + '/' + fRetornaAno(6));
              TfrxMemoView(frxRel.FindObject('rllMes06')).Top := fltGiroVendaTituloTop;
            end;

            if rdgGirEst.ItemIndex > 2  then
            begin
              TfrxMemoView(frxRel.FindObject('rdbMes07')).Top := fltGiroVendaDetalheTop;
              TfrxMemoView(frxRel.FindObject('rdbMes08')).Top := fltGiroVendaDetalheTop;
              TfrxMemoView(frxRel.FindObject('rdbMes09')).Top := fltGiroVendaDetalheTop;
              TfrxMemoView(frxRel.FindObject('rdbMes10')).Top := fltGiroVendaDetalheTop;
              TfrxMemoView(frxRel.FindObject('rdbMes11')).Top := fltGiroVendaDetalheTop;
              TfrxMemoView(frxRel.FindObject('rdbMes12')).Top := fltGiroVendaDetalheTop;

              TfrxMemoView(frxRel.FindObject('rllMes07')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllMes07')).Memo.Add(fRetornaMes(7) + '/' + fRetornaAno(7));
              TfrxMemoView(frxRel.FindObject('rllMes07')).Top := fltGiroVendaTituloTop;

              TfrxMemoView(frxRel.FindObject('rllMes08')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllMes08')).Memo.Add(fRetornaMes(8) + '/' + fRetornaAno(8));
              TfrxMemoView(frxRel.FindObject('rllMes08')).Top := fltGiroVendaTituloTop;

              TfrxMemoView(frxRel.FindObject('rllMes09')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllMes09')).Memo.Add(fRetornaMes(9) + '/' + fRetornaAno(9));
              TfrxMemoView(frxRel.FindObject('rllMes09')).Top := fltGiroVendaTituloTop;

              TfrxMemoView(frxRel.FindObject('rllMes10')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllMes10')).Memo.Add(fRetornaMes(10) + '/' + fRetornaAno(10));
              TfrxMemoView(frxRel.FindObject('rllMes10')).Top := fltGiroVendaTituloTop;

              TfrxMemoView(frxRel.FindObject('rllMes11')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllMes11')).Memo.Add(fRetornaMes(11) + '/' + fRetornaAno(11));
              TfrxMemoView(frxRel.FindObject('rllMes11')).Top := fltGiroVendaTituloTop;

              TfrxMemoView(frxRel.FindObject('rllMes12')).Memo.Clear;
              TfrxMemoView(frxRel.FindObject('rllMes12')).Memo.Add(fRetornaMes(12) + '/' + fRetornaAno(12));
              TfrxMemoView(frxRel.FindObject('rllMes12')).Top := fltGiroVendaTituloTop;
            end;
          end;

          TfrxMemoView(frxRel.FindObject('rdbMesAtual')).Visible := (chkMesAtu.Checked) and (rdgGirEst.ItemIndex > 0);
          TfrxMemoView(frxRel.FindObject('rdbMes01')).Visible := rdgGirEst.ItemIndex > 0;
          TfrxMemoView(frxRel.FindObject('rdbMes02')).Visible := rdgGirEst.ItemIndex > 0;
          TfrxMemoView(frxRel.FindObject('rdbMes03')).Visible := rdgGirEst.ItemIndex > 0;
          TfrxMemoView(frxRel.FindObject('rdbMes04')).Visible := rdgGirEst.ItemIndex > 1;
          TfrxMemoView(frxRel.FindObject('rdbMes05')).Visible := rdgGirEst.ItemIndex > 1;
          TfrxMemoView(frxRel.FindObject('rdbMes06')).Visible := rdgGirEst.ItemIndex > 1;
          TfrxMemoView(frxRel.FindObject('rdbMes07')).Visible := rdgGirEst.ItemIndex > 2;
          TfrxMemoView(frxRel.FindObject('rdbMes08')).Visible := rdgGirEst.ItemIndex > 2;
          TfrxMemoView(frxRel.FindObject('rdbMes09')).Visible := rdgGirEst.ItemIndex > 2;
          TfrxMemoView(frxRel.FindObject('rdbMes10')).Visible := rdgGirEst.ItemIndex > 2;
          TfrxMemoView(frxRel.FindObject('rdbMes11')).Visible := rdgGirEst.ItemIndex > 2;
          TfrxMemoView(frxRel.FindObject('rdbMes12')).Visible := rdgGirEst.ItemIndex > 2;

          TfrxMemoView(frxRel.FindObject('rllMesAtual')).Visible := (chkMesAtu.Checked) and (rdgGirEst.ItemIndex > 0);
          TfrxMemoView(frxRel.FindObject('rllMes01')).Visible := rdgGirEst.ItemIndex > 0;
          TfrxMemoView(frxRel.FindObject('rllMes02')).Visible := rdgGirEst.ItemIndex > 0;
          TfrxMemoView(frxRel.FindObject('rllMes03')).Visible := rdgGirEst.ItemIndex > 0;
          TfrxMemoView(frxRel.FindObject('rllMes04')).Visible := rdgGirEst.ItemIndex > 1;
          TfrxMemoView(frxRel.FindObject('rllMes05')).Visible := rdgGirEst.ItemIndex > 1;
          TfrxMemoView(frxRel.FindObject('rllMes06')).Visible := rdgGirEst.ItemIndex > 1;
          TfrxMemoView(frxRel.FindObject('rllMes07')).Visible := rdgGirEst.ItemIndex > 2;
          TfrxMemoView(frxRel.FindObject('rllMes08')).Visible := rdgGirEst.ItemIndex > 2;
          TfrxMemoView(frxRel.FindObject('rllMes09')).Visible := rdgGirEst.ItemIndex > 2;
          TfrxMemoView(frxRel.FindObject('rllMes10')).Visible := rdgGirEst.ItemIndex > 2;
          TfrxMemoView(frxRel.FindObject('rllMes11')).Visible := rdgGirEst.ItemIndex > 2;
          TfrxMemoView(frxRel.FindObject('rllMes12')).Visible := rdgGirEst.ItemIndex > 2;

          If edtDestino.Text = 'V' Then
            pPreviewReport(Self.Name, Self.Caption, frxRel)
          Else If frxRel.PrepareReport Then
          Begin
            frxRel.PrintOptions.Printer := strNomImp;
            frxRel.PrintOptions.ShowDialog := strNomImp.IsEmpty;
            pPrintReport(Self.Name, Self.Caption, strNomImp, frxRel);
          End;

        Except
          On E: Exception Do
          Begin
            pMensagensErro(E.Message, '['+Self.Name+' -> (Ocorreu um erro durante a Impressao)]');
          End;
        End;

      End;

      {*************************}
      {* GERANDO OS ORÇAMENTOS *}
      {**********************LU*}
    End
    Else
      pTabelaVazia;

  End;

  btnImprimir.Enabled := True;
  pnlInfo.Caption     := '';
  cdsSimilares.EmptyDataSet;

end;

procedure TfrmRelEstItemsAbaixoMin.chkCDNaoPodeAbastecerClick(Sender: TObject);
begin
  inherited;
  If chkCDNaoPodeAbastecer.Checked And chkLimSal.Checked Then
    chkLimSal.Checked := False;

    chkConsidEstMinCD.Visible := not chkConsidEstMinCD.Visible;

  If chkConsidEstMinCD.Visible = False Then
  Begin
    chkConsidestMinCD.Checked := False;
  End;

  objGeraOR.blnApenasSaldoCDMenorSaldoEmp := chkCDNaoPodeAbastecer.Checked;
end;

procedure TfrmRelEstItemsAbaixoMin.chkConsidEstMinCDClick(Sender: TObject);
begin
  inherited;

  //rdbMaxSeg.Checked := not chkConsidEstMinCD.Checked;
  if rdbMaxSeg.Checked then
    rdbSemEstSeg.Checked := True;
end;

procedure TfrmRelEstItemsAbaixoMin.chkDesIteClick(Sender: TObject);
begin
  inherited;
  If chkDesIte.Checked Then
  Begin
    chkImpRef.Checked := False;
    chkImpRef.Enabled := False;
    chkLinGru.Checked := False;
    chkLinGru.Enabled := False;
    chkNivelGiro.Enabled := False;
    chkNivelGiro.Checked := False;
    chkUltCompra.Enabled := False;
    chkUltCompra.Checked := False;
  End
  Else
  Begin
    chkImpRef.Enabled := True;
    chkLinGru.Enabled := True;
    chkNivelGiro.Enabled := True;
    chkUltCompra.Enabled := True;
  End;
end;

procedure TfrmRelEstItemsAbaixoMin.edtUnidadeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If fPesqUnidade(Self, edtUnidade, nil, nil, nil, Key, arrLinUni, False) Then
  Begin
    If fValidaCampos(edtUnidade, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmRelEstItemsAbaixoMin.edtUnidadeExit(Sender: TObject);
begin
  inherited;

  pEdtCodSelectExit(edtUnidade, nil, arrLinUni, fRetNomUnidade, Nil, 'da Unidade');
end;

procedure TfrmRelEstItemsAbaixoMin.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharForm Then
    Close;
end;

procedure TfrmRelEstItemsAbaixoMin.edtCodEmpresaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresa, edtDesEmpresa, Nil, Key, arrLinEmp, False, True) Then
  Begin
    fValidaCampos(edtCodEmpresa, False);
    Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstItemsAbaixoMin.edtCodDepExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodDep, edtDesCodDep, arrCodDep, fRetNomDep, nil, 'do Departamento');
end;

procedure TfrmRelEstItemsAbaixoMin.edtCodDepKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqDepartamento(Self, edtCodDep, edtDesCodDep, nil, key, arrCodDep, False) Then
  Begin
    if fValidaCampos(edtCodDep, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRelEstItemsAbaixoMin.edtCodEmpresaExit(Sender: TObject);
begin
  pEdtCodSelectExit(edtCodEmpresa, edtDesEmpresa, arrLinEmp, Nil, fRetNomeEmpresaSelec, 'da Empresa');

  If fEmptyStr(edtCodEmpresa.Text) or (Length(arrLinEmp) > 1) Then
    rdgAnaEmp.Enabled := True
  Else
  Begin
    rdgAnaEmp.Enabled   := False;
    rdgAnaEmp.ItemIndex := 0;
  End;
end;

procedure TfrmRelEstItemsAbaixoMin.FormShow(Sender: TObject);
begin
  inherited;
  lblEmpresa.Visible    := True;
  edtCodEmpresa.Visible := True;
  edtDesEmpresa.Visible := True;

  edtCodEmpresa.Text := VS_strCodEmp;
  edtCodEmpresaExit(Sender);

  shpMultSel.Visible := True;

  btnAltOrc.Visible := fCfgSis('ORTERE', varBoolean);
  btnGerOrc.Visible := btnAltOrc.Visible;


  rdbCompras.Checked := True;
  edtDias.Enabled    := False;
  cmbMeses.Enabled    := False;

  //Localização Fisica, grupo de Unidade
  //rdgOrdem.Buttons[4].Enabled := rdbLocFis.Checked;
  //rdgOrdem.Buttons[5].Enabled := rdbLocFis.Checked;

  objGeraOR := TRelGeraOR.Create(Self, fGravaFatGor, fGravaFatDor, pAbreQueryItens);

  {***************************************************}
  {* SE O RELATÓRIO FOI ORIGINADO DO RESUMO DE CAIXA *}
  {************************************************RV*}
  If blnOriRcx Then
  Begin
    mskLinhaGrupoExit(Sender);
    edtFornecedorExit(Sender);
    edtMarcaExit(Sender);
    edtRefere.Clear;
    edtUnidade.Clear;
    rdgSaldo.ItemIndex       := 2;
    rdgSaldoCD.ItemIndex     := 0;
    rdgStatus.ItemIndex      := 0;
    rdgImpLis.ItemIndex      := 2;
    rdbCompras.Checked       := True;
    rdgEstMin.ItemIndex      := 0;
    rdgCompraCentr.ItemIndex := 0;
    rdgNecCompra.ItemIndex   := 0;
    btnImprimirClick(Sender);
    blnFecharForm            := True;
  End;

  edtDocumento.TamCampo  := fTamNumDoc();
  edtDocumento.MaxLength := edtDocumento.TamCampo;

  blnCarregandoDados := True;
  Try
    objFrmRest.fCarregaDados('', Self, 'frmRelEstItemsAbaixoMin', strLoginUsuarioLogado, True, True);
    objFrmRest.fAtualizaDados;
    edtCodEmpresaExit(Sender);

    // NAO ESTÁ SALVANDO OS MESES
    chkInfMes.Checked := False;

    pTratarComponentesVendaPorDia;

    pHabilitaLimeteSaldo(chkLimSal.Checked);
  Finally
    blnCarregandoDados := False;
  End;


  if blnPontoExposicao then
  begin
    pUtilizarPontoExposicao(chkPontoExposicao.Checked);
  end;

end;

function TfrmRelEstItemsAbaixoMin.fTemCfgComPontoDeExposicaoAtivo: Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) QTD FROM CFGSIS');
    qryConsulta.SQL.Add(' WHERE SIS_CODCFG = "CFG_PONEXP"');
    qryConsulta.SQL.Add('   AND SIS_VALCFG = "S"');

    qryConsulta.Open;

    Result := qryConsulta.FieldByName('QTD').AsInteger > 0;
  Finally
    FreeAndNil(qryConsulta);
  End;
End;

procedure TfrmRelEstItemsAbaixoMin.FormCreate(Sender: TObject);
var
  frxRel: TfrxReport;
begin
  inherited;
  FCFGTRITTE:= fCfgSis('TRITTE', varBoolean);
  blnCarregandoDados := False;
  blnPontoExposicao :=  fTemCfgComPontoDeExposicaoAtivo;

  if blnPontoExposicao then
    rdgEstMin.Caption := 'Somente itens com Saldo - obs. o ponto de exposição anula este filtro'
  else
  Begin
    grpEntFut.Top := grpEntFut.Top - chkPontoExposicao.Height;
    rdgCalMinMax.Top := rdgCalMinMax.Top - chkPontoExposicao.Height;
    rdgTipoMultiplo.Top := rdgTipoMultiplo.Top - chkPontoExposicao.Height;
    rdgAnaEmp.Top := rdgAnaEmp.Top - chkPontoExposicao.Height;
    chkPontoExposicao.Visible := False;
  End;

  cdsItens       := TZClient.Create(Self);
  pCriaCdsSimilares;
  pCriaCdsMinimoSeguranca;

  fGravaFatGor   := Nil;
  fGravaFatDor   := Nil;
  blnFecharForm  := False;
  edtPerEam.Text := fCfgSis('PEREAM', varString);

  blnUsaInd      := (fCfgSis('UTIIND', varBoolean));
  chkAdicOrdProduAberta.Visible := blnUsaInd;
  objFrmRest := TSalvaInterface.Create(Self);
  pRetListaMesAno(lstBasGir.Items);
  lstBasGir.Checked[0] := True;
  cdsMeses :=  TMesesGiro.Create(Nil, 12);

  intSitPro := fCfgSis('SITEMP', varInteger); // 1 - Igual pra todas as empresas 2 - Um para cada empresa
  blnSitPro := fCfgSis('SITPRO', varBoolean); // Utiliza cadastro de situacao de procutos S ou N

  if not blnSitPro Then
  Begin
    lblSitPro.Enabled := False;
    edtCodSitPro.Enabled := False;
    edtDesSitPro.Enabled := False;
  End;

  frxRel := frxRelatorioJ;

  frxRel.AddFunction('function fFiltraSimilar(strCodIte: String): Boolean;');
  frxRel.AddFunction('function fArredondaMais(fltVlrIni: Double; blnArrDez: Boolean): Double;');

  blnExiPct := fCfgSis('EXIPCT', varBoolean);
  pnlParamCompras.Visible := blnExiPct;
end;

function TfrmRelEstItemsAbaixoMin.fFiltraSimilar(strCodIte: String): Boolean;
begin
  cdsSimilares.Filtered := False;
  cdsSimilares.Filter := 'ITE_PROPRI = ' + QuotedStr(strCodIte);
  cdsSimilares.Filtered := True;

  Result := not cdsSimilares.IsEmpty;
end;

procedure TfrmRelEstItemsAbaixoMin.btnGerOrcClick(Sender: TObject);
begin
  If Not fVerificaCampos Then
    Exit;

  If Not fChecaMeses Then
    Exit;

  If Not TfrmMsgValidacaoGeraOrdOp.fMsgValidacaoGeracaoOrcPed(veValida, edtCodEmpresa.Text, fEmpSelecionadaIgualEmpLogada) Then
    Exit;
  If fEmptyStr(edtEmpCD.Text) Then
  begin
    fMensagem('','Você deve informar a empresa C.D.',['&O K']);
    Exit;
  end;

  blnEntFut := (chkFaltaProduto.Checked) or (chkPrevisaoEntrega.Checked) or (chkAguardandoCliente.Checked) or (fCfgSis('BEFTRG', VarBoolean));

  objGeraOR.blnQtdVen := rdbQtdVen.Checked;

  If rdbPerEam.Checked Then
    objGeraOr.strAliquotaSaldoCD := FloatToStr(100 - StrToFloat(edtPerEam.Text))
  Else
    objGeraOr.strAliquotaSaldoCD := '';

  If rdbPerEam.Checked Then
    objGeraOr.tipSaldoCD := salPrecentualGrid

  Else If rdbDiaEst.Checked Then
    objGeraOr.tipSaldoCD := salDiasGrid

  Else
    objGeraOr.tipSaldoCD := salNaoLimitadoGrid;

  If fContaSelecaoBaseGiro = 0 Then
  Begin
    fMensagem('','Você deve selecionar um mês de Base para Cálculo da venda!',['&O K']);
    pSetFocus(lstBasGir);

    If lstBasGir.Items.Count > 0 Then
      lstBasGir.Selected[0] := True;
    Exit;
  End;


  If blnOriRcx Then
    objGeraOr.tpTipoMultiplo := tpmlCompra
  Else
  begin
    Case rdgTipoMultiplo.ItemIndex Of
      0: objGeraOr.tpTipoMultiplo := tpmlCompra;
      1: objGeraOr.tpTipoMultiplo := tpmlIndefinido;
      2: objGeraOr.tpTipoMultiplo := tpmlVenda;
    End;
  End;

  objGeraOr.blnLimSal := chkLimSal.Checked;
  objGeraOr.strEmp_TE := edtEmpCD.Text;
  objGeraOr.blnQuebraPorGrupoUnidade := rdgOrdem.ItemIndex = 5;
  //Se for origem de caixa
  If Not (rdbCalcVendaPorDia.Checked) Then
    setMesesVenda;
  If rdbQtdVen.Checked Then
     objGeraOr.objListaMesesVenda := objListaMesesVenda;
  objGeraOr.strQuebra := '';
  case rdgOrdem.ItemIndex of
    1: objGeraOr.strQuebra := 'CODGRU';
    2: objGeraOr.strQuebra := 'CODFOR';
  End;

  objGeraOr.tipOrdem := TTipoOrdem(rdgOrdem.ItemIndex);

  objGeraOR.strEmpresas := fArrCodigosToLista(edtCodEmpresa.Text, arrLinEmp, False);

  objGeraOr.blnCalcVendaPorDia := rdbCalcVendaPorDia.Checked;
  objGeraOR.strEmpCd_ext := edtEmpCD.Text;
  objGeraOr.strEmpCdDes_ext := edtEmpCDDes.Text;
  objGeraOR.pGeraOrcamento('', edtCodEmpresa, arrLinEmp, blnOriRcx, opcAbaixoMinimo, prgProgresso, Nil, rdgGirEst.ItemIndex <> 0, IIF(rdgGirEst.ItemIndex = 0, 0, IIF(rdgGirEst.ItemIndex = 1, 3, IIF(rdgGirEst.ItemIndex = 2, 6, 12))));
end;

procedure TfrmRelEstItemsAbaixoMin.btnHlpImpClick(Sender: TObject);
var msg: TStringList;
begin
  inherited;
  msg := TstringList.Create();
  Try
    msg.Add('  Este parâmetro serve para elevar a necessidade de abastecimento.');
    msg.Add('  Se a necessidade de abastecimento for menor que o ponto de exposição');
    msg.Add('sempre elevará a quantidade, até suprir o ponto de exposição.');
    msg.Add('--------------------------------');
    msg.Add('  Exemplo 1:');
    msg.Add('   Calcular pelo estoque....: Mínimo');
    msg.Add('   Estoque Atual do Destino.: 10');
    msg.Add('   Estoque Mínimo...........:  5');
    msg.Add('   Estoque Máximo...........: 20');
    msg.Add('   Ponto de Exposição.......: 15');
    msg.Add('   Necessidade sugerida.....:  5');
    msg.Add('--------------------------------');
    msg.Add('  Exemplo 2:');
    msg.Add('   Calcular pelo estoque....: Máximo');
    msg.Add('   Estoque Atual do Destino.: 10');
    msg.Add('   Estoque Mínimo...........:  5');
    msg.Add('   Estoque Máximo...........: 20');
    msg.Add('   Ponto de Exposição.......: 15');
    msg.Add('   Necessidade sugerida.....: 10');
    msg.Add('--------------------------------');
    msg.Add('  Exemplo 3:');
    msg.Add('   Calcular pelo estoque....: Mínimo');
    msg.Add('   Estoque Atual do Destino.: 4');
    msg.Add('   Estoque Mínimo...........: 5');
    msg.Add('   Estoque Máximo...........: 20');
    msg.Add('   Ponto de Exposição.......: 18');
    msg.Add('   Necessidade sugerida.....: 14');

    TfrmLog.pShowLog('Orientação', msg, 600, 400, ssNone);
  Finally
    FreeAndNil(msg);
  End;
























end;

procedure TfrmRelEstItemsAbaixoMin.btnHlpMediaVendasClick(Sender: TObject);
begin
  inherited;

  pMensagemOk('A quantidade para garantir os dias de estoque será calculada' + #13#10 +
              'pelas informações fornecidas no grupo "Calcular Vendas Por"' + #13#10 +
              'localizado no canto superior direito dessa tela.');
end;

procedure TfrmRelEstItemsAbaixoMin.btnAltOrcClick(Sender: TObject);
  var
    i: integer;
    strEmp: string;
begin
  inherited;

  If edtCodEmpresa.Text = '000' Then
  Begin
    For i := 0 To Length(arrLinEmp) - 1 Do
       strEmp := strEmp + '_' + arrLinEmp[i].strCodigo;
  End
  Else if Not fEmptyStr(edtCodEmpresa.Text) Then
    strEmp := edtCodEmpresa.Text;

  objGeraOR.pAlteraOrcamento(edtEmpCD.Text,
                             chkSalRes.Checked,
                             strEmp,
                             (chkSalResEmp.Checked),
                             fGetMotEntFut);
end;

procedure TfrmRelEstItemsAbaixoMin.pGeraExcel(qryDados: TZClient);
  Var
    objGeraExcel: TGeraExcel;
begin
  Try
    objGeraExcel := TGeraExcel.Create(qryDados, nil);

    With objGeraExcel Do
    Begin

      strNomRel := 'RELATORIO DE PRODUTOS COM SALDO ABAIXO DO MINIMO';

      {********************************}
      {* FILTROS                      *}
      {*****************************CI*}

      AddFiltro(fStrTitulo(mskLinhaGrupo.Text,  edtDesGrupo,      arrLinGru, strLinGru, 'LINHA/GRUPO'));
      AddFiltro(fStrTitulo(edtFornecedor.Text,  edtDesFornecedor, arrLinFor, strLinFor, 'FORNECEDOR'));
      AddFiltro(fStrTitulo(edtMarca.Text,       edtDesMarca,      arrLinMar, strLinMar, 'MARCA'));
      AddFiltro(fStrTitulo(edtGruCmp.Text,      edtDesGruCmp,     arrGruCmp, strGruCmp, 'GRUPO DE COMPRAS'));
      AddFiltro('REFERENCIA: ' + edtRefere.Text);
      AddFiltro(fStrTitulo(edtUnidade.Text,     nil,              arrLinUni, strLinUni, 'UNIDADE'));
      AddFiltro(fStrTitulo(edtCodEmpresa.Text,  edtDesEmpresa,    arrLinEmp, strLinEmp, 'EMPRESA'));
      AddFiltro ('LOCALIZACAO FISICA: ' + UpperCase(fTiraCaracEspeciais(rdgLocFis.Items[rdgLocFis.ItemIndex])));

      AddFiltro (UpperCase(fTiraCaracEspeciais(rdgSaldo.Caption))       + ': ' + UpperCase(fTiraCaracEspeciais(rdgSaldo.Items[rdgSaldo.ItemIndex])));
      AddFiltro (UpperCase(fTiraCaracEspeciais(rdgSaldoCD.Caption))     + ': ' + UpperCase(fTiraCaracEspeciais(rdgSaldoCD.Items[rdgSaldoCD.ItemIndex])));
      AddFiltro (UpperCase(fTiraCaracEspeciais(rdgStatus.Caption))      + ': ' + UpperCase(fTiraCaracEspeciais(rdgStatus.Items[rdgStatus.ItemIndex])));
      AddFiltro (UpperCase(fTiraCaracEspeciais(rdgImpLis.Caption))      + ': ' + UpperCase(fTiraCaracEspeciais(rdgImpLis.Items[rdgImpLis.ItemIndex])));
      AddFiltro (UpperCase(fTiraCaracEspeciais(rdgEstMin.Caption))      + ': ' + UpperCase(fTiraCaracEspeciais(rdgEstMin.Items[rdgEstMin.ItemIndex])));
      AddFiltro (UpperCase(fTiraCaracEspeciais(rdgCompraCentr.Caption)) + ': ' + UpperCase(fTiraCaracEspeciais(rdgCompraCentr.Items[rdgCompraCentr.ItemIndex])));

      AddFiltro (UpperCase(fTiraCaracEspeciais(rdgNecCompra.Caption))   + ': ' + UpperCase(fTiraCaracEspeciais(rdgNecCompra.Items[rdgNecCompra.ItemIndex])));

      AddFiltro (UpperCase(fTiraCaracEspeciais(rdgCalMinMax.Caption))   + ': ' + UpperCase(fTiraCaracEspeciais(rdgCalMinMax.Items[rdgCalMinMax.ItemIndex])));
      AddFiltro (UpperCase(fTiraCaracEspeciais(chkPedCom.Caption))      + ': ' + IIf(chkPedCom.Checked, 'SIM', 'NÃO'));
      AddFiltro (UpperCase(fTiraCaracEspeciais(chkPedComGar.Caption))      + ': ' + IIf(chkPedComGar.Checked, 'SIM', 'NÃO'));
      AddFiltro (UpperCase(fTiraCaracEspeciais(rdgAnaEmp.Caption))      + ': ' + UpperCase(fTiraCaracEspeciais(rdgAnaEmp.Items[rdgAnaEmp.ItemIndex])));

      If blnExiPct Then
      Begin
        AddFiltro (UpperCase(fTiraCaracEspeciais(rdgTipAbs.Caption))      + ': ' + UpperCase(fTiraCaracEspeciais(fGetDescFiltroTipAba)));
        AddFiltro (UpperCase(fTiraCaracEspeciais(rdgPolEstTipVenda.Caption))      + ': ' + UpperCase(fTiraCaracEspeciais(fGetDescFiltroPoliticaEst)));
      End;

      {********************************}
      {* DADOS DO RELATORIO           *}
      {*****************************CI*}
      AddCampo('CODITE', 'CÓDIGO');
      AddCampo('DESITE', 'DESCRIÇÃO');
      AddCampo('REFERE', 'REFERENCIA');
      AddCampo('SIGUNI', 'UN');
      AddCampo('DESMAR', 'MARCA');
      AddCampo('ESTMIN', 'EST.MIN');
      AddCampo('ESTMAX', 'EST.MAX');
      AddCampo('SALDCD', 'SALDO CD');
      AddCampo('SALDOS', 'SALDO ' + edtCodEmpresa.Text);
      AddCampo('QTDPEN', 'PEDIDO COMPRA');

      AddCampo('DTAULT', 'DATA DE ÚLTIMA COMPRA');
      AddCampo('PREULT', 'PREÇO DE ÚLTIMA COMPRA');

      AddCampo('QTDPEN_GAR', 'PEDIDO COMPRA - GARANTIA');
      AddCampo('NECCOM', 'NECES. COMPRA');

      If chkNivelGiro.Checked Then
        AddCampo('NIVGIR','GIRO');

      If rdbCompras.Checked Then
        AddCampo('COMPRA', 'COMPRAS')
      Else If rdbCodFab.Checked Then
        AddCampo('CODFAB', 'CÓD. FÁBRICA')
      Else If rdbLocFis.Checked Then
      Begin
        AddCampo('LOCFIS', 'LOC.FÍSICA');
        AddCampo('LOCSUP', 'LOC.SUP.EST.');
      End
      Else If (rdbQtdVen.Checked) Then
      Begin
        If rdbCalcVendaPorDia.Checked Then
          AddCampo('QTDVEN', 'QTD.VENDA (' + EdtDias.Text + ' DIAS)')
        Else
          AddCampo('QTDVEN', 'QTD.VENDA (' + cmbMeses.Text + ' Meses)')
      End
      Else If rdbEntFut.Checked  Then
          AddCampo('ENTFUT', 'ENTREGA FUTURA PENDENTE');

      if rdgGirEst.ItemIndex > 0 then
      begin
        if chkMesAtu.Checked then
          AddCampo('MesAtual', fRetornaMes(0) + '/' + fRetornaAno(0));

        AddCampo('Mes01', fRetornaMes(1) + '/' + fRetornaAno(1));
        AddCampo('Mes02', fRetornaMes(2) + '/' + fRetornaAno(2));
        AddCampo('Mes03', fRetornaMes(3) + '/' + fRetornaAno(3));

        if rdgGirEst.ItemIndex > 1 then
        begin
          AddCampo('Mes04', fRetornaMes(4) + '/' + fRetornaAno(4));
          AddCampo('Mes05', fRetornaMes(5) + '/' + fRetornaAno(5));
          AddCampo('Mes06', fRetornaMes(6) + '/' + fRetornaAno(6));

          if rdgGirEst.ItemIndex > 2 then
          begin
            AddCampo('Mes07', fRetornaMes(7) + '/' + fRetornaAno(7));
            AddCampo('Mes08', fRetornaMes(8) + '/' + fRetornaAno(8));
            AddCampo('Mes09', fRetornaMes(9) + '/' + fRetornaAno(9));
            AddCampo('Mes10', fRetornaMes(10) + '/' + fRetornaAno(10));
            AddCampo('Mes11', fRetornaMes(11) + '/' + fRetornaAno(11));
            AddCampo('Mes12', fRetornaMes(12) + '/' + fRetornaAno(12));
          end;
        end;
      end;

      case rdgOrdem.ItemIndex of
        1: // Linha Grupo
          Begin
            AddQuebra('LINDES', 'LINHA: ');
            AddQuebra('GRUDES', 'GRUPO: ');
          End;
        2: AddQuebra('FORNEC', 'FORNECEDOR: ');
        5: AddQuebra('UNIGRU', 'GRUPO UNIDADE: ');
      end;

      If fGerarRelatorio Then
        fMensagem('', 'Arquivo gerado com sucesso!', ['&OK']);
    End;

  Except
    On E: Exception Do
    Begin
      FreeAndNil(objGeraExcel);
      pMensagensErro (E.Message, '[TfrmRelEstItemsAbaixoMin.pGeraExcel]');
    End;

  End;
End;

procedure TfrmRelEstItemsAbaixoMin.pHabilitaOrdemLocFis;
begin
  //rdgOrdem.Buttons[4].Enabled := rdbLocFis.Checked;
  //rdgOrdem.Buttons[5].Enabled := rdbLocFis.Checked;

  edtDias.Enabled             := rdbQtdVen.Checked Or rdbDiaEst.Checked;
  lstBasGir.Enabled           := rdbQtdVen.Checked Or rdbDiaEst.Checked;
  chkInfMes.Enabled           := rdbQtdVen.Checked Or rdbDiaEst.Checked;
  cmbMeses.Enabled            := rdbQtdVen.Checked Or rdbDiaEst.Checked;

  rdbCalcVendaPorDia.Enabled  := rdbQtdVen.Checked Or rdbDiaEst.Checked;
  rdbCalcVendasPorMes.Enabled := rdbQtdVen.Checked Or rdbDiaEst.Checked;
  lblQtdMesDia.Enabled        := rdbQtdVen.Checked Or rdbDiaEst.Checked;
  lblQtdMesDia.Enabled        := rdbQtdVen.Checked Or rdbDiaEst.Checked;
  edtDias.Enabled             := rdbQtdVen.Checked Or rdbDiaEst.Checked;
  chkInfMes.Enabled           := rdbQtdVen.Checked Or rdbDiaEst.Checked;

  // Tratamento necessário por causa dos campos Loc.Fís. e Loc.Fís.Sup
  If rdbLocFis.Checked Then
  Begin
    chkDesIte.Enabled := False;
    chkDesIte.Checked := False;
  End
  Else
    chkDesIte.Enabled := True;
end;

procedure TfrmRelEstItemsAbaixoMin.pMensagemCheckPontoExposicao;
begin
  fMensagem('Atenção!', ' Se opção "Ultilizar ponto de exposição" estiver marcada irá anula este filtro.',['&Ok']);
end;

procedure TfrmRelEstItemsAbaixoMin.pPopulaCdsSimilares;
var qryConsulta: TUniQuery;
  procedure pLocalizaSimilares();
  begin
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT  G.ITE_CODITE,');
    qryConsulta.SQL.Add('        I.ITE_DESITE,');
    qryConsulta.SQL.Add('        I.ITE_REFERE,');
    qryConsulta.SQL.Add('        M.MAR_DESMAR,');
    qryConsulta.SQL.Add('        SUM(G.ITE_SALDOS - ' + fSQLSalResAbaixoMin(chkSalResEmp, False, 'G')+ ') AS SALDOS');
    qryConsulta.SQL.Add('  FROM ITEGER G');
    qryConsulta.SQL.Add(' INNER JOIN CADITE I ON I.ITE_CODITE =  G.ITE_CODITE');
    qryConsulta.SQL.Add('  LEFT JOIN CADMAR M ON I.ITE_CODMAR =  M.MAR_CODMAR');
    qryConsulta.SQL.Add('WHERE G.ITE_CODITE IN (SELECT C2.ITE_CODITE AS ITE_CODSIM FROM CADITE  C2');
    qryConsulta.SQL.Add('                        WHERE C2.ITE_CODSIM = (SELECT C3.ITE_CODSIM');
    qryConsulta.SQL.Add('                                                 FROM CADITE  C3');
    qryConsulta.SQL.Add('                                                 WHERE C3.ITE_CODITE = :CODITE))');
    qryConsulta.SQL.Add('  AND G.ITE_CODITE <> :CODITE');
    case rdgLocFisProdSimilar.ItemIndex of
      0: qryConsulta.SQL.Add(' AND G.ITE_LOCFIS <> "" ');
      1: qryConsulta.SQL.Add(' AND G.ITE_LOCSUP = "" ');
    end;
    qryConsulta.SQL.Add(fStrLocate(edtCodEmpresa, arrLinEmp, 'G.ITE_CODEMP', 'CODEMP'));
    qryConsulta.SQL.Add(' GROUP BY G.ITE_CODITE');
    qryConsulta.SQL.Add(' HAVING SALDOS > 0 ');
    qryConsulta.ParamByName('CODITE').AsString := cdsItens.FieldByName('CODITE').AsString;
    pSetaParam(edtCodEmpresa.Text, arrLinEmp, strLinEmp, 'CODEMP', qryConsulta);
    qryConsulta.Open;
  End;

  function fGetSaldoCD(AStrCodIte: String): Double;
  var
    qryAux: TUniQuery;
  begin
    qryAux := fCriaQuery;
    Try
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT SUM(G.ITE_SALDOS - ' + fSQLSalResAbaixoMin(chkSalResEmp, False, 'G') + ') AS SALDOS ');
      qryAux.SQL.Add('FROM ITEGER G ');
      qryAux.SQL.Add(' INNER JOIN CADITE I ON I.ITE_CODITE =  G.ITE_CODITE');
      qryAux.SQL.Add('WHERE G.ITE_CODITE IN (SELECT C2.ITE_CODITE AS ITE_CODSIM FROM CADITE  C2');
      qryAux.SQL.Add('                        WHERE C2.ITE_CODSIM = (SELECT C3.ITE_CODSIM');
      qryAux.SQL.Add('                                                 FROM CADITE  C3');
      qryAux.SQL.Add('                                                 WHERE C3.ITE_CODITE = :CODITE))');
      qryAux.SQL.Add('  AND G.ITE_CODITE <> :CODITE');
      case rdgLocFisProdSimilar.ItemIndex of
        0: qryAux.SQL.Add(' AND G.ITE_LOCFIS <> "" ');
        1: qryAux.SQL.Add(' AND G.ITE_LOCSUP = "" ');
      end;
      qryAux.SQL.Add(' AND G.ITE_CODEMP = :CODEMP');
      qryAux.SQL.Add(' GROUP BY G.ITE_CODITE');
      qryAux.ParamByName('CODITE').AsString := AStrCodIte;
      qryAux.ParamByName('CODEMP').AsString := edtEmpCD.Text;
      qryAux.Open;
      Result := qryAux.FieldByName('SALDOS').AsFloat;
    Finally
      FreeAndNil(qryAux);
    End;
  end;


begin
  pgbProgresso.Visible  := True;
  pgbProgresso.Position := 0;
  pgbProgresso.Properties.Max      := cdsItens.RecordCount;
  pnlInfo.Caption := 'Calculando similares.';
  Application.ProcessMessages;
  qryConsulta := fCriaQuery;
  Try
    While Not cdsItens.EoF Do
    Begin
      pLocalizaSimilares;
      While Not qryConsulta.Eof Do
      Begin
        cdsSimilares.Insert;
        cdsSimilares.FieldByName('ITE_CODITE').AsString := qryConsulta.FieldByName('ITE_CODITE').AsString;
        cdsSimilares.FieldByName('ITE_DESITE').AsString := qryConsulta.FieldByName('ITE_DESITE').AsString;
        cdsSimilares.FieldByName('MAR_DESMAR').AsString := qryConsulta.FieldByName('MAR_DESMAR').AsString;
        cdsSimilares.FieldByName('ITE_REFERE').AsString := qryConsulta.FieldByName('ITE_REFERE').AsString;
        cdsSimilares.FieldByName('ITE_PROPRI').AsString := cdsItens.FieldByName('CODITE').AsString;
        cdsSimilares.FieldByName('ITE_SALDOS').AsFloat  := qryConsulta.FieldByName('SALDOS').AsFloat;
        cdsSimilares.FieldByName('ITE_SALDCD').AsFloat  := fGetSaldoCD(qryConsulta.FieldByName('ITE_CODITE').AsString);
        cdsSimilares.Post;
        qryConsulta.Next;
      End;

      cdsItens.Next;
      pgbProgresso.Position := pgbProgresso.Position + 1;
      Application.ProcessMessages;
    End;
  Finally
    pgbProgresso.Visible  := False;
    pgbProgresso.Position := 0;
    pnlInfo.Caption := '';
    FreeAndNil(qryConsulta);
  End;
end;

procedure TfrmRelEstItemsAbaixoMin.rdbCalcVendaPorDiaClick(Sender: TObject);
begin
  inherited;
  pTratarComponentesVendaPorDia;

end;

procedure TfrmRelEstItemsAbaixoMin.rdbCalcVendasPorMesClick(Sender: TObject);
begin
  inherited;
  pTratarComponentesVendaPorDia;

end;

procedure TfrmRelEstItemsAbaixoMin.rdbCodFabClick(Sender: TObject);
begin
  pHabilitaOrdemLocFis
end;

procedure TfrmRelEstItemsAbaixoMin.rdbComprasClick(Sender: TObject);
begin
  pHabilitaOrdemLocFis;
end;

procedure TfrmRelEstItemsAbaixoMin.rdbDiaEstClick(Sender: TObject);
begin
  inherited;

  pAjustaOpcaoEstCD;
end;

procedure TfrmRelEstItemsAbaixoMin.rdbLocFisClick(Sender: TObject);
begin
  pHabilitaOrdemLocFis;
end;

procedure TfrmRelEstItemsAbaixoMin.rdbMaxSegClick(Sender: TObject);
begin
  inherited;

  pAjustaOpcaoEstCD;

  if rdbMaxSeg.Checked then
    chkConsidEstMinCD.Checked := False;
end;

procedure TfrmRelEstItemsAbaixoMin.rdbMinSegClick(Sender: TObject);
begin
  inherited;

  pAjustaOpcaoEstCD;
end;

procedure TfrmRelEstItemsAbaixoMin.rdbPerEamClick(Sender: TObject);
begin
  inherited;

  pAjustaOpcaoEstCD;
end;

procedure TfrmRelEstItemsAbaixoMin.pAjustaOpcaoEstCD;
Begin
  edtDiaEst.Enabled := rdbDiaEst.Checked;

  If Not edtDiaEst.Enabled Then
    edtDiaEst.Clear;

  edtPerEam.Enabled := rdbPerEam.Checked;

  If Not edtPerEam.Enabled Then
    edtPerEam.Clear;
end;

procedure TfrmRelEstItemsAbaixoMin.pAjustaPontoExposicao(qryItens: TZClient;
  strField: String);
  var fltPonExpCalc: Double;
      fltSalBas: Double;
begin
  If Not  chkPontoExposicao.Checked Then
    Exit;

  qryItens.First;
  qryItens.Filtered := False;
  qryItens.Filter   := 'PONEXP = ' + QuotedStr('S') +  ' AND ITE_PONEXP > 0 AND ' + strField + ' < ITE_PONEXP';
  qryItens.Filtered := True;


  While not qryItens.Eof Do
  Begin
    qryItens.Edit;

    If rdgCalMinMax.ItemIndex = 1 then
       fltPonExpCalc := IIf(qryItens.FieldByName('ITE_PONEXP').AsFloat > qryItens.FieldByName('ESTMAX').Asfloat ,
                            qryItens.FieldByName('ITE_PONEXP').AsFloat,
                            qryItens.FieldByName('ESTMAX').Asfloat)
    Else
      fltPonExpCalc := qryItens.FieldByName('ITE_PONEXP').AsFloat;


    fltSalBas := qryItens.FieldByName('SALDOS').Asfloat;

    If chkPedCom.Checked Then
      fltSalBas := fltSalBas + qryItens.FieldByName('QTDPEN').AsFloat;

    qryItens.FieldByName(strField).Asfloat := fltPonExpCalc - fltSalBas;
    qryItens.Post;
    qryItens.Next;
  End;
  qryItens.Filtered := False;

end;

procedure TfrmRelEstItemsAbaixoMin.rdbQtdVenClick(Sender: TObject);
begin
  pHabilitaOrdemLocFis;
end;

procedure TfrmRelEstItemsAbaixoMin.rdbSemEstSegClick(Sender: TObject);
begin
  inherited;

  pAjustaOpcaoEstCD;
end;

procedure TfrmRelEstItemsAbaixoMin.rdgEstMinClick(Sender: TObject);
begin
  inherited;
  if blnPontoExposicao and chkPontoExposicao.checked then
    pMensagemCheckPontoExposicao;
end;

procedure TfrmRelEstItemsAbaixoMin.rdgGirEstClick(Sender: TObject);
begin
  inherited;
  chkMesAtu.Enabled := rdgGirEst.ItemIndex <> 0;
end;

procedure TfrmRelEstItemsAbaixoMin.rdgTipoMultiploEnter(Sender: TObject);

begin
   HintControler.ShowHint(Round(((Monitor.Width/2 ) - (Self.Width / 2)) + rdgNecCompra.Left)           ,
                          rdgNecCompra.Top + rdgTipoMultiplo.Top + 50,
     'Considerar abastecimento com múltiplo de:',
     'COMPRA: Apenas para os itens que estão com a configuração: ' + #13#10 +
     '"No Abastecimento das Filiais, abastecer com Múltiplo de Compras" = "SIM"' + #13#10 +
     'VENDA: Apenas itens que estão com o campo Multiplo para Venda preenchido');
end;

procedure TfrmRelEstItemsAbaixoMin.rdgTipoMultiploExit(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

procedure TfrmRelEstItemsAbaixoMin.edtDestinoExit(Sender: TObject);
begin
//  inherited;
end;

procedure TfrmRelEstItemsAbaixoMin.edtDocumentoExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtDocumento.Text) Then
  Begin
    edtSerie.Clear;
    edtCodEmpresaNE.Clear;
    edtDesEmpresaNE.Clear;
    edtForNot.Clear;
    edtDesForNot.Clear;
    edtEspecie.Text         := 'NF';
    lblEspecie.Enabled      := False;
    lblSerie.Enabled        := False;
    lblEmpresaNE.Enabled    := False;
    edtCodEmpresaNE.Enabled := False;
    edtDesEmpresaNE.Enabled := False;
    edtEspecie.Enabled      := False;
    edtSerie.Enabled        := False;
    edtForNot.Enabled       := False;
    mskDtaEntIni.Enabled    := True;
    mskDtaEntFin.Enabled    := True;
  End
  Else
  Begin
    lblEspecie.Enabled      := True;
    lblSerie.Enabled        := True;
    lblEmpresaNE.Enabled    := True;
    edtCodEmpresaNE.Enabled := True;
    edtDesEmpresaNE.Enabled := True;
    edtEspecie.Enabled      := True;
    edtSerie.Enabled        := True;
    edtForNot.Enabled       := True;
    mskDtaEntIni.Clear;
    mskDtaEntFin.Clear;
    mskDtaEntIni.Enabled    := False;
    mskDtaEntFin.Enabled    := False;
    edtCodEmpresaNE.Text    := VS_strCodEmp;
    edtDesEmpresaNE.Text    := fRetNomeEmpresaSelec(edtCodEmpresa.Text);
  End;
end;

procedure TfrmRelEstItemsAbaixoMin.edtEmpCDExit(Sender: TObject);
  var
    arrConsulta: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtEmpCD, edtEmpCDDes, arrConsulta, Nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmRelEstItemsAbaixoMin.edtEmpCDKeyPress(Sender: TObject; var Key: Char);
  var
    arrConsulta: TConsultasArray;
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtEmpCD, edtEmpCDDes, Nil, Key, arrConsulta, False, True) Then
  Begin
    If fEmpSelecionadaIgualEmpLogada Then
       edtEmpCD.Text := '';
    fValidaCampos(edtEmpCD, False);
    Self.SelectNext(ActiveControl, True, True);
  End;

end;


procedure TfrmRelEstItemsAbaixoMin.edtCodEmpresaNEExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodEmpresaNE.Text) Then
    edtDesEmpresaNE.Text := 'TODOS'
  Else
    edtDesEmpresaNE.Text := fRetNomeEmpresaSelec(edtCodEmpresaNE.Text);

  If fEmptyStr(edtDesEmpresaNE.Text) And (Not fEmptyStr(edtCodEmpresaNE.Text)) And (edtCodEmpresaNE.Text <> '000') Then
  Begin
    fMensagem('AVISO','Código da empresa não encontrado.', ['&O K']);
    edtCodEmpresaNE.Clear;
    pSetFocus(edtCodEmpresaNE);
  End;

end;

procedure TfrmRelEstItemsAbaixoMin.edtCodEmpresaNEKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpresaNE, edtDesEmpresaNE, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(edtCodEmpresaNE, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

function TfrmRelEstItemsAbaixoMin.fGetMotEntFut: String;
begin
  If (chkFaltaProduto.Checked) Then
    Result := '"F"';
  If (chkPrevisaoEntrega.Checked) Then
    Result := Result + IfThen(Length(Result) > 0, ', "P"', '"P"');
  If (chkAguardandoCliente.Checked) Then
    Result := Result + IfThen(Length(Result) > 0, ', "A"', '"A"');
end;

(****************************************************************************************)
(*  QUANDO ALTERAR O SELECT ABAIXO ATENTAR PARA O FATO QUE O RELATORIO DE FATURAMENTO   *)
(*  TfrmRelFatListVenRep TAMBEM UTILIZA O MESMO OBJETO TRelGeraOR PARA GERAR ORÇAMENTOS *)
(*************************************************************************************LA*)
Function TfrmRelEstItemsAbaixoMin.fGetSqlItens(strEmpresas: String; intIndex: Integer): String;
  Var
    strUnitar,
    strSQL: String;
    blnUsaQtdPen: Boolean;
Begin

  strUnitar := TRelGeraOR.fSQLUnitarioAlias('CD.', edtEmpCD.Text);

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   IF(IFNULL(I.ITE_MLTCOM, 0) <= 0, 1, I.ITE_MLTCOM) AS MLTCOM, ';
  strSQL := strSQL + '   IF(IFNULL(I.ITE_MLTVEN, 0) <= 0, 1, I.ITE_MLTVEN) AS MLTVEN, ';
  strSQL := strSQL + '   I.AUTOINCREM,  ';
  strSQL := strSQL + '   CAST("D" AS CHAR(1)) AS MARDES,  ';
  strSQL := strSQL + '   CAST("N" AS CHAR(1)) AS EXCLUIR,  ';
  strSQL := strSQL + '   I.ITE_CODITE AS CODITE, ';
  strSQL := strSQL + '   I.ITE_CODSIM AS CODSIM, ';
  strSQL := strSQL + '   IF(TIPGIR.SIS_VALCFG = "S", G.ITE_NIVGIR, I.ITE_NVLGIR) AS NIVGIR,   ';

  strSQL := strSQL + '   I.ITE_CODGRU AS GRUPO, ';
  strSQL := strSQL + ' CAST(CONCAT(LEFT(I.ITE_CODGRU,3), ".000", " - ", ';
  strSQL := strSQL + '       (SELECT GRU_DESGRU FROM CADGRU ';
  strSQL := strSQL + '        WHERE GRU_CODGRU = CONCAT(LEFT(I.ITE_CODGRU,3),"","000"))) AS CHAR(7)) AS LINDES, ';
  strSQL := strSQL + ' CAST(CONCAT(LEFT(I.ITE_CODGRU,3), ".", RIGHT(I.ITE_CODGRU,3), " - ", ';
  strSQL := strSQL + '       (SELECT GRU_DESGRU FROM CADGRU ';
  strSQL := strSQL + '        WHERE GRU_CODGRU = I.ITE_CODGRU)) AS CHAR(7))AS GRUDES, ';
  strSQL := strSQL + '   0.000 AS LITKIL_M, ';
  strSQL := strSQL + '   0.000 AS NECCOM_M, ';
  strSQL := strSQL + '   I.ITE_CODMAR AS CODMAR, ';

  if (rdgGirEst.ItemIndex > 0) then
  begin
    if(chkMesAtu.Checked) then
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(0)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(0))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';

    strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(1)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(1))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
    strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(2)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(2))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
    strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(3)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(3))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';

    if rdgGirEst.ItemIndex > 1 then
    begin
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(4)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(4))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(5)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(5))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(6)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(6))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
    end;

    if rdgGirEst.ItemIndex > 2 then
    begin
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(7)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(7))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(8)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(8))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(9)  + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(9))  + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(10) + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(10)) + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(11) + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(11)) + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
      strSQL := strSQL + '   IFNULL((SELECT SUM(IFNULL(GIR_QSAI' + fRetornaMes(12) + ', 0)) FROM GIRITE WHERE GIR_CODITE = I.ITE_CODITE AND GIR_A_N_O_ = ' + QuotedStr(fRetornaAno(12)) + ' ' + IfThen(not fEmptyStr(edtCodEmpresa.Text), fStrLocate(edtCodEmpresa, arrLinEmp, 'GIR_CODEMP','CODEMP'), 'AND LOCATE(GIR_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0') + '),0) + ';
    end;
  end;
  strSQL := strSQL + '  0 AS GIRITE, ';

  If fUsaRotinaWMS Then
    strSQL := strSQL + '   CAST( (SELECT IFNULL(LOT_NUMLOT,"") FROM CADLOT WHERE LOT_CODITE = G.ITE_CODITE AND LOT_CODEMP = '+ QuotedStr(edtEmpCD.Text) + ' AND LOT_NUMLOT = "A DEFINIR") AS CHAR(30)) AS NUMLOT, '
  Else If fCfgSis('RSMLPV', varBoolean) Then
    strSQL := strSQL + ' IFNULL((SELECT LOT_NUMLOT FROM CADLOT WHERE LOT_CODITE = G.ITE_CODITE AND LOT_CODEMP = '+ QuotedStr(edtEmpCD.Text) + ' AND IFNULL(LOT_ARMOPV,"N") = "S"), IF((SELECT COUNT(*) FROM CADLOT WHERE LOT_CODITE = G.ITE_CODITE AND LOT_CODEMP = '+ QuotedStr(edtEmpCD.Text) + ') > 0, "A DEFINIR", "")) AS NUMLOT, '
  Else
    strSQL := strSQL + '   CAST("" AS CHAR(30)) AS NUMLOT, ';
  strSQL := strSQL + '   G.ITE_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   0.000 AS PESTOT, ';
  strSQL := strSQL + '   0.000 AS PESTIT, ';
  strSQL := strSQL + '   0.00  AS NECTOT, ';

  strSQL := strSQL + '   CAST(IF(IFNULL((SELECT COUNT(*)                                   ';
  strSQL := strSQL + '    FROM CADLOT                                                 ';
  strSQL := strSQL + '    WHERE LOT_CODITE = G.ITE_CODITE                         ';
  strSQL := strSQL + '      AND LOT_CODEMP = ' + QuotedStr(edtEmpCD.Text) ;
  strSQL := strSQL + '          ), 0) > 0, "S", "N") AS CHAR(1)) AS TEMLOT,                       ';

  If chkImpRef.Checked Then
  Begin
    If (fCfgSis('MONDES', varString) = '1') Then
      strSQL := strSQL + '   CAST(CONCAT(IFNULL(I.ITE_DESITE,""), IF(IFNULL(I.ITE_REFERE,"") = "", "", CONCAT(" ",I.ITE_REFERE))) AS CHAR(100))AS DESITE, '
    Else
      strSQL := strSQL + '   CAST(CONCAT(IF(IFNULL(I.ITE_REFERE,"") = "", "", CONCAT(I.ITE_REFERE," ")), IFNULL(I.ITE_DESITE,"")) AS CHAR(100)) AS DESITE, ';
  End
  Else
    strSQL := strSQL + '   I.ITE_DESITE AS DESITE, ';

  If fCfgSis('EXIAPL', varBoolean) Then
    strSQL := strSQL + ' I.ITE_APLICA AS APLICA, ';

  strSQL := strSQL + '   I.ITE_REFERE AS REFERE, ';
  strSQL := strSQL + '   I.ITE_CODUNI AS UNIDAD, ';
  strSQL := strSQL + '   U.UNI_SIGUNI AS SIGUNI, ';
  strSQL := strSQL + '   IFNULL(U.UNI_PESLIT,0) AS PESUNT, ';
  strSQL := strSQL + '   I.ITE_CODFOR AS CODFOR, ';
  strSQL := strSQL + '   CAST(CONCAT(I.ITE_CODFOR, " -  ", F.FOR_NOMFOR) AS CHAR(100)) AS FORNEC, ';

  strSQL := strSQL + '   SUM(G.ITE_SALDOS + ' + fSQLSalEntFut + ' - ' + fSQLSalResAbaixoMin(chkSalResEmp) +  ' + ' + fRetSQLConsiderarSaldoTransf + ') AS SALDOS,';

  strSQL := strSQL + '   SUM(IF(IFNULL(ITE_CNV_ML, 0) > 0, (G.ITE_SALDOS + ' + fSQLSalEntFut + ' - ' + fSQLSalResAbaixoMin(chkSalResEmp) + ' + ' + fRetSQLConsiderarSaldoTransf + ') * ITE_CNV_ML + G.ITE_SAL_ML, 0)) AS SALMLG, ';

  strSQL := strSQL + '   IFNULL(G.ITE_ESTMIN, 0) AS ESTMIN, ';
  strSQL := strSQL + '   G.ITE_ESTMAX AS ESTMAX, ';
  strSQL := strSQL + '   IFNULL(G.ITE_ABAMLT, "N") AS ABAMLT, ';
  strSQL := strSQL + '   I.ITE_EMBALA AS EMBALA, ';

  strSQL := strSQL + '  SUM(' + fSQLCamposQuantidadePendenteCompra(False {blnSoma}, False, False, 'SP') + ' - ' +
                                fSQLQuantidadePendenteCompraGarantia('G.ITE_CODITE', 'G.ITE_CODEMP') + ') AS QTDPEN, ';

  strSQL := strSQL + '  SUM(' + fSQLQuantidadePendenteCompraGarantia('G.ITE_CODITE', 'G.ITE_CODEMP') + ') AS QTDPEN_GAR, ';

  strSQL := strSQL + '  IFNULL(PONEXP.SIS_VALCFG, "N") AS PONEXP, ';
  strSQL := strSQL + '  G.ITE_PONEXP, ';

  strSQL := strSQL + '  SUM(CAST(CEIL((';

  If rdgCalMinMax.ItemIndex = 0 Then
    strSQL := strSQL + '    IFNULL(G.ITE_ESTMIN, 0) '
    Else
    strSQL := strSQL + '    G.ITE_ESTMAX ';

  strSQL := strSQL + '      - (G.ITE_SALDOS + ' + fRetSQLOrdemPro + ' + ' + fSQLSalEntFut + ' - ' + fSQLSalResAbaixoMin(chkSalResEmp) + ' + ' + fRetSQLConsiderarSaldoTransf + ')';

  If chkPedCom.Checked And chkPedComGar.Checked Then
    strSQL := strSQL + '  - ' + fSQLCamposQuantidadePendenteCompra(False {blnSoma}, False, False, 'SP')

  Else If chkPedCom.Checked Then
    strSQL := strSQL + '  - (' + fSQLCamposQuantidadePendenteCompra(False {blnSoma}, False, False, 'SP') + ' + ' +
                                 fSQLQuantidadePendenteCompraGarantia('G.ITE_CODITE', 'G.ITE_CODEMP') + ') '

  Else If chkPedComGar.Checked Then
    strSQL := strSQL + '  - ' + fSQLQuantidadePendenteCompraGarantia('G.ITE_CODITE', 'G.ITE_CODEMP');

  strSQL := strSQL + '            )) AS DECIMAL(14, 4))) ';

  If chkLimSal.Checked Then
  Begin
    strSQL := strSQL + '           AS NECORI, ';
    strSQL := strSQL + '           0.0000 AS NECCOM, ';
  End Else
  Begin
    strSQL := strSQL + '           AS NECCOM, ';
    strSQL := strSQL + '           0.0000 AS NECORI, ';
  End;

  strSQL := strSQL + '           0.0000 AS PERACU, ';

  strSQL := strSQL + fRetSQLOrdemPro + '  AS ORDPRO, ';

  strSQL := strSQL + ' IFNULL(G.ITE_SALTRA, 0) AS TEPEND, ';

  strSQL := strSQL + ' "  " AS LIMSAL, ';

  If rdbDiaEst.Checked Then
  Begin
    strSQL := strSQL + ' (' + fSQLQtdVen('CD.ITE_CODEMP', True) + ') AS QTDVEN_CD, ';
    strSQL := strSQL + ' CAST(NULL AS DECIMAL(12,4)) AS MEDIA_CD, ';
  End;

  //----------------------------------------------------------------------- SALDCD
  blnUsaQtdPen := (Not fCfgSis('BEFTRG', VarBoolean)) Or fUsaQtdPendenteEntregaFutura;
  strSQL := strSQL + '  IFNULL(CD.ITE_SALDOS, 0) + ' +  IIf(blnUsaQtdPen, fGetSQLSomaCamposEntregaFutura('CD'), '0') + ' AS SALFIS, ';

  strSQL := strSQL + '  ROUND(IFNULL((CD.ITE_SALDOS) ';

  If fUsaRotinaWMS Then
  Begin
    strSQL := strSQL + ' - IFNULL( ( SELECT SUM(LOT_SALDOS)                                       ';
    strSQL := strSQL + '             FROM CADLOT                                                  ';
    strSQL := strSQL + '             WHERE LOT_CODITE = G.ITE_CODITE                              ';
    strSQL := strSQL + '               AND LOT_CODEMP = ' + QuotedStr(edtEmpCD.Text)   ;
    strSQL := strSQL + '               AND LOT_ABSAUT  = "N" ) ,0)                                ';
  End;

  Case fCfgSis('CALSAL', varInteger) Of
    1: strSQL := strSQL + ' + IFNULL(CD.ITE_QTEF_A, 0) + IFNULL(CD.ITE_QTEF_F, 0) + IFNULL(CD.ITE_QTEF_P, 0) ';
    2: ;
    3: strSQL := strSQL + ' + IFNULL(CD.ITE_QTEF_F, 0) ';
    4: strSQL := strSQL + ' + IFNULL(CD.ITE_QTEF_A, 0) + IFNULL(CD.ITE_QTEF_P, 0) ';
    5: strSQL := strSQL + ' + IFNULL(CD.ITE_QTEF_A, 0) + IFNULL(CD.ITE_QTEF_F, 0) ';
  End;

  strSQL := strSQL + '  , 0) ';

  If rdbPerEam.Checked And (Not chkSalRes.Checked) Then
    strSQL := strSQL + ' * ((100- ' + ReplaceStr(edtPerEam.Text, ',', '.') + ') / 100) ';

  strSQL := strSQL  + ',4) AS SALDCD, ';
  //---------------------------------------------------------------------------------------------------------------------


  strSQL := strSQL  + '  CD.ITE_ESTMIN AS CD_ESTMIN, ';
  strSQL := strSQL  + '  CD.ITE_ESTMAX AS CD_ESTMAX, ';

  strSQL := strSQL + '  ROUND(IFNULL((CD.ITE_SALDOS) ';

  If fUsaRotinaWMS Then
  Begin
    strSQL := strSQL + ' - IFNULL( ( SELECT SUM(LOT_SALDOS)                                       ';
    strSQL := strSQL + '             FROM CADLOT                                                  ';
    strSQL := strSQL + '             WHERE LOT_CODITE = G.ITE_CODITE                              ';
    strSQL := strSQL + '               AND LOT_CODEMP = ' + QuotedStr(edtEmpCD.Text)   ;
    strSQL := strSQL + '               AND LOT_ABSAUT  = "N" ) ,0)                                ';
  End;

  Case fCfgSis('CALSAL', varInteger) Of
    1: strSQL := strSQL + ' + IFNULL(CD.ITE_QTEF_A, 0) + IFNULL(CD.ITE_QTEF_F, 0) + IFNULL(CD.ITE_QTEF_P, 0) ';
    2: ;
    3: strSQL := strSQL + ' + IFNULL(CD.ITE_QTEF_F, 0) ';
    4: strSQL := strSQL + ' + IFNULL(CD.ITE_QTEF_A, 0) + IFNULL(CD.ITE_QTEF_P, 0) ';
    5: strSQL := strSQL + ' + IFNULL(CD.ITE_QTEF_A, 0) + IFNULL(CD.ITE_QTEF_F, 0) ';
  End;

  strSQL := strSQL + '  ,0),4) AS REALCD, ';

  strSQL := strSQL +    strUnitar + ' AS UNITAR, ';
  strSQL := strSQL + '  CD.ITE_PRECUS AS PRECUS, ';
  strSQL := strSQL + '  CD.ITE_PREMED AS PREMED, ';
  strSQL := strSQL + '  CD.ITE_ICMSAI AS ICMSAI, ';
  strSQL := strSQL + '  CD.ITE_IPISAI AS IPISAI, ';
  strSQL := strSQL + '  CD.ITE_SUBSTI AS SUBSTI, ';

  strSQL := strSQL + '   I.ITE_PESOIT AS PESOIT, ';
  strSQL := strSQL + '   I.ITE_INCPIS AS INCPIS, ';

  strSQL := strSQL + '   ' + fGetSQLSomaCamposEntregaFutura() + ' AS ENTFUT, ';

  strSQL := strSQL + '  IFNULL(GUN_DESCRI,"OUTROS") AS UNIGRU, ';

  strSQL := strSQL + '   M.MAR_DESMAR AS DESMAR, ';

  strSQL := strSQL + '   CONCAT(F.FOR_NOMFOR, "-", I.ITE_REFERE) AS FORREF, ';

  If fCfgSIs('TIPABF') = '1' Then
    strSQL := strSQL + '   I.ITE_CODABF AS CODABF, '
  Else
    strSQL := strSQL + '   G.ITE_CODABF AS CODABF, ';

  If (rdgAnaEmp.ItemIndex = 1) And (fEmptyStr(strEmpresas)) Then
  Begin
    strSQL := strSQL + ',  SUM(G2.ITE_SALDOS  + ' + fSQLSalEntFut('G2') + ' - ' + fSQLSalResAbaixoMin(chkSalResEmp) + ' + ' + fRetSQLConsiderarSaldoTransf + ')  AS TOT_SALDOS, ';
    strSQL := strSQL + '   SUM(IFNULL(G2.ITE_ESTMIN, 0)) AS TOT_ESTMIN,  ';
  End;

  strSQL := strSQL + '  CD.ITE_LOCFIS AS LOCFIS, ';
  strSQL := strSQL + '  CD.ITE_LOCSUP AS LOCSUP, ';

  If fUsaRotinaWMS Then
  begin
    strSQL := strSQL + ' IFNULL((SELECT ';
    strSQL := strSQL + '	  CONCAT(IFNULL(ITE_LOCFIS,""), GROUP_CONCAT(DISTINCT IFNULL(CADLOC.LOC_CODLOC,""))) AS LOCALIZACAO';
    strSQL := strSQL + '  FROM ITEGER';
    strSQL := strSQL + '  INNER JOIN LOCITE ON ITE_CODEMP = LCI_CODEMP';
    strSQL := strSQL + '                   AND ITE_CODITE =  LCI_CODITE';
    strSQL := strSQL + '  INNER JOIN CADLOC ON CADLOC.AUTOINCREM = LCI_LOCFIS';
    strSQL := strSQL + '                 AND LOC_CODEMP = ITE_CODEMP';
    strSQL := strSQL + '  WHERE ITE_CODITE = G.ITE_CODITE AND ITE_CODEMP = G.ITE_CODEMP),"") FISEMP, ';
  end
  else
    strSQL := strSQL + '  G.ITE_LOCFIS AS FISEMP, ';

  strSQL := strSQL + '  G.ITE_LOCSUP AS SUPEMP, ';

  if fCfgSis('CFTFSA', varBoolean) then
    strSQL := strSQL + '  (SELECT ITF.ITE_CODFAB FROM ITEFOR ITF WHERE ITF.ITE_CODITE = I.ITE_CODITE AND ITF.ITE_CODFOR = I.ITE_CODFOR AND ITF.ITE_CODEMP = ' + IIF(fEmptyStr(strEmpresas), QuotedStr(VS_strCodEmp), 'G.ITE_CODEMP') + ' LIMIT 1) AS CODFAB, '
  else
    strSQL := strSQL + '  I.ITE_CODFAB AS CODFAB, ';

  If rdbQtdVen.Checked Then
  Begin

    If rdbCalcVendaPorDia.Checked Then
    Begin
      strSQL := strSQL + fSQLQtdVen('G.ITE_CODEMP', True) + ' AS QTDVEN ';
    End
    Else
    Begin
      strSQL := strSQL + fSQLQtdVen('G.ITE_CODEMP');
      strSQL := strSQL + fSQLQtdVen('G.ITE_CODEMP', True) + ' AS QTDVEN ';
    End;

  End
  Else
    strSQL := strSQL + ' 0 AS QTDVEN ';

  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADITE I ';

  strSQL := strSQL + '   INNER JOIN CADMAR M ON M.MAR_CODMAR = I.ITE_CODMAR ';

  strSQL := strSQL + '   INNER JOIN ITEGER CD ON CD.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '                       AND CD.ITE_CODEMP = ' + QuotedStr(edtEmpCD.Text);

  strSQL := strSQL + '   INNER JOIN ITEGER G ON I.ITE_CODITE = G.ITE_CODITE ';
  strSQL := strSQL + '   LEFT JOIN CFGSIS PONEXP ON PONEXP.SIS_CODEMP = G.ITE_CODEMP AND PONEXP.SIS_CODCFG = "CFG_PONEXP" ';
  strSQL := strSQL + '   LEFT JOIN CFGSIS TIPGIR ON TIPGIR.SIS_CODEMP = G.ITE_CODEMP AND TIPGIR.SIS_CODCFG = "CFG_TIPGIR" ';

  strSQL := strSQL + '   LEFT JOIN SALPDC SP ON SP.SAL_CODITE = G.ITE_CODITE ';
  strSQL := strSQL + '                      AND SP.SAL_CODEMP = G.ITE_CODEMP ';

  strSQL := strSQL + '   INNER JOIN CADUNI U ON U.UNI_CODUNI = I.ITE_CODUNI ';
  strSQL := strSQL + '   LEFT  JOIN CADFOR F ON F.FOR_CODFOR = I.ITE_CODFOR ';
  strSQL := strSQL + '   JOIN CADGRU   ON   GRU_CODGRU =  I.ITE_CODGRU ';

  If (rdgAnaEmp.ItemIndex = 1) And fEmptyStr(strEmpresas) Then
  Begin
    strSQL := strSQL + ' INNER JOIN ITEGER G2 ON G2.ITE_CODITE = G.ITE_CODITE ';
  End;

  strSQL := strSQL + 'LEFT JOIN ITEGUN ON I.ITE_CODUNI = ITEGUN.GUN_CODUNI ';
  strSQL := strSQL + 'LEFT JOIN CADGUN ON ITEGUN.GUN_CODIGO = CADGUN.GUN_CODIGO ';
  strSQL := strSQL + ' INNER JOIN CADEMP ON EMP_CODEMP = G.ITE_CODEMP ';
  strSQL := strSQL + ' WHERE TRUE ';

  if FCFGTRITTE then
    strSQL := strSQL + ' AND IFNULL(I.ITE_TRITTE, "N") = "S" ';

  If Not fEmptyStr(strEmpresas) Then
    strSQL := strSQL + ' AND G.ITE_CODEMP IN( ' + fCommaTextToQuoted(strEmpresas)  + ') ';

  If edtGirEst.Text <> 'T' Then
    strSQL := strSQL + ' AND IF( TIPGIR.SIS_VALCFG = "S", G.ITE_NIVGIR, I.ITE_NVLGIR ) = ' + QuotedStr(edtGirEst.Text);

  if Not fEmptyStr(fSQLNotasEntrada) then
    strSQL := strSQL + ' AND I.ITE_CODITE IN ( ' + fSQLNotasEntrada + ' )';

  Case rdgSaldoCD.ItemIndex Of
    0: Begin
          strSQL := strSQL + '  AND IFNULL((SELECT SUM(ITEGER.ITE_SALDOS) ';
          strSQL := strSQL + '          FROM ITEGER ';
          strSQL := strSQL + '          WHERE ITEGER.ITE_CODITE = G.ITE_CODITE AND ';
          strSQL := strSQL + '                ITEGER.ITE_CODEMP = ' + QuotedStr(edtEmpCD.Text) + '),0) > 0 ';
       End;
    1: Begin
          strSQL := strSQL + '  AND IFNULL((SELECT SUM(ITEGER.ITE_SALDOS) ';
          strSQL := strSQL + '          FROM ITEGER ';
          strSQL := strSQL + '          WHERE ITEGER.ITE_CODITE = G.ITE_CODITE AND ';
          strSQL := strSQL + '                ITEGER.ITE_CODEMP = ' + QuotedStr(edtEmpCD.Text) + '),0) = 0 ';
       End;
    3: Begin
          strSQL := strSQL + '  AND IFNULL((SELECT SUM(ITEGER.ITE_SALDOS) ';
          strSQL := strSQL + '          FROM ITEGER ';
          strSQL := strSQL + '          WHERE ITEGER.ITE_CODITE = G.ITE_CODITE AND ';
          strSQL := strSQL + '                ITEGER.ITE_CODEMP = ' + QuotedStr(edtEmpCD.Text) + '),0) < 0 ';
       End;
  End;

  If (rdgAnaEmp.ItemIndex = 0) Or (Not fEmptyStr(strEmpresas)) Then
  Begin

    strSQL := strSQL + '  AND G.ITE_SALDOS + ' + fSQLSalEntFut + ' - ' + fSQLSalResAbaixoMin(chkSalResEmp) + ' + ' + fRetSQLConsiderarSaldoTransf + fRetOperadorEstMin ;

    if chkPontoExposicao.Checked Then
      strSQL := strSQL + ' IF(PONEXP.SIS_VALCFG = "S" AND  IFNULL(G.ITE_PONEXP, 0) > IFNULL(G.ITE_ESTMIN, 0), IFNULL(G.ITE_PONEXP, 0), IFNULL(G.ITE_ESTMIN, 0)) '
    Else
      strSQL := strSQL + ' IFNULL(G.ITE_ESTMIN,0 ) ';

    Case rdgSaldo.ItemIndex Of
      0: strSQL := strSQL + '  AND G.ITE_SALDOS + ' + fSQLSalEntFut + ' - ' + fSQLSalResAbaixoMin(chkSalResEmp) + ' + ' + fRetSQLConsiderarSaldoTransf + ' > 0 ';
      1: strSQL := strSQL + '  AND G.ITE_SALDOS + ' + fSQLSalEntFut + ' - ' + fSQLSalResAbaixoMin(chkSalResEmp) + ' + ' + fRetSQLConsiderarSaldoTransf + ' = 0 ';
      3: strSQL := strSQL + '  AND G.ITE_SALDOS + ' + fSQLSalEntFut + ' - ' + fSQLSalResAbaixoMin(chkSalResEmp) + ' + ' + fRetSQLConsiderarSaldoTransf + ' < 0 ';
    End;
  End;

  Case rdgCompraCentr.ItemIndex Of
      0: strSQL := strSQL + '  AND (G.ITE_CPRCEN = "S" AND G.ITE_EMPCEN =  ' + QuotedStr(edtEmpCD.Text) + ')';
      1: strSQL := strSQL + '  AND ((G.ITE_CPRCEN = "N") OR (G.ITE_EMPCEN <> ' + QuotedStr(edtEmpCD.Text) + '))';
  End;

  If blnExiPct Then
  Begin
    strSQL := strSQL + fGetSqlTipoAbstecimento;
    strSQL := strSQL + fGetSQLPoliticaEst;
  End;

  If Not fEmptyStr(mskLinhaGrupo.Text) Then
      strSQL := strSQL + fStrLocateLinGru(mskLinhaGrupo, arrLinGru, 'ITE_CODGRU','CODGRU');

  strSQL := strSQL + fStrLocate(edtFornecedor, arrLinFor, 'I.ITE_CODFOR', 'CODFOR');
  strSQL := strSQL + fStrLocate(edtMarca, arrLinMar, 'I.ITE_CODMAR', 'CODMAR');
  strSQL := strSQL + fStrLocate(edtUnidade, arrLinUni, 'I.ITE_CODUNI', 'CODUNI');
  strSql := strSQL + fStrLocate(edtGruCmp,  arrGruCmp, 'I.ITE_GRUCMP', 'GRUCMP');
  strSql := strSQL + fStrLocate(edtPrdGru,  arrPrdGru, 'I.ITE_PRDGRU', 'PRDGRU');
  strSql := strSQL + fStrLocate(edtCodDep,  arrCodDep, 'I.ITE_CODDEP', 'CODDEP');

  if blnSitPro Then
  Begin
    Case intSitPro Of
      1: strSQL := strSQL + fStrLocate(edtCodSitPro, arrSitPro, 'I.ITE_SITPRO', 'SITPRO');
      2: strSQL := strSQL + fStrLocate(edtCodSitPro, arrSitPro, 'G.ITE_SITPRO', 'SITPRO');
    End;

    Case intSitPro Of
      1: strSQL := strSQL + fStrLocate(edtCodSitProExc, arrSitProExc, 'I.ITE_SITPRO', 'SITPROEXC', false, true);
      2: strSQL := strSQL + fStrLocate(edtCodSitProExc, arrSitProExc, 'G.ITE_SITPRO', 'SITPROEXC', false, true);
    End;
  End;


  If Not fEmptyStr(fRemoverTodosCaracteresPercentual(edtRefere.Text)) Then
    strSQL := strSQL + '  AND I.ITE_REFERE LIKE ' + QuotedStr(edtRefere.Text + '%');

  If rdgStatus.ItemIndex = 0 Then
    strSQL := strSQL + ' AND I.ITE_ITEATI = ' + QuotedStr('S') + ' '
  Else If rdgStatus.ItemIndex = 1 Then
    strSQL := strSQL + ' AND I.ITE_ITEATI = ' + QuotedStr('N') + ' ';

  Case rdgImpLis.ItemIndex Of
    0: strSQL := strSQL + ' AND G.ITE_IMPLIS  = "S" ';
    1: strSQL := strSQL + ' AND G.ITE_IMPLIS  = "N" ';
  End;

  If Not chkLocFisCD.Checked Then
  Begin
    Case rdgLocFis.ItemIndex Of
      0: strSQL := strSQL + ' AND IFNULL(G.ITE_LOCFIS, "") <> "" ';
      1: strSQL := strSQL + ' AND IFNULL(G.ITE_LOCFIS, "") =  "" ';
    End;
  End;

  If chkDescMinMaxCD.Checked Then
  Begin
    strSQL := strSQL + '  AND IFNULL(CD.ITE_ESTMIN, 0) > 0 ';
    strSQL := strSQL + '  AND CD.ITE_ESTMAX > 0 ';
  End;

  If not fEmptyStr(fRemoverTodosCaracteresPercentual(edtDescri.Text)) Then
    strSQL := strSQL  + ' AND I.ITE_DESITE LIKE :DESITE ';

  If not fEmptyStr(fRemoverTodosCaracteresPercentual(edtAcoObj.Text)) Then
    strSQL := strSQL  + ' AND I.ITE_ACOOBJ LIKE :ACOOBJ ';

  If Not fEmptyStr(fRemoverTodosCaracteresPercentual(edtRefere.Text)) Then
    strSQL := strSQL + '  AND I.ITE_REFERE LIKE :REFERE ';


  If Not chkInativoCompra.Checked Then
    strSQL := strSQL + '  AND I.ITE_ATICOM = "S" ';

  If (rdgAnaEmp.ItemIndex = 1) And (fEmptyStr(strEmpresas))Then
  Begin
    strSQL := strSQL + ' GROUP BY ';
    strSQL := strSQL + '   G2.ITE_CODITE, G.ITE_CODEMP ';
    strSQL := strSQL + ' HAVING ';

    strSQL := strSQL + '  TOT_SALDOS ' + fRetOperadorEstMin + ' TOT_ESTMIN  ';

    If rdgNecCompra.ItemIndex = 0 Then
    Begin

      If chkLimSal.Checked Then
        strSQL := strSQL + '  AND NECORI > 0 '
      Else
        strSQL := strSQL + '  AND NECCOM > 0 ';

    End;

    Case rdgSaldo.ItemIndex Of
      0: strSQL := strSQL + '  AND TOT_SALDOS > 0 ';
      1: strSQL := strSQL + '  AND TOT_SALDOS = 0 ';
      3: strSQL := strSQL + '  AND TOT_SALDOS < 0 ';
    End;

  End Else
  Begin

    strSQL := strSQL + ' GROUP BY ';
    strSQL := strSQL + '   G.ITE_CODITE, G.ITE_CODEMP ';

    If rdgNecCompra.ItemIndex = 0 Then
    Begin
      strSQL := strSQL + ' HAVING ';

      If chkLimSal.Checked Then
      Begin
        If chkPontoExposicao.Checked Then
          strSQL := strSQL + '   IF(PONEXP = "S", IF(NECORI < ITE_PONEXP, ITE_PONEXP, NECORI), NECORI)> 0 '
        Else
          strSQL := strSQL + '  NECORI > 0 ';
      End
      Else
      begin
        If chkPontoExposicao.Checked Then
          strSQL := strSQL + '   IF(PONEXP = "S", IF(NECCOM < ITE_PONEXP, ITE_PONEXP, NECCOM), NECCOM)> 0 '
        Else
          strSQL := strSQL + '  NECCOM > 0 ';
      End;
    End;

  End;

  strSQL := strSQL + 'ORDER BY ';

  If fUsaRotinaWMS Then
    strSQL := strSQL + '  CD.ITE_LOCFIS, ';

  If rdgOrdem.ItemIndex = 3 Then
    strSQL := strSQL + '  DESMAR, ';

  strSQL := strSQL + '  I.ITE_DESITE, G.ITE_CODITE, G.ITE_CODEMP ';

  Result := strSQL;
End;

Procedure TfrmRelEstItemsAbaixoMin.pAbreQueryItens(strEmpresas: String; qryItens: TZClient; strCodEmpCD: String='');
Begin
  With qryItens, qryQuery Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(fGetSqlItens(strEmpresas, intIndice));

    pSetaParam(mskLinhaGrupo.Text, arrLinGru, strLinGru, 'CODGRU', qryQuery);

    If Not fEmptyStr(edtCodEmpresa.Text) and (rdgGirEst.ItemIndex > 0) Then
      pSetaParam(edtCodEmpresa.Text, arrLinEmp, strLinEmp, 'CODEMP', qryQuery);

    If (rdbCalcVendaPorDia.Checked) And (rdbQtdVen.Checked) Then
    Begin
      ParamByName('DTAINIDIAS').AsDate := IncDay(Date, - StrToIntDef(edtDias.Text, 0));
      ParamByName('DTAFINDIAS').AsDate := Date;

      ParamByName('CLAVEN').AsString := VS_strClaVen;
      ParamByName('CLADEV').AsString := VS_strClaDev;
    End;

    If Not fEmptyStr(edtDocumento.Text) Then
    Begin
      ParamByName('NUMDOC').AsString    := edtDocumento.Text;
      ParamByName('ESPDOC').AsString    := edtEspecie.Text;

      If Not fEmptyStr(edtCodEmpresaNE.Text) then
        ParamByName('CODEMP_NE').AsString := edtCodEmpresaNE.Text;

      If Not fEmptyStr(edtSerie.Text) Then
        ParamByName('SERDOC').AsString := edtSerie.Text;

      If Not fEmptyStr(edtForNot.Text) Then
        ParamByName('FORNOT').AsString := edtForNot.Text;

    End;

    If (Not fEmptyDate(mskDtaEntIni.Text)) And (Not fEmptyDate(mskDtaEntFin.Text)) Then
    Begin
      ParamByName('CLACOM').AsString := VS_strClaCom;
      ParamByName('DTAINI').AsDate := StrToDate(mskDtaEntIni.Text);
      ParamByName('DTAFIN').AsDate := StrToDate(mskDtaEntFin.Text);
    End;

    pSetaParam(edtFornecedor.Text, arrLinFor, strLinFor, 'CODFOR', qryQuery);
    pSetaParam(edtMarca.Text, arrLinMar, strLinMar, 'CODMAR', qryQuery);
    pSetaParam(edtUnidade.Text, arrLinUni, strLinUni, 'CODUNI', qryQuery);
    pSetaParam(edtGruCmp.Text,  arrGruCmp, strGruCmp, 'GRUCMP', qryQuery);
    pSetaParam(edtPrdGru.Text,  arrPrdGru, strPrdGru, 'PRDGRU', qryQuery);
    pSetaParam(edtCodDep.Text,  arrCodDep, strCodDep, 'CODDEP', qryQuery);

    if blnSitPro Then
    begin
       pSetaParam(edtCodSitPro.Text, arrSitPro, strSitPro, 'SITPRO', qryQuery);
       pSetaParam(edtCodSitProExc.Text, arrSitProExc, strSitProExc, 'SITPROEXC', qryQuery);
    end;

    If Not fEmptyStr(fRemoverTodosCaracteresPercentual(edtRefere.Text)) Then
      ParamByName('REFERE').AsString := edtRefere.Text + '%';

    If Not fEmptyStr(fRemoverTodosCaracteresPercentual(edtDescri.Text)) Then
      ParamByName('DESITE').AsString := edtDescri.Text + '%';

    If Not fEmptyStr(fRemoverTodosCaracteresPercentual(edtAcoObj.Text)) Then
      ParamByName('ACOOBJ').AsString := edtAcoObj.Text + '%';

    fAbreClient(True, 'TfrmRelEstItemsAbaixoMin.pAbreQueryItens');

    Case rdgOrdem.ItemIndex of
      0: qryItens.IndexFieldNames := 'DESITE;CODITE;CODEMP';
      1: qryItens.IndexFieldNames := 'LINDES;GRUDES;DESITE;CODITE;CODEMP';
      2: qryItens.IndexFieldNames := 'FORNEC;DESITE;CODITE;CODEMP';
      3: qryItens.IndexFieldNames := 'DESMAR;DESITE;CODITE;CODEMP';
      4: qryItens.IndexFieldNames := 'LOCFIS;DESITE;CODITE;CODEMP';
      5: qryItens.IndexFieldNames := 'UNIGRU;LOCFIS;LOCSUP;DESITE;CODITE;CODEMP';
      6: qryItens.IndexFieldNames := 'SIGUNI;DESITE;CODITE;CODEMP';
    end;


    If chkSalRes.Checked Or rdbDiaEst.Checked Then  // VAI REPROCESSAR
      pCalculaSaldoReservadoCD(qryItens);

    If chkLimSal.Checked Then
      pAjustaPontoExposicao(qryItens, 'NECORI')
    Else
      pAjustaPontoExposicao(qryItens, 'NECCOM');

    pAjustaAbastecimento(qryItens, True, False);

    pAlinhaCampoCentro('CODEMP');
  End;
End;

procedure TfrmRelEstItemsAbaixoMin.pAjustaAbastecimento(qryItens: TZClient; blnTrataPercGradativo: Boolean; blnRelatorio: boolean);
  Var
    intContador,
    intLoops: Integer;
    fltCalcul,
    fltPerGra,
    fltSalCdRestante,
    fltQtdAba: Double;
    blnSaldoCDMenorNecCompra,
    blnDeletou,
    blnAtingiuEstoqueMinimo: Boolean;
    blnLimita: Boolean;
    strCodIte: String;
    tpesFiltro: TTipoEstoqueSeguranca;
  Procedure pAtualizaSaldoCD;
  Begin
    If (Not fEmptyStr(strCodIte)) And
       (strCodIte = objGeraOR.cdsSaldoCD.Fieldbyname('CODITE').AsString) Then
    Begin
      objGeraOR.cdsSaldoCD.Edit;
      objGeraOR.cdsSaldoCD.Fieldbyname('SALDOS').AsFloat := fltSalCdRestante;
      objGeraOR.cdsSaldoCD.Post;
    End;

  End;

  Procedure pAtualizaMinimoSeguranca;
  Begin
    If (Not fEmptyStr(strCodIte)) And
       (strCodIte = cdsMinimoSeguranca.Fieldbyname('CODITE').AsString) Then
    Begin
      cdsMinimoSeguranca.Edit;
      cdsMinimoSeguranca.Fieldbyname('MINSEG').AsString := IIF(blnAtingiuEstoqueMinimo, 'S', 'N');
      cdsMinimoSeguranca.Post;
    End;
  End;
Begin
  Case rdgTipoMultiplo.ItemIndex Of
    0: objGeraOr.tpTipoMultiplo := tpmlCompra;
    2: objGeraOr.tpTipoMultiplo := tpmlVenda;
    1: Begin
         objGeraOr.tpTipoMultiplo := tpmlIndefinido;

         If (Not chkLimSal.Checked) And (Not chkCDNaoPodeAbastecer.Checked) Then
           Exit;
       End;
  End;

  objGeraOR.cdsSaldoCD.EmptyDataSet;

  With qryItens Do
  Begin
    pgbProgresso.Visible  := True;
    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := RecordCount;

    strCodIte := '';
    fltSalCdRestante := 0;

    If blnTrataPercGradativo Then
      fltPerGra := fStrToFloat(edtPerGra.text)
    Else
      fltPerGra := 0;

    blnTrataPercGradativo := blnTrataPercGradativo And (fltPerGra > 0);

    If blnTrataPercGradativo Then
      intLoops := 100 Div StrToInt64Def(edtPerGra.Text, 1)
    Else
      intLoops := 1;

    For intContador := 1 To intLoops Do
    Begin

      First;
      While Not Eof Do
      Begin
        Edit;
        blnDeletou := False;

        If (strCodIte <> Fieldbyname('CODITE').AsString) Then
        begin
          If Not objGeraOR.cdsSaldoCD.FindKey([Fieldbyname('CODITE').AsString]) Then
          Begin
            objGeraOR.cdsSaldoCD.Insert;
            objGeraOR.cdsSaldoCD.Fieldbyname('CODITE').AsString := Fieldbyname('CODITE').AsString;
            objGeraOR.cdsSaldoCD.Fieldbyname('SALDOS').AsFloat  := Fieldbyname('SALDCD').AsFloat;
            objGeraOR.cdsSaldoCD.Post;
          End;

          fltSalCdRestante := objGeraOR.cdsSaldoCD.Fieldbyname('SALDOS').AsFloat;

          strCodIte := Fieldbyname('CODITE').AsString;

          If Not cdsMinimoSeguranca.FindKey([Fieldbyname('CODITE').AsString]) Then
          Begin
            cdsMinimoSeguranca.Insert;
            cdsMinimoSeguranca.Fieldbyname('CODITE').AsString := Fieldbyname('CODITE').AsString;
            cdsMinimoSeguranca.Fieldbyname('MINSEG').AsString := 'N';
            cdsMinimoSeguranca.Post;
          End;

          blnAtingiuEstoqueMinimo := IIF(cdsMinimoSeguranca.Fieldbyname('MINSEG').AsString = 'N', False, True);
        End;

        tpesFiltro := tpesIndefinido;
        If (rdbMinSeg.Checked Or chkConsidEstMinCD.Checked) then
          tpesFiltro := tpesMinimo
        else if rdbMaxSeg.Checked Then
          tpesFiltro := tpesMaximo;

        fltQtdAba := objGeraOR.fRetQuantidade(qryItens,
                                              objGeraOr.tpTipoMultiplo,
                                              chkLimSal.Checked,
                                              blnLimita,
                                              fltSalCdRestante,
                                              fltPerGra,
                                              fltCalcul,
                                              blnAtingiuEstoqueMinimo,
                                              blnSaldoCDMenorNecCompra,
                                              blnTrataPercGradativo,
                                              blnRelatorio,
                                              tpesFiltro);
        If ((chkCDNaoPodeAbastecer.Checked) And (Not blnSaldoCDMenorNecCompra)) Or
           ((blnSaldoCDMenorNecCompra) And (chkLimSal.Checked) And (rdbMinSeg.Checked) ) Or
           ((fltQtdAba = 0) And  (rdgNecCompra.ItemIndex = 0) And (chkPontoExposicao.Checked)) // Qtd zero, necessidade de compra maior que zero e com ponto de reposição, não entra o item.
        Then
        Begin
          blnDeletou := True;
          qryItens.Delete;
        End
        Else
        Begin

          Fieldbyname('NECCOM').AsFloat := fltQtdAba;
          If blnLimita Then
            Fieldbyname('LIMSAL').AsString := '**';
          if fltCalcul >= 0 Then
            fltSalCdRestante := fltSalCdRestante - fltCalcul;
          If fltPerGra > 0 Then
            If Fieldbyname('PERACU').AsFloat + fltPerGra > 100 Then
              Fieldbyname('PERACU').AsFloat := 100
            Else
              Fieldbyname('PERACU').AsFloat := Fieldbyname('PERACU').AsFloat + fltPerGra;
            pAtualizaSaldoCD;
          pAtualizaMinimoSeguranca;

          Post;
        End;

        pgbProgresso.Position := pgbProgresso.Position + 1;
        Application.ProcessMessages;
       If Not blnDeletou Then
          Next;
      End;

    End;

    First;
  End;

  cdsMinimoSeguranca.EmptyDataSet;

  pgbProgresso.Visible  := False;
  pgbProgresso.Position := 0;
End;

procedure TfrmRelEstItemsAbaixoMin.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtDocumento);
end;

procedure TfrmRelEstItemsAbaixoMin.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  objFrmRest.fAtualizaDados;
  objFrmRest.fSalvaDados('', 'frmRelEstItemsAbaixoMin', strLoginUsuarioLogado);
  FreeAndNil(objFrmRest);
  FreeAndNil(objGeraOR);
  inherited;
end;

function TfrmRelEstItemsAbaixoMin.fRetSQLConsiderarSaldoTransf: String;
begin
  If Not chkSalTransf.Checked Then
  begin
    Result := Result + ' 0 ';
    Exit;
  End;

  Result := Result + ' IFNULL(G.ITE_SALTRA, 0) ';
end;

function TfrmRelEstItemsAbaixoMin.fRetSQLOrdemPro(): String;
begin
  Result := ' 0 ';
  If Not chkAdicOrdProduAberta.Checked Then
    Exit;
  Result := '';
  Result := Result + 'IFNULL((SELECT SUM(IFNULL(D.ORD_QTDPRO, 0)) ';
  Result := Result + '  FROM ORDDET D  ';
  Result := Result + ' INNER JOIN ORDGER G ON G.AUTOINCREM = D.ORD_SEQGER  ';
  Result := Result + ' WHERE D.ORD_CODITE = G.ITE_CODITE ';
  Result := Result + '   AND IFNULL(D.ORD_QTDPRO, 0) > 0 ';
  Result := Result + '   AND ORD_CODEMP = G.ITE_CODEMP ';
  Result := Result + '   AND G.ORD_DTABAI IS NULL), 0)';
end;

procedure TfrmRelEstItemsAbaixoMin.frxGenGetValue(const VarName: string;
  var Value: Variant);
begin
  If VarName = 'EMP_NOMEMP' Then
    Value := fRetNomeEmpresa(VS_strCodEmp)
  Else If VarName = 'REL_NOMREL' Then
    Value := Self.Name;
end;

function TfrmRelEstItemsAbaixoMin.frxRelatorioJUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  If MethodName = 'FFILTRASIMILAR' Then
    Result := fFiltraSimilar(Params[0])
  Else If MethodName = 'FARREDONDAMAIS' Then
    Result := fArredondaMais(Params[0], Params[1]);
end;

function TfrmRelEstItemsAbaixoMin.fRemoverTodosCaracteresPercentual(
  Value: String): String;
begin
  Result := StringReplace(Value, '%', '', [rfReplaceAll]);
end;

function TfrmRelEstItemsAbaixoMin.fRetNroMeses: Integer;
begin
  result :=  StrToIntDef(cmbMeses.Text, 0);
end;

procedure TfrmRelEstItemsAbaixoMin.setMesesVenda;
  Var
    intContador: Integer;
    wrdDia, wrdMes, wrdAno: Word;
    intQtdMes: integer;
begin
  intQtdMes := fRetNroMeses;
  setLength(objListaMesesVenda, intQtdMes);
  DecodeDate(fPegaDataBaseGiro, wrdAno, wrdMes, wrdDia);
  If Not chkInfMes.Checked Then
  Begin
    If (wrdMes = 0) Then
    Begin
      wrdMes := 12;
      Dec(wrdAno);
    End;

    For intContador := 1 To intQtdMes Do
    Begin
      objListaMesesVenda[intContador -1].MesAno := fRetMes(wrdMes, True) + '/' + IntToStr(wrdAno);
      objListaMesesVenda[intContador -1].Coluna := 15 + intContador;
      Dec(wrdMes);
      If (wrdMes = 0) Then
      Begin
        wrdMes := 12;
        Dec(wrdAno);
      End;
    End;
  end
  Else
  Begin
    cdsMeses.Filtered := false;
    cdsMeses.Filter := 'SELECI = ' + fQuotedStr('S');
    cdsMeses.Filtered := True;
    cdsMeses.Last;
    intContador := 1;
    While not cdsMeses.BoF do
    Begin
      objListaMesesVenda[intContador -1].MesAno :=
           fRetMes(cdsMeses.FieldByName('VALMES').AsInteger, True) + '/' +
           cdsMeses.FieldByName('VALANO').AsString;
      objListaMesesVenda[intContador -1].Coluna := 15 + intContador;
      cdsMeses.Prior;
      Inc(intContador);
    End;

    cdsMeses.Filtered := false;
  End;
end;

function TfrmRelEstItemsAbaixoMin.fPegaDataBaseGiro: TDateTime;
  var
    intContador: Integer;
begin
  Result := 0;

  For intContador := 0 To lstBasGir.Items.Count -1 Do
  Begin
    If lstBasGir.Checked[intContador] Then
    Begin
      If FormatDateTime('mm/yyyy', VS_Date) = lstBasGir.Items[intContador] Then
        Result := VS_Date
      Else
        Result := EndOfTheMonth(StrToDate('01/' + lstBasGir.Items[intContador]));
    End;
  End;
End;

function TfrmRelEstItemsAbaixoMin.fContaSelecaoBaseGiro: Integer;
  Var
    intContador: Integer;
begin
  Result := 0;
  For intContador := 0 To lstBasGir.Items.Count -1 Do
    If lstBasGir.Checked[intContador] Then
      Inc(Result);
end;

procedure TfrmRelEstItemsAbaixoMin.lblSelMesClick(Sender: TObject);
begin
  inherited;
  cdsMeses.fSelecionaMeses(fRetNroMeses, strMeses)
end;

procedure TfrmRelEstItemsAbaixoMin.lstBasGirClickCheck(Sender: TObject);
  Var
    intIndex   : Integer;
begin
  inherited;

  intIndex := lstBasGir.ItemIndex;
  If intIndex = -1 Then
    Exit;
  lstBasGir.CheckAll(cbUnchecked);
  lstBasGir.Checked[intIndex] :=  True;
end;

procedure TfrmRelEstItemsAbaixoMin.lstBasGirKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Return) Then
    SelectNext(ActiveControl,True,True)
  Else If (Key = VK_Escape) Then
    Close;
end;

procedure TfrmRelEstItemsAbaixoMin.chkImpSimilaresClick(Sender: TObject);
begin
  inherited;

  rdgLocFisProdSimilar.Enabled := chkImpSimilares.Checked;
end;

procedure TfrmRelEstItemsAbaixoMin.chkInfMesClick(Sender: TObject);
begin
  lblSelMes.Enabled := chkInfMes.Checked;

  If Not chkInfMes.Checked Then
    lstBasGir.Enabled := True;

  If (chkInfMes.Checked) And (Not blnCarregandoDados) Then
    lblSelMesClick(lblSelMes);

  lstBasGir.Enabled := Not chkInfMes.Checked;
end;

procedure TfrmRelEstItemsAbaixoMin.chkLimSalClick(Sender: TObject);
begin
  inherited;

  pHabilitaLimeteSaldo(chkLimSal.Checked);
  If chkLimSal.Checked and chkCDNaoPodeAbastecer.Checked Then
    chkCDNaoPodeAbastecer.Checked := False;

end;

procedure TfrmRelEstItemsAbaixoMin.chkPontoExposicaoClick(Sender: TObject);
begin
  inherited;
  pUtilizarPontoExposicao(chkPontoExposicao.Checked);
end;

procedure TfrmRelEstItemsAbaixoMin.pHabilitaLimeteSaldo(blnHabilita: Boolean);
Begin
  rdbPerEam.Enabled := blnHabilita;
  edtPerEam.Enabled := blnHabilita And rdbPerEam.Checked;

  rdbDiaEst.Enabled := blnHabilita;
  edtDiaEst.Enabled := blnHabilita And rdbDiaEst.Checked;

  lblPerGra.Enabled := blnHabilita;
  edtPerGra.Enabled := blnHabilita;

  rdbMinSeg.Enabled := blnHabilita;
  rdbMaxSeg.Enabled := blnHabilita;

  rdbSemEstSeg.Enabled := blnHabilita;

  If Not blnHabilita Then
  Begin
    rdbSemEstSeg.Checked := True;
  End;
End;

procedure TfrmRelEstItemsAbaixoMin.cmbCalcVendaPorDiaChange(Sender: TObject);
begin
  inherited;
  pTratarComponentesVendaPorDia;
end;

procedure TfrmRelEstItemsAbaixoMin.pTratarComponentesVendaPorDia;
begin
 chkInfMes.Visible := not (rdbCalcVendaPorDia.Checked);
 lblSelMes.Visible := chkInfMes.Visible;

  If rdbCalcVendaPorDia.Checked Then
  Begin
    edtDias.Visible := True;
    cmbMeses.Visible := False;
    rdbQtdVen.Checked := True;
    lblMesDia.Caption := 'Dias';
    lstBasGir.Visible := False;
    lblBasGir.Visible := False;
  End
  Else
  Begin
    edtDias.Visible := False;
    cmbMeses.Visible := True;
    lblMesDia.Caption := 'Meses';
    lstBasGir.Visible := True;
    lblBasGir.Visible := True;
  End;
end;

procedure TfrmRelEstItemsAbaixoMin.pUtilizarPontoExposicao(pUtilizar: Boolean);
begin
  rdgAnaEmp.Enabled := Not pUtilizar;
  if pUtilizar then
    rdgAnaEmp.ItemIndex := 0;
end;

end.
