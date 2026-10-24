{***************************}
{* qryConIte -> CADITE     *}
{* qryConCor -> CADCOR     *}
{* qryConFas -> CADFAS     *}
{************************JB*}
unit untCadEstruturasIndustrial;

interface

uses
  Windows, Classes, Controls, Forms, untPai, Menus, StdCtrls, Buttons, ExtCtrls,
  EditFocus, Mask, DBCtrls, Uni, Grids, DBGridCitel, DBGrids, AppEvnts, frxClass, frxDBSet,
  DB, UniClientDataSet, UniDataSetProvider,  cxControls, cxContainer, cxEdit, cxLabel,
  cxDBLabel, untGeraExcel, untExcel, BitBtnLockedIncrem, MemDS, DBAccess,
  Provider, frxExportCSVTestabilidade, Datasnap.DBClient, untZClient,
  dxGDIPlusClasses, Vcl.ComCtrls, StrUtils, untAnaliseMov, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, dxCore, cxDateUtils, cxTextEdit,
  cxMaskEdit, cxDropDownEdit, cxCalendar, DateEditFocus, DateUtils, untLiberacao,
  cadastro.TSQLEstruturaIndustrial, OrdemProducaoIndustrial.TFormula,
  OrdemProducaoIndustrial.Dados.TCarregaMateriaPrima,
  OrdemProducaoIndustrial.Dados.TCarregaProdutoAcabado,
  OrdemProducaoIndustrial.TMateriaPrima, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, MaskEditFocus, untProcessoExtrusao,
  OrdemProducaoIndustrial.TCadFaseFormulaEspecial, untLogFormulaAlterada, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;


type
  TfrmCadEstruturasIndustrial = class(TfrmPai)
    pnlProdutos: TPanel;
    Label1: TLabel;
    edtDesProduto: TEditFocus;
    Label5: TLabel;
    Label10: TLabel;
    edtProdutos: TEditFocus;
    edtReferencia: TEditFocus;
    edtUnidade: TEditFocus;
    frxPaginaM: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    qryConsulta: TUniQuery;
    dspConsulta: TUniDataSetProvider;
    cdsConsulta: TUniClientDataSet;
    dtsConsulta: TDataSource;
    frxSemPrecoM: TfrxReport;
    frxSemPrecoJ: TfrxReport;
    frxPreCusM: TfrxReport;
    frxPreCusJ: TfrxReport;
    Label8: TLabel;
    edtCor: TEditFocus;
    edtDesCor: TEditFocus;
    Label9: TLabel;
    edtCodFormula: TEditFocus;
    rdgStatus: TRadioGroup;
    Label15: TLabel;
    btnConfirma: TBitBtnLocked;
    btnEstrutura: TBitBtnLocked;
    btnComentario: TBitBtnLocked;
    btnMoveCima: TBitBtnLocked;
    btnMoveBaixo: TBitBtnLocked;
    btnApaga: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    btnSubstituir: TBitBtnLocked;
    Label18: TLabel;
    edtDtaCad: TEditFocus;
    Label19: TLabel;
    edtDtaAlt: TEditFocus;
    PageControl: TPageControl;
    tbsFormula: TTabSheet;
    pnlSubProdutos: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label11: TLabel;
    Label17: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    edtDesSubProduto: TEditFocus;
    edtSubProduto: TEditFocus;
    edtSubReferencia: TEditFocus;
    edtSubUnidade: TEditFocus;
    edtSubQtdIte: TEditFocus;
    edtCodFas: TEditFocus;
    edtDesFas: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    edtSeq: TEditFocus;
    edtPerTol: TEditFocus;
    dbgDados: TDBGridCitel;
    Panel1: TPanel;
    lblMostraOps: TLabel;
    imgEpi: TImage;
    lblMsgEpi: TLabel;
    pnlTotais: TPanel;
    btnEpi: TBitBtnLocked;
    tbsAnalise: TTabSheet;
    pnlAnalises: TPanel;
    dbgAnalise: TDBGridCitel;
    Label22: TLabel;
    edtCodAna: TEditFocus;
    edtDesAna: TEditFocus;
    btnConfirmaAnalise: TBitBtnLocked;
    btnCancelaAnalise: TBitBtnLocked;
    pnlPesos: TPanel;
    edtPesRea: TEditFocus;
    edtTotPes: TEditFocus;
    Label16: TLabel;
    Label14: TLabel;
    pnlCusKG: TPanel;
    edtTotCus: TEditFocus;
    lblTotCusKG: TLabel;
    pnlCusLT: TPanel;
    Label25: TLabel;
    edtTotCusLT: TEditFocus;
    pnlPercentualTotal: TPanel;
    Label12: TLabel;
    edtTotPer: TEditFocus;
    frxPreCusLitroM: TfrxReport;
    frxPreCusLitroJ: TfrxReport;
    pgcResultadoAnalise: TPageControl;
    tbsIntervaloValores: TTabSheet;
    tbsDescricaoAberta: TTabSheet;
    Label13: TLabel;
    edtDescricaoResultadoAnalise: TEditFocus;
    edtCapacidadeMaxima: TEditFocus;
    pnlCapacidadeMaxima: TPanel;
    Label23: TLabel;
    Label24: TLabel;
    edtAnaMin: TEditFocus;
    edtAnaMax: TEditFocus;
    Label26: TLabel;
    chkForEsp: TCheckBox;
    edtDataDesenvolvimento: TDateEditFocus;
    lblDataDesenvolvimento: TLabel;
    TbsDescProcedimentoProd: TTabSheet;
    RichDescProcProducao: TRichEdit;
    ChkComponenteAB: TCheckBox;
    frxFormIte: TfrxDBDataset;
    frxPaginaJ: TfrxReport;
    tbsExtrusao: TTabSheet;
    pnlOperador: TPanel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    EdtOpeNomeExtrusao: TEditFocus;
    EdCodOpeExtrusao: TEditFocus;
    MskHraFinalExtrusao: TMaskEditFocus;
    MskHraInicioExtrusao: TMaskEditFocus;
    Panel2: TPanel;
    cxgExtrusao: TcxGridCitel;
    cxvExtrusao: TcxGridDBTableViewCitel;
    cxvExtrusaoTermostato: TcxGridDBColumn;
    cxvExtrusao01: TcxGridDBColumn;
    cxvExtrusao02: TcxGridDBColumn;
    cxvExtrusao03: TcxGridDBColumn;
    cxgExtrusaoLevel1: TcxGridLevel;
    Panel5: TPanel;
    Label30: TLabel;
    Label31: TLabel;
    edtRotacaoRoska: TEditFocus;
    edtPicotador: TEditFocus;
    Panel4: TPanel;
    Label32: TLabel;
    RichObservacaoExtrusao: TRichEdit;
    tbsFases: TTabSheet;
    dbgGfaFases: TcxGridCitel;
    dbgGfaFasesView: TcxGridDBTableViewCitel;
    cxGridSeq: TcxGridDBColumn;
    cxGridFase: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    pnlFasesEspecial: TPanel;
    Label37: TLabel;
    Label39: TLabel;
    EdtCodFaseEspecial: TEditFocus;
    EdtDesFaseEspecial: TEditFocus;
    btnConfirmaFaseEspecial: TBitBtnLocked;
    btnCancelaFaseEspecial: TBitBtnLocked;
    EdtSeqFaseEspecial: TEditFocus;
    cxGridCod: TcxGridDBColumn;
    memLogTemp: TFDMemTable;
    memLogTempLGF_CODITE: TStringField;
    memLogTempLGF_CODEMP: TStringField;
    memLogTempLGF_FORMUL: TStringField;
    memLogTempLGF_DTAHRA: TStringField;
    memLogTempLGF_CODOPE: TStringField;
    memLogTempLGF_ITESUB: TStringField;
    memLogTempLGF_INFALT: TStringField;
    memLogTempLGF_VALANT: TStringField;
    memLogTempLGF_VALATU: TStringField;
    memLogTempLGF_CODCOR: TStringField;
    edtOpeUltimaAlteracao: TEditFocus;
    Label33: TLabel;
    procedure edtProdutosKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutosExit(Sender: TObject);

    procedure pCarregaProduto(qryConsulta: TUniQuery);
    procedure pCarregaSubProduto(qryConsulta: TUniQuery);
    procedure pCarregaCor(qryConsulta: TUniQuery);

    procedure edtSubProdutoKeyPress(Sender: TObject; var Key: Char);

    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria(intPosicao: Integer);
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure pLimparDadosSubProduto;
    procedure pLimparDados;
    procedure pHabilitaCampos;
    procedure pDeletaItem;

    function fRetCustoItem(strCodite:String): String;
    function fRetPreVenda1(strCodIte:String): String;
    function fRetPreVenda2(strCodIte:String): String;
    function fRetPreVenda3(strCodIte:String): String;
    function fRetPreVenda4(strCodIte:String): String;
    function fRetPreVenda5(strCodIte:String): String;
    function fRetPreVenda6(strCodIte:String): String;
    function fRetPreVenda7(strCodIte:String): String;
    function fRetSeqGer: String;
    function fRetSeqIte(intSeqGer :  Integer): String;
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnEstruturaClick(Sender: TObject);
    procedure dbgDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnComentarioClick(Sender: TObject);

    function  fCarregaEstrutura: Boolean;
    procedure btnMoveCimaClick(Sender: TObject);
    procedure btnMoveBaixoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnApagaClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edtCorExit(Sender: TObject);
    procedure edtCorKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodFasKeyPress(Sender: TObject; var Key: Char);
    procedure btnSubstituirClick(Sender: TObject);
    procedure cdsConsultaAfterScroll(DataSet: TDataSet);
    procedure lblMostraOpsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnEpiClick(Sender: TObject);
    procedure edtCodAnaKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaAnaliseClick(Sender: TObject);
    procedure btnCancelaAnaliseClick(Sender: TObject);
    procedure dbgAnaliseDblClick(Sender: TObject);
    procedure tbsAnaliseShow(Sender: TObject);
    procedure dbgAnaliseKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPesReaValida(Sender: TObject);
    procedure pgcResultadoAnaliseEnter(Sender: TObject);
    procedure chkForEspClick(Sender: TObject);
    procedure chkForEspKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PageControlEnter(Sender: TObject);
    function frxPaginaJUserFunction(const MethodName: string;
      var Params: Variant): Variant;
    procedure edtRotacaoRoskaExit(Sender: TObject);
    procedure edtRotacaoRoskaKeyPress(Sender: TObject; var Key: Char);
    procedure edtPicotadorExit(Sender: TObject);
    procedure edtPicotadorKeyPress(Sender: TObject; var Key: Char);
    procedure EdCodOpeExtrusaoExit(Sender: TObject);
    procedure EdCodOpeExtrusaoKeyPress(Sender: TObject; var Key: Char);
    procedure cxvExtrusaoEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);
    procedure MskHraFinalExtrusaoKeyPress(Sender: TObject; var Key: Char);
    procedure tbsExtrusaoShow(Sender: TObject);
    procedure MskHraInicioExtrusaoExit(Sender: TObject);
    procedure EdtCodFaseEspecialKeyPress(Sender: TObject; var Key: Char);
    procedure btnCancelaFaseEspecialClick(Sender: TObject);
    procedure btnConfirmaFaseEspecialClick(Sender: TObject);
    procedure dbgGfaFasesViewEditKeyDown(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Word;
      Shift: TShiftState);


  private
    { Private declarations }
    FFecharAoConfirmar:Boolean;
    strNumOps: String;
    strCusIte: String;
    fltDensid: Double;
    strPreVe1: String;
    strPreVe2: String;
    strPreVe3: String;
    strPreVe4: String;
    strPreVe5: String;
    strPreVe6: String;
    strPreVe7: String;
    strSeqGer: String;
    strDescri: String;
    blnInsert: Boolean;
    dtaDtaCad: TDateTime;
    HraHraCad: TDateTime;
    qryConIte: TUniQuery;
    qryConCor: TUniQuery;
    qryConFas: TUniQuery;

    strAutoInc  : String;

    blnTrabalhaComFaseParaFormulasEspeciais: Boolean;

    blnAltera: Boolean;
    strSeqAlt: String;

    intMaxSeqGer : Integer;
    fltTotPercen : Double;
    fltTotCusIte : Double;
    fltTotDensid : Double;

    //Usada somente no relatorio em excel
    strTabPreRel: String;

    //fltTotPer: Double; // total de percentual
    cdsGeiEpi : TZClient;
    blnUsaEpi : Boolean;

    cdsGeiAna : TZClient;

    objLogFormulaAlterada: TLogFormulaAlterada;

    objLiberacao : TLiberacao;

    objFormula     :TFormula;
    objMateriaPrima:TMateriaPrima;
    objCadFaseFormulaEspecial: TCadFaseFormulaEspecial;

    ObjProcessoExtrusao: TObjProcessoExtrusao;

    function  fBuscaEstrutura( blnImportacao: Boolean ): String;
    procedure pCarregaItemAlteracao;

    procedure pAcertaSequencialItem;
    function  fRetDensidadeItem(strCodIte: String): Double;
    function  fInativaFormulas(strCodIte, strCodCor, strFormul: String): Boolean;
    procedure pGeraExcel(blnPreCusRel, blnPreVenRel, blnRefereRel: Boolean; DataSet: TUniClientDataSet);

    function fPreVenTotal(dtsDados: TDataSet): Double;
    function fCustoTotal(dtsDados: TDataSet): Double;
    function fCustoTotalLT(dtsDados: TDataSet): Double;

    Procedure pCarregaOps(blnCarregar: Boolean);

    procedure pGeraPreVen(objExcel: TGeraExcel; blnRefere: Boolean);
    procedure pGeraPreCus(objExcel: TGeraExcel; blnRefere: Boolean);
    procedure pGeraNormal(objExcel: TGeraExcel; blnRefere: Boolean);
    procedure pMontaResumo(Excel: TExcel; Campos: TCampos; Quebra: TRecQuebras);
    procedure pSomaTotaisVen(var Totais: TTotais; Dados: TDataSet);
    procedure pSomaTotaisCus(var Totais: TTotais; Dados: TDataSet);

    function  fRetornaPercentualRepresentacaoCusto(fltCusIte: Double): Double;
    procedure pAtualizaPorcentagemRepresentacaoCusto;
    procedure pTrocarSubstituirProduto;
    procedure pSubstituiOProdutoSelecionado(strCodIte, strDesIte, strRefere: String);

    procedure pCalcularTotaisProdutos;
    procedure pGravaLogFormula(strCodCor, strSeqOld, strCodIte, strIteSub, strForMul,
                               strCodFas, strSequen, strSubQtd, strPerTol: String;
                               strForEsp, strStatus, strOBS001, strOBS002, strOBS003,
                               strOBS004, strOBS005, strOBS006, strOBS007, strPesRea: String;
                               blnDelete: Boolean = False; blnInclusao: Boolean = False;
                               blnInclusaoFormula: Boolean = False; blnMateriaPrima: Boolean = False;
                               blnIncComentario: Boolean = False; strDesCom: String = '');

    function fVerificaPermissaoDelEst: Boolean;
    function fSQLGeiAna: String;
    procedure pCarregaEdicaoAnalise;
    procedure pImagemEpi;
    procedure pLimpaAnalise;
    function fHabilitaEdicao: boolean;
    procedure pFormataResultadoEsperadoAnalise(strTipRes : String);
    procedure pFormataFormulaEspecial;
    procedure pHabilitaChkComponenteAB;
    procedure pCarregaFormulaSubItensRel;
    function fAbreFormulaSubItensRel(strCodIte: String): Boolean;
    procedure pLimparCamposExtrusao;
    procedure pCarregaOperador(strCodOpe: String);
    procedure LimpaObjFormulaAlterada;


  protected
    procedure pAtualizaTotal;

    function fValidaCampos(Sender: TWinControl; blnValidaIndividual: Boolean): Boolean; Override;
    procedure pGravaTemporaria(strSeqIte,
                               strCodIte,
                               strDescri,
                               strCodFas,
                               strDesFas: String;
                               fltQtdIte: Double;
                               fltPerTol: Double;
                               intSeqGer: Integer);
  public
    blnConfirma: Boolean;
    strObs001: String;
    strObs002: String;
    strObs003: String;
    strObs004: String;
    strObs005: String;
    strObs006: String;
    strObs007: String;
    strComent: String;
    blnMPrPAg: Boolean; // Materia Prima e Produto a granel;

    procedure pCarregaFormula(strCodPag, strCodCor, strCodFor : String);
    { Public declarations }
  end;

const
  DEC_PERCENTUAL : Integer = 4;

implementation

uses SysUtils, untfuncoesSimples, untPesqAux, untObsEstrutura, untComentEstrutura,
  untGerMatInd, untOpcRelEstruturaIndustrial, untCfgRel, untConsultas, untSubsProdCadEstrIndus,
  untTypesSistema, untFuncFat, untPanelCxFormula, untPnlDadosFormula,
  untOrdProIndustrial, untCadEstruturasIndustrialEPI,
  OrdemProducaoIndustrial.Funcoes,
  untFuncoesRel, untFuncoesRel2;

{$R *.dfm}


procedure TfrmCadEstruturasIndustrial.edtProdutosKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    if fPesqItem(conIteSimples, Self, edtProdutos, edtDesProduto, qryConIte, Key, arrSel,
                 True, nil, 'Consulta de Itens', '1', '', 0,
                 False, False, 0, cdrCodIte, '', False, '', '', True, False, False, '',
                 False, False, False, True) then
    Begin
      If fValidaCampos(edtProdutos, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;

end;

procedure TfrmCadEstruturasIndustrial.edtRotacaoRoskaExit(Sender: TObject);
begin
  inherited;
  If Not(fValidaCampos(edtRotacaoRoska, True)) Then
    Exit;
end;

procedure TfrmCadEstruturasIndustrial.edtRotacaoRoskaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (Key = #13) Then
    pSetFocus(edtPicotador);
end;

procedure TfrmCadEstruturasIndustrial.edtCodAnaKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqAnalises(Self, edtCodAna, edtDesAna, Nil, Key, arrSel) then
  Begin
    If fValidaCampos(edtCodAna, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEstruturasIndustrial.edtCodFasKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    Try

      If fPesqFases(Self, edtCodFas, edtDesFas, qryConFas, Key, arrSel) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCadEstruturasIndustrial.edtCodFasKeyPress]');
      End;
    End;

  End;

end;

procedure TfrmCadEstruturasIndustrial.edtCorExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtDesCor.Text) And (Not fEmptyStr(edtCor.Text))  Then
  Begin
    fMensagem('AVISO','Cor não encontrada.', ['&O K']);
    edtCor.Clear;
    pSetFocus(edtCor);
  End;

  If ( Not fEmptyStr(edtCor.Text) ) Then
  Begin
    pCarregaCor(qryConCor);
    if edtDataDesenvolvimento.Visible then
    begin
      edtDataDesenvolvimento.Date := VS_Date;
      pSetFocus(edtDataDesenvolvimento);
    end
    else
      pSetFocus(edtCodFormula);
  End;
end;

procedure TfrmCadEstruturasIndustrial.edtCorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCor : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    if fPesqCores(Self, edtCor, edtDesCor, qryConCor, Key, arrCor) then
      if fValidaCampos(edtCor, True) then
        SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadEstruturasIndustrial.edtPesReaValida(Sender: TObject);
begin
  inherited;
  If (cdsConsulta.Active) And (Not cdsConsulta.IsEmpty) Then
  Begin
    pCalcularTotaisProdutos;
    pAtualizaPorcentagemRepresentacaoCusto;
  End;
end;

procedure TfrmCadEstruturasIndustrial.edtPicotadorExit(Sender: TObject);
begin
  inherited;
  If Not(fValidaCampos(edtPicotador, True)) Then
    Exit;
end;

procedure TfrmCadEstruturasIndustrial.edtPicotadorKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If (Key = #13) Then
    pSetFocus(RichObservacaoExtrusao);
end;

procedure TfrmCadEstruturasIndustrial.edtProdutosExit(Sender: TObject);
begin
  inherited;
  If fEmptyStr(edtDesProduto.Text) And (Not fEmptyStr(edtProdutos.Text))  Then
  Begin
    fMensagem('AVISO','Código do Produto não encontrado.', ['&O K']);
    edtProdutos.Clear;
    pSetFocus(edtProdutos);
  End;

  pHabilitaChkComponenteAB;

end;

procedure TfrmCadEstruturasIndustrial.pCarregaProduto(qryConsulta: TUniQuery);
begin
  pPesquisaCadIte(qryConsulta, qryConsulta, edtProdutos.Text, '', False, False, True, False, False, False, True);
  With qryConsulta Do
  Begin
    edtDesProduto.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;
    edtReferencia.Text := qryConsulta.FieldByName('ITE_REFERE').AsString;
    edtUnidade.Text    := qryConsulta.FieldByName('ITE_CODUNI').AsString;
    blnMPrPAg          := fEhMateriaPrimaEProdutoAGranel(qryConsulta.FieldByName('ITE_CODITE').AsString);

  End
end;

procedure TfrmCadEstruturasIndustrial.edtSubProdutoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    Try

      if fPesqItem(conIteSimples, Self, edtSubProduto, edtDesSubProduto, qryConIte, Key, arrSel, True,
                   nil, 'Consulta de Itens', '1',
                  '',0,False,False,0,cdrCodIte,'',False,'','',True,False, False,'',True) then
      Begin
        SelectNext(ActiveControl, True, True);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmCadEstruturasIndustrial.edtSubProdutoKeyPress]');
      End;
    End;

  End;

end;

procedure TfrmCadEstruturasIndustrial.pCarregaSubProduto(qryConsulta: TUniQuery);
begin
  pPesquisaCadIte(qryConsulta, qryConsulta, edtSubProduto.Text, '', False, False, True, False, False, False, False, True);
  With qryConsulta Do
  Begin
    strCusIte := fRetCustoItem(edtSubProduto.Text);
    fltDensid := fRetDensidadeItem(edtSubProduto.Text);
    strPreVe1 := fRetPreVenda1(edtSubProduto.Text);
    strPreVe2 := fRetPreVenda2(edtSubProduto.Text);
    strPreVe3 := fRetPreVenda3(edtSubProduto.Text);
    strPreVe4 := fRetPreVenda4(edtSubProduto.Text);
    strPreVe5 := fRetPreVenda5(edtSubProduto.Text);
    strPreVe6 := fRetPreVenda6(edtSubProduto.Text);
    strPreVe7 := fRetPreVenda7(edtSubProduto.Text);

    edtDesSubProduto.Text := qryConsulta.FieldByName('ITE_DESITE').AsString;
    edtSubReferencia.Text := qryConsulta.FieldByName('ITE_REFERE').AsString;
    edtSubUnidade.Text    := qryConsulta.FieldByName('ITE_CODUNI').AsString;
  End;
end;

procedure TfrmCadEstruturasIndustrial.pDeletaTemporaria;
begin
  If cdsConsulta.Active Then
    cdsConsulta.EmptyDataSet;

  If cdsGeiAna.Active Then
    cdsGeiAna.EmptyDataSet;

  If cdsGeiAna.Active Then
    cdsGeiAna.EmptyDataSet;
end;

procedure TfrmCadEstruturasIndustrial.pAcertaSequencialItem;
Var
  intRecNo : Integer;
  intSeqIte: Integer;
begin

  Try

    With cdsConsulta Do
    Begin
      intRecNo  := RecNo;
      intSeqIte := 0;

      DisableControls;
      First;

      While Not Eof Do
      Begin
        If (FieldByName('DMT_SEQUEN').AsInteger <> RecNo) Then
        Begin
          Edit;
          FieldByName('DMT_SEQUEN').AsInteger := RecNo;
          Post;
        End;

        If (Not fEmptyStr(FieldByName('DMT_SEQITE').AsString)) Then
        Begin
          Inc(intSeqIte);

          Edit;
          FieldByName('DMT_SEQITE').AsString := IntToStr(intSeqIte);
          Post;
        End;

        Next;
      End;

      RecNo := intRecNo;
      EnableControls;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmCadEstruturasIndustrial.pAcertaSequencialItem]');
  End;

end;

procedure TfrmCadEstruturasIndustrial.PageControlEnter(Sender: TObject);
begin
  inherited;
  if PageControl.ActivePage = tbsFormula then
    pSetFocus(edtSubProduto)
  else
    pSetFocus(edtCodAna);
end;

procedure TfrmCadEstruturasIndustrial.pAtualizaPorcentagemRepresentacaoCusto;
var
  fltValor         : Double;
  intRecNo         : Integer;
  objMateriasPrima: TMateriaPrima;
begin
  pCalcularTotaisProdutos;
  intRecNo := 0;
  Try
    intRecNo := cdsConsulta.RecNo;
    cdsConsulta.DisableControls;
    cdsConsulta.First;
    While Not cdsConsulta.Eof Do
    Begin
      If Not fEmptyStr(cdsConsulta.FieldByName('DMT_ITESUB').AsString) Then
      Begin
        cdsConsulta.Edit;

        If edtPesRea.Text <> '' Then
        Begin
          for objMateriasPrima in objFormula.lstMateriasPrimas do
          begin
            If (objMateriasPrima.strCodigo = cdsConsulta.FieldByName('DMT_ITESUB').AsString) And
               (objMateriasPrima.fltPercentualFormula = cdsConsulta.FieldByName('DMT_QTDITE').AsFloat)  Then
            Begin
              cdsConsulta.FieldByName('DMT_CUSCAL').AsFloat := objMateriasPrima.fRetornaCustoProduzidoKilo(1);
              cdsConsulta.FieldByName('DMT_CUS_LT').AsFloat := fConverteLitroParaKilo(fStrToFloat(edtPesRea.Text), cdsConsulta.FieldByName('DMT_CUSCAL').AsFloat);
              break;
            End;
          end;
        End;

        fltValor := fRetornaPercentualRepresentacaoCusto(cdsConsulta.FieldByName('DMT_CUSCAL').AsFloat);
        cdsConsulta.FieldByName('DMT_REPCUS').AsFloat := fFormataFloat(fltValor,2);

        cdsConsulta.Post;
      End;

      cdsConsulta.Next;
    End;
  Finally
    cdsConsulta.EnableControls;
    cdsConsulta.RecNo := intRecNo;
  End;

  pAtualizaTotal

end;


procedure TfrmCadEstruturasIndustrial.pAtualizaTotal;
var
  posicao: integer;
  fltTotCus: Double;
begin

  posicao := cdsConsulta.RecNo;
  cdsConsulta.DisableControls;
  cdsConsulta.First;
  fltTotCus := 0;
  while not cdsConsulta.Eof do
  Begin
     fltTotCus :=  fltTotCus + cdsConsulta.FieldByName('DMT_CUSCAL').AsFloat;
     cdsConsulta.Next;
  End;
  edtTotCus.Text   := FormatFloat('#,##0.0000', fltTotCus);

  cdsConsulta.RecNo :=  posicao;
  cdsConsulta.EnableControls;
end;

procedure TfrmCadEstruturasIndustrial.pAtualizaTemporaria(intPosicao: Integer);
begin
  With cdsConsulta Do
  Begin
    if cdsConsulta.Active then
    begin
      If (RecordCount > 0) And (RecordCount >= intPosicao) Then
        RecNo := intPosicao;

      (FieldByName('DMT_QTDITE') As TFloatField).DisplayFormat := edtSubQtdIte.EditFormat;
      (FieldByName('DMT_PERTOL') As TFloatField).DisplayFormat := edtPerTol.EditFormat;
      (FieldByName('DMT_CUSCAL') As TFloatField).DisplayFormat := '##0.0000';
      (FieldByName('DMT_CUS_LT') As TFloatField).DisplayFormat := '##0.0000';
      (FieldByName('DMT_REPCUS') As TFloatField).DisplayFormat := '##0.00';
    end;
  End;

end;

function TfrmCadEstruturasIndustrial.fValidaCampos(Sender: TWinControl;
  blnValidaIndividual: Boolean): Boolean;
Var
  blnRepEst: Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnValidaIndividual)) Then
  Begin

    If (Sender = edtProdutos) Then
    Begin

      If fEmptyStr(edtProdutos.Text) Then
      Begin
        fMensagem('ATENÇÃO','Digite o código do produto!',['&O K']);
        Result := False;
      End
      Else
      Begin
        pCarregaProduto(qryConIte);
        If qryConIte.FieldByName('ITE_CODITE').IsNull Then
        Begin
          fMensagem('ATENÇÃO','Código do produto não encontrado!',['&O K']);
          Result := False;
        End
        Else
        Begin
          pHabilitaChkComponenteAB;
        End;
      End;
    End
    Else If Sender = edtPesRea Then
    Begin
      If edtPesRea.Text <> '' Then
      Begin
        If fStrToFloat(edtPesRea.Text) <= 0.00 Then
        Begin
          fMensagem('ATENÇÃO','O peso real deve ser maior que zero!',['&O K']);
          Result := False;
        End
        Else
          edtPesReaValida(Sender)
      End
      Else
      Begin
        fMensagem('ATENÇÃO','O peso real deve ser preenchido!',['&O K']);
        Result := False;
      End;
    End
    Else
    If (Sender = edtSubProduto) Then
    Begin

      blnRepEst := fCfgSis('REPEST', varBoolean);

      If (fEmptyStr(edtSubProduto.Text)) Then
      Begin

        If (Not cdsConsulta.IsEmpty) Then
        Begin
          pSetFocus(dbgDados);
          blnMudarFoco := False;
        End
        Else
          Result := False;
      End
      Else If (edtSubProduto.Text = edtProdutos.Text) Then
      Begin
        fMensagem('ATENÇÃO','O Sub. Produto não pode ser igual a Estrutura!',['&OK']);
        Result := False;
      End
      Else If (Not blnRepEst) And (Not blnAltera) And cdsConsulta.Locate('DMT_ITESUB', edtSubProduto.Text, []) Then
      Begin
        fMensagem('ATENÇÃO','Esse item já se encontra na estrutura!',['&O K']);
        Result := False;
      End
      Else
      Begin

        If Not fEmptyStr(edtSubProduto.Text) Then
          pCarregaSubProduto(qryConIte);

        If fEmptyStr(edtDesSubProduto.Text) And (Not fEmptyStr(edtSubProduto.Text))  Then
        Begin
          fMensagem('AVISO','Código do Produto não encontrado.', ['&O K']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtSubQtdIte) Then
    Begin

      If Not fEmptyStr(edtSubProduto.Text) Then
      Begin

        If fEmptyStr(edtSubQtdIte.Text) Then
        Begin
          fMensagem('ATENÇÃO','Digite a quantidade do produto!',['&O K']);
          Result := False;
        End
        Else
        If fStrToFloat(edtSubQtdIte.Text) <= 0.00 Then
        Begin
          fMensagem('ATENÇÃO','A quantidade do produto deve ser maior que Zero !',['&O K']);
          Result := False;
        End;

      End;

    End

    Else If (Sender = edtPerTol) Then
    Begin

      If fEmptyStr(edtPerTol.Text) Then
      Begin
        fMensagem('ATENÇÃO','Digite o % de Tolerância do produto!',['&O K']);
        Result := False;
      End
      Else
      If fStrToFloat(edtPerTol.Text) < 0.00 Then
      Begin
        fMensagem('ATENÇÃO','O % de Tolerância deve ser maior ou igual a Zero !',['&O K']);
        Result := False;
      End;

    End


    Else If (Sender = edtSeq) Then
    Begin
      if (blnAltera) And fEmptyStr(EdtSeq.Text) Then
      Begin
        fMensagem('ATENÇÃO','A Sequência deve ser Preenchida !',['&O K']);
        Result := False;
      End;

      If not fValidaCampos(edtPesRea, True) Then
        Exit(False);

      pCalcularTotaisProdutos;

      if (blnAltera) And ( (StrToIntDef(EdtSeq.Text,0) <= 0) or (StrToIntDef(EdtSeq.Text,0) > intMaxSeqGer)) Then
      Begin
        fMensagem('ATENÇÃO','A Sequência deve estar entre 1 e ' + intToStr(intMaxSeqGer) + ' !',['&O K']);
        Result := False;
      End;



    End

    Else If (Sender = edtCor) Then
    Begin

      If fEmptyStr(edtCor.Text) Then
      Begin
        fMensagem('ATENÇÃO','Digite a Cor!',['&O K']);
        Result := False;
      End
      Else
      Begin
        pCarregaCor(qryConCor);
        If qryConCor.FieldByName('COR_CODCOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO','Código da cor não encontrado!',['&O K']);
          Result := False;
        End;
      End;

      if Result And blnMPrPAg then
      Begin
        if fQuantidadeEstruturasProduto(edtProdutos.Text, edtCor.Text) > 0 then
        Begin
          fMensagem('ATENÇÃO','Só é permitido cadastrar uma Cor para Estruturas de Classificação Matéria Prima e Produto a Granel !',['&O K']);
          Result := False;
        End;

      End;


    End

    Else If (Sender = edtCodFormula) Then
    Begin
      If blnValidaIndividual Then
      Begin
        if fValidaPanel(pnlProdutos) then
        begin
          qryTabela.Close;
          qryTabela.Sql.Clear;
          qryTabela.Sql.Add('SELECT * FROM GEIMAT       ');
          qryTabela.Sql.Add('WHERE GMT_CODITE = :CODITE ');
          qryTabela.Sql.Add('  AND GMT_CODCOR = :CODCOR ');
          qryTabela.Sql.Add('  AND GMT_FORMUL = :CODFOR ');

          qryTabela.ParamByName('CODITE').AsString := edtProdutos.Text;
          qryTabela.ParamByName('CODCOR').AsString := edtCor.Text;
          qryTabela.ParamByName('CODFOR').AsString := edtCodFormula.Text;
          qryTabela.Open;

          If (fCarregaEstrutura) Then
          Begin
            pAtualizaTemporaria(1);

            If fHabilitaEdicao And (cdsConsulta.Active) Then
              pHabilitaCampos;

            SelectNext(ActiveControl, True, True);
            //pSetFocus(edtSubProduto);

            pnlProdutos.Enabled := False;

          End
          Else
            Result := False;
        end;
      end;

    End

    {*****************}
    {* VALIDA A FASE *}
    {**************PZ*}
    Else If (Sender = edtCodFas) Then
    Begin
      If (Not fEmptyStr(edtCodFas.Text)) Then
      Begin
        edtDesFas.Text := fRetDescricaoFase(edtCodFas.Text);

        If (fEmptyStr(edtDesFas.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa Fase não está cadastrada!', ['&O k']);
          Result := False;
        End;
      End
      Else
        edtDesFas.Clear;
    End

    Else If (Sender = edtPesRea) Then
    Begin

      If fStrToFloat(edtPesRea.Text) <= 0 Then
      Begin

        fMensagem('ATENÇÃO!', 'Informe o peso específico real!', ['&O k']);
        Result := False;

      End;

    End

    Else If (Sender = edtCodAna) And blnValidaIndividual Then
    Begin
      If Not fEmptyStr(edtCodAna.Text) Then
      Begin
        edtDesAna.Text := fCampoTabela('ANA_DESCRI', 'CADANA', ['ANA_CODANA'], [edtCodAna.Text]);
        If fEmptyStr(edtDesAna.Text) Then
          Result := fMensagem('', 'Código de Análise Inválido!', ['&OK']) = -1;
      End
      Else
      Begin
        edtCodAna.Clear;
        pSetFocus(dbgAnalise);
        blnMudarFoco := False;
      End;

      pFormataResultadoEsperadoAnalise(fCampoTabela('ANA_TIPRES', 'CADANA', ['ANA_CODANA'], [edtCodAna.Text]));
    End

    Else If (pgcResultadoAnalise.ActivePage = tbsIntervaloValores) and (Sender = edtAnaMin) And blnValidaIndividual Then
    Begin
      If fStrToFloat(edtAnaMin.Text) < 0 Then
      Begin
        Result := fMensagem('', 'O valor mínimo para análise deve ser maior ou igual a zero!', ['&OK']) = -1;
      End;

    End

    Else If (pgcResultadoAnalise.ActivePage = tbsIntervaloValores) and (Sender = edtAnaMax) And blnValidaIndividual Then
    Begin
      If fStrToFloat(edtAnaMax.Text) < 0 Then
      Begin
        Result := fMensagem('', 'O valor máximo para análise deve ser maior ou igual a zero!', ['&OK']) = -1;
      End
      Else
      If fStrToFloat(edtAnaMax.Text) < fStrToFloat(edtAnaMin.Text) Then
        Result := fMensagem('', 'O valor máximo deve ser maior ou igual ao valor mínimo!', ['&OK']) = -1;

    End

    Else If (pgcResultadoAnalise.ActivePage = tbsDescricaoAberta) and (Sender = edtDescricaoResultadoAnalise) And blnValidaIndividual Then
    Begin
      If fEmptyStr(edtDescricaoResultadoAnalise.Text) Then
      Begin
        Result := fMensagem('', 'Preencha a descrição do resultado esperado!', ['&OK']) = -1;
      End;
    End

    Else If (Sender = edtCapacidadeMaxima) and pnlCapacidadeMaxima.Visible Then
    Begin

      If fEmptyStr(edtCapacidadeMaxima.Text) or (fStrToFloat(edtCapacidadeMaxima.Text) < 0.00) Then
      Begin
        edtCapacidadeMaxima.Text := FormatFloat(fMskDigitos(2), 0);
        fMensagem('ATENÇÃO','A capacidade máxima de produção deve ser maior ou igual a zero!',['&O K']);
        Result := False;
      End;

    End;

    If (fCfgSis('EXMOPI', varBoolean)) And  (PageControl.ActivePage = TbsExtrusao) Then
    Begin

      If (Sender = EdCodOpeExtrusao) Then
      Begin
        If Not(fEmptyStr(EdCodOpeExtrusao.Text)) Then
        Begin

          pCarregaOperador(EdCodOpeExtrusao.Text);

          If fEmptyStr(EdtOpeNomeExtrusao.Text) Then
          Begin
            pMensagemOk('Operador da aba Proc. Extrusão inválido!');
            Result:= False;
            Exit;
          End

        End

      End

      Else

      If (Sender = MskHraInicioExtrusao) Then
      Begin
        If Not(fEmptyTime(MskHraInicioExtrusao.Text)) Then
        Begin
          If StrToTimeDef(MskHraInicioExtrusao.Text, -1) < 0 Then
          Begin
            pMensagemOk('Hora de Inicio da Extrusão inválida');
            Result := False;
            Exit;
          End;
        End;

      End

      Else

      If (Sender = MskHraFinalExtrusao) Then
      Begin
        If Not(fEmptyTime(MskHraFinalExtrusao.Text)) Then
        Begin

          If StrToTimeDef(MskHraFinalExtrusao.Text, -1) < 0 Then
          Begin
            pMensagemOk('Hora de Finalização da Extrusão inválida');
            Result := False;
            Exit
          End

        End


        Else

        If Not(fEmptyTime(MskHraFinalExtrusao.Text)) And
          Not(fEmptyTime(MskHraInicioExtrusao.Text)) Then
        Begin

          If StrToDateDef(edtDtaCad.Text, 0) + StrToTimeDef(MskHraFinalExtrusao.Text, 0) <=
             StrToDateDef(edtDtaCad.Text, 0) + StrToTimeDef(MskHraInicioExtrusao.Text, 0) Then
          Begin
            pMensagemOk('A Finalização da Extrusão deve ser maior que o Inicio da Extrusão!');
            Result:= False;
            Exit;
          End;

        End

      End

    End
    {**********************************}
    {* VALIDA A FASE FORMULA ESPECIAL*}
    {**************PZ******************}
    Else  If blnTrabalhaComFaseParaFormulasEspeciais Then
    Begin

      If (Sender = EdtCodFaseEspecial) Then
      Begin

        If (fEmptyStr(EdtCodFaseEspecial.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Fase deve ser preenchida!', ['&O k']);
          Result := False;
          Exit;
        End Else
        Begin
          EdtDesFaseEspecial.Text := fRetDescricaoFase(EdtCodFaseEspecial.Text);

          If (fEmptyStr(EdtDesFaseEspecial.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa Fase não está cadastrada!', ['&O k']);
            Result := False;
            Exit;
          End;
        End

      End

      Else If (Sender = EdtSeqFaseEspecial) Then
      Begin

        If fEmptyStr(EdtSeqFaseEspecial.Text) Then
        Begin
          If (fEmptyStr(EdtSeqFaseEspecial.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Sequência Geral: deve ser informada!', ['&O k']);
            Result := False;
            Exit;
          End;
        End

      End


    End

  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadEstruturasIndustrial.FormCreate(Sender: TObject);
  Var
    intIndex : Integer;
begin
  inherited;

  FFecharAoConfirmar := False;
  qryTabela := fCriarQuery('SELECT * FROM GEIMAT WHERE FALSE');
  objLiberacao := TLiberacao.Create;

  If fCfgSis('FASESP', varBoolean) Then
  Begin
    objCadFaseFormulaEspecial:= TCadFaseFormulaEspecial.Create;
    objCadFaseFormulaEspecial.pCarregaFaseFormulaEspecial;
    dbgGfaFasesView.DataController.DataSource := objCadFaseFormulaEspecial.dtsFaseEspecial;
  End;

  PageControl.ActivePageIndex := 0;

  dbgDados.Refresh;
  pnlProdutos.Enabled    := True;
  pnlCapacidadeMaxima.Enabled := False;
  pnlSubProdutos.Enabled := False;
  dbgDados.Enabled       := False;
  pnlAnalises.Enabled    := False;
  dbgAnalise.Enabled     := False;
  btnConfirma.Enabled    := False;
  btnImprimir.Enabled    := False;
  btnApaga.Enabled       := False;
  btnEstrutura.Enabled   := True;
  btnComentario.Enabled  := False;
  btnMoveCima.Enabled    := False;
  btnMoveBaixo.Enabled   := False;
  btnSubstituir.Enabled  := False;
  pnlFasesEspecial.Enabled := False;

  //fltTotPer := 0;

  edtSubQtdIte.EditFormat := fMskDigitos(DEC_PERCENTUAL);
  edtSubQtdIte.Text       := FormatFloat(edtSubQtdIte.EditFormat, 0);

  edtPerTol.EditFormat := fMskDigitos(DEC_PERCENTUAL);
  edtPerTol.Text       := FormatFloat(edtPerTol.EditFormat, 0);

  blnUsaEpi := (fCfgSis('MDORIN', varString) = '6');
  btnEpi.Visible := blnUsaEpi;

  chkForEsp.Visible := fCfgSis('FORESP', varBoolean);
  pnlCapacidadeMaxima.Visible := fCfgSis('CAPMAX', varBoolean);

  edtDataDesenvolvimento.Visible := fCfgSis('DTAFOR', varBoolean);
  lblDataDesenvolvimento.Visible := edtDataDesenvolvimento.Visible;

  cdsGeiEpi := TZClient.Create(Self, 'SELECT * FROM GEIEPI WHERE GEP_SEQGMT = :SEQGMT ');

  //Analise
  cdsGeiAna := TZClient.Create(Self, fSQLGeiAna);
  dbgAnalise.DataSource := cdsGeiAna.dtsSource;

  pDeletaTemporaria;
  pCalcularTotaisProdutos;

  objLogFormulaAlterada:= TLogFormulaAlterada.Create;

  //pCarregaOps(False);

  pnlCusLT.Visible := (fCfgSis('CUSCAD', varInteger) = 2);
  If pnlCusLT.Visible Then
  Begin
    lblTotCusKG.Caption := 'Total Custo (KG)';

    For intIndex := 0 to dbgDados.Columns.Count -1 Do
    Begin
      If dbgDados.Columns[intIndex].FieldName = 'DMT_CUSCAL' Then
        dbgDados.Columns[intIndex].Title.Caption := 'Custo (KG)'
      Else If dbgDados.Columns[intIndex].FieldName = 'DMT_CUS_LT' Then
        dbgDados.Columns[intIndex].Visible := True;
    End;
  End;

  objFormula     := TFormula.Create;
  objMateriaPrima:= TMateriaPrima.Create;

  tbsExtrusao.TabVisible := fCfgSis('EXMOPI', varBoolean);
  If fCfgSis('EXMOPI', varBoolean) Then
  Begin
    ObjProcessoExtrusao:= TObjProcessoExtrusao.Create('GEIEXT');
    cxvExtrusao.DataController.DataSource:= ObjProcessoExtrusao.fRetornaDataSourceProcessosExtrusao(True);
  End;


end;

Function TfrmCadEstruturasIndustrial.fSQLGeiAna : String;
Begin
  Result := '';
  Result := Result + ' SELECT G.*, ANA_DESCRI, ANA_TIPRES,                       ';
  Result := Result + ' REPLACE( CASE ANA_TIPRES                                   ';
  Result := Result + '   WHEN 1 THEN CONCAT(  CAST(GAN_LIMMIN AS DECIMAL(12,2))  ';
  Result := Result + '                      , " a "                              ';
  Result := Result + '                      , CAST(GAN_LIMMAX AS DECIMAL(12,2))) ';
  Result := Result + '   WHEN 2 THEN GAN_DESRES                                  ';
  Result := Result + ' END,".",",") AS RESULTADOESPERADO                         ';
  Result := Result + ' FROM GEIANA G                                             ';
  Result := Result + '   INNER JOIN CADANA ON ANA_CODANA = GAN_CODANA            ';
  Result := Result + ' WHERE G.GAN_SEQGMT = :SEQGMT                              ';
End;

procedure TfrmCadEstruturasIndustrial.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryTabela);
  FreeAndNil(cdsGeiAna);
  FreeAndNil(cdsGeiEpi);
  FreeAndNil(objLiberacao);
  FreeAndNil(objLogFormulaAlterada);

  If objCadFaseFormulaEspecial <> Nil Then
    FreeAndNil(objCadFaseFormulaEspecial);

  If fCfgSis('EXMOPI', varBoolean) Then
    FreeAndNil(ObjProcessoExtrusao);

  inherited;
end;

procedure TfrmCadEstruturasIndustrial.btnConfirmaAnaliseClick(Sender: TObject);
begin
  inherited;
  If not fValidaPanel(pnlAnalises, True) Then
    Exit;

  If not fValidaCampos(edtDescricaoResultadoAnalise, True) Then
    Exit;


  If cdsGeiAna.Locate('GAN_CODANA', edtCodAna.Text, []) Then
    cdsGeiAna.Edit
  Else
    cdsGeiAna.Append;

  cdsGeiAna.FieldByName('GAN_CODANA').AsString := edtCodAna.Text;
  cdsGeiAna.FieldByName('ANA_DESCRI').AsString := edtDesAna.Text;
  cdsGeiAna.FieldByName('GAN_LIMMIN').AsFloat  := fStrToFloat(edtAnaMin.Text);
  cdsGeiAna.FieldByName('GAN_LIMMAX').AsFloat  := fStrToFloat(edtAnaMax.Text);
  cdsGeiAna.FieldByName('GAN_DESRES').AsString := edtDescricaoResultadoAnalise.Text;

  If (ChkComponenteAB.Visible) Then
  Begin
    If ChkComponenteAB.Checked Then
      cdsGeiAna.FieldByName('GAN_INFOAB').AsString :=  'AB'
    Else
      cdsGeiAna.FieldByName('GAN_INFOAB').AsString :=  'A';
  End;


  If pgcResultadoAnalise.ActivePage = tbsIntervaloValores then
    cdsGeiAna.FieldByName('RESULTADOESPERADO').AsString :=   FormatFloat('#,##0.00', cdsGeiAna.FieldByName('GAN_LIMMIN').AsFloat)
                                                           + ' a '
                                                           + FormatFloat('#,##0.00', cdsGeiAna.FieldByName('GAN_LIMMAX').AsFloat)
  else
    cdsGeiAna.FieldByName('RESULTADOESPERADO').AsString := cdsGeiAna.FieldByName('GAN_DESRES').AsString;

  cdsGeiAna.Post;

  pLimpaAnalise;
end;

procedure TfrmCadEstruturasIndustrial.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaCampos Then
  Begin
    //pSetFocus(edtSubProduto);
    Exit;
  End;

  pCalcularTotaisProdutos;

  pGravaTemporaria(fRetSeqIte(StrToIntDef(edtSeq.text,0)), edtSubProduto.Text, edtDesSubProduto.Text, edtCodFas.Text, edtDesFas.Text, fStrToFloat( edtSubQtdIte.Text ), fStrToFloat( edtPerTol.Text ), StrToIntDef(edtSeq.Text, 0));
  pLimparDadosSubProduto;

  pSetFocus(edtSubProduto);
  btnConfirma.Enabled   := True;
  btnImprimir.Enabled   := True;
  btnComentario.Enabled := True;

  If (cdsConsulta.RecordCount > 1) Then
  Begin
    btnMoveCima.Enabled  := True;
    btnMoveBaixo.Enabled := True;
  End;

  blnAltera := False;
  strSeqAlt := '';
end;

function TfrmCadEstruturasIndustrial.fPreVenTotal(dtsDados: TDataSet): Double;
begin
  Result := dtsDados.FieldByName('DMT_QTDITE').AsFloat *
            dtsDados.FieldByName('ITE_PREVE' + strTabPreRel).AsFloat;
end;

function TfrmCadEstruturasIndustrial.fCustoTotal(dtsDados: TDataSet): Double;
begin
  Result := fRetornaValorArredondado(dtsDados.FieldByName('DMT_QTDITE').AsFloat *
            dtsDados.FieldByName('ITE_PRECUS').AsFloat / 100);
end;

function TfrmCadEstruturasIndustrial.fCustoTotalLT(dtsDados: TDataSet): Double;
Begin
  Result := (fRetornaValorArredondado(dtsDados.FieldByName('DMT_QTDITE').AsFloat *
             dtsDados.FieldByName('ITE_PRECUS').AsFloat / 100) * fStrToFloat(edtPesRea.Text));
End;

procedure TfrmCadEstruturasIndustrial.pGeraExcel(blnPreCusRel, blnPreVenRel,
  blnRefereRel: Boolean; DataSet: TUniClientDataSet);
var
  objExcel: TGeraExcel;
begin
  Try
    objExcel := TGeraExcel.Create(DataSet, nil);

    If blnPreVenRel Then
    Begin
      pGeraPreVen(objExcel,blnRefereRel);
      objExcel.OnSomaResumo  := pSomaTotaisVen;
    End
    Else If blnPreCusRel Then
    Begin
      pGeraPreCus(objExcel,blnRefereRel);
      objExcel.OnSomaResumo  := pSomaTotaisCus;
    End  
    Else
      pGeraNormal(objExcel,blnRefereRel);

    objExcel.strNomRel := 'CHECK LIST EXPEDIÇÃO';
    objExcel.AddFiltro('ESTRUTURA: ' + edtDesProduto.Text);
    objExcel.AddFiltro('STATUS: ' + IIF(rdgStatus.ItemIndex = 0,'ATIVA','INATIVA'));

    If blnPreVenRel Or blnPreCusRel Then
      objExcel.OnMontaResumo := pMontaResumo;

    objExcel.fGerarRelatorio;
  Finally
    FreeAndNil(objExcel);
  End;
end;

procedure TfrmCadEstruturasIndustrial.pGeraNormal(objExcel: TGeraExcel;
  blnRefere: Boolean);
begin
  objExcel.AddCampo('DMT_QTDITE', 'QTD', DEC_PERCENTUAL);
  If blnRefere Then
    objExcel.AddCampo('DMT_REFERE', 'ITEM')
  Else
    objExcel.AddCampo('DMT_DESCRI', 'ITEM');
  objExcel.AddCampo('FAS_DESFAS', 'FASE');
end;

procedure TfrmCadEstruturasIndustrial.pGeraPreCus(objExcel: TGeraExcel;
  blnRefere: Boolean);
begin
  If blnRefere Then
    objExcel.AddCampo('DMT_REFERE', 'ITEM')
  Else
    objExcel.AddCampo('DMT_DESCRI', 'ITEM');
  objExcel.AddCampo('FAS_DESFAS', 'FASE');
  objExcel.AddCampo('DMT_QTDITE', 'QTD. ITEM', DEC_PERCENTUAL);
  objExcel.AddCampo('ITE_PRECUS', 'CUS. ITEM');

  If pnlCusLT.Visible Then
  Begin
    objExcel.AddCampo(fCustoTotal, 'CUSTO_TOTAL', 'CUS. TOTAL (KG)', 4);
    objExcel.AddCampo(fCustoTotalLT, 'CUSTO_TOTAL_LT', 'CUS. TOTAL (LT)', 4);
  End
  Else
    objExcel.AddCampo(fCustoTotal, 'CUSTO_TOTAL', 'CUS. TOTAL', 4);

  objExcel.AddCampo('ITE_PREMED', 'VLR. MEDIO');
  objExcel.AddCampo('ITE_DTAULT', 'ULT. COMPRA');
end;

procedure TfrmCadEstruturasIndustrial.pGeraPreVen(objExcel: TGeraExcel; blnRefere: Boolean);
begin
  If blnRefere Then
    objExcel.AddCampo('DMT_REFERE', 'ITEM')
  Else
    objExcel.AddCampo('DMT_DESCRI', 'ITEM');
  objExcel.AddCampo('FAS_DESFAS', 'FASE');
  objExcel.AddCampo('DMT_QTDITE', 'QTD', DEC_PERCENTUAL);
  objExcel.AddCampo('ITE_PREVE' + strTabPreRel, 'VLR. ITEM');
  objExcel.AddCampo(fPreVenTotal, 'VENDA_TOTAL', 'VLR. TOTAL');
end;

procedure TfrmCadEstruturasIndustrial.pGravaTemporaria(strSeqIte,
                                                       strCodIte,
                                                       strDescri,
                                                       strCodFas,
                                                       strDesFas: String;
                                                       fltQtdIte: Double;
                                                       fltPerTol: Double;
                                                       intSeqGer: Integer);
  Var
    intSequen: Integer;
    intRecNo : Integer;
    intNewIte: Integer;
    blnSeqIte: Boolean;
    strSeqOld: String;
    objTMateriaPrima: TMateriaPrima;
begin

  intNewIte := 0;

  If fEmptyStr(strCusIte) Then
    strCusIte := '0.00';

  If fEmptyStr(strPreVe1) Then
    strPreVe1 := '0.00';

  If fEmptyStr(strPreVe2) Then
    strPreVe2 := '0.00';

  If fEmptyStr(strPreVe3) Then
    strPreVe3 := '0.00';

  If fEmptyStr(strPreVe4) Then
    strPreVe4 := '0.00';

  If fEmptyStr(strPreVe5) Then
    strPreVe5 := '0.00';

  If fEmptyStr(strPreVe6) Then
    strPreVe6 := '0.00';

  If fEmptyStr(strPreVe7) Then
    strPreVe7 := '0.00';

  If (Not blnAltera) Then
  Begin
    With cdsConsulta Do
    Begin
      if (intSeqGer <= 0) Then
        intSequen := StrToIntDef(fRetSeqGer, 1)
      Else
        intSequen := intSeqGer;

      if (intSeqGer > 0) Then
      Begin
        //Avança os Itens Apos o intPos
        DisableControls;
        Last;
        While (FieldByName('DMT_SEQUEN').AsInteger >= intSequen) and (not Bof) Do
        Begin
          Edit;

          FieldByName('DMT_SEQUEN').AsInteger := FieldByName('DMT_SEQUEN').AsInteger + 1;
          If (StrToIntDef(FieldByName('DMT_SEQITE').AsString,0) > 0) and (not fEmptyStr(strSeqIte)) Then
          begin
            strSeqIte := FieldByName('DMT_SEQITE').AsString;
            FieldByName('DMT_SEQITE').AsInteger  := FieldByName('DMT_SEQITE').AsInteger + 1;
          end;

          Post;
          Prior;
        End;
        EnableControls;

      End;

      Insert;
      FieldByName('DMT_ITESUB').AsString  := strCodIte;
      FieldByName('DMT_SEQUEN').AsInteger := intSequen;
      FieldByName('DMT_SEQITE').AsString  := strSeqIte;
      FieldByName('DMT_CODEMP').AsString  := VS_strCodEmp;
      FieldByName('DMT_QTDITE').AsFloat   := fltQtdIte;
      FieldByName('DMT_PERTOL').AsFloat   := fltPerTol;
      FieldByName('DMT_CUSITE').AsFloat   := fStrToFloat(strCusIte);
      FieldByName('DMT_CUSCAL').AsFloat   := fFormataFloat(((fStrToFloat(strCusIte) * fltQtdIte)/100),4);
      FieldByName('DMT_CUS_LT').AsFloat   := fFormataFloat(((fStrToFloat(strCusIte) * fltQtdIte)/100) * fStrToFloat(edtPesRea.Text),4);
      FieldByName('DMT_DENSID').AsFloat   := fltDensid;
      FieldByName('ITE_PREVE1').AsFloat   := fStrToFloat(strPreVe1);
      FieldByName('ITE_PREVE2').AsFloat   := fStrToFloat(strPreVe2);
      FieldByName('ITE_PREVE3').AsFloat   := fStrToFloat(strPreVe3);
      FieldByName('ITE_PREVE4').AsFloat   := fStrToFloat(strPreVe4);
      FieldByName('ITE_PREVE5').AsFloat   := fStrToFloat(strPreVe5);
      FieldByName('ITE_PREVE6').AsFloat   := fStrToFloat(strPreVe6);
      FieldByName('ITE_PREVE7').AsFloat   := fStrToFloat(strPreVe7);
      FieldByName('DMT_SEQGER').AsInteger := 1;

      If Not fEmptyStr(strCodIte) Then
        FieldByName('DMT_DESCRI').AsString  := edtDesSubProduto.Text
      Else
        FieldByName('DMT_DESCRI').AsString  := strDescri;

      FieldByName('DMT_REFERE').AsString  := edtSubReferencia.Text;

      FieldByName('DMT_CODFAS').AsString  := strCodFas;
      FieldByName('FAS_DESFAS').AsString  := strDesFas;

      Post;


      If not fEmptyStr(edtCodFormula.Text) Then
      Begin
        strSeqOld:= FieldByName('DMT_SEQUEN').AsString;

        pGravaLogFormula(edtCor.Text,
                         FieldByName('DMT_SEQUEN').AsString,
                         edtProdutos.Text,
                         FieldByName('DMT_ITESUB').AsString,
                         edtCodFormula.Text,
                         FieldByName('DMT_CODFAS').AsString,
                         FieldByName('DMT_SEQUEN').AsString,
                         FormatFloat(edtSubQtdIte.EditFormat, FieldByName('DMT_QTDITE').AsFloat),
                         FormatFloat(edtPerTol.EditFormat, FieldByName('DMT_PERTOL').AsFloat),
                         '','','','','','','','', '','',
                         False, True, False, True, False, FieldByName('DMT_DESCRI').AsString);
      End
      Else
        objLogFormulaAlterada.cdsDataSet       := cdsConsulta;

      objMateriaPrima := TMateriaPrima.Create;
      objMateriaPrima.strCodigo           := cdsConsulta.FieldByName('DMT_ITESUB').AsString;
      objMateriaPrima.strDescricao        := cdsConsulta.FieldByName('DMT_DESCRI').AsString;
      objMateriaPrima.fltPercentualFormula:= cdsConsulta.FieldByName('DMT_QTDITE').AsFloat;
      objMateriaPrima.fltCusto            := cdsConsulta.FieldByName('DMT_CUSITE').AsFloat;
      objFormula.lstMateriasPrimas.Add(objMateriaPrima);

      pAtualizaPorcentagemRepresentacaoCusto;


      objLogFormulaAlterada.pIncluiSequenciaOriginalMateriaPrima(cdsConsulta.FieldByName('AUTOINCREM').AsString,
                                                                 cdsConsulta.FieldByName('DMT_ITESUB').AsString,
                                                                 cdsConsulta.FieldByName('DMT_SEQUEN').AsString,
                                                                 cdsConsulta.FieldByName('DMT_SEQITE').AsString);

    End;
  End
  Else
  Begin
    pCalcularTotaisProdutos;

    if (intSeqGer <= 0) or (intSeqGer > intMaxSeqGer) Then
    Begin
      fMensagem('ATENÇÃO','A Sequência deve estar entre 1 e ' + intToStr(intMaxSeqGer) + ' !',['&O K']);
      Abort;
    End;

    cdsConsulta.IndexFieldNames := '';
    If (cdsConsulta.Locate('DMT_SEQUEN', strSeqAlt, [])) Then
    Begin
      blnSeqIte := not fEmptyStr(cdsConsulta.FieldByName('DMT_SEQITE').AsString); // So Organiza Seq. Materia Prima se movimentar a Seq. de Materia Prima, se não mantem ordem.
      With cdsConsulta Do
      Begin

        strSeqOld:= cdsConsulta.FieldByName('DMT_SEQUEN').AsString;

        If not fEmptyStr(edtCodFormula.Text) Then
        Begin
          if (intSeqGer > 0) and (intSeqGer <> StrToIntDef(strSeqAlt,0)) Then
          Begin
            If Not(fEmptyStr(edtSubProduto.Text)) Then
              pGravaLogFormula(edtCor.Text,strSeqOld, edtProdutos.Text, edtSubProduto.Text, edtCodFormula.Text,
                               edtCodFas.Text, intToStr(intSeqGer), edtSubQtdIte.Text, edtPerTol.Text,
                               '','','','','','','','','','', False, False, False, True, False);
          End
          Else
          Begin
            If Not(fEmptyStr(edtSubProduto.Text)) Then
              pGravaLogFormula(edtCor.Text,strSeqOld, edtProdutos.Text, edtSubProduto.Text, edtCodFormula.Text,
                               edtCodFas.Text, edtSeq.Text, edtSubQtdIte.Text, edtPerTol.Text,
                               '','','','','','','','','','', False, False, False, True, False);
          End;
        End;

        if (intSeqGer > 0) and (intSeqGer <> StrToIntDef(strSeqAlt,0)) Then
        Begin

          DisableControls;
          intNewIte := 1;
          intRecNo := RecNo;
          First;

          if intSeqGer < StrToIntDef(strSeqAlt,0) Then
          Begin
            While (not Eof) Do
            Begin
              If (FieldByName('DMT_SEQUEN').AsInteger >= intSeqGer)
                 and (FieldByName('DMT_SEQUEN').AsInteger < StrToIntDef(strSeqAlt,0)) Then
              Begin
                Edit;
                FieldByName('DMT_SEQUEN').AsInteger := FieldByName('DMT_SEQUEN').AsInteger + 1;

                if blnSeqIte and (not fEmptyStr(FieldByName('DMT_SEQITE').AsString)) Then
                  FieldByName('DMT_SEQITE').AsInteger := FieldByName('DMT_SEQITE').AsInteger + 1;
                Post;

              End
              Else
                If (FieldByName('DMT_SEQUEN').AsInteger <= intSeqGer)
                   And (not fEmptyStr(FieldByName('DMT_SEQITE').AsString)) Then
                  intNewIte := FieldByName('DMT_SEQITE').AsInteger + 1;

              Next;
            End;

          End
          else
          begin
            While (Not Eof) Do
            Begin
              If (FieldByName('DMT_SEQUEN').AsInteger <= intSeqGer)
                 and (FieldByName('DMT_SEQUEN').AsInteger >= StrToIntDef(strSeqAlt,0)) Then
              Begin
                Edit;
                FieldByName('DMT_SEQUEN').AsInteger := FieldByName('DMT_SEQUEN').AsInteger - 1;

                if blnSeqIte and (not fEmptyStr(FieldByName('DMT_SEQITE').AsString)) Then
                  FieldByName('DMT_SEQITE').AsInteger := FieldByName('DMT_SEQITE').AsInteger - 1;
                Post;

                if (not fEmptyStr(FieldByName('DMT_SEQITE').AsString)) Then
                  intNewIte := FieldByName('DMT_SEQITE').AsInteger + 1;

              End;

              Next;
            End;

          End;
          RecNo := intRecNo;
          EnableControls;
        end;

        cdsConsulta.Edit;

        if (intSeqGer > 0) And (intSeqGer <> StrToIntDef(strSeqAlt,0)) Then
        Begin
          cdsConsulta.FieldByName('DMT_SEQUEN').AsInteger := intSeqGer;
          If not fEmptyStr(cdsConsulta.FieldByName('DMT_SEQITE').AsString) Then
            cdsConsulta.FieldByName('DMT_SEQITE').AsInteger := intNewIte;
        End;

        cdsConsulta.FieldByName('DMT_DESCRI').AsString  := strDescri;
        cdsConsulta.FieldByName('DMT_QTDITE').AsFloat  := fltQtdIte;
        cdsConsulta.FieldByName('DMT_PERTOL').AsFloat  := fltPerTol;
        cdsConsulta.FieldByName('DMT_DENSID').AsFloat  := fltDensid;
        cdsConsulta.FieldByName('DMT_CODFAS').AsString := strCodFas;
        cdsConsulta.FieldByName('FAS_DESFAS').AsString := strDesFas;
        cdsConsulta.FieldByName('DMT_CUSCAL').AsFloat  := fFormataFloat(((fStrToFloat(strCusIte) * fltQtdIte)/100),4);
        cdsConsulta.FieldByName('DMT_CUS_LT').AsFloat   := fFormataFloat(((fStrToFloat(strCusIte) * fltQtdIte)/100) * fStrToFloat(edtPesRea.Text),4);
        cdsConsulta.Post;

        for objTMateriaPrima in objFormula.lstMateriasPrimas do
        begin
          If (objTMateriaPrima.strCodigo = cdsConsulta.FieldByName('DMT_ITESUB').AsString) Then
          Begin
            objTMateriaPrima.fltPercentualFormula:= cdsConsulta.FieldByName('DMT_QTDITE').AsFloat;
            break;
          End;
        end;


        pAtualizaPorcentagemRepresentacaoCusto;

      End;
    End;
    cdsConsulta.IndexFieldNames := 'DMT_SEQUEN';
    cdsConsulta.Locate('DMT_SEQUEN', intSeqGer, []);

  End;

  cdsConsulta.AggregatesActive := False;
  cdsConsulta.AggregatesActive := True;  

end;

procedure TfrmCadEstruturasIndustrial.pLimparCamposExtrusao;
begin
  EdCodOpeExtrusao.Text:= '';
  MskHraInicioExtrusao.Text:= '';
  MskHraFinalExtrusao.Text:= '';
  edtRotacaoRoska.Text:= '';
  edtPicotador.Text:= '';
  EdtOpeNomeExtrusao.Text:= '';
  RichObservacaoExtrusao.Clear;
end;


procedure TfrmCadEstruturasIndustrial.pLimparDados;
begin
  strSeqGer                   := '';
  edtCapacidadeMaxima.Text    := FormatFloat(fMskDigitos(2), 0);
  chkForEsp.Checked           := False;
  edtDtaCad.Clear;
  edtDtaAlt.Clear;
  edtDataDesenvolvimento.Clear;
  edtOpeUltimaAlteracao.Clear;

  dbgDados.Refresh;
  pnlProdutos.Enabled         := True;
  pnlCapacidadeMaxima.Enabled := False;
  pnlSubProdutos.Enabled      := False;
  pnlFasesEspecial.Enabled    := False;
  pnlAnalises.Enabled         := False;
  dbgAnalise.Enabled          := False;
  edtProdutos.ReadOnly        := False;
  edtProdutos.Clear;
  edtReferencia.Clear;
  edtUnidade.Clear;
  edtDesProduto.Clear;
  edtCor.ReadOnly             := False;
  edtCor.Clear;
  edtDesCor.Clear;
  edtCodFormula.ReadOnly      := False;
  edtCodFormula.Clear;

  edtPesRea.ReadOnly          := False;
  edtPesRea.Clear;

  dbgDados.Enabled            := False;
  btnConfirma.Enabled         := False;
  btnApaga.Enabled            := False;
  btnImprimir.Enabled         := False;
  btnEstrutura.Enabled        := True;
  btnComentario.Enabled       := False;
  btnMoveCima.Enabled         := False;
  btnMoveBaixo.Enabled        := False;
  btnSubstituir.Enabled       := False;

  rdgStatus.ItemIndex         := 1;
  PageControl.ActivePageIndex := 0;

  strObs001                   := '';
  strObs002                   := '';
  strObs003                   := '';
  strObs004                   := '';
  strObs005                   := '';
  strObs006                   := '';
  strObs007                   := '';
  blnInsert                   := False;
  RichDescProcProducao.Clear;

  pLimparDadosSubProduto;
  pDeletaTemporaria;
  pCalcularTotaisProdutos;
  pFormataFormulaEspecial;
  LimpaObjFormulaAlterada;

  If fCfgSis('EXMOPI', varBoolean) Then
  Begin
    pLimparCamposExtrusao;
    cxvExtrusao.DataController.DataSource:= ObjProcessoExtrusao.fRetornaDataSourceProcessosExtrusao(True);
  End;

  If fCfgSis('FASESP', varBoolean) Then
  Begin
    If objCadFaseFormulaEspecial <> Nil Then
      objCadFaseFormulaEspecial:= Nil;
    objCadFaseFormulaEspecial:= TCadFaseFormulaEspecial.Create;
    objCadFaseFormulaEspecial.pCarregaFaseFormulaEspecial;
    dbgGfaFasesView.DataController.DataSource := objCadFaseFormulaEspecial.dtsFaseEspecial;
  End;

  ChkComponenteAB.Visible:= False;

  objFormula.Clear;
  pSetFocus(edtProdutos);
end;

procedure TfrmCadEstruturasIndustrial.pLimparDadosSubProduto;
begin
  edtSubProduto.Clear;
  edtDesSubProduto.Clear;
  edtSubReferencia.Clear;
  edtSubUnidade.Clear;
  edtCodFas.Clear;
  edtDesFas.Clear;
  edtSubQtdIte.Text := FormatFloat(edtSubQtdIte.EditFormat, 0);
  edtPerTol.Text    := FormatFloat(edtSubQtdIte.EditFormat, 0);
  edtSeq.Text       := '';
  edtSubProduto.Enabled := True;
  blnAltera := False;
end;

procedure TfrmCadEstruturasIndustrial.pMontaResumo(Excel: TExcel;
  Campos: TCampos; Quebra: TRecQuebras);
begin
  With Excel Do
  Begin
    Escrever(ProximaLinha, 04, 'TOTAL GERAL');
    Alinhamento(LinhaAtual, 04, Direita);

    Escrever(LinhaAtual,   05, Quebra.Totais['fltTotPro']);
    If pnlCusLT.Visible Then
      Escrever(LinhaAtual,   06, Quebra.Totais['fltTotProLT']);

    FormatoNumerico(LinhaAtual, 05, '#.##0,0000');
    FormatoNumerico(LinhaAtual, 06, '#.##0,0000');

    Negrito    ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), True);
    CorFundo   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Amarelo);
    CorFonte   ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual), Azul);
    Bordas     ('A' + IntToStr(LinhaAtual), fGetLetraAlfa(Campos.Colunas.Count) + IntToStr(LinhaAtual));
  End;
end;

procedure TfrmCadEstruturasIndustrial.pSomaTotaisCus(var Totais: TTotais;
  Dados: TDataSet);
begin
  With Dados Do
  Begin
    Totais['fltTotPro'] := Totais['fltTotPro'] + fRetornaValorArredondado((FieldByName('DMT_QTDITE').AsFloat * FieldByName('ITE_PRECUS').AsFloat / 100));
    Totais['fltTotProLT'] := Totais['fltTotProLT'] + fRetornaValorArredondado(((FieldByName('DMT_QTDITE').AsFloat * FieldByName('ITE_PRECUS').AsFloat / 100) * fStrToFloat(edtPesRea.Text)));
  End;
end;

procedure TfrmCadEstruturasIndustrial.pSomaTotaisVen(var Totais: TTotais;
  Dados: TDataSet);
begin
  With Dados Do
  Begin
    Totais['fltTotPro'] := Totais['fltTotPro'] + (FieldByName('DMT_QTDITE').AsFloat *
    FieldByName('ITE_PREVE' + strTabPreRel).AsFloat);
  End;
end;

procedure TfrmCadEstruturasIndustrial.pSubstituiOProdutoSelecionado(
  strCodIte, strDesIte, strRefere: String);
var
  strIteCus: String;
  fltIteQtd: Double;
  intRecNo : Integer;
begin
  strIteCus := fRetCustoItem(strCodIte);
  fltIteQtd := cdsConsulta.FieldByName('DMT_QTDITE').AsFloat;
  intRecNo  := cdsConsulta.RecNo;

  pGravaLogFormula(edtCor.Text,
                   cdsConsulta.FieldByName('DMT_SEQUEN').AsString,
                   edtProdutos.Text,
                   strCodIte,
                   edtCodFormula.Text,
                   cdsConsulta.FieldByName('DMT_CODFAS').AsString,
                   cdsConsulta.FieldByName('DMT_SEQUEN').AsString,
                   FormatFloat(edtSubQtdIte.EditFormat, cdsConsulta.FieldByName('DMT_QTDITE').AsFloat),
                   FormatFloat(edtPerTol.EditFormat, cdsConsulta.FieldByName('DMT_PERTOL').AsFloat),
                   '','','','','','','','','','',
                   False, False, False, True, False);

  With cdsConsulta Do
  Begin
    Edit;
    FieldByName('DMT_ITESUB').AsString  := strCodIte;
    FieldByName('DMT_CODEMP').AsString  := VS_strCodEmp;
    FieldByName('DMT_CUSITE').AsFloat   := fStrToFloat(strIteCus);
    FieldByName('DMT_CUSCAL').AsFloat   := fFormataFloat(((fStrToFloat(strIteCus) * fltIteQtd)/100),4);
    FieldByName('DMT_CUS_LT').AsFloat   := fFormataFloat(((fStrToFloat(strIteCus) * fltIteQtd)/100) * fStrToFloat(edtPesRea.Text),4);
    FieldByName('DMT_DENSID').AsFloat   := fRetDensidadeItem(strCodIte);
    FieldByName('ITE_PREVE1').AsFloat   := fStrToFloat(fRetPreVenda1(strCodIte));
    FieldByName('ITE_PREVE2').AsFloat   := fStrToFloat(fRetPreVenda2(strCodIte));
    FieldByName('ITE_PREVE3').AsFloat   := fStrToFloat(fRetPreVenda3(strCodIte));
    FieldByName('ITE_PREVE4').AsFloat   := fStrToFloat(fRetPreVenda4(strCodIte));
    FieldByName('ITE_PREVE5').AsFloat   := fStrToFloat(fRetPreVenda5(strCodIte));
    FieldByName('ITE_PREVE6').AsFloat   := fStrToFloat(fRetPreVenda6(strCodIte));
    FieldByName('ITE_PREVE7').AsFloat   := fStrToFloat(fRetPreVenda7(strCodIte));
    FieldByName('DMT_DESCRI').AsString  := strDesIte;
    FieldByName('DMT_REFERE').AsString  := strRefere;
    Post;

    pAtualizaPorcentagemRepresentacaoCusto;

    cdsConsulta.RecNo := intRecNo;
  End;

  pAtualizaTotal;
end;

procedure TfrmCadEstruturasIndustrial.pTrocarSubstituirProduto;
  Var
    frmSubsProdCadEstrIndus: TfrmSubsProdCadEstrIndus;
begin
  Try
    pCriarFormularios(TfrmSubsProdCadEstrIndus, frmSubsProdCadEstrIndus);
    frmSubsProdCadEstrIndus.edtProSel.Text    := cdsConsulta.FieldByName('DMT_ITESUB').AsString;
    frmSubsProdCadEstrIndus.edtDesProSel.Text := cdsConsulta.FieldByName('DMT_DESCRI').AsString;
    frmSubsProdCadEstrIndus.ShowModal;
    If frmSubsProdCadEstrIndus.blnConfirma Then
      pSubstituiOProdutoSelecionado(frmSubsProdCadEstrIndus.edtProSub.Text,
                                    frmSubsProdCadEstrIndus.edtDesProSub.Text,
                                    frmSubsProdCadEstrIndus.edtProSubRef.Text);
  Finally
    FreeAndNil(frmSubsProdCadEstrIndus);
  End;
end;

procedure TfrmCadEstruturasIndustrial.tbsAnaliseShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodAna);
end;

procedure TfrmCadEstruturasIndustrial.tbsExtrusaoShow(Sender: TObject);
begin
  inherited;
  If tbsExtrusao.Visible Then
    pSetFocus(pnlOperador);
end;

function TfrmCadEstruturasIndustrial.fRetCustoItem(strCodIte:String): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try

    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PRECUS ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '  ITE_CODEMP = :CODEMP     ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := VS_StrCodEmp;
      OPen;
      Result := FieldByName('ITE_PRECUS').AsString;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;
End;

function TfrmCadEstruturasIndustrial.fRetDensidadeItem(strCodIte:String): Double;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try

    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_DENSID ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADITE ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      OPen;
      Result := FieldByName('ITE_DENSID').AsFloat;
    End;

  Finally
    FreeAndNil(qryGenIte);
  End;
End;

function TfrmCadEstruturasIndustrial.fRetornaPercentualRepresentacaoCusto(fltCusIte: Double): Double;
begin
  Result := 0;
  If fltTotCusIte > 0 Then
    Result := fRetornaValorArredondado((fltCusIte * 100) / fltTotCusIte);
end;

function TfrmCadEstruturasIndustrial.fRetPreVenda1(strCodIte: String): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE1 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;
      Result := FieldByName('ITE_PREVE1').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturasIndustrial.fRetPreVenda2(strCodIte: String): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE2 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;
      Result := FieldByName('ITE_PREVE2').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturasIndustrial.fRetPreVenda3(strCodIte: String): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE3 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;
      Result := FieldByName('ITE_PREVE3').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturasIndustrial.fRetPreVenda4(strCodIte: String): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE4 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;
      Result := FieldByName('ITE_PREVE4').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturasIndustrial.fRetPreVenda5(strCodIte: String): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE5 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;
      Result := FieldByName('ITE_PREVE5').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturasIndustrial.fRetPreVenda6(strCodIte: String): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE6 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;
      Result := FieldByName('ITE_PREVE6').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturasIndustrial.fRetPreVenda7(strCodIte: String): String;
  Var
    strSQL   : String;
    qryGenIte: TUniQuery;
Begin
  Try
    qryGenIte := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ITE_PREVE7 ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  ITEGER ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  ITE_CODITE = :CODITE ';

    With qryGenIte Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      Open;
      Result := FieldByName('ITE_PREVE7').AsString;
    End;
  Finally
    FreeAndNil(qryGenIte);
  End;
end;

function TfrmCadEstruturasIndustrial.fRetSeqGer: String;
begin
  pCalcularTotaisProdutos;

  With cdsConsulta Do
  Begin
    Result := IntToStr(intMaxSeqGer + 1);
  End;

end;

function TfrmCadEstruturasIndustrial.fRetSeqIte(intSeqGer :  Integer): String;
var
  intSeqIte: Integer;
  intSeqTmp: Integer;
  intRecNo : Integer;
begin
  With cdsConsulta Do
  Begin
    intRecNo  := RecNo;

    DisableControls;
    First;

    If (Not IsEmpty) Then
    Begin
      If fEmptyStr(FieldByName('DMT_SEQITE').AsString) Then
        intSeqIte := 0
      Else
        intSeqIte := FieldByName('DMT_SEQITE').AsInteger
    End Else
      intSeqIte := 0;

    While Not Eof Do
    Begin
      if (intSeqGer = 0) or (intSeqGer <= FieldByName('DMT_SEQUEN').AsInteger) Then
      Begin
        intSeqTmp := StrToIntDef(FieldByName('DMT_SEQITE').AsString, 0);

        If (intSeqIte < intSeqTmp) Then
          intSeqIte := intSeqTmp;
      End;

      Next;
    End;

    RecNo := intRecNo;
    EnableControls;

    if (intSeqGer = 0) Then
      Result := intToStr(intSeqIte + 1)
    Else
      Result := intToStr(intSeqIte);
      
  End;
end;

function TfrmCadEstruturasIndustrial.frxPaginaJUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  inherited;
  If SameText(UpperCase(MethodName), UpperCase('fAbreFormulaSubItensRel')) Then
    Result := fAbreFormulaSubItensRel(Params[0]);
end;

procedure TfrmCadEstruturasIndustrial.pHabilitaCampos;
begin
  pnlSubProdutos.Enabled      := True;
  If blnTrabalhaComFaseParaFormulasEspeciais Then
    pnlFasesEspecial.Enabled    := True;
  dbgDados.Enabled            := True;
  pnlProdutos.Enabled         := False;
  pnlCapacidadeMaxima.Enabled := True;
  btnEstrutura.Enabled        := False;
end;

procedure TfrmCadEstruturasIndustrial.pHabilitaChkComponenteAB;
begin
  ChkComponenteAB.Visible:= ((qryConIte.FieldByName('ITE_COMPNA').AsString = 'S') And (fCfgSis('ULTCMP', varBoolean)));
  dbgAnalise.Columns[3].Visible:= ((qryConIte.FieldByName('ITE_COMPNA').AsString = 'S') And (fCfgSis('ULTCMP', varBoolean)));
end;

procedure TfrmCadEstruturasIndustrial.btnCancelaAnaliseClick(Sender: TObject);
begin
  inherited;
  pLimpaAnalise;
end;

procedure TfrmCadEstruturasIndustrial.btnCancelaFaseEspecialClick(
  Sender: TObject);
begin
  inherited;
  pSetFocus(edtSubProduto);
  EdtCodFaseEspecial.Text:= '';
  EdtDesFaseEspecial.Text:= '';
  EdtSeqFaseEspecial.Text:= '';
end;

procedure TfrmCadEstruturasIndustrial.pLimpaAnalise;
Begin
  edtCodAna.Clear;
  edtDesAna.Clear;
  edtAnaMin.Text := '0,00';
  edtAnaMax.Text := '0,00';
  edtDescricaoResultadoAnalise.Clear;
  ChkComponenteAB.Checked := False;
  pSetFocus(edtCodAna);
End;

procedure TfrmCadEstruturasIndustrial.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimparDadosSubProduto;
  LimpaObjFormulaAlterada;
  pSetFocus(edtSubProduto);

  blnAltera := False;
  strSeqAlt := '';
end;

procedure TfrmCadEstruturasIndustrial.btnEpiClick(Sender: TObject);
  Var
    frmCadEstruturasIndustrialEPI: TfrmCadEstruturasIndustrialEPI;
begin
  inherited;
  pCriarFormularios(TfrmCadEstruturasIndustrialEPI, frmCadEstruturasIndustrialEPI);
  frmCadEstruturasIndustrialEPI.fPreencheCadOpi(cdsGeiEpi);

  frmCadEstruturasIndustrialEPI.ShowModal;
  If frmCadEstruturasIndustrialEPI.ModalResult = mrOK Then
  Begin
    frmCadEstruturasIndustrialEPI.cdsCadEpi.First;
    While Not frmCadEstruturasIndustrialEPI.cdsCadEpi.Eof Do
    Begin
      If cdsGeiEpi.Locate('GEP_CODEPI', frmCadEstruturasIndustrialEPI.cdsCadEpi.FieldByName('EPI_CODEPI').AsString, []) Then
      Begin
        If frmCadEstruturasIndustrialEPI.cdsCadEpi.FieldByName('EPI_TIPUSO').AsString <> 'N' Then
        Begin
          cdsGeiEpi.Edit;
          cdsGeiEpi.FieldByName('GEP_TIPUSO').AsString := frmCadEstruturasIndustrialEPI.cdsCadEpi.FieldByName('EPI_TIPUSO').AsString;
          cdsGeiEpi.FieldByName('GEP_OBSERV').AsString := frmCadEstruturasIndustrialEPI.cdsCadEpi.FieldByName('EPI_OBSERV').AsString;
          cdsGeiEpi.Post;
        End
        Else // Se tirou o uso do epi, deleta o mesmo.
          cdsGeiEpi.Delete;
      End
      Else
      If frmCadEstruturasIndustrialEPI.cdsCadEpi.FieldByName('EPI_TIPUSO').AsString <> 'N' Then
      Begin
        cdsGeiEpi.Insert;
        cdsGeiEpi.FieldByName('GEP_CODEPI').AsString := frmCadEstruturasIndustrialEPI.cdsCadEpi.FieldByName('EPI_CODEPI').AsString;
        cdsGeiEpi.FieldByName('GEP_TIPUSO').AsString := frmCadEstruturasIndustrialEPI.cdsCadEpi.FieldByName('EPI_TIPUSO').AsString;
        cdsGeiEpi.FieldByName('GEP_OBSERV').AsString := frmCadEstruturasIndustrialEPI.cdsCadEpi.FieldByName('EPI_OBSERV').AsString;
        cdsGeiEpi.Post;
      End;

      frmCadEstruturasIndustrialEPI.cdsCadEpi.Next;
    End;

  End;
  pImagemEpi;
  FreeAndNil(frmCadEstruturasIndustrialEPI);
end;

procedure TfrmCadEstruturasIndustrial.btnEstruturaClick(Sender: TObject);
begin
  fBuscaEstrutura( False );
  pHabilitaChkComponenteAB;
end;

procedure TfrmCadEstruturasIndustrial.pDeletaItem;
var
  objTMateriaPrima: TMateriaPrima;
begin
  Try

    If blnAltera Then
      Exit;

    If Not cdsConsulta.IsEmpty Then
    Begin

      pGravaLogFormula(edtCor.Text,
                       cdsConsulta.FieldByName('DMT_SEQUEN').AsString,
                       edtProdutos.Text,
                       cdsConsulta.FieldByName('DMT_ITESUB').AsString,
                       edtCodFormula.Text,
                       cdsConsulta.FieldByName('DMT_CODFAS').AsString,
                       cdsConsulta.FieldByName('DMT_SEQUEN').AsString,
                       FormatFloat(edtSubQtdIte.EditFormat, cdsConsulta.FieldByName('DMT_QTDITE').AsFloat),
                       FormatFloat(edtPerTol.EditFormat, cdsConsulta.FieldByName('DMT_PERTOL').AsFloat),
                       '','','','','','','', '', '' ,'',
                       True, False, False, True, False);

      for objTMateriaPrima in objFormula.lstMateriasPrimas do
      begin
        If (objTMateriaPrima.strCodigo = cdsConsulta.FieldByName('DMT_ITESUB').AsString) Then
        Begin
          objFormula.lstMateriasPrimas.Remove(objTMateriaPrima);
          break;
        End;
      end;

      cdsConsulta.Delete;
      pAcertaSequencialItem;
    End;

    pCalcularTotaisProdutos;

    If (cdsConsulta.IsEmpty) and (not chkForEsp.Checked) Then
    Begin
      btnConfirma.Enabled   := False;
      btnImprimir.Enabled   := False;
      btnComentario.Enabled := False;
      btnMoveCima.Enabled   := False;
      btnMoveBaixo.Enabled  := False;
      btnSubstituir.Enabled := False;
    End;


  Finally

  End;

end;

procedure TfrmCadEstruturasIndustrial.dbgAnaliseDblClick(Sender: TObject);
begin
  inherited;
  pCarregaEdicaoAnalise;
end;

procedure TfrmCadEstruturasIndustrial.dbgAnaliseKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Shift = []) Then
  Begin
    If (Key = VK_DELETE) Then
    Begin
      If fMensagem('', 'Deseja Remover essa Análise?', ['&Sim', '&Não']) = 1 Then
      Begin
        cdsGeiAna.Delete;
      End;
      Key := 0;
    End

    Else If (key = VK_RETURN) Then
    Begin
      pCarregaEdicaoAnalise;
      Key := 0;
    End;

  End;
end;

procedure TfrmCadEstruturasIndustrial.pCarregaEdicaoAnalise;
Begin
  pFormataResultadoEsperadoAnalise(cdsGeiAna.FieldByName('ANA_TIPRES').AsString);

  edtCodAna.Text := cdsGeiAna.FieldByName('GAN_CODANA').AsString;
  edtDesAna.Text := cdsGeiAna.FieldByName('ANA_DESCRI').AsString;
  edtAnaMin.Text := FormatFloat(edtAnaMin.EditFormat, cdsGeiAna.FieldByName('GAN_LIMMIN').AsFloat);
  edtAnaMax.Text := FormatFloat(edtAnaMax.EditFormat, cdsGeiAna.FieldByName('GAN_LIMMAX').AsFloat);
  edtDescricaoResultadoAnalise.Text := cdsGeiAna.FieldByName('GAN_DESRES').AsString;

  If cdsGeiAna.FieldByName('GAN_INFOAB').AsString  = 'AB' then
    ChkComponenteAB.Checked := True
  Else
    ChkComponenteAB.Checked := False;

  pSetFocus(edtCodAna);
End;

procedure TfrmCadEstruturasIndustrial.pFormataResultadoEsperadoAnalise(strTipRes : String);
begin
  case TTipoResultadoAnalise(StrToIntDef(strTipRes, 1)) Of
    traNull, traIntervaloValores :
    begin
      pgcResultadoAnalise.ActivePage := tbsIntervaloValores;
      edtDescricaoResultadoAnalise.Clear;

      if cdsGeiAna.State in [dsEdit, dsInsert] then
        cdsGeiAna.FieldByName('GAN_DESRES').Clear;

    end;
    traDescricaoAberta :
    begin

      pgcResultadoAnalise.ActivePage := tbsDescricaoAberta;
      edtAnaMin.clear;
      edtAnaMax.clear;

      if cdsGeiAna.State in [dsEdit, dsInsert] then
      begin
        cdsGeiAna.FieldByName('GAN_LIMMIN').clear;
        cdsGeiAna.FieldByName('GAN_LIMMAX').clear;
      end;

    end;
  end;
end;

procedure TfrmCadEstruturasIndustrial.pgcResultadoAnaliseEnter(Sender: TObject);
begin
  if pgcResultadoAnalise.ActivePage = tbsIntervaloValores then
    pSetFocus(edtAnaMin)
  else
    pSetFocus(edtDescricaoResultadoAnalise);
end;

procedure TfrmCadEstruturasIndustrial.dbgDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) Then
  Begin
    btnCancelaItem.Click;
  End
  Else If (Key = VK_Return) Then
  Begin
    pCarregaItemAlteracao;
  End
  Else If (Key = VK_Delete) Then
  Begin
    pDeletaItem;
  End
(*
  Else If (Key = VK_Prior) Then
  Begin
    Key := 0;
    btnMoveCima.Click;
  End
  Else If (Key = VK_Next) Then
  Begin
    Key := 0;
    btnMoveBaixo.Click;
  End;
  *)
end;

procedure TfrmCadEstruturasIndustrial.dbgGfaFasesViewEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Shift = []) Then
  Begin
    If (Key = VK_DELETE) Then
    Begin
      If fMensagem('', 'Deseja excluir a fase?', ['&Sim', '&Não']) = 1 Then
      Begin
        objCadFaseFormulaEspecial.pDeletaFaseEspecial;
      End;
      Key := 0;
    End
  End;

end;

procedure TfrmCadEstruturasIndustrial.EdCodOpeExtrusaoExit(Sender: TObject);
begin
  inherited;
  If Not(fValidaCampos(EdCodOpeExtrusao, True)) Then
    Exit;
end;

procedure TfrmCadEstruturasIndustrial.EdCodOpeExtrusaoKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrOperador: TConsultasArray;
begin
  inherited;

  if fPesqOperador(Self,
                   EdCodOpeExtrusao,
                   EdtOpeNomeExtrusao,
                   Nil,
                   Key,
                   arrOperador,
                   False, {blnConSim}
                   False) Then //blnCompradores
  Begin
    If fValidaCampos(EdCodOpeExtrusao, True) Then
      Self.SelectNext(ActiveControl, True, True);

  End;

end;

procedure TfrmCadEstruturasIndustrial.EdtCodFaseEspecialKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    Try

      If fPesqFases(Self, EdtCodFaseEspecial, EdtDesFaseEspecial, qryConFas, Key, arrSel) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCadEstruturasIndustrial.edtCodFasKeyPress]');
      End;
    End;

  End;

end;

procedure TfrmCadEstruturasIndustrial.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDeletaTemporaria;

  FreeAndNil(qryConCor);
end;

procedure TfrmCadEstruturasIndustrial.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Escape) And (((cdsConsulta.Active) And (cdsConsulta.RecordCount > 0)) or chkForEsp.Checked or blnInsert) Then
  Begin

    Key := 0;

    If ( fMensagem( '', 'Cancela edição da Estrutura?', ['&Sim', '&Não'], 2 ) = 2 ) Then
      Exit;

    pLimparDados;
  End;

  inherited;

  If btnEstrutura.Enabled Then
  Begin
    If (Key = VK_F3) Then
      btnEstrutura.Click;
  End;

  If btnImprimir.Enabled Then
  Begin
    If (Key = VK_F5) Then
    Begin
      btnImprimir.Click;
      Key := 0;
    End;
  End;

  If btnSubstituir.Enabled Then
  Begin
    If (Key = VK_F6) Then
    Begin
      btnSubstituir.Click;
      Key := 0;
    End;
  End;

  If btnComentario.Enabled Then
  Begin
    If (Key = VK_INSERT) Then
    Begin
      btnComentario.Click;
      Key := 0;
    End;
  End;

  If btnConfirma.Enabled Then
  Begin
    If (Key = VK_F10) Then
    Begin
      btnConfirma.Click;
      Key := 0;
    End;
  End;

  If btnApaga.Enabled Then
  Begin

    If (Key = VK_F2) Then
    Begin
      btnApaga.Click;
      Key := 0;
    End;

  End;

  If (Key = VK_F11) And (btnEpi.Visible) And (btnEpi.Enabled) Then
  Begin
    btnEpi.Click;
    Key := 0;
  End;


  If (Key = VK_RETURN) And (ActiveControl Is TRadioButton) Then
  Begin
    SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadEstruturasIndustrial.pCarregaOperador(strCodOpe: String);
Var
  qryOpe : TUniQuery;
Begin
  qryOpe:= fCriaQuery;
  Try
    If Not(fEmptyStr(strCodOpe)) Then
    Begin

      qryOpe.Close;
      qryOpe.SQL.Clear;
      qryOpe.SQL.Add('SELECT OPE_CODOPE, OPE_NOMOPE FROM CADOPE WHERE OPE_CODOPE = "'+strCodOpe+'" ');
      qryOpe.Open;

      EdtOpeNomeExtrusao.Text:= qryOpe.FieldByName('OPE_NOMOPE').AsString;

    End
    Else
      EdtOpeNomeExtrusao.Text:='';

  Finally
    FreeAndNil(qryOpe);
  End;

End;

procedure TfrmCadEstruturasIndustrial.btnConfirmaClick(Sender: TObject);
  Var
    strSQL: String;
    qryGerMat : TUniQuery;
    qryGerCon : TUniQuery;
    qryConOpe : TUniQuery;
    intSequen: Integer;
    strCodFormulacao: String;
    fltTotPer: Double;
    I: Integer;
    strDesPro: String;
    strObsExtr: String;
begin
  inherited;

  if not chkForEsp.Checked Then
  begin

    If Not fValidaCampos(edtPesRea, True) Then
      Exit;

    If Not fValidaCampos(edtCapacidadeMaxima, True) Then
      Exit;

    pCalcularTotaisProdutos;

    strCodFormulacao := '';

    fltTotPer := fFormataFloat(fltTotPercen, 3);

    If (cdsConsulta.IsEmpty) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário digitar pelo menos 1 subproduto!', ['&Ok']);
      Exit;
    End;

    If (((fltTotPer > 0) And (fltTotPer < 100)) Or ((fltTotPer > 0) And (fltTotPer > 100))) then
    Begin
      fMensagem('ATENÇÃO!', 'O percentual total dos Sub. Produtos tem que fechar ' +
                            'em 100% !', ['&Ok']);
      Exit;
    End;

    If fCfgSis('EXMOPI', varBoolean) Then
    Begin

      If Not(fValidaCampos(tbsExtrusao, True)) Then
        Exit;

      If RichObservacaoExtrusao.Lines.Count > 0 Then
      Begin
        for I := 0 to RichObservacaoExtrusao.Lines.Count - 1 do
        Begin
          strObsExtr:= strObsExtr + RichObservacaoExtrusao.Lines[I];
        End;
      End;

      If Not(fValidaCampos(EdCodOpeExtrusao, True)) Then
        Exit;

      If Not(fValidaCampos(MskHraInicioExtrusao, True)) Then
        Exit;

      If Not(fValidaCampos(MskHraFinalExtrusao, True)) Then
        Exit;

      If Not(fValidaCampos(edtRotacaoRoska, True)) Then
        Exit;

      If Not(fValidaCampos(edtPicotador, True)) Then
        Exit;

      Try
        If Not(fEmptyStr(EdCodOpeExtrusao.text)) Then
          ObjProcessoExtrusao.pValidaCamposGridExtrusao;
      Except
        On E: Exception Do
        Begin
          pMensagemOk(E.Message);
          Exit;
        End;

      End;

    End;


  end;

  Try
    pCriarFormularios(TfrmObsEstrutura, frmObsEstrutura);

    frmObsEstrutura.edtObs01.Text := strObs001;
    frmObsEstrutura.edtObs02.Text := strObs002;
    frmObsEstrutura.edtObs03.Text := strObs003;
    frmObsEstrutura.edtObs04.Text := strObs004;
    frmObsEstrutura.edtObs05.Text := strObs005;
    frmObsEstrutura.edtObs06.Text := strObs006;
    frmObsEstrutura.edtObs07.Text := strObs007;

    frmObsEstrutura.ShowModal;

    blnConfirma := frmObsEstrutura.blnConfirma;

    If blnConfirma Then
    Begin
      strObs001 := frmObsEstrutura.edtObs01.Text;
      strObs002 := frmObsEstrutura.edtObs02.Text;
      strObs003 := frmObsEstrutura.edtObs03.Text;
      strObs004 := frmObsEstrutura.edtObs04.Text;
      strObs005 := frmObsEstrutura.edtObs05.Text;
      strObs006 := frmObsEstrutura.edtObs06.Text;
      strObs007 := frmObsEstrutura.edtObs07.Text;
    End;

    if blnMPrPAg Then
      pGravaAGranelComoAcabado(edtProdutos.Text, edtCor.Text);


  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmCadEstruturasIndustrial.btnConfirmaClick]');
    End;
  End;

  pFreeAndNil(frmObsEstrutura);


  {********************************************}
  {* VERIFICA SE A ESTRUTURA EXISTE NO BANCO  *}
  {* SE EXISTIR APAGA                         *}
  {*****************************************LB*}

  If dtaDtaCad = 0 Then dtaDtaCad := VS_Date;
  If HraHraCad = 0 Then HraHraCad := fNow;

  If blnConfirma Then
  Begin
    Try

      If fCfgSis('SOLSEN', varString) = 'S' Then
      Begin
        If ffrmSenha(strSenha, 'Digite a Senha') Then
        Begin
          qryConOpe:= fCriaQuery;
          Try
            qryConOpe.Close;
            qryConOpe.SQL.Clear;
            qryConOpe.SQL.Add('SELECT * FROM CADOPE WHERE OPE_CODOPE = :CODOPE AND OPE_STATUS <> "I"');
            qryConOpe.ParamByName('CODOPE').AsString:= strLoginUsuarioLogado;
            qryConOpe.Open;

            If (strSenha <> fDecrypt(qryConOpe.FieldByName('OPE_SENOPE').AsString)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Senha Invalida!', ['&O k']);
              Exit;
            End;

          Finally
            FreeAndNil(qryConOpe);
          End;
        End
        Else
          Exit;
      End;

      strCodFormulacao := edtCodFormula.Text;

      If Not fEmptyStr(strCodFormulacao) Then
      Begin

          objLogFormulaAlterada.strCodIte        := qryTabela.FieldByName('GMT_CODITE').AsString;
          objLogFormulaAlterada.strCodCor        := qryTabela.FieldByName('GMT_CODCOR').AsString;
          objLogFormulaAlterada.strCodEmp        := VS_strCodEmp;
          objLogFormulaAlterada.strDtaHra        := DateTimeToStr(fNow);
          objLogFormulaAlterada.strCodOpe        := strLoginUsuarioLogado;
          objLogFormulaAlterada.strForMul        := qryTabela.FieldByName('GMT_FORMUL').AsString;
          objLogFormulaAlterada.dftTabTem        := memLogTemp;

          objLogFormulaAlterada.pGravaSequenciaTabelaLogTemp;


          pGravaLogFormula(
                         qryTabela.FieldByName('GMT_CODCOR').AsString,
                         '',
                         qryTabela.FieldByName('GMT_CODITE').AsString,
                         '',
                         qryTabela.FieldByName('GMT_FORMUL').AsString,
                         '',
                         '',
                         '',
                         '',
                         IIF(chkForEsp.Checked, 1, 0),
                         IIF(rdgStatus.ItemIndex = 0, 'A', 'I'),
                         strObs001,
                         strObs002,
                         strObs003,
                         strObs004,
                         strObs005,
                         strObs006,
                         strObs007,
                         edtPesRea.Text,
                         False, False, False);
      End;



      fStartTransaction;

      strDesPro:= '';

      If RichDescProcProducao.Lines.Count > 0 Then
      Begin
        for I := 0 to RichDescProcProducao.Lines.Count - 1 do
        Begin
          strDesPro:= strDesPro + RichDescProcProducao.Lines[I];
        End;
      End;

      If Not fEmptyStr(strCodFormulacao) Then
      Begin
        Try
          qryGerMat := fCriaQuery(Self);
          qryGerCon := fCriaQuery(Self);


          strSQL := '';
          strSQL := strSQL + 'DELETE FROM ';
          strSQL := strSQL + '  GEIMAT ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  GMT_CODITE = :CODITE AND ';
          strSQL := strSQL + '  GMT_CODCOR = :CODCOR AND ';
          strSQL := strSQL + '  GMT_FORMUL = :CODFOR ';

          With qryGerMat Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('CODITE').AsString := edtProdutos.Text;
            ParamByName('CODCOR').AsString := edtCor.Text;
            ParamByName('CODFOR').AsString := strCodFormulacao;
            ExecSQL;
            Close;
          End;

          If fCfgSis('EXMOPI', varBoolean) Then
          Begin
            If Not(fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString)) And Not(fEmptyStr(EdCodOpeExtrusao.Text)) Then
            Begin
              qryGerCon.Close;
              qryGerCon.SQL.Clear;
              qryGerCon.SQL.Add('DELETE FROM GEIEXT WHERE GXT_SEQGMT = :SEQGMT');
              qryGerCon.ParamByName('SEQGMT').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
              qryGerCon.ExecSQL;
            End;
          End;

          If blnTrabalhaComFaseParaFormulasEspeciais Then
          Begin
            If Not(fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
            Begin
              objCadFaseFormulaEspecial.blnPersisteNoBanco:= True;
              objCadFaseFormulaEspecial.pDeletaFaseEspecial;
            End;

          End;


        Finally
          FreeAndNil(qryGerMat);
          FreeAndNil(qryGerCon);
        End;
      End;

      {***********************************}
      {* EFETUA A GRAVAÇÃO NO BANCO      *}
      {********************************LB*}
      fGravaGerMat(strAutoInc,
                   VS_strCodEmp,
                   edtProdutos.Text,
                   edtCor.Text,
                   strCodFormulacao,
                   edtReferencia.Text,
                   strObs001,
                   strObs002,
                   strObs003,
                   strObs004,
                   IIF(rdgStatus.ItemIndex = 0, 'A', 'I'),
                   IIF(chkForEsp.Checked, 1, fStrToFloat(edtPesRea.Text)),
                   dtaDtaCad,
                   HraHraCad,
                   IIF(not blnInsert, VS_Date, 0),
                   IIF(not blnInsert, fNow, 0),
                   chkForEsp.checked,
                   strObs005,
                   strObs006,
                   strObs007,
                   edtDataDesenvolvimento.Date,
                   strDesPro,
                   fStrToFloat(edtCapacidadeMaxima.Text),
                   EdCodOpeExtrusao.Text,
                   strObsExtr,
                   MskHraInicioExtrusao.Text,
                   MskHraFinalExtrusao.Text,
                   edtRotacaoRoska.Text,
                   edtPicotador.Text);

      If fEmptyStr(edtCodFormula.Text) Then
      Begin

          objLogFormulaAlterada.strCodIte        := edtProdutos.Text;
          objLogFormulaAlterada.strCodCor        := edtCor.Text;
          objLogFormulaAlterada.strCodEmp        := VS_strCodEmp;
          objLogFormulaAlterada.strDtaHra        := DateTimeToStr(fNow);
          objLogFormulaAlterada.strCodOpe        := strLoginUsuarioLogado;
          objLogFormulaAlterada.strForMul        := strCodFormulacao;
          objLogFormulaAlterada.dftTabTem        := memLogTemp;

          objLogFormulaAlterada.pGravaSequenciaTabelaLogTemp;

          pGravaLogFormula(edtCor.Text,
                         '',
                         edtProdutos.Text,
                         '',
                         strCodFormulacao,
                         '',
                         '',
                         '',
                         '',
                         IIF(chkForEsp.Checked, 1, 0),
                         IIF(rdgStatus.ItemIndex = 0, 'A', 'I'),
                         strObs001,
                         strObs002,
                         strObs003,
                         strObs004,
                         strObs005,
                         strObs006,
                         strObs007,
                         edtPesRea.Text,
                         False, False, True);
      End;


      edtCodFormula.Text := strCodFormulacao;

      if not chkForEsp.Checked then
      begin
        With cdsConsulta Do
        Begin
          intSequen := 0;
          First;
          While Not (Eof) Do
          Begin
            If fEmptyStr(FieldByName('DMT_ITESUB').AsString) Then
              strDescri := FieldByName('DMT_DESCRI').AsString
            Else
              strDescri := '';

            intSequen := intSequen + 1;
            fGravaDetMat(strAutoInc,
                         intSequen,
                         FieldByName('DMT_SEQITE').AsString,
                         VS_strCodEmp,
                         FieldByName('DMT_ITESUB').AsString,
                         strDescri,
                         FieldByName('DMT_DESPCA').AsString,
                         FieldByName('DMT_QTDITE').AsFloat,
                         FieldByName('DMT_PERTOL').AsFloat,
                         FieldByName('DMT_CODFAS').AsString);

            Next;
          End;
        End;

        if blnUsaEpi Then
        Begin
          fGravaGeiEpi(strAutoInc, cdsGeiEpi);
        End;

      end;

        fGravaGeiAna(strAutoInc, cdsGeiAna);

      {*************************************}
      {* SE MARCAR A FORMULA COMO ATIVA,   *}
      {* DESATIVA AS OUTRAS FORMULAS REF.  *}
      {* AO MESMO PRODUTO COM A MESMA COR  *}
      {**********************************PZ*}
      If (rdgStatus.ItemIndex = 0) Then
        fInativaFormulas(edtProdutos.Text, edtCor.Text, edtCodFormula.Text);

      If (memLogTemp.RecordCount > 0) And Not(fEmptyStr(edtCodFormula.Text)) Then
      Begin
        objLogFormulaAlterada.blnGravaBanco  := True;
        objLogFormulaAlterada.pGravaLogFormula;
      End;


      If (fCfgSis('EXMOPI', varBoolean)) And Not(fEmptyStr(EdCodOpeExtrusao.Text)) Then
      Begin
        ObjProcessoExtrusao.pGravaProcessoExtrusao(strAutoInc);
      End;


      If blnTrabalhaComFaseParaFormulasEspeciais Then
      Begin
        objCadFaseFormulaEspecial.blnPersisteNoBanco:= True;
        objCadFaseFormulaEspecial.strAutoIncremGeiMat := strAutoInc;

        objCadFaseFormulaEspecial.pGravarFormulaEspecial;
        objCadFaseFormulaEspecial.cdsFaseEspecial.EmptyDataSet;
      End;


      fCommit;
      fMensagem('Informação!','Fórmula : ' + edtCodFormula.Text + #13#10 +
                              'Produto Estrutura : ' + edtProdutos.Text + ' - ' + edtDesProduto.Text + #13#10 +
                              'incluída com sucesso!',['&Ok']);
    Except
      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[frmCadEstruturasIndustrial.btnConfirmaClick]');
      End;
    End;

    pLimparDados;

    if FFecharAoConfirmar Then
      ModalResult := mrOk;

  End;
end;

procedure TfrmCadEstruturasIndustrial.pGravaLogFormula(strCodCor, strSeqOld, strCodIte, strIteSub, strForMul,
                               strCodFas, strSequen, strSubQtd, strPerTol: String;
                               strForEsp, strStatus, strOBS001, strOBS002, strOBS003,
                               strOBS004, strOBS005, strOBS006, strOBS007, strPesRea: String;
                               blnDelete: Boolean = False; blnInclusao: Boolean = False;
                               blnInclusaoFormula: Boolean = False; blnMateriaPrima: Boolean = False;
                               blnIncComentario: Boolean = False; strDesCom: String = '');

Begin
  Try

    If Not(memLogTemp.Active) Then
      memLogTemp.Open;

    objLogFormulaAlterada.strCodIte        := strCodIte;
    objLogFormulaAlterada.strCodCor        := strCodCor;
    objLogFormulaAlterada.strDesSub        := strDesCom;
    objLogFormulaAlterada.strCodEmp        := VS_strCodEmp;
    objLogFormulaAlterada.strDtaHra        := DateTimeToStr(fNow);
    objLogFormulaAlterada.strCodOpe        := strLoginUsuarioLogado;
    objLogFormulaAlterada.strIteSub        := strIteSub;
    objLogFormulaAlterada.strForMul        := strForMul;
    objLogFormulaAlterada.strCodFas        := strCodFas;
    objLogFormulaAlterada.strSequen        := strSequen;
    objLogFormulaAlterada.strSubQtd        := strSubQtd;
    objLogFormulaAlterada.strPerTol        := strPerTol;
    objLogFormulaAlterada.strSeqOld        := strSeqOld;
    objLogFormulaAlterada.strForEsp        := strForEsp;
    objLogFormulaAlterada.strStatus        := strStatus;
    objLogFormulaAlterada.strObs001        := strOBS001;
    objLogFormulaAlterada.strObs002        := strOBS002;
    objLogFormulaAlterada.strObs003        := strOBS003;
    objLogFormulaAlterada.strObs004        := strOBS004;
    objLogFormulaAlterada.strObs005        := strOBS005;
    objLogFormulaAlterada.strObs006        := strOBS006;
    objLogFormulaAlterada.strObs007        := strOBS007;
    objLogFormulaAlterada.strPesRea        := strPesRea;

    objLogFormulaAlterada.cdsDataSet       := cdsConsulta;
    objLogFormulaAlterada.cdsDataSetFormula:= qryTabela;
    objLogFormulaAlterada.dftTabTem        := memLogTemp;

    objLogFormulaAlterada.blnGravaBanco  := False;

    objLogFormulaAlterada.pGravaLogFormula(blnDelete, blnInclusao, blnInclusaoFormula, blnMateriaPrima, blnIncComentario);

  Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCadEstruturasIndustrial.pGravaLogFormula]');
      End;
  End;

End;


procedure TfrmCadEstruturasIndustrial.btnConfirmaFaseEspecialClick(
  Sender: TObject);
begin
  inherited;

  If Not fValidaCampos(EdtCodFaseEspecial, True) Then
    Exit;

  If Not fValidaCampos(EdtSeqFaseEspecial, True) Then
    Exit;

  If Not(objCadFaseFormulaEspecial.cdsFaseEspecial.Active) Then
    objCadFaseFormulaEspecial.cdsFaseEspecial.Open;

  objCadFaseFormulaEspecial.strAutoIncrem           :=  fRetAutoIncrem('GEIFAS', VS_strCodEmp);
  objCadFaseFormulaEspecial.strCodigoEmpresa        :=  VS_strCodEmp;
  objCadFaseFormulaEspecial.strCodigoFase           :=  EdtCodFaseEspecial.Text;
  objCadFaseFormulaEspecial.strAutoIncremGeiMat     :=  qryTabela.FieldByName('AUTOINCREM').AsString;
  objCadFaseFormulaEspecial.strSequencialDaFase     :=  EdtSeqFaseEspecial.Text;
  objCadFaseFormulaEspecial.strChaveDoCadastroDeFase:=  objCadFaseFormulaEspecial.fRetornaAutIncCadFase;
  objCadFaseFormulaEspecial.pGravarFormulaEspecial;

  EdtCodFaseEspecial.Text:= '';
  EdtSeqFaseEspecial.Text:= '';
  EdtDesFaseEspecial.Text:= '';
  pSetFocus(EdtCodFaseEspecial);
end;

procedure TfrmCadEstruturasIndustrial.btnComentarioClick(Sender: TObject);
begin
  inherited;
  Try

    If (blnAltera) Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido inserir comentários em modo de alteração!', ['&O k']);
      Exit;
    End;

    pCriarFormularios(TfrmComentEstrutura,frmComentEstrutura);
    frmComentEstrutura.blnIndustrial  := True;
    frmComentEstrutura.edtComentario.MaxLength := 100;
    frmComentEstrutura.edtComentario.TamCampo  := 100;
    frmComentEstrutura.ShowModal;

    blnConfirma := frmComentEstrutura.blnConfirma;


    If blnConfirma Then
    Begin
      strComent := frmComentEstrutura.edtComentario.Text;
      pGravaTemporaria('', '', strComent,
                       frmComentEstrutura.edtCodFas.Text,
                       frmComentEstrutura.edtDesFas.Text,
                       0.00,
                       0.00,
                       StrToIntDef(frmComentEstrutura.edtSeq.Text,0));

      pGravaLogFormula(edtCor.Text,
                       cdsConsulta.FieldByName('DMT_SEQUEN').AsString,
                       edtProdutos.Text,
                       cdsConsulta.FieldByName('DMT_ITESUB').AsString,
                       edtCodFormula.Text,
                       cdsConsulta.FieldByName('DMT_CODFAS').AsString,
                       cdsConsulta.FieldByName('DMT_SEQUEN').AsString,
                       FormatFloat(edtSubQtdIte.EditFormat, cdsConsulta.FieldByName('DMT_QTDITE').AsFloat),
                       FormatFloat(edtPerTol.EditFormat, cdsConsulta.FieldByName('DMT_PERTOL').AsFloat),
                       '','','','','','','','','','',
                       False, True, False, False, True, strComent);

    End;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmCadEstruturasIndustrial.btnComentarioClick]');
    End;
  End;

  pFreeAndNil(frmComentEstrutura);

end;

procedure TfrmCadEstruturasIndustrial.pCarregaCor(qryConsulta: TUniQuery);
begin
  pPesquisaCadCor(qryConsulta, qryConsulta, edtCor.Text);
  With qryConsulta Do
  Begin
    edtDesCor.Text := qryConsulta.FieldByName('COR_DESCOR').AsString;
  End
end;

function TfrmCadEstruturasIndustrial.fCarregaEstrutura: Boolean;
  Var
    strSQL: String;
    blnImpEstrutura: Boolean;
    strCodIte: String;
    strCodCor: String;
    strCodFor: String;
    qryGerMat : TUniQuery;
    strEstrutura: String;
    objSQLEstruturaIndustrial: TSQLEstruturaIndustrial;

  procedure pCarregaEPI(strSeqGmt : String);
  begin
    cdsGeiEpi.qryQuery.Close;
    cdsGeiEpi.qryQuery.ParamByName('SEQGMT').AsString :=  strSeqGmt;
    cdsGeiEpi.fAbreClient(True, 'TfrmCadEstruturasIndustrial.fCarregaEstrutura');
  end;

  procedure pCarregaAnalise(strSeqGmt : String);
  begin
    cdsGeiAna.qryQuery.Close;
    cdsGeiAna.qryQuery.ParamByName('SEQGMT').AsString := strSeqGmt;
    cdsGeiAna.fAbreClient(True, 'TfrmCadEstruturasIndustrial.fCarregaEstrutura');

    (cdsGeiAna.FieldByName('GAN_LIMMIN') As TFloatField).DisplayFormat := edtAnaMin.EditFormat;
    (cdsGeiAna.FieldByName('GAN_LIMMAX') As TFloatField).DisplayFormat := edtAnaMax.EditFormat;
  end;
begin
  Result := False;

  blnImpEstrutura := False;
  strSQL          := '';

  objSQLEstruturaIndustrial:= TSQLEstruturaIndustrial.Create;
  Try
    strSQL:= objSQLEstruturaIndustrial.fRetornaTSQLCarregaEstrutura;
  Finally
    FreeAndNil(objSQLEstruturaIndustrial);
  End;


  qryGerMat := Nil;
  Try
    qryGerMat := fCriaQuery(Self);

    With qryGerMat Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := edtProdutos.Text;
      ParamByName('CODCOR').AsString := edtCor.Text;
      ParamByName('CODFOR').AsString := edtCodFormula.Text;
      Open;

      pCarregaAnalise(FieldByName('AUTOINCREM').AsString);
      if not chkForEsp.Checked then
      begin
        pCarregaEPI(FieldByName('AUTOINCREM').AsString);
        pImagemEpi;
      end;

      If IsEmpty Then
      Begin

        If (Not fEmptyStr(edtCodFormula.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa fórmula não está cadastrada!' + #13#10 +
                                'Item: ' + edtProdutos.Text + #13#10 +
                                'Cor: ' + edtCor.Text + #13#10 +
                                'Cód. Formula: ' + edtCodFormula.Text + #13#10 +
                                'Empresa: ' + VS_strCodEmp, ['&O k']);
          Exit;
        end;

        btnApaga.Enabled := False;
        blnImpEstrutura  := True;

        if edtDataDesenvolvimento.Visible and (DateTimeToUnix(edtDataDesenvolvimento.Date) <= 0 ) then
          edtDataDesenvolvimento.Date := VS_Date;

      End
      Else
      Begin

        rdgStatus.ItemIndex := IIF(FieldByName('GMT_STATUS').AsString  = 'A', 0, 1);
        chkForEsp.Checked := FieldByName('GMT_FORESP').AsBoolean;

        if pnlCapacidadeMaxima.Visible then
          edtCapacidadeMaxima.Text := FormatFloat(fMskDigitos(2), FieldByName('GMT_CAPMAX').AsFloat);


        if edtDataDesenvolvimento.Visible then
        begin
          if FieldByName('GMT_DTAFOR').AsDateTime > 0  then
            edtDataDesenvolvimento.Date :=  FieldByName('GMT_DTAFOR').AsDateTime
          else
            edtDataDesenvolvimento.Date := VS_Date;;
        end;

        pFormataFormulaEspecial;
        btnApaga.Enabled := True;

      End;

      Close;
    End;

    strCodIte := '';
    strCodCor := '';
    strCodFor := '';
    strEstrutura := '';

    If blnImpEstrutura And
       (fMensagem('', IIF(chkForEsp.Checked,'Importar Análises?' ,'Importar  Estrutura?'), ['&Sim', '&Não']) = 1) Then
    Begin
      strEstrutura := fBuscaEstrutura( True );
      strCodIte := Copy(strEstrutura,1,Pos('+',strEstrutura) - 1);
      strEstrutura := Copy(strEstrutura,Pos('+',strEstrutura) + 1,Length(strEstrutura));
      strCodCor := Copy(strEstrutura,1,Pos('+',strEstrutura) - 1);
      strEstrutura := Copy(strEstrutura,Pos('+',strEstrutura) + 1,Length(strEstrutura));
      strCodFor := strEstrutura;
    End;

    blnMudarFoco := False;

    If blnTrabalhaComFaseParaFormulasEspeciais Then
    Begin
      objCadFaseFormulaEspecial.strAutoIncremGeiMat:= qryTabela.FieldByName('AUTOINCREM').AsString;
      objCadFaseFormulaEspecial.pCarregaFaseFormulaEspecial;
    End;


    if not chkForEsp.Checked then
    begin

      If ( blnImpEstrutura ) And ( Not fEmptyStr( strCodIte ) ) Then
      Begin

        fCarregaEstruturaIndustrial(qryConsulta,
                                    cdsConsulta,
                                    strCodIte,
                                    strCodCor,
                                    strCodFor);

      End Else
      Begin

        fCarregaEstruturaIndustrial(qryConsulta,
                                    cdsConsulta,
                                    edtProdutos.Text,
                                    edtCor.Text,
                                    edtCodFormula.Text);
      End;


      With qryConsulta Do
      Begin
        TFloatField(FieldByName('DMT_QTDITE')).DisplayFormat := edtSubQtdIte.EditFormat;
        TFloatField(FieldByName('DMT_QTDITE')).EditFormat    := edtSubQtdIte.EditFormat;
        TFloatField(FieldByName('DMT_PERTOL')).DisplayFormat := edtPerTol.EditFormat;
        TFloatField(FieldByName('DMT_PERTOL')).EditFormat    := edtPerTol.EditFormat;

        strObs001 := FieldByName('GMT_OBS001').AsString;
        strObs002 := FieldByName('GMT_OBS002').AsString;
        strObs003 := FieldByName('GMT_OBS003').AsString;
        strObs004 := FieldByName('GMT_OBS004').AsString;
        strObs005 := FieldByName('GMT_OBS005').AsString;
        strObs006 := FieldByName('GMT_OBS006').AsString;
        strObs007 := FieldByName('GMT_OBS007').AsString;
      End;

      If Not cdsConsulta.IsEmpty Then
      Begin
        objFormula.Clear;
        cdsConsulta.First;
        While not cdsConsulta.eof do
        Begin
          objMateriaPrima := TMateriaPrima.Create;
          objMateriaPrima.strCodigo           := cdsConsulta.FieldByName('DMT_ITESUB').AsString;
          objMateriaPrima.strDescricao        := cdsConsulta.FieldByName('DMT_DESCRI').AsString;
          objMateriaPrima.fltPercentualFormula:= cdsConsulta.FieldByName('DMT_QTDITE').AsFloat;
          objMateriaPrima.fltCusto            := cdsConsulta.FieldByName('DMT_CUSITE').AsFloat;
          objFormula.lstMateriasPrimas.Add(objMateriaPrima);
          cdsConsulta.Next;
        End;

        cdsConsulta.First;

        strSeqGer := cdsConsulta.FieldByName('DMT_SEQGER').AsString;

        if blnUsaEpi then
          pCarregaEPI(strSeqGer);

        pCarregaAnalise(strSeqGer);

        If fCfgSis('EXMOPI', varBoolean) Then
        Begin
          pCarregaOperador(EdCodOpeExtrusao.Text);
          ObjProcessoExtrusao.pLimpaDataSetProcessoExtrusao;
          ObjProcessoExtrusao.pCarregaDadosExtrusao(cdsConsulta.FieldByName('AUTOINCREM').AsString);
          cxvExtrusao.DataController.DataSource:= ObjProcessoExtrusao.fRetornaDataSourceProcessosExtrusao;
        End;

        //se tiver análise ou epi na importação, pergunta se o usuário deseja importar
        if blnImpEstrutura and ((not cdsGeiAna.IsEmpty) or (not cdsGeiEpi.IsEmpty)) then
        begin
          if fMensagem('', 'Deseja Importar '+IIF(blnUsaEpi,'Análises e EPIs', 'Análises')+' da Estrutura?', ['&Sim', '&Não']) = 2 then
          begin
            cdsGeiAna.EmptyDataSet;
            cdsGeiEpi.EmptyDataSet;
          end;
        end;

        btnConfirma.Enabled   := True;
        btnImprimir.Enabled   := True;
        btnComentario.Enabled := True;
        btnMoveCima.Enabled   := True;
        btnMoveBaixo.Enabled  := True;
        pAtualizaPorcentagemRepresentacaoCusto;

        If Not fEmptyStr(strCodFor) And (Not blnImpEstrutura) Then
          edtCodFormula.Text := strCodFor;

        //pCarregaOps(True);
        pCarregaOps(Not fEmptyStr(edtCodFormula.Text));

      End Else
      Begin
        edtCodFormula.Clear;
        pCarregaOps(False);
      End;

      If not fEmptyStr(edtCodFormula.Text) Then
      Begin
        blnInsert := False;
        dtaDtaCad := cdsConsulta.FieldByName('GMT_DTACAD').AsDateTime;
        HraHraCad := cdsConsulta.FieldByName('GMT_HRACAD').AsDateTime;

        If dtaDtaCad > 0 Then
          edtDtaCad.Text := FormatDateTime('dd/mm/yyyy', dtaDtaCad) + ' ' +
                            FormatDateTime('hh:nn:ss'  , HraHraCad)
        Else
          edtDtaCad.Clear;

        If cdsConsulta.FieldByName('GMT_DTAALT').AsDateTime > 0 Then
          edtDtaAlt.Text := FormatDateTime('dd/mm/yyyy', cdsConsulta.FieldByName('GMT_DTAALT').AsDateTime) + ' ' +
                            FormatDateTime('hh:nn:ss'  , cdsConsulta.FieldByName('GMT_HRAALT').AsDateTime)
        Else
          edtDtaAlt.Clear;

        If Not(fEmptyStr(qryTabela.FieldByName('GMT_CODOPE').AsString)) Then
          edtOpeUltimaAlteracao.Text:= qryTabela.FieldByName('GMT_CODOPE').AsString +' '+ fRetNomeOperador(qryTabela.FieldByName('GMT_CODOPE').AsString)
        Else
        edtOpeUltimaAlteracao.Clear;


        If fCfgSis('EXMOPI', varBoolean) Then
        Begin
          EdCodOpeExtrusao.Text      := cdsConsulta.FieldByName('GMT_OPEEXT').AsString;
          If (Not(qryTabela.FieldByName('GMT_HREXIN').IsNull)) Then
            MskHraInicioExtrusao.Text  := FormatDateTime('hh:mm', cdsConsulta.FieldByName('GMT_HREXIN').Value)
          Else
            MskHraInicioExtrusao.Text  := '';

          If (Not(cdsConsulta.FieldByName('GMT_HREXFN').IsNull)) Then
            MskHraFinalExtrusao.Text   := FormatDateTime('hh:mm', cdsConsulta.FieldByName('GMT_HREXFN').Value)
          Else
            MskHraFinalExtrusao.Text   := '';

          RichObservacaoExtrusao.Text:= cdsConsulta.FieldByName('GMT_OBSEXT').AsString;
          EdtRotacaoRoska.Text       := cdsConsulta.FieldByName('GMT_ROSCA_').AsString;
          edtPicotador.Text          := cdsConsulta.FieldByName('GMT_VELPIC').AsString;
          pCarregaOperador(EdCodOpeExtrusao.Text);
          ObjProcessoExtrusao.pLimpaDataSetProcessoExtrusao;
          ObjProcessoExtrusao.pCarregaDadosExtrusao(qryTabela.FieldByName('AUTOINCREM').AsString);
          cxvExtrusao.DataController.DataSource:= ObjProcessoExtrusao.fRetornaDataSourceProcessosExtrusao;
        End;

      End
      Else
      Begin
        blnInsert := True;
        dtaDtaCad := 0;
        HraHraCad := 0;
        edtDtaAlt.Clear;
        edtDtaCad.Clear;
        edtOpeUltimaAlteracao.Clear;
        pCarregaOps(False);

        If fCfgSis('EXMOPI', varBoolean) Then
        Begin
          pLimparCamposExtrusao;
          cxvExtrusao.DataController.DataSource:= ObjProcessoExtrusao.fRetornaDataSourceProcessosExtrusao(True);
        End;

      End;

      btnEpi.Enabled := blnUsaEpi and ( (not cdsConsulta.IsEmpty) or blnInsert );
      edtSubProduto.Enabled := True;
    end
    else
    begin

      qryGerMat.Close;

      If ( blnImpEstrutura ) And ( Not fEmptyStr( strCodIte ) ) Then
      Begin
        qryGerMat.Params.ParamByName('CODITE').AsString := strCodIte;
        qryGerMat.Params.ParamByName('CODCOR').AsString := strCodCor;
        qryGerMat.Params.ParamByName('CODFOR').AsString := strCodFor;
      End Else
      Begin
        qryGerMat.Params.ParamByName('CODITE').AsString := edtProdutos.Text;
        qryGerMat.Params.ParamByName('CODCOR').AsString := edtCor.Text;
        qryGerMat.Params.ParamByName('CODFOR').AsString := edtCodFormula.Text;
      End;

      qryGerMat.Open;

      strObs001 := qryGerMat.FieldByName('GMT_OBS001').AsString;
      strObs002 := qryGerMat.FieldByName('GMT_OBS002').AsString;
      strObs003 := qryGerMat.FieldByName('GMT_OBS003').AsString;
      strObs004 := qryGerMat.FieldByName('GMT_OBS004').AsString;
      strObs005 := qryGerMat.FieldByName('GMT_OBS005').AsString;
      strObs006 := qryGerMat.FieldByName('GMT_OBS006').AsString;
      strObs007 := qryGerMat.FieldByName('GMT_OBS007').AsString;

      If Not qryGerMat.IsEmpty Then
      Begin
        strSeqGer := qryGerMat.FieldByName('AUTOINCREM').AsString;

        if not blnImpEstrutura then
        begin
          chkForEsp.Checked := qryGerMat.FieldByName('GMT_FORESP').AsBoolean;
          pFormataFormulaEspecial;
        end;

        pCarregaAnalise(strSeqGer);
        btnConfirma.Enabled := True;

        If Not fEmptyStr(strCodFor) And (Not blnImpEstrutura) Then
          edtCodFormula.Text := strCodFor;

        //pCarregaOps(True);
        pCarregaOps(Not fEmptyStr(edtCodFormula.Text));
      End Else
      Begin
        edtCodFormula.Clear;
        pCarregaOps(False);
      End;

      If not fEmptyStr(edtCodFormula.Text) Then
      Begin
        blnInsert := False;
        dtaDtaCad := qryGerMat.FieldByName('GMT_DTACAD').AsDateTime;
        HraHraCad := qryGerMat.FieldByName('GMT_HRACAD').AsDateTime;


        If dtaDtaCad > 0 Then
          edtDtaCad.Text := FormatDateTime('dd/mm/yyyy', dtaDtaCad) + ' ' +
                            FormatDateTime('hh:nn:ss'  , HraHraCad)
        Else
          edtDtaCad.Clear;

        If qryGerMat.FieldByName('GMT_DTAALT').AsDateTime > 0 Then
          edtDtaAlt.Text := FormatDateTime('dd/mm/yyyy', qryGerMat.FieldByName('GMT_DTAALT').AsDateTime) + ' ' +
                            FormatDateTime('hh:nn:ss'  , qryGerMat.FieldByName('GMT_HRAALT').AsDateTime)
        Else
          edtDtaAlt.Clear;

        If Not(fEmptyStr(qryGerMat.FieldByName('GMT_CODOPE').AsString)) Then
          edtOpeUltimaAlteracao.Text:= qryGerMat.FieldByName('GMT_CODOPE').AsString +' '+ fRetNomeOperador(qryGerMat.FieldByName('GMT_CODOPE').AsString)
        Else
          edtOpeUltimaAlteracao.Clear;


        if edtDataDesenvolvimento.Visible then
        begin
          if qryGerMat.FieldByName('GMT_DTAFOR').AsDateTime > 0  then
            edtDataDesenvolvimento.Date :=  qryGerMat.FieldByName('GMT_DTAFOR').AsDateTime
          else
            edtDataDesenvolvimento.Date := VS_Date;;
        end;

      End
      Else
      Begin
        blnInsert := True;
        dtaDtaCad := 0;
        HraHraCad := 0;
        edtDtaAlt.Clear;
        edtDtaCad.Clear;
        edtOpeUltimaAlteracao.Clear;
        pCarregaOps(False);
        btnConfirma.Enabled := True;
      End;
    end;

    If Not(cdsConsulta.IsEmpty) Then
    Begin
      cdsConsulta.First;
      objLogFormulaAlterada.pLimpaDataSetSequenciaOriginalMateriaPrima;
      While Not(cdsConsulta.Eof) Do
      Begin

        objLogFormulaAlterada.pIncluiSequenciaOriginalMateriaPrima(cdsConsulta.FieldByName('AUTOINCREM').AsString,
                                                                   cdsConsulta.FieldByName('DMT_ITESUB').AsString,
                                                                   cdsConsulta.FieldByName('DMT_SEQUEN').AsString,
                                                                   cdsConsulta.FieldByName('DMT_SEQITE').AsString);
        cdsConsulta.Next;
      End;
    End;


    Result := True;

  Finally
    If Assigned(qryGerMat) Then
    Begin
      qryGerMat.Close;
      FreeAndNil(qryGerMat);
    End;
  End;
end;

procedure TfrmCadEstruturasIndustrial.btnMoveCimaClick(Sender: TObject);
  Var
    intSeqAtu: Integer;
    intSeqAnt: Integer;
    intRecNo: Integer;

    strSeqIteAtu: String;
    strSeqIteAnt: String;

    blnMudSeq: Boolean;
begin
  inherited;

  If (blnAltera) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido mover itens em modo de alteração!', ['&O k']);
    Exit;
  End;

  With cdsConsulta Do
  If (RecNo > 1) Then
  Begin
    intSeqAtu    := FieldByName('DMT_SEQUEN').AsInteger;
    strSeqIteAtu := FieldByName('DMT_SEQITE').AsString;

    Prior;

    intSeqAnt    := FieldByName('DMT_SEQUEN').AsInteger;
    strSeqIteAnt := FieldByName('DMT_SEQITE').AsString;

    blnMudSeq := (Not fEmptyStr(strSeqIteAtu)) And (Not fEmptyStr(strSeqIteAnt));

    If Locate('DMT_SEQUEN', intSeqAtu, []) Then
    Begin
      Edit;
      FieldByName('DMT_SEQUEN').AsInteger := MaxInt;
      Post;
    End;

    If (blnMudSeq) And (Locate('DMT_SEQITE', strSeqIteAtu, [])) Then
    Begin
      Edit;
      FieldByName('DMT_SEQITE').AsString := 'AAAAAA';
      Post;
    End;

    If Locate('DMT_SEQUEN', intSeqAnt, []) Then
    Begin
      Edit;
      FieldByName('DMT_SEQUEN').AsInteger := intSeqAtu;
      Post;
    End;

    If (blnMudSeq) And (Locate('DMT_SEQITE', strSeqIteAnt, [])) Then
    Begin
      Edit;
      FieldByName('DMT_SEQITE').AsString := strSeqIteAtu;
      Post;
    End;

    If Locate('DMT_SEQUEN', MaxInt, []) Then
    Begin
      Edit;
      FieldByName('DMT_SEQUEN').AsInteger := intSeqAnt;
      Post;
    End;

    If (blnMudSeq) And (Locate('DMT_SEQITE', 'AAAAAA', [])) Then
    Begin
      Edit;
      FieldByName('DMT_SEQITE').AsString := strSeqIteAnt;
      Post;
    End;

    intRecNo := cdsConsulta.RecNo;
    Try
      cdsConsulta.First;
      objLogFormulaAlterada.cdsDataSet := cdsConsulta;
      While Not(cdsConsulta.Eof) Do
      Begin
        objLogFormulaAlterada.pIncluiSequenciaOriginalMateriaPrima(cdsConsulta.FieldByName('AUTOINCREM').AsString,
                                                                   cdsConsulta.FieldByName('DMT_ITESUB').AsString,
                                                                   cdsConsulta.FieldByName('DMT_SEQUEN').AsString,
                                                                   cdsConsulta.FieldByName('DMT_SEQITE').AsString,
                                                                   True);
        cdsConsulta.Next;
      End;
    Finally
      cdsConsulta.RecNo := intRecNo;
    End;
  End;
end;

procedure TfrmCadEstruturasIndustrial.btnSubstituirClick(Sender: TObject);
begin
  inherited;
  pTrocarSubstituirProduto;
end;

procedure TfrmCadEstruturasIndustrial.cdsConsultaAfterScroll(DataSet: TDataSet);
begin
  inherited;
  btnSubstituir.Enabled := (Not cdsConsulta.IsEmpty) And
                           (Not fEmptyStr(cdsConsulta.FieldByName('DMT_ITESUB').AsString));
end;

procedure TfrmCadEstruturasIndustrial.chkForEspClick(Sender: TObject);
begin
  inherited;
  pFormataFormulaEspecial;
end;

procedure TfrmCadEstruturasIndustrial.chkForEspKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  pFormataFormulaEspecial;
end;

procedure TfrmCadEstruturasIndustrial.cxvExtrusaoEditKeyDown(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_INSERT) Or (Key = VK_UP) Or (Key = VK_DOWN) Or (Key = Vk_Return) Then
  Begin
    If cxvExtrusao.DataController.DataSource.DataSet.State in [DsInsert, DsEdit] Then
    Begin
      If fEmptyStr(cxvExtrusao.DataController.DataSource.DataSet.FieldByName('NOMTER').AsString) Then
        cxvExtrusao.DataController.DataSource.DataSet.Cancel;
      End;
  End;

  If (Key = Vk_Return) Then
  Begin
    If cxvExtrusao01.Focused Then
      cxvExtrusao02.Focused:= True
    Else
    If cxvExtrusao02.Focused Then
      cxvExtrusao03.Focused:= True
    Else
    If cxvExtrusao03.Focused Then
    Begin
      If cxvExtrusao.DataController.DataSource.DataSet.FindNext Then
        cxvExtrusao01.Focused := True
      Else
      pSetFocus(edtRotacaoRoska);

    End;
  End;

end;

procedure TfrmCadEstruturasIndustrial.pFormataFormulaEspecial;
begin
  tbsFormula.tabvisible := not chkForEsp.Checked;
  if tbsFormula.TabVisible then
    PageControl.ActivePage := tbsFormula;

  btnComentario.Visible := not chkForEsp.Checked;
  btnMoveCima.Visible := not chkForEsp.Checked;
  btnMoveBaixo.Visible := not chkForEsp.Checked;
  btnSubstituir.Visible := not chkForEsp.Checked;
  btnImprimir.Visible := not chkForEsp.Checked;

  blnTrabalhaComFaseParaFormulasEspeciais:= chkForEsp.Checked And
                                            fCfgSis('FASESP', varBoolean);
  tbsFases.TabVisible:= blnTrabalhaComFaseParaFormulasEspeciais;
end;

procedure TfrmCadEstruturasIndustrial.btnMoveBaixoClick(Sender: TObject);
  Var
    intSeqAtu: Integer;
    intSeqAnt: Integer;
    intRecNo: Integer;

    strSeqIteAtu: String;
    strSeqIteAnt: String;

    blnMudSeq: Boolean;
begin
  inherited;

  If (blnAltera) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido mover itens em modo de alteração!', ['&O k']);
    Exit;
  End;

  With cdsConsulta Do
  If (RecNo < RecordCount) Then
  Begin
    intSeqAtu    := FieldByName('DMT_SEQUEN').AsInteger;
    strSeqIteAtu := FieldByName('DMT_SEQITE').AsString;

    Next;

    intSeqAnt    := FieldByName('DMT_SEQUEN').AsInteger;
    strSeqIteAnt := FieldByName('DMT_SEQITE').AsString;

    blnMudSeq := (Not fEmptyStr(strSeqIteAtu)) And (Not fEmptyStr(strSeqIteAnt));

    If Locate('DMT_SEQUEN', intSeqAtu, []) Then
    Begin
      Edit;
      FieldByName('DMT_SEQUEN').AsInteger := MaxInt;
      Post;
    End;

    If (blnMudSeq) And (Locate('DMT_SEQITE', strSeqIteAtu, [])) Then
    Begin
      Edit;
      FieldByName('DMT_SEQITE').AsString := 'AAAAAA';
      Post;
    End;

    If Locate('DMT_SEQUEN', intSeqAnt, []) Then
    Begin
      Edit;
      FieldByName('DMT_SEQUEN').AsInteger := intSeqAtu;
      Post;
    End;

    If (blnMudSeq) And (Locate('DMT_SEQITE', strSeqIteAnt, [])) Then
    Begin
      Edit;
      FieldByName('DMT_SEQITE').AsString := strSeqIteAtu;
      Post;
    End;

    If Locate('DMT_SEQUEN', MaxInt, []) Then
    Begin
      Edit;
      FieldByName('DMT_SEQUEN').AsInteger := intSeqAnt;
      Post;
    End;

    If (blnMudSeq) And (Locate('DMT_SEQITE', 'AAAAAA', [])) Then
    Begin
      Edit;
      FieldByName('DMT_SEQITE').AsString := strSeqIteAnt;
      Post;
    End;

    intRecNo := cdsConsulta.RecNo;
    Try
      cdsConsulta.First;
      objLogFormulaAlterada.cdsDataSet := cdsConsulta;
      While Not(cdsConsulta.Eof) Do
      Begin
        objLogFormulaAlterada.pIncluiSequenciaOriginalMateriaPrima(cdsConsulta.FieldByName('AUTOINCREM').AsString,
                                                                   cdsConsulta.FieldByName('DMT_ITESUB').AsString,
                                                                   cdsConsulta.FieldByName('DMT_SEQUEN').AsString,
                                                                   cdsConsulta.FieldByName('DMT_SEQITE').AsString,
                                                                   True);
        cdsConsulta.Next;
      End;
    Finally
      cdsConsulta.RecNo := intRecNo;
    End;

  End;

end;

function TfrmCadEstruturasIndustrial.fBuscaEstrutura( blnImportacao: Boolean ): String;
  Var
    arrSel : TConsultasArray;
    chrKey : Char;
    objFrmPnl: TPanelCxFormula;
begin
  objFrmPnl := TPanelCxFormula.Create(TfrmPnlDadosFormula);
  if not Assigned(qryTabela) then
    qryTabela := fCriaQuery(nil);
  Try
    chrKey := '/';

    If fPesqEstruturaIndustrial(Self, nil, qryTabela, chrKey, arrSel, True, 'Consulta de Estruturas', objFrmPnl) Then
    Begin

      If blnImportacao Then
      Begin
        Result := qryTabela.FieldByName('GMT_CODITE').AsString + '+' +
                  qryTabela.FieldByName('GMT_CODCOR').AsString + '+' +
                  qryTabela.FieldByName('GMT_FORMUL').AsString;
      End
      Else
      Begin

        edtProdutos.Text         := qryTabela.FieldByName('GMT_CODITE').AsString;
        edtCor.Text              := qryTabela.FieldByName('GMT_CODCOR').AsString;
        edtCodFormula.Text       := qryTabela.FieldByName('GMT_FORMUL').AsString;
        edtPesRea.Text           := FormatFloat('#0.0000', qryTabela.FieldByName('GMT_PESREA').AsFloat);
        chkForEsp.Checked        := qryTabela.FieldByName('GMT_FORESP').AsBoolean;
        RichDescProcProducao.Text:= qryTabela.FieldByName('GMT_OBS008').AsString;

        If fCfgSis('EXMOPI', varBoolean) Then
        Begin
          EdCodOpeExtrusao.Text      := qryTabela.FieldByName('GMT_OPEEXT').AsString;
          If (Not(qryTabela.FieldByName('GMT_HREXIN').IsNull)) Then
            MskHraInicioExtrusao.Text  := FormatDateTime('hh:mm', qryTabela.FieldByName('GMT_HREXIN').Value)
          Else
            MskHraInicioExtrusao.Text  := '';

          If (Not(qryTabela.FieldByName('GMT_HREXFN').IsNull)) Then
            MskHraFinalExtrusao.Text   := FormatDateTime('hh:mm', qryTabela.FieldByName('GMT_HREXFN').Value)
          Else
            MskHraFinalExtrusao.Text   := '';

          RichObservacaoExtrusao.Text:= qryTabela.FieldByName('GMT_OBSEXT').AsString;
          EdtRotacaoRoska.Text       := qryTabela.FieldByName('GMT_ROSCA_').AsString;
          edtPicotador.Text          := qryTabela.FieldByName('GMT_VELPIC').AsString;
          pCarregaOperador(EdCodOpeExtrusao.Text);
          ObjProcessoExtrusao.pLimpaDataSetProcessoExtrusao;
          ObjProcessoExtrusao.pCarregaDadosExtrusao(qryTabela.FieldByName('AUTOINCREM').AsString);
          cxvExtrusao.DataController.DataSource:= ObjProcessoExtrusao.fRetornaDataSourceProcessosExtrusao;
        End;

        if edtDataDesenvolvimento.Visible then
        begin
          if qryTabela.FieldByName('GMT_DTAFOR').AsDateTime > 0  then
            edtDataDesenvolvimento.Date :=  qryTabela.FieldByName('GMT_DTAFOR').AsDateTime
          else
            edtDataDesenvolvimento.Date := VS_Date;;
        end;

        pFormataFormulaEspecial;

        rdgStatus.ItemIndex := IIF(qryTabela.FieldByName('GMT_STATUS').AsString = 'A', 0, 1);

        If blnTrabalhaComFaseParaFormulasEspeciais Then
        Begin
          objCadFaseFormulaEspecial.strAutoIncremGeiMat:= qryTabela.FieldByName('AUTOINCREM').AsString;
          objCadFaseFormulaEspecial.pCarregaFaseFormulaEspecial;
        End;

        pCarregaProduto(qryConIte);
        pCarregaCor(qryConCor);
        fCarregaEstrutura;
        pAtualizaTemporaria(1);

        If fHabilitaEdicao And (cdsConsulta.Active) Then
          pHabilitaCampos;

        if tbsFormula.TabVisible then
          pSetFocus(edtSubProduto)
        else
          pSetFocus(edtCodAna);

      End;
      edtSubProduto.Enabled := True;
    End;
  Finally
    FreeAndNil(objFrmPnl);
  End;

End;

Procedure TfrmCadEstruturasIndustrial.pCarregaOps(blnCarregar: Boolean);
Begin
  If blnCarregar Then
  begin
    strNumOps := TOrdProIndustrial.fRetOrdemProducao(qryTabela.FieldByName('GMT_FORMUL').AsInteger,
                                                     qryTabela.FieldByName('GMT_CODITE').AsString,
                                                     qryTabela.FieldByName('GMT_CODCOR').AsString);
  end
  Else
    strNumOps := '';


  lblMostraOps.Visible        := Not fHabilitaEdicao;
  btnApaga.Enabled            := fHabilitaEdicao and (not blnInsert);
  btnMoveCima.Enabled         := fHabilitaEdicao;
  btnMoveBaixo.Enabled        := fHabilitaEdicao;
  btnComentario.Enabled       := fHabilitaEdicao;
  btnConfirma.Enabled         := fHabilitaEdicao;
  btnSubstituir.Enabled       := fHabilitaEdicao;
  pnlSubProdutos.Enabled      := fHabilitaEdicao;
  pnlFasesEspecial.Enabled    := fHabilitaEdicao;
  pnlCapacidadeMaxima.Enabled := fHabilitaEdicao;
  dbgDados.Enabled            := fHabilitaEdicao;
  pnlAnalises.Enabled         := fHabilitaEdicao;
  dbgAnalise.Enabled          := fHabilitaEdicao;
  btnEpi.Enabled              := fHabilitaEdicao;
  tbsAnalise.Enabled          := fHabilitaEdicao;
  edtPesRea.Enabled           := fHabilitaEdicao;
End;

function TfrmCadEstruturasIndustrial.fHabilitaEdicao : boolean;
begin
  Result := fEmptyStr(strNumOps) or fCfgSis('FORORP', varBoolean);
end;

function TfrmCadEstruturasIndustrial.fInativaFormulas(strCodIte, strCodCor,
  strFormul: String): Boolean;
Var
  strSQL: string;
  qryFor: TUniQuery;
begin

  Try

    qryFor := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE   ';
    strSQL := strSQL + '  GEIMAT ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  GMT_STATUS = "I" ';
    strSQL := strSQL + 'WHERE              ';
    strSQL := strSQL + '  GMT_CODITE =  :CODITE AND ';
    strSQL := strSQL + '  GMT_CODCOR =  :CODCOR AND ';
    strSQL := strSQL + '  GMT_FORMUL <> :FORMUL     ';

    With qryFor  Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODCOR').AsString := strCodCor;
      ParamByName('FORMUL').AsString := strFormul;
      ExecSQL;
      Result := True;
    End;

  Finally
    FreeAndNil(qryFor);
  End;

end;

procedure TfrmCadEstruturasIndustrial.FormShow(Sender: TObject);
begin
  inherited;
  qryConIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
  qryConCor := fCriarQuery('SELECT * FROM CADCOR WHERE FALSE', Self);
  qryConFas := fCriarQuery('SELECT * FROM CADFAS WHERE FALSE', Self);

  //Diferente do modelo com a descrição procedimento produção
  If (fCfgSis('MDORIN', varString) <> '10') And (fCfgSis('MDORIN', varString) <> '13') Then
    TbsDescProcedimentoProd.TabVisible:= False;

  blnAltera := False;
  strSeqAlt := '';

  pSetaCodIte( edtProdutos );
  pSetaCodIte( edtSubProduto );

  If FFecharAoConfirmar Then
  Begin
    fValidaCampos(edtProdutos, True);
    fValidaCampos(edtCor, True);
    fValidaCampos(edtCodFormula, True);

    fCarregaEstrutura;
  End;

end;

function TfrmCadEstruturasIndustrial.fVerificaPermissaoDelEst : Boolean;
Begin
  objLiberacao.Clear;
  objLiberacao.objMsglibera.pAddTexto('APAGAR ESTRUTURA');
  objLiberacao.objMsglibera.pAddTextoCaption('ESTRUTURA'         , edtProdutos.Text + ' - ' + edtDesProduto.Text);
  objLiberacao.objMsglibera.pAddTextoCaption('REFERÊNCIA'        , edtReferencia.Text);
  objLiberacao.objMsglibera.pAddTextoCaption('COR'               , edtCor.Text + ' - ' + edtDesCor.Text);
  objLiberacao.objMsglibera.pAddTextoCaption('CÓDIGO DA FÓRMULA' , edtCodFormula.Text);
  objLiberacao.objMsglibera.pAddQuebra;

  IF cdsCOnsulta.Active then
  begin
    cdsConsulta.DisableControls;
    cdsConsulta.First;
    While not cdsConsulta.Eof Do
    Begin
      objLiberacao.objMsglibera.pAddTexto(cdsConsulta.FieldByName('DMT_ITESUB').AsString + ' - ' +
                                          cdsConsulta.FieldByName('DMT_DESCRI').AsString);

      cdsConsulta.Next;
    End;
    cdsConsulta.First;
    cdsConsulta.EnableControls;
  end;

  objLiberacao.strDirAce := 'DELEST';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.blnUsarSenhaFixa := False;
  objLiberacao.blnSempreVariavelUsuario := True;

  Result := objLiberacao.fLibera;
End;

procedure TfrmCadEstruturasIndustrial.lblMostraOpsClick(Sender: TObject);
begin

  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(149, 6904, [],
                        ['FORMUL','CODITE','CODCOR'],
                        [IntToStr(qryTabela.FieldByName('GMT_FORMUL').AsInteger),
                        qryTabela.FieldByName('GMT_CODITE').AsString,
                        qryTabela.FieldByName('GMT_CODCOR').AsString],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmCadEstruturasIndustrial.LimpaObjFormulaAlterada;
begin

  objLogFormulaAlterada.strCodIte        := '';
  objLogFormulaAlterada.strCodCor        := '';
  objLogFormulaAlterada.strDesSub        := '';
  objLogFormulaAlterada.strCodEmp        := '';
  objLogFormulaAlterada.strDtaHra        := '';
  objLogFormulaAlterada.strCodOpe        := '';
  objLogFormulaAlterada.strIteSub        := '';
  objLogFormulaAlterada.strForMul        := '';
  objLogFormulaAlterada.strCodFas        := '';
  objLogFormulaAlterada.strSequen        := '';
  objLogFormulaAlterada.strSubQtd        := '';
  objLogFormulaAlterada.strPerTol        := '';
  objLogFormulaAlterada.strSeqOld        := '';
  objLogFormulaAlterada.strForEsp        := '';
  objLogFormulaAlterada.strStatus        := '';
  objLogFormulaAlterada.strObs001        := '';
  objLogFormulaAlterada.strObs002        := '';
  objLogFormulaAlterada.strObs003        := '';
  objLogFormulaAlterada.strObs004        := '';
  objLogFormulaAlterada.strObs005        := '';
  objLogFormulaAlterada.strObs006        := '';
  objLogFormulaAlterada.strObs007        := '';
  objLogFormulaAlterada.strPesRea        := '';

  objLogFormulaAlterada.cdsDataSet     := Nil;
  objLogFormulaAlterada.cdsDataSetFormula:= Nil;
  objLogFormulaAlterada.dftTabTem      := NIl;
  objLogFormulaAlterada.blnGravaBanco  := False;
  objLogFormulaAlterada.pLimpaDataSetSequenciaOriginalMateriaPrima;
  memLogTemp.Close;

end;

procedure TfrmCadEstruturasIndustrial.MskHraFinalExtrusaoKeyPress(
  Sender: TObject; var Key: Char);
begin
  inherited;
  If (Key = #13) Then
  Begin
    pSetFocus(cxgExtrusao);
    cxvExtrusao01.Focused := True;
  End;
end;

procedure TfrmCadEstruturasIndustrial.MskHraInicioExtrusaoExit(Sender: TObject);
begin
  inherited;
  If Not(fValidaCampos(MskHraInicioExtrusao, True)) Then
    Exit;
end;

procedure TfrmCadEstruturasIndustrial.btnApagaClick(Sender: TObject);
Var
  strSql: String;
  qryGenMat : TUniQuery;
begin
  if not fVerificaPermissaoDelEst Then
    Exit;

  inherited;

  Try

    qryGenMat := fCriaQuery(Self);

    If ( fEmptyStr( edtProdutos.Text ) Or fEmptyStr( strSeqGer ) ) Then
    Begin
      fMensagem('AVISO','É necessário selecionar uma estrutura antes.', ['&O K']);
      Exit;
    End;

    If ( fMensagem( '', 'Apagar Estrutura?', ['&Sim', '&Não'], 2 ) = 2 ) Then
      Exit;

    With qryGenMat Do
    Begin


      strSql := '';
      strSql := strSql + ' SELECT * FROM DEIMAT ';
      strSql := strSql + ' WHERE DMT_SEQGER=:AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName( 'AUTINC' ).AsString := strSeqGer;
      Open;
      While not Eof Do
      Begin
        fVerificaIntegridade(Self.Name, 'DEIMAT', qryGenMat);
        Next;
      End;
      Close;

      strSql := '';
      strSql := strSql + ' DELETE FROM DEIMAT ';
      strSql := strSql + ' WHERE DMT_SEQGER=:AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName( 'AUTINC' ).AsString := strSeqGer;
      ExecSql;
      Close;


      strSql := '';
      strSql := strSql + ' SELECT * FROM GEIMAT ';
      strSql := strSql + ' WHERE AUTOINCREM=:AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName( 'AUTINC' ).AsString := strSeqGer;
      Open;
      While not Eof Do
      Begin
        fVerificaIntegridade(Self.Name, 'GEIMAT', qryGenMat);
        Next;
      End;
      Close;

      pGravaLogFormula(qryTabela.FieldByName('GMT_CODCOR').AsString,
                     '',
                     qryTabela.FieldByName('GMT_CODITE').AsString,
                     '',
                     qryTabela.FieldByName('GMT_FORMUL').AsString,
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '',
                     '', '','','',
                     True, False, False);


      strSql := '';
      strSql := strSql + ' DELETE FROM GEIMAT ';
      strSql := strSql + ' WHERE AUTOINCREM=:AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName( 'AUTINC' ).AsString := strSeqGer;
      ExecSql;
      Close;

      strSql := '';
      strSql := strSql + ' DELETE FROM GEIEXT ';
      strSql := strSql + ' WHERE GXT_SEQGMT=:AUTINC ';

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName( 'AUTINC' ).AsString := strSeqGer;
      ExecSql;
      Close;

    End;

    If (memLogTemp.RecordCount > 0) And Not(fEmptyStr(edtCodFormula.Text)) Then
    Begin
      objLogFormulaAlterada.blnGravaBanco  := True;
      objLogFormulaAlterada.pGravaLogFormula;
    End;


    pLimparDados;

  Finally
    FreeAndNil(qryGenMat);
  End;
end;


procedure TfrmCadEstruturasIndustrial.btnImprimirClick(Sender: TObject);
Var
  strNomeFila: String;
  strTipImp: String;
  qckRel: TfrxReport;
  strTabPre: String;
  blnPreVen: Boolean;
  blnPreCus: Boolean;
  blnRefere: Boolean;
  blnGExcel: Boolean;
  blnTemDados: Boolean;
  blnImpSubItem: Boolean;
  strPesEsp: String;
  frmOpcRelEstruturaIndustrial: TfrmOpcRelEstruturaIndustrial;
  qryEstInd: TUniQuery;
  fltForTot,
  fltForTlt,
  fltPesRea: Double;
begin
  inherited;

  if not fCfgSis('CHKEDI', varBoolean) then
  begin
    pCriarFormularios(TfrmOpcRelEstruturaIndustrial, frmOpcRelEstruturaIndustrial);
    frmOpcRelEstruturaIndustrial.ShowModal;
    If (frmOpcRelEstruturaIndustrial.ModalResult = mrOk) Then
    Begin
      blnPreCus    := frmOpcRelEstruturaIndustrial.rdbPrecoCus.Checked;
      blnPreVen    := frmOpcRelEstruturaIndustrial.rdbPrecoVen.Checked;
      strTabPre    := frmOpcRelEstruturaIndustrial.cbTabPreco.Text;
      blnRefere    := frmOpcRelEstruturaIndustrial.rdbReferenc.Checked;
      blnGExcel    := frmOpcRelEstruturaIndustrial.chkExcel.Checked;
      blnImpSubItem:= frmOpcRelEstruturaIndustrial.rdbImprimiForSubSim.Checked;
      strTabPreRel := strTabPre;

      pCarregaFormulaSubItensRel;

      If Not blnGExcel Then
      Begin
        frxRelatorio.DataSet := cdsConsulta;

        pCarregaConfImpr(qryCfgRel, Self.Name);
        strNomeFila := qryCfgRel.FieldByName('REL_NOMFIL').AsString;
        strTipImp   := qryCfgRel.FieldByName('REL_IDEIMP').AsString;

        If (strTipImp = 'M') Then
        Begin
          If blnPreVen Then
            qckRel := frxPaginaM
          Else If blnPreCus Then
          Begin
            If pnlCusLT.Visible Then
              qckRel := frxPreCusLitroM
            Else
              qckRel := frxPreCusM;
          End
          Else
            qckRel := frxSemPrecoM;
        End
        Else
        Begin
          If blnPreVen Then
            qckRel := frxPaginaJ
          Else If blnPreCus Then
          Begin
            If pnlCusLT.Visible Then
              qckRel := frxPreCusLitroJ
            Else
              qckRel := frxPreCusJ;
          End
          Else
            qckRel := frxSemPrecoJ;
        End;

        qckRel.Script.Variables['EMPRESA']   := fRetNomeEmpresa;
        qckRel.Script.Variables['ESTRUTURA'] := 'ESTRUTURA: ' + edtDesProduto.Text;

        qckRel.AddFunction('function fAbreFormulaSubItensRel(strCodIte: String): Boolean;');

        If blnPreVen Then
        Begin
          TfrxMemoView(qckRel.FindObject('rdbValIte')).Text := '[<frxRelatorio."ITE_PREVE' + strTabPre + '">]';
          TfrxMemoView(qckRel.FindObject('rdbValTot')).Text := '[<frxRelatorio."ITE_PREVE' + strTabPre + '"> * <frxRelatorio."DMT_QTDITE">]';
          TfrxMemoView(qckRel.FindObject('rdbSumTot')).Text := '[SUM(<frxRelatorio."ITE_PREVE' + strTabPre + '"> * <frxRelatorio."DMT_QTDITE">,rlbDetalhes)]';
        End
        Else If blnPreCus Then
        Begin
          TfrxMemoView(qckRel.FindObject('rdbValIte')).Text := '[<frxRelatorio."ITE_PRECUS">]';
          TfrxMemoView(qckRel.FindObject('rdbValTot')).Text := '[<frxRelatorio."ITE_PRECUS"> * <frxRelatorio."DMT_QTDITE"> / 100]';
          TfrxMemoView(qckRel.FindObject('rdbSumTot')).Text := FormatFloat('#,##0.0000', objFormula.fRetornaCustoProducaoTotalKilo(1));

          If pnlCusLT.Visible Then
          Begin
            strPesEsp := ReplaceStr(FormatFloat('0.0000',fStrToFloat(edtPesRea.Text)), ',', '.');
            TfrxMemoView(qckRel.FindObject('rdbValTotLT')).Text := '[(<frxRelatorio."ITE_PRECUS"> * <frxRelatorio."DMT_QTDITE"> / 100) * ' + strPesEsp + ']';
            TfrxMemoView(qckRel.FindObject('rdbSumTotLT')).Text := FormatFloat('#,##0.0000', fConverteLitroParaKilo(fStrToFloat(edtPesRea.Text), objFormula.fRetornaCustoProducaoTotalKilo(1)));
          End;
        End;

        If blnRefere Then
          TfrxMemoView(qckRel.FindObject('rdbDesIte')).Text := '[<frxRelatorio."DMT_REFERE">]'
        Else
          TfrxMemoView(qckRel.FindObject('rdbDesIte')).Text := '[<frxRelatorio."DMT_DESCRI">]';

        If blnImpSubItem Then
        Begin
          If blnRefere Then
            TfrxMemoView(qckRel.FindObject('rdbDesIteDet')).Text := '[frxFormIte."ITE_REFERE"]'
          Else
            TfrxMemoView(qckRel.FindObject('rdbDesIteDet')).Text := '[frxFormIte."ITE_DESITE"]';
        End;

        TfrxDetailData(qckRel.FindComponent('detDetalhe')).Visible := blnImpSubItem;

        pPreviewReport(Self.Name, Self.Caption, qckRel);
      End
      Else
        pGeraExcel(blnPreCus, blnPreVen, blnRefere, cdsConsulta);
    End;

    pFreeAndNil(frmOpcRelEstruturaIndustrial);
  end
  else
  begin
    blnTemDados := False;
    fltForTot := 0;
    fltForTlt := 0;
    fltPesRea := 0;
    if cdsConsulta.Active  then
    begin
      cdsConsulta.First;
      while not cdsConsulta.Eof do
      begin
        if not blnTemDados then
        begin
          qryEstInd := fCriaQuery;
          qryEstInd.SQL.Clear;
          qryEstInd.SQL.Add('DROP TEMPORARY TABLE IF EXISTS TMP_ESTIND;');
          qryEstInd.SQL.Add('CREATE TEMPORARY TABLE TMP_ESTIND(');
          qryEstInd.SQL.Add('  TMP_REFERE VARCHAR(16),         ');
          qryEstInd.SQL.Add('  TMP_CODITE VARCHAR(7),          ');
          qryEstInd.SQL.Add('  TMP_ITESUB VARCHAR(7),          ');
          qryEstInd.SQL.Add('  TMP_DESCRI VARCHAR(70),         ');
          qryEstInd.SQL.Add('  TMP_DESFAS VARCHAR(30),         ');
          qryEstInd.SQL.Add('  TMP_QTDITE DECIMAL(12,4),       ');
          qryEstInd.SQL.Add('  TMP_PRECUS DECIMAL(12,4),       ');
          qryEstInd.SQL.Add('  TMP_PREMED DECIMAL(12,4),       ');
          qryEstInd.SQL.Add('  TMP_DTAULT DATE,                ');
          qryEstInd.SQL.Add('  TMP_PESREA DECIMAL(12,4),       ');
          qryEstInd.SQL.Add('  TMP_FORTOT DECIMAL(12,4),       ');
          qryEstInd.SQL.Add('  TMP_FORTLT DECIMAL(12,4)        ');
          qryEstInd.SQL.Add(');                                ');
          qryEstInd.SQL.Add('SET @ESTRUT := CONCAT("ESTRUTURA: ", UPPER(' + QuotedStr(edtDesProduto.Text) + '));');
          qryEstInd.SQL.Add('SET @DESCOR := CONCAT("COR: ", UPPER(' + QuotedStr(edtCor.Text) + '), " - ", UPPER(' + QuotedStr(edtDesCor.Text) + '));');
          qryEstInd.ExecSQL;
          fltForTot := objFormula.fRetornaCustoProducaoTotalKilo(1);
          if fCfgSis('CUSCAD', varInteger) = 2 then
          begin
            fltForTlt := fConverteLitroParaKilo(fStrToFloat(edtPesRea.Text), objFormula.fRetornaCustoProducaoTotalKilo(1));
            fltPesRea := fStrToFloat(edtPesRea.Text);
          end;
          blnTemDados := True;
        end;
        qryEstInd.SQL.Clear;
        qryEstInd.SQL.Add('INSERT INTO TMP_ESTIND(');
        qryEstInd.SQL.Add('  TMP_REFERE, TMP_CODITE, TMP_ITESUB, TMP_DESCRI, TMP_DESFAS, TMP_QTDITE, TMP_PRECUS, TMP_PREMED, TMP_DTAULT, TMP_PESREA, TMP_FORTOT, TMP_FORTLT');
        qryEstInd.SQL.Add(')VALUES(');
        qryEstInd.SQL.Add('  :REFERE, :CODITE, :ITESUB, :DESCRI, :DESFAS, :QTDITE, :PRECUS, :PREMED, :DTAULT, :PESREA, :FORTOT, :FORTLT');
        qryEstInd.SQL.Add(');');
        qryEstInd.ParamByName('REFERE').AsString   := cdsConsulta.FieldByName('DMT_REFERE').AsString;
        qryEstInd.ParamByName('CODITE').AsString   := edtProdutos.Text;
        qryEstInd.ParamByName('ITESUB').AsString   := cdsConsulta.FieldByName('DMT_ITESUB').AsString;
        qryEstInd.ParamByName('DESCRI').AsString   := cdsConsulta.FieldByName('DMT_DESCRI').AsString;
        qryEstInd.ParamByName('DESFAS').AsString   := cdsConsulta.FieldByName('FAS_DESFAS').AsString;
        qryEstInd.ParamByName('QTDITE').AsFloat    := cdsConsulta.FieldByName('DMT_QTDITE').AsFloat;
        qryEstInd.ParamByName('PRECUS').AsFloat    := cdsConsulta.FieldByName('ITE_PRECUS').AsFloat;
        qryEstInd.ParamByName('PREMED').AsFloat    := cdsConsulta.FieldByName('ITE_PREMED').AsFloat;
        qryEstInd.ParamByName('DTAULT').AsDateTime := cdsConsulta.FieldByName('ITE_DTAULT').AsDateTime;
        qryEstInd.ParamByName('PESREA').AsFloat    := fltPesRea;
        qryEstInd.ParamByName('FORTOT').AsFloat    := fltForTot;
        qryEstInd.ParamByName('FORTLT').AsFloat    := fltForTlt;
        qryEstInd.ExecSQL;
        cdsConsulta.Next;
      end;
    end;

    if blnTemDados then
    begin
      if Assigned(prcExecutaRelatorio) then
      begin
        if strTipImp = 'M' then
          prcExecutaRelatorio(246, 8272, [], [], [], Sender, nil)
        else
          prcExecutaRelatorio(245, 8268, [], [], [], Sender, nil);
      end;
      FreeAndNil(qryEstInd);
    end;
  end;

end;

procedure TfrmCadEstruturasIndustrial.pCarregaItemAlteracao;
begin
  If (cdsConsulta.IsEmpty) Then
    Exit;

  If (blnAltera) Then
  Begin
    fMensagem('ATENÇÃO!', 'Existe um item em edição, antes de continuar cancele ou confirme a alteração!', ['&O k']);
    Exit;
  End;

  // SE NAO É COMENTARIO
  If Not fEmptyStr(cdsConsulta.FieldByName('DMT_ITESUB').AsString) Then
  Begin
    edtSubProduto.Text := cdsConsulta.FieldByName('DMT_ITESUB').AsString;
    pCarregaSubProduto(qryConIte);

    edtCodFas.Text := cdsConsulta.FieldByName('DMT_CODFAS').AsString;
    edtDesFas.Text := fRetDescricaoFase(edtCodFas.Text);
    edtSubQtdIte.Text := FormatFloat(edtSubQtdIte.EditFormat, cdsConsulta.FieldByName('DMT_QTDITE').AsFloat);
    edtPerTol.Text := FormatFloat(edtPerTol.EditFormat, cdsConsulta.FieldByName('DMT_PERTOL').AsFloat);

    pSetFocus(edtCodFas);

    blnAltera   := True;
    strSeqAlt   := cdsConsulta.FieldByName('DMT_SEQUEN').AsString;
    edtSeq.Text := cdsConsulta.FieldByName('DMT_SEQUEN').AsString;
  End
  Else
  Begin

    pCriarFormularios(TfrmComentEstrutura,frmComentEstrutura);
    With frmComentEstrutura Do
    Begin
      edtComentario.MaxLength := 100;
      edtComentario.TamCampo  := 100;

      edtComentario.Text := cdsConsulta.FieldByName('DMT_DESCRI').AsString;
      edtCodFas.Text     := cdsConsulta.FieldByName('DMT_CODFAS').AsString;
      edtDesFas.Text     := fRetDescricaoFase(cdsConsulta.FieldByName('DMT_CODFAS').AsString);
      edtSeq.Text        := cdsConsulta.FieldByName('DMT_SEQUEN').AsString;

      frmComentEstrutura.ShowModal;

      If frmComentEstrutura.blnConfirma Then
      Begin
        strSeqAlt   := cdsConsulta.FieldByName('DMT_SEQUEN').AsString;



        strComent := edtComentario.Text;

        pGravaLogFormula(edtCor.Text,
                         cdsConsulta.FieldByName('DMT_SEQUEN').AsString,
                         edtProdutos.Text,
                         cdsConsulta.FieldByName('DMT_ITESUB').AsString,
                         edtCodFormula.Text,
                         cdsConsulta.FieldByName('DMT_CODFAS').AsString,
                         cdsConsulta.FieldByName('DMT_SEQUEN').AsString,
                         FormatFloat(edtSubQtdIte.EditFormat, cdsConsulta.FieldByName('DMT_QTDITE').AsFloat),
                         FormatFloat(edtPerTol.EditFormat, cdsConsulta.FieldByName('DMT_PERTOL').AsFloat),
                         '','','','','','','','','','',
                         False, True, False, False, True, strComent);


        blnAltera := True;
        pGravaTemporaria('', '', strComent,
                         edtCodFas.Text,
                         edtDesFas.Text,
                         0.00,
                         0.00,
                         StrToIntDef(frmComentEstrutura.edtSeq.Text,0));

        blnAltera := False;
      End;
    End;

    pFreeAndNil(frmComentEstrutura);

  End;

  edtSubProduto.Enabled := not(blnAltera);

end;

procedure TfrmCadEstruturasIndustrial.pCalcularTotaisProdutos;
  var
    cdsDados: TUniClientDataSet;
    fltPVC,
    fltCPVC,
    fltPVCCPVC,
    fltMassaSolidos,
    fltVolumeSolidos: Double;
begin
  If cdsConsulta.Active And (Not cdsConsulta.IsEmpty) Then
  Begin
    cdsDados := TUniClientDataSet.Create(nil);
    cdsDados.Data := cdsConsulta.Data;

    pCalculaPesoEspecificoSubItens(cdsDados,
                                   intMaxSeqGer,
                                   fltTotPercen,
                                   fltTotCusIte,
                                   fltTotDensid,
                                   fltPVC,
                                   fltCPVC,
                                   fltPVCCPVC,
                                   fltMassaSolidos,
                                   fltVolumeSolidos);

    FreeAndNil(cdsDados);
  End;

  edtTotPer.Text   := FormatFloat('#,##0.000',  fltTotPercen);
  If (objFormula <> Nil) Then
  Begin
    If edtPesRea.Text <> '' Then
    Begin
      edtTotCus.Text   := FormatFloat('#,##0.0000', objFormula.fRetornaCustoProducaoTotalKilo(1));
      edtTotCusLT.Text := FormatFloat('#,##0.0000', fConverteLitroParaKilo(fStrToFloat(edtPesRea.Text), objFormula.fRetornaCustoProducaoTotalKilo(1)));
    End;
  End
  Else
  Begin
    edtTotCus.Text   := FormatFloat('#,##0.0000', 0);
    edtTotCusLT.Text := FormatFloat('#,##0.0000', 0);
  End;
  edtTotPes.Text   := FormatFloat('#,##0.0000', fltTotDensid);
end;

procedure TfrmCadEstruturasIndustrial.pImagemEpi;
Begin
  imgEpi.Visible := blnUsaEpi And (cdsGeiEpi.IsEmpty);
  lblMsgEpi.Visible := imgEpi.Visible;
End;

procedure TfrmCadEstruturasIndustrial.pCarregaFormula(strCodPag, strCodCor,
  strCodFor: String);
begin
  edtProdutos.Text   := strCodPag;
  edtCor.Text        := strCodCor;
  edtCodFormula.Text := strCodFor;

  FFecharAoConfirmar:= True;
  Self.ShowModal;
end;

procedure TfrmCadEstruturasIndustrial.pCarregaFormulaSubItensRel;
Const
  SQL_FORMULA_SUB_ITENS_REL = ' SELECT                     '+
                              '       D.DMT_ITESUB,        '+
                              '       I.ITE_DESITE,        '+
                              '       I.ITE_REFERE,        '+
                              '       F.FAS_DESFAS,        '+
                              '       DMT_QTDITE           '+
                              ' FROM GEIMAT G              '+
                              ' INNER JOIN DEIMAT D        '+
                              '    ON (G.AUTOINCREM = D.DMT_SEQGER) '+
                              ' INNER JOIN CADITE I        '+
                              '    ON (I.ITE_CODITE = D.DMT_ITESUB) '+
                              ' LEFT JOIN CADFAS F         '+
                              '    ON (DMT_CODFAS = F.FAS_CODFAS)   '+
                              ' WHERE GMT_CODITE = :CODITE AND      '+
                              '       GMT_CODEMP = :CODEMP AND      '+
                              '       GMT_STATUS = "A"              ';

Var
  qryBusca: TUniQuery;
Begin

  qryBusca:= fCriaQuery;

  Try
    qryBusca.Close;
    qryBusca.SQL.Clear;
    qryBusca.SQL.Add(SQL_FORMULA_SUB_ITENS_REL);
    frxFormIte.DataSet := qryBusca;
  Finally
    //FreeAndNil(qryBusca);
  End;

End;

function TfrmCadEstruturasIndustrial.fAbreFormulaSubItensRel(strCodIte: String): Boolean;
begin
  Try
    Result := True;
    frxFormIte.DataSet.Close;
    TUniQuery(frxFormIte.DataSet).ParamByName('CODITE').AsString := strCodIte;
    TUniQuery(frxFormIte.DataSet).ParamByName('CODEMP').AsString := VS_strCodEmp;
    frxFormIte.DataSet.Open;
  Except
    Result := False;
  End;
end;


end.
