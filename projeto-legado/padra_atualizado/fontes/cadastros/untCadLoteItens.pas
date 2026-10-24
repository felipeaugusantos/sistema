unit untCadLoteItens;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls, Math,
  StdCtrls, Buttons, ExtCtrls, EditFocus, Mask, DBCtrls, DBEditFocus, DB, strUtils,
  untCadLote, Uni, untModulo, UniClientDataSet, QColorLabel, BitBtnLockedIncrem,
  cxProgressBar, MemDS, DBAccess, frxClass, frxExportCSVTestabilidade, Dialogs,
  untMensagemTravaLote, DBComboBoxFocus, untTProcessaEtiqueta, untTypesSistema,
  untICadLote, untPesqAux;

type
  TRecDadosEdicaoLotePicking = record
    strAutInc,
    strCodite,
    strLocFis,
    strLocDes,
    strNumLot: String;
  end;
  TfrmCadLoteItens = class(TfrmPaiCad)
    pnlDados: TPanel;
    dtsCadLot: TDataSource;
    dbeCodEmp: TDBEditFocus;
    qryCadLot: TUniQuery;
    qryCadLotAUTOINCREM: TStringField;
    qryCadLotLOT_NUMLOT: TStringField;
    qryCadLotLOT_CODEMP: TStringField;
    qryCadLotLOT_CODITE: TStringField;
    qryCadLotLOT_DTAFAB: TDateField;
    qryCadLotLOT_DTAVAL: TDateField;
    qryCadLotLOT_DTABAL: TDateField;
    qryCadLotLOT_SALBAL: TFloatField;
    qryCadLotLOT_SALDOS: TFloatField;
    qryCadLotLOT_PRECUS: TFloatField;
    qryCadLotLOT_PREVEN: TFloatField;
    qryCadLotLOT_LOCFIS: TStringField;
    qryCadLotLOT_CUSTOT: TFloatField;
    qryCadLotLOT_VENTOT: TFloatField;
    qryCadLotLOT_BROKER: TStringField;
    qryCadLotLOT_PRIIND: TStringField;
    pnlCtlArmazem: TPanel;
    Label12: TLabel;
    dbeCapaci: TDBEditFocus;
    Label13: TLabel;
    dbePonRep: TDBEditFocus;
    qryCadLotLOT_CAPACI: TFloatField;
    qryCadLotLOT_PONREP: TFloatField;
    qryCadLotLOT_ARMPRI: TStringField;
    pnlCodItem: TPanel;
    lbl1: TLabel;
    dbeCodIte: TDBEditFocus;
    edtDesIte: TEditFocus;
    pnlNumLot: TPanel;
    lblNumLot: TLabel;
    dbeNumLot: TDBEditFocus;
    edtDescArmazem: TEditFocus;
    pnlOutrasInform: TPanel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    dbeDtaFab: TDBEditFocus;
    dbeDtaVal: TDBEditFocus;
    dbeSaldos: TDBEditFocus;
    dbeSalBal: TDBEditFocus;
    dbeDtaBal: TDBEditFocus;
    qryCadLotLOT_STATUS: TStringField;
    qryCadLotLOT_ARMPRC: TStringField;
    qryCadLotLOT_VENTDO: TStringField;
    qryCadLotLOT_GARPRI: TStringField;
    pnlArmLotCheckout: TPanel;
    chkArmPri: TDBCheckBox;
    qryCadLotLOT_PRIPRO: TStringField;
    qryCadLotLOT_LOTAPR: TStringField;
    pnlLocSep: TPanel;
    Label1: TLabel;
    dbeLocSep: TDBEditFocus;
    qryCadLotLOT_LOCSEP: TStringField;
    qryCadLotLOT_PRITIN: TStringField;
    qryCadLotLOT_SAL_ML: TFloatField;
    qryCadLotLOT_ML_BAL: TFloatField;
    pnlLocFis: TPanel;
    lblLocFis: TLabel;
    dbeLocFis: TDBEditFocus;
    edtDesLoc: TEditFocus;
    pnlSal_ML: TPanel;
    Label2: TLabel;
    dbeSal_ML: TDBEditFocus;
    Label3: TLabel;
    dbeML_Bal: TDBEditFocus;
    pnlPriTin: TPanel;
    chkPriTin: TDBCheckBox;
    pnlAbsAut: TPanel;
    chkAbsAut: TDBCheckBox;
    qryCadLotLOT_ABSAUT: TStringField;
    pnlArmPrC: TPanel;
    chkArmPrC: TDBCheckBox;
    pnlOrdPro: TPanel;
    chkPriPro: TDBCheckBox;
    pnlGarantia: TPanel;
    chkGarPri: TDBCheckBox;
    dbcLotApr: TDBCheckBox;
    dbcVenTdo: TDBCheckBox;
    dbeStatus: TDBComboBoxFocus;
    pnlMotBlo: TPanel;
    Label4: TLabel;
    edtMotBlo: TEditFocus;
    qryCadLotLOT_MOTBLO: TStringField;
    pnlBroker: TPanel;
    chkBroker: TDBCheckBox;
    pnlCroDoc: TPanel;
    dbeCroDoc: TDBCheckBox;
    qryCadLotLOT_CRODOC: TStringField;
    lblCodbar: TLabel;
    edtCodbar: TEditFocus;
    pnlCodbar: TPanel;
    pnlArmLotOrPedVen: TPanel;
    chkArmOPV: TDBCheckBox;
    pnlPrincipalParaAluguelDeEquipamentos: TPanel;
    chkEqpPri: TDBCheckBox;
    qryCadLotLOT_EQPPRI: TStringField;
    edtDesLocSep: TEditFocus;
    pnlArmPce: TPanel;
    chkArmPce: TDBCheckBox;
    qryCadLotLOT_ARMPCE: TStringField;
    grpChapas: TGroupBox;
    lblChapa: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    edtLOT_NCHAPA: TEditFocus;
    edtLOT_MEDB_L: TEditFocus;
    edtLOT_ESPESS: TEditFocus;
    edtLOT_MEDL_L: TEditFocus;
    edtLOT_MEDL_A: TEditFocus;
    edtLOT_MEDB_A: TEditFocus;
    edtValM2Liquido: TEditFocus;
    btnImprimirEtiquetas: TBitBtnLocked;
    qryCadLotLOT_CHAPA_: TStringField;
    qryCadLotLOT_NCHAPA: TIntegerField;
    qryCadLotLOT_MEDB_L: TFloatField;
    qryCadLotLOT_MEDB_A: TFloatField;
    qryCadLotLOT_MEDL_L: TFloatField;
    qryCadLotLOT_MEDL_A: TFloatField;
    qryCadLotLOT_ESPESS: TFloatField;
    btnDividirChapa: TBitBtnLocked;
    ProgressBar1: TProgressBar;
    qryCadLotLOT_PREVEE: TFloatField;
    qryCadLotLOT_VENTOE: TFloatField;
    Label5: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    pnlArmFul: TPanel;
    chkArmFul: TDBCheckBox;
    qryCadLotLOT_ARMFUL: TStringField;
    qryCadLotLOT_CODBAR: TStringField;
    tbsPreVen: TTabSheet;
    pnlCtlLote: TPanel;
    grbPrecoVendaParcial: TGroupBox;
    grbPrecoVendaTotal: TGroupBox;
    Panel1: TPanel;
    pnlPreCusParcial: TPanel;
    dbePreCus: TDBEditFocus;
    pnlPreVenda1Parcial: TPanel;
    dbePreVe1: TDBEditFocus;
    lblPreVe1: TLabel;
    lblPreCus: TLabel;
    pnlPreVenda2Parcial: TPanel;
    lblPreVe2: TLabel;
    dbePreVe2: TDBEditFocus;
    pnlPreVenda3Parcial: TPanel;
    lblPreVe3: TLabel;
    dbePreVe3: TDBEditFocus;
    pnlPreVenda4Parcial: TPanel;
    lblPreVe4: TLabel;
    dbePreVe4: TDBEditFocus;
    pnlPreVenda5Parcial: TPanel;
    lblPreVe5: TLabel;
    dbePreVe5: TDBEditFocus;
    pnlPreVenda6Parcial: TPanel;
    lblPreVe6: TLabel;
    dbePreVe6: TDBEditFocus;
    pnlPreVenda7Parcial: TPanel;
    lblPreVe7: TLabel;
    dbePreVe7: TDBEditFocus;
    pnlPrecoVendaParcialEntrega: TPanel;
    pnlPreVendaEnt6Parcial: TPanel;
    lblPrVeE6: TLabel;
    dbePrVeE6: TDBEditFocus;
    pnlPreVendaEnt7Parcial: TPanel;
    lblPrVeE7: TLabel;
    dbePrVeE7: TDBEditFocus;
    pnlPreVendaEnt1Parcial: TPanel;
    lblPrVeE1: TLabel;
    dbePrVeE1: TDBEditFocus;
    pnlPreVendaEnt2Parcial: TPanel;
    lblPrVeE2: TLabel;
    dbePrVeE2: TDBEditFocus;
    pnlPreVendaEnt3Parcial: TPanel;
    lblPrVeE3: TLabel;
    dbePrVeE3: TDBEditFocus;
    pnlPreVendaEnt4Parcial: TPanel;
    lblPrVeE4: TLabel;
    dbePrVeE4: TDBEditFocus;
    pnlPreVendaEnt5Parcial: TPanel;
    lblPrVeE5: TLabel;
    dbePrVeE5: TDBEditFocus;
    pnlPrecoVendaTotalEntrega: TPanel;
    pnlPreVendaEnt6Total: TPanel;
    lblVeToE6: TLabel;
    dbeVeToE6: TDBEditFocus;
    pnlPreVendaEnt7Total: TPanel;
    lblVeToE7: TLabel;
    dbeVeToE7: TDBEditFocus;
    pnlPreVendaEnt1Total: TPanel;
    lblVeToE1: TLabel;
    dbeVeToE1: TDBEditFocus;
    pnlPreVendaEnt2Total: TPanel;
    lblVeToE2: TLabel;
    dbeVeToE2: TDBEditFocus;
    pnlPreVendaEnt3Total: TPanel;
    lblVeToE3: TLabel;
    dbeVeToE3: TDBEditFocus;
    pnlPreVendaEnt4Total: TPanel;
    lblVeToE4: TLabel;
    dbeVeToE4: TDBEditFocus;
    pnlPreVendaEnt5Total: TPanel;
    lblVeToE5: TLabel;
    dbeVeToE5: TDBEditFocus;
    pnlPreVenda7Total: TPanel;
    lblVenTo7: TLabel;
    dbeVenTo7: TDBEditFocus;
    pnlPreVenda6Total: TPanel;
    lblVenTo6: TLabel;
    dbeVenTo6: TDBEditFocus;
    pnlPreVenda5Total: TPanel;
    lblVenTo5: TLabel;
    dbeVenTo5: TDBEditFocus;
    pnlPreVenda4Total: TPanel;
    lblVenTo4: TLabel;
    dbeVenTo4: TDBEditFocus;
    pnlPreVenda3Total: TPanel;
    lblVenTo3: TLabel;
    dbeVenTo3: TDBEditFocus;
    pnlPreVenda2Total: TPanel;
    lblVenTo2: TLabel;
    dbeVenTo2: TDBEditFocus;
    pnlPreVenda1Total: TPanel;
    lblVenTo1: TLabel;
    dbeVenTo1: TDBEditFocus;
    pnlPreCusTotal: TPanel;
    dbeCusTot: TDBEditFocus;
    lblCusTot: TLabel;
    qryCadLotLOT_PREVE1: TFloatField;
    qryCadLotLOT_PREVE2: TFloatField;
    qryCadLotLOT_PREVE3: TFloatField;
    qryCadLotLOT_PREVE4: TFloatField;
    qryCadLotLOT_PREVE5: TFloatField;
    qryCadLotLOT_PREVE6: TFloatField;
    qryCadLotLOT_PREVE7: TFloatField;
    qryCadLotLOT_PRVEE1: TFloatField;
    qryCadLotLOT_PRVEE2: TFloatField;
    qryCadLotLOT_PRVEE3: TFloatField;
    qryCadLotLOT_PRVEE4: TFloatField;
    qryCadLotLOT_PRVEE5: TFloatField;
    qryCadLotLOT_PRVEE6: TFloatField;
    qryCadLotLOT_PRVEE7: TFloatField;
    qryCadLotLOT_VENTO1: TFloatField;
    qryCadLotLOT_VENTO2: TFloatField;
    qryCadLotLOT_VENTO3: TFloatField;
    qryCadLotLOT_VENTO4: TFloatField;
    qryCadLotLOT_VENTO5: TFloatField;
    qryCadLotLOT_VENTO6: TFloatField;
    qryCadLotLOT_VENTO7: TFloatField;
    qryCadLotLOT_VETOE1: TFloatField;
    qryCadLotLOT_VETOE2: TFloatField;
    qryCadLotLOT_VETOE3: TFloatField;
    qryCadLotLOT_VETOE4: TFloatField;
    qryCadLotLOT_VETOE5: TFloatField;
    qryCadLotLOT_VETOE6: TFloatField;
    qryCadLotLOT_VETOE7: TFloatField;
    qryCadLotLOT_TRANSI: TStringField;
    qryCadLotLOT_OPELLA: TStringField;
    pnlPriInd: TPanel;
    chkLotPriInd: TDBCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure qryCadLotLOT_DTAFABSetText(Sender: TField;
      const Text: String);
    procedure qryCadLotLOT_DTAVALSetText(Sender: TField;
      const Text: String);
    procedure FormActivate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chkArmPriClick(Sender: TObject);
    procedure dbeLocFisKeyPress(Sender: TObject; var Key: Char);
    procedure dbeNumLotKeyPress(Sender: TObject; var Key: Char);
    procedure chkArmPrCClick(Sender: TObject);
    procedure chkGarPriClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure chkPriTinClick(Sender: TObject);
    procedure dbeLocSepKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCroDocClick(Sender: TObject);
    procedure edtCodbarEnter(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkArmOPVClick(Sender: TObject);
    function dbeLocFisChamaCadastro(Key: Word): string;
    procedure chkArmPceClick(Sender: TObject);
    procedure btnImprimirEtiquetasClick(Sender: TObject);
    procedure btnDividirChapaClick(Sender: TObject);
    procedure dbeStatusChange(Sender: TObject);
    procedure dbcLotAprClick(Sender: TObject);
    procedure chkLotPriIndClick(Sender: TObject);
  private
    { Private declarations }
    blnArmazem,
    blnLotPic : Boolean;
    blnVariasChapasPorLote: Boolean;
    objCadLot: TCadLot;
    objSender: TWinControl;
    blnValObr: Boolean;
    strTraLoc,
    strLocTst,
    strLocalOld,
    strLoteOld,
    strCodIte: String;
    blnRemoverLocFis: Boolean;
    blnInclusao: Boolean;
    blnMARENT: Boolean;
    blnInativouLote: Boolean;
    blnTmqLot: Boolean;
    strStatusOriginal: String;
    recDadosEdicaoLotePkn: TRecDadosEdicaoLotePicking;
    strAutIncLotePickingRemoverLocFis: String;

    function fMostrarOpcaoLotePrincipalFulfillmentParaSubProdutos : Boolean;

    procedure pHabilitaNumLot(blnHabilita: Boolean);
    Procedure pCarregaItem;
    Procedure pCarregaArmazem;
    Procedure pCarregaLocalizacao;
    Procedure pCarregaLocalSeparacao;
    Procedure pHabilitaLocFis(blnHabili: Boolean);
    procedure pCarregaChapa;

    procedure pHabilitaCamposMarmore(blnHabilita: Boolean);

    Function fGravaLote: Boolean;
    Function fGravaLoteItens(pgbProgresso: TcxProgressBar): Boolean;

    function fInativarLote(blnExcluir : Boolean = False; blnApenasValidaSaldo: boolean = False): Boolean;

    function fVerificaDuplicado: Boolean;
    function fLoteVendasADefinir: Boolean;

    function fTemContagemEmAberto(strCodIte: String): Boolean;


    function fUtilizandoCadastroRapidoLoteWMS: Boolean;
    procedure pCadastroRapidoLoteWMS;
    procedure pCadastroRapidoLoteWMSMapeamentoLocFis;

    procedure pOnGetTextStatus(Sender: TField; var Text: string; DisplayText: Boolean);
    procedure pQryAfterOpen(DataSet: TDataSet);
    procedure pQryAfterScroll(DataSet: TDataSet);
    procedure pOnSetTextStatus(Field: TField; const Text: String);
    function fValidarCheckGarantiaCliente: Boolean;
    function fCarregaDadosLoteLocFisica(strCodIte, strNumLot, strLocFis: String): Boolean;
    function fLocalizacaoFisicaEmpresaManual(const AstrLocFis, AstrCodIte, AstrDesIte, AstrNumLot: String; const AblnCriaEmpresas: Boolean): TLocalizacaoFisicaEmpresaManual ;
    procedure pRenomeiaCamposPrecoVenda;
    procedure pHabilitaPrecoVenda;
    function fValidaPickingLaboratorioItemBase: Boolean;
    procedure pExibeMensagemLoteTransitorio(ALimpar: Boolean = False);
    function fValidaSeExisteCadastroLote: Boolean;
    procedure pBuscaLotePorAutoincrem;
    function fRemoveLocFisDoLotePickingAntigoSeExistir(AStrAutIncLote: String): Boolean;
    function fValidaSeExisteLoteLaborat: Boolean;
    function fLiberaTrocaStatusLoteAprovado: Boolean;
    procedure plimpaEventoClickChecAprovado;
    procedure pSetEventoClickChecAprovado;
  protected
    objEtiqueta: TProcessaEtiqueta;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pCarregaPreSetAmz;
    procedure pProcessaCodbar(strCodbar: string);
    procedure pInicializaIndices; override;
    procedure pOnStateChange; override;
    function fDefinePrincipalParaCompras: Boolean;
    procedure pValidarOpcoesLocPickingCheckOut;

    function fEhLocalizacaoPickingCheckOut(ACodLoc, ACodEmp : String) : Boolean;
    function fJahExisteLotePickingCheckOut(ANumLot, ACodEmp, ACodIte : String) : Boolean;
    procedure pProcessarOpcoesLote(ATForm : TForm; ABloqueio : Boolean);

  public
    { Public declarations }
    cdsSalLot: TUniClientDataSet;
    blnCadLoc: Boolean;
    strCodigoItemCadastroRapidoWMS: String;
    strDataValidadeCadastroRapidoWMS: String;
    strNumLotProdAca: String;
    blnBaixaOPI: Boolean;
    strNumeroLoteCadastroRapidoWMS: String;
    stlItensComLoteSemLocalizacao : TStringList;
    tipoCadastro : TTipoCadastroLote;
    blnCriaEmpresasWmsClass : Boolean;
    blnJaTemLote: Boolean;
    strCodigoLocFisCadastroRapidoWMS: String;
    blnCadOrigemMapeamento: Boolean;
    blnEdicaoPicking: Boolean;
    blnEditouPickingEGravou: Boolean;

    class procedure pCadastroRapidoMapeamentoLocFis(AStrCodIte, AStrLocFis: String);
    class procedure pCadastroRapidoSemProdutoWMS;
    class function fGetNumeroLoteInclusaoRapidaWMS(strDtaVal, strCodIte: String): String;

    Class function fUpdateADefinir(blnExclusao : Boolean; qryTabela: TUniQuery): Boolean;

    Class procedure pAtualizaStatusLoteADefinir(qryTabela: TUniQuery);

    Class Procedure pGravaLoteItemParte1(qryTabela: TUniQuery; objCadLot: TCadLot; blnAtualizaSaldoML: Boolean; Var blnUsarSaldoItem: Boolean);

    Class Function fGravaLoteItemParte2(qryTabela: TUniQuery; objCadLot: TCadLot;
                                        cdsSalLot: TUniClientDataSet;
                                        blnIncluir, blnUsarSaldoItem, blnRemoverLocFis, blnCriaEmpresasWms: Boolean;
                                        tipoCadastro : TTipoCadastroLote = tclNormal; blnBaixaOPI: Boolean = False; AblnJaTemLote: Boolean = False;
                                        AdictLocalizacaoFisicaEmpresa: TLocalizacaoFisicaEmpresaManual = Nil): Boolean;
    Class Function fEditarLote(AStrAutInc, AStrCodIte, AStrLocFis, AStrLocDes, AStrNumLot: String): Boolean;
  end;


implementation

uses SysUtils, untPai, Graphics, untConsultas, untFuncoesSimples, untGravando,
  untDadosCadLoteWMS, untConstantes,
  TypesRel, untFuncoesEtiqItens, untFuncoesEtiquetas, untFuncInsFactory,
  untILiberacao, untLiberacaoFactory, Lote.ValidaLoteLocalizacao,
  untObservacao, untMsgGridGenerica, untCadLoteLocalizacaoFisicaWmsEmpresas;

{$R *.dfm}

procedure TfrmCadLoteItens.FormActivate(Sender: TObject);
begin
  inherited;
  If (strCodigoItemCadastroRapidoWMS = 'XXXXX') Then
  Begin
    blnFecharFormPai := True;
    Close;
  End;
end;

procedure TfrmCadLoteItens.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  If fUtilizandoCadastroRapidoLoteWMS And (qryCadLot.State In [dsInsert]) Then
    btnCancela.Click;

  inherited;

  FreeAndNil(stlCampos);
  FreeAndNil(stlCamInd);
  FreeAndNil(stlDesInd);
end;

procedure TfrmCadLoteItens.pHabilitaNumLot(blnHabilita: Boolean);
Begin
  dbeNumLot.ReadOnly := Not blnHabilita;
  dbeNumLot.TabStop  := blnHabilita;

  If blnHabilita Then
  Begin
    dbeNumLot.Color       := clWindow;
    dbeNumLot.NormalColor := clWindow;
  End Else
  Begin
    dbeNumLot.Color       := $00FFDFB8;
    dbeNumLot.NormalColor := $00FFDFB8;
  End;
End;

procedure TfrmCadLoteItens.pHabilitaPrecoVenda;
var
  intCont,
  intTam : Integer;
  pnlPanel: TPanel;
begin
  intTam := 0;

  for intCont := 1 to Length(VS_strTabVen) do
  begin
    if (VS_strTabVen[intCont] = 'N') then
    begin
      pnlPanel := TPanel(FindComponent('pnlPreVenda' + intToStr(intCont) + 'Parcial'));
      intTam  := intTam + pnlPanel.Height;
      pnlPanel.Visible := False;
      TPanel(FindComponent('pnlPreVenda' + intToStr(intCont) + 'Total')).Visible := False;
    end;
  end;

  if pnlPrecoVendaParcialEntrega.Visible then
  begin
    for intCont := 1 to Length(VS_strTabVen) do
    begin
      if (VS_strTabVen[intCont] = 'N') then
      begin
        pnlPanel := TPanel(FindComponent('pnlPreVendaEnt' + intToStr(intCont) + 'Parcial'));
        intTam  := intTam + pnlPanel.Height;
        pnlPanel.Visible := False;
        TPanel(FindComponent('pnlPreVendaEnt' + intToStr(intCont) + 'Total')).Visible := False;
      end;
    end;
  end
  else
    intTam  := intTam + pnlPrecoVendaParcialEntrega.Height;

  grbPrecoVendaParcial.Height := grbPrecoVendaParcial.Height - intTam;
  grbPrecoVendaTotal.Height := grbPrecoVendaTotal.Height - intTam;
  pnlCtlLote.Height := pnlCtlLote.Height - intTam;

  if (Self.Height < (pnlCtlLote.Height + 130)) then
    Self.Height := pnlCtlLote.Height + 130;
end;

procedure TfrmCadLoteItens.FormCreate(Sender: TObject);
begin
  inherited;
  Width := 660;
  Height := 730;

  blnInclusao := False;
  blnMARENT := fCfgSis('MARENT', varBoolean);
  grpChapas.Visible := fCfgSis('MARMOR', varBoolean);
  blnVariasChapasPorLote := fCfgSis('CTRLCH', varString) = '2';

  If Not grpChapas.Visible  Then
    Self.Height := Self.Height - 114
  Else
  Begin
    If blnVariasChapasPorLote Then
      lblChapa.Caption := 'Qtd. Chapa';
  End;
  objEtiqueta := TProcessaEtiqueta.Create('frmCadLot', Self);
  pHabilitaCamposMarmore(False);

  strCodigoItemCadastroRapidoWMS   := '';
  strDataValidadeCadastroRapidoWMS := '';
  strNumeroLoteCadastroRapidoWMS   := '';
  strNumLotProdAca:= '';
  blnBaixaOPI := False;

  tipoCadastro := tclNormal;

  blnRemoverLocFis := False;

  objSender := Nil;
  cdsSalLot := Nil;

  pSetaCodIte(qryCadLotLOT_CODITE);

  qryCadLot.Connection := frmModulo.GetCurrentConnection;
  objCadLot := TCadLot.Create(Self, qryCadLot);

  blnCadLoc  := fCfgSis('CADLOC', varBoolean);

  blnLotPic := fCfgSis('LOTPIC', varBoolean);

  blnArmazem := fCfgSis('CTLEST') = '2';
  strTraLoc  := fCfgSIs('TRALOC');

  blnTmqLot := (fCfgSis('TMQLOT') = 'S') And (Not fUsaRotinaWMS);

  strNomeTabela := 'CADLOT';
  strNomeCampo  := 'LOT_NUMLOT';
  qryTabela     := objCadLot.qryTabela;
  dtsCadLot.DataSet := qryTabela;

  SetLength(arrCamposChave, 3);
  arrCamposChave[0] := dbeCodIte;
  arrCamposChave[1] := dbeNumLot;
  arrCamposChave[2] := dbeCodEmp;

  pnlCodbar.Visible := fCfgSis('BARLOT', varBoolean);
  pnlOrdPro.Visible := fCfgSis('ORDPRO', varBoolean);
  If not pnlOrdPro.Visible Then
    Self.Height := Self.Height - pnlOrdPro.Height;

  if Not fCfgSis('GARANT', varBoolean) Then
  Begin
    pnlGarantia.Visible := False;
    Self.Height := Self.Height - pnlGarantia.Height;
  End;

  If objCadLot.tplTipLot = tplLote Then
  Begin

    pnlPrincipalParaAluguelDeEquipamentos.Visible := False;
    Self.Height := Self.Height - pnlPrincipalParaAluguelDeEquipamentos.Height;

    {If Not fUsaRotinaWMS Then
    Begin
      pnlArmPrC.Visible := False;
      Self.Height       := Self.Height - pnlArmPrC.Height;
    End;}
  End
  Else
  Begin
    tbsPreVen.TabVisible := False;

    if Not fCfgSis('LOCEQU', varBoolean) Then
    Begin
      pnlPrincipalParaAluguelDeEquipamentos.Visible := False;
      Self.Height := Self.Height - pnlPrincipalParaAluguelDeEquipamentos.Height;
    End;

  End;

  //chkGarPri.Visible := (fCfgSis('CTLEST', varString) = '2');

  // NAO APARECE PARA ORDEM DE PRODUÇÃO INDUSTRIAL
  chkPriPro.Visible := (Not fCfgSis('UTIIND', varBoolean));

//  If Not chkPriPro.Visible Then
//    chkArmPrC.Left := chkPriPro.Left;

  Self.Caption      := objCadLot.strTitCad;
  lblNumLot.Caption := objCadLot.strTitLab + ':';

  dbcLotApr.Caption := objCadLot.strDescri + ' Aprovado / Liberado para venda ou Lote em garantia?';
  chkArmOPV.Caption := objCadLot.strDescri + ' principal para vendas no Orçamento/Pedido/Venda Normal/Brindes';
  chkArmPri.Caption := objCadLot.strDescri + ' principal para vendas no check-out';
  chkArmPrC.Caption := objCadLot.strDescri + ' principal para compras';
  chkPriTin.Caption := objCadLot.strDescri + ' principal para Tinta Máquina';
  chkGarPri.Caption := objCadLot.strDescri + ' principal para recebimento de garantia do cliente';

  If blnCadLoc and (not blnArmazem) And Not fUsaRotinaWMS Then
    pHabilitaLocFis(False);

  If blnArmazem Then
  Begin
    pnlOutrasInform.Top := pnlNumLot.Top;
    pnlNumLot.Top := pnlOutrasInform.Top + pnlOutrasInform.Height;
    pnlNumLot.TabOrder := pnlOutrasInform.TabOrder;
    {*******************************************************************************************}
    {* SE UTILIZA CADASTRO DE LOC.FIS. NÃO ALTERA ARMAZÉM, ESTE SERÁ CARREGADO AUTOMATICAMENTE *}
    {****************************************************************************************AL*}
    If blnCadLoc And Not fUsaRotinaWMS Then
    Begin
      pHabilitaNumLot(False);
    End;
  End
  Else
    edtDescArmazem.Visible := False;

  edtDesLoc.Visible := blnCadLoc;

  If fUsaRotinaWMS Then
  Begin
    dbcVenTdo.Visible := False;

    if tbsPreVen.TabVisible then
      tbsPreVen.TabVisible := False;
  End
  Else
  Begin
    pnlAbsAut.Visible := False;
    Self.Height       := Self.Height - pnlAbsAut.Height;

    pnlLocSep.Visible := False;
    Self.Height       := Self.Height - pnlLocSep.Height;

    If (Not fCfgSis('TMQLOT', varBoolean)) And (Not fCfgSis('LOTBAS', varBoolean)) Then
    Begin
      pnlPriTin.Visible := False;
      Self.Height       := Self.Height - pnlPriTin.Height;

      pnlSal_ML.Visible      := False;
      Self.Height            := Self.Height - pnlSal_ML.Height;
      pnlOutrasInform.Height := pnlOutrasInform.Height - pnlSal_ML.Height;
    End;
  End;

  If (Not fCfgSis('LOTCRO', varBoolean)) Then
  Begin
    pnlCroDoc.Visible := False;
    Self.Height       := Self.Height - pnlCroDoc.Height;
  End;

  If (blnArmazem) Then
    chkArmPce.Caption := 'Armazém principal para conserto de equipamentos'
  Else
    chkArmPce.Caption := 'Lote principal para conserto de equipamentos';

  pnlArmPce.Visible := (fCfgSis('CONEQU', varString) = 'S');
  If not pnlArmPce.Visible Then
    Self.Height := Self.Height - pnlArmPce.Height;

  pnlArmFul.Visible := fMostrarOpcaoLotePrincipalFulfillmentParaSubProdutos;
  If not pnlArmFul.Visible Then
    Self.Height := Self.Height - pnlArmFul.Height;

  qryTabela.AfterOpen   := pQryAfterOpen;
  qryTabela.AfterScroll := pQryAfterScroll;

  If blnMARENT Then
  Begin
    pnlPrecoVendaParcialEntrega.Visible := True;
    pnlPrecoVendaTotalEntrega.Visible := True;
  End;
  
  pnlCtlArmazem.Visible := Not fUsaRotinaWMS;

  pRenomeiaCamposPrecoVenda;
  pHabilitaPrecoVenda;

  blnInativouLote := False;
  strStatusOriginal := '';

  pnlPriInd.Visible := fCfgSis('UTIIND', varBoolean);
  If Not pnlPriInd.Visible Then
    Self.Height := Self.Height - pnlPriInd.Height;
end;

procedure TfrmCadLoteItens.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objEtiqueta)
end;

procedure TfrmCadLoteItens.FormShow(Sender: TObject);
begin
  inherited;
  If (fUtilizandoCadastroRapidoLoteWMS) And (Not blnCadOrigemMapeamento) Then
    pCadastroRapidoLoteWMS;

  If blnCadOrigemMapeamento Then
    pCadastroRapidoLoteWMSMapeamentoLocFis;

  pSetaCodIte( dbeCodIte );

  If blnEdicaoPicking Then
  Begin
    If Not fEmptyStr(recDadosEdicaoLotePkn.strAutInc) Then
      pBuscaLotePorAutoincrem;
  End;

  if Assigned(stlItensComLoteSemLocalizacao) Then
    btnPesquisaClick(nil);

end;

procedure TfrmCadLoteItens.pHabilitaCamposMarmore(blnHabilita: Boolean);
begin
  edtLOT_NCHAPA.Enabled:= blnHabilita;
  edtValM2Liquido.Enabled:= blnHabilita;
  edtLOT_MEDB_L.Enabled:= blnHabilita;
  edtLOT_MEDB_A.Enabled:= blnHabilita;
  edtLOT_MEDL_L.Enabled:= blnHabilita;
  edtLOT_MEDL_A.Enabled:= blnHabilita;
  edtLOT_ESPESS.Enabled:= blnHabilita;
end;

Procedure TfrmCadLoteItens.pHabilitaLocFis(blnHabili: Boolean);
Begin
  lblLocFis.Enabled := blnHabili;
  dbeLocFis.Enabled := blnHabili;

  If Not blnHabili Then
  Begin
    If Not blnCadOrigemMapeamento Then
      dbeLocFis.Clear;
    chkArmPri.Checked := False;
    chkArmPrC.Checked := False;
    chkArmOPV.Checked := False;
  End;

End;

function TfrmCadLoteItens.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
   Var
     strCodIte, strItem, strLote, strAutIncLoteComPicking: String;
     fltSalLot, fltSalLotML: Double;
     dbeEdit: TDBEditFocus;
begin
  Result := True;

  objSender := Nil;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    Try

      If (Sender = dbeCodIte) Then
      Begin

        //linha adicionada, pois ao passar pelo TStringField, o field não era preenchido com o valor do edit
        dbeCodIte.Field.Text := dbeCodIte.Text;
        objCadLot.strCodIte := dbeCodIte.Text;
        edtDesIte.Text      := objCadLot.strDesIte;
        blnValObr           := (fRetValObrProduto(objCadLot.strCodIte) = 'S') Or fUsaRotinaWMS;
        if Result And pnlArmPrC.Visible And (objCadLot.tplTipLot = tplLote) Then
          If fDefinePrincipalParaCompras Then
            qryTabela.FieldByName('LOT_ARMPRC').AsString := 'S';
      End

      else if (Sender = dbeStatus) Then
      Begin

        if dbeStatus.Text = 'BLOQUEADO' then
        begin
          pMensagemOk('Não é possível mudar o status para bloqueado!');
          Result := False;
        end
        else if (not blnBuscaPorChave) and (qryCadLot.fieldByName('LOT_STATUS').OldValue = 'B')then
        begin
          if fMensagem('ATENÇÃO', 'O lote atual pode estar em contagem, deseja realmente mudar seu status para ' + dbeStatus.Text +'?', ['','']) = 2 then
            Result := False;
        end
        else If (dbeStatus.Text = 'INATIVO') Then
          Result := fInativarLote(False, True)
      End

      Else If (pnlCodbar.Visible) And (Sender = edtCodbar) Then
      Begin
        objEtiqueta.pLeEtiqueta(edtCodbar.Text, blnInclusao);
        If (Not fEmptyStr(objEtiqueta.Campo['CODBAR'].Valor)) then
        Begin
          If Not blnInclusao Then
          Begin
            strCodIte := fCodigoDeBarrasToCodIte(objEtiqueta.Campo['CODBAR'].Valor);
            If strCodIte <> dbeCodIte.Text Then
              fMensagem('Atenção', 'A etiqueta informada não pertence ao item selecionado.', ['&Ok'])
            Else
              objEtiqueta.pPreencheCampos;
          End
          Else
          begin
            objEtiqueta.pPreencheCampos;
            dbeCodIte.Field.Value := fCodigoDeBarrasToCodIte(objEtiqueta.Campo['CODBAR'].Valor);
          End;
        End;

        edtCodbar.Text := '';

      End

      Else If (Sender = dbeNumLot) Then
      Begin

        If fEmptyStr(dbeNumLot.Text) Then
        Begin
          fMensagem('ATENÇÃO','Informe o número do ' + IIF(blnArmazem, 'Armazém', 'Lote') + ' !', ['&O k']);
          Result := False;
        End
        Else If (not fEmptyStr(dbeNumLot.Text)) and (fVerificaDuplicado) Then
        Begin
          fMensagem('ATENÇÃO', 'Já existe um registro com mesmos dados (Produto, '+IIF(blnArmazem, 'Armazém', 'Lote')+' e Empresa)!', ['&O k']);
          Result := False;
        End
        {***********************************************************************}
        {* SE NÃO UTILIZA CAD DE LOC.FIS. ENTÃO É OBRIGATÓRIO INFORMAR ARMAZÉM *}
        {********************************************************************AL*}
        Else If ((Not blnCadLoc) Or fEmptyStr(dbeLocFis.Text)) And (blnArmazem) Then
        Begin
          If fEmptyStr(dbeNumLot.Text) Then
          Begin
            pMensagemOk('Informe o Armazém!');;
            Result := False;
          End
          Else
          Begin
            edtDescArmazem.Text := fRetNomeArmazem(dbeNumLot.Text);

            If fEmptyStr(edtDescArmazem.Text) Then
            Begin
              pMensagemOk('Armazém não encontrado!');
              Result := False;
            End;
          End;
        End
        Else
        Begin
          If blnBuscaPorChave Or fUsaRotinaWMS Then
          Begin
            objCadLot.strNumLot := dbeNumLot.Text;
          End;

          pHabilitaLocFis((Not SameText(dbeNumLot.Text, 'A DEFINIR') And (qryTabela.FieldByName('LOT_TRANSI').AsString = 'N')));
        End;


        If blnArmazem Then
        Begin
          If Not fEmptyStr(dbeNumLot.Text) Then
          pCarregaPreSetAmz;

        end;
      End

      Else If (Sender = dbeDtaFab) Then
      Begin

        If (blnValObr) And (fEmptyStr(fTiraCaracEspeciais(dbeDtaFab.Text))) Then
        Begin
          pMensagemOk('Informe a Data de Fabricação!');
          Result := False;
        End
        Else
        If (not fEmptyDate(dbeDtaFab.Text)) And (StrToDateDef(dbeDtaFab.Text, 0) <= 0) Then
        Begin
          pMensagemOk('Data de Fabricação inválida!');
          Result := False;
        End
        Else
          objCadLot.strDtaFab :=  dbeDtaFab.Text;

      End

      Else If (Sender = dbeDtaVal) Then
      Begin

        If (blnValObr) And (fEmptyStr(fTiraCaracEspeciais(dbeDtaVal.Text))) Then
        Begin
          pMensagemOk('Informe a Data de Validade!');
          Result := False;
        End
        Else
        If (not fEmptyDate(dbeDtaVal.Text)) And (StrToDateDef(dbeDtaVal.Text, 0) <= 0) Then
        Begin
          pMensagemOk('Data de Validade inválida!');
          Result := False;
        End
        Else
          objCadLot.strDtaVal := dbeDtaVal.Text;

        If fUtilizandoCadastroRapidoLoteWMS And Result And blnValObr And (fEmptyStr(dbeNumLot.Field.AsString)) And (qryCadLot.State In [dsInsert]) Then
        Begin
          dbeNumLot.Field.AsString := TfrmCadLoteItens.fGetNumeroLoteInclusaoRapidaWMS(objCadLot.strDtaVal, dbeCodIte.Text);
        End;
      End

      Else If (Sender = dbePreCus) Then
      Begin
        If fEmptyStr(dbePreCus.Text) Then
          dbePreCus.Text := FormatFloat(fMskDigitos(objCadLot.intDecUni), 0);

        objCadLot.fltPreCus := fStrToFloat(dbePreCus.Text);
      End

      Else if (Pos(UpperCase('dbePreVe'), UpperCase(Sender.Name)) > 0) then
      Begin
        dbeEdit := TDBEditFocus(FindComponent('dbePreVe' + fRetSomenteNumeros(Sender.Name)));

        If fEmptyStr(dbeEdit.Text) Then
          dbeEdit.Text := FormatFloat(fMskDigitos(objCadLot.intDecUni), 0);

        if (fStrToFloat(dbeEdit.Text) < 0) then
        begin
          pMensagemOk('O "' + TLabel(FindComponent('lblPreVe' + fRetSomenteNumeros(Sender.Name))).Caption + '" tem que ser maior que 0!');
          Result := False;
        end;

        if (Sender = dbePreVe1) and Result then
        begin
  //        objCadLot.fltPreVen := fStrToFloat(dbePreVen.Text);
          If (grpChapas.Visible) And (Not fEmptyStr(edtLOT_NCHAPA.Text)) Then
          Begin
            dbeVenTo1.Field.Value := FormatFloat(fMskDigitos(objCadLot.intDecUni), dbePreVe1.Field.AsFloat * StrToFloat(AnsireplaceStr(edtValM2Liquido.Text, '.' , '')));
//            objCadLot.fltVenTot := dbeVenTot.Field.AsFloat;
          End;
        end;
      End

      Else if (Pos(UpperCase('dbePrVeE'), UpperCase(Sender.Name)) > 0) then
      Begin
        dbeEdit := TDBEditFocus(FindComponent('dbePrVeE' + fRetSomenteNumeros(Sender.Name)));

        If fEmptyStr(dbeEdit.Text) Then
          dbeEdit.Text := FormatFloat(fMskDigitos(objCadLot.intDecUni), 0);

        if (fStrToFloat(dbeEdit.Text) < 0) then
        begin
          pMensagemOk('O "' + TLabel(FindComponent('lblPrVeE' + fRetSomenteNumeros(Sender.Name))).Caption + '" tem que ser maior que 0!');
          Result := False;
        end;

        if (Sender = dbePrVeE1) and Result then
        begin
//          objCadLot.fltPreVee := fStrToFloat(dbePrevee.Text);
          If (grpChapas.Visible) And (Not fEmptyStr(edtLOT_NCHAPA.Text)) Then
          Begin
            dbeVeToE1.Field.Value := FormatFloat(fMskDigitos(objCadLot.intDecUni), dbePrVeE1.Field.AsFloat * StrToFloat(AnsireplaceStr(edtValM2Liquido.Text, '.' , '')));
//            objCadLot.fltVenToe := dbeVenToe.Field.AsFloat;
          End;
        end;
      End

      Else If (Sender = dbeCusTot) Then
      Begin
        If fEmptyStr(dbeCusTot.Text) Then
          dbeCusTot.Text := FormatFloat(fMskDigitos(objCadLot.intDecUni), 0);

        objCadLot.fltCusTot := fStrToFloat(dbeCusTot.Text);
      End

      Else if (Pos(UpperCase('dbeVenTo'), UpperCase(Sender.Name)) > 0) then
      Begin
        dbeEdit := TDBEditFocus(FindComponent('dbeVenTo' + fRetSomenteNumeros(Sender.Name)));

        If fEmptyStr(dbeEdit.Text) Then
          dbeEdit.Text := FormatFloat(fMskDigitos(objCadLot.intDecUni), 0);

        if (fStrToFloat(dbeEdit.Text) < 0) then
        begin
          pMensagemOk('O "' + TLabel(FindComponent('lblVenTo' + fRetSomenteNumeros(Sender.Name))).Caption + '" tem que ser maior que 0!');
          Result := False;
        end;

        if (Sender = dbeVenTo1) and Result then
        begin
//          objCadLot.fltVenTot := fStrToFloat(dbeVenTot.Text);
          If (grpChapas.Visible) And (Not fEmptySTR(edtLOT_NCHAPA.Text)) Then
          Begin
            If (StrToFloat(AnsireplaceStr(edtValM2Liquido.Text, '.', '')) > 0 ) Then
              dbePreVe1.Field.Value := FormatFloat(fMskDigitos(objCadLot.intDecUni), dbeVenTo1.Field.AsFloat / StrToFloat(AnsireplaceStr(edtValM2Liquido.Text, '.', '')))
            Else
              dbePreVe1.Field.Value := FormatFloat(fMskDigitos(objCadLot.intDecUni), dbeVenTo1.Field.AsFloat);
//            objCadLot.fltPreVen := dbePreVen.Field.AsFloat;
          End;
        end;
      End

      Else if (Pos(UpperCase('dbeVeToE'), UpperCase(Sender.Name)) > 0) then
      Begin
        dbeEdit := TDBEditFocus(FindComponent('dbeVeToE' + fRetSomenteNumeros(Sender.Name)));

        If fEmptyStr(dbeEdit.Text) Then
          dbeEdit.Text := FormatFloat(fMskDigitos(objCadLot.intDecUni), 0);

        if (fStrToFloat(dbeEdit.Text) < 0) then
        begin
          pMensagemOk('O "' + TLabel(FindComponent('lblVeToE' + fRetSomenteNumeros(Sender.Name))).Caption + '" tem que ser maior que 0!');
          Result := False;
        end;

        if (Sender = dbeVeToE1) and Result then
        begin
//          objCadLot.fltVenToe := fStrToFloat(dbeVentoe.Text);

          If (grpChapas.Visible) And (Not fEmptyStr(edtLOT_NCHAPA.Text)) Then
          Begin
            If (StrToFloat(AnsireplaceStr(edtValM2Liquido.Text, '.', '')) > 0 ) Then
              dbePrVeE1.Field.Value := FormatFloat(fMskDigitos(objCadLot.intDecUni), dbeVeToE1.Field.AsFloat / StrToFloat(AnsireplaceStr(edtValM2Liquido.Text, '.', '')))
            Else
              dbePrVeE1.Field.Value := FormatFloat(fMskDigitos(objCadLot.intDecUni), dbeVeToE1.Field.AsFloat);

//            objCadLot.fltPreVee := dbePreVee.Field.AsFloat;
          End;
        end;
      End

      Else If (Sender = dbeLocSep) Then
      Begin
        pCarregaLocalSeparacao;

        If (Not fEmptyStr(dbeLocSep.Text)) And fEmptyStr(edtDesLocSep.Text) Then
        Begin
          fMensagem('ATENÇÃO!','Esse local de separação não está cadastrado!',['&OK']);
          Result := False;
        End;

      End

      Else If (Sender = dbeLocFis) Then
      Begin
        pCarregaLocalizacao;

        if not fEmptyStr(dbeLocFis.text) then
        begin
          dbeLocFis.text := Trim(dbeLocFis.text);
          dbeLocFis.field.AsString := dbeLocFis.text;
        end;

        If blnCadLoc And dbeLocFis.Enabled Then
        Begin
          If blnCadLoc And blnArmazem Then
            pHabilitaNumLot(False);

          If (Not fEmptyStr(dbeLocFis.Text)) Then
          Begin

            pValidarOpcoesLocPickingCheckOut;

            If fEmptyStr(edtDesLoc.Text) Then
            Begin
              pMensagemOk('Localização Física não encontrada!');
              Result := False;
              blnRemoverLocFis := False;
            End

            Else If fUsaRotinaWMS And (fProdutoLocalizacaoFisicaPicking(dbeLocFis.Text) <> '') And
                                      (fProdutoLocalizacaoFisicaPicking(dbeLocFis.Text) <> dbeCodIte.Text) Then
            Begin
              strItem := fProdutoLocalizacaoFisicaPicking(dbeLocFis.Text);
              pMensagemOk('Localização Física Picking reservada para o produto ' + strItem + '-' + fRetNomProduto(strItem) + '!');
              Result := False;
            End

            Else If (Not blnEdicaoPicking) And ((fUsaRotinaWMS) And (blnLotPic) And (not fEmptyStr(dbeNumLot.Text))
                    And (objCadLot.fTemLocalizacaoFisicaComLotePicking(dbeLocFis.Text, VS_strCodEmp, dbeCodIte.Text, True, strAutIncLoteComPicking)))
                    And (Not blnInativouLote) And (Not SameText(strLocalOld, dbeLocFis.Text)) Then
            Begin
              pMensagemOk(' Está configurado para utilizar apenas um lote do produto por localização PICKING (CFG_LOTPIC)' + #10#13 +
                          ' portanto não pode ser utilizada a Localização Física: ' + dbeLocFis.Text + ' para o Lote: ' + dbeNumLot.Text);
              Result:= False;
            End

            Else If (fUsaRotinaWMS And
                     fCfgSis('PICOUT', varBoolean) And
                     fJahExisteLotePickingCheckOut(dbeNumLot.Text, VS_strCodEmp, dbeCodIte.Text)) Then
            Begin
              Result := False;
            End

            Else If (Not blnArmazem) And (Not fUsaRotinaWMS) And objCadLot.fTemProdutoComLocFisica(dbeLocFis.Text, strItem, fltSalLot, fltSalLotML, '') Then
            Begin

              If fltSalLot <> 0 Then
              Begin

                If strTraLoc <> 'N' then
                  pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                              ' já está cadastrado com essa localização física e está com saldo diferente de zero!');

                If strTraLoc = 'T' then
                  Result := False;

                blnRemoverLocFis := False;
              End Else
              Begin

                If (dbeLocFis.Text <> strLocTst) Then
                Begin

                  If fCfgSis('EXBMLF', varBoolean) Then
                  Begin
                    If Not fPergunta('Existem lotes com a mesma Localização Física cadastrada.'
                                    +' Deseja remover a Localização física de todos os lotes com a'
                                    +' mesma Localização Fisica cadastrada?', False) Then
                    Begin

                      If strTraLoc = 'T' then
                        Result := False;

                      blnRemoverLocFis := False;
                    End Else
                    Begin

                      blnRemoverLocFis := fCarregaDadosLoteLocFisica(qryTabela.FieldByName('LOT_CODITE').AsString,
                                                      qryTabela.FieldByName('LOT_NUMLOT').AsString,
                                                      qryTabela.FieldByName('LOT_LOCFIS').AsString);

                    End;
                  End;

                  If Result then
                    strLocTst := dbeLocFis.Text
                  Else
                    dbeLocFis.Text := strLocTst;
                End;
              End;
            End

            Else
            begin
              If objCadLot.fTemLoteComLocFisica(dbeLocFis.Text, strItem, strLote, fltSalLot, fltSalLotML,
                                                     dbeCodIte.Text, dbeNumLot.Text) Then
              Begin
                If fUsaRotinaWMS Then
                Begin
                  If ((fProdutoLocalizacaoFisicaPicking(dbeLocFis.Text) <> '') And (dbeCodIte.Text <> strItem)) Then
                  Begin
                    If (objCadLot.fRetLotePrincipalTintaMaquina(strItem, VS_strCodEmp) <> strLote) Then
                    Begin
                      pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                                  ' (' + objCadLot.strTitLab + ' ' + strLote + ') já está cadastrado com essa localização física!');
                      Result := False;
                    End;
                  End
                End

                Else If fltSalLot <> 0 Then
                Begin

                  If strTraLoc <> 'N' then
                    pMensagemOk('O produto ' + strItem + '-' + fRetNomProduto(strItem) +
                                ' (' + objCadLot.strTitLab + ' ' + strLote + ') já está cadastrado com essa localização física e está com saldo diferente de zero!');

                  If strTraLoc = 'T' then
                    Result := False;

                  blnRemoverLocFis := False;
                End Else
                Begin

                  If (dbeLocFis.Text <> strLocTst) Then
                  Begin
                    If fCfgSis('EXBMLF', varBoolean) Then
                    Begin
                      If Not fPergunta('Existem lotes com a mesma Localização Física cadastrada.'
                                      +' Deseja remover a Localização física de todos os lotes com a'
                                      +' mesma Localização Fisica cadastrada?', False) Then
                      Begin

                        If strTraLoc = 'T' then
                          Result := False;

                        blnRemoverLocFis := False;
                      End Else
                      Begin
                        blnRemoverLocFis := fCarregaDadosLoteLocFisica(qryTabela.FieldByName('LOT_CODITE').AsString,
                                                                      qryTabela.FieldByName('LOT_NUMLOT').AsString,
                                                                      qryTabela.FieldByName('LOT_LOCFIS').AsString);
                      End;
                    End;

                    If Result then
                      strLocTst := dbeLocFis.Text
                    Else
                      dbeLocFis.Text := strLocTst;

                  End;
                End;

              End;

              If Result And blnArmazem And Not fUsaRotinaWMS Then
              Begin

                If fEmptyStr(fRetCodArmazemLocFisica(dbeLocFis.Text)) Then
                Begin
                  pMensagemOk('A localização física informada não possui código do armazém em seu cadastro, verifique!');
                  Result := False;
                  blnRemoverLocFis := False;
                End
                Else If (qryTabela.State = dsEdit) And //Quando estiver alterando a localizacao fisica deve ser selecionado uma
                        (Not fEmptyStr(dbeNumLot.Text)) And
                        (fRetCodArmazemLocFisica(dbeLocFis.Text) <> dbeNumLot.Text) Then // pertencente ao mesmo armazém "Lote"
                Begin
                  pMensagemOk('A localização física deve pertencer ao mesmo armazém do cadastro inicial (' + dbeNumLot.Text + ')!');
                  Result := False;
                  blnRemoverLocFis := False;
                End
                Else
                Begin
                  dbeNumLot.Field.AsString := fRetCodArmazemLocFisica(dbeLocFis.Text);
                  edtDescArmazem.Text := fRetNomeArmazem(dbeNumLot.Field.AsString);
                End;
              End;

            end;
          End

          else
          begin

            If fUtilizandoCadastroRapidoLoteWMS Then
            Begin
              pMensagemOk('A localização física deve ser informada na inclusão rápida de lotes!');
              Result := False;
            End

            else If fUsaRotinaWMS and (dbeNumLot.Text <> 'A DEFINIR') Then
            Begin
              pMensagemOk('A localização física deve ser informada quando utiliza WMS!');
              Result := False;
            End

            Else If blnArmazem Then
            Begin

              With qryTabela Do
              If (State = dsInsert) Then
              Begin
                pHabilitaNumLot(True);
              End;

            End;

          end;

        End
        Else
        Begin
          If (fEmptyStr(dbeLocFis.Text)) and (dbeLocFis.Enabled) Then
          Begin
            pMensagemOk('A localização física deve ser informada!');
            Result := False;
            blnRemoverLocFis := False;
          End;
        End;

        If Result then
          strLocTst := dbeLocFis.Text;
      End

      Else If (Sender = dbeCapaci) Then
      Begin
        If fEmptyStr(dbeCapaci.Text) Then
          dbeCapaci.Text := FormatFloat(fMskDigitos(objCadLot.intDecQtd), 0);
        objCadLot.fltCapaci := fStrToFloat(dbeCapaci.Text);
      End

      Else If (Sender = dbePonRep) Then
      Begin
        If fEmptyStr(dbePonRep.Text) Then
          dbePonRep.Text := FormatFloat(fMskDigitos(objCadLot.intDecQtd), 0);
        objCadLot.fltPonRep := fStrToFloat(dbePonRep.Text);
      End

    Except

      On E: ExceptionCadLot Do
      Begin
				fMensagem('', E.Message,['&Ok']);
        Result := False;
      End;

      On E: Exception Do
      Begin
				pMensagensErro(E.Message,'[TfrmCadLoteItens.fValidaCampos]');
        Result := False;
      End;
    End;

  End;

  If Not Result Then
  Begin
    objSender := Sender;
    pSetFocus(Sender);
  End;

end;

function TfrmCadLoteItens.fValidaPickingLaboratorioItemBase: Boolean;
begin
  Result := True;

  If fEmptyStr(dbeCodIte.Text) Then
    Exit;

  If Not SameText(dbeStatus.Text, 'ATIVO') Then
    Exit;

  If Not fEhLocalizacaoFisicaPickingLaboratorio(dbeLocFis.Text) Then
    Exit;

  Result := (fCampoTabela('ITE_ITEBAS', 'CADITE', ['ITE_CODITE'], [dbeCodIte.Text], False) = 'S');
end;

function TfrmCadLoteItens.fVerificaDuplicado: Boolean;
  Var
    qryLot: TUniQuery;
begin
  qryLot := fCriaQuery;
  Try
    With qryLot, SQL Do
    Begin
      Add('SELECT SQL_NO_CACHE');
      Add('  COUNT(1)');
      Add('FROM');
      Add('  CADLOT');
      Add('WHERE');
      Add('  LOT_NUMLOT = :NUMLOT AND');
      Add('  LOT_CODEMP = :CODEMP AND');
      Add('  LOT_CODITE = :CODITE ');

      If dtsCadLot.State = dsEdit Then
        Add('  AND AUTOINCREM <> :AUTINC');

      ParamByName('NUMLOT').AsString := dbeNumLot.Text;
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('CODITE').AsString := dbeCodIte.Text;

      If dtsCadLot.State = dsEdit Then
        ParamByName('AUTINC').AsString := qryCadLot.FieldByName('AUTOINCREM').AsString;

      Open;

      Result := Fields[0].AsInteger > 0;
      
      Close;
    End;
  Finally
    FreeAndNil(qryLot);
  End;
end;

procedure TfrmCadLoteItens.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('LOT_NUMLOT');
  stlCampos.Add('LOT_CODITE');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('LOT_NUMLOT');
  stlCamInd.Add('LOT_CODITE');
  stlCamInd.Add('LOT_DTAFAB');
  stlCamInd.Add('LOT_DTAVAL');

  stlDesInd.Add('Núm.Lote');
  stlDesInd.Add('Cód.Item');
  stlDesInd.Add('Fabricação');
  stlDesInd.Add('Validade');
end;

procedure TfrmCadLoteItens.pOnGetTextStatus(Sender: TField; var Text: string;
  DisplayText: Boolean);
begin
  if not fEmptyStr(Sender.AsString) then
    Case Sender.AsString[1] of
      'S': Text := 'ATIVO';
      'N': Text := 'INATIVO';
      'B': Text := 'BLOQUEADO';
    end;
end;

procedure TfrmCadLoteItens.pOnSetTextStatus(Field: TField; const Text: String);
begin
  Case AnsiIndexStr(Text,['ATIVO','INATIVO', 'BLOQUEADO']) of
    0: Field.AsString := 'S';
    1: Field.AsString := 'N';
    2: Field.AsString := 'B';
  end;
end;

procedure TfrmCadLoteItens.pOnStateChange;
begin
  inherited;
if btnAlterar.Enabled then
    btnAlterar.Enabled := (Not (SameText(dbeNumLot.Text, 'A DEFINIR')) And (qryTabela.FieldByName('LOT_TRANSI').AsString = 'N'));

  if btnExcluir.Enabled then
    btnExcluir.Enabled := ((Not SameText(dbeNumLot.Text, 'A DEFINIR')) Or (SameText(dbeNumLot.Text, 'GARANTIA'))) And (qryTabela.FieldByName('LOT_TRANSI').AsString = 'N');
end;

procedure TfrmCadLoteItens.pProcessaCodbar(strCodbar: string);
begin
  If strCodbar = '' Then
    Exit;
end;

procedure TfrmCadLoteItens.pProcessarOpcoesLote(ATForm: TForm; ABloqueio: Boolean);
  const
    arrFields : Array[0..8] of String = ('LOT_PRIPRO', 'LOT_ARMPRC', 'LOT_GARPRI',
                                         'LOT_EQPPRI', 'LOT_PRITIN', 'LOT_BROKER',
                                         'LOT_CRODOC', 'LOT_ABSAUT', 'LOT_ARMPCE');
  var
    LCntObj : Integer;
    LCntFil : Integer;
    LField_ : String;
    LNCheck : String;
begin

  if not Assigned(ATForm) then
    Exit;

  for LCntObj := 0 to Pred(ATForm.ComponentCount) do
  begin
    if (ATForm.Components[LCntObj] is TDBCheckBox) then
    begin
      for LCntFil := 0 to Pred(Length(arrFields)) do
      begin
        LField_ := TDBCheckBox(ATForm.Components[LCntObj]).DataField;
        if LField_.Equals(arrFields[LCntFil]) then
        begin
          LNCheck := TDBCheckBox(ATForm.Components[LCntObj]).ValueUnchecked;
          TDBCheckBox(ATForm.Components[LCntObj]).Enabled := not ABloqueio;
          if (ABloqueio) then
            if (TDBCheckBox(ATForm.Components[LCntObj]).DataSource.DataSet.State in [dsInsert, dsEdit]) then
              TDBCheckBox(ATForm.Components[LCntObj]).DataSource.DataSet.FieldByName(LField_).AsString := LNCheck;
        end;
      end;
    end;
  end;

end;

procedure TfrmCadLoteItens.pQryAfterOpen(DataSet: TDataSet);
begin
  objCadLot.pAfterOpen(DataSet);
  qryCadLot.FieldByName('LOT_STATUS').OnGetText := pOnGetTextStatus;
  qryCadLot.FieldByName('LOT_STATUS').OnSetText := pOnSetTextStatus;
  pQryAfterScroll(DataSet);
end;

procedure TfrmCadLoteItens.pQryAfterScroll(DataSet: TDataSet);
begin
  edtMotBlo.Text := qryCadLot.fieldByName('LOT_MOTBLO').AsString;
  if qryCadLot.fieldByName('LOT_STATUS').AsString = 'B' then
  begin
    if not pnlMotBlo.Visible then
    begin
      pnlMotBlo.Visible := True;
      Self.Height := Self.Height + pnlMotBlo.Height;
    end;
  end
  else
  begin
    if pnlMotBlo.Visible then
    begin
      pnlMotBlo.Visible := False;
      Self.Height := Self.Height - pnlMotBlo.Height;
    end;
  end;
end;

procedure TfrmCadLoteItens.pRenomeiaCamposPrecoVenda;
var
  intCont: Integer;
  strDesc: String;
begin
  strDesc := IIF(pnlPrecoVendaParcialEntrega.Visible, 'Preço de Venda - Retira ', 'Preço de Venda ');

  for intCont := 1 to 7 do
  begin
    TLabel(FindComponent('lblPreVe' + intToStr(intCont))).Caption := strDesc + intCont.ToString + ':';
    TLabel(FindComponent('lblVenTo' + intToStr(intCont))).Caption := strDesc + intCont.ToString + ':';
  end;

  if pnlPrecoVendaParcialEntrega.Visible then
  begin
    for intCont := 1 to 7 do
    begin
      TLabel(FindComponent('lblPrVeE' + intToStr(intCont))).Caption := 'Preço de Venda - Entrega ' + intCont.ToString + ':';
      TLabel(FindComponent('lblVeToE' + intToStr(intCont))).Caption := 'Preço de Venda - Entrega ' + intCont.ToString + ':';
    end;
  end;
end;

procedure TfrmCadLoteItens.pValidarOpcoesLocPickingCheckOut;
begin
  If (fUsaRotinaWMS And fCfgSis('PICOUT', varBoolean)) Then
    pProcessarOpcoesLote(Self, fEhLocalizacaoPickingCheckOut(dbeLocFis.Text, VS_strCodEmp));

  If fUsaPickingLaboratorioWms Then
    pProcessarOpcoesLote(Self, fEhLocalizacaoFisicaPickingLaboratorio(dbeLocFis.Text));
end;

procedure TfrmCadLoteItens.btnImprimirClick(Sender: TObject);
var
  strCfgTipEti: String;
  intOpcFor: Integer;
  ArrNomEti: TStringArray;
  prmDllEtq: TParamDllEtiquetas;
begin
  inherited;
  If dtsCadLot.DataSet.IsEmpty Then
  Begin
    pMensagemOk('Nenhum lote selecionado para impressão da Etiqueta.');
    Exit;
  End;

  If (dtsCadLot.State in dsEditModes) Then
  Begin
    pMensagemOk('Etiqueta não pode ser impressa em edição.');
    Exit;
  End;

  prmDllEtq := TParamDllEtiquetas.Create;
  Try
    prmDllEtq.strCodEmp := ShortString(String(VS_strCodEmp));

    strCfgTipEti := fCfgSis('ETILOP');
    If ((fEmptyStr(strCfgTipEti)) OR (strCfgTipEti = 'S') ) Then
    Begin
      SetLength(ArrNomEti, 0);
      pAddDados(ArrNomEti, 'Laser');
      pAddDados(ArrNomEti, 'Argox');
      intOpcFor := fGetMenu('Escolha o Modelo:', ArrNomEti, 1, True);
      Case intOpcFor Of
        1: strCfgTipEti := 'L';
        2: strCfgTipEti := 'A';
      Else
        strCfgTipEti := 'L';
      End;
    End;

    prmDllEtq.tpeTipEtq := IIf(strCfgTipEti = 'L', tpeLoteProduto, tpeLoteProdutoArgox);
    SetLength(prmDllEtq.ArrLoteProdutoEtiq, 1);

    prmDllEtq.ArrLoteProdutoEtiq[0].strAutInc := ShortString(dtsCadLot.DataSet.FieldByName('AUTOINCREM').AsString);
    prmDllEtq.ArrLoteProdutoEtiq[0].intQtdEti := StrToIntDef(InputBox('Digite a quantidade de Etiquetas!', 'Quantidade', '1'), 0);
    If prmDllEtq.ArrLoteProdutoEtiq[0].intQtdEti = 0 Then
      pMensagemOk('É preciso digitar uma quantidade maior que zero para imprimir a etiqueta.')
    Else
      fImprimeEtiqueta(prmDllEtq, 'fImprimeEtiquetasLoteProduto');
  Finally
    FreeAndNil(prmDllEtq);
  End;
end;

procedure TfrmCadLoteItens.btnImprimirEtiquetasClick(Sender: TObject);
var
  prmDllEtq: TParamDllEtiquetas;
begin
  inherited;
  If qryTabela.FieldByName('LOT_CHAPA_').AsString <> 'S' Then
  Begin
    pMensagemOk('Este lote não é chapa de Mármore / Granito!');
    Exit;
  End;

  prmDllEtq := TParamDllEtiquetas.Create;
  Try
    prmDllEtq.strCodEmp := ShortString(String(VS_strCodEmp));
    If fCfgSis('ETIMAR') = 'L' Then
      prmDllEtq.tpeTipEtq :=  tpeMarmoreGranito
    Else
      prmDllEtq.tpeTipEtq :=  tpeMarmoreGranitoArgox;

    SetLength(prmDllEtq.ArrLoteProdutoEtiq, 1);

    prmDllEtq.ArrLoteProdutoEtiq[0].strAutInc := ShortString(dtsCadLot.DataSet.FieldByName('AUTOINCREM').AsString);
    prmDllEtq.ArrLoteProdutoEtiq[0].intQtdEti := StrToIntDef(InputBox('Digite a quantidade de Etiquetas!', 'Quantidade', '1'), 0);
    If prmDllEtq.ArrLoteProdutoEtiq[0].intQtdEti = 0 Then
      pMensagemOk('É preciso digitar uma quantidade maior que zero para imprimir a etiqueta.')
    Else
      fImprimeEtiqueta(prmDllEtq, 'fImprimeEtiquetasLoteProduto');
  Finally
    FreeAndNil(prmDllEtq);
  End;


end;

procedure TfrmCadLoteItens.btnIncluirClick(Sender: TObject);
begin
  inherited;
  plimpaEventoClickChecAprovado;
  strLocTst := '';
  blnInclusao := True;
  pLimparCampos;
  btnDividirChapa.Enabled := False;

  With qryTabela Do
  Begin
    FieldByName('LOT_CODEMP').AsString   := VS_strCodEmp;
    FieldByName('LOT_DTABAL').AsDateTime := VS_Date - 1;
    FieldByName('LOT_SALBAL').AsFloat    := 0;
    FieldByName('LOT_SALDOS').AsFloat    := 0;
    FieldByName('LOT_ML_BAL').AsFloat    := 0;
    FieldByName('LOT_SAL_ML').AsFloat    := 0;
    FieldByName('LOT_PRECUS').AsFloat    := 0;
    FieldByName('LOT_PREVEN').AsFloat    := 0;
    FieldByName('LOT_CAPACI').AsFloat    := 0;
    FieldByName('LOT_PONREP').AsFloat    := 0;
    FieldByName('LOT_CUSTOT').AsFloat    := 0;
    FieldByName('LOT_VENTOT').AsFloat    := 0;
    FieldByName('LOT_PREVEE').AsFloat    := 0;
    FieldByName('LOT_VENTOE').AsFloat    := 0;
    FieldByName('LOT_PREVE1').AsFloat    := 0;
    FieldByName('LOT_PREVE2').AsFloat    := 0;
    FieldByName('LOT_PREVE3').AsFloat    := 0;
    FieldByName('LOT_PREVE4').AsFloat    := 0;
    FieldByName('LOT_PREVE5').AsFloat    := 0;
    FieldByName('LOT_PREVE6').AsFloat    := 0;
    FieldByName('LOT_PREVE7').AsFloat    := 0;
    FieldByName('LOT_PRVEE1').AsFloat    := 0;
    FieldByName('LOT_PRVEE2').AsFloat    := 0;
    FieldByName('LOT_PRVEE3').AsFloat    := 0;
    FieldByName('LOT_PRVEE4').AsFloat    := 0;
    FieldByName('LOT_PRVEE5').AsFloat    := 0;
    FieldByName('LOT_PRVEE6').AsFloat    := 0;
    FieldByName('LOT_PRVEE7').AsFloat    := 0;
    FieldByName('LOT_VENTO1').AsFloat    := 0;
    FieldByName('LOT_VENTO2').AsFloat    := 0;
    FieldByName('LOT_VENTO3').AsFloat    := 0;
    FieldByName('LOT_VENTO4').AsFloat    := 0;
    FieldByName('LOT_VENTO5').AsFloat    := 0;
    FieldByName('LOT_VENTO6').AsFloat    := 0;
    FieldByName('LOT_VENTO7').AsFloat    := 0;
    FieldByName('LOT_VETOE1').AsFloat    := 0;
    FieldByName('LOT_VETOE2').AsFloat    := 0;
    FieldByName('LOT_VETOE3').AsFloat    := 0;
    FieldByName('LOT_VETOE4').AsFloat    := 0;
    FieldByName('LOT_VETOE5').AsFloat    := 0;
    FieldByName('LOT_VETOE6').AsFloat    := 0;
    FieldByName('LOT_VETOE7').AsFloat    := 0;
    FieldByName('LOT_ARMOPV').AsString   := 'N';
    FieldByName('LOT_ARMPRI').AsString   := 'N';
    FieldByName('LOT_ARMPRC').AsString   := 'N';
    FieldByName('LOT_STATUS').AsString   := 'S';
    FieldByName('LOT_VENTDO').AsString   := 'N';
    FieldByName('LOT_GARPRI').AsString   := 'N';
    FieldByName('LOT_PRITIN').AsString   := 'N';
    FieldByName('LOT_EQPPRI').AsString   := 'N';
    FieldByName('LOT_PRIPRO').AsString   := 'N';
    FieldByName('LOT_PRIIND').AsString   := 'N';
    FieldByName('LOT_ABSAUT').AsString   := 'S';
    FieldByName('LOT_BROKER').AsString   := 'N';
    FieldByName('LOT_CRODOC').AsString   := 'N';
    FieldByName('LOT_ARMPCE').AsString   := 'N';
    FieldByName('LOT_ARMFUL').AsString   := 'N';
    FieldByName('LOT_TRANSI').AsString   := 'N';

    If fCfgSis('DFLALG') = 'S' then
      FieldByName('LOT_LOTAPR').AsString   := 'N'
    Else
      FieldByName('LOT_LOTAPR').AsString   := 'S';
  End;

  pHabilitaCodigo(dbeNumLot, dbeCodIte, True);
  pHabilitaCamposMarmore(True);

  edtLOT_NCHAPA.Clear;
  edtValM2Liquido.Clear;
  edtLOT_MEDB_L.Clear;
  edtLOT_MEDB_A.Clear;
  edtLOT_MEDL_L.Clear;
  edtLOT_MEDL_A.Clear;
  edtLOT_ESPESS.Clear;

  If fUtilizandoCadastroRapidoLoteWMS Then
  Begin
    btnIncluir.Visible  := False;
    btnAlterar.Visible  := False;
    btnExcluir.Visible  := False;
    btnPesquisa.Visible := False;
    dbeNumLot.ReadOnLy  := True;
    dbeCodIte.ReadOnLy  := True;
  End;
  If pnlCodbar.Visible Then
    pSetFocus(edtCodbar);

  pExibeMensagemLoteTransitorio(True);
  pSetEventoClickChecAprovado;
end;

procedure TfrmCadLoteItens.pExibeMensagemLoteTransitorio(ALimpar: Boolean = False);
begin
  If (Not ALimpar) Then
  Begin
    pnlInfo.Caption := '* Lote Transitório criado para controle interno do sistema. Não permite alteração.';
    pnlInfo.Font.Color := clRed;
  End
  Else
  Begin
    pnlInfo.Caption := '';
    pnlInfo.Font.Color := clBlack;
  End;
end;

procedure TfrmCadLoteItens.btnAlterarClick(Sender: TObject);
begin
  inherited;
  If (qryTabela.Active) And (qryTabela.IsEmpty) Then
    Exit;
  If qryTabela.Active And (qryTabela.FindField('LOT_FULFIL') <> nil) And (qryTabela.FieldByName('LOT_FULFIL').AsString.Equals('S')) Then
  Begin
    pMensagemOk('Não é permitido alterar o ' + objCadLot.strDescri + ' de um Estoque Externo!');
    btnCancela.Click;
    Exit;
  End;
  blnInclusao:= False;
  btnDividirChapa.Enabled := False;

  strLocTst  := '';
  strCodIte  := dbeCodIte.Text;
  strLocalOld:= dbeLocFis.Text;
  strLoteOld := dbeNumLot.Text;


  pHabilitaCodigo(dbeCodIte, dbeDtaFab, False);
  If (not blnCadLoc) and (blnArmazem) Then
    pHabilitaCodigo(dbeNumLot, dbeDtaFab, True)
  Else
    pHabilitaCodigo(dbeNumLot, dbeDtaFab, False);

  pHabilitaLocFis((Not SameText(dbeNumLot.Text, 'A DEFINIR') And (qryTabela.FieldByName('LOT_TRANSI').AsString = 'N')));
  pHabilitaNumLot(Not SameText(dbeNumLot.Text, 'GARANTIA'));
  pHabilitaCamposMarmore(True);

  With qryTabela Do
  If State = dsEdit then
  Begin
    If FieldByName('LOT_PRECUS').IsNull Then
      FieldByName('LOT_PRECUS').AsFloat := 0;

    If FieldByName('LOT_PREVEN').IsNull Then
      FieldByName('LOT_PREVEN').AsFloat := 0;
  End;

  pValidarOpcoesLocPickingCheckOut;
  pSetEventoClickChecAprovado;
end;

procedure TfrmCadLoteItens.dbcLotAprClick(Sender: TObject);
var
  blnChecked: Boolean;
begin
  inherited;
  if not (qryTabela.State in dsEditModes) then
    Exit;

  blnChecked := Not dbcLotApr.Checked;

  if (qryTabela.State = dsEdit) then
    If fCfgSis('ALGSOL', varBoolean) then
    Begin

      If fLiberaTrocaStatusLoteAprovado then
      Begin
        plimpaEventoClickChecAprovado;
        Try
          qryTabela.FIeldByName('LOT_LOTAPR').AsString := IfThen(qryTabela.FIeldByName('LOT_LOTAPR').AsString = 'S','N','S');
          dbcLotApr.Checked := qryTabela.FIeldByName('LOT_LOTAPR').AsString = 'S';
        Finally
          pSetEventoClickChecAprovado;
        End;
        Exit;
      End
      Else
      Begin
        Try
          plimpaEventoClickChecAprovado;
          dbcLotApr.Checked := blnChecked;
        Finally
          pSetEventoClickChecAprovado;
        End;
      End;
    End;
end;

procedure TfrmCadLoteItens.dbeCodIteKeyPress(Sender: TObject;
  var Key: Char);
  Var
    qryCadIte: TUniQuery;
    arrSel : TConsultasArray;
begin
  inherited;
  If dbeCodIte.ReadOnLy Then
    Exit;

  If fEntraCons(Key) Then
  Begin
    qryCadIte := fCriaQuery;
    if fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, qryCadIte, Key, arrSel, True, nil, 'Consulta de Itens', '1') then
    Begin
      If fValidaCampos(dbeCodIte, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
    FreeAndNil(qryCadIte);
  End;
end;

procedure TfrmCadLoteItens.dbeCroDocClick(Sender: TObject);
  Var
    strLoteEncontrado: String;
begin
  inherited;

  If btnCancela.Focused Then
    Exit;

  If dbeCroDoc.Checked Then
  Begin

    If TCadLot.fTemCrossdocking(dbeCodIte.Text, VS_strCodEmp, dbeNumLot.Text, strLoteEncontrado) Then
    Begin

      dbeCroDoc.Checked := False;

      pMensagemOk('O Lote ' + strLoteEncontrado + ' já está cadastrado como crossdocking!');
    End;

  End;

end;

function TfrmCadLoteItens.dbeLocFisChamaCadastro(Key: Word): string;
begin
  inherited;
  if blnCadLoc then
    Result := untFuncInsFactory.fChamaCadLocFisica(Key);
end;

procedure TfrmCadLoteItens.dbeLocFisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If blnCadLoc And fPesqLocFisica(Self, dbeLocFis, Nil, Nil, Key, arrSel) And
     fValidaCampos(dbeLocFis, True) Then
    SelectNext(ActiveControl, True, True);

end;                                         

procedure TfrmCadLoteItens.dbeLocSepKeyPress(Sender: TObject; var Key: Char);
  Var
    arrLocSep : TConsultasArray;
begin
  inherited;

  If fPesqLocSep(Self, dbeLocSep, edtDesLocSep, Nil, Key, arrLocSep) Then
  Begin
    If fValidaCampos(dbeLocSep, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadLoteItens.dbeNumLotKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  If ((Not blnCadLoc) Or fEmptyStr(dbeLocFis.Text)) And (blnArmazem) And
     fPesqArmazem(Self, dbeNumLot, edtDescArmazem, nil, Key, arrSel) Then
  Begin
    If fValidaCampos(dbeNumLot, True) Then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadLoteItens.dbeStatusChange(Sender: TObject);
var
  strStatus: String;
begin
  inherited;
  Case AnsiIndexStr(dbeStatus.Text, ['ATIVO','INATIVO', 'BLOQUEADO']) of
    0: strStatus := 'S';
    1: strStatus := 'N';
    2: strStatus := 'B';
  end;

  blnInativouLote := (strStatusOriginal <> strStatus) And (strStatus = 'N');
end;

procedure TfrmCadLoteItens.edtCodbarEnter(Sender: TObject);
begin
  inherited;
  edtCodbar.Text := '';
end;

function TfrmCadLoteItens.fInativarLote(blnExcluir : Boolean = False; blnApenasValidaSaldo: boolean = False): Boolean;
  Var
    qryTmpLot : TUniQuery;
    strSQL    : String;
    strCodEmp : String;
begin
  inherited;

  Result := True;

  If (dbeStatus.Text = 'INATIVO') Or blnExcluir Then
  Begin
    qryTmpLot := fCriaQuery;
    Try

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + ' LOT_CODEMP, LOT_SALDOS, LOT_SAL_ML ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  CADLOT ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  LOT_CODITE = :CODITE AND ';
      strSQL := strSQL + '  LOT_NUMLOT = :NUMLOT AND ';
      strSQL := strSQL + ' (LOT_SALDOS + LOT_SAL_ML) <> 0 ';
      strSQL := strSQL + 'GROUP BY ';
      strSQL := strSQL + '  LOT_CODEMP ';

      With qryTmpLot Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('CODITE').AsString := dbeCodIte.Text;
        ParamByName('NUMLOT').AsString := dbeNumLot.Text;

        Open;

        strCodEmp := '';

        While Not Eof Do
        Begin
          strCodEmp := strCodEmp + FieldByName('LOT_CODEMP').AsString + ', ';
          Next;
        End;

        Close;
      End;

      If strCodEmp <> '' Then
      Begin

        strCodEmp := Copy(strCodEmp, 1, Length(strCodEmp) - 2);

        fMensagem('', 'Este Lote possui saldo na(s) empresa(s): ' + strCodEmp + '. ' + #13 + 'Não é possível' + IIf(blnApenasValidaSaldo, ' inativá-lo !', ' continuar !'), ['&O K']);

        pSetFocus(dbeStatus);

        Result := False;

      End;
      If blnApenasValidaSaldo Then
        Exit;

      If Result Then
      Begin
        With qryTmpLot, SQL Do
        Begin

          If fUpdateADefinir(blnExcluir, qryTabela) then
          Begin
            Close;
            Clear;
            Add(strSQL);

            ParamByName('CODITE').AsString := dbeCodIte.Text;
            ParamByName('NUMLOT').AsString := 'A DEFINIR';

            Open;

            strCodEmp := '';

            While Not Eof Do
            Begin
              strCodEmp := strCodEmp + FieldByName('LOT_CODEMP').AsString + ', ';
              Next;
            End;

            Close;
          End;
        End;

        If strCodEmp <> '' Then
        Begin

          strCodEmp := Copy(strCodEmp, 1, Length(strCodEmp) - 2);

          fMensagem('', 'O Lote "A DEFINIR" possui saldo na(s) empresa(s): ' + strCodEmp + '. ' + #13 + 'Não é possível continuar !', ['&O K']);

          pSetFocus(dbeStatus);

          Result := False;

        End;

      End;
    Finally
      FreeAndNil(qryTmpLot);
    End;
  End;

end;

function TfrmCadLoteItens.fJahExisteLotePickingCheckOut(ANumLot, ACodEmp, ACodIte: String): Boolean;
  const
    SQL = 'SELECT                    '+
          '  T.LOT_NUMLOT AS NUMLOT, '+
          '  T.LOT_LOCFIS AS LOCFIS, '+
          '  L.LOC_DESCRI AS DESCRI  '+
          'FROM       '+
          '  CADLOT T '+
          '  INNER JOIN CADLOC L ON (L.LOC_CODLOC = T.LOT_LOCFIS AND '+
          '                          L.LOC_CODEMP = T.LOT_CODEMP)    '+
          'WHERE                          '+
          '  (T.LOT_STATUS = "S")     AND '+
          '  (T.LOT_CODITE = :CODITE) AND '+
          '  (T.LOT_CODEMP = :CODEMP) AND '+
          '  (L.LOC_PICKIN = "C")     AND '+
          '  (T.LOT_NUMLOT <> :NUMLOT)    ';

    MSG = 'É permitido ter apenas um lote ativo cadastrado e vinculado a uma localização Picking Check-out.' + #13 + #13 +
          'Portanto, escolha outra localização para continuar ou acerte o cadastro da localização física.  ' + #13 + #13 +
          'Lote que está ativo e já vinculado à localização picking-ckeck-out: [NUMLOT] - [LOCFIS]';
  var
    LqryAux : TUniQuery;
    LstrMsg : String;
begin

  If Not fEhLocalizacaoPickingCheckOut(dbeLocFis.Text, VS_strCodEmp) Then
    Exit(False);

  LqryAux := fCriaQuery;

  Try

    LqryAux.Close;
    LqryAux.SQL.Clear;
    LqryAux.SQL.Add(SQL);
    LqryAux.ParamByName('CODITE').AsString := ACodIte;
    LqryAux.ParamByName('CODEMP').AsString := ACodEmp;
    LqryAux.ParamByName('NUMLOT').AsString := ANumLot;
    LqryAux.Open;

    Result := Not LqryAux.IsEmpty;

    If (Result) Then
    Begin
      LstrMsg := MSG;
      LstrMsg := LstrMsg.Replace('[NUMLOT]', LqryAux.FieldByName('NUMLOT').AsString);
      LstrMsg := LstrMsg.Replace('[LOCFIS]', LqryAux.FieldByName('DESCRI').AsString);
      TfrmObservacao.fObservacao('ATENÇÃO!', LstrMsg);
    End;

  Finally
    FreeAndNil(LqryAux);
  End;

end;
function TfrmCadLoteItens.fCarregaDadosLoteLocFisica(strCodIte, strNumLot, strLocFis: String): Boolean;
var
  qryExt: TUniQuery;
  ArrRecordFields: TArrRecordFields;
Begin

  qryExt:= fCriaQuery();
  Try
    qryExt.Close;
    qryExt.SQL.Clear;
    qryExt.SQL.Add(' SELECT LOT_NUMLOT, LOT_LOCFIS FROM CADLOT ');
    qryExt.SQL.Add(' WHERE LOT_CODEMP =   :CODEMP ');
    qryExt.SQL.Add(' AND LOT_LOCFIS =     :LOCFIS ');
    qryExt.SQL.Add(' AND (NOT ((LOT_NUMLOT = :NUMLOT) ');
    qryExt.SQL.Add(' AND (LOT_CODITE = :CODITE)))   ');

    qryExt.ParamByName('LOCFIS').AsString:= strLocFis;
    qryExt.ParamByName('NUMLOT').AsString:= strNumLot;
    qryExt.ParamByName('CODITE').AsString:= strCodIte;
    qryExt.ParamByName('CODEMP').AsString:= VS_strCodEmp;

    qryExt.Open;

    Result := not qryExt.IsEmpty;

    If (Result) Then
    Begin

      SetLength(ArrRecordFields, 2);

      ArrRecordFields[0].strFieldName    := 'LOT_NUMLOT';
      ArrRecordFields[0].strFieldCaption := 'NUM LOTE';
      ArrRecordFields[1].strFieldName    := 'LOT_LOCFIS';
      ArrRecordFields[1].strFieldCaption := 'LOC FISICA';

      //Abre tela genérica e exibe os itens no grid
      Result := TfrmMsgGridGenerica.fMontaGridGenerico(ArrRecordFields, qryExt, 'LOTES QUE TERÃO A LOCALIZAÇÃO FISICA REMOVIDA:');

    End;

  Finally
    FreeAndNil(qryExt);
  End;

end;

function TfrmCadLoteItens.fLocalizacaoFisicaEmpresaManual(
  const AstrLocFis, AstrCodIte, AstrDesIte, AstrNumLot: String; const AblnCriaEmpresas: Boolean): TLocalizacaoFisicaEmpresaManual;
var
  LlstEmpresasWms: TStringList ;
  LintCnt: Integer ;
  LstrRetorno: String ;
  LqryConsulta: TUniQuery ;
  LcdsConsulta: TUniClientDataSet ;
  LfrmCadLoteLocalizacaoFisicaWmsEmpresas: TfrmCadLoteLocalizacaoFisicaWmsEmpresas ;
begin
  Result := Nil ;
  if not AblnCriaEmpresas then
    Exit ;

  Result := TLocalizacaoFisicaEmpresaManual.Create();
  LqryConsulta := fCriaQuery() ;
  LlstEmpresasWms := TStringList.Create ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add(' SELECT A.LOT_CODITE, C.ITE_DESITE, A.LOT_CODEMP, A.LOT_NUMLOT, A.LOT_LOCFIS, B.LOC_DESCRI ') ;
    LqryConsulta.SQL.Add(' FROM CADLOT A ') ;
    LqryConsulta.SQL.Add('      LEFT JOIN CADLOC B ON B.LOC_CODLOC = A.LOT_LOCFIS AND B.LOC_CODEMP = A.LOT_CODEMP ') ;
    LqryConsulta.SQL.Add('      LEFT JOIN CADITE C ON A.LOT_CODITE = C.ITE_CODITE ') ;
    LqryConsulta.SQL.Add(' WHERE FALSE; ') ;
    LqryConsulta.Open ;
    LcdsConsulta := fCriaClientDatset(LqryConsulta) ;
    try
      LlstEmpresasWms.Delimiter := ',' ;
      LlstEmpresasWms.StrictDelimiter := True ;
      LlstEmpresasWms.DelimitedText := fRetEmpresasWms(True) ;
      for LintCnt := 0 to LlstEmpresasWms.Count-1 do
      begin
        if LlstEmpresasWms.Strings[LintCnt] = VS_strCodEmp then
          Continue ;

        LstrRetorno := fCampoTabela('LOC_CODLOC', 'CADLOC', ['LOC_CODLOC', 'LOC_CODEMP'], [AstrLocFis, LlstEmpresasWms.Strings[LintCnt]], False) ;
        if fEmptyStr(LstrRetorno) then
        begin
          LcdsConsulta.Append ;
          LcdsConsulta.FieldByName('LOT_CODITE').AsString := AstrCodIte ;
          LcdsConsulta.FieldByName('ITE_DESITE').AsString := AstrDesIte ;
          LcdsConsulta.FieldByName('LOT_CODEMP').AsString := LlstEmpresasWms.Strings[LintCnt] ;
          LcdsConsulta.FieldByName('LOT_NUMLOT').AsString := AstrNumLot ;
          LcdsConsulta.Post ;
        end ;
        Result.Add(LlstEmpresasWms.Strings[LintCnt], LstrRetorno) ;
      end ;

      if not LcdsConsulta.IsEmpty then
      begin
        pCriarFormularios(TfrmCadLoteLocalizacaoFisicaWmsEmpresas, LfrmCadLoteLocalizacaoFisicaWmsEmpresas);
        try
          LfrmCadLoteLocalizacaoFisicaWmsEmpresas.dsLoteEmpresas.DataSet := LcdsConsulta ;
          LfrmCadLoteLocalizacaoFisicaWmsEmpresas.showModal;
          if LfrmCadLoteLocalizacaoFisicaWmsEmpresas.blnConfirma then
          begin
            LcdsConsulta.First ;
            while not LcdsConsulta.Eof do
            begin
              Result.Items[LcdsConsulta.FieldByName('LOT_CODEMP').AsString] := LcdsConsulta.FieldByName('LOT_LOCFIS').AsString ;
              LcdsConsulta.Next ;
            end ;
          end ;
        finally
          pFreeAndNil(LfrmCadLoteLocalizacaoFisicaWmsEmpresas);
        end;
      end ;

    finally
      FreeAndNil(LcdsConsulta) ;
    end ;
  finally
    FreeAndNil(LlstEmpresasWms) ;
    FreeAndNil(LqryConsulta) ;
  end ;

end;

function TfrmCadLoteItens.fLoteVendasADefinir: Boolean;
var
  strTitulo: String;
begin
  Result := False;
  strTitulo := '';

  If qryTabela.FieldByName('LOT_ARMPRI').AsString = 'S' Then
    strTitulo := chkArmPri.Caption
  Else
  If qryTabela.FieldByName('LOT_ARMOPV').AsString = 'S' Then
    strTitulo := chkArmOPV.Caption;

  If Not fEmptyStr(strTitulo) Then
  Begin
    If (blnArmazem) Then
      Result := SameText('A DEFINIR', fRetNomeArmazem(dbeNumLot.Text))
    Else
      Result := SameText('A DEFINIR', dbeNumLot.Text);
  End;

  If (Result) Then
  Begin
    fMensagem('ATENÇÃO', strTitulo + ' não pode ser "A DEFINIR"', ['&OK']);
    pSetFocus(chkArmPri);
  End;
end;

function TfrmCadLoteItens.fMostrarOpcaoLotePrincipalFulfillmentParaSubProdutos: Boolean;
begin

  Result := False;

  If Not fCfgSis('UTIFUL', varBoolean) Then
    Exit;

  If Not ((fCfgSis('BXSBIT') = '2') Or (fCfgSis('BXSBIT') = '3')) Then
    Exit;

  Result := True;

end;

procedure TfrmCadLoteItens.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrLotes: TConsultasArray;
begin

  {*****************************}
  {* NOVA CONSULTA DE LOTES    *}
  {**************************AC*}
  chrKey := '/';
  if fPesqLoteItens(Self, Nil, Nil, objCadLot.intDecUni, qryTabela, chrKey, arrLotes, True, '', '', False, False, stlItensComLoteSemLocalizacao) then
  begin
    If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
    Begin
      qryTabela.AfterOpen := pQryAfterOpen;
      objCadLot.pAfterOpen(qryTabela);
      pSetFocus(btnAlterar);
    End;
  end;

  pCarregaItem;
  pCarregaArmazem;
  pCarregaLocalizacao;
  pCarregaLocalSeparacao;
  pOnStateChange;
  If grpChapas.Visible Then
    pCarregaChapa;

  strStatusOriginal := qryTabela.FieldByName('LOT_STATUS').AsString;

  pExibeMensagemLoteTransitorio(qryTabela.FieldByName('LOT_TRANSI').AsString = 'N')

end;

procedure TfrmCadLoteItens.pCarregaChapa;
begin
  If blnVariasChapasPorLote Then
    If (qryTabela.FieldByName('LOT_MEDL_L').AsFloat = 0) Or (qryTabela.FieldByName('LOT_MEDL_A').AsFloat = 0) Then
      edtLOT_NCHAPA.Text := FormatFloat('0.0000', qryTabela.FieldByName('LOT_SALDOS').AsFloat)
    Else
      edtLOT_NCHAPA.Text := FormatFloat('0.0000', qryTabela.FieldByName('LOT_SALDOS').AsFloat / (qryTabela.FieldByName('LOT_MEDL_L').AsFloat * qryTabela.FieldByName('LOT_MEDL_A').AsFloat))
  Else
    edtLOT_NCHAPA.Text   := qryTabela.FieldByName('LOT_NCHAPA').AsString;
  edtValM2Liquido.Text := FormatFloat('0.0000', qryTabela.FieldByName('LOT_MEDL_L').AsFloat * qryTabela.FieldByName('LOT_MEDL_A').AsFloat);
  edtLOT_MEDB_L.Text   := FormatFloat('0.0000', qryTabela.FieldByName('LOT_MEDB_L').AsFloat);
  edtLOT_MEDB_A.Text   := FormatFloat('0.0000', qryTabela.FieldByName('LOT_MEDB_A').AsFloat);
  edtLOT_MEDL_L.Text   := FormatFloat('0.0000', qryTabela.FieldByName('LOT_MEDL_L').AsFloat);
  edtLOT_MEDL_A.Text   := FormatFloat('0.0000', qryTabela.FieldByName('LOT_MEDL_A').AsFloat);
  edtLOT_ESPESS.Text   := FormatFloat('0.0000', qryTabela.FieldByName('LOT_ESPESS').AsFloat);
End;

procedure TfrmCadLoteItens.chkArmOPVClick(Sender: TObject);
begin
  inherited;
  If chkArmOPV.Checked Then
    objCadLot.strArmOPV := 'S'
  Else
    objCadLot.strArmOPV := 'N';
end;

procedure TfrmCadLoteItens.chkArmPceClick(Sender: TObject);
begin
  inherited;
  objCadLot.strArmPce := IIF(chkArmPce.Checked, 'S', 'N');
end;

procedure TfrmCadLoteItens.chkArmPrCClick(Sender: TObject);
begin
  inherited;
  If chkArmPrC.Checked Then
    objCadLot.strArmPrC := 'S'
  Else
    objCadLot.strArmPrC := 'N';
end;

procedure TfrmCadLoteItens.chkArmPriClick(Sender: TObject);
begin
  inherited;

  If chkArmPri.Checked Then
    objCadLot.strArmPri := 'S'
  Else
    objCadLot.strArmPri := 'N';
end;

procedure TfrmCadLoteItens.chkGarPriClick(Sender: TObject);
begin
  inherited;
  if Not fValidarCheckGarantiaCliente then
    if objCadLot.qryTabela.State In dsEditModes then
      chkGarPri.Field.AsString := 'N';

  objCadLot.strGarPri := IIF(chkGarPri.Checked, 'S', 'N');
end;

procedure TfrmCadLoteItens.chkLotPriIndClick(Sender: TObject);
begin
  inherited;

  If chkLotPriInd.Checked Then
    objCadLot.strPriInd := 'S'
  Else
    objCadLot.strPriInd := 'N';
end;

function TfrmCadLoteItens.fValidarCheckGarantiaCliente: Boolean;
Begin
  Result := true;
  If chkGarPri.Checked then
    if Not SameText(qryTabela.fieldbyname('LOT_NUMLOT').asstring, 'GARANTIA') then
    Begin
      Result := false;
      pMensagemOk('Atenção! Não é permtido marcar este lote como principal para recebimento de garantia do cliente pois ele não é o lote GARANTIA');
    End;
End;

function TfrmCadLoteItens.fValidaSeExisteCadastroLote: Boolean;
var
  qryAux: TUniQuery;
begin
  {UNIQUE KEY `UK_CADLOT_02` (`LOT_CODEMP`,`LOT_CODITE`,`LOT_LOCFIS`,`LOT_DTAVAL`,`LOT_NUMLOT`),}
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT SQL_NO_CACHE AUTOINCREM  ');
    qryAux.SQL.Add(' FROM CADLOT                    ');
    qryAux.SQL.Add(' WHERE TRUE                     ');
    qryAux.SQL.Add('   AND LOT_CODITE = :CODITE     ');
    qryAux.SQL.Add('   AND LOT_CODEMP = :CODEMP     ');
    qryAux.SQL.Add('   AND LOT_LOCFIS = :LOCFIS     ');
    qryAux.SQL.Add('   AND LOT_DTAVAL = :DTAVAL     ');
    qryAux.SQL.Add('   AND LOT_NUMLOT = :NUMLOT     ');

    qryAux.ParamByName('CODITE').AsString := dbeCodIte.Text;
    qryAux.ParamByName('CODEMP').AsString := VS_StrCodEmp;
    qryAux.ParamByName('LOCFIS').AsString := dbeLocFis.Text;
    qryAux.ParamByName('DTAVAL').AsDateTime := StrToDate(dbeDtaVal.Text);
    qryAux.ParamByName('NUMLOT').AsString := dbeNumLot.Text;

    qryAux.Open;

    Result := Not qryAux.IsEmpty;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmCadLoteItens.fValidaSeExisteLoteLaborat: Boolean;
Var
  qryLot: TUniQuery;
begin
  qryLot := fCriaQuery;
  Try
    with qryLot, SQL do
    begin
      Clear;
      Add('SELECT SQL_NO_CACHE');
      Add('       COUNT(1) ');
      Add('FROM   CADITE ');
      Add('WHERE (ITE_ITEBAS = "S" OR ');
      Add('       ITE_ITEPIG = "S" OR ');
      Add('       ITE_CNV_ML > 0 )    ');
      Add('   AND ITE_CODITE = :CODITE');
      ParamByName('CODITE').AsString := dbeCodIte.Text;
      Open;

      If Fields[0].AsInteger > 0 Then
      begin
        Clear;
        Add('SELECT SQL_NO_CACHE');
        Add('       COUNT(1) ');
        Add('FROM   CADLOT L ');
        Add('WHERE L.LOT_NUMLOT = "LABORAT"');
        Add('   AND L.LOT_CODEMP = :CODEMP');
        Add('   AND L.LOT_CODITE = :CODITE');
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('CODITE').AsString := dbeCodIte.Text;
        Open;

        Result := (Fields[0].AsInteger > 0) or (Trim(dbeNumLot.Text) = 'LABORAT');
      end
      Else
        Result := True;

      Close;
    End;
  Finally
    FreeAndNil(qryLot);
  End;
end;

procedure TfrmCadLoteItens.chkPriTinClick(Sender: TObject);
begin
  inherited;
  objCadLot.strPriTin := IIF(chkPriTin.Checked, 'S', 'N');
end;

procedure TfrmCadLoteItens.btnExcluirClick(Sender: TObject);
  Var
    strNumLot,
    strCodIte: String;
begin
  With qryTabela Do
  Begin
    strNumLot := FieldByName('LOT_NUMLOT').AsString;
    strCodIte := FieldByName('LOT_CODITE').AsString;

    If not objCadLot.fTemDocumentoLote(strCodIte, '', strNumLot) Then
      If fInativarLote(True) Then
      Begin
        Try
          blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

          inherited;

          If blnExcluiu Then
          Begin
            objCadLot.pExcluirLoteTodasEmpresas(strCodIte, strNumLot, Self.Name);
            fCommit;
          End
          Else
            fRollBack;
        Except
          On E: Exception Do
          Begin
            fRollBack;
            pMensagensErro(E.Message, '[untCadLoteItens.btnExcluirClick]');
          End;
        End;

        pLimparCampos;
      End;
  End;
  plimpaEventoClickChecAprovado;
end;

procedure TfrmCadLoteItens.btnCancelaClick(Sender: TObject);
begin
  inherited;
  plimpaEventoClickChecAprovado;
  pCarregaItem;
  pCarregaArmazem;
  pCarregaLocalizacao;
  pCarregaLocalSeparacao;
  pHabilitaCamposMarmore(False);
  btnDividirChapa.Enabled := True;


  If fUtilizandoCadastroRapidoLoteWMS Then
  Begin
    blnFecharFormPai := True;
    Self.Repaint;
  End;

  blnInativouLote := False;
  strStatusOriginal := qryTabela.FieldByName('LOT_STATUS').AsString;

  If (qryTabela.FieldByName('LOT_TRANSI').AsString  ='S') Then
    pExibeMensagemLoteTransitorio;
end;

procedure TfrmCadLoteItens.btnDividirChapaClick(Sender: TObject);
begin
  If (qryTabela.FieldByName('LOT_CHAPA_').AsString <> 'S') Then
    Exit;
  If qryTabela.FieldByName('LOT_SALDOS').AsFloat = 0 Then
  begin
    pMensagemOk('Não é possível dividir chapa sem saldo!');
    Exit;
  End;

  If Assigned(PrcIniciaProcessoDivisaoDeChapa) Then
  Begin

    If fLock_Unlock(STR_TRAVA_LOTE + dbeCodIte.Text, True, False) Then
    Begin
      PrcIniciaProcessoDivisaoDeChapa(dbeNumLot.Text,
                                      RoundTo(StrToFloat(edtLOT_NCHAPA.Text), -2),
                                      qryTabela.FieldByName('LOT_SALDOS').AsFloat,
                                      dbeCodIte.Text,
                                      VS_StrCodEmp,
                                      ProgressBar1);
      qryTabela.Close;
      qryTabela.Open;
      pCarregaItem;
      pCarregaArmazem;
      pCarregaLocalizacao;
      pCarregaLocalSeparacao;
      pOnStateChange;
      If grpChapas.Visible Then
        pCarregaChapa;


      fLock_Unlock(STR_TRAVA_LOTE + dbeCodIte.Text, False, False);
    End
    Else
      TfrmMensagemTravaLote.pMostraTravaLote('O item ' + dbeCodIte.Text + ' está sendo utilizado na estação: ' + fGetHostLock(STR_TRAVA_LOTE + dbeCodIte.Text));
  End;
end;

Procedure TfrmCadLoteItens.pCarregaItem;
Begin
  edtDesIte.Text := fRetNomProduto(dbeCodIte.Text);
End;

procedure TfrmCadLoteItens.pCarregaLocalizacao;
begin
  If blnCadLoc Then
    edtDesLoc.Text := fRetNomLocFisica(dbeLocFis.Text);
end;

procedure TfrmCadLoteItens.pCarregaLocalSeparacao;
begin
  edtDesLocSep.Text := fRetLocSep(dbeLocSep.Text);
end;

procedure TfrmCadLoteItens.pCarregaPreSetAmz;
var qrySelect : TUniQUery;
begin
  qrySelect := fCriaQuery;
  Try
    qrySelect.sql.add('SELECT CADAMZ.* FROM CADAMZ');
    qrySelect.sql.add(' WHERE AMZ_REPAMZ = "S"');
    qrySelect.sql.add('   AND AMZ_CODEMP = "' + VS_StrCodEmp + '"');
    qrySelect.sql.add('   and AMZ_CODAMZ = "'+dbeNumLot.Text+'"');
    qrySelect.sql.add('    AND AMZ_ARMPRC = "S"');

    qrySelect.Open;

    If qrySelect.IsEmpty then
      Exit;

    chkPriPro.Checked := qrySelect.FieldByName('AMZ_PRIPRO').AsString = 'S';
    chkArmPrC.Checked := qrySelect.FieldByName('AMZ_ARMPRC').AsString = 'S';
    chkGarPri.Checked := qrySelect.FieldByName('AMZ_GARPRI').AsString = 'S';
    chkArmPri.Checked := qrySelect.FieldByName('AMZ_ARMPRI').AsString = 'S';
    chkPriTin.Checked := qrySelect.FieldByName('AMZ_PRITIN').AsString = 'S';

  Finally
    FreeAndNil(qrySelect);
  End;
end;

Class procedure TfrmCadLoteItens.pAtualizaStatusLoteADefinir(qryTabela: TUniQuery);
  Var
    qrySelect : TUniQuery;
Begin
  qrySelect := fCriaQuery;
  Try
    With qrySelect, SQL Do
    Begin

      Close;
      Clear;
      Add(' UPDATE CADLOT SET LOT_STATUS = IF(:STATUS = "N" AND LOT_SALDOS <> 0, LOT_STATUS, :STATUS)');
      Add(' WHERE LOT_CODITE = :CODITE             ');
      Add('   AND LOT_NUMLOT = :NUMLOT             ');

      ParamByName('CODITE').AsString := qryTabela.FieldByName('LOT_CODITE').AsString;
      ParamByName('NUMLOT').AsString := qryTabela.FieldByName('LOT_NUMLOT').AsString;
      ParamByName('STATUS').AsString := qryTabela.FieldByName('LOT_STATUS').AsString;
      ExecSql;

      If fUpdateADefinir(False, qryTabela) Then
      Begin
        Close;
        Clear;
        Add(' UPDATE CADLOT SET LOT_STATUS = IF(:STATUS = "N" AND LOT_SALDOS <> 0, LOT_STATUS, :STATUS) ');
        Add(' WHERE LOT_CODITE = :CODITE             ');
        Add('   AND LOT_NUMLOT = "A DEFINIR"         ');

        ParamByName('CODITE').AsString := qryTabela.FieldByName('LOT_CODITE').AsString;
        ParamByName('STATUS').AsString := qryTabela.FieldByName('LOT_STATUS').AsString;

        ExecSql;
      End;

    End;
  Finally
    FreeAndNil(qrySelect);
  End;
End;

function TfrmCadLoteItens.fTemContagemEmAberto(strCodIte: String): Boolean;
  Var
    qrySelect : TUniQuery;
Begin
  qrySelect := fCriaQuery;
  Try

    qrySelect.SQL.Add('SELECT GROUP_CONCAT(ITE_CODEMP) AS EMPRESAS FROM ITEGER');

    If fUsaRotinaWMS Then
    Begin
      If fConferenciaDepoisDaEntrada And (fCfgSis('TPLREC', varString) <> 'N') And (not blnCriaEmpresasWmsClass) Then
      Begin
        qrySelect.SQL.Add('   WHERE ITE_CODEMP = "' + VS_strCodEmp + '"');
      End
      Else
      Begin
        qrySelect.SQL.Add(' INNER JOIN CADEMP ON EMP_CODEMP = ITEGER.ITE_CODEMP AND EMP_UTIWMS = "S" ');
        qrySelect.SQL.Add(' WHERE TRUE ');
      End
    End
    Else
    Begin
      qrySelect.SQL.Add(' INNER JOIN CADEMP ON EMP_CODEMP = ITEGER.ITE_CODEMP AND EMP_UTIWMS <> "S" ');
      qrySelect.SQL.Add(' WHERE TRUE ');
    End;

    qrySelect.SQL.Add('   AND ITE_CODITE = "' + strCodIte + '"');
    qrySelect.SQL.Add('   AND ITE_DIGCON = "S"');

    qrySelect.Open;

    Result := False;

    If qrySelect.FieldByName('EMPRESAS').AsString <> '' Then
    Begin
      Result := True;
      pMensagemOk('Existem contagens de balanço em aberto para este item nas empresas [' + qrySelect.FieldByName('EMPRESAS').AsString + '], é preciso concluir as contagens para criar os lotes');
    End;


  Finally
    FreeAndNil(qrySelect);
  End;

end;

Class function TfrmCadLoteItens.fUpdateADefinir(blnExclusao : Boolean; qryTabela: TUniQuery) : Boolean;
  Var
    qrySelect : TUniQuery;
Begin
  qrySelect := fCriaQuery;
  Try
    With qrySelect, SQL Do
    Begin

      Close;
      Clear;
      Add(' SELECT '                     );
      Add('  LOT_CODEMP, LOT_SALDOS '    );
      Add(' FROM '                       );
      Add('   CADLOT '                   );
      Add(' WHERE '                      );
      Add('   LOT_CODITE = :CODITE AND ' );

      If Not blnExclusao Then
      Begin
        Add('   LOT_STATUS  = "S"     AND ' );
        If (qryTabela.FieldByName('LOT_STATUS').AsString = 'N') Then // Se estiver ativando não pode filtar ele pois se tiver apenas um lote nao vai ativar o "A DEFINIR"
          Add('   LOT_NUMLOT <> :NUMLOT AND ');
      End
      Else
        Add('   LOT_NUMLOT <> :NUMLOT AND ');

      Add('   LOT_NUMLOT <> "A DEFINIR"  ');

      Add(' GROUP BY '                   );
      Add('   LOT_CODEMP '               );

      ParamByName('CODITE').AsString := qryTabela.FieldByName('LOT_CODITE').AsString;
      If Params.FindParam('NUMLOT') <> Nil Then
        ParamByName('NUMLOT').AsString := qryTabela.FieldByName('LOT_NUMLOT').AsString;

      Open;

      If blnExclusao Then
        Result := IsEmpty
      Else
        Result := //((qryTabela.FieldByName('LOT_STATUS').AsString = 'N') And IsEmpty) Or //COMENTADO REQ.: 75530
                  ((qryTabela.FieldByName('LOT_STATUS').AsString = 'S') And (Not IsEmpty));

    End;

  Finally
    FreeAndNil(qrySelect);
  End;
End;

Procedure TfrmCadLoteItens.pCarregaArmazem;
begin
  edtDescArmazem.Text := fRetNomeArmazem(dbeNumLot.Text);
end;

procedure TfrmCadLoteItens.qryCadLotLOT_DTAFABSetText(Sender: TField;
  const Text: String);
begin
  inherited;

  If fEmptyDate(Text) Then
    qryCadLotLOT_DTAFAB.Clear
  Else
    qryCadLotLOT_DTAFAB.AsDateTime := StrToDate(Text);

end;

procedure TfrmCadLoteItens.qryCadLotLOT_DTAVALSetText(Sender: TField;
  const Text: String);
begin
  inherited;

  If fEmptyDate(Text) Then
    qryCadLotLOT_DTAVAL.Clear
  Else
    qryCadLotLOT_DTAVAL.AsDateTime := StrToDate(Text);

end;


function TfrmCadLoteItens.fUtilizandoCadastroRapidoLoteWMS: Boolean;
begin
  Result := Not fEmptyStr(strCodigoItemCadastroRapidoWMS);
end;

class procedure TfrmCadLoteItens.pCadastroRapidoMapeamentoLocFis(AStrCodIte, AStrLocFis: String);
var
  frmCadLoteItens: TfrmCadLoteItens;
begin
  pCriarFormularios(TfrmCadLoteItens, frmCadLoteItens);
  Try
    Try
      frmCadLoteItens.blnCadOrigemMapeamento := True;
      frmCadLoteItens.strCodigoItemCadastroRapidoWMS := AStrCodIte;
      frmCadLoteItens.strCodigoLocFisCadastroRapidoWMS := AStrLocFis;
      frmCadLoteItens.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    FreeAndNil(frmCadLoteItens);
  End;
end;

procedure TfrmCadLoteItens.pCadastroRapidoLoteWMS;
  Var
    blnResult : Boolean;
    frmDadosCadLoteWMS : TfrmDadosCadLoteWMS;
begin
  blnResult := False;
  btnIncluir.Click;

  If qryCadLot.State In [dsInsert] Then
  Begin
    If strCodigoItemCadastroRapidoWMS <> 'XXXXX' Then
      dbeCodIte.Field.AsString   := strCodigoItemCadastroRapidoWMS;
    dbeDtaFab.Field.AsDateTime := VS_Date;

    If strToDateDef(strDataValidadeCadastroRapidoWMS, VS_Date) > 0 Then
      dbeDtaVal.Field.AsDateTime := strToDateDef(strDataValidadeCadastroRapidoWMS, VS_Date);

    If (strCodigoItemCadastroRapidoWMS = 'XXXXX') Or fValidaCampos(dbeCodIte, True) Then
    Begin
      Try
        pCriarFormularios(TfrmDadosCadLoteWMS, frmDadosCadLoteWMS);

        frmDadosCadLoteWMS.dbeNumLot := dbeNumLot;
        frmDadosCadLoteWMS.blnCadLoc := blnCadLoc;
        frmDadosCadLoteWMS.dbeDtaVal := dbeDtaVal;
        frmDadosCadLoteWMS.dbeLocFis := dbeLocFis;
        frmDadosCadLoteWMS.dbeLocSep := dbeLocSep;
        frmDadosCadLoteWMS.dbeAbsAut := chkAbsAut;
        frmDadosCadLoteWMS.dbeCodIte := dbeCodIte;

        If strCodigoItemCadastroRapidoWMS <> 'XXXXX' Then
          frmDadosCadLoteWMS.strCodIte := strCodigoItemCadastroRapidoWMS
        Else
        Begin
          frmDadosCadLoteWMS.strCodIte := '';
          frmDadosCadLoteWMS.pnlCodIte.Visible := True;
        End;

        If blnBaixaOPI Then
          frmDadosCadLoteWMS.dbeNumLot.Field.AsString:= strNumLotProdAca;

        frmDadosCadLoteWMS.fValidarCamposLote := fValidaCampos;

        frmDadosCadLoteWMS.ShowModal;

        blnResult := frmDadosCadLoteWMS.blnConfirma;
        If blnResult Then
        Begin
          If fEmptyDate(dbeDtaVal.Text) Then
            dbeDtaVal.Field.AsDateTime := StrToDate('31/12/9999');
          btnGravar.Click;
        End;

      Except
        On E: Exception Do
          pMensagensErro(E.Message, '');
      End;

      pFreeAndNil(frmDadosCadLoteWMS);
    End;
  End;

  If blnResult And (strCodigoItemCadastroRapidoWMS = 'XXXXX') Then
    pCadastroRapidoLoteWMS;

end;

procedure TfrmCadLoteItens.pCadastroRapidoLoteWMSMapeamentoLocFis;
begin
  btnIncluir.Click;

  If Not (qryCadLot.State In [dsInsert]) Then
    Exit;

  Try
    dbeCodIte.Field.AsString   := strCodigoItemCadastroRapidoWMS;
    dbeDtaFab.Field.AsDateTime := VS_Date;
    dbeNumLot.Field.AsString   := TCadLot.fGetProximoNUMLOT(strCodigoItemCadastroRapidoWMS);
    dbeLocFis.Field.AsString   := strCodigoLocFisCadastroRapidoWMS;
    dbeDtaBal.Field.AsDateTime := VS_Date - 1;
    dbeDtaVal.Field.AsDateTime := VS_Date;

    btnGravar.Click;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmCadLoteItens.pCadastroRapidoLoteWMSMapeamentoLocFis');
    End;
  End;
end;

class procedure TfrmCadLoteItens.pCadastroRapidoSemProdutoWMS;
var
  frmCadLoteItens: TfrmCadLoteItens;
begin
  pCriarFormularios(TfrmCadLoteItens, frmCadLoteItens);
  Try
    Try
      frmCadLoteItens.strCodigoItemCadastroRapidoWMS := 'XXXXX';
      frmCadLoteItens.ShowModal;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '');
    End;
  Finally
    pFreeAndNil(frmCadLoteItens);
  End;
end;

Function TfrmCadLoteItens.fGravaLote: Boolean;
Begin
  Try

    pCriarFormularios(TfrmGravando, frmGravando);
    frmGravando.fExecutarAcao := fGravaLoteItens;
    frmGravando.ShowModal;

    Result := frmGravando.blnConfirma;
    If blnEdicaoPicking Then
      blnEditouPickingEGravou := Result;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmCadLoteItens.pGravaLoteItens]');
    End;
  End;

  pFreeAndNil(frmGravando);

  If Assigned(objSender) Then
  Begin
    Result := True;

    If Self.CanFocus Then
    Begin
      pSetFocus(Self);
      pSetFocus(objSender);
    End;

  End;

  If fUtilizandoCadastroRapidoLoteWMS And blnGravou Then
  Begin
    strNumeroLoteCadastroRapidoWMS := dbeNumLot.Text;
    blnFecharFormPai := True;
    Self.Repaint;
  End;
End;

procedure TfrmCadLoteItens.btnGravarClick(Sender: TObject);
  Var
    strCodIte: String;
    blnTravadoPelaMesmaConexao: Boolean;
Begin
  btnDividirChapa.Enabled := True;

  // forçando validação do lote/armazem na hora da gravação
  if (Not fVerificaCampos) then
    Exit;

  If fLoteVendasADefinir Then
    Exit;

  If fUsaPickingLaboratorioWms Then
  Begin
    If Not fValidaPickingLaboratorioItemBase Then
    Begin
      pMensagemOk('A localização física selecionada é do tipo "Picking Laboratório" e ela só pode ser vinculada a produtos que são bases'+
        ' de tintas imobiliárias. Antes de continuar, faça primeiro o ajuste do cadastro do produto '+ dbeCodIte.Text +
        ' (aba "Complementos" campo "Produto Base") e depois faça novamente essa alteração ou escolha outra localização física.');
      Exit;
    End;
  End;

  If blnCadOrigemMapeamento Then
    If fValidaSeExisteCadastroLote Then
    Begin
      pMensagemOk('Já existe um cadastro com essas informações, por favor verifique.');
      Exit;
    End;

  If blnTmqLot And blnInclusao Then
    If Not fValidaSeExisteLoteLaborat Then
    Begin
      pMensagemOk('Para criar lote com produto tintometrico, é necesssário habilitar '+ #10#13 +
                  'a CFG_TMQLOT e ter o cadastro do lote padrão "LABORAT". '+ #10#13 +
                  'FAVOR ENTRAR EM CONTATO COM A CITEL.');
      Exit;
    End;

  If fLock_Unlock(STR_TRAVA_LOTE + strCodIte, True, blnTravadoPelaMesmaConexao, False, False, '', True,
                  'LOTE', False{blnManual}, True{blnSeForMesmaConexaoNaoTravar}) Then
  Begin

    If Not fGravaLote Then
      Close
    Else
    Begin

      If (Not(blnInclusao)) then
      Begin

        If fGeraLogLocFis(strLocalOld,dbeLocFis.Text) Then
        Begin
          fGravaLogLocFisica(dbeCodIte.Text, strLocalOld, dbeLocFis.Text, 1, dbeNumLot.Text);
        End;

      End;
      pHabilitaCamposMarmore(False);
      btnDividirChapa.Enabled := True;

      blnInativouLote := False;
      strStatusOriginal := qryTabela.FieldByName('LOT_STATUS').AsString;
      plimpaEventoClickChecAprovado;
    End;

    If Not blnTravadoPelaMesmaConexao Then
      fLock_Unlock(STR_TRAVA_LOTE + strCodIte, False, False, False, '', True, 'LOTE');

  End
  Else
  Begin
    TfrmMensagemTravaLote.pMostraTravaLote('O item ' + strCodIte + ' está sendo utilizado na estação: ' + fGetHostLock(STR_TRAVA_LOTE + strCodIte));
  End;
End;

Class Procedure TfrmCadLoteItens.pGravaLoteItemParte1(qryTabela: TUniQuery; objCadLot: TCadLot; blnAtualizaSaldoML: Boolean; var blnUsarSaldoItem: Boolean);
  Var
    fltSaldo,
    fltSaldoML: Double;
Begin
  blnUsarSaldoItem := (Not objCadLot.fExisteLote(qryTabela.FieldByName('LOT_CODITE').AsString, VS_strCodEmp, '', False, False, True));

  objCadLot.pStepStatusGravacao;

  If (blnUsarSaldoItem) Then
  Begin
    fltSaldo := fRetSaldosEmpresa(qryTabela.FieldByName('LOT_CODITE').AsString, VS_strCodEmp) -
                                  fCampoTabela('LOT_SALDOS', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT' ],
                                                      [qryTabela.FieldByName('LOT_CODITE').AsString, VS_strCodEmp, 'A DEFINIR']);


    qryTabela.FieldByName('LOT_SALBAL').AsFloat    := fCampoTabela('ITE_SALBAL', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'],
                                                      [qryTabela.FieldByName('LOT_CODITE').AsString, VS_strCodEmp]);

    qryTabela.FieldByName('LOT_SALDOS').AsFloat    := fltSaldo;

    If blnAtualizaSaldoML Then
    Begin
      fltSaldoML := fRetSaldosMLEmpresa(qryTabela.FieldByName('LOT_CODITE').AsString, VS_strCodEmp);
      qryTabela.FieldByName('LOT_ML_BAL').AsFloat    := fltSaldoML;
      qryTabela.FieldByName('LOT_SAL_ML').AsFloat    := fltSaldoML;
    End;


    qryTabela.FieldByName('LOT_DTABAL').AsDateTime := fCampoTabela('ITE_DTABAL', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'],
                                                       [qryTabela.FieldByName('LOT_CODITE').AsString, VS_strCodEmp]);
  End;

  If (fCfgSis('LOTEND', varString) = '2') And fUsaRotinaWMS Then
    qryTabela.FieldByName('LOT_CODBAR').AsString   := qryTabela.FieldByName('LOT_NUMLOT').AsString;
End;

Class Function TfrmCadLoteItens.fGravaLoteItemParte2(qryTabela: TUniQuery; objCadLot: TCadLot;
                                                     cdsSalLot: TUniClientDataSet;
                                                     blnIncluir, blnUsarSaldoItem, blnRemoverLocFis, blnCriaEmpresasWms: Boolean;
                                                     tipoCadastro : TTipoCadastroLote = tclNormal; blnBaixaOPI: Boolean = False; AblnJaTemLote: Boolean = False;
                                                     AdictLocalizacaoFisicaEmpresa: TLocalizacaoFisicaEmpresaManual = Nil ): Boolean;
Begin
  Result := True;

  objCadLot.pAjustaArmPrincipalOrcamentoPedidoVenda(qryTabela);
  objCadLot.pAjustaArmPrincipalVenda(qryTabela);
  objCadLot.pAjustaArmPrincipalCompra(qryTabela);
  objCadLot.pAjustaLotePrincipalConsertoEquipamento(qryTabela);

  if (tipoCadastro <> tclOrdemProducaoIndustrial) then
    objCadLot.pAjustaArmPrincipalGarantia(qryTabela);

  objCadLot.pAjustaArmPrincipalAluguelDeEquipamentos(qryTabela);
  objCadLot.pAjustaArmPrincipalProducao(qryTabela);
  objCadLot.pAjustaArmPrincipalProducaoIndustrial(qryTabela);
  objCadLot.pAjustaLotePrincipalTintaMaquina(qryTabela);

  objCadLot.pStepStatusGravacao;

  Begin
    If blnRemoverLocFis Then
    Begin
      Result := Result And objCadLot.fTrocaLocFisica(qryTabela.FieldByName('LOT_CODITE').AsString,
                                                     qryTabela.FieldByName('LOT_NUMLOT').AsString,
                                                     qryTabela.FieldByName('LOT_LOCFIS').AsString);
    End;
    End;

  If blnIncluir Then
  Begin
    Result := Result And objCadLot.fIncluiLote(cdsSalLot);
    Result := Result And objCadLot.fGeraLoteEmpresas(qryTabela, blnCriaEmpresasWms, blnBaixaOPI, AdictLocalizacaoFisicaEmpresa);
    Result := Result And objCadLot.fGeraLotesReplicacao(qryTabela, blnBaixaOPI);

    If blnUsarSaldoItem Then
      Result := Result And
           objCadLot.fSetaMovimentosLote(qryTabela.FieldByName('LOT_CODITE').AsString,
                                         qryTabela.FieldByName('LOT_NUMLOT').AsString);

    {Result := Result And objCadLot.fTratarSaldoEntregaFutura(qryTabela, AblnJaTemLote);}
  End;

  pAtualizaStatusLoteADefinir(qryTabela);
End;

Function TfrmCadLoteItens.fGravaLoteItens(pgbProgresso: TcxProgressBar): Boolean;
  var
    blnIncluir: Boolean;
    blnUsarSaldoItem: Boolean;
    objLiberacao : ILiberacao;
    LdictLocalizacaoFisicaEmpresa: TLocalizacaoFisicaEmpresaManual ;
begin
  Try
    objCadLot.pgbStatusGravacao := pgbProgresso;

    If Assigned(objCadLot.pgbStatusGravacao) Then
      objCadLot.pgbStatusGravacao.Properties.Max := 3;

    blnIncluir := (qryTabela.State = dsInsert);

    pGravaLoteItemParte1(qryTabela, objCadLot, fUsaRotinaWMS Or fCfgSis('TMQLOT', varBoolean) Or fCfgSis('LOTBAS', varBoolean), blnUsarSaldoItem);

    objCadLot.pStepStatusGravacao;


    blnCriaEmpresasWmsClass := False;
    //Se for inclusao de empresa com WMS com uso do coletor de dados, solicita senha para criar para todas as empresas
    //pois Coletor com WMS, nao pode ter lotes sem localização fisica, visto que quem deve criar os lotes é o coletor
    //com base no local + dta de validade (se usar)
    // criado para a CORDEIRO, onde la tem lotes das fitas de corte, q cada lote é uma medida.
    If blnIncluir And fUsaRotinaWMS And fConferenciaDepoisDaEntrada And (fCfgSis('TPLREC', varString) <> 'N') And (Not blnCadOrigemMapeamento) Then
    Begin
      if fMensagem('', 'Deseja criar esse lote para todas as empresas que utilizam WMS?', ['&Sim', '&Não'], 2) = 1 Then
      Begin
        objLiberacao := TLiberacaoFactory.fGetLiberacao;
        objLiberacao.Clear;

        objLiberacao.strDirAce := 'WMSCADLOTTODASEMPRESAS';
        objLiberacao.strSenLib := '';
        objLiberacao.strMsgSen := 'Cadastro de Lotes em Todas as Empresas com WMS';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.objMsgLibera.pAddTexto('Cadastro de Lotes em Todas as Empresas com WMS');
        objLiberacao.objMsgRemota.pAddTexto('Produto: ' + edtDesIte.Text);

        blnCriaEmpresasWmsClass := objLiberacao.fLibera;
        if not blnCriaEmpresasWmsClass Then
          Exit(False);
      End;

    End;


    If blnIncluir And not fEmptyStr(dbeCodIte.Text) And fTemContagemEmAberto(dbeCodIte.Text) Then
    Begin
      Exit(False);
    End;

    If (Not fValidacoesBotaoGravarPai) Then
      Exit(False);

    LdictLocalizacaoFisicaEmpresa := fLocalizacaoFisicaEmpresaManual(dbeLocFis.Text, dbeCodIte.Text, edtDesIte.Text, dbeNumLot.Text, blnCriaEmpresasWmsClass) ;
    try
      blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;


      If (qryCadLot.FieldByName('LOT_LOTAPR').Value <> qryCadLot.FieldByName('LOT_LOTAPR').OldValue) Then
        ReprocessarItem(dbeCodIte.Text, '')
      Else If blnCadLoc And Not SameText(strLocalOld, dbeLocFis.Text) Then
          ReprocessarItem(dbeCodIte.Text, VS_strCodEmp, False);

      blnJaTemLote := objCadLot.fJaTemLote(qryTabela.FieldByName('LOT_CODITE').AsString, VS_strCodEmp);

      inherited pGravaRegistro;

      Result := blnGravou;

      If blnGravou Then
      Begin
        Result := fGravaLoteItemParte2(qryTabela, objCadLot, cdsSalLot, blnIncluir, blnUsarSaldoItem, blnCadLoc And (Not fUsaRotinaWMS) And blnRemoverLocFis, blnCriaEmpresasWmsClass, tipoCadastro, blnBaixaOPI, blnJaTemLote, LdictLocalizacaoFisicaEmpresa);
      End;

      If blnEdicaoPicking Then
        Result := fRemoveLocFisDoLotePickingAntigoSeExistir(strAutIncLotePickingRemoverLocFis);

      If Result Then
        fCommit
      Else
        fRollBack;

      objCadLot.pFinalizaStatusGravacao;
      If Result And blnIncluir Then
        ReprocessarItem(dbeCodIte.Text, '');
    finally
      if Assigned(LdictLocalizacaoFisicaEmpresa) then
        FreeAndNil(LdictLocalizacaoFisicaEmpresa) ;
    end ;
  Except

    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadLoteItens.fGravaLoteItens]');
    End;

  End;
end;

function TfrmCadLoteItens.fDefinePrincipalParaCompras: Boolean;
var qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT COUNT(1) AS QTD FROM CADLOT');
    qryConsulta.SQL.Add('WHERE TRUE');
    qryConsulta.SQL.Add('  AND LOT_CODITE = :CODITE');
    qryConsulta.SQL.Add('  AND LOT_CODEMP = :CODEMP');
    qryConsulta.SQL.Add('  AND LOT_NUMLOT <> "A DEFINIR" AND LOT_NUMLOT <> "GARANTIA"');

    qryConsulta.ParamByName('CODITE').AsString := dbeCodIte.Text;
    qryConsulta.ParamByName('CODEMP').AsString := VS_StrCodEmp;

    qryConsulta.Open;

    Result := qryConsulta.FieldByName('QTD').AsInteger = 0;

  Finally
    FreeAndNil(qryConsulta)
  End;
end;

function TfrmCadLoteItens.fEhLocalizacaoPickingCheckOut(ACodLoc, ACodEmp: String): Boolean;
  const
    SQL = 'SELECT            '+
          '  COUNT(*) AS TOT '+
          'FROM       '+
          '  CADLOC L '+
          'WHERE      '+
          '  L.LOC_CODLOC = :CODLOC AND '+
          '  L.LOC_CODEMP = :CODEMP AND '+
          '  L.LOC_PICKIN = "C"';
  var
    LqryAux : TUniQuery;
begin

  LqryAux := fCriaQuery;

  Try

    LqryAux.Close;
    LqryAux.SQL.Clear;
    LqryAux.SQL.Add(SQL);
    LqryAux.ParamByName('CODLOC').AsString := ACodLoc;
    LqryAux.ParamByName('CODEMP').AsString := ACodEmp;
    LqryAux.Open;

    Result := (Not LqryAux.IsEmpty) And (LqryAux.FieldByName('TOT').AsInteger > 0);

  Finally
    FreeAndNil(LqryAux);
  End;

end;

class function TfrmCadLoteItens.fGetNumeroLoteInclusaoRapidaWMS(strDtaVal, strCodIte: String): String;
  Var
    qryGen: TUniQuery;
    intPos: Integer;
    intUlt: Integer;
    intAtu: Integer;
begin
  Result := 'V ' + FormatDateTime('yyyy-mm-dd', strToDate(strDtaVal));

  qryGen := fCriaQuery;

  With qryGen, SQL Do
  Begin
    Clear;

    Add('SELECT ');
    Add('  DISTINCT LOT_NUMLOT ');
    Add('FROM ');
    Add('  CADLOT ');
    Add('WHERE ');
    Add('  LOT_CODITE = ' + QuotedStr(strCodIte) + ' AND ');
    Add('  LOT_NUMLOT LIKE ' + QuotedStr(Result + '%'));
    Add('ORDER BY ');
    Add('  LOT_NUMLOT ');

    Open;

    intUlt := 0;

    First;
    While Not Eof Do
    Begin
      intPos := Pos('/', FieldByName('LOT_NUMLOT').AsString);
      intAtu := 0;

      If intPos > 0 Then
      Begin
        intAtu := strToIntDef(RightStr(FieldByName('LOT_NUMLOT').AsString,
                                Length(FieldByName('LOT_NUMLOT').AsString) - intPos), 0);
      End;

      intUlt := Max(intUlt, intAtu);

      Next;
    End;

    Result := Result + '/' + intToStr(intUlt + 1);
  End;

  FreeAndNil(qryGen);
end;

class function TfrmCadLoteItens.fEditarLote(AStrAutInc, AStrCodIte, AStrLocFis, AStrLocDes, AStrNumLot: String): Boolean;
var
  frmCadLoteItens: TfrmCadLoteItens;
begin
  pCriarFormularios(TfrmCadLoteItens, frmCadLoteItens);
  Try
    Try
      frmCadLoteItens.blnEdicaoPicking := True;
      frmCadLoteItens.recDadosEdicaoLotePkn.strAutInc := AStrAutInc;
      frmCadLoteItens.recDadosEdicaoLotePkn.strCodite := AStrCodIte;
      frmCadLoteItens.recDadosEdicaoLotePkn.strLocFis := AStrLocFis;
      frmCadLoteItens.recDadosEdicaoLotePkn.strNumLot := AStrNumLot;
      frmCadLoteItens.recDadosEdicaoLotePkn.strLocDes := AStrLocDes;
      frmCadLoteItens.ShowModal;
      Result := frmCadLoteItens.blnEditouPickingEGravou;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmCadLoteItens.fEditarLote]');
      End;
    End;
  Finally
    pFreeAndNil(frmCadLoteItens);
  End;
end;

procedure TfrmCadLoteItens.pBuscaLotePorAutoincrem;
Var
  chrKey: Char;
  arrLotes: TConsultasArray;

  function fBuscaLote: Boolean;
  begin
    Result := False;
    If Not fEmptyStr(recDadosEdicaoLotePkn.strAutInc) Then
    Begin
      pPesquisaCadLot(qryTabela, qryTabela, recDadosEdicaoLotePkn.strAutInc);
      Result := True;
    End;
  end;
begin

  {*****************************}
  {* NOVA CONSULTA DE LOTES    *}
  {**************************AC*}
  chrKey := '/';
  if fBuscaLote Or fPesqLoteItens(Self, Nil, Nil, objCadLot.intDecUni, qryTabela, chrKey, arrLotes, True, '', '', False, False, stlItensComLoteSemLocalizacao) then
  begin
    If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
    Begin
      qryTabela.AfterOpen := pQryAfterOpen;
      objCadLot.pAfterOpen(qryTabela);
      pSetFocus(btnAlterar);
    End;
  end;

  pCarregaItem;
  pCarregaArmazem;
  pCarregaLocalizacao;
  pCarregaLocalSeparacao;
  pOnStateChange;
  If grpChapas.Visible Then
    pCarregaChapa;

  strStatusOriginal := qryTabela.FieldByName('LOT_STATUS').AsString;

  pExibeMensagemLoteTransitorio(qryTabela.FieldByName('LOT_TRANSI').AsString = 'N');

  btnAlterar.Click;

  objCadLot.fTemLocalizacaoFisicaComLotePicking(dbeLocFis.Text, VS_strCodEmp, dbeCodIte.Text, False, strAutIncLotePickingRemoverLocFis);

  qryTabela.FieldByName('LOT_LOCFIS').AsString := recDadosEdicaoLotePkn.strLocFis;
  fValidaCampos(dbeLocFis, True);

  If qryTabela.FieldByName('LOT_STATUS').AsString <> 'S' Then
  Begin
    If fMensagem('Confirmação', 'O lote não está ativo, deseja ativar?', ['&Sim', '&Não']) = 1 Then
    Begin
      qryTabela.FieldByName('LOT_STATUS').AsString := 'S';
      fValidaCampos(dbeStatus, True);
      dbeStatusChange(dbeStatus);
    End;
  End;
end;

function TfrmCadLoteItens.fRemoveLocFisDoLotePickingAntigoSeExistir(AStrAutIncLote: String): Boolean;
var
  qryAux: TUniQuery;
begin
  {Precisamos continuar respeitando a configuração [CFG_LOTPIC], que quando ligada, só permite uma localização por lote picking}
  Result := True;

  If Not blnLotPic Then
    Exit;

  If fEmptyStr(AStrAutIncLote) Then
    Exit;

  If AStrAutIncLote = qryTabela.FieldByName('AUTOINCREM').AsString Then
    Exit;

  qryAux := fCriaQuery;
  Try
    Try
      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE CADLOT SET LOT_LOCFIS = NULL WHERE AUTOINCREM = :AUTINC ' );
      qryAux.ParamByName('AUTINC').AsString := AStrAutIncLote;
      qryAux.ExecSQL;
      Result := qryAux.RowsAffected = 1;
    Except On
      E: Exception Do
      Begin
				pMensagensErro(E.Message,'[TfrmCadLoteItens.fRemoveLocFisDoLotePickingAntigoSeExistir]');
        Result := False;
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmCadLoteItens.fLiberaTrocaStatusLoteAprovado: Boolean;
var
  objLiberacao : ILiberacao;
Begin
  Try
    objLiberacao :=  TLiberacaoFactory.fGetLiberacao;
    objLiberacao.Clear;

    objLiberacao.strDirAce := 'PMCALG';
    objLiberacao.strSenLib := '';
    objLiberacao.strMsgSen := 'Alteração do status "Lote Aprovado / Liberado para venda ou Lote em garantia?" no lote';
    If dbcLotApr.Checked then
      objLiberacao.objMsgLibera.pAddTexto('Permitir Marcar checkbox "Lote Aprovado / Liberado para venda ou Lote em garantia?')
    else
      objLiberacao.objMsgLibera.pAddTexto('Permitir Desmarcar checkbox "Lote Aprovado / Liberado para venda ou Lote em garantia?');

    objLiberacao.objMsgLibera.pAddTextoCaption('Produto', dbeCodite.Text +'-'+edtDesite.Text, 10);
    objLiberacao.objMsgLibera.pAddTextoCaption('lote', dbeNumlot.Text, 10);
    Result := objLiberacao.fLibera;
    If Result then
      qryTabela.FieldByName('LOT_OPELLA').AsString := objLiberacao.strOperador;
  Except On
    E:Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message,'[TfrmCadLoteItens.fLiberaTrocaStatusLoteAprovado]');
    End;
  End;
end;

procedure TfrmCadLoteItens.pSetEventoClickChecAprovado;
begin
  dbcLotApr.OnClick := dbcLotAprClick;
end;

procedure TfrmCadLoteItens.plimpaEventoClickChecAprovado;
begin
  dbcLotApr.OnClick := nil;
end;


end.
