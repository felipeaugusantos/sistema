{*************************}
{* qryConEmp -> CADEMP   *}
{**********************JB*}
unit untBaixaCartoes;

interface

uses
  Windows, Types, Classes, Controls, Forms, StdCtrls, untPaiSimples, Grids,
  HTTPSend, blcksock, synautil, ssl_openssl,
  DBGridCitel, DBGrids, Mask, MaskEditFocus, EditFocus, ComCtrls, Buttons, ExtCtrls, DB,
  Menus, QColorLabel, Uni, AppEvnts, untFuncoesSimples, UniClientDataSet,
  UniDataSetProvider, frxClass, frxDBSet, BitBtnLockedIncrem, cxProgressBar,
  untCadPag, MemDS, DBAccess, Provider, untTypesSistema, FileCtrl,
  frxExportCSVTestabilidade, Datasnap.DBClient, System.Generics.Collections,
  frxExportText, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  cxStyles, cxCustomData, cxFilter, untFechamentoFinanceiro,
  cxData, cxDataStorage, cxNavigator, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGridCitel, cxClasses,
  cxGridLevel, cxGrid, untGravandoObs, untSubjectClass, untSubjectIntf, untFuncFat,
  frxExportXLS, frxExportCSV, frxExportPDF, ComObj, System.ImageList,
  Vcl.ImgList, cxImageComboBox, Math, untLiberacao, REST.Client, Rest.Types,
  cxDataControllerConditionalFormattingRulesManagerDialog, untBaixaCtcBusca,
  untTBaixaCartoes, cxCurrencyEdit, untBaixaCartoesRelatorio, untTBanMca,
  untTConfiguracaoGrids;

 Type
   TArrBusca = Record
      NumCCD : String;
      NumNsu : String;
      DtaCad : String;
      DtaVen : String;
      Valor  : String;
      Nome   : String;
      CpfCgc : String;
 End;

type
  TfrmBaixaCartoes = class(TfrmPaiSimples)
    pnlAux1: TPanel;
    pnlDadosDup: TPanel;
    Label5: TLabel;
    Operadora: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label14: TLabel;
    pnlBotoesBaixa: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    edtCodCar: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    pnlAux2: TPanel;
    pnlTotais: TPanel;
    Label4: TLabel;
    Label6: TLabel;
    edtDesCar: TEditFocus;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtPerCar: TEditFocus;
    edtValOri: TEditFocus;
    edtValTax: TEditFocus;
    edtHist01: TEditFocus;
    edtHist02: TEditFocus;
    Label8: TLabel;
    Label11: TLabel;
    edtCodEmp: TEditFocus;
    edtDesEmp: TEditFocus;
    edtOperad: TEditFocus;
    Label12: TLabel;
    edtCodBan: TEditFocus;
    Label17: TLabel;
    edtDesBan: TEditFocus;
    Label18: TLabel;
    edtNomCli2: TEditFocus;
    edtCodCli2: TEditFocus;
    btnLocProx: TBitBtnLocked;
    btnConfirma: TBitBtnLocked;
    btnSairBaixa: TBitBtnLocked;
    BtnMarcarTodas: TBitBtnLocked;
    btnConcilia: TBitBtnLocked;
    shpMultSel: TShape;
    btnDesmarcarTodas: TBitBtnLocked;
    btnCarrCartoes: TBitBtnLocked;
    pnlInformativos: TPanel;
    flbConciliacao: TFileListBox;
    GroupBox1: TGroupBox;
    Shape1: TShape;
    Label21: TLabel;
    Shape2: TShape;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Shape3: TShape;
    lblNaoTransferidos: TLabel;
    Label27: TLabel;
    mskDtaIni: TcxDateEdit;
    mskDtaFin: TcxDateEdit;
    mskDtaIniVenc: TcxDateEdit;
    Label19: TLabel;
    mskDtaFinVenc: TcxDateEdit;
    grdDuplic: TcxGridCitel;
    grdDuplicDados: TcxGridDBTableViewCitel;
    grdDuplicDadosMCA_NUMCCD: TcxGridDBColumn;
    grdDuplicDadosMCA_CODEMP: TcxGridDBColumn;
    grdDuplicDadosMCA_DTAVEN: TcxGridDBColumn;
    grdDuplicDadosMCA_DTACAD: TcxGridDBColumn;
    grdDuplicDadosMCA_VALTOT: TcxGridDBColumn;
    grdDuplicDadosMCA_VALSTA: TcxGridDBColumn;
    grdDuplicDadosMCA_NUMNOT: TcxGridDBColumn;
    grdDuplicDadosPARDUP: TcxGridDBColumn;
    grdDuplicDadosMCA_MARDES: TcxGridDBColumn;
    grdDuplicNivel: TcxGridLevel;
    grdDuplicDadosMCA_RESCAI: TcxGridDBColumn;
    grdDuplicDadosMCA_DTATRA: TcxGridDBColumn;
    grdDuplicDadosMCA_EMPRCX: TcxGridDBColumn;
    btnMovimentoCartoes: TBitBtnLocked;
    rdgEmpresa: TRadioGroup;
    grdDuplicDadosMCA_NUMNSU: TcxGridDBColumn;
    Label20: TLabel;
    edtDtaCup: TEditFocus;
    pnlAjustaTotal1: TPanel;
    Label23: TLabel;
    edtQtdSel: TEditFocus;
    edtQtdDup: TEditFocus;
    Label9: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    edtTotDup: TEditFocus;
    edtTotSel: TEditFocus;
    pnlAjustaTotal2: TPanel;
    Label28: TLabel;
    edtAjuTot: TEditFocus;
    edtAjuSel: TEditFocus;
    pnlAjustaTotal3: TPanel;
    Label15: TLabel;
    edtTotDupLiq: TEditFocus;
    edtTotSelLiq: TEditFocus;
    Shape4: TShape;
    Label29: TLabel;
    Label30: TLabel;
    grdDuplicDadosMCA_AJUSTE: TcxGridDBColumn;
    btnAjuVal: TBitBtnLocked;
    pnlDadosConcil: TPanel;
    edtPonVen: TEditFocus;
    Label31: TLabel;
    edtPorBai: TEditFocus;
    Label32: TLabel;
    edtCtaBai: TEditFocus;
    Label33: TLabel;
    edtPorTax: TEditFocus;
    Label34: TLabel;
    edtForTax: TEditFocus;
    Label35: TLabel;
    edtCtaTax: TEditFocus;
    Label36: TLabel;
    edtPorDeb: TEditFocus;
    Label37: TLabel;
    edtCtaDeb: TEditFocus;
    Label38: TLabel;
    edtEveDeb: TEditFocus;
    Label39: TLabel;
    grdDuplicDadosSIT_CAD: TcxGridDBColumn;
    imgSitCad: TImageList;
    edtCtaAnt: TEditFocus;
    Label40: TLabel;
    btnRelatorio: TBitBtnLocked;
    FlwBotoesBaixa: TFlowPanel;
    Label41: TLabel;
    edtEventoBaixa: TEditFocus;
    Label42: TLabel;
    edtEventoTaxaBaixa: TEditFocus;
    pnlAntecipacao: TPanel;
    lblAntTax: TLabel;
    edtAntTax: TEditFocus;
    pnlMarketPlace: TPanel;
    Label43: TLabel;
    edtValorFrete: TEditFocus;
    Label44: TLabel;
    edtValorAjuste: TEditFocus;
    pnlCupomMarketPlace: TPanel;
    lblCupomMarketPlace: TLabel;
    edtCupomMarketPlace: TEditFocus;
    btnIniBus: TBitBtnLocked;
    pnlPorcenTaxaAntecipacao: TPanel;
    lblPorcenTaxaAnt: TLabel;
    edtPorcentagemTaxaAntecipacao: TEditFocus;
    grdDuplicDadosMCA_TRFLIB: TcxGridDBColumn;
    shpNegociado: TShape;
    lblNegociado: TLabel;
    lblNegociadoA: TLabel;
    grdDuplicDadosNEGOCIACAO: TcxGridDBColumn;
    grdDuplicDadosNEGOCIADO_ANTERIORMENTE: TcxGridDBColumn;
    grdDuplicDadosMCA_NUMPOK: TcxGridDBColumn;
    grdDuplicDadosBAN_NOMBAN: TcxGridDBColumn;
    grdDuplicDadosCARTAO: TcxGridDBColumn;
    btnPreviaCartoesConc: TBitBtnLocked;
    dtsPreviaCartoesConc: TDataSource;
    frxPDFExport1: TfrxPDFExport;
    frxDBPreviaCartoesConc: TfrxDBDataset;
    frxPreviaCartoesConc: TfrxReport;
    btnConfigurarGrid: TBitBtnLocked;
    grdDuplicDadosESTABE: TcxGridDBColumn;
    shpDefinirEmpresaAjuste: TShape;
    lblDefinirEmpresaAjuste: TLabel;
    lblDefinirEmpresaAjusteA: TLabel;
    grdDuplicDadosREGISTROTRANSFERENCIA: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSairBaixaClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure edtCodCarKeyPress(Sender: TObject; var Key: Char);
    procedure btnIniBusClick(Sender: TObject);
    procedure btnLocProxClick(Sender: TObject);
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure edtCodBanKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCli2KeyPress(Sender: TObject; var Key: Char);
    procedure btnConciliaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDesmarcarTodasClick(Sender: TObject);
    procedure btnCarrCartoesClick(Sender: TObject);
    procedure BtnMarcarTodasClick(Sender: TObject);
    procedure edtCodCli2Exit(Sender: TObject);
    procedure edtCodEmpExit(Sender: TObject);
    procedure grdDuplicDadosCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdDuplicDadosDblClick(Sender: TObject);
    procedure grdDuplicDadosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnMovimentoCartoesClick(Sender: TObject);
    procedure btnAjuValClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnRelatorioClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure btnPreviaCartoesConcClick(Sender: TObject);
    procedure btnConfigurarGridClick(Sender: TObject);
    function frxPreviaCartoesConcUserFunction(const MethodName: string;
      var Params: Variant): Variant;
  private
    { Private declarations }
    frmBaixaCtcBusca: TfrmBaixaCtcBusca;
    qryConEmp: TUniQuery;
    qryConBan: TUniQuery;
    qryConCar2: TUniQuery;
    qryCadPag: TUniQuery;

    FDataInicialConciliacao: TDate;
    FDataFinalConciliacao: TDate;
    FExibirCartoesPendente: Boolean;

    qryBaiCar: TUniQuery;
    FConfiguracaoGrid: TConfiguracaoGrids;

    cdsCadPor,
    cdsCadCta: TUniClientDataSet;
    objFechamento: TFechamentoFinanceiro;

    strPorCar: String;
    strCtaCar: String;
    strEventoCredito : String;
    strPorTax: String;
    strCtaTax: String;
    strForTax: String;
    strEventoTaxa : String;
    strPorBad: String;
    strCtaBad: String;
    strEveDeb: String;
    strCtaAnt: String;
    RecarregaGrid : Boolean;

    {*****************************************}
    {* DADOS ESPECIFICOS DA BAIXA SINTÉTICA  *}
    {**************************************MV*}
    dtaDtaDoc: TDateTime;
    strNumDoc: String;
    strHisDoc: String;

    dtaDtaPag: TDateTime;

    strSeqLan   : String;
    strSeqLanTax: String;
    strSeqLanCre: String;
    strSeqLanAnt: String;

    strValorFiltro: String;
    strCampoFiltro: String;

    dtsBaiCar: TDataSource;
    blnAcesso: Boolean;

    arrCartao  : TConsultasArray;
    arrBandeira: TConsultasArray;
    arrClientes: TConsultasArray;
    arrEmp     : TConsultasArray;

    arrNumNsu: Array of String;

    blnConfirmaBaixa: Boolean; //Tratamento para trabalhar o Commit/Rollback nas Baixas
    FHTTPSend: THTTPSend;

    arrBaiSinCar: Array Of TArrBaiSinCar;
    arrBaiSinDeb: Array Of TArrBaiSinCar; //array para gravação de cancelamentos/ajsutes na movban
    FArrayNegociacao: Array Of TArrBaiSinCar; //array para lançamento de negociação de recebíveis

    FRegistroCTPDETFrete,
    FRegistroCTPDETAjuste: TArrBaiSinCar;
    FCTPDETSintetico: Array Of TArrBaiSinCar;

    FRegistrosConciliar: TStringList;

    arrBusca : Array of TArrBusca;

    objLiberacao : TLiberacao;

    cdsCloneConsulta: TUniClientDataSet;

    FBaixaCartoesRelatorio: TfrmBaixaCartoesRelatorio;

    FLiberacaoTransferencia: Boolean;

    FBaixarTaxasAnaliticoMkt: Boolean;

    procedure pAbreConciliacao; //ABRIR A TELA PARA CONCILIAÇÃO
    procedure pFormShowConciliacaoMercadoLivre;
    procedure CriarComponetesRequisicao;
    procedure pCarregaEmpresa;
    procedure pCarregaBandeira;
    procedure pCarregaCartao;

    procedure pCalculaTotalDuplicatas;

    procedure pMarcaDuplicata(blnMarcar: Boolean; blnF8Concilia: Boolean = False; blnCieloAntecip: Boolean = False; fltValAntec: Double = 0; strChaCon: String = '');
    procedure pSelecionaDuplicata;
    procedure pLimpaDados;

    procedure pCriaTemporaria;
    procedure pDeletaTemporaria;
    procedure pAtualizaTemporaria;
    procedure AbrirClientDataSet;
    procedure pBuscarIni;
    procedure pBuscarProx;

    function  fAchouRegistro(blnInicio:Boolean=True):Boolean;
    function  RetornaSQLCamposTabelaTemporaria(AExiCampos: Boolean): String;

    procedure pPreencheVetor;

    procedure pAtualizaDados(DataSet: TDataSet);
    procedure pFilterRecord(DataSet: TDataSet; Var Accept: Boolean);

    procedure pCriaAgrFields;
    procedure pManipulaPanels(Habilita: Boolean);

    Function fCartaoBloqueado(qryMovCar: TDataSet): Boolean;

    function fVerificaPorCta: Boolean;
    function fValidaPortadores: String;
    function fValidaEventos : Boolean;

    function fGetCartoes: String;

    function fGetDadosBaixaCartao(    strCodCar: String;
                                  Var strPorCar,
                                      strCtaCar,
                                      strEventoCredito,
                                      strPorTax,
                                      strCtaTax,
                                      strForTax,
                                      strEventoTaxa,
                                      strPorBad,
                                      strCtaBad,
                                      strEveDeb: String;
                                      blnVarios: Boolean = False): Boolean;

    function fBaixaDuplicatas: Boolean;
    function fGravaCartoes(pgbStatus: TcxProgressBar): Boolean;
    function fGravaCartoesSin(pgbStatus: TcxProgressBar = Nil) : Boolean;
    procedure CartoesPendentesDeConciliacao;
    function fSetaDupBaixadasRede(arrNumNsu: Array of String):Boolean ;
    procedure pCarregaArrayNegociacao;

    procedure pCarregaArrBaiSinCar;
    procedure pCarregaArrAjustes;
    function fAdicionaCartoesPorEmpresa(strCodEmp: String; strIdenti: String;
      var AListaBanMca: TListaBanMCA; dtaDtaRec: TDateTime;
      strPorCar: String = ''; strCtaCar: String = ''; strPorBad: String = ''; strCtaBad: String = '';
      strPorTax: String = ''; strCtaTax: String = ''; strForTax: String = ''; AstrEventoCredito : String = '';
      AstrEventoTaxa : String = ''; strEveDeb: String = '';
      strCtaAnt: String = ''; intAutoIncremInicial: Int64 = 0): Integer;

    function fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fDesmarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pMarcar(fltValRec: Double; dtaDtaRec: TDate; blnMarcar:Boolean);

    procedure pAlteraValores(strAutoIncrem: String; ASelecionar: Boolean = True);

    procedure pTestaExcel;

    function fValidaValorBaixa(const fltValor:Double): Boolean;

    procedure pMarcaRegistrosResolvidoKoncilia(cdsRegistros: TUniClientDataset);
    function VerificacoesParaBaixa: Boolean;
    function fRetornaValorAntecipacao: String;

    procedure AdicionarRegistroCTPDetNoArraySintetico(ARegistroCTPDetFrete,
                                                      ARegistroCTPDetAjuste: TArrBaiSinCar;
                                                      APlanoDeContas: String;
                                                      ARegistros: TUniClientDataset);

    function ApenasBaixaDeTransferencias: Boolean;
    function fVerificaAcessoAlteracaoValor(FltVlrSemAlt, FltVlrInfo: Real): Boolean;
    procedure ExibirPorcentagemTaxaDeAntecipacao;
    procedure pVisualizaNroPedido;
    procedure ImpPreviaCartoesConc;
    procedure HabilitaPreviaCartoesConc;
    procedure pAtualizaDataMovimentobancarioMovCar( sAutoInc : String; ADataAlterada: TDateTime);
    function fGetEmpresaAjuste(ADataset: TUniClientDataset): string;
  protected
    strRcxTcc: String;
    dtaDtaIni: TDate;
    dtaDtaFim: TDate;
    lstNomArq: TStringList;
    lstSemArq: TStringList;
    intQtdSem: Integer;
    fltValSem: Integer;
    intCtpCon: Integer;

    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fRetornaChaveGrid(): String;
  public
    blnConcil,
    blnConRed,
    blnConML,
    blnInconsist,
    blnGraAju,
    blnBaiMan   : Boolean;
    cdsBaiCar   : TUniClientDataSet; //DATASET DA GRID DE BUSCA
    objConcil   : TCamposConcil;

    cdsResolverAPI,
    cdsResolverAPICanc,
    cdsWithdrawal     : TUniClientDataSet;

    fltValorBaixa: Double;
    strCodPorFix: String;
    dteDtaRecFix: TDateTime;
    arrSeqLanLoc: TStringArray;

    frxPagina: TfrxReport;
    frxExportaXLS: TfrxXLSExport;
    frxRelatorio: TfrxDBDataset;
    frxSemRed: TfrxDBDataset;
    frxListArq: TfrxDBDataset;
    frxTotBan: TfrxDBDataset;
    frxTotalFinal: TfrxDBDataset;

    property RegistrosConciliar: TStringList read FRegistrosConciliar write FRegistrosConciliar;
    property BaixaCartoesRelatorio: TfrmBaixaCartoesRelatorio read FBaixaCartoesRelatorio;

    property DataInicialConciliacao: TDate   Read FDataInicialConciliacao Write FDataInicialConciliacao;
    property DataFinalConciliacao  : TDate   Read FDataFinalConciliacao   Write FDataFinalConciliacao;
    property ExibirCartoesPendente : Boolean Read FExibirCartoesPendente   Write FExibirCartoesPendente;


    { Public declarations }
  end;


implementation

uses SysUtils, Variants, Graphics, StrUtils, untFuncoes, untPesqAux,
  untBaixaCtcValor, untBaixaCtcAnaSin, untFuncoesConsulta,
  untMovCar, untMovBan, untConsultas, untGravando, untFiltroInconsistencias,
  untCadMovCartoes, untRelAjudaMod, untDigValor, untConfiguracaoGrids;

{$R *.dfm}

{ TfrmBaixaCartoes }

function TfrmBaixaCartoes.fRetornaChaveGrid: String;
begin
  Result := Concat(Self.Name, '.', grdDuplicDados.Name);

  If Not objConcil.strTabCon.IsEmpty Then
    Result := Concat(Result, '.', objConcil.strTabCon);
end;

function TfrmBaixaCartoes.fRetornaValorAntecipacao: String;
begin
  Result := FormatFloat('#,##0.00',cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat);
end;

function TfrmBaixaCartoes.frxPreviaCartoesConcUserFunction(
  const MethodName: string; var Params: Variant): Variant;
begin
  inherited;
  If (SameText(MethodName, 'fTime')) Then
    Result := fTime(Params[0]);
end;

function TfrmBaixaCartoes.fSetaDupBaixadasRede(arrNumNsu: array of String): Boolean;
  Var
    strSQL     : String;
    strNsu     : String;
    intCont    : Integer;

    LCfgEstabelecimento: String;

    strEmpresasAjustes: String;

    cdsDatas: TUniClientDataSet;
begin

  Self.Enabled := False;

  Try
    cdsBaicar.Filter := 'MCA_MARDES=''M'' ';
    cdsDatas := CriarClientDataSet(cdsBaicar);
    cdsDatas.Open;
    dtaDtaIni := 0;
    dtaDtaFim := 0;
    cdsDatas.First;
    While Not cdsDatas.Eof Do
    Begin
      If dtaDtaIni > cdsDatas.FieldByName('MCA_DTAREC').AsDateTime Then
        dtaDtaIni :=  cdsDatas.FieldByName('MCA_DTAREC').AsDateTime;

      If dtaDtaFim < cdsDatas.FieldByName('MCA_DTAREC').AsDateTime Then
        dtaDtaFim :=  cdsDatas.FieldByName('MCA_DTAREC').AsDateTime;

      cdsDatas.Next;
    End;
    FreeAndNil(cdsDatas);

    {***************************************}
    {* MARCAÇÃO DE CONCILIAÇÃO DOS DÉBITOS *}
    {************************************AJ*}
    strNsu := '';

    For intCont := 0 To Length(arrNumNsu) - 1 Do
      strNsu := strNsu + '"' + arrNumNsu[intCont] + '",';

    strNsu := Copy(strNsu, 1, Length(strNsu) - 1);

    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + '   RED_EVDR05 ';
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + '   RED_CONCIL = 1 ';
    strSQL := strSQL + ' WHERE              ';
    strSQL := strSQL + '   RED_NUM_CV IN    ';
    strSQL := strSQL + '   (' + strNsu + ')        ';

    If Not strNsu.IsEmpty Then
      fExecutaSQL(strSQL);

    {************************}
    {* MARCAÇÃO DOS AJUSTES *}
    {*********************AJ*}
    If (fCfgSis('BAIDEB') = 'S') And
       (Length(arrBaiSinDeb) > 0) Then
    Begin
      strEmpresasAjustes := '';
      For intCont := 0 To Length(arrBaiSinDeb) - 1 Do
      Begin
        LCfgEstabelecimento := fCfgSis('REDEST',varString, arrBaiSindeb[intCont].strCodEmp);
        If Not LCfgEstabelecimento.IsEmpty Then
        Begin
          If Pos(LCfgEstabelecimento, strEmpresasAjustes) <= 0 Then
            strEmpresasAjustes := strEmpresasAjustes + '"' + LCfgEstabelecimento + '",';
        End;

        LCfgEstabelecimento := fCfgSis('REDECO',varString, arrBaiSindeb[intCont].strCodEmp);
        If Not LCfgEstabelecimento.IsEmpty Then
        Begin
          If Pos(LCfgEstabelecimento, strEmpresasAjustes) <= 0 Then
            strEmpresasAjustes := strEmpresasAjustes + '"' + LCfgEstabelecimento + '",';
        End;
      End;
      strEmpresasAjustes := LeftStr(strEmpresasAjustes, strEmpresasAjustes.Length - 1);

      fExecutaSQL('UPDATE RED_EFIR34 SET RED_CONCIL=1 ' +
                  ' WHERE RED_DTALAN BETWEEN ' +
                  FormatDateTime('yyyy-mm-dd', dtaDtaIni).QuotedString + ' AND ' +
                  FormatDateTime('yyyy-mm-dd', dtaDtaFim).QuotedString + ' AND ' +
                  'RED_NUM_PV IN (' + strEmpresasAjustes + ') AND ' +
                  'RED_REGDEB IN ("035", "045") ');
    End;

    cdsBaicar.Filtered := True;
    Result := True;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
      Result := False;
    End;
  End;

  Self.Enabled := True;
end;

function TfrmBaixaCartoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    intIndex: Integer;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

     {*********************}
    {* VALIDAÇÃO DE DATAS *}
    {******************LE*}

    If (Sender = mskDtaFin) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (StrToDateDef(mskDtaFin.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Final do período informada é inválida!', ['&O k']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final do período deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial do período deve ser preenchido!', ['&Ok']);
          Result := False;
          Sender := mskDtaIni;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) Then
          Begin
            If StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) Then
            Begin
              fMensagem('','A Data Inicial do período deve ser menor que a Data Final do período!',['&O K']);
              Result := False;
              Sender := mskDtaIni;
            End;
          End;
        End;
      End;
    End
    Else If (Sender = mskDtaIni) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))) and (StrToDateDef(mskDtaIni.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial do período informada é inválida!', ['&O k']);
        Result := False;
        Sender := mskDtaIni;
      End;
    End

    {****************************}
    {* VALIDAÇÃO DATAS VENCIMENTO*}
    {**************************LE*}
  Else
    If (Sender = mskDtaFinVenc) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinVenc.Text))) And (StrToDateDef(mskDtaFinVEnc.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Final de vencimento informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
      End
      Else
      If fEmptyStr(fTiraCaracEspeciais(mskDtaFinVenc.Text)) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVenc.Text))) Then
      Begin
        fMensagem('', 'O campo Data Final de vencimento deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinVenc.Text))) And fEmptyStr(fTiraCaracEspeciais(mskDtaIniVenc.Text)) Then
        Begin
          fMensagem('', 'O campo Data Inicial de vencimento deve ser preenchido!', ['&Ok']);
          Result := False;
          Sender := mskDtaIniVenc;
        End
        Else
        Begin
          If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinVenc.Text))) And (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVenc.Text))) Then
          Begin
            If StrToDate(mskDtaIniVenc.Text) > StrToDate(mskDtaFinVenc.Text) Then
            Begin
              fMensagem('','A data Inicial de vencimento deve ser menor que a data final de vencimento!',['&O K']);
              Result := False;
              Sender := mskDtaIniVenc;
            End;
          End;
        End;
      End;

    End
    Else
    If (Sender = mskDtaIniVenc) Then
    Begin
      If (Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVenc.Text))) and (StrToDateDef(mskDtaIniVenc.Text, 0) <= 0) Then
      Begin
        fMensagem('', 'A Data Inicial de vencimento informada é inválida! Necessário correção.', ['&O k']);
        Result := False;
        Sender := mskDtaIniVenc;
      End;
    End

    Else If (Sender = edtCodCli2) Then
      pDesmarcaLista(edtCodCli2, arrClientes)

    Else If (Sender = edtCodEmp) Then
    Begin

      pDesmarcaLista(edtCodEmp, arrEmp);

      If ((Not fEmptyStr(edtCodEmp.Text)) Or (High(arrEmp) >= 0)) And (Not blnAcesso) Then
      Begin
        If (High(arrEmp) >= 0 ) Then
        Begin
          For intIndex := 0 To High(arrEmp) Do
          Begin
            If Pos(arrEmp[intIndex].strCodigo, strEmpAcessoUsuarioLogado) <= 0 Then
            Begin
              fMensagem('', 'Usuário sem permissão de acesso a empresa + ' + arrEmp[intIndex].strCodigo + '!', ['&Ok']);
              Result := False;
              Break;
            End;
          End;
        End
        Else If Pos(edtCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
        Begin
          fMensagem('', 'Usuário sem permissão de acesso a essa Empresa!', ['&Ok']);
          Result := False;
        End;
      End;

    End

    Else If Sender = edtCodBan Then
    Begin

      If (fEmptyStr(edtCodBan.Text)) Then
      Begin
        edtDesBan.Text := 'TODOS';
        SetLength(arrBandeira, 0);
      End
      Else
      Begin
        If Not SameText(edtCodBan.Text, '000') Then
        Begin
          pCarregaBandeira;
          SetLength(arrBandeira, 0);
          If (qryConBan.FieldByName('BAN_CODBAN').IsNull) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa bandeira não está cadastrada!', ['&Ok']);
            Result := False;
          End;
        End;
      End;

    End

    Else If Sender = edtCodCar Then
    Begin

      If (fEmptyStr(edtCodCar.Text)) Then
      Begin
        edtDesCar.Text := 'TODOS';
        SetLength(arrCartao, 0);
      End
      Else
      Begin
        If Not SameText(edtCodCar.Text, '00000') Then
        Begin
          pCarregaCartao;
          SetLength(arrCartao, 0);
          If (qryConCar2.FieldByName('CAR_CODCAR').IsNull) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse cartão não está cadastrado!', ['&Ok']);
            Result := False;
          End
          Else If (Not fEmptyStr(edtCodCar.Text)) And (High(arrCartao) <= 0) And (Not blnAcesso) Then
          Begin
            If Not fVerificaAcessoCartao(edtCodCar.Text) Then
            Begin
              fMensagem('', 'Usuário sem permissão de acesso a esse Cartão!', ['&Ok']);
              Result := False;
            End;
          End;
        End;
      End;
    End

    Else If Sender = edtCodCli2 Then
    Begin

      If (fEmptyStr(edtCodCli2.Text)) Then
      Begin
        edtDesCar.Text := 'TODOS';
        SetLength(arrClientes, 0);
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfrmBaixaCartoes.fValidaEventos: Boolean;
begin
  Result := True;

  cdsBaiCar.DisableControls;
  cdsBaiCar.first;
  while not cdsBaiCar.eof do
    begin
      if ((cdsBaiCar.FieldByName('MCA_AJUSTE').AsString = 'N') and
         (fEmptyStr(cdsBaiCar.FieldByName('CAR_EVECRE').AsString) or
          fEmptyStr(cdsBaiCar.FieldByName('CAR_EVETAX').AsString)) or
         (not fEmptyStr(cdsBaiCar.FieldByName('CAR_PORBAD').AsString) and
          fEmptyStr(cdsBaiCar.FieldByName('CAR_EVEDEB').AsString)))
         or
         ((cdsBaiCar.FieldByName('MCA_AJUSTE').AsString = 'S') and
          (fEmptyStr(cdsBaiCar.FieldByName('MCA_EVECAN').AsString)))
           then
        begin
          cdsBaiCar.EnableControls;
          cdsBaiCar.First;
          Exit(False);
        end;

      cdsBaiCar.Next;
    end;

  cdsBaiCar.First;
  cdsBaiCar.EnableControls;
end;

function TfrmBaixaCartoes.fValidaPortadores: String;
  Var
    qryValPor: TUniQuery;
    strPortad: String;
begin
  qryValPor := fCriaQuery;
  strPortad := '';
  With cdsBaiCar Do
  Begin
    First;
    While Not Eof Do
    Begin
      If Pos(FieldByName('CAR_PORBAI').AsString, strPortad) <= 0 Then
        strPortad := strPortad + '"' + FieldByName('CAR_PORBAI').AsString + '",';
      If Pos(FieldByName('CAR_PORTAX').AsString, strPortad) <= 0 Then
        strPortad := strPortad + '"' + FieldByName('CAR_PORTAX').AsString + '",';
      If (Not fEmptyStr(FieldByName('CAR_PORBAD').AsString)) And (Pos(FieldByName('CAR_PORBAD').AsString, strPortad) <= 0) Then
        strPortad := strPortad + '"' + FieldByName('CAR_PORBAD').AsString + '",';

      Next;
    End;
    First;
  End;

  With qryValPor Do
  Begin
    SQL.Add('SELECT POR_CODPOR FROM CADPOR WHERE ');
    SQL.Add(' (POR_PERBAI="N" OR POR_PERBAI IS NULL) AND ');
    SQL.Add(' POR_CODPOR IN (' + IIF(fEmptyStr(strPortad), '""',
                                     LeftStr(strPortad, Length(strPortad) - 1)) + ') ');
    SQL.Add(' ORDER BY POR_CODPOR');
    Open;

    Result := '';
    If RecordCount > 0 Then
    Begin
      While Not Eof Do
      Begin
        Result := Result + FieldByName('POR_CODPOR').AsString + ', ';

        Next;
      End;
      Result := Copy(Result, 1, Length(Result) - 2);
    End;
    Close;
  End;
  FreeAndNil(qryValPor);
end;

function TfrmBaixaCartoes.fValidaValorBaixa(const fltValor: Double): Boolean;
var
  fltValSel: Double;
begin
  Result := True;
  if (fltValorBaixa > 0) and (strCodPorFix <> '') then
  begin
    fltValSel := 0;
    if edtTotSelLiq.Text <> '' then
       fltValSel := fStrToFloat(edtTotSelLiq.Text);

    fltValSel := fltValSel + fltValor;
    If fFormataFloat(fltValSel, 2) > fFormataFloat(fltValorBaixa, 2) Then
      Result := False;
  end;
end;


procedure TfrmBaixaCartoes.grdDuplicDadosCustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
Var strMarDes,
    strResCai,
    strDtaTra,
    strAjuste,

    LTFLiberada,
    LNegociacao,
    LNegociadoAnteriormente,
    LEstabelecimento,
    LTransferencia: String;
begin
  inherited;

  With cdsBaiCar do
  Begin
    If Not Active Then
      Exit;

    strMarDes := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_MARDES.Index]);
    strResCai := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_RESCAI.Index]);
    strDtaTra := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_DTATRA.Index]);
    strAjuste := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_AJUSTE.Index]);
    LTFLiberada := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosMCA_TRFLIB.Index]);

    LNegociacao := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosNEGOCIACAO.Index]);
    LNegociadoAnteriormente := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosNEGOCIADO_ANTERIORMENTE.Index]);
    LEstabelecimento := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosESTABE.Index]);
    LTransferencia := VarToStr(Sender.DataController.Values[AViewInfo.GridRecord.RecordIndex, grdDuplicDadosREGISTROTRANSFERENCIA.Index]);

    If (strMarDes = 'M') And (strAjuste <> 'S') Then
      ACanvas.Font.Color := clBlue
    Else If (LTFLiberada = 'N') And (strResCai = '1') And (FLiberacaoTransferencia) Then
      ACanvas.Font.Color := clGreen
    Else
    If (strRcxTcc = '2') And (strResCai = '1') And (strDtaTra ='') Then
      ACanvas.Font.Color := clGreen
    Else
    If strAjuste = 'S' Then
      ACanvas.Font.Color := clRed;

    If LNegociacao = 'S' Then
      ACanvas.Font.Color := clGreen;

    If LNegociadoAnteriormente = 'S' Then
    Begin
      ACanvas.Font.Color := clBlue;

      If Not AViewInfo.Selected Then
        ACanvas.Brush.Color := clMoneyGreen;
    End;
  End;
end;

procedure TfrmBaixaCartoes.grdDuplicDadosDblClick(Sender: TObject);
begin
  inherited;
  If (Not cdsBaiCar.Active) Or (cdsBaiCar.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário ter registros para marcar!', ['&Ok']);
    Exit;
  End
  Else
  Begin
    pSelecionaDuplicata;
    pAtualizaDados(Nil);
    pSetFocus(grdDuplic);
  End;
end;

procedure TfrmBaixaCartoes.grdDuplicDadosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Not cdsBaiCar.Active) Then
    Exit;

  If (Key = VK_Return) Then
  Begin
    grdDuplic.Enabled := False;
    pnlCabecalho.Enabled := False;
    pnlBotoesBaixa.Enabled := False;
    pSelecionaDuplicata;
    If (cdsBaiCar.RecordCount > 0) Then
      Key := VK_DOWN;
    pAtualizaDados(Nil);
    grdDuplic.Enabled := True;
    pSetFocus(grdDuplic);
    pnlCabecalho.Enabled := True;
    pnlBotoesBaixa.Enabled := True;
  End
  Else If (Key = VK_Escape) Then
  Begin
    pLimpaDados;
    pSetFocus(edtCodBan);
    pDeletaTemporaria;
  End;
end;

procedure TfrmBaixaCartoes.pAtualizaTemporaria;
begin
  If Not cdsBaiCar.IsEmpty Then
  Begin
    pCalculaTotalDuplicatas;
    cdsBaiCar.First;
    pAtualizaDados(cdsBaiCar);
  End
  Else
    pLimpaDados;
end;

procedure TfrmBaixaCartoes.pBuscarIni;
Var
  prcScroll: TprcScroll;
begin
  If (Not fEmptyStr(frmBaixaCtcBusca.strValorFiltro)) Then
  Begin
    pDisableControls(cdsBaiCar, prcScroll);
    strValorFiltro := Copy(frmBaixaCtcBusca.strValorFiltro,1,length(frmBaixaCtcBusca.strValorFiltro));
    strCampoFiltro := Copy(frmBaixaCtcBusca.strCampoFiltro,1,length(frmBaixaCtcBusca.strCampoFiltro));
    cdsBaiCar.First;
    if not fAchouRegistro(True) then
      fMensagem('ATENÇÃO!', 'Não foram localizados cartões para serem baixados!', ['&O k']);
    pEnableControls(cdsBaiCar, prcScroll);
  End;
end;

procedure TfrmBaixaCartoes.pBuscarProx;
Var
  prcScroll: TprcScroll;
begin
  If (Not cdsBaiCar.IsEmpty) And (Not fEmptyStr(strCampoFiltro)) Then
  Begin
    pDisableControls(cdsBaiCar, prcScroll);
    If Not fAchouRegistro(False) Then
      fMensagem('ATENÇÃO!', 'Não foram localizados cartões para serem baixados!', ['&O k']);
    pEnableControls(cdsBaiCar, prcScroll);
  End
  Else
    fMensagem('ATENÇÃO!', 'A Busca não foi iniciada!', ['&Ok']);
end;

procedure TfrmBaixaCartoes.pCriaTemporaria;
  Var
    strSQL   : String;
    prcScroll: TprcScroll;
begin
  strSQL := RetornaSQLCamposTabelaTemporaria(True);

  pDisableControls(cdsBaiCar, prcScroll);
  cdsBaicar.AggregatesActive := False;
  cdsBaiCar.Close;
  cdsBaiCar.Filter   := '';
  cdsBaiCar.Filtered := False;

  qryBaiCar.Close;

  qryBaiCar.SQL.Text := strSQL;

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) And
     Not fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) Then
  Begin
    qryBaiCar.ParamByName('DTAINI').AsDateTime := StrToDateTime(mskDtaIni.Text);
    qryBaiCar.ParamByName('DTAFIN').AsDateTime := StrToDateTime(mskDtaFin.Text);
  End;

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVenc.Text)) And
     Not fEmptyStr(fTiraCaracEspeciais(mskDtaFinVenc.Text)) Then
  Begin
    qryBaiCar.ParamByName('VENINI').AsDateTime := StrToDateTime(mskDtaIniVenc.Text);
    qryBaiCar.ParamByName('VENFIN').AsDateTime := StrToDateTime(mskDtaFinVenc.Text);
  End;

  qryBaiCar.Open;

  Application.ProcessMessages;

  If Not qryBaiCar.IsEmpty Then
  Begin
    AbrirClientDataSet;
  End
  Else
    fMensagem('ATENÇÃO!', 'Não há cartões para serem baixados!', ['&O k']);
  
  Application.ProcessMessages;
  cdsBaiCar.SetProvider(nil);

  If Not blnConRed Then
    pAtualizaTemporaria
  Else
    dtsBaiCar.Enabled := False;

  pEnableControls(cdsBaiCar, prcScroll);

  If grdDuplicDadosMCA_NUMCCD.DataBinding.Field = Nil Then
    Exit;

  If Not Assigned(FConfiguracaoGrid) Then
    FConfiguracaoGrid := TConfiguracaoGrids.Create(grdDuplic,
                                                 grdDuplicDados,
                                                 fRetornaChaveGrid,
                                                 ['MCA_MARDES', 'MCA_RESCAI', 'MCA_DTATRA', 'MCA_AJUSTE',
                                                 'MCA_TRFLIB', 'NEGOCIACAO', 'NEGOCIACAO_ANT']);
end;

procedure TfrmBaixaCartoes.pDeletaTemporaria;
begin
  If cdsBaiCar.Active Then
    cdsBaiCar.EmptyDataSet;
  blnConRed := False;
end;

procedure TfrmBaixaCartoes.pAbreConciliacao;
  Var
    strDireitos: String;
    qryBusCad  : TUniQuery;
begin
  cdsBaiCar.Close;
  pCriaAgrFields;

  dtsBaiCar := fCriaDataSource(cdsBaiCar);
  cdsBaiCar.AggregatesActive := True;
  grdDuplicDados.DataController.DataSource := dtsBaiCar;

  cdsBaiCar.Open;

  pnlCupomMarketPlace.Visible := MatchStr(objConcil.strTabCon, ['MER_MLPGTO','SHO_SHPGTO']);

  pnlMarketPlace.Visible := MatchStr(objConcil.strTabCon,['MER_MLPGTO','SHO_SHPGTO']) Or
                            ((objConcil.strTabCon = 'MLZ_MZPGTO') And (fCfgSis('MLZFRE') = 'S'));

  If Not pnlMarketPlace.Visible Then
  Begin
    Label14.Top := Label14.Top - pnlMarketPlace.Height;
    edtHist01.Top := edtHist01.Top - pnlMarketPlace.Height;
    edtHist02.Top := edtHist02.Top - pnlMarketPlace.Height;
  End;

  If Not fCfgSis('BAIDEB', varBoolean) Then
  Begin
    If MatchStr(objConcil.strTabCon, ['MER_MLPGTO']) Then
      FBaixarTaxasAnaliticoMkt := fCfgSis('MERANA', varBoolean);
  End;

  grdDuplicDadosMCA_NUMPOK.Visible := False;

  grdDuplicDadosBAN_NOMBAN.Visible := False;
  grdDuplicDadosCARTAO.Visible := False;

  If (objConcil.strTabCon = 'RED_APPGTO') Then
  Begin
    grdDuplicDadosBAN_NOMBAN.Visible := True;
    grdDuplicDadosCARTAO.Visible := True;
  End;

  pnlAntecipacao.Visible   := True;
  strDireitos              := '';
  pnlCabecalho.Visible     := False;
  pnlDadosDup.Height       := pnlDadosDup.Height + pnlCabecalho.Height;
  btnCarrCartoes.Visible   := False;
  btnIniBus.Visible        := False;
  btnLocProx.Visible       := False;
  btnMarcarTodas.Visible   := False;
  btnConcilia.Visible      := False;
  btnDesmarcarTodas.Visible:= False;
  btnMovimentoCartoes.Visible:= False;
  btnConfirma.Left         := btnIniBus.Left;
  pnlDadosConcil.Left      := 6;
  pnlDadosConcil.Top       := edtHist02.Top + edtHist02.Height + 5;
  pnlDadosConcil.Visible   := True;
  btnAjuVal.Left           := btnConfirma.Left + btnConfirma.Width + 2;
  btnAjuVal.Visible        := ((fValidarDirEspecificos(strDireitos, strLoginUsuarioLogado, 'frmBaixaCartoes')) And
                              (POS('A', strDireitos) > 0));
  btnRelatorio.Left        := btnAjuVal.Left + btnAjuVal.Width + 2;
  btnRelatorio.Visible     := True;

  lblNaoTransferidos.Caption := 'Neg. Recebíveis';
  lblNegociadoA.Visible := MatchStr(objConcil.strNomCon.ToUpper, ['CIELO']);
  lblNegociado.Visible := lblNegociadoA.Visible;
  shpNegociado.Visible := lblNegociadoA.Visible;

  {*********************************************}
  {* CRIA DATASETS PARA CADASTRO DE PORTADORES *}
  {* E PLANO DE CONTAS (CONCILIAÇÃO)           *}
  {******************************************AJ*}
  qryBusCad := fCriarQuery('SELECT POR_CODPOR, POR_NOMPOR FROM CADPOR ORDER BY POR_CODPOR', Self);
  qryBusCad.Open;
  cdsCadPor := CriarClientDataSet(qryBusCad);
  FreeAndNil(qryBusCad);
  qryBusCad := fCriarQuery('SELECT CTA_CODCTA, CTA_DESCTA FROM CADCTA ORDER BY CTA_CODCTA', Self);
  qryBusCad.Open;
  cdsCadCta := CriarClientDataSet(qryBusCad);
  FreeAndNil(qryBusCad);
  cdsCadPor.Open;
  cdsCadCta.Open;

  cdsBaiCar.Filter      := 'MCA_MARDES=''M'' AND REGISTROTRANSFERENCIA=''N'' ';
  cdsBaiCar.Filtered    := True;
  grdDuplicDados.OnKeyDown   := Nil;
  grdDuplicDados.OnDblClick  := Nil;

  If ApenasBaixaDeTransferencias Then
    Exit;
  
  edtCodEmp.Clear;
  edtDesEmp.Clear;

  //Apenas o recebendo aparecerá
  Label9.Visible       := False;
  edtQtdDup.Visible    := False;
  edtTotDup.Visible    := False;
  edtAjuTot.Visible    := False;
  edtTotDupLiq.Visible := False;
  Label23.Top          := Label9.Top;
  edtQtdSel.Top        := edtQtdDup.Top;
  edtTotSel.Top        := edtTotDup.Top;
  edtAjuSel.Top        := edtAjuTot.Top;
  edtTotSelLiq.Top     := edtTotDupLiq.Top;

  pnlAjustaTotal2.Visible := blnGraAju;
  pnlPorcenTaxaAntecipacao.Visible := MatchStr(objConcil.strTabCon, ['PAG_SEPGTO','RED_APPGTO']);

  pAtualizaTemporaria;
  cdsBaiCar.AfterScroll := pAtualizaDados;
  pSetFocus(btnConfirma);

  FConfiguracaoGrid := TConfiguracaoGrids.Create(grdDuplic,
                                                 grdDuplicDados,
                                                 fRetornaChaveGrid,
                                                 ['MCA_MARDES', 'MCA_RESCAI', 'MCA_DTATRA', 'MCA_AJUSTE',
                                                 'MCA_TRFLIB', 'NEGOCIACAO', 'NEGOCIACAO_ANT']);
end;

function TfrmBaixaCartoes.fAdicionaCartoesPorEmpresa(strCodEmp,
  strIdenti: String; var AListaBanMca: TListaBanMCA; dtaDtaRec: TDateTime;
  strPorCar: String = ''; strCtaCar: String = ''; strPorBad: String = ''; strCtaBad: String = '';
  strPorTax: String = ''; strCtaTax: String = ''; strForTax: String = ''; AstrEventoCredito : String = '';
  AstrEventoTaxa : String = ''; strEveDeb: String = '';
  strCtaAnt: String = ''; intAutoIncremInicial: Int64 = 0): Integer;
  Var
    LBanMcaDS: TBanMcaDS;
begin
  AListaBanMca := TListaBanMCA.Create;

  If blnBaiMan Then
    cdsCloneConsulta.Filter := 'MCA_MARDES = ' + QuotedStr('M') +
                               ' AND MCA_CODEMP = ' + QuotedStr(strCodEmp) +
                               ' AND MCA_AJUSTE = ' + QuotedStr('N')
  Else
    cdsCloneConsulta.Filter := 'MCA_MARDES = ' + QuotedStr('M') + ' AND MCA_CODEMP = ' + QuotedStr(strCodEmp) +
                               ' AND MCA_DTAREC = ' + QuotedStr(FormatDateTime('dd-mm-yyyy', dtaDtaRec)) +
                               ' AND MCA_AJUSTE = ' + QuotedStr('N') +
                               ' AND CAR_PORBAI = ' + QuotedStr(strPorCar) +
                               ' AND CAR_CTABAI = ' + QuotedStr(strCtaCar) +
                               ' AND CAR_PORBAD = ' + QuotedStr(strPorBad) +
                               ' AND CAR_CTABAD = ' + QuotedStr(strCtaBad) +
                               ' AND CAR_PORTAX = ' + QuotedStr(strPorTax) +
                               ' AND CAR_CTATAX = ' + QuotedStr(strCtaTax) +
                               ' AND CAR_FORTAX = ' + QuotedStr(strForTax) +
                               ' AND CAR_EVECRE = ' + QuotedStr(AstrEventoCredito) +
                               ' AND CAR_EVETAX = ' + QuotedStr(AstrEventoTaxa) +
                               ' AND CAR_EVEDEB = ' + QuotedStr(strEveDeb) +
                               ' AND CAR_CTAANT = ' + QuotedStr(strCtaAnt);
  cdsCloneConsulta.Filtered := True;

  cdsCloneConsulta.First;
  While Not cdsCloneConsulta.Eof Do
  Begin
    Application.ProcessMessages;

    LBanMcaDS := TBanMcaDS.Create;
    LBanMcaDS.strNumDup := cdsCloneConsulta.FieldByName('NRODUP').AsString;
    LBanMcaDS.strParcel := cdsCloneConsulta.FieldByName('PARDUP').AsString;
    LBanMcaDS.strCodEmp := cdsCloneConsulta.FieldByName('MCA_CODEMP').AsString;
    LBanMcaDS.strCodCli := cdsCloneConsulta.FieldByName('MCA_CODCLI').AsString;
    LBanMcaDS.strCodCar := cdsCloneConsulta.FieldByName('MCA_CODCAR').AsString;
    LBanMcaDS.strHist01 := cdsCloneConsulta.FieldByName('MCA_HIST01').AsString;
    LBanMcaDS.strHist02 := cdsCloneConsulta.FieldByName('MCA_HIST02').AsString;
    LBanMcaDS.strNumCCD := cdsCloneConsulta.FieldByName('MCA_NUMCCD').AsString;
    LBanMcaDS.strNumNsu := cdsCloneConsulta.FieldByName('MCA_NUMNSU').AsString;
    LBanMcaDS.fltValSta := cdsCloneConsulta.FieldByName('MCA_VALSTA').AsFloat;
    LBanMcaDS.fltValTax := cdsCloneConsulta.FieldByName('MCA_VALTAX').AsFloat;
    LBanMcaDS.fltValRec := cdsCloneConsulta.FieldByName('MCA_VALREC').AsFloat;
    LBanMcaDS.fltFreMkt := cdsCloneConsulta.FieldByName('FRETE_MARKETPLACE').AsFloat;
    LBanMcaDS.fltValAju := cdsCloneConsulta.FieldByName('AJUSTE_MARKETPLACE').AsFloat;
    LBanMcaDS.fltCupMkt := cdsCloneConsulta.FieldByName('CUPOM_MARKETPLACE').AsFloat;
    LBanMcaDS.strIdenti := strIdenti;
    LBanMcaDS.strAutInc := IIF(intAutoIncremInicial > 0,
                               fFormataAutInc(intAutoIncremInicial,
                                              VS_strCodEmp),
                               intAutoIncremInicial);
    AListaBanMca.Add(LBanMcaDS);

    If intAutoIncremInicial > 0 Then
      Inc64(intAutoIncremInicial);

    cdsCloneConsulta.Next;
  End;

  Result := cdsCloneConsulta.RecordCount;
end;

procedure TfrmBaixaCartoes.pAlteraValores(strAutoincrem: String; ASelecionar: Boolean = True);
  Var
    qryAltera: TUniQuery;
    strSQL   : String;
    intRecNo : Integer;
    BtnClik  : Boolean;
begin
  qryAltera := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE            ';
  strSQL := strSQL + '   MCA_VALDUP,                  ';
  strSQL := strSQL + '   MCA_VALSTA,                  ';
  strSQL := strSQL + '   MCA_PERCAR,                  ';
  strSQL := strSQL + '   MCA_CODEMP,                  ';
  strSQL := strSQL + '   MCA_CODCAR,                  ';
  strSQL := strSQL + '   MCA_NUMNSU,                  ';
  strSQL := strSQL + '   MCA_NUMCCD,                  ';
  strSQL := strSQL + '   MCA_HIST01,                  ';
  strSQL := strSQL + '   MCA_HIST02,                  ';
  strSQL := strSQL + '   MCA_DTACAD,                  ';
  strSQL := strSQL + '   MCA_DTAVEN,                  ';
  strSQL := strSQL + '   MCA_DTACUP,                  ';
  strSQL := strSQL + '   CAR_PORBAI,                  ';
  strSQL := strSQL + '   CAR_CTABAI,                  ';
  strSQL := strSQL + '   CAR_PORTAX,                  ';
  strSQL := strSQL + '   CAR_CTATAX,                  ';
  strSQL := strSQL + '   CAR_FORTAX,                  ';
  strSQL := strSQL + '   CAR_DESCAR,                  ';
  strSQL := strSQL + '   CAR_EVECRE,                  ';
  strSQL := strSQL + '   CAR_EVETAX,                  ';
  strSQL := strSQL + '   CAR_EVEDEB                   ';
  strSQL := strSQL + ' FROM                           ';
  strSQL := strSQL + '   MOVCAR                       ';
  strSQL := strSQL + '   JOIN CADCAR ON               ';
  strSQL := strSQL + '   CAR_CODCAR=MCA_CODCAR        ';
  strSQL := strSQL + ' WHERE                          ';
  strSQL := strSQL + '   MOVCAR.AUTOINCREM = :AUTOINC ';

  With qryAltera Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('AUTOINC').AsString := strAutoIncrem;
    Open;

    BtnClik  := True;
    intRecNo := cdsBaiCar.RecNo;
    cdsBaiCar.DisableControls;
    cdsBaiCar.Edit;
    cdsBaiCar.FieldByName('MCA_NUMCCD').AsString   := FieldByName('MCA_NUMCCD').AsString;
    cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat    := FieldByName('MCA_VALDUP').AsFloat;
    cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat    := FieldByName('MCA_VALDUP').AsFloat;
    cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat    := FieldByName('MCA_VALSTA').AsFloat;
    cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat    := FieldByName('MCA_PERCAR').AsFloat;
    cdsBaiCar.FieldByName('MCA_CODEMP').AsString   := FieldByName('MCA_CODEMP').AsString;
    cdsBaiCar.FieldByName('MCA_CODCAR').AsString   := FieldByName('MCA_CODCAR').AsString;
    cdsBaiCar.FieldByName('MCA_NUMNSU').AsString   := FieldByName('MCA_NUMNSU').AsString;
    cdsBaiCar.FieldByName('MCA_HIST01').AsString   := FieldByName('MCA_HIST01').AsString;
    cdsBaiCar.FieldByName('MCA_HIST02').AsString   := FieldByName('MCA_HIST02').AsString;
    cdsBaiCar.FieldByName('MCA_DTACAD').AsDateTime := FieldByName('MCA_DTACAD').AsDateTime;
    cdsBaiCar.FieldByName('MCA_DTAVEN').AsDateTime := FieldByName('MCA_DTAVEN').AsDateTime;
    cdsBaiCar.FieldByName('MCA_DTACUP').AsDateTime := FieldByName('MCA_DTACUP').AsDateTime;
    cdsBaiCar.FieldByName('CAR_DESCAR').AsString   := FieldByName('CAR_DESCAR').AsString;
    cdsBaiCar.FieldByName('CAR_EVECRE').AsString   := FieldByName('CAR_EVECRE').AsString;
    cdsBaiCar.FieldByName('CAR_EVETAX').AsString   := FieldByName('CAR_EVETAX').AsString;
    cdsBaiCar.FieldByName('CAR_EVEDEB').AsString   := FieldByName('CAR_EVEDEB').AsString;

    If (FieldByName('CAR_PORBAI').AsString = '') Or
       (FieldByName('CAR_CTABAI').AsString = '') Or
       (FieldByName('CAR_PORTAX').AsString = '') Or
       (FieldByName('CAR_CTATAX').AsString = '') Or
       (FieldByName('CAR_FORTAX').AsString = '') Or
       (fCfgSis('CTPOBE', varBoolean) and
       ((FieldByName('CAR_EVECRE').AsString = '') Or
        (FieldByName('CAR_EVETAX').AsString = '') Or
        (FieldByName('CAR_EVEDEB').AsString = '')) )
       Then
      cdsBaiCar.FieldByName('SIT_CAD').AsString := 'INCOMPLETO'
    Else
      cdsBaiCar.FieldByName('SIT_CAD').AsString :=  'COMPLETO';

    cdsBaiCar.Post;

    pAtualizaTemporaria;
    cdsBaiCar.RecNo := intRecNo;
    pCalculaTotalDuplicatas;
    pAtualizaTemporaria;
    cdsBaiCar.RecNo := intRecNo;
    cdsBaiCar.EnableControls;

    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text))Then
    Begin
      If(cdsBaiCar.FieldByName('MCA_DTACAD').AsDateTime >= StrToDate(mskDtaIni.Text)) And
        (cdsBaiCar.FieldByName('MCA_DTACAD').AsDateTime <= StrToDate(mskDtaFin.Text)) Then
      Begin
        BtnClik := False;
      End;
    End;
    If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVenc.Text))Then
    Begin
      If(cdsBaiCar.FieldByName('MCA_DTAVEN').AsDateTime >= StrToDate(mskDtaIniVenc.Text))And
        (cdsBaiCar.FieldByName('MCA_DTAVEN').AsDateTime <= StrToDate(mskDtaFinVenc.Text))Then
      Begin
        BtnClik := False;
      End;
    End;

    If fEmptyStr(fTiraCaracEspeciais(mskDtaIniVenc.Text)) And fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then BtnClik := False;

    If ((cdsBaiCar.FieldByName('MCA_CODCAR').AsString = edtCodCar.Text) Or fEmptyStr(edtCodCar.Text) And
       (qryAltera.RecordCount > 0) And Not(BtnClik)) And ASelecionar Then
    Begin
      pMarcaDuplicata(True);
      pAtualizaTemporaria;
    End
    Else
    begin
      RecarregaGrid := True;
    end;
  End;
  FreeAndNil(qryAltera);

end;

procedure TfrmBaixaCartoes.pAtualizaDados(DataSet: TDataSet);
begin

  edtCodCli.Text := cdsBaiCar.FieldByName('MCA_CODCLI').AsString;
  edtNomCli.Text := cdsBaiCar.FieldByName('CLI_NOMCLI').AsString;
  edtOperad.Text := cdsBaiCar.FieldByName('MCA_CODCAR').AsString +' - ' +
                    cdsBaiCar.FieldByName('CAR_DESCAR').AsString;
  edtDtaCup.Text := FormatDateTime('dd/mm/yyyy', cdsBaiCar.FieldByName('MCA_DTACUP').AsDateTime);
  edtPerCar.Text := FormatFloat(',0.000000', cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat);

  If pnlPorcenTaxaAntecipacao.Visible Then
    ExibirPorcentagemTaxaDeAntecipacao;

  edtValOri.Text := FormatFloat('#,##0.00', cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat);
  edtValTax.Text := FormatFloat('#,##0.00', cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat);
  edtHist01.Text := cdsBaiCar.FieldByName('MCA_HIST01').AsString;
  edtHist02.Text := cdsBaiCar.FieldByName('MCA_HIST02').AsString;

  If (Not blnBaiMan) Then
  Begin
    edtValorFrete.Text := FormatFloat('#,##0.00', Abs(cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat));
    edtValorAjuste.Text := FormatFloat('#,##0.00', Abs(cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat));
    edtCupomMarketPlace.Text := FormatFloat('#,##0.00', Abs(cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat));

    edtPonVen.Text := StringReplace(cdsBaiCar.FieldByName('MCA_ESTABE').AsString, 'EST_', EmptyStr, [rfReplaceAll]);

    edtForTax.Text := IIF(fEmptyStr(cdsBaiCar.FieldByName('FOR_NOMFOR').AsString), '',
                          cdsBaiCar.FieldByName('CAR_FORTAX').AsString + '-' + cdsBaiCar.FieldByName('FOR_NOMFOR').AsString);
    edtEveDeb.Text := IIF(fEmptyStr(cdsBaiCar.FieldByName('DESC_EVE_DEBITO').AsString), '',
                          cdsBaiCar.FieldByName('CAR_EVEDEB').AsString + '-' + cdsBaiCar.FieldByName('DESC_EVE_DEBITO').AsString);
    edtEventoBaixa.Text := IIF(fEmptyStr(cdsBaiCar.FieldByName('DESC_EVE_CREDITO').AsString), '',
                          cdsBaiCar.FieldByName('CAR_EVECRE').AsString + '-' + cdsBaiCar.FieldByName('DESC_EVE_CREDITO').AsString);

    if cdsBaiCar.FieldByName('MCA_AJUSTE').AsString <> 'S' then
      edtEventoTaxaBaixa.Text := IIF(fEmptyStr(cdsBaiCar.FieldByName('DESC_EVE_TAXA').AsString), '',
                                     cdsBaiCar.FieldByName('CAR_EVETAX').AsString + '-' + cdsBaiCar.FieldByName('DESC_EVE_TAXA').AsString)
    else
      edtEventoTaxaBaixa.Text := cdsBaiCar.FieldByName('MCA_EVECAN').AsString + '-' +
                                 fRetNomEvento(cdsBaiCar.FieldByName('MCA_EVECAN').AsString);

    edtPorBai.Text := '';
    If Not fEmptyStr(cdsBaiCar.FieldByName('CAR_PORBAI').AsString) Then
    Begin
      cdsCadPor.Locate('POR_CODPOR', cdsBaiCar.FieldByName('CAR_PORBAI').AsString, []);
      edtPorBai.Text := cdsCadPor.FieldByName('POR_CODPOR').AsString + '-' +
                        cdsCadPor.FieldByName('POR_NOMPOR').AsString;
    End;


    edtCtaBai.Text := '';
    If Not fEmptyStr(cdsBaiCar.FieldByName('CAR_CTABAI').AsString) Then
    Begin
      cdsCadCta.Locate('CTA_CODCTA', cdsBaiCar.FieldByName('CAR_CTABAI').AsString, []);
      edtCtaBai.Text := cdsCadCta.FieldByName('CTA_CODCTA').AsString + '-' +
                        cdsCadCta.FieldByName('CTA_DESCTA').AsString;
    End;

    edtPorTax.Text := '';
    If Not fEmptyStr(cdsBaiCar.FieldByName('CAR_PORTAX').AsString) Then
    Begin
      cdsCadPor.Locate('POR_CODPOR', cdsBaiCar.FieldByName('CAR_PORTAX').AsString, []);
      edtPorTax.Text := cdsCadPor.FieldByName('POR_CODPOR').AsString + '-' +
                        cdsCadPor.FieldByName('POR_NOMPOR').AsString;
    End;

    edtCtaTax.Text := '';
    If Not fEmptyStr(cdsBaiCar.FieldByName('CAR_CTATAX').AsString) Then
    Begin
      cdsCadCta.Locate('CTA_CODCTA', cdsBaiCar.FieldByName('CAR_CTATAX').AsString, []);
      edtCtaTax.Text := cdsCadCta.FieldByName('CTA_CODCTA').AsString + '-' +
                        cdsCadCta.FieldByName('CTA_DESCTA').AsString;
    End;


    edtPorDeb.Text := '';
    If Not fEmptyStr(cdsBaiCar.FieldByName('CAR_PORBAD').AsString) Then
    Begin
      cdsCadPor.Locate('POR_CODPOR', cdsBaiCar.FieldByName('CAR_PORBAD').AsString, []);
      edtPorDeb.Text := cdsCadPor.FieldByName('POR_CODPOR').AsString + '-' +
                        cdsCadPor.FieldByName('POR_NOMPOR').AsString;
    End;

    edtCtaDeb.Text := '';
    If Not fEmptyStr(cdsBaiCar.FieldByName('CAR_CTABAD').AsString) Then
    Begin
      cdsCadCta.Locate('CTA_CODCTA', cdsBaiCar.FieldByName('CAR_CTABAD').AsString, []);
      edtCtaDeb.Text := cdsCadCta.FieldByName('CTA_CODCTA').AsString + '-' +
                        cdsCadCta.FieldByName('CTA_DESCTA').AsString;
    End;

    edtCtaAnt.Text := '';
    If Not fEmptyStr(cdsBaiCar.FieldByName('CAR_CTAANT').AsString) Then
    Begin
      cdsCadCta.Locate('CTA_CODCTA', cdsBaiCar.FieldByName('CAR_CTAANT').AsString, []);
      edtCtaAnt.Text := cdsCadCta.FieldByName('CTA_CODCTA').AsString + '-' +
                        cdsCadCta.FieldByName('CTA_DESCTA').AsString;
    End;

    edtAntTax.Text := fRetornaValorAntecipacao;

    edtValTax.Text := FormatFloat('#,##0.00', fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat -
                                                            cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat, 2));
  End;

  edtHist02.Hint     := edtHist02.Text;
  edtHist02.ShowHint := True;

  btnAjuVal.Enabled := (cdsBaiCar.FieldByName('MCA_AJUSTE').AsString <> 'S');
  Label35.Caption   := IIF(cdsBaiCar.FieldByName('MCA_AJUSTE').AsString <> 'S',
                           'Fornecedor Taxa:',
                           'Fornecedor Canc.:');
  Label42.Caption   := IIF(cdsBaiCar.FieldByName('MCA_AJUSTE').AsString <> 'S',
                           'Ctr. Custo Taxa:',
                           'Ctr. Custo Canc.:');
end;


procedure TfrmBaixaCartoes.FormCreate(Sender: TObject);
begin
  inherited;

  objLiberacao := TLiberacao.Create;
  strRcxTcc := fCfgSis('RCXTCC');

  FLiberacaoTransferencia := fCfgSis('USAAUT', varBoolean);

  qryCadPag := fCriarQuery('SELECT * FROM CADPAG WHERE FALSE', Self);

  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConBan := fCriarQuery('SELECT * FROM CADBAN WHERE FALSE', Self);
  qryConCar2 := fCriarQuery('SELECT * FROM CADCAR WHERE FALSE', Self);

  edtCodEmp.Text := VS_strCodEmp;
  pCarregaEmpresa;

  cdsBaiCar := TUniClientDataSet.Create(Self);
  qryBaiCar := fCriaQuery(Self);
  qryBaiCar.OnFilterRecord := pFilterRecord;
  dtsBaiCar := fCriaDataSource(cdsBaiCar);

  cdsBaiCar.AggregatesActive := True;

  grdDuplicDados.DataController.DataSource := dtsBaiCar;
  {*******************************************}

  blnConRed   := False;
  blnConcil   := False;
  blnInconsist:= False;
  blnGraAju   := False;
  blnBaiMan   := False;

  SetLength(arrSeqLanLoc, 0);

  pCriarFormularios(TfrmBaixaCartoesRelatorio, FBaixaCartoesRelatorio);
  frxPagina := FBaixaCartoesRelatorio.frxPagina;
  frxExportaXLS := FBaixaCartoesRelatorio.frxExportaXLS;
  frxRelatorio := FBaixaCartoesRelatorio.frxRelatorio;
  frxSemRed := FBaixaCartoesRelatorio.frxSemRed;
  frxListArq := FBaixaCartoesRelatorio.frxListArq;
  frxTotBan := FBaixaCartoesRelatorio.frxTotBan;
  frxTotalFinal := FBaixaCartoesRelatorio.frxTotalFinal;

  FBaixarTaxasAnaliticoMkt := False;

  pTestaExcel;

  frxPreviaCartoesConc.AddFunction('function fTime(AForceTime: Boolean) : TDateTime');
end;


procedure TfrmBaixaCartoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_F2) Then
    btnAjuVal.Click
  Else If (Key = VK_F5) Then
    btnIniBus.Click
  Else If (Key = VK_F6) Then
    btnLocProx.Click
  Else If (Key = VK_F7) Then
    btnMarcarTodas.Click
  Else If (Key = VK_F8) Then
    btnDesmarcarTodas.Click
  Else If (Key = VK_F9) Then
    btnConcilia.Click
  Else If (Key = VK_F10) Then
    btnConfirma.Click
  Else If (Key = VK_F11) Then
    btnMovimentoCartoes.Click
  Else If (Key = VK_ESCAPE) And ((blnConcil) Or (blnConRed)) Then
    btnSairBaixa.Click
  Else If (Key = VK_F3) Then
    btnRelatorio.Click;
end;

procedure TfrmBaixaCartoes.FormPaint(Sender: TObject);
begin
  inherited;
  If blnFecharFormPai Then
    btnSairBaixa.Click;
end;

procedure TfrmBaixaCartoes.pFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  If Not fEmptyStr(strCampoFiltro) Then
  Begin
    If strCampoFiltro = 'MCA_VALSTA' Then
      Accept := (Pos(strValorFiltro, FloatToStrF(DataSet.FieldByName(strCampoFiltro).AsFloat, ffNumber, 12, 2)) > 0)
    Else
      Accept := (Pos(strValorFiltro, AnsiUpperCase(DataSet.FieldByName(strCampoFiltro).AsString)) > 0);
  End;
end;

procedure TfrmBaixaCartoes.pFormShowConciliacaoMercadoLivre;
begin
  If Not blnConML Then
    Exit;

  // Núm. Liberação
  grdDuplicDadosMCA_NUMCCD.Caption := 'N° Lib/External Ref';
  grdDuplicDadosMCA_NUMCCD.Width := 97;

  // Coluna NSU
  grdDuplicDadosMCA_NUMNSU.Caption := 'NSU/Shippind ID';

  // Coluna Sit. Cadastro
  grdDuplicDadosSIT_CAD.Caption := 'Sit. Cad.';
  grdDuplicDadosSIT_CAD.Width := 59;

end;

procedure TfrmBaixaCartoes.pVisualizaNroPedido;
begin

  If fCfgSis('NPEDBX', varBoolean) Then
     grdDuplicDadosMCA_NUMPOK.Visible := True
  Else
     grdDuplicDadosMCA_NUMPOK.Visible := False;

end;

function TfrmBaixaCartoes.RetornaSQLCamposTabelaTemporaria(AExiCampos: Boolean): String;
begin
  Result := fGetSQLCartoes(objConcil);

  If AExiCampos Then
    Result := Result + ' AND TRUE  '
  Else
    Result := Result + ' AND FALSE  ';

  //Filtra cartões selecionados ou com direito de acesso
  If Not fEmptyStr(edtCodCar.Text) Then
  Begin
    Result := Result + ' AND CAR_CODCAR IN (';
    Result := Result + fRetArrToSQLIn(arrCartao, edtCodCar.Text) + ') ';
  End
  Else If (Not blnAcesso) Then
  Begin
    Result := Result + ' AND (CAR_CODEMP = "" OR CAR_CODEMP IS NULL OR ';
    Result := Result + ' CAR_CODEMP IN (';
    Result := Result + fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ')) ';
  End;

  If Not fEmptyStr(edtCodBan.Text) Then
  Begin
    Result := Result + ' AND CAR_CODBAN IN (';
    Result := Result + fRetArrToSQLIn(arrBandeira, edtCodBan.Text) + ') ';
  End;

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIniVenc.Text)) Then
    Result := Result + '  AND MCA_DTAVEN BETWEEN :VENINI AND :VENFIN ';

  If Not fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) Then
    Result := Result + '  AND MCA_DTACAD BETWEEN :DTAINI AND :DTAFIN ';

  If rdgEmpresa.ItemIndex = 0 Then
  Begin
    If (Not fEmptyStr(edtCodEmp.Text)) Then
      Result := Result + ' AND MCA_CODEMP IN (' + fRetArrToSQLIn(arrEmp, edtCodEmp.Text) + ') '
    Else If (Not blnAcesso) Then
      Result := Result + ' AND MCA_CODEMP IN (' +  fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';;
  End
  Else
  Begin
    If (Not fEmptyStr(edtCodEmp.Text)) Then
      Result := Result + ' AND MCA_EMPRCX IN (' + fRetArrToSQLIn(arrEmp, edtCodEmp.Text) + ') '
    Else If (Not blnAcesso) Then
      Result := Result + ' AND MCA_EMPRCX IN (' +  fRetStrToSQLIn(strEmpAcessoUsuarioLogado) + ') ';;
  End;

  If (Not fEmptyStr(edtCodCli2.Text)) Then
    Result := Result + ' AND MCA_CODCLI IN (' + fRetArrToSQLIn(arrClientes, edtCodCli2.Text) + ') ';

  Result := Result + ' ORDER BY MCA_DTAVEN, MCA_NUMDUP, MCA_NUMNSU, MCA_CODEMP, MCA_NUMCCD,  MCA_PARCEL) AS TMP  ';
end;

procedure TfrmBaixaCartoes.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodBan);
end;

procedure TfrmBaixaCartoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(FBaixaCartoesRelatorio);

  If Assigned(FHTTPSend) Then
    FreeAndNil(FHTTPSend);

  If Assigned(FConfiguracaoGrid) Then
    FreeAndNil(FConfiguracaoGrid);

  pDeletaTemporaria;
end;

procedure TfrmBaixaCartoes.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If Assigned(cdsCadPor) Then
    FreeAndNil(cdsCadPor);
  If Assigned(cdsCadCta) Then
    FreeAndNil(cdsCadCta);
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  If Assigned(FRegistrosConciliar) Then
    FreeAndNil(FRegistrosConciliar);
end;

procedure TfrmBaixaCartoes.btnSairBaixaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmBaixaCartoes.CartoesPendentesDeConciliacao;
  Var
    LMovCar : TUniQuery;
begin

 If Not Self.FExibirCartoesPendente Then
   Exit;

  Try
    LMovCar := fCriaQuery(Nil);
    Try
      LMovCar.Close;
      LMovCar.SQL.Clear;
      LMovCar.SQL.Text := 'SELECT                                '+
                          '  *                                   '+
                          'FROM                                  '+
                          '  MOVCAR                              '+
                          'WHERE MCA_DTAREC IS NULL              '+
                          '  AND MCA_CODCAR IN ('+fGetCartoes+') '+
                          '  AND MCA_DTAVEN BETWEEN :DTAINI      '+
                          '  AND :DTAFIN                         '+
                          'ORDER BY MCA_CODCAR, MCA_DTAVEN       ';

      LMovCar.ParamByName('DTAINI').AsDateTime := Self.FDataInicialConciliacao;
      LMovCar.ParamByName('DTAFIN').AsDateTime := Self.DataFinalConciliacao;

      LMovCar.Open;

      If LMovCar.IsEmpty Then
        Exit;

      fMensagem('AVISO', 'A seguir será exibido os cartões pendentes de conciliação.', ['&O k']);

      FBaixaCartoesRelatorio.frxDBCartoesPendenteConciliacao.DataSet := LMovCar;

      TfrxMemoView(FBaixaCartoesRelatorio.frxCartoesPendenteConciliacao.FindObject('rllZebra')).Highlight.Color := fCfgSis('CORZEB');
      FBaixaCartoesRelatorio.frxCartoesPendenteConciliacao.DotMatrixReport             := False;
      FBaixaCartoesRelatorio.frxCartoesPendenteConciliacao.PrintOptions.PrintMode      := pmScale;
      FBaixaCartoesRelatorio.frxCartoesPendenteConciliacao.PrintOptions.PrintOnSheet   := 9;
      FBaixaCartoesRelatorio.frxCartoesPendenteConciliacao.Script.Variables['NOMEMP']  := fRetNomeEmpresa;
      FBaixaCartoesRelatorio.frxCartoesPendenteConciliacao.Script.Variables['PERIODO'] := 'Período de ' + FormatDateTime('dd/mm/yyyy', Self.FDataInicialConciliacao)
                                                                                                        + ' até '
                                                                                                        + FormatDateTime('dd/mm/yyyy', Self.DataFinalConciliacao);

      pPreviewReport('TfrmBaixaCartoes.CartoesPendentesDeConciliacao',
                     'Cartões pendentes de conciliação',
                     FBaixaCartoesRelatorio.frxCartoesPendenteConciliacao);

    Except
      On E:Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LMovCar);
  End;

end;

procedure TfrmBaixaCartoes.CriarComponetesRequisicao;
begin
  If Assigned(FHTTPSend) Then
    FreeAndNil(FHTTPSend);

  FHTTPSend :=THTTPSend.Create;
  FHTTPSend.MimeType  := 'application/json; charset=utf-8';
  FHTTPSend.UserAgent := 'Mozilla/4.0';
  FHTTPSend.Protocol  := '1.1';
  FHTTPSend.KeepAlive := True;

  FHTTPSend.Sock.SSL.SSLType:= LT_TLSv1_2;

  FHTTPSend.Sock.SetTimeout( 90000 );
  FHTTPSend.Sock.ConnectionTimeout   := 90000;
  FHTTPSend.Sock.InterPacketTimeout  := False;
  FHTTPSend.Sock.NonblockSendTimeout := 90000;
  FHTTPSend.Sock.SocksTimeout        := 90000;
  FHTTPSend.Sock.HTTPTunnelTimeout   := 90000;
  FHTTPSend.Sock.SocksType := TSocksType.ST_Socks4;

  FHTTPSend.Headers.Add('Accept: application/json');
  FHTTPSend.Headers.Add('Content-Type: application/json');
end;

procedure TfrmBaixaCartoes.pCarregaArrayNegociacao;
  Var
    LDataRecebimento: TDateTime;

    LValorRecebido,
    LValorTaxa: Double;

    LGerarNovo: Boolean;

    LContador: Integer;

    LCodigoEmpresa,
    LPortador,
    LPlanoDeContas,
    LPlanoDeContasTaxa,
    LFornecedor,
    LFiltroAnterior,
    LTipoAjuste: String;
begin
  If Not blnConcil Then
    Exit;

  //Apenas para conciliação automática
  Application.ProcessMessages;

  LFiltroAnterior := cdsBaiCar.Filter;
  cdsBaiCar.Filter := 'MCA_AJUSTE=''S'' AND NEGOCIACAO=''S'' ';
  cdsBaiCar.IndexFieldNames := 'MCA_CODEMP;MCA_DTAREC;CAR_PORBAI;CAR_CTABAI;CAR_FORTAX;MCA_VALREC';
  strCampoFiltro  := '';
  strValorFiltro  := '';
  cdsBaiCar.Filtered := True;

  SetLength(FArrayNegociacao, 0);

  Try
    If cdsBaiCar.IsEmpty Then
      Exit;

    cdsBaiCar.First;
    LCodigoEmpresa := cdsBaiCar.FieldByName('MCA_CODEMP').AsString;
    LDataRecebimento := cdsBaiCar.FieldByName('MCA_DTAREC').Value;
    LPortador := cdsBaiCar.FieldByName('CAR_PORBAI').AsString;
    LPlanoDeContas := cdsBaiCar.FieldByName('CAR_CTABAI').AsString;
    LPlanoDeContasTaxa := cdsBaiCar.FieldByName('PLANODECONTASTXNEGOCIACAO').AsString;
    LFornecedor := cdsBaiCar.FieldByName('CAR_FORTAX').AsString;
    LValorRecebido := 0;
    LValorTaxa := 0;
    LTipoAjuste := IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C');

    While Not cdsBaiCar.Eof Do
    Begin
      LGerarNovo := Concat(cdsBaiCar.FieldByName('MCA_CODEMP').AsString,
                           FormatDateTime('dd/mm/yyyy', cdsBaiCar.FieldByName('MCA_DTAREC').Value),
                           cdsBaiCar.FieldByName('CAR_PORBAI').AsString,
                           cdsBaiCar.FieldByName('CAR_CTABAI').AsString,
                           cdsBaiCar.FieldByName('CAR_FORTAX').AsString,
                           IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C')) <>
                    Concat(LCodigoEmpresa,
                           FormatDateTime('dd/mm/yyyy', LDataRecebimento),
                           LPortador,
                           LPlanoDeContas,
                           LFornecedor,
                           LTipoAjuste);

      If LGerarNovo Then
      Begin
        SetLength(FArrayNegociacao, Length(FArrayNegociacao) + 1);

        LContador := Length(FArrayNegociacao);

        FArrayNegociacao[LContador - 1].fltValDoc := LValorRecebido;
        FArrayNegociacao[LContador - 1].fltValTax := LValorTaxa;
        FArrayNegociacao[LContador - 1].strCodEmp := LCodigoEmpresa;
        FArrayNegociacao[LContador - 1].dtaDtaRec := LDataRecebimento;
        FArrayNegociacao[LContador - 1].strPorBai := LPortador;
        FArrayNegociacao[LContador - 1].strCtaBai := LPlanoDeContas;
        FArrayNegociacao[LContador - 1].PlanoDEContasTaxaNegociacao := LPlanoDeContasTaxa.Trim;
        FArrayNegociacao[LContador - 1].strForTax := LFornecedor;
        FArrayNegociacao[LContador - 1].strNumDoc := strNumDoc;
        FArrayNegociacao[LContador - 1].strHisDoc := 'NEGOCIAÇÃO DE RECEBÍVEIS ' + objConcil.strNomCon.ToUpperInvariant + ' - Emp. ' + LCodigoEmpresa + ' - ' + strHisDoc;
        FArrayNegociacao[LContador - 1].intPagCon := intCtpCon;
        FArrayNegociacao[LContador - 1].strTipAju := IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C');

        LCodigoEmpresa := cdsBaiCar.FieldByName('MCA_CODEMP').AsString;
        LDataRecebimento := cdsBaiCar.FieldByName('MCA_DTAREC').Value;

        LValorRecebido := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;
        If fFormataFloat(cdsBaiCar.FieldByName('VALOR_TAXA_NEGOCIACAO').AsFloat, 2) > 0 Then
        Begin
          LValorRecebido := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
          LValorTaxa := cdsBaiCar.FieldByName('VALOR_TAXA_NEGOCIACAO').AsFloat;
        End;

        LPortador := cdsBaiCar.FieldByName('CAR_PORBAI').AsString;
        LPlanoDeContas := cdsBaiCar.FieldByName('CAR_CTABAI').AsString;
        LFornecedor := cdsBaiCar.FieldByName('CAR_FORTAX').AsString;
        LTipoAjuste := IIF(cdsBaiCar.FieldByName('MCA_VALREC').Value < 0, 'D', 'C');
      End
      Else
      Begin
        If fFormataFloat(cdsBaiCar.FieldByName('VALOR_TAXA_NEGOCIACAO').AsFloat, 2) > 0 Then
        Begin
          LValorRecebido := LValorRecebido + cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
          LValorTaxa := LValorTaxa + cdsBaiCar.FieldByName('VALOR_TAXA_NEGOCIACAO').AsFloat;
        End
        Else
          LValorRecebido := LValorRecebido + cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;
      End;

      cdsBaiCar.Next;
    End;

    SetLength(FArrayNegociacao, Length(FArrayNegociacao) + 1);

    LContador := Length(FArrayNegociacao);

    FArrayNegociacao[LContador - 1].fltValDoc := LValorRecebido;
    FArrayNegociacao[LContador - 1].fltValTax := LValorTaxa;
    FArrayNegociacao[LContador - 1].strCodEmp := LCodigoEmpresa;
    FArrayNegociacao[LContador - 1].dtaDtaRec := LDataRecebimento;
    FArrayNegociacao[LContador - 1].strPorBai := LPortador;
    FArrayNegociacao[LContador - 1].strCtaBai := LPlanoDeContas;
    FArrayNegociacao[LContador - 1].PlanoDEContasTaxaNegociacao := LPlanoDeContasTaxa.Trim;
    FArrayNegociacao[LContador - 1].strForTax := LFornecedor;
    FArrayNegociacao[LContador - 1].strNumDoc := strNumDoc;
    FArrayNegociacao[LContador - 1].strHisDoc := 'NEGOCIAÇÃO DE RECEBÍVEIS ' + objConcil.strNomCon.ToUpperInvariant + ' - Emp. ' + LCodigoEmpresa + ' - ' + strHisDoc;
    FArrayNegociacao[LContador - 1].intPagCon := intCtpCon;
    FArrayNegociacao[LContador - 1].strTipAju := LTipoAjuste;
  Finally
    cdsBaiCar.Filter := LFiltroAnterior;
  End;
end;

Function TfrmBaixaCartoes.fCartaoBloqueado(qryMovCar: TDataSet): Boolean;
Begin
  Result := untMovCar.CartaoBloqueado(qryMovCar, strRcxTcc);
End;

procedure TfrmBaixaCartoes.pSelecionaDuplicata;
  Var
    intRecNo: Integer;
    prcScroll: TprcScroll;
begin
  If (Not cdsBaiCar.Active) Or (cdsBaiCar.IsEmpty) Then
    Exit;

  intRecNo := cdsBaiCar.RecNo;

  Try
    grdDuplic.Enabled := False;
    pDisableControls(cdsBaiCar, prcScroll);

    If (cdsBaiCar.FieldByName('MCA_MARDES').AsString <> 'M') And
       (cdsBaiCar.FieldByName('MCA_AJUSTE').AsString <> 'S') Then
    Begin
      If fCartaoBloqueado(cdsBaiCar) Then
      Begin
        If FLiberacaoTransferencia Then
          pMensagemOk('Cartões recebidos pelo Caixa que ainda não foram transferidos ou a transferência não foi liberada, não podem ser baixados!')
        Else
          pMensagemOk('Cartões recebidos pelo Caixa que ainda não foram transferidos não podem ser baixados!');
      End
      Else
        pMarcaDuplicata(True);
    End
    Else
      pMarcaDuplicata(False);

  Finally
    pAtualizaTemporaria;
    cdsBaiCar.RecNo := intRecNo;
    grdDuplic.Enabled := True;
    pEnableControls(cdsBaiCar, prcScroll);
  End;
end;

procedure TfrmBaixaCartoes.pTestaExcel;
  Var
    oleTestar: Variant;
begin
  Try
    oleTestar := CreateOleObject('Excel.Application');
    oleTestar.quit;
  Except
    FreeAndNil(frxExportaXLS);
  End;
end;

function TfrmBaixaCartoes.VerificacoesParaBaixa: Boolean;
begin
  Result := True;
  If Not blnBaiMan Then
    Exit;

  If TBaixaCartoes.VerificaSeHouveAlteracaoNosCartoesAntesDaBaixa(cdsBaiCar) Then
  Begin
    pMensagemOk('Existem cartões que estão sendo baixados que sofreram uma alteração posterior a pesquisa.' + #13 +
                'Carregue os cartões novamente para efetuar as baixas corretamente!');
    Result := False;
  End;
end;

function TfrmBaixaCartoes.fVerificaPorCta: Boolean;
begin

  Result := cdsBaiCar.Locate('CAR_PORBAI', '', []);
  If Not Result Then
    Result := cdsBaiCar.Locate('CAR_CTABAI', '', []);
  If Not Result Then
    Result := cdsBaiCar.Locate('CAR_PORTAX;MCA_AJUSTE', VarArrayOf(['', 'N']), []);
  If Not Result Then
    Result := cdsBaiCar.Locate('CAR_CTATAX;MCA_AJUSTE', VarArrayOf(['', 'N']), []);
  If Not Result Then
    Result := cdsBaiCar.Locate('CAR_FORTAX', '', []);
  If Not Result Then
    Result := cdsBaiCar.Locate('CAR_CTAANT;MCA_ANT_SN', VarArrayOf(['', 'S']), []);
  
  If Result Then
    cdsBaiCar.First;
end;

procedure TfrmBaixaCartoes.pLimpaDados;
begin
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtOperad.Clear;
  edtPerCar.Clear;
  edtValOri.Clear;
  edtValTax.Clear;
  edtHist01.Clear;
  edtHist02.Clear;

  edtTotDup.Clear;
  edtQtdDup.Clear;
  edtTotSel.Clear;
  edtQtdSel.Clear;
  edtTotSelLiq.Clear;
  edtTotDupLiq.Clear;
  edtDtaCup.Clear;

  edtCodBan.Clear;
  edtDesBan.Clear;
  edtCodCar.Clear;
  edtDesCar.Clear;
  edtCodCli2.Clear;
  edtNomCli2.Clear;
  edtCodEmp.Clear;
  edtDesEmp.Clear;
  mskDtaIni.Clear;
  mskDtaFin.Clear;
  mskDtaIniVenc.Clear;
  mskDtaFinVenc.Clear;

  pSetFocus(edtCodBan);
end;

procedure TfrmBaixaCartoes.pManipulaPanels(Habilita: Boolean);
begin
  pnlBotoesBaixa.Enabled := Habilita;
  pnlAux2.Enabled := Habilita;
  pnlCabecalho.Enabled := (Habilita) And ((Not blnConcil) And (Not blnConRed));
  pnlDadosDup.Enabled := Habilita;
end;

procedure TfrmBaixaCartoes.pMarcaDuplicata(blnMarcar: Boolean; blnF8Concilia: Boolean = False; blnCieloAntecip: Boolean = False; fltValAntec: Double = 0; strChaCon: String = '');
  Var
    fltValRec: Double;
    dtaDtaRec: TDateTime;
    blnConfirma: Boolean;
    prcScroll: TprcScroll;
    frmBaixaCtcValor : TfrmBaixaCtcValor;
    fltValSemAlt: Double;
begin
  fltValRec   := 0.0;
  dtaDtaRec   := 0.0;
  blnConfirma := True;

  If blnMarcar Then
  Begin

    If Not blnF8Concilia Then
    Begin
      Try
        {*****************************************}
        {* CHAMA A TELA DE DIGITAÇÃO DO VALOR    *}
        {**************************************MV*}
        pCriarFormularios(TfrmBaixaCtcValor, frmBaixaCtcValor);
        frmBaixaCtcValor.fltValPag := IIF((cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat = cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) AND
                      (cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat <> 0), cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - (cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat * (cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat / 100)),
                       cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat);
        frmBaixaCtcValor.fltValBru := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
        frmBaixaCtcValor.dtaDtaPag := dtaDtaPag;

        fltValSemAlt := fFormataFloat(frmBaixaCtcValor.fltValPag,02);

        if strCodPorFix <> '' then
        begin
          frmBaixaCtcValor.dtaDtaPag := dteDtaRecFix;
          frmBaixaCtcValor.mskDtaPag.Date    := dteDtaRecFix;
          frmBaixaCtcValor.mskDtaPag.Enabled := False;
        end;

        If fCfgSis('CTC_AS') <> 'A' Then
        Begin
          frmBaixaCtcValor.mskDtaPag.Visible := False;
          frmBaixaCtcValor.Label2.Visible := False;
          frmBaixaCtcValor.Width :=   frmBaixaCtcValor.Width -  (frmBaixaCtcValor.mskDtaPag.Width  + frmBaixaCtcValor.Label2.Width);
          frmBaixaCtcValor.mskDtaPag.Text := DateTimeToStr(VS_DATE);
          frmBaixaCtcValor.btnCancelaDados.Align := alRight;
        End;

        frmBaixaCtcValor.showModal;

        If (frmBaixaCtcValor.blnConfirma) And (fltValSemAlt <> fFormataFloat(frmBaixaCtcValor.fltValPag,02) ) Then
           blnConfirma := fVerificaAcessoAlteracaoValor(fltValSemAlt, frmBaixaCtcValor.fltValPag);

        if blnConfirma then
        Begin
           fltValRec   := frmBaixaCtcValor.fltValPag;
           dtaDtaRec   := frmBaixaCtcValor.dtaDtaPag;
           dtaDtaPag   := frmBaixaCtcValor.dtaDtaPag;
           blnConfirma := (frmBaixaCtcValor.blnConfirma) And (dtaDtaPag >= cdsBaiCar.FieldByName('MCA_DTACAD').Value);
        End;

        If (dtaDtaPag > 0) And (dtaDtaPag < cdsBaiCar.FieldByName('MCA_DTACAD').Value) And frmBaixaCtcValor.blnConfirma Then
          pMensagemOK('A data de pagamento deve ser maior que a data de cadastro do cartão.');

        //FECHAMENTO FINANCEIRO
        //VERIFICA A DATA DA BAIXA DO DOCUMENTO SINTÉTICO
        if dtaDtaRec > 0 then
          if objFechamento.FechamentoFinanceiroJaRealizado(edtCodEmp.Text, dtaDtaRec) then
            blnConfirma := False;

        If (blnConfirma) And (fFormataFloat(fltValRec, 02) = fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat, 02)) Then
        Begin
          cdsBaiCar.Edit;
          cdsBaiCar.FieldByName('MCA_ZERATX').AsString := 'S';
          cdsBaiCar.Post;
        End;
      Except
        On E: Exception Do
        Begin
          blnConfirma := False;
          pMensagensErro(E.Message, '[frmBaixaCartoes.pMarcaDuplicata]');
        End;
      End;
      pFreeAndNil(frmBaixaCtcValor);
    End
     {*****************************************}
     {* SE FOR CONCILIAR                      *}
     {**************************************LE*}
    Else
    Begin
      If Not blnCieloAntecip Then
        fltValRec := cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat
      Else
        fltValRec := fltValAntec;

      If dtaDtaPag = 0 Then
        dtaDtaRec := VS_Date
      Else
        dtaDtaRec   := dtaDtaPag;

      blnConfirma := True;
    End;


    If (blnConfirma) Then
    begin
      if not fValidaValorBaixa(fltValRec) then
      begin
         pMensagemOk('Não é possível selecionar esta duplicata, o valor excede o permitido!' + #13 +
                     'Valor para baixa: ' + FormatFloat('###,###,##0.00', fltValorBaixa)+ #13 +
                     'Valor disponível: ' + FormatFloat('###,###,##0.00', fltValorBaixa-fStrToFloat(edtTotSelLiq.Text)));
         Exit;
      end;

      pMarcar(fltValRec,dtaDtaRec,True);
    end
    Else
     pMarcar(fltValRec,dtaDtaRec,False);
  End
  Else
   pMarcar(fltValRec,dtaDtaRec,False);


  If Not blnConfirma Then
    Exit;

  If blnMarcar Then
  Begin
    cdsBaiCar.Edit;
    cdsBaiCar.FieldByName('MCA_MARDES').AsString   := 'M';
    cdsBaiCar.FieldByName('MCA_VALREC').AsFloat    := fltValRec;
    cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime := dtaDtaRec;
    cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat    := fltValRec;
    If Not blnCieloAntecip Then
      cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat  := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - cdsBaiCar.FieldByName('MCA_VALREC').AsFloat
    Else
    Begin
      cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat  := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - fltValRec;
      cdsBaiCar.FieldByName('MCA_ANTECI').AsFloat  := fltValRec;
    End;

    cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat    := cdsBaiCar.FieldByName('TAXA_ADM_ORIGINAL').AsFloat;
    If (fFormataFloat(fltValRec, 2) <> fFormataFloat(cdsBaiCar.FieldByName('MCA_VALORI').AsFloat, 2)) Or
       (fFormataFloat(cdsBaiCar.FieldByName('MCA_FREMKT').AsFloat + cdsBaiCar.FieldByName('MCA_CUPMKT').AsFloat, 2) > 0) Then
      cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat    := IIF(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat <> 0,
                                                            (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat / cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100,
                                                            0.000000);

    cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat;
    cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat  := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
    cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat  := 1;
    cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat  := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;

    If Not fEmptyStr(strChaCon) Then
      cdsBaiCar.FieldByName('MCA_CHACON').AsString := strChaCon;

    cdsBaiCar.Post;
  End
  Else
  Begin
    cdsBaiCar.Edit;
    cdsBaiCar.FieldByName('MCA_MARDES').AsString := 'D';
    cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := 0;
    cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat  := 0;
    cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat  := 0;
    cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat  := 0;

    If cdsBaiCar.FieldByName('MCA_ANTECI').AsFloat > 0 Then
      cdsBaiCar.FieldByName('MCA_ANTECI').AsFloat  := 0;

    cdsBaiCar.Post;
  End;

  If Not blnF8Concilia Then
  Begin
    pDisableControls(cdsBaiCar, prcScroll);
    pEnableControls(cdsBaiCar, prcScroll);
  End;

end;

procedure TfrmBaixaCartoes.pCalculaTotalDuplicatas;
  Var
    prcScroll: TprcScroll;
begin
  pDisableControls(cdsBaiCar, prcScroll);

  edtAjuTot.Text    := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsBaiCar, 'TOT_AJUTOT'));
  edtAjuSel.Text    := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsBaiCar, 'TOT_AJUSEL'));
  edtTotDup.Text    := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsBaiCar, 'TOT_VALSTA') +
                                                         (fDoubleAggregate(cdsBaiCar, 'TOT_AJUSEL') * IIF(fDoubleAggregate(cdsBaiCar, 'TOT_VALSTA') >= 0, 1, -1)));
  edtTotDupLiq.Text := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsBaiCar, 'TOT_VALTOT'));
  edtQtdDup.Text    := '( ' + IIF((blnConcil) Or (blnConRed),
                         IntToStr(fIntAggregate(cdsBaiCar, 'TOT_SELQTD')),
                         IntToStr(cdsBaiCar.RecordCount)) + ' )';
  edtTotSel.Text    := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsBaiCar, 'TOT_SELSTA'));
  edtTotSelLiq.Text := FormatFloat('#,##0.00;-#,##0.00', fDoubleAggregate(cdsBaiCar, 'TOT_SELTOT') +
                                                         (fDoubleAggregate(cdsBaiCar, 'TOT_AJUSEL') * IIF(fDoubleAggregate(cdsBaiCar, 'TOT_SELSTA') >= 0, 1, -1)));
  edtQtdSel.Text    := '( ' + IntToStr(fIntAggregate(cdsBaiCar, 'TOT_SELQTD')) + ' )';

  pEnableControls(cdsBaiCar, prcScroll);
end;

procedure TfrmBaixaCartoes.btnMovimentoCartoesClick(Sender: TObject);
  Var
    LCadMovCartoes: TfrmCadMovCartoes;
begin
  inherited;
  If Not fValidaCampos(mskDtaIni, False) And
     Not fValidaCampos(mskDtaFin, False) Or
     Not fValidaCampos(mskDtaIni,False)  Or
     Not fValidaCampos(mskDtaFin,False)  Then
       Exit;

  If Not fValidaCampos(mskDtaIniVenc, False) And
     Not fValidaCampos(mskDtaFinVenc, False) Or
     Not fValidaCampos(mskDtaIniVenc,False)  Or
     Not fValidaCampos(mskDtaFinVenc,False)  Or
     Not fValidaCampos(edtCodEmp, False)     Or
     Not fValidaCampos(edtCodCar, False)     Then
       Exit;
  If Not TBitBtnLocked(Sender).Visible Then
    Exit;

  If (not cdsBaiCar.Active) Or cdsBaiCar.IsEmpty Then
  Begin
    pMensagemOk('Nenhum cartão selecionado!');
    Exit;
  End;

  If Not fVerificaAcessoSistema('frmCadMovCartoes') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso para manutenção de cartões!', ['&O k']);
    Exit;
  End;

  If fCartaoBloqueado(cdsBaiCar) Then
  Begin
    If FLiberacaoTransferencia Then
      pMensagemOk('Cartões recebidos pelo Caixa que ainda não foram transferidos ou a transferência não foi liberada, não podem ser baixados!')
    Else
      pMensagemOk('Cartões recebibos pelo Caixa que ainda não foram transferidos não podem ser baixados!');
  End
  Else
  Begin
    Try
      pCriarFormularios(TfrmCadMovCartoes, LCadMovCartoes);
      LCadMovCartoes.blnChamadoDoManutencao := False;
      LCadMovCartoes.strNumDup := cdsBaiCar.FieldByName('NRODUP').AsString;
      LCadMovCartoes.strParcel := cdsBaiCar.FieldByName('PARDUP').AsString;
      LCadMovCartoes.strCodEmp := cdsBaiCar.FieldByName('MCA_CODEMP').AsString;
      LCadMovCartoes.strCodCli := cdsBaiCar.FieldByName('MCA_CODCLI').AsString;
      LCadMovCartoes.strDocume := cdsBaiCar.FieldByName('MCA_DOCUME').AsString;
      LCadMovCartoes.strNumCcd := cdsBaiCar.FieldByName('MCA_NUMCCD').AsString;
      LCadMovCartoes.RotinaOrigem := roBaixaCartoes;

      LCadMovCartoes.ShowModal;

      RecarregaGrid := False;
      pAlteraValores(cdsBaiCar.FieldByName('AUTOINC').AsString,
                     Not LCadMovCartoes.AtualizarBaixa);

      pAtualizaDados(cdsBaiCar);

      If(RecarregaGrid) Then
        btnCarrCartoes.Click;
    Finally
      FreeAndNil(LCadMovCartoes);
    End;
  End;

end;

procedure TfrmBaixaCartoes.HabilitaPreviaCartoesConc;
begin
  If (objConcil.strNomCon.ToUpper = 'REDECARD API') Then
  Begin
    btnPreviaCartoesConc.Visible := True;
  End;
end;

procedure TfrmBaixaCartoes.btnPreviaCartoesConcClick(Sender: TObject);
begin
  If Not Assigned(cdsBaiCar) Or (cdsBaiCar.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO', 'Sem dados para imprimir!', ['&O k']);
    Exit;
  End;

  TfrmGravando.fExecutarModalA(ImpPreviaCartoesConc, 'Aguarde, Gerando Relatório ...', '');
end;

procedure TfrmBaixaCartoes.ImpPreviaCartoesConc;
 Var
   LVideo  : Boolean;
   LCfgRel : TUniQuery;
   LNomImp : String;
   LTipImp : String;
   LRecNo  : Integer;
   LCdsImp : TUniClientDataSet;
begin
  LRecNo    := cdsBaiCar.RecNo;

  Try
    LVideo :=  (fMensagem('','Saída',['&Vídeo','&Imprimir']) = 1);
    LCfgRel := fCriaQuery(Nil);
    LNomImp := '';
    LTipImp := '';

    Try
      If Not LVideo Then
      Begin
        pCarregaConfImpr(LCfgRel, Self.Name);
        LNomImp := LCfgRel.FieldByName('REL_NOMFIL').AsString;
        LTipImp := 'J';

        If fEmptyStr(LNomImp) Then
          fPreImpressao(LCfgRel, LNomImp, LTipImp, False);

        If VerImpressoraONLINE(LNomImp) <> 0 Then
          LNomImp := ' ';

        If Not fEmptyStr(LNomImp) Then
        Begin
          frxPreviaCartoesConc.PrintOptions.ShowDialog := False;
          frxPreviaCartoesConc.PrintOptions.Printer    := LNomImp;
        End;
      End;

      cdsBaiCar.DisableControls;

      LCdsImp := TUniClientDataSet.Create(Self);
      pCloneDataSet(LCdsImp, cdsBaiCar);

      LCdsImp.IndexFieldNames := 'MCA_AJUSTE;' + cdsBaiCar.IndexFieldNames;

      LCdsImp.Filter   := cdsBaiCar.Filter;
      LCdsImp.Filtered := cdsBaiCar.Filtered;

      dtsPreviaCartoesConc.DataSet := LCdsImp;

      frxPreviaCartoesConc.Script.Variables['EMPRESA']    := fRetNomeEmpresa;
      frxPreviaCartoesConc.Script.Variables['NOMCONC']    := objConcil.strNomCon;

      If (edtQtdDup.Visible) Then
      Begin
        frxPreviaCartoesConc.Script.Variables['QUANTIDADE'] := edtQtdDup.Text;
        frxPreviaCartoesConc.Script.Variables['VRLIQUIDO']  := edtTotDupLiq.Text;
        frxPreviaCartoesConc.Script.Variables['VRSEMTAXA']  := edtTotDup.Text;
        frxPreviaCartoesConc.Script.Variables['VRAJUSTES']  := edtAjuTot.Text;
      End
      Else
      Begin
        frxPreviaCartoesConc.Script.Variables['QUANTIDADE'] := edtQtdSel.Text;
        frxPreviaCartoesConc.Script.Variables['VRLIQUIDO']  := edtTotSelLiq.Text;
        frxPreviaCartoesConc.Script.Variables['VRSEMTAXA']  := edtTotSel.Text;
        frxPreviaCartoesConc.Script.Variables['VRAJUSTES']  := edtAjuSel.Text;
      End;

      If frxPreviaCartoesConc.PrepareReport Then
      Begin
        If Not LVideo Then
          pPrintReport(Self.Name, Self.Caption, LNomImp, frxPreviaCartoesConc)
        Else
          pPreviewReport(Self.Name, Self.Caption, frxPreviaCartoesConc);
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[ImpPreviaCartoesConc]');
      End;
    End;
  Finally
    FreeAndNil(LCfgRel);
    cdsBaiCar.RecNo := LRecNo;
    cdsBaiCar.EnableControls;
  End;
end;

procedure TfrmBaixaCartoes.btnRelatorioClick(Sender: TObject);
begin
  inherited;
  If (Not TBitBtnLocked(Sender).Visible) Or (Not TBitBtnLocked(Sender).Enabled) Then
    Exit;

  pPreviewReport(Self.Name, Self.Caption, frxPagina);
end;

function TfrmBaixaCartoes.ApenasBaixaDeTransferencias: Boolean;
  Var
    LSequenciais: TSequenciaisBaixaCartao;
begin
  Result := False;

  If Not cdsBaiCar.IsEmpty Then
    Exit;

  If objConcil.CfgPortadorTransferencia.IsEmpty Then
    Exit;

  cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';

  If cdsBaiCar.Locate('REGISTROTRANSFERENCIA', 'S', []) Then
  Begin
    Result := True;

    If fMensagem('ATENÇÃO', 'O período selecionado possui apenas registros de transferências para serem lançados.' + #13 +
                            'Deseja continuar com os lançamentos?', ['&Sim', '&Não'], 2) = 1 Then
    Begin
      Try
        Inc64(LSequenciais.intSeqLan, cdsBaiCar.RecordCount * 2);
        LSequenciais.intContadorAutIncMovBan := Copy(fRetAutoIncrem('MOVBAN', VS_strCodEmp, LSequenciais.intSeqLan), 4, 14).ToInt64;
        LSequenciais.intSeqLan := fSeqContaBanco(LSequenciais.intSeqLan).ToInt64;

        fStartTransaction;
        TBaixaCartoes.GravaMovBanDeTransferencias(cdsBaiCar,
                                                  objConcil.strNomCon,
                                                  LSequenciais);

        If Not MatchStr(objConcil.strTabCon, ['MER_MLPGTO', 'MLZ_MZPGTO']) Then
          TBaixaCartoes.MarcarComoConciliado(objConcil,
                                             cdsBaiCar)
        Else
          TBaixaCartoes.MarcaRegistrosConciliadoPelaLista(FRegistrosConciliar,
                                                          objConcil);
        fCommit;

        fMensagem('AVISO', 'Lançamentos de transferências realizados com sucesso.', ['&Ok']);
      Except
        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro('Ocorreu um erro ao gravar as transferências.' + #13 +
                         'Erro gerado: ' + E.Message, '[TfrmBaixaCartoes.ApenasBaixaDeTransferencias]');
        End;
      End;
    End;

    blnFecharFormPai := True;

  End;

  cdsBaiCar.Filter      := 'MCA_MARDES=''M'' AND REGISTROTRANSFERENCIA=''N'' ';
end;

procedure TfrmBaixaCartoes.btnAjuValClick(Sender: TObject);
  Var
    fltValDig: Double;
    blnConfir: Boolean;
    prcScroll: TprcScroll;
begin
  inherited;
  If (Not TBitBtnLocked(Sender).Visible) Or (Not TBitBtnLocked(Sender).Enabled) Then
    Exit;

  If (not cdsBaiCar.Active) Or (cdsBaiCar.IsEmpty) Or (cdsBaiCar.FieldByName('MCA_AJUSTE').AsString = 'S') Then
  Begin
    pMensagemOk('Nenhum cartão válido selecionado!');
    Exit;
  End;

  pCriarFormularios(TfrmDigValor, frmDigValor);
  frmDigValor.blnPermiteZero      := False;
  frmDigValor.blnPermiteMenorZero := False;
  frmDigValor.blnConciliacao      := True;
  frmDigValor.Caption             := 'Digite o valor a ser ajustado';
  frmDigValor.ShowModal;

  fltValDig := IIF(fEmptyStr(frmDigValor.edtValor.Text), 0,
                      fStrToFloat(frmDigValor.edtValor.Text) *
                      IIF(frmDigValor.cmbTipVal.ItemIndex = 0, 1, -1));


  blnConfir := (fltValDig <> 0) And (frmDigValor.ModalResult = mrOK) ;

  FreeAndNil(frmDigValor);

  If Not blnConfir Then
    Exit;

  //Cancela se digitar um valor maior ou igual que o valor sem taxa (bruto)
  If fFormataFloat(fltValDig + cdsBaiCar.FieldByName('MCA_VALREC').AsFloat, 2) > fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat, 2) Then
  Begin
    pMensagemOK('O valor recebido não pode ser maior que o valor sem taxa do cartão.');
    Exit;
  End;

  If fFormataFloat(cdsBaiCar.FieldByName('MCA_VALREC').AsFloat + fltValDig, 2) <= 0 Then
  Begin
    fMensagem('ATENÇÃO', 'O valor recebido não pode ser menor ou igual a zero. Verifique o valor ajustado.', ['&OK']);
    Exit;
  End;

  If (Not fVerificaAcessoSistema('CARAJUVALCON', strLoginUsuarioLogado)) Then
  Begin
    setLength(arrLogLib, 0);

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('CONCILIAÇÃO DE CARTÕES - AJUSTE DE VALOR');
    objLiberacao.objMsgLibera.pAddTexto('');
    objLiberacao.objMsgLibera.pAddTexto('Totais da Conciliação: ' + objConcil.strNomCon);
    objLiberacao.objMsgLibera.pAddTexto('Data de recebimento: ' + FormatDateTime('dd/mm/yyyy', cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime));
    objLiberacao.objMsgLibera.pAddTexto('Valor total bruto: ' + FormatFloat(',0.00', fStrToFloat(edtTotSel.Text)));
    objLiberacao.objMsgLibera.pAddTexto('Valor total líquido: ' + FormatFloat(',0.00', fStrToFloat(edtTotSelLiq.Text)));
    objLiberacao.objMsgLibera.pAddTexto('Valor total líquido após ajuste: ' + FormatFloat(',0.00', fltValDig + fStrToFloat(edtTotSelLiq.Text)));
    objLiberacao.objMsgLibera.pAddTexto('');

    objLiberacao.objMsgLibera.pAddTexto('--------------------------------------------------------------------------------------------------------------------------------------------');
    objLiberacao.objMsgLibera.pAddTexto('| NUM. LIBERAÇÃO | NSU               | EMP. | NUM. NOTA            | DT.CAD.  | DT.VEN   | VALOR BRUTO  | VALOR LIQ. ATUAL |  VALOR AJUST. |');
    objLiberacao.objMsgLibera.pAddTexto(' -------------------------------------------------------------------------------------------------------------------------------------------');
    objLiberacao.objMsgLibera.pAddTexto(Concat('| ',
                                               LeftStr(fPadR(cdsBaiCar.FieldByName('MCA_NUMCCD').AsString, 15), 15),
                                               '| ',
                                               LeftStr(fPadR(cdsBaiCar.FieldByName('MCA_NUMNSU').AsString, 17), 17),
                                               ' | ',
                                               LeftStr(fPadR(cdsBaiCar.FieldByName('MCA_CODEMP').AsString, 4), 4),
                                               ' | ',
                                               LeftStr(fPadR(cdsBaiCar.FieldByName('MCA_NUMNOT').AsString, 21), 21),
                                               '| ',
                                               FormatDateTime('dd/mm/yy', cdsBaiCar.FieldByName('MCA_DTACAD').AsDateTime),
                                               ' | ',
                                               FormatDateTime('dd/mm/yy', cdsBaiCar.FieldByName('MCA_DTAVEN').AsDateTime),
                                               ' | ',
                                               fPadL(FormatFloat(',0.00', cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat), 12),
                                               ' | ',
                                               fPadL(FormatFloat(',0.00', cdsBaiCar.FieldByName('MCA_VALREC').AsFloat), 16),
                                               ' | ',
                                               fPadL(FormatFloat(',0.00', fltValDig + cdsBaiCar.FieldByName('MCA_VALREC').AsFloat), 13),
                                               ' |'));
    objLiberacao.objMsgLibera.pAddTexto('--------------------------------------------------------------------------------------------------------------------------------------------');


    objLiberacao.strDirAce := 'CARAJUVALCON';
    objLiberacao.strMsgSen := 'Permitir ajustar valor recebido do cartão na conciliação.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.pInformaNumDocEspDocCodEmp(
                    EmptyStr,
                    EmptyStr,
                    VS_strCodEmp);

    If Not objLiberacao.fLibera Then
      Exit;
  End;

  cdsBaiCar.Edit;
  cdsBaiCar.FieldByName('MCA_VALREC').AsFloat  := fltValDig + cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;
  cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat  := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;
  cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;
  cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat  := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;
  cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat  := IIF(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat <> 0,
                                                      (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat / cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100,
                                                      0.000000);
  cdsBaiCar.Post;

  pDisableControls(cdsBaiCar, prcScroll);
  pEnableControls(cdsBaiCar, prcScroll);
  pCalculaTotalDuplicatas;
end;

procedure TfrmBaixaCartoes.btnCarrCartoesClick(Sender: TObject);
begin
  inherited;

  {**********************************************************************}
  {* BOTÃO CRIADO PARA CARREGAMENTO DE CARTÕES E PARA EVITAR TELA BRANCA*}
  {* CHAMAMOS O 'AGUARDE' E VALIDAÇÃO DE DATAS                           *}
  {*********************************************************************LE*}

  If Not fValidaCampos(mskDtaIni, False) And
     Not fValidaCampos(mskDtaFin, False) Or
     Not fValidaCampos(mskDtaIni,False)  Or
     Not fValidaCampos(mskDtaFin,False)  Then
     Exit;

  If Not fValidaCampos(mskDtaIniVenc, False) And
     Not fValidaCampos(mskDtaFinVenc, False) Or
     Not fValidaCampos(mskDtaIniVenc,False)  Or
     Not fValidaCampos(mskDtaFinVenc,False)  Or
     Not fValidaCampos(edtCodEmp, False)     Or
     Not fValidaCampos(edtCodCar, False)     Then
     Exit;

  pManipulaPanels(False);
  TfrmGravando.fExecutarModal(pCriaTemporaria,'Aguarde... Carregando Cartões.','');
  cdsBaiCar.AfterScroll := pAtualizaDados;
  pManipulaPanels(True);
  blnConRed := False;
  blnConcil := False;



  If cdsBaiCar.IsEmpty Then
    pSetFocus(edtCodBan)
  Else
    pSetFocus(grdDuplic);
end;

procedure TfrmBaixaCartoes.btnConciliaClick(Sender: TObject);
begin
  If Not TBitBtnLocked(Sender).Visible Then
    Exit;

  pCriarFormularios(TfrmRelAjudaMod, frmRelAjudaMod);
  frmRelAjudaMod.pAbreAjuda(Self.Name, 'CONCILIACAO');
  pFreeAndNil(frmRelAjudaMod);

  pSetFocus(edtCodBan);
end;

procedure TfrmBaixaCartoes.btnConfigurarGridClick(Sender: TObject);
Var
  LConfiguracaoGrids: TfrmConfiguracaoGrids;
begin
  inherited;

  If Not cdsBaiCar.Active Then
  Begin
    fMensagem('AVISO', 'É necessario o carregamento dos cartões para utilização da configuração', ['&Ok']);
    Exit;
  End;

  pCriarFormularios(TfrmConfiguracaoGrids, LConfiguracaoGrids);

  Try
    LConfiguracaoGrids.ConfiguracaoGridsObj := FConfiguracaoGrid;
    LConfiguracaoGrids.ChaveGrid := fRetornaChaveGrid;
    LConfiguracaoGrids.DatasetCampos := grdDuplicDados.DataController.Dataset;
    LConfiguracaoGrids.WidthAutomaticoCampos := False;
    LConfiguracaoGrids.ShowModal;

    if (LConfiguracaoGrids.Confirmar) Then
      FConfiguracaoGrid.CarregarDadosSalvos(grdDuplicDados);
  Finally
    FreeAndNil(LConfiguracaoGrids);
  End;
end;

procedure TfrmBaixaCartoes.btnConfirmaClick(Sender: TObject);
  Var
    LRegistroAtual: Integer;

    strPortad: String;
    fltValSel: Double;
    prcScroll: TprcScroll;
    blnConfir: Boolean;
begin
  inherited;

  {***********************************}
  {* VALIDA OS PORTADORES PARA DAR   *}
  {* ANDAMENTO NA BAIXA DOS CARTÕES  *}
  {* PARA CONCILIAÇÃO AUTOMÁTICA     *}
  {********************************AJ*}
  pDisableControls(cdsBaiCar, prcScroll);
  blnConfir := True;
  If (Not blnBaiMan) Then
  Begin
    If (fVerificaPorCta) Then
    Begin
      fMensagem('ATENÇÃO', 'Para baixa através de conciliação automática, é necessário que todos os cartões selecionados estejam com as configurações de Portadores e Planos de Contas configurados.' + #13 +
                'Para cancelamentos/ajustes, o Código do Estabelecimento da operadora do cartão também deve estar vinculado a empresa da baixa.' + #13 +
                'Para baixa de antecipações, é necessário que todos os cartões selecionados estejam com a configuração de Planos de Contas para antecipação configurado.',
                ['OK'], 1, False, 1, 0, False, 0, False, False, False, 260);
      blnConfir := False;
    End;

    strPortad := fValidaPortadores;
    If (blnConfir) And (Not fEmptyStr(strPortad)) Then
    Begin
      fMensagem('ATENÇÃO', 'O(s) portador(res) ' + strPortad + ' não possui(em) permissão para realizar baixa!',['&O K']);
      blnConfir := False;
    End;

    If fCfgSis('CTPOBE', varBoolean) and not(fValidaEventos) Then
    Begin
      fMensagem('ATENÇÃO', 'Para baixa através de conciliação automática, é necessário que todos os cartões envolvidos '+
      'estejam com os Centro de Custos configurados. Também é necessário que e os Centro de Custos de cancelamento\ajuste estejam parametrizados '+
      'na empresa correspondente ao ponto de venda.',
      ['OK']);
      blnConfir := False;
    End;

    If ((Not fEmptyStr(edtTotSel.Text))  And
       (fStrToFloat(edtTotSel.Text) = 0)) And
      ((Not fEmptyStr(edtAjuSel.Text))  And
       (fStrToFloat(edtAjuSel.Text) = 0)) Then
    Begin
      fMensagem('ATENÇÃO', 'Não é possível efetuar a baixa pois não possui valor selecionado.', ['&OK']);
      Exit;
    End;
  End;

  If Not cdsBaiCar.IsEmpty  Then
  Begin
    If blnConfir Then
    Begin
      LRegistroAtual := cdsBaiCar.RecNo;

      blnConfir := cdsBaiCar.Locate('MCA_MARDES', 'M', []);

      cdsBaiCar.RecNo := LRegistroAtual;

      If Not blnConfir Then
      Begin
        fMensagem('','É necessário selecionar ao menos um registro!',['&O K']);
        blnConfir := False;
      End;
    End;

  End
  Else If blnConfir Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos um registro!', ['&Ok']);
    blnConfir := False;
  End;

  //Limite de valor de lançamentos se a tela for chamada pela nova
  //tela de conciliação bancária
  if (blnConfir) And (fltValorBaixa > 0) And (strCodPorFix <> '') then
  begin
    fltValSel := 0;
    if edtTotSelLiq.Text <> '' then
       fltValSel := fStrToFloat(edtTotSelLiq.Text);

    if  fFormataFloat(fltValSel, 2) < fFormataFloat(fltValorBaixa, 2) then
    begin
      pMensagemOk('Não é possível efetuar a baixa, o valor é menor que o valor para baixa!' + #13 + #13 +
                  'Valor para baixa: ' + FormatFloat('###,###,##0.00', fltValorBaixa));
      blnConfir := False;
    end;
  end;

  If (blnConfir) And (TBaixaCartoes.VerificaSeHaCartoesBaixadosAntesDaBaixa(cdsBaiCar)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Existem cartões marcados que foram baixados por outro usuário. Realize a pesquisa novamente para efetuar a baixa desses cartões!', ['&OK']);
    blnConfir := False;
  End;

  If (blnConfir) And
     (((Not fEmptyStr(edtTotSel.Text))  And
       (fStrToFloat(edtTotSel.Text) > 0)) Or
      ((Not fEmptyStr(edtAjuSel.Text))  And
       (fStrToFloat(edtAjuSel.Text) <> 0))) Then
  Begin
    pManipulaPanels(False);

    If Assigned(cdsCloneConsulta) Then
      FreeAndNil(cdsCloneConsulta);

    If fBaixaDuplicatas Then
    Begin

      fMensagem('AVISO', 'Baixa de cartão realizada com sucesso!', ['&O k']);

      If (Not blnConcil) And (Not blnConRed) Then
      Begin
        cdsBaiCar.Filter   := '';
        cdsBaiCar.Filtered := True;
        TfrmGravando.fExecutarModal(pCriaTemporaria,'Aguarde... Atualizando Cartões.','');
        pAtualizaTemporaria;
      End
      Else
        btnSairBaixa.Click;
      
      if (fltValorBaixa > 0) and (strCodPorFix <> '') then
      begin
        btnSairBaixa.Click;
        Exit;
      end;

    End;
    pManipulaPanels(True);
    pEnableControls(cdsBaiCar, prcScroll);
    pSetFocus(grdDuplic);
  End
  Else
    pEnableControls(cdsBaiCar, prcScroll);

end;

procedure TfrmBaixaCartoes.btnDesmarcarTodasClick(Sender: TObject);
  Var
  cdsAux : TUniClientDataSet;
begin
  inherited;
  If Not TBitBtnLocked(Sender).Visible Then
    Exit;

  If (Not cdsBaiCar.Active) Or (cdsBaiCar.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário ter registros para desmarcar!', ['&Ok']);
    Exit;
  End;


  If Not cdsBaiCar.IsEmpty  Then
  Begin
    cdsAux := TUniClientDataSet.Create(Nil);
    cdsAux.Data := cdsBaiCar.Data;

    cdsAux.DisableControls;
    cdsAux.Filtered := False;
    cdsAux.Filter   := 'MCA_MARDES = ' + QuotedStr('M');
    cdsAux.Filtered := True;

    If cdsAux.FieldByName('MCA_MARDES').AsString <> 'M' Then
    Begin
      fMensagem('','É necessário selecionar ao menos um registro para desmarcar!',['&O K']);
      Exit;
    End;

  End;

  If (fMensagem('', 'Confirma desmarcar todos os cartões?', ['&Sim', '&Não']) = 2) Then
    Exit;

  pManipulaPanels(False);
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fDesmarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Desmarcando Cartões.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
  pManipulaPanels(True);
end;

function TfrmBaixaCartoes.fGetDadosBaixaCartao(    strCodCar: String;
                                               Var strPorCar,
                                                   strCtaCar,
                                                   strEventoCredito,
                                                   strPorTax,
                                                   strCtaTax,
                                                   strForTax,
                                                   strEventoTaxa,
                                                   strPorBad,
                                                   strCtaBad,
                                                   strEveDeb: String;
                                                   blnVarios: Boolean = False): Boolean;
  Var
    qryGen: TUniQuery;
Begin
  strPorCar := '';
  strCtaCar := '';
  strPorTax := '';
  strCtaTax := '';
  strForTax := '';
  strPorBad := '';
  strCtaBad := '';
  strEveDeb := '';
  strEventoCredito := '';
  strEventoTaxa    := '';

  If strCodCar.IsEmpty Then
    Exit(False);

  Try
    qryGen := fCriaQuery;

    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT DISTINCT ');
    qryGen.SQL.Add('  IF(CON_PORCRE IS NULL, CAR_PORBAI, CON_PORCRE) AS CAR_PORBAI,');
    qryGen.SQL.Add('  IF(CON_PORCRE IS NULL, CAR_PORTAX, CON_PORTAX) AS CAR_PORTAX,');
    qryGen.SQL.Add('  IF(CON_PORCRE IS NULL, CAR_FORTAX, CON_FORTAX) AS CAR_FORTAX,');
    qryGen.SQL.Add('  IF(CON_PORCRE IS NULL, CAR_CTABAI, CON_CTACRE) AS CAR_CTABAI,');
    qryGen.SQL.Add('  IF(CON_PORCRE IS NULL, CAR_CTATAX, CON_CTATAX) AS CAR_CTATAX,');
    qryGen.SQL.Add('  IF(CON_PORCRE IS NULL, CAR_PORBAD, CON_PORDEB) AS CAR_PORBAD,');
    qryGen.SQL.Add('  IF(CON_PORCRE IS NULL, CAR_CTABAD, CON_CTADEB) AS CAR_CTABAD,');
    qryGen.SQL.Add('  IF(CON_PORCRE IS NULL, CAR_EVECRE, CON_EVECRE) AS CAR_EVECRE,');
    qryGen.SQL.Add('  IF(CON_PORCRE IS NULL, CAR_EVETAX, CON_EVETAX) AS CAR_EVETAX,');
    qryGen.SQL.Add('  IF(CON_PORCRE IS NULL, CAR_EVEDEB, CON_EVEDEB) AS CAR_EVEDEB ');
    qryGen.SQL.Add('FROM CADCAR');
    qryGen.SQL.Add('LEFT JOIN CONPOR ON CON_CODCAR=CAR_CODCAR');
    qryGen.SQL.Add('                AND CON_CODEMP="' + VS_strCodEmp + '"');
    qryGen.SQL.Add('WHERE');

    If Not blnVarios Then
    Begin
      qryGen.SQL.Add('  CAR_CODCAR = :CODCAR');
      qryGen.ParamByName('CODCAR').AsString := strCodCar;
    End
    Else
      qryGen.SQL.Add('  CAR_CODCAR IN ( ' + strCodCar  + ')');

    qryGen.Open;

    If qryGen.RecordCount = 1 Then
    Begin
      strPorCar        := qryGen.FieldByName('CAR_PORBAI').AsString;
      strCtaCar        := qryGen.FieldByName('CAR_CTABAI').AsString;
      strPorTax        := qryGen.FieldByName('CAR_PORTAX').AsString;
      strCtaTax        := qryGen.FieldByName('CAR_CTATAX').AsString;
      strForTax        := qryGen.FieldByName('CAR_FORTAX').AsString;
      strPorBad        := qryGen.FieldByName('CAR_PORBAD').AsString;
      strCtaBad        := qryGen.FieldByName('CAR_CTABAD').AsString;
      strEventoCredito := qryGen.FieldByName('CAR_EVECRE').AsString;
      strEventoTaxa    := qryGen.FieldByName('CAR_EVETAX').AsString;
      strEveDeb        := qryGen.FieldByName('CAR_EVEDEB').AsString;
    End;

    qryGen.Close;

    FreeAndNil(qryGen);
    Result := True;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGetDadosBaixaCartao]');
    End;
  End;
End;

function TfrmBaixaCartoes.fGravaCartoes(pgbStatus: TcxProgressBar): Boolean;
  Var
    intMax       : Integer;
    strNumDup    : String;
    strHistor    : String;
    blnConfirma  : Boolean;
    cdsAux       : TUniClientDataSet;
    objSequencias: TSequenciaisBaixaCartao;

    LValorTotalTaxa,
    LValorCredito,
    LValorTotalCtp: Double;

    LSeqLanFrete,
    LSeqLanAjuste,
    LSeqLanCupom: String;

    LListaBanMca: TListaBanMCA;

    LBanMcaDS: TBanMcaDS;
begin
  Application.ProcessMessages;
  Try
    cdsAux := CriarClientDataSet(cdsBaiCar);

    cdsAux.DisableControls;
    cdsAux.Filtered := False;
    cdsAux.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND MCA_AJUSTE = ' + QuotedStr('N');
    cdsAux.Filtered := True;
    intMax := cdsAux.RecordCount;

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := intMax;
    blnConfirma := True;
    Application.ProcessMessages;

    LSeqLanFrete := EmptyStr;
    LSeqLanAjuste := EmptyStr;
    LSeqLanCupom := EmptyStr;

    With cdsAux Do
    Begin

      fStartTransaction;
      intCtpCon := fRetCtpCon;
      fCommit;

      If Not blnBaiMan Then
        pCarregaArrAjustes;

      objSequencias := TBaixaCartoes.RetornaSequenciaisParaBaixaAnalitica(cdsAux,
                                                                          blnBaiMan,
                                                                          Not fEmptyStr(strPorBad),
                                                                          FBaixarTaxasAnaliticoMkt,
                                                                          Length(arrBaiSinDeb));
      objSequencias.SequencialControleBaixaPagar := intCtpCon;
      objSequencias.NumeroDocumentoBaixa := strNumDoc;

      strHistor := strHisDoc;

      fStartTransaction;

      {************************************}
      {* GRAVA OS LANÇAMENTOS DOS AJUSTES *}
      {*********************************AJ*}
      If (Not blnBaiMan) Then
      Begin
        If (Length(arrBaiSinDeb) > 0) Then
        Begin
          TBaixaCartoes.GravaMovBanAjustes(arrBaiSinDeb, objSequencias.intSeqLan, objSequencias.intContadorAutIncMovBan);
          TBaixaCartoes.GravaCadPagAjustes(arrBaiSinDeb, objSequencias.intSequencialCadPag, objSequencias.intContadorAutIncCadPag);

          Inc64(objSequencias.intSeqLan, Length(arrBaiSinDeb));
          Inc64(objSequencias.intSequencialCadPag, Length(arrBaiSinDeb));
          Inc64(objSequencias.intContadorAutIncMovBan, Length(arrBaiSinDeb));
          Inc64(objSequencias.intContadorAutIncCadPag, Length(arrBaiSinDeb));
        End;

        pCarregaArrayNegociacao;
        If Length(FArrayNegociacao) > 0 Then
        Begin
          TBaixaCartoes.GravaMovBanAjustes(FArrayNegociacao);
          TBaixaCartoes.GravaCadPagAjustes(FArrayNegociacao);
        End;
      End;

      While Not Eof Do
      Begin
        pStepStatusGravacao(pgbStatus);

        If FieldByName('MCA_MARDES').AsString = 'M' Then
        Begin
          TBaixaCartoes.GeraRegistroCTPDetDeTaxaParaMarketPlace(FRegistroCTPDetFrete,
                                                                FRegistroCTPDetAjuste,
                                                                cdsAux);

          If Not fEmptyStr(cdsAux.FieldByName('HISTORICO_BAIXA').AsString) Then
          Begin
            If (Pos(cdsAux.FieldByName('HISTORICO_BAIXA').AsString,strHistor) <= 0) Then
              strHistor := cdsAux.FieldByName('HISTORICO_BAIXA').AsString + ' ' + strHistor;

            If (Pos(cdsAux.FieldByName('HISTORICO_BAIXA').AsString,strHisDoc) <= 0) Then
              strHisDoc := cdsAux.FieldByName('HISTORICO_BAIXA').AsString + ' ' + strHisDoc;
          End;

          If fEmptyStr(strHistor) Then
            strHisDoc := 'Rec. ' + FieldByName('CAR_DESCAR').AsString;

          LBanMcaDS := TBanMcaDS.Create;
          LBanMcaDS.strNumDup := cdsAux.FieldByName('NRODUP').AsString;
          LBanMcaDS.strParcel := cdsAux.FieldByName('PARDUP').AsString;
          LBanMcaDS.strCodEmp := cdsAux.FieldByName('MCA_CODEMP').AsString;
          LBanMcaDS.strCodCli := cdsAux.FieldByName('MCA_CODCLI').AsString;
          LBanMcaDS.strCodCar := cdsAux.FieldByName('MCA_CODCAR').AsString;
          LBanMcaDS.strHist01 := cdsAux.FieldByName('MCA_HIST01').AsString;
          LBanMcaDS.strHist02 := cdsAux.FieldByName('MCA_HIST02').AsString;
          LBanMcaDS.strNumCCD := cdsAux.FieldByName('MCA_NUMCCD').AsString;
          LBanMcaDS.strNumNsu := cdsAux.FieldByName('MCA_NUMNSU').AsString;
          LBanMcaDS.fltValSta := cdsAux.FieldByName('MCA_VALSTA').AsFloat;
          LBanMcaDS.fltValTax := cdsAux.FieldByName('MCA_VALTAX').AsFloat;
          LBanMcaDS.fltValRec := cdsAux.FieldByName('MCA_VALREC').AsFloat;
          LBanMcaDS.fltFreMkt := cdsAux.FieldByName('FRETE_MARKETPLACE').AsFloat;
          LBanMcaDS.fltValAju := cdsAux.FieldByName('AJUSTE_MARKETPLACE').AsFloat;
          LBanMcaDS.fltCupMkt := cdsAux.FieldByName('CUPOM_MARKETPLACE').AsFloat;
          LBanMcaDS.strIdenti := 'VALSTA';
          LBanMcaDS.strAutInc := fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_strCodEmp);

          Inc64(objSequencias.intContadorAutIncBanMca);

          LListaBanMca := TListaBanMCA.Create;
          LListaBanMca.Add(LBanMcaDS);

          LValorCredito := FieldByName('MCA_VALSTA').AsFloat;
          If Not FBaixarTaxasAnaliticoMkt Then
            LValorCredito := LValorCredito +
                             Abs(FieldByName('CUPOM_MARKETPLACE').AsFloat);

          {*****************************************}
          {* GRAVA MOVBAN DO CARTÃO                *}
          {**************************************MV*}
          strSeqLanCre  := fGravaMovBan(IIF(blnBaiMan, strCtaCar, FieldByName('CAR_CTABAI').AsString),  // Centro de Custo
                                        IIF(blnBaiMan, strPorCar,FieldByName('CAR_PORBAI').AsString),  // Portador
                                        strLoginUsuarioLogado,                // Operador
                                        FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                        fTime(),                              // Hora do Lançamento
                                        strNumDoc,                           // Documento
                                        'C',                                  // Credito / Debito
                                        VS_strCodEmp,                         // Empresa
                                        LValorCredito,                        // Valor Documento
                                        strHisDoc + ' - Ref.Emp. ' + FieldByName('MCA_CODEMP').AsString,// Historico 1
                                        '',                                   // Historico 2
                                        FieldByName('MCA_CODCLI').AsString,   // Cliente
                                        '',                                   // Fornecedor
                                        '',                                   // Numero da Duplicata
                                        0,                                    // Sequencial Duplicata
                                        '',                                   // Parcela da Duplicata
                                        FieldByName('MCA_CODEMP').AsString,   // Empresa da Duplicata
                                        '',                                   // Série
                                        //'',                                 // Sequencial de Lançamento
                                        IIF(blnBaiMan, strEventoCredito, FieldByName('CAR_EVECRE').AsString), // Código do Evento
                                        '',                                   // Documento da Baixa
                                        Nil,                                  // Log Bancário
                                        0,
                                        intCtpCon,
                                        '',
                                        '',
                                        objSequencias.intSeqLan.ToString,
                                        fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_strCodEmp),
                                        '',
                                        '',
                                        1,
                                        True,
                                        LListaBanMca);

          Inc64(objSequencias.intSeqLan);
          Inc64(objSequencias.intContadorAutIncMovBan);

          blnConfirma := (Not fEmptyStr(strSeqLanCre));

          If (blnConfirma) Then
             pAtualizaDataMovimentobancarioMovCar( FieldByName('AUTOINC').AsString, FieldByName('MCA_DTAREC').AsDateTime );

          If (blnConfirma) And
             (((Not blnBaiMan) And (Not fEmptyStr(FieldByName('CAR_PORBAD').AsString))) Or
              ((blnBaiMan) And (Not fEmptyStr(strPorBad)))) Then
          Begin
            if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
            begin
              SetLength(arrSeqLanLoc, Length(arrSeqLanLoc) + 1);
              arrSeqLanLoc[Length(arrSeqLanLoc)-1] := strSeqLanCre;
            end;

            LBanMcaDS.strIdenti := 'VALSTA';
            LBanMcaDS.strAutInc := fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_strCodEmp);

            Inc64(objSequencias.intContadorAutIncBanMca);

            LListaBanMca := TListaBanMCA.Create;
            LListaBanMca.Add(LBanMcaDS);

            {*****************************************}
            {* GRAVA MOVBAN DO CARTÃO (DEBITO)       *}
            {**************************************MV*}
            strSeqLan   := fGravaMovBan(IIF(blnBaiMan, strCtaBad, FieldByName('CAR_CTABAD').AsString),  // Centro de Custo
                                        IIF(blnBaiMan, strPorBad,FieldByName('CAR_PORBAD').AsString),  // Portador
                                        strLoginUsuarioLogado,                // Operador
                                        FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                        fTime(),                              // Hora do Lançamento
                                        strNumDoc,                            // Documento
                                        'D',                                  // Credito / Debito
                                        VS_strCodEmp,                         // Empresa
                                        FieldByName('MCA_VALSTA').AsFloat +
                                          Abs(FieldByName('CUPOM_MARKETPLACE').AsFloat),    // Valor Documento
                                        strHisDoc + ' - Ref.Emp. ' + FieldByName('MCA_CODEMP').AsString,// Historico 1
                                        '',                                   // Historico 2
                                        FieldByName('MCA_CODCLI').AsString,   // Cliente
                                        '',                                   // Fornecedor
                                        '',                                   // Numero da Duplicata
                                        0,                                    // Sequencial Duplicata
                                        '',                                   // Parcela da Duplicata
                                        FieldByName('MCA_CODEMP').AsString,   // Empresa da Duplicata
                                        '',                                   // Série
                                        //'',                                 // Sequencial de Lançamento
                                        IIF(blnBaiMan, strEveDeb, FieldByName('CAR_EVEDEB').AsString),  // Codigo do Evento
                                        '',                                   // Documento da Baixa
                                        Nil,                                  // Log Bancário
                                        0,
                                        intCtpCon,
                                        '',
                                        '',
                                        objSequencias.intSeqLan.ToString,
                                        fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_strCodEmp),
                                        '',
                                        '',
                                        1,
                                        True,
                                        LListaBanMca);

            Inc64(objSequencias.intSeqLan);
            Inc64(objSequencias.intContadorAutIncMovBan);

            blnConfirma := (Not fEmptyStr(strSeqLan));
          End;

          {************************************}
          {* SÓ GRAVA TAXA SE VALREC < VALSTA *}
          {*********************************JU*}

          If (FieldByName('MCA_VALTAX').Value <> 0) And (blnConfirma) Then
          Begin
            LBanMcaDS.strIdenti := 'VALTAX';
            LBanMcaDS.strAutInc := fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_strCodEmp);

            Inc64(objSequencias.intContadorAutIncBanMca);

            LListaBanMca := TListaBanMCA.Create;
            LListaBanMca.Add(LBanMcaDS);

            LValorTotalTaxa := fFormataFloat(FieldByName('MCA_VALTAX').AsFloat -
                                             FieldByName('MCA_ANTTAX').AsFloat, 2);

            If Not FBaixarTaxasAnaliticoMkt Then
              LValorTotalTaxa := fFormataFloat(LValorTotalTaxa +
                                               Abs(FieldByName('FRETE_MARKETPLACE').AsFloat) +
                                               Abs(FieldByName('AJUSTE_MARKETPLACE').AsFloat), 2);

            {*****************************************}
            {* GRAVA MOVBAN DA TAXA                  *}
            {**************************************MV*}
            strSeqLanTax := fGravaMovBan(IIF(blnBaiMan, strCtaTax, FieldByName('CAR_CTATAX').AsString),  // Centro de Custo
                                         IIF(blnBaiMan, strPorTax, FieldByName('CAR_PORTAX').AsString),  // Portador
                                         strLoginUsuarioLogado,                // Operador
                                         FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                         fTime(),                              // Hora do Lançamento
                                         strNumDoc,                            // Documento
                                         'D',                                  // Credito / Debito
                                         VS_strCodEmp,                         // Empresa
                                         LValorTotalTaxa,                      // Valor Documento
                                         IIF(fEmptyStr(strHistor), 'Pag. de Taxas Ref. Aos Cartões',
                                             strHisDoc + ' - Ref.Emp. ' + FieldByName('MCA_CODEMP').AsString),// Historico 1
                                         '',                                   // Historico 2
                                         FieldByName('MCA_CODCLI').AsString,   // Cliente
                                         IIF(blnBaiMan, strForTax, FieldByName('CAR_FORTAX').AsString),  // Fornecedor
                                         '',                                   // Numero da Duplicata
                                         0,                                    // Sequencial Duplicata
                                         '',                                   // Parcela da Duplicata
                                         FieldByName('MCA_CODEMP').AsString,   // Empresa da Duplicata
                                         '',                                   // Série
                                         //'',                                 // Sequencial de Lançamento
                                         IIF(blnBaiMan, strEventoTaxa, FieldByName('CAR_EVETAX').AsString),  // Código do Evento
                                         '',
                                         Nil,
                                         0,
                                         intCtpCon,
                                         '',
                                         '',
                                         objSequencias.intSeqLan.ToString,
                                         fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_strCodEmp),
                                         '',
                                         '',
                                         1,
                                         True,
                                         LListaBanMca);

            Inc64(objSequencias.intSeqLan);
            Inc64(objSequencias.intContadorAutIncMovBan);

            blnConfirma := (Not fEmptyStr(strSeqLanTax));

            {************************}
            {* GRAVA CADPAG DA TAXA *}
            {*********************AF*}
            If (blnConfirma) Then
            Begin
              if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
              begin
                SetLength(arrSeqLanLoc, Length(arrSeqLanLoc) + 1);
                arrSeqLanLoc[Length(arrSeqLanLoc)-1] := strSeqLanTax;
              end;

              strNumDup := 'G' + fStrZero(objSequencias.intSequencialCadPag.ToString, 11);

              LValorTotalCtp := LValorTotalTaxa;

              If FBaixarTaxasAnaliticoMkt Then
                LValorTotalCtp := fFormataFloat(LValorTotalCtp +
                                                Abs(FieldByName('FRETE_MARKETPLACE').AsFloat) +
                                                Abs(FieldByName('AJUSTE_MARKETPLACE').AsFloat) -
                                                Abs(FieldByName('SUBTRAIR_FRETE').AsFloat), 2);

              blnConfirma := fGravaCadPag('frmBaixaCartoes',
                                          'INCLUSAO DA TAXA - CARTOES BX_ANA',
                                          IIF(blnBaiMan, strForTax, FieldByName('CAR_FORTAX').AsString),
                                          strNumDup,
                                          'A',
                                          FieldByName('MCA_CODEMP').AsString,
                                          IIF(blnBaiMan, strCtaTax, FieldByName('CAR_CTATAX').AsString),
                                          'CRT',
                                          0,
                                          FieldByName('MCA_DTAREC').Value,
                                          FieldByName('MCA_DTAREC').AsDateTime,
                                          0,
                                          LValorTotalCtp,
                                          'N',
                                          'N',
                                          'N',
                                          IIF(fEmptyStr(strHistor), 'Pag. de Taxas Ref. Aos Cartões',
                                                    strHisDoc + ' - Ref.Emp. ' + FieldByName('MCA_CODEMP').AsString),
                                          '',
                                          'Pag. de Taxas Ref. Aos Cartões',
                                          IIF(blnBaiMan, strPorTax, FieldByName('CAR_PORTAX').AsString),
                                          IIF(blnBaiMan, strCtaTax, FieldByName('CAR_CTATAX').AsString),
                                          strSeqLanTax,
                                          strLoginUsuarioLogado,
                                          FieldByName('MCA_DTAREC').Value,
                                          LValorTotalCtp,
                                          0,
                                          0,
                                          VS_strCodEmp,
                                          IIF(blnBaiMan, strEventoTaxa, FieldByName('CAR_EVETAX').AsString),
                                          '',
                                          IIF(blnBaiMan, strPorTax, FieldByName('CAR_PORTAX').AsString),
                                          '',
                                          0.0,
                                          0.0,
                                          intCtpCon,
                                          False,
                                          0,
                                          '',
                                          0,
                                          '',
                                          '',
                                          '',
                                          '',
                                          fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_strCodEmp),
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
                                          LValorTotalCtp,
                                          0,
                                          0,
                                          0,
                                          '',
                                          0,
                                          0,
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '0',
                                          '',
                                          '',
                                          fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_strCodEmp));

              Inc64(objSequencias.intContadorAutIncCadPag);
              Inc64(objSequencias.intContadorAutIncLogCtp);
              Inc64(objSequencias.intSequencialCadPag);

              If blnConfirma Then
                TBaixaCartoes.GravaCTPDetDeTaxaParaMarketPlaceAnalitico(strNumDup,
                                                                        IIF(blnBaiMan, strForTax, FieldByName('CAR_FORTAX').AsString),
                                                                        FieldByName('MCA_CODEMP').AsString,
                                                                        'CRT',
                                                                        IIF(blnBaiMan, strCtaTax, FieldByName('CAR_CTATAX').AsString),
                                                                        IIF(blnBaiMan, strEventoTaxa, FieldByName('CAR_EVETAX').AsString),
                                                                        LValorTotalCtp,
                                                                        FRegistroCTPDetFrete,
                                                                        FRegistroCTPDetAjuste);

            End;
          End;

          {******************************}
          {* GRAVA TAXAS DE ANTECIPAÇÃO *}
          {***************************AJ*}
          If (FieldByName('MCA_ANTTAX').Value <> 0) And (blnConfirma) Then
          Begin
            LBanMcaDS.strIdenti := 'ANTTAX';
            LBanMcaDS.strAutInc := fFormataAutInc(objSequencias.intContadorAutIncBanMca, VS_strCodEmp);

            Inc64(objSequencias.intContadorAutIncBanMca);

            LListaBanMca := TListaBanMCA.Create;
            LListaBanMca.Add(LBanMcaDS);

            {*****************************************}
            {* GRAVA MOVBAN DA TAXA DE ANTECIPAÇÃO   *}
            {**************************************AJ*}
            strSeqLanAnt := fGravaMovBan(IIF(blnBaiMan, strCtaTax, FieldByName('CAR_CTAANT').AsString),  // Centro de Custo
                                         IIF(blnBaiMan, strPorTax, FieldByName('CAR_PORTAX').AsString),  // Portador
                                         strLoginUsuarioLogado,                // Operador
                                         FieldByName('MCA_DTAREC').Value,      // Data do Lançamento
                                         fTime(),                              // Hora do Lançamento
                                         strNumDoc,                            // Documento
                                         'D',                                  // Credito / Debito
                                         VS_strCodEmp,                         // Empresa
                                         FieldByName('MCA_ANTTAX').AsFloat,    // Valor Documento
                                         IIF(fEmptyStr(strHistor), 'Pag. de Tx Antecip. Ref. Aos Cartões',
                                             'Tx Antecip. ' + strHisDoc + ' - Ref.Emp. ' + FieldByName('MCA_CODEMP').AsString),// Historico 1
                                         '',                                   // Historico 2
                                         FieldByName('MCA_CODCLI').AsString,   // Cliente
                                         IIF(blnBaiMan, strForTax, FieldByName('CAR_FORTAX').AsString),  // Fornecedor
                                         '',                                   // Numero da Duplicata
                                         0,                                    // Sequencial Duplicata
                                         '',                                   // Parcela da Duplicata
                                         FieldByName('MCA_CODEMP').AsString,   // Empresa da Duplicata
                                         '',                                   // Série
                                         //'',                                 // Sequencial de Lançamento
                                         '',                                   // Código do Evento
                                         '',
                                         Nil,
                                         0,
                                         intCtpCon,
                                         '',
                                         '',
                                         objSequencias.intSeqLan.ToString,
                                         fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_strCodEmp),
                                         '',
                                         '',
                                         1,
                                         True,
                                         LListaBanMca);

            Inc64(objSequencias.intSeqLan);
            Inc64(objSequencias.intContadorAutIncMovBan);

            blnConfirma := (Not fEmptyStr(strSeqLanAnt));

            {***************************************}
            {* GRAVA CADPAG DA TAXA DE ANTECIPAÇÃO *}
            {************************************AJ*}
            If (blnConfirma) Then
            Begin
              if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
              begin
                SetLength(arrSeqLanLoc, Length(arrSeqLanLoc) + 1);
                arrSeqLanLoc[Length(arrSeqLanLoc)-1] := strSeqLanTax;
              end;

              strNumDup := 'G' + fStrZero(objSequencias.intSequencialCadPag.ToString, 11);

              blnConfirma := fGravaCadPag('frmBaixaCartoes',
                                          'INCLUSAO DA TAXA - CARTOES BX_ANA',
                                          IIF(blnBaiMan, strForTax, FieldByName('CAR_FORTAX').AsString),
                                          strNumDup,
                                          'A',
                                          FieldByName('MCA_CODEMP').AsString,
                                          IIF(blnBaiMan, strCtaAnt, FieldByName('CAR_CTAANT').AsString),
                                          'CRT',
                                          0,
                                          FieldByName('MCA_DTAREC').Value,
                                          FieldByName('MCA_DTAREC').AsDateTime,
                                          0,
                                          FieldByName('MCA_ANTTAX').AsFloat,
                                          'N',
                                          'N',
                                          'N',
                                          IIF(fEmptyStr(strHistor), 'Pag. de Tx Atecip. Ref. Aos Cartões',
                                                    strHisDoc + ' - Ref.Emp. ' + FieldByName('MCA_CODEMP').AsString),
                                          '',
                                          'Pag. de Tx Antecip. Ref. Aos Cartões',
                                          IIF(blnBaiMan, strPorTax, FieldByName('CAR_PORTAX').AsString),
                                          IIF(blnBaiMan, strCtaAnt, FieldByName('CAR_CTAANT').AsString),
                                          strSeqLanAnt,
                                          strLoginUsuarioLogado,
                                          FieldByName('MCA_DTAREC').Value,
                                          FieldByName('MCA_ANTTAX').AsFloat,
                                          0,
                                          0,
                                          VS_strCodEmp,
                                          '',
                                          '',
                                          '',
                                          '',
                                          0.0,
                                          0.0,
                                          intCtpCon,
                                          False,
                                          0,
                                          '',
                                          0,
                                          '',
                                          '',
                                          '',
                                          '',
                                          fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_strCodEmp),
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
                                          FieldByName('MCA_ANTTAX').AsFloat,
                                          0,
                                          0,
                                          0,
                                          '',
                                          0,
                                          0,
                                          '',
                                          '',
                                          '',
                                          '',
                                          '',
                                          '0',
                                          '',
                                          '',
                                          fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_strCodEmp));

              Inc64(objSequencias.intContadorAutIncCadPag);
              Inc64(objSequencias.intContadorAutIncLogCtp);
              Inc64(objSequencias.intSequencialCadPag);
            End;
          End;

          If FBaixarTaxasAnaliticoMkt Then
          Begin
            If blnConfirma Then
              TBaixaCartoes.GravarMovBanAnalitoFreteTaxasMarketPlace(cdsAux,
                                                                     objSequencias,
                                                                     LSeqLanFrete,
                                                                     LSeqLanAjuste,
                                                                     LSeqLanCupom);
          End;

          If blnConfirma Then
          Begin

            {*****************************************}
            {* BAIXA UM REGISTRO                     *}
            {**************************************MV*}
            blnConfirma := fBaixaCartao(Self.Name,
                                        'BAIXA DE CARTÕES ' +
                                             IIF(blnBaiMan, '(MANUAL)', '(' + Self.Caption + ')'),
                                        FieldByName('AUTOINC').AsString,
                                        FieldByName('NRODUP').AsString,
                                        FieldByName('PARDUP').AsString,
                                        FieldByName('MCA_CODCLI').AsString,
                                        FieldByName('MCA_CODEMP').AsString,
                                        FieldByName('MCA_DTAREC').Value,
                                        FieldByName('MCA_VALREC').AsFloat,
                                        strLoginUsuarioLogado,
                                        strHisDoc,
                                        IIF(blnBaiMan, strPorCar, FieldByName('CAR_PORBAI').AsString),
                                        IIF(blnBaiMan, strCtaCar, FieldByName('CAR_CTABAI').AsString),
                                        strSeqLanCre,
                                        IIF(blnBaiMan, strPorTax, FieldByName('CAR_PORTAX').AsString),
                                        IIF(blnBaiMan, strCtaTax, FieldByName('CAR_CTATAX').AsString),
                                        strSeqLanTax,
                                        IIF(blnBaiMan, strForTax, FieldByName('CAR_FORTAX').AsString),
                                        IIF(blnBaiMan, strCtaBad, FieldByName('CAR_CTABAD').AsString),
                                        IIF(blnBaiMan, strPorBad, FieldByName('CAR_PORBAD').AsString),
                                        strSeqLan,
                                        FieldByName('MCA_CHACON').AsString,
                                        IIF(blnBaiMan, strEveDeb, FieldByName('CAR_EVEDEB').AsString),
                                        IIF(FieldByName('MCA_ANT_SN').AsString = 'N',
                                             '', FieldByName('CAR_CTAANT').AsString),
                                        IIF(FieldByName('MCA_ANT_SN').AsString = 'N',
                                             '', strSeqLanAnt),
                                        IIF(FieldByName('MCA_ANT_SN').AsString = 'N',
                                             0, FieldByName('MCA_ANTTAX').AsFloat),
                                        fFormataAutInc(objSequencias.intContadorAutIncLogMca, VS_strCodEmp),
                                        IIF(blnBaiMan, strEventoCredito, FieldByName('CAR_EVECRE').AsString),
                                        IIF(blnBaiMan, strEventoTaxa, FieldByName('CAR_EVETAX').AsString),
                                        IIF(blnBaiMan, 0.00, FieldByName('FRETE_MARKETPLACE').AsFloat),
                                        IIF(blnBaiMan, 0.00, FieldByName('AJUSTE_MARKETPLACE').AsFloat),
                                        IIF(blnBaiMan, 0.00, FieldByName('MCA_VALTAX').AsFloat),
                                        IIF(blnBaiMan, 0.00, FieldByName('CUPOM_MARKETPLACE').AsFloat),
                                        FieldByName('ALTERAR_BRUTO').AsString.Equals('S'),
                                        FieldByName('MCA_VALSTA').AsFloat,
                                        LSeqLanFrete,
                                        LSeqLanAjuste,
                                        LSeqLanCupom);

            Inc64(objSequencias.intContadorAutIncLogMca);

            If (blnConRed) And (blnConfirma) Then
            Begin
              SetLength(arrNumNsu, Length(arrNumNsu) + 1);

              arrNumNsu[Length(arrNumNsu) - 1] := fPadL(FieldByName('MCA_NUMNSU').AsString, 14, '0');
            End;

          End;

        End;

        If Not blnConfirma Then
          Break;

        Next;
      End;

      If blnConcil Then
      Begin
        If blnConfirma Then
          TBaixaCartoes.GravaMovBanDeTransferencias(cdsBaiCar,
                                                    objConcil.strNomCon,
                                                    objSequencias);
      End;

      If (blnConcil) And (blnConfirma) Then
      Begin
        If (Not objConcil.strChavePrimaria.IsEmpty) Then
          TBaixaCartoes.MarcarComoConciliado(objConcil, cdsBaiCar);
      End;

      If Not blnConfirma Then
        Raise Exception.Create('Não foi possível baixar o(s) cartão(ões)!')
      Else
        blnConfirmaBaixa := True;
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      blnConfirmaBaixa := False;
      Result := false;
      pMensagensErro(E.Message, '[TfrmBaixaCartoes.fGravaCartoes]');
      FreeAndNil(cdsAux);
      Exit;
    End;
  End;

  FreeAndNil(cdsAux);

  If Assigned(LListaBanMca) Then
    FreeAndNil(LListaBanMca);

  Result := True;
end;

function TfrmBaixaCartoes.fGetCartoes: String;
  Var
    stlCartos: TStringList;
    intIndice: Integer;
    prcScroll: TprcScroll;
Begin
  stlCartos := TStringList.Create;
  stlCartos.Sorted := True;
  stlCartos.Clear;

  pDisableControls(cdsBaiCar, prcScroll);
  cdsBaiCar.First;
  While Not cdsBaiCar.Eof Do
  Begin
    If (cdsBaiCar.FieldByName('MCA_MARDES').AsString <> 'M') Then
    Begin
      cdsBaiCar.Next;
      Continue;
    End;

    If cdsBaiCar.FieldByName('MCA_AJUSTE').AsString = 'N' Then
    Begin
      If Not stlCartos.Find(cdsBaiCar.FieldByName('MCA_CODCAR').AsString, intIndice) Then
        stlCartos.Add(cdsBaiCar.FieldByName('MCA_CODCAR').AsString);
    End;

    cdsBaiCar.Next;
  End;

  Result := stlCartos.CommaText;
  stlCartos.Clear;
  FreeAndNil(stlCartos);

  pEnableControls(cdsBaiCar, prcScroll);
End;

function TfrmBaixaCartoes.fAchouRegistro(blnInicio:Boolean=True):Boolean;
Var
  registro:Integer;
begin
  Result := False;
  registro := cdsBaiCar.Recno;

  if not blnInicio then
    cdsBaiCar.Next;

  while not cdsBaiCar.Eof do
  begin
    if (
         iif(not fEmptyStr(arrBusca[0].NumCCD),cdsBaiCar.FieldByName('MCA_NUMCCD').AsString,True) =
         iif(not fEmptyStr(arrBusca[0].NumCCD),arrBusca[0].NumCCD,True) )
       AND
       (
         iif(not fEmptyStr(arrBusca[0].NumNsu),cdsBaiCar.FieldByName('MCA_NUMNSU').AsString,True) =
         iif(not fEmptyStr(arrBusca[0].NumNsu),arrBusca[0].NumNsu,True) )
       AND
       (
         iif(not fEmptyStr(fTiraCaracEspeciais(arrBusca[0].DtaCad)),cdsBaiCar.FieldByName('MCA_DTACAD').AsString,True) =
         iif(not fEmptyStr(fTiraCaracEspeciais(arrBusca[0].DtaCad)),arrBusca[0].DtaCad,True) )
       AND
       (
         iif(not fEmptyStr(fTiraCaracEspeciais(arrBusca[0].DtaVen)),cdsBaiCar.FieldByName('MCA_DTAVEN').AsString,True) =
         iif(not fEmptyStr(fTiraCaracEspeciais(arrBusca[0].DtaVen)),arrBusca[0].DtaVen,True) )
       AND
       (
         iif(not fEmptyStr(arrBusca[0].Valor),fStrToFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsString),True) =
         iif(not fEmptyStr(arrBusca[0].Valor),arrBusca[0].Valor,True) )
       AND
       (
         iif(not fEmptyStr(arrBusca[0].Nome),true,false) =
         iif(not fEmptyStr(arrBusca[0].Nome),cdsBaiCar.FieldByName('CLI_NOMCLI').AsString.Contains(arrBusca[0].Nome),false)
        )
       AND
       (
         iif(not fEmptyStr(arrBusca[0].CpfCgc),cdsBaiCar.FieldByName('CLI_C_G_C_').AsString,True) =
         iif(not fEmptyStr(arrBusca[0].CpfCgc),arrBusca[0].CpfCgc,True)
       )
       then
       begin
         Result := True;
         Exit;
       end;
    cdsBaiCar.Next;
  end;
  if not Result then
    cdsBaiCar.Recno := registro;
end;

{*****************************************}
{* BAIXA AS DUPLICATAS SELECIONADAS      *}
{**************************************MV*}
function TfrmBaixaCartoes.fBaixaDuplicatas: Boolean;
  Var
    blnBaiAna   : Boolean;
    blnConfirma : Boolean;
    Key         : Char;

    frmBaixaCtcAnaSin : TfrmBaixaCtcAnaSin;
begin
  Result       := False;
  blnBaiAna    := fCfgSis('CTC_AS') = 'A';
  strSeqLan    := '';
  strSeqLanTax := '';
  strSeqLanCre := '';

  {***************************************}
  {* VERIFICA SE POSSUI INCONSISTÊNCIAS  *}
  {* DE CONCILIAÇÃO PARA PEDIR O DIREITO *}
  {* DE ACESSO PARA CONTINUAR A BAIXA    *}
  {************************************AJ*}
  If (blnInconsist) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Permitir realizar a baixa de cartões de crédito com inconsistências.');

    objLiberacao.strDirAce := 'CARBAIINC';
    objLiberacao.strMsgSen := 'Realizar a baixa de cartões de crédito com inconsistências';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;

    If Not objLiberacao.fLibera Then
      Exit;
  End;

  {*****************************************}
  {* CHAMA A TELA DE BAIXA                 *}
  {**************************************MV*}
  Try
    cdsBaiCar.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND MCA_AJUSTE=' + QuotedStr('N');
    cdsBaiCar.Filtered := True;

    cdsCloneConsulta := CriarClientDataSet(cdsBaiCar);

    pCriarFormularios(TfrmBaixaCtcAnaSin, frmBaixaCtcAnaSin);
    frmBaixaCtcAnaSin.blnBaiAna    := blnBaiAna;
    frmBaixaCtcAnaSin.blnZeraTx    := fDoubleAggregate(cdsBaiCar, 'TOT_VALTAX') = 0;
    frmBaixaCtcAnaSin.dtaMaxDta    := TBaixaCartoes.CalculaDataMinimaParaPortador(cdsBaiCar);
    frmBaixaCtcAnaSin.strCodEmp    := edtCodEmp.Text;
    frmBaixaCtcAnaSin.blnConcil    := Not blnBaiMan;
    frmBaixaCtcAnaSin.blnVemBxCart := True;

    If (Not cdsBaiCar.IsEmpty) Then
    Begin
      If fCfgSis('BAIOTI', varBoolean) Then
      Begin
        If blnBaiMan Then
        Begin
          If fGetDadosBaixaCartao(fGetCartoes,
                                  strPorCar,
                                  strCtaCar,
                                  strEventoCredito,
                                  strPorTax,
                                  strCtaTax,
                                  strForTax,
                                  strEventoTaxa,
                                  strPorBad,
                                  strCtaBad,
                                  strEveDeb,
                                  True) Then
          Begin
            frmBaixaCtcAnaSin.strPorCar        := strPorCar;
            frmBaixaCtcAnaSin.strCtaCar        := strCtaCar;
            frmBaixaCtcAnaSin.strEventoCredito := strEventoCredito;
            frmBaixaCtcAnaSin.strPorTax        := strPorTax;
            frmBaixaCtcAnaSin.strCtaTax        := strCtaTax;
            frmBaixaCtcAnaSin.strForTax        := strForTax;
            frmBaixaCtcAnaSin.strEventoTaxa    := strEventoTaxa;
            frmBaixaCtcAnaSin.strPorDeb        := strPorBad;
            frmBaixaCtcAnaSin.strCtaDeb        := strCtaBad;
            frmBaixaCtcAnaSin.strEveDeb        := strEveDeb;
          End;
        End;
      End;
    End;

    frmBaixaCtcAnaSin.mskDtaDoc.Enabled := Not blnConRed;
    frmBaixaCtcAnaSin.edtPorCar.Enabled := Not blnConRed;
    frmBaixaCtcAnaSin.fraPlanoDeContasCar.MskCodCta.Enabled := Not blnConRed;
    frmBaixaCtcAnaSin.edtPorTax.Enabled := Not blnConRed;
    frmBaixaCtcAnaSin.edtCodFor.Enabled := Not blnConRed;
    frmBaixaCtcAnaSin.fraPlanoDeContasTax.MskCodCta.Enabled := Not blnConRed;
    frmBaixaCtcAnaSin.edtPorDeb.Enabled := Not blnConRed;
    frmBaixaCtcAnaSin.fraPlanoDeContasDeb.MskCodCta.Enabled := Not blnConRed;

    if strCodPorFix <> '' then
    begin
      frmBaixaCtcAnaSin.strPortadorExtrato := strCodPorFix;
      frmBaixaCtcAnaSin.edtPorCar.Text := strCodPorFix;
      Key := #13;
      frmBaixaCtcAnaSin.edtPorCarKeyPress(nil, Key);
      frmBaixaCtcAnaSin.edtPorCar.Enabled := False;
      frmBaixaCtcAnaSin.mskDtaDoc.Date    := dteDtaRecFix;
      frmBaixaCtcAnaSin.mskDtaDoc.Enabled := False;
    end;

    frmBaixaCtcAnaSin.showModal;

    If Not frmBaixaCtcAnaSin.blnConfirma Or Not VerificacoesParaBaixa Then
    Begin
      cdsBaiCar.Filter   := 'MCA_MARDES = ''M'' AND REGISTROTRANSFERENCIA=''N'' ';
      cdsBaiCar.Filtered := True;
      If blnBaiMan Then
        cdsBaiCar.Filter   := '';

      pFreeAndNil(frmBaixaCtcAnaSin);
      Exit;
    End;

    If blnBaiMan Then
    Begin
      strPorCar        := frmBaixaCtcAnaSin.strPorCar;
      strCtaCar        := frmBaixaCtcAnaSin.strCtaCar;
      strPorBad        := frmBaixaCtcAnaSin.strPorDeb;
      strCtaBad        := frmBaixaCtcAnaSin.strCtaDeb;
      strPorTax        := frmBaixaCtcAnaSin.strPorTax;
      strCtaTax        := frmBaixaCtcAnaSin.strCtaTax;
      strForTax        := frmBaixaCtcAnaSin.strForTax;
      strEveDeb        := frmBaixaCtcAnaSin.strEveDeb;
      strEventoCredito := frmBaixaCtcAnaSin.strEventoCredito;
      strEventoTaxa    := frmBaixaCtcAnaSin.strEventoTaxa;
    End;

    strNumDoc := frmBaixaCtcAnaSin.strNumDoc;
    strHisDoc := frmBaixaCtcAnaSin.strHisDoc;

    blnConfirma := frmBaixaCtcAnaSin.blnConfirma;

    If (Not blnBaiAna) And (blnConfirma) Then
    Begin
      dtaDtaDoc := frmBaixaCtcAnaSin.dtaDtaDoc;

      blnConfirma := TBaixaCartoes.ValidaDadosDigitadosBaixaSintetica(cdsCloneConsulta,
                                                                      DateToStr(dtaDtaDoc),
                                                                      strPorCar,
                                                                      strPorTax,
                                                                      strPorBad);
      If Not blnConfirma Then
      Begin
        cdsBaiCar.Filter   := 'MCA_MARDES = ''M'' AND REGISTROTRANSFERENCIA=''N'' ';
        cdsBaiCar.Filtered := True;
        If blnBaiMan Then
          cdsBaiCar.Filter   := '';
      End;
    End;

  Except
    On E: Exception Do
    Begin
      blnConfirma := False;
      pMensagensErro('Ocorreu um erro ao validar os dados dos cartões. ' + #13 +
                     'Erro gerado: ' + E.Message, '[frmBaixaCartoes.fBaixaDuplicatas]');
    End;
  End;

  pFreeAndNil(frmBaixaCtcAnaSin);

  //FECHAMENTO FINANCEIRO
  //VERIFICA A DATA DA BAIXA DO DOCUMENTO SINTÉTICO
  if dtaDtaDoc > 0 then
    if objFechamento.FechamentoFinanceiroJaRealizado(edtCodEmp.Text, dtaDtaDoc) then
      blnConfirma := False;

  {*****************************************}
  {* CASO OCORREU UM ERRO, SAI             *}
  {**************************************MV*}
  If Not blnConfirma Then
  Begin
    cdsBaiCar.Filter   := 'MCA_MARDES = ''M'' AND REGISTROTRANSFERENCIA=''N'' ';
    cdsBaiCar.Filtered := True;
    If blnBaiMan Then
      cdsBaiCar.Filter   := '';
    pSetFocus(grdDuplic);
    Exit;
  End;

  {*****************************************}
  {* PROCESSA AS DUPLITAS MARCADAS         *}
  {**************************************MV*}
  Application.ProcessMessages;
  fAbrirTabela(qryCadPag);
  Application.ProcessMessages;
  Try
    With cdsBaiCar Do
    Begin
      Filter   := 'MCA_MARDES = ' + QuotedStr('M');
      Filtered := True;

      First;
      Application.ProcessMessages;

      {*******************}
      {* BAIXA SINTÉTICA *}
      {****************AJ*}
      If (blnConfirma) And (Not blnBaiAna)  Then
      Begin
        Try
          blnConfirmaBaixa := False;
          pCriarFormularios(TfrmGravando,frmGravando);
          frmGravando.fExecutarAcao := fGravaCartoesSin;
          frmGravando.lblGravando.Caption := 'Aguarde... Gravando cartões';
          frmGravando.ShowModal;
          blnConfirma := frmGravando.blnConfirma;

          blnConfirma := blnConfirmaBaixa;
          pFreeAndNil(frmGravando);

        Except
          On E: Exception Do
          Begin
            fRollBack;
            blnConfirma := False;
            pMensagensErro(E.Message,'[untBaixaCartoes.fGravaCartoesSin]');
          End;
        End;
      End;

      {*******************}
      {* BAIXA ANALÍTICA *}
      {*******************}
      If (blnConfirma) And
         (blnBaiAna)   Then
      Begin

        Try
          blnConfirmaBaixa := False;
          pCriarFormularios(TfrmGravando,frmGravando);
          frmGravando.fExecutarAcao := fGravaCartoes;
          frmGravando.lblGravando.Caption := 'Aguarde... Gravando cartões';
          frmGravando.ShowModal;

          pFreeAndNil(frmGravando);

          blnConfirma := blnConfirmaBaixa;
        Except
          On E: Exception Do
          Begin
            fRollBack;
            blnConfirma := False;
            pMensagensErro(E.Message, '[untBaixaCartoes.fGravaCartoes]');
          End;
        End;

      End;

    End;

    If (blnConRed) And (blnConfirma) Then
      blnConfirma := fSetaDupBaixadasRede(arrNumNsu);

    Try
      If (blnConfirma) And
         (Not blnBaiMan) And
         (objConcil.strTabCon = 'KON_KOPGTO') And
         (Assigned(cdsResolverAPI)) Then
      Begin
        pMarcaRegistrosResolvidoKoncilia(cdsResolverAPI);

        If Assigned(cdsResolverAPICanc) Then
          pMarcaRegistrosResolvidoKoncilia(cdsResolverAPICanc);
      End;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        blnConfirma := False;
        pMensagensErro(E.Message, '[untBaixaCartoes.pMarcaRegistrosResolvidoKoncilia]');
      End;
    End;

    Try
      If blnConfirma Then
      Begin
        If Not blnBaiMan Then
        Begin
          If MatchStr(objConcil.strTabCon, ['MER_MLPGTO', 'STO_STPGTO', 'MLZ_MZPGTO']) Then
            TBaixaCartoes.MarcaRegistrosConciliadoPelaLista(FRegistrosConciliar,
                                                            objConcil);
        End;
      End;
    Except
      On E: Exception Do
      Begin
        fRollBack;
        blnConfirma := False;
        pMensagensErro(E.Message, '[TBaixaCartoes.MarcaRegistrosConciliadoPelaLista]');
      End;
    End;

  Finally
    If blnConfirma Then
      fCommit
    Else
      fRollBack;
  End;

  CartoesPendentesDeConciliacao;

  fFecharTabela(qryCadPag);

  If Assigned(cdsCloneConsulta) Then
    FreeAndNil(cdsCloneConsulta);

  Result := blnConfirma;
end;

procedure TfrmBaixaCartoes.edtCodCarKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE CARTOES  *}
  {**************************DP*}
  If fPesqCartao(Self, edtCodCar, edtDesCar, Nil, Key, arrCartao, False, False, False, True, True, Not blnAcesso) Then
  Begin
    fValidaCampos(edtCodCar,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCartoes.edtCodCli2Exit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodCli2, edtNomCli2, arrClientes, Nil, fRetNomCliente, 'do cliente', 8);
end;

procedure TfrmBaixaCartoes.edtCodCli2KeyPress(Sender: TObject; var Key: Char);
begin
  If fPesqCliente(conCliSimples, Self, edtCodCli2, edtNomCli2, Nil, Key, arrClientes, False) Then
  Begin
    If fValidaCampos(edtCodCli2, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCartoes.btnIniBusClick(Sender: TObject);
begin
  inherited;
  If Not TBitBtnLocked(Sender).Visible Then
    Exit;

  If cdsBaiCar.IsEmpty Then
  Begin
    fMensagem('', 'É necessário selecionar ao menos um cartão!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmBaixaCtcBusca, frmBaixaCtcBusca);
    frmBaixaCtcBusca.ShowModal;
    pPreencheVetor;
    TfrmGravando.fExecutarModal(pBuscarIni,'Aguarde... Localizando cartão.','');
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmBaixaCtcBusca);
  pSetFocus(grdDuplic);
  pAtualizaDados(cdsBaiCar);
end;

procedure TfrmBaixaCartoes.btnLocProxClick(Sender: TObject);
begin
  inherited;
  If Not TBitBtnLocked(Sender).Visible Then
    Exit;

  If cdsBaiCar.IsEmpty Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar ao menos um cartão!', ['&Ok']);
    Exit;
  End;

  TfrmGravando.fExecutarModal(pBuscarProx,'Aguarde... Localizando cartão.','');

  pSetFocus(grdDuplic);
  pAtualizaDados(cdsBaiCar);
end;

procedure TfrmBaixaCartoes.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtDesEmp, arrEmp, Nil, fRetNomeEmpresaSelec, 'da empresa', 3);
end;

procedure TfrmBaixaCartoes.edtCodEmpKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtDesEmp, Nil, Key, arrEmp, False, Not blnAcesso) Then
  Begin
    If fValidaCampos(edtCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCartoes.ExibirPorcentagemTaxaDeAntecipacao;
  Var
    LValorDaAntecipacao: Double;
    LPorcenTaxaAntecipacao : Double;
begin
  LValorDaAntecipacao := 0.00;
  edtPorcentagemTaxaAntecipacao.Text := FormatFloat(',0.000000', LValorDaAntecipacao);

  If Not cdsBaiCar.FieldByName('MCA_ANTTAX').IsNull Then
    LValorDaAntecipacao := cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat;

  If (LValorDaAntecipacao > 0) And (fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat, 2) > 0) Then
  Begin
    LPorcenTaxaAntecipacao := ((LValorDaAntecipacao / cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100);

    edtPorcentagemTaxaAntecipacao.Text := FormatFloat(',0.000000', LPorcenTaxaAntecipacao);

    edtPerCar.Text := FormatFloat(',0.000000',(cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat -  LPorcenTaxaAntecipacao));
  end;

  edtPorcentagemTaxaAntecipacao.Text := Concat(edtPorcentagemTaxaAntecipacao.Text,' %');
End;

function TfrmBaixaCartoes.fGetEmpresaAjuste(ADataset: TUniClientDataset): string;
begin
  Result := ADataset.FieldByName('MCA_CODEMP').AsString;
end;

procedure TfrmBaixaCartoes.pCarregaArrAjustes;
  Var
    strCodEmp: String;
    dtaDtaRec: TDateTime;
    fltValDoc: Double;
    blnVerifi: Boolean;
    strPorBai,
    strCtaBai,
    strTaxaFo,
    strFilAnt,
    strTipAju,
    strEventoCancelamentoAjuste: String;
begin
  //Apenas para conciliação automática
  Application.ProcessMessages;

  With cdsBaiCar Do
  Begin
    strFilant := Filter;

    Filter := 'MCA_AJUSTE=''S'' AND REGISTROTRANSFERENCIA=''N'' AND NEGOCIACAO <> ''S'' ';

    IndexFieldNames := 'MCA_CODEMP;MCA_DTAREC;CAR_PORBAI;CAR_CTABAI;CAR_FORTAX;MCA_VALREC;MCA_EVECAN';
    strCampoFiltro  := '';
    strValorFiltro  := '';
    Filtered        := True;
    SetLength(arrBaiSinDeb, 0);

    If RecordCOunt > 0 Then
    Begin
      First;
      strCodEmp                   := fGetEmpresaAjuste(cdsBaiCar);
      dtaDtaRec                   := FieldByName('MCA_DTAREC').Value;
      strPorBai                   := FieldByName('CAR_PORBAI').AsString;
      strCtaBai                   := FieldByName('CAR_CTABAI').AsString;
      strTaxaFo                   := FieldByName('CAR_FORTAX').AsString;
      strEventoCancelamentoAjuste := FieldByName('MCA_EVECAN').AsString;
      fltValDoc                   := 0;
      strTipAju                   := IIF(FieldByName('MCA_VALREC').Value < 0, 'D', 'C');

      While Not Eof Do
      Begin
        blnVerifi := (fGetEmpresaAjuste(cdsBaiCar) <> strCodEmp) Or
                     (FieldByName('MCA_DTAREC').Value <> dtaDtaRec)    Or
                     (FieldByName('CAR_PORBAI').AsString <> strPorBai) Or
                     (FieldByName('CAR_CTABAI').AsString <> strCtaBai) Or
                     (FieldByName('CAR_FORTAX').AsString <> strTaxaFo) Or
                     (FieldByName('MCA_EVECAN').AsString <> strEventoCancelamentoAjuste) Or
                     (IIF(FieldByName('MCA_VALREC').Value < 0, 'D', 'C') <> strTipAju);

        If blnVerifi Then
        Begin
          SetLength(arrBaiSinDeb, Length(arrBaiSinDeb) + 1);

          arrBaiSinDeb[Length(arrBaiSinDeb) - 1].fltValDoc := fltValDoc;
          arrBaiSinDeb[Length(arrBaiSinDeb) - 1].fltValTax := 0;
          arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strCodEmp := strCodEmp;
          arrBaiSinDeb[Length(arrBaiSinDeb) - 1].dtaDtaRec := dtaDtaRec;
          arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strPorBai := strPorBai;
          arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strCtaBai := strCtaBai;
          arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strForTax := strTaxaFo;
          arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strNumDoc := strNumDoc;

          If Not fEmptyStr(cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString) Then
          Begin
            If (Pos(cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString,strHisDoc) <= 0) Then
              strHisDoc := cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString + ' ' + strHisDoc;
          End;

          arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strHisDoc := strHisDoc + ' - Canc./Ajuste Cartões';
          arrBaiSinDeb[Length(arrBaiSinDeb) - 1].intPagCon := intCtpCon;
          //arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strTipAju := IIF(FieldByName('MCA_VALREC').Value < 0, 'D', 'C');
          arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strTipAju := IIF(fltValDoc < 0, 'D', 'C');
          arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strEventoCancelamentoAjuste :=
            strEventoCancelamentoAjuste;

          strCodEmp                   := fGetEmpresaAjuste(cdsBaiCar);
          dtaDtaRec                   := FieldByName('MCA_DTAREC').Value;
          fltValDoc                   := FieldByName('MCA_VALREC').AsFloat;
          strPorBai                   := FieldByName('CAR_PORBAI').AsString;
          strCtaBai                   := FieldByName('CAR_CTABAI').AsString;
          strTaxaFo                   := FieldByName('CAR_FORTAX').AsString;
          strEventoCancelamentoAjuste := FieldByName('MCA_EVECAN').AsString;
          strTipAju                   := IIF(FieldByName('MCA_VALREC').Value < 0, 'D', 'C');
        End
        Else
          fltValDoc := fltValDoc + FieldByName('MCA_VALREC').AsFloat;

        Next;
      End;

      SetLength(arrBaiSinDeb, Length(arrBaiSinDeb) + 1);

      arrBaiSinDeb[Length(arrBaiSinDeb) - 1].fltValDoc := fltValDoc;
      arrBaiSinDeb[Length(arrBaiSinDeb) - 1].fltValTax := 0;
      arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strCodEmp := strCodEmp;
      arrBaiSinDeb[Length(arrBaiSinDeb) - 1].dtaDtaRec := dtaDtaRec;
      arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strPorBai := strPorBai;
      arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strCtaBai := strCtaBai;
      arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strForTax := strTaxaFo;
      arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strNumDoc := strNumDoc;

      If Not fEmptyStr(cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString) Then
      Begin
        If (Pos(cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString,strHisDoc) <= 0) Then
          strHisDoc := cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString + ' ' + strHisDoc;
      End;

      arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strHisDoc := IIF(fEmptyStr(strHisDoc),'', strHisDoc + ' - ')+ 'Canc./Ajuste Cartões - Emp. ' + strCodEmp;
      arrBaiSinDeb[Length(arrBaiSinDeb) - 1].intPagCon := intCtpCon;
      arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strTipAju := strTipAju;
      arrBaiSinDeb[Length(arrBaiSinDeb) - 1].strEventoCancelamentoAjuste := strEventoCancelamentoAjuste;
    End;

    Filter := strFilAnt;
  End;

end;

procedure TfrmBaixaCartoes.pCarregaArrBaiSinCar;
  Var
    strCodEmp: String;
    dtaDtaRec: TDateTime;

    fltValDoc,
    fltValTax,
    fltValAnt,
    LFreteMarketPlace,
    LAjusteMarketPlace,
    LCupomMarketPlace,
    LSubtrairFrete: Double;

    blnVerifi: Boolean;

    strPorBai,
    strCtaBai,
    strPorDeb,
    strCtaDeb,
    strTaxaPo,
    strTaxaCt,
    strTaxaFo,
    SEventoCredito,
    SEventoTaxa,
    strEvento,
    strCtaAnt,
    strFilAnt,

    LPlanoDeContasFrete,
    LPlanoDeCOntasAjuste,
    LPlanoDeContasCupom: String;

    intQtdCar: Integer;
begin

  Application.ProcessMessages;
  SetLength(arrBaiSinCar, 0);
  SetLength(FCTPDETSintetico, 0);

  cdsBaiCar.IndexFieldNames := IIF(blnBaiMan, 'MCA_CODEMP;MCA_DTAREC',
                               'MCA_CODEMP;MCA_DTAREC;CAR_PORBAI;CAR_CTABAI;CAR_PORTAX;CAR_CTATAX;CAR_FORTAX;'+
                              'CAR_PORBAD;CAR_CTABAD;CAR_EVEDEB;CAR_CTAANT;CAR_EVECRE;CAR_EVETAX');
  strFilAnt := cdsBaiCar.Filter;
  cdsBaiCar.Filter := 'MCA_MARDES=' + QuotedStr('M') + 'AND MCA_AJUSTE=' + QuotedStr('N') + ' AND NEGOCIACAO=''N'' ';
  cdsBaiCar.Filtered := True;

  If cdsBaiCar.IsEmpty Then
    Exit;

  cdsBaiCar.First;
  strCodEmp := cdsBaiCar.FieldByName('MCA_CODEMP').AsString;
  dtaDtaRec := IIF(blnBaiMan, dtaDtaDoc, cdsBaiCar.FieldByName('MCA_DTAREC').Value);
  strPorBai      := IIF(blnBaiMan, strPorCar, cdsBaiCar.FieldByName('CAR_PORBAI').AsString);
  strCtaBai      := IIF(blnBaiMan, strCtaCar, cdsBaiCar.FieldByName('CAR_CTABAI').AsString);
  strPorDeb      := IIF(blnBaiMan, strPorBad, cdsBaiCar.FieldByName('CAR_PORBAD').AsString);
  strCtaDeb      := IIF(blnBaiMan, strCtaBad, cdsBaiCar.FieldByName('CAR_CTABAD').AsString);
  strTaxaPo      := IIF(blnBaiMan, strPorTax, cdsBaiCar.FieldByName('CAR_PORTAX').AsString);
  strTaxaCt      := IIF(blnBaiMan, strCtaTax, cdsBaiCar.FieldByName('CAR_CTATAX').AsString);
  strTaxaFo      := IIF(blnBaiMan, strForTax, cdsBaiCar.FieldByName('CAR_FORTAX').AsString);
  SEventoCredito := IIF(blnBaiMan, strEventoCredito, cdsBaiCar.FieldByName('CAR_EVECRE').AsString);
  SEventoTaxa    := IIF(blnBaiMan, strEventoTaxa, cdsBaiCar.FieldByName('CAR_EVETAX').AsString);
  strEvento      := IIF(blnBaiMan, strEveDeb, cdsBaiCar.FieldByName('CAR_EVEDEB').AsString);
  strCtaAnt      := IIF(blnBaiMan, strCtaAnt, cdsBaiCar.FieldByName('CAR_CTAANT').AsString);
  fltValDoc      := 0;
  fltValTax      := 0;
  fltValAnt      := 0;
  intQtdCar      := 0;
  LFreteMarketPlace := 0;
  LAjusteMarketPlace := 0;
  LCupomMarketPlace := 0;
  LSubtrairFrete := 0;

  LPlanoDeContasFrete := IIF(blnBaiMan, EmptyStr, cdsBaiCar.FieldByName('CAR_CTAFRE').AsString);
  LPlanoDeContasAjuste := IIF(blnBaiMan, EmptyStr, cdsBaiCar.FieldByName('CAR_CTAAJU').AsString);
  LPlanoDeContasCupom := IIF(blnBaiMan, EmptyStr, cdsBaiCar.FieldByName('CAR_CTACUP').AsString);

  While Not cdsBaiCar.Eof Do
  Begin
    TBaixaCartoes.GeraRegistroCTPDetDeTaxaParaMarketPlace(FRegistroCTPDetFrete,
                                                          FRegistroCTPDetAjuste,
                                                          cdsBaiCar);

    If (blnBaiMan) Then
      blnVerifi := (cdsBaiCar.FieldByName('MCA_CODEMP').AsString <> strCodEmp) Or
                   (dtaDtaDoc <> dtaDtaRec)
    Else
      blnVerifi := (cdsBaiCar.FieldByName('MCA_CODEMP').AsString <> strCodEmp) Or
                   (cdsBaiCar.FieldByName('MCA_DTAREC').Value <> dtaDtaRec)    Or
                   (cdsBaiCar.FieldByName('CAR_PORBAI').AsString <> strPorBai) Or
                   (cdsBaiCar.FieldByName('CAR_CTABAI').AsString <> strCtaBai) Or
                   (cdsBaiCar.FieldByName('CAR_PORBAD').AsString <> strPorDeb) Or
                   (cdsBaiCar.FieldByName('CAR_CTABAD').AsString <> strCtaDeb) Or
                   (cdsBaiCar.FieldByName('CAR_PORTAX').AsString <> strTaxaPo) Or
                   (cdsBaiCar.FieldByName('CAR_CTATAX').AsString <> strTaxaCt) Or
                   (cdsBaiCar.FieldByName('CAR_FORTAX').AsString <> strTaxaFo) Or
                   (cdsBaiCar.FieldByName('CAR_EVECRE').AsString <> SEventoCredito) Or
                   (cdsBaiCar.FieldByName('CAR_EVETAX').AsString <> SEventoTaxa) Or
                   (cdsBaiCar.FieldByName('CAR_EVEDEB').AsString <> strEvento) Or
                   (cdsBaiCar.FieldByName('CAR_CTAANT').AsString <> strCtaAnt);

    If blnVerifi Then
    Begin
      SetLength(arrBaiSinCar, Length(arrBaiSinCar) + 1);

      arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValDoc        := fltValDoc + Abs(LCupomMarketPlace);
      arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValTax        := fltValTax;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strCodEmp        := strCodEmp;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].dtaDtaRec        := dtaDtaRec;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorBai        := strPorBai;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaBai        := strCtaBai;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strEventoCredito := SEventoCredito;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorBad        := strPorDeb;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaBad        := strCtaDeb;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorTax        := strTaxaPo;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strForTax        := strTaxaFo;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaTax        := strTaxaCt;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strEventoTaxa    := SEventoTaxa;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strEveDeb        := strEvento;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaAnt        := strCtaAnt;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValAnt        := fltValAnt;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].intQtdCar        := intQtdCar;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].FreteMarketPlace := Abs(LFreteMarketPlace);
      arrBaiSinCar[Length(arrBaiSinCar) - 1].AjusteMarketPlace := Abs(LAjusteMarketPlace);
      arrBaiSinCar[Length(arrBaiSinCar) - 1].CupomMarketPlace := Abs(LCupomMarketPlace);
      arrBaiSinCar[Length(arrBaiSinCar) - 1].SubtrairFrete := Abs(LSubtrairFrete);
      arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasFreteMkt := LPlanoDeContasFrete;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasAjusteMkt := LPlanoDeContasAjuste;
      arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasCupomMkt := LPlanoDeContasCupom;

      strCodEmp      := cdsBaiCar.FieldByName('MCA_CODEMP').AsString;
      dtaDtaRec      := IIF(blnBaiMan, dtaDtaDoc, cdsBaiCar.FieldByName('MCA_DTAREC').Value);
      fltValDoc      := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
      fltValTax      := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;
      strPorBai      := IIF(blnBaiMan, strPorCar, cdsBaiCar.FieldByName('CAR_PORBAI').AsString);
      strCtaBai      := IIF(blnBaiMan, strCtaCar, cdsBaiCar.FieldByName('CAR_CTABAI').AsString);
      strPorDeb      := IIF(blnBaiMan, strPorBad, cdsBaiCar.FieldByName('CAR_PORBAD').AsString);
      strCtaDeb      := IIF(blnBaiMan, strCtaBad, cdsBaiCar.FieldByName('CAR_CTABAD').AsString);
      strTaxaPo      := IIF(blnBaiMan, strPorTax, cdsBaiCar.FieldByName('CAR_PORTAX').AsString);
      strTaxaCt      := IIF(blnBaiMan, strCtaTax, cdsBaiCar.FieldByName('CAR_CTATAX').AsString);
      strTaxaFo      := IIF(blnBaiMan, strForTax, cdsBaiCar.FieldByName('CAR_FORTAX').AsString);
      SEventoCredito := IIF(blnBaiMan, strEventoCredito, cdsBaiCar.FieldByName('CAR_EVECRE').AsString);
      SEventoTaxa    := IIF(blnBaiMan, strEventoTaxa, cdsBaiCar.FieldByName('CAR_EVETAX').AsString);
      strEvento      := IIF(blnBaiMan, strEveDeb, cdsBaiCar.FieldByName('CAR_EVEDEB').AsString);
      strCtaAnt      := IIF(blnBaiMan, strCtaAnt, cdsBaiCar.FieldByName('CAR_CTAANT').AsString);
      fltValAnt      := cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat;
      LFreteMarketPlace := cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat;
      LAjusteMarketPlace := cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat;
      LCupomMarketPlace := cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat;
      LPlanoDeContasFrete := IIF(blnBaiMan, EmptyStr, cdsBaiCar.FieldByName('CAR_CTAFRE').AsString);
      LPlanoDeContasAjuste := IIF(blnBaiMan, EmptyStr, cdsBaiCar.FieldByName('CAR_CTAAJU').AsString);
      LPlanoDeContasCupom := IIF(blnBaiMan, EmptyStr, cdsBaiCar.FieldByName('CAR_CTACUP').AsString);
      LSubtrairFrete := cdsBaiCar.FieldByName('SUBTRAIR_FRETE').AsFloat;
      intQtdCar      := 1;
    End
    Else
    Begin
      fltValDoc := fltValDoc + cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
      fltValTax := fltValTax + cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;
      fltValAnt := fltValAnt + cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat;
      LFreteMarketPlace := LFreteMarketPlace + cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat;
      LAjusteMarketPlace := LAjusteMarketPlace + cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat;
      LCupomMarketPlace := LCupomMarketPlace + cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat;
      LSubtrairFrete := LSubtrairFrete + cdsBaiCar.FieldByName('SUBTRAIR_FRETE').AsFloat;

      Inc(intQtdCar);
    End;

    AdicionarRegistroCTPDetNoArraySintetico(FRegistroCTPDetFrete,
                                            FRegistroCTPDetAjuste,
                                            strTaxaCt,
                                            cdsBaiCar);

    cdsBaiCar.Next;
  End;

  SetLength(arrBaiSinCar, Length(arrBaiSinCar) + 1);

  arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValDoc        := fltValDoc + Abs(LCupomMarketPlace);
  arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValTax        := fltValTax;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strCodEmp        := strCodEmp;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].dtaDtaRec        := dtaDtaRec;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorBai        := strPorBai;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaBai        := strCtaBai;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorBad        := strPorDeb;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaBad        := strCtaDeb;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strPorTax        := strTaxaPo;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strForTax        := strTaxaFo;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaTax        := strTaxaCt;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strEventoCredito := SEventoCredito;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strEventoTaxa    := SEventoTaxa;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strEveDeb        := strEvento;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].strCtaAnt        := strCtaAnt;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].fltValAnt        := fltValAnt;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].intQtdCar        := intQtdCar;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].FreteMarketPlace := Abs(LFreteMarketPlace);
  arrBaiSinCar[Length(arrBaiSinCar) - 1].AjusteMarketPlace := Abs(LAjusteMarketPlace);
  arrBaiSinCar[Length(arrBaiSinCar) - 1].CupomMarketPlace := Abs(LCupomMarketPlace);
  arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasFreteMkt := LPlanoDeContasFrete;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasAjusteMkt := LPlanoDeContasAjuste;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].PlanoDeContasCupomMkt := LPlanoDeContasCupom;
  arrBaiSinCar[Length(arrBaiSinCar) - 1].SubtrairFrete := Abs(LSubtrairFrete);

  cdsBaiCar.Filter := strFilAnt;
end;

procedure TfrmBaixaCartoes.AbrirClientDataSet;
begin

  If Assigned(cdsBaiCar) Then
    FreeAndNil(cdsBaiCar);

  cdsBaiCar := CriarClientDataSet(qryBaiCar);
  cdsBaiCar.Close;
  pCriaAgrFields;

  cdsBaiCar.Open;
  cdsBaicar.AggregatesActive := True;
  cdsBaiCar.IndexFieldNames := 'MCA_NUMDUP;MCA_CODEMP';
  cdsBaiCar.First;

  dtsBaiCar := fCriaDataSource(cdsBaiCar);
  grdDuplicDados.DataController.DataSource := dtsBaiCar;
end;

procedure TfrmBaixaCartoes.AdicionarRegistroCTPDetNoArraySintetico(ARegistroCTPDetFrete,
                                                                   ARegistroCTPDetAjuste: TArrBaiSinCar;
                                                                   APlanoDeContas: String;
                                                                   ARegistros: TUniClientDataset);
  Var
    LGravarFrete,
    LGravarAjuste: Boolean;

    LContador,
    LPosicaoFrete,
    LPosicaoAjuste: Integer;

    LChaveComparacao,
    LChaveArrayOriginal: String;
begin
  If blnBaiMan Then
    Exit;

  If Not TBaixaCartoes.ValidaGravacaoCTPDet(LGravarFrete, LGravarAjuste, APlanoDeContas, FRegistroCTPDetFrete, FRegistroCTPDetAjuste) Then
    Exit;

  LChaveArrayOriginal := Concat(ARegistros.FieldByName('MCA_CODEMP').AsString,
                                ARegistros.FieldByName('MCA_DTAREC').AsString,
                                ARegistros.FieldByName('CAR_PORBAI').AsString,
                                ARegistros.FieldByName('CAR_CTABAI').AsString,
                                ARegistros.FieldByName('CAR_PORBAD').AsString,
                                ARegistros.FieldByName('CAR_CTABAD').AsString,
                                ARegistros.FieldByName('CAR_PORTAX').AsString,
                                ARegistros.FieldByName('CAR_CTATAX').AsString,
                                ARegistros.FieldByName('CAR_FORTAX').AsString,
                                ARegistros.FieldByName('CAR_EVECRE').AsString,
                                ARegistros.FieldByName('CAR_EVETAX').AsString,
                                ARegistros.FieldByName('CAR_EVEDEB').AsString,
                                ARegistros.FieldByName('CAR_CTAANT').AsString);


  LPosicaoFrete := -1;
  LPosicaoAjuste := -1;
  For LContador := 0 To Length(FCTPDetSintetico) - 1 Do
  Begin
    LChaveComparacao := Concat(FCTPDetSintetico[LContador].strCodEmp,
                               DateTimeToStr(FCTPDetSintetico[LContador].dtaDtaRec),
                               FCTPDetSintetico[LContador].strPorBai,
                               FCTPDetSintetico[LContador].strCtaBai,
                               FCTPDetSintetico[LContador].strPorBad,
                               FCTPDetSintetico[LContador].strCtaBad,
                               FCTPDetSintetico[LContador].strPorTax,
                               FCTPDetSintetico[LContador].strCtaTax,
                               FCTPDetSintetico[LContador].strForTax,
                               FCTPDetSintetico[LContador].strEventoCredito,
                               FCTPDetSintetico[LContador].strEventoTaxa,
                               FCTPDetSintetico[LContador].strEveDeb,
                               FCTPDetSintetico[LContador].strCtaAnt);

    If LChaveComparacao <> LChaveArrayOriginal Then
      Continue;

    If LGravarFrete Then
      LPosicaoFrete := IIF(ARegistroCTPDetFrete.strCtaTax = FCTPDetSintetico[LContador].PlanoDeContasParaCTPDet,
                           LContador,
                           LPosicaoFrete);

    If LGravarAjuste Then
      LPosicaoAjuste := IIF(ARegistroCTPDetAjuste.strCtaTax = FCTPDetSintetico[LContador].PlanoDeContasParaCTPDet,
                            LContador,
                            LPosicaoAjuste);
  End;

  If LGravarFrete Then
  Begin
    If LPosicaoFrete = -1 THen
    Begin
      LPosicaoFrete := Length(FCTPDetSintetico);

      SetLength(FCTPDetSintetico, Length(FCTPDetSintetico) + 1);

      FCTPDetSintetico[LPosicaoFrete].strCodEmp := ARegistros.FieldByName('MCA_CODEMP').AsString;
      FCTPDetSintetico[LPosicaoFrete].dtaDtaRec := ARegistros.FieldByName('MCA_DTAREC').Value;
      FCTPDetSintetico[LPosicaoFrete].strPorBai := ARegistros.FieldByName('CAR_PORBAI').AsString;
      FCTPDetSintetico[LPosicaoFrete].strCtaBai := ARegistros.FieldByName('CAR_CTABAI').AsString;
      FCTPDetSintetico[LPosicaoFrete].strPorBad := ARegistros.FieldByName('CAR_PORBAD').AsString;
      FCTPDetSintetico[LPosicaoFrete].strCtaBad := ARegistros.FieldByName('CAR_CTABAD').AsString;
      FCTPDetSintetico[LPosicaoFrete].strPorTax := ARegistros.FieldByName('CAR_PORTAX').AsString;
      FCTPDetSintetico[LPosicaoFrete].strCtaTax := ARegistros.FieldByName('CAR_CTATAX').AsString;
      FCTPDetSintetico[LPosicaoFrete].strForTax := ARegistros.FieldByName('CAR_FORTAX').AsString;
      FCTPDetSintetico[LPosicaoFrete].strEventoCredito := ARegistros.FieldByName('CAR_EVECRE').AsString;
      FCTPDetSintetico[LPosicaoFrete].strEventoTaxa := ARegistros.FieldByName('CAR_EVETAX').AsString;
      FCTPDetSintetico[LPosicaoFrete].strEveDeb := ARegistros.FieldByName('CAR_EVEDEB').AsString;
      FCTPDetSintetico[LPosicaoFrete].strCtaAnt :=ARegistros.FieldByName('CAR_CTAANT').AsString;

      FCTPDetSintetico[LPosicaoFrete].PlanoDeContasParaCTPDet := ARegistroCTPDetFrete.strCtaTax;

      FCTPDetSintetico[LPosicaoFrete].fltValTax := 0.00;
    End;

    FCTPDetSintetico[LPosicaoFrete].fltValTax := FCTPDetSintetico[LPosicaoFrete].fltValTax +
                                                 fFormataFloat(ARegistroCTPDetFrete.fltValTax, 2);
  End;

  If LGravarAjuste Then
  Begin
    If ARegistroCTPDetAjuste.strCtaTax = ARegistroCTPDetFrete.strCtaTax Then
      LPosicaoAjuste := LPosicaoFrete;

    If LPosicaoAjuste = -1 THen
    Begin
      LPosicaoAjuste := Length(FCTPDetSintetico);

      SetLength(FCTPDetSintetico, Length(FCTPDetSintetico) + 1);

      FCTPDetSintetico[LPosicaoAjuste].strCodEmp := ARegistros.FieldByName('MCA_CODEMP').AsString;
      FCTPDetSintetico[LPosicaoAjuste].dtaDtaRec := ARegistros.FieldByName('MCA_DTAREC').Value;
      FCTPDetSintetico[LPosicaoAjuste].strPorBai := ARegistros.FieldByName('CAR_PORBAI').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strCtaBai := ARegistros.FieldByName('CAR_CTABAI').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strPorBad := ARegistros.FieldByName('CAR_PORBAD').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strCtaBad := ARegistros.FieldByName('CAR_CTABAD').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strPorTax := ARegistros.FieldByName('CAR_PORTAX').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strCtaTax := ARegistros.FieldByName('CAR_CTATAX').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strForTax := ARegistros.FieldByName('CAR_FORTAX').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strEventoCredito := ARegistros.FieldByName('CAR_EVECRE').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strEventoTaxa := ARegistros.FieldByName('CAR_EVETAX').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strEveDeb := ARegistros.FieldByName('CAR_EVEDEB').AsString;
      FCTPDetSintetico[LPosicaoAjuste].strCtaAnt :=ARegistros.FieldByName('CAR_CTAANT').AsString;

      FCTPDetSintetico[LPosicaoAjuste].PlanoDeContasParaCTPDet := ARegistroCTPDetAjuste.strCtaTax;
    End;

    FCTPDetSintetico[LPosicaoAjuste].fltValTax := FCTPDetSintetico[LPosicaoAjuste].fltValTax +
                                                  fFormataFloat(ARegistroCTPDetAjuste.fltValTax, 2);
  End;
end;

procedure TfrmBaixaCartoes.pCarregaBandeira;
begin
  pPesquisaCadBan(qryConBan, qryConBan, edtCodBan.Text);
  With qryConBan Do
  Begin
    edtDesBan.Text := qryConBan.FieldByName('BAN_NOMBAN').AsString;
  End;
end;

procedure TfrmBaixaCartoes.pCarregaCartao;
begin
  pPesquisaCadCar(qryConCar2, qryConCar2, edtCodCar.Text);
  With qryConCar2 Do
  Begin
    edtDesCar.Text := qryConCar2.FieldByName('CAR_DESCAR').AsString;
  End
end;

procedure TfrmBaixaCartoes.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, edtCodEmp.Text);
  With qryConEmp Do
  Begin
    edtDesEmp.Text := qryConEmp.FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmBaixaCartoes.pMarcar(fltValRec: Double; dtaDtaRec: TDate;blnMarcar:Boolean);
begin
  If blnMarcar Then
  Begin
    cdsBaiCar.Edit;
    cdsBaiCar.FieldByName('MCA_MARDES').AsString   := 'M';
    cdsBaiCar.FieldByName('MCA_VALREC').AsFloat    := fltValRec;
    cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime := dtaDtaRec;
    cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat    := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat -
                                                      cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;
    cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat    := fltValRec;

    cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat    := cdsBaiCar.FieldByName('TAXA_ADM_ORIGINAL').AsFloat;
    If (fFormataFloat(fltValRec, 2) <> fFormataFloat(cdsBaiCar.FieldByName('MCA_VALORI').AsFloat, 2)) Or
       (fFormataFloat(cdsBaiCar.FieldByName('MCA_FREMKT').AsFloat + cdsBaiCar.FieldByName('MCA_CUPMKT').AsFloat, 2) > 0) Then
      cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat    := IIF(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat <> 0,
                                                            (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat / cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100,
                                                            0.000000);

    cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat;
    cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat  := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
    cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat  := 1;
    cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat  := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;
    cdsBaiCar.Post;
  End
  {*****************************************}
  {* DESMARCANDO DUPLICATAS                *}
  {**************************************LE*}
  Else
  Begin
    cdsBaiCar.Edit;
    cdsBaiCar.FieldByName('MCA_MARDES').AsString := 'D';
    cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := 0;
    cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat  := 0;
    cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat  := 0;
    cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat  := 0;
    cdsBaiCar.Post;
  End;

end;

procedure TfrmBaixaCartoes.pPreencheVetor;
begin
  setLength(arrBusca,0);
  Application.ProcessMessages;
  setLength(arrBusca,1);
  arrBusca[0].NumCCD := frmBaixaCtcBusca.edtNumDup.Text;
  if Not fEmptyStr(frmBaixaCtcBusca.edtNumNsu.Text) then
      arrBusca[0].NumNsu := fPadL( frmBaixaCtcBusca.edtNumNsu.Text, 14, '0')
  else
      arrBusca[0].NumNsu := '';
  arrBusca[0].DtaCad := frmBaixaCtcBusca.mskDtaCad.Text;
  arrBusca[0].DtaVen := frmBaixaCtcBusca.mskDtaVen.Text;
  arrBusca[0].Valor  := frmBaixaCtcBusca.edtValor.Text;
  arrBusca[0].Nome   := trim(frmBaixaCtcBusca.edtNomeCliente.Text);
  arrBusca[0].CpfCgc := fTiraCaracEspeciaisPonto(frmBaixaCtcBusca.mskCgcCpf.Text);

end;

procedure TfrmBaixaCartoes.FormShow(Sender: TObject);
begin
  inherited;
  pFormShowConciliacaoMercadoLivre;

  pVisualizaNroPedido;

  dtaDtaPag := 0;
  blnAcesso := fVerificaAcessoSistema('CARBAITODOS');

  If Not blnConcil Then
    pCriaAgrFields;

  pnlMarketPlace.Left := 0;

  blnBaiMan := (Not blnConcil) And (Not blnConRed);
  If blnBaiMan Then
  Begin
    Label14.Top := Label14.Top - pnlMarketPlace.Height;
    edtHist01.Top := edtHist01.Top - pnlMarketPlace.Height;
    edtHist02.Top := edtHist02.Top - pnlMarketPlace.Height;
  End;

  If (blnConcil) Or (blnConRed) Then
    pAbreConciliacao;

  HabilitaPreviaCartoesConc;
end;

procedure TfrmBaixaCartoes.edtCodBanKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE BANDEIRAS DE CARTOES *}
  {**************************************DP*}
  If fPesqCartaoBandeira(Self, edtCodBan, edtDesBan, Nil, Key, arrBandeira, False) Then
  Begin
    fValidaCampos(edtCodBan,False);
    self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmBaixaCartoes.pCriaAgrFields;
begin
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VALSTA';
    FieldName     := 'TOT_VALSTA';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_VALSTA)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VALTOT';
    FieldName     := 'TOT_VALTOT';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_VALTOT)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_SELSTA';
    FieldName     := 'TOT_SELSTA';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_SELSTA)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_SELTOT';
    FieldName     := 'TOT_SELTOT';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_SELTOT)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_SELQTD';
    FieldName     := 'TOT_SELQTD';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_SELQTD)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_VALTAX';
    FieldName     := 'TOT_VALTAX';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_TOTTAX)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_AJUTOT';
    FieldName     := 'TOT_AJUTOT';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_AJUTOT)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
  With TAggregateField.Create(Self) Do
  Begin
    Name          := 'TOT_AJUSEL';
    FieldName     := 'TOT_AJUSEL';
    DataSet       := cdsBaiCar;
    Expression    := 'SUM(MCA_AJUSEL)';
    DisplayFormat := ',0.00';
    Active        := True;
  End;
end;

function TfrmBaixaCartoes.fMarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
Var
  prcScroll: TprcScroll;
  dtaMarcarTodas:TDateTime;
  blnNaoMar: Boolean;
  fltValorMarcado: Double;
Begin
  {*******************************************}
  {* MARCANDO DUPLICATAS                    *}
  {****************************************LE}
  blnNaoMar := False;
  dtaMarcarTodas := VS_Date;
  fltValorMarcado:= 0;
  If fCfgSis('CTC_AS') = 'A' Then
  Begin
    If (Not ffrmData(dtaMarcarTodas, 'Data de Baixa', 'Data de Baixa')) Then
    Begin
      Result := False;
      Exit;
    End;
  End;

  With cdsBaiCar Do
  Begin

    Try
      pDisableControls(cdsBaiCar, prcScroll);
      AggregatesActive := False;
      First;

      pgbStatus.Position := 0;
      pgbStatus.Properties.Max := cdsBaiCar.RecordCount;

      While Not Eof Do
      Begin
        pStepStatusGravacao(pgbStatus);
        Try
          If (FieldByName('MCA_MARDES').AsString <> 'M') And
          (Not fCartaoBloqueado(cdsBaiCar)) Then
          Begin
            If FieldByName('MCA_DTACAD').Value <= dtaMarcarTodas Then
            begin
              if not fValidaValorBaixa(fltValorMarcado) then
              begin
                Next;
                Continue;
              end;

              fltValorMarcado := fltValorMarcado + FieldByName('MCA_VALSTA').AsFloat;

              pMarcar(IIF((FieldByName('MCA_VALTOT').AsFloat = FieldByName('MCA_VALSTA').AsFloat) AND
                           (FieldByName('MCA_PERCAR').AsFloat <> 0), FieldByName('MCA_VALSTA').AsFloat - (FieldByName('MCA_VALSTA').AsFloat * (FieldByName('MCA_PERCAR').AsFloat / 100)), FieldByName('MCA_VALTOT').AsFloat),
                           dtaMarcarTodas,True);
            end
            Else
              blnNaoMar := True;
          End;
        Except
          On E: Exception Do
          Begin
            fMensagem('','Ocorreu um erro ao Marcar o Registro para Baixa !' + #13 + E.Message,['&OK']);
            Break;
          End;
        End;
        Next;
      End;

      If fCartaoBloqueado(cdsBaiCar) Then
      Begin
        If FLiberacaoTransferencia Then
          pMensagemOk('Cartões recebidos pelo Caixa que ainda não foram transferidos ou a transferência não foi liberada, não podem ser baixados!')
        Else
          pMensagemOk('Cartões recebidos pelo Caixa que ainda não foram transferidos não podem ser baixados!');
      End;

      If blnNaoMar Then
        pMensagemOK('Alguns cartões não foram marcados pois a data do pagamento é inferior a data do cadastro. Verifique!');

    Finally
      First;
      pEnableControls(cdsBaiCar, prcScroll);

    End;
  End;

  cdsBaiCar.AggregatesActive := True;
  TfrmGravando.fExecutarModal(pAtualizaTemporaria,'Aguarde... Atualizando Cartões.','');
  Result := True;

End;

function TfrmBaixaCartoes.fDesmarcarTodas(pgbStatus: TcxProgressBar = Nil): Boolean;
Var
    prcScroll: TprcScroll;
begin

  {*******************************************}
  {* DESMARCANDO DUPLICATAS                 *}
  {****************************************LE}
  With cdsBaiCar Do
  Begin

    Try
      pDisableControls(cdsBaiCar, prcScroll);
      AggregatesActive := False;

      Filtered := False;
      Filter   := 'MCA_MARDES = ' + QuotedStr('M');
      Filtered := True;
      First;

      pgbStatus.Position := 0;
      pgbStatus.Properties.Max :=  cdsBaiCar.RecordCount;

      While Not IsEmpty Do
      Begin
        Try
          pMarcar(0.0,VS_DATE,False);
          pStepStatusGravacao(pgbStatus);
        Except
          On E: Exception Do
          Begin
            fMensagem('','Ocorreu um erro ao Desmarcar o Registro para Baixa !' + #13 + E.Message,['&OK']);
            Break;
          End;
        End;
        Next;
      End;

    Finally
      Filter   := '';
      Filtered := False;
      First;
    End;

  End;

  cdsBaiCar.AggregatesActive := True;
  TfrmGravando.fExecutarModal(pAtualizaTemporaria,'Aguarde... Atualizando Cartões.','');
  pEnableControls(cdsBaiCar, prcScroll);
  Result := True;
End;

procedure TfrmBaixaCartoes.BtnMarcarTodasClick(Sender: TObject);
begin
  inherited;
  If Not TBitBtnLocked(Sender).Visible Then
    Exit;

  If (Not cdsBaiCar.Active) Or (cdsBaiCar.IsEmpty) Then
  Begin
    fMensagem('', 'É necessário ter registros para marcar!', ['&Ok']);
    Exit;
  End;

  If (fMensagem('', 'Confirma selecionar todos os cartões?', ['&Sim', '&Não']) = 2) Then
    Exit;

  pManipulaPanels(False);
  pCriarFormularios(TfrmGravando,frmGravando);
  frmGravando.fExecutarAcao := fMarcarTodas;
  frmGravando.lblGravando.Caption := 'Aguarde... Marcando Cartões.';
  frmGravando.ShowModal;
  pFreeAndNil(frmGravando);
  pManipulaPanels(True);

end;

function TfrmBaixaCartoes.fGravaCartoesSin(pgbStatus: TcxProgressBar = Nil) : Boolean;
  Var
    blnConfirma,
    blnCadPag    : Boolean;
    strNumDup    : String;
    intCont      : Integer;
    cdsAux       : TUniClientDataSet;
    objSequencias: TSequenciaisBaixaCartao;

    LValorTotalTaxa,
    LValorBruto: Double;

    LListaBanMca: TListaBanMCA;

    LSeqLanFrete,
    LSeqLanAjuste,
    LSeqLanCupom: String;
begin

  Application.ProcessMessages;
  strSeqLan    := '';
  strSeqLanTax := '';
  strSeqLanCre := '';
  strSeqLanAnt := '';
  strNumDup    := '';
  blnConfirma := True;

  cdsAux := CriarClientDataSet(cdsBaiCar);

  cdsAux.DisableControls;
  cdsAux.Filtered := False;
  cdsAux.Filter   := 'MCA_MARDES = ' + QuotedStr('M') + ' AND MCA_AJUSTE = ' + QuotedStr('N');
  cdsAux.Filtered := True;

  cdsAux.First;

  Try
    With cdsAux Do
    Begin

      Application.ProcessMessages;
      pgbStatus.Position := 0;

      fStartTransaction;
      intCtpCon := fRetCtpCon;
      fCommit;

      pCarregaArrBaiSinCar;
      If Not blnBaiMan Then
        pCarregaArrAjustes;

      pgbStatus.Properties.Max := Length(arrBaiSinCar);

      objSequencias := TBaixaCartoes.RetornaSequenciaisParaBaixaSintetica(arrBaiSinCar,
                                                                          cdsAux,
                                                                          blnBaiMan,
                                                                          Not fEmptyStr(strPorBad),
                                                                          FBaixarTaxasAnaliticoMkt,
                                                                          Length(arrBaiSinDeb));
      objSequencias.SequencialControleBaixaPagar := intCtpCon;
      objSequencias.NumeroDocumentoBaixa := strNumDoc;

      fStartTransaction;

      {************************************}
      {* GRAVA OS LANÇAMENTOS DOS AJUSTES *}
      {*********************************AJ*}
      If (Not blnBaiMan) Then
      Begin
        If (Length(arrBaiSinDeb) > 0) Then
        Begin
          TBaixaCartoes.GravaMovBanAjustes(arrBaiSinDeb, objSequencias.intSeqLan, objSequencias.intContadorAutIncMovBan);
          TBaixaCartoes.GravaCadPagAjustes(arrBaiSinDeb, objSequencias.intSequencialCadPag, objSequencias.intContadorAutIncCadPag);

          Inc64(objSequencias.intSeqLan, Length(arrBaiSinDeb));
          Inc64(objSequencias.intSequencialCadPag, Length(arrBaiSinDeb));
          Inc64(objSequencias.intContadorAutIncMovBan, Length(arrBaiSinDeb));
          Inc64(objSequencias.intContadorAutIncCadPag, Length(arrBaiSinDeb));
        End;

        pCarregaArrayNegociacao;
        If Length(FArrayNegociacao) > 0 Then
        Begin
          TBaixaCartoes.GravaMovBanAjustes(FArrayNegociacao);
          TBaixaCartoes.GravaCadPagAjustes(FArrayNegociacao);
        End;
      End;

      For intCont := 0 To Length(arrBaiSinCar) - 1 Do
      Begin
        If Not blnConfirma Then
          Break;

        If Not blnBaiMan Then
        Begin
          strPorCar        := arrBaiSinCar[intCont].strPorBai;
          strCtaCar        := arrBaiSinCar[intCont].strCtaBai;
          strPorBad        := arrBaiSinCar[intCont].strPorBad;
          strCtaBad        := arrBaiSinCar[intCont].strCtaBad;
          strPorTax        := arrBaiSinCar[intCont].strPorTax;
          strCtaTax        := arrBaiSinCar[intCont].strCtaTax;
          strForTax        := arrBaiSinCar[intCont].strForTax;
          strEventoCredito := arrBaiSinCar[intCont].strEventoCredito;
          strEventoTaxa    := arrBaiSinCar[intCont].strEventoTaxa;
          strEveDeb        := arrBaiSinCar[intCont].strEveDeb;
          strCtaAnt        := arrBaiSinCar[intCont].strCtaAnt;
        End;

       Inc64(objSequencias.intContadorAutIncBanMca,
             fAdicionaCartoesPorEmpresa(arrBaiSinCar[intCont].strCodEmp,
                                        'VALSTA',
                                        LListaBanMca,
                                        IIF((blnConRed) Or (blnConcil), arrBaiSinCar[intCont].dtaDtaRec, dtaDtaDoc),
                                        strPorCar,
                                        strCtaCar,
                                        strPorBad,
                                        strCtaBad,
                                        strPorTax,
                                        strCtaTax,
                                        strForTax,
                                        strEventoCredito,
                                        strEventoTaxa,
                                        strEveDeb,
                                        strCtaAnt,
                                        objSequencias.intContadorAutIncBanMca));

        LValorBruto := arrBaiSinCar[intCont].fltValDoc;
        If FBaixarTaxasAnaliticoMkt Then
          LValorBruto := fFormataFloat(LValorBruto -
                                       arrBaiSinCar[intCont].CupomMarketPlace, 2);

        {*****************************************}
        {* GRAVA MOVBAN DO CARTÃO                *}
        {**************************************MV*}
        strSeqLanCre  := fGravaMovBan(strCtaCar,                      // Centro de Custo
                                      strPorCar,                      // Portador
                                      strLoginUsuarioLogado,          // Operador
                                      IIF(blnBaiMan, dtaDtaDoc, arrBaiSinCar[intCont].dtaDtaRec),// Data do Lançamento
                                      fTime(),                        // Hora do Lançamento
                                      strNumDoc,                      // Documento
                                      'C',                            // Credito / Debito
                                      VS_strCodEmp,                   // Empresa
                                      LValorBruto,                    // Valor Documento
                                      strHisDoc + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp, // Historico 1
                                      '',                             // Historico 2
                                      '',                             // Cliente
                                      '',                             // Fornecedor
                                      '',                             // Numero da Duplicata
                                      0,                              // Sequencial Duplicata
                                      '',                             // Parcela da Duplicata
                                      arrBaiSinCar[intCont].strCodEmp,// Empresa da Duplicata
                                      '',                             // Série
                                      //'',                           // Sequencial de Lançamento
                                      strEventoCredito,               // Código do Evento
                                      '',                             // Documento da Baixa
                                      Nil,                            // Log Bancário
                                      0,
                                      intCtpCon,
                                      '',
                                      '',
                                      objSequencias.intSeqLan.ToString,
                                      fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_strCodEmp),
                                      '',
                                      '',
                                      1,
                                      True,
                                      LListaBanMca);

        Inc64(objSequencias.intSeqLan);
        Inc64(objSequencias.intContadorAutIncMovBan);

        blnConfirma := (Not fEmptyStr(strSeqLanCre));
        arrBaiSinCar[intCont].strSeqLanCre := strSeqLanCre;

        If (Not fEmptyStr(strSeqLanCre)) And (Not fEmptyStr(strPorBad)) Then
        Begin
          if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
          begin
            SetLength(arrSeqLanLoc, Length(arrSeqLanLoc) + 1);
            arrSeqLanLoc[Length(arrSeqLanLoc)-1] := strSeqLanCre;
          end;

          Inc64(objSequencias.intContadorAutIncBanMca,
                fAdicionaCartoesPorEmpresa(arrBaiSinCar[intCont].strCodEmp,
                                           'VALSTA',
                                           LListaBanMca,
                                           IIF((blnConRed) Or (blnConcil), arrBaiSinCar[intCont].dtaDtaRec, dtaDtaDoc),
                                           strPorCar,
                                           strCtaCar,
                                           strPorBad,
                                           strCtaBad,
                                           strPorTax,
                                           strCtaTax,
                                           strForTax,
                                           strEventoCredito,
                                           strEventoTaxa,
                                           strEveDeb,
                                           strCtaAnt,
                                           objSequencias.intContadorAutIncBanMca));

          {*****************************************}
          {* GRAVA MOVBAN DO CARTÃO (DEBITO)       *}
          {**************************************MV*}
          strSeqLan   := fGravaMovBan(strCtaBad,                      // Centro de Custo
                                      strPorBad,                      // Portador
                                      strLoginUsuarioLogado,          // Operador
                                      IIF(blnBaiMan, dtaDtaDoc, arrBaiSinCar[intCont].dtaDtaRec),// Data do Lançamento
                                      fTime(),                        // Hora do Lançamento
                                      strNumDoc,                      // Documento
                                      'D',                            // Credito / Debito
                                      VS_strCodEmp,                   // Empresa
                                      arrBaiSinCar[intCont].fltValDoc,// Valor Documento
                                      strHisDoc + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp, // Historico 1
                                      '',                             // Historico 2
                                      '',                             // Cliente
                                      '',                             // Fornecedor
                                      '',                             // Numero da Duplicata
                                      0,                              // Sequencial Duplicata
                                      '',                             // Parcela da Duplicata
                                      arrBaiSinCar[intCont].strCodEmp,// Empresa da Duplicata
                                      '',                             // Série
                                      //'',                           // Sequencial de Lançamento
                                      strEveDeb,                      // Código do Evento
                                      '',                             // Documento da Baixa
                                      Nil,                            // Log Bancário
                                      0,
                                      intCtpCon,
                                      '',
                                      '',
                                      objSequencias.intSeqLan.ToString,
                                      fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_strCodEmp),
                                      '',
                                      '',
                                      1,
                                      True,
                                      LListaBanMca);

          Inc64(objSequencias.intSeqLan);
          Inc64(objSequencias.intContadorAutIncMovBan);

          blnConfirma := (Not fEmptyStr(strSeqLan));
          arrBaiSinCar[intCont].strSeqLanDeb := strSeqLan;
        End;

        {************************************}
        {* SÓ GRAVA TAXA SE VALREC < VALSTA *}
        {*********************************JU*}

        If (arrBaiSinCar[intCont].fltValTax > 0) And (blnConfirma) Then
        Begin
          Inc64(objSequencias.intContadorAutIncBanMca,
                fAdicionaCartoesPorEmpresa(arrBaiSinCar[intCont].strCodEmp,
                                           'VALTAX',
                                           LListaBanMca,
                                           IIF((blnConRed) Or (blnConcil), arrBaiSinCar[intCont].dtaDtaRec, dtaDtaDoc),
                                           strPorCar,
                                           strCtaCar,
                                           strPorBad,
                                           strCtaBad,
                                           strPorTax,
                                           strCtaTax,
                                           strForTax,
                                           strEventoCredito,
                                           strEventoTaxa,
                                           strEveDeb,
                                           strCtaAnt,
                                           objSequencias.intContadorAutIncBanMca));

          LValorTotalTaxa := fFormataFloat(arrBaiSinCar[intCont].fltValTax -
                                           arrBaiSinCar[intCont].fltValAnt, 2);

          If Not FBaixarTaxasAnaliticoMkt Then
            LValorTotalTaxa := LValorTotalTaxa +
                               fFormataFloat(Abs(arrBaiSinCar[intCont].FreteMarketPlace) +
                                             Abs(arrBaiSinCar[intCont].AjusteMarketPlace), 2);

          {*****************************************}
          {* GRAVA MOVBAN DA TAXA                  *}
          {**************************************MV*}
          strSeqLanTax := fGravaMovBan(strCtaTax,                      // Centro de Custo
                                       strPorTax,                      // Portador
                                       strLoginUsuarioLogado,          // Operador
                                       IIF(blnBaiMan, dtaDtaDoc, arrBaiSinCar[intCont].dtaDtaRec),// Data do Lançamento
                                       fTime(),                        // Hora do Lançamento
                                       strNumDoc,                      // Documento
                                       'D',                            // Credito / Debito
                                       VS_strCodEmp,                   // Empresa
                                       LValorTotalTaxa,                // Valor Documento
                                       strHisDoc + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp, // Historico 1
                                       '',                             // Historico 2
                                       '',                             // Cliente
                                       strForTax,                      // Fornecedor
                                       '',                             // Numero da Duplicata
                                       0,                              // Sequencial Duplicata
                                       '',                             // Parcela da Duplicata
                                       arrBaiSinCar[intCont].strCodEmp,// Empresa da Duplicata
                                       '',                             // Série
                                       //'',                           // Sequencial de Lançamento
                                       strEventoTaxa,                  // Código do Evento
                                       '',                             // Documento da Baixa
                                       Nil,                            // Log Bancário
                                       0,
                                       intCtpCon,
                                       '',
                                       '',
                                       objSequencias.intSeqLan.ToString,
                                       fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_strCodEmp),
                                       '',
                                       '',
                                       1,
                                       True,
                                       LListaBanMca);

          Inc64(objSequencias.intSeqLan);
          Inc64(objSequencias.intContadorAutIncMovBan);

          blnConfirma := (Not fEmptyStr(strSeqLanTax));
          arrBaiSinCar[intCont].strSeqLanTax := strSeqLanTax;

          {************************}
          {* GRAVA CADPAG DA TAXA *}
          {*********************AF*}
          If (blnConfirma) Then
          Begin
            if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
            begin
              SetLength(arrSeqLanLoc, Length(arrSeqLanLoc) + 1);
              arrSeqLanLoc[Length(arrSeqLanLoc)-1] := strSeqLanTax;
            end;

            strNumDup := 'G' + fStrZero(objSequencias.intSequencialCadPag.ToString, 11);

            blnCadPag :=  fGravaCadPag('frmBaixaCartoes',
                                       'INCLUSAO TAXA - CARTOES BX_SIN',
                                       strForTax,
                                       strNumDup,
                                       'A',
                                       arrBaiSinCar[intCont].strCodEmp,
                                       strCtaTax,
                                       'CRT',
                                       0,
                                       IIF(blnBaiMan, dtaDtaDoc, arrBaiSinCar[intCont].dtaDtaRec),
                                       IIF(blnBaiMan, dtaDtaDoc, arrBaiSinCar[intCont].dtaDtaRec),
                                       0,
                                       LValorTotalTaxa,
                                       'N',
                                       'N',
                                       'N',
                                       strHisDoc + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp,
                                       '',
                                       strHisDoc + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp,
                                       strPorTax,
                                       strCtaTax,
                                       strSeqLanTax,
                                       strLoginUsuarioLogado,
                                       IIF(blnBaiMan, dtaDtaDoc, arrBaiSinCar[intCont].dtaDtaRec),
                                       LValorTotalTaxa,
                                       0,
                                       0,
                                       VS_strCodEmp,
                                       strEventoTaxa,
                                       '',
                                       strPorTax,
                                       strNumDoc,
                                       0.0,
                                       0.0,
                                       intCtpCon,
                                       False,
                                       0,
                                       '',
                                       0,
                                       '',
                                       '',
                                       '',
                                       '',
                                       fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_strCodEmp),
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
                                       LValorTotalTaxa,
                                       0,
                                       0,
                                       0,
                                       '',
                                       0,
                                       0,
                                       '',
                                       '',
                                       '',
                                       '',
                                       '',
                                       '0',
                                       '',
                                       '',
                                       fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_strCodEmp));

            Inc64(objSequencias.intContadorAutIncCadPag);
            Inc64(objSequencias.intContadorAutIncLogCtp);
            Inc64(objSequencias.intSequencialCadPag);

            blnConfirma := blnCadPag;

            If blnConfirma Then
              TBaixaCartoes.GravaCTPDetDeTaxaParaMarketPlaceSintetico(strNumDup,
                                                                      strForTax,
                                                                      arrBaiSinCar[intCont].strCodEmp,
                                                                      'CRT',
                                                                      arrBaiSinCar[intCont],
                                                                      FCTPDetSintetico);
          End;
        End;

        {*********************************}
        {* GRAVA A TAXA DE ANTECIPAÇÃO   *}
        {******************************AJ*}
        If (arrBaiSinCar[intCont].fltValAnt > 0) And (blnConfirma) Then
        Begin
          Inc64(objSequencias.intContadorAutIncBanMca,
                fAdicionaCartoesPorEmpresa(arrBaiSinCar[intCont].strCodEmp,
                                           'VALSTA',
                                           LListaBanMca,
                                           IIF((blnConRed) Or (blnConcil), arrBaiSinCar[intCont].dtaDtaRec, dtaDtaDoc),
                                           strPorCar,
                                           strCtaCar,
                                           strPorBad,
                                           strCtaBad,
                                           strPorTax,
                                           strCtaTax,
                                           strForTax,
                                           strEventoCredito,
                                           strEventoTaxa,
                                           strEveDeb,
                                           strCtaAnt,
                                           objSequencias.intContadorAutIncBanMca));

          {***************************************}
          {* GRAVA MOVBAN DA TAXA DE ANTECIPAÇÃO *}
          {************************************AJ*}
          strSeqLanAnt := fGravaMovBan(strCtaAnt,                      // Centro de Custo
                                       strPorTax,                      // Portador
                                       strLoginUsuarioLogado,          // Operador
                                       IIF(blnBaiMan, dtaDtaDoc, arrBaiSinCar[intCont].dtaDtaRec),// Data do Lançamento
                                       fTime(),                        // Hora do Lançamento
                                       strNumDoc,                      // Documento
                                       'D',                            // Credito / Debito
                                       VS_strCodEmp,                   // Empresa
                                       arrBaiSinCar[intCont].fltValAnt,// Valor Documento
                                       'Tx Antecip. ' + strHisDoc + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp, // Historico 1
                                       '',                             // Historico 2
                                       '',                             // Cliente
                                       strForTax,                      // Fornecedor
                                       '',                             // Numero da Duplicata
                                       0,                              // Sequencial Duplicata
                                       '',                             // Parcela da Duplicata
                                       arrBaiSinCar[intCont].strCodEmp,// Empresa da Duplicata
                                       '',                             // Série
                                       //'',                           // Sequencial de Lançamento
                                       '',                             // Código do Evento
                                       '',                             // Documento da Baixa
                                       Nil,                            // Log Bancário
                                       0,
                                       intCtpCon,
                                       '',
                                       '',
                                       objSequencias.intSeqLan.ToString,
                                       fFormataAutInc(objSequencias.intContadorAutIncMovBan, VS_strCodEmp),
                                       '',
                                       '',
                                       1,
                                       True,
                                       LListaBanMca);

          Inc64(objSequencias.intSeqLan);
          Inc64(objSequencias.intContadorAutIncMovBan);

          blnConfirma := (Not fEmptyStr(strSeqLanAnt));
          arrBaiSinCar[intCont].strSeqLanAnt := strSeqLanAnt;

          {***************************************}
          {* GRAVA CADPAG DA TAXA DE ANTECIPAÇÃO *}
          {************************************AJ*}
          If (blnConfirma) Then
          Begin
            if (fltValorBaixa <> 0) and (strCodPorFix <> '') then
            begin
              SetLength(arrSeqLanLoc, Length(arrSeqLanLoc) + 1);
              arrSeqLanLoc[Length(arrSeqLanLoc)-1] := strSeqLanTax;
            end;

            strNumDup := 'G' + fStrZero(objSequencias.intSequencialCadPag.ToString, 11);

            blnCadPag :=  fGravaCadPag('frmBaixaCartoes',
                                       'INCLUSAO TAXA - CARTOES BX_SIN',
                                       strForTax,
                                       strNumDup,
                                       'A',
                                       arrBaiSinCar[intCont].strCodEmp,
                                       strCtaAnt,
                                       'CRT',
                                       0,
                                       IIF(blnBaiMan, dtaDtaDoc, arrBaiSinCar[intCont].dtaDtaRec),
                                       IIF(blnBaiMan, dtaDtaDoc, arrBaiSinCar[intCont].dtaDtaRec),
                                       0,
                                       arrBaiSinCar[intCont].fltValAnt,
                                       'N',
                                       'N',
                                       'N',
                                       'Tx Antecip. ' + strHisDoc + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp,
                                       '',
                                       'Tx Antecip. ' + strHisDoc + ' - Ref.Emp. ' + arrBaiSinCar[intCont].strCodEmp,
                                       strPorTax,
                                       strCtaAnt,
                                       strSeqLanTax,
                                       strLoginUsuarioLogado,
                                       IIF(blnBaiMan, dtaDtaDoc, arrBaiSinCar[intCont].dtaDtaRec),
                                       arrBaiSinCar[intCont].fltValAnt,
                                       0,
                                       0,
                                       VS_strCodEmp,
                                       '',
                                       '',
                                       '',
                                       strNumDoc,
                                       0.0,
                                       0.0,
                                       intCtpCon,
                                       False,
                                       0,
                                       '',
                                       0,
                                       '',
                                       '',
                                       '',
                                       '',
                                       fFormataAutInc(objSequencias.intContadorAutIncCadPag, VS_strCodEmp),
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
                                       arrBaiSinCar[intCont].fltValAnt,
                                       0,
                                       0,
                                       0,
                                       '',
                                       0,
                                       0,
                                       '',
                                       '',
                                       '',
                                       '',
                                       '',
                                       '0',
                                       '',
                                       '',
                                       fFormataAutInc(objSequencias.intContadorAutIncLogCtp, VS_strCodEmp));

            Inc64(objSequencias.intContadorAutIncCadPag);
            Inc64(objSequencias.intContadorAutIncLogCtp);
            Inc64(objSequencias.intSequencialCadPag);

            blnConfirma := blnCadPag;
          End;
        End;

        If FBaixarTaxasAnaliticoMkt Then
        Begin
          TBaixaCartoes.GravarMovBanSinteticoFreteTaxasMarketPlace(LListaBanMca,
                                                                   objSequencias,
                                                                   arrBaiSinCar[intCont],
                                                                   strHisDoc,
                                                                   LSeqLanFrete,
                                                                   LSeqLanAjuste,
                                                                   LSeqLanCupom);

          arrBaiSinCar[intCont].SeqLanFreteMkt := LSeqLanFrete;
          arrBaiSinCar[intCont].SeqLanAjusteMkt := LSeqLanAjuste;
          arrBaiSinCar[intCont].SeqLanCupomMkt := LSeqLanCupom;
        End;

        pStepStatusGravacao(pgbStatus);
      End;


      If blnBaiMan Then
        IndexFieldNames := 'MCA_CODEMP;MCA_DTAREC'
      Else
        IndexFieldNames := 'MCA_CODEMP;MCA_DTAREC;CAR_PORBAI;CAR_CTABAI;CAR_PORBAD;CAR_CTABAD;'+
                           'CAR_PORTAX;CAR_CTATAX;CAR_FORTAX;CAR_EVEDEB;CAR_EVECRE;CAR_EVETAX';
      intCont := 0;

      First;

      pgbStatus.Position := 0;
      pgbStatus.Properties.Max :=  cdsAux.RecordCount;

      While (Not Eof) And (blnConfirma) Do
      Begin
        pStepStatusGravacao(pgbStatus);

        //Acha a empresa para gravar os dados corretos
        If blnBaiMan Then
        Begin
          If (arrBaiSinCar[intCont].strCodEmp <> FieldByName('MCA_CODEMP').AsString) Or
             (arrBaiSinCar[intCont].dtaDtaRec <> dtaDtaDoc) Then
          Begin
            For intCont := 0 to Length(arrBaiSinCar) - 1 Do
            Begin
              If (arrBaiSinCar[intCont].strCodEmp = FieldByName('MCA_CODEMP').AsString) And
                 (arrBaiSinCar[intCont].dtaDtaRec = dtaDtaDoc) Then
                Break;
            End;
          End;
        End
        Else
        Begin
          If (arrBaiSinCar[intCont].strCodEmp        <> FieldByName('MCA_CODEMP').AsString) Or
             (arrBaiSinCar[intCont].dtaDtaRec        <> FieldByName('MCA_DTAREC').Value) Or
             (arrBaiSinCar[intCont].strPorBai        <> FieldByName('CAR_PORBAI').AsString) Or
             (arrBaiSinCar[intCont].strCtaBai        <> FieldByName('CAR_CTABAI').AsString) Or
             (arrBaiSinCar[intCont].strPorBad        <> FieldByName('CAR_PORBAD').AsString) Or
             (arrBaiSinCar[intCont].strCtaBad        <> FieldByName('CAR_CTABAD').AsString) Or
             (arrBaiSinCar[intCont].strPorTax        <> FieldByName('CAR_PORTAX').AsString) Or
             (arrBaiSinCar[intCont].strCtaTax        <> FieldByName('CAR_CTATAX').AsString) Or
             (arrBaiSinCar[intCont].strForTax        <> FieldByName('CAR_FORTAX').AsString) Or
             (arrBaiSinCar[intCont].strEventoCredito <> FieldByName('CAR_EVECRE').AsString) Or
             (arrBaiSinCar[intCont].strEventoTaxa    <> FieldByName('CAR_EVETAX').AsString) Or
             (arrBaiSinCar[intCont].strEveDeb        <> FieldByName('CAR_EVEDEB').AsString) Or
             (arrBaiSinCar[intCont].strCtaAnt        <> FieldByName('CAR_CTAANT').AsString) Then
          Begin
            For intCont := 0 to Length(arrBaiSinCar) - 1 Do
            Begin
              If (arrBaiSinCar[intCont].strCodEmp        = FieldByName('MCA_CODEMP').AsString) And
                 (arrBaiSinCar[intCont].dtaDtaRec        = FieldByName('MCA_DTAREC').Value)    And
                 (arrBaiSinCar[intCont].strPorBai        = FieldByName('CAR_PORBAI').AsString) And
                 (arrBaiSinCar[intCont].strCtaBai        = FieldByName('CAR_CTABAI').AsString) And
                 (arrBaiSinCar[intCont].strPorBad        = FieldByName('CAR_PORBAD').AsString) And
                 (arrBaiSinCar[intCont].strCtaBad        = FieldByName('CAR_CTABAD').AsString) And
                 (arrBaiSinCar[intCont].strPorTax        = FieldByName('CAR_PORTAX').AsString) And
                 (arrBaiSinCar[intCont].strCtaTax        = FieldByName('CAR_CTATAX').AsString) And
                 (arrBaiSinCar[intCont].strForTax        = FieldByName('CAR_FORTAX').AsString) And
                 (arrBaiSinCar[intCont].strEventoCredito = FieldByName('CAR_EVECRE').AsString) And
                 (arrBaiSinCar[intCont].strEventoTaxa    = FieldByName('CAR_EVETAX').AsString) And
                 (arrBaiSinCar[intCont].strEveDeb        = FieldByName('CAR_EVEDEB').AsString) And
                 (arrBaiSinCar[intCont].strCtaAnt        = FieldByName('CAR_CTAANT').AsString) Then
                Break;
            End;
          End;
        End;

        If (FieldByName('MCA_MARDES').AsString = 'M') And (FieldByName('MCA_AJUSTE').AsString = 'N') Then
        Begin
          {*****************************************}
          {* BAIXA UM REGISTRO                     *}
          {**************************************MV*}
          blnConfirma := fBaixaCartao(Self.Name,
                                      'BAIXA DE CARTÕES ' +
                                      IIF(blnBaiMan, '(MANUAL)', '(' + Self.Caption + ')'),
                                      FieldByName('AUTOINC').AsString,
                                      FieldByName('NRODUP').AsString,
                                      FieldByName('PARDUP').AsString,
                                      FieldByName('MCA_CODCLI').AsString,
                                      FieldByName('MCA_CODEMP').AsString,
                                      IIF(blnBaiMan, dtaDtaDoc, arrBaiSinCar[intCont].dtaDtaRec),
                                      FieldByName('MCA_VALREC').AsFloat,
                                      strLoginUsuarioLogado,
                                      strHisDoc,
                                      IIF(blnBaiMan, strPorCar, arrBaiSinCar[intCont].strPorBai),
                                      IIF(blnBaiMan, strCtaCar, arrBaiSinCar[intCont].strCtaBai),
                                      arrBaiSinCar[intCont].strSeqLanCre,
                                      IIF(blnBaiMan, strPorTax, arrBaiSinCar[intCont].strPorTax),
                                      IIF(blnBaiMan, strCtaTax, arrBaiSinCar[intCont].strCtaTax),
                                      arrBaiSinCar[intCont].strSeqLanTax,
                                      IIF(blnBaiMan, strForTax, arrBaiSinCar[intCont].strForTax),
                                      IIF(blnBaiMan, strCtaBad, arrBaiSinCar[intCont].strCtaBad),
                                      IIF(blnBaiMan, strPorBad, arrBaiSinCar[intCont].strPorBad),
                                      arrBaiSinCar[intCont].strSeqLanDeb,
                                      FieldByName('MCA_CHACON').AsString,
                                      IIF(blnBaiMan, strEveDeb, arrBaiSinCar[intCont].strEveDeb),
                                      IIF(FieldByName('MCA_ANT_SN').AsString = 'N',
                                           '', arrBaiSinCar[intCont].strCtaAnt),
                                      IIF(FieldByName('MCA_ANT_SN').AsString = 'N',
                                           '', arrBaiSinCar[intCont].strSeqLanAnt),
                                      IIF(FieldByName('MCA_ANT_SN').AsString = 'N',
                                           0, FieldByName('MCA_ANTTAX').AsFloat),
                                      fFormataAutInc(objSequencias.intContadorAutIncLogMca, VS_strCodEmp),
                                      IIF(blnBaiMan, strEventoCredito, arrBaiSinCar[intCont].strEventoCredito),
                                      IIF(blnBaiMan, strEventoTaxa, arrBaiSinCar[intCont].strEventoTaxa),
                                      IIF(blnBaiMan, 0.00, FieldByName('FRETE_MARKETPLACE').AsFloat),
                                      IIF(blnBaiMan, 0.00, FieldByName('AJUSTE_MARKETPLACE').AsFloat),
                                      IIF(blnBaiMan, 0.00, FieldByName('MCA_VALTAX').AsFloat),
                                      IIF(blnBaiMan, 0.00, FieldByName('CUPOM_MARKETPLACE').AsFloat),
                                      FieldByName('ALTERAR_BRUTO').AsString.Equals('S'),
                                      FieldByName('MCA_VALSTA').AsFloat,
                                      IIF(blnBaiMan, EmptyStr, arrBaiSinCar[intCont].SeqLanFreteMkt),
                                      IIF(blnBaiMan, EmptyStr, arrBaiSinCar[intCont].SeqLanAjusteMkt),
                                      IIF(blnBaiMan, EmptyStr, arrBaiSinCar[intCont].SeqLanCupomMkt));

          Inc64(objSequencias.intContadorAutIncLogMca);

          If (blnConRed) And (blnConfirma) Then
          Begin
            SetLength(arrNumNsu, Length(arrNumNsu) + 1);

            arrNumNsu[Length(arrNumNsu) - 1] := fPadL(FieldByName('MCA_NUMNSU').AsString, 14, '0');
          End;

          If (blnConfirma) Then
             pAtualizaDataMovimentobancarioMovCar( FieldByName('AUTOINC').AsString, IIF(blnBaiMan, dtaDtaDoc, arrBaiSinCar[intCont].dtaDtaRec) );

        End;

        If Not blnConfirma Then
          Break;

        Next;
      End;

      If blnConcil Then
      Begin
        If blnConfirma Then
          TBaixaCartoes.GravaMovBanDeTransferencias(cdsBaiCar,
                                                    objConcil.strNomCon,
                                                    objSequencias);
      End;

      If (blnConcil) And (blnConfirma) Then
      Begin
        If (Not objConcil.strChavePrimaria.IsEmpty) Then
          TBaixaCartoes.MarcarComoConciliado(objConcil, cdsBaiCar);
      End;

      SetLength(arrBaiSinCar, 0);

      If Not blnConfirma Then
        Raise Exception.Create('Não foi possível baixar o(s) cartão(ões)!')
      Else
        blnConfirmaBaixa := True;
    End;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      blnConfirmaBaixa := False;
      Result := false;
      pMensagensErro(E.Message, '[TfrmBaixaCartoes.fGravaCartoesSin]');
      FreeAndNil(cdsAux);

      If Assigned(cdsCloneConsulta) Then
        FreeAndNil(cdsCloneConsulta);

      Exit;
    End;
  End;

  blnConfirmaBaixa := blnConfirma;
  FreeAndNil(cdsAux);

  If Assigned(cdsCloneConsulta) Then
    FreeAndNil(cdsCloneConsulta);

  Result :=  True;
End;

procedure TfrmBaixaCartoes.pMarcaRegistrosResolvidoKoncilia(cdsRegistros: TUniClientDataset);
  Var
    LFDataResp,
    LFDataReq: TMemoryStream;

    LResposta: String;

    intContadorRegistros: Integer;

    strLinkAPI,
    strChaveKoncilia,
    strAmbiente,
    strEmpresaAtual,
    strCorporequisicao: String;

    strParameter: array of String;
    FGravando   : IObserver_;
    FSubject    : ISubject_;
Begin
  Try
    cdsRegistros.Filter          := 'MARCADO=''S'' ';
    cdsRegistros.Filtered        := True;
    cdsRegistros.IndexFieldNames := 'KON_CODEST';

    intContadorRegistros := 0;

    FGravando := TGravandoObs.Create;
    FSubject  := TSubject.Create;

    FSubject.pAddObserver(FGravando);

    SetLength(strParameter,4);
    strParameter[0] := 'TcxProgressBar';
    strParameter[1] := IntToStr(cdsRegistros.RecordCount);
    strParameter[2] := 'Aguarde...  Marcando como resolvido na API Koncili.';

    FSubject.pNotify(strParameter);

    cdsRegistros.First;
    While Not (cdsRegistros.Eof) Do
    Begin
      If strEmpresaAtual <> cdsRegistros.FieldByName('KON_CODEST').AsString Then
      Begin
        strEmpresaAtual  := cdsRegistros.FieldByName('KON_CODEST').AsString;
        strChaveKoncilia := fCfgSis('KONKEY', varString, strEmpresaAtual);
        strAmbiente      := fCfgSis('KONAMB', varString, strEmpresaAtual);

        strLinkAPI := 'https://api-sandbox.koncili.com/externalapi/orderextract/resolve/batch/';
        If strAmbiente = 'N' Then
          strLinkAPI := 'https://api.koncili.com/externalapi/orderextract/resolve/batch/';

        intContadorRegistros := 0;
        strCorporequisicao := '[';
      End;

      If (cdsRegistros.FieldByName('MARCADO').AsString = 'S') Then
      Begin
        strCorporequisicao := strCorporequisicao + cdsRegistros.FieldByName('KON_ID_KON').AsString + ',';
        Inc(intContadorRegistros);
      End;

      strParameter[3] := IntToStr(cdsRegistros.RecNo);
      FSubject.pNotify(strParameter);

      cdsRegistros.Next;

      If ((cdsRegistros.Eof) And (intContadorRegistros > 0)) Or
         (intContadorRegistros = 100) Or
         (strEmpresaAtual <> cdsRegistros.FieldByName('KON_CODEST').AsString) Then
      Begin

        If fEmptyStr(strChaveKoncilia) Then
          Continue;

        CriarComponetesRequisicao;

        strCorporequisicao := LeftStr(strCorporequisicao, strCorporequisicao.Length - 1) + ']';
        FHTTPSend.Headers.Add('gumgaToken: '+ strChaveKoncilia);

        Try
          LFDataReq := TMemoryStream.Create;
          WriteStrToStream(LFDataReq, AnsiString(UTF8Encode(strCorporequisicao)));
          FHTTPSend.Document.LoadFromStream(LFDataReq);
        Finally
          FreeAndNil(LFDataReq);
        End;

        FHTTPSend.HTTPMethod('PUT', strLinkAPI);


        Try
          LFDataResp := TMemoryStream.Create;
          LFDataResp.LoadFromStream(FHTTPSend.Document);

          LFDataResp.Position := 0;
          LResposta := UTF8ToString(ReadStrFromStream(LFDataResp, LFDataResp.Size));

        Finally
          FreeAndNil(LFDataResp);
        End;


        If FHTTPSend.ResultCode = 200 Then
        Begin
          fExecutaSQL('UPDATE KON_KOPGTO SET KON_CONCIL=1, KON_RESOLV=1 ' +
                      ' WHERE KON_ID_KON IN ' + strCorporequisicao.Replace('[', '(').Replace(']', ')') +
                      '   AND (KON_CONCIL<>1 OR KON_RESOLV<>1)');

          intContadorRegistros := 0;
          strCorporequisicao := '[';

          Application.ProcessMessages;
        End
        Else
          Raise Exception.Create('Ocorreu um erro na requisição com a API Koncili!' + #13 +
                                 'Código do erro: ' + FHTTPSend.ResultCode.toString +
                                 'Mensagem: ' + LResposta);
      End;
    End;
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

  If Assigned(FHTTPSend) Then
    FreeAndNil(FHTTPSend);
End;

Function TfrmBaixaCartoes.fVerificaAcessoAlteracaoValor(FltVlrSemAlt, FltVlrInfo : Real): Boolean;
Begin

  Result := True;

  If (Not fVerificaAcessoSistema('CARALTVLBXM', strLoginUsuarioLogado)) Then
  Begin
    setLength(arrLogLib, 0);

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('BAIXA DE CARTÃO - ALTERAÇÃO DO VALOR DE RECEBIMENTO.');
    objLiberacao.objMsgLibera.pAddTexto('');

    objLiberacao.objMsgLibera.pAddTexto('--------------------------------------------------------------------------------------------------------------------------------------------');
    objLiberacao.objMsgLibera.pAddTexto('| NUM. LIBERAÇÃO | NSU               | EMP. | NUM. NOTA            | DT.CAD.  | DT.VEN   | VALOR BRUTO  | VALOR LIQ. ATUAL |  VALOR INFOR. |');
    objLiberacao.objMsgLibera.pAddTexto(' -------------------------------------------------------------------------------------------------------------------------------------------');
    objLiberacao.objMsgLibera.pAddTexto(Concat('| ',
                                               LeftStr(fPadR(cdsBaiCar.FieldByName('MCA_NUMCCD').AsString, 15), 15),
                                               '| ',
                                               LeftStr(fPadR(cdsBaiCar.FieldByName('MCA_NUMNSU').AsString, 17), 17),
                                               ' | ',
                                               LeftStr(fPadR(cdsBaiCar.FieldByName('MCA_CODEMP').AsString, 4), 4),
                                               ' | ',
                                               LeftStr(fPadR(cdsBaiCar.FieldByName('MCA_NUMNOT').AsString, 21), 21),
                                               '| ',
                                               FormatDateTime('dd/mm/yy', cdsBaiCar.FieldByName('MCA_DTACAD').AsDateTime),
                                               ' | ',
                                               FormatDateTime('dd/mm/yy', cdsBaiCar.FieldByName('MCA_DTAVEN').AsDateTime),
                                               ' | ',
                                               fPadL(FormatFloat(',0.00', cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat), 12),
                                               ' | ',
                                               fPadL(FormatFloat(',0.00', FltVlrSemAlt), 16),
                                               ' | ',
                                               fPadL(FormatFloat(',0.00', FltVlrInfo), 13),
                                               ' |'));
    objLiberacao.objMsgLibera.pAddTexto('--------------------------------------------------------------------------------------------------------------------------------------------');


    objLiberacao.strDirAce := 'CARALTVLBXM';
    objLiberacao.strMsgSen := 'Permitir alterar o valor do cartão na baixa manual.';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strCodDig := strLoginUsuarioLogado;
    objLiberacao.pInformaNumDocEspDocCodEmp(
                    EmptyStr,
                    EmptyStr,
                    VS_strCodEmp);

    If Not objLiberacao.fLibera Then
       Result := False;
  End;

End;

procedure TfrmBaixaCartoes.pAtualizaDataMovimentobancarioMovCar( sAutoInc : String; ADataAlterada: TDateTime);
Var
  qryAltCrt : TUniQuery;
begin
  qryAltCrt := fCriaQuery(Self);

  Try

     qryAltCrt.Close;
     qryAltCrt.SQL.Clear;
     qryAltCrt.SQL.Add(' UPDATE MOVCAR ');
     qryAltCrt.SQL.Add('    SET MCA_DTABAN = :DTABAN ');
     qryAltCrt.SQL.Add('  WHERE AUTOINCREM = :AUTOIN ');
     qryAltCrt.ParamByName('DTABAN').AsDateTime := ADataAlterada;
     qryAltCrt.ParamByName('AUTOIN').AsString   := sAutoInc;
     qryAltCrt.ExecSQL;

     If Assigned(qryAltCrt) Then
        FreeAndNil(qryAltCrt);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[TfrmBaixaCartoes.pAtualizaDataMovimentobancarioMovCar] ' +E.Message);
    End;
  End;
End;

end.

