{***************************}
{* qryConEmp -> CADEMP     *}
{* qryConFor -> CADFOR     *}
{* qryConCta -> CADCTA     *}
{* qryConPor -> CADPOR     *}
{************************JB*}
unit untCadCtaPagar;

interface

uses
  Windows, Classes, Controls, Forms, StdCtrls, untPaiCad, Mask, DBCtrls,
  DBEditFocus, ComCtrls, UniClientDataSet, Buttons, ExtCtrls, DB, QColorLabel, Menus,
  EditFocus, Uni, frxClass, frxDBSet, frxDMPExport, AppEvnts, DBMemoFocus,
  BitBtnLockedIncrem, UniScript, frxExportCSVTestabilidade, dxScreenTip,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer,
  cxEdit, DateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Math,
  cxDBEdit, cxClasses, dxCustomHint, cxHint, MaskEditFocus,
  cxButtons, untCtpListaPortadores,
  System.Generics.Collections, untTypesSistema, Vcl.Graphics, untFechamentoFinanceiro,
    System.IOUtils, untMetaCentroCustoPedido, DBComboBoxFocus,
  DBLookupComboBoxFocus, Datasnap.Provider, Winapi.Messages, ComboBoxFocus,
  untLiberacao, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, MemDS,
  DBAccess, untFrameCentroCustoDBEditFocus,untExclusaoAutCtaPagar,
  untFramePlanoDeContasDBEditFocus,untRelConhecimentoFrete,untTValidaCorrespondenteContabil, 
  untFrmManipulaContasPagarPrevisaoNao, untLogCtpDet, untGravando, cxProgressBar;

type
  TfrmCadCtaPagar = class(TfrmPaiCad)
    pnlGeral: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeNumDup: TDBEditFocus;
    dbeParcel: TDBEditFocus;
    Label3: TLabel;
    dbeCodEmp: TDBEditFocus;
    dbeCodPor: TDBEditFocus;
    Label5: TLabel;
    dbeCodFor: TDBEditFocus;
    pnlDetalhe: TPanel;
    Label7: TLabel;
    dbeDtaCad: TDBEditFocus;
    dbeDtaVen: TDBEditFocus;
    Label8: TLabel;
    Label9: TLabel;
    dbeValDup: TDBEditFocus;
    Label11: TLabel;
    dbeVeiobo: TDBEditFocus;
    Label17: TLabel;
    Label4: TLabel;
    dbePrevis: TDBEditFocus;
    pnlDadosBaixa: TPanel;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label24: TLabel;
    Label6: TLabel;
    Label14: TLabel;
    pnlBotoesInfo: TPanel;
    Label15: TLabel;
    dbeSerie: TDBEditFocus;
    ColorLabel2: TColorLabel;
    ColorLabel1: TColorLabel;
    Label10: TLabel;
    edtNomEmp: TEditFocus;
    edtNomFor: TEditFocus;
    edtNomPor: TEditFocus;
    edtTipBai: TEditFocus;
    edtDtaPag: TEditFocus;
    edtDesCtaBai: TEditFocus;
    edtPorBai: TEditFocus;
    edtOpeBai: TEditFocus;
    edtSeqBai: TEditFocus;
    edtValOri: TEditFocus;
    edtValPag: TEditFocus;
    edtDocBai: TEditFocus;
    edtHisBai: TEditFocus;
    dbeDesSuj: TDBEditFocus;
    dbeJurSuj: TDBEditFocus;
    Label16: TLabel;
    Label20: TLabel;
    ColorLabel3: TColorLabel;
    dbeUsaChq: TDBEditFocus;
    Label25: TLabel;
    dbeTipDoc: TDBEditFocus;
    dbecodvel: TDBEditFocus;
    Label29: TLabel;
    Label31: TLabel;
    dbeDeposi: TDBEditFocus;
    ColorLabel5: TColorLabel;
    dtsTabela: TDataSource;
    dbeVendor: TDBEditFocus;
    lblVendor: TLabel;
    lbl1: TLabel;
    dbeVeioNF: TDBEditFocus;
    ColorLabel6: TColorLabel;
    dbePagAnt: TDBEditFocus;
    Label32: TLabel;
    frxDataset: TfrxDBDataset;
    frxGen: TfrxUserDataSet;
    dbeHisto1: TDBMemoFocus;
    gpbCodBar: TGroupBox;
    dbeCodBar: TDBEditFocus;
    btnBaixarDup: TBitBtnLocked;
    btnDesmembr: TBitBtnLocked;
    btnAltNumDoc: TBitBtnLocked;
    btnAbrirPastaAnexos: TBitBtnLocked;
    dbeLinDig: TDBEditFocus;
    chkCodBar: TCheckBox;
    chkLinDig: TCheckBox;
    Label33: TLabel;
    dbeUsoCon: TDBEditFocus;
    ColorLabel7: TColorLabel;
    HintControler: TcxHintStyleController;
    Label12: TLabel;
    Label34: TLabel;
    ColorLabel8: TColorLabel;
    dbeCompet: TMaskEditFocus;
    btnListarPortadores: TcxButton;
    dbeCtaBai: TDBEditFocus;
    lblTipoPagamento: TLabel;
    Label35: TLabel;
    dbeQtdDia: TDBEditFocus;
    btnHistPagam: TBitBtnLocked;
    lblGuia: TLabel;
    Label36: TLabel;
    btnLiberacaoBaixa: TBitBtnLocked;
    btnEstorno: TBitBtnLocked;
    lblValorOutrasEntidades: TLabel;
    dbeValorOutrasEntidades: TDBEditFocus;
    lblValTot: TLabel;
    edtValTot: TEditFocus;
    btnDetalharValoresBaixa: TBitBtnLocked;
    edtEntidadesZerado: TEditFocus;
    edtVendorZerado: TEditFocus;
    dtsGuiaTributo: TDataSource;
    btnRomaneio: TBitBtnLocked;
    LcbGuiaTributo: TDBLookupComboBox;
    LcbTipoTributo: TDBLookupComboBox;
    dtsTipoTributo: TDataSource;
    spbDicaTributo: TSpeedButton;
    btnAjuVal: TBitBtnLocked;
    btnEspelhoNotaFiscal: TBitBtnLocked;
    pnlProjeto: TPanel;
    lblProjeto: TLabel;
    edtDesPrj: TEditFocus;
    dbeCodPrj: TDBEditFocus;
    fraCentroCusto: TfraCentroCustoDBEditFocus;
    btnExcluirAut: TBitBtnLocked;
    fraPlanoDeContas: TfraPlanoDeContasDBEditFocus;
    btnPendLiberacao: TBitBtnLocked;
    btnEspelhoCte: TBitBtnLocked;
    dbeMulSuj: TDBEditFocus;
    lblMulSuj: TLabel;
    pnlEnvBan: TPanel;
    Label13: TLabel;
    Label28: TLabel;
    Label37: TLabel;
    dbeDtaEnv: TDBEditFocus;
    dbeBcoBol: TDBEditFocus;
    edtNomBan: TEditFocus;
    DtsDadosBcoFor: TDataSource;
    lblStatusDoc: TLabel;
    edtStatus: TEdit;
    lblProvisão: TLabel;
    edtProvisao: TEdit;
    btnDocBaixa: TBitBtnLocked;
    edtNumPedCompra: TEditFocus;
    Label38: TLabel;
    Label39: TLabel;
    dbeHisto2: TDBMemoFocus;
    cbxBcoFor: TComboBoxFocus;
    btnImpCtaPagar: TBitBtnLocked;
    btnReinf: TBitBtnLocked;
    lblUsaMca: TLabel;
    clbUsaMca: TColorLabel;
    dbeUsaMca: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    function dbeCodEmpChamaCadastro(Key: Word): String;
    function dbeCodForChamaCadastro(Key: Word): String;
    procedure FormShow(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodForKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDesmembrClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnBaixarDupClick(Sender: TObject);
    procedure dbeDtaCadExit(Sender: TObject);
    procedure frxGenGetValue(const VarName: String; var Value: Variant);
    function dbeCodPorChamaCadastro(Key: Word): String;
    procedure dbeCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure dbeValDupEnter(Sender: TObject);
    procedure dbeHisto1KeyPress(Sender: TObject; var Key: Char);
    procedure btnAltNumDocClick(Sender: TObject);
    procedure btnAbrirPastaAnexosClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure chkCodBarClick(Sender: TObject);
    procedure chkLinDigClick(Sender: TObject);
    procedure dbeTipDocEnter(Sender: TObject);
    procedure dbeTipDocExit(Sender: TObject);
    procedure btnListarPortadoresClick(Sender: TObject);
    procedure dbeCtaBaiKeyPress(Sender: TObject; var Key: Char);
    procedure dbeQtdDiaEnter(Sender: TObject);
    procedure dbeQtdDiaExit(Sender: TObject);
    procedure btnHistPagamClick(Sender: TObject);
    procedure VisualizaComboGuiaTributos;
    procedure FormPaint(Sender: TObject);
    procedure dbeDeposiChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dtsTabelaStateChange(Sender: TObject);
    procedure cbxBcoForExit(Sender: TObject);
    procedure cbxBcoForKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnLiberacaoBaixaClick(Sender: TObject);
    procedure btnEstornoClick(Sender: TObject);
    procedure dbeValorOutrasEntidadesEnter(Sender: TObject);
    procedure btnDetalharValoresBaixaClick(Sender: TObject);
    procedure dbeValDupExit(Sender: TObject);
    procedure LcbGuiaTributoExit(Sender: TObject);
    procedure spbDicaTributoClick(Sender: TObject);
    procedure btnRomaneioClick(Sender: TObject);
    procedure btnEspelhoNotaFiscalClick(Sender: TObject);
    procedure dbeCodPrjKeyPress(Sender: TObject; var Key: Char);
    procedure btnAjuValClick(Sender: TObject);
    procedure dbeNumDupChange(Sender: TObject);
    procedure btnExcluirAutClick(Sender: TObject);
    procedure fraPlanoDeContasdbeCodCtaKeyPress(Sender: TObject; var Key: Char);
    procedure fraPlanoDeContasdbeCodCtaExit(Sender: TObject);
    function fraPlanoDeContasdbeCodCtaChamaCadastro(Key: Word): string;
    procedure btnPendLiberacaoClick(Sender: TObject);
    procedure btnEspelhoCteClick(Sender: TObject);
    procedure dbeBcoBolKeyPress(Sender: TObject; var Key: Char);
    procedure btnDocBaixaClick(Sender: TObject);
    procedure cbxBcoForChange(Sender: TObject);
    procedure cbxBcoForDropDown(Sender: TObject);
    procedure cbxBcoForEnter(Sender: TObject);
    procedure btnImpCtaPagarClick(Sender: TObject);
    procedure btnReinfClick(Sender: TObject);
  private
    { Private declarations }
    qryConCta: TUniQuery;
    qryCtaBai: TUniQuery;
    qryConEmp: TUniQuery;
    qryConFor: TUniQuery;
    qryConPor: TUniQuery;
    qryConPrj: TUniQuery;
    qryCtaFor: TUniQuery;
    qryGuiaTributo: TUniQuery;
    qryTipoTributo: TUniQuery;
    qryCadBco: TUniQuery;
    qryDadosBcoFor: TUniQuery;

    FDatasetCtpDet,
    FDatasetCtpDetClone: TUniClientDataSet;

    blnTelaReduzida: Boolean;
    blnValPlanoCusto: Boolean;

    fltValDupAnt: Double;
    fltValOriAnt: Double;
    fltValDupOld: Double;
    fltDesSujOld: Double;
    fltJurSujOld: Double;
    fltMulSujOld: Double;
    fltValVendorOld: Double;
    fltValOutrasEntidadesOld: Double;

    strDtaCadOld,
    strDtaVenOld,
    strCodPorOld,
    strCodCtaOld,
    strCompetOld : String;
    FValidaCorrespondenteContabil: TValidaCorrespondenteContabil;

    strCtaAnt: String;
    strCtaFor: String;
    strCtaAut: String;

    ANumDupAnterior,
    AParcelaAnterior,
    ACodEmpAnterior,
    ACodForAnterior,
    ASerieAnterior: String;
    ASeqBaiAnterior: Integer;
    AAlterouChave: Boolean;

    ACodigoNaturezaReinf : String;
    ACodigoServicoReinf  : String;
    ACodigoNaturezaReinf_Old : String;
    ACodigoServicoReinf_Old  : String;
    AAutoIncremReinf : String;

    strIni_CodNatAlteracao  : String;
    strIni_CodServAlteracao  : String;

    blnReinfAlterado : Boolean;
    blnUsouReinf : Boolean;

    {intGuia,
    intTributo     : Integer;}

    blnBaixada: Boolean;
    blnGravaMovBanSemDesmembrar: Boolean;

    intQtdReg: Integer;
    strCodFor: String;

    blnIniciaCadastro: Boolean;
    fltValLanLoc: Double;
    strHist01Loc,
    strCodPorLoc: String;
    dteDataLanLoc,
    dteDataVenLoc: TDate;
    arrSeqLanLoc: TStringArray;

    strSenhaDtaCadOld,
    strSenhaDtaVenOld,
    strSenhaValDupOld,
    strSenhaCodPorOld: String;
    FLigDigOld,
    FCodBarOld : String;

    blnAlterandoChave,
    blnTravarDes,
    blnTravarAlt: Boolean;

    lstBcoFor: TStringList;
    objLiberacao : TLiberacao;

    blnDupTravada: Boolean;
    strAutoincremLckAtc: String;

    blnUsaVendor: Boolean;
    objFechamento: TFechamentoFinanceiro;
    FEntradaDeMercadoriaQueNaoChegouNaEmpresa: Boolean;
    AValorTotalInicial: Double;
    ADataCadastroInicial: TDateTime;
    AEmpresaInicial: String;

    blnUsaLiberacaoDePrevisao,
    blnGravaApenasPrevisao   : Boolean;

    FAutoIncremMovGer: String;
    FArquivoIntegracao : String;

    procedure pHabilitaFields;
    procedure pDesabilitaFields;
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pAfterScroll(DataSet: TDataSet);
    procedure pCarregaEmpresa;
    procedure pCarregaFornecedor;
    procedure pPreencheCentroCusto;
    procedure pCarregaCentroCusto;
    procedure pCarregaCentroCustoBaixa;
    procedure pCarregaDadosBaixa;
    procedure pCarregaDadosAdicionais;
    procedure pCarregaEventos;
    procedure pCarregaPortador;
    procedure pCarregaProjeto;
    procedure pUtilizaRotinaProjeto;
    procedure pLimparEdits;
    procedure pAtribuiTabelas;
    procedure pIniciaValoresPadrao;
    procedure pDeletaCtpDet(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String);

    function fBaixaCtp: Boolean;
    function fLiberaBaixaCtp: Boolean;
    procedure pImprimeCP;

    procedure pHabilitaBotoes;

    procedure pAtualizaCtpDet(ANumeroAnterior, AEmpresaAnterior, AFornecedorAnterior, AParcelaAnterior, ASerieAnterior: String; Var AGravouLogCtpDet: Boolean);
    function fDuplicataPossuiMovGer(strCodFor, strNumDup, strSerie_, strCodEmp: String; var strEspDoc: String; blnMensagem: Boolean = True): Boolean; overload;
    function fDuplicataPossuiMovGer: Boolean; overload;
    function fBuscaDuplicata: Boolean;
    function fConfiguracoesRateioValidas(out AMsgRetorno: String): Boolean;
    function PedirConfirmacaoDadosBoleto: Boolean;
    function fValidaChqBolDep(Sender: TWinControl): Boolean;
    function fCtpExisteDupDependentes(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String): Boolean;

    procedure pLimpaCTPCom(strCTPCom: String);

    function fRetCodBarLinDig(strLinDig: String): String;
    function ValidaDataVencimentoBoleto(ASender: TObject): Boolean;
    function ValidaValorBoleto(ASender: TObject): Boolean;
    procedure pCarregaCompetencia;
    procedure pHabilitaDesabiltabtnAbrirPastaAnexos;
    procedure GravaLogCtp(strNumDup,
                          strParcel: String;
                          intSeqBai: Integer;
                          strCodEmp,
                          strCodFor,
                          strSerie_: String;
                          blnInserindo: Boolean;
                          AComplementoDescricao: String = '';
                          AAutoincrem: String = '');
    function fAlteraMovBanBanCtp(strCodCta, strNumDup, strOldFor, strNewFor, strSeqLan, strHisBai: String) : Boolean;    procedure pCarregaCtaFornecedor(strCodFor: String);
    function fPodeAlterarDocumento:Boolean;
    function fVinculadoReceber: Boolean;
    function  fRetEmpresaRealPagAnt(ACodEmp: string): string;
    function fVerificaDuplicataContabilizada: Boolean;
    function fPodeAlterarPlanoContaDuplicataContabilizada: Boolean;
    function fDigSenVarDuplicataContabilizada: BOolean;

    function fVerificaMeta(blnInserindo: Boolean): Boolean;
    function fCarregaDuplicata(ARotinaLiberacao: Boolean = False): Boolean;
    procedure pCarregaDadosBancariosFornecedor(strCodFor: String);
    procedure pTrataBcoFor;
    procedure pSetaBcoFor;
    procedure CarregaGuiasETributos(ATrazTributo: Boolean = False);

    procedure pCalculaValorTotal;

    procedure AcertaCamposDeGuiaETributos();
    function fIsGNRE: Boolean;
    function fTornaPendLiberacao(AAltCad:Boolean = False): Boolean;
    function fValidaTornarPend: Integer;
    procedure TravaAlteracaoDeCamposPrincipaisDaNotaDeEntrada;
    procedure pAtualizaDlp(AAutoIncrem: String);
    function fTemAlteracao: Boolean;
    function fEntradaDeMercadorias: Boolean;
    function fTemDesmembramento: Boolean;

    procedure RetornaDataInicialFinalMovDet(out ADataInicial,
                                                ADataFinal: String);
    procedure pCarregaBanco;

    function ImportarCtaPagar(pgbStatus: TcxProgressBar) : Boolean;
    procedure VerificaSeStatusFatura(StrNumdoc, strCodEmp, strCodFor,
      strSerie: String);
    procedure CarregaNumeroPedidoCompra(strNumDoc, strCodEmp, strCodFor, ASerie,AParcel : String; ASeqBai: Integer);
    procedure PosicionaContaFornecedor;
    function fVerificaReimpressaoCP(strNumDup, strParcel, strSerie, strCodEmp, strCodFor, strNomFor, strDtaCad: String): Boolean;
    function fPodeAlterarVendor: Boolean;
    function fPodeAlterarValoresAposFechamentoFinanceiro(Sender: TObject): Boolean;
    Function VerificaSeDuplicataTemCadFis(StrNumdoc, strCodEmp, strCodFor, strSerie: String) : Boolean;
    procedure pAtualizaCtp_REINF(strDupAnt, strEmpAnt, strForAnt: String);
    Procedure pAtualizaCorBotaoREINF(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String; strSeqBai : Integer);
    function fMontaNomePastaAnexos(const ACodFor, ACodEmp, AAutoIncrem: String): String;
    function fMoverPastaAnexos(const AOrigem, ADestino: String): Boolean;
    procedure pAjustaPastaAnexos(const ACodFor, ACodEmp, AAutoIncrem,
      ACodForAnt, ACodEmpAnt: String; const AMostraTela: Boolean = False);

  protected
    procedure pDestravarRegistros; override;

    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fExecutaAntesDoDelete: Boolean; override;

    function fVerificaExistemDeTributosParaGuia(ACodigoGuia: Integer) : Boolean;
  public
    { Public declarations }
    recUltDupBaixada : TUltDupBaixada;
    strAutoIncrem,
    strOrigem : String;
    class procedure pMostraIniciandoCadastro(fltValLan: Double; strHist01: String; dteDataLan, dteDataVen: TDate; strCodPor: String;var arrSeqLan: TStringArray);
  end;

implementation

uses SysUtils, StrUtils, Variants, untFuncoes, untConstantes, untfuncoesSimples,
     untPesqAux, untModulo, untFuncIns, untFuncIns2, untDesmembrValores,
     untPai, untBaixaCtaPagar, untCadCta, untQckCopiaCheque, untCadChq, untMovBan,
     untCadPag, untConsultas, untGravaArquivoPasta, untCfgRel, untReciboCtp,
     untBancos, untBaixaSintetica,
     untLogCtp, untFuncFat, untRelCtpLogAcompDuplicNovo,
     untCadFornecedores, untCtpLiberacaoBaixa, untMsgLiberacao,
     untLiberacaoFactory, untEstornoPagar, Dialogs,
     Contabilidade.Funcoes, Contabilidade.Consultas, untCtpDetalhesBaixa,
     untTDuplicataAgrupamento, untCadCtaPagarRomaneio, untRelEspNotaEnt,
     untCadClientes, untCadTransportadoras,untPanelCxCadPagar,untPnlPesqCadPag,
     untCadCtaPagarParcelas, untFuncoesRel, untFuncoesRel2,untTLiberaBaixaPagar,
     untCtrDocBaixa, untIntegracaoTicketLog, untDigReinfCTP;

{$R *.dfm}

{ TfrmCadCtaPagar }

function TfrmCadCtaPagar.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strDtaCad: String;
    strDtaVen: String;
    fltValDup: Double;
    blnValEna: Boolean;
    blnEveRat: Boolean;
    blnPedeSenha: Boolean;
    intCodPag: Integer;
    SDuplicataAgrupamentoFiltro : TDuplicataAgrupamentoFiltro;
    SMensagem : String;
    oParametros: TParametrosDesmembraValoresCtaDet;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    try
      {*****************************************}
      {* VALIDA A DUPLICATA                    *}
      {**************************************MV*}
      If (Sender = dbeNumDup) Then
      Begin
        If fEmptyStr(dbeNumDup.Text) Then
        Begin
          dbeParcel.Enabled := False;
        End
        Else
        if Length(dbeNumDup.Text) < 12 then
        begin
          If (qryTabela.State in [dsInsert]) Then
            dbeNumDup.Text := fStrZero(dbeNumDup.Text, 12);
        end;
      End

      {*****************************************}
      {* VALIDA COMPETENCIA                    *}
      {**************************************BB*}
      Else if (Sender = dbeCompet) then
      Begin
        If not fValidaDataStr('01/'+ dbeCompet.Text) Then
        Begin
          pMensagemOk('Data informada na Competência não é válida!');
          Result := False;
        end

        Else If fEmptyStr(fTiraCaracEspeciais(dbeCompet.Text)) Then
        Begin
          pMensagemOk('A Competência deve ser preenchida!');
          Result := False;
        End

        Else If Length(fTiraCaracEspeciais(Trim(dbeCompet.Text))) < 6 Then
        Begin
          pMensagemOk('O ano da Competência deve ser preenchido com 4 dígitos!');
          Result := False;
        End;
      End

      {*****************************************}
      {* VALIDA A PARCELA                      *}
      {**************************************MV*}
      Else If (Sender = dbeParcel) Then
      Begin

        If fEmptyStr(dbeParcel.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Parcela deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not CharInSet(dbeParcel.Text[1], ['A'..'Z']) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Parcela deve estar entre A e Z!', ['&O k']);
          Result := False;
        End;

      End

      Else If (Sender = dbePrevis) And dbePrevis.Visible Then
      Begin

        If Pos(dbePrevis.Text, 'SN') <= 0 Then
        Begin
          Result := False;
          fMensagem('','O campo previsão deve ser informado com (S)im ou (N)ão!', ['&Ok']);
        End

        Else If (dbePrevis.Text = 'S') And (dbePagAnt.Text = 'S') Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!','Para informar previsão como (S)im, o campo pagamento antecipado deve estar igual à (N)ão!', ['&Ok']);
        End

        Else If (dbePrevis.Enabled And Not fCfgSis('PRECTP', varBoolean)) Then
        Begin
          If (qryTabela.State = dsEdit) And (dbePrevis.Text <> dbePrevis.Field.OldValue) Then
          Begin
            fMensagem('ATENÇÃO!', 'Não é permitido a alteração da previsão quando a configuração [CFG_PRECTP] está igual a (N)ão!', ['&O k']);
            Result := False;
          End;
        End;

      End

      Else If (Sender = dbePagAnt) And dbePagAnt.Visible  Then
      Begin
        If Pos(dbePagAnt.Text, 'SN') <= 0 Then
        Begin
          Result := False;
          fMensagem('','O campo pagamento antecipado deve ser informado com (S)im ou (N)ão!', ['&Ok']);
        End

        Else If (dbePrevis.Text = 'S') And (dbePagAnt.Text = 'S') Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO!','Para informar pagamento antecipado como (S)im, o campo previsão deve estar igual à (N)ão!', ['&Ok']);
        End;
      End

      {*****************************************}
      {* VALIDA O TIPO DO DOCUMENTO            *}
      {**************************************MA*}
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
            qryTabela.FieldByName('CTP_TIPDOC').AsString := '2';
          End
          Else
          Begin
            qryTabela.FieldByName('CTP_TIPDOC').AsString := dbeTipDoc.Text;
            LcbGuiaTributo.Visible := False;
            LcbTipoTributo.Visible := False;
            spbDicaTributo.Visible := False;
            LcbGuiaTributo.KeyValue := -1;
            LcbTipoTributo.KeyValue := EmptyStr;
            lblGuia.Visible := False;
            lblValorOutrasEntidades.Enabled := False;
            dbeValorOutrasEntidades.Enabled := False;
            fValidaCampos(LcbTipoTributo);
          End;


        End;
      End

      {*****************************************}
      {* VALIDA O CÓDIGO DA EMPRESA            *}
      {**************************************MV*}
      Else If (Sender = dbeCodEmp) Then
      Begin
        If fEmptyStr(dbeCodEmp.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código da Empresa deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          //FECHAMENTO FINANCEIRO
          //NÃO PODE TROCAR A EMPRESA
          If Not FEntradaDeMercadoriaQueNaoChegouNaEmpresa Then
          Begin
            if ((qryTabela.State = dsEdit) And (AEmpresaInicial <> dbeCodEmp.Text)) then
            begin
              if objFechamento.FechamentoFinanceiroJaRealizado(AEmpresaInicial, StrToDate(dbeDtaCad.Text)) then
                Result := False
              else
              if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, StrToDate(dbeDtaCad.Text)) then
                Result := False;
            end;
          End;

          If Pos(dbeCodEmp.Text, strEmpAcessoUsuarioLogado) <= 0 Then
          Begin
            fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso a essa Empresa!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            pCarregaEmpresa;
            If qryConEmp.FieldByName('EMP_CODEMP').IsNull Then
            Begin
              fMensagem('ATENÇÃO!', 'Essa empresa não está cadastrada!', ['&O k']);
              Result := False;
            End;
          End;
        End;
        pHabilitaBotoes;
      End

      {*****************************************}
      {* VALIDA O CÓDIGO DO FORNECEDOR         *}
      {**************************************MV*}
      Else If (Sender = dbeCodFor) Then
      Begin
        If fEmptyStr(dbeCodFor.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código do Fornecedor deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin

          {****************************************************************
           VALIDAR SE OS DADOS DA UNIQUE DO CONTAS A PAGAR NÃO ENCONTRAM-SE
             EM UMA DUPLICATA AGRUPADA.
          {**************************************************************GD}
          If not fEmptyStr(dbeNumDup.Text) and
             not fEmptyStr(dbeParcel.Text) and
             not fEmptyStr(dbeCodEmp.Text) and
             not fEmptyStr(dbeCodFor.Text) Then
          Begin
            SDuplicataAgrupamentoFiltro := TDuplicataAgrupamentoFiltro.Create(tpAgrupamentoContaPagar);
            try
              SDuplicataAgrupamentoFiltro.Duplicata        := dbeNumDup.Text;
              SDuplicataAgrupamentoFiltro.Parcela          := dbeParcel.Text;
              SDuplicataAgrupamentoFiltro.Serie_           := dbeSerie.Text;
              SDuplicataAgrupamentoFiltro.CodigoEmpresa    := dbeCodEmp.Text;
              SDuplicataAgrupamentoFiltro.CodigoFornecedor := dbeCodFor.Text;

              if TDuplicataAgrupamentoBuilder.DuplicataPresenteEmAgrupamento(SDuplicataAgrupamentoFiltro, SMensagem) then
                begin
                  fMensagem('ATENÇÃO!', 'Os Dados desta duplicata já encontram-se presentes no agrupamento '+
                  '"'+SMensagem+'" e não podem ser reutilizados.', ['&O k']);
                  Exit(False);
                end;

            finally
              FreeAndNil(SDuplicataAgrupamentoFiltro);
            end;
          End;

          pCarregaFornecedor;
          If qryConFor.FieldByName('FOR_CODFOR').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Fornecedor não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If qryConFor.FieldByName('FOR_STATUS').AsString <> 'A' Then
          Begin
            If qryTabela.State = dsInsert then
            begin
              fMensagem('ATENÇÃO!', 'Esse fornecedor está inativo!', ['&O k']);
              Result := False;
            END;
          End
          Else If (blnBuscaPorChave) And (Not blnAlterandoChave) Then
          Begin
            strDtaCad := dbeDtaCad.Text;
            strDtaVen := dbeDtaVen.Text;

            If (fVerificaCtpDet(dbeNumDup.Text,
                                dbeParcel.Text,
                                dbeSerie.Text,
                                dbeCodEmp.Text,
                                dbeCodFor.Text,
                                blnEveRat)) Then
            Begin
              fraPlanoDeContas.dbeCodCta.Enabled := False;
              If blnEveRat Then
              Begin
                fraCentroCusto.dbeCodEve.Text  := fCfgSis('EVEPRI');
                fraCentroCusto.dbeCodEve.Enabled := False;
                pCarregaEventos;
              End
              Else
              Begin
                fraCentroCusto.dbeCodEve.Enabled := True;
                pCarregaEventos;
              End;
            End
            Else
            Begin
              {*****************************************************}
              {* SÓ PODE ALTERAR O VALDUP SE TEM DIREITO DE ACESSO *}
              {**************************************************JU*}
              If (qryTabela.State = dsEdit) Then
               Begin
                If fEmptyStr(fCfgSis('CTPSVD')) Then
                Begin
                  If Not fVerificaAcessoSistema('CTPALTVLR') And (qryTabela.State In [dsEdit]) Then
                  Begin
                    dbeValDup.Enabled := False;

                    If fEmptyStr(dbeValDup.Text) Then
                      dbeValDup.Field.Value := 0.00;

                    dbeDesSuj.Enabled := False;
                    dbeJurSuj.Enabled := False;
                    dbeMulSuj.Enabled := False;
                    dbeVendor.Enabled := False;
                  End
                  Else If fVerificaAcessoSistema('CTPALTVLR') Then
                    dbeValDup.Enabled := True;

                  fraPlanoDeContas.dbeCodCta.Enabled := True;
                  fraCentroCusto.dbeCodEve.Enabled := True;
                End;
              End;
            End;

            If fEmptyStr(strAutoIncrem) And fBuscaPorCamposChave And
               (Not btnAlterar.Visible) Then
            Begin
              fMensagem('ATENÇÃO!', 'Duplicata já cadastrada!', ['&O k']);
              btnCancela.Click;
              Result := FALSE;
              Exit;
            End;

            If Not (qryTabela.State In [dsInsert,dsEdit]) Then
              Exit;

            {*****************************************************}
            {* POPULA INFORMAÇÕES PADRÕES NAS VARIÁVEIS          *}
            {**************************************************FS*}
            fltValDupOld := qryTabela.FieldByName('CTP_VALDUP').AsFloat;
            strDtaCadOld := qryTabela.FieldByName('CTP_DTACAD').AsString;
            strDtaVenOld := qryTabela.FieldByName('CTP_DTAVEN').AsString;
            strCodPorOld := qryTabela.FieldByName('CTP_CODPOR').AsString;

            {*****************************************************}
            {* SÓ PODE ALTERAR O VALDUP SE TEM DIREITO DE ACESSO *}
            {**************************************************JU*}
            If Not fVerificaAcessoSistema('CTPALTVLR') And (qryTabela.State In [dsEdit]) Then
              blnValEna := dbeValDup.Enabled
            Else
              blnValEna := fraPlanoDeContas.dbeCodCta.Enabled;

            fltValDup := 0.0;
            If (Not fEmptyStr(dbeValDup.Text)) Then
              fltValDup := fStrToFloat(dbeValDup.Text);

            qryTabela.FieldByName('CTP_SEQBAI').AsInteger := 0;

            {**************************************************}
            {* ALTEREI PQ NA ALTERAÇÃO QUANDO ENTRAVA POR     *}
            {* INCLUSAO, ELE JOGAVA DATA DO DIA E NÃO A       *}
            {* DE VENCIMENTO COM QUAL A DUPLICATA FOI GERADA. *}
            {***********************************************AC*}
            If (qryTabela.State = dsInsert) Then
            Begin
              If Not fEmptyStr(fTiraCaracEspeciais(strDtaCad)) Then
                dbeDtaCad.Text := strDtaCad;

              If Not fEmptyStr(fTiraCaracEspeciais(strDtaVen)) Then
                dbeDtaVen.Text := strDtaVen;
            End
            Else If (qryTabela.State = dsEdit) Then
            Begin
              If Not FEntradaDeMercadoriaQueNaoChegouNaEmpresa Then
                dbeDtaCad.Text := DateToStr(qryTabela.FieldByName('CTP_DTACAD').AsDateTime);

              dbeDtaVen.Text := DateToStr(qryTabela.FieldByName('CTP_DTAVEN').AsDateTime);
            End;

            dbeValDup.Text := FloatToStrF(fltValDup, ffFixed, 12, 2);
            dbeValorOutrasEntidades.Text := FloatToStrF(0.0, ffFixed, 12, 2);

            dbeVeiobo.Text := dbeVeiobo.Field.AsString;
            dbePrevis.Text := dbePrevis.Field.AsString;
            dbeDeposi.Text := dbeDeposi.Field.AsString;
            dbeUsaChq.Text := dbeUsaChq.Field.AsString;
            dbeUsaMca.Text := dbeUsaMca.Field.AsString;
            dbeVeioNF.Text := dbeVeioNF.Field.AsString;
            dbePagAnt.Text := dbePagAnt.Field.AsString;
            dbeUsoCon.Text := dbeUsoCon.Field.AsString;

            pCarregaDadosAdicionais;
            pHabilitaFields;
            pCalculaValorTotal;
            {*****************************************************}
            {* SÓ PODE ALTERAR O VALDUP SE TEM DIREITO DE ACESSO *}
            {**************************************************JU*}
            If (qryTabela.State = dsEdit) Then
            Begin
              If Not fVerificaAcessoSistema('CTPALTVLR') Then
              Begin
                dbeValDup.Enabled := False;

                If fEmptyStr(dbeValDup.Text) Then
                  dbeValDup.Field.Value := 0.00;

                fraPlanoDeContas.dbeCodCta.Enabled := True;
                dbeDesSuj.Enabled := False;
                dbeJurSuj.Enabled := False;
                dbeMulSuj.Enabled := False;
                dbeVendor.Enabled := False;

              End
              Else
              Begin
                dbeValDup.Enabled := blnValEna;
                fraPlanoDeContas.dbeCodCta.Enabled := blnValEna;
              End;
            End;


            If Assigned(FDatasetCtpDet) And (Not FDatasetCtpDet.IsEmpty) Then
              fMensagem('ATENÇÃO!', 'Será necessário digitar os dados de desmembramento de valores.', ['&Ok']);
            
          End;

          If blnAlterandoChave And fBuscaDuplicata Then
          Begin
            fMensagem('ATENÇÃO!', 'Duplicata já cadastrada.', ['&Ok']);
            Result := False;
          End;

          If Result And (qryTabela.State = dsInsert) Then
          Begin
            If (dbeCodFor.Text <> strCodFor) or (fEmptyStr(fraPlanoDeContas.dbeCodCta.Text)) Then
            Begin
              If (fraPlanoDeContas.dbeCodCta.Enabled) Then
                pPreencheCentroCusto;
              strCodFor := dbeCodFor.Text;
              pCarregaDadosBancariosFornecedor(strCodFor);
              qryTabela.FieldByName('CTP_BCOFOR').Value := Null;
            End;
          End;

        End;

      End

      {*****************************************}
      {* VALIDA A DATA DO CADASTRO             *}
      {**************************************MV*}
      Else If ((Sender = dbeDtaCad) And dbeDtaCad.Enabled) And Not FEntradaDeMercadoriaQueNaoChegouNaEmpresa Then
      Begin
        if (dteDataLanLoc  <> 0) and (dteDataLanLoc  <> StrToDate(dbeDtaCad.Text)) then
          qryTabela.FieldByName('CTP_DTACAD').AsDateTime := dteDataLanLoc;

        If not fValidaDataStr(dbeDtaCad.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Cadastro não é válida!', ['&O k']);
          Result := False;
        end

        Else If fEmptyStr(fTiraCaracEspeciais(dbeDtaCad.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Cadastro deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If (StrToDateDef(dbeDtaCad.Text, 0) <= 0) Then
        Begin
          fMensagem('', 'Data de Cadastro informada é inválida! Necessário correção.', ['&O k']);
          Result := False;
        End
        Else If (fCfgSis('CTPCAD', varBoolean)) And (qryTabela.State = dsEdit) And (StrToDateDef(strDtaCadOld, 0) <> StrToDateDef(dbeDtaCad.Text, 0)) And fEmptyStr(strSenhaDtaCadOld) Then
        Begin
          If (Not fEmptyStr(fCfgSis('CTPSDC'))) Then
          Begin
            If ffrmSenha(strSenha, 'Digite a Senha da Data Cadastro') Then
            Begin
              If strSenha <> fCfgSis('CTPSDC') Then
                Result := False
              Else
                strSenhaDtaCadOld := strSenha;
            End
            Else
              Result := False;
          End;
        End
        Else If  (not fCfgSis('CTPINF', varBoolean)) And (qryTabela.State = dsInsert) And (not fVerificaAcessoSistema('DTCADINF', strLoginUsuarioLogado)) And (StrToDate(dbeDtaCad.Text) <> VS_Date) And (StrToDateDef(strDtaCadOld, 0) <> StrToDateDef(dbeDtaCad.Text, 0)) Then
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Data de cadastro de duplicata inferior a data atual!');
          objLiberacao.objMsgLibera.pAddQuebra;
          objLiberacao.objMsgLibera.pAddTextoCaption('Data de cadastro', dbeDtaCad.Text);
          objLiberacao.objMsgLibera.pAddTextoCaption('Duplicata' , qryTabela.FieldByName('CTP_NUMDUP').AsString                          , 10);
          objLiberacao.objMsgLibera.pAddTextoCaption('Parcela'   , qryTabela.FieldByName('CTP_PARCEL').AsString                          , 10);
          objLiberacao.objMsgLibera.pAddTextoCaption('Série'     , qryTabela.FieldByName('CTP_SERIE_').AsString                          , 10);
          objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'   , qryTabela.FieldByName('CTP_CODEMP').AsString                          , 10);
          objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor', qryTabela.FieldByName('CTP_CODFOR').AsString + ' - ' + edtNomFor.Text , 10);

          objLiberacao.strDirAce := 'DTCADINF';
          objLiberacao.strSenLib := fCfgSis('SENFVU');
          objLiberacao.strMsgSen := 'Alterar Data de Cadastro';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;
          objLiberacao.strCodDig := strLoginUsuarioLogado;
          objLiberacao.tipCliFor := cfFornecedor;

          If (Not objLiberacao.fLibera) Then
          Begin
            fMensagem('ATENÇÃO!','Não é permitido alterar a data do cadastro!', ['&O K']);
            Result := False;
          End
          else
            strDtaCadOld := dbeDtaCad.Text;
        End
        Else
        Begin
          If (Not fEmptyStr(edtSeqBai.Text)) Then
          Begin
            If (StrToDate(dbeDtaCad.Text) > StrToDate(dbeDtaVen.Text)) Then
            Begin
              fMensagem('ATENÇÃO!', 'A Data de Cadastro deve ser menor ou igual a Data de Vencimento!', ['&O k']);
              Result := False;
            End;
          End;
        End;

        //FECHAMENTO FINANCEIRO
        //VERIFICA SE É INSERÇÃO OU UMA ALTERAÇÃO DE DATA DE CADASTRO
        if (qryTabela.State = dsInsert) then
          if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, StrToDate(dbeDtaCad.Text)) then
            Result := False;

        if ((qryTabela.State = dsEdit) And (ADataCadastroInicial <> StrToDate(dbeDtaCad.Text))) then
        begin
          if Not (Pos('G',dbeNumDup.Text) > 0) And objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, ADataCadastroInicial) then
            Result := False
          else
          if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, StrToDate(dbeDtaCad.Text)) then
            Result := False;
        end;
      End

      {*****************************************}
      {* VALIDA A DATA DO VENCIMENTO           *}
      {**************************************MV*}
      Else If (Sender = dbeDtaVen) And dbeDtaVen.Enabled Then
      Begin
        if (dteDataVenLoc  <> 0) and (dteDataVenLoc  <> StrToDate(dbeDtaVen.Text)) then
          qryTabela.FieldByName('CTP_DTAVEN').AsDateTime := dteDataVenLoc;

        If not fValidaDataStr(dbeDtaVen.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Vencimento não é válida!', ['&O k']);
          Result := False;
        end

        Else If fEmptyStr(fTiraCaracEspeciais(dbeDtaVen.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Vencimento deve ser preenchida!', ['&O k']);
          Result := False;
        End

        Else If (StrToDateDef(dbeDtaVen.Text, 0) <= 0) Then
        Begin
          fMensagem('', 'Data do Vencimento informada é inválida! Necessário correção.', ['&O k']);
          Result := False;
        End

        Else If ((dbeDtaCad.Enabled) And
                (fEmptyStr(fTiraCaracEspeciais(dbeDtaCad.Text)))) And Not FEntradaDeMercadoriaQueNaoChegouNaEmpresa Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Cadastro deve ser preenchida!', ['&O k']);
          Sender := dbeDtaCad;
          Result := False;
        End

        Else If ((Not fEmptyStr(dbeDtaCad.Field.AsString)) And
                (StrToDate(dbeDtaVen.Text) < StrToDate(dbeDtaCad.Text))) And Not FEntradaDeMercadoriaQueNaoChegouNaEmpresa Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Vencimento deve ser maior ou igual a Data de Cadastro!', ['&O k']);
          Result := False;
        End
        Else If (fCfgSis('CTPDTA', varBoolean)) And
                (qryTabela.State = dsEdit) And
                (StrToDateDef(strDtaVenOld, 0) <> StrToDate(dbeDtaVen.Text)) And
                (fEmptyStr(strSenhaDtaVenOld)) Then
        Begin
          If (Not fEmptyStr(fCfgSis('CTPSDV'))) Then
          Begin
            If ffrmSenha(strSenha, 'Digite a Senha da Data Vencimento') Then
            Begin
              If strSenha <> fCfgSis('CTPSDV') Then
                Result := False
              Else
                strSenhaDtaVenOld := strSenha;
            End
            Else
              Result := False;
          End;
        End;

      End

      {*****************************************}
      {* VALIDA O VALOR DA DUPLICATA           *}
      {**************************************MV*}
      Else If (Sender = dbeValDup) And (fEmptyStr(edtTipBai.Text)) Then
      Begin
        If fEmptyStr(fTiraCaracEspeciais(dbeValDup.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor do Documento deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If fStrToFloat(dbeValDup.Text) = 0.0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor do Documento deve ser diferente de Zero!', ['&O k']);
          Result := False;
        End
        Else If fStrToFloat(dbeValDup.Text) > MAX_VALMON Then
        Begin
          fMensagem('ATENÇÃO!',  Format('O valor do documento excede o máximo permitido: %s.', [FormatFloat('#,##0.00', MAX_VALMON)]), ['&O k']);
          Result := False;
          pSetFocus(dbeValDup);
          Exit;
        End;

        //FECHAMENTO FINANCEIRO
        //SE O VALOR DA DUPLICATA FOR ALTERADO VERIFICA FECHAMENTO
        if ((qryTabela.State = dsEdit)                    And
            (fltValDupOld <> fStrToFloat(dbeValDup.Text))) And
            (Not FEntradaDeMercadoriaQueNaoChegouNaEmpresa) Then
        begin
          if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, StrToDate(dbeDtaCad.Text)) then
            Result := False;
        end;

        If Result And fVerificaAcessoSistema('CTPALTVLR') Or (qryTabela.State In [dsInsert]) Then
        Begin
          if (fltValLanLoc <> 0) and (fltValLanLoc <> fStrToFloat(dbeValDup.Text)) then
            qryTabela.FieldByName('CTP_VALDUP').AsFloat := fltValLanLoc;

          fltValDup := fStrToFloat(dbeValDup.Text);
          If fltValDup > MAX_VALMON Then
          Begin
            fltValDupAnt   := MAX_VALMON;
            dbeValDup.Text := FloatToStr(fltValDupAnt);
          End;

          fltValOriAnt := fltValOriAnt + (fStrToFloat(dbeValDup.Text) - fltValDupAnt);
          fltValDupAnt := fStrToFloat(dbeValDup.Text);
          qryTabela.FieldByName('CTP_VALORI').AsFloat := fltValOriAnt;

          Exit;
        End
        Else
        Begin

          fltValDup := 0.00;

          If fEmptyStr(dbeValDup.Text) Then
            dbeValDup.Field.Value := 0.00;

          If fltValDup > MAX_VALMON Then
          Begin
            fltValDupAnt   := MAX_VALMON;
            dbeValDup.Text := FloatToStr(fltValDupAnt);
          End;

          fltValOriAnt := fltValOriAnt + (fStrToFloat(dbeValDup.Text) - fltValDupAnt);
          fltValDupAnt := fStrToFloat(dbeValDup.Text);
          qryTabela.FieldByName('CTP_VALORI').AsFloat := fltValOriAnt;
          if (fltValLanLoc <> 0) and (fltValLanLoc <> fStrToFloat(dbeValDup.Text)) then
            qryTabela.FieldByName('CTP_VALDUP').AsFloat := fltValLanLoc;
        End;

        if Result then
        begin
          If (fCfgSis('CTPVAL', varBoolean)) And (qryTabela.State = dsEdit) And (fltValDupOld <> fStrToFloat(dbeValDup.Text)) And fEmptyStr(strSenhaValDupOld) Then
          Begin
            If (Not fEmptyStr(fCfgSis('CTPSVD'))) Then
            Begin
              If ffrmSenha(strSenha, 'Digite a Senha do Valor Duplicata') Then
              Begin
                If strSenha <> fCfgSis('CTPSVD') Then
                  Result := False
                Else
                  strSenhaValDupOld := strSenha;
              End
              Else
                Result := False;
            End;
          End;
          if Result then
            fltValDupOld := fStrToFloat(dbeValDup.Text);
        end;

      End

      {*****************************************}
      {* VALIDA O CAMPO "VEIO BOLETO?" E       *}
      {* "PREVISÃO?"                           *}
      {**************************************MV*}
      {*****************************************}
      {* VALIDA O CAMPO "DEPOSITO"             *}
      {*                                       *}
      {**************************************AA*}
      {************************************}
      {* VALIDA SE UTILIZA CHEQUE SIM/NAO *}
      {*********************************LB*}
      Else If ((Sender = dbeVeiobo) And dbeVeiobo.Enabled) Or
              ((Sender = dbeVeioNF) And dbeVeioNF.Enabled) Or
              ((Sender = dbeDeposi) And dbeDeposi.Enabled) Or
              ((Sender = dbeUsaChq) And dbeUsaChq.Enabled) Or
              ((Sender = dbeUsaMca) And dbeUsaMca.Enabled) Or
              ((Sender = dbePrevis) And dbePrevis.Enabled) Or
              ((Sender = dbePagAnt) And dbePagAnt.Enabled) Or
              ((Sender = dbeUsoCon) And dbeUsoCon.Enabled) Then
      Begin
        Result := fValidaChqBolDep(Sender);
      End

      {*****************************************}
      {* VALIDA O CÓDIGO DO EVENTO             *}
      {**************************************LB*}
      Else If (Sender = fraCentroCusto.dbeCodEve) And fraCentroCusto.dbeCodEve.Enabled Then
      Begin

        if (fCfgSis('METPED', varString) = '5') Or
           (fCfgSis('METPED', varString) = '6') Then
        Begin

          If Not(fEmptyStr(fraCentroCusto.dbeCodEve.Text)) Then
            pCarregaEventos;

            If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
            Begin
              fMensagem('ATENÇÃO!', 'Campo: Centro de Custo, deve ser preenchido!', ['&O k']);
              Result := False;
              Exit;
            End;

        End;

        If Not fEmptyStr(fraCentroCusto.dbeCodEve.Text) Then
        Begin
          pCarregaEventos;
          If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If (fRetTipoEvento(fraCentroCusto.dbeCodEve.Text)='R') Then
          Begin
            fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a receber!',['&OK']);
            Result := False;
          End;
        End
        Else
        Begin
          If fCfgSis('CTPOBE', varBoolean) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Centro de Custos deve ser preenchido!', ['&O k']);
            Result := False;
          End;

          qryTabela.FieldByName('CTP_CODEVE').AsVariant := Null;
          fraCentroCusto.edtDesEve.Clear;
        End;
      End

      {*****************************************}
      {* VALIDA O CÓDIGO DO PORTADOR           *}
      {**************************************JB*}
      Else If (Sender = dbeCodPor) Then
      Begin
        If Not fEmptyStr(dbeCodPor.Text) Then
        Begin
          if (strCodPorLoc <> '') and (strCodPorLoc  <> dbeCodPor.Text) then
            qryTabela.FieldByName('CTP_CODPOR').AsString := strCodPorLoc;

          pCarregaPortador;
          If qryConPor.FieldByName('POR_CODPOR').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Portador não está cadastrado!', ['&O k']);
            Result := False;
          End

          {*REQ*145940**********RP*}
          Else If Not fEmpresaTemAcessoPortador(dbeCodPor.Text, dbeCodEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End

          Else If Not FValidaCorrespondenteContabil.PortadorPossuiCorrespondenteContabil(dbeCodPor.Text,dbeCodEmp.Text) Then
          Begin
            Result := False;
          End;

          If Result Then
          Begin
            If fCfgSis('DACPOR', varBoolean) Then
            Begin
              If Pos(dbeCodPor.Text, strPortadoresOperador) <= 0 Then
              Begin
                fMensagem('ATENÇÃO!', 'Você não possui permissão para utilizar este portador!', ['&O k']);
                Result := False;
              End;
            End;
          End;

          If (fCfgSis('CTPPOR', varBoolean)) And (qryTabela.State = dsEdit) And (strCodPorOld <> dbeCodPor.Text) And fEmptyStr(strSenhaCodPorOld) And (not fEmptyStr(strCodPorOld)) Then
          Begin
            If (Not fEmptyStr(fCfgSis('CTPSPO'))) Then
            Begin
              If ffrmSenha(strSenha, 'Digite a Senha do Portador da Duplicata') Then
              Begin
                If strSenha <> fCfgSis('CTPSPO') Then
                  Result := False
                Else
                  strSenhaCodPorOld := strSenha;
              End
              Else
                Result := False;
            End;
          End;

        End
        Else
        Begin
          If fCfgSis('CTPOBP', varBoolean) Then
          Begin
            fMensagem('ATENÇÃO!', 'O portador deve ser preenchido!', ['&O k']);
            Result := False;
          End;

          qryTabela.FieldByName('CTP_CODPOR').AsVariant := Null;
          edtNomPor.Clear;
        End;
      End

      {*****************************************}
      {* VALIDA VALIDA O CENTRO DE CUSTO       *}
      {**************************************MV*}
      Else If (Sender = fraPlanoDeContas.dbeCodCta) And fraPlanoDeContas.dbeCodCta.Enabled Then
      Begin

        If fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If (Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.dbeCodCta.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!', ['&O k']);
          Result := False;
        End
        {************************************************}
        {* NÃO DEIXA INFORMAR CENTRO DE CUSTO DE RATEIO *}
        {*********************************************RV*}
        Else If (fraPlanoDeContas.dbeCodCta.Text = fCfgSis('CTAPRI')) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Plano de Contas de Rateio não é permitido!', ['&O k']);
          Result := False;
        End
        Else If Not FValidaCorrespondenteContabil.PlanoDeContasPossuiCorrespondenteContabil(fraPlanoDeContas.dbeCodCta.Text,dbeCodEmp.Text) Then
        Begin
          Result := False;
        End
        Else
        Begin
          pCarregaCentroCusto;
          If Result And (qryTabela.State = dsInsert) And Not qryConCta.FieldByName('CTA_CODCTA').IsNull Then
          Begin
            If Not PlanoDeContasAtivo(fraPlanoDeContas.dbeCodCta.Text) Then
              Result := False;
          End
          Else  If Result And (qryTabela.State = dsEdit) Then
          Begin
            If Result And (qryTabela.FieldByName('CTP_CODCTA').OldValue <> fraPlanoDeContas.dbeCodCta.Text) Then
            Begin
              If Not PlanoDeContasAtivo(fraPlanoDeContas.dbeCodCta.Text) Then
                Result := False
              Else If Not fPodeAlterarPlanoContaDuplicataContabilizada Then
                Result := False;
            End;
          End;

          If Result And qryConCta.FieldByName('CTA_CODCTA').IsNull Then
          Begin
            If Not fCfgSis('USACTF', varBoolean) Then
              fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k'])
            Else
              fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado ou não está vinculado ao fornecedor!', ['&O k']);

            Result := False;
          End;

          If (Result) And (strCtaAnt <> fraPlanoDeContas.dbeCodCta.Text) Then
          Begin
            if qryTabela.FieldByName('CTP_DTAPAG').IsNull and
                 not fValidaCampos(dbeValDup) then
            begin
              pSetFocus(dbeValDup);
              Exit(False);
            end;

            If FDatasetCtpDetClone.IsEmpty Then
            Begin
              oParametros := TParametrosDesmembraValoresCtaDet.Create;
              try
                oParametros.strNumCta := fraPlanoDeContas.dbeCodCta.Text;
                oParametros.strCodEve := fraCentroCusto.dbeCodEve.Text;
                oParametros.frmCadPag := Self;

                oParametros.fltValDup := fstrToFloat(dbeValDup.Text);
                If Not qryTabela.FieldByName('CTP_DTAPAG').IsNull Then
                  oParametros.fltValDup := fFormataFloat(qryTabela.FieldByName('CTP_VALORI').AsFloat, 2);

                oParametros.strCodEmp := dbeCodEmp.Text;
                oParametros.blnDireto := False;

                if fDesmembraValoresCtaDet(oParametros) then
                Begin
                  If fEmptyStr(oParametros.strCodCta) And fEmptyStr(fCfgSis('CTAPRI')) Then
                  Begin
                    fMensagem('ATENÇÃO!', 'Para ativar o rateio deste Plano de Contas, a configuração "Plano de Contas principal para rateio de duplicatas" deve estar preenchida nas configurações do sistema!', ['&O k']);
                    Exit(False);
                  End;

                  fraPlanoDeContas.dbeCodCta.Enabled := False;

                  If fEmptyStr(oParametros.strCodCta) Then
                    fraPlanoDeContas.dbeCodCta.Field.AsString := fCfgSis('CTAPRI')
                  Else
                    fraPlanoDeContas.dbeCodCta.Field.AsString := oParametros.strCodCta;

                  FDatasetCtpDet.Data := oParametros.cdsTemp.Data;

                  fraCentroCusto.dbeCodEve.Field.Value := fCfgSis('EVEPRI');
                  pCarregaEventos;
                  pCarregaCentroCusto;
                  pSetFocus(Self);
                  If fraCentroCusto.dbeCodEve.CanFocus Then
                    pSetFocus(fraCentroCusto.dbeCodEve)
                  Else
                    pSetFocus(dbeCodPor);
                End
                Else
                  strCtaAnt := fraPlanoDeContas.dbeCodCta.Text;
              finally
                oParametros.Free;
              end;
            End;
          End;

          If Result then
          Begin
            blnPedeSenha := Not (fEmptyStr(strCtaFor) And fEmptyStr(strCtaAut));
            If Not fEmptyStr(strCtaFor) Then
              blnPedeSenha := blnPedeSenha And (strCtaFor <> fraPlanoDeContas.dbeCodCta.Text);
            If Not fEmptyStr(strCtaAut) Then
              blnPedeSenha := blnPedeSenha And (strCtaAut <> fraPlanoDeContas.dbeCodCta.Text);

            If blnPedeSenha And (Not fCfgSis('USACTF', varBoolean)) Then
            Begin
              objLiberacao.Clear;
              objLiberacao.objMsgLibera.pAddTexto('ALTERAR PLANO DE CONTAS');
              objLiberacao.objMsgLibera.pAddQuebra;
              objLiberacao.objMsgLibera.pAddTextoCaption('Plano de contas anterior'         , strCtaAut + '-' + fRetNomeConta(strCtaAut));
              objLiberacao.objMsgLibera.pAddTextoCaption('Documento'                        , IfThen(fEmptyStr(dbeNumDup.Text)
                                                                                                     , ''
                                                                                                     ,dbeNumDup.Text + '-' +
                                                                                                      dbeParcel.Text +
                                                                                                      IfThen(fEmptyStr(dbeSerie.Text)
                                                                                                             , ''
                                                                                                             , '-' + dbeSerie.Text) +
                                                                                                      IfThen(fEmptyStr(dbeCodEmp.Text)
                                                                                                             , ''
                                                                                                             , '-' + dbeCodEmp.Text)
                                                                                                    ));
              objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor'                       , dbeCodFor.Text + '-' + edtNomFor.Text);
              objLiberacao.objMsgLibera.pAddTextoCaption('Data de cadastro'                 , dbeDtaCad.Text);
              objLiberacao.objMsgLibera.pAddTextoCaption('Data de vencimento'               , dbeDtaVen.Text);
              objLiberacao.objMsgLibera.pAddTextoCaption('Valor'                            , dbeValDup.Text);
              objLiberacao.objMsgLibera.pAddTextoCaption('Alterando para o plano de contas' , fraPlanoDeContas.dbeCodCta.Text + '-' + fraPlanoDeContas.edtDesCta.Text);

              objLiberacao.strDirAce := 'CTPALTCTA';
              objLiberacao.strSenFvu := 'V';
              objLiberacao.strMsgSen := 'Senha para alteração do plano de contas da conta a pagar';
              objLiberacao.strCodOpe := strLoginUsuarioLogado;


              If objLiberacao.fLibera Then
              Begin
                strCtaAut := fraPlanoDeContas.dbeCodCta.Text;
              End
              Else
              Begin
                fraPlanoDeContas.dbeCodCta.Text := strCtaAut;
                pCarregaCentroCusto;
                Result := False;
              End;
            End;
          End;
        End;
      End

      Else If (Sender = dbeCtaBai) And dbeCtaBai.Enabled Then
      Begin
        If (fVerificaAcessoSistema('CTPALTCTABAI'))                            And
           (fCfgSis('CTP_AS', varString) = 'A')                                And
           (fCfgSis('PRBAMB', varInteger) = 2)                                 And
           (qryTabela.FieldByName('CTP_CTABAI').AsString <> fCfgSis('CTAPRI')) And
           (fDuplicataCtpBaixada(dbeNumDup.Text,
                                 dbeParcel.Text,
                                 dbeCodEmp.Text,
                                 dbeCodFor.Text,
                                 dbeSerie.Text,
                                 qryTabela.FieldByName('CTP_SEQBAI').AsInteger)) Then
        Begin
          If fEmptyStr(dbeCtaBai.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Centro de Custo deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else If (Not fValidaLinhaGrupoCadCta(dbeCtaBai.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!', ['&O k']);
            Result := False;
          End
          {************************************************}
          {* NÃO DEIXA INFORMAR CENTRO DE CUSTO DE RATEIO *}
          {*********************************************RV*}
          Else If (dbeCtaBai.Text = fCfgSis('CTAPRI')) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Centro de Custo de Rateio não é permitido!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            pCarregaCentroCustoBaixa;
            If qryCtaBai.FieldByName('CTA_CODCTA').IsNull Then
            Begin
              If Not fCfgSis('USACTF', varBoolean) Then
                fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado!', ['&O k'])
              Else
                fMensagem('ATENÇÃO!', 'Esse Centro de Custo não está cadastrado ou não está vinculado ao fornecedor!', ['&O k']);

              Result := False;
            End;

          End;
        End;
      End

      {***********************************************}
      {* VERIFICAR SE IRÁ MESMO FAZER ESSA VALIDAÇÃO *}
      {***********************************************}
      {* VALIDA O CÓDIGO DE BARRAS COM 44 CARACTERES *}
      {********************************************JU*}
      Else If (Sender = dbeCodBar) Then
      Begin
        If Not fEmptyStr(dbeCodBar.Text) Then
        Begin
          if lblTipoPagamento.Caption <> '' then
          begin
            lblTipoPagamento.Caption := '';
            qryTabela.FieldByName('CTP_TIPPAG').AsString := '';
            qryTabela.FieldByName('CTP_LINDIG').AsString := '';
          end;

          if Copy(dbeCodBar.Text, 1, 1) <> '8' then
          begin
            If Length(dbeCodBar.Text) <> 44 Then
            Begin
              fMensagem('ATENÇÃO!', 'Leitura incorreta, o código de barras deve ter 44 dígitos!' + #13#10 +
                                    'Caso o erro persista, desmaque a opção Leitor de código de barras e seleciona a opção Informar linha digitável manualmente!', ['&O k']);
              Result := False;
            End;


            If Result And Not ValidaValorBoleto(dbeCodBar) Then Result := False
            Else If Result And Not ValidaDataVencimentoBoleto(dbeCodBar) Then Result := False;

          end
          else
          begin
            if fValidaCodigoBarrasCobranca(dbeCodBar.Text) then
            begin
              intCodPag :=  StrToInt(Copy(fRetSomenteNumeros(dbeCodBar.Text), 2, 1));
              case intCodPag of
                 1: lblTipoPagamento.Caption := 'Tipo de Pagamento: 1 - Prefeituras(IPTU)';
                 2: lblTipoPagamento.Caption := 'Tipo de Pagamento: 2 - Saneamento';
                 3: lblTipoPagamento.Caption := 'Tipo de Pagamento: 3 - Energia Elétrica e Gás';
                 4: lblTipoPagamento.Caption := 'Tipo de Pagamento: 4 - Telecomunicações';
                 5: lblTipoPagamento.Caption := 'Tipo de Pagamento: 5 - Tributos';
              end;
              If (intCodPag=5) Then
                qryTabela.FieldByName('CTP_LINDIG').AsString := fRetornaReprNumericaCobrancaMod11(dbeCodBar.Text)
              Else
                qryTabela.FieldByName('CTP_LINDIG').AsString := fRetornaReprNumericaCobranca(dbeCodBar.Text);
              qryTabela.FieldByName('CTP_TIPPAG').AsString := intToStr(intCodPag);

              If fEmptyStr(dbeTipDoc.Text) then
                qryTabela.FieldByName('CTP_TIPDOC').AsString := IIF(intCodPag=5,'2','3');
            end
          end;
        End
        else
        begin
          if lblTipoPagamento.Caption <> '' then
          begin
            lblTipoPagamento.Caption := '';
            qryTabela.FieldByName('CTP_TIPPAG').AsString := '';
            qryTabela.FieldByName('CTP_LINDIG').AsString := '';
          end;

          {**************************************}
          {* VERIFICA SE E OBRIGATORIO INFORMAR *}
          {* O CODIGO DE BARRAS                 *}
          {***********************************FS*}
          If (dbeCodBar.Enabled) Then
          Begin
            If fCfgSis('CTPBOL', varBoolean) And (dbeVeiobo.Text = 'S') Then
            begin
              fMensagem('ATENÇÃO!', 'O código de barras deve ser preenchido!', ['&O k']);
              Result := False;
            End;
          End;
        end;
      End
      {***********************************************}
      {* VALIDA O LINHA DIGITÁVEL COM 47 CARACTERES  *}
      {********************************************JU*}
      Else If (Sender = dbeLinDig) Then
      Begin
        If Not fEmptyStr(dbeLindig.Text) Then
        Begin
          if lblTipoPagamento.Caption <> '' then
          begin
            lblTipoPagamento.Caption := '';
          end;

          if Copy(dbeLinDig.Text, 1, 1) <> '8' then
          begin
            If Length(dbeLinDig.Text) <> 47 Then
            Begin
              fMensagem('ATENÇÃO!', 'Valor informado incorretamente, a linha digitável deve ter 47 dígitos!', ['&O k']);
              Result := False;
            End
            Else
            if not fValidaLinhaDigitavel(dbeLinDig.Text) Then
            Begin
              fMensagem('ATENÇÃO!', 'A linha digitável informada está incorreta!', ['&O k']);
              Result := False;
            End
            Else
              dbeCodBar.Text := fRetCodBarLinDig(dbeLinDig.Text);

            If Result And Not ValidaValorBoleto(dbeLinDig) Then Result := False
            Else If Result And Not ValidaDataVencimentoBoleto(dbeLinDig) Then Result := False;

          end
          else
          begin
            If Length(dbeLinDig.Text) <> 48 Then
            Begin
              fMensagem('ATENÇÃO!', 'Valor informado incorretamente, a linha digitável deve ter 48 dígitos!', ['&O k']);
              Result := False;
            End
            else
            begin
              if fValidaRepresentacaoNumericaCobranca(dbeLinDig.Text) then
              begin
                intCodPag :=  StrToInt(Copy(fRetSomenteNumeros(dbeLinDig.Text), 2, 1));
                case intCodPag of
                   1: lblTipoPagamento.Caption := 'Tipo de Pagamento: 1 - Prefeituras(IPTU)';
                   2: lblTipoPagamento.Caption := 'Tipo de Pagamento: 2 - Saneamento';
                   3: lblTipoPagamento.Caption := 'Tipo de Pagamento: 3 - Energia Elétrica e Gás';
                   4: lblTipoPagamento.Caption := 'Tipo de Pagamento: 4 - Telecomunicações';
                   5: lblTipoPagamento.Caption := 'Tipo de Pagamento: 5 - Tributos';
                end;
                qryTabela.FieldByName('CTP_CODBAR').AsString := fRetornaCodigoBarrasCobranca(dbeLinDig.Text);
                qryTabela.FieldByName('CTP_TIPPAG').AsString := intToStr(intCodPag);

                If fEmptyStr(dbeTipDoc.Text) then
                  qryTabela.FieldByName('CTP_TIPDOC').AsString := IIF(intCodPag=5,'2','3');
              end
              Else
              Begin
                //Se Não for Concessionárias, será Tributos
                intCodPag := StrToInt(Copy(fRetSomenteNumeros(dbeLinDig.Text), 2, 1));
                case intCodPag of
                   5: lblTipoPagamento.Caption := 'Tipo de Pagamento: 5 - Tributos';
                end;
                qryTabela.FieldByName('CTP_CODBAR').AsString := fRetornaCodigoBarrasCobranca(dbeLinDig.Text);
                qryTabela.FieldByName('CTP_TIPPAG').AsString := intToStr(intCodPag);

                If fEmptyStr(dbeTipDoc.Text) then
                  qryTabela.FieldByName('CTP_TIPDOC').AsString := '2';
              End;
            end;
          end;
        End
        else
        begin
          if ((lblTipoPagamento.Caption <> '') and (dbeCodBar.Text = '')) then
          begin
            lblTipoPagamento.Caption := '';
            qryTabela.FieldByName('CTP_TIPPAG').AsString := '';
            qryTabela.FieldByName('CTP_LINDIG').AsString := '';
          end;

          {**************************************}
          {* VERIFICA SE E OBRIGATORIO INFORMAR *}
          {* A LINHA DIGITAVEL                  *}
          {***********************************FS*}
          If (dbeLinDig.Enabled) Then
          Begin
            If fCfgSis('CTPBOL', varBoolean) And (dbeVeiobo.Text = 'S') Then
            begin
              fMensagem('ATENÇÃO!', 'A linha digitável deve ser preenchida!', ['&O k']);
              Result := False;
            End;
          End;
        end;
      End

      {*****************************************}
      {* VALIDA O VALOR DE DESCONTO            *}
      {**************************************AJ*}
      Else If (Sender = dbeDesSuj) Then
      Begin
        dbeQtdDia.Enabled := ((Not fEmptyStr(dbeDesSuj.Text)) And (fStrToFloat(dbeDesSuj.Text) > 0)) And (qryTabela.State in [dsInsert, dsEdit]);
        If (not dbeCompet.Enabled) And (not dbeDtaCad.Enabled) Then
          pSetFocus(dbeQtdDia);
        If (Not dbeQtdDia.Enabled) And (qryTabela.State in [dsInsert, dsEdit]) Then
          dbeQtdDia.Field.AsInteger := 0;

        //FECHAMENTO FINANCEIRO
        //SE O VALOR DE DESCONTO SUGERIDO FOR ALTERADO VERIFICA FECHAMENTO
        if ((qryTabela.State = dsEdit)                    And
            (fltDesSujOld <> fStrToFloat(dbeDesSuj.Text))) And
            (Not FEntradaDeMercadoriaQueNaoChegouNaEmpresa) Then
        begin
          if not fPodeAlterarValoresAposFechamentoFinanceiro(Sender) then
            Result := False;
        end;

        if Result then
          fltDesSujOld := fStrToFloat(dbeDesSuj.Text);
      End

      {*****************************************}
      {* VALIDA A QTDE DIAS PARA DESCONTO      *}
      {**************************************AJ*}
      Else If (Sender = dbeQtdDia) Then
      Begin
        If (fEmptyStr(dbeQtdDia.Text)) And (qryTabela.State in [dsInsert, dsEdit]) Then
          dbeQtdDia.Field.AsInteger := 0;

        If dbeQtdDia.Field.AsInteger < 0 Then
        Begin
          fMensagem('ATENÇÃO!', 'A quantidade de dias para desconto não pode ser menor que 0. Verifique!', ['&O k']);
          Result := False;
        End;
      End

      {****************************************************}
      {* VALIDA O CÓDIGO DE RECEITA SE FOR TRIBUTO E      *}
      {* QUANDO O CAMPO GUIA ESTIVER VISÍVEL E HABILITADO *}
      {*************************************************CH*}
      Else If (Sender = LcbTipoTributo) and
              (LcbGuiatributo.Visible And LcbGuiatributo.Enabled) Then
      Begin
        If ((VarToString(LcbGuiatributo.KeyValue) <> '') And
            (fVerificaExistemDeTributosParaGuia(LcbGuiatributo.KeyValue)) And
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
          lblValorOutrasEntidades.Enabled := True;
          dbeValorOutrasEntidades.Enabled := True;
        end
        else
        begin
          If (qryTabela.State in [dsInsert, dsEdit]) And
             (qryTabela.FieldByName('CTP_DTAPAG').IsNull) Then
          Begin
            dbeValorOutrasEntidades.Text := '0,00';
            qryTabela.FieldByName('CTP_OUTENT').AsFloat := 0.00;
            pCalculaValorTotal;
          End;

          lblValorOutrasEntidades.Enabled := False;
          dbeValorOutrasEntidades.Enabled := False;
        end;
      End

      {**************************************}
      {* VALIDA O VALOR DE OUTRAS ENTIDADES *}
      {***********************************MO*}
      Else If (Sender = dbeValorOutrasEntidades) then
      begin
        If (dbeValorOutrasEntidades.Enabled) And
           (fEmptyStr(fTiraCaracEspeciais(dbeValorOutrasEntidades.Text))) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor de Outras Entidades deve ser preenchido!', ['&O k']);
          Result := False;
        End;

        //FECHAMENTO FINANCEIRO
        //SE O VALOR DE OUTRAS ENTIDADES FOR ALTERADO VERIFICA FECHAMENTO
        if ((qryTabela.State = dsEdit)                                               And
            (fltValOutrasEntidadesOld <> fStrToFloat(dbeValorOutrasEntidades.Text))) And
            (Not FEntradaDeMercadoriaQueNaoChegouNaEmpresa)                           Then
        begin
          if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, StrToDate(dbeDtaCad.Text)) then
            Result := False;
        end;

        if Result then
          fltValOutrasEntidadesOld := fStrToFloat(dbeValorOutrasEntidades.Text);
      end

      {***************************}
      {* VALIDA O VALOR DA MULTA *}
      {************************MT*}
      Else If (Sender = dbeMulSuj) then
      begin
        If Not fEmptyStr(fTiraCaracEspeciais(dbeMulSuj.Text)) Then
        Begin
          If (fStrToFloat(dbeMulSuj.Text) < 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'O valor da Multa deve ser maior ou igual a zero!', ['&O k']);
            Result := False;
          End;
        End;
        //FECHAMENTO FINANCEIRO
        //SE O VALOR DE MULTA SUGERIDA FOR ALTERADO VERIFICA FECHAMENTO
        if Result And (((qryTabela.State = dsEdit)   And
           (fltMulSujOld <> fStrToFloat(dbeMulSuj.Text))) And
           (Not FEntradaDeMercadoriaQueNaoChegouNaEmpresa)) Then
        begin
          if not fPodeAlterarValoresAposFechamentoFinanceiro(Sender) then
            Result := False;
        end;

        if Result then
          fltMulSujOld := fStrToFloat(dbeMulSuj.Text);
      end

      {***************************}
      {* VALIDA O VALOR DE JUROS *}
      {***************************}
      Else If (Sender = dbeJurSuj) then
      begin
        If Not fEmptyStr(fTiraCaracEspeciais(dbeJurSuj.Text)) Then
        Begin
          If (fStrToFloat(dbeJurSuj.Text) < 0) Then
          Begin
            fMensagem('ATENÇÃO!', 'O valor da Juros deve ser maior ou igual a zero!', ['&O k']);
            Result := False;
          End;
        End;
        //FECHAMENTO FINANCEIRO
        //SE O VALOR DE JUROS SUGERIDO FOR ALTERADO VERIFICA FECHAMENTO
        if Result And (((qryTabela.State = dsEdit)   And
           (fltJurSujOld <> fStrToFloat(dbeJurSuj.Text))) And
           (Not FEntradaDeMercadoriaQueNaoChegouNaEmpresa)) Then
        begin
          if not fPodeAlterarValoresAposFechamentoFinanceiro(Sender) then
            Result := False;
        end;

        if Result then
          fltJurSujOld := fStrToFloat(dbeJurSuj.Text);
      end

      Else If (Sender = dbeCodPrj) And dbeCodPrj.Visible  Then
      Begin
        If Not fEmptyStr(dbeCodPrj.Text) Then
        Begin
          edtDesPrj.Text := fCampoTabela('PRJ_DESPRJ', 'CADPRJ', ['PRJ_CODPRJ'], [dbeCodPrj.Text], False);

          If fEmptyStr(edtDesPrj.Text) Then
          Begin
            fMensagem('', 'Projeto não encontrado !', ['&Ok']);
            Result := False;
            edtDesPrj.Clear;
          End
          Else
          If fCampoTabela('PRJ_SITUAC', 'CADPRJ', ['PRJ_CODPRJ'], [dbeCodPrj.Text], False) = 'I' Then
          Begin
            fMensagem('ATENÇÃO!', 'O projeto informado foi Inativado. Verifique!', ['&Ok']);
            Result :=False;
          End;
        End
        Else
          edtDesPrj.Clear;
      End

      Else If (Sender = dbeDtaEnv) And (pnlEnvBan.Visible) Then
      Begin

        If Not blnBuscaPorChave Then
        Begin
          If fEmptyDate(dbeDtaEnv.Text) And (Not fEmptyStr(dbeBcoBol.Text)) Then
          Begin
            fMensagem('ATENÇÃO!', 'A data de envio deve ser preenchida!', ['&O k']);
            Result := False;
          End;

        End;

      End

      Else If (Sender = dbeBcoBol) And (pnlEnvBan.Visible) Then
      Begin

        If fEmptyStr(dbeBcoBol.Text) Then
        Begin
          If Not fEmptyDate(dbeDtaEnv.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Código do Banco deve ser preenchido!', ['&O k']);
            Result := False;
          End
          Else edtNomBan.Clear;
        End
        Else
        Begin
          pCarregaBanco;
          If qryCadBco.FieldByName('BCO_CODBCO').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Banco não está cadastrado!', ['&Ok']);
            edtNomBan.Clear;
            Result := False;
          End;
        End;

      End

      {************************************}
      {* VALIDA ALTERAÇÃO DO CAMPO VENDOR *}
      {* COM FECHAMENTO FINANCEIRO ********}
      {*****************************331143*}
      Else If (Sender = dbeVendor) then
      begin
        if fltValVendorOld = fStrToFloat(dbeVendor.Text) then
          Exit;

        if not fPodeAlterarVendor then
        begin
          Result := False;
        end;

        if Result then
          fltValVendorOld := fStrToFloat(dbeVendor.Text);
      end;

    except
      on E: Exception Do
      begin
        Result := False;
        fMensagemTratada(E);
      end;
    end;
  End;

  TravaAlteracaoDeCamposPrincipaisDaNotaDeEntrada;

  If (Not Result) Then
    pSetFocus(Sender);
end;

procedure TfrmCadCtaPagar.pCalculaValorTotal;
begin
  edtValTot.Visible := False;
  lblValTot.Visible := False;

  If (qryTabela.Active) And
     (fEmptyStr(qryTabela.FieldByName('CTP_DTAPAG').AsString)) And
     ((qryTabela.RecordCount >= 1) Or (qryTabela.State = dsInsert)) Then
  Begin
    edtValTot.Visible := True;
    lblValTot.Visible := True;

    {***********************************************}
    {* CASO A LÓGICA DO VALOR TOTAL SEJA ALTERADA, *}
    {* ALTERAR TAMBÉM NA PESQUISA! (fPesqCtaPagar) *}
    {*REQ*145965*********************************RP*}
    edtValTot.Text := FloatToStrF(qryTabela.FieldByName('CTP_VALDUP').AsFloat +
                                  qryTabela.FieldByName('CTP_JURSUJ').AsFloat +
                                  qryTabela.FieldByName('CTP_MULSUJ').AsFloat -
                                  qryTabela.FieldByName('CTP_DESSUJ').AsFloat +
                                  qryTabela.FieldByName('CTP_VENDOR').AsFloat +
                                  qryTabela.FieldByName('CTP_OUTENT').AsFloat, ffNumber, 12, 2);
  End;
end;

procedure TfrmCadCtaPagar.pCarregaCentroCusto;
begin

  If Not fCfgSis('USACTF', varBoolean) Then
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.dbeCodCta.Text)
  Else
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.dbeCodCta.Text, True, dbeCodFor.Field.AsString);

  With qryConCta Do
  Begin
    if not fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) then
    begin
      fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;

      If FieldByName('CTA_PROCON').AsInteger = 1 Then
         edtProvisao.Text := 'S'
      Else
         edtProvisao.Text := 'N';

    end
    else
    begin
      fraPlanoDeContas.edtDesCta.Text := '';
      edtProvisao.Text := '';
    End;
  End;
end;

procedure TfrmCadCtaPagar.pCarregaCentroCustoBaixa;
begin
  If Not fCfgSis('USACTF', varBoolean) Then
    pPesquisaCadCta(qryCtaBai, qryCtaBai, dbeCtaBai.Text)
  Else
    pPesquisaCadCta(qryCtaBai, qryCtaBai, dbeCtaBai.Text, True, dbeCodFor.Field.AsString);

  With qryCtaBai Do
  Begin
    edtDesCtaBai.Text := FieldByName('CTA_DESCTA').AsString;

    if fEmptyStr(dbeCtaBai.Field.AsString) and (dtsTabela.State = dsInsert ) then
      dbeCtaBai.Field.AsString := FieldByName('CTA_CODCTA').AsString;
  End;
end;

procedure TfrmCadCtaPagar.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, dbeCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmCadCtaPagar.pCarregaFornecedor;
begin
  pPesquisaCadFor(qryConFor, qryConFor, dbeCodFor.Text);
  With qryConFor Do
  Begin
    edtNomFor.Text := FieldByName('FOR_NOMFOR').AsString;
  End;
end;

procedure TfrmCadCtaPagar.FormCreate(Sender: TObject);
begin
  inherited;
  qryConPor     := fCriaQuery(Self);
  qryConPrj     := fCriaQuery(Self);
  objLiberacao  := TLiberacao.Create;
  strNomeCampo  := 'CTP_NUMDUP';
  strNomeTabela := 'CADPAG';
  strAutoIncrem := '';

  qryTabela             := fCriarQuery('SELECT * FROM CADPAG WHERE FALSE', Self);
  qryTabela.AfterOpen   := pAfterOpen;
  qryTabela.AfterScroll := pAfterScroll;
  dtsTabela.DataSet     := qryTabela;

  SetLength(arrCamposChave, 5);
  arrCamposChave[0] := dbeNumDup;
  arrCamposChave[1] := dbeParcel;
  arrCamposChave[2] := dbeCodEmp;
  arrCamposChave[3] := dbeCodFor;
  arrCamposChave[4] := dbeSerie;

  {*****************************}
  {* CLIENT RESPONSAVEL PELO   *}
  {* DESMEMBRAMENTO DE VALORES *}
  {**************************AN*}
  pCriaClientTemporariaCtpDet('', '', '', '', '', FDatasetCtpDet, FDatasetCtpDetClone);

  {**19/01/2014*********************************}
  {* FLAG PARA CONTROLAR SE GRAVA MOVBAN COM ***}
  {* OU SEM DESMEMBRAMENTO DE VALORES **********}
  {* RQ 29265 ******************************BB**}
  blnGravaMovBanSemDesmembrar  := (fCfgSis('PRBAMB', varInteger) = 2);
  btnEspelhoNotaFiscal.Enabled := False;

  FillChar(recUltDupBaixada, SizeOf(recUltDupBaixada), #0);

  If (fVerificaAcessoSistema('CTPALTCTABAI')) And
     (fCfgSis('CTP_AS', varString) = 'A') And
     (fCfgSis('PRBAMB', varInteger) = 2) Then
    dbeCtaBai.Color := clWindow
  else
    dbeCtaBai.Color := $00FFDFB8;

  blnIniciaCadastro   := False;
  SetLength(arrSeqLanLoc, 0);

  VisualizaComboGuiaTributos;
  qryGuiaTributo := fCriaQuery(Self);
  qryTipoTributo := fCriaQuery(Self);
  qryCadBco      := fCriaQuery(Self);
  qryDadosBcoFor := fCriaQuery(Self);
  {******************}
  {* Depósito       *}
  {***************FS*}
  lstBcoFor := TStringList.Create;

  blnUsaVendor := fCfgSis('CTPVND', varBoolean);
  objFechamento := TFechamentoFinanceiro.Create(Self, Self.Name);

  blnUsaLiberacaoDePrevisao := fCfgSis('CTPPRE', varBoolean);
  blnGravaApenasPrevisao    := (blnUsaLiberacaoDePrevisao) And
                               (Not fVerPermissaoOperador('LIBCTPPREV', strLoginUsuarioLogado));
  FValidaCorrespondenteContabil :=  TValidaCorrespondenteContabil.Create;
end;

procedure TfrmCadCtaPagar.FormDestroy(Sender: TObject);
begin
  if Assigned(objLiberacao) then
    FreeAndNil(objLiberacao);
  FreeAndNil(FValidaCorrespondenteContabil);

  FreeAndNil(FDatasetCtpDet);
  FreeAndNil(FDatasetCtpDetClone);
  inherited;
  lstBcoFor.Free;
end;

procedure TfrmCadCtaPagar.pCarregaDadosAdicionais;
var
  intCodPag: Integer;
begin
  If Not qryTabela.Active Then
    Exit;

  lblTipoPagamento.Caption := '';

  fltValOriAnt := fltValOriAnt + (qryTabela.FieldByName('CTP_VALDUP').AsFloat - fltValDupAnt);
  fltValDupAnt := qryTabela.FieldByName('CTP_VALDUP').AsFloat;

  fltValDupOld := qryTabela.FieldByName('CTP_VALDUP').AsFloat;
  fltValVendorOld := qryTabela.FieldByName('CTP_VENDOR').AsFloat;
  fltDesSujOld := qryTabela.FieldByName('CTP_DESSUJ').AsFloat;
  fltMulSujOld := qryTabela.FieldByName('CTP_MULSUJ').AsFloat;
  fltJurSujOld := qryTabela.FieldByName('CTP_JURSUJ').AsFloat;
  fltValOutrasEntidadesOld := qryTabela.FieldByName('CTP_OUTENT').AsFloat;

  If (qryTabela.State <> dsInsert) Then
    dbeCompet.Text := qryTabela.FieldByName('CTP_COMPET').AsString;
  pCarregaEmpresa;
  pCarregaFornecedor;
  pCarregaCentroCusto;
  pCarregaDadosBaixa;
  pCarregaEventos;
  pCarregaPortador;
  pCarregaProjeto;
  pCarregaCompetencia;
  pCarregaBanco;

  if ((not qryTabela.FieldByName('CTP_TIPPAG').IsNull) and (not fEmptyStr(qryTabela.FieldByName('CTP_TIPPAG').AsString))) then
  begin
    intCodPag :=  qryTabela.FieldByName('CTP_TIPPAG').AsInteger;
    case intCodPag of
       1: lblTipoPagamento.Caption := 'Tipo de Pagamento: 1 - Prefeituras(IPTU)';
       2: lblTipoPagamento.Caption := 'Tipo de Pagamento: 2 - Saneamento';
       3: lblTipoPagamento.Caption := 'Tipo de Pagamento: 3 - Energia Elétrica e Gás';
       4: lblTipoPagamento.Caption := 'Tipo de Pagamento: 4 - Telecomunicações';
    end;
  end;

  pCriaClientTemporariaCtpDet(dbeNumDup.Text, dbeParcel.Text, dbeSerie.Text, dbeCodEmp.Text, dbeCodFor.Text, FDatasetCtpDet, FDatasetCtpDetClone);

  {*****************************************}
  {* CASO A DUPLICATA ESTEJA BAIXADA, DE-  *}
  {* SABILITA OS BOTOES DE ALTERAR E EX-   *}
  {* CLUIR                                 *}
  {**************************************MV*}
  blnBaixada := fDuplicataCtpBaixada(dbeNumDup.Text,
                                     dbeParcel.Text,
                                     dbeCodEmp.Text,
                                     dbeCodFor.Text,
                                     dbeSerie.Text,
                                     qryTabela.FieldByName('CTP_SEQBAI').AsInteger);

  If (blnBaixada) Or
     (EhAgrupamento(dbeNumDup.Text, dbeCodFor.Text, dbeCodEmp.Text)) Then
  Begin
    btnExcluir.Enabled   := False;
    btnGravar.Enabled    := False;
    btnHistPagam.Enabled := True;
  End
  Else
  Begin
    If (qryTabela.State = dsEdit) Or (qryTabela.State = dsInsert) Then
    Begin
      btnGravar.Enabled    := True;
      btnExcluir.Enabled   := False;
      btnHistPagam.Enabled := False;
    End
    Else
    Begin
      btnHistPagam.Enabled := True;
      btnGravar.Enabled  := False;
      If btnExcluir.Tag <> 88 Then
        btnExcluir.Enabled := True;
    End;
  End;

  strCtaAnt := fraPlanoDeContas.dbeCodCta.Text;

  pHabilitaBotoes;
  fValidaCampos(dbeDesSuj);

  if fVinculadoReceber then
    btnAlterar.Enabled := False;
end;

procedure TfrmCadCtaPagar.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('CTP_NUMDUP');
  stlCamInd.Add('FOR_NOMFOR+CTP_DTAVEN');
  stlCamInd.Add('FOR_NOMFAN');
  stlCamInd.Add('CTP_DTAVEN');
  stlCamInd.Add('CTP_DTACAD');
  stlCamInd.Add('CTP_VALORI');
  stlCamInd.Add('CTP_CODVEL');

  stlDesInd.Add('Duplicata');
  stlDesInd.Add('Fornecedor/Vencimento');
  stlDesInd.Add('Nome Fantasia');
  stlDesInd.Add('Vencimento');
  stlDesInd.Add('Data de Cadastro');
  stlDesInd.Add('Valor Original');
  stlDesInd.Add('Documento Antigo');

  pAtribuiTabelas;

end;

procedure TfrmCadCtaPagar.btnGravarClick(Sender: TObject);
  Var
    blnInserindo : Boolean;
    blnSaveUsaPr : Boolean;
    blnAltCtaBai : Boolean;
    blnAltMovBan : Boolean;
    strCfg_PORPGR: String;
    strCfg_CTAGCP: String;
    stlVerifica  : TStringList;
    AGravouLogCtp: Boolean;
    blnTornarPend: Boolean;
    LChaveAntiga:  String;
    LChaveNova:    String;
    lstEventosInv: TStringList;
    LAlterouChave: Boolean;

    LDuplicataAnterior: TDuplicataCtp;

    procedure pCarregaTmpCtpDet;
    begin

      If Assigned(FDatasetCtpDet) Then
      Begin
        If Not FDatasetCtpDet.Active Then
          FDatasetCtpDet.Open;

        FDatasetCtpDet.IndexFieldNames := 'CTP_CODEMP;CTP_CODCTA';
      End;

    end;
begin
  strCfg_PORPGR := fCfgSis('PORPGR');
  strCfg_CTAGCP := fCfgSis('CTAGCP');

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  If fEmptyStr(dbeNumDup.Text) Then
    qryTabela.FieldByName('CTP_NUMDUP').AsString := fRetSequencialCadPag;


  If Not qryTabela.FieldByName('CTP_OPEREP').IsNull And
     blnUsaLiberacaoDePrevisao And
     (qryTabela.State in [dsEdit]) Then
  Begin
    qryTabela.FieldByName('CTP_OPEREP').Value := Null;
  End;

  If fEmptyStr(dbeParcel.Text) Or
     fEmptyStr(dbeCodEmp.Text) Or
     fEmptyStr(dbeCodFor.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Os dados para inclusão da duplicata estão inválidos.', ['&Ok']);
    pSetFocus(dbeCodFor);
    Exit;
  End;

  If Not FEntradaDeMercadoriaQueNaoChegouNaEmpresa Then
  Begin
    if (dbeDtaCad.Field.Value = Null) And (not fEmptyStr(Trim(fTiraCaracEspeciais(dbeDtaCad.Text))))  then
      qryTabela.FieldByName('CTP_DTACAD').Value := StrToDateDef(dbeDtaCad.Text, 0);
  End;

  If Not fValidacoesBotaoGravarPai Then
    Exit;

  If Not fValidaCampos(LcbTipoTributo, True) Then
    Exit;

  // CHECK
  // ESTÁ EM EDIÇÃO + PODE SOLICITAR ALTERAÇÃO DO DOCUMENTO/EMPRESA + PODE ALTERAR DOCUMENTO (CASO NÃO EXISTA)
  // FA 25/11/2016
  // REQ 63569
  if (dbeNumDup.DataSource.DataSet.State = dsEdit) and (not fPodeAlterarDocumento) then
    Exit;

  If (Not fEmptyStr(strCfg_PORPGR)) Or (Not fEmptyStr(strCfg_CTAGCP)) Then
  Begin

    If (Not fEmptyStr(strCfg_PORPGR)) Then
    Begin

      If (Not fEmptyStr(dbeCodPor.Text)) And
         (dbeCodPor.Field.OldValue <> dbeCodPor.Field.Text) And
         (dbeCodPor.Text = strCfg_PORPGR) Then
      Begin
        pMensagemOk('Portador ' + strCfg_PORPGR + ' não permitido, pois está configurado para baixa de Contas a Pagar no resumo de caixa.');
        pSetFocus(dbeCodPor);
        Exit;
      End;

    End;

    If (Not fEmptyStr(strCfg_CTAGCP)) Then
    Begin

      If (Not fEmptyStr(fraPlanoDeContas.dbeCodCta.Text)) And
         (fraPlanoDeContas.dbeCodCta.Field.OldValue <> fraPlanoDeContas.dbeCodCta.Field.Text) And
         (fraPlanoDeContas.dbeCodCta.Text = strCfg_CTAGCP) Then
      Begin
        pMensagemOk('Plano de Contas ' + strCfg_CTAGCP + ' não permitido, pois está configurado para baixa de Contas a Pagar no resumo de caixa.');
        pSetFocus(fraPlanoDeContas.dbeCodCta);
        Exit;
      End;

    End;
  End;

  If (fCfgSis('TIDVIC', varBoolean)) Then
  Begin
    If (Not fValidaDtaVenCompetencia(qryTabela.FieldByName('CTP_DTAVEN').AsDateTime, StrToDate('01/'+ dbeCompet.Text))) Then
    Begin
      pMensagemOk('Não é permitida a inclusão da duplicata com Data de Vencimento inferior a Data de Competência');
      pSetFocus(dbeDtaVen);
      Exit;
    End;
  End;

  If fDescontoMaiorQueDuplicata(qryTabela.FieldByName('CTP_DESSUJ').AsFloat,
                                qryTabela.FieldByName('CTP_VALORI').AsFloat,
                                fStrToFloat(edtValTot.Text)) Then
  Begin
    pMensagemOk('Não é permitido desconto maior ou igual ao valor do documento.');
    pSetFocus(dbeDesSuj);
    Exit;
  End;

  blnInserindo := qryTabela.State = dsInsert;
  blnTornarPend := False;

  If Not fVerificaMeta(blnInserindo) Then
    Exit;

  LDuplicataAnterior.strNumDup := EmptyStr;
  LDuplicataAnterior.strParcel := EmptyStr;
  LDuplicataAnterior.strCodEmp := EmptyStr;
  LDuplicataAnterior.strCodFor := EmptyStr;
  LDuplicataAnterior.strSerie_ := EmptyStr;
  If Not blnInserindo Then
  Begin
    LDuplicataAnterior.strNumDup := qryTabela.FieldByName('CTP_NUMDUP').OldValue;
    LDuplicataAnterior.strCodEmp := qryTabela.FieldByName('CTP_CODEMP').OldValue;
    LDuplicataAnterior.strCodFor := qryTabela.FieldByName('CTP_CODFOR').OldValue;
    LDuplicataAnterior.strParcel := qryTabela.FieldByName('CTP_PARCEL').OldValue;
    LDuplicataAnterior.strSerie_ := IIF(qryTabela.FieldByName('CTP_SERIE_').OldValue = Null,
                                        EmptyStr,
                                        qryTabela.FieldByName('CTP_SERIE_').OldValue);
  End;

  pRetornaDadosREINF( IIF(Not fEmptyStr(LDuplicataAnterior.strNumDup), LDuplicataAnterior.strNumDup, qryTabela.FieldByName('CTP_NUMDUP').AsString),
                      IIF(Not fEmptyStr(LDuplicataAnterior.strCodEmp), LDuplicataAnterior.strCodEmp, qryTabela.FieldByName('CTP_CODEMP').AsString),
                      IIF(Not fEmptyStr(LDuplicataAnterior.strCodFor), LDuplicataAnterior.strCodFor, qryTabela.FieldByName('CTP_CODFOR').AsString),
                      qryTabela.FieldByName('CTP_SERIE_').AsString,
                      qryTabela.FieldByName('CTP_PARCEL').AsString,
                      qryTabela.FieldByName('CTP_SEQBAI').AsInteger,
                      ACodigoNaturezaReinf_Old,
                      ACodigoServicoReinf_Old,
                      AAutoincremReinf);

  {*************************************}
  {* VERIFICA SE A LINHA DIGITÁVEL /   *}
  {* CÓD BARRAS JÁ ESTA CADASTRADO     *}
  {**********************************AJ*}
  stlVerifica := fVerificaLinDigCtaPag(blnInserindo,
                                       dbeLinDig.Text,
                                       dbeCodBar.Text,
                                       qryTabela.FieldByName('AUTOINCREM').AsString);
  If stlVerifica.Count > 0 Then
  Begin
    pMensagemOK('Já existe uma duplicata com o código de barras e/ou linha digitável informado(s). Verifique!' +
                   #13 + 'Duplicata: ' + stlVerifica[0] + '-' + stlVerifica[2] + '-' + stlVerifica[7]);
    FreeAndNil(stlVerifica);
    Exit;
  End;

   blnSaveUsaPr := blnUsaProCodigo;

  If fEmptyStr(dbeNumDup.Text) Then
    qryTabela.FieldByName('CTP_NUMDUP').AsString := fRetSequencialCadPag
  Else
    blnUsaProCodigo := FALSE;

  If (Not Assigned(FDatasetCtpDet)) Or (Not FDatasetCtpDet.Active)  Then
    pCriaClientTemporariaCtpDet(dbeNumDup.Text, dbeParcel.Text, dbeSerie.Text, dbeCodEmp.Text, dbeCodFor.Text, FDatasetCtpDet, FDatasetCtpDetClone);

  pCarregaTmpCtpDet;

  If ((blnInserindo Or (qryTabela.State = dsEdit)) And fCfgSis('UTICON', varBoolean)) Then
  Begin
     If fValidaEventosCFGContabil(FDatasetCtpDet,lstEventosInv) Then
     Begin
        pInformaEventosInvalidosListaContabilidade(lstEventosInv);
        Exit;
     End;
  End;

  qryTabela.FieldByName('CTP_EMPGER').AsString := dbeCodEmp.Text + '/';

  qryTabela.FieldByName('CTP_COMPET').AsString := dbeCompet.Text;

  If (blnInserindo) Then
    qryTabela.FieldByName('CTP_GRVORI').AsFloat := qryTabela.FieldByName('CTP_VALORI').AsFloat;

  If fEmptyStr(dbeSerie.Text) Then
    qryTabela.FieldByName('CTP_SERIE_').AsString := '';

  If ((VarToString(LcbTipoTributo.KeyValue) = '') Or
      (VarToString(LcbGuiaTributo.KeyValue) = '') Or
     (LcbGuiaTributo.KeyValue <> 1) Or
     (LcbTipoTributo.KeyValue <> '2100')) And
     (qryTabela.FieldByName('CTP_DTAPAG').IsNull) then
    qryTabela.FieldByName('CTP_OUTENT').AsFloat := 0.00;

  If fEmptyStr(dbeCtaBai.Text) Then
    dbeCtaBai.Field.Clear;

  blnAltCtaBai := False;
  If (Not fEmptyStr(edtTipBai.Text)) And
     (fVerificaAcessoSistema('CTPALTCTABAI')) And
     (fCfgSis('CTP_AS', varString) = 'A') And
     (fCfgSis('PRBAMB', varInteger) = 2) Then
  Begin
    If (qryTabela.FieldByName('CTP_CODCTA').OldValue <> qryTabela.FieldByName('CTP_CODCTA').NewValue) And
       (fMensagem('','Deseja alterar o centro de custo da baixa deste título e do movimento bancário?', ['&Sim', '&Não']) = 1) Then
      qryTabela.FieldByName('CTP_CTABAI').AsString := qryTabela.FieldByName('CTP_CODCTA').AsString;

    If (qryTabela.FieldByName('CTP_CTABAI').OldValue <> qryTabela.FieldByName('CTP_CTABAI').NewValue) Then
      blnAltCtaBai := True;
  End;

  AcertaCamposDeGuiaETributos();

  If fEmptyStr(dbeCodPrj.Text) Then
    qryTabela.FieldByName('CTP_CODPRJ').Value := Null;

  If fEmptyStr(dbeBcoBol.Text) Then
    dbeBcoBol.Field.Value := Null;

  pSetaBcoFor;

  if (not blnInserindo) and (fValidaTornarPend = 4)
  and fTemAlteracao then
  begin
    fTornaPendLiberacao(True);
    blnTornarPend := True;
  end;

  Try
    inherited;
    if AAlterouChave Then
    begin
      GravaLogCtp(ANumDupAnterior,
                  AParcelaAnterior,
                  ASeqBaiAnterior,
                  ACodEmpAnterior,
                  ACodForAnterior,
                  ASerieAnterior,
                  False, //FALSE: ALTERAÇÃO - TRUE: INCLUSÃO
                  ' DE CHAVE',
                  qryTabela.FieldByName('AUTOINCREM').AsString);

      LChaveAntiga := ANumDupAnterior  + '-' +
                      AParcelaAnterior + '-' +
                      ACodEmpAnterior  + '-' +
                      ACodForAnterior  + '-' +
                      ASerieAnterior;

      LChaveNova   := qryTabela.FieldByName('CTP_NUMDUP').AsString + '-' +
                      qryTabela.FieldByName('CTP_PARCEL').AsString + '-' +
                      qryTabela.FieldByName('CTP_CODEMP').AsString + '-' +
                      qryTabela.FieldByName('CTP_CODFOR').AsString + '-' +
                      qryTabela.FieldByName('CTP_SERIE_').AsString ;

      AtualizarChaveKMRodados(LChaveAntiga, LChaveNova);
    end;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      blnGravou := False;
      pMensagensErro(E.Message, '[TfrmCadCtaPagar.btnGravarClick]');
    End;
  End;

  blnUsaProCodigo := blnSaveUsaPr;
  blnAltMovBan    := False;
  {* AAlterouChave e zerado mais abaixo, ainda dentro do "If blnGravou", logo apos *}
  {* o GravaLogCtp ' POR ALTERACAO DE CHAVE'. Guardar aqui porque o ajuste da pasta *}
  {* de anexos roda depois disso.                                       Req 462258 *}
  LAlterouChave   := AAlterouChave;

  If blnGravou Then
  Begin
    Try
      {**********************************************}
      {* CASO GRAVOU, GRAVA A TABELA CTPDET, LOGCTP *}
      {****************************************MV,BB*}
      If Not blnAlterandoChave Then
        fGravaFatorCalculado(dbeNumDup.Text,
                             dbeParcel.Text,
                             dbeCodEmp.Text,
                             dbeCodFor.Text,
                             dbeSerie.Text,
                             FDatasetCtpDet,
                             Self.Name,
                             True)
      Else If AAlterouChave Then
        pAtualizaCtpDet(LDuplicataAnterior.strNumDup,
                        LDuplicataAnterior.strCodEmp,
                        LDuplicataAnterior.strCodFor,
                        LDuplicataAnterior.strParcel,
                        LDuplicataAnterior.strSerie_,
                        AGravouLogCtp);

      If (fEmptyStr(LDuplicataAnterior.strNumDup)) And (fEmptyStr(LDuplicataAnterior.strCodEmp)) And (fEmptyStr(LDuplicataAnterior.strCodFor)) Then
      Begin
        If (((ACodigoNaturezaReinf <> ACodigoNaturezaReinf_Old) or (ACodigoServicoReinf <> ACodigoServicoReinf_Old)) And (blnUsouReinf = True)) Then
        Begin
           fGravaDadosREINF( AAutoIncremReinf,
                             qryTabela.FieldByName('CTP_NUMDUP').AsString,
                             qryTabela.FieldByName('CTP_CODFOR').AsString,
                             qryTabela.FieldByName('CTP_PARCEL').AsString,
                             qryTabela.FieldByName('CTP_CODEMP').AsString,
                             qryTabela.FieldByName('CTP_SERIE_').AsString,
                             ACodigoNaturezaReinf,
                             ACodigoServicoReinf,
                             qryTabela.FieldByName('CTP_SEQBAI').AsInteger );
           blnReinfAlterado := False;
        End;
      End
      Else
      Begin
        pAtualizaCtp_REINF(IIF(Not fEmptyStr(LDuplicataAnterior.strNumDup), LDuplicataAnterior.strNumDup, dbeNumDup.Text),
                           IIF(Not fEmptyStr(LDuplicataAnterior.strCodEmp), LDuplicataAnterior.strCodEmp, dbeCodEmp.Text),
                           IIF(Not fEmptyStr(LDuplicataAnterior.strCodFor), LDuplicataAnterior.strCodFor, dbeCodFor.Text));
        blnReinfAlterado := False;
      End;

      if AAlterouChave Then
      begin
        GravaLogCtp(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                    qryTabela.FieldByName('CTP_PARCEL').AsString,
                    qryTabela.FieldByName('CTP_SEQBAI').AsInteger,
                    qryTabela.FieldByName('CTP_CODEMP').AsString,
                    qryTabela.FieldByName('CTP_CODFOR').AsString,
                    qryTabela.FieldByName('CTP_SERIE_').AsString,
                    True, //FALSE: ALTERAÇÃO - TRUE: INCLUSÃO
                    ' POR ALTERAÇÃO DE CHAVE');

        AAlterouChave := False;
      end
      else
      begin
        if AGravouLogCtp then
          GravaLogCtp(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                      qryTabela.FieldByName('CTP_PARCEL').AsString,
                      qryTabela.FieldByName('CTP_SEQBAI').AsInteger,
                      qryTabela.FieldByName('CTP_CODEMP').AsString,
                      qryTabela.FieldByName('CTP_CODFOR').AsString,
                      qryTabela.FieldByName('CTP_SERIE_').AsString,
                      blnInserindo,
                      ' (TEVE CTPDET)')
        Else
          GravaLogCtp(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                      qryTabela.FieldByName('CTP_PARCEL').AsString,
                      qryTabela.FieldByName('CTP_SEQBAI').AsInteger,
                      qryTabela.FieldByName('CTP_CODEMP').AsString,
                      qryTabela.FieldByName('CTP_CODFOR').AsString,
                      qryTabela.FieldByName('CTP_SERIE_').AsString,
                      blnInserindo);

        AGravouLogCtp := False;
      end;
      pGeraLogLiberacao(qryTabela.FieldByName('CTP_NUMDUP').AsString,'',qryTabela.FieldByName('CTP_CODEMP').AsString);
      If blnBaixada And ((blnAltCtaBai) Or (Not LDuplicataAnterior.strCodFor.Equals(dbeCodFor.Text)) Or (Not LDuplicataAnterior.strNumDup.Equals(dbeNumDup.Text))) Then
        blnAltMovBan := fAlteraMovBanBanCtp(IIF(blnAltCtaBai,qryTabela.FieldByName('CTP_CTABAI').AsString,''),
                                            IIF(LDuplicataAnterior.strNumDup.Equals(dbeNumDup.Text),'',qryTabela.FieldByName('CTP_NUMDUP').AsString),
                                            LDuplicataAnterior.strCodFor, dbeCodFor.Text, qryTabela.FieldByName('CTP_DOCBAI').AsString, qryTabela.FieldByName('CTP_HISBAI').AsString);

      If qryTabela.FieldByName('CTP_CODBAR').AsString.IsEmpty Then
        untCadPag.ApagaDuplicataRETDDA(qryTabela.FieldByName('AUTOINCREM').AsString);

      fCommit;
      If blnAltMovBan Then
        fMensagem('', 'O movimento bancário também foi atualizado!', ['&OK']);

      if blnAltCtaBai then
        btnDocBaixa.Enabled  := True;

    Except
      On E: Exception Do
      Begin
        fRollBack;
        blnGravou := False;
        pMensagensErro(E.Message, '[btnGravarClick]');
      End;
    End;

    {* Req 462258 - a pasta dos anexos leva fornecedor e empresa no nome; com a      *}
    {* chave trocada os arquivos ficariam na pasta da chave antiga. Entra aqui, logo *}
    {* apos o fCommit e ANTES do "btnSair.Click; Exit" mais abaixo, que fecha a tela *}
    {* quando ela foi aberta por outra rotina (strAutoIncrem preenchido).            *}
    If LAlterouChave and blnGravou Then
      pAjustaPastaAnexos(qryTabela.FieldByName('CTP_CODFOR').AsString,
                         qryTabela.FieldByName('CTP_CODEMP').AsString,
                         qryTabela.FieldByName('AUTOINCREM').AsString,
                         ACodForAnterior,
                         ACodEmpAnterior);

    pHabilitaBotoes;
    pDesabilitaFields;
    VisualizaComboGuiaTributos;

    if dbePrevis.Text = 'N' then
    begin
      Try
        pCriarFormularios(TFrmManipulaContasPagarPrevisaoNao, frmManipulaContasPagarPrevisaoNao) ;
        frmManipulaContasPagarPrevisaoNao.AUTOINCREM := qryTabela.FieldByName('AUTOINCREM').AsString ;
        frmManipulaContasPagarPrevisaoNao.pCarregarDadosCtaPagarComPrevisaoNao;
        if frmManipulaContasPagarPrevisaoNao.fCarregarDadosCtaPagarComPrevisaoSim then
        frmManipulaContasPagarPrevisaoNao.showModal;
      Finally
        FreeAndNil(frmManipulaContasPagarPrevisaoNao);
      End;
    end;

    {*********************************************************************}
    {* SÓ PERGUNTA SE BAIXA A DUPLICATA SE TEM ACESSO PARA ALTERAR VALOR *}
    {******************************************************************JU*}
    If fVerificaAcessoSistema('CTPALTVLR')Then
    Begin
      If (fCfgSis('PBXAUT', varBoolean)) Then
      Begin
        If (blnInserindo)             And
           (fEmptyStr(strAutoIncrem)) And
           (fMensagem('', 'Baixar esta duplicata?', ['&Sim', '&Não'], 2) = 1) Then
        Begin
          If Not fLock_Unlock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString, True, False) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esta duplicata está sendo utilizada por outra estação: ' + fGetHostLock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString), ['&Ok']);
            Exit;
          End;

          fLock_Unlock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString, False);
          blnTelaReduzida := True;

          fBaixaCtp;
          pCarregaDadosAdicionais;
        End;
      End;
    End;

    If (fCfgSis('IMP_CP', varBoolean)) Then
      If (fMensagem('', 'Deseja imprimir CP?', ['&Sim', '&Não']) = 1) Then
        pImprimeCP;

    blnTravarDes := False;
    blnTravarAlt := False;

    pCarregaDadosAdicionais;
    pCalculaValorTotal;
    VerificaSeStatusFatura(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                           qryTabela.FieldByName('CTP_CODEMP').AsString,
                           qryTabela.FieldByName('CTP_CODFOR').AsString,
                           qryTabela.FieldByName('CTP_SERIE_').AsString);

    btnReinf.enabled := Not VerificaSeDuplicataTemCadFis(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                                                         qryTabela.FieldByName('CTP_CODEMP').AsString,
                                                         qryTabela.FieldByName('CTP_CODFOR').AsString,
                                                         qryTabela.FieldByName('CTP_SERIE_').AsString);

    pAtualizaCorBotaoREINF(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                           qryTabela.FieldByName('CTP_PARCEL').AsString,
                           qryTabela.FieldByName('CTP_SERIE_').AsString,
                           qryTabela.FieldByName('CTP_CODEMP').AsString,
                           qryTabela.FieldByName('CTP_CODFOR').AsString,
                           qryTabela.FieldByName('CTP_SEQBAI').AsInteger);

    if blnIniciaCadastro OR (Not fEmptyStr(strAutoIncrem)) then
    begin
      btnSair.Click;
      Exit;
    end;

    blnAlterandoChave    := False;
    btnBaixarDup.Enabled := True;
    btnHistPagam.Enabled := True;
    blnGravou            := False;

    If blnInserindo Then
    begin
      fLock_Unlock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString, True, False);
      blnDupTravada       := True;
      strAutoincremLckAtc := qryTabela.FieldByName('AUTOINCREM').AsString;
    end;

    pSetFocus(Self);
    LcbGuiaTributo.Enabled := False;
    LcbTipoTributo.Enabled := False;

    if blnTornarPend then
      pAtualizaDlp(qryTabela.FieldByName('AUTOINCREM').AsString);
  End
  Else
    fRollBack;
end;

procedure TfrmCadCtaPagar.btnHistPagamClick(Sender: TObject);
  Var
    frmRelCtpLogAcompDuplicNovo: TfrmRelCtpLogAcompDuplicNovo;
begin
  inherited;
  If (qryTabela.IsEmpty) Or (fEmptyStr(dbeNumDup.Text))Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmRelCtpLogAcompDuplicNovo, frmRelCtpLogAcompDuplicNovo);
    frmRelCtpLogAcompDuplicNovo.edtCodEmpresa.Text    := qryTabela.FieldByName('CTP_CODEMP').AsString;
    frmRelCtpLogAcompDuplicNovo.edtCodFornecedor.Text := qryTabela.FieldByName('CTP_CODFOR').AsString;
    frmRelCtpLogAcompDuplicNovo.edtNumDoc.Text        := qryTabela.FieldByName('CTP_NUMDUP').AsString;
    frmRelCtpLogAcompDuplicNovo.edtParcel.Text        := qryTabela.FieldByName('CTP_PARCEL').AsString;
    frmRelCtpLogAcompDuplicNovo.edtSerie.Text         := qryTabela.FieldByName('CTP_SERIE_').AsString;
    frmRelCtpLogAcompDuplicNovo.blnVeioManutencao     := True;
    frmRelCtpLogAcompDuplicNovo.pCarregaCampos;
    if frmRelCtpLogAcompDuplicNovo.DatasetConsulta.IsEmpty then
      fMensagem('ATENÇÃO!', 'Sem dados para exibir!', ['&O k'])
    else
      frmRelCtpLogAcompDuplicNovo.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCadCtaPagar.btnHistPagam]');
  End;
  pFreeAndNil(frmRelCtpLogAcompDuplicNovo);

end;

procedure TfrmCadCtaPagar.btnIncluirClick(Sender: TObject);
begin
  inherited;
  if blnDupTravada and (Not (fEmptyStr(strAutoIncremLckAtc))) then
  begin
    fLock_Unlock(strNomeTabela + strAutoIncremLckAtc, False);
    blnDupTravada       := False;
    strAutoIncremLckAtc := '';
  end;

  strCtaAnt := '';
  edtStatus.Text := '';
  edtProvisao.Text := '';
  edtNumPedCompra.Text := '';

  If fEmptyStr(strLoginUsuarioLogado) Then
    qryTabela.FieldByName('CTP_CODVEN').Value := Null
  Else
    qryTabela.FieldByName('CTP_CODVEN').AsString := strLoginUsuarioLogado;

  If fEmptyStr(strLoginUsuarioLogado) Then
    qryTabela.FieldByName('CTP_CODOPE').Value := Null
  Else
    qryTabela.FieldByName('CTP_CODOPE').AsString := strLoginUsuarioLogado;

  btnEstorno.Enabled   := False;
  btnBaixarDup.Enabled := False;
  btnHistPagam.Enabled := False;
  btnRomaneio.Enabled  := False;
  btnDocBaixa.Enabled  := False;
  pSetFocus(dbeNumDup);
  pLimparEdits;
  pHabilitaFields;
  pIniciaValoresPadrao;

  If (Assigned(FDatasetCtpDet)) And (FDatasetCtpDet.Active) Then
  Begin
    FDatasetCtpDet.EmptyDataSet;
    FDatasetCtpDetClone.EmptyDataset;
  End;

  chkCodBar.Enabled := True;
  dbeCodBar.Enabled := True;
  chkLinDig.Enabled := True;
  dbeLinDig.Enabled := True;
  dbeCtaBai.Enabled := False;

  LcbGuiaTributo.Enabled := True;
  LcbTipoTributo.Enabled := True;

  pHabilitaDesabiltabtnAbrirPastaAnexos;

  VisualizaComboGuiaTributos;
  pCalculaValorTotal;
  FValidaCorrespondenteContabil.LimparListas;

  ACodigoNaturezaReinf := '';
  ACodigoServicoReinf  := '';
  blnUsouReinf := False;

  btnReinf.Font.Color := clblack;
end;

procedure TfrmCadCtaPagar.btnLiberacaoBaixaClick(Sender: TObject);
begin
  inherited;
  //VERIFICA SE TEM DIREITO DE ACESSO
  If Not fVerificaAcessoSistema('frmCtpLiberacaoBaixa') Then
  Begin
    fMensagem('ATENÇÃO','Operador sem permissão para Liberação de Baixa.',['&Ok']);
    Exit;
  End
  Else
  Begin
    //VERIFICA SE JÁ NÃO FOI LIBERADA
    If (qryTabela.FieldByName('CTP_DTAPAG').AsDateTime > 0) Then
    Begin
      fMensagem('ATENÇÃO','Essa duplicata já foi paga.',['&Ok']);
      Exit;
    End
    Else
    Begin
      If (qryTabela.FieldByName('CTP_DTALIB').AsDateTime > 0) Then
      Begin
        fMensagem('ATENÇÃO','Essa duplicata já está liberada para baixa.',['&Ok']);
        Exit;
      End
      Else
      Begin
        Try

          fLiberaBaixaCtp;
          pAtualizaDlp(qryTabela.FieldByName('AUTOINCREM').AsString);
          fCarregaDuplicata(True);

        Except
          On E: Exception Do
            pMensagensErro(E.Message, '[TfrmCadCtaPagar.btnLiberacaoBaixaClick]');
        End;
      End;
    End;
  End;
end;

procedure TfrmCadCtaPagar.btnListarPortadoresClick(Sender: TObject);
begin
  inherited;

  If Not btnListarPortadores.Visible Then
    Exit;

  Try
    pCriarFormularios(TfrmCtpListaPortadores, frmCtpListaPortadores);
    frmCtpListaPortadores.strNumDup := qryTabela.FieldByName('CTP_NUMDUP').AsString;
    frmCtpListaPortadores.strParcel := qryTabela.FieldByName('CTP_PARCEL').AsString;
    frmCtpListaPortadores.intSeqBai := qryTabela.FieldByName('CTP_SEQBAI').AsInteger;
    frmCtpListaPortadores.strCodEmp := qryTabela.FieldByName('CTP_CODEMP').AsString;
    frmCtpListaPortadores.strCodFor := qryTabela.FieldByName('CTP_CODFOR').AsString;
    frmCtpListaPortadores.strSerie_ := qryTabela.FieldByName('CTP_SERIE_').AsString;
    frmCtpListaPortadores.strSeqLan := qryTabela.FieldByName('CTP_DOCBAI').AsString;

    frmCtpListaPortadores.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmCtpListaPortadores);
end;

procedure TfrmCadCtaPagar.AcertaCamposDeGuiaETributos;
  Var
    LGravarNulo: Boolean;
begin
  LGravarNulo := VarToString(LcbGuiaTributo.KeyValue) = '';

  If (Not LGravarNulo) Then
    LGravarNulo := LcbGuiaTributo.KeyValue < 0;

  If LGravarNulo Then
  Begin
    qryTabela.FieldByName('CTP_Q_GUIA').Value := Null;
    qryTabela.FieldByName('CTP_CODREC').Value := Null;

    Exit;
  End;

  qryTabela.FieldByName('CTP_Q_GUIA').AsString := LcbGuiaTributo.KeyValue;

  {*******************************************************************************}
  {* IF PARA GARANTIR QUE O CAMPO DE CÓDIGO DE RECEITA SEJA GRAVADO CORRETAMENTE *}
  {* QUANDO FOR IPTU OU ISS, QUE SÃO TRIBUTOS QUE NÃO POSSUEM CÓDIGO DE RECEITA. *}
  {*REQ*153657*****************************************************************MO*}
  LGravarNulo := VarToString(LcbTipoTributo.KeyValue) = '';

  If Not LGravarNulo Then
    LGravarNulo := MatchStr(VarToString(LcbGuiaTributo.KeyValue), ['8', '9']);

  If Not LGravarNulo Then
    LGravarNulo := VarToString(LcbTipoTributo.KeyValue).IsEmpty;

  If LGravarNulo Then
    qryTabela.FieldByName('CTP_CODREC').Value := Null
  else
    qryTabela.FieldByName('CTP_CODREC').AsString := LcbTipoTributo.KeyValue;

end;

procedure TfrmCadCtaPagar.btnEspelhoCteClick(Sender: TObject);
  Var
    LRelConhecimentoFrete: TfrmRelConhecimentoFrete;
begin
  inherited;
   pCriarFormularios(TfrmRelConhecimentoFrete, LRelConhecimentoFrete);
   Try
     LRelConhecimentoFrete.VisualizarRelConhecimentoFrete(qryTabela.FieldByName('CTP_NUMDUP').AsString,qryTabela.FieldByName('CTP_SERIE_').AsString,
                                                          qryTabela.FieldByName('CTP_CODEMP').AsString,qryTabela.FieldByName('CTP_CODFOR').AsString);
   Finally
     pFreeAndNil(LRelConhecimentoFrete);
   End;
end;

procedure TfrmCadCtaPagar.btnImpCtaPagarClick(Sender: TObject);
var
  LOpenDialog : TOpenDialog;
  LfrmGravando : TfrmGravando;
begin
  inherited;

  if fCfgSis('CTPOBE', varBoolean) then
  begin
    if fEmptyStr(fCfgSis('EVETKT', varString)) then
    begin
      pMensagemOk('Quando a configuração "CTPOBE" estiver marcada como "S", ' +
                  'é necessário informar o Centro de Custos na configuração "EVETKT".');
      Exit;
    end;
  end;

  LOpenDialog := TOpenDialog.Create(nil);
  try
    if not LOpenDialog.Execute Then
      Exit;

    FArquivoIntegracao := LOpenDialog.FileName;

    pCriarFormularios(TfrmGravando, LfrmGravando);
    Try
      LfrmGravando.lblGravando.Caption := 'Importando Contas...';
      LfrmGravando.pgbStatus.Visible := False;
      LfrmGravando.fExecutarAcao := ImportarCtaPagar;
      LfrmGravando.ShowModal;
    finally
      if Assigned(LfrmGravando) Then
        FreeAndNil(LfrmGravando);
    end;

  finally
    if Assigned(LOpenDialog) Then
      FreeAndNil(LOpenDialog);
  end;

end;

{* Nome da pasta de anexos da duplicata: fornecedor(8) - empresa(3) - autoincrem(20). *}
function TfrmCadCtaPagar.fMontaNomePastaAnexos(const ACodFor, ACodEmp, AAutoIncrem: String): String;
begin
  Result := fStrZero(ACodFor, 8) + '-' + fStrZero(ACodEmp, 3) + '-' + fStrZero(AAutoIncrem, 20);
end;

{* Leva o conteudo de AOrigem para ADestino. Renomeia a pasta quando ADestino ainda nao *}
{* existe; quando ja existe, transfere arquivo a arquivo - TDirectory.Move nao aceita   *}
{* destino existente e estouraria deixando os anexos para tras. Nunca sobrescreve e so  *}
{* remove a origem se ela ficar vazia. Result = alguma coisa foi movida.                *}
function TfrmCadCtaPagar.fMoverPastaAnexos(const AOrigem, ADestino: String): Boolean;
  Var
    strArquivo   : String;
    strArqDestino: String;
begin
  Result := False;

  If fEmptyStr(AOrigem) Then
    Exit;

  If fEmptyStr(ADestino) Then
    Exit;

  If SameText(ExcludeTrailingPathDelimiter(AOrigem), ExcludeTrailingPathDelimiter(ADestino)) Then
    Exit;

  If Not DirectoryExists(AOrigem) Then
    Exit;

  If Not DirectoryExists(ADestino) Then
  Begin
    TDirectory.Move(AOrigem, ADestino);
    Result := True;
    Exit;
  End;

  For strArquivo In TDirectory.GetFiles(AOrigem) Do
  Begin
    strArqDestino := IncludeTrailingPathDelimiter(ADestino) + ExtractFileName(strArquivo);

    If FileExists(strArqDestino) Then
      Continue;

    TFile.Move(strArquivo, strArqDestino);
    Result := True;
  End;

  If Length(TDirectory.GetFileSystemEntries(AOrigem)) = 0 Then
    TDirectory.Delete(AOrigem);
end;

{* Garante que os anexos da duplicata estejam na pasta da chave atual e, com AMostraTela, *}
{* abre a tela de anexos. ACodForAnt/ACodEmpAnt sao a chave ANTERIOR quando houve troca   *}
{* de fornecedor/empresa - vazios quando nao houve troca, e ai nada e movido por conta    *}
{* dela. A pasta so e criada (pela propria TfrmGravaArquivoPasta) quando AMostraTela.     *}
procedure TfrmCadCtaPagar.pAjustaPastaAnexos(const ACodFor, ACodEmp, AAutoIncrem,
  ACodForAnt, ACodEmpAnt: String; const AMostraTela: Boolean = False);
  Var
    strPastaBase   : String;
    strPastaDestino: String;
    blnMoveu       : Boolean;
begin
  If fEmptyStr(ACodFor) Then
    Exit;

  If fEmptyStr(ACodEmp) Then
    Exit;

  If fEmptyStr(AAutoIncrem) Then
    Exit;

  Try
    strPastaBase := fCfgSis('PAGPAT');
    If fEmptyStr(strPastaBase) Then
      strPastaBase := ExtractFilePath(Application.ExeName) + 'ANEXOS_CTP\';

    strPastaBase    := IncludeTrailingPathDelimiter(strPastaBase);
    strPastaDestino := strPastaBase + fMontaNomePastaAnexos(ACodFor, ACodEmp, AAutoIncrem);

    {* pasta no formato antigo, so com o autoincrem *}
    blnMoveu := fMoverPastaAnexos(ExtractFilePath(Application.ExeName) + 'ANEXOS_CTP\' + AAutoIncrem,
                                  strPastaDestino);

    {* pasta da chave anterior, quando o fornecedor ou a empresa mudaram *}
    If (Not fEmptyStr(ACodForAnt)) And (Not fEmptyStr(ACodEmpAnt)) Then
      blnMoveu := fMoverPastaAnexos(strPastaBase + fMontaNomePastaAnexos(ACodForAnt, ACodEmpAnt, AAutoIncrem),
                                    strPastaDestino) Or blnMoveu;

    If blnMoveu Then
      Sleep(500);

    If AMostraTela Then
    Begin
      pFreeAndNil(frmGravaArquivoPasta);
      pCriarFormularios(TfrmGravaArquivoPasta, frmGravaArquivoPasta);
      Try
        frmGravaArquivoPasta.Caption         := 'Pasta ( Arquivos Anexos )';
        frmGravaArquivoPasta.strCaminhoPasta := strPastaDestino;
        frmGravaArquivoPasta.ShowModal;
      Finally
        pFreeAndNil(frmGravaArquivoPasta);
      End;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCadCtaPagar.pAjustaPastaAnexos]');
  End;
end;

procedure TfrmCadCtaPagar.btnAbrirPastaAnexosClick(Sender: TObject);
  Var
    strCodFor: String;
    strCodEmp: String;
begin
  inherited;

  If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
    Exit;

  If (Not fVerificaAcessoSistema('PVADCTP', strLoginUsuarioLogado)) then
  Begin
    pMensagemOK('Usuário sem direito de acesso para visualizar os arquivos anexos.');
    Exit;
  End;

  {* Em alteracao de chave os campos da tela ja estao com a chave NOVA, que ainda nao *}
  {* foi gravada - a pasta dos anexos pertence a chave GRAVADA. Por isso usa o par    *}
  {* Anterior, preenchido no btnAltNumDocClick. Renomear a pasta aqui apontaria para  *}
  {* uma chave que o usuario ainda pode cancelar.                          Req 462258 *}
  strCodFor := qryTabela.FieldByName('CTP_CODFOR').AsString;
  strCodEmp := qryTabela.FieldByName('CTP_CODEMP').AsString;

  If blnAlterandoChave Then
  Begin
    strCodFor := ACodForAnterior;
    strCodEmp := ACodEmpAnterior;
  End;

  pAjustaPastaAnexos(strCodFor,
                     strCodEmp,
                     qryTabela.FieldByName('AUTOINCREM').AsString,
                     EmptyStr,
                     EmptyStr,
                     True);
end;

procedure TfrmCadCtaPagar.btnAjuValClick(Sender: TObject);
begin
  inherited;
  If Not btnAjuVal.Enabled Then
    Exit;

  If (Not fVerificaAcessoSistema('CTPALTALLPARC', strLoginUsuarioLogado)) then
  Begin
    pMensagemOK('Usuário sem direito de acesso para utilizar a função.');
    Exit;
  End;

  If (Not qryTabela.Active) Or (qryTabela.IsEmpty) Then
  Begin
    pMensagemOK('É necessário possuir algum registro selecionado para utilizar essa função.');
    Exit;
  End;

  If qryTabela.State <> dsBrowse Then
    Exit;

  pCriarFormularios(TfrmCadCtaPagarParcelas, frmCadCtaPagarParcelas);
  frmCadCtaPagarParcelas.strAutoincAtual := qryTabela.FieldByName('AUTOINCREM').AsString;
  frmCadCtaPagarParcelas.pCarregaParcelas(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                                          qryTabela.FieldByName('CTP_SERIE_').AsString,
                                          qryTabela.FieldByName('CTP_CODFOR').AsString,
                                          qryTabela.FieldByName('CTP_CODEMP').AsString);
  If frmCadCtaPagarParcelas.blnAltPar Then
    frmCadCtaPagarParcelas.ShowModal
  Else
    frmCadCtaPagarParcelas.Close;
  FreeAndNil(frmCadCtaPagarParcelas);

  qryTabela.Close;
  qryTabela.Open;
  pCarregaDadosAdicionais;
  pCalculaValorTotal;
  pSetFocus(btnAlterar);
end;

procedure TfrmCadCtaPagar.btnAlterarClick(Sender: TObject);
  Var
    blnPodeAlterar: Boolean;
    blnTemCtpDet: Boolean;
    blnRatEve : Boolean;
begin
  blnPodeAlterar := True;
  blnValPlanoCusto := False;
  ACodigoNaturezaReinf := '';
  ACodigoServicoReinf  := '';
  blnUsouReinf := False;

  If Not (fCfgSis('EMPGER', varBoolean)) Then
  Begin
    If (Not fEmptyStr(dbeCodEmp.Text)) Then
    Begin
      If dbeCodEmp.Text = VS_strCodEmp Then
        blnPodeAlterar := True
      Else
        blnPodeAlterar := False;
    End;
  End;

  If blnPodeAlterar Then
  Begin

    If Not blnDupTravada Then
    Begin
      fLock_Unlock(strNomeTabela +
                   qryTabela.FieldByName('AUTOINCREM').AsString,
                   True,
                   False);

      strAutoIncremLckAtc := qryTabela.FieldByName('AUTOINCREM').AsString;
      blnDupTravada       := True;
    end;

    inherited;

    If blnAlterou Then
    Begin
      LcbGuiaTributo.Enabled := qryTabela.FieldByName('CTP_DTAPAG').IsNull;
      LcbTipoTributo.Enabled := qryTabela.FieldByName('CTP_DTAPAG').IsNull;
      dbeCompet.Enabled := qryTabela.FieldByName('CTP_DTAPAG').IsNull;

      pHabilitaFields;
      pTrataBcoFor;
      btnBaixarDup.Enabled := False;
      btnHistPagam.Enabled := False;

      blnTemCtpDet := fVerificaCtpDet(dbeNumDup.Text,
                                      dbeParcel.Text,
                                      dbeSerie.Text,
                                      dbeCodEmp.Text,
                                      dbeCodFor.Text,
                                      blnRatEve);

      fraPlanoDeContas.dbeCodCta.Enabled := not blnTemCtpDet;
      fraCentroCusto.dbeCodEve.Enabled := not blnRatEve;
      fltValDupOld      := qryTabela.FieldByName('CTP_VALDUP').AsFloat;
      strDtaCadOld      := qryTabela.FieldByName('CTP_DTACAD').AsString;
      strDtaVenOld      := qryTabela.FieldByName('CTP_DTAVEN').AsString;
      strCodPorOld      := qryTabela.FieldByName('CTP_CODPOR').AsString;
      strCodCtaOld      := qryTabela.FieldByName('CTP_CODCTA').AsString;
      strCompetOld      := qryTabela.FieldByName('CTP_COMPET').AsString;

      If blnRatEve Then
      Begin
        If Trim(fraCentroCusto.dbeCodEve.Text) = '' Then
        Begin
          fraCentroCusto.dbeCodEve.Text := fCfgSis('EVEPRI');
          pCarregaEventos;
        End;
      End;

      pHabilitaCodigo(dbeNumDup, dbeDtaCad, False);
      dbeParcel.Enabled := False;
      dbeCodEmp.Enabled := False;
      dbeCodFor.Enabled := False;
      dbeSerie.Enabled  := False;
      pHabilitaBotoes;

      If (Not fEmptyStr(edtTipBai.Text)) Then
      Begin
        pEnabled(Self, False);
        fraPlanoDeContas.dbeCodCta.Enabled := not blnTemCtpDet;
        fraCentroCusto.dbeCodEve.Enabled   := not blnRatEve;
        dbeHisto1.Enabled := True;
        dbeVeioNF.Enabled := True;

         dbeCompet.Enabled := fVerificaAcessoSistema('CTPALTCOMP', strLoginUsuarioLogado) And
                              fVerificaAcessoSistema('ALTCOMPCTP', strLoginUsuarioLogado);

        dbeCtaBai.Enabled := (fVerificaAcessoSistema('CTPALTCTABAI')) And
                             (fCfgSis('CTP_AS', varString) = 'A') And
                             (fCfgSis('PRBAMB', varInteger) = 2) And
                             (qryTabela.FieldByName('CTP_CTABAI').AsString <> fCfgSis('CTAPRI'));
        pSetFocus(dbeDtaCad);
      End
      Else
      Begin
        fraPlanoDeContas.dbeCodCta.Enabled := not blnTemCtpDet;
        fraCentroCusto.dbeCodEve.Enabled := not blnRatEve;

        dbeCtaBai.Enabled := False;
        dbeCodPor.Enabled := True;
        dbeHisto1.Enabled := True;
        dbeVeioNF.Enabled := True;
        dbeValDup.Enabled := fCfgSis('CTPVAL', varBoolean);
        dbeDtaVen.Enabled := fCfgSis('CTPDTA', varBoolean);
        dbeDtaCad.Enabled := (fCfgSis('CTPCAD', varBoolean)) And
                             (Not fEmptyStr(strDtaCadOld));
        dbeCodPor.Enabled := fCfgSis('CTPPOR', varBoolean);

        dbeCompet.Enabled := fVerificaAcessoSistema('ALTCOMPCTP', strLoginUsuarioLogado);

      End;

      If (not dbeDtaCad.Enabled) Then
        pSetFocus(dbeCompet);
      If (not dbeCompet.Enabled) And (not dbeDtaCad.Enabled) Then
        pSetFocus(dbeQtdDia);
      If (not dbeQtdDia.Enabled) And (not dbeCompet.Enabled) And (not dbeDtaCad.Enabled)  Then
         pSetFocus(fraCentroCusto.dbeCodEve);


      fValidaCampos(dbeDesSuj);

      strSenhaDtaCadOld := '';
      strSenhaDtaVenOld := '';
      strSenhaValDupOld := '';
      strSenhaCodPorOld := '';
      VisualizaComboGuiaTributos;

      dbePrevis.Enabled := (Not blnUsaLiberacaoDePrevisao) Or
                           ((Not blnGravaApenasPrevisao) And
                            (qryTabela.FieldByName('CTP_OPEAPR').IsNull) And
                            (qryTabela.FieldByName('CTP_OPEREP').IsNull) And
                            (qryTabela.FieldByName('CTP_PREVIS').AsString = 'N'));

      {*****************************************************}
      {* SÓ PODE ALTERAR O VALDUP SE TEM DIREITO DE ACESSO *}
      {**************************************************JU*}

      If Not fVerificaAcessoSistema('CTPALTVLR') Then
      Begin
        dbeValDup.Enabled := False;
        dbeDesSuj.Enabled := False;
        dbeJurSuj.Enabled := False;
        dbeMulSuj.Enabled := False;
        dbeVendor.Enabled := False;
      End;

      if fContaPagarGeradaPelaRotinaDeResumoISS(qryTabela.FieldByName('AUTOINCREM').AsString) then
        dbeValDup.Enabled := False;

    End;
    btnPendLiberacao.Enabled := not blnPodeAlterar;
  End
  Else
  Begin
    fMensagem('ATENÇÃO!', 'Uma Empresa Não Gerencial só pode alterar Duplicatas por ela Gerada!', ['&O k']);
  End;
  TravaAlteracaoDeCamposPrincipaisDaNotaDeEntrada;
  dbeDtaCad.Enabled := ( dbeDtaCad.Enabled And Not FEntradaDeMercadoriaQueNaoChegouNaEmpresa);
end;

procedure TfrmCadCtaPagar.pLimparEdits;
begin
  edtNomEmp.Clear;
  edtNomFor.Clear;
  fraPlanoDeContas.edtDesCta.Clear;
  edtNomPor.Clear;
  fraCentroCusto.edtDesEve.Clear;

  edtTipBai.Clear;
  edtDtaPag.Clear;
  edtDocBai.Clear;
  edtPorBai.Clear;
  edtDesCtaBai.Clear;
  edtDesPrj.Clear;
  edtHisBai.Clear;
  edtOpeBai.Clear;
  edtSeqBai.Clear;
  edtValPag.Clear;
  edtDocBai.Clear;
  edtValOri.Clear;
  lblTipoPagamento.Caption := '';

  edtNomBan.Clear;

  fltValDupOld := 0;
  strDtaCadOld := '';
  strDtaVenOld := '';
  strCodPorOld := '';
  strCodCtaOld := '';
  strCompetOld := '';

  strSenhaDtaCadOld := '';
  strSenhaDtaVenOld := '';
  strSenhaValDupOld := '';
  strSenhaCodPorOld := '';
end;

class procedure TfrmCadCtaPagar.pMostraIniciandoCadastro(fltValLan: Double;
  strHist01: String; dteDataLan, dteDataVen: TDate; strCodPor: String;var arrSeqLan: TStringArray);
var
  frmCadCtaPagar: TfrmCadCtaPagar;
begin
  pCriarFormularios(TfrmCadCtaPagar, frmCadCtaPagar);
  try
    with frmCadCtaPagar do
    begin
      blnIniciaCadastro := True;

      fltValLanLoc  := fltValLan;
      strHist01Loc  := strHist01;
      strCodPorLoc  := strCodPor;
      dteDataLanLoc := dteDataLan;
      dteDataVenLoc := dteDataVen;

      ShowModal;

      arrSeqLan     := arrSeqLanLoc;
    end;
  except
    On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadCtaPagar.pMostraIniciandoCadastro]');
  end;
  pFreeAndNil(frmCadCtaPagar);
end;

procedure TfrmCadCtaPagar.pPreencheCentroCusto;
begin
  If (qryTabela.State = dsInsert) And (fraPlanoDeContas.dbeCodCta.Enabled) Then
  Begin
    If fCfgSis('USACTF', varBoolean) Then
    begin
      pCarregaCtaFornecedor(dbeCodFor.Text);
      fraPlanoDeContas.dbeCodCta.Field.AsString := qryCtaFor.FieldByName('CTF_CODCTA').AsString;
    end
    else
    begin
      if Not qryConFor.IsEmpty Then
      begin
        fraPlanoDeContas.dbeCodCta.Field.AsString := qryConFor.FieldByName('FOR_CODCTA').AsString;
      end;

      strCtaFor := fraPlanoDeContas.dbeCodCta.Field.AsString;
    end;
    strCtaAut := fraPlanoDeContas.dbeCodCta.Field.AsString;
    pCarregaCentroCusto;
  End;
end;

procedure TfrmCadCtaPagar.pSetaBcoFor;
begin
  //Feito dessa forma pois foi pedido para não mudar o layout dos campos na tela
  qryTabela.FieldByName('CTP_BCOFOR').Value := Null;
  qryTabela.FieldByName('CTP_FORPIX').Value := Null;
  If cbxBcoFor.ItemIndex > -1 Then
  Begin
    If LeftStr(lstBcoFor[cbxBcoFor.ItemIndex], 3) <> 'PIX' Then
      qryTabela.FieldByName('CTP_BCOFOR').AsString := lstBcoFor[cbxBcoFor.ItemIndex]
    Else
      qryTabela.FieldByName('CTP_FORPIX').AsString := Copy(lstBcoFor[cbxBcoFor.ItemIndex], 4, 20);
  End;
end;

procedure TfrmCadCtaPagar.pTrataBcoFor;
begin
  If Assigned(dtsTabela.DataSet) Then
  Begin
    If (dtsTabela.DataSet.State in dsEditModes) Then
    Begin
      cbxBcoFor.Enabled := (dbeDeposi.Text = 'S');
      If (Not cbxBcoFor.Enabled) Then
      Begin
        cbxBcoFor.ItemIndex := -1;
        qryTabela.FieldByName('CTP_BCOFOR').Value := Null;
        qryTabela.FieldByName('CTP_FORPIX').Value := Null;
      End;
    End
    Else
      cbxBcoFor.Enabled := False;
  End;
end;

procedure TfrmCadCtaPagar.pUtilizaRotinaProjeto;
begin
  pnlProjeto.Visible := fCfgSis('UTLPRJ', varBoolean);
end;

procedure TfrmCadCtaPagar.RetornaDataInicialFinalMovDet(out ADataInicial,
  ADataFinal: String);
  Var
    LConsulta: TUniQuery;
begin
  ADataInicial := '';
  ADataFinal := '';

  If FAutoIncremMovGer.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT ' +
                          '   MIN(DET_DTAENT) AS DATAINICIAL, ' +
                          '   MAX(DET_DTAENT) AS DATAFINAL ' +
                          'FROM MOVDET ' +
                          'WHERE DET_SEQGER="' + FAutoIncremMovGer + '"';

    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
    Begin
      If LConsulta.FieldByName('DATAINICIAL').AsDateTime > 0 Then
      Begin
        ADataInicial := FormatDateTime('dd/mm/yyyy', LConsulta.FieldByName('DATAINICIAL').AsDateTime);
        ADataFinal := FormatDateTime('dd/mm/yyyy', LConsulta.FieldByName('DATAFINAL').AsDateTime);
      End;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmCadCtaPagar.spbDicaTributoClick(Sender: TObject);
begin

  inherited;
  fMensagem('Informação sobre tributos', 'Os tributos ISS, IPTU e FGTS não são tratados no AUTBAN.', ['&Ok']);

end;

procedure TfrmCadCtaPagar.TravaAlteracaoDeCamposPrincipaisDaNotaDeEntrada;
begin

  If Not Trim(edtStatus.Text).Equals('FATURA') Then
    Exit;

  If Not fCfgSis('ALTNEP', varBoolean) Then
    Exit;

  dbeDtaCad.Enabled := False;
  dbeValDup.Enabled := False;
  fraPlanoDeContas.dbeCodCta.Enabled := False;
end;

function TfrmCadCtaPagar.ValidaValorBoleto(ASender: TObject): Boolean;
  Var
    fltValDup  : Double;
begin
  Result := True;
  fltValDup := 0;

  If Not (qryTabela.FieldByName('CTP_VALDUP').Value <> 0) Then
    Exit;

  If (Not fEmptyStr(dbeLinDig.Text)) Then
  Begin
    fltValDup := StrToFloat(Copy(dbeLinDig.Text, 38, 10)) / 100;
    If (fltValDup <> 0) Then
    Begin
      If fltValDup <> qryTabela.FieldByName('CTP_VALDUP').Value Then
        Result := False;
    End;
  End;

  If (Not fEmptyStr(dbeCodbar.Text)) And (Result) Then
  Begin
    fltValDup := StrToFloat(Copy(dbeCodbar.Text, 10, 10)) / 100;
    If (fltValDup <> 0)Then
    Begin
      If fltValDup <> qryTabela.FieldByName('CTP_VALDUP').Value Then
        Result := False;
    End;
  End;

  If Not Result Then
  Begin
    If Trim(TEdit(ASender).Name).Equals('dbeCodBar') Then
      fMensagem('ATENÇÃO!', 'O valor do código de barras ['+FloatToStrF(fltValDup, ffNumber, 12, 2)+']'+
                           ' não corresponde ao valor da duplicata ['+ FloatToStrF(qryTabela.FieldByName('CTP_VALDUP').AsFloat, ffNumber, 12, 2)+']. Verifique!', ['&O k'])
    Else
      fMensagem('ATENÇÃO!', 'O valor da linha digitável ['+FloatToStrF(fltValDup, ffNumber, 12, 2)+']'+
                           ' não corresponde ao valor da duplicata ['+ FloatToStrF(qryTabela.FieldByName('CTP_VALDUP').AsFloat, ffNumber, 12, 2)+']. Verifique!', ['&O k']);
  End;
end;


function TfrmCadCtaPagar.ValidaDataVencimentoBoleto(ASender: TObject): Boolean;
  Var
    strFatorVen: String;
    LMensagem: String;
    LPedirConfirmacao: Boolean;
begin
  Result := True;
  LPedirConfirmacao := True;

  If Not (qryTabela.FieldByName('CTP_VALDUP').Value <> 0) Then
    Exit;

  strFatorVen := CalcularFatorVencimento(qryTabela.FieldByName('CTP_DTAVEN').AsDateTime);

  If (Not fEmptyStr(dbeLinDig.Text)) Then
  Begin
    If (strFatorVen <> '0000') Then
    Begin
      If Copy(dbeLinDig.Text, 34, 4) <> '0000' Then
        If Copy(dbeLinDig.Text, 34, 4) <> strFatorVen Then
          Result := False;
    End;
  End;

  If (Not fEmptyStr(dbeCodbar.Text)) And (Result) Then
  Begin
    If (strFatorVen <> '0000') Then
    Begin
      If Copy(dbeCodbar.Text, 6, 4) <> '0000' Then
        If Copy(dbeCodbar.Text, 6, 4) <> strFatorVen Then
          Result := False;
    End;
  End;

  If Not Result Then
  Begin
    If Trim(TEdit(ASender).Name).Equals('dbeCodBar') Then
    Begin
      LPedirConfirmacao := PedirConfirmacaoDadosBoleto;
      FCodBarOld := TDBEditFocus(ASender).Text;
      LMensagem := 'A data de vencimento do código de barras'+
                   ' não corresponde a data de vencimento da duplicata ['+FormatDateTime('dd/mm/yyyy',qryTabela.FieldByName('CTP_DTAVEN').Value)+'].' +#13 + 'Deseja continuar mesmo assim?'
    End Else
    Begin
      LPedirConfirmacao := PedirConfirmacaoDadosBoleto;
      FLigDigOld := TDBEditFocus(ASender).Text;
      LMensagem := 'A data de vencimento da linha digitável'+
                   ' não corresponde a data de vencimento da duplicata ['+FormatDateTime('dd/mm/yyyy',qryTabela.FieldByName('CTP_DTAVEN').Value)+'].' +#13 + 'Deseja continuar mesmo assim?';
    End;
  End;

  If Not fEmptyStr(LMensagem) Then
  Begin
    Result := True;

    If LPedirConfirmacao Then
    Begin
      Result := (fMensagem('AVISO',LMensagem, ['&Sim', '&Não']) = 1);

      If Not Result Then
      Begin
        FCodBarOld := '';
        FLigDigOld := '';
      End;

    End;
  End;

end;

procedure TfrmCadCtaPagar.VisualizaComboGuiaTributos;
begin
  Try
    If (dbeTipDoc.Text = '2') Then
    Begin
      lblGuia.Visible := True;
      LcbGuiaTributo.Visible := True;
      LcbTipoTributo.Visible := True;
      spbDicaTributo.Visible := True;
      pHabilitaFields;

      if ((VarToStr(LcbGuiaTributo.KeyValue) = '') Or
          (LcbGuiaTributo.KeyValue <> 1) Or
          (LcbTipoTributo.KeyValue <> '2100')) And
         (qryTabela.FieldByName('CTP_DTAPAG').IsNull) And
         (qryTabela.State In [dsInsert, dsEdit]) then
        dbeValorOutrasEntidades.Text := '0,00';
    End
    Else
    Begin
      lblGuia.Visible         := False;
      LcbGuiaTributo.Visible  := False;
      LcbTipoTributo.Visible  := False;
      spbDicaTributo.Visible  := False;
      LcbGuiaTributo.KeyValue := -1;
      LcbTipoTributo.KeyValue := EmptyStr;
      lblValorOutrasEntidades.Enabled := False;
      dbeValorOutrasEntidades.Enabled := False;

      If (qryTabela.FieldByName('CTP_DTAPAG').IsNull) And
         (qryTabela.State In [dsInsert, dsEdit]) then
        dbeValorOutrasEntidades.Text := '0,00';
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[VisualizaComboGuiaTributos]');
    End;
  End;
end;

procedure TfrmCadCtaPagar.pCarregaDadosBaixa;
  Var
    strSQL    : String;
    qryGenPor : TUniQuery;
begin

  If fCfgSis('CTP_AS') = 'A' Then
  Begin
    btnListarPortadores.Visible := False;
    edtPorBai.Visible := True;
  End;

  qryGenPor := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CONCAT(G.CTP_PORBAI, " - ", P.POR_NOMPOR) AS PORBAI, ';
  strSQL := strSQL + '  G.CTP_CTABAI, G.CTP_SEQBAI, G.CTP_VALORI, G.CTP_DTAPAG, ';
  strSQL := strSQL + '  C.CTA_DESCTA, G.CTP_VALPAG, G.CTP_DOCBAI, G.CTP_HISBAI, ';
  strSQL := strSQL + '  CONCAT(G.CTP_OPEBAI, " - ", O.OPE_NOMOPE) AS OPEBAI ';
  strSQL := strSQL + 'FROM CADPAG G ';
  strSQL := strSQL + '  LEFT JOIN CADPOR P ON G.CTP_PORBAI = P.POR_CODPOR ';
  strSQL := strSQL + '  JOIN CADCTA C ON G.CTP_CTABAI = C.CTA_CODCTA ';
  strSQL := strSQL + '  JOIN CADOPE O ON G.CTP_OPEBAI = O.OPE_CODOPE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  G.CTP_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  G.CTP_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '  G.CTP_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  G.CTP_CODFOR = :CODFOR AND ';
  If (fEmptyStr(dbeSerie.Text)) Then
    strSQL := strSQL + '  ((G.CTP_SERIE_ IS NULL) OR (G.CTP_SERIE_ = "")) AND '
  Else
    strSQL := strSQL + '  G.CTP_SERIE_ = :SERIE_ AND ';
  strSQL := strSQL + '  G.CTP_SEQBAI = :SEQBAI ';

  With qryGenPor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDUP').AsString  := dbeNumDup.Text;
    ParamByName('PARCEL').AsString  := dbeParcel.Text;
    ParamByName('CODEMP').AsString  := dbeCodEmp.Text;
    ParamByName('CODFOR').AsString  := dbeCodFor.Text;
    If (Not fEmptyStr(dbeSerie.Text)) Then
      ParamByName('SERIE_').AsString  := dbeSerie.Text;
    ParamByName('SEQBAI').AsInteger := qryTabela.FieldByName('CTP_SEQBAI').AsInteger;
    Open;
  End;

  blnBaixada := fDuplicataCtpBaixada(dbeNumDup.Text,
                                     dbeParcel.Text,
                                     dbeCodEmp.Text,
                                     dbeCodFor.Text,
                                     dbeSerie.Text,
                                     qryTabela.FieldByName('CTP_SEQBAI').AsInteger);


  If blnBaixada Then
  Begin
    if qryTabela.State = dsBrowse then
      btnDocBaixa.Enabled  := True;

    If (fCfgSis('CTP_AS') = 'S') THEN
    Begin
      btnListarPortadores.Visible := True;
      edtPorBai.Visible := False;
    End
    Else
    Begin
      btnListarPortadores.Visible := False;
      edtPorBai.Visible := True;
    End;

    If qryGenPor.FieldByName('CTP_SEQBAI').AsInteger <= 0 Then
      edtTipBai.Text := 'Baixa Total'
    Else
      edtTipBai.Text := 'Baixa Parcial';

    If (Not qryGenPor.FieldByName('CTP_VALORI').IsNull)   And
       (qryGenPor.FieldByName('CTP_VALORI').AsFloat <> 0) Then
      edtValOri.Text := FloatToStrF(qryGenPor.FieldByName('CTP_VALORI').AsFloat, ffFixed, 12, 2)
    Else
      edtValOri.Clear;

    edtDtaPag.Text := qryGenPor.FieldByName('CTP_DTAPAG').AsString;

    If (Not qryGenPor.FieldByName('CTP_VALPAG').IsNull)   And
       (qryGenPor.FieldByName('CTP_VALPAG').AsFloat <> 0) Then
      edtValPag.Text := FloatToStrF(qryGenPor.FieldByName('CTP_VALPAG').AsFloat, ffFixed, 12, 2)
    Else
      edtValPag.Clear;

    edtDocBai.Text := qryGenPor.FieldByName('CTP_DOCBAI').AsString;
    edtPorBai.Text := qryGenPor.FieldByName('PORBAI').AsString;
    edtDesCtaBai.Text := qryGenPor.FieldByName('CTA_DESCTA').AsString;
    edtHisBai.Text := qryGenPor.FieldByName('CTP_HISBAI').AsString;
    edtOpeBai.Text := qryGenPor.FieldByName('OPEBAI').AsString;

    If blnBaixada Then
      edtSeqBai.Text := qryGenPor.FieldByName('CTP_SEQBAI').AsString
    Else
      edtSeqBai.Text := '';

    qryGenPor.Close;
  End
  Else
  Begin
    btnListarPortadores.Visible := False;
    edtPorBai.Visible:= True;
    edtTipBai.Clear;
    edtValOri.Clear;
    edtSeqBai.Clear;
    edtOpeBai.Clear;
    edtHisBai.Clear;
    edtDesCtaBai.Clear;
    edtPorBai.Clear;
    edtDocBai.Clear;
    edtValPag.Clear;
    edtDtaPag.Clear;
    edtValOri.Clear;
    edtTipBai.Clear;
    edtPorBai.Clear;
  End;

  btnDetalharValoresBaixa.Enabled := blnBaixada;

  {*****************************************}
  {* HABILITA / DESABILITA OS EDITS        *}
  {**************************************MV*}
  If (qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit) Then
  Begin
    pEnabled(Self, Not blnBaixada);
  End;

  dbeCtaBai.Enabled := False;
  {If blnBaixada Then
    dbeCtaBai.Enabled := True
  else
    dbeCtaBai.Enabled := False;}

  FreeAndNil(qryGenPor);

end;

procedure TfrmCadCtaPagar.pCarregaDadosBancariosFornecedor(strCodFor: String);
Var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;

  Try
    cbxBcoFor.Clear;
    lstBcoFor.Clear;

    qryGen.SQL.Text := getSQLDadosBancariosFornecedor(True);
    qryGen.ParamByName('CODFOR').AsString := strCodFor;
    qryGen.Open;

    While Not qryGen.Eof Do
    Begin
      cbxBcoFor.Items.Add(qryGen.FieldByName('DESC_CONTA').AsString);

      If qryGen.FieldByName('TIPO_CONTA').AsString <> 'PIX' Then
        lstBcoFor.Add(qryGen.FieldByName('AUTOINCREM').AsString)
      Else
        lstBcoFor.Add('PIX' + qryGen.FieldByName('AUTOINCREM').AsString);

      qryGen.Next;
    End;

    qryGen.Close;
  Finally
    PosicionaContaFornecedor;

    pTrataBcoFor;
    FreeAndNil(qryGen);
  End;

end;

procedure TfrmCadCtaPagar.btnCancelaClick(Sender: TObject);
begin

  edtProvisao.text := '';

  inherited;
  blnAlterandoChave    := False;
  btnBaixarDup.Enabled := True;
  btnHistPagam.Enabled := True;
  blnTravarDes         := False;
  blnTravarAlt         := False;
  btnDocBaixa.Enabled  := True;
  LcbGuiaTributo.Enabled := False;
  LcbTipoTributo.Enabled := False;
  pDesabilitaFields;
  pCarregaDadosAdicionais;
  pCalculaValorTotal;

  pCriaClientTemporariaCtpDet(dbeNumDup.Text, dbeParcel.Text, dbeSerie.Text, dbeCodEmp.Text, dbeCodFor.Text, FDatasetCtpDet, FDatasetCtpDetClone);
  
  VisualizaComboGuiaTributos;

  if (VarToStr(LcbGuiaTributo.KeyValue) <> '') And
     (LcbGuiaTributo.KeyValue > 0) then
    CarregaGuiasETributos(True);

  pCarregaDadosBancariosFornecedor(qryTabela.FieldByName('CTP_CODFOR').AsString);

  FValidaCorrespondenteContabil.LimparListas;
  FValidaCorrespondenteContabil.AddPortadorValidado(dbeCodPor.Text);
  FValidaCorrespondenteContabil.AddPlanoDeContasValidado(fraPlanoDeContas.dbeCodCta.Text);

  VerificaSeStatusFatura(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                         qryTabela.FieldByName('CTP_CODEMP').AsString,
                         qryTabela.FieldByName('CTP_CODFOR').AsString,
                         qryTabela.FieldByName('CTP_SERIE_').AsString);

  CarregaNumeroPedidoCompra(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                            qryTabela.FieldByName('CTP_CODEMP').AsString,
                            qryTabela.FieldByName('CTP_CODFOR').AsString,
                            qryTabela.FieldByName('CTP_SERIE_').AsString,
                            qryTabela.FieldByName('CTP_PARCEL').AsString,
                            qryTabela.FieldByName('CTP_SEQBAI').AsInteger);

  btnReinf.enabled := Not VerificaSeDuplicataTemCadFis(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                                                       qryTabela.FieldByName('CTP_CODEMP').AsString,
                                                       qryTabela.FieldByName('CTP_CODFOR').AsString,
                                                       qryTabela.FieldByName('CTP_SERIE_').AsString);

  pAtualizaCorBotaoREINF(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                         qryTabela.FieldByName('CTP_PARCEL').AsString,
                         qryTabela.FieldByName('CTP_SERIE_').AsString,
                         qryTabela.FieldByName('CTP_CODEMP').AsString,
                         qryTabela.FieldByName('CTP_CODFOR').AsString,
                         qryTabela.FieldByName('CTP_SEQBAI').AsInteger);
end;

function TfrmCadCtaPagar.fCarregaDuplicata(ARotinaLiberacao: Boolean = False): Boolean;
begin
  Result := True;

  If Not ARotinaLiberacao Then
  Begin
    If Not fLock_Unlock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString, True, False) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esta duplicata está sendo utilizada por outra estação: ' + fGetHostLock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString), ['&Ok']);

      qryTabela.SQL.Clear;
      qryTabela.SQL.Add('SELECT * FROM ' + strNomeTabela + ' WHERE FALSE');
      qryTabela.Open;

      Result := False;
      pLimparEdits;
      Exit;
    End
    ELSE
    begin
      blnDupTravada       := True;
      strAutoincremLckAtc := qryTabela.FieldByName('AUTOINCREM').AsString;
    end;
  End;

  If (btnAlterar.Enabled) Then
  Begin
    If (btnAlterar.Visible) Then
      pSetFocus(btnAlterar);
  End;

  pCarregaDadosBancariosFornecedor(qryTabela.FieldByName('CTP_CODFOR').AsString);

  pCarregaDadosAdicionais;
  pCalculaValorTotal;
  CarregaGuiasETributos(True);
  pTrataBcoFor;
  pCriaClientTemporariaCtpDet(dbeNumDup.Text, dbeParcel.Text, dbeSerie.Text, dbeCodEmp.Text, dbeCodFor.Text, FDatasetCtpDet, FDatasetCtpDetClone);
  AValorTotalInicial   := fStrToFloat(edtValTot.Text);
  ADataCadastroInicial := qryTabela.FieldByName('CTP_DTACAD').AsDateTime;
  AEmpresaInicial      := dbeCodEmp.Text;

end;

function TfrmCadCtaPagar.fTemAlteracao: Boolean;
var
  I: Integer;
begin

  for I := 0 to Pred(qryTabela.Fields.Count) do
  begin
    if qryTabela.Fields[I].OldValue <>
        qryTabela.Fields[I].NewValue then
          Exit(True);
  end;

  Result := False;

end;

function TfrmCadCtaPagar.fCtpExisteDupDependentes(strNumDup, strParcel, strSerie,
  strCodEmp, strCodFor: String): Boolean;
  Var
    qryGenDup: TUniQuery;
Begin
  qryGenDup := fCriaQuery(Nil);

  With qryGenDup Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  COUNT(*) AS QTD ');
    SQL.Add('FROM ');
    SQL.Add('  CADPAG ');
    SQL.Add('WHERE ');
    SQL.Add('  CTP_NUMDUP = :NUMDUP AND ');
    SQL.Add('  CTP_PARCEL = :PARCEL AND ');
    SQL.Add('  CTP_SERIE_ = :SERIE_ AND ');
    SQL.Add('  CTP_CODEMP = :CODEMP AND ');
    SQL.Add('  CTP_CODFOR = :CODFOR AND ');
    SQL.Add('  CTP_SEQBAI > 0 ');

    ParamByName('NUMDUP').AsString  := strNumDup;
    ParamByName('PARCEL').AsString  := strParcel;
    ParamByName('SERIE_').AsString  := strSerie;
    ParamByName('CODEMP').AsString  := strCodEmp;
    ParamByName('CODFOR').AsString  := strCodFor;
    Open;


    Result := (FieldByName('QTD').AsInteger) > 0;

    Close;

  End;

  FreeAndNil(qryGenDup);
End;

function TfrmCadCtaPagar.fDigSenVarDuplicataContabilizada: BOolean;
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('A DUPLICATA JA ESTÁ CONTABILIZADA');
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddTextoCaption('Plano de contas anterior'         , strCtaAut + '-' + fRetNomeConta(strCtaAut));
  objLiberacao.objMsgLibera.pAddTextoCaption('Documento'                        , IfThen(fEmptyStr(dbeNumDup.Text)
                                                                                         , ''
                                                                                         ,dbeNumDup.Text + '-' +
                                                                                          dbeParcel.Text +
                                                                                          IfThen(fEmptyStr(dbeSerie.Text)
                                                                                                 , ''
                                                                                                 , '-' + dbeSerie.Text) +
                                                                                          IfThen(fEmptyStr(dbeCodEmp.Text)
                                                                                                 , ''
                                                                                                 , '-' + dbeCodEmp.Text)
                                                                                        ));
  objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor'                       , dbeCodFor.Text + '-' + edtNomFor.Text);
  objLiberacao.objMsgLibera.pAddTextoCaption('Data de cadastro'                 , dbeDtaCad.Text);
  objLiberacao.objMsgLibera.pAddTextoCaption('Data de vencimento'               , dbeDtaVen.Text);
  objLiberacao.objMsgLibera.pAddTextoCaption('Valor'                            , dbeValDup.Text);
  objLiberacao.objMsgLibera.pAddTextoCaption('Alterando para o plano de contas' , fraPlanoDeContas.dbeCodCta.Text + '-' + fraPlanoDeContas.edtDesCta.Text);
  objLiberacao.strDirAce := 'PALTDUPCON';
  objLiberacao.strMsgSen := 'Permitir alterar plano de contas de duplicatas contabilizada';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;
  Result := objLiberacao.fLibera;

  If Result Then
    blnValPlanoCusto := True;
end;

function TfrmCadCtaPagar.fDuplicataPossuiMovGer: Boolean;
var
  strEspDoc: String;
begin
  If fEmptyStr(dbeNumDup.Text) Then
  Begin
    Result := False;
    Exit;
  End;

  Result := fDuplicataPossuiMovGer(dbeCodFor.Text, dbeNumDup.Text, dbeSerie.Text, dbeCodEmp.Text, strEspDoc, False);
end;

function TfrmCadCtaPagar.ImportarCtaPagar(pgbStatus: TcxProgressBar): Boolean;
const
  cstMensagem : String = 'Importação finalizada!' + sLineBreak + sLineBreak +
                         'Registros Importados com Sucesso: %d ' + sLineBreak +
                         'Registros Importados com Erro: %d ' + sLineBreak +
                         'Registros já Importados anteriormente: %d ';
var
  LIntegracao : TIntegracaoTicketLog;
  LResultadoIntegracao : TRetornoIntegracao;
  LQuery : TUniquery;
begin
  Result := False;

  LIntegracao := TIntegracaoTicketLog.Create;
  try
    try
      if not LIntegracao.ImportarArquivo(FArquivoIntegracao) Then
      begin
        pMensagemOk('Não foi possivel concluir a importação, verifique o arquivo e tente novamente.');
        Exit;
      end;

      if not LIntegracao.ProcessarArquivo Then
      begin
        pMensagemOk('Não foi possivel concluir o processamento dos registros, verifique o arquivo e tente novamente.');
        Exit;
      end;

      LQuery := fCriaQuery(Self);
      try
        LResultadoIntegracao := LIntegracao.LancarTitulosContasPagar(LQuery);
      finally
        if Assigned(LQuery) Then
          FreeAndNil(LQuery);
      end;

      pMensagemOk(Format(cstMensagem, [LResultadoIntegracao.QuantidadeRegistrosInseridos,
                                       LResultadoIntegracao.QuantidadeRegistrosComErro,
                                       LResultadoIntegracao.QuantidadeRegistrosIgnorados]));

      Result := LResultadoIntegracao.ConcluidoComSucesso;

      if LResultadoIntegracao.QuantidadeRegistrosInseridos > 0 then
      begin
        if fMensagem('', 'Gostaria de realizar agora a baixa dos títulos importados?', ['&Sim', '&Não']) = 1 then
        begin
            LIntegracao.BaixarTitulosImportados;
        end;
      end;

    except on E: Exception do
      begin
        pMensagemOk('Não foi possivel concluir a operação, verifique o arquivo e tente novamente.' + sLineBreak +
                    'Erro Original: ' + E.Message);
      end;
    end;
  finally
    if Assigned(LIntegracao) then
      FreeAndNil(LIntegracao);

    FArquivoIntegracao := EmptyStr;
  end;
end;

function TfrmCadCtaPagar.fIsGNRE: Boolean;
  Var
    strSQL   : String;
    qryCtpGNRE: TUniQuery;
begin
  Result := False;
  Try
    qryCtpGNRE := fCriaQuery(Self);

    strSQL := 'SELECT COUNT(*) AS NREC'+
      ' FROM CADPAG C'+
      ' JOIN LOGCTP L' +
      ' ON L.CTP_NUMDUP = C.CTP_NUMDUP AND L.CTP_PARCEL = C.CTP_PARCEL'+
      ' AND L.CTP_SERIE_ = C.CTP_SERIE_ AND L.CTP_CODEMP = C.CTP_CODEMP'+
      ' AND L.CTP_CODFOR = C.CTP_CODFOR'+
      ' WHERE C.CTP_NUMDUP = :NUMDUP'+
      ' AND C.CTP_PARCEL = :PARCEL'+
      ' AND C.CTP_SERIE_ = :SERIE_'+
      ' AND C.CTP_CODEMP = :CODEMP'+
      ' AND C.CTP_CODFOR = :CODFOR'+
      ' AND L.CTP_DESCRI LIKE ''%GNRE%''';

    Application.ProcessMessages;

    With qryCtpGNRE Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := qryTabela.FieldByName('CTP_NUMDUP').AsString;
      ParamByName('PARCEL').AsString := qryTabela.FieldByName('CTP_PARCEL').AsString;
      ParamByName('SERIE_').AsString := qryTabela.FieldByName('CTP_SERIE_').AsString;
      ParamByName('CODEMP').AsString := qryTabela.FieldByName('CTP_CODEMP').AsString;
      ParamByName('CODFOR').AsString := qryTabela.FieldByName('CTP_CODFOR').AsString;
      Open;

      If FieldByName('NREC').AsInteger > 0 Then
        Result := True
      Else
        Result := False;
      Close;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;

  Application.ProcessMessages;
  FreeAndNil(qryCtpGNRE);
end;

procedure TfrmCadCtaPagar.btnEspelhoNotaFiscalClick(Sender: TObject);
var
  frmRelEspNotaEnt: TfrmRelEspNotaEnt;
  strEspDoc: String;

  LDataInicial,
  LDataFinal: String;
begin
  inherited;

  If Not fDuplicataPossuiMovGer(dbeCodFor.Text, dbeNumDup.Text, dbeSerie.Text, dbeCodEmp.Text, strEspDoc, False) Then
  Begin
    fMensagem('Aviso', 'A duplicata selecionada não está vinculada a nenhuma nota fiscal de entrada!',['&O K']);
    Exit;
  End;

  RetornaDataInicialFinalMovDet(LDataInicial, LDataFinal);
  If LDataInicial.IsEmpty Then
  Begin
    LDataInicial := dbeDtaCad.Text;
    LDataFinal := dbeDtaCad.Text;
  End;

  if not fCfgSis('ENTEDI', varBoolean) then
  begin
    Try
      pCriarFormularios(TfrmRelEspNotaEnt, frmRelEspNotaEnt);
      frmRelEspNotaEnt.mskDtaIni.Text        := LDataInicial;
      frmRelEspNotaEnt.mskDtaFin.Text        := LDataFinal;
      frmRelEspNotaEnt.edtCodFornecedor.Text := dbeCodFor.Text;
      frmRelEspNotaEnt.edtDocumento.Text     := dbeNumDup.Text;
      frmRelEspNotaEnt.edtEspecie.Text       := strEspDoc;
      frmRelEspNotaEnt.edtSerie.Text         := dbeSerie.Text;
      frmRelEspNotaEnt.edtCodEmpresa.Text    := dbeCodEmp.Text;
      frmRelEspNotaEnt.pVerNotaFiscal;
    Finally
      FreeAndNil(frmRelEspNotaEnt);
    End;
  end
  else
  begin
    if Assigned(prcExecutaRelatorio) then
      prcExecutaRelatorio(154,
                          5814,
                          [5814],
                          ['DTAINI', 'DTAFIN', 'CODFOR', 'NUMDOC', 'ESPDOC', 'SERIE_', 'CODEMP'],
                          [LDataInicial, LDataFinal, dbeCodFor.Text, dbeNumDup.Text, strEspDoc, dbeSerie.Text, dbeCodEmp.Text],
                          Sender,
                          nil,
                          True);
  end;
end;

procedure TfrmCadCtaPagar.btnEstornoClick(Sender: TObject);
  Var
    frmEstornoPagar: TfrmEstornoPagar;
begin
  inherited;
  If (btnEstorno.Visible) And (btnEstorno.Enabled) And
     (Not qryTabela.IsEmpty) Then
  Begin
    Try
      pCriarFormularios(TfrmEstornoPagar, frmEstornoPagar);
      frmEstornoPagar.edtNumDup.Text := qryTabela.FieldByName('CTP_NUMDUP').AsString;
      frmEstornoPagar.edtParcel.Text := qryTabela.FieldByName('CTP_PARCEL').AsString;
      frmEstornoPagar.edtSerie.Text  := qryTabela.FieldByName('CTP_SERIE_').AsString;
      frmEstornoPagar.edtCodFor.Text := qryTabela.FieldByName('CTP_CODFOR').AsString;
      frmEstornoPagar.edtNomFor.Text := fRetNomFornecedor(qryTabela.FieldByName('CTP_CODFOR').AsString);
      frmEstornoPagar.edtCodEmp.Text := qryTabela.FieldByName('CTP_CODEMP').AsString;
      frmEstornoPagar.edtNomEmp.Text := fRetNomeEmpresaSelec(qryTabela.FieldByName('CTP_CODEMP').AsString);
      frmEstornoPagar.ShowModal;
      qryTabela.Refresh;
      pCarregaCompetencia;
      pCarregaDadosAdicionais;

      pHabilitaFields;
      pCalculaValorTotal;

      If qryTabela.IsEmpty Then
      Begin
        LcbGuiaTributo.KeyValue := -1;
        LcbTipoTributo.KeyValue := EmptyStr;
      End;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadCtaPagar.btnEstornoClick]');
    End;
    pFreeAndNil(frmEstornoPagar);
  End;
end;

procedure TfrmCadCtaPagar.btnExcluirAutClick(Sender: TObject);
  Var
    frmExclusaoAutCtaPagar : TfrmExclusaoAutCtaPagar;
    strAutoincrem: String;
begin
  If qryTabela.IsEmpty Then
    Exit;

  If Not ExcluirDuplicataGeradaDeKMRodados(qryTabela.FieldByName('CTP_NUMDUP').AsString + '-' +
                                           qryTabela.FieldByName('CTP_PARCEL').AsString + '-' +
                                           qryTabela.FieldByName('CTP_CODEMP').AsString + '-' +
                                           qryTabela.FieldByName('CTP_CODFOR').AsString + '-' +
                                           qryTabela.FieldByName('CTP_SERIE_').AsString,
                                           qryTabela.FieldByname('CTP_SEQBAI').AsInteger) Then
    Exit;

  fLock_Unlock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString, False);
  strAutoincrem  := qryTabela.FieldByName('AUTOINCREM').AsString;

  Try
    Try
      pCriarFormularios(TfrmExclusaoAutCtaPagar, frmExclusaoAutCtaPagar);
      frmExclusaoAutCtaPagar.strNumDup := qryTabela.FieldByName('CTP_NUMDUP').AsString;
      frmExclusaoAutCtaPagar.strCodEmp := qryTabela.FieldByName('CTP_CODEMP').AsString;
      frmExclusaoAutCtaPagar.strCodFor := qryTabela.FieldByName('CTP_CODFOR').AsString;
      frmExclusaoAutCtaPagar.pAtualizaTemporaria;
      If Not frmExclusaoAutCtaPagar.blnIsEmpty Then
        frmExclusaoAutCtaPagar.ShowModal;
    except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadCtaPagar.btnExcluirAutClick]');
    end;
  Finally
    pFreeAndNil(frmExclusaoAutCtaPagar);
  End;

  FreeAndNil(qryTabela);
  qryTabela           := fCriarQuery('SELECT * FROM CADPAG WHERE AUTOINCREM = ' + QuotedStr(strAutoincrem)+ ' ', Self);
  qryTabela.AfterOpen := pAfterOpen;
  dtsTabela.DataSet   := qryTabela;
  qryTabela.Open;

  If qryTabela.IsEmpty Then
  Begin
    pLimparEdits;
    Exit;
  End;

    {***************************************************************************************************************}
    {* SE A DUPLICATA FOR BAIXADA, E, ANTES DA TELA DE BAIXA FOR FECHADA OUTRA ESTAÇÃO CARREGAR A MESMA DUPLICATA, *}
    {* O SISTEMA DEVE FICAR VERIFICANDO QUANDO A DUPLICATA ESTIVER SIDO LIBERADA PARA ASSIM SEGUIR. ****************}
    {* POR ISSO O PARÂMENTRO blnLoopTravamento ESTÁ TRUE ***********************************************************}
    {***************************************************************************************************************}
  If Not fLock_Unlock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString, True, False) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esta duplicata está sendo utilizada por outra estação: ' + fGetHostLock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString), ['&Ok']);

    qryTabela             := fCriarQuery('SELECT * FROM CADPAG WHERE FALSE', Self);
    qryTabela.AfterOpen   := pAfterOpen;
    qryTabela.AfterScroll := pAfterScroll;
    dtsTabela.DataSet := qryTabela;
    pLimparEdits;
    Exit;
  End;

  fCarregaDuplicata(True);

  pHabilitaFields;
  VisualizaComboGuiaTributos;
  LcbGuiaTributo.Enabled := False;
  LcbTipoTributo.Enabled := False;
  pCarregaEventos;
  pCarregaProjeto;
  VerificaSeStatusFatura(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                         qryTabela.FieldByName('CTP_CODEMP').AsString,
                         qryTabela.FieldByName('CTP_CODFOR').AsString,
                         qryTabela.FieldByName('CTP_SERIE_').AsString);

  CarregaNumeroPedidoCompra(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                            qryTabela.FieldByName('CTP_CODEMP').AsString,
                            qryTabela.FieldByName('CTP_CODFOR').AsString,
                            qryTabela.FieldByName('CTP_SERIE_').AsString,
                            qryTabela.FieldByName('CTP_PARCEL').AsString,
                            qryTabela.FieldByName('CTP_SEQBAI').AsInteger);

  btnReinf.enabled := Not VerificaSeDuplicataTemCadFis(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                                                       qryTabela.FieldByName('CTP_CODEMP').AsString,
                                                       qryTabela.FieldByName('CTP_CODFOR').AsString,
                                                       qryTabela.FieldByName('CTP_SERIE_').AsString);

  pAtualizaCorBotaoREINF(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                         qryTabela.FieldByName('CTP_PARCEL').AsString,
                         qryTabela.FieldByName('CTP_SERIE_').AsString,
                         qryTabela.FieldByName('CTP_CODEMP').AsString,
                         qryTabela.FieldByName('CTP_CODFOR').AsString,
                         qryTabela.FieldByName('CTP_SEQBAI').AsInteger);
end;

procedure TfrmCadCtaPagar.btnExcluirClick(Sender: TObject);
  Var
    blnPodeExcluir: Boolean;
    sumValDup,
    sumValJur,
    sumValMul,
    sumValDes,
    sumValTot     : Double;
    strSenha,
    strNumDup,
    strParcel,
    strSerie,
    strCodEmp,
    strCodFor,
    strCTPCom,
    strChaveLck: String;
    blnRatEve: Boolean;

    LAutoIncremDuplicata: String;
    strAutInc: String;
    
    function fLiberacaoApagarDuplicata: Boolean;
              {*************************}
              {**  EXCLUIR DUPLICATA  **}
              {**********************RG*}
    Begin
      Result := False;

      If (fEmptyStr(fCfgSis('SEXCTP'))) Then
      Begin
        Result := True;
        Exit;
      End;


      If ((fCfgSis('SENFVU') = 'F')) Then
      Begin
        If ffrmSenha(strSenha) Then
        Begin
          If strSenha = fCfgSis('SEXCTP') Then
          Begin
            Result := True;
          End
          Else
            fMensagem('','Senha incorreta!',['&OK']);
        End;
      End;


      If (fCfgSis('SENFVU') <> 'F') Then
      Begin
        With qryTabela Do
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('EXCLUSÃO DE DUPLICATAS - CONTAS A PAGAR');
          objLiberacao.objMsgLibera.pAddSeparador(85);

          If Not fEmptyStr(fCfgSis('SEXCTP')) Then
          begin
            objLiberacao.objMsgLibera.pAddTexto('DADOS DE EXCLUSÃO - DUPLICATAS', alCentro, teAmbos, '', 85);
            objLiberacao.objMsgLibera.pAddSeparador(85);
          end;

          objLiberacao.objMsgLibera.pAddTextoCaption('DOCUMENTO'       , fPadR(FieldByName('CTP_NUMDUP').AsString, 12) + dbeParcel.Text + ' - ' + dbeSerie.Text , 15);
          objLiberacao.objMsgLibera.pAddTextoCaption('EMPRESA'         , FieldByName('CTP_CODEMP').AsString + ' - ' + edtNomEmp.Text                            , 15);
          objLiberacao.objMsgLibera.pAddTextoCaption('FORNECEDOR'      , fPadR(FieldByName('CTP_CODFOR').AsString, 8) + ' - ' + edtNomFor.Text                  , 15);
          objLiberacao.objMsgLibera.pAddTextoCaption('DATA CADASTRO'   , FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTACAD').AsDateTime)                     , 15);
          objLiberacao.objMsgLibera.pAddTextoCaption('DATA VENCIMENTO' , FormatDateTime('dd/mm/yyyy', FieldByName('CTP_DTAVEN').AsDateTime)                     , 15);
          objLiberacao.objMsgLibera.pAddTextoCaption('VALOR DUPLICATA' , FloatToStrF(FieldByName('CTP_VALDUP').AsFloat, ffNumber, 12, 2)                        , 15);
          objLiberacao.objMsgLibera.pAddTextoCaption('DESCONTO'        , FloatToStrF(FieldByName('CTP_DESSUJ').AsFloat, ffNumber, 12, 2)                        , 15);
          objLiberacao.objMsgLibera.pAddTextoCaption('JUROS'           , FloatToStrF(FieldByName('CTP_JURSUJ').AsFloat, ffNumber, 12, 2)                        , 15);
          objLiberacao.objMsgLibera.pAddTextoCaption('MULTA'           , FloatToStrF(FieldByName('CTP_MULSUJ').AsFloat, ffNumber, 12, 2)                        , 15);
          objLiberacao.objMsgLibera.pAddSeparador(85);

          sumValDup := FieldByName('CTP_VALDUP').AsFloat;
          sumValJur := FieldByName('CTP_JURSUJ').AsFloat;
          sumValDes := FieldByName('CTP_DESSUJ').AsFloat;
          sumValMul := FieldByName('CTP_MULSUJ').AsFloat;
          sumValTot := sumValDup + sumValJur + sumValMul - sumValDes;

          objLiberacao.objMsgLibera.pAddTextoCaption('TOTAL', FloatToStrF(sumValTot, ffNumber, 9, 2) , 15, alDireita, teAmbos, '', 85);
          objLiberacao.objMsgLibera.pAddSeparador(85);
        End;

        objLiberacao.strDirAce := 'CTPEXCDUP';
        objLiberacao.strSenLib := fCfgSis('SEXCTP');
        objLiberacao.strMsgSen := 'Excluir Duplicata';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCodDig := strLoginUsuarioLogado;
        objLiberacao.tipCliFor := cfFornecedor;

        If objLiberacao.fLibera Then
        Begin
          Result := True;
        End;
      End;
    End;
begin

  strNumDup := dbeNumDup.Text;
  strParcel := dbeParcel.Text;
  strSerie  := dbeSerie.Text;
  strCodEmp := dbeCodEmp.Text;
  strCodFor := dbeCodFor.Text;

  strSenha := '';
  blnPodeExcluir := True;
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  blnExcluiu := False;
  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If fIsGNRE Then
  Begin
    fMensagem('AVISO', 'A duplicata refere-se a uma GUIA GNRE e não poderá ser'+
              ' excluída pelo contas a pagar!', ['&Ok']);
    Exit;
  End;

  {****************************************************}
  {* CASO SEQBAI = 0, VERIFICA SE HÁ DUPS DEPENDENTES *}
  {* CASO EXISTA BLOQUEIA A EXCLUSÃO                  *}
  {**********************************************AJ*JB*}
  If (qryTabela.FieldByName('CTP_SEQBAI').AsInteger = 0)                      And
     (fCtpExisteDupDependentes(strNumDup,
                               strParcel,
                               strSerie,
                               strCodEmp,
                               strCodFor)) Then
  Begin
    fMensagem('','A duplicata não pode ser excluída, pois existem duplicatas dependentes.' +
                 ' É necessário estornar as duplicatas dependentes!',['&OK']);
    Exit;
  End;

  If fDuplicataCtpBaixada(dbeNumDup.Text,
                          dbeParcel.Text,
                          dbeCodEmp.Text,
                          dbeCodFor.Text,
                          dbeSerie.Text,
                          qryTabela.FieldByName('CTP_SEQBAI').AsInteger) Then
  Begin
    fMensagem('ATENÇÃO','A duplicata não pode ser excluída pois está baixada.' + #13 +
                        'Recarregue a duplicata para atualizar seus dados.',['&OK']);

    Exit;
  End;

  If fCfgSis('UTICON', varBoolean) Then
  Begin
    If IncluidoPeloLivroFiscal(strNumDup,
                               strParcel,
                               strSerie,
                               strCodEmp,
                               strCodFor) Then
    Begin
      fMensagem('AVISO', 'A duplicata foi originada no Livro Fiscal e a empresa está configurada para utilização do módulo de Contabilidade.' + #13 +
                         'A exclusão deverá ser realizada diretamente no Livro Fiscal.', ['&Ok']);

      Exit;
    End;
  End;

  //FECHAMENTO FINANCEIRO
  if objFechamento.FechamentoFinanceiroJaRealizado(qryTabela.FieldByName('CTP_CODEMP').AsString, qryTabela.FieldByName('CTP_DTACAD').AsDateTime) then
    Exit;

  If Not ExcluirDuplicataGeradaDeKMRodados(strNumDup + '-' +
                                           strParcel + '-' +
                                           strCodEmp + '-' +
                                           strCodFor + '-' +
                                           strSerie,
                                           qryTabela.FieldByname('CTP_SEQBAI').AsInteger) Then
    Exit;

  {*****************************************}
  {* FAZ VALIDAÇÕES SOBRE A EMPRESA GEREN- *}
  {* CIAL                                  *}
  {**************************************MV*}
  If Not (fCfgSis('EMPGER', varBoolean)) Then
  Begin
    If (Not fEmptyStr(dbeCodEmp.Text)) Then
    Begin
      If dbeCodEmp.Text = VS_strCodEmp Then
        blnPodeExcluir := True
      Else
        blnPodeExcluir := False;
    End;
  End;

  {*****************************************}
  {* CASO SEJA EMPRESA GERENCIAL, OU SEJA  *}
  {* UMA DUPLICATA DA PROPRIA LOJA, PODE   *}
  {* EXCLUIR                               *}
  {**************************************MV*}

  If ((blnPodeExcluir) And (fLiberacaoApagarDuplicata)) Then
  Begin
    LAutoIncremDuplicata := qryTabela.FieldByName('AUTOINCREM').AsString;

    strCTPCom := qryTabela.FieldByName('CTP_CTPCOM').AsString;

    strChaveLck := strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString;

    inherited btnExcluirClick(Sender);
    If blnExcluiu Then
    Begin
      {*** LOGCTP GRAVA NO PAICAD ***}

      // Limpa CTPCom de todas tabelas
      If Not fEmptyStr(strCTPCom) Then
        pLimpaCTPCom(strCTPCom);

      ExcluirDuplicataGeradaDeKMRodados(strNumDup + '-' +
                                        strParcel + '-' +
                                        strCodEmp + '-' +
                                        strCodFor + '-' +
                                        strSerie,
                                        qryTabela.FieldByname('CTP_SEQBAI').AsInteger,
                                        True);

      {*****************************************}
      {* CASO HAJA ALGUM CTPDET, EXCLUI DA TA- *}
      {* BELA REAL                             *}
      {**************************************MV*}
      If fVerificaCtpDet(strNumDup, strParcel, strSerie, strCodEmp, strCodFor, blnRatEve) Then
      Begin
        pDeletaCtpDet(strNumDup, strParcel, strSerie, strCodEmp, strCodFor);
      End;

      {*****************************************}
      {* CASO HAJA ALGUM RNFCTP, EXCLUI DA TA- *}
      {* BELA REAL - DADOS REIMP               *}
      {*****************************************}
      If fVerificaReinfCtp(strNumDup, strParcel, strSerie, strCodEmp, strCodFor, qryTabela.FieldByname('CTP_SEQBAI').AsInteger, strAutInc) Then
      Begin
        DeletaDadosREINF(strAutInc);
      End;

      untCadPag.ApagaDuplicataRETDDA(LAutoIncremDuplicata);

      fLock_Unlock(strChaveLck, False);
      fCommit;
    End
    Else
      fRollBack;

    pCarregaCompetencia;
    pCarregaDadosAdicionais;
    pCriaClientTemporariaCtpDet(dbeNumDup.Text, dbeParcel.Text, dbeSerie.Text, dbeCodEmp.Text, dbeCodFor.Text, FDatasetCtpDet, FDatasetCtpDetClone);
    pCalculaValorTotal;
    btnReinf.Font.Color := clblack;
  End;

  if Not fEmptyStr(strAutoIncrem) then
  begin
    btnSair.Click;
    Exit;
  end;

  If not blnPodeExcluir Then
    fMensagem('ATENÇÃO!', 'Uma Loja Filial só pode Excluir Duplicatas por ela Gerada!', ['&O k']);
end;

procedure TfrmCadCtaPagar.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    If FindField('CTP_CODCTA') <> nil Then
      TStringField(FieldByName('CTP_CODCTA')).EditMask := '99.99.999;0;_';

    If FindField('CTP_DTACAD') <> nil Then
      TDateField(FieldByName('CTP_DTACAD')).EditMask := '99/99/9999';

    If FindField('CTP_DTAVEN') <> nil Then
      TDateField(FieldByName('CTP_DTAVEN')).EditMask := '99/99/9999';

    If FindField('CTP_VALDUP') <> nil Then
      TFloatField(FieldByName('CTP_VALDUP')).DisplayFormat := '#,##0.00';

    If FindField('CTP_VALORI') <> nil Then
      TFloatField(FieldByName('CTP_VALORI')).DisplayFormat := '#,##0.00';

    If FindField('CTP_DTAPAG') <> nil Then
      TDateField(FieldByName('CTP_DTAPAG')).EditMask := '99/99/9999';

    If FindField('CTP_VALPAG') <> nil Then
      TFloatField(FieldByName('CTP_VALPAG')).DisplayFormat := '#,##0.00';

    If FindField('CTP_VALJUR') <> nil Then
      TFloatField(FieldByName('CTP_VALJUR')).DisplayFormat := '#,##0.00';

    If FindField('CTP_VALDES') <> nil Then
      TFloatField(FieldByName('CTP_VALDES')).DisplayFormat := '#,##0.00';

    If FindField('CTP_DESSUJ') <> nil Then
      TFloatField(FieldByName('CTP_DESSUJ')).DisplayFormat := '#,##0.00';

    If FindField('CTP_JURSUJ') <> nil Then
      TFloatField(FieldByName('CTP_JURSUJ')).DisplayFormat := '#,##0.00';

    If FindField('CTP_MULSUJ') <> nil Then
      TFloatField(FieldByName('CTP_MULSUJ')).DisplayFormat := '#,##0.00';

    If FindField('CTP_VENDOR') <> nil Then
      TFloatField(FieldByName('CTP_VENDOR')).DisplayFormat := '#,##0.00';

    If FindField('CTP_CTABAI') <> nil Then
      TStringField(FieldByName('CTP_CTABAI')).EditMask := '99.99.999;0;_';

    If FindField('CTP_OUTENT') <> nil Then
      TFloatField(FieldByName('CTP_OUTENT')).DisplayFormat := '#,##0.00';
  End;
  strCodFor := dbeCodFor.Text;
  strCtaAut := fraPlanoDeContas.dbeCodCta.Field.AsString;
end;

procedure TfrmCadCtaPagar.pCarregaCompetencia;
begin
  if FEmptyStr(qryTabela.FieldByName('CTP_COMPET').AsString) then
  begin
    dbeCompet.Text := '';

    if (qryTabela.State = dsInsert) then
      dbeCompet.Text := FormatDateTime('mm/YYYY',VS_Date);

  end
  else
    dbeCompet.Text := qryTabela.FieldByName('CTP_COMPET').AsString;
end;

procedure TfrmCadCtaPagar.pCarregaCtaFornecedor(strCodFor: String);
begin
  if Not fEmptyStr(strCodFor) then
  begin
    with qryCtaFor do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM CTAFOR WHERE CTF_CODFOR = ' + strCodFor + '' );
      Open;
    end;
  end
end;

procedure TfrmCadCtaPagar.pAfterScroll(DataSet: TDataSet);
begin
  pCarregaCompetencia;
  strCodFor := dbeCodFor.Text;
  strCtaAut := fraPlanoDeContas.dbeCodCta.Field.AsString;
end;

function TfrmCadCtaPagar.fAlteraMovBanBanCtp(strCodCta, strNumDup, strOldFor,
  strNewFor, strSeqLan, strHisBai: String) : Boolean;
Var
  qryAux: TUniQuery;
  strNomFor: String;
  strNomNew: String;
  strNovHis: String;
begin

  If Not fEmptyStr(strOldFor) Then
  Begin
    strNovHis := '';
    If Pos(strOldFor, strHisBai) > 0 Then
      strNovHis := StringReplace(strHisBai, strOldFor, strNewFor, [rfReplaceAll]);

    strNomFor := fRetNomFornecedor(strOldFor);
    strNomNew := fRetNomFornecedor(strNewFor);
    If Pos(strNomFor, strHisBai) > 0 Then
      strNovHis := StringReplace(IIF(fEmptyStr(strNovHis),strHisBai,strNovHis), strNomFor, strNomNew, [rfReplaceAll]);

    If Not fEmptyStr(strNovHis) Then
    Begin
      qryTabela.Edit;
      qryTabela.FieldByName('CTP_HISBAI').AsString := strNovHis;
      qryTabela.Post;
    End;
  End;

  qryAux := fCriaQuery(Nil);
  Try
    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE MOVBAN SET ');

      If Not fEmptyStr(strCodCta) Then
        SQL.Add(' CTB_CODCTA = :CODCTA ');
      If Not fEmptyStr(strOldFor) Then
        SQL.Add(IIF(SQL.Count>1,',','')+' CTB_CODFOR = :CODFOR ');
      If Not fEmptyStr(strNumDup) Then
        SQL.Add(IIF(SQL.Count>1,',','')+' CTB_NUMDUP = :NUMDUP ');
      If Not fEmptyStr(strNovHis) Then
        SQL.Add(IIF(SQL.Count>1,',','')+' CTB_HIST01 = :HISTO ');

      SQL.Add('WHERE CTB_SEQLAN = :SEQLAN ');

      If Not fEmptyStr(strCodCta) Then
        ParamByName('CODCTA').AsString := strCodCta;
      If Not fEmptyStr(strOldFor) Then
        ParamByName('CODFOR').AsString := strNewFor;
      If Not fEmptyStr(strNumDup) Then
        ParamByName('NUMDUP').AsString := strNumDup;
      If Not fEmptyStr(strNovHis) Then
        ParamByName('HISTO').AsString := strNovHis;

      ParamByName('SEQLAN').AsString := strSeqLan;
      ExecSQL;
    End;

    With qryAux Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE BANCTP SET ');

      If Not fEmptyStr(strCodCta) Then
        SQL.Add(' CTP_CODCTA = :CODCTA ');
      If Not fEmptyStr(strOldFor) Then
        SQL.Add(IIF(SQL.Count>1,',','')+' CTP_CODFOR = :CODFOR ');
      If Not fEmptyStr(strNumDup) Then
        SQL.Add(IIF(SQL.Count>1,',','')+' CTP_NUMDUP = :NUMDUP ');

      SQL.Add('WHERE CTB_SEQLAN = :SEQLAN ');

      If Not fEmptyStr(strCodCta) Then
        ParamByName('CODCTA').AsString := strCodCta;
      If Not fEmptyStr(strOldFor) Then
        ParamByName('CODFOR').AsString := strNewFor;
      If Not fEmptyStr(strNumDup) Then
        ParamByName('NUMDUP').AsString := strNumDup;

      ParamByName('SEQLAN').AsString := strSeqLan;
      ExecSQL;
    End;

    {*******************************************************}
    {* SE ALTEROU O FORNECEDOR, ATUALIZA O HISTÓRICO DO    *}
    {* CHEQUE USADO NO PAGAMENTO DA DUPLICATA, CASO EXISTA *}
    {****************************************************JS*}
    If Not fEmptyStr(strOldFor) Then
    Begin
      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('UPDATE BANCHQ SET ');
        SQL.Add('  CHQ_HIST01 = REPLACE(REPLACE(CHQ_HIST01, :OLDFOR, :NEWFOR), :NOMFOR, :NOMNEW) ');
        SQL.Add('WHERE CTB_SEQLAN = :SEQLAN ');

        ParamByName('OLDFOR').AsString := strOldFor;
        ParamByName('NEWFOR').AsString := strNewFor;
        ParamByName('NOMFOR').AsString := strNomFor;
        ParamByName('NOMNEW').AsString := strNomNew;
        ParamByName('SEQLAN').AsString := strSeqLan;

        ExecSQL;
      End;
    End;

    Result := True;
  Finally
    FreeAndNil(qryAux);
  end;
end;


function TfrmCadCtaPagar.fEntradaDeMercadorias: Boolean;
var
  qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  Try
    Result := False;

    If (fCfgSis('UTICON', varBoolean)) And
       (fCfgSis('TRVCON', varBoolean)) And
       (Not fEmptyStr(dbeNumDup.Text)) Then
    Begin
      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT       ');
        SQL.Add('  FIS_NUMDOC ');
        SQL.Add('FROM         ');
        SQL.Add('  CADFIS     ');
        SQL.Add('  INNER JOIN CADPAG ON ');
        SQL.Add('	(FIS_NUMDOC = CTP_NUMDUP AND ');
        SQL.Add('  FIS_FORCLI = CTP_CODFOR	AND ');
        SQL.Add('  FIS_CODEMP = CTP_CODEMP) ');
        SQL.Add('WHERE        ');
        SQL.Add('  FIS_NUMDOC = :NUMDOC AND ');
        SQL.Add('  FIS_CODEMP = :CODEMP AND ');
        SQL.Add('  FIS_FORCLI = :CODFOR AND ');
        SQL.Add('  IFNULL( FIS_SERIE_, '' ) = IFNULL( CTP_SERIE_, '' ) AND ');
        SQL.Add('  FIS_TIP_FC = '+QuotedStr('F'));

        ParamByName('NUMDOC').AsString := dbeNumDup.Text;
        ParamByName('CODEMP').AsString := dbeCodEmp.Text;
        ParamByName('CODFOR').AsString := dbeCodFor.Text;
        Open;

        Result := Not IsEmpty;

        Close;
      End;
    End;

  Finally
    FreeAndNil(qryGen);
  End;

end;

function TfrmCadCtaPagar.fExecutaAntesDoDelete: Boolean;
begin
  Result := True;
  try
    untLogCtp.GravaLogCTP(qryTabela.FieldByName('AUTOINCREM').AsString,
                          'EXCLUSÃO',
                          Self.Name);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadCtaPagar.fExecutaAntesDoDelete]');
      Exit(False);
    End;
  end;
end;

procedure TfrmCadCtaPagar.pAtribuiTabelas;
begin
  qryConFor := fCriarQuery('SELECT * FROM CADFOR WHERE FALSE', Self);
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
  qryCtaBai := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
end;

procedure TfrmCadCtaPagar.dbeBcoBolKeyPress(Sender: TObject; var Key: Char);
  var
    arrSel : TConsultasArray;

begin
  inherited;

  If fPesqBanco(Self, dbeBcoBol, nil, qryCadBco, Key, arrSel) Then
  Begin
    if fValidaCampos(dbeBcoBol, True) then
      SelectNext(ActiveControl, True, True);
    pCarregaBanco;
  End;

end;

procedure TfrmCadCtaPagar.pCarregaBanco;
begin

  pPesquisaCadBco(qryCadBco, qryCadBco, dbeBcoBol.Text);
  edtNomBan.Text := qryCadBco.FieldByName('BCO_NOMBCO').AsString;

end;

function TfrmCadCtaPagar.dbeCodEmpChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadEmp(Key);
end;

function TfrmCadCtaPagar.dbeCodForChamaCadastro(Key: Word): String;
begin
  inherited;
  TLiberacaoFactory.pSetLiberacao( TLiberacao.Create );
  Result := untFuncIns.fChamaCadFor(Key);
end;

procedure TfrmCadCtaPagar.pIniciaValoresPadrao;
begin
  {********************************************}
  {* ADICIONADA A OPCAO DEPOSITO EM dbeDeposi *}
  {* ASSOCIADA AO CAMPO CTP_DEPOSI            *}
  {*****************************************AA*}
  dbeDtaCad.Field.AsDateTime := VS_Date;
  dbeDtaVen.Field.AsDateTime := VS_Date;
  dbeParcel.Field.AsString   := 'A';
  dbePrevis.Field.AsString   := 'N';
  dbeUsaChq.Field.AsString   := 'N';
  dbeUsaMca.Field.AsString   := 'N';
  dbeDeposi.Field.AsString   := 'N';
  dbeCodEmp.Field.AsString   := VS_strCodEmp;
  dbePagAnt.Field.AsString   := 'N';
  dbeUsoCon.Field.AsString   := 'N';
  dbeQtdDia.Field.AsInteger  := 0;

  If fCfgSis('VEIONF') <> 'B' Then
    dbeVeioNF.Field.AsString   := fCfgSis('VEIONF');

  If fCfgSis('VEIOBO') <> 'B' Then
    dbeVeiobo.Field.AsString   := fCfgSis('VEIOBO');

  dbeValorOutrasEntidades.Field.AsFloat         := 0.00;
  qryTabela.FieldByName('CTP_SEQBAI').AsInteger := 0;
  fValidaCampos(dbeDesSuj);
  pCarregaEmpresa;
end;

procedure TfrmCadCtaPagar.FormShow(Sender: TObject);
begin
  inherited;
  pUtilizaRotinaProjeto;
  edtPorBai.Width := edtDtaPag.Width;
  btnListarPortadores.Left    := edtPorBai.Left;
  btnListarPortadores.Width   := edtPorBai.Width;
  btnListarPortadores.Visible := False;
  qryCtaFor := fCriaQuery;

  blnTelaReduzida := False;
  blnTravarDes := False;
  blnTravarAlt := False;

  blnDupTravada := False;
  strAutoincremLckAtc := '';
  pCarregaDadosAdicionais;

  edtStatus.Text := '';
  edtProvisao.Text := '';
  edtNumPedCompra.Text := '';

  dtsGuiaTributo.DataSet := qryGuiaTributo;
  dtsTipoTributo.DataSet := qryTipoTributo;
  CarregaGuiasETributos;

  dtsDadosBcoFor.Dataset := qryDadosBcoFor;

  btnLiberacaoBaixa.Enabled := fCfgSis('CTPLBB', varBoolean);

  btnImpCtaPagar.Visible := fCfgSis('USATKL', varBoolean);

  if blnIniciaCadastro then
  begin
    btnIncluir.Click;

    if fltValLanLoc <> 0 then
    begin
      dbeValDup.DataSource.DataSet.FieldByName('CTP_VALDUP').Value    := fltValLanLoc;
    end;

    if dteDataLanLoc <> 0 then
    begin
      dbeDtaVen.DataSource.DataSet.FieldByName('CTP_DTACAD').Value := dteDataLanLoc;
      dbeCompet.Text := FormatDateTime('mm/yyyy', dteDataLanLoc);
      dbeDtaCad.ReadOnly := True;
    end;

    if dteDataVenLoc <> 0 then
    begin
      dbeDtaVen.DataSource.DataSet.FieldByName('CTP_DTAVEN').Value := dteDataVenLoc;
      dbeDtaVen.ReadOnly := True;
    end;

    if strHist01Loc <> '' then
    begin
      dbeHisto1.DataSource.DataSet.FieldByName('CTP_HIST01').Value    := strHist01Loc;
    end;

    if strCodPorLoc <> '' then
    begin
      dbeCodPor.DataSource.DataSet.FieldByName('CTP_CODPOR').Value    := strCodPorLoc;
      pCarregaPortador;
    end;
  end;

  {*******************************************}
  {* CASO TENHA CARREGADO O AUTOINCREM ANTES *}
  {* ANTES DO FORMSHOW JÁ ABRE A DUPLICATA   *}
  {****************************************JS*}
  if Not fEmptyStr(strAutoIncrem) Then
  Begin
    If strOrigem = 'frmBaixaCtaPagar' Then
      btnBaixarDup.Visible := False;

    qryTabela             := fCriarQuery('SELECT * FROM CADPAG WHERE AUTOINCREM = ' + QuotedStr(strAutoIncrem)+ ' ', Self);
    qryTabela.AfterOpen   := pAfterOpen;
    qryTabela.AfterScroll := pAfterScroll;
    dtsTabela.DataSet     := qryTabela;
    qryTabela.Open;
    qryTabela.Edit;
    btnCancela.Click;
    pSetFocus(btnAlterar);

    pCarregaDadosBancariosFornecedor(qryTabela.FieldByName('CTP_CODFOR').AsString);

    fValidaCampos(dbeCodFor, True);

  End;

  pCalculaValorTotal;

  If Not fVerificaAcessoSistema('REMCTP') Then
  Begin
    pnlEnvBan.Visible := False;
    self.Height := self.Height - pnlEnvBan.Height;
  End;

end;

procedure TfrmCadCtaPagar.btnPendLiberacaoClick(Sender: TObject);
begin
  inherited;

  Try
    case fValidaTornarPend of
      1: fMensagem('ATENÇÃO','Essa duplicata já está paga.',['&Ok']);
      2: fMensagem('ATENÇÃO','Selecione uma duplicada.',['&Ok']);
      3: fMensagem('ATENÇÃO','Essa duplicata ainda não foi liberada para baixa.',['&Ok']);
      4:begin
        If fMensagem('Confirmação', 'Deseja retornar para pendente de liberação a duplicata?'
                       ,['&Sim', '&Não'], 2) = 2 Then
          Exit;

        fTornaPendLiberacao;
        pAtualizaDlp(qryTabela.FieldByName('AUTOINCREM').AsString);

      end;
    end;
  Except
  On E: Exception Do
    pMensagensErro(E.Message, '[TfrmCadCtaPagar.btnPendLiberacaoClick]');
  End;

end;

procedure TfrmCadCtaPagar.btnPesquisaClick(Sender: TObject);
  Var
    intOpcao     : Integer;
    arrSel       : TConsultasArray;
    chrKey       : Char;
    strAutInc    : String;
    objfrmPnl    : TPanelCxCadPagar;
begin
  strOrderOpc := 'CTP_PARCEL, CTP_SERIE_, CTP_SEQBAI, CTP_CODEMP, CTP_CODFOR ';

  intOpcao := fMensagem('','OPÇÃO',['TODOS','BAIXADOS','ABERTOS']);

  chrKey := '/';
  objfrmPnl := TPanelCxCadPagar.Create(TfrmPnlPesqCadPag);
  strAutInc := qryTabela.FieldByName('AUTOINCREM').AsString;
  Try
    If fPesqCtaPagar(Self, dbeNumDup, qryTabela, chrKey, arrSel, intOpcao, True, 'Consulta Contas Pagar',objfrmPnl)  Then
    Begin
      If qryTabela.IsEmpty Then
        Exit;

      If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
      Begin
        qryTabela.Close;
        qryTabela.SQL.Clear;
        qryTabela.SQL.Add('SELECT * FROM ' + strNomeTabela + ' WHERE FALSE');
        qryTabela.Open;

        pLimparEdits;
        Exit;
      End;

      fLock_Unlock(strNomeTabela + strAutInc, False);
      fCarregaDuplicata;

      pHabilitaFields;
      VisualizaComboGuiaTributos;
      LcbGuiaTributo.Enabled := False;
      LcbTipoTributo.Enabled := False;
      pCarregaEventos;
      pCarregaProjeto;
      VerificaSeStatusFatura(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                             qryTabela.FieldByName('CTP_CODEMP').AsString,
                             qryTabela.FieldByName('CTP_CODFOR').AsString,
                             qryTabela.FieldByName('CTP_SERIE_').AsString);

      CarregaNumeroPedidoCompra(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                                qryTabela.FieldByName('CTP_CODEMP').AsString,
                                qryTabela.FieldByName('CTP_CODFOR').AsString,
                                qryTabela.FieldByName('CTP_SERIE_').AsString,
                                qryTabela.FieldByName('CTP_PARCEL').AsString,
                                qryTabela.FieldByName('CTP_SEQBAI').AsInteger);

      btnReinf.enabled := Not VerificaSeDuplicataTemCadFis(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                                                           qryTabela.FieldByName('CTP_CODEMP').AsString,
                                                           qryTabela.FieldByName('CTP_CODFOR').AsString,
                                                           qryTabela.FieldByName('CTP_SERIE_').AsString);

      pAtualizaCorBotaoREINF(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                             qryTabela.FieldByName('CTP_PARCEL').AsString,
                             qryTabela.FieldByName('CTP_SERIE_').AsString,
                             qryTabela.FieldByName('CTP_CODEMP').AsString,
                             qryTabela.FieldByName('CTP_CODFOR').AsString,
                             qryTabela.FieldByName('CTP_SEQBAI').AsInteger);

      If Not qryTabela.IsEmpty Then
        btnExcluirAut.Enabled := Not fIsGNRE;
    End;
  Finally
    pFreeAndNil(objfrmPnl);
  End;
end;

procedure TfrmCadCtaPagar.btnReinfClick(Sender: TObject);
  Var
    frmDigReinfCTP : TfrmDigReinfCTP;
begin
  inherited;

  If ((qryTabela.State <> dsEdit) And (qryTabela.State <> dsInsert)) Then
  Begin
     fMensagem('ATENÇÃO!', 'Para essa funcionalidade é necessário estar incluíndo ou alterando a duplicata.', ['&Ok']);
     Exit;
  End;

  If ((qryTabela.State <> dsBrowse) And (qryTabela.State <> dsInactive)) Then
  Begin

    Try
      pCriarFormularios(TfrmDigReinfCTP, frmDigReinfCTP);
      frmDigReinfCTP.strNumdup := qryTabela.FieldByName('CTP_NUMDUP').AsString;
      frmDigReinfCTP.strCodfor := qryTabela.FieldByName('CTP_CODFOR').AsString;
      frmDigReinfCTP.strParcel := qryTabela.FieldByName('CTP_PARCEL').AsString;
      frmDigReinfCTP.intSeqBai := qryTabela.FieldByName('CTP_SEQBAI').AsInteger;
      frmDigReinfCTP.strSerie  := qryTabela.FieldByName('CTP_SERIE_').AsString;
      frmDigReinfCTP.strCodEmp := qryTabela.FieldByName('CTP_CODEMP').AsString;
      frmDigReinfCTP.bnlInserindo   := (qryTabela.State = dsInsert);
      frmDigReinfCTP.strIns_CodNat  := ACodigoNaturezaReinf;
      frmDigReinfCTP.strIns_CodServ := ACodigoServicoReinf;

      frmDigReinfCTP.strCodNat_Alterado  := strIni_CodNatAlteracao;
      frmDigReinfCTP.strCodServ_Alterado := strIni_CodServAlteracao;
      frmDigReinfCTP.blnAlterado         := blnReinfAlterado;

      frmDigReinfCTP.showModal;

      If frmDigReinfCTP.blnConfirma Then
      Begin

         blnUsouReinf := frmDigReinfCTP.blnEntrouReinf;

         If Not frmDigReinfCTP.bnlInserindo Then
         Begin
           strIni_CodNatAlteracao  := frmDigReinfCTP.edtCodNatRend.Text;
           strIni_CodServAlteracao := frmDigReinfCTP.edtCodTipServ.Text;
           blnReinfAlterado := True;
         End;

         If (Not fEmptyStr(frmDigReinfCTP.edtCodNatRend.Text)) And (Not fEmptyStr(frmDigReinfCTP.edtCodTipServ.Text)) Then
         Begin
           ACodigoNaturezaReinf := frmDigReinfCTP.edtCodNatRend.Text;
           ACodigoServicoReinf  := frmDigReinfCTP.edtCodTipServ.Text;
         End
         Else
         Begin
           ACodigoNaturezaReinf := '';
           ACodigoServicoReinf  := '';
         End;
      End;

     {If Not cdsCtpDet.IsEmpty Then
      Begin
        pSetFocus(Self);
      End
      Else
      Begin
        pSetFocus(Self);
      End;}
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[frmCadCtaPagar.btnReinf]');
      End;
    End;
    pFreeAndNil(frmDigReinfCTP);

  End;

end;

procedure TfrmCadCtaPagar.btnRomaneioClick(Sender: TObject);
  Var
    frmCadCtaPagarRomaneio: TfrmCadCtaPagarRomaneio;
begin
  if not btnRomaneio.Enabled then
    Exit;

  pCriarFormularios(TfrmCadCtaPagarRomaneio, frmCadCtaPagarRomaneio);
  try
    frmCadCtaPagarRomaneio.CodigoFornecedor := dbeCodFor.Text;
    frmCadCtaPagarRomaneio.CodigoEmpresa    := dbeCodEmp.Text;
    frmCadCtaPagarRomaneio.NumeroDuplicata  := dbeNumDup.Text;
    frmCadCtaPagarRomaneio.Serie            := dbeSerie.Text;
    frmCadCtaPagarRomaneio.ShowModal;
  finally
    pFreeAndNil(frmCadCtaPagarRomaneio);
  End;
end;

procedure TfrmCadCtaPagar.CarregaGuiasETributos(ATrazTributo: Boolean = False);
begin
  qryGuiaTributo.Close;
  qryGuiaTributo.SQL.Clear;
  qryGuiaTributo.SQL.Add('SELECT GUI_CODGUI, GUI_DESCRI ');
  qryGuiaTributo.SQL.Add('FROM GUITRI ');
  qryGuiaTributo.Open;

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
end;

procedure TfrmCadCtaPagar.CarregaNumeroPedidoCompra(strNumDoc, strCodEmp, strCodFor,ASerie,AParcel : String; ASeqBai: Integer);
  Var
    LConsulta: TUniQuery;
begin

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := 'SELECT                                                       '+
                          '  GROUP_CONCAT(DISTINCT PCG_NUMPED) AS NUMPED                '+
                          '  FROM                                                       '+
                          '    CADPAG P                                                 '+
                          '    LEFT JOIN MOVDET                                         '+
                          '      ON DET_NUMDOC = P.CTP_NUMDUP                           '+
                          '      AND DET_CODFOR = P.CTP_CODFOR                          '+
                          '      AND IFNULL(DET_SERIE_, "") = IFNULL(P.CTP_SERIE_, "")  '+
                          '      AND DET_CODEMP = P.CTP_CODEMP                          '+
                          '    LEFT JOIN BAIPED                                         '+
                          '      ON BAI_AUTDET = MOVDET.AUTOINCREM                      '+
                          '    LEFT JOIN PCMDET                                         '+
                          '      ON PCMDET.AUTOINCREM = BAI_AUTPED                      '+
                          '    LEFT JOIN PCMGER                                         '+
                          '      ON PCG_NUMPED = PCD_NUMPED                             '+
                          '      AND PCG_CODFOR = PCD_CODFOR                            '+
                          '      AND PCG_ESPDOC = PCD_ESPDOC                            '+
                          '      AND PCG_CODEMP = PCD_CODEMP                            '+
                          '  WHERE P.CTP_NUMDUP = :NUMDUP                               '+
                          '    AND P.CTP_CODFOR = :CODFOR                               '+
                          '    AND P.CTP_PARCEL = :PARCEL                               '+
                          '    AND P.CTP_SEQBAI = :SEQBAI                               '+
                          '    AND IFNULL(P.CTP_SERIE_,"") = :SERIE_                    '+
                          '    AND P.CTP_CODEMP = :CODEMP                               '+
                          '  GROUP BY P.AUTOINCREM                                      ';


    LConsulta.ParamByName('NUMDUP').AsString := strNumDoc;
    LConsulta.ParamByName('CODFOR').AsString := strCodFor;
    LConsulta.ParamByName('PARCEL').AsString := AParcel;
    LConsulta.ParamByName('SEQBAI').AsInteger := ASeqBai;
    LConsulta.ParamByName('SERIE_').AsString := ASerie;
    LConsulta.ParamByName('CODEMP').AsString := strCodEmp;

    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
       EdtnumPedCompra.Text := LConsulta.FieldByName('NUMPED').AsString
    Else
       EdtnumPedCompra.Text := '';

  Finally
    FreeAndNil(LConsulta);
  End;

end;

procedure TfrmCadCtaPagar.cbxBcoForChange(Sender: TObject);
begin
  inherited;
  pSetaBcoFor;
end;

procedure TfrmCadCtaPagar.cbxBcoForDropDown(Sender: TObject);
begin
  inherited;
  SendMessage(cbxBcoFor.Handle, CB_SETDROPPEDWIDTH, 315, 0);
end;

procedure TfrmCadCtaPagar.cbxBcoForEnter(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := 'INSERT para incluir/alterar dados bancários do fornecedor';
end;

procedure TfrmCadCtaPagar.cbxBcoForExit(Sender: TObject);
begin
  inherited;
  pnlInfo.Caption := '';
end;

procedure TfrmCadCtaPagar.cbxBcoForKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If fIsInsert(Key) And fValidaCampos(dbeCodFor, True) Then
  Begin

    pCriarFormularios(TfrmCadFornecedores, frmCadFornecedores);

    try
      frmCadFornecedores.strCodFornecedorIniciarCadastro := dbeCodFor.Text;
      frmCadFornecedores.fMskCon := fMskCon;
      frmCadFornecedores.fSemMascaraPlaNco := fSemMascaraPlaNco;
      frmCadFornecedores.fPesqPlanoContabil := fPesqPlanoContabil;
      frmCadFornecedores.pPlanoDeContasPorEmpresa := pPlanoDeContasPorEmpresa;
      frmCadFornecedores.fVerificarPlanoDeContasPorEmpresa := fVerificarPlanoDeContasPorEmpresa;
      frmCadFornecedores.pGravarPlanoContasAutomatico := pGravarPlanoContasAutomatico;
      frmCadFornecedores.pGravarPlanoContasAutomaticoParaCadaEmpresa := pGravarPlanoContasAutomaticoParaCadaEmpresa;
      frmCadFornecedores.fCadastroRapidoCliente := TfrmCadClientes.fCadastroRapidoCliente;
      frmCadFornecedores.fCadastroRapidoTransportadora := TfrmCadTransportadoras.fCadastroRapidoTransportadora;
      frmCadFornecedores.fCriaEstruturaCdsNCO := fCriaEstruturaCdsNCO ;
      frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := pCarregaPlanoDeContasPorEmpresa ;
      frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := pSalvaPlanoDeContasPorEmpresa;
      frmCadFornecedores.ShowModal;
    finally
      frmCadFornecedores.fMskCon := Nil;
      frmCadFornecedores.fSemMascaraPlaNco := Nil;
      frmCadFornecedores.fPesqPlanoContabil := Nil;
      frmCadFornecedores.fCadastroRapidoCliente := Nil;
      frmCadFornecedores.fCadastroRapidoTransportadora := Nil;
      frmCadFornecedores.fCriaEstruturaCdsNCO := Nil ;
      frmCadFornecedores.pCarregaPlanoDeContasPorEmpresa := Nil ;
      frmCadFornecedores.pSalvaPlanoDeContasPorEmpresa := Nil ;
      pCarregaDadosBancariosFornecedor(dbeCodFor.Text);
      pFreeAndNil(frmCadFornecedores);
    End;

  End;
end;

procedure TfrmCadCtaPagar.chkCodBarClick(Sender: TObject);
begin
  inherited;
  If chkCodBar.Checked Then
  Begin
    chkLinDig.Enabled := False;
    dbeLinDig.Enabled := False;
    dbeCodBar.Enabled := True;
  End
  Else
  Begin
    chkLinDig.Enabled := True;
    dbeLinDig.Enabled := True;
    dbeCodBar.Enabled := False;
  End;
end;

procedure TfrmCadCtaPagar.chkLinDigClick(Sender: TObject);
begin
  inherited;
  If chkLinDig.Checked Then
  Begin
    chkCodBar.Enabled := False;
    dbeCodBar.Enabled := False;
    dbeLinDig.Enabled := True;
  End
  Else
  Begin
    chkCodBar.Enabled := True;
    dbeCodBar.Enabled := True;
    dbeLinDig.Enabled := False;
  End;
end;

procedure TfrmCadCtaPagar.dbeCodEmpKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrEmp: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE EMPRESAS   *}
  {****************************RV*}
  If fPesqEmpresa(conEmpSimples, Self, dbeCodEmp, edtNomEmp, Nil, Key, arrEmp) Then
  Begin
    If fValidaCampos(dbeCodEmp) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCtaPagar.dbeCodForKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrFornec: TConsultasArray;
begin
  inherited;
  {*********************************}
  {* NOVA CONSULTA DE FORNECEDORES *}
  {******************************RV*}
  If fPesqFornecedor(conForCompleta, Self, dbeCodFor, edtNomFor, Nil, Key, arrFornec) Then
  Begin
    If fValidaCampos(dbeCodFor, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCtaPagar.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F2: btnAjuVal.Click;
    VK_F8: btnDesmembr.Click;
    VK_F9: btnAltNumDoc.Click;
    VK_F10: btnRomaneio.Click;
    VK_F12: btnReinf.Click;
    VK_Escape: btnSair.Click;
  End;
end;

procedure TfrmCadCtaPagar.FormPaint(Sender: TObject);
begin
  inherited;

end;

{******************************************************}
{* VERIFICA SE A META DO PLANO DE CONTAS FOI EXCEDIDA *}
{***************************************************AJ*}
function TfrmCadCtaPagar.fVerificaDuplicataContabilizada: Boolean;
Var
  qryConsulta:  TUniQuery;
begin
  Try
    qryConsulta := fCriaQuery;
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add(' SELECT CON_INCDOC FROM LANCON WHERE CON_TIPLAN = "CTP" AND CON_INCDOC = :INCDOC ');
    qryConsulta.ParamByName('INCDOC').AsString := QryTabela.FieldByName('AUTOINCREM').AsString;
    qryConsulta.Open;

    Result := (Not qryConsulta.IsEmpty);
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function TfrmCadCtaPagar.fVerificaExistemDeTributosParaGuia(
  ACodigoGuia: Integer): Boolean;
  Var
    qryConsulta:  TUniQuery;
begin
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Add('SELECT TRI_CODTRI, TRI_CODGUI, TRI_DESCRI ');
    qryConsulta.SQL.Add('FROM TIPTRI ');
    qryConsulta.SQL.Add('WHERE TRI_CODGUI = :CODGUI ');
    qryConsulta.ParamByName('CODGUI').AsInteger := ACodigoGuia;
    qryConsulta.Open;
    Result := (Not qryConsulta.IsEmpty);
  Finally
    FreeAndNil(qryConsulta);
  End;

end;

function TfrmCadCtaPagar.fVerificaMeta(blnInserindo: Boolean): Boolean;
  Var
    objMetaCusto: TMetaCentroCustoPedido;
    blnPedeSenha,
    blnExiste   : Boolean;
    arrMetas    : Array Of TCtaMetas;
    intCont     : Integer;
    arrDuplicata: TarrDuplicata;
begin
  Result := True;
  pZeraDigDuplic(arrDuplicata);

  If (fCfgSis('METPED') <> '2') and (fCfgSis('METPED') <> '4') And
    (fCfgSis('METPED') <> '5') and (fCfgSis('METPED') <> '6') Then
    Exit;

  If Pos(dbeCodFor.Text, fRetForFilialTodos) > 0 Then
    Exit;

  // Caso nenhum dos campos abaixos tenham sido alterados
  // não faz a verificação da meta
  If (fltValDupOld = fStrToFloat(dbeValDup.Text)) And
     (strDtaCadOld = dbeDtaCad.Text) And
     (strDtaVenOld = dbeDtaVen.Text) And
     (strCodPorOld = dbeCodPor.Text) And
     (strCodCtaOld = fraPlanoDeContas.dbeCodCta.Text) And
     (strCompetOld = dbeCompet.Text) Then
    Exit;

  blnPedeSenha := False;
  TLiberacaoFactory.pSetLiberacao( TLiberacao.Create );
  objMetaCusto := TMetaCentroCustoPedido.Create(Self);
  objMetaCusto.pInicializa;
  objMetaCusto.strCodFor := dbeCodFor.Text;
  objMetaCusto.strNomFor := edtNomFor.Text;

  objMetaCusto.strAutIncCTP := IIF(blnInserindo, fStrZero('0', 20),
                                   qryTabela.FieldByName('AUTOINCREM').AsString);

  If FDatasetCtpDet.IsEmpty Then
    blnPedeSenha := Not objMetaCusto.fCarregaMetas(dbeDtaVen.Field.AsDateTime,
                                                   dbeCodEmp.Text,
                                                   fraPlanoDeContas.dbeCodCta.Text,
                                                   '',
                                                   '01.000',
                                                   dbeValDup.Field.AsFloat,
                                                   True, arrDuplicata,
                                                   '',
                                                   fraCentroCusto.dbeCodEve.Text)
  Else
  Begin
    SetLength(arrMetas, 0);

    FDatasetCtpDet.First;
    While Not FDatasetCtpDet.Eof Do
    Begin
      blnExiste := False;
      For intCont := 0 To Length(arrMetas) - 1 Do
      Begin
        If (arrMetas[intCont].strCodCta = FDatasetCtpDet.FieldByName('CTP_CODCTA').AsString) And
           (arrMetas[intCont].strCodEmp = IIF(fCfgSis('METPED') = '4', 'Todas', FDatasetCtpDet.FieldByName('CTP_CODEMP').AsString)) Then
        Begin
          blnExiste := True;
          Break;
        End;
      End;

      If blnExiste Then
        arrMetas[intCont].fltValDup := arrMetas[intCont].fltValDup + (dbeValDup.Field.AsFloat * FDatasetCtpDet.FieldByName('CTP_FATCAL').AsFloat)
      Else
      Begin
        SetLength(arrMetas, Length(arrMetas) + 1);
        intCont := Length(arrMetas) - 1;
        arrMetas[intCont].strCodCta := FDatasetCtpDet.FieldByName('CTP_CODCTA').AsString;
        arrMetas[intCont].strCodEmp := IIF(fCfgSis('METPED') = '4', 'Todas', FDatasetCtpDet.FieldByName('CTP_CODEMP').AsString);
        arrMetas[intCont].fltValDup := (dbeValDup.Field.AsFloat * FDatasetCtpDet.FieldByName('CTP_FATCAL').AsFloat);
      End;

      FDatasetCtpDet.Next;
    End;

    For intCont := 0 To Length(arrMetas) - 1 Do
    Begin
      blnPedeSenha := (Not objMetaCusto.fCarregaMetas(dbeDtaVen.Field.AsDateTime,
                                                      IIF(fCfgSis('METPED') = '4',
                                                      fraPlanoDeContas.dbeCodCta.Field.AsString,
                                                      arrMetas[intCont].strCodEmp),
                                                      arrMetas[intCont].strCodCta,
                                                      '',
                                                      '01.000',
                                                      arrMetas[intCont].fltValDup))
                      Or (blnPedeSenha);
    End;

  End;
  Result := IIF(blnPedeSenha, objMetaCusto.fPedeSenha, True);

  FreeAndNil(objMetaCusto);
end;

{*******************************************}
{* DELETE UM REGISTRO ESPECÍFICO DE CTPDET *}
{****************************************MV*}
procedure TfrmCadCtaPagar.pDeletaCtpDet(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String);
  Var
    strSQL: String;
    qryGenDet: TUniQuery;

begin
  qryGenDet := fCriaQuery;

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT * FROM CTPDET ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
    If (fEmptyStr(strSerie)) Then
      strSQL := strSQL + '  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) AND '
    Else
      strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';
    strSQL := strSQL + '  CTP_EMPORI = :EMPORI AND ';
    strSQL := strSQL + '  CTP_CODFOR = :CODFOR ';

    qryGenDet.SQL.Text := strSQL;
    qryGenDet.ParamByName('NUMDUP').AsString := strNumDup;
    qryGenDet.ParamByName('PARCEL').AsString := strParcel;
    If (Not fEmptyStr(strSerie)) Then
      qryGenDet.ParamByName('SERIE_').AsString := strSerie;
    qryGenDet.ParamByName('EMPORI').AsString := strCodEmp;
    qryGenDet.ParamByName('CODFOR').AsString := strCodFor;
    qryGenDet.Open;

    While Not qryGenDet.Eof Do
    Begin
      untLogCtpDet.GravaLogCtpDet(qryGenDet.FieldByName('AUTOINCREM').AsString,
                                  'EXCLUSÃO',
                                  Self.Name);

      qryGenDet.Delete;
    End;

  Finally
    qryGenDet.Close;

    FreeAndNil(qryGenDet);
  End;

end;

procedure TfrmCadCtaPagar.pDesabilitaFields;
begin
  dbeCompet.Enabled := False;
end;

procedure TfrmCadCtaPagar.pDestravarRegistros;
begin
  inherited;
  If Not qryTabela.IsEmpty Then
  Begin
    qryTabela.First;

    While Not qryTabela.Eof Do
    Begin
      fLock_Unlock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString, False);

      qryTabela.Next;
    End;
  End;
  blnDupTravada := False;
  strAutoincremLckAtc := '';
end;

function TfrmCadCtaPagar.PedirConfirmacaoDadosBoleto: Boolean;
begin
  Result := True;

  If (FCodBarOld  = TDBEditFocus(dbeCodBar).Text) Then
    Result := False;

  If (FLigDigOld  = TDBEditFocus(dbeLinDig).Text) Then
    Result := False;
end;

procedure TfrmCadCtaPagar.GravaLogCtp(strNumDup,
                                      strParcel: String;
                                      intSeqBai: Integer;
                                      strCodEmp,
                                      strCodFor,
                                      strSerie_: String;
                                      blnInserindo: Boolean;
                                      AComplementoDescricao: String = '';
                                      AAutoincrem: String = '');
  Var
    strDescriLogCtp,
    LAutoIncrem: String;
begin
  Try
    strDescriLogCtp := ifThen(blnInserindo,'INCLUSAO', 'ALTERACAO') + AComplementoDescricao;
    LAutoIncrem := AAutoincrem;

    If fEmptyStr(LAutoIncrem) Then
      LAutoIncrem := fCampoTabela('AUTOINCREM',
                                  'CADPAG',
                                  ['CTP_NUMDUP', 'CTP_PARCEL', 'CTP_CODEMP', 'CTP_CODFOR', 'CTP_SERIE_', 'CTP_SEQBAI'],
                                  [strNumDup, strParcel, strCodEmp, strCodFor, strSerie_, intSeqBai],
                                  True);

    untLogCtp.GravaLogCtp(LAutoIncrem,
                          strDescriLogCtp,
                          Self.Name);
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;
end;

function TfrmCadCtaPagar.fConfiguracoesRateioValidas(out AMsgRetorno: String): Boolean;
var
  LPlanoContasRateioInvalida,
  LCentroCustoRateioInvalida,
  LAmbasInvalidas: Boolean;
begin
  Result := False;
  AMsgRetorno := '';
  LPlanoContasRateioInvalida := fEmptyStr(fCfgSis('CTAPRI'));
  LCentroCustoRateioInvalida := fEmptyStr(fCfgSis('EVEPRI')) And (Not blnBaixada);
  LAmbasInvalidas := LPlanoContasRateioInvalida And LCentroCustoRateioInvalida;

  If LAmbasInvalidas Then
  Begin
    AMsgRetorno := 'As configurações: "Plano de Contas principal para rateio de duplicatas" e "Centro de Custos principal para rateio de duplicatas" devem estar preenchidas nas configurações do sistema!';
    Exit;
  End;

  If LPlanoContasRateioInvalida Then
  Begin
    AMsgRetorno := 'A configuração: "Plano de Contas principal para rateio de duplicatas" deve estar preenchida nas configurações do sistema!';
    Exit;
  End;

  If LCentroCustoRateioInvalida Then
  Begin
    AMsgRetorno := 'A configuração: "Centro de Custos principal para rateio de duplicatas" deve estar preenchida nas configurações do sistema!';
    Exit;
  End;

  Result := True;
end;


procedure TfrmCadCtaPagar.btnDesmembrClick(Sender: TObject);
  Var
    frmDesmembrValores : TfrmDesmembrValores;

    LCentroDeCustosDesmembramento: String;
    I: Integer;
    LMsgCFG: String;
begin
  inherited;

  frmDesmembrValores := Nil;

  If (Not btnDesmembr.Enabled) Or (Not btnDesmembr.Visible) Then
  Begin
    Exit;
  End;

  {*****************************************************************************}
  {* SÓ PERMITI ENTRAR NA TELA DE DESMEMBRAMENTO SE O VALOR FOR MAIOR QUE ZERO *}
  {**************************************************************************LU*}
  {***************************************************************************}
  {* SOLICITAÇÃO DA MACHADO PARA LIBERAR DESMEMBRAMENTO DE VALORES NEGATIVOS *}
  {************************************************************09/01/2012**JU*}
  If (fStrToFloat(dbeValDup.Text) = 0) And (Not blnBaixada)  Then
  Begin
    fMensagem('', 'Digite o Valor da Duplicata antes de realizar o desmembramento!', ['&Ok']);
    Exit;
  End;

  If Not fConfiguracoesRateioValidas(LMsgCFG) Then
  Begin
    fMensagem('ATENÇÃO!', LMsgCFG, ['&Ok']);
    Exit;
  End;

  If ((qryTabela.State <> dsBrowse) And (qryTabela.State <> dsInactive)) Or (blnBaixada) Then
  Begin
    Try
      Try
        blnTravarDes := False;
        blnTravarAlt := True;
        btnAltNumDoc.Enabled := False;
        {*****************************************}
        {* CHAMA O FORM DE DESMEMBRAMENTO        *}
        {**************************************MV*}
        pCriarFormularios(TfrmDesmembrValores, frmDesmembrValores);
        frmDesmembrValores.DatasetCtpDet       := FDatasetCtpDet;
        frmDesmembrValores.strNumDup       := dbeNumDup.Text;
        frmDesmembrValores.strParcel       := dbeParcel.Text;
        frmDesmembrValores.strSerie        := dbeSerie.Text;
        frmDesmembrValores.strCodEmp       := dbeCodEmp.Text;
        frmDesmembrValores.strCodFor       := dbeCodFor.Text;
        frmDesmembrValores.FValidaCorrespondenteContabil := Self.FValidaCorrespondenteContabil;

        frmDesmembrValores.blnBaixada := False;

        If blnBaixada Then
        Begin
          frmDesmembrValores.fltValTot := fStrToFloat(edtValOri.Text);
        End
        Else
        Begin
          If Not fEmptyStr(dbeValDup.Text) Then
            frmDesmembrValores.fltValTot := fStrToFloat(dbeValDup.Text);
        End;

        frmDesmembrValores.edtNumDup.Text  := dbeNumDup.Text;
        frmDesmembrValores.edtParcel.Text  := dbeParcel.Text;

        frmDesmembrValores.pnlInfo.Caption := '';
        frmDesmembrValores.pnlInfo.Font.Color := clBlack;

        If fCfgSis('UTICON', varBoolean) And fEntradaDeMercadorias Then
        Begin

          If fTemDesmembramento Then
          Begin

            With frmDesmembrValores Do
            Begin
              For I := 0 To Pred(ComponentCount) Do
              Begin
                If (Components[I] Is TPanel) Then
                Begin
                  If (TPanel(Components[I]).Name <> 'pnlBotoesDesm') Then
                      TPanel(Components[I]).Enabled := False;
                End;
              End;

              frmDesmembrValores.DesabilitaTodosBotoes();

              pnlInfo.Caption := AnsiQuotedStr('Título oriundo de Entrada de Mercadorias. '
                                              +'Já contabilizado. Não será permitido alterar '
                                              +'a distribuição do Desmembramento.','"');
              pnlInfo.Font.Color := clRed;

            End;

          End;

        End;

        frmDesmembrValores.showModal;

        If FDatasetCtpDet <> frmDesmembrValores.DatasetCtpDet Then
          FreeAndNil(FDatasetCtpDet);

        FDatasetCtpDet := frmDesmembrValores.DatasetCtpDet;

        FDatasetCtpDet.Filter := 'TIPOACAO<>''3'' ';
        FDatasetCtpDet.Filtered := True;
        If Not FDatasetCtpDet.IsEmpty Then
        Begin
          fraPlanoDeContas.dbeCodCta.Enabled := False;
          fraPlanoDeContas.dbeCodCta.Text    := IIF(fEmptyStr(frmDesmembrValores.strCodCta), fCfgSis('CTAPRI'), frmDesmembrValores.strCodCta);
          pCarregaCentroCusto;

          If fVerificaEvenRat(FDatasetCtpDet) Then
          Begin
            LCentroDeCustosDesmembramento := IIF((frmDesmembrValores.strCodEve = ''), fCfgSis('EVEPRI'), frmDesmembrValores.strCodEve);

            If Not LCentroDeCustosDesmembramento.IsEmpty Then
            Begin
              fraCentroCusto.dbeCodEve.Text := LCentroDeCustosDesmembramento;
              fraCentroCusto.dbeCodEve.Enabled := False;
              pCarregaEventos;
            End;
          End
          Else
          Begin
            fraCentroCusto.dbeCodEve.Enabled := True;
            pCarregaEventos;
          End;
          pSetFocus(Self);
        End
        Else
        Begin
          {*****************************************************}
          {* SÓ PODE ALTERAR O VALDUP SE TEM DIREITO DE ACESSO *}
          {**************************************************JU*}
          If Not fVerificaAcessoSistema('CTPALTVLR') And (qryTabela.State In [dsEdit]) Then
          Begin
            dbeValDup.Enabled := False;
            dbeDesSuj.Enabled := False;
            dbeJurSuj.Enabled := False;
            dbeMulSuj.Enabled := False;
            dbeVendor.Enabled := False;
          End
          Else If fVerificaAcessoSistema('CTPALTVLR') Then
            dbeValDup.Enabled := True;

          fraPlanoDeContas.dbeCodCta.Enabled := True;
          fraCentroCusto.dbeCodEve.Enabled := True;
          pSetFocus(dbeValDup);
          strCtaAnt := '';
        End;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[frmCadCtaPagar.btnDesmembrClick]');
        End;
      End;
    Finally
      FDatasetCtpDet.Filter := '';
      FDatasetCtpDet.Filtered := False;
      FreeAndNil(frmDesmembrValores);
    End;
  End;

  TravaAlteracaoDeCamposPrincipaisDaNotaDeEntrada;
end;

procedure TfrmCadCtaPagar.btnDetalharValoresBaixaClick(Sender: TObject);
  Var
    frmCtpDetalhesBaixa: TfrmCtpDetalhesBaixa;
begin
  inherited;
  pCriarFormularios(TfrmCtpDetalhesBaixa, frmCtpDetalhesBaixa);
  Try
    frmCtpDetalhesBaixa.dtsCtaPagar := qryTabela;
    frmCtpDetalhesBaixa.ShowModal;
  Finally
    FreeAndNil(frmCtpDetalhesBaixa);
  End;
end;

procedure TfrmCadCtaPagar.btnDocBaixaClick(Sender: TObject);
begin
  inherited;
  If qryTabela.RecordCount = 0 Then
  Begin
    fMensagem('ATENÇÃO!','É necessário CARREGAR uma duplicata BAIXADA para exibir os documentos!',['&O k']);
    Exit;
  End;

  If (qryTabela.RecordCount > 0)
  And (qryTabela.FieldByName('CTP_DTAPAG').IsNull) Then
  Begin
    fMensagem('ATENÇÃO!','A duplicata deve estar BAIXADA para exibir os documentos!',['&O k']);
    Exit;
  End;

  pCriarFormularios(TfrmCtrDocBaixa, frmCtrDocBaixa);
  Try
    frmCtrDocBaixa.SeqCon := qryTabela.FieldByName('CTP_SEQCON').AsInteger;
    frmCtrDocBaixa.EmpBai := qryTabela.FieldByName('CTP_EMPBAI').AsString;
    frmCtrDocBaixa.NomeTabela := 'CADPAG';

    frmCtrDocBaixa.ShowModal;
  Finally
    FreeAndNil(frmCtrDocBaixa);
  End;
end;

procedure TfrmCadCtaPagar.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(btnIncluir);
end;

procedure TfrmCadCtaPagar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  If (Action <> CaNone) Then
  Begin
    FreeAndNil(qryCadBco);
    lstBcoFor.Clear;
  End;
end;

function TfrmCadCtaPagar.fBaixaCtp: Boolean;
  Var
    strAutoincrem: String;
    frmBaixaCtaPagar: TfrmBaixaCtaPagar;
begin
  fLock_Unlock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString, False);
  SetLength(arrSeqLanLoc, 0);
  Try
    strAutoincrem  := qryTabela.FieldByName('AUTOINCREM').AsString;
    if blnTelaReduzida then
    begin
      pCriarFormularios(TfrmBaixaCtaPagar, frmBaixaCtaPagar);
      frmBaixaCtaPagar.strChamada := '[frmCadCtaPagar.fBaixaCtp]';
      frmBaixaCtaPagar.pnlCabecalho.Enabled := False;
      frmBaixaCtaPagar.pnlCabecalho.Visible := False;
      frmBaixaCtaPagar.strAutIncManCtp := strAutoincrem;
      frmBaixaCtaPagar.btnIniBus.Enabled         := False;
      frmBaixaCtaPagar.btnLocProx.Enabled        := False;
      frmBaixaCtaPagar.btnMarcarTodas.Enabled    := False;
      frmBaixaCtaPagar.btnDesmarcarTodas.Enabled := False;
      frmBaixaCtaPagar.btnSelecionadas.Enabled   := False;

      if dteDataVenLoc <> 0 then
        frmBaixaCtaPagar.dteDtaPagFix   := dteDataVenLoc;
      if strCodPorLoc  <> '' then
        frmBaixaCtaPagar.strCodPorFix   := strCodPorLoc;
      if fltValLanLoc <> 0 then
        frmBaixaCtaPagar.fltValorBaixa  := fltValLanLoc;

      Sleep(1000); //NÃO RETIRAR
      frmBaixaCtaPagar.btnConsultar.Click;
      frmBaixaCtaPagar.ShowModal;

      If Not fEmptyStr(frmBaixaCtaPagar.recUltDupBaixada.strSeqLan) Then
        recUltDupBaixada := frmBaixaCtaPagar.recUltDupBaixada;

      arrSeqLanLoc := frmBaixaCtaPagar.arrSeqLan;
      Result := True;
    end
    else
    begin
      pCriarFormularios(TfrmBaixaCtaPagar, frmBaixaCtaPagar);
      frmBaixaCtaPagar.strChamada := '[frmCadCtaPagar.fBaixaCtp]';
      frmBaixaCtaPagar.ShowModal;

      Result := True;
    end;

    FreeAndNil(qryTabela);
    qryTabela           := fCriarQuery('SELECT * FROM CADPAG WHERE AUTOINCREM = ' + QuotedStr(strAutoincrem)+ ' ', Self);
    qryTabela.AfterOpen := pAfterOpen;
    dtsTabela.DataSet   := qryTabela;
    qryTabela.Open;

    {***************************************************************************************************************}
    {* SE A DUPLICATA FOR BAIXADA, E, ANTES DA TELA DE BAIXA FOR FECHADA OUTRA ESTAÇÃO CARREGAR A MESMA DUPLICATA, *}
    {* O SISTEMA DEVE FICAR VERIFICANDO QUANDO A DUPLICATA ESTIVER SIDO LIBERADA PARA ASSIM SEGUIR. ****************}
    {* POR ISSO O PARÂMENTRO blnLoopTravamento ESTÁ TRUE ***********************************************************}
    {***************************************************************************************************************}
    If Not fLock_Unlock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString, True, False) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esta duplicata está sendo utilizada por outra estação: ' + fGetHostLock(strNomeTabela + qryTabela.FieldByName('AUTOINCREM').AsString), ['&Ok']);

      qryTabela             := fCriarQuery('SELECT * FROM CADPAG WHERE FALSE', Self);
      qryTabela.AfterOpen   := pAfterOpen;
      qryTabela.AfterScroll := pAfterScroll;
      dtsTabela.DataSet := qryTabela;
      pLimparEdits;

      Exit;
    End;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmCadCtaPagar.fBaixaCtp]');
    End;
  End;

  pFreeAndNil(frmBaixaCtaPagar);
  blnTelaReduzida := False;
End;

procedure TfrmCadCtaPagar.btnBaixarDupClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaAcessoSistema('frmBaixaCtaPagar') Then
    Exit;

  SetLength(arrSeqLanLoc, 0);
  Try
    if (fCfgSis('CTPCDA', varBoolean))
    and (dtsTabela.DataSet.FieldByName('CTP_DTABAI').IsNull)
    and (dtsTabela.DataSet.RecordCount > 0)
    and not(dtsTabela.DataSet.FieldByName('CTP_NUMDUP').IsNull) then
      blnTelaReduzida := True;
    fBaixaCtp;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCadCtaPagar.btnBaixarDupClick]');
  End;

  //fBuscaPorCamposChave;
  pCarregaCompetencia;
  pCarregaDadosAdicionais;
  pCalculaValorTotal;
  pHabilitaFields;

  if Length(arrSeqLanLoc) > 0 then
  begin
    btnSair.Click;
    Exit;
  end;
end;

//MF: 286456 - 01/06/2023 - verificação se é reimpressão, e se possui direito para reimprimir Recibo.
function TfrmCadCtaPagar.fVerificaReimpressaoCP(strNumDup, strParcel, strSerie, strCodEmp, strCodFor, strNomFor, strDtaCad: String): Boolean;
begin
    Result := True;

    if (fCPJaImpresso(strNumDup, strParcel, strSerie, strCodEmp, strCodFor)) Then
    Begin
      If (Not fVerificaAcessoSistema('RMPCPG', strLoginUsuarioLogado)) Then //MF: 286456
      Begin
        objLiberacao.Clear;
        objLiberacao.pInformaNumDocEspDocCodEmp(strNumDup +
                                                strParcel,
                                                '',
                                                strCodEmp);

        objLiberacao.objMsgLibera.pAddTexto('Não é permitido reimprimir Comprovante de Pagamento');
        objLiberacao.objMsgLibera.pAddQuebra;
        objLiberacao.objMsgLibera.pAddTextoCaption('Data de cadastro', strDtaCad                    , 16);
        objLiberacao.objMsgLibera.pAddTextoCaption('Duplicata'       , strNumDup                    , 16);
        objLiberacao.objMsgLibera.pAddTextoCaption('Parcela'         , strParcel                    , 16);
        objLiberacao.objMsgLibera.pAddTextoCaption('Série'           , strSerie                     , 16);
        objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'         , strCodEmp                    , 16);
        objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor'      , strCodFor+ ' - ' + strNomFor , 16);

        objLiberacao.strDirAce := 'RMPCPG';
        objLiberacao.strSenLib := fCfgSis('SENFVU');
        objLiberacao.strMsgSen := 'Reimprimir Comprovante de Pagamento';
        objLiberacao.strCodOpe := strLoginUsuarioLogado;
        objLiberacao.strCodDig := strLoginUsuarioLogado;
        objLiberacao.tipCliFor := cfFornecedor;

        If (Not objLiberacao.fLibera) Then
        Begin
          fMensagem('ATENÇÃO!','Não é permitido reimprimir Comprovante de Pagamento', ['&O K']);
          Result := False;
        End
        Else
          Result := True;
      End;
    End;
end;

{**************}
{* IMPRIME CP *}
{***********AF*}
procedure TfrmCadCtaPagar.pImprimeCP;
begin
  If (fVerificaReimpressaoCP(dbeNumDup.Text,
                             dbeParcel.Text,
                             dbeSerie.Text,
                             dbeCodEmp.Text,
                             dbeCodFor.Text,
                             edtNomFor.Text,
                             dbeDtaCad.Text)) Then//MF: 286456 - 02/06/2023
    ImprimeCP(dbeNumDup.Text,
              dbeParcel.Text,
              dbeCodEmp.Text,
              dbeCodFor.Text,
              dbeSerie.Text,
              Self.Name);

end;

procedure TfrmCadCtaPagar.pLimpaCTPCom(strCTPCom: String);
Var
  qryCTPCom: TUniQuery;
  strSQL   : String;
begin
  qryCTPCom := fCriaQuery(Self);

  Try
    strSQL := '';
    strSQL := strSQL + 'UPDATE CADREC  SET CTR_CTPCOM = NULL WHERE CTR_CTPCOM = :CTPCOM; ';
    strSQL := strSQL + 'UPDATE DUPAGR  SET CTR_CTPCOM = NULL WHERE CTR_CTPCOM = :CTPCOM; ';
    strSQL := strSQL + 'UPDATE CTRCNF  SET CTR_CTPCOM = NULL WHERE CTR_CTPCOM = :CTPCOM; ';
    strSQL := strSQL + 'UPDATE CADCHQ  SET CHQ_CTPCOM = NULL WHERE CHQ_CTPCOM = :CTPCOM; ';
    strSQL := strSQL + 'UPDATE MOVCAR  SET MCA_CTPCOM = NULL WHERE MCA_CTPCOM = :CTPCOM; ';

    qryCTPCom.SQL.Text := strSQL;
    qryCTPCom.ParamByName('CTPCOM').AsString := strCTPCom;
    qryCTPCom.ExecSQL;
    qryCTPCom.Close;

    qryCTPCom.SQL.Text := 'DELETE FROM AGRCOM WHERE COM_CTPCOM=:CTPCOM';
    qryCTPCom.ParamByName('CTPCOM').AsString := strCTPCom;
    qryCTPCom.ExecSQL;
    qryCTPCom.Close;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[pLimpaCTPCom]');
    End;
  End;

  FreeAndNil(qryCTPCom);
end;

procedure TfrmCadCtaPagar.pHabilitaBotoes;
 Var blnEhEntradaMercadorias,
     blnTemDesmebramento : Boolean;
begin

  If fEmptyStr(dbeCodFor.Text) Then
    Exit;

  btnDesmembr.Enabled  := False;
  btnEstorno.Enabled   := False;

  blnEhEntradaMercadorias := fEntradaDeMercadorias;

  If (qryTabela.State <> dsBrowse) Then
  Begin

    blnTemDesmebramento  := fTemDesmembramento;

    {********************************************************}
    {* SÓ PODE DESMEMBRAR SE TEM ACESSO PARA ALTERAR VALDUP *}
    {*****************************************************JU*}
    btnDesmembr.Enabled  := (fVerificaAcessoSistema('CTPALTVLR')) And
                            (Not blnTravarDes) And
                            (
                             ((blnEhEntradaMercadorias) And (blnTemDesmebramento))
                             Or (Not blnEhEntradaMercadorias)
                            );
  End
  Else
  Begin
    btnEstorno.Enabled := (Not qryTabela.IsEmpty) And (blnBaixada) And (fVerificaAcessoSistema('frmEstornoCtaPagar'));
  End;

  btnAltNumDoc.Enabled := (btnAlterar.enabled)            And
                          (Not blnBaixada)                And
                          (Not fEmptyStr(dbeCodEmp.Text)) And
                          (Not fEmptyStr(dbeCodFor.Text)) And
                          (Not dbeNumDup.Enabled)         And
                          (Not blnTravarAlt)              And
                          (Copy(dbeNumDup.Text, 1, 2) <> 'AG') And
                          (fRetSeqBaiCadPag(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                                            qryTabela.FieldByName('CTP_PARCEL').AsString,
                                            qryTabela.FieldByName('CTP_CODEMP').AsString,
                                            qryTabela.FieldByName('CTP_CODFOR').AsString,
                                            qryTabela.FieldByName('CTP_SERIE_').AsString) = 0);

  btnAjuVal.Enabled := btnAltNumDoc.Enabled;

  pHabilitaDesabiltabtnAbrirPastaAnexos;

  btnEspelhoNotaFiscal.Enabled := fDuplicataPossuiMovGer;

  FEntradaDeMercadoriaQueNaoChegouNaEmpresa := EntradaDeMercadoriaQueNaoChegouNaEmpresa(qryTabela.FieldByName('CTP_NUMDUP').AsString,
                                                                                        qryTabela.FieldByName('CTP_SERIE_').AsString,
                                                                                        qryTabela.FieldByName('CTP_CODEMP').AsString,
                                                                                        qryTabela.FieldByName('CTP_CODFOR').AsString);

  btnRomaneio.Enabled := (btnAlterar.enabled)            And
                         (Not fEmptyStr(dbeCodEmp.Text)) And
                         (Not fEmptyStr(dbeCodFor.Text)) And
                         (Not fEmptyStr(dbeNumDup.Text)) And
                         (Not dbeNumDup.Enabled)         And
                         (Not blnTravarAlt)              And
                          fCfgSis('CTPROM', varBoolean);

  btnLiberacaoBaixa.Enabled := (qryTabela.FieldByName('AUTOINCREM').IsNull)   or
                               (
                                  (qryTabela.FieldByName('CTP_DTALIB').IsNull) And
                                  (qryTabela.FieldByName('CTP_DTAPAG').IsNull) And
                                  fCfgSis('CTPLBB', varBoolean)
                               );


  btnPendLiberacao.Enabled := (not qryTabela.FieldByName('AUTOINCREM').IsNull) And
                              (Not qryTabela.FieldByName('CTP_DTALIB').IsNull) And
                              (qryTabela.FieldByName('CTP_DTAPAG').IsNull)     And
                               fCfgSis('CTPLBB', varBoolean)                   And
                               fVerificaAcessoSistema('TPLIBCTPBX', strLoginUsuarioLogado);

  {If Assigned(qryTabela) Then
  Begin
    If (qryTabela.State = dsEdit) Then
    Begin
      If fCfgSis('UTICON', varBoolean) Then
         fraPlanoDeContas.dbeCodCta.Enabled := fraPlanoDeContas.dbeCodCta.Enabled And (Not blnEhEntradaMercadorias);
    End;
  End;}

end;

procedure TfrmCadCtaPagar.pHabilitaDesabiltabtnAbrirPastaAnexos;
begin
  If (qryTabela.Active)      And
     Not (qryTabela.IsEmpty) Then
    btnAbrirPastaAnexos.Enabled := Not (qryTabela.State = dsInsert);
end;

procedure TfrmCadCtaPagar.pHabilitaFields;
  Var
    blnEmEdicao: Boolean;
begin
  blnEmEdicao := qryTabela.State in [dsInsert, dsEdit];

  dbeCompet.Enabled := blnEmEdicao;

  blnEmEdicao := (blnEmEdicao) And (qryTabela.FieldByName('CTP_DTAPAG').IsNull);
  btnEspelhoNotaFiscal.Enabled := fDuplicataPossuiMovGer;

  lblVendor.Enabled := (blnUsaVendor) And (blnEmEdicao);
  dbeVendor.Enabled := (blnUsaVendor) And (blnEmEdicao);

  {********************************************************************}
  {* SE O CAMPO NO BANCO DE DADOS ESTIVER NULL OU SE TIVER PREENCHIDO *}
  {* VALIDA O ENABLED CASO TENHA VALOR NO CAMPO EM TELA. **************}
  {* ISSO GARANTE QUE SE O CAMPO NO BANCO DE DADOS ESTIVER VAZIO, NÃO *}
  {* DÊ ERRO DE CONVERSÃO DE STRING E INTEGER. ************************}
  {*REQ*143089******************************************************MO*}
  if (qryTabela.FieldByName('CTP_Q_GUIA').IsNull) Or
     not fEmptyStr(qryTabela.FieldByName('CTP_Q_GUIA').AsString) Then
  begin
    lblValorOutrasEntidades.Enabled := (LcbGuiaTributo.KeyValue = 1) and
                                       (LcbTipoTributo.KeyValue = '2100') and
                                       (blnEmEdicao);
    dbeValorOutrasEntidades.Enabled := (LcbGuiaTributo.KeyValue = 1) and
                                       (LcbTipoTributo.KeyValue = '2100') and
                                       (blnEmEdicao);
  end
  else
  begin
    lblValorOutrasEntidades.Enabled := False;
    dbeValorOutrasEntidades.Enabled := False;
  end;

  dbeValorOutrasEntidades.Visible := qryTabela.FieldByName('CTP_DTAPAG').IsNull;
  dbeVendor.Visible               := qryTabela.FieldByName('CTP_DTAPAG').IsNull;
end;

procedure TfrmCadCtaPagar.pCarregaEventos;
  Var
    blnTemCtpDet: Boolean;
    blnRatEve : Boolean;
begin
  If fEmptyStr(fraCentroCusto.dbeCodEve.Text) Then
  Begin
    blnTemCtpDet := fVerificaCtpDet(dbeNumDup.Text,
                                    dbeParcel.Text,
                                    dbeSerie.Text,
                                    dbeCodEmp.Text,
                                    dbeCodFor.Text,
                                    blnRatEve);

    If blnTemCtpDet And blnRatEve Then
    Begin
      fraCentroCusto.dbeCodEve.Text := fCfgSis('EVEPRI');
    End;
  End;

  If Not fEmptyStr(fraCentroCusto.dbeCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.dbeCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmCadCtaPagar.dbeDeposiChange(Sender: TObject);
begin
  inherited;
  pTrataBcoFor;
end;

procedure TfrmCadCtaPagar.dbeDtaCadExit(Sender: TObject);
begin
  If (fEmptyStr(fTiraCaracEspeciais(dbeDtaCad.Text))) Then
    dbeDtaCad.Field.Value := Null;

  inherited;
end;

function TfrmCadCtaPagar.fPodeAlterarDocumento: Boolean;
begin
  Result := True;

  If (qryTabela.State = dsEdit) Then
  Begin
    SelectNext(ActiveControl, True, True);
    If ((dbeNumDup.Text <> qryTabela.FieldByName('CTP_NUMDUP').OldValue) OR
        (dbeCodEmp.Text <> qryTabela.FieldByName('CTP_CODEMP').OldValue) OR
        (dbeCodFor.Text <> qryTabela.FieldByName('CTP_CODFOR').OldValue) OR
        (dbeParcel.Text <> qryTabela.FieldByName('CTP_PARCEL').OldValue) OR
        (dbeSerie.Text  <> qryTabela.FieldByName('CTP_SERIE_').OldValue)) Then
    Begin
      If fBuscaDuplicata Then
      Begin
        fMensagem('','Duplicata já cadastrada!', ['OK']);
        AAlterouChave := False;
        Result := False;
      End
      Else If fMensagem('', 'Confirma alteração do documento / empresa  / Fornecedor / Parcela / Série da Duplicata?',['','']) = 1 Then
      begin
        AAlterouChave := True;
        Result := True;
      end
      Else
      begin
        AAlterouChave := False;
        Result := False;
      end;
    End;

  End;
end;

function TfrmCadCtaPagar.fPodeAlterarPlanoContaDuplicataContabilizada: Boolean;
begin
  Result := True;

  If fVerificaDuplicataContabilizada And (objFechamento.FechamentoFinanceiroJaRealizado(qryTabela.FieldByName('CTP_CODEMP').AsString,
    qryTabela.FieldByName('CTP_DTACAD').AsDateTime, False)) Then
  Begin
    fMensagem('ATENÇÃO', 'Não é possível alterar o plano de conta da duplicata após os fechamentos financeiros', ['&Ok']);
    Exit(False);
  End;

  If fVerificaDuplicataContabilizada Then
  Begin
    If Not fVerificaAcessoSistema('PALTDUPCON', strLoginUsuarioLogado) Then
    Begin
      If Not blnValPlanoCusto Then
        Result := fDigSenVarDuplicataContabilizada;
    End;
  End;
end;


function TfrmCadCtaPagar.fPodeAlterarValoresAposFechamentoFinanceiro(Sender: TObject): Boolean;
var
  datDtaDup     : TDate;
  datDataFecFin : TDateTime;
  strEmpDup     : String;
  strNomeCampo  : String;
  strCampoDB    : String;
  fltValAtual   : Double;
  fltValNovo    : Double;
begin
  Result := True;

  if Sender = dbeDesSuj then
  begin
    strNomeCampo := 'Desconto';
    strCampoDB   := 'CTP_DESSUJ';
  end
  else if Sender = dbeJurSuj then
  begin
    strNomeCampo := 'Juros';
    strCampoDB   := 'CTP_JURSUJ';
  end
  else if Sender = dbeMulSuj then
  begin
    strNomeCampo := 'Multa';
    strCampoDB   := 'CTP_MULSUJ';
  end
  else
    Exit;

  try
    datDtaDup   := qryTabela.FieldByName('CTP_DTACAD').AsDateTime;
    strEmpDup   := qryTabela.FieldByName('CTP_CODEMP').AsString;
    fltValAtual := qryTabela.FieldByName(strCampoDB).AsFloat;
    fltValNovo  := fStrToFloat((Sender as TDBEditFocus).Text);

    if objFechamento.FechamentoFinanceiroJaRealizado(strEmpDup, datDtaDup, False) then
    begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('ALTERAÇÃO DE ' + UpperCase(strNomeCampo) +
                                          ' NA MANUTENÇÃO DE CONTAS A PAGAR APÓS FECHAMENTO FINANCEIRO');
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddTextoCaption('Data de cadastro'    , dbeDtaCad.Text                                                           );
      objLiberacao.objMsgLibera.pAddTextoCaption('Duplicata'           , qryTabela.FieldByName('CTP_NUMDUP').AsString                             , 11);
      objLiberacao.objMsgLibera.pAddTextoCaption('Parcela'             , qryTabela.FieldByName('CTP_PARCEL').AsString                             , 11);
      objLiberacao.objMsgLibera.pAddTextoCaption('Série'               , qryTabela.FieldByName('CTP_SERIE_').AsString                             , 11);
      objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'             , qryTabela.FieldByName('CTP_CODEMP').AsString                             , 11);
      objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor'          , qryTabela.FieldByName('CTP_CODFOR').AsString + ' - ' + edtNomFor.Text    , 11);
      objLiberacao.objMsgLibera.pAddTextoCaption(strNomeCampo          , FormatFloat('R$ ###,##0.00', fltValAtual)                                , 11);
      objLiberacao.objMsgLibera.pAddTextoCaption('Novo ' + strNomeCampo, FormatFloat('R$ ###,##0.00', fltValNovo)                                 , 11);

      objLiberacao.strDirAce := 'PERALTVENDORCTAPAGARCOMFECFIN';
      objLiberacao.strMsgSen := 'Alterar ' + strNomeCampo;
      objLiberacao.pInformaNumDocEspDocCodEmp(qryTabela.FieldByName('CTP_NUMDUP').AsString, EmptyStr, VS_strCodEmp);
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.tipCliFor := cfFornecedor;

      if not objLiberacao.fLibera then
      begin
        datDataFecFin := objFechamento.DataFechamento(strEmpDup);
        fMensagem('ATENÇÃO!',
                  'Não é permitido alterar o campo ' + QuotedStr(strNomeCampo) + ', ' +
                  'pois existe um fechamento financeiro para a empresa.' + #13#10 +
                  'Empresa: ' + strEmpDup + ' - ' + 'último Fechamento: ' + DateTimeToStr(datDataFecFin),
                  ['&OK']);
        Result := False;
      end;
    end;
  except
    on E: Exception do
      raise Exception.Create('Problemas ao validar fechamento financeiro. ' +
                             '> TfrmCadCtaPagar.fPodeAlterarValoresAposFechamentoFinanceiro. ' +
                             E.Message);
  end;
end;

function TfrmCadCtaPagar.fPodeAlterarVendor: Boolean;
var
  datDtaDup: TDate;
  datDataFecFin: TDateTime;
  strEmpDup: String;
  fltValVendor: Double;
begin
  Result := True;

  try
    datDtaDup := qryTabela.FieldByName('CTP_DTACAD').AsDateTime;
    strEmpDup := qryTabela.FieldByName('CTP_CODEMP').AsString;
    fltValVendor := fStrToFloat(qryTabela.FieldByName('CTP_VENDOR').AsString);

    if objFechamento.FechamentoFinanceiroJaRealizado(strEmpDup,
                                                     datDtaDup,
                                                     False) then
    begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('ALTERAÇÃO DO VENDOR NA MANUTENÇÃO DE CONTAS A PAGAR APÓS FECHAMENTO FINANCEIRO');
      objLiberacao.objMsgLibera.pAddQuebra;
      objLiberacao.objMsgLibera.pAddTextoCaption('Data de cadastro', dbeDtaCad.Text);
      objLiberacao.objMsgLibera.pAddTextoCaption('Duplicata' , qryTabela.FieldByName('CTP_NUMDUP').AsString                              , 11);
      objLiberacao.objMsgLibera.pAddTextoCaption('Parcela'   , qryTabela.FieldByName('CTP_PARCEL').AsString                              , 11);
      objLiberacao.objMsgLibera.pAddTextoCaption('Série'     , qryTabela.FieldByName('CTP_SERIE_').AsString                              , 11);
      objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'   , qryTabela.FieldByName('CTP_CODEMP').AsString                              , 11);
      objLiberacao.objMsgLibera.pAddTextoCaption('Fornecedor', qryTabela.FieldByName('CTP_CODFOR').AsString + ' - ' + edtNomFor.Text     , 11);
      objLiberacao.objMsgLibera.pAddTextoCaption('Vendor'    , FormatFloat('R$ ###,##0.00', fltValVendor)                                , 11);
      objLiberacao.objMsgLibera.pAddTextoCaption('Novo Vendor', FormatFloat('R$ ###,##0.00', fStrToFloat(dbeVendor.Text))                , 11);

      objLiberacao.strDirAce := 'PERALTVENDORCTAPAGARCOMFECFIN';
      objLiberacao.strMsgSen := 'Alterar Vendor';
      objLiberacao.pInformaNumDocEspDocCodEmp(qryTabela.FieldByName('CTP_NUMDUP').AsString, EmptyStr, VS_strCodEmp);
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.tipCliFor := cfFornecedor;

      If (Not objLiberacao.fLibera) Then
      Begin
        datDataFecFin := objFechamento.DataFechamento(strEmpDup);

        fMensagem('ATENÇÃO!','Não é permitido alterar o campo ' + QuotedStr('Vendor') + ', ' +
                             'pois existe um fechamento financeiro para a empresa.' + #13#10 +
                             'Empresa: ' + strEmpDup  + ' - ' + 'Último Fechamento: ' + DateTimeToStr(datDataFecFin), ['&O K']);
        Result := False;
      End;
    end;
  except
    On E: Exception do
    begin
      raise Exception.Create('Problemas ao validar fechamento financeiro. ' +
                             '> TfrmCadCtaPagar.fPodeAlterarVendor. ' + E.Message);
    end;
  end;
end;

function TfrmCadCtaPagar.fraPlanoDeContasdbeCodCtaChamaCadastro(
  Key: Word): string;
begin
  inherited;
  Result := fChamaCadCta(Key);
end;

procedure TfrmCadCtaPagar.fraPlanoDeContasdbeCodCtaExit(Sender: TObject);
begin
  inherited;
  fraPlanoDeContas.dbeCodCtaExit(Sender);
end;

procedure TfrmCadCtaPagar.fraPlanoDeContasdbeCodCtaKeyPress(Sender: TObject;
  var Key: Char);
Var
  arrCentroCusto : TConsultasArray;
begin
  inherited;
  {*****************************************}
  {* NOVA CONSULTA DE CENTRO DE CUSTO      *}
  {**************************************DP*}
  If Key = '/' Then
  Begin

    If Not fCfgSis('USACTF', varBoolean) Then
    Begin
      If fPesqCentroCusto(Self, fraPlanoDeContas.dbeCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
      Begin
        If (fValidaCampos(fraPlanoDeContas.dbeCodCta, True)) Then
          Self.SelectNext(ActiveControl, True, True);
        pCarregaCentroCusto;
      End;
    End
    Else
    Begin
      If fPesqCentroCusto(Self, fraPlanoDeContas.dbeCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto, True, True, dbeCodFor.Field.AsString) Then
      Begin
        If (fValidaCampos(fraPlanoDeContas.dbeCodCta, True)) Then
          Self.SelectNext(ActiveControl, True, True);
        pCarregaCentroCusto;
      End;
    End;
  End;
end;


function TfrmCadCtaPagar.fRetCodBarLinDig(strLinDig: String): String;
begin

  Result := Copy(strLinDig, 01, 04) + Copy(strLinDig, 33, 15) + Copy(strLinDig, 05, 05) +
            Copy(strLinDig, 11, 08) + Copy(strLinDig, 19, 02) + Copy(strLinDig, 22, 10); 

end;

procedure TfrmCadCtaPagar.frxGenGetValue(const VarName: String;
  var Value: Variant);
begin
  inherited;

  If AnsiUpperCase(VarName) = AnsiUpperCase('intQtdReg') Then
  Begin
    Value := intQtdReg;
  End;

  If VarName = 'EMP_NOMEMP' Then
    Value := fRetNomeEmpresa(VS_strCodEmp)

  Else If VarName = 'REL_NOMREL' Then
    Value := Self.Name;
end;

function TfrmCadCtaPagar.fTornaPendLiberacao(AAltCad:Boolean = False): Boolean;
var
  objLibera: TLiberaBaixaPagar;
begin
  objLibera := TLiberaBaixaPagar.Create(Self.Name);
  Try
    try

      objLibera.pCancLiberacao(qryTabela.FieldByName('AUTOINCREM').AsString);

      if not AAltCad then
        fMensagem('', 'Liberação cancelada com sucesso!', ['&Ok']);

      Result := true;

    except on E: Exception do
      begin
        Result := False;
        raise;
      end;
    end;

  Finally
    FreeAndNil(objLibera);
  End;
end;

function TfrmCadCtaPagar.fTemDesmembramento: Boolean;
var
  qryGen: TUniQuery;
Begin
  qryGen := fCriaQuery;
  Try
    Result := False;

    If (Not fEmptyStr(dbeNumDup.Text)) Then
    Begin
      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT       ');
        SQL.Add(' CTP_NUMDUP  ');
        SQL.Add('FROM         ');
        SQL.Add('  CTPDET     ');
        SQL.Add('WHERE        ');
        SQL.Add('     CTP_NUMDUP = :NUMDUP ');
        SQL.Add(' AND CTP_CODFOR = :CODFOR ');
        SQL.Add(' AND CTP_PARCEL = :PARCEL ');
        SQL.Add(' AND CTP_EMPORI = :CODEMP ');
        SQL.Add(' AND CTP_SERIE_ = :SERIE_ ');

        ParamByName('NUMDUP').AsString := dbeNumDup.Text;
        ParamByName('CODFOR').AsString := dbeCodFor.Text;
        ParamByName('PARCEL').AsString := dbeParcel.Text;
        ParamByName('CODEMP').AsString := dbeCodEmp.Text;
        ParamByName('SERIE_').AsString := dbeSerie.Text;

        Open;

        Result := Not IsEmpty;

        Close;
      End;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}
procedure TfrmCadCtaPagar.dbeCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
    chrKey: Char;
begin
  inherited;
  chrKey := '/';
  If fEntraCons(Key) Then
  Begin
    Key := #0;
    if fPesqPortador(conSimples,
                     Self,
                     dbeCodPor,
                     edtNomPor,
                     nil,
                     chrKey,
                     arrSel,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     dbeCodEmp.Text) then
    Begin
      If fValidaCampos(dbeCodPor, False) Then
        Self.SelectNext(ActiveControl, True, True);
    End;

  End;
end;

procedure TfrmCadCtaPagar.dbeCodPrjKeyPress(Sender: TObject; var Key: Char);
  Var
    arrPrj : TConsultasArray;
begin
  If fPesqProjetos(Self, dbeCodPrj, edtDesPrj, nil, Key, arrPrj) Then
  Begin
    If fValidaCampos(dbeCodPrj, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCtaPagar.dbeCtaBaiKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCentroCusto : TConsultasArray;
    strMask        : String;
begin
  inherited;
  If Key = '/' Then
  Begin
    strMask := dtsTabela.DataSet.FieldByName('CTP_CTABAI').EditMask;
    dtsTabela.DataSet.FieldByName('CTP_CTABAI').EditMask := '';
    If Not fCfgSis('USACTF', varBoolean) Then
    Begin
      If fPesqCentroCusto(Self, dbeCtaBai, edtDesCtaBai, Nil, Key, arrCentroCusto) Then
      Begin
        If (fValidaCampos(dbeCtaBai, True)) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
    End
    Else
    Begin
      If fPesqCentroCusto(Self, dbeCtaBai, edtDesCtaBai, Nil, Key, arrCentroCusto, True, True, dbeCodFor.Field.AsString) Then
      Begin
        If (fValidaCampos(dbeCtaBai, True)) Then
          Self.SelectNext(ActiveControl, True, True);
      End;
    End;
    dtsTabela.DataSet.FieldByName('CTP_CTABAI').EditMask := strMask;
  End;
end;

function TfrmCadCtaPagar.dbeCodPorChamaCadastro(Key: Word): String;
begin
  inherited;

  Result := fChamaCadPor(Key);

end;

procedure TfrmCadCtaPagar.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, dbeCodPor.Text);
  With qryConPor Do
  Begin
    edtNomPor.Text := FieldByName('POR_NOMPOR').AsString;
  End;
end;

procedure TfrmCadCtaPagar.pCarregaProjeto;
begin
  pPesquisaCadPrj(Nil, qryConPrj, dbeCodPrj.Text);
  With qryConPrj Do
  Begin
    edtDesPrj.Text := FieldByName('PRJ_DESPRJ').AsString;
  End;
end;

procedure TfrmCadCtaPagar.dbeValDupEnter(Sender: TObject);
begin
  inherited;

  If (dbeValDup.Field Is TFloatField) Then
    dbeValDup.Text := AnsiReplaceStr(dbeValDup.Text,'.','');

end;

procedure TfrmCadCtaPagar.dbeValDupExit(Sender: TObject);
begin
  inherited;
  pCalculaValorTotal;
end;

procedure TfrmCadCtaPagar.dbeValorOutrasEntidadesEnter(Sender: TObject);
begin
  inherited;
  If (dbeValorOutrasEntidades.Field Is TFloatField) Then
    dbeValorOutrasEntidades.Text := AnsiReplaceStr(dbeValorOutrasEntidades.Text,'.','');
end;

procedure TfrmCadCtaPagar.LcbGuiaTributoExit(Sender: TObject);
begin
  inherited;
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

  if Not LcbTipoTributo.CanFocus then
    pSetFocus(dbeDtaVen);
end;

procedure TfrmCadCtaPagar.dtsTabelaStateChange(Sender: TObject);
begin
  inherited;
  pTrataBcoFor;
end;

procedure TfrmCadCtaPagar.dbeHisto1KeyPress(Sender: TObject;
  var Key: Char);
  Var
    strKey: String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key    := strKey[1];
end;

procedure TfrmCadCtaPagar.dbeNumDupChange(Sender: TObject);
begin
  inherited;
  btnExcluirAut.Visible := (Pos('G',dbeNumDup.Text) > 0);
end;

procedure TfrmCadCtaPagar.dbeQtdDiaEnter(Sender: TObject);
begin
  inherited;
  HintControler.ShowHint(Self.Left + dbeQtdDia.Left + dbeQtdDia.Width + 7,
                        60 + Self.Top + dbeQtdDia.Top + dbeQtdDia.Height, 'Dias para Desconto:',
                        'Se o valor informado for igual a 0, o desconto será dado ' + #13 +
                        'até a Data do Vencimento. Se o valor informado for maior que 0, ' + #13 +
                        'o desconto será dado dias antes da Data do Vencimento.');
end;

procedure TfrmCadCtaPagar.dbeQtdDiaExit(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
end;

function TfrmCadCtaPagar.fDuplicataPossuiMovGer(strCodFor, strNumDup, strSerie_, strCodEmp: String; var strEspDoc: String; blnMensagem: Boolean = True): Boolean;
  Var
    strSql: String;
    qryGer: TUniQuery;
begin
  strEspDoc := '';

  strSql := '';
  strSql := strSql + ' SELECT SQL_NO_CACHE         ';
  strSql := strSql + '   GER_NUMDOC,               ';
  strSql := strSql + '   GER_ESPDOC,               ';
  strSql := strSql + '   GER_SERIE_,               ';
  strSql := strSql + '   GER_CODFOR,               ';
  strSql := strSql + '   AUTOINCREM                ';
  strSql := strSql + ' FROM                        ';
  strSql := strSql + '   MOVGER                    ';
  strSql := strSql + ' WHERE                       ';
  strSql := strSql + '   GER_CODFOR = :CODFOR AND  ';
  strSql := strSql + '   GER_NUMDOC = :NUMDOC AND  ';
  strSql := strSql + '   IFNULL(GER_SERIE_, "") = :SERIE_ AND  ';
  strSql := strSql + '   GER_CODEMP = :CODEMP AND  ';
  strSql := strSql + '   (GER_ESPDOC = "ESPNF" OR GER_ESPDOC = "ESPEL") AND  ';
  strSql := strSql + '   GER_TIP_FC = "F"          ';

  strSql := AnsiReplaceStr(AnsiReplaceStr(strSql, 'ESPEL','EL'), 'ESPNF','NF') + ' UNION ALL ' +
            AnsiReplaceStr(AnsiReplaceStr(strSql, 'ESPEL','PD'), 'ESPNF','PD');

  qryGer := fCriaQuery(Nil);

  With qryGer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSql);
    ParamByName('CODFOR').AsString := strCodFor;
    ParamByName('NUMDOC').AsString := strNumDup;
    ParamByName('SERIE_').AsString := strSerie_;
    ParamByName('CODEMP').AsString := strCodEmp;

    Open;

    Result    := Not IsEmpty;
    strEspDoc := FieldByName('GER_ESPDOC').AsString;

    FAutoIncremMovGer := FieldByName('AUTOINCREM').AsString;

    If Result And blnMensagem Then
      fMensagem('','Não é possível alterar, pois a duplicata está relacionada com o documento ' +
                   FieldByName('GER_NUMDOC').AsString + '-' + FieldByName('GER_ESPDOC').AsString,['&OK']);

  End;

  FreeAndNil(qryGer);

end;

function TfrmCadCtaPagar.fLiberaBaixaCtp: Boolean;
Var
  strAutoIncrem: String;
  frmCtpLiberacaoBaixa: TfrmCtpLiberacaoBaixa;
begin
  SetLength(arrSeqLanLoc, 0);
  Try
    strAutoIncrem  := qryTabela.FieldByName('AUTOINCREM').AsString;
    pCriarFormularios(TfrmCtpLiberacaoBaixa, frmCtpLiberacaoBaixa);
    frmCtpLiberacaoBaixa.strAutIncManCtp := strAutoIncrem;
    frmCtpLiberacaoBaixa.blnVeioMntPagar := True;

    If Not fEmptyStr(strAutoIncrem) Then
      frmCtpLiberacaoBaixa.btnConsultar.Click;

    frmCtpLiberacaoBaixa.ShowModal;
    Result := frmCtpLiberacaoBaixa.ModalResult = mrOk;

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[frmCadCtaPagar.fBaixaCtp]');
    End;
  End;
  pFreeAndNil(frmCtpLiberacaoBaixa);
end;

procedure TfrmCadCtaPagar.btnAltNumDocClick(Sender: TObject);
var
  strEspDoc: String;
begin
  inherited;
  If (Not btnAltNumDoc.Enabled) Or (Not btnAltNumDoc.Visible) Then
    Exit;

  if DuplicataGeradaDeKMRodados(qryTabela.FieldByName('CTP_NUMDUP').AsString + '-' +
                                qryTabela.FieldByName('CTP_PARCEL').AsString + '-' +
                                qryTabela.FieldByName('CTP_CODEMP').AsString + '-' +
                                qryTabela.FieldByName('CTP_CODFOR').AsString + '-' +
                                qryTabela.FieldByName('CTP_SERIE_').AsString) then
  begin
    fMensagem('ATENÇÃO',
              'Esta duplicata foi gerada a partir de um registro de KM rodados. ' +
              'Se você alterar a chave do documento, o registro correspondente também será atualizado.',
              ['&OK']);
  end;

  btnAlterar.Click;
  If Not fVerificaAcessoSistema('CTPALTDUP', strLoginUsuarioLogado) Then
  Begin
    fMensagem('','Usuário não possui direitos de acesso para esta operação!', ['&OK']);
  End
  Else If (fVerificaCampos) And (Not fDuplicataPossuiMovGer(dbeCodFor.Text, dbeNumDup.Text, dbeSerie.Text, dbeCodEmp.Text, strEspDoc)) Then
  Begin
    blnAlterandoChave := True;

    pEnabled(self, false);
    pDesabilitaFields;

    If Not blnBaixada Then
      dbeCodEmp.Enabled := True;

    dbeNumDup.Enabled := True;
    dbeCodFor.Enabled := True;
    dbeParcel.Enabled := True;
    dbeSerie.Enabled  := True;
    btnAltNumDoc.Enabled := False;
    btnDesmembr.Enabled  := False;
    blnTravarDes := True;
    blnTravarAlt := True;

    ANumDupAnterior  := qryTabela.FieldByName('CTP_NUMDUP').AsString;
    AParcelaAnterior := qryTabela.FieldByName('CTP_PARCEL').AsString;
    ASeqBaiAnterior  := qryTabela.FieldByName('CTP_SEQBAI').AsInteger;
    ACodEmpAnterior  := qryTabela.FieldByName('CTP_CODEMP').AsString;
    ACodForAnterior  := qryTabela.FieldByName('CTP_CODFOR').AsString;
    ASerieAnterior   := qryTabela.FieldByName('CTP_SERIE_').AsString;

    If Not blnBaixada Then
      pSetFocus(dbeNumDup)
    Else
      pSetFocus(dbeCodFor);
  End;
end;

procedure TfrmCadCtaPagar.dbeTipDocEnter(Sender: TObject);
begin
  inherited;
  HintControler.ShowHint(Self.Left + dbeTipDoc.Left + dbeTipDoc.Width,
                        65 + Self.Top + dbeTipDoc.Top + dbeTipDoc.Height, 'Tipos de Documento:', dbeTipDoc.Hint);
end;

procedure TfrmCadCtaPagar.dbeTipDocExit(Sender: TObject);
begin
  inherited;
  HintControler.HideHint;
  fValidaCampos(dbeTipDoc);
end;

function TfrmCadCtaPagar.fBuscaDuplicata: Boolean;
  Var
    strSQL: String;
    qryCtp: TUniQuery;
begin

  qryCtp := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '  CTP_NUMDUP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADPAG ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTP_NUMDUP =:NUMDUP AND ';
  strSQL := strSQL + '  CTP_CODEMP =:CODEMP AND ';
  strSQL := strSQL + '  CTP_PARCEL =:PARCEL AND ';
  strSQL := strSQL + '  CTP_CODFOR =:CODFOR     ';

  If (Not fEmptyStr(dbeSerie.Text)) Then
    strSQL := strSQL + '  AND CTP_SERIE_ =:SERIE_ ';

  With qryCtp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDUP').AsString := dbeNumDup.Text;
    ParamByName('CODEMP').AsString := dbeCodEmp.Text;
    ParamByName('PARCEL').AsString := dbeParcel.Text;
    ParamByName('CODFOR').AsString := dbeCodFor.Text;

    If (Not fEmptyStr(dbeSerie.Text)) Then
      ParamByName('SERIE_').AsString  := dbeSerie.Text;

    Open;
    Result := Not IsEmpty;
  End;

  FreeAndNil(qryCtp);

end;

procedure TfrmCadCtaPagar.pAtualizaCtpDet(ANumeroAnterior, AEmpresaAnterior,
  AFornecedorAnterior, AParcelaAnterior, ASerieAnterior: String; Var AGravouLogCtpDet: Boolean);
  Var
    LSelectCTPDet: TUniQuery;
begin
  If Not AAlterouChave Then
    Exit;

  LSelectCTPDet := fCriaQuery(Nil);

  Try
    LSelectCTPDet.SQL.Clear;
    LSelectCTPDet.SQL.Add('SELECT * FROM CTPDET  ');
    LSelectCTPDet.SQL.Add('WHERE CTP_NUMDUP = :DUPANT AND ');
    LSelectCTPDet.SQL.Add('      CTP_PARCEL = :PARCEL AND ');
    LSelectCTPDet.SQL.Add('      CTP_EMPORI = :EMPORI AND ');
    LSelectCTPDet.SQL.Add('      CTP_CODFOR = :CODFORANT AND ');

    If ASerieAnterior.IsEmpty Then
      LSelectCTPDet.SQL.Add('  (CTP_SERIE_ IS NULL OR CTP_SERIE_ = "") ')
    Else
      LSelectCTPDet.SQL.Add('  CTP_SERIE_ = "' + ASerieAnterior + '" ');

    LSelectCTPDet.ParamByName('DUPANT').AsString  := ANumeroAnterior;
    LSelectCTPDet.ParamByName('PARCEL').AsString  := AParcelaAnterior;
    LSelectCTPDet.ParamByName('EMPORI').AsString  := AEmpresaAnterior;
    LSelectCTPDet.ParamByName('CODFORANT').AsString  := AFornecedorAnterior;

    LSelectCTPDet.Open;

    If LSelectCTPDet.IsEmpty then
      Exit;

    AGravouLogCtpDet := True;

    While Not LSelectCTPDet.Eof Do
    Begin
      LSelectCTPDet.Edit;
      LSelectCTPDet.FieldByName('CTP_NUMDUP').AsString := dbeNumDup.Text;
      LSelectCTPDet.FieldByName('CTP_PARCEL').AsString := dbeParcel.Text;
      LSelectCTPDet.FieldByName('CTP_EMPORI').AsString := dbeCodEmp.Text;
      LSelectCTPDet.FieldByName('CTP_CODFOR').AsString := dbeCodFor.Text;
      LSelectCTPDet.FieldByName('CTP_SERIE_').AsString := dbeSerie.Text;
      LSelectCTPDet.Post;

      pGravaLogCtpDet(LSelectCTPDet.FieldByName('AUTOINCREM').AsString,
                      'ALTERAÇÃO DE CHAVE',
                      Self.Name);

      LSelectCTPDet.Next;
    End;
  Finally
    LSelectCTPDet.Close;
    FreeAndNil(LSelectCTPDet);
  End;
end;

procedure TfrmCadCtaPagar.pAtualizaDlp(AAutoIncrem: String);
begin
  try
    FreeAndNil(qryTabela);
    qryTabela           := fCriarQuery('SELECT * FROM CADPAG WHERE AUTOINCREM = ' + QuotedStr(AAutoincrem)+ ' ', Self);
    qryTabela.AfterOpen := pAfterOpen;
    dtsTabela.DataSet   := qryTabela;
    qryTabela.Open;

    pCarregaCompetencia;
    pCarregaDadosAdicionais;
    pCalculaValorTotal;
    pHabilitaFields;
    pHabilitaBotoes;

  except on E: Exception do
    begin
      pMensagensErro(E.Message, '[TfrmCadCtaPagar.pAtualizaDlp]');
    end;
  end;
end;

function TfrmCadCtaPagar.fValidaChqBolDep(Sender: TWinControl): Boolean;
begin
  Result := True;

  If Pos(TDBEditFocus(Sender).Text, 'SN') <= 0 Then
  Begin
    Result := False;
    fMensagem('','O campo deve ser informado com (S)im ou (N)ão!', ['&Ok']);
  End
  Else If TDBEditFocus(Sender).Text = 'S' Then
  Begin
    If (Sender = dbeUsaChq) Then
    Begin
      If (dbeVeiobo.Text = 'S') Or (dbeDeposi.Text = 'S') Or  (dbeUsaMca.Text = 'S')  Then
      Begin
        Result := False;
        fMensagem('','Para informar cheque como (S)im, os campos deposito, veio boleto e cartão devem estar iguais à (N)ão!', ['&Ok']);
      End;
    End;

    If (Sender = dbeUsaMca) Then
    Begin
      If (dbeVeiobo.Text = 'S') Or (dbeDeposi.Text = 'S') Or  (dbeUsaChq.Text = 'S') Then
      Begin
        Result := False;
        fMensagem('','Para informar cartão como (S)im, os campos deposito, veio boleto e cheque devem estar iguais à (N)ão!', ['&Ok']);
      End;
    End;

    If (Sender = dbeVeiobo) Then
    Begin
      If (dbeUsaChq.Text = 'S') Or (dbeDeposi.Text = 'S') Or  (dbeUsaMca.Text = 'S')  Then
      Begin
        Result := False;
        fMensagem('','Para informar veio boleto como (S)im, os campos deposito, cheque e cartão devem estar iguais à (N)ão!', ['&Ok']);
      End;
    End;

    If (Sender = dbeDeposi) Then
    Begin
      If (dbeUsaChq.Text = 'S') Or (dbeVeiobo.Text = 'S') Or (dbeUsaMca.Text = 'S')   Then
      Begin
        Result := False;
        fMensagem('','Para informar deposito como (S)im, os campos veio boleto, cheque e cartão devem estar iguais à (N)ão!', ['&Ok']);
      End;
    End;
  End
  Else
  Begin
    If (Sender = dbePrevis) Then
    Begin
      If (blnGravaApenasPrevisao) And (dbePrevis.Text = 'N') Then
      Begin
        If (dbePrevis.Field.OldValue <> dbePrevis.Text) And (qrytabela.FieldByName('CTP_DTAPAG').IsNull) Then
        Begin
          Result := False;
          fMensagem('ATENÇÃO','Essa conta deve possuir o campo Previsão igual a (S)im!', ['&Ok']);
        End;
      End;
    End;
  End;

end;

function TfrmCadCtaPagar.fValidaTornarPend: Integer;
begin

  If not (qryTabela.FieldByName('CTP_DTAPAG').IsNull) Then Exit(1);
  If (qryTabela.FieldByName('AUTOINCREM').AsString = '')
   or (qryTabela.FieldByName('AUTOINCREM').IsNull) 		Then Exit(2);
  If (qryTabela.FieldByName('CTP_DTALIB').IsNull) 		Then Exit(3);

  Result := 4;

end;

function TfrmCadCtaPagar.fVinculadoReceber: Boolean;
var
  qryConsulta:  TUniQuery;
begin
  If qryTabela.FieldByName('AUTOINCREM').AsString.IsEmpty Then
    Exit(False);

  qryConsulta := fCriaQuery;

  Try
    qryConsulta.Sql.Clear;
    qryConsulta.Sql.Text := 'SELECT CTR_AUTCTP FROM CADREC WHERE CTR_AUTCTP = :AUTCTP';

    qryConsulta.ParamByName('AUTCTP').AsString := QryTabela.FieldByName('AUTOINCREM').AsString;
    qryConsulta.Open;

    Result := Not qryConsulta.IsEmpty;
  Finally
    qryConsulta.Close;
    FreeAndNil(qryConsulta);
  End;
end;

function  TfrmCadCtaPagar.fRetEmpresaRealPagAnt(ACodEmp: string): string;
var qryConsulta: TUniQuery;
begin
  Result := ACodEmp;
  qryConsulta := fCriaQuery;
  Try
    qryConsulta.SQL.Add('SELECT FIS_CODEMP AS CODEMP FROM PGOFIS');
    qryConsulta.SQL.Add(' INNER JOIN CADFIS ON CADFIS.AUTOINCREM = PGF_SEQFIS');
    qryConsulta.SQL.Add(' WHERE PGF_SEQPAG = "' + qryTabela.FieldByName('AUTOINCREM').AsString + '"');
    qryConsulta.SQL.Add(' UNION ALL');
    qryConsulta.SQL.Add('SELECT GER_CODEMP AS CODEMP FROM PGOGER');
    qryConsulta.SQL.Add(' INNER JOIN MOVGER ON MOVGER.AUTOINCREM = PGO_SEQGER');
    qryConsulta.SQL.Add(' WHERE PGO_SEQPAG = "' + qryTabela.FieldByName('AUTOINCREM').AsString + '"');
    qryConsulta.Open;

    If not qryConsulta.IsEmpty then
      Result := qryConsulta.FieldByName('CODEMP').AsString;

  finally
    FreeAndNil(qryConsulta)
  End;

end;

procedure TfrmCadCtaPagar.VerificaSeStatusFatura(StrNumdoc, strCodEmp, strCodFor, strSerie: String);
  Var
    LConsulta: TUniQuery;
begin

  Try
    If fCfgSis('CTPUIF', varString) = 'F' Then
      If not fEmptyStr(qryTabela.FieldByName('CTP_INCFIS').AsString) Then
      begin
        edtStatus.text := 'FATURA';
        Exit;
      End;

    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := ' SELECT FIS_NUMDOC '+
                          '   FROM CADFIS     '+
                          '  WHERE            '+
                          '   FIS_NUMDOC = :CTP_NUMDOC AND '+
                          '   FIS_CODEMP = :CTP_CODEMP AND '+
                          '   FIS_FORCLI = :CTP_CODFOR AND '+
                          '   FIS_TIP_FC = "F" AND     '+
                          '   FIS_SERIE_ = :CTP_SERIE_ ';

    LConsulta.ParamByName('CTP_NUMDOC').AsString := StrNumdoc;
    LConsulta.ParamByName('CTP_CODEMP').AsString := fRetEmpresaRealPagAnt(strCodEmp);
    LConsulta.ParamByName('CTP_CODFOR').AsString := strCodFor;
    LConsulta.ParamByName('CTP_SERIE_').AsString := strSerie;

    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
       edtStatus.text := 'FATURA'
    Else
       edtStatus.text := 'AVULSO';

  Finally
    FreeAndNil(LConsulta);
  End;

end;

procedure TfrmCadCtaPagar.PosicionaContaFornecedor;
begin
  //Feito assim pois foi pedido para não alterar os campos da tela
  cbxBcoFor.ItemIndex := - 1;
  If Not qryTabela.FieldByName('CTP_BCOFOR').AsString.IsEmpty Then
    cbxBcoFor.ItemIndex := lstBcoFor.IndexOf(qryTabela.FieldByName('CTP_BCOFOR').AsString)
  Else
    cbxBcoFor.ItemIndex := lstBcoFor.IndexOf('PIX' + qryTabela.FieldByName('CTP_FORPIX').AsString);
end;

Function TfrmCadCtaPagar.VerificaSeDuplicataTemCadFis(StrNumdoc, strCodEmp, strCodFor, strSerie: String) : Boolean;
  Var
    LConsulta: TUniQuery;
begin

  Try
    LConsulta := fCriaQuery;

    LConsulta.SQL.Text := ' SELECT FIS_NUMDOC '+
                          '   FROM CADFIS     '+
                          '  WHERE            '+
                          '   FIS_NUMDOC = :CTP_NUMDOC AND '+
                          '   FIS_CODEMP = :CTP_CODEMP AND '+
                          '   FIS_FORCLI = :CTP_CODFOR AND '+
                          '   FIS_TIP_FC = "F" AND     '+
                          '   FIS_SERIE_ = :CTP_SERIE_ ';

    LConsulta.ParamByName('CTP_NUMDOC').AsString := StrNumdoc;
    LConsulta.ParamByName('CTP_CODEMP').AsString := strCodEmp;
    LConsulta.ParamByName('CTP_CODFOR').AsString := strCodFor;
    LConsulta.ParamByName('CTP_SERIE_').AsString := strSerie;

    LConsulta.Open;

    If Not LConsulta.IsEmpty Then
       Result := True
    Else
       Result := False;

  Finally
    FreeAndNil(LConsulta);
  End;

end;

procedure TfrmCadCtaPagar.pAtualizaCtp_REINF(strDupAnt, strEmpAnt, strForAnt: String);
Var
  qryUpdate,
  qrySelect : TUniQuery;
begin
  qryUpdate := fCriaQuery(Nil);
  qrySelect := fCriaQuery(Nil);

  With qrySelect Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT      ');
    SQL.Add('  AUTOINCREM ');
    SQL.Add('  FROM       ');
    SQL.Add('      RNFCTP ');
    SQL.Add(' WHERE       ');
    SQL.Add('       CTP_NUMDUP = :DUPANT    ');
    SQL.Add('   AND CTP_PARCEL = :PARCEL    ');
    SQL.Add('   AND CTP_CODFOR = :CODFORANT ');

    If (fEmptyStr(dbeSerie.Text)) Then
      SQL.Add(' AND ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) ')
    Else
      SQL.Add(' AND CTP_SERIE_ = :SERIE_ ');

    SQL.Add('   AND CTP_CODEMP = :EMPORI    ');

    ParamByName('DUPANT').AsString := strDupAnt;
    ParamByName('PARCEL').AsString := dbeParcel.Text;

    If (Not fEmptyStr(dbeSerie.Text)) Then
      ParamByName('SERIE_').AsString := dbeSerie.Text;

    ParamByName('EMPORI').AsString    := strEmpAnt;
    ParamByName('CODFORANT').AsString := strForAnt;
    Open;
  End;

  If qrySelect.RecordCount > 0 then
  Begin

    With qryUpdate Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE ');
      SQL.Add('  RNFCTP ');
      SQL.Add('SET ');
      SQL.Add('  CTP_NUMDUP = :NUMDUP, ');
      SQL.Add('  CTP_CODEMP = :CODEMP, ');
      SQL.Add('  CTP_CODFOR = :CODFOR  ');
      SQL.Add('WHERE ');
      SQL.Add('  CTP_NUMDUP = :DUPANT AND ');
      SQL.Add('  CTP_PARCEL = :PARCEL AND ');

      If (fEmptyStr(dbeSerie.Text)) Then
        SQL.Add('  ((CTP_SERIE_ IS NULL) OR (CTP_SERIE_ = "")) AND ')
      Else
        SQL.Add('  CTP_SERIE_ = :SERIE_ AND ');

      SQL.Add('  CTP_CODEMP = :EMPORI AND ');
      SQL.Add('  CTP_CODFOR = :CODFORANT ');

      ParamByName('NUMDUP').AsString  := dbeNumDup.Text;
      ParamByName('CODEMP').AsString  := dbeCodEmp.Text;
      ParamByName('CODFOR').AsString  := dbeCodFor.Text;
      ParamByName('DUPANT').AsString  := strDupAnt;
      ParamByName('PARCEL').AsString  := dbeParcel.Text;

      If (Not fEmptyStr(dbeSerie.Text)) Then
        ParamByName('SERIE_').AsString := dbeSerie.Text;

      ParamByName('EMPORI').AsString    := strEmpAnt;
      ParamByName('CODFORANT').AsString := strForAnt;
      ExecSQL;
    End;
  End;

  FreeAndNil(qryUpdate);
  FreeAndNil(qrySelect);
end;

Procedure TfrmCadCtaPagar.pAtualizaCorBotaoREINF(strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String; strSeqBai : Integer);
  Var
      blntemReinf : Boolean;
      sAInc : String;
Begin

  blntemReinf := fVerificaReinfCtp(strNumDup, strParcel, strSerie, strCodEmp, strCodFor, strSeqBai, sAInc);

  If (blntemReinf) And (Not fEmptyStr(sAinc)) Then
     btnReinf.Font.Color := clblue
  Else
     btnReinf.Font.Color := clblack;

End;

end.
