{***************************}
{* qryConCli -> CADCLI/FOR *}
{* qryConCid -> CADCID     *}
{* qryCidEmp -> CADCID     *}
{* qryConCfo -> CADCFO     *}
{************************JB*}
{***************************}
{* qryCadCid -> CADCID     *}
{************************RV*}
unit untCadLivroFiscal;

interface

uses
  Classes, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, Buttons, ExtCtrls,
  Mask, DBCtrls, DBEditFocus, QColorLabel, Menus, EditFocus, Grids, DBGridCitel, DBGrids, DB,
  Uni, Windows, AppEvnts, CurrencyEditFocus, untGeralPisCofins, BitBtnLockedIncrem,
  MemDS, DBAccess, frxClass, frxExportCSVTestabilidade, ComboBoxFocus, system.generics.collections,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator, cxDBData, untCadImpostosNFS,
  Datasnap.Provider, UniDataSetProvider, Datasnap.DBClient, UniClientDataSet,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, SysUtils, DateUtils,
  MaskEditFocus, cxDataControllerConditionalFormattingRulesManagerDialog, untTypesSistema,
  untFuncoesSimples, untLiberacao, untEntPagtoAntecipado, untFechamentoFiscal, cxCurrencyEdit,
  DBMemoFocus, untFraPessoasCte, untCadCtaPagarPrevisao, untFechamentoEstoque, untCadOcorrenciasGia,
  untConsultarFinanceiro, cxContainer, cxTextEdit, cxMaskEdit, cxDBEdit, cxButtonEdit,
  cxEditRepositoryItems, untFrmManipulaContasPagarPrevisaoNao,
  untTLock, Winapi.Messages, untGerenciadorTabOrder, untFuncoes;

const HeightComValor = 36;
      HeightSemValor =  18;


type
  TRecChaveAcesso = Record
  private
    FAutorizado: Boolean;
    FValor: String;
    FValidarAlteracao: Boolean;
    FCodCli,
    FNumDoc,
    FEspDoc,
    FSerie_,
    FTip_FC,
    FCodEmp: String;
    procedure pSetValor(const pValor: String);
    function fChaveAutorizada(pstrChvAce: String): Boolean;
  public
    constructor Create(pValidarAlteracao: Boolean;
                       pstrNumDoc: String = '';
                       pstrEspDoc: String = '';
                       pstrSerie_: String = '';
                       pstrCodCli: String = '';
                       pstrTip_FC: String = '';
                       pstrCodEmp: String = '';
                       pstrChvAce: String = '');
    property Autorizado: Boolean Read FAutorizado;
    function AlterouChaveAutorizada(const pstrChaveAcesso: String): Boolean;
  end;

type
  TValoresIniciaisItens = record
    Edit: TEdit;
    Value: string;
  End;

  TArrValoresIniciaisItens = array of TValoresIniciaisItens;

  TfrmCadLivroFiscal = class(TfrmPaiCad)
    pnlGeral: TPanel;
    Label1: TLabel;
    lblTip_fc: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    dbeNumDoc: TDBEditFocus;
    dbeNumDo2: TDBEditFocus;
    Label12: TLabel;
    dbeEntSai: TDBEditFocus;
    dbeTip_Fc: TDBEditFocus;
    dbeForCli: TDBEditFocus;
    dbeDtaDoc: TDBEditFocus;
    Label13: TLabel;
    dbeDtaEnt: TDBEditFocus;
    dbeEspDoc: TDBEditFocus;
    Label14: TLabel;
    dbeNfComp: TDBEditFocus;
    qryFisItensTOTFRE_ITE: TFloatField;
    qryFisItensDESACE_ITE: TFloatField;
    qryFisItensVLRCON_ITE: TFloatField;
    Label15: TLabel;
    pgcDetalhes: TPageControl;
    ColorLabel2: TColorLabel;
    Label4: TLabel;
    edtNomFor: TEditFocus;
    edtCidade: TEditFocus;
    edtNumCep: TEditFocus;
    tbsDocs: TTabSheet;
    dbeClfSc5: TDBEditFocus;
    dbeVlCon5: TDBEditFocus;
    dbeBasIc5: TDBEditFocus;
    dbeAlqIc5: TDBEditFocus;
    dbeVlrIc5: TDBEditFocus;
    dbeOutra5: TDBEditFocus;
    dbeIsent5: TDBEditFocus;
    dbeBcret5: TDBEditFocus;
    dbeRetid5: TDBEditFocus;
    dbeBasIp5: TDBEditFocus;
    dbeVlrIp5: TDBEditFocus;
    dbeVlrIp4: TDBEditFocus;
    dbeBasIp4: TDBEditFocus;
    dbeRetid4: TDBEditFocus;
    dbeBcret4: TDBEditFocus;
    dbeIsent4: TDBEditFocus;
    dbeOutra4: TDBEditFocus;
    dbeVlrIc4: TDBEditFocus;
    dbeAlqIc4: TDBEditFocus;
    dbeBasIc4: TDBEditFocus;
    dbeVlCon4: TDBEditFocus;
    dbeClfSc4: TDBEditFocus;
    dbeClfSc3: TDBEditFocus;
    dbeVlCon3: TDBEditFocus;
    dbeBasIc3: TDBEditFocus;
    dbeAlqIc3: TDBEditFocus;
    dbeVlrIc3: TDBEditFocus;
    dbeOutra3: TDBEditFocus;
    dbeIsent3: TDBEditFocus;
    dbeBcret3: TDBEditFocus;
    dbeRetid3: TDBEditFocus;
    dbeBasIp3: TDBEditFocus;
    dbeVlrIp3: TDBEditFocus;
    dbeVlrIp2: TDBEditFocus;
    dbeBasIp2: TDBEditFocus;
    dbeRetid2: TDBEditFocus;
    dbeBcret2: TDBEditFocus;
    dbeIsent2: TDBEditFocus;
    dbeOutra2: TDBEditFocus;
    dbeVlrIc2: TDBEditFocus;
    dbeAlqIc2: TDBEditFocus;
    dbeBasIc2: TDBEditFocus;
    dbeVlCon2: TDBEditFocus;
    dbeClfSc2: TDBEditFocus;
    dbeClfSc1: TDBEditFocus;
    dbeVlCon1: TDBEditFocus;
    dbeBasIc1: TDBEditFocus;
    dbeAlqIc1: TDBEditFocus;
    dbeVlrIc1: TDBEditFocus;
    dbeOutra1: TDBEditFocus;
    dbeIsent1: TDBEditFocus;
    dbeBcret1: TDBEditFocus;
    dbeRetid1: TDBEditFocus;
    dbeBasIp1: TDBEditFocus;
    dbeVlrIp1: TDBEditFocus;
    Label25: TLabel;
    Label24: TLabel;
    Label22: TLabel;
    Label21: TLabel;
    Label20: TLabel;
    Label19: TLabel;
    Label18: TLabel;
    Label17: TLabel;
    Label16: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    tbsItens: TTabSheet;
    pnlItens: TPanel;
    qryFisItens: TUniQuery;
    dtsFisItens: TDataSource;
    qryFisItensCODITE: TStringField;
    qryFisItensDESCRI: TStringField;
    qryFisItensQTDITE: TFloatField;
    qryFisItensUNITAR: TFloatField;
    qryFisItensTOTITE: TFloatField;
    qryFisItensCODFIS: TStringField;
    qryFisItensCLAFIS: TStringField;
    qryFisItensBASICM: TFloatField;
    qryFisItensALQICM: TFloatField;
    qryFisItensVALICM: TFloatField;
    qryFisItensBASIPI: TFloatField;
    qryFisItensALQIPI: TFloatField;
    qryFisItensVALIPI: TFloatField;
    qryFisItensVTOTAL: TFloatField;
    qryFisItensDESFIS: TStringField;
    qryFisItensDESCLA: TStringField;
    qryFisItensBFCPST: TFloatField;
    qryFisItensPFCPST: TFloatField;
    qryFisItensVFCPST: TFloatField;
    Label40: TLabel;
    dbeCodEmp: TDBEditFocus;
    edtDesEmp: TEditFocus;
    Label41: TLabel;
    dbeChaveAcesso: TDBEditFocus;
    tbsImpostos: TTabSheet;
    chkCNHREC: TDBCheckBox;
    Bevel1: TBevel;
    Panel2: TPanel;
    dtsTabela: TDataSource;
    qryFisItensVALRET: TFloatField;
    qryFisItensBASRET: TFloatField;
    qryFisItensVLRCON: TFloatField;
    qryFisItensAUTOINCREM: TStringField;
    qryFisItensVALFRE: TFloatField;
    qryFisItensDESACE: TFloatField;
    pgcAjustes: TTabSheet;
    qryFisItensCSTPIS: TStringField;
    qryFisItensBASPIS: TFloatField;
    qryFisItensALQPIS: TFloatField;
    qryFisItensVALPIS: TFloatField;
    qryFisItensNR_PIS: TStringField;
    qryFisItensCSTCOF: TStringField;
    qryFisItensBASCOF: TFloatField;
    qryFisItensALQCOF: TFloatField;
    qryFisItensVALCOF: TFloatField;
    qryFisItensNR_COF: TStringField;
    dbeBasAn1: TDBEditFocus;
    dbeAntIc1: TDBEditFocus;
    dbeBasAn2: TDBEditFocus;
    dbeAntIc2: TDBEditFocus;
    dbeBasAn3: TDBEditFocus;
    dbeAntIc3: TDBEditFocus;
    dbeBasAn4: TDBEditFocus;
    dbeAntIc4: TDBEditFocus;
    dbeBasAn5: TDBEditFocus;
    dbeAntIc5: TDBEditFocus;
    Label59: TLabel;
    Label60: TLabel;
    qryFisItensBASANT: TFloatField;
    qryFisItensVALANT: TFloatField;
    qryFisItensOUTICM: TFloatField;
    qryFisItensISEICM: TFloatField;
    qryFisItensBAEIPI: TFloatField;
    qryFisItensALEIPI: TFloatField;
    qryFisItensVAEIPI: TFloatField;
    btnReconstruir: TBitBtnLocked;
    btnAltData: TBitBtnLocked;
    btnAlterarSerie: TBitBtnLocked;
    btnAltEspecie: TBitBtnLocked;
    btnAltFor: TBitBtnLocked;
    qryFisItensDESESP: TFloatField;
    btnRefresh: TBitBtnLocked;
    qryFisItensVAERET: TFloatField;
    qryFisItensBAERET: TFloatField;
    ColorLabel3: TColorLabel;
    dbeNfComple: TDBEditFocus;
    qryFisItensDESABF: TStringField;
    strngfldFisItensRICMPR: TStringField;
    qryFisItensPERRED: TFloatField;
    lblWarningCfopInvalida: TLabel;
    tbsServico: TTabSheet;
    lblCodAju: TLabel;
    lblDesAju: TLabel;
    lblBasIcm: TLabel;
    lblAlqIcm: TLabel;
    lblValIcm: TLabel;
    lblOutros: TLabel;
    dbgrFisAju: TDBGridCitel;
    btnIncluirFisAju: TBitBtnLocked;
    btnGravarFisAju: TBitBtnLocked;
    btnAlterarFisAju: TBitBtnLocked;
    btnExcluirFisAju: TBitBtnLocked;
    btnCancelarFisAju: TBitBtnLocked;
    edtCodAju: TDBEditFocus;
    edtBasIcm: TDBEditFocus;
    edtAlqIcm: TDBEditFocus;
    edtValIcm: TDBEditFocus;
    edtOutros: TDBEditFocus;
    dtsFisAju: TDataSource;
    qryFisAju: TUniQuery;
    qryFisAjuAUTOINCREM: TStringField;
    qryFisAjuAJU_SEQGER: TStringField;
    qryFisAjuAJU_CD_AJU: TStringField;
    qryFisAjuAJU_DESAJU: TStringField;
    qryFisAjuAJU_BASICM: TFloatField;
    qryFisAjuAJU_ALQICM: TFloatField;
    qryFisAjuAJU_VALICM: TFloatField;
    qryFisAjuAJU_OUTROS: TFloatField;
    edtEstado: TEditFocus;
    Label5: TLabel;
    dbeNfCstEnt: TDBEditFocus;
    btnDifal: TBitBtnLocked;
    lblCgcCpf: TLabel;
    edtCgcCpf: TMaskEdit;
    qryFisItensICD_BCUFDE: TFloatField;
    qryFisItensICD_PERFCP: TFloatField;
    qryFisItensICD_ALQUFD: TFloatField;
    qryFisItensICD_ALQINE: TFloatField;
    qryFisItensICD_PERPAR: TFloatField;
    qryFisItensICD_VALFCP: TFloatField;
    qryFisItensICD_VALDES: TFloatField;
    qryFisItensICD_VALORI: TFloatField;
    qryFisItensICD_TEMICD: TStringField;
    Label81: TLabel;
    ColorLabel1: TColorLabel;
    ColorLabel4: TColorLabel;
    dbeSubSerie: TDBEditFocus;
    qryFisItensAUX_DESINC: TStringField;
    qryFisItensAUX_VENPRE: TStringField;
    lblCTComVen: TColorLabel;
    dbeCTComVen: TDBEditFocus;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    DBEVAERET5: TDBEditFocus;
    DBEVAEIPI5: TDBEditFocus;
    DBEVAEIPI4: TDBEditFocus;
    DBEVAERET4: TDBEditFocus;
    DBEVAERET3: TDBEditFocus;
    DBEVAEIPI3: TDBEditFocus;
    DBEVAEIPI2: TDBEditFocus;
    DBEVAERET2: TDBEditFocus;
    DBEVAERET1: TDBEditFocus;
    DBEVAEIPI1: TDBEditFocus;
    dbeBaeRe5: TDBEditFocus;
    dbeBaeRe4: TDBEditFocus;
    dbeBaeRe3: TDBEditFocus;
    dbeBaeRe2: TDBEditFocus;
    dbeBaeRe1: TDBEditFocus;
    dbeBaeIP1: TDBEditFocus;
    dbeBaeIP2: TDBEditFocus;
    dbeBaeIP3: TDBEditFocus;
    dbeBaeIP4: TDBEditFocus;
    dbeBaeIP5: TDBEditFocus;
    tbsAcumContDom: TTabSheet;
    dbgDomAcu: TDBGridCitel;
    GroupBox2: TGroupBox;
    Label87: TLabel;
    edtCodAcu: TEditFocus;
    edtPerAcu: TEditFocus;
    Label88: TLabel;
    Label89: TLabel;
    cbxClaFisAcu: TComboBoxFocus;
    btnConfAcumulador: TBitBtnLocked;
    dtsDomAcu: TDataSource;
    cdsDomAcu: TUniClientDataSet;
    cdsDomAcuAUTOINCREM: TStringField;
    cdsDomAcuACU_SEQFIS: TStringField;
    cdsDomAcuACU_CLAFIS: TStringField;
    cdsDomAcuACU_ALQICM: TFloatField;
    cdsDomAcuACU_CODACU: TStringField;
    cdsDomAcuACU_PERACU: TFloatField;
    cdsDomAcuACU_CODEMP: TStringField;
    tbsDadosCpl: TTabSheet;
    lblInfCpl: TLabel;
    lblInfAdiFisco: TLabel;
    memInfCpl: TMemo;
    memInfAdicFisco: TMemo;
    qryFisItensBCR158: TFloatField;
    qryFisItensVLR158: TFloatField;
    qryFisItensVICMDE: TFloatField;
    Label93: TLabel;
    dbeAcenfo: TDBEditFocus;
    Label94: TLabel;
    dbeProtoc: TDBEditFocus;
    tbsNotaAssociadoComplemento: TTabSheet;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    edtNumeroNfComplementar: TEditFocus;
    edtEspecieNfComplementar: TEditFocus;
    edtParticipanteNfComplementar: TEditFocus;
    edtSerieNfComplementar: TEditFocus;
    edtNomPartNfComplementar: TEditFocus;
    mskDataNfComplementar: TMaskEditFocus;
    btnPesquisarNfEntrada: TBitBtnLocked;
    btnExcluirNfComplementar: TBitBtnLocked;
    qryFisItensBCI158: TFloatField;
    qryFisItensALI158: TFloatField;
    qryFisItensVLI158: TFloatField;
    edtDesAju: TEditFocus;
    lblCodMod: TLabel;
    cbxCodMod: TComboBoxFocus;
    chkNfExtemporanea: TCheckBox;
    Label104: TLabel;
    Label105: TLabel;
    DBEVFCPS1: TDBEditFocus;
    DBEFCPST1: TDBEditFocus;
    DBEVFCPS2: TDBEditFocus;
    DBEFCPST2: TDBEditFocus;
    DBEVFCPS3: TDBEditFocus;
    DBEFCPST3: TDBEditFocus;
    DBEVFCPS4: TDBEditFocus;
    DBEFCPST4: TDBEditFocus;
    DBEVFCPS5: TDBEditFocus;
    DBEFCPST5: TDBEditFocus;
    qryFisItensICD_BASFCP: TFloatField;
    Label43: TLabel;
    DBEBAFCP1: TDBEditFocus;
    DBEBAFCP2: TDBEditFocus;
    DBEBAFCP3: TDBEditFocus;
    DBEBAFCP4: TDBEditFocus;
    DBEBAFCP5: TDBEditFocus;
    Label109: TLabel;
    DBEVLFCP1: TDBEditFocus;
    DBEVLFCP2: TDBEditFocus;
    DBEVLFCP3: TDBEditFocus;
    DBEVLFCP4: TDBEditFocus;
    DBEVLFCP5: TDBEditFocus;
    grpEnergiaEletrica: TGroupBox;
    lblCodigoClasseConsumoEnergiaEletrica: TLabel;
    lblCodGrupTensao: TLabel;
    cmbCodClaConEnergiaEletrica: TComboBoxFocus;
    cmbCodGrupTensao: TComboBoxFocus;
    GroupBox14: TGroupBox;
    LabelBasePis: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    LabelBaseCofins: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    LabelCstCofins: TLabel;
    LabelCstPis: TLabel;
    dbeBasPis: TDBEditFocus;
    dbeTotPis: TDBEditFocus;
    dbeBasCof: TDBEditFocus;
    dbeTotCof: TDBEditFocus;
    dbeAlqPis: TDBEditFocus;
    dbeAlqCof: TDBEditFocus;
    dbeNatRecCof: TDBEditFocus;
    dbeNatRecPis: TDBEditFocus;
    dbeCstCof: TDBEditFocus;
    dbeCstPis: TDBEditFocus;
    grpCupomFiscal: TGroupBox;
    dbeNumSer: TDBEditFocus;
    lblNumSer: TLabel;
    lblNumCoo: TLabel;
    dbeNumCoo: TDBEditFocus;
    lblCodCon: TLabel;
    dbeCodCon: TDBEditFocus;
    Panel1: TPanel;
    GroupBox4: TGroupBox;
    Label32: TLabel;
    Label33: TLabel;
    dbeCodFis: TEditFocus;
    edtDesCodFis: TEditFocus;
    dbeClaFis: TEditFocus;
    Panel3: TPanel;
    GroupBox7: TGroupBox;
    Label35: TLabel;
    Label37: TLabel;
    Label39: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    dbeBasIPI: TEditFocus;
    dbeAlqIPI: TEditFocus;
    dbeValipi: TEditFocus;
    dbeBaeIPI: TEditFocus;
    dbeAleIpi: TEditFocus;
    dbeVaeIpi: TEditFocus;
    GroupBox8: TGroupBox;
    Label57: TLabel;
    Label48: TLabel;
    Label50: TLabel;
    Label52: TLabel;
    Label56: TLabel;
    Label55: TLabel;
    Label53: TLabel;
    Label51: TLabel;
    Label54: TLabel;
    Label49: TLabel;
    edtIteCstPis: TEditFocus;
    edtIteBasPis: TEditFocus;
    edtIteAlqPis: TEditFocus;
    edtIteValPis: TEditFocus;
    edtIteCstCof: TEditFocus;
    edtIteBasCof: TEditFocus;
    edtIteAlqCof: TEditFocus;
    edtIteValCof: TEditFocus;
    edtIteNatRecPis: TEditFocus;
    edtIteNatRecCof: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    dbeValFreItens: TEditFocus;
    dbeValFre: TEditFocus;
    dbeDesAce: TEditFocus;
    Label66: TLabel;
    edtDesAbf: TEditFocus;
    dbgItens: TcxGridCitel;
    dbgItensDBTableViewCitel1: TcxGridDBTableViewCitel;
    dbgItensLevel1: TcxGridLevel;
    dbgItensDBTableViewCitel1CODITE: TcxGridDBColumn;
    dbgItensDBTableViewCitel1DESCRI: TcxGridDBColumn;
    dbgItensDBTableViewCitel1QTDITE: TcxGridDBColumn;
    dbgItensDBTableViewCitel1TOTITE: TcxGridDBColumn;
    dbgItensDBTableViewCitel1VALIPI: TcxGridDBColumn;
    dbgItensDBTableViewCitel1VALRET: TcxGridDBColumn;
    dbgItensDBTableViewCitel1VAEIPI: TcxGridDBColumn;
    dbgItensDBTableViewCitel1DESESP: TcxGridDBColumn;
    dbgItensDBTableViewCitel1VAERET: TcxGridDBColumn;
    dbgItensDBTableViewCitel1TOTFRE_ITE: TcxGridDBColumn;
    dbgItensDBTableViewCitel1DESACE_ITE: TcxGridDBColumn;
    dbgItensDBTableViewCitel1VLRCON_ITE: TcxGridDBColumn;
    dbgItensDBTableViewCitel1VFCPST: TcxGridDBColumn;
    dbgItensDBTableViewCitel1UNITAR: TcxGridDBColumn;
    edtTotDoc: TEditFocus;
    edtVlrConTot: TEditFocus;
    edtBasIcmTot: TEditFocus;
    edtVlrIcmTot: TEditFocus;
    edtOutrasTot: TEditFocus;
    edtIsentaTot: TEditFocus;
    edtBCRETTot: TEditFocus;
    edtRetidTot: TEditFocus;
    edtBasAntTot: TEditFocus;
    edtAnticTot: TEditFocus;
    edtBasIpiTot: TEditFocus;
    edtVlrIipiTot: TEditFocus;
    edtBaeRetTot: TEditFocus;
    edtVaeRetTot: TEditFocus;
    edtBAEIPITot: TEditFocus;
    edtVaeIPiTot: TEditFocus;
    edtBAFCPTot: TEditFocus;
    edtVLFCPTot: TEditFocus;
    edtFCPSTTot: TEditFocus;
    edtVfcPsTot: TEditFocus;
    Label2: TLabel;
    qryFisItensTIPPRO: TStringField;
    dbgItensDBTableViewCitel1Column1: TcxGridDBColumn;
    qryFisItensUNIDAD: TStringField;
    grpDadosCat158: TGroupBox;
    Label90: TLabel;
    Label91: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    edtBaseStCat158: TEditFocus;
    edtValorStCat158: TEditFocus;
    edtBaseIcmCat158: TEditFocus;
    edtAlqIcmCat158: TEditFocus;
    edtValorIcmCat158: TEditFocus;
    GroupBox9: TGroupBox;
    GroupBox5: TGroupBox;
    Label103: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label73: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    edtBaseFCP: TEditFocus;
    edtPercFCP: TEditFocus;
    edtValorFCP: TEditFocus;
    edtBaseUFDest: TEditFocus;
    edtICMSOrigem: TEditFocus;
    edtICMSDestino: TEditFocus;
    edtAlqInterna: TEditFocus;
    edtAlqInterestadual: TEditFocus;
    edtPercentualPartilha: TEditFocus;
    GroupBox6: TGroupBox;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    edtBFCPST: TEditFocus;
    edtPFCPST: TEditFocus;
    edtVFCPST: TEditFocus;
    GroupBox10: TGroupBox;
    GroupBox12: TGroupBox;
    Label65: TLabel;
    Label64: TLabel;
    dbeBRetNC: TEditFocus;
    dbeVRetNC: TEditFocus;
    GroupBox11: TGroupBox;
    Label42: TLabel;
    Label3: TLabel;
    dbeBasRet: TEditFocus;
    dbeValRet: TEditFocus;
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    Label34: TLabel;
    Label36: TLabel;
    Label38: TLabel;
    lblOutIcm: TLabel;
    lblIseIcm: TLabel;
    Label92: TLabel;
    dbeBasIcm: TEditFocus;
    dbeAlqIcm: TEditFocus;
    dbeValIcm: TEditFocus;
    dbeOutras: TEditFocus;
    dbeIsenta: TEditFocus;
    dbeVICMDe: TEditFocus;
    grpIcmsAnte: TGroupBox;
    lblBasAnt: TLabel;
    lblValAnt: TLabel;
    dbeBasAnt: TEditFocus;
    dbeValAnt: TEditFocus;
    tbsHistContigencia: TTabSheet;
    dbmHisCon: TDBMemoFocus;
    pnlNatCfo: TPanel;
    Label23: TLabel;
    dbeNatCfo: TEditFocus;
    qryFisItensNAT_CODCFO: TStringField;
    dbgItensDBTableViewCitel1CODFAB: TcxGridDBColumn;
    qryFisItensCODFAB: TStringField;
    GroupBox13: TGroupBox;
    Label26: TLabel;
    Label29: TLabel;
    Label110: TLabel;
    edtCidadeEnt: TEditFocus;
    edtEstadoEnt: TEditFocus;
    edtCEPEnt: TEditFocus;
    qryFisItensCIDADEENT: TStringField;
    qryFisItensESTADOENT: TStringField;
    qryFisItensCEPENT: TStringField;
    btnAtualizaCstAliquotaProdutos: TBitBtnLocked;
    grpRetencaoFuntural: TGroupBox;
    Label23x: TLabel;
    Label44: TLabel;
    Label67: TLabel;
    dbeBasFun: TDBEditFocus;
    dbeTotFun: TDBEditFocus;
    dbeAlqFun: TDBEditFocus;
    dbgItensDBTableViewCitelSEQUENCIA: TcxGridDBColumn;
    tbsPessoasCTE: TTabSheet;
    pnlContainerPessoas: TPanel;
    qryFisItensNROITE: TLargeintField;
    Label45: TLabel;
    qryFisItensCSTIPI: TStringField;
    dbeCSTIPI: TEditFocus;
    dbgItensDBTableViewCitel1DESCMAR: TcxGridDBColumn;
    dbgItensDBTableViewCitel1CODFAB2: TcxGridDBColumn;
    qryFisItensDESMAR: TStringField;
    qryFisItensCODFAB2: TStringField;
    lblVenda: TLabel;
    edtVenda: TEditFocus;
    rgpTipoLancamentoCTE: TRadioGroup;
    tbsDocumentosCTE: TTabSheet;
    DBGridCitel1: TDBGridCitel;
    cdsDocsCTE: TUniClientDataSet;
    cdsDocsCTEGER_DTADOC: TDateField;
    cdsDocsCTEGER_NUMDOC: TStringField;
    cdsDocsCTEGER_ESPDOC: TStringField;
    cdsDocsCTEGER_SERIE_: TStringField;
    dtsDocsCTE: TDataSource;
    tbsChaveRef: TTabSheet;
    grdChaveRefDBTableView: TcxGridDBTableView;
    grdChaveRefLevel: TcxGridLevel;
    grdChaveRef: TcxGrid;
    cdsChaveRef: TUniClientDataSet;
    cdsChaveRefCHAVES: TStringField;
    dtsChaveRef: TDataSource;
    grdChaveRefCHAVES: TcxGridDBColumn;
    lblNFCeOffline: TLabel;
    lblDataNFCeOffline: TLabel;
    dbeDataNFCeOffline: TDBEditFocus;
    lblChaveNFCeOffline: TLabel;
    dbeChaveNFCeOffline: TDBEditFocus;
    dbeNcmIte: TEditFocus;
    Label68: TLabel;
    edtDesNcm: TEditFocus;
    qryFisItensNCMITE: TStringField;
    ckbReduzICMS: TCheckBox;
    lblRICMPR: TLabel;
    lblStatus: TLabel;
    cmbNatOpe: TComboBoxFocus;
    qryFisItensNAT_DESCRI: TStringField;
    qryFisItensDET_NATOPE: TStringField;
    cmbNatOpeItem: TComboBoxFocus;
    cdsDocsCTEGER_ENTSAI: TStringField;
    dbgItensDBTableViewCitelNCMITE: TcxGridDBColumn;
    dbgItensDBTableViewCitelCST: TcxGridDBColumn;
    dbgItensDBTableViewCitelCFOP: TcxGridDBColumn;
    tbsGia: TTabSheet;
    tbsFinanceiro: TTabSheet;
    cxGrid1: TcxGrid;
    grdFinanceiro: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    chkDocumentoConferido: TDBCheckBox;
    dsFinanceiro: TDataSource;
    pnlGia: TPanel;
    FlowPanel1: TFlowPanel;
    btnIncluirGia: TBitBtnLocked;
    btnGravarGia: TBitBtnLocked;
    btnAlterarGia: TBitBtnLocked;
    btnExcluirGia: TBitBtnLocked;
    btnCancelarGia: TBitBtnLocked;
    pnlCentral: TPanel;
    Label58: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label82: TLabel;
    mskDtaMes: TcxDBMaskEdit;
    edtCodSubIte: TDBEditFocus;
    edtValSubIte: TDBEditFocus;
    lcbFundamentoLegal: TDBLookupComboBox;
    lcbDescricaoOcorrencia: TDBLookupComboBox;
    rgIndicaOperacaoPropriaOuSt: TRadioGroup;
    dtsDescricaoFundamentoLegal: TDataSource;
    dtsDescricaoOcorrencia: TDataSource;
    dtsCadOcr: TDataSource;
    BitBtnLocked1: TBitBtnLocked;
    FlowPanel3: TFlowPanel;
    btnDocCTEIncluir: TBitBtnLocked;
    btnDocCTEExcluir: TBitBtnLocked;
    cdsDocsCTETABELA: TStringField;
    cdsDocsCTEAUTOINCREM: TStringField;
    qryFisItensOPCDOC: TStringField;
    cxEditRepository1: TcxEditRepository;
    cxEditRepository1ButtonItem1: TcxEditRepositoryButtonItem;
    gbxBaseFrete: TGroupBox;
    lblCFOP: TLabel;
    edtDesBasFre: TEditFocus;
    dbeBasFre: TDBEditFocus;
    pnlDadosGeraisCtnComum: TPanel;
    pnlCtnICMSSubst: TPanel;
    pnlBaseCMSSubst: TPanel;
    pnlvalorCMSSubst: TPanel;
    pnlCtnICMSAntecipado: TPanel;
    pnlValorCMSAntecipado: TPanel;
    pnlBaseCMSAntecipado: TPanel;
    pnlCtnIPI: TPanel;
    pnlValorIPI: TPanel;
    pnlBaseIPI: TPanel;
    pnlCtnIcmsStNaoCreditado: TPanel;
    pnlValorIcmsStNaoCreditado: TPanel;
    pnlBaseIcmsStNaoCreditado: TPanel;
    pnlCtnIpiNaoCreditado: TPanel;
    pnlValorIpiNaoCreditado: TPanel;
    pnlBaseIpiNaoCreditado: TPanel;
    pnlCtnFCP: TPanel;
    pnlValorFCP: TPanel;
    pnlBaseFCP: TPanel;
    pnlCtnFCPST: TPanel;
    pnlValorFCPST: TPanel;
    pnlBaseFCPST: TPanel;
    pnlCtnQtdMono: TPanel;
    pnlValorQtdMono: TPanel;
    pnlBaseQtdMono: TPanel;
    pnlContainerReforma: TPanel;
    pnlBaseCBS: TPanel;
    pnlValorCBS: TPanel;
    pnlBaseIBS: TPanel;
    pnlValorIBS: TPanel;
    pnlBaseIS: TPanel;
    pnlValorIS: TPanel;
    lblBaseCBS: TLabel;
    lblValorCBS: TLabel;
    lblBaseIBS: TLabel;
    lblValorIBS: TLabel;
    lblBaseIS: TLabel;
    lblValorIS: TLabel;
    DBEBCCBS1: TDBEditFocus;
    DBEBCCBS2: TDBEditFocus;
    DBEBCCBS3: TDBEditFocus;
    DBEBCCBS4: TDBEditFocus;
    DBEBCCBS5: TDBEditFocus;
    DBEVLCBS1: TDBEditFocus;
    DBEVLCBS2: TDBEditFocus;
    DBEVLCBS3: TDBEditFocus;
    DBEVLCBS4: TDBEditFocus;
    DBEVLCBS5: TDBEditFocus;
    DBEBCIBS1: TDBEditFocus;
    DBEBCIBS2: TDBEditFocus;
    DBEBCIBS3: TDBEditFocus;
    DBEBCIBS4: TDBEditFocus;
    DBEBCIBS5: TDBEditFocus;
    DBEVLIBS1: TDBEditFocus;
    DBEVLIBS2: TDBEditFocus;
    DBEVLIBS3: TDBEditFocus;
    DBEVLIBS4: TDBEditFocus;
    DBEVLIBS5: TDBEditFocus;
    DBEBC_IS1: TDBEditFocus;
    DBEBC_IS2: TDBEditFocus;
    DBEBC_IS3: TDBEditFocus;
    DBEBC_IS4: TDBEditFocus;
    DBEBC_IS5: TDBEditFocus;
    DBEVL_IS1: TDBEditFocus;
    DBEVL_IS2: TDBEditFocus;
    DBEVL_IS3: TDBEditFocus;
    DBEVL_IS4: TDBEditFocus;
    DBEVL_IS5: TDBEditFocus;
    dtsAuxFis: TDataSource;
    edtBCCBSTot: TEditFocus;
    edtVLCBSTot: TEditFocus;
    edtBCIBSTot: TEditFocus;
    edtVLIBSTot: TEditFocus;
    edtBC_ISTot: TEditFocus;
    edtVL_ISTot: TEditFocus;
    lblPerfCli: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    edtQtdMonTot: TEditFocus;
    edtValMonTot: TEditFocus;
    DBEVALMO3: TDBEditFocus;
    DBEQBCMO3: TDBEditFocus;
    DBEVALMO4: TDBEditFocus;
    DBEQBCMO4: TDBEditFocus;
    DBEVALMO5: TDBEditFocus;
    DBEQBCMO5: TDBEditFocus;
    DBEVALMO1: TDBEditFocus;
    DBEQBCMO1: TDBEditFocus;
    DBEVALMO2: TDBEditFocus;
    DBEQBCMO2: TDBEditFocus;
    gbxMonofasico: TGroupBox;
    Label112: TLabel;
    Label113: TLabel;
    Label114: TLabel;
    edtQBCMonoRet: TEditFocus;
    edtAdRemICMDRet: TEditFocus;
    edtVICMSMonoRet: TEditFocus;
    qryFisItensDET_QBCMON: TCurrencyField;
    qryFisItensDET_ADREMN: TCurrencyField;
    qryFisItensDET_VALMON: TCurrencyField;
    Label117: TLabel;
    edtValGNRE: TEditFocus;
    btnMemCalcGNRE: TSpeedButton;
    qryFisItensDET_VLGNRE: TCurrencyField;
    qryFisItensBASCBS: TFloatField;
    qryFisItensVALCBS: TFloatField;
    qryFisItensBASIBS: TFloatField;
    qryFisItensVALIBS: TFloatField;
    qryFisItensBAS_IS: TFloatField;
    qryFisItensVAL_IS: TFloatField;
    dbmHistor: TDBMemoFocus;
    Label118: TLabel;
    Label119: TLabel;
    dbeNumDPS: TDBEditFocus;
    dbeSerDPS: TDBEditFocus;
    pnlValorLiquido: TPanel;
    Label69: TLabel;
    edtVlrLiqTot: TEditFocus;
    DBEVLLIQ1: TEditFocus;
    DBEVLLIQ2: TEditFocus;
    DBEVLLIQ3: TEditFocus;
    DBEVLLIQ4: TEditFocus;
    DBEVLLIQ5: TEditFocus;
    edtPerfCli: TEditFocus;
    btnEventosDeEntrega: TBitBtnLocked;
    popEventosEntrega: TPopupMenu;
    popConfirmaoEntrega: TMenuItem;
    popCancelamentoConfirmacaoEntrega: TMenuItem;
    N1: TMenuItem;
    popInsucessoEntrega: TMenuItem;
    popCancelamentoInsucessoEntrega: TMenuItem;
    gpbReforma: TGroupBox;
    Label120: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label126: TLabel;
    edtBaseCbs: TEditFocus;
    edtValorCBS: TEditFocus;
    edtBaseIBS: TEditFocus;
    edtValorIBS: TEditFocus;
    Label123: TLabel;
    Label124: TLabel;
    edtBaseIS: TEditFocus;
    edtValorIS: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure dbeForCliKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeClfSc5KeyPress(Sender: TObject; var Key: Char);
    function dbeClfSc1ChamaCadastro(Key: Word): String;
    procedure dbeBasPisExit(Sender: TObject);
    procedure dbeBasCofExit(Sender: TObject);
    procedure dbeAlqIc1Enter(Sender: TObject);
    procedure dbeAlqIc2Enter(Sender: TObject);
    procedure dbeAlqIc3Enter(Sender: TObject);
    procedure dbeAlqIc4Enter(Sender: TObject);
    procedure dbeAlqIc5Enter(Sender: TObject);
    procedure dbeCodFisChange(Sender: TObject);
    procedure dbeClaFisChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure tbsItensShow(Sender: TObject);
    procedure tbsItensHide(Sender: TObject);
    procedure dbeEspDocExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pHabilitaChaveAcesso;
    procedure pHabilitaCTCompraVenda;
    procedure pHabilitaNFComplemento;
    procedure pHabilitaInfCpl;
    procedure pHabilitaCodMod;
    procedure pRemoveInfCpl;
    procedure dbeCodFisExit(Sender: TObject);
    procedure btnReconstruirClick(Sender: TObject);
    procedure btnAltDataClick(Sender: TObject);
    procedure edtIteCstPisKeyPress(Sender: TObject; var Key: Char);
    procedure edtIteCstCofKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCstPisKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCstCofKeyPress(Sender: TObject; var Key: Char);
    procedure pgcDetalhesChange(Sender: TObject);
    procedure btnAlterarSerieClick(Sender: TObject);
    procedure btnAltEspecieClick(Sender: TObject);
    procedure btnAltForClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure dbeEntSaiExit(Sender: TObject);
    procedure dbgItensEnter(Sender: TObject);
    procedure dbgItensExit(Sender: TObject);
    procedure dbeCodFisKeyPress(Sender: TObject; var Key: Char);
    procedure dbeClaFisKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodFisEnter(Sender: TObject);
    procedure dbeClaFisExit(Sender: TObject);
    procedure dbeTip_FcChange(Sender: TObject);
    procedure dbeAlqIssExit(Sender: TObject);
    procedure btnIncluirFisAjuClick(Sender: TObject);
    procedure btnGravarFisAjuClick(Sender: TObject);
    procedure btnAlterarFisAjuClick(Sender: TObject);
    procedure btnExcluirFisAjuClick(Sender: TObject);
    procedure btnCancelarFisAjuClick(Sender: TObject);
    procedure edtBasIcmExit(Sender: TObject);
    procedure edtAlqIcmExit(Sender: TObject);
    procedure edtOutrosExit(Sender: TObject);
    procedure edtValIcmEnter(Sender: TObject);
    procedure btnDifalClick(Sender: TObject);
    procedure edtAlqInterestadualExit(Sender: TObject);
    procedure edtAlqInternaExit(Sender: TObject);
    procedure edtBaseUFDestExit(Sender: TObject);
    procedure edtPercFCPExit(Sender: TObject);
    procedure dbeEntSaiChange(Sender: TObject);
    procedure grdImpostosRET_ALIQUOGetDataText(Sender: TcxCustomGridTableItem;
      ARecordIndex: Integer; var AText: string);
    procedure grdImpostosVALRETGetDataText(Sender: TcxCustomGridTableItem;
      ARecordIndex: Integer; var AText: string);
//    procedure btnCalcRetClick(Sender: TObject);
    procedure cdsForRetRET_ALIQUOChange(Sender: TField);
//    procedure grdImpostosTableView1EditValueChanged(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
    procedure edtPerAcuExit(Sender: TObject);
    procedure btnConfAcumuladorClick(Sender: TObject);
    procedure dbgDomAcuKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbeNfCompleChange(Sender: TObject);
    procedure dbeClfSc1Change(Sender: TObject);
    procedure dbeVlCon1Exit(Sender: TObject);
    procedure btnPesquisarNfEntradaClick(Sender: TObject);
    procedure btnExcluirNfComplementarClick(Sender: TObject);
    procedure edtCodAjuKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodAjuExit(Sender: TObject);
    procedure dtsFisAjuDataChange(Sender: TObject; Field: TField);
    procedure dbeChaveAcessoExit(Sender: TObject);
    procedure edtPFCPSTExit(Sender: TObject);
    procedure dbgItensDBTableViewCitel1CellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure dbgItensDBTableViewCitel1DblClick(Sender: TObject);
    procedure dbgItensDBTableViewCitel1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgItensDBTableViewCitel1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbeBasIc1Exit(Sender: TObject);
    procedure dbeAlqIc5Exit(Sender: TObject);
    procedure dbeVlCon2Exit(Sender: TObject);
    procedure dbeDtaEntExit(Sender: TObject);
    procedure dbeClfSc1Exit(Sender: TObject);
    procedure dtsFisItensDataChange(Sender: TObject; Field: TField);
    procedure dtsTabelaDataChange(Sender: TObject; Field: TField);
    procedure dbeNatCfoEnter(Sender: TObject);
    procedure dbeNatCfoKeyPress(Sender: TObject; var Key: Char);
    procedure btnAtualizaCstAliquotaProdutosClick(Sender: TObject);
    procedure dbeCSTIPIKeyPress(Sender: TObject; var Key: Char);
    procedure grdChaveRefDBTableViewEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure dbeNcmIteKeyPress(Sender: TObject; var Key: Char);
    procedure cmbNatOpeChange(Sender: TObject);
    procedure btnIncluirGiaClick(Sender: TObject);
    procedure btnGravarGiaClick(Sender: TObject);
    procedure btnAlterarGiaClick(Sender: TObject);
    procedure btnExcluirGiaClick(Sender: TObject);
    procedure btnCancelarGiaClick(Sender: TObject);
    procedure dtsCadOcrStateChange(Sender: TObject);
    procedure BitBtnLocked1Click(Sender: TObject);
    procedure btnDocCTEIncluirClick(Sender: TObject);
    procedure btnDocCTEExcluirClick(Sender: TObject);
    procedure edtVlrIcmTotChange(Sender: TObject);
    procedure cxEditRepository1ButtonItem1PropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure dbeBasFreKeyPress(Sender: TObject; var Key: Char);
    procedure chkDocumentoConferidoClick(Sender: TObject);
    procedure dbeNumDocExit(Sender: TObject);
    procedure btnMemCalcGNREClick(Sender: TObject);
    procedure dbmHistorExit(Sender: TObject);
    procedure dbmHistorKeyPress(Sender: TObject; var Key: Char);
    procedure dbeIsent1Exit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure popCancelamentoConfirmacaoEntregaClick(Sender: TObject);
    procedure popInsucessoEntregaClick(Sender: TObject);
    procedure popCancelamentoInsucessoEntregaClick(Sender: TObject);
    procedure popConfirmaoEntregaClick(Sender: TObject);
    procedure btnEventosDeEntregaClick(Sender: TObject);
  private
    { Private declarations }
    FChaveAcesso: TRecChaveAcesso;
    qryAuxFis: TUniQuery;
    FblnGravandoLivro: Boolean;
    blnCRDMNF: Boolean;
    strCLITSV: String;
    qryCadOcr: TUniQuery;
    qryFundamentoLegal: TUniQuery;
    qryDescricaoOcorrencia: TUniQuery;
    qryConsultarFinanceiro: TConsultarFinanceiro;
    strCodCfo: String;

    strENERGIA_ELETRICA: String;
    strTELECOMUNICACAO: String;
    ArrValoresIniciaisItens : TArrValoresIniciaisItens;
    blnPulaProcessoEnergia: Boolean;
    fltMinDocRet : Double;
    fltMinRet : Double;

    arrAju: TConsultasArray;
    blnTemAnt: Boolean;
    strTabela : String;

    blnEditaBaseCalcPISCofins: Boolean;

    objFechamentoFiscal: TFechamentoFiscal;
    objFechamentoEstoque: TFechamentoEstoque;
    fraCadImpostosNFS: TfraCadImpostosNFS;

    strNumDoc: String;
    strNumDo2: String;
    strEstado: String;
    intCLIREGFIS: Integer;
    strCodCta: String;
    strDtTrav: String;
    blnInsert: Boolean;

    strEstEmp: String;
    strDEMQDD: String;

    qryConCfo,
    qryConCid,
    qryCidEmp,
    qryConCli,
    qryCadEmp,
    qryCadFor,
    qryCadCli,
    qryDomAcu,
    FqryPgoFis: TUniQuery;
    tipRatFrete: TTipoRateioFrete;

    blnUTIABR: Boolean;
    blnUTICON: Boolean;
    blnEXPCTB: Boolean;
    arrAliICM: array[1..5] of Double;
    blnAlterouPisCofins: Boolean;

    objLiberacao : TLiberacao;

    objPgoAnt: TEntPagtoAntecipado;
    blnCarregaPis: Boolean;
    blnCarregaCofins: Boolean;
    FDatasetCtpDet: TUniClientDataSet;

    fraPessoasCTE: TfraPessoasCTE;

    arrDuplicata: TarrDuplicata;

    qryCadNcm: TUniQuery;

    fltOldAlqPis,
    fltOldBasPis,
    fltOldAlqCof,
    fltOldBasCof: Double;

    FqryUpdNatOpeItem: TUniQuery;

    FStrNatOpeItemAnt: String;

    FBlnAlterandoItem: Boolean;

    stlRegistrosExcluidosRECTNF: TStringList;
    FobjTabOrder: TGerenciadorTabOrder;

    function fLiberaAlteracaoData(ANovaDtaEnt : TDateTime): Boolean;
    function fDireitoNovaDataEntrada(ANovaDtaEnt : TDateTime): Boolean;

    function fRegraPisCofins: Boolean;
    function fRegraPisCofinsServico: Boolean;
    function fExisteCadFis(AAutInc: String): Boolean;
    function fItemExiste(strCodIte: String): Boolean;
    procedure pLimparConteudoItens;
    procedure pRegistrarTabOrderDocs;
    function fPermiteMudarFocoTabOrder(AobjComponente: TWinControl): Boolean;
    procedure pIrParaProximaAbaTabOrder(Sender: TObject);

    function fAplicaReducaoICMS(blnReduz: Boolean): Boolean;
    function fEhClienteConsumidor(strTipCli, strCodCli: string): Boolean;
    function fBuscaInscricaoEstadual(strTipCli, strCodCli: string): string;
    function fEhMicroEmpresa(strTipCli, strCodCli: string): Boolean;

    procedure pInicializarTabela(strSQL: String);
    Function fTemNotaEletronica: Boolean;
    function fExpecieExigeChave: Boolean;

    procedure pCarregaPisCofins(strCfop,AstrCstPis, AstrCstCof: String);
    procedure pCalculaTotais;
    function  fTransformSQL(strCampo: String): String; overload;
    procedure pAddArrValoresIniciaisItens(Aedit: TEdit);
    function fModeloValidoParaNotaDeComunicao: Boolean;
    function fGravarFinanceiro: Boolean;
    function  fTransformSQL(strCampo: String; intTamanho: Integer;
      strChar: String): String; overload;
    function  fExisteRegraPis(strCstPis: String;
      fltBasPis: Double; fltAlqPis: Double; fltValPis: Double): Boolean;
    function  fExisteRegraCofins(strCstCof: String;
      fltBasCof: Double; fltAlqCof: Double; fltValCof: Double): Boolean;

    procedure pCarregaCliente;
    procedure pCarregaFornecedor;
    procedure pCarregaPerfil;
    procedure pCarregaCidadeEstado(strCodCid: String);
    procedure pCarregaCidadeEmpresa(strCodCid: String);
    procedure pCarregaDadosAdicionais;
    procedure pCarregaEmpresa;
    procedure pCarregaDadosCpl;
    procedure pCarregaDadosNotaComplementar;
    procedure pCarregaDocumentosAssociadosCTE;
    procedure pDesabilitaEditsNfComplementar;

    procedure pAtribuiTabelas;
    procedure pAfterOpen(DataSet: TDataSet);

    procedure pLimpaEdits;
    procedure pLimpaDadosComplementares;
    procedure pBuscaCliente;
    procedure pBuscaFornecedor;

    procedure pAtivaCampoCst;

    procedure pAtualizaItensLivro;
    procedure pCarregaModFis(strChave: String = '');

    function  fPodeAlterar: Boolean;
    function  fTabTri: String;
    procedure pCriaMovGerMovDet;
    procedure pMontaSQLMovGer(qryComand: TUniQuery; strMovGerAutInc: String);
    procedure pMontaSQLMovDet(qryComand: TUniQuery; strMovGerAutInc: String);
    procedure pApagaMovGer(strNumDoc, strEspDoc, strCodEmp, strForCli, strSerie: String);

    function  fVerificaClaFis(strClaFis: String): Boolean;

    {*****************************************}
    {* FUNÇÕES PARA VALIDAÇÃO DOS DADOS      *}
    {* FISCAIS. VALIDA O CAMPO DE ACORDO C/  *}
    {* A COLUNA QUE SE ENCONTRA              *}
    {**************************************MV*}
    procedure pLimparCamposFiscais(intNumCampo: Integer);
    procedure pHabilitaDadosFiscais(blnHabilita: Boolean; intNumCampo: Integer); overload;
    procedure pHabilitaDadosFiscais; overload;
    procedure pCalculaValIcm(intNumCampo: Integer);
    procedure pHabilitaCanhotoNF;

    procedure pCarregaItens(blnApenasDesabilitaCampos: Boolean = False; blnLimpaCampos: Boolean = False; blnAlterarNatOpeCapa: Boolean = True);

    function  fValidaClaFis(strCampo: String): Boolean;
    function  fValidaClaFisInclusao: Boolean;
    function  fValidaClaFisCT(strEspDoc: string; strCFOP: String = ''): Boolean;


    procedure pCalculaValorIcmsIpi;

    function fRetSQL(strTabela: String): String;
    procedure pSetaParametros(qryAux: TUniQuery);

    procedure pCalculaValorDocumento;
    procedure pCalculaTotaisItens;
    procedure pJustaCamposImpostos;
    procedure pSincronizarAuxFis;
    function fSqlReformaLivro(const ATabelaDetalhe, ACampo: String): String;
    function fSqlReformaLivroTotal(const ATabelaDetalhe: String): String;
    function fValorReformaItemLivro: Double;
    function fPrepararAuxFisReconstrucao: Boolean;
    procedure pPreencherAuxFisReconstrucao(const ABloco: Integer; const AQrySint: TUniQuery);
    procedure pGravarAuxFis;
    procedure pConfirmarAuxFis;
    procedure pDescartarAuxFis;
    function fSomarBlocosAuxFis(const strCampo: String): Double;
    procedure pJustaCamposAllVisible;
    function fTemValorBase(APanel: TPanel): Boolean;

    procedure pManipulaCampoCodigoVerificador;
    function pManipulaCampoCodigoTipoServico: Boolean;

    procedure pCarregaComboClassficacaoAcu;
    function fRetornaAlqDoCombo(strConteudoCombo: String): Double;
    procedure pLimpaCamposDominioAcumulador;
    procedure pCarregaDominioAcumulador;
    procedure pGravaDominioAcumulador;
    function fValidaAcumuladoresConf: Boolean;
    function fValidaAcumuladoresGrav: Boolean;
    procedure pCarregaItensGrid;

    procedure pSetaTabelaEAutoIncremContabilidade(var RegistroContabilidade: TrecRegistroContabilidade);

    function fCidadeMovGer(strNumDoc, strEspDoc, strCodEmp, strCodCli, strSerie: String): String;
    function fReconstruirLivro(blnAtualizarMovGer: Boolean): Boolean;
    procedure pAtualizaDataMovDetMovGer;
    procedure pRateiaValores;
    procedure pCalculaTotalItemPisCofins;
    function fItensComDataBalancoValida(qryItens: TDataSet;
      dtaDtaEnt: TDateTime): Boolean;
    procedure pAlteraDataDocumento(dtaNovaDtaEnt, dtaDocumento: TDateTime);
    procedure pAlteraDataItens(dtaDtaEnt: TDateTime);
    function fVerificaSeExisteTA(strNumDoc, strEspDoc,strCodEmp,strCodFor,strSerie, strTipFc: String): String;
    procedure pCarregaItensDocumento(qryItens: TUniQuery);
    procedure pGravaLogs(dtaDtaEnt: TDateTime);
    procedure pHabilitaCamposGerais(blnHabilita: Boolean);
    function fTemMovTri(strTabela, strAutInc: String): Boolean;
    procedure pAtualizaDadosPisCofins(strAutInc: String);
    function fValidaCstCofinsLivro(dbeCampo: TDBEdit;
      ipcImposto: TImpostoPisCofins; blnCstBranca: Boolean): Boolean;
    function fDigitaNovaSerie(var strNovaSerie: String): Boolean;
    function fDocumentoStateBrowse: Boolean;
    function fNotaEmissaoPropria: Boolean;
    procedure pAtualizarSerieDocumento(strNovaSerie: String);
    function fTryAtualizarSerieDocumento(strNovaSerie: String; var strMensagem: String): Boolean;
    procedure pImprimeEspelho;
    function fDigitaNovaEspecie(var strNovaEspecie: String): Boolean;
    procedure pAtualizarFornecedor(strNovoFor: String);
    procedure pTryAtualizarFornecedor(strNovoFor: String);
    procedure pAtualizarEspecieDocumento(strNovaEspecie: String);
    procedure pTryAtualizarEspecieDocumento(strNovaEspecie: String);
    function fVerificaExiste(strNovoVal, strCampo: String): Boolean;
    procedure pRefreshDocumento;
    procedure pTryRefreshDocumento;
    procedure pGravaLogFis(strValAnt, strValAtu, strNomCam, strNomTab: String);
    procedure pAtualizarMovGer(fltTotPro, fltTotBasIcm, fltMaxAlqIcm, fltTotValIcm,
      fltTotBasRet, fltTotValRet, fltTotBasIpi, fltMaxAlqIpi, fltTotValIpi: Double);
    function fVerificaTotalImpostos: Boolean;
    function fVerificaCfopCorreta(strCfop: String): Boolean;
    procedure pVerificaCfopCorreta(strCfop: String);
    procedure pAtualizaLabelCfopInvalida;
    function fPermiteAlterarData: Boolean;
    procedure pMarcarComoImpresso;
   	procedure pSetButtonFisAju(NomeTabela:TDataSet;btnNovo,btnConfirma,btnExclui,btnCancela,btnEditar:TBitBtnLocked);
    procedure pOnStateChangeFisAju;
    procedure pEnabledFisAju;
    procedure pEnabledCodigoClasseConsumoEnergiaEletrica;
    //procedure pHabilitaBotoesFisAju;
    procedure pCalcularValoresUFDest;
//    procedure pAjustarCamposRetencoesLivFis(fltRetPis, fltRetCofins, fltRetCsll, fltRetIrrf, fltRetInss, fltRetIss: Double);
//    procedure pAjustaCamposRetencoesGrid(Sender: TDbEditFocus);
//    procedure pCriarParcelasRetencoesFornecedor;
    function fGravarTabelasAuxiliares: Boolean;
    procedure pDesabilitaBotoesCompValor;
    procedure pVerificaCtaPagar(var blnCtaPagar, blnCtaBaixado, blnCtaPagarComRetencaoImp, blnCtaPagarComRetencaoImpPago, blnCtaPagarAntecipado: Boolean; var AListaRetencao: String);
    function fVerificaCtpAgrupada: Boolean;
    function fCancelaPagamentoAntecipado(strCliFor, strCodEmp: String): Boolean;
    procedure pCarregaDocumentosAntecipacao;
    function  fValidaNatOper: Boolean;
    function fClassificaoUnica: Boolean;
    procedure pCarregaTipoLancamentoCTE;

    procedure pAtualizaFieldsQryFisItens(strAutInc, strCstPis: String; strAlqPis, fltValPis: Double;
                                               strCstCof: String; fltAlqCof, fltValCof: Double);

    procedure fAtualizaDadosCtpNotEnt(strNovaSerie: String;
                                      strNotTip: String;
                                      strAutInc: String = '';
                                      strNovoFornecedor: String = '';
                                      strNovaEspecie: String = '');

    function fDireitoAcesso : Boolean;
    function fBuscaParcela(intContParcela: integer): string;
    procedure pAtualizaServico;
    procedure pAtualizaPrecoCustoReal(strAutIncMovDet: string);
    function fCarregaChavesReferenciadas: Boolean;

    function pGravarContasPagar(): Boolean;
    function pIncluirContasPagar(fltTotDoc: Double): Boolean;
    function fEhLancamentoDeNotaServico : Boolean;
    function pAlteraContasPagar(const DataSet: TDataSet; fltTotDoc: Double): Boolean;
    function fAlteraContasPagarPrevisao(strAutIncCTP: String; fltTotDoc: Double): Boolean;
    function fNFServico(strClaFis: String = ''): Boolean;
    function fObrigaCSTPis: Boolean;
    function fPodeRecalcularIcmsIpi: Boolean;
    procedure pAlterarVencimento(strAutInc: String; dtaVencimento: TDate);
    procedure pAlterarDataCadastro(strAutInc: String; dtaCadastro: TDate);

    procedure pDistribuiADiferencaDoRateioItens(Var fltValAtu, fltValDif: Double);
    function fGetModDocumentocbxCODMOD: String;
    procedure pHabilitaDadosOffline;
    procedure pCarregarStatus;
    procedure pSetaComboNatOpe(ACbxCombo: TComboBox; AstrClaFis: String; ABlnItem: Boolean);
    procedure pAtualizaComboNatOpe(ACbxCombo: TComboBox);
    procedure pCarregaNatOperacao(ACbxCombo: TComboBox; AstrCodCfo: String);
    procedure pChangeNatOpe(ABlnItem: Boolean);
    function fRetAutoIncremNatCfo(AStrNatCfo, AStrNatOpe: String): String;
    function fRetNatOpeItemDaCapa: String;
    function fItemDefineACapa: Boolean;

    procedure pDefineCapaPrimeiraClafisDadosGerais;
    function fSomaImpostosNaoCreditados: Boolean;
    function fPossuiCtpCtr: Boolean;
    function fValorTotalRetencao: Currency;
    procedure pCalcularValorLiquido;
    procedure pCarregarPainelValorLiquido;
    function fValidaFechamentoFiscalEstoque(AdtaDtaEnt: TDate = 0): Boolean;
    function fCriaQryUpdNatOpeItem: TUniQuery;
    procedure pVerificaSeRetificaREINF(var blnRetificaReinf2000, blnRetificaReinf4000: Boolean);
    procedure pRetificaReinf(const blnRetificaReinf2000, blnRetificaReinf4000: Boolean);
    function fValidarEntradaCFOPFornecedor(strCFOP:String): Boolean;
    function fValidarEntradaCT: Boolean;
    procedure pConsultarGIA;
    procedure pHabilitarTabGia;
    procedure pFormatarCamposGia;
    procedure pEnabledFraCadImpostosNFS(const blnEnabled: Boolean);
    procedure pGravarRecTnf;
    procedure pInserirRecTnf(strTabela, strAutoIncrem: String);
    procedure pConfigurarColunaPlanCta;
    procedure cxGrid1DBTableView1ButtonsGetProperties(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AProperties: TcxCustomEditProperties);
    function fBuscaBaseFrete(ACodBfr: string): string;
    procedure pBloqueiaEdicaoBaseFrete(AAutInc: String);
    procedure pSetaBaseFrete;
    procedure pHabilitarDocumentoConferido;
    function fExisteDocumentoFiscal(strNumDoc , strCodCliFor, strCodEmp, strTipCliFor : String) : Boolean;
    procedure pFormatarNumDoc;
    function fEhNotaEnergiaEletroincaZerada: Boolean;
    procedure pExibeMemoriaCalculoGNRE(ASeqDet: String);
    procedure pQryTabelaNewRecord(pDataSet: TDataSet);
    procedure pQryTabelaBeforeEdit(pDataSet: TDataSet);
    function fLockUnlock(ATravar: Boolean): Boolean;
    procedure pDeletaCTPDET(strNumDup, strParcel, strSerie, strCodFor, strCodEmp: String);
    function fPermitePalavraNoHistorico(const APalavra : String): Boolean;
    procedure pRemoveRegistrosRecTnf;
    function fLiberaEdicaoBasePISCOFINSEnergiaComunicacao: Boolean;
    function fPermiteInsucessoNaEntrega(AChaveAcesso:String): Boolean;
    procedure pDFeEventoDeEntrega(ATipoEvento: TTipoEventoEntrega);
    procedure pAtivaEventoDeEntrega;
  protected
    function fValidaAcessoEmpresa : Boolean;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    procedure pInicializaIndices; override;
    procedure pOnStateChange; override;
    function fCSTCadastrada(blnPis: Boolean): Boolean;

    procedure pPadrao;
    procedure pSetarFocusPadrao;
    procedure pValorOutras;
    procedure pConferirDocumento; overload;
    procedure pConferirDocumento(const blnConferir : Boolean); overload;
    procedure pSetaValoresConferencia(const blnConferir : Boolean);
    procedure pCadastrarGia;
    function fValidarDocumentoConferido: Boolean;
    function fValidarLiberarDocumentoConferido: Boolean;
    function fFiltroCFOP: String;
    function fVerificaDocumentoExisteCtp(strCodEmp: String; strNumDoc, strSerie, strCodFor: String; intTamCam: Integer): Boolean;
    function fDocumentoComVinculoFiscal(const qryTabela : TUniQuery) : Boolean;
  public
    { Public declarations }
    strAutoincrem : String;
    procedure pApagaCtaPagar(strForCli, strNumDoc, strCodEmp, strSerie, strEspDoc : String; strAutInc: String = ''; AstrListaRetencao: string = '');
  end;


var
  frmCadLivroFiscal: TfrmCadLivroFiscal;

implementation

uses Variants, Graphics, Dialogs, StrUtils, Math,
  untPai, untConsultas, untPesqAux, untFuncIns, untConstantes,
  untFiscCtpEntrada, untCadPag, untMemo, untCadProdutos, untEntradaValidacoes,
  untMsgValidacaoContabil, untCadAjuDet, untFuncoesGenerica,
  untDuplicatas, untFuncoesConsulta, untTCadPag, untLogCtp, untTCadPagRepository,
  untFuncFat, untMsgLiberacao, untEnderecamentoProduto, untSelCtaPagar, untFrameCtaPagar,
  untTGerenciaModeloPermitidos, untCancelamentoDocResumo, untCadRec,
  untRateioPlanCtas, untMensagemExplicativa, untLogCtpDet, untDFeEventosDeEntrega;

{$R *.dfm}

{ TfrmCadLivroFiscal }


procedure pHab(edtEdit: TEditFocus);
begin
  edtEdit.Color    := clWindow;
  edtEdit.ReadOnly := False;
  edtEdit.Enabled  := True;
end;
procedure pDesHab(edtEdit: TEditFocus);
begin
  edtEdit.Color    := $00FFDFB8;
  edtEdit.ReadOnly := True;
  edtEdit.Enabled  := False;
end;

function TfrmCadLivroFiscal.fPodeAlterar: Boolean;
begin
  Result := True;
  If (Pos(qryTabela.FieldByName('FIS_ESPDOC').AsString, 'NF_EL_IF_IV_D1_') > 0) And (qryTabela.FieldByName('FIS_DTAENT').AsDateTime <= StrToDate(strDtTrav)) Then
  Begin
    Result := False;
  End;
end;

function TfrmCadLivroFiscal.fRegraPisCofins: Boolean;
begin

  Result := strToIntDef(qryTabela.FieldByName('FIS_CLFSC1').AsString, 0) < 5000;

  If Result Then
    Result := blnUTIABR;

end;

function TfrmCadLivroFiscal.fRegraPisCofinsServico: Boolean;
begin
  Result := Pos(qryTabela.FieldByName('FIS_CLFSC1').AsString, '1933_2933') > 0;

  If Result Then
    Result := blnUTIABR;
end;

function TfrmCadLivroFiscal.fPodeRecalcularIcmsIpi: Boolean;
 var
  i: TValoresIniciaisItens;
begin
  If qryFisItens.IsEmpty Then
    Exit(True);

  Result := False;
  For i in ArrValoresIniciaisItens do
  begin
    If (i.Edit.Text <> i.Value) and ((i.Edit <> dbeCodFis) and (i.Edit <> dbeClaFis)) then
      Exit(True);
  End;

end;

function TfrmCadLivroFiscal.fNFServico(strClaFis: String =''): Boolean;
begin
  If strClaFis = '' then
    strClaFis := qryTabela.FieldByName('FIS_CLFSC1').AsString;
  Result := Pos(strClaFis, strCLITSV) > 0;
end;

function TfrmCadLivroFiscal.fRetornaAlqDoCombo(strConteudoCombo: String): Double;
begin
  //5102 - 18,00
  Result := fStrToFloat(ReplaceStr(Copy(strConteudoCombo, Pos('-', strConteudoCombo) + 2,  Length(strConteudoCombo)), '%', ''));
end;

function TfrmCadLivroFiscal.fRetSQL(strTabela: String): String;
begin
  Result := '';

  If strTabela = 'ITECOM' then
  Begin
    Result := Result + 'SELECT ';
    Result := Result + '  ITC_CLAFIS AS CLAFIS, ';
    Result := Result + '  ITC_ALQICM AS ALQICM, ';
    Result := Result + '  SUM(ITC_VALCOM) AS VLRCON, ';
    Result := Result + '  SUM(ITC_VALCOM) AS TOTPRO, ';
    Result := Result + '  SUM(ITC_BASICM) AS BASICM, ';
    Result := Result + '  SUM(ITC_VALICM) AS VALICM, ';
    Result := Result + '  SUM(ITC_BASRET) AS BASRET, ';
    Result := Result + '  SUM(ITC_VALRET) AS VALRET, ';
    Result := Result + '  0 AS BAERET, ';
    Result := Result + '  0 AS VAERET, ';
    Result := Result + '  0 AS BASANT, ';
    Result := Result + '  0 AS VALANT, ';
    Result := Result + '  0 AS DESACE, ';
    Result := Result + '  SUM(ITC_BASIPI) AS BASIPI, ';
    Result := Result + '  SUM(ITC_VALIPI) AS VALIPI, ';
    Result := Result + '  0 AS BAEIPI, ';
    Result := Result + '  0 AS VAEIPI, ';
    Result := Result + '  0 AS TOTFRE, ';
    Result := Result + '  0 AS DESESP, ';

    Result := Result + '  MAX(IFNULL(ITC_ALQPIS, 0)) AS ALQPIS, ';
    Result := Result + '  MAX(IFNULL(ITC_ALQCOF, 0)) AS ALQCOF, ';

    Result := Result + '  0 AS OUTICM, ';
    Result := Result + '  0 AS ISEICM, ';

    Result := Result + '  SUM(IFNULL(ITC_BASPIS, 0)) AS BASPIS, ';
    Result := Result + '  SUM(IFNULL(ITC_VALPIS, 0)) AS VALPIS, ';
    Result := Result + '  SUM(IFNULL(ITC_BASCOF, 0)) AS BASCOF, ';
    Result := Result + '  SUM(IFNULL(ITC_VALCOF, 0)) AS VALCOF, ';
    Result := Result + '  MAX(IFNULL(ITC_ALQICM, 0)) AS ALQICM, ';
    Result := Result + '  MAX(IFNULL(ITC_ALQIPI, 0)) AS ALQIPI, ';
    Result := Result + '  0 AS VICMDE  ';
    Result := Result + 'FROM  ';
    Result := Result + '  ITECOM ';
    Result := Result + 'WHERE ';
    Result := Result + '  ITC_SEQFIS = :AUTOINCREM ';
    Result := Result + 'GROUP BY ';
    Result := Result + '  ITC_CLAFIS, ';
    Result := Result + '  ITC_ALQICM  ';
  End
  Else
  Begin
    Result := Result + 'SELECT ';
    Result := Result + '  DET_CLAFIS AS CLAFIS, ';
    Result := Result + '  DET_ALQICM AS ALQICM, ';
    Result := Result + '  SUM(IFNULL(DET_TOTITE, 0)+IFNULL(DET_VALIPI, 0)+IFNULL(DET_TOTFRE, 0)+IFNULL(DET_DESACE, 0)+IFNULL(DET_VALRET, 0)-';
    Result := Result + '  IFNULL(DET_DESESP, 0)+IFNULL(TRI.DET_VAEIPI,0)+IFNULL(TRI.DET_VAERET,0) + IFNULL(TRI.DET_VFCPST, 0) + ';

    If  strTabela = 'NOTDET' Then
    Begin
      Result := Result + '  IF(IFNULL(IMP_SEQDET, "") = "", 0, IFNULL(DET_VALICM, 0) + IFNULL(IMP_PISPAS, 0) + IFNULL(IMP_COFINS, 0) + ';
      Result := Result + '  IFNULL(IMP_VALIOF, 0) + IFNULL(IMP_DESADU, 0) + IFNULL(IMP_VAL_II, 0) + IFNULL(IMP_SISCOM, 0) + IFNULL(IMP_VAFRMM,0)) + ';
    End
    Else
    Begin
      Result := Result + '  IF(IFNULL(IMP_SQMVDT, "") = "", 0, IFNULL(DET_VALICM, 0) + IFNULL(IMP_PISPAS, 0) + IFNULL(IMP_COFINS, 0) + ';
      Result := Result + '  IFNULL(IMP_VALIOF, 0) + IFNULL(IMP_DESADU, 0) + IFNULL(IMP_VAL_II, 0) + IFNULL(IMP_VAFRMM,0)) + ';
    End;

      Result := Result + fSqlReformaLivroTotal(strTabela) + ' + 0 ) AS VLRCON, ';


    Result := Result + '  SUM(DET_TOTITE) AS TOTPRO, ';
    Result := Result + '  SUM(DET_BASICM) AS BASICM, ';
    Result := Result + '  SUM(DET_VALICM) AS VALICM, ';
    Result := Result + '  SUM(DET_BASRET) AS BASRET, ';
    Result := Result + '  SUM(DET_VALRET) AS VALRET, ';
    Result := Result + '  SUM(IFNULL(TRI.DET_BAERET,0)) AS BAERET, ';
    Result := Result + '  SUM(IFNULL(TRI.DET_VAERET,0)) AS VAERET, ';
    Result := Result + '  SUM(IFNULL(DET_BASANT,0)) AS BASANT, ';
    Result := Result + '  SUM(IFNULL(DET_ICMANT,0)) AS VALANT, ';
    Result := Result + '  SUM(DET_DESACE) AS DESACE, ';
    Result := Result + '  SUM(DET_BASIPI) AS BASIPI, ';
    Result := Result + '  SUM(DET_VALIPI) AS VALIPI, ';
    Result := Result + '  SUM(IFNULL(TRI.DET_BAEIPI,0)) AS BAEIPI, ';
    Result := Result + '  SUM(IFNULL(TRI.DET_VAEIPI,0)) AS VAEIPI, ';
    Result := Result + '  SUM(DET_TOTFRE) AS TOTFRE, ';
    Result := Result + '  SUM(DET_DESESP) AS DESESP, ';

    Result := Result + '  MAX(IFNULL(TRI.DET_ALQPIS, 0)) AS ALQPIS, ';
    Result := Result + '  MAX(IFNULL(TRI.DET_ALQCOF, 0)) AS ALQCOF, ';

    Result := Result + '  SUM(IFNULL(TRI.DET_OUTICM, 0)) AS OUTICM, ';
    Result := Result + '  SUM(IFNULL(TRI.DET_ISEICM, 0)) AS ISEICM, ';

    Result := Result + '  SUM(IFNULL(TRI.DET_BASPIS, 0)) AS BASPIS, ';
    Result := Result + '  SUM(IFNULL(TRI.DET_VALPIS, 0)) AS VALPIS, ';
    Result := Result + '  SUM(IFNULL(TRI.DET_BASCOF, 0)) AS BASCOF, ';
    Result := Result + '  SUM(IFNULL(TRI.DET_VALCOF, 0)) AS VALCOF, ';
    Result := Result + '  MAX(IFNULL(DET_ALQICM,0)) AS ALQICM, ';
    Result := Result + '  MAX(IFNULL(DET_ALQIPI,0)) AS ALQIPI, ';
    Result := Result + '  SUM(IFNULL(DET_VICMDE,0)) AS VICMDE, ';
    Result := Result + '  SUM(IFNULL(TRI.DET_VFCPST, 0)) AS VFCPST, ';
    Result := Result + '  SUM(IFNULL(TRI.DET_BFCPST, 0)) AS BFCPST, ';
    Result := Result + '  SUM(IF(TRI.DET_BFCPST = ICD.ICD_BASFCP, 0, IFNULL(ICD.ICD_BASFCP, 0.00))) AS BASFCP, ';
    Result := Result + '  SUM(IF(TRI.DET_BFCPST = ICD.ICD_BASFCP, 0, IFNULL(ICD.ICD_VALFCP, 0.00))) AS VALFCP  ';
    Result := Result + '  ,SUM(IFNULL(TRI.DET_QBCMON, 0)) AS QBCMON ';
    Result := Result + '  ,TRI.DET_ADREMN ADREMN ';
    Result := Result + '  ,SUM(IFNULL(TRI.DET_VALMON, 0)) AS VALMON ';
    Result := Result + '  ,SUM(' + fSqlReformaLivro(strTabela, 'REF_BASCAL') + ') AS BASCBS ';
    Result := Result + '  ,SUM(' + fSqlReformaLivro(strTabela, 'REF_CBSVAL') + ') AS VALCBS ';
    Result := Result + '  ,SUM(' + fSqlReformaLivro(strTabela, 'REF_BASCAL') + ') AS BASIBS ';
    Result := Result + '  ,SUM(' + fSqlReformaLivro(strTabela, 'REF_VALIBS') + ') AS VALIBS ';
    Result := Result + '  ,SUM(' + fSqlReformaLivro(strTabela, 'REF_SELBAS') + ') AS BAS_IS ';
    Result := Result + '  ,SUM(' + fSqlReformaLivro(strTabela, 'REF_SELVAL') + ') AS VAL_IS ';
    Result := Result + 'FROM  ';
    Result := Result +    strTabela + ' ';
    Result := Result + '  LEFT JOIN ' + fTabTri +  ' AS TRI ON ';
    Result := Result + '    TRI.DET_SEQGER = ' + strTabela + '.AUTOINCREM ';
    If  strTabela = 'NOTDET' Then
    Begin
      Result := Result + '  LEFT JOIN DOCIMP ON IMP_SEQDET = ' + strTabela + '.AUTOINCREM ';
      Result := Result + '  LEFT JOIN NOTICD AS ICD ON ICD_SEQGER = ' + strTabela + '.AUTOINCREM ';
    End
    Else
    Begin
      Result := Result + '  LEFT JOIN DOCIMP ON IMP_SQMVDT = MOVDET.AUTOINCREM ';
      Result := Result + '  LEFT JOIN MOVICD AS ICD ON ICD_SEQGER = ' + strTabela + '.AUTOINCREM ';
    End;

    Result := Result + 'WHERE ';
    Result := Result + '  DET_NUMDOC = :NUMDOC AND ';
    Result := Result + '  DET_ESPDOC = :ESPDOC AND ';
    Result := Result + '  DET_CODEMP = :CODEMP AND ';
    Result := Result + '  IFNULL(DET_PROEMB, "") <> "S" AND ';

    If (qryTabela.FieldByName('FIS_TIP_FC').AsString = 'C') Then
      Result := Result + '  DET_CODCLI = :FORCLI AND '
    Else
      Result := Result + '  DET_CODFOR = :FORCLI AND ';

    Result := Result + '  DET_TIP_FC = :TIP_FC AND ';
    Result := Result + '  IFNULL(DET_SERIE_, "") = :SERIE_ ';
    Result := Result + 'GROUP BY ';
    Result := Result + '  DET_CLAFIS, ';
    Result := Result + '  DET_ALQICM  ';
  End;
end;

function TfrmCadLivroFiscal.fSomaImpostosNaoCreditados: Boolean;
Var
  strCLAGAE, strCLANFO: String;
begin
  {Se soma o ipi e St Não Creditado nos impostos}
  {Req. 296192                                  }

  strCLAGAE := fTransform(fCfgSis('CLAGAE'), 4);
  strCLANFO := fTransform(fCfgSis('CLANFO'), 4);

  Result := False;
  If SameText(dbeEntSai.Text,'E') Then  {Entrada}
    Result := True
  Else If (SameText(dbeEntSai.Text,'S')) And {Saída}
          (SameText(dbeTip_Fc.Text,'F')) And {Fornecedor}
          (pos(qryTabela.FieldByName('FIS_CLFSC1').AsString, strCLAGAE + strCLANFO) > 0) Then {Devolução}
    Result := True;
end;

function TfrmCadLivroFiscal.fValidaAcessoEmpresa: Boolean;
begin
  result := (Pos(dbeCodEmp.Text, strEmpAcessoUsuarioLogado) > 0);
end;

function TfrmCadLivroFiscal.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strCliFor: String;
    strForCli: String;
    strNomCid: String;
    strC_E_P_: String;
    strNomEmp: String;
    intNumCampo: Integer;
    dbeCampo:  TDBEditFocus;
    strNFComp: String;
    strCTComVen: String;
    strNfCstEnt: String;
    strSubSerie: String;

    fltTolerancia: Double;
    fltValIpiCalc: Double;
    blnItemConcreto: Boolean;
    strMsg: String;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*****************************************}
    {* VALIDA O DOCUMENTO 1                  *}
    {**************************************MV*}
    If (Sender = dbeNumDoc) Then
    Begin
      If fEmptyStr(dbeNumDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Número do Documento deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
      dbeNumDoc.Text := fPadL(dbeNumDoc.Field.AsString, 12, '0');
      strNumDoc := dbeNumDoc.Text;
      fraCadImpostosNFS.strNumDoc := dbeNumDoc.Text;
    End

    Else If (Sender = dbeNfComp) Then
    Begin
      fraCadImpostosNFS.strSerie := dbeNfComp.Text;
    End

    Else If (Sender = dbeNumDo2) Then
    Begin
      strNumDo2 := dbeNumDo2.Text;
    End

    {*****************************************}
    {* VALIDA O CAMPO 'Entrada / Saída'      *}
    {**************************************MV*}
    Else If (Sender = dbeEntSai) Then
    Begin
      If fEmptyStr(dbeEntSai.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Entrada / Saída deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (dbeEntSai.Text <> 'E') And
              (dbeEntSai.Text <> 'S') Then
      Begin
        Result := False;
      End;
      fraCadImpostosNFS.strEntSai := dbeEntSai.Text;

    End

    {******************************************}
    {* VALIDA O CAMPO 'Funcionário / Cliente' *}
    {***************************************MV*}
    Else If (Sender = dbeTip_Fc) Then
    Begin
      If fEmptyStr(dbeTip_Fc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Fornecedor / Cliente deve ser preenchido!', ['&Ok']);
        Result := False;
      End
      Else If (dbeTip_Fc.Text <> 'F') And
              (dbeTip_Fc.Text <> 'C') Then
      Begin
        Result := False;
      End
      Else If (dbeTip_Fc.Text = 'F') Then
      Begin
        qryConCli := qryCadFor;
        lblTip_fc.Caption := 'Código do Fornecedor';
        lblCgcCpf.Caption := 'CNPJ: ';
      End
      Else If (dbeTip_Fc.Text = 'C') Then
      Begin
        qryConCli := qryCadCli;
        lblTip_fc.Caption := 'Código do Cliente';
        lblCgcCpf.Caption := 'CPF: ';
      End;
      fraCadImpostosNFS.strTip_Fc := dbeTip_fc.Text;

    End

    {*****************************************}
    {* VALIDA O CAMPO CÓDIGO DO FOR. / CLI.  *}
    {**************************************MV*}
    Else If (Sender = dbeForCli) Then
    Begin

      If fEmptyStr(dbeForCli.Text) Then
      Begin
        If dbeForCli.Text = 'C' Then
          strCliFor := 'Cliente'
        Else
          strCliFor := 'Fornecedor';

        fMensagem('ATENÇÃO!', 'O código do ' + strCliFor + ' deve ser preenchido!', ['&Ok']);
        Result := False;
      End

      Else
      Begin
        If dbeTip_Fc.Text = 'C' Then
        Begin
          strCliFor := 'Cliente';
          pCarregaCliente;
        End
        Else
        Begin
          strCliFor := 'Fornecedor';
          pCarregaFornecedor;
        End;

        pCarregaPerfil;

        If qryConCli.IsEmpty Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse ' + strCliFor + ' não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else If blnBuscaPorChave Then
        Begin
          If Not fBuscaPorCamposChave Then
          Begin

            if fExisteDocumentoFiscal(dbeNumDoc.Text, dbeForCli.Text, dbeCodEmp.Text, dbeTip_Fc.Text) then
            begin
              if fMensagem('AVISO', 'Já existe um documento lançado com este número de nota,' + sLineBreak +
                                    ' mesma empresa, e mesmo código cliente/fornecedor. ' + sLineBreak +
                                    'Deseja prosseguir com o lançamento?', ['&Sim', '&Não']) = 2 Then
              Exit(False);
            end;

            strForCli := edtNomFor.Text;
            strNomCid := edtCidade.Text;
            strEstado := edtEstado.Text;
            strC_E_P_ := edtNumCep.Text;
            strNomEmp := edtDesEmp.Text;
            strNFComp := dbeNfComple.Text;
            strCTComVen := dbeCTComVen.Text;
            strNfCstEnt := dbeNfCstEnt.Text;
            strSubSerie := dbeSubSerie.Text;

            pLimparCampos;

            dbeNumDoc.Text := strNumDoc;

            edtNomFor.Text := strForCli;
            edtCidade.Text := strNomCid;
            edtEstado.Text := strEstado;
            edtNumCep.Text := strC_E_P_;
            edtDesEmp.Text := strNomEmp;
            dbeNfComple.Text := strNFComp;
            dbeCTComVen.Text := strCTComVen;
            dbeNfCstEnt.Text := strNfCstEnt;
            dbeSubSerie.Text := strSubSerie;

            pHabilitaDadosFiscais;
            pZeraCamposNumericos;

            dbeAlqPis.Field.Value := fCfgSis('ALPISP', varDouble);
            dbeAlqCof.Field.Value := fCfgSis('ALCOFP', varDouble);
          End
          Else
          Begin
            dbeNumDoc.Enabled := False;
            dbeNumDo2.Enabled := False;
            dbeEspDoc.Enabled := False;
            dbeCodEmp.Enabled := False;
            dbeTip_Fc.Enabled := False;
            dbeEntSai.Enabled := False;
            dbeNfComp.Enabled := False;
            dbeSubSerie.Enabled := False;
            dbeForCli.Enabled := False;

            pAtualizaLabelCfopInvalida;
            pCarregaDadosAdicionais;
            pCarregaItens;
            pJustaCamposImpostos;
            pHabilitaNFComplemento;
            pHabilitaCTCompraVenda;

            pHabilitaCamposGerais(qryFisItens.IsEmpty);

            blnMudarFoco := False;
          End;
          If qryTabela.State = dsInsert Then
          Begin
            qryTabela.FieldByName('FIS_DTAENT').AsDateTime := VS_Date;
            qryTabela.FieldByName('FIS_DTADOC').AsDateTime := VS_Date;
          End;

          dbeNumDo2.Text := strNumDo2;
        End;
      End;
      fraCadImpostosNFS.strForCli := dbeForCli.Text;
      fraCadImpostosNFS.pCarregaDadosReinf;
    End

    Else If (Sender = dbeCodEmp) Then
    Begin

      If fEmptyStr(dbeCodEmp.Text) Then
      Begin
        fMensagem('','O código da empresa deve ser preenchido!',['&OK']);
        Result := False;
      End

      Else if (not fValidaAcessoEmpresa) and blnInsert then
      Begin
        fMensagem('ATENÇÃO!', 'Usuário sem Permissão para a empresa escolhida!', ['&O k']);
        Result := False;
      End

      Else
      Begin

        pCarregaEmpresa;
        If qryCadEmp.FieldByName('EMP_CODEMP').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
          Result := False;
        End;

      End;
      fraCadImpostosNFS.strCodEmp := dbeCodEmp.Text;
      pHabilitarTabGia;
    End

    {*****************************************}
    {* VALIDA O CAMPO ENTRADA                *}
    {**************************************MV*}
    Else If (Sender = dbeDtaEnt) Then
    Begin
      If not fValidaDataStr(dbeDtaEnt.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Entrada não é válido!', ['&O k']);
        Result := False;
      End

      Else If fEmptyStr(fTiraCaracEspeciais(dbeDtaEnt.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Entrada deve ser preenchido!', ['&Ok']);
        Result := False;
      End

      Else If (StrToDate(dbeDtaEnt.Text) < StrToDate('01/01/2000')) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data de Entrada não pode ser menor que 01/01/2000!', ['&O k']);
        Result := False;
      End

      Else If Not fValidaFechamentoFiscalEstoque Then
      Begin
        Result := False;
      End

      Else If (StrToDate(dbeDtaDoc.Text) > StrToDate(dbeDtaEnt.Text)) Then
      Begin
        If strDEMQDD = 'A' Then //AVisa;
        Begin
          fMensagem('ATENÇÃO!', 'A Data do Documento não pode ser maior que Data de Entrada!', ['&O k']);
          Result := False;
        End
        Else If strDEMQDD = 'T' Then //Trava;
        Begin
          If Not TEntradaValidacoes.fLiberouDataDocumentoMaiorQueDataEntrada(FormatDateTime('dd/mm/yyyy', StrToDate(dbeDtaEnt.Text)), FormatDateTime('dd/mm/yyyy', StrToDate(dbeDtaDoc.Text))) Then
            Result := False;
        End;
      End;

      fraCadImpostosNFS.dtaDtaEnt := StrToDateDef(dbeDtaEnt.Text, 0);

    End

    {*****************************************}
    {* VALIDA O CAMPO ESPÉCIE                *}
    {**************************************MV*}
    Else If (Sender = dbeEspDoc) Then
    Begin
      If fEmptyStr(dbeEspDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Espécie deve ser preenchido!', ['&Ok']);
        Result := False;
      End;
      pHabilitaCanhotoNF;
      pHabilitaChaveAcesso;
      pHabilitaCTCompraVenda;
      pManipulaCampoCodigoVerificador;
      fraCadImpostosNFS.strEspDoc := dbeEspDoc.Text;

      tbsPessoasCTE.TabVisible := (blnInsert And (dbeEspDoc.Text = 'CT'));
      tbsDocumentosCTE.TabVisible := (dbeEspDoc.Text = 'CT');
      If tbsDocumentosCTE.TabVisible Then
      Begin
        If (qryTabela.State In [dsInsert, dsEdit]) Then
        Begin
          If blnInsert Then
          Begin
            // Na inserção, os botões devem ser habilitados.
            btnDocCTEIncluir.Enabled := True;
            btnDocCTEExcluir.Enabled := True;
          End
          Else
          Begin
            // Na alteração, os botões devem ser habilitados apenas se o CTe for referente a lançamento manual direto no livro.
            btnDocCTEIncluir.Enabled := (qryTabela.FieldByName('FIS_LCTCTE').AsString = 'M');
            btnDocCTEExcluir.Enabled := (qryTabela.FieldByName('FIS_LCTCTE').AsString = 'M');
          End;
        End
        ELse
        Begin
          btnDocCTEIncluir.Enabled := False;
          btnDocCTEExcluir.Enabled := False;
        End
      End;
      gbxBaseFrete.Visible := (dbeEspDoc.Text = 'CT');

      fraCadImpostosNFS.pCarregaDadosReinf;
    End

    {*****************************************}
    {* VALIDA CHAVE DE ACESSO NFE/CTe        *}
    {**************************************GB*}
    Else If (Sender = dbeChaveAcesso) Then
    Begin
      If qryTabela.FieldByName('FIS_ESPDOC').AsString <> 'NS' then
      Begin
        if FChaveAcesso.AlterouChaveAutorizada(dbeChaveAcesso.Text) then
        begin
          dbeChaveAcesso.Undo;
          pMensagemOk('Não é permitido apagar a chave de acesso de uma nota autorizada!');
          Result := False;
        end
        else
        begin
          If Not fEmptyStr(dbeChaveAcesso.Text) Then
          Begin
            Result := fValidaChaveAcessoNFE(dbeChaveAcesso.Text);
            if Result Then
            Begin
              if fCfgSis('VCHACE', varBoolean) Then
              Begin
                If  SameText(dbeEntSai.Text, 'S') Then
                  {Quando é saída, o CNPJ na chave de acesso sempre é do emitente, sendo assim precisa validar o cnpj da empresa.}
                  Result := fValidaChaveAcessoNFE(dbeChaveAcesso.Text, dbeForCli.Text, dbeNumDoc.Text, dbeNfComp.Text, False, fRetCGCEmpresa(dbeCodEmp.Text), False )
                Else
                   Result := fValidaChaveAcessoNFE(dbeChaveAcesso.Text, dbeForCli.Text, dbeNumDoc.Text, dbeNfComp.Text, (dbeTip_Fc.Text = 'C'), fRetCGCEmpresa(dbeCodEmp.Text), ((Length(edtCgcCpf.Text) = 11) And (Pos(qryFisItens.FieldByName('OPCDOC').AsString, 'DV_FE_') < 0)));
                if not Result Then
                  fMensagem('ATENÇÃO!', 'A Chave de Acesso informada não é a mesma da Nota Fiscal Informada!', ['&Ok']);
              End;
            End
            Else
              fMensagem('ATENÇÃO!', 'A Chave de Acesso informada é Inválida!', ['&Ok']);
          End;
        End;
      End;
    End

    Else If (Sender = cbxCodMod) And (Sender.Visible) and
            ((Pos('CANCEL', dbmHistor.Text)  = 0) And
             (Pos('DENEGAD', dbmHistor.Text) = 0) And
             (Pos('INUTIL', dbmHistor.Text)  = 0)) Then
    Begin
      If cbxCodMod.ItemIndex < 0 Then
      Begin
        Result := False;
        pMensagemOk('O modelo do documento deve ser informado!');
      End;
    End

    Else If (Sender = dbeAcenfo) And (tbsDadosCpl.TabVisible) Then
    Begin
      If Not fEmptyStr(dbeAcenfo.Text) Then
      Begin
        Result := fValidaChaveAcessoNFE(dbeAcenfo.Text);
        if not Result Then
          fMensagem('ATENÇÃO!', 'A Chave de Acesso informada é Inválida!', ['&Ok']);
      End;
    End

    {*****************************************}
    {* VALIDA A DATA DO DOCUMETO             *}
    {**************************************MV*}
    Else If (Sender = dbeDtaDoc) Then
    Begin

      If not fValidaDataStr(dbeDtaDoc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Data Documento não é válido!', ['&O k']);
        Result := False;
      End

      Else If fEmptyStr(fTiraCaracEspeciais(dbeDtaDoc.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Data Documento deve ser preenchido!', ['&Ok']);
        Result := False;
      End

      Else If (StrToDate(dbeDtaDoc.Text) < StrToDate('01/01/2000')) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data do Documento não pode ser menor que 01/01/2000!', ['&O k']);
        Result := False;
      End;
      fraCadImpostosNFS.dtaDtaDoc := StrToDateDef(dbeDtaDoc.Text, 0);

    End

	Else If (Sender = fraCadImpostosNFS.dbeCodTipoServico) Then
    Begin
      If fCfgSis('SOLCSV', varBoolean) And (fraCadImpostosNFS.dbeCodTipoServico.Text = '' ) And (fraCadImpostosNFS.dbeCodTipoServico.Visible) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código do tipo de serviço deve ser informado na aba ''Serviços''!', ['&O k']);
        pgcDetalhes.ActivePage := tbsServico;
        Result := False;
      End;

    End

    Else If (Sender = dbeCstPis) Then
    Begin
      If (blnInsert) And
         (blnUTIABR And (dbeCstPis.text = '' )) And
         (((Pos(dbeEspDoc.Text, '_NF_CO') > 0) And (fCfgsis('SIMPAU') = 'N') and (fCfgsis('SIMBRU') = 'N')  And
         ((pos(qryTabela.FieldByName('FIS_CLFSC1').AsString, CFOP_ENERGIA + CFOP_COMUNICACAO) > 0) Or (qryTabela.FieldByName('FIS_CLFSC1').AsInteger < 5000))) or
         ((Pos(dbeEspDoc.Text, 'CT') > 0) And  (pos(Copy(qryTabela.FieldByName('FIS_CLFSC1').AsString, 2, 3), CFOP_CTE) > 0))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A CST de Pis deve ser informada!', ['&O k']);
        pnlGeral.Visible := True;
        Result := False;
      End
      Else
      begin
        Result := fValidaCstCofinsLivro(dbeCstPis, ipcPis, Not blnBuscaPorChave);
        If Result And blnUTIABR And  (not (fCfgsis('SIMPAU') = 'S')) And  (dbeCstPis.text <> '') and (pos(qryTabela.FieldByName('FIS_CLFSC1').AsString, CFOP_ENERGIA + CFOP_COMUNICACAO +  CFOP_SERVICO) > 0) And (Not fCSTCadastrada(True)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A CST de PIS Digitada não foi encontrada na abreviação para esta CFOP!', ['&O k']);
          Result := False;
        End
        Else If Result And (dbeCstPis.text = '' ) And (Pos(qryTabela.FieldByName('FIS_CLFSC1').AsString, CFOP_ENERGIA + CFOP_COMUNICACAO +  CFOP_SERVICO) > 0) And ( not (blnUTIABR)) Then
        Begin
          If fObrigaCSTPis Then
          Begin
            fMensagem('ATENÇÃO!', 'A CST de Pis deve ser informada!', ['&O k']);
            pnlGeral.Visible := True;
            Result := False;
          End;
        End;
      End;
    End

    {**************************************}
    {* VALIDA BASE PIS                    *}
    {***********************************AF*}



    Else If (Sender = dbeBasPis) Then
    Begin

      If fEmptyStr(dbeBasPis.Text) Then
        dbeBasPis.Field.Value := 0;

      If (Not fraCadImpostosNFS.grbRetencoes.Visible) And (blnBuscaPorChave) Then
      Begin
        If (Not blnAlterouPisCofins) And (dbeBasPis.Field.Value > 0) And (fltOldBasPis <> fStrToFloat(dbeBasPis.Text)) Then
        Begin
          dbeTotPis.Field.Value := fFormataFloat((fStrToFloat(dbeBasPis.Text) * IfNull(dbeAlqPis.Field.Value, 0)) / 100, 2);
          blnAlterouPisCofins := True;
          fltOldBasPis := fStrToFloat(dbeBasPis.Text);
        End;
      End;
//      pAjustaCamposRetencoesGrid(TDBEditFocus(Sender));

    End

    Else If (Sender = dbeAlqPis) Then
    Begin
      If (fEmptyStr(dbeAlqPis.Text)) Then
      Begin
        dbeAlqPis.Field.AsFloat := 0.0;
      End
      Else If (fStrToFloat(dbeAlqPis.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A alíquota de PIS deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
      End;
//      pAjustaCamposRetencoesGrid(TDBEditFocus(Sender));

      If Result And (fltOldAlqPis <> fStrToFloat(dbeAlqPis.Text)) Then
      Begin
        dbeTotPis.Field.Value := fFormataFloat((dbeBasPis.Field.Value * IfNull(fStrToFloat(dbeAlqPis.Text), 0)) / 100, 2);
        fltOldAlqPis := fStrToFloat(dbeAlqPis.Text);
      End;

    End

    Else If (Sender = dbeCstCof) Then
    Begin
      If (blnInsert) And
         (blnUTIABR And (dbeCstCof.text = '' )) And
         (((Pos(dbeEspDoc.Text, '_NF_CO') > 0) And (fCfgsis('SIMPAU') = 'N') and (fCfgsis('SIMBRU') = 'N')  And
         ((pos(qryTabela.FieldByName('FIS_CLFSC1').AsString, CFOP_ENERGIA + CFOP_COMUNICACAO) > 0) Or (qryTabela.FieldByName('FIS_CLFSC1').AsInteger < 5000))) or
         ((Pos(dbeEspDoc.Text, 'CT') > 0) And  (pos(Copy(qryTabela.FieldByName('FIS_CLFSC1').AsString, 2, 3), CFOP_CTE) > 0))) Then
      Begin
        fMensagem('ATENÇÃO!', 'A CST de COFINS deve ser informada!', ['&O k']);
        pnlGeral.Visible := True;
        Result := False;
      End
      Else
      begin
        Result := fValidaCstCofinsLivro(dbeCstCof, ipcCofins, Not blnBuscaPorChave);

        If Result And blnUTIABR And  (not (fCfgsis('SIMPAU') = 'S')) And  (dbeCstCof.text <> '') and (pos(qryTabela.FieldByName('FIS_CLFSC1').AsString, CFOP_ENERGIA + CFOP_COMUNICACAO +  CFOP_SERVICO) > 0) And (Not fCSTCadastrada(False)) then
        Begin
          fMensagem('ATENÇÃO!', 'A CST de COFINS Digitada não foi encontrada na abreviação para esta CFOP!', ['&O k']);
          Result := False;
        End
        Else If Result And (dbeCstCof.text = '' ) And (Pos(qryTabela.FieldByName('FIS_CLFSC1').AsString, CFOP_ENERGIA + CFOP_COMUNICACAO +  CFOP_SERVICO) > 0) And ( not (blnUTIABR)) Then
        Begin
          If fObrigaCSTPis Then
          Begin
            fMensagem('ATENÇÃO!', 'A CST de COFINS deve ser informada!', ['&O k']);
            pnlGeral.Visible := True;
            Result := False;
          End;
        End;
      End;
    End

    {**************************************}
    {* VALIDA BASE COFINS                 *}
    {***********************************AF*}


    Else If (Sender = dbeBasCof) Then
    Begin
      If fEmptyStr(dbeBasCof.Text) Then
        dbeBasCof.Field.Value := 0;

      If (Not fraCadImpostosNFS.grbRetencoes.Visible) And (blnBuscaPorChave) Then
      Begin
        If (Not blnAlterouPisCofins) And (dbeBasCof.Field.Value > 0) And (fltOldBasCof <> fStrToFloat(dbeBasCof.Text)) Then
        Begin
          dbeTotCof.Field.Value := fFormataFloat((fStrToFloat(dbeBasCof.Text) * IfNull(dbeAlqCof.Field.Value, 0)) / 100, 2);
          blnAlterouPisCofins := True;
          fltOldBasCof := fStrToFloat(dbeBasCof.Text);
        End;
      End;
//      pAjustaCamposRetencoesGrid(TDBEditFocus(Sender));

    End

    Else If (Sender = dbeAlqCof) Then
    Begin
      If (fEmptyStr(dbeAlqCof.Text)) Then
      Begin
        dbeAlqCof.Field.AsFloat := 0.0;
      End
      Else If (fStrToFloat(dbeAlqCof.Text) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A alíquota de COFINS deve ser maior ou igual a Zero!', ['&Ok']);
        Result := False;
//        pAjustaCamposRetencoesGrid(TDBEditFocus(Sender));
      End;

      If Result And (fltOldAlqCof <> fStrToFloat(dbeAlqCof.Text)) Then
      Begin
        dbeTotCof.Field.Value := fFormataFloat((dbeBasCof.Field.Value * IfNull(fStrToFloat(dbeAlqCof.Text), 0)) / 100, 2);
        fltOldAlqCof := fStrToFloat(dbeAlqCof.Text);
      End;

    End

    Else If (Sender = dbeBasFre) Then
    Begin
      If (Not fEmptyStr(dbeBasFre.Text)) And (Length(Trim(dbeBasFre.Text)) <> 2) Then
      Begin
        fMensagem('','Preencher corretamente o Código de Base de Frete!', ['&Ok']);
        Result := False;
      End
      Else If (Not fEmptyStr(dbeBasFre.Text)) Then
      Begin
        edtDesBasFre.Text := fBuscaBaseFrete(dbeBasFre.Text);

        If Trim(edtDesBasFre.Text) = '' Then
        Begin
          fMensagem('','Código para Base de Frete não encontrado!', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = cmbCodClaConEnergiaEletrica) Then
    Begin
      If (cmbCodClaConEnergiaEletrica.Visible) and (cmbCodClaConEnergiaEletrica.ItemIndex = -1) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para notas de energia elétrica é necessário informar um código de classe consumo!', ['&Ok']);
        pSetFocus(cmbCodClaConEnergiaEletrica);
        Result := False;
      end;
    End

    {*****************************************}
    {* VALIDA CAMPOS REFERENTES À CLASSIFI-  *}
    {* CAÇÃO FISCAL                          *}
    {**************************************MV*}
    Else If (Sender = dbeClfSc1) Or
            (Sender = dbeClfSc2) Or
            (Sender = dbeClfSc3) Or
            (Sender = dbeClfSc4) Or
            (Sender = dbeClfSc5) Then
    Begin
      intNumCampo := StrToInt(RightStr(Sender.Name, 1));

      fraCadImpostosNFS.strClaFis := dbeClfSc1.Text;

      {pManipulaCampoCodigoVerificador;}
      pEnabledCodigoClasseConsumoEnergiaEletrica;

      {**************************************************}
      {* VALIDA CLASSIFICAÇÃO FISCAL EM FUNÇÃO DO LOCAL *}
      {***********************************09/10/2012**CI*}

      dbeCampo  := (fComponentByName(tbsDocs, 'dbeClfSc' + IntToStr(intNumCampo)) As TDBEditFocus);


      If Not TGerenciaModeloPermitidos.fModeloPermitidoParaCFOP(dbeCampo.Text, fGetModDocumentocbxCODMOD) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Classificação Fiscal '+dbeCampo.Text+' não pode ser utlizada no modelo '+fGetModDocumentocbxCODMOD+'!', ['&Ok']);
        Result := False;
      End
      Else
      If intNumCampo = 1 Then
      Begin
        If fEmptyStr(dbeCampo.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo "Classificação Fiscal" da primeira coluna deve ser preenchido!', ['&Ok']);
          Result := False;
        End
      End
      Else If intNumCampo In [2..5] Then
      Begin
        If fEmptyStr(dbeCampo.Text) Then
        Begin
          pLimparCamposFiscais(intNumCampo);
          pHabilitaDadosFiscais(False, intNumCampo);
        End
        Else
          pHabilitaDadosFiscais(True, intNumCampo);
      End
      Else
      Begin
        fMensagem('ATENÇÃO!', 'Você deve usar entre 1 e 5 colunas!', ['&Ok']);
      End;

      If (Result) Then
        Result := fValidaClaFis(dbeCampo.Text);

      //If (Result) And (Not fEmptyStr((Sender As TDBEditFocus).Text)) Then
      If (Result) And (Not fEmptyStr(dbeCampo.Text)) Then
      Begin
        //If Not fVerificaClaFis((Sender As TDBEditFocus).Text) Then
        If Not fVerificaClaFis(dbeCampo.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End
      Else If Not fValidaClaFisCT(qryTabela.FieldByName('FIS_ESPDOC').AsString) Then
        Result := False;

      If fValidarEntradaCFOPFornecedor(dbeCampo.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada no fornecedor!', ['&Ok']);
          Result := False;
        End;

      If fValidarEntradaCT Then
      Begin
        fMensagem('ATENÇÃO!', 'Para esta espécie de documento é preciso informa um CFOP e Modelo de Trasnporte!', ['&Ok']);
        Result := False;
      End;

      If Not Result Then
        pnlGeral.Visible := True;
    End

    {*****************************************}
    {* CAMPOS REFERENTES À BASE DE ICMS      *}
    {**************************************MV*}
    Else If (Sender = dbeBasIc1) Or (Sender = dbeAlqIc1) Or
            (Sender = dbeBasIc2) Or (Sender = dbeAlqIc2) Or
            (Sender = dbeBasIc3) Or (Sender = dbeAlqIc3) Or
            (Sender = dbeBasIc4) Or (Sender = dbeAlqIc4) Or
            (Sender = dbeBasIc5) Or (Sender = dbeAlqIc5) Then
    Begin
      intNumCampo := StrToInt(RightStr(Sender.Name, 1));
      pCalculaValIcm(intNumCampo);
    End

    Else If Sender = dbeNumCoo Then
    Begin

      If (Not dbeCodCon.Visible) Then
        SelectNext(ActiveControl, True, True);

    End
    ELse If Sender = dbeCodCon Then
    Begin

      if fEmptyStr(dbeCodCon.Text) And (qryTabela.State in [dsInsert,dsEdit]) Then
        qryTabela.FieldByName('FIS_CODCON').Clear;

      SelectNext(ActiveControl, True, True);

    End
    Else if (Sender = dbeBasIcm) Or
            (Sender = dbeAlqIcm) Or
            (Sender = dbeValIcm) Or
            (Sender = dbeValFre) Or
            (Sender = dbeDesAce) Or
            (Sender = dbeBasIpi) Or
            (Sender = dbeBaeIpi) Or
            (Sender = dbeAlqIpi) Or
            (Sender = dbeValIpi) Or
            (Sender = dbeAleIpi) Or
            (Sender = dbeVaeIpi) Or
            (Sender = dbeValRet) Or
            (Sender = dbeBasRet) Or
            (Sender = dbeVRetNC) Or
            (Sender = dbeBRetNC) Or
            (Sender = dbeOutras) Or
            (Sender = dbeIsenta) Or
            (Sender = dbeVICMDE) Or

            ((Sender = dbeValAnt) And dbeValAnt.Visible) Or
            ((Sender = dbeBasAnt) And dbeBasAnt.Visible) Then
    Begin
      If fStrToFloat((Sender As TEditFocus).Text) < 0 Then
      Begin
        fMensagem('', 'Os valores devem ser maiores ou iguais a zero!', ['&OK']);
        Result := False;
      End
      Else
      If fPodeRecalcularIcmsIpi Then
      Begin
        pCalculaValorIcmsIpi;
      End;

      If (Sender = dbeVaeIpi) Or (Sender = dbeValIpi) Then
      Begin
        If (fStrToFloat(dbeVaeIpi.Text) > 0) And (fStrToFloat(dbeValIpi.Text) > 0) Then
        Begin
          fMensagem('', 'Não é permitido informar Valor de IPI E Valor de Ipi não creditado.!', ['&OK']);
          Result := False;
        End
        Else If Not fCfgSis('CVIPIA', varBoolean) Then
        Begin
          fltTolerancia := fCfgSis('TDFIPI', varDouble);

          fltValIpiCalc := fFormataFloat(fStrToFloat(dbeBasIpi.Text) * fStrToFloat(dbeAlqIpi.Text) / 100, 2);
          If Not SameValue(fltValIpiCalc, fStrToFloat(dbeValIpi.Text), fltTolerancia+0.005) Then
          Begin
            pMensagemOk('O valor do IPI não corresponde ao resultado de Base IPI x Alq. IPI, já respeitando a tolerância de ' +
              FloatToStrF(fltTolerancia, ffNumber, 12, 2) + '. Por favor, revise Base IPI, Alq. IPI e Valor IPI.');
            Result := False;
          End
          Else
          Begin
            fltValIpiCalc := fFormataFloat(fStrToFloat(dbeBaeIpi.Text) * fStrToFloat(dbeAleIpi.Text) / 100, 2);
            If Not SameValue(fltValIpiCalc, fStrToFloat(dbeVaeIpi.Text), fltTolerancia+0.005) Then
            Begin
              pMensagemOk('O valor do IPI não creditado não corresponde ao resultado de Base IPI Não Cr. x Alq. IPI N Cr., ' +
                'já respeitando a tolerância de ' + FloatToStrF(fltTolerancia, ffNumber, 12, 2) +
                '. Por favor, revise Base IPI, Alq. IPI e Valor IPI.');
              Result := False;
            End;
          End;
        End;
      End
      Else If (Sender = dbeVRetNC) Or (Sender = dbeValRet) Then
      Begin
        If (fStrToFloat(dbeVRetNC.Text) > 0) And (fStrToFloat(dbeValRet.Text) > 0) Then
        Begin
          fMensagem('', 'Não é permitido informar Valor de Retido E Valor de Retido não creditado.!', ['&OK']);
          Result := False;
        End;
      End;
    End
    Else If (Sender = dbeClaFis) Then
    Begin
      blnItemConcreto := fItemConcreto(qryFisItensCODITE.AsString);

      If (Not fEmptyStr((Sender As TEditFocus).Text)) Then
      Begin
        If Not fVerificaClaFis((Sender As TEditFocus).Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal não está cadastrada!', ['&Ok']);
          Result := False;
        End
        Else If (
                  (qryFisItensCODITE.AsString <> fCfgSis('ITESER')) And
                  (qryFisItensCODITE.AsString <> fCfgSis('SERTER')) And
                  (qryFisItensTIPPRO.AsString <> TIPO_PRODUTO_SPED[9,0]) And
                  (Not blnItemConcreto)
                ) And
                (Pos(dbeClaFis.Text, strCLITSV) > 0) Then
        Begin
          strMsg := 'Só é permitido informar CFOP de serviço para um item de serviço';
          If fCfgSis('USACCR', varBoolean) Then
          Begin
            strMsg := strMsg + ' ou item concreto';
          End;
          strMsg := strMsg + '!';

          fMensagem('ATENÇÃO!', strMsg, ['&Ok']);
          Result := False;
        End
        Else Result := fValidaClaFis(dbeClaFis.Text);
      End;
    End

    Else If (Sender = dbeNatCfo) Then
    Begin
      If Not fEmptyStr(dbeNatCfo.Text) Then
      Begin
        If fEmptyStr(cmbNatOpe.Text) Then
          pCarregaNatOperacao(cmbNatOpe, dbeNatCfo.Text);

        If fEmptyStr(cmbNatOpe.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa classificação fiscal está incorreta. Favor verificar!', ['&Ok']);
          Result := False;
        End;
        {Else
        If Not fValidaNatOper Then
        Begin
          fMensagem('Atenção!', 'Na Natureza da Operação só é permitido informar cfop''s que estão presentes nos itens da nota fiscal!', ['&Ok']);
          Result := False;
        End; } // REQ 288200 VAI PERMITIR A ALTERAÇÃO DE CFOP QUE NÃO ESTEJA NO LIVRO! TK
      End;

    End
    Else if (Sender = dbeNcmIte) then
    begin
      if not fEmptyStr(dbeNcmIte.Text) then
      begin
        edtDesNcm.Text := fRetDescricaoNcm(dbeNcmIte.Text);
        If fEmptyStr(edtDesNcm.Text) Then
        begin
          fMensagem('ATENÇÃO!', 'NCM não encontrado!', ['&Ok']);
          dbeNcmIte.Clear;
          edtDesNcm.Clear;
          Result := False;
        end;
      end
      else
        edtDesNcm.Clear;
    end
    Else If (Sender = edtIteCstPis) Then
    Begin
      If Not fEmptyStr(edtIteCstPis.Text) Then
      Begin
        Result := fCstPisValida(edtIteCstPis.Text);
        If Not Result Then
          fMensagem('', 'CST PIS do Item não encontrado.!', ['&Ok']);
      End;
    End

    Else If (Sender = dbeCSTIPI) Then
    Begin
      If Not fEmptyStr(dbeCSTIPI.Text) Then
      Begin
        Result := fCstIPIValidar(dbeCSTIPI.Text);
        If Not Result Then
          fMensagem('', 'CST IPI do Item não encontrado.!', ['&Ok']);
      End;
    End

    Else If (Sender = edtIteCstCof) Then
    Begin
      If Not fEmptyStr(edtIteCstCof.Text) Then
      Begin
//        Result := fCstCofValida(edtIteCstCof.Text);
//        If Not Result Then
//          fMensagem('', 'CST COFINS do Item não encontrado.!', ['&Ok']);
      End;
    End

    Else If (Sender = edtBaseStCat158) Or (Sender = edtValorStCat158) Then
    Begin
      If (Not (RightStr(dbeCodFis.Text, 2) = '60')) And (fCfgSis('X60CAT') = 'S') Then
      Begin
        If (fStrToFloat(edtBaseStCat158.Text) > 0) Or (fStrToFloat(edtValorStCat158.Text) > 0) Then
        Begin
          fMensagem('Aviso', 'É permitido preencher os campos da CAT158, somente para a CST "X60"', ['OK']);
          edtBaseStCat158.Text := '0,00';
          edtValorStCat158.Text := '0,00';
        End;
      End;
    End
    Else If (Sender = dbeCodFis) Then
    Begin
      pDesHab(edtQBCMonoRet);
      pDesHab(edtAdRemICMDRet);
      pDesHab(edtVICMSMonoRet);
      If (RightStr(dbeCodFis.Text, 2) = '61') Then
      Begin
        pHab(edtQBCMonoRet);
        pHab(edtAdRemICMDRet);
        pHab(edtVICMSMonoRet);
      End;
      If (fStrToFloat(edtQBCMonoRet.Text) > 0) And (RightStr(dbeCodFis.Text, 2) <> '61') Then
      Begin
        fMensagem('Aviso', 'Não é permitido preencher os campos do Monofásico quando o Cód. Fiscal for diferente de 61', ['OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtQBCMonoRet) Or (Sender = edtVICMSMonoRet) Or (Sender = edtAdRemICMDRet) Then
    Begin
      If (RightStr(dbeCodFis.Text, 2) <> '61') Then
      Begin
        If (fStrToFloat(edtQBCMonoRet.Text) <= 0) And  ((fStrToFloat(edtVICMSMonoRet.Text) > 0) Or (fStrToFloat(edtAdRemICMDRet.Text) > 0)) Then
        Begin
          fMensagem('Aviso', 'Não é permitido preencher os campos do Monofásico quando o Cód. Fiscal for diferente de 61', ['OK']);
          Result := False;
        End;
      End
      Else If (fStrToFloat(edtQBCMonoRet.Text) <= 0) And  ((fStrToFloat(edtVICMSMonoRet.Text) > 0) Or (fStrToFloat(edtAdRemICMDRet.Text) > 0)) Then
      Begin
        fMensagem('Aviso', 'Não é permitido preencher os campos do Vr.ICMS Monofásico e Alq.Ad Rem quando o valor Qtd.BC.Monofásico for igual a 0', ['OK']);
        edtVICMSMonoRet.Text := '0,00';
        edtAdRemICMDRet.Text := '0,00';
        Result := False;
      End;
    End
    Else If (Sender = edtBaseIcmCat158) Or (Sender = edtAlqIcmCat158) Or (Sender = edtValorIcmCat158) Then
    Begin
      If (Not (RightStr(dbeCodFis.Text, 2) = '60')) And (fCfgSis('X60CAT') = 'S') Then
      Begin
        If (fStrToFloat(edtBaseIcmCat158.Text) > 0) Or
           (fStrToFloat(edtAlqIcmCat158.Text) > 0) Or
           (fStrToFloat(edtValorIcmCat158.Text) > 0) Then
        Begin
          fMensagem('Aviso', 'É permitido preencher os campos da CAT158, somente para a CST "X60"', ['OK']);
          edtBaseIcmCat158.Text := '0,00';
          edtAlqIcmCat158.Text := '0,00';
          edtValorIcmCat158.Text := '0,00';
        End;
      End;
    End

    Else If (Sender = edtIteBasPis) Or
            (Sender = edtIteAlqPis) Or
            (Sender = edtIteBasCof) Or
            (Sender = edtIteAlqCof) Then
    Begin
      If fEmptyStr(edtIteBasPis.Text) Then
        edtIteBasPis.Text := '0,00';

      If fEmptyStr(edtIteAlqPis.Text) Then
        edtIteAlqPis.Text := '0,00';

      If fEmptyStr(edtIteBasCof.Text) Then
        edtIteBasCof.Text := '0,00';

      If fEmptyStr(edtIteAlqCof.Text) Then
        edtIteAlqCof.Text := '0,00';

      pCalculaTotalItemPisCofins;
    End

    Else If (Sender = dbeNfComple) Then
    Begin
      If (Not dbeNfComple.ReadOnly) And (Not fValidoSimNao(dbeNfComple.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'NF Complemento deve ser "S" ou "N"!', ['&Ok']);
        Result := False;
      End;
    End

    Else If (Sender = dbmHistor)Then
    Begin
      If (Not fPermitePalavraNoHistorico('CANCELADO')) Then
        Result := False
      Else If (Not fPermitePalavraNoHistorico('INUTILIZADO')) Then
        Result := False
      Else If (Not fPermitePalavraNoHistorico('DENEGADA')) Then
        Result := False;
    End

    {***********************************}
    { Calcular Valor Total do Documento }
    {********************************RV*}
    Else If (Sender = dbeVlCon1) Or
            (Sender = dbeVlCon2) Or
            (Sender = dbeVlCon3) Or
            (Sender = dbeVlCon4) Or
            (Sender = dbeVlCon5) Then
    Begin
      If (Sender = dbeVlCon1) And
         (fStrToFloat(dbeVlCon1.Text) < 0)  Then
      Begin
        fMensagem('', 'Os valores devem ser maiores ou iguais a zero!', ['&OK']);
        Result := False;
      End
      Else If (Sender = dbeVlCon2) And
         (fStrToFloat(dbeVlCon2.Text) < 0)  Then
      Begin
        fMensagem('', 'Os valores devem ser maiores ou iguais a zero!', ['&OK']);
        Result := False;
      End
      Else If (Sender = dbeVlCon3) And
         (fStrToFloat(dbeVlCon3.Text) < 0)  Then
      Begin
        fMensagem('', 'Os valores devem ser maiores ou iguais a zero!', ['&OK']);
        Result := False;
      End
      Else If (Sender = dbeVlCon4) And
         (fStrToFloat(dbeVlCon4.Text) < 0)  Then
      Begin
        fMensagem('', 'Os valores devem ser maiores ou iguais a zero!', ['&OK']);
        Result := False;
      End
      Else If (Sender = dbeVlCon5) And
         (fStrToFloat(dbeVlCon5.Text) < 0)  Then
      Begin
        fMensagem('', 'Os valores devem ser maiores ou iguais a zero!', ['&OK']);
        Result := False;
      End
      Else
        pCalculaValorDocumento;
    End

    Else If (Sender = dbeCTComVen) Then
    Begin
      If (dbeCTComVen.Visible) Then
      Begin
        If (Not (MatchStr(dbeCTComVen.Text, ['V', 'C']))) Then
        Begin
          fMensagem('ATENÇÃO!', 'Informar se o Conhecimento é de (V)enda ou de (C)ompra!', ['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodAcu) Then
    Begin
      If cbxClaFisAcu.ItemIndex >= 0 Then
      Begin
        If (edtCodAcu.Enabled) And (tbsAcumContDom.Visible) And (fEmptyStr(edtCodAcu.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'É necessário informar o Código do Acumulador.', ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = chkDocumentoConferido) Then
      pConferirDocumento

    Else If (Sender = edtPerAcu) Then
    Begin
      If cbxClaFisAcu.ItemIndex >= 0 Then
      Begin
        If (edtPerAcu.Enabled) And (tbsAcumContDom.Visible) Then
        Begin
          If Not fValidaEscala(edtPerAcu.Text, 0.01, 100) Then
          Begin
            fMensagem('ATENÇÃO!', 'O percentual acumulador deve ser maior que zero e menor ou igual a 100!', ['&Ok']);
            Result := False;
          End;
        End
      End;
    End
    Else Result := fraCadImpostosNFS.fValidaCampos(Sender, blnBuscaPorChave);
  End;

  pAtivaCampoCst;
  pAtivaEventoDeEntrega;

  If Not Result Then
  Begin
    pFindAndActivePage(Sender);
    pSetFocus(Sender);
  End;
end;

function TfrmCadLivroFiscal.fObrigaCSTPis: Boolean;
begin
  Result := not ((fCfgsis('SIMPAU') = 'S') And (fCfgsis('UTIABR') = 'N'));
End;

procedure TfrmCadLivroFiscal.pCalculaTotalItemPisCofins;
begin
  edtIteValPis.Text := FloatToStrF(fFormataFloat(fStrToFloat(edtIteBasPis.Text) * fStrToFloat(edtIteAlqPis.Text) / 100, 4), ffNumber, 12, 2);
  edtIteValCof.Text := FloatToStrF(fFormataFloat(fStrToFloat(edtIteBasCof.Text) * fStrToFloat(edtIteAlqCof.Text) / 100, 4), ffNumber, 12, 2);
end;

procedure TfrmCadLivroFiscal.pHabilitaCanhotoNF;
begin
  If (Not qryTabela.Active) Or (dtsTabela.State = dsBrowse) Then
  Begin
    chkCNHREC.Visible := False;
    Exit;
  End;

  if fCfgSis('LIMCNH', varInteger) > 0 then
  begin
    chkCNHREC.Visible := False;
    Exit;
  end;

  If (qryTabela.FieldByName('FIS_ORIDOC').AsString = 'V') And
     (Pos(qryTabela.FieldByName('FIS_ESPDOC').AsString, 'NF_EL_NS_') > 0) Then
  Begin
    chkCNHREC.Visible := True;

    If (dtsTabela.State = dsInsert) And
       (qryTabela.FieldByName('FIS_CNHREC').IsNull) Then
    Begin
      qryTabela.FieldByName('FIS_CNHREC').AsString := 'N';
    End;
  End
  Else
  Begin
    If (dtsTabela.State = dsInsert) Or (dtsTabela.State = dsEdit) Then
      qryTabela.FieldByName('FIS_CNHREC').AsString := 'N';
  End;
end;

procedure TfrmCadLivroFiscal.pImprimeEspelho;
  Var
    intContador : Integer;
begin

  pInicializaImpressaoCP;

  intContador := 0;

  While (intContador < Length(arrDuplicata)) And
        (Not fEmptyStr(arrDuplicata[intContador].strSequen)) Do
  Begin
    pAdicionaImpressaoCP(qryTabela.FieldByName('FIS_NUMDOC').AsString,
                         arrDuplicata[intContador].strSequen,
                         qryTabela.FieldByName('FIS_FORCLI').AsString,
                         qryTabela.FieldByName('FIS_SERIE_').AsString,
                         Self.Name);

    Inc(intContador);
  End;

  pImprimeCPs;

end;

function TfrmCadLivroFiscal.pIncluirContasPagar(fltTotDoc: Double): Boolean;
var
  blnUtilizouPagamento: Boolean;
  fltTotAdiFis: Double;
  intQtdParc,
  intContador: Integer;
  strGuiaTributo,
  strGuiaTipoTributo: String;
  strHistoricoRentecao: String;
  strLinha: String;
  strAutoIncremPix: String;
  blnGravouContasApagar: Boolean;
  LstrAutInc : String;
  LstrAutIncAuxiliar : String;
  LstrEdtPrevisao : String;
begin
  Result := True;
  If fGravarFinanceiro Then
  Begin
    blnUtilizouPagamento := False;
    blnGravouContasApagar := False;
    fltTotAdiFis := 0;
    intQtdParc := 0;
    If (fEhLancamentoDeNotaServico) and (objPgoAnt.fFornecedorTemPagamentoAntecipado(dbeForCli.Text, True)) and
        (fMensagem('', 'Deseja utilizar pagamento antecipado?', ['&Sim', '&Não']) = 1) Then
    begin
      objPgoAnt.pSetaListaSelecao(Nil);
      objPgoAnt.pSetaFornecedor(dbeForCli.Text);
      objPgoAnt.pSetarDocumentoEntrada(dbeNumDoc.Text, dbeNfComp.Text, 'NS', '', TDate(StrToDate(dbeDtaEnt.Text)), TDate(StrToDate(dbeDtaDoc.Text)), fltTotDoc);
      objPgoAnt.fSelecionaDuplicatas(fltTotDoc, 0, True);
      if objPgoAnt.fGravaPgtosAntecipados('', dbeNumDoc.Text, dbeNfComp.Text, fltTotDoc, '', qryTabela.FieldByName('AUTOINCREM').AsString) then
      begin
        fltTotAdiFis := objPgoAnt.fltTotUso;
        intQtdParc := objPgoAnt.intQtdParc;
        blnUtilizouPagamento := True;
      end
      else
      begin
        pMensagensErro('Não foi possível utilizar pagamento antecipado.', '[Lançamento de contas a pagar (Livro fiscal)]');
        Result := False;
        Exit;
      end;
    end;

    //Caso o total de adiantamento usado seja menor que o total do documento, então entra na rotina para lançar mais parcelas no contas a pagar
    if (fltTotDoc > fltTotAdiFis) then
    begin
      strGuiaTributo     := '';
      strGuiaTipoTributo := '';

      pCriarFormularios(TfrmFiscCtpEntrada, frmFiscCtpEntrada);
      frmFiscCtpEntrada.strCodFor := dbeForCli.Text;
      frmFiscCtpEntrada.strDatCad := dbeDtaEnt.Text;
      frmFiscCtpEntrada.strDtaDoc := dbeDtaDoc.Text;
      frmFiscCtpEntrada.strMemHis := dbmHistor.Text;
      frmFiscCtpEntrada.fltValOri := fltTotDoc;
      frmFiscCtpEntrada.fltValDup := fltTotDoc;
      frmFiscCtpEntrada.strCodEmp := dbeCodEmp.Field.AsString;
      frmFiscCtpEntrada.SetInclusaoManual(True);

      If Assigned(qryCadFor) Then
      Begin
        If Not qryCadFor.IsEmpty Then
        Begin
          frmFiscCtpEntrada.edtCodPor.Text := qryCadFor.FieldByName('FOR_CODPOR').AsString;
          frmFiscCtpEntrada.edtCodCnd.Text := qryCadFor.FieldByName('FOR_CODCND').AsString;
          frmFiscCtpEntrada.mskCndPag.Text := qryCadFor.FieldByName('FOR_CNDPAG').AsString;
        End;
      End;

      if fNFServico  then
        frmFiscCtpEntrada.strCodCta := strCodCta;


      If frmFiscCtpEntrada.ShowModal = mrOK Then
      Begin
        With frmFiscCtpEntrada Do
        Begin
          {*REQ*145940**********RP*}
          If Not fEmpresaTemAcessoPortador(edtCodPor.Text, dbeCodEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
            Exit;
          End;

          If fVerificaDocumentoExisteCtp(dbeCodEmp.Text, dbeNumDoc.Text, dbeNfComp.Text, dbeForCli.Text, Length(dbeNumDoc.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Já existe uma duplicata no contas a pagar com esses dados!' + #13 +
              'Número:' + dbeNumDoc.Text + #13 +
              'Série:' + dbeNfComp.Text, ['&Ok']);
            Result := False;
            Exit;
          End;

          dbeDtaEnt.Text:= frmFiscCtpEntrada.strDatCad;
          dbmHistor.Text:= frmFiscCtpEntrada.strMemHis;
          FDatasetCtpDet.Data := frmFiscCtpEntrada.DatasetCtpDet.Data;
          strAutoIncremPix := frmFiscCtpEntrada.strAutIncPix;

          If (fraCtaPagar.LcbGuiaTributo.KeyValue = Null) Or (fraCtaPagar.LcbGuiaTributo.KeyValue = '-1') Then
            strGuiaTributo:= '0'
          Else
            strGuiaTributo:= fraCtaPagar.LcbGuiaTributo.KeyValue;

          If (fraCtaPagar.LcbTipoTributo.KeyValue = Null) Or (fraCtaPagar.LcbTipoTributo.KeyValue = '-1') Then
            strGuiaTipoTributo:= ''
          Else
            strGuiaTipoTributo:= fraCtaPagar.LcbTipoTributo.KeyValue;

          {Pega a informação a baixo la do frame pois o
          frame oferece a opção do usuario incluir os juros
          e multa assim como desconto se houver}
          fltTotDoc     := frmFiscCtpEntrada.fltValDup;

          fltTotDoc := fltTotDoc - fltTotAdiFis;
          If fltTotDoc > 0 Then
          Begin

            Try
              If fDigDuplic(arrDuplicata,
                            fTiraCaracEspeciais(strCndPagDig),
                            0,
                            fltTotDoc,
                            True,
                            True,
                            False,
                            dbeDtaDoc.Field.AsDateTime,
                            True) Then
              Begin
                intContador := 0;

                strHistoricoRentecao := '';
                If (Not fraCadImpostosNFS.cdsForRet.IsEmpty) Then
                Begin

                  fraCadImpostosNFS.cdsForRet.First;


                  strLinha := StringOfChar(' ', 100);
                  Insert('Vr. Serviço.......:', strLinha, 1);
                  Insert(fPadL(edtTotDoc.Text, 15), strLinha, 21);
                  strHistoricoRentecao := Copy(strLinha, 1 , 36);

                  While not fraCadImpostosNFS.cdsForRet.Eof Do
                  Begin

                    Case (fraCadImpostosNFS.cdsForRet.FieldByName('RET_TIPRET').AsInteger) Of
                      0: Begin
                           strLinha := StringOfChar(' ', 100);
                           Insert('Retenção de PIS...:', strLinha, 1);
                           Insert(fPadL(FormatFloat('#0.00', fraCadImpostosNFS.cdsForRetVALRET.AsFloat), 15), strLinha, 21);
                         End;
                      1: Begin
                           strLinha := StringOfChar(' ', 100);
                           Insert('Retenção de COFINS:', strLinha, 1);
                           Insert(fPadL(FormatFloat('#0.00', fraCadImpostosNFS.cdsForRetVALRET.AsFloat), 15), strLinha, 21);
                         End;
                      2: Begin
                           strLinha := StringOfChar(' ', 100);
                           Insert('Retenção de CSSL..:', strLinha, 1);
                           Insert(fPadL(FormatFloat('#0.00', fraCadImpostosNFS.cdsForRetVALRET.AsFloat), 15), strLinha, 21);
                         End;
                      3: Begin
                           strLinha := StringOfChar(' ', 100);
                           Insert('Retenção de IRRF..:', strLinha, 1);
                           Insert(fPadL(FormatFloat('#0.00', fraCadImpostosNFS.cdsForRetVALRET.AsFloat), 15), strLinha, 21);
                         End;
                      4: Begin
                           strLinha := StringOfChar(' ', 100);
                           Insert('Retenção de INSS..:', strLinha, 1);
                           Insert(fPadL(FormatFloat('#0.00', fraCadImpostosNFS.cdsForRetVALRET.AsFloat), 15), strLinha, 21);
                         End;
                      5: Begin
                           strLinha := StringOfChar(' ', 100);
                           Insert('Retenção de ISS...:', strLinha, 1);
                           Insert(fPadL(FormatFloat('#0.00', fraCadImpostosNFS.cdsForRetVALRET.AsFloat), 15), strLinha, 21);
                         End;
                      6: Begin
                           strLinha := StringOfChar(' ', 100);
                           Insert('Retenção de INSS Patronal...:', strLinha, 1);
                           Insert(fPadL(FormatFloat('#0.00', fraCadImpostosNFS.cdsForRetVALRET.AsFloat), 15), strLinha, 21);
                         End;

                    End;
                    strHistoricoRentecao := strHistoricoRentecao + #$A#$D + Copy(strLinha, 1 , 36);
                    fraCadImpostosNFS.cdsForRet.Next;

                  End;
                  strHistoricoRentecao := strHistoricoRentecao + #$A#$D + 'Vr.Líquido........: ' + fPadL(FormatFloat('#0.00', fltTotDoc), 15);
                End;

                fStartTransaction;

                While (intContador < Length(arrDuplicata)) And
                      (Not fEmptyStr(arrDuplicata[intContador].strSequen)) Do
                Begin
                  //Se for utilizado pagamento antecipado, utiliza a função abaixo para pegar as próximas letras das parcelas, senão sempre  iniciar em "A" o que vai acarretar em erro de duplicidade de chave.
                  if intQtdParc > 0 then
                  begin
                    arrDuplicata[intContador].strSequen := fBuscaParcela(intContador + intQtdParc);
                  end;

                  LstrAutInc := fRetAutoIncrem('CADPAG', dbeCodEmp.Field.AsString);
                  If fGravaCadPag('frmCadLivroFiscal',                            // Nome Form LOGCTP
                                  'INCLUSÃO LIVRO FISCAL',                        // Descrição LOGCTP
                                  dbeForCli.Field.AsString,                       // Fornecedor
                                  dbeNumDoc.Text,                                 // Número da duplicata
                                  arrDuplicata[intContador].strSequen,            // Parcela
                                  dbeCodEmp.Field.AsString,                       // Empresa
                                  fraCtaPagar.edtCodCta.Text,                     // Centro de Custo
                                  dbeNfComp.Field.AsString,                       // Serie do Documento
                                  0,                                              // Sequencial de Baixa
                                  dbeDtaEnt.Field.AsDateTime,                     // Data do lançamento
                                  StrToDateTime(arrDuplicata[intContador].dtaDtaVen),  // Data de Vencimento
                                  arrDuplicata[intContador].curValor,             // Valor da Duplicata
                                  arrDuplicata[intContador].curValor,             // Valor Original
                                  fraCtaPagar.edtPrevis.Text,                     // Previsão?
                                  fraCtaPagar.edtVeiobo.Text,                     // Veio Boleto
                                  fraCtaPagar.edtDeposi.Text,                     // Deposito
                                  dbmHistor.Text + #$A#$D + strHistoricoRentecao, // Histórico 1
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
                                  fraCtaPagar.edtCodEve.Text,                     // Codigo do Evento
                                  fraCtaPagar.edtUsaChq.Text,                     // Usa Cheque
                                  edtCodPor.Text,                                 // Codigo do Portador
                                  dbeNumDoc.Field.AsString,                       // Número do documento
                                  0,
                                  0,
                                  0,
                                  False,
                                  0,
                                  fraCtaPagar.edtTipDoc.Text,
                                  0,
                                  fraCtaPagar.edtVeioNF.Text,
                                  '',
                                  '',
                                  '',
                                  LstrAutInc,
                                  '',
                                  '',
                                  '',
                                  '',
                                  fraCtaPagar.edtUsoCon.Text,
                                  fraCtaPagar.edtCompet.Text,
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
                                  strGuiaTributo,
                                  strGuiaTipoTributo,
                                  fraCtaPagar.strBcoFor,
                                  '',
                                  '',
                                  fraCtaPagar.edtPagAnt.Text,
                                  '',
                                  '',
                                  '',
                                  '',
                                  0,
                                  '',
                                  0,
                                  strAutoIncremPix,
                                  0,
                                  0,
                                  0,
                                  '',
                                  '',
                                  qryTabela.FieldByName('AUTOINCREM').AsString) Then
                  Begin
                    blnGravouContasApagar := True;
                  End;

                  fGravaFatorCalculado(dbeNumDoc.Text,
                                       arrDuplicata[intContador].strSequen,
                                       dbeCodEmp.Field.AsString,
                                       dbeForCli.Field.AsString,
                                       dbeNfComp.Field.AsString,
                                       FDatasetCtpDet,
                                       Self.Name,
                                       True);

                  if intContador = 0 then
                  begin
                    LstrAutIncAuxiliar := LstrAutInc;
                  end;

                  Inc(intContador);

                End;

                fCommit;

                LstrEdtPrevisao := fraCtaPagar.edtPrevis.Text;
                if LstrEdtPrevisao = 'N' then
                begin
                  Try
                    pCriarFormularios(TFrmManipulaContasPagarPrevisaoNao, frmManipulaContasPagarPrevisaoNao) ;
                    frmManipulaContasPagarPrevisaoNao.AUTOINCREM := LstrAutIncAuxiliar ;
                    frmManipulaContasPagarPrevisaoNao.pCarregarDadosCtaPagarComPrevisaoNao ;
                    if frmManipulaContasPagarPrevisaoNao.fCarregarDadosCtaPagarComPrevisaoSim then
                      frmManipulaContasPagarPrevisaoNao.showModal ;
                  Finally
                    FreeAndNil(frmManipulaContasPagarPrevisaoNao) ;
                  End;
                end;

                fMensagem('', 'Lançamento efetuado com sucesso!', ['&O k']);
                If Not fEhNotaEnergiaEletroincaZerada Then
                  If (fCfgSis('IMP_CP', varBoolean)) Then
                  Begin
                    If qryFisItens.IsEmpty Then
                      If fMensagem('', 'Deseja imprimir CP?', ['&Sim', '&Não']) = 1 Then
                        pImprimeEspelho;
                  End;

              End;

            Except

              On E: Exception Do
              Begin
                fRollBack;
                blnGravouContasApagar := False;
                pMensagensErro(E.Message, '[Lançamento de contas a pagar (Livro fiscal)]');
              End;

            End;

          End;
        End;

        FreeAndNil(frmFiscCtpEntrada);

      End;
    end
    else if blnUtilizouPagamento then
    begin
      fMensagem('', 'Adiantamento utilizado com sucesso!', ['&O k']);
    end;

    If ((blnUtilizouPagamento Or blnGravouContasApagar) And (Not fraCadImpostosNFS.cdsForRet.IsEmpty)) Then
    Begin
      Try
        fStartTransaction;

        fraCadImpostosNFS.CtaDet(FDatasetCtpDet);
        fraCadImpostosNFS.strForCli := dbeForCli.Field.AsString;
        fraCadImpostosNFS.fCriarParcelasRetencoesFornecedor(qryTabela.FieldByName('AUTOINCREM').AsString, 'frmCadLivroFiscal');

        fCommit;
      Except

        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[Lançamento das retenções (Livro fiscal)]');
        End;

      End;
    End;

  End;
end;

procedure TfrmCadLivroFiscal.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('FIS_NUMDOC');
  stlCampos.Add('FIS_NUMDO2');
  stlCampos.Add('FIS_CLFSC1');
  stlCampos.Add('FIS_ESPDOC');
  stlCampos.Add('FIS_CODEMP');
  stlCampos.Add('FIS_SERIE_');
  stlCampos.Add('FIS_ENTSAI');
  stlCampos.Add('FIS_TIP_FC');
  stlCampos.Add('FIS_FORCLI');
  stlCampos.Add('FIS_DTAENT');
  stlCampos.Add('FIS_DTADOC');
  stlCampos.Add('FIS_HISTOR');
  stlCampos.Add('FIS_NUMCOO');
  stlCampos.Add('CLI_NOMCLI');
  stlCampos.Add('FOR_NOMFOR');
  stlCampos.Add('AUTOINCREM');


  stlCamInd.Add('FIS_NUMDOC+FIS_CODEMP');
  stlCamInd.Add('FIS_DTAENT');
  stlCamInd.Add('CLI_NOMCLI+FOR_NOMFOR');
  stlCamInd.Add('FIS_FORCLI+FIS_TIP_FC');
  stlCamInd.Add('FIS_CLFSC1+FIS_DTAENT');
  stlCamInd.Add('FIS_NUMCOO');
  stlCamInd.Add('FIS_ACESSO');

  stlDesInd.Add('Documento 1 / Código da Empresa');
  stlDesInd.Add('Data Entrada');
  stlDesInd.Add('Nome Cliente / Nome Fornecedor');
  stlDesInd.Add('Código Cliente-Fornecedor / Cliente-Fornecedor');
  stlDesInd.Add('CFOP / Data Entrada');
  stlDesInd.Add('Número COO');
  stlDesInd.Add('Chave de Acesso');
end;

procedure TfrmCadLivroFiscal.pInicializarTabela(strSQL: String);
begin
  if assigned(qryTabela) then
    freeandnil(qryTabela);

  qryTabela     := fCriarQuery(strSQL, Self);
  qryTabela.AfterOpen := pAfterOpen;
  qryTabela.OnNewRecord := pQryTabelaNewRecord;
  qryTabela.BeforeEdit := pQryTabelaBeforeEdit;
  dtsTabela.DataSet := qryTabela;
end;

procedure TfrmCadLivroFiscal.FormActivate(Sender: TObject);
begin
  inherited;
  pJustaCamposImpostos;

end;

procedure TfrmCadLivroFiscal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Action <> caNone) Then
  Begin
    FDatasetCtpDet := Nil;

    FreeAndNil(qryCidEmp);
    FreeAndNil(qryConCfo);
    FreeAndNil(objLiberacao);
    FreeAndNil(objPgoAnt);
    FreeAndNil(FqryPgoFis);
    FreeAndNil(qryCadNcm);
    FreeAndNil(stlRegistrosExcluidosRECTNF);
    FreeAndNil(FobjTabOrder);
  End;
end;

procedure TfrmCadLivroFiscal.FormCreate(Sender: TObject);
  Var
    intIndex : integer;
begin
  strCLITSV := fCfgSis('CLITSV', varString);
  chkDocumentoConferido.Visible := fCfgSis('DOCCOF', varBoolean);
  pCadastrarGia;
  qryConsultarFinanceiro := TConsultarFinanceiro.Create;

  strENERGIA_ELETRICA := fTransform(fCfgSis('CLAELE', varString), 4);
  strTELECOMUNICACAO := fTransform(fCfgSis('CLATEL', varString), 4);

  blnPulaProcessoEnergia := false;
  fraCadImpostosNFS := TfraCadImpostosNFS.fCriaFrameImpostos(Self, tbsServico);
  pEnabledFraCadImpostosNFS(False);

  inherited;

  pZeraDigDuplic(arrDuplicata);

  blnUTIABR := fCfgSis('UTIABR', varBoolean);
  blnUTICON := fCfgSis('UTICON', varBoolean);
  blnEXPCTB := fCfgSis('EXPCTB', varBoolean);

  btnEventosDeEntrega.Visible := False;

  blnAlterouPisCofins := False;

  pSetaCodIte(qryFisItensCODITE);
  strAutoincrem := '';
  fltMinDocRet := fCfgSis('MINSPR', varDouble);
  fltMinRet    := fCfgSis('MINIMP', varDouble);
  tbsAcumContDom.TabVisible := fCfgSis('UTIACU', varBoolean);
  tbsHistContigencia.TabVisible := fCfgSis('UTIFUL', varBoolean);
  blnEditaBaseCalcPISCofins := fCfgSis('EDTPIS', varBoolean);
  cdsDomAcu.CreateDataSet;
  cdsDocsCTE.CreateDataSet;
  FqryPgoFis := fCriaQuery;

  objFechamentoFiscal := TFechamentoFiscal.Create(Self);
  objFechamentoEstoque := TFechamentoEstoque.Create(Self);

  objLiberacao := TLiberacao.Create;

  blnTemAnt := fTemAntecipacaoIcms;

  lblBasAnt.Visible := blnTemAnt;
  dbeBasAnt.Visible := blnTemAnt;
  lblValAnt.Visible := blnTemAnt;
  dbeValAnt.Visible := blnTemAnt;

  grpIcmsAnte.Visible := blnTemAnt;

  strNomeTabela := 'CADFIS';
  strNomeCampo  := 'FIS_NUMDOC';

  pInicializarTabela('SELECT * FROM CADFIS WHERE FALSE');

  pAtribuiTabelas;

  SetLength(arrCamposChave, 9);
  arrCamposChave[0] := dbeNumDoc;
  arrCamposChave[1] := dbeEntSai;
  arrCamposChave[2] := dbeForCli;
  arrCamposChave[3] := dbeTip_Fc;
  arrCamposChave[4] := dbeCodEmp;
  arrCamposChave[5] := dbeEspDoc;
  arrCamposChave[6] := dbeNfComp; //Série
  arrCamposChave[7] := dbeNfCstEnt;
  arrCamposChave[8] := dbeSubSerie;

  objPgoAnt :=  TEntPagtoAntecipado.Create;

  For intIndex := Low(arrAliICM) To High(arrAliICM) Do
    arrAliICM[intIndex] := 0;

  pgcDetalhes.ActivePageIndex := 0;
  fraCadImpostosNFS.pInicializaDados(qryTabela);

  cdsChaveRef.CreateDataSet;

  {******************}
  {* DESMENBRAMENTO *}
  {*******REQ:195821*}
  pCriaClientTemporariaCtpDet('', '','', '', '', FDatasetCtpDet);

  fraPessoasCTE           := TfraPessoasCTE.Create(Self);
  fraPessoasCTE.Parent    := pnlContainerPessoas;
  fraPessoasCTE.FormPai   := Self;
  fraPessoasCTE.Container := pnlContainerPessoas;
  fraPessoasCTE.ControleQueReceberaOFocoAoTerminar :=  dbeCstPis;
  fraPessoasCTE.PageControlQueReceberaOFocoAoTerminar:= tbsImpostos;
  fraPessoasCTE.pInicializaComponentes(False);
  fraPessoasCTE.Top       := pnlContainerPessoas.Top + 2;
  fraPessoasCTE.Left      := pnlContainerPessoas.Left + 2;

  qryCadNcm   := fCriaQuery(Self);

  FqryUpdNatOpeItem := fCriaQryUpdNatOpeItem;

  FBlnAlterandoItem := False;
  gbxMonofasico.Visible := blnCRDMNF;

  stlRegistrosExcluidosRECTNF := TStringList.Create;
  stlRegistrosExcluidosRECTNF.Duplicates := dupIgnore;
  stlRegistrosExcluidosRECTNF.Sorted := True;

  pRegistrarTabOrderDocs;
end;

procedure TfrmCadLivroFiscal.FormDestroy(Sender: TObject);
begin
  If Assigned(qryAuxFis) Then
    FreeAndNil(qryAuxFis);
  inherited;

  FreeAndNil(qryConsultarFinanceiro);
end;

{ Registra os campos da aba tbsDocs no gerenciador de TabOrder.
  Ordem de navegacao: vertical por coluna - percorre a coluna 1 de cima
  para baixo, depois a coluna 2, ate a coluna 8. }
procedure TfrmCadLivroFiscal.pRegistrarTabOrderDocs;
const
  intColunas = 5;
  arrCamposDocs: array[0..28] of String = (
    'dbeClfSc', 'dbeVlCon', 'dbeBasIc', 'dbeAlqIc', 'dbeVlrIc',
    'dbeOutra', 'dbeIsent', 'dbeBcret', 'dbeRetid', 'dbeBasAn',
    'dbeAntIc', 'dbeBaeRe', 'dbeVaeRet', 'dbeBasIp', 'dbeVlrIp',
    'dbeBaeIP', 'dbeVaEipi', 'dbeBaFcp', 'dbeVlFcp', 'dbeFcpSt',
    'dbeVFcps', 'dbeBcCbs', 'dbeVlCbs', 'dbeBcIbs', 'dbeVlIbs',
    'dbeBc_Is', 'dbeVl_Is', 'dbeQbcMo', 'dbeValMo');
var
  intCol, intLin, intPos: Integer;
  objComp: TComponent;
  arrComponentes: TArray<TWinControl>;
begin
  SetLength(arrComponentes, intColunas * Length(arrCamposDocs));
  intPos := 0;
  for intCol := 1 to intColunas do
    for intLin := Low(arrCamposDocs) to High(arrCamposDocs) do
    begin
      objComp := fComponentByName(tbsDocs, arrCamposDocs[intLin] + IntToStr(intCol));
      if objComp is TWinControl then
      begin
        arrComponentes[intPos] := TWinControl(objComp);
        Inc(intPos);
      end;
    end;
  SetLength(arrComponentes, intPos);

  FobjTabOrder := TGerenciadorTabOrder.Create;
  FobjTabOrder.funPermiteMudarFoco := fPermiteMudarFocoTabOrder;
  FobjTabOrder.evtAoSairDoGrupo    := pIrParaProximaAbaTabOrder;
  FobjTabOrder.pRegistrar(arrComponentes);
end;

{ Ao passar do ultimo campo da tbsDocs por Tab/Enter, avanca para a proxima
  aba visivel do pgcDetalhes (SelectNextPage respeita TabVisible) e coloca o
  foco nela. O pgcDetalhesChange aplica as regras de acesso da aba. }
procedure TfrmCadLivroFiscal.pIrParaProximaAbaTabOrder(Sender: TObject);
begin
  pgcDetalhes.SelectNextPage(True);
  if Assigned(pgcDetalhes.ActivePage) and pgcDetalhes.ActivePage.CanFocus then
    pSetFocus(pgcDetalhes.ActivePage);
end;

{ Replica o contrato de TfrmPai.pProximoControle para o gerenciador de
  TabOrder: componentes com Tag = 99 passam pelo fValidaCampos herdado do
  pai, e o blnMudarFoco e respeitado quando o form ja redirecionou o foco
  (ex.: fIncluiBuscaPorChave cancela a edicao e foca btnAlterar). }
function TfrmCadLivroFiscal.fPermiteMudarFocoTabOrder(AobjComponente: TWinControl): Boolean;
begin
  if AobjComponente.Tag = 99 then
    Result := fValidaCampos(AobjComponente) and blnMudarFoco
  else
    Result := blnMudarFoco;

  blnMudarFoco := True;
end;


procedure TfrmCadLivroFiscal.pCarregaCliente;
Var
  strCidCon: String;
  qryAux   : TUniQuery;
begin

  edtNomFor.Clear;
  edtCgcCpf.Clear;
  edtCidade.Clear;
  edtEstado.Clear;
  edtNumCep.Clear;

  qryConCli := qryCadCli;
  pPesquisaCadCli(qryCadCli, qryConCli, dbeForCli.Text);

  {Cliente}
  If (Pos('CONSUMIDOR', qryConCli.FieldByName('CLI_NOMCLI').AsString) <= 0) Then
  Begin

    With qryConCli Do
    Begin
      edtNomFor.Text := FieldByName('CLI_NOMCLI').AsString;
      fraCadImpostosNFS.strNomFor := edtNomFor.Text;

      edtNumCep.Text := FieldbyName('CLI_C_E_P_').AsString;

      If Length(FieldByName('CLI_C_G_C_').AsString) > 11 Then
        edtCgcCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
      Else
        edtCgcCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);

      edtCgcCpf.Text := FieldByName('CLI_C_G_C_').AsString;

      intCLIREGFIS := FieldByName('CLI_REGFIS').AsInteger;

      strCidCon := fCidadeMovGer(qryTabela.FieldByName('FIS_NUMDOC').AsString,
                                 qryTabela.FieldByName('FIS_ESPDOC').AsString,
                                 qryTabela.FieldByName('FIS_CODEMP').AsString,
                                 qryTabela.FieldByName('FIS_FORCLI').AsString,
                                 qryTabela.FieldByName('FIS_SERIE_').AsString);

      If fEmptyStr(strCidCon) Then
        strCidCon := FieldbyName('CLI_CODCID').AsString;

      pCarregaCidadeEstado(strCidCon);

      If (Not fClienteConsumidor(FieldByName('CLI_NOMCLI').AsString, False, True)) Then
      Begin
        If fEmptyStr(edtEstado.Text) Then
        Begin

          If (qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit) Then
          Begin
            edtEstado.Text := qryConCid.FieldByName('CID_ESTADO').AsString;
          End;

        End;

      End;
      strEstado := edtEstado.Text;
    End;

  End
  Else
  {Consumidor}
  Begin

    qryAux := fCriaQuery;

    Try

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT        ');
      qryAux.SQL.Add('  GER_NOMCON, ');
      qryAux.SQL.Add('  GER_CGCCON, ');
      qryAux.SQL.Add('  GER_CIDCON, ');
      qryAux.SQL.Add('  GER_ESTCON, ');
      qryAux.SQL.Add('  GER_CEPCON  ');
      qryAux.SQL.Add('FROM          ');
      qryAux.SQL.Add('  MOVGER      ');
      qryAux.SQL.Add('WHERE         ');
      qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
      qryAux.SQL.Add('  GER_CODCLI = :CODCLI AND ');
      qryAux.SQL.Add('  GER_SERIE_ = :SERIE_     ');

      qryAux.SQL.Add('UNION ALL     ');

      qryAux.SQL.Add('SELECT        ');
      qryAux.SQL.Add('  GER_NOMCON, ');
      qryAux.SQL.Add('  GER_CGCCON, ');
      qryAux.SQL.Add('  GER_CIDCON, ');
      qryAux.SQL.Add('  GER_ESTCON, ');
      qryAux.SQL.Add('  GER_CEPCON  ');
      qryAux.SQL.Add('FROM          ');
      qryAux.SQL.Add('  NOTGER      ');
      qryAux.SQL.Add('WHERE         ');
      qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
      qryAux.SQL.Add('  GER_CODCLI = :CODCLI AND ');
      qryAux.SQL.Add('  GER_SERIE_ = :SERIE_     ');

      qryAux.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
      qryAux.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
      qryAux.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
      qryAux.ParamByName('CODCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
      qryAux.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
      qryAux.Open;

      If Not qryAux.IsEmpty Then
      Begin

        edtNomFor.Text := qryAux.FieldByName('GER_NOMCON').AsString + ' (CONSUMIDOR)';
        edtCgcCpf.Text := qryAux.FieldByName('GER_CGCCON').AsString;
        edtNumCep.Text := qryAux.FieldByName('GER_CEPCON').AsString;

        If Not qryAux.FieldByName('GER_CIDCON').IsNull Then
        Begin

          strCidCon := qryAux.FieldByName('GER_CIDCON').AsString;
          pCarregaCidadeEstado(strCidCon);

          strEstado := edtEstado.Text;

        End;

      End;

    Finally
      FreeAndNil(qryAux);
    End;

  End;

end;

procedure TfrmCadLivroFiscal.pCarregaComboClassficacaoAcu;
begin
  cbxClaFisAcu.Items.Clear;
  If Not fEmptyStr(dbeClfSc1.Text) Then
    cbxClaFisAcu.Items.Add(dbeClfSc1.Text + ' - ' + dbeAlqIc1.Text + '%');
  If Not fEmptyStr(dbeClfSc2.Text) Then
    cbxClaFisAcu.Items.Add(dbeClfSc2.Text + ' - ' + dbeAlqIc2.Text + '%');
  If Not fEmptyStr(dbeClfSc3.Text) Then
    cbxClaFisAcu.Items.Add(dbeClfSc3.Text + ' - ' + dbeAlqIc3.Text + '%');
  If Not fEmptyStr(dbeClfSc4.Text) Then
    cbxClaFisAcu.Items.Add(dbeClfSc4.Text + ' - ' + dbeAlqIc4.Text + '%');
  If Not fEmptyStr(dbeClfSc5.Text) Then
    cbxClaFisAcu.Items.Add(dbeClfSc5.Text + ' - ' + dbeAlqIc5.Text + '%');
end;

procedure TfrmCadLivroFiscal.pCarregaFornecedor;
begin
  qryConCli := qryCadFor;

  pPesquisaCadFor(qryCadFor, qryConCli, dbeForCli.Text);
  With qryConCli Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
    fraCadImpostosNFS.strNomFor := edtNomFor.Text;
    edtNumCep.Text    := FieldbyName('FOR_C_E_P_').AsString;

    If Length(FieldByName('FOR_C_G_C_').AsString) > 11 Then
      edtCgcCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
    Else
      edtCgcCpf.EditMask := fRetMascaraC_G_C_(fSetaPais, C_P_F_);

    edtCgcCpf.Text := FieldByName('FOR_C_G_C_').AsString;

    strCodCta := FieldByName('FOR_CODCTA').AsString;


    pCarregaCidadeEstado(FieldByName('FOR_CODCID').AsString);

    If fEmptyStr(edtEstado.Text) Then
    Begin

      If (qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit) Then
      Begin
        edtEstado.Text := qryConCid.FieldByName('CID_ESTADO').AsString;
      End;

    End;
    strEstado := edtEstado.Text;
    strCodCfo := qryConCli.FieldByName('FOR_CODCFO').AsString;
    If blnInsert Then
      If strCodCfo.Length = 4 Then
        qryTabela.FieldByName('FIS_CLFSC1').AsString := strCodCfo;

    fraCadImpostosNFS.dbeCodNatRend.Text := IIF(fEmptyStr(qryTabela.FieldByName('FIS_TB01RE').AsString), FieldbyName('FOR_TB01RE').AsString, qryTabela.FieldByName('FIS_TB01RE').AsString);
    fraCadImpostosNFS.dbeCodTipServ.Text := IIF(fEmptyStr(qryTabela.FieldByName('FIS_TB06RE').AsString), FieldbyName('FOR_TB06RE').AsString, qryTabela.FieldByName('FIS_TB06RE').AsString);
    if (not fEmptyStr(fraCadImpostosNFS.dbeCodNatRend.Text)) or (not fEmptyStr(fraCadImpostosNFS.dbeCodTipServ.Text)) then
      fraCadImpostosNFS.pCarregaDadosReinf;
  End;
end;

procedure TfrmCadLivroFiscal.pCarregaPerfil;
var
  qryPerf   : TUniQuery;
begin
  lblPerfCli.Visible := False;

  If (Not fEmptyStr(dbeNumDoc.Text)) And
     (dbeTip_Fc.Text = 'C') And
     (dbeEntsai.Text = 'S') And
     (dbeEspDoc.Text = 'NF') Then
  begin
    qryPerf := fCriaQuery(Self);
    qryPerf.Close;
    qryPerf.Sql.Clear;
    qryPerf.Sql.Add('SELECT ');
    qryPerf.Sql.Add('  SUBSTRING(M.ITE_TIPABF, 6, 3) AS TIPABF ');
    qryPerf.Sql.Add('FROM MOVITE M ');
    qryPerf.Sql.Add('  INNER JOIN MOVDET D ON ');
    qryPerf.Sql.Add('     M.ITE_SEQGER = D.AUTOINCREM ');
    qryPerf.Sql.Add('  WHERE D.DET_CODEMP = :CODEMP ');
    qryPerf.Sql.Add('    AND D.DET_NUMDOC = :NUMDOC ');
    qryPerf.Sql.Add('    AND D.DET_CODCLI = :CODCLI ');
    qryPerf.Sql.Add('    AND D.DET_TIP_FC = "C" ');
    qryPerf.Sql.Add('    AND SUBSTRING(D.DET_CLAFIS, 1, 1) IN ("5", "6", "7") ');
    qryPerf.Sql.Add('    AND D.DET_ESPDOC = "NF" ');
    qryPerf.Sql.Add('  LIMIT 1 ');
    qryPerf.Parambyname('CODEMP').AsString := dbeCodEmp.Text;
    qryPerf.Parambyname('NUMDOC').AsString := dbeNumDoc.Text;
    qryPerf.Parambyname('CODCLI').AsString := dbeForCli.Text;
    qryPerf.Open;

    If Not fEmptyStr(qryPerf.FieldByName('TIPABF').Asstring) Then
    begin
      lblPerfCli.Visible := True;
      edtPerfCli.Text := fSglAbfToDesAbf(qryPerf.FieldByName('TIPABF').Asstring);
    end;

    FreeAndNil(qryPerf);
  end;
end;

procedure TfrmCadLivroFiscal.pCarregaDominioAcumulador;
  Var
    qryAux: TUniQuery;
begin
  cdsDomAcu.EmptyDataSet;

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT * FROM DOMACU WHERE ACU_SEQFIS = :SEQFIS AND ACU_CODEMP = :CODEMP');
  qryAux.ParamByName('SEQFIS').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
  qryAux.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
  qryAux.Open;

  While (Not qryAux.Eof) Do
  Begin
    cdsDomAcu.Append;
    cdsDomAcu.FieldByName('ACU_CLAFIS').AsString := qryAux.FieldByName('ACU_CLAFIS').AsString;
    cdsDomAcu.FieldByName('ACU_CODACU').AsString := qryAux.FieldByName('ACU_CODACU').AsString;
    cdsDomAcu.FieldByName('ACU_PERACU').AsString := qryAux.FieldByName('ACU_PERACU').AsString;
    cdsDomAcu.FieldByName('ACU_ALQICM').AsFloat  := qryAux.FieldByName('ACU_ALQICM').AsFloat;
    cdsDomAcu.Post;
    qryAux.Next;
  End;

  FreeAndNil(qryAux);

  pCarregaComboClassficacaoAcu;
  pLimpaCamposDominioAcumulador;
end;

procedure TfrmCadLivroFiscal.pCarregaCidadeEstado(strCodCid: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CID_CODCID = :CODCID ';

  With qryConCid Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCID').AsString := strCodCid;
    Open;
    edtCidade.Text := FieldbyName('CID_NOMCID').AsString;
    edtEstado.Text := FieldbyName('CID_ESTADO').AsString;
  End;
end;

{****************************************************}
{* BUSCA O ESTADO DA EMPRESA QUE ESTÁ SENDO TRATADA *}
{*************************************09/10/2012**CI*}

procedure TfrmCadLivroFiscal.pCarregaCidadeEmpresa(strCodCid: String);
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADCID ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CID_CODCID = :CODCID ';

  With qryCidEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCID').AsString := strCodCid;
    Open;
  End;
end;

function TfrmCadLivroFiscal.fValidaClaFis(strCampo: String): Boolean;
  Var
    intDigCla: Integer;
begin
  Result := True;

  If (Not fEmptyStr(strCampo)) Then
  Begin
    intDigCla := StrToInt(LeftStr(strCampo, 1));
    If (dbeEntSai.Text = 'E') And (intDigCla >= 5)  Then
    Begin
      fMensagem('ATENÇÃO!', 'Classificação não permitida para nota de entrada!', ['&Ok']);
      Result := False;
    End
    Else If (dbeEntSai.Text = 'S') And (intDigCla < 5) Then
    Begin
      fMensagem('ATENÇÃO!', 'Classificação não permitida para nota de saída!', ['&Ok']);
      Result := False;
    End;

    {**************************************************}
    {* VALIDA CLASSIFICAÇÃO FISCAL EM FUNÇÃO DO LOCAL *}
    {***********************************09/10/2012**CI*}

    If (Result) And
       (qryFisItens.IsEmpty) Then
    Begin
      Result := fVerificaCfopCorreta(strCampo);
    End;
  End;
end;

function TfrmCadLivroFiscal.fValidaClaFisCT(strEspDoc: string; strCFOP: String = ''): Boolean;
Var
   intConCla: Integer;
   dbeClfsc: TDBEditFocus;
begin
  Result := True;

  If Not (fEmptyStr(strCFOP)) Then
  Begin
    If (Pos(strCFOP, '1351_1352_1354_1355_1356_1360_1932_2351_2352_2354_2355_2356_2932') > 0) And (strEspDoc <> 'CT')  Then
    Begin
      fMensagem('ATENÇÃO!', 'Para este tipo de CFOP, deve ser utilizada a espécie "CT".', ['&Ok']);
      Result := False;
      Exit;
    End
    Else If (Pos(strCFOP, '1301_1302_1304_1305_1306_2301_2302_2304_2305_2306_') > 0) And (strEspDoc <> 'CO') Then
    Begin
      fMensagem('ATENÇÃO!', 'Para este tipo de CFOP, deve ser utilizada a espécie "CO".', ['&Ok']);
      Result := False;
      Exit;
    End;
  End;

  For intConCla := 1 To 5 Do
  Begin
    dbeClfsc := (fComponentByName(tbsDocs ,'dbeClfSc' + IntToStr(intConCla)) As TDBEditFocus);

    If (Pos(dbeClfsc.Text, '1351_1352_1354_1355_1356_1360_1932_2351_2352_2354_2355_2356_2932') > 0) And (strEspDoc <> 'CT')  Then
    Begin
      fMensagem('ATENÇÃO!', 'Para este tipo de CFOP, deve ser utilizada a espécie "CT".', ['&Ok']);
      Result := False;
      Exit;
    End
    Else If (Pos(dbeClfsc.Text, '1301_1302_1304_1305_1306_2301_2302_2304_2305_2306_') > 0) And (strEspDoc <> 'CO') Then
    Begin
      fMensagem('ATENÇÃO!', 'Para este tipo de CFOP, deve ser utilizada a espécie "CO".', ['&Ok']);
      Result := False;
      Exit;
    End;
  End;
end;

function TfrmCadLivroFiscal.fValidaClaFisInclusao: Boolean;
Var
   intConCla: Integer;
   dbeClfsc: TDBEditFocus;
begin
  Result := True;

  If (dbeEspDoc.Text <> 'CT') And
     (dbeEspDoc.Text <> 'CO') Then
  Begin
    For intConCla := 1 To 5 Do
    Begin
      dbeClfsc := (fComponentByName(tbsDocs ,'dbeClfSc' + IntToStr(intConCla)) As TDBEditFocus);

      If Pos(dbeClfsc.Text, VS_strClaCom) > 0 Then
      Begin
        Result := (qryTabela.State <> dsInsert);
        Exit;
      End;

      If Pos(dbeClfsc.Text, VS_strClaVen) > 0 Then
      Begin
        Result := (qryTabela.State <> dsInsert);
        Exit;
      End;
    End;
  End;
End;

procedure TfrmCadLivroFiscal.pLimparCamposFiscais(intNumCampo: Integer);
begin
  (fComponentByName(tbsDocs, 'dbeVlCon' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'dbeBasIc' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'dbeAlqIc' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'dbeVlrIc' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'dbeOutra' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'dbeIsent' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'dbeBcret' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'dbeRetid' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'dbeBasIp' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'dbeVlrIp' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'dbeBasAn' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'dbeAntIc' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'dbeBasIp' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'dbeVlrIp' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'dbeBaeRe' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'DBEVAERET' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'dbeBaeIP' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'DBEVAEIPI' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'DBEFCPST' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'DBEVFCPS' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'DBEBAFCP' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'DBEVLFCP' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'DBEQBCMO' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;
  (fComponentByName(tbsDocs, 'DBEVALMO' + IntToStr(intNumCampo)) As TDBEditFocus).Clear;

  If Assigned(qryAuxFis) And qryAuxFis.Active And
     ((Not qryAuxFis.IsEmpty) Or (qryAuxFis.State In [dsEdit, dsInsert])) Then
  Begin
    If Not (qryAuxFis.State In [dsEdit, dsInsert]) Then
      qryAuxFis.Edit;

    qryAuxFis.FieldByName('FIS_BCCBS' + IntToStr(intNumCampo)).AsFloat := 0;
    qryAuxFis.FieldByName('FIS_VLCBS' + IntToStr(intNumCampo)).AsFloat := 0;
    qryAuxFis.FieldByName('FIS_BCIBS' + IntToStr(intNumCampo)).AsFloat := 0;
    qryAuxFis.FieldByName('FIS_VLIBS' + IntToStr(intNumCampo)).AsFloat := 0;
    qryAuxFis.FieldByName('FIS_BC_IS' + IntToStr(intNumCampo)).AsFloat := 0;
    qryAuxFis.FieldByName('FIS_VL_IS' + IntToStr(intNumCampo)).AsFloat := 0;

    qryAuxFis.Post;
  End;
end;


procedure TfrmCadLivroFiscal.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pJustaCamposAllVisible;
  if cdsDocsCTE.Active then
  begin
    cdsDocsCTE.CancelUpdates;
    cdsDocsCTE.EmptyDataSet;
  end;
  blnCRDMNF := fCfgSis('CRDMNF', varString) = 'S';
  dbgItensDBTableViewCitel1.OnDblClick := dbgItensDBTableViewCitel1DblClick;
  pDesabilitaEditsNfComplementar;
  pAtualizaLabelCfopInvalida;
  tbsPessoasCTE.TabVisible := False;
  tbsDocumentosCTE.TabVisible := False;

  blnAlterouPisCofins := False;

  qryFisAju.Cancel;
  pEnabledFisAju;
  pEnabledCodigoClasseConsumoEnergiaEletrica;

  pLimpaEdits;
  pHabilitaCodigo(dbeNumDoc, dbeNumDoc, True);
  pHabilitaDadosFiscais;
  pZeraCamposNumericos;
  qryTabela.FieldByName('FIS_DTAENT').AsDateTime := VS_Date;
  qryTabela.FieldByName('FIS_DTADOC').AsDateTime := VS_Date;
  qryTabela.FieldByName('FIS_LCTCTE').AsString := 'M';
  qryTabela.FieldByName('FIS_ENTSAI').AsString := 'E';
  qryTabela.FieldByName('FIS_TIP_FC').AsString := 'F';
  qryTabela.FieldByName('FIS_CONFER').AsString := '0';
  dbeAlqPis.Field.Value := fCfgSis('ALPISP', varDouble);
  dbeAlqCof.Field.Value := fCfgSis('ALCOFP', varDouble);

  pHabilitaChaveAcesso;
  pHabilitaCTCompraVenda;
  pHabilitaNFComplemento;
  pHabilitaCodMod;
  pHabilitaDadosOffline;

  dbeNfComple.Field.Value := 'N';

  qryFisItens.Close;
  // Limpa os edits e desabilita
  pCarregaItens(True, True);

  blnInsert := True;

  pHabilitaCamposGerais(True);

  edtCgcCpf.Enabled := False;

  fraCadImpostosNFS.strClaFis := dbeClfSc1.Text;
  fraCadImpostosNFS.strEspDoc := dbeEspDoc.Text;
  fraCadImpostosNFS.cdsForRet.Close;
  fraCadImpostosNFS.qryForRet.Close;
  fraCadImpostosNFS.grpRetencaoDados.Visible:= False;
  fraCadImpostosNFS.grpRent.Visible         := False;
  fraCadImpostosNFS.pnlBotoesImp.Visible    := False;
  fraCadImpostosNFS.grbRetencoes.Visible    := False;
  fraCadImpostosNFS.pCarregarRetencoes;


  pCarregaDominioAcumulador;

  pLimpaDadosComplementares;
  pCarregaTipoLancamentoCTE;

  pCarregaModFis(dbeChaveAcesso.Text);

  cmbNatOpe.Items.Clear;
  pCarregarPainelValorLiquido;

  pEnabledFraCadImpostosNFS(True);
  if Assigned(stlRegistrosExcluidosRECTNF) then
    stlRegistrosExcluidosRECTNF.Clear;
end;

procedure TfrmCadLivroFiscal.btnIncluirFisAjuClick(Sender: TObject);
begin
  Try
    pValidaProCod('FISAJU');
    qryFisAju.Insert;
    pEnabledFisAju;
    pOnStateChangeFisAju;
    pSetFocus(edtCodAju);
  Except
    On E: EUniError Do
    Begin
      showMessage(IntToStr(E.ErrorCode));
    End;
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[Inserir Registro]');
    End;
  End;
end;

procedure TfrmCadLivroFiscal.pAtualizaFieldsQryFisItens(strAutInc, strCstPis: String; strAlqPis, fltValPis: Double;
                                     strCstCof: String; fltAlqCof, fltValCof: Double);
Begin
  If (qryFisItens.Locate('AUTOINCREM', strAutInc, [])) Then
  Begin
    qryFisItens.Edit;
    qryFisItens.FieldByName('AUTOINCREM').AsString:= strAutInc;
    qryFisItens.FieldByName('CSTPIS').AsString    := strCstPis;
    qryFisItens.FieldByName('ALQPIS').AsFloat     := strAlqPis;
    qryFisItens.FieldByName('VALPIS').AsFloat     := fltValPis;
    qryFisItens.FieldByName('CSTCOF').AsString    := strCstCof;
    qryFisItens.FieldByName('ALQCOF').AsFloat     := fltAlqCof;
    qryFisItens.FieldByName('VALCOF').AsFloat     := fltValCof;
    qryFisItens.Post;
  End;
End;

procedure TfrmCadLivroFiscal.btnAtualizaCstAliquotaProdutosClick(Sender: TObject);
var
  strCstCofins,
  strCstPis: String;
  fltAliqPis,
  fltValPis,
  fltAliqCofins,
  fltValCofins :Double;
begin
  inherited;

  If qryFisItens.recordcount = 0 Then
    Exit;

  If (fMensagem('', 'Deseja realmente alterar as aliquotas '+
                   'e CST de PIS E COFINS de todos os itens da nota (aba "Itens Documento")?', ['&Sim', '&Não']) = 1) Then
  Begin

    qryFisItens.First;

    while NOT(qryFisItens.eof) do
    Begin
      strCstCofins := dtsTabela.DataSet.FieldByName('FIS_CSTCOF').AsString;

      strCstPis    := dtsTabela.DataSet.FieldByName('FIS_CSTPIS').AsString;

      fltAliqPis   := dtsTabela.DataSet.FieldByName('FIS_ALQPIS').AsFloat;

      fltValPis    := ((qryFisItens.FieldByName('BASPIS').AsFloat * dtsTabela.DataSet.FieldByName('FIS_ALQPIS').AsFloat) / 100);

      fltAliqCofins:= dtsTabela.DataSet.FieldByName('FIS_ALQCOF').AsFloat;

      fltValCofins := ((qryFisItens.FieldByName('BASCOF').AsFloat * dtsTabela.DataSet.FieldByName('FIS_ALQCOF').AsFloat) / 100);

      pAtualizaFieldsQryFisItens(qryFisItens.FieldByName('AUTOINCREM').AsString, strCstPis,
                                 fltAliqPis, fltValPis, strCstCofins, fltAliqCofins, fltValCofins);

      pCarregaItensGrid;

      btnConfirmar.OnClick(Nil);

      qryFisItens.Next;
    End;
    pMensagemOk('Atualização realizada com sucesso!');
  End

end;

procedure TfrmCadLivroFiscal.btnAltDataClick(Sender: TObject);
  Var
    dtaNovaDtaEnt: TDateTime;
    dtaDocumento : TDateTime;
begin
  inherited;
  If qryTabela.State = dsEdit Then
  Begin
    pMensagemOk('Para alterar um documento, o mesmo não pode estar em edição.');
    Exit;
  End;

  If Not fValidaFechamentoFiscalEstoque Then
  Begin
    Exit;
  End;

  If fPermiteAlterarData Then
  Begin

    dtaNovaDtaEnt := qryTabela.FieldByName('FIS_DTAENT').AsDateTime;
    dtaDocumento  := qryTabela.FieldByName('FIS_DTADOC').AsDateTime;

    If ffrmData(dtaNovaDtaEnt, 'Data Entrada', 'Digite a nova data:') Then
    Begin
      If Not fValidaFechamentoFiscalEstoque(dtaNovaDtaEnt) Then
      Begin
        Exit;
      End;

      pAlteraDataDocumento(dtaNovaDtaEnt, dtaDocumento);

      If qryTabela.FieldByName('FIS_ESPDOC').AsString = 'IF' then
      begin
        pMarcarComoImpresso;
      end;
    End;
  End;

end;

function TfrmCadLivroFiscal.fPossuiCtpCtr: Boolean;
Var
  qryCta : TUniQuery;
  strSQL : String;
begin
  qryCta := fCriaQuery;

  strSQL := '';
  Try
    Try
      If (qryTabela.FieldByName('FIS_TIP_FC').AsString = 'F') Then
      Begin
        strSQL := strSQL + ' SELECT COUNT(1) AS QTD FROM CADPAG ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   CTP_CODFOR = :CODFOR AND ';
        strSQL := strSQL + '   CTP_NUMDUP = :NUMDUP AND ';
        strSQL := strSQL + '   CTP_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '   IFNULL(CTP_SERIE_, "") = :SERIE_  ';

        qryCta.SQL.Clear;
        qryCta.SQL.Add(strSQL);

        qryCta.ParamByName('CODFOR').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
        qryCta.ParamByName('NUMDUP').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
        qryCta.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
        qryCta.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
      End
      Else If (qryTabela.FieldByName('FIS_TIP_FC').AsString = 'C') Then
      Begin
        strSQL := '';
        strSQL := strSQL + ' SELECT COUNT(1) AS QTD  ';
        strSQL := strSQL + ' FROM CADREC ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
        strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
        strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC ';

        qryCta.SQL.Clear;
        qryCta.SQL.Add(strSQL);

        qryCta.ParamByName('CODCLI').AsString   := qryTabela.FieldByName('FIS_FORCLI').AsString;
        qryCta.ParamByName('NUMDUP').AsString   := qryTabela.FieldByName('FIS_NUMDOC').AsString;
        qryCta.ParamByName('CODEMP').AsString   := qryTabela.FieldByName('FIS_CODEMP').AsString;
        qryCta.ParamByName('ESPDOC').AsString   := qryTabela.FieldByName('FIS_ESPDOC').AsString;
      End
      Else
      Begin
        Result := False;
        Exit;
      End;

      qryCta.Open;

      Result := qryCta.FieldByName('QTD').AsInteger > 0;
    Except
      On E: Exception DO
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fPossuiCtpCtr]');
      End;
    End;
  Finally
    FreeAndNil(qryCta);
  End;
end;

function TfrmCadLivroFiscal.fPermiteAlterarData: Boolean;
begin
  Result := True;
  If (qryTabela.FieldByName('FIS_ESPDOC').AsString = 'IF') Then
  Begin
    If Not fVerificaAcessoSistema('DTAFIS_IF') Then
    Begin
      pMensagemOk('Você não tem direito para alterar a data do cupom fiscal.');
      Result := False;
    End;
  End
  Else If ((qryTabela.FieldByName('FIS_TIP_FC').AsString <> 'F') And (qryTabela.FieldByName('FIS_ORIDOC').AsString <> 'D')) Or
          (qryTabela.FieldByName('FIS_ENTSAI').AsString <> 'E') Then
  Begin
    pMensagemOk('Só é permitido alterar datas de notas de Entrada de Fornecedores ou Nota de Devolução realizada pela Entrada de Mercadoria.');
    Result := False;
  End
  Else If blnUTICON And fPossuiCtpCtr and (not blnEXPCTB) Then
  Begin
    pMensagemOk('O Módulo Contábil está ativo (CFG_UTICON), não é permitido alterar Data de Entrada para manter a integridade dos dados.');
    Result := False;
  End;
end;

function TfrmCadLivroFiscal.pAlteraContasPagar(const DataSet: TDataSet; fltTotDoc: Double): Boolean;
var
  frmSelCtaPag: TfrmSelCtaPag;
  QryUpdate: TUniQuery;
  objPag: TCadPag;
  objRep: TCadPagRepository;
  strGetFornecedor : String;
begin
  pCriarFormularios(TfrmSelCtaPag, frmSelCtaPag);
  try
    frmSelCtaPag.SetData(DataSet);
    if frmSelCtaPag.ShowModal = MrOk Then
    begin
      QryUpdate := fCriaQuery();
      try
        QryUpdate.SQL.Add('UPDATE CADPAG SET');
        QryUpdate.SQL.Add('  CTP_PREVIS = "N",');
        QryUpdate.SQL.Add('  CTP_VALANT = CTP_VALDUP,');
        QryUpdate.SQL.Add('  CTP_NUMDUP = :NUMDUP,');
        QryUpdate.SQL.Add('  CTP_CODEMP = :CODEMP,');
        QryUpdate.SQL.Add('  CTP_SERIE_ = :SERIE_,');
        QryUpdate.SQL.Add('  CTP_VALDUP = :VALDUP,');
        QryUpdate.SQL.Add('  CTP_VALORI = :VALORI');
        QryUpdate.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM');

        QryUpdate.ParamByName('NUMDUP').AsString := dbeNumDoc.Text;
        QryUpdate.ParamByName('CODEMP').AsString := dbeCodEmp.Field.AsString;
        QryUpdate.ParamByName('SERIE_').AsString := dbeNfComp.Field.AsString;
        QryUpdate.ParamByName('VALDUP').AsFloat := fltTotDoc;
        QryUpdate.ParamByName('VALORI').AsFloat := fltTotDoc;
        QryUpdate.ParamByName('AUTOINCREM').AsString := frmSelCtaPag.Selecionado;

        QryUpdate.ExecSQL;

        objRep := TCadPagRepository.Create;
        objPag := objRep.fRetDuplicata(frmSelCtaPag.Selecionado);

        If Assigned(objPag) Then
        begin
          strGetFornecedor := objPag.objCodFor.FOR_CODFOR;
          untLogCtp.pGravaLogCtp(objPag, 'INCLUSÃO LIVRO FISCAL', 'frmCadLivroFiscal');
        end;

        If Assigned(objRep) Then
          FreeAndNil(objRep);

      finally
        FreeAndNil(QryUpdate);
      end;
      Result := True;
    end
    else
      Result := pIncluirContasPagar(fltTotDoc);
  finally
    pFreeAndNil(frmSelCtaPag);
  end;
end;

function TfrmCadLivroFiscal.fAlteraContasPagarPrevisao(strAutIncCTP: String;
  fltTotDoc: Double): Boolean;
var
  QryUpdate: TUniQuery;
  objPag: TCadPag;
  objRep: TCadPagRepository;
  strGetFornecedor : String;
begin
  QryUpdate := fCriaQuery();
  Try
    QryUpdate.SQL.Add('UPDATE CADPAG SET');
    QryUpdate.SQL.Add('  CTP_PREVIS = "N",');
    QryUpdate.SQL.Add('  CTP_VALANT = CTP_VALDUP,');
    QryUpdate.SQL.Add('  CTP_NUMDUP = :NUMDUP,');
    QryUpdate.SQL.Add('  CTP_CODEMP = :CODEMP,');
    QryUpdate.SQL.Add('  CTP_SERIE_ = :SERIE_,');
    QryUpdate.SQL.Add('  CTP_VALDUP = :VALDUP,');
    QryUpdate.SQL.Add('  CTP_VALORI = :VALORI');
    QryUpdate.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM');

    QryUpdate.ParamByName('NUMDUP').AsString := dbeNumDoc.Text;
    QryUpdate.ParamByName('CODEMP').AsString := dbeCodEmp.Field.AsString;
    QryUpdate.ParamByName('SERIE_').AsString := dbeNfComp.Field.AsString;
    QryUpdate.ParamByName('VALDUP').AsFloat := fltTotDoc;
    QryUpdate.ParamByName('VALORI').AsFloat := fltTotDoc;
    QryUpdate.ParamByName('AUTOINCREM').AsString := strAutIncCTP;

    QryUpdate.ExecSQL;
    Result := (QryUpdate.RowsAffected > 0);

    objRep := TCadPagRepository.Create;
    objPag := objRep.fRetDuplicata(strAutIncCTP);

    If Assigned(objPag) Then
    Begin
      strGetFornecedor := objPag.objCodFor.FOR_CODFOR;
      untLogCtp.pGravaLogCtp(objPag, 'INCLUSÃO LIVRO FISCAL - ALTERACAO PREVISAO', 'frmCadLivroFiscal');
    End;

    If Assigned(objRep) Then
      FreeAndNil(objRep);

  Finally
    FreeAndNil(QryUpdate);
  End;
end;

procedure TfrmCadLivroFiscal.pAlteraDataDocumento(dtaNovaDtaEnt, dtaDocumento: TDateTime);
  Var
    qryItens: TUniQuery;
begin

  qryItens := fCriaQuery(Self);
  try
    pCarregaItensDocumento(qryItens);

    If not fItensComDataBalancoValida(qryItens, dtaNovaDtaEnt) Then
      exit;

    if fEmptyDate(qryTabela.FieldByName('FIS_DTAENT').AsString) then
    begin
      if fCfgSis('TPLREC', varString) = 'N' then
        pMensagemOk('Não é possível alterar a data de entrada, pois o movimento fiscal ainda não foi confirmado!')
      else
        pMensagemOk('Não é possível alterar a data de entrada, pois o plano de recebimento ainda não foi confirmado!');

      exit;
    end;

    If dtaDocumento > dtaNovaDtaEnt Then
    Begin
      If strDEMQDD = 'A' Then //AVisa;
      Begin
        pMensagemOk('A Data do Documento não pode ser maior que Data de Entrada!');
        Exit;
      End
      Else If strDEMQDD = 'T' Then //Trava;
      Begin
        If Not TEntradaValidacoes.fLiberouDataDocumentoMaiorQueDataEntrada(FormatDateTime('dd/mm/yyyy', dtaNovaDtaEnt), FormatDateTime('dd/mm/yyyy', dtaDocumento)) Then
          Exit;
      End;
    End;

    If not fLiberaAlteracaoData(dtaNovaDtaEnt) Then
      Exit;

    If fMensagem('ATENÇÃO!', 'Confirma alterar a data?' + #13#10 +
      'Fazendo isto, o inventário, posição de estoque, apuração de ICMS, ' +
      'entre outros, podem ficar inconsistentes.', ['&Sim', '&Não']) = 1 Then
    Begin
      fStartTransaction;
      Try
        pGravaLogs(dtaNovaDtaEnt);
        pAlteraDataItens(dtaNovaDtaEnt);
        fCommit;

        pMensagemOk('Concluido.');
      Except
        On E: Exception Do
        Begin
          fRollBack;
          pMensagensErro(E.Message, '[pAlteraDataDocumento]');
        End;
      End;
    End;

    qryItens.Close;

  finally
    FreeAndNil(qryItens);
  end;
end;

procedure TfrmCadLivroFiscal.pCarregaItensDocumento(qryItens: TUniQuery);
begin
  qryItens.SQL.Clear;
  qryItens.SQL.Add('SELECT ');
  qryItens.SQL.Add('  CADITE.ITE_CODITE, ');
  qryItens.SQL.Add('  CADITE.ITE_DESITE, ');
  qryItens.SQL.Add('  ITEGER.ITE_DTABAL, ');
  qryItens.SQL.Add('  MOVDET.AUTOINCREM AS AUTINC ');
  qryItens.SQL.Add('FROM ');
  qryItens.SQL.Add('  CADITE ');
  qryItens.SQL.Add('JOIN MOVDET ON DET_CODITE = CADITE.ITE_CODITE ');
  qryItens.SQL.Add('JOIN ITEGER ON ITEGER.ITE_CODITE = CADITE.ITE_CODITE AND ');
  qryItens.SQL.Add('               ITEGER.ITE_CODEMP = DET_CODEMP ');
  qryItens.SQL.Add('WHERE ');
  qryItens.SQL.Add('  DET_NUMDOC = :NUMDOC AND ');
  qryItens.SQL.Add('  DET_ESPDOC = :ESPDOC AND ');
  qryItens.SQL.Add('  DET_CODEMP = :CODEMP AND ');
  qryItens.SQL.Add('  DET_CODFOR = :CODFOR AND ');
  qryItens.SQL.Add('  IFNULL(DET_SERIE_, "") = :SERIE_ AND ');
  qryItens.SQL.Add('  DET_TIP_FC = :TIP_FC ');

  qryItens.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
  qryItens.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
  qryItens.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
  qryItens.ParamByName('CODFOR').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
  qryItens.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
  qryItens.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
  qryItens.Open;
end;


{procedure TfrmCadLivroFiscal.pCriarParcelasRetencoesFornecedor;
  Var
    wrdAno, wrdMes, wrdDia : Word;
    dteVencto, dteUltDiaMes: TDateTime;
    strLogCta, strNumDup, strHist, strTipRet: String;

  function fCalcularDataVencimento: TDateTime; begin
    dteVencto := StrToDateTime(dbeDtaEnt.Text);
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
  end;
begin
  Try
    cdsForRet.DisableControls();
    cdsForRet.First();

    While (Not cdsForRet.Eof) Do Begin
      If (cdsForRet.FieldByName('RET_ALIQUO').AsFloat > 0) And
        (cdsForRet.FieldByName('VALRET').AsFloat > 0) Then Begin
        strNumDup := fRetSequencialCadPag();
        strLogCta := 'INCLUSÃO LIVRO FISCAL';

        Case (cdsForRet.FieldByName('RET_TIPRET').AsInteger) Of
          0: strTipRet := 'RETENÇÃO DE PIS';
          1: strTipRet := 'RETENÇÃO DE COFINS';
          2: strTipRet := 'RETENÇÃO DE CSSL';
          3: strTipRet := 'RETENÇÃO DE IRRF';
          4: strTipRet := 'RETENÇÃO DE INSS';
          5: strTipRet := 'RETENÇÃO DE ISS';
        End;

        strHist := strTipRet + ' do documento ' +
          dbeNumDoc.Field.AsString + '-' + dbeEspDoc.Field.AsString + '-' + dbeCodEmp.Field.AsString +
          ', Fornecedor: ' + dbeForCli.Field.AsString + '-' + edtNomFor.Text +
          ', emitida em ' + dbeDtaDoc.Text + '.';

        fGravaCadPag('frmCadLivroFiscal',                            // Nome Form LOGCTP
                     strLogCta,                                      // Descrição LOGCTP
                     cdsForRet.FieldByName('RET_FORRET').AsString,   // Fornecedor
                     strNumDup,                                      // Número da duplicata
                     'A',                                            // Parcela
                     dbeCodEmp.Field.AsString,                       // Empresa
                     cdsForRet.FieldByName('RET_CODCTA').AsString,   // Centro de Custo
                     '',                                             // Serie do Documento
                     0,                                              // Sequencial de Baixa
                     fNow(),                                         // Data do lançamento
                     fCalcularDataVencimento(),                      // Data de Vencimento
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
                     '',                                             // Codigo do Portador
                     dbeNumDoc.Field.AsString,                       // Número do documento
                     0,
                     0,
                     0);
      End;

      cdsForRet.Next();
    End;
  Finally
    cdsForRet.EnableControls();
  End;
end;

}
procedure TfrmCadLivroFiscal.pDesabilitaBotoesCompValor;
begin
  //Desabilita botões que permitem alteração quando for NF Complemento por Valor
  btnReconstruir.Visible  := strTabela <> 'ITECOM';
  btnAltData.Visible      := (strTabela <> 'ITECOM') And (Not fEmptyStr(strTabela));
  btnAlterarSerie.Visible := strTabela <> 'ITECOM';
  btnAltFor.Visible       := strTabela <> 'ITECOM';
  btnAltEspecie.Visible   := strTabela <> 'ITECOM';
  btnRefresh.Visible      := strTabela <> 'ITECOM';
  pnlItens.Enabled        := strTabela <> 'ITECOM';
end;

procedure TfrmCadLivroFiscal.pDesabilitaEditsNfComplementar;
begin
  btnPesquisarNfEntrada.Enabled := qryTabela.State in [dsInsert,dsEdit];
  btnExcluirNfComplementar.Enabled := qryTabela.State in [dsInsert,dsEdit];

  mskDataNfComplementar.Enabled := False;
  edtNumeroNfComplementar.Enabled := False;
  edtEspecieNfComplementar.Enabled := False;
  edtParticipanteNfComplementar.Enabled := False;
  edtSerieNfComplementar.Enabled := False;
  edtNomPartNfComplementar.Enabled := False;
end;

procedure TfrmCadLivroFiscal.pDistribuiADiferencaDoRateioItens(var fltValAtu,
  fltValDif: Double);
begin
  If ((fltValAtu + fltValDif) >= 0) Then
  Begin
    fltValAtu := fltValAtu + fltValDif;
    fltValDif := 0.0;
  End
  Else
  Begin
    fltValDif := fltValDif + fltValAtu;
    fltValAtu := 0.0;
  End;
end;

procedure TfrmCadLivroFiscal.pEnabledCodigoClasseConsumoEnergiaEletrica;
begin
  If blnPulaProcessoEnergia then
    Exit;
  lblCodigoClasseConsumoEnergiaEletrica.Visible := (Pos(dbeClfSc1.Text, strENERGIA_ELETRICA) > 0);
  cmbCodClaConEnergiaEletrica.Visible := (Pos(dbeClfSc1.Text, strENERGIA_ELETRICA) > 0);
  cmbCodClaConEnergiaEletrica.Enabled := (dtsTabela.State in [dsInsert, dsEdit]);

  grpEnergiaEletrica.Visible := cmbCodClaConEnergiaEletrica.Visible;

  if (qryTabela.FieldByName('FIS_CODCCE').IsNull) or
     (fEmptyStr(qryTabela.FieldByName('FIS_CODCCE').AsString)) then
    cmbCodClaConEnergiaEletrica.ItemIndex := -1
  else
    cmbCodClaConEnergiaEletrica.ItemIndex := qryTabela.FieldByName('FIS_CODCCE').AsInteger - 1;

  lblCodGrupTensao.Visible := (Pos(dbeClfSc1.Text, strENERGIA_ELETRICA) > 0);
  cmbCodGrupTensao.Visible := (Pos(dbeClfSc1.Text, strENERGIA_ELETRICA) > 0);
  cmbCodGrupTensao.Enabled := (dtsTabela.State in [dsInsert, dsEdit]);

  if (qryTabela.FieldByName('FIS_CODGRT').IsNull) or
     (fEmptyStr(qryTabela.FieldByName('FIS_CODGRT').AsString)) then
    cmbCodGrupTensao.ItemIndex := -1
  else
    cmbCodGrupTensao.ItemIndex := qryTabela.FieldByName('FIS_CODGRT').AsInteger - 1;
end;

procedure TfrmCadLivroFiscal.pEnabledFisAju;
begin
  edtCodAju.Enabled := dtsFisAju.State in [dsInsert, dsEdit];
  edtBasIcm.Enabled := dtsFisAju.State in [dsInsert, dsEdit];
  edtAlqIcm.Enabled := dtsFisAju.State in [dsInsert, dsEdit];
  edtValIcm.Enabled := dtsFisAju.State in [dsInsert, dsEdit];
  edtOutros.Enabled := dtsFisAju.State in [dsInsert, dsEdit];
  dbgrFisAju.Enabled := dtsFisAju.State in [dsBrowse];
end;

procedure TfrmCadLivroFiscal.pEnabledFraCadImpostosNFS(const blnEnabled: Boolean);
begin
  fraCadImpostosNFS.Enabled := blnEnabled;
end;

procedure TfrmCadLivroFiscal.pgcDetalhesChange(Sender: TObject);
begin
  inherited;
  pnlGeral.Visible := Not (pgcDetalhes.ActivePage = tbsItens);

  If Assigned(qryTabela.FindField('AUTOINCREM')) Then
  Begin
    If (fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString)) And (pgcDetalhes.ActivePageIndex = 4) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário cadastrar ou pesquisar uma nota fiscal antes de incluir um ou mais ajustes!', ['&Ok']);
      pgcDetalhes.ActivePageIndex := 0;
      Application.ProcessMessages;
      pnlGeral.Visible := True;
    End;
  End;

  pEnabledCodigoClasseConsumoEnergiaEletrica;

  If (tbsAcumContDom.Visible) And (pgcDetalhes.ActivePage = tbsAcumContDom) Then
  begin
    pCarregaComboClassficacaoAcu;
    pLimpaCamposDominioAcumulador;
  end;

  if (pgcDetalhes.ActivePageIndex = 7) and
     (not ((dbeNfComple.Text = 'S') and (dbeEntSai.Text = 'E'))) then
  begin
    fMensagem('ATENÇÃO!', 'Essa aba apenas pode ser acessada por notas de entrada complementares!', ['&Ok']);
    pgcDetalhes.ActivePageIndex := 0;
    Application.ProcessMessages;
  end;

  If pgcDetalhes.ActivePage = tbsServico Then
  Begin
    With fraCadImpostosNFS Do
     If (Not grbRetencoes.Visible) Or (fRetTotalImpostos = 0) Then
      pCarregarRetencoes();
  End;

  If (pgcDetalhes.ActivePage = tbsImpostos) And (qryTabela.State in [dsInsert]) And (Not blnAlterouPisCofins)  Then
  Begin
    If fRegraPisCofins Then
      pCarregaPisCofins(qryTabela.FieldByName('FIS_CLFSC1').AsString, qryTabela.FieldByName('FIS_CSTPIS').AsString, qryTabela.FieldByName('FIS_CSTCOF').AsString);
  End;

  if (pgcDetalhes.ActivePage = tbsGia) then
  begin
    pConsultarGia;
  End;

  if (pgcDetalhes.ActivePage = tbsFinanceiro) then
  begin
    grdFinanceiro
      .ClearItems;
    Case AnsiIndexStr(dbeTip_Fc.Text,['F','C']) Of
      0:  grdFinanceiro
            .DataController
            .DataSource := qryConsultarFinanceiro
              .fAutoIncrem(qryTabela.FieldByName('AUTOINCREM').AsString)
              .fEspecie(dbeEspDoc.Text)
              .fConsultarContasPagar
              .fDataSource;

      1:  grdFinanceiro
            .DataController
            .DataSource := qryConsultarFinanceiro
              .fAutoIncrem(qryTabela.FieldByName('AUTOINCREM').AsString)
              .fEspecie(dbeEspDoc.Text)
              .fConsultarContasReceber
              .fDataSource;
    End;

    grdFinanceiro
      .DataController
      .CreateAllItems;
    grdFinanceiro
      .ApplyBestFit;
    pConfigurarColunaPlanCta;
  end;
end;

procedure TfrmCadLivroFiscal.pConfigurarColunaPlanCta;
  Var
    oCol : TcxGridDBColumn;
begin
  oCol := grdFinanceiro.GetColumnByFieldName('CTA_DESCTA');
  If Not Assigned(oCol) Then
    Exit;

  oCol.OnGetProperties := cxGrid1DBTableView1ButtonsGetProperties;
  grdFinanceiro.OptionsData.Editing := True;
end;

procedure TfrmCadLivroFiscal.cxEditRepository1ButtonItem1PropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
var
  frmRateioPlanCtas : TfrmRateioPlanCtas;
  strNumDup         : String;
  strParcel         : String;
  strSerie          : String;
  strCodeEmp        : String;
  strCodeFor        : String;
  function fGetColVal(AColuna : String): Variant;
  begin
    Result := grdFinanceiro
      .DataController
      .Values[grdFinanceiro.Controller.FocusedRowIndex, grdFinanceiro.GetColumnByFieldName(AColuna).Index];
  end;
begin
  inherited;
  pCriarFormularios(TfrmRateioPlanCtas, frmRateioPlanCtas);
  Try
    strNumDup  := fGetColVal('CTP_NUMDUP');
    strParcel  := fGetColVal('CTP_PARCEL');
    strSerie   := fGetColVal('CTP_SERIE_');
    strCodeEmp := fGetColVal('CTP_CODEMP');
    strCodeFor := fGetColVal('CTP_CODFOR');
    frmRateioPlanCtas.pSetarCtpDet(strNumDup, strParcel, strSerie, strCodeEmp, strCodeFor);
    frmRateioPlanCtas.ShowModal;
  Finally
    frmRateioPlanCtas.Free;
  End;
end;

procedure TfrmCadLivroFiscal.cxGrid1DBTableView1ButtonsGetProperties(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AProperties: TcxCustomEditProperties);
  Var
    strVal : String;
begin
  if (ARecord = nil) then
    Exit;

  If Not fEmptyStr(grdFinanceiro.DataController.DataSource.dataset.fieldByName('CTA_DESCTA').AsString) Then
  Begin
    strVal := ARecord.Values[grdFinanceiro.GetColumnByFieldName('CTA_DESCTA').Index];
    if Copy(strVal, 1, 7) = fCfgSis('CTAPRI', varString) then
      AProperties := cxEditRepository1ButtonItem1.Properties;
  End;
end;

function TfrmCadLivroFiscal.fItensComDataBalancoValida(qryItens: TDataSet; dtaDtaEnt: TDateTime): Boolean;
  Var
    stlProblemas: TStringList;
begin
  Result := True;
  stlProblemas := TStringList.Create;
  qryItens.First;
  While (Not qryItens.Eof) Do
  Begin
    If (dtaDtaEnt <= qryItens.FieldByName('ITE_DTABAL').AsDateTime) Then
    Begin
      stlProblemas.Add('Item ' + qryItens.FieldByName('ITE_CODITE').AsString +
                       ' tem data de balanço maior que data informada.');
    End;

    qryItens.Next;
  End;

  If stlProblemas.Count > 0 Then
  Begin
    Result := False;
    stlProblemas.Insert(0, 'Não será possível alterar a data de entrada. Motivos:');
    pCriarFormularios(TfrmMemo, frmMemo);
    Try
      frmMemo.cxMemo.Lines.Assign(stlProblemas);
      frmMemo.ShowModal;
    Finally
      pFreeAndNil(frmMemo);
    End;
  End;

  FreeAndNil(stlProblemas);

end;

function TfrmCadLivroFiscal.fLiberaAlteracaoData(ANovaDtaEnt : TDateTime): Boolean;
begin
  Result := False;
  If (dbeEntSai.Text <> 'E') then
    Exit(True);
  If(dbeEspDoc.Text <> 'NF') Then
    Exit(True);
  If fVerificaAcessoSistema('PERMALTDTAENTLIVFIS') Then
    Exit(True);
  If fDireitoNovaDataEntrada(ANovaDtaEnt) Then
    Exit(True);
end;

function TfrmCadLivroFiscal.fDireitoNovaDataEntrada(ANovaDtaEnt : TDateTime): Boolean;
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddSeparador(70);
  objLiberacao.objMsgLibera.pAddTexto('ALTERAÇÃO DE DATA DE ENTRADA DE DOCUMENTO');
  objLiberacao.objMsgLibera.pAddSeparador(70);
  objLiberacao.objMsgLibera.pAddTexto('Documento: ' + qryTabela.FieldByName('FIS_NUMDOC').AsString + '-' + qryTabela.FieldByName('FIS_ESPDOC').AsString + '-' + qryTabela.FieldByName('FIS_CODEMP').AsString + '   Série: ' + qryTabela.FieldByName('FIS_SERIE_').AsString);
  If qryTabela.FieldByName('FIS_TIP_FC').AsString = 'F' Then
    objLiberacao.objMsgLibera.pAddTexto('Fornecedor: ' + qryTabela.FieldByName('FIS_FORCLI').AsString + '-' + edtNomFor.text)
  Else
    objLiberacao.objMsgLibera.pAddTexto('Cliente: ' + qryTabela.FieldByName('FIS_FORCLI').AsString + '-' + edtNomFor.text);
  objLiberacao.objMsgLibera.pAddTexto('Dt. Documento: ' + qryTabela.FieldByName('FIS_DTADOC').AsString);
  objLiberacao.objMsgLibera.pAddTexto('');
  objLiberacao.objMsgLibera.pAddTexto('Dt. Entrada Atual: ' + qryTabela.FieldByName('FIS_DTAENT').AsString);
  objLiberacao.objMsgLibera.pAddTexto('Nota Dt. Entrada: ' + DateToStr(ANovaDtaEnt));
  objLiberacao.objMsgLibera.pAddSeparador(70);

  objLiberacao.strDirAce := 'PERMALTDTAENTLIVFIS';
  objLiberacao.strSenLib := '';
  objLiberacao.strMsgSen := 'Alterar Data de Entrada';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.tipCliFor := cfFornecedor;

  Result := objLiberacao.fLibera;
end;


function TfrmCadLivroFiscal.fModeloValidoParaNotaDeComunicao: Boolean;
var
  strModelosPermitidos: String;
begin
  strModelosPermitidos := fTransform(fCfgSis('MODPCO'), 2, ',');
  Result := Pos(fGetModDocumentocbxCODMOD, strModelosPermitidos) > 0;
  If Not Result Then
    fMensagem('ATENÇÃO!', 'O Modelo do documento selecionado['+fGetModDocumentocbxCODMOD+'] não é permitido para notas de Comunicação!' + #$A#$D +
                          'Permitidos [' + strModelosPermitidos+ ']', ['&Ok']);
end;

function TfrmCadLivroFiscal.fVerificaSeExisteTA(strNumDoc, strEspDoc,strCodEmp,strCodFor,strSerie, strTipFc: String): String;
  Var
    qryConsulta: TUniQuery;
Begin
  Result:= '';

  qryConsulta:= fCriaQuery();
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT TA.AUTOINCREM FROM MOVGER ENT ');
    qryConsulta.SQL.Add('               INNER JOIN AUXMOV ON AUX_SEQDOR = ENT.AUTOINCREM ');
    qryConsulta.SQL.Add('               INNER JOIN MOVGER TA ON TA.AUTOINCREM = AUX_SEQGER ');
    qryConsulta.SQL.Add('               LEFT JOIN CADCLI ON CLI_CODCLI = TA.GER_CODCLI ');
    qryConsulta.SQL.Add('               WHERE ENT.GER_NUMDOC = :NUMDOC');
    qryConsulta.SQL.Add('                 AND ENT.GER_ESPDOC = :ESPDOC');
    qryConsulta.SQL.Add('                 AND ENT.GER_CODEMP = :CODEMP');

    If ((Pos(strEspDoc, 'ND_NF_CR_') > 0) Or (strEspDoc = 'XX')) And (strTipFc = 'C') Then
      qryConsulta.SQL.Add('                 AND ENT.GER_CODCLI = :CODPES')
    Else
      qryConsulta.SQL.Add('                 AND ENT.GER_CODFOR = :CODPES');

    qryConsulta.SQL.Add('                 AND IFNULL(ENT.GER_SERIE_, "") = :SERIE_');

    qryConsulta.ParamByName('NUMDOC').AsString:= strNumDoc;
    qryConsulta.ParamByName('ESPDOC').AsString:= strEspDoc;
    qryConsulta.ParamByName('CODEMP').AsString:= strCodEmp;
    qryConsulta.ParamByName('CODPES').AsString:= strCodFor;
    qryConsulta.ParamByName('SERIE_').AsString:= strSerie;

    qryConsulta.Open;

    result:= qryConsulta.FieldByName('AUTOINCREM').AsString;

  Finally
    FreeAndNil(qryConsulta);
  End;

End;

procedure TfrmCadLivroFiscal.pAlteraDataItens(dtaDtaEnt: TDateTime);
  Var
    qryUpd: TUniQuery;
    strSQL,
    strDtaAnt: String;
    strAutInc: String;
  procedure pSetaParametros;
  begin
    qryUpd.ParamByName('DTAENT').AsDateTime := dtaDtaEnt;
    qryUpd.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    qryUpd.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
    qryUpd.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
    qryUpd.ParamByName('CODFOR').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
    qryUpd.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
    qryUpd.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
  end;
begin
  strSQL := '';
  strSQL := strSQL + 'UPDATE ' + strTabela + ' SET ';
  strSQL := strSQL + '  DET_DTAENT = :DTAENT ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  DET_NUMDOC = :NUMDOC AND ';
  strSQL := strSQL + '  DET_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  DET_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  IF(:TIP_FC="C", DET_CODCLI, DET_CODFOR) = :CODFOR AND ';
  strSQL := strSQL + '  IFNULL(DET_SERIE_, "") = :SERIE_ AND ';
  strSQL := strSQL + '  DET_TIP_FC = :TIP_FC ';

  qryUpd := fCriaQuery(Nil);
  Try
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add(strSQL);
    pSetaParametros;
    qryUpd.ExecSQL;
    If VS_AffectedRows > 0 Then
      pGravaLogFis(qryTabela.FieldByName('FIS_DTAENT').AsString,DateToStr(dtaDtaEnt),
                   'DET_DTAENT',strTabela);

    strSQL := AnsiReplaceText(strSQL, 'DET', 'GER');
    qryUpd.SQL.Clear;
    qryUpd.SQL.Add(strSQL);
    pSetaParametros;
    qryUpd.ExecSQL;
    If VS_AffectedRows > 0 Then
      pGravaLogFis(qryTabela.FieldByName('FIS_DTAENT').AsString,DateToStr(dtaDtaEnt),
                   'GER_DTAENT',AnsiReplaceText(strTabela, 'DET', 'GER'));


    strDtaAnt := qryTabela.FieldByName('FIS_DTAENT').AsString;
    qryTabela.Edit;
    qryTabela.FieldByName('FIS_DTAENT').AsDateTime := dtaDtaEnt;
    qryTabela.Post;
    If strDtaAnt <> DateToStr(dtaDtaEnt) Then
      pGravaLogFis(strDtaAnt,DateToStr(dtaDtaEnt),'FIS_DTAENT','CADFIS');

    strAutInc:= fVerificaSeExisteTA(qryTabela.FieldByName('FIS_NUMDOC').AsString,
                                    qryTabela.FieldByName('FIS_ESPDOC').AsString,
                                    qryTabela.FieldByName('FIS_CODEMP').AsString,
                                    qryTabela.FieldByName('FIS_FORCLI').AsString,
                                    qryTabela.FieldByName('FIS_SERIE_').AsString,
                                    qryTabela.FieldByName('FIS_TIP_FC').AsString);

    If strAutInc <> '' Then
    Begin
      qryUpd.Close;
      qryUpd.SQL.Clear;
      qryUpd.SQL.Add('UPDATE MOVGER SET GER_DTAENT = :DTAENT ');
      qryUpd.SQL.Add('            WHERE AUTOINCREM = :AUTINC ');
      qryUpd.ParamByName('DTAENT').AsDateTime := dtaDtaEnt;
      qryUpd.ParamByName('AUTINC').AsString := strAutInc;
      qryUpd.ExecSQL;

      qryUpd.Close;
      qryUpd.SQL.Clear;
      qryUpd.SQL.Add('UPDATE MOVDET SET DET_DTAENT = :DTAENT ');
      qryUpd.SQL.Add('            WHERE DET_SEQGER = :AUTINC ');
      qryUpd.ParamByName('DTAENT').AsDateTime := dtaDtaEnt;
      qryUpd.ParamByName('AUTINC').AsString := strAutInc;
      qryUpd.ExecSQL;
    End;
  Finally
    FreeAndNil(qryUpd);
  End;
end;

function TfrmCadLivroFiscal.fCancelaPagamentoAntecipado(strCliFor, strCodEmp: String): Boolean;

  function fSQLUpdatePagtoAntecipado: String;
    Var
      strSQL: String;
  Begin
    strSQL := '';
    strSQL := strSQL + ' UPDATE CADPAG SET       ';
    strSQL := strSQL + '   CTP_NUMDUP = :DUPORI, ';
    strSQL := strSQL + '   CTP_SERIE_ = :SERORI, ';
    strSQL := strSQL + '   CTP_PARCEL = :PARCEL, ';
    strSQL := strSQL + '   CTP_USOFIS = "N"      ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   AUTOINCREM = :AUTINC  ';
    Result := strSQL;
  End;

  function fSQLMaxParcelaPagtoAntecipado: String;
    Var
      strSQL: String;
  Begin
    strSQL := '';
    strSQL := strSQL + ' SELECT MAX(CTP_PARCEL) AS PARCEL FROM CADPAG ';
    strSQL := strSQL + ' WHERE CTP_NUMDUP = :DUPORI AND IFNULL(CTP_SERIE_, "") = :SERORI AND CTP_CODEMP = :CODEMP AND CTP_CODFOR = :CODFOR';
    Result := strSQL;
  End;

  function fSQLCancelaPagamentoAntecipado: String;
    Var
      strSQL: String;
  Begin
    strSQL := '';
    strSQL := strSQL + ' DELETE FROM PGOFIS     ';
    strSQL := strSQL + ' WHERE                  ';
    strSQL := strSQL + '   PGF_SEQPAG = :SEQPAG ';
    Result := strSQL;
  End;

  Var
    qryUpdate,
    qryParcel,
    qryDelete: TUniQuery;
Begin

  qryParcel := fCriaQuery;
  qryParcel.Close;
  qryParcel.SQL.Clear;
  qryParcel.SQL.Add(fSQLMaxParcelaPagtoAntecipado);

  qryUpdate := fCriaQuery;
  qryUpdate.Close;
  qryUpdate.SQL.Clear;
  qryUpdate.SQL.Add(fSQLUpdatePagtoAntecipado);

  qryDelete := fCriaQuery;
  qryDelete.Close;
  qryDelete.SQL.Clear;
  qryDelete.SQL.Add(fSQLCancelaPagamentoAntecipado);

  If FqryPgoFis.Active Then
  Begin
    FqryPgoFis.First;

    While Not FqryPgoFis.Eof do
    Begin
      qryParcel.Close;
      qryParcel.ParamByName('DUPORI').AsString := FqryPgoFis.FieldByName('PGF_DUPORI').AsString;
      qryParcel.ParamByName('SERORI').AsString := FqryPgoFis.FieldByName('PGF_SERORI').AsString;
      qryParcel.ParamByName('CODFOR').AsString := strCliFor;
      qryParcel.ParamByName('CODEMP').AsString := strCodEmp;
      qryParcel.Open;

      qryUpdate.Close;
      qryUpdate.ParamByName('AUTINC').AsString := FqryPgoFis.FieldByName('PGF_SEQPAG').AsString;
      qryUpdate.ParamByName('DUPORI').AsString := FqryPgoFis.FieldByName('PGF_DUPORI').AsString;
      qryUpdate.ParamByName('SERORI').AsString := FqryPgoFis.FieldByName('PGF_SERORI').AsString;

      If qryParcel.IsEmpty Or fEmptyStr(qryParcel.FieldByName('PARCEL').AsString) Then
        qryUpdate.ParamByName('PARCEL').AsString := 'A'
      Else
        qryUpdate.ParamByName('PARCEL').AsString := Char(Succ(Byte(qryParcel.FieldByName('PARCEL').AsString[1])));

      qryUpdate.ExecSQL;

      qryDelete.Close;
      qryDelete.ParamByName('SEQPAG').AsString := FqryPgoFis.FieldByName('PGF_SEQPAG').AsString;;
      qryDelete.ExecSQL;

      FqryPgoFis.Next;
    End;

  End;

  FreeAndNil(qryDelete);
  FreeAndNil(qryParcel);
  FreeAndNil(qryUpdate);

  Result := True;
End;


function TfrmCadLivroFiscal.fCarregaChavesReferenciadas: Boolean;
var
  qryChavesRef: TUniQuery;
begin
  Result := False;

  cdsChaveRef.EmptyDataSet;

  if (not Assigned(qryTabela)) then
    Exit;

  if (qryTabela.RecordCount <= 0) then
    Exit;

  qryChavesRef := fCriaQuery;
  cdsChaveRef.DisableControls;

  try
    qryChavesRef.Close;
    qryChavesRef.SQL.Clear;
    qryChavesRef.SQL.Add('SELECT FIS_ACESSO');
    qryChavesRef.SQL.Add('FROM REFFIS');
    qryChavesRef.SQL.Add('WHERE FIS_SEQFIS = :SEQFIS');
    qryChavesRef.ParamByName('SEQFIS').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryChavesRef.Open;

    if qryChavesRef.IsEmpty then
      Exit;

    while not qryChavesRef.Eof do
    begin
      cdsChaveRef.Append;
      cdsChaveRefCHAVES.AsString := qryChavesRef.FieldByName('FIS_ACESSO').AsString;
      cdsChaveRef.Post;
      qryChavesRef.Next;
    end;

    cdsChaveRef.First;

    Result := Not cdsChaveRef.IsEmpty;

  finally
    FreeAndNil(qryChavesRef);
    cdsChaveRef.EnableControls;
  end;
end;

procedure TfrmCadLivroFiscal.pApagaCtaPagar(strForCli, strNumDoc, strCodEmp, strSerie, strEspDoc : String; strAutInc: String = ''; AstrListaRetencao: string = '');
var
  objPag: TCadPag;
  objRep: TCadPagRepository;
  strGetFornecedor : String;
  qryCta : TUniQuery;
  qryTemp: TUniQuery;
  strSQL : String;
  strDupDel: String;
  intRecordCount: integer;
begin

  qryCta := fCriaQuery;

  strDupDel := '';
  strSQL := '';
  strSQL := strSQL + ' SELECT AUTOINCREM, CTP_PAGANT, ';
  strSQL := strSQL + '        CTP_NUMDUP, CTP_PARCEL, CTP_SERIE_, CTP_CODFOR, CTP_CODEMP ';
  strSQL := strSQL + '   FROM CADPAG ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CTP_CODFOR = :CODFOR AND ';
  strSQL := strSQL + '   CTP_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '   CTP_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   CTP_SERIE_ = :SERIE_  ';

  With qryCta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODFOR').AsString := strForCli;
    ParamByName('NUMDUP').AsString := strNumDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('SERIE_').AsString := strSerie;

    Open;
    intRecordCount := qryCta.RecordCount;
  End;

  {****************}
  {* GRAVA LOGCTP *}
  {****************}
  objRep := TCadPagRepository.Create;

  While Not qryCta.Eof Do
  Begin

   {Deleta a CTPDET referente a duplicada principal}
    pDeletaCTPDET(qryCta.FieldByName('CTP_NUMDUP').AsString,
                  qryCta.FieldByName('CTP_PARCEL').AsString,
                  IIF(qryCta.FieldByName('CTP_SERIE_').IsNull, '', qryCta.FieldByName('CTP_SERIE_').AsString),
                  qryCta.FieldByName('CTP_CODFOR').AsString,
                  qryCta.FieldByName('CTP_CODEMP').AsString);

    {*******************************************}
    {* MONTA O WHERE DO DELETE                 *}
    {****************************************MV*}
    strDupDel := strDupDel + ' ( CTP_NUMDUP = ' + QuotedStr(qryCta.FieldByName('CTP_NUMDUP').AsString) + ' AND ';
    strDupDel := strDupDel + '   CTP_PARCEL = ' + QuotedStr(qryCta.FieldByName('CTP_PARCEL').AsString) + ' AND ';

    If ((qryCta.FieldByName('CTP_SERIE_').IsNull) or (fEmptyStr(qryCta.FieldByName('CTP_SERIE_').ASString))) Then
      strDupDel := strDupDel + '   IFNULL(CTP_SERIE_, "") = "" AND '
    Else
      strDupDel := strDupDel + '   CTP_SERIE_ = ' + QuotedStr(qryCta.FieldByName('CTP_SERIE_').AsString) + ' AND ';

    strDupDel := strDupDel + '   CTP_CODFOR = ' + QuotedStr(qryCta.FieldByName('CTP_CODFOR').AsString) + ' AND ';
    strDupDel := strDupDel + '   CTP_CODEMP = ' + QuotedStr(qryCta.FieldByName('CTP_CODEMP').AsString) + ') ';

    If (qryCta.RecNo < intRecordCount) Then
      strDupDel := strDupDel + ' OR ';

    objPag := objRep.fRetDuplicata(qryCta.FieldByName('AUTOINCREM').AsString);

    If Assigned(objPag) Then
    begin
      strGetFornecedor := objPag.objCodFor.FOR_CODFOR;
      untLogCtp.pGravaLogCtp(objPag, 'EXCLUSÃO LIVRO FISCAL', 'frmCadLivroFiscal');

      {É necessário remover o pagamento antecipado, pois caso ele seja reutilizado em uma segunda exclusão, }
      {ocorrerá um erro na gravação da tabela DEL_CADPAG devido à chave primária (PK).                      }
      If (qryCta.FieldByName('CTP_PAGANT').AsString = 'N') Then
        objRep.pGravaDelCadPag(objPag, self.Name);
    end;

    qryCta.Next;
  End;

  If Assigned(objRep) Then
    FreeAndNil(objRep);

  fCancelaPagamentoAntecipado(strForCli, strCodEmp);

  qryCta.Close;

  If (Not fEmptyStr(strDupDel)) Then
  Begin
    {*******************************************}
    {* DELETA AS DUPLICATAS                    *}
    {****************************************MV*}
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM CADPAG ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + strDupDel;
    With qryCta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;

    {*******************************************}
    {* DELETA CTPDET(X)                        *}
    {****************************************MV*}
    strSQL := '';
    strSQL := strSQL + 'DELETE FROM CTPDET ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + AnsiReplaceStr(strDupDel, 'CTP_CODEMP', 'CTP_EMPORI');
    With qryCta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ExecSQL;
      Close;
    End;
  End;

  If not fEmptyStr(AstrListaRetencao) Then
  Begin
    strDupDel := '';
    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM CADPAG ';
    strSQL := strSQL + ' WHERE AUTOINCREM IN ('+AstrListaRetencao+')';

    qryTemp := fCriaQuery;
    Try
      With qryTemp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        Open;
        intRecordCount := qryTemp.RecordCount;

        If Not(IsEmpty) Then
        Begin
          objRep := TCadPagRepository.Create;
          Try
            First;
            while not eof do
            Begin

              {Deleta a CTPDET referente a duplicada principal}
              pDeletaCTPDET(qryTemp.FieldByName('CTP_NUMDUP').AsString,
                            qryTemp.FieldByName('CTP_PARCEL').AsString,
                            IIF(qryTemp.FieldByName('CTP_SERIE_').IsNull, '', qryTemp.FieldByName('CTP_SERIE_').AsString),
                            qryTemp.FieldByName('CTP_CODFOR').AsString,
                            qryTemp.FieldByName('CTP_CODEMP').AsString);

              {*******************************************}
              {* MONTA O WHERE DO DELETE                 *}
              {****************************************MV*}
              strDupDel := strDupDel + ' ( CTP_NUMDUP = ' + QuotedStr(qryTemp.FieldByName('CTP_NUMDUP').AsString) + ' AND ';
              strDupDel := strDupDel + '   CTP_PARCEL = ' + QuotedStr(qryTemp.FieldByName('CTP_PARCEL').AsString) + ' AND ';

              If ((qryTemp.FieldByName('CTP_SERIE_').IsNull) or (fEmptyStr(qryTemp.FieldByName('CTP_SERIE_').ASString))) Then
                strDupDel := strDupDel + '   IFNULL(CTP_SERIE_, "") = "" AND '
              Else
                strDupDel := strDupDel + '   CTP_SERIE_ = ' + QuotedStr(qryTemp.FieldByName('CTP_SERIE_').AsString) + ' AND ';

              strDupDel := strDupDel + '   CTP_CODFOR = ' + QuotedStr(qryTemp.FieldByName('CTP_CODFOR').AsString) + ' AND ';
              strDupDel := strDupDel + '   CTP_CODEMP = ' + QuotedStr(qryTemp.FieldByName('CTP_CODEMP').AsString) + ') ';

              If (qryTemp.RecNo < intRecordCount) Then
                strDupDel := strDupDel + ' OR ';

              fVerificaIntegridade(Self.Name, 'CADPAG', qryTemp, True, False, EmptyStr, strLoginUsuarioLogado);

              objPag := objRep.fRetDuplicata(qryTemp.FieldByName('AUTOINCREM').AsString);

              If Assigned(objPag) Then
              begin
                strGetFornecedor := objPag.objCodFor.FOR_CODFOR;
                untLogCtp.pGravaLogCtp(objPag, 'EXCLUSÃO LIVRO FISCAL', 'frmCadLivroFiscal');
              end;

              qryTemp.Next;
            End;
          Finally
            FreeAndNil(objRep);
          End;

          If (Not fEmptyStr(strDupDel)) Then
          Begin
            {*******************************************}
            {* DELETA AS DUPLICATAS                    *}
            {****************************************MV*}
            strSQL := '';
            strSQL := strSQL + 'DELETE FROM CADPAG ';
            strSQL := strSQL + 'WHERE ';
            strSQL := strSQL + strDupDel;
            With qryCta Do
            Begin
              Close;
              SQL.Clear;
              SQL.Add(strSQL);
              ExecSQL;
              Close;
            End;

            {*******************************************}
            {* DELETA CTPDET(X)                        *}
            {****************************************MV*}
            strSQL := '';
            strSQL := strSQL + 'DELETE FROM CTPDET ';
            strSQL := strSQL + 'WHERE ';
            strSQL := strSQL + AnsiReplaceStr(strDupDel, 'CTP_CODEMP', 'CTP_EMPORI');
            With qryCta Do
            Begin
              Close;
              SQL.Clear;
              SQL.Add(strSQL);
              ExecSQL;
              Close;
            End;
          End;
        End;
      End;
    Finally
      FreeAndNil(qryTemp);
    End;
  End;
  FreeAndNil(qryCta);
end;

procedure TfrmCadLivroFiscal.pAlterarDataCadastro(strAutInc: String;
  dtaCadastro: TDate);
var
  qryCta : TUniQuery;
  blnTemParcA: Boolean;
begin
  qryCta := fCriaQuery;
  Try

    qryCta.SQL.Add('SELECT COUNT(1) AS QTD ');
    qryCta.SQL.Add('FROM CADPAG A ');
    qryCta.SQL.Add('INNER JOIN CADPAG B ');
    qryCta.SQL.Add('      ON  A.CTP_CODFOR = B.CTP_CODFOR ');
    qryCta.SQL.Add('      AND A.CTP_CODEMP = B.CTP_CODEMP ');
    qryCta.SQL.Add('      AND A.CTP_NUMDUP = B.CTP_NUMDUP ');
    qryCta.SQL.Add('      AND A.CTP_SERIE_ = B.CTP_SERIE_ ');
    qryCta.SQL.Add('      AND A.CTP_SEQBAI = B.CTP_SEQBAI ');
    qryCta.SQL.Add('WHERE A.AUTOINCREM = :AUTOINC ');
    qryCta.SQL.Add('  AND B.AUTOINCREM <> :AUTOINC ');
    qryCta.SQL.Add('  AND B.CTP_PARCEL = "A" ');
    qryCta.ParamByName('AUTOINC').AsString := strAutInc;
    qryCta.Open;

    blnTemParcA := qryCta.FieldByName('QTD').AsInteger > 0;

    qryCta.Close;
    qryCta.SQL.Clear;
    qryCta.SQL.Add('UPDATE CADPAG SET');
    qryCta.SQL.Add(' CTP_DTACAD = :DTAVEN ');
    qryCta.SQL.Add(' ,CTP_COMPET = :COMPET ');

    If (Not blnTemParcA) Then
      qryCta.SQL.Add(' ,CTP_PARCEL = "A" ');

    qryCta.SQL.Add(' WHERE AUTOINCREM = :AUTOINCREM ');
    qryCta.ParamByName('AUTOINCREM').AsString := strAutInc;
    qryCta.ParamByName('DTAVEN').AsDateTime := dtaCadastro;
    qryCta.ParamByName('COMPET').AsString := FormatDateTime('mm/YYYY',dtaCadastro);
    qryCta.Execute;
  Finally
    FreeAndNil(qryCta);
  End;

end;

procedure TfrmCadLivroFiscal.pAlterarVencimento(strAutInc: String; dtaVencimento: TDate);
var
  qryCta : TUniQuery;
begin
  qryCta := fCriaQuery;
  Try
    qryCta.SQL.Add('UPDATE CADPAG SET');
    qryCta.SQL.Add('CTP_DTAVEN = :DTAVEN');
    qryCta.SQL.Add('WHERE AUTOINCREM = :AUTOINCREM ');
    qryCta.ParamByName('AUTOINCREM').AsString := strAutInc;
    qryCta.ParamByName('DTAVEN').AsDateTime := dtaVencimento;
    qryCta.Execute;
  Finally
    FreeAndNil(qryCta);
  End;
end;


procedure TfrmCadLivroFiscal.pApagaMovGer(strNumDoc, strEspDoc, strCodEmp,
  strForCli, strSerie: String);
  var qryComand: TUniQuery;
begin
  qryComand := fCriaQuery;
  Try
    qryComand.SQL.Add('DELETE FROM MOVGER');
    qryComand.SQL.Add('  WHERE GER_NUMDOC = "'+strNumDoc+'"');
    qryComand.SQL.Add('    AND GER_CODEMP = "'+strCodEmp+'"');
    qryComand.SQL.Add('    AND GER_CODFOR = "'+strForCli+'"');
    qryComand.SQL.Add('    AND GER_ESPDOC = "'+strEspDoc+'"');
    qryComand.SQL.Add('    AND IFNULL(GER_SERIE_, "") = "'+strSerie+'"');
    qryComand.SQL.Add('    AND GER_MEN001 = "NOTA DE SERVICO FORNECEDOR"');
    qryComand.ExecSQL;
  Finally
    FreeAndNil(qryComand);
  End;

end;

procedure TfrmCadLivroFiscal.pGravaDominioAcumulador;
  Var
    qryAux    : TUniQuery;
    strSeqFis : String;
    strCodEmp : String;
    strSQL    : String;
begin
  strSeqFis := qryTabela.FieldByName('AUTOINCREM').AsString;
  strCodEmp := qryTabela.FieldByName('FIS_CODEMP').AsString;

  qryAux := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DOMACU ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ACU_SEQFIS = :SEQFIS AND ';
  strSQL := strSQL + '  ACU_CODEMP = :CODEMP ';

  With qryDomAcu Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('SEQFIS').AsString := strSeqFis;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If (RecordCount > 0) Then
    Begin
      qryAux.SQL.Clear;
      qryAux.SQL.Add('DELETE FROM DOMACU WHERE ACU_SEQFIS = :SEQFIS AND ACU_CODEMP = :CODEMP');
      qryAux.ParamByName('SEQFIS').AsString := strSeqFis;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ExecSQL;
      qryAux.Close;

      Close;
      Open;
    End;

    cdsDomAcu.First;
    While (Not cdsDomAcu.Eof) Do
    Begin
      Append;
    	FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('DOMACU', VS_strCodEmp);
    	FieldByName('ACU_SEQFIS').AsString := strSeqFis;
    	FieldByName('ACU_CLAFIS').AsString := cdsDomAcu.FieldByName('ACU_CLAFIS').AsString;
    	FieldByName('ACU_ALQICM').AsFloat  := cdsDomAcu.FieldByName('ACU_ALQICM').AsFloat;
    	FieldByName('ACU_CODACU').AsString := cdsDomAcu.FieldByName('ACU_CODACU').AsString;
    	FieldByName('ACU_PERACU').AsFloat  := cdsDomAcu.FieldByName('ACU_PERACU').AsFloat;
    	FieldByName('ACU_CODEMP').AsString := strCodEmp;
      Post;
      cdsDomAcu.Next;
    End;

    Close;
  End;

  FreeAndNil(qryAux);
end;

procedure TfrmCadLivroFiscal.pGravaLogFis(strValAnt, strValAtu, strNomCam,
  strNomTab: String);
  Var
    qryLog: TUniQuery;
begin
  Try
    qryLog := fCriaQuery(Self);
    qryLog.SQL.Add('INSERT INTO LOGFIS (LOG_NUMDOC, LOG_ESPDOC, LOG_CODEMP, ');
    qryLog.SQL.Add(' LOG_FORCLI, LOG_SERIE_, LOG_TIP_FC, LOG_VALANT, LOG_VALATU, ');
    qryLog.SQL.Add(' LOG_CODOPE, LOG_DTAALT, LOG_HORALT, LOG_NOMCAM, LOG_NOMTAB)');
    qryLog.SQL.Add('VALUES (:NUMDOC, :ESPDOC, :CODEMP, :FORCLI, :SERIE_, :TIP_FC,');
    qryLog.SQL.Add(' :VALANT, :VALATU, :CODOPE, :DTAALT, :HORALT, :NOMCAM, :NOMTAB) ');

    qryLog.ParamByName('NUMDOC').AsString   := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    qryLog.ParamByName('ESPDOC').AsString   := qryTabela.FieldByName('FIS_ESPDOC').AsString;
    qryLog.ParamByName('CODEMP').AsString   := qryTabela.FieldByName('FIS_CODEMP').AsString;
    qryLog.ParamByName('FORCLI').AsString   := qryTabela.FieldByName('FIS_FORCLI').AsString;
    qryLog.ParamByName('SERIE_').AsString   := qryTabela.FieldByName('FIS_SERIE_').AsString;
    qryLog.ParamByName('TIP_FC').AsString   := qryTabela.FieldByName('FIS_TIP_FC').AsString;
    qryLog.ParamByName('VALANT').AsString   := strValAnt;
    qryLog.ParamByName('VALATU').AsString   := strValAtu;
    qryLog.ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;
    qryLog.ParamByName('DTAALT').AsDateTime := VS_Date;
    qryLog.ParamByName('HORALT').AsDateTime := fTime();
    qryLog.ParamByName('NOMCAM').AsString   := strNomCam;
    qryLog.ParamByName('NOMTAB').AsString   := strNomTab;
    qryLog.ExecSQL;
  Finally
    FreeAndNil(qryLog);
  End;

end;

procedure TfrmCadLivroFiscal.pGravaLogs(dtaDtaEnt: TDateTime);
  Var
    qryLog: TUniQuery;
begin
  qryLog := fCriaQuery(Self);
  qryLog.SQL.Add('INSERT INTO DOCDTA (DOC_NUMDOC, DOC_ESPDOC, DOC_CODEMP, ');
  qryLog.SQL.Add(' DOC_FORCLI, DOC_SERIE_, DOC_TIP_FC, DOC_DTAANT, DOC_DTAATU, ');
  qryLog.SQL.Add(' DOC_CODOPE, DOC_DTAALT, DOC_HORALT) VALUES (:NUMDOC, :ESPDOC, :CODEMP, ');
  qryLog.SQL.Add(' :FORCLI, :SERIE_, :TIP_FC, :DTAANT, :DTAATU, :CODOPE, :DTAALT, :HORALT) ');

  qryLog.ParamByName('NUMDOC').AsString   := qryTabela.FieldByName('FIS_NUMDOC').AsString;
  qryLog.ParamByName('ESPDOC').AsString   := qryTabela.FieldByName('FIS_ESPDOC').AsString;
  qryLog.ParamByName('CODEMP').AsString   := qryTabela.FieldByName('FIS_CODEMP').AsString;
  qryLog.ParamByName('FORCLI').AsString   := qryTabela.FieldByName('FIS_FORCLI').AsString;
  qryLog.ParamByName('SERIE_').AsString   := qryTabela.FieldByName('FIS_SERIE_').AsString;
  qryLog.ParamByName('TIP_FC').AsString   := qryTabela.FieldByName('FIS_TIP_FC').AsString;
  qryLog.ParamByName('DTAANT').AsDateTime := qryTabela.FieldByName('FIS_DTAENT').AsDateTime;
  qryLog.ParamByName('DTAATU').AsDateTime := dtaDtaEnt;
  qryLog.ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;
  qryLog.ParamByName('DTAALT').AsDateTime := VS_Date;
  qryLog.ParamByName('HORALT').AsDateTime := fTime();
  qryLog.ExecSQL;

  FreeAndNil(qryLog);
end;

function TfrmCadLivroFiscal.pGravarContasPagar;
var
  qryAux: TUniQuery;
  fltTotDoc : Double;
  strSerie: String;
  blnGerarCtaPagar: Boolean;
begin
  blnGerarCtaPagar := True;
  Result := True;
  fltTotDoc := fStrToFloat(edtTotDoc.Text) - (fraCadImpostosNFS.fRetTotalImpostos);

  qryAux := fCriaQuery;
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT');
    qryAux.SQL.Add('  CADPAG.AUTOINCREM, CTP_DTACAD, CTP_DTAVEN,');
    qryAux.SQL.Add('  CONCAT(CTP_NUMDUP, "-", CTP_PARCEL) AS DOCUMENTO,');
    qryAux.SQL.Add('  CTP_SERIE_, CTA_DESCTA, CTP_HIST01, CTP_VALDUP,');
    qryAux.SQL.Add('  CAST("" AS CHAR(01)) AS MARDES');
    qryAux.SQL.Add('FROM CADPAG');
    qryAux.SQL.Add('JOIN CADCTA ON CTP_CODCTA = CTA_CODCTA');
    qryAux.SQL.Add('WHERE CTP_PREVIS = "S"');
    qryAux.SQL.Add('  AND CTP_CODFOR = :CODFOR');
    qryAux.SQL.Add('  AND CTP_DTAPAG IS NULL');
    qryAux.SQL.Add('ORDER BY CTP_DTAVEN');

    qryAux.ParamByName('CODFOR').AsString := dbeForCli.Text;
    qryAux.Open;

    if not qryAux.IsEmpty then
    begin
      If (Pos(dbeClfSc1.Text, '1933_2933') > 0) Or
      (Pos(dbeClfSc1.Text, strENERGIA_ELETRICA) > 0) Or
      (Pos(dbeClfSc1.Text, strTELECOMUNICACAO) > 0) Then
      Begin
        Try
          TfrmCadCtaPagarPrevisao
            .Create(nil)
            .fCodFor(dbeForCli.Text)
            .fVlrTot(fStrToFloat(dbeVlCon1.Text))
            .fDataCadastro(dbeDtaDoc.Text)
            .fExecutar(
              procedure (objDataSet: TDataSet)
              Begin
                objDataSet.First;
                While Not objDataSet.Eof Do
                Begin
                  //Altera Vencimento
                  If objDataSet.FieldBYName('CTP_DTAVEN').OldValue <> objDataSet.FieldBYName('CTP_DTAVEN').NewValue Then
                  Begin
                    pAlterarVencimento(objDataSet.FieldBYName('AUTOINCREM').AsString,
                      objDataSet.FieldBYName('CTP_DTAVEN').AsDateTime
                    );
                  End;
                  //Altera data Cadastro
                  If objDataSet.FieldBYName('CONVERTER_DATADECADASTRO').AsString = '1' Then
                  Begin
                    pAlterarDataCadastro(objDataSet.FieldBYName('AUTOINCREM').AsString,
                      TDate(StrToDate(dbeDtaDoc.Text)));
                  End;
                  //Converte Previsão em despesa
                  If objDataSet.FieldBYName('CONVERTER_DESPESA').AsString = '1' Then
                  Begin
                    strSerie := dbeNfComp.Text;
                    If Pos('PD',objDataSet.FieldBYName('CTP_HIST01').AsString) > 0 Then
                      strSerie := 'PD';

                    If Not fAlteraContasPagarPrevisao(objDataSet.FieldBYName('AUTOINCREM').AsString, fltTotDoc) Then
                      raise Exception.Create('Falha ao alterar previsão!');

                    blnGerarCtaPagar := False;
                  End;
                  objDataSet.Next;
                End;

                If (Not blnGerarCtaPagar) Then
                Begin
                  Try
                    fStartTransaction;

                    fraCadImpostosNFS.CtaDet(FDatasetCtpDet);
                    fraCadImpostosNFS.strForCli := dbeForCli.Field.AsString;
                    fraCadImpostosNFS.fCriarParcelasRetencoesFornecedor(qryTabela.FieldByName('AUTOINCREM').AsString, 'frmCadLivroFiscal');

                    fCommit;
                  Except

                    On E: Exception Do
                    Begin
                      fRollBack;
                      pMensagensErro(E.Message, '[Lançamento das retenções (Livro fiscal)]');
                    End;

                  End;
                End;
              End
            )
            .Free;
            If blnGerarCtaPagar Then
              pIncluirContasPagar(fltTotDoc);
        Except
          On E: Exception Do
          Begin
            Result := False;
            pMensagensErro(E.Message, '[TfrmCadLivroFiscal.pGravarContasPagar]');
          End;
        End;
      End
      Else
      Begin
        if fMensagem('',
          'Existem lancamentos de previsão no contas a pagar para este fornecedor.' + SLineBreak +
          'Deseja vincular algum destes lancamentos ao documento fiscal que esta sendo escriturado ?',
          ['&Sim', '&Não'], 2) = 1 then
          Result := pAlteraContasPagar(qryAux, fltTotDoc)
        else
          Result := pIncluirContasPagar(fltTotDoc);
      End;
    end
    else
      Result := pIncluirContasPagar(fltTotDoc);
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmCadLivroFiscal.btnAlterarClick(Sender: TObject);
begin
  If qryTabela.IsEmpty Then
  Begin
   fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
   Exit;
  End;

  If (Not fEmptyStr(dbeCodEmp.Text)) And (Not fValidaAcessoEmpresa) Then
  Begin
    fMensagem('ATENÇÃO!', 'Usuário sem Permissão para a empresa escolhida!', ['&O k']);
    Exit;
  End;

  strDtTrav := fCfgSis('DTTRAV');

  If ((strDtTrav <> '') And (Not fPodeAlterar)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Data do Documento menor que a Data da Trava Fiscal, não pode ser alterado.', ['&Ok']);
    Exit;
  End;

  If Not fValidaFechamentoFiscalEstoque Then
  Begin
    Exit;
  End;

  If chkDocumentoConferido.Visible Then
    If qryTabela.FieldByName('FIS_CONFER').AsInteger = 1 Then
    Begin
      If Not fValidarLiberarDocumentoConferido Then
        Exit;
      If qryTabela.FieldByName('FIS_CODCOF').AsString = strLoginUsuarioLogado Then
        If Not fValidarDocumentoConferido  Then
          Exit;
    End;

  If Not fLockUnlock(True) Then
    Exit;

  inherited;
  dbgItensDBTableViewCitel1.OnDblClick := dbgItensDBTableViewCitel1DblClick;
  tbsPessoasCTE.TabVisible := False;

  qryFisAju.Cancel;
  pEnabledFisAju;
  pEnabledCodigoClasseConsumoEnergiaEletrica;
  pDesabilitaEditsNfComplementar;

  If pgcDetalhes.ActivePage = tbsItens Then
  Begin
    pSetFocus(dbgItens);
  End;

  pHabilitaDadosFiscais;
  dbgItens.Enabled := True;

  dbeNumDoc.Enabled := False;
  dbeEspDoc.Enabled := False;
  dbeCodEmp.Enabled := False;
  dbeTip_Fc.Enabled := False;
  dbeEntSai.Enabled := False;
  dbeNfComp.Enabled := False;
  dbeSubSerie.Enabled := False;
  dbeForCli.Enabled := False;
  dbeNumDo2.Enabled := False;
  cmbNatOpeItem.Enabled := False;
  dbeNatCfo.Enabled := False;

  pHabilitaChaveAcesso;
  pHabilitaCTCompraVenda;
  pHabilitaNFComplemento;
  pHabilitaCanhotoNF;
  pHabilitaInfCpl;
  pHabilitaCodMod;
  pHabilitaDadosOffline;

  blnInsert := False;

  pHabilitaCamposGerais(qryFisItens.IsEmpty);

  edtCgcCpf.Enabled := False;

  fraCadImpostosNFS.strClaFis := dbeClfSc1.Text;
  fraCadImpostosNFS.strEspDoc := dbeEspDoc.Text;
  fraCadImpostosNFS.strTip_Fc := dbeTip_Fc.Text;
  fraCadImpostosNFS.blnAlteracaoLivro := True;
  fraCadImpostosNFS.pCarregarRetencoes;
  pCarregaDominioAcumulador;

  pEnabledFraCadImpostosNFS(True);

  if qryTabela.FieldByName('FIS_ESPDOC').AsString = 'CT' Then
  Begin
    tbsDocumentosCTE.TabVisible := True;
    btnDocCTEIncluir.Enabled := (qryTabela.FieldByName('FIS_LCTCTE').AsString = 'M');
    btnDocCTEExcluir.Enabled := (qryTabela.FieldByName('FIS_LCTCTE').AsString = 'M');
  End
  Else
    tbsDocumentosCTE.TabVisible := False;

  if Assigned(stlRegistrosExcluidosRECTNF) then
    stlRegistrosExcluidosRECTNF.Clear;
end;

procedure TfrmCadLivroFiscal.btnAlterarFisAjuClick(Sender: TObject);
begin
  Try
    If qryFisAju.IsEmpty Then
    Begin
      fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
      Exit;
    End;

    qryFisAju.Edit;
    pEnabledFisAju;
    pOnStateChangeFisAju;
    SelectNext(ActiveControl, True, True);
    pSetFocus(edtCodAju);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, 'Altera Registro');
    End;
  End;
end;

procedure TfrmCadLivroFiscal.btnAlterarSerieClick(Sender: TObject);
  Var
    strNovaSerie: String;
begin
  inherited;
  If Not fDocumentoStateBrowse Then
  Begin
    pMensagemOk('Para alterar a série, é necessário selecionar um documento e o mesmo ' +
      'não pode estar em inclusão ou edição.');
    Exit;
  End;

  If fNotaEmissaoPropria Then
  Begin
    pMensagemOk('Só é permitido alterar série de documentos emitidos por terceiros.');
    Exit;
  End;

  If Not fValidaFechamentoFiscalEstoque Then
  Begin
    Exit;
  End;

  strNovaSerie := qryTabela.FieldByName('FIS_SERIE_').AsString;
  If fDigitaNovaSerie(strNovaSerie) Then
  Begin
    If Not fVerificaExiste(strNovaSerie,'SERIE_') Then
    Begin
      pMensagemOk('Já existe este documento com esta série selecionada!');
      Exit;
    End;

    pAtualizarSerieDocumento(strNovaSerie);
  End;
end;

procedure TfrmCadLivroFiscal.btnAltEspecieClick(Sender: TObject);
  Var
    strNovaEspecie,
    strCfops: String;
    blnNotaServico: Boolean;
begin
  inherited;
  If Not fDocumentoStateBrowse Then
  Begin
    pMensagemOk('Para alterar a espécie, é necessário selecionar um documento e o mesmo ' +
      'não pode estar em inclusão ou edição.');
    Exit;
  End;

  If qryTabela.FieldByName('FIS_ENTSAI').AsString <> 'E' Then
  Begin
    pMensagemOk('Permitido alterar espécie apenas de documentos de entrada!');
    Exit;
  End;

  {*****************************}
  {* CFOPs REFERENTES A NOTAS  *}
  {* QUE NÃO POSSUEM ITENS     *}
  {**************************NC*}
  strCfops := '"1556", "2556", "1251", "1252", "1253", "1254", "1255", "1256", "1257", "2251", "2252", ' +
              '"2253", "2254", "2255", "2256", "2257", "3251", "5251", "5252", "5253", ' +
              '"5254", "5255", "5256", "5257", "5258", "6251", "6252", "6253", "6254", ' +
              '"6255", "6256", "6257", "6258", "1301", "1302", "1303", "1304", "1305", ' +
              '"1306", "2301", "2302", "2303", "2304", "2305", "2306", "2301", "3301", ' +
              '"5301", "5302", "5303", "5304", "5305", "5306", "5307", "6301", "6302", ' +
              '"6303", "6304", "6305", "6306", "6307", "1351", "1352", "1353", "1354", ' +
              '"1355", "1356", "1360", "1932", "2351", "2352", "2353", "2354", "2355", ' +
              '"2356", "2932", "5351", "5352", "5353", "5354", "5355", "5356", "5357", ' +
              '"5359", "5360", "5932", "6351", "6352", "6353", "6354", "6355", "6356", ' +
              '"6357", "6359", "6360", "6932", "1933", "2933", "5933", "6933",         ' +
              '"1406", "2406", "3406", "1551", "2551", "3551", "1407", "2407", "3407", ' +
              '"1653", "2653", "3653", "5605", "1605", "1604", "1908", "2908"';

  If (Pos('"' + qryTabela.FieldByName('FIS_CLFSC1').AsString + '"', strCfops) = 0) And
     (Pos('"' + qryTabela.FieldByName('FIS_CLFSC2').AsString + '"', strCfops) = 0) And
     (Pos('"' + qryTabela.FieldByName('FIS_CLFSC3').AsString + '"', strCfops) = 0) And
     (Pos('"' + qryTabela.FieldByName('FIS_CLFSC4').AsString + '"', strCfops) = 0) And
     (Pos('"' + qryTabela.FieldByName('FIS_CLFSC5').AsString + '"', strCfops) = 0) Then
  Begin
    pMensagemOk('Só é permitido trocar a espécie de documentos que não envolvam movimento com mercadorias.');
    Exit;
  End;

  If Not fValidaFechamentoFiscalEstoque Then
  Begin
    Exit;
  End;

  Try
    btnAltEspecie.Enabled := False;
    Screen.Cursor := crHourGlass;

    strNovaEspecie := qryTabela.FieldByName('FIS_ESPDOC').AsString;
    blnNotaServico := fNFServico;
    If fDigitaNovaEspecie(strNovaEspecie) Then
    Begin
      If Not fValidaClaFisCT(strNovaEspecie) Then
        Exit;

      If ((blnNotaServico) And ((Pos(strNovaEspecie,'NF_NS_') = 0))) Then
      Begin
        pMensagemOk('Para Nota de Serviço a nova espécie deve ser "NF" ou "NS"!');
        Exit;
      End
      Else
      If (Not blnNotaServico) And (Pos(strNovaEspecie,'NF_CT_CO_49_9_') = 0) Then
      Begin
        pMensagemOk('Nova espécie deve ser "NF", "CT", "CO", "49" ou "9"!');
        Exit;
      End;

      If Not fVerificaExiste(strNovaEspecie,'ESPDOC') Then
      Begin
        pMensagemOk('Já existe este documento com esta espécie selecionada!');
        Exit;
      End;

      pAtualizarEspecieDocumento(strNovaEspecie);
    End;
  Finally
    btnAltEspecie.Enabled := True;
    Screen.Cursor := crDefault;
  End;
end;

procedure TfrmCadLivroFiscal.btnAltForClick(Sender: TObject);
Var
  arrFornec: TConsultasArray;
  chrKey: Char;
  edtCodFor: TEditFocus;
begin
  inherited;

  If Not fDocumentoStateBrowse Then
  Begin
    pMensagemOk('Para alterar o fornecedor, é necessário selecionar um documento e o mesmo ' +
      'não pode estar em inclusão ou edição.');
    Exit;
  End;

  If qryTabela.FieldByName('FIS_TIP_FC').AsString <> 'F' Then
  Begin
    pMensagemOk('Esta nota não está vinculada a um Fornecedor!');
    Exit;
  End;

  If Not fValidaFechamentoFiscalEstoque Then
  Begin
    Exit;
  End;

  Try
    btnAltFor.Enabled := False;
    chrKey := '/' ;
    Screen.Cursor := crHourGlass;
    edtCodFor := TEditFocus.Create(Nil);
    If fPesqFornecedor(conForCompleta, Self, edtCodFor, Nil, Nil, chrKey, arrFornec) Then
    Begin
      If fRetEstadoFornecedor(edtCodFor.Text) <> qryTabela.FieldByName('FIS_ESTADO').AsString Then
      Begin
        pMensagemOk('Fornecedor selecionado com Estado diferente do atual.' +#13 +
                    'Selecionar fornecedor do Estado: '+ qryTabela.FieldByName('FIS_ESTADO').AsString);
        Exit;
      End;

      If Not fVerificaExiste(edtCodFor.Text,'FORCLI') Then
      Begin
        pMensagemOk('Já existe este documento com este fornecedor selecionado!');
        Exit;
      End;

      pAtualizarFornecedor(edtCodFor.Text);
    End;
  Finally
    Screen.Cursor := crDefault;
    FreeAndNil(edtCodFor);
    btnAltFor.Enabled := True;
  End;
end;

function TfrmCadLivroFiscal.fDigitaNovaEspecie(
  var strNovaEspecie: String): Boolean;
Begin
  Result := False;
  While (InputQuery('Nova espécie', 'Digite a nova espécie', strNovaEspecie)) Do
  Begin
    strNovaEspecie := UpperCase(Trim(strNovaEspecie));
    If Length(strNovaEspecie) > 2 Then
    Begin
      pMensagemOk('A espécie deve ter no máximo 2 digitos.');
    End
    Else
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TfrmCadLivroFiscal.fDigitaNovaSerie(Var strNovaSerie: String): Boolean;
begin
  Result := False;
  While (InputQuery('Nova série', 'Digite a nova série', strNovaSerie)) Do
  Begin
    strNovaSerie := Trim(strNovaSerie);
    If Length(strNovaSerie) > 3 Then
    Begin
      pMensagemOk('A série deve ter no máximo 3 digitos.');
    End
    Else
    Begin
      Result := True;
      Break;
    End;
  End;
end;

function TfrmCadLivroFiscal.fDireitoAcesso: Boolean;
var
  strSQL : String;
  qryCta : TUniQuery;
begin

  qryCta := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CTP_NUMDUP, CTP_CODEMP, CTP_CODFOR, CTP_DTACAD, CTP_PARCEL, ';
  strSQL := strSQL + '   CTP_SERIE_, CTP_DTAVEN, CTP_VALDUP, FOR_NOMFOR, EMP_NOMEMP  ';
  strSQL := strSQL + ' FROM CADPAG C  ';
  strSQL := strSQL + ' INNER JOIN CADFOR  ';
  strSQL := strSQL + '   ON FOR_CODFOR = CTP_CODFOR  ';
  strSQL := strSQL + ' INNER JOIN CADEMP  ';
  strSQL := strSQL + '   ON EMP_CODEMP = CTP_CODEMP  ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CTP_CODFOR = :CODFOR AND ';
  strSQL := strSQL + '   CTP_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '   CTP_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   CTP_SERIE_ = :SERIE_  ';

  With qryCta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODFOR').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
    ParamByName('NUMDUP').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
    ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;

    Open;
  End;

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('EXCLUSÃO DE DUPLICATAS - LIVRO FISCAL');
  objLiberacao.objMsgLibera.pAddSeparador(70);
  If Not fEmptyStr(fCfgSis('SEXCTP')) Then
    objLiberacao.objMsgLibera.pAddTexto('DADOS DE EXCLUSÃO - DUPLICATAS', alCentro, teAmbos, '', 70);

  While Not qryCta.Eof Do
  Begin
    With qryCta do
    Begin
      objLiberacao.objMsgLibera.pAddSeparador(70);
      objLiberacao.objMsgLibera.pAddTextoCaption('DOCUMENTO'      , fPadR(FieldByName('CTP_NUMDUP').AsString, 12) + FieldByName('CTP_PARCEL').AsString + ' - ' + FieldByName('CTP_SERIE_').AsString, 15);
      objLiberacao.objMsgLibera.pAddTextoCaption('EMPRESA'        , FieldByName('CTP_CODEMP').AsString + ' - ' + Copy(FieldByName('EMP_NOMEMP').AsString,1, 45)                                    , 15);
      objLiberacao.objMsgLibera.pAddTextoCaption('FORNECEDOR'     , fPadR(FieldByName('CTP_CODFOR').AsString, 8) + ' - ' + Copy(FieldByName('FOR_NOMFOR').AsString,1, 40)                          , 15);
      objLiberacao.objMsgLibera.pAddTextoCaption('DATA CADASTRO'  , FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTACAD').AsDateTime)                                                             , 15);
      objLiberacao.objMsgLibera.pAddTextoCaption('DATA VENCIMENTO', FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTAVEN').AsDateTime)                                                             , 15);
      objLiberacao.objMsgLibera.pAddTextoCaption('VALOR DUPLICATA', FloatToStrF(FieldByName('CTP_VALDUP').AsFloat, ffNumber, 12, 2)                                                                , 15);
      objLiberacao.objMsgLibera.pAddSeparador(70);

      Next;
    End;
  End;

  qryCta.Close;

  objLiberacao.strDirAce := 'CTPEXCDUP';
  objLiberacao.strSenLib := fCfgSis('SEXCTP');
  objLiberacao.strMsgSen := 'Excluir Duplicata';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.tipCliFor := cfFornecedor;

  Result := objLiberacao.fLibera;
end;

function TfrmCadLivroFiscal.fDocumentoStateBrowse: Boolean;
begin
  Result := (qryTabela.Active) And
            (Not qryTabela.IsEmpty) And
            (qryTabela.State = dsBrowse);
end;

function TfrmCadLivroFiscal.fEhClienteConsumidor(strTipCli,
  strCodCli: string): Boolean;
var
  qryConsulta: TUniQuery;
begin
  Result := False;

  if strTipCli = 'C' then
  begin
    qryConsulta := fCriaQuery;
    try
      qryConsulta.Close;
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('SELECT CLI_CONSUM FROM CADCLI WHERE CLI_CODCLI = :CODCLI');
      qryConsulta.ParamByName('CODCLI').AsString := strCodCli;
      qryConsulta.Open;

      if (not qryConsulta.IsEmpty) and (qryConsulta.FieldByName('CLI_CONSUM').AsString = 'N') then
      begin
        Result := False;
      end;
    finally
      FreeAndNil(qryConsulta);
    end;
  end;
end;

function TfrmCadLivroFiscal.fEhLancamentoDeNotaServico: Boolean;
const
  CFOP_AQUISICAO_PRESTACAO_SERVICO = '933';
var
  intContador : Integer;
  strClaFis   : String;
begin

  Result := True;

  If (dbeEspDoc.Text = 'NS') Then
    Exit;

  If (dbeEspDoc.Text = 'NF') Then
  Begin
    For intContador := 1 To 5 Do
    Begin
      strClaFis := (fComponentByName(tbsDocs ,'dbeClfSc' + intContador.ToString()) As TDBEditFocus).Text;
      If (Pos(RightStr(strClaFis, 3), CFOP_AQUISICAO_PRESTACAO_SERVICO) > 0) Then
        Exit;
    End;
  End;

  Result := False;

end;

function TfrmCadLivroFiscal.fEhMicroEmpresa(strTipCli,
  strCodCli: string): Boolean;
var
  qryConsulta: TUniQuery;
begin
  Result := False;
  qryConsulta := fCriaQuery();

  try
    if strTipCli = 'C' then
    begin
      qryConsulta.Close;
      qryConsulta.SQL.Clear;
      qryConsulta.SQL.Add('SELECT CLI_MICEMP FROM CADCLI WHERE CLI_CODCLI = :CODCLI');
      qryConsulta.ParamByName('CODCLI').AsString := strCodCli;
      qryConsulta.Open;

      Result := (not qryConsulta.IsEmpty) and (qryConsulta.FieldByName('CLI_MICEMP').AsString = 'S');
    end;
  finally
    FreeAndNil(qryConsulta);
  end;
end;

function TfrmCadLivroFiscal.fExisteCadFis(AAutInc: String): Boolean;
var
  qryConsulta: TUniQuery;
Begin

  qryConsulta:= fCriaQuery();
  Try
    qryConsulta.SQL.Add('SELECT * FROM CADFIS WHERE AUTOINCREM = "'+AAutInc+'"');
    qryConsulta.Open;
    Result := Not qryConsulta.IsEmpty;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TfrmCadLivroFiscal.fItemExiste(strCodIte: String): Boolean;
var
  qryConsulta: TUniQuery;
begin
  
  qryConsulta:= fCriaQuery();
  Try
    qryConsulta.SQL.Add('SELECT ITE_CODITE FROM CADITE WHERE ITE_CODITE = "'+strCodIte+'"');
    qryConsulta.Open;
    Result := Not qryConsulta.IsEmpty;
  Finally
    FreeAndNil(qryConsulta);
  End;
End;

function TfrmCadLivroFiscal.fExisteRegraPis(strCstPis: String;
fltBasPis: Double; fltAlqPis: Double; fltValPis: Double): Boolean;
begin
  Result := (Not fEmptyStr(strCstPis));
  If Not Result Then
    Exit;

  If Not Result Then
    Result :=  fltBasPis > 0;
  If Not Result Then
    Result := fltAlqPis > 0;
  If Not Result Then
    Result :=  fltValPis > 0;

end;

function TfrmCadLivroFiscal.fExisteDocumentoFiscal(strNumDoc , strCodCliFor, strCodEmp, strTipCliFor : String) : Boolean;
var
  strSQL : String;
  qryExisteDocumento: TUniQuery;
begin
  qryExisteDocumento := fCriaQuery;
  try
    strSQL := 'SELECT COUNT(1) AS QTDREGISTROS FROM CADFIS ' +
              '    WHERE FIS_NUMDOC = :DOC' +
              '    AND FIS_TIP_FC = :TIPFC' +
              '    AND FIS_FORCLI = :CODFORCLI' +
              '    AND FIS_CODEMP = :EMP';

    qryExisteDocumento.Close;
    qryExisteDocumento.SQL.Clear;
    qryExisteDocumento.SQL.Add(strSQL);
    qryExisteDocumento.ParamByName('DOC').AsString := strNumDoc;
    qryExisteDocumento.ParamByName('TIPFC').AsString := strTipCliFor;
    qryExisteDocumento.ParamByName('CODFORCLI').AsString := strCodCliFor;
    qryExisteDocumento.ParamByName('EMP').AsString := strCodEmp;
    qryExisteDocumento.Open;

    Result := qryExisteDocumento.FieldByName('QTDREGISTROS').AsInteger > 0;
  finally
    FreeAndNil(qryExisteDocumento);
  end;
end;

function TfrmCadLivroFiscal.fExisteRegraCofins(strCstCof: String;
fltBasCof: Double; fltAlqCof: Double; fltValCof: Double): Boolean;
begin
  Result := (Not fEmptyStr(strCstCof));
  If Not Result Then
    Exit;

  If Not Result Then
    Result := fltBasCof > 0;
  If Not Result Then
    Result := fltAlqCof > 0;
  If Not Result Then
    Result := fltValCof > 0;
end;

function TfrmCadLivroFiscal.fExpecieExigeChave: Boolean;
begin
  Result := False;
  If dbeEspDoc.Text = 'CT' Then
    If (Pos('CANCEL', dbmHistor.Text) = 0) And
       (Pos('DENEGAD', dbmHistor.Text) = 0) And
       (Pos('INUTIL', dbmHistor.Text) = 0) Then
     Result := True;
end;

function TfrmCadLivroFiscal.fGetModDocumentocbxCODMOD: String;
begin
  if cbxCODMOD.ItemIndex >= 0 then
    Result := cbxCODMOD.Items.Names[cbxCODMOD.ItemIndex]
  else
    Result := EmptyStr;
end;

function TfrmCadLivroFiscal.fGravarFinanceiro: Boolean;
begin
  If fEhLancamentoDeNotaServico and (fCfgSis('UTICON') ='S') then
    Exit(True);
  Result := fMensagem('', 'Deseja gravar o contas a pagar desse lançamento?', ['&Sim', '&Não']) = 1;
end;

function TfrmCadLivroFiscal.fGravarTabelasAuxiliares: Boolean;
var
  qryTblMovObs: TUniQuery;
begin
  if (tbsDadosCpl.TabVisible) then
  begin
    try
      try
          qryTblMovObs := fCriaQuery;

          qryTblMovObs.SQL.Add('SELECT * FROM OBSFIS WHERE OBS_SEQFIS = :SEQFIS');
          qryTblMovObs.ParamByName('SEQFIS').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
          qryTblMovObs.Open;
          qryTblMovObs.Edit;

          qryTblMovObs.FieldByName('OBS_SEQFIS').AsString  := qryTabela.FieldByName('AUTOINCREM').AsString;

          qryTblMovObs.FieldByName('OBS_OBSFIS').AsString  := AnsiReplaceStr(memInfAdicFisco.Text, STRING_ENTER, STRING_QUEBRA);
          qryTblMovObs.FieldByName('OBS_INFCPL').AsString  := AnsiReplaceStr(memInfCpl.Text, STRING_ENTER, STRING_QUEBRA);

          qryTblMovObs.Post;

          Result := True;
      Except
        On E: Exception Do
        Begin
          qryTblMovObs.Cancel;
          pMensagensErro(E.Message, '[TfrmCadLivroFiscal.fGravarTabelasAuxiliares]');
          Result := False;
        End;
      End;

    Finally
      FreeAndNil(qryTblMovObs);
    End;
  End
  Else
    Result := True;
End;

function TfrmCadLivroFiscal.fNotaEmissaoPropria: Boolean;
begin
  Result := (qryTabela.FieldByName('FIS_ORIDOC').AsString = 'V');
end;

procedure TfrmCadLivroFiscal.pAtualizarEspecieDocumento(strNovaEspecie: String);
begin
  fStartTransaction;

  Try
    fAtualizaDadosCtpNotEnt('', '', '', '', strNovaEspecie);
    fAtualizaDadosCtpNotEnt('', '03', '', '', strNovaEspecie);

    pTryAtualizarEspecieDocumento(strNovaEspecie);
    fCommit;

    pMensagemOk('Alteração de espécie concluída.');
  Except
    On E: Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, '[pAtualizarEspecieDocumento]');
    End;
  End;
end;

procedure TfrmCadLivroFiscal.pAtualizarFornecedor(strNovoFor: String);
begin
  fStartTransaction;

  Try
    pTryAtualizarFornecedor(strNovoFor);
    fCommit;

    pCarregaDadosAdicionais;

    pMensagemOk('Alteração de fornecedor concluída.');
  Except
    On E: Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, '[pAtualizarFornecedor]');
    End;
  End;
end;

procedure TfrmCadLivroFiscal.pAtualizarSerieDocumento(strNovaSerie: String);
var strMensagem: String;
begin
  fStartTransaction;

  Try
    If fTryAtualizarSerieDocumento(strNovaSerie, strMensagem) Then
    Begin
      fCommit;
      pMensagemOk('Alteração de série concluída.');
    End
    Else
    Begin
      fRollback;
      If strMensagem <> '' Then
        pMensagemOk('Não foi possível alterar a série. Motivo: ' + strMensagem);
    End;
  Except
    On E: Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, '[pAtualizarSerieDocumento]');
    End;
  End;
end;

procedure TfrmCadLivroFiscal.pQryTabelaBeforeEdit(pDataSet: TDataSet);
begin
  FChaveAcesso.Create(True,
                      qryTabela.FieldByName('FIS_NUMDOC').AsString,
                      qryTabela.FieldByName('FIS_ESPDOC').AsString,
                      qryTabela.FieldByName('FIS_SERIE_').AsString,
                      qryTabela.FieldByName('FIS_FORCLI').AsString,
                      qryTabela.FieldByName('FIS_TIP_FC').AsString,
                      qryTabela.FieldByName('FIS_CODEMP').AsString,
                      qryTabela.FieldByName('FIS_ACESSO').AsString);
end;

procedure TfrmCadLivroFiscal.pQryTabelaNewRecord(pDataSet: TDataSet);
begin
  FChaveAcesso.Create(False);
end;

procedure TfrmCadLivroFiscal.pTryAtualizarEspecieDocumento(
  strNovaEspecie: String);
  Var
    qryAux: TUniQuery;
    strEspecieAnt: String;

  procedure pExecutaUpd;
  begin
    qryAux.ParamByName('NOVESP').AsString := strNovaEspecie;
    qryAux.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    qryAux.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
    qryAux.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
    qryAux.ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
    qryAux.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
    qryAux.ParamByName('ESPDOC').AsString := strEspecieAnt;
    qryAux.ExecSQL;
  end;

  procedure pUpdates(strGer, strDet: String);
  Begin
    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE ' + strGer + ' SET GER_ESPDOC = :NOVESP WHERE');
    qryAux.SQL.Add('GER_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('GER_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('GER_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('GER_CODFOR = :FORCLI AND ');
    qryAux.SQL.Add('GER_TIP_FC = :TIP_FC AND ');
    qryAux.SQL.Add('GER_SERIE_ = :SERIE_ ');
    pExecutaUpd;
    If VS_AffectedRows > 0 Then
      pGravaLogFis(strEspecieAnt, strNovaEspecie, 'GER_ESPDOC', strGer);

    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE ' + strDet + ' SET DET_ESPDOC = :NOVESP WHERE');
    qryAux.SQL.Add('DET_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('DET_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('DET_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('DET_CODFOR = :FORCLI AND ');
    qryAux.SQL.Add('DET_TIP_FC = :TIP_FC AND ');
    qryAux.SQL.Add('DET_SERIE_ = :SERIE_ ');
    pExecutaUpd;
    If VS_AffectedRows > 0 Then
      pGravaLogFis(strEspecieAnt, strNovaEspecie, 'DET_ESPDOC', strDet);
  End;
begin
  Try
    qryAux := fCriaQuery(Self);

    strEspecieAnt := qryTabela.FieldByName('FIS_ESPDOC').AsString;

    qryTabela.Edit;
    qryTabela.FieldByName('FIS_ESPDOC').AsString := strNovaEspecie;
    qryTabela.Post;
    If VS_AffectedRows > 0 Then
      pGravaLogFis(strEspecieAnt,strNovaEspecie,'FIS_ESPDOC','CADFIS');

    If (Pos('CANCELADO',qryTabela.FieldByName('FIS_HISTOR').AsString) > 0) Then
    Begin
      pUpdates('DEL_MOVGER', 'DEL_MOVDET');
      pUpdates('DEL_NOTGER', 'DEL_NOTDET');

      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE DEL_CADFIS SET FIS_ESPDOC = :NOVESP WHERE');
      qryAux.SQL.Add('FIS_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('FIS_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('FIS_CODEMP = :CODEMP AND ');
      qryAux.SQL.Add('FIS_FORCLI = :FORCLI AND ');
      qryAux.SQL.Add('FIS_TIP_FC = :TIP_FC AND ');
      qryAux.SQL.Add('FIS_SERIE_ = :SERIE_ ');
      pExecutaUpd;
      If VS_AffectedRows > 0 Then
        pGravaLogFis(strEspecieAnt, strNovaEspecie, 'FIS_ESPDOC', 'DEL_CADFIS');
    End
    Else
    Begin
      pUpdates('MOVGER', 'MOVDET');
      pUpdates('NOTGER', 'NOTDET');
    End;
  Finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmCadLivroFiscal.pTryAtualizarFornecedor(strNovoFor: String);
  Var
    qryAux: TUniQuery;
    strTabPag,
    strForAnt: String;

    LDuplicatasLog: TUniQuery;

    procedure pExecutaUpd;
    begin
      qryAux.ParamByName('NOVFOR').AsString := strNovoFor;
      qryAux.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
      qryAux.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
      qryAux.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
      qryAux.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
      qryAux.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
      qryAux.ParamByName('FORCLI').AsString := strForAnt;
      qryAux.ExecSQL;
    end;

    procedure pExecutaUpdCon;
      Var qrySel: TUniQuery;
    begin
      qrySel := fCriaQuery(Nil);
      qrySel.Close;
      qrySel.SQL.Clear;
      qrySel.SQL.Add('SELECT');
      qrySel.SQL.Add('  FOR_NOMFOR, FOR_ENDERE, FOR_BAIRRO, FOR_C_E_P_,');
      qrySel.SQL.Add('  FOR_CODCID, CID_ESTADO, FOR_FONE01, FOR_CGCCPF,');
      qrySel.SQL.Add('  FOR_C_G_C_, FOR_I_E_S_, FOR_NUMRG_, FOR_EMAIL_ ');
      qrySel.SQL.Add('FROM');
      qrySel.SQL.Add('  CADFOR');
      qrySel.SQL.Add('LEFT JOIN');
      qrySel.SQL.Add('  CADCID ON CID_CODCID = FOR_CODCID');
      qrySel.SQL.Add('WHERE');
      qrySel.SQL.Add('  FOR_CODFOR = :CODFOR');
      qrySel.ParamByName('CODFOR').AsString := strNovoFor;
      qrySel.Open;

      qryAux.ParamByName('NOVFOR').AsString := strNovoFor;
      qryAux.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
      qryAux.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
      qryAux.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
      qryAux.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
      qryAux.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
      qryAux.ParamByName('FORCLI').AsString := strForAnt;
      qryAux.ParamByName('NOMCON').AsString := qrySel.FieldByName('FOR_NOMFOR').AsString;
      qryAux.ParamByName('ENDCON').AsString := qrySel.FieldByName('FOR_ENDERE').AsString;
      qryAux.ParamByName('BAICON').AsString := qrySel.FieldByName('FOR_BAIRRO').AsString;
      qryAux.ParamByName('CEPCON').AsString := qrySel.FieldByName('FOR_C_E_P_').AsString;
      qryAux.ParamByName('CIDCON').AsString := qrySel.FieldByName('FOR_CODCID').AsString;
      qryAux.ParamByName('ESTCON').AsString := qrySel.FieldByName('CID_ESTADO').AsString;
      qryAux.ParamByName('TELCON').AsString := qrySel.FieldByName('FOR_FONE01').AsString;
      qryAux.ParamByName('CGCCPF').AsString := qrySel.FieldByName('FOR_CGCCPF').AsString;
      qryAux.ParamByName('CGCCON').AsString := qrySel.FieldByName('FOR_C_G_C_').AsString;
      qryAux.ParamByName('IESCON').AsString := qrySel.FieldByName('FOR_I_E_S_').AsString;
      qryAux.ParamByName('R_GCON').AsString := qrySel.FieldByName('FOR_NUMRG_').AsString;
      qryAux.ParamByName('EMLCON').AsString := qrySel.FieldByName('FOR_EMAIL_').AsString;
      qryAux.ExecSQL;

      FreeAndNil(qrySel);
    end;

    procedure pUpdates(strGer, strDet: String);
    Begin
      If qryTabela.FieldByName('FIS_ENTSAI').AsString = 'S' Then
      Begin
        qryAux.SQL.Clear;
        qryAux.SQL.Add('UPDATE ' + strGer );
        qryAux.SQL.Add('SET GER_CODFOR = :NOVFOR,');
        qryAux.SQL.Add('GER_NOMCON = :NOMCON,');
        qryAux.SQL.Add('GER_ENDCON = :ENDCON,');
        qryAux.SQL.Add('GER_BAICON = :BAICON,');
        qryAux.SQL.Add('GER_CEPCON = :CEPCON,');
        qryAux.SQL.Add('GER_CIDCON = :CIDCON,');
        qryAux.SQL.Add('GER_ESTCON = :ESTCON,');
        qryAux.SQL.Add('GER_TELCON = :TELCON,');
        qryAux.SQL.Add('GER_CGCCPF = :CGCCPF,');
        qryAux.SQL.Add('GER_CGCCON = :CGCCON,');
        qryAux.SQL.Add('GER_IESCON = :IESCON,');
        qryAux.SQL.Add('GER_R_GCON = :R_GCON,');
        qryAux.SQL.Add('GER_EMLCON = :EMLCON ');
        qryAux.SQL.Add('WHERE');
        qryAux.SQL.Add('GER_NUMDOC = :NUMDOC AND ');
        qryAux.SQL.Add('GER_ESPDOC = :ESPDOC AND ');
        qryAux.SQL.Add('GER_CODEMP = :CODEMP AND ');
        qryAux.SQL.Add('GER_CODFOR = :FORCLI AND ');
        qryAux.SQL.Add('GER_TIP_FC = :TIP_FC AND ');
        qryAux.SQL.Add('GER_SERIE_ = :SERIE_ ');
        pExecutaUpdCon;
        If VS_AffectedRows > 0 Then
          pGravaLogFis(strForAnt, strNovoFor, 'GER_CODFOR', strGer);
      End
      Else
      Begin
        qryAux.SQL.Clear;
        qryAux.SQL.Add('UPDATE ' + strGer + ' SET GER_CODFOR = :NOVFOR WHERE');
        qryAux.SQL.Add('GER_NUMDOC = :NUMDOC AND ');
        qryAux.SQL.Add('GER_ESPDOC = :ESPDOC AND ');
        qryAux.SQL.Add('GER_CODEMP = :CODEMP AND ');
        qryAux.SQL.Add('GER_CODFOR = :FORCLI AND ');
        qryAux.SQL.Add('GER_TIP_FC = :TIP_FC AND ');
        qryAux.SQL.Add('GER_SERIE_ = :SERIE_ ');
        pExecutaUpd;
        If VS_AffectedRows > 0 Then
          pGravaLogFis(strForAnt, strNovoFor, 'GER_CODFOR', strGer);
      End;

      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE ' + strDet + ' SET DET_CODFOR = :NOVFOR WHERE');
      qryAux.SQL.Add('DET_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('DET_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('DET_CODEMP = :CODEMP AND ');
      qryAux.SQL.Add('DET_CODFOR = :FORCLI AND ');
      qryAux.SQL.Add('DET_TIP_FC = :TIP_FC AND ');
      qryAux.SQL.Add('DET_SERIE_ = :SERIE_ ');
      pExecutaUpd;
      If VS_AffectedRows > 0 Then
        pGravaLogFis(strForAnt, strNovoFor, 'DET_CODFOR', strDet);
    End;
begin
  Try
    qryAux := fCriaQuery(Self);
    strForAnt := qryTabela.FieldByName('FIS_FORCLI').AsString;

    fAtualizaDadosCtpNotEnt('', '', '', strNovoFor);
    fAtualizaDadosCtpNotEnt('', '03', '', strNovoFor);

    qryTabela.Edit;
    qryTabela.FieldByName('FIS_FORCLI').AsString := strNovoFor;
    qryTabela.Post;
    If VS_AffectedRows > 0 Then
      pGravaLogFis(strForAnt,strNovoFor,'FIS_FORCLI','CADFIS');

    If(Pos('CANCELADO',qryTabela.FieldByName('FIS_HISTOR').AsString) > 0) Then
    Begin
      strTabPag := 'DEL_CADPAG';
      pUpdates('DEL_MOVGER', 'DEL_MOVDET');
      pUpdates('DEL_NOTGER', 'DEL_NOTDET');
      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE DEL_CADFIS SET FIS_FORCLI = :NOVFOR WHERE');
      qryAux.SQL.Add('FIS_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('FIS_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('FIS_CODEMP = :CODEMP AND ');
      qryAux.SQL.Add('FIS_FORCLI = :FORCLI AND ');
      qryAux.SQL.Add('FIS_TIP_FC = :TIP_FC AND ');
      qryAux.SQL.Add('FIS_SERIE_ = :SERIE_ ');
      pExecutaUpd;
      If VS_AffectedRows > 0 Then
        pGravaLogFis(strForAnt, strNovoFor, 'FIS_FORCLI', 'DEL_CADFIS');
    End
    Else
    Begin
      strTabPag := 'CADPAG';
      pUpdates('MOVGER', 'MOVDET');
      pUpdates('NOTGER', 'NOTDET');
    End;

    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE ' + strTabPag + ' SET CTP_CODFOR = :NOVFOR WHERE');
    qryAux.SQL.Add('CTP_NUMDUP = :NUMDOC AND ');
    qryAux.SQL.Add('CTP_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add('CTP_CODFOR = :FORCLI AND ');
    qryAux.SQL.Add('CTP_SERIE_ = :SERIE_ ');
    qryAux.ParamByName('NOVFOR').AsString := strNovoFor;
    qryAux.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    qryAux.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
    qryAux.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
    qryAux.ParamByName('FORCLI').AsString := strForAnt;
    qryAux.ExecSQL;
    If qryAux.RowsAffected > 0 Then
    Begin
      pGravaLogFis(strForAnt, strNovoFor, 'CTP_CODFOR', strTabPag);

      If strTabPag.Equals('CADPAG') Then
      Begin
        LDuplicatasLog := fCriaQuery;
        LDuplicatasLog.SQL.Text := 'SELECT AUTOINCREM, ' +
                                   '       CTP_PARCEL ' +
                                   'FROM CADPAG ' +
                                   'WHERE CTP_NUMDUP=:NUMDUP ' +
                                   '  AND CTP_CODEMP=:CODEMP ' +
                                   '  AND CTP_CODFOR=:CODFOR ';
        If qryTabela.FieldByName('FIS_SERIE_').AsString.IsEmpty Then
          LDuplicatasLog.SQL.Add('  AND (CTP_SERIE_ IS NULL OR CTP_SERIE_= "") ')
        Else
        Begin
          LDuplicatasLog.SQL.Add('  AND CTP_SERIE_=:SERIE_ ');
          LDuplicatasLog.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
        End;

        LDuplicatasLog.ParamByName('NUMDUP').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
        LDuplicatasLog.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
        LDuplicatasLog.ParamByName('CODFOR').AsString := strNovoFor;
        LDuplicatasLog.Open;

        While Not LDuplicatasLog.Eof Do
        Begin
           AlteraChaveCtpDet(RetornaRecordChaveDuplicata(qryTabela.FieldByName('FIS_NUMDOC').AsString,
                                                         LDuplicatasLog.FieldByName('CTP_PARCEL').AsString,
                                                         qryTabela.FieldByName('FIS_CODEMP').AsString,
                                                         strForAnt,
                                                         qryTabela.FieldByName('FIS_SERIE_').AsString),
                             RetornaRecordChaveDuplicata(qryTabela.FieldByName('FIS_NUMDOC').AsString,
                                                         LDuplicatasLog.FieldByName('CTP_PARCEL').AsString,
                                                         qryTabela.FieldByName('FIS_CODEMP').AsString,
                                                         strNovoFor,
                                                         qryTabela.FieldByName('FIS_SERIE_').AsString),
                             Self.Name);

          untLogCtp.GravaLogCtp(LDuplicatasLog.FieldByName('AUTOINCREM').AsString,
                                'ALTERAÇÃO FORNECEDOR',
                                Self.Name);

          LDuplicatasLog.Next;
        End;
        LDuplicatasLog.Close;
        FreeAndNil(LDuplicatasLog);
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmCadLivroFiscal.fTryAtualizarSerieDocumento(strNovaSerie: String; var strMensagem: String): Boolean;
  Var
    qryAux: TUniQuery;
    qryAux2: TUniQuery;
    qryContasPagar: TUniQuery;
    strTabGer: String;
    strSerieAnt: String;
    objEnderecamento : TEnderecamentoProduto;
    endDocumento: TEndDocumento;

    strDocEndAntigo : String;
    strDocEndNovo: String;

    procedure pExecutaUpd;
    begin
      qryAux.ParamByName('NOVSER').AsString := strNovaSerie;
      qryAux.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;

      If qryAux.Params.FindParam('ESPDOC') <> nil then
        qryAux.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;

      qryAux.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
      qryAux.ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;

      If qryAux.Params.FindParam('TIP_FC') <> nil then
        qryAux.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;

      qryAux.ParamByName('SERIE_').AsString := strSerieAnt;
      qryAux.ExecSQL;
    end;

    procedure pCarregaContasAPagar;
    begin
      qryContasPagar.SQL.Clear;
      qryContasPagar.SQL.Add('SELECT AUTOINCREM, CTP_BCOENV, CTP_CODFOR, CTP_DTAENV, CTP_DTABAI,CTP_CODEMP, CTP_SERIE_, CTP_NUMDUP, CTP_PARCEL, CTP_SEQBAI FROM CADPAG');
      qryContasPagar.SQL.Add(' WHERE CTP_NUMDUP = :NUMDUP');
      qryContasPagar.SQL.Add('   AND CTP_CODFOR = :CODFOR');
      qryContasPagar.SQL.Add('   AND CTP_CODEMP = :CODEMP');
      qryContasPagar.SQL.Add('   AND CTP_SERIE_ = :SERIE_');

      qryContasPagar.ParamByName('NUMDUP').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
      qryContasPagar.ParamByName('CODFOR').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
      qryContasPagar.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
      qryContasPagar.ParamByName('SERIE_').AsString := strSerieAnt;

      qryContasPagar.Open;
    end;

    function fAtualizaTabelasContasAPagar: Boolean;
    begin
      Try
        qryAux.SQL.Clear;
        qryAux.SQL.Add('UPDATE CADPAG SET CTP_SERIE_ = "'+strNOvaSerie+'" WHERE AUTOINCREM =  :AUTINC' );
        Try

          qryContasPagar.First;
          while not qryContasPagar.EoF Do
          Begin
            qryAux.ParamByName('AUTINC').AsString := qryContasPagar.FieldByName('AUTOINCREM').AsString;
            qryAux.ExecSQL;

            qryAux2.SQL.Clear;
            qryAux2.SQL.Add('UPDATE MOVBAN SET CTB_SERIE_ = "'+ strNOvaSerie+ '"');
            qryAux2.SQL.Add('WHERE CTB_NUMDUP = "' + qryContasPagar.FieldByName('CTP_NUMDUP').AsString + '"');
            qryAux2.SQL.Add('  AND CTB_EMPDUP = "' + qryContasPagar.FieldByName('CTP_CODEMP').AsString + '"');
            qryAux2.SQL.Add('  AND IFNULL(CTB_SERIE_, "") = "' + qryContasPagar.FieldByName('CTP_SERIE_').AsString + '"');
            qryAux2.SQL.Add('  AND CTB_PARCEL = "' + qryContasPagar.FieldByName('CTP_PARCEL').AsString + '"');
            qryAux2.SQL.Add('  AND CTB_CODFOR = "' + qryContasPagar.FieldByName('CTP_CODFOR').AsString + '"');
            qryAux2.ExecSQL;

            qryAux2.SQL.Clear;
            qryAux2.SQL.Add('UPDATE BANCTP SET CTP_SERIE_ = "' +strNOvaSerie+ '"');
            qryAux2.SQL.Add(' WHERE CTP_CODEMP = "' +qryContasPagar.FieldByName('CTP_CODEMP').AsString+ '"');
            qryAux2.SQL.Add('   AND CTP_NUMDUP = "' +qryContasPagar.FieldByName('CTP_NUMDUP').AsString+ '"');
            qryAux2.SQL.Add('   AND CTP_PARCEL = "' +qryContasPagar.FieldByName('CTP_PARCEL').AsString+ '"');
            qryAux2.SQL.Add('   AND IFNULL(CTP_SERIE_, "") = "' +qryContasPagar.FieldByName('CTP_SERIE_').AsString+ '"');
            qryAux2.SQL.Add('   AND CTP_CODFOR = "' + qryContasPagar.FieldByName('CTP_CODFOR').AsString + '"');
            qryAux2.ExecSQL;

            AlteraChaveCtpDet(RetornaRecordChaveDuplicata(qryContasPagar.FieldByName('CTP_NUMDUP').AsString,
                                                          qryContasPagar.FieldByName('CTP_PARCEL').AsString,
                                                          qryContasPagar.FieldByName('CTP_CODEMP').AsString,
                                                          qryContasPagar.FieldByName('CTP_CODFOR').AsString,
                                                          qryContasPagar.FieldByName('CTP_SERIE_').AsString),
                              RetornaRecordChaveDuplicata(qryContasPagar.FieldByName('CTP_NUMDUP').AsString,
                                                          qryContasPagar.FieldByName('CTP_PARCEL').AsString,
                                                          qryContasPagar.FieldByName('CTP_CODEMP').AsString,
                                                          qryContasPagar.FieldByName('CTP_CODFOR').AsString,
                                                          strNovaSerie),
                              Self.Name);

            fAtualizaDadosCtpNotEnt(strNOvaSerie, '', qryContasPagar.FieldByName('AUTOINCREM').AsString);

            untLogCtp.GravaLogCtp(qryContasPagar.FieldByName('AUTOINCREM').AsString,
                                  'Alteração da Serie',
                                  Self.Name);
            
            qryContasPagar.Next;
          End;

          fAtualizaDadosCtpNotEnt(strNOvaSerie, '03');

          Result := True;
        Finally

        End;
      Except
        on e: Exception do
        Begin
          Result := False;
          strMensagem := e.message;
        End;
      End
    End;

begin
  qryContasPagar := fCriaQuery(Self);
  qryAux := fCriaQuery(Self);
  qryAux2 := fCriaQuery(Self);

  Try
    strSerieAnt := qryTabela.FieldByName('FIS_SERIE_').AsString;

    pCarregaContasAPagar;

    If Not qryContasPagar.IsEmpty Then
    Begin
      If Not fAtualizaTabelasContasAPagar Then
        Exit(False);
    End;

    qryTabela.Edit;
    qryTabela.FieldByName('FIS_SERIE_').AsString := strNOvaSerie;
    qryTabela.Post;

    If strNOvaSerie <> strSerieAnt Then
      pGravaLogFis(strSerieAnt,strNOvaSerie,'FIS_SERIE_','CADFIS');

    If Not qryFisItens.IsEmpty Then
    Begin
      strTabGer := IIF(strTabela='MOVDET', 'MOVGER', 'NOTGER');

      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE ' + strTabGer + ' SET GER_SERIE_ = :NOVSER WHERE');
      qryAux.SQL.Add('GER_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('GER_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('GER_CODEMP = :CODEMP AND ');
      qryAux.SQL.Add('IF(GER_TIP_FC="C", GER_CODCLI, GER_CODFOR) = :FORCLI AND ');
      qryAux.SQL.Add('GER_TIP_FC = :TIP_FC AND ');
      qryAux.SQL.Add('IFNULL(GER_SERIE_, "") = :SERIE_ ');
      pExecutaUpd;
      If VS_AffectedRows > 0 Then
        pGravaLogFis(strSerieAnt,strNOvaSerie,'GER_SERIE_',strTabGer);

      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE ' + strTabela + ' SET DET_SERIE_ = :NOVSER WHERE');
      qryAux.SQL.Add('DET_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('DET_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('DET_CODEMP = :CODEMP AND ');
      qryAux.SQL.Add('IF(DET_TIP_FC="C", DET_CODCLI, DET_CODFOR) = :FORCLI AND ');
      qryAux.SQL.Add('DET_TIP_FC = :TIP_FC AND ');
      qryAux.SQL.Add('IFNULL(DET_SERIE_, "") = :SERIE_ ');
      pExecutaUpd;

      //GERELE
      If qryTabela.FieldByName('FIS_ESPDOC').AsString = 'NF' then
      begin
        qryAux.SQL.Clear;
        qryAux.SQL.Add('UPDATE GERELE SET B07_SERIE = :NOVSER WHERE');
        qryAux.SQL.Add('B08_NNF = :NUMDOC AND ');
        qryAux.SQL.Add('GER_CODEMP = :CODEMP AND ');
        qryAux.SQL.Add('IF(GER_TIP_FC="C", GER_CODCLI, GER_CODFOR) = :FORCLI AND ');
        qryAux.SQL.Add('GER_TIP_FC = :TIP_FC AND ');
        qryAux.SQL.Add('IFNULL(B07_SERIE, "") = :SERIE_ ');
        pExecutaUpd;
      end;

      //AGEDOC
      If qryTabela.FieldByName('FIS_TIP_FC').AsString = 'F' then
      begin
        qryAux.SQL.Clear;
        qryAux.SQL.Add('UPDATE AGEDOC SET ADC_SERIE_ = :NOVSER WHERE');
        qryAux.SQL.Add('ADC_NUMDOC = :NUMDOC AND ');
        qryAux.SQL.Add('ADC_ESPDOC = :ESPDOC AND ');
        qryAux.SQL.Add('ADC_CODEMP = :CODEMP AND ');
        qryAux.SQL.Add('ADC_CODFOR = :FORCLI AND ');
        qryAux.SQL.Add('IFNULL(ADC_SERIE_, "") = :SERIE_ ');
        pExecutaUpd;
      end;


      //DOCUMENTOS DE ENDEREÇAMENTO
      objEnderecamento := TEnderecamentoProduto.Create;
      try
        objEnderecamento.pLimpar;

        endDocumento.strNumDoc := qryTabela.FieldByName('FIS_NUMDOC').AsString;
        endDocumento.strEspDoc := qryTabela.FieldByName('FIS_ESPDOC').AsString;
        endDocumento.strSerie_ := strSerieAnt;
        endDocumento.strCodEmp := qryTabela.FieldByName('FIS_CODEMP').AsString;
        endDocumento.strCliFor := qryTabela.FieldByName('FIS_FORCLI').AsString;
        endDocumento.strTip_FC := qryTabela.FieldByName('FIS_TIP_FC').AsString;
        objEnderecamento.endDocumento := endDocumento;

        strDocEndAntigo := objEnderecamento.strDocumento;

        objEnderecamento.pLimpar;

        endDocumento.strNumDoc := qryTabela.FieldByName('FIS_NUMDOC').AsString;
        endDocumento.strEspDoc := qryTabela.FieldByName('FIS_ESPDOC').AsString;
        endDocumento.strSerie_ := strNovaSerie;
        endDocumento.strCodEmp := qryTabela.FieldByName('FIS_CODEMP').AsString;
        endDocumento.strCliFor := qryTabela.FieldByName('FIS_FORCLI').AsString;
        endDocumento.strTip_FC := qryTabela.FieldByName('FIS_TIP_FC').AsString;
        objEnderecamento.endDocumento := endDocumento;

        strDocEndNovo := objEnderecamento.strDocumento;

        qryAux.SQL.Clear;
        qryAux.SQL.Add('UPDATE EXTGOR SET FGO_DOCEND = :DOCEND_NOVO WHERE FGO_DOCEND = :DOCEND_ANTIGO');

        qryAux.ParamByName('DOCEND_ANTIGO').AsString := strDocEndAntigo;
        qryAux.ParamByName('DOCEND_NOVO').AsString   := strDocEndNovo;

        qryAux.ExecSQL;

      finally
        FreeAndNil(objEnderecamento);
      end;

      If VS_AffectedRows > 0 Then
        pGravaLogFis(strSerieAnt,strNOvaSerie,'DET_SERIE_',strTabela);
      Result := True;
    End
    Else
      Result := True;
  Finally
    FreeAndNil(qryAux);
    FreeAndNil(qryAux2);
    FreeAndNil(qryContasPagar);
  End;
end;

procedure TfrmCadLivroFiscal.pTryRefreshDocumento;
  Var
    qryAux,
    qryGer,
    qryCliFor: TUniQuery;
    strPrefix,
    strNomeCampo: String;

  procedure pUpdates(strGer: String);
    Var
      intCont: Integer;
  Begin
    strPrefix := IIF(qryTabela.FieldByName('FIS_TIP_FC').AsString = 'C', 'CLI_', 'FOR_');

    qryGer.Close;
    qryGer.SQL.Clear;
    qryGer.SQL.Add('SELECT');
    qryGer.SQL.Add('  GER_NOMCON,');
    qryGer.SQL.Add('  GER_ENDCON,');
    qryGer.SQL.Add('  GER_BAICON,');
    qryGer.SQL.Add('  GER_CEPCON,');
    qryGer.SQL.Add('  GER_CIDCON,');
    qryGer.SQL.Add('  GER_ESTCON,');
    qryGer.SQL.Add('  GER_TELCON,');
    qryGer.SQL.Add('  GER_CGCCPF,');
    qryGer.SQL.Add('  GER_CGCCON,');
    qryGer.SQL.Add('  GER_IESCON,');
    qryGer.SQL.Add('  GER_EMLCON,');
    qryGer.SQL.Add('  GER_R_GCON');
    qryGer.SQL.Add('FROM ' + strGer + ' WHERE ');
    qryGer.SQL.Add('GER_NUMDOC = :NUMDOC AND ');
    qryGer.SQL.Add('GER_ESPDOC = :ESPDOC AND ');
    qryGer.SQL.Add('GER_CODEMP = :CODEMP AND ');
    qryGer.SQL.Add(IIF(strPrefix = 'CLI_','GER_CODCLI','GER_CODFOR') + ' = :FORCLI AND ');
    qryGer.SQL.Add('GER_TIP_FC = :TIP_FC AND ');
    qryGer.SQL.Add('GER_SERIE_ = :SERIE_');

    qryGer.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    qryGer.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
    qryGer.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
    qryGer.ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
    qryGer.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
    qryGer.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
    qryGer.Open;

    If (qryGer.FieldByName('GER_NOMCON').IsNull) Or (fEmptyStr(qryGer.FieldByName('GER_NOMCON').AsString)) Then
      Exit;

    qryCliFor.Close;
    qryCliFor.SQL.Clear;
    qryCliFor.SQL.Add('SELECT');
    qryCliFor.SQL.Add(   strPrefix + 'NOM' + LeftStr(strPrefix,3) + ' GER_NOMCON,');
    qryCliFor.SQL.Add(   'CONCAT(' + strPrefix + 'ENDERE, ", " ,' + strPrefix + 'ENDNUM) GER_ENDCON,');
    qryCliFor.SQL.Add(   strPrefix + 'BAIRRO GER_BAICON,');
    qryCliFor.SQL.Add(   strPrefix + 'C_E_P_ GER_CEPCON,');
    qryCliFor.SQL.Add(   strPrefix + 'CODCID GER_CIDCON,');
    qryCliFor.SQL.Add(   strPrefix + 'FONE01 GER_TELCON,');
    qryCliFor.SQL.Add(   strPrefix + 'CGCCPF GER_CGCCPF,');
    qryCliFor.SQL.Add(   strPrefix + 'C_G_C_ GER_CGCCON,');
    qryCliFor.SQL.Add(   strPrefix + 'I_E_S_ GER_IESCON,');
    qryCliFor.SQL.Add(   strPrefix + 'EMAIL_ GER_EMLCON,');
    qryCliFor.SQL.Add(   strPrefix + IIF(strPrefix = 'CLI_', 'NUMR_G', 'NUMRG_') + ' GER_R_GCON,');
    qryCliFor.SQL.Add(   'CID_ESTADO GER_ESTCON');
    qryCliFor.SQL.Add('FROM');
    qryCliFor.SQL.Add(   IIF(strPrefix = 'CLI_', 'CADCLI', 'CADFOR'));
    qryCliFor.SQL.Add('LEFT JOIN ');
    qryCliFor.SQL.Add('  CADCID ON CID_CODCID = '+ strPrefix + 'CODCID');
    qryCliFor.SQL.Add('WHERE');
    qryCliFor.SQL.Add(   strPrefix + 'COD' + LeftStr(strPrefix,3) + ' = :CODIGO');

    qryCliFor.ParamByName('CODIGO').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
    qryCliFor.Open;

    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE ' + strGer + ' SET ');
    qryAux.SQL.Add('GER_NOMCON = :NOMCON,');
    qryAux.SQL.Add('GER_ENDCON = :ENDCON,');
    qryAux.SQL.Add('GER_BAICON = :BAICON,');
    qryAux.SQL.Add('GER_CEPCON = :CEPCON,');
    qryAux.SQL.Add('GER_CIDCON = :CIDCON,');
    qryAux.SQL.Add('GER_ESTCON = :ESTCON,');
    qryAux.SQL.Add('GER_TELCON = :TELCON,');
    qryAux.SQL.Add('GER_CGCCPF = :CGCCPF,');
    qryAux.SQL.Add('GER_CGCCON = :CGCCON,');
    qryAux.SQL.Add('GER_IESCON = :IESCON,');
    qryAux.SQL.Add('GER_EMLCON = :EMLCON,');
    qryAux.SQL.Add('GER_R_GCON = :R_GCON ');
    qryAux.SQL.Add('WHERE');
    qryAux.SQL.Add('GER_NUMDOC = :NUMDOC AND ');
    qryAux.SQL.Add('GER_ESPDOC = :ESPDOC AND ');
    qryAux.SQL.Add('GER_CODEMP = :CODEMP AND ');
    qryAux.SQL.Add(IIF(strPrefix = 'CLI_','GER_CODCLI','GER_CODFOR') + ' = :FORCLI AND ');
    qryAux.SQL.Add('GER_TIP_FC = :TIP_FC AND ');
    qryAux.SQL.Add('GER_SERIE_ = :SERIE_');

    qryAux.ParamByName('NOMCON').AsString := qryCliFor.FieldByName('GER_NOMCON').AsString;
    qryAux.ParamByName('ENDCON').AsString := qryCliFor.FieldByName('GER_ENDCON').AsString;
    qryAux.ParamByName('BAICON').AsString := qryCliFor.FieldByName('GER_BAICON').AsString;
    qryAux.ParamByName('CEPCON').AsString := qryCliFor.FieldByName('GER_CEPCON').AsString;
    qryAux.ParamByName('CIDCON').AsString := qryCliFor.FieldByName('GER_CIDCON').AsString;
    qryAux.ParamByName('ESTCON').AsString := qryCliFor.FieldByName('GER_ESTCON').AsString;
    qryAux.ParamByName('TELCON').AsString := qryCliFor.FieldByName('GER_TELCON').AsString;
    qryAux.ParamByName('CGCCPF').AsString := qryCliFor.FieldByName('GER_CGCCPF').AsString;
    qryAux.ParamByName('CGCCON').AsString := qryCliFor.FieldByName('GER_CGCCON').AsString;
    qryAux.ParamByName('IESCON').AsString := qryCliFor.FieldByName('GER_IESCON').AsString;
    qryAux.ParamByName('EMLCON').AsString := qryCliFor.FieldByName('GER_EMLCON').AsString;
    qryAux.ParamByName('R_GCON').AsString := qryCliFor.FieldByName('GER_R_GCON').AsString;
    qryAux.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    qryAux.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
    qryAux.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
    qryAux.ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
    qryAux.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
    qryAux.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
    qryAux.ExecSQL;

    For intCont := 0 To qryGer.Fields.Count -1 Do
    Begin
      strNomeCampo := qryGer.Fields[intCont].FieldName;
      If qryGer.FieldByName(strNomeCampo).AsString <>
         qryCliFor.FieldByName(strNomeCampo).AsString Then
      Begin
         pGravaLogFis(qryGer.FieldByName(strNomeCampo).AsString,
                      qryCliFor.FieldByName(strNomeCampo).AsString, strNomeCampo, strGer);
      End;
    End;
  End;
begin
  Try
    qryAux    := fCriaQuery(Self);
    qryCliFor := fCriaQuery(Self);
    qryGer    := fCriaQuery(Self);

    If (Pos('CANCELADO',qryTabela.FieldByName('FIS_HISTOR').AsString) > 0) Then
    Begin
      pUpdates('DEL_MOVGER');
      pUpdates('DEL_NOTGER');
    End
    Else
    Begin
      pUpdates('MOVGER');
      pUpdates('NOTGER');
    End;

  Finally
    FreeAndNil(qryAux);
    FreeAndNil(qryCliFor);
    FreeAndNil(qryGer);
  End;
end;

procedure TfrmCadLivroFiscal.pVerificaCfopCorreta(strCfop: String);
  Var
    intDigCla: Integer;
    blnVendaPresencial: Boolean;
    edtEstadoInterno: TEditFocus;
begin
  If fEmptyStr(strCfop) Then
    Raise Exception.Create('Favor informar a classificação fiscal!');

  intDigCla := StrToInt(LeftStr(strCfop, 1));

  edtEstadoInterno := edtEstado;
  If Not fEmptyStr(edtEstadoEnt.Text) and (intCLIREGFIS = 2) Then
    edtEstadoInterno := edtEstadoEnt;

  blnVendaPresencial := False;
  If (Not qryFisItens.IsEmpty) Then
    If (qryFisItens.FindField('AUX_VENPRE') <> NIL) Then
      blnVendaPresencial := (qryFisItens.FieldByName('AUX_VENPRE').AsString = 'S');

  If ((intDigCla = 1) And(edtEstadoInterno.Text <> qryCidEmp.FieldByName('CID_ESTADO').AsString) And (dbeEspDoc.Text <> 'CT')) And (Not blnVendaPresencial) Then
    Raise Exception.Create('Classificação permitida somente para entradas ou serviços do estado!')
  Else If ((intDigCla = 2) And (edtEstadoInterno.Text = qryCidEmp.FieldByName('CID_ESTADO').AsString) And (dbeEspDoc.Text <> 'CT')) Then
    Raise Exception.Create('Classificação permitida somente para entradas ou serviços de outro estado!')
  Else If ((intDigCla = 3) And (edtEstadoInterno.Text <> 'EX')) Then
    Raise Exception.Create('Classificação permitida somente para entradas ou serviços do exterior!')
  Else If ((intDigCla = 5) And (edtEstadoInterno.Text <> qryCidEmp.FieldByName('CID_ESTADO').AsString) And (Not blnVendaPresencial)) Then
    Raise Exception.Create('Classificação permitida somente para saídas ou serviços do estado!')
  Else If ((intDigCla = 6) And (edtEstadoInterno.Text = qryCidEmp.FieldByName('CID_ESTADO').AsString)) Then
    Raise Exception.Create('Classificação permitida somente para saídas ou serviços de outro estado!')
  Else If ((intDigCla = 7) And (edtEstadoInterno.Text <> 'EX')) Then
    Raise Exception.Create('Classificação permitida somente para saídas ou serviços do exterior!');
end;

procedure TfrmCadLivroFiscal.pVerificaCtaPagar(var blnCtaPagar,
  blnCtaBaixado, blnCtaPagarComRetencaoImp, blnCtaPagarComRetencaoImpPago, blnCtaPagarAntecipado: Boolean; var AListaRetencao: String);
var
  qryCta : TUniQuery;
  strSQL: String;
begin
  blnCtaPagar   := False;
  blnCtaBaixado := False;
  blnCtaPagarComRetencaoImp:= False;
  blnCtaPagarComRetencaoImpPago := False;
  blnCtaPagarAntecipado := False;

  If (qryTabela.FieldByName('FIS_TIP_FC').AsString<>'F') Or
     (qryTabela.FieldByName('FIS_ENTSAI').AsString<>'E') Then
    Exit;

  qryCta := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT AUTOINCREM, MAX(CTP_DTAPAG) AS CTP_DTAPAG ';
  strSQL := strSQL + '   FROM CADPAG ';
  strSQL := strSQL + '  WHERE ';
  strSQL := strSQL + '   CTP_PAGANT = "N"     AND  ';
  strSQL := strSQL + '   CTP_CODFOR = :CODFOR AND  ';
  strSQL := strSQL + '   CTP_NUMDUP = :NUMDUP AND  ';
  strSQL := strSQL + '   CTP_CODEMP = :CODEMP AND  ';
  strSQL := strSQL + '   CTP_DTACAD >= :DTAENT AND ';
  strSQL := strSQL + '   CTP_SERIE_ = :SERIE_      ';

  With qryCta Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    ParamByName('CODFOR').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
    ParamByName('NUMDUP').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
    ParamByName('DTAENT').AsDateTime := qryTabela.FieldByName('FIS_DTAENT').AsDateTime;
    ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;

    Open;

    blnCtaPagar   := (FieldByName('AUTOINCREM').Value <> Null) And (RecordCount > 0);
    blnCtaBaixado := Not (FieldByName('CTP_DTAPAG').Value = Null);

    strSQL := '';
    strSQL := strSQL + '  SELECT AUTOINCREM, MAX(CTP_DTAPAG) AS CTP_DTAPAG ';
    strSQL := strSQL + '    FROM CADPAG ';
    strSQL := strSQL + '   WHERE ';
    strSQL := strSQL + '    CTP_PAGANT = "S"     AND  ';
    strSQL := strSQL + '    CTP_USOFIS = "S"     AND  ';
    strSQL := strSQL + '    CTP_CODFOR = :CODFOR AND  ';
    strSQL := strSQL + '    CTP_NUMDUP = :NUMDUP AND  ';
    strSQL := strSQL + '    CTP_CODEMP = :CODEMP AND  ';
    strSQL := strSQL + '    CTP_SERIE_ = :SERIE_      ';

    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODFOR').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
    ParamByName('NUMDUP').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
    ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;

    Open;
    blnCtaPagarAntecipado   := (FieldByName('AUTOINCREM').Value <> Null) And (RecordCount > 0);

    Close;
  End;

  {VERIFICA SE EXISTE ALGUMA DUPLICATA DE RETENÇÃO DE IMPOSTO}
  blnCtaPagarComRetencaoImp := False;
  blnCtaPagarComRetencaoImpPago := False;
  If fNFServico Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT AUTOINCREM , CTP_DTAPAG FROM CADPAG ';
    strSQL := strSQL + ' WHERE CTP_HIST01 LIKE "%'+qryTabela.FieldByName('FIS_NUMDOC').AsString+ '-';
    strSQL := strSQL + qryTabela.FieldByName('FIS_ESPDOC').AsString + '-';
    strSQL := strSQL + qryTabela.FieldByName('FIS_SERIE_').AsString + '-';
    strSQL := strSQL + qryTabela.FieldByName('FIS_CODEMP').AsString + ', ';
    strSQL := strSQL + 'Fornecedor: '+qryTabela.FieldByName('FIS_FORCLI').AsString+'%"';
    With qryCta Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      Open;

      AListaRetencao := '';

      blnCtaPagarComRetencaoImp := Not(IsEmpty);
      while not qryCta.Eof Do
      Begin
        AListaRetencao := AListaRetencao + '"' + qryCta.FieldByName('AUTOINCREM').AsString + '"';
        If not blnCtaPagarComRetencaoImpPago Then
          blnCtaPagarComRetencaoImpPago := qryCta.FieldByName('CTP_DTAPAG').AsString <> '';
        qryCta.Next;
        If not qryCta.Eof then
          AListaRetencao := AListaRetencao +  ',';
      End;
      Close;
    End;

  End;

  FreeAndNil(qryCta);
end;

procedure TfrmCadLivroFiscal.pLimpaCamposDominioAcumulador;
begin
  cbxClaFisAcu.ItemIndex := -1;
  edtCodAcu.Clear;
  edtPerAcu.Clear;
end;

procedure TfrmCadLivroFiscal.pLimpaDadosComplementares;
begin
  memInfAdicFisco.Clear;
  memInfCpl.Clear;

  tbsDadosCpl.TabVisible := False;

  pHabilitaInfCpl;
end;

procedure TfrmCadLivroFiscal.pLimpaEdits;
begin
  edtNomFor.Clear;
  edtCidade.Clear;
  edtNumCep.Clear;
  edtDesEmp.Clear;
  edtCgcCpf.Clear;

end;

procedure TfrmCadLivroFiscal.pCarregaDadosAdicionais;
begin
  If dbeTip_Fc.Text = 'C' Then
    pCarregaCliente
  Else
    pCarregaFornecedor;

  pCarregaEmpresa;

  dbeCodCon.Visible := (fCfgSis('CODCON', varBoolean)) And (dbeTip_Fc.Text = 'F');
  lblCodCon.Visible := (fCfgSis('CODCON', varBoolean)) And (dbeTip_Fc.Text = 'F');

  chkNfExtemporanea.Checked := qryTabela.Active And (qryTabela.FieldByName('FIS_NFEXTE').AsString = 'S');

  arrAliICM[1] := fStrToFloat(dbeAlqIc1.Text);
  arrAliICM[2] := fStrToFloat(dbeAlqIc2.Text);
  arrAliICM[3] := fStrToFloat(dbeAlqIc3.Text);
  arrAliICM[4] := fStrToFloat(dbeAlqIc4.Text);
  arrAliICM[5] := fStrToFloat(dbeAlqIc4.Text);

  If (qryTabela.FieldByName('FIS_ESPDOC').AsString = 'IF') Then
  Begin
    grpCupomFiscal.Visible := True;
    lblNumSer.Visible := True;
    dbeNumSer.Visible := True;
    lblNumCoo.Visible := True;
    dbeNumCoo.Visible := True;
  End
  Else
  Begin
    grpCupomFiscal.Visible := False;
    lblNumSer.Visible := False;
    dbeNumSer.Visible := False;
    lblNumCoo.Visible := False;
    dbeNumCoo.Visible := False;
  End;

  btnConfirmar.Enabled := False;
  dbgItens.Repaint;

  pCalculaValorDocumento;

  pnlBotoes.Enabled := True;

  // Verifica se é uma nota de entrada complementar de fornecedor
  // para habilitar a aba "Dados Complementares" (RQ.71079)
  tbsDadosCpl.TabVisible := ((dbeEntSai.Text = 'E') AND
                         (dbeNfComple.Text = 'S') AND
                         (dbeTip_Fc.Text = 'F'));

  if (tbsDadosCpl.TabVisible) then
  begin
    pCarregaDadosCpl;
  end;
end;

procedure TfrmCadLivroFiscal.pCarregaDadosCpl;
var
  qryTblMovObs: TUniQuery;
begin
  try
    try
      qryTblMovObs := fCriaQuery;

      qryTblMovObs.SQL.Add('SELECT * FROM OBSFIS WHERE OBS_SEQFIS = :SEQFIS');
      qryTblMovObs.ParamByName('SEQFIS').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
      qryTblMovObs.Open;

      memInfCpl.Text := AnsiReplaceStr(qryTblMovObs.FieldByName('OBS_INFCPL').AsString, STRING_QUEBRA, STRING_ENTER);
      memInfAdicFisco.Text := AnsiReplaceStr(qryTblMovObs.FieldByName('OBS_OBSFIS').AsString, STRING_QUEBRA, STRING_ENTER);

      qryTblMovObs.Close;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmCadLivroFiscal.pCarregaDadosCpl]');
      End;
    End;

  Finally
    FreeAndNil(qryTblMovObs);
  End;
end;

procedure TfrmCadLivroFiscal.pCarregaDadosNotaComplementar;
var
    arrParticipante: TConsultasArray;
    qryNfComplementar: TUniQuery;
begin
  qryNfComplementar := fCriaQuery(nil);
  try
    with qryNfComplementar do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT FIS_TIP_FC, FIS_DTAENT, FIS_NUMDOC, FIS_ESPDOC, IFNULL(FIS_SERIE_, "") AS FIS_SERIE_, FIS_FORCLI ' +
                  ' FROM CADFIS WHERE AUTOINCREM = :AUTOINC ';
      ParamByName('AUTOINC').AsString := qryTabela.FieldByName('FIS_ATNFCP').AsString;
      Open;

      mskDataNfComplementar.Text := qryNfComplementar.FieldByName('FIS_DTAENT').AsString;
      edtNumeroNfComplementar.Text := qryNfComplementar.FieldByName('FIS_NUMDOC').AsString;
      edtEspecieNfComplementar.Text := qryNfComplementar.FieldByName('FIS_ESPDOC').AsString;
      edtParticipanteNfComplementar.Text := qryNfComplementar.FieldByName('FIS_FORCLI').AsString;
      edtSerieNfComplementar.Text := qryNfComplementar.FieldByName('FIS_SERIE_').AsString;

      SetLength(arrParticipante, 1);
      arrParticipante[0].strCodigo := qryNfComplementar.FieldByName('FIS_FORCLI').AsString;

      if qryNfComplementar.FieldByName('FIS_TIP_FC').AsString = 'C' then
        pEdtCodSelectExit(edtParticipanteNfComplementar, edtNomPartNfComplementar, arrParticipante, nil, fRetNomCliente, 'do Cliente')
      else
        pEdtCodSelectExit(edtParticipanteNfComplementar, edtNomPartNfComplementar, arrParticipante, fRetNomFornecedor, nil,'do Fornecedor')
    end;
  finally
    qryNfComplementar.Free;
  end;
end;

{procedure TfrmCadLivroFiscal.btnCalcRetClick(Sender: TObject);
  Var
    fltRetIss   : Double;
    fltRetPis   : Double;
    fltRetCsll  : Double;
    fltRetInss  : Double;
    fltRetIrrf  : Double;
    fltRetCofins: Double;
    fltCalcRet: Double;
begin
  inherited;

  Try
    If (cdsForRet.State = dsEdit) Then cdsForRet.Post();

    cdsForRet.DisableControls();
    cdsForRet.First();

    fltRetIss    := 0;
    fltRetPis    := 0;
    fltRetCsll   := 0;
    fltRetInss   := 0;
    fltRetIrrf   := 0;
    fltRetCofins := 0;

    While (Not cdsForRet.Eof) Do Begin
      cdsForRet.Edit();

      fltCalcRet := qryTabela.FieldByName('FIS_VLCON1').AsFloat *
        (cdsForRet.FieldByName('RET_ALIQUO').AsFloat / 100);

      If cdsForRet.FieldByName('RET_TIPRET').AsInteger In [0, 1, 2,3] Then
      Begin
        If (fStrToFloat(edtTotDoc.Text) < fltMinDocRet) Or
           (fltCalcRet < fltMinRet) Then
           fltCalcRet := 0;
      End;

      cdsForRet.FieldByName('VALRET').AsFloat := fltCalcRet;



      Case (cdsForRet.FieldByName('RET_TIPRET').AsInteger) Of
        0: fltRetPis    := fltRetPis    + cdsForRet.FieldByName('VALRET').AsFloat;
        1: fltRetCofins := fltRetCofins + cdsForRet.FieldByName('VALRET').AsFloat;
        2: fltRetCsll   := fltRetCsll   + cdsForRet.FieldByName('VALRET').AsFloat;
        3: fltRetIrrf   := fltRetIrrf   + cdsForRet.FieldByName('VALRET').AsFloat;
        4: fltRetInss   := fltRetInss   + cdsForRet.FieldByName('VALRET').AsFloat;
        5: fltRetIss    := fltRetIss    + cdsForRet.FieldByName('VALRET').AsFloat;
      End;

      If (cdsForRet.RecordCount = cdsForRet.RecNo) Then
        pAjustarCamposRetencoesLivFis(fltRetPis,
                                      fltRetCofins,
                                      fltRetCsll,
                                      fltRetIrrf,
                                      fltRetInss,
                                      fltRetIss);

      cdsForRet.Next();
    End;
  Finally
    cdsForRet.EnableControls();
  End;
end;
}

procedure TfrmCadLivroFiscal.btnCancelaClick(Sender: TObject);
begin
  inherited;
  dbgItensDBTableViewCitel1.OnDblClick := nil;
  pAtualizaLabelCfopInvalida;
  pEnabledFisAju;
  pEnabledCodigoClasseConsumoEnergiaEletrica;
  pAtivaCampoCst;
  pAtivaEventoDeEntrega;
  pDesabilitaEditsNfComplementar;
  pCarregaDadosAdicionais;
  pCarregaItens;
  pJustaCamposImpostos;
  pCarregaDominioAcumulador;
  pHabilitaCamposGerais(qryFisItens.IsEmpty);
  pHabilitaNFComplemento;
  pHabilitaCTCompraVenda;
  pHabilitaInfCpl;
  pManipulaCampoCodigoVerificador;
  pManipulaCampoCodigoTipoServico;

  pCarregaModFis(qryTabela.FieldByName('FIS_ACESSO').AsString);
  fraCadImpostosNFS.pReset;
  fraCadImpostosNFS.strClaFis := dbeClfSc1.Text;
  fraCadImpostosNFS.strEspDoc := dbeEspDoc.Text;
  fraCadImpostosNFS.cdsForRet.Close;
  fraCadImpostosNFS.qryForRet.Close;

  fraCadImpostosNFS.pCarregarRetencoes;

  fraCadImpostosNFS.pCarregaDadosReinf;

  blnAlterouPisCofins := False;

  pEnabledFraCadImpostosNFS(False);
  fLockUnlock(False);
  if cdsDocsCTE.Active then
    cdsDocsCTE.CancelUpdates;
  if Assigned(stlRegistrosExcluidosRECTNF) then
    stlRegistrosExcluidosRECTNF.Clear;
  btnDocCTEIncluir.Enabled := False;
  btnDocCTEExcluir.Enabled := False;
end;

procedure TfrmCadLivroFiscal.btnCancelarFisAjuClick(Sender: TObject);
begin
  If (qryFisAju.State = dsInsert) Or (qryFisAju.State = dsEdit) Then
  Begin
    Try
      qryFisAju.Cancel;
      pOnStateChangeFisAju;
      pEnabledFisAju;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'Cancelar operação');
      End;
    End;
  End;
end;

procedure TfrmCadLivroFiscal.pHabilitaDadosFiscais(blnHabilita: Boolean; intNumCampo: Integer);
begin
  (fComponentByName(tbsDocs, 'dbeVlCon' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'dbeBasIc' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'dbeAlqIc' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'dbeVlrIc' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'dbeOutra' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'dbeIsent' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'dbeBcret' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'dbeRetid' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'dbeBasIp' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'dbeVlrIp' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'dbeBasAn' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'dbeAntIc' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'dbeBasIp' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'dbeVlrIp' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'dbeBaeRe' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'DBEVAERET' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'dbeBaeIP' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'DBEVAEIPI' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'DBEFCPST' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'DBEVFCPS' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'DBEBAFCP' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'DBEVLFCP' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'DBEQBCMO' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'DBEVALMO' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'DBEBCCBS' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'DBEVLCBS' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'DBEBCIBS' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'DBEVLIBS' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'DBEBC_IS' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
  (fComponentByName(tbsDocs, 'DBEVL_IS' + IntToStr(intNumCampo)) As TDBEditFocus).Enabled := blnHabilita;
end;

procedure TfrmCadLivroFiscal.pCalculaValIcm(intNumCampo: Integer);
  Var
    dbeClfsc, dbeBase, dbeAlq, dbeValor: TDBEditFocus;
    fltBase, fltAlq, fltValor: Double;
begin
  dbeClfsc := (fComponentByName(tbsDocs ,'dbeClfSc' + IntToStr(intNumCampo)) As TDBEditFocus);
  dbeBase  := (fComponentByName(tbsDocs ,'dbeBasIc' + IntToStr(intNumCampo)) As TDBEditFocus);
  dbeAlq   := (fComponentByName(tbsDocs ,'dbeAlqIc' + IntToStr(intNumCampo)) As TDBEditFocus);
  dbeValor := (fComponentByName(tbsDocs ,'dbeVlrIc' + IntToStr(intNumCampo)) As TDBEditFocus);

  If fStrToFloat(dbeAlq.Text) <> arrAliICM[intNumCampo]  Then
  Begin
    If fEmptyStr(dbeBase.Text) Then
      dbeBase.Text := '0';

    If fEmptyStr(dbeAlq.Text) Then
      dbeAlq.Text := '0';

    fltBase := fStrToFloat(dbeBase.Text);
    fltAlq  := fStrToFloat(dbeAlq.Text);

    fltValor := fCalculaValorIcms(fltBase, fltAlq, lblRICMPR.Visible);

    dbeValor.Text := FloatToStr(fltValor);

    qryTabela.fieldbyname('FIS_VLRIC'+IntToStr(intNumCampo)).AsFloat := fltValor;

    If fEmptyStr(dbeClfsc.Text) Then
    Begin
      dbeBase.Clear;
      dbeAlq.Clear;
      dbeValor.Clear;
    End;

    arrAliICM[intNumCampo] := fStrToFloat(dbeAlq.Text);
  End;
end;

procedure TfrmCadLivroFiscal.pHabilitaDadosFiscais;
begin
  pHabilitaDadosFiscais(Not fEmptyStr(dbeClfSc2.Text), 2);
  pHabilitaDadosFiscais(Not fEmptyStr(dbeClfSc3.Text), 3);
  pHabilitaDadosFiscais(Not fEmptyStr(dbeClfSc4.Text), 4);
  pHabilitaDadosFiscais(Not fEmptyStr(dbeClfSc5.Text), 5);
end;

procedure TfrmCadLivroFiscal.pHabilitaInfCpl;
begin
  If (qryTabela.State in [dsInsert,dsEdit]) then
  begin
    memInfAdicFisco.Enabled := True;
    memInfCpl.Enabled := True;
  end
  else
  begin
    memInfAdicFisco.Enabled := False;
    memInfCpl.Enabled := False;
  end;
end;

procedure TfrmCadLivroFiscal.pHabilitaNFComplemento;
begin
  dbeNfComple.ReadOnly := Not(qryFisItens.IsEmpty);
end;

procedure TfrmCadLivroFiscal.dbeForCliKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If dbeTip_Fc.Text = 'C' Then
      pBuscaCliente
    Else
      pBuscaFornecedor;
  End;
end;

procedure TfrmCadLivroFiscal.dbeIsent1Exit(Sender: TObject);
begin
  inherited;
  pValorOutras;
  pCalculaTotais;
end;

procedure TfrmCadLivroFiscal.dbeNatCfoEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'INSERT para fazer um novo cadastro';
end;

procedure TfrmCadLivroFiscal.dbeNatCfoKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  if fPesqCFOP(Self, dbeNatCfo, Nil, Nil, Key, arrSel, True, fFiltroCFOP) then
  Begin
    if fValidaCampos(dbeNatCfo) then
      SelectNext(ActiveControl, True, True);
  End;
  If Key = #13 Then
  Begin
    If btnGravar.Enabled Then
      pSetFocus(btnGravar);
  End;

end;

procedure TfrmCadLivroFiscal.dbeNcmIteKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  If fPesqNCM(Self.Name, qryCadNcm, Key, arrSel) Then
  Begin
    dbeNcmIte.Text := qryCadNcm.FieldByName('NCM_CODNCM').AsString;
    if fValidaCampos(dbeNcmIte) then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadLivroFiscal.dbeNfCompleChange(Sender: TObject);
begin
  inherited;
  // Verifica se é uma nota de entrada complementar de fornecedor
  // para habilitar a aba "Dados Complementares" (RQ.71079)
  tbsDadosCpl.TabVisible := ((dbeEntSai.Text = 'E') AND
                         (dbeNfComple.Text = 'S') AND
                         (dbeTip_Fc.Text = 'F'));

  pDesabilitaBotoesCompValor;

  tbsNotaAssociadoComplemento.TabVisible := ((dbeNfComple.Text = 'S') and (dbeEntSai.Text = 'E'));
end;

procedure TfrmCadLivroFiscal.dbeNumDocExit(Sender: TObject);
begin
  inherited;
  pFormatarNumDoc;
end;

procedure TfrmCadLivroFiscal.dbeTip_FcChange(Sender: TObject);
begin
  inherited;
  lblTip_fc.Caption := 'Código do ' + IIF(dbeTip_Fc.Text = 'C', 'Cliente', 'Fornecedor')+ ':';
  lblCgcCpf.Caption := IIF(dbeTip_Fc.Text = 'C', 'CPF', 'CNPJ')+ ':';


  With fraCadImpostosNFS Do
  If (grbRetencoes.Visible) And (dbeTip_Fc.Text = 'C') Then
  Begin
    grbRetencoes.Visible := False;
    grbRetencoes.Enabled := False;
    pnlBotoesImp.Visible := False;
    grpRetencaoDados.Visible := False;
    cdsForRet.Close;
    qryForRet.Close;
  End
  Else
    pCarregarRetencoes();

  // Verifica se é uma nota de entrada complementar de fornecedor
  // para habilitar a aba "Dados Complementares" (RQ.71079)
  tbsDadosCpl.TabVisible := ((dbeEntSai.Text = 'E') AND
                         (dbeNfComple.Text = 'S') AND
                         (dbeTip_Fc.Text = 'F'));
end;

procedure TfrmCadLivroFiscal.dbeVlCon1Exit(Sender: TObject);
begin
  inherited;
  {If grbRetencoes.Visible Then
    btnCalcRet.Click;
  If fRegraPisCofinsServico Then
    pCarregaPisCofins(qryTabela.FieldByName('FIS_CLFSC1').AsString, qryTabela.FieldByName('FIS_CSTPIS').AsString, qryTabela.FieldByName('FIS_CSTCOF').AsString);
  }
  pValorOutras;
  pCalculaTotais;
end;

procedure TfrmCadLivroFiscal.dbeVlCon2Exit(Sender: TObject);
begin
  inherited;
  pCalculaTotais
end;

procedure TfrmCadLivroFiscal.pBuscaCliente;
  Var
    chrKey: Char;
    arrClientes: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  chrKey := '/';
  If fPesqCliente(conCliSimples, Self, dbeForCli, edtNomFor, Nil, chrKey, arrClientes) Then
  Begin
    If fValidaCampos(dbeForCli, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
      pCarregaDadosAdicionais;
    End;
  End;
end;

procedure TfrmCadLivroFiscal.pBuscaFornecedor;
  var
    chrKey: Char;
    arrFornec: TConsultasArray;
begin
  inherited;
  chrKey := '/';
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForSimples, Self, dbeForCli, edtNomFor, Nil, chrKey, arrFornec) Then
  Begin
    If fValidaCampos(dbeForCli, True) Then
      SelectNext(ActiveControl, True, True);
  End;
  pCarregaDadosAdicionais;
end;

procedure TfrmCadLivroFiscal.FormShow(Sender: TObject);
begin
  inherited;

  if not fEmptyStr(strAutoincrem) then
  begin
    pInicializarTabela('SELECT * FROM CADFIS WHERE AUTOINCREM = ' + strAutoincrem.QuotedString);
    qryTabela.Open;
  end;
  pHabilitarTabGia;
  pCarregaDadosAdicionais;
  pHabilitaCTCompraVenda;
  pSetFocus(btnIncluir);
  qryFisAju.Open;
  pEnabledFisAju;
  pEnabledCodigoClasseConsumoEnergiaEletrica;
  pOnStateChangeFisAju;
  pManipulaCampoCodigoTipoServico;
  pHabilitaDadosOffline;

  If fCfgSis('DIFAL_') = 'S' Then
    btnDifal.Visible := True
  Else
    btnDifal.Visible := False;

  If fCfgSis('X60CAT') = 'S' Then
    grpDadosCat158.Visible := True
  Else
    grpDadosCat158.Visible := False;

  //pnlTipoFrete.Visible := (fCfgSis('RATFRE', varInteger) = 3);

  strEstEmp := fCadEmp('ESTADO');

//  grbRetencoes.Enabled := False;
  strDEMQDD := fCfgSis('DEMQDD', varString);
end;

procedure TfrmCadLivroFiscal.pLimparConteudoItens;
var i: integer;
begin
  for i := 0 To ComponentCount -1 do
  Begin
   If Components[i] is TEdit Then
     TEdit(Components[i]).Clear;
  End;
End;

procedure TfrmCadLivroFiscal.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
begin
  chrKey:='?';
  If not fPesqLivroFiscal(Self, qryTabela, chrKey, arrSel, True) Then
    Exit;
  pConsultarGia;
  pHabilitarTabGia;
  dbgItensDBTableViewCitel1.OnDblClick := nil;
  pLimparConteudoItens;
  pLimpaDadosComplementares;
  pCarregaDadosAdicionais;
  pCarregaItens(False, True);
  pJustaCamposImpostos;
  pHabilitaCanhotoNF;
  pHabilitaCTCompraVenda;
  pCarregaEmpresa;
  pDesabilitaEditsNfComplementar;
  pHabilitaDadosOffline;

  qryFisAju.SQL.Clear;
  qryFisAju.SQL.Add('SELECT * FROM FISAJU WHERE AJU_SEQGER = :SEQGER');
  qryFisAju.ParamByName('SEQGER').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
  qryFisAju.Open;

  pHabilitaCamposGerais(qryFisItens.IsEmpty);

  pAtualizaLabelCfopInvalida;

  pAtivaCampoCst;
  pAtivaEventoDeEntrega;

  pManipulaCampoCodigoVerificador;
  pManipulaCampoCodigoTipoServico;

  pEnabledFisAju;
  pEnabledCodigoClasseConsumoEnergiaEletrica;

  pCarregaDadosNotaComplementar;
  if qryTabela.FieldByName('FIS_ESPDOC').AsString = 'CT' Then
  Begin
    tbsDocumentosCTE.TabVisible := True;
    btnDocCTEIncluir.Enabled := False;
    btnDocCTEExcluir.Enabled := False;

    pCarregaDocumentosAssociadosCTE;
  End Else
    tbsDocumentosCTE.TabVisible := False;

  fraCadImpostosNFS.pReset;
  fraCadImpostosNFS.blnAlteracaoLivro := True;
  fraCadImpostosNFS.pAtualizaDados(qryTabela.FieldByName('FIS_ESPDOC').AsString,
                                   qryTabela.FieldByName('FIS_CLFSC1').AsString,
                                   qryTabela.FieldByName('FIS_TIP_FC').AsString,
                                   edtNomFor.Text,
                                   qryTabela.FieldByName('FIS_ENTSAI').AsString,
                                   qryTabela.FieldByName('FIS_FORCLI').AsString,
                                   qryTabela.FieldByName('FIS_CODEMP').AsString,
                                   qryTabela.FieldByName('FIS_NUMDOC').AsString,
                                   qryTabela.FieldByName('FIS_SERIE_').AsString,
                                   qryTabela.FieldByName('FIS_DTADOC').AsDateTime,
                                   qryTabela.FieldByName('FIS_DTAENT').AsDateTime);
  fraCadImpostosNFS.pCarregarRetencoes;
  fraCadImpostosNFS.pCarregaDadosReinf;

  pCarregaDominioAcumulador;

  pCarregaModFis(qryTabela.FieldByName('FIS_ACESSO').AsString);

  tbsNotaAssociadoComplemento.TabVisible := ((dbeNfComple.Text = 'S') and (dbeEntSai.Text = 'E'));

  pCalculaTotais;

  pCarregaTipoLancamentoCTE;

  tbsChaveRef.TabVisible := fCarregaChavesReferenciadas;

  pCarregarStatus;

  pCarregaPerfil;

  pSetaBaseFrete;

  if pgcDetalhes.ActivePage = tbsFinanceiro then
    if Assigned(pgcDetalhes.OnChange) then
      pgcDetalhes.OnChange(pgcDetalhes);

  if Assigned(stlRegistrosExcluidosRECTNF) then
    stlRegistrosExcluidosRECTNF.Clear;
end;

procedure TfrmCadLivroFiscal.btnPesquisarNfEntradaClick(Sender: TObject);
  var
    chrKey: Char;
    arrSelTest, arrParticipante: TConsultasArray;
    qryNfComplementar: TUniQuery;
begin
  inherited;

  qryNfComplementar := fCriaQuery(nil);
  try
    chrKey:= '?';

    //carregar consulta, filtrando o fornecedor envolvido no complemento;
    if not fPesqLivroFiscal(Self, qryNfComplementar, chrKey, arrSelTest, True, conNotaComplementar, '', dbeForCli.Text, '', dbeNumDoc.Text) then
      Exit;

    qryTabela.FieldByName('FIS_ATNFCP').AsString := qryNfComplementar.FieldByName('AUTOINCREM').AsString;

    mskDataNfComplementar.Text := qryNfComplementar.FieldByName('FIS_DTAENT').AsString;
    edtNumeroNfComplementar.Text := qryNfComplementar.FieldByName('FIS_NUMDOC').AsString;
    edtEspecieNfComplementar.Text := qryNfComplementar.FieldByName('FIS_ESPDOC').AsString;
    edtParticipanteNfComplementar.Text := qryNfComplementar.FieldByName('FIS_FORCLI').AsString;
    edtSerieNfComplementar.Text := qryNfComplementar.FieldByName('FIS_SERIE_').AsString;

    SetLength(arrParticipante, 1);
    arrParticipante[0].strCodigo := qryNfComplementar.FieldByName('FIS_FORCLI').AsString;

    if qryNfComplementar.FieldByName('FIS_TIP_FC').AsString = 'C' then
      pEdtCodSelectExit(edtParticipanteNfComplementar, edtNomPartNfComplementar, arrParticipante, nil, fRetNomCliente, 'do Cliente')
    else
      pEdtCodSelectExit(edtParticipanteNfComplementar, edtNomPartNfComplementar, arrParticipante, fRetNomFornecedor, nil,'do Fornecedor')
  finally
    qryNfComplementar.Free;
  end;
end;

procedure TfrmCadLivroFiscal.pHabilitarDocumentoConferido;
begin
  If (Not dtsTabela.AutoEdit) Then
    Exit;
  If (Not fVerificaAcessoSistema('PERMEDITDOCJACONFERIDO')) Then
  Begin
    chkDocumentoConferido.Enabled := False;
    Exit;
  End;
  chkDocumentoConferido.Enabled := ((qryTabela.Active) And (Not qryTabela.IsEmpty) And (qryTabela.State In [dsBrowse, dsEdit, dsInsert]));
end;

procedure TfrmCadLivroFiscal.pHabilitaCamposGerais(blnHabilita: Boolean);
begin
  pHabilitarDocumentoConferido;

  chkNfExtemporanea.Enabled := qryTabela.Active And (qryTabela.State In [dsEdit, dsInsert]);

  tbsDocs.Enabled := blnHabilita;

  //dbeCstPis.ReadOnly     := Not blnHabilita;
  dbeBasPis.ReadOnly := (Not blnHabilita) And
                          Not (fLiberaEdicaoBasePISCOFINSEnergiaComunicacao);

  //dbeAlqPis.ReadOnly     := Not blnHabilita;
  dbeNatRecPis.ReadOnly  := Not blnHabilita;

  //dbeCstCof.ReadOnly     := Not blnHabilita;
  dbeBasCof.ReadOnly     := dbeBasPis.ReadOnly;
  //dbeAlqCof.ReadOnly     := Not blnHabilita;
  dbeNatRecCof.ReadOnly  := Not blnHabilita;

  btnAtualizaCstAliquotaProdutos.Enabled:= Not(dbeAlqPis.ReadOnly) And (dbeAlqPis.Enabled = True) And
                                           Not(dbeCstPis.ReadOnly) And (dbeCstPis.Enabled = True) And
                                           Not(dbeAlqCof.ReadOnly) And (dbeAlqCof.Enabled = True) And
                                           Not(dbeCstCof.ReadOnly) And (dbeCstCof.Enabled = True);
  
  dbeDtaEnt.ReadOnly     := Not blnHabilita;

  pDesabilitaBotoesCompValor;

  If strTabela <> 'ITECOM' Then
  Begin
    btnReconstruir.Visible := Not blnHabilita;
    btnAltData.Visible     := (Not blnHabilita) And (Not fEmptyStr(strTabela));
  End;

  {*************************************************}
  {* SOLICITAÇÃO PARA LIBERAR A ALTERAÇÃO DA SÉRIE *}
  {*********************************21/11/2012**CI**}
  //btnAlterarSerie.Visible := Not blnHabilita;
end;

procedure TfrmCadLivroFiscal.btnReconstruirClick(Sender: TObject);
begin
  inherited;
  If (qryTabela.State = dsEdit) Then
    fReconstruirLivro(False)
  Else
    fMensagem('', 'Por favor, edite o registro.', ['&Ok']);
end;

procedure TfrmCadLivroFiscal.btnRefreshClick(Sender: TObject);
Begin
  inherited;
  If Not fDocumentoStateBrowse Then
  Begin
    pMensagemOk('Para atualizar os dados do movimento, é necessário selecionar um documento e o mesmo ' +
      'não pode estar em inclusão ou edição.');
    Exit;
  End;

  If qryTabela.FieldByName('FIS_TIP_FC').AsString = 'F' Then
  Begin
    If fRetEstadoFornecedor(dbeForCli.Text) <> qryTabela.FieldByName('FIS_ESTADO').AsString Then
    Begin
      pMensagemOk('Impossível Atualizar. Estado do fornecedor foi alterado e difere do Estado cadastrado no Livro Fiscal.');
      Exit;
    End;
  End
  Else
  Begin
    If fRetEstadoCliente(dbeForCli.Text) <> qryTabela.FieldByName('FIS_ESTADO').AsString Then
    Begin
      pMensagemOk('Impossível Atualizar. Estado do cliente foi alterado e difere do Estado cadastrado no Livro Fiscal.');
      Exit;
    End;
  End;

  If Not fValidaFechamentoFiscalEstoque Then
  Begin
    Exit;
  End;

  Try
    btnRefresh.Enabled := False;
    Screen.Cursor := crHourGlass;

    pRefreshDocumento;
  Finally
    btnRefresh.Enabled := True;
    Screen.Cursor := crDefault;
  End;
end;


procedure TfrmCadLivroFiscal.cdsForRetRET_ALIQUOChange(Sender: TField);
begin
  inherited;

  //
end;

procedure TfrmCadLivroFiscal.chkDocumentoConferidoClick(Sender: TObject);
begin
  pConferirDocumento(chkDocumentoConferido.Checked);
end;

procedure TfrmCadLivroFiscal.cmbNatOpeChange(Sender: TObject);
begin
  inherited;

  pChangeNatOpe(False);
end;

procedure TfrmCadLivroFiscal.pChangeNatOpe(ABlnItem: Boolean);
var
  strNatOpe,
  strAutInc: String;
begin
  //ABlnItem = False, estou trocando pela capa
  //AblnItem = True, estou trocando pelo item
  strNatOpe := IIF(ABlnItem, cmbNatOpeItem.Text, cmbNatOpe.Text);
  strAutInc := qryFisItens.FieldByName('AUTOINCREM').AsString;

  If qryFisItens.IsEmpty Then
    Exit;

  Try
    If ABlnItem then
      qryFisItens.Filter := 'AUTOINCREM = '+Quotedstr(strAutInc)
    Else
      qryFisItens.Filter := 'CLAFIS = ' + Quotedstr(dbeNatCfo.Text) + ' AND ALQICM = ' + dbeAlqIc1.Text;

    qryFisItens.Filtered := True;
    qryFisItens.DisableControls;
    qryFisItens.First;
    fStartTransaction;
    try
      While Not qryFisItens.Eof Do
      Begin

        FqryUpdNatOpeItem.ParamByName('NATOPE').AsString := strNatOpe;
        FqryUpdNatOpeItem.ParamByName('AUTOIN').AsString := qryFisItens.FieldByName('AUTOINCREM').AsString;
        FqryUpdNatOpeItem.ExecSQL;
        qryFisItens.Next;
      End;
      fCommit;
    Except On
      E:Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, '[pChangeNatOpe]');
      End;
    End;
  Finally
    qryFisItens.Filtered := False;
    qryFisItens.EnableControls;
    pCarregaItens(False, False, False);
  End;
end;

procedure TfrmCadLivroFiscal.pCarregaDocumentosAntecipacao;
begin
  FqryPgoFis.Close;
  FqryPgoFis.SQL.Clear;
  FqryPgoFis.SQL.Add(' SELECT        ');
  FqryPgoFis.SQL.Add(' PGF_SEQPAG,   ');
  FqryPgoFis.SQL.Add(' PGF_DUPORI,   ');
  FqryPgoFis.SQL.Add(' PGF_SERORI    ');
  FqryPgoFis.SQL.Add(' FROM PGOFIS   ');
  FqryPgoFis.SQL.Add(' WHERE PGF_SEQFIS = :AUTINC ');
  FqryPgoFis.ParamByName('AUTINC').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
  FqryPgoFis.Open;
end;


procedure TfrmCadLivroFiscal.pCarregaDocumentosAssociadosCTE;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  try
    cdsDocsCTE.DisableControls;
    cdsDocsCTE.LogChanges := False;
    try
      cdsDocsCTE.EmptyDataSet;
      With qryAux do
      Begin

        SQL.Add('SELECT * FROM ( ');

        SQL.Add('SELECT ');
        SQL.Add('GER_DTADOC, ');
        SQL.Add('GER_NUMDOC, ');
        SQL.Add('GER_ESPDOC, ');
        SQL.Add('GER_SERIE_, ');
        SQL.Add('"MOVGER" AS TABELA, ');
        SQL.Add('MOVGER.AUTOINCREM AS AUTOINCREM, ');
        SQL.Add('IF(GER_CLAFIS < "5000","ENTRADA","SAÍDA") GER_ENTSAI');
        SQL.Add('FROM RECTNF ');
        SQL.Add('INNER JOIN MOVGER ON MOVGER.AUTOINCREM = REC_MOVSEQ ');
        SQL.Add('WHERE REC_CTESEQ = :AUTOINCREMEN ');

        SQL.Add('UNION ALL ');

        SQL.Add('SELECT ');
        SQL.Add('GER_DTAENT AS GER_DTADOC, ');
        SQL.Add('GER_NUMDOC, ');
        SQL.Add('GER_ESPDOC, ');
        SQL.Add('GER_SERIE_, ');
        SQL.Add('"NOTGER" AS TABELA, ');
        SQL.Add('NOTGER.AUTOINCREM AS AUTOINCREM, ');
        SQL.Add('IF(GER_CLAFIS < "5000","ENTRADA","SAÍDA") GER_ENTSAI');
        SQL.Add('FROM RECTNF ');
        SQL.Add('INNER JOIN NOTGER ON NOTGER.AUTOINCREM = REC_NOTSEQ ');
        SQL.Add('WHERE REC_CTESEQ = :AUTOINCREMEN ');

        SQL.Add('UNION ALL ');

        SQL.Add('SELECT ');
        SQL.Add('GER_DTADOC, ');
        SQL.Add('GER_NUMDOC, ');
        SQL.Add('GER_ESPDOC, ');
        SQL.Add('GER_SERIE_, ');
        SQL.Add('"MOVGER" AS TABELA, ');
        SQL.Add('MOVGER.AUTOINCREM AS AUTOINCREM, ');
        SQL.Add('IF(GER_CLAFIS < "5000","ENTRADA","SAÍDA") GER_ENTSAI');
        SQL.Add('FROM CONFRE ');
        SQL.Add('INNER JOIN MOVGER ON MOVGER.AUTOINCREM = CON_SEQGER ');
        SQL.Add('WHERE CON_SEQFIS = :AUTOINCREMEN ) TMP ');

        SQL.Add('GROUP BY ');
        SQL.Add('TABELA, ');
        SQL.Add('AUTOINCREM, ');
        SQL.Add('GER_DTADOC, ');
        SQL.Add('GER_NUMDOC, ');
        SQL.Add('GER_ESPDOC, ');
        SQL.Add('GER_SERIE_ ');

        ParamByName('AUTOINCREMEN').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
        Open;

        While (Not Eof) Do
        Begin
          cdsDocsCTE.Append;
          cdsDocsCTE.FieldByName('GER_DTADOC').AsString := FieldByName('GER_DTADOC').AsString;
          cdsDocsCTE.FieldByName('GER_NUMDOC').AsString := FieldByName('GER_NUMDOC').AsString;
          cdsDocsCTE.FieldByName('GER_ESPDOC').AsString := FieldByName('GER_ESPDOC').AsString;
          cdsDocsCTE.FieldByName('GER_SERIE_').AsString := FieldByName('GER_SERIE_').AsString;
          cdsDocsCTE.FieldByName('GER_ENTSAI').AsString := FieldByName('GER_ENTSAI').AsString;
          cdsDocsCTE.FieldByName('TABELA').AsString := FieldByName('TABELA').AsString;
          cdsDocsCTE.FieldByName('AUTOINCREM').AsString := FieldByName('AUTOINCREM').AsString;

          cdsDocsCTE.Post;
          Next;
        End;
      End;
    finally
      cdsDocsCTE.LogChanges := True;
      cdsDocsCTE.EnableControls;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmCadLivroFiscal.btnExcluirClick(Sender: TObject);
var
  blnCtaBaixado,
  blnCtaPagar,
  blnCtaPagarAntecipado,
  blnCtaPagarComRetencaoImp,
  blnCtaPagarComRetencaoImpPago : Boolean;
  strForCli,
  strNumDoc,
  strCodEmp,
  strSerie : String;
  RegistroContabilidade: TrecRegistroContabilidade;
  str_Autoinc,
  str_EspDoc,
  str_ClaFis: String;
  stListaRetencao: String;
begin
  pEnabledFisAju;

  blnCtaPagar    := False;
  blnCtaBaixado  := False;

  pVerificaCtaPagar(blnCtaPagar, blnCtaBaixado, blnCtaPagarComRetencaoImp, blnCtaPagarComRetencaoImpPago, blnCtaPagarAntecipado, stListaRetencao);

  If blnCtaPagar Then
  Begin
    If blnCtaBaixado Then
    Begin
      fMensagem('AVISO', 'O Contas a Pagar referente a este registro foi baixado. Caso necessário faça o estorno do mesmo ' +
                'para conseguir excluir esse registro!', ['&Ok']);
      Exit;
    End
    Else
    Begin
      If fMensagem('AVISO', 'O Contas a Pagar referente a este registro também será apagado. ' +
                'Confirma esta operação?', ['&Sim','&Não']) = 2 Then
        Exit;
    End;

    If blnCtaPagarComRetencaoImpPago Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é permitido cancelar um documento com títulos já baixados!', ['&Ok']);
      Exit;
    End;

    If blnCtaPagarComRetencaoImp Then
    Begin
      fMensagem('ATENÇÃO!', 'Titulos do contas a pagar '+
                            'referente às retenções, também serão apagados!', ['&Ok']);
    End;

    If Not fDireitoAcesso Then
      Exit;
  End;

  If qryTabela.IsEmpty Then
  Begin
   fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
   Exit;
  End;

  If (Not fEmptyStr(dbeCodEmp.Text)) And (Not fValidaAcessoEmpresa) then
  Begin
    fMensagem('ATENÇÃO!', 'Usuário sem Permissão para a empresa escolhida!', ['&O k']);
    Exit;
  End;

  If (Not fNFServico(str_ClaFis)) And
     (Not qryFisItens.IsEmpty) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido excluir notas que tenham produtos.' + #13#10 +
      'Por favor, utilize o cancelamento.', ['&Ok']);
    Exit;
  End;

  If fVerificaCtpAgrupada Then
    Exit;

  If Not fValidaFechamentoFiscalEstoque Then
  Begin
    Exit;
  End;

  If fDocumentoComVinculoFiscal(qryTabela) Then
  Begin
    fMensagem('ATENÇÃO!', 'Este documento possui vínculo fiscal e, portanto, não pode ser excluído.', ['&OK']);
    Exit;
  End;

  pCarregaDocumentosAntecipacao;

  strForCli := qryTabela.FieldByName('FIS_FORCLI').AsString;
  strNumDoc := qryTabela.FieldByName('FIS_NUMDOC').AsString;
  strCodEmp := qryTabela.FieldByName('FIS_CODEMP').AsString;
  strSerie  := qryTabela.FieldByName('FIS_SERIE_').AsString;
  str_Autoinc := qryTabela.FieldByName('AUTOINCREM').AsString;
  str_EspDoc  := qryTabela.FieldByName('FIS_ESPDOC').AsString;
  str_ClaFis  := qryTabela.FieldByName('FIS_CLFSC1').AsString;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  Try
    // Aqui executa rotina que apaga o registro.
    inherited;

    RegistroContabilidade.ttpTabela := ttCadFis;
    RegistroContabilidade.strClafis := str_ClaFis;
    RegistroContabilidade.strEspDoc := str_EspDoc;
    RegistroContabilidade.strSeqGer := str_Autoinc;
    RegistroContabilidade.mlModLan := mlCancelamento;
    RegistroContabilidade.strEmpLan := strCodEmp;
    pGravaRegistroContabilidade(RegistroContabilidade);

    If blnExcluiu And (blnCtaPagar or blnCtaPagarAntecipado) Then
    Begin
      pApagaCtaPagar(strForCli, strNumDoc, strCodEmp, strSerie, str_EspDoc, str_Autoinc, stListaRetencao);
    End;

        If blnExcluiu and fNFServico(str_ClaFis) Then
          pApagaMovGer(strNumDoc, str_EspDoc, strCodEmp, strForCli, strSerie);

    fCommit;

    pCarregaDadosAdicionais;
    pHabilitaCamposGerais(qryFisItens.IsEmpty);
    pEnabledCodigoClasseConsumoEnergiaEletrica;
    pDesabilitaEditsNfComplementar;
    dbgItensDBTableViewCitel1.OnDblClick := nil;

    If blnExcluiu Then
      qryConsultarFinanceiro.fFechar;
  Finally
    blnStartTransactionNoPaiMasCommitRoolBackNoFilho := False;
  End

end;

procedure TfrmCadLivroFiscal.btnExcluirFisAjuClick(Sender: TObject);
  Var
    blnPodeExcluir: Boolean;
begin
  If qryFisAju.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If blnPerguntarParaExcluir Then
    blnPodeExcluir := fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1
  Else
    blnPodeExcluir := True;

  If blnPodeExcluir Then
  Begin
    Try
      fStartTransaction;

      qryFisAju.Delete;

      fCommit;

      edtDesAju.Text := '';
    Except
      On E: EUniError Do
      Begin
        If E.ErrorCode = ERROR_FOREIGN_KEY_DELETE Then
        Begin
          fRollBack;
          pGravarErro(True, '[ERROR_FOREIGN_KEY_DELETE] - Não é possível excluir esse registro',  E.Message + sLineBreak + fRetornaInformacaoUltimoErroForeignKey());
          fMensagem('ATENÇÃO!','Não é possível excluir esse registro, pois existe itens relacionados !',['&O K']);
        End
        Else
          pMensagensErro(IntToStr(E.ErrorCode) + ': ' + E.Message, ' [ Excluir registro ] ');
      End;

      On E: Exception Do
      Begin
        fRollBack;
        pMensagensErro(E.Message, 'Excluir registro');
      End;
    End;
  End;
end;

procedure TfrmCadLivroFiscal.btnExcluirNfComplementarClick(Sender: TObject);
begin
  qryTabela.FieldByName('FIS_ATNFCP').AsString := '';
  mskDataNfComplementar.Text := '';
  edtNumeroNfComplementar.Text := '';
  edtEspecieNfComplementar.Text := '';
  edtParticipanteNfComplementar.Text := '';
  edtNomPartNfComplementar.Text := '';
  edtSerieNfComplementar.Text := '';
end;

procedure TfrmCadLivroFiscal.dbeClfSc5KeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrCFOP: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    {*******************************}
    {* NOVA CONSULTA DE CFOP       *}
    {****************************RV*}
    If fPesqCFOP(Self, (Sender As TDBEditFocus), Nil, Nil, Key, arrCFOP, True, fFiltroCFOP) Then
    Begin
      If fValidaCampos((Sender As TDBEditFocus), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End
  Else If Not CharInSet(Key, ['0'..'9', #8, #9]) Then
    Key := #0;
end;

{*****************************************}
{* VERIFICA SE DETERMINADA CLASSIFICAÇÃO *}
{* ESTÁ CADASTRADA                       *}
{**************************************MV*}
function TfrmCadLivroFiscal.fVerificaCfopCorreta(strCfop: String): Boolean;
begin
  Result := True;

  Try
    pVerificaCfopCorreta(strCfop);
  Except
    On E: Exception Do
    Begin
      pMensagemOk(E.Message);
      Result := False;
    End;
  End;
end;

function TfrmCadLivroFiscal.fVerificaClaFis(strClaFis: String): Boolean;
  Var
    strSQL   : String;
    qryGenCfo: TUniQuery;

begin
  Try
    qryGenCfo := fCriaQuery(Self);

    Result := False;
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CFO_CODCFO ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADCFO ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CFO_CODCFO = :CODCFO ';

    With qryGenCfo Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCFO').AsString := strClaFis;
      Open;
      If Not IsEmpty Then
        Result := True;
      Close;
    End;

  Finally
    FreeAndNil(qryGenCfo);
  End;
end;

function TfrmCadLivroFiscal.fVerificaCtpAgrupada: Boolean;
Var
    lstCtpAgrupada: TStringList;
    frmCancelamentoDocResumo : TfrmCancelamentoDocResumo;
  function fVerificarCadPagAgrupado(strNumDoc, strEspDoc, strCliFor, strSerie, strCodEmp: String): TStringList;
  Var
    qryAux: TUniQuery;
  begin
    Result := TStringList.Create;
    qryAux := fCriaQuery(Self);
    Try
      qryAux.SQL.Add('SELECT ');
      qryAux.SQL.Add('  CTP_NUMAGR, ');
      qryAux.SQL.Add('  CTP_NUMDUP, ');
      qryAux.SQL.Add('  CTP_PARCEL, ');
      qryAux.SQL.Add('  CTP_VALDUP, ');
      qryAux.SQL.Add('  CTP_DTAVEN, ');
      qryAux.SQL.Add('  CTP_CODEMP, ');
      qryAux.SQL.Add('  CTP_CODFOR  ');
      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  DUPAGP ');
      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  CTP_NUMDUP = :NUMDUP AND ');
      qryAux.SQL.Add('  CTP_CODEMP = :CODEMP AND ');
      qryAux.SQL.Add('  CTP_CODFOR = :CODFOR AND ');

      If (fEmptyStr(strSerie)) Then
        qryAux.SQL.Add('  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) ')
      Else
        qryAux.SQL.Add('  CTP_SERIE_ = :SERIE ');

      qryAux.ParamByName('NUMDUP').AsString := strNumDoc;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ParamByName('CODFOR').AsString := strCliFor;


      If (Not fEmptyStr(strSerie)) Then
        qryAux.ParamByName('SERIE').AsString := strSerie;

      qryAux.Open;

      With qryAux Do
      While (Not qryAux.Eof) Do
      Begin
        Result.Add('Agrup: ' + fPadR(fieldbyname('CTP_NUMAGR').AsString,18,' ') +
                   'Duplic: ' + fPadR(fieldbyname('CTP_NUMDUP').AsString + '-' +
                                      fieldbyname('CTP_PARCEL').AsString + '-' +
                                      fieldbyname('CTP_CODEMP').AsString, 19,' ') +
                   'Venc: ' + fPadR(fieldbyname('CTP_DTAVEN').AsString,12,' ') +
                   'Valor: ' + FormatFloat('#,##0.00',fieldbyname('CTP_VALDUP').AsFloat));
        qryAux.Next;
      End;
    Finally
      FreeAndNil(qryAux);
    End;
  End;
begin

  Result := False;

  If (qryTabela.FieldByName('FIS_TIP_FC').AsString<>'F') Or
     (qryTabela.FieldByName('FIS_ENTSAI').AsString<>'E') Then
    Exit;

  lstCtpAgrupada := TStringList.Create;
  Try
    lstCtpAgrupada := fVerificarCadPagAgrupado(dbeNumDoc.Text, dbeEspDoc.Text, dbeForCli.Text, dbeNfComp.Text, dbeCodEmp.Text);

    If (lstCtpAgrupada.Count > 0) then
    Begin
      Result:= True;
      Try
        pCriarFormularios(TfrmCancelamentoDocResumo, frmCancelamentoDocResumo);

        Try
          frmCancelamentoDocResumo.memResumo.Text := 'Há duplicatas agrupadas, não será permitido fazer a exclusão do documento!' + #13#10 + #13#10 +
                                                     lstCtpAgrupada.Text;

          frmCancelamentoDocResumo.memResumo.Lines.Add('');
          frmCancelamentoDocResumo.memResumo.Lines.Add('');

          frmCancelamentoDocResumo.ShowModal;
        Finally
          pFreeAndNil(frmCancelamentoDocResumo);
        End;

      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[TfrmCadLivroFiscal.fVerificaCtpAgrupada]');
        End;
      End;
    end;
  Finally
    FreeAndNil(lstCtpAgrupada);
  End;
end;

function TfrmCadLivroFiscal.fVerificaExiste(strNovoVal,
  strCampo: String): Boolean;
  Var qryAux: TUniQuery;
Begin
  Try
    Result := False;

    If strNovoVal = qryTabela.FieldByName('FIS_' + strCampo).AsString Then
    Begin
      Result := True;
      Exit;
    End;

    qryAux := fCriaQuery(Nil);
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Text := 'SELECT '+
                       '  FIS_NUMDOC '+
                       'FROM '+
                       '  CADFIS '+
                       'WHERE '+
                       'FIS_NUMDOC = :NUMDOC AND '+
                       'FIS_ESPDOC = :ESPDOC AND '+
                       'FIS_CODEMP = :CODEMP AND '+
                       'FIS_FORCLI = :FORCLI AND '+
                       'FIS_TIP_FC = :TIP_FC AND '+
                       'IFNULL(FIS_SERIE_,"") = :SERIE_ ';
    qryAux.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    qryAux.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
    qryAux.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
    qryAux.ParamByName(strCampo).AsString := strNovoVal;

    If strCampo = 'SERIE_' Then
    Begin
      qryAux.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
      qryAux.ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
    End
    Else If strCampo = 'FORCLI' Then
    Begin
      qryAux.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
      qryAux.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
    End
    Else If strCampo = 'ESPDOC' Then
    Begin
      qryAux.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
      qryAux.ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
    End;
    qryAux.Open;

    If qryAux.RecordCount = 0 Then
      Result := True;

  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmCadLivroFiscal.fVerificaTotalImpostos: Boolean;
  Var
    fltSomaImpostos, fltNovoValorContabil: Double;
    fltReformaItem: Double;
    strReformaMsg: String;
    fltFatDesAce: Double;
    fltFatTotFre: Double;
    strTipoDif: String;
begin
  Result := True;

  If LeftStr(qryFisItensCLAFIS.AsString, 1) = '3' Then
    Exit;

  fltReformaItem := fValorReformaItemLivro;
  strReformaMsg  := IIF(fSomarNovosImpostosDaReformaAoValorContabil, ' + Vr. CBS + Vr. IBS + Vr. IS', '');

  If qryFisItensDESACE.AsFloat > 0 Then
    fltFatDesAce := fStrToFloat(dbeDesAce.Text) / qryFisItensDESACE.AsFloat
  Else
    fltFatDesAce := 0;

  If qryFisItensVALFRE.AsFloat > 0 Then
    fltFatTotFre := fStrToFloat(dbeValFre.Text) / qryFisItensVALFRE.AsFloat
  Else
    fltFatTotFre := 0;

  fltSomaImpostos := fStrToFloat(dbeBasIcm.Text) +
                     fStrToFloat(dbeValIpi.Text) +
                     fStrToFloat(dbeValRet.Text) +
                     fStrToFloat(dbeOutras.Text) +
                     fStrToFloat(dbeIsenta.Text) +
                     IIf(fSomaImpostosNaoCreditados,
                         fStrToFloat(dbeVaeIpi.Text) +
                         fStrToFloat(dbeVRetNC.Text), 0) +
                     fStrToFloat(edtVFCPST.Text) +
                     fltReformaItem;
  fltNovoValorContabil := fFormataFloat(qryFisItens.FieldByName('TOTITE').AsFloat -
                                        IIf(qryFisItens.FieldByName('AUX_DESINC').AsString = 'N', qryFisItens.FieldByName('DESESP').AsFloat, 0), 2) +
                          fStrToFloat(dbeValIpi.Text) +
                          fStrToFloat(dbeValRet.Text) +
                          fFormataFloat(qryFisItensTOTFRE_ITE.AsFloat * fltFatTotFre, 2) +
                          fFormataFloat(qryFisItensDESACE_ITE.AsFloat * fltFatDesAce, 2) +
                          fStrTofloat(dbeVaeIpi.Text) +
                          fStrToFloat(dbeVRetNC.Text) +
                          fStrToFloat(edtVFCPST.Text) +
                          fltReformaItem;

  If fEmptyStr(qryTabela.FieldByName('FIS_ORIDOC').AsString) And (Pos(dbeClaFis.Text, '1910_2910') > 0) And
     SameValue(fStrToFloat(dbeBasIcm.Text) / 2 +
               fStrToFloat(dbeValIpi.Text) +
               fStrToFloat(dbeValRet.Text) +
               fStrToFloat(dbeOutras.Text) +
               fStrToFloat(dbeIsenta.Text) +
               fStrToFloat(edtVFCPST.Text) + fltReformaItem, qryFisItensVLRCON_ITE.AsFloat, 0.005) Then

  Begin
    Result := True;
  End

  Else If (fEmptyStr(qryTabela.FieldByName('FIS_ORIDOC').AsString) Or (qryTabela.FieldByName('FIS_ORIDOC').AsString = 'D')) And
     SameValue(fStrToFloat(dbeBasIcm.Text) +
               fStrToFloat(dbeValRet.Text) +
               fStrToFloat(dbeOutras.Text) +
               fStrToFloat(dbeIsenta.Text) +
               fStrToFloat(edtVFCPST.Text) + fltReformaItem, qryFisItensVLRCON_ITE.AsFloat, 0.005) Then

  Begin
    Result := True;
  End

  Else If fConsideraICMSDesoneradoComDesconto(strEstEmp) And
          (fEmptyStr(qryTabela.FieldByName('FIS_ORIDOC').AsString) Or (qryTabela.FieldByName('FIS_ORIDOC').AsString = 'D')) And
     SameValue(fStrToFloat(dbeBasIcm.Text) -
               qryFisItensDESESP.AsFloat +
               fStrToFloat(dbeValIpi.Text) +
               fStrToFloat(dbeValRet.Text) +
               fStrToFloat(dbeOutras.Text) +
               fStrToFloat(dbeIsenta.Text) -
               fStrToFloat(edtVFCPST.Text) + fltReformaItem, qryFisItensVLRCON_ITE.AsFloat, 0.005) Then
  Begin
    Result := True;
  End

  Else If  Not SameValue(fltSomaImpostos, qryFisItensVLRCON_ITE.AsFloat, 0.005) Then
  Begin
    strTipoDif := IIF(fltSomaImpostos > qryFisItensVLRCON_ITE.AsFloat, 'a mais', 'a menos');

    pCriarFormularios(TfrmMsgValidacaoContabil, frmMsgValidacaoContabil);
    frmMsgValidacaoContabil.mmoMsg.Clear;
    frmMsgValidacaoContabil.blnEntMercadorias := False;
    frmMsgValidacaoContabil.mmoMsg.Lines.Add('');
    frmMsgValidacaoContabil.mmoMsg.Lines.Add('    O valor de Outras ou Isentas está inconsistente com relação aos impostos.');
    frmMsgValidacaoContabil.mmoMsg.Lines.Add('    Diferença: ' + FloatToStrF(Abs(fltSomaImpostos - qryFisItensVLRCON_ITE.AsFloat), ffNumber, 12, 2) + ' ' + strTipoDif + '.');

    frmMsgValidacaoContabil.mmoMsg.Lines.Add('    Os valores digitados devem seguir uma das seguintes regras:');
    frmMsgValidacaoContabil.mmoMsg.Lines.Add('    1) Vr.contabil = Base ICMS + Vr. IPI + Vr. ICMS ST + Vr. OUTRAS + Vr. ISENTAS + Vr. Desp. Ace + Vr. Frete + Vr. Ret. Não Creditado + Vr. IPI. Não Creditado + Vr. FCP ST' + strReformaMsg + ':');
    frmMsgValidacaoContabil.mmoMsg.Lines.Add('    2) Vr.contabil = Base ICMS + Vr. ICMS ST + Vr. OUTRAS + Vr. ISENTAS + Vr. Desp. Ace + Vr. Frete + Vr. Ret. Não Creditado + Vr. IPI. Não Creditado + Vr. FCP ST' + strReformaMsg + ':');
    frmMsgValidacaoContabil.mmoMsg.Lines.Add('');
    frmMsgValidacaoContabil.mmoMsg.Lines.Add('    No caso de Classificações de Bonificação (1910/2910) também é válido:');
    frmMsgValidacaoContabil.mmoMsg.Lines.Add('    3) Vr.contabil = Base ICMS / 2 + Vr. IPI + Vr. ICMS ST + Vr. OUTRAS + Vr. ISENTAS + Vr. Desp. Ace + Vr. Frete + Vr. FCP ST' + strReformaMsg + ':');
    frmMsgValidacaoContabil.mmoMsg.Lines.Add('');

    If fConsideraICMSDesoneradoComDesconto(strEstEmp) Then
      frmMsgValidacaoContabil.mmoMsg.Lines.Add('  4) Vr.contabil = Base ICMS - Valor Desconto + Vr. IPI + Vr. ICMS ST + Vr. OUTRAS + Vr. ISENTAS - Vr. FCP ST' + strReformaMsg + ':');

    frmMsgValidacaoContabil.ShowModal;
    FreeAndNil(frmMsgValidacaoContabil);

    Result := False;
  End;

  If Not SameValue(fltNovoValorContabil, qryFisItens.FieldByName('VLRCON_ITE').AsFloat, 0.005) Then
  Begin
    pMensagemOk('O valor contábil gravado (' + FloatToStrF(Abs(qryFisItens.FieldByName('VLRCON_ITE').AsFloat), ffNumber, 12, 2) + '), está '
                 + 'diferente do valor contábil calculado (' + FloatToStrF(Abs(fltNovoValorContabil), ffNumber, 12, 2) + ')' +
                 ' Vr.Calculado = Total do produto - desconto + Vr. IPI + Vr.IPI N Cred + Vr. ICMS ST + Vr. ICMS ST N Cred + Vr. Frete + Desp. Ace' + strReformaMsg);

    Result := False;
  End;
end;

procedure TfrmCadLivroFiscal.grdChaveRefDBTableViewEditKeyPress(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
begin
  inherited;
  Key := #0;
end;

procedure TfrmCadLivroFiscal.grdImpostosRET_ALIQUOGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
Var
  strTipo: String;
begin
  inherited;
  strTipo := VarToStr(fraCadImpostosNFS.grdImpostosTableView1.ViewData.Records[ARecordIndex].Values[fraCadImpostosNFS.grdImpostosRET_TIPRET.Index]);
  AText := FormatFloat('#,##0.00', fStrToFloat(AText));
  If strTipo = '5' Then
    AText := FormatFloat('#,##0.0000', fStrToFloat(AText));
end;

{procedure TfrmCadLivroFiscal.grdImpostosTableView1EditValueChanged(
  Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem);
  Var
    strNomCampo : String;
    fltValRetAnt: Double;
    fltCalcRet: Double;

  procedure pAjustarValoresRetencoes; begin
    pAjustarCamposRetencoesLivFis(
      IIF(cdsForRet.FieldByName('RET_TIPRET').AsInteger = 0,
          qryTabela.FieldByName('FIS_VREPIS').AsFloat -
            (fltValRetAnt - cdsForRet.FieldByName('VALRET').AsFloat),
          qryTabela.FieldByName('FIS_VREPIS').AsFloat),

      IIF(cdsForRet.FieldByName('FIS_VRECOF').AsInteger = 1,
          qryTabela.FieldByName('FIS_TOTCOF').AsFloat -
            (fltValRetAnt - cdsForRet.FieldByName('VALRET').AsFloat),
          qryTabela.FieldByName('FIS_VRECOF').AsFloat),

      IIF(cdsForRet.FieldByName('RET_TIPRET').AsInteger = 2,
          IIf(cdsForRet.FieldByName('VALRET').AsFloat = 0 , 0 ,
          qryTabela.FieldByName('FIS_RECSSL').AsFloat - (fltValRetAnt - cdsForRet.FieldByName('VALRET').AsFloat)),
          qryTabela.FieldByName('FIS_RECSSL').AsFloat),

      IIF(cdsForRet.FieldByName('RET_TIPRET').AsInteger = 3,
          IIf(cdsForRet.FieldByName('VALRET').AsFloat = 0 , 0 ,
          qryTabela.FieldByName('FIS_REIRRF').AsFloat - (fltValRetAnt - cdsForRet.FieldByName('VALRET').AsFloat)),
          qryTabela.FieldByName('FIS_REIRRF').AsFloat),

      IIF(cdsForRet.FieldByName('RET_TIPRET').AsInteger = 4,
          IIf(cdsForRet.FieldByName('VALRET').AsFloat = 0 , 0 ,
          qryTabela.FieldByName('FIS_REINSS').AsFloat - (fltValRetAnt - cdsForRet.FieldByName('VALRET').AsFloat)),
          qryTabela.FieldByName('FIS_REINSS').AsFloat),

      IIF(cdsForRet.FieldByName('RET_TIPRET').AsInteger = 5,
         IIf(cdsForRet.FieldByName('VALRET').AsFloat = 0 , 0 ,
          qryTabela.FieldByName('FIS_RETISS').AsFloat - (fltValRetAnt - cdsForRet.FieldByName('VALRET').AsFloat)),
          qryTabela.FieldByName('FIS_RETISS').AsFloat)
      );
  end;
begin
  inherited;

  fltValRetAnt := cdsForRet.FieldByName('VALRET').AsFloat;

  If (cdsForRet.State = dsEdit) Then cdsForRet.Post();

  strNomCampo := (AItem as TcxGridDBColumn).DataBinding.FieldName;

  If (strNomCampo = 'RET_ALIQUO') Or (strNomCampo = 'VALRET') Then Begin
    cdsForRet.Edit();

    If (strNomCampo = 'RET_ALIQUO') Then //mudou aliquota, calcula retenção
      cdsForRet.FieldByName('VALRET').AsFloat := qryTabela.FieldByName('FIS_VLCON1').AsFloat *
        (cdsForRet.FieldByName('RET_ALIQUO').AsFloat / 100)
    Else If (strNomCampo = 'VALRET') Then  ////mudou retenção, calcula aliquota
      cdsForRet.FieldByName('RET_ALIQUO').AsFloat := cdsForRet.FieldByName('VALRET').AsFloat /
        qryTabela.FieldByName('FIS_VLCON1').AsFloat * 100;

    fltCalcRet := cdsForRet.FieldByName('VALRET').AsFloat;

    If cdsForRet.FieldByName('RET_TIPRET').AsInteger In [0, 1, 2,3] Then
    Begin
     If (fStrToFloat(edtTotDoc.Text) < fltMinDocRet) Or
       (fltCalcRet < fltMinRet) Then
      fltCalcRet := 0;
    End;

    cdsForRet.FieldByName('VALRET').AsFloat := fltCalcRet;

    pAjustarValoresRetencoes();

    cdsForRet.Post();
  End;
end;
}

procedure TfrmCadLivroFiscal.grdImpostosVALRETGetDataText(
  Sender: TcxCustomGridTableItem; ARecordIndex: Integer; var AText: string);
begin
  inherited;

  AText := FormatFloat('#,##0.00', fStrToFloat(AText));
end;

function TfrmCadLivroFiscal.dbeClfSc1ChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadCfo(Key);
//  pAtribuiTabelas;
end;

procedure TfrmCadLivroFiscal.dbeClfSc1Change(Sender: TObject);
begin
  inherited;
  fraCadImpostosNFS.strClaFis := dbeClfSc1.Text;
  fraCadImpostosNFS.strEspDoc := dbeEspDoc.Text;
  fraCadImpostosNFS.pCarregarRetencoes;
end;

procedure TfrmCadLivroFiscal.dbeClfSc1Exit(Sender: TObject);
begin
  inherited;
  pManipulaCampoCodigoVerificador;
  pManipulaCampoCodigoTipoServico;
  If fRegraPisCofins Then
    pCarregaPisCofins(qryTabela.FieldByName('FIS_CLFSC1').AsString, qryTabela.FieldByName('FIS_CSTPIS').AsString, qryTabela.FieldByName('FIS_CSTCOF').AsString);

  pCalculaTotais;

  If qryFisItens.IsEmpty Then
  Begin
    dbeNatCfo.Text := dbeClfSc1.Text;
    pCarregaNatOperacao(cmbNatOpe, dbeNatCfo.Text);
  End;

end;

procedure TfrmCadLivroFiscal.pAfterOpen(DataSet: TDataSet);
  Var intCont: Integer;
begin
  With DataSet Do
  Begin
    For intCont := 1 To 5 Do
    Begin
      TFloatField(FieldByName('FIS_VLCON' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_BASIC' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_ALQIC' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_VLRIC' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_OUTRA' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_ISENT' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_RETID' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_BASIP' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_VLRIP' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_BCRET' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_DACES' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_BASAN' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_ANTIC' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_BAERE' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_VAERE' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_BAEIP' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_VAEIP' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_BFCPS' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_VFCPS' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_BAFCP' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_VLFCP' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_QBCMO' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_ADREM' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      TFloatField(FieldByName('FIS_VALMO' + IntToStr(intCont))).DisplayFormat := '#,##0.00';
      Application.ProcessMessages;
    End;

    TFloatField(FieldByName('FIS_TOTPIS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIS_TOTCOF')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIS_BASPIS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIS_BASCOF')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIS_ALQPIS')).DisplayFormat := '#,##0.0000';
    TFloatField(FieldByName('FIS_ALQCOF')).DisplayFormat := '#,##0.0000';
    TFloatField(FieldByName('FIS_BASISS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIS_ALQISS')).DisplayFormat := fDisplayFormatUsandoCampo('CADFIS','FIS_ALQISS');
    TFloatField(FieldByName('FIS_VALISS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIS_RETISS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIS_REIRRF')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIS_RECSSL')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIS_REINSS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIS_PERACU')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIS_VREPIS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIS_VRECOF')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIS_RFRBAS')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIS_RFRALQ')).DisplayFormat := '#,##0.00';
    TFloatField(FieldByName('FIS_RFRVAL')).DisplayFormat := '#,##0.00';
    TDateField(FieldByName('FIS_DTAENT')).EditMask := '99/99/9999';
    TDateField(FieldByName('FIS_DTADOC')).EditMask := '99/99/9999';

    FieldbyName('AUTOINCREM').Visible := False;
  End;

  pSincronizarAuxFis;
end;

{procedure TfrmCadLivroFiscal.pAjustaCamposRetencoesGrid(Sender: TDbEditFocus);
var blnEncontrou: Boolean;
    fltCalcRet: Double;
begin
  if not cdsForRet.Active then
    Exit;

  cdsForRet.First;
  blnEncontrou := False;
  // Localiza a linha no grid para manipular
  while not cdsForRet.Eof Do
  Begin
    If (Sender = dbeReCSSL) And (cdsForRet.FieldByName('RET_TIPRET').AsInteger = 2) Then
      blnEncontrou := True

    Else If (Sender = dbeReIRRF) And (cdsForRet.FieldByName('RET_TIPRET').AsInteger = 3) Then
      blnEncontrou := True

    Else If (Sender = dbeReINSS) And (cdsForRet.FieldByName('RET_TIPRET').AsInteger = 4) Then
      blnEncontrou := True


    Else If (Sender = dbeRetISS) And (cdsForRet.FieldByName('RET_TIPRET').AsInteger = 5) Then
      blnEncontrou := True;

    If blnEncontrou Then
      Break;

    cdsForRet.Next;
  End;

  If not blnEncontrou Then
    exit;

  cdsForRet.Edit;
  If (Sender = dbeReCSSL) Or (Sender = dbeReIRRF) Then
  Begin
    fltCalcRet := fStrToFloat(Sender.Text);
    If (fStrToFloat(edtTotDoc.Text) < fltMinDocRet) Or (fltCalcRet < fltMinRet) Then
        fltCalcRet := 0;
    cdsForRet.FieldByName('VALRET').AsFloat := fltCalcRet;
    If fltCalcRet > 0 Then
      cdsForRet.FieldByName('RET_ALIQUO').AsFloat := cdsForRet.FieldByName('VALRET').AsFloat / qryTabela.FieldByName('FIS_VLCON1').AsFloat * 100
    Else
      Sender.Field.Value := 0
  End;
  If (Sender = dbeReINSS) Or (Sender = dbeRetISS) Then
  Begin
    cdsForRet.FieldByName('VALRET').AsString := Sender.Field.Value;
    cdsForRet.FieldByName('RET_ALIQUO').AsFloat := cdsForRet.FieldByName('VALRET').AsFloat / qryTabela.FieldByName('FIS_VLCON1').AsFloat * 100;
  End
end;
}
{procedure TfrmCadLivroFiscal.pAjustarCamposRetencoesLivFis(fltRetPis, fltRetCofins,
  fltRetCsll, fltRetIrrf, fltRetInss, fltRetIss: Double);
begin
  If (cdsForRet.State = dsBrowse) Then Exit;

  //PIS
  If fltRetPis > 0 Then
  Begin
    qryTabela.FieldByName('FIS_VREPIS').AsFloat := fltRetPis;
  End;

  //COFINS
  If fltRetCofins > 0 Then
  Begin
    qryTabela.FieldByName('FIS_VRECOF').AsFloat := fltRetCofins;
  End;

  //CSLL
  qryTabela.FieldByName('FIS_RECSSL').AsFloat := fltRetCsll;

  //IRRF
  qryTabela.FieldByName('FIS_REIRRF').AsFloat := fltRetIrrf;

  //INSS
  qryTabela.FieldByName('FIS_REINSS').AsFloat := fltRetInss;

  //ISS
  qryTabela.FieldByName('FIS_RETISS').AsFloat := fltRetIss;
end;
}

procedure TfrmCadLivroFiscal.pAtivaCampoCst;
begin
  If (dbeEntSai.Text = 'E') And (dbeNfComple.Text = 'S') Then
  Begin
    dbeNfCstEnt.Visible := True;
    label5.Visible := True;
  End
  Else
  Begin
    dbeNfCstEnt.Text := '';
    dbeNfCstEnt.Visible := False;
    label5.Visible := False;
  End;
end;

procedure TfrmCadLivroFiscal.pAtribuiTabelas;
begin

  qryConCid := fCriaQuery(Self);
  qryCidEmp := fCriaQuery(Self);
  qryConCfo := fCriaQuery(Self);
  qryDomAcu := fCriaQuery(Self);
  qryCadEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryCadFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryCadCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);

end;

procedure TfrmCadLivroFiscal.dbeBasPisExit(Sender: TObject);
begin
  inherited;
  If (dbeBasPis.Field.Value > 0) And (fltOldBasPis <> fStrToFloat(dbeBasPis.Text)) Then
    blnAlterouPisCofins:= False; //para forcar recalcular o valor total.
  fValidaCampos(dbeBasPis, True);
end;

procedure TfrmCadLivroFiscal.dbeBasCofExit(Sender: TObject);
begin
  inherited;
  If (dbeBasCof.Field.Value > 0) And (fltOldBasCof <> fStrToFloat(dbeBasCof.Text)) Then
    blnAlterouPisCofins:= False; //para forcar recalcular o valor total.
  fValidaCampos(dbeBasCof, True);
end;

procedure TfrmCadLivroFiscal.dbeBasFreKeyPress(Sender: TObject; var Key: Char);
Var
  arrBaseFrete: TConsultasArray;
begin
  inherited;
  If fPesqCodBaseFrete(Self, dbeBasFre, Nil, Nil, Key, arrBaseFrete) Then
  Begin
    fValidaCampos(dbeBasFre);
  End;
end;

procedure TfrmCadLivroFiscal.dbeBasIc1Exit(Sender: TObject);
begin
  inherited;
  pValorOutras;
  pCalculaTotais;
end;

procedure TfrmCadLivroFiscal.dbeAlqIc1Enter(Sender: TObject);
begin
  inherited;
  arrAliICM[1] := fStrToFloat(dbeAlqIc1.Text);
end;

procedure TfrmCadLivroFiscal.dbeAlqIc2Enter(Sender: TObject);
begin
  inherited;
  arrAliICM[2] := fStrToFloat(dbeAlqIc2.Text);
end;

procedure TfrmCadLivroFiscal.dbeAlqIc3Enter(Sender: TObject);
begin
  inherited;
  arrAliICM[3] := fStrToFloat(dbeAlqIc3.Text);
end;

procedure TfrmCadLivroFiscal.dbeAlqIc4Enter(Sender: TObject);
begin
  inherited;
  arrAliICM[4] := fStrToFloat(dbeAlqIc4.Text);
end;

procedure TfrmCadLivroFiscal.dbeAlqIc5Enter(Sender: TObject);
begin
  inherited;
  arrAliICM[5] := fStrToFloat(dbeAlqIc5.Text);
end;

procedure TfrmCadLivroFiscal.dbeAlqIc5Exit(Sender: TObject);
begin
  inherited;
  pCalculaTotais;
end;

procedure TfrmCadLivroFiscal.dbeAlqIssExit(Sender: TObject);
begin
end;

{****************************************************}
{* PROCEDURE QUE CARREGA OS ITENS DO DOCUMENTO SE-  *}
{* LECIONADO PARA MOSTRAR NO DETALHAMENTO DOS ITENS *}
{** 08/05/2008 - 14:34 ***************************ER*}
procedure TfrmCadLivroFiscal.pCarregaItens(blnApenasDesabilitaCampos: Boolean = False; blnLimpaCampos: Boolean = False; blnAlterarNatOpeCapa: Boolean = True);
  procedure pClear(arrEdit: Array Of TCustomEdit);

    Var
      intEdit: Integer;
  begin
    For intEdit := 0 To Length(arrEdit) -1 Do
      arrEdit[intEdit].Clear;
  end;
begin
  If blnLimpaCampos Then
    pClear([dbeCodFis, dbeClaFis, dbeBasIcm, dbeAlqIcm, dbeValIcm, dbeValFre, dbeValFreItens, dbeDesAce, dbeBasIPI,
            dbeAlqIPI, dbeValipi, dbeBaeIPI, dbeAleIPI, dbeVaeipi, dbeValRet, dbeBasRet, dbeValAnt,
            dbeBasAnt, dbeOutras, dbeIsenta, edtIteCstPis, edtIteBasPis, edtIteAlqPis, edtIteValPis,
            edtIteNatRecPis, edtIteCstCof,  edtIteBasCof, edtIteAlqCof, edtIteValCof, edtIteNatRecCof,
            dbeVRetNC, dbeBRetNC, edtBaseUFDest, edtPercFCP, edtValorFCP,
            edtAlqInterna, edtAlqInterestadual, edtPercentualPartilha, edtICMSOrigem, edtICMSDestino, dbeVICMDE,
            edtBaseStCat158, edtValorStCat158, edtBaseIcmCat158, edtAlqIcmCat158, edtValorIcmCat158, dbeNatCfo, dbeCSTIPI, dbeNcmIte,
            edtQBCMonoRet, edtAdRemICMDRet, edtVICMSMonoRet, edtBaseCbs, edtValorCbs, edtBaseIBS, edtValorIBS, edtBaseIS, edtValorIS]);

  {***************************}
  {* DESABILITA COMPONENTES  *}
  {** 12/05/2008 - 13:56 **ER*}
  dbeCodFis.Enabled    := False;
  dbeClaFis.Enabled    := False;
  dbeBasIcm.Enabled    := False;
  dbeAlqIcm.Enabled    := False;
  dbeValIcm.Enabled    := False;
  dbeValFre.Enabled    := False;
  dbeValFreItens.Enabled    := False;
  dbeDesAce.Enabled    := False;
  dbeBasIPI.Enabled    := False;
  dbeAlqIPI.Enabled    := False;
  dbeValipi.Enabled    := False;
  dbeBaeIPI.Enabled    := False;
  dbeAleIPI.Enabled    := False;
  dbeVaeipi.Enabled    := False;
  dbeValRet.Enabled    := False;
  edtBaseCbs.Enabled   := False;
  edtValorCbs.Enabled  := False;
  edtBaseIBS.Enabled   := False;
  edtValorIBS.Enabled  := False;
  edtBaseIS.Enabled    := False;
  edtValorIS.Enabled   := False;
  gpbReforma.Visible   := fSomarNovosImpostosDaReformaAoValorContabil;
  dbeBasRet.Enabled    := False;
  dbeValAnt.Enabled    := False;
  dbeBasAnt.Enabled    := False;
  dbeOutras.Enabled    := False;
  dbeIsenta.Enabled    := False;
  dbeVICMDe.Enabled    := False;
  btnConfirmar.Enabled := False;
  dbeBRetNC.Enabled    := False;
  dbeVRetNC.Enabled    := False;
  dbeCSTIPI.Enabled    := False;
  dbeNcmIte.Enabled    := False;

  edtIteCstPis.Enabled := False;
  edtIteBasPis.Enabled := False;
  edtIteAlqPis.Enabled := False;
  edtIteValPis.Enabled := False;
  edtIteNatRecPis.Enabled := False;

  edtIteCstCof.Enabled := False;
  edtIteBasCof.Enabled := False;
  edtIteAlqCof.Enabled := False;
  edtIteValCof.Enabled := False;
  edtIteNatRecCof.Enabled := False;

  edtBaseUFDest.Enabled := False;
  edtBaseFCP.Enabled := False;
  edtPercFCP.Enabled := False;
  edtValorFCP.Enabled := False;
  edtAlqInterna.Enabled := False;
  edtAlqInterestadual.Enabled := False;
  edtPercentualPartilha.Enabled := False;
  edtICMSOrigem.Enabled := False;
  edtICMSDestino.Enabled := False;

  edtBaseStCat158.Enabled := False;
  edtValorStCat158.Enabled := False;
  edtBaseIcmCat158.Enabled := False;
  edtAlqIcmCat158.Enabled := False;
  edtValorIcmCat158.Enabled := False;
  edtQBCMonoRet.Enabled := False;
  edtAdRemICMDRet.Enabled := False;
  edtVICMSMonoRet.Enabled := False;

  cmbNatOpeItem.Enabled := False;
  cmbNatOpeItem.ItemIndex := cmbNatOpeItem.Items.IndexOf(qryFisItens.FieldByName('DET_NATOPE').AsString);

  lblRICMPR.Visible    := False;
  ckbReduzICMS.Visible := fCfgSis('RICMPR', varBoolean);

  If blnApenasDesabilitaCampos Then
    Exit;

  {*****************************************************}
  {* CARREGA ITENS REFERENTES AO DOCUMENTO SELECIONADO *}
  {** 12/05/2008 - 13:58 ****************************ER*}
  With qryFisItens Do
  Begin
    DisableControls;

    SQL.Clear;
    SQL.Add(' SET @NROITE = 0; ');
    SQL.Add(' SELECT  ');
    SQL.Add('   (@NROITE:=(@NROITE + 1))    AS NROITE, ');
    SQL.Add('   MOVDET.AUTOINCREM AS AUTOINCREM, ');
    SQL.Add('   DET_CODITE      AS CODITE, ');
    SQL.Add('   DET_DESCRI      AS DESCRI, ');
    SQL.Add('   DET_QTDITE      AS QTDITE, ');
    SQL.Add('   UNI_SIGUNI      AS UNIDAD, ');
    SQL.Add('   DET_UNITAR      AS UNITAR, ');
    SQL.Add('   DET_TOTITE      AS TOTITE, ');
    SQL.Add('   DET_CODEMP      AS CODEMP, ');
    SQL.Add('   DET_TOTITE+T.DET_VAEIPI+DET_VALIPI+DET_TOTFRE+DET_DESACE+ ');
    SQL.Add('   DET_VALRET-IF(A.AUX_DESINC = "S", 0, DET_DESESP)+T.DET_VAERET + IFNULL(T.DET_VFCPST,0) +  ');
    SQL.Add('   -- CALC_DOCIMP ');
    SQL.Add('   ' + fSqlReformaLivroTotal('MOVDET') + ' + ');

    SQL.Add('   0 AS VLRCON,');

    SQL.Add('   DET_CODFIS      AS CODFIS, ');
    SQL.Add('   DET_CLAFIS      AS CLAFIS, ');
    SQL.Add('   DET_BASICM      AS BASICM, ');
    SQL.Add('   DET_ALQICM      AS ALQICM, ');
    SQL.Add('   DET_VALICM      AS VALICM, ');
    SQL.Add('   DET_BASIPI      AS BASIPI, ');
    SQL.Add('   DET_ALQIPI      AS ALQIPI, ');
    SQL.Add('   DET_VALIPI      AS VALIPI, ');
    SQL.Add('   T.DET_CSTIPI    AS CSTIPI, ');
    SQL.Add('   T.DET_BAEIPI    AS BAEIPI, ');
    SQL.Add('   T.DET_ALEIPI    AS ALEIPI, ');
    SQL.Add('   T.DET_VAEIPI    AS VAEIPI, ');
    SQL.Add('   DET_VALRET      AS VALRET, ');
    SQL.Add('   DET_BASRET      AS BASRET, ');
    SQL.Add('   T.DET_VAERET    AS VAERET, ');
    SQL.Add('   T.DET_BAERET    AS BAERET, ');
    SQL.Add('   DET_ICMANT      AS VALANT, ');
    SQL.Add('   DET_BASANT      AS BASANT, ');
    SQL.Add('   TRI_DESC01      AS DESFIS, ');
    SQL.Add('   CFO_DESCR1      AS DESCLA, ');
    SQL.Add('   DET_TOTITE      AS VTOTAL, ');
    SQL.Add('   GER_TOTFRE      AS VALFRE, ');
    SQL.Add('   GER_DESACE      AS DESACE, ');
    SQL.Add('   T.DET_OUTICM    AS OUTICM, ');
    SQL.Add('   T.DET_ISEICM    AS ISEICM, ');
    SQL.Add('   T.DET_CSTPIS    AS CSTPIS, ');
    SQL.Add('   T.DET_BASPIS    AS BASPIS, ');
    SQL.Add('   T.DET_ALQPIS    AS ALQPIS, ');
    SQL.Add('   T.DET_VALPIS    AS VALPIS, ');
    SQL.Add('   T.DET_NR_PIS    AS NR_PIS, ');
    SQL.Add('   CAST(' + fSqlReformaLivro('MOVDET', 'REF_BASCAL') + ' AS DECIMAL(15,2)) AS BASCBS, ');
    SQL.Add('   CAST(' + fSqlReformaLivro('MOVDET', 'REF_CBSVAL') + ' AS DECIMAL(15,2)) AS VALCBS, ');
    SQL.Add('   CAST(' + fSqlReformaLivro('MOVDET', 'REF_BASCAL') + ' AS DECIMAL(15,2)) AS BASIBS, ');
    SQL.Add('   CAST(' + fSqlReformaLivro('MOVDET', 'REF_VALIBS') + ' AS DECIMAL(15,2)) AS VALIBS, ');
    SQL.Add('   CAST(' + fSqlReformaLivro('MOVDET', 'REF_SELBAS') + ' AS DECIMAL(15,2)) AS BAS_IS, ');
    SQL.Add('   CAST(' + fSqlReformaLivro('MOVDET', 'REF_SELVAL') + ' AS DECIMAL(15,2)) AS VAL_IS, ');
    SQL.Add('   T.DET_CSTCOF    AS CSTCOF, ');
    SQL.Add('   T.DET_BASCOF    AS BASCOF, ');
    SQL.Add('   T.DET_ALQCOF    AS ALQCOF, ');
    SQL.Add('   T.DET_VALCOF    AS VALCOF, ');
    SQL.Add('   T.DET_NR_COF    AS NR_COF, ');
    SQL.Add('   T.DET_RICMPR    AS RICMPR, ');
    SQL.Add('   T.DET_NCMITE    AS NCMITE, ');
    SQL.Add('   IFNULL(DET_PERRED, '+fFloatToSQL(CONST_PERCENTUAL_DIFERIMENTO_RICMS)+') AS PERRED, ');
    SQL.Add('   DET_DESESP      AS DESESP, ');
    SQL.Add('   DET_DESACE      AS DESACE_ITE, ');
    SQL.Add('   DET_TOTFRE      AS TOTFRE_ITE, ');
    SQL.Add('   DET_VLRCON      AS VLRCON_ITE, ');
    SQL.Add('   T.DET_NATOPE, ');
    SQL.Add('   IFNULL(A.AUX_DESINC, "N") AS AUX_DESINC , ');
    SQL.Add('   A.AUX_OPCDOC AS OPCDOC , ');
    SQL.Add('   N.NAT_CODCFO,  ');
    SQL.Add('   N.NAT_DESCRI,  ');
    SQL.Add('   CONCAT(ABF_CODABF, " - ", ABF_DESABF) AS DESABF, ');
    SQL.Add('   IF(IFNULL(ICD.ICD_BCUFDE,"") = "", "0", "1") AS ICD_TEMICD, ');
    SQL.Add('   IFNULL(A.AUX_VENPRE, "N")    AS AUX_VENPRE, ');
    SQL.Add('   IFNULL(ICD.ICD_BCUFDE, 0.00) AS ICD_BCUFDE, ');
    SQL.Add('   IFNULL(ICD.ICD_PERFCP, 0.00) AS ICD_PERFCP, ');
    SQL.Add('   IFNULL(ICD.ICD_ALQUFD, 0.00) AS ICD_ALQUFD, ');
    SQL.Add('   IFNULL(ICD.ICD_ALQINE, 0.00) AS ICD_ALQINE, ');
    SQL.Add('   IFNULL(ICD.ICD_PERPAR, 0.00) AS ICD_PERPAR, ');
    SQL.Add('   IFNULL(ICD.ICD_VALDES, 0.00) AS ICD_VALDES, ');
    SQL.Add('   IFNULL(ICD.ICD_VALORI, 0.00) AS ICD_VALORI, ');
    SQL.Add('   IF(T.DET_BFCPST = ICD.ICD_BASFCP, 0, IFNULL(ICD.ICD_BASFCP, 0.00)) AS ICD_BASFCP, ');
    SQL.Add('   IF(T.DET_BFCPST = ICD.ICD_BASFCP, 0, IFNULL(ICD.ICD_VALFCP, 0.00)) AS ICD_VALFCP, ');
    SQL.Add('   T.DET_VICMDE    AS VICMDE, ');
    SQL.Add('   T.DET_BCR158    AS BCR158, ');
    SQL.Add('   T.DET_VLR158    AS VLR158, ');
    SQL.Add('   T.DET_BCI158    AS BCI158, ');
    SQL.Add('   T.DET_ALI158    AS ALI158, ');
    SQL.Add('   T.DET_VLI158    AS VLI158, ');
    SQL.Add('   IFNULL(T.DET_BFCPST, 0.00) AS BFCPST, ');
    SQL.Add('   IFNULL(T.DET_PFCPST, 0.00) AS PFCPST, ');
    SQL.Add('   IFNULL(T.DET_VFCPST, 0.00) AS VFCPST, ');
    SQL.Add('   G.ITE_TIPPRO AS TIPPRO, ');

    SQL.Add('   @I02PROPD := (SELECT I02_CPROD FROM DETELE');
    SQL.Add('       INNER JOIN GERELE ON DETELE.DET_SEQGER = GERELE.AUTOINCREM');
    SQL.Add('       WHERE GERELE.GER_DOCENT = MOVGER.GER_NUMDOC');
    SQL.Add('         AND GERELE.GER_ESPENT = MOVGER.GER_ESPDOC');
    SQL.Add('         AND GERELE.GER_EMPENT = MOVGER.GER_CODEMP');
    SQL.Add('         AND GERELE.GER_CODFOR = MOVGER.GER_CODFOR');
    SQL.Add('         AND IFNULL(GERELE.B07_SERIE, "") = MOVGER.GER_SERIE_');
    SQL.Add('         and DETELE.DET_CODITE = MOVDET.DET_CODITE');
    SQL.Add('             LIMIT 1) AS I02PROPD,');
    SQL.Add('    CAST(IFNULL(@I02PROPD, "") AS CHAR(120) ) AS CODFAB, ');

    SQL.Add('   CD.CID_NOMCID   AS CIDADEENT , ');
    SQL.Add('   CD.CID_ESTADO   AS ESTADOENT , ');
    SQL.Add('   EC.ETC_CEPENT   AS CEPENT, ');

    SQL.Add('   CAST(CONCAT(I.ITE_CODMAR, "-", CM.MAR_DESMAR) AS CHAR(100)) AS DESMAR, ');
    SQL.Add('   I.ITE_CODFAB AS CODFAB2 ');
    SQL.Add('   ,DET_QBCMON ');
    SQL.Add('   ,DET_ADREMN ');
    SQL.Add('   ,DET_VALMON ');
    SQL.Add('   ,IFNULL(T.DET_VLGNRE, 0) AS DET_VLGNRE ');
    SQL.Add(' FROM     ');
    SQL.Add('   MOVDET ');
    SQL.Add('   INNER JOIN MOVGER   ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ');
    SQL.Add('   LEFT  JOIN CADTRI   ON   DET_CODFIS = TRI_CODTRI ');
    SQL.Add('   LEFT  JOIN CADUNI   ON   DET_UNIDAD = UNI_CODUNI');

    SQL.Add('   INNER JOIN CADCFO   ON   DET_CLAFIS = CFO_CODCFO ');
    SQL.Add('   LEFT  JOIN MOVTRI T ON T.DET_SEQGER = MOVDET.AUTOINCREM ');
    SQL.Add('   LEFT  JOIN MOVICD ICD ON ICD.ICD_SEQGER = MOVDET.AUTOINCREM ');
    SQL.add('   LEFT  JOIN AUXMOV A ON A.AUX_SEQGER = MOVGER.AUTOINCREM ');
    SQL.Add('   LEFT  JOIN ENTCLI EC ON A.AUX_ENTGER = EC.AUTOINCREM' );
    SQL.Add('   LEFT  JOIN CADCID CD ON EC.ETC_CIDENT = CD.CID_CODCID');
    SQL.Add('   LEFT  JOIN CADITE I ON I.ITE_CODITE = DET_CODITE ');
    SQL.Add('   LEFT JOIN DOCIMP ON IMP_SQMVDT = MOVDET.AUTOINCREM ');
    SQL.Add('   LEFT  JOIN ITEGER G ON G.ITE_CODITE = DET_CODITE AND ');
    SQL.Add('                          G.ITE_CODEMP = DET_CODEMP ');
    SQL.Add('   LEFT  JOIN NATCFO N ON N.AUTOINCREM = AUX_NATCFO ');
    SQL.Add('   LEFT  JOIN CADMAR CM ON CM.MAR_CODMAR = I.ITE_CODMAR ');

    If fCfgSis('TIPABF') = '1' Then
    Begin
      SQL.Add(' LEFT JOIN ABFICM ON ABF_CODABF = I.ITE_CODABF ');
    End
    Else
    Begin
      SQL.Add(' LEFT JOIN ABFICM ON ABF_CODABF = G.ITE_CODABF ');
    End;
    SQL.Add('  AND ABF_ESTADO = DET_ESTADO ');

    SQL.Add(' WHERE    ');
    SQL.Add('   DET_NUMDOC = :NUMDOC AND ');
    SQL.Add('   DET_CODEMP = :CODEMP AND ');
    SQL.Add('   DET_ESPDOC = :ESPDOC AND ');
    SQL.Add('   DET_TIP_FC = :TIP_FC AND ');
    SQL.Add('   IFNULL(DET_PROEMB, "") <> "S" AND ');
    SQL.Add('   IFNULL(DET_SERIE_, "") = :SERIE_ AND ');
    SQL.Add('   IFNULL(DET_ORIDOC, "") = :ORIDOC AND ');

    If SameText(qryTabela.FieldByName('FIS_TIP_FC').AsString, 'C') Then
      SQL.Add('   DET_CODCLI = :FORCLI ')
    Else
      SQL.Add('   DET_CODFOR = :FORCLI ');

    SQL.Add(' ORDER BY     ');
    SQL.Add('   MOVDET.AUTOINCREM ');

    ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
    ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
    ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
    ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
    ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
    ParamByName('ORIDOC').AsString := qryTabela.FieldByName('FIS_ORIDOC').AsString;

    Open;

    TFloatField(FieldByName('QTDITE')).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));

    {***************************************************}
    {* SE NÃO HOUVER NENHUM REGISTRO EM MOVDET, FAZ O  *}
    {* SELECT EM NOTDET                                *}
    {** 13/05/2008 - 11:08 **************************ER*}
    strTabela := 'MOVDET';
    If IsEmpty Then
    Begin
      Close;

      SQL.Text := AnsiReplaceStr(SQL.Text,  '-- CALC_DOCIMP',
        'IF(IFNULL(IMP_SQMVDT, "") = "", 0, IFNULL(DET_VALICM, 0) + IFNULL(IMP_PISPAS, 0) + IFNULL(IMP_COFINS, 0) + ' +
        ' IFNULL(DET_VALICM, 0) + IFNULL(IMP_VALIOF, 0) + IFNULL(IMP_DESADU, 0) + IFNULL(IMP_VAL_II, 0) + IFNULL(IMP_SISCOM, 0) + IFNULL(IMP_VAFRMM,0)) + ');

      SQL.Text := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(SQL.Text, 'MOVDET', 'NOTDET'),
        'MOVGER', 'NOTGER'), 'MOVTRI', 'NOTTRI'), 'MOVICD', 'NOTICD'), 'AUXMOV', 'AUXNOT'), 'IMP_SQMVDT', 'IMP_SEQDET');

      SQL.Text := AnsiReplaceStr(SQL.Text, 'MOVREF', 'NOTREF');

      strTabela := 'NOTDET';

      SQL.Text := AnsiReplaceStr(SQL.Text, 'T.DET_NATOPE,', '"" AS DET_NATOPE,');

      Open;
    End;

    If IsEmpty Then
    Begin
      Close;

      SQL.Clear;
      SQL.Add(' SET @NROITE = 0; ');
      SQL.Add('SELECT                                                 ');
      SQL.Add('   (@NROITE:=(@NROITE + 1))    AS NROITE, ');
      SQL.Add('  ITECOM.AUTOINCREM AS AUTOINCREM,                     ');
      SQL.Add('  ITC_CODITE AS CODITE,                                ');
      SQL.Add('  ITC_DESCRI AS DESCRI,                                ');
      SQL.Add('  DET_QTDITE AS QTDITE,                                ');
      SQL.Add('  UNI_SIGUNI AS UNIDAD,                                ');
      SQL.Add('  (ITC_VALCOM / DET_QTDITE) AS UNITAR,                 ');
      SQL.Add('  ITC_VALCOM AS TOTITE,                                ');
      SQL.Add('  DET_CODEMP AS CODEMP,                                ');
      SQL.Add('  (ITC_VALCOM + ITC_VALIPI + ITC_VALRET) AS VLRCON,    ');
      SQL.Add('  ITC_CODFIS AS CODFIS,                                ');
      SQL.Add('  ITC_CLAFIS AS CLAFIS,                                ');
      SQL.Add('  ITC_BASICM AS BASICM,                                ');
      SQL.Add('  ITC_ALQICM AS ALQICM,                                ');
      SQL.Add('  ITC_VALICM AS VALICM,                                ');
      SQL.Add('  ITC_BASIPI AS BASIPI,                                ');
      SQL.Add('  ITC_ALQIPI AS ALQIPI,                                ');
      SQL.Add('  ITC_VALIPI AS VALIPI,                                ');
      SQL.Add('  "" AS CSTIPI,                                        ');
      SQL.Add('  0.00 AS BAEIPI,                                      ');
      SQL.Add('  0.00 AS ALEIPI,                                      ');
      SQL.Add('  0.00 AS VAEIPI,                                      ');
      SQL.Add('  ITC_VALRET AS VALRET,                                ');
      SQL.Add('  ITC_BASRET AS BASRET,                                ');
      SQL.Add('  0.00 AS VAERET,                                      ');
      SQL.Add('  0.00 AS BAERET,                                      ');
      SQL.Add('  0.00 AS VALANT,                                      ');
      SQL.Add('  0.00 AS BASANT,                                      ');
      SQL.Add('  "" AS DESFIS,                                        ');
      SQL.Add('  CFO_DESCR1 AS DESCLA,                                ');
      SQL.Add('  ITC_VALCOM AS VTOTAL,                                ');
      SQL.Add('  0.00 AS VALFRE,                                      ');
      SQL.Add('  0.00 AS DESACE,                                      ');
      SQL.Add('  0.00 AS OUTICM,                                      ');
      SQL.Add('  0.00 AS ISEICM,                                      ');
      SQL.Add('  ITC_CSTPIS AS CSTPIS,                                ');
      SQL.Add('  ITC_BASPIS AS BASPIS,                                ');
      SQL.Add('  ITC_ALQPIS AS ALQPIS,                                ');
      SQL.Add('  ITC_VALPIS AS VALPIS,                                ');
      SQL.Add('  "" AS NR_PIS,                                        ');
      SQL.Add('  ITC_CSTCOF AS CSTCOF,                                ');
      SQL.Add('  ITC_BASCOF AS BASCOF,                                ');
      SQL.Add('  ITC_ALQCOF AS ALQCOF,                                ');
      SQL.Add('  ITC_VALCOF AS VALCOF,                                ');
      SQL.Add('  "" AS NR_COF,                                        ');
      SQL.Add('  "" AS RICMPR,                                        ');
      SQL.Add('  "" AS NCMITE,                                        ');
      SQL.Add('  IFNULL(DET_PERRED, '+fFloatToSQL(CONST_PERCENTUAL_DIFERIMENTO_RICMS)+') AS PERRED, ');
      SQL.Add('  0.00 AS DESESP,                                      ');
      SQL.Add('  0.00 AS DESACE_ITE,                                  ');
      SQL.Add('  0.00 AS TOTFRE_ITE,                                  ');
      SQL.Add('  (ITC_VALCOM + ITC_VALIPI + ITC_VALRET) AS VLRCON_ITE,');
      SQL.Add('  "N" AS AUX_DESINC,                                   ');
      SQL.Add('  "" AS NAT_CODCFO,                                    ');
      SQL.Add('  "" AS DET_NATOPE,                                    ');
      SQL.Add('  "" AS NAT_DESCRI,                                    ');
      SQL.Add('   CONCAT(ABF_CODABF, " - ", ABF_DESABF) AS DESABF,    ');
      SQL.Add('  IF(IFNULL(COMICD.ICD_BCUFDE,"") = "", "0", "1") AS ICD_TEMICD, ');
      SQL.Add('  "N" AS AUX_VENPRE,                                   ');
      SQL.Add('  COMICD.ICD_BCUFDE,                                   ');
      SQL.Add('  COMICD.ICD_BASFCP,                                   ');
      SQL.Add('  COMICD.ICD_PERFCP,                                   ');
      SQL.Add('  COMICD.ICD_ALQUFD,                                   ');
      SQL.Add('  COMICD.ICD_ALQINE,                                   ');
      SQL.Add('  COMICD.ICD_PERPAR,                                   ');
      SQL.Add('  COMICD.ICD_VALFCP,                                   ');
      SQL.Add('  COMICD.ICD_VALDES,                                   ');
      SQL.Add('  COMICD.ICD_VALORI,                                   ');

      SQL.Add('  0.00 AS VICMDE,                                      ');
      SQL.Add('  0.00 AS BCR158,                                      ');
      SQL.Add('  0.00 AS VLR158,                                      ');
      SQL.Add('  0.00 AS BCI158,                                      ');
      SQL.Add('  0.00 AS ALI158,                                      ');
      SQL.Add('  0.00 AS VLI158,                                      ');

      SQL.Add('  0.00 AS BFCPST, ');
      SQL.Add('  0.00 AS PFCPST, ');
      SQL.Add('  0.00 AS VFCPST, ');
      SQL.Add('  G.ITE_TIPPRO AS TIPPRO, ');

      SQL.Add('   @I02PROPD := (SELECT I02_CPROD FROM DETELE');
      SQL.Add('       INNER JOIN GERELE ON DETELE.DET_SEQGER = GERELE.AUTOINCREM');
      SQL.Add('       WHERE GERELE.GER_DOCENT = MOVGER.GER_NUMDOC');
      SQL.Add('         AND GERELE.GER_ESPENT = MOVGER.GER_ESPDOC');
      SQL.Add('         AND GERELE.GER_EMPENT = MOVGER.GER_CODEMP');
      SQL.Add('         AND GERELE.GER_CODFOR = MOVGER.GER_CODFOR');
      SQL.Add('         AND IFNULL(GERELE.B07_SERIE, "") = MOVGER.GER_SERIE_');
      SQL.Add('         and DETELE.DET_CODITE = MOVDET.DET_CODITE');
      SQL.Add('             LIMIT 1) AS I02PROPD,');
      SQL.Add('    CAST(IFNULL(@I02PROPD, "") AS CHAR(120) ) AS CODFAB, ');

      SQL.Add('  "" AS CIDADEENT,');
      SQL.Add('  "" AS ESTADOENT,');
      SQL.Add('  "" AS CEPENT,');
      SQL.Add('   A.AUX_OPCDOC AS OPCDOC , ');

      SQL.Add('   CAST(CONCAT(I.ITE_CODMAR, "-", CM.MAR_DESMAR) AS CHAR(100)) AS DESMAR, ');
      SQL.Add('   I.ITE_CODFAB AS CODFAB2 ');
      SQL.Add('   ,0.00 DET_QBCMON ');
      SQL.Add('   ,0.00 DET_ADREMN ');
      SQL.Add('   ,0.00 DET_VALMON ');
      SQL.Add('   ,0.00 DET_VLGNRE ');
      SQL.Add('   ,0.00 AS BASCBS ');
      SQL.Add('   ,0.00 AS VALCBS ');
      SQL.Add('   ,0.00 AS BASIBS ');
      SQL.Add('   ,0.00 AS VALIBS ');
      SQL.Add('   ,0.00 AS BAS_IS ');
      SQL.Add('   ,0.00 AS VAL_IS ');
      SQL.Add('FROM                                                   ');
      SQL.Add('  NOTCOM                                               ');
      SQL.Add('  INNER JOIN MOVDET                                    ');
      SQL.Add('    ON NOTCOM.GER_DOCORI = MOVDET.DET_NUMDOC           ');
      SQL.Add('    AND NOTCOM.GER_SERORI = MOVDET.DET_SERIE_          ');
      SQL.Add('    AND NOTCOM.GER_EMPORI = MOVDET.DET_CODEMP          ');
      SQL.Add('    AND NOTCOM.GER_ESPORI = MOVDET.DET_ESPDOC          ');
      SQL.Add('  LEFT JOIN ITECOM                                     ');
      SQL.Add('    ON ITC_SEQFIS = NOTCOM.GER_SEQGER AND              ');
      SQL.Add('      ITC_CODITE  = MOVDET.DET_CODITE                  ');
      SQL.Add('  LEFT JOIN COMICD ON COMICD.ICD_SEQITE = ITECOM.AUTOINCREM ');
      SQL.Add('   LEFT  JOIN CADUNI   ON   DET_UNIDAD = UNI_CODUNI');
      SQL.Add('  LEFT JOIN MOVGER   ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER');
      SQL.add('  LEFT  JOIN AUXMOV A ON A.AUX_SEQGER = MOVGER.AUTOINCREM ');
      SQL.Add('  LEFT JOIN CADTRI                                     ');
      SQL.Add('    ON ITC_CODFIS = TRI_CODTRI                         ');
      SQL.Add('  INNER JOIN CADCFO                                    ');
      SQL.Add('    ON ITC_CLAFIS = CFO_CODCFO                         ');
      SQL.Add('  LEFT JOIN CADITE I                                   ');
      SQL.Add('    ON I.ITE_CODITE = DET_CODITE                       ');
      SQL.Add('  LEFT JOIN ITEGER G                                   ');
      SQL.Add('    ON G.ITE_CODITE = DET_CODITE AND G.ITE_CODEMP = DET_CODEMP ');
      SQL.Add('   LEFT  JOIN CADMAR CM ON CM.MAR_CODMAR = I.ITE_CODMAR ');

      If fCfgSis('TIPABF') = '1' Then
      Begin
        SQL.Add(' LEFT JOIN ABFICM ON ABF_CODABF = I.ITE_CODABF ');
      End
      Else
      Begin
        SQL.Add(' LEFT JOIN ABFICM ON ABF_CODABF = G.ITE_CODABF ');
      End;
      SQL.Add('  AND ABF_ESTADO = DET_ESTADO ');

      SQL.Add('WHERE NOTCOM.GER_SEQGER = :AUTOINCREM                  ');
      SQL.Add('  AND NOTCOM.GER_COMVAL = "S"                          ');
      SQL.Add('      GROUP BY NOTCOM.GER_SEQGER, ITECOM.AUTOINCREM    ');
      SQL.Add('ORDER BY MOVDET.AUTOINCREM                             ');

      ParamByName('AUTOINCREM').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;

      Open;

      If Not IsEmpty Then
        strTabela := 'ITECOM'
    End;

    EnableControls;
  End;

  pSetFocus(dbgItens);

//  blnHandle:= False;

  If dtsFisItens.DataSet.RecordCount > 0 Then
    pCarregaItensGrid;

  edtCidadeEnt.Text := qryFisItens.FieldByName('CIDADEENT').AsString;
  edtEstadoEnt.Text := qryFisItens.FieldByName('ESTADOENT').AsString;
  edtCEPEnt.Text    := qryFisItens.FieldByName('CEPENT').AsString;

  pDefineCapaPrimeiraClafisDadosGerais;

  edtVenda.Text := Iif(qryFisItens.FieldByName('AUX_VENPRE').AsString = 'S', 'PRESENCIAL','');

  pCalculaTotaisItens;

  fltOldAlqPis := qryTabela.FieldByName('FIS_ALQPIS').AsFloat;
  fltOldBasPis := qryTabela.FieldByName('FIS_BASPIS').AsFloat;
  fltOldAlqCof := qryTabela.FieldByName('FIS_ALQCOF').AsFloat;
  fltOldBasCof := qryTabela.FieldByName('FIS_BASCOF').AsFloat;
end;

procedure TfrmCadLivroFiscal.pAtualizaItensLivro;
var
  qryItens: TUniQuery;
  qryGen  : TUniQuery;
  qryUpdIcd: TUniQuery;
  fltAlqDifal : double;
begin
  If strTabela = 'ITECOM' Then
    Exit;

  qryGen   := fCriaQuery(Self);
  qryItens := fCriaQuery(Self);
  With qryItens Do
  Begin

    SQL.Clear;
    SQL.Add(' UPDATE                     ');
    SQL.Add(    strTabela                 );
    SQL.Add(' SET                        ');
    SQL.Add('   DET_CODFIS = :CODFIS,    ');
    SQL.Add('   DET_CLAFIS = :CLAFIS,    ');
    SQL.Add('   DET_BASICM = :BASICM,    ');
    SQL.Add('   DET_ALQICM = :ALQICM,    ');
    SQL.Add('   DET_VALICM = :VALICM,    ');
    SQL.Add('   DET_BASIPI = :BASIPI,    ');
    SQL.Add('   DET_ALQIPI = :ALQIPI,    ');
    SQL.Add('   DET_VALIPI = :VALIPI,    ');
    SQL.Add('   DET_VALRET = :VALRET,    ');
    SQL.Add('   DET_BASRET = :BASRET    ');
    SQL.Add(' WHERE                      ');
    SQL.Add('   DET_CODITE = :CODITE AND ');
    SQL.Add('   DET_NUMDOC = :NUMDOC AND ');
    SQL.Add('   DET_ESPDOC = :ESPDOC AND ');
    SQL.Add('   DET_CODEMP = :CODEMP AND ');
    SQL.Add('   AUTOINCREM = :AUTOIN AND ');
    SQL.Add('   IFNULL(DET_SERIE_, "") = :SERIE_ AND ');
    SQL.Add('   DET_TIP_FC = :TIP_FC AND ');

    If (dbeTip_Fc.Text = 'C') Then
      SQL.Add('   DET_CODCLI = :FORCLI ')
    Else
      SQL.Add('   DET_CODFOR = :FORCLI ');

    ParamByName('CODFIS').AsString := dbeCodFis.Text;
    ParamByName('CLAFIS').AsString := dbeClaFis.Text;
    ParamByName('BASICM').AsFloat  := fStrToFloat(dbeBasIcm.Text);
    ParamByName('ALQICM').AsFloat  := fStrToFloat(dbeAlqIcm.Text);
    ParamByName('VALICM').AsFloat  := fStrToFloat(dbeValIcm.Text);
    ParamByName('BASIPI').AsFloat  := fStrToFloat(dbeBasIPI.Text);
    ParamByName('ALQIPI').AsFloat  := fStrToFloat(dbeAlqIPI.Text);
    ParamByName('VALIPI').AsFloat  := fStrToFloat(dbeValIPI.Text);
    ParamByName('VALRET').AsFloat  := fStrToFloat(dbeValRet.Text);
    ParamByName('BASRET').AsFloat  := fStrToFloat(dbeBasRet.Text);

    ParamByName('CODITE').AsString := qryFisItens.FieldByName('CODITE').AsString;
    ParamByName('AUTOIN').AsString := qryFisItens.FieldByName('AUTOINCREM').AsString;
    ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
    ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
    ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
    ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
    ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;

    ExecSQL;

    Close;
    SQL.Clear;
    SQL.Add(' UPDATE                     ');
    SQL.Add(fTabTri);
    SQL.Add(' SET                        ');
    SQL.Add('   DET_OUTICM = :OUTICM,    ');
    SQL.Add('   DET_ISEICM = :ISEICM,    ');
    SQL.Add('   DET_BASANT = :BASANT,    ');
    SQL.Add('   DET_ICMANT = :VALANT,    ');
    SQL.Add('   DET_BAERET = :BAERET,    ');
    SQL.Add('   DET_VAERET = :VAERET,    ');
    SQL.Add('   DET_ALERET = :ALERET,    ');
    SQL.Add('   DET_VICMDE = :VICMDE,    ');
    SQL.Add('   DET_BCR158 = :BCR158,    ');
    SQL.Add('   DET_VLR158 = :VLR158,    ');
    SQL.Add('   DET_BCI158 = :BCI158,    ');
    SQL.Add('   DET_ALI158 = :ALI158,    ');
    SQL.Add('   DET_VLI158 = :VLI158     ');

    If (Not SameText(fTabTri,'NOTTRI')) Then
     SQL.Add('   ,DET_NATOPE = :NATOPE     ');

    if (fCfgSis('IMPCF4') = 'S') then
      SQL.Add('  ,DET_ICMSAI = :ICMSAI   ');
    If blnCRDMNF Then
      If (Not SameText(fTabTri,'MOVTRI')) Then
      Begin
       SQL.Add('   ,DET_QBCMON = :QBCMON     ');
       SQL.Add('   ,DET_ADREMN = :ADREMN     ');
       SQL.Add('   ,DET_VALMON = :VALMON     ');
      End;
    SQL.Add(' WHERE                      ');
    SQL.Add('   DET_SEQGER = :AUTOIN     ');

    ParamByName('AUTOIN').AsString := qryFisItens.FieldByName('AUTOINCREM').AsString;
    ParamByName('OUTICM').AsFloat  := fStrToFloat(dbeOutras.Text);
    ParamByName('ISEICM').AsFloat  := fStrToFloat(dbeIsenta.Text);
    ParamByName('VALANT').AsFloat  := fStrToFloat(dbeValAnt.Text);
    ParamByName('BASANT').AsFloat  := fStrToFloat(dbeBasAnt.Text);
    ParamByName('BAERET').AsFloat  := fStrToFloat(dbeBRetNC.Text);
    ParamByName('VAERET').AsFloat  := fStrToFloat(dbeVRetNC.Text);
    ParamByName('VICMDE').AsFloat  := fStrToFloat(dbeVICMDE.Text);

    If (Not SameText(fTabTri,'NOTTRI')) Then
      ParamByName('NATOPE').AsString := cmbNatOpeItem.Text;

    If fStrToFloat(dbeBRetNC.Text) = 0 Then
      ParamByName('ALERET').AsFloat := 0
    Else
      ParamByName('ALERET').AsFloat := (fStrToFloat(dbeVRetNC.Text) * 100) / fStrToFloat(dbeBRetNC.Text);

    ParamByName('BCR158').AsFloat := fStrToFloat(edtBaseStCat158.Text);
    ParamByName('VLR158').AsFloat := fStrToFloat(edtValorStCat158.Text);

    ParamByName('BCI158').AsFloat := fStrToFloat(edtBaseIcmCat158.Text);
    ParamByName('ALI158').AsFloat := fStrToFloat(edtAlqIcmCat158.Text);
    ParamByName('VLI158').AsFloat := fStrToFloat(edtValorIcmCat158.Text);

    If blnCRDMNF Then
      If (Not SameText(fTabTri,'MOVTRI')) Then
      Begin
        ParamByName('QBCMON').AsFloat := fStrToFloat(edtQBCMonoRet.Text);
        ParamByName('ADREMN').AsFloat := fStrToFloat(edtAdRemICMDRet.Text);
        ParamByName('VALMON').AsFloat := fStrToFloat(edtVICMSMonoRet.Text);
      End;
    if (fCfgSis('IMPCF4') = 'S') then
    begin
      fltAlqDifal := fStrToFloat(edtAlqInterna.Text)-fStrToFloat(edtAlqInterestadual.Text);
      fltAlqDifal := IIF(fltAlqDifal < 0, 0, fltAlqDifal);
      ParamByName('ICMSAI').AsFloat := ((qryFisItens.FieldByName('TOTITE').AsFloat - qryFisItens.FieldByName('DESESP').AsFloat) + qryFisItens.FieldByName('TOTFRE_ITE').AsFloat + qryFisItens.FieldByName('DESACE_ITE').AsFloat) * (fStrToFloat(dbeAlqIcm.Text)+(fltAlqDifal)) / 100;
    end;

    ExecSQL;

    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT ');
    qryGen.SQL.Add('   GROUP_CONCAT(DISTINCT D.DET_SEQGER) AS SEQGER, ');
    qryGen.SQL.Add('   SUM(DET_BASICM) AS BASICM,    ');
    qryGen.SQL.Add('   SUM(DET_VALICM) AS VALICM,    ');
    qryGen.SQL.Add('   SUM(DET_BASIPI) AS BASIPI,    ');
    qryGen.SQL.Add('   SUM(DET_VALIPI) AS VALIPI,    ');
    qryGen.SQL.Add('   SUM(DET_VALRET) AS VALRET,    ');
    qryGen.SQL.Add('   SUM(T.DET_VAEIPI) AS VAEIPI,    ');
    qryGen.SQL.Add('   SUM(T.DET_VAERET) AS VAERET,    ');
    qryGen.SQL.Add('   SUM(DET_BASRET) AS BASRET,    ');
    qryGen.SQL.Add('   SUM(IFNULL(DET_ICMANT, 0)) AS VALANT,    ');
    qryGen.SQL.Add('   SUM(IFNULL(DET_BASANT, 0)) AS BASANT,    ');
    qryGen.SQL.Add('   SUM(IFNULL(DET_VFCPST, 0)) AS VFCPST    ');
    qryGen.SQL.Add(' FROM                            ');
    qryGen.SQL.Add( strTabela + ' D');
    qryGen.SQL.Add(' LEFT JOIN ' + fTabTri + ' T ON T.DET_SEQGER = D.AUTOINCREM');
    qryGen.SQL.Add(' WHERE                      ');
    qryGen.SQL.Add('   DET_CODITE = :CODITE AND ');
    qryGen.SQL.Add('   DET_NUMDOC = :NUMDOC AND ');
    qryGen.SQL.Add('   DET_ESPDOC = :ESPDOC AND ');
    qryGen.SQL.Add('   DET_CODEMP = :CODEMP AND ');
    qryGen.SQL.Add('   AUTOINCREM = :AUTOIN AND ');
    qryGen.SQL.Add('   IFNULL(DET_SERIE_, "") = :SERIE_ AND ');
    qryGen.SQL.Add('   DET_TIP_FC = :TIP_FC AND ');
    If (dbeTip_Fc.Text = 'C') Then
      qryGen.SQL.Add('   DET_CODCLI = :FORCLI ')
    Else qryGen.SQL.Add('   DET_CODFOR = :FORCLI ');

    qryGen.ParamByName('CODITE').AsString := qryFisItens.FieldByName('CODITE').AsString;
    qryGen.ParamByName('AUTOIN').AsString := qryFisItens.FieldByName('AUTOINCREM').AsString;
    qryGen.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    qryGen.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
    qryGen.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
    qryGen.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
    qryGen.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
    qryGen.ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
    qryGen.Open;

    Close;
    SQL.Clear;
    SQL.Add(' UPDATE                     ');
    SQL.Add(IIF(strTabela = 'MOVDET', 'AUXMOV', 'AUXNOT'));
    SQL.Add(' SET                  ');
    SQL.Add('   AUX_TOTANT = :VALANT,    ');
    SQL.Add('   AUX_BASANT = :BASANT     ');
    SQL.Add(' WHERE                      ');
    SQL.Add('   AUX_SEQGER = :AUTOIN     ');

    ParamByName('AUTOIN').AsString := qryGen.FieldByName('SEQGER').AsString;
    ParamByName('VALANT').AsFloat  := qryGen.FieldByName('VALANT').AsFloat;
    ParamByName('BASANT').AsFloat  := qryGen.FieldByName('BASANT').AsFloat;
    ExecSQL;

    FreeAndNil(qryGen);
    FreeAndNil(qryItens);

    qryUpdIcd := fCriaQuery(Self);
    qryUpdIcd.SQL.Add('UPDATE ' + IIF(strTabela='MOVDET', 'MOVICD', 'NOTICD') + ' SET ');
    qryUpdIcd.SQL.Add('  ICD_BCUFDE = :BCUFDE, ');
    qryUpdIcd.SQL.Add('  ICD_PERFCP = :PERFCP, ');
    qryUpdIcd.SQL.Add('  ICD_ALQUFD = :ALQUFD, ');
    qryUpdIcd.SQL.Add('  ICD_ALQINE = :ALQINE, ');
    qryUpdIcd.SQL.Add('  ICD_PERPAR = :PERPAR, ');
    qryUpdIcd.SQL.Add('  ICD_VALFCP = :VALFCP, ');
    qryUpdIcd.SQL.Add('  ICD_VALDES = :VALDES, ');
    qryUpdIcd.SQL.Add('  ICD_VALORI = :VALORI, ');
    qryUpdIcd.SQL.Add('  ICD_BASFCP = :BASFCP  ');
    qryUpdIcd.SQL.Add('WHERE ICD_SEQGER = :SEQGER ');

    qryUpdIcd.ParamByName('BCUFDE').AsFloat := fStrToFloat(edtBaseUFDest.Text);
    qryUpdIcd.ParamByName('BASFCP').AsFloat := fStrToFloat(edtBaseFCP.Text);
    qryUpdIcd.ParamByName('PERFCP').AsFloat := fStrToFloat(edtPercFCP.Text);
    qryUpdIcd.ParamByName('ALQUFD').AsFloat := fStrToFloat(edtAlqInterna.Text);
    qryUpdIcd.ParamByName('ALQINE').AsFloat := fStrToFloat(edtAlqInterestadual.Text);
    qryUpdIcd.ParamByName('PERPAR').AsFloat := fStrToFloat(edtPercentualPartilha.Text);
    qryUpdIcd.ParamByName('VALFCP').AsFloat := fStrToFloat(edtValorFCP.Text);
    qryUpdIcd.ParamByName('VALDES').AsFloat := fStrToFloat(edtICMSDestino.Text);
    qryUpdIcd.ParamByName('VALORI').AsFloat := fStrToFloat(edtICMSOrigem.Text);
    qryUpdIcd.ParamByName('SEQGER').AsString := qryFisItens.FieldByName('AUTOINCREM').AsString;
    qryUpdIcd.ExecSQL;

    FreeAndNil(qryUpdIcd);

    if (fCfgSis('IMPCF4') = 'S') then
      pAtualizaPrecoCustoReal(qryFisItens.FieldByName('AUTOINCREM').AsString);

    pAtualizaDadosPisCofins(qryFisItens.FieldByName('AUTOINCREM').AsString);
    pRateiaValores;
  End;
end;

procedure TfrmCadLivroFiscal.pCarregaModFis(strChave: String = '');
  Var
    strModChave: String;
    i: Integer;
    objStrings: TStrings;
Begin
  cbxCodMod.Clear;
  objStrings := cbxCodMod.Items;
  fRetornaDadosModFis(strChave, objStrings);

  If Not(qryTabela.State in [dsInsert,dsEdit]) Then
  begin
    strModChave := qryTabela.FieldByName('FIS_CODMOD').AsString;
    i := cbxCodMod.Items.IndexOfName(strModChave);
    cbxCodMod.ItemIndex := i;
    cbxCodMod.Enabled := False;
  end;
End;

procedure TfrmCadLivroFiscal.pCarregaPisCofins(strCfop, AstrCstPis, AstrCstCof: String);
var
  qryTbl: TUniQuery;
  strCstPis: String;
  fltBasPis: Double;
  fltAlqPis: Double;
  fltValPis: Double;
  strCstCof: String;
  fltBasCof: Double;
  fltAlqCof: Double;
  fltValCof: Double;
  fltTotDoc: Double;
begin
  If Not fValidaCampos(dbeVlCon1) Then
    Exit;

  If fEmptyStr(strCfop) then
    Exit;

  If blnAlterouPisCofins Then
    Exit;
 {$Region 'Comentado pelo req 194134'}
//    If dtsFisItens.DataSet.RecordCount > 0 Then
//      Exit;
  {$EndRegion}

  blnCarregaPis := False;
  blnCarregaCofins := False;
  qryTbl := fCriaQuery;
  strCstPis := '';
  fltBasPis := 0;
  fltAlqPis := 0;
  fltValPis := 0;
  strCstCof := '';
  fltBasCof := 0;
  fltAlqCof := 0;
  fltValCof := 0;
  Try
    qryTbl.Close;
    qryTbl.SQL.Clear;

    qryTbl.SQL.Add('SELECT * FROM PISENT WHERE LOCATE(:CLAFIS, ' + fTransformSQL('APC_CFOENT') + ') > 0');
    If AstrCstPis <> '' Then
      qryTbl.SQL.Add(' AND APC_CSTENT = ' +fQuotedStr(AstrCstPis));

    qryTbl.SQL.Add('ORDER BY APC_VIGENC DESC, APC_CODAPC ASC');

    qryTbl.ParamByName('CLAFIS').AsString := strCfop;

    qryTbl.Open;

    If Not qryTbl.IsEmpty Then
    Begin
      strCstPis := qryTbl.FieldByName('APC_CSTENT').AsString;
      fltTotDoc := fStrToFloat(edtTotDoc.Text);
      If (dbeEspDoc.Text = 'CT') And fCfgSis('DEIPCT', varBoolean)  Then
        fltTotDoc := fltTotDoc  - fStrToFloat(edtVlrIcmTot.text);
      fltBasPis := fFormataFloat((qryTbl.FieldByName('APC_BASENT').AsFloat * fltTotDoc / 100), 2);
      fltAlqPis := qryTbl.FieldByName('APC_ALQENT').AsFloat;
      fltValPis := fFormataFloat(fFormataFloat((fltBasPis * fltAlqPis / 100), 4),2);
    End;

    If Not fExisteRegraPis(strCstPis,
                           fltBasPis,
                           fltAlqPis,
                           fltValPis) Then
    Begin
      If Not qryFisItens.IsEmpty Then
        dbeCstPis.Field.AsString := ''
      Else
        pMensagemOk('Abreviação de PIS Padrão não encontrada.');
    End
    Else
    Begin
      dbeCstPis.Field.Value := strCstPis;
      dbeBasPis.Field.Value := fltBasPis;
      dbeAlqPis.Field.Value := fltAlqPis;
      dbeTotPis.Field.Value := fltValPis;
      fValidaCampos(dbeBasPis, True);
      fValidaCampos(dbeAlqPis, True);

      If Pos(strCfop, '1933_2933') > 0 Then
      Begin
        dbeBasPis.ReadOnly := True;
        dbeTotPis.ReadOnly := True;
      End;

      btnAtualizaCstAliquotaProdutos.Enabled:= Not(dbeAlqPis.ReadOnly) And (dbeAlqPis.Enabled = True) And
                                               Not(dbeCstPis.ReadOnly) And (dbeCstPis.Enabled = True);

      blnCarregaPis := True;
    End;

    //COFINS
    qryTbl.Close;
    qryTbl.SQL.Clear;
    qryTbl.SQL.Add('SELECT * FROM COFENT WHERE LOCATE(:CLAFIS, ' + fTransformSQL('APC_CFOENT') + ') > 0');
    If AstrCstCof <> '' Then
      qryTbl.SQL.Add(' AND APC_CSTENT = ' +fQuotedStr(AstrCstCof)) ;

    qryTbl.SQL.Add('ORDER BY APC_VIGENC DESC, APC_CODAPC ASC');

    qryTbl.ParamByName('CLAFIS').AsString := strCfop;
    qryTbl.Open;

    If Not qryTbl.IsEmpty Then
    Begin
      strCstCof := qryTbl.FieldByName('APC_CSTENT').AsString;
      fltTotDoc := fStrToFloat(edtTotDoc.Text);
      If (dbeEspDoc.Text = 'CT') And fCfgSis('DEIPCT', varBoolean)  Then
        fltTotDoc := fltTotDoc  - fStrToFloat(edtVlrIcmTot.text);
      fltBasCof := fFormataFloat((qryTbl.FieldByName('APC_BASENT').AsFloat * fltTotDoc / 100), 2);
      fltAlqCof := qryTbl.FieldByName('APC_ALQENT').AsFloat;
      fltValCof := fFormataFloat(fFormataFloat((fltBasCof * fltAlqCof / 100), 4),2);
    End;

    If Not fExisteRegraCofins( strCstCof,
                               fltBasCof,
                               fltAlqCof,
                               fltValCof) Then
    Begin
      If Not qryFisItens.IsEmpty Then
        dbeCstPis.Field.AsString := ''
      Else
        pMensagemOk('Abreviação de COFINS Padrão não encontrada.');
    End
    Else
    Begin
      dbeCstCof.Field.Value := strCstCof;
      dbeBasCof.Field.Value := fltBasCof;
      dbeAlqCof.Field.Value := fltAlqCof;
      dbeTotCof.Field.Value := fltValCof;
      fValidaCampos(dbeBasCof, True);
      fValidaCampos(dbeAlqCof, True);

      If Pos(strCfop, '1933_2933') > 0 Then
      Begin
        dbeBasCof.ReadOnly := True;
        dbeTotCof.ReadOnly := True;
      End;

      If Not btnAtualizaCstAliquotaProdutos.Enabled Then
        btnAtualizaCstAliquotaProdutos.Enabled:= Not(dbeAlqCof.ReadOnly) And (dbeAlqCof.Enabled = True) And
                                                 Not(dbeCstCof.ReadOnly) And (dbeCstCof.Enabled = True);

      blnCarregaCofins := True;
    End;


  Finally
    FreeAndNil(qryTbl);
  End;
end;

procedure TfrmCadLivroFiscal.pCarregaTipoLancamentoCTE;
begin
  if qryTabela.FieldByName('FIS_ESPDOC').AsString = 'CT' Then
  Begin
    rgpTipoLancamentoCTE.Visible := True;

    if qryTabela.FieldByName('FIS_LCTCTE').AsString = 'M' Then
      rgpTipoLancamentoCTE.ItemIndex := 0
    Else
      rgpTipoLancamentoCTE.ItemIndex := 1;
  End Else
    rgpTipoLancamentoCTE.Visible := False;
end;

procedure TfrmCadLivroFiscal.pCriaMovGerMovDet;
var qryComand: TUniQuery;
    strMovGerAutInc: string;
begin
  qryComand := fCriaQuery;
  Try
    strMovGerAutInc := fRetAutoIncrem('MOVGER',VS_StrCodEmp);
    pMontaSQLMovGer(qryComand, strMovGerAutInc);
    pMontaSQLMovDet(qryComand, strMovGerAutInc);
    qryComand.ExecSQL;
  Finally
    FreeAndNil(qryComand);
  End;

end;

procedure TfrmCadLivroFiscal.pMontaSQLMovGer(qryComand: TUniQuery; strMovGerAutInc: String);
begin
    qryComand.SQL.Add('INSERT INTO MOVGER (');
    qryComand.SQL.Add('            AUTOINCREM,');
    qryComand.SQL.Add('            GER_CODEMP,');
    qryComand.SQL.Add('            GER_NUMDOC,');
    qryComand.SQL.Add('            GER_ESPDOC,');
    qryComand.SQL.Add('            GER_CODVEN,');
    qryComand.SQL.Add('            GER_CODTRA,');
    qryComand.SQL.Add('            GER_CODFOR,');
    qryComand.SQL.Add('            GER_CODCLI,');
    qryComand.SQL.Add('            GER_TIP_FC,');
    qryComand.SQL.Add('            GER_SERIE_,');
    qryComand.SQL.Add('            GER_DTAENT,');
    qryComand.SQL.Add('            GER_HORENT,');
    qryComand.SQL.Add('            GER_DTADOC,');
    qryComand.SQL.Add('            GER_CONPAG,');
    qryComand.SQL.Add('            GER_ESTADO,');
    qryComand.SQL.Add('            GER_NOMCON,');
    qryComand.SQL.Add('            GER_ENDCON,');
    qryComand.SQL.Add('            GER_BAICON,');
    qryComand.SQL.Add('            GER_CEPCON,');
    qryComand.SQL.Add('            GER_CIDCON,');
    qryComand.SQL.Add('            GER_ESTCON,');
    qryComand.SQL.Add('            GER_TELCON,');
    qryComand.SQL.Add('            GER_CGCCPF,');
    qryComand.SQL.Add('            GER_CGCCON,');
    qryComand.SQL.Add('            GER_IESCON,');
    qryComand.SQL.Add('            GER_EMLCON,');
    qryComand.SQL.Add('            GER_CLAFIS,');
    qryComand.SQL.Add('            GER_BASSIM,');
    qryComand.SQL.Add('            GER_BASIPI,');
    qryComand.SQL.Add('            GER_ALQIPI,');
    qryComand.SQL.Add('            GER_TOTIPI,');
    qryComand.SQL.Add('            GER_BASICM,');
    qryComand.SQL.Add('            GER_ALQICM,');
    qryComand.SQL.Add('            GER_TOTICM,');
    qryComand.SQL.Add('            GER_TOTRET,');
    qryComand.SQL.Add('            GER_ALQRET,');
    qryComand.SQL.Add('            GER_BASRET,');
    qryComand.SQL.Add('            GER_DESESP,');
    qryComand.SQL.Add('            GER_VLRCON,');
    qryComand.SQL.Add('            GER_TOTPRO,');
    qryComand.SQL.Add('            GER_TOTCUS,');
    qryComand.SQL.Add('            GER_TOTMED,');
    qryComand.SQL.Add('            GER_TIPFRE,');
    qryComand.SQL.Add('            GER_TOTFRE,');
    qryComand.SQL.Add('            GER_PESBRU,');
    qryComand.SQL.Add('            GER_PESLIQ,');
    qryComand.SQL.Add('            GER_VOLUME,');
    qryComand.SQL.Add('            GER_ESPECI,');
    qryComand.SQL.Add('            GER_MARCA_,');
    qryComand.SQL.Add('            GER_MEN001,');
    qryComand.SQL.Add('            GER_MEN002,');
    qryComand.SQL.Add('            GER_JAFATU,');
    qryComand.SQL.Add('            GER_TIPFAT,');
    qryComand.SQL.Add('            GER_NUMFAT,');
    qryComand.SQL.Add('            GER_DTAFAT,');
    qryComand.SQL.Add('            GER_VENFAT,');
    qryComand.SQL.Add('            GER_CNDFAT,');
    qryComand.SQL.Add('            GER_VALFAT,');
    qryComand.SQL.Add('            GER_VPAR01,');
    qryComand.SQL.Add('            GER_VPAR02,');
    qryComand.SQL.Add('            GER_VPAR03,');
    qryComand.SQL.Add('            GER_VPAR04,');
    qryComand.SQL.Add('            GER_VPAR05,');
    qryComand.SQL.Add('            GER_VPAR06,');
    qryComand.SQL.Add('            GER_VPAR07,');
    qryComand.SQL.Add('            GER_VPAR08,');
    qryComand.SQL.Add('            GER_VPAR09,');
    qryComand.SQL.Add('            GER_VPAR10,');
    qryComand.SQL.Add('            GER_VPAR11,');
    qryComand.SQL.Add('            GER_VPAR12,');
    qryComand.SQL.Add('            GER_NOTESP,');
    qryComand.SQL.Add('            GER_CODDIG,');
    qryComand.SQL.Add('            GER_PORDES,');
    qryComand.SQL.Add('            GER_R_GCON,');
    qryComand.SQL.Add('            GER_CODCND,');
    qryComand.SQL.Add('            GER_CODFPG,');
    qryComand.SQL.Add('            GER_FATNOT,');
    qryComand.SQL.Add('            GER_CODS01,');
    qryComand.SQL.Add('            GER_CODS02,');
    qryComand.SQL.Add('            GER_CODS03,');
    qryComand.SQL.Add('            GER_CODS04,');
    qryComand.SQL.Add('            GER_CODS05,');
    qryComand.SQL.Add('            GER_CODS06,');
    qryComand.SQL.Add('            GER_DESS01,');
    qryComand.SQL.Add('            GER_DESS02,');
    qryComand.SQL.Add('            GER_DESS03,');
    qryComand.SQL.Add('            GER_DESS04,');
    qryComand.SQL.Add('            GER_DESS05,');
    qryComand.SQL.Add('            GER_DESS06,');
    qryComand.SQL.Add('            GER_VALS01,');
    qryComand.SQL.Add('            GER_VALS02,');
    qryComand.SQL.Add('            GER_VALS03,');
    qryComand.SQL.Add('            GER_VALS04,');
    qryComand.SQL.Add('            GER_VALS05,');
    qryComand.SQL.Add('            GER_VALS06,');
    qryComand.SQL.Add('            GER_PRAENT,');
    qryComand.SQL.Add('            GER_TOTSER,');
    qryComand.SQL.Add('            GER_PERISS,');
    qryComand.SQL.Add('            GER_VALISS,');
    qryComand.SQL.Add('            GER_CLAFI2,');
    qryComand.SQL.Add('            GER_CLAFI3,');
    qryComand.SQL.Add('            GER_NATOPE,');
    qryComand.SQL.Add('            GER_DESACE,');
    qryComand.SQL.Add('            GER_ORIDOC,');
    qryComand.SQL.Add('            GER_DTAROM,');
    qryComand.SQL.Add('            GER_HORROM,');
    qryComand.SQL.Add('            GER_OPEROM,');
    qryComand.SQL.Add('            GER_NUMROM,');
    qryComand.SQL.Add('            GER_CONENT,');
    qryComand.SQL.Add('            GER_IMPRES,');
    qryComand.SQL.Add('            GER_CODREP,');
    qryComand.SQL.Add('            GER_VALROM,');
    qryComand.SQL.Add('            GER_ALQIRF,');
    qryComand.SQL.Add('            GER_VALIRF,');
    qryComand.SQL.Add('            GER_ALQPIS,');
    qryComand.SQL.Add('            GER_VALPIS,');
    qryComand.SQL.Add('            GER_ALQCOF,');
    qryComand.SQL.Add('            GER_VALCOF,');
    qryComand.SQL.Add('            GER_ALQCSL,');
    qryComand.SQL.Add('            GER_VALCSL,');
    qryComand.SQL.Add('            GER_IRFRET,');
    qryComand.SQL.Add('            GER_PISRET,');
    qryComand.SQL.Add('            GER_COFRET,');
    qryComand.SQL.Add('            GER_CSLRET,');
    qryComand.SQL.Add('            GER_SERRET,');
    qryComand.SQL.Add('            GER_NOTRET,');
    qryComand.SQL.Add('            GER_NORESE,');
    qryComand.SQL.Add('            GER_ALIRFP,');
    qryComand.SQL.Add('            GER_ALPISP,');
    qryComand.SQL.Add('            GER_ALCOFP,');
    qryComand.SQL.Add('            GER_ALCSLP,');
    qryComand.SQL.Add('            GER_PESGSO,');
    qryComand.SQL.Add('            GER_VLSGSO,');
    qryComand.SQL.Add('            GER_IRPRRT,');
    qryComand.SQL.Add('            GER_IRPRDV,');
    qryComand.SQL.Add('            GER_IRSERT,');
    qryComand.SQL.Add('            GER_IRSEDV,');
    qryComand.SQL.Add('            GER_PIPRRT,');
    qryComand.SQL.Add('            GER_PIPRDV,');
    qryComand.SQL.Add('            GER_PISERT,');
    qryComand.SQL.Add('            GER_PISEDV,');
    qryComand.SQL.Add('            GER_COPRRT,');
    qryComand.SQL.Add('            GER_COPRDV,');
    qryComand.SQL.Add('            GER_COSERT,');
    qryComand.SQL.Add('            GER_COSEDV,');
    qryComand.SQL.Add('            GER_CSPRRT,');
    qryComand.SQL.Add('            GER_CSPRDV,');
    qryComand.SQL.Add('            GER_CSSERT,');
    qryComand.SQL.Add('            GER_CSSEDV,');
    qryComand.SQL.Add('            GER_ORDPRO,');
    qryComand.SQL.Add('            GER_ROMIMP,');
    qryComand.SQL.Add('            GER_BASORG,');
    qryComand.SQL.Add('            GER_ICMORG,');
    qryComand.SQL.Add('            GER_NCONHE,');
    qryComand.SQL.Add('            GER_DESCFF,');
    qryComand.SQL.Add('            GER_RET_SP,');
    qryComand.SQL.Add('            GER_CONSUM,');
    qryComand.SQL.Add('            GER_MEN003,');
    qryComand.SQL.Add('            GER_MEN004,');
    qryComand.SQL.Add('            GER_MEN005,');
    qryComand.SQL.Add('            GER_ENTFAT,');
    qryComand.SQL.Add('            GER_CLIFAT,');
    qryComand.SQL.Add('            GER_EMPFAT,');
    qryComand.SQL.Add('            GER_OPEEXP,');
    qryComand.SQL.Add('            GER_SEPEXP,');
    qryComand.SQL.Add('            GER_OPLBRC,');
    qryComand.SQL.Add('            GER_DTLBRC,');
    qryComand.SQL.Add('            GER_HRLBRC,');
    qryComand.SQL.Add('            GER_TABPRE,');
    qryComand.SQL.Add('            GER_OPLBEX,');
    qryComand.SQL.Add('            GER_DTLBEX,');
    qryComand.SQL.Add('            GER_HRLBEX,');
    qryComand.SQL.Add('            GER_ENTFUT,');
    qryComand.SQL.Add('            GER_NUM_PR,');
    qryComand.SQL.Add('            GER_EMPROM,');
    qryComand.SQL.Add('            GER_MARGEM,');
    qryComand.SQL.Add('            GER_EMPORI,');
    qryComand.SQL.Add('            GER_BARTSP,');
    qryComand.SQL.Add('            GER_VLRTSP,');
    qryComand.SQL.Add('            GER_OPRFLJ,');
    qryComand.SQL.Add('            GER_SEGURO,');
    qryComand.SQL.Add('            GER_DTALAN,');
    qryComand.SQL.Add('            GER_NUMREG,');
    qryComand.SQL.Add('            GER_AUTSER,');
    qryComand.SQL.Add('            GER_DTENTR,');
    qryComand.SQL.Add('            GER_NROCEI,');
    qryComand.SQL.Add('            GER_CLAFI4,');
    qryComand.SQL.Add('            GER_TOEIPI,');
    qryComand.SQL.Add('            GER_ALEIPI,');
    qryComand.SQL.Add('            GER_BAEIPI,');
    qryComand.SQL.Add('            GER_CODEVE,');
    qryComand.SQL.Add('            GER_CODOCO,');
    qryComand.SQL.Add('            GER_VLIVA0,');
    qryComand.SQL.Add('            GER_VLIVA5,');
    qryComand.SQL.Add('            GER_VIVA10,');
    qryComand.SQL.Add('            GER_MENEXP,');
    qryComand.SQL.Add('            GER_MENEX2,');
    qryComand.SQL.Add('            GER_MENEX3,');
    qryComand.SQL.Add('            GER_MENEX4,');
    qryComand.SQL.Add('            GER_PRVIMP,');
    qryComand.SQL.Add('            GER_NROBOX');
    qryComand.SQL.Add('            )');
    qryComand.SQL.Add('(SELECT "' + strMovGerAutInc + '",');                    // AUTOINCREM
    qryComand.SQL.Add('        FIS_CODEMP,');                                  // GER_CODEMP
    qryComand.SQL.Add('        FIS_NUMDOC,');                                  // GER_NUMDOC
    qryComand.SQL.Add('        FIS_ESPDOC,');                                  // GER_ESPDOC
    qryComand.SQL.Add('        "'+strLoginUsuarioLogado+'",');                 // GER_CODVEN
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODTRA
    qryComand.SQL.Add('        FIS_FORCLI,');                                  // GER_CODFOR
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODCLI
    qryComand.SQL.Add('        "F",       ');                                  // GER_TIP_FC
    qryComand.SQL.Add('        FIS_SERIE_,');                                  // GER_SERIE_
    qryComand.SQL.Add('        FIS_DTAENT,');                                  // GER_DTAENT
    qryComand.SQL.Add('        "' + FormatDateTime('hh:mm:ss', fNow) + '",');  // GER_HORENT
    qryComand.SQL.Add('        FIS_DTADOC,');                                  // GER_DTADOC
    qryComand.SQL.Add('        "01000",   ');                                  // GER_CONPAG
    qryComand.SQL.Add('        "",        ');                                  // GER_ESTADO
    qryComand.SQL.Add('        NULL,      ');                                  // GER_NOMCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_ENDCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_BAICON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CEPCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CIDCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_ESTCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_TELCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CGCCPF
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CGCCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_IESCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_EMLCON
    qryComand.SQL.Add('        FIS_CLFSC1,');                                  // GER_CLAFIS
    qryComand.SQL.Add('        0.00,      ');                                  // GER_BASSIM
    qryComand.SQL.Add('        IFNULL(FIS_BASIP1, 0.00),      ');              // GER_BASIPI
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALQIPI
    qryComand.SQL.Add('        IFNULL(FIS_VLRIP1, 0.00),      ');              // GER_TOTIPI
    qryComand.SQL.Add('        IFNULL(FIS_BASIC1, 0.00),      ');              // GER_BASICM
    qryComand.SQL.Add('        IFNULL(FIS_ALQIC1, 0.00),      ');              // GER_ALQICM
    qryComand.SQL.Add('        IFNULL(FIS_VLRIC1, 0.00),      ');              // GER_TOTICM
    qryComand.SQL.Add('        IFNULL(FIS_VAERE1, 0.00),      ');              // GER_TOTRET
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALQRET
    qryComand.SQL.Add('        IFNULL(FIS_BCRET1, 0.00),      ');              // GER_BASRET
    qryComand.SQL.Add('        0.00,      ');                                  // GER_DESESP
    qryComand.SQL.Add('        FIS_VLCON1,');                                  // GER_VLRCON
    qryComand.SQL.Add('        0.00,      ');                                  // GER_TOTPRO
    qryComand.SQL.Add('        0.00,      ');                                  // GER_TOTCUS
    qryComand.SQL.Add('        0.00,      ');                                  // GER_TOTMED
    qryComand.SQL.Add('        "",        ');                                  // GER_TIPFRE
    qryComand.SQL.Add('        0.00,      ');                                  // GER_TOTFRE
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PESBRU
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PESLIQ
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VOLUME
    qryComand.SQL.Add('        "",        ');                                  // GER_ESPECI
    qryComand.SQL.Add('        "",        ');                                  // GER_MARCA_
    qryComand.SQL.Add('        "NOTA DE SERVICO FORNECEDOR",');                // GER_MEN001
    qryComand.SQL.Add('        "",        ');                                  // GER_MEN002
    qryComand.SQL.Add('        "0",        ');                                 // GER_JAFATU
    qryComand.SQL.Add('        "",        ');                                  // GER_TIPFAT
    qryComand.SQL.Add('        "",        ');                                  // GER_NUMFAT
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DTAFAT
    qryComand.SQL.Add('        NULL,      ');                                  // GER_VENFAT
    qryComand.SQL.Add('        "",        ');                                  // GER_CNDFAT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALFAT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR01
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR02
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR03
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR04
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR05
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR06
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR07
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR08
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR09
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR10
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR11
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VPAR12
    qryComand.SQL.Add('        "N",        ');                                 // GER_NOTESP
    qryComand.SQL.Add('        "'+strLoginUsuarioLogado+'",');                 // GER_CODDIG
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PORDES
    qryComand.SQL.Add('        NULL,      ');                                  // GER_R_GCON
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODCND
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODFPG
    qryComand.SQL.Add('        0.00,      ');                                  // GER_FATNOT
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODS01
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODS02
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODS03
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODS04
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODS05
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODS06
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DESS01
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DESS02
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DESS03
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DESS04
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DESS05
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DESS06
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALS01
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALS02
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALS03
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALS04
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALS05
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALS06
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PRAENT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_TOTSER
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PERISS
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALISS
    qryComand.SQL.Add('        "",        ');                                  // GER_CLAFI2
    qryComand.SQL.Add('        "",        ');                                  // GER_CLAFI3
    qryComand.SQL.Add('        FIS_NATOPE,');                                  // GER_NATOPE
    qryComand.SQL.Add('        0.00,      ');                                  // GER_DESACE
    qryComand.SQL.Add('        "",        ');                                  // GER_ORIDOC
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DTAROM
    qryComand.SQL.Add('        NULL,      ');                                  // GER_HORROM
    qryComand.SQL.Add('        NULL,      ');                                  // GER_OPEROM
    qryComand.SQL.Add('        NULL,      ');                                  // GER_NUMROM
    qryComand.SQL.Add('        "N",       ');                                  // GER_CONENT
    qryComand.SQL.Add('        "1",       ');                                  // GER_IMPRES
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODREP
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALROM
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALQIRF
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALIRF
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALQPIS
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALPIS
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALQCOF
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALCOF
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALQCSL
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VALCSL
    qryComand.SQL.Add('        0.00,      ');                                  // GER_IRFRET
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PISRET
    qryComand.SQL.Add('        0.00,      ');                                  // GER_COFRET
    qryComand.SQL.Add('        0.00,      ');                                  // GER_CSLRET
    qryComand.SQL.Add('        0.00,      ');                                  // GER_SERRET
    qryComand.SQL.Add('        "",        ');                                  // GER_NOTRET
    qryComand.SQL.Add('        "",        ');                                  // GER_NORESE
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALIRFP
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALPISP
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALCOFP
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALCSLP
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PESGSO
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VLSGSO
    qryComand.SQL.Add('        0.00,      ');                                  // GER_IRPRRT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_IRPRDV
    qryComand.SQL.Add('        0.00,      ');                                  // GER_IRSERT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_IRSEDV
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PIPRRT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PIPRDV
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PISERT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_PISEDV
    qryComand.SQL.Add('        0.00,      ');                                  // GER_COPRRT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_COPRDV
    qryComand.SQL.Add('        0.00,      ');                                  // GER_COSERT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_COSEDV
    qryComand.SQL.Add('        0.00,      ');                                  // GER_CSPRRT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_CSPRDV
    qryComand.SQL.Add('        0.00,      ');                                  // GER_CSSERT
    qryComand.SQL.Add('        0.00,      ');                                  // GER_CSSEDV
    qryComand.SQL.Add('        NULL,      ');                                  // GER_ORDPRO
    qryComand.SQL.Add('        NULL,      ');                                  // GER_ROMIMP
    qryComand.SQL.Add('        0.00,      ');                                  // GER_BASORG
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ICMORG
    qryComand.SQL.Add('        0.00,      ');                                  // GER_NCONHE
    qryComand.SQL.Add('        0.00,      ');                                  // GER_DESCFF
    qryComand.SQL.Add('        0.00,      ');                                  // GER_RET_SP
    qryComand.SQL.Add('        "",        ');                                  // GER_CONSUM
    qryComand.SQL.Add('        "",        ');                                  // GER_MEN003
    qryComand.SQL.Add('        "",        ');                                  // GER_MEN004
    qryComand.SQL.Add('        "",        ');                                  // GER_MEN005
    qryComand.SQL.Add('        "N",       ');                                  // GER_ENTFAT
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CLIFAT
    qryComand.SQL.Add('        NULL,      ');                                  // GER_EMPFAT
    qryComand.SQL.Add('        NULL,      ');                                  // GER_OPEEXP
    qryComand.SQL.Add('        NULL,      ');                                  // GER_SEPEXP
    qryComand.SQL.Add('        NULL,      ');                                  // GER_OPLBRC
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DTLBRC
    qryComand.SQL.Add('        NULL,      ');                                  // GER_HRLBRC
    qryComand.SQL.Add('        "",        ');                                  // GER_TABPRE
    qryComand.SQL.Add('        NULL,      ');                                  // GER_OPLBEX
    qryComand.SQL.Add('        NULL,      ');                                  // GER_DTLBEX
    qryComand.SQL.Add('        NULL,      ');                                  // GER_HRLBEX
    qryComand.SQL.Add('        "N",       ');                                  // GER_ENTFUT
    qryComand.SQL.Add('        "",        ');                                  // GER_NUM_PR
    qryComand.SQL.Add('        NULL,      ');                                  // GER_EMPROM
    qryComand.SQL.Add('        0.00,      ');                                  // GER_MARGEM
    qryComand.SQL.Add('        "",        ');                                  // GER_EMPORI
    qryComand.SQL.Add('        0.00,      ');                                  // GER_BARTSP
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VLRTSP
    qryComand.SQL.Add('        "N",       ');                                  // GER_OPRFLJ
    qryComand.SQL.Add('        NULL,      ');                                  // GER_SEGURO
    qryComand.SQL.Add('        FIS_DTAENT,');                                  // GER_DTALAN
    qryComand.SQL.Add('        "",        ');                                  // GER_NUMREG
    qryComand.SQL.Add('        "N",       ');                                  // GER_AUTSER
    qryComand.SQL.Add('        FIS_DTAENT,');                                  // GER_DTENTR
    qryComand.SQL.Add('        "",        ');                                  // GER_NROCEI
    qryComand.SQL.Add('        "",        ');                                  // GER_CLAFI4
    qryComand.SQL.Add('        0.00,      ');                                  // GER_TOEIPI
    qryComand.SQL.Add('        0.00,      ');                                  // GER_ALEIPI
    qryComand.SQL.Add('        0.00,      ');                                  // GER_BAEIPI
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODEVE
    qryComand.SQL.Add('        NULL,      ');                                  // GER_CODOCO
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VLIVA0
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VLIVA5
    qryComand.SQL.Add('        0.00,      ');                                  // GER_VIVA10
    qryComand.SQL.Add('        "",        ');                                  // GER_MENEXP
    qryComand.SQL.Add('        "",        ');                                  // GER_MENEX2
    qryComand.SQL.Add('        "",        ');                                  // GER_MENEX3
    qryComand.SQL.Add('        "",        ');                                  // GER_MENEX4
    qryComand.SQL.Add('        NULL,      ');                                  // GER_PRVIMP
    qryComand.SQL.Add('        NULL       ');                                  // GER_NROBOX
    qryComand.SQL.Add('   FROM CADFIS ');
    qryComand.SQL.Add('  WHERE CADFIS.FIS_NUMDOC = "'+dbeNumDoc.Text+'" ');
    qryComand.SQL.Add('    AND CADFIS.FIS_ESPDOC = "'+dbeEspDoc.Text+'" ');
    qryComand.SQL.Add('    AND CADFIS.FIS_CODEMP = "'+dbeCodEmp.Text+'" ');
    qryComand.SQL.Add('    AND CADFIS.FIS_FORCLI = "'+dbeForCli.Text+'" ');
    qryComand.SQL.Add('    AND IFNULL(CADFIS.FIS_SERIE_, "") = "'+dbeNfComp.Text+'");');

    qryComand.SQL.Add(' INSERT INTO AUXMOV ( ');
    qryComand.SQL.Add('  AUX_SEQGER,         ');
    qryComand.SQL.Add('  AUX_BASANT,         ');
    qryComand.SQL.Add('  AUX_TOTANT,         ');
    qryComand.SQL.Add('  AUX_NATCFO          ');
    qryComand.SQL.Add('            )         ');
    qryComand.SQL.Add('(SELECT "' + strMovGerAutInc + '",');                    { AUTOINCREM}
    qryComand.SQL.Add('   IFNULL(FIS_BASAN1, 0.00),                ');          { AUX_BASANT BASE  ICMS ANTECIPADO }
    qryComand.SQL.Add('   IFNULL(FIS_ANTIC1, 0.00),                ');          { AUX_TOTANT VALOR ICMS ANTECIPADO }
    qryComand.SQL.Add(  QuotedStr(fRetAutoIncremNatCfo(dbeNatCfo.Text, cmbNatOpe.Text)));
    qryComand.SQL.Add('   FROM CADFIS ');
    qryComand.SQL.Add('  WHERE CADFIS.FIS_NUMDOC = "'+dbeNumDoc.Text+'" ');
    qryComand.SQL.Add('    AND CADFIS.FIS_ESPDOC = "'+dbeEspDoc.Text+'" ');
    qryComand.SQL.Add('    AND CADFIS.FIS_CODEMP = "'+dbeCodEmp.Text+'" ');
    qryComand.SQL.Add('    AND CADFIS.FIS_FORCLI = "'+dbeForCli.Text+'" ');
    qryComand.SQL.Add('    AND IFNULL(CADFIS.FIS_SERIE_, "") = "'+dbeNfComp.Text+'");');
End;

procedure TfrmCadLivroFiscal.pMontaSQLMovDet(qryComand: TUniQuery; strMovGerAutInc: String);
var strAutIncMovDet: String;
begin
  strAutIncMovDet := fRetAutoIncrem('MOVDET',VS_StrCodEmp);

  qryComand.SQL.Add('INSERT INTO MOVDET (');
  qryComand.SQL.Add('            DET_SEQGER,');
  qryComand.SQL.Add('            AUTOINCREM,');
  qryComand.SQL.Add('            DET_CODEMP,');
  qryComand.SQL.Add('            DET_CODVEN,');
  qryComand.SQL.Add('            DET_CODITE,');
  qryComand.SQL.Add('            DET_CODDIV,');
  qryComand.SQL.Add('            DET_CODMAR,');
  qryComand.SQL.Add('            DET_CODFOR,');
  qryComand.SQL.Add('            DET_CODCLI,');
  qryComand.SQL.Add('            DET_NUMDOC,');
  qryComand.SQL.Add('            DET_ESPDOC,');
  qryComand.SQL.Add('            DET_SERIE_,');
  qryComand.SQL.Add('            DET_DTAENT,');
  qryComand.SQL.Add('            DET_HORENT,');
  qryComand.SQL.Add('            DET_DTADOC,');
  qryComand.SQL.Add('            DET_CONPAG,');
  qryComand.SQL.Add('            DET_TIP_FC,');
  qryComand.SQL.Add('            DET_ESTADO,');
  qryComand.SQL.Add('            DET_DESCRI,');
  qryComand.SQL.Add('            DET_REFERE,');
  qryComand.SQL.Add('            DET_UNIDAD,');
  qryComand.SQL.Add('            DET_FORITE,');
  qryComand.SQL.Add('            DET_QTDITE,');
  qryComand.SQL.Add('            DET_UNITAR,');
  qryComand.SQL.Add('            DET_UNIORI,');
  qryComand.SQL.Add('            DET_UNIDIG,');
  qryComand.SQL.Add('            DET_TOTITE,');
  qryComand.SQL.Add('            DET_VLRCON,');
  qryComand.SQL.Add('            DET_TOTCUS,');
  qryComand.SQL.Add('            DET_TOTMED,');
  qryComand.SQL.Add('            DET_DESCON,');
  qryComand.SQL.Add('            DET_TOTFRE,');
  qryComand.SQL.Add('            DET_DESESP,');
  qryComand.SQL.Add('            DET_DESACE,');
  qryComand.SQL.Add('            DET_CODREP,');
  qryComand.SQL.Add('            DET_COMREP,');
  qryComand.SQL.Add('            DET_PERREP,');
  qryComand.SQL.Add('            DET_PERCOM,');
  qryComand.SQL.Add('            DET_TOTCOM,');
  qryComand.SQL.Add('            DET_CLAFIS,');
  qryComand.SQL.Add('            DET_CODFIS,');
  qryComand.SQL.Add('            DET_VALIPI,');
  qryComand.SQL.Add('            DET_ALQIPI,');
  qryComand.SQL.Add('            DET_BASIPI,');
  qryComand.SQL.Add('            DET_VALICM,');
  qryComand.SQL.Add('            DET_ALQICM,');
  qryComand.SQL.Add('            DET_BASICM,');
  qryComand.SQL.Add('            DET_VALRET,');
  qryComand.SQL.Add('            DET_ALQRET,');
  qryComand.SQL.Add('            DET_BASRET,');
  qryComand.SQL.Add('            DET_TOTPES,');
  qryComand.SQL.Add('            DET_PERBAS,');
  qryComand.SQL.Add('            DET_PERRED,');
  qryComand.SQL.Add('            DET_JAFATU,');
  qryComand.SQL.Add('            DET_TIPFAT,');
  qryComand.SQL.Add('            DET_NUMFAT,');
  qryComand.SQL.Add('            DET_DTAFAT,');
  qryComand.SQL.Add('            DET_VENFAT,');
  qryComand.SQL.Add('            DET_CNDFAT,');
  qryComand.SQL.Add('            DET_VALFAT,');
  qryComand.SQL.Add('            DET_IDEPRO,');
  qryComand.SQL.Add('            DET_INCPIS,');
  qryComand.SQL.Add('            DET_NOTESP,');
  qryComand.SQL.Add('            DET_DOCDEV,');
  qryComand.SQL.Add('            DET_ESPDEV,');
  qryComand.SQL.Add('            DET_EMPDEV,');
  qryComand.SQL.Add('            DET_ITETIN,');
  qryComand.SQL.Add('            DET_ITECHA,');
  qryComand.SQL.Add('            DET_DESCOR,');
  qryComand.SQL.Add('            DET_TIPEMB,');
  qryComand.SQL.Add('            DET_QTDEMB,');
  qryComand.SQL.Add('            DET_PREEMB,');
  qryComand.SQL.Add('            DET_TIPPRE,');
  qryComand.SQL.Add('            DET_PRVTIN,');
  qryComand.SQL.Add('            DET_PRCTIN,');
  qryComand.SQL.Add('            DET_FATTIN,');
  qryComand.SQL.Add('            DET_PROEMB,');
  qryComand.SQL.Add('            DET_CODDIG,');
  qryComand.SQL.Add('            DET_CODCND,');
  qryComand.SQL.Add('            DET_CODFPG,');
  qryComand.SQL.Add('            DET_ITEEMB,');
  qryComand.SQL.Add('            DET_LAZQUA,');
  qryComand.SQL.Add('            DET_PROMOC,');
  qryComand.SQL.Add('            DET_CODVE2,');
  qryComand.SQL.Add('            DET_TOTCO2,');
  qryComand.SQL.Add('            DET_SEQTIN,');
  qryComand.SQL.Add('            DET_QTDPUL,');
  qryComand.SQL.Add('            DET_PEDCOM,');
  qryComand.SQL.Add('            DET_ORIDOC,');
  qryComand.SQL.Add('            DET_IMPRES,');
  qryComand.SQL.Add('            DET_QTDROM,');
  qryComand.SQL.Add('            DET_NUM_PD,');
  qryComand.SQL.Add('            DET_ESP_PD,');
  qryComand.SQL.Add('            DET_EMP_PD,');
  qryComand.SQL.Add('            DET_IND_PD,');
  qryComand.SQL.Add('            DET_ORDPRO,');
  qryComand.SQL.Add('            DET_TMPGAR,');
  qryComand.SQL.Add('            DET_DESCFF,');
  qryComand.SQL.Add('            DET_DESNES,');
  qryComand.SQL.Add('            DET_CLIFAT,');
  qryComand.SQL.Add('            DET_EMPFAT,');
  qryComand.SQL.Add('            DET_BCAMIN,');
  qryComand.SQL.Add('            DET_BCACOM,');
  qryComand.SQL.Add('            DET_VOLPRO,');
  qryComand.SQL.Add('            DET_DTABCA,');
  qryComand.SQL.Add('            DET_CODACA,');
  qryComand.SQL.Add('            DET_EMPACA,');
  qryComand.SQL.Add('            DET_QTDENT,');
  qryComand.SQL.Add('            DET_DOCFUT,');
  qryComand.SQL.Add('            DET_ESPFUT,');
  qryComand.SQL.Add('            DET_EMPFUT,');
  qryComand.SQL.Add('            DET_FILKAR,');
  qryComand.SQL.Add('            DET_PROACA,');
  qryComand.SQL.Add('            DET_TABPRE,');
  qryComand.SQL.Add('            DET_EMPCOM,');
  qryComand.SQL.Add('            DET_SEGURO,');
  qryComand.SQL.Add('            DET_LINLIN,');
  qryComand.SQL.Add('            DET_CATALI,');
  qryComand.SQL.Add('            DET_CODDIL,');
  qryComand.SQL.Add('            DET_PORDIL,');
  qryComand.SQL.Add('            DET_DILCON,');
  qryComand.SQL.Add('            DET_PORCAT,');
  qryComand.SQL.Add('            DET_QTDPON,');
  qryComand.SQL.Add('            DET_ENTFUT,');
  qryComand.SQL.Add('            DET_MOTFUT,');
  qryComand.SQL.Add('            DET_DTAFUT,');
  qryComand.SQL.Add('            DET_QTDEFT,');
  qryComand.SQL.Add('            DET_DTAEFT,');
  qryComand.SQL.Add('            DET_TOTCU2,');
  qryComand.SQL.Add('            DET_BAIEMP,');
  qryComand.SQL.Add('            DET_KEY_EP,');
  qryComand.SQL.Add('            DET_NUMLOT,');
  qryComand.SQL.Add('            DET_FUNEXP,');
  qryComand.SQL.Add('            DET_PIGBAS,');
  qryComand.SQL.Add('            DET_BAEIPI,');
  qryComand.SQL.Add('            DET_ALEIPI,');
  qryComand.SQL.Add('            DET_VAEIPI,');
  qryComand.SQL.Add('            DET_EFBAIX,');
  qryComand.SQL.Add('            DET_ALQIVA,');
  qryComand.SQL.Add('            DET_VLIVA0,');
  qryComand.SQL.Add('            DET_VLIVA5,');
  qryComand.SQL.Add('            DET_VIVA10)');
  qryComand.SQL.Add('(SELECT ');
  qryComand.SQL.Add(' "' + strMovGerAutInc + '",  ');                           {DET_SEQGER}
  qryComand.SQL.Add(' "' + strAutIncMovDet + '",  ');                           {AUTOINCREM}
  qryComand.SQL.Add(' FIS_CODEMP,    ');                                        {DET_CODEMP}
  qryComand.SQL.Add(' "' + strLoginUsuarioLogado + '",');                       {DET_CODVEN}
  qryComand.SQL.Add(' ITE_CODITE, ');                                           {DET_CODITE}
  qryComand.SQL.Add(' NULL, ');                                                 {DET_CODDIV}
  qryComand.SQL.Add(' ITE_CODMAR, ');                                           {DET_CODMAR}
  qryComand.SQL.Add(' "'+dbeForCli.Text+'", ');                                 {DET_CODFOR}
  qryComand.SQL.Add(' NULL, ');                                                 {DET_CODCLI}
  qryComand.SQL.Add(' FIS_NUMDOC, ');                                           {DET_NUMDOC}
  qryComand.SQL.Add(' FIS_ESPDOC, ');                                           {DET_ESPDOC}
  qryComand.SQL.Add(' FIS_SERIE_, ');                                           {DET_SERIE_}
  qryComand.SQL.Add(' FIS_DTAENT, ');                                           {DET_DTAENT}
  qryComand.SQL.Add(' "' + FormatDateTime('hh:mm:ss', fNow) + '",');            {DET_HORENT}
  qryComand.SQL.Add(' FIS_DTADOC, ');                                           {DET_DTADOC}
  qryComand.SQL.Add(' "01000", ');                                              {DET_CONPAG}
  qryComand.SQL.Add(' "F", ');                                                  {DET_TIP_FC}
  qryComand.SQL.Add(' "",  ');                                                  {DET_ESTADO}
  qryComand.SQL.Add(' ITE_DESITE, ');                                           {DET_DESCRI}
  qryComand.SQL.Add(' IFNULL(ITE_REFERE, ""), ');                               {DET_REFERE}
  qryComand.SQL.Add(' ITE_CODUNI,  ');                                          {DET_UNIDAD}
  qryComand.SQL.Add(' ITE_CODFOR,  ');                                          {DET_FORITE}
  qryComand.SQL.Add(' 1.00, ');                                                 {DET_QTDITE}
  qryComand.SQL.Add(' FIS_VLCON1, ');                                           {DET_UNITAR}
  qryComand.SQL.Add(' FIS_VLCON1, ');                                           {DET_UNIORI}
  qryComand.SQL.Add(' FIS_VLCON1, ');                                           {DET_UNIDIG}
  qryComand.SQL.Add(' FIS_VLCON1, ');                                           {DET_TOTITE}
  qryComand.SQL.Add(' FIS_VLCON1, ');                                           {DET_VLRCON}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTCUS}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTMED}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_DESCON}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTFRE}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_DESESP}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_DESACE}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_CODREP}
  qryComand.SQL.Add(' 0.00, ');                                                 {DET_COMREP}
  qryComand.SQL.Add(' 0.00, ');                                                 {DET_PERREP}
  qryComand.SQL.Add(' 0.00, ');                                                 {DET_PERCOM}
  qryComand.SQL.Add(' 0.00, ');                                                 {DET_TOTCOM}
  qryComand.SQL.Add(' FIS_CLFSC1, ');                                           {DET_CLAFIS}
  qryComand.SQL.Add(' "090",      ');                                           {DET_CODFIS}
  qryComand.SQL.Add(' IFNULL(FIS_VLRIP1, 0.00),      ');                        {DET_VALIPI}
  qryComand.SQL.Add(' IF(IFNULL(FIS_BASIP1, 0.00) > 0.00, (FIS_BASIP1 / FIS_VLRIP1), 0.00), '); {DET_ALQIPI}
  qryComand.SQL.Add(' IFNULL(FIS_BASIP1, 0.00),     ');                         {DET_BASIPI}
  qryComand.SQL.Add(' IFNULL(FIS_VLRIC1, 0.00),     ');                         {DET_VALICM}
  qryComand.SQL.Add(' IFNULL(FIS_ALQIC1, 0.00),     ');                         {DET_ALQICM}
  qryComand.SQL.Add(' IFNULL(FIS_BASIC1, 0.00),     ');                         {DET_BASICM}
  qryComand.SQL.Add(' IFNULL(FIS_RETID1, 0.00),     ');                         {DET_VALRET}
  qryComand.SQL.Add(' IF(IFNULL(FIS_BCRET1, 0.00) > 0.00, (FIS_BCRET1 / FIS_RETID1), 0.00), '); {DET_ALQRET}
  qryComand.SQL.Add(' IFNULL(FIS_BCRET1, 0.00),      ');                         {DET_BASRET}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTPES}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_PERBAS}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_PERRED}
  qryComand.SQL.Add(' 0,         ');                                            {DET_JAFATU}
  qryComand.SQL.Add(' "",        ');                                            {DET_TIPFAT}
  qryComand.SQL.Add(' "",        ');                                            {DET_NUMFAT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_DTAFAT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_VENFAT}
  qryComand.SQL.Add(' "",        ');                                            {DET_CNDFAT}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_VALFAT}
  qryComand.SQL.Add(' "NOR",     ');                                            {DET_IDEPRO}
  qryComand.SQL.Add(' "S",       ');                                            {DET_INCPIS}
  qryComand.SQL.Add(' "N",       ');                                            {DET_NOTESP}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_DOCDEV}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_ESPDEV}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_EMPDEV}
  qryComand.SQL.Add(' "",        ');                                            {DET_ITETIN}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_ITECHA}
  qryComand.SQL.Add(' "",        ');                                            {DET_DESCOR}
  qryComand.SQL.Add(' "",        ');                                            {DET_TIPEMB}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_QTDEMB}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_PREEMB}
  qryComand.SQL.Add(' "",        ');                                            {DET_TIPPRE}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_PRVTIN}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_PRCTIN}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_FATTIN}
  qryComand.SQL.Add(' "",        ');                                            {DET_PROEMB}
  qryComand.SQL.Add('  "'+strLoginUsuarioLogado+'",');                          {DET_CODDIG}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_CODCND}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_CODFPG}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_ITEEMB}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_LAZQUA}
  qryComand.SQL.Add(' "N",       ');                                            {DET_PROMOC}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_CODVE2}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTCO2}
  qryComand.SQL.Add(' "",        ');                                            {DET_SEQTIN}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_QTDPUL}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_PEDCOM}
  qryComand.SQL.Add(' FIS_ORIDOC, ');                                           {DET_ORIDOC}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_IMPRES}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_QTDROM}
  qryComand.SQL.Add(' "",        ');                                            {DET_NUM_PD}
  qryComand.SQL.Add(' "",        ');                                            {DET_ESP_PD}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_EMP_PD}
  qryComand.SQL.Add(' 0,         ');                                            {DET_IND_PD}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_ORDPRO}
  qryComand.SQL.Add(' 0,         ');                                            {DET_TMPGAR}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_DESCFF}
  qryComand.SQL.Add(' "",        ');                                            {DET_DESNES}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_CLIFAT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_EMPFAT}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_BCAMIN}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_BCACOM}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_VOLPRO}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_DTABCA}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_CODACA}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_EMPACA}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_QTDENT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_DOCFUT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_ESPFUT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_EMPFUT}
  qryComand.SQL.Add(' 1   ,      ');                                            {DET_FILKAR}
  qryComand.SQL.Add(' "N",       ');                                            {DET_PROACA}
  qryComand.SQL.Add(' "",        ');                                            {DET_TABPRE}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_EMPCOM}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_SEGURO}
  qryComand.SQL.Add(' "",        ');                                            {DET_LINLIN}
  qryComand.SQL.Add(' "",        ');                                            {DET_CATALI}
  qryComand.SQL.Add(' "",        ');                                            {DET_CODDIL}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_PORDIL}
  qryComand.SQL.Add(' "",        ');                                            {DET_DILCON}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_PORCAT}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_QTDPON}
  qryComand.SQL.Add(' "N",       ');                                            {DET_ENTFUT}
  qryComand.SQL.Add(' "",        ');                                            {DET_MOTFUT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_DTAFUT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_QTDEFT}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_DTAEFT}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_TOTCU2}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_BAIEMP}
  qryComand.SQL.Add(' "",        ');                                            {DET_KEY_EP}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_NUMLOT}
  qryComand.SQL.Add(' "N",       ');                                            {DET_FUNEXP}
  qryComand.SQL.Add(' "N",       ');                                            {DET_PIGBAS}
  qryComand.SQL.Add(' IFNULL(FIS_BAEIP1, 0.00),      ');                        {DET_BAEIPI}
  qryComand.SQL.Add(' IF(IFNULL(FIS_BAEIP1, 0.00) > 0.00, (FIS_BAEIP1 / FIS_VAEIP1), 0.00), '); {DET_ALEIPI}
  qryComand.SQL.Add(' IFNULL(FIS_VAEIP1, 0.00),      ');                        {DET_VAEIPI}
  qryComand.SQL.Add(' "N",       ');                                            {DET_EFBAIX}
  qryComand.SQL.Add(' NULL,      ');                                            {DET_ALQIVA}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_VLIVA0}
  qryComand.SQL.Add(' 0.00,      ');                                            {DET_VLIVA5}
  qryComand.SQL.Add(' 0.00      ');                                             {DET_VIVA10}

  qryComand.SQL.Add('  FROM CADFIS ');
  qryComand.SQL.Add('  LEFT JOIN CADITE ON ITE_CODITE = "' + fCfgSis('ITESER') + '"');
  qryComand.SQL.Add(' WHERE CADFIS.FIS_NUMDOC = "'+dbeNumDoc.Text+'" ');
  qryComand.SQL.Add('   AND CADFIS.FIS_ESPDOC = "'+dbeEspDoc.Text+'" ');
  qryComand.SQL.Add('   AND CADFIS.FIS_CODEMP = "'+dbeCodEmp.Text+'" ');
  qryComand.SQL.Add('   AND CADFIS.FIS_FORCLI = "'+dbeForCli.Text+'" ');
  qryComand.SQL.Add('   AND IFNULL(CADFIS.FIS_SERIE_, "") = "'+dbeNfComp.Text+'");');

  qryComand.SQL.Add(' INSERT INTO MOVTRI ( ');
  qryComand.SQL.Add(' DET_SEQGER,  ');
  qryComand.SQL.Add(' DET_CSTPIS,  ');
  qryComand.SQL.Add(' DET_BASPIS,  ');
  qryComand.SQL.Add(' DET_ALQPIS,  ');
  qryComand.SQL.Add(' DET_VALPIS,  ');
  qryComand.SQL.Add(' DET_NR_PIS,  ');
  qryComand.SQL.Add(' DET_CSTCOF,  ');
  qryComand.SQL.Add(' DET_BASCOF,  ');
  qryComand.SQL.Add(' DET_ALQCOF,  ');
  qryComand.SQL.Add(' DET_VALCOF,  ');
  qryComand.SQL.Add(' DET_NR_COF,  ');
  qryComand.SQL.Add(' DET_OUTICM,  ');
  qryComand.SQL.Add(' DET_ISEICM,  ');
  qryComand.SQL.Add(' DET_VAERET,  ');
  qryComand.SQL.Add(' DET_ALERET,  ');
  qryComand.SQL.Add(' DET_BAERET,  ');
  qryComand.SQL.Add(' DET_NATOPE   ');
  qryComand.SQL.Add(' ) ');
  qryComand.SQL.Add(' (SELECT      ');
  qryComand.SQL.Add(' "' + strAutIncMovDet + '",  ');                            {DET_SEQGER}
  qryComand.SQL.Add(' FIS_CSTPIS, ');                                            {DET_CSTPIS}
  qryComand.SQL.Add(' FIS_BASPIS, ');                                            {DET_BASPIS}
  qryComand.SQL.Add(' FIS_ALQPIS, ');                                            {DET_ALQPIS}
  qryComand.SQL.Add(' FIS_TOTPIS, ');                                            {DET_VALPIS}
  qryComand.SQL.Add(' FIS_NR_PIS, ');                                            {DET_NR_PIS}
  qryComand.SQL.Add(' FIS_CSTCOF, ');                                            {DET_CSTCOF}
  qryComand.SQL.Add(' FIS_BASCOF, ');                                            {DET_BASCOF}
  qryComand.SQL.Add(' FIS_ALQCOF, ');                                            {DET_ALQCOF}
  qryComand.SQL.Add(' FIS_TOTCOF, ');                                            {DET_VALCOF}
  qryComand.SQL.Add(' FIS_NR_COF, ');                                            {DET_NR_COF}
  qryComand.SQL.Add(' IFNULL(FIS_OUTRA1, 0.00), ');                              {DET_OUTICM}
  qryComand.SQL.Add(' IFNULL(FIS_ISENT1, 0.00), ');                              {DET_ISEICM}
  qryComand.SQL.Add(' IFNULL(FIS_VAERE1, 0.00), ');                              {DET_VAERET}
  qryComand.SQL.Add(' IF(IFNULL(FIS_BAERE1, 0.00) > 0.00 AND IFNULL(FIS_VAERE1, 0.00) > 0.00, ((FIS_VAERE1 * 100) / FIS_BAERE1), 0.00), ');{DET_ALERET}
  qryComand.SQL.Add(' IFNULL(FIS_BAERE1, 0.00), ');                              {DET_BAERET}
  qryComand.SQL.Add(' FIS_NATOPE ');                                             {DET_NATOPE}
  qryComand.SQL.Add('  FROM CADFIS ');
  qryComand.SQL.Add(' WHERE CADFIS.FIS_NUMDOC = "'+dbeNumDoc.Text+'" ');
  qryComand.SQL.Add('   AND CADFIS.FIS_ESPDOC = "'+dbeEspDoc.Text+'" ');
  qryComand.SQL.Add('   AND CADFIS.FIS_CODEMP = "'+dbeCodEmp.Text+'" ');
  qryComand.SQL.Add('   AND CADFIS.FIS_FORCLI = "'+dbeForCli.Text+'" ');
  qryComand.SQL.Add('   AND IFNULL(CADFIS.FIS_SERIE_, "") = "'+dbeNfComp.Text+'");');
End;

procedure TfrmCadLivroFiscal.pAtualizaLabelCfopInvalida;
  Var
    intCont: Integer;
    strCfop: String;
begin
  lblWarningCfopInvalida.Visible := False;

  For intCont := 1 to 5 Do
  Begin
    strCfop := TDBEdit(fComponentByName(tbsDocs, 'dbeClfSc' + IntToStr(intCont))).Text;
    Try
      If Not (fEmptyStr(strCfop)) Then
        pVerificaCfopCorreta(strCfop);
    Except
      lblWarningCfopInvalida.Visible := True;
      fMensagem('ATENÇÃO!', lblWarningCfopInvalida.Caption, ['&Ok']);
    End;
  End;
end;

procedure TfrmCadLivroFiscal.pAtualizaPrecoCustoReal(strAutIncMovDet: string);
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' UPDATE MOVDET A, MOVTRI B ');
    qryAux.SQL.Add('    SET A.DET_TOTCU2 = A.DET_TOTCUS + B.DET_IMPFED + B.DET_OUTVAL + B.DET_DESOPE + B.DET_ICMSAI + :VALFCP + :VDIFAL ');
    qryAux.SQL.Add('  WHERE A.AUTOINCREM = B.DET_SEQGER ');
    qryAux.SQL.Add('    AND A.AUTOINCREM = :AUTINC ');
    qryAux.ParamByName('AUTINC').AsString := strAutIncMovDet;
    qryAux.ParamByName('VALFCP').AsFloat := fCampoTabela('ICD_VALFCP', 'MOVICD', ['ICD_SEQGER'], [strAutIncMovDet]);
    qryAux.ParamByName('VDIFAL').AsFloat := fCampoTabela('ICD_VALDES', 'MOVICD', ['ICD_SEQGER'], [strAutIncMovDet]);
    qryAux.ExecSQL;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TfrmCadLivroFiscal.pAtualizaDadosPisCofins(strAutInc: String);
  Var
    qryAux: TUniQuery;
    strTab: String;
begin
  strTab := IIF(strTabela = 'MOVDET', 'MOVTRI', 'NOTTRI');

  qryAux := fCriaQuery(Self);

  If (fTemMovTri(strTab, strAutInc)) Then
  Begin
    qryAux.SQL.Add('UPDATE ' + strTab + ' ');
    qryAux.SQL.Add('SET ');
    qryAux.SQL.Add('  DET_BAEIPI = :BAEIPI, ');
    qryAux.SQL.Add('  DET_ALEIPI = :ALEIPI, ');
    qryAux.SQL.Add('  DET_VAEIPI = :VAEIPI, ');
    qryAux.SQL.Add('  DET_CSTIPI = :CSTIPI, ');
    qryAux.SQL.Add('  DET_VAERET = :VAERET, ');
    qryAux.SQL.Add('  DET_BAERET = :BAERET, ');
    qryAux.SQL.Add('  DET_OUTICM = :OUTICM, ');
    qryAux.SQL.Add('  DET_ISEICM = :ISEICM, ');
    qryAux.SQL.Add('  DET_CSTPIS = :CSTPIS, ');
    qryAux.SQL.Add('  DET_BASPIS = :BASPIS, ');
    qryAux.SQL.Add('  DET_ALQPIS = :ALQPIS, ');
    qryAux.SQL.Add('  DET_VALPIS = :VALPIS, ');
    qryAux.SQL.Add('  DET_NR_PIS = :NR_PIS, ');
    qryAux.SQL.Add('  DET_CSTCOF = :CSTCOF, ');
    qryAux.SQL.Add('  DET_BASCOF = :BASCOF, ');
    qryAux.SQL.Add('  DET_ALQCOF = :ALQCOF, ');
    qryAux.SQL.Add('  DET_VALCOF = :VALCOF, ');
    qryAux.SQL.Add('  DET_VICMDE = :VICMDE, ');
    qryAux.SQL.Add('  DET_NR_COF = :NR_COF, ');
    qryAux.SQL.Add('  DET_BFCPST = :BFCPST, ');
    qryAux.SQL.Add('  DET_PFCPST = :PFCPST, ');
    qryAux.SQL.Add('  DET_VFCPST = :VFCPST, ');
    qryAux.SQL.Add('  DET_NCMITE = :NCMITE ');
    qryAux.SQL.Add('WHERE ');
    qryAux.SQL.Add('  DET_SEQGER = :AUTINC ');
  End
  Else
  Begin
    qryAux.SQL.Add('INSERT INTO ' + strTab + '(');
    qryAux.SQL.Add('  DET_CSTIPI, ');
    qryAux.SQL.Add('  DET_BAEIPI, ');
    qryAux.SQL.Add('  DET_ALEIPI, ');
    qryAux.SQL.Add('  DET_VAEIPI, ');
    qryAux.SQL.Add('  DET_VAERET, ');
    qryAux.SQL.Add('  DET_BAERET, ');
    qryAux.SQL.Add('  DET_OUTICM, ');
    qryAux.SQL.Add('  DET_ISEICM, ');
    qryAux.SQL.Add('  DET_CSTPIS, ');
    qryAux.SQL.Add('  DET_BASPIS, ');
    qryAux.SQL.Add('  DET_ALQPIS, ');
    qryAux.SQL.Add('  DET_VALPIS, ');
    qryAux.SQL.Add('  DET_NR_PIS, ');
    qryAux.SQL.Add('  DET_CSTCOF, ');
    qryAux.SQL.Add('  DET_BASCOF, ');
    qryAux.SQL.Add('  DET_ALQCOF, ');
    qryAux.SQL.Add('  DET_VALCOF, ');
    qryAux.SQL.Add('  DET_NR_COF, ');
    qryAux.SQL.Add('  DET_VICMDE, ');
    qryAux.SQL.Add('  DET_BFCPST, ');
    qryAux.SQL.Add('  DET_PFCPST, ');
    qryAux.SQL.Add('  DET_VFCPST, ');
    qryAux.SQL.Add('  DET_NCMITE, ');
    qryAux.SQL.Add('  DET_SEQGER) ');
    qryAux.SQL.Add('VALUES ( ');
    qryAux.SQL.Add('  :CSTIPI, ');
    qryAux.SQL.Add('  :BAEIPI, ');
    qryAux.SQL.Add('  :ALEIPI, ');
    qryAux.SQL.Add('  :VAEIPI, ');
    qryAux.SQL.Add('  :VAERET, ');
    qryAux.SQL.Add('  :BAERET, ');
    qryAux.SQL.Add('  :OUTICM, ');
    qryAux.SQL.Add('  :ISEICM, ');
    qryAux.SQL.Add('  :CSTPIS, ');
    qryAux.SQL.Add('  :BASPIS, ');
    qryAux.SQL.Add('  :ALQPIS, ');
    qryAux.SQL.Add('  :VALPIS, ');
    qryAux.SQL.Add('  :NR_PIS, ');
    qryAux.SQL.Add('  :CSTCOF, ');
    qryAux.SQL.Add('  :BASCOF, ');
    qryAux.SQL.Add('  :ALQCOF, ');
    qryAux.SQL.Add('  :VALCOF, ');
    qryAux.SQL.Add('  :NR_COF, ');
    qryAux.SQL.Add('  :VICMDE,');
    qryAux.SQL.Add('  :BFCPST, ');
    qryAux.SQL.Add('  :PFCPST, ');
    qryAux.SQL.Add('  :VFCPST, ');
    qryAux.SQL.Add('  :NCMITE, ');

    qryAux.SQL.Add('  :AUTINC) ');
  End;

  qryAux.ParamByName('CSTIPI').AsString  := dbeCSTIpi.Text;
  qryAux.ParamByName('BAEIPI').AsFloat  := fStrToFloat(dbeBaeIpi.Text);
  qryAux.ParamByName('ALEIPI').AsFloat  := fStrToFloat(dbeAleIpi.Text);
  qryAux.ParamByName('VAEIPI').AsFloat  := fStrToFloat(dbeVaeIpi.Text);

  qryAux.ParamByName('VAERET').AsFloat  := fStrToFloat(dbeVRetNC.Text);
  qryAux.ParamByName('BAERET').AsFloat  := fStrToFloat(dbeBRetNC.Text);

  qryAux.ParamByName('OUTICM').AsFloat  := fStrToFloat(dbeOutras.Text);
  qryAux.ParamByName('ISEICM').AsFloat  := fStrToFloat(dbeIsenta.Text);

  qryAux.ParamByName('CSTPIS').AsString := edtIteCstPis.Text;
  qryAux.ParamByName('BASPIS').AsFloat  := fStrToFloat(edtIteBasPis.Text);
  qryAux.ParamByName('ALQPIS').AsFloat  := fStrToFloat(edtIteAlqPis.Text);
  qryAux.ParamByName('VALPIS').AsFloat  := fStrToFloat(edtIteValPis.Text);
  qryAux.ParamByName('NR_PIS').AsString := edtIteNatRecPis.Text;

  qryAux.ParamByName('CSTCOF').AsString := edtIteCstCof.Text;
  qryAux.ParamByName('BASCOF').AsFloat  := fStrToFloat(edtIteBasCof.Text);
  qryAux.ParamByName('ALQCOF').AsFloat  := fStrToFloat(edtIteAlqCof.Text);
  qryAux.ParamByName('VALCOF').AsFloat  := fStrToFloat(edtIteValCof.Text);
  qryAux.ParamByName('NR_COF').AsString := edtIteNatRecCof.Text;
  qryAux.ParamByName('VICMDE').AsFloat  := fStrToFloat(dbeVICMDE.Text);
  qryAux.ParamByName('BFCPST').AsFloat  := fStrToFloat(edtBFCPST.Text);
  qryAux.ParamByName('PFCPST').AsFloat  := fStrToFloat(edtPFCPST.Text);
  qryAux.ParamByName('VFCPST').AsFloat  := fStrToFloat(edtVFCPST.Text);
  qryAux.ParamByName('NCMITE').AsString  := dbeNcmIte.Text;

  qryAux.ParamByName('AUTINC').AsString := strAutInc;

  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

procedure TfrmCadLivroFiscal.pAtualizaDataMovDetMovGer;
  Var
    qryUpdate: TUniQuery;
begin

  qryUpdate := fCriaQuery;
  Try
    Try
      qryUpdate.SQL.Add('UPDATE MOVDET');
      qryUpdate.SQL.Add('   SET DET_DTADOC = :DATA ');
      qryUpdate.SQL.Add(' WHERE DET_NUMDOC = :NUMDOC ');
      qryUpdate.SQL.Add('   AND DET_ESPDOC = :ESPDOC ');

      If (qryTabela.FieldByName('FIS_TIP_FC').AsString = 'C') Then
        qryUpdate.SQL.Add(' AND DET_CODCLI = :FORCLI')
      Else
        qryUpdate.SQL.Add(' AND DET_CODFOR = :FORCLI');

      qryUpdate.SQL.Add('   AND DET_CODEMP = :CODEMP ');
      qryUpdate.SQL.Add('   AND DET_TIP_FC = :TIP_FC ');
      qryUpdate.SQL.Add('   AND IFNULL(DET_SERIE_, "") = :SERIE_ ');

      qryUpdate.ParamByName('DATA').AsDateTime := qryTabela.FieldByName('FIS_DTADOC').AsDateTime;
      qryUpdate.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
      qryUpdate.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
      qryUpdate.ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
      qryUpdate.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
      qryUpdate.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
      qryUpdate.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
      qryUpdate.ExecSQL;
    Except
      On E: ExceptionAutCom Do
      Begin
        pMensagemOk(E.Message);
      End;

      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmCadLivroFiscal.btnGravarClick]');
      End;
    End;

    Try
      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add(' UPDATE AUXMOV A ');
      qryUpdate.SQL.Add('    JOIN MOVGER M ON GER_NUMDOC = :NUMDOC AND ');
      qryUpdate.SQL.Add('      GER_ESPDOC = :ESPDOC AND ');

      If (qryTabela.FieldByName('FIS_TIP_FC').AsString = 'C') Then
        qryUpdate.SQL.Add(' GER_CODCLI = :FORCLI AND ')
      Else
        qryUpdate.SQL.Add(' GER_CODFOR = :FORCLI AND ');

      qryUpdate.SQL.Add('      GER_CODEMP = :CODEMP AND ');
      qryUpdate.SQL.Add('      GER_TIP_FC = :TIP_FC AND ');
      qryUpdate.SQL.Add('      IFNULL(GER_SERIE_, "") = :SERIE_ ');
      qryUpdate.SQL.Add('    LEFT OUTER JOIN NATCFO N ON NAT_CODCFO = :CODCFO AND NAT_DESCRI = :DESCFO ');
      qryUpdate.SQL.Add('  SET A.AUX_NATCFO = N.AUTOINCREM ');
      qryUpdate.SQL.Add(' WHERE A.AUX_SEQGER = M.AUTOINCREM ');

      qryUpdate.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
      qryUpdate.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
      qryUpdate.ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
      qryUpdate.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
      qryUpdate.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
      qryUpdate.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
      qryUpdate.ParamByName('CODCFO').AsString := dbeNatCfo.Text;
      qryUpdate.ParamByName('DESCFO').AsString := cmbNatOpe.Text;
      qryUpdate.ExecSQL;
    Except
      On E: ExceptionAutCom Do
      Begin
        pMensagemOk(E.Message);
      End;

      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmCadLivroFiscal.btnGravarClick]');
      End;
    End;


    Try
      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add('UPDATE MOVGER');
      qryUpdate.SQL.Add('   SET GER_DTADOC = :DATA, ');
      qryUpdate.SQL.Add('       GER_CLAFIS = :CLAF, ');
      qryUpdate.SQL.Add('       GER_NATOPE = :NATO  ');
      qryUpdate.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC ');
      qryUpdate.SQL.Add('   AND GER_ESPDOC = :ESPDOC ');

      If (qryTabela.FieldByName('FIS_TIP_FC').AsString = 'C') Then
        qryUpdate.SQL.Add(' AND GER_CODCLI = :FORCLI ')
      Else
        qryUpdate.SQL.Add(' AND GER_CODFOR = :FORCLI ');

      qryUpdate.SQL.Add('   AND GER_CODEMP = :CODEMP ');
      qryUpdate.SQL.Add('   AND GER_TIP_FC = :TIP_FC ');
      qryUpdate.SQL.Add('   AND IFNULL(GER_SERIE_, "") = :SERIE_ ');

      qryUpdate.ParamByName('DATA').AsDate := qryTabela.FieldByName('FIS_DTADOC').AsDateTime;
      qryUpdate.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
      qryUpdate.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
      qryUpdate.ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
      qryUpdate.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
      qryUpdate.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
      qryUpdate.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
      qryUpdate.ParamByName('CLAF').AsString := dbeNatCfo.Text;
      qryUpdate.ParamByName('NATO').AsString := cmbNatOpe.Text;


      qryUpdate.ExecSQL;
    Except
      On E: ExceptionAutCom Do
      Begin
        pMensagemOk(E.Message);
      End;

      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[TfrmCadLivroFiscal.btnGravarClick]');
      End;
    End;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

function TfrmCadLivroFiscal.fTemMovTri(strTabela, strAutInc: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT COUNT(*) AS QTD FROM ' + strTabela + ' WHERE DET_SEQGER = :SEQGER');
  qryAux.ParamByName('SEQGER').AsString := strAutInc;
  qryAux.Open;

  Result := (qryAux.FieldByName('QTD').AsInteger > 0);

  FreeAndNil(qryAux);
end;

procedure TfrmCadLivroFiscal.dbgDomAcuKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) Then
  Begin
    If (cdsDomAcu.IsEmpty) Then
      Exit;

    cdsDomAcu.Delete;
  End
  Else If (Key = VK_ESCAPE) Then
  Begin
    pLimpaCamposDominioAcumulador;
  End;
end;

procedure TfrmCadLivroFiscal.dtsFisAjuDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  edtDesAju.Text := qryFisAju.FieldByName('AJU_DESAJU').AsString;
end;

procedure TfrmCadLivroFiscal.dtsTabelaDataChange(Sender: TObject; Field: TField);
begin
  pSincronizarAuxFis;
end;

procedure TfrmCadLivroFiscal.dtsFisItensDataChange(Sender: TObject;
  Field: TField);
//var
  //blnState: Boolean;
begin
  inherited;
  {//tabela de itens ativa
  blnState := (dtsFisItens.DataSet.State in ([dsBrowse, dsInsert, dsEdit]));

  //se a tabela estiver inativa mostra os campos de CST Pis e Cofins e não entra na condição abaixo
  If blnState Then
  Begin
    //caso contenha item não mostrará as Cst's
    blnState := dtsFisItens.DataSet.IsEmpty;
  End;

  labelCstPis.Visible    := blnState;
  labelCstCofins.Visible := blnState;
  dbeCstPis.Visible      := blnState;
  dbeCstCof.Visible      := blnState;}
end;

procedure TfrmCadLivroFiscal.edtAlqIcmExit(Sender: TObject);
begin
  inherited;
  edtBasIcmExit(Sender);
//  pSetFocus(edtOutros);
end;

procedure TfrmCadLivroFiscal.edtAlqInterestadualExit(Sender: TObject);
begin
  inherited;
  pCalcularValoresUFDest;
end;

procedure TfrmCadLivroFiscal.edtAlqInternaExit(Sender: TObject);
begin
  inherited;
  pCalcularValoresUFDest;
end;

procedure TfrmCadLivroFiscal.edtBaseUFDestExit(Sender: TObject);
begin
  inherited;
  edtPercFCPExit(Sender);
  pCalcularValoresUFDest;
end;

procedure TfrmCadLivroFiscal.edtBasIcmExit(Sender: TObject);
begin
  inherited;
  edtValIcm.Text := FloatToStrF(((fStrToFloat(edtBasIcm.Text) * fStrToFloat(edtAlqIcm.Text)) / 100), ffNumber, 12, 2);
  qryFisAjuAJU_VALICM.AsFloat := fStrToFloat(edtValIcm.Text);
end;

procedure TfrmCadLivroFiscal.edtCodAjuExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodAju, edtDesAju, arrAju, fRetDesAjuIcm, Nil, 'do ajuste');
  qryFisAju.FieldByName('AJU_DESAJU').AsString := edtDesAju.Text;
end;

procedure TfrmCadLivroFiscal.edtCodAjuKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqAju(Self, edtCodAju, edtDesAju, nil, Key, arrAju) Then
  Begin
    If fValidaCampos(edtCodAju, False) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadLivroFiscal.edtIteCstCofKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;

  fPesqCSTCof(Self, edtIteCstCof, Nil, Nil, Key, arrSel);
end;

procedure TfrmCadLivroFiscal.edtIteCstPisKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  fPesqCSTPis(Self, edtIteCstPis, Nil, Nil, Key, arrSel);
end;

procedure TfrmCadLivroFiscal.edtOutrosExit(Sender: TObject);
begin
  inherited;
  pSetFocus(btnGravarFisAju);
end;

procedure TfrmCadLivroFiscal.edtPerAcuExit(Sender: TObject);
begin
  Try
    edtPerAcu.Text := Formatfloat('0.00', fStrToFloat(edtPerAcu.Text));
  Except

  End;
  inherited;
end;

procedure TfrmCadLivroFiscal.edtPercFCPExit(Sender: TObject);
begin
  inherited;
  edtValorFCP.Text := FloatToStrF(((fStrToFloat(edtBaseFCP.Text) * fStrToFloat(edtPercFCP.Text)) / 100), ffNumber, 12, 2);
end;

procedure TfrmCadLivroFiscal.edtPFCPSTExit(Sender: TObject);
begin
  inherited;
  edtVFCPST.Text := FloatToStrF(((fStrToFloat(edtBFCPST.Text) * fStrToFloat(edtPFCPST.Text)) / 100), ffNumber, 12, 2);
end;

procedure TfrmCadLivroFiscal.edtValIcmEnter(Sender: TObject);
begin
  inherited;
//  pSetFocus(edtOutros);
end;

procedure TfrmCadLivroFiscal.edtVlrIcmTotChange(Sender: TObject);
begin
  inherited;
  If (dbeEspDoc.Text = 'CT') And fCfgSis('DEIPCT', varBoolean) And (qryTabela.State in dsEditModes)  Then
  Begin
    pCarregaPisCofins(qryTabela.FieldByName('FIS_CLFSC1').AsString, qryTabela.FieldByName('FIS_CSTPIS').AsString, qryTabela.FieldByName('FIS_CSTCOF').AsString);
  End;
end;

function TfrmCadLivroFiscal.fAplicaReducaoICMS(blnReduz: Boolean): Boolean;
begin
  Result := (blnReduz) and
            (fDentroDoEstado(strEstado, VS_StrCodEmp)) and
            (fCfgSis('RICMPR',varBoolean)) and
            (not fEhClienteConsumidor(dbeTip_Fc.Text, dbeForCli.Text)) and
            ((not fEmptyStr(fBuscaInscricaoEstadual(dbeTip_Fc.Text, dbeForCli.Text))) or fEhMicroEmpresa(dbeTip_Fc.Text, dbeForCli.Text)) and
            (Pos(dbeCodFis.Text, '040_041_') <= 0);
end;

procedure TfrmCadLivroFiscal.fAtualizaDadosCtpNotEnt(strNovaSerie: String; strNotTip: String; strAutInc: String = '';
                                                     strNovoFornecedor: String = ''; strNovaEspecie: String = '');
var
  qryGen: TUniQuery;
  qryUpdate: TUniQuery;
  strNotEntAnt,
  strNotEntAtu: String;
begin
  qryGen:= fCriaQuery();
  qryUpdate := fCriaQuery();
  Try

   strNotEntAnt:=qryTabela.FieldByName('FIS_NUMDOC').AsString +
                 qryTabela.FieldByName('FIS_ESPDOC').AsString +
                 qryTabela.FieldByName('FIS_CODEMP').AsString +
                 fstrEspaco(qryTabela.FieldByName('FIS_SERIE_').AsString, 3) +
                 qryTabela.FieldByName('FIS_FORCLI').AsString;

   If Not(fEmptyStr(strNovaSerie)) Then
   Begin
     strNotEntAtu:=qryTabela.FieldByName('FIS_NUMDOC').AsString +
                   qryTabela.FieldByName('FIS_ESPDOC').AsString +
                   qryTabela.FieldByName('FIS_CODEMP').AsString +
                   fstrEspaco(strNovaSerie, 3) +
                   qryTabela.FieldByName('FIS_FORCLI').AsString;
   End
   Else
   If Not(fEmptyStr(strNovoFornecedor)) Then
   Begin
     strNotEntAtu:=qryTabela.FieldByName('FIS_NUMDOC').AsString +
                   qryTabela.FieldByName('FIS_ESPDOC').AsString +
                   qryTabela.FieldByName('FIS_CODEMP').AsString +
                   fstrEspaco(qryTabela.FieldByName('FIS_SERIE_').AsString, 3) +
                   strNovoFornecedor;
   End
   Else
   If Not(fEmptyStr(strNovaEspecie)) Then
   Begin
     strNotEntAtu:=qryTabela.FieldByName('FIS_NUMDOC').AsString +
                   strNovaEspecie +
                   qryTabela.FieldByName('FIS_CODEMP').AsString +
                   fstrEspaco(qryTabela.FieldByName('FIS_SERIE_').AsString, 3) +
                   qryTabela.FieldByName('FIS_FORCLI').AsString;
   End;


    If strNotTip = '03' Then
    Begin

      qryUpdate.Close;
      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add('UPDATE CADPAG SET CTP_NOTENT = "'+strNotEntAtu+'" ');
      qryUpdate.SQL.Add('WHERE CTP_NOTENT = "'+strNotEntAnt+'" AND CTP_NOTTIP = "03"');
      qryUpdate.ExecSQL;

    End
    Else
    Begin

      qryUpdate.Close;
      qryUpdate.SQL.Clear;
      qryUpdate.SQL.Add('UPDATE CADPAG SET CTP_NOTENT = "'+strNotEntAtu+'" ');
      qryUpdate.SQL.Add('WHERE CTP_NOTENT  = "'+strNotEntAnt+'" ');
      If Not(fEmptyStr(strAutInc)) Then
        qryUpdate.SQL.Add('  AND AUTOINCREM = "'+strAutInc+'" ');
      qryUpdate.ExecSQL;

    End;

  Finally
    FreeAndNil(qryGen);
    FreeAndNil(qryUpdate);
  End;
end;


function TfrmCadLivroFiscal.fBuscaInscricaoEstadual(strTipCli,
  strCodCli: string): string;
var
  qryConsulta: TUniQuery;
begin
  Result := EmptyStr;
  qryConsulta := fCriaQuery();

  try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;

    if strTipCli = 'C' then
    begin
      qryConsulta.SQL.Add('SELECT CLI_I_E_S_ AS I_E_S_ FROM CADCLI WHERE CLI_CODCLI = :CODCLI');
    end
    else if strTipCli = 'F' then
    begin
      qryConsulta.SQL.Add('SELECT FOR_I_E_S_ AS I_E_S_ FROM CADFOR WHERE FOR_CODFOR = :CODCLI');
    end;

    qryConsulta.ParamByName('CODCLI').AsString := strCodCli;
    qryConsulta.Open;

    if not qryConsulta.IsEmpty then
    begin
      Result := qryConsulta.FieldByName('I_E_S_').AsString;
    end;
  finally
    FreeAndNil(qryConsulta);
  end;

end;

function TfrmCadLivroFiscal.fBuscaParcela(intContParcela: integer): string;
const
  arrParcelas: Array[1..26] of string = ('A','B','C','D','E','F','G','H','I','J','K',
                                         'L','M','N','O','P','Q','R','S','T','U','V',
                                         'W','X','Y','Z');
begin
  Result := arrParcelas[intContParcela + 1];
end;

function TfrmCadLivroFiscal.fCidadeMovGer(strNumDoc, strEspDoc, strCodEmp,
  strCodCli, strSerie: String): String;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  GER_CIDCON ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  MOVGER ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  GER_CODCLI = :CODCLI AND ');
  qryAux.SQL.Add('  IFNULL(GER_SERIE_,"") = :SERIE_ ');

  qryAux.SQL.Add('  UNION ALL ');

  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  GER_CIDCON ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  NOTGER ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  GER_CODCLI = :CODCLI AND ');
  qryAux.SQL.Add('  IFNULL(GER_SERIE_,"") = :SERIE_ ');

  qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
  qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('CODCLI').AsString := strCodCli;
  qryAux.ParamByName('SERIE_').AsString := strSerie;

  qryAux.Open;

  Result := qryAux.FieldByName('GER_CIDCON').AsString;

  FreeAndNil(qryAux);
end;

function TfrmCadLivroFiscal.fClassificaoUnica: Boolean;
  function fValido(strValue: string): Boolean;
  begin
    If strValue = '' Then
      Exit(True);
    If (strValue <> '') And (strValue = dbeClfSc1.Text) Then
      Exit(True)
    Else
      Exit(False)
  end;
begin
  result := fValido(dbeClfSc2.Text) And
            fValido(dbeClfSc3.Text) And
            fValido(dbeClfSc4.Text) And
            fValido(dbeClfSc5.Text);
end;

function TfrmCadLivroFiscal.fCSTCadastrada(blnPis: Boolean): Boolean;
var qryPisCof: TUniQuery;
    strTabela: String;
    strField: String;
    strClaFis: String;
    strFieldCST: String;
    strValue: String;
begin
  strClaFis := dbeClfSc1.Text;
  If strClaFis = '' Then
    strClaFis := '0';

  If StrToInt(dbeClfSc1.Text) < 5000 then
  Begin
    strTabela := IIf(blnPis, 'PISENT', 'COFENT');
    strField := 'APC_CFOENT';
    strFieldCST :=  'APC_CSTENT';
  End
  Else
  Begin
    strTabela := IIf(blnPis, 'PISSAI', 'COFSAI');
    strField := 'APC_CFOSAI';
    strFieldCST :=  'APC_CSTSAI';
  End;
  strValue := IIf(blnPis, dbeCstPis.text, dbeCstCof.text);

  qryPisCof := fCriaQuery;
  qryPisCof.SQL.Add('SELECT ' + strTabela + '.* FROM ' + strTabela );
  qryPisCof.SQL.Add(' WHERE LOCATE(:CLAFIS, ' + fTransformSQL(strField) +' ) > 0');
  If strValue <> '' Then
    qryPisCof.SQL.Add(' AND ' + strFieldCST + ' = ' +fQuotedStr(strValue));
  qryPisCof.SQL.Add('ORDER BY APC_VIGENC DESC, APC_CODAPC ASC');
  qryPisCof.ParamByName('CLAFIS').AsString := dbeClfSc1.Text;
  qryPisCof.Open;
  Result := Not qryPisCof.IsEmpty;
end;

procedure TfrmCadLivroFiscal.dbeCodFisChange(Sender: TObject);
begin
  inherited;
  edtDesCodFis.Text := fRetDesFis(dbeCodFis.Text);
end;

procedure TfrmCadLivroFiscal.dbeCodFisEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'INSERT para fazer um novo cadastro';
end;

procedure TfrmCadLivroFiscal.dbeCodFisExit(Sender: TObject);
begin
  inherited;
  If qryFisItens.IsEmpty Then
    Exit;

  If fEmptyStr(dbeCodFis.Text) Then
  Begin
    fMensagem('', 'O Cód. Fiscal deve ser preenchido!', ['&Ok']);
    pSetFocus(dbeCodFis);
  End
  Else If fEmptyStr(edtDesCodFis.Text) Then
  Begin
    fMensagem('', 'Este Cód. Fiscal não está cadastrado!', ['&Ok']);
    pSetFocus(dbeCodFis);
  End;

  pnlInfo.Caption := '';
end;

procedure TfrmCadLivroFiscal.dbeCodFisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqSitTributaria(Self, dbeCodFis, edtDesCodFis, nil, Key, arrSel) Then
  Begin
    if fValidaCampos(dbeCodFis) then
      SelectNext(ActiveControl, True, True);

  End;

end;

procedure TfrmCadLivroFiscal.dbeCstCofKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  fPesqCSTCof(Self, dbeCstCof, Nil, Nil, Key, arrSel);
end;

procedure TfrmCadLivroFiscal.dbeCSTIPIKeyPress(Sender: TObject; var Key: Char);
Var
  arrSel: TConsultasArray;
begin
  inherited;
  fPesqCSTIPI(Self, dbeCSTIPI, Nil, Nil, Key, arrSel);
end;

procedure TfrmCadLivroFiscal.dbeCstPisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  fPesqCSTPis(Self, dbeCstPis, Nil, Nil, Key, arrSel);
end;

procedure TfrmCadLivroFiscal.dbeDtaEntExit(Sender: TObject);
begin
  inherited;
  pManipulaCampoCodigoTipoServico;
end;

procedure TfrmCadLivroFiscal.dbeChaveAcessoExit(Sender: TObject);
Var
  strModChave: String;
  i: Integer;
begin
  inherited;
  cbxCodMod.Clear;
  cbxCodMod.Enabled := True;
  pCarregaModFis(dbeChaveAcesso.Text);
  If cbxCodMod.Items.Count = 1 Then
  Begin
    cbxCodMod.Enabled   := False;
    cbxCodMod.ItemIndex := 0;
  End
  Else If (Not fEmptyStr(dbeChaveAcesso.Text)) And SameText(dbeEspDoc.Text,'NF') Then
  begin
    strModChave := Copy(dbeChaveAcesso.Text,  21, 2);
    i := cbxCodMod.Items.IndexOfName(strModChave);
    cbxCodMod.ItemIndex := i;
end;
end;

procedure TfrmCadLivroFiscal.dbeClaFisChange(Sender: TObject);
begin
  inherited;
  If cmbNatOpeItem.Items.IndexOf(qryFisItens.FieldByName('DET_NATOPE').AsString) > -1 Then
    cmbNatOpeItem.ItemIndex := cmbNatOpeItem.Items.Indexof(qryFisItens.FieldByName('DET_NATOPE').AsString)
  Else
    cmbNatOpeItem.ItemIndex := 0;
end;

procedure TfrmCadLivroFiscal.dbeClaFisExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
  pCarregaNatOperacao(cmbNatOpeItem, dbeClaFis.Text);
end;

procedure TfrmCadLivroFiscal.dbeClaFisKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  if fPesqCFOP(Self, dbeClaFis, Nil, Nil, Key, arrSel, True, fFiltroCFOP) Then
  Begin
    if fValidaCampos(dbeClaFis) then
      SelectNext(ActiveControl, True, True);
  End;

end;

procedure TfrmCadLivroFiscal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
  Begin
    Key := 0;
    If (btnConfirmar.Enabled) And (pnlItens.Enabled) Then
      btnconfirmarClick(Sender);
  End;

  If Key = VK_INSERT Then
  Begin
    If (dbeClaFis.Focused) And fVerificaAcessoSistema('frmCadClassFiscal') Then
      dbeClaFis.Text := fChamaCadCfo(Key);

    If (dbeCodFis.Focused) And fVerificaAcessoSistema('frmCadSitTributarias') Then
      dbeCodFis.Text := fChamaCadTri(Key);

  End;

end;

procedure TfrmCadLivroFiscal.btnConfAcumuladorClick(Sender: TObject);
begin
  inherited;
  If (cbxClaFisAcu.Enabled) And (cbxClaFisAcu.ItemIndex = -1) Then
  Begin
    fMensagem('ATENÇÃO!', 'É necessário selecionar uma classificação. As classificações deste campo são carregadas da aba "Dados Gerais".', ['&Ok']);
    Exit;
  End;

  If Not fValidaCampos(edtCodAcu, True) Then
  Begin
    pSetFocus(edtCodAcu);
    Exit;
  End;

  If Not fValidaCampos(edtPerAcu, True) Then
  Begin
    pSetFocus(edtPerAcu);
    Exit;
  End;

  If Not fValidaAcumuladoresConf Then
    Exit;

  cdsDomAcu.Append;
  cdsDomAcu.FieldByName('ACU_CODACU').AsString := edtCodAcu.Text;
  cdsDomAcu.FieldByName('ACU_PERACU').AsString := FormatFloat('#,##0.00', fStrToFloat(edtPerAcu.Text));
  cdsDomAcu.FieldByName('ACU_CLAFIS').AsString := LeftStr(cbxClaFisAcu.Text, 4);
  cdsDomAcu.FieldByName('ACU_ALQICM').AsFloat  := fRetornaAlqDoCombo(cbxClaFisAcu.Text);
  cdsDomAcu.Post;

  pLimpaCamposDominioAcumulador;
  pSetFocus(cbxClaFisAcu);
end;

procedure TfrmCadLivroFiscal.btnConfirmarClick(Sender: TObject);
  Var
    qrySint: TUniQuery;
    intRecNo: Integer;
//    blnHandle: Boolean;
begin
  inherited;
  qrySint := fCriaQuery(Nil);
  Try
    With qrySint Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetSQL('MOVDET'));
      pSetaParametros(qrySint);
      Open;

      If (IsEmpty) Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSQL('NOTDET'));
        pSetaParametros(qrySint);
        Open;
      End;

      If (IsEmpty) Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSQL('ITECOM'));
        ParamByName('AUTOINCREM').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
        Open;
      End;
    End;

    //DESABILITADO PELO REQ 346203
    {If qrySint.RecordCount > 5 Then
    Begin
      fMensagem('Aviso', 'A combinação de CFOP+Alíquota ultrapassa cinco colunas, favor entrar em contato com o suporte!', ['OK']);
      Exit;
    End;  }
  Finally
    qrySint.Free;
  End;

  If qryTabela.State in [dsInsert, dsEdit] Then
  Begin
    If (fVerificaTotalImpostos) And
       (fVerificaCfopCorreta(dbeClaFis.Text)) And
       (fValidaClaFisCT(qryTabela.FieldByName('FIS_ESPDOC').AsString, dbeClaFis.Text)) And
       (fVerificaCampos) Then
    Begin
      pnlInfo.Caption := 'Gravando dados do item, aguarde...';
      pnlInfo.Refresh;
      Try
        pgcDetalhes.ActivePageIndex := 2;
        intRecNo := dbgItensDBTableViewCitel1.DataController.DataSource.DataSet.RecNo;

        If strTabela <> 'ITECOM' then
          pAtualizaItensLivro;

        If (cmbNatOpeItem.Text <> FStrNatOpeItemAnt) And
           (dbeClaFis.Text = qryFisItens.FieldByName('CLAFIS').AsString) Then
          pChangeNatOpe(True);

        pCarregaitens;

        btnGravarClick(Sender);

        pDefineCapaPrimeiraClafisDadosGerais;

        // Mostra Aba de Itens
        tbsItens.Show;
        // Clica no botão alterar do livro
        btnAlterar.Click;
        // Esconde pnlGeral
        pgcDetalhesChange(tbsItens);
        // Desabilita os campos
        pCarregaItens(True);
        // Seleciona o registro anterior
        dbgItensDBTableViewCitel1.DataController.DataSource.DataSet.RecNo := intRecNo;
        // Clica no registro para carregar os valores
        If dtsFisItens.DataSet.RecordCount > 0 Then
          pCarregaItensGrid;
        // Foca no grid
        pSetFocus(dbgItens);
        // Habilita os botões
        pnlBotoes.Enabled := True;

        FBlnAlterandoItem := False;
      Finally
        pnlInfo.Caption := '';
      End;
    End;
  End;
  pCalculaTotais;
  pJustaCamposImpostos;
end;

procedure TfrmCadLivroFiscal.btnDifalClick(Sender: TObject);
var
  frmCadAjuDet : TfrmCadAjuDet;
begin
  inherited;
  If Not qryFisItens.IsEmpty Then
  Begin
    pCriarFormularios(TfrmCadAjuDet, frmCadAjuDet);
    Try
      frmCadAjuDet.QryFisItens := qryFisItens;
      frmCadAjuDet.strCodEmp := qryTabela.FieldByName('FIS_CODEMP').AsString;
      frmCadAjuDet.strAutoIncrem := qryTabela.FieldByName('AUTOINCREM').AsString;
      frmCadAjuDet.ShowModal;
    Finally
      frmCadAjuDet.Free;
    End;
  End
  Else
    fMensagem('Atenção', 'Não existem itens associados a esta nota', ['OK']);
end;

procedure TfrmCadLivroFiscal.pAddArrValoresIniciaisItens(Aedit: TEdit);
var intPos: Integer;
begin
  IntPos := Length(ArrValoresIniciaisItens) + 1;
  SetLength(ArrValoresIniciaisItens, IntPos);
  IntPos := IntPos -1;
  ArrValoresIniciaisItens[intPos].Edit :=  Aedit;
  ArrValoresIniciaisItens[intPos].Value :=  Aedit.Text;
End;

procedure TfrmCadLivroFiscal.pCarregaItensGrid;
Begin
  SetLength(ArrValoresIniciaisItens, 0);
  With qryFisItens Do
  Begin
    dbeCodFis.Text := FieldByName('CODFIS').AsString;
    dbeClaFis.Text := FieldByName('CLAFIS').AsString;
    dbeCSTIPI.Text := FieldByName('CSTIPI').AsString;
    dbeNcmIte.Text := FieldByName('NCMITE').AsString;
    If Not fEmptyStr(dbeNcmIte.Text) Then
      edtDesNcm.Text := fRetDescricaoNcm(dbeNcmIte.Text)
    else
      edtDesNcm.Clear;

    dbeBasIcm.Text := FloatToStrF(FieldByName('BASICM').AsFloat, ffFixed, 10, 2);
    dbeAlqIcm.Text := FloatToStrF(FieldByName('ALQICM').AsFloat, ffFixed, 10, 2);
    dbeValIcm.Text := FloatToStrF(FieldByName('VALICM').AsFloat, ffFixed, 10, 2);
    dbeBasIPI.Text := FloatToStrF(FieldByName('BASIPI').AsFloat, ffFixed, 10, 2);
    dbeAlqIPI.Text := FloatToStrF(FieldByName('ALQIPI').AsFloat, ffFixed, 10, 2);
    dbeValipi.Text := FloatToStrF(FieldByName('VALIPI').AsFloat, ffFixed, 10, 2);
    dbeBaeIPI.Text := FloatToStrF(FieldByName('BAEIPI').AsFloat, ffFixed, 10, 2);
    dbeAleIPI.Text := FloatToStrF(FieldByName('ALEIPI').AsFloat, ffFixed, 10, 2);
    dbeVaeipi.Text := FloatToStrF(FieldByName('VAEIPI').AsFloat, ffFixed, 10, 2);

    edtBaseCbs.Text := FloatToStrF(fSafeFloatField(qryFisItens, 'BASCBS'), ffFixed, 10, 2);
    edtValorCbs.Text := FloatToStrF(fSafeFloatField(qryFisItens, 'VALCBS'), ffFixed, 10, 2);
    edtBaseIBS.Text := FloatToStrF(fSafeFloatField(qryFisItens, 'BASIBS'), ffFixed, 10, 2);
    edtValorIBS.Text := FloatToStrF(fSafeFloatField(qryFisItens, 'VALIBS'), ffFixed, 10, 2);
    edtBaseIS.Text := FloatToStrF(fSafeFloatField(qryFisItens, 'BAS_IS'), ffFixed, 10, 2);
    edtValorIS.Text := FloatToStrF(fSafeFloatField(qryFisItens, 'VAL_IS'), ffFixed, 10, 2);

    dbeValRet.Text := FloatToStrF(FieldByName('VALRET').AsFloat, ffFixed, 10, 2);
    dbeBasRet.Text := FloatToStrF(FieldByName('BASRET').AsFloat, ffFixed, 10, 2);
    dbeVRetNC.Text := FloatToStrF(FieldByName('VAERET').AsFloat, ffFixed, 10, 2);
    dbeBRetNC.Text := FloatToStrF(FieldByName('BAERET').AsFloat, ffFixed, 10, 2);
    dbeValFre.Text := FloatToStrF(FieldByName('VALFRE').AsFloat, ffFixed, 10, 2);
    dbeValFreItens.Text := FloatToStrF(FieldByName('TOTFRE_ITE').AsFloat, ffFixed, 10, 2);
    dbeBasAnt.Text := FloatToStrF(FieldByName('BASANT').AsFloat, ffFixed, 10, 2);
    dbeValAnt.Text := FloatToStrF(FieldByName('VALANT').AsFloat, ffFixed, 10, 2);
    dbeDesAce.Text := FloatToStrF(FieldByName('DESACE').AsFloat, ffFixed, 10, 2);
    dbeOutras.Text := FloatToStrF(FieldByName('OUTICM').AsFloat, ffFixed, 10, 2);
    dbeIsenta.Text := FloatToStrF(FieldByName('ISEICM').AsFloat, ffFixed, 10, 2);
    dbeVICMDe.Text := FloatToStrF(FieldByName('VICMDE').AsFloat, ffFixed, 10, 2);

    edtIteCstPis.Text := FieldByName('CSTPIS').AsString;
    edtIteBasPis.Text := FloatToStrF(FieldByName('BASPIS').AsFloat, ffFixed, 10, 2);
    edtIteAlqPis.Text := FloatToStrF(FieldByName('ALQPIS').AsFloat, ffFixed, 10, 4);
    edtIteValPis.Text := FloatToStrF(FieldByName('VALPIS').AsFloat, ffFixed, 10, 2);
    edtIteNatRecPis.Text := FieldByName('NR_PIS').AsString;

    edtIteCstCof.Text := FieldByName('CSTCOF').AsString;
    edtIteBasCof.Text := FloatToStrF(FieldByName('BASCOF').AsFloat, ffFixed, 10, 2);
    edtIteAlqCof.Text := FloatToStrF(FieldByName('ALQCOF').AsFloat, ffFixed, 10, 4);
    edtIteValCof.Text := FloatToStrF(FieldByName('VALCOF').AsFloat, ffFixed, 10, 2);
    edtBFCPST.Text := FloatToStrF(FieldByName('BFCPST').AsFloat, ffFixed, 10, 2);
    edtPFCPST.Text := FloatToStrF(FieldByName('PFCPST').AsFloat, ffFixed, 10, 2);
    edtVFCPST.Text := FloatToStrF(FieldByName('VFCPST').AsFloat, ffFixed, 10, 2);

    edtIteNatRecCof.Text := FieldByName('NR_COF').AsString;

    lblRICMPR.Visible := FieldByName('RICMPR').AsString = 'S';
    If lblRICMPR.Visible Then
      lblRICMPR.Caption := 'Este produto possui diferimento de '+FloatToStrF(FieldByName('PERRED').AsFloat, ffFixed, 10, 2)+'% conforme RICMS';

    if ckbReduzICMS.Visible then
    begin
      ckbReduzICMS.Checked := FieldByName('RICMPR').AsString = 'S';
    end;

    edtDesAbf.Text := FieldByName('DESABF').AsString;

    edtValorFCP.Text := FloatToStrF(FieldByName('ICD_VALFCP').AsFloat, ffFixed, 10, 2);

    edtPercFCP.Text    := FloatToStrF(FieldByName('ICD_PERFCP').AsFloat, ffFixed, 10, 2);
    edtBaseUFDest.Text := FloatToStrF(FieldByName('ICD_BCUFDE').AsFloat, ffFixed, 10, 2);
    edtBaseFCP.Text := FloatToStrF(FieldByName('ICD_BASFCP').AsFloat, ffFixed, 10, 2);
    edtAlqInterna.Text := FloatToStrF(FieldByName('ICD_ALQUFD').AsFloat, ffFixed, 10, 2);
    edtAlqInterestadual.Text := FloatToStrF(FieldByName('ICD_ALQINE').AsFloat, ffFixed, 10, 2);
    edtPercentualPartilha.Text := FloatToStrF(FieldByName('ICD_PERPAR').AsFloat, ffFixed, 10, 2);
    edtICMSOrigem.Text := FloatToStrF(FieldByName('ICD_VALORI').AsFloat, ffFixed, 10, 2);
    edtICMSDestino.Text := FloatToStrF(FieldByName('ICD_VALDES').AsFloat, ffFixed, 10, 2);

    edtBaseStCat158.Text := FloatToStrF(FieldByName('BCR158').AsFloat, ffFixed, 10, 2);
    edtValorStCat158.Text := FloatToStrF(FieldByName('VLR158').AsFloat, ffFixed, 10, 2);

    edtBaseIcmCat158.Text := FloatToStrF(FieldByName('BCI158').AsFloat, ffFixed, 10, 2);
    edtAlqIcmCat158.Text := FloatToStrF(FieldByName('ALI158').AsFloat, ffFixed, 10, 2);
    edtValorIcmCat158.Text := FloatToStrF(FieldByName('VLI158').AsFloat, ffFixed, 10, 2);
    edtQBCMonoRet.Text := FloatToStrF(FieldByName('DET_QBCMON').AsFloat, ffFixed, 10, 2);
    edtAdRemICMDRet.Text := FloatToStrF(FieldByName('DET_ADREMN').AsFloat, ffFixed, 10, 2);
    edtVICMSMonoRet.Text := FloatToStrF(FieldByName('DET_VALMON').AsFloat, ffFixed, 10, 2);
    edtValGNRE.Text:= FloatToStrF(FieldByName('DET_VLGNRE').AsFloat, ffFixed, 10, 2);
    btnMemCalcGNRE.Enabled := FieldByName('DET_VLGNRE').AsFloat > 0;

    pSetaComboNatOpe(cmbNatOpeItem, dbeClaFis.Text, True);

    pAddArrValoresIniciaisItens(dbeCodFis);
    pAddArrValoresIniciaisItens(dbeClaFis);
    pAddArrValoresIniciaisItens(dbeCSTIPI);
    pAddArrValoresIniciaisItens(dbeBasIcm);
    pAddArrValoresIniciaisItens(dbeAlqIcm);
    pAddArrValoresIniciaisItens(dbeValIcm);
    pAddArrValoresIniciaisItens(dbeBasIPI);
    pAddArrValoresIniciaisItens(dbeAlqIPI);
    pAddArrValoresIniciaisItens(dbeValipi);
    pAddArrValoresIniciaisItens(dbeBaeIPI);
    pAddArrValoresIniciaisItens(dbeAleIPI);
    pAddArrValoresIniciaisItens(dbeVaeipi);
    pAddArrValoresIniciaisItens(dbeValRet);
    pAddArrValoresIniciaisItens(dbeBasRet);
    pAddArrValoresIniciaisItens(dbeVRetNC);
    pAddArrValoresIniciaisItens(dbeBRetNC);
    pAddArrValoresIniciaisItens(dbeValFre);
    pAddArrValoresIniciaisItens(dbeBasAnt);
    pAddArrValoresIniciaisItens(dbeValAnt);
    pAddArrValoresIniciaisItens(dbeDesAce);
    pAddArrValoresIniciaisItens(dbeOutras);
    pAddArrValoresIniciaisItens(dbeIsenta);
    pAddArrValoresIniciaisItens(dbeVICMDe);
    pAddArrValoresIniciaisItens(dbeValFreItens);
    pAddArrValoresIniciaisItens(edtIteCstPis);
    pAddArrValoresIniciaisItens(edtIteBasPis);
    pAddArrValoresIniciaisItens(edtIteAlqPis);
    pAddArrValoresIniciaisItens(edtIteValPis);
    pAddArrValoresIniciaisItens(edtIteNatRecPis);
    pAddArrValoresIniciaisItens(edtIteCstCof);
    pAddArrValoresIniciaisItens(edtIteBasCof);
    pAddArrValoresIniciaisItens(edtIteAlqCof);
    pAddArrValoresIniciaisItens(edtIteValCof);
    pAddArrValoresIniciaisItens(edtBFCPST);
    pAddArrValoresIniciaisItens(edtPFCPST);
    pAddArrValoresIniciaisItens(edtVFCPST);
    pAddArrValoresIniciaisItens(edtIteNatRecCof);
    pAddArrValoresIniciaisItens(edtDesAbf);
    pAddArrValoresIniciaisItens(edtValorFCP);
    pAddArrValoresIniciaisItens(edtPercFCP);
    pAddArrValoresIniciaisItens(edtBaseUFDest);
    pAddArrValoresIniciaisItens(edtBaseFCP);
    pAddArrValoresIniciaisItens(edtAlqInterna);
    pAddArrValoresIniciaisItens(edtAlqInterestadual);
    pAddArrValoresIniciaisItens(edtPercentualPartilha);
    pAddArrValoresIniciaisItens(edtICMSOrigem);
    pAddArrValoresIniciaisItens(edtICMSDestino);
    pAddArrValoresIniciaisItens(edtBaseStCat158);
    pAddArrValoresIniciaisItens(edtValorStCat158);
    pAddArrValoresIniciaisItens(edtBaseIcmCat158);
    pAddArrValoresIniciaisItens(edtAlqIcmCat158);
    pAddArrValoresIniciaisItens(edtValorIcmCat158);
    pAddArrValoresIniciaisItens(edtQBCMonoRet);
    pAddArrValoresIniciaisItens(edtAdRemICMDRet);
    pAddArrValoresIniciaisItens(edtVICMSMonoRet);
  End;
End;

procedure TfrmCadLivroFiscal.dbgItensDBTableViewCitel1CellClick(Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  pCarregaItensGrid;
end;

procedure TfrmCadLivroFiscal.dbgItensDBTableViewCitel1DblClick(Sender: TObject);
begin
  // para desabilitar os botões só precisa passar o TabStop = False

    inherited;

  If qryFisItens.IsEmpty Then
    Exit;

  pHab(dbeCodFis);
  pHab(dbeClaFis);
  cmbNatOpeItem.Enabled := True;
  pHab(dbeBasIcm);
  pHab(dbeAlqIcm);
  pHab(dbeValIcm);
  pHab(dbeValFre);
  pHab(dbeDesAce);
  pHab(dbeBasIPI);
 // pHab(dbeAlqIPI);  a pedido do Ronaldo
  pHab(dbeValipi);
  pHab(dbeBaeIPI);
 // pHab(dbeAleIPI);  a pedido do Ronaldo
  pHab(dbeVaeipi);
  pHab(dbeCSTIPI);
  pHab(dbeNcmIte);

  pHab(dbeValRet);
  pHab(dbeBasRet);
  pHab(dbeVRetNC);
  pHab(dbeBRetNC);

  pHab(dbeValAnt);
  pHab(dbeBasAnt);
  pHab(dbeOutras);
  pHab(dbeIsenta);
  pHab(dbeVICMDE);

  pHab(edtIteCstPis);
  pHab(edtIteBasPis);
  pHab(edtIteAlqPis);
  pHab(edtIteNatRecPis);

  pHab(edtIteCstCof);
  pHab(edtIteBasCof);
  pHab(edtIteAlqCof);
  pHab(edtIteNatRecCof);

  pHab(edtBaseStCat158);
  pHab(edtValorStCat158);

  pHab(edtBaseIcmCat158);
  pHab(edtAlqIcmCat158);
  pHab(edtValorIcmCat158);

  If (lblRICMPR.Visible) And (dbeTip_Fc.Text <> 'F') Then
    dbeCodFis.Enabled := False;

  btnConfirmar.Enabled := True;

  pnlBotoes.Enabled := False;
  pHab(edtBFCPST);
  pHab(edtPFCPST);
  pHab(edtVFCPST);

  If (qryFisItens.FieldByName('ICD_TEMICD').AsInteger = 1) Then
  Begin
    pHab(edtBaseUFDest);
    pHab(edtPercFCP);
    pHab(edtAlqInterna);
    pHab(edtAlqInterestadual);
  End
  Else
  Begin
    pDesHab(edtBaseUFDest);
    pDesHab(edtPercFCP);
    pDesHab(edtAlqInterna);
    pDesHab(edtAlqInterestadual);
  End;

  If dbeCodFis.Enabled Then
  Begin
    pSetFocus(dbeCodFis);
    dbeCodFis.SelectAll;
  End
  Else
    SelectNext(dbeCodFis, True, True);
  pDesHab(edtQBCMonoRet);
  pDesHab(edtAdRemICMDRet);
  pDesHab(edtVICMSMonoRet);
  If (RightStr(dbeCodFis.Text, 2) = '61') Then
  Begin
    pHab(edtQBCMonoRet);
    pHab(edtAdRemICMDRet);
    pHab(edtVICMSMonoRet);
  End;
  FStrNatOpeItemAnt := qryFisItens.FieldByName('DET_NATOPE').AsString;
  FBlnAlterandoItem := True;
end;

procedure TfrmCadLivroFiscal.dbgItensDBTableViewCitel1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
Begin
  If Key = VK_RETURN Then
  Begin
    dbgItensDBTableViewCitel1DblClick(Sender);
  End
  Else If Key = VK_ESCAPE Then
  Begin
    btnCancelaClick(Sender);
  End
  Else If (Key = VK_INSERT) Then
  Begin
    If fVerificaAcessoSistema('frmCadProdutos') Then
    Begin
      pCriarForm(TfrmCadProdutos, frmCadProdutos);
    End
    Else
    Begin
      pMensagemOk('Este usuário não tem permissão para acessar o cadastro de produtos.');
    End;
  End
  Else
    inherited;

end;

procedure TfrmCadLivroFiscal.dbgItensDBTableViewCitel1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  If (Key = VK_UP) Or (Key = VK_DOWN) And (dtsFisItens.DataSet.RecordCount > 0)Then
    pCarregaItensGrid;
end;

procedure TfrmCadLivroFiscal.dbgItensEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'Pressione INSERT para abrir o cadastro de produtos';
end;

procedure TfrmCadLivroFiscal.dbgItensExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmCadLivroFiscal.dbmHistorExit(Sender: TObject);
begin
  inherited;
  dbmHistor.Text := AnsiUpperCase(dbmHistor.Text);
end;

procedure TfrmCadLivroFiscal.dbmHistorKeyPress(Sender: TObject; var Key: Char);
begin
  If Key = #13 Then
  Begin
    Key := #0;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadLivroFiscal.btnGravarClick(Sender: TObject);
  Var
    intCont: Integer;
    varDefault: Variant;
    RegistroContabilidade: TrecRegistroContabilidade;

    blnRetificaReinf2000,
    blnRetificaReinf4000: Boolean;
begin
  pAtivaCampoCst;
  pAtivaEventoDeEntrega;

  pEnabledFisAju;

  If fRegraPisCofins Then
  Begin
    pCarregaPisCofins(qryTabela.FieldByName('FIS_CLFSC1').AsString, qryTabela.FieldByName('FIS_CSTPIS').AsString, qryTabela.FieldByName('FIS_CSTCOF').AsString);
    if Not blnCarregaPis then
    Begin
      if fEmptyStr(dbeCstPis.Text) Then
      Begin
        pMensagemOK('É necessário informar dados de Abreviação de PIS para entrada.');
        Exit;
      End;
    End;
    if Not blnCarregaCofins then
    Begin
      if fEmptyStr(dbeCstCof.Text) Then
      Begin
        pMensagemOK('É necessário informar dados de Abreviação de COFINS para entrada.');
        Exit;
      End;
    End;
  End;

  If Not fValidaClaFisCT(qryTabela.FieldByName('FIS_ESPDOC').AsString) Then
    Exit;

  If fExpecieExigeChave and fEmptyStr(dbeChaveAcesso.Text)  Then
  Begin
    fMensagem('', 'Para esta espécie de documento é preciso informa a chave de acesso!', ['OK']);
    pSetFocus(dbeChaveAcesso);
    Exit;
  End;

  If ((Pos(dbeEspDoc.Text, '_NF_CO') > 0) And  (pos(qryTabela.FieldByName('FIS_CLFSC1').AsString, CFOP_COMUNICACAO) > 0)) Then
    If Not fModeloValidoParaNotaDeComunicao Then
      Exit;

  If (dbeEspDoc.Text = 'CO') And (pos(qryTabela.FieldByName('FIS_CLFSC1').AsString, CFOP_COMUNICACAO) = 0) Then
  Begin
    fMensagem('', 'Para esta espécie de documento é preciso informa um CFOP de Comunicação!', ['OK']);
    Exit;
  End;

  blnPulaProcessoEnergia := True;
  Try
    If (Not fValidacoesBotaoGravarPai) Then
      Exit;
  Finally
    blnPulaProcessoEnergia := False;
  End;

  If Not fValidaObrigatoriedadeChaveModelo(dbeChaveAcesso.Text, fGetModDocumentocbxCODMOD) Then
  Begin
    pMensagemOk('O Modelo selecionado exige a chave de acesso!');
    Exit;
  End;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  if cmbCodClaConEnergiaEletrica.Visible then
  begin
    if cmbCodClaConEnergiaEletrica.ItemIndex < 0 then
    begin
      fMensagem('', 'É necessário informar um código de classe consumo para energia elétrica!', ['OK']);
      pFindAndActivePage(cmbCodClaConEnergiaEletrica);
      pSetFocus(cmbCodClaConEnergiaEletrica);
      Exit;
    end
    else
      qryTabela.FieldByName('FIS_CODCCE').AsString := LeftStr(cmbCodClaConEnergiaEletrica.Items.Strings[cmbCodClaConEnergiaEletrica.ItemIndex], 2);
  end;

  if cmbCodGrupTensao.Visible then
  begin
    if cmbCodGrupTensao.ItemIndex < 0 then
    begin
      if (fGetModDocumentocbxCODMOD <> '66') and (not fEmptyStr(dbeChaveAcesso.Text)) then
      begin
        fMensagem('', 'É necessário informar um código de grupo de tensão para energia elétrica!', ['OK']);
        pFindAndActivePage(cmbCodGrupTensao);
        pSetFocus(cmbCodGrupTensao);
        Exit;
      end;
    end
    else
      qryTabela.FieldByName('FIS_CODGRT').AsString := LeftStr(cmbCodGrupTensao.Items.Strings[cmbCodGrupTensao.ItemIndex], 2);
  end;


  If fNFServico And blnInsert Then
  begin
    If (fCfgSis('ITESER') = '') Then
    begin
      fMensagem('Atenção', 'É necessário configurar um item de serviço na CFG_ITESER!', ['OK']);
      Exit;
    End
    Else If (Not fItemExiste(fCfgSis('ITESER'))) then
    Begin
      fMensagem('Atenção', 'O Item Configurado na CFG_ITESER não existe!', ['OK']);
      Exit;
    End;
  End;

  If tbsPessoasCTE.TabVisible Then
    If blnInsert Then
      If Not fraPessoasCTE.fValida Then
        Exit;

  pEnabledCodigoClasseConsumoEnergiaEletrica;
  If Not fEhNotaEnergiaEletroincaZerada Then
    If AnsiIndexStr(dbmHistor.Text, ['CANCELAD','INUTILIZAD','DENEGAD']) = -1 then
    Begin
      If (Not fValidaClaFisInclusao) And (dbeNfComple.Text <> 'S') Then
      Begin
        fMensagem('ATENÇÃO!', 'Documentos com itens permitidos somente em "ENTRADA DE MERCADORIAS".', ['&Ok']);
        Exit;
      End;
    End;

  If Not fEhNotaEnergiaEletroincaZerada Then
    If (fStrToFloat(dbeVlCon1.Text) <= 0) And (dbeNfComple.Text <> 'S') Then
    Begin
      fMensagem('ATENÇÃO!', 'Não é possível lançar notas eletrônicas sem valor contábil. ' + sLineBreak +
                            'Favor verificar o lançamento. Dúvidas entre em contato com a Citel!', ['&Ok']);
      Exit;
    End;

  If fCfgSis('UTIACU', varBoolean) Then
    If Not fValidaAcumuladoresGrav Then
      Exit;

  Try
    If Not objFechamentoFiscal.fVeSeTravaFechamentoFiscal(trfMovimentacao, StrToDate(dbeDtaEnt.Text), dbeCodEmp.Text) Then
      Exit;

    If (qryTabela.FieldByName('FIS_ESPDOC').AsString = 'NS') And (qryTabela.State = dsEdit) Then
      pAtualizaServico;

    If (Not qryFisItens.IsEmpty) And (qryTabela.State = dsEdit) Then
    Begin
      If strTabela <> 'ITECOM' then
        If Not fReconstruirLivro(True) Then
          Exit;
    End;

    If (qryTabela.State = dsInsert) Then
    Begin
      {*****************************************}
      {* ORIGEM DO CADASTRO.                   *}
      {**************************************MV*}
      qryTabela.FieldByName('FIS_ESTADO').AsString := edtEstado.Text;
      qryTabela.FieldByName('FIS_ORIDOC').AsString := 'C';
    End;

    If (dbeEspDoc.Text <> 'CT') And (qryTabela.State In [dsInsert, dsEdit]) Then
      qryTabela.FieldByName('FIS_VENCOM').Value := Null;

    If (Not cbxCodMod.ItemIndex < 0) And (qryTabela.State In [dsInsert, dsEdit]) Then
      qryTabela.FieldByName('FIS_CODMOD').AsString := fGetModDocumentocbxCODMOD
    Else
      qryTabela.FieldByName('FIS_CODMOD').Value := Null;

    If (qryTabela.State <> dsInsert) Then
    Begin
      For intCont := 0 To qryTabela.FieldCount -1 Do
      Begin
        varDefault := IIF(qryTabela.Fields[intCont].DataType = ftString, '', 0);

        If IIF(qryTabela.Fields[intCont].OldValue = Null, varDefault, qryTabela.Fields[intCont].OldValue) <>
           IIF(qryTabela.Fields[intCont].Value = Null, varDefault, qryTabela.Fields[intCont].Value) Then
          pGravaLogFis(IIF(qryTabela.Fields[intCont].OldValue = Null, varDefault, qryTabela.Fields[intCont].OldValue),
                         IIF(qryTabela.Fields[intCont].Value = Null, varDefault, qryTabela.Fields[intCont].Value),
                         qryTabela.Fields[intCont].FieldName, 'CADFIS');
      End;
    End;

    qryTabela.FieldByName('FIS_NFEXTE').AsString := IfThen(chkNfExtemporanea.Checked, 'S', 'N');

    qryTabela.FieldByName('FIS_NATOPE').AsString := cmbNatOpe.Text;
    //qryTabela.FieldByName('FIS_CLFSC1').AsString := dbeNatCfo.Text;

    if (qryTabela.FieldByName('FIS_ESPDOC').AsString = 'CT') and (qryTabela.FieldByName('FIS_LCTCTE').AsString <> 'I') Then
      qryTabela.FieldByName('FIS_LCTCTE').AsString := 'M';

    If fraCadImpostosNFS.grbRetencoes.Visible Then
      fraCadImpostosNFS.btnCalcRet.Click;

    If fRegraPisCofinsServico Then
      pCarregaPisCofins(qryTabela.FieldByName('FIS_CLFSC1').AsString, qryTabela.FieldByName('FIS_CSTPIS').AsString, qryTabela.FieldByName('FIS_CSTCOF').AsString);

    For intCont := 1 To 5 Do
    Begin
      If qryTabela.FieldByName('FIS_ALQIC' + intCont.ToString).Value = Null Then
        qryTabela.FieldByName('FIS_ALQIC' + intCont.ToString).AsFloat := 0.0;
    End;

    If (chkDocumentoConferido.Checked) Then
      pConferirDocumento
    Else
      pSetaValoresConferencia(False);

    blnRetificaReinf2000 := False;
    blnRetificaReinf4000 := False;
    pVerificaSeRetificaREINF(blnRetificaReinf2000, blnRetificaReinf4000);

    FblnGravandoLivro := True;
    Try
      inherited;

      If tbsDocumentosCTE.TabVisible And (qryTabela.FieldByName('FIS_LCTCTE').AsString = 'M') Then
      Begin
        pRemoveRegistrosRecTnf;
        pGravarRecTnf;
        cdsDocsCTE.MergeChangeLog;
        stlRegistrosExcluidosRECTNF.Clear;
      End;
    Except
      On E: Exception Do
      Begin
        blnGravou := False;
        fRollBack;
        pDescartarAuxFis;
        pMensagensErro(E.Message, '[TfrmCadLivroFiscal.btnGravarClick]');
      End;
    End;

    If blnGravou Then
    Begin
      pRetificaReinf(blnRetificaReinf2000, blnRetificaReinf4000);

      Try
        pGravarAuxFis;
        fCommit;
        pConfirmarAuxFis;
      Except
        On E: Exception Do
        Begin
          blnGravou := False;
          fRollBack;
          pDescartarAuxFis;
          pMensagensErro(E.Message, '[TfrmCadLivroFiscal.btnGravarClick]');
        End;
      End;
    End
    Else
    Begin
      fRollBack;
      pDescartarAuxFis;
    End;

    If ((fCfgsis('UTICON', varBoolean) and fCfgSis('CONONL', varBoolean))) Then
    Begin

      If blnInsert Then
      Begin
        RegistroContabilidade.ttpTabela := ttCadFis;
        RegistroContabilidade.strClafis := dbeClfSc1.Text;
        RegistroContabilidade.strEspDoc := dbeEspDoc.Text;
        RegistroContabilidade.strSeqGer := qryTabela.FieldByName('AUTOINCREM').AsString;
        RegistroContabilidade.mlModLan := mlInclusao;
        RegistroContabilidade.strEmpLan := dbeCodEmp.Text;
        pGravaRegistroContabilidade(RegistroContabilidade);
      End
      Else
      Begin
        //Gravação para a notger movger
        RegistroContabilidade.strClafis := dbeClfSc1.Text;
        If (Pos(copy(RegistroContabilidade.strClafis, 2, 3), '_933_253_303_602_605') = 0) Then
           pSetaTabelaEAutoIncremContabilidade(RegistroContabilidade)
        Else
        begin
          RegistroContabilidade.ttpTabela := ttCadFis;
          RegistroContabilidade.strSeqGer := qryTabela.FieldByName('AUTOINCREM').AsString;
        End;
        RegistroContabilidade.strEspDoc := dbeEspDoc.Text;
        RegistroContabilidade.mlModLan := mlCancelamento;
        RegistroContabilidade.strEmpLan := dbeCodEmp.Text;
        pGravaRegistroContabilidade(RegistroContabilidade);

        RegistroContabilidade.mlModLan := mlInclusao;
        pGravaRegistroContabilidade(RegistroContabilidade);
      End;
    End;

    pDesabilitaEditsNfComplementar;

    If blnGravou Then
    Begin
      If tbsPessoasCTE.TabVisible Then
      Begin
        If blnInsert Then
        Begin
          fraPessoasCTE.pSalva(qryTabela.FieldByName('AUTOINCREM').AsString);
    		End;
      End;

      If Not(qryFisItens.IsEmpty) Then
      Begin
        pAtualizaDataMovDetMovGer;
      End;

      tbsPessoasCTE.TabVisible := False;

      pgcDetalhes.ActivePageIndex := 0;
      pgcDetalhesChange(pgcDetalhes);

      If fCfgSis('UTIACU', varBoolean) Then
        pGravaDominioAcumulador;

      if (tbsDadosCpl.TabVisible) then
        fGravarTabelasAuxiliares
      else
        pRemoveInfCpl;

      If fNFServico And blnInsert And fExisteCadFis(qryTabela.FieldByName('AUTOINCREM').AsString) And (fCfgSis('ITESER') <> '') And fItemExiste(fCfgSis('ITESER')) then
        pCriaMovGerMovDet;
    End;


    If blnGravou And (dbeEntSai.Field.AsString = 'E') And (fStrToFloat(edtTotDoc.Text) <> 0) And (dbeTip_Fc.Text = 'F') And (blnInsert) Then
      if not pGravarContasPagar() then
        Exit;

    pAtualizaLabelCfopInvalida;

    if (tbsDadosCpl.TabVisible) then
    begin
      pCarregaDadosCpl;
    end;

    dbgItens.Enabled := False;
    fraCadImpostosNFS.pReset;
    fraCadImpostosNFS.grbRetencoes.Enabled := (qryTabela.State <> dsBrowse);
    If blnGravou Then
      pgcDetalhes.ActivePageIndex := 0;

    If blnGravou And fNFServico And blnInsert And fExisteCadFis(qryTabela.FieldByName('AUTOINCREM').AsString) And (fCfgSis('ITESER') <> '') And (fitemExiste(fCfgSis('ITESER')))then
      pCarregaItens;

    If fNFServico Then
      pCalcularValorLiquido;

    pHabilitaNFComplemento;
    pHabilitaCTCompraVenda;
    pHabilitaInfCpl;

    If blnGravou Then
      pEnabledFraCadImpostosNFS(False);

  Finally
    FblnGravandoLivro := False;
    pHabilitaCamposGerais(Not blnGravou);
    objFechamentoFiscal.pDestravaFechamentoFiscal(trfMovimentacao, dbeCodEmp.Text);
    fLockUnlock(False);
  End;
end;

procedure TfrmCadLivroFiscal.pVerificaSeRetificaREINF(var blnRetificaReinf2000, blnRetificaReinf4000: Boolean);
const
  arrFields2000: TArray<String> = ['FIS_TB06RE',
                                   'FIS_SERIE_',
                                   'FIS_NUMDOC',
                                   'FIS_DTAENT',
                                   'FIS_VLCON1',
                                   'FIS_VLCON2',
                                   'FIS_VLCON3',
                                   'FIS_VLCON4',
                                   'FIS_VLCON5',
                                   'FIS_REINSS'];

  arrFields4000: TArray<String> = ['FIS_TB01RE',
                                   'FIS_SERIE_',
                                   'FIS_NUMDOC',
                                   'FIS_DTAENT',
                                   'FIS_VLCON1',
                                   'FIS_VLCON2',
                                   'FIS_VLCON3',
                                   'FIS_VLCON4',
                                   'FIS_VLCON5',
                                   'FIS_REIRRF',
                                   'FIS_RECSSL',
                                   'FIS_VRECOF',
                                   'FIS_VREPIS'];
var
  intContadorSerieReinf: Integer;
  intContador: Integer;
begin
  if not fCfgSis('UTIREI', varBoolean) then
   Exit;

  for intContadorSerieReinf:=0 to 1 do
  begin
    if fEmptyStr(qryTabela.FieldByName(IIF(intContadorSerieReinf = 0, 'FIS_LOTREI_2000', 'FIS_LOTREI_4000')).AsString) then
      Continue;

    if intContadorSerieReinf = 0 then
    begin

      for intContador:=0 to Length(arrFields2000)-1 do
      begin
        if fValorFieldAlterado(qryTabela.FieldByName(arrFields2000[intContador])) then
        begin
          blnRetificaReinf2000 := True;
          Break;
        end;
      end;

    end
    else
    begin

      for intContador:=0 to Length(arrFields4000)-1 do
      begin
        if fValorFieldAlterado(qryTabela.FieldByName(arrFields4000[intContador])) then
        begin
          blnRetificaReinf4000 := True;
          Break;
        end;
      end;

    end;
  end;

end;

procedure TfrmCadLivroFiscal.pRetificaReinf(const blnRetificaReinf2000, blnRetificaReinf4000: Boolean);
const
  SQL_REINF_LOTES = ' UPDATE '+
                    '   REINF_LOTES '+
                    ' SET '+
                    '   LOT_SITUAC = "1" '+
                    ' WHERE '+
                    '   AUTOINCREM = :AUTINC ';
var
  qryAux: TUniQuery;
begin
  if not fCfgSis('UTIREI', varBoolean) then
   Exit;

  if blnRetificaReinf2000 then
  begin
    qryAux := fCriaQuery(Self);
    try
      qryAux.Close;
      qryAux.SQL.Text := SQL_REINF_LOTES;
      qryAux.ParamByName('AUTINC').AsString := qryTabela.FieldByName('FIS_LOTREI_2000').AsString;
      qryAux.ExecSQL;
    finally
      FreeAndNil(qryAux);
    end;
  end;

  if blnRetificaReinf4000 then
  begin
    qryAux := fCriaQuery(Self);
    try
      qryAux.Close;
      qryAux.SQL.Text := SQL_REINF_LOTES;
      qryAux.ParamByName('AUTINC').AsString := qryTabela.FieldByName('FIS_LOTREI_4000').AsString;
      qryAux.ExecSQL;
    finally
      FreeAndNil(qryAux);
    end;
  end;

end;

procedure TfrmCadLivroFiscal.btnGravarFisAjuClick(Sender: TObject);
begin
  If (qryFisAju.State = dsInsert) Then
  Begin
    qryFisAjuAJU_SEQGER.AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    qryFisAjuAUTOINCREM.AsString := fRetAutoIncrem('FISAJU', qryTabela.FieldByName('FIS_CODEMP').AsString);
  End;
  Try
    qryFisAju.Post;
  Except
    On E: Exception Do
    Begin
      If (Pos('Dataset not in edit or insert mode', E.Message) > 0) Then
        pMensagemOK('Os dados não estão no modo de edição ou inserção.')
      Else
        raise;
    End;
  End;
  pEnabledFisAju;
  pOnStateChangeFisAju;
  pSetFocus(dbgrFisAju);
end;

procedure TfrmCadLivroFiscal.pCalculaValorDocumento;
  Var
    fltVlCon1: Double;
    fltVlCon2: Double;
    fltVlCon3: Double;
    fltVlCon4: Double;
    fltVlCon5: Double;
begin
  fltVlCon1 := 0;
  fltVlCon2 := 0;
  fltVlCon3 := 0;
  fltVlCon4 := 0;
  fltVlCon5 := 0;
  If (Not fEmptyStr(dbeVlCon1.Text)) Then
    fltVlCon1 := fStrToFloat(dbeVlCon1.Text);
  If (Not fEmptyStr(dbeVlCon2.Text)) Then
    fltVlCon2 := fStrToFloat(dbeVlCon2.Text);
  If (Not fEmptyStr(dbeVlCon3.Text)) Then
    fltVlCon3 := fStrToFloat(dbeVlCon3.Text);
  If (Not fEmptyStr(dbeVlCon4.Text)) Then
    fltVlCon4 := fStrToFloat(dbeVlCon4.Text);
  If (Not fEmptyStr(dbeVlCon5.Text)) Then
    fltVlCon5 := fStrToFloat(dbeVlCon5.Text);
  edtTotDoc.Text := FloatToStrF(fltVlCon1 + fltVlCon2 + fltVlCon3 + fltVlCon4 + fltVlCon5, ffNumber, 12, 2);
end;

procedure TfrmCadLivroFiscal.pCalculaValorIcmsIpi;
  Var
    fltValIcmAnt: Double;
    fltValIpiAnt: Double;
    strDiferenca: String;

  function fCalculaAliquotaIpi(fltValorIpi, fltBaseIpi: Double): Double;
  Begin
    Try
      If fltBaseIpi = 0 then
        Result := 0
      Else
        Result := ((fltValorIpi / fltBaseIpi) * 100);
    Except
      On E: Exception Do
        Result := 0;
    End;
  End;
begin
  fltValIcmAnt := fStrToFloat(dbeValIcm.Text);
  fltValIpiAnt := fStrToFloat(dbeValIpi.Text);

  If (Not fEmptyStr(dbeBasIcm.Text)) And (Not fEmptyStr(dbeAlqIcm.Text)) Then
    dbeValIcm.Text := FormatFloat('#,##0.00',fCalculaValorIcms(fStrToFloat(dbeBasIcm.Text), fStrToFloat(dbeAlqIcm.Text), fAplicaReducaoICMS(ckbReduzICMS.Checked)));

  {******************************}
  {* TOLERANCIA PARA VALOR ICMS *}
  {***************01/10/2012**CI*}
  strDiferenca := FormatFloat('#,##0.00', Abs(fltValIcmAnt - fStrToFloat(dbeValIcm.Text)));
  If ( strDiferenca <= TOLERANCIA_ICM_IPI) Then
    dbeValIcm.Text := FormatFloat('#,##0.00',fltValIcmAnt);

  If fCfgSis('CVIPIA', varBoolean) Then
  Begin
    If (Not fEmptyStr(dbeBasIPI.Text)) And (Not fEmptyStr(dbeValipi.Text)) Then
      dbeAlqIPI.Text := FormatFloat('#,##0.00', fCalculaAliquotaIpi(fStrToFloat(dbeValIpi.Text), fStrToFloat(dbeBasIPI.Text)));

    {*****************************}
    {* TOLERANCIA PARA VALOR IPI *}
    {**************01/10/2012**CI*}
    strDiferenca := FormatFloat('#,##0.00',Abs(fltValIpiAnt - fStrToFloat(dbeValIpi.Text)));
    If strDiferenca <= TOLERANCIA_ICM_IPI Then
      dbeValIpi.Text := FormatFloat('#,##0.00',fltValIpiAnt);

    If (Not fEmptyStr(dbeBaeIPI.Text)) And (Not fEmptyStr(dbeVaeIpi.Text)) Then
      dbeAleIpi.Text := FormatFloat('#,##0.00', fCalculaAliquotaIpi(fStrToFloat(dbeVaeIpi.Text), fStrToFloat(dbeBaeIPI.Text)));
  End;
end;

procedure TfrmCadLivroFiscal.dbeCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtDesEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(dbeCodEmp, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadLivroFiscal.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryCadEmp, qryCadEmp, dbeCodEmp.Text);

  With qryCadEmp Do
  Begin
    edtDesEmp.Text := FieldByName('EMP_NOMEMP').AsString;
    pCarregaCidadeEmpresa(FieldbyName('EMP_CODCID').AsString);
  End;
end;

procedure TfrmCadLivroFiscal.tbsItensShow(Sender: TObject);
begin
  inherited;
  pCarregaItens;
  pnlBotoes.Enabled := True;
end;

procedure TfrmCadLivroFiscal.tbsItensHide(Sender: TObject);
begin
  inherited;
  qryFisItens.Close;
end;

procedure TfrmCadLivroFiscal.dbeEntSaiChange(Sender: TObject);
begin
  inherited;

  // Verifica se é uma nota de entrada complementar de fornecedor
  // para habilitar a aba "Dados Complementares" (RQ.71079)
  tbsDadosCpl.TabVisible := ((dbeEntSai.Text = 'E') AND
                         (dbeNfComple.Text = 'S') AND
                         (dbeTip_Fc.Text = 'F'));

  fraCadImpostosNFS.strClaFis := dbeClfSc1.Text;
  fraCadImpostosNFS.strEspDoc := dbeEspDoc.Text;
  fraCadImpostosNFS.pCarregarRetencoes;

  tbsNotaAssociadoComplemento.TabVisible := ((dbeNfComple.Text = 'S') and (dbeEntSai.Text = 'E'));
end;

procedure TfrmCadLivroFiscal.dbeEntSaiExit(Sender: TObject);
begin
  inherited;
  pHabilitaNFComplemento;
  pHabilitaCTCompraVenda;
  pHabilitaCodMod;
end;

procedure TfrmCadLivroFiscal.dbeEspDocExit(Sender: TObject);
begin
  inherited;
  pHabilitaCanhotoNF;
  pHabilitaCTCompraVenda;
  pManipulaCampoCodigoVerificador;
  pManipulaCampoCodigoTipoServico;
  pCarregaTipoLancamentoCTE;
end;


procedure TfrmCadLivroFiscal.pHabilitaCTCompraVenda;
begin
  lblCTComVen.Visible := (dbeEspDoc.Text = 'CT') And fCfgSis('COVECT', VarBoolean);
  dbeCTComVen.Visible := (dbeEspDoc.Text = 'CT') And fCfgSis('COVECT', VarBoolean);
end;

{********************************************************}
{* HABILITA A DIGITACAO DA CHAVE DE ACESSO NESSES CASOS *}
{*****************************************************DP*}
procedure TfrmCadLivroFiscal.pHabilitaChaveAcesso;
begin
  dbeChaveAcesso.ReadOnly := Pos(dbeEspDoc.Text,'NF_EL_CT_IF') = 0;
end;

procedure TfrmCadLivroFiscal.pHabilitaCodMod;
begin
  If (dbeEntSai.Text = 'E') or fEmptyStr(dbeEntSai.Text) then
  Begin
    cbxCodMod.Visible := True;
    lblCodMod.Visible := True;
  End
  Else
  Begin
    cbxCodMod.Visible := False;
    lblCodMod.Visible := False;
  End;
end;

function TfrmCadLivroFiscal.fTabTri: String;
begin
  Result := IIF(strTabela = 'MOVDET', 'MOVTRI', 'NOTTRI');
end;

function TfrmCadLivroFiscal.pManipulaCampoCodigoTipoServico: Boolean;
  var
    strClfSc: string;
begin
  strClfSc:= dbeClfSc1.Text+'_'+dbeClfSc2.Text+'_'+dbeClfSc3.Text+'_'+dbeClfSc4.Text+'_'+dbeClfSc5.Text+'_';
  with fraCadImpostosNFS do
  Begin

    if ((IIF(dbeDtaEnt.Text <> '  /  /    ', Length(dbeDtaEnt.Text), 0) > 0) and
      ((StrToDate(dbeDtaEnt.Text)) > StrToDate('31/12/2018'))) and
      ((Pos('933_', strClfSc) > 0) and (fCfgSis('SOLCSV', varBoolean))) then
    begin
      if (fraCadImpostosNFS.edtCodigoVerificacaoNSE.Visible) then
      begin
        lblCodTipoServico.Left:= Label82.Left + Label82.Width + 4 + edtCodigoVerificacaoNSE.Width + 6;
        dbeCodTipoServico.Left:= Label82.Left + Label82.Width + 4 + edtCodigoVerificacaoNSE.Width + 6 + lblCodTipoServico.Width + 4;
      end
      else
      begin
        lblCodTipoServico.Left:= Label82.Left;
        dbeCodTipoServico.Left:= lblCodTipoServico.Left + lblCodTipoServico.Width + 4;
      end;
      lblCodTipoServico.Visible := True;
      dbeCodTipoServico.Visible := True;
    end
    else
    begin
      dbeCodTipoServico.Clear;
      lblCodTipoServico.Visible := False;
      dbeCodTipoServico.Visible := False;
    end;
    Result:= dbeCodTipoServico.Visible;
  End;
end;

procedure TfrmCadLivroFiscal.pManipulaCampoCodigoVerificador;
begin
  If (dbeEspDoc.Text = 'NF') And (Pos(RightStr(dbeClfSc1.Text, 3), '933') > 0) Then
  Begin
    fraCadImpostosNFS.Label82.Visible := True;
    fraCadImpostosNFS.edtCodigoVerificacaoNSE.Visible := True;
  End
  Else
  Begin
    fraCadImpostosNFS.Label82.Visible := False;
    fraCadImpostosNFS.edtCodigoVerificacaoNSE.Visible := False;
  End;
end;

procedure TfrmCadLivroFiscal.pMarcarComoImpresso;
  Var
    qryAux: TUniQuery;
    strTabGer: String;
begin
  strTabGer := AnsiReplaceText(strTabela, 'DET', 'GER');

  If fCupomJaImpresso(strTabGer,
    qryTabela.FieldByName('FIS_NUMDOC').AsString,
    qryTabela.FieldByName('FIS_ESPDOC').AsString,
    qryTabela.FieldByName('FIS_CODEMP').AsString,
    qryTabela.FieldByName('FIS_FORCLI').AsString,
    qryTabela.FieldByName('FIS_SERIE_').AsString) Then
  Begin
    Exit;
  End;

  If fMensagem('', 'Deseja marcar o cupom como impresso?', ['&Sim', 'Não']) = 2 Then
  Begin
    Exit;
  End;

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('UPDATE ' + strTabGer + ' SET ');
  qryAux.SQL.Add('  GER_IMPRES = 1 ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
  qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
  qryAux.SQL.Add('  GER_CODEMP = :CODEMP AND ');
  qryAux.SQL.Add('  GER_CODCLI = :CODCLI AND ');
  qryAux.SQL.Add('  IFNULL(GER_SERIE_, "") = :SERIE_ ');

  qryAux.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
  qryAux.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
  qryAux.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
  qryAux.ParamByName('CODCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
  qryAux.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
  qryAux.ExecSQL;

  FreeAndNil(qryAux);

  pMensagemOk('Cupom marcado como impresso.');
end;

procedure TfrmCadLivroFiscal.pOnStateChange;
begin
  inherited;
  cbxClaFisAcu.Enabled := (qryTabela.State in DsEditModes);
  cbxCodMod.Enabled    := (qryTabela.State in DsEditModes);
  btnConfAcumulador.Enabled := (qryTabela.State in DsEditModes);
  dbgDomAcu.Enabled := (qryTabela.State in DsEditModes);
  tbsGia.Enabled := qryTabela.State = dsEdit;
end;

procedure TfrmCadLivroFiscal.pOnStateChangeFisAju;
begin
  pSetButtonFisAju(qryFisAju, btnIncluirFisAju, btnGravarFisAju, btnExcluirFisAju, btnCancelarFisAju, btnAlterarFisAju);
end;

function TfrmCadLivroFiscal.fReconstruirLivro(blnAtualizarMovGer: Boolean): Boolean;
  Var
    qrySint: TUniQuery;
    intCol: Integer;

    fltTotBasPis: Double;
    fltMaxAlqPis: Double;
    fltTotValPis: Double;
    fltTotBasCof: Double;
    fltMaxAlqCof: Double;
    fltTotValCof: Double;
    intContador: Integer;

    fltTotPro: Double;

    fltTotBasIcm: Double;
    fltMaxAlqIcm: Double;
    fltTotValIcm: Double;
    fltTotBasRet: Double;
    fltTotValRet: Double;
    fltTotBasIpi: Double;
    fltMaxAlqIpi: Double;
    fltTotValIpi: Double;
    fltTotQBCMon: Double;
    fltTotValMon: Double;
    blnAuxFis: Boolean;
begin
  Result := True;

  If strTabela = 'ITECOM' Then
    Exit;

  fltTotBasPis := 0.0;
  fltMaxAlqPis := 0.0;
  fltTotValPis := 0.0;
  fltTotBasCof := 0.0;
  fltMaxAlqCof := 0.0;
  fltTotValCof := 0.0;

  fltTotPro := 0.0;

  fltTotBasIcm := 0.0;
  fltMaxAlqIcm := 0.0;
  fltTotValIcm := 0.0;
  fltTotBasRet := 0.0;
  fltTotValRet := 0.0;
  fltTotBasIpi := 0.0;
  fltMaxAlqIpi := 0.0;
  fltTotValIpi := 0.0;
  fltTotQBCMon := 0.0;
  fltTotValMon := 0.0;

  Try

    qrySint := fCriaQuery(Self);

    With qrySint Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(fRetSQL('MOVDET'));
      pSetaParametros(qrySint);
      Open;

      If (IsEmpty) Then
      Begin
        Close;
        SQL.Clear;
        SQL.Add(fRetSQL('NOTDET'));
        pSetaParametros(qrySint);
        Open;
      End;

    End;

    If (Not FBlnAlterandoItem) And (qrySint.RecordCount > 5) Then
    Begin
      fMensagem('Aviso', 'A combinação de CFOP+Alíquota ultrapassa cinco colunas, favor entrar em contato com o suporte!', ['OK']);
      Exit(False);
    End;

    For intContador := 1 To 5 Do
    Begin
      qryTabela.FieldByName('FIS_CLFSC' + IntToStr(intContador)).AsString := '';
      qryTabela.FieldByName('FIS_VLCON' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_BASIC' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_ALQIC' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_VLRIC' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_OUTRA' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_ISENT' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_BCRET' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_RETID' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_BASAN' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_ANTIC' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_DACES' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_BASIP' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_VLRIP' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_BAERE' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_VAERE' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_BAEIP' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_VAEIP' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_BFCPS' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_VFCPS' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_QBCMO' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_ADREM' + IntToStr(intContador)).AsFloat  := 0;
      qryTabela.FieldByName('FIS_VALMO' + IntToStr(intContador)).AsFloat  := 0;
    End;

    blnAuxFis := fPrepararAuxFisReconstrucao;

    intCol := 1;
    While (Not qrySint.Eof) Do
    Begin

      If (intCol <= 5) Then
      Begin
        qryTabela.FieldByName('FIS_CLFSC' + IntToStr(intCol)).AsString := qrySint.FieldByName('CLAFIS').AsString;
        qryTabela.FieldByName('FIS_VLCON' + IntToStr(intCol)).AsFloat  := qrySint.FieldByName('VLRCON').AsFloat;
        qryTabela.FieldByName('FIS_BASIC' + IntToStr(intCol)).AsFloat  := qrySint.FieldByName('BASICM').AsFloat;
        qryTabela.FieldByName('FIS_ALQIC' + IntToStr(intCol)).AsFloat  := qrySint.FieldByName('ALQICM').AsFloat;
        qryTabela.FieldByName('FIS_VLRIC' + IntToStr(intCol)).AsFloat  := qrySint.FieldByName('VALICM').AsFloat;

        qryTabela.FieldByName('FIS_OUTRA' + IntToStr(intCol)).AsFloat  := qrySint.FieldByName('OUTICM').AsFloat;

        qryTabela.FieldByName('FIS_ISENT' + IntToStr(intCol)).AsFloat  := qrySint.FieldByName('ISEICM').AsFloat;
        qryTabela.FieldByName('FIS_BCRET' + IntToStr(intCol)).AsFloat  := qrySint.FieldByName('BASRET').AsFloat;
        qryTabela.FieldByName('FIS_RETID' + IntToStr(intCol)).AsFloat  := qrySint.FieldByName('VALRET').AsFloat;
        qryTabela.FieldByName('FIS_BASAN' + IntToStr(intCol)).AsFloat  := qrySint.FieldByName('BASANT').AsFloat;
        qryTabela.FieldByName('FIS_ANTIC' + IntToStr(intCol)).AsFloat  := qrySint.FieldByName('VALANT').AsFloat;

        qryTabela.FieldByName('FIS_BAERE' + IntToStr(intCol)).AsFloat := qrySint.FieldByName('BAERET').AsFloat;
        qryTabela.FieldByName('FIS_VAERE' + IntToStr(intCol)).AsFloat := qrySint.FieldByName('VAERET').AsFloat;
        qryTabela.FieldByName('FIS_BAEIP' + IntToStr(intCol)).AsFloat := qrySint.FieldByName('BAEIPI').AsFloat;
        qryTabela.FieldByName('FIS_VAEIP' + IntToStr(intCol)).AsFloat := qrySint.FieldByName('VAEIPI').AsFloat;
        qryTabela.FieldByName('FIS_BFCPS' + IntToStr(intCol)).AsFloat := qrySint.FieldByName('BFCPST').AsFloat;
        qryTabela.FieldByName('FIS_VFCPS' + IntToStr(intCol)).AsFloat := qrySint.FieldByName('VFCPST').AsFloat;
        qryTabela.FieldByName('FIS_BAFCP' + IntToStr(intCol)).AsFloat := qrySint.FieldByName('BASFCP').AsFloat;
        qryTabela.FieldByName('FIS_VLFCP' + IntToStr(intCol)).AsFloat := qrySint.FieldByName('VALFCP').AsFloat;

        {********************************************************}
        {* DESPESA ACESSÓRIA JA ESTA INCLUIDA NO VALOR CONTÁBIL *}
        {*****************************************************RN*}
  //      qryTabela.FieldByName('FIS_DACES' + IntToStr(intCol)).AsFloat  := qrySint.FieldByName('DESACE').AsFloat;

        qryTabela.FieldByName('FIS_BASIP' + IntToStr(intCol)).AsFloat  := qrySint.FieldByName('BASIPI').AsFloat;
        qryTabela.FieldByName('FIS_VLRIP' + IntToStr(intCol)).AsFloat  := qrySint.FieldByName('VALIPI').AsFloat;
        qryTabela.FieldByName('FIS_QBCMO' + IntToStr(intCol)).AsFloat  := qrySint.FieldByName('QBCMON').AsFloat;
        qryTabela.FieldByName('FIS_ADREM' + IntToStr(intCol)).AsFloat  := qrySint.FieldByName('ADREMN').AsFloat;
        qryTabela.FieldByName('FIS_VALMO' + IntToStr(intCol)).AsFloat  := qrySint.FieldByName('VALMON').AsFloat;

        If blnAuxFis Then
          pPreencherAuxFisReconstrucao(intCol, qrySint);
      End;

      fltTotBasPis := fltTotBasPis + qrySint.FieldByName('BASPIS').AsFloat;
      fltTotValPis := fltTotValPis + qrySint.FieldByName('VALPIS').AsFloat;
      fltTotBasCof := fltTotBasCof + qrySint.FieldByName('BASCOF').AsFloat;
      fltTotValCof := fltTotValCof + qrySint.FieldByName('VALCOF').AsFloat;
      fltMaxAlqPis := Max(fltMaxAlqPis, qrySint.FieldByName('ALQPIS').AsFloat);
      fltMaxAlqCof := Max(fltMaxAlqCof, qrySint.FieldByName('ALQCOF').AsFloat);

      fltTotPro := fltTotPro + qrySint.FieldByName('TOTPRO').AsFloat;

      fltTotBasIcm := fltTotBasIcm + qrySint.FieldByName('BASICM').AsFloat;
      fltMaxAlqIcm := Max(fltMaxAlqIcm, qrySint.FieldByName('ALQICM').AsFloat);
      fltTotValIcm := fltTotValIcm + qrySint.FieldByName('VALICM').AsFloat;
      fltTotBasRet := fltTotBasRet + qrySint.FieldByName('BASRET').AsFloat;
      fltTotValRet := fltTotValRet + qrySint.FieldByName('VALRET').AsFloat;
      fltTotBasIpi := fltTotBasIpi + qrySint.FieldByName('BASIPI').AsFloat;
      fltMaxAlqIpi := Max(fltMaxAlqIpi, qrySint.FieldByName('ALQIPI').AsFloat);
      fltTotValIpi := fltTotValIpi + qrySint.FieldByName('VALIPI').AsFloat;
      fltTotQBCMon := fltTotQBCMon + qrySint.FieldByName('QBCMON').AsFloat;
      fltTotValMon := fltTotValMon + qrySint.FieldByName('VALMON').AsFloat;
      Inc(intCol);
      qrySint.Next;
    End;

    If blnAuxFis Then
      qryAuxFis.Post;

    If (Not fLiberaEdicaoBasePISCOFINSEnergiaComunicacao) Then
    Begin
    qryTabela.FieldByName('FIS_BASPIS').AsFloat := fltTotBasPis;

    If Not(qryTabela.FieldByName('FIS_ALQPIS').IsNull) And (qryTabela.FieldByName('FIS_ALQPIS').NewValue <> fCfgSis('ALPISP', varDouble)) Then
      qryTabela.FieldByName('FIS_ALQPIS').AsFloat := qryTabela.FieldByName('FIS_ALQPIS').NewValue
    Else
      qryTabela.FieldByName('FIS_ALQPIS').AsFloat := fCfgSis('ALPISP', varDouble);//fltMaxAlqPis;

    If (qryTabela.FieldByName('FIS_TOTPIS').NewValue <> fltTotValPis) Then
      qryTabela.FieldByName('FIS_TOTPIS').AsFloat := fltTotValPis;

    qryTabela.FieldByName('FIS_BASCOF').AsFloat := fltTotBasCof;

    If Not(qryTabela.FieldByName('FIS_ALQCOF').IsNull) And (qryTabela.FieldByName('FIS_ALQCOF').NewValue <> fCfgSis('ALCOFP', varDouble)) Then
      qryTabela.FieldByName('FIS_ALQCOF').AsFloat:= qryTabela.FieldByName('FIS_ALQCOF').NewValue
    Else
      qryTabela.FieldByName('FIS_ALQCOF').AsFloat := fCfgSis('ALCOFP', varDouble);//fltMaxAlqCof;

    If (qryTabela.FieldByName('FIS_TOTCOF').NewValue <> fltTotValCof) Then
      qryTabela.FieldByName('FIS_TOTCOF').AsFloat := fltTotValCof;
    End;

    qryTabela.FieldByName('FIS_VALIS1').AsFloat := fStrToFloat(fraCadImpostosNFS.dbeValIss.Text);
    pCalculaTotaisItens;

    If (blnAtualizarMovGer) And (Not qryFisItens.IsEmpty) Then
    Begin
      pAtualizarMovGer(fltTotPro, fltTotBasIcm, fltMaxAlqIcm, fltTotValIcm, fltTotBasRet,
        fltTotValRet, fltTotBasIpi, fltMaxAlqIpi, fltTotValIpi);
    End;

   If fClassificaoUnica then
     dbeNatCfo.Text := dbeClfSc1.Text;

   If Not fValidaNatOper Then
   Begin
     pDefineCapaPrimeiraClafisDadosGerais;
   End;

  Finally
    If Assigned(qryAuxFis) And (qryAuxFis.State In [dsEdit, dsInsert]) Then
      qryAuxFis.Cancel;
    FreeAndNil(qrySint);
  End;

  pcalculaTotais;
  pJustaCamposImpostos;
end;

procedure TfrmCadLivroFiscal.pAtualizarMovGer(fltTotPro, fltTotBasIcm, fltMaxAlqIcm,
  fltTotValIcm, fltTotBasRet, fltTotValRet, fltTotBasIpi, fltMaxAlqIpi, fltTotValIpi: Double);
  Var
    qryUpd: TUniQuery;

  function fGetSql(const strTabela, strTabAux: String): String;
  begin
    Result := '';
    Result := Result + 'UPDATE ' + strTabela + ', ' + strTabAux + ' SET ';
    Result := Result + '  GER_TOTPRO = :TOTPRO, ';
    Result := Result + '  GER_BASICM = :BASICM, ';
    Result := Result + '  GER_ALQICM = :ALQICM, ';
    Result := Result + '  GER_TOTICM = :TOTICM, ';
    Result := Result + '  GER_BASRET = :BASRET, ';
    Result := Result + '  GER_TOTRET = :TOTRET, ';
    Result := Result + '  GER_BASIPI = :BASIPI, ';
    Result := Result + '  GER_ALQIPI = :ALQIPI, ';
    Result := Result + '  GER_TOTIPI = :TOTIPI, ';
    Result := Result + '  AUX_BASISS = :BASISS, ';
    Result := Result + '  AUX_REDISS = 100 * (1 - (:BASISS / GER_TOTSER)), ';
    Result := Result + '  GER_PERISS = :PERISS, ';
    Result := Result + '  GER_VALISS = :VALISS, ';
    Result := Result + '  GER_CLAFIS = :CLAFIS, ';
    Result := Result + '  GER_CLAFI2 = :CLAFI2, ';
    Result := Result + '  GER_CLAFI3 = :CLAFI3, ';
    Result := Result + '  GER_CLAFI4 = :CLAFI4 ';
    Result := Result + 'WHERE ';
    Result := Result + '  ' + strTabAux + '.AUX_SEQGER = ' + strTabela + '.AUTOINCREM AND ';
    Result := Result + '  GER_NUMDOC = :NUMDOC AND ';
    Result := Result + '  GER_ESPDOC = :ESPDOC AND ';
    Result := Result + '  GER_CODEMP = :CODEMP AND ';
    Result := Result + '  IF(GER_TIP_FC="C", GER_CODCLI, GER_CODFOR) = :FORCLI AND ';
    Result := Result + '  IFNULL(GER_SERIE_, "") = :SERIE_ AND ';
    Result := Result + '  GER_TIP_FC = :TIP_FC ';
  end;
begin
  qryUpd := fCriaQuery(Self);

  qryUpd.SQL.Add(fGetSql(IIF(strTabela='MOVDET', 'MOVGER', 'NOTGER'),
                         IIF(strTabela='MOVDET', 'AUXMOV', 'AUXNOT')));

  qryUpd.ParamByName('TOTPRO').AsFloat := fltTotPro;
  qryUpd.ParamByName('BASICM').AsFloat := fltTotBasIcm;
  qryUpd.ParamByName('ALQICM').AsFloat := fltMaxAlqIcm;
  qryUpd.ParamByName('TOTICM').AsFloat := fltTotValIcm;
  qryUpd.ParamByName('BASRET').AsFloat := fltTotBasRet;
  qryUpd.ParamByName('TOTRET').AsFloat := fltTotValRet;
  qryUpd.ParamByName('BASIPI').AsFloat := fltTotBasIpi;
  qryUpd.ParamByName('ALQIPI').AsFloat := fltMaxAlqIpi;
  qryUpd.ParamByName('TOTIPI').AsFloat := fltTotValIpi;
  qryUpd.ParamByName('BASISS').AsFloat := fStrToFloat(fraCadImpostosNFS.dbeBasIss.Text);
  qryUpd.ParamByName('PERISS').AsFloat := fStrToFloat(fraCadImpostosNFS.dbeAlqIss.Text);
  qryUpd.ParamByName('VALISS').AsFloat := fStrToFloat(fraCadImpostosNFS.dbeValIss.Text);

  qryUpd.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
  qryUpd.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
  qryUpd.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
  qryUpd.ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
  qryUpd.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
  qryUpd.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
  qryUpd.ParamByName('CLAFIS').AsString := qryTabela.FieldByName('FIS_CLFSC1').AsString;
  qryUpd.ParamByName('CLAFI2').AsString := qryTabela.FieldByName('FIS_CLFSC2').AsString;
  qryUpd.ParamByName('CLAFI3').AsString := qryTabela.FieldByName('FIS_CLFSC3').AsString;
  qryUpd.ParamByName('CLAFI4').AsString := qryTabela.FieldByName('FIS_CLFSC4').AsString;
  qryUpd.ExecSQL;

  FreeAndNil(qryUpd);
end;

procedure TfrmCadLivroFiscal.pRefreshDocumento;
begin
  fStartTransaction;

  Try
    pTryRefreshDocumento;
    fCommit;

    pCarregaDadosAdicionais;

    pMensagemOk('Atualizações concluídas.');
  Except
    On E: Exception Do
    Begin
      fRollback;
      pMensagensErro(E.Message, '[pRefreshDocumento]');
    End;
  End;
end;

procedure TfrmCadLivroFiscal.pRemoveInfCpl;
var
  qryTblMovObs: TUniQuery;
begin
  try
    try
        fStartTransaction;
        qryTblMovObs := fCriaQuery;

        qryTblMovObs.SQL.Clear;
        qryTblMovObs.SQL.Add('DELETE FROM OBSFIS WHERE OBS_SEQFIS = :SEQFIS');
        qryTblMovObs.ParamByName('SEQFIS').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
        qryTblMovObs.ExecSQL;

        fCommit;

        pLimpaDadosComplementares;

    Except
      On E: Exception Do
      Begin
        qryTblMovObs.Cancel;
        pMensagensErro(E.Message, '[TfrmCadLivroFiscal.fGravarTabelasAuxiliares]');
      End;
    End;

  Finally
    FreeAndNil(qryTblMovObs);
  End;
End;

procedure TfrmCadLivroFiscal.pRemoveRegistrosRecTnf;
var
  qryDeleta: TUniQuery;
  I: Integer;
  strSeqFis,
  sTabela,
  sSeqGer,
  sListaMovger,
  sListaNotger: string;
begin
  if (not cdsDocsCTE.Active) or (not qryTabela.Active) then
    Exit;

  if qryTabela.FieldByName('FIS_LCTCTE').AsString <> 'M' Then
    Exit;

  if stlRegistrosExcluidosRECTNF.Count = 0 Then
    Exit;

  // Monta duas listas CSV (uma por tabela de origem) a partir do StringList
  sListaMovger := '';
  sListaNotger := '';
  for I := 0 to stlRegistrosExcluidosRECTNF.Count - 1 do
  Begin
    sTabela := stlRegistrosExcluidosRECTNF.Names[I];
    sSeqGer := stlRegistrosExcluidosRECTNF.ValueFromIndex[I];

    if fEmptyStr(sSeqGer) then
      Continue;

    if sTabela = 'MOVGER' then
    Begin
      if sListaMovger <> '' then
        sListaMovger := sListaMovger + ',';
      sListaMovger := sListaMovger + QuotedStr(sSeqGer);
    End
    else
    Begin
      if sListaNotger <> '' then
        sListaNotger := sListaNotger + ',';
      sListaNotger := sListaNotger + QuotedStr(sSeqGer);
    End;
  End;

  if (sListaMovger = '') and (sListaNotger = '') then
    Exit;

  strSeqFis := qryTabela.FieldByName('AUTOINCREM').AsString;
  qryDeleta := fCriaQuery;
  try
    // 1 DELETE para todos os vínculos via REC_MOVSEQ
    if sListaMovger <> '' then
    Begin
      qryDeleta.SQL.Text :=
        'DELETE FROM RECTNF ' +
        'WHERE REC_CTESEQ = :SEQFIS ' +
        '  AND REC_MOVSEQ IN (' + sListaMovger + ')';
      qryDeleta.ParamByName('SEQFIS').AsString := strSeqFis;
      qryDeleta.ExecSQL;
    End;

    // 1 DELETE para todos os vínculos via REC_NOTSEQ
    if sListaNotger <> '' then
    Begin
      qryDeleta.Close;
      qryDeleta.SQL.Text :=
        'DELETE FROM RECTNF ' +
        'WHERE REC_CTESEQ = :SEQFIS ' +
        '  AND REC_NOTSEQ IN (' + sListaNotger + ')';
      qryDeleta.ParamByName('SEQFIS').AsString := strSeqFis;
      qryDeleta.ExecSQL;
    End;
  finally
    FreeAndNil(qryDeleta);
  end;
end;

procedure TfrmCadLivroFiscal.pSetaParametros(qryAux: TUniQuery);
begin
  With qryAux Do
  Begin
    ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
    ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
    ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
    ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
    ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
  End;
end;

procedure TfrmCadLivroFiscal.pSetButtonFisAju(NomeTabela: TDataSet; btnNovo,
  btnConfirma, btnExclui, btnCancela, btnEditar: TBitBtnLocked);
begin
  If btnNovo.Tag <> 88 Then
    btnNovo.Enabled      := (NomeTabela.State = dsBrowse);

  If btnConfirma.Tag <> 88 Then
    btnConfirma.Enabled  := (NomeTabela.State in [dsInsert, dsEdit]);

  If btnExclui.Tag <> 88 Then
    btnExclui.Enabled    := (NomeTabela.State = dsBrowse);

  If btnCancela.Tag <> 88 Then
    btnCancela.Enabled   := (NomeTabela.State in [dsInsert, dsEdit]);

  If btnEditar.Tag <> 88 Then
    btnEditar.Enabled    := (NomeTabela.State = dsBrowse);
end;

Function TfrmCadLivroFiscal.fTemNotaEletronica: Boolean;
  Var
    qryGerEle: TUniQuery;
Begin
  Result := False;

  If qryTabela.State <> dsEdit Then
    Exit;

  If qryTabela.FieldByName('FIS_TIP_FC').AsString <> 'F' Then
    Exit;

  qryGerEle := fCriaQuery;

  With qryGerEle, SQL Do
  begin
    Add('SELECT GER_DOCENT');
    Add('FROM GERELE');
    Add('WHERE');
    Add('  GER_DOCENT = :NUMDOC AND');
    Add('  GER_ESPENT = :ESPDOC AND');
    Add('  GER_EMPENT = :CODEMP AND');
    Add('  GER_CODFOR = :CODFOR AND');
    Add('  IFNULL(B07_SERIE, "") = :SERIE_  ');

    ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
    ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
    ParamByName('CODFOR').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
    ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;

    Open;

    Result := Not IsEmpty;
  End;

  FreeAndNil(qryGerEle);
End;

function TfrmCadLivroFiscal.fTransformSQL(strCampo: String; intTamanho: Integer;
  strChar: String): String;
Var
  intIndice: Integer;
  intContador: Integer;
begin
  intIndice := 1;
  Result := 'CONCAT_WS(' + QuotedStr(strChar) + ', ';

  For intContador := 1 To 65 Do
  Begin
    Result := Result + 'SUBSTR(' + strCampo + ', ' + IntToStr(intIndice) + ',' + IntToStr(intTamanho) + ')';

    If intContador < 65 Then
      Result := Result + ',';

    Inc(intIndice, intTamanho);
  End;

  Result := Result + ')';
end;

function TfrmCadLivroFiscal.fTransformSQL(strCampo: String): String;
begin
  Result := fTransformSQL(strCampo, 4, '_');
end;

procedure TfrmCadLivroFiscal.pRateiaValores;
  Var
    fltTotFrete  : Double;
    fltTotDesAces: Double;
    fltTmpFrete  : Double;
    fltTmpDesAces: Double;
    fltPerCor    : Double;
    fltPerCorFre : Double;
//    intPrimIteSai: Integer;
    fltTotalItens: Double;
    fltTotQtdIte : Double;

    fltTotPes,
    fltTotFreRes,
    fltDifDesAce: Double;

    qryGen: TUniQuery;
    qryTri: TUniQuery;

    procedure pAtualizaRegistroItem(blnAtualizaFrete: Boolean = True);
    begin
      qryGen.Edit;
      if blnAtualizaFrete then
        qryGen.FieldByName('DET_TOTFRE').AsFloat := fltTmpFrete;
      qryGen.FieldByName('DET_DESACE').AsFloat := fltTmpDesAces;
      qryGen.Post;
    end;

    function fEhItemVenda: Boolean;
    begin
      Result := (qryGen.FieldByName('DET_CODITE').AsString <> fCfgSisL('ITESER')) And
                (qryGen.FieldByName('DET_CODITE').AsString <> fCfgSisL('SERTER'));
    end;

    function fTemRateioDespAcessoria: Boolean;
    begin
      Result := (Abs(fltTmpDesAces) <> 0.0);
    end;

begin
  If fTemNotaEletronica Then
    Exit;

  {***********************}
  {* INICIA AS VARIAVEIS *}
  {********************JC*}
//  intPrimIteSai := -1;
  fltTmpFrete   := 0.0;
  fltTmpDesAces := 0.0;
  fltTotFrete   := 0.0;
  fltTotDesAces := 0.0;
  fltTotalItens := 0.0;
  fltTotPes     := 0.0;
  fltTotQtdIte  := 0.0;

  qryGen := fCriaQuery(Self);
  qryTri := fCriaQuery(Self);
  Try
    qryGen.Close;
    qryGen.SQL.Clear;
    qryGen.SQL.Add('SELECT ');
    qryGen.SQL.Add('   D.AUTOINCREM AS AUTOIN,');
    qryGen.SQL.Add('   D.*,');
    qryGen.SQL.Add('   T.DET_ALQCOF,');
    qryGen.SQL.Add('   T.DET_ALQPIS,');
    qryGen.SQL.Add('   T.DET_OUTICM,');
    qryGen.SQL.Add('   T.DET_BASPIS,');
    qryGen.SQL.Add('   T.DET_VAERET,');
    qryGen.SQL.Add('   T.DET_VAEIPI,');
    qryGen.SQL.Add('   T.DET_BASCOF,');
    qryGen.SQL.Add('   T.DET_VFCPST,');

    If fTabTri = 'MOVTRI' Then
      qryGen.SQL.Add('   T.DET_CODEXT,');

    qryGen.SQL.Add('   ABFICM.*, ');
    qryGen.SQL.Add('   DET_QTDITE * ITE_PESOIT AS PESTOT, ');
    qryGen.SQL.Add('   DET_QTDITE ');

    qryGen.SQL.Add(' FROM  ');
    qryGen.SQL.Add(strTabela + ' D ');
    qryGen.SQL.Add(' INNER JOIN ' + fTabTri + ' T ON T.DET_SEQGER = D.AUTOINCREM');
    qryGen.SQL.Add(' LEFT  JOIN CADITE I ON I.ITE_CODITE = DET_CODITE ');
    If fCfgSis('TIPABF') = '1' Then
    Begin
      qryGen.SQL.Add(' LEFT JOIN ABFICM ON ABF_CODABF = I.ITE_CODABF ');
    End
    Else
    Begin
      qryGen.SQL.Add(' LEFT  JOIN ITEGER G ON G.ITE_CODITE = DET_CODITE AND ');
      qryGen.SQL.Add('                        G.ITE_CODEMP = DET_CODEMP ');
      qryGen.SQL.Add(' LEFT JOIN ABFICM ON ABF_CODABF = G.ITE_CODABF ');
    End;
    qryGen.SQL.Add('  AND ABF_ESTADO = DET_ESTADO ');

    qryGen.SQL.Add(' WHERE                      ');
    qryGen.SQL.Add('   DET_NUMDOC = :NUMDOC AND ');
    qryGen.SQL.Add('   DET_ESPDOC = :ESPDOC AND ');
    qryGen.SQL.Add('   DET_CODEMP = :CODEMP AND ');
    qryGen.SQL.Add('   IFNULL(DET_SERIE_, "") = :SERIE_ AND ');
    qryGen.SQL.Add('   DET_TIP_FC = :TIP_FC AND ');
    If (dbeTip_Fc.Text = 'C') Then
      qryGen.SQL.Add('   DET_CODCLI = :FORCLI ')
    Else qryGen.SQL.Add('   DET_CODFOR = :FORCLI ');

    qryGen.SQL.Add(' ORDER BY D.AUTOINCREM ');

    qryGen.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    qryGen.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
    qryGen.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
    qryGen.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
    qryGen.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
    qryGen.ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
    qryGen.Open;

    If fTabTri = 'MOVTRI' Then
      If not fEmptyStr(qryGen.FieldByName('DET_CODEXT').AsString) Then
        Exit;

    qryTri.SQL.Clear;
    qryTri.SQL.Add(' UPDATE                     ');
    qryTri.SQL.Add(fTabTri);
    qryTri.SQL.Add(' SET                        ');
    qryTri.SQL.Add('   DET_VALCOF = :VALCOF,    ');
    qryTri.SQL.Add('   DET_VALPIS = :VALPIS,    ');
    qryTri.SQL.Add('   DET_OUTICM = :OUTICM,    ');
    qryTri.SQL.Add('   DET_BASPIS = :BASPIS,    ');
    qryTri.SQL.Add('   DET_BASCOF = :BASCOF     ');
    qryTri.SQL.Add(' WHERE                      ');
    qryTri.SQL.Add('   DET_SEQGER = :AUTOIN     ');

    While Not qryGen.Eof Do
    Begin
      pAtualizaRegistroItem();

      If fEhItemVenda Then
      Begin
        fltTotalItens := fltTotalItens + qryGen.FieldByName('DET_TOTITE').AsFloat;
        fltTotPes     := fltTotPes     + qryGen.FieldByName('PESTOT').AsFloat;
        fltTotQtdIte  := fltTotQtdIte  + qryGen.FieldByName('DET_QTDITE').AsFloat;
      End;

      qryGen.Next;
    End;

    If (fFormataFloat(fltTotalItens, 2) > 0.0) Then
    Begin
      fltTotFreRes := fStrToFloat(dbeValFre.Text);

      If (qryGen.FieldByName('DET_ORIDOC').AsString = '') Then
      Begin
          case fCfgSis('RATFRE', varInteger) Of
            1 : tipRatFrete := trfPropValorItem;
            2 : Begin
                  If (fltTotPes > 0) Then
                    tipRatFrete := trfPropPesoItem
                  Else
                    tipRatFrete := trfPropValorItem;
                End;

            3 : tipRatFrete := trfDefinirEntrada;
            4 : tipRatFrete := trfPropQtdItem;
          end;
      End;

      qryGen.First;
      While Not qryGen.Eof Do
      Begin
        If Not fEhItemVenda Then
        Begin
          qryGen.Next;
          Continue;
        End;

        fltPerCor := qryGen.FieldByName('DET_TOTITE').AsFloat / fltTotalItens;

        case tipRatFrete of
          trfPropPesoItem : fltPerCorFre := qryGen.FieldByName('PESTOT').AsFloat / fltTotPes;
          trfPropQtdItem  : fltPerCorFre := qryGen.FieldByName('DET_QTDITE').AsFloat / fltTotQtdIte;
        Else
          fltPerCorFre := fltPerCor;
        end;

        If qryGen.RecNo = qryGen.RecordCount Then
          fltTmpFrete   := fltTotFreRes
        Else
          fltTmpFrete   := fFormataFloat(fStrToFloat(dbeValFre.Text) * fltPerCorFre, 2);

        fltTmpDesAces := fFormataFloat(fStrToFloat(dbeDesAce.Text) * fltPerCor, 2);

        fltTotFrete   := fltTotFrete + fltTmpFrete;
        fltTotDesAces := fltTotDesAces + fltTmpDesAces;

        fltTotFreRes  := fltTotFreRes - fltTmpFrete;

        {**********************************}
        {* ATUALIZA OS VALORES DO PRODUTO *}
        {*******************************AF*}
        pAtualizaRegistroItem;

        qryGen.Next;
      End;

      If (fFormataFloat(fltTotDesAces, 4) <> fFormataFloat(fStrToFloat(dbeDesAce.Text), 4)) Then
        fltDifDesAce := fStrToFloat(dbeDesAce.Text) - fltTotDesAces;

      If fTemRateioDespAcessoria Then
      Begin
        qryGen.Close;
        qryGen.Open;
        qryGen.First;

        While Not qryGen.Eof Do
        Begin
          If Not fEhItemVenda Then
          Begin
            qryGen.Next;
            Continue;
          End;

          fltTmpDesAces := qryGen.FieldByName('DET_DESACE').AsFloat;
          pDistribuiADiferencaDoRateioItens(fltTmpDesAces, fltDifDesAce);
          pAtualizaRegistroItem(False);

          qryGen.Next;
        End;
      End
    End;
  Finally
    FreeAndNil(qryGen);
    FreeAndNil(qryTri);
  End;
end;

procedure TfrmCadLivroFiscal.pCalculaTotais;
begin
   edtVlrConTot.Text := FormatFloat('#0.00', dbeVlCon1.Field.AsFloat   + dbeVlCon2.Field.AsFloat  + dbeVlCon3.Field.AsFloat  + dbeVlCon4.Field.AsFloat  + dbeVlCon5.Field.AsFloat);

   edtBasIcmTot.Text  := FormatFloat('#0.00', dbeBasIc1.Field.AsFloat  + dbeBasIc2.Field.AsFloat  + dbeBasIc3.Field.AsFloat  + dbeBasIc4.Field.AsFloat  + dbeBasIc5.Field.AsFloat);
   edtVlrIcmTot.Text  := FormatFloat('#0.00', dbeVlrIc1.Field.AsFloat  + dbeVlrIc2.Field.AsFloat  + dbeVlrIc3.Field.AsFloat  + dbeVlrIc4.Field.AsFloat  + dbeVlrIc5.Field.AsFloat);

   edtOutrasTot.Text  := FormatFloat('#0.00', dbeOutra1.Field.AsFloat  + dbeOutra2.Field.AsFloat  + dbeOutra3.Field.AsFloat  + dbeOutra4.Field.AsFloat  + dbeOutra5.Field.AsFloat);
   edtIsentaTot.Text  := FormatFloat('#0.00', dbeIsent1.Field.AsFloat  + dbeIsent2.Field.AsFloat  + dbeIsent3.Field.AsFloat  + dbeIsent4.Field.AsFloat  + dbeIsent5.Field.AsFloat);
   
   edtBCRETTot.Text   := FormatFloat('#0.00', dbeBcret1.Field.AsFloat  + dbeBcret2.Field.AsFloat  + dbeBcret3.Field.AsFloat  + dbeBcret4.Field.AsFloat  + dbeBcret5.Field.AsFloat);
   edtRetidTot.Text   := FormatFloat('#0.00', dbeRetid1.Field.AsFloat  + dbeRetid2.Field.AsFloat  + dbeRetid3.Field.AsFloat  + dbeRetid4.Field.AsFloat  + dbeRetid5.Field.AsFloat);
   
   edtBasAntTot.Text  := FormatFloat('#0.00', dbeBasAn1.Field.AsFloat  + dbeBasAn2.Field.AsFloat  + dbeBasAn3.Field.AsFloat  + dbeBasAn4.Field.AsFloat  + dbeBasAn5.Field.AsFloat); 
   edtAnticTot.Text   := FormatFloat('#0.00', dbeAntIc1.Field.AsFloat  + dbeAntIc2.Field.AsFloat  + dbeAntIc3.Field.AsFloat  + dbeAntIc4.Field.AsFloat  + dbeAntIc5.Field.AsFloat);
  

   edtBasIpiTot.Text  := FormatFloat('#0.00', dbeBasIp1.Field.AsFloat  + dbeBasIp2.Field.AsFloat  + dbeBasIp3.Field.AsFloat  + dbeBasIp4.Field.AsFloat  + dbeBasIp5.Field.AsFloat);
   edtVlrIipiTot.Text := FormatFloat('#0.00', dbeVlrIp1.Field.AsFloat  + dbeVlrIp2.Field.AsFloat  + dbeVlrIp3.Field.AsFloat  + dbeVlrIp4.Field.AsFloat  + dbeVlrIp5.Field.AsFloat);
   
   edtBaeRetTot.Text  := FormatFloat('#0.00', dbeBaeRe1.Field.AsFloat  + dbeBaeRe2.Field.AsFloat  + dbeBaeRe3.Field.AsFloat  + dbeBaeRe4.Field.AsFloat  + dbeBaeRe5.Field.AsFloat);
   edtVaeRetTot.Text  := FormatFloat('#0.00', DBEVAERET1.Field.AsFloat + DBEVAERET2.Field.AsFloat + DBEVAERET3.Field.AsFloat + DBEVAERET4.Field.AsFloat + DBEVAERET5.Field.AsFloat);
   
   edtBaeIPITot.Text  := FormatFloat('#0.00', dbeBaeIP1.Field.AsFloat  + dbeBaeIP2.Field.AsFloat  + dbeBaeIP3.Field.AsFloat  + dbeBaeIP4.Field.AsFloat  + dbeBaeIP5.Field.AsFloat);
   edtVaeIPiTot.Text  := FormatFloat('#0.00', DBEVAEIPI1.Field.AsFloat + DBEVAEIPI2.Field.AsFloat + DBEVAEIPI3.Field.AsFloat + DBEVAEIPI4.Field.AsFloat + DBEVAEIPI5.Field.AsFloat);
   
   edtBAFCPTot.Text   := FormatFloat('#0.00', DBEBAFCP1.Field.AsFloat  + DBEBAFCP2.Field.AsFloat  + DBEBAFCP3.Field.AsFloat  + DBEBAFCP4.Field.AsFloat  + DBEBAFCP5.Field.AsFloat);
   edtVLFCPTot.Text   := FormatFloat('#0.00', DBEVLFCP1.Field.AsFloat  + DBEVLFCP2.Field.AsFloat  + DBEVLFCP3.Field.AsFloat  + DBEVLFCP4.Field.AsFloat  + DBEVLFCP5.Field.AsFloat);
   
   edtFCPSTTot.Text   := FormatFloat('#0.00', DBEFCPST1.Field.AsFloat  + DBEFCPST2.Field.AsFloat  + DBEFCPST3.Field.AsFloat  + DBEFCPST4.Field.AsFloat  + DBEFCPST5.Field.AsFloat);
   edtVfcPsTot.Text   := FormatFloat('#0.00', DBEVFCPS1.Field.AsFloat  + DBEVFCPS2.Field.AsFloat  + DBEVFCPS3.Field.AsFloat  + DBEVFCPS4.Field.AsFloat  + DBEVFCPS5.Field.AsFloat);
   edtQtdMonTot.Text  := FormatFloat('#0.00', DBEQBCMO1.Field.AsFloat  + DBEQBCMO2.Field.AsFloat  + DBEQBCMO3.Field.AsFloat + DBEQBCMO4.Field.AsFloat  + DBEQBCMO5.Field.AsFloat);
   edtValMonTot.Text  := FormatFloat('#0.00', DBEVALMO1.Field.AsFloat  + DBEVALMO2.Field.AsFloat  + DBEVALMO3.Field.AsFloat + DBEVALMO4.Field.AsFloat  + DBEVALMO5.Field.AsFloat);

   edtBCCBSTot.Text   := FormatFloat('#0.00', fSomarBlocosAuxFis('FIS_BCCBS'));
   edtVLCBSTot.Text   := FormatFloat('#0.00', fSomarBlocosAuxFis('FIS_VLCBS'));
   edtBCIBSTot.Text   := FormatFloat('#0.00', fSomarBlocosAuxFis('FIS_BCIBS'));
   edtVLIBSTot.Text   := FormatFloat('#0.00', fSomarBlocosAuxFis('FIS_VLIBS'));
   edtBC_ISTot.Text   := FormatFloat('#0.00', fSomarBlocosAuxFis('FIS_BC_IS'));
   edtVL_ISTot.Text   := FormatFloat('#0.00', fSomarBlocosAuxFis('FIS_VL_IS'));

   pCarregarPainelValorLiquido;
end;

procedure TfrmCadLivroFiscal.pCalcularValoresUFDest;
  Var
    fltDifAlq: Double;
    fltValDifAlq: Double;
begin
  fltDifAlq := fStrToFloat(edtAlqInterna.Text) - fStrToFloat(edtAlqInterestadual.Text);
  fltValDifAlq := fFormataFloat(fStrToFloat(edtBaseUFDest.Text) * fltDifAlq / 100, 2);

  edtIcmsDestino.Text := FloatToStrF(fFormataFloat(fltValDifAlq * fStrToFloat(edtPercentualPartilha.Text) / 100, 2), ffNumber, 12, 2);
  edtIcmsOrigem.Text := FloatToStrF(fltValDifAlq - fStrToFloat(edtIcmsDestino.Text), ffNumber, 12, 2);
end;


procedure TfrmCadLivroFiscal.pCalculaTotaisItens;
  Var fltTotal, fltVlCon, fltTotDesEsp: Double;
      intRecNo: Integer;
begin

  fltTotal := 0;
  fltVlCon := 0;
  fltTotDesEsp := 0;

  With qryFisItens Do
  Begin

    intRecNo := RecNo;
    DisableControls;
    First;

    While (Not Eof) Do
    Begin
      fltTotal := fltTotal + FieldByName('TOTITE').AsFloat;
      fltVlCon := fltVlCon + FieldByName('VLRCON').AsFloat;
      fltTotDesEsp := fltTotDesEsp + FieldByName('DESESP').AsFloat;

      Next;
    End;

    RecNo := intRecNo;
    EnableControls;
  End;
end;

function TfrmCadLivroFiscal.fValidaCstCofinsLivro(dbeCampo: TDBEdit;
  ipcImposto: TImpostoPisCofins; blnCstBranca: Boolean): Boolean;
  Var
    oldValue: Variant;

  function fImp: String;
  begin
    Result := IIF(ipcImposto = ipcPis, 'PIS', 'COFINS');
  end;
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
          If fMensagem('', 'Deseja realmente apagar a CST de ' + fImp + '?', ['', '']) = 2 Then
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
    fMensagem('ATENÇÃO!', 'CST de ' + fImp + ' inválida.!', ['&Ok']);
    Result := False;
  End;
end;

function TfrmCadLivroFiscal.fValidaFechamentoFiscalEstoque(AdtaDtaEnt: TDate = 0): Boolean;
Var
  dtaDataAux: TDate;
begin
  Result := True;

  If Not fCfgSis('UTIFEC', varBoolean) then
    Exit;

  If (AdtaDtaEnt = 0) Then
    dtaDataAux := StrToDate(dbeDtaEnt.Text)
  Else
    dtaDataAux := AdtaDtaEnt;

  If Not objFechamentoFiscal.fDataFiscalPermitida(dtaDataAux, '', False, dbeCodEmp.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'A data de entrada é menor que a data do fechamento fiscal (' + FormatDateTime('DD/MM/YYYY', TFechamentoFiscal.fDataFechamento(dbeCodEmp.Text)) +
                            '), não pode ser alterado.', ['&Ok']);
    Exit(False);
  End;

  If Not objFechamentoEstoque.fDataDeEntradaPermitida(dtaDataAux, '', False, dbeCodEmp.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'A data de entrada é menor que a data do fechamento de estoque ('+ FormatDateTime('DD/MM/YYYY', objFechamentoEstoque.fDataFechamento(dbeCodEmp.Text)) +
                            '), não pode ser alterado.', ['&Ok']);
    Exit(False);
  End;
end;

function TfrmCadLivroFiscal.fValidaNatOper: Boolean;
begin
  Result := False;
  If (dbeClfSc1.Text = dbeNatCfo.Text) Or
     (dbeClfSc2.Text = dbeNatCfo.Text) Or
     (dbeClfSc3.Text = dbeNatCfo.Text) Or
     (dbeClfSc4.Text = dbeNatCfo.Text) Or
     (dbeClfSc5.Text = dbeNatCfo.Text) Then
  Result := True;

  If qryFisItens.Active Then
    Result := Result Or qryFisItens.Locate('CLAFIS', dbeNatCfo.Text, []);
end;

function TfrmCadLivroFiscal.fValidaAcumuladoresConf: Boolean;
Var
  fltSomaPercentual: Double;
begin
  Result := True;

  fltSomaPercentual := 0;

  cdsDomAcu.First;

  While not cdsDomAcu.Eof Do
  Begin
    If (cdsDomAcu.FieldByName('ACU_CLAFIS').AsString = LeftStr(cbxClaFisAcu.Text, 4)) And
       (cdsDomAcu.FieldByName('ACU_ALQICM').AsFloat = fRetornaAlqDoCombo(cbxClaFisAcu.Text)) Then
      fltSomaPercentual := fltSomaPercentual + cdsDomAcu.FieldByName('ACU_PERACU').AsFloat;
    cdsDomAcu.Next;
  End;

  cdsDomAcu.IndexFieldNames := 'ACU_CLAFIS;ACU_ALQICM;ACU_CODACU';
  If cdsDomAcu.FindKey([LeftStr(cbxClaFisAcu.Text, 4),
                       fRetornaAlqDoCombo(cbxClaFisAcu.Text),
                       edtCodAcu.Text]) Then
  Begin
    fMensagem('ATENÇÃO!', 'Já existe um registro cadastrado para Classificação [' + cbxClaFisAcu.Text + '] e Acumulador [' + edtCodAcu.Text + '] . Para excluir um registro já inserido, selecione-o e aperte [DEL].', ['&Ok']);
    Result := False;
    Exit;
  End;

  If fFormataFloat(fltSomaPercentual + fStrToFloat(edtPerAcu.Text), 2) > 100 Then
  Begin
    fMensagem('ATENÇÃO!', 'Impossível prosseguir. A soma dos percentuais para [' + cbxClaFisAcu.Text + '] será maior que 100%. Para excluir um registro já inserido, selecione-o e aperte [DEL].', ['&Ok']);
    Result := False;
    Exit;
  End;

  cdsDomAcu.First;
end;

function TfrmCadLivroFiscal.fValidaAcumuladoresGrav: Boolean;
Var
  dicAcumulado: TDictionary<String, Double>;
  strChaveAcu: String;
  strChaveFis: String;
  intCont: Integer;
begin
  Result := True;

  dicAcumulado := TDictionary<String, Double>.Create;

  cdsDomAcu.First;
  While not cdsDomAcu.Eof Do
  Begin
    strChaveAcu := cdsDomAcu.FieldByName('ACU_CLAFIS').AsString + ' - ' + FormatFloat('#,##0.00', cdsDomAcu.FieldByName('ACU_ALQICM').AsFloat) + '%';

    For intCont := 1 to 5 Do
    Begin
      strChaveFis := strChaveFis + qryTabela.FieldByName('FIS_CLFSC' + IntToStr(intCont)).AsString + ' - ' +
                     FormatFloat('#,##0.00', qryTabela.FieldByName('FIS_ALQIC' + IntToStr(intCont)).AsFloat) + '%_';
    End;

    If Pos(strChaveAcu, strChaveFis) <= 0 Then
    Begin
      Result := False;
      fMensagem('ATENÇÃO!', 'A classificação [' +  strChaveAcu + '] cadastrada no Domínio Acumulador não existe nas classificações do Livro Fiscal (Aba "Dados Gerais"). Para excluir um registro já inserido, selecione-o e aperte [DEL].).', ['&Ok']);
      pgcDetalhes.ActivePageIndex := 5;
      Exit;
    End;

    If dicAcumulado.ContainsKey(strChaveAcu) Then
      dicAcumulado[strChaveAcu] := dicAcumulado[strChaveAcu] + cdsDomAcu.FieldByName('ACU_PERACU').AsFloat
    Else
      dicAcumulado.Add(strChaveAcu, cdsDomAcu.FieldByName('ACU_PERACU').AsFloat);

    cdsDomAcu.Next;
  End;

  If Result Then
  Begin
    For strChaveAcu In dicAcumulado.Keys Do
    Begin
      If dicAcumulado[strChaveAcu] <> 100 Then
      Begin
        Result := False;
        fMensagem('ATENÇÃO!', 'A soma da classificação [' +  strChaveAcu + '] deve ser igual a 100% no cadastro do Domínio Acumulador.', ['&Ok']);
        pgcDetalhes.ActivePageIndex := 5;
        Break;
      End;
    End;
  End;

  FreeAndNil(dicAcumulado);
end;

procedure TfrmCadLivroFiscal.pSetaTabelaEAutoIncremContabilidade(var RegistroContabilidade: TrecRegistroContabilidade);
  var
    qryConsulta: TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT AUTOINCREM FROM MOVGER');
    qryConsulta.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC');
    qryConsulta.SQL.Add('   AND GER_ESPDOC = :ESPDOC');
    qryConsulta.SQL.Add('   AND IFNULL(GER_SERIE_, "") = :SERIE_');
    qryConsulta.SQL.Add('   AND GER_TIP_FC = :TIP_FC');
    If qryTabela.FieldByName('FIS_TIP_FC').AsString = 'F' Then
      qryConsulta.SQL.Add('   AND GER_CODFOR = :FORCLI')
    Else
      qryConsulta.SQL.Add('   AND GER_CODCLI = :FORCLI');
    qryConsulta.SQL.Add('   AND GER_CODEMP = :CODEMP');

    qryConsulta.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    qryConsulta.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
    qryConsulta.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
    qryConsulta.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
    qryConsulta.ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
    qryConsulta.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;

    qryConsulta.Open;

    If qryConsulta.IsEmpty Then
    Begin
      qryConsulta.SQL.Text := AnsiReplaceStr(qryConsulta.SQL.Text, 'MOVGER', 'NOTGER');
      qryConsulta.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
      qryConsulta.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
      qryConsulta.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
      qryConsulta.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
      qryConsulta.ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
      qryConsulta.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
      qryConsulta.Open;
      If qryConsulta.IsEmpty Then
        Exit;
      RegistroContabilidade.ttpTabela := ttNotger;
    End
    Else
      RegistroContabilidade.ttpTabela := ttMovGer;

    RegistroContabilidade.strSeqGer := qryConsulta.FieldByName('AUTOINCREM').AsString;
  Finally
    FreeAndNil(qryConsulta);
  End;
End;

procedure TfrmCadLivroFiscal.pAtualizaServico;
  Var
    qryUpd: TUniQuery;

  function fGetSql(const strTabela, strTabAux: String): String;
  begin
    Result := '';
    Result := Result + 'UPDATE ' + strTabela + ', ' + strTabAux + ' SET ';
    Result := Result + '  AUX_BASISS = :BASISS, ';
    Result := Result + '  AUX_REDISS = 100 * (1 - (:BASISS / GER_TOTSER)), ';
    Result := Result + '  GER_PERISS = :PERISS, ';
    Result := Result + '  GER_VALISS = :VALISS  ';
    Result := Result + 'WHERE ';
    Result := Result + '  ' + strTabAux + '.AUX_SEQGER = ' + strTabela + '.AUTOINCREM AND ';
    Result := Result + '  GER_NUMDOC = :NUMDOC AND ';
    Result := Result + '  GER_ESPDOC = :ESPDOC AND ';
    Result := Result + '  GER_CODEMP = :CODEMP AND ';
    Result := Result + '  IF(GER_TIP_FC="C", GER_CODCLI, GER_CODFOR) = :FORCLI AND ';
    Result := Result + '  IFNULL(GER_SERIE_, "") = :SERIE_ AND ';
    Result := Result + '  GER_TIP_FC = :TIP_FC ';
  end;
begin
  qryUpd := fCriaQuery(Self);

  qryUpd.SQL.Add(fGetSql(IIF(strTabela='MOVDET', 'MOVGER', 'NOTGER'),
                         IIF(strTabela='MOVDET', 'AUXMOV', 'AUXNOT')));

  qryUpd.ParamByName('BASISS').AsFloat := fStrToFloat(fraCadImpostosNFS.dbeBasIss.Text);
  qryUpd.ParamByName('PERISS').AsFloat := fStrToFloat(fraCadImpostosNFS.dbeAlqIss.Text);
  qryUpd.ParamByName('VALISS').AsFloat := fStrToFloat(fraCadImpostosNFS.dbeValIss.Text);

  qryUpd.ParamByName('NUMDOC').AsString := qryTabela.FieldByName('FIS_NUMDOC').AsString;
  qryUpd.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('FIS_ESPDOC').AsString;
  qryUpd.ParamByName('CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
  qryUpd.ParamByName('FORCLI').AsString := qryTabela.FieldByName('FIS_FORCLI').AsString;
  qryUpd.ParamByName('SERIE_').AsString := qryTabela.FieldByName('FIS_SERIE_').AsString;
  qryUpd.ParamByName('TIP_FC').AsString := qryTabela.FieldByName('FIS_TIP_FC').AsString;
  qryUpd.ExecSQL;

  FreeAndNil(qryUpd);
end;

procedure TFrmCadLivroFiscal.pHabilitaDadosOffline;
var
  LVisible: Boolean;
begin
  LVisible := (qryTabela.FieldByName('FIS_DOCOFF').AsString = 'S');

  dbeDataNFCeOffline.Enabled  := False;
  dbeChaveNFCeOffline.Enabled := False;

  lblNFCeOffline.Visible      := LVisible;
  lblDataNFCeOffline.Visible  := LVisible;
  dbeDataNFCeOffline.Visible  := LVisible;
  lblChaveNFCeOffline.Visible := LVisible;
  dbeChaveNFCeOffline.Visible := LVisible;
end;


procedure TFrmCadLivroFiscal.pCarregarStatus;
Var
  strStatus: String;
Begin
  strStatus := fCampoTabela('NFE_STATUS', 'LOGNFE', ['NFE_ACESSO'], [qryTabela.FieldByName('FIS_ACESSO').AsString]);

  lblStatus.Visible := (strStatus = 'DN')
    And (Pos('DENEGAD',qryTabela.FieldByName('FIS_HISTOR').AsString) > 0)
    And (AnsiIndexStr(qryTabela.FieldByName('FIS_ESPDOC').AsString, ['NF','IF']) >= 0)
End;

procedure TFrmCadLivroFiscal.pSetaComboNatOpe(ACbxCombo: TComboBox; AstrClaFis: String; ABlnItem: Boolean);
begin
  If Not(fEmptyStr(AstrClaFis)) Then
  Begin
    pCarregaNatOperacao(ACbxCombo, AstrClaFis);
    If Not(fEmptyStr(qryFisItens.FieldByName('DET_NATOPE').AsString)) Then
    Begin
      If ABlnItem Then
      Begin
        If ACbxCombo.Items.IndexOf(qryFisItens.FieldByName('DET_NATOPE').AsString) > -1 Then
          ACbxCombo.ItemIndex := ACbxCombo.Items.IndexOf(qryFisItens.FieldByName('DET_NATOPE').AsString)
        Else
          ACbxCombo.ItemIndex := 0;
      End
    End
    Else
    If qryFisItens.IsEmpty Then
    Begin
      If ACbxCombo.Items.IndexOf(qryTabela.FieldByName('FIS_NATOPE').AsString) > -1 Then
        ACbxCombo.ItemIndex := ACbxCombo.Items.IndexOf(qryTabela.FieldByName('FIS_NATOPE').AsString)
      Else
        ACbxCombo.ItemIndex := 0;
    End
    Else
      pAtualizaComboNatOpe(ACbxCombo);
  End;
end;

procedure TFrmCadLivroFiscal.pAtualizaComboNatOpe(ACbxCombo: TComboBox);
Begin
  pCarregaNatOperacao(ACbxCombo, dbeNatCfo.Text);
  ACbxCombo.ItemIndex := 0;
End;

procedure TFrmCadLivroFiscal.pCarregaNatOperacao(ACbxCombo: TComboBox; AstrCodCfo: String);
var
  qryNatOpe: TUniQuery;
Begin
  qryNatOpe := fCriaQuery(Self);
  Try
    qryNatOpe.Close;
    qryNatOpe.SQL.Clear;
    qryNatOpe.SQL.Add(' SELECT AUTOINCREM, NAT_DESCRI FROM NATCFO');
    qryNatOpe.SQL.Add(' WHERE NAT_CODCFO = :CODCFO');
    qryNatOpe.SQL.Add('   AND NAT_ATIVO_ = ' + QuotedStr('S'));

    qryNatOpe.ParamByName('CODCFO').AsString := AstrCodCfo;
    qryNatOpe.Open;

    ACbxCombo.Clear;
    qryNatOpe.First;
    While not qryNatOpe.eof do
    Begin                       
      ACbxCombo.Items.AddObject(qryNatOpe.FieldByName('NAT_DESCRI').AsString,TObject(qryNatOpe.FieldByName('AUTOINCREM').AsString));
      qryNatOpe.Next;
    End;

    If qryNatOpe.RecordCount > 0 Then
      ACbxCombo.ItemIndex := 0;

  Finally
    FreeAndNil(qryNatOpe);
  End;

End;

function TfrmCadLivroFiscal.fRetAutoIncremNatCfo(AStrNatCfo, AStrNatOpe: String): String;
begin
  Result := fCampoTabela('AUTOINCREM', 'NATCFO', ['NAT_CODCFO','NAT_DESCRI'], [AStrNatCfo, AStrNatOpe]);
end;

function TfrmCadLivroFiscal.fRetNatOpeItemDaCapa: String;
begin
  Result := '';

  If qryFisItens.isEmpty Then
    Exit(qrytabela.fieldByName('FIS_NATOPE').AsString);

  qryFisItens.Filter := 'CLAFIS = ' + QuotedStr(dbeClfSc1.Text) + ' AND ALQICM = ' + dbeAlqIc1.Text;
  qryFisItens.Filtered := True;
  Result := qryFisItens.FieldByName('DET_NATOPE').AsString;
  qryFisItens.Filtered := False;
end;

function TfrmCadLivroFiscal.fItemDefineACapa: Boolean;
begin
  if qryFisItens.Active Then
    Result := qryFisItens.RecordCount = 1
  else
    Result := False;
end;

procedure TfrmCadLivroFiscal.pDeletaCTPDET(strNumDup, strParcel, strSerie,
  strCodFor, strCodEmp: String);
Var
  strSQL: String;
  qryTemp02: TUniQuery;

begin
  qryTemp02 := fCriaQuery(Self);

  {*******************************************}
  {* SELECIONA O REGISTRO NO CTPDET PARA SER *}
  {* GRAVADO NOS DELETADOS                   *}
  {****************************************MV*}
  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + ' CTPDET ' ;
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';

  If fEmptyStr(strSerie) Then
    strSQL := strSQL + ' ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) AND '
  Else
    strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';

  strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
  strSQL := strSQL + '  CTP_EMPORI = :CODEMP ';

  qryTemp02.Close;
  qryTemp02.SQL.Clear;
  qryTemp02.SQL.Add(strSQL);
  qryTemp02.ParamByName('NUMDUP').AsString := strNumDup;
  qryTemp02.ParamByName('PARCEL').AsString := strParcel;

  If (Not fEmptyStr(strSerie)) Then
    qryTemp02.ParamByName('SERIE_').AsString := strSerie;

  qryTemp02.ParamByName('CODFOR').AsString := strCodFor;
  qryTemp02.ParamByName('CODEMP').AsString := strCodEmp;
  qryTemp02.Open;

  While (Not qryTemp02.Eof) Do
  Begin
    untLogCtpDet.GravaLogCtpDet(qryTemp02.FieldByName('AUTOINCREM').AsString,
                                'EXCLUSÃO LIVRO FISCAL',
                                'frmCadLivroFiscal');

    fVerificaIntegridade(Self.Name, 'CTPDET', qryTemp02, True, False, EmptyStr, strLoginUsuarioLogado);

    qryTemp02.Next;
  End;
end;

procedure TfrmCadLivroFiscal.pDefineCapaPrimeiraClafisDadosGerais;
var
  strIemCapa : String;
begin
  dbeNatCfo.Text := dbeClfSc1.Text;
  pCarregaNatOperacao(cmbNatOpe, dbeNatCfo.Text);

  if fItemDefineACapa then
  begin
    strIemCapa := fRetNatOpeItemDaCapa;

    If cmbNatOpe.Items.Indexof(strIemCapa) > -1 Then
      cmbNatOpe.ItemIndex := cmbNatOpe.Items.Indexof(strIemCapa)
    Else
      cmbNatOpe.itemIndex := 0;
  end;
end;

procedure TfrmCadLivroFiscal.pCarregarPainelValorLiquido;
Var
  objEdit: TDBEditFocus;
  arrEdit: TArray<TDBEditFocus>;
begin
  pnlValorLiquido.Visible := False;
  arrEdit := [dbeClfSc1,dbeClfSc2,dbeClfSc3,dbeClfSc4,dbeClfSc5];
  For objEdit In arrEdit Do
    If Not pnlValorLiquido.Visible Then
      pnlValorLiquido.Visible := Pos('933',objEdit.Text) > 0;
  pCalcularValorLiquido;
End;

procedure TfrmCadLivroFiscal.pCalcularValorLiquido;
Var
  objValorLiquido: TEditFocus;
  curValorTotal: Currency;
  intContador: Integer;
  curValorRetencao: Currency;
  curFisVlCon: Currency;
  strCFOP: String;
Begin
  curValorRetencao := fValorTotalRetencao;
  curValorTotal := 0;
  For intContador := 1 To 5 Do
  Begin
    curFisVlCon := qryTabela.FieldByName('FIS_VLCON' + intContador.ToString).AsCurrency;
    strCFOP := qryTabela.FieldByName('FIS_CLFSC' + intContador.ToString).AsString;

    curValorTotal := curValorTotal + curFisVlCon;
    objValorLiquido := TEditFocus(FindComponent('DBEVLLIQ' + intContador.ToString));
    objValorLiquido.Text := '0,00';
    If Pos('933',strCFOP) > 0 Then
      objValorLiquido.Text := FormatFloat('#,##0.00',  curFisVlCon - curValorRetencao);
  End;
  edtVlrLiqTot.Text := FormatFloat('#,##0.00',curValorTotal  - curValorRetencao);
End;

function TfrmCadLivroFiscal.fValorTotalRetencao: Currency;
Var
  strCampo: String;
Begin
  Result := 0;
  For strCampo In 'FIS_VREPIS,FIS_RETISS,FIS_VRECOF,FIS_RECSSL,FIS_REIRRF,FIS_REINSS'.Split([',']) Do
    Result := Result + qryTabela.FieldByName(strCampo).AsCurrency;
End;

function TfrmCadLivroFiscal.fCriaQryUpdNatOpeItem: TUniQuery;
begin
  Result := fCriaQuery;
  Result.SQL.Clear;
  Result.SQL.Add('UPDATE MOVTRI SET DET_NATOPE = :NATOPE WHERE DET_SEQGER = :AUTOIN ');
end;

procedure TfrmCadLivroFiscal.pPadrao;
Begin
  qryTabela.FieldByName('FIS_TIP_FC').AsString := 'F';
  qryTabela.FieldByName('FIS_ENTSAI').AsString := 'E';
End;

procedure TfrmCadLivroFiscal.pConferirDocumento;
Begin
  qryTabela.FieldByName('FIS_CODCOF').AsString := strLoginUsuarioLogado;
  qryTabela.FieldByName('FIS_DTACOF').AsDateTime := fNow;
  qryTabela.FieldByName('FIS_HORCOF').AsDateTime := fNow;
End;

procedure TfrmCadLivroFiscal.pConferirDocumento(const blnConferir : Boolean);
begin
  If (Not Assigned(qryTabela)) Then
    Exit;
  If (Not qryTabela.Active) Then
    Exit;
  If (qryTabela.IsEmpty) Then
    Exit;
  If (Not dtsTabela.AutoEdit) Then
    Exit;
  If (Not btnIncluir.Enabled) Then
    Exit;
  If (qryTabela.State <> dsEdit) Then
    Exit;
  pSetaValoresConferencia(blnConferir);
  qryTabela.Post;
  pSetFocus(btnAlterar);
end;

procedure TfrmCadLivroFiscal.pSetaValoresConferencia(const blnConferir : Boolean);
begin
  If (blnConferir) Then
  Begin
    qryTabela.FieldByName('FIS_CODCOF').AsString := strLoginUsuarioLogado;
    qryTabela.FieldByName('FIS_DTACOF').AsDateTime := fNow;
    qryTabela.FieldByName('FIS_HORCOF').AsDateTime := fNow;
    qryTabela.FieldByName('FIS_CONFER').AsInteger := 1;
  End
  Else
  Begin
    qryTabela.FieldByName('FIS_CODCOF').Value := Null;
    qryTabela.FieldByName('FIS_DTACOF').Value := Null;
    qryTabela.FieldByName('FIS_HORCOF').Value := Null;
    qryTabela.FieldByName('FIS_CONFER').AsInteger := 0;
  End;
end;

procedure TfrmCadLivroFiscal.pSetarFocusPadrao;
Begin
  pSetFocus(dbeTip_Fc);
End;

procedure TfrmCadLivroFiscal.pValorOutras;
Var
    fltVlCon, fltBasIcm, fltIsent, fltOutra: Double;
Begin
  // Sincroniza FIS_OUTRA1 com o "valor contábil" para CFOPs de
  // energia/comunicação.
  //
  // Regra fiscal:
  //   FIS_OUTRA1 = FIS_VLCON1 - FIS_BASIC1 - FIS_ISENT1
  //   (parcela do valor contábil que não é base de ICMS nem isenta)
  //
  // A atribuição é incondicional dentro do CFOP alvo — quando todo o
  // valor é tributado (BasIcm = VlCon), a fórmula gera 0 e o campo é
  // zerado explicitamente, evitando resíduo de edições anteriores.

  If (qryTabela.State In dsEditModes) And
     (Pos(dbeClfSc1.Text, CFOP_ENERGIA + CFOP_COMUNICACAO) > 0) Then
  Begin
    fltVlCon  := fStrToFloat(dbeVlCon1.Text);
    fltBasIcm := fStrToFloat(dbeBasIc1.Text);
    fltIsent  := fStrToFloat(dbeIsent1.Text);

    fltOutra := fltVlCon - fltBasIcm - fltIsent;
    If fltOutra < 0 Then
      fltOutra := 0;

    qryTabela.FieldByName('FIS_OUTRA1').Value := fltOutra;
  End;
End;

function TfrmCadLivroFiscal.fValidarDocumentoConferido: Boolean;
Var
  strMensagem: String;
  strCodOpe,
  strNomOpe: String;
  dtaDataHora: TDateTime;
Begin
  strCodOpe := qryTabela.FieldByName('FIS_CODCOF').AsString;
  strNomOpe := FRetNomeOperador(strCodOpe);
  dtaDataHora := qryTabela.FieldByName('FIS_DTACOF').AsDateTime +
    qryTabela.FieldByName('FIS_HORCOF').AsDateTime;

  strMensagem := 'Confirmação' + #13;
  strMensagem := strMensagem + 'O documento fiscal já está conferido. Ao atualizar o documento, os dados' + #13;
  strMensagem := strMensagem + 'da conferência já cadastrados serão atualizados.' + #13;
  strMensagem := strMensagem + 'Operador Conferente: ' + strCodOpe + ' - ' + strNomOpe + #13;
  strMensagem := strMensagem + 'Data/Hora Conferência: ' + FormatDateTime('dd/mm/yyyy hh:nn:ss', dtaDataHora) + 'hs';
  Result := fMensagem('ATENÇÃO!', strMensagem, ['&Confirmar', 'Cancelar']) = 1;
End;

function TfrmCadLivroFiscal.fValidarLiberarDocumentoConferido: Boolean;
Begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTextoCaption('Motivo:', 'Operador solicita a liberação para editar documento fiscal já conferido, conforme '+
    'dados da conferência abaixo:');
  objLiberacao.objMsgLibera.pAddTextoCaption('Operador Conferente:', qryTabela.FieldByName('FIS_CODCOF').AsString + ' - ' +
    fRetNomeOperador(qryTabela.FieldByName('FIS_CODCOF').AsString));
  objLiberacao.objMsgLibera.pAddTextoCaption('Data/Hora Conferência:',FormatDateTime('dd/mm/yyyy hh:nn:ss', qryTabela.FieldByName('FIS_DTACOF').AsDateTime +
    qryTabela.FieldByName('FIS_HORCOF').AsDateTime)+  ' hs');
  objLiberacao.objMsgLibera.pAddTextoCaption('Operador Solicitante:', strLoginUsuarioLogado + ' - ' + fRetNomeOperador(strLoginUsuarioLogado));
  objLiberacao.objMsgLibera.pAddTextoCaption('Documento Fiscal:', '9999999999  Especie: 00');
  objLiberacao.objMsgLibera.pAddTextoCaption('Empresa:',VS_strCodEmp + ' - ' + fRetDadosEmpresa.strNome);


  objLiberacao.strDirAce := 'ALTDOCCONFE';
  objLiberacao.strMsgSen := 'Liberar documento conferido';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  objLiberacao.strCodDig := strLoginUsuarioLogado;
  objLiberacao.tipCliFor := cfFornecedor;
  Result := objLiberacao.fLibera;
End;

function TfrmCadLivroFiscal.fFiltroCFOP: String;
Begin
  If Not fEmptyStr(strCodCfo)Then
    Result := 'LOCATE(CFO_CODCFO, ' + strCodCfo + ')';
End;

procedure TfrmCadLivroFiscal.pCadastrarGia;
Begin
  qryCadOcr := fCriarQuery('SELECT * FROM CADOCR WHERE FALSE', Self);
  dtsCadOcr.DataSet:=qryCadOCr;

  qryFundamentoLegal := fCriarQuery('SELECT * FROM CADFUL', Self);
  dtsDescricaoFundamentoLegal.DataSet := qryFundamentoLegal;
  qryFundamentoLegal.Open;

  qryDescricaoOcorrencia := fCriarQuery('SELECT * FROM CADDOC', Self);
  dtsDescricaoOcorrencia.DataSet := qryDescricaoOcorrencia;
  qryDescricaoOcorrencia.Open;
End;

function TfrmCadLivroFiscal.fValidarEntradaCT: Boolean;
Begin
  Result := (dbeEspDoc.Text = 'CT')
    And ((StrToIntDef(fGetModDocumentocbxCODMOD,-1)In [57,67])
      And (pos(Copy(dbeClfSc1.text, 2, 3), CFOP_CTE)= 0));
End;

function TfrmCadLivroFiscal.fValidarEntradaCFOPFornecedor(strCFOP: String): Boolean;
Begin
  Result := (Not fEmptyStr(strCodCfo))
    And (Not fEmptyStr(strCFOP))
    And (Pos(strCFOP,strCodCfo) = 0);
End;

procedure TfrmCadLivroFiscal.btnIncluirGiaClick(Sender: TObject);
begin
  inherited;
  qryCadOcr.Append;
  pSetFocus(mskDtaMes);
end;

procedure TfrmCadLivroFiscal.btnMemCalcGNREClick(Sender: TObject);
begin
  inherited;
  pExibeMemoriaCalculoGNRE(qryFisItensAUTOINCREM.AsString);
end;

procedure TfrmCadLivroFiscal.btnGravarGiaClick(Sender: TObject);
begin
  inherited;
  If fStrToFloat(edtValSubIte.Text) <= 0 Then
  Begin
    fMensagem('', 'Valor do item deve ser maior que zero!', ['&Ok']);
    Exit;
  End;

  IF qryCadOcr.FieldByName('AUTOINCREM').IsNull Then
    qryCadOcr.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADOCR',VS_StrCodEmp);
  qryCadOcr.FieldByName('OCR_CODEMP').AsString := qryTabela.FieldByName('FIS_CODEMP').AsString;
  qryCadOcr.FieldByName('OCR_SEQFIS').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
  qryCadOcr.FieldByName('OCR_PROPST').AsInteger := rgIndicaOperacaoPropriaOuSt.ItemIndex;
  qryCadOcr.Post;
end;

procedure TfrmCadLivroFiscal.btnAlterarGiaClick(Sender: TObject);
begin
  inherited;
  qryCadOcr.Edit;
  pSetFocus(mskDtaMes);
end;

procedure TfrmCadLivroFiscal.btnExcluirGiaClick(Sender: TObject);
begin
  inherited;
  qryCadOcr.Delete;
end;

procedure TfrmCadLivroFiscal.btnCancelarGiaClick(Sender: TObject);
begin
  inherited;
  qryCadOcr.Cancel;
end;

procedure TfrmCadLivroFiscal.dtsCadOcrStateChange(Sender: TObject);
begin
  inherited;
  btnIncluirGia.Enabled := dtsCadOcr.State In [dsBrowse];
  btnGravarGia.Enabled := dtsCadOcr.State In dsEditModes;
  btnAlterarGia.Enabled := (Not dtsCadOcr.DataSet.IsEmpty) And (dtsCadOcr.State In [dsBrowse]);
  btnCancelarGia.Enabled := dtsCadOcr.State In dsEditModes;
  btnExcluirGia.Enabled := (Not dtsCadOcr.DataSet.IsEmpty) And (dtsCadOcr.State In [dsBrowse]);
  rgIndicaOperacaoPropriaOuSt.Enabled := dtsCadOcr.State In dsEditModes;
end;

procedure TfrmCadLivroFiscal.pConsultarGIA;
Begin
  qryCadOcr.SQL.Clear;
  qryCadOcr.SQL.Text := 'SELECT * FROM CADOCR WHERE OCR_SEQFIS = ' + qryTabela
    .FieldByName('AUTOINCREM')
    .AsString
      .QuotedString;
  qryCadOcr.Open;
  rgIndicaOperacaoPropriaOuSt.ItemIndex := qryCadOcr.FieldByName('OCR_PROPST').AsInteger;
  pFormatarCamposGia;
End;

procedure TfrmCadLivroFiscal.BitBtnLocked1Click(Sender: TObject);
var
  chrKey: Char;
  arrConsulta: TConsultasArray;
begin
  chrKey := '/';
  If fPesqOcorrenciasGIA(Self, qryCadOcr, chrKey, arrConsulta, True, 'OCR_SEQFIS = ' + qryTabela.FieldByName('AUTOINCREM').AsString.QuotedString) Then
  Begin
    rgIndicaOperacaoPropriaOuSt.ItemIndex := qryCadOcr.FieldByName('OCR_PROPST').AsInteger;
    pFormatarCamposGia;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadLivroFiscal.pHabilitarTabGia;
Var
  strCodEmp: String;
begin
  strCodEmp := dbeCodEmp.Text;
  if fEmptyStr(strCodEmp) Then
    strCodEmp := VS_strCodEmp;

  tbsGia.TabVisible := fRetUFEmpresa(strCodEmp) = 'SP';
end;

procedure TfrmCadLivroFiscal.pFormatarCamposGia;
begin
  TFloatField(qryCadOcr.FieldByName('OCR_VALITE')).EditFormat := '#,##0.00';
  TFloatField(qryCadOcr.FieldByName('OCR_VALITE')).DisplayFormat := '#,##0.00';
end;

procedure TfrmCadLivroFiscal.pInserirRecTnf(strTabela, strAutoIncrem: String);
Var
  qryInsert: TUniQuery;
begin
  qryInsert := fCriaQuery(Self);
  try
    qryInsert.SQL.Text := 'INSERT INTO RECTNF (REC_CTESEQ, REC_MOVSEQ, REC_NOTSEQ) ' +
      ' VALUES (:REC_CTESEQ, :REC_MOVSEQ, :REC_NOTSEQ);';
    qryInsert.ParamByName('REC_CTESEQ').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
    If strTabela = 'MOVGER' Then
     begin
      qryInsert.ParamByName('REC_MOVSEQ').AsString := strAutoIncrem;
      qryInsert.ParamByName('REC_NOTSEQ').Clear;
    end
    else
    begin
      qryInsert.ParamByName('REC_NOTSEQ').AsString := strAutoIncrem;
      qryInsert.ParamByName('REC_MOVSEQ').Clear;
    end;
    qryInsert.ExecSQL;
  finally
    FreeAndNil(qryInsert);
  End;
End;

function TfrmCadLivroFiscal.fTemValorBase(APanel: TPanel): Boolean;
var i: integer;
begin
  Result := False;
  For i := 0 to APanel.ControlCount - 1 do
    If (APanel.Controls[i] is TDBEditFocus) and
       (TDBEditFocus(APanel.Controls[i]).Field.AsFloat > 0) then
      Exit(True);
end;

procedure TfrmCadLivroFiscal.pJustaCamposAllVisible;
begin
  SendMessage(Handle, WM_SETREDRAW, 0, 0);
  try
    pnlCtnICMSSubst.Height := HeightComValor;
    pnlvalorCMSSubst.Visible := True;
    pnlCtnICMSAntecipado.Height := HeightComValor;
    pnlValorCMSAntecipado.Visible := True;
    pnlCtnIcmsStNaoCreditado.Height := HeightComValor;
    pnlValorIcmsStNaoCreditado.Visible := True;
    pnlCtnIPI.Height := HeightComValor;
    pnlValorIPI.Visible := True;
    pnlCtnIpiNaoCreditado.Height := HeightComValor;
    pnlValorIpiNaoCreditado.Visible := True;
    pnlCtnFCP.Height := HeightComValor;
    pnlValorFCP.Visible := True;
    pnlCtnFCPST.Height := HeightComValor;
    pnlValorFCPST.Visible := True;
    pnlCtnQtdMono.Height := HeightComValor;
    pnlValorQtdMono.Visible := True;
  finally
    SendMessage(Handle, WM_SETREDRAW, 1, 0);
    RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_ALLCHILDREN);
  end;
end;

function TfrmCadLivroFiscal.fSomarBlocosAuxFis(const strCampo: String): Double;
  Var
    intBloco: Integer;
    fldBloco: TField;
begin
  Result := 0;

  If (Not Assigned(qryAuxFis)) Or (Not qryAuxFis.Active) Then
    Exit;

  For intBloco := 1 To 5 Do
  Begin
    fldBloco := qryAuxFis.FindField(strCampo + IntToStr(intBloco));

    If Assigned(fldBloco) Then
      Result := Result + fldBloco.AsFloat;
  End;
end;

procedure TfrmCadLivroFiscal.pSincronizarAuxFis;
  Const
    ARR_CAMPOS_AUXFIS: Array[0..5] Of String = ('FIS_BCCBS', 'FIS_VLCBS',
                                                'FIS_BCIBS', 'FIS_VLIBS',
                                                'FIS_BC_IS', 'FIS_VL_IS');
  Var
    intCampo: Integer;
    intBloco: Integer;
    strSeqFis: String;
begin
  If Not Assigned(qryAuxFis) Then
  Begin
    qryAuxFis := fCriarQuery('SELECT * FROM AUXFIS WHERE FIS_SEQFIS = :SEQFIS', Self);
    qryAuxFis.CachedUpdates := True;
    dtsAuxFis.DataSet := qryAuxFis;
  End;

  {* RECONSTRUCAO DO LIVRO FICA NO CACHE ATE O GRAVAR; FORA DE EDICAO, DESCARTA *}
  If qryAuxFis.Active And qryAuxFis.UpdatesPending Then
  Begin
    If FblnGravandoLivro Or (Assigned(qryTabela) And (qryTabela.State In [dsEdit, dsInsert])) Then
      Exit;

    qryAuxFis.CancelUpdates;
    qryAuxFis.Close;
  End;

  strSeqFis := '';
  If Assigned(qryTabela) And qryTabela.Active And (Not qryTabela.IsEmpty) Then
    strSeqFis := qryTabela.FieldByName('AUTOINCREM').AsString;

  If fEmptyStr(strSeqFis) And ((Not Assigned(qryTabela)) Or (qryTabela.State <> dsInsert)) Then
  Begin
    qryAuxFis.Close;
    Exit;
  End;

  {* JA ESTA NO REGISTRO CERTO: NAO REABRE A CADA DataChange *}
  If qryAuxFis.Active And (qryAuxFis.ParamByName('SEQFIS').AsString = strSeqFis) Then
    Exit;

  qryAuxFis.Close;
  qryAuxFis.ParamByName('SEQFIS').AsString := strSeqFis;
  qryAuxFis.Open;

  For intCampo := Low(ARR_CAMPOS_AUXFIS) To High(ARR_CAMPOS_AUXFIS) Do
    For intBloco := 1 To 5 Do
      TFloatField(qryAuxFis.FieldByName(ARR_CAMPOS_AUXFIS[intCampo] + IntToStr(intBloco))).DisplayFormat := '#,##0.00';
end;

function TfrmCadLivroFiscal.fSqlReformaLivro(const ATabelaDetalhe, ACampo: String): String;
  Var
    strTabelaReforma: String;
begin
  Result := '0';

  If Not fSomarNovosImpostosDaReformaAoValorContabil Then
    Exit;

  If (ATabelaDetalhe = 'MOVDET') Then
    strTabelaReforma := 'MOVREF'
  Else If (ATabelaDetalhe = 'NOTDET') Then
    strTabelaReforma := 'NOTREF'
  Else
    Exit;

  Result := '(SELECT IFNULL(SUM(R.' + ACampo + '), 0) FROM ' + strTabelaReforma + ' R ' +
            'WHERE R.REF_SEQGER = ' + ATabelaDetalhe + '.AUTOINCREM)';
end;

function TfrmCadLivroFiscal.fSqlReformaLivroTotal(const ATabelaDetalhe: String): String;
begin
  Result := fSqlReformaLivro(ATabelaDetalhe, 'REF_CBSVAL') + ' + ' +
            fSqlReformaLivro(ATabelaDetalhe, 'REF_VALIBS') + ' + ' +
            fSqlReformaLivro(ATabelaDetalhe, 'REF_SELVAL');
end;

function TfrmCadLivroFiscal.fValorReformaItemLivro: Double;
  Var
    qryRef: TUniQuery;
    strTabelaReforma: String;
begin
  Result := 0;

  If Not fSomarNovosImpostosDaReformaAoValorContabil Then
    Exit;

  If (strTabela = 'MOVDET') Then
    strTabelaReforma := 'MOVREF'
  Else If (strTabela = 'NOTDET') Then
    strTabelaReforma := 'NOTREF'
  Else
    Exit;

  qryRef := fCriaQuery(Self);
  Try
    qryRef.SQL.Add('SELECT IFNULL(SUM(REF_CBSVAL), 0) + IFNULL(SUM(REF_VALIBS), 0) + IFNULL(SUM(REF_SELVAL), 0) AS VALOR ');
    qryRef.SQL.Add('  FROM ' + strTabelaReforma + ' ');
    qryRef.SQL.Add(' WHERE REF_SEQGER = :SEQGER ');
    qryRef.ParamByName('SEQGER').AsString := qryFisItens.FieldByName('AUTOINCREM').AsString;
    qryRef.Open;

    Result := qryRef.FieldByName('VALOR').AsFloat;
  Finally
    FreeAndNil(qryRef);
  End;
end;

function TfrmCadLivroFiscal.fPrepararAuxFisReconstrucao: Boolean;
  Const
    ARR_CAMPOS_AUXFIS: Array[0..5] Of String = ('FIS_BCCBS', 'FIS_VLCBS',
                                                'FIS_BCIBS', 'FIS_VLIBS',
                                                'FIS_BC_IS', 'FIS_VL_IS');
  Var
    intCampo: Integer;
    intBloco: Integer;
begin
  Result := False;

  If Not fTabelaExiste('AUXFIS', True) Then
    Exit;

  pSincronizarAuxFis;

  If (Not Assigned(qryAuxFis)) Or (Not qryAuxFis.Active) Then
    Exit;

  If qryAuxFis.IsEmpty Then
    qryAuxFis.Append
  Else
    qryAuxFis.Edit;

  For intCampo := Low(ARR_CAMPOS_AUXFIS) To High(ARR_CAMPOS_AUXFIS) Do
    For intBloco := 1 To 5 Do
      qryAuxFis.FieldByName(ARR_CAMPOS_AUXFIS[intCampo] + IntToStr(intBloco)).AsFloat := 0;

  Result := True;
end;

procedure TfrmCadLivroFiscal.pPreencherAuxFisReconstrucao(const ABloco: Integer; const AQrySint: TUniQuery);
  Var
    strSufixo: String;
begin
  strSufixo := IntToStr(ABloco);

  qryAuxFis.FieldByName('FIS_BCCBS' + strSufixo).AsFloat := AQrySint.FieldByName('BASCBS').AsFloat;
  qryAuxFis.FieldByName('FIS_VLCBS' + strSufixo).AsFloat := AQrySint.FieldByName('VALCBS').AsFloat;
  qryAuxFis.FieldByName('FIS_BCIBS' + strSufixo).AsFloat := AQrySint.FieldByName('BASIBS').AsFloat;
  qryAuxFis.FieldByName('FIS_VLIBS' + strSufixo).AsFloat := AQrySint.FieldByName('VALIBS').AsFloat;
  qryAuxFis.FieldByName('FIS_BC_IS' + strSufixo).AsFloat := AQrySint.FieldByName('BAS_IS').AsFloat;
  qryAuxFis.FieldByName('FIS_VL_IS' + strSufixo).AsFloat := AQrySint.FieldByName('VAL_IS').AsFloat;
end;

procedure TfrmCadLivroFiscal.pGravarAuxFis;
begin
  If (Not Assigned(qryAuxFis)) Or (Not qryAuxFis.Active) Or (Not qryAuxFis.UpdatesPending) Then
    Exit;

  qryAuxFis.Edit;

  If fEmptyStr(qryAuxFis.FieldByName('AUTOINCREM').AsString) Then
    qryAuxFis.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('AUXFIS', qryTabela.FieldByName('FIS_CODEMP').AsString);

  qryAuxFis.FieldByName('FIS_SEQFIS').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;
  qryAuxFis.Post;

  qryAuxFis.ApplyUpdates;
end;

procedure TfrmCadLivroFiscal.pConfirmarAuxFis;
begin
  If Assigned(qryAuxFis) And qryAuxFis.Active Then
    qryAuxFis.CommitUpdates;
end;

procedure TfrmCadLivroFiscal.pDescartarAuxFis;
begin
  If Assigned(qryTabela) And (qryTabela.State In [dsEdit, dsInsert]) Then
    Exit;

  If Assigned(qryAuxFis) And qryAuxFis.Active And qryAuxFis.UpdatesPending Then
  Begin
    qryAuxFis.CancelUpdates;
    qryAuxFis.Close;
  End;
end;

procedure TfrmCadLivroFiscal.pJustaCamposImpostos;
begin
  SendMessage(Handle, WM_SETREDRAW, 0, 0);
  try
    pnlCtnICMSSubst.Height := HeightComValor;
    pnlvalorCMSSubst.Visible := True;
    If Not fTemValorBase(pnlBaseCMSSubst) then
    begin
      pnlCtnICMSSubst.Height := HeightSemValor;
      pnlvalorCMSSubst.Visible := False;
    end;

    pnlCtnICMSAntecipado.Height := HeightComValor;
    pnlValorCMSAntecipado.Visible := True;
    If Not fTemValorBase(pnlBaseCMSAntecipado) then
    begin
      pnlCtnICMSAntecipado.Height := HeightSemValor;
      pnlValorCMSAntecipado.Visible := False;
    end;

    pnlCtnIcmsStNaoCreditado.Height := HeightComValor;
    pnlValorIcmsStNaoCreditado.Visible := True;
    If Not fTemValorBase(pnlBaseIcmsStNaoCreditado) then
    begin
      pnlCtnIcmsStNaoCreditado.Height := HeightSemValor;
      pnlValorIcmsStNaoCreditado.Visible := False;
    end;

    pnlCtnIPI.Height := HeightComValor;
    pnlValorIPI.Visible := True;
    If Not fTemValorBase(pnlBaseIPI) then
    begin
      pnlCtnIPI.Height := HeightSemValor;
      pnlValorIPI.Visible := False;
    end;

    pnlCtnIpiNaoCreditado.Height := HeightComValor;
    pnlValorIpiNaoCreditado.Visible := True;
    If Not fTemValorBase(pnlBaseIpiNaoCreditado) then
    begin
      pnlCtnIpiNaoCreditado.Height := HeightSemValor;
      pnlValorIpiNaoCreditado.Visible := False;
    end;

    pnlCtnFCP.Height := HeightComValor;
    pnlValorFCP.Visible := True;
    If Not fTemValorBase(pnlBaseFCP) then
    begin
      pnlCtnFCP.Height := HeightSemValor;
      pnlValorFCP.Visible := False;
    end;

    pnlCtnFCPST.Height := HeightComValor;
    pnlValorFCPST.Visible := True;
    If Not fTemValorBase(pnlBaseFCPST) then
    begin
      pnlCtnFCPST.Height := HeightSemValor;
      pnlValorFCPST.Visible := False;
    end;

    pnlCtnQtdMono.Height := HeightComValor;
    pnlValorQtdMono.Visible := True;
    If Not fTemValorBase(pnlBaseQtdMono) then
    begin
      pnlCtnQtdMono.Height := HeightSemValor;
      pnlValorQtdMono.Visible := False;
    end;

    pnlContainerReforma.Visible := fSomarNovosImpostosDaReformaAoValorContabil;
  finally
    SendMessage(Handle, WM_SETREDRAW, 1, 0);
    RedrawWindow(Handle, nil, 0, RDW_ERASE or RDW_INVALIDATE or RDW_ALLCHILDREN);
  end;
end;

procedure TfrmCadLivroFiscal.pGravarRecTnf;
Var
  StatusOriginal: TUpdateStatusSet;
begin
  if (Not cdsDocsCTE.Active) Or (cdsDocsCTE.IsEmpty) Then
    Exit;

  if (not qryTabela.Active) Then
    Exit;

  if qryTabela.FieldByName('FIS_LCTCTE').AsString <> 'M' Then
    Exit;

  //Salva o status atual
  StatusOriginal := cdsDocsCTE.StatusFilter;
  cdsDocsCTE.StatusFilter := [usInserted];
  try
    cdsDocsCTE.First;
    while not cdsDocsCTE.Eof do
    Begin
      If Not fEmptyStr(cdsDocsCTE.FieldByName('AUTOINCREM').AsString) Then
        pInserirRecTnf(cdsDocsCTE.FieldByName('TABELA').AsString,
                       cdsDocsCTE.FieldByName('AUTOINCREM').AsString);
      cdsDocsCTE.Next;
    End;
  finally
    // Volta status para o que estava antes, não importa o que aconteça
    cdsDocsCTE.StatusFilter := StatusOriginal;
  end;
end;

procedure TfrmCadLivroFiscal.btnDocCTEIncluirClick(Sender: TObject);
Var
  strWhere: String;
  chrKey: Char;
  qryConsulta: TUniQuery;
  arrIncCte: TConsultasArray;
  stlDuplicados: TStringList;
begin
  inherited;
  If Not btnDocCTEIncluir.Enabled Then
    Exit;
  if not (qryTabela.State in [dsInsert, dsEdit]) then
    Exit;

  chrKey := '/' ;
  strWhere := 'FORCLI = ' ;
  qryConsulta := fCriaQuery(Self);
  stlDuplicados := TStringList.Create;
  Try
    If fPesqNFeCTe(Self, qryConsulta, chrKey, arrIncCte, False, strWhere) Then
    Begin
      cdsDocsCTE.DisableControls;
      try
        While (Not qryConsulta.Eof) Do
        Begin
          if cdsDocsCTE.Locate('AUTOINCREM;TABELA',
               VarArrayOf([qryConsulta.FieldByName('AUTOINCREM').AsString,
                           qryConsulta.FieldByName('TABELA').AsString]), []) Then
          Begin
            stlDuplicados.Add(Format('  - Número: %s | Espécie: %s | Série: %s',
                                     [qryConsulta.FieldByName('NUMDOC').AsString,
                                      qryConsulta.FieldByName('ESPDOC').AsString,
                                      qryConsulta.FieldByName('SERIE_').AsString]));
          End
          Else
          Begin
            cdsDocsCTE.Append;
            cdsDocsCTE.FieldByName('GER_DTADOC').AsString := qryConsulta.FieldByName('DTADOC').AsString;
            cdsDocsCTE.FieldByName('GER_NUMDOC').AsString := qryConsulta.FieldByName('NUMDOC').AsString;
            cdsDocsCTE.FieldByName('GER_ESPDOC').AsString := qryConsulta.FieldByName('ESPDOC').AsString;
            cdsDocsCTE.FieldByName('GER_SERIE_').AsString := qryConsulta.FieldByName('SERIE_').AsString;
            cdsDocsCTE.FieldByName('GER_ENTSAI').AsString := qryConsulta.FieldByName('ENTSAI').AsString;
            cdsDocsCTE.FieldByName('TABELA').AsString := qryConsulta.FieldByName('TABELA').AsString;
            cdsDocsCTE.FieldByName('AUTOINCREM').AsString := qryConsulta.FieldByName('AUTOINCREM').AsString;
            cdsDocsCTE.Post;
          End;
          qryConsulta.Next;
        End;
      finally
        cdsDocsCTE.EnableControls;
      end;
    End;

    if stlDuplicados.Count > 0 Then
      fMensagem('Atenção',
                'Os seguintes documentos já estavam associados e foram ignorados:' + sLineBreak +
                stlDuplicados.Text,
                ['OK']);
  Finally
    FreeAndNil(stlDuplicados);
    pFreeAndNil(qryConsulta);
  End;
end;

procedure TfrmCadLivroFiscal.btnDocCTEExcluirClick(Sender: TObject);
begin
  inherited;
  If Not btnDocCTEExcluir.Enabled Then
    Exit;
  if not (qryTabela.State in [dsInsert, dsEdit]) then
    Exit;

  If Not cdsDocsCTE.IsEmpty Then
    If fMensagem('Atenção', 'Deseja excluir essa associação da nota fiscal?', ['&Sim', '&Não']) = 1 Then
    Begin
      // só registra DELETE para quem veio do banco
      if (cdsDocsCTE.UpdateStatus = usUnmodified) and
         (not fEmptyStr(cdsDocsCTE.FieldByName('AUTOINCREM').AsString)) then
      begin
        stlRegistrosExcluidosRECTNF.Add(Format('%s=%s', [cdsDocsCTE.FieldByName('TABELA').AsString,
                                                         cdsDocsCTE.FieldByName('AUTOINCREM').AsString]));
      end;
      cdsDocsCTE.Delete;
    End;
end;

function TfrmCadLivroFiscal.fBuscaBaseFrete(ACodBfr: string): string;
begin
  Result := fCampoTabela('BFR_DESBFR', 'BASFRE',['BFR_CODBFR'],[ACodBfr]);
end;

procedure TfrmCadLivroFiscal.pBloqueiaEdicaoBaseFrete(AAutInc: String);
begin
  dbeBasFre.Enabled := fCampoTabela('COUNT(1)', 'CONFRE',['CON_SEQFIS'],[AAutInc]) > 0;
end;

procedure TfrmCadLivroFiscal.pSetaBaseFrete;
begin
  gbxBaseFrete.Visible := (qryTabela.FieldByName('FIS_ESPDOC').AsString = 'CT');
  If (gbxBaseFrete.Visible) Then
  begin
    edtDesBasFre.Text := fBuscaBaseFrete(qryTabela.FieldByName('FIS_CODBFR').AsString);
    pBloqueiaEdicaoBaseFrete(qryTabela.FieldByName('AUTOINCREM').AsString);
  end;

end;

procedure TfrmCadLivroFiscal.pFormatarNumDoc;
begin
  If (Not (qryTabela.State In [dsInsert, dsEdit])) Then
    Exit;
  If (Not fEmptyStr(dbeNumDoc.Text)) And (Length(dbeNumDoc.Text) < 12) Then
  Begin
    dbeNumDoc.Text := fPadL(dbeNumDoc.Field.AsString, 12, '0');
    dbeNumDoc.Field.AsString := dbeNumDoc.Text;
  End;
end;

function TfrmCadLivroFiscal.fEhNotaEnergiaEletroincaZerada: Boolean;
Begin
  Result := (Pos(dbeClfSc1.Text, strENERGIA_ELETRICA) > 0) And
    (fStrToFloat(dbeVlCon1.Text) = 0) And
    (dbeNfComple.Text = 'N');
End;

procedure TfrmCadLivroFiscal.pExibeMemoriaCalculoGNRE(ASeqDet: String);
Var
  LMemCal: String;
  LfrmMensagemExplicativa: TfrmMensagemExplicativa;
begin
  LMemCal := fCampoTabela('CAL_MEMCAL', 'CALGNR',['DET_SEQDET'],[ASeqDet]);

  If fEmptyStr(LMemCal) And (StrToFloat(edtValGNRE.Text) > 0) Then
    LMemCal := MSG_VLR_GNR_MANUAL;

  pCriarFormularios(TfrmMensagemExplicativa, LfrmMensagemExplicativa);
  Try
    LfrmMensagemExplicativa.Caption := 'Memória de Cálculo da GNRE';
    LfrmMensagemExplicativa.Width   := 660;
    LfrmMensagemExplicativa.Height  := 300;
    LfrmMensagemExplicativa.RitchObservacao.Visible:= True;
    LfrmMensagemExplicativa.RitchObservacao.BringToFront;
    LfrmMensagemExplicativa.RitchObservacao.Lines.Add(LMemCal);
    LfrmMensagemExplicativa.ShowModal;
  Finally
    pFreeAndNil(LfrmMensagemExplicativa);
  End;
end;

{ TRecChaveAcesso }

function TRecChaveAcesso.AlterouChaveAutorizada(
  const pstrChaveAcesso: String): Boolean;
begin
  Result := False;

  if Not FValidarAlteracao then
    Exit;

  Result := (Self.FValor <> pstrChaveAcesso) And Self.Autorizado;
end;

constructor TRecChaveAcesso.Create(pValidarAlteracao: Boolean;
                                   pstrNumDoc: String = '';
                                   pstrEspDoc: String = '';
                                   pstrSerie_: String = '';
                                   pstrCodCli: String = '';
                                   pstrTip_FC: String = '';
                                   pstrCodEmp: String = '';
                                   pstrChvAce: String = '');
begin
  FValidarAlteracao := pValidarAlteracao;
  FNumDoc := pstrNumDoc;
  FEspDoc := pstrEspDoc;
  FSerie_ := pstrSerie_;
  FCodEmp := pstrCodEmp;
  FCodCli := pstrCodcli;
  FTip_FC := pstrTip_FC;
  FValor := EmptyStr;
  FAutorizado := False;
  pSetValor(pstrChvAce);
end;

function TRecChaveAcesso.fChaveAutorizada(pstrChvAce: String): Boolean;
Var
  lQry: TUniQuery;
  lSql: String;
begin
  Result := False;
  if fEmptyStr(pstrChvAce) then
    Exit;

  lQry := fCriaQuery;
  Try
    lSql :=        ' SELECT 1 AS REG ';
    lSql := lSql + ' FROM LOGNFE ';
    lSql := lSql + ' WHERE     TRUE ';
    lSql := lSql + '       AND NFE_NUMDOC = :NUMDOC ';
    lSql := lSql + '       AND NFE_ESPDOC = :ESPDOC ';
    lSql := lSql + '       AND NFE_SERIE_ = :SERIE_ ';
    lSql := lSql + '       AND NFE_TIP_FC = :TIP_FC ';
    lSql := lSql + '       AND NFE_CODCLI = :CODCLI ';
    lSql := lSql + '       AND NFE_CODEMP = :CODEMP ';
    lSql := lSql + '       AND NFE_STATUS = "AT" ';
    lSql := lSql + '       AND NFE_ACESSO = :PCHAVE ';

    lQry.Close;
    lQry.Sql.Add(lSql);
    lQry.ParambyName('NUMDOC').AsString := FNumDoc;
    lQry.ParambyName('ESPDOC').AsString := FEspDoc;
    lQry.ParambyName('SERIE_').AsString := FSerie_;
    lQry.ParambyName('TIP_FC').AsString := FTip_FC;
    lQry.ParambyName('CODCLI').AsString := FCodCli;
    lQry.ParambyName('CODEMP').AsString := FCodEmp;
    lQry.ParambyName('PCHAVE').AsString := pstrChvAce;
    lQry.Open;
    Result := Not lQry.IsEmpty;
  Finally
    FreeAndNil(lQry);
  End;
end;

procedure TRecChaveAcesso.pSetValor(const pValor: String);
begin
  if pValor = FValor then
    Exit;
  FValor := pValor;
  FAutorizado := False;
  if FValidarAlteracao then
    FAutorizado := fChaveAutorizada(FValor);
end;

function TfrmCadLivroFiscal.fLockUnlock(ATravar: Boolean): Boolean;
Var
  LAutoIncrem: String;
Begin
  Result := False;
  If Not fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
  Begin
    LAutoIncrem := 'LIVRO FISCAL_' + qryTabela.FieldByName('AUTOINCREM').AsString;
    Result := fLock_Unlock(LAutoIncrem, ATravar, False);
    If Not Result Then
      pMensagemOk('O documento ' + dbeNumDoc.Text + '-' + dbeCodEmp.Text +
                  ' está sendo utilizada em outra estação por ' +
                  fGetHostLock(LAutoIncrem)  + '!');
  End;
End;

function TfrmCadLivroFiscal.fPermitePalavraNoHistorico(const APalavra : String): Boolean;
begin
  Result := True;
  If (Pos(APalavra, dbmHistor.Text) > 0)  And
       ((fStrToFloat(dbeVlCon1.Text) +
         fStrToFloat(dbeVlCon2.Text) +
         fStrToFloat(dbeVlCon3.Text) +
         fStrToFloat(dbeVlCon4.Text) +
         fStrToFloat(dbeVlCon5.Text) ) > 0) Then
  Begin
    fMensagem('ATENÇÃO!', 'Não é permitido a palavra "' + APalavra + '" no histórico de ' +
                          'um documento que possua valores!', ['&Ok']);
    Result := False;
  End;
end;

Function TfrmCadLivroFiscal.fVerificaDocumentoExisteCtp(strCodEmp: String; strNumDoc, strSerie, strCodFor: String; intTamCam: Integer): Boolean;
  Var
    strSQL   : String;
    qryGenPag: TUniQuery;
begin
  Try
    qryGenPag := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADPAG ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
    strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';

    If (fEmptyStr(strSerie)) Then
      strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) '
    Else
      strSQL := strSQL + '  CTP_SERIE_ = :SERIE ';

    With qryGenPag Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := fStrZero(strNumDoc, intTamCam);
      ParamByName('CODFOR').AsString := strCodFor;
      ParamByName('CODEMP').AsString := strCodEmp;
      If (Not fEmptyStr(strSerie)) Then
      Begin
        ParamByName('SERIE').AsString := strSerie;
      End;
      Open;
      Result := FieldByName('QTD').AsInteger > 0;
      Close;
    End;

  Finally
    FreeAndNil(qryGenPag);
  End;
end;

function TfrmCadLivroFiscal.fDocumentoComVinculoFiscal(const qryTabela : TUniQuery) : Boolean;
  const
    STR_ESPECIES_FISCAIS : String = '_NF_IF_NS_';
begin
  Result := False;
  If (STR_ESPECIES_FISCAIS.Contains(qryTabela.FieldByName('FIS_ESPDOC').AsString)) And
     (qryTabela.FieldByName('FIS_ORIDOC').AsString = 'V') And
     (Not fEmptyStr(qryTabela.FieldByName('FIS_PROTOC').AsString)) Then
  Begin
    Result := True;
  End;
end;

function TfrmCadLivroFiscal.fLiberaEdicaoBasePISCOFINSEnergiaComunicacao: Boolean;
begin
  Result := blnEditaBaseCalcPISCofins And
            (Pos(qryTabela.FieldByName('FIS_CLFSC1').AsString, CFOP_ENERGIA + CFOP_COMUNICACAO) > 0);
end;

procedure TfrmCadLivroFiscal.btnEventosDeEntregaClick(Sender: TObject);
Var
  x,y : Integer;
begin
  inherited;

  x := Self.Left + btnEventosDeEntrega.Left;
  y := Self.Top + Self.Height - (pnlBotoes.Height + pnlInfo.Height);

  popEventosEntrega.Popup(x,y);
end;

function TfrmCadLivroFiscal.fPermiteInsucessoNaEntrega(AChaveAcesso:String): Boolean;
var
  LXML: String;
begin
  LXML   := fRetornaXMLNFeBD(AChaveAcesso);
  Result := fNFePermiteInsucessoNaEntrega(LXML);
end;

procedure TfrmCadLivroFiscal.pDFeEventoDeEntrega(ATipoEvento: TTipoEventoEntrega);
begin
  pCriarFormularios(TfrmDFeEventosDeEntrega, frmDFeEventosDeEntrega);
  Try
    frmDFeEventosDeEntrega.TipoEvento := ATipoEvento;
    frmDFeEventosDeEntrega.strAcesso  := qryTabela.FieldByName('FIS_ACESSO').AsString;
    frmDFeEventosDeEntrega.strNumDoc  := qryTabela.FieldByName('FIS_NUMDOC').AsString;
    frmDFeEventosDeEntrega.strEspDoc  := qryTabela.FieldByName('FIS_ESPDOC').AsString;
    frmDFeEventosDeEntrega.strCodEmp  := qryTabela.FieldByName('FIS_CODEMP').AsString;
    frmDFeEventosDeEntrega.strSerie_  := qryTabela.FieldByName('FIS_SERIE_').AsString;

    If ATipoEvento in [NFeCancelamentoConfirmacaoEntrega, NFeCancelamentoInsucessoEntrega,
                       CTeCancelamentoConfirmacaoEntrega, CTeCancelamentoInsucessoEntrega] Then
    Begin
      frmDFeEventosDeEntrega.btnConfirma.Click;
    End
    Else
      frmDFeEventosDeEntrega.ShowModal;

  Finally
    FreeAndNil(frmDFeEventosDeEntrega);
  End;
end;

procedure TfrmCadLivroFiscal.pAtivaEventoDeEntrega;
begin
  btnEventosDeEntrega.Visible := False;

  If not Assigned(qryTabela) Then
    Exit;

  If fEmptyStr(qryTabela.FieldByName('FIS_ACESSO').AsString) Then
    Exit;

  If (Pos('CANCELADO',qryTabela.FieldByName('FIS_HISTOR').AsString) > 0) Then
    Exit;

  If not fVerificaAcessoSistema('DFE_EVENTOS_DE_ENTREGA') Then
    Exit;

  If not (qryTabela.FieldByName('FIS_CODEMP').AsString = VS_StrCodEmp) Then
    Exit;

  btnEventosDeEntrega.Visible := pos(qryTabela.FieldByName('FIS_ESPDOC').AsString, 'NF_CT_') > 0;
end;

procedure TfrmCadLivroFiscal.popConfirmaoEntregaClick(Sender: TObject);
begin
  inherited;
  If qryTabela.FieldByName('FIS_ESPDOC').AsString = 'CT' Then
    pDFeEventoDeEntrega(CTeConfirmacaoEntrega)
  Else
    pDFeEventoDeEntrega(NFeConfirmacaoEntrega);
end;

procedure TfrmCadLivroFiscal.popCancelamentoConfirmacaoEntregaClick(Sender: TObject);
begin
  inherited;
  If fMensagem('', 'Confirma o cancelamento da entrega', ['&Sim','&Não']) = 2 Then
    Exit;

  If qryTabela.FieldByName('FIS_ESPDOC').AsString = 'CT' Then
    pDFeEventoDeEntrega(CTeCancelamentoConfirmacaoEntrega)
  Else
    pDFeEventoDeEntrega(NFeCancelamentoConfirmacaoEntrega);
end;

procedure TfrmCadLivroFiscal.popInsucessoEntregaClick(Sender: TObject);
begin
  inherited;
  If qryTabela.FieldByName('FIS_ESPDOC').AsString = 'NF' Then
  Begin
    If fPermiteInsucessoNaEntrega(qryTabela.FieldByName('FIS_ACESSO').AsString) Then
      pDFeEventoDeEntrega(NFeInsucessoEntrega)
    Else
      fMensagem('ATENÇÃO!', 'A Nota Fiscal informada não tem entrega!', ['&Ok']);
  End
  Else
    pDFeEventoDeEntrega(CTeInsucessoEntrega);
end;

procedure TfrmCadLivroFiscal.popCancelamentoInsucessoEntregaClick(Sender: TObject);
begin
  inherited;
  If fMensagem('', 'Confirma o cancelamento do insucesso na entrega', ['&Sim','&Não']) = 2 Then
    Exit;

  If qryTabela.FieldByName('FIS_ESPDOC').AsString = 'NF' Then
  Begin
    If fPermiteInsucessoNaEntrega(qryTabela.FieldByName('FIS_ACESSO').AsString) Then
      pDFeEventoDeEntrega(NFeCancelamentoInsucessoEntrega)
    Else
      fMensagem('ATENÇÃO!', 'A Nota Fiscal informada não tem entrega!', ['&Ok']);
  End
  Else
    pDFeEventoDeEntrega(CTeCancelamentoInsucessoEntrega);
end;

end.


