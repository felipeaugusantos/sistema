unit untCadLeads;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Uni, StrUtils,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, EditFocus, Vcl.Mask,
  Vcl.DBCtrls, DBEditFocus, MemoFocus, DBMemoFocus, MaskEditFocus,
  Datasnap.DBClient, UniClientDataSet, System.IOUtils, Vcl.Grids, Vcl.DBGrids,
  cxImage, untTypesSistema, QColorLabel, untILeads, untLeads;

type
  TProcedureChamaOrcamento = procedure (Sender: TObject; strCodCli, strNumLead: string) of object;
  TProcedureSetaNumLead    = procedure (strNumLead : String) of object;

  TfrmCadLeads = class(TfrmPaiCad)
    pnlTop: TPanel;
    pnlBottom: TPanel;
    Label5: TLabel;
    dbeCodCli: TDBEditFocus;
    edtNomCli: TEditFocus;
    dbeNumDoc: TDBEditFocus;
    Label16: TLabel;
    Label1: TLabel;
    dbeCodEmp: TDBEditFocus;
    edtCliCid: TEditFocus;
    Label2: TLabel;
    Label3: TLabel;
    edtCliTip: TEditFocus;
    Label4: TLabel;
    DBEditFocus1: TDBEditFocus;
    dbeIniObr: TDBEditFocus;
    Label6: TLabel;
    Label7: TLabel;
    mmoCliObs: TMemoFocus;
    dtsTabela: TDataSource;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label14: TLabel;
    edtLinGru: TMaskEditFocus;
    edtDesGru: TEditFocus;
    edtObserv: TEditFocus;
    Label17: TLabel;
    edtPrevis: TEditFocus;
    Label18: TLabel;
    lblCodOpe: TLabel;
    edtCodPVe: TEditFocus;
    Label19: TLabel;
    edtNomPVe: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    dtsItens: TDataSource;
    ckbRegist: TCheckBox;
    ckbDescont: TCheckBox;
    edtNumReg: TEditFocus;
    edtAutDes: TEditFocus;
    dbeNomPro: TDBEditFocus;
    Label20: TLabel;
    btnContatos: TBitBtnLocked;
    btnOrcamento: TBitBtnLocked;
    btnOrcamentos: TBitBtnLocked;
    btnAnexos: TBitBtnLocked;
    edtNomKam: TEditFocus;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label10: TLabel;
    dbmObs001: TDBMemoFocus;
    dbmObs002: TDBMemoFocus;
    Label11: TLabel;
    TabSheet2: TTabSheet;
    cdsMovOcorr: TUniClientDataSet;
    cdsMovOcorrOCO_CODOCO: TStringField;
    cdsMovOcorrOCO_CODTOC: TStringField;
    cdsMovOcorrOCO_CODCLI: TStringField;
    cdsMovOcorrOCO_DTAINC: TDateField;
    cdsMovOcorrOCO_HORINC: TTimeField;
    cdsMovOcorrOCO_DTACON: TDateField;
    cdsMovOcorrOCO_HORCON: TTimeField;
    cdsMovOcorrOCO_CODOPE: TStringField;
    cdsMovOcorrOCO_DESCRI: TMemoField;
    cdsMovOcorrOCO_CODEMP: TStringField;
    cdsMovOcorrAUTOINCREM: TStringField;
    cdsMovOcorrCLI_NOMCLI: TStringField;
    cdsMovOcorrTOC_DESTOC: TStringField;
    cdsMovOcorrOPE_NOMOPE: TStringField;
    cdsMovOcorrIMAGEM1: TBlobField;
    cdsMovOcorrHOREXC: TFloatField;
    cdsMovOcorrOCO_EMERGE: TStringField;
    cdsMovOcorrOCO_DTALIM: TDateTimeField;
    cdsMovOcorrOCO_TMPLIM: TFloatField;
    cdsMovOcorrOCO_METLIM: TFloatField;
    cdsMovOcorrNUMDOC: TStringField;
    cdsMovOcorrOCO_CODSIT: TStringField;
    cdsMovOcorrFGO_VLRCON: TFloatField;
    cdsMovOcorrOCO_PROTOC: TStringField;
    cdsMovOcorrSTATUS: TStringField;
    cdsMovOcorrNUMCMP: TStringField;
    cdsMovOcorrENTRET: TStringField;
    cdsMovOcorrCLILOJ: TStringField;
    cdsMovOcorrFGO_STATUS: TIntegerField;
    cdsMovOcorrDOCCON: TStringField;
    cdsMovOcorrUSADEPS: TStringField;
    cdsMovOcorrSTATUSDEPS: TStringField;
    cdsMovOcorrAUTOINCREMFATGOR: TStringField;
    cdsMovOcorrMOTBAI: TStringField;
    cdsMovOcorrCAT_DESCRI: TStringField;
    dtsMovOcorr: TDataSource;
    dbgMovOcorr: TcxGridCitel;
    dbgMovOcorrDBTableView1: TcxGridDBTableViewCitel;
    dbgMovOcorrDBTableView1IMAGEM1: TcxGridDBColumn;
    dbgMovOcorrDBTableView1STATUS: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OCO_DTAINC: TcxGridDBColumn;
    dbgMovOcorrDBTableView1TOC_DESTOC: TcxGridDBColumn;
    dbgMovOcorrDBTableView1NumDoc: TcxGridDBColumn;
    dbgMovOcorrDBTableView1DOCCON: TcxGridDBColumn;
    dbgMovOcorrDBTableView1FGO_VLRCON: TcxGridDBColumn;
    dbgMovOcorrDBTableView1NUMCMP: TcxGridDBColumn;
    dbgMovOcorrDBTableView1ENTRET: TcxGridDBColumn;
    dbgMovOcorrDBTableView1CLILOJ: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OPE_NOMOPE: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OCO_DTACON: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OCO_HORCON: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OCO_EMERGE: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OCO_DTALIM: TcxGridDBColumn;
    dbgMovOcorrDBTableView1HOREXC: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OCO_TMPLIM: TcxGridDBColumn;
    dbgMovOcorrDBTableView1OCO_METLIM: TcxGridDBColumn;
    dbgMovOcorrDBTableView1STATUSDEPS: TcxGridDBColumn;
    dbgMovOcorrDBTableView1CAT_DESCRI: TcxGridDBColumn;
    dbgMovOcorrLevel1: TcxGridLevel;
    btnIncOcorrencia: TBitBtnLocked;
    btnVincularOrc: TBitBtnLocked;
    btnFinalizarLead: TBitBtnLocked;
    pnlDados: TPanel;
    Label25: TLabel;
    Label15: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label24: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    pnlCategoria: TPanel;
    LbCategoria: TLabel;
    dbeCodCat: TDBEditFocus;
    edtNomCat: TEditFocus;
    dbeTotVpr: TDBEditFocus;
    edtCodVen: TDBEditFocus;
    edtNomVen: TEditFocus;
    edtNomExt: TEditFocus;
    dbeVenExt: TDBEditFocus;
    dbeCodIns: TDBEditFocus;
    edtNomIns: TEditFocus;
    edtTipIns: TEditFocus;
    dbeCodFas: TDBEditFocus;
    edtNomFas: TEditFocus;
    dbePreOrd: TDBEditFocus;
    GroupBox1: TGroupBox;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    dbeConFab: TDBEditFocus;
    dbeConInt: TDBEditFocus;
    dbeConDis: TDBEditFocus;
    grbStatus: TGroupBox;
    lblStatus: TLabel;
    lblDtaFin: TLabel;
    lblHorFin: TLabel;
    lblOpeFin: TLabel;
    lblStatusLead: TLabel;
    edtDtaFin: TEditFocus;
    edtHorFin: TEditFocus;
    edtOpeFin: TEditFocus;
    cxgItens: TcxGridCitel;
    cxgItensDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxgItensDBTableViewCitel1CODGRU: TcxGridDBColumn;
    cxgItensDBTableViewCitel1DESGRU: TcxGridDBColumn;
    cxgItensDBTableViewCitel1PREVIS: TcxGridDBColumn;
    cxgItensDBTableViewCitel1KAFORN: TcxGridDBColumn;
    cxgItensDBTableViewCitel1CODPVE: TcxGridDBColumn;
    cxgItensDBTableViewCitel1NOMPVE: TcxGridDBColumn;
    cxgItensDBTableViewCitel1REGIST: TcxGridDBColumn;
    cxgItensDBTableViewCitel1NUMREG: TcxGridDBColumn;
    cxgItensDBTableViewCitel1DESCON: TcxGridDBColumn;
    cxgItensDBTableViewCitel1OBSERV: TcxGridDBColumn;
    cxgItensDBTableViewCitel1AUTDES: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    lblMarca: TLabel;
    edtDesMar: TEditFocus;
    edtCodMar: TEditFocus;
    cdsItens: TUniClientDataSet;
    cdsItensCODGRU: TStringField;
    cdsItensDESGRU: TStringField;
    cdsItensPREVIS: TFloatField;
    cdsItensOBSERV: TStringField;
    cdsItensCODKAM: TStringField;
    cdsItensNOMKAM: TStringField;
    cdsItensMOEDA_: TStringField;
    cdsItensCODPVE: TStringField;
    cdsItensNOMPVE: TStringField;
    cdsItensREGIST: TStringField;
    cdsItensDESCON: TStringField;
    cdsItensNUMREG: TStringField;
    cdsItensAUTDES: TStringField;
    cdsItensKAFORN: TStringField;
    cdsItensCODMAR: TStringField;
    cdsItensDESMAR: TStringField;
    Splitter1: TSplitter;
    cdsItensMARCA: TStringField;
    cxgItensDBTableViewCitel1MARCA: TcxGridDBColumn;
    cdsItensTOT_PREVIS: TAggregateField;
    Label26: TLabel;
    edtPrevisDolar: TEditFocus;
    Label27: TLabel;
    edtValorCotacao: TEditFocus;
    Label28: TLabel;
    btnCalcPrevOrcDolar: TBitBtnLocked;
    mskDtaCot: TMaskEditFocus;
    cdsItensLDD_PRVDLR: TFloatField;
    cdsItensLDD_DTACOT: TDateTimeField;
    cdsItensLDD_VLRCOT: TFloatField;
    cxgItensDBTableViewCitel1LDD_PRVDLR: TcxGridDBColumn;
    Label29: TLabel;
    dbeTotVprDolar: TDBEditFocus;
    cdsItensTOT_PREVIS_DLR: TAggregateField;
    lblDataFlw: TLabel;
    DEDTAFLW: TDBEditFocus;
    edtOrcVin: TEditFocus;
    edtCodEmpOrcVin: TEditFocus;
    edtNomEmpOrcVin: TEditFocus;
    lblOrcVin: TLabel;
    lblEmpOrcVin: TLabel;
    cdsItensORCVIN: TStringField;
    cxgItensDBTableViewCitel1ORCVIN: TcxGridDBColumn;
    cdsItensLDD_ORCVIN: TStringField;
    cdsItensLDD_EMPORC: TStringField;
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeVenExtKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodInsKeyPress(Sender: TObject; var Key: Char);
    function dbeVenExtChamaCadastro(Key: Word): string;
    procedure dbeCodFasKeyPress(Sender: TObject; var Key: Char);
    procedure edtLinGruKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodPVeKeyPress(Sender: TObject; var Key: Char);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure cxgItensDBTableViewCitel1DblClick(Sender: TObject);
    procedure cxgItensDBTableViewCitel1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnGravarClick(Sender: TObject);
    procedure ckbRegistClick(Sender: TObject);
    procedure ckbDescontClick(Sender: TObject);
    procedure btnContatosClick(Sender: TObject);
    procedure btnOrcamentoClick(Sender: TObject);
    procedure btnOrcamentosClick(Sender: TObject);
    procedure btnAnexosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbgMovOcorrDBTableView1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgMovOcorrDBTableView1DblClick(Sender: TObject);
    procedure btnIncOcorrenciaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbeCodCatKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure cdsItensAfterDelete(DataSet: TDataSet);
    procedure btnVincularOrcClick(Sender: TObject);
    procedure btnFinalizarLeadClick(Sender: TObject);
    function edtCodVenChamaCadastro(Key: Word): string;
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodMarExit(Sender: TObject);
    procedure cdsItensCalcFields(DataSet: TDataSet);
    procedure btnCalcPrevOrcDolarClick(Sender: TObject);
    procedure edtPrevisExit(Sender: TObject);
    procedure edtCodEmpOrcVinKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpOrcVinExit(Sender: TObject);
    procedure edtOrcVinKeyPress(Sender: TObject; var Key: Char);
  strict private
    procedure pPesquisaPadraoOperador(objEdit: TDBEditFocus; var Key: Char; arrSel : TConsultasArray);
    function fPesquisarOperadorSemClienteInformado(objEdit: TDBEditFocus; var Key: Char; arrSel : TConsultasArray): Boolean;
    function fPesquisarOperadorSeNenhumVendedorVinculadoAoCliente(objEdit: TDBEditFocus; var Key: Char; arrSel : TConsultasArray): Boolean;
    procedure pPesquisarVendedoresVinculadosAoCliente(objEdit: TDBEditFocus; var Key: Char; arrSel : TConsultasArray);
    procedure pKeyPressCodigoVendedorGenerico(Sender: TObject; var Key: Char);
    procedure pCarregarDadosCotacao;
    procedure pCalcularPrevisaoOrcamentoDolar;
    procedure pSetarObjLeads;
  private
    strCodCli : String;
    strSqlPesq: String;
    blnCarregaLeadsDoAtalhoPesq : Boolean;
    prcChamaOrcamento : TProcedureChamaOrcamento;
    prcSetaNumLead    : TProcedureSetaNumLead   ;
    qryOcorre : TUniQuery;
    objLeads: ILeads;
    FTip_Fc: String;
    qryCotacao : TUniQuery;
    FSeqLogLdg: String;
    arrEmpresas : TConsultasArray;

    procedure pCarregaCliente;
    procedure pLimpaCampos;
    procedure pFormataCampos;
    procedure pLimpaItens;
    function fGravaLadDet: Boolean;
    procedure pCarregaLadDet;
    procedure pCarregaItemEdicao;
    procedure pCarregaHistorioOcorrencia;
    procedure pInserirAlterarOcorrencia(strTipoAcao: String);
    procedure pPreencherTotalPrevisaoOrcamento;
    procedure pAtualizaInformacoesGeraisDoLead;
    procedure pAlterarStatusLeadParaFinalizado;
    procedure pAlterarStatusLeadParaAndamento;
    function getTip_Fc: String;
    procedure setTip_Fc(const Value: String);
    procedure pGravarLogLadGer;
    function fCarregaOrcamento(strNumDoc, strCodEmp, strCodCli: String;
      var strLinGru, strLeads: String): Boolean;
    function fMesmoRegistroLinGru(strFgoLinGru, strCodLinGru, strFgoLeads,
      strLead: String): Boolean;
    function fEncontrouRegistroNaGrade(strNumOrc,
      strCodEmpOrc: String): Boolean;
  public
    property strTip_Fc: String Read getTip_Fc Write setTip_Fc;
    class procedure fCadLeads(strCodCli : String; prcChamaOrcamentoP : TProcedureChamaOrcamento; prcSetaNumLeadP : TProcedureSetaNumLead; Chave: String = ''; strTip_Fc: String = 'C'); overload;
    class procedure fCadLeads(prcChamaOrcamentoP: TProcedureChamaOrcamento; aObjLeads: ILeads); overload;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean; Override;
    function fExecutaAntesDoDelete : Boolean; Override;
    procedure pOnStateChange; override;
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untFuncIns, untFuncoesConsulta,
  untContatoLeads, untCadLeadOrcamentos, untGravaArquivoPasta, untFuncoesCRM,
  untCRM, untCadMovOcorrencias, untCategoriaCadLead, untCadLeadVincularOrcamentos,
  DateUtils;

{$R *.dfm}

procedure TfrmCadLeads.pCarregaLadDet;
  Var
    qryLadDet : TUniQuery;
Begin
  qryLadDet := fCriaQuery;
  Try
    With qryLadDet, SQL Do
    Begin
      Close;
      Clear;

      Add(' SELECT LDD_LINGRU     AS LINGRU,                      ');
      Add('        GRU_DESGRU     AS DESGRU,                      ');
      Add('        LDD_VALPRE     AS VALPRE,                      ');
      Add('        LDD_OBSERV     AS OBSERV,                      ');
      Add('        LDD_KAMFOR     AS CODKAM,                      ');
      Add('        LDD_KAFORN     AS KAFORN,                      ');
      Add('        KAM.OPE_NOMOPE AS NOMKAM,                      ');
      Add('        LDD_PREVEN     AS OPEPVE,                      ');
      Add('        INS.OPE_NOMOPE AS NOMPVE,                      ');
      Add('        LDD_MOEDA_     AS MOEDA_,                      ');
      Add('        LDD_REGIST     AS REGIST,                      ');
      Add('        LDD_DESCON     AS DESCON,                      ');
      Add('        LDD_NUMREG     AS NUMREG,                      ');
      Add('        LDD_AUTDES     AS AUTDES,                      ');
      Add('        LDD_CODMAR     AS CODMAR,                      ');
      Add('        MAR_DESMAR     AS DESMAR,                      ');
      Add('        LDD_VLRCOT,                                    ');
      Add('        LDD_DTACOT,                                    ');
      Add('        LDD_PRVDLR,                                    ');
      Add('        LDD_ORCVIN,                                    ');
      Add('        LDD_EMPORC                                     ');
      Add(' FROM LADDET                                           ');
      Add('   LEFT JOIN CADOPE KAM ON KAM.OPE_CODOPE = LDD_KAMFOR ');
      Add('   LEFT JOIN CADOPE INS ON INS.OPE_CODOPE = LDD_PREVEN ');
      Add('   LEFT JOIN CADGRU GRU ON GRU.GRU_CODGRU = LDD_LINGRU ');
      Add('   LEFT JOIN CADMAR MAR ON MAR.MAR_CODMAR = LDD_CODMAR ');
      Add(' WHERE LDD_SEQGER = :SEQGER                            ');

      ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;

      Open;

      cdsItens.EmptyDataSet;
      While not Eof Do
      Begin
        cdsItens.Insert;
        cdsItensCODGRU.AsString := FieldByName('LINGRU').AsString;
        cdsItensDESGRU.AsString := FieldByName('DESGRU').AsString;
        cdsItensPREVIS.AsFloat  := FieldByName('VALPRE').AsFloat;
        cdsItensOBSERV.AsString := FieldByName('OBSERV').AsString;
        cdsItensCODKAM.AsString := FieldByName('CODKAM').AsString;
        cdsItensNOMKAM.AsString := FieldByName('NOMKAM').AsString;
        cdsItensKAFORN.AsString := FieldByName('KAFORN').AsString;
        cdsItensCODPVE.AsString := FieldByName('OPEPVE').AsString;
        cdsItensNOMPVE.AsString := FieldByName('NOMPVE').AsString;
        cdsItensMOEDA_.AsString := FieldByName('MOEDA_').AsString;
        cdsItensREGIST.AsString := FieldByName('REGIST').AsString;
        cdsItensDESCON.AsString := FieldByName('DESCON').AsString;
        cdsItensNUMREG.AsString := FieldByName('NUMREG').AsString;
        cdsItensAUTDES.AsString := FieldByName('AUTDES').AsString;
        cdsItensCODMAR.AsString := FieldByName('CODMAR').AsString;
        cdsItensDESMAR.AsString := FieldByName('DESMAR').AsString;
        cdsItensLDD_VLRCOT.AsFloat  := FieldByName('LDD_VLRCOT').AsFloat;
        cdsItensLDD_DTACOT.AsString := FieldByName('LDD_DTACOT').AsString;
        cdsItensLDD_PRVDLR.AsFloat  := FieldByName('LDD_PRVDLR').AsFloat;
        cdsItensLDD_ORCVIN.AsString := FieldByName('LDD_ORCVIN').AsString;
        cdsItensLDD_EMPORC.AsString := FieldByName('LDD_EMPORC').AsString;
        cdsItens.Post;

        Next;
      End;


    End;

  Finally
    FreeAndNil(qryLadDet);
  End;

End;

procedure TfrmCadLeads.pPreencherTotalPrevisaoOrcamento;
begin
  if (qryTabela.IsEmpty) then
    Exit;

  qryTabela.FieldByName('LDG_TOTVPR').AsFloat := fDoubleAggregate(cdsItens, 'TOT_PREVIS');
end;

function TfrmCadLeads.fGravaLadDet : Boolean;
  Var
    qryInsert,
    qryInsertLog : TUniQuery;
    qryFatGor : TUniQuery;
Begin
  Result := True;

  qryInsert    := fCriaQuery;
  qryInsertLog := fCriaQuery;
  qryFatGor    := fCriaQuery;

  cdsItens.DisableControls;
  Try
    fStartTransaction();
    Try
      qryInsert.Close;
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add(' DELETE FROM LADDET WHERE LDD_SEQGER = :SEQGER ');
      qryInsert.ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      qryInsert.ExecSQL;

      qryInsert.Close;
      qryInsert.SQL.Clear;
      qryInsert.SQL.Add(' INSERT INTO LADDET(AUTOINCREM, LDD_SEQGER, LDD_LINGRU, LDD_OBSERV, ' +
                        ' LDD_VALPRE, LDD_PREVEN, LDD_REGIST, LDD_DESCON, LDD_NUMREG, ' +
                        ' LDD_AUTDES, LDD_KAFORN, LDD_CODMAR, LDD_VLRCOT, LDD_DTACOT, LDD_PRVDLR, LDD_ORCVIN, LDD_EMPORC) ');
      qryInsert.SQL.Add(' VALUES(:AUTINC, :SEQGER, :LINGRU, :OBSERV, :VALPRE, :PREVEN, :REGIST, ' +
                        ':DESCON, :NUMREG, :AUTDES, :KAFORN, :CODMAR, :LDD_VLRCOT, :LDD_DTACOT, :LDD_PRVDLR, :LDD_ORCVIN, :LDD_EMPORC) ');


      qryInsertLog.Close;
      qryInsertLog.SQL.Clear;
      qryInsertLog.SQL.Add(' INSERT INTO LOGLDT(AUTOINCREM, LOG_SEQGER, LOG_LINGRU, LOG_OBSERV, ' +
                           ' LOG_VALPRE, LOG_PREVEN, LOG_REGIST, LOG_DESCON, LOG_NUMREG, ' +
                           ' LOG_AUTDES, LOG_KAFORN, LOG_CODMAR, LOG_VLRCOT, LOG_DTACOT, LOG_PRVDLR, '+
                           ' LOG_DTALOG, LOG_HORLOG, LOG_OPELOG, LOG_FRMLOG, LOG_SEQLOG) ');
      qryInsertLog.SQL.Add(' VALUES(:AUTINC, :SEQGER, :LINGRU, :OBSERV, :VALPRE, :PREVEN, :REGIST, ' +
                           ':DESCON, :NUMREG, :AUTDES, :KAFORN, :CODMAR, :VLRCOT, :DTACOT, :PRVDLR, '+
                             ':DTALOG, :HORLOG, :OPELOG, :FRMLOG, :SEQLOG) ');

      qryFatGor.Close;
      qryFatGor.SQL.Clear;
      qryFatGor.SQL.Add(' UPDATE EXTGOR E ');
      qryFatGor.SQL.Add(' JOIN FATGOR F ON F.AUTOINCREM = E.FGO_SEQFGO');
      qryFatGor.SQL.Add(' SET E.FGO_LINGRU = :LINGRU,  ');
      qryFatGor.SQL.Add('     E.FGO_NLEADS = :NLEADS   ');
      qryFatGor.SQL.Add(' WHERE F.FGO_NUMDOC = :NUMDOC ');
      qryFatGor.SQL.Add('   AND F.FGO_CODEMP = :CODEMP ');
      qryFatGor.SQL.Add('   AND F.FGO_ESPDOC = :ESPDOC ');

      cdsItens.First;
      While not cdsItens.Eof Do
      Begin
        qryInsert.ParamByName('AUTINC').AsString := fRetAutoIncrem('LADDET', VS_strCodEmp);;
        qryInsert.ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
        qryInsert.ParamByName('LINGRU').AsString := cdsItensCODGRU.AsString;
        qryInsert.ParamByName('OBSERV').AsString := cdsItensOBSERV.AsString;
        qryInsert.ParamByName('VALPRE').AsFloat  := cdsItensPREVIS.AsFloat;
        qryInsert.ParamByName('KAFORN').AsString := cdsItensKAFORN.AsString;
        qryInsert.ParamByName('PREVEN').AsString := cdsItensCODPVE.AsString;
        qryInsert.ParamByName('REGIST').AsString := cdsItensREGIST.AsString;
        qryInsert.ParamByName('DESCON').AsString := cdsItensDESCON.AsString;
        qryInsert.ParamByName('NUMREG').AsString := cdsItensNUMREG.AsString;
        qryInsert.ParamByName('AUTDES').AsString := cdsItensAUTDES.AsString;
        qryInsert.ParamByName('CODMAR').AsString := cdsItensCODMAR.AsString;
        qryInsert.ParamByName('LDD_VLRCOT').AsFloat := cdsItensLDD_VLRCOT.AsFloat;
        qryInsert.ParamByName('LDD_DTACOT').AsDateTime := cdsItensLDD_DTACOT.AsDateTime;
        qryInsert.ParamByName('LDD_PRVDLR').AsFloat  := cdsItensLDD_PRVDLR.AsFloat;
        qryInsert.ParamByName('LDD_ORCVIN').AsString := cdsItensLDD_ORCVIN.AsString;
        qryInsert.ParamByName('LDD_EMPORC').AsString := cdsItensLDD_EMPORC.AsString;
        qryInsert.ExecSQL;

        qryInsertLog.ParamByName('AUTINC').AsString := fRetAutoIncrem('LOGLDT', VS_strCodEmp);;
        qryInsertLog.ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;;
        qryInsertLog.ParamByName('LINGRU').AsString := cdsItensCODGRU.AsString;
        qryInsertLog.ParamByName('OBSERV').AsString := cdsItensOBSERV.AsString;
        qryInsertLog.ParamByName('VALPRE').AsFloat  := cdsItensPREVIS.AsFloat;
        qryInsertLog.ParamByName('KAFORN').AsString := cdsItensKAFORN.AsString;
        qryInsertLog.ParamByName('PREVEN').AsString := cdsItensCODPVE.AsString;
        qryInsertLog.ParamByName('REGIST').AsString := cdsItensREGIST.AsString;
        qryInsertLog.ParamByName('DESCON').AsString := cdsItensDESCON.AsString;
        qryInsertLog.ParamByName('NUMREG').AsString := cdsItensNUMREG.AsString;
        qryInsertLog.ParamByName('AUTDES').AsString := cdsItensAUTDES.AsString;
        qryInsertLog.ParamByName('CODMAR').AsString := cdsItensCODMAR.AsString;
        qryInsertLog.ParamByName('VLRCOT').AsFloat := cdsItensLDD_VLRCOT.AsFloat;
        qryInsertLog.ParamByName('DTACOT').AsDateTime := cdsItensLDD_DTACOT.AsDateTime;
        qryInsertLog.ParamByName('PRVDLR').AsFloat := cdsItensLDD_PRVDLR.AsFloat;
        qryInsertLog.ParamByName('DTALOG').AsDateTime := fNow;
        qryInsertLog.ParamByName('HORLOG').AsDateTime := fNow;
        qryInsertLog.ParamByName('OPELOG').AsString := strLoginUsuarioLogado;
        qryInsertLog.ParamByName('FRMLOG').AsString := Self.Name;
        qryInsertLog.ParamByName('SEQLOG').AsString := FSeqLogLdg;
        qryInsertLog.ExecSQL;

        If (Not fEmptyStr(cdsItensLDD_ORCVIN.AsString)) And (Not fEmptyStr(cdsItensLDD_EMPORC.AsString)) Then
        Begin
          qryFatGor.ParamByName('LINGRU').AsString := cdsItensCODGRU.AsString;
          qryFatGor.ParamByName('NLEADS').AsString := qryTabela.FieldByName('LDG_NUMDOC').AsString;
          qryFatGor.ParamByName('NUMDOC').AsString := cdsItensLDD_ORCVIN.AsString;
          qryFatGor.ParamByName('ESPDOC').AsString := 'OR';
          qryFatGor.ParamByName('CODEMP').AsString := cdsItensLDD_EMPORC.AsString;
          qryFatGor.ExecSQL;
        End;

        cdsItens.Next;
      End;

      fCommit();
    Except
      On E: Exception Do
      Begin
        fRollBack();
        Raise;
      End;
    End;
  Finally
    FreeAndNil(qryFatGor);
    FreeAndNil(qryInsertLog);
    FreeAndNil(qryInsert);

    cdsItens.First;
    cdsItens.EnableControls;
  End;
End;

procedure TfrmCadLeads.btnIncOcorrenciaClick(Sender: TObject);
begin
  inherited;

  If Not objLeads.fPermitidoExecutarOperacao(qryTabela) Then
    Exit;

  pInserirAlterarOcorrencia('Inserir');
end;

procedure TfrmCadLeads.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  if (not fValidaCampos(edtLinGru, True)) Or
     (not fValidaCampos(edtPrevis, True)) Or
     (not fValidaCampos(edtCodPVe, True)) Then
     Exit;

  If fEmptyStr(edtLinGru.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe "Linha/Grupo" para continuar!', ['&O k']);
    Exit;
  End;

  pCalcularPrevisaoOrcamentoDolar;

  if (cdsItens.State = dsBrowse) Then
    cdsItens.Insert;

  cdsItensCODGRU.AsString := edtLinGru.Text;
  cdsItensDESGRU.AsString := edtDesGru.Text;
  cdsItensPREVIS.AsFloat  := fStrToFloat(edtPrevis.Text);
  cdsItensOBSERV.AsString := edtObserv.Text;
  cdsItensKAFORN.AsString := edtNomKam.Text;
  cdsItensCODPVE.AsString := edtCodPVe.Text;
  cdsItensNOMPVE.AsString := edtNomPVe.Text;
  cdsItensREGIST.AsString := IfThen(ckbRegist.Checked, 'S', 'N');
  cdsItensNUMREG.AsString := edtNumReg.Text;
  cdsItensDESCON.AsString := IfThen(ckbDescont.Checked, 'S', 'N');
  cdsItensAUTDES.AsString := edtAutDes.Text;
  cdsItensCODMAR.AsString := edtCodMar.Text;
  cdsItensDESMAR.AsString := edtDesMar.Text;
  cdsItensLDD_PRVDLR.AsFloat := fStrToFloat(edtPrevisDolar.Text);
  If Not fEmptyDate(mskDtaCot.Text) Then
    cdsItensLDD_DTACOT.AsDateTime := StrToDateTime(mskDtaCot.Text);
  cdsItensLDD_VLRCOT.AsFloat := fStrToFloat(edtValorCotacao.Text);
  cdsItensLDD_ORCVIN.AsString := edtOrcVin.Text;
  cdsItensLDD_EMPORC.AsString := IIF(Not fEmptyStr(edtOrcVin.Text), edtCodEmpOrcVin.Text, '');
  cdsItens.Post;

  qryTabela.FieldByName('LDG_TOTVPR').AsFloat := fDoubleAggregate(cdsItens, 'TOT_PREVIS');

  pLimpaItens;

  cxgItens.Enabled := True;

  pSetFocus(edtLinGru);

end;

procedure TfrmCadLeads.btnAlterarClick(Sender: TObject);
begin
  If Not objLeads.fPermitidoExecutarOperacao(qryTabela) Then
    Exit;

  inherited;
  If blnAlterou Then
    pPreencherTotalPrevisaoOrcamento;

  pSetarObjLeads;
  pCarregarDadosCotacao;

  pSetFocus(dbeNomPro);
end;

procedure TfrmCadLeads.btnAnexosClick(Sender: TObject);
  Var
    SPath: String;
begin
  inherited;

  SPath := IncludeTrailingPathDelimiter(fCfgSis('PLEADS'));
  If fEmptyStr(SPath) Then
  Begin
    fMensagem('', 'A configuração "CFG_PLEADS" está em branco!', ['&OK']);
    Exit;
  End;

  If not DirectoryExists(SPath) Then
  Begin
    fMensagem('', 'A configuração "CFG_PLEADS" está configurada com um diretório inexistente ou inacessível!', ['&OK']);
    Exit;
  End;

  Try
    SPath := SPath + qryTabela.FieldByName('AUTOINCREM').AsString + '_' +
                     qryTabela.FieldByName('LDG_NUMDOC').AsString + '_' +
                     qryTabela.FieldByName('LDG_CODEMP').AsString + '\';

    If not DirectoryExists(SPath) Then
    Begin
      TDirectory.CreateDirectory(SPath);

      If not DirectoryExists(SPath) Then
      Begin
        fMensagem('', 'Não foi possível criar o diretório para o lead atual, verifique a permissão ao diretorio da "CFG_PLEADS"!', ['&OK']);
        Exit;
      End;
    End;

  Except
    On E : Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmCadLeads.btnAnexosClick_TDirectory.CreateDirectory');
      Exit;
    End;
  End;

  frmGravaArquivoPasta := TfrmGravaArquivoPasta.Create(Self);
  Try
    frmGravaArquivoPasta.strCaminhoPasta := SPath;
    frmGravaArquivoPasta.bTodasExtensoes := True;
    frmGravaArquivoPasta.Caption         := 'Pasta ( Anexos do Lead '+ qryTabela.FieldByName('LDG_NUMDOC').AsString + ' )';
    frmGravaArquivoPasta.ShowModal;
  Finally
    FreeAndNil(frmGravaArquivoPasta);
  End;

end;

procedure TfrmCadLeads.btnCalcPrevOrcDolarClick(Sender: TObject);
begin
  inherited;

  pCarregarDadosCotacao;
  pCalcularPrevisaoOrcamentoDolar;
end;

procedure TfrmCadLeads.btnCancelaClick(Sender: TObject);
begin
  inherited;
  if qryTabela.IsEmpty Then
  Begin
    pLimpaCampos;
  End
  Else
  Begin
    pLimpaItens;
    fVerificaCampos;
    pCarregaCliente;
    pCarregaLadDet;
    pCarregaHistorioOcorrencia;
    pCarregarDadosCotacao;
  End;

  pAtualizaInformacoesGeraisDoLead;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadLeads.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimpaItens;
  pCarregarDadosCotacao;
  cdsItens.Cancel;
  cxgItens.Enabled := True;
  pSetFocus(edtLinGru);
end;

procedure TfrmCadLeads.btnContatosClick(Sender: TObject);
begin
  inherited;
  TfrmContatoLeads.fCadContatoLead(strCodCli);
end;

procedure TfrmcadLeads.pLimpaItens;
Begin
  edtLinGru.Clear;
  edtDesGru.Clear;
  edtPrevis.Text := '0,00';
  edtObserv.Clear;
  edtNomKam.Clear;
  edtCodPVe.Clear;
  edtNomPVe.Clear;
  ckbRegist.Checked := False;
  edtNumReg.Clear;
  ckbDescont.Checked := False;
  edtAutDes.Clear;
  edtCodMar.Clear;
  edtDesMar.Clear;
  edtPrevisDolar.Text := '0,00';
  edtOrcVin.Clear;
  edtCodEmpOrcVin.Text := VS_strCodEmp;
  edtNomEmpOrcVin.Text := VS_strRazSoc;
End;

procedure TfrmCadLeads.pOnStateChange;
begin
  inherited;
  cxgItens.Enabled        := btnGravar.Enabled;
  btnAdicionar.Enabled    := btnGravar.Enabled;
  btnCancelaItem.Enabled  := btnGravar.Enabled;
  btnContatos.Enabled     := btnGravar.Enabled;
  btnOrcamento.Enabled    := qryTabela.Active And
                           (not (qryTabela.State in dsEditModes)) And
                           (not fEmptyStr(qryTabela.FieldByName('LDG_NUMDOC').AsString));
  btnOrcamentos.Enabled   := btnOrcamento.Enabled;
  btnVincularOrc.Enabled  := btnOrcamento.Enabled;
  btnFinalizarLead.Enabled:= btnOrcamento.Enabled;
  btnAnexos.Enabled       := btnOrcamento.Enabled;
  btnIncOcorrencia.Enabled:= (qryTabela.FieldByName('LDG_CODCLI').AsString <> '');
  btnCalcPrevOrcDolar.Enabled := btnGravar.Enabled;
end;

procedure TfrmCadLeads.btnExcluirClick(Sender: TObject);
begin

  Try
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    inherited;

    if blnExcluiu Then
    Begin
      fCommit();
      pLimpaCampos;
      pAtualizaInformacoesGeraisDoLead;
    End
    Else
    Begin
      fRollBack();
      if fVerificaCampos Then
      Begin
        pFormataCampos;
        pCarregaCliente;
        pCarregaLadDet;
        pCarregaHistorioOcorrencia;
      End;
    End;

  Except
    On E : Exception Do
    Begin
      fRollBack();
      pMensagensErro(E.Message, 'btnGravarClick');
    End;
  End;
end;

procedure TfrmCadLeads.btnFinalizarLeadClick(Sender: TObject);
begin
  inherited;
  Case objLeads.StatusLead  of
    slAndamento,
    slAberto,
    slFaturamentoParcial: pAlterarStatusLeadParaFinalizado;
    slFinalizado        : pAlterarStatusLeadParaAndamento;
  End;
  qryTabela.Close;
  qryTabela.Open;
end;

procedure TfrmCadLeads.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  Try
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

    if fEmptyStr(qryTabela.FieldByName('LDG_NUMDOC').AsString) Then
      qryTabela.FieldByName('LDG_NUMDOC').AsString   := fProximoCodigo;

    qryTabela.FieldByName('LDG_ULTALT').AsDateTime  := fNow();

    inherited;

    If blnGravou Then
    Begin
      pGravarLogLadGer;

      If fGravaLadDet Then
        fCommit()
      Else
        fRollBack();
    End;

    pSetarObjLeads;
  Except
    On E : Exception Do
    Begin
      fRollBack();
      pMensagensErro(E.Message, 'btnGravarClick');
    End;
  End;
end;

procedure TfrmCadLeads.pSetarObjLeads;
Begin
  objLeads.Tip_Fc := strTip_Fc;
  objLeads.pSetDadosLead(qryTabela);
  objLeads.strNomeFrmOrigem := Self.Name;
End;

procedure TfrmCadLeads.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pLimpaCampos;

  pHabilitaCodigo(dbeNumDoc, dbeCodEmp, False);
  qryTabela.FieldByName('LDG_CODCLI').AsString   := strCodCli;
  qryTabela.FieldByName('LDG_CODEMP').AsString   := VS_strCodEmp;
  qryTabela.FieldByName('LDG_DTACAD').AsDateTime := fNow();
  qryTabela.FieldByName('LDG_REGIST').AsString   := 'N';
  qryTabela.FieldByName('LDG_DESCON').AsString   := 'N';
  qryTabela.FieldByName('LDG_STATUS').AsString   := 'B'; //Aberto
  qryTabela.FieldByName('LDG_ULTALT').AsDateTime   := fNow();

  pFormataCampos;

  pCarregaCliente;
  pCarregarDadosCotacao;
  pCarregaHistorioOcorrencia;
  pAtualizaInformacoesGeraisDoLead;
  pSetarObjLeads;
  pSetFocus(dbeCodCli);

end;

procedure TfrmCadLeads.btnOrcamentoClick(Sender: TObject);
begin
  inherited;

  If Not objLeads.fPermitidoExecutarOperacao(qryTabela) Then
    Exit;

  If Assigned(prcSetaNumLead) Then
    prcSetaNumLead(qryTabela.FieldByName('LDG_NUMDOC').AsString);

  prcChamaOrcamento(Sender, dbeCodCli.text, qryTabela.FieldByName('LDG_NUMDOC').AsString);
end;

procedure TfrmCadLeads.btnOrcamentosClick(Sender: TObject);
begin
  inherited;
  TfrmCadLeadOrcamentos.pMostraOrcamentos(objLeads, True);
  objLeads.pAtualizaStatusLeadAndamento(qryTabela.FieldByName('AUTOINCREM').AsString, qryTabela.FieldByName('LDG_NUMDOC').AsString);
  qryTabela.Close;
  qryTabela.Open;
  pAtualizaInformacoesGeraisDoLead;
end;

procedure TfrmCadLeads.pFormataCampos;
Begin
  TDateTimeField(qryTabela.FieldByName('LDG_DTACAD')).EditMask := '99/99/9999';
  TDateTimeField(qryTabela.FieldByName('LDG_INIOBR')).EditMask := '99/99/9999';
  TDateTimeField(qryTabela.FieldByName('LDG_PREORC')).EditMask := '99/99/9999';
  TDateTimeField(qryTabela.FieldByName('LDG_DTAFLW')).EditMask := '99/99/9999';
  TFloatField(qryTabela.FieldByName('LDG_TOTVPR')).DisplayFormat := '#,##0.00';
End;

procedure TfrmCadLeads.pGravarLogLadGer;
var
  qryInsert: TUniQuery;
begin
  qryInsert := fCriaQuery;

  Try
    qryInsert.Close;
    qryInsert.SQL.Clear;
    qryInsert.SQL.Add(' INSERT INTO LOGLDG(AUTOINCREM, LOG_DTALOG, LOG_HORLOG, LOG_OPELOG, ' +
                      ' LOG_FRMLOG, LOG_INIOBR, LOG_VENEXT, LOG_CODFAS, LOG_PREORC,        ' +
                      ' LOG_REGIST, LOG_DESCON, LOG_NOMPRO, LOG_CODINS, LOG_TOTVPR, LOG_STATUS, ' +
                      ' LOG_CODVEN, LOG_ULTALT, LOG_SEQLDG, LOG_CODEMP) ');

    qryInsert.SQL.Add(' VALUES(:AUTOINCREM, :DTALOG, :HORLOG, :OPELOG, ' +
                      ' :FRMLOG, :INIOBR, :VENEXT, :CODFAS, :PREORC,   ' +
                      ' :REGIST, :DESCON, :NOMPRO, :CODINS, :TOTVPR,   ' +
                      ' :STATUS, :CODVEN, :ULTALT, :SEQLDG, :CODEMP)   ');

    FSeqLogLdg := fRetAutoIncrem('LOGLDG', VS_strCodEmp);
    qryInsert.ParamByName('AUTOINCREM').AsString := FSeqLogLdg;
    qryInsert.ParamByName('DTALOG').AsDateTime := fNow();
    qryInsert.ParamByName('HORLOG').AsDateTime := fNow();
    qryInsert.ParamByName('OPELOG').AsString := strLoginUsuarioLogado;
    qryInsert.ParamByName('FRMLOG').AsString := Self.Name;
    qryInsert.ParamByName('INIOBR').AsDateTime := qryTabela.FieldByName('LDG_INIOBR').AsDateTime;
    qryInsert.ParamByName('VENEXT').AsString := qryTabela.FieldByName('LDG_VENEXT').AsString;
    qryInsert.ParamByName('CODFAS').AsString := qryTabela.FieldByName('LDG_CODFAS').AsString;
    qryInsert.ParamByName('PREORC').AsDateTime := qryTabela.FieldByName('LDG_PREORC').AsDateTime;
    qryInsert.ParamByName('REGIST').AsString := qryTabela.FieldByName('LDG_REGIST').AsString;
    qryInsert.ParamByName('DESCON').AsString := qryTabela.FieldByName('LDG_DESCON').AsString;
    qryInsert.ParamByName('NOMPRO').AsString := qryTabela.FieldByName('LDG_NOMPRO').AsString;
    qryInsert.ParamByName('CODINS').AsString := qryTabela.FieldByName('LDG_CODINS').AsString;
    qryInsert.ParamByName('TOTVPR').AsFloat := qryTabela.FieldByName('LDG_TOTVPR').AsFloat;
    qryInsert.ParamByName('STATUS').AsString := qryTabela.FieldByName('LDG_STATUS').AsString;
    qryInsert.ParamByName('CODVEN').AsString := qryTabela.FieldByName('LDG_CODVEN').AsString;
    qryInsert.ParamByName('ULTALT').AsDateTime := qryTabela.FieldByName('LDG_ULTALT').AsDateTime;
    qryInsert.ParamByName('SEQLDG').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryInsert.ParamByName('CODEMP').AsString := qryTabela.FieldByName('LDG_CODEMP').AsString;
    qryInsert.ExecSQL;

  Finally
    FreeAndNil(qryInsert);
  End;
end;

procedure TfrmCadLeads.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    chrKey: Char;
begin
  chrKey := '?';
//  inherited;
  If fPesqLeads(Self, Nil, Nil, qryTabela, chrKey, arrSel, True, strCodCli) Then
  Begin
    if fVerificaCampos Then
    Begin
      pFormataCampos;
      pCarregaCliente;
      pCarregaLadDet;
      pCarregaHistorioOcorrencia;
      pOnStateChange;
      pAtualizaInformacoesGeraisDoLead;
      If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
        pSetFocus(btnAlterar);
    End;
  End
end;

procedure TfrmCadLeads.btnVincularOrcClick(Sender: TObject);
begin
  inherited;

  If Not objLeads.fPermitidoExecutarOperacao(qryTabela) Then
    Exit;

  TfrmCadLeadVincularOrcamentos
    .pAbrirTelaVincularOrcamentos(objLeads);

  objLeads.pAtualizaStatusLeadAndamento(qryTabela.FieldByName('AUTOINCREM').AsString, qryTabela.FieldByName('LDG_NUMDOC').AsString);
  pAtualizaInformacoesGeraisDoLead;
end;

procedure TfrmCadLeads.cdsItensAfterDelete(DataSet: TDataSet);
begin
  inherited;
  qryTabela.FieldByName('LDG_TOTVPR').AsFloat := fDoubleAggregate(cdsItens, 'TOT_PREVIS');
end;

procedure TfrmCadLeads.cdsItensCalcFields(DataSet: TDataSet);
begin
  inherited;

  If Not fEmptyStr(cdsItensCODMAR.AsString) Then
    cdsItensMARCA.AsString := cdsItensCODMAR.AsString + ' - ' + cdsItensDESMAR.AsString;

  If Not fEmptyStr(cdsItensLDD_ORCVIN.AsString) Then
    cdsItensORCVIN.AsString := cdsItensLDD_ORCVIN.AsString + '-' + cdsItensLDD_EMPORC.AsString
  Else
    cdsItensORCVIN.AsString := '';
end;

procedure TfrmCadLeads.ckbDescontClick(Sender: TObject);
begin
  inherited;
  edtAutDes.Enabled := ckbDescont.Checked;
end;

procedure TfrmCadLeads.ckbRegistClick(Sender: TObject);
begin
  inherited;
  edtNumReg.Enabled := ckbRegist.Checked;
end;

procedure TfrmCadLeads.cxgItensDBTableViewCitel1DblClick(Sender: TObject);
begin
  inherited;
  pCarregaItemEdicao;
End;

procedure TfrmCadLeads.pCarregaItemEdicao;
Begin
  if (not cdsItens.Active) or (cdsItens.IsEmpty) Then
    Exit;

  if (not cxgItens.Enabled) Then
  Begin
    fMensagem('', 'Confirme ou cancele o item em edição para editar outro!', ['&OK']);
    Exit;
  End;

  pLimpaItens;
  cdsItens.Cancel;
  cdsItens.Edit;

  edtLinGru.Text    := cdsItensCODGRU.AsString;
  edtDesGru.Text    := cdsItensDESGRU.AsString;
  edtCodMar.Text    := cdsItensCODMAR.AsString;
  edtDesMar.Text    := cdsItensDESMAR.AsString;
  edtPrevis.Text    := FormatFloat('#,##0.00', cdsItensPREVIS.AsFloat);
  edtObserv.Text    := cdsItensOBSERV.AsString;
  edtNomKam.Text    := cdsItensKAFORN.AsString;
  edtCodPVe.Text    := cdsItensCODPVE.AsString;
  edtNomPVe.Text    := cdsItensNOMPVE.AsString;

  ckbRegist.Checked := (cdsItensREGIST.AsString = 'S');
  edtNumReg.Text := cdsItensNUMREG.AsString;
  ckbDescont.Checked := (cdsItensDESCON.AsString = 'S');
  edtAutDes.Text := cdsItensAUTDES.AsString;

  edtAutDes.Enabled := ckbDescont.Checked;
  edtNumReg.Enabled := ckbRegist.Checked;

  edtPrevisDolar.Text := FormatFloat('#,##0.00', cdsItensLDD_PRVDLR.AsFloat);
  mskDtaCot.Text := cdsItensLDD_DTACOT.AsString;
  edtValorCotacao.Text := FormatFloat('#,##0.00', cdsItensLDD_VLRCOT.AsFloat);

  edtOrcVin.Text       := cdsItensLDD_ORCVIN.AsString;
  edtCodEmpOrcVin.Text := cdsItensLDD_EMPORC.AsString;
  edtNomEmpOrcVin.Text := fRetNomeEmpresa(cdsItensLDD_EMPORC.AsString);
  cxgItens.Enabled := False;


  pSetFocus(edtLinGru);

end;

procedure TfrmCadLeads.cxgItensDBTableViewCitel1KeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
  Begin
    if (cdsItens.Active) And (not cdsItens.IsEmpty) Then
    Begin
      if fMensagem('', 'Deseja excluir esse item?', ['&Sim', '&Não'], 2) = 1 Then
        cdsItens.Delete;
    End;
  End
  Else If (Key = VK_RETURN) Then
  Begin
    pCarregaItemEdicao;
  End;
end;

procedure TfrmCadLeads.dbeCodCatKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCateg : TConsultasArray;
begin
  inherited;

  If fPesqCategoriaOrPd(Self, dbeCodCat, edtNomCat, Nil, Key, arrCateg, True, '', True) Then
  Begin
    If fValidaCampos(dbeCodCat, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadLeads.dbeCodCliKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFase : TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, dbeCodCli, edtNomCli, Nil, Key, arrFase) Then
  Begin
    If fValidaCampos(dbeCodCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadLeads.dbeCodFasKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFase : TConsultasArray;
begin
  inherited;
  If fPesqFaseObra(Self, dbeCodFas, edtNomFas, Nil, Key, arrFase) Then
  Begin
    If fValidaCampos(dbeCodFas, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadLeads.dbeCodInsKeyPress(Sender: TObject; var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, dbeCodIns, edtNomIns, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(dbeCodIns, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadLeads.dbeVenExtChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadOpe(Key);
end;

procedure TfrmCadLeads.pPesquisaPadraoOperador(objEdit: TDBEditFocus; var Key: Char; arrSel : TConsultasArray);
var
  objEditNome: TEditFocus;
begin
  objEditNome := edtNomExt;
  if objEdit = edtCodVen then
    objEditNome := edtNomVen;

  if fPesqOperador(Self, objEdit, objEditNome, Nil, Key, arrSel) then
  Begin
    If fValidaCampos(objEdit, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadLeads.fPesquisarOperadorSemClienteInformado(objEdit: TDBEditFocus; var Key: Char; arrSel : TConsultasArray): Boolean;
begin
  if not dbeCodCli.Field.AsString.IsEmpty then
    Exit(False);

  pPesquisaPadraoOperador(objEdit, Key, arrSel);
  Result := True;
end;

function TfrmCadLeads.fPesquisarOperadorSeNenhumVendedorVinculadoAoCliente(objEdit: TDBEditFocus; var Key: Char; arrSel : TConsultasArray): Boolean;
begin
  if not fRetNomVendRep(String.Empty, String.Empty, dbeCodCli.text).IsEmpty then
    Exit(False);

  pPesquisaPadraoOperador(objEdit, Key, arrSel);
  Result := True;
end;

procedure TfrmCadLeads.pPesquisarVendedoresVinculadosAoCliente(objEdit: TDBEditFocus; var Key: Char; arrSel : TConsultasArray);
var
  strRetornoPesquisa: string;
begin
  strRetornoPesquisa := fPesquisaCliVendedores(dbeCodCli.Field.AsString);
  key := #0;

  if strRetornoPesquisa.IsEmpty then
    Exit;

  objEdit.Field.AsString := strRetornoPesquisa;

  If fValidaCampos(objEdit, True) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadLeads.dbeVenExtKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  pKeyPressCodigoVendedorGenerico(Sender, Key);
end;

procedure TfrmCadLeads.dbgMovOcorrDBTableView1DblClick(Sender: TObject);
begin
  inherited;
  pInserirAlterarOcorrencia('Alterar');
end;

procedure TfrmCadLeads.dbgMovOcorrDBTableView1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Case Key Of
      VK_RETURN: pInserirAlterarOcorrencia('Alterar');
  End;

  inherited;

end;

procedure TfrmCadLeads.edtCodPVeKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, edtCodPVe, edtNomPVe, nil, Key, arrSel) then
  Begin
    If fValidaCampos(edtCodPVe, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmCadLeads.edtCodVenChamaCadastro(Key: Word): string;
begin
  inherited;
  Result := fChamaCadOpe(Key);
end;

procedure TfrmCadLeads.edtCodVenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  pKeyPressCodigoVendedorGenerico(Sender, Key);
end;

procedure TfrmCadLeads.edtLinGruKeyPress(Sender: TObject; var Key: Char);
  Var
    arrLinGru : TConsultasArray;
begin
  inherited;
  If fPesqGrupo(Self, edtLinGru, edtDesGru, Nil, Key, arrLinGru, False, False, False) Then
  Begin
    If fValidaCampos(edtLinGru, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadLeads.edtOrcVinKeyPress(Sender: TObject; var Key: Char);
  Var
    qryRetorno : TUniQuery;
    arrDocumento : TConsultasArray;
begin
  inherited;

  qryRetorno := fCriaQuery;
  Try
    If fPesqPedOrc(conPedCompleta, Self, 'OR', 'OR', '', edtOrcVin,  nil, edtCodEmpOrcVin, qryRetorno, Key, arrDocumento, True, Nil, dbeCodCli.Text, 'N', '', True) Then
    Begin
      If fValidaCampos(edtOrcVin, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  Finally
    FreeAndNil(qryRetorno);
  End;
end;

procedure TfrmCadLeads.edtPrevisExit(Sender: TObject);
begin
  inherited;

  pCalcularPrevisaoOrcamentoDolar;
end;

class procedure TfrmCadLeads.fCadLeads(strCodCli: String;
  prcChamaOrcamentoP : TProcedureChamaOrcamento;  prcSetaNumLeadP : TProcedureSetaNumLead;
  Chave: String = ''; strTip_Fc: String = 'C');
var
    frmCadLeads: TfrmCadLeads;
begin
  Try
    pCriarFormularios(TfrmCadLeads, frmCadLeads);
    frmCadLeads.strCodCli := strCodCli;
    frmCadLeads.prcChamaOrcamento := prcChamaOrcamentoP;
    frmCadLeads.prcSetaNumLead    := prcSetaNumLeadP;
    frmCadLeads.strTip_Fc := strTip_Fc;
    If Chave <> '' Then
    Begin
      frmCadLeads.dbeCodCli.Text := strCodCli;
      frmCadLeads.strSqlPesq:= 'SELECT * FROM LADGER WHERE LADGER.AUTOINCREM = '+QuotedStr(Chave)+'';
      frmCadLeads.blnCarregaLeadsDoAtalhoPesq:= True;
    End;
    frmCadLeads.ShowModal;
    frmCadLeads.prcSetaNumLead('');
  Finally
    pFreeAndNil(frmCadLeads);
  End;
end;


class procedure TfrmCadLeads.fCadLeads(prcChamaOrcamentoP: TProcedureChamaOrcamento;
  aObjLeads: ILeads);
var
  frmCadLeads: TfrmCadLeads;
begin
  Try
    pCriarFormularios(TfrmCadLeads, frmCadLeads);
    frmCadLeads.strCodCli := aObjLeads.strCodCli;
    frmCadLeads.objLeads := aObjLeads;
    frmCadLeads.prcChamaOrcamento := prcChamaOrcamentoP;
    frmCadLeads.strTip_Fc := aObjLeads.Tip_Fc;
    If Not fEmptyStr(aObjLeads.strAutInc) Then
    Begin
      frmCadLeads.dbeCodCli.Text := aObjLeads.strCodCli;
      frmCadLeads.strSqlPesq:= 'SELECT * FROM LADGER WHERE LADGER.AUTOINCREM = '+ QuotedStr(aObjLeads.strAutInc)+'';
      frmCadLeads.blnCarregaLeadsDoAtalhoPesq:= True;
    End;
    frmCadLeads.ShowModal;
  Finally
    pFreeAndNil(frmCadLeads);
  End;

end;

function TfrmCadLeads.fExecutaAntesDoDelete: Boolean;
Var qryDelete : TUniQuery;
begin
  Result := True;
  try
    Try
      qryDelete := fCriaQuery;
      With qryDelete, SQL Do
      Begin
        Close;
        Clear;
        Add('SELECT * FROM LADDET WHERE LDD_SEQGER = :SEQGER ');
        ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
        Open;

        While Not Eof Do
        Begin
          fVerificaIntegridade(Self.Name, 'LADDET', qryDelete);
          qryDelete.Delete;
        End;
      End;
    Finally
      FreeAndNil(qryDelete);
    End;
  Except
    On E : Exception Do
    begin
      Result := False;
      pMensagensErro(E.Message, 'TfrmCadLeads.fExecutaAntesDoDelete');
    end;
  End;
end;

procedure TfrmCadLeads.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela := 'LADGER';
  strNomeCampo  := 'LDG_NUMDOC';
  qryTabela     := fCriaQuery();
  dtsTabela.DataSet := qryTabela;
  qryOcorre     := fCriaQuery();
  SetLength(arrCamposChave, 2);
  blnCarregaLeadsDoAtalhoPesq:= False;
  strSqlPesq:= '';
  arrCamposChave[0] := dbeNumDoc;
  arrCamposChave[1] := dbeCodEmp;
  objLeads := TLeads.New();
  objLeads.strNomeFrmOrigem := Self.Name;
  qryCotacao := fCriaQuery();
  qryCotacao.DisableControls;
  qryCotacao.SQL.Add('SELECT  MOE_DTAMOE, MOE_DOLCOM ' +
                     'FROM CADMOE ' +
                     'WHERE MOE_DTAMOE = :DATA');
  qryCotacao.Prepare;

  Self.Position    := poScreenCenter;
  Self.WindowState := wsMaximized;
end;

procedure TfrmCadLeads.pCarregarDadosCotacao;
Begin
  edtValorCotacao.Clear;
  edtPrevisDolar.Clear;
  mskDtaCot.Clear;


  qryCotacao.ParamByName('DATA').AsDateTime := Today;
  qryCotacao.Open;
  If Not (qryCotacao.IsEmpty) Then
  Begin
    edtValorCotacao.Text := qryCotacao.FieldByName('MOE_DOLCOM').AsString;
    mskDtaCot.Text := qryCotacao.FieldByName('MOE_DTAMOE').AsString;
  End;
End;

procedure TfrmCadLeads.pCalcularPrevisaoOrcamentoDolar;
begin
  If fStrToFloat(edtPrevis.Text) <= 0 Then
   Exit;

  If fStrToFloat(edtValorCotacao.Text) <= 0 Then
   Exit;

  edtPrevisDolar.Text := FormatFloat('#,##0.00', (fStrToFloat(edtPrevis.Text) /  fStrToFloat(edtValorCotacao.Text)) );
end;

procedure TfrmCadLeads.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryOcorre);
  FreeAndNil(qryCotacao);
  inherited;

end;

procedure TfrmCadLeads.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_F1) AND (btnIncOcorrencia.Enabled)  then
    btnIncOcorrencia.OnClick(Sender);
  inherited;

end;

procedure TfrmCadLeads.FormShow(Sender: TObject);
  var
    objCategoriaCadLead: TCategoriaCadLead;
begin
  inherited;
  objLeads.Tip_Fc := strTip_Fc;

  {So entrará nesta condição se a tela de cadastro de Leads for chamada através
  da consulta de Leads opção ctrl + F11. Pois faz-se necessário manter o resultado
  da pesquisa.}
  If blnCarregaLeadsDoAtalhoPesq Then
  Begin

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add(strSqlPesq);
    qryTabela.Open;

    If fVerificaCampos Then
    Begin
      pFormataCampos;
      pCarregaCliente;
      pCarregaLadDet;
      pCarregaHistorioOcorrencia;
      pOnStateChange;
      pAtualizaInformacoesGeraisDoLead;
      pSetarObjLeads;
    End;

    blnCarregaLeadsDoAtalhoPesq:= False;

  End;

  objCategoriaCadLead:= TCategoriaCadLead.Create;
  Try
    objCategoriaCadLead.blnUtiCat:= fCfgSis('UTICAO', varBoolean) Or fCfgSis('UTICAP', varBoolean);
    pnlCategoria.Visible := objCategoriaCadLead.fExibeCategoriaNaTelaLead;
  Finally
    FreeAndNil(objCategoriaCadLead);
  End;

  edtOrcVin.Visible       := fCfgSis('VIORLG', varBoolean);
  edtCodEmpOrcVin.Visible := fCfgSis('VIORLG', varBoolean);
  edtNomEmpOrcVin.Visible := fCfgSis('VIORLG', varBoolean);
  lblOrcVin.Visible       := fCfgSis('VIORLG', varBoolean);
  lblEmpOrcVin.Visible    := fCfgSis('VIORLG', varBoolean);

  cxgItensDBTableViewCitel1LDD_PRVDLR.Visible := fCfgSis('VIORLG', varBoolean);

  edtCodEmpOrcVin.Text := VS_strCodEmp;
  edtNomEmpOrcVin.Text := VS_strRazSoc;
end;

function TfrmCadLeads.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  var
    qryConsTemp: TUniQuery;
    objCategoriaCadLead: TCategoriaCadLead;
    strFgoLinGru : String;
    strFgoLeads  : String;
begin
  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If (Sender = dbeCodCli) Then
    Begin
      If fEmptyStr(dbeCodCli.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do cliente deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        edtNomCli.Text := fRetNomCliente(dbeCodCli.Text);
        If fEmptyStr(edtNomCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse cliente não está cadastrado!', ['&O k']);
          Result := False;
        End;
        pCarregaCliente;
      End;

    End
    Else If (Sender = dbeCodCat) Then
    Begin
      qryConsTemp:= fCriaQuery;
      Try

        objCategoriaCadLead:= TCategoriaCadLead.Create;
        Try

          objCategoriaCadLead.blnUtiCat := fCfgSis('UTICAO', varBoolean) Or fCfgSis('UTICAP', varBoolean);
          objCategoriaCadLead.strCodigoCategoria:= dbeCodCat.Text;

          qryConsTemp.Close;
          qryConsTemp.SQL.Clear;
          qryConsTemp.SQL.Add(objCategoriaCadLead.fRetornaSQLCategoria);
          qryConsTemp.Open;

          Try
            objCategoriaCadLead.strDescricao:= qryConsTemp.FieldByName('CAT_DESCRI').AsString;
            objCategoriaCadLead.pValidaExisteCategoria;
          Except
            On E : Exception Do
            Begin
              pMensagemOk(E.Message);
              Result:= False;
              Exit;
            End;
          End;

          Try
            objCategoriaCadLead.strCategoriaLead:= qryConsTemp.FieldByName('CAT_LEDPER').AsString;
            objCategoriaCadLead.pValidaCategoriaEhLead;
          Except
            On E : Exception Do
            Begin
              pMensagemOk(E.Message);
              Result:= False;
              Exit;
            End;
          End;

          edtNomCat.Text:= objCategoriaCadLead.strDescricao;

        Finally
          FreeAndNil(objCategoriaCadLead);
        End;

      Finally
        FreeAndNil(qryConsTemp);
      End;

    End
    Else If (Sender = dbeVenExt) Then
    Begin
      If fEmptyStr(dbeVenExt.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do vendedor externo deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        edtNomExt.Text := fRetNomVendRep(dbeVenExt.Text);
        If fEmptyStr(edtNomExt.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = edtCodVen) Then
    Begin
      If fEmptyStr(edtCodVen.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do vendedor deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        edtNomVen.Text := fRetNomVendRep(edtCodVen.Text);
        If fEmptyStr(edtNomVen.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = dbeCodIns) Then
    Begin
      If fEmptyStr(dbeCodIns.Text) Then
        edtNomIns.Text:= '';

      If (Not(fEmptyStr(dbeCodIns.Text))) Then
      Begin
        If fEmptyStr(fRetNomCliente(dbeCodIns.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Instalador não localizado!', ['&O k']);
          edtNomIns.Text:= '';
          dbeCodIns.Text:= '';
          Result := False;
        End
        Else
        Begin
          edtNomIns.Text := fRetNomCliente(dbeCodIns.Text);
          edtTipIns.Text := fRetDescTipoCli(fRetTipoCliente(dbeCodIns.Text));
        End;
      End;
    End
    Else If (Sender = dbeCodFas) Then
    Begin
      If fEmptyStr(dbeCodFas.Text) Then
      Begin
        Result := False;
        edtNomFas.Text := '';
        pMensagemOk('Deve ser selecionado uma Fase da Obra!');
      End
      Else
      Begin
        edtNomFas.Text :=  fRetNomFaseObra(dbeCodFas.Text);

        If fEmptyStr(edtNomFas.Text) Then
        Begin
          Result := False;
          pMensagemOk('O código da Fase da Obra não existe!');
        End;

      End;

    End
    Else If (Sender = dbePreOrd) Then
    Begin
      if fEmptyDate(dbePreOrd.Text) Then
        Result := fMensagem('', 'Informe a data de previsão do orçamento!', ['&OK']) = 2;
    End
    Else If (Sender = edtLinGru) And blnBuscaPorChave Then
    Begin

      If fEmptyStr(edtLinGru.Text) Then
      Begin
        if (cdsItens.State in dsEditModes) Then
        Begin
          edtDesGru.Clear;
          fMensagem('ATENÇÃO!', 'Informe o grupo para continuar!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          //SE NAO ESTIVER EDITANDO O ITEM, PASSA DIRETO PARA A PARTE DE BAIXO DO CADASTRO!!!
          pSetFocus(cxgItens);

        End;

      End
      Else
      Begin
        edtDesGru.Text := fRetNomeLinhaGrupo(edtLinGru.Text);
        If fEmptyStr(edtDesGru.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa linha/grupo não está cadastrada!', ['&O k']);
          Result := False;
        End;

      End;

    End
    Else If (Sender = edtPrevis) And blnBuscaPorChave Then
    Begin
      Result := fStrToFloat(edtPrevis.Text) > 0;
      If Not Result Then
        fMensagem('', 'O valor de previsão deve ser maior que zero!', ['&OK']);
    End
    Else If (Sender = edtCodPVe) And blnBuscaPorChave Then
    Begin
      If fEmptyStr(edtCodPVe.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do Pré Venda deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        edtNomPVe.Text := fRetNomVendRep(edtCodPVe.Text);
        If fEmptyStr(edtNomPVe.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse vendedor não está cadastrado!', ['&O k']);
          Result := False;
        End;
      End;

    End
    Else
    If (Sender = edtOrcVin) And (fCfgSis('VIORLG', varBoolean)) Then
    Begin
      If (Not fEmptyStr(edtOrcVin.Text)) Then
      Begin
        If (Not fCarregaOrcamento(edtOrcVin.Text, edtCodEmpOrcVin.Text, dbeCodCli.Text, strFgoLinGru, strFgoLeads)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Documento não encontrado!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If (Not fEmptyStr(strFgoLinGru)) Then
          Begin
            If (cdsItens.State <> dsEdit) Or
               ((cdsItens.State = dsEdit) And (Not fMesmoRegistroLinGru(strFgoLinGru, cdsItensCODGRU.AsString, strFgoLeads, dbeNumDoc.Text))) Then
            Begin
              fMensagem('ATENÇÃO!', 'Orçamento já vinculado a Linha/Grupo "'+strFgoLinGru+'" - Lead "'+strFgoLeads+'"!', ['&O k']);
              Result := False;
            End;
          End
          Else
          Begin
            If (fEncontrouRegistroNaGrade(edtOrcVin.Text, edtCodEmpOrcVin.Text)) Then
            Begin
              fMensagem('ATENÇÃO!', 'Orçamento já vinculado a linha/grupo da grade!', ['&O k']);
              Result := False;
            End;
          End;
        End;
      End;
    End
  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmCadLeads.fEncontrouRegistroNaGrade(strNumOrc: String; strCodEmpOrc: String): Boolean;
  Var
    cdsClone : TUniClientDataSet;
begin
  If (cdsItens.IsEmpty) Then
    Exit(False);

  cdsClone := TUniClientDataSet.Create(Nil);
  Try
    pCloneDataSet(cdsClone, cdsItens);
    cdsClone.Filtered := False;
    cdsClone.Filter   := 'LDD_ORCVIN = '''+strNumOrc+''' AND LDD_EMPORC = '''+strCodEmpOrc+'''';
    cdsClone.Filtered := True;

    Result := Not cdsClone.IsEmpty;
  Finally
    FreeAndNil(cdsClone);
  End;
end;

function TfrmCadLeads.fMesmoRegistroLinGru(strFgoLinGru: String; strCodLinGru: String;
  strFgoLeads: String; strLead: String): Boolean;
begin
  Result := (strFgoLinGru = strCodLinGru) And (strFgoLeads = strLead);
end;

function TfrmCadLeads.fCarregaOrcamento(strNumDoc: String; strCodEmp: String;
  strCodCli: String; var strLinGru: String; var strLeads: String): Boolean;
  Var
    qryExtGor : TUniQuery;
begin
  strLinGru := '';
  strLeads  := '';

  qryExtGor := fCriaQuery;
  Try
    qryExtGor.Close;
    qryExtGor.SQL.Clear;
    qryExtGor.SQL.Add(' SELECT ');
    qryExtGor.SQL.Add('   E.FGO_LINGRU, ');
    qryExtGor.SQL.Add('   E.FGO_NLEADS ');
    qryExtGor.SQL.Add(' FROM FATGOR F ');
    qryExtGor.SQL.Add('   INNER JOIN EXTGOR E ON E.FGO_SEQFGO = F.AUTOINCREM  ');
    qryExtGor.SQL.Add(' WHERE F.FGO_NUMDOC = :NUMDOC ');
    qryExtGor.SQL.Add('   AND F.FGO_ESPDOC = :ESPDOC ');
    qryExtGor.SQL.Add('   AND F.FGO_CODEMP = :CODEMP ');
    qryExtGor.SQL.Add('   AND F.FGO_CODCLI = :CODCLI ');
    qryExtGor.ParamByName('NUMDOC').AsString := strNumDoc;
    qryExtGor.ParamByName('ESPDOC').AsString := 'OR';
    qryExtGor.ParamByName('CODEMP').AsString := strCodEmp;
    qryExtGor.ParamByName('CODCLI').AsString := strCodCli;
    qryExtGor.Open;

    Result := Not qryExtGor.IsEmpty;

    If Result Then
    Begin
      strLinGru := qryExtGor.FieldByName('FGO_LINGRU').AsString;
      strLeads  := qryExtGor.FieldByName('FGO_NLEADS').AsString;
    End;
  Finally
    FreeAndNil(qryExtGor);
  End;
end;

procedure TfrmCadLeads.pAlterarStatusLeadParaAndamento;
begin
  If fMensagem('', 'Deseja realmente reabrir o Lead?', ['&Sim', '&Não'], 2) = 2 Then
    Exit;

  objLeads.pAtualizaStatusLeadAndamento(qryTabela.FieldByName('AUTOINCREM').AsString, qryTabela.FieldByName('LDG_NUMDOC').AsString);
  objLeads.pAlterarStatusLead(lblStatusLead, edtDtaFin, edtHorFin, edtOpeFin, btnFinalizarLead, qryTabela.FieldByName('AUTOINCREM').AsString);

  fMensagem('Atenção', 'Lead nº ' + qryTabela.FieldByName('LDG_NUMDOC').AsString + ' reaberto com sucesso!', ['&OK']);
end;

procedure TfrmCadLeads.pAlterarStatusLeadParaFinalizado;
begin
  If objLeads.fExitemOcorrenciasVinculadasAoLeadEmAberto(cdsMovOcorr) Then
  Begin
    objLeads.pExibirMensagemFinalizarLeadEmAberto;
    Exit;
  End;

  If objLeads.fExitemOcorrenciasDosOrcamentosVinculadosAoLeadEmAberto(qryTabela.FieldByName('LDG_NUMDOC').AsString)  Then
  Begin
    objLeads.pExibirMensagemFinalizarLeadEmAberto;
    Exit;
  End;

  objLeads.fFinalizarLead(qryTabela);
  objLeads.pAlterarStatusLead(lblStatusLead, edtDtaFin, edtHorFin, edtOpeFin, btnFinalizarLead, qryTabela.FieldByName('AUTOINCREM').AsString);

  fMensagem('Atenção', 'Lead nº ' + qryTabela.FieldByName('LDG_NUMDOC').AsString + ' finalizado com sucesso!', ['&OK']);
end;

procedure TfrmCadLeads.pAtualizaInformacoesGeraisDoLead;
begin
  objLeads.pAtualizaInformacoesGeraisDoLead(lblStatusLead, btnFinalizarLead, edtDtaFin, edtHorFin, edtOpeFin, qryTabela);
end;

procedure TfrmCadLeads.pCarregaCliente;
  Var
    qryCadCli : TUniQuery;
Begin
  Try
    qryCadCli := fCriaQuery;
    qryCadCli.Close;
    qryCadCli.SQL.Clear;
    qryCadCli.SQL.Add(' SELECT CLI_NOMCLI AS NOMCLI, ');
    qryCadCli.SQL.Add('        CLI_OBSERV AS OBSERV, ');
    qryCadCli.SQL.Add('        CID_NOMCID AS NOMCID, ');
    qryCadCli.SQL.Add('        TIP_DESTIP AS TIPCLI, ');
    qryCadCli.SQL.Add('        CLI_CODVEN AS CODVEN, ');
    qryCadCli.SQL.Add('        OPE_NOMOPE AS NOMVEN  ');
    qryCadCli.SQL.Add(' FROM CADCLI                  ');
    qryCadCli.SQL.Add(' LEFT JOIN CADCID ON CID_CODCID = CLI_CODCID ');
    qryCadCli.SQL.Add(' LEFT JOIN TIPCLG ON TIP_CODTIP = CLI_TIPCLI ');
    qryCadCli.SQL.Add(' LEFT JOIN CADOPE ON OPE_CODOPE = CLI_CODVEN ');
    qryCadCli.SQL.Add(' WHERE CLI_CODCLI = :CODCLI ');
    qryCadCli.ParamByName('CODCLI').AsString := dbeCodCli.Text;
    qryCadCli.Open;

    edtNomCli.Text  := qryCadCli.FieldByName('NOMCLI').AsString;
    mmoCliObs.Texto := qryCadCli.FieldByName('OBSERV').AsString;
    edtCliCid.Text  := qryCadCli.FieldByName('NOMCID').AsString;
    edtCliTip.Text  := qryCadCli.FieldByName('TIPCLI').AsString;

    if (Assigned(edtCodVen.Field)) and
       (edtCodVen.Field.AsString.IsEmpty) and
       (edtCodVen.Field.DataSet.State in dsEditModes) then
    begin
      edtCodVen.Field.AsString  := qryCadCli.FieldByName('CODVEN').AsString;
      edtNomVen.Text  := qryCadCli.FieldByName('NOMVEN').AsString;
    end;

    qryCadCli.Close;

  Finally
    FreeAndNil(qryCadCli);
  End;

End;

procedure TfrmCadLeads.pCarregaHistorioOcorrencia;
begin

  //cdsMovOcorr.EmptyDataSet;
  cdsMovOcorr.Close;
  cdsMovOcorr.CreateDataSet;
  If (qryTabela.FieldByName('AUTOINCREM').AsString <> '') Then
  Begin
    qryOcorre.Close;
    qryOcorre.SQL.Clear;
    qryOcorre.SQL.Add(fRetornaSQLInformacoesOcorrencias(strTip_Fc, qryTabela.FieldByName('AUTOINCREM').AsString));
    qryOcorre.Open;

    qryOcorre.First;
    While Not(qryOcorre.eof) Do
    Begin
      cdsMovOcorr.Insert;
      cdsMovOcorrOCO_PROTOC.AsString   := qryOcorre.FieldByName('OCO_PROTOC').AsString;
      cdsMovOcorrOCO_CODOCO.AsString   := qryOcorre.FieldByName('OCO_CODOCO').AsString;
      cdsMovOcorrOCO_CODTOC.AsString   := qryOcorre.FieldByName('OCO_CODTOC').AsString;
      cdsMovOcorrOCO_CODCLI.AsString   := qryOcorre.FieldByName('OCO_CODCLI').AsString;
      if qryOcorre.FieldByName('OCO_DTAINC').AsDateTime > 0 then
        cdsMovOcorrOCO_DTAINC.AsDateTime := qryOcorre.FieldByName('OCO_DTAINC').AsDateTime
      else
        cdsMovOcorrOCO_DTAINC.IsNull;
      if qryOcorre.FieldByName('OCO_HORINC').AsDateTime > 0 then
        cdsMovOcorrOCO_HORINC.AsDateTime := qryOcorre.FieldByName('OCO_HORINC').AsDateTime
      else
        cdsMovOcorrOCO_HORINC.IsNull;
      if qryOcorre.FieldByName('OCO_DTACON').AsDateTime > 0 then
        cdsMovOcorrOCO_DTACON.AsDateTime := qryOcorre.FieldByName('OCO_DTACON').AsDateTime
      else
        cdsMovOcorrOCO_DTACON.IsNull;
      if qryOcorre.FieldByName('OCO_HORCON').AsDateTime > 0 then
        cdsMovOcorrOCO_HORCON.AsDateTime := qryOcorre.FieldByName('OCO_HORCON').AsDateTime
      else
        cdsMovOcorrOCO_HORCON.IsNull;
      cdsMovOcorrOCO_CODOPE.AsString   := qryOcorre.FieldByName('OCO_CODOPE').AsString;
      cdsMovOcorrOCO_DESCRI.AsString   := qryOcorre.FieldByName('OCO_DESCRI').AsString;
      cdsMovOcorrOCO_CODEMP.AsString   := qryOcorre.FieldByName('OCO_CODEMP').AsString;
      cdsMovOcorrAUTOINCREM.AsString   := qryOcorre.FieldByName('AUTOINCREM').AsString;
      cdsMovOcorrCLI_NOMCLI.AsString   := qryOcorre.FieldByName('CLI_NOMCLI').AsString;
      cdsMovOcorrTOC_DESTOC.AsString   := qryOcorre.FieldByName('TOC_DESTOC').AsString;
      cdsMovOcorrOPE_NOMOPE.AsString   := qryOcorre.FieldByName('OPE_NOMOPE').AsString;
      cdsMovOcorrOCO_EMERGE.AsString   := qryOcorre.FieldByName('OCO_EMERGE').AsString;
      cdsMovOcorrOCO_DTALIM.AsDateTime := qryOcorre.FieldByName('OCO_DTALIM').AsDateTime;
      cdsMovOcorrNumDoc.AsString       := qryOcorre.FieldByName('NUMDOC').AsString;
      cdsMovOcorrUSADEPS.AsString      := qryOcorre.FieldByName('USADEPS').AsString;
      cdsMovOcorrSTATUSDEPS.AsString   := qryOcorre.FieldByName('STATUSDEPS').AsString;
      cdsMovOcorrMOTBAI.AsString       := qryOcorre.FieldByName('FGO_MOTBAI').AsString;

      cdsMovOcorrAUTOINCREMFATGOR.AsString := qryOcorre.FieldByName('AUTOINCREMFATGOR').AsString;
      cdsMovOcorrCAT_DESCRI.AsString := qryOcorre.FieldByName('CAT_DESCRI').AsString;

        //Controle dos atrasos
      cdsMovOcorrHOREXC.AsFloat       := qryOcorre.FieldByName('OCO_HOREXC').AsFloat;
      cdsMovOcorrOCO_TMPLIM.AsFloat   := qryOcorre.FieldByName('OCO_TMPLIM').AsFloat;
      cdsMovOcorrOCO_METLIM.AsFloat   := qryOcorre.FieldByName('OCO_METLIM').AsFloat;
      cdsMovOcorrOCO_CODSIT.AsString  := qryOcorre.FieldByName('OCO_CODSIT').AsString;
      cdsMovOcorrFGO_VLRCON.AsFloat   := qryOcorre.FieldByName('FGO_VLRCON').AsFloat;
      cdsMovOcorrNUMCMP.AsString       := qryOcorre.FieldByName('NUMCMP').AsString;
      cdsMovOcorrENTRET.AsString      := qryOcorre.FieldByName('ENTRET').AsString;
      cdsMovOcorrCLILOJ.AsString      := qryOcorre.FieldByName('CLILOJ').AsString;
      cdsMovOcorrSTATUS.AsString      := qryOcorre.FieldByName('STATUS').AsString;
      cdsMovOcorrFGO_STATUS.AsInteger := qryOcorre.FieldByName('FGO_STATUS').AsInteger;
      cdsMovOcorrDOCCON.AsString      := qryOcorre.FieldByName('DOCCON').AsString;
      cdsMovOcorr.Post;

      qryOcorre.Next;
    End;

  End
  Else
  Begin
    qryOcorre.Close;
    qryOcorre.SQL.Clear;
    qryOcorre.SQL.Add('SELECT * FROM MOVOCO WHERE OCO_SEQLAG = "0" ');
    qryOcorre.Open;
  End;
end;

procedure TfrmCadLeads.pInicializaIndices;
begin
  inherited;
end;

procedure TfrmCadLeads.pInserirAlterarOcorrencia(strTipoAcao: String);
 var
   qryConsulta: TUniQuery;
   frmCadMovOcorrencias : TfrmCadMovOcorrencias;
begin
  If strTipoAcao = 'Alterar' Then
  Begin
    qryConsulta:= fCriaQuery;
    Try
      qryConsulta.Close;
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add(fRetornaSQLInformacoesOcorrencias(strTip_Fc, qryTabela.FieldByName('AUTOINCREM').AsString));
      qryConsulta.Open;

      If qryConsulta.IsEmpty Then
      Begin
        pMensagemOk('Lead não possui ocorrência vinculada!');
        Abort;
      End
      Else
      Begin
        Try
          pCriarFormularios(TfrmCadMovOcorrencias,frmCadMovOcorrencias);
          frmCadMovOcorrencias.strTip_FC := IfThen(False,'P', 'C');
          frmCadMovOcorrencias.strCodCli := cdsMovOcorr.FieldByName('OCO_CODCLI').AsString;
          frmCadMovOcorrencias.strCodOco := cdsMovOcorr.FieldByName('OCO_CODOCO').AsString;
          frmCadMovOcorrencias.strCodLad := qryTabela.FieldByName('AUTOINCREM').AsString;
          frmCadMovOcorrencias.strCodEmp := cdsMovOcorr.FieldByName('OCO_CODEMP').AsString;
          frmCadMovOcorrencias.strNumLead := qryTabela.FieldByName('LDG_NUMDOC').AsString;
          frmCadMovOcorrencias.strOperac := strTipoAcao;
          frmCadMovOcorrencias.ShowModal;
          pCarregaHistorioOcorrencia;
        Finally
          FreeAndNil(frmCadMovOcorrencias);
        End;
      End;
    Finally
      FreeAndNil(qryConsulta)
    End;
  End
  Else
  Begin
    Try
      pCriarFormularios(TfrmCadMovOcorrencias,frmCadMovOcorrencias);
      frmCadMovOcorrencias.strTip_FC := IfThen(False,'P', 'C');
      frmCadMovOcorrencias.strCodCli := qryTabela.FieldByName('LDG_CODCLI').AsString;
      frmCadMovOcorrencias.strCodOco := cdsMovOcorr.FieldByName('OCO_CODOCO').AsString;
      frmCadMovOcorrencias.strCodLad := qryTabela.FieldByName('AUTOINCREM').AsString;
      frmCadMovOcorrencias.strCodEmp := VS_strCodEmp;
      frmCadMovOcorrencias.strOperac := strTipoAcao;
      frmCadMovOcorrencias.strNumLead := qryTabela.FieldByName('LDG_NUMDOC').AsString;
      frmCadMovOcorrencias.ShowModal;
      pCarregaHistorioOcorrencia;
    Finally
      FreeAndNil(frmCadMovOcorrencias);
    End;
  End;

  objLeads.pAtualizaStatusLeadAndamento(qryTabela.FieldByName('AUTOINCREM').AsString,
                                        qryTabela.FieldByName('LDG_NUMDOC').AsString);
  pAtualizaInformacoesGeraisDoLead;
end;

procedure TfrmCadLeads.pLimpaCampos;
begin
  edtNomCli.Clear;
  mmoCliObs.Clear;
  edtCliCid.Clear;
  edtCliTip.Clear;
  edtNomFas.Clear;
  edtNomVen.Clear;
  edtNomExt.Clear;
  edtNomIns.Clear;
  edtTipIns.Clear;
  edtNomCat.Clear;
  pLimpaItens;
  cdsItens.EmptyDataSet;
  ObjLeads.pLimpar;
  edtPrevisDolar.Clear;
end;

procedure TfrmCadLeads.pKeyPressCodigoVendedorGenerico(Sender: TObject; var Key: Char);
var
  arrSel : TConsultasArray;
begin
  if fEntraCons(Key) and fCfgSis('MLTOPE', varBoolean) then
  begin
    if fPesquisarOperadorSemClienteInformado(TDBEditFocus(Sender), Key, arrSel) then
      Exit;

    if fPesquisarOperadorSeNenhumVendedorVinculadoAoCliente(TDBEditFocus(Sender), Key, arrSel) then
      Exit;

    pPesquisarVendedoresVinculadosAoCliente(TDBEditFocus(Sender), Key, arrSel);
    Exit;
  end;
  pPesquisaPadraoOperador(TDBEditFocus(Sender), Key, arrSel);
end;

function TfrmCadLeads.getTip_Fc: String;
begin
  Result := FTip_Fc;
end;

procedure TfrmCadLeads.setTip_Fc(const Value: String);
begin
  FTip_Fc := Value;
end;

procedure TfrmCadLeads.edtCodEmpOrcVinExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmpOrcVin, edtNomEmpOrcVin, arrEmpresas, fRetNomeEmpresa, Nil, 'da Empresa', 0, False, 'Código', True);
end;

procedure TfrmCadLeads.edtCodEmpOrcVinKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqEmpresa(conEmpSimples, Self, edtCodEmpOrcVin, edtNomEmpOrcVin, Nil, Key, arrEmpresas, True) Then
  Begin
    If fValidaCampos(edtCodEmpOrcVin, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadLeads.edtCodMarExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(edtCodMar.Text) Then
    edtDesMar.Text := 'TODAS'
  Else
    edtDesMar.Text := fRetNomMarca(edtCodMar.Text);

  If fEmptyStr(edtDesMar.Text) And (Not fEmptyStr(edtCodMar.Text)) Then
  Begin
    fMensagem('', 'Marca não encontrada!', ['&Ok']);
    edtCodMar.Clear;
  End;
end;

procedure TfrmCadLeads.edtCodMarKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  If fPesqMarcas(Self, edtCodMar, edtDesMar, Nil, Key, arrSel) Then
  Begin
    If fValidaCampos(edtCodMar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;


end.
