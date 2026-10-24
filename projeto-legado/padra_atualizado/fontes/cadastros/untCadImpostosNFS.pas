unit untCadImpostosNFS;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, DBEditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  Vcl.Buttons, BitBtnLockedIncrem, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGridCitel,
  cxGrid, Datasnap.DBClient, Uni, Vcl.ComCtrls,
  UniClientDataSet, untTypesSistema, untGeralPisCofins, MemDS, DBAccess,
  Datasnap.Provider, UniDataSetProvider, cxCurrencyEdit, ComboBoxFocus,
  MaskEditFocus, EditFocus, untPesqAux, dxScreenTip, dxCustomHint, cxHint,
  cxDBLookupComboBox, cxSpinEdit;

type
  TfraCadImpostosNFS = class(TFrame)
    scroll: TScrollBox;
    cdsForRet: TUniClientDataSet;
    cdsForRetAUTOINCREM: TStringField;
    cdsForRetRET_ALIQUO: TFloatField;
    cdsForRetDESTIP: TStringField;
    cdsForRetRET_DIAVEN: TIntegerField;
    cdsForRetDESVEN: TStringField;
    cdsForRetDESEVE: TStringField;
    cdsForRetDESCTA: TStringField;
    cdsForRetDESFOR: TStringField;
    cdsForRetRET_TIPRET: TStringField;
    cdsForRetRET_CODFOR: TStringField;
    cdsForRetRET_CODEVE: TStringField;
    cdsForRetRET_CODCTA: TStringField;
    cdsForRetRET_TIPVEN: TStringField;
    cdsForRetRET_FORRET: TStringField;
    cdsForRetFOR_NOMFOR: TStringField;
    cdsForRetCTA_DESCTA: TStringField;
    cdsForRetEVE_DESEVE: TStringField;
    cdsForRetVALRET: TFloatField;
    dtsForRet: TDataSource;
    dtsTabela: TDataSource;
    qryForRet: TUniQuery;
    dspForRet: TUniDataSetProvider;
    grpIss: TGroupBox;
    Label68: TLabel;
    Label23: TLabel;
    Label67: TLabel;
    Label82: TLabel;
    lblCodTipoServico: TLabel;
    dbeBasIss: TDBEditFocus;
    dbeAlqIss: TDBEditFocus;
    dbeValIss: TDBEditFocus;
    edtCodigoVerificacaoNSE: TDBEditFocus;
    dbeCodTipoServico: TDBEditFocus;
    grbRetencoes: TGroupBox;
    grdImpostos: TcxGridCitel;
    grdImpostosTableView1: TcxGridDBTableViewCitel;
    grdImpostosDESTIP: TcxGridDBColumn;
    grdImpostosRET_ALIQUO: TcxGridDBColumn;
    grdImpostosDESCTA: TcxGridDBColumn;
    grdImpostosDESEVE: TcxGridDBColumn;
    grdImpostosDESVEN: TcxGridDBColumn;
    grdImpostosRET_DIAVEN: TcxGridDBColumn;
    grdImpostosVALRET: TcxGridDBColumn;
    grdImpostosLevel1: TcxGridLevel;
    pnlCalcRet: TPanel;
    btnCalcRet: TBitBtnLocked;
    grpRetencaoDados: TGroupBox;
    Label5: TLabel;
    DBEditFocus5: TDBEditFocus;
    lblForn: TLabel;
    lblCentroCusto: TLabel;
    lblEventos: TLabel;
    edtCodFor: TEditFocus;
    edtCodEve: TEditFocus;
    edtDesFor: TEditFocus;
    edtDesCtaRet: TEditFocus;
    edtDesEve: TEditFocus;
    lblTipo: TLabel;
    cmbTipImp: TComboBoxFocus;
    lblAliq: TLabel;
    edtAliq: TEditFocus;
    rdgVencimento: TRadioGroup;
    grpRent: TGroupBox;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    dbeRetISS: TDBEditFocus;
    dbeReIRRF: TDBEditFocus;
    dbeReCSSL: TDBEditFocus;
    dbeReINSS: TDBEditFocus;
    dbeVREPIS: TDBEditFocus;
    dbeVRECOF: TDBEditFocus;
    edtVencimento: TEditFocus;
    pnlBotoesImp: TPanel;
    btnIncluirImp: TBitBtnLocked;
    btnAlterarImp: TBitBtnLocked;
    btnExcluirImp: TBitBtnLocked;
    btnCancelarImp: TBitBtnLocked;
    btnGravarImp: TBitBtnLocked;
    cdsForRetVALBAS: TFloatField;
    grdImpostosVALBAS: TcxGridDBColumn;
    grdImpostosRET_TIPRET: TcxGridDBColumn;
    lblPortador: TLabel;
    edtCodPorRet: TEditFocus;
    edtNomPorRet: TEditFocus;
    cdsForRetPOR_NOMPOR: TStringField;
    cdsForRetRET_CODPOR: TStringField;
    cdsForRetNOMPOR: TStringField;
    grdImpostosNOMPOR: TcxGridDBColumn;
    Label25: TLabel;
    dbeTipDoc: TDBEditFocus;
    lblGuia: TLabel;
    LcbGuiaTributo: TDBLookupComboBox;
    LcbTipoTributo: TDBLookupComboBox;
    cdsForRetRET_TIPDOC: TIntegerField;
    cdsForRetRET_Q_GUIA: TStringField;
    cdsForRetRET_CODREC: TStringField;
    dtsGuiaTributo: TDataSource;
    dtsTipoTributo: TDataSource;
    HintControler: TcxHintStyleController;
    spbDicaTributo: TSpeedButton;
    dxScreenTipRepository: TdxScreenTipRepository;
    dxScreenTipRepositoryScreenTip1: TdxScreenTip;
    grdImpostosRET_TIPDOC: TcxGridDBColumn;
    grdImpostosRET_Q_GUIA: TcxGridDBColumn;
    grdImpostosRET_CODREC: TcxGridDBColumn;
    mskCodCtaRet: TMaskEditFocus;
    Label1: TLabel;
    dbeReINSSP: TDBEditFocus;
    gbpREINF: TGroupBox;
    lblNatRend: TLabel;
    lblTipServ: TLabel;
    edtNatRend: TEditFocus;
    edtTipoServico: TEditFocus;
    dbeCodNatRend: TDBEditFocus;
    dbeCodTipServ: TDBEditFocus;
    lblWarning: TLabel;
    procedure dbeRetISSExit(Sender: TObject);
    procedure dbeReIRRFExit(Sender: TObject);
    procedure dbeReCSSLExit(Sender: TObject);
    procedure dbeReINSSExit(Sender: TObject);
    procedure dbeBasIssExit(Sender: TObject);
    procedure dbeAlqIssChange(Sender: TObject);
    procedure grdImpostosTableView1EditValueChanged(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem);
    procedure btnCalcRetClick(Sender: TObject);
    procedure dbeCodTipoServicoKeyPress(Sender: TObject; var Key: Char);
    procedure btnIncluirImpClick(Sender: TObject);
    procedure btnGravarImpClick(Sender: TObject);
    procedure btnCancelarImpClick(Sender: TObject);
    procedure btnExcluirImpClick(Sender: TObject);
    procedure btnAlterarImpClick(Sender: TObject);
    procedure edtCodForKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEveKeyPress(Sender: TObject; var Key: Char);
    procedure rdgVencimentoClick(Sender: TObject);
    procedure rdgVencimentoExit(Sender: TObject);
    procedure cmbTipImpChange(Sender: TObject);
    procedure grdImpostosTableView1DblClick(Sender: TObject);
    procedure cmbTipImpSelect(Sender: TObject);
    procedure edtCodPorRetKeyPress(Sender: TObject; var Key: Char);
    procedure LcbGuiaTributoExit(Sender: TObject);
    procedure dbeTipDocExit(Sender: TObject);
    procedure spbDicaTributoClick(Sender: TObject);
    procedure HintControlerShowHint(Sender: TObject; var HintStr: string;
      var CanShow: Boolean; var HintInfo: THintInfo);
    procedure grdImpostosRET_CODRECPropertiesInitPopup(Sender: TObject);
    procedure grdImpostosTableView1FocusedRecordChanged(
      Sender: TcxCustomGridTableView; APrevFocusedRecord,
      AFocusedRecord: TcxCustomGridRecord;
      ANewItemRecordFocusingChanged: Boolean);
    procedure mskCodCtaRetExit(Sender: TObject);
    procedure mskCodCtaRetEnter(Sender: TObject);
    procedure mskCodCtaRetKeyPress(Sender: TObject; var Key: Char);
    procedure grdImpostosTableView1FocusedItemChanged(
      Sender: TcxCustomGridTableView; APrevFocusedItem,
      AFocusedItem: TcxCustomGridTableItem);
    procedure dbeCodNatRendKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodTipServKeyPress(Sender: TObject; var Key: Char);
    procedure dbeReINSSPExit(Sender: TObject);
    procedure dbeCodTipoServicoExit(Sender: TObject);

  private
    { Private declarations }
     FTip_Fc,
     FForCli,
     FNomFor,
     FEntSai,
     FCodEmp,
     FSerie,
     FNumDoc,
     FEspDoc,
     FClaFis: String;
     FDtaDoc,
     FDtaEnt: TDate;

     qryCadCta,
     qryConFor,
     qryGuiaTributo,
     qryTipoTributo: TUniQuery;
     qryCtaDet: TUniClientDataSet;
     FstrNumDup: String;
     Procedure pSetEspDoc(Value: String);
     Procedure pSetClaFis(Value: String);
     procedure pSetaValores(fltRetPis, fltRetCofins, fltRetCsll, fltRetIrrf, fltRetInss,fltRetIss, fltRetInssPatronal: Double);
//     function fImp(ipcImposto: TImpostoPisCofins): String;
     function fCarregaRetencoes(blnHabilitaSempre: Boolean): Boolean;
     function fEntradaDeServico: Boolean;
     procedure pAjustarValoresRetencoes(fltValRetAnt: Double);
     function fCampoAliquotaOuValRet(strNomCampo:String): Boolean;
     procedure pLimparDadosRetencoes;

     procedure pHabilitarBotoesImp(blnIncAlt: Boolean);
     procedure pHabilitarEditsImp(blnHabilita: Boolean);
     procedure pCarregaFornecedor;
     procedure pCarregaCentroDeCusto(mksCodCta: TMaskEditFocus; edtDesCta: TEditFocus);
     procedure HabilitaCamposRetencao;
     function fRetCampoClaFisServico(blnDefaultVazio: Boolean = False): String;
     function fCalcularDataVencimento(var wrdAno: Word; var wrdMes: Word;  var wrdDia: Word;
                                      var dteVencto: TDateTime; var dteUltDiaMes: TDateTime): TDateTime;

     function fRetornaDataVencimento(strDataVencimento: String): Variant;
     function fRetornaCodFornecedor(strForCli: String): Variant;
     function fRetornaCodConta(strCodContaRateio: String): Variant;
     function fRetornaCodEvento(strCodEvento: String): Variant;
     function fRetornaCodPortador(strCodPortador: String): Variant;
     function fRetornaCodForRet(strCodFor: String): Variant;
     function fRetornaDescEvento(strCodEvento: String): String;
     function fRetornaDescPortador(strCodPortador: String): String;
     function fRetornaDescConta(strCodContaRateio: String): String;
     function fRetornaDescFornecedor(strCodFor: String): String;
     function fRetornaTipoImposto(strTipoImposto: String): String;
     function fRetornaDiaVenc(strVencimento: String): String;
     function fDiaVencimentoInformado(strVencimento: String; intVencimento: Integer): Boolean;
     function fLocalizouFornecedorRetencaoParaMesmoTipoImposto(blnInc: Boolean): Boolean;
     procedure pVlidaTipoImpostoEmBranco(intTipoImposto: Integer);
     procedure pVlidaAliquotaImpostoEmBranco(strAliquota: String);
     procedure pVlidaContaRetencaoImpostoEmBranco(strContaRetencao: String);
     procedure pVlidaDiaVencimentoRetencaoImpostoEmBranco(strVencimento: String; intVencimento: Integer);
     procedure pCarregaGuiasETributos(ATrazTributo: Boolean = False);
     procedure pCarregaTipoTributos(ABlnOrigemGrid: Boolean = False);
     procedure pLiberaTravaColunaGuiaETipoTributo;
     function fValidaNaturezaRendimentoReinf: Boolean;
     function fValidaTipoServicoReinf: Boolean;
     procedure pGravarCtpDet(strParcel: String; strLocalOrigem: String = '');

  public
    { Public declarations }
    frmPai: TForm;
    blnEntradaMercadoria: Boolean;
    blnCarregaCSTPisConfisAoDefinirCFOP: Boolean;

    qryTabela: TDataSet;
    btnConfirmar: TBitBtnLocked;
    blnAlteracaoLivro: Boolean;


    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
    procedure pReset;

//    function fValidaCstCofinsLivro(dbeCampo: TDBEdit; ipcImposto: TImpostoPisCofins; blnCstBranca: Boolean): Boolean;

    Function fRetTotalImpostos(): Double;

    Procedure pInicializaValores;

    Procedure pAtualizaCdsForRet(intTipRet: Integer;
                                 fltAliquo,
                                 fltValRet: Double);

    procedure pManipulaCampoCodigoVerificador;
    procedure pCalculaServico;

    procedure pCalculaRetencoes;

    procedure pAjustarCamposRetencoesLivFis(fltRetPis, fltRetCofins, fltRetCsll, fltRetIrrf, fltRetInss, fltRetIss, fltRetInssPatronal: Double);
    procedure pCarregarRetencoes(blnHabilitaSempre: Boolean = False);
    procedure pCalculaValorRetencaoAliquota(strNomCampo: String; fltValRetAnt: Double);


    function fVisibilidadeRetencao(blnHabilitaSempre: Boolean): boolean;
    function fRetencaoEnabled(blnHabilitaSempre: Boolean): Boolean;
    Function fCriarParcelasRetencoesFornecedor(AutIncFis: string; AstrLocalOrigem: String = ''): Boolean;
    Class Function fCriaFrameImpostos(frmDestino: TForm; tbsPagina: TWinControl): TfraCadImpostosNFS;

    procedure pCarregaDadosReinf;

    Procedure pInicializaDados(qryTabela: TDataSet);

    Procedure pAtualizaDados(strEspDoc, strClaFis, strTip_Fc, strNomFor, strEntSai,
                             strForCli, strCodEmp, strNumDoc: String; strSerie: String;
                             dtaDtaDoc, dtaDtaEnt: TDate);
    function CtaDet(qryDataSet: TUniClientDataSet): TfraCadImpostosNFS;
    Property strEspDoc: String read FEspDoc write pSetEspDoc;
    Property strClaFis: String read FClaFis write pSetClaFis;
    Property strTip_Fc: String read FTip_Fc write FTip_Fc;
    Property strNomFor: String read FNomFor write FNomFor;
    Property strEntSai: String read FEntSai write FEntSai;
    Property strForCli: String read FForCli write FForCli;
    Property strCodEmp: String read FCodEmp write FCodEmp;
    Property strSerie : String read FSerie  write FSerie;
    Property strNumDoc: String read FNumDoc write FNumDoc;
    Property dtaDtaDoc: TDate  read FDtaDoc write FDtaDoc;
    Property dtaDtaEnt: TDate  read FDtaEnt write FDtaEnt;

  end;

implementation

{$R *.dfm}

Uses
  StrUtils,
  DateUtils,
  untConsultas,
  untFuncoesSimples,
  untCadPag;

Const
  TIPRET_PIS    = 0;
  TIPRET_COFINS = 1;
  TIPRET_CSLL   = 2;
  TIPRET_IRFF   = 3;
  TIPRET_INSS   = 4;
  TIPRET_ISS    = 5;
  TIPRET_INSSP  = 6;

procedure TfraCadImpostosNFS.pCalculaRetencoes;
  Var
    fltRetIss   : Double;
    fltRetPis   : Double;
    fltRetCsll  : Double;
    fltRetInss  : Double;
    fltRetIrrf  : Double;
    fltRetCofins: Double;
    fltValBas,
    fltValImp: Double;
    fltRetInssPatronal  : Double;
    strCampoClafisServico: String;
begin
  inherited;

  Try
    If Not cdsForRet.Active Then
      Exit;

    If (cdsForRet.State = dsEdit) Then
      cdsForRet.Post();

    cdsForRet.DisableControls();
    cdsForRet.First();

    fltRetIss    := 0;
    fltRetPis    := 0;
    fltRetCsll   := 0;
    fltRetInss   := 0;
    fltRetIrrf   := 0;
    fltRetCofins := 0;
    fltRetInssPatronal := 0;
    fltValImp := 0;

    if blnAlteracaoLivro Then
    Begin
      //PIS
     fltRetPis := qryTabela.FieldByName('FIS_VREPIS').AsFloat;
      //COFINS
     fltRetCofins := qryTabela.FieldByName('FIS_VRECOF').AsFloat;
      //CSLL
     fltRetCsll := qryTabela.FieldByName('FIS_RECSSL').AsFloat;
      //IRRF
     fltRetIrrf := qryTabela.FieldByName('FIS_REIRRF').AsFloat;
      //INSS
     fltRetInss := qryTabela.FieldByName('FIS_REINSS').AsFloat;
      //ISS
     fltRetIss := qryTabela.FieldByName('FIS_RETISS').AsFloat;
      //INSS Patronal
     fltRetInssPatronal := qryTabela.FieldByName('FIS_RINSSP').AsFloat;
    End;
    strCampoClaFisServico := fRetcampoClaFisServico;

    While (Not cdsForRet.Eof) Do
    Begin
      cdsForRet.Edit();
      If blnAlteracaoLivro Then
      Begin
        fltValBas  := qryTabela.FieldByName(strCampoClaFisServico).AsFloat;



        Case (cdsForRet.FieldByName('RET_TIPRET').AsInteger) Of
          0: fltValImp := fltRetPis;
          1: fltValImp := fltRetCofins;
          2: fltValImp := fltRetCsll;
          3: fltValImp := fltRetIrrf;
          4: fltValImp := fltRetInss;
          5: fltValImp := fltRetIss;
          6: fltValImp := fltRetInssPatronal;
        End;
        cdsForRet.FieldByName('VALBAS').AsFloat := fltValBas;
        cdsForRet.FieldByName('VALRET').AsFloat := fltValImp;
        cdsForRet.FieldByName('RET_ALIQUO').AsFloat := fltValImp / fltValBas * 100;
        cdsForRet.Post;
      End
      Else
      Begin
        If cdsForRet.FieldByName('VALBAS').AsFloat = 0 Then
          cdsForRet.FieldByName('VALBAS').AsFloat := qryTabela.FieldByName(strCampoClaFisServico).AsFloat;

        If cdsForRet.FieldByName('VALRET').AsFloat = 0 Then
          cdsForRet.FieldByName('VALRET').AsFloat := qryTabela.FieldByName(strCampoClaFisServico).AsFloat *
          (cdsForRet.FieldByName('RET_ALIQUO').AsFloat / 100);

        Case (cdsForRet.FieldByName('RET_TIPRET').AsInteger) Of
          0: fltRetPis    := fltRetPis    + cdsForRet.FieldByName('VALRET').AsFloat;
          1: fltRetCofins := fltRetCofins + cdsForRet.FieldByName('VALRET').AsFloat;
          2: fltRetCsll   := fltRetCsll   + cdsForRet.FieldByName('VALRET').AsFloat;
          3: fltRetIrrf   := fltRetIrrf   + cdsForRet.FieldByName('VALRET').AsFloat;
          4: fltRetInss   := fltRetInss   + cdsForRet.FieldByName('VALRET').AsFloat;
          5: fltRetIss    := fltRetIss    + cdsForRet.FieldByName('VALRET').AsFloat;
          6: fltRetInssPatronal := fltRetInssPatronal + cdsForRet.FieldByName('VALRET').AsFloat;
        End;

        If (cdsForRet.RecordCount = cdsForRet.RecNo) Then
          //Post acontece aqui dentro
          pAjustarCamposRetencoesLivFis(fltRetPis,
                                        fltRetCofins,
                                        fltRetCsll,
                                        fltRetIrrf,
                                        fltRetInss,
                                        fltRetIss,
                                        fltRetInssPatronal);
      End;

      cdsForRet.Next();
    End;
  Finally
    cdsForRet.EnableControls();
  End;
end;

procedure TfraCadImpostosNFS.btnAlterarImpClick(Sender: TObject);
begin
  If (Not cdsForRet.IsEmpty) Then
  Begin
    cmbTipImp.ItemIndex     := cdsForRet.FieldByName('RET_TIPRET').AsInteger;
    cmbTipImpSelect(Sender);
    edtAliq.Text            := cdsForRet.FieldByName('RET_ALIQUO').AsString;
    edtCodFor.Text          := cdsForRet.FieldByName('RET_FORRET').AsString;
    mskCodCtaRet.Text       := fStrZero(cdsForRet.FieldByName('RET_CODCTA').AsString, 7);
    rdgVencimento.ItemIndex := cdsForRet.FieldByName('RET_TIPVEN').AsInteger;
    edtVencimento.Text      := cdsForRet.FieldByName('RET_DIAVEN').AsString;
    edtCodEve.Text          := cdsForRet.FieldByName('RET_CODEVE').AsString;
    edtDesEve.Text          := fRetNomEventoExiFat(edtCodEve.Text);

    edtCodPorRet.Text       := cdsForRet.FieldByName('RET_CODPOR').AsString;
    edtNomPorRet.Text       := fRetNomPortador(edtCodPorRet.Text);

    pCarregaFornecedor;
    pCarregaCentroDeCusto(mskCodCtaRet,  edtDesCtaRet);

    cmbTipImp.Enabled := False;

    cdsForRet.Edit();

    pHabilitarBotoesImp(True);
    pHabilitarEditsImp(True);

    HabilitaCamposRetencao;

    pSetFocus(cmbTipImp);

    pCarregaGuiasETributos(True);
  End
  Else
  Begin
    fMensagem('ATENÇÃO!', 'Não há registro de Retenção selecionado para alteração!', ['&OK']);
  End;

end;

procedure TfraCadImpostosNFS.btnCalcRetClick(Sender: TObject);
begin
  If (grbRetencoes.Visible) Then
    pCalculaRetencoes;
end;

procedure TfraCadImpostosNFS.btnCancelarImpClick(Sender: TObject);
begin
  cdsForRet.Cancel();
  pLimparDadosRetencoes();
  pHabilitarBotoesImp(False);
  pHabilitarEditsImp(False);

  if (VarToStr(LcbGuiaTributo.KeyValue) <> '') And (LcbGuiaTributo.KeyValue > 0) then
    pCarregaGuiasETributos(True);
end;

procedure TfraCadImpostosNFS.btnExcluirImpClick(Sender: TObject);
begin
  If (Not cdsForRet.IsEmpty) Then
  Begin
    If (fMensagem('CONFIRMAÇÃO!', 'Excluir Retenção de Imposto?', ['&Sim', '&Não'], 2) = 1) Then Begin
      cdsForRet.Delete();
    End;

    pHabilitarBotoesImp(False);
    pHabilitarEditsImp(False);

  End
  Else
  Begin
    fMensagem('ATENÇÃO!', 'Não há registro de Retenção selecionado para exclusão!', ['&OK']);
  End;
end;

function TfraCadImpostosNFS.fRetornaDataVencimento(strDataVencimento: String): Variant;
Begin
  Result:= Null;
  If(Not(fEmptyStr(strDataVencimento))) Then
    Result:= strDataVencimento;
End;

function TfraCadImpostosNFS.fRetornaCodFornecedor(strForCli: String): Variant;
Begin
  Result:= Null;
  If(Not(fEmptyStr(strForCli))) Then
    Result:= strForCli;
End;

function TfraCadImpostosNFS.fRetornaCodConta(strCodContaRateio: String): Variant;
Begin
  Result:= Null;
  If(Not(fEmptyStr(strCodContaRateio))) Then
    Result:= strCodContaRateio;
End;

function TfraCadImpostosNFS.fRetornaCodEvento(strCodEvento: String): Variant;
Begin
  Result:= Null;
  If(Not(fEmptyStr(strCodEvento))) Then
    Result:= strCodEvento;
End;

function TfraCadImpostosNFS.fRetornaDescEvento(strCodEvento: String): String;
Begin
  Result:= '';
  If(Not(fEmptyStr(strCodEvento))) Then
    Result:= edtCodEve.Text    + '-' + edtDesEve.Text;
End;

function TfraCadImpostosNFS.fRetornaCodForRet(strCodFor: String): Variant;
Begin
  Result:= Null;
  If(Not(fEmptyStr(strCodFor))) Then
    Result:= strCodFor;
End;

function TfraCadImpostosNFS.fRetornaCodPortador(strCodPortador: String): Variant;
begin
  Result:= Null;
  If(Not(fEmptyStr(strCodPortador))) Then
    Result:= strCodPortador;
end;

function TfraCadImpostosNFS.fRetornaDescPortador(strCodPortador: String): String;
Begin
  Result:= '';
  If(Not(fEmptyStr(strCodPortador))) Then
    Result:= edtCodPorRet.Text    + '-' + edtNomPorRet.Text;
End;

function TfraCadImpostosNFS.fRetornaDescConta(strCodContaRateio: String): String;
Begin
  Result:= '';
  If(Not(fEmptyStr(strCodContaRateio))) Then
    Result:= mskCodCtaRet.Text + '-' + edtDesCtaRet.Text;
End;

function TfraCadImpostosNFS.fRetornaDescFornecedor(strCodFor: String): String;
Begin
  Result:= '';
  If(Not(fEmptyStr(strCodFor))) Then
    Result:= edtCodFor.Text    + '-' + edtDesFor.Text;
End;

function TfraCadImpostosNFS.fRetornaTipoImposto(strTipoImposto: String): String;
Begin
  Result:= '';
  If(Not(fEmptyStr(strTipoImposto))) Then
    Result:= strTipoImposto;
End;

function TfraCadImpostosNFS.fRetornaDiaVenc(strVencimento: String): String;
Begin
  Result:= '';
  If(Not(fEmptyStr(strVencimento))) Then
    Result:= strVencimento;
End;


function TfraCadImpostosNFS.fDiaVencimentoInformado(strVencimento: String; intVencimento: Integer): Boolean;
Begin
  Result:= (Not fEmptyStr(edtVencimento.Text)) And (StrToInt(edtVencimento.Text) = 0) And (rdgVencimento.ItemIndex = 0);
End;

function TfraCadImpostosNFS.fLocalizouFornecedorRetencaoParaMesmoTipoImposto(blnInc: Boolean): Boolean;
begin
  Result:= (blnInc) And (cdsForRet.Locate('RET_CODFOR;RET_FORRET;RET_TIPRET',
                         VarArrayOf([strForCli,
                                     edtCodFor.Text,
                                     IntToStr(cmbTipImp.ItemIndex)]), []));

End;

procedure TfraCadImpostosNFS.pVlidaTipoImpostoEmBranco(intTipoImposto: Integer);
Begin
  If (intTipoImposto = -1) Then
    raise Exception.Create('O Tipo de Imposto para Retenção deve ser informado');
End;

procedure TfraCadImpostosNFS.pVlidaAliquotaImpostoEmBranco(strAliquota: String);
Begin
  If ((strAliquota.Equals('0')) Or (strAliquota.Equals('0,00')))  Then
    raise Exception.Create('A Alíquota para Retenção deve ser informada!');
End;

procedure TfraCadImpostosNFS.pVlidaContaRetencaoImpostoEmBranco(strContaRetencao: String);
Begin
  If fEmptyStr(strContaRetencao) Then
    raise Exception.Create('O Plano de Contas para Retenção deve ser informado');
End;

procedure TfraCadImpostosNFS.pVlidaDiaVencimentoRetencaoImpostoEmBranco(strVencimento: String; intVencimento: Integer);
Begin
  If fDiaVencimentoInformado(strVencimento, intVencimento) Then
    raise Exception.Create('O Dia de Vencimento para Retenção deve ser informado');
End;


procedure TfraCadImpostosNFS.btnGravarImpClick(Sender: TObject);
var
  blnValida,
  blnInc: Boolean;

begin

  blnInc  := (cdsForRet.State = dsInsert);

  blnValida:= (fValidaCampos(edtCodFor) And fValidaCampos(edtCodEve) And
     fValidaCampos(mskCodCtaRet) And fValidaCampos(edtAliq) And
     fValidaCampos(edtVencimento) And fValidaCampos(edtCodPorRet) And
     fValidaCampos(dbeTipDoc) And fValidaCampos(lcbGuiaTributo) And
     fValidaCampos(lcbTipoTributo));

  If Not(blnValida) Then
    Exit;


  If (Not fEmptyStr(edtCodFor.Text)) Then
  Begin

    Try
      pVlidaTipoImpostoEmBranco(cmbTipImp.ItemIndex);
    Except
      on E: Exception do
      Begin
        fMensagem('ATENÇÃO!', 'O Tipo de Imposto para Retenção deve ser informado!', ['&Ok']);
        pSetFocus(cmbTipImp);
        Exit;
      End;

    End;


    Try
      pVlidaAliquotaImpostoEmBranco(edtAliq.Text);
    Except
      on E: Exception do
      Begin
      fMensagem('ATENÇÃO!', 'A Alíquota para Retenção deve ser informada!', ['&Ok']);
      pSetFocus(edtAliq);
      Exit;
      End;

    End;


    Try
      pVlidaContaRetencaoImpostoEmBranco(edtDesCtaRet.Text);
    Except
      on E: Exception do
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas para Retenção deve ser informado!', ['&Ok']);
        pSetFocus(mskCodCtaRet);
        Exit;
      End;

    End;


    Try
      pVlidaDiaVencimentoRetencaoImpostoEmBranco(edtVencimento.Text, rdgVencimento.ItemIndex);
    Except
      on E: Exception do
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas para Retenção deve ser informado!', ['&Ok']);
        pSetFocus(mskCodCtaRet);
        Exit;
      End;

    End;


    If fLocalizouFornecedorRetencaoParaMesmoTipoImposto(blnInc) Then
    Begin
      fMensagem('ATENÇÃO!', 'O Tipo de Retenção está duplicado para o fornecedor informado!', ['&Ok']);
      pSetFocus(cmbTipImp);
      Exit;
    End;

  End;

  If (blnInc) Then
  Begin
    If (dbeTipDoc.Enabled) And (fEmptyStr(dbeTipDoc.Text)) Then
      cdsForRet.Insert()
    Else
      cdsForRet.Edit();
  End
  Else
    cdsForRet.Edit();

  cdsForRet.FieldByName('RET_TIPRET').AsInteger := cmbTipImp.ItemIndex;
  cdsForRet.FieldByName('RET_ALIQUO').AsString  := FormatFloat('#,####0.0000', fStrToFloat(edtAliq.Text));
  cdsForRet.FieldByName('RET_TIPVEN').AsInteger := rdgVencimento.ItemIndex;

  cdsForRet.FieldByName('RET_DIAVEN').Value    := fRetornaDataVencimento(edtVencimento.Text);
  cdsForRet.FieldByName('RET_CODFOR').Value    := fRetornaCodFornecedor(strForCli);
  cdsForRet.FieldByName('RET_CODCTA').Value    := fRetornaCodConta(mskCodCtaRet.Text);
  cdsForRet.FieldByName('RET_CODEVE').Value    := fRetornaCodEvento(edtCodEve.Text);
  cdsForRet.FieldByName('RET_FORRET').Value    := fRetornaCodForRet(edtCodFor.Text);
  cdsForRet.FieldByName('RET_CODPOR').Value    := fRetornaCodPortador(edtCodPorRet.Text);
  cdsForRet.FieldByName('NOMPOR').AsString     := fRetornaDescPortador(edtCodPorRet.Text);
  cdsForRet.FieldByName('DESEVE').AsString     := fRetornaDescEvento(edtCodEve.Text);
  cdsForRet.FieldByName('DESCTA').AsString     := fRetornaDescConta(mskCodCtaRet.Text);
  cdsForRet.FieldByName('DESFOR').AsString     := fRetornaDescFornecedor(mskCodCtaRet.Text);
  cdsForRet.FieldByName('DESTIP').AsString     := fRetornaTipoImposto(cmbTipImp.Text);
  cdsForRet.FieldByName('DESVEN').AsString     := fRetornaDiaVenc(rdgVencimento.Items[rdgVencimento.ItemIndex]);

  cdsForRet.Post();

  pCalculaValorRetencaoAliquota('RET_ALIQUO', cdsForRet.FieldByName('VALRET').AsFloat);

  pLimparDadosRetencoes();

  pHabilitarBotoesImp(False);
  pHabilitarEditsImp(False);

  grdImpostosTableView1.ApplyBestFit();

  pSetFocus(btnIncluirImp);
end;


procedure TfraCadImpostosNFS.pHabilitarBotoesImp(blnIncAlt: Boolean);
begin
  btnGravarImp.Enabled   := (blnIncAlt);
  btnCancelarImp.Enabled := (blnIncAlt);
  btnIncluirImp.Enabled  := (Not blnIncAlt);
  btnAlterarImp.Enabled  := (Not blnIncAlt);
  btnExcluirImp.Enabled  := (Not blnIncAlt);
  If Assigned(btnConfirmar) Then
    btnConfirmar.Enabled := btnIncluirImp.Enabled;

end;


procedure TfraCadImpostosNFS.pHabilitarEditsImp(blnHabilita: Boolean);
begin
  cmbTipImp.Enabled     := blnHabilita;
  edtAliq.Enabled       := blnHabilita;
  edtCodFor.Enabled     := blnHabilita;
  edtCodPorRet.Enabled  := blnHabilita;
  mskCodCtaRet.Enabled  := blnHabilita;
  edtCodEve.Enabled     := blnHabilita;
  rdgVencimento.Enabled := blnHabilita;
  dbeTipDoc.Enabled := blnHabilita;
  lcbGuiaTributo.Enabled := blnHabilita;
  lcbTipoTributo.Enabled := blnHabilita;
end;

procedure TfraCadImpostosNFS.btnIncluirImpClick(Sender: TObject);
begin
  pLimparDadosRetencoes;

  cdsForRet.Insert();
  cmbTipImp.Enabled := True;
  pSetFocus(cmbTipImp);
  pHabilitarBotoesImp(True);
  pHabilitarEditsImp(True);

end;

procedure TfraCadImpostosNFS.HabilitaCamposRetencao;
Begin
  If grpRetencaoDados.Visible Then
  Begin
    dbeVREPIS.ReadOnly    := True;
    dbeVRECOF.ReadOnly    := True;
    dbeReCSSL.ReadOnly    := True;
    dbeReIRRF.ReadOnly    := True;
    dbeReINSS.ReadOnly    := True;
    dbeRetISS.ReadOnly    := True;
    dbeReINSSP.ReadOnly    := True;

    Case (cmbTipImp.ItemIndex) Of
      0: dbeVREPIS.ReadOnly    := False;
      1: dbeVRECOF.ReadOnly    := False;
      2: dbeReCSSL.ReadOnly    := False;
      3: dbeReIRRF.ReadOnly    := False;
      4: dbeReINSS.ReadOnly    := False;
      5: dbeRetISS.ReadOnly    := False;
      6: dbeReINSSP.ReadOnly    := False;
    End;
  End;

End;

procedure TfraCadImpostosNFS.HintControlerShowHint(Sender: TObject;
  var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
begin
  canShow := HintStr = 'TipDoc';
  HintInfo.HintPos.Y := HintInfo.HintPos.Y + dbeTipDoc.Height;
end;

procedure TfraCadImpostosNFS.LcbGuiaTributoExit(Sender: TObject);
begin
  pCarregaTipoTributos;
end;

procedure TfraCadImpostosNFS.cmbTipImpChange(Sender: TObject);
begin
  HabilitaCamposRetencao;
end;

procedure TfraCadImpostosNFS.cmbTipImpSelect(Sender: TObject);
begin
  case cmbTipImp.ItemIndex of
    5:
    Begin
      edtAliq.Text := '0,0000';
      edtAliq.EditFormat := '#,##0.0000';
    End;
  Else
    edtAliq.Text := '0,00';
    edtAliq.EditFormat := '#,##0.00';
  End;
  lblWarning.Visible := cmbTipImp.Text = 'INSS Patronal';
end;

function TfraCadImpostosNFS.CtaDet(qryDataSet: TUniClientDataSet): TfraCadImpostosNFS;
begin
  Result := Self;
  qryCtaDet := qryDataSet;
end;

procedure TfraCadImpostosNFS.dbeAlqIssChange(Sender: TObject);
begin
  fValidaCampos(dbeAlqIss);
end;

procedure TfraCadImpostosNFS.dbeBasIssExit(Sender: TObject);
begin
  fValidaCampos(dbeBasIss);

end;

procedure TfraCadImpostosNFS.dbeCodNatRendKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  if fPesqReinfNaturezaDoRendimento(frmPai, dbeCodNatRend, edtNatRend, nil, Key, arrSel) then
  begin
    if fValidaCampos(dbeCodNatRend, True) then
      SelectNext(frmPai.ActiveControl, True, True);
  end
end;

procedure TfraCadImpostosNFS.dbeCodTipoServicoExit(Sender: TObject);
begin
  fValidaCampos(dbeCodTipoServico, True);
end;

procedure TfraCadImpostosNFS.dbeCodTipoServicoKeyPress(Sender: TObject; var Key: Char);
  var
    arrCds: TConsultasArray;
begin
  inherited;
  if fPesqCodTipoServico(frmPai, dbeCodTipoServico, nil, nil, Key, arrCds) then
  begin
    if fValidaCampos(dbeCodTipoServico, True) then
      SelectNext(frmPai.ActiveControl, True, True);
  end;
end;
procedure TfraCadImpostosNFS.dbeCodTipServKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  if fPesqReinfTipoDoServico(frmPai, dbeCodTipServ, edtTipoServico, nil, Key, arrSel) then
  begin
    if fValidaCampos(dbeCodTipServ, True) then
      SelectNext(frmPai.ActiveControl, True, True);
  end;
end;

procedure TfraCadImpostosNFS.dbeReCSSLExit(Sender: TObject);
begin

  fValidaCampos(dbeReCSSL);

end;

procedure TfraCadImpostosNFS.dbeReINSSExit(Sender: TObject);
begin
  fValidaCampos(dbeReINSS);
end;

procedure TfraCadImpostosNFS.dbeReINSSPExit(Sender: TObject);
begin
  fValidaCampos(dbeReINSSP);
end;

procedure TfraCadImpostosNFS.dbeReIRRFExit(Sender: TObject);
begin

  fValidaCampos(dbeReIRRF);

end;

procedure TfraCadImpostosNFS.dbeRetISSExit(Sender: TObject);
begin

  fValidaCampos(dbeRetISS);

end;

procedure TfraCadImpostosNFS.dbeTipDocExit(Sender: TObject);
begin
  HintControler.HideHint;
  fValidaCampos(dbeTipDoc);
end;

procedure TfraCadImpostosNFS.edtCodEveKeyPress(Sender: TObject; var Key: Char);
  Var
    arrEvento: TConsultasArray;
begin
  inherited;

  If fPesqEventos(frmPai, edtCodEve, edtDesEve, Nil, Key, arrEvento, True, True) Then
  Begin
    If fValidaCampos(edtCodEve, True) Then
      SelectNext(frmPai.ActiveControl, True, True);
  End;
end;

procedure TfraCadImpostosNFS.pCarregaCentroDeCusto(mksCodCta: TMaskEditFocus;
  edtDesCta: TEditFocus);
begin

  mksCodCta.Text := IIF(fEmptyStr(mksCodCta.Text),mksCodCta.Text,fGetPlanoDeContas(mksCodCta.Text));
  If Not(fEmptyStr(fTiraCaracEspeciais(mksCodCta.Text))) Then
  Begin
    qryCadCta.Close;
    qryCadCta.SQL.Clear;
    qryCadCta.SQL.Add('SELECT * FROM CADCTA WHERE CTA_CODCTA = :CODCTA');
    qryCadCta.ParamByName('CODCTA').AsString:= mksCodCta.Text;
    qryCadCta.Open;
    edtDesCta.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
  End;
end;

procedure TfraCadImpostosNFS.pCarregaFornecedor;
begin
  If Not(fEmptyStr(edtCodFor.Text)) Then
  Begin
    qryConFor.Close;
    qryConFor.SQL.Clear;
    qryConFor.SQL.Add('SELECT * FROM CADFOR WHERE FOR_CODFOR = :CADFOR');
    qryConFor.ParamByName('CADFOR').AsString:= edtCodFor.Text;
    qryConFor.Open;
    edtDesFor.Text := qryConFor.FieldByName('FOR_NOMFOR').AsString;
  End;
end;

procedure TfraCadImpostosNFS.edtCodForKeyPress(Sender: TObject; var Key: Char);
Var
  arrFornec: TConsultasArray;
begin
  inherited;

  If fPesqFornecedor(conForSimples, frmPai, edtCodFor, Nil, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtCodFor, True) Then
      SelectNext(frmPai.ActiveControl, True, True);
  End;
end;

procedure TfraCadImpostosNFS.edtCodPorRetKeyPress(Sender: TObject;  var Key: Char);
Var
  arrCodPor: TConsultasArray;
begin
  inherited;
  If fPesqPortador(conSimples, frmPai, edtCodPorRet, edtNomPorRet, Nil, Key, arrCodPor) then
  Begin
    If fValidaCampos(edtCodPorRet, True) Then
      SelectNext(frmPai.ActiveControl, True, True);
  End;
end;

{function TfraCadImpostosNFS.fImp(ipcImposto: TImpostoPisCofins): String;
begin
  Result := IIF(ipcImposto = ipcPis, 'PIS', 'COFINS');
end;}


{function TfraCadImpostosNFS.fValidaCstCofinsLivro(dbeCampo: TDBEdit;
  ipcImposto: TImpostoPisCofins; blnCstBranca: Boolean): Boolean;
  Var
    oldValue: Variant;

begin
  Result := True;
  If fEmptyStr(dbeCampo.Text) Then
  Begin
    If (blnCstBranca) Then
    Begin
      If qryTabela.State = dsEdit Then
      Begin
        Try
          oldValue := dbeCampo.Field.OldValue;
        Except
          oldValue := Null;
        End;

        If Not fEmptyStr(IfNull(oldValue, '')) Then
        Begin
          If fMensagem('', 'Deseja realmente apagar a CST de ' + fImp(ipcImposto) + '?', ['', '']) = 2 Then
          Begin
            dbeCampo.Text := dbeCampo.Field.OldValue;
          End
          Else
          Begin
            dbeCampo.Field.AsString := '';
          End;
        End;
      End
      Else
        dbeCampo.Field.AsString := '';
    End;

  End
  Else If Not fCstPisValida(dbeCampo.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'CST de ' + fImp(ipcImposto) + ' inválida.!', ['&Ok']);
    Result := False;
  End;
end;

  }
function TfraCadImpostosNFS.fVisibilidadeRetencao(blnHabilitaSempre: Boolean): boolean;
begin
  Result := True;
  If (Not cdsForRet.IsEmpty()) Then
  Begin
   If blnHabilitaSempre Then
      Exit(True);
    If (qryTabela.State = dsInsert) Then
      Exit(True);
  End;
end;

Procedure TfraCadImpostosNFS.pAtualizaCdsForRet(intTipRet: Integer;
                                                fltAliquo,
                                                fltValRet: Double);
Begin
  If Not cdsForRet.Active Then
    Exit;

  If cdsForRet.Locate('RET_TIPRET', intTipRet, []) Then
  Begin
    cdsForRet.Edit;
    cdsForRet.FieldByName('RET_ALIQUO').AsFloat := fltAliquo;
    cdsForRet.FieldByName('VALRET').AsFloat     := fltValRet;
    cdsForRet.Post;
  End;
End;


function TfraCadImpostosNFS.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = dbeRetISS) Then
  Begin
    If fEmptyStr(dbeRetISS.Text) Then
      dbeRetISS.Field.Value := 0;
  End

  Else If (Sender = dbeReIRRF) Then
  Begin
    If fEmptyStr(dbeReIRRF.Text) Then
      dbeReIRRF.Field.Value := 0;
  End

  Else If (Sender = dbeReCSSL) Then
  Begin
    If fEmptyStr(dbeReCSSL.Text) Then
      dbeReCSSL.Field.Value := 0;
  End

  Else If (Sender = dbeReINSS) Then
  Begin
    If fEmptyStr(dbeReINSS.Text) Then
      dbeReINSS.Field.Value := 0;
  End

  Else If (Sender = dbeReINSSP) Then
  Begin
    If fEmptyStr(dbeReINSSP.Text) Then
      dbeReINSSP.Field.Value := 0;
  End

  Else If (Sender = dbeBasIss) Or
          (Sender = dbeAlqIss) Then
  Begin
    If fStrToFloat((Sender As TDBEditFocus).Text) < 0 Then
    Begin
      fMensagem('', 'Os valores devem ser maiores ou iguais a zero!', ['&OK']);
      Result := False;
    End
    Else
      pCalculaServico;
  End

  Else If (Sender = dbeCodTipoServico) And (dbeCodTipoServico.Visible) Then
  Begin
    dbeCodTipoServico.Text := fStrZero(dbeCodTipoServico.Text, 4);

    If fEmptyStr(fRetCodTipoServico(dbeCodTipoServico.Text)) Then
    Begin
      pMensagemOk('Tipo de serviço não encontrado!');
      Result := False;
    End;
  End

  Else

  If  (grpRetencaoDados.Enabled) And (grpRetencaoDados.Visible) Then
  Begin
    If (Sender = edtCodFor) And (edtCodFor.Enabled) Then
    Begin
      If fEmptyStr(edtCodFor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código do Fornecedor deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        pCarregaFornecedor;

        If (qryConFor.FieldByName('FOR_CODFOR').AsString = strForCli) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Fornecedor em edição não pode receber retenções!', ['&Ok']);

          Result := False;
        End
        Else
        If qryConFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodEve) And (edtCodEve.Enabled) Then
    begin
      If Not fEmptyStr(edtCodEve.Text) Then Begin
        edtDesEve.Text := fRetNomEventoExiFat(edtCodEve.Text);

        If fEmptyStr(edtDesEve.Text) Then Begin
          fMensagem('ATENÇÃO!', 'Esse Evento não está cadastrado!', ['&OK']);
          Result := False;
        End;
      End
      Else
        edtDesEve.Clear;
    end

    Else If (Sender = edtAliq) And (edtAliq.Enabled) Then
    Begin
      If (Not fEmptyStr(edtAliq.Text)) Then Begin
        If (fStrToFloat(edtAliq.Text) > 100) Then Begin
          fMensagem('ATENÇÃO!', 'A Alíquota de Retenção não pode ser maior que 100%', ['&Ok']);
          Result := False;
        End Else If (fStrToFloat(edtAliq.Text) < 0) Then Begin
          fMensagem('ATENÇÃO!', 'A Alíquota de Retenção não pode ser negativa!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtVencimento) And (rdgVencimento.ItemIndex <= 0) Then Begin
      If (fEmptyStr(edtVencimento.Text)) Then edtVencimento.Text := '0';

      If ((StrToInt(edtVencimento.Text) <= 0) Or (StrToInt(edtVencimento.Text) > 31)) And (rdgVencimento.Enabled) Then Begin
        fMensagem('ATENÇÃO!', 'A Data de Vencimento deve ser um dia entre 01 e 31!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = mskCodCtaRet) And (mskCodCtaRet.Enabled) Then
    Begin

      If RightStr(mskCodCtaRet.Text, 3) = '000' Then
      Begin
        fMensagem('ATENÇÃO!', mskCodCtaRet.Text + ' não é um Plano de Contas válido!', ['&Ok']);
        mskCodCtaRet.Clear;
        Result := False;
      End
      Else If Not fEmptyStr(mskCodCtaRet.Text) Then
      Begin
        //mskCodCtaRet.Text := fStrZero(mskCodCtaRet.Text,7);

        pCarregaCentroDeCusto(mskCodCtaRet, edtDesCtaRet);

        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If Not PlanoDeContasAtivo(mskCodCtaRet.Text) Then
          Result := False;

      End
      Else
      Begin
        edtDesCtaRet.Clear;
        mskCodCtaRet.Clear;
      End;

    End

    Else If (Sender = edtCodEve) And (edtCodEve.Enabled) Then
    begin
      If Not fEmptyStr(edtCodEve.Text) Then Begin
        edtDesEve.Text := fRetNomEventoExiFat(edtCodEve.Text);

        If fEmptyStr(edtDesEve.Text) Then Begin
          fMensagem('ATENÇÃO!', 'Esse Evento não está cadastrado!', ['&OK']);
          Result := False;
        End;
      End Else
        edtDesEve.Clear;
    end

    Else If (Sender = edtAliq) And (edtAliq.Enabled) Then Begin
      If (Not fEmptyStr(edtAliq.Text)) Then Begin
        If (fStrToFloat(edtAliq.Text) > 100) Then Begin
          fMensagem('ATENÇÃO!', 'A Alíquota de Retenção não pode ser maior que 100%', ['&Ok']);
          Result := False;
        End Else If (fStrToFloat(edtAliq.Text) < 0) Then Begin
          fMensagem('ATENÇÃO!', 'A Alíquota de Retenção não pode ser negativa!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodPorRet) And (edtCodPorRet.Enabled) Then
    Begin
      edtNomPorRet.Clear;
      If Not fEmptyStr(edtCodPorRet.Text) Then
      Begin
        edtNomPorRet.text := fRetNomPortador(edtCodPorRet.Text);

        If fEmptyStr(edtNomPorRet.text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
          Result := False;
        End
        Else If Not fEmpresaTemAcessoPortador(edtCodPorRet.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPorRet.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos deste portador!', ['&O k']);
            Result := False;
          End;
        End;
      End;
      {Else If (fCfgSis('CTPOBP', varBoolean)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do portador deve ser preenchido!', ['&O k']);
        Result := False;
      End;  }
    End
    Else If (Sender = dbeTipDoc) Then
    Begin
      If Not fEmptyStr(dbeTipDoc.Text) Then
      Begin

        If Pos(dbeTipDoc.Text,'1_2_3_') <= 0 Then
        Begin
          fMensagem('','O Tipo do Documento deve ser 1, 2 ou 3!',['&OK']);
          Result := False;
        End;

        If (dbeTipDoc.Text = '2') Then
        Begin
          LcbGuiaTributo.Visible := True;
          LcbTipoTributo.Visible := True;
          spbDicaTributo.Visible := True;
          lblGuia.Visible := True;
        End
        Else
        Begin
          LcbGuiaTributo.Visible := False;
          LcbTipoTributo.Visible := False;
          spbDicaTributo.Visible := False;
          LcbGuiaTributo.KeyValue := -1;
          LcbTipoTributo.KeyValue := EmptyStr;
          lblGuia.Visible := False;
          //lblValorOutrasEntidades.Enabled := False;
          //dbeValorOutrasEntidades.Enabled := False;
          If cdsForRet.State = dsBrowse Then
            cdsForRet.Edit;

          cdsForRet.FieldByName('RET_Q_GUIA').Clear;
          cdsForRet.FieldByName('RET_CODREC').Clear;
          fValidaCampos(LcbTipoTributo);
        End;


      End;
    End
    Else If (Sender = LcbTipoTributo) and
            (LcbGuiatributo.Visible And LcbGuiatributo.Enabled) Then
    Begin
      If ((VarToString(LcbGuiatributo.KeyValue) <> '') And
          (LcbGuiatributo.KeyValue > 0) And
          (LcbGuiatributo.KeyValue <> 8) And //ISS
          (LcbGuiatributo.KeyValue <> 9) And //IPTU
          (fEmptyStr(LcbTipoTributo.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código de receita do tributo deve ser informado. Verifique!', ['&O k']);
        Result := False;
      End;

      If ((VarToString(LcbGuiatributo.KeyValue) = '') Or (LcbGuiaTributo.KeyValue < 0 )) And (Not fEmptyStr(LcbTipoTributo.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição da guia deve ser informada. Verifique!', ['&O k']);
        Result := False;
      End;

    // SE FOR GPS E CÓDIGO 2100 HABILITA O CAMPO DE VALOR DE OUTRAS ENTIDADES.
      If (VarToString(LcbGuiatributo.KeyValue) <> '') And
         (VarToString(LcbTipoTributo.KeyValue) <> '') And
         (LcbGuiaTributo.KeyValue = 1) and
         (LcbTipoTributo.KeyValue = '2100') then
      begin
        //lblValorOutrasEntidades.Enabled := True;
        //dbeValorOutrasEntidades.Enabled := True;
      end
      else
      begin
        {If (qryTabela.State in [dsInsert, dsEdit]) And
           (qryTabela.FieldByName('RET_DTAPAG').IsNull) Then
        Begin
          //dbeValorOutrasEntidades.Text := '0,00';
          qryTabela.FieldByName('RET_OUTENT').AsFloat := 0.00;
          //pCalculaValorTotal;
        End; }

        //lblValorOutrasEntidades.Enabled := False;
        //dbeValorOutrasEntidades.Enabled := False;
      end;
    End
    Else If (Sender = LcbTipoTributo) and
            (LcbGuiatributo.Visible And LcbGuiatributo.Enabled) Then
    Begin
      If ((VarToString(LcbGuiatributo.KeyValue) <> '') And
          (LcbGuiatributo.KeyValue > 0) And
          (LcbGuiatributo.KeyValue <> 8) And //ISS
          (LcbGuiatributo.KeyValue <> 9) And //IPTU
          (fEmptyStr(LcbTipoTributo.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código de receita do tributo deve ser informado. Verifique!', ['&O k']);
        Result := False;
      End;

      If ((VarToString(LcbGuiatributo.KeyValue) = '') Or (LcbGuiaTributo.KeyValue < 0 )) And (Not fEmptyStr(LcbTipoTributo.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A descrição da guia deve ser informada. Verifique!', ['&O k']);
        Result := False;
      End;

    // SE FOR GPS E CÓDIGO 2100 HABILITA O CAMPO DE VALOR DE OUTRAS ENTIDADES.
      If (VarToString(LcbGuiatributo.KeyValue) <> '') And
         (VarToString(LcbTipoTributo.KeyValue) <> '') And
         (LcbGuiaTributo.KeyValue = 1) and
         (LcbTipoTributo.KeyValue = '2100') then
      begin
        //lblValorOutrasEntidades.Enabled := True;
        //dbeValorOutrasEntidades.Enabled := True;
      end
      else
      begin
        {If (qryTabela.State in [dsInsert, dsEdit]) And
           (qryTabela.FieldByName('RET_DTAPAG').IsNull) Then
        Begin
          //dbeValorOutrasEntidades.Text := '0,00';
          qryTabela.FieldByName('RET_OUTENT').AsFloat := 0.00;
          //pCalculaValorTotal;
        End;     }

        //lblValorOutrasEntidades.Enabled := False;
        //dbeValorOutrasEntidades.Enabled := False;
      end;
    End;
  End;

  if gbpREINF.Visible then
    begin
      If (Sender = dbeCodNatRend) Then
      Begin
        if (fEmptyStr(dbeCodNatRend.Text)) and (fValidaNaturezaRendimentoReinf) then
        begin
          fMensagem('ATENÇÃO!', 'Informe a Natureza do Rendimento (REINF)!', ['&Ok']);
          scroll.VertScrollBar.Position := 150;
        Result := False;
      end
        else
        begin
          edtNatRend.Text := fRetReinfNaturezaDoRendimento(dbeCodNatRend.Text);
          if (fEmptyStr(edtNatRend.Text)) and (fValidaNaturezaRendimentoReinf) then
          begin
            fMensagem('ATENÇÃO!', 'Natureza do Rendimento inválida (REINF)!', ['&Ok']);
            scroll.VertScrollBar.Position := 150;
          Result := False;
        end;
      end;
    End

      Else If (Sender = dbeCodTipServ) Then
      Begin
        if (fEmptyStr(dbeCodTipServ.Text)) and (fValidaTipoServicoReinf) then
        begin
          fMensagem('ATENÇÃO!', 'Informe o Tipo de Serviço (REINF)!', ['&Ok']);
          Result := False;
      end
        else
        begin
          edtTipoServico.Text := fRetReinfTipoDeServico(dbeCodTipServ.Text);
          if (fEmptyStr(edtTipoServico.Text)) and (fValidaTipoServicoReinf) then
          begin
            fMensagem('ATENÇÃO!', 'Tipo do Serviço inválido (REINF)!', ['&Ok']);
            Result := False;
        end;
      end;
    End;
  end;

  If Not Result Then
    pSetFocus(Sender);
end;

function TfraCadImpostosNFS.fValidaTipoServicoReinf: Boolean;
begin
  if not gbpREINF.Visible then
    Exit(False);

  Result := (qryTabela.FieldByName('FIS_REINSS').AsFloat > 0);
end;

function TfraCadImpostosNFS.fValidaNaturezaRendimentoReinf: Boolean;
begin

  if not gbpREINF.Visible then
    Exit(False);

  Result := (qryTabela.FieldByName('FIS_REIRRF').AsFloat > 0) or
            (qryTabela.FieldByName('FIS_RECSSL').AsFloat > 0) or
            (qryTabela.FieldByName('FIS_VREPIS').AsFloat > 0) or
            (qryTabela.FieldByName('FIS_VRECOF').AsFloat > 0);
end;

Procedure TfraCadImpostosNFS.pInicializaValores;
Begin
  blnAlteracaoLivro := False;
End;

procedure TfraCadImpostosNFS.pLimparDadosRetencoes;
begin
  blnAlteracaoLivro := False;
  cmbTipImp.ItemIndex := -1;
  edtAliq.Text := '0,00';
  edtCodFor.Text := '';
  edtDesFor.Text := '';
  mskCodCtaRet.Clear();
  edtDesCtaRet.Text := '';
  edtCodEve.Text := '';
  edtDesEve.Text := '';
  rdgVencimento.ItemIndex := 1;
  edtVencimento.Text := '';
  edtVencimento.Enabled := False;
  edtCodPorRet.Clear;
  edtNomPorRet.Clear;
  lblWarning.Visible := cmbTipImp.Text = 'INSS Patronal';
end;

function TfraCadImpostosNFS.fRetCampoClaFisServico(blnDefaultVazio: Boolean = False): String;
var i: integer;
begin
  Result := IIF(blnDefaultVazio, '', 'FIS_VLCON1');
  For i := 1 To 5 do
  Begin
    If Pos('933', qryTabela.FieldByName('FIS_CLFSC' + IntToStr(i)).AsString) > 0 Then
      Exit('FIS_VLCON' + IntToStr(i));

  End;
end;

function TfraCadImpostosNFS.fRetencaoEnabled(blnHabilitaSempre: Boolean): Boolean;
begin
  result := False;
  If blnHabilitaSempre Then
    Exit(True);
  If (qryTabela.State <> dsBrowse) Then
    Exit(True);
end;

Function TfraCadImpostosNFS.fRetTotalImpostos(): Double;
Begin
  Result := fStrToFloat(dbeRetISS.Text) +
            fStrToFloat(dbeReCSSL.Text) +
            fStrToFloat(dbeReIRRF.Text) +
            fStrToFloat(dbeReINSS.Text) +
            fStrToFloat(dbeVREPIS.Text) +
            fStrToFloat(dbeVRECOF.Text);
End;

procedure TfraCadImpostosNFS.pManipulaCampoCodigoVerificador;
begin
  Label82.Visible := False;
  edtCodigoVerificacaoNSE.Visible := False;

  If (strEspDoc = 'NF') Then
    If (Pos(RightStr(strClaFis, 3), '933') > 0) Then
  Begin
    Label82.Visible := True;
    edtCodigoVerificacaoNSE.Visible := True;
  End;
end;

Procedure TfraCadImpostosNFS.pSetEspDoc(Value: String);
Begin
  If Value <> FEspDoc Then
  Begin
    FEspDoc := Value;
    pManipulaCampoCodigoVerificador;
  End;
End;


  procedure TfraCadImpostosNFS.rdgVencimentoClick(Sender: TObject);
begin
  edtVencimento.Enabled := (rdgVencimento.ItemIndex = 0);

  If (Not edtVencimento.Enabled) Then
    edtVencimento.Text := '';
end;

procedure TfraCadImpostosNFS.rdgVencimentoExit(Sender: TObject);
begin
  If (rdgVencimento.ItemIndex = 1) Then
    pSetFocus(btnGravarImp);
end;

procedure TfraCadImpostosNFS.spbDicaTributoClick(Sender: TObject);
begin
  inherited;
  fMensagem('Informação sobre tributos', 'Os tributos ISS, IPTU e FGTS não são tratados no AUTBAN.', ['&Ok']);
end;

procedure TfraCadImpostosNFS.pReset;
begin
  blnAlteracaoLivro := False;
  pnlBotoesImp.Visible := False;
  grpRetencaoDados.Visible := False;
  grbRetencoes.Visible := False;
  grpRent.Visible := fRetCampoClaFisServico(True) <> '';

end;

procedure TfraCadImpostosNFS.pAjustarValoresRetencoes(fltValRetAnt: Double);
  begin
    pAjustarCamposRetencoesLivFis(
      IIF(cdsForRet.FieldByName('RET_TIPRET').AsInteger = 0,
          qryTabela.FieldByName('FIS_VREPIS').AsFloat -
            (fltValRetAnt - cdsForRet.FieldByName('VALRET').AsFloat),
          qryTabela.FieldByName('FIS_VREPIS').AsFloat),

      IIF(cdsForRet.FieldByName('RET_TIPRET').AsInteger = 1,
          qryTabela.FieldByName('FIS_VRECOF').AsFloat -
            (fltValRetAnt - cdsForRet.FieldByName('VALRET').AsFloat),
          qryTabela.FieldByName('FIS_VRECOF').AsFloat),

      IIF(cdsForRet.FieldByName('RET_TIPRET').AsInteger = 2,
          qryTabela.FieldByName('FIS_RECSSL').AsFloat -
            (fltValRetAnt - cdsForRet.FieldByName('VALRET').AsFloat),
          qryTabela.FieldByName('FIS_RECSSL').AsFloat),

      IIF(cdsForRet.FieldByName('RET_TIPRET').AsInteger = 3,
          qryTabela.FieldByName('FIS_REIRRF').AsFloat -
            (fltValRetAnt - cdsForRet.FieldByName('VALRET').AsFloat),
          qryTabela.FieldByName('FIS_REIRRF').AsFloat),

      IIF(cdsForRet.FieldByName('RET_TIPRET').AsInteger = 4,
          qryTabela.FieldByName('FIS_REINSS').AsFloat -
            (fltValRetAnt - cdsForRet.FieldByName('VALRET').AsFloat),
          qryTabela.FieldByName('FIS_REINSS').AsFloat),

      IIF(cdsForRet.FieldByName('RET_TIPRET').AsInteger = 5,
          qryTabela.FieldByName('FIS_RETISS').AsFloat -
            (fltValRetAnt - cdsForRet.FieldByName('VALRET').AsFloat),
          qryTabela.FieldByName('FIS_RETISS').AsFloat),

      IIF(cdsForRet.FieldByName('RET_TIPRET').AsInteger = 6,
          qryTabela.FieldByName('FIS_RINSSP').AsFloat -
            (fltValRetAnt - cdsForRet.FieldByName('VALRET').AsFloat),
          qryTabela.FieldByName('FIS_RINSSP').AsFloat)
      );
  end;

procedure TfraCadImpostosNFS.pCalculaValorRetencaoAliquota(strNomCampo: String; fltValRetAnt: Double);
var
  strCampoClaFisServico : String;
Begin
  If fCampoAliquotaOuValRet(strNomCampo) Then
  Begin
    cdsForRet.Edit();
    strCampoClaFisServico := fRetcampoClaFisServico;


    cdsForRet.Edit();
    If cdsForRet.FieldByName('VALBAS').AsFloat = 0 Then
      cdsForRet.FieldByName('VALBAS').AsFloat := qryTabela.FieldByName(strCampoClaFisServico).AsFloat;

    If (strNomCampo = 'RET_ALIQUO') Then //mudou aliquota, calcula retenção
      cdsForRet.FieldByName('VALRET').AsFloat := cdsForRet.FieldByName('VALBAS').AsFloat *
        (cdsForRet.FieldByName('RET_ALIQUO').AsFloat / 100)
    Else If (strNomCampo = 'VALRET') Then  ////mudou retenção, calcula aliquota
      cdsForRet.FieldByName('RET_ALIQUO').AsFloat := cdsForRet.FieldByName('VALRET').AsFloat /
        cdsForRet.FieldByName('VALBAS').AsFloat * 100

    Else If (strNomCampo = 'VALBAS') Then // mudou base, calcula retenção
      cdsForRet.FieldByName('VALRET').AsFloat := cdsForRet.FieldByName('VALBAS').AsFloat *
        (cdsForRet.FieldByName('RET_ALIQUO').AsFloat / 100);

    pAjustarValoresRetencoes(fltValRetAnt);

    cdsForRet.Post();

  End;

End;


procedure TfraCadImpostosNFS.grdImpostosRET_CODRECPropertiesInitPopup(
  Sender: TObject);
var
  BoxProperties: TcxLookupComboBoxProperties;
begin
  BoxProperties := TcxLookupComboBox(Sender).ActiveProperties;
  BoxProperties.DropDownWidth := 450;
  BoxProperties.Grid.Columns[0].Width := 100;
  BoxProperties.Grid.Columns[1].Width := 350;
end;

procedure TfraCadImpostosNFS.grdImpostosTableView1DblClick(Sender: TObject);
begin
  btnAlterarImp.Click;
end;

procedure TfraCadImpostosNFS.grdImpostosTableView1EditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);

  Var
    strNomCampo : String;
    fltValRetAnt: Double;

begin
  If Not cdsForRet.Active Then
    Exit;

  fltValRetAnt := cdsForRet.FieldByName('VALRET').AsFloat;

  If (cdsForRet.State = dsEdit) Then
    cdsForRet.Post();

  strNomCampo := (AItem as TcxGridDBColumn).DataBinding.FieldName;

  //pCalculaValorRetencaoAliquota(strNomCampo, fltValRetAnt);


  If fCampoAliquotaOuValRet(strNomCampo) Then
  Begin
    cdsForRet.Edit();

    If (strNomCampo = 'RET_ALIQUO') Then //mudou aliquota, calcula retenção
      cdsForRet.FieldByName('VALRET').AsFloat := cdsForRet.FieldByName('VALBAS').AsFloat *
        (cdsForRet.FieldByName('RET_ALIQUO').AsFloat / 100)
    Else If (strNomCampo = 'VALRET') Then  ////mudou retenção, calcula aliquota
      cdsForRet.FieldByName('RET_ALIQUO').AsFloat := cdsForRet.FieldByName('VALRET').AsFloat /
        cdsForRet.FieldByName('VALBAS').AsFloat * 100
    Else If (strNomCampo = 'VALBAS') Then // mudou base, calcula retenção
      cdsForRet.FieldByName('VALRET').AsFloat := cdsForRet.FieldByName('VALBAS').AsFloat *
        (cdsForRet.FieldByName('RET_ALIQUO').AsFloat / 100);

    pAjustarValoresRetencoes(fltValRetAnt);

    cdsForRet.Post();
  End;

  If strNomCampo = 'RET_TIPDOC' Then
  Begin
    pLiberaTravaColunaGuiaETipoTributo;
  End;

end;

procedure TfraCadImpostosNFS.grdImpostosTableView1FocusedItemChanged(
  Sender: TcxCustomGridTableView; APrevFocusedItem,
  AFocusedItem: TcxCustomGridTableItem);
begin
  If APrevFocusedItem = grdImpostosRET_Q_GUIA Then
    pCarregaTipoTributos(True);
end;

procedure TfraCadImpostosNFS.grdImpostosTableView1FocusedRecordChanged(
  Sender: TcxCustomGridTableView; APrevFocusedRecord,
  AFocusedRecord: TcxCustomGridRecord; ANewItemRecordFocusingChanged: Boolean);
begin
  pLiberaTravaColunaGuiaETipoTributo;
end;

procedure TfraCadImpostosNFS.mskCodCtaRetEnter(Sender: TObject);
begin
  MskCodCtaRet.EditMask := '';
end;

procedure TfraCadImpostosNFS.mskCodCtaRetExit(Sender: TObject);
begin
  MskCodCtaRet.EditMask := '99.99.999;0;_'
end;


procedure TfraCadImpostosNFS.mskCodCtaRetKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCtaFor : TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then Begin
    If fPesqCentroCusto(frmPai, mskCodCtaRet, edtDesCtaRet, nil, Key, arrCtaFor, True, fCfgSis('USACTF', varBoolean), edtCodFor.Text) Then Begin
      fValidaCampos(mskCodCtaRet, False);
      SelectNext(frmPai.ActiveControl, True, True);
    End;
  End;

end;

function TfraCadImpostosNFS.fCampoAliquotaOuValRet(strNomCampo:String): Boolean;
Begin
  Result := False;
  If strNomCampo = 'RET_ALIQUO' Then
    Exit(True);
  If  strNomCampo = 'VALRET' Then
    Exit(True);
  If  strNomCampo = 'VALBAS' Then
    Exit(True);
End;

procedure TfraCadImpostosNFS.pSetaValores(fltRetPis, fltRetCofins, fltRetCsll, fltRetIrrf, fltRetInss,fltRetIss, fltRetInssPatronal: Double);
begin
  //PIS
  qryTabela.FieldByName('FIS_VREPIS').AsFloat := fltRetPis;

  //COFINS
  qryTabela.FieldByName('FIS_VRECOF').AsFloat := fltRetCofins;

  //CSLL
  qryTabela.FieldByName('FIS_RECSSL').AsFloat := fltRetCsll;

  //IRRF
  qryTabela.FieldByName('FIS_REIRRF').AsFloat := fltRetIrrf;

  //INSS
  qryTabela.FieldByName('FIS_REINSS').AsFloat := fltRetInss;

  //ISS
  qryTabela.FieldByName('FIS_RETISS').AsFloat := fltRetIss;

  //INSS PATRONAL
  qryTabela.FieldByName('FIS_RINSSP').AsFloat := fltRetInssPatronal;
end;

Procedure TfraCadImpostosNFS.pSetClaFis(Value: String);
Begin
  If Value <> FClaFis Then
  Begin
    FClaFis := Value;
    pManipulaCampoCodigoVerificador;
  End;
End;

procedure TfraCadImpostosNFS.pCalculaServico;
begin
  If (Not fEmptyStr(dbeBasIss.Text)) Then
    If (Not fEmptyStr(dbeAlqIss.Text)) Then
      dbeValISS.Field.AsFloat := fCalculaValorIss(fStrToFloat(AnsiReplaceStr(dbeBasIss.Text, '.', '')), fStrToFloat(dbeAlqIss.Text));
end;

procedure TfraCadImpostosNFS.pAjustarCamposRetencoesLivFis(fltRetPis, fltRetCofins,
  fltRetCsll, fltRetIrrf, fltRetInss, fltRetIss, fltRetInssPatronal: Double);
  Var
    blnDarPost: Boolean;
begin
  If Not cdsForRet.Active Then
    Exit;

  If (cdsForRet.State = dsBrowse) Then
    Exit;

  If Not (qryTabela.State In dsEditModes) Then
  Begin
    qryTabela.Edit;
    blnDarPost := True;
  End

  Else
    blnDarPost := False;

   pSetaValores(fltRetPis, fltRetCofins, fltRetCsll, fltRetIrrf, fltRetInss,fltRetIss, fltRetInssPatronal);

  If blnDarPost Then
    qryTabela.Post;
end;

function TfraCadImpostosNFS.fEntradaDeServico: Boolean;
begin
  Result := False;
  If FTip_Fc = 'F' Then
    If (Not fEmptyStr(FNomFor)) Then
      If ('933' = Copy(FClaFis, 2, 3)) Then
        If FEntSai = 'E' Then
          Result := True;
End;

function TfraCadImpostosNFS.fCarregaRetencoes(blnHabilitaSempre: Boolean): Boolean;
begin
  Result := True;
  If Not blnEntradaMercadoria Then
    If (Not blnHabilitaSempre) Then
      If (qryTabela.State in [dsBrowse, dsEdit]) Then
      Exit(False);

  If Not fEntradaDeServico Then
    Exit(False);
End;

procedure TfraCadImpostosNFS.pCarregarRetencoes(blnHabilitaSempre: Boolean = False);
  Var
    strSQL: String;
begin
  If Not fCarregaRetencoes(blnHabilitaSempre) Then
    Exit;

  strSQL := 'SELECT ' +
            '  FORRET.AUTOINCREM, ' +
            '  RET_TIPRET, ' +
            '  RET_CODFOR, ' +
            '  RET_CODEVE, ' +
            '  RET_CODPOR, ' +
            '  RET_CODCTA, ' +
            '  RET_ALIQUO, ' +
            '  RET_DIAVEN, ' +
            '  RET_TIPVEN, ' +
            '  RET_FORRET, ' +
            '  FOR_NOMFOR, ' +
            '  CTA_DESCTA, ' +
            '  EVE_DESEVE, ' +
            '  POR_NOMPOR, ' +
            '  CONCAT(EVE_CODEVE, "-", EVE_DESEVE) AS DESEVE, ' +
            '  CONCAT(POR_CODPOR, "-", POR_NOMPOR) AS NOMPOR, ' +
            '  CONCAT(CTA_CODCTA, "-", CTA_DESCTA) AS DESCTA, ' +
            '  CONCAT(FOR_CODFOR, "-", FOR_NOMFOR) AS DESFOR, ' +
            '  CASE RET_TIPRET ' +
            '    WHEN "0" THEN "Retenção de PIS" ' +
            '    WHEN "1" THEN "Retenção de COFINS" ' +
            '    WHEN "2" THEN "Retenção de CSLL" ' +
            '    WHEN "3" THEN "Retenção de IRRF" ' +
            '    WHEN "4" THEN "Retenção de INSS" ' +
            '    WHEN "5" THEN "Retenção de ISS" ' +
            '    WHEN "6" THEN "Retenção de INSS Patronal" ' +
            '    ELSE "" ' +
            '  END AS DESTIP, ' +
            '  IF(RET_TIPVEN = "0", "Dia Fixo", "Último Dia do Mês") AS DESVEN, ' +
            '  0.00 AS VALRET, ' +
            '  0.00 AS VALBAS, ' +
            '  RET_Q_GUIA, ' +
            '  RET_TIPDOC, ' +
            '  RET_CODREC  ' +
            'FROM ' +
            '  FORRET ' +
            '  LEFT JOIN CADEVE ON RET_CODEVE = EVE_CODEVE ' +
            '  LEFT JOIN CADPOR ON RET_CODPOR = POR_CODPOR ' +
            '  LEFT JOIN CADCTA ON RET_CODCTA = CTA_CODCTA ' +
            '  LEFT JOIN CADFOR ON RET_FORRET = FOR_CODFOR ' +
            'WHERE RET_CODFOR = :CODFOR ORDER BY RET_TIPRET';

  qryForRet.Close();
  qryForRet.SQL.Clear();
  qryForRet.SQL.Text := strSQL;

  qryForRet.ParamByName('CODFOR').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;

  cdsForRet.Close;
  cdsForRet.SetProvider(dspForRet);

  qryForRet.Open;

  pSetaClient(qryForRet);

  cdsForRet.Open;

  If (Not cdsForRet.IsEmpty()) Then
    grdImpostosTableView1.ApplyBestFit();

  If blnEntradaMercadoria Then
  Begin
    If qryTabela.State = dsBrowse Then
      qryTabela.Edit;

    grbRetencoes.Visible := True;
    grbRetencoes.Enabled := grbRetencoes.Visible;
  End
  Else
  Begin
    grbRetencoes.Visible := fVisibilidadeRetencao(blnHabilitaSempre);
    grbRetencoes.Enabled := fRetencaoEnabled(blnHabilitaSempre);

  End;

  grpRetencaoDados.Visible:= cdsForRet.IsEmpty();
  grpRent.Visible         := False;
  pnlBotoesImp.Visible    := grpRetencaoDados.Visible;


  btnCalcRet.Click();

  dbeVREPIS.ReadOnly := False;

  dbeVRECOF.ReadOnly := False;

  dbeRetISS.ReadOnly := False;
  dbeReIRRF.ReadOnly := False;
  dbeReCSSL.ReadOnly := False;
  dbeReINSS.ReadOnly := False;
  dbeReINSSP.ReadOnly := False;

  If grbRetencoes.Visible Then
  Begin
    dbeVREPIS.ReadOnly := cdsForRet.Locate('RET_TIPRET', TIPRET_PIS,    []);
    dbeVRECOF.ReadOnly := cdsForRet.Locate('RET_TIPRET', TIPRET_COFINS, []);
    dbeRetISS.ReadOnly := cdsForRet.Locate('RET_TIPRET', TIPRET_ISS,  []);
    dbeReIRRF.ReadOnly := cdsForRet.Locate('RET_TIPRET', TIPRET_IRFF, []);
    dbeReCSSL.ReadOnly := cdsForRet.Locate('RET_TIPRET', TIPRET_CSLL, []);
    dbeReINSS.ReadOnly := cdsForRet.Locate('RET_TIPRET', TIPRET_INSS, []);
    dbeReINSSP.ReadOnly := cdsForRet.Locate('RET_TIPRET', TIPRET_INSSP, []);
  End;

end;

function TfraCadImpostosNFS.fCalcularDataVencimento(var wrdAno: Word; var wrdMes: Word;  var wrdDia: Word;
                                                    var dteVencto: TDateTime; var dteUltDiaMes: TDateTime): TDateTime;
begin
  dteVencto := dtaDtaEnt;
  DecodeDate(dteVencto, wrdAno, wrdMes, wrdDia);

  If wrdMes = 12 Then
    dteUltDiaMes := EndOfAMonth(wrdAno + 1, 1)
  Else
    dteUltDiaMes := EndOfAMonth(wrdAno, wrdMes +1);

  DecodeDate(dteUltDiaMes, wrdAno, wrdMes, wrdDia);

  Case (cdsForRet.FieldByName('RET_TIPVEN').AsInteger) Of
    //VENCIMENTO EM DIA FIXO
    0: Result := EncodeDate(wrdAno,
                            wrdMes,
                            IIF(cdsForRet.FieldByName('RET_DIAVEN').AsInteger > wrdDia,
                                wrdDia,
                                cdsForRet.FieldByName('RET_DIAVEN').AsInteger));
    //VENCIMENTO NO ÚLTIMO DIA DO MÊS
    1: Result := EncodeDate(wrdAno,
                            wrdMes,
                            wrdDia);
    Else
      Result := 0;
  End;

End;



function  TfraCadImpostosNFS.fCriarParcelasRetencoesFornecedor(AutIncFis: string; AstrLocalOrigem: String = ''): Boolean;
  Var
    wrdAno, wrdMes, wrdDia : Word;
    dteVencto, dteUltDiaMes: TDateTime;
    strLogCta, strHist, strTipRet: String;

begin
  Try
    Try
      cdsForRet.DisableControls();
      cdsForRet.First();

      While (Not cdsForRet.Eof) Do Begin
        If (cdsForRet.FieldByName('RET_ALIQUO').AsFloat > 0) And
          (cdsForRet.FieldByName('VALRET').AsFloat > 0) Then
        Begin
          FstrNumDup := fRetSequencialCadPag();
          strLogCta := 'INCLUSÃO LIVRO FISCAL';

          Case (cdsForRet.FieldByName('RET_TIPRET').AsInteger) Of
            0: strTipRet := 'RETENÇÃO DE PIS';
            1: strTipRet := 'RETENÇÃO DE COFINS';
            2: strTipRet := 'RETENÇÃO DE CSSL';
            3: strTipRet := 'RETENÇÃO DE IRRF';
            4: strTipRet := 'RETENÇÃO DE INSS';
            5: strTipRet := 'RETENÇÃO DE ISS';
            6: strTipRet := 'RETENÇÃO DE INSS PATRONAL';
          End;

          strHist := strTipRet + ' do documento ' +
            strNumDoc + '-' + strEspDoc + '-' + strSerie + '-' + strCodEmp +
            ', Fornecedor: ' + strForCli + '-' + strNomFor +
            ', emitida em ' + DateToStr(dtaDtaDoc) + '.';

          fGravaCadPag('frmCadLivroFiscal',                            // Nome Form LOGCTP
                       strLogCta,                                      // Descrição LOGCTP
                       cdsForRet.FieldByName('RET_FORRET').AsString,   // Fornecedor
                       FstrNumDup,                                      // Número da duplicata
                       'A',                                            // Parcela
                       strCodEmp,                       // Empresa
                       cdsForRet.FieldByName('RET_CODCTA').AsString,   // Centro de Custo
                       '',                                             // Serie do Documento
                       0,                                              // Sequencial de Baixa
                       dtaDtaEnt,                                         // Data do lançamento
                       fCalcularDataVencimento(wrdAno, wrdMes, wrdDia, dteVencto, dteUltDiaMes), // Data de Vencimento
                       cdsForRet.FieldByName('VALRET').AsFloat,        // Valor da Duplicata
                       cdsForRet.FieldByName('VALRET').AsFloat,        // Valor Original
                       'N',                                            // Previsão?
                       'N',                                            // Veio Boleto
                       'N',                                            // Deposito
                       strHist,                                        // Histórico 1
                       '',                                             // Histórico 2
                       '',                                             // Histórico da Baixa
                       '',                                             // Portador da Baixa
                       '',                                             // Centro de Custo da Baixa
                       '',                                             // Documento da Baixa
                       '',                                             // Operador da Baixa
                       0,                                              // Data do Pagamento
                       0,                                              // Valor Pago
                       0,                                              // Valor de Juros
                       0,                                              // Valor Desconto
                       '',                                             // Empresa
                       cdsForRet.FieldByName('RET_CODEVE').AsString,   // Codigo do Evento
                       'N',                                            // Usa Cheque
                       cdsForRet.FieldByName('RET_CODPOR').AsString,   // Codigo do Portador
                       strNumDoc,                                      // Número do documento
                       0,
                       0,
                       0,
                       False,
                       0,
                       cdsForRet.FieldByName('RET_TIPDOC').AsString,
                       0,
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
                       FormatDateTime('mm/yyyy', dtaDtaDoc),
                       '',
                       '',
                       '',
                       '',
                       0,
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
                       cdsForRet.FieldByName('RET_Q_GUIA').AsString,
                       cdsForRet.FieldByName('RET_CODREC').AsString,
                       '',
                       '',
                       '',
                       'N',
                       '',
                       '',
                       '',
                       '',
                       0,
                       '',
                       0,
                       '',
                       0,
                       0,
                       0,
                       '',
                       '',
                       AutIncFis);
          pGravarCtpDet('A', AstrLocalOrigem);
        End;

        cdsForRet.Next();
      End;
      Result := True;
    Finally
      cdsForRet.EnableControls();
    End;
  Except
    Result := False;
  End;
end;


Class Function TfraCadImpostosNFS.fCriaFrameImpostos(frmDestino: TForm; tbsPagina: TWinControl): TfraCadImpostosNFS;
Begin
  Result := TfraCadImpostosNFS.Create(frmDestino);
  Result.frmPai    := frmDestino;
  Result.Parent    := tbsPagina;
  Result.Top       := 0;
  Result.TabOrder  := 0;
  Result.blnCarregaCSTPisConfisAoDefinirCFOP := False;
End;

Procedure TfraCadImpostosNFS.pInicializaDados(qryTabela: TDataSet);
Begin
  Self.qryTabela := qryTabela;
  Self.dtsTabela.DataSet := qryTabela;

  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);

  pCarregaGuiasETributos;
End;

procedure TfraCadImpostosNFS.pCarregaDadosReinf;
begin
  gbpREINF.Visible := ((fCfgSis('UTIREI', varBoolean)) and
                       (not blnEntradaMercadoria) and
                       (fObrigaTipoServicoNaturezaRendimentoREINF(strTip_Fc, strForCli)));

  edtNatRend.Text := fRetReinfNaturezaDoRendimento(dbeCodNatRend.Text);
  edtTipoServico.Text := fRetReinfTipoDeServico(dbeCodTipServ.Text);
end;

Procedure TfraCadImpostosNFS.pAtualizaDados(strEspDoc, strClaFis, strTip_Fc, strNomFor, strEntSai,
                                            strForCli, strCodEmp, strNumDoc: String; strSerie: String;
                                            dtaDtaDoc, dtaDtaEnt: TDate);
Begin
  Self.strEspDoc := strEspDoc;
  Self.strClaFis := strClaFis;
  Self.strTip_Fc := strTip_Fc;
  Self.strNomFor := strNomFor;
  Self.strEntSai := strEntSai;
  Self.strForCli := strForCli;
  Self.strCodEmp := strCodEmp;
  Self.strNumDoc := strNumDoc;
  Self.dtaDtaDoc := dtaDtaDoc;
  Self.dtaDtaEnt := dtaDtaEnt;
  Self.strSerie  := strSerie;
End;

Procedure TfraCadIMpostosNFS.pCarregaGuiasETributos(ATrazTributo: Boolean = False);
Begin
  If Not Assigned(qryGuiaTributo) Then
    qryGuiaTributo := fCriaQuery(Self);

  qryGuiaTributo.Close;
  qryGuiaTributo.SQL.Clear;
  qryGuiaTributo.SQL.Add('SELECT GUI_CODGUI, GUI_DESCRI ');
  qryGuiaTributo.SQL.Add('FROM GUITRI ');
  qryGuiaTributo.Open;

  If Not Assigned(qryTipoTributo) Then
    qryTipoTributo := fCriaQuery(Self);
  qryTipoTributo.Close;
  qryTipoTributo.SQL.Clear;
  qryTipoTributo.SQL.Add('SELECT TRI_CODTRI, TRI_CODGUI, TRI_DESCRI ');
  qryTipoTributo.SQL.Add('FROM TIPTRI ');

  if ATrazTributo then
  begin
    qryTipoTributo.SQL.Add('WHERE TRI_CODGUI = :CODGUI ');
    qryTipoTributo.ParamByName('CODGUI').AsInteger := qryGuiaTributo.FieldByName('GUI_CODGUI').AsInteger;
  end
  else
    qryTipoTributo.SQL.Add('WHERE FALSE ');

  qryTipoTributo.Open;

  dtsGuiaTributo.DataSet := qryGuiaTributo;
  dtsTipoTributo.DataSet := qryTipoTributo;
End;

procedure TfraCadImpostosNFs.pCarregaTipoTributos(ABlnOrigemGrid: Boolean = False);
begin
  If ABlnOrigemGrid Then
  Begin
    qryTipoTributo.Close;
    qryTipoTributo.SQL.Clear;
    qryTipoTributo.SQL.Add('SELECT TRI_CODTRI, TRI_CODGUI, TRI_DESCRI ');
    qryTipoTributo.SQL.Add('FROM TIPTRI ');
    qryTipoTributo.SQL.Add('WHERE TRI_CODGUI = :CODGUI ');
    qryTipoTributo.ParamByName('CODGUI').AsInteger := cdsForRet.FieldByName('RET_Q_GUIA').AsInteger;
    qryTipoTributo.Open;
  End
  Else
    Begin
    If (VarToStr(LcbGuiaTributo.KeyValue) <> '') And
       (LcbGuiaTributo.KeyValue > 0) then
    Begin
      qryTipoTributo.Close;
      qryTipoTributo.SQL.Clear;
      qryTipoTributo.SQL.Add('SELECT TRI_CODTRI, TRI_CODGUI, TRI_DESCRI ');
      qryTipoTributo.SQL.Add('FROM TIPTRI ');
      qryTipoTributo.SQL.Add('WHERE TRI_CODGUI = :CODGUI ');
      qryTipoTributo.ParamByName('CODGUI').AsInteger := LcbGuiaTributo.KeyValue;
      qryTipoTributo.Open;
    End;

    LcbTipoTributo.Enabled := qryTipoTributo.RecordCount > 0;
  End;

  If Not fEmptyStr(cdsForRet.FieldByName('RET_CODREC').AsString) Then
    cdsForRet.FieldByName('RET_CODREC').Clear;
end;

procedure TfraCadImpostosNFs.pLiberaTravaColunaGuiaETipoTributo;
begin
  If Not Assigned(cdsForRet.FindField('RET_TIPDOC')) Then
    Exit;

  If cdsForRet.FieldByName('RET_TIPDOC').AsInteger > 1 Then
  Begin
    grdImpostosRET_Q_GUIA.Options.Editing := True;
    grdImpostosRET_CODREC.Options.Editing := True;
  End
  Else
  Begin
    grdImpostosRET_Q_GUIA.Options.Editing := False;
    grdImpostosRET_CODREC.Options.Editing := False;

    If (Not fEmptyStr(cdsForRet.FieldByName('RET_Q_GUIA').AsString)) Or (Not fEmptyStr(cdsForRet.FieldByName('RET_CODREC').AsString)) Then
    Begin
      cdsForRet.Edit;
      cdsForRet.FieldByName('RET_Q_GUIA').Clear;
      cdsForRet.FieldByName('RET_CODREC').Clear;
      cdsForRet.Post;
    End;
  End;
end;

procedure TfraCadImpostosNFs.pGravarCtpDet(strParcel: String; strLocalOrigem: String = '');
  Var
    qryInsert: TUniQuery;
    strAutIncCtpDet: String;
begin
  qryInsert := fCriaQuery;

  if fEmptyStr(strLocalOrigem) Then
    strLocalOrigem := 'frmDesmembrValores';

  qryInsert.SQL.Add('INSERT INTO ');
  qryInsert.SQL.Add('  CTPDET ');
  qryInsert.SQL.Add('( ');
  qryInsert.SQL.Add('  CTP_NUMDUP, ');
  qryInsert.SQL.Add('  CTP_PARCEL, ');
  qryInsert.SQL.Add('  CTP_SERIE_, ');
  qryInsert.SQL.Add('  CTP_CODEMP, ');
  qryInsert.SQL.Add('  CTP_CODFOR, ');
  qryInsert.SQL.Add('  CTP_CODCTA, ');
  qryInsert.SQL.Add('  CTP_EMPORI, ');
  qryInsert.SQL.Add('  CTP_FATCAL, ');
  qryInsert.SQL.Add('  CTP_CODEVE, ');
  qryInsert.SQL.Add('  AUTOINCREM ');
  qryInsert.SQL.Add(') VALUES ( ');
  qryInsert.SQL.Add('  :NUMDUP, ');
  qryInsert.SQL.Add('  :PARCEL, ');
  qryInsert.SQL.Add('  :SERIE_, ');
  qryInsert.SQL.Add('  :CODEMP, ');
  qryInsert.SQL.Add('  :CODFOR, ');
  qryInsert.SQL.Add('  :CODCTA, ');
  qryInsert.SQL.Add('  :EMPORI, ');
  qryInsert.SQL.Add('  :FATCAL, ');
  qryInsert.SQL.Add('  :CODEVE, ');
  qryInsert.SQL.Add('  :AUTINC) ');

  If Not Assigned(qryCtaDet) Then
    Exit;

  If Not qryCtaDet.Active Then
    qryCtaDet.Open;

  strAutIncCtpDet := fRetAutoIncrem('CTPDET', VS_strCodEmp, qryCtaDet.RecordCount);
  qryCtaDet.First;

  While (Not qryCtaDet.Eof) Do
  Begin
    qryInsert.ParamByName('NUMDUP').AsString := FstrNumDup;
    qryInsert.ParamByName('PARCEL').AsString := strParcel;
    //qryInsert.ParamByName('SERIE_').AsString := strSerie;
    qryInsert.ParamByName('CODEMP').AsString := qryCtaDet.FieldByName('CTP_CODEMP').AsString;
    qryInsert.ParamByName('CODFOR').AsString := cdsForRet.FieldByName('RET_FORRET').AsString;
    qryInsert.ParamByName('CODCTA').AsString := qryCtaDet.FieldByName('CTP_CODCTA').AsString;
    qryInsert.ParamByName('EMPORI').AsString := VS_strCodEmp;
    qryInsert.ParamByName('FATCAL').AsFloat  := qryCtaDet.FieldByName('CTP_FATCAL').AsFloat;
    qryInsert.ParamByName('CODEVE').AsString := qryCtaDet.FieldByName('CTP_CODEVE').AsString;

    If fEmptyStr(qryInsert.ParamByName('CODEVE').AsString) Then
      qryInsert.ParamByName('CODEVE').Clear;

    If fEmptyStr(strAutIncCtpDet) Then
    Begin

      qryInsert.ParamByName('AUTINC').AsString := fRetAutoIncrem('CTPDET', VS_strCodEmp);

    End Else
    Begin
      qryInsert.ParamByName('AUTINC').AsString := strAutIncCtpDet;
      strAutIncCtpDet := fNextAutoIncrem(strAutIncCtpDet);
    End;

    qryInsert.ExecSQL;

    pGravaLogCtpDet(qryInsert.ParamByName('AUTINC').AsString,
                    'INCLUSÃO',
                    strLocalOrigem);

    qryCtaDet.Next;
  End;

  FreeAndNil(qryInsert);
end;


end.
