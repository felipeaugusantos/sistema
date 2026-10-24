unit untFatManutRomaneio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass, untFatGor, untFuncoesRel,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.Mask, MaskEditFocus, EditFocus,
  untTypesSistema, Data.DB, MemDS, DBAccess, Uni, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, StrUtils, System.UITypes,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Datasnap.DBClient, Math,
  UniClientDataSet, Datasnap.Provider, UniDataSetProvider, untModulo,
  cxButtonEdit, cxProgressBar, untConfiguracaoGridFactory, untTLock, untLogCancelamento;

type
  TAcaoRomaneio = (tpRemover, tpGerar, tpIncluir, tpIndefinido);

type
  TfrmFatManutRomaneio = class(TfrmPai)
    pnlCabecalho: TPanel;
    pnlRomaneio: TPanel;
    pnlManutancao: TPanel;
    lblEmpresa: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    lblDtaInin: TLabel;
    lblDtaFin: TLabel;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lblRomaneio: TLabel;
    edtNumRom: TEditFocus;
    lblMotorista: TLabel;
    edtCodMot: TEditFocus;
    edtNomMot: TEditFocus;
    grdRomaneioDBTableView: TcxGridDBTableView;
    grdRomaneioLevel1: TcxGridLevel;
    grdRomaneio: TcxGrid;
    cdsRomaneio: TUniClientDataSet;
    dtsRomaneio: TDataSource;
    btnFiltrar: TBitBtnLocked;
    dspRomaneio: TUniDataSetProvider;
    qryRomaneio: TUniQuery;
    grdRomaneioNUMROM: TcxGridDBColumn;
    grdRomaneioDTAENT: TcxGridDBColumn;
    grdRomaneioNOMMOT: TcxGridDBColumn;
    grdRomaneioPESBRU: TcxGridDBColumn;
    grdRomaneioVLRCON: TcxGridDBColumn;
    grdRomaneioDBTableView1: TcxGridDBTableView;
    grdRomaneioLevel2: TcxGridLevel;
    grdRomaneioDBTableView2: TcxGridDBTableView;
    grdRomaneioDETNUMROM: TcxGridDBColumn;
    grdRomaneioDETNOMCLI: TcxGridDBColumn;
    grdRomaneioDETDOCUME: TcxGridDBColumn;
    grdRomaneioDETPESBRU: TcxGridDBColumn;
    grdRomaneioDETVLRCON: TcxGridDBColumn;
    grdRomaneioDETMARDES: TcxGridDBColumn;
    cdsDocumentos: TUniClientDataSet;
    dtsDocumentos: TDataSource;
    cdsDocumentosGER_NUMROM: TStringField;
    cdsDocumentosGER_NUMDOC: TStringField;
    cdsDocumentosGER_ESPDOC: TStringField;
    cdsDocumentosGER_CODCLI: TStringField;
    cdsDocumentosCLI_NOMCLI: TStringField;
    cdsDocumentosGER_DOCUME: TStringField;
    cdsDocumentosGER_PESBRU: TFloatField;
    cdsDocumentosGER_VLRCON: TFloatField;
    cdsDocumentosGER_MARDES: TStringField;
    cdsRomaneioGER_NUMROM: TStringField;
    cdsRomaneioGER_DTAENT: TDateField;
    cdsRomaneioMOT_NOMMOT: TStringField;
    cdsRomaneioGER_PESBRU: TFloatField;
    cdsRomaneioGER_VLRCON: TFloatField;
    pnlTotais: TPanel;
    lbltotDocSel: TLabel;
    lblTotDoc: TLabel;
    lblTotPesSel: TLabel;
    lblTotValSel: TLabel;
    grdRomaneioBTNMARTOT: TcxGridDBColumn;
    grdRomaneioBTNDESTOT: TcxGridDBColumn;
    grdRomaneioBTNMOVER: TcxGridDBColumn;
    cdsRomaneioBTNMAR: TStringField;
    cdsRomaneioBTNDES: TStringField;
    cdsRomaneioBTNMOV: TStringField;
    grdManutencaoDBTableView: TcxGridDBTableView;
    grdManutencaoLevel1: TcxGridLevel;
    grdManutencao: TcxGrid;
    cdsManut: TUniClientDataSet;
    cdsManutGER_NUMROM: TStringField;
    cdsManutGER_NUMDOC: TStringField;
    cdsManutGER_ESPDOC: TStringField;
    cdsManutGER_CODCLI: TStringField;
    cdsManutCLI_NOMCLI: TStringField;
    cdsManutGER_DOCUME: TStringField;
    cdsManutGER_PESBRU: TFloatField;
    cdsManutGER_VLRCON: TFloatField;
    cdsManutGER_MARDES: TStringField;
    dtsManut: TDataSource;
    grdManutencaoMATNUMROM: TcxGridDBColumn;
    grdManutencaoMATNOMCLI: TcxGridDBColumn;
    grdManutencaoMATDOCUME: TcxGridDBColumn;
    grdManutencaoMATPESBRU: TcxGridDBColumn;
    grdManutencaoMATVLRCON: TcxGridDBColumn;
    grdManutencaoMATMARDES: TcxGridDBColumn;
    cdsDocumentosAUTOINCREM: TStringField;
    cdsManutAUTOINCREM: TStringField;
    cdsManutCEPENT: TStringField;
    cdsManutCIDENT: TStringField;
    cdsDocumentosCEPENT: TStringField;
    cdsDocumentosCIDENT: TStringField;
    grdRomaneioDETCIDENT: TcxGridDBColumn;
    grdRomaneioDETCEPENT: TcxGridDBColumn;
    pnlAcao: TPanel;
    btnRemover: TBitBtnLocked;
    btnGerarNovo: TBitBtnLocked;
    btnIncluir: TBitBtnLocked;
    lblInformacao: TLabel;
    cdsDocumentosGER_EMPROM: TStringField;
    cdsManutGER_EMPROM: TStringField;
    cdsRomaneioGER_EMPROM: TStringField;
    cdsDocumentosGER_PESLIQ: TFloatField;
    cdsRomaneioGER_PESLIQ: TFloatField;
    cdsManutGER_PESLIQ: TFloatField;
    cdsDocumentosGER_ENTSAI: TStringField;
    cdsManutGER_ENTSAI: TStringField;
    cdsDocumentosGER_CODEMP: TStringField;
    cdsManutGER_CODEMP: TStringField;
    btnCfgGrid: TBitBtnLocked;
    btnEntEsp: TBitBtnLocked;
    grdRomaneioDOCS_FAT: TcxGridDBColumn;
    cdsDocumentosDOCS_FAT: TStringField;
    cdsDocumentosGER_NOMTAB: TStringField;
    procedure FormShow(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumRomKeyPress(Sender: TObject; var Key: Char);
    procedure btnFiltrarClick(Sender: TObject);
    procedure grdRomaneioDBTableView2DblClick(Sender: TObject);
    procedure grdRomaneioDBTableView2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdRomaneioDBTableView2CustomDrawCell(
      Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
      AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure grdRomaneioBTNMARTOTPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure grdRomaneioBTNDESTOTPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure grdRomaneioBTNMOVERPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure grdManutencaoDBTableViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnRemoverClick(Sender: TObject);
    procedure btnGerarNovoClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCfgGridClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnEntEspClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    type
      TDadosTranspMot = record
        strCodTra : String;
        strCodMot : String;
        strCodAj1 : String;
        strCodAj2 : String;
        strCodAj3 : String;
        strCodAj4 : String;
        strObsFec : String;
        strPlaVei : String;
        strCodReg : String;
        fltVlrFre : Double;
        fltVlrAdi : Double;
        fltPerFre : Double;
        strNumBox : String;
        dtaDtaRom : TDate;
        dtaHorRom : TDateTime;
      End;
  private
    strAceRom: String;
    arrMot,
    arrRom,
    arrEmpres: TConsultasArray;
    strOpcRom: string;
    FFgoRemov: string;
    FGerRemov: string;
    FCodTra,
    FCodMot,
    FNumBox,
    FCodAj1,
    FCodAj2,
    FCodAj3,
    FCodAj4,
    FObsFec,
    FPlaVei,
    FCodReg: string;
    FVlrFre,
    FVlrAdi,
    FPerFre: Double;
    FOpeRom: string;
    FDtaRom: TDateTime;
    FHorRom: TDateTime;
    FNumRom: string;
    FEmpRom: string;
    cdsRomDet : TUniClientDataSet;
    blnUsaPreRom: Boolean;
    FAcaoRomaneio: TAcaoRomaneio;
    objLock: TLock;
    FLogCancelamento : TLogCancelamento;
    cfgConfiguracaoGrids: TConfiguracaoGridFactory;

    function fExisteCancelamentoPendentePorChaveAcesso(const strNumDoc, strEspDoc, strCodEmp, strCodCli : String): Boolean;
    function fCarregaCadMot: Boolean;
    procedure pConsultaRomaneios;
    procedure fCondicao(var AQry: TUniQuery);
    procedure pMarcaDesmarcaDocumento;
    procedure pSomaTotais;
    procedure pMarcaDesmarcaTodos(AMarca: Boolean);
    procedure pMoverPedido;
    procedure pRemoveRegistro;
    function fRemoveRomaneio: Boolean;
    function fRetOperadorSolicitante: string;
    function fSelecionaDocumentos(AFgoDocs, AGerDocs, ANumRom: string): Boolean;
    function fGetCampo(ACampo: String): String;
    function fRetSQLDoc(ADocumentosFgo, ADocumentosGer: String): String;
    procedure pRetornaTransMot(ANumRom, AEmpRom: string);
    function fIniciaMautencao: Boolean;
    procedure pRetornaDocumentos(var ADocumentosFgo, ADocumentosGer: String; ADataSet: TUniClientDataSet);
    function fGravaRomaneio(qryMovGer: TUniQuery; strCodTra, strPlaVei, strCodMot, strNumBox,
      strCodAj1, strCodAj2, strCodAj3, strCodAj4, strObsFec, strCodReg: String; Var strNumRom: String; strOpeSol: String; strEntSai: String; strFgoDocs, strGerDocs: String): Boolean;
    function fRetMensagemExpedicao(strNumDoc, strEspDoc, strCodEmp: String; strTabela: String;
      Var stlMsgExp: TStringList): String;
    procedure pCopiaParaTemporaria(AQryDados: TUniQuery; Var ACdsDados: TUniClientDataSet);
    procedure pAdicionaDadosRomDet(ANumDoc, AEspDoc, ACodEmp, ACodCli, AEntSai, AAutInc, ANomTab, AClaFis: string);
    function fAtualizaQtdBaiDet(strNumDoc, strEspDoc, strCodCli, strCodEmp : String;
      blnPedOrc: Boolean; strNumRom, strNomTab, strAutInc, strEntSai, strClaFis: String): Boolean;
    function fRetTabelaDet(strNomTab: String): String;
    function fQtdeRomInvalido(strCodIte, strNumDoc, strEspDoc, strCodCli, strCodEmp, strTabela: String): Boolean;
    function fRetVolumeItem(strCodIte: String; fltQtdIte: Double): Double;
    function fAtualizaDocumentos(ANumDoc, AEspDoc, ACodEmp, ACodCLi, ANumRom, AFgoDocs, AGerDocs: string; AValSel: Double): Boolean;
    function fListaAutIncGer(strLisDoc, strTabela: String): String;
    function fPedeTelaTransportadora(var ADadosTranspMot : TDadosTranspMot): Boolean;
    function fGeraRomaneio: Boolean;
    function fIncluiRomaneio: Boolean;
    function fRetRomaneio(var AEmpRom: string): string;
    function fRetDocsRomaneioInformado: Boolean;
    function fRemoveRomaneioClick(pgbStatus: TcxProgressBar): Boolean;
    function fGeraRomaneioClick(pgbStatus: TcxProgressBar): Boolean;
    function fIncluiRomaneioClick(pgbStatus: TcxProgressBar): Boolean;
    procedure pPegaMsgDocBaixaEntFut(var stlMsgExp: TStringList; strNumDoc, strEspDoc, strCodEmp: string);
    function fAdicionaRomDetOpcRom_1_5(AAutInc, AEspDoc, AEntSai, AClaFis: String; ADocTemItemRepetido: Boolean): String;
    function fAdicionaRomDetOpcRom_2(AEspDoc, AEntSai, AClaFis: String; ADocTemItemRepetido: Boolean): String;
    function fAdicionaRomDetOpcRom_3_4(AAutInc, AEspDoc, AEntSai, AClaFis: String; ADocTemItemRepetido: Boolean): String;
    function fAdicionaRomDetOpcRom_3_4_Parte_2(AEspDoc, AEntSai, AClaFis: String; ADocTemItemRepetido: Boolean): String;
    procedure pAtualizaQtdBaiDetGeral(strNumDoc, strEspDoc, strCodEmp, strCodCli, strTabelaMovDet: String;
                                      blnUsaPreRom: Boolean;
                                      var cdsRomDet, cdsTmp: TUniClientDataSet; strClaFis: String;
                                      blnDocTemItemRepetido: Boolean);
    function fAtualizaQtdBaiDetOpcRom_234(strNumDoc, strEspDoc, strCodCli, strCodEmp,
                                          strNumRom, strAutInc, strTabelaMovDet, strTabelaMovDetTri: string;
                                          var cdsTmp: TUniClientDataSet):Boolean;
    function fAtualizaQtdBaiDetOpcRom_15(strNumDoc, strEspDoc, strCodCli, strCodEmp,
                                         strNumRom, strAutInc: string; var cdsTmp: TUniClientDataSet): Boolean;
    procedure pInfTabelaGravaRomaneio(strNomTab: string; var strTabelaMovDet: string; var blnPedOrc: Boolean);
    procedure pFormataCamposCds(var ACdsDados: TUniClientDataSet);
    function  fRetSqlMensagemExpedicao(strTabela: string): string;
    procedure pCarregaConfiguracoesGrids;
    procedure pDestravaTodasAsTravas;
    procedure pDestravaLock(ALock: TLock);
    function fTravaDestravaDocumento(const ATravar: Boolean; const AMarcandoTodos : Boolean; var AInterromperProcesso : Boolean): Boolean;
    function fPodeDesmarcarDocumento(AMarcar: Boolean): Boolean;
    function fDocumentoSofreuAlteracao(var ADocumentos: String; AMarca: Boolean): Boolean;
    procedure pGravaLogRomaneioSemRomDetX;
    procedure pValidaSeNecessitaDestravarLocks(const strNumRom: String; strEmpRom : String);
    function fTemAlgumDocumentoMarcado(const strNumRom: String; strEmpRom : String): Boolean;
    procedure pSetDadosTransportadoraMotorista(const ADadosTranspMot : TDadosTranspMot);
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnGravou: Boolean;
    strNumRomCarregado: String;
    objLockRomaneio: TLock;
  end;

implementation

uses
  untFuncoesSimples, untFuncoesConsulta, untConsultas, untRomGer,
  untFatRomTransMot, untGravando, untFatManutRomaneioEntEsp, untGravaRomaneio, untConstantes;

{$R *.dfm}

procedure TfrmFatManutRomaneio.btnCfgGridClick(Sender: TObject);
begin
  cfgConfiguracaoGrids.fGravarConfiguracaoGrids;
end;

procedure TfrmFatManutRomaneio.btnEntEspClick(Sender: TObject);
  Var
    frmFatManutRomaneioEntEsp: TfrmFatManutRomaneioEntEsp;
begin
  inherited;
  If Not btnEntEsp.Visible Then
    Exit;

  If cdsRomaneio.IsEmpty Then
    Exit;

  pCriarFormularios(TfrmFatManutRomaneioEntEsp, frmFatManutRomaneioEntEsp);
  Try
    frmFatManutRomaneioEntEsp.Caption := 'Pedidos com rota especial - Romaneio nº '+
      cdsRomaneio.FieldByName('GER_NUMROM').AsString +' - Motorista '+
      cdsRomaneio.FieldByName('MOT_NOMMOT').AsString;

    frmFatManutRomaneioEntEsp.strNumRom := cdsRomaneio.FieldByName('GER_NUMROM').AsString;
    frmFatManutRomaneioEntEsp.ShowModal;
  Finally
    pFreeAndNil(frmFatManutRomaneioEntEsp);
  End;
end;

procedure TfrmFatManutRomaneio.btnFiltrarClick(Sender: TObject);
begin
  inherited;

  If fVerificaCampos Then
    pConsultaRomaneios;
end;

procedure TfrmFatManutRomaneio.btnGerarNovoClick(Sender: TObject);
var
  LfrmGravando : TfrmGravando;
begin
  inherited;
  pCriarFormularios(TfrmGravando,LfrmGravando);

  Try
    Try
      LfrmGravando.lblGravando.Caption := 'Aguarde... Gerando novo romaneio.';
      LfrmGravando.fExecutarAcao := fGeraRomaneioClick;
      LfrmGravando.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[btnGerarNovoClick]');
      End;
    End;
  finally
    pFreeAndNil(LfrmGravando);
  end;
end;

procedure TfrmFatManutRomaneio.btnIncluirClick(Sender: TObject);
var
  LfrmGravando : TfrmGravando;
begin
  inherited;
  pCriarFormularios(TfrmGravando,LfrmGravando);

  Try
    Try
      LfrmGravando.lblGravando.Caption := 'Aguarde... Incluindo no romaneio.';
      LfrmGravando.fExecutarAcao := fIncluiRomaneioClick;
      LfrmGravando.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[btnIncluirClick]');
      End;
    End;
  finally
    pFreeAndNil(LfrmGravando);
  end;
end;

procedure TfrmFatManutRomaneio.btnRemoverClick(Sender: TObject);
var
  LfrmGravando : TfrmGravando;
begin
  inherited;
  pCriarFormularios(TfrmGravando,LfrmGravando);

  Try
    Try
      LfrmGravando.lblGravando.Caption := 'Aguarde... Removendo romaneio.';
      LfrmGravando.fExecutarAcao := fRemoveRomaneioClick;
      LfrmGravando.ShowModal;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[btnRemoverClick]');
      End;
    End;
  finally
    pFreeAndNil(LfrmGravando);
  end;
end;

procedure TfrmFatManutRomaneio.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpres, fRetNomeEmpresa, nil, 'da Empresa');
end;

procedure TfrmFatManutRomaneio.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, Nil, Key, arrEmpres, False, False, strAceRom) Then
    If fValidaCampos(edtCodEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmFatManutRomaneio.edtCodMotKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fPesqMotorista(Self, edtCodMot, edtNomMot, Nil, Key, arrMot, True, True) Then
  Begin
    If fValidaCampos(edtCodMot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatManutRomaneio.edtNumRomKeyPress(Sender: TObject;
  var Key: Char);
var
  LConGen: TUniQuery;
begin
  inherited;
  LConGen := fCriaQuery(Self);

  try
    If fPesqRomaneio(Self, edtNumRom, LConGen, Key, arrRom, '', True, True, 'Consulta de Romaneios') Then
    Begin
      If (fValidaCampos(edtNumRom, True)) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;
    End;
  finally
    FreeAndNil(LConGen);
  end;
end;

function TfrmFatManutRomaneio.fAdicionaRomDetOpcRom_1_5(AAutInc, AEspDoc, AEntSai, AClaFis: string; ADocTemItemRepetido: Boolean): String;
var
  strSQL: string;
begin
  strSQL := EmptyStr;

  strSQL := strSQL + '  FDO_NUMDOC DET_NUMDOC, ';
  strSQL := strSQL + '  FDO_ESPDOC DET_ESPDOC, ';
  strSQL := strSQL + '  FDO_CODEMP DET_CODEMP, ';
  strSQL := strSQL + '  FDO_CODITE DET_CODITE, ';
  strSQL := strSQL + '  FDO_DESCRI DET_DESITE, ';
  strSQL := strSQL + '  SUM(FDO_QTDITE - IFNULL(FDO_QTDROM, 0)) DET_QTDITE, ';
  strSQL := strSQL + '  SUM(FDO_QTDITE - IFNULL(FDO_QTDROM, 0)) DET_QTDBAI, ';
  strSQL := strSQL + '  SUM(FDO_QTDITE - IFNULL(FDO_QTDROM, 0)) DET_QTDTMP, ';
  strSQL := strSQL + '  SUM(FDO_QTDITE)              DET_QTDTOT, ';
  strSQL := strSQL + '  SUM(FDO_QTDITE)              DET_QTDTOT_REAL, ';
  strSQL := strSQL + '  FDO_UNITAR DET_UNITAR, ';
  strSQL := strSQL + '  FDO_DESESP DET_DESESP, ';
  strSQL := strSQL + '  FATDOR.AUTOINCREM DET_AUTINC, ';
  strSQL := strSQL + '  " " AS DET_INFITE, ';
  strSQL := strSQL + '  "N" AS DET_SEPIMP, ';
  strSQL := strSQL + '  FDO_NUMLOT DET_NUMLOT, ';
  strSQL := strSQL + '  "C" DET_TIP_FC,        ';
  strSQL := strSQL + '  FDO_CODCLI DET_CODCLI, ';
  strSQL := strSQL + '  SUM(FDO_TOTPES) AS DET_TOTPES, ';
  strSQL := strSQL + '  IF(LEFT(FDO_CLAFIS,1) >= "5", "S", "E") DET_ENTSAI, ';
  strSQL := strSQL + '  EXTDOR.FDO_TURENT AS TURENT, ';
  strSQL := strSQL + '  UNI_SIGUNI AS DET_UNIDAD, ';
  strSQL := strSQL + '  SUM(FDO_TOTPES) AS DET_VLTOPE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FATDOR ';
  strSQL := strSQL + '  JOIN CADITE I ON ITE_CODITE = FDO_CODITE ';
  strSQL := strSQL + '  LEFT JOIN EXTDOR ON FATDOR.AUTOINCREM = EXTDOR.FDO_SEQFDO ';
  strSQL := strSQL + '  LEFT JOIN CADUNI ON FATDOR.FDO_UNIDAD = CADUNI.UNI_CODUNI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FDO_CODITE <> :ITESER AND ';
  strSQL := strSQL + '  FDO_CODITE <> :SERTER AND ';
  strSQL := strSQL + '  FDO_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  FDO_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  FDO_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  FDO_CODEMP = :CODEMP ';

  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  FDO_CODITE, FDO_DESCRI, IFNULL(FDO_NUMLOT, "") ';

  if fAgrupaPorAutoIncrem(AClaFis, ADocTemItemRepetido) then
    strSQL := strSQL + '  ,FATDOR.AUTOINCREM ';

  If (fCfgSis('TRBRRO', varBoolean)) Then
  Begin
    strSQL := strSQL + '  ';
    strSQL := strSQL + 'UNION ALL ';
    strSQL := strSQL + '  ';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ' + QuotedStr(AAutInc) + ' DET_SEQGER, ';
    strSQL := strSQL + '  DET_NUMDOC, ';
    strSQL := strSQL + '  DET_ESPDOC, ';
    strSQL := strSQL + '  DET_CODEMP, ';
    strSQL := strSQL + '  DET_CODITE, ';
    strSQL := strSQL + '  DET_DESCRI DET_DESITE, ';
    strSQL := strSQL + '  SUM(DET_QTDITE - DET_QTDROM) DET_QTDITE, ';
    strSQL := strSQL + '  SUM(DET_QTDITE - DET_QTDROM) DET_QTDBAI, ';
    strSQL := strSQL + '  SUM(DET_QTDITE - DET_QTDROM) DET_QTDTMP, ';
    strSQL := strSQL + '  SUM(DET_QTDITE)              DET_QTDTOT, ';
    strSQL := strSQL + '  SUM(DET_QTDITE)              DET_QTDTOT_REAL, ';
    strSQL := strSQL + '  DET_UNITAR, ';
    strSQL := strSQL + '  DET_DESESP, ';
    strSQL := strSQL + '  MOVDET.AUTOINCREM DET_AUTINC, ';
    strSQL := strSQL + '  " " AS DET_INFITE, ';
    strSQL := strSQL + '  "N" AS DET_SEPIMP, ';
    strSQL := strSQL + '  DET_NUMLOT, ';
    strSQL := strSQL + '  "C" DET_TIP_FC,   ';
    strSQL := strSQL + '  DET_CODCLI,       ';
    strSQL := strSQL + '  SUM(DET_TOTPES) AS DET_TOTPES, ';
    strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) >= "5", "S", "E") DET_ENTSAI, ';
    strSQL := strSQL + '  DET_TURENT AS TURENT, ';
    strSQL := strSQL + '  UNI_SIGUNI AS DET_UNIDAD, ';
    strSQL := strSQL + '  SUM(DET_TOTPES) AS DET_VLTOPE ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  MOVDET ';
    strSQL := strSQL + '  JOIN CADITE I ON ITE_CODITE = DET_CODITE ';
    strSQL := strSQL + '  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
    strSQL := strSQL + '  LEFT JOIN CADUNI ON MOVDET.DET_UNIDAD = CADUNI.UNI_CODUNI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  DET_CODITE <> :ITESER AND ';
    strSQL := strSQL + '  DET_CODITE <> :SERTER AND ';

    If (AEspDoc = 'TR') Then
    Begin
      If (AEntSai = 'E') Then
        strSQL := strSQL + '  LEFT(DET_CLAFIS, 1) < 5 AND '
      Else
        strSQL := strSQL + '  LEFT(DET_CLAFIS, 1) >= 5 AND ';
    End
    Else
      strSQL := strSQL + '  LEFT(DET_CLAFIS, 1) >= 5 AND ';

    If (fCfgSis('EFTEST') = '2') And (fCfgSis('EFTESE') = '1') Then
      strSQL := strSQL + '  DET_PROEMB <> "S" AND ';

    strSQL := strSQL + '  RIGHT(DET_CLAFIS, 3) <> "999" AND ';
    strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  DET_CODEMP = :CODEMP ';

    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  DET_CODITE, DET_DESCRI, IFNULL(DET_NUMLOT, "") ';

    if fAgrupaPorAutoIncrem(AClaFis, ADocTemItemRepetido) then
      strSQL := strSQL + '  ,MOVDET.AUTOINCREM ';

  End;

  Result := strSQL;
end;

function TfrmFatManutRomaneio.fAdicionaRomDetOpcRom_2(AEspDoc, AEntSai, AClaFis: String; ADocTemItemRepetido: Boolean): String;
var
  strSQL: string;
begin
  strSQL := EmptyStr;

  strSQL := strSQL + '  DET_NUMDOC, ';
  strSQL := strSQL + '  DET_ESPDOC, ';
  strSQL := strSQL + '  DET_CODEMP, ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  DET_DESCRI DET_DESITE, ';

  If fUsaRomaneioDocsExpedidos Then
  Begin
    strSQL := strSQL + '  SUM(COALESCE(DET_QTDEXP, 0) - DET_QTDROM) DET_QTDITE, ';
    strSQL := strSQL + '  SUM(COALESCE(DET_QTDEXP, 0) - DET_QTDROM) DET_QTDBAI, ';
    strSQL := strSQL + '  SUM(COALESCE(DET_QTDEXP, 0) - DET_QTDROM) DET_QTDTMP, ';
    strSQL := strSQL + '  SUM(COALESCE(DET_QTDEXP, 0))              DET_QTDTOT, ';
    strSQL := strSQL + '  SUM(DET_QTDITE)                           DET_QTDTOT_REAL, ';
  End
  Else
  Begin
    strSQL := strSQL + '  SUM(DET_QTDITE - DET_QTDROM) DET_QTDITE, ';
    strSQL := strSQL + '  SUM(DET_QTDITE - DET_QTDROM) DET_QTDBAI, ';
    strSQL := strSQL + '  SUM(DET_QTDITE - DET_QTDROM) DET_QTDTMP, ';
    strSQL := strSQL + '  SUM(DET_QTDITE)              DET_QTDTOT, ';
    strSQL := strSQL + '  SUM(DET_QTDITE)              DET_QTDTOT_REAL, ';
  End;

  strSQL := strSQL + '  DET_UNITAR, ';
  strSQL := strSQL + '  DET_DESESP, ';
  strSQL := strSQL + '  MOVDET.AUTOINCREM DET_AUTINC, ';
  strSQL := strSQL + '  " " AS DET_INFITE, ';
  strSQL := strSQL + '  "N" AS DET_SEPIMP, ';
  strSQL := strSQL + '  DET_NUMLOT DET_NUMLOT,   ';
  strSQL := strSQL + '  "C" DET_TIP_FC,          ';
  strSQL := strSQL + '  DET_CODCLI,              ';

  If fUsaRomaneioDocsExpedidos Then
    strSQL := strSQL + '  SUM((DET_TOTPES / DET_QTDITE) * (COALESCE(DET_QTDEXP, 0) - COALESCE(DET_QTDROM, 0))) AS DET_TOTPES, '
  Else
    strSQL := strSQL + '  SUM(DET_TOTPES) AS DET_TOTPES, ';

  strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) >= "5", "S", "E") DET_ENTSAI, ';
  strSQL := strSQL + '  DET_TURENT AS TURENT, ';
  strSQL := strSQL + '  UNI_SIGUNI AS DET_UNIDAD, ';
  strSQL := strSQL + '  SUM(DET_TOTPES) AS DET_VLTOPE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET ';
  strSQL := strSQL + '  JOIN CADITE I ON ITE_CODITE = DET_CODITE ';
  strSQL := strSQL + '  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN CADUNI ON MOVDET.DET_UNIDAD = CADUNI.UNI_CODUNI ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_CODITE <> :ITESER AND ';
  strSQL := strSQL + '  DET_CODITE <> :SERTER AND ';

  If (AEspDoc = 'TR') Then
  Begin
    If (AEntSai = 'E') Then
      strSQL := strSQL + '  LEFT(DET_CLAFIS, 1) < 5 AND '
    Else
      strSQL := strSQL + '  LEFT(DET_CLAFIS, 1) >= 5 AND ';
  End;

  If (fCfgSis('EFTEST') = '2') And (fCfgSis('EFTESE') = '1') Then
    strSQL := strSQL + '  DET_PROEMB <> "S" AND ';

  strSQL := strSQL + '  RIGHT(DET_CLAFIS, 3) <> "999" AND ';
  strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  DET_CODEMP = :CODEMP ';

  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  DET_CODITE, DET_DESCRI, IFNULL(DET_NUMLOT, "") ';

  if fAgrupaPorAutoIncrem(AClaFis, ADocTemItemRepetido) then
    strSQL := strSQL + '  ,MOVDET.AUTOINCREM ';

  Result := strSQL;
end;

function TfrmFatManutRomaneio.fAdicionaRomDetOpcRom_3_4(AAutInc, AEspDoc, AEntSai, AClaFis: String; ADocTemItemRepetido: Boolean): String;
var
  strSQL: string;
begin
  strSQL := EmptyStr;

  strSQL := strSQL + '  DET_NUMDOC, ';
  strSQL := strSQL + '  DET_ESPDOC, ';
  strSQL := strSQL + '  DET_CODEMP, ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  DET_DESCRI DET_DESITE, ';

  If fUsaRomaneioDocsExpedidos Then
  Begin
    strSQL := strSQL + '  SUM(COALESCE(DET_QTDEXP, 0) - DET_QTDROM) DET_QTDITE, ';
    strSQL := strSQL + '  SUM(COALESCE(DET_QTDEXP, 0) - DET_QTDROM) DET_QTDBAI, ';
    strSQL := strSQL + '  SUM(COALESCE(DET_QTDEXP, 0) - DET_QTDROM) DET_QTDTMP, ';
    strSQL := strSQL + '  SUM(COALESCE(DET_QTDEXP, 0))              DET_QTDTOT, ';
    strSQL := strSQL + '  SUM(DET_QTDITE)                           DET_QTDTOT_REAL, ';
  End
  Else
  Begin
    strSQL := strSQL + '  SUM(DET_QTDITE - DET_QTDROM) DET_QTDITE, ';
    strSQL := strSQL + '  SUM(DET_QTDITE - DET_QTDROM) DET_QTDBAI, ';
    strSQL := strSQL + '  SUM(DET_QTDITE - DET_QTDROM) DET_QTDTMP, ';
    strSQL := strSQL + '  SUM(DET_QTDITE)              DET_QTDTOT, ';
    strSQL := strSQL + '  SUM(DET_QTDITE)              DET_QTDTOT_REAL, ';
  End;

  strSQL := strSQL + '  DET_UNITAR, ';
  strSQL := strSQL + '  DET_DESESP, ';
  strSQL := strSQL + '  MOVDET.AUTOINCREM DET_AUTINC, ';
  strSQL := strSQL + '  " " AS DET_INFITE, ';
  strSQL := strSQL + '  "N" AS DET_SEPIMP, ';
  strSQL := strSQL + '  DET_NUMLOT, ';
  strSQL := strSQL + '  "C" DET_TIP_FC,   ';
  strSQL := strSQL + '  DET_CODCLI,       ';

  If fUsaRomaneioDocsExpedidos Then
    strSQL := strSQL + '  SUM((DET_TOTPES / DET_QTDITE) * (COALESCE(DET_QTDEXP, 0) - COALESCE(DET_QTDROM, 0))) AS DET_TOTPES, '
  Else
    strSQL := strSQL + '  SUM(DET_TOTPES) AS DET_TOTPES, ';

  strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) >= "5", "S", "E") DET_ENTSAI, ';
  strSQL := strSQL + '  DET_TURENT AS TURENT, ';
  strSQL := strSQL + '  UNI_SIGUNI AS DET_UNIDAD, ';
  strSQL := strSQL + '  SUM(DET_TOTPES) AS DET_VLTOPE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  MOVDET ';
  strSQL := strSQL + '  JOIN CADITE I ON ITE_CODITE = DET_CODITE ';
  strSQL := strSQL + '  LEFT JOIN MOVTRI ON MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ';
  strSQL := strSQL + '  LEFT JOIN CADUNI ON MOVDET.DET_UNIDAD = CADUNI.UNI_CODUNI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_CODITE <> :ITESER AND ';
  strSQL := strSQL + '  DET_CODITE <> :SERTER AND ';

  If (AEspDoc = 'TR') Then
  Begin
    If (AEntSai = 'E') Then
      strSQL := strSQL + '  LEFT(DET_CLAFIS, 1) < 5 AND '
    Else
      strSQL := strSQL + '  LEFT(DET_CLAFIS, 1) >= 5 AND ';
  End;

  If (fCfgSis('EFTEST') = '2') And (fCfgSis('EFTESE') = '1') Then
    strSQL := strSQL + '  DET_PROEMB <> "S" AND ';

  strSQL := strSQL + '  RIGHT(DET_CLAFIS, 3) <> "999" AND ';
  strSQL := strSQL + '  DET_TIP_FC = "C" AND ';
  strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  DET_CODEMP = :CODEMP ';

  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  DET_CODITE, DET_DESCRI, IFNULL(DET_NUMLOT, "") ';

  if fAgrupaPorAutoIncrem(AClaFis, ADocTemItemRepetido) then
    strSQL := strSQL + '  ,MOVDET.AUTOINCREM ';

  strSQL := strSQL + '  ';
  strSQL := strSQL + 'UNION ALL ';
  strSQL := strSQL + '  ';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  ' + QuotedStr(AAutInc) + ' DET_SEQGER, ';

  strSQL := strSQL + '  DET_NUMDOC, ';
  strSQL := strSQL + '  DET_ESPDOC, ';
  strSQL := strSQL + '  DET_CODEMP, ';
  strSQL := strSQL + '  DET_CODITE, ';
  strSQL := strSQL + '  DET_DESCRI DET_DESITE, ';

  strSQL := strSQL + fAdicionaRomDetOpcRom_3_4_Parte_2(AEspDoc, AEntSai, AClaFis, ADocTemItemRepetido);

  if fAgrupaPorAutoIncrem(AClaFis, ADocTemItemRepetido) then
   strSQL := strSQL + '  ,NOTDET.AUTOINCREM ';

  Result := strSQL;
end;

function TfrmFatManutRomaneio.fAdicionaRomDetOpcRom_3_4_Parte_2(AEspDoc,
  AEntSai, AClaFis: String; ADocTemItemRepetido: Boolean): String;
var
  strSQL: string;
begin
  strSQL := EmptyStr;

  If fUsaRomaneioDocsExpedidos Then
  Begin
    strSQL := strSQL + '  SUM(COALESCE(DET_QTDEXP, 0) - DET_QTDROM) DET_QTDITE, ';
    strSQL := strSQL + '  SUM(COALESCE(DET_QTDEXP, 0) - DET_QTDROM) DET_QTDBAI, ';
    strSQL := strSQL + '  SUM(COALESCE(DET_QTDEXP, 0) - DET_QTDROM) DET_QTDTMP, ';
    strSQL := strSQL + '  SUM(COALESCE(DET_QTDEXP, 0))              DET_QTDTOT, ';
    strSQL := strSQL + '  SUM(DET_QTDITE)                           DET_QTDTOT_REAL, ';
  End
  Else
  Begin
    strSQL := strSQL + '  SUM(DET_QTDITE - DET_QTDROM) DET_QTDITE, ';
    strSQL := strSQL + '  SUM(DET_QTDITE - DET_QTDROM) DET_QTDBAI, ';
    strSQL := strSQL + '  SUM(DET_QTDITE - DET_QTDROM) DET_QTDTMP, ';
    strSQL := strSQL + '  SUM(DET_QTDITE)              DET_QTDTOT, ';
    strSQL := strSQL + '  SUM(DET_QTDITE)              DET_QTDTOT_REAL, ';
  End;

  strSQL := strSQL + '  DET_UNITAR, ';
  strSQL := strSQL + '  DET_DESESP, ';
  strSQL := strSQL + '  NOTDET.AUTOINCREM DET_AUTINC, ';
  strSQL := strSQL + '  " " AS DET_INFITE, ';
  strSQL := strSQL + '  "N" AS DET_SEPIMP, ';
  strSQL := strSQL + '  DET_NUMLOT, ';
  strSQL := strSQL + '  "C" DET_TIP_FC,  ';
  strSQL := strSQL + '  DET_CODCLI,      ';

  If fUsaRomaneioDocsExpedidos Then
    strSQL := strSQL + '  SUM((DET_TOTPES / DET_QTDITE) * (COALESCE(DET_QTDEXP, 0) - COALESCE(DET_QTDROM, 0))) AS DET_TOTPES, '
  Else
    strSQL := strSQL + '  SUM(DET_TOTPES) AS DET_TOTPES, ';

  strSQL := strSQL + '  IF(LEFT(DET_CLAFIS,1) >= "5", "S", "E") DET_ENTSAI, ';
  strSQL := strSQL + '  DET_TURENT AS TURENT, ';
  strSQL := strSQL + '  UNI_SIGUNI AS DET_UNIDAD, ';
  strSQL := strSQL + '  SUM(DET_TOTPES) AS DET_VLTOPE ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  NOTDET ';
  strSQL := strSQL + '  JOIN CADITE I ON ITE_CODITE = DET_CODITE ';
  strSQL := strSQL + '  JOIN NOTTRI   ON NOTDET.AUTOINCREM = NOTTRI.DET_SEQGER ';
  strSQL := strSQL + '  LEFT JOIN CADUNI ON NOTDET.DET_UNIDAD = CADUNI.UNI_CODUNI ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_CODITE <> :ITESER AND ';
  strSQL := strSQL + '  DET_CODITE <> :SERTER AND ';

  If (AEspDoc = 'TR') Then
  Begin
    If (AEntSai = 'E') Then
      strSQL := strSQL + '  LEFT(DET_CLAFIS, 1) < 5 AND '
    Else
      strSQL := strSQL + '  LEFT(DET_CLAFIS, 1) >= 5 AND ';
  End;

  If (fCfgSis('EFTEST') = '2') And (fCfgSis('EFTESE') = '1') Then
    strSQL := strSQL + '  DET_PROEMB <> "S" AND ';

  strSQL := strSQL + '  RIGHT(DET_CLAFIS, 3) <> "999" AND ';
  strSQL := strSQL + '  DET_TIP_FC = "C" AND ';
  strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  DET_CODEMP = :CODEMP ';

  strSQL := strSQL + 'GROUP BY ';
  strSQL := strSQL + '  DET_CODITE, DET_DESCRI, IFNULL(DET_NUMLOT, "") ';

  Result := strSQL;
end;

function TfrmFatManutRomaneio.fAtualizaDocumentos(ANumDoc, AEspDoc, ACodEmp,
  ACodCLi, ANumRom, AFgoDocs, AGerDocs: string; AValSel: Double): Boolean;
var
  qryDocs: TUniQuery;
  strUPDGerVal,
  strUPDGer,
  strUPDFgoVal,
  strUPDFgo: string;
begin
  qryDocs := fCriaQuery;

  try
    Result := False;

    strUPDFgo := '';
    strUPDFgo := strUPDFgo + 'UPDATE ';
    strUPDFgo := strUPDFgo + '  FATGOR G  ';
    strUPDFgo := strUPDFgo + 'SET ';
    strUPDFgo := strUPDFgo + '  G.FGO_DTAROM = ' + fCurrentDate + ', ';
    strUPDFgo := strUPDFgo + '  G.FGO_HORROM = ' + fCurrentTime + ', ';
    strUPDFgo := strUPDFgo + '  G.FGO_OPEROM = :OPEROM, ';
    strUPDFgo := strUPDFgo + '  G.FGO_NUMROM = :NUMROM, ';
    strUPDFgo := strUPDFgo + '  G.FGO_EMPROM = :EMPROM, ';
    strUPDFgo := strUPDFgo + '  G.FGO_PRVIMP = "N" ';
    strUPDFgo := strUPDFgo + 'WHERE ';
    strUPDFgo := strUPDFgo + '  G.AUTOINCREM IN (' + fListaAutIncGer(AFgoDocs, 'FATDOR') + ') AND ';
    strUPDFgo := strUPDFgo + '  (SELECT  ';
    strUPDFgo := strUPDFgo + '    FORMAT(SUM(IFNULL(D.FDO_QTDROM, 0)), 4)';
    strUPDFgo := strUPDFgo + '   FROM ';
    strUPDFgo := strUPDFgo + '    FATDOR D ';
    strUPDFgo := strUPDFgo + '   WHERE ';
    strUPDFgo := strUPDFgo + '    D.FDO_SEQGER = G.AUTOINCREM) ';
    strUPDFgo := strUPDFgo + '    ';
    strUPDFgo := strUPDFgo + '  = ';
    strUPDFgo := strUPDFgo + '    ';
    strUPDFgo := strUPDFgo + '  (SELECT  ';
    strUPDFgo := strUPDFgo + '    FORMAT(SUM(D.FDO_QTDITE), 4)';
    strUPDFgo := strUPDFgo + '   FROM ';
    strUPDFgo := strUPDFgo + '    FATDOR D ';
    strUPDFgo := strUPDFgo + '   WHERE ';
    strUPDFgo := strUPDFgo + '    D.FDO_SEQGER = G.AUTOINCREM) ';

    strUPDFgoVal := '';
    strUPDFgoVal := strUPDFgoVal + 'UPDATE ';
    strUPDFgoVal := strUPDFgoVal + '  FATGOR ';
    strUPDFgoVal := strUPDFgoVal + 'SET ';
    strUPDFgoVal := strUPDFgoVal + '  FGO_VALROM = FGO_VALROM + :VALROM ';
    strUPDFgoVal := strUPDFgoVal + 'WHERE ';
    strUPDFgoVal := strUPDFgoVal + ' (FGO_NUMDOC = ' + QuotedStr(ANumDoc) + ' AND ';
    strUPDFgoVal := strUPDFgoVal + '  FGO_ESPDOC = ' + QuotedStr(AEspDoc) + ' AND ';
    strUPDFgoVal := strUPDFgoVal + '  FGO_CODCLI = ' + QuotedStr(ACodCLi) + ' AND ';
    strUPDFgoVal := strUPDFgoVal + '  FGO_CODEMP = ' + QuotedStr(ACodEmp) + ') ';

    strUPDGer := '';
    strUPDGer := strUPDGer + 'UPDATE ';
    strUPDGer := strUPDGer + '  MOVGER G ';
    strUPDGer := strUPDGer + 'SET ';
    strUPDGer := strUPDGer + '  G.GER_DTAROM = ' + fCurrentDate + ', ';
    strUPDGer := strUPDGer + '  G.GER_HORROM = ' + fCurrentTime + ', ';
    strUPDGer := strUPDGer + '  G.GER_OPEROM = :OPEROM, ';
    strUPDGer := strUPDGer + '  G.GER_NUMROM = :NUMROM, ';
    strUPDGer := strUPDGer + '  G.GER_EMPROM = :EMPROM, ';
    strUPDGer := strUPDGer + '  G.GER_PRVIMP = "N" ';
    strUPDGer := strUPDGer + 'WHERE ';
    strUPDGer := strUPDGer + '  G.AUTOINCREM IN (' + fListaAutIncGer(AGerDocs, 'MOVDET') + ') AND ';
    strUPDGer := strUPDGer + '  (SELECT ';
    strUPDGer := strUPDGer + '    FORMAT(SUM(D.DET_QTDROM), 4) ';
    strUPDGer := strUPDGer + '   FROM ';
    strUPDGer := strUPDGer + '     MOVDET D ';
    strUPDGer := strUPDGer + '   WHERE ';
    strUPDGer := strUPDGer + '    LEFT(D.DET_CLAFIS, 1) >= 5 AND ';
    strUPDGer := strUPDGer + '    RIGHT(D.DET_CLAFIS, 3) <> "999" AND ';

    If (fCfgSis('EFTEST') = '2') And (fCfgSis('EFTESE') = '1') Then
      strUPDGer := strUPDGer + '    D.DET_PROEMB <> "S" AND ';

    strUPDGer := strUPDGer + '    D.DET_SEQGER = G.AUTOINCREM) ';
    strUPDGer := strUPDGer + '     ';
    strUPDGer := strUPDGer + '   = ';
    strUPDGer := strUPDGer + '     ';
    strUPDGer := strUPDGer + '  (SELECT ';
    strUPDGer := strUPDGer + '    FORMAT(SUM(D.DET_QTDITE), 4) ';
    strUPDGer := strUPDGer + '   FROM ';
    strUPDGer := strUPDGer + '    MOVDET D ';
    strUPDGer := strUPDGer + '   WHERE ';
    strUPDGer := strUPDGer + '    LEFT(D.DET_CLAFIS, 1) >= 5 AND ';
    strUPDGer := strUPDGer + '    RIGHT(D.DET_CLAFIS, 3) <> "999" AND ';

    If (fCfgSis('EFTEST') = '2') And (fCfgSis('EFTESE') = '1') Then
      strUPDGer := strUPDGer + '    D.DET_PROEMB <> "S" AND ';

    strUPDGer := strUPDGer + '    D.DET_SEQGER = G.AUTOINCREM) ';

    strUPDGerVal := '';
    strUPDGerVal := strUPDGerVal + 'UPDATE ';
    strUPDGerVal := strUPDGerVal + '  MOVGER ';
    strUPDGerVal := strUPDGerVal + 'SET ';
    strUPDGerVal := strUPDGerVal + '  GER_VALROM = GER_VALROM + :VALROM ';
    strUPDGerVal := strUPDGerVal + 'WHERE ';
    strUPDGerVal := strUPDGerVal + ' (GER_NUMDOC = ' + QuotedStr(ANumDoc) + ' AND ';
    strUPDGerVal := strUPDGerVal + '  GER_ESPDOC = ' + QuotedStr(AEspDoc) + ' AND ';
    strUPDGerVal := strUPDGerVal + '  GER_CODEMP = ' + QuotedStr(ACodEmp) + ' AND ';
    strUPDGerVal := strUPDGerVal + '  GER_CODCLI = ' + QuotedStr(ACodCLi) + ') ';

    if not fEmptyStr(AFgoDocs) then
    begin
      qryDocs.Close;
      qryDocs.SQL.Clear;
      qryDocs.SQL.Add(strUPDFgo);
      qryDocs.ParamByName('OPEROM').AsString := strLoginUsuarioLogado;
      qryDocs.ParamByName('NUMROM').AsString := ANumRom;
      qryDocs.ParamByName('EMPROM').AsString := VS_strCodEmp;
      qryDocs.ExecSQL;

      qryDocs.Close;
      qryDocs.SQL.Clear;
      qryDocs.SQL.Add(strUPDFgoVal);
      qryDocs.ParamByName('VALROM').AsFloat := AValSel;
      qryDocs.ExecSQL;
    end;

    if not fEmptyStr(AGerDocs) then
    begin
      qryDocs.Close;
      qryDocs.SQL.Clear;
      qryDocs.SQL.Add(strUPDGer);
      qryDocs.ParamByName('OPEROM').AsString := strLoginUsuarioLogado;
      qryDocs.ParamByName('NUMROM').AsString := ANumRom;
      qryDocs.ParamByName('EMPROM').AsString := VS_strCodEmp;
      qryDocs.ExecSQL;

      qryDocs.Close;
      qryDocs.SQL.Clear;
      qryDocs.SQL.Add(strUPDGerVal);
      qryDocs.ParamByName('VALROM').AsFloat := AValSel;
      qryDocs.ExecSQL;

      strUPDGer := AnsiReplaceStr(strUPDGer, 'MOVGER', 'NOTGER');
      strUPDGer := AnsiReplaceStr(strUPDGer, 'MOVDET', 'NOTDET');

      strUPDGerVal := AnsiReplaceStr(strUPDGerVal, 'MOVGER', 'NOTGER');

      qryDocs.Close;
      qryDocs.SQL.Clear;
      qryDocs.SQL.Add(strUPDGer);
      qryDocs.ParamByName('OPEROM').AsString := strLoginUsuarioLogado;
      qryDocs.ParamByName('NUMROM').AsString := ANumRom;
      qryDocs.ParamByName('EMPROM').AsString := VS_strCodEmp;
      qryDocs.ExecSQL;

      qryDocs.Close;
      qryDocs.SQL.Clear;
      qryDocs.SQL.Add(strUPDGerVal);
      qryDocs.ParamByName('VALROM').AsFloat := AValSel;
      qryDocs.ExecSQL;
    end;

    Result := True;
  finally
    FreeAndNil(qryDocs);
  end;
end;

function TfrmFatManutRomaneio.fAtualizaQtdBaiDet(strNumDoc, strEspDoc,
  strCodCli, strCodEmp: String; blnPedOrc: Boolean; strNumRom, strNomTab,
  strAutInc, strEntSai, strClaFis: String): Boolean;
Var
  cdsTmp : TUniClientDataSet;
  strIndice : String;
  strTabelaMovDet : String;
  strTabelaMovDetTri: String;
  blnDocTemItemRepetido: Boolean;
begin
  Result := True;
  cdsTmp := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsTmp, cdsRomDet);

  Try
    blnDocTemItemRepetido := fDocumentoTemItemRepetido(strNomTab, strNumDoc, strEspDoc, strCodEmp);

    If (Pos(strOpcRom, '34') <= 0) Then
      strTabelaMovDet := fRetTabelaDet(strNomTab)
    Else
    Begin
      strTabelaMovDet := AnsiReplaceStr(strNomTab, 'GER', 'DET');
    End;

    strTabelaMovDetTri := AnsiReplaceStr(strTabelaMovDet, 'DET', 'TRI');

    cdsTmp.Filter   := '';
    cdsTmp.Filtered := False;
    cdsTmp.EmptyDataSet;

    strIndice := 'DET_CODITE;DET_DESITE;DET_NUMLOT';

    if fAgrupaPorAutoIncrem(strClaFis, blnDocTemItemRepetido) then
      strIndice := strIndice + ';DET_AUTINC';

    cdsTmp.IndexFieldNames := strIndice;

    pAtualizaQtdBaiDetGeral(strNumDoc, strEspDoc, strCodEmp, strCodCli, strTabelaMovDet,
                            blnUsaPreRom, cdsRomDet, cdsTmp, strClaFis, blnDocTemItemRepetido);

    cdsTmp.First;
    While (Not cdsTmp.Eof) Do
    Begin

      If (cdsTmp.FieldByName('DET_QTDBAI').AsFloat <= 0) Then
      Begin
        cdsTmp.Next;
        Continue;
      End;

      If ((Pos(strOpcRom, '234') > 0) And (Not blnPedOrc)) Or (Not blnPedOrc) Then
      Begin
        Result := fAtualizaQtdBaiDetOpcRom_234(strNumDoc, strEspDoc, strCodCli, strCodEmp, strNumRom, strAutInc,
                                               strTabelaMovDet, strTabelaMovDetTri, cdsTmp);
      End
      Else
      Begin
        Result := fAtualizaQtdBaiDetOpcRom_15(strNumDoc, strEspDoc, strCodCli, strCodEmp, strNumRom, strAutInc, cdsTmp);
      End;

      If (Not Result) Then
        Break;

      cdsTmp.Next;
    End;

  Finally
    FreeAndNil(cdsTmp);
  End;
end;

function TfrmFatManutRomaneio.fAtualizaQtdBaiDetOpcRom_15(strNumDoc, strEspDoc,
  strCodCli, strCodEmp, strNumRom, strAutInc: string;
  var cdsTmp: TUniClientDataSet): Boolean;
var
  qryUpDate: TUniQuery;
  qryDet: TUniQuery;
  strSQL: string;
  fltVolume: DOuble;
  fltTotPes: Double;
  fltPesLiq: Double;
  fltQtdIte: Double;
  fltQtdBai: Double;
begin
  qryUpDate := fCriaQuery;
  qryDet := fCriaQuery;

  try
    Result := False;

    strSQL := '';
    strSQL := strSQL + 'UPDATE  ';
    strSQL := strSQL + '  FATDOR ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  FDO_QTDROM = IFNULL(FDO_QTDROM, 0) + :QTDROM ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  AUTOINCREM = :AUTINC AND ';
    strSQL := strSQL + '  FDO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FDO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  FDO_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  FDO_CODEMP = :CODEMP ';

    qryDet.Close;
    qryDet.SQL.Clear;
    qryDet.SQL.Add(' SELECT FATDOR.*, EXTDOR.FDO_PESLIQ, ');
    qryDet.SQL.Add(fSqlValoresReformaTributariaRomaneio('FATDOR', 'FATDOR'));
    qryDet.SQL.Add('   FROM FATDOR ');
    qryDet.SQL.Add('   LEFT JOIN EXTDOR ON FDO_SEQFDO = AUTOINCREM ');
    qryDet.SQL.Add('  WHERE AUTOINCREM = :AUTINC ');
    qryDet.SQL.Add('    AND FDO_NUMDOC = :NUMDOC ');
    qryDet.SQL.Add('    AND FDO_ESPDOC = :ESPDOC ');
    qryDet.SQL.Add('    AND FDO_CODCLI = :CODCLI ');
    qryDet.SQL.Add('    AND FDO_CODEMP = :CODEMP ');
    qryDet.ParamByName('AUTINC').AsString := cdsTmp.FieldByName('DET_AUTINC').AsString;
    qryDet.ParamByName('NUMDOC').AsString := strNumDoc;
    qryDet.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDet.ParamByName('CODCLI').AsString := strCodCli;
    qryDet.ParamByName('CODEMP').AsString := strCodEmp;
    qryDet.Open;

    qryUpDate.Close;
    qryUpDate.SQL.Clear;
    qryUpDate.SQL.Add(strSQL);
    qryUpDate.ParamByName('QTDROM').AsFloat  := cdsTmp.FieldByName('DET_QTDBAI').AsFloat;
    qryUpDate.ParamByName('AUTINC').AsString := cdsTmp.FieldByName('DET_AUTINC').AsString;
    qryUpDate.ParamByName('NUMDOC').AsString := strNumDoc;
    qryUpDate.ParamByName('ESPDOC').AsString := strEspDoc;
    qryUpDate.ParamByName('CODCLI').AsString := strCodCli;
    qryUpDate.ParamByName('CODEMP').AsString := strCodEmp;
    qryUpDate.ExecSQL;
    qryUpDate.Close;

    If fQtdeRomInvalido(cdsTmp.FieldByName('DET_CODITE').AsString, strNumDoc, strEspDoc, strCodCli, strCodEmp, 'FATDOR') Then
    Begin
      Result := False;
      Exit;
    End;

    {***********************************************}
    {* SE ENTRA TROCA E BRINDE NO ROMANEIO EXECUTA *}
    {* UPDATE DO QTDROM NA MOVDET TAMBÉM          *}
    {********************************************AL*}
    If (fCfgSis('TRBRRO', varBoolean)) Then
    Begin
      strSQL := AnsiReplaceStr(AnsiReplaceStr(strSQL, 'FATDOR', 'MOVDET'), 'FDO_', 'DET_');

      qryUpDate.SQL.Clear;
      qryUpDate.SQL.Add(strSQL);
      qryUpDate.ParamByName('QTDROM').AsFloat  := cdsTmp.FieldByName('DET_QTDBAI').AsFloat;
      qryUpDate.ParamByName('AUTINC').AsString := cdsTmp.FieldByName('DET_AUTINC').AsString;
      qryUpDate.ParamByName('NUMDOC').AsString := strNumDoc;
      qryUpDate.ParamByName('ESPDOC').AsString := strEspDoc;
      qryUpDate.ParamByName('CODCLI').AsString := strCodCli;
      qryUpDate.ParamByName('CODEMP').AsString := strCodEmp;
      qryUpDate.ExecSQL;
    End;

    fltTotPes := qryDet.FieldByName('FDO_TOTPES').AsFloat / qryDet.FieldByName('FDO_QTDITE').AsFloat * cdsTmp.FieldByName('DET_QTDBAI').AsFloat;
    fltPesLiq := qryDet.FieldByName('FDO_PESLIQ').AsFloat / qryDet.FieldByName('FDO_QTDITE').AsFloat * cdsTmp.FieldByName('DET_QTDBAI').AsFloat;

    if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
    begin
      fltQtdIte := cdsTmp.FieldByName('DET_QTDBAI').AsFloat;
      fltQtdBai := 0;
    end
    else
    begin
      fltQtdIte := cdsTmp.FieldByName('DET_QTDITE').AsFloat;
      fltQtdBai := cdsTmp.FieldByName('DET_QTDBAI').AsFloat;
    end;

    fltVolume := fRetVolumeItem(qryDet.FieldByName('FDO_CODITE').AsString, fltQtdIte);

    Result := fGravaRomDet(strNumRom,                                   // Romaneio
                           strAutInc,                                   // Sequencial do Arquivo Geral
                           qryDet.FieldByName('FDO_NUMDOC').AsString,   // Numero do Documento
                           qryDet.FieldByName('FDO_ESPDOC').AsString,   // Espécie
                           qryDet.FieldByName('FDO_CODEMP').AsString,   // Empresa
                           qryDet.FieldByName('FDO_CODITE').AsString,   // Cód. Item
                           qryDet.FieldByName('FDO_CODVEN').AsString,   // Vendedor
                           qryDet.FieldByName('FDO_CODDIV').AsString,   // Código Diversos
                           qryDet.FieldByName('FDO_CODMAR').AsString,   // Código da Marca
                           '',                                          // Fornecedor
                           qryDet.FieldByName('FDO_CODCLI').AsString,   // Cliente
                           qryDet.FieldByName('FDO_DTAENT').AsDateTime, // Data da Entrada
                           qryDet.FieldByName('FDO_HORENT').AsDateTime, // Hora da Entrada
                           0,                                           // Data do Documento
                           qryDet.FieldByName('FDO_CONPAG').AsString,   // Condição de Pagamento
                           'C',                                         // Tipo: (C)liente / (F) Fornecedor
                           '',                                          // Estado do Fornecedor
                           qryDet.FieldByName('FDO_DESCRI').AsString,   // Descrição do Item
                           qryDet.FieldByName('FDO_REFERE').AsString,   // Referência do Item
                           qryDet.FieldByName('FDO_UNIDAD').AsString,   // Cód. Unidade
                           qryDet.FieldByName('FDO_FORITE').AsString,   // Fornecedor Item
                           fltQtdIte,                                   // Quantidade do Item
                           qryDet.FieldByName('FDO_UNITAR').AsFloat,    // Valor Unitario
                           qryDet.FieldByName('FDO_UNIORI').AsFloat,    // Valor Unitário Original
                           fFormataFloat(cdsTmp.FieldByName('DET_UNITAR').AsFloat * cdsTmp.FieldByName('DET_QTDBAI').AsFloat, 2), // Total do Item
                           qryDet.FieldByName('FDO_VLRCON').AsFloat,    // Valor Contábil do Item
                           qryDet.FieldByName('FDO_TOTCUS').AsFloat,    // Valor Total de Custo
                           qryDet.FieldByName('FDO_TOTMED').AsFloat,    // Valor Total Medio
                           qryDet.FieldByName('FDO_DESCON').AsFloat,    // % Desconto do Item
                           qryDet.FieldByName('FDO_TOTFRE').AsFloat,    // Valor do Frete
                           qryDet.FieldByName('FDO_DESESP').AsFloat,    // Valor do Desconto Especial
                           qryDet.FieldByName('FDO_CODREP').AsString,   // Código do Representante
                           qryDet.FieldByName('FDO_PERCOM').AsFloat,    // Percentual de Comissão do Vendedor
                           qryDet.FieldByName('FDO_TOTCOM').AsFloat,    // Total de Comissão do Vendedor
                           qryDet.FieldByName('FDO_CLAFIS').AsString,   // Classificação Fiscal
                           qryDet.FieldByName('FDO_CODFIS').AsString,   // Código Fiscal
                           qryDet.FieldByName('FDO_VALIPI').AsFloat,    // Valor IPI
                           qryDet.FieldByName('FDO_ALQIPI').AsFloat,    // Aliquota IPI
                           qryDet.FieldByName('FDO_BASIPI').AsFloat,    // Base IPI
                           qryDet.FieldByName('FDO_VALICM').AsFloat,    // Valor de ICMS
                           qryDet.FieldByName('FDO_ALQICM').AsFloat,    // Aliquota de ICMS
                           qryDet.FieldByName('FDO_BASICM').AsFloat,    // Base de ICMS
                           qryDet.FieldByName('FDO_VALRET').AsFloat,    // Valor de Substituição
                           qryDet.FieldByName('FDO_ALQRET').AsFloat,    // Aliquota de Substituição
                           qryDet.FieldByName('FDO_BASRET').AsFloat,    // Base de Substituição
                           fltTotPes,                                   // Total de Peso
                           qryDet.FieldByName('FDO_PERBAS').AsFloat,    // Percentual de Base de ICMS
                           qryDet.FieldByName('FDO_PERRED').AsFloat,    // Percentual de Redução de Base
                           IIF(qryDet.FieldByName('FDO_JAFATU').AsInteger = 1, True, False),  // Indica se ja esta Faturado
                           qryDet.FieldByName('FDO_TIPFAT').AsString,   // Tipo de Faturamento
                           qryDet.FieldByName('FDO_NUMFAT').AsString,   // Número do Faturamento
                           qryDet.FieldByName('FDO_DTAFAT').AsDateTime, // Data do Faturamento
                           qryDet.FieldByName('FDO_VENFAT').AsString,   // Vendedor do Faturamento
                           qryDet.FieldByName('FDO_CNDFAT').AsString,   // Condição de Pagamento Faturamento
                           qryDet.FieldByName('FDO_VALFAT').AsFloat,    // Valor do Faturamento
                           qryDet.FieldByName('FDO_IDEPRO').AsString,   // Identificação Produto ( Normal / Outros )
                           qryDet.FieldByName('FDO_INCPIS').AsString,   // Indice se incide Pis
                           qryDet.FieldByName('FDO_SERIE_').AsString,   // Série
                           qryDet.FieldByName('FDO_DESACE').AsFloat,    // Valor de Despesa Acessória
                           '',                                          // Nota Especial
                           '',                                          // Documento da Devolução
                           '',                                          // Espécie da Devolução
                           '',                                          // Empresa da Devolução
                           qryDet.FieldByName('FDO_ITECHA').AsString,   // Item de Chamada (TINTA DE MAQUINA)
                           qryDet.FieldByName('FDO_ITETIN').AsString,   // Item da Tinta (TINTA DE MAQUINA)
                           qryDet.FieldByName('FDO_DESCOR').AsString,   // Descrição da Cor (TINTA DE MAQUINA)
                           qryDet.FieldByName('FDO_TIPEMB').AsString,   // Tipo de Embalagem (TINTA DE MAQUINA)
                           qryDet.FieldByName('FDO_QTDEMB').AsFloat,    // Quantidade de Embalagem (TINTA DE MAQUINA)
                           qryDet.FieldByName('FDO_PREEMB').AsFloat,    // Preço da Embalagem (TINTA DE MAQUINA)
                           qryDet.FieldByName('FDO_TIPPRE').AsString,   // Tipo de Preço (TINTA DE MAQUINA)
                           qryDet.FieldByName('FDO_PRVTIN').AsFloat,    // Preço de Venda da Tinta (TINTA DE MAQUINA)
                           qryDet.FieldByName('FDO_PRCTIN').AsFloat,    // Preço de Compra da Tinta (TINTA DE MAQUINA)
                           qryDet.FieldByName('FDO_FATTIN').AsFloat,    // Fator da Tinta (TINTA DE MAQUINA)
                           qryDet.FieldByName('FDO_PROEMB').AsString,   // Produto Embalagem (TINTA DE MAQUINA)
                           qryDet.FieldByName('FDO_CODDIG').AsString,   // Código do Digitador
                           qryDet.FieldByName('FDO_CODCND').AsString,   // Codigo da Condição
                           qryDet.FieldByName('FDO_CODFPG').AsString,   // Forma de Pagamento
                           fltQtdBai,                                   // Quantidade de Baixa ********
                           cdsTmp.FieldByName('DET_INFITE').AsString,   // Informações do item ********
                           cdsTmp.FieldByName('DET_SEPIMP').AsString,   // Separacao Impressa (S/N)
                           cdsTmp.FieldByName('DET_AUTINC').AsString,   // Autoincremento do fatdor *******
                           qryDet.FieldByName('FDO_NUMLOT').AsString,   // NUMERO DO LOTE
                           fltPesLiq,                                   // Peso Liquido
                           fltVolume,
                           qryDet.FieldByName('REF_CBSVAL').AsFloat,    // Valor CBS
                           qryDet.FieldByName('REF_VALIBS').AsFloat,    // Valor IBS
                           qryDet.FieldByName('REF_SELVAL').AsFloat);   // Valor IS
  finally
    FreeAndNil(qryUpDate);
    FreeAndNil(qryDet);
  end;
end;

function TfrmFatManutRomaneio.fAtualizaQtdBaiDetOpcRom_234(strNumDoc, strEspDoc,
  strCodCli, strCodEmp, strNumRom, strAutInc, strTabelaMovDet,
  strTabelaMovDetTri: string; var cdsTmp: TUniClientDataSet): Boolean;
var
  qryUpDate: TUniQuery;
  qryDet: TUniQuery;
  strSQL: string;
  strQtdBai: string;
  dtaDtaDoc: TDate;
  blnJaFatu: Boolean;
  fltVolume: Double;
begin
  qryUpDate := fCriaQuery;
  qryDet := fCriaQuery;

  try
    Result := False;

    strQtdBai := AnsiReplaceStr(FloatToStr(cdsTmp.FieldByName('DET_QTDBAI').AsFloat), ',', '.');

    qryDet.Close;
    qryDet.SQL.Clear;
    qryDet.SQL.Add(' SELECT ');
    qryDet.SQL.Add('   ((DET_VLRCON / DET_QTDITE) * ' + strQtdBai + ') AS DET_VLRCON, ');
    qryDet.SQL.Add('   ((DET_TOTCUS / DET_QTDITE) * ' + strQtdBai + ') AS DET_TOTCUS, ');
    qryDet.SQL.Add('   ((DET_TOTMED / DET_QTDITE) * ' + strQtdBai + ') AS DET_TOTMED, ');
    qryDet.SQL.Add('   ((DET_TOTFRE / DET_QTDITE) * ' + strQtdBai + ') AS DET_TOTFRE, ');
    qryDet.SQL.Add('   ((DET_DESESP / DET_QTDITE) * ' + strQtdBai + ') AS DET_DESESP, ');
    qryDet.SQL.Add('   ((DET_VALIPI / DET_QTDITE) * ' + strQtdBai + ') AS DET_VALIPI, ');
    qryDet.SQL.Add('   ((DET_BASIPI / DET_QTDITE) * ' + strQtdBai + ') AS DET_BASIPI, ');
    qryDet.SQL.Add('   ((DET_VALICM / DET_QTDITE) * ' + strQtdBai + ') AS DET_VALICM, ');
    qryDet.SQL.Add('   ((DET_BASICM / DET_QTDITE) * ' + strQtdBai + ') AS DET_BASICM, ');
    qryDet.SQL.Add('   ((DET_VALRET / DET_QTDITE) * ' + strQtdBai + ') AS DET_VALRET, ');
    qryDet.SQL.Add('   ((DET_BASRET / DET_QTDITE) * ' + strQtdBai + ') AS DET_BASRET, ');
    qryDet.SQL.Add('   ((DET_TOTPES / DET_QTDITE) * ' + strQtdBai + ') AS DET_TOTPES, ');
    qryDet.SQL.Add('   ((DET_PESLIQ / DET_QTDITE) * ' + strQtdBai + ') AS DET_PESLIQ, ');
    qryDet.SQL.Add('   ((DET_DESACE / DET_QTDITE) * ' + strQtdBai + ') AS DET_DESACE, ');
    qryDet.SQL.Add(fSqlValoresReformaTributariaRomaneio(strTabelaMovDet, strTabelaMovDet, ' / ' + strTabelaMovDet + '.DET_QTDITE * ' + strQtdBai) + ', ');
    qryDet.SQL.Add(strTabelaMovDet + '.* ');
    qryDet.SQL.Add('   FROM ' + strTabelaMovDet);
    qryDet.SQL.Add('   LEFT JOIN  ' + strTabelaMovDetTri + ' ON ' + strTabelaMovDet + '.AUTOINCREM = ' + strTabelaMovDetTri + '.DET_SEQGER');
    qryDet.SQL.Add('  WHERE AUTOINCREM = :AUTINC ');
    qryDet.SQL.Add('    AND DET_NUMDOC = :NUMDOC ');
    qryDet.SQL.Add('    AND DET_ESPDOC = :ESPDOC ');
    qryDet.SQL.Add('    AND DET_CODCLI = :CODCLI ');
    qryDet.SQL.Add('    AND DET_CODEMP = :CODEMP ');
    qryDet.ParamByName('AUTINC').AsString := cdsTmp.FieldByName('DET_AUTINC').AsString;
    qryDet.ParamByName('NUMDOC').AsString := strNumDoc;
    qryDet.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDet.ParamByName('CODCLI').AsString := strCodCli;
    qryDet.ParamByName('CODEMP').AsString := strCodEmp;
    qryDet.Open;

    strSQL := '';
    strSQL := strSQL + 'UPDATE  ';
    strSQL := strSQL + '  ' + strTabelaMovDet + ' ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  DET_QTDROM = DET_QTDROM + :QTDROM ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  AUTOINCREM = :AUTINC AND ';
    strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  DET_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  DET_CODEMP = :CODEMP ';

    qryUpDate.Close;
    qryUpDate.SQL.Clear;
    qryUpDate.SQL.Add(strSQL);
    qryUpDate.ParamByName('QTDROM').AsFloat  := cdsTmp.FieldByName('DET_QTDBAI').AsFloat;
    qryUpDate.ParamByName('AUTINC').AsString := cdsTmp.FieldByName('DET_AUTINC').AsString;
    qryUpDate.ParamByName('NUMDOC').AsString := strNumDoc;
    qryUpDate.ParamByName('ESPDOC').AsString := strEspDoc;
    qryUpDate.ParamByName('CODCLI').AsString := strCodCli;
    qryUpDate.ParamByName('CODEMP').AsString := strCodEmp;
    qryUpDate.ExecSQL;

    If fQtdeRomInvalido(cdsTmp.FieldByName('DET_CODITE').AsString, strNumDoc, strEspDoc, strCodCli, strCodEmp, strTabelaMovDet) Then
    Begin
      Result := False;
      Exit;
    End;

    If strOpcRom = '2' Then
      dtaDtaDoc := qryDet.FieldByName('DET_DTADOC').AsDateTime
    Else
      dtaDtaDoc := qryDet.FieldByName('DET_DTAENT').AsDateTime;

    If qryDet.FieldByName('DET_JAFATU').DataType = ftInteger Then
      blnJaFatu := IIF(qryDet.FieldByName('DET_JAFATU').AsInteger = 1, True, False)
    Else
      blnJaFatu := qryDet.FieldByName('DET_JAFATU').AsBoolean;

    fltVolume := fRetVolumeItem(qryDet.FieldByName('DET_CODITE').AsString, cdsTmp.FieldByName('DET_QTDITE').AsFloat);

    Result := fGravaRomDet(strNumRom,                                   // Romaneio
                           strAutInc,                                   // Sequencial do Arquivo Geral
                           qryDet.FieldByName('DET_NUMDOC').AsString,   // Numero do Documento
                           qryDet.FieldByName('DET_ESPDOC').AsString,   // Espécie
                           qryDet.FieldByName('DET_CODEMP').AsString,   // Empresa
                           qryDet.FieldByName('DET_CODITE').AsString,   // Cód. Item
                           qryDet.FieldByName('DET_CODVEN').AsString,   // Vendedor
                           qryDet.FieldByName('DET_CODDIV').AsString,   // Código Diversos
                           qryDet.FieldByName('DET_CODMAR').AsString,   // Código da Marca
                           qryDet.FieldByName('DET_CODFOR').AsString,   // Fornecedor
                           qryDet.FieldByName('DET_CODCLI').AsString,   // Cliente
                           qryDet.FieldByName('DET_DTAENT').AsDateTime, // Data da Entrada
                           qryDet.FieldByName('DET_HORENT').AsDateTime, // Hora da Entrada
                           dtaDtaDoc,                                   // Data do Documento
                           qryDet.FieldByName('DET_CONPAG').AsString,   // Condição de Pagamento
                           qryDet.FieldByName('DET_TIP_FC').AsString,   // Tipo: (C)liente / (F) Fornecedor
                           qryDet.FieldByName('DET_ESTADO').AsString,   // Estado do Fornecedor
                           qryDet.FieldByName('DET_DESCRI').AsString,   // Descrição do Item
                           qryDet.FieldByName('DET_REFERE').AsString,   // Referência do Item
                           qryDet.FieldByName('DET_UNIDAD').AsString,   // Cód. Unidade
                           qryDet.FieldByName('DET_FORITE').AsString,   // Fornecedor Item
                           cdsTmp.FieldByName('DET_QTDITE').AsFloat,    // Quantidade do Item
                           qryDet.FieldByName('DET_UNITAR').AsFloat,    // Valor Unitario
                           qryDet.FieldByName('DET_UNIORI').AsFloat,    // Valor Unitário Original
                           fFormataFloat(cdsTmp.FieldByName('DET_UNITAR').AsFloat * cdsTmp.FieldByName('DET_QTDBAI').AsFloat, 2), // Total do Item
                           qryDet.FieldByName('DET_VLRCON').AsFloat,    // Valor Contábil do Item
                           qryDet.FieldByName('DET_TOTCUS').AsFloat,    // Valor Total de Custo
                           qryDet.FieldByName('DET_TOTMED').AsFloat,    // Valor Total Medio
                           qryDet.FieldByName('DET_DESCON').AsFloat,    // % Desconto do Item
                           qryDet.FieldByName('DET_TOTFRE').AsFloat,    // Valor do Frete
                           qryDet.FieldByName('DET_DESESP').AsFloat,    // Valor do Desconto Especial
                           qryDet.FieldByName('DET_CODREP').AsString,   // Código do Representante
                           qryDet.FieldByName('DET_PERCOM').AsFloat,    // Percentual de Comissão do Vendedor
                           qryDet.FieldByName('DET_TOTCOM').AsFloat,    // Total de Comissão do Vendedor
                           qryDet.FieldByName('DET_CLAFIS').AsString,   // Classificação Fiscal
                           qryDet.FieldByName('DET_CODFIS').AsString,   // Código Fiscal
                           qryDet.FieldByName('DET_VALIPI').AsFloat,    // Valor IPI
                           qryDet.FieldByName('DET_ALQIPI').AsFloat,    // Aliquota IPI
                           qryDet.FieldByName('DET_BASIPI').AsFloat,    // Base IPI
                           qryDet.FieldByName('DET_VALICM').AsFloat,    // Valor de ICMS
                           qryDet.FieldByName('DET_ALQICM').AsFloat,    // Aliquota de ICMS
                           qryDet.FieldByName('DET_BASICM').AsFloat,    // Base de ICMS
                           qryDet.FieldByName('DET_VALRET').AsFloat,    // Valor de Substituição
                           qryDet.FieldByName('DET_ALQRET').AsFloat,    // Aliquota de Substituição
                           qryDet.FieldByName('DET_BASRET').AsFloat,    // Base de Substituição
                           qryDet.FieldByName('DET_TOTPES').AsFloat,    // Total de Peso
                           qryDet.FieldByName('DET_PERBAS').AsFloat,    // Percentual de Base de ICMS
                           qryDet.FieldByName('DET_PERRED').AsFloat,    // Percentual de Redução de Base
                           blnJaFatu,  // Indica se ja esta Faturado
                           qryDet.FieldByName('DET_TIPFAT').AsString,   // Tipo de Faturamento
                           qryDet.FieldByName('DET_NUMFAT').AsString,   // Número do Faturamento
                           qryDet.FieldByName('DET_DTAFAT').AsDateTime, // Data do Faturamento
                           qryDet.FieldByName('DET_VENFAT').AsString,   // Vendedor do Faturamento
                           qryDet.FieldByName('DET_CNDFAT').AsString,   // Condição de Pagamento Faturamento
                           qryDet.FieldByName('DET_VALFAT').AsFloat,    // Valor do Faturamento
                           qryDet.FieldByName('DET_IDEPRO').AsString,   // Identificação Produto ( Normal / Outros )
                           qryDet.FieldByName('DET_INCPIS').AsString,   // Indice se incide Pis
                           qryDet.FieldByName('DET_SERIE_').AsString,   // Série
                           qryDet.FieldByName('DET_DESACE').AsFloat,    // Valor de Despesa Acessória
                           qryDet.FieldByName('DET_NOTESP').AsString,   // Nota Especial
                           qryDet.FieldByName('DET_DOCDEV').AsString,   // Documento da Devolução
                           qryDet.FieldByName('DET_ESPDEV').AsString,   // Espécie da Devolução
                           qryDet.FieldByName('DET_EMPDEV').AsString,   // Empresa da Devolução
                           qryDet.FieldByName('DET_ITECHA').AsString,   // Item de Chamada (TINTA DE MAQUINA)
                           qryDet.FieldByName('DET_ITETIN').AsString,   // Item da Tinta (TINTA DE MAQUINA)
                           qryDet.FieldByName('DET_DESCOR').AsString,   // Descrição da Cor (TINTA DE MAQUINA)
                           qryDet.FieldByName('DET_TIPEMB').AsString,   // Tipo de Embalagem (TINTA DE MAQUINA)
                           qryDet.FieldByName('DET_QTDEMB').AsFloat,    // Quantidade de Embalagem (TINTA DE MAQUINA)
                           qryDet.FieldByName('DET_PREEMB').AsFloat,    // Preço da Embalagem (TINTA DE MAQUINA)
                           qryDet.FieldByName('DET_TIPPRE').AsString,   // Tipo de Preço (TINTA DE MAQUINA)
                           qryDet.FieldByName('DET_PRVTIN').AsFloat,    // Preço de Venda da Tinta (TINTA DE MAQUINA)
                           qryDet.FieldByName('DET_PRCTIN').AsFloat,    // Preço de Compra da Tinta (TINTA DE MAQUINA)
                           qryDet.FieldByName('DET_FATTIN').AsFloat,    // Fator da Tinta (TINTA DE MAQUINA)
                           qryDet.FieldByName('DET_PROEMB').AsString,   // Produto Embalagem (TINTA DE MAQUINA)
                           qryDet.FieldByName('DET_CODDIG').AsString,   // Código do Digitador
                           qryDet.FieldByName('DET_CODCND').AsString,   // Codigo da Condição
                           qryDet.FieldByName('DET_CODFPG').AsString,   // Forma de Pagamento
                           cdsTmp.FieldByName('DET_QTDBAI').AsFloat,    // Quantidade Baixada   ****
                           cdsTmp.FieldByName('DET_INFITE').AsString,   // Informações do item  ****
                           cdsTmp.FieldByName('DET_SEPIMP').AsString,   // Separacao Impressa (S/N)
                           cdsTmp.FieldByName('DET_AUTINC').AsString,   // Autoincremento do movdet ****
                           qryDet.FieldByName('DET_NUMLOT').AsString,   // NUMERO DO LOTE
                           qryDet.FieldByName('DET_PESLIQ').AsFloat,    // Peso liquido
                           fltVolume,
                           qryDet.FieldByName('REF_CBSVAL').AsFloat,    // Valor CBS
                           qryDet.FieldByName('REF_VALIBS').AsFloat,    // Valor IBS
                           qryDet.FieldByName('REF_SELVAL').AsFloat);   // Valor IS
  finally
    FreeAndNil(qryUpDate);
    FreeAndNil(qryDet);
  end;
end;

function TfrmFatManutRomaneio.fCarregaCadMot: Boolean;
begin
  If Not fEmptyStr(edtCodMot.Text) Then
  Begin
    if (fRetStatusMotorista(edtCodMot.Text) = 'I') Then
    Begin
      edtNomMot.Clear;
      Result := False;
      Exit;
    End
    Else
      edtNomMot.Text := fRetNomeMotorista(edtCodMot.Text);
  End
  Else
    edtNomMot.Clear;

  Result := True;
end;

procedure TfrmFatManutRomaneio.fCondicao(var AQry: TUniQuery);
var
  LEmpresas: string;
  LContador: integer;
begin
  LEmpresas := EmptyStr;

  if Length(arrEmpres) > 0 then
  begin
    for LContador := Low(arrEmpres) to High(arrEmpres) do
      pIncrementaListaStr(arrEmpres[LContador].strCodigo, LEmpresas, True);

    AQry.SQL.Add('AND R.GER_EMPROM IN ('+LEmpresas+')');
  end;


  if not fEmptyStr(mskDtaIni.Text) then
    if not fEmptyStr(mskDtaFin.Text) then
    begin
      AQry.SQL.Add('AND R.GER_DTAROM BETWEEN :DTAINI AND :DTAFIN');
      AQry.ParamByName('DTAINI').AsDate := StrToDate(mskDtaIni.Text);
      AQry.ParamByName('DTAFIN').AsDate := StrToDate(mskDtaFin.Text);
    end;

  if not fEmptyStr(edtNumRom.Text) then
  begin
    AQry.SQL.Add('AND R.GER_NUMROM = :NUMROM');
    AQry.ParamByName('NUMROM').AsString := edtNumRom.Text;
  end;

  if not fEmptyStr(edtCodMot.Text) then
  begin
    AQry.SQL.Add('AND R.GER_CODMOT = :CODMOT');
    AQry.ParamByName('CODMOT').AsString := edtCodMot.Text;
  end;

  If (Pos(strOpcRom,'1_5_') > 0) Then
    AQry.SQL.Add('AND R.GER_NOMTAB = "FATGOR"')
  Else
    AQry.SQL.Add('AND R.GER_NOMTAB = "MOVGER"');
end;

function TfrmFatManutRomaneio.fGeraRomaneio: Boolean;
begin
  cdsManut.DisableControls;

  try
    Result := False;

    FFgoRemov := EmptyStr;
    FGerRemov := EmptyStr;

    cdsManut.First;

    while not cdsManut.Eof do
    begin
      pRetornaDocumentos(FFgoRemov, FGerRemov, cdsManut);
      cdsManut.Next;
    end;

    Result := fSelecionaDocumentos(FFgoRemov, FGerRemov, '');
  finally
    cdsManut.EnableControls;
  end;
end;

function TfrmFatManutRomaneio.fGeraRomaneioClick(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    recDadosTranspMot : TDadosTranspMot;
begin
  Result := False;

  if not fIniciaMautencao then
    Exit;

  FillChar(recDadosTranspMot, SizeOf(recDadosTranspMot), #0);

  if not fPedeTelaTransportadora(recDadosTranspMot) then
    Exit;

  fStartTransaction;

  try
    if not fRemoveRomaneio Then
    begin
      fRollBack;
      Exit;
    end;

    pSetDadosTransportadoraMotorista(recDadosTranspMot);

    FNumRom := EmptyStr;

    FAcaoRomaneio := tpGerar;

    if fGeraRomaneio then
    begin
      fCommit;
      blnGravou := True;
      cdsManut.EmptyDataSet;
      pConsultaRomaneios;
      fMensagem('', 'Romaneio Nº ' + FNumRom + ' gerado com sucesso!', ['&Ok']);

      if not fEmptyStr(FNumRom) then
      begin
        if Assigned(prcExecutaRelatorio) then
          prcExecutaRelatorio(13, 1356, [1356, 1367],
                              ['NUMROM', 'EMPROM'],
                              [FNumRom, VS_strCodEmp],
                              nil);
      end;

      Result := True;
    end
    else
      fRollBack;

    FAcaoRomaneio := tpIndefinido;
  except
    On E: Exception DO
    begin
      fRollBack;
      pMensagensErro('Erro ao gerar novo documento: ' + E.Message, '[fGeraRomaneio]');
    end;
  end;
end;

function TfrmFatManutRomaneio.fGetCampo(ACampo: String): String;
begin
  If fUsaRomaneioDocsExpedidos Then
    Result := '(' + ACampo + ' / SUM(DET_QTDITE))'
  Else
    Result := ACampo;
end;

function TfrmFatManutRomaneio.fGravaRomaneio(qryMovGer: TUniQuery; strCodTra,
  strPlaVei, strCodMot, strNumBox, strCodAj1, strCodAj2, strCodAj3, strCodAj4, strObsFec, strCodReg: String;
  var strNumRom: String; strOpeSol, strEntSai: String; strFgoDocs, strGerDocs: String): Boolean;
Var
  strAutInc: String;

  strNumDoc: String;
  strEspDoc: String;
  strCodEmp: String;
  strCodVen: String;
  strCodFor: String;
  strCodCli: String;
  strTip_fc: String;
  dtaDtaEnt: TDateTime;
  dtaHorEnt: TDateTime;
  dtaDtaDoc: TDateTime;
  strConPag: String;
  strEstAdo: String;
  strNomCon: String;
  strEndCon: String;
  strBaiCon: String;
  strCepCon: String;
  strCidCon: String;
  strEstCon: String;
  strTelCon: String;
  strCgcCpf: String;
  strCgcCon: String;
  strIesCon: String;
  strR_gCon: String;
  strRomImp: String;
  fltBasSim: Double;
  fltBasIpi: Double;
  fltAlqIpi: Double;
  fltTotIpi: Double;
  fltBasIcm: Double;
  fltAlqIcm: Double;
  fltTotIcm: Double;
  fltTotRet: Double;
  fltAlqRet: Double;
  fltBasRet: Double;
  fltDesEsp: Double;
  fltVlrCon: Double;
  fltTotPro: Double;
  fltTotCus: Double;
  fltTotMed: Double;
  strTipFre: String;
  fltTotFre: Double;
  fltPesBru: Double;
  fltPesLiq: Double;
  fltVolUme: Double;
  strEspEci: String;
  strMarCa_: String;
  strMen001: String;
  strMen002: String;
  strTipFat: String;
  strNumFat: String;
  dtaDtaFat: TDateTime;
  strVenFat: String;
  strCndFat: String;
  fltValFat: Double;
  fltVpaR01: Double;
  fltVpaR02: Double;
  fltVpaR03: Double;
  fltVpaR04: Double;
  fltVpaR05: Double;
  fltVpaR06: Double;
  fltVpaR07: Double;
  fltVpaR08: Double;
  fltVpaR09: Double;
  fltVpaR10: Double;
  fltVpaR11: Double;
  fltVpaR12: Double;
  strSerIe_: String;
  strNotEsp: String;
  strClaFis: String;
  fltPorDes: Double;
  strCodDig: String;
  strCodCnd: String;
  strCodFpg: String;
  fltVlrOri: Double;
  blnPedOrc: Boolean;
  intOrdemI: Integer;

  strNumDocHis: String;
  strEspDocHis: String;
  strCodEmpHis: String;

  strTabelaMovDet: String;
  strAutEnt,
  strMsgExp,
  strPalet: String;
  strAutIncGer: String;

  strStatus: String;
  strNomTab: String;
  stlTmp: TStringList;

  strMenExp: String;
  strMenEx2: String;
  strMenEx3: String;
  strMenEx4: String;

  strNumPedTmp: String;
  strEmpPedTmp: String;

  prcScroll: TprcScroll;

  strLocali,
  strLibApp,
  strEvitar: String;
  fltDistan,
  fltTmpEnt: Double;
  strFilial,
  strIniPar: String;

  strEndEnt,
  strBaiEnt,
  strCepEnt,
  strCidEnt,
  strRefEnt: String;

  blnUsaPreRom: Boolean;
  arrDuplicataCND: TarrDuplicata;
  blnGerouRomaneioSemRomdetx : Boolean;
begin
  try
    Result := False;

    strMsgExp := '';
    strMenExp := '';
    strMenEx2 := '';
    strMenEx3 := '';
    strMenEx4 := '';
    strLocali := '';
    strLibApp := fCfgSis('LIBAPP', varString);
    strEvitar := '';
    fltDistan := 0;
    fltTmpEnt := 0;

    strPalet  := '';
    stlTmp    := TStringList.Create;
    qryMovGer.First;

    while not qryMovGer.Eof do
    begin
      pInfTabelaGravaRomaneio(qryMovGer.FieldByName('GER_NOMTBL').AsString, strTabelaMovDet, blnPedOrc);

      If (qryMovGer.FindField('GER_ESPDOC') <> Nil) And
         (qryMovGer.FieldByName('GER_ESPDOC').AsString = 'OX') Then
      Begin
        strAutIncGer := qryMovGer.FieldByName('GER_AUTINC').AsString;
        strNumDocHis := qryMovGer.FieldByName('GER_DOCORI').AsString;
        strEspDocHis := qryMovGer.FieldByName('GER_ESPDOC').AsString;
        strCodEmpHis := qryMovGer.FieldByName('GER_CODEMP').AsString;
        strNumDoc := qryMovGer.FieldByName('GER_DOCORI').AsString;
        strEspDoc := qryMovGer.FieldByName('GER_ESPDOC').AsString;
        strCodEmp := qryMovGer.FieldByName('GER_CODEMP').AsString;
        strCodVen := qryMovGer.FieldByName('GER_CODVEN').AsString;
        strCodFor := '';
        strCodCli := qryMovGer.FieldByName('GER_CODCLI').AsString;
        strTip_fc := 'C';
        dtaDtaEnt := qryMovGer.FieldByName('GER_DTAENT').AsDateTime;
        dtaHorEnt := qryMovGer.FieldByName('GER_HORENT').AsDateTime;
        dtaDtaDoc := 0;
        strConPag := '';
        strEstAdo := '';
        strNomCon := '';
        strEndCon := '';
        strBaiCon := '';
        strCepCon := '';
        strCidCon := '';
        strEstCon := '';
        strTelCon := '';
        strCgcCpf := '';
        strCgcCon := '';
        strIesCon := '';
        strR_gCon := '';
        fltBasSim := 0;
        fltBasIpi := 0;
        fltAlqIpi := 0;
        fltTotIpi := 0;
        fltBasIcm := 0;
        fltAlqIcm := 0;
        fltTotIcm := 0;
        fltTotRet := 0;
        fltAlqRet := 0;
        fltBasRet := 0;
        fltDesEsp := 0;
        fltVlrCon := 0;
        fltTotPro := 0;
        fltTotCus := 0;
        fltTotMed := 0;
        strTipFre := '';
        fltTotFre := 0;
        fltVolUme := 0;
        strEspEci := '';
        strMarCa_ := '';
        strMen001 := qryMovGer.FieldByName('GER_NOMCLI').AsString;
        strMen002 := '';
        strTipFat := '';
        strNumFat := '';
        dtaDtaFat := 0;
        strVenFat := '';
        strCndFat := '';
        fltValFat := 0.0;
        fltVpaR01 := 0.0;
        fltVpaR02 := 0.0;
        fltVpaR03 := 0.0;
        fltVpaR04 := 0.0;
        fltVpaR05 := 0.0;
        fltVpaR06 := 0.0;
        fltVpaR07 := 0.0;
        fltVpaR08 := 0.0;
        fltVpaR09 := 0.0;
        fltVpaR10 := 0.0;
        fltVpaR11 := 0.0;
        fltVpaR12 := 0.0;
        strSerIe_ := '';
        strNotEsp := '';
        strClaFis := '';
        fltPorDes := 0;
        strCodDig := '';
        strCodCnd := '';
        strCodFpg := '';
        fltVlrOri := 0.0;
        strAutEnt := '';
        strStatus := IfThen(blnUsaPreRom,'P','A');
        strCodReg := qryMovGer.FieldByName('CODREG').AsString;
      End
      Else If (Pos(strOpcRom, '1_5_') > 0) And (blnPedOrc) Then
      Begin
        strAutIncGer := qryMovGer.FieldByName('GER_AUTINC').AsString;
        strNumDocHis := qryMovGer.FieldByName('GER_NUMDOC').AsString;
        strEspDocHis := qryMovGer.FieldByName('GER_ESPDOC').AsString;
        strCodEmpHis := qryMovGer.FieldByName('GER_CODEMP').AsString;

        strNumDoc := qryMovGer.FieldByName('GER_NUMDOC').AsString;
        strEspDoc := qryMovGer.FieldByName('GER_ESPDOC').AsString;
        strCodEmp := qryMovGer.FieldByName('GER_CODEMP').AsString;
        strCodVen := qryMovGer.FieldByName('GER_CODVEN').AsString;
        strCodFor := '';
        strCodCli := qryMovGer.FieldByName('GER_CODCLI').AsString;
        strTip_fc := 'C';
        dtaDtaEnt := qryMovGer.FieldByName('GER_DTAENT').AsDateTime;
        dtaHorEnt := qryMovGer.FieldByName('GER_HORENT').AsDateTime;
        dtaDtaDoc := 0;
        strConPag := qryMovGer.FieldByName('GER_CONPAG').AsString;
        strEstAdo := qryMovGer.FieldByName('GER_ESTADO').AsString;
        strNomCon := qryMovGer.FieldByName('GER_NOMCON').AsString;
        strEndCon := qryMovGer.FieldByName('GER_ENDCON').AsString;
        strBaiCon := qryMovGer.FieldByName('GER_BAICON').AsString;
        strCepCon := qryMovGer.FieldByName('GER_CEPCON').AsString;
        strCidCon := qryMovGer.FieldByName('GER_CIDCON').AsString;
        strEstCon := qryMovGer.FieldByName('GER_ESTCON').AsString;
        strTelCon := qryMovGer.FieldByName('GER_TELCON').AsString;
        strCgcCpf := qryMovGer.FieldByName('GER_CGCCPF').AsString;
        strCgcCon := qryMovGer.FieldByName('GER_CGCCON').AsString;
        strIesCon := qryMovGer.FieldByName('GER_IESCON').AsString;
        strR_gCon := qryMovGer.FieldByName('GER_R_GCON').AsString;
        fltBasSim := qryMovGer.FieldByName('GER_BASSIM').AsFloat;
        fltBasIpi := qryMovGer.FieldByName('GER_BASIPI').AsFloat;
        fltAlqIpi := qryMovGer.FieldByName('GER_ALQIPI').AsFloat;
        fltTotIpi := qryMovGer.FieldByName('GER_TOTIPI').AsFloat;
        fltBasIcm := qryMovGer.FieldByName('GER_BASICM').AsFloat;
        fltAlqIcm := qryMovGer.FieldByName('GER_ALQICM').AsFloat;
        fltTotIcm := qryMovGer.FieldByName('GER_TOTICM').AsFloat;
        fltTotRet := qryMovGer.FieldByName('GER_TOTRET').AsFloat;
        fltAlqRet := qryMovGer.FieldByName('GER_ALQRET').AsFloat;
        fltBasRet := qryMovGer.FieldByName('GER_BASRET').AsFloat;
        fltDesEsp := qryMovGer.FieldByName('GER_DESESP').AsFloat;

        fltVlrCon := qryMovGer.FieldByName('GER_VLRCON').AsFloat;

        fltTotPro := fltVlrCon;

        fltTotCus := qryMovGer.FieldByName('GER_TOTCUS').AsFloat;
        fltTotMed := qryMovGer.FieldByName('GER_TOTMED').AsFloat;
        strTipFre := qryMovGer.FieldByName('GER_TIPFRE').AsString;
        fltTotFre := qryMovGer.FieldByName('GER_TOTFRE').AsFloat;
        fltVolUme := qryMovGer.FieldByName('GER_VOLUME').AsFloat;
        strEspEci := qryMovGer.FieldByName('GER_ESPECI').AsString;
        strMarCa_ := qryMovGer.FieldByName('GER_MARCA_').AsString;
        strMen001 := qryMovGer.FieldByName('GER_MEN001').AsString;
        strMen002 := qryMovGer.FieldByName('GER_MEN002').AsString;
        strTipFat := qryMovGer.FieldByName('GER_TIPFAT').AsString;
        strNumFat := qryMovGer.FieldByName('GER_NUMFAT').AsString;
        dtaDtaFat := qryMovGer.FieldByName('GER_DTAFAT').AsDateTime;
        strVenFat := qryMovGer.FieldByName('GER_VENFAT').AsString;
        strCndFat := qryMovGer.FieldByName('GER_CNDFAT').AsString;
        fltValFat := qryMovGer.FieldByName('GER_VALFAT').AsFloat;
        fltVpaR01 := 0.0;
        fltVpaR02 := 0.0;
        fltVpaR03 := 0.0;
        fltVpaR04 := 0.0;
        fltVpaR05 := 0.0;
        fltVpaR06 := 0.0;
        fltVpaR07 := 0.0;
        fltVpaR08 := 0.0;
        fltVpaR09 := 0.0;
        fltVpaR10 := 0.0;
        fltVpaR11 := 0.0;
        fltVpaR12 := 0.0;
        strSerIe_ := qryMovGer.FieldByName('GER_SERIE_').AsString;
        strNotEsp := '';
        strClaFis := '';
        fltPorDes := qryMovGer.FieldByName('GER_PORDES').AsFloat;
        strCodDig := qryMovGer.FieldByName('GER_CODDIG').AsString;
        strCodCnd := qryMovGer.FieldByName('GER_CODCND').AsString;
        strCodFpg := qryMovGer.FieldByName('GER_CODFPG').AsString;
        fltVlrOri := qryMovGer.FieldByName('GER_TOTPRO').AsFloat;
        strAutEnt := qryMovGer.FieldByName('AUX_ENTGER').AsString;
        strStatus := IfThen(blnUsaPreRom,'P','A');
      End
      Else
      Begin
        pRetNumeroPedido(qryMovGer.FieldByName('GER_NUMDOC').AsString,
                         qryMovGer.FieldByName('GER_ESPDOC').AsString,
                         qryMovGer.FieldByName('GER_CODEMP').AsString,
                         strNumDocHis,
                         strEspDocHis,
                         strCodEmpHis);

        strAutIncGer := qryMovGer.FieldByName('GER_AUTINC').AsString;
        strNumDoc := qryMovGer.FieldByName('GER_NUMDOC').AsString;
        strEspDoc := qryMovGer.FieldByName('GER_ESPDOC').AsString;
        strCodEmp := qryMovGer.FieldByName('GER_CODEMP').AsString;
        strCodVen := qryMovGer.FieldByName('GER_CODVEN').AsString;
        strCodFor := qryMovGer.FieldByName('GER_CODFOR').AsString;
        strCodCli := qryMovGer.FieldByName('GER_CODCLI').AsString;
        strTip_fc := qryMovGer.FieldByName('GER_TIP_FC').AsString;
        dtaDtaEnt := qryMovGer.FieldByName('GER_DTAENT').AsDateTime;
        dtaHorEnt := qryMovGer.FieldByName('GER_HORENT').AsDateTime;
        strConPag := qryMovGer.FieldByName('GER_CONPAG').AsString;
        strEstAdo := qryMovGer.FieldByName('GER_ESTADO').AsString;
        strNomCon := qryMovGer.FieldByName('GER_NOMCON').AsString;
        strEndCon := qryMovGer.FieldByName('GER_ENDCON').AsString;
        strBaiCon := qryMovGer.FieldByName('GER_BAICON').AsString;
        strCepCon := qryMovGer.FieldByName('GER_CEPCON').AsString;
        strCidCon := qryMovGer.FieldByName('GER_CIDCON').AsString;
        strEstCon := qryMovGer.FieldByName('GER_ESTCON').AsString;
        strTelCon := qryMovGer.FieldByName('GER_TELCON').AsString;
        strCgcCpf := qryMovGer.FieldByName('GER_CGCCPF').AsString;
        strCgcCon := qryMovGer.FieldByName('GER_CGCCON').AsString;
        strIesCon := qryMovGer.FieldByName('GER_IESCON').AsString;
        strR_gCon := qryMovGer.FieldByName('GER_R_GCON').AsString;
        strRomImp := qryMovGer.FieldByName('GER_ROMIMP').AsString;
        fltAlqIpi := qryMovGer.FieldByName('GER_ALQIPI').AsFloat;
        fltAlqIcm := qryMovGer.FieldByName('GER_ALQICM').AsFloat;
        fltAlqRet := qryMovGer.FieldByName('GER_ALQRET').AsFloat;
        strTipFre := qryMovGer.FieldByName('GER_TIPFRE').AsString;


        fltBasSim := qryMovGer.FieldByName('GER_BASSIM').AsFloat;
        fltBasIpi := qryMovGer.FieldByName('GER_BASIPI').AsFloat;
        fltTotIpi := qryMovGer.FieldByName('GER_TOTIPI').AsFloat;
        fltBasIcm := qryMovGer.FieldByName('GER_BASICM').AsFloat;
        fltTotIcm := qryMovGer.FieldByName('GER_TOTICM').AsFloat;
        fltTotRet := qryMovGer.FieldByName('GER_TOTRET').AsFloat;
        fltBasRet := qryMovGer.FieldByName('GER_BASRET').AsFloat;
        fltDesEsp := qryMovGer.FieldByName('GER_DESESP').AsFloat;

        fltVlrCon := qryMovGer.FieldByName('GER_VLRCON').AsFloat;

        fltTotPro := fltVlrCon;

        fltTotCus := qryMovGer.FieldByName('GER_TOTCUS').AsFloat;
        fltTotMed := qryMovGer.FieldByName('GER_TOTMED').AsFloat;
        fltTotFre := qryMovGer.FieldByName('GER_TOTFRE').AsFloat;
        fltVolUme := qryMovGer.FieldByName('GER_VOLUME').AsFloat;
        fltVpaR01 := qryMovGer.FieldByName('GER_VPAR01').AsFloat;
        fltVpaR02 := qryMovGer.FieldByName('GER_VPAR02').AsFloat;
        fltVpaR03 := qryMovGer.FieldByName('GER_VPAR03').AsFloat;
        fltVpaR04 := qryMovGer.FieldByName('GER_VPAR04').AsFloat;
        fltVpaR05 := qryMovGer.FieldByName('GER_VPAR05').AsFloat;
        fltVpaR06 := qryMovGer.FieldByName('GER_VPAR06').AsFloat;
        fltVpaR07 := qryMovGer.FieldByName('GER_VPAR07').AsFloat;
        fltVpaR08 := qryMovGer.FieldByName('GER_VPAR08').AsFloat;
        fltVpaR09 := qryMovGer.FieldByName('GER_VPAR09').AsFloat;
        fltVpaR10 := qryMovGer.FieldByName('GER_VPAR10').AsFloat;
        fltVpaR11 := qryMovGer.FieldByName('GER_VPAR11').AsFloat;
        fltVpaR12 := qryMovGer.FieldByName('GER_VPAR12').AsFloat;
        fltVlrOri := qryMovGer.FieldByName('GER_TOTPRO').AsFloat;

        strEspEci := qryMovGer.FieldByName('GER_ESPECI').AsString;
        strMarCa_ := qryMovGer.FieldByName('GER_MARCA_').AsString;
        strMen001 := qryMovGer.FieldByName('GER_MEN001').AsString;
        strMen002 := qryMovGer.FieldByName('GER_MEN002').AsString;
        strTipFat := qryMovGer.FieldByName('GER_TIPFAT').AsString;
        strNumFat := qryMovGer.FieldByName('GER_NUMFAT').AsString;
        dtaDtaFat := qryMovGer.FieldByName('GER_DTAFAT').AsDateTime;
        strVenFat := qryMovGer.FieldByName('GER_VENFAT').AsString;
        strCndFat := qryMovGer.FieldByName('GER_CNDFAT').AsString;
        fltValFat := qryMovGer.FieldByName('GER_VALFAT').AsFloat;
        strSerIe_ := qryMovGer.FieldByName('GER_SERIE_').AsString;
        strNotEsp := qryMovGer.FieldByName('GER_NOTESP').AsString;
        strClaFis := qryMovGer.FieldByName('GER_CLAFIS').AsString;
        fltPorDes := qryMovGer.FieldByName('GER_PORDES').AsFloat;
        strCodDig := qryMovGer.FieldByName('GER_CODDIG').AsString;
        strCodCnd := qryMovGer.FieldByName('GER_CODCND').AsString;
        strCodFpg := qryMovGer.FieldByName('GER_CODFPG').AsString;

        If (strOpcRom = '2') And (qryMovGer.FieldByName('GER_NOMTBL').AsString  <> 'FATGOR') Then
        Begin
          dtaDtaDoc := qryMovGer.FieldByName('GER_DTADOC').AsDateTime;
        End
        Else
        Begin
          dtaDtaDoc := qryMovGer.FieldByName('GER_DTAENT').AsDateTime;
        End;

        strAutEnt := qryMovGer.FieldByName('AUX_ENTGER').AsString;

        strMsgExp := fRetMensagemExpedicao(strNumDoc,
                                           strEspDoc,
                                           strCodEmp,
                                           qryMovGer.FieldByName('GER_NOMTBL').AsString,
                                           stlTmp);

        If (stlTmp.Count > 0) Then
        Begin
          strMenExp := stlTmp[0];
          strMenEx2 := stlTmp[1];
          strMenEx3 := stlTmp[2];
          strMenEx4 := stlTmp[3];
        End;

        strStatus := 'A';
      End;


      strNomTab := qryMovGer.FieldByName('GER_NOMTBL').AsString;
      intOrdemI := qryMovGer.fieldbyname('GER_ORDIMP').AsInteger;

      strEndEnt := qryMovGer.FieldByName('GER_ENDCON').AsString;
      strBaiEnt := qryMovGer.FieldByName('GER_BAICON').AsString;
      strCepEnt := qryMovGer.FieldByName('GER_CEPCON').AsString;
      strCidEnt := qryMovGer.FieldByName('GER_CIDCON').AsString;

      fltPesBru := qryMovGer.FieldByName('GER_PESBRU').AsFloat;
      fltPesLiq := qryMovGer.FieldByName('GER_PESLIQ').AsFloat;

      {*******************************************}
      {* GRAVA ARQUIVO GERAL                     *}
      {****************************************MV*}
      Result := fGravaRomGer(strNumRom,   // Número do Romaneio (Referencia)
                             strAutInc,   // Auto Incremento (Referência)
                             strNumDoc,   // Documento
                             strEspDoc,   // Espécie
                             strCodEmp,   // Empresa
                             strCodTra,   // Transportadora
                             strCodVen,   // Vendedor
                             strCodFor,   // Fornecedor
                             strCodCli,   // Cliente
                             strTip_fc,   // Tipo (Cliente / Fornecedor)
                             dtaDtaEnt,   // Data de Entrada
                             dtaHorEnt,   // Hora de Entrada
                             dtaDtaDoc,   // Data do Documento
                             strConPag,   // Condição de Pagamento
                             strEstAdo,   // Estado
                             strNomCon,   // Nome Cliente Consumidor
                             strEndCon,   // Endereço Cliente Consumidor
                             strBaiCon,   // Bairro Cliente Consumidor
                             strCepCon,   // CEP Cliente Consumidor
                             strCidCon,   // Cidade Cliente Consumidor
                             strEstCon,   // Estado Cliente Consumidor
                             strTelCon,   // Telefone Cliente Consumidor
                             strCgcCpf,   // CGC/CPF Cliente Consumidor
                             strCgcCon,   // CNPJ Cliente Consumidor
                             strIesCon,   // Inscrição Estadual Cliente Consumidor
                             strR_gCon,   // RG Cliente Consumidor
                             strRomImp,   // Romaneio já impresso?
                             fltBasSim,   // Base Simples Paulista
                             fltBasIpi,   // Base IPI
                             fltAlqIpi,   // Aliquota IPI
                             fltTotIpi,   // Total de IPI
                             fltBasIcm,   // Base de ICMS
                             fltAlqIcm,   // Aliquota de ICMS
                             fltTotIcm,   // Total de ICMS
                             fltTotRet,   // Total Retido
                             fltAlqRet,   // Aliquota Retido
                             fltBasRet,   // Base Retido
                             fltDesEsp,   // Desconto Especial
                             fltVlrCon,   // Valor Contabil
                             fltTotPro,   // Total dos Produtos
                             fltTotCus,   // Total de Custo
                             fltTotMed,   // Total Médio
                             strTipFre,   // Tipo de Frete
                             fltTotFre,   // Total do Frete
                             fltPesBru,   // Peso Bruto
                             fltPesLiq,   // Peso Líquido
                             fltVolUme,   // Volume
                             strEspEci,   // Espécie
                             strMarCa_,   // Marca
                             strMen001,   // Mensagem 01
                             strMen002,   // Mensagem 02
                             False,       // Ja Faturado?
                             strTipFat,   // Tipo de Faturamento
                             strNumFat,   // Numero do Faturamento
                             dtaDtaFat,   // Data do Faturamento
                             strVenFat,   // Vendedor do Faturamento
                             strCndFat,   // Condição do Faturamento
                             fltValFat,   // Valor do Faturamento
                             fltVpaR01,   // Valor da Parcela 01
                             fltVpaR02,   // Valor da Parcela 02
                             fltVpaR03,   // Valor da Parcela 03
                             fltVpaR04,   // Valor da Parcela 04
                             fltVpaR05,   // Valor da Parcela 05
                             fltVpaR06,   // Valor da Parcela 06
                             fltVpaR07,   // Valor da Parcela 07
                             fltVpaR08,   // Valor da Parcela 08
                             fltVpaR09,   // Valor da Parcela 09
                             fltVpaR10,   // Valor da Parcela 10
                             fltVpaR11,   // Valor da Parcela 11
                             fltVpaR12,   // Valor da Parcela 12
                             arrDuplicataCND,
                             strSerIe_,   // Série
                             strNotEsp,   // Nota Especial
                             strClaFis,   // Classificação Fiscal
                             fltPorDes,   //
                             strCodDig,   // Digitador
                             strCodCnd,   // Código da Condição de Pagamento
                             strCodFpg,   // Código da Forma de Pagamento
                             strPlaVei,   //Placa do veiculo
                             strCodMot,   // Motorista
                             strCodAj1,   // Ajudante 1
                             strCodAj2,   // Ajudante 2
                             strCodAj3,   // Ajudante 3
                             strCodAj4,   // Ajudante 4
                             strObsFec,   // Observação Fechamento Romaneio
                             strCodReg,   // Região
                             FDtaRom,     // Data do Romaneio
                             FHorRom,     // Hora do Romaneio
                             strLoginUsuarioLogado,  // Operador que realizou o romaneio
                             intOrdemI,   // Ordem de Impressao
                             fltVlrOri,   // Valor original do
                             strOpeSol,   // Operador Solicitante
                             strAutEnt,   // Ref de Endereco de Entrega
                             FVlrFre,
                             FVlrAdi,
                             FPerFre,
                             strMsgExp,
                             strPalet,
                             strStatus,
                             strNumBox,
                             strNomTab,
                             strEntSai,
                             strAutIncGer,
                             strMenExp,
                             strMenEx2,
                             strMenEx3,
                             strMenEx4,
                             strLocali,
                             strLibApp,
                             strEvitar,
                             fltDistan,
                             fltTmpEnt,
                             strEndEnt,
                             strBaiEnt,
                             strCepEnt,
                             strCidEnt,
                             strRefEnt,
                             strFilial,
                             strIniPar,
                             '',
                             '',
                             'N');

      if Result then
      begin
        if FAcaoRomaneio = tpGerar then
          FNumRom := strNumRom;

        pAdicionaDadosRomDet(strNumDoc, strEspDoc, strCodEmp, strCodCli, strEntSai, strAutInc, strNomTab, qryMovGer.FieldByName('GER_CLAFIS').AsString);
        Result := fAtualizaQtdBaiDet(strNumDoc, strEspDoc, strCodCli, strCodEmp, blnPedOrc, strNumRom,
          strNomTab, strAutInc, strEntSai, qryMovGer.FieldByName('GER_CLAFIS').AsString);

        If (Result) Then
        Begin
          blnGerouRomaneioSemRomdetx := (fCampoTabela('COUNT(*)', 'ROMDETX', ['DET_SEQGER'], [strAutInc]) = 0);
          If blnGerouRomaneioSemRomdetx Then
          Begin
            Result := False;
            fRollBack;
            fMensagem('', 'Inconsistência na gravação dos itens do romaneio (ROMDETX), feche a tela e tente novamente!' + sLineBreak +
                          'Documento: ' + strNumDoc + '-' + strEspDoc + '-' + strCodEmp + '-' + strCodCli, ['&OK']);
            pGravaLogRomaneioSemRomDetX;
            Break;
          End;
        End;

        if Result then
          Result := fAtualizaDocumentos(strNumDoc, strEspDoc, strCodEmp, strCodCli, strNumRom, strFgoDocs, strGerDocs, fltVlrCon);
      end;

      qryMovGer.Next;
    end;
  finally
    FreeAndNil(stlTmp);
  end;
end;

function TfrmFatManutRomaneio.fIncluiRomaneio: Boolean;
begin
  Result := False;
  cdsManut.DisableControls;

  try
    if not fRetDocsRomaneioInformado then
      Exit;

    FFgoRemov := EmptyStr;
    FGerRemov := EmptyStr;

    cdsManut.First;

    while not cdsManut.Eof do
    begin
      pRetornaDocumentos(FFgoRemov, FGerRemov, cdsManut);
      cdsManut.Next;
    end;

    pRetornaTransMot(FNumRom, VS_strCodEmp);

    pDeletaRomaneio(FNumRom, True);

    Result := fSelecionaDocumentos(FFgoRemov, FGerRemov, FNumRom);
  finally
    cdsManut.EnableControls;
  end;
end;

function TfrmFatManutRomaneio.fIncluiRomaneioClick(
  pgbStatus: TcxProgressBar): Boolean;
begin
  Result := False;

  if not fIniciaMautencao then
    Exit;

  fStartTransaction;

  try
    FNumRom := fRetRomaneio(FEmpRom);

    if not fRemoveRomaneio Then
    begin
      fRollBack;
      Exit;
    end;

    FAcaoRomaneio := tpIncluir;

    if fIncluiRomaneio then
    begin
      fCommit;
      blnGravou := True;
      cdsManut.EmptyDataSet;
      pConsultaRomaneios;
      fMensagem('', 'Romaneio Nº ' + FNumRom + ' gerado com sucesso!', ['&Ok']);

      if not fEmptyStr(FNumRom) then
      begin
        if Assigned(prcExecutaRelatorio) then
          prcExecutaRelatorio(13, 1356, [1356, 1367],
                              ['NUMROM', 'EMPROM'],
                              [FNumRom, VS_strCodEmp],
                              nil);
      end;

      Result := True;
    end
    else
      fRollBack;

    FAcaoRomaneio := tpIndefinido;
  except
    On E: Exception DO
    begin
      fRollBack;
      pMensagensErro('Erro ao gerar novo documento: ' + E.Message, '[fIncluiRomaneio]');
    end;
  end;
end;

function TfrmFatManutRomaneio.fIniciaMautencao: Boolean;
begin
  Result := False;
  FOpeRom := EmptyStr;

  if not cdsManut.Active then
    Exit;

  if cdsManut.RecordCount = 0 then
    Exit;

  FOpeRom := fRetOperadorSolicitante;

  if fEmptyStr(FOpeRom) then
    Exit;

  Result := True;
end;

function TfrmFatManutRomaneio.fListaAutIncGer(strLisDoc,
  strTabela: String): String;
Var
  strSQL : String;
  qryGen: TUniQuery;
begin
  Result := ' "" ';

  If (Not fEmptyStr(strLisDoc)) Then
  Begin
    qryGen := fCriaQuery(Nil);
    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT DISTINCT ';
      If Pos(strTabela, 'MOVDET_NOTDET_') > 0 Then
        strSQL := strSQL + ' D.DET_SEQGER '
      Else
        strSQL := strSQL + ' D.FDO_SEQGER ';
      strSQL := strSQL + ' FROM ';
      strSQL := strSQL + strTabela + ' D ';
      strSQL := strSQL + ' WHERE ';
      If Pos(strTabela, 'MOVDET_NOTDET_') > 0 Then
        strSQL := strSQL + AnsiReplaceStr(strLisDoc,'G.GER_','D.DET_')
      Else
        strSQL := strSQL + AnsiReplaceStr(strLisDoc,'G.FGO_','D.FDO_');

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);
      qryGen.Open;

      If Not qryGen.IsEmpty  Then
      Begin
        Result := '';
        qryGen.First;
        While Not qryGen.Eof Do
        Begin
          pIncrementaListaStr(qryGen.Fields[0].Text, Result, True, True, ',', False, False);
          qryGen.Next;
        End;
      End;

      qryGen.Close;

    Finally
      FreeAndNil(qryGen);
    End;
  End;
end;

procedure TfrmFatManutRomaneio.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDestravaTodasAsTravas;
end;

procedure TfrmFatManutRomaneio.FormCreate(Sender: TObject);
begin
  inherited;
  pCarregaConfiguracoesGrids;

  blnFecharComEscape := True;

  cdsDocumentos.CreateDataSet;
  cdsDocumentos.IndexFieldNames := 'GER_NUMROM';
  cdsManut.CreateDataSet;
  cdsRomDet := TUniClientDataSet.Create(Self);
  blnUsaPreRom := fCfgSis('USPRRO', varBoolean);
  FNumRom := EmptyStr;
  FEmpRom := EmptyStr;
  FAcaoRomaneio := tpIndefinido;
  objLock := TLock.Create;
  blnGravou := False;
  strNumRomCarregado := '';
  FLogCancelamento := TLogCancelamento.Create;
end;

procedure TfrmFatManutRomaneio.FormDestroy(Sender: TObject);
begin
  FreeAndNil(cfgConfiguracaoGrids);
  FreeAndNil(cdsRomDet);
  FreeAndNil(objLock);
  FreeAndNil(FLogCancelamento);
  inherited;
end;

procedure TfrmFatManutRomaneio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F2 Then
    btnEntEsp.Click;
end;

procedure TfrmFatManutRomaneio.FormShow(Sender: TObject);
begin
  inherited;
  pnlManutancao.Width := Self.Width Div 2;
  pSetFocus(mskDtaIni);
  strAceRom := fCampoTabela('OPE_EMPROM', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresa;
  mskDtaIni.Text := DateToStr(fRetDataServidor);
  mskDtaFin.Text := mskDtaIni.Text;
  strOpcRom := fCfgSis('OPCROM');
  btnEntEsp.Visible := (fCfgSis('OPCROM') = '5');
  grdRomaneioDOCS_FAT.Visible := (fCfgSis('OPCROM') = '5');

  edtCodEmpExit(edtCodEmp);
end;

function TfrmFatManutRomaneio.fQtdeRomInvalido(strCodIte, strNumDoc, strEspDoc,
  strCodCli, strCodEmp, strTabela: String): Boolean;
var
  qryTmp : TUniQuery;
  strSQL : String;
begin
  qryTmp := fCriaQuery(Self);

  Try
    If strTabela = 'FATDOR' Then
    Begin
      strSQL := ' SELECT IF(SUM(FDO_QTDROM) > SUM(FDO_QTDITE), "S","N") AS INVALIDO '+
                '   FROM FATDOR '+
                '  WHERE FDO_CODITE = :CODITE '+
                '    AND FDO_NUMDOC = :NUMDOC '+
                '    AND FDO_ESPDOC = :ESPDOC '+
                '    AND FDO_CODCLI = :CODCLI '+
                '    AND FDO_CODEMP = :CODEMP ';
    End
    Else
    Begin
      strSQL := ' SELECT IF(SUM(DET_QTDROM) > SUM(DET_QTDITE), "S","N") AS INVALIDO '+
                '   FROM '+strTabela+
                '  WHERE DET_CODITE = :CODITE '+
                '    AND DET_NUMDOC = :NUMDOC '+
                '    AND DET_ESPDOC = :ESPDOC '+
                '    AND DET_CODCLI = :CODCLI '+
                '    AND DET_CODEMP = :CODEMP ';
    End;

    qryTmp.SQL.Text := strSQL;
    qryTmp.ParamByName('CODITE').AsString := strCodIte;
    qryTmp.ParamByName('NUMDOC').AsString := strNumDoc;
    qryTmp.ParamByName('ESPDOC').AsString := strEspDoc;
    qryTmp.ParamByName('CODCLI').AsString := strCodCli;
    qryTmp.ParamByName('CODEMP').AsString := strCodEmp;
    qryTmp.Open;

    Result := (qryTmp.FieldByName('INVALIDO').AsString = 'S');

    If Result Then
    begin
      fMensagem('ATENÇÃO!', 'Documento ['+strNumDoc+'-'+strEspDoc+'-'+strCodEmp+'] com quantidade inválida !'+#13+
                            'Refaça esse documento e tente novamente.', ['&Ok']);
    end;

  Finally
    FreeAndNil(qryTmp);
  End;
end;

function TfrmFatManutRomaneio.fRemoveRomaneio: Boolean;
var
  LRomaneioBKP,
  LDocumentosBKP: TUniClientDataSet;
begin
  LRomaneioBKP := TUniClientDataSet.Create(Self);
  LDocumentosBKP := TUniClientDataSet.Create(Self);

  try
    Result := False;

    pCloneDataSet(LRomaneioBKP, cdsRomaneio);
    pCloneDataSet(LDocumentosBKP, cdsDocumentos);

    LRomaneioBKP.First;

    while not LRomaneioBKP.Eof do
    begin
      FFgoRemov := EmptyStr;
      FGerRemov := EmptyStr;

      if not cdsManut.Locate('GER_NUMROM', LRomaneioBKP.FieldByName('GER_NUMROM').AsString, []) then
      begin
        LRomaneioBKP.Next;
        Continue;
      end;

      LDocumentosBKP.Filtered := False;
      LDocumentosBKP.Filter := 'GER_NUMROM = ' + QuotedStr(LRomaneioBKP.FieldByName('GER_NUMROM').AsString);
      LDocumentosBKP.Filtered := True;

      if LDocumentosBKP.RecordCount = 0 then
      begin
        LRomaneioBKP.Next;
        Continue;
      end;

      LDocumentosBKP.First;

      while not LDocumentosBKP.Eof do
      begin
        if not cdsManut.Locate('AUTOINCREM', LDocumentosBKP.FieldByName('AUTOINCREM').AsString, []) then
        begin
          pRetornaDocumentos(FFgoRemov, FGerRemov, LDocumentosBKP);
        end;

        LDocumentosBKP.Next;
      end;

      pRetornaTransMot(LRomaneioBKP.FieldByName('GER_NUMROM').AsString, LRomaneioBKP.FieldByName('GER_EMPROM').AsString);

      pDeletaRomaneio(LRomaneioBKP.FieldByName('GER_NUMROM').AsString, True);

      Result := fSelecionaDocumentos(FFgoRemov, FGerRemov, LRomaneioBKP.FieldByName('GER_NUMROM').AsString);

      LRomaneioBKP.Next;
    end;
  finally
    FreeAndNil(LDocumentosBKP);
    FreeAndNil(LRomaneioBKP);
  end;
end;

function TfrmFatManutRomaneio.fRemoveRomaneioClick(
  pgbStatus: TcxProgressBar): Boolean;
begin
  Result := False;

  if not fIniciaMautencao then
    Exit;

  fStartTransaction;

  try
    FAcaoRomaneio := tpRemover;
    if fRemoveRomaneio then
    begin
      fCommit;
      blnGravou := True;
      cdsManut.EmptyDataSet;
      pConsultaRomaneios;
      fMensagem('', 'Documentos removidos com sucesso.', ['&Ok']);
      Result := True;
    end
    else
      fRollBack;

    FAcaoRomaneio := tpIndefinido;
  except
    On E: Exception Do
    begin
      fRollBack;
      pMensagensErro('Erro ao remover documentos: ' + E.Message, '[fRemoveRomaneio]');
    end;
  end;
end;

function TfrmFatManutRomaneio.fRetMensagemExpedicao(strNumDoc, strEspDoc,
  strCodEmp, strTabela: String; var stlMsgExp: TStringList): String;
var
  qryPesqui:  TUniQuery;
  stlMensag: TStringList;
  strTabTmp: String;
Begin
  Result := '';

  stlMensag  := TStringList.Create;
  qryPesqui  := fCriaQuery(Self);

  Try
    If Assigned(stlMsgExp) Then
      stlMsgExp.Clear;

    qryPesqui.SQL.Clear;

    If SameText(strTabela, 'FATGOR') Then
    Begin
      // PEDIDO FATURADO DIRETAMENTE
      qryPesqui.SQL.Add('SELECT ');
      qryPesqui.SQL.Add('  FGO_MENEXP AS MENEXP, ');
      qryPesqui.SQL.Add('  FGO_MENEX2 AS MENEX2, ');
      qryPesqui.SQL.Add('  FGO_MENEX3 AS MENEX3, ');
      qryPesqui.SQL.Add('  FGO_MENEX4 AS MENEX4 ');
      qryPesqui.SQL.Add('FROM');
      qryPesqui.SQL.Add('  FATGOR F');
      qryPesqui.SQL.Add('WHERE');
      qryPesqui.SQL.Add('  FGO_NUMFAT = :NUMDOC AND');
      qryPesqui.SQL.Add('  FGO_TIPFAT = :ESPDOC AND');
      qryPesqui.SQL.Add('  FGO_EMPFAT = :CODEMP     ');

      qryPesqui.SQL.Add('UNION ALL');

      // PEGA OS PEDIDOS DOS DOCUMENTOS ORIGINAIS DE ENTREGA FUTURA
      qryPesqui.SQL.Add('SELECT ');
      qryPesqui.SQL.Add('  FGO_MENEXP, ');
      qryPesqui.SQL.Add('  FGO_MENEX2, ');
      qryPesqui.SQL.Add('  FGO_MENEX3, ');
      qryPesqui.SQL.Add('  FGO_MENEX4  ');

      qryPesqui.SQL.Add('FROM');
      qryPesqui.SQL.Add('  FATGOR');

          // PEDIDOS DOS DOCUMENTOS ORIGINAIS DE ENTREGA FUTURA
      qryPesqui.SQL.Add('INNER JOIN MOVGER ORI ON ');
      qryPesqui.SQL.Add('   FGO_NUMFAT = ORI.GER_NUMDOC AND ');
      qryPesqui.SQL.Add('   FGO_TIPFAT = ORI.GER_ESPDOC AND ');
      qryPesqui.SQL.Add('   FGO_EMPFAT = ORI.GER_CODEMP     ');

      qryPesqui.SQL.Add('INNER JOIN ( ');

          // DOCUMENTOS ORIGINAIS DE ENTREGA FUTURA RELACIONADOS COM OS ITENS DE BAIXA
      qryPesqui.SQL.Add('SELECT DISTINCT');
      qryPesqui.SQL.Add('  DET_DOCFUT, ');
      qryPesqui.SQL.Add('  DET_ESPFUT, ');
      qryPesqui.SQL.Add('  DET_EMPFUT  ');
      qryPesqui.SQL.Add('FROM');

      qryPesqui.SQL.Add('MOVDET ');

      qryPesqui.SQL.Add('WHERE');
      qryPesqui.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
      qryPesqui.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
      qryPesqui.SQL.Add('  DET_CODEMP = :CODEMP     ');

      qryPesqui.SQL.Add(' ) BAI ON ');

              // RELACIONA COM O MOVGER ORIGINAL
      qryPesqui.SQL.Add('   ORI.GER_NUMDOC = DET_DOCFUT AND ');
      qryPesqui.SQL.Add('   ORI.GER_ESPDOC = DET_ESPFUT AND ');
      qryPesqui.SQL.Add('   ORI.GER_CODEMP = DET_EMPFUT     ');
    End
    Else
    Begin
      strTabTmp := 'MOVGER';

      qryPesqui.SQL.Add('SELECT ');
      qryPesqui.SQL.Add('  GER_MENEXP AS MENEXP, ');
      qryPesqui.SQL.Add('  GER_MENEX2 AS MENEX2, ');
      qryPesqui.SQL.Add('  GER_MENEX3 AS MENEX3, ');
      qryPesqui.SQL.Add('  GER_MENEX4 AS MENEX4 ');
      qryPesqui.SQL.Add('FROM');
      qryPesqui.SQL.Add(strTabTmp);
      qryPesqui.SQL.Add('WHERE');

      qryPesqui.SQL.Add(fRetSqlMensagemExpedicao(strTabela));
    End;

    qryPesqui.ParamByName('NUMDOC').AsString := strNumDoc;
    qryPesqui.ParamByName('ESPDOC').AsString := strEspDoc;
    qryPesqui.ParamByName('CODEMP').AsString := strCodEmp;

    qryPesqui.Open;

    While Not qryPesqui.Eof Do
    Begin
      stlMensag.Add(qryPesqui.FieldByName('MENEXP').AsString);
      stlMensag.Add(qryPesqui.FieldByName('MENEX2').AsString);
      stlMensag.Add(qryPesqui.FieldByName('MENEX3').AsString);
      stlMensag.Add(qryPesqui.FieldByName('MENEX4').AsString);

      If Assigned(stlMsgExp) Then
      Begin
        If(fEhDocumentoBaixaEntregaFutura(strNumDoc, strEspDoc, strCodEmp)) Then
          pPegaMsgDocBaixaEntFut(stlMsgExp, strNumDoc, strEspDoc, strCodEmp)
        Else
        Begin
          stlMsgExp.Add(qryPesqui.FieldByName('MENEXP').AsString);
          stlMsgExp.Add(qryPesqui.FieldByName('MENEX2').AsString);
          stlMsgExp.Add(qryPesqui.FieldByName('MENEX3').AsString);
          stlMsgExp.Add(qryPesqui.FieldByName('MENEX4').AsString);
        End;
      End;

      qryPesqui.Next;
    End;

    If Assigned(stlMsgExp) Then
      Result := AnsiReplaceStr(stlMsgExp.Text, #13#10, ' ')
    Else
      Result := AnsiReplaceStr(stlMensag.Text, #13#10, ' ');

    qryPesqui.Close;

  Finally
    FreeAndNil(qryPesqui);
    FreeAndNil(stlMensag);
  End;
End;

function TfrmFatManutRomaneio.fRetOperadorSolicitante: string;
begin
  Result := '';
  While fEmptyStr(Result) Do
  Begin

    If (Not ffrmSenha(Result, 'Operador Solicitante')) Then
    Begin
      Exit;
    End;

    Result := fRetCodVendedor(Result);

    If fEmptyStr(Result) Then
    Begin
      fMensagem('', 'Operador não cadastrado.', ['&Ok']);
    End;

  End;
end;

function TfrmFatManutRomaneio.fRetRomaneio(var AEmpRom: string): string;
var
  LConGen: TUniQuery;
  LArrRom: TConsultasArray;
begin
  inherited;
  LConGen := fCriaQuery(Self);

  try
    Result := EmptyStr;
    AEmpRom := EmptyStr;
    If (fPesqRomaneioNaoBaixado(Self, LConGen, LArrRom)) And (Length(LArrRom) > 0) Then
    Begin
      AEmpRom := fCampoTabela('GER_EMPROM', 'ROMGERX', ['AUTOINCREM'], [LArrRom[0].strCodigo], False);
      Result := fCampoTabela('GER_NUMROM', 'ROMGERX', ['AUTOINCREM'], [LArrRom[0].strCodigo], False);
    End;
  finally
    FreeAndNil(LConGen);
  end;
end;

function TfrmFatManutRomaneio.fRetSQLDoc(ADocumentosFgo,
  ADocumentosGer: String): String;
var
  LSQLFgo: String;
  LSQLGer: String;
begin
  LSQLFgo := '';
  LSQLFgo := LSQLFgo + 'SELECT ';
  LSQLFgo := LSQLFgo + '  G.FGO_NUMDOC AS GER_NUMDOC, ';
  LSQLFgo := LSQLFgo + '  G.FGO_ESPDOC AS GER_ESPDOC, ';
  LSQLFgo := LSQLFgo + '  G.FGO_CODEMP AS GER_CODEMP, ';
  LSQLFgo := LSQLFgo + '  G.FGO_CODVEN AS GER_CODVEN, ';
  LSQLFgo := LSQLFgo + '  " "          AS GER_CODFOR, ';
  LSQLFgo := LSQLFgo + '  G.FGO_CODCLI AS GER_CODCLI, ';
  LSQLFgo := LSQLFgo + '  "C"          AS GER_TIP_FC, ';
  LSQLFgo := LSQLFgo + '  G.FGO_VLRCON AS GER_VLRCON, ';
  LSQLFgo := LSQLFgo + '  CAST(G.FGO_DTAENT AS DATE) AS GER_DTADOC, ';
  LSQLFgo := LSQLFgo + '  G.FGO_DTAENT AS GER_DTAENT, ';
  LSQLFgo := LSQLFgo + '  G.FGO_HORENT AS GER_HORENT, ';
  LSQLFgo := LSQLFgo + '  G.FGO_CONPAG AS GER_CONPAG, ';
  LSQLFgo := LSQLFgo + '  G.FGO_ESTADO AS GER_ESTADO, ';
  LSQLFgo := LSQLFgo + '  G.FGO_NOMCON AS GER_NOMCON, ';
  LSQLFgo := LSQLFgo + '  G.FGO_ENDCON AS GER_ENDCON, ';
  LSQLFgo := LSQLFgo + '  G.FGO_BAICON AS GER_BAICON, ';
  LSQLFgo := LSQLFgo + '  G.FGO_CEPCON AS GER_CEPCON, ';
  LSQLFgo := LSQLFgo + '  G.FGO_CIDCON AS GER_CIDCON, ';
  LSQLFgo := LSQLFgo + '  G.FGO_ESTCON AS GER_ESTCON, ';
  LSQLFgo := LSQLFgo + '  G.FGO_TELCON AS GER_TELCON, ';
  LSQLFgo := LSQLFgo + '  G.FGO_CGCCPF AS GER_CGCCPF, ';
  LSQLFgo := LSQLFgo + '  G.FGO_CGCCON AS GER_CGCCON, ';
  LSQLFgo := LSQLFgo + '  G.FGO_IESCON AS GER_IESCON, ';
  LSQLFgo := LSQLFgo + '  G.FGO_R_GCON AS GER_R_GCON, ';
  LSQLFgo := LSQLFgo + '  G.FGO_ROMIMP AS GER_ROMIMP, ';
  LSQLFgo := LSQLFgo + '  G.FGO_BASSIM AS GER_BASSIM, ';
  LSQLFgo := LSQLFgo + '  G.FGO_BASIPI AS GER_BASIPI, ';
  LSQLFgo := LSQLFgo + '  G.FGO_ALQIPI AS GER_ALQIPI, ';
  LSQLFgo := LSQLFgo + '  G.FGO_TOTIPI AS GER_TOTIPI, ';
  LSQLFgo := LSQLFgo + '  G.FGO_BASICM AS GER_BASICM, ';
  LSQLFgo := LSQLFgo + '  G.FGO_ALQICM AS GER_ALQICM, ';
  LSQLFgo := LSQLFgo + '  G.FGO_TOTICM AS GER_TOTICM, ';
  LSQLFgo := LSQLFgo + '  G.FGO_TOTRET AS GER_TOTRET, ';
  LSQLFgo := LSQLFgo + '  G.FGO_ALQRET AS GER_ALQRET, ';
  LSQLFgo := LSQLFgo + '  G.FGO_BASRET AS GER_BASRET, ';
  LSQLFgo := LSQLFgo + '  G.FGO_DESESP AS GER_DESESP, ';
  LSQLFgo := LSQLFgo + '  G.FGO_TOTCUS AS GER_TOTCUS, ';
  LSQLFgo := LSQLFgo + '  G.FGO_TOTMED AS GER_TOTMED, ';
  LSQLFgo := LSQLFgo + '  G.FGO_TIPFRE AS GER_TIPFRE, ';
  LSQLFgo := LSQLFgo + '  G.FGO_TOTFRE AS GER_TOTFRE, ';
  LSQLFgo := LSQLFgo + '  G.FGO_PESBRU AS GER_PESBRU, ';
  LSQLFgo := LSQLFgo + '  G.FGO_PESLIQ AS GER_PESLIQ, ';
  LSQLFgo := LSQLFgo + '  G.FGO_VOLUME AS GER_VOLUME, ';
  LSQLFgo := LSQLFgo + '  G.FGO_ESPECI AS GER_ESPECI, ';
  LSQLFgo := LSQLFgo + '  G.FGO_MARCA_ AS GER_MARCA_, ';
  LSQLFgo := LSQLFgo + '  G.FGO_MEN001 AS GER_MEN001, ';
  LSQLFgo := LSQLFgo + '  G.FGO_MEN002 AS GER_MEN002, ';
  LSQLFgo := LSQLFgo + '  G.FGO_TIPFAT AS GER_TIPFAT, ';
  LSQLFgo := LSQLFgo + '  G.FGO_NUMFAT AS GER_NUMFAT, ';
  LSQLFgo := LSQLFgo + '  G.FGO_DTAFAT AS GER_DTAFAT, ';
  LSQLFgo := LSQLFgo + '  G.FGO_VENFAT AS GER_VENFAT, ';
  LSQLFgo := LSQLFgo + '  G.FGO_CNDFAT AS GER_CNDFAT, ';
  LSQLFgo := LSQLFgo + '  G.FGO_VALFAT AS GER_VALFAT, ';
  LSQLFgo := LSQLFgo + '  G.FGO_VPAR01 AS GER_VPAR01, ';
  LSQLFgo := LSQLFgo + '  G.FGO_VPAR02 AS GER_VPAR02, ';
  LSQLFgo := LSQLFgo + '  G.FGO_VPAR03 AS GER_VPAR03, ';
  LSQLFgo := LSQLFgo + '  G.FGO_VPAR04 AS GER_VPAR04, ';
  LSQLFgo := LSQLFgo + '  G.FGO_VPAR05 AS GER_VPAR05, ';
  LSQLFgo := LSQLFgo + '  G.FGO_VPAR06 AS GER_VPAR06, ';
  LSQLFgo := LSQLFgo + '  G.FGO_VPAR07 AS GER_VPAR07, ';
  LSQLFgo := LSQLFgo + '  G.FGO_VPAR08 AS GER_VPAR08, ';
  LSQLFgo := LSQLFgo + '  G.FGO_VPAR09 AS GER_VPAR09, ';
  LSQLFgo := LSQLFgo + '  G.FGO_VPAR10 AS GER_VPAR10, ';
  LSQLFgo := LSQLFgo + '  G.FGO_VPAR11 AS GER_VPAR11, ';
  LSQLFgo := LSQLFgo + '  G.FGO_VPAR12 AS GER_VPAR12, ';
  LSQLFgo := LSQLFgo + '  G.FGO_SERIE_ AS GER_SERIE_, ';
  LSQLFgo := LSQLFgo + '  "N"          AS GER_NOTESP, ';
  LSQLFgo := LSQLFgo + '  0            AS GER_CLAFIS, ';
  LSQLFgo := LSQLFgo + '  G.FGO_PORDES AS GER_PORDES, ';
  LSQLFgo := LSQLFgo + '  G.FGO_CODDIG AS GER_CODDIG, ';
  LSQLFgo := LSQLFgo + '  G.FGO_CODCND AS GER_CODCND, ';
  LSQLFgo := LSQLFgo + '  G.FGO_CODFPG AS GER_CODFPG, ';
  LSQLFgo := LSQLFgo + '  G.FGO_TOTPRO AS GER_TOTPRO, ';
  LSQLFgo := LSQLFgo + '  "FATGOR"     AS GER_NOMTBL, ';
  LSQLFgo := LSQLFgo + '  0.00         AS GER_VALSEL, ';
  LSQLFgo := LSQLFgo + '  1            AS GER_ORDIMP, ';
  LSQLFgo := LSQLFgo + '  G.AUTOINCREM AS GER_AUTINC, ';
  LSQLFgo := LSQLFgo + '  IFNULL(AUX_ENTGER, "") AS AUX_ENTGER ';  // REFERENCIA DO ENDERECO DE ENTREGA
  LSQLFgo := LSQLFgo + 'FROM ';
  LSQLFgo := LSQLFgo + '  FATGOR G  ';
  LSQLFgo := LSQLFgo + '  LEFT JOIN ' + fRetNomTabAuxMov('FATGOR') + ' ON AUX_SEQGER = G.AUTOINCREM ';
  LSQLFgo := LSQLFgo + 'WHERE ';
  LSQLFgo := LSQLFgo + '(' + ADocumentosFgo + ') ';
  LSQLFgo := LSQLFgo + 'GROUP BY ';
  LSQLFgo := LSQLFgo + ' G.FGO_NUMDOC, ';
  LSQLFgo := LSQLFgo + ' G.FGO_ESPDOC, ';
  LSQLFgo := LSQLFgo + ' G.FGO_CODEMP ';

  LSQLGer := '';
  LSQLGer := LSQLGer + 'SELECT ';
  LSQLGer := LSQLGer + '  G.GER_NUMDOC, ';
  LSQLGer := LSQLGer + '  G.GER_ESPDOC, ';
  LSQLGer := LSQLGer + '  G.GER_CODEMP, ';
  LSQLGer := LSQLGer + '  G.GER_CODVEN, ';
  LSQLGer := LSQLGer + '  G.GER_CODFOR, ';
  LSQLGer := LSQLGer + '  G.GER_CODCLI, ';
  LSQLGer := LSQLGer + '  G.GER_TIP_FC, ';
  LSQLGer := LSQLGer + '  G.GER_VLRCON, ';
  LSQLGer := LSQLGer + '  G.GER_DTADOC, ';
  LSQLGer := LSQLGer + '  G.GER_DTAENT, ';
  LSQLGer := LSQLGer + '  G.GER_HORENT, ';
  LSQLGer := LSQLGer + '  G.GER_CONPAG, ';
  LSQLGer := LSQLGer + '  G.GER_ESTADO, ';
  LSQLGer := LSQLGer + '  G.GER_NOMCON, ';
  LSQLGer := LSQLGer + '  G.GER_ENDCON, ';
  LSQLGer := LSQLGer + '  G.GER_BAICON, ';
  LSQLGer := LSQLGer + '  G.GER_CEPCON, ';
  LSQLGer := LSQLGer + '  G.GER_CIDCON, ';
  LSQLGer := LSQLGer + '  G.GER_ESTCON, ';
  LSQLGer := LSQLGer + '  G.GER_TELCON, ';
  LSQLGer := LSQLGer + '  G.GER_CGCCPF, ';
  LSQLGer := LSQLGer + '  G.GER_CGCCON, ';
  LSQLGer := LSQLGer + '  G.GER_IESCON, ';
  LSQLGer := LSQLGer + '  G.GER_R_GCON, ';
  LSQLGer := LSQLGer + '  G.GER_ROMIMP, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_BASSIM') + ' AS GER_BASSIM, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_BASIPI') + ' AS GER_BASIPI, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_ALQIPI') + ' AS GER_ALQIPI, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_TOTIPI') + ' AS GER_TOTIPI, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_BASICM') + ' AS GER_BASICM, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_ALQICM') + ' AS GER_ALQICM, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_TOTICM') + ' AS GER_TOTICM, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_TOTRET') + ' AS GER_TOTRET, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_ALQRET') + ' AS GER_ALQRET, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_BASRET') + ' AS GER_BASRET, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_DESESP') + ' AS GER_DESESP, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_TOTCUS') + ' AS GER_TOTCUS, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_TOTMED') + ' AS GER_TOTMED, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_TIPFRE') + ' AS GER_TIPFRE, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_TOTFRE') + ' AS GER_TOTFRE, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_PESBRU') + ' AS GER_PESBRU, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_PESLIQ') + ' AS GER_PESLIQ, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_VOLUME') + ' AS GER_VOLUME, ';
  LSQLGer := LSQLGer + '  G.GER_ESPECI, ';
  LSQLGer := LSQLGer + '  G.GER_MARCA_, ';
  LSQLGer := LSQLGer + '  G.GER_MEN001, ';
  LSQLGer := LSQLGer + '  G.GER_MEN002, ';
  LSQLGer := LSQLGer + '  G.GER_TIPFAT, ';
  LSQLGer := LSQLGer + '  G.GER_NUMFAT, ';
  LSQLGer := LSQLGer + '  G.GER_DTAFAT, ';
  LSQLGer := LSQLGer + '  G.GER_VENFAT, ';
  LSQLGer := LSQLGer + '  G.GER_CNDFAT, ';
  LSQLGer := LSQLGer + '  G.GER_VALFAT, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_VPAR01') + ' AS GER_VPAR01, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_VPAR02') + ' AS GER_VPAR02, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_VPAR03') + ' AS GER_VPAR03, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_VPAR04') + ' AS GER_VPAR04, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_VPAR05') + ' AS GER_VPAR05, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_VPAR06') + ' AS GER_VPAR06, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_VPAR07') + ' AS GER_VPAR07, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_VPAR08') + ' AS GER_VPAR08, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_VPAR09') + ' AS GER_VPAR09, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_VPAR10') + ' AS GER_VPAR10, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_VPAR11') + ' AS GER_VPAR11, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_VPAR12') + ' AS GER_VPAR12, ';
  LSQLGer := LSQLGer + '  G.GER_SERIE_, ';
  LSQLGer := LSQLGer + '  G.GER_NOTESP, ';
  LSQLGer := LSQLGer + '  G.GER_CLAFIS, ';
  LSQLGer := LSQLGer + '  G.GER_PORDES, ';
  LSQLGer := LSQLGer + '  G.GER_CODDIG, ';
  LSQLGer := LSQLGer + '  G.GER_CODCND, ';
  LSQLGer := LSQLGer + '  G.GER_CODFPG, ';
  LSQLGer := LSQLGer + fGetCampo('G.GER_TOTPRO') + ' AS GER_TOTPRO, ';
  LSQLGer := LSQLGer + '  "MOVGER" GER_NOMTBL, ';
  LSQLGer := LSQLGer + '  0.00 GER_VALSEL, ';
  LSQLGer := LSQLGer + '  1    GER_ORDIMP, ';
  LSQLGer := LSQLGer + '  G.AUTOINCREM AS GER_AUTINC, ';
  LSQLGer := LSQLGer + '  IFNULL(AUX_ENTGER, "") AS AUX_ENTGER ';  // REFERENCIA DO ENDERECO DE ENTREGA
  LSQLGer := LSQLGer + 'FROM ';
  LSQLGer := LSQLGer + '  MOVGER G  ';
  LSQLGer := LSQLGer + '  LEFT JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM ';
  LSQLGer := LSQLGer + '  LEFT JOIN ' + fRetNomTabAuxMov('MOVGER') + ' ON AUX_SEQGER = G.AUTOINCREM ';
  LSQLGer := LSQLGer + 'WHERE ';
  LSQLGer := LSQLGer + '(' + ADocumentosGer + ') ';
  LSQLGer := LSQLGer + 'GROUP BY ';
  LSQLGer := LSQLGer + ' G.GER_NUMDOC, ';
  LSQLGer := LSQLGer + ' G.GER_ESPDOC, ';
  LSQLGer := LSQLGer + ' G.GER_CODCLI, ';
  LSQLGer := LSQLGer + ' G.GER_CODEMP ';

  Result := '';

  If (Not fEmptyStr(ADocumentosFgo) And (ADocumentosFgo <> '()')) Then
    Result := LSQLFgo;

  If (Not fEmptyStr(ADocumentosGer) And (ADocumentosGer <> '()')) Then
  Begin
    If (fEmptyStr(Result)) Then
      Result := LSQLGer + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(LSQLGer, 'G.GER_DTADOC', 'G.GER_DTAENT AS GER_DTADOC'), 'AUXMOV', 'AUXNOT'), 'MOVGER', 'NOTGER')
    Else
      Result := Result + ' UNION ALL ' + LSQLGer + ' UNION ALL ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(LSQLGer, 'G.GER_DTADOC', 'G.GER_DTAENT AS GER_DTADOC'), 'AUXMOV', 'AUXNOT'), 'MOVGER', 'NOTGER');
  End;
end;

function TfrmFatManutRomaneio.fRetSqlMensagemExpedicao(
  strTabela: string): string;
begin
  If SameText(strTabela, 'NOTGER') Then
  Begin
    Result := ' GER_NUMFAT = :NUMDOC AND ' +
              ' GER_TIPFAT = :ESPDOC AND ' +
              ' GER_EMPFAT = :CODEMP ';
  End
  Else
  Begin
    Result := ' GER_NUMDOC = :NUMDOC AND ' +
              ' GER_ESPDOC = :ESPDOC AND ' +
              ' GER_CODEMP = :CODEMP ';
  End;
end;

function TfrmFatManutRomaneio.fRetTabelaDet(strNomTab: String): String;
begin
  Result := '';

  If (strNomTab = 'MOVGER') Then
    Result := 'MOVDET'
  Else If (strNomTab = 'NOTGER') Then
    Result := 'NOTDET';
end;

function TfrmFatManutRomaneio.fRetVolumeItem(strCodIte: String;
  fltQtdIte: Double): Double;
Var
  fltMltVen: Double;
  blnVolEmb: Boolean;
  fltEmbala: Double;
Begin
  Result := 0;
  blnVolEmb := fCfgSis('TIPVOL') = '1';

  fltEmbala := fCampoTabela('ITE_EMBALA', 'CADITE', ['ITE_CODITE'], [strCodIte], False);

  If Not blnVolEmb Then
  Begin
    fltMltVen := fRetMltVenItem(strCodIte);

    If fltMltVen <= 0 Then
      fltMltVen := 1;

    Result := Result + Ceil(fFormataFloat(((fFormataFloat((fltQtdIte / fltMltVen), 4) * fFormataFloat((1 - fltMltVen), 4)) + fltQtdIte), 4));
  End
  Else
  Begin
    If fltEmbala <= 0 Then
      fltEmbala := 1;

    Result := Result + Ceil(fltQtdIte / fltEmbala);
  End;
End;

function TfrmFatManutRomaneio.fSelecionaDocumentos(AFgoDocs,
  AGerDocs, ANumRom: string): Boolean;
var
  LQryDocsSelecionados: TUniQuery;
begin
  LQryDocsSelecionados := fCriaQuery;

  try
    Result := False;
    LQryDocsSelecionados.Close;
    LQryDocsSelecionados.SQL.Clear;
    LQryDocsSelecionados.SQL.Add(fRetSQLDoc(AFgoDocs, AGerDocs));

    if fEmptyStr(LQryDocsSelecionados.SQL.Text) then
    begin
      Result := True; // No caso de não ter documentos sobrados para fazer um novo romaneio, ou seja, a deleção foi de um romaneio completo. Então retorna True para poder comitar.
      Exit;
    end;

    LQryDocsSelecionados.Open;

    if LQryDocsSelecionados.IsEmpty then
    begin
      Result := False;
      Exit;
    end;

    Result := fGravaRomaneio(LQryDocsSelecionados, FCodTra, FPlaVei, FCodMot, FNumBox,
                             FCodAj1, FCodAj2, FCodAj3, FCodAj4, FObsFec, FCodReg, ANumRom, FOpeRom, 'S', AFgoDocs, AGerDocs);
  finally
    FreeAndNil(LQryDocsSelecionados);
  end;
end;

function TfrmFatManutRomaneio.fTravaDestravaDocumento(const ATravar: Boolean; const AMarcandoTodos : Boolean; var AInterromperProcesso : Boolean): Boolean;
  Var
    LTravaRomaneio : TTravaRomaneio;
Begin
  AInterromperProcesso := False;

  Result := True;

  if (cdsDocumentosGER_MARDES.AsString = 'M') and ATravar then
    Exit;

  if (cdsDocumentosGER_MARDES.AsString = 'D') and (not ATravar) then
    Exit;

  if (cdsDocumentosGER_NUMROM.AsString = strNumRomCarregado) then
    Exit;

  If fTemAlgumDocumentoMarcado(cdsDocumentosGER_NUMROM.AsString, cdsDocumentosGER_EMPROM.AsString) Then
    Exit;

  LTravaRomaneio := TTravaRomaneio.Create(cdsDocumentosGER_NUMROM.AsString, cdsDocumentosGER_EMPROM.AsString, objLock);
  Try
    LTravaRomaneio.blnExibirMensagemAoTravarDocumento := False;
    Result := LTravaRomaneio.fTrava;
    If (Not Result) Then
    Begin
      If (AMarcandoTodos) Then
      Begin
        AInterromperProcesso := True;
        fMensagem('', 'Documentos deste romaneio estão sendo utilizados pela estação: ' + fGetHostLock(LTravaRomaneio.strUltimaChaveVerificada), ['&OK']);
      End
      Else
        fMensagem('ATENÇÃO!', Format('Este documento [%s] do romaneio está sendo utilizado por outra estação: %s', [cdsDocumentosGER_NUMDOC.AsString + '-' + cdsDocumentosGER_ESPDOC.AsString + '-' + cdsDocumentosGER_CODEMP.AsString, fGetHostLock(LTravaRomaneio.strUltimaChaveVerificada)]), ['&OK']);
    End;
  Finally
    FreeAndNil(LTravaRomaneio);
  End;
end;

function TfrmFatManutRomaneio.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If Sender = edtCodEmp Then
  Begin
    If Not fEmptyStr(edtCodEmp.Text) And (Length(arrEmpres) <= 1) Then
    Begin
      If Pos(edtCodEmp.Text, strAceRom) <= 0 Then
      Begin
        fMensagem('','Usuário sem permissão de acesso à empresa!',['&O K']);
        Result := False;
      End;
    End;
  End

  Else If (Sender = mskDtaIni) And
          (fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
  Begin
    fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&O k']);
    Result := False;
  End

  Else If (Sender = mskDtaFin) Then
  Begin
    If (fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) Then
    Begin
      fMensagem('', 'O campo Data Final deve ser preenchido!', ['&O k']);
      Result := False;
    End
    Else
    Begin
      If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
      Begin
        fMensagem('','A Data Final deve ser maior que a Data Inicial!',['&O K']);
         Result := False;
      End;
    End;
  End

  Else If (Sender = edtNumRom) Then
  Begin
    If (Not fEmptyStr(edtNumRom.Text)) Then
    Begin
      If (Not fRomaneioExiste(edtNumRom.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse romaneio não está cadastrado!', ['&Ok']);
        Result := False;
      End

      Else If (fRomaneioBaixado(edtNumRom.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse romaneio já está baixado!', ['&Ok']);
        edtNumRom.Clear;
        Result := False;
      End;
    End;
  End

  Else If (Sender = edtCodMot) And (Not fEmptyStr(edtCodMot.Text)) Then
  Begin
    If (Not fCarregaCadMot) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esse Motorista está inativo!', ['&OK']);
      Result := False;
      edtCodMot.Clear;
    End
    Else
    Begin
      If fEmptyStr(edtNomMot.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Motorista não está cadastrado!', ['&OK']);
        Result := False;
        edtCodMot.Clear;
      End;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmFatManutRomaneio.grdManutencaoDBTableViewKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_DELETE: pRemoveRegistro;
  end;
end;

procedure TfrmFatManutRomaneio.grdRomaneioBTNDESTOTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pMarcaDesmarcaTodos(False);
end;

procedure TfrmFatManutRomaneio.grdRomaneioBTNMARTOTPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pMarcaDesmarcaTodos(True);
end;

procedure TfrmFatManutRomaneio.grdRomaneioBTNMOVERPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  pMoverPedido;
end;

procedure TfrmFatManutRomaneio.grdRomaneioDBTableView2CustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;

  If VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdRomaneioDETMARDES.Index]) = 'M' Then
  Begin
    ACanvas.Brush.Color := clBlue;
    ACanvas.Font.Color := clWhite;
  End
  Else
  Begin
    ACanvas.Brush.Color := clWhite;
    ACanvas.Font.Color := clBlack;
  End;
end;

procedure TfrmFatManutRomaneio.grdRomaneioDBTableView2DblClick(Sender: TObject);
begin
  inherited;
  pMarcaDesmarcaDocumento;
end;

procedure TfrmFatManutRomaneio.grdRomaneioDBTableView2KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_RETURN: pMarcaDesmarcaDocumento;
  end;
end;

procedure TfrmFatManutRomaneio.pAdicionaDadosRomDet(ANumDoc, AEspDoc, ACodEmp,
  ACodCli, AEntSai, AAutInc, ANomTab, AClaFis: string);
var
  strSQL   : String;
  qryGenDet: TUniQuery;
  blnDocTemItemRepetido: Boolean;
begin
  If (AEspDoc = 'OX') Then
  Begin
    Exit;
  End;

  blnDocTemItemRepetido := fDocumentoTemItemRepetido(ANomTab, ANumDoc, AEspDoc, ACodEmp);

  qryGenDet := fCriaQuery(Self);
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  ' + QuotedStr(AAutInc) + ' DET_SEQGER, ';

    If (Pos(strOpcRom, '1_5_') > 0) Or (SameText(ANomTab, 'FATGOR')) Then
      strSQL := strSQL + fAdicionaRomDetOpcRom_1_5(AAutInc, AEspDoc, AEntSai, AClaFis, blnDocTemItemRepetido)
    Else If (strOpcRom = '2') Then
      strSQL := strSQL + fAdicionaRomDetOpcRom_2(AEspDoc, AEntSai, AClaFis, blnDocTemItemRepetido)
    Else
      strSQL := strSQL + fAdicionaRomDetOpcRom_3_4(AAutInc, AEspDoc, AEntSai, AClaFis, blnDocTemItemRepetido);

    qryGenDet.Close;
    qryGenDet.SQL.Clear;
    qryGenDet.SQL.Add(strSQL);
    qryGenDet.ParamByName('ITESER').AsString := fCfgSis('ITESER');
    qryGenDet.ParamByName('SERTER').AsString := fCfgSis('SERTER');
    qryGenDet.ParamByName('NUMDOC').AsString := ANumDoc;
    qryGenDet.ParamByName('ESPDOC').AsString := AEspDoc;
    qryGenDet.ParamByName('CODCLI').AsString := ACodCli;
    qryGenDet.ParamByName('CODEMP').AsString := ACodEmp;
    qryGenDet.Open;

    pCopiaParaTemporaria(qryGenDet, cdsRomDet);

  Finally
    FreeAndNil(qryGenDet);
  End;
end;

procedure TfrmFatManutRomaneio.pAtualizaQtdBaiDetGeral(strNumDoc, strEspDoc,
  strCodEmp, strCodCli, strTabelaMovDet: String; blnUsaPreRom: Boolean;
  var cdsRomDet, cdsTmp: TUniClientDataSet; strClaFis: String;
  blnDocTemItemRepetido: Boolean);
var
  blnChaveExiste: Boolean;
begin
  cdsRomDet.First;
  While Not cdsRomDet.Eof Do
  Begin
    if fAgrupaPorAutoIncrem(strClaFis, blnDocTemItemRepetido) then
      blnChaveExiste := cdsTmp.FindKey([cdsRomDet.FieldByName('DET_CODITE').AsString, cdsRomDet.FieldByName('DET_DESITE').AsString, cdsRomDet.FieldByName('DET_NUMLOT').AsString, cdsRomDet.FieldByName('DET_AUTINC').AsString])
    else
      blnChaveExiste := cdsTmp.FindKey([cdsRomDet.FieldByName('DET_CODITE').AsString, cdsRomDet.FieldByName('DET_DESITE').AsString, cdsRomDet.FieldByName('DET_NUMLOT').AsString]);

    If blnChaveExiste Then
    Begin
      cdsTmp.Edit;
      cdsTmp.FieldByName('DET_QTDBAI').AsFloat := cdsTmp.FieldByName('DET_QTDBAI').AsFloat + cdsRomDet.FieldByName('DET_QTDBAI').AsFloat;
      cdsTmp.FieldByName('DET_QTDITE').AsFloat := cdsTmp.FieldByName('DET_QTDITE').AsFloat + cdsRomDet.FieldByName('DET_QTDITE').AsFloat;
    End
    Else
    Begin
      cdsTmp.Append;
      cdsTmp.FieldByName('DET_CODITE').AsString := cdsRomDet.FieldByName('DET_CODITE').AsString;
      cdsTmp.FieldByName('DET_QTDBAI').AsFloat  := cdsRomDet.FieldByName('DET_QTDBAI').AsFloat;
      cdsTmp.FieldByName('DET_DESITE').AsString := cdsRomDet.FieldByName('DET_DESITE').AsString;
      cdsTmp.FieldByName('DET_NUMLOT').AsString := cdsRomDet.FieldByName('DET_NUMLOT').AsString;
      cdsTmp.FieldByName('DET_AUTINC').AsString := cdsRomDet.FieldByName('DET_AUTINC').AsString;
      cdsTmp.FieldByName('DET_QTDITE').AsFloat  := cdsRomDet.FieldByName('DET_QTDITE').AsFloat;
      cdsTmp.FieldByName('DET_TOTPES').AsFloat  := cdsRomDet.FieldByName('DET_TOTPES').AsFloat;
      cdsTmp.FieldByName('DET_INFITE').AsString := cdsRomDet.FieldByName('DET_INFITE').AsString;
      cdsTmp.FieldByName('DET_SEPIMP').AsString := cdsRomDet.FieldByName('DET_SEPIMP').AsString;
      cdsTmp.FieldByName('DET_UNITAR').AsFloat  := cdsRomDet.FieldByName('DET_UNITAR').AsFloat;
    End;

    cdsTmp.Post;

    cdsRomDet.Next;
  End;
end;

procedure TfrmFatManutRomaneio.pConsultaRomaneios;
var
  LDocumentos: TUniQuery;
  LSQL: string;
begin
  if (cdsManut.IsEmpty) then
    pDestravaTodasAsTravas
  else
    pMarcaDesmarcaTodos(False);

  cdsRomaneio.Close;
  qryRomaneio.Close;
  qryRomaneio.SQL.Clear;
  qryRomaneio.SQL.Add('SELECT ');
  qryRomaneio.SQL.Add('       R.GER_NUMROM ');
  qryRomaneio.SQL.Add('     , R.GER_DTAENT ');
  qryRomaneio.SQL.Add('     , C.MOT_NOMMOT ');
  qryRomaneio.SQL.Add('     , (SELECT SUM(D.DET_TOTPES) FROM ROMDETX D ');
  qryRomaneio.SQL.Add('         WHERE D.DET_NUMROM = R.GER_NUMROM AND D.DET_EMPROM = R.GER_EMPROM) AS GER_PESBRU ');
  qryRomaneio.SQL.Add('     , SUM(R.GER_VLRCON) AS GER_VLRCON ');
  qryRomaneio.SQL.Add('     , CAST(" " AS CHAR(1)) AS BTNMAR ');
  qryRomaneio.SQL.Add('     , CAST(" " AS CHAR(1)) AS BTNDES ');
  qryRomaneio.SQL.Add('     , CAST(" " AS CHAR(1)) AS BTNMOV ');
  qryRomaneio.SQL.Add('     , R.GER_EMPROM ');
  qryRomaneio.SQL.Add('     , (SELECT SUM(D.DET_PESLIQ) FROM ROMDETX D ');
  qryRomaneio.SQL.Add('         WHERE D.DET_NUMROM = R.GER_NUMROM AND D.DET_EMPROM = R.GER_EMPROM) AS GER_PESLIQ ');
  qryRomaneio.SQL.Add('  FROM ROMGERX R ');
  qryRomaneio.SQL.Add(' INNER JOIN CADMOT C ON(R.GER_CODMOT = C.MOT_CODMOT) ');
  qryRomaneio.SQL.Add(' WHERE R.GER_DTABAI IS NULL ');
  fCondicao(qryRomaneio);
  qryRomaneio.SQL.Add(' GROUP BY ');
  qryRomaneio.SQL.Add('       R.GER_NUMROM ');
  qryRomaneio.Open;
  cdsRomaneio.Open;

  LDocumentos := fCriaQuery;

  try
    cdsDocumentos.DisableControls;
    cdsDocumentos.EmptyDataSet;
    dtsDocumentos.DataSet := nil;

    LDocumentos.Close;
    LDocumentos.SQL.Clear;
    LDocumentos.SQL.Add('SELECT R.GER_NUMROM, R.GER_CODCLI, C.CLI_NOMCLI, R.GER_NUMDOC, R.GER_ESPDOC, CONCAT(R.GER_NUMDOC,"-",R.GER_ESPDOC) AS GER_DOCUME, SUM(RD.DET_TOTPES) AS GER_PESBRU, R.GER_VLRCON, R.AUTOINCREM ');
    LDocumentos.SQL.Add(', IFNULL(E.ETC_CEPENT, C.CLI_C_E_P_) AS CEPENT, IFNULL(I.CID_NOMCID, D.CID_NOMCID) AS CIDENT, R.GER_EMPROM, SUM(RD.DET_PESLIQ) AS GER_PESLIQ, R.GER_ENTSAI, R.GER_CODEMP, R.GER_NOMTAB, ');

    If (strOpcRom = '5') Then
    Begin
      LDocumentos.SQL.Add(' (SELECT DISTINCT');
      LDocumentos.SQL.Add('   GROUP_CONCAT(');
      LDocumentos.SQL.Add('     DISTINCT DET_FAT.DET_NUMDOC,');
      LDocumentos.SQL.Add('     "-",');
      LDocumentos.SQL.Add('     DET_FAT.DET_ESPDOC,');
      LDocumentos.SQL.Add('     "-",');
      LDocumentos.SQL.Add('     DET_FAT.DET_CODEMP');
      LDocumentos.SQL.Add('   )');
      LDocumentos.SQL.Add(' FROM');
      LDocumentos.SQL.Add('   MOVDET DET_FAT');
      LDocumentos.SQL.Add(' WHERE DET_FAT.DET_NUM_PD = F.FGO_NUMDOC');
      LDocumentos.SQL.Add('   AND DET_FAT.DET_ESP_PD = F.FGO_ESPDOC');
      LDocumentos.SQL.Add('   AND DET_FAT.DET_EMP_PD = F.FGO_CODEMP');
      LDocumentos.SQL.Add('   AND DET_FAT.DET_CODCLI = F.FGO_CODCLI');
      LDocumentos.SQL.Add(' ) AS DOCS_FAT');
    End
    Else
      LDocumentos.SQL.Add(' "" AS DOCS_FAT');

    LDocumentos.SQL.Add('FROM ROMGERX R');
    LDocumentos.SQL.Add('INNER JOIN ROMDETX RD');
    LDocumentos.SQL.Add('ON(R.GER_NUMROM = RD.DET_NUMROM AND R.GER_EMPROM = RD.DET_EMPROM AND R.GER_NUMDOC = RD.DET_NUMDOC AND R.GER_ESPDOC = RD.DET_ESPDOC AND R.GER_CODEMP = RD.DET_CODEMP)');
    LDocumentos.SQL.Add('LEFT JOIN CADCLI C');
    LDocumentos.SQL.Add('ON(R.GER_CODCLI = C.CLI_CODCLI)');
    LDocumentos.SQL.Add('LEFT JOIN CADCID D');
    LDocumentos.SQL.Add('ON(C.CLI_CODCID = D.CID_CODCID)');

    if (Pos(strOpcRom,'1_5_') > 0) Then
    begin
      LDocumentos.SQL.Add('LEFT JOIN FATGOR F');
      LDocumentos.SQL.Add('ON(R.GER_NUMDOC = F.FGO_NUMDOC AND R.GER_ESPDOC = F.FGO_ESPDOC AND R.GER_CODEMP = F.FGO_CODEMP AND R.GER_CODCLI = F.FGO_CODCLI)');
      LDocumentos.SQL.Add('LEFT JOIN AUXGOR A');
      LDocumentos.SQL.Add('ON(F.AUTOINCREM = A.AUX_SEQGER)');
    end
    else
    begin
      LDocumentos.SQL.Add('LEFT JOIN MOVGER G');
      LDocumentos.SQL.Add('ON(R.GER_NUMDOC = G.GER_NUMDOC AND R.GER_ESPDOC = G.GER_ESPDOC AND R.GER_CODEMP = G.GER_CODEMP AND R.GER_CODCLI = G.GER_CODCLI)');
      LDocumentos.SQL.Add('LEFT JOIN AUXMOV A');
      LDocumentos.SQL.Add('ON(G.AUTOINCREM = A.AUX_SEQGER)');
    end;


    LDocumentos.SQL.Add('LEFT JOIN ENTCLI E');
    LDocumentos.SQL.Add('ON(A.AUX_ENTGER = E.AUTOINCREM)');
    LDocumentos.SQL.Add('LEFT JOIN CADCID I');
    LDocumentos.SQL.Add('ON(E.ETC_CIDENT = I.CID_CODCID) ');
    LDocumentos.SQL.Add('WHERE R.GER_DTABAI IS NULL');
    fCondicao(LDocumentos);

    LDocumentos.SQL.Add('GROUP BY GER_NUMROM, GER_NUMDOC, GER_ESPDOC, GER_CODEMP');

    if (Pos(strOpcRom,'1_5_') <= 0) Then
    begin
      LSQL := AnsiReplaceStr(AnsiReplaceStr(LDocumentos.SQL.Text ,'MOVGER' ,'NOTGER'), 'AUXMOV', 'AUXNOT');
      LDocumentos.SQL.Add('UNION');
      LDocumentos.SQL.Add(LSQL);
      LSQL := AnsiReplaceStr(AnsiReplaceStr(LSQL, 'NOTGER' ,'OUTDIGX'), 'G.GER', 'G.DIG');
      LDocumentos.SQL.Add('UNION');
      LDocumentos.SQL.Add(LSQL);
    end;

    LDocumentos.Open;

    if LDocumentos.IsEmpty then
      Exit;

    while not LDocumentos.Eof do
    begin
      cdsDocumentos.Append;
      cdsDocumentosGER_NUMROM.AsString := LDocumentos.FieldByName('GER_NUMROM').AsString;
      cdsDocumentosGER_NUMDOC.AsString := LDocumentos.FieldByName('GER_NUMDOC').AsString;
      cdsDocumentosGER_ESPDOC.AsString := LDocumentos.FieldByName('GER_ESPDOC').AsString;
      cdsDocumentosGER_CODCLI.AsString := LDocumentos.FieldByName('GER_CODCLI').AsString;
      cdsDocumentosCLI_NOMCLI.AsString := LDocumentos.FieldByName('CLI_NOMCLI').AsString;
      cdsDocumentosGER_DOCUME.AsString := LDocumentos.FieldByName('GER_DOCUME').AsString;
      cdsDocumentosDOCS_FAT.AsString  := LDocumentos.FieldByName('DOCS_FAT').AsString;
      cdsDocumentosGER_PESBRU.AsFloat := LDocumentos.FieldByName('GER_PESBRU').AsFloat;
      cdsDocumentosGER_PESLIQ.AsFloat := LDocumentos.FieldByName('GER_PESLIQ').AsFloat;
      cdsDocumentosGER_VLRCON.AsFloat := LDocumentos.FieldByName('GER_VLRCON').AsFloat;
      cdsDocumentosAUTOINCREM.AsString := LDocumentos.FieldByName('AUTOINCREM').AsString;
      cdsDocumentosCEPENT.AsString := LDocumentos.FieldByName('CEPENT').AsString;
      cdsDocumentosCIDENT.AsString := LDocumentos.FieldByName('CIDENT').AsString;
      cdsDocumentosGER_EMPROM.AsString := LDocumentos.FieldByName('GER_EMPROM').AsString;
      cdsDocumentosGER_CODEMP.AsString := LDocumentos.FieldByName('GER_CODEMP').AsString;
      cdsDocumentosGER_NOMTAB.AsString := LDocumentos.FieldByName('GER_NOMTAB').AsString;
      cdsDocumentosGER_MARDES.AsString := 'D';

      if cdsManut.Locate('GER_NUMDOC;GER_ESPDOC;GER_CODEMP',
                         VarArrayOf([cdsDocumentosGER_NUMDOC.AsString,
                                     cdsDocumentosGER_ESPDOC.AsString,
                                     cdsDocumentosGER_CODEMP.AsString]), []) then
        cdsDocumentosGER_MARDES.AsString := 'M';
        

      cdsDocumentos.Post;
      LDocumentos.Next;
    end;

    lblTotDoc.Caption := 'Total de Documentos: ' + IntToStr(cdsDocumentos.RecordCount);
    lbltotDocSel.Caption := 'Total Selecionado: 0';
    lblTotPesSel.Caption := 'Peso Doc. Selecionado: 0.000,00';
    lblTotValSel.Caption := 'Valor Doc. Selecionado: 0.000,00';
  finally
    cdsDocumentos.EnableControls;
    FreeAndNil(LDocumentos);
    dtsDocumentos.DataSet := cdsDocumentos;
  end;
end;

procedure TfrmFatManutRomaneio.pCopiaParaTemporaria(AQryDados: TUniQuery;
  var ACdsDados: TUniClientDataSet);
var
  LCnt : Integer;
  LCampo : TField;
  LScroll: TprcScroll;
  LWasEnabled: Boolean;
begin
  LWasEnabled := Not ACdsDados.ControlsDisabled;

  If LWasEnabled Then
    pDisableControls(ACdsDados, LScroll);

  If (ACdsDados.Active) Then
    ACdsDados.EmptyDataSet;

  If (Not ACdsDados.Active) Then
  Begin
    ACdsDados := fCriaClientDatset(AQryDados, True);
    pSetaClient(ACdsDados);

    pFormataCamposCds(ACdsDados);
  End;

  Screen.Cursor := crSQLWait;

  AQryDados.First;
  While Not AQryDados.Eof Do
  Begin
    ACdsDados.Append;
    For LCnt := 0 To AQryDados.FieldCount -1 Do
    Begin
      If (Not AQryDados.Fields[LCnt].IsNull) Then
      Begin
        LCampo := ACdsDados.FindField(AQryDados.Fields[LCnt].FieldName);
        If LCampo <> Nil Then
          ACdsDados.FieldByName(LCampo.FieldName).Value := AQryDados.Fields[LCnt].Value;
      End;
    End;

    ACdsDados.Post;

    AQryDados.Next;
  End;

  Screen.Cursor         := crDefault;

  If LWasEnabled Then
    pEnableControls(ACdsDados, LScroll);
end;

procedure TfrmFatManutRomaneio.pDestravaLock(ALock: TLock);
var
  LChaLck: String;
  LLibera: Boolean;
begin
  for LChaLck in ALock.fRetornaTravas do
  begin
    LLibera := (Not fVerificaLockAtivo(LChaLck + STR_TRAVA_CONFERENCIA));

    if LLibera then
      fLock_Unlock(LChaLck, False, False, False, '', True, '', False, False, True, True, True, False);
  end;

  ALock.fRetornaTravas.Clear;
end;

procedure TfrmFatManutRomaneio.pDestravaTodasAsTravas;
begin
  pDestravaLock(objLock);

  if blnGravou then
    pDestravaLock(objLockRomaneio);
end;

procedure TfrmFatManutRomaneio.pGravaLogRomaneioSemRomDetX;
  Var
    LDocumentos : String;
    LManutencao : String;
    LAcao : String;
    LMensagem : String;
begin
  LDocumentos := EmptyStr;

  cdsDocumentos.First;
  While Not cdsDocumentos.Eof Do
  Begin
    If cdsDocumentos.FieldByName('GER_MARDES').AsString <> 'M' Then
    Begin
      cdsDocumentos.Next;
      Continue;
    End;

    If (Not fEmptyStr(LDocumentos)) Then
      LDocumentos := LDocumentos + sLineBreak;

    LDocumentos := LDocumentos + 'Romaneio: ' + cdsDocumentosGER_NUMROM.AsString + '-' +
      cdsDocumentosGER_EMPROM.AsString + ' - Documento: ' + cdsDocumentosGER_NUMDOC.AsString + '-' + cdsDocumentosGER_ESPDOC.AsString + '-' + cdsDocumentosGER_CODEMP.AsString + '-' + cdsDocumentosGER_CODCLI.AsString;

    cdsDocumentos.Next;
  End;

  LManutencao := EmptyStr;
  cdsManut.First;
  While Not cdsManut.Eof Do
  Begin
    If (Not fEmptyStr(LManutencao)) Then
      LManutencao := LManutencao + sLineBreak;

    LManutencao := LManutencao + 'Romaneio: ' + cdsManutGER_NUMROM.AsString + '-' +
      cdsManutGER_EMPROM.AsString + ' - Documento: ' + cdsManutGER_NUMDOC.AsString + '-' + cdsManutGER_ESPDOC.AsString + '-' + cdsManutGER_CODEMP.AsString + '-' + cdsManutGER_CODCLI.AsString;

    cdsManut.Next;
  End;

  LAcao := 'Indefinido';
  case FAcaoRomaneio of
    tpRemover: LAcao := 'Remover';
    tpGerar: LAcao := 'Gerar Novo';
    tpIncluir: LAcao := 'Incluir';
  end;

  LMensagem := 'ROMANEIOS E DOCUMENTOS SELECIONADOS (LADO ESQUERDO):' + sLineBreak;
  LMensagem := LMensagem + LDocumentos + sLineBreak;
  LMensagem := LMensagem + 'DOCUMENTOS EM MANUTENÇÃO (LADO DIREITO):' + sLineBreak;
  LMensagem := LMensagem + LManutencao + sLineBreak;
  LMensagem := LMensagem + 'Ação: ' + LAcao + sLineBreak;
  LMensagem := LMensagem + 'Romaneio: ' + FNumRom + '-' + FEmpRom + sLineBreak;
  LMensagem := LMensagem + sLineBreak;
  LMensagem := LMensagem + fRetornaStack;
  pGravarErro(True, 'MANUTENÇÃO DE ROMANEIO: GRAVOU ROMGERX SEM ROMDETX', LMensagem);
end;

procedure TfrmFatManutRomaneio.pFormataCamposCds(
  var ACdsDados: TUniClientDataSet);
begin
  If ACdsDados.FindField('GER_VLRCON') <> Nil Then
    TFloatField(ACdsDados.FieldByName('GER_VLRCON')).DisplayFormat := '#,##0.00';

  If ACdsDados.FindField('GER_PESBRU') <> Nil Then
    TFloatField(ACdsDados.FieldByName('GER_PESBRU')).DisplayFormat := '#,##0.000';

  If (ACdsDados.FindField('GER_DTAENT') <> Nil) And
     (ACdsDados.FieldByName('GER_DTAENT').DataType In [ftDate, ftDateTime]) Then
    TDateField(ACdsDados.FieldByName('GER_DTAENT')).DisplayFormat := 'dd/mm/yyyy';

  If (ACdsDados.FindField('GER_DTENTR') <> Nil) And
     (ACdsDados.FieldByName('GER_DTENTR').DataType In [ftDate, ftDateTime]) Then
    TDateField(ACdsDados.FieldByName('GER_DTENTR')).DisplayFormat := 'dd/mm/yyyy';
end;

procedure TfrmFatManutRomaneio.pInfTabelaGravaRomaneio(strNomTab: string;
  var strTabelaMovDet: string; var blnPedOrc: Boolean);
begin
  If (strNomTab = 'FATGOR') Then
    blnPedOrc := True
  Else
    blnPedOrc := False;

  If (Pos(strOpcRom, '34') <= 0) Then
    strTabelaMovDet := 'MOVDET'
  Else
  Begin
    strTabelaMovDet := AnsiReplaceStr(strNomTab, 'GER', 'DET');
  End;
end;

procedure TfrmFatManutRomaneio.pMarcaDesmarcaDocumento;
var
  LDocAlt,
  LMarDes: String;
  LInterromperProcesso : Boolean;
begin
  if not grdRomaneioDBTableView2.DataController.DataSet.Active then
    Exit;

  if grdRomaneioDBTableView2.DataController.DataSet.RecordCount = 0 then
    Exit;

  if grdRomaneioDBTableView2.DataController.DataSet.RecNo <= 0 then
    Exit;

  LMarDes := grdRomaneioDBTableView2.DataController.DataSet.FieldByName('GER_MARDES').AsString;

  if (not fPodeDesmarcarDocumento(LMarDes = 'D')) then
    Exit;

  if fDocumentoSofreuAlteracao(LDocAlt, (LMarDes = 'D')) then
  begin
    fMensagem('', 'O documento ' + Copy(LDocAlt, 1, Length(LDocAlt) - 2) + ' que está tentando selecionar sofreu alteração. ' + #13#10 +
                  'Você deve clicar novamente no botão consultar para recarregar os documentos com os dados atualizados!', ['&OK']);
    Exit;
  end;

  If (LMarDes = 'D') And
     fExisteCancelamentoPendentePorChaveAcesso(cdsDocumentosGER_NUMDOC.AsString,
                                               cdsDocumentosGER_ESPDOC.AsString,
                                               cdsDocumentosGER_CODEMP.AsString,
                                               cdsDocumentosGER_CODCLI.AsString) Then
    Exit;

  try
    if (not fTravaDestravaDocumento(LMarDes = 'D', False, LInterromperProcesso)) then
      Exit;

    grdRomaneioDBTableView2.DataController.DataSet.DisableControls;

    grdRomaneioDBTableView2.DataController.DataSet.Edit;

    if grdRomaneioDBTableView2.DataController.DataSet.FieldByName('GER_MARDES').AsString = 'D' then
      grdRomaneioDBTableView2.DataController.DataSet.FieldByName('GER_MARDES').AsString := 'M'
    else
      grdRomaneioDBTableView2.DataController.DataSet.FieldByName('GER_MARDES').AsString := 'D' ;

    grdRomaneioDBTableView2.DataController.DataSet.Post;

    If (grdRomaneioDBTableView2.DataController.DataSet.FieldByName('GER_MARDES').AsString = 'D') Then
      pValidaSeNecessitaDestravarLocks(grdRomaneioDBTableView2.DataController.DataSet.FieldByName('GER_NUMROM').AsString, grdRomaneioDBTableView2.DataController.DataSet.FieldByName('GER_EMPROM').AsString);

    pSomaTotais;
  finally
    grdRomaneioDBTableView2.DataController.DataSet.EnableControls;
  end;
end;

procedure TfrmFatManutRomaneio.pMarcaDesmarcaTodos(AMarca: Boolean);
var
  LPosicao: integer;
  LDocsAlt: String;
  LNumRom : String;
  LEmpRom : String;
  LInterromperProcesso : Boolean;
begin
  if not cdsRomaneio.Active then
    Exit;

  if cdsRomaneio.RecordCount = 0 then
    exit;

  if cdsRomaneio.RecNo <= 0 then
    Exit;

  if not cdsDocumentos.Active then
    Exit;

  if cdsDocumentos.RecordCount = 0 then
    exit;

  cdsDocumentos.DisableControls;
  LPosicao := cdsDocumentos.RecNo;
  LDocsAlt := '';

  try
    LNumRom := EmptyStr;
    LEmpRom := EmptyStr;
    cdsDocumentos.First;

    while not cdsDocumentos.Eof do
    begin
      LInterromperProcesso := False;
      if (cdsDocumentos.FieldByName('GER_NUMROM').AsString <> cdsRomaneio.FieldByName('GER_NUMROM').AsString) or
        (fDocumentoSofreuAlteracao(LDocsAlt, AMarca)) or
        (not fPodeDesmarcarDocumento(AMarca)) or
        (not fTravaDestravaDocumento(AMarca, True, LInterromperProcesso)) then
      begin
        If (LInterromperProcesso) Then
          Break;

        cdsDocumentos.Next;
        Continue;
      end;

      LNumRom := cdsDocumentos.FieldByName('GER_NUMROM').AsString;
      LEmpRom := cdsDocumentos.FieldByName('GER_EMPROM').AsString;

      cdsDocumentos.Edit;
      cdsDocumentos.FieldByName('GER_MARDES').AsString := IIF(AMarca, 'M', 'D');
      cdsDocumentos.Post;

      cdsDocumentos.Next;
    end;

    If (Not AMarca) Then
      pValidaSeNecessitaDestravarLocks(LNumRom, LEmpRom);

    cdsDocumentos.RecNo := LPosicao;
    pSomaTotais;

    if (not fEmptyStr(LDocsAlt)) then
    begin
      fMensagem('', 'Os documentos abaixo não foram selecionados pois sofreram alteração. ' + #13#10 +
                    'Você deve clicar novamente no botão consultar para recarregar os documentos com os dados atualizados!' + #13#10 +
                    Copy(LDocsAlt, 1, Length(LDocsAlt) - 2), ['&OK']);
    end;
  finally
    cdsDocumentos.EnableControls;
  end;
end;

procedure TfrmFatManutRomaneio.pMoverPedido;
var
  LField: TField;
  LPosicao: Integer;
begin
  cdsDocumentos.DisableControls;
  cdsManut.DisableControls;
  LPosicao := cdsDocumentos.RecNo;

  try
    cdsDocumentos.First;

    while not cdsDocumentos.Eof do
    begin
      if cdsDocumentos.FieldByName('GER_MARDES').AsString = 'M' then
      begin
        if fEntregaIniciadaPeloMotorista(cdsDocumentos.FieldByName('GER_NUMROM').AsString,
                                         cdsDocumentos.FieldByName('GER_NUMDOC').AsString,
                                         cdsDocumentos.FieldByName('GER_ESPDOC').AsString,
                                         cdsDocumentos.FieldByName('GER_CODEMP').AsString) then
        begin
          fMensagem('ATENÇÃO!', 'Não é permitido realizar alterações em romaneios com este documento pois o motorista já iniciou ' +
                    'a entrega pelo APP Tá Entregue. Entre em contato com o motorista para verificar a situação da entrega.' + #13 + 'Se for ' +
                    'o caso, peça para o motorista baixar o documento como não entregue através do APP e libere o documento pelo painel de ' +
                    'entrega para que ele possa ser inserido em um romaneio novo.', ['&Ok']);

          cdsDocumentos.Edit;
          cdsDocumentos.FieldByName('GER_MARDES').AsString := 'D';
          cdsDocumentos.Post;
          pValidaSeNecessitaDestravarLocks(cdsDocumentos.FieldByName('GER_NUMROM').AsString, cdsDocumentos.FieldByName('GER_EMPROM').AsString);
          Exit;
        end;

        if cdsDocumentos.FieldByName('GER_NUMROM').AsString = cdsRomaneio.FieldByName('GER_NUMROM').AsString then
        begin
          if not cdsManut.Locate('AUTOINCREM', cdsDocumentos.FieldByName('AUTOINCREM').AsString, []) then
          begin
            cdsManut.Append;
            for LField in cdsDocumentos.Fields do
              if Assigned(cdsManut.FindField(LField.FieldName)) then
                cdsManut.FieldByName(LField.FieldName).Value := LField.Value;

            cdsManut.Post;
          end;
        end;
      end;

      cdsDocumentos.Next;
    end;
  finally
    cdsDocumentos.RecNo := LPosicao;
    cdsDocumentos.EnableControls;
    cdsManut.EnableControls;
  end;
end;

procedure TfrmFatManutRomaneio.pPegaMsgDocBaixaEntFut(
  var stlMsgExp: TStringList; strNumDoc, strEspDoc, strCodEmp: string);
var
  qryDocFut: TUniQuery;
  strIncFut: string;
begin
  qryDocFut := fCriaQuery;
  strIncFut := EmptyStr;

  try
    qryDocFut.Close;
    qryDocFut.SQL.Clear;
    qryDocFut.SQL.Add(' SELECT ');
    qryDocFut.SQL.Add(' MT.DET_INCFUT  ');
    qryDocFut.SQL.Add(' FROM MOVGER ');
    qryDocFut.SQL.Add(' INNER JOIN MOVDET MD ON MD.DET_SEQGER = MOVGER.AUTOINCREM ');
    qryDocFut.SQL.Add(' INNER JOIN MOVTRI MT ON MT.DET_SEQGER = MD.AUTOINCREM     ');
    qryDocFut.SQL.Add('  WHERE ');
    qryDocFut.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
    qryDocFut.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
    qryDocFut.SQL.Add('  GER_CODEMP = :CODEMP AND ');
    qryDocFut.SQL.Add('  DET_INCFUT IS NOT NULL   ');

    qryDocFut.ParamByName('NUMDOC').AsString := strNumDoc;
    qryDocFut.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDocFut.ParamByName('CODEMP').AsString := strCodEmp;
    qryDocFut.Open;

    While Not qryDocFut.Eof Do
    Begin
      strIncFut := strIncFut + QuotedStr(qryDocFut.FieldByName('DET_INCFUT').AsString);

      If qryDocFut.RecNo < qryDocFut.RecordCount Then
        strIncFut := strIncFut + '_';

       Next;
    End;


    If (Not fEmptyStr(strIncFut)) Then
    Begin
      strIncFut := AnsiReplaceStr(strIncFut,'_', ',');

      qryDocFut.Close;
      qryDocFut.SQL.Clear;
      qryDocFut.SQL.Add('SELECT ');
      qryDocFut.SQL.Add('  GER_MENEXP,');
      qryDocFut.SQL.Add('  GER_MENEX2,');
      qryDocFut.SQL.Add('  GER_MENEX3,');
      qryDocFut.SQL.Add('  GER_MENEX4 ');
      qryDocFut.SQL.Add('  FROM ');
      qryDocFut.SQL.Add('  MOVGER ');
      qryDocFut.SQL.Add('  INNER JOIN MOVDET MD ON MD.DET_SEQGER = MOVGER.AUTOINCREM ');
      qryDocFut.SQL.Add('  WHERE MD.AUTOINCREM IN ('+strIncFut+')');
      qryDocFut.SQL.Add('  GROUP BY MD.DET_SEQGER');
      qryDocFut.Open;
      While Not qryDocFut.Eof Do
      Begin
        stlMsgExp.Add(qryDocFut.FieldByName('GER_MENEXP').AsString);
        stlMsgExp.Add(qryDocFut.FieldByName('GER_MENEX2').AsString);
        stlMsgExp.Add(qryDocFut.FieldByName('GER_MENEX3').AsString);
        stlMsgExp.Add(qryDocFut.FieldByName('GER_MENEX4').AsString);
        qryDocFut.Next;
      End;
    End;
  finally
    FreeAndNil(qryDocFut);
  end;
end;

function TfrmFatManutRomaneio.fPedeTelaTransportadora(var ADadosTranspMot : TDadosTranspMot): Boolean;
var
  frmFatRomTransMot: TfrmFatRomTransMot;
begin
  pCriarFormularios(TfrmFatRomTransMot, frmFatRomTransMot);
  try
    Result := False;

    frmFatRomTransMot.btnRoteiro.Visible := False;

    FillChar(ADadosTranspMot, SizeOf(ADadosTranspMot), #0);

    if frmFatRomTransMot.ShowModal = mrOk then
    begin
      FCodTra := frmFatRomTransMot.edtCodTra.Text;
      FCodMot := frmFatRomTransMot.edtCodMot.Text;
      FCodAj1 := frmFatRomTransMot.edtCodAj1.Text;
      FCodAj2 := frmFatRomTransMot.edtCodAj2.Text;
      FCodAj3 := frmFatRomTransMot.edtCodAj3.Text;
      FCodAj4 := frmFatRomTransMot.edtCodAj4.Text;
      FObsFec := frmFatRomTransMot.mmoObsFec.Text;
      FPlaVei := fTiraCaracEspeciais(frmFatRomTransMot.mskPlaVei.Text);
      FCodReg := frmFatRomTransMot.edtCodReg.Text;
      FVlrFre := fStrToFloat(frmFatRomTransMot.edtVlrFrete.Text);
      FVlrAdi := fStrToFloat(frmFatRomTransMot.edtVlrAdiant.Text);
      FPerFre := fStrToFloat(frmFatRomTransMot.edtPercFrete.Text);
      FNumBox := EmptyStr;
      FDtaRom := fRetDataServidor;
      FHorRom := fRetHoraServidor;

      ADadosTranspMot.strCodTra := FCodTra;
      ADadosTranspMot.strCodMot := FCodMot;
      ADadosTranspMot.strCodAj1 := FCodAj1;
      ADadosTranspMot.strCodAj2 := FCodAj2;
      ADadosTranspMot.strCodAj3 := FCodAj3;
      ADadosTranspMot.strCodAj4 := FCodAj4;
      ADadosTranspMot.strObsFec := FObsFec;
      ADadosTranspMot.strPlaVei := FPlaVei;
      ADadosTranspMot.strCodReg := FCodReg;
      ADadosTranspMot.fltVlrFre := FVlrFre;
      ADadosTranspMot.fltVlrAdi := FVlrAdi;
      ADadosTranspMot.fltPerFre := FPerFre;
      ADadosTranspMot.strNumBox := FNumBox;
      ADadosTranspMot.dtaDtaRom := FDtaRom;
      ADadosTranspMot.dtaHorRom := FHorRom;

      Result := True;
    end;
  finally
    pFreeAndNil(frmFatRomTransMot);
  end;
end;

function TfrmFatManutRomaneio.fPodeDesmarcarDocumento(AMarcar: Boolean): Boolean;
begin
  Result := True;

  if AMarcar then
    Exit;

  Result := (not cdsManut.Locate('GER_NUMDOC;GER_ESPDOC;GER_CODEMP',
                                 VarArrayOf([cdsDocumentosGER_NUMDOC.AsString,
                                             cdsDocumentosGER_ESPDOC.AsString,
                                             cdsDocumentosGER_CODEMP.AsString]), []));
end;

procedure TfrmFatManutRomaneio.pRemoveRegistro;
begin
  if not cdsManut.Active then
    Exit;

   if cdsManut.RecordCount = 0 then
    Exit;

  if cdsManut.RecNo <= 0 then
    Exit;

  cdsManut.Delete;
end;

function TfrmFatManutRomaneio.fRetDocsRomaneioInformado: Boolean;
var
  LQryDocs: TUniQuery;
begin
  Result := False;

  if fEmptyStr(FNumRom) then
    Exit;

  if fEmptyStr(FEmpRom) then
    Exit;

  LQryDocs := fCriaQuery;

  try
    LQryDocs.Close;
    LQryDocs.SQL.Clear;
    LQryDocs.SQL.Add('SELECT * FROM ROMGERX WHERE GER_NUMROM = :NUMROM AND GER_EMPROM = :EMPROM');
    LQryDocs.ParamByName('NUMROM').AsString := FNumRom;
    LQryDocs.ParamByName('EMPROM').AsString := FEmpRom;
    LQryDocs.Open;

    if LQryDocs.IsEmpty then
      Exit;

    while not LQryDocs.Eof do
    begin
      cdsManut.Append;
      cdsManutGER_NUMROM.AsString := LQryDocs.FieldByName('GER_NUMROM').AsString;
      cdsManutGER_NUMDOC.AsString := LQryDocs.FieldByName('GER_NUMDOC').AsString;
      cdsManutGER_ESPDOC.AsString := LQryDocs.FieldByName('GER_ESPDOC').AsString;
      cdsManutGER_CODCLI.AsString := LQryDocs.FieldByName('GER_CODCLI').AsString;
      cdsManutGER_PESBRU.AsFloat := LQryDocs.FieldByName('GER_PESBRU').AsFloat;
      cdsManutGER_PESLIQ.AsFloat := LQryDocs.FieldByName('GER_PESLIQ').AsFloat;
      cdsManutGER_VLRCON.AsFloat := LQryDocs.FieldByName('GER_VLRCON').AsFloat;
      cdsManutAUTOINCREM.AsString := LQryDocs.FieldByName('AUTOINCREM').AsString;
      cdsManutGER_EMPROM.AsString := LQryDocs.FieldByName('GER_EMPROM').AsString;
      cdsManutGER_CODEMP.AsString := LQryDocs.FieldByName('GER_CODEMP').AsString;
      cdsManut.Post;
      LQryDocs.Next;
    end;

    Result := True;
  finally
    FreeAndNil(LQryDocs);
  end;
end;

procedure TfrmFatManutRomaneio.pRetornaDocumentos(var ADocumentosFgo,
  ADocumentosGer: String; ADataSet: TUniClientDataSet);
begin
  if not fEmptyStr(ADocumentosFgo) then
    ADocumentosFgo := ADocumentosFgo + ' OR ';

  if not fEmptyStr(ADocumentosGer) then
    ADocumentosGer := ADocumentosGer + ' OR ';

    ADocumentosFgo := ADocumentosFgo + '('
                                     + 'G.FGO_NUMDOC = ' + QuotedStr(ADataSet.FieldByName('GER_NUMDOC').AsString) + ' AND '
                                     + 'G.FGO_ESPDOC = ' + QuotedStr(ADataSet.FieldByName('GER_ESPDOC').AsString) + ' AND '
                                     + 'G.FGO_CODCLI = ' + QuotedStr(ADataSet.FieldByName('GER_CODCLI').AsString) + ' AND '
                                     + 'G.FGO_CODEMP = ' + QuotedStr(ADataSet.FieldByName('GER_CODEMP').AsString) +  ') ';

    ADocumentosGer := ADocumentosGer + '('
                                     + 'G.GER_NUMDOC = ' + QuotedStr(ADataSet.FieldByName('GER_NUMDOC').AsString) + ' AND '
                                     + 'G.GER_ESPDOC = ' + QuotedStr(ADataSet.FieldByName('GER_ESPDOC').AsString) + ' AND '
                                     + 'G.GER_CODEMP = ' + QuotedStr(ADataSet.FieldByName('GER_CODEMP').AsString) + ' AND '
                                     + 'G.GER_CODCLI = ' + QuotedStr(ADataSet.FieldByName('GER_CODCLI').AsString) + ') ';
end;

procedure TfrmFatManutRomaneio.pRetornaTransMot(ANumRom, AEmpRom: string);
var
  LQryTransMot: TUniQuery;
begin
  FCodTra := EmptyStr;
  FCodMot := EmptyStr;
  FNumBox := EmptyStr;
  FCodAj1 := EmptyStr;
  FCodAj2 := EmptyStr;
  FCodAj3 := EmptyStr;
  FCodAj4 := EmptyStr;
  FObsFec := EmptyStr;
  FPlaVei := EmptyStr;
  FCodReg := EmptyStr;
  FVlrFre := 0;
  FVlrAdi := 0;
  FPerFre := 0;
  FDtaRom := 0;
  FHorRom := 0;

  LQryTransMot := fCriaQuery;

  try
    LQryTransMot.Close;
    LQryTransMot.SQL.Clear;
    LQryTransMot.SQL.Add('');
    LQryTransMot.SQL.Add('SELECT ');
    LQryTransMot.SQL.Add('  GER_DTAROM, ');
    LQryTransMot.SQL.Add('  GER_HORROM, ');
    LQryTransMot.SQL.Add('  GER_PLAVEI, ');
    LQryTransMot.SQL.Add('  GER_CODMOT, ');
    LQryTransMot.SQL.Add('  GER_NUMBOX, ');
    LQryTransMot.SQL.Add('  GER_CODAJ1, ');
    LQryTransMot.SQL.Add('  GER_CODAJ2, ');
    LQryTransMot.SQL.Add('  GER_CODAJ3, ');
    LQryTransMot.SQL.Add('  GER_CODAJ4, ');
    LQryTransMot.SQL.Add('  GER_OBSFEC, ');
    LQryTransMot.SQL.Add('  GER_CODTRA, ');
    LQryTransMot.SQL.Add('  GER_CODREG, ');
    LQryTransMot.SQL.Add('  GER_FRETE_, ');
    LQryTransMot.SQL.Add('  GER_ADIFRE, ');
    LQryTransMot.SQL.Add('  GER_PERFRE  ');
    LQryTransMot.SQL.Add('FROM ');
    LQryTransMot.SQL.Add('  ROMGERX ');
    LQryTransMot.SQL.Add('WHERE ');
    LQryTransMot.SQL.Add('  GER_NUMROM = :NUMROM AND ');
    LQryTransMot.SQL.Add('  GER_EMPROM = :EMPROM ');

    LQryTransMot.ParamByName('NUMROM').AsString := ANumRom;
    LQryTransMot.ParamByName('EMPROM').AsString := AEmpRom;

    LQryTransMot.Open;

    if LQryTransMot.IsEmpty then
      Exit;

    FCodTra := LQryTransMot.FieldByName('GER_CODTRA').AsString;
    FCodMot := LQryTransMot.FieldByName('GER_CODMOT').AsString;
    FNumBox := LQryTransMot.FieldByName('GER_NUMBOX').AsString;
    FCodAj1 := LQryTransMot.FieldByName('GER_CODAJ1').AsString;
    FCodAj2 := LQryTransMot.FieldByName('GER_CODAJ2').AsString;
    FCodAj3 := LQryTransMot.FieldByName('GER_CODAJ3').AsString;
    FCodAj4 := LQryTransMot.FieldByName('GER_CODAJ4').AsString;
    FObsFec := LQryTransMot.FieldByName('GER_OBSFEC').AsString;
    FPlaVei := LQryTransMot.FieldByName('GER_PLAVEI').AsString;
    FCodReg := LQryTransMot.FieldByName('GER_CODREG').AsString;
    FVlrFre := LQryTransMot.FieldByName('GER_FRETE_').AsFloat;
    FVlrAdi := LQryTransMot.FieldByName('GER_ADIFRE').AsFloat;
    FPerFre := LQryTransMot.FieldByName('GER_PERFRE').AsFloat;
    FDtaRom := LQryTransMot.FieldByName('GER_DTAROM').AsDateTime;
    FHorRom := LQryTransMot.FieldByName('GER_HORROM').AsDateTime;

  finally
    FreeAndNil(LQryTransMot);
  end;
end;

procedure TfrmFatManutRomaneio.pSetDadosTransportadoraMotorista(const ADadosTranspMot : TDadosTranspMot);
begin
  FCodTra := ADadosTranspMot.strCodTra;
  FCodMot := ADadosTranspMot.strCodMot;
  FCodAj1 := ADadosTranspMot.strCodAj1;
  FCodAj2 := ADadosTranspMot.strCodAj2;
  FCodAj3 := ADadosTranspMot.strCodAj3;
  FCodAj4 := ADadosTranspMot.strCodAj4;
  FObsFec := ADadosTranspMot.strObsFec;
  FPlaVei := ADadosTranspMot.strPlaVei;
  FCodReg := ADadosTranspMot.strCodReg;
  FVlrFre := ADadosTranspMot.fltVlrFre;
  FVlrAdi := ADadosTranspMot.fltVlrAdi;
  FPerFre := ADadosTranspMot.fltPerFre;
  FNumBox := ADadosTranspMot.strNumBox;
  FDtaRom := ADadosTranspMot.dtaDtaRom;
  FHorRom := ADadosTranspMot.dtaHorRom;
end;

procedure TfrmFatManutRomaneio.pSomaTotais;
var
  LPosicao: integer;
  intTotDocSel: integer;
  fltTotPesSel,
  fltTotVlrSel: Double;
begin
  cdsDocumentos.DisableControls;

  try
    intTotDocSel := 0;
    fltTotPesSel := 0;
    fltTotVlrSel :=0;

    LPosicao := cdsDocumentos.RecNo;
    cdsDocumentos.First;

    while not cdsDocumentos.Eof do
    begin
      if cdsDocumentos.FieldByName('GER_MARDES').AsString = 'M' then
      begin
        Inc(intTotDocSel);
        fltTotPesSel := fltTotPesSel + cdsDocumentos.FieldByName('GER_PESBRU').AsFloat;
        fltTotVlrSel := fltTotVlrSel + cdsDocumentos.FieldByName('GER_VLRCON').AsFloat;
      end;

      cdsDocumentos.Next;
    end;

    cdsDocumentos.RecNo := LPosicao;

    lbltotDocSel.Caption := 'Total Selecionado: ' + IntToStr(intTotDocSel);
    lblTotPesSel.Caption := 'Peso Doc. Selecionado: ' + FloatToStrF(fltTotPesSel, ffNumber, 12, 4);
    lblTotValSel.Caption := 'Valor Doc. Selecionado: ' + FloatToStrF(fltTotVlrSel, ffNumber, 12, 4);
  finally
    cdsDocumentos.EnableControls;
  end;
end;

procedure TfrmFatManutRomaneio.pCarregaConfiguracoesGrids;
begin
  Try
    cfgConfiguracaoGrids := TConfiguracaoGridFactory.Create;

    cfgConfiguracaoGrids
      .SetNomeFormulario(Self.Name)
      .SetCodigoOperador(strLoginUsuarioLogado)
      .fAddGridConfiguracao(grdRomaneioDBTableView)
      .fAddGridConfiguracao(grdRomaneioDBTableView2)
      .fAddGridConfiguracao(grdManutencaoDBTableView)
      .fCarregarConfiguraoGrids;
  Except
    fMensagem('', 'Não foi possível carregar as configurações das colunas. A '+
                  'tela será aberta e as configurações poderão ser refeitas.', ['&Ok']);
    cfgConfiguracaoGrids.fDeletarConfiguracaoGrids;
  End;
end;

function TfrmFatManutRomaneio.fDocumentoSofreuAlteracao(var ADocumentos: String; AMarca: Boolean): Boolean;
begin
  if (not AMarca) then
    Exit(False);

  Result := fCampoTabela('COUNT(1)',
                         'ROMGERX',
                         ['GER_NUMROM', 'GER_EMPROM', 'GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'],
                         [cdsDocumentosGER_NUMROM.AsString, cdsDocumentosGER_EMPROM.AsString, cdsDocumentosGER_NUMDOC.AsString,
                          cdsDocumentosGER_ESPDOC.AsString, cdsDocumentosGER_CODEMP.AsString]) = 0;

  if Result then
    ADocumentos := ADocumentos + cdsDocumentosGER_NUMDOC.AsString + '-' + cdsDocumentosGER_ESPDOC.AsString + '-' + cdsDocumentosGER_CODEMP.AsString + ' | ';
end;

procedure TfrmFatManutRomaneio.pValidaSeNecessitaDestravarLocks(const strNumRom: String; strEmpRom : String);
  Var
    objTravaRomaneio : TTravaRomaneio;
begin
  If (fTemAlgumDocumentoMarcado(strNumRom, strEmpRom)) Then
    Exit;
  objTravaRomaneio := TTravaRomaneio.Create(strNumRom, strEmpRom, objLock);
  Try
    objTravaRomaneio.pDestrava(strNumRom, strEmpRom, objLock);
  Finally
    FreeAndNil(objTravaRomaneio);
  End;
end;

function TfrmFatManutRomaneio.fTemAlgumDocumentoMarcado(
  const strNumRom: String; strEmpRom : String): Boolean;
  Var
    cdsClone : TUniClientDataSet;
    intRecNo : Integer;
begin
  cdsClone := TUniClientDataSet.Create(Self);
  intRecNo := cdsDocumentos.RecNo;
  Try
    pCloneDataSet(cdsClone, cdsDocumentos);
    cdsClone.Filter := 'GER_NUMROM = ' + QuotedStr(strNumRom) + ' AND GER_EMPROM = ' + QuotedStr(strEmpRom) + ' AND GER_MARDES = ' + QuotedStr('M');
    cdsClone.Filtered := True;
    Result := (Not cdsClone.IsEmpty);
  Finally
    FreeAndNil(cdsClone);
    cdsDocumentos.RecNo := intRecNo;
  End;
end;

function TfrmFatManutRomaneio.fExisteCancelamentoPendentePorChaveAcesso(const strNumDoc, strEspDoc, strCodEmp, strCodCli : String): Boolean;
  Var
    strChave : String;
begin
  Result := False;

  If (Pos(strEspDoc, 'NF_EL_NV_IF_IV_') <= 0) Then
    Exit;

  strChave := fRetChaveAcesso(strNumDoc, strEspDoc, strCodCli, strCodEmp);

  If fEmptyStr(strChave) Then
    Exit;

  If FLogCancelamento.fExisteCancelamentoPendentePorChaveAcesso(strChave) Then
  Begin
    Result := True;
    pMensagemOK('Documento Fiscal se encontra em processo de cancelamento (LOGCAN)!');
  End;
end;

end.
