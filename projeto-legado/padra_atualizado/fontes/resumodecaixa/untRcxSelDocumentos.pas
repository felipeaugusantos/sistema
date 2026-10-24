unit untRcxSelDocumentos;

interface

uses
  Windows, Types, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, ComCtrls, StdCtrls, Buttons, ExtCtrls, EditFocus,
  Grids, DBGridCitel, DBGrids, StrUtils, DB, Menus, MemoFocus, Uni, AppEvnts,
  UniDataSetProvider, UniClientDataSet, RLTypes, BitBtnLockedIncrem, DateUtils,
  WinSpool, frxClass, frxExportCSVTestabilidade, dxScreenTip, cxClasses, Math,
  dxCustomHint, cxHint, untTBaixaReceber, untGravando, cxProgressBar, untLiberacao,
  untTLock, untFechamentoFinanceiro, untRcxTResumoDeCaixa, untValidacaoCredito,
  System.Generics.Collections, System.Generics.Defaults,MaskUtils,untFuncoesGenerica,
  untTLogLibRec, untTypesSistema, untFuncoesConsulta, untTConfiguracaoGrids,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGrid, untConfiguracaoGrids, untLogCancelamento,
  untMsgLiberacao; //MF: 285995 - 31/05/2023

type
  TDescontoGeral = Record
    strCODCLI: String;
    strNUMDUP: String;
    strPARDUP: String;
    strESPDOC: String;
    strCODEMP: String;
    strNOMCLI: String;
    fltVALDUP: Double;
    fltVALCAL: Double;
    fltVALDES: Double;
    fltVALREC: Double;
    dtaDTAVEN: TDateTime;
    dtaDTACAD: TDateTime;
    strMOTDES: String;
  End;

type
  TfrmRcxSelDocumentos = class(TfrmPaiSimples)
    btnConfirma: TBitBtnLocked;
    pnlGeral: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtEspDoc: TEditFocus;
    pnlInformativos: TPanel;
    pnlValores: TPanel;
    edtVendedor: TEditFocus;
    Label2: TLabel;
    edtPortador: TEditFocus;
    Label3: TLabel;
    Label4: TLabel;
    edtTotSel: TEditFocus;
    edtTotGer: TEditFocus;
    Label5: TLabel;
    Label6: TLabel;
    edtNumDoc: TEditFocus;
    Label7: TLabel;
    edtQtdSel: TEditFocus;
    Label8: TLabel;
    edtParcel: TEditFocus;
    memHistDup: TMemoFocus;
    btnRecalculaJuros: TBitBtnLocked;
    btnPesquisa: TBitBtnLocked;
    btnImpressao: TBitBtnLocked;
    btnDupAgrupadas: TBitBtnLocked;
    btnProdutos: TBitBtnLocked;
    btnSelecTodos: TBitBtnLocked;
    btnAplicaFiltro: TBitBtnLocked;
    lblNumCoo: TLabel;
    edtNumCoo: TEditFocus;
    PopupCalcJuros: TPopupMenu;
    mnuCalcJurosGlobal: TMenuItem;
    mnuCalcJurosIndividual: TMenuItem;
    mnuCalcJurosFuturo: TMenuItem;
    btnInfCobr: TBitBtnLocked;
    Label13: TLabel;
    edtMedPond: TEditFocus;
    btnMedPond: TBitBtnLocked;
    HintControler: TcxHintStyleController;
    btnResumoFinanceiro: TBitBtnLocked;
    lblEvento: TLabel;
    edtEvento: TEditFocus;
    btnDescontoGeral: TBitBtnLocked;
    lblNumDocOrigem: TLabel;
    edtNumDocOrigem: TEditFocus;
    lblEspDocOrigem: TLabel;
    edtEspDocOrigem: TEditFocus;
    btnConfigurarGrid: TBitBtnLocked;
    dbgDocumentos: TcxGrid;
    dbgDocumentosDBTableView1: TcxGridDBTableView;
    dbgDocumentosCTR_DUPPAR: TcxGridDBColumn;
    dbgDocumentosCTR_ESPDOC: TcxGridDBColumn;
    dbgDocumentosFGO_DOCORI: TcxGridDBColumn;
    dbgDocumentosFGO_ESPORI: TcxGridDBColumn;
    dbgDocumentosCTR_CODEMP: TcxGridDBColumn;
    dbgDocumentosCTR_DTACAD: TcxGridDBColumn;
    dbgDocumentosCTR_DTAVEN: TcxGridDBColumn;
    dbgDocumentosCTR_VALCOR: TcxGridDBColumn;
    dbgDocumentosCTR_ENVBCO: TcxGridDBColumn;
    dbgDocumentosCTR_NOSNUM: TcxGridDBColumn;
    dbgDocumentosCTR_IMPBOL: TcxGridDBColumn;
    dbgDocumentosDIASATRASO: TcxGridDBColumn;
    dbgDocumentosLevel1: TcxGridLevel;
    dbgDocumentosCTR_NOMCLI: TcxGridDBColumn;
    dbgDocumentosCTR_DUPORI: TcxGridDBColumn;
    dbgDocumentosCTR_MARDES: TcxGridDBColumn;
    Label9: TLabel;
    edtTotDpl: TEditFocus;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnRecalculaJurosClick(Sender: TObject);
    procedure btnAplicaFiltroClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnImpressaoClick(Sender: TObject);
    procedure btnDupAgrupadasClick(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure btnSelecTodosClick(Sender: TObject);
    procedure mnuCalcJurosGlobalClick(Sender: TObject);
    procedure mnuCalcJurosIndividualClick(Sender: TObject);
    procedure mnuCalcJurosFuturoClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure btnInfCobrClick(Sender: TObject);
    procedure edtMedPondMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure edtMedPondMouseLeave(Sender: TObject);
    procedure btnMedPondMouseEnter(Sender: TObject);
    procedure btnMedPondMouseLeave(Sender: TObject);
    procedure btnMedPondClick(Sender: TObject);
    procedure btnResumoFinanceiroClick(Sender: TObject);
    procedure btnDescontoGeralClick(Sender: TObject);
    procedure btnConfigurarGridClick(Sender: TObject);
    procedure dbgDocumentosDBTableView1CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure dbgDocumentosDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { Private declarations }

    strAceCtr: String;
    strCliSel: String;
    strEmpCod: String;

    intQtdSel: Integer;
    fltTotSel: Double;
    fltCreSel: Double;
    fltTotGer: Double;

    dtsDadosTemp: TDataSource;

    intLockConfirmar: Integer;
    stlDupPro: TStringList;

    blnLiberouUtiCredProf : Boolean;
    stlAutIncDupMar: TStringList;

    blnDiaUtil : Boolean;

    objBaixaReceber: TBaixaReceber;

    stlSelecionadas: TStringList;
    objLiberacao : TLiberacao;
    objLock: TLock;
    objFechamento: TFechamentoFinanceiro;

    dicBaixa: TDictionary <String,Variant>;

    objLogCancelamento : TLogCancelamento;
    objLogLibRec : TLogLibRec;

    FConfiguracaoGrid: TConfiguracaoGrids;

    cdsCloneDup : TUniClientDataSet;

    fltPercMultaAplicado : Double;
    fltPercJurosAplicado : Double;
    FBloquearSelecaoDuplicataCartaoDiferente: Boolean;

    function fTemPermissaoBaixarDuplicataComPortadorTravadoCad: Boolean;
    function fLiberouAutenticacaoPendenteExpedicao: Boolean;
    function fTemDupVencida: Boolean;
    procedure pMontaMensagemLib(strDuplicata: String; fltValOri: Double; strCodCli, sMsgTitulo: String;
                                          objTabela: TRegistroMsgLiberaTabela; cdsTmp: TUniClientDataSet);
    function fVerificaDescontoFaturaVencida: Boolean;
    procedure pCarregaValoresOriginais(cds: TDataset; strAutoInc: String);
    procedure pClonaDuplicatasOriginais;

    Type TPonderada = Record
      intDiasAtr: Double;
      fltTotVlr : Double;
      fltTotPon : Double;
    End;
    procedure pCalculaTotalGeral;
    procedure pCalculaTotais;

    procedure AplicaDescontoGeral;

    procedure pAtualizaDados(DataSet: TDataSet);

    procedure pMarcarDuplicata(blnMarcar: Boolean; blnMarcarTodos: Boolean = False; blnRecAut: Boolean = False);
    procedure pSelecionaDuplicata(blnMensagem: Boolean);

    procedure pCalculaJuros(fltPerJur: Double; fltPerMul : Double = 9999);

    procedure pCalculaJurosIndiv(fltPerJur: Double; fltPerMul : Double = 9999);

    procedure pRecalculaJuros;

    procedure pRecalculaJurosIndiv;

    function fDigRecebimento: Boolean;

    function fValorCalculado(fltValSuj, fltJuros, fltPerDPo : Double): Double;

    {*******************************************}
    {* FUNÇÕES ESPECÍFICAS DO RESUMO DE CAIXA: *}
    {* CÁLCULOS, ABATIMENTOS, ETC              *}
    {****************************************MV*}
    procedure pTotalizaValores;

    function fCalculaValorRecebido: Double;
    function fCalculaTotalCreditos: Double;
    function fVerificaConfirmacaoDuplicatas: Boolean;
    function fTemParCre: Boolean;
    function fVerificaQuitacao: Boolean;
    function fCupomImpresso(blnMensagem: Boolean; var blnExiste: Boolean): Boolean;

    function fField(strName: String): TField;
    function fGetChaveAcessoDocumento: String;
    function fGetNumeroCooDocumento: String;
    function fLiberarDocumentoSemAutorizacaoSefaz: Boolean;
    function fVerificaDocumentoAutorizadoSefaz: Boolean;
    function fExisteCancelamentoPendentePorChaveAcesso(const blnMensagem : Boolean): Boolean;
    function fEhMesmoClienteOuMesmaRedeDeLojas(Var blnTemCreditos: Boolean): Boolean;
    function fApenasBoletoAdiantamento(): Boolean;
    function fTemDuplicataMarcada(): Boolean;
    function fPodeSelecionarCreditoClienteDiferentes: Boolean;
    function fValidaCreditosVencidos: Boolean;
    function fApagarBoletoAdiantamento: Boolean;
    function fMarcaDuplics(pgbProgresso: TcxProgressBar): Boolean;

    procedure pTotalFiltro(strNumDoc, strParCel, strEspDoc: String);
    function fVerificarCadRecBaixado(strNumDoc, strEspDoc, strCliFor, strCodEmp, strParcel, strSeqBai: String; lstDoc: TStringList): Boolean;
    procedure pGeraResumo(lstCtrBaixadas: TStringList);
    function fDocumentosBaixados: Boolean;
    function fApenasCreditos: Boolean;

    procedure pSelecionaContratos;
    function fSqlDuplicatas(strRomaneio: String = ''): String;

    function fEhDevolucaoDeFaturamentoFuturo(strNumDev, strEspDev, strCliDev, strEmpDev: String): Boolean;
    procedure pRemoveDevolucoesDeFF;
    function fConfirmaAutenticacao: Boolean;
    procedure pJurosFuturo;
    procedure pCalculaJurosFuturo(fltPerJur: Double; strDtaPag: String; fltPerMul : Double = 9999);
    function fVerificaDireitoBaixa: Boolean;
    function fVeiodeCH: Boolean;

    procedure pVerificaDestravarLckProf;
    function  fRetChaveLckProf: String;
    function  fValidaLiberacaoCreditoProfissional: Boolean;
    procedure pDesmarcaDuplicatasCreditoProfissional;
    function fRetornaMediaPonderadaNova(strCodCli:String;objDados:TUniClientDataSet; blnCalcDiaUtil:Boolean=False):String;
    function  fLiberaBaixaParcialComJuros(blnBaixaComCreditos: Boolean = False) : Boolean;
    function fValidaBaixaParcialComJurosUsandoCreditos: Boolean;
    function DuplicataDeCreditoLiberada(ANumDup, AParcel, AEspDoc, ACodEmp, ACodCli: string): Boolean;

    function ValidaDuplicatasParaReceberDescontoGeral: Boolean;
    function fCriaListaClientes: TStringList;

    function fUtilizaCredEmpresa: Boolean;
    procedure pRatearExcedenteComoJuros(AValorExcedente, ATotalBaseRateio: Double);
  public
    { Public declarations }
    strCodOpe: String;
    strCodCli: String;
    strNumRom: String;
    strCodEmp: String;
    strEmpOri: String;
    strMotDes: String;
    strCodRed: String;

    dtaDtaIni: TDateTime;
    dtaDtaFin: TDateTime;

    fltTotRec: Double;
    fltValDoc: Double;
    fltValJur: Double;
    fltDesRec: Double;
    fltTotCre: Double;
    fltTotLiq: Double;
    fltDesCob: Double;

    blnEdiCam  : Boolean;
    blnConfirma: Boolean;
    blnQuitacao: Boolean;
    blnVeiodeCH: Boolean;

    blnSelTodas: Boolean;
    blnAutTrDv : Boolean;
    blnDuplicatasVista: Boolean;

    blnDescFinanSomenteAteVenc: Boolean;

    cdsDadosTemp: TUniClientDataSet;

    strNomTabSelDoc: String;

    strFpgSelPD: String;
    strCodCarSelPD: String;
    intQtdPaCSelPD: Integer;

    blnBuscaContratos: Boolean;

    blnNaoPermiteSelecionarDevolucaoDeFF: Boolean;
    blnF11: Boolean;
    ADataCaixa: TDateTime;

    objResumoDeCaixa: TResumoDeCaixa;
    strCodigoCaixa  : String;

    arrClientesSel: TConsultasArray;

    procedure pLiberaDupsMarcadas;
    procedure pCriaTemporaria;
    procedure pAtualizaTemporaria(blnOrdenaVencimento: Boolean);

    function fVerificaDupBaixada(strNumDup,
                                 strParcel,
                                 strEspDoc,
                                 strCodEmp,
                                 strCodCli: String;
                                 intSeqBai: Integer): Boolean;

    function fVerificaDupExiste(strNumDup,
                                strParcel,
                                strEspDoc,
                                strCodEmp,
                                strCodCli: String;
                                intSeqBai: Integer): Boolean;

  private
    procedure pAtualizaTotaisGrade(ASender: TcxDataSummary);
    function fIndiceSomaGrade(const ACampo: String): Integer;

  end;


implementation

uses  untfuncoesSimples, untPai, untRcxDigRecebimento,
      untRcxRecalculaJuros,untConstantes, untRcxDigDesconto,
      untRelRcxReciboCob,untFuncoesAuxiliares, untFuncoesRel2, TypesRel,
      untFuncoesRel, untCancelamentoDocResumo, untFuncFat,
      untDigValor, untCfgRel, untSpoolImpressao, untSelDuplicatasContrato, untCadRec,
      untRcxCalculaJurosFuturo, untRelFatVendasClienteF9, untModuloSPR,
      untRcxTravas, untImpMatricial, untImpAutenticacao, untFuncoes, untCadRcxx,
      untInfCobranca, untResFinanceiro, untBaixaDescGeral,
      untMovGer, untPgtOnlineApi;

{$R *.dfm}

procedure TfrmRcxSelDocumentos.btnSairClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmRcxSelDocumentos.pAtualizaTemporaria(blnOrdenaVencimento: Boolean);
 Var
     blnclonaCds : Boolean;
begin
  blnclonaCds := False;

  cdsDadosTemp.IndexFieldNames := IfThen(blnOrdenaVencimento, 'CTR_DTAVEN;CTR_DUPPAR', 'CTR_DTAVEN;CTR_DUPPAR;CTR_NOMCLI');

  If (Not cdsDadosTemp.Active) Then
  Begin
    pCriaTemporaria;
    blnclonaCds := true;
  End;

  (fField('CTR_VALDUP') As TFloatField).DisplayFormat := '#,##0.00';
  (fField('CTR_VALCOR') As TFloatField).DisplayFormat := '#,##0.00';
  (fField('CTR_VRTRDV') As TFloatField).DisplayFormat := '#,##0.00';
  (fField('CTR_DUPORI') As TFloatField).DisplayFormat := '#,##0.00';

  pCalculaTotalGeral;
  pCalculaTotais;

  If blnclonaCds Then
     pClonaDuplicatasOriginais;
end;

procedure TfrmRcxSelDocumentos.pSelecionaContratos;
  Var
    fltPerJur: Double;
    frmSelDuplicatasContrato: TfrmSelDuplicatasContrato;
begin

  Try
    pCriarFormularios(TfrmSelDuplicatasContrato, frmSelDuplicatasContrato);

    frmSelDuplicatasContrato.fSqlDuplicatas := fSqlDuplicatas;

    If frmSelDuplicatasContrato.ShowModal <> mrOk Then
      frmSelDuplicatasContrato.cdsDuplicatasSelecionadas.EmptyDataSet;

    cdsDadosTemp.Data := frmSelDuplicatasContrato.cdsDuplicatasSelecionadas.Data;

    pSetaClient(cdsDadosTemp);

    cdsDadosTemp.Open;

    cdsDadosTemp.Active := False;
    cdsDadosTemp.Active := True;

    If blnNaoPermiteSelecionarDevolucaoDeFF Then
      pRemoveDevolucoesDeFF;

    fltPerJur := fCfgSis('JURATR', varDouble);

    {*******************************************}
    {* CALCULA JUROS                           *}
    {****************************************MV*}
    pCalculaJuros(fltPerJur);

    btnSelecTodos.Click;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  pFreeAndNil(frmSelDuplicatasContrato);

end;


procedure TfrmRcxSelDocumentos.FormCreate(Sender: TObject);
begin
  inherited;
  edtNumDoc.TamCampo  := fTamDocCadRec;
  edtNumDoc.MaxLength := fTamDocCadRec;

  objBaixaReceber := TBaixaReceber.Create(Self);

  objLiberacao := TLiberacao.Create;
  objLogLibRec := TLogLibRec.Create;

  objLock := TLock.Create;

  blnLiberouUtiCredProf := False;
  blnVeiodeCH       := False;
  blnBuscaContratos := False;

  intLockConfirmar := -1;

  stlDupPro := TStringList.Create;
  stlAutIncDupMar := TStringList.Create;
  stlAutIncDupMar.Sorted := True;

  strCliSel      := '';
  strFpgSelPD    := '';
  strCodCarSelPD := '';
  intQtdPaCSelPD := 0;
  blnConfirma    := False;
  blnQuitacao    := True;
  fltCreSel      := 0;
  strCodigoCaixa := '';

  dicBaixa  := TDictionary <String,Variant>.Create;

  cdsDadosTemp := TUniClientDataSet.Create(Self);
  dtsDadosTemp := fCriaDataSource(cdsDadosTemp);
  dbgDocumentosDBTableView1.DataController.DataSource := dtsDadosTemp;

  {*******************************************}
  {* ADICIONA OS AGGREGATES DO CLIENT        *}
  {* PS. TO REGASSSANDO O RESUMO DE CAIXAAAA *}
  {****************************************AF*}
  cdsDadosTemp.AggregatesActive := True;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VALCOR';
    FieldName     := 'TOT_VALCOR';
    DataSet       := cdsDadosTemp;
    Expression    := 'SUM(CTR_VALCOR)';
    DisplayFormat := '#,##0.00';
    Active        := True;
  End;

  cdsDadosTemp.AggregatesActive := True;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_DUPORI';
    FieldName     := 'TOT_DUPORI';
    DataSet       := cdsDadosTemp;
    Expression    := 'SUM(CTR_DUPORI)';
    DisplayFormat := '#,##0.00';
    Active        := True;
  End;

  dbgDocumentosDBTableView1.DataController.Summary.OnAfterSummary := pAtualizaTotaisGrade;

  {******************************************}
  {* QUANDO UTILIZAR ESSE RECURSO, NÃO      *}
  {* ESQUECER DE "LIMPAR" O EVENTO, OU SEJA *}
  {* ATRIBUIR NIL AO EVENTO. VER (*) NO E-  *}
  {* VENTO "OnClose"                        *}
  {* AO FAZE-LO, FAVOR COLOCAR ESSE COMEN-  *}
  {* TARIO                                  *}
  {***************************************MV*}

  cdsDadosTemp.AfterScroll := pAtualizaDados;

  blnNaoPermiteSelecionarDevolucaoDeFF :=
    (Not fCfgSis('FFSDUP', varBoolean)) And fCfgSis('SINCNF', varBoolean);

  blnF11 := False;
  stlSelecionadas := TStringList.Create;

  FBloquearSelecaoDuplicataCartaoDiferente := (fCfgSis('CARDIF') = 'S');
  objLogCancelamento := TLogCancelamento.Create;
end;

procedure TfrmRcxSelDocumentos.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(stlAutIncDupMar);
  FreeAndNil(stlSelecionadas);
  FreeAndNil(objLock);
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  FreeAndNil(objLogCancelamento);
end;

procedure TfrmRcxSelDocumentos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Shift = ([ssAlt])) And ((Key = Ord('J')) Or (Key = Ord('j'))) Then
  Begin
    btnRecalculaJuros.Click;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    btnSair.Click;
  End
  Else If (Key = VK_F3) Then
  Begin
    If btnImpressao.Enabled And btnImpressao.Visible Then
      btnImpressao.Click;
  End
  Else If (Key = VK_F4) Then
  Begin
    If btnSelecTodos.Visible Then
      btnSelecTodos.Click;
  End
  Else If (Key = VK_F5) Then
  Begin
    If btnPesquisa.Enabled Then
      btnPesquisa.Click;
  End
  Else If (Key = VK_F6) Then
  Begin
    If btnDupAgrupadas.Enabled And btnDupAgrupadas.Visible Then
      btnDupAgrupadas.Click;
  End
  Else If (Key = VK_F7) Then
  Begin
    If (Shift = [ssAlt]) And btnResumoFinanceiro.Visible Then
      btnResumoFinanceiro.Click;

    If (Shift = []) And btnProdutos.Enabled Then
      btnProdutos.Click;
  End
  Else If (Key = VK_F8) Then
  Begin
    If btnRecalculaJuros.Enabled And btnRecalculaJuros.Visible Then
      mnuCalcJurosGlobal.Click;
  End
  Else If (Key = VK_F9) Then
  Begin
    If btnRecalculaJuros.Enabled And btnRecalculaJuros.Visible Then
      mnuCalcJurosIndividual.Click;
  End
  Else If (Key = VK_F10) Then
  Begin
    If btnConfirma.Enabled Then
      btnConfirma.Click;
  End
  Else If (Key = VK_F11) Then
  Begin
    If btnRecalculaJuros.Enabled And btnRecalculaJuros.Visible Then
      mnuCalcJurosFuturo.Click;
  End
  Else If (Key = VK_F12) And (Shift = [ssAlt]) Then
  Begin
    If btnDescontoGeral.Enabled Then
      btnDescontoGeral.Click;
  End
  Else If (Key = VK_F12) Then
  Begin
    If btnInfCobr.Visible Then
      btnInfCobr.Click;
  End;
end;

procedure TfrmRcxSelDocumentos.pCriaTemporaria;
  Var
    strSQL   : String;
    intCont  : Integer;
    fltPerJur: Double;
    qryGen   : TUniQuery;
    prvPro   : TUniDataSetProvider;
begin
  If Not objLogLibRec.pExisteTabela Then
    objLogLibRec.CriaTabelaTemporaria();

  objLogLibRec.pLimpaTmpLogLib();

  If blnBuscaContratos Then
  Begin
    pSelecionaContratos;
    Exit;
  End;

  Try
    pLiberaDupsMarcadas;
    cdsDadosTemp.Filtered := False;

    qryGen := fCriaQuery;
    prvPro := TUniDataSetProvider.Create(Self);
    prvPro.DataSet := qryGen;

    {*********************************************}
    {* INCLUI LEFT JOIN COM A MOVGER PARA QUANDO *}
    {* CLINTE = CONSUMIDOR, ENTÃO BUSCAR CLIENTE *}
    {* NA MOVGER                                 *}
    {***************************************AC,JB*}
    strSQL := fSqlDuplicatas(strNumRom);

    strSQL := strSQL + 'WHERE ';

    strSQL := strSQL + '  CTR_DTAREC IS NULL ';

    If Not fCfgSis('RECADT', VarBoolean) Then
      strSQL := strSQL + '  AND (IFNULL(FGO_BOLADT, 0.00) = 0.00)  ';

    If Not blnF11 Then
    Begin
      If blnAutTrDv Then
        strSQL := strSQL + ' AND IFNULL(CTR_VRTRDV, 0) <> 0 ';

      {********************************************}
      {* Somente duplicatas a vista               *}
      {*****************************************AA*}
      If blnDuplicatasVista Then
         strSQL := strSQL + '  AND CTR_DTAVEN = CTR_DTACAD ';
    End
    Else
    Begin
      strSQL := strSQL + ' AND CTR_ESPDOC = "CC" ';
      strSQL := strSQL + ' AND CTR_DTAENV IS NULL ';
      strSQL := strSQL + ' AND IF(CTR_BCOBOL = "778", TRUE, (CTR_NOSNUM IS NULL OR CTR_NOSNUM = "")) ';
      If fCfgSis('EMPORI', VarBoolean) Then
        strSQL := strSQL + '  AND CTR_CODEMP = ' + QuotedStr(VS_strCodEmp);
    End;

    If (dtaDtaIni <> 0) And (dtaDtaFin <> 0) Then
      strSQL := strSQL + '  AND CTR_DTAVEN BETWEEN :DTAINI AND :DTAFIN  ';

    If (Not fEmptyStr(edtNumDoc.Text)) Then
      strSQL := strSQL + '  AND CTR_NUMDUP = :NUMDOC ';

    If (Not fEmptyStr(edtEspDoc.Text)) Then
      strSQL := strSQL + '  AND CTR_ESPDOC = :ESPDOC ';

    If (Not fEmptyStr(strCodCli)) Then
      strSQL := strSQL + fStrLocate(strCodCli, arrClientesSel, 'CTR_CODCLI', 'CODCLI');

    If (Not fEmptyStr(strCodRed)) Then
      strSQL := strSQL + ' AND CLI_CODRED = :CODRED ';

    If (Not fEmptyStr(strNumRom)) Then
    Begin
      strSQL := strSQL + '  AND MOVGER.GER_NUMROM = :NUMROM ';
      strSQL := strSQL + '  AND ROMGERX.GER_EMPROM = :EMPROM ';
    End;

    If (Not fEmptyStr(strCodEmp)) Then
      strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP '
    Else If fCfgSis('EMPACE', varBoolean) Then
      strSQL := strSQL + ' AND LOCATE(CTR_CODEMP, ' + QuotedStr(fRetEmpAcessoUsuario(strCodOpe)) + ') > 0 ';

    If (Not fEmptyStr(strEmpOri)) Then
      strSQL := strSQL + '  AND IFNULL(CTR_EMP_PD, CTR_CODEMP) = :EMPORI ';

    If (Not fCfgSis('FFSDUP', varBoolean)) Then
      strSQL := strSQL + '  AND CTR_ESPDOC <> "FF" ';

    If Not fVerificaAcessoSistema('PEREXICRED', strCodOpe) Then
      strSQL := strSQL + '  AND CTR_VALDUP > 0 ';

    If Not fEmptyStr(fCfgSis('POOCRE')) Then
      strSQL := strSQL + 'AND IF((CTR_VALDUP < 0),IFNULL(CTR_CODPOR,"") <> '+String(fCfgSis('POOCRE')).QuotedString+',TRUE)';

    strSQL := strSQL + ' GROUP BY CADREC.AUTOINCREM ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If (Not fEmptyStr(edtNumDoc.Text)) Then
      Begin
        ParamByName('NUMDOC').AsString := edtNumDoc.Text;
      End;

      If (Not fEmptyStr(edtEspDoc.Text)) Then
      Begin
        ParamByName('ESPDOC').AsString := edtEspDoc.Text;
      End;

      If (Not fEmptyStr(strCodCli)) Then
      Begin
        pSetaParam(strCodCli, arrClientesSel, strCodCli, 'CODCLI', qryGen);
      End;

      If (Not fEmptyStr(strCodRed)) Then
      Begin
        ParamByName('CODRED').AsString := strCodRed;
      End;

      If (Not fEmptyStr(strNumRom)) Then
      Begin
        ParamByName('NUMROM').AsString := strNumRom;
        ParamByName('EMPROM').AsString := VS_strCodEmp;
      End;

      If (Not fEmptyStr(strCodEmp)) Then
      Begin
        ParamByName('CODEMP').AsString := strCodEmp;
      End;

      If (Not fEmptyStr(strEmpOri)) Then
      Begin
        ParamByName('EMPORI').AsString := strEmpOri;
      End;

      If (dtaDtaIni <> 0) And (dtaDtaFin <> 0) Then
      Begin
        ParamByName('DTAINI').AsDateTime := dtaDtaIni;
        ParamByName('DTAFIN').AsDateTime := dtaDtaFin;
      End;

      Open;

      For intCont := 1 To qryGen.FieldCount Do
      Begin
        qryGen.Fields.FieldByNumber(intCont).Required := False;
        qryGen.Fields.FieldByNumber(intCont).ReadOnly := False;
      End;

      cdsDadosTemp.Close;
      cdsDadosTemp.SetProvider(prvPro);
      cdsDadosTemp.Open;

    End;

    If blnNaoPermiteSelecionarDevolucaoDeFF And (Not blnAutTrDv) Then
      pRemoveDevolucoesDeFF;

    fltPerJur := fCfgSis('JURATR', varDouble);

    {*******************************************}
    {* CALCULA JUROS                           *}
    {****************************************MV*}
    pCalculaJuros(fltPerJur);

    FreeAndNil(qryGen);
    FreeAndNil(prvPro);

  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryGen);
      FreeAndNil(prvPro);
      pMensagensErro(E.Message, '[pCriaTemporaria - RcxSelDocumentos]');
    End;
  End;

end;

procedure TfrmRcxSelDocumentos.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  {*****************************************}
  {* (*) LIMPA EVENTO                      *}
  {**************************************MV*}
  cdsDadosTemp.AfterScroll := Nil;
  pAtualizaTemporaria(True);

  cdsDadosTemp.Filter   := '';
  cdsDadosTemp.Filtered := False;

  FreeAndNil(stlDupPro);
  FreeAndNil(dicBaixa);

  if (assigned(objLogLibRec)) then
     FreeAndNil(objLogLibRec);

  If Assigned(FConfiguracaoGrid) Then
    FreeAndNil(FConfiguracaoGrid);

  If Not blnConfirma Then
  Begin
    objLock.pDestravarTodos;
  End;
end;

procedure TfrmRcxSelDocumentos.FormShow(Sender: TObject);
begin
  inherited;
  strAceCtr:= fCampoTabela('OPE_EMPCTR', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);
  blnSelTodas := False;
  Screen.Cursor := crDefault;
  btnInfCobr.Visible := fVerificaAcessoSistema('INFCOB', strCodOpe);
  btnResumoFinanceiro.Visible := fVerificaAcessoSistema('ACEF7_', strCodOpe);

  FConfiguracaoGrid := TConfiguracaoGrids.Create(dbgDocumentos,
                                                 dbgDocumentosDBTableView1,
                                                 Concat(Self.Name, '.', dbgDocumentosDBTableView1.Name),
                                                 ['CTR_MARDES']);

  If blnAutTrDv Then
  Begin
    dbgDocumentosCTR_DUPORI.DataBinding.FieldName := 'CTR_VRTRDV';
    dbgDocumentosCTR_VALCOR.Visible := False;
    dbgDocumentosCTR_NOSNUM.Visible := False;
    dbgDocumentosCTR_IMPBOL.Visible := False;
  End;

  if fCfgSis('EMPFAT', varBoolean) and fCfgSis('EMPFVN', varBoolean) then
  begin
    pnlCabecalho.Height := 63;
    lblNumDocOrigem.Visible := True;
    edtNumDocOrigem.Visible := True;
    lblEspDocOrigem.Visible := True;
    edtEspDocOrigem.Visible := True;

    dbgDocumentosFGO_DOCORI.Index := 2;
    dbgDocumentosFGO_ESPORI.Index := 3;
    dbgDocumentosFGO_DOCORI.Visible := True;
    dbgDocumentosFGO_ESPORI.Visible := True;
  end;

  If blnF11 Then
  Begin
    btnSelecTodos.Click;
    mnuCalcJurosGlobal.Enabled := False;
    mnuCalcJurosIndividual.Enabled := False;
    btnProdutos.Enabled := False;
    btnSelecTodos.Enabled := False;
    mnuCalcJurosFuturo.Enabled := False;
    btnRecalculaJuros.Enabled := False;
  End;

  // carrega valores da configuração do sistema;
  fltPercMultaAplicado := fCfgSis('MULATR', varDouble); //0;
  fltPercJurosAplicado := fCfgSis('JURATR', varDouble); //0;

  pSetFocus(dbgDocumentos);
end;

function TfrmRcxSelDocumentos.fVerificaDireitoBaixa: Boolean;
Begin
	Result:= True;
	if not (Pos(LeftStr(fField('CTR_CODEMP').AsString,3), strAceCtr) > 0) then
	begin
			Result:= False;
	End;
End;

function TfrmRcxSelDocumentos.fVerificaDocumentoAutorizadoSefaz: Boolean;
begin
  Result := True;
  If fCfgSis('PRSATS', VarBoolean) Then
  Begin
    If (Pos(fField('CTR_ESPDOC').AsString, 'NF_EL_') > 0) And fCfgSis('NFEUSA', VarBoolean) Then
    Begin
      If fEmptyStr(fGetChaveAcessoDocumento) And (Not fLiberarDocumentoSemAutorizacaoSefaz) Then
        Result := False;
    End
    Else If (Pos(fField('CTR_ESPDOC').AsString, 'IF_') > 0) Then
    Begin
      If (fCfgSis('USNFCE', VarBoolean) Or fUsaSat) Then
      Begin
        If fEmptyStr(fGetChaveAcessoDocumento) And (Not fLiberarDocumentoSemAutorizacaoSefaz) Then
          Result := False;
      End
      Else If fEmptyStr(fGetNumeroCooDocumento) And (Not fLiberarDocumentoSemAutorizacaoSefaz) Then
        Result := False;
    End;
  End;
end;

function TfrmRcxSelDocumentos.fExisteCancelamentoPendentePorChaveAcesso(const blnMensagem : Boolean): Boolean;
begin
  Result := False;
  If (Pos(fField('CTR_ESPDOC').AsString, 'NF_EL_NV_IF_IV_') > 0) And objLogCancelamento.fExisteCancelamentoPendentePorChaveAcesso(fGetChaveAcessoDocumento) Then
  Begin
    Result := True;
    If (blnMensagem) Then
      pMensagemOK('Documento Fiscal se encontra em processo de cancelamento (LOGCAN)!');
  End;
end;

function TfrmRcxSelDocumentos.fEhMesmoClienteOuMesmaRedeDeLojas(Var blnTemCreditos: Boolean): Boolean;
  Var
    cdsDupSel: TUniClientDataSet;
    strCliSel: String;
    strRedSel: String;
begin
  cdsDupSel          := TUniClientDataSet.Create(nil);
  cdsDupSel.Data     := cdsDadosTemp.Data;
  cdsDupSel.Filter   := 'CTR_MARDES = ' + QuotedStr('M');
  cdsDupSel.Filtered := True;

  strCliSel := '';
  strRedSel := '';

  blnTemCreditos := False;

  cdsDupSel.First;

  While Not cdsDupSel.Eof Do
  Begin
    If Pos(cdsDupSel.FieldByName('CTR_CODCLI').AsString, strCliSel) <= 0 Then
      strCliSel := strCliSel + cdsDupSel.FieldByName('CTR_CODCLI').AsString;

    If Pos(cdsDupSel.FieldByName('CLI_CODRED').AsString, strRedSel) <= 0 Then
      strRedSel := strRedSel + cdsDupSel.FieldByName('CLI_CODRED').AsString;

    If (cdsDupSel.FieldByName('CTR_VALDUP').AsFloat < 0) Then
      blnTemCreditos := True;

    cdsDupSel.Next;
  End;

  Result := False;
  //Se nao tem documentos selecionados
  If fEmptyStr(strCliSel) Then Result := True
  //Se for a mesma rede de lojas para todos os clientes selecionados
  Else If (Length(strRedSel) = 5) And (strRedSel <> '00000') Then Result := fField('CLI_CODRED').AsString = strRedSel
  //Se for o mesmo cliente selecionado
  Else If (Length(strCliSel) = 8) Then Result := fField('CTR_CODCLI').AsString = strCliSel;

  FreeAndNil(cdsDupSel);
end;

function TfrmRcxSelDocumentos.fValidaCreditosVencidos: Boolean;
  Var
    intDiasValidadeCredito: Integer;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
begin
  Result := True;

  intDiasValidadeCredito := fCfgSis('DIACRE', VarInteger);

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddSeparador(115);
  objLiberacao.objMsgLibera.pAddTexto('***  Utilização de Crédito Expirado  ***', alCentro, teAutcom, '', 115);
  objLiberacao.objMsgLibera.pAddSeparador(115);
  objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade de dias para expirar e solicitar senha para utilização', intDiasValidadeCredito.ToString);

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DUPLICATA' , 13 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'EMP'       , 4  , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'   , 39 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'DT.CAD.'   , 11 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT.VENC.'  , 11 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'VR.CREDITO', 14 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'QTD.DIAS'  , 8  , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  cdsDadosTemp.First;
  While Not cdsDadosTemp.Eof Do
  Begin
    If (fField('CTR_MARDES').AsString = 'M') And
       (fField('CTR_VALDUP').AsFloat < 0)    And
       (DaysBetween(fField('CTR_DTAVEN').AsDateTime, VS_Date) > intDiasValidadeCredito) Then
    Begin

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('DUPLICATA' , fField('CTR_NUMDUP').AsString + fField('CTR_PARCEL').AsString       , 13 , alEsquerda);
      objLinha.pAddColuna('EMP'       , fField('CTR_CODEMP').AsString                                       , 4  , alCentro  );
      objLinha.pAddColuna('CLIENTE'   , fField('CTR_CODCLI').AsString + '-' + fField('CTR_NOMCLI').AsString , 39 , alEsquerda);
      objLinha.pAddColuna('DT.CAD.'   , FormatDateTime('dd/MM/yyyy', fField('CTR_DTACAD').AsDateTime)       , 11 , alCentro  );
      objLinha.pAddColuna('DT.VENC.'  , FormatDateTime('dd/MM/yyyy', fField('CTR_DTAVEN').AsDateTime)       , 11 , alCentro  );
      objLinha.pAddColuna('VR.CREDITO', FormatFloat('#,##0.00', fField('CTR_VALDUP').AsFloat)               , 14 , alDireita );
      objLinha.pAddColuna('QTD.DIAS'  , DaysBetween(fField('CTR_DTAVEN').AsDateTime, VS_Date).ToString      , 8  , alDireita );
      objTabela.lstLinhas.Add(objLinha);

      Result := False;
    End;
    cdsDadosTemp.Next;
  End;
  cdsDadosTemp.First;


  If Result Then
    FreeAndNil(objTabela)
  else
  begin
    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strDirAce := 'LIBRECCREDEXP';
    objLiberacao.strMsgSen := 'Utilização de Crédito Expirado';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;

    Result := objLiberacao.fLibera;
  end;
end;

function TfrmRcxSelDocumentos.fPodeSelecionarCreditoClienteDiferentes: Boolean;
  Var
    blnTemCreditosSel: Boolean;
begin
  Result := True;

  If Not fCfgSis('SBCCMC', VarBoolean) Then
    Exit;

  If (fField('CTR_VALDUP').AsFloat < 0) Then
  Begin
    If Not fEhMesmoClienteOuMesmaRedeDeLojas(blnTemCreditosSel) Then
    Begin
      Result := False;
      pMensagemOk('Duplicata de crédito somente é permitido selecionar '+
        'com duplicatas do mesmo cliente ou mesma rede de lojas!');
    End;
  End
  Else
  Begin
    If Not fEhMesmoClienteOuMesmaRedeDeLojas(blnTemCreditosSel) And blnTemCreditosSel Then
    Begin
      Result := False;
      pMensagemOk('Já foram selecionadas duplicatas de crédito e somente é permitido selecionar '+
        'com duplicatas do mesmo cliente ou mesma rede de lojas!');
    End;
  End;
end;

function TfrmRcxSelDocumentos.DuplicataDeCreditoLiberada(ANumDup, AParcel,
  AEspDoc, ACodEmp, ACodCli: string): Boolean;
var
  FDuplicatas: TArrayDuplicatasCredito;
  FDuplicata: TDuplicatasCredito;
begin
  Result := True;

  if pos(AEspDoc, 'NF_DV') = 0 then
    Exit;

  FDuplicata.NumDup := ANumDup;
  FDuplicata.Parcel := AParcel;
  FDuplicata.EspDoc := AEspDoc;
  FDuplicata.CodEmp := ACodEmp;
  FDuplicata.CodCli := ACodCli;

  SetLength(FDuplicatas, Length(FDuplicatas)+1);

  FDuplicatas[High(FDuplicatas)] := FDuplicata;

  Result := fDuplicataCreditoLiberada(FDuplicatas);

  SetLength(FDuplicatas, 0);

end;

procedure TfrmRcxSelDocumentos.edtMedPondMouseLeave(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmRcxSelDocumentos.edtMedPondMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  pnlInfo.Caption := 'MÉD. POND = SOMATÓRIO(Vlr.Original * (Dt.Atual-Dt.Cadastro)) / SOMATÓRIO(Vlr.Original)';
end;

procedure TfrmRcxSelDocumentos.mnuCalcJurosGlobalClick(Sender: TObject);
var
  blnEncMarcado: Boolean;
begin
  inherited;
  blnEncMarcado := False;

  If blnF11 Then
    Exit;

  if cdsDadosTemp.Locate('CTR_MARDES', 'M', []) THEN
    blnEncMarcado := True;

  If blnEncMarcado Then
  Begin
    fMensagem('', 'Para efetuar o recálculo do juros, nenhuma duplicata pode estar selecionada!', ['&Ok']);
    Exit;
  End;

  TfrmGravando.fExecutarModal(pRecalculaJuros,'Aguarde... Recalculando Juros.','');
end;

procedure TfrmRcxSelDocumentos.pAtualizaDados(DataSet: TDataSet);
begin

  {*******************************************}
  {* HABILITA / DESABILITA BOTÃO QUE CHAMA   *}
  {* TELA DE DUPLICATAS AGRUPADAS            *}
  {****************************************RL*}
  If DataSet.FieldByName('CTR_ESPDOC').AsString = 'AG' Then
  Begin
    btnDupAgrupadas.Enabled := True;
    btnProdutos.Enabled     := False;
  End
  Else
  Begin
    btnDupAgrupadas.Enabled := False;

    If Not blnF11 Then
      btnProdutos.Enabled   := True;
  End;

  With DataSet Do
  Begin
    edtVendedor.Text := FieldByName('CTR_NOMVEN').AsString;
    edtPortador.Text := FieldByName('CTR_NOMPOR').AsString;

    memHistDup.Lines.Clear;
    memHistDup.Lines.Add(
    AnsiReplaceStr(FieldByName('CTR_HIST01').AsString, '<<csq>>',' ') + ' ' +
    AnsiReplaceStr(FieldByName('CTR_HIST02').AsString, '<<csq>>',' '));
    SendMessage(memHistDup.Handle, WM_VSCROLL, SB_TOP, 0);//PRIMEIRA LINHA DO MEMO
  End;

end;

procedure TfrmRcxSelDocumentos.dbgDocumentosDBTableView1CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);

  function fGetValue(strField: String): Variant;
  begin
    Result := Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDocumentosDBTableView1.GetColumnByFieldName(strField).Index];
  end;

  Var
    strMarDes: String;

begin
  inherited;
  If Not cdsDadosTemp.IsEmpty Then
  Begin
    With cdsDadosTemp Do
    Begin
      {*****************************************}
      {* CASO A TABELA ESTEJA FECHADA, SAI     *}
      {**************************************MV*}
      If Not Active Then
        Exit;

      strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, dbgDocumentosCTR_MARDES.Index]);
      If (cdsDadosTemp.IsEmpty) Or fEmptyStr(strMarDes) Then
         Exit;

      If (strMarDes = 'M') Then
      Begin
         ACanvas.Font.Color := clBlue;
      End
      Else

      If (AViewInfo.Item.Caption = 'Data Venc.') and
         (dbgDocumentosCTR_DTAVEN.DataBinding.FieldName = 'CTR_DTAVEN') Then
      Begin

        If (VarToDateTime(fGetValue('CTR_DTAVEN')) < VS_Date) Then
        Begin
           ACanvas.Font.Color  := clRed;
           ACanvas.Font.Style  := [fsBold];
           ACanvas.FillRect(AViewInfo.Bounds);
        End;

      End;

    End;

  end;
end;

procedure TfrmRcxSelDocumentos.dbgDocumentosDBTableView1KeyDown(
  Sender: TObject; var Key: Word; Shift: TShiftState);
  Var
    LprcScroll: TprcScroll;
begin
  inherited;
  If (Key = VK_RETURN) Then
  Begin
    pDisableControls(cdsDadosTemp, LprcScroll);
    Try
      If InterlockedIncrement(intLockConfirmar) = 0 Then
      Begin
        If Not blnF11 Then
        Begin
          pnlGeral.Enabled := False;
          pSelecionaDuplicata(True);
          pnlGeral.Enabled := True;
          pSetFocus(dbgDocumentos);
        End
        Else
          fMensagem('ATENÇÃO', 'É necessário que baixe todas as duplicatas de créditos!', ['&OK']);

        InterlockedDecrement(intLockConfirmar);
      End
      Else
        InterlockedDecrement(intLockConfirmar);
    Finally
      pEnableControls(cdsDadosTemp, LprcScroll);
    End;
  End;
end;

procedure TfrmRcxSelDocumentos.pCalculaTotais;
  Var
    cdsAux: TUniClientDataSet;
    fltTot: Double;
begin
  Try
    cdsAux := TUniClientDataSet.Create(Self);

    cdsAux.Data := cdsDadosTemp.Data;
    cdsAux.Filter := 'CTR_MARDES = ' + QuotedStr('M');
    cdsAux.Filtered := True;

    edtQtdSel.Text := IntToStr(cdsAux.RecordCount);

    fltTot := 0;
    fltCreSel := 0;

    With cdsAux Do
    Begin
      First;

      While Not Eof Do
      Begin
        fltTot := fFormataFloat(fltTot, 2) + fFormataFloat(FieldByName('CTR_VALREC').AsFloat, 2);

        If Not fEmptyStr(FieldByName('CTR_DOCDIV').AsString) Then
          fltCreSel := fltCreSel + FieldByName('CTR_VALDUP').AsFloat;

        Next;
      End;

    End;

    edtTotSel.Text := FloatToStrF(fltTot,ffFixed,12,2);

    intQtdSel := StrToInt(edtQtdSel.Text);
    fltTotSel := fFormataFloat(fStrToFloat(edtTotSel.Text), 2);
    fltTotGer := fFormataFloat(fStrToFloat(edtTotGer.Text), 2);

    btnImpressao.Enabled := (intQtdSel > 0);

    If intQtdSel = 0 Then
    Begin
      strFpgSelPD    := '';
      strCodCarSelPD := '';
      intQtdPaCSelPD := 0;
    End;

    edtMedPond.Text := fRetornaMediaPonderadaNova(cdsAux.FieldByName('CTR_CODCLI').AsString, cdsAux);

  Except
    On E:Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(cdsAux);

end;

procedure TfrmRcxSelDocumentos.pCalculaTotalGeral;
  Var
    LIndiceDuplicata,
    LIndiceCorrigido: Integer;
begin

  With dbgDocumentosDBTableView1.DataController Do
  Begin
    If (FilteredRecordCount < RecordCount) Then
    Begin
      LIndiceDuplicata := fIndiceSomaGrade('CTR_DUPORI');
      LIndiceCorrigido := fIndiceSomaGrade('CTR_VALCOR');

      If (LIndiceDuplicata >= 0) And (LIndiceCorrigido >= 0) Then
      Begin
        If VarIsNull(Summary.FooterSummaryValues[LIndiceDuplicata]) Then
          edtTotDpl.Text := '0,00'
        Else
          edtTotDpl.Text := FormatFloat('#,##0.00', Summary.FooterSummaryValues[LIndiceDuplicata]);

        If VarIsNull(Summary.FooterSummaryValues[LIndiceCorrigido]) Then
          edtTotGer.Text := '0,00'
        Else
          edtTotGer.Text := FormatFloat('#,##0.00', Summary.FooterSummaryValues[LIndiceCorrigido]);

        Exit;
      End;
    End;
  End;

  // tot. Duplic.
  If TAggregateField(fField('TOT_DUPORI')).Value = Null Then
    edtTotDpl.Text := '0,00'
  Else
    edtTotDpl.Text := FormatFloat('#,##0.00', TAggregateField(fField('TOT_DUPORI')).Value);

  If TAggregateField(fField('TOT_VALCOR')).Value = Null Then
    edtTotGer.Text := '0,00'
  Else
    edtTotGer.Text := FormatFloat('#,##0.00', TAggregateField(fField('TOT_VALCOR')).Value);

end;

procedure TfrmRcxSelDocumentos.pAtualizaTotaisGrade(ASender: TcxDataSummary);
begin
  If (csDestroying In ComponentState) Or (Not cdsDadosTemp.Active) Then
    Exit;

  pCalculaTotalGeral;
end;

function TfrmRcxSelDocumentos.fIndiceSomaGrade(const ACampo: String): Integer;
  Var
    LItem: Integer;
begin
  Result := -1;

  With dbgDocumentosDBTableView1.DataController.Summary Do
  Begin
    For LItem := 0 To FooterSummaryItems.Count - 1 Do
    Begin
      If (FooterSummaryItems[LItem].Kind = skSum) And
         (FooterSummaryItems[LItem] Is TcxGridDBTableSummaryItem) And
         SameText(TcxGridDBTableSummaryItem(FooterSummaryItems[LItem]).FieldName, ACampo) Then
      Begin
        Result := LItem;
        Exit;
      End;
    End;
  End;
end;

function TfrmRcxSelDocumentos.fConfirmaAutenticacao: Boolean;
  Var
    cdsAux: TUniClientDataSet;
    ImpAutenticacao: TImpAutenticacao;
    strNomeFila, strTipImp: String;
    blnLiberou : Boolean;
Begin
  Result := False;

  Try

    blnLiberou := fLiberouAutenticacaoPendenteExpedicao;

    If (blnLiberou) Then
    Begin
      Result := False;
      cdsAux := TUniClientDataSet.Create(Nil);
      cdsAux.Data := cdsDadosTemp.Data;

      cdsAux.Filter   := 'CTR_MARDES = ' + QuotedStr('M');
      cdsAux.Filtered := True;

      cdsAux.First;
      While Not cdsAux.Eof Do
      Begin
        Result := fAutenticaTRDV(cdsAux.FieldByName('CTR_NUMDUP').AsString,
                                 cdsAux.FieldByName('CTR_PARCEL').AsString,
                                 cdsAux.FieldByName('CTR_ESPDOC').AsString,
                                 cdsAux.FieldByName('CTR_CODEMP').AsString,
                                 cdsAux.FieldByName('CTR_CODCLI').AsString,
                                 cdsAux.FieldByName('CTR_SEQBAI').AsInteger,
                                 cdsAux.FieldByName('CTR_VRTRDV').AsFloat);

        If Not Result Then
          Break;

        cdsAux.Next;
      End;

      If Result Then
      Begin
        pCarregaConfImpr(qryCfgRel, 'frmRcxSelDocumentos_AUTENTICACAO');

        fPreImpressao(qryCfgRel, strNomeFila,strTipImp,False);

        ImpAutenticacao := TImpAutenticacao.Create(strNomeFila);
        ImpAutenticacao.pImprimeAutenticacao(
                             cdsAux.FieldByName('CTR_NUMDUP').AsString,
                             cdsAux.FieldByName('CTR_PARCEL').AsString,
                             cdsAux.FieldByName('CTR_ESPDOC').AsString,
                             cdsAux.FieldByName('CTR_CODCLI').AsString,
                             cdsAux.FieldByName('CTR_CODEMP').AsString,
                             FloatToStrF(cdsAux.FieldByName('CTR_VRTRDV').AsFloat, ffFixed, 12, 2),
                             strCodOpe);

        pMensagemOk('Autenticação realizada com sucesso!');

        objLock.pDestravarTodos;
      End;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;
  FreeAndNil(cdsAux);

End;

function TfrmRcxSelDocumentos.fCriaListaClientes: TStringList;
  Var
    cdsGen: TUniClientDataSet;
    strCodCli: String;
begin
  Result := TStringList.Create;
  cdsGen := TUniClientDataSet.Create(Self);

  With cdsGen Do
  Begin

    Data := cdsDadosTemp.Data;
    Filtered := False;
    Filter := 'CTR_MARDES = ''M''';
    Filtered := True;
    First;

    strCodCli := '';
    While Not Eof Do
    Begin

      If Not SameText(strCodCli, FieldByName('CTR_CODCLI').AsString) then
      Begin
        strCodCli := FieldByName('CTR_CODCLI').AsString;
        Result.Add(strCodCli);
      End;
      Next;

    End;
  End;

  FreeAndNil(cdsGen);
end;


procedure TfrmRcxSelDocumentos.btnConfigurarGridClick(Sender: TObject);
  Var
    LConfiguracaoGrids: TfrmConfiguracaoGrids;
begin
  inherited;

  pCriarFormularios(TfrmConfiguracaoGrids, LConfiguracaoGrids);

  Try
    LConfiguracaoGrids.ConfiguracaoGridsObj := FConfiguracaoGrid;
    LConfiguracaoGrids.ChaveGrid := Concat(Self.Name, '.', dbgDocumentosDBTableView1.Name);
    LConfiguracaoGrids.DatasetCampos := dbgDocumentosDBTableView1.DataController.Dataset;
    LConfiguracaoGrids.WidthAutomaticoCampos := False;
    LConfiguracaoGrids.ShowModal;

    if (LConfiguracaoGrids.Confirmar) Then
      FConfiguracaoGrid.CarregarDadosSalvos(dbgDocumentosDBTableView1);
  finally
    FreeAndNil(LConfiguracaoGrids);
  end;
end;

procedure TfrmRcxSelDocumentos.btnConfirmaClick(Sender: TObject);
  Var
    cdsClone : TUniClientDataSet;
    prcScroll: TprcScroll;
    frmRcxDigDesconto : TfrmRcxDigDesconto;

  procedure pClonaDuplicatasMarcadas;
  Begin
    cdsClone := TUniClientDataSet.Create(Self);

    pCloneDataSet(cdsClone, cdsDadosTemp);

    With cdsClone Do
    Begin
      Filtered := False;
      Filter := 'CTR_MARDES = ''M''';
      Filtered := True;
    End;
  End;

  function fDuplicatasJaUtilizadasPorOutrosUsuarios: Boolean;
  Begin
    Result := True;

    With cdsClone Do
    Begin
      First;

      While Not Eof Do
      Begin
        If stlAutIncDupMar.IndexOf(FieldByName('CTR_NOMARQ').AsString +
                                   FieldByName('CTR_NUMDUP').AsString +
                                   FieldByName('CTR_ESPDOC').AsString +
                                   FieldByName('CTR_CODEMP').AsString +
                                   FieldByName('CTR_CODCLI').AsString +
                                   FieldByName('CTR_PARCEL').AsString) <> -1 Then
        Begin
          Result := False;
          Break;
        End;

        Next;
      End;
    End;
  End;

  function fVerificaDuplicatasExcluidas: Boolean;
    Var
      strSQL: String;
      qryTmp: TUniQuery;
  Begin
    Result := True;

    With cdsClone Do
    Begin
      First;
      qryTmp := fCriaQuery;

      While Not Eof Do
      Begin
        strSQL := '';
        strSQL := strSQL + ' SELECT ';
        strSQL := strSQL + '   COUNT(*) AS QTD ';
        strSQL := strSQL + ' FROM ';
        strSQL := strSQL + FieldByName('CTR_NOMARQ').AsString;
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   CTR_NUMDUP = :NRODUP AND ';
        strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
        strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
        strSQL := strSQL + '   CTR_PARCEL = :PARDUP     ';

        qryTmp.Params.Clear;
        qryTmp.SQL.Clear;
        qryTmp.SQL.Add(strSQL);
        qryTmp.ParamByName('NRODUP').AsString := FieldByName('CTR_NUMDUP').AsString;
        qryTmp.ParamByName('ESPDOC').AsString := FieldByName('CTR_ESPDOC').AsString;
        qryTmp.ParamByName('CODEMP').AsString := FieldByName('CTR_CODEMP').AsString;
        qryTmp.ParamByName('CODCLI').AsString := FieldByName('CTR_CODCLI').AsString;
        qryTmp.ParamByName('PARDUP').AsString := FieldByName('CTR_PARCEL').AsString;

        qryTmp.Open;

        If Not qryTmp.IsEmpty Then
        Begin
          If qryTmp.FieldByName('QTD').AsInteger = 0 Then
          begin
            Result := False;
            Break;
          end;
        End
        Else
        begin
          Result := False;
          Break;
        end;

        Next;
      End;

      FreeAndNil(qryTmp);
    End;
  End;
begin
  inherited;

  If intQtdSel <= 0 Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos uma duplicata!', ['&Ok']);
    Exit;
  End;

  If not cdsDadosTemp.IsEmpty Then
  Begin
    pDisableControls(cdsDadosTemp, prcScroll);
    If (InterlockedIncrement(intLockConfirmar) = 0) Then
    Begin
      Try
        btnConfirma.Enabled := False;
        pClonaDuplicatasMarcadas;

        If Not fDuplicatasJaUtilizadasPorOutrosUsuarios Then
        Begin
          fMensagem('ATENÇÃO!', 'Existem duplicatas que estão sendo baixadas e as mesma foram utilizadas por outro usuário. Realize a pesquisa novamente para efetuar as baixas corretamente!', ['&OK']);
          FreeAndNil(cdsClone);
          pEnableControls(cdsDadosTemp, prcScroll);
          Exit;
        End;

        {********************************************************************}
        {* REALIZADO ESSE TRATAMENTO DEVIDO AO DESAGRUPAMENTO DE DUPLICATAS *}
        {********************************************************************}
        If Not fVerificaDuplicatasExcluidas Then
        Begin
          fMensagem('ATENÇÃO!', 'Existem duplicatas que foram excluídas por outro usuário. Realize a pesquisa novamente para efetuar as baixas corretamente!', ['&OK']);
          FreeAndNil(cdsClone);
          pEnableControls(cdsDadosTemp, prcScroll);
          Exit;
        End;

        {***********************************}
        {* REALIZA A VERIFICAÇÃO DO CADCBI *}
        {********************************AF*}
        objBaixaReceber.pCarregaListSelecionadas(cdsDadosTemp.Data);
        If Not objBaixaReceber.fAnalizaCadCbi Then
        Begin
          pEnableControls(cdsDadosTemp, prcScroll);
          Exit;
        End;

        If blnAutTrDv Then
          blnConfirma := fConfirmaAutenticacao
        Else
        Begin
          edtNumDoc.Clear;
          edtEspDoc.Clear;
          edtParcel.Clear;
          cdsDadosTemp.Filter := '';
          cdsDadosTemp.Filtered := False;

          blnEdiCam   := True;
          blnQuitacao := True;

          If (intQtdSel <= 0) And (Not fVerificaConfirmacaoDuplicatas) Then
            Exit;

          If (Not blnLiberouUtiCredProf) And (Not fValidaLiberacaoCreditoProfissional) Then
          Begin
            pDesmarcaDuplicatasCreditoProfissional;
            pEnableControls(cdsDadosTemp, prcScroll);
            Exit;
          End;

          blnVeiodeCH := fVeiodeCH;

          {*****************************************}
          {* VERIFICA SE É PERMITIDO SELECIONAR    *}
          {* APENAS CRÉDITOS                       *}
          {**************************************AF*}
          If Not fCfgSis('APECRE',varBoolean) Then
          Begin
            If fApenasCreditos Then
            Begin
              fMensagem('','Não é permitido selecionar apenas créditos!',['&OK']);
              pEnableControls(cdsDadosTemp, prcScroll);
              Exit;
            End;
          End;

          If fUtilizaCredEmpresa Then
          Begin
            fMensagem('ATENÇÃO!', 'O(s) crédito(s) selecionado(s) pertence(m) a(s) empresa(s) '+ strEmpCod + #13 +
                                  'e o mesmo só poderá ser utilizado na empresa de origem.', ['&OK']);
            pEnableControls(cdsDadosTemp, prcScroll);
            Exit;
          End;

          {*****************************************}
          {* VERIFICA SE TEM SALDO SUFICIENTE NO   *}
          {* CAIXA                                 *}
          {**************************************RS*}
          If fApenasCreditos And (fltTotSel < 0.0) And
             (fFormataFloat(fltTotSel * -100, 2) > fFormataFloat(objResumoDeCaixa.fRetornaSaldoCaixaCampo('RCX_DINREC', strCodigoCaixa) * 100, 2)) Then
          Begin
            fMensagem('', 'Saldo em caixa insuficiente para esta baixa!', ['&Ok']);
            pEnableControls(cdsDadosTemp, prcScroll);
            Exit;
          End;

          If Not fSenhaCreditos(cdsDadosTemp, 'CTR_VALCOR') Then
          Begin
            pEnableControls(cdsDadosTemp, prcScroll);
            Exit;
          End;

          If Not fValidaCreditosVencidos Then
          Begin
            pEnableControls(cdsDadosTemp, prcScroll);
            Exit;
          End;

          If Not fApagarBoletoAdiantamento Then
          Begin
            pEnableControls(cdsDadosTemp, prcScroll);
            Exit;
          End;

          If (Not blnAutTrDv) And
             (VS_strTipExp = '2') And
             (fCfgSis('CXAEXP') = '2') Then
          Begin
            If Not fTemPermissaoFaturarSemExpedicao(cdsDadosTemp) Then
            Begin
              fMensagem('ATENÇÃO!', 'Não é permitido baixar este documento, pois o mesmo ainda não foi expedido.', ['&Ok']);
              pEnableControls(cdsDadosTemp, prcScroll);
              Exit;
            End;
          End;

          fltValDoc := fltTotSel;

          If (fltTotSel > 0.0) Then
          Begin
            If fDocumentosBaixados Then
            Begin
              pEnableControls(cdsDadosTemp, prcScroll);
              Exit;
            End;

            Try
              pCriarFormularios(TfrmRcxDigDesconto, frmRcxDigDesconto);
              frmRcxDigDesconto.strCodOpe      := strCodOpe;
              frmRcxDigDesconto.cdsDados       := cdsDadosTemp;
              frmRcxDigDesconto.intQtdSel      := intQtdSel;
              frmRcxDigDesconto.edtTotGer.Text := FloatToStrF(fltTotSel, ffFixed, 12, 2);
              frmRcxDigDesconto.edtTotDes.Text := frmRcxDigDesconto.edtTotGer.Text;
              frmRcxDigDesconto.edtTotLiq.Text := frmRcxDigDesconto.edtTotGer.Text;

              frmRcxDigDesconto.blnTemParCre   := fTemParCre;
              frmRcxDigDesconto.blnBolAdt      := fApenasBoletoAdiantamento;
              frmRcxDigDesconto.blnTemDupVen   := fTemDupVencida;//MF: 285995 - 30/05/2023
              frmRcxDigDesconto.ShowModal;

              blnConfirma := frmRcxDigDesconto.blnConfirma;

              If (blnConfirma) Then
              Begin
                fltTotLiq := fStrToFloat(frmRcxDigDesconto.edtTotLiq.Text);
                strMotDes := frmRcxDigDesconto.edtMotivo.Text;
              End;

            Except
              On E: Exception Do
              Begin
                blnConfirma := False;
                pMensagensErro(E.Message, '[frmRcxSelDocumentos.btnConfirmaClick]');
              End;
            End;

            //FECHAMENTO FINANCEIRO
            if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, ADataCaixa) then
              blnConfirma := False;

            pFreeAndNil(frmRcxDigDesconto);

            If Not blnConfirma Then
            Begin
              pEnableControls(cdsDadosTemp, prcScroll);
              Exit;
            End;

          End
          Else
          Begin
            If (fMensagem('', 'Confirma?', ['&Sim', '&Não']) = 1) Then
            Begin
              fltTotLiq := fCalculaValorRecebido;
              blnConfirma := True;
            End
            Else
            Begin
              pEnableControls(cdsDadosTemp, prcScroll);
              Exit;
            End;
          End;

          {*******************************************}
          {* CASO TENHA DUPLICATA "CREDITO" E DUPLI- *}
          {* CATAS NORMAIS SELECIONADAS PERGUNTA     *}
          {* "QUITAÇÃO OU NÃO"                       *}
          {****************************************MV*}
          If (fVerificaQuitacao) Then
          Begin

            If (fMensagem('', 'É Quitação?', ['&Sim', '&Não']) = 2) Then
            Begin
              blnQuitacao := False;
              If Not fValidaBaixaParcialComJurosUsandoCreditos Then
              Begin
                If fCfgSis('JURPAR') = 'N' Then
                Begin
                  if not fLiberaBaixaParcialComJuros(True) then
                  Begin
                    pEnableControls(cdsDadosTemp, prcScroll);
                    blnConfirma := False;
                    Exit;
                  End;
                End;
              End;

            End;

          End;

        End;

        If (blnConfirma) Then
        Begin
          fltTotRec := fCalculaValorRecebido;
          pTotalizaValores;
          Close;
        End;

      Finally
        InterlockedDecrement(intLockConfirmar);
        btnConfirma.Enabled := True;
      End;
    End
    Else
      InterlockedDecrement(intLockConfirmar);

    pEnableControls(cdsDadosTemp, prcScroll);
  end;
end;

procedure TfrmRcxSelDocumentos.pSelecionaDuplicata(blnMensagem: Boolean);
  Var
    blnMarcar: Boolean;
    strCliSelAnt: String;
    blnExiste: Boolean;
    strFpgAtuPD: String;
    strCodCarAtuPD: String;
    intQtdPaCAtuPD: Integer;
    blnRecAut : Boolean;
    fltCreUti,
    fltJuros : Double;
    strCodDiv: String;
    blnBolAdt: Boolean;

    function JaTemSelecionado: Boolean;
      Var
        cdsAux: TUniClientDataSet;
    Begin
      cdsAux := TUniClientDataSet.Create(Nil);
      cdsAux.Data := cdsDadosTemp.Data;

      cdsAux.Filter   := 'CTR_MARDES = ' + QuotedStr('M');
      cdsAux.Filtered := True;
      Result := Not cdsAux.IsEmpty;

      FreeAndNil(cdsAux);
    End;

begin
  If cdsDadosTemp.IsEmpty Then
    Exit;

  strCliSelAnt := strCliSel;
  blnExiste    := False;
  blnRecAut    := False;

  blnMarcar := (fField('CTR_MARDES').AsString <> 'M');

  If (fField('CTR_ESPDOC').AsString = 'IF') And
     (Not fCupomImpresso(blnMensagem, blnExiste))             Then
  Begin
    If blnMensagem And blnExiste Then
      fMensagem('ATENÇÃO!', 'Esse cupom não foi impresso!', ['&Ok']);
    Exit;
  End;

  If blnMarcar And Not fVerificaDocumentoAutorizadoSefaz Then
    Exit;

  If blnMarcar And fExisteCancelamentoPendentePorChaveAcesso(blnMensagem) Then
    Exit;

  If blnMarcar And Not fPodeSelecionarCreditoClienteDiferentes Then
    Exit;

  blnBolAdt := fApenasBoletoAdiantamento;
  If blnMarcar And (((Not blnBolAdt) And (fField('FGO_BOLADT').AsFloat > 0)) Or
                   ((blnBolAdt) And (fField('FGO_BOLADT').AsFloat = 0))) And fTemDuplicataMarcada  Then
  Begin
   fMensagem('ATENÇÃO!','Duplicata de espécie PD cujos boletos foram emitidos somente é permitido selecionar '+
                        'com duplicatas de espécie PD cujos boletos foram emitidos!', ['&Ok']);
    Exit;
  End;

  If blnMarcar And (Not fCfgSis('BAIEMP', varBoolean)) Then
  Begin
    If fField('CTR_CODEMP').AsString <> VS_strCodEmp Then
    Begin
      fMensagem('ATENÇÃO','Não é permitido o recebimento de duplicatas em empresas diferentes do cadastro!', ['&Ok']);
      Exit;
    End;
  End;


  If blnMarcar Then
  Begin
    If Not fField('CTR_TX_PIX').AsString.IsEmpty  Then
    Begin
      If blnMensagem Then
        fMensagem('ATENÇÃO!','Não é possível selecionar a duplicata pois possui um Pix gerado e ativo!', ['&Ok']);

      Exit;
    End;
  End;

  {***********************************************************}
  {* VERIFICA SE DEIXA BAIXAR DUPLICATAS ENVIADAS POR BOLETO *}
  {********************************************************LU*}
  If (Not fCfgSis('BAIBOL', varBoolean)) And (Not fEmptyStr(fField('CTR_DTAENV').AsString))  Then
  Begin
    If fTravarBaixaDuplicataComBoletoEnviado(fField('CTR_NUMDUP').AsString,
                                             fField('CTR_ESPDOC').AsString,
                                             fField('CTR_CODEMP').AsString,
                                             fField('CTR_CODCLI').AsString,
                                             fField('CTR_PARCEL').AsString,
                                             strCodOpe,
                                             blnRecAut) Then
      Exit;
  End;

  if TValidacoesPagamentoOnline.fAgrupamentoPossuiLinkPagamento(
    fField('CTR_NUMDUP').AsString,
    fField('CTR_ESPDOC').AsString,
    fField('CTR_CODEMP').AsString,
    fField('CTR_CODCLI').AsString) then
  begin
    fMensagem('ATENÇÃO!', 'Não será possível baixar esta duplicata pois existe link de pagamento! ', ['&O K']);
    Exit;
  end;

  {****************************************************************}
  {* VERIFICA SE O PORTADOR TEM PERMISSÃO PARA BAIXAR A DUPLICATA *}
  {*************************************************************RN*}
  if (blnMarcar) and (not fTemPermissaoBaixarDuplicataComPortadorTravadoCad())then
    Exit;

  If blnAutTrDv And JaTemSelecionado And blnMarcar Then
    Exit;

  If (blnMarcar) Then
  Begin
    if fField('CTR_VALDUP').AsFloat < 0 then
    begin
      if not Self.DuplicataDeCreditoLiberada(
                fField('CTR_NUMDUP').AsString,
                fField('CTR_PARCEL').AsString,
                fField('CTR_ESPDOC').AsString,
                fField('CTR_CODEMP').AsString,
                fField('CTR_CODCLI').AsString) then
      begin
        Exit;
      end;
    end;

    {*******************************************}
    {* VERIFICA SE É PORTADOR CARTORIO         *}
    {****************************************MV*}
    If (Not fEmptyStr(fCfgSis('PORCAR'))) Then
    Begin
      If (fCfgSis('PORCAR') = fField('CTR_CODPOR').AsString) Then
      Begin
        If blnMensagem Then
          fMensagem('', 'Essa duplicata está em cartório!', ['&Ok']);
        Exit;
      End;
    End;

    If not fCfgSis('SELVCL',varBoolean) Then
    Begin

      If (Not fEmptyStr(strCliSel)) Then
      Begin

        If (strCliSel <> fField('CTR_CODCLI').AsString) Then
        Begin
          If blnMensagem Then
            fMensagem('', 'Só é permitido selecionar duplicatas do mesmo cliente!', ['&Ok']);
          Exit;
        End;

      End
      Else
      Begin
        strCliSel := fField('CTR_CODCLI').AsString
      End;

    End;

    If fCfgSis('RECPLC', VarBoolean) Then
    Begin
      If (fField('CTR_ESPDOC').AsString  = 'PD') And
         (fField('CTR_PEDLBC').AsInteger = 0   ) Then
      Begin
        If blnMensagem Then
          fMensagem('', 'Somente será permitido o recebimento deste pedido após a ' +
                        'liberação do mesmo pelo Departamento Comercial!', ['&Ok']);
        Exit;
      End;
    End;

    strFpgAtuPD := fField('CTR_FPG_PD').AsString;

    If (strFpgAtuPD = '') And (fField('CTR_ESPDOC').AsString = 'NV') Then
    Begin
      //Nao deve realizar a validacao da CFG_SFPGPD pois sao duplicatas de conversao que não possuem pedido ou nota fiscal Req: 131514
    End
    Else If (fCfgSis('SFPGPD',varBoolean)) Then
    Begin
      If ((strToIntDef(edtQtdSel.Text, 0) = 0) And (not blnSelTodas)) Or
        ((stlSelecionadas.Count = 0) And blnSelTodas) Then
        strFpgSelPD := '';

      If (Not fEmptyStr(strFpgSelPD)) Then
      Begin
        If (Not (Pos(fField('CTR_ESPDOC').AsString, 'PD_NF_NV_NS_FF_IV_IF_MI_') > 0)) And (fField('CTR_VALCOR').AsFloat > 0) Then
        Begin
          If blnMensagem Then
            fMensagem('', 'Já foram selecionadas duplicatas oriundas de venda ' +
                          'e o sistema esta configurado para permitir receber esta duplicata de acordo com a ' +
                          'forma de pagamento negociada (CFG_SFPGPD). Portanto não será permitido selecionar duplicatas de outras ' +
                          'espécies de documentos juntamente com espécie ' + fField('CTR_ESPDOC').AsString + '!', ['&Ok']);
          Exit;
        End;

        If (strFpgSelPD <> strFpgAtuPD) And (fField('CTR_VALCOR').AsFloat > 0) Then
        Begin
          If blnMensagem Then
            fMensagem('', 'Somente é permitido selecionar duplicatas de venda da mesma ' +
                          'forma de pagamento negociada!' + #13#10 +
                          'Já selecionada: ' + strFpgSelPD + '-' + fRetDesForPag(strFpgSelPD) + #13#10 +
                          'Documento atual: ' + strFpgAtuPD + '-' + fRetDesForPag(strFpgAtuPD), ['&Ok']);
          Exit;
        End;

      End
      Else
      Begin
        If (Pos(fField('CTR_ESPDOC').AsString, 'PD_NF_NV_NS_FF_IV_IF_MI_') > 0) Then
        Begin
          If ((strToIntDef(edtQtdSel.Text, 0) > 0) And (not blnSelTodas)) Or
            ((stlSelecionadas.Count > 0) And blnSelTodas) Then
          Begin
            If blnMensagem Then
              fMensagem('', 'Já foram selecionadas duplicatas diferentes de venda ' +
                            'e o sistema esta configurado para permitir receber duplicatas oriundas de PD de acordo com a ' +
                            'forma de pagamento negociada (CFG_SFPGPD). Portanto não será permitido selecionar duplicatas de venda ' +
                            'juntamente com outras espécies de documentos!', ['&Ok']);
            Exit;
          End;

          strFpgSelPD := strFpgAtuPD;
          If blnMensagem Then
            fMensagem('', 'Somente será permitido receber esta duplicata utilizando a forma de pagamento ' +
                          '"' + strFpgSelPD + '-' + fRetDesForPag(strFpgSelPD) + '"', ['&Ok']);
        End;
      End;

    End;

    If FBloquearSelecaoDuplicataCartaoDiferente And (fCfgSis('SOLCAR',varBoolean)) Then
    Begin
      strCodCarAtuPD := fField('CTR_CODCAR').AsString;
      intQtdPaCAtuPD := fField('CTR_QTDPAC').AsInteger;

      If ((strToIntDef(edtQtdSel.Text, 0) = 0) And (not blnSelTodas)) Or
        ((stlSelecionadas.Count = 0) And blnSelTodas) Then
      Begin
        strCodCarSelPD := '';
        intQtdPaCSelPD := 0;
      End;

      If (Not fEmptyStr(strCodCarSelPD)) Or
        (((strToIntDef(edtQtdSel.Text, 0) > 0) And (not blnSelTodas)) Or
         ((stlSelecionadas.Count > 0) And blnSelTodas)) Then
      Begin
        If (strCodCarSelPD <> strCodCarAtuPD) Or
           (intQtdPaCSelPD <> intQtdPaCAtuPD) Then
        Begin
          If blnMensagem Then
            fMensagem('', 'Somente é permitido selecionar duplicatas com o mesmo cartão e ' +
                          'a mesma quantidade de Parcelas negociada!' + #13#10 +
                          'Já selecionado : ' + IIF(fEmptyStr(strCodCarSelPD), 'SEM CARTÃO', intToStr(intQtdPaCSelPD) + 'x ' + fRetNomeCartao(strCodCarSelPD)) + #13#10 +
                          'Documento atual: ' + IIF(fEmptyStr(strCodCarAtuPD), 'SEM CARTÃO', intToStr(intQtdPaCAtuPD) + 'x ' + fRetNomeCartao(strCodCarAtuPD)), ['&Ok']);
          Exit;
        End;
      End;

      strCodCarSelPD := strCodCarAtuPD;
      intQtdPaCSelPD := intQtdPaCAtuPD;
    End;

    If fUtilizaTravaMaxUtilCredProfissional(fltCreSel + fField('CTR_VALDUP').AsFloat) And (Not fEmptyStr(fField('CTR_DOCDIV').AsString)) Then
    Begin
      pDestravaDupCreditoProf;

      If (Not fTravaDupCreditoProf) Then
      Begin
        Exit;
      End;

      stlDupPro.Add(fRetChaveLckProf);

      If Not fVerificaCredProfissionaisMes(fltCreSel + fField('CTR_VALDUP').AsFloat, fltCreUti) Then
      Begin
        strCodDiv := fRetClienteProfissional(fField('CTR_CODCLI').AsString);

        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('O valor do crédito ultrapassa o máximo de utilização de crédito dentro do mês corrente.');
        objLiberacao.objMsgLibera.pAddTextoCaption('Profissional', strCodDiv + '-' + fRetNomeProfissional(strCodDiv), 13);
        objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'     , VS_strCodEmp + '-' + fRetNomeEmpresa             , 13);

        blnLiberouUtiCredProf := False;

        objLiberacao.strDirAce := 'MAXUCM';
        objLiberacao.strSenLib := fCfgSis('SENUCM');
        objLiberacao.strMsgSen := 'Máximo de utilização de crédito para profissionais';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;

        If Not objLiberacao.fLibera Then
        Begin
          pVerificaDestravarLckProf;
          Exit;
        End
        Else
          blnLiberouUtiCredProf := True;
      End;
    End;

    {*******************************************}
    {* DIGITAÇÃO DOS VALORES                   *}
    {****************************************MV*}
    If blnMensagem And (Not blnAutTrDv) Then
    Begin
      If (Not fDigRecebimento) Then
      Begin
        strCliSel := strCliSelAnt;
        pVerificaDestravarLckProf;
        Exit;
      End;
    End;

    fltJuros := cdsDadosTemp.FieldByName('CTR_VALCOR').AsFloat - cdsDadosTemp.FieldByName('CTR_VALDUP').AsFloat;

    If ((fltJuros > 0) And (cdsDadosTemp.FieldByName('CTR_BAIPAR').AsString = 'S')) Then
    Begin
      if fCfgSis('JURPAR') = 'N' Then
      begin
        if not fLiberaBaixaParcialComJuros then
          blnMarcar :=False;
      end;
    end;

  End
  Else
  Begin
    strCliSel := '';
  End;

  {***************************************************************}
  {* VERIFICA SE A DUPLICATA NÃO FOI BAIXADA AINDA               *}
  {* CASO OCORRA DE DOIS CAIXAS ESTAREM RECEBENDO AO MESMO TEMPO *}
  {************************************************************LU*}
  If (Not blnAutTrDv) And fVerificaDupBaixada(fField('CTR_NUMDUP').AsString,
                                              fField('CTR_PARCEL').AsString,
                                              fField('CTR_ESPDOC').AsString,
                                              fField('CTR_CODEMP').AsString,
                                              fField('CTR_CODCLI').AsString,
                                              fField('CTR_SEQBAI').AsInteger) Then
  Begin
    If Not blnSelTodas Then
    Begin
      fMensagem('', 'Essa duplicata já está baixada!', ['&Ok']);
      pVerificaDestravarLckProf;
      Exit;
    End
    Else
      if not blnMensagem then
        pMarcarDuplicata(False, True)
      else
        pMarcarDuplicata(False);
  End
  Else
    if not blnMensagem then
      pMarcarDuplicata(blnMarcar, True, blnRecAut)
    else
      pMarcarDuplicata(blnMarcar, False, blnRecAut);

end;

procedure TfrmRcxSelDocumentos.pMarcarDuplicata(blnMarcar: Boolean; blnMarcarTodos: Boolean = False; blnRecAut: Boolean = False);
  Var
    strNumDup: String;
    strChaLck: String;
    intIndSel: Integer;
begin

  if (not fVerificaDireitoBaixa) then
	begin
  		if not blnMarcarTodos then
  			pMensagemOk('Usuário não tem permissão para fazer baixa nesta empresa.');

  		Exit;
	end;

  {*****************************************}
  {* ESTOU IGNORANDO A PARCELA PARA FORMAR *}
  {* A CHAVE DA TRAVA POIS NA CONFIRMAÇÃO  *}
  {* DE DOCUMENTOS, NÃO TEM PARCELA, SO-   *}
  {* MENTE O NUMERO DO DOCUMENTO.          *}
  {**************************************MV*}
  strChaLck := 'CADREC' +
               fField('CTR_NUMDUP').AsString +
               fField('CTR_ESPDOC').AsString +
               fField('CTR_CODEMP').AsString +
               fField('CTR_CODCLI').AsString;

  {****************************************************************}
  {* ARMAZENO ESSA VARIÁVEL PARA USA-LA NO LOCATE CASO NECESSARIO *}
  {*************************************************************AC*}
  strNumDup := fField('CTR_DUPPAR').AsString;

  cdsDadosTemp.Edit;

  {***************************************************************************************************}
  {* NO CASO DO USUÁRIO SOMENTE CARREGAR O GRID E NESSE MOMENTO A DUPLICATA SOFREU ALGUMA ALTERAÇÃO, *}
  {* QUANDO FOR MARCAR O SISTEMA VERIFICA SE A MESMA FOI ALTERADA. ***********************************}
  {**REQ 124170************************************************************************************MO*}
  If Not (fRetUltimaAlteracaoCadRec(fField('CTR_NUMDUP').AsString,
                                    fField('CTR_PARCEL').AsString,
                                    fField('CTR_ESPDOC').AsString,
                                    fField('CTR_CODCLI').AsString,
                                    fField('CTR_CODEMP').AsString) < fField('HRAFIL').AsDateTime) Then
  Begin
    fMensagem('ATENÇÃO', 'Não é possível selecionar a duplicata, pois essa sofreu uma alteração. Recarregue os títulos novamente.', ['&OK'], 0);
    objLock.fLock_Unlock(strChaLck, False);
    Exit;
  End;

  {***************************************************************}
  {* NO CASO DA ULTIMA ALTERAÇÃO FOR REFERENTE A UMA BAIXA TOTAL *}
  {**REQ 175566************************************************MT*}
  If (Trim(fGetUltimaAlteracaoCadRec(fField('CTR_NUMDUP').AsString,
                                     fField('CTR_PARCEL').AsString,
                                     fField('CTR_ESPDOC').AsString,
                                     fField('CTR_CODCLI').AsString,
                                     fField('CTR_CODEMP').AsString,
                                     fField('CTR_SEQBAI').AsInteger)) = 'BAIXA TOTAL') Then
  Begin
    fMensagem('ATENÇÃO', 'Não é possível selecionar a duplicata, pois sua ultima alteração é referente a uma baixa total. Verifique!', ['&OK'], 0);
    objLock.fLock_Unlock(strChaLck, False);
    Exit;
  End;

  If (blnMarcar) Then
  Begin

    If Not fVerificaDupExiste(fField('CTR_NUMDUP').AsString,
                              fField('CTR_PARCEL').AsString,
                              fField('CTR_ESPDOC').AsString,
                              fField('CTR_CODEMP').AsString,
                              fField('CTR_CODCLI').AsString,
                              fField('CTR_SEQBAI').AsInteger) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esta duplicata não está mais disponível para baixa.' + #13#10 +
                            'Verifique se a mesma foi baixada ou confirmada por outra estação.', ['&Ok']);
      Exit;
    End;

    If Not fEmptyStr(fGetHostLock(strChaLck)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck), ['&Ok']);
      Exit;
    End;

    {*****************************************}
    {* TRAVA PARA O RESUMO DE CAIXA.         *}
    {**************************************MV*}
    strChaLck := strChaLck + fField('CTR_PARCEL').AsString;
    If Not objLock.fLock_Unlock(strChaLck, True, False) Then
    Begin
      stlAutIncDupMar.Add(strChaLck);
      fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChaLck), ['&Ok']);
      Exit;
    End;

    fField('CTR_MARDES').AsString := 'M';
    fField('CTR_RECAUT').AsString := IIF(blnRecAut, 'S', 'N');

    If stlSelecionadas.IndexOf(fField('CTR_DUPPAR').AsString) < 0 Then
      stlSelecionadas.Add(fField('CTR_DUPPAR').AsString);
  End
  Else
  Begin

    strChaLck := strChaLck + fField('CTR_PARCEL').AsString;
    objLock.fLock_Unlock(strChaLck, False);
    pVerificaDestravarLckProf;

    // carrega valores alterados, feito isso pq os valores podem ter
    // sido alterados devido a alteração da desp. Cob.; verificar se vai influenciar no pagto. parcial;
    If Not blnSelTodas Then
       pCarregaValoresOriginais(cdsDadosTemp, fField('AUTOINCREM').AsString);

    fField('CTR_MARDES').AsString := 'D';
    fField('CTR_VALREC').AsFloat  := 0.0;
    fField('CTR_VALRES').AsFloat  := 0.0;
    fField('CTR_VALJUR').AsFloat  := 0.0;
    fField('CTR_VALDES').AsFloat  := 0.0;
    fField('CTR_RECAUT').AsString := 'N';
    fField('CTR_BAIPAR').AsString := '';

    fField('VALORBAIXADUPLICATA').AsFloat   := 0.00;
    fField('VALORNOVADUPLICATA').AsFloat    := 0.00;
    fField('JUROSNOVADUPLICATA').AsFloat    := 0.00;
    fField('DESCONTONOVADUPLICATA').AsFloat := 0.00;
    fField('DESPESASNOVADUPLICATA').AsFloat := 0.00;
    fField('DESPESASBAIXADUPLICATA').AsFloat := 0.00;
    fField('FATORBAIXADUPLICATA').AsFloat   := 0.000000;
    fField('FATORJUROSDUPLICATA').AsFloat   := 0.000000;

    intIndSel := stlSelecionadas.IndexOf(fField('CTR_DUPPAR').AsString);
    If intIndSel >= 0 Then
      stlSelecionadas.Delete(intIndSel);
  End;
  cdsDadosTemp.Post;

  ObjLogLibRec.pRemoveTmpLogLib(fField('CTR_NUMDUP').AsString, fField('CTR_ESPDOC').AsString, fField('CTR_CODEMP').AsString );

  If Not blnSelTodas Then
    pCalculaTotais;

  {**********************************************}
  {* VERIFICO SE FOI FILTRADA.SE FOI EU LIMPO   *}
  {* OS CAMPOS DE PESQUISA E PESQUISO NOVAMENTE *}
  {*******************************************AC*}
  If (((Not fEmptyStr(edtNumDoc.Text)) Or (Not fEmptyStr(edtParcel.Text)) Or (Not fEmptyStr(edtEspDoc.Text))) And (blnMarcar) And (Not blnMarcarTodos)) Then
  Begin
    edtNumDoc.Clear;
    edtParcel.Clear;
    edtEspDoc.Clear;
    btnAplicaFiltro.Click;
    cdsDadosTemp.Locate('CTR_DUPPAR', strNumDup, []);
  End;

  strNumDup := '';

end;

function TfrmRcxSelDocumentos.fDigRecebimento: Boolean;
  Var
    fltValRec: Double;
    fltValDes: Double;
    qryAux   : TUniQuery;
    strSQLAux: String;
    frmRcxDigRecebimento : TfrmRcxDigRecebimento;
begin

  With cdsDadosTemp Do
  Begin
    fltValRec := FieldByName('CTR_VALCOR').AsFloat;

    If fCfgSis('DESPON', varBoolean) And Not(FieldByName('FGO_BOLADT').AsFloat > 0.00)Then
    Begin
      If ( VS_Date <= ( FieldByName('CTR_DTAVEN').AsDateTime - FieldByName('CTR_QTDDAV').AsInteger ) ) Then
        fltValDes := fFormataFloat(FieldByName('CTR_VALDUP').AsFloat * ( FieldByName('CTR_PERDPO').AsFloat / 100.00 ),2)
      Else fltValDes := 0;
    End
    Else fltValDes := 0;
  End;

  Try
    pCriarFormularios(TfrmRcxDigRecebimento, frmRcxDigRecebimento);
    frmRcxDigRecebimento.blnDescFinanSomenteAteVenc := blnDescFinanSomenteAteVenc;
    frmRcxDigRecebimento.cdsDados         := cdsDadosTemp;
    frmRcxDigRecebimento.edtNumDup.Text   := fField('CTR_NUMDUP').AsString;
    frmRcxDigRecebimento.edtValCor.Text   := FormatFloat('#,##0.00', fField('CTR_VALCOR').AsFloat);
    frmRcxDigRecebimento.edtValRec.Text   := FormatFloat('#,##0.00', fltValRec);
    frmRcxDigRecebimento.edtValDes.Text   := FormatFloat('#,##0.00', fltValDes);
    frmRcxDigRecebimento.fltValCob        := fField('CTR_DESCOB').AsFloat;
    frmRcxDigRecebimento.blnBolAdt        := (fField('FGO_BOLADT').AsFloat > 0.00);

    frmRcxDigRecebimento.fltPercMultAplic := fltPercMultaAplicado;
    frmRcxDigRecebimento.fltPercJuroAplic := fltPercJurosAplicado;

    If (fltValDes > 0) And (fCfgSis('MDERCX', varBoolean)) Then
      frmRcxDigRecebimento.edtMotivo.Text := 'DESCONTO PONTUALIDADE';
      
    frmRcxDigRecebimento.edtRomaneio.Text := fField('RCX_NUMROM').AsString;

    frmRcxDigRecebimento.strCodEmp := fField('CTR_CODEMP').AsString;

    If fField('CTR_ESPDOC').AsString <> 'AG' Then
    Begin
      frmRcxDigRecebimento.strEspDoc := fField('CTR_ESPDOC').AsString;
      frmRcxDigRecebimento.strNumDoc := copy(fField('CTR_DUPPAR').AsString, 01, fTamDocCadRec());
    End
    Else
    Begin
      qryAux := fCriaQuery(Nil);

      strSQLAux := '';
      strSQLAux := strSQLAux + ' SELECT CTR_NUMDUP, CTR_ESPDOC FROM DUPAGR WHERE CTR_NUMAGR = :NUMAGR ';

      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQLAux);
        ParamByName('NUMAGR').AsString := copy(fField('CTR_DUPPAR').AsString, 01, fTamDocCadRec());
        Open;
        First;
      End;

      frmRcxDigRecebimento.strEspDoc := '';
      frmRcxDigRecebimento.strNumDoc := '';

      While Not qryAux.Eof Do
      Begin
        frmRcxDigRecebimento.strEspDoc := frmRcxDigRecebimento.strEspDoc + qryAux.FieldByName('CTR_ESPDOC').AsString + '_';
        frmRcxDigRecebimento.strNumDoc := frmRcxDigRecebimento.strNumDoc + qryAux.FieldByName('CTR_NUMDUP').AsString + '_';

        qryAux.Next;
      End;

    End;     

    frmRcxDigRecebimento.strCodOpe := strCodOpe;

    {***********************************}
    {SE FOI INFORMADO O ROMANEIO NA TELA}
    {DE RESUMO DE CAIXA, ENTÃO, JÁ TRAZ }
    {INFORMADO O ROMANEIO NA TELA DE    }
    {DIGITAÇÃO DO RECEBIMENTO           }
    {********************************RL*}
    If (fCfgSis('RCXROM', varBoolean)) Then
      frmRcxDigRecebimento.edtRomaneio.Text := strNumRom;

    frmRcxDigRecebimento.ShowModal;

    pCalculaTotalGeral();

    Result := frmRcxDigRecebimento.blnConfirma;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmRcxSelDocumentos.fDigRecebimento]');
    End;
  End;

  pFreeAndNil(frmRcxDigRecebimento);

end;

procedure TfrmRcxSelDocumentos.pCalculaJuros(fltPerJur: Double; fltPerMul : Double = 9999);
  Var
    intRecNo    : Integer;
    fltValCor,
    fltValDespon: Double;
    prcScroll   : TprcScroll;
begin
  fltValDespon := 0;

  With cdsDadosTemp Do
  Begin
    pDisableControls(cdsDadosTemp, prcScroll);
    intRecNo := RecNo;

    First;
    While (Not Eof) Do
    Begin
      Application.ProcessMessages;

      If FieldByName('CTR_ESPDOC').AsString <> 'CC' Then
        fltValCor := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                         FieldByName('CTR_VALDUP').AsFloat,
                                         fltPerJur, fltPerMul)
      Else
        fltValCor := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                         FieldByName('CTR_VALDUP').AsFloat,
                                         0, 0);



      {*******************************************}
      {* VALOR CALCULADO                         *}
      {****************************************AF*}
      Edit;

      if (blnDescFinanSomenteAteVenc) then
      begin
        if (FieldByName('CTR_DTAVEN').asDateTime < VS_Date)  then
          FieldByName('CTR_VALCOR').AsFloat := FieldByName('CTR_VALDUP').AsFloat + fltValCor
        else
          FieldByName('CTR_VALCOR').AsFloat := FieldByName('CTR_VALDUP').AsFloat + fltValCor;
      end
      else if (FieldByName('CTR_DTAVEN').asDateTime < VS_Date)  then
        FieldByName('CTR_VALCOR').AsFloat := FieldByName('CTR_VALDUP').AsFloat + fltValCor
      else
        FieldByName('CTR_VALCOR').AsFloat := FieldByName('CTR_VALDUP').AsFloat + fltValCor;

      FieldByName('CTR_CALORI').AsFloat := FieldByName('CTR_VALCOR').AsFloat;

      If (FieldByName('CTR_ESPDOC').AsString <> 'CC') And Not(FieldByName('FGO_BOLADT').AsFloat > 0.00) Then
      Begin
        IF Not (fltValCor > 0) Then
        begin
          if (blnDescFinanSomenteAteVenc) then
          begin
            If (fCfgSis('DESPON', varBoolean)) And
               (VS_Date <= (FieldByName('CTR_DTAVEN').asDateTime + fField('CTR_QTDDAV').AsInteger)) Then
            Begin
              fltValDespon  := fFormataFloat(FieldByName('CTR_VALCOR').AsFloat * ( fField('CTR_PERDPO').AsFloat / 100.00 ),2);
            End;
          end
          else
          begin
            If (fCfgSis('DESPON', varBoolean)) And
               (VS_Date <= (FieldByName('CTR_DTAVEN').asDateTime - fField('CTR_QTDDAV').AsInteger)) Then
            Begin
              fltValDespon  := fFormataFloat(FieldByName('CTR_VALCOR').AsFloat * ( fField('CTR_PERDPO').AsFloat / 100.00 ),2);
            End;
          end;

          if fltValDespon > 0 then
            FieldByName('CTR_VALCOR').AsFloat := FieldByName('CTR_VALCOR').AsFloat - fltValDespon;
        end;
      End;

      // Req. 112643 - guarda valor inicial corrigido antes de juros ser recalculado (quando VALSUG ainda está zerado)
      if FieldByName('CTR_VALSUJ').AsFloat = 0 then
        FieldByName('CTR_VALSUJ').AsFloat := FieldByName('CTR_VALCOR').AsFloat;

      FieldByName('DATA_JUROS').AsDateTime := VS_Date;

      Post;


      Next;
    End;

    RecNo := intRecNo;
    pEnableControls(cdsDadosTemp, prcScroll);
  End;

end;

procedure TfrmRcxSelDocumentos.btnRecalculaJurosClick(Sender: TObject);
var
  ctrBtn: TControl;
  P1: TPoint;
begin
  If not cdsDadosTemp.IsEmpty Then
  Begin
    ctrBtn := TControl(Sender);
    P1   := Point(0, ctrBtn.Height);
    P1   := ctrBtn.ClientToScreen(P1);
    PopupCalcJuros.PopUp(P1.X, P1.Y - (ctrBtn.Height*3));
  end;
end;

procedure TfrmRcxSelDocumentos.btnResumoFinanceiroClick(Sender: TObject);
begin
  inherited;
  If not cdsDadosTemp.IsEmpty Then
  Begin
    pCriarFormularios(TfrmResFinanceiro,frmResFinanceiro);
    Try
      frmResFinanceiro.strCodCli := cdsDadosTemp.FieldByName('CTR_CODCLI').AsString;
      frmResFinanceiro.pSetaAjusteData(fMensagem('Ajuste de Datas',
                                                 'Ajusta vencimentos considerando Sábado/Domingo/Feriados?',
                                                 ['&Sim','&Não'],2) = 1);
      frmResFinanceiro.ShowModal;
    Finally
      pFreeAndNil(frmResFinanceiro);
    End;
  End;
end;

procedure TfrmRcxSelDocumentos.pRatearExcedenteComoJuros(AValorExcedente, ATotalBaseRateio: Double);
var
  LAcumulado: Double;
  LBase: Double;
  LTotalBaseRateio: Double;
  LResidual: Double;
  LJurosRateado: Double;
  LBookmark: TBookmark;
begin
  LBookmark := nil;

  if AValorExcedente <= 0 then
    Exit;

  if ATotalBaseRateio <= 0 then
    Exit;

  LTotalBaseRateio := ATotalBaseRateio;

  try
    try
      LAcumulado := 0;

      cdsDadosTemp.First;
      while not cdsDadosTemp.Eof do
      begin
        if (Trim(cdsDadosTemp.FieldByName('CTR_TX_PIX').AsString).IsEmpty) and
           (cdsDadosTemp.FieldByName('CTR_VALCOR').AsFloat > 0) then
        begin
          cdsDadosTemp.Edit;

          LBase := cdsDadosTemp.FieldByName('CTR_VALCOR').AsFloat;

          LJurosRateado := fFormataFloat( (AValorExcedente * LBase) / LTotalBaseRateio, 2 );

          if LAcumulado + LJurosRateado > AValorExcedente then
            LJurosRateado := fFormataFloat(AValorExcedente - LAcumulado, 2);

          cdsDadosTemp.FieldByName('CTR_VALCOR').AsFloat :=
            fFormataFloat(cdsDadosTemp.FieldByName('CTR_VALCOR').AsFloat + LJurosRateado, 2);

          cdsDadosTemp.FieldByName('CTR_CALORI').AsFloat := cdsDadosTemp.FieldByName('CTR_VALCOR').AsFloat;

          cdsDadosTemp.FieldByName('CTR_VALREC').AsFloat := cdsDadosTemp.FieldByName('CTR_VALCOR').AsFloat;

          cdsDadosTemp.Post;

          LAcumulado := LAcumulado + LJurosRateado;

          if LBookmark <> nil then
            cdsDadosTemp.FreeBookmark(LBookmark);
          LBookmark := cdsDadosTemp.GetBookmark;
        end;
        cdsDadosTemp.Next;
      end;

      LResidual := AValorExcedente - LAcumulado;

      if LBookmark = nil then
        Exit;

      if LResidual > 0 then
      begin
        cdsDadosTemp.GotoBookmark(LBookmark);
        cdsDadosTemp.Edit;

        cdsDadosTemp.FieldByName('CTR_VALCOR').AsFloat :=
          fFormataFloat(cdsDadosTemp.FieldByName('CTR_VALCOR').AsFloat + LResidual, 2);

        cdsDadosTemp.FieldByName('CTR_CALORI').AsFloat := cdsDadosTemp.FieldByName('CTR_VALCOR').AsFloat;

        cdsDadosTemp.FieldByName('CTR_VALREC').AsFloat := cdsDadosTemp.FieldByName('CTR_VALCOR').AsFloat;

        cdsDadosTemp.Post;
      end;
    finally
      if LBookmark <> nil then
        cdsDadosTemp.FreeBookmark(LBookmark);
    end
  except
    On E: Exception Do
    begin
      cdsDadosTemp.Cancel;
      pMensagensErro(E.message, '');
      Raise;
    end;
  end
end;

procedure TfrmRcxSelDocumentos.pRecalculaJuros;
  Var
    blnConfirma: Boolean;
    fltPerJur  : Double;
    fltPerMul  : Double;
    fltJurAnt  : Double;
    sumValDup  : Double;
    sumValSuj  : Double;
    sumValCor  : Double;
    prcScroll  : TprcScroll;
    blnNivel2  : Boolean;
    strSenJM2  : String;

    blnNivel3  : Boolean;
    strSenJM3  : String;

    objTabela  : TRegistroMsgLiberaTabela;
    objLinha   : TLinhaMsgLibera;
    frmRcxRecalculaJuros : TfrmRcxRecalculaJuros;
begin

  fltPerJur := 0.0;
  fltPerMul := 0.0;
  Screen.Cursor := crHourGlass;

  Try
    pCriarFormularios(TfrmRcxRecalculaJuros, frmRcxRecalculaJuros);
    frmRcxRecalculaJuros.strTitJuros:= 'Recalcula Juros Global';
    frmRcxRecalculaJuros.edtPerJur.Hint:= 'Esta rotina irá aplicar juros e multa em todos os '+
      #13#10 + 'títulos carregados na tela de seleção de duplicatas.';
    frmRcxRecalculaJuros.ShowModal;

    blnConfirma :=  frmRcxRecalculaJuros.blnConfirma;
    If blnConfirma Then
    Begin
      fltPerJur := fStrToFloat(frmRcxRecalculaJuros.edtPerJur.Text);
      fltPerMul := fStrToFloat(frmRcxRecalculaJuros.edtPerMul.Text);
    End;
  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmRcxSelDocumentos.pRecalculaJuros]');
    End;
  End;
  pFreeAndNil(frmRcxRecalculaJuros);

  If (blnConfirma) Then
  Begin
    Try

      fltJurAnt := fCfgSis('JURATR', varDouble);

      //Utilizado na tela untrcxdgrecebimento;
      fltPercMultaAplicado := fltPerMul;
      fltPercJurosAplicado := fltPerJur;

      pDisableControls(cdsDadosTemp, prcScroll);
      pCalculaJuros(fltPerJur, fltPerMul);
      pAtualizaTemporaria(False);

      With cdsDadosTemp Do
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddQuebra;
        objLiberacao.objMsgLibera.pAddTexto('RECÁLCULO DE JUROS');
        objLiberacao.objMsgLibera.pAddSeparador(125);
        If fCfgSis('SENJM1') <> '' Then
          objLiberacao.objMsgLibera.pAddTexto('JUROS MENOR QUE O PERMITIDO', alCentro, teAmbos, '',125)
        else
          objLiberacao.objMsgLibera.pAddTexto('ACESSO AO RECÁLCULO DE JUROS', alCentro, teAmbos, '',125);


        objTabela := TRegistroMsgLiberaTabela.Create;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''  , 'DOCUMENTO'       , 17 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'EMP'             , 4  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'CLIENTE'         , 29 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'DT.VENC.'        , 9  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'DT.CAD.'         , 9  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'VR.DUPLICATA'    , 13 , alDireita  , teAutcom);
        objLinha.pAddColuna(''  , 'VR.C/JUR.SUJ'    , 13 , alDireita  , teAutcom);
        objLinha.pAddColuna(''  , 'VL.RECALC.(*)'   , 14 , alDireita  , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        sumValDup := 0;
        sumValSuj := 0;
        sumValCor := 0;

        First;
        While Not Eof Do
        Begin

          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('DOCUMENTO'       ,  fPadR(FieldByName('CTR_NUMDUP').AsString + FieldByName('CTR_PARCEL').AsString, 15) + '-' +
                                                   FieldByName('CTR_ESPDOC').AsString                              , 17 , alEsquerda );
          objLinha.pAddColuna('EMP'             ,  FieldByName('CTR_CODEMP').AsString                              , 4  , alCentro   );
          objLinha.pAddColuna('CLIENTE'         ,  FieldByName('CTR_NOMCLI').AsString                              , 29 , alEsquerda );
          objLinha.pAddColuna('DT.VENC.'        ,  FormatDateTime('dd/mm/yy',FieldByName('CTR_DTAVEN').AsDateTime) , 9  , alCentro   );
          objLinha.pAddColuna('DT.CAD.'         ,  FormatDateTime('dd/mm/yy',FieldByName('CTR_DTACAD').AsDateTime) , 9  , alCentro   );
          objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(FieldByName('CTR_DUPORI').AsFloat, ffNumber, 9, 2)  , 13 , alDireita  );
          objLinha.pAddColuna('VR.C/JUR.SUJ'    ,  FloatToStrF(FieldByName('CTR_VALSUJ').AsFloat, ffNumber, 9, 2)  , 13 , alDireita  );
          objLinha.pAddColuna('VL.RECALC.(*)'   ,  FloatToStrF(FieldByName('CTR_VALCOR').AsFloat, ffNumber, 9, 2)  , 14 , alDireita  );
          objTabela.lstLinhas.Add(objLinha);


          sumValDup := sumValDup + FieldByName('CTR_DUPORI').AsFloat;
          sumValSuj := sumValSuj + FieldByName('CTR_VALSUJ').AsFloat;
          sumValCor := sumValCor + FieldByName('CTR_VALCOR').AsFloat;

          Next;
        End;


        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlTotal;
        objLinha.pAddColuna(''                , 'TOTAIS'                                , 76 , alDireita, teAutcom );
        objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(sumValDup, ffNumber, 9, 2) , 13 , alDireita  );
        objLinha.pAddColuna('VR.C/JUR.SUJ'    ,  FloatToStrF(sumValSuj, ffNumber, 9, 2) , 13 , alDireita  );
        objLinha.pAddColuna('VL.RECALC.(*)  ' ,  FloatToStrF(sumValCor, ffNumber, 9, 2) , 14 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);


        objLiberacao.objMsgLibera.pAddTextoCaption('(*)Taxa de Juros aplicada', FloatToStrF(fltPerJur, ffNumber, 3, 2) + '%', 25 , alDireita, teAmbos, '', 6);
        objLiberacao.objMsgLibera.pAddTextoCaption('(*)Taxa de Multa aplicada', FloatToStrF(fltPerMul, ffNumber, 3, 2) + '%', 25 , alDireita, teAmbos, '', 6);
        objLiberacao.objMsgLibera.pAddSeparador(125);
      End;


      {*****************************************************}
      {*  LIBERAÇÃO ATRAVÉS DE SENHA E GRAVAÇÃO DO LOGVAR  *}
      {**************************************************MA*}
      blnNivel2 := (fltPerJur < fCfgSis('JURMN1', varDouble)) And (fltPerJur >= fCfgSis('JURMN2', varDouble));
      strSenJM2 := fCfgSis('SENJM2');

      blnNivel3 := fltPerJur < fCfgSis('JURMN2', varDouble);
      strSenJM3 := fCfgSis('SENJM3');

      If (fCfgSis('SENJM1') <> '') And (fltPerJur < fCfgSis('JURMN1', varDouble)) Then
      begin
        objLiberacao.strDirAce := 'SENJM1';
        objLiberacao.strSenLib := fCfgSis('SENJM1');
        objLiberacao.strMsgSen := 'Recalcular Juros';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strDirAceNv2 := 'SENJM2';
        objLiberacao.strSenLibNv2 := strSenJM2;
        objLiberacao.blnNivel2 := blnNivel2;
        objLiberacao.strDirAceNv3 := 'SENJM3';
        objLiberacao.strSenLibNv3 := strSenJM3;
        objLiberacao.blnNivel3 := blnNivel3;
        objLiberacao.objMsgLibera.strTitulo := 'O valor de juros é menor que o permitido.';

        blnConfirma := objLiberacao.fLibera;
      end
      Else If (fCfgSis('SENJM1') = '') Or
              ((fCfgSis('JURMN1', varDouble) <= 0) Or
               (fCfgSis('JURMN1', varString) = '')) Then
      begin
        objLiberacao.strDirAce := 'SENJUR';
        objLiberacao.strSenLib := fCfgSis('SENJUR');
        objLiberacao.strMsgSen := 'Recalcular Juros';
        objLiberacao.objMsgLibera.strTitulo := 'Permitir recálculo de juros no recebimento.';

      If (fCfgSis('ENVDUP', varString) <> '') Then
      Begin
        objLiberacao.intQuantidadeLinhas:= StrToInt(fCfgSis('ENVDUP', varString));
        objLiberacao.blnLimitaQuantidadeDuplicata:= True;
      End;

        blnConfirma := objLiberacao.fLibera;
      end;

      If (Not blnConfirma) Then
        pCalculaJuros(fltJurAnt);

      pAtualizaTemporaria(False);

    except
      On E: Exception Do
        pMensagensErro(E.message, '');
    end;
    pEnableControls(cdsDadosTemp, prcScroll);

  End;

  If (blnConfirma) Then
  Begin
    pDisableControls(cdsDadosTemp, prcScroll);
    pCalculaJuros(fltPerJur, fltPerMul);
    pAtualizaTemporaria(False);
    pEnableControls(cdsDadosTemp, prcScroll);
  End;

  Screen.Cursor := crDefault;

end;

procedure TfrmRcxSelDocumentos.pRecalculaJurosIndiv;
  Var
    blnConfirma: Boolean;
    fltPerJur: Double;
    fltPerMul: Double;
    fltJurAnt: Double;
    sumValDup: Double;
    sumValSuj: Double;
    sumValCor: Double;
    blnNivel2  : Boolean;
    strSenJM2  : String;

    blnNivel3  : Boolean;
    strSenJM3  : String;

    objTabela  : TRegistroMsgLiberaTabela;
    objLinha   : TLinhaMsgLibera;
    prcScroll: TPrcScroll;
    frmRcxRecalculaJuros : TfrmRcxRecalculaJuros;
begin

  fltPerJur     := 0.0;
  fltPerMul     := 0.0;
  Screen.Cursor := crHourGlass;

  Try
    pCriarFormularios(TfrmRcxRecalculaJuros, frmRcxRecalculaJuros);
    frmRcxRecalculaJuros.strTitJuros:= 'Recalcula Juros Individual';
    frmRcxRecalculaJuros.edtPerJur.Hint:= 'Esta rotina irá aplicar juros e multa somente neste '
      + #13#10 + 'título selecionado.';
    frmRcxRecalculaJuros.ShowModal;

    blnConfirma :=  frmRcxRecalculaJuros.blnConfirma;
    If blnConfirma Then
    Begin
      fltPerJur := fStrToFloat(frmRcxRecalculaJuros.edtPerJur.Text);
      fltPerMul := fStrToFloat(frmRcxRecalculaJuros.edtPerMul.Text);
    End;
  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmRcxSelDocumentos.pRecalculaJuros]');
    End;
  End;
  pFreeAndNil(frmRcxRecalculaJuros);

  If (blnConfirma) Then
  Begin
    Try

      fltJurAnt := fCfgSis('JURATR', varDouble);

      //Utilizado na tela untrcxdgrecebimento;
      fltPercMultaAplicado := fltPerMul;
      fltPercJurosAplicado := fltPerJur;

      pDisableControls(cdsDadosTemp, prcScroll);
      pCalculaJurosIndiv(fltPerJur, fltPerMul);
      pAtualizaTemporaria(False);

      With cdsDadosTemp Do
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddQuebra;
        objLiberacao.objMsgLibera.pAddTexto('RECÁLCULO DE JUROS');
        objLiberacao.objMsgLibera.pAddSeparador(125);
        If fCfgSis('SENJM1') <> '' Then
          objLiberacao.objMsgLibera.pAddTexto('JUROS MENOR QUE O PERMITIDO', alCentro, teAmbos, '',125)
        else
          objLiberacao.objMsgLibera.pAddTexto('ACESSO AO RECÁLCULO DE JUROS', alCentro, teAmbos, '',125);


        objTabela := TRegistroMsgLiberaTabela.Create;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''  , 'DOCUMENTO'       , 17 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'EMP'             , 4  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'CLIENTE'         , 29 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'DT.VENC.'        , 9  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'DT.CAD.'         , 9  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'VR.DUPLICATA'    , 13 , alDireita  , teAutcom);
        objLinha.pAddColuna(''  , 'VR.C/JUR.SUJ'    , 13 , alDireita  , teAutcom);
        objLinha.pAddColuna(''  , 'VL.RECALC.(*)'   , 14 , alDireita  , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        sumValDup := 0;
        sumValSuj := 0;
        sumValCor := 0;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DOCUMENTO'       ,  fPadR(FieldByName('CTR_NUMDUP').AsString + FieldByName('CTR_PARCEL').AsString, 15) + '-' +
                                                 FieldByName('CTR_ESPDOC').AsString                              , 17 , alEsquerda );
        objLinha.pAddColuna('EMP'             ,  FieldByName('CTR_CODEMP').AsString                              , 4  , alCentro   );
        objLinha.pAddColuna('CLIENTE'         ,  FieldByName('CTR_NOMCLI').AsString                              , 29 , alEsquerda );
        objLinha.pAddColuna('DT.VENC.'        ,  FormatDateTime('dd/mm/yy',FieldByName('CTR_DTAVEN').AsDateTime) , 9  , alCentro   );
        objLinha.pAddColuna('DT.CAD.'         ,  FormatDateTime('dd/mm/yy',FieldByName('CTR_DTACAD').AsDateTime) , 9  , alCentro   );
        objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(FieldByName('CTR_DUPORI').AsFloat, ffNumber, 9, 2)  , 13 , alDireita  );
        objLinha.pAddColuna('VR.C/JUR.SUJ'    ,  FloatToStrF(FieldByName('CTR_VALSUJ').AsFloat, ffNumber, 9, 2)  , 13 , alDireita  );
        objLinha.pAddColuna('VL.RECALC.(*)'   ,  FloatToStrF(FieldByName('CTR_VALCOR').AsFloat, ffNumber, 9, 2)  , 14 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);


        sumValDup := sumValDup + FieldByName('CTR_VALDUP').AsFloat;
        sumValSuj := sumValSuj + FieldByName('CTR_VALSUJ').AsFloat;
        sumValCor := sumValCor + FieldByName('CTR_VALCOR').AsFloat;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlTotal;
        objLinha.pAddColuna(''                , 'TOTAIS'                                , 76 , alDireita, teAutcom );
        objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(sumValDup, ffNumber, 9, 2) , 13 , alDireita  );
        objLinha.pAddColuna('VR.C/JUR.SUJ'    ,  FloatToStrF(sumValSuj, ffNumber, 9, 2) , 13 , alDireita  );
        objLinha.pAddColuna('VL.RECALC.(*)'   ,  FloatToStrF(sumValCor, ffNumber, 9, 2) , 14 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);


        objLiberacao.objMsgLibera.pAddTextoCaption('(*)Taxa de Juros aplicada', FloatToStrF(fltPerJur, ffNumber, 3, 2) + '%', 25 , alDireita, teAmbos, '', 6);
        objLiberacao.objMsgLibera.pAddTextoCaption('(*)Taxa de Multa aplicada', FloatToStrF(fltPerMul, ffNumber, 3, 2) + '%', 25 , alDireita, teAmbos, '', 6);
        objLiberacao.objMsgLibera.pAddSeparador(125);

      End;

       {*****************************************************}
      {*  LIBERAÇÃO ATRAVÉS DE SENHA E GRAVAÇÃO DO LOGVAR  *}
      {**************************************************MA*}
      blnNivel2 := (fltPerJur < fCfgSis('JURMN1', varDouble)) And (fltPerJur >= fCfgSis('JURMN2', varDouble));
      strSenJM2 := fCfgSis('SENJM2');

      blnNivel3 := fltPerJur < fCfgSis('JURMN2', varDouble);
      strSenJM3 := fCfgSis('SENJM3');

      If (fCfgSis('SENJM1') <> '') And (fltPerJur < fCfgSis('JURMN1', varDouble)) Then
      begin
        objLiberacao.strDirAce := 'SENJM1';
        objLiberacao.strSenLib := fCfgSis('SENJM1');
        objLiberacao.strMsgSen := 'Recalcular Juros';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strDirAceNv2 := 'SENJM2';
        objLiberacao.strSenLibNv2 := strSenJM2;
        objLiberacao.blnNivel2 := blnNivel2;
        objLiberacao.strDirAceNv3 := 'SENJM3';
        objLiberacao.strSenLibNv3 := strSenJM3;
        objLiberacao.blnNivel3 := blnNivel3;
        objLiberacao.objMsgLibera.strTitulo := 'O valor de juros é menor que o permitido.';

        blnConfirma := objLiberacao.fLibera;
      end
      Else If (fCfgSis('SENJM1') = '') Or
              ((fCfgSis('JURMN1', varDouble) <= 0) Or
               (fCfgSis('JURMN1', varString) = '')) Then
      begin
        objLiberacao.strDirAce := 'SENJUR';
        objLiberacao.strSenLib := fCfgSis('SENJUR');
        objLiberacao.strMsgSen := 'Recalcular Juros';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.objMsgLibera.strTitulo := 'Permitir recálculo de juros no recebimento.';

        blnConfirma := objLiberacao.fLibera;
      end;

      If (Not blnConfirma) Then
        pCalculaJurosIndiv(fltJurAnt);

      pAtualizaTemporaria(False);

    except
      On E: Exception Do
        pMensagensErro(E.message, '');
    end;
    pEnableControls(cdsDadosTemp, prcScroll);

  End;

  If (blnConfirma) Then
  Begin
    pDisableControls(cdsDadosTemp, prcScroll);
    pCalculaJurosIndiv(fltPerJur, fltPerMul);
    pAtualizaTemporaria(False);
    pEnableControls(cdsDadosTemp, prcScroll);
  End;

  Screen.Cursor := crDefault;

end;

{*******************************************}
{* CALCULA O VALOR RECEBIDO (COM EXEÇÃO AS *}
{* DUPLICATAS CREDITO)                     *}
{****************************************MV*}
function TfrmRcxSelDocumentos.fCalculaValorRecebido: Double;
Var
    prcScroll: TPrcScroll;
begin

  Result := 0.0;

  With cdsDadosTemp Do
  Begin
    pDisableControls(cdsDadosTemp, prcScroll);
    First;

    While (Not Eof) Do
    Begin

      If (FieldByName('CTR_MARDES').AsString <> 'M') Then
      Begin
        Next;
        Continue;
      End;

      If (FieldByName('CTR_VALREC').AsFloat > 0.0) Then
        Result := Result + FieldByName('CTR_VALREC').AsFloat;

      Next;
    End;

    pEnableControls(cdsDadosTemp, prcScroll);
  End;
end;

function TfrmRcxSelDocumentos.fCalculaTotalCreditos: Double;
begin

  Result := 0.0;

  With cdsDadosTemp Do
  Begin

    DisableControls;
    First;

    While (Not Eof) Do
    Begin

      If (FieldByName('CTR_MARDES').AsString <> 'M') Then
      Begin
        Next;
        Continue;
      End;

      If (FieldByName('CTR_VALREC').AsFloat <= 0.0) Then
        Result := Result + FieldByName('CTR_VALREC').AsFloat;

      Next;
    End;

    EnableControls;

  End;
end;

function TfrmRcxSelDocumentos.fValorCalculado(fltValSuj, fltJuros, fltPerDPo: Double): Double;
Var
  fltValDes: Double;
begin

  If (fCfgSis('DESPON', varBoolean)) And (fltPerDpo > 0) Then
    fltValDes := fFormataFloat(fltValSuj * (fltPerDpo/100.00),2)
  Else
    fltValDes := 0;

  Result :=(fltJuros + fltValSuj - fltValDes);
end;

function TfrmRcxSelDocumentos.fValidaBaixaParcialComJurosUsandoCreditos: Boolean;
var
  fltJuros,
  fltCreditos,
  fltRecebido: Double;
  intRecno: Integer;
begin
  fltJuros     := 0;
  fltCreditos  := 0;
  fltRecebido  := 0;

  With cdsDadosTemp Do
  Begin

    DisableControls;
    intRecNo := RecNo;
    First;

    While (Not Eof) Do
    Begin

      If (FieldByName('CTR_MARDES').AsString <> 'M') Then
      Begin
        Next;
        Continue;
      End;

      fltJuros := fltJuros + cdsDadosTemp.FieldByName('CTR_VALCOR').AsFloat - cdsDadosTemp.FieldByName('CTR_VALDUP').AsFloat;

      If (FieldByName('CTR_VALREC').AsFloat <= 0.0) Then
        fltCreditos := fltCreditos + (FieldByName('CTR_VALREC').AsFloat * -1)
      Else
        fltRecebido := fltRecebido + FieldByName('CTR_VALREC').AsFloat;

      Next;
    End;

    RecNo := intRecNo;
    EnableControls;
  End;

  Result := Not ((fltJuros > 0) And (fltRecebido > fltCreditos));
end;

function TfrmRcxSelDocumentos.fVerificaConfirmacaoDuplicatas: Boolean;
  Var
    blnTemTro: Boolean;
    stlEspecies: TStringList;
    prcScroll: TPrcScroll;
begin

  blnTemTro          := False;
  stlEspecies        := TStringList.Create;
  stlEspecies.Sorted := True;
  {*******************************************}
  {* NÃO PERMITE ESPECIES DUPLICADAS!!       *}
  {****************************************MV*}
  stlEspecies.Duplicates := dupIgnore;

  With cdsDadosTemp Do
  Begin

    pDisableControls(cdsDadosTemp, prcScroll);
    First;

    While (Not Eof) Do
    Begin

      If (FieldByName('CTR_MARDES').AsString <> 'M') Then
      Begin
        Next;
        Continue;
      End;

      stlEspecies.Add(FieldByName('CTR_ESPDOC').AsString);

      If (FieldByName('CTR_ESPDOC').AsString = 'TR') then
        blnTemTro := True;

      Next;
    End;

    pEnableControls(cdsDadosTemp, prcScroll);

  End;

  If (stlEspecies.Count > 1) And (blnTemTro) Then
  Begin
    If (fFormataFloat(fltTotSel, 2) = 0.0) And (intQtdSel <= 0) Then
    Begin
      Result := False;
      Exit;
    End;
  End
  Else
  Begin
    If (blnTemTro) Then
    Begin
      Result := True;
      Exit;
    End
    Else If (fFormataFloat(fltTotSel, 2) = 0) And (intQtdSel <= 0) Then
    Begin
      Result := False;
      Exit;
    End;
  End;

  Result := True;

end;

function TfrmRcxSelDocumentos.fVeiodeCH: Boolean;
Var
  prcScroll: TPrcScroll;
begin
  Result := False;

  With cdsDadosTemp Do
  Begin
    pDisableControls(cdsDadosTemp, prcScroll);
    First;

    While (Not Eof) Do
    Begin

      If (FieldByName('CTR_MARDES').AsString <> 'M') Then
      Begin
        Next;
        Continue;
      End;

      If FieldByName('CTR_ESPDOC').AsString = 'CH' Then
        Result := True;

      Next;
    End;

    pEnableControls(cdsDadosTemp, prcScroll);
  End;
end;

{*******************************************}
{* VERIFICA SE POSSUI DUPLICATAS PARCIAIS  *}
{* E/OU DUPLICATAS DE CREDTITO             *}
{****************************************MV*}
function TfrmRcxSelDocumentos.fTemDuplicataMarcada: Boolean;
  Var
    cdsDupSel: TUniClientDataSet;
begin
  Result := False;

  If Not fCfgSis('RECADT', VarBoolean) Then
    Exit;

  cdsDupSel          := TUniClientDataSet.Create(nil);
  cdsDupSel.Data     := cdsDadosTemp.Data;
  cdsDupSel.Filter   := 'CTR_MARDES = ' + QuotedStr('M');
  cdsDupSel.Filtered := True;

  If (cdsDupSel.RecordCount >= 1) Then
    Result := True;

  FreeAndNil(cdsDupSel);
end;

function TfrmRcxSelDocumentos.fTemParCre: Boolean;
var
  cdsTmp: TUniClientDataSet;
  prcScroll: TPrcScroll;
begin
  cdsTmp := TUniClientDataSet.Create(Self);
  Result := False;
  cdsTmp.Data := cdsDadosTemp.Data;

  With cdsTmp Do
  Begin

    pDisableControls(cdsDadosTemp, prcScroll);
    First;

    While (Not Eof) Do
    Begin

      If (FieldByName('CTR_MARDES').AsString = 'M') Then
      Begin

        {*******************************************}
        {* FILTRA AS DUPLICATAS:                   *}
        {* -> NÃO SELECIONADAS                     *}
        {* -> BAIXADA PARCIAL                      *}
        {* -> DUPLICATA CREDITO                    *}
        {****************************************MV*}
        If (FieldByName('CTR_VALRES').AsFloat > 0.0) Or (FieldByName('CTR_VALREC').AsFloat < 0.0) Then
        Begin
          Result := True;
          Break;
        End;

      End;

      Next;
    End;

    pEnableControls(cdsDadosTemp, prcScroll);

  End;

end;

//MF: 285995 - 30/05/2023 - Verifica se tem duplicata vencida selecionada
function TfrmRcxSelDocumentos.fTemDupVencida: Boolean;
var
  cdsTmp: TUniClientDataSet;
  prcScroll: TPrcScroll;
begin
  cdsTmp := TUniClientDataSet.Create(Self);
  Result := False;
  cdsTmp.Data := cdsDadosTemp.Data;

  With cdsTmp Do
  Begin
    pDisableControls(cdsDadosTemp, prcScroll);
    First;

    While (Not Eof) Do
    Begin
      If (FieldByName('CTR_MARDES').AsString = 'M') And (FieldByName('DIASATRASO').AsInteger > 0) Then
      Begin
        Result := True;
        Break;
      End;
      Next;
    End;

    pEnableControls(cdsDadosTemp, prcScroll);
  End;
end;

function TfrmRcxSelDocumentos.fUtilizaCredEmpresa: Boolean;
  Var
    cdsDupSel: TUniClientDataSet;
    strAuxEmp: String;
begin
  Result := False;

  If Not fCfgSis('EMPORI', VarBoolean) Then
    Exit;

  cdsDupSel          := TUniClientDataSet.Create(nil);
  pCloneDataSet(cdsDupSel, cdsDadosTemp);

  Try
    cdsDupSel.Filter   := 'CTR_MARDES = ' + QuotedStr('M');
    cdsDupSel.Filtered := True;
    cdsDupSel.IndexFieldNames := 'CTR_CODEMP';

    strEmpCod := '';
    strAuxEmp := '';
    While Not cdsDupSel.Eof Do
    Begin
      If ((cdsDupSel.FieldByName('CTR_ESPDOC').AsString = 'CC') Or (cdsDupSel.FieldByName('CTR_VALDUP').AsFloat < 0)) And
         (VS_strCodEmp <> cdsDupSel.FieldByName('CTR_CODEMP').AsString) Then
      Begin
        Result := True;

        If strAuxEmp <> cdsDupSel.FieldByName('CTR_CODEMP').AsString Then
        Begin
          strEmpCod := strEmpCod + cdsDupSel.FieldByName('CTR_CODEMP').AsString + ', ';
          strAuxEmp := cdsDupSel.FieldByName('CTR_CODEMP').AsString;
        End;
      End;

      cdsDupSel.Next;
    End;

    strEmpCod := Copy(strEmpCod, 1, Length(strEmpCod) - 2); // Para remover a vírgula adicional do final

  Finally
    FreeAndNil(cdsDupSel);
  End;
end;

function TfrmRcxSelDocumentos.fVerificaQuitacao: Boolean;
  Var
    blnTemCre: Boolean;
    blnSelNor: Boolean;
    prcScroll: TPrcScroll;
begin
  Result := False;
  blnTemCre := False;
  blnSelNor := False;

  If (fFormataFloat(fltTotSel, 02) <= 0.0) Then
  Begin
    Exit;
  End;

  With cdsDadosTemp Do
  Begin

    pDisableControls(cdsDadosTemp, prcScroll);
    First;

    While (Not Eof) Do
    Begin

      If (FieldByName('CTR_MARDES').AsString = 'M') Then
      Begin

        If (FieldByName('CTR_VALREC').AsFloat < 0.0)Then
          blnTemCre := True
        Else
          blnSelNor := True;

        If (blnTemCre) And (blnSelNor) Then
        Begin
          Result := True;
          Break;
        End;

      End;

      Next;
    End;

    pEnableControls(cdsDadosTemp, prcScroll);

  End;
end;

{*******************************************}
{* PROCESSA DUPLICATAS, TOTALIZANDO JUROS, *}
{* DESCONTOS, CRÉDITOS                     *}
{****************************************MV*}
procedure TfrmRcxSelDocumentos.pTotalizaValores;
Var
  prcScroll: TPrcScroll;
begin
  fltValJur := 0.0;
  fltDesRec := 0.0;
  fltTotCre := 0.0;
  fltDesCob := 0.0;

  With cdsDadosTemp Do
  Begin

    pDisableControls(cdsDadosTemp, prcScroll);
    First;

    While (Not Eof) Do
    Begin

      If (FieldByName('CTR_MARDES').AsString <> 'M') Then
      Begin
        Next;
        Continue;
      End;

      {*******************************************}
      {* TOTALIZA VALORES DE CREDITO DO CLIENTE  *}
      {****************************************MV*}
      If (FieldByName('CTR_VALREC').AsFloat < 0.0) Then
      Begin
        fltTotCre := fltTotCre + FieldByName('CTR_VALREC').AsFloat;
        Next;
        Continue;
      End;

      {*******************************************}
      {* SOMA SOMENTE SE NÃO FOR BAIXA PARCIAL   *}
      {****************************************MV*}
      If (FieldByName('CTR_VALRES').AsFloat <= 0) Then
      Begin
        fltValJur := fltValJur + FieldByName('CTR_VALJUR').AsFloat;
        fltDesRec := fltDesRec + FieldByName('CTR_VALDES').AsFloat;
        fltDesCob := fltDesCob + FieldByName('CTR_DESCOB').AsFloat;
      End;
      Next;
    End;

    If (fFormataFloat(fStrToFloat(edtTotSel.Text), 2) > 0.0) Then
    Begin

      fltValDoc := fFormataFloat(fltTotLiq, 2);

      If (Not blnQuitacao) And (fltTotCre < 0.0) Then
      Begin
        fltValDoc := -fltTotCre;
        blnEdiCam := False;
      End;

    End
    Else
    Begin

      fltValDoc := 0.0;
      If (fFormataFloat(fStrToFloat(edtTotSel.Text), 2) <= 0.0) Then
      Begin
        fltValDoc := fltTotRec;
      End;

      blnEdiCam := False;

    End;

    pEnableControls(cdsDadosTemp, prcScroll);

  End;
end;

procedure TfrmRcxSelDocumentos.mnuCalcJurosIndividualClick(Sender: TObject);
var
  blnEncMarcado: Boolean;
begin
  inherited;
  blnEncMarcado := False;

  If blnF11 Then
    Exit;

  if cdsDadosTemp.Locate('CTR_MARDES', 'M', []) THEN
    blnEncMarcado := True;

  If blnEncMarcado Then
  Begin
    fMensagem('', 'Para efetuar o recálculo do juros, nenhuma duplicata pode estar selecionada!', ['&Ok']);
    Exit;
  End;

  TfrmGravando.fExecutarModal(pRecalculaJurosIndiv,'Aguarde... Recalculando Juros.','');
end;

procedure TfrmRcxSelDocumentos.AplicaDescontoGeral;
  Var
    arrDesGer: Array of TDescontoGeral;
    blnConfirma: Boolean;
    strDescGer,
    strValBaiTot : String;
    fltValLiq,
    fltDescGer,
    fltValBaiTot,
    fltValDesc,
    LDescontoTotalAplicado : Double;
    intRecNo   : Integer;
    fltCtrDes,
    fltCtrDe2  : Double;
    blnNivel2  : Boolean;
    strSenNv2 : String;
    fltPerMax,
    fltValPag,
    fltTmpTotDesc,
    fltValDif: Double;
    blnDigSenha: Boolean;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;

    LDataset: TDataset;

  function fGetValDes(fltValGer, fltValDup, fltValDes: Double): Double;
  Begin
    Result := 0;
      {*******************************************************************}
      {* Caso tenha selecionada várias duplicatas e o desconto especial  *}
      {* seja muito baixo, pode dar diferença de centavos no final por   *}
      {* conta do arredondamento feito em cada duplicata. Por essa razão *}
      {* o sistema verifica se o valor do desconto foi atingido e caso   *}
      {* tenha sido ultrapassado faz o ajuste.                           *}
      {*******************************************************************}
    If LDescontoTotalAplicado <> fltValDes Then
    Begin
      Result := RoundTo(fltValDup * fltValDes / fltValGer, -2);
      LDescontoTotalAplicado := LDescontoTotalAplicado + Result;

      If (LDescontoTotalAplicado > fltValDes) Then
      Begin
        Result := RoundTo((fltValDes - LDescontoTotalAplicado) + Result, -2) ;
        LDescontoTotalAplicado :=  fltValDes;
      End;
    End;
  End;

  procedure pAdicionaLista(fltValDes, fltValRec: Double);
    Var
      intIndex: Integer;
  Begin
    SetLength(arrDesGer, Length(arrDesGer) + 1);
    intIndex := Length(arrDesGer) -1;

    arrDesGer[intIndex].strCODCLI := LDataset.FieldByName('CTR_CODCLI').AsString;
    arrDesGer[intIndex].strNOMCLI := LDataset.FieldByName('CTR_NOMCLI').AsString;
    arrDesGer[intIndex].strNUMDUP := LDataset.FieldByName('CTR_NUMDUP').AsString;
    arrDesGer[intIndex].strPARDUP := LDataset.FieldByName('CTR_PARCEL').AsString;
    arrDesGer[intIndex].strESPDOC := LDataset.FieldByName('CTR_ESPDOC').AsString;
    arrDesGer[intIndex].strCODEMP := LDataset.FieldByName('CTR_CODEMP').AsString;
    arrDesGer[intIndex].fltVALDUP := LDataset.FieldByName('CTR_VALDUP').AsFloat;
    arrDesGer[intIndex].fltVALCAL := LDataset.FieldByName('CTR_VALCOR').AsFloat;
    arrDesGer[intIndex].fltVALDES := fltValDes;
    arrDesGer[intIndex].fltVALREC := fltValRec;
    arrDesGer[intIndex].dtaDTAVEN := LDataset.FieldByName('CTR_DTAVEN').AsDateTime;
    arrDesGer[intIndex].dtaDTACAD := LDataset.FieldByName('CTR_DTACAD').AsDateTime;
    arrDesGer[intIndex].strMOTDES := dicBaixa['MotivoDoDesconto'];
  End;

  procedure pAplicaDescontoDuplicata(fltDesconto: Double);
  Begin
    LDataset.Edit;

    LDataset.FieldByName('CTR_VALDES').AsFloat := fltDesconto;
    LDataset.FieldByName('CTR_VALREC').AsFloat := LDataset.FieldByName('CTR_DUPORI').AsFloat -
                                                   LDataset.FieldByName('CTR_VALDES').AsFloat +
                                                   LDataset.FieldByName('CTR_VALJUR').AsFloat +
                                                   LDataset.FieldByName('CTR_DESCOB').AsFloat;
    LDataset.FieldByName('CTR_MOTDES').AsString := dicBaixa['MotivoDoDesconto'];
    LDataset.Post;
  End;

  procedure pMontaMensagem;
    Var
      i : Integer;
      fltValOrig,
      fltValDesc,
      fltValRece,
      fltSomValOri,
      fltSomDescon,
      fltSomValRec,
      fltPerDes: Double;
      strCodCli: String;
  Begin
    fltSomValOri  := 0;
    fltSomDescon  := 0;
    fltSomValRec  := 0;
    fltValOrig    := 0;
    fltValDesc    := 0;
    fltValRece    := 0;
    fltTmpTotDesc := 0;
    // fltValDif     := 0;
    strCodCli     := '';

    {****************************************************}
    {* FAZ ORDENAÇÃO PELO CÓD CLIENTE E DATA CADASTRO   *}
    {*************************************************FS*}
    TArray.Sort<TDescontoGeral>(arrDesGer , TDelegatedComparer<TDescontoGeral>.Construct(
      function(const Left, Right: TDescontoGeral): Integer
      begin
        Result := TComparer<String>.Default.Compare(Concat(Left.strCODCLI, DateToStr(Left.dtaDTACAD)),
                                                    Concat(Right.strCODCLI, DateToStr(Right.dtaDTACAD)));
      end));

    For i := 0 To Length(arrDesGer) - 1 Do
    Begin
      If (strCodCli <> arrDesGer[i].strCODCLI) Then
      Begin
        strCodCli  := arrDesGer[i].strCODCLI;

        If not objTabela.isEmpty Then
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlTotal;
          objLinha.pAddColuna(''                 , ''                                     , 26 , alDireita , teAutcom);
          objLinha.pAddColuna('VALOR ORIGINAL'  , FloatToStrF(fltValOrig, ffNumber, 9, 2) , 30 , alDireita , teAmbos, True);
          objLinha.pAddColuna('VALOR DESCONTO'  , FloatToStrF(fltValDesc, ffNumber, 9, 2) , 30 , alDireita , teAmbos, True);
          objLinha.pAddColuna('VALOR RECEBIDO'  , FloatToStrF(fltValRece, ffNumber, 9, 2) , 30 , alDireita , teAmbos, True);
          objTabela.lstLinhas.Add(objLinha);

          fltValOrig := 0;
          fltValDesc := 0;
          fltValRece := 0;
        End;
      End;


      if objTabela.isEmpty Then
      Begin

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''  , 'DOCUMENTO'       , 17 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'EMP'             , 4  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'CLIENTE'         , 42 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'DT.VENC.'        , 9  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'DT.CAD.'         , 9  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'VR.DUPLICATA'    , 13 , alDireita  , teAutcom);
        objLinha.pAddColuna(''  , 'VR.CORRIGIDO(*)' , 16 , alDireita  , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

      End;

      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('DOCUMENTO'       ,  fPadR(arrDesGer[i].strNUMDUP,12)
                                             + arrDesGer[i].strPARDUP + '-'
                                             + arrDesGer[i].strESPDOC                              , 17 , alEsquerda );
      objLinha.pAddColuna('EMP'             ,  arrDesGer[i].strCODEMP                              , 4  , alCentro   );
      objLinha.pAddColuna('CLIENTE'         ,  arrDesGer[i].strNOMCLI                              , 42 , alEsquerda );
      objLinha.pAddColuna('DT.VENC.'        ,  FormatDateTime('dd/mm/yy',arrDesGer[i].dtaDTAVEN)   , 9  , alCentro   );
      objLinha.pAddColuna('DT.CAD.'         ,  FormatDateTime('dd/mm/yy',arrDesGer[i].dtaDTACAD)   , 9  , alCentro   );
      objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(arrDesGer[i].fltVALDUP, ffNumber, 9, 2) , 13 , alDireita  );
      objLinha.pAddColuna('VR.CORRIGIDO(*)' ,  FloatToStrF(arrDesGer[i].fltVALCAL, ffNumber, 9, 2) , 16 , alDireita  );
      objTabela.lstLinhas.Add(objLinha);


      fltValOrig := fltValOrig + arrDesGer[i].fltVALCAL;
      fltValDesc := fltValDesc + arrDesGer[i].fltVALDES;
      fltValRece := fltValRece + arrDesGer[i].fltVALREC;

      fltSomValOri := fltSomValOri + arrDesGer[i].fltVALCAL;
      fltSomDescon := fltSomDescon + arrDesGer[i].fltVALDES;
      fltSomValRec := fltSomValRec + arrDesGer[i].fltVALREC;
    End;

    If (fltValOrig> 0) And (fltValdesc > 0) And (fltValRece > 0) Then
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlTotal;
      objLinha.pAddColuna(''                , ''                                      , 26 , alDireita , teAutcom);
      objLinha.pAddColuna('VALOR ORIGINAL'  , FloatToStrF(fltValOrig, ffNumber, 9, 2) , 30 , alDireita , teAmbos, True);
      objLinha.pAddColuna('VALOR DESCONTO'  , FloatToStrF(fltValDesc, ffNumber, 9, 2) , 30 , alDireita , teAmbos, True);
      objLinha.pAddColuna('VALOR RECEBIDO'  , FloatToStrF(fltValRece, ffNumber, 9, 2) , 30 , alDireita , teAmbos, True);
      objTabela.lstLinhas.Add(objLinha);
    End;

    objLiberacao.objMsgLibera.pAddTexto('O valor do desconto é maior que o permitido.');

    If dicBaixa['MotivoDoDesconto'] <> '' Then
    Begin
      objLiberacao.objMsgLibera.pAddTexto('Motivo do desconto: ' + dicBaixa['MotivoDoDesconto']);
      objLiberacao.objMsgLibera.pAddTexto('');
    End;

    fltPerDes := (fltSomDescon / fStrToFloat(dicBaixa['ValorBaixaTotal'])) * 100;

    objLiberacao.objMsgLibera.pAddTextoCaption('Valor original'                , FormatFloat('#,##0.00', fStrToFloat(dicBaixa['ValorBaixaTotal'])) , 30);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor desconto concedido'      , FormatFloat('#,##0.00', fltSomDescon) , 30);
    objLiberacao.objMsgLibera.pAddTextoCaption('Desconto sobre ' + dicBaixa['DescontoSobre'] + ' (%)', FormatFloat('#,##0.00', fltPerDes)+'%', 30);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor recebido'                , FormatFloat('#,##0.00', fltSomValRec) , 30);
  End;
begin
  LDAtaset := dbgDocumentosDBTableView1.DataController.DataSource.Dataset;


  Application.ProcessMessages;
  Screen.Cursor := crHourGlass;
  blnDigSenha   := False;
  blnNivel2     := False;
  blnConfirma   := dicBaixa['Confirmado'];
  strDescGer    := dicBaixa['DescontoTotal'];
  strValBaiTot  := dicBaixa['ValorBaixaTotal'];
  intRecNo      := LDataset.RecNo;
  fltPerMax     := 0;

  Try
    If Not blnConfirma Then
      Exit;

    fltDescGer  := fStrToFloat(strDescGer);
    fltValBaiTot:= fStrToFloat(strValBaiTot);

    Try
      LDataset.DisableControls;
      LDataset.Filtered := False;
      LDataset.Filter   := 'CTR_MARDES = ''M''';
      LDataset.Filtered := True;

      While Not LDataset.Eof Do
      Begin
        {* Se for baixa parcial e/ou Crédito não inclui desconto *}
        If (LDataset.FieldByName('CTR_BAIPAR').AsString = 'S') Or
           (LDataset.FieldByName('CTR_VALCOR').AsFloat < 0) Then
        Begin
          LDataset.Next;
          Continue;
        End;

        fltValLiq := LDataset.FieldByName('CTR_VALCOR').AsFloat;
        fltCtrDes := 1 - (fCfgSis('RCXDES', varDouble) / 100);
        fltCtrDe2 := 1 - (fCfgSis('RCXDE2', varDouble) / 100);

        fltValDesc := fGetValDes(fltValBaiTot, fltValLiq, fltDescGer);
        fltTmpTotDesc := fltTmpTotDesc + fltValDesc;

        fltPerMax := fCfgSis('RCXDES', varDouble);
        fltValPag := (LDataset.FieldByName('CTR_VALCOR').AsFloat - fltValDesc);

        If (RoundTo(fltValPag, -2) < RoundTo(fltValLiq * fltCtrDes, -2)) Then
        Begin
          pAdicionaLista(fltValDesc, fltValPag);

          If Not blnNivel2 Then
            blnNivel2 := RoundTo(fltValLiq * fltCtrDe2, -2) > RoundTo(fltValPag, -2);

          If fEmptyStr(strSenNv2) Then
            strSenNv2 := fCfgSis('SENDE2');
        End;

        LDataset.Next;
      End;

      {*********************************}
      {* Trata a diferença de centavos *}
      {******************************FS*}
      fltValDif := fltDescGer - fltTmpTotDesc;

      If (Length(arrDesGer) > 0) Then
      Begin
        {* Se tiver diferença, joga a mesma para a primeira duplicata *}
        If (RoundTo(fltValDif, -2) <> 0) Then
        Begin
          arrDesGer[0].fltVALDES := arrDesGer[0].fltVALDES + RoundTo(fltValDif, -2);
          arrDesGer[0].fltVALREC := arrDesGer[0].fltVALREC - RoundTo(fltValDif, -2);
        End;

        objLiberacao.Clear;
        objTabela := TRegistroMsgLiberaTabela.Create;
        pMontaMensagem;
        objLiberacao.objMsgLibera.pAddTextoCaption('Desconto máximo permitido', FormatFloat('#,##0.00', fltPerMax) + '%', 30);
        objLiberacao.objMsgLibera.pAddQuebra;

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        While (not blnDigSenha) Do
        Begin
          objLiberacao.strDirAce := 'RCXDESMAX';
          objLiberacao.strSenLib := fCfgSis('SENDES');
          objLiberacao.strMsgSen := 'Desconto Máximo';
          objLiberacao.blnMosMen := True;
          objLiberacao.strCodOpe := strLoginUsuarioLogado;
          objLiberacao.strCodDig := strLoginUsuarioLogado;
          objLiberacao.strDirAceNv2 := 'RCXDESMA2';
          objLiberacao.strSenLibNv2 := strSenNv2;
          objLiberacao.blnNivel2 := blnNivel2;

          If (objLiberacao.fLibera) Then
            Break
          else
            If (fMensagem('', 'Senha Incorreta!', ['&Novamente', '&Desistir']) = 2) Then
              Exit;
        End;
      End;

      {* Aplica o desconto *}
      LDescontoTotalAplicado := 0;
      LDataset.First;
      While Not LDataset.Eof Do
      Begin
        {* Se for baixa parcial e/ou Crédito não inclui desconto *}
        If (LDataset.FieldByName('CTR_BAIPAR').AsString = 'S') Or
           (LDataset.FieldByName('CTR_VALCOR').AsFloat < 0) Then
        Begin
          LDataset.Next;
          Continue;
        End;

        fltValDesc := fGetValDes(fltValBaiTot, LDataset.FieldByName('CTR_VALCOR').AsFloat, fltDescGer);
        pAplicaDescontoDuplicata(fltValDesc);

        LDataset.Next;
      End;

      {* Se tiver diferença, joga a mesma para a primeira duplicata *}
      If (RoundTo(fltValDif, -2) <> 0) Then
      Begin
        LDataset.Filter   := 'CTR_MARDES = ''M'' AND CTR_BAIPAR<>''S'' AND CTR_VALCOR > 0';
        LDataset.First;

        If LDataset.RecordCount > 0 Then
          pAplicaDescontoDuplicata(LDataset.FieldByName('CTR_VALDES').AsFloat + RoundTo(fltValDif, -2))
        Else
          fMensagem('ATENÇÃO', 'Não foi possível aplicar o desconto geral nas duplicatas selecionadas. ' + #13 +
                               'É necessário selecionar ao menos uma duplicata positiva para baixa total.',
                               ['&OK'], 0);
      End;
    Except
      On E: Exception Do
      Begin
        blnConfirma := False;
        pMensagensErro('Ocorreu um erro ao calcular o desconto geral.' + #13 +
                       'Erro gerado: ' + E.message, '[frmRcxSelDocumentos.AplicaDescontoGeral]');
      End;
    End;

    If blnConfirma Then
      pCalculaTotais;
  Finally
    Screen.Cursor      := crDefault;
    LDataset.EnableControls;
    btnAplicaFiltro.Click;

    LDataset.RecNo := intRecNo;
  End;

end;

procedure TfrmRcxSelDocumentos.btnAplicaFiltroClick(Sender: TObject);
  Var
    strFiltro: String;
begin
  inherited;
  strFiltro := '';
  If (Not fEmptyStr(edtNumDoc.Text)) Then
  Begin
    If Copy(edtNumDoc.Text, 1, Pos('%', edtNumDoc.Text)) = '%' then
      strFiltro := ' CTR_NUMDUP LIKE ' + QuotedStr(edtNumDoc.Text) + ' '
    Else
      strFiltro := ' CTR_NUMDUP = ' + QuotedStr(edtNumDoc.Text) + ' ';
  End;

  If (Not fEmptyStr(edtNumDocOrigem.Text)) Then
  Begin
    If (Not fEmptyStr(strFiltro)) Then
    Begin
      strFiltro := strFiltro + ' AND ';
    End;

    If Copy(edtNumDocOrigem.Text, 1, Pos('%', edtNumDocOrigem.Text)) = '%' then
      strFiltro := ' FGO_DOCORI LIKE ' + QuotedStr(edtNumDocOrigem.Text) + ' '
    Else
      strFiltro := ' FGO_DOCORI = ' + QuotedStr(edtNumDocOrigem.Text) + ' ';
  End;

  If (Not fEmptyStr(edtParcel.Text)) Then
  Begin
    If (Not fEmptyStr(strFiltro)) Then
    Begin
      strFiltro := strFiltro + ' AND ';
    End;

    If Copy(edtParcel.Text, 1, Pos('%', edtParcel.Text)) = '%' then
      strFiltro := strFiltro + ' CTR_PARCEL LIKE ' + QuotedStr(edtParcel.Text)
    Else
      strFiltro := strFiltro + ' CTR_PARCEL = ' + QuotedStr(edtParcel.Text);
  End;

  If (Not fEmptyStr(edtEspDoc.Text)) Then
  Begin
    If (Not fEmptyStr(strFiltro)) Then
    Begin
      strFiltro := strFiltro + ' AND ';
    End;

    If Copy(edtEspDoc.Text, 1, Pos('%', edtEspDoc.Text)) = '%' then
      strFiltro := strFiltro + ' CTR_ESPDOC LIKE ' + QuotedStr(edtEspDoc.Text)
    Else
      strFiltro := strFiltro + ' CTR_ESPDOC = ' + QuotedStr(edtEspDoc.Text);
  End;

  If (Not fEmptyStr(edtEspDocOrigem.Text)) Then
  Begin
    If (Not fEmptyStr(strFiltro)) Then
    Begin
      strFiltro := strFiltro + ' AND ';
    End;

    If Copy(edtEspDocOrigem.Text, 1, Pos('%', edtEspDocOrigem.Text)) = '%' then
      strFiltro := strFiltro + ' FGO_ESPORI LIKE ' + QuotedStr(edtEspDocOrigem.Text)
    Else
      strFiltro := strFiltro + ' FGO_ESPORI = ' + QuotedStr(edtEspDocOrigem.Text);
  End;

  If (Not fEmptyStr(edtNumCoo.Text)) Then
  Begin
    If (Not fEmptyStr(strFiltro)) Then
    Begin
      strFiltro := strFiltro + ' AND ';
    End;

    If Copy(edtNumCoo.Text, 1, Pos('%', edtNumCoo.Text)) = '%' then
      strFiltro := strFiltro + ' FIS_NUMCOO LIKE ' + QuotedStr(edtNumCoo.Text)
    Else
      strFiltro := strFiltro + ' FIS_NUMCOO = ' + QuotedStr(edtNumCoo.Text);
  End;

  if (not fEmptyStr(edtEvento.Text)) then
  begin
    if (not fEmptyStr(strFiltro)) then
    begin
      strFiltro := strFiltro + ' AND ';
    end;

    if Copy(edtEvento.Text, 1, Pos('%', edtEvento.Text)) = '%' then
      strFiltro := strFiltro + ' CTR_CODEVE LIKE ' + QuotedStr(edtEvento.Text)
    else
      strFiltro := strFiltro + ' CTR_CODEVE = ' + QuotedStr(edtEvento.Text);
  end;

  cdsDadosTemp.Filter := strFiltro;
  If (Not fEmptyStr(cdsDadosTemp.Filter)) Then
  Begin
    cdsDadosTemp.Filtered := True;
  End
  Else
  Begin
    cdsDadosTemp.Filtered := False;
  End;

  pTotalFiltro(edtNumDoc.Text,edtParcel.Text,edtEspDoc.Text);

  If Not cdsDadosTemp.IsEmpty Then
    pSetFocus(dbgDocumentos);
end;

procedure TfrmRcxSelDocumentos.btnPesquisaClick(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNumDoc);
end;

procedure TfrmRcxSelDocumentos.btnImpressaoClick(Sender: TObject);
  Var
    strNomeFila: String;
    strTipImp  : String;
    strSenha   : String;
    cdsGenRec  : TUniClientDataSet;
    prcScroll  : TPrcScroll;
    LfrmRelRcxReciboCob : TfrmRelRcxReciboCob;
    intRecNo   : Integer;
    stlClientes: TStringList;
    intCont    : Integer;
    blnPersonalizavel : Boolean;
    qryGenCli: TUniQuery;
    FPais      : TPais;

    procedure pCarregarCliente(strCodCli : String);
      var
        strSQL : String;
    begin
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  * ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADCLI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CLI_CODCLI = :CODCLI ';

      qryGenCli.Close;
      qryGenCli.SQL.Clear;
      qryGenCli.SQL.Add(strSQL);
      qryGenCli.ParamByName('CODCLI').AsString := strCodCli;
      qryGenCli.Open;
    End;
Begin
  blnPersonalizavel := True;
  FPais := fSetaPais;
  If (ffrmSenha(strSenha, 'Imprimir Recibo')) Then
  Begin
    If (strSenha = fCfgSis('SENREC')) Then
    Begin
      cdsGenRec := TUniClientDataSet.Create(Self);

      With cdsGenRec, FieldDefs Do
      Begin
        With AddFieldDef Do Begin Name := 'CODCLI'; DataType := ftString; Size := 008; End;
        With AddFieldDef Do Begin Name := 'NUMDUP'; DataType := ftString; Size := 020; End;
        With AddFieldDef Do Begin Name := 'CODEMP'; DataType := ftString; Size := 003; End;
        With AddFieldDef Do Begin Name := 'DTAEMI'; DataType := ftDate; End;
        With AddFieldDef Do Begin Name := 'DTAVEN'; DataType := ftDate; End;
        With AddFieldDef Do Begin Name := 'VALORI'; DataType := ftFloat;   End; //12,2
        With AddFieldDef Do Begin Name := 'VALJUR'; DataType := ftFloat;   End; //12,2
        With AddFieldDef Do Begin Name := 'DESCON'; DataType := ftFloat;   End; //12,2
        With AddFieldDef Do Begin Name := 'VALTOT'; DataType := ftFloat;   End; //12,2

        cdsGenRec.FieldDefs.Add('NOMCLI',ftString,200);
        cdsGenRec.FieldDefs.Add('ENDCLI',ftString,100);
        cdsGenRec.FieldDefs.Add('CIDCLI',ftString,100);
        cdsGenRec.FieldDefs.Add('CGCCLI',ftString,15);
        cdsGenRec.FieldDefs.Add('FONCLI',ftString,20);
        cdsGenRec.FieldDefs.Add('BAICLI',ftString,100);
        cdsGenRec.FieldDefs.Add('CEPCLI',ftString,15);
        cdsGenRec.FieldDefs.Add('IRGCLI',ftString,20);
        cdsGenRec.FieldDefs.Add('FONCLI2',ftString,20);

        CreateDataSet;
        Open;
      End;

      With cdsDadosTemp Do
      Begin
        pDisableControls(cdsDadosTemp, prcScroll);
        intRecNo := RecNo;
        qryGenCli := fCriaQuery(Self);
        First;
        While Not Eof Do
        Begin

          If FieldByName('CTR_MARDES').AsString = 'M' Then
          Begin
            pCarregarCliente(FieldByName('CTR_CODCLI').AsString);

            cdsGenRec.Insert;
            cdsGenRec.FieldByName('CODCLI').AsString   := FieldByName('CTR_CODCLI').AsString;
            cdsGenRec.FieldByName('NUMDUP').AsString   := FieldByName('CTR_NUMDUP').AsString + ' - ' +
                                                          FieldByName('CTR_PARCEL').AsString;
            cdsGenRec.FieldByName('CODEMP').AsString   := FieldByName('CTR_CODEMP').AsString;
            cdsGenRec.FieldByName('DTAEMI').AsDateTime := FieldByName('CTR_DTACAD').AsDateTime;
            cdsGenRec.FieldByName('DTAVEN').AsDateTime := FieldByName('CTR_DTAVEN').AsDateTime;
            cdsGenRec.FieldByName('VALORI').AsFloat    := FieldByName('CTR_VALORI').AsFloat;
            cdsGenRec.FieldByName('VALJUR').AsFloat    := FieldByName('CTR_VALJUR').AsFloat;
            cdsGenRec.FieldByName('DESCON').AsFloat    := FieldByName('CTR_VALDES').AsFloat;
            cdsGenRec.FieldByName('VALTOT').AsFloat    := FieldByName('CTR_VALREC').AsFloat;


            cdsGenRec.FieldByName('NOMCLI').AsString   := qryGenCli.FieldByName('CLI_NOMCLI').AsString;
            cdsGenRec.FieldByName('ENDCLI').AsString   := qryGenCli.FieldByName('CLI_ENDERE').AsString + IIF(Not fEmptyStr(qryGenCli.FieldByName('CLI_ENDNUM').AsString), ', ' +
                                                          qryGenCli.FieldByName('CLI_ENDNUM').AsString, '');

            cdsGenRec.FieldByName('CIDCLI').AsString   := fRetNomCidade(qryGenCli.FieldByName('CLI_CODCID').AsString);
            cdsGenRec.FieldByName('CGCCLI').AsString   := FormatMaskText(IIF(qryGenCli.FieldByName('CLI_CGCCPF').AsString = '1', fRetMascaraC_G_C_(FPais, C_G_C_), fRetMascaraC_G_C_(FPais, C_P_F_)),
                                                                             qryGenCli.FieldByName('CLI_C_G_C_').AsString);
            cdsGenRec.FieldByName('FONCLI').AsString   := fFormataFone(qryGenCli.FieldByName('CLI_FONE01').AsString);
            cdsGenRec.FieldByName('BAICLI').AsString   := qryGenCli.FieldByName('CLI_BAIRRO').AsString;
            cdsGenRec.FieldByName('CEPCLI').AsString   := FormatMaskText('99999-999;0;_', qryGenCli.FieldByName('CLI_C_E_P_').AsString);
            cdsGenRec.FieldByName('IRGCLI').AsString   := qryGenCli.FieldByName('CLI_I_E_S_').AsString;
            cdsGenRec.FieldByName('FONCLI2').AsString  := fFormataFone(qryGenCli.FieldByName('CLI_FONE02').AsString);
            cdsGenRec.Post;
          End;

          Next;
        End;
        RecNo := intRecNo;
        pEnableControls(cdsDadosTemp, prcScroll);
      End;

      With cdsGenRec Do
      Begin
        If Not IsEmpty Then
        Begin
          Try
            stlClientes := fCriaListaClientes;
            pCriarFormularios(TfrmRelRcxReciboCob,LfrmRelRcxReciboCob);

            For intCont := 0 To stlClientes.Count -1 Do
            Begin
              If Not LfrmRelRcxReciboCob.fImprimirReciboCobranca(cdsGenRec,stlClientes[intCont]) Then
              Begin
                blnPersonalizavel := False;
                Break;
              End
            End;

            If Not blnPersonalizavel Then
            Begin
              pCarregaConfImpr(qryCfgRel, 'frmRcxSelDocumentos');
              fPreImpressao(qryCfgRel, strNomeFila, strTipImp, False);

              LfrmRelRcxReciboCob.frxDBReciboCobranca.DataSet := cdsGenRec;
              LfrmRelRcxReciboCob.frxReciboCobranca.DotMatrixReport             := False;
              LfrmRelRcxReciboCob.frxReciboCobranca.PrintOptions.PrintMode      := pmScale;
              LfrmRelRcxReciboCob.frxReciboCobranca.PrintOptions.PrintOnSheet   := 9;

              If strNomeFila.Equals(TSpoolImpressaoCitel.PontoExportarPDF) Then
              Begin
                If LfrmRelRcxReciboCob.frxReciboCobranca.PrepareReport Then
                  pPrintReport('TfrmRcxSelDocumentos.btnImpressaoClick',
                               'Recibo de cobrança',
                               strNomeFila,
                               LfrmRelRcxReciboCob.frxReciboCobranca);
              End
              Else
              Begin
                If VerImpressoraONLINE(strNomeFila) <> 0 Then
                Begin
                  fMensagem('ATENÇÃO!', 'Impressora "' + strNomeFila + '" está OFFLINE! Selecione outra!', ['&OK']);
                  LfrmRelRcxReciboCob.frxReciboCobranca.PrintOptions.ShowDialog := True;
                End
                Else
                Begin
                  LfrmRelRcxReciboCob.frxReciboCobranca.PrintOptions.ShowDialog := False;
                  LfrmRelRcxReciboCob.frxReciboCobranca.PrintOptions.Printer := AnsiReplaceText(strNomeFila, '\\' + fRetNomeRede + '\', '');
                End;

                If LfrmRelRcxReciboCob.frxReciboCobranca.PrepareReport Then
                Begin
                  If (fEmptyStr(strNomeFila)) Then
                    pPreviewReport('TfrmRcxSelDocumentos.btnImpressaoClick',
                                   'Recibo de cobrança',
                                   LfrmRelRcxReciboCob.frxReciboCobranca)
                  Else
                    pPrintReport('TfrmRcxSelDocumentos.btnImpressaoClick',
                                 'Recibo de cobrança',
                                 strNomeFila,
                                 LfrmRelRcxReciboCob.frxReciboCobranca);
                End;
              End;
            End;
          Except
            On E: Exception Do
            Begin
              pMensagensErro(E.Message, '[frmRcxSelDocumentos.btnImpressaoClick]');
            End;
          End;

          FreeAndNil(LfrmRelRcxReciboCob);

        End;

        cdsGenRec.Close;
        FreeAndNil(cdsGenRec);
        FreeAndNil(qryGenCli);
      End;

    End
    Else
      fMensagem('', 'Senha Incorreta!', ['&OK']);
  End;

end;

procedure TfrmRcxSelDocumentos.btnInfCobrClick(Sender: TObject);
   Var
     frmInfCobranca : TfrmInfCobranca;
begin
  inherited;
  If not cdsDadosTemp.IsEmpty Then
  Begin
    If Not btnInfCobr.Visible Then
      Exit;

    If (Not cdsDadosTemp.IsEmpty) Then
    Begin
      Try
        pCriarFormularios(TfrmInfCobranca, frmInfCobranca);
        frmInfCobranca.edtCodCli.Text := fField('CTR_CODCLI').AsString;
        frmInfCobranca.edtNomCli.Text := fRetNomCliente(fField('CTR_CODCLI').AsString);
        frmInfCobranca.ShowModal;

      Finally
        pFreeAndNil(frmInfCobranca);
      End;
    End;
  End;
end;

procedure TfrmRcxSelDocumentos.btnMedPondClick(Sender: TObject);
begin
  if not cdsDadosTemp.Active then
    exit;

  edtMedPond.Text := fRetornaMediaPonderadaNova(cdsDadosTemp.FieldByName('CTR_CODCLI').AsString, cdsDadosTemp, not blnDiaUtil);

  blnDiautil := not blnDiautil;

  btnMedPondMouseEnter(btnMedPond);

end;

procedure TfrmRcxSelDocumentos.btnMedPondMouseEnter(Sender: TObject);
Var msg:String;
begin

  if blnDiaUtil then
    msg := 'Recalcular com Dias Corridos'
  else
    msg := 'Recalcular com Dias Úteis';

  HintControler.ShowHint(Self.Left + btnMedPond.Left + btnMedPond.Width,
                         Self.Top  + btnMedPond.Top  + btnMedPond.Height + btnMedPond.Parent.Top, 'Média Ponderada', msg);
end;

procedure TfrmRcxSelDocumentos.btnMedPondMouseLeave(Sender: TObject);
begin
  HintControler.HideHint;
end;

{*******************************************}
{*  USADA PARA CÁLCULO DE JUROS FUTURO     *}
{* AGORA VERIFICA DESCONTO DE PONTUALIDADE *}
{* FOI TOTALMENTE REFEITA ESTA PROCEDURE   *}
{REQ 42920*****************************MA*LE}
procedure TfrmRcxSelDocumentos.pCalculaJurosFuturo(fltPerJur: Double; strDtaPag: String; fltPerMul : Double = 9999);
  Var
    intRecNo  : Integer;
    fltValCor :  Double;  //Valor Corrigido
    fltValJur : Double;  //Juros Corrigido
    prcScroll : TPrcScroll;
begin

  With cdsDadosTemp Do
  Begin
    pDisableControls(cdsDadosTemp, prcScroll);
    intRecNo := RecNo;

    First;

    While (Not Eof) Do
    Begin
      Application.ProcessMessages;

      fltValCor := 0.00;

      //Caso Desconto de pontualidade for sim e PERDPO maior do que 0
      If (fCfgSis('DESPON', varBoolean)) And (FieldByName('CTR_PERDPO').AsFloat > 0) Then
      Begin
        //Se hoje for menor ou igual a data de vencimento - os dias de tolerancia do desconto
        //a duplicata vai ter o desconto de pontualidade
        If ( VS_Date <= ( FieldByName('CTR_DTAVEN').AsDateTime - FieldByName('CTR_QTDDAV').AsInteger ) ) Then
          fltValCor := fValorCalculado(FieldByName('CTR_VALDUP').AsFloat,0,FieldByName('CTR_PERDPO').AsFloat)
        Else
          fltValCor := fValorCalculado(FieldByName('CTR_VALDUP').AsFloat,fltValCor,0);

        fltValJur := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                         strDtaPag,
                                         fltValCor,
                                         fltPerJur, fltPerMul)
      End
      Else   //Caso desconto de pontualidade for Nao
      Begin
        fltValJur := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                           strDtaPag,
                                           FieldByName('CTR_VALDUP').AsFloat,
                                           fltPerJur, fltPerMul);
      End;

      {*********************************************}
      {* VALOR CALCULADO                           *}
      {****************************************MA*LE}
      Edit;
      // Agora tendo o valor do juros calculado e o valor corrigido atribui o novo valor.
      If FieldByName('CTR_ESPDOC').AsString <> 'CC' Then
        FieldByName('CTR_VALCOR').AsFloat := FieldByName('CTR_VALDUP').AsFloat + fltValJur
      Else
        FieldByName('CTR_VALCOR').AsFloat := FieldByName('CTR_VALDUP').AsFloat;

      FieldByName('DATA_JUROS').AsDateTime := StrToDateTime(strDtaPag);
      FieldByName('CTR_CALORI').AsFloat := FieldByName('CTR_VALCOR').AsFloat;
      Post;

      Next;
    End;

    RecNo := intRecNo;
    pEnableControls(cdsDadosTemp, prcScroll);
  End;

end;

procedure TfrmRcxSelDocumentos.pCalculaJurosIndiv(fltPerJur: Double; fltPerMul : Double = 9999);
  Var
    intRecNo : Integer;
    fltValCor: Double;
    prcScroll: TPrcScroll;
begin

  With cdsDadosTemp Do
  Begin
    pDisableControls(cdsDadosTemp, prcScroll);
    intRecNo := RecNo;

    Application.ProcessMessages;

    fltValCor := fCalculaJurosCadCtr(FieldByName('CTR_DTAVEN').AsDateTime,
                                     FieldByName('CTR_VALDUP').AsFloat,
                                     fltPerJur, fltPerMul);

    {*******************************************}
    {* VALOR CALCULADO                         *}
    {****************************************AF*}
    Edit;
    If FieldByName('CTR_ESPDOC').AsString <> 'CC' Then
    Begin
      if (blnDescFinanSomenteAteVenc) then
      begin
        if (FieldByName('CTR_DTAVEN').asDateTime < VS_Date)  then
          FieldByName('CTR_VALCOR').AsFloat := fValorCalculado(FieldByName('CTR_VALDUP').AsFloat,fltValCor,0)
        else
          FieldByName('CTR_VALCOR').AsFloat := fValorCalculado(FieldByName('CTR_VALDUP').AsFloat,0,FieldByName('CTR_PERDPO').AsFloat);
      end
      else if (FieldByName('CTR_DTAVEN').asDateTime < VS_Date)  then
        FieldByName('CTR_VALCOR').AsFloat := fValorCalculado(FieldByName('CTR_VALDUP').AsFloat,fltValCor,0)
      else
        FieldByName('CTR_VALCOR').AsFloat := fValorCalculado(FieldByName('CTR_VALDUP').AsFloat,0,FieldByName('CTR_PERDPO').AsFloat);
    End
    Else
      FieldByName('CTR_VALCOR').AsFloat := FieldByName('CTR_VALDUP').AsFloat;

    FieldByName('DATA_JUROS').AsDateTime := VS_Date;
    FieldByName('CTR_CALORI').AsFloat := FieldByName('CTR_VALCOR').AsFloat;
    Post;

    Next;

    RecNo := intRecNo;
    pEnableControls(cdsDadosTemp, prcScroll);
  End;

end;

{*******************************************}
{*  CÁLCULO DE JUROS FUTURO                *}
{****************************************MA*}
procedure TfrmRcxSelDocumentos.pJurosFuturo;
  Var
    blnConfirma: Boolean;
    fltPerJur  : Double;
    fltPerMul  : Double;
    fltJurAnt  : Double;
    sumValDup  : Double;
    sumValSuj  : Double;
    sumValCor  : Double;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
    strDtaFin  : String;
    prcScroll  : TprcScroll;
    blnNivel2  : Boolean;
    strSenJM2  : String;

    blnNivel3  : Boolean;
    strSenJM3  : String;
begin

  fltPerJur     := 0.0;
  fltPerMul     := 0.0;
  Screen.Cursor := crHourGlass;

  Try
    pCriarFormularios(TfrmRcxCalculaJurosFuturo, frmRcxCalculaJurosFuturo);
    frmRcxCalculaJurosFuturo.strTitJuros:= 'Recalcular Juros Futuros';
    frmRcxCalculaJurosFuturo.edtPerJur.Hint:= 'Esta rotina irá aplicar juros e multa em todos os ' +
      #13#10 + 'títulos carregados nesta tela de seleção de duplicatas, ' +
      #13#10 + ' conforme a data final digitada.';
    frmRcxCalculaJurosFuturo.ShowModal;

    blnConfirma :=  frmRcxCalculaJurosFuturo.blnConfirma;

    If blnConfirma Then
    Begin
      fltPerJur := fStrToFloat(frmRcxCalculaJurosFuturo.edtPerJur.Text);
      fltPerMul := fStrToFloat(frmRcxCalculaJurosFuturo.edtPerMul.Text);
      strDtaFin := frmRcxCalculaJurosFuturo.mskDtaFin.Text;
    End;
  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro(E.Message, '[frmRcxSelDocumentos.CalculaJurosFuturo]');
    End;
  End;
  pFreeAndNil(frmRcxCalculaJurosFuturo);

  If (blnConfirma) Then
  Begin
    Try
      fltJurAnt := fCfgSis('JURATR', varDouble);

      //Utilizado na tela untrcxdgrecebimento;
      fltPercMultaAplicado := fltPerMul;
      fltPercJurosAplicado := fltPerJur;

      pDisableControls(cdsDadosTemp, prcScroll);
      pCalculaJurosFuturo(fltPerJur, strDtaFin, fltPerMul);
      pAtualizaTemporaria(False);

      {******************************}
      {*  EXIBIÇÃO DAS INFORMAÇÕES  *}
      {***************************MA*}

      With cdsDadosTemp Do
      Begin
        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddQuebra;
        objLiberacao.objMsgLibera.pAddTexto('RECÁLCULO DE JUROS');
        objLiberacao.objMsgLibera.pAddSeparador(125);
        If fCfgSis('SENJM1') <> '' Then
          objLiberacao.objMsgLibera.pAddTexto('JUROS MENOR QUE O PERMITIDO', alCentro, teAmbos, '',125)
        else
          objLiberacao.objMsgLibera.pAddTexto('ACESSO AO RECÁLCULO DE JUROS', alCentro, teAmbos, '',125);


        objTabela := TRegistroMsgLiberaTabela.Create;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlCabecalho;
        objLinha.pAddColuna(''  , 'DOCUMENTO'       , 17 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'EMP'             , 4  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'CLIENTE'         , 29 , alEsquerda , teAutcom);
        objLinha.pAddColuna(''  , 'DT.VENC.'        , 9  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'DT.CAD.'         , 9  , alCentro   , teAutcom);
        objLinha.pAddColuna(''  , 'VR.DUPLICATA'    , 13 , alDireita  , teAutcom);
        objLinha.pAddColuna(''  , 'VR.C/JUR.SUJ'    , 13 , alDireita  , teAutcom);
        objLinha.pAddColuna(''  , 'VL.RECALC.(*)'   , 14 , alDireita  , teAutcom);
        objTabela.lstLinhas.Add(objLinha);

        sumValDup := 0;
        sumValSuj := 0;
        sumValCor := 0;

        First;
        While Not Eof Do
        Begin
          objLinha  := TLinhaMsgLibera.Create;
          objLinha.enuTipoLinha := tlValor;
          objLinha.pAddColuna('DOCUMENTO'       ,  fPadR(FieldByName('CTR_NUMDUP').AsString + FieldByName('CTR_PARCEL').AsString, 15) + '-' +
                                                   FieldByName('CTR_ESPDOC').AsString                              , 17 , alEsquerda );
          objLinha.pAddColuna('EMP'             ,  FieldByName('CTR_CODEMP').AsString                              , 4  , alCentro   );
          objLinha.pAddColuna('CLIENTE'         ,  FieldByName('CTR_NOMCLI').AsString                              , 29 , alEsquerda );
          objLinha.pAddColuna('DT.VENC.'        ,  FormatDateTime('dd/mm/yy',FieldByName('CTR_DTAVEN').AsDateTime) , 9  , alCentro   );
          objLinha.pAddColuna('DT.CAD.'         ,  FormatDateTime('dd/mm/yy',FieldByName('CTR_DTACAD').AsDateTime) , 9  , alCentro   );
          objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(FieldByName('CTR_DUPORI').AsFloat, ffNumber, 9, 2)  , 13 , alDireita  );
          objLinha.pAddColuna('VR.C/JUR.SUJ'    ,  FloatToStrF(FieldByName('CTR_VALSUJ').AsFloat, ffNumber, 9, 2)  , 13 , alDireita  );
          objLinha.pAddColuna('VL.RECALC.(*)'   ,  FloatToStrF(FieldByName('CTR_VALCOR').AsFloat, ffNumber, 9, 2)  , 14 , alDireita  );
          objTabela.lstLinhas.Add(objLinha);

          sumValDup := sumValDup + FieldByName('CTR_DUPORI').AsFloat;
          sumValSuj := sumValSuj + FieldByName('CTR_VALSUJ').AsFloat;
          sumValCor := sumValCor + FieldByName('CTR_VALCOR').AsFloat;

          Next;
        End;

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlTotal;
        objLinha.pAddColuna(''                , 'TOTAIS'                                , 76 , alDireita, teAutcom );
        objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(sumValDup, ffNumber, 9, 2) , 13 , alDireita  );
        objLinha.pAddColuna('VR.C/JUR.SUJ'    ,  FloatToStrF(sumValSuj, ffNumber, 9, 2) , 13 , alDireita  );
        objLinha.pAddColuna('VL.RECALC.(*)'   ,  FloatToStrF(sumValCor, ffNumber, 9, 2) , 14 , alDireita  );
        objTabela.lstLinhas.Add(objLinha);

        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);


        objLiberacao.objMsgLibera.pAddTextoCaption('(*)Taxa de Juros aplicada', FloatToStrF(fltPerJur, ffNumber, 3, 2) + '%', 25 , alDireita, teAmbos, '', 6);
        objLiberacao.objMsgLibera.pAddTextoCaption('(*)Taxa de Multa aplicada', FloatToStrF(fltPerMul, ffNumber, 3, 2) + '%', 25 , alDireita, teAmbos, '', 6);
        objLiberacao.objMsgLibera.pAddTextoCaption('Data Final'               , strDtaFin                                   , 25);
        objLiberacao.objMsgLibera.pAddSeparador(125);
      End;

      {*****************************************************}
      {*  LIBERAÇÃO ATRAVÉS DE SENHA E GRAVAÇÃO DO LOGVAR  *}
      {**************************************************MA*}
      blnNivel2 := (fltPerJur < fCfgSis('JURMN1', varDouble)) And (fltPerJur >= fCfgSis('JURMN2', varDouble));
      strSenJM2 := fCfgSis('SENJM2');

      blnNivel3 := fltPerJur < fCfgSis('JURMN2', varDouble);
      strSenJM3 := fCfgSis('SENJM3');

      If (fCfgSis('SENJM1') <> '') And (fltPerJur < fCfgSis('JURMN1', varDouble)) Then
      begin
        objLiberacao.strDirAce := 'SENJM1';
        objLiberacao.strSenLib := fCfgSis('SENJM1');
        objLiberacao.strMsgSen := 'Recalcular Juros';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strDirAceNv2 := 'SENJM2';
        objLiberacao.strSenLibNv2 := strSenJM2;
        objLiberacao.blnNivel2 := blnNivel2;
        objLiberacao.strDirAceNv3 := 'SENJM3';
        objLiberacao.strSenLibNv3 := strSenJM3;
        objLiberacao.blnNivel3 := blnNivel3;
        objLiberacao.objMsgLibera.strTitulo := 'O valor de juros é menor que o permitido.';

        blnConfirma := objLiberacao.fLibera;

      end
      Else If (fCfgSis('SENJM1') = '') Or
              ((fCfgSis('JURMN1', varDouble) <= 0) Or
               (fCfgSis('JURMN1', varString) = '')) Then
      begin
        objLiberacao.strDirAce := 'SENJUR';
        objLiberacao.strSenLib := fCfgSis('SENJUR');
        objLiberacao.strMsgSen := 'Recalcular Juros';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.objMsgLibera.strTitulo := 'Permitir recálculo de juros no recebimento.';

        blnConfirma := objLiberacao.fLibera;
      end;
      If (Not blnConfirma) Then
        pCalculaJuros(fltJurAnt);

      pAtualizaTemporaria(False);

    except
      On E: Exception Do
        pMensagensErro(E.message, '');
    end;
    pEnableControls(cdsDadosTemp, prcScroll);

  End;

  If (blnConfirma) Then
  Begin
    pDisableControls(cdsDadosTemp, prcScroll);
    pCalculaJurosFuturo(fltPerJur, strDtaFin, fltPerMul);
    pAtualizaTemporaria(False);
    pEnableControls(cdsDadosTemp, prcScroll);
  End;

  Screen.Cursor := crDefault;

end;


procedure TfrmRcxSelDocumentos.pLiberaDupsMarcadas;
Var
  prcScroll: TPrcScroll;
begin
  With cdsDadosTemp Do
  Begin
    Filtered := False;
    Filter := 'CTR_MARDES = ''M''';
    Filtered := True;

    If Not IsEmpty Then
    Begin
      First;
      pDisableControls(cdsDadosTemp, prcScroll);
      While Not Eof Do
      Begin
        objLock.fLock_Unlock(FieldByName('CTR_NOMARQ').AsString +
                             FieldByName('CTR_NUMDUP').AsString +
                             FieldByName('CTR_ESPDOC').AsString +
                             FieldByName('CTR_CODEMP').AsString +
                             FieldByName('CTR_CODCLI').AsString +
                             FieldByName('CTR_PARCEL').AsString, False);
        Next;
      End;
      pEnableControls(cdsDadosTemp, prcScroll);
    End;
  End;

  stlAutIncDupMar.Clear;
end;

//MF: 285995 - 31/05/2023
procedure TfrmRcxSelDocumentos.pMontaMensagemLib(strDuplicata : String; fltValOri: Double; strCodCli, sMsgTitulo : String;
                                            objTabela: TRegistroMsgLiberaTabela; cdsTmp: TUniClientDataSet);
var
  objLinha: TLinhaMsgLibera;
Begin
  if objLiberacao.objMsgLibera.isEmpty then
  begin
    objLiberacao.objMsgLibera.pAddTexto(sMsgTitulo);
    objLiberacao.objMsgLibera.pAddTextoCaption('Duplicata'               , strDuplicata                                                                                 , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor original'          , FormatFloat('#,##0.00', fltValOri)                                                           , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'                 , strCodCli + ' - ' + fRetNomCliente(strCodCli)                                                , 25);
    objLiberacao.objMsgLibera.pAddTextoCaption('CPF/CNPJ'                , fFormataCpfCgc(fCampoTabela('CLI_C_G_C_', 'CADCLI', ['CLI_CODCLI'], [strCodCli]), fSetaPais) , 25);
  end
  else
  begin
    (objLiberacao.objMsgLibera.lstRegistros[1] as TRegistroMsgLiberaTextoCaption).strTexto := 'MAIS DE UMA DUPLICATA'                 ;
    (objLiberacao.objMsgLibera.lstRegistros[2] as TRegistroMsgLiberaTextoCaption).strTexto := FormatFloat('#,##0.00', fltValOri);      ;

    if Copy((objLiberacao.objMsgLibera.lstRegistros[3] as TRegistroMsgLiberaTextoCaption).strTexto,1,8) <> strCodCli then
    begin
      (objLiberacao.objMsgLibera.lstRegistros[3] as TRegistroMsgLiberaTextoCaption).strTexto   := 'MAIS DE UM CLIENTE';
      (objLiberacao.objMsgLibera.lstRegistros[4] as TRegistroMsgLiberaTextoCaption).strCaption := '';
      (objLiberacao.objMsgLibera.lstRegistros[4] as TRegistroMsgLiberaTextoCaption).strTexto   := '';
    end;
  end;

  if objTabela.isEmpty Then
  Begin

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'DOCUMENTO'       , 17 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'EMP'             , 4  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'CLIENTE'         , 42 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'DT.VENC.'        , 8  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'DT.CAD.'         , 8  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'VR.DUPLICATA'    , 13 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'VR.CORRIGIDO(*)' , 16 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'NOSSO NUMERO'    , 12 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'BCO'             , 3  , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);
  End;


  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlValor;
  objLinha.pAddColuna('DOCUMENTO'       ,  fPadR(cdsTmp.FieldByName('CTR_NUMDUP').AsString,12)
                                         + cdsTmp.FieldByName('CTR_PARCEL').AsString + '-'
                                         + cdsTmp.FieldByName('CTR_ESPDOC').AsString                              , 17 , alEsquerda );
  objLinha.pAddColuna('EMP'             ,  cdsTmp.FieldByName('CTR_CODEMP').AsString                              , 4  , alCentro   );
  objLinha.pAddColuna('CLIENTE'         ,  cdsTmp.FieldByName('CTR_NOMCLI').AsString                              , 42 , alEsquerda );
  objLinha.pAddColuna('DT.VENC.'        ,  FormatDateTime('dd/mm/yy',cdsTmp.FieldByName('CTR_DTAVEN').AsDateTime) , 8  , alCentro   );
  objLinha.pAddColuna('DT.CAD.'         ,  FormatDateTime('dd/mm/yy',cdsTmp.FieldByName('CTR_DTACAD').AsDateTime) , 8  , alCentro   );
  objLinha.pAddColuna('VR.DUPLICATA'    ,  FloatToStrF(cdsTmp.FieldByName('CTR_VALDUP').AsFloat, ffNumber, 9, 2)  , 13 , alDireita  );
  objLinha.pAddColuna('VR.CORRIGIDO(*)' ,  FloatToStrF(cdsTmp.FieldByName('CTR_VALCOR').AsFloat, ffNumber, 9, 2)  , 16 , alDireita  );
  objLinha.pAddColuna('NOSSO NUMERO'    ,  cdsTmp.FieldByName('CTR_NOSNUM').AsString                              , 12 , alDireita  );
  objLinha.pAddColuna('BCO'             ,  cdsTmp.FieldByName('CTR_BCOBOL').AsString                              , 3  , alDireita  );
  objTabela.lstLinhas.Add(objLinha);

End;

//MF: 285995 - 31/05/2023 - INI
function TfrmRcxSelDocumentos.fVerificaDescontoFaturaVencida: Boolean;
Var
  cdsTmp   : TUniClientDataSet;
  objTabela : TRegistroMsgLiberaTabela;
  strCliCod: String;
begin
  cdsTmp := TUniClientDataSet.Create(Self);
  Try
    Result := True;

    if (fTemDupVencida) Then
    Begin
      If (Not fVerificaAcessoSistema('DDUPVE', strCodOpe)) Then
      Begin
        cdsTmp.Data := cdsDadosTemp.Data;

        cdsTmp.First;
        cdsTmp.Filter := 'CTR_MARDES = ' + QuotedStr('M');
        cdsTmp.Filtered := True;

        objLiberacao.Clear;

        objTabela := TRegistroMsgLiberaTabela.Create;

        objLiberacao.pInformaNumDocEspDocCodEmp(cdsTmp.FieldByName('CTR_NUMDUP').AsString +
                                                cdsTmp.FieldByName('CTR_PARCEL').AsString,
                                                cdsTmp.FieldByName('CTR_ESPDOC').AsString,
                                                cdsTmp.FieldByName('CTR_CODEMP').AsString);

        While not cdsTmp.Eof Do
        Begin
          pMontaMensagemLib(cdsTmp.FieldByName('CTR_NUMDUP').AsString +
                         cdsTmp.FieldByName('CTR_PARCEL').AsString + '-' +
                         cdsTmp.FieldByName('CTR_ESPDOC').AsString + '-' +
                         cdsTmp.FieldByName('CTR_CODEMP').AsString,
                         fStrToFloat(edtTotSel.Text),
                         cdsTmp.FieldByName('CTR_CODCLI').AsString,
                         'Autorização para desconto em duplicata vencida',
                         objTabela,
                         cdsTmp);

          cdsTmp.Next;
        End;

        objLiberacao.objMsgLibera.pAddQuebra;
        objLiberacao.objMsgLibera.pAddSeparador(142);
        objLiberacao.objMsgLibera.pAddTexto('RESUMO DOS TÍTULOS SELECIONADOS', alCentro, teAmbos, '',142);
        objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

        Result := False;

        strCliCod := IIF(cdsTmp.RecordCount = 1, cdsTmp.FieldByName('CTR_CODCLI').AsString, '');
        While (True) Do
        Begin
          objLiberacao.strDirAce              := 'DDUPVE';
          objLiberacao.strMsgSen              := 'Usuário sem autorização para desconto em duplicata vencida';
          objLiberacao.blnMosMen              := True;
          objLiberacao.strCodOpe              := strCodOpe;
          objLiberacao.strCodDig              := strCodOpe;
          objLiberacao.objMsgLibera.strTitulo := 'Autorização para desconto em duplicata vencida';
          objLiberacao.strCliente             := strCliCod;

          If (objLiberacao.fLibera) Then
          Begin
            Result := True;
            Break;
          End;

          If (fMensagem('', 'Senha Incorreta!', ['&Novamente', '&Desistir']) = 2) Then
            Break;
        End;
        pRemoveLiberacao('DDUPVE','');
      End;

    End;
  Finally
    FreeAndNil(cdsTmp);
  End;

end;

procedure TfrmRcxSelDocumentos.btnDescontoGeralClick(Sender: TObject);
  Var
    LConfirma: Boolean;

    frmBaixaDescGeral: TfrmBaixaDescGeral;
begin
  inherited;

  If dbgDocumentosDBTableView1.DataController.DataSource.DataSet.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'Nenhuma duplicata carregada!', ['&Ok']);
    Exit;
  End;

  If Not ValidaDuplicatasParaReceberDescontoGeral Then
    Exit;

  If fApenasBoletoAdiantamento Then
  Begin
    fMensagem('ATENÇÃO!','Não é permitido dar desconto para duplicatas de espécie PD cujos boletos foram emitidos!', ['&Ok']);
    Exit;
  End;

  //MF: 285995 - 31/05/2023 - INI
  If (Not fVerificaDescontoFaturaVencida) Then
  Begin
    fMensagem('ATENÇÃO!','Não é permitido dar desconto para duplicatas vencidas!', ['&Ok']);
    Exit;
  End;
  //MF: 285995 - 31/05/2023 - FIM

  Application.ProcessMessages;
  Try
    pCriarFormularios(TfrmBaixaDescGeral, frmBaixaDescGeral);

    frmBaixaDescGeral.cdsDuplicatas := (dbgDocumentosDBTableView1.DataController.DataSource.DataSet As TUniClientDataset);
    frmBaixaDescGeral.ResumoDeCaixa := True;
    frmBaixaDescGeral.blnCtaPagar   := False;
    frmBaixaDescGeral.ShowModal;

    LConfirma := frmBaixaDescGeral.blnConfirma;

    dicBaixa.AddOrSetValue('DescontoTotal'   , FloatToStr(frmBaixaDescGeral.fltValDes));

    If (frmBaixaDescGeral.rgpDescSobre.ItemIndex <= 0) Then
      dicBaixa.AddOrSetValue('ValorBaixaTotal' , FloatToStr(frmBaixaDescGeral.fltValTotGer))
    Else
      dicBaixa.AddOrSetValue('ValorBaixaTotal' , FloatToStr(frmBaixaDescGeral.fltValBaiTot));

    dicBaixa.AddOrSetValue('MotivoDoDesconto', frmBaixaDescGeral.MotivoDoDesconto);
    dicBaixa.AddOrSetValue('Confirmado' , LConfirma);
    dicBaixa.AddOrSetValue('DescontoSobre', frmBaixaDescGeral.rgpDescSobre.Items[frmBaixaDescGeral.rgpDescSobre.ItemIndex]);
  Finally
    pFreeAndNil(frmBaixaDescGeral);
  End;

  If LConfirma Then
    TfrmGravando.fExecutarModal(AplicaDescontoGeral,'Aguarde... Aplicando desconto.','');

  pSetFocus(dbgDocumentos);
end;

{*******************************************}
{*EXIBE A TELA DE DUPLICATAS AGRUPADAS     *}
{****************************************RL*}
procedure TfrmRcxSelDocumentos.btnDupAgrupadasClick(Sender: TObject);
begin
  inherited;

  If (dbgDocumentosDBTableView1.DataController.DataSource.DataSet.FieldByName('CTR_ESPDOC').AsString = 'AG') Then
  Begin
    pMostraDuplicatasAgrupadas(LeftStr(dbgDocumentosDBTableView1.DataController.DataSource.DataSet.FieldByName('CTR_DUPPAR').AsString, fTamDocCadRec()),
                               LeftStr(dbgDocumentosDBTableView1.DataController.DataSource.DataSet.FieldByName('CTR_CODEMP').AsString, 3),
                               dbgDocumentosDBTableView1.DataController.DataSource.DataSet.FieldByName('CTR_CODCLI').AsString,
                               TRUE{veio pelo Resumo de Caixa});
  End;

end;

procedure TfrmRcxSelDocumentos.btnProdutosClick(Sender: TObject);
begin
  inherited;
  If not cdsDadosTemp.IsEmpty Then
  Begin
    If blnF11 Then
      Exit;

    Try
      pCriarFormularios(TfrmRelFatVendasClienteF9, frmRelFatVendasClienteF9);
      frmRelFatVendasClienteF9.dtsRelVenCli.DataSet := frmModuloSPR.qryRelatorio;
      frmRelFatVendasClienteF9.blnMosVenMtl := fCfgSis('VENMTL', varBoolean);

      With frmRelFatVendasClienteF9 do
      begin
        pMostrarProdutos
          (LeftStr(dbgDocumentosDBTableView1.DataController.DataSource.DataSet.FieldByName('CTR_DUPPAR').AsString, fTamDocCadRec()),
           dbgDocumentosDBTableView1.DataController.DataSource.DataSet.FieldByName('CTR_ESPDOC').AsString,
           LeftStr(dbgDocumentosDBTableView1.DataController.DataSource.DataSet.FieldByName('CTR_CODEMP').AsString, 3),
           False,
           dbgDocumentosDBTableView1.DataController.DataSource.DataSet.FieldByName('CTR_CODCLI').AsString,
           True);

        ShowModal;
      end;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[btnProdutosClick]');
      End;
    End;

    pFreeAndNil(frmRelFatVendasClienteF9);
  End;
end;

function TfrmRcxSelDocumentos.fCupomImpresso(blnMensagem: Boolean; var blnExiste: Boolean): Boolean;
  Var
    qryAux: TUniQuery;
begin

  blnExiste := False;
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT GER_IMPRES           ');
  qryAux.SQL.Add('  FROM MOVGER               ');
  qryAux.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC ');
  qryAux.SQL.Add('   AND GER_ESPDOC = :ESPDOC ');
  qryAux.SQL.Add('   AND GER_CODEMP = :CODEMP ');
  qryAux.SQL.Add('   AND GER_CODCLI = :CODCLI ');

  qryAux.SQL.Add('UNION ALL                   ');

  qryAux.SQL.Add('SELECT GER_IMPRES           ');
  qryAux.SQL.Add('  FROM NOTGER               ');
  qryAux.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC ');
  qryAux.SQL.Add('   AND GER_ESPDOC = :ESPDOC ');
  qryAux.SQL.Add('   AND GER_CODEMP = :CODEMP ');
  qryAux.SQL.Add('   AND GER_CODCLI = :CODCLI ');

  qryAux.ParamByName('NUMDOC').AsString := fField('CTR_NUMDUP').AsString;
  qryAux.ParamByName('ESPDOC').AsString := fField('CTR_ESPDOC').AsString;
  qryAux.ParamByName('CODEMP').AsString := fField('CTR_CODEMP').AsString;
  qryAux.ParamByName('CODCLI').AsString := fField('CTR_CODCLI').AsString;

  qryAux.Open;

  If qryAux.IsEmpty Then
  Begin
    If (blnMensagem) And
       (fMensagem('ATENÇÃO!', 'Não foi encontrada a informação da impressão do cupom.' + #13#10 +
                              'Deseja continuar?', ['&Sim', '&Não']) = 1) Then
    Begin
      Result := True;
    End
    Else
    Begin
      Result := False;
    End;
  End
  Else
  Begin
    blnExiste := True;
    Result := (qryAux.FieldByName('GER_IMPRES').AsInteger = 1);
  End;

  qryAux.Close;

  FreeAndNil(qryAux);

end;

procedure TfrmRcxSelDocumentos.btnSelecTodosClick(Sender: TObject);
var frmGravando_: TfrmGravando;
    blnGravaLog: Boolean;
begin
  If not cdsDadosTemp.IsEmpty Then
  Begin
    blnGravaLog := VS_blnGravaLogTransacao;
    try
      VS_blnGravaLogTransacao := false;
      blnSelTodas := True;
      pCriarFormularios(TfrmGravando,frmGravando_);
      frmGravando_.fExecutarAcao := fMarcaDuplics;
      frmGravando_.lblGravando.Caption := 'Aguarde... Marcando Títulos.';
      frmGravando_.ShowModal;
      pFreeAndNil(frmGravando_);
      blnSelTodas := False;
    finally
      VS_blnGravaLogTransacao := blnGravaLog;
    end;
  End;
end;

function TfrmRcxSelDocumentos.fMarcaDuplics(pgbProgresso: TcxProgressBar): Boolean;
  Var
    intOpcao    : Integer;
    fltValInf,
    fltDesSuj,
    fltJuros    : Double;
    blnLiberado : Boolean;
    prcScroll   : TprcScroll;
    blnNaoMar   : Boolean;

    LDuplicatasComPixGerado: Boolean;
    LValorDesconto,
    LValorDespesas,
    LFatorDescontoDuplicata,
    LFatorDespesasDuplicata,
    LValorJuros,
    LDiferenca: Double;

    LValorExcedente: Double;
    LRatearExcedente: Boolean;
    LBaseValorExcedente: Double;
begin
  inherited;
  Result := True;

  If blnBuscaContratos Or blnF11 Then
    intOpcao := 1
  Else
    intOpcao := fGetMenu('Selecione a opção', ['Todas as duplicatas', 'Informar o valor selecionado', 'Cancelar'], 1);

  If Not (intOpcao In [1,2]) Then Exit;

  fltValInf := 0.00;
  fltDesSuj := 0;

  LDuplicatasComPixGerado := False;

  If intOpcao = 2 Then
  begin
    Try
      pCriarFormularios(TfrmDigValor, frmDigValor);
      frmDigValor.ShowModal;
      If frmDigValor.ModalResult = mrOk Then
      begin
        fltValInf := fStrToFloat(frmDigValor.edtValor.Text);
      end
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[]');
      End;
    End;
    pFreeAndNil(frmDigValor);

    If fltValInf <= 0 Then Exit;
  end;


  LBaseValorExcedente := 0;

  try
    pDisableControls(cdsDadosTemp, prcScroll);

    cdsDadosTemp.First;
    while not cdsDadosTemp.Eof do
    begin
      if (Trim(cdsDadosTemp.FieldByName('CTR_TX_PIX').AsString).IsEmpty) then
        LBaseValorExcedente := LBaseValorExcedente + cdsDadosTemp.FieldByName('CTR_VALCOR').AsFloat;
      cdsDadosTemp.Next;
    end;
  finally
    pEnableControls(cdsDadosTemp, prcScroll);
  end;

  LValorExcedente := 0;

  if LBaseValorExcedente > 0 then
    LValorExcedente := fltValInf - LBaseValorExcedente;

  LRatearExcedente := False;

  if LValorExcedente > 0 then
  begin
    If (fMensagem('', 'O valor total das duplicatas selecionadas é de R$ '+
                        FormatFloat('#,##0.00',LBaseValorExcedente) +#13+#13+
                      'Foi informado um valor superior de R$ '+ FormatFloat('#,##0.00',fltValInf) +#13+#13+
                      'Deseja aplicar a diferença como juros?', ['&Sim', '&Não']) = 1) Then
      LRatearExcedente := True
    else
      Exit;
  end;

  blnLiberado := False;
  blnNaoMar := False;
  If InterlockedIncrement(intLockConfirmar) = 0 Then
  Begin
    Try
      With cdsDadosTemp Do
      Begin
        pDisableControls(cdsDadosTemp, prcScroll);
        blnSelTodas := True;

        pgbProgresso.Position := 0;
        pgbProgresso.Properties.Max := RecordCount;

        //Primeiro desmarca todas as duplicatas (para desmarcar os creditos selecionados)
        If fCfgSis('SBCCMC', VarBoolean) Then
        Begin
          First;
          While (Not Eof) Do
          Begin
            pgbProgresso.Position := pgbProgresso.Position + 1;
            Application.ProcessMessages;

            If fField('CTR_MARDES').AsString = 'M' Then
              pMarcarDuplicata(False, True);
            Next;
          End;
        End;

        if LRatearExcedente then
          pRatearExcedenteComoJuros(LValorExcedente, LBaseValorExcedente);

        pgbProgresso.Position := 0;
        pgbProgresso.Properties.Max := RecordCount;

        First;
        While (Not Eof) Do
        Begin
          pgbProgresso.Position := pgbProgresso.Position + 1;
          Application.ProcessMessages;

          If fCfgSis('SBCCMC', VarBoolean) And (fField('CTR_VALDUP').AsFloat < 0) Then
          Begin
            Next;
            Continue;
          End;

          If Not fField('CTR_TX_PIX').AsString.IsEmpty Then
          Begin
            LDuplicatasComPixGerado := True;

            Next;
            Continue;
          End;

          If (intOpcao = 1) Or ((intOpcao = 2) And (fltValInf > 0)) Then
          Begin
            pMarcarDuplicata(False, True);

            If (Not fEmptyStr(FieldByName('CTR_DOCDIV').AsString)) Then
              fltCreSel := fltCreSel - FieldByName('CTR_VALDUP').AsFloat;

            pSelecionaDuplicata(False);

            If (FieldByName('CTR_MARDES').AsString = 'M') Then
            Begin
              Edit;

              If (intOpcao = 2) And (fltValInf < FieldByName('CTR_VALCOR').AsFloat) And (FieldByName('CTR_VALCOR').AsFloat > 0) Then
              begin
                fltJuros := FieldByName('CTR_VALCOR').AsFloat - FieldByName('CTR_VALDUP').AsFloat;
                FieldByName('CTR_VALREC').AsFloat := fFormataFloat(fltValInf, 2);

                If (fltJuros > 0) Then
                Begin
                  if fCfgSis('JURPAR') = 'N' Then
                  begin
                    if not fLiberaBaixaParcialComJuros then
                    begin
                      pMarcarDuplicata(False, True);
                      fltValInf := 0;

                      Continue;
                    end;
                  end
                end;

                if not blnLiberado then
                Begin

                 If (FieldByName('FGO_BOLADT').AsFloat > 0.00) Then
                  Begin
                    fMensagem('ATENÇÃO!','Não é possível realizar baixa parcial de duplicatas de espécie PD cujos boletos foram emitidos!', ['&Ok']);
                    pMarcarDuplicata(False, True);
                    Break;
                  End;

                  If fHabilitaBaixaParcial(strCodOpe) And fValidaBaixaParcial(strCodOpe, strLoginUsuarioLogado) Then
                    blnLiberado := True
                  Else
                  Begin
                    pMarcarDuplicata(False, True);
                    Break;
                  End;
                End;

                If blnLiberado Then
                Begin
                  FieldByName('CTR_VALREC').AsFloat := fltValInf;
                  FieldByName('CTR_VALRES').AsFloat := FieldByName('CTR_VALCOR').AsFloat - fltValInf;
                  FieldByName('CTR_BAIPAR').AsString:= 'S';

                  LValorDesconto := FieldByName('CTR_DESSUJ').AsFloat;
                  LValorDespesas := FieldByName('CTR_DESCOB').AsFloat;
                  LValorJuros := (FieldByName('CTR_VALCOR').AsFloat - FieldByName('CTR_DUPORI').AsFloat) + LValorDesconto - LValorDespesas;

                  If LValorJuros < 0 Then
                    LValorJuros := 0;

                  FieldByName('FATORBAIXADUPLICATA').AsFloat := FieldByName('CTR_DUPORI').AsFloat /
                                                                FieldByName('CTR_VALCOR').AsFloat;

                  FieldByName('FATORJUROSDUPLICATA').AsFloat := LValorJuros /
                                                                FieldByName('CTR_VALCOR').AsFloat;

                  LFatorDescontoDuplicata := LValorDesconto / FieldByName('CTR_VALCOR').AsFloat;
                  LFatorDespesasDuplicata := LValorDespesas / FieldByName('CTR_VALCOR').AsFloat;

                  FieldByName('JUROSNOVADUPLICATA').AsFloat := LValorJuros;
                  LValorJuros := fFormataFloat(fltValInf * FieldByName('FATORJUROSDUPLICATA').AsFloat, 2);
                  FieldByName('JUROSNOVADUPLICATA').AsFloat := FieldByName('JUROSNOVADUPLICATA').AsFloat - LValorJuros;

                  FieldByName('DESCONTONOVADUPLICATA').AsFloat := LValorDesconto;
                  LValorDesconto := fFormataFloat(fltValInf * LFatorDescontoDuplicata,2);
                  FieldByName('DESCONTONOVADUPLICATA').AsFloat := fFormataFloat(FieldByName('DESCONTONOVADUPLICATA').AsFloat -
                                                                                LValorDesconto,2);

                  FieldByName('DESPESASNOVADUPLICATA').AsFloat := LValorDespesas;
                  LValorDespesas := fFormataFloat(fltValInf * LFatorDespesasDuplicata,2);
                  FieldByName('DESPESASNOVADUPLICATA').AsFloat := fFormataFloat(FieldByName('DESPESASNOVADUPLICATA').AsFloat -
                                                                                LValorDespesas,2);

                  FieldByName('VALORBAIXADUPLICATA').AsFloat := fFormataFloat(fltValInf *
                                                                              FieldByName('FATORBAIXADUPLICATA').AsFloat, 2);

                  LDiferenca := fFormataFloat(fltValInf -
                                              (FieldByName('VALORBAIXADUPLICATA').AsFloat +
                                               LValorJuros +
                                               LValorDespesas -
                                               LValorDesconto),2);

                  FieldByName('VALORBAIXADUPLICATA').AsFloat := FieldByName('VALORBAIXADUPLICATA').AsFloat + (LDiferenca);

                  FieldByName('VALORNOVADUPLICATA').AsFloat := fFormataFloat(FieldByName('CTR_DUPORI').AsFloat -
                                                                             FieldByName('VALORBAIXADUPLICATA').AsFloat, 2);

                  FieldByName('CTR_VALJUR').AsFloat := LValorJuros;
                  FieldByName('CTR_VALDES').AsFloat := LValorDesconto;
                  FieldByName('DESPESASBAIXADUPLICATA').AsFloat := LValorDespesas;
                End
                Else
                Begin
                  pMarcarDuplicata(False, True);
                  Continue;
                End;
                fltValInf := 0;
              End
              Else
              Begin

                If (FieldByName('CTR_VALCOR').AsFloat >= FieldByName('CTR_DUPORI').AsFloat) Then
                Begin
                  If (FieldByName('CTR_JURSUJ').AsFloat <> 0) Or
                     (FieldByName('CTR_DESSUJ').AsFloat <> 0) Then
                  Begin
                    If (FieldByName('CTR_VALCOR').AsFloat = (FieldByName('CTR_DUPORI').AsFloat + FieldByName('CTR_JURSUJ').AsFloat - FieldByName('CTR_DESSUJ').AsFloat)) Then
                    Begin
                      FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_JURSUJ').AsFloat;
                      fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
                    End
                    Else If (FieldByName('CTR_VALCOR').AsFloat < (FieldByName('CTR_DUPORI').AsFloat + FieldByName('CTR_JURSUJ').AsFloat - FieldByName('CTR_DESSUJ').AsFloat)) Then
                    Begin
                      FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_JURSUJ').AsFloat -
                                  ((FieldByName('CTR_DUPORI').AsFloat + FieldByName('CTR_JURSUJ').AsFloat - FieldByName('CTR_DESSUJ').AsFloat) -
                                   (FieldByName('CTR_VALCOR').AsFloat));
                      fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
                    End
                    Else If (FieldByName('CTR_VALCOR').AsFloat > (FieldByName('CTR_DUPORI').AsFloat + FieldByName('CTR_JURSUJ').AsFloat - FieldByName('CTR_DESSUJ').AsFloat)) Then
                    Begin

                      If blnDescFinanSomenteAteVenc Then
                      Begin
                        If (VS_Date <= FieldByName('CTR_DTAVEN').AsDateTime) Then
                          fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat
                        Else
                          fltDesSuj := 0;
                      End
                      Else
                        fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;

                      FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_JURSUJ').AsFloat +
                                                          (FieldByName('CTR_VALCOR').AsFloat -
                                                          (FieldByName('CTR_DUPORI').AsFloat + FieldByName('CTR_JURSUJ').AsFloat + FieldByName('CTR_DESCOB').AsFloat - fltDesSuj));
                    End;
                  End
                  Else
                  Begin
                    FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_VALCOR').AsFloat - FieldByName('CTR_DUPORI').AsFloat - FieldByName('CTR_DESCOB').AsFloat;

                    If blnDescFinanSomenteAteVenc Then
                    Begin
                      If (VS_Date <= FieldByName('CTR_DTAVEN').AsDateTime) Then
                        fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat
                      Else
                        fltDesSuj := 0;
                    End
                    Else
                      fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;
                  End;
                End
                Else
                Begin

                  If blnDescFinanSomenteAteVenc Then
                  Begin
                    If (VS_Date <= FieldByName('CTR_DTAVEN').AsDateTime) Then
                      fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat
                    Else
                      fltDesSuj := 0;
                  End
                  Else
                    fltDesSuj := FieldByName('CTR_DESSUJ').AsFloat;

                  FieldByName('CTR_VALJUR').AsFloat := FieldByName('CTR_VALCOR').AsFloat - FieldByName('CTR_DUPORI').AsFloat + fltDesSuj;

                  If (fCfgSis('DESPON', varBoolean)) And (FieldByName('CTR_PERDPO').AsFloat > 0) And
                     (VS_Date <= (FieldByName('CTR_DTAVEN').AsDateTime - FieldByName('CTR_QTDDAV').AsInteger)) Then
                  Begin
                    If fFormataFloat(FieldByName('CTR_VALCOR').AsFloat,2) = fFormataFloat(fValorCalculado(FieldByName('CTR_VALDUP').AsFloat,0,FieldByName('CTR_PERDPO').AsFloat),2) Then
                    Begin
                      fltDesSuj := FieldByName('CTR_VALDUP').AsFloat - FieldByName('CTR_VALCOR').AsFloat;
                      FieldByName('CTR_VALJUR').AsFloat := 0.00;
                    End;
                  End;

                End;

                FieldByName('CTR_VALDES').AsFloat := fltDesSuj;
                FieldByName('CTR_VALREC').AsFloat := fFormataFloat(FieldByName('CTR_VALCOR').AsFloat, 2);
                FieldByName('CTR_VALRES').AsFloat := 0;
                FieldByName('CTR_BAIPAR').AsString:= 'N';

                If intOpcao = 2 Then
                  fltValInf := fFormataFloat(fltValInf - FieldByName('CTR_VALCOR').AsFloat, 2);

              End;

              Post;
            End
            Else
              blnNaoMar := True;
          End
          Else
            pMarcarDuplicata(False, True);

          Next;
        End;

        First;
        pEnableControls(cdsDadosTemp, prcScroll);
      End;

      If (Not fValidaLiberacaoCreditoProfissional) Then
      Begin
        pDesmarcaDuplicatasCreditoProfissional;
      End;

      If blnNaoMar Then
        pMensagemOK('Algumas duplicatas não foram marcadas por alguma inconsistência, ' +
                    'verifique o motivo selecionando individualmente as duplicatas desmarcadas!');

      If LDuplicatasComPixGerado Then
        fMensagem('ATENÇÃO', 'Algumas duplicatas não foram marcadas pois possui Pix ativo gerado.', ['&Ok']);

      pAtualizaTemporaria(False);

      pCalculaTotais;
      pCalculaTotalGeral;

      stlSelecionadas.Clear;
      blnSelTodas := False;
      InterlockedDecrement(intLockConfirmar);
    Except
      On E: Exception Do
      Begin
        InterlockedDecrement(intLockConfirmar);
        pMensagensErro(E.Message, '[btnSelecTodosClick]');
      End;
    End;
  End
  Else
    InterlockedDecrement(intLockConfirmar);
end;

procedure TfrmRcxSelDocumentos.pTotalFiltro(strNumDoc, strParCel, strEspDoc: String);
begin
  pCalculaTotalGeral;
end;

function TfrmRcxSelDocumentos.fVerificarCadRecBaixado(strNumDoc, strEspDoc, strCliFor, strCodEmp, strParcel, strSeqBai: String; lstDoc: TStringList): Boolean;
  Var
    qryAux: TUniQuery;
begin
  Try
    Result := True;

    qryAux := fCriaQuery;
    qryAux.SQL.Add('SELECT ');
    qryAux.SQL.Add('  CTR_NUMDUP, ');
    qryAux.SQL.Add('  CTR_PARCEL, ');
    qryAux.SQL.Add('  CTR_ESPDOC, ');
    qryAux.SQL.Add('  CTR_CODEMP  ');
    qryAux.SQL.Add('FROM ');
    qryAux.SQL.Add('  CADREC ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  CTR_NUMDUP = :NUMDUP AND ');
    qryAux.SQL.Add('  CTR_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('  CTR_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('  CTR_CODCLI = :CODCLI AND ');
    qryAux.SQL.Add('  CTR_PARCEL = :PARCEL AND ');
    qryAux.SQL.Add('  CTR_SEQBAI = :SEQBAI AND ');
    qryAux.SQL.Add('  CTR_DTAREC IS NOT NULL   ');

    qryAux.ParamByName('NUMDUP').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCliFor;
    qryAux.ParamByName('PARCEL').AsString := strParcel;
    qryAux.ParamByName('SEQBAI').AsString := strSeqBai;
    qryAux.Open;

    While (Not qryAux.Eof) Do
    Begin
      lstDoc.Add(qryAux.FieldByName('CTR_NUMDUP').AsString +
                 qryAux.FieldByName('CTR_PARCEL').AsString + ' - ' +
                 qryAux.FieldByName('CTR_ESPDOC').AsString + ' Loja: ' +
                 qryAux.FieldByName('CTR_CODEMP').AsString);
      qryAux.Next;
    End;

    qryAux.Close;
    FreeAndNil(qryAux);

  Except
    Result := False;
    FreeAndNil(qryAux);
  End;

end;

procedure TfrmRcxSelDocumentos.mnuCalcJurosFuturoClick(Sender: TObject);
var
  blnEncMarcado: Boolean;
begin
  inherited;
  blnEncMarcado := False;

  If blnF11 Then
    Exit;

  if cdsDadosTemp.Locate('CTR_MARDES', 'M', []) THEN
    blnEncMarcado := True;

  If blnEncMarcado Then
  Begin
    fMensagem('', 'Para calcular juros futuro, nenhuma duplicata pode estar selecionada!', ['&Ok']);
    Exit;
  End;

  TfrmGravando.fExecutarModal(pJurosFuturo,'Aguarde... Recalculando Juros.','');

end;

procedure TfrmRcxSelDocumentos.pGeraResumo(lstCtrBaixadas: TStringList);
  Var
    blnGerarResumo: Boolean;
    intContador: Integer;
    frmCancelamentoDocResumo : TfrmCancelamentoDocResumo;
begin

  blnGerarResumo := (lstCtrBaixadas.Count > 0);

  If (blnGerarResumo) Then
  Begin

    Try
      pCriarFormularios(TfrmCancelamentoDocResumo, frmCancelamentoDocResumo);
      frmCancelamentoDocResumo.memResumo.Lines.Add('Duplicatas que já foram baixadas e portanto não será permitido baixar o documento!');
      frmCancelamentoDocResumo.memResumo.Lines.Add('');

      For intContador := 0 To lstCtrBaixadas.Count -1 Do
        frmCancelamentoDocResumo.memResumo.Lines.Add(lstCtrBaixadas[intContador]);

      frmCancelamentoDocResumo.Caption := 'Resumo da Baixa de Documentos';
      frmCancelamentoDocResumo.ShowModal;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmRcxSelDocumentos.pGeraResumo]');
      End;
    End;

    pFreeAndNil(frmCancelamentoDocResumo);

  End;
  
end;

function TfrmRcxSelDocumentos.fDocumentosBaixados: Boolean;
  Var
    cdsAux: TUniClientDataSet;
    lstDoc: TStringList;
Begin

  Try
    Result := False;
    cdsAux := TUniClientDataSet.Create(Self);
    cdsAux.Data := cdsDadosTemp.Data;
    lstDoc := TStringList.Create;

    cdsAux.Filter := ' CTR_MARDES = '+ QuotedStr('M');
    cdsAux.Filtered := True;

    While Not cdsAux.Eof Do
    Begin
      Application.ProcessMessages;

      fVerificarCadRecBaixado(cdsAux.FieldByName('CTR_NUMDUP').AsString,
                              cdsAux.FieldByName('CTR_ESPDOC').AsString,
                              cdsAux.FieldByName('CTR_CODCLI').AsString,
                              cdsAux.FieldByName('CTR_CODEMP').AsString,
                              cdsAux.FieldByName('CTR_PARCEL').AsString,
                              cdsAux.FieldByName('CTR_SEQBAI').AsString,
                              lstDoc);
      cdsAux.Next;
    End;

    If lstDoc.Count > 0 Then
    Begin
      Result := True;
      pGeraResumo(lstDoc);
    End;

  Finally
    FreeAndNil(lstDoc);
  End;

End;

function TfrmRcxSelDocumentos.fVerificaDupBaixada(strNumDup,
                                                  strParcel,
                                                  strEspDoc,
                                                  strCodEmp,
                                                  strCodCli: String;
                                                  intSeqBai: Integer): Boolean;
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin

  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CTR_DTAREC ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADREC ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString  := strNumDup;
      ParamByName('PARCEL').AsString  := strParcel;
      ParamByName('ESPDOC').AsString  := strEspDoc;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODCLI').AsString  := strCodCli;
      ParamByName('SEQBAI').AsInteger := intSeqBai;
      Open;

      If fEmptyStr(FieldByName('CTR_DTAREC').AsString) Then
        Result := False
      Else
        Result := True;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

End;

function TfrmRcxSelDocumentos.fApagarBoletoAdiantamento: Boolean;
  Var
    prcScroll: TprcScroll;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
begin
  Result := True;
  If Not fApenasBoletoAdiantamento Then
    Exit;

  Try
    pDisableControls(cdsDadosTemp, prcScroll);

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(105);
    objLiberacao.objMsgLibera.pAddTexto('***  BAIXA DUPLICATA/INCLUSAO DE ADIANTAMENTO (BAIXA MANUAL - BOLETO DE ADIANTAMENTO)  ***', alCentro, teAutcom, '', 105);
    objLiberacao.objMsgLibera.pAddSeparador(105);

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'DUPLICATA' , 13 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'EMP'       , 4  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'CLIENTE'   , 39 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'DT.CAD.'   , 11 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'DT.VENC.'  , 11 , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'VR.DUPLIC', 14 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);


    cdsDadosTemp.First;
    While Not cdsDadosTemp.Eof Do
    Begin
      If (fField('CTR_MARDES').AsString = 'M') Then
      Begin

        objLinha  := TLinhaMsgLibera.Create;
        objLinha.enuTipoLinha := tlValor;
        objLinha.pAddColuna('DUPLICATA' , fField('NRODUP').AsString + fField('PARDUP').AsString               , 13 , alEsquerda);
        objLinha.pAddColuna('EMP'       , fField('CTR_CODEMP').AsString                                       , 4  , alCentro  );
        objLinha.pAddColuna('CLIENTE'   , fField('CTR_CODCLI').AsString + '-' + fField('CTR_NOMCLI').AsString , 39 , alEsquerda);
        objLinha.pAddColuna('DT.CAD.'   , FormatDateTime('dd/MM/yyyy', fField('CTR_DTACAD').AsDateTime)       , 11 , alCentro  );
        objLinha.pAddColuna('DT.VENC.'  , FormatDateTime('dd/MM/yyyy', fField('CTR_DTAVEN').AsDateTime)       , 11 , alCentro  );
        objLinha.pAddColuna('VR.DUPLIC', FormatFloat('#,##0.00', fField('CTR_VALDUP').AsFloat)               , 14 , alDireita );
        objTabela.lstLinhas.Add(objLinha);

        Result := False;
      End;
      cdsDadosTemp.Next;
    End;
    cdsDadosTemp.First;

    If Result Then
      FreeAndNil(objTabela)
    else
    begin
      objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

      objLiberacao.strDirAce := 'RECMANUALBOLADT';
      objLiberacao.strMsgSen := 'Receber duplicatas de espécie PD cujos boletos foram emitidos, nas rotinas de baixa de contas a receber e resumo de caixa.';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;

      Result := objLiberacao.fLibera;
    end;
  Finally
    pEnableControls(cdsDadosTemp, prcScroll);
  End;
end;

function TfrmRcxSelDocumentos.fApenasBoletoAdiantamento: Boolean;
  Var
    cdsDupSel: TUniClientDataSet;
begin
  Result := True;

  If Not fCfgSis('RECADT', VarBoolean) Then
  Begin
    Result := False;
    Exit;
  End;

  cdsDupSel          := TUniClientDataSet.Create(nil);
  cdsDupSel.Data     := cdsDadosTemp.Data;
  cdsDupSel.Filter   := 'CTR_MARDES = ' + QuotedStr('M') + ' AND (FGO_BOLADT =  ' + QuotedStr('0,00') + ' OR FGO_BOLADT IS NULL)';
  cdsDupSel.Filtered := True;

  If (cdsDupSel.RecordCount >= 1) Then
    Result := False
  Else If Not fTemDuplicataMarcada And Not(cdsDadosTemp.FieldByName('FGO_BOLADT').AsFloat > 0.00) Then
    Result := False;

  FreeAndNil(cdsDupSel);
end;

function TfrmRcxSelDocumentos.fApenasCreditos: Boolean;
Var
  prcScroll: TPrcScroll;
begin
  Try
    Result := True;

    With cdsDadosTemp Do
    Begin

      pDisableControls(cdsDadosTemp, prcScroll);
      First;

      While (Not Eof) Do
      Begin

        If (FieldByName('CTR_MARDES').AsString = 'M') Then
        Begin

          If (FieldByName('CTR_VALREC').AsFloat > 0.0)Then
          Begin
            Result := False;
            Break;
          End;

        End;

        Next;
      End;

    End;

  Finally
    pEnableControls(cdsDadosTemp, prcScroll);
  End;

end;

function TfrmRcxSelDocumentos.fVerificaDupExiste(strNumDup, strParcel,
  strEspDoc, strCodEmp, strCodCli: String; intSeqBai: Integer): Boolean;
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CTR_DTAREC ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADREC ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDUP').AsString  := strNumDup;
    ParamByName('PARCEL').AsString  := strParcel;
    ParamByName('ESPDOC').AsString  := strEspDoc;
    ParamByName('CODEMP').AsString  := strCodEmp;
    ParamByName('CODCLI').AsString  := strCodCli;
    ParamByName('SEQBAI').AsInteger := intSeqBai;
    Open;

    Result := (Not IsEmpty);
  End;

  FreeAndNil(qryGen);
end;

function TfrmRcxSelDocumentos.fSqlDuplicatas(strRomaneio: String = ''): String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE DISTINCT ';
  Result := Result + '  CONCAT(CTR_NUMDUP, CTR_PARCEL) AS CTR_DUPPAR, ';
  Result := Result + '  CADREC.AUTOINCREM, ';
  Result := Result + '  CLI_FANSOB, ';
  Result := Result + '  CLI_C_G_C_, ';
  Result := Result + '  CTR_NUMDUP, ';
  Result := Result + '  CTR_ESPDOC, ';
  Result := Result + '  CTR_PARCEL, ';
  Result := Result + '  CTR_CODEMP, ';
  Result := Result + '  CTR_CODCLI, ';
  Result := Result + '  IFNULL(CLI_CODRED, "00000") AS CLI_CODRED, ';
  Result := Result + '  CTR_SEQBAI, ';
  Result := Result + '  CTR_SEQCON, ';
  Result := Result + '  CURRENT_TIMESTAMP AS HRAFIL, ';
  Result := Result + '  IFNULL((IF(CLI_NOMCLI LIKE "%CONSUMIDOR%" OR ';
  Result := Result + '            CLI_NOMCLI LIKE "%BALCAO%"     OR ';
  Result := Result + '            CLI_NOMCLI LIKE "%BALCÃO%",       ';
  Result := Result + '        IF(CTR_ESPDOC = "PD", ';
  Result := Result + '           CONCAT(FATGOR.FGO_CODCLI,"-",FATGOR.FGO_NOMCON), ';
  Result := Result + '           IF(IFNULL(MOVGER.GER_NOMCON, "") = "", ';
  Result := Result + '              CONCAT(NOTGER.GER_CODCLI,"-", NOTGER.GER_NOMCON), CONCAT(MOVGER.GER_CODCLI,"-", MOVGER.GER_NOMCON))), ';
  Result := Result + '      CONCAT(CTR_CODCLI,"-",CLI_NOMCLI))), CONCAT(CTR_CODCLI, "-", CLI_NOMCLI)) AS CTR_NOMCLI, ';
  Result := Result + '  CTR_DTACAD, ';
  Result := Result + '  CTR_DTAVEN, ';
  Result := Result + '  CTR_DTAENV, ';

  if blnDescFinanSomenteAteVenc Then
  Begin
    Result := Result + '  CTR_DTAREC, ';
    Result := Result + '  (CTR_VALDUP - IFNULL(CTR_DESSUJ, 0) + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0)) AS CTR_VALDUP_COM_DESC, ';
    Result := Result + '  (CTR_VALDUP - IF( CTR_DTAVEN >= ' + fCurrentDate + ', IFNULL(CTR_DESSUJ, 0), 0 ) + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0)) AS CTR_VALDUP, ';
    Result := Result + '  (CTR_VALDUP - IF( CTR_DTAVEN >= ' + fCurrentDate + ', IFNULL(CTR_DESSUJ, 0), 0 ) + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0)) AS CTR_VALSUJ_ORI, ';
    Result := Result + '  IF( CTR_DTAVEN >= ' + fCurrentDate + ', IFNULL(CTR_DESSUJ, 0), 0 ) AS CTR_DESSUJ, ';
  end
  else
  Begin
    Result := Result + '  (CTR_VALDUP - IFNULL(CTR_DESSUJ, 0) + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0)) AS CTR_VALDUP, ';
    Result := Result + '  IFNULL(CTR_DESSUJ, 0) AS CTR_DESSUJ, ';
  End;

  Result := Result + '  IFNULL(CTR_JURSUJ, 0) AS CTR_JURSUJ, ';
  Result := Result + '  CTR_CODVEN, ';
  Result := Result + '  CTR_CODDIG, ';
  Result := Result + '  CONCAT(CTR_CODVEN, "-", OPE_NOMOPE) AS CTR_NOMVEN, ';
  Result := Result + '  CTR_CODPOR, ';
  Result := Result + '  CONCAT(CTR_CODPOR, "-", POR_NOMPOR) AS CTR_NOMPOR, ';
  Result := Result + '  "D" AS CTR_MARDES, '; // Marcado / Desmarcado
  Result := Result + '  0.0000 AS CTR_VALREC, ';
  Result := Result + '  0.0000 AS CTR_VALJUR, ';
  Result := Result + '  0.0000 AS CTR_VALDES, ';
  Result := Result + '  0.0000 AS CTR_VALRES, ';
  Result := Result + '  0.0000 AS CTR_VLRJUR, ';
  Result := Result + '  0.0000 AS CTR_VLRDES, ';
  Result := Result + '  CTR_VALORI AS CTR_VALORI, ';
  Result := Result + '  CTR_VALDUP AS CTR_DUPORI, ';
  Result := Result + '  CTR_VALFCP, ';
  Result := Result + '  CTR_VALIPI, ';
  Result := Result + '  CTR_VALRET, ';
  Result := Result + '  CTR_VALCBS, ';
  Result := Result + '  CTR_VALIBS, ';
  Result := Result + '  CTR_VAL_IS, ';
  Result := Result + '  CTR_VALACE, ';
  Result := Result + '  CTR_VALFRE, ';
  Result := Result + '  0.0000 AS CTR_SOBCRE, ';
  Result := Result + '  CTR_DESCOB, ';
  Result := Result + '  CTR_DESCON, ';
  Result := Result + '  CTR_HIST01, ';
  Result := Result + '  CTR_HIST02, ';
  Result := Result + '  CTR_ADTCLI, ';
  Result := Result + '  CTR_CODEVE, ';
  Result := Result + '  CTR_CODVEL, ';
  Result := Result + '  CTR_OBSAG1, ';
  Result := Result + '  CTR_OBSAG2, ';
  Result := Result + '  CTR_OBSAG3, ';
  Result := Result + '  CTR_VALANT, ';

  If Not blnDescFinanSomenteAteVenc Then
  Begin
    Result := Result + '  (CTR_VALDUP - IFNULL(CTR_DESSUJ, 0) + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0)) AS CTR_VALSUJ, ';
  End
  Else
  Begin
    Result := Result + '  (CTR_VALDUP - IFNULL(CTR_DESSUJ, 0) + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0)) AS CTR_VALSUJ_COM_DESC, ';
    Result := Result + '  (CTR_VALDUP - IF( CTR_DTAVEN >= ' + fCurrentDate + ', IFNULL(CTR_DESSUJ, 0), 0 ) + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0)) AS CTR_VALSUJ, ';
    Result := Result + '  (CTR_VALDUP - IF( CTR_DTAVEN >= ' + fCurrentDate + ', IFNULL(CTR_DESSUJ, 0), 0 ) + IFNULL(CTR_JURSUJ, 0) + IFNULL(CTR_DESCOB, 0)) AS CTR_VALSUJ_ORI, ';
  End;

  Result := Result + '  "      " AS RCX_NUMROM, ';
  Result := Result + '  " "      AS CTR_BAIPAR, ';
  Result := Result + '  0        AS AUTOINCREM, ';
  Result := Result + '  CTR_VRTRDV, ';
  Result := Result + '  CTR_NOSNUM, ';
  Result := Result + '  CTR_BCOBOL, ';
  Result := Result + '  CTR_DTABOL, ';

  Result := Result + '  CTR_DTAENV, ';
  Result := Result + '  CTR_LINDIG, ';
  Result := Result + '  CTR_BCOENV, ';
  Result := Result + '  CTR_CARTEI, ';
  Result := Result + '  0.0000 AS CTR_CALORI, ';
  Result := Result + '  0.00 AS VALORNOVADUPLICATA, ';
  Result := Result + '  0.00 AS JUROSNOVADUPLICATA, ';
  Result := Result + '  0.00 AS DESCONTONOVADUPLICATA, ';
  Result := Result + '  0.00 AS DESPESASNOVADUPLICATA, ';
  Result := Result + '  0.00 AS VALORBAIXADUPLICATA, ';
  Result := Result + '  0.00 AS DESPESASBAIXADUPLICATA, ';
  Result := Result + '  0.0000000 AS FATORBAIXADUPLICATA, ';
  Result := Result + '  0.0000000 AS FATORJUROSDUPLICATA, ';
  Result := Result + '  CTR_NUMDUP AS NRODUP, ';
  Result := Result + '  CTR_PARCEL AS PARDUP, ';
  Result := Result + '  CTR_CODCED, ';
  Result := Result + '  FGO_BOLADT, ';

  Result := Result + '  IF((CTR_NOSNUM IS NOT NULL) OR (COALESCE(CTR_BCOBOL, "")= "999" AND CTR_DTABOL IS NOT NULL), "Sim", "Não") AS CTR_IMPBOL, ';
  Result := Result + '  IF(CTR_DTAENV IS NOT NULL, "Sim", "Não") AS CTR_ENVBCO, ';
  Result := Result + '  IF(NOTGER.GER_NUMDOC IS NULL, MOVGER.GER_DTLBEX, ' + fCurrentDate + ') AS CTR_DTLBEX, ';
  Result := Result + '  IFNULL(MOVGER.GER_ENTFUT, "N") AS CTR_ENTFUT, ';
  Result := Result + '  REPEAT(" ", 254) AS CTR_MOTDES, ';
  Result := Result + '  0.0000 AS CTR_VALCOR, ';
  Result := Result + '  0.0000 AS CTR_VALSUJ, ';
  Result := Result + '  IFNULL(CTR_PERDPO,0) AS CTR_PERDPO, ';
  Result := Result + '  IFNULL(CTR_QTDDAV,0) AS CTR_QTDDAV, ';
  Result := Result + '  CTR_BARCON, ';//CONTRATO
  Result := Result + '  "CADREC" AS CTR_NOMARQ, ';

  If Not fCfgSis('SFPGPD', VarBoolean) Then
    Result := Result + '  "   " AS CTR_FPG_PD, '
  Else
    Result := Result + '  IF(CTR_ESPDOC = "PD", FGO_CODFPG, IFNULL(NOTGER.GER_CODFPG, MOVGER.GER_CODFPG) ) AS CTR_FPG_PD, ';

  If Not fCfgSis('RECPLC', VarBoolean) Then
    Result := Result + '  1 AS CTR_PEDLBC, '
  Else
    Result := Result + '  FGO_LIBCOM AS CTR_PEDLBC, ';

  If Not fCfgSis('SOLCAR', VarBoolean) Then
  Begin
    Result := Result + '  "   " AS CTR_CODCAR, ';
    Result := Result + '  0 AS CTR_QTDPAC, ';
  End
  Else
  Begin
    Result := Result + '  FGO_CODCAR AS CTR_CODCAR, ';
    Result := Result + '  FGO_QTDPAC AS CTR_QTDPAC, ';
  End;

  Result := Result + '  POR_BAIRCX, ';
  Result := Result + '  FIS_NUMCOO, ';
  Result := Result + '  CONCAT(CTR_CODCLI,"-",CLI_NOMCLI) AS CTR_CLIORI, ';
  Result := Result + '  CTR_RECAUT, ';
  Result := Result + '  CTR_DOCDIV, ';
  Result := Result + '  CTR_CLIDIV, ';
  Result := Result + '  CLI_STATUS, ';
  Result := Result + '  CTR_CODCTA, ';
  Result := Result + '  CTR_DOCDIV,  ';
  Result := Result + '  CTR_TX_PIX,  ';
  Result := Result + '  CTR_EMPPIX,  ';
  Result := Result + '  IF((CTR_DTAVEN >= IF(CTR_DTAREC IS NULL, '+ fCurrentDate +',CTR_DTAREC)) OR (CTR_VALORI < 0), ';
  Result := Result + '     0, ';
  Result := Result + '     IF(CTR_DTAREC <= FRETPROXDIAUTIL (CTR_DTAVEN),0,DATEDIFF(IF(CTR_DTAREC IS NULL,'+ fCurrentDate +',CTR_DTAREC),CTR_DTAVEN)) ';
  Result := Result + '  ) AS DIASATRASO, ';
  Result := Result + '  FATGOR.FGO_NUMDOC AS FGO_DOCORI, ';
  Result := Result + '  FATGOR.FGO_ESPDOC AS FGO_ESPORI, ';
  Result := Result + '  CURRENT_DATE AS DATA_JUROS ';
  Result := Result + 'FROM ';
  Result := Result + '  CADREC ';
  Result := Result + '  LEFT JOIN CADOPE ON CTR_CODVEN = OPE_CODOPE ';
  Result := Result + '  LEFT JOIN CADCLI ON CTR_CODCLI = CLI_CODCLI ';
  Result := Result + '  LEFT JOIN CADPOR ON POR_CODPOR = CTR_CODPOR ';
  Result := Result + '  LEFT JOIN MOVGER ON MOVGER.GER_CODCLI = CTR_CODCLI ';
  Result := Result + '                  AND MOVGER.GER_NUMDOC = CTR_NUMDUP ';
  Result := Result + '                  AND MOVGER.GER_ESPDOC = CTR_ESPDOC ';
  Result := Result + '                  AND MOVGER.GER_CODEMP = CTR_CODEMP ';

  Result := Result + ' LEFT JOIN CADFIS ON FIS_NUMDOC = MOVGER.GER_NUMDOC AND ';
  Result := Result + '                     FIS_ESPDOC = MOVGER.GER_ESPDOC AND ';
  Result := Result + '                     FIS_CODEMP = MOVGER.GER_CODEMP AND ';
  Result := Result + '                     FIS_FORCLI = IF(FIS_TIP_FC = "C", MOVGER.GER_CODCLI, MOVGER.GER_CODFOR) AND ';
  Result := Result + '                     FIS_SERIE_ = MOVGER.GER_SERIE_     ';

  Result := Result + '  LEFT JOIN NOTGER ON NOTGER.GER_CODCLI = CTR_CODCLI ';
  Result := Result + '                  AND NOTGER.GER_NUMDOC = CTR_NUMDUP ';
  Result := Result + '                  AND NOTGER.GER_ESPDOC = CTR_ESPDOC ';
  Result := Result + '                  AND NOTGER.GER_CODEMP = CTR_CODEMP ';

  Result := Result + '  LEFT JOIN MOVDET MD ON MD.DET_CODEMP = CTR_CODEMP  ';
  Result := Result + '                  AND MD.DET_CODCLI = CTR_CODCLI     ';
  Result := Result + '                  AND MD.DET_NUMDOC = CTR_NUMDUP     ';
  Result := Result + '                  AND MD.DET_ESPDOC = CTR_ESPDOC     ';

  Result := Result + '  LEFT JOIN FATGOR ON FATGOR.FGO_NUMDOC = IF(CADREC.CTR_ESPDOC = "PD", CADREC.CTR_NUMDUP, DET_NUM_PD) ';
  Result := Result + '                  AND FATGOR.FGO_ESPDOC = IF(CADREC.CTR_ESPDOC = "PD", "PD", DET_ESP_PD)      ';
  Result := Result + '                  AND FATGOR.FGO_CODEMP = IF(CADREC.CTR_ESPDOC = "PD", CADREC.CTR_CODEMP, DET_EMP_PD) ';
  Result := Result + '                  AND FATGOR.FGO_CODCLI = IF(CADREC.CTR_ESPDOC = "PD", CADREC.CTR_CODCLI, DET_CODCLI) ';

  Result := Result + '  LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';

  If (Not fEmptyStr(strRomaneio)) Then
  Begin
    Result := Result + '  LEFT JOIN ROMGERX ON ROMGERX.GER_NUMDOC = CTR_NUMDUP AND ';
    Result := Result + '                       ROMGERX.GER_ESPDOC = CTR_ESPDOC AND ';
    Result := Result + '                       ROMGERX.GER_CODEMP = CTR_CODEMP AND ';
    Result := Result + '                       ROMGERX.GER_CODCLI = CTR_CODCLI     ';
  End;

end;

function TfrmRcxSelDocumentos.fEhDevolucaoDeFaturamentoFuturo(strNumDev, strEspDev,strCliDev, strEmpDev: String): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   DISTINCT DET_ESPDEV ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   MOVDET ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '   DET_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   DET_CODCLI = :CODCLI     ';

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('NUMDOC').AsString  := strNumDev;
    ParamByName('ESPDOC').AsString  := strEspDev;
    ParamByName('CODEMP').AsString  := strEmpDev;
    ParamByName('CODCLI').AsString  := strCliDev;

    Open;

    Result := (RecordCount = 1) And (Fields[0].AsString = 'FF');
  End;

  FreeAndNil(qryGen);
end;

function TfrmRcxSelDocumentos.fField(strName: String): TField;
begin
  Result := cdsDadosTemp.FieldByName(strName);
end;

function TfrmRcxSelDocumentos.fGetChaveAcessoDocumento: String;
begin
  Result := fRetChaveAcesso(fField('CTR_NUMDUP').AsString,
                            fField('CTR_ESPDOC').AsString,
                            fField('CTR_CODCLI').AsString,
                            fField('CTR_CODEMP').AsString);
end;

function TfrmRcxSelDocumentos.fGetNumeroCooDocumento: String;
begin
  Result := fRetNumeroCOO(fField('CTR_NUMDUP').AsString,
                          fField('CTR_ESPDOC').AsString,
                          fField('CTR_CODCLI').AsString,
                          fField('CTR_CODEMP').AsString);
end;

function TfrmRcxSelDocumentos.fLiberarDocumentoSemAutorizacaoSefaz: Boolean;
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('Permitir recebimento de duplicatas ( NF/IF ) mesmo sem autorização da SEFAZ');
  objLiberacao.objMsgLibera.pAddTextoCaption('Documento', fField('CTR_NUMDUP').AsString + '-' +
                                                          fField('CTR_ESPDOC').AsString + '-' +
                                                          fField('CTR_CODEMP').AsString);

  objLiberacao.strDirAce := 'LIBRECNFIFSEMAUTSEFAZ';
  objLiberacao.strMsgSen := 'Permitir recebimento de duplicatas ( NF/IF ) mesmo sem autorização da SEFAZ';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := objLiberacao.fLibera;
end;

procedure TfrmRcxSelDocumentos.pRemoveDevolucoesDeFF;
Var
  prcScroll: TPrcScroll;
begin
  With cdsDadosTemp Do
  Begin
    First;
    pDisableControls(cdsDadosTemp, prcScroll);
    While Not Eof Do
    Begin
      If fEhDevolucaoDeFaturamentoFuturo(FieldByName('CTR_NUMDUP').AsString,
                                         FieldByName('CTR_ESPDOC').AsString,
                                         FieldByName('CTR_CODCLI').AsString,
                                         FieldByName('CTR_CODEMP').AsString) Then
      Begin
        Delete;
      End
      Else
        Next;
    End;
    pEnableControls(cdsDadosTemp, prcScroll);
    First;
  End;
end;

procedure TfrmRcxSelDocumentos.pVerificaDestravarLckProf;
Var
  intIndice: Integer;
Begin
  If (Not Assigned(stlDupPro)) Or
     (stlDupPro.Count <= 0)    Or
     (fEmptyStr(fField('CTR_DOCDIV').AsString)) Then
    Exit;

  intIndice := stlDupPro.IndexOf(fRetChaveLckProf);

  If (intIndice >= 0) Then
    stlDupPro.Delete(intIndice);

  If (stlDupPro.Count <= 0) Then
    pDestravaDupCreditoProf;
End;

function TfrmRcxSelDocumentos.ValidaDuplicatasParaReceberDescontoGeral: Boolean;
  Var
    LDataset: TUniCLientDataset;
begin
  LDataset := TUniCLientDataset.Create(Nil);
  LDataset.Data := cdsDadosTemp.Data;

  Try
    LDataset.Filter := 'CTR_MARDES=''M'' AND CTR_BAIPAR<>''S'' AND CTR_VALCOR > 0';
    LDataset.Filtered := True;

    Result := Not LDataset.IsEmpty;

    If Not Result Then
      fMensagem('ATENÇÃO', 'Para aplicar o desconto geral nos títulos, deve possuir algum documento ' +
                           'positivo e baixado de forma integral na seleção.', ['&Ok']);
  Finally
    FreeAndNil(LDataset);
  End;
end;

function TfrmRcxSelDocumentos.fRetChaveLckProf: String;
begin

  Result := 'CADREC' +
            fField('CTR_NUMDUP').AsString +
            fField('CTR_ESPDOC').AsString +
            fField('CTR_CODEMP').AsString +
            fField('CTR_CODCLI').AsString +
            fField('CTR_PARCEL').AsString;

end;

function TfrmRcxSelDocumentos.fRetornaMediaPonderadaNova(strCodCli: String;
  objDados: TUniClientDataSet; blnCalcDiaUtil:Boolean=False): String;
  function fBuscaProxDiaUtil(data:TDateTime):TDateTime;
    function fExisteFeriado(data:TDateTime):Boolean;
    var
      qryFeriado :TUniQuery;
    begin
      qryFeriado := fCriaQuery(self);
      qryFeriado.SQL.Text :=
          ' SELECT COUNT(FER_DTAFER) FROM CADFER WHERE FER_DTAFER = ' +
               QuotedStr(FormatDateTime('YYYY-MM-DD',data));
      qryFeriado.Open;
      Result := qryFeriado.fields[0].AsInteger > 0;
      FreeAndNil(qryFeriado);
    end;
  Var
    dataNova : TDateTime;
  begin

    dataNova := data;

    if DayOfWeek(dataNova) = 1 then
      dataNova := datanova + 1;

    if DayOfWeek(dataNova) = 7 then
      dataNova := datanova + 2;

    while (fExisteFeriado(dataNova)) or (dayOfWeek(dataNova) in [1,7]) do
      dataNova := datanova + 1;

    result := dataNova;
  end;


  Var
    arrPonderada : Array of TPonderada;
    intTamanho   : Integer;
    intPosicao   : Integer;
    fltTotVlr    : Double;
    fltTotPon    : Double;

    dtaDtaVen: TDateTime;
    intAtraso: Double;

    cdsCloneRec : TUniClientDataSet;
begin
  cdsCloneRec := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsCloneRec, objDados);

  Result    := '0,00';
  intTamanho:= 1;

  with cdsCloneRec do
  begin
    Filtered := False;
    Filter   := ' CTR_MARDES = ' + QuotedStr('M');
    Filtered := True;
    First;
    While Not Eof Do
    Begin

          // dtaDtaVen := fBuscaProxDiaUtil(FieldByName('CTR_DTACAD').AsDateTime);
          // FOI SOLICITADO QUE COLOCASSE DATA DE CADASTRO PARA BATER COM A TELA DE INFORMAÇÃO
          // DE BAIXA DE CONTAS A RECEBER.
          // DESCONSIDERAR TAMBEM DIAS UTEIS. A DATA SERA FIXA PELO CAMPO DATA DE CADASTRO.
          // ACERTADO COM DOUGLAS.


      //REQ 67015
      // QUANDO BOTÃO ESPECÍFICO CLICADO, RECALCULAR MEDIA PONDERADA AJUSTANDO VARIAVEL PARA CALCULAR COM
      // DIAS UTEIS.
      // FA
      if blnCalcDiautil then
        dtaDtaVen := fBuscaProxDiaUtil(FieldByName('CTR_DTACAD').AsDateTime)
      else
        dtaDtaVen := FieldByName('CTR_DTACAD').AsDateTime;

      intAtraso := DaysBetween(VS_Date, dtaDtaVen);

      SetLength(arrPonderada, intTamanho);

      arrPonderada[intTamanho - 1].intDiasAtr := intAtraso;
      arrPonderada[intTamanho - 1].fltTotVlr  := FieldByName('CTR_VALCOR').AsFloat;
      arrPonderada[intTamanho - 1].fltTotPon  := FieldByName('CTR_VALCOR').AsFloat * intAtraso;

      Inc(intTamanho);

      Next;
      Application.ProcessMessages;
    End;
  end;
  fltTotVlr := 0;
  fltTotPon := 0;

  For intPosicao := 0 To High(arrPonderada) Do
  Begin
    fltTotVlr := fltTotVlr + arrPonderada[intPosicao].fltTotVlr;
    fltTotPon := fltTotPon + arrPonderada[intPosicao].fltTotPon;
  End;

  If fltTotVlr <> 0 Then
    Result := FormatFloat('0.00', fltTotPon / fltTotVlr);

  FreeAndNil(cdsCloneRec);
end;

function TfrmRcxSelDocumentos.fValidaLiberacaoCreditoProfissional: Boolean;
  Var
    cdsRecTmp: TUniClientDataSet;
    fltCrePro: Double;
    fltCreMax: Double;
    fltCreUti: Double;
Begin

  Result := True;

  Try

    If (fCfgSis('TCOPRO') <> '2') Or (Not fCfgSis('TRACPR', varBoolean)) Then
      Exit;

    cdsRecTmp := TUniClientDataSet.Create(Self);
    cdsRecTmp.Data := cdsDadosTemp.Data;
    cdsRecTmp.Filter := 'CTR_MARDES = ' + QuotedStr('M') + ' AND CTR_DOCDIV <> ' + QuotedStr('') + '';
    cdsRecTmp.Filtered := True;
    cdsRecTmp.Open;

    With cdsRecTmp Do
    Begin
      First;
      fltCrePro := 0;

      While Not Eof Do
      Begin
        fltCrePro := fltCrePro + FieldByName('CTR_VALDUP').AsFloat;
        Next;
      End;
    End;

    If (fltCrePro < 0) Then
      Result := fVerificaCredProfissionaisMes(fltCrePro, fltCreUti);

    If (Not Result) Then
    Begin
      Result := True;

      fltCreMax := fCfgSis('MAXUCM', varDouble);

      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Os valores dos créditos selecionados ultrapassam o valor máximo de utilização de crédito dentro do mês corrente.');
      objLiberacao.objMsgLibera.pAddTextoCaption('Empresa', VS_strCodEmp + '-' + fRetNomeEmpresa);
      objLiberacao.objMsgLibera.pAddTextoCaption('Valor máximo permitido'          , FormatFloat('#,##0.00', fltCreMax )                                       , 32, alDireita, teAmbos, '', 10);
      objLiberacao.objMsgLibera.pAddTextoCaption('Créditos já utilizados'          , FormatFloat('#,##0.00', Abs(fltCreUti))                                   , 32, alDireita, teAmbos, '', 10);
      objLiberacao.objMsgLibera.pAddTextoCaption('Créditos para liberação'         , FormatFloat('#,##0.00', Abs(fltCrePro))                                   , 32, alDireita, teAmbos, '', 10);
      objLiberacao.objMsgLibera.pAddTextoCaption('Créditos utilizados + liberação' , FormatFloat('#,##0.00', Abs(fltCreUti) + Abs(fltCrePro))                  , 32, alDireita, teAmbos, '', 10);
      objLiberacao.objMsgLibera.pAddTextoCaption('Diferença'                       , FormatFloat('#,##0.00', Abs(fltCreUti) + Abs(fltCrePro) - Abs(fltCreMax)) , 32, alDireita, teAmbos, '', 10);

      blnLiberouUtiCredProf := False;

      objLiberacao.strDirAce := 'MAXUCM';
      objLiberacao.strSenLib := fCfgSis('SENUCM');
      objLiberacao.strMsgSen := 'Máximo de utilização de crédito para profissionais';
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := strLoginUsuarioLogado;

      If Not objLiberacao.fLibera Then
      Begin
        Result := False;
      End
      Else
        blnLiberouUtiCredProf := True;

    End;

  Except
    On E: Exception Do
      pMensagensErro('Houve um erro ao validar a liberação de crédito de profissional', e.message);
  End;

  FreeAndNil(cdsRecTmp);
End;

procedure TfrmRcxSelDocumentos.pDesmarcaDuplicatasCreditoProfissional;
  Var
    intRecNo: Integer;
    prcScroll: TPrcScroll;
Begin
  pDisableControls(cdsDadosTemp, prcScroll);
  Try

    With cdsDadosTemp Do
    Begin
      intRecNo := RecNo;
      First;

      While Not Eof Do
      Begin
        If (Not fEmptyStr(FieldByName('CTR_DOCDIV').AsString)) And
           (FieldByName('CTR_MARDES').AsString = 'M') Then
          pSelecionaDuplicata(False);

        Next;
      End;

      RecNo := intRecNo;
    End;

  Except
    On E: Exception Do
      pMensagensErro('Houve um erro ao desmarcar as duplicatas de créditos para profissional', E.Message);
  End;

  pEnableControls(cdsDadosTemp, prcScroll);
End;

function  TfrmRcxSelDocumentos.fLiberaBaixaParcialComJuros(blnBaixaComCreditos: Boolean = False): Boolean;
var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
  fltValor : Double;
begin
  If blnBaixaComCreditos Then
    fltValor := (fCalculaTotalCreditos*-1)
  Else
    fltValor := cdsDadosTemp.FieldByName('CTR_VALREC').AsFloat;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddSeparador(127);
  objLiberacao.objMsgLibera.pAddTexto('LIBERAÇÃO DE BAIXA PARCIAL DE DUPLICATA COM JUROS', alCentro, teAmbos, '',127);


  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DUPLICATA'     , 21 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'       , 27 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'DT.CAD.'       , 11 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT.VENC.'      , 11 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'VR.ORIGINAL'   , 15 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'VR.CORRIGIDO'  , 14 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'VR.BX.PARCIAL' , 13 , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);

  with  cdsDadosTemp do
  begin
    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('DUPLICATA'     , fPadR(FieldByName('CTR_NUMDUP').AsString,12) +
                                          FieldByName('CTR_PARCEL').AsString + '-' +
                                          FieldByName('CTR_ESPDOC').AsString + '-' +
                                          FieldByName('CTR_CODEMP').AsString                                , 21 , alEsquerda );
    objLinha.pAddColuna('CLIENTE'       , FieldByName('CTR_NOMCLI').AsString                                , 27 , alEsquerda );
    objLinha.pAddColuna('DT.CAD.'       , FormatDateTime('dd/mm/yyyy',FieldByName('CTR_DTACAD').AsDateTime) , 11 , alCentro   );
    objLinha.pAddColuna('DT.VENC.'      , FormatDateTime('dd/mm/yyyy',FieldByName('CTR_DTAVEN').AsDateTime) , 11 , alCentro   );
    objLinha.pAddColuna('VR.ORIGINAL'   , FloatToStrF(FieldByName('CTR_DUPORI').AsFloat, ffNumber, 9, 2)    , 15 , alDireita  );
    objLinha.pAddColuna('VR.CORRIGIDO'  , FloatToStrF(FieldByName('CTR_VALCOR').AsFloat, ffNumber, 9, 2)    , 14 , alDireita  );
    objLinha.pAddColuna('VR.BX.PARCIAL' , FloatToStrF(fltValor, ffNumber, 9, 2)                             , 13 , alDireita  );
    objTabela.lstLinhas.Add(objLinha);
  end;

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.strDirAce := 'BAIDUPJUR';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.objMsgLibera.strTitulo := 'LIBERAÇÃO DE BAIXA PARCIAL DE DUPLICATA COM JUROS';

  If objLiberacao.fLibera Then
    Result := True
  else
    Result := False;
end;

function TfrmRcxSelDocumentos.fTemPermissaoBaixarDuplicataComPortadorTravadoCad() : Boolean;
  Var
    objTabela : TRegistroMsgLiberaTabela;
    objLinha : TLinhaMsgLibera;
begin
  try
    if (fField('POR_BAIRCX').AsString <> 'N') then
       begin
         Result :=  True;
         exit;
       end;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(0, teAutcom);
    objLiberacao.objMsgLibera.pAddTexto('BAIXA DE DUPLICATAS COM PORTADOR BLOQUEADO PARA RECEBIMENTO', alCentro , teAutcom,  '', 141);

    objTabela := TRegistroMsgLiberaTabela.Create;

    objLinha := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna('', 'DUPLICATA'    , 14 , alEsquerda , teAutcom);
    objLinha.pAddColuna('', 'ESP'          ,  3 , alCentro   , teAutcom);
    objLinha.pAddColuna('', 'EMP'          ,  3 , alCentro   , teAutcom);
    objLinha.pAddColuna('', 'CLIENTE'      , 35 , alEsquerda , teAutcom);
    objLinha.pAddColuna('', 'PORTADOR'     , 24 , alEsquerda , teAutcom);
    objLinha.pAddColuna('', 'DT.CAD.'      , 10 , alCentro   , teAutcom);
    objLinha.pAddColuna('', 'DT.VENCTO'    , 10 , alCentro   , teAutcom);
    objLinha.pAddColuna('', 'VR.ORIGINAL'  , 12 , alDireita  , teAutcom);
    objLinha.pAddColuna('', 'VR.DUPLICATA' , 12 , alDireita  , teAutcom);
    objTabela.lstLinhas.Add(objLinha);

    objLinha := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlValor;
    objLinha.pAddColuna('DUPLICATA'    , fField('CTR_DUPPAR').AsString , 14 , alEsquerda );
    objLinha.pAddColuna('ESP'          , fField('CTR_ESPDOC').AsString ,  3 , alCentro   );
    objLinha.pAddColuna('EMP'          , fField('CTR_CODEMP').AsString ,  3 , alCentro   );
    objLinha.pAddColuna('CLIENTE'      , fField('CTR_NOMCLI').AsString , 35 , alEsquerda );
    objLinha.pAddColuna('PORTADOR'     , fField('CTR_NOMPOR').AsString , 24 , alEsquerda );
    objLinha.pAddColuna('DT.CAD.'      , FormatDateTime('dd/mm/yy', fField('CTR_DTACAD').AsDateTime) , 10 , alCentro  );
    objLinha.pAddColuna('DT.VENC.'     , FormatDateTime('dd/mm/yy', fField('CTR_DTAVEN').AsDateTime) , 10 , alCentro  );
    objLinha.pAddColuna('VR.ORIGINAL'  , FloatToStrF(fField('CTR_VALORI').AsFloat, ffNumber, 9, 2)   , 12 , alDireita );
    objLinha.pAddColuna('VR.DUPLICATA' , FloatToStrF(fField('CTR_VALDUP').AsFloat, ffNumber, 9, 2)   , 12 , alDireita );
    objTabela.lstLinhas.Add(objLinha);

    objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

    objLiberacao.strDirAce := 'DIRRCXRECPORTRA';
    objLiberacao.strCodIte := fField('CTR_DUPPAR').AsString;//PARA DIFERENCIAR, PODE HAVER LIBERAÇÃO DE DUPLICATAS DIFENTES COM MESMO DIREITO DE ACESSO.
    objLiberacao.strMsgSen := 'Permitir Recebimento de Duplicatas com Portadores Travados para Baixa no Cadastro';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    Result := objLiberacao.fLibera;

  finally

  end
end;

function TfrmRcxSelDocumentos.fLiberouAutenticacaoPendenteExpedicao: Boolean;
  Var
    strDocNaoPedeLiberacao : String;
    blnDocExpedido : Boolean;

Begin
  Result := True;

  strDocNaoPedeLiberacao := fCfgSis('DOCEXP');

  blnDocExpedido := fDocumentoExpedido(copy(fField('CTR_DUPPAR').AsString, 01, fTamDocCadRec()),
                                            fField('CTR_ESPDOC').AsString,
                                            fField('CTR_CODEMP').AsString);
  If (VS_strTipExp = '2') And
     (Pos(fField('CTR_ESPDOC').AsString, strDocNaoPedeLiberacao) <= 0) And
     (Not blnDocExpedido) And
     (Not fVerificaAcessoSistema('LIBCREDDOCNAOEXP', strCodOpe)) Then
  Begin

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Autenticação - Permitir liberar crédito para o cliente de documento pendente de expedição.');

    objLiberacao.strDirAce := 'LIBCREDDOCNAOEXP';
    objLiberacao.strMsgSen := 'Autenticação - Permitir liberar crédito para o cliente de documento pendente de expedição.';
    objLiberacao.blnMosMen := True;
    objLiberacao.strCodOpe := strCodOpe;
    objLiberacao.strCodDig := strCodOpe;

    objLiberacao.objMsgLibera.pAddTextoCaption('Documento'     , fField('CTR_DUPPAR').AsString, 18);
    objLiberacao.objMsgLibera.pAddTextoCaption('Data Emissão'  , DateToStr(fField('CTR_DTACAD').AsDateTime), 18);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor'         , FloatToStrF(fField('CTR_VRTRDV').AsFloat, ffFixed, 12, 2), 18);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'       , fField('CTR_NOMCLI').AsString, 18);

    Result := objLiberacao.fLibera;
  End;

End;

procedure TfrmRcxSelDocumentos.pClonaDuplicatasOriginais;
Begin
  cdsCloneDup := TUniClientDataSet.Create(Self);

  pCloneDataSet(cdsCloneDup, cdsDadosTemp);
End;

procedure TfrmRcxSelDocumentos.pCarregaValoresOriginais(cds : TDataset; strAutoInc : String);
Begin

  cdsCloneDup.Filtered := False;
  cdsCloneDup.Filter := 'AUTOINCREM = '+QuotedStr(strAutoInc);
  cdsCloneDup.Filtered := True;

  If Not cdsCloneDup.IsEmpty Then
  Begin
     cds.FieldByName('CTR_VALDUP').AsFloat := cdsCloneDup.FieldByName('CTR_VALDUP').AsFloat;
     cds.FieldByName('CTR_VALCOR').AsFloat := fFormataFloat(cds.FieldByName('CTR_VALCOR').AsFloat -
                                                            cds.FieldByName('CTR_DESCOB').AsFloat +
                                                            cdsCloneDup.FieldByName('CTR_DESCOB').AsFloat, 2);
     cds.FieldByName('CTR_DESCOB').AsFloat := cdsCloneDup.FieldByName('CTR_DESCOB').AsFloat;
  End;

End;

end.
