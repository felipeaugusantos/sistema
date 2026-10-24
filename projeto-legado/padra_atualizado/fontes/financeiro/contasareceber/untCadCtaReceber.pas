{****************************}
{* qryConEmp -> CADEMP     *}
{* qryConCli -> CADCLI     *}
{* qryConPor -> CADPOR     *}
{* qryConOpe -> CADOPE     *}
{* qryConCta -> CADCTA     *}
{************************JB*}
{***************************}
{* qryCadBco -> CADBCO     *}
{************************RV*}
unit untCadCtaReceber;

interface

uses
  Windows, Classes, DB, Controls, Forms, StdCtrls, untPaiCad, ComCtrls, ExtCtrls, Mask,
  Uni, DBCtrls, DBEditFocus, QColorLabel, Menus, EditFocus, AppEvnts, untTypesSistema,
  UniDataSetProvider, DBMemoFocus, RLTypes, BitBtnLockedIncrem, Buttons, strUtils, untFechamentoFinanceiro,
  frxClass, frxExportCSVTestabilidade, untLiberacao, untMsgLiberacao, ClipBrd,
  untFrameCentroCustoDBEditFocus,untTBanCtrRepository, untMovBan,untPorCredMovban,
  untTProrrogacaoDeTitulos,untAdiantamentoCliente, untTEnvioEmail, frxDBSet,
  MemDS, DBAccess, System.MaskUtils,untDetalheHistoricos,
  untFramePlanoDeContasDBEditFocus, System.IOUtils,untTValidaCorrespondenteContabil,
  dxScreenTip, cxClasses, dxCustomHint, cxHint;

type
  TfrmCadCtaReceber = class(TfrmPaiCad)
    pnlGeral: TPanel;
    pnlDetalhe: TPanel;
    pnlDadosBaixa: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    dbeNumDup: TDBEditFocus;
    dbeParcel: TDBEditFocus;
    Label3: TLabel;
    dbeCodEmp: TDBEditFocus;
    dbeEspDoc: TDBEditFocus;
    Label4: TLabel;
    Label5: TLabel;
    dbeCodCli: TDBEditFocus;
    Label7: TLabel;
    dbeDtaCad: TDBEditFocus;
    dbeDtaVen: TDBEditFocus;
    Label8: TLabel;
    Label9: TLabel;
    dbeValDup: TDBEditFocus;
    dbeDesCob: TDBEditFocus;
    Label10: TLabel;
    Label11: TLabel;
    dbeDescon: TDBEditFocus;
    dbeCodPor: TDBEditFocus;
    Label13: TLabel;
    dbeCodVen: TDBEditFocus;
    Label15: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label24: TLabel;
    Label6: TLabel;
    Label14: TLabel;
    ColorLabel2: TColorLabel;
    Label16: TLabel;
    edtNomEmp: TEditFocus;
    edtNomCli: TEditFocus;
    edtNomPor: TEditFocus;
    edtNomVen: TEditFocus;
    edtTipBai: TEditFocus;
    edtDtaRec: TEditFocus;
    edtPorBai: TEditFocus;
    edtCtaBai: TEditFocus;
    edtOpeBai: TEditFocus;
    edtHisBai: TEditFocus;
    edtDocBai: TEditFocus;
    edtValRec: TEditFocus;
    edtValOri: TEditFocus;
    edtSeqBai: TEditFocus;
    Label25: TLabel;
    Label29: TLabel;
    dbeCodVel: TDBEditFocus;
    Label30: TLabel;
    lblTitEnv: TLabel;
    dbeDtaRec: TDBEditFocus;
    dbeHisto1: TDBMemoFocus;
    pnlEnvBan: TPanel;
    Label31: TLabel;
    Label32: TLabel;
    dbeDtaEnv: TDBEditFocus;
    Label33: TLabel;
    dbeBcoBol: TDBEditFocus;
    edtNomBan: TEditFocus;
    Label34: TLabel;
    dbeDesSuj: TDBEditFocus;
    Label35: TLabel;
    dbeJurSuj: TDBEditFocus;
    lblSeqBai: TLabel;
    dbeSeqBai: TDBEditFocus;
    dtsTabela: TDataSource;
    edtSeqCon: TEditFocus;
    Label36: TLabel;
    btnBaixarDup: TBitBtnLocked;
    btnImprimir: TBitBtnLocked;
    btnHistReceb: TBitBtnLocked;
    btnHisRetorno: TBitBtnLocked;
    pnlDadosBoleto: TPanel;
    lblDadosBoleto: TLabel;
    Label12: TLabel;
    dbeNosNum: TDBEditFocus;
    Label37: TLabel;
    dbeLinhaDigitavel: TDBEditFocus;
    btnCopiaLinhaDigitada: TBitBtnLocked;
    dbeBancoBoleto: TDBEditFocus;
    Label39: TLabel;
    Label40: TLabel;
    dbeDtaEmi: TDBEditFocus;
    edtNomBanBoleto: TEditFocus;
    btnDetalharValoresBaixa: TBitBtnLocked;
    lblPorTar: TLabel;
    edtPorTar: TEditFocus;
    lblForTar: TLabel;
    edtForTar: TEditFocus;
    lblCtaTar: TLabel;
    edtCtaTar: TEditFocus;
    lblValTar: TLabel;
    edtValorTarifa: TEditFocus;
    lblValTot: TLabel;
    edtValTot: TEditFocus;
    btnImpBol: TBitBtnLocked;
    btnEstornoCtr: TBitBtnLocked;
    edtValJur: TEditFocus;
    lblValJur: TLabel;
    lblValDes: TLabel;
    edtValDes: TEditFocus;
    dbeDtaPro: TDBEditFocus;
    Label38: TLabel;
    spbAmpliar: TSpeedButton;
    btnBoleto: TBitBtnLocked;
    fraCentroCusto: TfraCentroCustoDBEditFocus;
    btnNF: TBitBtnLocked;
    btnCopiaCPFCNPJ: TBitBtnLocked;
    btnConsultarAdiantamentos: TBitBtnLocked;
    btnReenviarRelAgrup: TBitBtnLocked;
    frxRelCTR: TfrxReport;
    frxDBRelCTR: TfrxDBDataset;
    qryRelCTR: TUniQuery;
    qryRelCTRCTR_NUMDUP: TStringField;
    qryRelCTRCTR_PARCEL: TStringField;
    qryRelCTRCTR_ESPDOC: TStringField;
    qryRelCTRCLIENTE: TStringField;
    qryRelCTRCLI_ENDERE: TStringField;
    qryRelCTRCLI_BAIRRO: TStringField;
    qryRelCTRCID_NOMCID: TStringField;
    qryRelCTRCLI_FONE01: TStringField;
    qryRelCTRVENDEDOR: TStringField;
    qryRelCTRCTR_DTACAD: TDateField;
    qryRelCTRCTR_VALDUP: TFloatField;
    qryRelCTRCTR_DESSUJ: TFloatField;
    qryRelCTRCTR_DTAVEN: TDateField;
    qryRelCTRCTR_DESCOB: TFloatField;
    qryRelCTRCTR_NOSNUM: TStringField;
    qryRelCTRPORTADOR: TStringField;
    qryRelCTREVENTO: TStringField;
    qryRelCTRHIST01: TStringField;
    qryRelCTRCTR_HIST02: TStringField;
    qryRelCTRCTR_CODVEL: TStringField;
    qryRelCTRCTR_DTAREC: TDateField;
    qryRelCTRPORBAI: TStringField;
    qryRelCTRCTR_CTABAI: TStringField;
    qryRelCTROPEBAI: TStringField;
    qryRelCTRCTR_SEQBAI: TIntegerField;
    qryRelCTRCTR_VALORI: TFloatField;
    qryRelCTRCTR_VALREC: TFloatField;
    qryRelCTRCTR_DOCBAI: TStringField;
    qryRelCTRCTR_HISBAI: TStringField;
    qryRelCTRCTR_DESCON: TStringField;
    qryRelCTRCLI_CGCCPF: TLongWordField;
    qryRelCTRCLI_C_G_C_: TStringField;
    qryRelCTRPLANOCONTA: TStringField;
    qryRelCTREMP_NOMEMP: TStringField;
    btnDetalharHistorico: TSpeedButton;
    pnlProjeto: TPanel;
    lblProjeto: TLabel;
    edtDesPrj: TEditFocus;
    fraPlanoDeContas: TfraPlanoDeContasDBEditFocus;
    btnAbrirPastaAnexos: TBitBtnLocked;
    btnDocBaixa: TBitBtnLocked;
    btnNossNumCompleto: TSpeedButton;
    HintControler: TcxHintStyleController;
    edtCodPrj: TEditFocus;
    btnAcompEntrega: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pqryCadRecCTR_DTAENVSetText(Sender: TField; const Text: String);
    procedure btnCancelaClick(Sender: TObject);
    function dbeCodEmpChamaCadastro(Key: Word): String;
    function dbeCodCliChamaCadastro(Key: Word): String;
    function dbeCodPorChamaCadastro(Key: Word): String;
    function dbeCodVenChamaCadastro(Key: Word): String;
    procedure dbeCodPorKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnBaixarDupClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure dbeHisto1KeyPress(Sender: TObject; var Key: Char);
    procedure dbeBcoBolKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnHistRecebClick(Sender: TObject);
    procedure btnHisRetornoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnCopiaLinhaDigitadaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbeNumDupChange(Sender: TObject);
    procedure btnDetalharValoresBaixaClick(Sender: TObject);
    procedure edtValRecChange(Sender: TObject);
    procedure dbeValDupExit(Sender: TObject);
    procedure btnImpBolClick(Sender: TObject);
    procedure dtsTabelaStateChange(Sender: TObject);
    procedure dbeLinhaDigitavelChange(Sender: TObject);
    procedure dbeNosNumKeyPress(Sender: TObject; var Key: Char);
    procedure btnEstornoCtrClick(Sender: TObject);
    procedure spbAmpliarClick(Sender: TObject);
    procedure btnNFClick(Sender: TObject);
    procedure btnBoletoClick(Sender: TObject);
    procedure dtsTabelaDataChange(Sender: TObject; Field: TField);
    procedure btnCopiaCPFCNPJClick(Sender: TObject);
    procedure btnConsultarAdiantamentosClick(Sender: TObject);
    procedure btnReenviarRelAgrupClick(Sender: TObject);
    procedure btnDetalharHistoricoClick(Sender: TObject);
    procedure fraPlanoDeContasdbeCodCtaKeyPress(Sender: TObject; var Key: Char);
    function fraPlanoDeContasdbeCodCtaChamaCadastro(Key: Word): string;
    procedure btnAbrirPastaAnexosClick(Sender: TObject);
    procedure btnDocBaixaClick(Sender: TObject);
    procedure btnNossNumCompletoMouseEnter(Sender: TObject);
    procedure btnNossNumCompletoMouseLeave(Sender: TObject);
    procedure btnNossNumCompletoClick(Sender: TObject);
    procedure dbeEspDocExit(Sender: TObject);
    procedure edtCodPrjKeyPress(Sender: TObject; var Key: Char);
    procedure btnAcompEntregaClick(Sender: TObject);
  private
    { Private declarations }
    qryConCta: TUniQuery;
    qryConOpe: TUniQuery;
    qryConPor: TUniQuery;
    qryConEmp: TUniQuery;
    qryConCli: TUniQuery;
    qryCadBco: TUniQuery;
    qryConPrj: TUniQuery;
    arrDupSel: TArrDupSel;
    strMovBan: String;
    blnGerarCreditoDireto : Boolean;
    blnExitValDup : Boolean;
    strUltVlrAlt : String;
    qryGen: TUniQuery;
    dtaDtaVenPrzVen: TDateTime;

    fltValOriAnt  : Double;
    fltValDupAnt  : Double;

    blnDupBaixada : Boolean;
    blnEnviada    : Boolean;

    strCodBco     : String;
    dtaDtaEnv     : TDateTime;

    blnIniciaCadastro: Boolean;
    fltValLanLoc: Double;
    strHist01Loc,
    strCodPorLoc: String;
    strEspecieLoc: String;
    dteDataLanLoc,
    dteDataVenLoc: TDate;

    dtaDtaVenOld,
    dtaDtaCadOld: TDateTime;
    strValDupOld,
    strCodPorOld: String;
    strSenhaDtaCadOld,
    strSenhaDtaVenOld,
    strSenhaValDupOld,
    strSenhaCodPorOld,
    strDuplicataParcial,
    strParcelaParcial,
    strEmpresaParcial,
    strClienteParcial,
    strEspecieParcial,

    chqCadRec            : String;
    blnDupTravada: Boolean;

    objLiberacao : TLiberacao;
    objProrrogacao : TProrrogacaoDeTitulos;
    FValidaCorrespondenteContabil: TValidaCorrespondenteContabil;

    strNumDupDC,
    strParcelDC,
    strEspDocDC,
    strCodCliDC,
    strCodEmpDC : String;

    FSeqBaiDC: Integer;

    strPlanoContasOri: String;

    FEspecieDocumento,
    FCodigoCliente,
    FNumeroControle,
    FChaveLck : String;
    objFechamento: TFechamentoFinanceiro;
    AValorTotalInicial: Double;
    ADataCadastroInicial: TDateTime;

    FLiberaVencimento: Boolean;
    FblnExcluirFF: Boolean;

    function fVerLiberacaoExclusaoDupBolAdt : Boolean;

    procedure pInicializarTabela(strSQL: String);
    procedure pAfterOpen(DataSet: TDataSet);
    procedure pIniciaValoresPadrao;
    procedure pCarregaDadosAdicionais;
    function BoletoCancelado:Boolean;

    procedure pAtribuiTabelas;
    function  fGravaCreditoCliente(APortadorMovBan, APlanoDeContasMovBan: String; const AInserindo : Boolean): Boolean;
    function  fGravaDebitoCliente : Boolean;
    procedure pCarregaCreditoCliente;
    Procedure pConsultarAdintamento;
    function  fGerarCreditoCliente(blnInserindo : Boolean): Boolean;
    procedure pAdicionarDuplicataNoArray;
    procedure pCarregaBanco;
    procedure HideHint;
    procedure ShowHint(AButton: TSpeedButton; ATitulo: String; AHint: String);
    function RetornaNossoNumeroCompleto:String;
    function DigitoVerificadorNossoNumero(ANossoNumero: String):String;
    procedure pCarregaEmpresa;
    procedure pCarregaCliente;
    procedure pCarregaPortador;
    procedure pAdiantamentoCliente;
    procedure pCarregaVendedor;
    procedure pCarregaDadosBaixa;
    procedure pCarregaEventos;
    procedure pCarregaCentroCusto;
    procedure pRecarregaDuplicataAberta;
    procedure pConsultaBoleto;
    procedure pConsultaNotaFiscal;

    function fValidaDupAgr(strNumDup, strParcel, strEspDoc, strCodEmp,
      strCodCli: String; Var strNumAgr: String): Boolean;

    function  fRetornaDtaVenLogCtr(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli: String): TDateTime;
    function  fCtrExisteDupDependentes(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli: String): Boolean;
    function  fDocumentoVeioFaturamento(strNumDup, strEspDoc, strCodEmp,
      strCodCli, AParcel: String): Boolean;
    procedure pHabilitaEditFields;
    function  fSenhaPortador: Boolean;
    function  fSenhaAlteracaoValorDuplicata: Boolean;
    function  fSenhaAlteracaoVencimentoDuplicata: Boolean;
    function  fAlterouValor(chaveDuplicata:String; valorAtual:Double):Boolean;
    function  fAlterouVencimento(chaveDuplicata:String; dtaVen:String):Boolean;
    procedure pLimpaDadosBoleto;
    function  fExisteChqGerador(chaveBusca:String):Boolean;
    procedure setChqCadRec(chave:String);
    procedure pCalculaValorTotal();
    function  fCarregaDuplicata: Boolean;
    function  fDocumentoJaUtilizado(strNumDup, strEspDoc, strCodEmp, strCodCli: String): Boolean;
    procedure pGeraRelatorioAgrupamento;

    function SelecionaPortadorPlanoDeContasMovBan(out APortadorMovBan, APlanoDeContasMovBan: String): Boolean;
    function fSqlAgrupamento(strCodCli, strNumDup: string): string;
    function fGetHistoricoLancamentoCredito : String;
    procedure pUtilizaRotinaProjeto;
    procedure pCarregaProjeto;
    procedure CarregaCodigoProjeto;
    procedure HabilitarCampoProjeto;
    procedure pHabilitaDesabiltabtnAbrirPastaAnexos;

    function fDocumentoRLComParcelamento(strNumDup, strEspDoc, strCodEmp, strCodCli: String): Boolean;
    function fDocumentoRLComAdiantamentoBaixado(strNumDup, strEspDoc, strCodEmp, strCodCli: String): Boolean;
    procedure TituloEnviadaAoBanco;
    function ExisteDuplicataParaRemessa: Boolean;
    procedure pDesvinculaContratoLocacao(strNumDup,
                                         strEspDoc,
                                         strCodCli,
                                         strCodEmp: String;
                                         fltValDup: Double);
    function fExcluiTodasParcelasAdiantamento(Const strNumDup, strEspDoc, strCodEmp, strCodCli: String): Boolean;
    function fDuplicataDeChequeTransferido(tipoDoc, chaveBusca: String): Boolean;

    function DuplicataCCFoiGeradaPorUmaBaixa(out ADocumentosEstornar: String): Boolean;
    function fCarregaDupParaBaixa(strAutInc: String): Boolean;
    function PermitirIncluirCreditoClienteComValorPositivo : Boolean;
    function NumeroDuplicataFoiAltarado(out ANumDupOriginal: String): Boolean;
    function DeveTravarAlteracaoNossoNumero: Boolean;

    procedure DefinirTarifa;
    function RetornaSqlConsultaTarifa(ACodigoBancoBoleto: String): String;
  protected
    procedure pDestravarRegistros; override;

    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
    function fExecutaAntesDoDelete : Boolean; override;
  public
    { Public declarations }
    strAutoincrem,
    strOrigem : String;
    recUltDupBaixada : TUltDupBaixada;
    class procedure pMostraIniciandoCadastro(fltValLan: Double = 0; strHist01: String = '';
                   dteDataLan: TDate = 0; dteDataVen: TDate = 0; strCodPor: String = ''; aLanExtInc: Boolean = False; strEspecie: String = '');
  end;

implementation

uses SysUtils, Variants, Graphics, UniClientDataSet, untFuncoesSimples, untPai,
  untFuncIns, untPesqAux, untConstantes, untBaixaReceber, untMetCli,
  untCadCta, untCadRec, untCfgRel,
  untConsultas, untPanelCxCadReceber, untPnlPesqCadRec,
  untFuncoesRel, untFuncoesRel2, untRcxTravas, untRelCtrLogAcompDuplicNovo, untFuncFat,
  untCtrDetalhesBaixa, untBoleto, untFuncoes, untFuncoesBoleto,
  untAgrupDuplicatas, untEstornoReceber, untMemo,
  untAdiantamentoClienteGenerico, untValidacoesSistemaDEPS, untDocumento, untIDocumento,
  untAtualizaOcorrenciasCRM, untTypesCRM, untCtrAgrupDupRecibo, untgravando,
  untModulo, untFuncoesGenerica, UntLogCba, untQckCtrDuplicata,
  untGravaArquivoPasta, untFatGor, Faturamento.Classes.CancelamentoLocEqu,
  untCtrDocBaixa,untTEnviaEmailCancelamentoBoleto, untConsultaPedidos, untPgtOnlineApi;

{$R *.dfm}

{ TfrmCadCtaReceber }

function TfrmCadCtaReceber.fVerLiberacaoExclusaoDupBolAdt : Boolean;
begin
  Result := True;

  If Not fVerificaAcessoSistema('DELUNIDUPBOLADT', strLoginUsuarioLogado) Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Permitir excluir duplicata de boleto de adiantamento');
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Documento'       , qryTabela.FieldByName('CTR_NUMDUP').AsString                           , 9);
    objLiberacao.objMsgLibera.pAddTextoCaption('Parcela'         , qryTabela.FieldByName('CTR_PARCEL').AsString                           , 9);
    objLiberacao.objMsgLibera.pAddTextoCaption('Espécie'         , qryTabela.FieldByName('CTR_ESPDOC').AsString                           , 9);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'         , qryTabela.FieldByName('CTR_CODCLI').AsString + ' - ' + edtNomCli.Text  , 9);
    objLiberacao.objMsgLibera.pAddTextoCaption('Valor'           , dbeValDup.Text                                                         , 9);

    objLiberacao.strDirAce := 'DELUNIDUPBOLADT';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strMsgSen := 'Permitir excluir duplicata de boleto de adiantamento';
    objLiberacao.pInformaNumDocEspDocCodEmp(
                     qryTabela.FieldByName('CTR_NUMDUP').AsString,
                     qryTabela.FieldByName('CTR_ESPDOC').AsString,
                     qryTabela.FieldByName('CTR_CODEMP').AsString);

    If (Not objLiberacao.fLibera) Then
    begin
      fMensagem('ATENÇÃO!','Não é permitido excluir a duplicata!', ['&O K']);
      Result := False;
    end;
  End;
end;

procedure TfrmCadCtaReceber.HabilitarCampoProjeto;
begin
  edtCodPrj.Enabled := True;

  If dbeEspDoc.Text <> 'CC' Then
    edtCodPrj.Enabled := False;

  If (fStrToFloat(dbeValDup.Text) >= 0) Then
    edtCodPrj.Enabled := False;

  If Not edtCodPrj.Enabled Then
   CarregaCodigoProjeto;
end;

procedure TfrmCadCtaReceber.HideHint;
begin
  HintControler.HideHint;
end;

function TfrmCadCtaReceber.NumeroDuplicataFoiAltarado(out ANumDupOriginal: String): Boolean;
var
  LQuery:          TUniQuery;
  LNumDupAtual:    String;
  LNumDupOriginal: String;
begin
  Result := False;
  LQuery := fCriaQuery(Self);
  try
    try
      LQuery.Close;
      LQuery.SQL.Clear;
      LQuery.SQL.Add('SELECT CTR_NUMDUP FROM CADREC WHERE AUTOINCREM = :AUTO');
      LQuery.Params[0].Value := qryTabela.FieldByName('AUTOINCREM').Value;
      LQuery.Open;

      LNumDupAtual := qryTabela.FieldByName('CTR_NUMDUP').AsString;
      LNumDupOriginal := LQuery.Fields[0].AsString;
      ANumDupOriginal := LNumDupOriginal;

      Result := not LNumDupAtual.Equals(LNumDupOriginal);
    except
      On E: Exception do
        raise Exception.Create('Problemas ao verificar se o número da duplicata foi alterado. ' + E.Message);
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

function TfrmCadCtaReceber.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strNumDup: String;
    strDtaCad, strDtaVen: String;
    strDescon: String;
    fltValDup, fltDesCob: Double;
    strSenha: String;
    strNumAgr: String;
begin
  Result := True;

  {$IFDEF AUTDUP}
   Exit;
  {$ENDIF}

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin
    {**********************************************}
    {* ALTEREI A ROTINA DO VALIDA CAMPOS DEVIDO À *}
    {* SOLICITAÇÃO DA CHUVEIRÃO PARA PERMITIR     *}
    {* ALTERAR O CENTRO DE CUSTO DE DUPLICATAS    *}
    {* JÁ BAIXADAS. OBS.: NÃO TEM ALTERA PARA ISSO*}
    {*27/05/2013********************************JU*}
    If (blnDupBaixada) Then
    Begin
      {*****************************************}
      {* VALIDA VALIDA O CENTRO DE CUSTO       *}
      {**************************************MV*}
      If (Sender = fraPlanoDeContas.dbeCodCta) And (fraPlanoDeContas.dbeCodCta.Visible) Then
      Begin
        If fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) Then
        Begin
          fraPlanoDeContas.dbeCodCta.Field.Value := Null;
          fraPlanoDeContas.edtDesCta.Clear;
        End
        Else If (Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.dbeCodCta.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If (qryTabela.State = dsInsert) Then
          Begin
            pCarregaCentroCusto;

            If Not PlanoDeContasAtivo(fraPlanoDeContas.dbeCodCta.Text) Then
              Result := False;
          End
          Else
          Begin
            pCarregaCentroCusto;
            If strPlanoContasOri <> fraPlanoDeContas.dbeCodCta.Text Then
            Begin
              If Not PlanoDeContasAtivo(fraPlanoDeContas.dbeCodCta.Text) Then
                Result := False;
            End;
          End;

          If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If Not FValidaCorrespondenteContabil.PlanoDeContasPossuiCorrespondenteContabil(fraPlanoDeContas.dbeCodCta.Text,dbeCodEmp.Text) Then
          Begin
            Result := False;
          End;
        End;

        if not Result then
        begin
          fraPlanoDeContas.dbeCodCta.Field.Value := Null;
          fraPlanoDeContas.edtDesCta.Clear;
        end;

      End;

    End
    Else
    Begin
      {*****************************************}
      {* VALIDA O NÚMERO DA DUPLICATA          *}
      {**************************************MV*}
      If (Sender = dbeNumDup) Then
      Begin
        If fEmptyStr(dbeNumDup.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Número do Documento deve ser preenchido!', ['&O k']);
          Result := False;
        End
        else
        begin
          if Length(dbeNumDup.Text) < 12 then
          begin
            If qryTabela.State = dsInsert Then
              dbeNumDup.Text := fStrZero(dbeNumDup.Text, 12);
          end;
        end;
      End


      Else If (Sender = edtCodPrj) Then
      Begin
        If Not fEmptyStr(edtCodPrj.Text) Then
        Begin
          pCarregaProjeto;

          If fEmptyStr(edtDesPrj.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Projeto não cadastrado!', ['&O k']);
            Result := False;
          End;
        End;

      End

      {*****************************************}
      {* VALIDA A PARCELA *}
      {**************************************MV*}
      Else If (Sender = dbeParcel) Then
      Begin
        If fEmptyStr(dbeParcel.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Parcela deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Not CharInSet(dbeParcel.Text[1], ['A'..'Z']) And (dbeEspDoc.Text <> 'AG') And (qryTabela.State In [dsInsert]) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Parcela deve estar entre A e Z!', ['&O k']);
          Result := False;
        End;
      End

      {*****************************************}
      {* VALIDA A ESPÉCIE DO DOCUMENTO         *}
      {**************************************MV*}
      Else If (Sender = dbeEspDoc) Then
      Begin
        if (strEspecieLoc  <> '') and (strEspecieLoc  <> dbeEspDoc.Text) then
          qryTabela.FieldByName('CTR_ESPDOC').AsString := strEspecieLoc;

        If fEmptyStr(dbeEspDoc.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Espécie deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If Length(dbeEspDoc.Text) <> 2 Then
        Begin
          fMensagem('ATENÇÃO!', 'A Espécie deve ter exatamente 2 caracteres!', ['&O k']);
          Result := False;
        End
        Else If dbeEspDoc.Text = 'FC' Then
        Begin
          fMensagem('ATENÇÃO!', 'Não é permitido gravar duplicatas com Espécie FC.', ['&O k']);
          Result := False;
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
      End

      {*****************************************}
      {* VALIDA O CÓDIGO DO CLIENTE            *}
      {**************************************MV*}
      Else If (Sender = dbeCodCli) Then
      Begin
        If fEmptyStr(dbeCodCli.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código do Cliente deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCarregaCliente;
          If qryConCli.FieldByName('CLI_CODCLI').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Cliente não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else
          If qryConCli.FieldByName('CLI_STATUS').AsString <> 'A' Then
          Begin
            If qryTabela.State = dsInsert then
            begin
              fMensagem('ATENÇÃO!', 'Esse cliente está inativo!', ['&O k']);
              Result := False;
            END;
          End
          Else If Not fValidaDupAgr(dbeNumDup.Text, dbeParcel.Text, dbeEspDoc.Text,
                                    dbeCodEmp.Text, dbeCodCli.Text, strNumAgr) Then
          Begin
            fMensagem('ATENÇÃO!', 'Essa duplicata pertence ao agrupamento ' + strNumAgr + ', portanto ' +
                                  'não pode ser cadastrada. Favor cadastrar com outra ' +
                                  'codificação e destacar no histórico a duplicata a que se refere.', ['&O k']);
            Result := False;
          End
          Else If (Not(qryTabela.State in [dsEdit])) AND
                  (fDocumentoJaUtilizado(dbeNumDup.Text, dbeEspDoc.Text,
                                        dbeCodEmp.Text, dbeCodCli.Text)) Then
          Begin
            fMensagem('', 'Documento já utilizado anteriormente.', ['&OK']);
            Result := False;
          End
          Else If blnBuscaPorChave Then
          Begin
            strDtaCad := dbeDtaCad.Text;
            strDtaVen := dbeDtaVen.Text;
            strDescon := dbeDescon.Text;
            If Not fBuscaPorCamposChave Then
            Begin
              strDuplicataParcial := '';
              strParcelaParcial   := '';
              strEmpresaParcial   := '';
              strClienteParcial   := '';
              strEspecieParcial   := '';
              If Not (fltValLanLoc <> 0) Then
                pLimparCampos;
            End
            Else
            Begin
              pAdiantamentoCliente;
              {**************************}
              {* HABILITA DATAS E VALOR *}
              {* RQ: 31799 ***********BB*}
              If (qryTabela.State In [dsInsert,dsEdit]) Then
                pHabilitaEditFields;

              {*******************************************}
              {* INICIO AS VARIAVEIS PARA PODER USA-LAS  *}
              {* NO VALIDA CAMPOS                        *}
              {****************************************AC*}
              dtaDtaCadOld := qryTabela.FieldByName('CTR_DTACAD').AsDateTime;
              dtaDtaVenOld := qryTabela.FieldByName('CTR_DTAVEN').AsDateTime;
              strValDupOld := FloatToStr(qryTabela.FieldByName('CTR_VALDUP').AsFloat);
              strCodPorOld := qryTabela.FieldByName('CTR_CODPOR').AsString;

              strSenhaDtaCadOld := '';
              strSenhaDtaVenOld := '';
              strSenhaValDupOld := '';
              strSenhaCodPorOld := '';
              FLiberaVencimento := False;

              If dbeEspDoc.Text = 'AG' Then
              Begin
                btnCancela.Click;
                Exit;
              End;

              dtaDtaVenPrzVen := fRetornaDtaVenLogCtr(dbeNumDup.Text, dbeParcel.Text, dbeEspDoc.Text, dbeCodEmp.Text, dbeCodCli.Text);

              If dtaDtaVenPrzVen = 0 Then
                dtaDtaVenPrzVen := StrToDate(dbeDtaVen.Text);

            End;
            If (qryTabela.State In dsEditModes) Then
              qryTabela.FieldByName('CTR_SEQBAI').AsInteger := 0;

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

              If Not fEmptyStr(fTiraCaracEspeciais(strDescon)) Then
                dbeDescon.Text := strDescon;
            End
            Else If (qryTabela.State = dsEdit) Then
            Begin
                dbeDtaCad.Text := DateToStr(qryTabela.FieldByName('CTR_DTACAD').AsDateTime);
                dbeDtaVen.Text := DateToStr(qryTabela.FieldByName('CTR_DTAVEN').AsDateTime);
                dbeDescon.Text := qryTabela.FieldByName('CTR_DESCON').AsString;
            End;

            pCarregaDadosAdicionais;
            If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
              pSetFocus(btnAlterar);
          End;
        End;
      End

      {*****************************************}
      {* VALIDA A DATA DE CADASTRO             *}
      {**************************************MV*}
      Else If (Sender = dbeDtaCad) Then
      Begin
        if (dteDataLanLoc  <> 0) and (dteDataLanLoc  <> StrToDate(dbeDtaCad.Text)) then
          qryTabela.FieldByName('CTR_DTACAD').AsDateTime := dteDataLanLoc;

        If fEmptyStr(fTiraCaracEspeciais(dbeDtaCad.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Cadastro deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If (StrToDate(dbeDtaCad.Text) > VS_Date) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Cadastro deve ser menor ou igual a Data Atual!', ['&O k']);
          Result := False;
        End
        Else If (fCfgSis('CTRCAD', varBoolean)) And (qryTabela.State = dsEdit) And (dtaDtaCadOld <> StrToDate(dbeDtaCad.Text)) And fEmptyStr(strSenhaDtaCadOld) Then
        Begin
          if fCfgSis('UTICON', varBoolean) and
               MatchStr(dbeEspDoc.Text, ['NF', 'IF']) Then
          begin
              fMensagem('ATENÇÃO!', 'Quando utiliza a rotina de contabilidade, ' +
                                    'não é permitido alterar a data de cadastro!', ['&O k']);
              Result := False;
          end
          else
          begin
            If (Not fEmptyStr(fCfgSis('CTRSDC'))) Then
            Begin
              If ffrmSenha(strSenha, 'Digite a Senha da Data Cadastro') Then
              Begin
                If strSenha <> fCfgSis('CTRSDC') Then
                  Result := False
                Else
                  strSenhaDtaCadOld := strSenha;
              End
              Else
                Result := False;
            End;
          end;
        End
        Else If  (not fCfgSis('CTRINF', varBoolean)) And (qryTabela.State = dsInsert) And ( not fVerificaAcessoSistema('ALTDTCAD', strLoginUsuarioLogado) ) And (StrToDate(dbeDtaCad.Text) <> VS_Date) And (dtaDtaCadOld <> StrToDate(dbeDtaCad.Text)) Then
        Begin
          objLiberacao.Clear;
          objLiberacao.objMsgLibera.pAddTexto('Data de cadastro de duplicata inferior a data atual!');
          objLiberacao.objMsgLibera.pAddQuebra;
          objLiberacao.objMsgLibera.pAddTextoCaption('Data de cadastro', dbeDtaCad.Text                                                         , 9);
          objLiberacao.objMsgLibera.pAddTextoCaption('Duplicata'       , qryTabela.FieldByName('CTR_NUMDUP').AsString                           , 9);
          objLiberacao.objMsgLibera.pAddTextoCaption('Parcela'         , qryTabela.FieldByName('CTR_PARCEL').AsString                           , 9);
          objLiberacao.objMsgLibera.pAddTextoCaption('Espécie'         , qryTabela.FieldByName('CTR_ESPDOC').AsString                           , 9);
          objLiberacao.objMsgLibera.pAddTextoCaption('Empresa'         , qryTabela.FieldByName('CTR_CODEMP').AsString                           , 9);
          objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'         , qryTabela.FieldByName('CTR_CODCLI').AsString + ' - ' + edtNomCli.Text  , 9);

          objLiberacao.strDirAce := 'ALTDTCAD';
          objLiberacao.strCodOpe := strLoginUsuarioLogado;
          objLiberacao.strMsgSen := 'Data de cadastro de duplicata inferior a data atual';
          objLiberacao.pInformaNumDocEspDocCodEmp(
                           qryTabela.FieldByName('CTR_NUMDUP').AsString,
                           qryTabela.FieldByName('CTR_ESPDOC').AsString,
                           qryTabela.FieldByName('CTR_CODEMP').AsString);

          If (Not objLiberacao.fLibera) Then
          Begin
            fMensagem('ATENÇÃO!','Não é permitido alterar a data do cadastro!', ['&O K']);
            Result := False;
          End
          else
            dtaDtaCadOld := StrToDate(dbeDtaCad.Text);
        End;

        //FECHAMENTO FINANCEIRO
        //VERIFICA SE É INSERÇÃO OU UMA ALTERAÇÃO DE DATA DE CADASTRO
        if (qryTabela.State = dsInsert) then
          if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, StrToDate(dbeDtaCad.Text)) then
              Result := False;

        if ((qryTabela.State = dsEdit) And (ADataCadastroInicial <> StrToDate(dbeDtaCad.Text))) then
        begin
          if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, ADataCadastroInicial) then
            Result := False
          else
          if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, StrToDate(dbeDtaCad.Text)) then
            Result := False;
        end;

      End

      {*****************************************}
      {* VALIDA A DATA DE VENCIMENTO           *}
      {**************************************MV*}
      Else If (Sender = dbeDtaVen) Then
      Begin
        if (dteDataVenLoc  <> 0) and (dteDataVenLoc  <> StrToDate(dbeDtaVen.Text)) then
          qryTabela.FieldByName('CTR_DTAVEN').AsDateTime := dteDataVenLoc;

        If fEmptyStr(fTiraCaracEspeciais(dbeDtaVen.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Vencimento deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If (StrToDate(dbeDtaVen.Text) < StrToDate(dbeDtaCad.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A Data de Vencimento deve ser maior ou igual a Data de Cadastro!', ['&O k']);
          Result := False;
        End
        {****************************************************************}
        {* VERIFICA SE A DATA DE VENCIMENTO ESTÁ DENTRO DO PRAZO MÁXIMO *}
        {*************************************************************LU*}
        Else If (fCfgSis('PRZVEN', varInteger) >= 0) Then
        Begin
          If (StrToDate(dbeDtaVen.Text) > (dtaDtaVenPrzVen + fCfgSis('PRZVEN', varInteger))) And (qryTabela.State = dsEdit) Then
          Begin
            fMensagem('ATENÇÃO!', 'Data máxima para prorrogação do vencimento: ' + FormatDateTime('dd/mm/yyyy',(dtaDtaVenPrzVen + fCfgSis('PRZVEN', varInteger))), ['&O k']);
            Result := False;
          End
          Else If (fCfgSis('CTRDTA', varBoolean)) And (qryTabela.State = dsEdit) And (dtaDtaVenOld <> StrToDate(dbeDtaVen.Text)) And fEmptyStr(strSenhaDtaVenOld) Then
          Begin
            If (Not fEmptyStr(fCfgSis('CTRSDV'))) Then
            Begin
              If ffrmSenha(strSenha, 'Digite a Senha da Data Vencimento') Then
              Begin
                If strSenha <> fCfgSis('CTRSDV') Then
                  Result := False
                Else
                  strSenhaDtaVenOld := strSenha;
              End
              Else
                Result := False;
            End
            Else
            Begin
              If Not(FLiberaVencimento) and Not(fVerificaAcessoSistema('CTRALTVENDUP', strLoginUsuarioLogado)) then
              begin
                Result := fSenhaAlteracaoVencimentoDuplicata;
                FLiberaVencimento := Result;
              end;
            End;
          End;
        End;
      End

      {*****************************************}
      {* VALIDA O VALOR DA DUPLICATA           *}
      {**************************************MV*}
      Else If (Sender = dbeValDup) Then
      Begin

        if (fltValLanLoc <> 0) and (fltValLanLoc <> fStrToFloat(dbeValDup.Text)) then
        begin
            qryTabela.FieldByName('CTR_VALDUP').AsFloat := fltValLanLoc;
        end;

        if not(PermitirIncluirCreditoClienteComValorPositivo) then
        begin
          fMensagem('ATENÇÃO!', 'Não é permitido incluir um crédito (CC) com valor positivo quando a configuração [CFG_CCPOSI] está definida como "Não".', ['&O k']);
          Result := False;
        end;

        If fEmptyStr(dbeValDup.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor da Duplicata deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If fStrToFloat(dbeValDup.Text) = 0.0 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Valor da Duplicata deve ser diferente de Zero!', ['&O k']);
          Result := False;
        End
        Else If (FloatToStrF(fltValDupAnt, ffNumber, 12, 2) <> dbeValDup.Text) Then
        Begin
          fltValDup := fStrToFloat(dbeValDup.Text);
          If fltValDup > MAX_VALMON Then
          Begin
            fltValDup   := MAX_VALMON;
            dbeValDup.Text := FloatToStr(fltValDup);
          End;

          fltValOriAnt := fltValOriAnt + (fStrToFloat(dbeValDup.Text) - fltValDupAnt);
          fltValDupAnt := fStrToFloat(dbeValDup.Text);
          qryTabela.FieldByName('CTR_VALORI').AsFloat := fltValOriAnt;
        End;

        If (fStrToFloat(dbeValDup.Text) < 0.0)                         And
           Not fVerificaAcessoSistema('INCCRE', strLoginUsuarioLogado) Then
        Begin
          fMensagem('ATENÇÃO!','Lançamento de crédito não permitido!', ['&O K']);
          Result := False;
        End;

        if (qryTabela.State = dsEdit) And
           (fStrToFloat(strValDupOld) <> fStrToFloat(dbeValDup.Text)) and
           (TValidacoesPagamentoOnline.fAgrupamentoPossuiLinkPagamento(dbeNumDup.Text, dbeEspDoc.Text, dbeCodEmp.Text, dbeCodCli.Text)) then
        begin
          fMensagem('ATENÇÃO!', 'Não será possível alterar o valor desta duplicata pois existe link de pagamento! ', ['&O K']);
          pSetFocus(Sender);
          Result := False;
          exit ;
        end ;

        If (fCfgSis('CTRVAL', varBoolean)) And (qryTabela.State = dsEdit) And (fStrToFloat(strValDupOld) <> fStrToFloat(dbeValDup.Text)) And fEmptyStr(strSenhaValDupOld) Then
        Begin
          If (Not fEmptyStr(fCfgSis('CTRSVD'))) Then
          Begin
            If ffrmSenha(strSenha, 'Digite a Senha do Valor Duplicata') Then
            Begin
              If strSenha <> fCfgSis('CTRSVD') Then
                Result := False
              Else
                strSenhaValDupOld := strSenha;
            End
            Else
              Result := False;
          End;
        End;

        //FECHAMENTO FINANCEIRO
        //SE O VALOR TOTAL FOR ALTERADO VERIFICA FECHAMENTO
        if (qryTabela.State = dsEdit) And
           (AValorTotalInicial <> fStrToFloat(dbeValDup.Text)) Then
        begin
          if objFechamento.FechamentoFinanceiroJaRealizado(dbeCodEmp.Text, qryTabela.FieldByName('CTR_DTACAD').AsDateTime) then
            Result := False;
        end;

        If (qryTabela.State = dsEdit) And (fStrToFloat(strValDupOld) <> fStrToFloat(dbeValDup.Text)) And (dbeEspDoc.Text = 'CC') Then
        Begin
          pAdicionarDuplicataNoArray;
          strMovBan := fCreditoDiretoComMovBan(arrDupSel);
          if Not fEmptyStr(strMovBan) And EstaConciliado(strMovBan, 'CADREC') And (Not blnExitValDup) then
          begin
            fMensagem('', 'Não é possível alterar o valor desse título, pois o mesmo está conciliado. ' +
                          'Para ser possível altera-lo, o mesmo deve ser desconciliado. Acessar PRINCIPAL > CONTROLE FINANCEIRO > CONCILIAÇÃO BANCÁRIA.', ['&O k']);
            Result := False;
          end
          Else
          If (qryTabela.FieldByName('CTR_SEQBAI').AsInteger = 0) And
             (fCtrExisteDupDependentes(qryTabela.FieldByName('CTR_NUMDUP').AsString,
                                       qryTabela.FieldByName('CTR_PARCEL').AsString,
                                       qryTabela.FieldByName('CTR_ESPDOC').AsString,
                                       qryTabela.FieldByName('CTR_CODEMP').AsString,
                                       qryTabela.FieldByName('CTR_CODCLI').AsString)) Then
          Begin
            fMensagem('AVISO','Este crédito já foi utilizado parcialmente em um recebimento. Portanto, o valor não pode ser alterado!',['&OK']);
            Result := False;
          End
          Else
          Begin
            If Not fEmptyStr(strMovBan) And
              (qryTabela.State = dsEdit) And
              (fStrToFloat(strValDupOld) <> fStrToFloat(dbeValDup.Text))And
              (dbeEspDoc.Text = 'CC') And (Not blnExitValDup) And
              (fStrToFloat(strUltVlrAlt)  <> fStrToFloat(dbeValDup.Text)) Then
            Begin
              strUltVlrAlt := dbeValDup.Text;
              fMensagem('', 'Crédito direto com movimentação bancária, o valor do lançamento também será atualizado!', ['&O k']);
            End;
          End;
        End;
      End

      {*****************************************}
      {* VALIDA AS DESPESAS DE COBRANÇA        *}
      {**************************************MV*}
      Else If (Sender = dbeDesCob) Then
      Begin
        If Not fEmptyStr(dbeDesCob.Text) Then
        Begin

          If fStrToFloat(dbeDesCob.Text) < 0.0 Then
          Begin
            fMensagem('ATENÇÃO!', 'O campo Despesa de Cobrança deve ser maior ou igual a Zero!', ['&O k']);
            Result := False;
          End
          Else
          Begin
            fltDesCob := fStrToFloat(dbeDesCob.Text);
            If fltDesCob > MAX_VALMON Then
              dbeDesCob.Text := FloatToStr(MAX_VALMON);
          End;

        End;
      End

      {*****************************************}
      {* VALIDA O CAMPO 'DUPLICATA DESCONTADA' *}
      {**************************************MV*}
      Else If (Sender = dbeDescon) Then
      Begin
        Result := fValidoSimNao(dbeDescon.Text);
      End

      {*********************}
      {* VALIDA O PORTADOR *}
      {******************RV*}
      Else If (Sender = dbeCodPor) Then
      Begin
        if (strCodPorLoc <> '') and (strCodPorLoc  <> dbeCodPor.Text) then
          qryTabela.FieldByName('CTR_CODPOR').AsString := strCodPorLoc;

        If (fCfgSis('OBRPOR', varBoolean)) Then
        Begin

          If fEmptyStr(dbeCodPor.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'O Portador, deve ser preenchido!', ['&O k']);
            Result := False;
          End;

        End
        Else
        Begin
          If fEmptyStr(dbeCodPor.Text) Then
          Begin
            edtNomPor.Text := '';
          End;
        End;

        If (Result) And (Not fEmptyStr(dbeCodPor.Text)) Then
        Begin
          pCarregaPortador;
          If fEmptyStr(edtNomPor.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Este portador não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If Not FValidaCorrespondenteContabil.PortadorPossuiCorrespondenteContabil(dbeCodPor.Text,dbeCodEmp.Text) Then
          Begin
            Result := False;
          End
          {*REQ*145940**********RP*}
          Else If Not fEmpresaTemAcessoPortador(dbeCodPor.Text, dbeCodEmp.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok']);
            Result := False;
          End
          Else If fCfgSis('DACPOR', varBoolean) Then
          Begin
            If Pos(dbeCodPor.Text, strPortadoresOperador) <= 0 Then
            Begin
              fMensagem('ATENÇÃO!', 'Usuário sem permissão de acesso aos lançamentos para este portador!', ['&O k']);
              Result := False;
            End;
          End;

        End;

        If (fCfgSis('CTRPOR', varBoolean)) And (qryTabela.State = dsEdit) And (strCodPorOld <> dbeCodPor.Text) And fEmptyStr(strSenhaCodPorOld) And (not fEmptyStr(strCodPorOld)) Then
        Begin
          If (Not fEmptyStr(fCfgSis('CTRSPO'))) Then
          Begin
            If ffrmSenha(strSenha, 'Digite a Senha do Portador da Duplicata') Then
            Begin
              If strSenha <> fCfgSis('CTRSPO') Then
                Result := False
              Else
                strSenhaCodPorOld := strSenha;
            End
            Else
              Result := False;
          End;
        End;
      End

      {*****************************************}
      {* VALIDA O NOSSO NÚMERO                 *}
      {**************************************MV*}
      Else If (Sender = dbeNosNum) And ((qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit))Then
      Begin

        If fValidaNossoNumero(dbeNosNum.Text,
                              qryTabela.FieldByName('CTR_CODEMP').AsString,
                              qryTabela.FieldByName('CTR_BCOBOL').AsString,
                              strNumDup,
                              IIF(qryTabela.State = dsInsert, EmptyStr, dbeNumDup.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse nosso número já existe na duplicata ' + strNumDup + '!', ['&O k']);
          Result := False;
        End;

        if qryTabela.FieldByName('CTR_NOSNUM').OldValue <> dbeNosNum.Text then
        Begin
          qryTabela.FieldByName('CTR_LINDIG').Value    := Null;
          qryTabela.FieldByName('CTR_DTABOL').Value    := Null;
          qryTabela.FieldByName('CTR_BCOBOL').Value    := Null;
          qryTabela.FieldByName('CTR_CARTEI').AsString := '';
          qryTabela.FieldByName('CTR_CODCED').Value    := Null;
        End;
        btnNossNumCompleto.Visible := Not fEmptyStr(RetornaNossoNumeroCompleto);
      End

      {*****************************************}
      {* VALIDA O CÓDIGO DO EVENTO             *}
      {**************************************LB*}
      Else If (Sender = fraCentroCusto.dbeCodEve) Then
      Begin
        If Not fEmptyStr(fraCentroCusto.dbeCodEve.Text) Then
        Begin
          pCarregaEventos;
          If fEmptyStr(fraCentroCusto.edtDesEve.Text) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Centro de Custos não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If (fRetTipoEvento(fraCentroCusto.dbeCodEve.Text)='P') Then
          Begin
            fMensagem('ATENÇÃO', 'Esse Centro de Custos pode ser aplicado somente às contas a pagar!',['&OK']);
            Result := False;
          End;
        End
        Else
        Begin
          qryTabela.FieldByName('CTR_CODEVE').AsVariant := Null;
          fraCentroCusto.edtDesEve.Clear;
        End;
      End

      {*****************************************}
      {* VALIDA VALIDA O CENTRO DE CUSTO       *}
      {**************************************MV*}
      Else If (Sender = fraPlanoDeContas.dbeCodCta) And (fraPlanoDeContas.dbeCodCta.Visible) Then
      Begin

        If fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) Then
        Begin
          fraPlanoDeContas.dbeCodCta.Field.Value := Null;
          fraPlanoDeContas.edtDesCta.Clear;
        End
        Else If (Not fValidaLinhaGrupoCadCta(fraPlanoDeContas.dbeCodCta.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Linha / Grupo não é permitido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If (qryTabela.State = dsInsert) Then
          Begin
            pCarregaCentroCusto;
            If Not PlanoDeContasAtivo(fraPlanoDeContas.dbeCodCta.Text) Then
              Result := False;
          End
          Else
          Begin
            pCarregaCentroCusto;
            If strPlanoContasOri <> fraPlanoDeContas.dbeCodCta.Text Then
            Begin
              If Not PlanoDeContasAtivo(fraPlanoDeContas.dbeCodCta.Text) Then
                Result := False;
            End;
          End;

          If qryConCta.FieldByName('CTA_CODCTA').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Plano de Contas não está cadastrado!', ['&O k']);
            Result := False;
          End
          Else If Not FValidaCorrespondenteContabil.PlanoDeContasPossuiCorrespondenteContabil(fraPlanoDeContas.dbeCodCta.Text,dbeCodEmp.Text) Then
          Begin
            Result := False;
          End;
        End;

        if not Result then
        begin
          fraPlanoDeContas.dbeCodCta.Field.Value := Null;
          fraPlanoDeContas.edtDesCta.Clear;
        end;

      End

      {*****************************************}
      {* VALIDA O CÓDIGO DO VENDEDOR           *}
      {**************************************MV*}
      Else If (Sender = dbeCodVen) Then
      Begin
        If fEmptyStr(dbeCodVen.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'O Código do Vendedor ser preenchido!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          pCarregaVendedor;
          If qryConOpe.FieldByName('OPE_CODOPE').IsNull Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse Vendedor não está cadastrado!', ['&O k']);
            Result := False;
          End Else
          Begin
            If (qryTabela.FieldByName('CTR_CODDIG').IsNull) Or
               fEmptyStr(qryTabela.FieldByName('CTR_CODDIG').AsString) Then
              qryTabela.FieldByName('CTR_CODDIG').AsString :=  dbeCodVen.Text;
          End;
        End;
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

      End;
    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadCtaReceber.pInicializaIndices;
begin
  inherited;
  pAtribuiTabelas;

  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('CTR_NUMDUP');
  stlCamInd.Add('CLI_NOMCLI+CTR_DTAVEN');
  stlCamInd.Add('CLI_FANSOB+CTR_NUMDUP');
  stlCamInd.Add('CTR_NOSNUM');
  stlCamInd.Add('CTR_DTAVEN');
  stlCamInd.Add('CTR_DTACAD');
  stlCamInd.Add('CTR_CODVEL');
  stlCamInd.Add('CTR_VALDUP');
  stlCamInd.Add('CTR_VALREC');
  stlCamInd.Add('CTR_VALORI');
  stlCamInd.Add('POR_NOMPOR');

  stlDesInd.Add('Duplicata');
  stlDesInd.Add('Cliente/Vencimento');
  stlDesInd.Add('Nome Fantasia/Duplicata');
  stlDesInd.Add('Nosso Número');
  stlDesInd.Add('Vencimento');
  stlDesInd.Add('Data de Cadastro');
  stlDesInd.Add('Documento Antigo');
  stlDesInd.Add('Valor Duplicata');
  stlDesInd.Add('Valor Recebido');
  stlDesInd.Add('Valor Original');
  stlDesInd.Add('Portador');  
end;

procedure TfrmCadCtaReceber.pInicializarTabela(strSQL: String);
begin
  if assigned(qryTabela) then
    FreeAndNil(qryTabela);

  qryTabela := fCriarQuery(strSQL, Self);
  qryTabela.AfterOpen := pAfterOpen;
  qryTabela.FieldByName('CTR_DTAENV').OnSetText := pqryCadRecCTR_DTAENVSetText;
  dtsTabela.DataSet := qryTabela;
end;

{*****************************************}
{* INICIALIZA OS VALORES PADRÃO          *}
{**************************************MV*}
procedure TfrmCadCtaReceber.pIniciaValoresPadrao;
begin
  qryTabela.FieldByName('CTR_PARCEL').AsString   := 'A';
  qryTabela.FieldByName('CTR_DESCON').AsString   := 'N';
  qryTabela.FieldByName('CTR_CODEMP').AsString   := VS_strCodEmp;
  qryTabela.FieldByName('CTR_DTACAD').AsDateTime := VS_Date;
  qryTabela.FieldByName('CTR_DTAVEN').AsDateTime := VS_Date;
  qryTabela.FieldByName('CTR_SEQBAI').AsInteger  := 0;
  dtaDtaCadOld := qryTabela.FieldByName('CTR_DTACAD').AsDateTime;
end;

procedure TfrmCadCtaReceber.pLimpaDadosBoleto;
begin
  qryTabela.FieldByName('CTR_LINDIG').Value := Null;
end;

class procedure TfrmCadCtaReceber.pMostraIniciandoCadastro(fltValLan: Double;
  strHist01: String; dteDataLan: TDate; dteDataVen: TDate;
  strCodPor: String; aLanExtInc: Boolean;
  strEspecie: String);
var
  frmCadCtaReceber: TfrmCadCtaReceber;
begin
  pCriarFormularios(TfrmCadCtaReceber, frmCadCtaReceber);
  try
    with frmCadCtaReceber do
    begin
      blnIniciaCadastro := True;

      fltValLanLoc  := IIF(aLanExtInc,fFormataFloat((fltValLan * -1),2),fltValLan);
      strHist01Loc  := strHist01;
      strCodPorLoc  := strCodPor;
      dteDataLanLoc := dteDataLan;
      dteDataVenLoc := dteDataVen;
      strEspecieLoc := strEspecie;

      ShowModal;
    end;
  except
    On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadCtaReceber.pMostraIniciandoCadastro]');
  end;
  pFreeAndNil(frmCadCtaReceber);
end;

procedure TfrmCadCtaReceber.pHabilitaDesabiltabtnAbrirPastaAnexos;
begin
    If (qryTabela.Active) And Not (qryTabela.IsEmpty) Then
    btnAbrirPastaAnexos.Enabled := Not (qryTabela.State = dsInsert);
end;

procedure TfrmCadCtaReceber.pHabilitaEditFields;
begin
  {***********************************************}
  {* SE ENCONTRAR DUPLICATA COM A CHAVE DIGITADA *}
  {* VERIFICA AS CONFIGURAÇÕES PARA DESABILITAR  *}
  {* OS CAMPOS VALOR E DTA VENCTO                *}
  {** 22/02/2008 ***************************ER****}
  If Not fCfgSis('CTRVAL', varBoolean)  Then
  Begin
    dbeValDup.Enabled := False;
    dbeValDup.TabStop := False;
  End
  Else Begin
    dbeValDup.Enabled := True;
    dbeValDup.TabStop := True;
  End;

  If Not fCfgSis('CTRDTA', varBoolean) Then
  Begin
    dbeDtaVen.Enabled := False;
    dbeDtaVen.TabStop := False;
  End
  Else Begin
    dbeDtaVen.Enabled := True;
    dbeDtaVen.TabStop := True;
  End;

  If Not fCfgSis('CTRCAD', varBoolean) Then
  Begin
    dbeDtaCad.Enabled := False;
    dbeDtaCad.TabStop := False;
  End
  Else Begin
    dbeDtaCad.Enabled := True;
    dbeDtaCad.TabStop := True;
  End;

  If Not fCfgSis('CTRPOR', varBoolean) Then
  Begin
    dbeCodPor.Enabled := False;
    dbeCodPor.TabStop := False;
  End
  Else Begin
    dbeCodPor.Enabled := True;
    dbeCodPor.TabStop := True;
  End;
end;


procedure TfrmCadCtaReceber.FormShow(Sender: TObject);
  Var
    blnUsaTarifa: Boolean;
begin
  inherited;

  if not fEmptyStr(strAutoincrem) then
  begin
    If strOrigem = 'frmBaixaReceber' Then
      btnBaixarDup.Visible := False;

    pInicializarTabela('SELECT * FROM CADREC WHERE AUTOINCREM = ' + strAutoincrem.QuotedString);
    qryTabela.Open;
  end;

  {*****************************************}
  {* ESSE CAMPO É ZERADO PARA QUE O PAICAD *}
  {* NÃO PREENCHA O CÓDIGO DA EMPRESA AU-  *}
  {* TOMATICAMENTE                         *}
  {**************************************MV*}
  strCampoEmp := '';

  If Not (fCfgSis('EMPGER', varBoolean)) Then
  Begin
    btnAlterar.Tag := 88;
    btnExcluir.Tag := 88;
    btnAlterar.Enabled  := False;
    btnExcluir.Enabled  := False;
    btnImprimir.Enabled := False;
  End;

  If (Not fCfgSis('CTAFAT', varBoolean)) Then
  Begin
    fraPlanoDeContas.lblPlaContas.Visible := False;
    fraPlanoDeContas.dbeCodCta.Visible    := False;
    fraPlanoDeContas.edtDesCta.Visible    := False;
  End;

  blnUsaTarifa := fCfgSis('ENCBAN', varBoolean);

  edtValorTarifa.Visible := blnUsaTarifa;
  edtPorTar.Visible      := blnUsaTarifa;
  edtCtaTar.Visible      := blnUsaTarifa;
  edtForTar.Visible      := blnUsaTarifa;
  lblValtar.Visible      := blnUsaTarifa;
  lblPorTar.Visible      := blnUsaTarifa;
  lblCtaTar.Visible      := blnUsaTarifa;
  lblForTar.Visible      := blnUsaTarifa;

  lblValJur.Visible := Not blnUsaTarifa;
  lblValDes.Visible := Not blnUsaTarifa;
  edtValJur.Visible := Not blnUsaTarifa;
  edtValDes.Visible := Not blnUsaTarifa;

  pCarregaDadosAdicionais;
  pCalculaValorTotal();

  If Not fVerificaAcessoSistema('REMCTR') Then
  Begin
    pnlEnvBan.Visible := FALSE;
    self.Height := self.Height - pnlEnvBan.Height;
  End;

  if blnIniciaCadastro then
  begin
    btnIncluir.Click;

    if fltValLanLoc <> 0 then
    begin
      dbeValDup.DataSource.DataSet.FieldByName('CTR_VALDUP').Value := fltValLanLoc;
      dbeValDup.Text := FormatFloat('#,###,##0.00', fltValLanLoc);
      dbeValDupExit(dbeValDup);
    end;

    if dteDataLanLoc <> 0 then
      dbeDtaVen.DataSource.DataSet.FieldByName('CTR_DTACAD').Value := dteDataLanLoc;

    if  dteDataVenLoc <> 0 then
      dbeDtaVen.DataSource.DataSet.FieldByName('CTR_DTAVEN').Value := dteDataVenLoc;

    if strHist01Loc <> '' then
      dbeHisto1.DataSource.DataSet.FieldByName('CTR_HIST01').Value := strHist01Loc;

    if strCodPorLoc <> '' then
    begin
      dbeCodPor.DataSource.DataSet.FieldByName('CTR_CODPOR').Value := strCodPorLoc;
      pCarregaPortador;
    end;

    if  strEspecieLoc <> '' then
      dbeEspDoc.DataSource.DataSet.FieldByName('CTR_ESPDOC').Value := strEspecieLoc;

  end;
  pUtilizaRotinaProjeto;
end;

procedure TfrmCadCtaReceber.btnDetalharHistoricoClick(Sender: TObject);
  Var
    frmDetalheHistoricos : TfrmDetalheHistoricos;
begin
  inherited;
  If fEmptyStr(edtOpeBai.Text) Then
    Exit;

  If qryTabela.IsEmpty Then
    Exit;

  pCriarFormularios(TfrmDetalheHistoricos, frmDetalheHistoricos);
  Try
    frmDetalheHistoricos.strAutoIncrem := qryTabela.FieldByName('AUTOINCREM').AsString;
    frmDetalheHistoricos.ShowModal;
  Finally
    pFreeAndNil(frmDetalheHistoricos);
  End;
end;

procedure TfrmCadCtaReceber.btnDetalharValoresBaixaClick(Sender: TObject);
Var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);

  With qryAux Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT CTR_DINHEI, CTR_CHQAVI, CTR_CHQPRE, CTR_CARTAO, ');
    SQL.Add('       CTR_ORDPAG, CTR_VALFIN, CTR_VALREC, CTR_VALJUR, ');
    SQL.Add('       CTR_ORDPAG, CTR_VALFIN, CTR_VALREC, CTR_VALJUR, ');
    SQL.Add('       CTR_VALDES, CTR_EMPBAI, CTR_SEQCON, CTR_CODCLI, ');
    SQL.Add('       CTR_SEQCON, CTR_NUMDUP, CTR_ESPDOC, CTR_PARCEL, ');
    SQL.Add('       CTR_ADTCLI, CTR_CODEMP, CTR_VALCOB              ');
    SQL.Add('FROM CADREC ');
    SQL.Add('WHERE CTR_NUMDUP = :NUMDUP AND ');
    SQL.Add('      CTR_PARCEL = :PARCEL AND ');
    SQL.Add('      CTR_ESPDOC = :ESPDOC AND ');
    SQL.Add('      CTR_CODEMP = :CODEMP AND ');
    SQL.Add('      CTR_CODCLI = :CODCLI AND ');
    SQL.Add('      CTR_SEQBAI = :SEQBAI ');
    ParamByName('NUMDUP').AsString  := dbeNumDup.Text;
    ParamByName('PARCEL').AsString  := dbeParcel.Text;
    ParamByName('ESPDOC').AsString  := dbeEspDoc.Text;
    ParamByName('CODEMP').AsString  := dbeCodEmp.Text;
    ParamByName('CODCLI').AsString  := dbeCodCli.Text;
    ParamByName('SEQBAI').AsInteger := qryTabela.FieldByName('CTR_SEQBAI').AsInteger;
    Open;
  End;

  pCriarFormularios(TfrmCtrDetalhesBaixa, frmCtrDetalhesBaixa);
  Try
    frmCtrDetalhesBaixa.dtsCtaReceber := qryAux;
    frmCtrDetalhesBaixa.ShowModal;
  Finally
    FreeAndNil(frmCtrDetalhesBaixa);
    FreeAndNil(qryAux);
  End;
end;

procedure TfrmCadCtaReceber.btnDocBaixaClick(Sender: TObject);
begin
  inherited;
  If qryTabela.RecordCount = 0 Then
  Begin
    fMensagem('ATENÇÃO!','É necessário CARREGAR uma duplicata BAIXADA para exibir os documentos!',['&O k']);
    Exit;
  End;

  If (qryTabela.RecordCount > 0)
  And (qryTabela.FieldByName('CTR_DTAREC').IsNull) Then
  Begin
    fMensagem('ATENÇÃO!','A duplicata deve estar BAIXADA para exibir os documentos!',['&O k']);
    Exit;
  End;

  pCriarFormularios(TfrmCtrDocBaixa, frmCtrDocBaixa);
  Try
    frmCtrDocBaixa.SeqCon := qryTabela.FieldByName('CTR_SEQCON').AsInteger;
    frmCtrDocBaixa.EmpBai := qryTabela.FieldByName('CTR_EMPBAI').AsString;
    frmCtrDocBaixa.NomeTabela := 'CADREC';
    frmCtrDocBaixa.ShowModal;
  Finally
    FreeAndNil(frmCtrDocBaixa);
  End;
end;

procedure TfrmCadCtaReceber.btnAcompEntregaClick(Sender: TObject);
  Var
    frmConsultaPedidos : TfrmConsultaPedidos;
begin
  inherited;
  Try
    If (Not fVerificaAcessoSistema('frmTelAcompEntrega')) Then Begin
      fMensagem('', 'Operador não tem direito de acesso ao Acompanhamento da Entrega!', ['&OK']);
      Exit;
    End;

    pCriarFormularios(TfrmConsultaPedidos, frmConsultaPedidos);

    If Not qryTabela.IsEmpty Then
    Begin
      frmConsultaPedidos.NumDocFat := qryTabela.FieldByName('CTR_NUMDUP').AsString;
      frmConsultaPedidos.EspFat    := qryTabela.FieldByName('CTR_ESPDOC').AsString;
      frmConsultaPedidos.EmpFat    := qryTabela.FieldByName('CTR_CODEMP').AsString;
      frmConsultaPedidos.CodCli    := qryTabela.FieldByName('CTR_CODCLI').AsString;
      frmConsultaPedidos.blnCadCtaReceber := True;
    End;

    If frmConsultaPedidos.EspFat = 'AG' then
      fMensagem('', 'Esse documento é um Agrupamento, portanto não possui acompanhamento de entrega vinculado!', ['&OK']);

    frmConsultaPedidos.ShowModal;
  Finally
    FreeAndNil(frmConsultaPedidos);
  End;
end;

function TfrmCadCtaReceber.BoletoCancelado: Boolean;
begin
  Result := False;

  If (qryTabela.State in [dsEdit]) Then
  Begin
    If qryTabela.FieldByName('CTR_LINDIG').OldValue <> Null Then
    Begin
      If qryTabela.FieldByName('CTR_NOSNUM').OldValue <> dbeNosNum.Text Then
        Result := True;
    End;
  End;
end;

procedure TfrmCadCtaReceber.btnAbrirPastaAnexosClick(Sender: TObject);
Var
  strCaminhoPastaAntiga: String;
begin
  inherited;

  If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) Then
    Exit;

  Try
    pCriarFormularios(TfrmGravaArquivoPasta, frmGravaArquivoPasta);

    strCaminhoPastaAntiga := ExtractFilePath(Application.ExeName)+ 'ANEXOS_CTR\' + qryTabela.FieldByName('AUTOINCREM').AsString ;

    frmGravaArquivoPasta.strCaminhoPasta := ExtractFilePath(Application.ExeName)+ 'ANEXOS_CTR\' +
                                                            fStrZero( qryTabela.FieldByName('CTR_CODCLI').AsString, 8  ) + '-' +
                                                            fStrZero( qryTabela.FieldByName('CTR_CODEMP').AsString, 3  ) + '-' +
                                                            fStrZero( qryTabela.FieldByName('AUTOINCREM').AsString, 20 ) ;
    If DirectoryExists( strCaminhoPastaAntiga ) Then
    Begin
       TDirectory.Move( strCaminhoPastaAntiga, frmGravaArquivoPasta.strCaminhoPasta );
       Sleep(500);
    End;

    frmGravaArquivoPasta.Caption := 'Pasta ( Arquivos Anexos )';
    frmGravaArquivoPasta.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmGravaArquivoPasta);
end;

procedure TfrmCadCtaReceber.btnAlterarClick(Sender: TObject);
  Var
    blnPodeAlterar: Boolean;
begin
  If (Not qryTabela.Active Or qryTabela.IsEmpty) Then
  begin
    fMensagem('ATENÇÃO!', 'Por favor, escolha um registro para essa operação!', ['&O k']);
    Exit;
  end;

  If ( TAdiantamentoGenerico.fRetornaValorBoletosAdiantamento(
                        qryTabela.FieldByName('CTR_NUMDUP').AsString,
                        qryTabela.FieldByName('CTR_ESPDOC').AsString,
                        qryTabela.FieldByName('CTR_CODEMP').AsString,
                        qryTabela.FieldByName('CTR_CODCLI').AsString) > 0 ) Then
  Begin
    if fCfgSis('BOLADI', varBoolean) then
    begin
      fMensagem('ATENÇÃO!', 'Duplicata de boleto de adiantamento não pode ser alterada. '+
        'Favor alterar o pedido de venda caso deseje alterar o valor da duplicata ou exclua '+
        'a duplicata e gere novamente o boleto pela baixa de contas a receber!', ['&OK']);
    end
    else
    begin
      fMensagem('ATENÇÃO!', 'Duplicata de boleto de adiantamento não pode ser alterada. '+
        'Favor alterar o pedido de venda caso deseje alterar o valor da duplicata!', ['&OK']);
    end;
    Exit;
  End;

  If Not qryTabela.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
  Begin
    If qryTabela.FieldByName('CTR_DTAREC').AsString.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO!', 'Duplicata com Pix gerado e ativo não pode ser alterada. ' + #13#10 +
                            'Caso deseje alterar a duplicata, remova o Pix gerado!', ['&OK']);
      Exit;
    End;
  End;

  {*******************************************}
  {* INICIO AS VARIAVEIS PARA PODER USA-LAS  *}
  {* NO VALIDA CAMPOS                        *}
  {****************************************AC*}
  dtaDtaCadOld := qryTabela.FieldByName('CTR_DTACAD').AsDateTime;
  dtaDtaVenOld := qryTabela.FieldByName('CTR_DTAVEN').AsDateTime;
  strValDupOld := FloatToStr(qryTabela.FieldByName('CTR_VALDUP').AsFloat);
  strCodPorOld := qryTabela.FieldByName('CTR_CODPOR').AsString;

  dtaDtaVenPrzVen := fRetornaDtaVenLogCtr(dbeNumDup.Text, dbeParcel.Text, dbeEspDoc.Text, dbeCodEmp.Text, dbeCodCli.Text);

  If dtaDtaVenPrzVen = 0 Then
    dtaDtaVenPrzVen := StrToDate(dbeDtaVen.Text);

  strCodBco := qryTabela.FieldByName('CTR_BCOENV').AsString;
  dtaDtaEnv := qryTabela.FieldByName('CTR_DTAENV').AsDateTime;

  If Not blnDupTravada Then
  Begin
    fLock_Unlock(strNomeTabela +
                 qryTabela.FieldByName('CTR_NUMDUP').AsString +
                 qryTabela.FieldByName('CTR_ESPDOC').AsString +
                 qryTabela.FieldByName('CTR_CODEMP').AsString +
                 qryTabela.FieldByName('CTR_CODCLI').AsString +
                 qryTabela.FieldByName('CTR_PARCEL').AsString,
                 True,
                 False);

    blnDupTravada := True;
  end;

  If (blnDupBaixada) Or ((blnEnviada) And (Not fVerificaAcessoSistema('DADUEB'))) Then
  Begin
    btnAlterar.Enabled   := False;
    btnExcluir.Enabled   := False;
    btnPesquisa.Enabled  := False;
    btnIncluir.Enabled   := False;
    btnBaixarDup.Enabled := False;
    btnDocBaixa.Enabled  := False;
    btnImprimir.Enabled  := False;
    btnSair.Enabled      := False;
    btnHistReceb.Enabled := False;
    btnGravar.Enabled    := True;
    btnCancela.Enabled   := True;
    dbeHisto1.Enabled    := True;
    btnEstornoCtr.Enabled:= False;
    btnReenviarRelAgrup.enabled := false;
    pHabilitaDesabiltabtnAbrirPastaAnexos;

    If blnDupBaixada Then
    Begin
      fraPlanoDeContas.dbeCodCta.Enabled := True;
      qryTabela.Edit;
      pSetFocus(fraPlanoDeContas.dbeCodCta);
    End
    Else
      pSetFocus(dbeHisto1);
  End
  Else
  Begin

    blnPodeAlterar := True;
    btnImprimir.Enabled := False;

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
      inherited;
      If blnAlterou Then
      Begin
        btnBaixarDup.Enabled := False;
        btnDocBaixa.Enabled  := False;
        pHabilitaCodigo(dbeNumDup, dbeDtaCad, False);
        btnReenviarRelAgrup.enabled := false;
        pHabilitaDesabiltabtnAbrirPastaAnexos;
        dbeParcel.Enabled := False;
        dbeEspDoc.Enabled := False;
        dbeCodEmp.Enabled := False;
        dbeCodCli.Enabled := False;

        If Not fCfgSis('CTRVAL', varBoolean) Then
          dbeValDup.Enabled := False;

        If Not fCfgSis('CTRDTA', varBoolean) Then
          dbeDtaVen.Enabled := False;

        If Not fCfgSis('CTRCAD', varBoolean) Then
          dbeDtaCad.Enabled := False;

        If Not fCfgSis('CTRPOR', varBoolean) Then
          dbeCodPor.Enabled := False;

        if fEmptyStr(qryTabela.FieldByName('CTR_BCOENV').AsString) then
        begin
          dbeNosNum.Enabled := fVerificaAcessoSistema('ALTNNB', strLoginUsuarioLogado);
        end
        else
          dbeNosNum.Enabled := False;

        strSenhaDtaCadOld := '';
        strSenhaDtaVenOld := '';
        strSenhaValDupOld := '';
        strSenhaCodPorOld := '';
        FLiberaVencimento := False;

      End;
      HabilitarCampoProjeto;
    End
    Else
    Begin
      fMensagem('ATENÇÃO!', 'Uma Loja Filial só pode alterar Duplicatas por ela Gerada!', ['&O k']);
    End;

    strPlanoContasOri := fraPlanoDeContas.dbeCodCta.Text;
  End;
end;

procedure TfrmCadCtaReceber.btnEstornoCtrClick(Sender: TObject);
  Var
    frmEstornoReceber : TfrmEstornoReceber;
begin
  inherited;
  If (btnEstornoCtr.Visible) And (btnEstornoCtr.Enabled) And
     (Not qryTabela.IsEmpty) Then
  Begin
    Try
      pCriarFormularios(TfrmEstornoReceber, frmEstornoReceber);
      frmEstornoReceber.blnResCai := False;

      If (qryTabela.FieldByName('CTR_ESPDOC').AsString = 'GA') Then
        frmEstornoReceber.edtEspDoc.Text := 'CC'
      Else
        frmEstornoReceber.edtEspDoc.Text := qryTabela.FieldByName('CTR_ESPDOC').AsString;

      frmEstornoReceber.edtNumDup.Text := qryTabela.FieldByName('CTR_NUMDUP').AsString;
      frmEstornoReceber.edtParcel.Text := qryTabela.FieldByName('CTR_PARCEL').AsString;
      frmEstornoReceber.edtCodCli.Text := qryTabela.FieldByName('CTR_CODCLI').AsString;
      frmEstornoReceber.edtNomCli.Text := fRetNomCliente(qryTabela.FieldByName('CTR_CODCLI').AsString);
      frmEstornoReceber.edtCodEmp.Text := qryTabela.FieldByName('CTR_CODEMP').AsString;
      frmEstornoReceber.edtNomEmp.Text := fRetNomeEmpresaSelec(qryTabela.FieldByName('CTR_CODEMP').AsString);
      frmEstornoReceber.ShowModal;

      strDuplicataParcial := qryTabela.FieldByName('CTR_NUMDUP').AsString;
      strParcelaParcial   := qryTabela.FieldByName('CTR_PARCEL').AsString;
      strEmpresaParcial   := qryTabela.FieldByName('CTR_CODEMP').AsString;
      strClienteParcial   := qryTabela.FieldByName('CTR_CODCLI').AsString;
      strEspecieParcial   := qryTabela.FieldByName('CTR_ESPDOC').AsString;

      qryTabela.Refresh;
      pCarregaDadosAdicionais;

      If qryTabela.IsEmpty Then
      begin
        pLimparCampos;
        pDestravarRegistros;
        strDuplicataParcial := '';
        strParcelaParcial   := '';
        strEmpresaParcial   := '';
        strClienteParcial   := '';
        strEspecieParcial   := '';
      end;
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TfrmCadCtaReceber.btnEstornoCtrClick]');
    End;
    pFreeAndNil(frmEstornoReceber);
  End;
end;

procedure TfrmCadCtaReceber.btnExcluirClick(Sender: TObject);
  Var
    blnPodeExcluir : Boolean;
    strSenha       : String;
    objMetCli      : TMetCli;
    strNumeroPedido: String;
    blnAtuBolAdt   : Boolean;
    LMensagem: String;
    LDuplicataBoleto: TDuplicataCtr;
begin
  strSenha := '';
  blnPodeExcluir := True;
  blnAtuBolAdt := False;

  blnExcluiu := False;
  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If ( TAdiantamentoGenerico.fRetornaValorBoletosAdiantamento(
                        qryTabela.FieldByName('CTR_NUMDUP').AsString,
                        qryTabela.FieldByName('CTR_ESPDOC').AsString,
                        qryTabela.FieldByName('CTR_CODEMP').AsString,
                        qryTabela.FieldByName('CTR_CODCLI').AsString) > 0 ) Then
  Begin
    if not fValidaExclusaoBoletoAdiantamento(dbeNumDup.Text, dbeEspDoc.Text, dbeCodEmp.Text, dbeCodCli.Text) then
      Exit;

    if not fVerLiberacaoExclusaoDupBolAdt then
      Exit;

    blnAtuBolAdt := True;
  End;

  If (Not qryTabela.FieldByName('CTR_TX_PIX').AsString.IsEmpty) Or
     (Not qryTabela.FieldByName('CTR_SEQMPX').AsString.IsEmpty) Then
  Begin
    LMensagem := 'Duplicata com Pix gerado não pode ser excluída!';
    If (qryTabela.FieldByName('CTR_DTAREC').AsString.IsEmpty) Or
       (Not qryTabela.FieldByName('CTR_SEQMPX').AsString.IsEmpty) Then
      LMensagem := LMensagem + #13#10 + 'Caso deseje excluir a duplicata, remova o Pix gerado.';

    fMensagem('ATENÇÃO!', LMensagem, ['&OK']);
    Exit;
  End;

  {****************************************************}
  {* CASO SEQBAI = 0, VERIFICA SE HA DUPS DEPENDENTES *}
  {* CASO EXISTA BLOQUEIA A DELECAO                   *}
  {*************************************************JB*}
  If (qryTabela.FieldByName('CTR_SEQBAI').AsInteger = 0)                      And
     (fCtrExisteDupDependentes(qryTabela.FieldByName('CTR_NUMDUP').AsString,
                               qryTabela.FieldByName('CTR_PARCEL').AsString,
                               qryTabela.FieldByName('CTR_ESPDOC').AsString,
                               qryTabela.FieldByName('CTR_CODEMP').AsString,
                               qryTabela.FieldByName('CTR_CODCLI').AsString)) Then
  Begin
    fMensagem('','A duplicata não pode ser excluída, pois existem duplicatas dependentes.' +
                 ' Por favor estorne as duplicatas dependentes!',['&OK']);
    Exit;
  End;

  If fDuplicataDeChequeTransferido(qryTabela.FieldByName('CTR_ESPDOC').AsString,
                        qryTabela.FieldByName('CTR_NUMDUP').AsString+'-'+
                        qryTabela.FieldByName('CTR_PARCEL').AsString+'-'+
                        qryTabela.FieldByName('CTR_SEQBAI').AsString+'-'+
                        qryTabela.FieldByName('CTR_ESPDOC').AsString+'-'+
                        qryTabela.FieldByName('CTR_CODEMP').AsString+'-'+
                        qryTabela.FieldByName('CTR_CODCLI').AsString) Then
  Begin
    fMensagem('','Duplicata originada do Cadastro de Cheque (CHEQUE: '+chqCadRec+'), não poderá ser excluida! ' + #13#10 +
                 'Utilizar a rotina de Cancelamento de Transferencia de Cheque',
                 ['&OK']);
    Exit;
  End;

  {***************************************************}
  {* VERIFICA SE É UM CRÉDITO DE CLIENTE GERADO PELO *}
  {* ADIANTAMENTO DE CLIENTE                         *}
  {************************************************AJ*}
  If (qryTabela.FieldByName('CTR_ESPDOC').AsString = 'CC') Then
  Begin
     If (fCreditoGeradoPeloAdiantamento(qryTabela.FieldByName('CTR_NUMDUP').AsString,
                                        qryTabela.FieldByName('CTR_PARCEL').AsString,
                                        qryTabela.FieldByName('CTR_CODEMP').AsString,
                                        qryTabela.FieldByName('CTR_CODCLI').AsString,
                                        strNumeroPedido)) Then
      Begin
        fMensagem('ATENÇÃO', 'Esse crédito não pode ser excluído pois foi gerado pela rotina de Adiantamento de Cliente.' + #13 +
                             'Para excluí-lo, é necessário acessar a Consulta de Adiantamentos (pelo Resumo de Caixa ou pela ' +
                             'Baixa de Contas a Receber) e realizar o estorno do crédito gerado pelo Adiantamento do Pedido ' + strNumeroPedido,
                             ['&OK'], 1);
        Exit;
      End;

      If untCadRec.ExisteCartaoOuChequeVinculadoDoResumoDeCaixa(qryTabela.FieldByName('CTR_NUMDUP').AsString,
                                                                qryTabela.FieldByName('CTR_PARCEL').AsString,
                                                                qryTabela.FieldByName('CTR_ESPDOC').AsString,
                                                                qryTabela.FieldByName('CTR_CODEMP').AsString,
                                                                qryTabela.FieldByName('CTR_CODCLI').AsString) Then
      Begin
        fMensagem('ATENÇÃO', 'Esse crédito não pode ser excluído pois foi gerado pelo ' +
                             'Resumo de Caixa e possui cartão e/ou cheque vinculado.', ['&OK'], 1);

      Exit;
    End;

    pAdicionarDuplicataNoArray;
    strMovBan := fCreditoDiretoComMovBan(arrDupSel);
    if Not fEmptyStr(strMovBan) And EstaConciliado(strMovBan, 'CADREC') then
    begin
      fMensagem('', 'Não é possível exluir esse título, pois o mesmo está conciliado. ' +
                    'Para ser possível exclui-lo, o mesmo deve ser desconciliado. Acessar PRINCIPAL > CONTROLE FINANCEIRO > CONCILIAÇÃO BANCÁRIA.', ['&O k']);
      exit;
    end
    Else If Not fEmptyStr(strMovBan) Then
      fMensagem('', 'Crédito direto com movimentação bancária, será lançado um débito no mesmo valor!', ['&O k']);

  End;

  {******************************************************}
  { BUSCA DA EXISTENCIA DE CHEQUE GERADOR DO MOVIMENTO DE
    CONTAS A RECEBER E CASO EXISTA, BLOQUEIA A EXCLUSÃO}


  if fExisteChqGerador(qryTabela.FieldByName('CTR_NUMDUP').AsString+'-'+
                       qryTabela.FieldByName('CTR_ESPDOC').AsString+'-'+
                       qryTabela.FieldByName('CTR_PARCEL').AsString+'-'+
                       qryTabela.FieldByName('CTR_CODEMP').AsString+'-'+
                       qryTabela.FieldByName('CTR_CODCLI').AsString) then
  begin
    fMensagem('','Não é possivel excluir a duplicata pois existe movimento relacionado! CHEQUE: ' + chqCadRec,['&OK']);
    Exit;
  end;

  {******************************************************************}
  {* NÃO É PERMITIDO EXCLUIR UMA DUPLICATA DO TIPO AG - AGRUPAMENTO *}
  {***************************************************************JL*}
  If (qryTabela.FieldByName('CTR_ESPDOC').AsString = 'AG') Then
  Begin
    fMensagem('','Não é permitido excluir duplicata com espécie AG.',['&OK']);
    Exit;
  End;

  {**************************************************}
  {* CASO A DUPLICATA JÁ TENHA SIDO ENVIDA AO BANCO *}
  {***********************************************JU*}

  If Not (qryTabela.FieldByName('CTR_DTAENV').IsNull) Then
  Begin
    fMensagem('','Esta duplicata está com a data de envio para o banco preenchida, faça o cancelamento ' +
                 'no autban e comunique ao banco antes de excluir!', ['&OK']);
    Exit;
  End;

  If DuplicataCCFoiGeradaPorUmaBaixa(LMensagem) Then
  Begin
    fMensagem('ATENÇÃO','Esta duplicata de crédito não pode ser excluída pois ' +
                        'foi gerada por uma baixa.' + #13 +
                        'Para exclui-la, deve ser feito o estorno do(s) documento(s) ' + LMensagem +
                        ' em PRINCIPAL->FINANCEIRO->CONTAS A RECEBER->ESTORNO DE CONTAS A RECEBER!', ['&OK']);
    Exit;
  End;

  //FECHAMENTO FINANCEIRO
  if objFechamento.FechamentoFinanceiroJaRealizado(qryTabela.FieldByName('CTR_CODEMP').AsString, qryTabela.FieldByName('CTR_DTACAD').AsDateTime) then
    Exit;

  If fDocumentoVeioFaturamento(qryTabela.FieldByName('CTR_NUMDUP').AsString,
                               qryTabela.FieldByName('CTR_ESPDOC').AsString,
                               qryTabela.FieldByName('CTR_CODEMP').AsString,
                               qryTabela.FieldByName('CTR_CODCLI').AsString,
                               qryTabela.FieldByName('CTR_PARCEL').AsString) Then
  Begin
    fMensagem('','Esta duplicata é proveniente de um documento de venda, faça a exclusão ' +
                 'pelo módulo de cancelamento de documentos em: PRINCIPAL->CANCELAMENTO DE DOCUMENTOS!', ['&OK']);
    Exit;
  End;

  If qryTabela.FieldByName('CTR_ESPDOC').AsString = 'RL' Then
  Begin
    If (fDocumentoRLComParcelamento(qryTabela.FieldByName('CTR_NUMDUP').AsString,
                                    qryTabela.FieldByName('CTR_ESPDOC').AsString,
                                    qryTabela.FieldByName('CTR_CODEMP').AsString,
                                    qryTabela.FieldByName('CTR_CODCLI').AsString)) Then
    Begin
      fMensagem('Atenção','Esta duplicata é proveniente de um documento de locação de equipamento com parcelamento. Sendo assim não é possível excluir uma única parcela. ' +
                          'Efetue a exclusão pela tela de cancelamento de faturamento: PRINCIPAL->LOCAÇÃO DE EQUIPAMENTOS->CANCELAMENTO DE LOCAÇÃO!', ['&OK']);
      Exit;
    End;

    If (fDocumentoRLComAdiantamentoBaixado(qryTabela.FieldByName('CTR_NUMDUP').AsString,
                                           qryTabela.FieldByName('CTR_ESPDOC').AsString,
                                           qryTabela.FieldByName('CTR_CODEMP').AsString,
                                           qryTabela.FieldByName('CTR_CODCLI').AsString)) Then
    Begin
      fMensagem('Atenção','Esta duplicata é proveniente de um documento de locação de equipamento e possui valor de adiantamento baixado. ' +
                          'Efetue a exclusão pela tela de cancelamento de faturamento: PRINCIPAL->LOCAÇÃO DE EQUIPAMENTOS->CANCELAMENTO DE LOCAÇÃO!', ['&OK']);
      Exit;
    End;
  End;

  objMetCli := TMetCli.Create(Nil);

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
  If blnPodeExcluir Then
  Try

    If ffrmSenha(strSenha) Then
    Begin
      If strSenha = fCfgSis('SEXCTR') Then
      Begin

        blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

        {*********************************}
        {* GRAVAR TABELA DO SISTEMA DEPS *}
        {******************************AJ*}
        If fCfgSis('USADEP') = 'S' Then
          TValidacoesSistemaDEPS.pGravaLancamentoSistemaDEPS(Concat(qryTabela.FieldByName('CTR_NUMDUP').AsString, '-',
                                                                    qryTabela.FieldByName('CTR_PARCEL').AsString, '-',
                                                                    qryTabela.FieldByName('CTR_ESPDOC').AsString, '-',
                                                                    qryTabela.FieldByName('CTR_CODEMP').AsString, '-',
                                                                    qryTabela.FieldByName('CTR_CODCLI').AsString, '-',
                                                                    qryTabela.FieldByName('CTR_SEQBAI').AsString),
                                                             'EXCLUSÃO');

        If fCfgSis('BADAUT', VarBoolean) Then
          blnExcluiu := fExcluiValAdtPeloSeqCtr(qryTabela.FieldByName('AUTOINCREM').AsString)
        Else
          blnExcluiu := True;

        If blnExcluiu Then
          inherited;

        If (blnExcluiu) Then
        Begin
          If Not fEmptyStr(strMovBan) Then
            fGravaDebitoCliente;

          If FEspecieDocumento = 'MC' Then
          Begin
            objMetCli.pCarregaMetCli(FCodigoCliente, True);
            objMetCli.fAtualizaMetCli(FNumeroControle);
          End;

          If VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString)))  Then
          Begin
            TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(strNumDupDC,
                                                     strEspDocDC,
                                                     strCodEmpDC,
                                                     strCodCliDC,
                                                     strParcelDC,
                                                     strLoginUsuarioLogado,
                                                     fRetCgcCpf(strCodCliDC),
                                                     afcExcluiDuplicata, True);
          End;

          If FEspecieDocumento = 'DC' Then
          Begin
            pDesvinculaDespesaCobrancaDaDuplicataOrigem(strNumDupDC,
                                                        strParcelDC,
                                                        strEspDocDC,
                                                        strCodCliDC,
                                                        strCodEmpDC);
          End
          Else If FEspecieDocumento = 'RL' Then
          Begin
            pDesvinculaContratoLocacao(strNumDupDC,
                                       strEspDocDC,
                                       strCodCliDC,
                                       strCodEmpDC,
                                       fltValDupAnt);
          End;

          if blnAtuBolAdt then
          begin
            blnExcluiu := fExcluiTodasParcelasAdiantamento(strNumDupDC, strEspDocDC, strCodEmpDC, strCodCliDC);

            if blnExcluiu then
              pAtualizaDuplicataBolAdt(strNumDupDC, strEspDocDC, strCodEmpDC, strCodCliDC);
          end;

          If FSeqBaiDC = 0 Then
          Begin
            LDuplicataBoleto.strNumDup := strNumDupDC;
            LDuplicataBoleto.strParcel := strParcelDC;
            LDuplicataBoleto.strEspDoc := strEspDocDC;
            LDuplicataBoleto.strCodEmp := strCodEmpDC;
            LDuplicataBoleto.strCodCli := strCodCliDC;
            DeletarCarteiraBoleto(LDuplicataBoleto);
          End;

          fLock_Unlock(FChaveLck, False);
          blnDupTravada := False;
        End;

        If blnExcluiu Then
          fCommit
        Else
          fRollBack;

        pCarregaDadosAdicionais;
        pCalculaValorTotal();
        blnExcluiu := False;

      End
      Else
        fMensagem('','Senha incorreta!',['&OK']);
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
			pMensagensErro(E.Message,'[TfrmCadCtaReceber.btnExcluirClick]');
    End;
  End
  Else
  Begin
    fMensagem('ATENÇÃO!', 'Uma Loja Filial só pode Excluir Duplicatas por ela Gerada!', ['&O k']);
  End;

  FreeAndNil(objMetCli);
end;

procedure TfrmCadCtaReceber.pCarregaDadosAdicionais;
  Var
    blnBaixada: Boolean;
    blnRemessa: Boolean;
begin
  fltValOriAnt := qryTabela.FieldByName('CTR_VALORI').AsFloat;
  fltValDupAnt := qryTabela.FieldByName('CTR_VALDUP').AsFloat;

  edtValorTarifa.Clear;
  edtForTar.Clear;
  edtPorTar.Clear;
  edtCtaTar.Clear;

  pCarregaBanco;
  pCarregaEmpresa;
  pCarregaCliente;
  pCarregaPortador;
  CarregaCodigoProjeto;
  pCarregaVendedor;
  pCarregaDadosBaixa;
  pCarregaEventos;
  pCarregaCentroCusto;
  pAdiantamentoCliente;
  blnBaixada := fDuplicataCtrBaixada(dbeNumDup.Text,
                                     dbeParcel.Text,
                                     dbeEspDoc.Text,
                                     dbeCodEmp.Text,
                                     dbeCodCli.Text,
                                     qryTabela.FieldByName('CTR_SEQBAI').AsInteger);

  blnRemessa := (Not fEmptyStr(fTiraCaracEspeciais(dbeDtaEnv.Text))) Or
                (Not fEmptyStr(dbeBcoBol.Text));

  blnDupBaixada := blnBaixada;
  blnEnviada    := blnRemessa;

  btnEstornoCtr.Enabled := False;

  If qryTabela.State = dsBrowse Then
  Begin
    btnEstornoCtr.Enabled := (Not qryTabela.IsEmpty) And (blnBaixada) And (fVerificaAcessoSistema('frmEstornoCtaReceber'));

    TituloEnviadaAoBanco;

    If (blnBaixada) Or (Not qryTabela.FieldByName('CTR_OBSAG1').IsNull) Then
    Begin
      btnExcluir.Enabled := False;

      If (btnAlterar.Tag = 88) Then
      {$IFDEF AUTDUP}
      Begin
        edtDtaRec.Visible  := False;
        dbeDtaRec.Visible  := True;
        btnAlterar.Enabled := True;
      End
      {$ELSE}
        btnAlterar.Enabled := False
      {$ENDIF}
      Else
        btnAlterar.Enabled := True;
    End
    Else
    Begin
      If btnExcluir.Tag <> 88 Then
        btnExcluir.Enabled := True;

      If btnAlterar.Tag <> 88 Then
        btnAlterar.Enabled := True;
    End;

  End
  Else If (qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit) Then
  Begin
    btnGravar.Enabled := Not blnBaixada;
  End;

  dbeSeqBai.Visible := False;
  lblSeqBai.Visible := False;
  If Not qryTabela.IsEmpty Then
  Begin
    If Not qryTabela.FieldByName('CTR_DTABAI').IsNull Then
    Begin
      dbeSeqBai.Visible := True;
      lblSeqBai.Visible := True;
    End;
  End;

  btnNossNumCompleto.Visible := Not fEmptyStr(RetornaNossoNumeroCompleto);
end;

procedure TfrmCadCtaReceber.pCarregaEmpresa;
begin
  pPesquisaCadEmp(qryConEmp, qryConEmp, dbeCodEmp.Text);
  With qryConEmp Do
  Begin
    edtNomEmp.Text := FieldByName('EMP_NOMEMP').AsString;
  End;
end;

procedure TfrmCadCtaReceber.pCarregaCliente;
begin
  pPesquisaCadCli(qryConCli, qryConCli, dbeCodCli.Text);
  With qryConCli Do
  Begin
    edtNomCli.Text := FieldByName('CLI_NOMCLI').AsString;
  End;
end;

procedure TfrmCadCtaReceber.pCarregaCreditoCliente;
  Var
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT            ';
  strSQL := strSQL + '   M.CTB_CODPOR AS CODPOR,  ';
  strSQL := strSQL + '   M.CTB_CODCTA AS CODCTA,  ';
  strSQL := strSQL + '   M.CTB_CODEMP AS CODEMP   ';
  strSQL := strSQL + ' FROM              ';
  strSQL := strSQL + '   BANCTR B        ';
  strSQL := strSQL + '    JOIN MOVBAN M ON M.CTB_SEQLAN = B.CTB_SEQLAN ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '   CTB_CREDEB = "C"         ';

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := arrDupSel[0].strNumDoc;
      ParamByName('ESPDOC').AsString := arrDupSel[0].strEspDoc;
      ParamByName('CODEMP').AsString := arrDupSel[0].strCodEmp;
      ParamByName('PARCEL').AsString := arrDupSel[0].strParcel;
      ParamByName('CODCLI').AsString := arrDupSel[0].strCodCli;
      Open;

    End;
  Except
      On E: Exception Do
      begin
        Raise Exception.Create(E.Message);
      end;
  End;
End;

procedure TfrmCadCtaReceber.pCarregaPortador;
begin
  pPesquisaCadPor(Nil, qryConPor, dbeCodPor.Text);
  With qryConPor Do
  Begin
    edtNomPor.Text := FieldByName('POR_NOMPOR').AsString;
    if Assigned(qrytabela) And Assigned(qryConPor) And (Not qryConPor.isEmpty) then
      btnImpBol.Enabled := (qryTabela.State in [dsBrowse]) And (qryConPor.FieldByName('POR_IMPBOL').AsString = 'S');
  End;
end;

procedure TfrmCadCtaReceber.pCarregaVendedor;
begin
  pPesquisaCadOpe(qryConOpe, qryConOpe, dbeCodVen.Text);
  With qryConOpe Do
  Begin
    edtNomVen.Text := FieldByName('OPE_NOMOPE').AsString;
  End;
end;

procedure TfrmCadCtaReceber.pDestravarRegistros;
begin
  inherited;
  If Not qryTabela.IsEmpty Then
  Begin
    fLock_Unlock(strNomeTabela +
                 qryTabela.FieldByName('CTR_NUMDUP').AsString +
                 qryTabela.FieldByName('CTR_ESPDOC').AsString +
                 qryTabela.FieldByName('CTR_CODEMP').AsString +
                 qryTabela.FieldByName('CTR_CODCLI').AsString +
                 qryTabela.FieldByName('CTR_PARCEL').AsString,
                 False);
    blnDupTravada := False;
  End
  Else
  {*******************************************************}
  {* QRYTABLEA SERÁ ISEMPTY QUANDO ESTORNADO UMA PARCIAL *}
  {*******************************************************}
  if((not fEmptyStr(strDuplicataParcial)) and
     (not fEmptyStr(strParcelaParcial)) and
     (not fEmptyStr(strEmpresaParcial)) and
     (not fEmptyStr(strClienteParcial)) and
     (not fEmptyStr(strEspecieParcial))) then
  begin
    fLock_Unlock(strNomeTabela +
                 strDuplicataParcial +
                 strEspecieParcial +
                 strEmpresaParcial +
                 strClienteParcial +
                 strParcelaParcial,
                 False);
    blnDupTravada := False;
  end;
end;

function TfrmCadCtaReceber.fGerarCreditoCliente(blnInserindo : Boolean): Boolean;
  Var
    strMsg : String;
    recModalidades : TArrModalidade;
    concilBancaria : Boolean;

    LRealizaPergunta: Boolean;
begin
  concilBancaria:=False;
  if (strEspecieLoc  <> '') Then
  Begin
    If (strEspecieLoc  = dbeEspDoc.Text) then
      concilBancaria:=True;
  End;

  Result := True;
  If Not blnInserindo Then
    Exit;

  If (dbeEspDoc.Text = 'CC') And (fStrToFloat(dbeValDup.Text) < 0) Then
  Begin
    FillChar(recModalidades, SizeOf(recModalidades), #0);
    strMsg := 'A inclusão de um lançamento de crédito para o cliente, deve gerar o lançamento automático na movimentação bancária ' +
              'para conciliação dos valores recebidos.'+ #13#10 +
              'Confirma a geração do movimento bancário?';
    Try
      blnGerarCreditoDireto := True;
      if concilBancaria Then
        Exit;

      LRealizaPergunta := fCfgSis('MOV_CC', varString) = '1';

      If LRealizaPergunta Then
      Begin
        If fMensagem('ATENÇÃO!', strMsg, ['&Sim', '&Não'],1) <> 1 Then
        Begin
          blnGerarCreditoDireto := False;
          pAdicionarDuplicataNoArray;

          If fTravarCreditoDireto(dbeCodCli.Text,
                                  fStrToFloat(dbeValDup.Text),
                                  strLoginUsuarioLogado,
                                  False,
                                  recModalidades,
                                  True,
                                  arrDupSel) Then
            Result := False;
        End;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '');
        Result := False;
      End;
    End;
  End;
end;

procedure TfrmCadCtaReceber.pUtilizaRotinaProjeto;
begin
  pnlProjeto.Visible := fCfgSis('UTLPRJ', varBoolean);
end;

function TfrmCadCtaReceber.RetornaNossoNumeroCompleto: String;
  Var
    LConvenio : String;
    LCarteiraSemEmpresa : String;
    LEmpresaCarteira: String;
    LCarteira : String;
begin
  Result := '';
  If MatchStr(dbeBancoBoleto.Text,['001']) Then
  Begin
    LCarteira := qryTabela.FieldByName('CTR_CARTEI').AsString;

    If (Pos('CONFIG001D7',LCarteira) > 0) Then
    Begin
      LEmpresaCarteira    := RightStr(LCarteira, 3);
      LCarteiraSemEmpresa := LCarteira.Replace('-' + LEmpresaCarteira,'');
      LConvenio           := fGetBancoConfig(0,LCarteiraSemEmpresa, 'CODCONV','',LEmpresaCarteira);

      Result := Concat(LConvenio,dbeNosNum.Text);
      Result := Result + DigitoVerificadorNossoNumero(Result);
    End;
  End;
end;

procedure TfrmCadCtaReceber.pCarregaProjeto;
begin
  edtDesPrj.Text := '';

  If fEmptyStr(edtCodPrj.Text) Then
    Exit;

  If Not Assigned(qryTabela) Then
    Exit;

  If qryTabela.IsEmpty Then
    Exit;

  pPesquisaCadPrj(Nil, qryConPrj, edtCodPrj.Text);
  edtDesPrj.Text := qryConPrj.FieldByName('PRJ_DESPRJ').AsString;
end;

function TfrmCadCtaReceber.fGetHistoricoLancamentoCredito: String;
begin
  Result := 'REF. LANC. CREDITO';
  If Not fEmptyStr(qryTabela.FieldByName('CTR_HIST01').AsString) Then
  Begin
    Result := AnsiReplaceStr(qryTabela.FieldByName('CTR_HIST01').AsString, '<<csq>>', ' ');
  End;
end;

procedure TfrmCadCtaReceber.btnIncluirClick(Sender: TObject);
begin
  pDestravarRegistros;
  inherited;
  lblTitEnv.Caption := '';
  btnBaixarDup.Enabled := False;
  btnDocBaixa.Enabled  := False;
  btnImprimir.Enabled  := False;
  btnHistReceb.Enabled := False;
  dbeValDup.Enabled    := True;
  dbeValDup.TabStop    := True;
  btnReenviarRelAgrup.enabled := false;
  pIniciaValoresPadrao;
  pCarregaDadosAdicionais;
  pCalculaValorTotal();
  pHabilitaCodigo(dbeNumDup, dbeNumDup, True);

  pHabilitaDesabiltabtnAbrirPastaAnexos;
  FValidaCorrespondenteContabil.LimparListas;
end;

procedure TfrmCadCtaReceber.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrSel: TConsultasArray;
    objfrmPnl: TPanelCxCadReceber;
    strChvLoc: String;
begin
  chrKey := '/';

  objfrmPnl := TPanelCxCadReceber.Create(TfrmPnlPesqCadRec);

  strChvLoc := strNomeTabela +
               qryTabela.FieldByName('CTR_NUMDUP').AsString +
               qryTabela.FieldByName('CTR_ESPDOC').AsString +
               qryTabela.FieldByName('CTR_CODEMP').AsString +
               qryTabela.FieldByName('CTR_CODCLI').AsString +
               qryTabela.FieldByName('CTR_PARCEL').AsString;

  If fPesqCtaReceber(Self,
                     qryTabela,
                     chrKey,
                     arrSel,
                     objfrmPnl) Then
  Begin
    fLock_Unlock(strChvLoc, False);
    blnDupTravada := False;
    strPlanoContasOri := '';
    if not fCarregaDuplicata then
      Exit;
    FValidaCorrespondenteContabil.LimparListas;
    FValidaCorrespondenteContabil.AddPortadorValidado(dbeCodPor.Text);
    FValidaCorrespondenteContabil.AddPlanoDeContasValidado(fraPlanoDeContas.dbeCodCta.Text);
  End;

  If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
  Begin
    btnImprimir.Enabled := True;
    pHabilitaDesabiltabtnAbrirPastaAnexos;
    pSetFocus(btnAlterar);
  End;

  TituloEnviadaAoBanco;
end;

procedure TfrmCadCtaReceber.btnReenviarRelAgrupClick(Sender: TObject);
Begin
  TfrmGravando.fExecutarModalA(pGeraRelatorioAgrupamento, 'Aguarde, Gerando Relatório de Agrupamento...', '');
end;

procedure TfrmCadCtaReceber.CarregaCodigoProjeto;
begin
  edtCodPrj.Text := qryTabela.FieldByName('CTR_CODPRJ').AsString;

  If fEmptyStr(edtCodPrj.Text) Then
    edtCodPrj.Text := fRetornaCodigoProjeto(qryTabela.FieldByName('CTR_NUMDUP').AsString,
                                            qryTabela.FieldByName('CTR_ESPDOC').AsString,
                                            qryTabela.FieldByName('CTR_CODEMP').AsString,
                                            qryTabela.FieldByName('CTR_CODCLI').AsString);

  pCarregaProjeto;
end;

function TfrmCadCtaReceber.fSqlAgrupamento(strCodCli,strNumDup : string): string;
var
  strSql:     string;
begin
  strSql := 'SELECT  CONCAT(CTR_NUMAGR, "-AG_", CLI_CODCLI ) AS NOMEARQ, ';
  strSql := strSql + 'CLI_EMCOB1, CLI_EMCOB2, CLI_EMAIL_, CLI_EMAIL2, CLI_EMAIL3 ';
  strSql := strSql + 'FROM DUPAGR ';
  strSql := strSql + 'INNER JOIN CADCLI C ON CTR_CODCLI = CLI_CODCLI ';
  strSql := strSql + 'WHERE CLI_CODCLI = '+QuotedStr(strCodCli)+
                     '  AND CTR_NUMAGR = '+QuotedStr(strNumDup);
  result := strSql;
end;

procedure TfrmCadCtaReceber.pGeraRelatorioAgrupamento();
var
  qryAgrupamento:   TUniQuery;
  strMSBOEM:        string;
  strArquivo:       string;
  strEmailCli:      string;
  strNumDup:        string;
  arrDestinatarios: TStringArray;
  arrArquivos:      TStringArray;
begin
  inherited;
  qryAgrupamento := fCriaQuery(self);
  strNumDup := qryTabela.FieldByName('CTR_NUMDUP').AsString;
  qryAgrupamento.Close;
  qryAgrupamento.SQL.Clear;
  qryAgrupamento.SQL.Add(fSqlAgrupamento(qryTabela.FieldByName('CTR_CODCLI').AsString, qryTabela.FieldByName('CTR_NUMDUP').AsString));
  qryAgrupamento.Open;
  pSetaClient(qryAgrupamento);

  if qryAgrupamento.recordcount > 0 then
  begin
    //DESTINATÁRIO
    If (fCfgSis('GPEMCB', VarBoolean)) Then
    Begin
      strEmailCli := '';

      If Not fEmptyStr(qryAgrupamento.FieldByName('CLI_EMCOB1').AsString) Then
        strEmailCli := qryAgrupamento.FieldByName('CLI_EMCOB1').AsString;

      If Not fEmptyStr(qryAgrupamento.FieldByName('CLI_EMCOB2').AsString) Then
      Begin
        If fEmptyStr(strEmailCli) Then
          strEmailCli := qryAgrupamento.FieldByName('CLI_EMCOB2').AsString
        Else
          strEmailCli := strEmailCli + '; ' + qryAgrupamento.FieldByName('CLI_EMCOB2').AsString;
      End;

      If fEmptyStr(strEmailCli) Then
      Begin
        If Not fEmptyStr(qryAgrupamento.FieldByName('CLI_EMAIL_').AsString) Then
          strEmailCli := qryAgrupamento.FieldByName('CLI_EMAIL_').AsString
        Else If Not fEmptyStr(qryAgrupamento.FieldByName('CLI_EMAIL2').AsString) Then
          strEmailCli := qryAgrupamento.FieldByName('CLI_EMAIL2').AsString;
      End;
    End
    Else
    Begin
      If Not fEmptyStr(qryAgrupamento.FieldByName('CLI_EMCOB1').AsString) Then
        strEmailCli := qryAgrupamento.FieldByName('CLI_EMCOB1').AsString
      Else If Not fEmptyStr(qryAgrupamento.FieldByName('CLI_EMCOB2').AsString) Then
        strEmailCli := qryAgrupamento.FieldByName('CLI_EMCOB2').AsString
      Else If Not fEmptyStr(qryAgrupamento.FieldByName('CLI_EMAIL_').AsString) Then
        strEmailCli := qryAgrupamento.FieldByName('CLI_EMAIL_').AsString
      Else If Not fEmptyStr(qryAgrupamento.FieldByName('CLI_EMAIL2').AsString) Then
        strEmailCli := qryAgrupamento.FieldByName('CLI_EMAIL2').AsString
      Else
        strEmailCli := '';
    End;

    If (Not fEmptyStr(qryAgrupamento.FieldByName('CLI_EMAIL3').AsString)) Then Begin
      If (Not fEmptyStr(strEmailCli)) Then
        strEmailCli := strEmailCli + '; ' + qryAgrupamento.FieldByName('CLI_EMAIL3').AsString
      Else
        strEmailCli := qryAgrupamento.FieldByName('CLI_EMAIL3').AsString;
    End;

    strEmailCli := AnsiReplaceStr(strEmailCli, ';;', ';');

      //BUSCA ARQUIVO NO DIRETÓRIO
    if not FileExists(ExtractFilePath(Application.ExeName) + 'AgrupDuplicatas\'+qryAgrupamento.fieldbyname('NOMEARQ').asstring+'.pdf') then
    begin
      Try
        pCriarFormularios(TfrmCtrAgrupDupRecibo, frmCtrAgrupDupRecibo);
        frmCtrAgrupDupRecibo.pImprimeComprovante(strNumDup, Self.Name, 1, true);
        strArquivo := ExtractFilePath(Application.ExeName) + 'AgrupDuplicatas\'+qryAgrupamento.fieldbyname('NOMEARQ').asstring+'.pdf';
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[Erro ao salvar comprovante agrupamento contas a receber]');
      End;
    end
    else
      strArquivo := ExtractFilePath(Application.ExeName) + 'AgrupDuplicatas\'+qryAgrupamento.fieldbyname('NOMEARQ').asstring+'.pdf';
    if FileExists(strArquivo) then
    begin
      strMSBOEM := fCfgSis('MSBOEM', varString);
      pCriarArrayAnexosEDestinatarios(strArquivo, strEmailCli, arrDestinatarios, arrArquivos);
      TEnvioEmail.EnviarEmail(Self, strLoginUsuarioLogado, 'Agrupamentos', arrDestinatarios, [], [], ['Segue duplicatas em anexo.', strMSBOEM], arrArquivos, False);
    end;
  end;
end;

procedure TfrmCadCtaReceber.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(btnIncluir);
end;

procedure TfrmCadCtaReceber.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  pDestravarRegistros;
  If Action <> caNone Then
  begin
    FreeAndNil(qryCadBco);
    FreeAndNil(objLiberacao);
    If Assigned(qryGen)Then
      FreeAndNil(qryGen);

    If Assigned(objProrrogacao) Then
      FreeAndNil(objProrrogacao);

    If Assigned(FValidaCorrespondenteContabil) Then
      FreeAndNil(FValidaCorrespondenteContabil);
  end;
end;

procedure TfrmCadCtaReceber.FormCreate(Sender: TObject);
begin
  inherited;

  strAutoincrem := '';
  qryCadBco := fCriaQuery(Self);
  qryConPor := fCriaQuery(Self);
  qryConPrj := fCriaQuery(Self);

  objLiberacao := TLiberacao.Create;

  strNomeCampo  := 'CTR_NUMDUP';
  lblTitEnv.Caption := '';
  strNomeTabela     := 'CADREC';

  pInicializarTabela('SELECT * FROM CADREC WHERE FALSE');

  SetLength(arrCamposChave, 5);
  arrCamposChave[0] := dbeNumDup;
  arrCamposChave[1] := dbeParcel;
  arrCamposChave[2] := dbeEspDoc;
  arrCamposChave[3] := dbeCodEmp;
  arrCamposChave[4] := dbeCodCli;

  dbeDesSuj.ReadOnly := not fVerificaAcessoSistema('ALTDES');
  dbeJurSuj.ReadOnly := not fVerificaAcessoSistema('ALTJUR');
  FblnExcluirFF := fCfgSis('TRAFFE', varBoolean);

  dbeJurSuj.TabStop  := not dbeJurSuj.ReadOnly;
  dbeJurSuj.Enabled  := dbeJurSuj.TabStop;

  dbeDesSuj.TabStop  := not dbeDesSuj.ReadOnly;
  dbeDesSuj.Enabled  := dbeDesSuj.TabStop;

  SetLength(arrLogLib, 0);
  blnIniciaCadastro   := False;

  FillChar(recUltDupBaixada, SizeOf(recUltDupBaixada), #0);
  objFechamento := TFechamentoFinanceiro.Create(Self, Self.Name);

  If fCfgSis('CTRPRO', varBoolean) Then
    objProrrogacao := TProrrogacaoDeTitulos.Create(ttAltVen);

  FValidaCorrespondenteContabil :=  TValidaCorrespondenteContabil.Create;
end;

procedure TfrmCadCtaReceber.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_F8 : btnCopiaLinhaDigitada.Click;
    VK_F9 : btnBoleto.Click;
    VK_F6 : IF btnConsultarAdiantamentos.Visible Then btnConsultarAdiantamentos.Click;
  end;
end;

procedure TfrmCadCtaReceber.pqryCadRecCTR_DTAENVSetText(Sender: TField; const Text: String);
begin
  If fEmptyDate(Text) Then
    TField(Sender).Clear
  Else
    TField(Sender).AsDateTime := StrToDate(Text);
end;

procedure TfrmCadCtaReceber.setChqCadRec(chave:String);
begin
  chqCadRec := chave;
end;

procedure TfrmCadCtaReceber.ShowHint(AButton: TSpeedButton; ATitulo,
  AHint: String);
begin
  HintControler.ShowHint(AButton.ClientOrigin.X,AButton.ClientOrigin.Y, ATitulo, AHint);
end;

procedure TfrmCadCtaReceber.spbAmpliarClick(Sender: TObject);
begin

  inherited;

  If not qryTabela.Active Then
    exit;

  If fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString) then
    exit;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(219, 7731, [],
                        ['AUTINC'],
                        [qryTabela.FieldByName('AUTOINCREM').AsString],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmCadCtaReceber.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pCarregaDadosAdicionais;
  pCalculaValorTotal();
  btnBaixarDup.Enabled := True;
  btnDocBaixa.Enabled  := True;
  btnImprimir.Enabled  := True;
  btnHistReceb.Enabled := True;
  btnReenviarRelAgrup.enabled := qryTabela.FieldByName('CTR_ESPDOC').asstring = 'AG';
  pHabilitaDesabiltabtnAbrirPastaAnexos;
  SetLength(arrLogLib, 0);
  pCarregaProjeto;
end;

procedure TfrmCadCtaReceber.btnCopiaLinhaDigitadaClick(Sender: TObject);
begin
  inherited;
  dbeLinhaDigitavel.SelectAll;
  dbeLinhaDigitavel.CopyToClipboard;
  fMensagem('Atenção','Linha digitável copiada! Cole através do CTRL + V',['&OK']);
end;

procedure TfrmCadCtaReceber.pCarregaDadosBaixa;
  Var
    strSQL    : String;
    blnBaixada: Boolean;
    qryGenPor : TUniQuery;
begin
  qryGenPor := fCriaQuery(Self);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CONCAT(R.CTR_PORBAI, " - ", P.POR_NOMPOR) AS PORBAI, ';
  strSQL := strSQL + '  CONCAT(R.CTR_OPEBAI, " - ", O.OPE_NOMOPE) AS OPEBAI, ';
  strSQL := strSQL + '  CONCAT(R.CTR_CTABAI, " - ", C.CTA_DESCTA) AS CTR_CTABAI, ';
  strSQL := strSQL + '  R.CTR_VALORI, R.CTR_SEQBAI, R.CTR_DTAREC, ';
  strSQL := strSQL + '  C.CTA_DESCTA, R.CTR_VALREC, R.CTR_DOCBAI, R.CTR_HISBAI, ';
  strSQL := strSQL + '  R.CTR_SEQCON, R.CTR_EMPBAI, R.CTR_VALJUR, R.CTR_VALDES ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREC R ';
  strSQL := strSQL + '  JOIN CADPOR P ON R.CTR_PORBAI = P.POR_CODPOR ';
  strSQL := strSQL + '  JOIN CADCTA C ON R.CTR_CTABAI = C.CTA_CODCTA ';
  strSQL := strSQL + '  JOIN CADOPE O ON R.CTR_OPEBAI = O.OPE_CODOPE ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  R.CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  R.CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '  R.CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  R.CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  R.CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  R.CTR_SEQBAI = :SEQBAI ';

  If qryTabela.State = dsBrowse Then
    qryTabela.Refresh;

  With qryGenPor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDUP').AsString  := dbeNumDup.Text;
    ParamByName('PARCEL').AsString  := dbeParcel.Text;
    ParamByName('ESPDOC').AsString  := dbeEspDoc.Text;
    ParamByName('CODEMP').AsString  := dbeCodEmp.Text;
    ParamByName('CODCLI').AsString  := dbeCodCli.Text;
    ParamByName('SEQBAI').AsInteger := qryTabela.FieldByName('CTR_SEQBAI').AsInteger;
    Open;
  End;

  blnBaixada := fDuplicataCtrBaixada(dbeNumDup.Text,
                                     dbeParcel.Text,
                                     dbeEspDoc.Text,
                                     dbeCodEmp.Text,
                                     dbeCodCli.Text,
                                     qryTabela.FieldByName('CTR_SEQBAI').AsInteger);

  If blnBaixada Then
  Begin
    edtValOri.Text := FloatToStrF(qryGenPor.FieldByName('CTR_VALORI').AsFloat, ffFixed, 12, 2);

    If qryGenPor.FieldByName('CTR_SEQBAI').AsInteger <= 0 Then
      edtTipBai.Text := 'Baixa Total'
    Else
      edtTipBai.Text := 'Baixa Parcial';

    edtDtaRec.Text := qryGenPor.FieldByName('CTR_DTAREC').AsString;

    If (Not qryGenPor.FieldByName('CTR_VALREC').IsNull)   And
       (qryGenPor.FieldByName('CTR_VALREC').AsFloat <> 0) Then
      edtValRec.Text := FloatToStrF(qryGenPor.FieldByName('CTR_VALREC').AsFloat, ffFixed, 12, 2)
    Else
      edtValRec.Clear;

    edtValJur.Text := FloatToStrF(qryGenPor.FieldByName('CTR_VALJUR').AsFloat, ffFixed, 12, 2);
    edtValDes.Text := FloatToStrF(qryGenPor.FieldByName('CTR_VALDES').AsFloat, ffFixed, 12, 2);

    edtDocBai.Text := qryGenPor.FieldByName('CTR_DOCBAI').AsString;
    edtPorBai.Text := qryGenPor.FieldByName('PORBAI').AsString;
    edtCtaBai.Text := qryGenPor.FieldByName('CTR_CTABAI').AsString;
    edtHisBai.Text := qryGenPor.FieldByName('CTR_HISBAI').AsString;
    edtOpeBai.Text := qryGenPor.FieldByName('OPEBAI').AsString;

    If Not fEmptyStr(qryGenPor.FieldByName('CTR_SEQCON').AsString) Then
      edtSeqCon.Text := qryGenPor.FieldByName('CTR_SEQCON').AsString + '-' + qryGenPor.FieldByName('CTR_EMPBAI').AsString
    Else
      edtSeqCon.Text := '';

    edtSeqBai.Text := qryGenPor.FieldByName('CTR_SEQBAI').AsString;

    QryGenPor.Close;
  End
  Else
  Begin
    edtSeqBai.Clear;
    edtTipBai.Clear;
    edtOpeBai.Clear;
    edtHisBai.Clear;
    edtValOri.Clear;
    edtCtaBai.Clear;
    edtPorBai.Clear;
    edtDocBai.Clear;
    edtSeqCon.Clear;
    edtValRec.Clear;
    edtDtaRec.Clear;
    edtValJur.Clear;
    edtValDes.CLear;
  End;

  {*****************************************}
  {* HABILITA / DESABILITA OS EDITS        *}
  {**************************************MV*}
  If (qryTabela.State = dsInsert) Or (qryTabela.State = dsEdit) Then
  Begin
    pEnabled(Self, Not blnBaixada);
    HabilitarCampoProjeto;
  End;

  edtCtaBai.Enabled := False;

  if ((qryTabela.FieldByName('CTR_AUTCTP').AsString <> '') and (fCfgSis('ENCBAN', varBoolean))) then
  begin
    DefinirTarifa;
  end;

  If (blnDupBaixada) and (qryTabela.State = dsBrowse) Then
  Begin
    dbeHisto1.Enabled    := False;
    btnGravar.Enabled    := False;
    btnCancela.Enabled   := False;
    btnIncluir.Enabled   := True;
    btnAlterar.Enabled   := True;
    btnPesquisa.Enabled  := True;
    btnBaixarDup.Enabled := True;
    btnDocBaixa.Enabled  := True;
    btnSair.Enabled      := True;
    btnReenviarRelAgrup.enabled := qryTabela.FieldByName('CTR_ESPDOC').asstring = 'AG';
    pSetFocus(btnAlterar);
  End;

  FreeAndNil(qryGenPor);
end;

function TfrmCadCtaReceber.RetornaSqlConsultaTarifa(ACodigoBancoBoleto: String): String;
begin
  Result := ' SELECT A.CTP_VALORI AS TARIFA, ' +
            '  CONCAT(A.CTP_PORBAI, " - ", P.POR_NOMPOR) AS PORBAI, ' +
            '  CONCAT(A.CTP_CTABAI, " - ", C.CTA_DESCTA) AS CTABAI, ' +
            '  CONCAT(A.CTP_CODFOR, " - ", F.FOR_NOMFOR) AS FORBAI '  +
            'FROM ' +
            '  CADPAG A ' +
            '  JOIN CADPOR P ON A.CTP_PORBAI = P.POR_CODPOR ' +
            '  JOIN CADCTA C ON A.CTP_CTABAI = C.CTA_CODCTA ' +
            '  JOIN CADFOR F ON A.CTP_CODFOR = F.FOR_CODFOR ' +
            '  WHERE A.AUTOINCREM = :AUTCTP';

  if MatchStr(ACodigoBancoBoleto, ['756']) then
    Result := 'SELECT ' +
              '  DET_TARIFA AS TARIFA, ' +
              '  CONCAT(CTP_PORBAI, " - ", POR_NOMPOR) AS PORBAI, ' +
              '  CONCAT(CTP_CTABAI, " - ", CTA_DESCTA) AS CTABAI, ' +
              '  CONCAT(CTP_CODFOR, " - ", FOR_NOMFOR) AS FORBAI ' +
              'FROM ' +
              '  HISRET ' +
              '  INNER JOIN CADREC C ' +
              '    ON CTR_NUMDUP = HIS_NUMDUP ' +
              '    AND CTR_PARCEL = HIS_PARCEL ' +
              '    AND CTR_CODCLI = HIS_CODCLI ' +
              '    AND CTR_CODEMP = HIS_CODEMP ' +
              '    AND CTR_SEQBAI = HIS_SEQBAI ' +
              '  INNER JOIN RETDET D ' +
              '    ON C.AUTOINCREM = DET_DUPLIC ' +
              '    AND DET_CODOCO = HIS_CODOCO ' +
              '    AND DET_DTAPAG = HIS_DTAPAG ' +
              '  INNER JOIN RETGER G ' +
              '   ON G.AUTOINCREM = DET_SEQGER ' +
              '   AND GER_CODBCO = HIS_CODBCO ' +
              '  INNER JOIN CADPAG P ' +
              '    ON C.CTR_AUTCTP = P.AUTOINCREM ' +
              '  JOIN CADPOR ON POR_CODPOR = CTP_PORBAI ' +
              '  JOIN CADCTA ON CTA_CODCTA = CTP_CTABAI ' +
              '  JOIN CADFOR ON FOR_CODFOR = CTP_CODFOR ' +
              'WHERE C.AUTOINCREM = :AUTOINCREM ' +
              '  AND HIS_VALPAG > 0.00 ' +
              'ORDER BY HIS_DTAOCO ' +
              'LIMIT 1';
end;

procedure TfrmCadCtaReceber.DefinirTarifa;
var
  LConsulta: TUniQuery;
begin
  LConsulta := fCriaQuery;
  try
    LConsulta.SQL.Text := RetornaSqlConsultaTarifa(qryTabela.FieldByName('CTR_BCOENV').AsString);

    if LConsulta.Params[0].Name.Equals('AUTCTP') then
      LConsulta.ParamByName('AUTCTP').AsString := qryTabela.FieldByName('CTR_AUTCTP').AsString
    else
      LConsulta.ParamByName('AUTOINCREM').AsString := qryTabela.FieldByName('AUTOINCREM').AsString;

    LConsulta.Open;
    LConsulta.First;

    if not LConsulta.isEmpty then
    begin
      edtValorTarifa.Text := FloatToStrF(LConsulta.FieldByName('TARIFA').AsFloat, ffFixed, 12, 2);
      edtPorTar.Text      := LConsulta.FieldByName('PORBAI').AsString;
      edtCtaTar.Text      := LConsulta.FieldByName('CTABAI').AsString;
      edtForTar.Text      := LConsulta.FieldByName('FORBAI').AsString;
    end;

    LConsulta.Close;
  finally
    FreeAndNil(LConsulta);
  end;
end;

function TfrmCadCtaReceber.fCarregaDuplicata: Boolean;
var
  strChvLoc: String;
begin
  Result := True;
  strChvLoc := strNomeTabela +
               qryTabela.FieldByName('CTR_NUMDUP').AsString +
               qryTabela.FieldByName('CTR_ESPDOC').AsString +
               qryTabela.FieldByName('CTR_CODEMP').AsString +
               qryTabela.FieldByName('CTR_CODCLI').AsString ;

  If Not fEmptyStr(fGetHostLock(strChvLoc)) Then
  Begin
    if qryTabela.RecordCount > 0 then
    begin
      fMensagem('ATENÇÃO!', 'Este documento está sendo utilizado por outra estação: ' + fGetHostLock(strChvLoc), ['&Ok']);

      With qryTabela Do
      Begin
        SQL.Clear;
        SQL.Add('SELECT * FROM ' + strNomeTabela + ' WHERE FALSE');
        Open;
      End;

      Result := False;
      strDuplicataParcial := '';
      strParcelaParcial   := '';
      strEmpresaParcial   := '';
      strClienteParcial   := '';
      strEspecieParcial   := '';
      pLimparCampos;
      Exit;
    end 
    else
    begin
      fLock_Unlock(strChvLoc +
                   qryTabela.FieldByName('CTR_PARCEL').AsString,
                   False,
                   False);
      blnDupTravada := False;
    end;
  End
  Else If Not fLock_Unlock(strChvLoc +
                           qryTabela.FieldByName('CTR_PARCEL').AsString,
                           True,
                           False) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esta duplicata está sendo utilizada por outra estação: ' + fGetHostLock(strChvLoc +
                                                                                      qryTabela.FieldByName('CTR_PARCEL').AsString), ['&Ok']);

    With qryTabela Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT * FROM ' + strNomeTabela + ' WHERE FALSE');
      Open;
    End;

    Result := False;
    strDuplicataParcial := '';
    strParcelaParcial   := '';
    strEmpresaParcial   := '';
    strClienteParcial   := '';
    strEspecieParcial   := '';
    pLimparCampos;
    Exit;
  End
  else
    blnDupTravada := True;

  pCarregaDadosAdicionais;
  pCalculaValorTotal();
  AValorTotalInicial   := qryTabela.FieldByName('CTR_VALDUP').AsFloat;
  ADataCadastroInicial := qryTabela.FieldByName('CTR_DTACAD').AsDateTime;
end;

function TfrmCadCtaReceber.fCarregaDupParaBaixa(strAutInc: String): Boolean;
begin
  Result := False;

  If (fCfgSis('CTRCDA', varBoolean)) Then
  Begin
    If (fEmptyStr(strAutInc)) Then
      Exit;

    If (Not qryTabela.FieldByName('CTR_DTAREC').IsNull) Then
      Exit;

    Result := True;
  End;
end;

function TfrmCadCtaReceber.dbeCodEmpChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fchamaCadEmp(Key);
end;

function TfrmCadCtaReceber.dbeCodCliChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fchamaCadCli(Key);
end;

function TfrmCadCtaReceber.dbeCodPorChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadPor(Key);
end;

function TfrmCadCtaReceber.dbeCodVenChamaCadastro(Key: Word): String;
begin
  inherited;
  Result := fChamaCadOpe(Key);
end;
{******************************************************************}
{* PROCEDURE ALTERADO PARA CHAMADA DA NOVA CONSULTA DE PORTADORES *}
{***************************************************************JU*}
procedure TfrmCadCtaReceber.dbeCodPorKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited; 
  If fEntraCons(Key) Then
  Begin
    if fPesqPortador(conSimples,
                     Self,
                     dbeCodPor,
                     edtNomPor,
                     nil,
                     Key,
                     arrSel,
                     True,
                     'Consulta de Portadores',
                     '',
                     False,
                     False,
                     dbeCodEmp.Text)  then
    Begin
      If fValidaCampos(dbeCodPor, False) Then
        Self.SelectNext(ActiveControl, True, True);
    End; 
  End;
end;

procedure TfrmCadCtaReceber.dbeCodVenKeyPress(Sender: TObject;
  var Key: Char);
  var
    arrSel : TConsultasArray;
begin
  inherited;
  if fPesqOperador(Self, dbeCodVen, edtNomVen, qryConOpe, Key, arrSel) then
  Begin
    If fValidaCampos(dbeCodVen, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCtaReceber.dbeEspDocExit(Sender: TObject);
begin
  inherited;
  HabilitarCampoProjeto;
end;

procedure TfrmCadCtaReceber.dbeCodCliKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrClientes: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE CLIENTES   *}
  {****************************RV*}
  If fPesqCliente(conCliSimples, Self, dbeCodCli, edtNomCli, Nil, Key, arrClientes) Then
  Begin
    If fValidaCampos(dbeCodCli, True) Then
    Begin
      SelectNext(ActiveControl, True, True);
      pCarregaDadosAdicionais;
      dtaDtaCadOld := qryTabela.FieldByName('CTR_DTACAD').AsDateTime;
      dtaDtaVenOld := qryTabela.FieldByName('CTR_DTAVEN').AsDateTime;
      strValDupOld := FloatToStr(qryTabela.FieldByName('CTR_VALDUP').AsFloat);
      strCodPorOld := qryTabela.FieldByName('CTR_CODPOR').AsString;
    End;
  End;
end;

procedure TfrmCadCtaReceber.dbeCodEmpKeyPress(Sender: TObject;
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

procedure TfrmCadCtaReceber.btnGravarClick(Sender: TObject);
  Var
    dsState: TDataSetState;
    strCfg_PORPGR: String;
    strCfg_CTAGCP: String;
    recModalidades : TArrModalidade;
    strSeqGeral: String;
    Corrige_Branco:String;
    dtaDtaVc1: TDateTime;
    dtaDtaVc2: TDateTime;
    qryAux   : TUniQuery;
    strSQL   : String;

    blnCtrPrd,
    blnInserindo,
    blnAlterando,
    LPortadorPDD : Boolean;

    LDataTrocaPortador : TDateTime;

    strValorAnterior,
    strVencimentoAnterior,
    strPortadorAnterior,
    strPlanoDeContasAnterior,
    strChaveDuplicata : String;

    LPortadorMovBan,
    LPlanoDeContasMovBan: String;
    LEnviaEmailCancelamentoBoleto: TEnviaEmailCancelamentoBoleto;
    LNumDupOriginal: String;
begin
  dtaDtaVc1 := 0;
  dtaDtaVc2 := 0;
  blnGerarCreditoDireto := False;
  Corrige_Branco := dbeNosNum.Text;

  if fEmptyStr(qryTabela.FieldByName('CTR_EMPORI').AsString) then
    qryTabela.FieldByName('CTR_EMPORI').AsString := VS_strCodEmp;

  qryTabela.FieldByName('CTR_CODPRJ').Value := Null;
  if Not fEmptyStr(edtCodPrj.Text) And edtCodPrj.Enabled Then
    qryTabela.FieldByName('CTR_CODPRJ').AsString := edtCodPrj.Text;

  If Pos(' ',corrige_branco) <> 0 then
  Begin
    fMensagem('ATENÇÃO!','"Nosso número" corrigido pois não pode conter espaço em branco!',['&O k']);
    dbeNosNum.Text := StringReplace(dbeNosNum.Text, ' ', '', [rfReplaceAll]);
  End;


  If (qryTabela.FieldByName('CTR_CODPOR').OldValue <> qryTabela.FieldByName('CTR_CODPOR').NewValue) And
     ((Not qryTabela.FieldByName('CTR_DTAENV').IsNull) Or (Not qryTabela.FieldByName('CTR_DTABOL').IsNull)) And
     (Not qryTabela.FieldByName('CTR_NOSNUM').IsNull) Then
  Begin
    If (Not fValidaCampos(dbeCodPor)) Or (Not fSenhaPortador) Then
      Exit;
  End;

  If (qryTabela.FieldByName('CTR_VALDUP').OldValue <> qryTabela.FieldByName('CTR_VALDUP').NewValue) And
   Not(fVerificaAcessoSistema('CTRALTVALDUP', strLoginUsuarioLogado)) And fCfgSis('CTRVAL', varBoolean) And
       fEmptyStr(fCfgSis('CTRSVD')) And qryTabela.State = dsEdit Then
  Begin
    If (Not fValidaCampos(dbeValDup)) Or (Not fSenhaAlteracaoValorDuplicata) Then
      Exit;
  End;

  FillChar(recModalidades, SizeOf(recModalidades), #0);

  If (Not fEmptyStr(strCodBco)) or (dtaDtaEnv <> 0) Then
  begin
    If (strCodBco <> qryTabela.FieldByName('CTR_BCOENV').AsString) or
       (dtaDtaEnv <> qryTabela.FieldByName('CTR_DTAENV').AsDateTime)  Then
    begin
      if ExisteDuplicataParaRemessa then
      begin
        fMensagem('ATENÇÃO!','Alteração nos dados de remessa bancária não permitida!' + #13 +
                             'Há uma duplicata para remessa vinculada a esse registro. ' + #13 +
                             'Acesse a rotina "Cancelamento de Duplicatas para Remessa" do AUTBAN.',['&O K']);
        btnCancelaClick(Sender);
        Exit;
      end;

      if fVerificaRemessa(qryTabela.FieldByName('AUTOINCREM').AsString) then
      begin
        fMensagem('','Essa duplicata pertence a uma remessa bancária, portanto, não poderá ser alterado os dados da remessa. Caso precise alterar ou excluir esses dados, acesse o AUTBAN e cancele a remessa!',['&O K']);
        btnCancelaClick(Sender);
        Exit;
      end;
    end;
  end;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  {**************************************************
   *LANÇAR MOVIMENTAÇÃO BANCARIA PARA CREDITO DIRETO*
   *******************************MT*REQ: 163244*****}
  blnInserindo := qryTabela.State = dsInsert;
  If Not fGerarCreditoCliente(blnInserindo) Then
    Exit;

  blnAlterando := qryTabela.State = dsEdit;

  strCfg_PORPGR := fCfgSis('PORPGR');
  strCfg_CTAGCP := fCfgSis('CTAGCP');

  If (Not fEmptyStr(strCfg_PORPGR)) Or (Not fEmptyStr(strCfg_CTAGCP)) Then
  Begin

    If (Not fEmptyStr(strCfg_PORPGR)) Then
    Begin

      If ((Not fEmptyStr(dbeCodPor.Text)) And (dbeCodPor.Text = strCfg_PORPGR)) Then
      Begin
        pMensagemOk('Portador ' + strCfg_PORPGR + ' não permitido, pois está configurado para baixa de Contas a Pagar no resumo de caixa.');
        pSetFocus(dbeCodPor);
        Exit;
      End;

    End;

    If (Not fEmptyStr(strCfg_CTAGCP)) Then
    Begin

      If (Not fEmptyStr(fraPlanoDeContas.dbeCodCta.Text)) And (fraPlanoDeContas.dbeCodCta.Text = strCfg_CTAGCP) Then
      Begin
        pMensagemOk('Plano de Contas ' + strCfg_CTAGCP + ' não permitido, pois está configurado para baixa de Contas a Pagar no resumo de caixa.');
        pSetFocus(fraPlanoDeContas.dbeCodCta);
        Exit;
      End;

    End;
  End;

  If (blnDupBaixada) Then
  Begin
    btnGravar.Enabled    := False;
    btnCancela.Enabled   := False;
    btnIncluir.Enabled   := True;
    btnAlterar.Enabled   := True;
    btnPesquisa.Enabled  := True;
    btnBaixarDup.Enabled := True;
    btnDocBaixa.Enabled  := True;
    btnHistReceb.Enabled := True;
    btnSair.Enabled      := True;
    btnReenviarRelAgrup.enabled := (qryTabela.FieldByName('CTR_ESPDOC').asstring = 'AG') And (qryTabela.State = dsInsert);
  End;

  If (dbeEspDoc.Text = 'AG') And (blnInserindo) Then
  Begin
    fMensagem('','Não é permitido gravar duplicata com espécie AG.',['&OK']);
    Exit;
  End;

  if not (blnInserindo) then
  begin
    if fAlterouValor(qryTabela.FieldByName('AUTOINCREM').AsString,
                     qryTabela.fieldByName('CTR_VALDUP').AsFloat) then
      pLimpaDadosBoleto;
    if fAlterouVencimento(qryTabela.FieldByName('AUTOINCREM').AsString,
                     qryTabela.fieldByName('CTR_DTAVEN').AsString) then
      pLimpaDadosBoleto;
  end;

  If fEmptyStr(dbeBcoBol.Text) Then
    dbeBcoBol.Field.Value := Null;

  If fEmptyStr(dbeNosNum.Text) Then
  begin
    If fVerificaRetorno(qryTabela.FieldByName('AUTOINCREM').AsString) Then
    begin
      If fMensagem('', 'Essa duplicata já sofreu confirmação bancária por arquivo retorno, deseja continuar?', ['', ''], 2) = 1 Then
      Begin
        pGravaDelRetDet('CANCELAMENTO DE RETORNO BANCARIO UNTCADCTARECEBER',
                        qryTabela.FieldByName('AUTOINCREM').AsString,
                        strSeqGeral);
        pGravaDelRetGer(strSeqGeral, 'CANCELAMENTO DE RETORNO BANCARIO UNTCADCTARECEBER');
      End
      Else
        Exit;
    End;

    qryTabela.FieldByName('CTR_NOSNUM').Value    := Null;
    qryTabela.FieldByName('CTR_DTABOL').Value    := Null;
    qryTabela.FieldByName('CTR_BCOBOL').Value    := Null;
    qryTabela.FieldByName('CTR_CARTEI').AsString := '';
    qryTabela.FieldByName('CTR_CODCED').Value    := Null;
    qryTabela.FieldByName('CTR_LINDIG').Value    := Null;
  end;

  If BoletoCancelado Then
  Begin
    LEnviaEmailCancelamentoBoleto := TEnviaEmailCancelamentoBoleto.Create(qryTabela.FieldByName('AUTOINCREM').AsString);
  End;

  If (blnInserindo) Then
    qryTabela.FieldByName('CTR_GRVORI').AsFloat := qryTabela.FieldByName('CTR_VALORI').AsFloat;

  dsState := qryTabela.State;

  If ((qryTabela.FieldByName('CTR_CODCTA').IsNull) And (qryTabela.FieldByName('CTR_CODCTA').AsString = '') ) Or (Not fraPlanoDeContas.dbeCodCta.Visible) Then
    fraPlanoDeContas.dbeCodCta.Field.Value := null;

  If fEmptyStr(dbeCodPor.Text) Then
    qryTabela.FieldByName('CTR_CODPOR').Value := Null;

  blnCtrPrd := False;

  strValorAnterior         := '';
  strVencimentoAnterior    := '';
  strPortadorAnterior      := '';
  strPlanoDeContasAnterior := '';

  LPortadorPDD := False;
  LDataTrocaPortador := 0;

  If dsState = dsEdit Then
  Begin
    if NumeroDuplicataFoiAltarado(LNumDupOriginal) then
    begin
      qryTabela.FieldByName('CTR_NUMDUP').AsString := LNumDupOriginal;
    end;

    strValorAnterior         := VarToStr(qryTabela.FieldByName('CTR_VALDUP').OldValue);
    strVencimentoAnterior    := VarToStr(qryTabela.FieldByName('CTR_DTAVEN').OldValue);
    strPortadorAnterior      := VarToStr(qryTabela.FieldByName('CTR_CODPOR').OldValue);
    strPlanoDeContasAnterior := VarToStr(qryTabela.FieldByName('CTR_CODCTA').OldValue);

    If (strPortadorAnterior <> qryTabela.FieldByName('CTR_CODPOR').AsString) Then
    Begin
      LDataTrocaPortador := TGravaAlteracaoDePortador.RetornaDataPortadorAnterior(qryTabela.FieldByName('CTR_NUMDUP').AsString,
                                                                         qryTabela.FieldByName('CTR_PARCEL').AsString,
                                                                         qryTabela.FieldByName('CTR_ESPDOC').AsString,
                                                                         qryTabela.FieldByName('CTR_CODEMP').AsString,
                                                                         qryTabela.FieldByName('CTR_CODCLI').AsString,
                                                                         qryTabela.FieldByName('CTR_SEQBAI').AsString);

      If Not fValidaPortadorDataPDD(qryTabela.FieldByName('CTR_CODPOR').AsString,
                                    qryTabela.FieldByName('CTR_CODEMP').AsString,
                                    LDataTrocaPortador,
                                    fCampoTabela('POR_TITPDD', 'CADPOR', ['POR_CODPOR'], [strPortadorAnterior]) = 'S') Then
      Begin
         fMensagem('','Operação cancelada!',['&OK']);
         Exit;
      End
      Else
        LPortadorPDD  := True;
    End;

    qryAux := fCriaQuery(Self);

    Try
      strSQL := '';
      strSQL := strSQL + ' SELECT SQL_NO_CACHE        ';
      strSQL := strSQL + '   CTR_DTAVEN               ';
      strSQL := strSQL + ' FROM                       ';
      strSQL := strSQL + '   ' + strNomeTabela         ;
      strSQL := strSQL + ' WHERE                      ';
      strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI AND ';
      strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '   CTR_CODCLI = :CODCLI     ';

      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := qryTabela.FieldByName('CTR_NUMDUP').AsString;
        ParamByName('PARCEL').AsString := qryTabela.FieldByName('CTR_PARCEL').AsString;
        ParamByName('SEQBAI').AsInteger:= qryTabela.FieldByName('CTR_SEQBAI').AsInteger;
        ParamByName('ESPDOC').AsString := qryTabela.FieldByName('CTR_ESPDOC').AsString;
        ParamByName('CODEMP').AsString := qryTabela.FieldByName('CTR_CODEMP').AsString;
        ParamByName('CODCLI').AsString := qryTabela.FieldByName('CTR_CODCLI').AsString;
        Open;

        dtaDtaVc1 := FieldByName('CTR_DTAVEN').AsDateTime;
        dtaDtaVc2 := dbeDtaVen.Field.Value;
      End;
    Finally
      FreeAndNil(qryAux);
    End;

    If dtaDtaVc2 > dtaDtaVc1 Then
      blnCtrPrd := True
    Else
      blnCtrPrd := False;
  End;

  If blnGerarCreditoDireto Then
  Begin
    If Not SelecionaPortadorPlanoDeContasMovBan(LPortadorMovBan, LPlanoDeContasMovBan) Then
      Exit;

    If fCfgSis('UTICON', varBoolean) Then
    Begin
      dbeCodPor.Text := LPortadorMovBan;
      If Not fValidaCampos(dbeCodPor) Then
        Exit;
    End;
  End;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;
  Try
    if DeveTravarAlteracaoNossoNumero then
    begin
      fMensagem('ATENÇÃO!',
                'O "Nosso Número" foi informado, mas a carteira está vazia. ' +
                'Recarregue a duplicata e tente novamente!',
                ['&OK']);
      Exit;
    end;

    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadCtaReceber.btnGravarClick]');
    End;
  End;

  Try
    If blnGravou Then
    Begin
      {**************************************************
       *LANÇAR MOVIMENTAÇÃO BANCARIA PARA CREDITO DIRETO*
       *******************************MT*REQ: 163244*****}
      If blnGerarCreditoDireto Then
      Begin
        If Not fGravaCreditoCliente(LPortadorMovBan, LPlanoDeContasMovBan, blnInserindo) Then
          Exit;
      End;


      If Assigned(LEnviaEmailCancelamentoBoleto) Then
      Begin
        If Not LEnviaEmailCancelamentoBoleto.EnviaEmailCancelamentoBoleto Then
        Begin
          fMensagem('Aviso!','Houve um problema no envio do e-mail referente ao cancelamento do boleto!',['&O k']);
        End;
        FreeAndNil(LEnviaEmailCancelamentoBoleto);
      End;

      {**********************************************************************
       *QUANDO ALTERADO VALOR DE UM CRÉDITO DIRETO COM MOVIMENTAÇÃO BANCARIA*
       *TAMBEM IRA ALTERAR O VALOR DOS LANÇAMENTOS                          *
       **********************************************MT*REQ: 163244**********}
      If (blnAlterando) And (dbeEspDoc.Text = 'CC') And
        (fStrToFloat(strValDupOld) <> fStrToFloat(dbeValDup.Text)) And (Not fEmptyStr(strMovBan))Then
      Begin
        If Not fAtualizaCreditoDiretoComMovBan(arrDupSel,strMovBan,fStrToFloat(dbeValDup.Text), self.Name) Then
          Exit;
      End;

      If blnAlterando And (dtaDtaVenOld < VS_DATE) And
        (dtaDtaVenOld <> StrToDate(dbeDtaVen.Text)) And
        (StrToDate(dbeDtaVen.Text) >= VS_DATE) Then
      Begin
        If Assigned(objProrrogacao) Then
        Begin
          objProrrogacao.pAdicionarDuplicataNoArrayProrrogacao(qryTabela,qryTabela.RecNo,dtaDtaVenOld);
          objProrrogacao.pInativarClientePorProrrogacao;
          objProrrogacao.pLimparArrays;
        End;
      End;

      pCalculaValorTotal();

      pGeraLogLiberacao(qryTabela.FieldByName('CTR_NUMDUP').AsString,
                        qryTabela.FieldByName('CTR_ESPDOC').AsString,
                        qryTabela.FieldByName('CTR_CODEMP').AsString);

      If (blnDupBaixada) Or (Not qryTabela.FieldByName('CTR_OBSAG1').IsNull) Then
      Begin
        btnExcluir.Enabled := False;
        If (btnAlterar.Tag = 88) Then
          btnAlterar.Enabled := False;
      End;

      btnBaixarDup.Enabled := True;
      btnDocBaixa.Enabled  := True;
      btnImprimir.Enabled  := True;
      btnHistReceb.Enabled := True;
      pHabilitaDesabiltabtnAbrirPastaAnexos;

      If LPortadorPDD Then
        TGravaAlteracaoDePortador.SalvarManualmente(strPortadorAnterior,
                                                    qryTabela.FieldByName('CTR_CODPOR').AsString,
                                                    qryTabela.FieldByName('CTR_NUMDUP').AsString,
                                                    qryTabela.FieldByName('CTR_PARCEL').AsString,
                                                    qryTabela.FieldByName('CTR_ESPDOC').AsString,
                                                    qryTabela.FieldByName('CTR_CODEMP').AsString,
                                                    qryTabela.FieldByName('CTR_CODCLI').AsString,
                                                    qryTabela.FieldByName('CTR_SEQBAI').AsString,
                                                    False,
                                                    LDataTrocaPortador);


      blnGravou := False;

      {*********************************}
      {* GRAVAR TABELA DO SISTEMA DEPS *}
      {******************************AJ*}
      If fCfgSis('USADEP') = 'S' Then
      Begin
        strChaveDuplicata := Concat(qryTabela.FieldByName('CTR_NUMDUP').AsString, '-',
                                    qryTabela.FieldByName('CTR_PARCEL').AsString, '-',
                                    qryTabela.FieldByName('CTR_ESPDOC').AsString, '-',
                                    qryTabela.FieldByName('CTR_CODEMP').AsString, '-',
                                    qryTabela.FieldByName('CTR_CODCLI').AsString, '-',
                                    qryTabela.FieldByName('CTR_SEQBAI').AsString);

        If blnInserindo Then
          TValidacoesSistemaDEPS.pGravaLancamentoSistemaDEPS(strChaveDuplicata, 'INCLUSÃO')
        Else If (qryTabela.FieldByName('CTR_DTAREC').IsNull) And
                (qryTabela.FieldByName('CTR_SEQBAI').AsString = '0') Then
        Begin
          If strVencimentoAnterior <> qryTabela.FieldByName('CTR_DTAVEN').AsString Then
            TValidacoesSistemaDEPS.pGravaLancamentoSistemaDEPS(strChaveDuplicata,
                                                               'ALTERAÇÃO VENCIMENTO',
                                                               strVencimentoAnterior);

          If strValorAnterior <> qryTabela.FieldByName('CTR_VALDUP').AsString Then
            TValidacoesSistemaDEPS.pGravaLancamentoSistemaDEPS(strChaveDuplicata,
                                                               'ALTERAÇÃO VALOR',
                                                               strValorAnterior);

          If strPortadorAnterior <> qryTabela.FieldByName('CTR_CODPOR').AsString Then
            TValidacoesSistemaDEPS.pGravaLancamentoSistemaDEPS(strChaveDuplicata,
                                                               'ALTERAÇÃO PORTADOR',
                                                               strPortadorAnterior);

          If strPlanoDeContasAnterior <> qryTabela.FieldByName('CTR_CODCTA').AsString Then
            TValidacoesSistemaDEPS.pGravaLancamentoSistemaDEPS(strChaveDuplicata,
                                                               'ALTERAÇÃO PLANO DE CONTAS',
                                                               strPlanoDeContasAnterior);

        End;
      End;

      If blnInserindo And VS_strHabilitarCRM And (Not fEmptyStr(fCfgSis('OCOFIN', varString)))  Then
      Begin
        TAtuOcoCrm.pAtualizaOcorrenciaFinanceiro(qryTabela.FieldByName('CTR_NUMDUP').AsString,
                                                 qryTabela.FieldByName('CTR_ESPDOC').AsString,
                                                 qryTabela.FieldByName('CTR_CODEMP').AsString,
                                                 qryTabela.FieldByName('CTR_CODCLI').AsString,
                                                 qryTabela.FieldByName('CTR_PARCEL').AsString,
                                                 dbeCodVen.Text,
                                                 fRetCgcCpf(dbeCodCli.text),
                                                 afcGeraDuplicata);
      End;

      pGravaLogCtr(qryTabela.FieldByName('AUTOINCREM').AsString, IIF(dsState = dsInsert,'INCLUSÃO','ALTERAÇÃO'), Self.Name);



      If blnCtrPrd Then
        fGravaCtrPrd(qryTabela.FieldByName('CTR_NUMDUP').AsString,
                     qryTabela.FieldByName('CTR_PARCEL').AsString,
                     qryTabela.FieldByName('CTR_SEQBAI').AsInteger,
                     qryTabela.FieldByName('CTR_ESPDOC').AsString,
                     qryTabela.FieldByName('CTR_CODCLI').AsString,
                     qryTabela.FieldByName('CTR_CODEMP').AsString,
                     qryTabela.FieldByName('CTR_VALDUP').AsFloat,
                     dtaDtaVc1,
                     dtaDtaVc2,
                     strLoginUsuarioLogado,
                     Self.Name);

      fCommit;

      If blnInserindo Then
      begin
        fLock_Unlock(strNomeTabela +
               qryTabela.FieldByName('CTR_NUMDUP').AsString +
               qryTabela.FieldByName('CTR_ESPDOC').AsString +
               qryTabela.FieldByName('CTR_CODEMP').AsString +
               qryTabela.FieldByName('CTR_CODCLI').AsString +
               qryTabela.FieldByName('CTR_PARCEL').AsString, True, False);
        blnDupTravada := True;
      end;

      if blnIniciaCadastro then
      begin
        btnSair.Click;
        Exit;
      end;
      pDestravarRegistros;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin

      If Assigned(LEnviaEmailCancelamentoBoleto) Then
        FreeAndNil(LEnviaEmailCancelamentoBoleto);

      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;

  SetLength(arrLogLib, 0);

  btnEstornoCtr.Enabled := (Not qryTabela.IsEmpty) And
                           (blnDupBaixada) And
                           (fVerificaAcessoSistema('frmEstornoCtaReceber'));
end;

procedure TfrmCadCtaReceber.btnHisRetornoClick(Sender: TObject);
begin
  inherited;

  If Assigned(prcExecutaRelatorio) Then
  begin
    prcExecutaRelatorio(90, 5416, [],
                        ['NUMDUP','PARCEL','SEQBAI','ESPDOC','CODCLI','CODEMP'],
                        [dbeNumDup.Text,
                        dbeParcel.Text,
                        dbeSeqBai.Text,
                        dbeEspDoc.Text,
                        dbeCodCli.Text,
                        dbeCodEmp.Text],
                        Sender,
                        nil,
                        True);
  End;

end;

procedure TfrmCadCtaReceber.btnHistRecebClick(Sender: TObject);
  Var
    frmRelCtrLogAcompDuplicNovo : TfrmRelCtrLogAcompDuplicNovo;
begin
  If (qryTabela.IsEmpty) Or (fEmptyStr(dbeNumDup.Text))Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmRelCtrLogAcompDuplicNovo, frmRelCtrLogAcompDuplicNovo);
    frmRelCtrLogAcompDuplicNovo.edtCodEmpresa.Text := qryTabela.FieldByName('CTR_CODEMP').AsString;
    frmRelCtrLogAcompDuplicNovo.edtCodCliente.Text := qryTabela.FieldByName('CTR_CODCLI').AsString;
    frmRelCtrLogAcompDuplicNovo.edtNumDoc.Text     := qryTabela.FieldByName('CTR_NUMDUP').AsString;
    frmRelCtrLogAcompDuplicNovo.edtParcel.Text     := qryTabela.FieldByName('CTR_PARCEL').AsString;
    frmRelCtrLogAcompDuplicNovo.edtEspecie.Text    := qryTabela.FieldByName('CTR_ESPDOC').AsString;
    frmRelCtrLogAcompDuplicNovo.blnVeioManutencao  := True;
    frmRelCtrLogAcompDuplicNovo.pCarregaCampos;
    if frmRelCtrLogAcompDuplicNovo.qryConsulta.IsEmpty then
      fMensagem('ATENÇÃO!', 'Sem dados para exibir!', ['&O k'])
    else
      frmRelCtrLogAcompDuplicNovo.ShowModal;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TfrmCadCtaReceber.btnHistReceb]');
  End;
  pFreeAndNil(frmRelCtrLogAcompDuplicNovo);
end;

procedure TfrmCadCtaReceber.pAdiantamentoCliente;
begin
  If qryTabela.FieldByName('CTR_ADTCLI').AsString = 'S' Then
  Begin
    btnConsultarAdiantamentos.Visible := True;
    btnCopiaCPFCNPJ.Caption := 'Cop. CPF/CNP&J';
    btnCopiaCPFCNPJ.Width   := 101;
  End
  Else
  Begin
    btnConsultarAdiantamentos.Visible := False;
    btnCopiaCPFCNPJ.Caption := 'Copiar CPF/CNP&J cliente';
    btnCopiaCPFCNPJ.Width   := 202;
  End;
end;

procedure TfrmCadCtaReceber.pAdicionarDuplicataNoArray;
begin
  arrDupSel := Nil;
  FillChar(arrDupSel, SizeOf(arrDupSel), #0);
  SetLength(arrDupSel, Length(arrDupSel) + 1);
  arrDupSel[Length(arrDupSel) - 1].strNumDoc := qryTabela.FieldByName('CTR_NUMDUP').AsString;
  arrDupSel[Length(arrDupSel) - 1].strEspDoc := qryTabela.FieldByName('CTR_ESPDOC').AsString;
  arrDupSel[Length(arrDupSel) - 1].strCodEmp := qryTabela.FieldByName('CTR_CODEMP').AsString;
  arrDupSel[Length(arrDupSel) - 1].strCodCli := qryTabela.FieldByName('CTR_CODCLI').AsString;
  arrDupSel[Length(arrDupSel) - 1].dtaDtaCad := qryTabela.FieldByName('CTR_DTACAD').AsDateTime;
  arrDupSel[Length(arrDupSel) - 1].dtaDtaVen := qryTabela.FieldByName('CTR_DTAVEN').AsDateTime;
  arrDupSel[Length(arrDupSel) - 1].fltVlrRec := qryTabela.FieldByName('CTR_VALDUP').AsFloat;
  arrDupSel[Length(arrDupSel) - 1].strParcel := qryTabela.FieldByName('CTR_PARCEL').AsString;
  arrDupSel[Length(arrDupSel) - 1].strSeqBai := '';
end;

procedure TfrmCadCtaReceber.pAfterOpen(DataSet: TDataSet);
begin
  With DataSet Do
  Begin

    If FindField('CTR_DTACAD') <> nil Then
      TDateField(FieldByName('CTR_DTACAD')).EditMask := '99/99/9999';

    If FindField('CTR_DTAVEN') <> nil Then
      TDateField(FieldByName('CTR_DTAVEN')).EditMask := '99/99/9999';

    If FindField('CTR_VALDUP') <> nil Then
      TFloatField(FieldByName('CTR_VALDUP')).DisplayFormat := '#,##0.00';

    If FindField('CTR_VALORI') <> nil Then
      TFloatField(FieldByName('CTR_VALORI')).DisplayFormat := '#,##0.00';

    If FindField('CTR_DESCOB') <> nil Then
      TFloatField(FieldByName('CTR_DESCOB')).DisplayFormat := '#,##0.00';

    If FindField('CTR_DTAREC') <> nil Then
      TDateField(FieldByName('CTR_DTAREC')).EditMask := '99/99/9999';

    If FindField('CTR_VALREC') <> nil Then
      TFloatField(FieldByName('CTR_VALREC')).DisplayFormat := '#,##0.00';

    If FindField('CTR_VALJUR') <> nil Then
      TFloatField(FieldByName('CTR_VALJUR')).DisplayFormat := '#,##0.00';

    If FindField('CTR_VALDES') <> nil Then
      TFloatField(FieldByName('CTR_VALDES')).DisplayFormat := '#,##0.00';

    If FindField('CTR_DTAENV') <> nil Then
      TDateField(FieldByName('CTR_DTAENV')).EditMask := '99/99/9999';

    If FindField('CTR_CODCTA') <> nil Then
      TStringField(FieldByName('CTR_CODCTA')).EditMask := '99.99.999;0;_';

    If FindField('CTR_CTASER') <> nil Then
      TStringField(FieldByName('CTR_CTASER')).EditMask := '99.99.999;0;_';

    If FindField('CTR_DESSUJ') <> nil Then
      TFloatField(FieldByName('CTR_DESSUJ')).DisplayFormat := '#,##0.00';

    If FindField('CTR_JURSUJ') <> nil Then
      TFloatField(FieldByName('CTR_JURSUJ')).DisplayFormat := '#,##0.00';

    If FindField('CTR_DTAPRO') <> nil Then
      TDateField(FieldByName('CTR_DTAPRO')).EditMask := '99/99/9999';

  End;
end;

procedure TfrmCadCtaReceber.pAtribuiTabelas;
begin
  qryConEmp := fCriarQuery('SELECT * FROM CADEMP WHERE FALSE', Self);
  qryConCli := fCriarQuery('SELECT * FROM CADCLI WHERE FALSE', Self);
  qryConOpe := fCriarQuery('SELECT * FROM CADOPE WHERE FALSE', Self);
  qryConCta := fCriarQuery('SELECT * FROM CADCTA WHERE FALSE', Self);
end;

procedure TfrmCadCtaReceber.pRecarregaDuplicataAberta;
Var
  strAutoincrem : String;
begin
  strAutoincrem  := qryTabela.FieldByName('AUTOINCREM').AsString;
  if not fEmptyStr(strAutoincrem) then
   begin
     pInicializarTabela('SELECT * FROM CADREC WHERE AUTOINCREM = ' + strAutoincrem.QuotedString);
     qryTabela.Open;
   end;
end;

function TfrmCadCtaReceber.SelecionaPortadorPlanoDeContasMovBan(
  out APortadorMovBan, APlanoDeContasMovBan: String): Boolean;
  Var
    LPorCredMovban : TfrmPorCredMovban;
begin
  pCriarFormularios(TfrmPorCredMovban, LPorCredMovban);
  LPorCredMovban.Caption := 'Dados para crédito no Movimento Bancário';
  LPorCredMovban.blnVeioManutencaoReceber := True;
  LPorCredMovban.ShowModal;

  Result := LPorCredMovban.blnConfirma;

  If Result then
  Begin
    Result := fEmpresaTemAcessoPortador(LPorCredMovBan.edtPorBai.Text);

    If Not Result Then
      fMensagem('ATENÇÃO!', 'Empresa sem acesso para utilizar este portador. Verifique o Cadastro de Portadores - Aba "Empresas Acesso".', ['&Ok'])
    Else
    Begin
      APortadorMovBan      := LPorCredMovban.edtPorBai.Text;
      APlanoDeContasMovBan := LPorCredMovban.fraPlanoDeContas.MskCodCta.Text;
    End;
  End;

  FreeAndNil(LPorCredMovban);
end;

procedure TfrmCadCtaReceber.btnBaixarDupClick(Sender: TObject);
Var
  frmBaixaReceber: TfrmBaixaReceber;
begin
  inherited;
  If Not fVerificaAcessoSistema('frmBaixaCtareceber') Then
    Exit;

  pDestravarRegistros;

  pCriarFormularios(TfrmBaixaReceber, frmBaixaReceber);

  If fCarregaDupParaBaixa(qryTabela.FieldByName('AUTOINCREM').AsString) Then
  Begin
    frmBaixaReceber.strAutIncManCtr := qryTabela.FieldByName('AUTOINCREM').AsString;
    frmBaixaReceber.pnlCabecalho.Visible := False;
    frmBaixaReceber.pnlCabecalho2.Visible := False;
    frmBaixaReceber.btnCarrTitulos.Click;
  End;

  frmBaixaReceber.ShowModal;


  pRecarregaDuplicataAberta;
  pCarregaDadosAdicionais;
  pCalculaValorTotal();

  pFreeAndNil(frmBaixaReceber);

  {***************************************************************************************************************}
  {* SE A DUPLICATA FOR BAIXADA, E, ANTES DA TELA DE BAIXA FOR FECHADA OUTRA ESTAÇÃO CARREGAR A MESMA DUPLICATA, *}
  {* O SISTEMA DEVE FICAR VERIFICANDO QUANDO A DUPLICATA ESTIVER SIDO LIBERADA PARA ASSIM SEGUIR. ****************}
  {* POR ISSO O PARÂMENTRO blnLoopTravamento ESTÁ TRUE ***********************************************************}
  {***************************************************************************************************************}
  if not fEmptyStr(qryTabela.FieldByName('CTR_NUMDUP').AsString) then
  begin
    If Not fLock_Unlock(strNomeTabela +
                        qryTabela.FieldByName('CTR_NUMDUP').AsString +
                        qryTabela.FieldByName('CTR_ESPDOC').AsString +
                        qryTabela.FieldByName('CTR_CODEMP').AsString +
                        qryTabela.FieldByName('CTR_CODCLI').AsString +
                        qryTabela.FieldByName('CTR_PARCEL').AsString, True, False) Then
    Begin
      fMensagem('ATENÇÃO!', 'Esta duplicata está sendo utilizada por outra estação: ' +
                             fGetHostLock(strNomeTabela +
                                          qryTabela.FieldByName('CTR_NUMDUP').AsString +
                                          qryTabela.FieldByName('CTR_ESPDOC').AsString +
                                          qryTabela.FieldByName('CTR_CODEMP').AsString +
                                          qryTabela.FieldByName('CTR_CODCLI').AsString +
                                          qryTabela.FieldByName('CTR_PARCEL').AsString), ['&Ok']);

      pInicializarTabela('SELECT * FROM CADREC WHERE FALSE');
      pCarregaDadosAdicionais;
      pCalculaValorTotal();
      blnExcluiu := False;

      Exit;
    End;
  end;
end;

{*****************************************}
{* VERIFICA SE HA UMA DUPLICATA EM DUPAGR*}
{* CASO TENHA ALGUM REGISTRO NA TABELA   *}
{* 'DUPAGR' RETORNA FALSO.               *}
{**************************************MV*}
function TfrmCadCtaReceber.fValidaDupAgr(strNumDup, strParcel, strEspDoc,
  strCodEmp, strCodCli: String; Var strNumAgr: String): Boolean;
  Var
    strSQL   : String;
    qryGenAgr: TUniQuery;
begin
  Try

    Result := False;
    strNumAgr := '';

    qryGenAgr := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTR_NUMAGR ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  DUPAGR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';

    With qryGenAgr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := dbeNumDup.Text;
      ParamByName('PARCEL').AsString := dbeParcel.Text;
      ParamByName('ESPDOC').AsString := dbeEspDoc.Text;
      ParamByName('CODEMP').AsString := dbeCodEmp.Text;
      ParamByName('CODCLI').AsString := dbeCodCli.Text;
      Open;

      If IsEmpty Then
        Result := True
      Else
        strNumAgr := FieldByName('CTR_NUMAGR').AsString;

      Close;
    End;

  Finally
    FreeAndNil(qryGenAgr);
  End;
end;

procedure TfrmCadCtaReceber.pCarregaEventos;
begin
  If Not fEmptyStr(fraCentroCusto.dbeCodEve.Text) Then
    fraCentroCusto.edtDesEve.Text := fRetNomEvento(fraCentroCusto.dbeCodEve)
  Else
    fraCentroCusto.edtDesEve.Clear;
end;

procedure TfrmCadCtaReceber.btnImpBolClick(Sender: TObject);
var
  arrDupCtr: TArrDupCtr;

Begin
  btnImpBol.Enabled := False;
  If qryTabela.IsEmpty Then
  Begin
    fMensagem('Aviso', 'É necessário carregar uma duplicata para impressão do boleto!', ['&O k']);
    btnImpBol.Enabled := True;
    Exit;
  End;

  If not fVerificaAcessoSistema('frmImpBoletosIndiv') Then
  Begin
    fMensagem('Aviso', 'Usuário sem permissão!', ['&O k']);
    btnImpBol.Enabled := True;
    Exit;
  End;

  If not fEmptyStr(qryTabela.FieldByName('CTR_NOSNUM').AsString) Then
  Begin
    fMensagem('Aviso', 'Já foi emitido boleto para a duplicata selecionada! Essa rotina não permite reimpressão!', ['&O k']);
    btnImpBol.Enabled := True;
    Exit;
  End;

  If qryTabela.FieldByName('CTR_BCOBOL').AsString.Equals('999') Then
  Begin
    fMensagem('Aviso', 'Já foi emitido duplicata mercantil para o título selecionado! Essa rotina não permite reimpressão!', ['&O k']);
    btnImpBol.Enabled := True;
    Exit;
  End;

  If Not (qryTabela.FieldByName('CTR_DTAREC').IsNull) Then
  Begin
    fMensagem('Aviso', 'Não é permitido imprimir boletos de duplicatas baixadas!', ['&O k']);
    btnImpBol.Enabled := True;
    Exit;
  End;

  If (qryTabela.FieldByName('CTR_VALDUP').AsFloat < 0) Then
  Begin
    fMensagem('Aviso', 'Não é permitido imprimir boletos de duplicatas negativas!', ['&O k']);
    btnImpBol.Enabled := True;
    Exit;
  End;

  If qryTabela.FieldByName('CTR_DTAVEN').AsDateTime < VS_Date Then
  Begin
    fMensagem('Aviso', 'Não é permitido a impressão de duplicatas vencidas!', ['&O k']);
    btnImpBol.Enabled := True;
    Exit;
  End;

  If Not qryTabela.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
  Begin
    If qryTabela.FieldByName('CTR_DTAREC').AsString.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO!', 'Duplicata com Pix gerado e ativo não pode ser gerado boleto. ' + #13#10 +
                            'Caso deseje gerar boleto para a duplicata, remova o Pix gerado!', ['&OK']);
      btnImpBol.Enabled := True;
      Exit;
    End;
  End;

  //MF: 282523 e 279633 - 15/05/2023
  If qryTabela.FieldByName('CTR_ESPDOC').AsString = 'NF' Then
  Begin
    If Not fVerificaContRecNFAutorizadaSefaz(qryTabela.FieldByName('CTR_NUMDUP').AsString,
                                             qryTabela.FieldByName('CTR_CODCLI').AsString,
                                             qryTabela.FieldByName('CTR_CODEMP').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'Este boleto não pode ser emitido, pois a nota fiscal não foi autorizada na SEFAZ. ' + #13#10 +
                            'Verifique a inconsistência no painel de notas fiscais e regularize para liberar esta operação.', ['&OK']);
      btnImpBol.Enabled := True;
      Exit;
    End;
  End;

  With qryTabela Do
  Begin
    If Not IsEmpty Then
    Begin
      SetLength(arrDupCtr,0);

      SetLength(arrDupCtr,Length(arrDupCtr)+1);
      arrDupCtr[Length(arrDupCtr)-1].strNumDup := FieldByName('CTR_NUMDUP').AsString;
      arrDupCtr[Length(arrDupCtr)-1].strEspDoc := FieldByName('CTR_ESPDOC').AsString;
      arrDupCtr[Length(arrDupCtr)-1].strCodEmp := FieldByName('CTR_CODEMP').AsString;
      arrDupCtr[Length(arrDupCtr)-1].strCodCli := FieldByName('CTR_CODCLI').AsString;
      arrDupCtr[Length(arrDupCtr)-1].strParcel := FieldByName('CTR_PARCEL').AsString;
      arrDupCtr[Length(arrDupCtr)-1].strAutoIn := FieldByName('AUTOINCREM').AsString;

      If Length(arrDupCtr) > 0 Then
      Begin
        TBoleto.fImprimirBoletos(arrDupCtr,
                                 False,
                                 True,
                                 'Deseja gerar o boleto?',
                                 self.Name,
                                 '',
                                 '',
                                 True);
        qryTabela.Refresh;
        pCarregaBanco;
      End;
      SetLength(arrDupCtr,0);
    End;
  End;
  btnImpBol.Enabled := True;
End;

procedure TfrmCadCtaReceber.btnImprimirClick(Sender: TObject);
begin
  inherited;
  If qryTabela.IsEmpty Then
  Begin
    fMensagem('AVISO', 'Favor escolher um registro para essa operação!', ['&Ok']);
    Exit;
  End;

  If Not Assigned(frmQckCtrDuplicata) Then
     pCriarFormularios(TfrmQckCtrDuplicata,frmQckCtrDuplicata);

  frmQckCtrDuplicata.ImprimeDup(qryTabela.FieldByName('AUTOINCREM').AsString, qryTabela.FieldByName('CTR_CODEMP').AsString, Self.Name);
end;

procedure TfrmCadCtaReceber.pCarregaCentroCusto;
begin
  fraPlanoDeContas.edtDesCta.Text := '';
  If not fEmptyStr(fraPlanoDeContas.dbeCodCta.Text) Then
  begin
    pPesquisaCadCta(qryConCta, qryConCta, fraPlanoDeContas.dbeCodCta.Text);
    With qryConCta Do
    Begin
      fraPlanoDeContas.edtDesCta.Text := FieldByName('CTA_DESCTA').AsString;
    End;
  end;

end;

function TfrmCadCtaReceber.fraPlanoDeContasdbeCodCtaChamaCadastro(
  Key: Word): string;
begin
  inherited;
  Result := fChamaCadCta(Key);
end;

procedure TfrmCadCtaReceber.fraPlanoDeContasdbeCodCtaKeyPress(Sender: TObject;
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
    If fPesqCentroCusto(Self, fraPlanoDeContas.dbeCodCta, fraPlanoDeContas.edtDesCta, Nil, Key, arrCentroCusto) Then
    Begin
      If (fValidaCampos(fraPlanoDeContas.dbeCodCta, True)) Then
        Self.SelectNext(ActiveControl, True, True);
      pCarregaCentroCusto;
    End;
  End;

end;

function TfrmCadCtaReceber.fRetornaDtaVenLogCtr(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli: String): TDateTime;
Var
  strSQL: String;
  qryGen: TUniQuery;
  dspGen: TUniDataSetProvider;
  cdsGen: TUniClientDataSet;

  dtaDtaVen: TDateTime;
  dtaDtaRec: TDateTime;
Begin
  Try

    qryGen := fCriaQuery(Self);
    dspGen := TUniDataSetProvider.Create(Self);
    cdsGen := TUniClientDataSet.Create(Self);
    cdsGen.DisableControls;
    cdsGen.FetchOnDemand := False;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '     CTR_DTAVEN AS DTAVEN, ';
    strSQL := strSQL + '     CTR_DTAREC AS DTAREC  ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   LOGCTR ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '   CTR_DESCRI IN ("BAIXA PARCIAL","INCLUSÃO","BAIXA PARCIAL LD","INCLUSÃO LD") ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      Open;
    End;

    pSetaClient(qryGen);

    dspGen.DataSet := qryGen;
    cdsGen.Close;
    cdsGen.SetProvider(dspGen);
    cdsGen.Open;

    cdsGen.IndexFieldNames := 'DTAVEN';
    cdsGen.Last;

    dtaDtaVen := cdsGen.fieldbyname('DTAVEN').AsDateTime;

    cdsGen.IndexFieldNames := 'DTAREC';
    cdsGen.Last;

    dtaDtaRec := cdsGen.fieldbyname('DTAREC').AsDateTime;

    If cdsGen.IsEmpty Then
      Result := dtaDtaVenOld
    Else
    Begin
      If dtaDtaVen > dtaDtaRec Then
        Result := dtaDtaVen
      Else
        Result := dtaDtaRec;
    End;

  Finally
    FreeAndNil(qryGen);
    FreeAndNil(dspGen);
    FreeAndNil(cdsGen);
  End;
End;

function TfrmCadCtaReceber.fSenhaAlteracaoValorDuplicata: Boolean;
Var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
  strNTrava : String;
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddSeparador(99);
  objLiberacao.objMsgLibera.pAddTexto('ALTERAÇÃO DO VALOR DA DUPLICATA', alCentro, teAmbos, '', 99);
  objLiberacao.objMsgLibera.pAddSeparador(99);
  objLiberacao.objMsgLibera.pAddTextoCaption('NOVO VALOR: ', 'R$ ' + dbeValDup.Text, 0, alEsquerda, teAmbos, '', 99);

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DUPLICATA'         , 19 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'           , 33 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'DT. CAD.'          , 12 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT. VENC.'         , 12 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'VR.DUPLICATA'      , 12 , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);


  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlValor;
  objLinha.pAddColuna('DUPLICATA'         , dbeNumDup.text + dbeParcel.Text + '-' + dbeEspDoc.Text                       , 19 , alEsquerda );
  objLinha.pAddColuna('CLIENTE'           , dbeCodCli.Text + '-' + edtNomCli.Text                                        , 33 , alEsquerda );
  objLinha.pAddColuna('DT. CAD.'          , FormatDateTime('dd/mm/yyyy', qryTabela.FieldByName('CTR_DTACAD').AsDateTime) , 12 , alCentro   );
  objLinha.pAddColuna('DT. VENC.'         , FormatDateTime('dd/mm/yyyy', qryTabela.FieldByName('CTR_DTAVEN').AsDateTime) , 12 , alCentro   );
  objLinha.pAddColuna('VR.DUPLICATA'      , FormatFloat('#,###,##0.00', qryTabela.FieldByName('CTR_VALDUP').OldValue)     , 12 , alDireita  );
  objTabela.lstLinhas.Add(objLinha);

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.objMsgLibera.pAddTexto('NECESSÁRIO INFORMAÇÃO DE SENHA', alCentro, teAmbos, '', 99);
  objLiberacao.objMsgLibera.pAddSeparador(99);
  objLiberacao.objMsgLibera.pAddTextoCaption('EMPRESA  SOLICITANTE: ', VS_strCodEmp);
  objLiberacao.objMsgLibera.pAddTextoCaption('OPERADOR SOLICITANTE: ', strLoginUsuarioLogado + ' - ' +strDescriUsuarioLogado);

  objLiberacao.strDirAce := 'CTRALTVALDUP';
  objLiberacao.strMsgSen := 'Permitir Alterar o Valor da Duplicata';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := fMensagemLiberacao(objLiberacao, strNTrava, nil);
end;

function TfrmCadCtaReceber.fSenhaAlteracaoVencimentoDuplicata: Boolean;
Var
  objTabela : TRegistroMsgLiberaTabela;
  objLinha  : TLinhaMsgLibera;
  strNTrava : String;
begin
  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddSeparador(99);
  objLiberacao.objMsgLibera.pAddTexto('ALTERAÇÃO DA DATA VENCIMENTO DA DUPLICATA', alCentro, teAmbos, '', 99);
  objLiberacao.objMsgLibera.pAddSeparador(99);
  objLiberacao.objMsgLibera.pAddTextoCaption('NOVO VENCIMENTO: ', dbeDtaVen.Text, 0, alEsquerda, teAmbos, '', 99);

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DUPLICATA'         , 19 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'EMPRESA'           , 03 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'           , 33 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'VAL.ORIGINAL'      , 12 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'VAL. JUROS'        , 12 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'VAL. ATUAL'        , 12 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'DT. CAD.'          , 11 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'VENC. ANT.'        , 11 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'NOVO VENC.'        , 11 , alCentro   , teAutcom);
  objTabela.lstLinhas.Add(objLinha);


  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlValor;
  objLinha.pAddColuna('DUPLICATA'         , dbeNumDup.text + dbeParcel.Text + '-' + dbeEspDoc.Text                       , 19 , alEsquerda );
  objLinha.pAddColuna('EMPRESA'           , dbeCodEmp.Text                                                               , 03 , alEsquerda );
  objLinha.pAddColuna('CLIENTE'           , dbeCodCli.Text + '-' + edtNomCli.Text                                        , 33 , alEsquerda );
  objLinha.pAddColuna('VAL.ORIGINAL'      , FormatFloat('#,###,##0.00', qryTabela.FieldByName('CTR_VALORI').AsFloat)     , 12 , alDireita  );
  objLinha.pAddColuna('VAL. JUROS'        , FormatFloat('#,###,##0.00', qryTabela.FieldByName('CTR_JURSUJ').AsFloat)     , 12 , alDireita  );
  objLinha.pAddColuna('VAL. ATUAL'        , FormatFloat('#,###,##0.00', qryTabela.FieldByName('CTR_VALDUP').AsFloat)     , 12 , alDireita  );
  objLinha.pAddColuna('DT. CAD.'          , FormatDateTime('dd/mm/yyyy', qryTabela.FieldByName('CTR_DTACAD').AsDateTime) , 11 , alCentro   );
  objLinha.pAddColuna('VENC. ANT.'        , FormatDateTime('dd/mm/yyyy', qryTabela.FieldByName('CTR_DTAVEN').OldValue)   , 11 , alCentro   );
  objLinha.pAddColuna('NOVO VENC.'        , dbeDtaVen.Text                                                               , 11 , alCentro   );
  objTabela.lstLinhas.Add(objLinha);

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.objMsgLibera.pAddTexto('NECESSÁRIO INFORMAÇÃO DE SENHA', alCentro, teAmbos, '', 99);
  objLiberacao.objMsgLibera.pAddSeparador(99);
  objLiberacao.objMsgLibera.pAddTextoCaption('EMPRESA  SOLICITANTE: ', VS_strCodEmp);
  objLiberacao.objMsgLibera.pAddTextoCaption('OPERADOR SOLICITANTE: ', strLoginUsuarioLogado + ' - ' +strDescriUsuarioLogado);

  objLiberacao.strDirAce := 'CTRALTVENDUP';
  objLiberacao.strMsgSen := 'Permitir Alterar a data de vencimento da Duplicata';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  Result := fMensagemLiberacao(objLiberacao, strNTrava, nil);
end;

function TfrmCadCtaReceber.fSenhaPortador: Boolean;
  Var
    strPortador: String;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha  : TLinhaMsgLibera;
    strNTrava : String;
begin
  If qryTabela.FieldByName('CTR_CODPOR').OldValue = Null Then
    strPortador := ''
  Else
    strPortador := qryTabela.FieldByName('CTR_CODPOR').OldValue + '-' + fRetNomPortador(qryTabela.FieldByName('CTR_CODPOR').OldValue);

  objLiberacao.Clear;
  objLiberacao.objMsgLibera.pAddTexto('>> ALTERAÇÃO DO PORTADOR APÓS BOLETO EMITIDO <<');
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddSeparador(121);
  objLiberacao.objMsgLibera.pAddTexto('ACESSO A ALTERAÇÃO DE PORTADOR APÓS BOLETO EMITIDO', alCentro, teAmbos, '', 121);
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddTextoCaption('NOVO PORTADOR', Copy(dbeCodPor.Text + '-' + edtNomPor.Text,1,80), 0, alCentro, teAmbos, '', 121);
  objLiberacao.objMsgLibera.pAddQuebra;

  objTabela := TRegistroMsgLiberaTabela.Create;

  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlCabecalho;
  objLinha.pAddColuna(''  , 'DUPLICATA'         , 19 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'CLIENTE'           , 33 , alEsquerda , teAutcom);
  objLinha.pAddColuna(''  , 'DT. CAD.'          , 12 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'DT. VENC.'         , 12 , alCentro   , teAutcom);
  objLinha.pAddColuna(''  , 'VR.DUPLICATA'      , 12 , alDireita  , teAutcom);
  objLinha.pAddColuna(''  , 'PORTADOR ORIGINAL' , 20 , alDireita  , teAutcom);
  objTabela.lstLinhas.Add(objLinha);


  objLinha  := TLinhaMsgLibera.Create;
  objLinha.enuTipoLinha := tlValor;
  objLinha.pAddColuna('DUPLICATA'         , dbeNumDup.text + dbeParcel.Text + '-' + dbeEspDoc.Text                       , 19 , alEsquerda );
  objLinha.pAddColuna('CLIENTE'           , dbeCodCli.Text + '-' + edtNomCli.Text                                        , 33 , alEsquerda );
  objLinha.pAddColuna('DT. CAD.'          , FormatDateTime('dd/mm/yyyy', qryTabela.FieldByName('CTR_DTACAD').AsDateTime) , 12 , alCentro   );
  objLinha.pAddColuna('DT. VENC.'         , FormatDateTime('dd/mm/yyyy', qryTabela.FieldByName('CTR_DTAVEN').AsDateTime) , 12 , alCentro   );
  objLinha.pAddColuna('VR.DUPLICATA'      , FormatFloat('#,###,##0.00', qryTabela.FieldByName('CTR_VALDUP').AsFloat)     , 12 , alDireita  );
  objLinha.pAddColuna('PORTADOR ORIGINAL' , strPortador                                                                  , 20 , alDireita  );
  objTabela.lstLinhas.Add(objLinha);

  objLiberacao.objMsgLibera.lstRegistros.Add(objTabela);

  objLiberacao.objMsgLibera.pAddTexto('NECESSÁRIO INFORMAÇÃO DE SENHA', alCentro, teAmbos, '', 121);
  objLiberacao.objMsgLibera.pAddSeparador(121);
  objLiberacao.objMsgLibera.pAddQuebra;
  objLiberacao.objMsgLibera.pAddTextoCaption('>> EMPRESA  SOLICITANTE', VS_strCodEmp);
  objLiberacao.objMsgLibera.pAddTextoCaption('>> OPERADOR SOLICITANTE', strLoginUsuarioLogado + ' - ' +strDescriUsuarioLogado);

  objLiberacao.strDirAce := 'ALTPORBOL';
  objLiberacao.strMsgSen := 'Senha para alteração de portador da duplicata';
  objLiberacao.strCodOpe := strLoginUsuarioLogado;

  objLiberacao.pInformaNumDocEspDocCodEmp(
                  dbeNumDup.text,
                  dbeEspDoc.text,
                  dbeCodEmp.text);

  Result := fMensagemLiberacao(objLiberacao, strNTrava, nil);
end;

procedure TfrmCadCtaReceber.dbeHisto1KeyPress(Sender: TObject;
  var Key: Char);
  Var
    strKey: String;
begin
  inherited;
  strKey := Key;
  strKey := AnsiUpperCase(strKey);
  Key := strKey[1];
end;

procedure TfrmCadCtaReceber.dbeLinhaDigitavelChange(Sender: TObject);
begin
  inherited;
  btnCopiaLinhaDigitada.enabled := not fEmptyStr(dtsTabela.DataSet.FieldByName('CTR_LINDIG').AsString);
end;

procedure TfrmCadCtaReceber.dbeNosNumKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  {***************************}
  {*****ESPAÇOS EM BRANCO*****}
  {***************************}
  If (Key = #32 ) Then
  Begin
    Key:= #0;
    fMensagem('ATENÇÃO!', 'Não é permetido espaços em branco no "Nosso Número"!',['&O k']);
  End;

end;

procedure TfrmCadCtaReceber.dbeNumDupChange(Sender: TObject);
begin
  inherited;
  btnCopiaLinhaDigitada.enabled := not fEmptyStr(dtsTabela.DataSet.FieldByName('CTR_LINDIG').AsString);
end;

procedure TfrmCadCtaReceber.dbeValDupExit(Sender: TObject);
begin
  blnExitValDup := True;
  inherited;
  pCalculaValorTotal();
  fValidaCampos(dbeValDup);
  blnExitValDup := False;
  HabilitarCampoProjeto;
end;

function TfrmCadCtaReceber.DeveTravarAlteracaoNossoNumero: Boolean;
begin
  If fCfgSis('PER_NN', varBoolean) Then
    Exit(False);

  If qryTabela.FieldByName('CTR_NOSNUM').Value = qryTabela.FieldByName('CTR_NOSNUM').OldValue Then
    Exit(False);

  Result := Not qryTabela.FieldByName('CTR_NOSNUM').AsString.IsEmpty;
  If Result Then
    Result := qryTabela.FieldByName('CTR_CARTEI').AsString.IsEmpty;
end;

function TfrmCadCtaReceber.DigitoVerificadorNossoNumero(ANossoNumero: String): String;
var
  I, Mult, Tot: Integer;
begin
  Tot  := 0;
  Mult := 2;

  for I := Length(ANossoNumero) downto 1 do
  begin
    Tot := Tot + (StrToInt(ANossoNumero[I]) * Mult);
    Inc(Mult);
    if Mult > 9 then Mult := 2;
  end;

  Tot := 11 - (Tot mod 11);

  if Tot > 9 then Result := 'X'
  Else Result := IntToStr(Tot);

end;

procedure TfrmCadCtaReceber.dtsTabelaDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  btnCopiaCPFCNPJ.enabled := not fEmptyStr(dtsTabela.DataSet.FieldByName('CTR_CODCLI').AsString);
  btnReenviarRelAgrup.enabled := dtsTabela.DataSet.FieldByName('CTR_ESPDOC').asstring = 'AG';
  btnAcompEntrega.Enabled := not dtsTabela.DataSet.IsEmpty;
end;

procedure TfrmCadCtaReceber.dtsTabelaStateChange(Sender: TObject);
begin
  inherited;
  if Assigned(qrytabela) And Assigned(qryConPor) And (Not qryConPor.isEmpty) then
    btnImpBol.Enabled := (qryTabela.State in [dsBrowse]) And (qryConPor.FieldByName('POR_IMPBOL').AsString = 'S');
end;

function TfrmCadCtaReceber.DuplicataCCFoiGeradaPorUmaBaixa(
  out ADocumentosEstornar: String): Boolean;
  Var
    LConsulta: TUniQuery;

    LSequencialControle,
    LEmpresaBaixa: String;

    LDataBaixa: TDateTime;

    LContador: Integer;
begin
  Result := False;

  If Not qryTabela.FieldByName('CTR_ESPDOC').AsString.Equals('CC') Then
    Exit;

  If qryTabela.FieldByName('CTR_VALORI').AsFloat > 0 Then
    Exit;

  ADocumentosEstornar := EmptyStr;

  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Text := 'SELECT CTR_SEQCON, CTR_CODEMP, CTR_DTACAD ' +
                          'FROM LOGCTR ' +
                          'WHERE CTR_NUMDUP = :NUMDUP ' +
                          '  AND CTR_PARCEL = :PARCEL ' +
                          '  AND CTR_ESPDOC = :ESPDOC ' +
                          '  AND CTR_CODEMP = :CODEMP ' +
                          '  AND CTR_CODCLI = :CODCLI ' +
                          '  AND CTR_SEQBAI = 0 ' +
                          '  AND CTR_DESCRI IN("INCLUSÃO","INCLUSÃO LD")' +
                          '  AND CTR_SEQCON>0';

    LConsulta.ParamByName('NUMDUP').AsString := qryTabela.FieldByName('CTR_NUMDUP').AsString;
    LConsulta.ParamByName('PARCEL').AsString := qryTabela.FieldByName('CTR_PARCEL').AsString;
    LConsulta.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('CTR_ESPDOC').AsString;
    LConsulta.ParamByName('CODEMP').AsString := qryTabela.FieldByName('CTR_CODEMP').AsString;
    LConsulta.ParamByName('CODCLI').AsString := qryTabela.FieldByName('CTR_CODCLI').AsString;
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    LSequencialControle := LConsulta.FieldByName('CTR_SEQCON').AsString;
    LEmpresaBaixa := LConsulta.FieldByName('CTR_CODEMP').AsString;
    LDataBaixa := LConsulta.FieldByName('CTR_DTACAD').AsDateTime;

    LConsulta.Close;

    LConsulta.SQL.Text := 'SELECT CONCAT(CTR_NUMDUP, CTR_PARCEL, "-", CTR_ESPDOC, "-", CTR_CODEMP) AS DUPLICATA ' +
                          'FROM CADREC ' +
                          'WHERE CTR_SEQCON = :SEQCON ' +
                          '  AND CTR_EMPBAI = :EMPBAI ' +
                          '  AND CTR_DTABAI = :DTABAI ' +
                          'UNION ' +
                          'SELECT CONCAT(ADT_NUMDOC, "A-", ADT_ESPDOC, "-", ADT_CODEMP) AS DUPLICATA ' +
                          'FROM ADTCLI ' +
                          'WHERE ADT_SEQCON = :SEQCON ' +
                          '  AND ADT_EMPLAN = :EMPBAI ' +
                          '  AND ADT_DTALAN = :DTABAI ' +
                          '  AND ADT_ORIGEM = "CTR" ';

    LConsulta.ParamByName('SEQCON').AsInteger := StrToInt64(LSequencialControle);
    LConsulta.ParamByName('EMPBAI').AsString := LEmpresaBaixa;
    LConsulta.ParamByName('DTABAI').AsDateTime := LDataBaixa;
    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;

    LContador := 0;
    While Not LConsulta.Eof Do
    Begin
      If LContador >= 4 Then
      Begin
        ADocumentosEstornar := ADocumentosEstornar + '...,';
        Break;
      End;

      ADocumentosEstornar := ADocumentosEstornar +
                             LConsulta.FieldByName('DUPLICATA').AsString + ',';

      Inc(LContador);

      LConsulta.Next;
    End;

    If Not ADocumentosEstornar.IsEmpty Then
      ADocumentosEstornar := LeftStr(ADocumentosEstornar, ADocumentosEstornar.Length - 1);
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

procedure TfrmCadCtaReceber.edtCodPrjKeyPress(Sender: TObject; var Key: Char);
  Var
    arrPrj : TConsultasArray;
begin
  If fPesqProjetos(Self, edtCodPrj, edtDesPrj, nil, Key, arrPrj) Then
  Begin
    If fValidaCampos(edtCodPrj, True) Then
      Self.SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadCtaReceber.edtValRecChange(Sender: TObject);
begin
  inherited;
  btnDetalharValoresBaixa.Enabled := (fStrToFloat(edtValRec.Text) <> 0);
end;

function TfrmCadCtaReceber.ExisteDuplicataParaRemessa: Boolean;
Var
  LCadCbi : TUniQuery;
Begin
  LCadCbi := fCriaQuery(nil);
  Try

    LCadCbi.Close;
    LCadCbi.SQL.Clear;
    LCadCbi.SQL.Text := ' SELECT                        '+
                        '   1                           '+
                        ' FROM                          '+
                        '   CADCBI                      '+
                        ' WHERE CBI_NUMDUP = :NUMDUP    '+
                        '   AND CBI_PARCEL = :PARCEL    '+
                        '   AND CBI_ESPDOC = :ESPDOC    '+
                        '   AND CBI_CODCLI = :CODCLI    '+
                        '   AND CBI_CODEMP = :CODEMP     ';

    LCadCbi.ParamByName('NUMDUP').AsString := qryTabela.FieldByName('CTR_NUMDUP').AsString;
    LCadCbi.ParamByName('PARCEL').AsString := qryTabela.FieldByName('CTR_PARCEL').AsString;
    LCadCbi.ParamByName('ESPDOC').AsString := qryTabela.FieldByName('CTR_ESPDOC').AsString;
    LCadCbi.ParamByName('CODCLI').AsString := qryTabela.FieldByName('CTR_CODCLI').AsString;
    LCadCbi.ParamByName('CODEMP').AsString := qryTabela.FieldByName('CTR_CODEMP').AsString;

    LCadCbi.Open;

    Result := Not LCadCbi.IsEmpty;
  Finally
    FreeAndNil(LCadCbi);
  End;
End;

procedure TfrmCadCtaReceber.TituloEnviadaAoBanco;
begin
  If qryTabela.FieldByName('CTR_DTAENV').IsNull Then
  Begin
    lblTitEnv.Caption := 'NÃO';
    lblTitEnv.Font.Color := clRed;
  End
  Else If ExisteDuplicataParaRemessa Then
  Begin
    lblTitEnv.Caption := 'PENDENTE';
    lblTitEnv.Font.Color := clYELLOW;
  End
  Else
  Begin
    lblTitEnv.Caption := 'SIM';
    lblTitEnv.Font.Color := clGreen;
  End;
end;

procedure TfrmCadCtaReceber.dbeBcoBolKeyPress(Sender: TObject;
  var Key: Char);
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

procedure TfrmCadCtaReceber.pCalculaValorTotal;
begin
  If fEmptyStr(qryTabela.FieldByName('CTR_DTAREC').AsString) And
     ((qryTabela.RecordCount >= 1) Or (qryTabela.State = dsInsert)) Then
  Begin
    edtValTot.Visible := True;
    lblValTot.Visible := True;

    edtValTot.Text := FloatToStrF(qryTabela.FieldByName('CTR_VALDUP').AsFloat +
                                  qryTabela.FieldByName('CTR_JURSUJ').AsFloat -
                                  qryTabela.FieldByName('CTR_DESSUJ').AsFloat +
                                  qryTabela.FieldByName('CTR_DESCOB').AsFloat, ffNumber, 12, 2);
  End
  Else
  Begin
    edtValTot.Visible := False;
    lblValTot.Visible := False;
  End;
end;

procedure TfrmCadCtaReceber.pCarregaBanco;
begin

  pPesquisaCadBco(qryCadBco, qryCadBco, dbeBcoBol.Text);
  edtNomBan.Text := qryCadBco.FieldByName('BCO_NOMBCO').AsString;

  if (not fEmptyStr(dbeBancoBoleto.Text)) then
  begin
    pPesquisaCadBco(qryCadBco, qryCadBco, dbeBancoBoleto.Text);
    edtNomBanBoleto.Text := qryCadBco.FieldByName('BCO_NOMBCO').AsString;
  end else
    edtNomBanBoleto.Text := '';

end;

function TfrmCadCtaReceber.fAlterouValor(chaveDuplicata: String;
  valorAtual: Double): Boolean;
Var
  qryBuscaBoleto:TUniQuery;
begin
  qryBuscaBoleto := fCriaQuery(Nil);
  with qryBuscaBoleto do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT SQL_NO_CACHE ');
    SQL.Add(' CTR_VALDUP ');
    SQL.Add(' FROM CADREC ');
    SQL.Add(' WHERE AUTOINCREM = ' + QuotedStr(chaveDuplicata));

    Open;

    Result := FieldByName('CTR_VALDUP').AsFloat <> valorAtual;
  end;

  FreeAndNil(qryBuscaBoleto);

end;

function TfrmCadCtaReceber.fAlterouVencimento(chaveDuplicata,
  dtaVen: String): Boolean;
Var
  qryBuscaBoleto:TUniQuery;
begin
  qryBuscaBoleto := fCriaQuery(Nil);
  with qryBuscaBoleto do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT SQL_NO_CACHE ');
    SQL.Add(' CTR_DTAVEN ');
    SQL.Add(' FROM CADREC ');
    SQL.Add(' WHERE AUTOINCREM = ' + QuotedStr(chaveDuplicata));

    Open;

    Result := FieldByName('CTR_DTAVEN').AsString <> dtaVen;
  end;

  FreeAndNil(qryBuscaBoleto);

end;

function TfrmCadCtaReceber.fCtrExisteDupDependentes(strNumDup, strParcel, strEspDoc,
  strCodEmp, strCodCli: String): Boolean;
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
    SQL.Add('  CADREC ');
    SQL.Add('WHERE ');
    SQL.Add('  CTR_NUMDUP = :NUMDUP AND ');
    SQL.Add('  CTR_PARCEL = :PARCEL AND ');
    SQL.Add('  CTR_ESPDOC = :ESPDOC AND ');
    SQL.Add('  CTR_CODEMP = :CODEMP AND ');
    SQL.Add('  CTR_CODCLI = :CODCLI AND ');
    SQL.Add('  CTR_SEQBAI > 0 ');

    ParamByName('NUMDUP').AsString  := strNumDup;
    ParamByName('PARCEL').AsString  := strParcel;
    ParamByName('ESPDOC').AsString  := strEspDoc;
    ParamByName('CODEMP').AsString  := strCodEmp;
    ParamByName('CODCLI').AsString  := strCodCli;
    Open;


    Result := (FieldByName('QTD').AsInteger) > 0;

    Close;

  End;

  FreeAndNil(qryGenDup);
End;

function TfrmCadCtaReceber.fDocumentoVeioFaturamento(strNumDup, strEspDoc,
  strCodEmp, strCodCli, AParcel: String): Boolean;
  Var
    qryGenDup: TUniQuery;
Begin

  Result := False;

  If Not FblnExcluirFF Then
  Begin
    If Pos(strEspdoc, 'NF_IF_NS_') <= 0 Then
      Exit;
  End
  Else
  Begin
    If Pos(strEspdoc, 'NF_IF_NS_FF_') <= 0 Then
      Exit;
  End;

  Try
    qryGenDup := fCriaQuery(Nil);

    With qryGenDup Do
    Begin
      Close;
      SQL.Clear;

      SQL.Add('SELECT ');
      SQL.Add('  SUM(QTD) AS QTD ');
      SQL.Add('FROM ');
      SQL.Add(' ( ');

      SQL.Add('SELECT ');
      SQL.Add('  COUNT(*) AS QTD ');
      SQL.Add('FROM ');
      SQL.Add('  MOVGER ');
      SQL.Add('WHERE ');
      SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
      SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
      SQL.Add('  GER_CODEMP = :CODEMP AND ');
      SQL.Add('  GER_CODCLI = :CODCLI ');

      SQL.Add(' UNION ALL ');

      SQL.Add('SELECT ');
      SQL.Add('  COUNT(*) AS QTD ');
      SQL.Add('FROM ');
      SQL.Add('  NOTGER ');
      SQL.Add('WHERE ');
      SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
      SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
      SQL.Add('  GER_CODEMP = :CODEMP AND ');
      SQL.Add('  GER_CODCLI = :CODCLI ');

      SQL.Add(' ) AS TAB ');

      ParamByName('NUMDOC').AsString  := strNumDup;
      ParamByName('ESPDOC').AsString  := strEspDoc;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODCLI').AsString  := strCodCli;
      Open;


      Result := (FieldByName('QTD').AsInteger) > 0;

      Close;

    End;


    If Result Then
    Begin
      qryGenDup.Close;
      qryGenDup.SQL.Clear;
      qryGenDup.SQL.Text := '                                        '+
                            ' SELECT                                 '+
                            '   COUNT(*) AS QTD                      '+
                            ' FROM                                   '+
                            '   LOGCTR                               '+
                            ' WHERE CTR_NUMDUP = :NUMDUP             '+
                            '   AND CTR_PARCEL = :PARCEL             '+
                            '   AND CTR_ESPDOC = :ESPDOC             '+
                            '   AND CTR_CODCLI = :CODCLI             '+
                            '   AND CTR_CODEMP = :CODEMP             '+
                            '   AND CTR_DESCRI IN ("INCLUSÃO","INCLUSÃO LD")'+
                            '   AND CTR_NOMFRM <> "frmCadCtaReceber" ';

      qryGenDup.ParamByName('NUMDUP').AsString  := strNumDup;
      qryGenDup.ParamByName('ESPDOC').AsString  := strEspDoc;
      qryGenDup.ParamByName('CODEMP').AsString  := strCodEmp;
      qryGenDup.ParamByName('CODCLI').AsString  := strCodCli;
      qryGenDup.ParamByName('PARCEL').AsString  := AParcel;
      qryGenDup.Open;
      Result := (qryGenDup.FieldByName('QTD').AsInteger) > 0;
    End;


  Except
    On E: Exception Do
      pMensagensErro(E.Message,'');
  End;

  FreeAndNil(qryGenDup);
End;

function TfrmCadCtaReceber.fDocumentoRLComAdiantamentoBaixado(strNumDup,
  strEspDoc, strCodEmp, strCodCli: String): Boolean;
Var
  qryCadRec: TUniQuery;
Begin
  qryCadRec := fCriaQuery(Nil);
  Try
    qryCadRec.Close;
    qryCadRec.SQL.Clear;
    qryCadRec.SQL.Add('SELECT                     ');
    qryCadRec.SQL.Add('  COUNT(*) AS QTD          ');
    qryCadRec.SQL.Add('FROM                       ');
    qryCadRec.SQL.Add('  CADREC                   ');
    qryCadRec.SQL.Add('WHERE                      ');
    qryCadRec.SQL.Add('  CTR_CODEMP = :CODEMP AND ');
    qryCadRec.SQL.Add('  CTR_ESPDOC = :ESPDOC AND ');
    qryCadRec.SQL.Add('  CTR_NUMDUP = :NUMDUP AND ');
    qryCadRec.SQL.Add('  CTR_CODCLI = :CODCLI AND ');
    qryCadRec.SQL.Add('  CTR_DTABAI IS NOT NULL   ');

    qryCadRec.ParamByName('NUMDUP').AsString  := strNumDup;
    qryCadRec.ParamByName('ESPDOC').AsString  := strEspDoc;
    qryCadRec.ParamByName('CODEMP').AsString  := strCodEmp;
    qryCadRec.ParamByName('CODCLI').AsString  := strCodCli;

    qryCadRec.Open;

    Result := (qryCadRec.FieldByName('QTD').AsInteger) > 0;
  Finally
    qryCadRec.Close;
    FreeAndNil(qryCadRec);
  End;
End;

function TfrmCadCtaReceber.fDocumentoRLComParcelamento(strNumDup, strEspDoc,
  strCodEmp, strCodCli: String): Boolean;
Var
  qryEqlFat: TUniQuery;
Begin
  qryEqlFat := fCriaQuery(Nil);
  Try
    qryEqlFat.Close;
    qryEqlFat.SQL.Clear;
    qryEqlFat.SQL.Add('SELECT                     ');
    qryEqlFat.SQL.Add('  COUNT(EQF_NUMDOC) AS QTD ');
    qryEqlFat.SQL.Add('FROM                       ');
    qryEqlFat.SQL.Add('  EQLFAT                   ');
    qryEqlFat.SQL.Add('INNER JOIN CONEQL ON CONEQL.AUTOINCREM = EQF_SEQCON   ');
    qryEqlFat.SQL.Add('WHERE                      ');
    qryEqlFat.SQL.Add('  EQF_EMPDOC = :CODEMP AND ');
    qryEqlFat.SQL.Add('  EQF_ESPDOC = :ESPDOC AND ');
    qryEqlFat.SQL.Add('  EQF_NUMDOC = :NUMDUP AND ');
    qryEqlFat.SQL.Add('  EQL_CODCLI = :CODCLI     ');

    qryEqlFat.ParamByName('NUMDUP').AsString  := strNumDup;
    qryEqlFat.ParamByName('ESPDOC').AsString  := strEspDoc;
    qryEqlFat.ParamByName('CODEMP').AsString  := strCodEmp;
    qryEqlFat.ParamByName('CODCLI').AsString  := strCodCli;

    qryEqlFat.Open;

    Result := (qryEqlFat.FieldByName('QTD').AsInteger) > 1;
  Finally
    qryEqlFat.Close;
    FreeAndNil(qryEqlFat);
  End;
End;

function TfrmCadCtaReceber.fDocumentoJaUtilizado(strNumDup, strEspDoc, strCodEmp,
  strCodCli: String): Boolean;
Var
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);

  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT G.AUTOINCREM,');
    qryAux.SQL.Add('       L.CTR_NOMFRM AS NOMFRM');
    qryAux.SQL.Add('FROM               ');
    qryAux.SQL.Add('MOVGER G           ');
    qryAux.SQL.Add('INNER JOIN DEL_CADREC D');
    qryAux.SQL.Add('        ON G.GER_NUMDOC = D.CTR_NUMDUP');
    qryAux.SQL.Add('       AND G.GER_ESPDOC = D.CTR_ESPDOC');
    qryAux.SQL.Add('       AND G.GER_CODEMP = D.CTR_CODEMP');
    qryAux.SQL.Add('       AND G.GER_CODCLI = D.CTR_CODCLI');
    qryAux.SQL.Add('LEFT JOIN LOGCTR L');
    qryAux.SQL.Add('        ON L.CTR_NUMDUP = D.CTR_NUMDUP');
    qryAux.SQL.Add('       AND L.CTR_ESPDOC = D.CTR_ESPDOC');
    qryAux.SQL.Add('       AND L.CTR_CODEMP = D.CTR_CODEMP');
    qryAux.SQL.Add('       AND L.CTR_CODCLI = D.CTR_CODCLI');
    qryAux.SQL.Add('       AND L.CTR_DESCRI IN ("INCLUSÃO", "INCLUSÃO LD")');
    qryAux.SQL.Add('       AND L.CTR_NOMFRM = "frmCadCtaReceber"');
    qryAux.SQL.Add('WHERE G.GER_NUMDOC = :NUMDOC');
    qryAux.SQL.Add('  AND G.GER_ESPDOC = :ESPDOC');
    qryAux.SQL.Add('  AND G.GER_CODEMP = :CODEMP');
    qryAux.SQL.Add('  AND G.GER_CODCLI = :CODCLI');
    qryAux.SQL.Add('  AND D.CTR_SEQBAI = 0 ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDup;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;

    qryAux.Open;
    Result := ((Not qryAux.IsEmpty) and (qryAux.FieldByName('NOMFRM').IsNull));
    qryAux.Close;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function TfrmCadCtaReceber.fExcluiTodasParcelasAdiantamento(const strNumDup,
  strEspDoc, strCodEmp, strCodCli: String): Boolean;
  Var
    qryCadRec: TUniQuery;
    strChaveLck: String;
    stlChaveLck: TStringList;
begin
  Result := True;
  qryCadRec := fCriaQuery;
  stlChaveLck := TStringList.Create;
  Try
    Try
      qryCadRec.SQL.Add('SELECT * FROM CADREC');
      qryCadRec.SQL.Add('WHERE CTR_NUMDUP = :NUMDUP');
      qryCadRec.SQL.Add('  AND CTR_ESPDOC = :ESPDOC');
      qryCadRec.SQL.Add('  AND CTR_CODEMP = :CODEMP');
      qryCadRec.SQL.Add('  AND CTR_CODCLI = :CODCLI');
      qryCadRec.ParamByname('NUMDUP').AsString := strNumDup;
      qryCadRec.ParamByname('ESPDOC').AsString := strEspDoc;
      qryCadRec.ParamByname('CODEMP').AsString := strCodEmp;
      qryCadRec.ParamByname('CODCLI').AsString := strCodCli;
      qryCadRec.Open;

      qryCadRec.First;
      While Not qryCadRec.Eof Do
      Begin
        strChaveLck := strNomeTabela +
                       qryCadRec.FieldByName('CTR_NUMDUP').AsString +
                       qryCadRec.FieldByName('CTR_ESPDOC').AsString +
                       qryCadRec.FieldByName('CTR_CODEMP').AsString +
                       qryCadRec.FieldByName('CTR_CODCLI').AsString +
                       qryCadRec.FieldByName('CTR_PARCEL').AsString;

        If Not fLock_Unlock(strChaveLck, True, False) Then
        Begin
          fRollBack;
          pMensagemOk('A duplicata '+ qryCadRec.FieldByName('CTR_NUMDUP').AsString +'-'+ qryCadRec.FieldByName('CTR_PARCEL').AsString +
                      ' está sendo utilizada por outra estação: '+ fGetHostLock(strChaveLck));
          Exit(False);
        End;

        stlChaveLck.Add(strChaveLck);

        pGravaLogCtr(qryCadRec.FieldByName('AUTOINCREM').AsString, 'EXCLUSÃO', Self.Name);

        fVerificaIntegridade(Self.Name, strNomeTabela, qryCadRec);

        qryCadRec.Delete;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        fRollBack;
        pMensagensErro(E.Message, '[TfrmCadCtaReceber.fExcluiTodasParcelasAdiantamento]');
      End;
    End;
  Finally
    If Result Then
      For strChaveLck In stlChaveLck Do
        fLock_Unlock(strChaveLck, False);

    FreeAndNil(qryCadRec);
    FreeAndNil(stlChaveLck);
  End;
end;

function TfrmCadCtaReceber.fExecutaAntesDoDelete: Boolean;
begin
  Result := True;
  try
    FEspecieDocumento := qryTabela.FieldByName('CTR_ESPDOC').AsString;
    FCodigoCliente    := qryTabela.FieldByName('CTR_CODCLI').AsString;
    FNumeroControle   := qryTabela.FieldByName('CTR_NUMDUP').AsString +
                         qryTabela.FieldByName('CTR_PARCEL').AsString +
                         qryTabela.FieldByName('CTR_ESPDOC').AsString +
                         qryTabela.FieldByName('CTR_CODEMP').AsString;

    FChaveLck:= strNomeTabela +
                qryTabela.FieldByName('CTR_NUMDUP').AsString +
                qryTabela.FieldByName('CTR_ESPDOC').AsString +
                qryTabela.FieldByName('CTR_CODEMP').AsString +
                qryTabela.FieldByName('CTR_CODCLI').AsString +
                qryTabela.FieldByName('CTR_PARCEL').AsString;

    strNumDupDC := qryTabela.FieldByName('CTR_NUMDUP').AsString;
    strParcelDC := qryTabela.FieldByName('CTR_PARCEL').AsString;
    strEspDocDC := qryTabela.FieldByName('CTR_ESPDOC').AsString;
    strCodCliDC := qryTabela.FieldByName('CTR_CODCLI').AsString;
    strCodEmpDC := qryTabela.FieldByName('CTR_CODEMP').AsString;
    FSeqBaiDC := qryTabela.FieldByName('CTR_SEQBAI').AsInteger;

    pGravaLogCtr(qryTabela.FieldByName('AUTOINCREM').AsString, 'EXCLUSÃO', Self.Name);
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadCtaReceber.fExecutaAntesDoDelete]');
      Exit(False);
    End;
  end;
end;

function TfrmCadCtaReceber.fExisteChqGerador(chaveBusca: String): Boolean;
Var
  qryBuscaCheque:TUniQuery;
begin
  qryBuscaCheque := fCriaQuery(Nil);
  with qryBuscaCheque do
  begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT SQL_NO_CACHE ');
    SQL.Add(' CHQ_DUPDEV, CHQ_NUMCHQ ');
    SQL.Add(' FROM CADCHQ ');
    SQL.Add(' WHERE CHQ_DUPDEV = ' + QuotedStr(chaveBusca));

    Open;

    Result := (not FieldByName('CHQ_DUPDEV').IsNull);
    if result then
      setChqCadRec(FieldByName('CHQ_NUMCHQ').AsString);
  end;

  FreeAndNil(qryBuscaCheque);

end;

procedure TfrmCadCtaReceber.btnNFClick(Sender: TObject);
begin
  inherited;

  If qryTabela.IsEmpty Or (fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Por favor, escolha um registro para essa operação!', ['&O k']);
    Exit;
  End;

  pConsultaNotaFiscal;
end;

procedure TfrmCadCtaReceber.btnNossNumCompletoClick(Sender: TObject);
  Var
    LNossoNumero: String;
    LNossNumeroCompleto: String;
begin
  inherited;
  LNossNumeroCompleto := RetornaNossoNumeroCompleto;
  If Not fEmptyStr(LNossNumeroCompleto) Then
  Begin
    LNossoNumero   := dbeNosNum.Text;
    dbeNosNum.Text := LNossNumeroCompleto;
    dbeNosNum.SelectAll;
    dbeNosNum.CopyToClipboard;
    dbeNosNum.Text := LNossoNumero;
  End;
end;

procedure TfrmCadCtaReceber.btnNossNumCompletoMouseEnter(Sender: TObject);
  Var
    LNosNumCompleto : String;
begin
  inherited;
  LNosNumCompleto := RetornaNossoNumeroCompleto;
  If Not fEmptyStr(LNosNumCompleto) Then
  Begin
    ShowHint(btnNossNumCompleto,'Nosso número completo', 'Nosso número Completo: '+ LNosNumCompleto +#13#10+'Clique para cópiar!');
  End;
end;

procedure TfrmCadCtaReceber.btnNossNumCompletoMouseLeave(Sender: TObject);
begin
  inherited;
  HideHint;
end;

procedure TfrmCadCtaReceber.pConsultaNotaFiscal;
var
  documento: IDocumento;
begin
  inherited;

  documento := TDocumento.Create();
  documento.pImprimeNotaFiscal(qryTabela.FieldByName('AUTOINCREM').AsString);
end;

procedure TfrmCadCtaReceber.pConsultarAdintamento;
  Var
    qryAux : TUniQuery;
    strSQL : String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT                     ';
  strSQL := strSQL + '  ADT_NUMDOC              ';
  strSQL := strSQL + 'FROM                       ';
  strSQL := strSQL + '  ADTCLI                   ';
  strSQL := strSQL + 'WHERE ADT_CODCLI = :CODCLI ';
  strSQL := strSQL + '  AND ADT_SEQCON = :SEQCON ';
  strSQL := strSQL + '  AND ADT_CODEMP = :CODEMP ';

  qryAux := fCriaQuery();
  Try
    With qryAux Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := qryTabela.FieldByName('CTR_CODCLI').AsString;
      ParamByName('SEQCON').AsString := qryTabela.FieldByName('CTR_SEQCON').AsString;
      ParamByName('CODEMP').AsString := qryTabela.FieldByName('CTR_CODEMP').AsString;;
      Open;

      If Not isEmpty Then
        TAdiantamento.pConsultarAdiantamentos(strloginUsuarioLogado,
                                              qryAux.FieldByName('ADT_NUMDOC').AsString,
                                              qryTabela.FieldByName('CTR_CODEMP').AsString);
    End;
  Finally
    pFreeAndNil(qryAux);
  End;
end;

procedure TfrmCadCtaReceber.pConsultaBoleto;
var
  documento: IDocumento;
begin
  inherited;

  documento := TDocumento.Create;

  If documento.fImprimeBoleto(qryTabela.FieldByName('AUTOINCREM').AsString) Then
  Begin
    pCarregaDadosAdicionais;
    pCalculaValorTotal();
  End;
end;

procedure TfrmCadCtaReceber.btnBoletoClick(Sender: TObject);
begin
  inherited;

  If qryTabela.IsEmpty Or (fEmptyStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Por favor, escolha um registro para essa operação!', ['&O k']);
    Exit;
  End;

  if (qryTabela.State in [dsEdit]) then
  begin
    fMensagem('ATENÇÃO!',
              'Esta operação não pode ser realizada enquanto a duplicata estiver em edição.',
              ['&OK']);
    Exit;
  end;

  If (Not qryTabela.FieldByName('CTR_DTAREC').IsNull) Then
  Begin
    fMensagem('ATENÇÃO!', 'Esta operação só está disponível para títulos em aberto!', ['&O k']);
    Exit;
  End;

  //MF: 282523 e 279633 - 15/05/2023
  If qryTabela.FieldByName('CTR_ESPDOC').AsString = 'NF' Then
  Begin
    If Not fVerificaContRecNFAutorizadaSefaz(qryTabela.FieldByName('CTR_NUMDUP').AsString,
                                             qryTabela.FieldByName('CTR_CODCLI').AsString,
                                             qryTabela.FieldByName('CTR_CODEMP').AsString) Then
    Begin
      fMensagem('ATENÇÃO!', 'Este boleto não pode ser emitido, pois a nota fiscal não foi autorizada na SEFAZ. ' + #13#10 +
                            'Verifique a inconsistência no painel de notas fiscais e regularize para liberar esta operação.', ['&OK']);
      Exit;
    End;
  End;

  pConsultaBoleto;
end;

function TfrmCadCtaReceber.fGravaCreditoCliente(APortadorMovBan, APlanoDeContasMovBan: String; const AInserindo : Boolean): Boolean;
  Var
    lstBanCtr : TBanCtrRepository;
    strSeqLan : String;
begin
  Try
    lstBanCtr := TBanCtrRepository.Create;
    lstBanCtr.fAdd(qryTabela.FieldByName('CTR_NUMDUP').AsString,
                   qryTabela.FieldByName('CTR_PARCEL').AsString,
                   'CC',
                   qryTabela.FieldByName('CTR_CODEMP').AsString,
                   qryTabela.FieldByName('CTR_CODCLI').AsString,
                   fGetHistoricoLancamentoCredito,
                   '',
                   0,
                   qryTabela.FieldByName('CTR_VALDUP').AsFloat);

    strSeqLan := fGravaMovBan( APlanoDeContasMovBan,                                                        // Centro de Custo
                               APortadorMovBan,                                                             // Portador da Baixa
                               strLoginUsuarioLogado,                                                       // Operador da Baixa
                               qryTabela.FieldByName('CTR_DTACAD').AsDateTime,                              // Data do Lançamento
                               fTime(),                                                                     // Hora do Lançamento
                               qryTabela.FieldByName('CTR_NUMDUP').AsString,                                // Numero do Documento
                               'C',                                                                         // Credito / Debito
                               VS_strCodEmp,                                                                // Empresa da Baixa
                               qryTabela.FieldByName('CTR_VALDUP').AsFloat,                                 // Valor Do Lançamento
                               fGetHistoricoLancamentoCredito,                                                        // Histórico 1
                               '',                                                                          // Histórico 2
                               qryTabela.FieldByName('CTR_CODCLI').AsString,                                // Cliente da Duplicata
                               '',                                                                          // Fornecedor da Duplicata
                               qryTabela.FieldByName('CTR_NUMDUP').AsString,                                // Número da Duplicata
                               0,                                                                           // Sequencial de Baixa
                               qryTabela.FieldByName('CTR_PARCEL').AsString,                                // Parcela da Duplicata
                               qryTabela.FieldByName('CTR_CODEMP').AsString,                                // Empresa da Duplicata
                               '',                                                                          // Série
                               qryTabela.FieldByName('CTR_CODEVE').AsString,                                // Codigo do Evento
                               '',                                                                          // Documento da Baixa
                               lstBanCtr.fGetList                                                           // Log Bancário
                              );

    If (AInserindo) Then
      pAtualizarSequencialMovBanInclusaoCredito(qryTabela.FieldByName('AUTOINCREM').AsString, strSeqLan);

    Result := Not fEmptyStr(strSeqLan);

    if Result then
       untLogCba.pGravaLogCba(strSeqLan, 'INCLUSAO', self.Name);

    FreeAndNil(lstBanCtr);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar a movinebtação bancária. ' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

function TfrmCadCtaReceber.fGravaDebitoCliente: Boolean;
  Var
    lstBanCtr : TBanCtrRepository;
    strSeqLan : String;
begin
  Try
    pCarregaCreditoCliente;

    If qryGen.IsEmpty Then
      Exit(False);

    lstBanCtr := TBanCtrRepository.Create;
    lstBanCtr.fAdd(arrDupSel[0].strNumDoc,
                   arrDupSel[0].strParcel,
                   'CC',
                   arrDupSel[0].strCodEmp,
                   arrDupSel[0].strCodCli,
                   'REF. LANC. DÉBITO',
                   '',
                   0,
                   arrDupSel[0].fltVlrRec);


    strSeqLan := fGravaMovBan( qryGen.FieldByName('CODCTA').AsString,                                                        // Centro de Custo
                               qryGen.FieldByName('CODPOR').AsString,                                                         // Portador da Baixa
                               strLoginUsuarioLogado,                                                       // Operador da Baixa
                               VS_DATE,                                                                     // Data do Lançamento
                               fTime(),                                                                     // Hora do Lançamento
                               arrDupSel[0].strNumDoc,                                                      // Numero do Documento
                               'D',                                                                         // Credito / Debito
                               qryGen.FieldByName('CODEMP').AsString,                                       // Empresa da Baixa
                               arrDupSel[0].fltVlrRec,                                                      // Valor Do Lançamento
                               'REF. LANC. DÉBITO',                                                         // Histórico 1
                               '',                                                                          // Histórico 2
                               arrDupSel[0].strCodCli,                                                      // Cliente da Duplicata
                               '',                                                                          // Fornecedor da Duplicata
                               arrDupSel[0].strNumDoc,                                                      // Número da Duplicata
                               0,                                                                           // Sequencial de Baixa
                               arrDupSel[0].strParcel,                                                      // Parcela da Duplicata
                               arrDupSel[0].strCodEmp,                                                      // Empresa da Duplicata
                               '',                                                                          // Série
                               '',                                                                          // Codigo do Evento
                               '',                                                                          // Documento da Baixa
                               lstBanCtr.fGetList                                                           // Log Bancário
                              );
    Result := Not fEmptyStr(strSeqLan);

    if Result then
       untLogCba.pGravaLogCba(strSeqLan, 'EXCLUSAO DO RECEBER', self.Name);

    FreeAndNil(lstBanCtr);
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
      Result := False;
    End;
  End;
end;

procedure TfrmCadCtaReceber.btnConsultarAdiantamentosClick(Sender: TObject);
begin
  inherited;
  pConsultarAdintamento;
end;

procedure TfrmCadCtaReceber.btnCopiaCPFCNPJClick(Sender: TObject);
var
  sRetornoConsulta: string;
begin
  inherited;
  sRetornoConsulta := fRetCgcCpf(dbeCodCli.text);
  if fEmptyStr(sRetornoConsulta) then
  begin
    fMensagem('Atenção',
              'Não foi possível copiar o CPF/CNPJ do cliente porque ele não está preenchido no cadastro!',
              ['&OK']);
  end
  else
  begin
    Clipboard.AsText := sRetornoConsulta;
    fMensagem('Atenção',
              'CPF/CNPJ do Cliente copiado! Cole através do CTRL + V',
              ['&OK']);
  end;
end;

procedure TfrmCadCtaReceber.pDesvinculaContratoLocacao(strNumDup, strEspDoc, strCodCli, strCodEmp: String; fltValDup: Double);
var
  objCancelar: TCancelarContratoLocacao;
Begin
  objCancelar := TCancelarContratoLocacao.Create;
  Try
    objCancelar.fDesvinculaContratoLocacaoRL(strNumDup, strEspDoc, strCodCli, strCodEmp, fltValDup);
  Finally
    FreeAndNil(objCancelar);
  End;
end;

function TfrmCadCtaReceber.PermitirIncluirCreditoClienteComValorPositivo: Boolean;
begin
  Result := False;

  If Not (dbeEspDoc.Text = 'CC') Then
    Exit(True);

  If Not (fStrToFloat(dbeValDup.Text) > 0) Then
    Exit(True);

  If fCfgSis('CCPOSI', varBoolean) Then
    Exit(True);
end;

function TfrmCadCtaReceber.fDuplicataDeChequeTransferido(tipoDoc:String; chaveBusca: String): Boolean;
Var
  qryBuscaCheque:TUniQuery;
begin

  If tipoDoc <> 'CH' Then
    Exit(False);

  qryBuscaCheque := fCriaQuery(Nil);

  Try
    qryBuscaCheque.Close;
    qryBuscaCheque.SQL.Clear;
    qryBuscaCheque.SQL.Add(' SELECT CHQ_NUMCHQ ');
    qryBuscaCheque.SQL.Add(' FROM CADCHQ ');
    qryBuscaCheque.SQL.Add(' WHERE CHQ_DUPDEP = ' + QuotedStr(chaveBusca));
    qryBuscaCheque.Open;

    Result := qryBuscaCheque.FieldByName('CHQ_NUMCHQ').AsString <> '';

    If Result Then
      setChqCadRec(qryBuscaCheque.FieldByName('CHQ_NUMCHQ').AsString);

  Finally
    FreeAndNil(qryBuscaCheque);
  End;

end;

end.
