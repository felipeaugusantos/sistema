unit untConfigMultiplike;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Mask, DirectoryEditFocus, StdCtrls, EditFocus, Buttons,
  ExtCtrls, QColorLabel, Menus, ComCtrls, ShellApi, Uni, AppEvnts, ComboBoxFocus,
  BitBtnLockedIncrem, untTypesSistema, frxClass, frxExportCSVTestabilidade,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, StrUtils, cxTextEdit, cxMaskEdit, cxButtonEdit,
  dxScreenTip, cxClasses, dxCustomHint, cxHint, dxBarBuiltInMenu, cxGroupBox,
  cxPC, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  Data.DB, cxDBData, cxGridLevel, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox, Datasnap.DBClient,
  System.Generics.Collections, UniClientDataSet,
  cxDataControllerConditionalFormattingRulesManagerDialog, 
  untFrameDirectoryEditFocus, untFramePlanoDeContasMaskEdit, MaskEditFocus;

type
  TfrmConfigMultiplike = class(TfrmPai)
    pnlFundo: TPanel;
    pnlTopo: TPanel;
    tabCarteira: TTabControl;
    HintControler: TcxHintStyleController;
    btnCancelar: TBitBtnLocked;
    btnGravar: TBitBtnLocked;
    btnEditar: TBitBtnLocked;
    btnConfigurar: TBitBtnLocked;
    BtnManual: TBitBtnLocked;
    BtnOcorrencia: TBitBtnLocked;
    cxPaginas: TcxPageControl;
    tbsGeral: TcxTabSheet;
    tbsEncBan: TcxTabSheet;
    pnlAtivo1: TPanel;
    Label5: TLabel;
    lblCodAgenc: TLabel;
    lblCodCart: TLabel;
    lblContCorr: TLabel;
    lblDiasProt: TLabel;
    lblIdentBanco: TLabel;
    lblPathArquivosRem: TLabel;
    lblPathArquivosRet: TLabel;
    lblProNum: TLabel;
    lblResp: TLabel;
    ColorLabel1: TColorLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    ColorLabel3: TColorLabel;
    Label14: TLabel;
    ColorLabel4: TColorLabel;
    Label15: TLabel;
    Label17: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    Label16: TLabel;
    Label6: TLabel;
    lblCartSeq: TLabel;
    edtResp: TEditFocus;
    edtDiasProt: TEditFocus;
    edtContaCorr: TEditFocus;
    edtCodAgencia: TEditFocus;
    edtIdentBanc: TEditFocus;
    edtCodCar: TEditFocus;
    edtProxNumArqRem: TEditFocus;
    edtDesPor: TEditFocus;
    edtCodPor: TEditFocus;
    edtObservacao1: TEditFocus;
    edtObservacao2: TEditFocus;
    edtObservacao3: TEditFocus;
    edtObservacao4: TEditFocus;
    edtObservacao5: TEditFocus;
    edtExpCgc: TEditFocus;
    edtDiasCred: TEditFocus;
    edtProAce: TEditFocus;
    edtPerMul: TEditFocus;
    cmbTipDia: TComboBoxFocus;
    edtInfAdi: TEditFocus;
    edtCodFsh: TEditFocus;
    fraPathRemessaMultiplike: TfraDirectoryEditFocus;
    fraPathRetornoMultiplike: TfraDirectoryEditFocus;
    cmbNumCart: TComboBoxFocus;
    cmbInstrucao1: TComboBoxFocus;
    cmbInstrucao2: TComboBoxFocus;
    edtDiasMora: TEditFocus;
    chkCartSeq: TCheckBox;
    edtCartSeq: TEditFocus;
    edtDigCtaCor: TEditFocus;
    pnlAtivo2: TPanel;
    grpTarAux: TcxGroupBox;
    edtMandMsg: TEditFocus;
    ColorLabel6: TColorLabel;
    Label19: TLabel;
    grpTarLiq: TcxGroupBox;
    Label7: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    edtDesPorTar: TEditFocus;
    edtPorTar: TEditFocus;
    edtValorTarifa: TEditFocus;
    edtDesForTar: TEditFocus;
    edtForTar: TEditFocus;
    grdTarifasDBTableView1: TcxGridDBTableView;
    grdTarifasLevel1: TcxGridLevel;
    grdTarifas: TcxGrid;
    grdTarifasDBTableView1CNF_CODOCO: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_DESOCO: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_GERPAG: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_FORNEC: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_PLNCON: TcxGridDBColumn;
    grdTarifasDBTableView1CNF_PORTAD: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    btnAddOco: TBitBtnLocked;
    btnRemOco: TBitBtnLocked;
    cxStyle2: TcxStyle;
    btnEdtOco: TBitBtnLocked;
    Label22: TLabel;
    cdsCnfOco: TUniClientDataSet;
    cdsCnfOcoCNF_CODOCO: TStringField;
    cdsCnfOcoCNF_DESOCO: TStringField;
    cdsCnfOcoCNF_GERPAG: TBooleanField;
    cdsCnfOcoCNF_FORNEC: TStringField;
    cdsCnfOcoCNF_PORTAD: TStringField;
    cdsCnfOcoCNF_PLNCON: TStringField;
    dsCnfOco: TDataSource;
    cdsCnfOcoCNF_CUSCAR: TBooleanField;
    grdTarifasDBTableView1CNF_CUSCAR: TcxGridDBColumn;
    Label23: TLabel;
    edtCodLiq: TEditFocus;
    ColorLabel2: TColorLabel;
    cdsCnfOcoCNF_TIPDES: TIntegerField;
    cdsCnfOcoCNF_DSTPDS: TStringField;
    grdTarifasDBTableView1CNF_DSTPDS: TcxGridDBColumn;
    fraPlanoDeContas: TfraPlanoDeContasMskEdit;
    fraPlanoDeContasEnc: TfraPlanoDeContasMskEdit;
    tbsComplemento: TcxTabSheet;
    pnlComplemento: TPanel;
    Label45: TLabel;
    edtCodPorRem: TEditFocus;
    edtDescPorRem: TEditFocus;
    grpBeneficiario: TGroupBox;
    lblDesCrr: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    edtDesBen: TEditFocus;
    edtEndBen: TEditFocus;
    edtCompBen: TEditFocus;
    edtBaiBen: TEditFocus;
    edtCidBen: TEditFocus;
    edtEstBen: TEditFocus;
    edtCepBen: TMaskEditFocus;
    edtCgcBen: TMaskEditFocus;
    Label35: TLabel;
    ColorLabel7: TColorLabel;
    edtUsaSac: TEditFocus;
    procedure pCarregaDados;
    procedure FormShow(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure edtCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure pCarregaPortador(strCodPor: String; edtLabel: TEdit);
    procedure pCarregaCentroCusto(strCtaBai: String; edtLabel: TEdit);
    procedure tabCarteiraChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfigurarClick(Sender: TObject);
    procedure BtnManualClick(Sender: TObject);
    procedure edtDiasCredEnter(Sender: TObject);
    procedure edtDiasCredExit(Sender: TObject);
    procedure btnConfigurarEnter(Sender: TObject);
    procedure btnConfigurarExit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtCodFshEnter(Sender: TObject);
    procedure edtCodFshExit(Sender: TObject);
    procedure cmbNumCartChange(Sender: TObject);
    procedure BtnOcorrenciaEnter(Sender: TObject);
    procedure BtnOcorrenciaExit(Sender: TObject);
    procedure BtnOcorrenciaClick(Sender: TObject);
    procedure chkCartSeqClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure tabCarteiraChanging(Sender: TObject; var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCancelarClick(Sender: TObject);
    procedure edtPorTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtForTarKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorTarifaExit(Sender: TObject);
    procedure edtMandMsgEnter(Sender: TObject);
    procedure edtMandMsgExit(Sender: TObject);
    procedure btnAddOcoClick(Sender: TObject);
    procedure btnEdtOcoClick(Sender: TObject);
    procedure btnRemOcoClick(Sender: TObject);
    procedure grdTarifasDBTableView1DblClick(Sender: TObject);
    procedure edtCodLiqEnter(Sender: TObject);
    procedure edtCodLiqExit(Sender: TObject);
    procedure ApplicationEventsDeactivate(Sender: TObject);
    procedure fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasEncMskCodCtaKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtCodPorRemKeyPress(Sender: TObject; var Key: Char);
    procedure edtUsaSacExit(Sender: TObject);

  private
    { Private declarations }
    qryCadPor : TUniQuery;
    qryCadCta : TUniQuery;
    qryCadFor : TUniQuery;

    blnVirtualUI: Boolean;

    procedure pShowHint(edtEdit: TEditFocus; strTitulo: String);
    procedure pShowHintBotao(btnBotao: TBitBtnLocked; strTitulo: String);
    procedure pHideHint;
    procedure pLimpaCampos;
    procedure pGravaLogCarteira(stlCfgAnt : TStringList);
    procedure pCarregaCfg(Var stlCampos: TStringList);
    procedure pCarregaOcorrencias;
    function RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;

  public
    { Public declarations }
    blnNaoEditar: Boolean;
    strConfig   : String;
    strOcoTar   : String;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; Override;
  end;

var
  frmConfigMultiplike: TfrmConfigMultiplike;

implementation

uses  untPesqAux, untCfgGenericas_AutBan, untConsultas, untFuncoesSimples,
  untMemo, untFuncoes, untCadOcoCartei, untCNFOCO_Class, untCNFOCO_Dao,
  VirtualUI_SDK;

{$R *.dfm}

procedure TfrmConfigMultiplike.pCarregaDados;
begin
  {*****************}
  {* CARREGA DADOS *}
  {**************AF*}
  //Limpando Valores Carregados;
  pLimpaCampos;

  If fEmptyStr(fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '')) Then
  Begin
    edtProxNumArqRem.Enabled  := True;
    edtProxNumArqRem.Clear;
    pSetFocus(edtProxNumArqRem);
  End
  Else
  Begin
    edtProxNumArqRem.Text  := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', '');
    edtProxNumArqRem.Enabled := False;
    pSetFocus(cmbNumCart);
  End;

  if (strLoginUsuarioLogado='997') or(strLoginUsuarioLogado='998') or (strLoginUsuarioLogado='999') Then
  begin
    edtProxNumArqRem.Enabled := True;
    pSetFocus(edtProxNumArqRem);
  End;

  If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', '')) Of
      102: cmbNumCart.ItemIndex := 0;
      101: cmbNumCart.ItemIndex := 1;
      104: cmbNumCart.ItemIndex := 2;
      107: cmbNumCart.ItemIndex := 3;
      108: cmbNumCart.ItemIndex := 4;
      109: cmbNumCart.ItemIndex := 5;
      112: cmbNumCart.ItemIndex := 6;
      115: cmbNumCart.ItemIndex := 7;
      121: cmbNumCart.ItemIndex := 8;
      129: cmbNumCart.ItemIndex := 9;
      139: cmbNumCart.ItemIndex := 10;
      142: cmbNumCart.ItemIndex := 11;
      143: cmbNumCart.ItemIndex := 12;
      147: cmbNumCart.ItemIndex := 13;
      150: cmbNumCart.ItemIndex := 14;
      169: cmbNumCart.ItemIndex := 15;
      172: cmbNumCart.ItemIndex := 16;
      173: cmbNumCart.ItemIndex := 17;
      174: cmbNumCart.ItemIndex := 18;
      175: cmbNumCart.ItemIndex := 19;
      177: cmbNumCart.ItemIndex := 20;
      180: cmbNumCart.ItemIndex := 21;
      188: cmbNumCart.ItemIndex := 22;
      198: cmbNumCart.ItemIndex := 23;
      352: cmbNumCart.ItemIndex := 24;
      354: cmbNumCart.ItemIndex := 25;
      358: cmbNumCart.ItemIndex := 26;
      359: cmbNumCart.ItemIndex := 27;
      364: cmbNumCart.ItemIndex := 28;
      365: cmbNumCart.ItemIndex := 29;
      458: cmbNumCart.ItemIndex := 30;
      459: cmbNumCart.ItemIndex := 31;
    End;
  End
  Else
    cmbNumCart.ItemIndex := -1;

  edtDesPor.Text := '';
  edtDescPorRem.Text := '';
  fraPlanoDeContas.edtDesCta.Text := '';

  edtCodCar.Text         := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', '');
  edtIdentBanc.Text      := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', '');
  edtCodAgencia.Text     := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', '');
  edtContaCorr.Text      := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', '');
  edtDigCtaCor.Text      := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', '');
  edtCodPor.Text         := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', '');
  edtCodPorRem.Text      := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', '');
  fraPlanoDeContas.MskCodCta.Text         := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', '');
  edtDiasProt.Text       := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', '');
  edtDiasMora.Text       := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', '');
  edtResp.Text           := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', '');
  edtMandMsg.Text        := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVDUPAG', 'N');

  If fEmptyStr(edtMandMsg.Text) then
    edtMandMsg.Text := 'S';

  If fEmptyStr(edtDiasMora.Text) then
    edtDiasMora.Text := '1';

  cmbInstrucao1.ItemIndex := 0;

  {If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', '')) Of
      00: cmbInstrucao1.ItemIndex := 0;  // AUSÊNCIA DE INSTRUÇÕES
      02: cmbInstrucao1.ItemIndex := 1;  // DEVOLVER APÓS 05 DIAS DO VENCIMENTO
      03: cmbInstrucao1.ItemIndex := 2;  // DEVOLVER APÓS 30 DIAS DO VENCIMENTO
      05: cmbInstrucao1.ItemIndex := 3;  // RECEBER CONFORME INSTRUÇÕES NO PRÓPRIO TÍTULO
      06: cmbInstrucao1.ItemIndex := 4;  // DEVOLVER APÓS 10 DIAS DO VENCIMENTO
      07: cmbInstrucao1.ItemIndex := 5;  // DEVOLVER APÓS 15 DIAS DO VENCIMENTO
      08: cmbInstrucao1.ItemIndex := 6;  // DEVOLVER APÓS 20 DIAS DO VENCIMENTO
      09: cmbInstrucao1.ItemIndex := 7;  // PROTESTAR (emite aviso ao sacado após XX dias do vencimento, e envia ao cartório após 5 dias úteis)
      10: cmbInstrucao1.ItemIndex := 8;  // NÃO PROTESTAR (inibe protesto, quando houver instrução permanente na conta corrente)
      11: cmbInstrucao1.ItemIndex := 9;  // DEVOLVER APÓS 25 DIAS DO VENCIMENTO
      12: cmbInstrucao1.ItemIndex := 10; // DEVOLVER APÓS 35 DIAS DO VENCIMENTO
      13: cmbInstrucao1.ItemIndex := 11; // DEVOLVER APÓS 40 DIAS DO VENCIMENTO
      14: cmbInstrucao1.ItemIndex := 12; // DEVOLVER APÓS 45 DIAS DO VENCIMENTO
      15: cmbInstrucao1.ItemIndex := 13; // DEVOLVER APÓS 50 DIAS DO VENCIMENTO
      16: cmbInstrucao1.ItemIndex := 14; // DEVOLVER APÓS 55 DIAS DO VENCIMENTO
      17: cmbInstrucao1.ItemIndex := 15; // DEVOLVER APÓS 60 DIAS DO VENCIMENTO
      18: cmbInstrucao1.ItemIndex := 16; // DEVOLVER APÓS 90 DIAS DO VENCIMENTO
      19: cmbInstrucao1.ItemIndex := 17; // NÃO RECEBER APÓS 05 DIAS DO VENCIMENTO
      20: cmbInstrucao1.ItemIndex := 18; // NÃO RECEBER APÓS 10 DIAS DO VENCIMENTO
      21: cmbInstrucao1.ItemIndex := 19; // NÃO RECEBER APÓS 15 DIAS DO VENCIMENTO
      22: cmbInstrucao1.ItemIndex := 20; // NÃO RECEBER APÓS 20 DIAS DO VENCIMENTO
      23: cmbInstrucao1.ItemIndex := 21; // NÃO RECEBER APÓS 25 DIAS DO VENCIMENTO
      24: cmbInstrucao1.ItemIndex := 22; // NÃO RECEBER APÓS 30 DIAS DO VENCIMENTO
      25: cmbInstrucao1.ItemIndex := 23; // NÃO RECEBER APÓS 35 DIAS DO VENCIMENTO
      26: cmbInstrucao1.ItemIndex := 24; // NÃO RECEBER APÓS 40 DIAS DO VENCIMENTO
      27: cmbInstrucao1.ItemIndex := 25; // NÃO RECEBER APÓS 45 DIAS DO VENCIMENTO
      28: cmbInstrucao1.ItemIndex := 26; // NÃO RECEBER APÓS 50 DIAS DO VENCIMENTO
      29: cmbInstrucao1.ItemIndex := 27; // NÃO RECEBER APÓS 55 DIAS DO VENCIMENTO E
      30: cmbInstrucao1.ItemIndex := 28; // IMPORTÂNCIA DE DESCONTO POR DIA
      31: cmbInstrucao1.ItemIndex := 29; // NÃO RECEBER APÓS 60 DIAS DO VENCIMENTO
      32: cmbInstrucao1.ItemIndex := 30; // NÃO RECEBER APÓS 90 DIAS DO VENCIMENTO
      33: cmbInstrucao1.ItemIndex := 31; // CONCEDER ABATIMENTO REF. À PIS-PASEP/COFIN/CSSL, MESMO APÓS VENCIMENTO
      34: cmbInstrucao1.ItemIndex := 32; // PROTESTAR APÓS XX DIAS CORRIDOS DO VENCIMENTO
      35: cmbInstrucao1.ItemIndex := 33; // PROTESTAR APÓS XX DIAS ÚTEIS DO VENCIMENTO
      37: cmbInstrucao1.ItemIndex := 34; // RECEBER ATÉ O ÚLTIMO DIA DO MÊS DE VENCIMENTO
      38: cmbInstrucao1.ItemIndex := 35; // CONCEDER DESCONTO MESMO APÓS VENCIMENTO
      39: cmbInstrucao1.ItemIndex := 36; // NÃO RECEBER APÓS O VENCIMENTO
      40: cmbInstrucao1.ItemIndex := 37; // CONCEDER DESCONTO CONFORME NOTA DE CRÉDITO A
      42: cmbInstrucao1.ItemIndex := 38; // PROTESTO PARA FINS FALIMENTARES
      43: cmbInstrucao1.ItemIndex := 39; // SUJEITO A PROTESTO SE NÃO FOR PAGO NO VENCIMENTO F
      44: cmbInstrucao1.ItemIndex := 40; // IMPORTÂNCIA POR DIA DE ATRASO A PARTIR DE DDMMAA
      45: cmbInstrucao1.ItemIndex := 41; // TEM DIA DA GRAÇA
      47: cmbInstrucao1.ItemIndex := 42; // DISPENSAR JUROS/COMISSÃO DE PERMANÊNCIA
      51: cmbInstrucao1.ItemIndex := 43; // RECEBER SOMENTE COM A PARCELA ANTERIOR QUITADA
      52: cmbInstrucao1.ItemIndex := 44; // EFETUAR O PAGAMENTO SOMENTE ATRAVÉS DESTE BOLETO E NA REDE BANCÁRIA
      54: cmbInstrucao1.ItemIndex := 45; // APÓS VENCIMENTO PAGÁVEL SOMENTE NA EMPRESA
      57: cmbInstrucao1.ItemIndex := 46; // SOMAR VALOR DO TÍTULO AO VALOR DO CAMPO MORA/MULTA CASO EXISTA
      58: cmbInstrucao1.ItemIndex := 47; // DEVOLVER APÓS 365 DIAS DE VENCIDO
      59: cmbInstrucao1.ItemIndex := 48; // COBRANÇA NEGOCIADA. PAGÁVEL SOMENTE POR ESTE BOLETO NA REDE BANCÁRIA
      61: cmbInstrucao1.ItemIndex := 49; // TÍTULO ENTREGUE EM PENHOR EM FAVOR DO CEDENTE ACIMA
      62: cmbInstrucao1.ItemIndex := 50; // TÍTULO TRANSFERIDO A FAVOR DO CEDENTE
      66: cmbInstrucao1.ItemIndex := 51; // ENTRADA EM NEGATIVAÇÃO EXPRESSA (IMPRIME: SUJEITO A NEGATIVAÇÃO APÓS O VENCIMENTO)
      67: cmbInstrucao1.ItemIndex := 52; // NÃO NEGATIVAR (INIBE A ENTRADA EM NEGATIVAÇÃO EXPRESSA)
      78: cmbInstrucao1.ItemIndex := 53; // VALOR DA IDA ENGLOBA MULTA DE 10% PRO RATA
      79: cmbInstrucao1.ItemIndex := 54; // COBRAR JUROS APÓS 15 DIAS DA EMISSÃO (para títulos com vencimento à vista)
      80: cmbInstrucao1.ItemIndex := 55; // PAGAMENTO EM CHEQUE: SOMENTE RECEBER COM CHEQUE DE EMISSÃO DO SACADO
      81: cmbInstrucao1.ItemIndex := 56; // PROTESTAR APÓS XX DIAS CORRIDOS DO VENCIMENTO
      82: cmbInstrucao1.ItemIndex := 57; // PROTESTAR APÓS XX DIAS ÚTEIS DO VENCIMENTO
      83: cmbInstrucao1.ItemIndex := 58; // OPERAÇÃO REF A VENDOR
      84: cmbInstrucao1.ItemIndex := 59; // APÓS VENCIMENTO CONSULTAR A AGÊNCIA CEDENTE
      86: cmbInstrucao1.ItemIndex := 60; // ANTES DO VENCIMENTO OU APÓS 15 DIAS, PAGÁVEL SOMENTE EM NOSSA SEDE
      88: cmbInstrucao1.ItemIndex := 61; // NÃO RECEBER ANTES DO VENCIMENTO
      90: cmbInstrucao1.ItemIndex := 62; // NO VENCIMENTO PAGÁVEL EM QUALQUER AGÊNCIA BANCÁRIA
      91: cmbInstrucao1.ItemIndex := 63; // NÃO RECEBER APÓS XX DIAS DO VENCIMENTO A
      92: cmbInstrucao1.ItemIndex := 64; // DEVOLVER APÓS XX DIAS DO VENCIMENTO
      93: cmbInstrucao1.ItemIndex := 65; // MENSAGENS NOS BOLETOS COM 30 POSIÇÕES
      94: cmbInstrucao1.ItemIndex := 66; // MENSAGENS NOS BOLETOS COM 40 POSIÇÕES
      98: cmbInstrucao1.ItemIndex := 67; // DUPLICATA / FATURA Nº
    End;
  End
  Else
    cmbInstrucao1.ItemIndex := -1; }

  {If Not fEmptyStr(fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '')) Then
  Begin
    Case StrToInt(fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', '')) Of
      00: cmbInstrucao2.ItemIndex := 0;  // AUSÊNCIA DE INSTRUÇÕES
      02: cmbInstrucao2.ItemIndex := 1;  // DEVOLVER APÓS 05 DIAS DO VENCIMENTO
      03: cmbInstrucao2.ItemIndex := 2;  // DEVOLVER APÓS 30 DIAS DO VENCIMENTO
      05: cmbInstrucao2.ItemIndex := 3;  // RECEBER CONFORME INSTRUÇÕES NO PRÓPRIO TÍTULO
      06: cmbInstrucao2.ItemIndex := 4;  // DEVOLVER APÓS 10 DIAS DO VENCIMENTO
      07: cmbInstrucao2.ItemIndex := 5;  // DEVOLVER APÓS 15 DIAS DO VENCIMENTO
      08: cmbInstrucao2.ItemIndex := 6;  // DEVOLVER APÓS 20 DIAS DO VENCIMENTO
      09: cmbInstrucao2.ItemIndex := 7;  // PROTESTAR (emite aviso ao sacado após XX dias do vencimento, e envia ao cartório após 5 dias úteis)
      10: cmbInstrucao2.ItemIndex := 8;  // NÃO PROTESTAR (inibe protesto, quando houver instrução permanente na conta corrente)
      11: cmbInstrucao2.ItemIndex := 9;  // DEVOLVER APÓS 25 DIAS DO VENCIMENTO
      12: cmbInstrucao2.ItemIndex := 10; // DEVOLVER APÓS 35 DIAS DO VENCIMENTO
      13: cmbInstrucao2.ItemIndex := 11; // DEVOLVER APÓS 40 DIAS DO VENCIMENTO
      14: cmbInstrucao2.ItemIndex := 12; // DEVOLVER APÓS 45 DIAS DO VENCIMENTO
      15: cmbInstrucao2.ItemIndex := 13; // DEVOLVER APÓS 50 DIAS DO VENCIMENTO
      16: cmbInstrucao2.ItemIndex := 14; // DEVOLVER APÓS 55 DIAS DO VENCIMENTO
      17: cmbInstrucao2.ItemIndex := 15; // DEVOLVER APÓS 60 DIAS DO VENCIMENTO
      18: cmbInstrucao2.ItemIndex := 16; // DEVOLVER APÓS 90 DIAS DO VENCIMENTO
      19: cmbInstrucao2.ItemIndex := 17; // NÃO RECEBER APÓS 05 DIAS DO VENCIMENTO
      20: cmbInstrucao2.ItemIndex := 18; // NÃO RECEBER APÓS 10 DIAS DO VENCIMENTO
      21: cmbInstrucao2.ItemIndex := 19; // NÃO RECEBER APÓS 15 DIAS DO VENCIMENTO
      22: cmbInstrucao2.ItemIndex := 20; // NÃO RECEBER APÓS 20 DIAS DO VENCIMENTO
      23: cmbInstrucao2.ItemIndex := 21; // NÃO RECEBER APÓS 25 DIAS DO VENCIMENTO
      24: cmbInstrucao2.ItemIndex := 22; // NÃO RECEBER APÓS 30 DIAS DO VENCIMENTO
      25: cmbInstrucao2.ItemIndex := 23; // NÃO RECEBER APÓS 35 DIAS DO VENCIMENTO
      26: cmbInstrucao2.ItemIndex := 24; // NÃO RECEBER APÓS 40 DIAS DO VENCIMENTO
      27: cmbInstrucao2.ItemIndex := 25; // NÃO RECEBER APÓS 45 DIAS DO VENCIMENTO
      28: cmbInstrucao2.ItemIndex := 26; // NÃO RECEBER APÓS 50 DIAS DO VENCIMENTO
      29: cmbInstrucao2.ItemIndex := 27; // NÃO RECEBER APÓS 55 DIAS DO VENCIMENTO E
      30: cmbInstrucao2.ItemIndex := 28; // IMPORTÂNCIA DE DESCONTO POR DIA
      31: cmbInstrucao2.ItemIndex := 29; // NÃO RECEBER APÓS 60 DIAS DO VENCIMENTO
      32: cmbInstrucao2.ItemIndex := 30; // NÃO RECEBER APÓS 90 DIAS DO VENCIMENTO
      33: cmbInstrucao2.ItemIndex := 31; // CONCEDER ABATIMENTO REF. À PIS-PASEP/COFIN/CSSL, MESMO APÓS VENCIMENTO
      34: cmbInstrucao2.ItemIndex := 32; // PROTESTAR APÓS XX DIAS CORRIDOS DO VENCIMENTO
      35: cmbInstrucao2.ItemIndex := 33; // PROTESTAR APÓS XX DIAS ÚTEIS DO VENCIMENTO
      37: cmbInstrucao2.ItemIndex := 34; // RECEBER ATÉ O ÚLTIMO DIA DO MÊS DE VENCIMENTO
      38: cmbInstrucao2.ItemIndex := 35; // CONCEDER DESCONTO MESMO APÓS VENCIMENTO
      39: cmbInstrucao2.ItemIndex := 36; // NÃO RECEBER APÓS O VENCIMENTO
      40: cmbInstrucao2.ItemIndex := 37; // CONCEDER DESCONTO CONFORME NOTA DE CRÉDITO A
      42: cmbInstrucao2.ItemIndex := 38; // PROTESTO PARA FINS FALIMENTARES
      43: cmbInstrucao2.ItemIndex := 39; // SUJEITO A PROTESTO SE NÃO FOR PAGO NO VENCIMENTO F
      44: cmbInstrucao2.ItemIndex := 40; // IMPORTÂNCIA POR DIA DE ATRASO A PARTIR DE DDMMAA
      45: cmbInstrucao2.ItemIndex := 41; // TEM DIA DA GRAÇA
      47: cmbInstrucao2.ItemIndex := 42; // DISPENSAR JUROS/COMISSÃO DE PERMANÊNCIA
      51: cmbInstrucao2.ItemIndex := 43; // RECEBER SOMENTE COM A PARCELA ANTERIOR QUITADA
      52: cmbInstrucao2.ItemIndex := 44; // EFETUAR O PAGAMENTO SOMENTE ATRAVÉS DESTE BOLETO E NA REDE BANCÁRIA
      54: cmbInstrucao2.ItemIndex := 45; // APÓS VENCIMENTO PAGÁVEL SOMENTE NA EMPRESA
      57: cmbInstrucao2.ItemIndex := 46; // SOMAR VALOR DO TÍTULO AO VALOR DO CAMPO MORA/MULTA CASO EXISTA
      58: cmbInstrucao2.ItemIndex := 47; // DEVOLVER APÓS 365 DIAS DE VENCIDO
      59: cmbInstrucao2.ItemIndex := 48; // COBRANÇA NEGOCIADA. PAGÁVEL SOMENTE POR ESTE BOLETO NA REDE BANCÁRIA
      61: cmbInstrucao2.ItemIndex := 49; // TÍTULO ENTREGUE EM PENHOR EM FAVOR DO CEDENTE ACIMA
      62: cmbInstrucao2.ItemIndex := 50; // TÍTULO TRANSFERIDO A FAVOR DO CEDENTE
      66: cmbInstrucao2.ItemIndex := 51; // ENTRADA EM NEGATIVAÇÃO EXPRESSA (IMPRIME: SUJEITO A NEGATIVAÇÃO APÓS O VENCIMENTO)
      67: cmbInstrucao2.ItemIndex := 52; // NÃO NEGATIVAR (INIBE A ENTRADA EM NEGATIVAÇÃO EXPRESSA)
      78: cmbInstrucao2.ItemIndex := 53; // VALOR DA IDA ENGLOBA MULTA DE 10% PRO RATA
      79: cmbInstrucao2.ItemIndex := 54; // COBRAR JUROS APÓS 15 DIAS DA EMISSÃO (para títulos com vencimento à vista)
      80: cmbInstrucao2.ItemIndex := 55; // PAGAMENTO EM CHEQUE: SOMENTE RECEBER COM CHEQUE DE EMISSÃO DO SACADO
      81: cmbInstrucao2.ItemIndex := 56; // PROTESTAR APÓS XX DIAS CORRIDOS DO VENCIMENTO
      82: cmbInstrucao2.ItemIndex := 57; // PROTESTAR APÓS XX DIAS ÚTEIS DO VENCIMENTO
      83: cmbInstrucao2.ItemIndex := 58; // OPERAÇÃO REF A VENDOR
      84: cmbInstrucao2.ItemIndex := 59; // APÓS VENCIMENTO CONSULTAR A AGÊNCIA CEDENTE
      86: cmbInstrucao2.ItemIndex := 60; // ANTES DO VENCIMENTO OU APÓS 15 DIAS, PAGÁVEL SOMENTE EM NOSSA SEDE
      88: cmbInstrucao2.ItemIndex := 61; // NÃO RECEBER ANTES DO VENCIMENTO
      90: cmbInstrucao2.ItemIndex := 62; // NO VENCIMENTO PAGÁVEL EM QUALQUER AGÊNCIA BANCÁRIA
      91: cmbInstrucao2.ItemIndex := 63; // NÃO RECEBER APÓS XX DIAS DO VENCIMENTO A
      92: cmbInstrucao2.ItemIndex := 64; // DEVOLVER APÓS XX DIAS DO VENCIMENTO
      93: cmbInstrucao2.ItemIndex := 65; // MENSAGENS NOS BOLETOS COM 30 POSIÇÕES
      94: cmbInstrucao2.ItemIndex := 66; // MENSAGENS NOS BOLETOS COM 40 POSIÇÕES
      98: cmbInstrucao2.ItemIndex := 67; // DUPLICATA / FATURA Nº
    End;
  End
  Else
    cmbInstrucao2.ItemIndex := -1;}

  cmbInstrucao2.ItemIndex := 0;

  edtDesPor.Text := '';
  edtDescPorRem.Text := '';
  fraPlanoDeContas.edtDesCta.Text := '';

  edtObservacao1.Text    := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', '');
  edtObservacao2.Text    := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', '');
  edtObservacao3.Text    := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', '');
  edtObservacao4.Text    := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', '');
  edtObservacao5.Text    := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', '');

  fraPathRemessaMultiplike.edtDirectory.text:= fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', '');
  fraPathRetornoMultiplike.edtDirectory.text:= fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', '');
  edtExpCgc.Text         := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPCNPJ', '');
  edtDiasCred.Text       := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', '');
  edtProAce.Text         := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', '');

  edtPerMul.Text         := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', '');
  edtInfAdi.Text         := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', '');

  edtCodFsh.Text         := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CDFLASH', '');
  chkCartSeq.Checked     := (fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', '') = 'S');
  edtCartSeq.Text        := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', '');
  edtPorTar.Text         := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', '');
  fraPlanoDeContasEnc.MskCodCta.Text := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', '');
  edtForTar.Text         := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', '');
  edtValorTarifa.Text    := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', '');
  edtCodLiq.Text         := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CODLIQU', 'N');

  //Dados Beneficiário
  edtUsaSac.Text        := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', '');
  edtUsaSac.Text        := IIF(fEmptyStr(edtUsaSac.Text), 'N', edtUsaSac.Text);
  edtDesBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''), '');
  edtEndBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''), '');
  edtBaiBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''), '');
  edtCompBen.Text       := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''), '');
  edtCidBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''), '');
  edtEstBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''), '');
  edtCepBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''), '');
  edtCgcBen.Text        := IIF(edtUsaSac.Text = 'S', fGetBancoConfig(0, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''), '');

  fValidaCampos(edtUsaSac);

  chkCartSeq.OnClick(chkCartSeq);

  If Not fEmptyStr(fGetBancoConfig(0,'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1),'TIPDIA', '1')) Then
    cmbTipDia.ItemIndex    := StrToInt(fGetBancoConfig(0,'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1),'TIPDIA', '1'))-1
  Else
    cmbTipDia.ItemIndex    := -1;

  If Not fEmptyStr( edtCodPor.Text ) Then
    pCarregaPortador(edtCodPor.Text, edtDesPor);

  If Not fEmptyStr( edtCodPorRem.Text ) Then
    pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);

  If Not fEmptyStr( fraPlanoDeContas.MskCodCta.Text ) Then
    pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);

  If Not fEmptyStr( edtPorTar.Text ) Then pCarregaPortador(edtPorTar.Text, edtDesPorTar);
  If Not fEmptyStr( fraPlanoDeContasEnc.MskCodCta.Text ) Then pCarregaCentroCusto(fraPlanoDeContasEnc.MskCodCta.Text, fraPlanoDeContasEnc.edtDesCta);

  If Not fEmptyStr( edtForTar.Text ) Then
  begin
    pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);
    edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
  end;

  pCarregaOcorrencias;

end;

procedure TfrmConfigMultiplike.pCarregaOcorrencias;
var
  lstCnfOco: TObjectList<TCnfOco>;
  objCnfOco: TCnfOco;
  objCnfDao: TCnfOcoDao;
  strCodBco: String;
  strTipLay: String;
  strNumPos: String;
  strEspeci: String;
  strCodEmp: String;
  intCartei: Integer;
begin
  cdsCnfOco.DisableControls;
  cdsCnfOco.EmptyDataSet;
  cdsCnfOco.Close;
  cdsCnfOco.Open;

  pDesmembraCarteira('CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp, strCodBco,
                     strTipLay, strNumPos, strEspeci, strCodEmp, intCartei);

  objCnfDao := TCnfOcoDao.Create(strCodBco, strTipLay, strNumPos,
                                 strEspeci, strCodEmp, intCartei);

  lstCnfOco := objCnfDao.fBuscaTodas;

  If lstCnfOco.Count > 0 Then
  Begin
    For objCnfOco in lstCnfOco Do
    Begin
      With cdsCnfOco Do
      Begin
        Append;
        cdsCnfOcoCNF_CODOCO.AsString := objCnfOco.strCodOco;
        cdsCnfOcoCNF_DESOCO.AsString := objCnfOco.strDesOco;
        cdsCnfOcoCNF_GERPAG.Value    := objCnfOco.blnGerpag;
        cdsCnfOcoCNF_CUSCAR.Value    := objCnfOco.blnCusCar;
        cdsCnfOcoCNF_FORNEC.AsString := objCnfOco.strCodFor + ' - ' + fRetNomFornecedor(objCnfOco.strCodFor);
        cdsCnfOcoCNF_PORTAD.AsString := objCnfOco.strCodPor + ' - ' + fRetNomPortador(objCnfOco.strCodPor);
        cdsCnfOcoCNF_PLNCON.AsString := objCnfOco.strCodCta + ' - ' + fRetDescCentroCusto(objCnfOco.strCodCta);
        cdsCnfOcoCNF_TIPDES.AsInteger:= objCnfOco.IntTipDes;
        Case objCnfOco.IntTipDes of
          0: cdsCnfOcoCNF_DSTPDS.AsString := '';
          1: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA IOF DESCONTO';
          2: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA BOLETO DESC';
          3: cdsCnfOcoCNF_DSTPDS.AsString := 'TARIFA DESCONTADA';
        End;
        Post;
      End;
    End;
  End;

  lstCnfOco.Free;
  objCnfDao.Free;

  cdsCnfOco.First;
  cdsCnfOco.EnableControls;
end;

procedure TfrmConfigMultiplike.FormShow(Sender: TObject);
begin
  inherited;

  qryCadCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  pCarregaDados;

  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(edtCodAgencia);

  pnlAtivo1.Enabled := False;
  pnlComplemento.Enabled := pnlAtivo1.Enabled;
  pnlAtivo2.Enabled := False;

  pSetFocus(btnEditar);

  if blnNaoEditar then
  begin
    btnConfigurar.Enabled := False;
    btnConfigurar.Visible := False;
    btnGravar.Enabled     := True;
    btnEditar.Visible     := False;
    pSetFocus(btnGravar);
  end;

  blnVirtualUI := VirtualUI.Active;

  fraPathRetornoMultiplike.Visible := Not blnVirtualUI;
  lblPathArquivosRet.Visible := Not blnVirtualUI;
  If blnVirtualUI Then
    lblPathArquivosRem.Caption := 'Path temporário para Remessa:';

end;

procedure TfrmConfigMultiplike.btnConfigurarEnter(Sender: TObject);
begin
  inherited;
  btnConfigurar.Hint := 'Configurar percentual de ' + #13+#10 +
                        'juros para remessa.';
  pShowHintBotao(btnConfigurar, 'Cofigurações específicas.');
end;

procedure TfrmConfigMultiplike.btnConfigurarExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigMultiplike.btnEditarClick(Sender: TObject);
begin
  If ((Not fVerificaDireitoAutBan('PERCARBAN')) and (strLoginUsuarioLogado <> '999')) Then
  begin
    fMensagem('ATENÇÃO','Usuário sem permissão!', ['&Ok ']);
    Exit;
  end
  else
  begin
    pnlAtivo1.Enabled := True;
    pnlComplemento.Enabled := pnlAtivo1.Enabled;

    if tbsEncBan.tabVisible then
      pnlAtivo2.Enabled := True;

    btnGravar.Enabled := True;
    btnConfigurar.Enabled := True;
    btnEditar.Visible := False;
    btnCancelar.Visible := true;

    if edtProxNumArqRem.Enabled then
      pSetFocus(edtProxNumArqRem)
    else
      pSetFocus(edtCodAgencia);

  end;
end;

procedure TfrmConfigMultiplike.btnEdtOcoClick(Sender: TObject);
Var
  intRecNo_: Integer;
begin
  inherited;
  intRecNo_ := 0;
  If Not cdsCnfOco.isEmpty Then
  Begin
    intRecNo_ := cdsCnfOco.RecNo;
    frmCadOcoCartei                     := TfrmCadOcoCartei.Create(nil);
    frmCadOcoCartei.strCartei           := 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
    frmCadOcoCartei.blnEditar           := True;
    frmCadOcoCartei.edtCodOco.Text      := cdsCnfOcoCNF_CODOCO.AsString;
    frmCadOcoCartei.fraPlanoDeContasOco.MskCodCta.Text := Copy(cdsCnfOcoCNF_PLNCON.AsString,1,7);
    frmCadOcoCartei.cmbTipDes.ItemIndex := cdsCnfOcoCNF_TIPDES.AsInteger;
    If cdsCnfOcoCNF_CODOCO.AsString = '02' Then frmCadOcoCartei.cmbTipDes.Visible := True;
    If cdsCnfOcoCNF_CODOCO.AsString = '02' Then frmCadOcoCartei.lblTipDes.Visible := True;

    Try
      frmCadOcoCartei.ShowModal;
    Finally
      FreeAndNil(frmCadOcoCartei);
    End;
  End
  Else
    pMensagemOk('É necessário possuir um registro selecionado para editar!');

  pCarregaOcorrencias;

  If intRecNo_ > 0 Then
  Begin
    cdsCnfOco.DisableControls;
    cdsCnfOco.RecNo := intRecNo_;
    cdsCnfOco.EnableControls;

  End;
end;

procedure TfrmConfigMultiplike.btnGravarClick(Sender: TObject);
Var
  stlCfgAnt : TStringList;

begin
  inherited;

  If fVerificaCampos Then
  Begin
    If blnNaoEditar Then
    Begin
      Close;
      ModalResult := mrOk;
      Exit;
    End;

    If (chkCartSeq.Checked) Then
    Begin
      If edtProxNumArqRem.Text <> fRetProxNumAutBan('CONFIG981-' + edtCartSeq.Text) Then
      Begin
        If fMensagem('ATENÇÃO','Ao utilizar a sequência do arquivo de remessa de outra carteira, o campo Último Núm. de Seq. Arq. Remessa será sobrescrito pelo da carteira principal. Deseja continuar?',['&SIM', '&NÃO'], 1) = 2 Then
          Exit;
      End;
    End;

    Try
      stlCfgAnt := TStringList.Create;
      pCarregaCfg(stlCfgAnt);

      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', IIF(chkCartSeq.Checked, fRetProxNumAutBan('CONFIG981-' + edtCartSeq.Text), edtProxNumArqRem.Text));
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', LeftStr(cmbNumCart.Text, 3));
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', edtCodCar.Text       );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', edtIdentBanc.Text    );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', edtCodAgencia.Text   );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', edtContaCorr.Text    );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', edtDigCtaCor.Text    );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', edtCodPor.Text       );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', edtCodPorRem.Text       );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', fraPlanoDeContas.MskCodCta.Text       );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', edtDiasProt.Text     );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', edtDiasMora.Text     );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', edtResp.Text         );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', LeftStr(cmbInstrucao1.Text,2));
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', LeftStr(cmbInstrucao2.Text,2));

      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', edtObservacao1.Text);
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', edtObservacao2.Text);
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', edtObservacao3.Text);
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', edtObservacao4.Text);
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', edtObservacao5.Text);


      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', fraPathRemessaMultiplike.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', fraPathRetornoMultiplike.edtDirectory.text);
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'EXPCNPJ', edtExpCgc.Text         );

      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', edtDiasCred.Text     );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', edtProAce.Text       );

      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', edtPerMul.Text       );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', edtInfAdi.Text       );

      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CDFLASH', edtCodFsh.Text       );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'ENVDUPAG', edtMandMsg.Text      );

      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA' , IntToStr(cmbTipDia.ItemIndex+1));
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', IIF(chkCartSeq.Checked, 'S', 'N'));
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', IIF(chkCartSeq.Checked, edtCartSeq.Text, ''));
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', edtPorTar.Text    );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', fraPlanoDeContasEnc.MskCodCta.Text);
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', edtForTar.Text    );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', edtValorTarifa.Text  );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CODLIQU', edtCodLiq.Text  );

      // dados beneficiario
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', edtUsaSac.Text        );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', edtDesBen.Text        );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', edtEndBen.Text        );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', edtBaiBen.Text        );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', edtCompBen.Text       );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', edtCidBen.Text        );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', edtEstBen.Text        );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', edtCepBen.Text        );
      fGetBancoConfig(1, 'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', edtCgCBen.Text        );

      If Not (btnGravar.Caption = '&OK') Then
      Begin
        pBackupCnfBco;
        fMensagem('', 'Dados salvos com sucesso.', ['&O K'], 1, True);
        edtProxNumArqRem.Enabled := False;
        pSetFocus(cmbNumCart);
        btnEditar.Visible := True;
        pnlAtivo1.Enabled := False;
        pnlComplemento.Enabled := pnlAtivo1.Enabled;

        If tbsEncBan.tabVisible Then
          pnlAtivo2.Enabled := False;

        btnGravar.Enabled := False;
        btnConfigurar.Enabled := False;
        btnEditar.Visible := True;
        btnCancelar.Visible := False;
        pSetFocus(btnEditar);
      End
      Else
      Begin
        Close;
        ModalResult := mrOk;
      End;

      pGravaLogCarteira(stlCfgAnt);

      pCarregaDados;
    Except
      On E:Exception Do
      Begin
        fMensagem('Erro','Ocorreu um erro ao tentar salvar os dados.' + #13 + E.Message,['&O K']);
      End;
    End;

    FreeAndNil(stlCfgAnt);
  End;
end;

procedure TfrmConfigMultiplike.fraPlanoDeContasEncMskCodCtaKeyPress(
  Sender: TObject; var Key: Char);
  Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************KP*}
  If fPesqCentroCusto(Self, fraPlanoDeContasEnc.MskCodCta, fraPlanoDeContasEnc.edtDesCta, Nil, Key, arrCentroCusto) Then
  begin
    if fValidaCampos(fraPlanoDeContasEnc.MskCodCta)  then
      SelectNext(ActiveControl, True, True);
  end;
end;

procedure TfrmConfigMultiplike.fraPlanoDeContasMskCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If fPesqCentroCusto(Self, fraPlanoDeContas.MskCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
    if fValidaCampos(fraPlanoDeContas.MskCodCta) then
      SelectNext(ActiveControl, True, True);
end;

function TfrmConfigMultiplike.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean;
var
  strMensagemConfig: String;
Begin

  Result := True;

   if blnNaoEditar then
     strMensagemConfig := #13 + 'Por favor acesse a tela de configuração do banco selecionado ' + #13  + ' e corrija as informações necessárias!'
  else
     strMensagemConfig := '';

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = edtProxNumArqRem Then
    Begin
      If fEmptyStr(edtProxNumArqRem.Text) Then
      Begin
        fMensagem('', 'O Último Núm. Arq. Remessa deve conter um valor!'+strMensagemConfig,['&O K']);
        Result := False;
      End

      Else If StrToInt(edtProxNumArqRem.Text) < 0 Then
      Begin
        fMensagem('', 'O Último Núm. Arq. Remessa deve ser maior ou igual a zero!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If (Sender = cmbInstrucao1) Then
    Begin

      If cmbInstrucao1.ItemIndex = -1 Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
      edtCodFsh.Enabled := (cmbInstrucao1.ItemIndex in [65,66]);
    End

    Else If (Sender = cmbInstrucao2) Then
    Begin

      If cmbInstrucao2.ItemIndex = -1 Then
      Begin
        fMensagem('','Os Campos de instruções devem ser preenchidos!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
      edtCodFsh.Enabled := (cmbInstrucao2.ItemIndex in [65,66]);

    End

    Else If Sender = edtResp Then
    Begin

      If (edtResp.Text <> 'E') And (edtResp.Text <> 'B') Then
      Begin
        fMensagem('','O campo Resp. por emissão de boletos deve ser E ou B!'+strMensagemConfig,['&O K']);
        Result := False;
      End;

    End

    Else If Sender = edtMandMsg Then
    Begin
      if fEmptyStr(edtMandMsg.Text) Then
        edtMandMsg.Text := 'S';

      If Pos(edtMandMsg.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('ATENÇÃO','Enviar Mensagem (Agrupamento) deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (tbsEncBan.TabVisible = True) and (Sender = edtPorTar) Then
    Begin
      If fEmptyStr(TEditFocus(Sender).Text) Then
      begin
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        Begin
          fMensagem('', 'O portador para baixa da tarifa deve ser preenchido!'+strMensagemConfig, ['&Ok']);

          If (Sender = edtPorTar) Then edtDesPorTar.Clear;

          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        End;
      end
      else
      begin
        pCarregaPortador(edtPorTar.Text, edtDesPorTar);

        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtPorTar.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin

          If (Pos(edtPorTar.Text, strPortadoresOperador) <= 0) Then
          Begin
            If Not fEmptyStr(edtDesPorTar.Text) Then
            Begin
              fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
              Result := False;
            End
          End;

        End;
      end;
    End

    Else If (tbsEncBan.TabVisible = True) and  (Sender = fraPlanoDeContasEnc.MskCodCta)  Then
    Begin
      If fEmptyStr(fraPlanoDeContasEnc.MskCodCta.Text) Then
      begin
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+strMensagemConfig, ['&Ok']);
          fraPlanoDeContasEnc.edtDesCta.Clear;
          Result := False;
        End
      end
      Else
      Begin
        pCarregaCentroCusto(fraPlanoDeContasEnc.MskCodCta.Text, fraPlanoDeContasEnc.edtDesCta);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End
        else
        begin
          Result := PlanoDeContasAtivo(fraPlanoDeContasEnc.MskCodCta.Text,True);
          fraPlanoDeContasEnc.edtDesCta.Text := qryCadCta.FieldByName('CTA_DESCTA').AsString;
        end;

      end;

    End

    Else If (tbsEncBan.TabVisible = True) and  (Sender = edtForTar)  Then
    Begin
      If fEmptyStr(edtForTar.Text) Then
      begin
        if (not fEmptyStr(edtValorTarifa.Text)) and (fStrToFloat(edtValorTarifa.Text)>0) then
        Begin
          fMensagem('ATENÇÃO','O Código do fornecedor para baixa da tarifa bancária deve ser preenchido!'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      end
      else
      begin
        pPesquisaCadFor(qryCadFor, qryCadFor, edtForTar.Text);

        If qryCadFor.FieldByName('FOR_CODFOR').IsNull Then
        Begin
          fMensagem('', 'Esse fornecedor não está cadastrado!'+strMensagemConfig, ['&Ok']);
          cxPaginas.ActivePage := tbsEncBan;
          Result := False;
        End
        else
          edtDesForTar.Text  := qryCadFor.FieldByName('FOR_NOMFOR').AsString;
      end;
    End

    Else If Sender = edtProAce Then
    Begin
      If Pos(edtProAce.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Imprime Protocolo de Aceite deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If Sender = edtCodLiq Then
    Begin
      If Pos(edtCodLiq.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Considerar código de liquidação deve ser preenchido com (S/N)!'+strMensagemConfig,['&O K']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodPorRem) Then
    Begin
        If (edtCodPorRem.Text <> EmptyStr) Then
        Begin
          pCarregaPortador(edtCodPorRem.Text, edtDescPorRem);
          If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
            Result := False;
          End
          {*REQ*145940**********RP*}
          Else If Not fEmpresaTemAcessoPortador(edtCodPorRem.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(edtCodPorRem.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
              Result := False;
            End;
          End
          Else If (Not fPortadorPermiteBaixa(edtCodPorRem.Text)) Then
          Begin
            fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
            Result := False;
          End;
        End
        Else
          edtDescPorRem.Clear;
    End


    Else If (Sender = edtCodPor) Then
    Begin

      If fEmptyStr(edtCodPor.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O portador deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        edtDesPor.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaPortador(edtCodPor.Text, edtDesPor);
        If qryCadPor.FieldByName('POR_CODPOR').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse portador não está cadastrado!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End
        {*REQ*145940**********RP*}
        Else If Not fEmpresaTemAcessoPortador(edtCodPor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores no Autcom - Aba "Empresas Acesso".', ['&Ok']);
          Result := False;
        End
        Else If fCfgSis('DACPOR', varBoolean) Then
        Begin
          If Pos(edtCodPor.Text, strPortadoresOperador) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!','Usuário sem permissão de acesso a este portador!'+strMensagemConfig, ['&Ok']);
            Result := False;
          End;
        End
        Else If (Not fPortadorPermiteBaixa(edtCodPor.Text)) Then
        Begin
          fMensagem('ATENÇÃO', 'Esse portador não tem permissão para realizar baixa!',['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = fraPlanoDeContas.MskCodCta) Then
    Begin

      If fEmptyStr(fraPlanoDeContas.MskCodCta.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser informado!'+strMensagemConfig, ['&Ok']);
        fraPlanoDeContas.edtDesCta.Clear;
        Result := False;
      End
      Else
      Begin
        pCarregaCentroCusto(fraPlanoDeContas.MskCodCta.Text, fraPlanoDeContas.edtDesCta);
        If qryCadCta.FieldByName('CTA_CODCTA').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End
        Else
          Result := PlanoDeContasAtivo(fraPlanoDeContas.MskCodCta.Text,True);
      End;
    End

    Else If (Sender = edtExpCgc) Then
    Begin

      If fEmptyStr(edtExpCgc.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo Exp. Cnpj do cedente deve ser preenchido!'+strMensagemConfig, ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If Pos(edtExpCgc.Text, 'S_N_') = 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O campo Exp. Cnpj do cedente deve conter apenas (S/N)!'+strMensagemConfig, ['&Ok']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtPerMul) Then
    Begin
      If Not fValidaEscala(edtPerMul.Text, 0, 99.99) Then
      begin
        fMensagem('ATENÇÃO','O campo percentual de multa deve estar entre 0 e 99,99!'+strMensagemConfig,['&OK']);
        Result := False;
      end;
    End

    Else If (Sender = cmbNumCart) Then
    Begin
      If cmbNumCart.ItemIndex = -1 Then
      Begin
        fMensagem('ATENÇÃO','O campo Número da Carteira deve ser informado!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      Else
      Begin
        If cmbNumCart.ItemIndex = 13 Then
          edtCodCar.Text := 'E'
        Else If cmbNumCart.ItemIndex = 14 Then
          edtCodCar.Text := 'U'
        Else If cmbNumCart.ItemIndex >= 24 Then
          edtCodCar.Text := 'D'
        Else
          edtCodCar.Text := 'I';
      End;
    End

    Else If (Sender = edtCodFsh) Then
    Begin
      If (Not fEmptyStr(edtCodFsh.Text)) Then
      Begin
        If (cmbInstrucao1.ItemIndex <> 65) And
           (cmbInstrucao2.ItemIndex <> 65) And
           (cmbInstrucao1.ItemIndex <> 66) And
           (cmbInstrucao2.ItemIndex <> 66) Then
        Begin
          fMensagem('ATENÇÃO','O Código Flash só deve ser preenchido quando utilizado o código 93 ou código 94 para instrução 1 ou para instrução 2!'+strMensagemConfig,['&OK']);
          Result := False;
        End
        Else If (Length(edtCodFsh.Text) <> edtCodFsh.MaxLength) Then
        Begin
          fMensagem('ATENÇÃO','O campo Código Flash, quando informado, deve ter 3 caracteres!'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCodAgencia) Then
    Begin
      If fEmptyStr(edtCodAgencia.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Código da Agência deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End

    Else If (Sender = edtContaCorr) Then
    Begin
      If fEmptyStr(edtContaCorr.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Conta Corrente deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End
      else
      begin
        if Length(edtContaCorr.Text) <> 5 then
        begin
          fMensagem('ATENÇÃO','O campo Conta Corrente deve ter 5 (cinco) caracteres. Caso tenha 0 (zero) favor informar!' + strMensagemConfig,['&OK']);
          Result := False;
        end;
      end;
    End

    Else If (Sender = edtDigCtaCor) Then
    Begin
      If fEmptyStr(edtDigCtaCor.Text) Then
      Begin
        fMensagem('ATENÇÃO','O campo Dígito da Conta Corrente deve ser preenchido!'+strMensagemConfig,['&OK']);
        Result := False;
      End;

    End

    {Else If (Sender = edtDiasProt) Then
    Begin
      If ((cmbInstrucao1.ItemIndex in [7, 32, 33, 38, 51, 56, 57, 63, 64])  Or
          (cmbInstrucao2.ItemIndex in [7, 32, 33, 38, 51, 56, 57, 63, 64])) Then
      Begin
        If (fEmptyStr(edtDiasProt.Text)) Then
        Begin
          fMensagem('ATENÇÃO','O campo Quantidade de dias para Protesto/Devolução/Negativação deve ser preenchido!'+strMensagemConfig,['&OK']);
          Result := False;
        End
        Else If StrToInt(edtDiasProt.Text) <= 0 Then
        Begin
          fMensagem('ATENÇÃO','O campo Quantidade de dias para Protesto/Devolução/Negativação deve ser maior que zero!'+strMensagemConfig,['&OK']);
          Result := False;
        End;
      End;
    End
    {Else If (Sender = cmbTipDia) Then
    Begin
      If ((cmbInstrucao1.ItemIndex in [32, 56])  Or
          (cmbInstrucao2.ItemIndex in [32, 56])) And
         (cmbTipDia.ItemIndex = 0) Then
      Begin
        fMensagem('ATENÇÃO','O tipo de dias para protesto deve ser "Corridos" conforme a instrução!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
      If ((cmbInstrucao1.ItemIndex in [33, 57])  Or
          (cmbInstrucao2.ItemIndex in [33, 57])) And
         (cmbTipDia.ItemIndex = 1) Then
      Begin
        fMensagem('ATENÇÃO','O tipo de dias para protesto deve ser "Úteis" conforme a instrução!'+strMensagemConfig,['&OK']);
        Result := False;
      End;
    End}

    Else If (Sender = chkCartSeq) Then
    Begin
      If (chkCartSeq.Checked) Then
      Begin
        If fVerificaCartPrimariaAutBan('CONFIG981-', tabCarteira.TabIndex + 1) Then
        Begin
          fMensagem('ATENÇÃO','Não pode ser utilizada sequência de Arquivo de Remessa de outra carteira, pois essa está cadastrada no campo Carteira Seq. de outra(s) carteira(s).' ,['&O K']);
          Result := False;
        End;
      End;
    End

    Else If (Sender = edtCartSeq) Then
    Begin
      If (chkCartSeq.Checked) Then
      Begin
        If fEmptyStr(edtCartSeq.Text) Then
        Begin
          fMensagem('ATENÇÃO','O campo Carteira Seq. deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else
        Begin
          If (Pos(edtCartSeq.Text, '1_2_3_4_5_') <= 0) Then
          Begin
            fMensagem('ATENÇÃO','O campo Carteira Seq. deve ter valor entre 1 e 5!' ,['&O K']);
            Result := False;
          End
          Else
          If edtCartSeq.Text = IntToStr(tabCarteira.TabIndex + 1) Then
          Begin
            fMensagem('ATENÇÃO','O campo Carteira Seq. não pode ser igual a carteira selecionada!' ,['&O K']);
            Result := False;
          End
          Else
          If fEmptyStr(fGetBancoConfig(0, 'CONFIG981-' + edtCartSeq.Text, 'PROXNUM', '')) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa não possui Último Núm. Seq. Remessa cadastrado!' ,['&O K']);
            Result := False;
          End
          Else
          If fVerificaCartFilhaAutBan('CONFIG981-' + edtCartSeq.Text) Then
          Begin
            fMensagem('ATENÇÃO','Não pode ser usada essa carteira no campo Carteira Seq., pois essa já possui uma Carteira Seq. cadastrada!' ,['&O K']);
            Result := False;
          End;
        End;
      End;
    End
    // DADOS BENEFICIARIO
    Else If Sender = edtUsaSac Then
    Begin

      If Pos(edtUsaSac.Text, 'S_N_') <= 0 Then
      Begin
        fMensagem('','O campo Enviar Sacador/Avalista deve ser preenchido com (S/N)!',['&O K']);
        Result := False;
      End
      Else If (edtUsaSac.Text = 'N') Then
      Begin
        edtCompBen.Clear;
        edtDesBen.Clear;
        edtEndBen.Clear;
        edtBaiBen.Clear;
        edtCidBen.Clear;
        edtEstBen.Clear;
        edtCepBen.Clear;
        edtCgcBen.Clear;
      End;

      grpBeneficiario.Enabled := edtUsaSac.Text = 'S';
    End
    Else If Sender = edtDesBen Then
    Begin
      If (fEmptyStr(edtDesBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End
    Else If Sender = edtEndBen Then
    Begin
      If (fEmptyStr(edtEndBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Endereço do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End
    Else If Sender = edtBaiBen Then
    Begin
      If (fEmptyStr(edtBaiBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Bairro do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End
    Else If Sender = edtCidBen Then
    Begin
      If (fEmptyStr(edtCidBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Cidade do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End
    Else If Sender = edtEstBen Then
    Begin
      If (fEmptyStr(edtEstBen.Text)) And (edtUsaSac.Text = 'S') Then
      Begin
        fMensagem('ATENÇÃO','O campo Estado do beneficiário deve ser preenchido!' ,['&O K']);
        Result := False;
      End
    End
    Else If Sender = edtCepBen Then
    Begin
      If (edtUsaSac.Text = 'S') Then
      Begin
        If (fEmptyStr(fRetSomenteNumeros(edtCepBen.Text))) Then
        Begin
          fMensagem('ATENÇÃO','O campo CEP do beneficiário deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else If Length(fRetSomenteNumeros(edtCepBen.Text)) < 8 Then
        Begin
          fMensagem('ATENÇÃO','O campo CEP do beneficiário deve ser preenchido com 8 números!' ,['&O K']);
          Result := False;
        End;
      End;
    End
    Else If Sender = edtCgcBen Then
    Begin
      If (edtUsaSac.Text = 'S') Then
      Begin
        If (fEmptyStr(fTiraCaracEspeciaisPonto(edtCgcBen.Text))) Then
        Begin
          fMensagem('ATENÇÃO','O campo CNPJ do beneficiário deve ser preenchido!' ,['&O K']);
          Result := False;
        End
        Else If (Length(fTiraCaracEspeciaisPonto(edtCgcBen.Text)) < 14) Or (Not fValidaCnpjCpf(edtCgcBen.Text)) Then
        Begin
          fMensagem('ATENÇÃO','O campo CNPJ do beneficiário deve conter um número válido!' ,['&O K']);
          Result := False;
        End;
      End;
    End;
  End;

  If Not Result Then
  begin
    if not blnNaoEditar then
    begin
      cxPaginas.ActivePage := RetornaAbaDoComponete(Sender);
      pSetFocus(Sender);
    end;
  end;
End;

procedure TfrmConfigMultiplike.grdTarifasDBTableView1DblClick(Sender: TObject);
begin
  inherited;
  If Not cdsCnfOco.isEmpty Then
    btnEdtOco.Click;

end;

procedure TfrmConfigMultiplike.edtCodFshEnter(Sender: TObject);
begin
  inherited;
  edtCodFsh.Hint := 'Código fornecido pelo banco ' + #13+#10 +
                    'para envio de mensagens na ' + #13+#10 +
                    'remessa quando utilizada a ' + #13+#10 +
                    'instrução 93 ou a instrução 94.';
  pShowHint(edtCodFsh, 'Código Flash');
end;

procedure TfrmConfigMultiplike.edtCodFshExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigMultiplike.edtCodLiqEnter(Sender: TObject);
begin
  inherited;
  edtCodLiq.Hint := 'O código de liquidação vem na posição 393-394    ' + #13 + #10 +
                    'do arquivo de retorno. Se esse campo estiver     ' + #13 + #10 +
                    'gravado como "S", para o registro que possuir um ' + #13 + #10 +
                    'desses códigos: AC, B0, B1, B2, B3, B4, B5, B6,  ' + #13 + #10 +
                    'B7, CC, ou LC, será adicionado um dia útil à data' + #13 + #10 +
                    'do crédito da Movimentação Bancária na baixa do  ' + #13 + #10 +
                    'título.';

  pShowHint(edtCodLiq, 'Considerar código de liquidação');
end;

procedure TfrmConfigMultiplike.edtCodLiqExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigMultiplike.edtCodPorKeyPress(Sender: TObject; var Key: Char);
  var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPor, edtDesPor, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodPor, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigMultiplike.edtCodPorRemKeyPress(Sender: TObject;
  var Key: Char);
var
 ArrSel: TConsultasArray;
begin
  inherited;

  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtCodPorRem, edtDescPorRem, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtCodPorRem, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigMultiplike.pCarregaPortador(strCodPor: String; edtLabel: TEdit);
begin
  pPesquisaCadPor(Nil, qryCadPor, strCodPor);
  With qryCadPor Do
  Begin
    edtLabel.Text := FieldByName('POR_NOMPOR').AsString;
  End;

end;

procedure TfrmConfigMultiplike.pHideHint;
begin
  HintControler.HideHint;
end;


procedure TfrmConfigMultiplike.pLimpaCampos;
var
  i: Integer;
begin
  for i := Self.ComponentCount -1 downto 0 do
  begin
    if (Self.Components[i] is TEditFocus) then
      (Self.Components[i] as TEditFocus).text := '';

    if (Self.Components[i] is TfraDirectoryEditFocus) then
      (Self.Components[i] as TfraDirectoryEditFocus).edtDirectory.text := '';

    if (Self.Components[i] is TCheckBox) then
      (Self.Components[i] as TCheckBox).Checked := False;

    if (Self.Components[i] is TComboBoxFocus) then
      (Self.Components[i] as TComboBoxFocus).ItemIndex := -1;
  end;
end;

procedure TfrmConfigMultiplike.pShowHint(edtEdit: TEditFocus; strTitulo: String);
begin
  HintControler.ShowHint(edtEdit.ClientOrigin.X,edtEdit.ClientOrigin.Y, strTitulo, edtEdit.Hint);
end;

procedure TfrmConfigMultiplike.pShowHintBotao(btnBotao: TBitBtnLocked;
  strTitulo: String);
begin
  HintControler.ShowHint(btnBotao.ClientOrigin.X,btnBotao.ClientOrigin.Y, strTitulo, btnBotao.Hint);
end;

function TfrmConfigMultiplike.RetornaAbaDoComponete(Sender: TWinControl): TCxTabSheet;
begin
  While Not Sender.ClassName.Equals('TcxTabSheet') Do
  Begin
    Sender := Sender.Parent;
  End;
  Result := TcxTabSheet(Sender);
end;

procedure TfrmConfigMultiplike.edtDiasCredEnter(Sender: TObject);
begin
  inherited;

  edtDiasCred.Hint := 'Informar quantidade de dias ' + #13+#10 +
                      'do intervalo entre a efetuação ' + #13+#10 +
                      'do pagamento e o crédito na ' + #13+#10 +
                      'conta corrente.';

  pShowHint(edtDiasCred, 'Dias para Crédito');

end;

procedure TfrmConfigMultiplike.edtDiasCredExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigMultiplike.pCarregaCentroCusto(strCtaBai: String;  edtLabel: TEdit);
begin
  pPesquisaCadCta(qryCadCta, qryCadCta, strCtaBai);
  With qryCadCta Do
  Begin
    edtLabel.Text := FieldByName('CTA_DESCTA').AsString;
  End;

end;

procedure TfrmConfigMultiplike.tabCarteiraChange(Sender: TObject);
begin
  inherited;
  pCarregaDados;
  cxPaginas.ActivePage := tbsGeral;
end;


procedure TfrmConfigMultiplike.tabCarteiraChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if btnCancelar.Visible then
  begin
    btnCancelar.Click;
    if btnCancelar.Visible then
      AllowChange := False;
  end;

  inherited;

end;

procedure TfrmConfigMultiplike.FormActivate(Sender: TObject);
begin
  inherited;
  If edtProxNumArqRem.Enabled Then
    pSetFocus(edtProxNumArqRem)
  Else
    pSetFocus(edtCodAgencia);
end;

procedure TfrmConfigMultiplike.FormCreate(Sender: TObject);
begin
  inherited;
  pCarKeyAutBan;
  qryCadPor := fCriaQuery(Self);
  qryCadFor := fCriaQuery(Self);
  cxPaginas.Properties.ActivePage := tbsGeral;

  If fCfgSis('ENCBAN', varBoolean) Then
    tbsEncBan.TabVisible := True
  else
    tbsEncBan.TabVisible := False;

end;

procedure TfrmConfigMultiplike.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Escape) then
  begin
    if btnCancelar.Visible then
    begin
      btnCancelar.Click;
      if btnCancelar.Visible then
        SysUtils.Abort;
    end;
  end;

  inherited;
end;

procedure TfrmConfigMultiplike.ApplicationEventsDeactivate(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigMultiplike.btnAddOcoClick(Sender: TObject);
begin
  inherited;
  frmCadOcoCartei := TfrmCadOcoCartei.Create(nil);
  frmCadOcoCartei.strCartei :=  'CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp;
  frmCadOcoCartei.cmbTipDes.Visible := True;
  frmCadOcoCartei.cmbTipDes.Enabled := True;
  frmCadOcoCartei.lblTipDes.Visible := True;
  Try
    frmCadOcoCartei.ShowModal;
  Finally
    FreeAndNil(frmCadOcoCartei);
  End;
  pCarregaOcorrencias;
end;

procedure TfrmConfigMultiplike.btnCancelarClick(Sender: TObject);
begin
  inherited;
  if fMensagem('Aviso', 'Deseja cancelar a alteração/inclusão do registro da carteira selecionada?', ['&S i m', '&N ã o'], 2) = 1 then
  begin
    cxPaginas.ActivePage :=  tbsGeral;
    btnCancelar.Visible := False;
    btnEditar.Visible   := True;
    pnlAtivo1.Enabled := False;
    pnlComplemento.Enabled := pnlAtivo1.Enabled;

    if tbsEncBan.tabVisible then
       pnlAtivo2.Enabled:= False;

    btnEditar.Visible   := True;
    btnGravar.Enabled   := False;
    btnConfigurar.Enabled := False;
    pCarregaDados;
    pSetFocus(btnEditar);
  end;
end;

procedure TfrmConfigMultiplike.btnConfigurarClick(Sender: TObject);
begin
  inherited;
  Try
    pHideHint;

    pCriarFormularios(TfrmCfgGenericas_AutBan, frmCfgGenericas_AutBan);
    frmCfgGenericas_AutBan.strNomForm := Self.Name;
    frmCfgGenericas_AutBan.strCodBco  := '981';
    frmCfgGenericas_AutBan.ShowModal;

  Finally
    FreeAndNil(frmCfgGenericas_AutBan);
  End;

end;

procedure TfrmConfigMultiplike.BtnManualClick(Sender: TObject);
  Var
    strDirCor: String;
    strFile: String;
begin
  inherited;

  strDirCor := ExtractFilePath(Application.ExeName);
  strFile := strDirCor+'layout';

  If DirectoryExists(strFile) Then
  Begin
    If FileExists(strFile+'\981400p.pdf') Then
      ShellExecute(Application.Handle, 'open',PChar(strFile+'\981400p.pdf'),nil,nil,SW_SHOWNORMAL)
    Else
      fMensagem('Informação', 'O Arquivo Manual não existe!',['&O K']);
  End;

end;

procedure TfrmConfigMultiplike.BtnOcorrenciaClick(Sender: TObject);
  Var
    strDetalhe : String;
begin
  inherited;
  pHideHint;


  strDetalhe := #13#10 +
                '06, 08 - Baixa duplicata; ' + #13#10 +
                '02, 04 - Atualiza nosso número caso não tenha gravado; ' + #13#10 +
                '23 - Lança histórico de protesto; ' + #13#10 +
                #13#10 +
                'As ocorrências listadas também fazem a atualização do código ' +
                'do Evento e do Portador das duplicatas, no caso dessas '+
                'ocorrências possuírem Evento/Portador vinculados.'+ #13#10 +
                #13#10 +
                'As demais ocorrências são gravadas na rotina ' +
                'de retorno e mostradas no relatório apenas em ' +
                'caráter informativo.'+ #13#10 +
                #13#10 +
                'Pressione Esc para voltar à tela de configurações.';


  TfrmMemo.pShowMessage('Banco 981 - Banco Multiplike - Detalhamento de Ocorrências (posições 109 - 110 arquivo retorno).' + #13#10 +
                        strDetalhe);
end;

procedure TfrmConfigMultiplike.BtnOcorrenciaEnter(Sender: TObject);
begin
  inherited;
  btnOcorrencia.Hint := 'Lista detalhada dos códigos de ocorrências ' + #13+#10 +
                        'que são tratados pelas rotinas do sistema.';
  pShowHintBotao(btnOcorrencia, 'Lista Ocorrências.');
end;

procedure TfrmConfigMultiplike.BtnOcorrenciaExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigMultiplike.btnRemOcoClick(Sender: TObject);
Var
  objCnfOco: TCnfOco;
  objCnfDao: TCnfOcoDao;
  strCodBco: String;
  strTipLay: String;
  strNumPos: String;
  strEspeci: String;
  strCodEmp: String;
  intCartei: Integer;
begin
  inherited;
  If Not cdsCnfOco.isEmpty Then
  Begin
    if fMensagem('Aviso', 'Confirma remoção da ocorrência selecionada?', ['&S i m', '&N ã o']) = 1 then
    Begin
      pDesmembraCarteira('CONFIG981-' + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_strCodEmp,
                         strCodBco, strTipLay, strNumPos, strEspeci, strCodEmp, intCartei);

      objCnfDao := TCnfOcoDao.Create(strCodBco, strTipLay, strNumPos,
                                     strEspeci, strCodEmp, intCartei);

      objCnfOco := objCnfDao.fBuscaPorOcorrencia(cdsCnfOcoCNF_CODOCO.AsString,'',Copy(cdsCnfOcoCNF_PLNCON.AsString,1,7),cdsCnfOcoCNF_TIPDES.AsInteger);
      If Assigned(objCnfOco) Then
      Begin
        If objCnfDao.fRemoverOcorrencia(objCnfOco.strCodOco,'',objCnfOco.strCodCta,objCnfOco.intTipDes) Then
        Begin
          pCarregaOcorrencias;
          pMensagemOk('Registro removido com sucesso!');
        End;
        objCnfOco.Free;
      End;
      objCnfDao.Free;
    End;
  End;
end;

procedure TfrmConfigMultiplike.chkCartSeqClick(Sender: TObject);
begin
  inherited;
  If Not fValidaCampos(chkCartSeq) Then
    TCheckBox(Sender).Checked := False;

  lblCartSeq.Enabled := TCheckBox(Sender).Checked;
  edtCartSeq.Enabled := TCheckBox(Sender).Checked;
end;

procedure TfrmConfigMultiplike.cmbNumCartChange(Sender: TObject);
begin
  inherited;
  If cmbNumCart.ItemIndex = 13 Then
    edtCodCar.Text := 'E'
  Else If cmbNumCart.ItemIndex = 14 Then
    edtCodCar.Text := 'U'
  Else If cmbNumCart.ItemIndex >= 24 Then
    edtCodCar.Text := 'D'
  Else
    edtCodCar.Text := 'I';
end;

procedure TfrmConfigMultiplike.edtForTarKeyPress(Sender: TObject; var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************KP*}
  If fPesqFornecedor(conForCompleta, Self, edtForTar, edtDesForTar, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(edtForTar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmConfigMultiplike.edtPorTarKeyPress(Sender: TObject; var Key: Char);
var
    ArrSel: TConsultasArray;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    If fPesqPortador(conSimples, Self, edtPorTar, edtDesPorTar, nil, Key, arrSel) then
    Begin
      If fValidaCampos(edtPorTar, True) Then
        Self.SelectNext(ActiveControl, True, True);
    End;
  End;
end;

procedure TfrmConfigMultiplike.edtUsaSacExit(Sender: TObject);
begin
  inherited;
  fValidaCampos(edtUsaSac);
end;

procedure TfrmConfigMultiplike.edtValorTarifaExit(Sender: TObject);
begin
  inherited;
  try
    if not fEmptyStr(edtValorTarifa.Text) then
       edtValorTarifa.Text := FormatFloat('###,##0.00', fStrToFloat(edtValorTarifa.Text));
  except
      edtValorTarifa.Text := FormatFloat('###,##0.00', 0);
  end
end;

procedure TfrmConfigMultiplike.edtMandMsgEnter(Sender: TObject);
begin
  inherited;
  edtMandMsg.Hint := 'Enviar número de duplicatas agrupadas.  '+ #13#10 +
                     'Configuração não válida para intruções 93 ou 94. ';

  pShowHint(edtMandMsg, 'Duplicatas agrupadas');
end;

procedure TfrmConfigMultiplike.edtMandMsgExit(Sender: TObject);
begin
  inherited;
  pHideHint;
end;

procedure TfrmConfigMultiplike.pCarregaCfg(Var stlCampos: TStringList);
begin
  stlCampos.Clear;
  stlCampos.Add('Seq. remessa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROXNUM', ''));
  stlCampos.Add('Util. outra cart. :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'USASEQC', ''));
  stlCampos.Add('Seq. carteira     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SEQCART', ''));
  stlCampos.Add('Cód. agência      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODAGEN', ''));
  stlCampos.Add('Número C/C        :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCTAC', ''));
  stlCampos.Add('Dígito C/C        :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIGCTAC', ''));
  stlCampos.Add('Identif. Bancária :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'IDENTBC', ''));
  stlCampos.Add('Cód. carteira     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODCART', ''));
  stlCampos.Add('Num. carteira     :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NUMCART', ''));
  stlCampos.Add('Portador de baixa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORBAI_', ''));
  stlCampos.Add('Portador da remessa :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORREM_', ''));
  stlCampos.Add('Conta de baixa    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CTABAI_', ''));
  stlCampos.Add('Cód. instrução 1  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU1', ''));
  stlCampos.Add('Cód. instrução 2  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INSTRU2', ''));
  stlCampos.Add('Observação 1      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV1', ''));
  stlCampos.Add('Observação 2      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV2', ''));
  stlCampos.Add('Observação 3      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV3', ''));
  stlCampos.Add('Observação 4      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV4', ''));
  stlCampos.Add('Observação 5      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'OBSERV5', ''));
  stlCampos.Add('Dias p/ protesto  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAPROT', ''));
  stlCampos.Add('Dias p/ crédito   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIACRED', ''));
  stlCampos.Add('Dias p/ mora      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'DIAMORA', ''));
  stlCampos.Add('Arquivo remessa   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHREM', ''));
  stlCampos.Add('Arquivo retorno   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PATHRET', ''));
  stlCampos.Add('Percentual Multa  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PERMULT', ''));
  stlCampos.Add('Inf. adicional    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'INFADIC', ''));
  stlCampos.Add('Responsável Bol.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'RESPONS', ''));
  stlCampos.Add('Protocolo aceite  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PROACEI', ''));
  stlCampos.Add('Exp. CNPJ Cedente :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'EXPCNPJ', ''));
  stlCampos.Add('Tipo dia protesto :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'TIPDIA', ''));
  stlCampos.Add('Código do Flash   :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CDFLASH', ''));
  stlCampos.Add('Envia Dup. Agrup. :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ENVDUPAG', ''));
  stlCampos.Add('Conv. Serasa      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CVSERAS', ''));
  stlCampos.Add('EncBan - Vr Tarifa:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'VALOTAR', ''));
  stlCampos.Add('EncBan - Portador :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'PORTTAR', ''));
  stlCampos.Add('EncBan - Conta    :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CONTTAR', ''));
  stlCampos.Add('EncBan - Fornec.  :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'FORNTAR', ''));
  stlCampos.Add('Considerar código liquidação:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CODLIQU', 'N'));

  stlCampos.Add('Envia Sacador/Avalista:' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'SACAVAL', 'N'));
  stlCampos.Add('Beneficiário      :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'NOMEBEN', ''));
  stlCampos.Add('Endereço          :' + fGetBancoConfig(0, strConfig+ IntToStr(tabCarteira.TabIndex + 1), 'ENDEBEN', ''));
  stlCampos.Add('Bairro            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'BAIRBEN', ''));
  stlCampos.Add('Complemento       :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'COMPBEN', ''));
  stlCampos.Add('Cidade            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CIDABEN', ''));
  stlCampos.Add('Estado            :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'ESTABEN', ''));
  stlCampos.Add('CEP               :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CEP_BEN', ''));
  stlCampos.Add('CNPJ              :' + fGetBancoConfig(0, strConfig + IntToStr(tabCarteira.TabIndex + 1), 'CNPJBEN', ''));
end;

procedure TfrmConfigMultiplike.pGravaLogCarteira(stlCfgAnt : TStringList);
Var
  intCont,
  intIndice: Integer;
  stlCfgAtu: TStringList;
  strCmpAlt: String;

  function fRetStrCfg(stlCfg : TStringList) : String;
  Var
    intCont : Integer;
  begin
    Result := '';

    For intCont := 0 To stlCfg.Count - 1 Do
      Result := Result + stlCfg.Strings[intCont] + #13+#10;
  end;

begin
  stlCfgAtu := TStringList.Create;
  pCarregaCfg(stlCfgAtu);
  strCmpAlt := '';

  For intCont := 0 To stlCfgAtu.Count - 1 Do
  Begin
    If stlCfgAnt.Strings[intCont] <> stlCfgAtu.Strings[intCont] Then
    Begin
      intIndice := Pos(':', stlCfgAnt.Strings[intCont]);

      If Not fEmptyStr(strCmpAlt) Then
        strCmpAlt := strCmpAlt + #13+#10;

      strCmpAlt := strCmpAlt + Copy(stlCfgAnt.Strings[intCont], 1, intIndice) +
                  ' Valor Anterior - ' + Copy(stlCfgAnt.Strings[intCont], intIndice + 1, Length(stlCfgAnt.Strings[intCont]) - intIndice) +
                  ' Valor Atual - ' + Copy(stlCfgAtu.Strings[intCont], intIndice + 1, Length(stlCfgAtu.Strings[intCont]) - intIndice);
    End;
  End;

  If Not fEmptyStr(strCmpAlt) Then
    pGravaLogAtb('981', 'Multiplike', strConfig + IntToStr(tabCarteira.TabIndex + 1) + '-' + VS_StrCodEmp,
                 strLoginUsuarioLogado, VS_StrCodEmp, fRetStrCfg(stlCfgAnt), fRetStrCfg(stlCfgAtu), strCmpAlt);

  FreeAndNil(stlCfgAtu);
end;

end.
