{***********************}
{* qryConPor -> CADPOR *}
{********************JB*}

unit untCadCondicoes;

interface

uses
  Windows, Classes, Controls, untPaiCad, Menus, ComCtrls, StdCtrls, Buttons,
  ExtCtrls, DBCtrls, DBEditFocus, QColorLabel, EditFocus, DB, DBComboBoxFocus,
  Uni, AppEvnts, ComboBoxFocus, DBMemoFocus, BitBtnLockedIncrem, Mask, frxClass,
  frxExportCSVTestabilidade, Vcl.CheckLst, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxSpinEdit, cxDBEdit, cxButtons, DateUtils, cxCheckBox,
  cxDropDownEdit, cxCheckComboBox, cxDBCheckComboBox, UniClientDataSet;

type
  TfrmCadCondicoes = class(TfrmPaiCad)
    pnlFundo: TPanel;
    pnlDados2: TPanel;
    lblPortador: TLabel;
    dbeCodPor: TDBEditFocus;
    edtNomPor: TEditFocus;
    pnlDados1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    dbeCodigo: TDBEditFocus;
    dbeDescri: TDBEditFocus;
    dbcTipFor: TDBComboBoxFocus;
    pnlFormaPagto: TPanel;
    lblFormPagto: TLabel;
    dbeCodFpg: TDBEditFocus;
    edtDesFpg: TEditFocus;
    dtsCadCnd: TDataSource;
    lblAbaDes: TLabel;
    clbAbaDes: TColorLabel;
    lblAbDeCc: TLabel;
    clbAbDeCc: TColorLabel;
    lblTaxJuros: TLabel;
    lblPorTaxJur: TLabel;
    lblPrzMedio: TLabel;
    lblFatAca: TLabel;
    Label4: TLabel;
    ColorLabel1: TColorLabel;
    dbeAbaDes: TDBEditFocus;
    dbeAbDeCc: TDBEditFocus;
    dbeTaxJur: TDBEditFocus;
    dbePrzMed: TDBEditFocus;
    dbeFatAca: TDBEditFocus;
    dbeInfAna: TDBEditFocus;
    lblValMin: TLabel;
    dbeValMin: TDBEditFocus;
    Label6: TLabel;
    dbeCndPag: TDBEditFocus;
    pnlDiaFix: TPanel;
    lblQtdPar: TLabel;
    dbeQtdPar: TDBEditFocus;
    dbcSemEnt: TDBCheckBox;
    lblPerCom: TLabel;
    dbePerCom: TDBEditFocus;
    lblPercen: TLabel;
    Label5: TLabel;
    cbbDiaFix: TComboBoxFocus;
    lblPerDPo: TLabel;
    lblPercn2: TLabel;
    dbePerDPo: TDBEditFocus;
    dbeQtdDAV: TDBEditFocus;
    lblQtdDAV: TLabel;
    lblTabPre: TLabel;
    lbl10: TLabel;
    lbl11: TColorLabel;
    dbeImpFat: TDBEditFocus;
    btnDescMax: TBitBtnLocked;
    Label10: TLabel;
    lblPraMin: TLabel;
    dbePraMin: TDBEditFocus;
    corPraMin: TColorLabel;
    dbeJurPro: TDBEditFocus;
    ColorLabel7: TColorLabel;
    tbsEmpresas: TTabSheet;
    pnlEmpresas: TPanel;
    clbEmpCnd: TCheckListBox;
    pnlSelEmp: TPanel;
    lblLegenda: TLabel;
    Label14: TLabel;
    dbcTipCnd: TComboBoxFocus;
    tbsPerfil: TTabSheet;
    pnlPerfil: TPanel;
    gpbPerfil: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    ColorLabel3: TColorLabel;
    lblAltPre: TLabel;
    lbl4: TLabel;
    ColorLabel5: TColorLabel;
    lbl5: TLabel;
    ColorLabel6: TColorLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    Label11: TLabel;
    ColorLabel8: TColorLabel;
    lblLbPdOb: TLabel;
    clbLbPdOb: TColorLabel;
    lblMaxCar: TLabel;
    Label12: TLabel;
    Label15: TLabel;
    ColorLabel2: TColorLabel;
    dbeImpBol: TDBEditFocus;
    dbeSenCnd: TDBEditFocus;
    dbeLimCre: TDBEditFocus;
    dbeDesPfl: TDBMemoFocus;
    dbeMarMin: TDBEditFocus;
    dbeMarMax: TDBEditFocus;
    dbeFatMin: TDBEditFocus;
    dbeFatMax: TDBEditFocus;
    gpbTipFat: TGroupBox;
    chkTipFatA: TCheckBox;
    chkTipFatB: TCheckBox;
    chkTipFatC: TCheckBox;
    chkTipFatD: TCheckBox;
    dbeTrTtVe: TDBEditFocus;
    dbeLbPdOb: TDBEditFocus;
    dbeMaxCar: TDBEditFocus;
    dbcTrClCr: TComboBoxFocus;
    dbcAltPre: TComboBoxFocus;
    gpbFpgNvl: TGroupBox;
    chkNaoValidaDin: TCheckBox;
    chkNaoValidaChq: TCheckBox;
    chkNaoValidaCar: TCheckBox;
    dbeSenTra: TDBEditFocus;
    gpbDespAcess: TGroupBox;
    Label8: TLabel;
    dbePeDeAc: TDBEditFocus;
    Label9: TLabel;
    Label16: TLabel;
    dbeVrDaUv: TDBEditFocus;
    gpbTpFtDa: TGroupBox;
    chkTpFtDaA: TCheckBox;
    chkTpFtDaB: TCheckBox;
    chkTpFtDaC: TCheckBox;
    lblVrDeAc: TLabel;
    dbeVrDeAc: TDBEditFocus;
    rdgMCobDa: TDBRadioGroup;
    chkTpFtDaD: TCheckBox;
    lblExpFSo: TLabel;
    corExpFSo: TColorLabel;
    dbeExpFSo: TDBEditFocus;
    Label18: TLabel;
    dbeParMin: TDBEditFocus;
    Label19: TLabel;
    dbeParMax: TDBEditFocus;
    gpbDestino: TGroupBox;
    dbeRetira: TDBEditFocus;
    clblRetira: TColorLabel;
    lblRetira: TLabel;
    dbeEntregaImediata: TDBEditFocus;
    clblEntregaImediata: TColorLabel;
    lblEntregaImediata: TLabel;
    lblEntregaFutura: TLabel;
    dbeEntregaFutura: TDBEditFocus;
    clblEntregaFutura: TColorLabel;
    Label17: TLabel;
    dbeQtdMax: TDBEditFocus;
    dbcTrClCb: TComboBoxFocus;
    Label20: TLabel;
    lblExpB2B: TLabel;
    dbeExpB2B: TDBEditFocus;
    corExpB2B: TColorLabel;
    clbPreTab: TCheckListBox;
    spnLimite: TcxDBSpinEdit;
    lblLimite: TLabel;
    btnLimite: TBitBtnLocked;
    lblGeraCobrancaYapay: TLabel;
    dbeGeraCobrancaYapay: TDBEditFocus;
    clbGeraCobrancaYapay: TColorLabel;
    lblUsaDeps: TLabel;
    dbeUsaDeps: TDBEditFocus;
    lblUsaDeps_SN: TColorLabel;
    lblRcx_F3: TLabel;
    dbeRcx_F3: TDBEditFocus;
    ColorLabel4: TColorLabel;
    GroupBox1: TGroupBox;
    Label21: TLabel;
    dbcTrOrCr: TComboBoxFocus;
    Label22: TLabel;
    dbcTrOrCb: TComboBoxFocus;
    gpbConfiguracoesYapay: TGroupBox;
    edtYapPar: TDBEditFocus;
    Label24: TLabel;
    cbYapDis: TcxCheckComboBox;
    Label23: TLabel;
    cbYapTra: TDBCheckBox;
    dbcDiaCor: TDBCheckBox;
    lblPerVen: TLabel;
    dbePerVen: TDBEditFocus;
    lblPerPerVer: TLabel;
    dbcTraPar: TComboBoxFocus;
    dbcTraMar: TComboBoxFocus;
    dbcTraFat: TComboBoxFocus;
    lblCndEsp: TLabel;
    dbeCondEsp: TDBEditFocus;
    clbCndEsp: TColorLabel;
    lblDesMaxGer: TLabel;
    dbeDesMGe: TDBEditFocus;
    Label7: TLabel;
    lblDesMaxSub: TLabel;
    dbeDesMSu: TDBEditFocus;
    Label13: TLabel;
    lblDescMax: TLabel;
    dbeDesMax: TDBEditFocus;
    lblPorDesMax: TLabel;
    lblDesMaxGerM: TLabel;
    dbeDesMGeM: TDBEditFocus;
    Label28: TLabel;
    lblDesMaxSubM: TLabel;
    dbeDesMSuM: TDBEditFocus;
    Label30: TLabel;
    lblDescMaxM: TLabel;
    dbeDesMaxM: TDBEditFocus;
    pnlRecebimentoPix: TPanel;
    Label27: TLabel;
    ColorLabel9: TColorLabel;
    dbeRecebimentoPix: TDBEditFocus;
    Label31: TLabel;
    dbeTravaCliCompra: TDBEditFocus;
    ColorLabel10: TColorLabel;
    pnlLinkPgtoOnline: TPanel;
    lbGeraLinkPgtoOnline: TLabel;
    clbGeraLinkPgtoOnline: TColorLabel;
    dbeGeraLinkPgtoOnline: TDBEditFocus;
    pnlEspFat: TPanel;
    dbcEspFat: TComboBoxFocus;
    Label29: TLabel;
    lblTravaOrcForaIntervalo: TLabel;
    dbcTrOrFi: TComboBoxFocus;
    lblTravaOrParcForaIntervalo: TLabel;
    dbcTrOrPf: TComboBoxFocus;
    lblGeraCobrancaPagarMe: TLabel;
    dbeGeraCobrancaPagarMe: TDBEditFocus;
    clbGeraCobrancaPagarMe: TColorLabel;
    cllExpTab: TColorLabel;
    dbeExpTab: TDBEditFocus;
    lblExpTab: TLabel;
    gpbPagarMe: TGroupBox;
    chkPermiteBoleto: TCheckBox;
    chkPermiteCartao: TCheckBox;
    Label26: TLabel;
    Label32: TLabel;
    cmbLimiteParcelas: TComboBoxFocus;
    cmbQtdeParcelasSemJuros: TComboBoxFocus;
    Label33: TLabel;
    Label34: TLabel;
    edtPmeJct: TEditFocus;
    edtPmeDVc: TEditFocus;
    lblInfoPagarMe: TLabel;
    lblMoDiVn: TLabel;
    cbbMoDiVn: TComboBoxFocus;
    rdgEmiBol: TDBRadioGroup;
    btnDescMaxGlobal: TBitBtnLocked;
    lblPetrcd: TLabel;
    dbePetRcd: TDBEditFocus;
    clbPetrcd: TColorLabel;
    btnHeranca: TBitBtnLocked;
    pnlLinkPgtoCielo: TPanel;
    clbGeraLinkPgtoCielo: TColorLabel;
    dbeGeraLinkPgtoCielo: TDBEditFocus;
    lbGeraLinkPgtoCielo: TLabel;
    LblExpApp: TLabel;
    dbeExpApp: TDBEditFocus;
    clbExpApp: TColorLabel;
    pnlLinkPgtoCredPay: TPanel;
    clbGeraLinkPgtoCredPay: TColorLabel;
    lbGeraLinkPgtoCredPay: TLabel;
    dbeGeraLinkPgtoCredPay: TDBEditFocus;
    pnlLinkPgtoIpag: TPanel;
    clbGeraLinkPgtoIpag: TColorLabel;
    lbGeraLinkPgtoIpag: TLabel;
    dbeGeraLinkPgtoIpag: TDBEditFocus;

    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbeCodPorKeyPress(Sender: TObject; var Key: Char);
    function dbeCodPorChamaCadastro(Key: Word): String;
    procedure dbeCodPorExit(Sender: TObject);
    procedure dbeCodFpgKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodFpgExit(Sender: TObject);
    procedure dbcTipForChange(Sender: TObject);
    procedure dbcUsaDFxClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeDesPflKeyPress(Sender: TObject; var Key: Char);
    procedure dtsCadCndDataChange(Sender: TObject; Field: TField);
    procedure dtsCadCndStateChange(Sender: TObject);
    procedure btnDescMaxClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure clbEmpCndClickCheck(Sender: TObject);
    procedure rdgMCobDaEnter(Sender: TObject);
    procedure btnLimiteClick(Sender: TObject);
    procedure cbbDiaFixChange(Sender: TObject);
    procedure dbeGeraCobrancaYapayExit(Sender: TObject);
    procedure dbeGeraCobrancaYapayEnter(Sender: TObject);
    procedure cbYapTraClick(Sender: TObject);
    procedure dbeGeraCobrancaYapayChange(Sender: TObject);
    procedure dbeGeraLinkPgtoOnlineChange(Sender: TObject);
    procedure dbeGeraCobrancaPagarMeChange(Sender: TObject);
    procedure cmbLimiteParcelasSelect(Sender: TObject);
    procedure chkPermiteBoletoClick(Sender: TObject);
    procedure chkPermiteCartaoClick(Sender: TObject);
    procedure rdgEmiBolChange(Sender: TObject);
    procedure btnDescMaxGlobalClick(Sender: TObject);
    procedure btnHerancaClick(Sender: TObject);
    procedure dbeGeraLinkPgtoCieloChange(Sender: TObject);
    procedure dbeGeraLinkPgtoCrePayChange(Sender: TObject);
    procedure dbeGeraLinkPgtoIpagChange(Sender: TObject);

  private
    { Private declarations }
    qryConPor: TUniQuery;
    strVrfTpr: string;
    blnTabPre: Boolean;
    blnPermitirEmissaoFF : Boolean;
    strValorOriginalGeracobrancaYapay: string;

    procedure pCarregaDadosAdicionais;
    procedure pCarregaPortador;
    procedure pExibirMaximoParcelasCartao;
    procedure pLimpaEdits;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pMostraDiaFixo;
    procedure pMostraLimite;
    procedure pAfterScroll(DataSet: TDataSet);
    function fGetEmpSelecao: String;
    procedure pAtualizaCombos(DataSet: TDataSet);
    function fVaiParaProximaAba(Sender: TWinControl): Boolean;
    procedure pMarcarDesmarcarEmpresas(blnMarcar: Boolean);
    procedure pTrataCampoQtdMax;
    function fInformaTabelasSelecionadas: string;
    function fTabelasConfiguradas(strTabelas, strCfgTabelas: string; var strTabelasRetorno: string): Boolean;
    function fValidaLinkPgtoCheckout : Boolean;
    function fValidaLinkPgtoBoletoFaturamento : Boolean;
    procedure pCarregaModalidadeFormaPagamento;
    function fValidaHierarquia(DataSet: TDataSet) : Boolean;
    function fTemLinkPagamentoSiTefLigadaQualquerEmpresa: Boolean;
    function fTemLinkPagamentoCieloLigadaQualquerEmpresa: Boolean;
    function fTemLinkPagamentoHabilitadoNestaCondicao: Boolean;
    function fTemLinkPagamentoCredPayLigadaQualquerEmpresa: Boolean;
    function fTemLinkPagamentoIpagLigadaQualquerEmpresa: Boolean;

    procedure pLimparInformacoesPagarMe;
    procedure pCarregarTipoFaturamento;
    procedure pSetFocusLinkPgto;
    function fPossuiVinculoIntegracao(ADeletando: Boolean = False): Boolean;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    procedure pFocarNaAbaCriticada(Sender: TWinControl);
  public
    { Public declarations }
  end;

const

  ARR_TIPCND: Array[0..1] Of Array[0..1] of String = (('A VISTA', 'V'),
                                                      ('A PRAZO', 'P'));

  ARR_TRAVA: Array[0..2] Of Array[0..1] of String = (('NÃO AVISA', 'N'),
                                                     ('AVISA'    , 'A'),
                                                     ('TRAVA'    , 'T'));

const
  ARR_ALTPRE: Array[0..3] Of Array[0..1] Of String = (('NÃO.',                                      'N'),
                                                      ('SIM, SOMENTE PARA CIMA DO PREÇO SUGERIDO.', 'C'),
                                                      ('SIM, SEMPRE.',                              'S'),
                                                      ('SIM, SOMENTE PARA PRODUTOS EM PROMOÇÃO.',   'P'));

  ARR_TRAMIN: Array[0..1] Of Array[0..1] of String = (('TRAVAR COM OPÇÃO DE LIBERAR COM SENHA', 'S'),
                                                      ('TRAVAR SEM OPÇÃO DE LIBERAR COM SENHA', 'N'));


implementation

uses  SysUtils, Variants, Forms, StrUtils, untPai, untFuncoes, untFuncoesSimples,
  untPesqAux, untFuncIns, untConsultas, untCadCondLinGru, untTypesSistema,
  untMensagemExplicativa, untConstantes, Yapay.Api.Facade,
  untCadCondLinGruGlobal, untValidaHierarquia,
  untClassesComumLinkPagamentoCitel;

{$R *.dfm}

procedure TfrmCadCondicoes.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pLimpaEdits;
  pMostraDiaFixo;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodigo, dbeDescri, False)
  Else
    pHabilitaCodigo(dbeCodigo, dbeCodigo, True);

  If (blnTabPre) and (not fEmptyStr(fCfgSis('TABPAD'))) then
    clbPreTab.Checked[fCfgSis('TABPAD') - 1] := True;

  dbeJurPro.Field.AsString  := 'S';
  dbeInfAna.Field.AsString  := 'S';
  dbeImpFat.Field.AsString  := 'N';
  dbePerDPo.Field.AsFloat   := 0.0;
  dbeQtdDAV.Field.AsInteger := 0;
  dbePeDeAc.Field.AsFloat   := 0.0;
  dbePerVen.Field.AsFloat   := 0.0;
  dbeAbaDes.Field.AsString  := 'N';
  dbeAbDeCc.Field.AsString  := 'N';
  dbePerCom.Field.AsFloat   := 0.0;
  dbeSenTra.Field.AsString  := 'N';
  dbeVrDeAc.Field.AsFloat   := 0.0;
  dbeVrDaUv.Field.AsFloat   := 0.0;
  rdgMCobDa.Field.AsString  := '1';
  dbeExpB2B.Field.AsString  := 'S';
  dbeExpFSo.Field.AsString  := 'S';
  dbeQtdMax.Field.AsInteger := 0;
  dbeRcx_F3.Field.AsString  := 'S';
  dbcDiaCor.Field.AsString  := 'N';
  dbeCondEsp.Field.AsString := 'N';
  dbeExpTab.Field.AsString  := 'S';

  if pnlLinkPgtoOnline.Visible then
    dbeGeraLinkPgtoOnline.Field.AsString := 'N';

  if pnlLinkPgtoCielo.Visible then
    dbeGeraLinkPgtoCielo.Field.AsString := 'N';

  if pnlLinkPgtoCredPay.Visible then
    dbeGeraLinkPgtoCredPay.Field.AsString := 'N';

  if pnlLinkPgtoIpag.Visible then
    dbeGeraLinkPgtoIpag.Field.AsString := 'N';

  dbeUsaDeps.Field.AsString         := 'N';
  dbeRecebimentoPix.Field.AsString  := 'N';
  dbeRetira.Field.AsString          := 'S';
  dbeEntregaImediata.Field.AsString := 'S';
  dbeEntregaFutura.Field.AsString   := 'S';

  dbeTravaCliCompra.Field.AsString := 'S';

  If tbsPerfil.TabVisible Then
  Begin
    dbeImpBol.Field.AsString  := 'S';
    dbeSenCnd.Field.AsString  := 'S';
    dbeLimCre.Field.AsString  := 'S';
    dbeTrTtVe.Field.AsString  := 'S';
    dbeLbPdOb.Field.AsString  := 'N';
    dbeMarMin.Field.AsInteger := 0;
    dbeMarMax.Field.AsInteger := 100;
    dbeFatMin.Field.AsFloat   := 0;
    dbeFatMax.Field.AsFloat   := 9999999.99;
    dbeParMin.Field.AsFloat   := 0;
    dbeParMax.Field.AsFloat   := 9999999.99;
    dbeMaxCar.Field.AsInteger := 0;
    dbcTrClCr.Enabled         := True;
    dbcTrClCr.ItemIndex       := 0;
    dbcTrOrCr.Enabled         := True;
    dbcTrOrCr.ItemIndex       := 0;
    dbcAltPre.Enabled         := True;
    dbcAltPre.ItemIndex       := 2;
    dbcTrClCb.Enabled         := True;
    dbcTrClCb.ItemIndex       := 0;
    dbcTrOrCb.Enabled         := True;
    dbcTrOrCb.ItemIndex       := 0;
    dbcTraFat.Enabled         := True;
    dbcTraFat.ItemIndex       := 1;
    dbcTraMar.Enabled         := True;
    dbcTraMar.ItemIndex       := 1;
    dbcTraPar.Enabled         := True;
    dbcTraPar.ItemIndex       := 1;
    dbcEspFat.ItemIndex       := 0;
    dbcTrOrFi.Enabled         := True;
    dbcTrOrFi.ItemIndex       := Integer(tpTrava);
    dbcTrOrPf.Enabled         := True;
    dbcTrOrPf.ItemIndex       := Integer(tpTrava);
    dbePetRcd.Field.AsString  := 'N';
  End;

  chkTpFtDaA.Checked := True;
  chkTpFtDaB.Checked := blnPermitirEmissaoFF;
  chkTpFtDaC.Checked := True;
  chkTpFtDaD.Checked := True;

  cbbDiaFix.Enabled  := True;
  spnLimite.Enabled  := True;
  dbcTipCnd.Enabled  := True;
  clbEmpCnd.Enabled  := True;
  dbcDiaCor.Enabled  := True;
  dbeCondEsp.Enabled := dbeCondEsp.Visible;

  dbcTipCnd.ItemIndex := 0;

  If (qryTabela.State = dsInsert) Then
  Begin
    pCarregaDadosAdicionais;
    pnlSelEmp.Visible := True;
    pMarcarDesmarcarEmpresas(True);
  End;

  If Not dbeAbaDes.Visible Then
    dbeAbaDes.Field.AsString := 'N';

  If Not dbeAbDeCc.Visible Then
    dbeAbDeCc.Field.AsString := 'N';

  dbeGeraCobrancaYapay.Field.AsString := Nao.ToFlag;
  cbYapTra.Field.AsString := Sim.ToFlag;
  cbYapDis.Clear;
  edtYapPar.Field.clear;

  rdgEmiBol.Field.AsString := '2';

  dbeGeraCobrancaPagarMe.Field.AsString := Nao.ToFlag;
  pLimparInformacoesPagarMe;
end;

procedure TfrmCadCondicoes.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pnlSelEmp.Visible := True;
  pHabilitaCodigo(dbeCodigo, dbeDescri, False);
  pMostraDiaFixo;
  cbbDiaFix.Enabled := True;
  spnLimite.Enabled := True;
  dbcTipCnd.Enabled := True;
  dbcTrClCr.Enabled := True;
  dbcTrOrCr.Enabled := True;
  dbcAltPre.Enabled := True;
  dbcTipFor.Enabled := True;
  clbEmpCnd.Enabled := True;
  dbcTrClCb.Enabled := True;
  dbcTrOrCb.Enabled := True;
  dbcDiaCor.Enabled := True;
  dbeCondEsp.Enabled := dbeCondEsp.Visible;
  dbcTraFat.Enabled := True;
  dbcTraMar.Enabled := True;
  dbcTraPar.Enabled := True;
  dbcTrOrFi.Enabled := True;
  dbcTrOrPf.Enabled := True;

  pCarregaDadosAdicionais;
  pTrataCampoQtdMax();
end;

procedure TfrmCadCondicoes.FormCreate(Sender: TObject);
  Var
    i: Integer;
    tpTrava: TTipoTrava;
begin
  inherited;
  intPaginasAtivas := 2;

  gpbFpgNvl.Visible    := (fCfgSis('TFPF11', varBoolean) Or fCfgSis('SFPGPD', varBoolean));


  strNomeTabela        := 'CADCND';
  strNomeCampo         := 'CND_CODIGO';
  qryTabela            := fCriarQuery('SELECT * FROM CADCND', Self);
  qryTabela.AfterOpen  := pAfterOpen;
  qryTabela.AfterScroll:= pAfterScroll;
  dtsCadCnd.DataSet    := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodigo;

  If (Not fCfgSis('USAFPG', varBoolean)) And fEmptyStr(fCfgSis('CODACA')) Then
  Begin
    pnlFormaPagto.Visible := False;
    Height := Height - pnlFormaPagto.Height;
  End;

  If (fCfgSis('OPCCOM') <> 'O') Then
  Begin
    lblPerCom.Visible := False;
    dbePerCom.Visible := False;
    lblPercen.Visible := False;
  End;

  If Not (fCfgSis('DESPON', varBoolean) And (fCfgSis('TDEPON') = '1')) Then
  Begin
    lblPerDPo.Visible := False;
    dbePerDPo.Visible := False;
    lblPercn2.Visible := False;
    lblQtdDAV.Visible := False;
    dbeQtdDAV.Visible := False;
  End;

  If Not fCfgSis('PERPAG', varBoolean) Then
  Begin
    lblPerPerVer.Visible := False;
    lblPerVen.Visible := False;
    dbePerVen.Visible := False;
  End;

  if (fEmptyStr(fCfgSis('PATTAB'))) then
  Begin
    dbeExpFSo.Visible := False;
    lblExpFSo.Visible := False;
    corExpFSo.Visible := False;
  end;

  blnTabPre := fCfgSis('TBPCND', varBoolean);

  {**********************************************}
  {* VERIFICA SE TRABALHA COM PERFIL DE CLIENTE *}
  {*******************************************RV*}
  tbsPerfil.TabVisible := fCfgSis('PFLCLI', varBoolean);
  If tbsPerfil.TabVisible Then
  Begin
    If (fCfgSis('CNDVEN') = 'F') And (fCfgSis('LIBCND') = '1') Then
    Begin
      dbcTraFat.Visible := False;
      dbcTraMar.Visible := False;
    End;
  End;

  If Not tbsPerfil.TabVisible Then
    tbsEmpresas.Caption := '&2 - Empresas Acesso';

  btnDescMax.Visible := fCfgSis('LIGUCN',varBoolean);
  btnDescMaxGlobal.Visible := fCfgSis('LIGUCN',varBoolean);

  dbeLbPdOb.Visible := (fCfgSis('LIBPED', varBoolean) And fCfgSis('LPPDBL', varBoolean));
  lblLbPdOb.Visible := dbeLbPdOb.Visible;
  clbLbPdOb.Visible := dbeLbPdOb.Visible;

  If ((fCfgSis('PEMIFF') = '1') And (Not fCfgSis('PERMFF', varBoolean))) Then
  Begin
    chkTipFatB.Visible := False;
    chkTpFtDaB.Visible := False;
  End;

  cbbDiaFix.Enabled  := False;
  spnLimite.Enabled  := False;
  dbcTipCnd.Enabled  := False;
  dbcTrClCr.Enabled  := False;
  dbcTrOrCr.Enabled  := False;
  dbcTrClCb.Enabled  := False;
  dbcTrOrCb.Enabled  := False;
  dbcAltPre.Enabled  := False;
  dbcTipFor.Enabled  := False;
  clbEmpCnd.Enabled  := False;
  dbcDiaCor.Enabled  := False;
  dbeCondEsp.Enabled := False;
  dbcTraFat.Enabled  := False;
  dbcTraMar.Enabled  := False;
  dbcTraPar.Enabled  := False;
  dbcTrOrFi.Enabled  := False;
  dbcTrOrPf.Enabled  := False;

  dbcTrClCr.Items.Clear;
  dbcTrOrCr.Items.Clear;
  dbcTrClCb.Items.Clear;
  dbcTrOrCb.Items.Clear;
  dbcAltPre.Items.Clear;
  dbcTipCnd.Items.Clear;
  dbcTraFat.Items.Clear;
  dbcTraMar.Items.Clear;
  dbcTraPar.Items.Clear;
  dbcTrOrFi.Items.Clear;
  dbcTrOrPf.Items.Clear;

  For i := 0 To Length(ARR_TRAVA) -1 Do
  begin
    dbcTrClCr.Items.Add(ARR_TRAVA[i][0]);
    dbcTrOrCr.Items.Add(ARR_TRAVA[i][0]);
    dbcTrClCb.Items.Add(ARR_TRAVA[i][0]);
    dbcTrOrCb.Items.Add(ARR_TRAVA[i][0]);
  end;

  For i := 0 To Length(ARR_ALTPRE) -1 Do
    dbcAltPre.Items.Add(ARR_ALTPRE[i][0]);

  For i := 0 To Length(ARR_TIPCND) -1 Do
    dbcTipCnd.Items.Add(ARR_TIPCND[i][0]);

  For i := 0 To Length(ARR_TRAMIN) -1 Do
    dbcTraFat.Items.Add(ARR_TRAMIN[i][0]);

  For i := 0 To Length(ARR_TRAMIN) -1 Do
    dbcTraMar.Items.Add(ARR_TRAMIN[i][0]);

  For i := 0 To Length(ARR_TRAMIN) -1 Do
    dbcTraPar.Items.Add(ARR_TRAMIN[i][0]);

  For tpTrava:= Low( TTipoTrava ) To High( TTipoTrava ) Do
  Begin
    dbcTrOrFi.Items.Add(arrDescTrava[tpTrava]);
    dbcTrOrPf.Items.Add(arrDescTrava[tpTrava]);
  End;

  blnPermitirEmissaoFF := fPermiteEmissaoEspecie('FF');

  If (chkTpFtDaB.Visible) Then
    chkTpFtDaB.Visible := blnPermitirEmissaoFF;

  If (chkTipFatB.Visible) Then
    chkTipFatB.Visible := blnPermitirEmissaoFF;

  if (fCfgSis('PRAMIN') = 'N') then
  Begin
    dbePraMin.Visible := False;
    lblPraMin.Visible := False;
    corPraMin.Visible := False;
  end;

  {Destino}
  gpbDestino.Visible := fCfgSis('RETENT',varBoolean);

  lblGeraCobrancaYapay.Visible := (fCfgSis('YAPHAB',varBoolean));
  dbeGeraCobrancaYapay.Visible := lblGeraCobrancaYapay.Visible;
  clbGeraCobrancaYapay.Visible := lblGeraCobrancaYapay.Visible;
  gpbConfiguracoesYapay.Visible := lblGeraCobrancaYapay.Visible;
  cbYapTra.Visible := lblGeraCobrancaYapay.Visible;

  if (fCfgSis('YAPHAB',varBoolean)) then
    TYapayFacade.TcxCheckComboBox(cbYapDis).PopulaformasPagamento;

  lblCndEsp.Visible  := fCfgSis('CNDPES',varBoolean);
  dbeCondEsp.Visible := lblCndEsp.Visible;
  clbCndEsp.Visible  := lblCndEsp.Visible;

  pnlLinkPgtoOnline.Visible := fTemLinkPagamentoSiTefLigadaQualquerEmpresa ;
  pnlLinkPgtoCielo.Visible :=  fTemLinkPagamentoCieloLigadaQualquerEmpresa ;
  pnlLinkPgtoCredPay.Visible := fTemLinkPagamentoCredPayLigadaQualquerEmpresa ;
  pnlLinkPgtoIpag.Visible := fTemLinkPagamentoIpagLigadaQualquerEmpresa ;

  pnlEspFat.Visible := fCfgSis('UTIDTF', varBoolean);

  lblGeraCobrancaPagarMe.Visible := (fCfgSis('PMEHAB',varBoolean));
  dbeGeraCobrancaPagarMe.Visible := lblGeraCobrancaPagarMe.Visible;
  clbGeraCobrancaPagarMe.Visible := lblGeraCobrancaPagarMe.Visible;
  gpbPagarMe.Visible             := False;
  rdgEmiBol.Visible              := ((fCfgSis('BOLADT', varBoolean)) And (fCfgSis('SUGBOL', varString) = '3'));

  dbePetrcd.Enabled := (fCfgSis('PFLCLI', varString) = 'S') And
                       (fCfgSis('MPRORI', varString) = 'D') And
                       (fCfgSis('CNDVEN', varString) = 'I');
  dbePetrcd.Visible := dbePetrcd.Enabled;
  lblPetrcd.Visible := dbePetrcd.Enabled;
  clbPetrcd.Visible := dbePetrcd.Enabled;

  pLimparInformacoesPagarMe;
end;

procedure TfrmCadCondicoes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_RETURN) And Assigned(ActiveControl) And (ActiveControl Is TRadioButton) Then
  Begin
    If Not fVaiParaProximaAba(ActiveControl) Then
      Self.SelectNext(ActiveControl, True, True);
  End
  Else
  If (pgcDados.ActivePage = tbsEmpresas) And (pnlSelEmp.Visible) Then
  Begin
    Case Key Of
      VK_F8: pMarcarDesmarcarEmpresas(True);
      VK_F9: pMarcarDesmarcarEmpresas(False);
      VK_RETURN: SelectNext(ActiveControl, True, True);
    End;
  End;
end;

function TfrmCadCondicoes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  strTabelasCfg,
  strTabSelecionadas: string;
  intCont: integer;
begin

  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA  O CÓDIGO                      *}
    {**************************************MA*}
    If (Sender = dbeCodigo) Then
    Begin
      If (fEmptyStr(dbeCodigo.Text)) And (dbeCodigo.Enabled) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Código deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
        Begin
          If qryTabela.State in [dsInsert, dsEdit] Then
          Begin
            If fEmptyStr(dbeRecebimentoPix.Text) Then
              dbeRecebimentoPix.Text := 'N';
          End;
        End
        Else
        Begin
          pCarregaPortador;
        End;
      End;
    End

    {*****************************************}
    {* VALIDA  A DESCRICAO                   *}
    {**************************************MA*}
    Else If (Sender = dbeDescri) Then
    Begin
      If fEmptyStr(dbeDescri.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Descrição deve ser preenchida!', ['&O k']);
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA  O FORA                        *}
    {**************************************MA*}
    Else If (Sender = dbcTipFor) Then
    Begin
      If fEmptyStr(dbcTipFor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Tipo Fora deve ser selecionado!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = dbeExpApp) And (dbeExpApp.Visible) Then
    Begin
      If (Pos(dbeExpApp.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Exportar para o APP Sales? deve ser preenchido com S ou N!', ['&OK']);
        Result := False;
      End;
    End

    {************************************}
    {* VALIDA TRAVA CLIENTE SEM CRÉDITO *}
    {*********************************MM*}
    Else If (Sender = dbcTrClCr) Then
    Begin
      If fCfgSis('PFLCLI',varBoolean) And fEmptyStr(dbcTrClCr.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Trava de clientes sem consulta de crédito deve ser selecionada!', ['&O k']);
        Result := False;
      End;
    End
    Else If (Sender = dbcTrOrCr) Then
    Begin
      If fCfgSis('PFLCLI',varBoolean) And fEmptyStr(dbcTrOrCr.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Trava de clientes sem consulta de crédito para Orçamentos deve ser selecionada!', ['&O k']);
        Result := False;
      End;
    End

    Else if (Sender = dbcTrClCb) then
    Begin
      If fCfgSis('PFLCLI', varBoolean) And (fEmptyStr(dbcTrClCb.Text)) then
      Begin
        fMensagem('ATENÇÃO!', 'A Trava de clientes sem consulta de dados de cobrança deve ser selecionada!', ['&O k']);
        Result := False;
      End;
    End
    Else if (Sender = dbcTrOrCb) then
    Begin
      If fCfgSis('PFLCLI', varBoolean) And (fEmptyStr(dbcTrOrCb.Text)) then
      Begin
        fMensagem('ATENÇÃO!', 'A Trava de clientes sem consulta de dados de cobrança para Orçamentos deve ser selecionada!', ['&O k']);
        Result := False;
      End;
    End

    {**********************************************************}
    {* VALIDA "CONDIÇÃO ESPECIAL"*}
    {*******************************************************PZ*}
    Else If (Sender = dbeCondEsp) and (dbeCondEsp.Visible) Then
    Begin
      If (Pos(dbeCondEsp.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "Condição de Pagamento Especial?" deve ser preenchido com S ou N!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbcAltPre) And fCfgSis('PFLCLI',varBoolean) And (gpbPerfil.Visible) And (dbcAltPre.Visible) And (dbcAltPre.Enabled) Then
    Begin
      If fEmptyStr(dbcAltPre.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Permite Alterar Preço do Produto no Faturamento deve ser selecionado!', ['&OK']);
        Result := False;
      End;
    End

    {***************************************}
    {* VALIDA "INTEGRAR COM O SISTEMA DEPS"*}
    {************************************AJ*}
    Else If (Sender = dbeUsaDeps) And (dbeUsaDeps.Visible) Then
    Begin
      If (Pos(dbeUsaDeps.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Integrar com o Sistema DEPS deve ser preenchido com S ou N!', ['&OK']);
        Result := False;
      End;
    End

    {******************************}
    {* VALIDA RECEBIMENTO POR PIX *}
    {***************************AJ*}
    Else If (Sender = dbeRecebimentoPix) And (dbeRecebimentoPix.Visible) Then
    Begin
      If Not MatchStr(dbeRecebimentoPix.Text, ['S', 'N']) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Ativar o recebimento por meio do Pix deve ser preenchido com S ou N!', ['&OK']);
        Result := False;
      End
      Else If dbeGeraCobrancaYapay.Text = 'S' Then
      Begin
        If dbeRecebimentoPix.Text = 'S' Then
        Begin
          fMensagem('ATENÇÃO!', 'Só poderá ser ativado o recebimento por meio do Pix em condições de pagamento que não recebem por Yapay!', ['&OK']);
          Result := False;
        End;
      End
      Else If dbeRecebimentoPix.Text = 'S' Then
      Begin
        If dbeCodFpg.Text <> '012' Then
        Begin
          fMensagem('ATENÇÃO!', 'Só poderá ser ativado o recebimento por meio do Pix em utilizando a forma de pagamento 012 (Ordem de Pagamento)!', ['&OK']);
          Result := False;
        End
        Else If dbcTipCnd.ItemIndex <> 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'Só poderá ser ativado o recebimento por meio do Pix em condições de pagamento a vista!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = dbeRcx_F3) And (dbeRcx_F3.Visible) Then
    Begin
      If (Pos(dbeRcx_F3.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "' + lblRcx_F3.Caption + '" deve ser preenchido com S ou N!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = dbeExpTab) Then
    Begin
      If (Pos(dbeExpTab.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "' + lblExpTab.Caption + '" deve ser preenchido com S ou N!', ['&OK']);
        Result := False;
      End;
    End

    Else If (pnlLinkPgtoCielo.Visible) and (Sender = dbeGeraLinkPgtoCielo) Then
    Begin
      If (Pos(dbeGeraLinkPgtoCielo.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "' + lbGeraLinkPgtoCielo.Caption + '" deve ser preenchido com S ou N!', ['&OK']);
        Result := False;
      End;
    End

    Else If (pnlLinkPgtoCredPay.Visible) and (Sender = dbeGeraLinkPgtoCredPay) Then
    Begin
      If (Pos(dbeGeraLinkPgtoCredPay.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "' + lbGeraLinkPgtoCredPay.Caption + '" deve ser preenchido com S ou N!', ['&OK']);
        Result := False;
      End;
    End

    Else If (pnlLinkPgtoIpag.Visible) and (Sender = dbeGeraLinkPgtoIpag) Then
    Begin
      If (Pos(dbeGeraLinkPgtoIpag.Text, 'SN') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo "' + lbGeraLinkPgtoIpag.Caption + '" deve ser preenchido com S ou N!', ['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = rdgEmiBol) And (rdgEmiBol.Visible) Then
    Begin
      If (rdgEmiBol.ItemIndex = 0) And (dbeCodFpg.Text <> '008') Then
      Begin
        fMensagem('ATENÇÃO!', 'Só é permitido usar a sugestão da emissão de boletos na forma de pagamento 008!', ['&Ok']);
        rdgEmiBol.ItemIndex := 1;
        Result := False;
      End;
    End

    {*****************************************}
    {* VALIDA  A CONDICAO DE PAGAMENTO       *}
    {**************************************MA*}
    Else If (Sender = dbeCndPag) And dbeCndPag.Enabled Then
    Begin
      If fEmptyStr(fTiraCaracEspeciais(dbeCndPag.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A condição de pagamento deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin

        If Not fValidaCndPag(dbeCndPag.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa condição de pagamento ' + fFormataCondPag(dbeCndPag.Text) + ' ' +
                                'não é valida!' + #13#10 +
                                'Verifique se informou todas as parcelas e se as mesmas estão em ordem progressiva, ' +
                                'exemplos válidos: (01)000, (01)030, (03)030.060.090', ['&O k']);
          Result := False;
        End
        Else If blnBuscaPorChave Then
        Begin
          If (fFormataCondPag(dbeCndPag.Text) = '(01)000') Then
            dbcTipCnd.ItemIndex := 0
          Else
            dbcTipCnd.ItemIndex := 1;
        End;

      End;

      pExibirMaximoParcelasCartao;
    End

    {*****************************************}
    {* VALIDA A TABELA DE PRECO              *}
    {**************************************MA*}
    Else If (Sender = clbPreTab) And clbPreTab.Visible Then
    Begin
      for intCont := 0 to 6 do
        if Not (clbPreTab.ItemEnabled[intCont]) then
          clbPreTab.Checked[intCont] := False;

      strTabSelecionadas := fInformaTabelasSelecionadas;
      If fEmptyStr(strTabSelecionadas) Then
      Begin
        If (blnTabPre) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Tabela de Preço deve ser preenchida!', ['&Ok']);
          Result := False;
        End;
      End
      else
      Begin
        If (not fTabelasConfiguradas(strTabSelecionadas, strVrfTpr, strTabelasCfg)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Tabela de Preço deve ser ' + strTabelasCfg + '!', ['&Ok']);
          Result := False;
        End;
      end;

    End

    Else If (Sender = dbeQtdPar) And dbeQtdPar.Enabled And pnlDiaFix.Visible Then
    Begin
      If Not fValidaEscala(dbeQtdPar.Text, 1, 24) Then
      Begin
        fMensagem('','Informe uma quantidade entre 1 e 24!', ['&Ok']);
        Result := false;
      End;

      {Validação - Se apenas uma parcela, seleciona sem entrada automaticamente!}
      If Not fEmptyStr(dbeQtdPar.Text) Then
      begin

        If StrToInt(dbeQtdPar.Text) = 1 Then
        Begin
          dbcSemEnt.Field.AsString := 'S';
          pMostraLimite;
        End;

      end;

    End

    {*****************************************}
    {* VALIDA O PORTADOR                     *}
    {**************************************MA*}
    Else If (Sender = dbeCodPor) Then
    Begin

      If Not fEmptyStr(dbeCodPor.Text) Then
      Begin
        pCarregaPortador;
        If qryConPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!', ['&O k']);
          Result := False;
        End

        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(qryConPor.FieldByName('POR_CODPOR').AsString) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End;
      End;

      pExibirMaximoParcelasCartao;

    End

    {*****************************************}
    {* VALIDA A FORMA DE PAGAMENTO           *}
    {**************************************JC*}
    Else If (Sender = dbeCodFpg) Then
    Begin
      If Not fEmptyStr(dbeCodFpg.Text) Then
      Begin
        edtDesFpg.Text := fRetDesFpg(dbeCodFpg.Text);
        If fEmptyStr(edtDesFpg.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa forma de pagamento não está cadastrado!', ['&O k']);
          Result := False;
        End
        else if fPossuiVinculoIntegracao then
        begin
          fMensagem('ATENÇÃO!', 'Esta condição de pagamento está vinculada com integrações Citel e será permitido somente formas de pagamento 007, 008, 009 ou 013!', ['&O k']);
          Result := False;
        end;
      End;
    End

    {*******************************************}
    {* VALIDA O PERCENTUAL DESCONTO PONTUALID. *}
    {****************************************IV*}
    Else If (Sender = dbePerDPo) And (dbePerDPo.Visible) Then
    Begin
      If fEmptyStr(dbePerDPo.Text) Then
      Begin
        dbePerDPo.Field.AsFloat := 0.0;
      End
      Else If ( Not ( fStrToFloat(dbePerDPo.Text) >= 0 ) ) Then
      Begin
        fMensagem('', 'O Percentual de Desconto Pontualidade deve ser maior ou igual a zero !', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbePerVen) And (dbePerVen.Visible) Then
    Begin
      If fEmptyStr(dbePerVen.Text) Then
      Begin
        dbePerVen.Field.AsFloat := 0.0;
      End
      Else If ((fStrToFloat(dbePerVen.Text) < 0) Or (fStrToFloat(dbePerVen.Text) > 100)) Then
      Begin
        fMensagem('', 'O Percentual de venda da primeira parcela de ve ser entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End

    {*******************************************}
    {* VALIDA A QTD DIAS ANTECIP P/ DESC.PONT. *}
    {****************************************IV*}
    Else If (Sender = dbeQtdDAV) And (dbeQtdDAV.Visible) Then
    Begin
      If fEmptyStr(dbeQtdDAV.Text) Then
      Begin
        dbeQtdDAV.Field.AsInteger := 0;
      End
      Else If ( Not ( StrToInt(dbeQtdDAV.Text) >= 0 ) ) Then
      Begin
        fMensagem('', 'A Qtde de Dias de Antecipação deve ser maior ou igual a zero !', ['&Ok']);
        Result := False;
      End;

      If Result Then
        fVaiParaProximaAba(Sender);
    End

    {*******************************************}
    {* VALIDA O PRAZO MÉDIO                    *}
    {****************************************MV*}
    Else If (Sender = dbePrzMed) Then
    Begin
      If fEmptyStr(dbePrzMed.Text) Then
      Begin
        dbePrzMed.Field.AsFloat := 0.0;
      End
      Else If ( Not ( fStrToFloat(dbePrzMed.Text) >= 0 ) ) Then
      Begin
        fMensagem('', 'O Prazo Médio deve ser maior ou igual a zero !', ['&Ok']);
        Result := False;
      End;
    End

    {*******************************************}
    {* VALIDA A QTD MÁXIMA                     *}
    {****************************************FS*}
    Else If (Sender = dbeQtdMax) Then
    Begin
      If fEmptyStr(dbeQtdMax.Text) Then
        dbeQtdMax.Field.AsInteger := 0
      Else If (Not fValidaEscala(dbeQtdMax.Text, 0, 12)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Qtd. Máxima de Parcelas deve estar entre 0 e 12!', ['&Ok']);
        Result := False;
      End;
    End

    {*******************************************}
    {* VALIDA O VALOR MINIMO                   *}
    {****************************************MV*}
    Else If (Sender = dbeValMin) Then
    Begin
      If fEmptyStr(dbeValMin.Text) Then
      Begin
        dbeValMin.Field.AsFloat := 0.0;
      End
      Else If ( Not ( fStrToFloat(dbeValMin.Text) >= 0 ) ) Then
      Begin
        fMensagem('', 'O valor mínimo deve ser maior ou igual a zero !', ['&Ok']);
        Result := False;
      End;
    End

    {*******************************************}
    {* VALIDA FATOR NA ACACIA                  *}
    {****************************************MV*}
    Else If (Sender = dbeFatAca) Then
    Begin
      If fEmptyStr(dbeFatAca.Text) Then
      Begin
        dbeFatAca.Field.AsFloat := 0.0;
      End
      Else If (Not fValidaEscala(dbeFatAca.Text, 0, 99.9999)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Fator da Exportação para Tablet deve estar entre 0 e 99,9999!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeMaxCar) Then
    Begin
      If fEmptyStr(dbeMaxCar.Text) Or (Not dbeMaxCar.Visible) Then
      Begin
        dbeMaxCar.Field.AsFloat := 0.0;
      End
      Else If (Not fValidaEscala(dbeMaxCar.Text, 0, 24)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade máxima de parcelas para cartões deve estar entre 0 e 24!', ['&Ok']);
        Result := False;
      End;
    End

    {*******************************************}
    {* VALIDA DESCONTO MAXIMO                  *}
    {****************************************MV*}
    Else If (Sender = dbeDesMax) Then
    Begin
      If fEmptyStr(dbeDesMax.Text) Then
      Begin
        dbeDesMax.Field.AsFloat := 0.0;
      End
      Else If (Not fValidaEscala(dbeDesMax.Text, 0, 100)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O desconto máximo do Vendedor Júnior deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeDesMaxM) Then
    Begin
      If fEmptyStr(dbeDesMaxM.Text) Then
      Begin
        dbeDesMaxM.Field.AsFloat := 0.0;
      End
      Else If (Not fValidaEscala(dbeDesMaxM.Text, 0, 100)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O desconto máximo do Vendedor Master deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End

    {*******************************************}
    {* VALIDA DESCONTO MAXIMO                  *}
    {****************************************MV*}
    Else If (Sender = dbeDesMGe) Then
    Begin
      If fEmptyStr(dbeDesMGe.Text) Then
      Begin
        dbeDesMGe.Field.AsFloat := 0.0;
      End
      Else If (Not fValidaEscala(dbeDesMGe.Text, 0, 100)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O desconto máximo do Gerente Júnior deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeDesMGeM) Then
    Begin
      If fEmptyStr(dbeDesMGeM.Text) Then
      Begin
        dbeDesMGeM.Field.AsFloat := 0.0;
      End
      Else If (Not fValidaEscala(dbeDesMGeM.Text, 0, 100)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O desconto máximo do Gerente Master deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeDesMSu) Then
    Begin
      If fEmptyStr(dbeDesMSu.Text) Then
      Begin
        dbeDesMSu.Field.AsFloat := 0.0;
      End
      Else If (Not fValidaEscala(dbeDesMSu.Text, 0, 100)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O desconto máximo do Sub-Gerente Júnior deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbeDesMSuM) Then
    Begin
      If fEmptyStr(dbeDesMSuM.Text) Then
      Begin
        dbeDesMSuM.Field.AsFloat := 0.0;
      End
      Else If (Not fValidaEscala(dbeDesMSuM.Text, 0, 100)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O desconto máximo do Sub-Gerente Master deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End

    {*******************************************}
    {* VALIDA TAXA DE JUROS                    *}
    {****************************************AA*}
    Else If (Sender = dbeTaxJur) Then
    Begin
      If fEmptyStr(dbeTaxJur.Text) Then
      Begin
        dbeTaxJur.Field.AsFloat := 0.0;
      End
      Else If (Not fValidaEscala(dbeTaxJur.Text, 0, 100)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A taxa de juros deve estar entre 0 e 100!', ['&Ok']);
        Result := False;
      End;
    End

    {*******************************************}
    {* VALIDA "ABATER DESCONTO AUTOMATICAMENTE"*}
    {****************************************MV*}
    Else If (Sender = dbeAbaDes) And dbeAbaDes.Visible Then
    Begin
      If (Pos(dbeAbaDes.Text, 'SN') <= 0) Then
        Result := False;
    End

    {*******************************************}
    {* VALIDA "IMPRIMIR NO FATURAMENTO"        *}
    {****************************************MM*}
    Else If (Sender = dbeImpFat) Then
    Begin
      If (Pos(dbeImpFat.Text, 'SN') <= 0) Then
        Result := False;
    End

    {******************************************************************}
    {* VALIDA "ABATER DESCONTO AUTOMATICAMENTE PARA CARTAO DE CREDITO"*}
    {***************************************************************LU*}
    Else If (Sender = dbeAbDeCc) And dbeAbDeCc.Visible Then
    Begin
      If (Pos(dbeAbDeCc.Text, 'SN') <= 0) Then
        Result := False;
    End

    Else If (Sender = dbeJurPro) Then
    Begin
      If (Pos(dbeJurPro.Text, 'SN') <= 0) Then
        Result := False;
    End

    Else If (Sender = dbeInfAna) Then
    Begin
      If (Pos(dbeInfAna.Text, 'SN') <= 0) Then
        Result := False;

      If Result Then
        fVaiParaProximaAba(Sender);
    End

    Else If (Sender = dbeExpB2B) Then
    Begin
      If (Pos(dbeExpB2B.Text, 'SN') <= 0) Then
        Result := False;
    End

    Else If (Sender = dbeGeraCobrancaYapay) and
            (fCfgSis('YAPHAB',varBoolean)) Then
    Begin
      If (Pos(dbeGeraCobrancaYapay.Text, 'SN') <= 0) Then
        Result := False;
    End

    Else If (Sender = cbYapDis) and
            (fCfgSis('YAPHAB',varBoolean)) Then
    Begin
      If (cbYapTra.Checked) and
         (dbeGeraCobrancaYapay.Text = 'S') and
         (TYapayFacade.TcxCheckComboBox(cbYapDis).Value.IsEmpty) Then
      begin
        fMensagem('ATENÇÃO!', 'Nenhuma Forma de Pagamento foi selecionada para envio de cobrança Yapay!', ['&Ok']);
        Result := False;
      end;
    End

    Else If (Sender = edtYapPar) then
    begin
      if StrToIntDef(edtYapPar.Text,0) > 12 then
      Begin
        fMensagem('ATENÇÃO!', 'A quantidade máxima de parcelas da cobrança Yapay não pode ser superior a 12x!', ['&Ok']);
        Result := False;
      End
    end

    {*******************************************}
    {* VALIDA % DE COMISSÃO                    *}
    {****************************************RV*}
    Else If (Sender = dbePerCom) And (dbePerCom.Visible) Then
    Begin
      If fEmptyStr(dbePerCom.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Percentual de Comissão deve ser maior ou igual a 0!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(dbePerCom.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Percentual de Comissão deve ser maior ou igual a 0!', ['&Ok']);
        Result := False;
      End;
    End

    {*******************************************}
    {* VALIDA % DE DESPESA ACESSÓRIA           *}
    {****************************************MV*}
    Else If (Sender = dbePeDeAc) Then
    Begin
      If fEmptyStr(dbePeDeAc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de despesa acessória deve ser maior ou igual a 0!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(dbePeDeAc.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O percentual de despesa acessória deve ser maior ou igual a 0!', ['&Ok']);
        Result := False;
      End;
    End

    Else
    If (Sender = dbeVrDeAc) Then
    Begin
      If fEmptyStr(dbeVrDeAc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor de despesas acessórias por parcela a prazo deve ser maior ou igual a 0!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(dbeVrDeAc.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor de despesas acessórias por parcela a prazo deve ser maior ou igual a 0!', ['&Ok']);
        Result := False;
      End;
    End
    Else If (Sender = dbeVrDaUv) Then
    Begin
      If fEmptyStr(dbeVrDaUv.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor de despesas acessórias único por venda deve ser maior ou igual a 0!', ['&Ok']);
        Result := False;
      End
      Else If (fStrToFloat(dbeVrDaUv.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O valor de despesas acessórias único por venda deve ser maior ou igual a 0!', ['&Ok']);
        Result := False;
      End;

      If Result Then
        fVaiParaProximaAba(Sender);
    End
    Else
    {**********************************************}
    {* VERIFICA SE TRABALHA COM PERFIL DE CLIENTE *}
    {*******************************************RV*}
    If tbsPerfil.TabVisible Then
    Begin
      If (Sender = dbeDesPfl) Then
      Begin
        If fEmptyStr(dbeDesPfl.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Descrição do Perfil deve ser preenchida!', ['&O k']);
          Result := False;
        End;
      End
      Else If (Sender = dbeImpBol) Then
      Begin
        If (Pos(dbeImpBol.Text, 'SN') <= 0) Then
          Result := False;
      End
      Else If (Sender = dbeSenCnd) Then
      Begin
        If (Pos(dbeSenCnd.Text, 'SN') <= 0) Then
          Result := False;
      End
      Else If (Sender = dbeLimCre) Then
      Begin
        If (Pos(dbeLimCre.Text, 'SN') <= 0) Then
          Result := False;
      End
      Else If (Sender = dbeMarMin) Then
      Begin
        If fEmptyStr(dbeMarMin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Margem/Markup Mínima deve ser informada!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = dbeMarMax) Then
      Begin
        If fEmptyStr(dbeMarMax.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Margem/Markup Máxima deve ser maior ou igual a 0!', ['&Ok']);
          Result := False;
        End
        Else If (fStrToFloat(dbeMarMax.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Margem/Markup Máxima deve ser maior ou igual a 0!', ['&Ok']);
          Result := False;
        End
        Else If (fStrToFloat(dbeMarMax.Text) < fStrToFloat(dbeMarMin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Margem/Markup Máxima deve ser maior ou igual a Mínima!', ['&Ok']);
          Result := False;
        End;

        If Result Then
          fVaiParaProximaAba(Sender);
      End
      Else If (Sender = dbeFatMin) Then
      Begin
        If fEmptyStr(dbeFatMin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Faturamento Mínimo deve ser maior ou igual a 0!', ['&Ok']);
          Result := False;
        End
        Else If (fStrToFloat(dbeFatMin.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Faturamento Mínimo deve ser maior ou igual a 0!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = dbeFatMax) Then
      Begin
        If fEmptyStr(dbeFatMax.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Faturamento Máximo deve ser maior ou igual a 0!', ['&Ok']);
          Result := False;
        End
        Else If (fStrToFloat(dbeFatMax.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Faturamento Máximo deve ser maior ou igual a 0!', ['&Ok']);
          Result := False;
        End
        Else If (fStrToFloat(dbeFatMax.Text) < fStrToFloat(dbeFatMin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Faturamento Máximo deve ser maior ou igual ao Mínimo!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = dbeParMin) Then
      Begin
        If fEmptyStr(dbeParMin.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Parcela Mínima deve ser maior ou igual a 0!', ['&Ok']);
          Result := False;
        End
        Else If (fStrToFloat(dbeParMin.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Parcela Mínima deve ser maior ou igual a 0!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = dbeParMax) Then
      Begin
        If fEmptyStr(dbeParMax.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Parcela Máxima deve ser maior ou igual a 0!', ['&Ok']);
          Result := False;
        End
        Else If (fStrToFloat(dbeParMax.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Parcela Máxima deve ser maior ou igual a 0!', ['&Ok']);
          Result := False;
        End
        Else If (fStrToFloat(dbeParMax.Text) < fStrToFloat(dbeParMin.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Parcela Máxima deve ser maior ou igual a Mínima!', ['&Ok']);
          Result := False;
        End;
      End
      Else If (Sender = dbeTravaCliCompra) Then
      Begin
        If (Pos(dbeTravaCliCompra.Text, 'SN') <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Travar clientes que não compram a XX dias deve ser preenchido com S ou N!', ['&OK']);
          Result := False;
        End;
      End
      Else If (Sender = dbeSenTra) Then
      Begin
        If (Pos(dbeSenTra.Text, 'SN') <= 0) Then
          Result := False;
      End
      Else If (Sender = dbcEspFat) and (pnlEspFat.Visible) Then
      Begin
        If fEmptyStr(dbcEspFat.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Tipo de Faturamento Principal para a Expedição deve ser preechido!', ['&Ok']);
          Result := False;
        End
        Else If (Pos(dbcEspFat.Text, 'NF_FF_IF_') <= 0) Then
          Result := False
        Else
          fVaiParaProximaAba(Sender);
      End
      Else If (Sender = chkTipFatA) Or
              (Sender = chkTipFatB) Or
              (Sender = chkTipFatC) Or
              (Sender = chkTipFatD) Then
      Begin
        if not pnlEspFat.Visible then
          fVaiParaProximaAba(Sender);
      End
      Else If (Sender = chkTpFtDaA) Or
              (Sender = chkTpFtDaB) Or
              (Sender = chkTpFtDaC) Or
              (Sender = chkTpFtDaD) Then
      Begin
        fVaiParaProximaAba(Sender);
      End
      Else If (Sender = dbePetrcd) Then
      Begin
        If (Pos(dbePetrcd.Text, 'SN') <= 0) And
           (dbePetrcd.Visible) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo "Perguntar se deseja manter os preços originais '+
                                'ao fazer a troca para esta condição" deve ser preechido '+
                                'com "S" ou "N".', ['&Ok']);
          Result := False;
        End;
      End;

    End;

    {********************************}
    {* VALIDAÇÕES PARA O PAGAR.ME   *}
    {*****************************WL*}
    If (fCfgSis('PMEHAB',varBoolean)) And
       (dbeGeraCobrancaPagarMe.Text = 'S') And
       (Result) Then
    Begin
      If chkPermiteBoleto.Checked Then
      Begin
        If (Sender = edtPmeDVc) And
           ((StrToIntDef(edtPmeDVc.Text,0) <= 0) Or
            (StrToIntDef(edtPmeDVc.Text,0) > 31)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe um valor válido para os dias para vencimento do boleto. Valores permitidos: de 1 até 31 dias', ['&OK']);
          Result := False;
        End;

        If (Not blnBuscaPorChave) And
           (StrToIntDef(edtPmeDVc.Text,0) = 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Quando permite boleto na cobrança online Pagar.me, é preciso informar os dias para vencimento', ['&OK']);
          Result := False;
        End;
      End;

      If chkPermiteCartao.Checked Then
      Begin
        If (Sender = edtPmeJct) And
           ((StrToFloatDef(edtPmeJct.Text,0) < 0.01) Or
            (StrToFloatDef(edtPmeJct.Text,0) > 100)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe um valor válido para a porcentagem de juros ao mês. Valores permitidos: de 0.01 até 100%.', ['&OK']);
          Result := False;
        End;

        If (Not blnBuscaPorChave) And
           (StrToFloatDef(edtPmeJct.Text,0) = 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informe a porcentagem de juros ao mês no quadro Pagar.me', ['&OK']);
          Result := False;
        End;

        If (Not blnBuscaPorChave) And
           ((cmbLimiteParcelas.ItemIndex < 1) or
            (cmbQtdeParcelasSemJuros.ItemIndex < 1)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Quando permite cartão na cobrança online Pagar.me, é preciso informar o limite de parcelas e a quantidade de parcelas sem juros', ['&OK']);
          Result := False;
        End;
      End;

      If (Not blnBuscaPorChave) And
         (Not chkPermiteBoleto.Checked) And
         (Not chkPermiteCartao.Checked) Then
      Begin
        fMensagem('ATENÇÃO!', 'Pelo menos um meio de pagamento deve estar marcado quando usa a cobrança online Pagar.me', ['&OK']);
        Result := False;
      End;

    End;
  End;

  If Not Result Then
  Begin
    pFocarNaAbaCriticada(Sender);
    pSetFocus(Sender);
  End;
end;

procedure TfrmCadCondicoes.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('CND_CODIGO');
  stlCampos.Add('CND_DESCRI');
  stlCampos.Add('CND_TIPFOR');
  stlCampos.Add('CND_CNDPAG');
  stlCampos.Add('CND_CODPOR');
  stlCampos.Add('CND_DESMAX');
  stlCampos.Add('CND_DESMSU');
  stlCampos.Add('CND_DESMGE');

  stlCampos.Add('CND_DESMVM');
  stlCampos.Add('CND_DESMSM');
  stlCampos.Add('CND_DESMGM');

  stlCampos.Add('CND_TXJURO');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('CND_DESCRI');
  stlCamInd.Add('CND_CODIGO');
  stlCamInd.Add('CND_TIPFOR');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');
  stlDesInd.Add('Fora');

end;

procedure TfrmCadCondicoes.pAfterOpen(DataSet: TDataSet);
begin

  with DataSet do
  begin

    if Active then
    begin

      if FindField('CND_CNDPAG') <> nil then
        TStringField(FieldbyName('CND_CNDPAG')).EditMask := MASK_CONPAG;

      if FindField('CND_TXJURO') <> nil then
        TFloatField(FieldbyName('CND_TXJURO')).DisplayFormat := '0.0000';

      if FindField('CND_DESMAX') <> nil then
        TFloatField(FieldbyName('CND_DESMAX')).DisplayFormat := '0.00';

      if FindField('CND_DESMGE') <> nil then
        TFloatField(FieldbyName('CND_DESMGE')).DisplayFormat := '0.00';

      if FindField('CND_DESMSU') <> nil then
        TFloatField(FieldbyName('CND_DESMSU')).DisplayFormat := '0.00';

      if FindField('CND_DESMVM') <> nil then
        TFloatField(FieldbyName('CND_DESMVM')).DisplayFormat := '0.00';

      if FindField('CND_DESMSM') <> nil then
        TFloatField(FieldbyName('CND_DESMSM')).DisplayFormat := '0.00';

      if FindField('CND_DESMGM') <> nil then
        TFloatField(FieldbyName('CND_DESMGM')).DisplayFormat := '0.00';

      if FindField('CND_FATACA') <> nil then
        TFloatField(FieldbyName('CND_FATACA')).DisplayFormat := '0.00';

      if FindField('CND_PRZMED') <> nil then
        TFloatField(FieldbyName('CND_PRZMED')).DisplayFormat := '0.00';

      if FindField('CND_VALMIN') <> nil then
        TFloatField(FieldbyName('CND_VALMIN')).DisplayFormat := '0.00';

      if FindField('CND_PERCOM') <> nil then
        TFloatField(FieldbyName('CND_PERCOM')).DisplayFormat := '0.00';

      if FindField('CND_PERDPO') <> nil then
        TFloatField(FieldbyName('CND_PERDPO')).DisplayFormat := '0.00';

      if FindField('CND_PERVEN') <> nil then
        TFloatField(FieldbyName('CND_PERVEN')).DisplayFormat := '0.00';

      if FindField('CND_MARMIN') <> nil then
        TFloatField(FieldbyName('CND_MARMIN')).DisplayFormat := '0.00';

      if FindField('CND_MARMAX') <> nil then
        TFloatField(FieldbyName('CND_MARMAX')).DisplayFormat := '0.00';

      if FindField('CND_FATMIN') <> nil then
        TFloatField(FieldbyName('CND_FATMIN')).DisplayFormat := '0.00';

      if FindField('CND_FATMAX') <> nil then
        TFloatField(FieldbyName('CND_FATMAX')).DisplayFormat := '0.00';

      if FindField('CND_PARMIN') <> nil then
        TFloatField(FieldbyName('CND_PARMIN')).DisplayFormat := '0.00';

      if FindField('CND_PARMAX') <> nil then
        TFloatField(FieldbyName('CND_PARMAX')).DisplayFormat := '0.00';

      if FindField('CND_PEDEAC') <> nil then
        TFloatField(FieldbyName('CND_PEDEAC')).DisplayFormat := '0.00';

      if FindField('CND_VRDEAC') <> nil then
        TFloatField(FieldbyName('CND_VRDEAC')).DisplayFormat := '0.00';

      if FindField('CND_VRDAUV') <> nil then
        TFloatField(FieldbyName('CND_VRDAUV')).DisplayFormat := '0.00';

    end;

  end;

end;

procedure TfrmCadCondicoes.pAfterScroll(DataSet: TDataSet);
begin
  pAtualizaCombos(DataSet);
end;

procedure TfrmCadCondicoes.pAtualizaCombos(DataSet: TDataSet);
  Var
    i: Integer;
    tpTrava: TTipoTrava;
begin
  dbcTrClCr.ItemIndex := -1;
  dbcTrOrCr.ItemIndex := -1;
  dbcTrClCb.ItemIndex := -1;
  dbcTrOrCb.ItemIndex := -1;
  dbcAltPre.ItemIndex := -1;
  dbcTipCnd.ItemIndex := -1;
  dbcTrOrFi.ItemIndex := -1;
  dbcTrOrPf.ItemIndex := -1;

  For i := 0 To Length(ARR_TRAVA) -1 Do
  begin
    If DataSet.FieldByName('CND_TRCLCR').AsString = ARR_TRAVA[i][1] Then
      dbcTrClCr.ItemIndex := i;

    If DataSet.FieldByName('CND_TRORCR').AsString = ARR_TRAVA[i][1] Then
      dbcTrOrCr.ItemIndex := i;

    If DataSet.FieldByName('CND_TRCLCB').AsString = ARR_TRAVA[i][1] then
      dbcTrClCb.ItemIndex := i;

    If DataSet.FieldByName('CND_TRORCB').AsString = ARR_TRAVA[i][1] then
      dbcTrOrCb.ItemIndex := i;

  end;

  For i := 0 To Length(ARR_ALTPRE) -1 Do
    If DataSet.FieldByName('CND_ALTPRE').AsString = ARR_ALTPRE[i][1] Then
      dbcAltPre.ItemIndex := i;

  For i := 0 To Length(ARR_TIPCND) -1 Do
    If qryTabela.FieldByName('CND_TIPCND').AsString = ARR_TIPCND[i][1] Then
      dbcTipCnd.ItemIndex := i;

  For i := 0 To Length(ARR_TRAMIN) -1 Do
    If qryTabela.FieldByName('CND_TRAFAT').AsString = ARR_TRAMIN[i][1] Then
      dbcTraFat.ItemIndex := i;

  For i := 0 To Length(ARR_TRAMIN) -1 Do
    If qryTabela.FieldByName('CND_TRAMAR').AsString = ARR_TRAMIN[i][1] Then
      dbcTraMar.ItemIndex := i;

  For i := 0 To Length(ARR_TRAMIN) -1 Do
    If qryTabela.FieldByName('CND_TRAPAR').AsString = ARR_TRAMIN[i][1] Then
      dbcTraPar.ItemIndex := i;


  For tpTrava:= Low( TTipoTrava ) To High( TTipoTrava ) Do
  Begin
    If DataSet.FieldByName('CND_TRORFI').AsString = arrTipoTrava[tpTrava] Then
      dbcTrOrFi.ItemIndex := Integer(tpTrava);

    If DataSet.FieldByName('CND_TRORPF').AsString = arrTipoTrava[tpTrava] Then
      dbcTrOrPf.ItemIndex := Integer(tpTrava);
  End;

end;

procedure TfrmCadCondicoes.pCarregaDadosAdicionais;
var
  strTabelasPreco: string;
  intIndice: integer;
begin
  pCarregaPortador;
  pExibirMaximoParcelasCartao;
  edtDesFpg.Text := fRetDesFpg(dbeCodFpg.Text);
  pCarregaListaEmpresas(clbEmpCnd, fGetEmpAceCadCnd(qryTabela.FieldByName('CND_CODIGO').AsString));
  pCarregaModalidadeFormaPagamento;

  chkNaoValidaDin.Enabled := (dtsCadCnd.State in dsEditModes) And (dbeCodFpg.Field.AsString = '009');
  chkNaoValidaChq.Enabled := (dtsCadCnd.State in dsEditModes) And (dbeCodFpg.Field.AsString = '009');
  chkNaoValidaCar.Enabled := (dtsCadCnd.State in dsEditModes) And (dbeCodFpg.Field.AsString = '009');

  chkNaoValidaDin.Checked := (Pos('001', qryTabela.FieldByName('CND_FPGNVL').AsString) > 0);
  chkNaoValidaCar.Checked := (Pos('007', qryTabela.FieldByName('CND_FPGNVL').AsString) > 0);
  chkNaoValidaChq.Checked := (Pos('002', qryTabela.FieldByName('CND_FPGNVL').AsString) > 0) Or
                             (Pos('006', qryTabela.FieldByName('CND_FPGNVL').AsString) > 0);

  chkPermiteBoleto.Checked := StrToIntDef(qryTabela.FieldByName('CND_PMEDVC').AsString,0) > 0;
  chkPermiteCartao.Checked := not fEmptyStr(qryTabela.FieldByName('CND_PMEQPA').AsString);

  cmbLimiteParcelas.ItemIndex := cmbLimiteParcelas.Items.IndexOf(qryTabela.FieldByName('CND_PMEQPA').AsString.Trim);
  cmbLimiteParcelasSelect(cmbLimiteParcelas);

  cmbQtdeParcelasSemJuros.ItemIndex := cmbQtdeParcelasSemJuros.Items.IndexOf(qryTabela.FieldByName('CND_PMEQPJ').AsString.Trim);

  edtPmeJct.Text := FormatFloat('#,##0.00', qryTabela.FieldByName('CND_PMEJCT').AsFloat);
  edtPmeDVc.Text := qryTabela.FieldByName('CND_PMEDVC').AsString;

  if (blnTabPre) then
  begin
    strTabelasPreco := qryTabela.FieldByName('CND_PRETAB').AsString;
    if not fEmptyStr(strTabelasPreco) then
    begin
      for intIndice := 1 to Length(strTabelasPreco) do
      begin
        clbPreTab.Checked[intIndice - 1] := strTabelasPreco[intIndice] = 'S';
      end;
    end;
  end;
end;

procedure TfrmCadCondicoes.pCarregaModalidadeFormaPagamento;
begin
  if dbeCodFpg.Text = '009' then
  begin
    cbbMoDiVn.Visible := True;
    lblMoDiVn.Visible := True;
  end
  else
  begin
    cbbMoDiVn.Visible := False;
    lblMoDiVn.Visible := False;
  end;

  if fEmptyStr(qryTabela.FieldByName('CND_MODIVN').AsString) then
  begin
    cbbMoDiVn.ItemIndex := 2;
  end
  else
  begin
    case AnsiIndexStr(UpperCase(qryTabela.FieldByName('CND_MODIVN').AsString), ['V','P','T']) of
      0: cbbMoDiVn.ItemIndex := 0;
      1: cbbMoDiVn.ItemIndex := 1;
      2: cbbMoDiVn.ItemIndex := 2;
    end;
  end;
end;

procedure TfrmCadCondicoes.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, dbeCodPor.Text);
  edtNomPor.Text := qryConPor.FieldbyName('POR_NOMPOR').AsString;
end;

procedure TfrmCadCondicoes.pExibirMaximoParcelasCartao;
begin
  lblMaxCar.Visible := (dbeCodFpg.Text = '009') And (fConPagComEntrada(dbeCndPag.Text)) And tbsPerfil.TabVisible;
  dbeMaxCar.Visible := (dbeCodFpg.Text = '009') And (fConPagComEntrada(dbeCndPag.Text)) And tbsPerfil.TabVisible;
end;

procedure TfrmCadCondicoes.pFocarNaAbaCriticada(Sender: TWinControl);
  Var
    intCnt : Integer;
begin
  For intCnt := 0 To pgcDados.PageCount -1 Do
  Begin
    If fAchaControle(pgcDados.Pages[intCnt], Sender.Name) Then
    Begin
      if pgcDados.Pages[intCnt].TabVisible then
      begin
        pgcDados.ActivePage := pgcDados.Pages[intCnt];
        Break;
      end;
    End;
  End;
end;

procedure TfrmCadCondicoes.btnExcluirClick(Sender: TObject);
begin
  if fPossuiVinculoIntegracao(True) then
  begin
    fMensagem('ATENÇÃO!', 'Não é possível excluir esta condição de pagamento pois ela está vinculada com integrações Citel!', ['&O k']);
    Exit;
  end;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCondicoes.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  pCarregaDadosAdicionais;
  pMostraDiaFixo;        
end;

function TfrmCadCondicoes.fValidaLinkPgtoCheckout : Boolean;
begin
  Result := True;

  if not TLinkPagamentoCitelCfg.fLinkPagamentoCitelLigado then
    Exit(False);

  if not fTemLinkPagamentoHabilitadoNestaCondicao then
    Exit(False);

  if dbeRcx_F3.Text = 'N' then
    Exit(False);
end;

function TfrmCadCondicoes.fValidaLinkPgtoBoletoFaturamento : Boolean;
begin
  Result := True;

  if not TLinkPagamentoCitelCfg.fLinkPagamentoCitelLigado then
    Exit(False);

  if fCfgSis('PFLCLI') <> 'S' then
    Exit(False);

  if not fTemLinkPagamentoHabilitadoNestaCondicao then
    Exit(False);

  if dbeImpBol.Text = 'N' then
    Exit(False);
end;

function TfrmCadCondicoes.fValidaHierarquia(DataSet: TDataSet) : Boolean;
var
  objValidaHierarquia : TValidaHierarquia;
  recResultado        : TResultado;
begin

  Result := True;

  objValidaHierarquia := TValidaHierarquia.Create(Self);

  Try

    objValidaHierarquia.pSetVendedorJunior(DataSet.FieldByName('CND_DESMAX').AsFloat);
    objValidaHierarquia.pSetVendedorMaster(DataSet.FieldByName('CND_DESMVM').AsFloat);
    objValidaHierarquia.pSetSubGerenJunior(DataSet.FieldByName('CND_DESMSU').AsFloat);
    objValidaHierarquia.pSetSubGerenMaster(DataSet.FieldByName('CND_DESMSM').AsFloat);
    objValidaHierarquia.pSetGerente_Junior(DataSet.FieldByName('CND_DESMGE').AsFloat);
    objValidaHierarquia.pSetGerente_Master(DataSet.FieldByName('CND_DESMGM').AsFloat);

    recResultado := objValidaHierarquia.fValidarDescontoMaximoOperador;

    If recResultado.TemInconsistencia Then
    Begin
      fMensagem('ATENÇÃO!', recResultado.Mensagem, ['&Ok']);
      Result := False;
    End;

  Finally
    FreeAndNil(objValidaHierarquia);
  End;

end;

procedure TfrmCadCondicoes.btnGravarClick(Sender: TObject);
var
  intIndice: integer;
  strTabPre: string;
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  if fValidaLinkPgtoCheckout then
  begin
    fMensagem('ATENÇÃO!', 'Não é permitido utilizar "Gerar Link para Pagamento Online/Cielo"'+
                          ' com "Permitir utilizar esta condição de   pagamento no F3 (checkout) do caixa.'+
                          ' Verifique!', ['&Ok']);
    tbsGeral.Show;
    pSetFocusLinkPgto ;
    Exit;
  end;

  if fValidaLinkPgtoBoletoFaturamento then
  begin
    fMensagem('ATENÇÃO!', 'Não é permitido utilizar "Gerar Link para Pagamento Online/Cielo" '+
                          'com "Imprime Boleto no Faturamento" da aba Perfil.', ['&Ok']);
    tbsPerfil.Show;
    pSetFocus(dbeImpBol);
    Exit;
  end;

  if not fValidaHierarquia(qryTabela) Then
   Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If dbcTipCnd.ItemIndex > -1 Then
    qryTabela.FieldByName('CND_TIPCND').AsString := ARR_TIPCND[dbcTipCnd.ItemIndex][1];

  If cbbDiaFix.ItemIndex > 0 Then
    qryTabela.FieldByName('CND_DIAFIX').AsInteger := cbbDiaFix.ItemIndex
  Else
    qryTabela.FieldByName('CND_DIAFIX').Clear;

  qryTabela.FieldByName('CND_TRCLCR').Clear;

  If dbcTrClCr.ItemIndex > -1 Then
    qryTabela.FieldByName('CND_TRCLCR').AsString := ARR_TRAVA[dbcTrClCr.ItemIndex][1];

  If dbcTrOrCr.ItemIndex > -1 Then
    qryTabela.FieldByName('CND_TRORCR').AsString := ARR_TRAVA[dbcTrOrCr.ItemIndex][1];

  if dbcTrClCb.ItemIndex > -1 Then
    qryTabela.FieldByName('CND_TRCLCB').AsString := ARR_TRAVA[dbcTrClCb.ItemIndex][1];

  if dbcTrOrCb.ItemIndex > -1 Then
    qryTabela.FieldByName('CND_TRORCB').AsString := ARR_TRAVA[dbcTrOrCb.ItemIndex][1];

  If dbcAltPre.ItemIndex > -1 Then
    qryTabela.FieldByName('CND_ALTPRE').AsString := ARR_ALTPRE[dbcAltPre.ItemIndex][1];

  If dbcTraFat.ItemIndex > -1 Then
    qryTabela.FieldByName('CND_TRAFAT').AsString := ARR_TRAMIN[dbcTraFat.ItemIndex][1];

  If dbcTraMar.ItemIndex > -1 Then
    qryTabela.FieldByName('CND_TRAMAR').AsString := ARR_TRAMIN[dbcTraMar.ItemIndex][1];

  If dbcTraPar.ItemIndex > -1 Then
    qryTabela.FieldByName('CND_TRAPAR').AsString := ARR_TRAMIN[dbcTraPar.ItemIndex][1];

  If (Not blnPermitirEmissaoFF) Then
    chkTipFatB.Checked := False;

  qryTabela.FieldByName('CND_TIPFAT').AsString := IIF(chkTipFatA.Checked, 'A', '')
                                                + IIF(chkTipFatB.Checked, 'B', '')
                                                + IIF(chkTipFatC.Checked, 'C', '')
                                                + IIF(chkTipFatD.Checked, 'D', '');

  If (Not blnPermitirEmissaoFF) Then
    chkTpFtDaB.Checked := False;

  qryTabela.FieldByName('CND_TPFTDA').AsString := IIF(chkTpFtDaA.Checked, 'A', '')
                                                + IIF(chkTpFtDaB.Checked, 'B', '')
                                                + IIF(chkTpFtDaC.Checked, 'C', '')
                                                + IIF(chkTpFtDaD.Checked, 'D', '');

  qryTabela.FieldByName('CND_FPGNVL').AsString := IIF(chkNaoValidaDin.Checked, '001_', '')
                                                + IIF(chkNaoValidaChq.Checked, '002_', '')
                                                + IIF(chkNaoValidaChq.Checked, '006_', '')
                                                + IIF(chkNaoValidaCar.Checked, '007_', '');

  qryTabela.FieldByName('CND_EMPACE').AsString := fGetEmpSelecao;

  if blnTabPre then
  begin
    strTabPre := EmptyStr;
    for intIndice := 0 to 6 do
    begin  
      if (clbPreTab.Checked[intIndice]) And (clbPreTab.ItemEnabled[intIndice]) then
      begin
        strTabPre := strTabPre + 'S';
      end
      else
      begin
        strTabPre := strTabPre + 'N';
      end;
    end;
    qryTabela.FieldByName('CND_PRETAB').AsString := strTabPre;
  end;

  If (Not spnLimite.Visible) Then
  begin
    qryTabela.FieldByName('CND_LIMITE').AsInteger := 0;
    qryTabela.FieldByName('CND_DIACOR').AsString  := 'N';
  end;

  if (fCfgSis('YAPHAB',varBoolean)) then
  begin
    if qryTabela.FieldByName('CND_YAPDIS').AsString <> TYapayFacade.TcxCheckComboBox(cbYapDis).Value then
      qryTabela.FieldByName('CND_YAPDIS').AsString := TYapayFacade.TcxCheckComboBox(cbYapDis).Value;
  end
  else
  begin
    dbeGeraCobrancaYapay.Field.AsString := Nao.ToFlag;
    cbYapTra.Field.Clear;
    cbYapDis.Clear;
    edtYapPar.Field.clear;
  end;

  if pnlEspFat.Visible then
    qryTabela.FieldByName('CND_ESPFAT').AsString := dbcEspFat.Text;

  If dbcTrOrFi.ItemIndex > -1 Then
    qryTabela.FieldByName('CND_TRORFI').AsString := arrTipoTrava[ TTipoTrava(dbcTrOrFi.ItemIndex)];

  If dbcTrOrPf.ItemIndex > -1 Then
    qryTabela.FieldByName('CND_TRORPF').AsString := arrTipoTrava[ TTipoTrava(dbcTrOrPf.ItemIndex)];

  qryTabela.FieldByName('CND_PMEQPA').AsString := EmptyStr;
  qryTabela.FieldByName('CND_PMEQPJ').AsString := EmptyStr;
  qryTabela.FieldByName('CND_PMEDVC').AsString := '0';
  qryTabela.FieldByName('CND_PMEJCT').AsFloat  := 0.01;

  if cbbMoDiVn.Visible then
  begin
    if dbeCodFpg.Text = '009' then
    begin
      case cbbMoDiVn.ItemIndex of
        0: qryTabela.FieldByName('CND_MODIVN').AsString := 'V';
        1: qryTabela.FieldByName('CND_MODIVN').AsString := 'P';
        2: qryTabela.FieldByName('CND_MODIVN').AsString := 'T';
      end;
    end
    else
    begin
      qryTabela.FieldByName('CND_MODIVN').AsString := 'T';
    end;
  end
  else
  begin
    qryTabela.FieldByName('CND_MODIVN').AsString := 'T';
  end;

  If (fCfgSis('PMEHAB',varBoolean)) Then
  Begin
    If chkPermiteBoleto.Checked Then
      qryTabela.FieldByName('CND_PMEDVC').AsString := edtPmeDVc.Text;

    If chkPermiteCartao.Checked Then
    Begin
      If cmbQtdeParcelasSemJuros.ItemIndex > 0 Then
      Begin
        qryTabela.FieldByName('CND_PMEQPA').AsString := cmbLimiteParcelas.Text;
        qryTabela.FieldByName('CND_PMEQPJ').AsString := cmbQtdeParcelasSemJuros.Text;
        qryTabela.FieldByName('CND_PMEJCT').AsFloat  := StrToFloat(edtPmeJct.Text);
      End;
    End;
  End;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCondicoes.btnGravarClick]');
    End;
  End;

  If blnGravou Then
  Begin
    fCommit;
    dbcTrClCr.Enabled  := False;
    dbcTrOrCr.Enabled  := False;
    dbcTrClCb.Enabled  := False;
    dbcTrOrCb.Enabled  := False;
    dbcTipCnd.Enabled  := False;
    cbbDiaFix.Enabled  := False;
    spnLimite.Enabled  := False;
    dbcAltPre.Enabled  := False;
    dbcTipFor.Enabled  := False;
    clbEmpCnd.Enabled  := False;
    dbcDiaCor.Enabled  := False;
    dbeCondEsp.Enabled := False;
    dbcTraFat.Enabled  := False;
    dbcTraMar.Enabled  := False;
    dbcTraPar.Enabled  := False;
    pgcDados.ActivePageIndex := 0;
    pnlSelEmp.Visible  := False;
    dbcTrOrFi.Enabled  := False;
    dbcTrOrPf.Enabled  := False;
  End
  Else
    fRollBack;
end;

procedure TfrmCadCondicoes.btnHerancaClick(Sender: TObject);
  Var
    cdsHeranca : TUniClientDataSet;
begin
  inherited;

  cdsHeranca := fCriaClientDatset(qryTabela);
  Try
    btnIncluir.Click;

    qrytabela.FieldByName('CND_DESCRI').AsVariant := cdsHeranca.FieldByName('CND_DESCRI').AsVariant;
    qrytabela.FieldByName('CND_CNDPAG').AsVariant := cdsHeranca.FieldByName('CND_CNDPAG').AsVariant;
    qrytabela.FieldByName('CND_TIPFOR').AsVariant := cdsHeranca.FieldByName('CND_TIPFOR').AsVariant;
    qrytabela.FieldByName('CND_CODEMP').AsVariant := cdsHeranca.FieldByName('CND_CODEMP').AsVariant;
    qrytabela.FieldByName('CND_ABADES').AsVariant := cdsHeranca.FieldByName('CND_ABADES').AsVariant;
    qrytabela.FieldByName('CND_ABDECC').AsVariant := cdsHeranca.FieldByName('CND_ABDECC').AsVariant;
    qrytabela.FieldByName('CND_INFANA').AsVariant := cdsHeranca.FieldByName('CND_INFANA').AsVariant;
    qrytabela.FieldByName('CND_SEMENT').AsVariant := cdsHeranca.FieldByName('CND_SEMENT').AsVariant;
    qrytabela.FieldByName('CND_DIAFIX').AsVariant := cdsHeranca.FieldByName('CND_DIAFIX').AsVariant;
    qrytabela.FieldByName('CND_DESPFL').AsVariant := cdsHeranca.FieldByName('CND_DESPFL').AsVariant;
    qrytabela.FieldByName('CND_IMPBOL').AsVariant := cdsHeranca.FieldByName('CND_IMPBOL').AsVariant;
    qrytabela.FieldByName('CND_ALTPRE').AsVariant := cdsHeranca.FieldByName('CND_ALTPRE').AsVariant;
    qrytabela.FieldByName('CND_SENCND').AsVariant := cdsHeranca.FieldByName('CND_SENCND').AsVariant;
    qrytabela.FieldByName('CND_LIMCRE').AsVariant := cdsHeranca.FieldByName('CND_LIMCRE').AsVariant;
    qrytabela.FieldByName('CND_CODVEL').AsVariant := cdsHeranca.FieldByName('CND_CODVEL').AsVariant;
    qrytabela.FieldByName('CND_TIPFAT').AsVariant := cdsHeranca.FieldByName('CND_TIPFAT').AsVariant;
    qrytabela.FieldByName('CND_IMPFAT').AsVariant := cdsHeranca.FieldByName('CND_IMPFAT').AsVariant;
    qrytabela.FieldByName('CND_JURPRO').AsVariant := cdsHeranca.FieldByName('CND_JURPRO').AsVariant;
    qrytabela.FieldByName('CND_TIPCND').AsVariant := cdsHeranca.FieldByName('CND_TIPCND').AsVariant;
    qrytabela.FieldByName('CND_TRTTVE').AsVariant := cdsHeranca.FieldByName('CND_TRTTVE').AsVariant;
    qrytabela.FieldByName('CND_EMPACE').AsVariant := cdsHeranca.FieldByName('CND_EMPACE').AsVariant;
    qrytabela.FieldByName('CND_TRCLCR').AsVariant := cdsHeranca.FieldByName('CND_TRCLCR').AsVariant;
    qrytabela.FieldByName('CND_LBPDOB').AsVariant := cdsHeranca.FieldByName('CND_LBPDOB').AsVariant;
    qrytabela.FieldByName('CND_DESMSU').AsVariant := cdsHeranca.FieldByName('CND_DESMSU').AsVariant;
    qrytabela.FieldByName('CND_FPGNVL').AsVariant := cdsHeranca.FieldByName('CND_FPGNVL').AsVariant;
    qrytabela.FieldByName('CND_SENTRA').AsVariant := cdsHeranca.FieldByName('CND_SENTRA').AsVariant;
    qrytabela.FieldByName('CND_TPFTDA').AsVariant := cdsHeranca.FieldByName('CND_TPFTDA').AsVariant;
    qrytabela.FieldByName('CND_MCOBDA').AsVariant := cdsHeranca.FieldByName('CND_MCOBDA').AsVariant;
    qrytabela.FieldByName('CND_EXPFSO').AsVariant := cdsHeranca.FieldByName('CND_EXPFSO').AsVariant;
    qrytabela.FieldByName('CND_PRAMIN').AsVariant := cdsHeranca.FieldByName('CND_PRAMIN').AsVariant;
    qrytabela.FieldByName('CND_RETIRA').AsVariant := cdsHeranca.FieldByName('CND_RETIRA').AsVariant;
    qrytabela.FieldByName('CND_ENTIME').AsVariant := cdsHeranca.FieldByName('CND_ENTIME').AsVariant;
    qrytabela.FieldByName('CND_ENTFUT').AsVariant := cdsHeranca.FieldByName('CND_ENTFUT').AsVariant;
    qrytabela.FieldByName('CND_TRCLCB').AsVariant := cdsHeranca.FieldByName('CND_TRCLCB').AsVariant;
    qrytabela.FieldByName('CND_EXPB2B').AsVariant := cdsHeranca.FieldByName('CND_EXPB2B').AsVariant;
    qrytabela.FieldByName('CND_PRETAB').AsVariant := cdsHeranca.FieldByName('CND_PRETAB').AsVariant;
    qrytabela.FieldByName('CND_USADEP').AsVariant := cdsHeranca.FieldByName('CND_USADEP').AsVariant;
    qrytabela.FieldByName('CND_RCX_F3').AsVariant := cdsHeranca.FieldByName('CND_RCX_F3').AsVariant;
    qrytabela.FieldByName('CND_COBYAP').AsVariant := cdsHeranca.FieldByName('CND_COBYAP').AsVariant;
    qrytabela.FieldByName('CND_TRORCR').AsVariant := cdsHeranca.FieldByName('CND_TRORCR').AsVariant;
    qrytabela.FieldByName('CND_TRORCB').AsVariant := cdsHeranca.FieldByName('CND_TRORCB').AsVariant;
    qrytabela.FieldByName('CND_YAPTRA').AsVariant := cdsHeranca.FieldByName('CND_YAPTRA').AsVariant;
    qrytabela.FieldByName('CND_YAPDIS').AsVariant := cdsHeranca.FieldByName('CND_YAPDIS').AsVariant;
    qrytabela.FieldByName('CND_DIACOR').AsVariant := cdsHeranca.FieldByName('CND_DIACOR').AsVariant;
    qrytabela.FieldByName('CND_TRAFAT').AsVariant := cdsHeranca.FieldByName('CND_TRAFAT').AsVariant;
    qrytabela.FieldByName('CND_TRAMAR').AsVariant := cdsHeranca.FieldByName('CND_TRAMAR').AsVariant;
    qrytabela.FieldByName('CND_TRAPAR').AsVariant := cdsHeranca.FieldByName('CND_TRAPAR').AsVariant;
    qrytabela.FieldByName('CND_CNDESP').AsVariant := cdsHeranca.FieldByName('CND_CNDESP').AsVariant;
    qrytabela.FieldByName('CND_RECPIX').AsVariant := cdsHeranca.FieldByName('CND_RECPIX').AsVariant;
    qrytabela.FieldByName('CND_TRACNC').AsVariant := cdsHeranca.FieldByName('CND_TRACNC').AsVariant;
    qrytabela.FieldByName('CND_GERLNK').AsVariant := cdsHeranca.FieldByName('CND_GERLNK').AsVariant;
    qrytabela.FieldByName('CND_ESPFAT').AsVariant := cdsHeranca.FieldByName('CND_ESPFAT').AsVariant;
    qrytabela.FieldByName('CND_TRORFI').AsVariant := cdsHeranca.FieldByName('CND_TRORFI').AsVariant;
    qrytabela.FieldByName('CND_TRORPF').AsVariant := cdsHeranca.FieldByName('CND_TRORPF').AsVariant;
    qrytabela.FieldByName('CND_COBPME').AsVariant := cdsHeranca.FieldByName('CND_COBPME').AsVariant;
    qrytabela.FieldByName('CND_EXPTAB').AsVariant := cdsHeranca.FieldByName('CND_EXPTAB').AsVariant;
    qrytabela.FieldByName('CND_PMEDVC').AsVariant := cdsHeranca.FieldByName('CND_PMEDVC').AsVariant;
    qrytabela.FieldByName('CND_PMEQPA').AsVariant := cdsHeranca.FieldByName('CND_PMEQPA').AsVariant;
    qrytabela.FieldByName('CND_PMEQPJ').AsVariant := cdsHeranca.FieldByName('CND_PMEQPJ').AsVariant;
    qrytabela.FieldByName('CND_MODIVN').AsVariant := cdsHeranca.FieldByName('CND_MODIVN').AsVariant;
    qrytabela.FieldByName('CND_PETRCD').AsVariant := cdsHeranca.FieldByName('CND_PETRCD').AsVariant;
    qrytabela.FieldByName('CND_IPAGLK').AsVariant := cdsHeranca.FieldByName('CND_IPAGLK').AsVariant;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_CODFPG').AsString) Then
      qrytabela.FieldByName('CND_CODFPG').AsString := cdsHeranca.FieldByName('CND_CODFPG').AsString;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_CODPOR').AsString) Then
      qrytabela.FieldByName('CND_CODPOR').AsString := cdsHeranca.FieldByName('CND_CODPOR').AsString;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_YAPPAR').AsString) Then
      qrytabela.FieldByName('CND_YAPPAR').AsInteger := cdsHeranca.FieldByName('CND_YAPPAR').AsInteger;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_QTDPAR').AsString) Then
      qrytabela.FieldByName('CND_QTDPAR').AsInteger := cdsHeranca.FieldByName('CND_QTDPAR').AsInteger;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_QTDDAV').AsString) Then
      qrytabela.FieldByName('CND_QTDDAV').AsInteger := cdsHeranca.FieldByName('CND_QTDDAV').AsInteger;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_MAXCAR').AsString) Then
      qrytabela.FieldByName('CND_MAXCAR').AsInteger := cdsHeranca.FieldByName('CND_MAXCAR').AsInteger;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_QTDMAX').AsString) Then
      qrytabela.FieldByName('CND_QTDMAX').AsInteger := cdsHeranca.FieldByName('CND_QTDMAX').AsInteger;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_LIMITE').AsString) Then
      qrytabela.FieldByName('CND_LIMITE').AsInteger := cdsHeranca.FieldByName('CND_LIMITE').AsInteger;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_EMIBOL').AsString) Then
      qrytabela.FieldByName('CND_EMIBOL').AsInteger := cdsHeranca.FieldByName('CND_EMIBOL').AsInteger;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_PERDPO').AsString) Then
      qrytabela.FieldByName('CND_PERDPO').AsFloat := cdsHeranca.FieldByName('CND_PERDPO').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_PERCOM').AsString) Then
      qrytabela.FieldByName('CND_PERCOM').AsFloat := cdsHeranca.FieldByName('CND_PERCOM').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_MARMAX').AsString) Then
      qrytabela.FieldByName('CND_MARMAX').AsFloat := cdsHeranca.FieldByName('CND_MARMAX').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_FATMIN').AsString) Then
      qrytabela.FieldByName('CND_FATMIN').AsFloat := cdsHeranca.FieldByName('CND_FATMIN').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_FATMAX').AsString) Then
      qrytabela.FieldByName('CND_FATMAX').AsFloat := cdsHeranca.FieldByName('CND_FATMAX').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_PEDEAC').AsString) Then
      qrytabela.FieldByName('CND_PEDEAC').AsFloat := cdsHeranca.FieldByName('CND_PEDEAC').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_MARMIN').AsString) Then
      qrytabela.FieldByName('CND_MARMIN').AsFloat := cdsHeranca.FieldByName('CND_MARMIN').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_DESMAX').AsString) Then
      qrytabela.FieldByName('CND_DESMAX').AsFloat := cdsHeranca.FieldByName('CND_DESMAX').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_TXJURO').AsString) Then
      qrytabela.FieldByName('CND_TXJURO').AsFloat := cdsHeranca.FieldByName('CND_TXJURO').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_PRZMED').AsString) Then
      qrytabela.FieldByName('CND_PRZMED').AsFloat := cdsHeranca.FieldByName('CND_PRZMED').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_FATACA').AsString) Then
      qrytabela.FieldByName('CND_FATACA').AsFloat := cdsHeranca.FieldByName('CND_FATACA').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_DESMGE').AsString) Then
      qrytabela.FieldByName('CND_DESMGE').AsFloat := cdsHeranca.FieldByName('CND_DESMGE').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_VALMIN').AsString) Then
      qrytabela.FieldByName('CND_VALMIN').AsFloat := cdsHeranca.FieldByName('CND_VALMIN').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_VRDEAC').AsString) Then
      qrytabela.FieldByName('CND_VRDEAC').AsFloat := cdsHeranca.FieldByName('CND_VRDEAC').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_VRDAUV').AsString) Then
      qrytabela.FieldByName('CND_VRDAUV').AsFloat := cdsHeranca.FieldByName('CND_VRDAUV').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_PARMAX').AsString) Then
      qrytabela.FieldByName('CND_PARMAX').AsFloat := cdsHeranca.FieldByName('CND_PARMAX').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_PARMIN').AsString) Then
      qrytabela.FieldByName('CND_PARMIN').AsFloat := cdsHeranca.FieldByName('CND_PARMIN').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_PERVEN').AsString) Then
      qrytabela.FieldByName('CND_PERVEN').AsFloat := cdsHeranca.FieldByName('CND_PERVEN').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_DESMVM').AsString) Then
      qrytabela.FieldByName('CND_DESMVM').AsFloat := cdsHeranca.FieldByName('CND_DESMVM').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_DESMSM').AsString) Then
      qrytabela.FieldByName('CND_DESMSM').AsFloat := cdsHeranca.FieldByName('CND_DESMSM').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_DESMGM').AsString) Then
      qrytabela.FieldByName('CND_DESMGM').AsFloat := cdsHeranca.FieldByName('CND_DESMGM').AsFloat;

    If Not fEmptyStr(cdsHeranca.FieldByName('CND_PMEJCT').AsString) Then
      qrytabela.FieldByName('CND_PMEJCT').AsFloat := cdsHeranca.FieldByName('CND_PMEJCT').AsFloat;

    pCarregaListaEmpresas(clbEmpCnd, fGetEmpAceCadCnd(cdsHeranca.FieldByName('CND_CODIGO').AsString));
    pCarregarTipoFaturamento;

    edtDesFpg.Text := fRetDesForPag(dbeCodFpg.Text);
    edtNomPor.Text := fRetNomPortador(dbeCodPor.Text);
  Finally
    pFreeAndNil(cdsHeranca);
  End;
end;

procedure TfrmCadCondicoes.btnLimiteClick(Sender: TObject);
begin

 pCriarFormularios(TfrmMensagemExplicativa, frmMensagemExplicativa);
  Try
    frmMensagemExplicativa.Width := Self.Width;

    frmMensagemExplicativa.Caption := 'Instrução';
    frmMensagemExplicativa.mmoInstru.Lines.Add('Indica a quantidade limite em dias, entre e emissão e o vencimento, para que a primeira parcela caia ainda dentro do mesmo mês, conforme os exemplos:');
    frmMensagemExplicativa.mmoInstru.Lines.Add('');
    frmMensagemExplicativa.mmoInstru.Lines.Add('A-"Dia fixo vencimento(s)" 28 com um "Limite" à 05 dias do vencimento, a primeira parcela será dia: 28/'+fStrZero(IntToStr(MonthOf(VS_Date)),2)+'/'+IntToStr(YearOf(VS_Date))+' '+
                                               'para documentos emitidos entre: 01/'+fStrZero(IntToStr(MonthOf(VS_Date)),2)+'/'+IntToStr(YearOf(VS_Date))+' e 23/'+fStrZero(IntToStr(MonthOf(VS_Date)),2)+'/'+IntToStr(YearOf(VS_Date))+'.');
    frmMensagemExplicativa.mmoInstru.Lines.Add('');
    frmMensagemExplicativa.mmoInstru.Lines.Add('A-"Dia fixo vencimento(s)" 28 com um "Limite" à 10 dias do vencimento, a primeira parcela será dia: 28/'+fStrZero(IntToStr(MonthOf(VS_Date)),2)+'/'+IntToStr(YearOf(VS_Date))+' '+
                                               'para documentos emitidos entre: 01/'+fStrZero(IntToStr(MonthOf(VS_Date)),2)+'/'+IntToStr(YearOf(VS_Date))+' e 18/'+fStrZero(IntToStr(MonthOf(VS_Date)),2)+'/'+IntToStr(YearOf(VS_Date))+'.');
    frmMensagemExplicativa.mmoInstru.Lines.Add('');
    frmMensagemExplicativa.mmoInstru.Lines.Add('A-"Dia fixo vencimento(s)" 28 com um "Limite" à 20 dias do vencimento, a primeira parcela será dia: 28/'+fStrZero(IntToStr(MonthOf(VS_Date)),2)+'/'+IntToStr(YearOf(VS_Date))+' '+
                                               'para documentos emitidos entre: 01/'+fStrZero(IntToStr(MonthOf(VS_Date)),2)+'/'+IntToStr(YearOf(VS_Date))+' e 08/'+fStrZero(IntToStr(MonthOf(VS_Date)),2)+'/'+IntToStr(YearOf(VS_Date))+'.');
    frmMensagemExplicativa.mmoInstru.Lines.Add('');
    frmMensagemExplicativa.mmoInstru.Lines.Add('Caso "Limite" for 0, o vencimento será sempre o "Dia fixo vencimento(s)" indicado, do mês subsequente.');
    frmMensagemExplicativa.ShowModal;
  Finally
    pFreeAndNil(frmMensagemExplicativa);
  End;
end;

procedure TfrmCadCondicoes.pLimpaEdits;
begin
  edtNomPor.Clear;
end;

procedure TfrmCadCondicoes.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pnlSelEmp.Visible := False;
  pCarregaDadosAdicionais;
  pMostraDiaFixo;
  pAtualizaCombos(qryTabela);
  dbcTrClCr.Enabled  := False;
  dbcTrOrCr.Enabled  := False;
  dbcTrClCb.Enabled  := False;
  dbcTrOrCb.Enabled  := False;
  dbcTipCnd.Enabled  := False;
  cbbDiaFix.Enabled  := False;
  spnLimite.Enabled  := False;
  dbcAltPre.Enabled  := False;
  dbcTipFor.Enabled  := False;
  clbEmpCnd.Enabled  := False;
  dbcDiaCor.Enabled  := False;
  dbeCondEsp.Enabled := False;
  dbcTraFat.Enabled  := False;
  dbcTraMar.Enabled  := False;
  dbcTraPar.Enabled  := False;
  pgcDados.ActivePageIndex := 0;
  dbcTrOrFi.Enabled  := False;
  dbcTrOrPf.Enabled  := False;

end;

procedure TfrmCadCondicoes.btnDescMaxClick(Sender: TObject);
  Var
    qryCndGru : TUniQuery;
    frmCadCondLinGru : TfrmCadCondLinGru;
begin
  inherited;
  Try
    If (qryTabela.IsEmpty) Or (qryTabela.State in [dsInsert, dsEdit]) Then
      Exit;

    pCriarFormularios(TfrmCadCondLinGru, frmCadCondLinGru);
    frmCadCondLinGru.cdsItens.CreateDataSet;
    frmCadCondLinGru.strCodCnd := qryTabela.FieldByName('CND_CODIGO').AsString;

    qryCndGru := fCriaQuery(Self);

    With qryCndGru Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT D.CND_CODCND AS CODCND,                                     ');
      SQL.Add('       C.CND_DESCRI AS DESCND,                                     ');
      SQL.Add('       D.CND_CODGRU AS CODGRU,                                     ');
      SQL.Add('       G.GRU_DESGRU AS DESGRU,                                     ');
      SQL.Add('       D.CND_DESMAG AS DESMAG,                                     ');
      SQL.Add('       D.CND_DESMAS AS DESMAS,                                     ');
      SQL.Add('       D.CND_DESMAV AS DESMAV,                                     ');
      SQL.Add('       D.CND_DESMGM AS DESMGM,                                     ');
      SQL.Add('       D.CND_DESMSM AS DESMSM,                                     ');
      SQL.Add('       D.CND_DESMVM AS DESMVM                                      ');
      SQL.Add('FROM   CNDGRU D INNER JOIN CADCND C ON D.CND_CODCND = C.CND_CODIGO ');
      SQL.Add('                INNER JOIN CADGRU G ON D.CND_CODGRU = G.GRU_CODGRU ');
      SQL.Add('WHERE  D.CND_CODCND = :CODCND                                      ');      
      ParamByName('CODCND').AsString := qryTabela.FieldByName('CND_CODIGO').AsString;
      Open;

      If Not IsEmpty then
      Begin
        While Not EOF Do
        Begin
          With frmCadCondLinGru Do
          Begin
            cdsItens.Append;
            cdsItens.FieldByName('CODCND').AsString := FieldByName('CODCND').AsString;
            cdsItens.FieldByName('DESCND').AsString := FieldByName('DESCND').AsString;
            cdsItens.FieldByName('CODGRU').AsString := FieldByName('CODGRU').AsString;
            cdsItens.FieldByName('DESGRU').AsString := FieldByName('DESGRU').AsString;
            cdsItens.FieldByName('DESMAG').AsFloat  := FieldByName('DESMAG').AsFloat;
            cdsItens.FieldByName('DESMAS').AsFloat  := FieldByName('DESMAS').AsFloat;
            cdsItens.FieldByName('DESMAV').AsFloat  := FieldByName('DESMAV').AsFloat;
            cdsItens.FieldByName('DESMGM').AsFloat  := FieldByName('DESMGM').AsFloat;
            cdsItens.FieldByName('DESMSM').AsFloat  := FieldByName('DESMSM').AsFloat;
            cdsItens.FieldByName('DESMVM').AsFloat  := FieldByName('DESMVM').AsFloat;
            cdsItens.Post;
          End;

          Next;
        End;
      End;
    End;

    FreeAndNil(qryCndGru);

    frmCadCondLinGru.pInsereNovo;
    frmCadCondLinGru.ShowModal;
  Except
    On E: Exception Do
    Begin
      If Assigned(qryCndGru) Then
        FreeAndNil(qryCndGru);

      pMensagensErro(E.Message, 'Altera Registro');
    End;
  End;

  pFreeAndNil(frmCadCondLinGru);
end;

procedure TfrmCadCondicoes.btnDescMaxGlobalClick(Sender: TObject);
var
  frmCadCondLinGruGlobal: TfrmCadCondLinGruGlobal;
begin
  inherited;

  pCriarFormularios(TfrmCadCondLinGruGlobal, frmCadCondLinGruGlobal);

  try
    frmCadCondLinGruGlobal.ShowModal;
  finally
    pFreeAndNil(frmCadCondLinGruGlobal);
  end;
end;

procedure TfrmCadCondicoes.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrCnd: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE COND. PGTO *}
  {****************************RV*}
  chrKey := '/';
  If fPesqCondicoesPgto(Self, Nil, Nil, qryTabela, chrKey, arrCnd, True, False, IIF(fCfgSis('PFLCLI', varBoolean), conCndPerfil, conSimples)) Then
  Begin
    pCarregaDadosAdicionais;
    pSetFocus(btnAlterar);
  End;
  pMostraDiaFixo;
end;

procedure TfrmCadCondicoes.cbbDiaFixChange(Sender: TObject);
begin
  inherited;
  If qryTabela.Active Then
    pMostraLimite;
end;

procedure TfrmCadCondicoes.cbYapTraClick(Sender: TObject);
begin
  inherited;
  if not (dtsCadCnd.DataSet.State in dsEditModes) then
    Exit;

  cbYapDis.Enabled := cbYapTra.Checked;
  cbYapDis.Clear;
end;

procedure TfrmCadCondicoes.chkPermiteBoletoClick(Sender: TObject);
begin
  inherited;
  edtPmeDVc.Text := IfThen(chkPermiteBoleto.Checked,'7','0');
end;

procedure TfrmCadCondicoes.chkPermiteCartaoClick(Sender: TObject);
begin
  inherited;
  If Not chkPermiteCartao.Checked Then
  Begin
    edtPmeJct.Text                    := '0,01';
    cmbLimiteParcelas.ItemIndex       := 0;
    cmbQtdeParcelasSemJuros.ItemIndex := 0;
  End;
end;

procedure TfrmCadCondicoes.clbEmpCndClickCheck(Sender: TObject);
  Var
    strCodEmp: String;
begin
  inherited;

  If Not clbEmpCnd.Checked[clbEmpCnd.ItemIndex] Then
  Begin
    strCodEmp := LeftStr(clbEmpCnd.Items[clbEmpCnd.ItemIndex], 3);
    If (not fEmptyStr(fCfgSis('CNDPTE', varString, strCodEmp))) And (fCfgSis('CNDPTE', varString, strCodEmp) = dbeCodigo.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esta condição de pagamento está vinculada na configuração "'+'CFG_CNDPTE - '+fRetNomCfg('CNDPTE')+
                            '" portanto, não é possível retirar o acesso da empresa: '+strCodEmp, ['&Ok']);
      clbEmpCnd.Checked[clbEmpCnd.ItemIndex] := True;
    End;
  End
end;

procedure TfrmCadCondicoes.pLimparInformacoesPagarMe;
begin
  edtPmeJct.Text           := '0,01';
  edtPmeDVc.Text           := '0';

  chkPermiteBoleto.Checked := (fCfgSis('PMEHAB',varBoolean)) And
                              (gpbPagarMe.Visible);
  chkPermiteCartao.Checked := (fCfgSis('PMEHAB',varBoolean)) And
                              (gpbPagarMe.Visible);

  If (fCfgSis('PMEHAB',varBoolean)) Then
  Begin
    cmbLimiteParcelas.ItemIndex       := 0;
    cmbQtdeParcelasSemJuros.ItemIndex := 0;
    edtPmeDVc.Text                    := '7';
  End
  Else
  Begin
    cmbLimiteParcelas.ItemIndex       := -1;
    cmbQtdeParcelasSemJuros.ItemIndex := -1;
  End;
end;

procedure TfrmCadCondicoes.cmbLimiteParcelasSelect(Sender: TObject);
var
  intItem    : Integer;
  intPosicao : Integer;
begin
  inherited;
  intPosicao := cmbQtdeParcelasSemJuros.ItemIndex;

  cmbQtdeParcelasSemJuros.Clear;
  cmbQtdeParcelasSemJuros.Items.Add('QUANTIDADE PARCELAS SEM JUROS');

  For intItem := 1 To cmbLimiteParcelas.ItemIndex Do
  Begin
    If intItem = 1 Then
      cmbQtdeParcelasSemJuros.Items.Add('À vista')
    Else
      cmbQtdeParcelasSemJuros.Items.Add(Format('Até %s parcelas sem juros', [intItem.ToString]));
  End;

  If intPosicao <= Pred(cmbQtdeParcelasSemJuros.Items.Count) Then
    cmbQtdeParcelasSemJuros.ItemIndex := intPosicao
  Else
    cmbQtdeParcelasSemJuros.ItemIndex := 0;
end;

procedure TfrmCadCondicoes.FormShow(Sender: TObject);
  var
    blnCodaca  : Boolean;
    intCon     :integer;
    blnCndVen,
    blnUsaDeps,
    blnUsaAppCS: Boolean;
begin
  inherited;
  pgcDados.ActivePageIndex := 0;

  qryConPor := fCriaQuery(Self);
  pCarregaDadosAdicionais;

  If (Not (fCfgSis('EMPGER', varBoolean))) Then
  Begin
    btnIncluir.Enabled := False;
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
  End;

  gpbTpFtDa.Visible  := fCfgSis('TPDCEX') = '1';

  chkTipFatD.Visible := fCfgSis('SOLFNE') = 'S';
  chkTpFtDaD.Visible := fCfgSis('SOLFNE') = 'S';

  blnCodaca := fEmptyStr(fCfgSis('CODACA'));

  blnCndVen := fCfgSis('CNDVEN') = 'I';

  lblAltPre.Visible := blnCndVen;
  dbcAltPre.Visible := blnCndVen;

  lblValMin.Visible := Not blnCodaca;
  dbeValMin.Visible := Not blnCodaca;

  blnUsaDeps := fCfgSis('USADEP') = 'S';

  lblUsaDeps.Visible    := blnUsaDeps;
  lblUsaDeps_SN.Visible := blnUsaDeps;
  dbeUsaDeps.Visible    := blnUsaDeps;

  blnUsaAppCS := fCfgSis('APPSAL') = 'S';

  lblExpApp.Visible := blnUsaAppCS;
  dbeExpApp.Visible := blnUsaAppCS;
  clbExpApp.Visible := blnUsaAppCS;

  pnlRecebimentoPix.Visible := fCfgSis('USAPIX', varBoolean);

  cbbMoDiVn.ItemIndex := 2;
  cbbMoDiVn.Visible := False;
  lblMoDiVn.Visible := False;

  {*************************************}
  { HAB SOMENTE AS TABS CONFORME A CFG  }
  {**********************************JB*}
  If blnTabPre then
  Begin
    strVrfTpr := EmptyStr;

    For intCon:= 1 To Length(Trim(VS_strTabVen)) Do
    Begin
      strVrfTpr := strVrfTpr + IfThen(SameText(VS_strTabVen[intCon], 'S'), IntToStr(intCon), '');
      If SameText(VS_strTabVen[intCon], 'N') Then
        clbPreTab.ItemEnabled[intCon-1] := False;
    End;

    lblTabPre.Visible   := True;
    clbPreTab.Visible   := True;

  end
  else
  Begin
    lblTabPre.Visible   := False;
    clbPreTab.Visible   := False;
  End;

  If fAplicarTaxaJurosPrecoDigitado Then
  Begin
    lblAbaDes.Visible := False;
    dbeAbaDes.Visible := False;
    clbAbaDes.Visible := False;

    lblAbDeCc.Visible := False;
    dbeAbDeCc.Visible := False;
    clbAbDeCc.Visible := False;
  End;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadCondicoes.dbeCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqPortador(conSimples, Self, dbeCodPor, edtNomPor, qryConPor, Key, arrSel) Then
  Begin
    If fValidaCampos(dbeCodPor) Then
      Self.SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadCondicoes.dbeDesPflKeyPress(Sender: TObject; var Key: Char);
  Var
    strKey : String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];
  If (Key = #13) Then
  Begin
    Key := #0;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCondicoes.dbeGeraCobrancaPagarMeChange(Sender: TObject);
begin
  inherited;
  gpbPagarMe.Visible := (fCfgSis('PMEHAB',varBoolean)) And
                        (UpperCase(dbeGeraCobrancaPagarMe.Text) = 'S');
  pLimparInformacoesPagarMe;
end;

procedure TfrmCadCondicoes.dbeGeraCobrancaYapayChange(Sender: TObject);
begin
  inherited;
  if not (dtsCadCnd.State in dsEditModes) then
    Exit;

  if not Assigned(dbeGeraCobrancaYapay.Field) then
    Exit;

  if dbeGeraCobrancaYapay.Field.AsString = dbeGeraCobrancaYapay.Text then
    Exit;

  dbeGeraCobrancaYapay.Field.AsString := dbeGeraCobrancaYapay.Text;
end;

procedure TfrmCadCondicoes.dbeGeraCobrancaYapayEnter(Sender: TObject);
begin
  inherited;
  strValorOriginalGeracobrancaYapay := dbeGeraCobrancaYapay.Field.AsString;
end;

procedure TfrmCadCondicoes.dbeGeraCobrancaYapayExit(Sender: TObject);
var
  blnPerguntar: Boolean;
  strMensagemPergunta: string;
const
  strFORMA_PAGAMENTO_YAPAY = '007';
  strFORA_YAPAY = 'NENHUM';
begin
  inherited;
  If (dtsCadCnd.State In dsEditModes) and
     (dbeGeraCobrancaYapay.Field.AsString = Sim.ToFlag) and
     (dbeGeraCobrancaYapay.Field.AsString <> strValorOriginalGeracobrancaYapay) Then
  begin
    blnPerguntar :=
      (dbeCodFpg.Field.AsString <> strFORMA_PAGAMENTO_YAPAY) or
      (dbcTipFor.Field.AsString <> strFORA_YAPAY);

    if (not blnPerguntar) then
      exit;

    strMensagemPergunta :=
      'Para habilitar geração de cobrança Yapay ' +
      'serão realizados os seguintes ajustes. ' +
      'Forma Pagto: ' + strFORMA_PAGAMENTO_YAPAY + '-' + fRetDesFpg(strFORMA_PAGAMENTO_YAPAY) + ', ' +
      'Fora: ' + strFORA_YAPAY + sLineBreak +
      'Confirma as alterações para essa condição e Pagamento?';

    if (not blnPerguntar) or (not fPergunta(strMensagemPergunta)) then
    begin
      dbeGeraCobrancaYapay.Field.AsString := Nao.ToFlag;
      exit;
    end;

    if dbeCodFpg.Field.AsString <> strFORMA_PAGAMENTO_YAPAY then
    begin
      dbeCodFpg.Field.AsString := strFORMA_PAGAMENTO_YAPAY;
      fValidaCampos(dbeCodFpg);
    end;

    if dbcTipFor.Field.AsString <> strFORA_YAPAY then
      dbcTipFor.Field.AsString := strFORA_YAPAY;
  end;
end;

procedure TfrmCadCondicoes.dbeGeraLinkPgtoCieloChange(Sender: TObject);
begin
  inherited;
  if not (dtsCadCnd.State In dsEditModes) then
    Exit;

  dbeCodFpg.ReadOnly := False;

  if dbeGeraLinkPgtoCielo.Text = 'S' then
  begin
    dbeCodFpg.Field.AsString := '007';
    dbeCodFpgExit(Self);
    dbeCodFpg.ReadOnly := True;
  end;
end;

procedure TfrmCadCondicoes.dbeGeraLinkPgtoCrePayChange(Sender: TObject);
begin
  inherited;
  if not (dtsCadCnd.State In dsEditModes) then
    Exit;

  dbeCodFpg.ReadOnly := False;

  if dbeGeraLinkPgtoCredPay.Text = 'S' then
  begin
    dbeCodFpg.Field.AsString := '007';
    dbeCodFpgExit(Self);
    dbeCodFpg.ReadOnly := True;
  end;
end;

procedure TfrmCadCondicoes.dbeGeraLinkPgtoIpagChange(Sender: TObject);
begin
  inherited;
  if not (dtsCadCnd.State In dsEditModes) then
    Exit;

  dbeCodFpg.ReadOnly := False;

  if dbeGeraLinkPgtoIpag.Text = 'S' then
  begin
    dbeCodFpg.Field.AsString := '007';
    dbeCodFpgExit(Self);
    dbeCodFpg.ReadOnly := True;
  end;
end;

procedure TfrmCadCondicoes.dbeGeraLinkPgtoOnlineChange(Sender: TObject);
begin
  inherited;
  if not (dtsCadCnd.State In dsEditModes) then
    Exit;

  dbeCodFpg.ReadOnly := False;

  if dbeGeraLinkPgtoOnline.Text = 'S' then
  begin
    dbeCodFpg.Field.AsString := '007';
    dbeCodFpgExit(Self);
    dbeCodFpg.ReadOnly := True;
  end;
end;

procedure TfrmCadCondicoes.pCarregarTipoFaturamento;
begin
  chkTipFatA.Checked := Pos('A', qryTabela.FieldByName('CND_TIPFAT').AsString) > 0;
  chkTipFatB.Checked := (blnPermitirEmissaoFF) And (Pos('B', qryTabela.FieldByName('CND_TIPFAT').AsString) > 0);
  chkTipFatC.Checked := Pos('C', qryTabela.FieldByName('CND_TIPFAT').AsString) > 0;
  chkTipFatD.Checked := Pos('D', qryTabela.FieldByName('CND_TIPFAT').AsString) > 0;

  chkTpFtDaA.Checked := Pos('A', qryTabela.FieldByName('CND_TPFTDA').AsString) > 0;
  chkTpFtDaB.Checked := (blnPermitirEmissaoFF) And (Pos('B', qryTabela.FieldByName('CND_TPFTDA').AsString) > 0);
  chkTpFtDaC.Checked := Pos('C', qryTabela.FieldByName('CND_TPFTDA').AsString) > 0;
  chkTpFtDaD.Checked := Pos('D', qryTabela.FieldByName('CND_TPFTDA').AsString) > 0;
end;

procedure TfrmCadCondicoes.dtsCadCndDataChange(Sender: TObject; Field: TField);
var
  intIndice: integer;
  strTabelasPreco: string;
  strQuantidadeParcelas: string;
begin
  inherited;

  btnHeranca.Enabled := (Not qryTabela.IsEmpty) And (Not (dtsCadCnd.State In dsEditModes));

  If Not (dtsCadCnd.State In dsEditModes) Then
  Begin
    pCarregarTipoFaturamento;

    if (blnTabPre) then
    begin
      strTabelasPreco := qryTabela.FieldByName('CND_PRETAB').AsString;
      if not fEmptyStr(strTabelasPreco) then
      begin
        for intIndice := 1 to Length(strTabelasPreco) do
        begin
          clbPreTab.Checked[intIndice - 1] := strTabelasPreco[intIndice] = 'S';
        end;
      end;
    end;

    if pnlEspFat.Visible then
      dbcEspFat.ItemIndex := dbcEspFat.Items.IndexOf(qryTabela.FieldByName('CND_ESPFAT').AsString);
  End;

  if (fCfgSis('YAPHAB',varBoolean)) then
  begin
    dbeCodFpg.Enabled := dbeGeraCobrancaYapay.Text <> Sim.ToFlag;
    dbcTipFor.Enabled := dbeCndPag.Enabled;

    gpbConfiguracoesYapay.Visible := dbeGeraCobrancaYapay.Text = Sim.ToFlag;
    cbYapTra.Visible := gpbConfiguracoesYapay.Visible;

    cbYapDis.Enabled := (cbYapTra.Checked) and (dtsCadCnd.DataSet.State in dsEditModes);

    edtYapPar.Enabled := False;

    if (dtsCadCnd.DataSet.State in dsEditModes) then
    begin
      if (dbeGeraCobrancaYapay.Text <> Sim.ToFlag) and cbYapTra.Checked then
        cbYapTra.Checked := False;

      if cbYapTra.Checked then
      begin
        strQuantidadeParcelas := Copy(dbeCndPag.Text,1,2);
        if (StrToIntDef(strQuantidadeParcelas, 0) = 0) then
        begin
          if (not qryTabela.FieldByName('CND_YAPPAR').IsNull) then
            qryTabela.FieldByName('CND_YAPPAR').Clear;
        end
        else if qryTabela.FieldByName('CND_YAPPAR').AsInteger <> StrToIntDef(strQuantidadeParcelas, 0) then
          qryTabela.FieldByName('CND_YAPPAR').AsString := strQuantidadeParcelas;
      end
      else
      begin
        if (not qryTabela.FieldByName('CND_YAPPAR').IsNull) then
          qryTabela.FieldByName('CND_YAPPAR').Clear;

        if not qryTabela.FieldByName('CND_YAPDIS').IsNull then
          qryTabela.FieldByName('CND_YAPDIS').Clear;

        if not TYapayFacade.TcxCheckComboBox(cbYapDis).Value.IsEmpty then
          TYapayFacade.TcxCheckComboBox(cbYapDis).Clear;
      end
    end;

    if (not Assigned(Field)) or (qryTabela.FieldByName('CND_YAPDIS').FieldName = Field.FieldName) then
    begin
      if TYapayFacade.TcxCheckComboBox(cbYapDis).Value <> qryTabela.FieldByName('CND_YAPDIS').AsString then
        TYapayFacade.TcxCheckComboBox(cbYapDis).Value := qryTabela.FieldByName('CND_YAPDIS').AsString;
    end;

  end;
end;

procedure TfrmCadCondicoes.dtsCadCndStateChange(Sender: TObject);
begin
  inherited;
  gpbTipFat.Enabled := (dtsCadCnd.State in dsEditModes);
  gpbTpFtDa.Enabled := (dtsCadCnd.State in dsEditModes);
  if blnTabPre then
  begin
    clbPreTab.Enabled := (dtsCadCnd.State in dsEditModes);
  end;
end;

function TfrmCadCondicoes.dbeCodPorChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadPor(Key);

end;

procedure TfrmCadCondicoes.dbeCodPorExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(dbeCodPor.Text) Then
  Begin
    edtNomPor.Clear;
    qryTabela.FieldByName('CND_CODPOR').Value := Null;
  End
  Else
    pCarregaPortador;
end;

procedure TfrmCadCondicoes.dbeCodFpgKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrForma: TConsultasArray;
begin
  inherited;
  {***********************************}
  {* NOVA CONSULTA DE FORMA DE PAGTO *}
  {********************************RV*}
  If fPesqFormaPgto(conFpgSimples, Self, dbeCodFpg, edtDesFpg, Nil, Key, arrForma) Then
  Begin
    If fValidaCampos(dbeCodFpg, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCondicoes.dbcTipForChange(Sender: TObject);
begin
  inherited;
  pMostraDiaFixo;
  pTrataCampoQtdMax();
end;

procedure TfrmCadCondicoes.dbcUsaDFxClick(Sender: TObject);
begin
  inherited;
  pMostraDiaFixo;
end;

procedure TfrmCadCondicoes.dbeCodFpgExit(Sender: TObject);
begin
  inherited;

  If fEmptyStr(dbeCodFpg.Text) Then
  Begin
    edtDesFpg.Clear;
    qryTabela.FieldByName('CND_CODFPG').Value := Null;
  End
  Else
    edtDesFpg.Text := fRetDesFpg(dbeCodFpg.Text);

  pExibirMaximoParcelasCartao;
  pCarregaModalidadeFormaPagamento;

  chkNaoValidaDin.Enabled := (dbeCodFpg.Field.AsString = '009');
  chkNaoValidaChq.Enabled := (dbeCodFpg.Field.AsString = '009');
  chkNaoValidaCar.Enabled := (dbeCodFpg.Field.AsString = '009');

  If Not chkNaoValidaDin.Enabled Then chkNaoValidaDin.Checked := False;
  If Not chkNaoValidaChq.Enabled Then chkNaoValidaChq.Checked := False;
  If Not chkNaoValidaCar.Enabled Then chkNaoValidaCar.Checked := False;

end;

procedure TfrmCadCondicoes.pMarcarDesmarcarEmpresas(blnMarcar: Boolean);
  Var
    intCnt : Integer;
    strCodEmp: String;
    strResult: String;
begin
  strResult := '';

  For intCnt := 0 To clbEmpCnd.Count -1 Do
  Begin
    If blnMarcar Then
    Begin
      clbEmpCnd.Checked[intCnt] := True;
    End
    Else
    Begin
      strCodEmp := LeftStr(clbEmpCnd.Items[intCnt], 3);
      If fCfgSis('CNDPTE', varString, strCodEmp) = dbeCodigo.Text Then
        strResult := strResult + strCodEmp + '_'
      Else
        clbEmpCnd.Checked[intCnt] := False;
    End;
  End;

  If Not fEmptyStr(strResult) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esta condição de pagamento está vinculada na configuração "'+'CFG_CNDPTE - '+fRetNomCfg('CNDPTE')+
                          '" portanto, não é possível retirar o acesso da(s) empresa(s): '+strResult, ['&Ok'], 1, False, 1, 0, False, 0, False, False, False, 250);
  End;
end;

procedure TfrmCadCondicoes.pMostraDiaFixo;
  var
    blnHabilita: Boolean;
begin
  If Not qryTabela.Active Then
    Exit;

  blnHabilita := qryTabela.State In [dsEdit, dsInsert];

  pnlDiaFix.Visible := (dbcTipFor.Text = 'DIA FIXO');

  dbeCndPag.Enabled := Not pnlDiaFix.Visible And blnHabilita;

  cbbDiaFix.ItemIndex := 0;

  If Not qryTabela.FieldByName('CND_DIAFIX').IsNull Then
    cbbDiaFix.ItemIndex := qryTabela.FieldByName('CND_DIAFIX').AsInteger;

  If blnHabilita Then
  Begin
    If Not pnlDiaFix.Visible Then
    Begin
      dbcSemEnt.Field.AsString  := 'N';
      spnLimite.DataBinding.Field.AsInteger := 0;
      dbeQtdPar.Field.Clear;
      qryTabela.FieldByName('CND_DIAFIX').Clear;
      qryTabela.FieldByName('CND_DIACOR').AsString := 'N';
    End
    Else
      dbeCndPag.Field.Clear;
  End;

  pMostraLimite;
end;

procedure TfrmCadCondicoes.pMostraLimite;
begin
  spnLimite.Visible := (cbbDiaFix.ItemIndex > 0) And (dbcSemEnt.Field.AsString = 'S');
  lblLimite.Visible := spnLimite.Visible;
  btnLimite.Visible := spnLimite.Visible;
  dbcDiaCor.Visible := spnLimite.Visible;
end;

procedure TfrmCadCondicoes.pSetFocusLinkPgto;
begin
  if fCfgSis('LINKPG') = '2' then
    pSetFocus(dbeGeraLinkPgtoOnline)
  else if fCfgSis('LINKPG') = '3' then
    pSetFocus(dbeGeraLinkPgtoCielo)
  else if fCfgSis('LINKPG') = '5' then
    pSetFocus(dbeGeraLinkPgtoCredPay)
  else if fCfgSis('LINKPG') = '7' then
    pSetFocus(dbeGeraLinkPgtoIpag);
end;

procedure TfrmCadCondicoes.pTrataCampoQtdMax;
begin
  dbeQtdMax.Enabled := (dbcTipFor.Text = 'OUTROS');

  if not (dbeQtdMax.DataSource.DataSet.State in dsEditModes) then
    exit;

  If (dbeQtdMax.Enabled) then
    exit;

  dbeQtdMax.Field.AsInteger := 0;
end;

procedure TfrmCadCondicoes.rdgEmiBolChange(Sender: TObject);
begin
  inherited;

  fValidaCampos(rdgEmiBol);
end;

procedure TfrmCadCondicoes.rdgMCobDaEnter(Sender: TObject);
begin
  inherited;
  If rdgMCobDa.ItemIndex = -1 Then rdgMCobDa.ItemIndex := 0;
  pSetFocus(TRadioButton(rdgMCobDa.Controls[rdgMCobDa.ItemIndex]));
end;

function TfrmCadCondicoes.fGetEmpSelecao: String;
  Var
    intCnt : Integer;
begin
  Result := '';
  For intCnt := 0 To clbEmpCnd.Count -1 Do
  Begin
    If (clbEmpCnd.Checked[intCnt]) Then
      Result := Result + LeftStr(clbEmpCnd.Items.Strings[intCnt], 3) + '_';
  End;
end;

function TfrmCadCondicoes.fInformaTabelasSelecionadas: string;
var
  intIndice: integer;
begin
  Result := '';
  for intIndice := 0 to 6 do
  begin
    if clbPreTab.Checked[intIndice] then
    begin
      Result := Result + IntToStr(intIndice + 1);
    end;
  end;
end;

function TfrmCadCondicoes.fPossuiVinculoIntegracao(ADeletando: Boolean = False): Boolean;
const
  TABELAS_INT: Array[0..5] of String = ('HUBCIT_CADGTY', 'VTEX_CADGTY', 'ECOMM_CADGTY', 'TRAY_CADGTY', 'TRAYC_CADGTY', 'INTEGR_CADGTY');
var
  LTabela: String;
  LQry: TUniQuery;
begin
  Result := False;

  if (qryTabela.State = dsInsert) then
    Exit;

  if (not ADeletando) and (Pos(dbeCodFpg.Text, '007_008_009_013_') > 0) then
    Exit;

  LQry := fCriaQuery;

  try
    for LTabela in TABELAS_INT do
    begin
      if (not fTabelaExiste(LTabela)) then
        Continue;

      if (not fCampoExiste(LTabela, 'GTY_CODCND', True)) then
        Continue;

      LQry.Close;
      LQry.SQL.Clear;
      LQry.SQL.Add('SELECT COUNT(1) QTD ');
      LQry.SQL.Add('FROM ' + LTabela);
      LQry.SQL.Add('WHERE GTY_CODCND = :CODCND ');
      LQry.ParamByName('CODCND').AsString := qryTabela.FieldByName('CND_CODIGO').AsString;
      LQry.Open;

      Result := (LQry.FieldByName('QTD').AsInteger > 0);
    end;
  finally
    FreeAndNil(LQry);
  end;
end;

function TfrmCadCondicoes.fTabelasConfiguradas(strTabelas,
  strCfgTabelas: string; var strTabelasRetorno: string): Boolean;
var
  I,
  intIndice: integer;
begin
  Result := True;
  strTabelasRetorno := EmptyStr;

  for intIndice := 1 to length(strTabelas) do
  begin
    if Pos(strTabelas[intIndice],strCfgTabelas) <= 0 then
    begin
      for I := 1 to Length(strCfgTabelas) do
      begin
        strTabelasRetorno := strTabelasRetorno + ' ('+strCfgTabelas[I]+') ';
      end;
      Result := False;
      Exit;
    end;
  end;
end;

function TfrmCadCondicoes.fTemLinkPagamentoHabilitadoNestaCondicao: Boolean;
begin
  Result := True;

  if (dbeGeraLinkPgtoOnline.Text <> 'S') and
     (dbeGeraLinkPgtoCielo.Text <> 'S') and
     (dbeGeraLinkPgtoCredPay.Text <> 'S') and
     (dbeGeraLinkPgtoIpag.Text <> 'S') then
    Result := False;
end;

function TfrmCadCondicoes.fTemLinkPagamentoCieloLigadaQualquerEmpresa: Boolean;
var
  LqryConsulta: TUniQuery ;
begin
  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add('SELECT SIS_CODEMP FROM CFGSIS WHERE SIS_CODCFG = "CFG_LINKPG" AND SIS_VALCFG = "3"') ;
    LqryConsulta.Open ;

    Result := LqryConsulta.RecordCount > 0 ;

  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end;

function TfrmCadCondicoes.fTemLinkPagamentoCredPayLigadaQualquerEmpresa: Boolean;
var
  LqryConsulta: TUniQuery ;
begin
  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add('SELECT SIS_CODEMP FROM CFGSIS WHERE SIS_CODCFG = "CFG_LINKPG" AND SIS_VALCFG = "5"') ;
    LqryConsulta.Open ;

    Result := LqryConsulta.RecordCount > 0 ;

  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end;

function TfrmCadCondicoes.fTemLinkPagamentoIpagLigadaQualquerEmpresa: Boolean;
var
  LqryConsulta: TUniQuery ;
begin
  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add('SELECT SIS_CODEMP FROM CFGSIS WHERE SIS_CODCFG = "CFG_LINKPG" AND SIS_VALCFG = "7"') ;
    LqryConsulta.Open ;

    Result := LqryConsulta.RecordCount > 0 ;

  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end;

function TfrmCadCondicoes.fTemLinkPagamentoSiTefLigadaQualquerEmpresa: Boolean;
var
  LqryConsulta: TUniQuery ;
begin
  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close ;
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add('SELECT SIS_CODEMP FROM CFGSIS WHERE SIS_CODCFG = "CFG_LINKPG" AND SIS_VALCFG = "2"') ;
    LqryConsulta.Open ;

    Result := LqryConsulta.RecordCount > 0 ;

  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end;

function TfrmCadCondicoes.fVaiParaProximaAba(Sender: TWinControl): Boolean;
  Var
    WinControl : TWinControl;
    strNomeControle : String;
begin
  WinControl := FindNextControl(Sender, True, True, False);

  If WinControl <> Nil Then
    strNomeControle := WinControl.Name
  Else
    strNomeControle := '';

  If Not fEmptyStr(strNomeControle) Then
    Result := Not fAchaControle(pgcDados.Pages[pgcDados.ActivePageIndex], strNomeControle)
  Else
    Result := False;

  If (Result) Then
    pProximaPagina;
end;

end.


