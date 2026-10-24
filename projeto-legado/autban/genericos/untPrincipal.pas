{************************************************}
{*                  ATENÇÃO                     *}
{************************************************}
{* O MENU QUE NÃO VAI TER LETRA ANTES TEM QUE   *}
{* COMEÇAR COM "MNU" OBRIGATÓRIAMENTE           *}
{*********************************************AF*}
{* TODAS AS CHAMADAS DO CONTAS A PAGAR DE FORMU_*}
{* LARIOS QUE SÃO COMUNS PARA RECEBER E A RAGAR *}
{* , TERÁ OBRIGATÓRIAMENTE QUE SER PASSADO O    *}
{* PARAMETRO STRTIPGER = P(CONTAS A PAGAR).     *}
{*********************************************AC*}
unit untPrincipal;

interface
{$WARN SYMBOL_PLATFORM OFF}
uses
  Windows, SysUtils, Types, Classes, Variants, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, StrUtils, Buttons, QColorLabel,
  Menus, UniClientDataSet, MidasLib, Uni, Vcl.AppEvnts, untLogBan, untLogTrace,
  System.Generics.Collections, untTypesSistema,
  untCNFOCO_Class, untCNFOCO_Dao, untTBanCTP, frxClass, dxGDIPlusClasses,
  untTBanCtpRepository, untTBanCtrRepository, Data.DB, untConfigRedasset, untExpArqRemRedasset,
  BitBtnLockedIncrem, untFechamentoFinanceiro,untFuncAutban,cxProgressBar,untTLock,
  System.Math,untLogMovCtr, untFrameMenuPrincipal,untLogAut,untTMonitorGeraBoletos,
  untTDDAMenu,untTOCOBANCache,untTDeleteRetBcoLote,untTInsertMovCtrLote,untTInsertLogMcrLote,
  untTUpdateBolCtrLote,untTUpdateDupCobLote,untProcessaAtualizacaoOcorrenciasCRM;
type
  TBaixa = Record
    strPortad: String;
    strCtaBai: String;
    dtaDtaLan: TDate;
    fltValCtb: Double;
  End;

Type
  TDadosGravacaoDeTarifa = Record
    strAutCtp,
    strSeqLan,
    strSeqPag          : String;
    intSeqConP         : Integer;
    fltTotalTarifa     : Double;
    dtaDtaOcoSintetica : TDate;
    arrDuplicatasTarifa: Array Of String;
    strDadosDuplicatas : String;
    AOcorrencia        : String;
  End;

type
  TRegDupMovCtr = Record
    intCont       : Integer;
    strAutoInc    : String;
  End;

type
  TReservaSequencial = Record
    Prefixo: String;
    Largura: Integer;
    Proximo,
    Restantes: Int64;
  End;

type
  TfrmPrincipal = class(TForm)
    stbStatus: TStatusBar;
    pnlRodape: TPanel;
    pnlImagem: TPanel;
    Image1: TImage;
    btnSair: TSpeedButton;
    tmrRelogio: TTimer;
    ApplicationEvents1: TApplicationEvents;
    tmrCertificadosExpirados: TTimer;
    FrameMenu: TfrmFrameMenuPrincipal;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pVerificaMenu;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pGeraVetor;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSairClick(Sender: TObject);
    procedure trvMenuKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure trvMenuDblClick(Sender: TObject);
    procedure tmrRelogioTimer(Sender: TObject);

    procedure pBaixaAtuDup(strCodBco: String; intCartei: Integer; strCarBco: String = '';
                           intTotalCarteiras: Integer = 1);
    procedure pBaixaAtuDupContasPagar(strCodBco: String; intCartei: Integer; strConfig: String = ''; AblnPGG : Boolean = False; ABancoAPI: Boolean = False);
    function fOcorrenciaContasAPagarValida(ACodigoBanco, AOcorrencia: string): Boolean;
    function fEhOcorrenciaPagamentoCondicaoTesteBradesco(ACodigoBanco, AOcorrencia: string): Boolean;
    procedure pGravaLogCtp(AAutoIncremCadPag, strDescricaoLog: String);
    procedure FormDestroy(Sender: TObject);

    function DeveAtualizarEventoEPortador(ACodigoBanco: String;
                                          AOcorrencia,
                                          AMotivo: String): Boolean;

    procedure tmrCertificadosExpiradosTimer(Sender: TObject);
  private

    qryGravaMovBan : TUniQuery;

    intDiaCred,
    FDiasParaCreditoOcorrencia12: Integer;
    dtaDtaLan,
    dtaDtaTar : TDateTime;

    blnBcoBra7d: Boolean;

    strCtaBai,
    strPorBai,
    strHisBai,
    strOpeBai,
    strCodEve,
    strForTar,
    strCtaTar,
    strPorTar,
    strPorDes: String;

    strRetAutIncMovBan: String; //Para fazer o vínculo do Movban

    objGravacaoTarifa: TDadosGravacaoDeTarifa;
    lstBanCtp        : TBanCtpRepository;

    intContadorCarteiras: Integer; //Determina a carteira atual da baixa

    cdsNaoBai: TUniClientDataSet;
    objFechamento: TFechamentoFinanceiro;
    blnUtlDesDup : Boolean;
    LConsiderarDescontoSugerido : Boolean;

    s033Oco10: Boolean;
    LQryRetBcoGer : TUniQuery; // Query que filtra toda a RETBCO do banco.
    LNomBanco : String;
    FBaixaEmpresaCadastro: Boolean;
    LCodBco : String;
    LOcoTar : String;
    objLock: TLock;

    stlRegMovBanSep: TStringList;
    arrRegMovBanSep: Array Of TBaixa;

    stlRegMovBanSepJur: TStringList;
    arrRegMovBanSepJur: Array Of TBaixa;

    stlRegMovBanSepDes: TStringList;
    arrRegMovBanSepDes: Array Of TBaixa;

    ArrGravaMovCarSep    : Array Of TRegDupMovCtr;
    ArrGravaMovCarSepJur : Array Of TRegDupMovCtr;
    ArrGravaMovCarSepDes : Array Of TRegDupMovCtr;

    lstBanCtrSep: array of TBanCtrRepository;
    lstBanCtrSepJur: array of TBanCtrRepository;
    lstBanCtrSepDes: array of TBanCtrRepository;

    { Private declarations }
    function GetValorPago(ACodBco: String; AValPag,ATarifa,AValDup : Double): Double;
    function fGravaMovBan(strCodCta,
                          strCodPor,
                          strCodOpe: String;
                          dtaDtaLan: TDateTime;
                          strNumDoc,
                          strCreDeb,
                          strCodEmp: String;
                          fltValLan: Double;
                          strHist01,
                          strHist02: String;
                          strCodCli,
                          strCodFor,
                          strNumDup: String;
                          intSeqBai: Integer;
                          strParcel,
                          strEmpDup,
                          strSerie,
                          strSeqLan,
                          strCodEve: String;
                          lstLogBan: TList<TLogBan>;
                          strCompet: String = '';
                          intPagCon: Integer = 0;
                          const AAutoIncMovBan: String = ''): String;
    procedure pRemoveNomeForms;
    function fAtualizaCodEve(qryUpdate: TUniQuery;
                             strTabela,
                             strCodEve,
                             strNumDup,
                             strParcel,
                             strEspDoc,
                             strCodEmp,
                             strCodCli: String;
                             intSeqBai: Integer;
                             strCodPor: String = ''): Boolean;
    function fUsaTabelaOCORET(qryCons: TUniQuery;
                              strCodBco: String): Boolean;
    function fRetornaCodEvento(qryCons: TUniQuery;
                               strCodOco,
                               strCodBco: String;
                               strMotOco : String = '';
                               icartei : Integer = 0): String;
    procedure pGravaHisRet(qryDados: TUniQuery; strNomBanco: String);
    procedure pRestaurarBoleto(AAutoIncremento, ACodigoBanco,
                               ANumeroDuplicata, AParcela, AEspecieDocumento,
                               ACodigoEmpresa, ACodigoCliente, ACodigoOcorrencia, AMotivoOcorrencia, ACnab : String);
    function fOcorrenciaParaRestaurarBoleto(AConfiguracaoCarteira : String; AOcorrencia : String): Boolean;
    procedure AtualizaDivergenciaRetBco(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli, strMotDiv: String; AComDivergencia: Boolean = True);
    procedure pApagaRetBco(strCodBco, strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli, strCodOco: String; strCNAB: String = ''; AMotOco: String = '');
    procedure pApagaRetCtp(strCodBco, strNumDup, strParcel, strSerie, strCodEmp, strCodFor: String);
    procedure pRelatorioNosNum(strCodBco: String = '');
    procedure pGravaTarifa(objCnfOco: TCnfOco;
                           strCodEmp: String;
                           fltValTar: Double;
                           dteDtaLan: TDate;
                           qryCadRec: TDataset;
                           AblnHistoricoEstorno: Boolean = False);
    function fGravaReceber(qryCadRec: TDataset;
                           fltValTar: Double ) : Boolean;

    function fRetRelatSQL: String;
    procedure pGravaNaoBai(qryRetBco,
                           qryCadRec: TUniQuery;
                           strDescri: String;
                           ATarifaCarteira: Double);
    procedure pMostraDupNBaixadas(strCodBco: String);
//    function fFiltraIndiceCarteiraBanco(strCodBco: String; strCartei: String): Boolean;

    function fRetSQLOcoBancos(strCodBco, strConfig, strOcoTar, AOcoRet, strValOco05: String): String;
    procedure pLancaTarifasAuxiliares(qryRetBco, qryCadRec: TUniQuery;
      objCnfDao: TCnfOcoDao; strCodBco: String; strOcoTar: String; intDiasCredito: Integer);
    function LancarTarifasNaLiquidacao(ACodBco,ACodOco: String): Boolean;
    function fSelecionaPortadorPlanodeContas(strConfig: String;
             cdsConRet: TUniClientDataSet; qryRetBco: TUniQuery): Boolean;

    function SelecionaPortadorPlanoDeContasPorRegistro(ACodBco,AConfig: String):Boolean;

    procedure pLancaTarifaDoBoletoAnalitico(qryRetBco, qryCadRec: TUniQuery; ATarifaTed: Double = 0; AConfiguracao:String = '');
    procedure pLancaTarifaDoBoletoSintetico(strCodBco: String);
    procedure pAtualizaAutoIncremTarifasBoletosEmAberto;

    procedure pGravaCtrBan(strAutCtr, strAutCtb, strAutCtp: String;
                           intTipDes: Integer = 2;
                           AOcorrencia: String = '';
                           AMotivo: String = '');
    function OcorrenciaSemVinculoCtrBan(AAutCtr, AOcorrencia, ABanco: String; AMotivo: String = ''): Boolean;

    procedure pIniciarBaixa(strCodBco: String);
    procedure EstornoDuplicataDescontadaParaCobrancaSimples(qryRetBco, qryCadRec: TUniQuery; AstrCodBco: String; objCnfDao: TCnfOcoDao; AintDiasCredito: integer);
    function RetornaPlanoContasParaBaixa(ABanco: String; ACartei: Integer; ABancoApi: Boolean = False): String;
    function RetornaPortadorParaBaixa(ABanco: String; ACartei: Integer; ABancoApi: Boolean = False): String;
    function FechamentoFinanceiroJaRealizado(ACarteira, ATotalCarteiras: Integer; ACarteiraBanco, ACodBanco, AReceberPagar: String): Boolean;
    function fEhBancoQueIgnoraOcorrenciaNaBaixa(strCodBco : String) : Boolean ;

    function ValidacaoParaLancamentoDeTarifaNaConfirmacao(APermitidoLancarTarifa: Boolean;
                                                          ADatasetRetBco,
                                                          ADatasetCadRec: TDataset): Boolean;

    procedure ValidaEAtualizaVersoesDLLsAPI;

    procedure AtualizaEventoPortador(ARetBco, AQryAux: TUniQuery; ACodBco: String);
    function MarcandoDuplicatas(pgbProgresso: TcxProgressBar): Boolean;
    function DesmarcandoDuplicatas(pgbProgresso: TcxProgressBar): Boolean;
    procedure pStepStatusSelecao(pgbStatus: TcxProgressBar);
    procedure LiberaDuplicatas;
    procedure MarcaDuplicatas;
    function LancamentoDeTarifa(ACodBco,ACodOco,AMotOco: String): Boolean;
    function VerificaSeOperadorPossuiDireitoABaixaNaEmpresa(AEmpresasComDireito: String): Boolean;
    function VerificaPermissaoParaBaixaEmEmpresaDiferenteDoCadastro: Boolean;
    procedure CalculaValorCorrigido(ARetBco:TDataSet);

    function fRetornaDataVenctoRetDet(strAutoincrem, strNomarq : String): TdateTime;

    function fGravaMovBanJurDescSeparadosAnalitico(strCtaBai, strPorBai,
      strOpeBai: String; dtaDtaLan, dtaHraLan: TDateTime; strNumdup, strParcel,
      strEspDoc, strCodEmp, strCodCli, strHist01, strHist02, strHisBai,
      strCodEve, strAutoIn: String; intSeqCon, intSeqBai: Integer; fltValLan, fltValJur,
      fltValDes: Double): String;

    function pGravaMovBanJuros(strPorBai, strOpeBai: String; dtaDtaLan,
      dtaHraLan: TDateTime; strNumdup, strParcel, strEspDoc, strCodEmp,
      strCodCli, strHist01, strHist02, strHisBai, strCodEve, strAutoIn: String; intSeqCon,
      intSeqBai: Integer; fltValJur: Double): String;

    procedure GravarMovCtr(const AAutoIncremContasReceber,
                                 ASequencialMovimentacaoBancaria,
                                 AEmpresaMovimentacaoBancaria: string);

    function fGravaMovBanDesconto(strPorBai, strOpeBai: String; dtaDtaLan,
      dtaHraLan: TDateTime; strNumdup, strParcel, strEspDoc, strCodEmp,
      strCodCli, strHist01, strHist02, strHisBai, strCodEve, strAutoIn: String; intSeqCon,
      intSeqBai: Integer; fltValDes: Double): String;

    function fMovBanJurDescSeparadosSintetico(strCtaBai, strPorBai,
      strOpeBai: String; dtaDtaLan, dtaHraLan: TDateTime; strNumdup, strParcel,
      strEspDoc, strCodEmp, strCodCli, strHist01, strHist02, strAutoIn: String;
      intSeqBai: Integer; fltValLan, fltValJur, fltValDes: Double) : String;

    Procedure pGravaMovBanSinteticoBanco(strOpeBai: String);
//    lstBanCtrS, lstBanCtrJ, lstBanCtrD: array of TBanCtrRepository ): String;

    procedure LimpaDadosDuplicatasBaixadasPeloBanco(AAutoIncremCadRec,
                                                    ACodigoBanco,
                                                    ACodigoOcorrencia: String);
    procedure pGravaVinculoCtr(strAutCtr, strAutCtr_Rastreio: String);
    function pRetornaAutoinVinculoCtr(strNumDup, strParcel, strEspDoc, strCodCli, strCodEmp: String): String;
    function VerificaVinculoTarifaLancada(AAutCtr: String): Boolean;

    function DeveAtualizarDespesaDeCobranca(APermite: Boolean;
                                            AValorDespesa: Double;
                                            ACodigoBanco,
                                            AConfiguracao: String): Boolean;
    procedure AtualizaDespesasDeCobranca(ADatasetCadRec,
                                         ADatasetRetBco: TDataset);

    procedure AtualizaQRCodeCADREC(AAutoIncremCadRec, AQRCodeRetBco : String);

    function fEhDocumentoDesCobJaAtualizado(strNumDup, strParcel, strEspDoc,
                                            strCodEmp, strCodCli, strNomArq,
                                            strCodBco: String; fltDesCob: Double;
                                            intCodOco: Integer): Boolean;
    function fGetDiasParaCreditoOcorrencia12(ABanco: String; ACarteira: Integer):Integer;
    procedure pGetDiasParaCreditoOcorrencia01(ABanco: String; ACodOco: String; ACarteira: Integer);

    function fRetornarListaOcoRet(ACodBco: string): string;
    Procedure AtualizaHistoricoDuplicata(AHistorico,ANumeroDuplicata,AParcela,AEspecieDocumento,ACodigoEmpresa,ACodigoCliente,AAutoIncremento : String);
  private
    FReservaMovBan,
    FReservaBanCtr,
    FReservaLogCtr,
    FReservaSeqLan,
    FReservaCadPagTarifa,
    FReservaLogCtpTarifa,
    FReservaSeqLanTarifa,
    FReservaMovBanTarifa,
    FReservaBanCtpTarifa: TReservaSequencial;
    FQuantidadeTarifas: Integer;
    procedure pReservaAutoIncrem(var AReserva: TReservaSequencial; const ATabela: String; const AQuantidade: Integer);
    procedure pReservaSeqLan(var AReserva: TReservaSequencial; const AQuantidade: Integer);
    function fProximoAutoIncremReservado(var AReserva: TReservaSequencial; const ACodEmp: String): String;
    function fProximoSeqLanReservado(var AReserva: TReservaSequencial): String;
    procedure pLimparReservasAutoIncrem;
    procedure pContarReservasDoRetorno(ARetBco: TDataSet; out AQtdTitulos, AQtdLiquidacoes, AQtdTarifas: Integer);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses untFuncoes, untfuncoesSimples, untModulo, untRelRelDuplicatas, untModuloSPR,
  untConfigBradesco, untConfigBrasil, untBaixaMovimentacaoBancariaDesmembrado,
  untConfigCxFederal,untConfigCxFederal7D, untConfigHsbc, untConfigItau, untConfigMercantil,
  untGerDup, untEstorno, untExpArqRemBradesco, untExpArqRemBrasil, untExpArqRemCxFed,untExpArqRemCxFed7D,
  untExpArqRemHsbc, untExpArqRemItau, untExpArqRemMerc,
  untModuloCons, untConstantes, untModuloCadCbi,
  untRetBco, untConfigSofisa, untExpArqRemSofisa,
  untModuloRetBco, untRelRetBco, untWaitWindow, untConfigBrasil7d,
  untExpArqRemBrasil7d, untModuloCfgAtb, untConfigCxFederal400p, untExpArqRemCxFed400p,
  untConfigSicredi, untConfigBanrisul,
  untExpArqRemSicredi, untExpArqRemBanrisul, untModuloReplicacao,
  untRelRelCtaDuplicatas, untModuloCadPgi,
  untConfigItauCta, untExpArqRemItauCta, untRelRetBcoCta, untModuloRetCtp,
  untConfigBancoob, untExpArqRemBancoob, untGeraArqSerasa,
  untProcArqSerasa, untConfigSantanderBan, untExpArqRemSantanderBan,
  untConfigSantander240p, untExpArqRemSantander240p,
  untGeraArqSerasaCon, untCadPag, untCadRec,
  untConfigBanestes, untExpArqRemBanestes, untConfigBancoob240,
  untExpArqRemBancoob240, untConfigSantanderCta, untExpArqRemSantanderCta,
  untGeraArqSerasaPEFIN, untProcArqSerasaPEFIN, untArqDivRetBco,
  untConfigBradescoCta, untExpArqRemBradescoCta, untConfigBancoAmazonia,
  untExpArqRemBancoAmazonia, untConfigRendimento, untExpArqRemRendimento, untConfigCecred,
  untExpArqRemCecred, untConfigUnicred, untExpArqRemUnicred,
  untConfigUnicred400, untExpArqRemUnicred400, untConfigABCBrasil,
  untConfigUnicred400_136, untExpArqRemUnicred400_136,
  untExpArqRemABCBrasil, {untTBanCtrRepository,} untExpArqSer,
  untConfigSafra, untExpArqRemSafra, untConfigReal, untExpArqRemReal, untLogCtp, untLogCtr,
  untConfigCtaDDA, untCtaImpDDA, untCtaRelDupDDA, untCtaAtuDupDDA,
  untCtaCadDupDDA, untConfigBancoobCta, untExpArqRemBancoobCta, untGeraArqSPC,
  untConfigSPC, untExpArqSPC, untProcArqSPC, untConfigBradescoCta240,
  untExpArqRemBradescoCta240, untConfigBradesco240Vendor,
  untExpArqRemBradesco240Vendor, untRelNossoNum,
  untConfigSafraCta, untExpArqRemSafraCta,
  untAdiantamentoClienteGenerico,
  untConfigBRB400p, untExpArqRemBRB400p, untGerDupCob, untExpArqCobJudicial,
  untConfigNordeste400, untExpArqRemNordeste400, untFuncoesBoleto, untBancos,
  untConfigBanestesCta, untExpArqRemBanestesCta,  untConfigPagFor, untExpArqPagFor, untRetPagFor,
  untConfigUniprime400, untExpArqRemUniprime400, untConfigCredisan400,
  untExpArqRemCredisan400, untConfigSicredi240, untExpArqRemSicredi240,
  untConfigFomentoMercantil400, untExpArqRemFomentoMercantil400, untExpArqRemIEPTBSP, untConfigIEPTBSP,
  untConfigDaycoval, untExpArqRemDaycoval, untConfigCreditBrasil, untExpArqRemCreditBrasil,
  untConfigBanrisul240, untExpArqRemBanrisul240, untConfigAthenaAtlanta,
  untExpArqRemAthenaAtlanta,untConfigGarsonCredito,untExpArqRemGarsonCredito,
  untConfigSifra,untExpArqRemSifra, untAtualizaOcorrenciasCRM, untTypesCRM,
  untConfigDaycoval_707,untExpArqRemDaycoval_707, untTBancoInterMenu,
  untConfigBanrisulCta240, untExpArqRemBanrisulCta240, untTSerranaMenu, untTRubiMenu,
  untConfiguracaoBancoBrasilPGG,untExpRemessaBancoBrasilPGG,untGravando,untTBancoDoBrasilMenu,untTBancoDoBrasilApi,
  untConfigSBCredito, untExpArqRemSBCredito, untConfigSBCredito_Bradesco,
  untExpArqRemSBCredito_Bradesco, untConfigABCBrasilCta,
  untExpArqRemABCBrasilCta, untConfigSofisa_444, untExpArqRemSofisa_444,
  untTBancoCredisisMenu, untConfigCredisisAPI, untConfigBtgPactual_240p,
  untExpArqRemBtgPactual_240p,untConfigCresol240p,
  untExpArqRemCresol240p, untConfigGerencianet240p, untExpArqRemGerencianet240p,
  untTBancoSicrediMenu,untTBancoSicrediApi,
  untConfigBMPMoneyPlus, untExpArqRemBMPMoneyPlus, untTPagForMenu,
  untTItauMenu, untExpArqRemSparti, untConfigSparti, untConfigBancoLecca,
  untExpArqRemBancoLecca, untExpArqRemSisprime, untConfigSisprime,
  untThreadUtils, untHorarioSistema, untConfigMultibank, untExpArqRemMultibank,
  untConfigSRM, untExpArqRemSRM, untConfigFidussia, untExpArqRemFidussia,
  untConfigMultiplike, untExpArqRemMultiplike, untConfigGrupoSifra,
  untExpArqRemGrupoSifra, untConfigJpiFidc, untExpArqRemJpiFidc, untConfigCapitalFinancas, untExpArqRemCapitalFinancas,
  untTBancoSicoobMenu, untTBancoSantanderMenu, untConfigLakeBank, untExpArqRemLakeBank, untConfigLotus, untExpArqRemLotus,
  untConfigJPCapital, untExpArqRemJPCapital, untConfigOlam, untExpArqRemOlam, untConfigBelaVista, untExpArqRemBelaVista,
  untConfigSofisa_LP_444, untExpArqRemSofisa_LP_444, untTBancoSafraMenu, untConfigSafraAPI,
  untConfigBMPMoneyPlus_LP_400, untExpArqRemBMPMoneyPlus_LP_400, untTBancoBradescoMenu, untConfigFinanceiraFormula,
  untExpArqRemFinanceiraFormula, untConfigBancoCredVale, untExpArqRemBancoCredVale;

{$R *.dfm}

function TfrmPrincipal.fEhBancoQueIgnoraOcorrenciaNaBaixa(strCodBco: String): Boolean;
begin
  Result := False;
  If strCodBco = '756_240p' Then
    Result := True
  Else If strCodBco = '237' Then
    Result := True
  Else If strCodBco = '041_240p' Then
    Result := True
  Else If strCodBco = '976' Then
    Result := True
  Else If strCodBco = '906' Then
    Result := True;
end;

function TfrmPrincipal.fEhDocumentoDesCobJaAtualizado(strNumDup, strParcel, strEspDoc,
  strCodEmp, strCodCli, strNomArq, strCodBco: String; fltDesCob: Double;
  intCodOco: Integer): Boolean;
  Var
    LConsulta: TUniQuery;
begin
  Result := False;

  LConsulta := fCriaQuery;
  Try
    LConsulta.SQL.Text := 'SELECT  IFNULL(COUNT(*), 0) AS TOTAL ' +
                          'FROM HISRET  ' +
                          ' WHERE HIS_CODBCO = :CODBCO ' +
                          '   AND HIS_CODOCO = :CODOCO ' +
                          '   AND HIS_NOMARQ = :NOMARQ ' +
                          '   AND HIS_DESCOB = :DESCOB ' +
                          '   AND HIS_NUMDUP = :NUMDUP ' +
                          '   AND HIS_PARCEL = :PARCEL ' +
                          '   AND HIS_ESPDOC = :ESPDOC ' +
                          '   AND HIS_CODEMP = :CODEMP ' +
                          '   AND HIS_CODCLI = :CODCLI ';

    Try
      LConsulta.ParamByName('NUMDUP').AsString   := strNumDup;
      LConsulta.ParamByName('PARCEL').AsString   := strParcel;
      LConsulta.ParamByName('ESPDOC').AsString   := strEspDoc;
      LConsulta.ParamByName('CODEMP').AsString   := strCodEmp;
      LConsulta.ParamByName('CODCLI').AsString   := strCodCli;

      LConsulta.ParamByName('CODBCO').AsString   := strCodBco;
      LConsulta.ParamByName('CODOCO').AsInteger  := intCodOco;
      LConsulta.ParamByName('NOMARQ').AsString   := strNomArq;
      LConsulta.ParamByName('DESCOB').AsFloat    := fltDesCob;
      LConsulta.Open;

      Result := LConsulta.FieldByName('TOTAL').AsInteger > 1;
    Except
      On E: Exception Do
        Raise Exception.Create(E.Message + ' - [fEhDocumentoJaAtulizado]');
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

function TfrmPrincipal.fGetDiasParaCreditoOcorrencia12(ABanco: String; ACarteira: Integer): Integer;
  Var
   LDiasParaCredito: string;
begin
  Result := -1;

  Try
    If Not SameText(ABanco, '001API') Then
      Exit;

    LDiasParaCredito := fGetBancoConfig(0,'CONFIG001API-' + IntToStr(ACarteira),'DIACRED12','');

    if not fEmptyStr(LDiasParaCredito) then
      Result :=  StrToIntDef(LDiasParaCredito, -1);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TfrmPrincipal.fGravaMovBan(strCodCta,
                                    strCodPor,
                                    strCodOpe: String;
                                    dtaDtaLan: TDateTime;
                                    strNumDoc,
                                    strCreDeb,
                                    strCodEmp: String;
                                    fltValLan: Double;
                                    strHist01,
                                    strHist02: String;
                                    strCodCli,
                                    strCodFor,
                                    strNumDup: String;
                                    intSeqBai: Integer;
                                    strParcel,
                                    strEmpDup,
                                    strSerie,
                                    strSeqLan,
                                    strCodEve: String;
                                    lstLogBan: TList<TLogBan>;
                                    strCompet: String = '';
                                    intPagCon: Integer = 0;
                                    const AAutoIncMovBan: String = ''): String;
  Var
    strSQL: String;
    objLogBan : TLogBan;
begin
  Try
    strRetAutIncMovBan := '';

    If fEmptyStr(strSeqLan) Then
      Result := fSeqContaBanco
    Else
      Result := strSeqLan;

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO MOVBAN ( ';
    strSQL := strSQL + ' CTB_SEQLAN, ';
    strSQL := strSQL + ' CTB_CODCTA, ';
    strSQL := strSQL + ' CTB_CODPOR, ';
    strSQL := strSQL + ' CTB_CODOPE, ';
    strSQL := strSQL + ' CTB_DTALAN, ';
    strSQL := strSQL + ' CTB_HORLAN, ';
    strSQL := strSQL + ' CTB_NUMDOC, ';
    strSQL := strSQL + ' CTB_CREDEB, ';
    strSQL := strSQL + ' CTB_VALLAN, ';
    strSQL := strSQL + ' CTB_HIST01, ';
    strSQL := strSQL + ' CTB_HIST02, ';
    strSQL := strSQL + ' CTB_CODEMP, ';
    strSQL := strSQL + ' AUTOINCREM, ';
    strSQL := strSQL + ' CTB_CODCLI, ';
    strSQL := strSQL + ' CTB_CODFOR, ';
    strSQL := strSQL + ' CTB_NUMDUP, ';
    strSQL := strSQL + ' CTB_SEQBAI, ';
    strSQL := strSQL + ' CTB_PARCEL, ';
    strSQL := strSQL + ' CTB_EMPDUP, ';
    strSQL := strSQL + ' CTB_SERIE_, ';
    strSQL := strSQL + ' CTB_CODEVE, ';
    strSQL := strSQL + ' CTB_COMPET, ';
    strSQL := strSQL + ' CTB_PAGCON, ';
    strSQL := strSQL + ' CTB_ORIGEM) ';
    strSQL := strSQL + 'VALUES ( ';
    strSQL := strSQL + '  :SEQLAN, ';
    strSQL := strSQL + '  :CODCTA, ';
    strSQL := strSQL + '  :CODPOR, ';
    strSQL := strSQL + '  :CODOPE, ';
    strSQL := strSQL + '  :DTALAN, ';
    strSQL := strSQL + '  :HORLAN, ';
    strSQL := strSQL + '  :NUMDOC, ';
    strSQL := strSQL + '  :CREDEB, ';
    strSQL := strSQL + '  :VALLAN, ';
    strSQL := strSQL + '  :HIST01, ';
    strSQL := strSQL + '  :HIST02, ';
    strSQL := strSQL + '  :CODEMP, ';
    strSQL := strSQL + '  :AUTINC, ';
    strSQL := strSQL + '  :CODCLI, ';
    strSQL := strSQL + '  :CODFOR, ';
    strSQL := strSQL + '  :NUMDUP, ';
    strSQL := strSQL + '  :SEQBAI, ';
    strSQL := strSQL + '  :PARCEL, ';
    strSQL := strSQL + '  :EMPDUP, ';
    strSQL := strSQL + '  :SERIE_, ';
    strSQL := strSQL + '  :CODEVE, ';
    strSQL := strSQL + '  :COMPET, ';
    strSQL := strSQL + '  :PAGCON, ';
    strSQL := strSQL + '  :ORIGEM) ';

    Try

      qryGravaMovBan := fCriaQuery(qryGravaMovBan);

      With qryGravaMovBan Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('SEQLAN').AsString   := Result;

        If fEmptyStr(strCodCta) Then
          ParamByName('CODCTA').Value    := Null
        Else
          ParamByName('CODCTA').AsString := strCodCta;

        If fEmptyStr(strCodPor) Then
          ParamByName('CODPOR').Value    := Null
        Else
          ParamByName('CODPOR').AsString := strCodPor;

        If fEmptyStr(strCodOpe) Then
          ParamByName('CODOPE').Value    := Null
        Else
          ParamByName('CODOPE').AsString := strCodOpe;

        ParamByName('COMPET').AsString   := strCompet;
        ParamByName('PAGCON').AsInteger  := intPagCon;
        ParamByName('DTALAN').AsDateTime := dtaDtaLan;
        ParamByName('HORLAN').AsTime     := fTime();
        ParamByName('NUMDOC').AsString   := strNumDoc;
        ParamByName('CREDEB').AsString   := strCreDeb;
        ParamByName('VALLAN').AsFloat    := fltValLan;
        ParamByName('HIST01').AsString   := strHist01;
        ParamByName('HIST02').AsString   := strHist02;
        ParamByName('CODEMP').AsString   := strCodEmp;
        If fEmptyStr(AAutoIncMovBan) Then
          ParamByName('AUTINC').AsString := fRetAutoIncrem('MOVBAN', strCodEmp)
        Else
          ParamByName('AUTINC').AsString := AAutoIncMovBan;

        strRetAutIncMovBan := ParamByName('AUTINC').AsString;

        If Not fEmptyStr(strCodCli) Then
          ParamByName('CODCLI').AsString := strCodCli
        Else
          ParamByName('CODCLI').Value    := Null;

        If fEmptyStr(strCodFor) Then
          ParamByName('CODFOR').Value    := Null
        Else
          ParamByName('CODFOR').AsString := strCodFor;

        ParamByName('NUMDUP').AsString   := strNumDup;
        ParamByName('SEQBAI').AsInteger  := intSeqBai;
        ParamByName('PARCEL').AsString   := strParcel;

        If fEmptyStr(strEmpDup) Then
          ParamByName('EMPDUP').Value    := Null
        Else
          ParamByName('EMPDUP').AsString   := strEmpDup;

        ParamByName('SERIE_').AsString   := strSerie;

        If (fEmptyStr(strCodEve)) Then
          ParamByName('CODEVE').Value := Null
        Else
          ParamByName('CODEVE').AsString := strCodEve;

        If (lstLogBan <> Nil) And (lstLogBan.Count > 0) And (lstLogBan[0] <> Nil) Then
          ParamByName('ORIGEM').AsString := TGravaLogBan.fGetOrigem(lstLogBan[0])
        Else
          ParamByName('ORIGEM').Value := Null;


        ExecSQL;
        Close;
      End;

      If (Assigned(lstLogBan)) Then
        For objLogBan In lstLogBan Do
          TGravaLogBan.fGravaLogBan(objLogBan, strCodEmp, Result);

    Finally

      FreeAndNil(qryGravaMovBan);
    End;

  Except
    On E: Exception Do
    Begin
      Result := '';
      pMensagensErro(E.Message, '[fGravaMovBan]');
    End;
  End;
end;



procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  FrameMenu.AdicionaMenuBancoDoBrasilPagForAPI;
  FrameMenu.AdicionaMenuItauAPIPix;
  FrameMenu.AdicionaMenuSicoobAPIPix;
  FrameMenu.AdicionaMenuSantanderAPIPix;
  FrameMenu.AdicionaMenuJpiFidc;
  FrameMenu.AdicionaMenuBradescoAPIPix;

  pGeraVetor;
  pVerificaMenu;
  pRemoveNomeForms;

  stbStatus.SizeGrip := True;

  intContadorCarteiras := 1;

  WindowState := wsMaximized;
  SetForegroundWindow(Self.Handle);

  VS_ListaDeCarteiras := RetornaListaDeCarteirasCFGBAN;

  ValidaEAtualizaVersoesDLLsAPI;
  tmrCertificadosExpirados.Enabled := True;
end;

function TfrmPrincipal.fRetornaCodEvento(qryCons: TUniQuery;
                                         strCodOco,
                                         strCodBco: String;
                                         strMotOco: String = '';
                                         iCartei : Integer = 0): String;
  Var
    LContadorMotivos: Integer;
    LMotivo: String;
begin
  Result := '';

  Try
    qryCons.Close;
    qryCons.SQL.Clear;
    qryCons.SQL.Add(' SELECT RET_CODEVE, RET_CODPOR, IFNULL(RET_MOTOCO,"") AS RET_MOTOCO FROM OCORET WHERE RET_CODOCO = :CODOCO AND RET_CODBCO = :CODBCO AND RET_CODEMP = :CODEMP');

    If ( (fCfgSis('CAROCO', varBoolean)) And ((strCodBco = '756') And (iCartei > 0)) ) Then
       qryCons.SQL.Add(' AND RET_CARTEI = :CARTEI ');

    qryCons.ParamByName('CODOCO').AsString := strCodOco;
    qryCons.ParamByName('CODBCO').AsString := strCodBco;
    qryCons.ParamByName('CODEMP').AsString := VS_strCodEmp;

    If ( (fCfgSis('CAROCO', varBoolean)) And ((strCodBco = '756') And (iCartei > 0)) ) Then
       qryCons.ParamByName('CARTEI').AsInteger := iCartei;

    qryCons.Open;

    If qryCons.Locate('RET_MOTOCO',VarArrayOf(['']), []) Then
    Begin
      If DeveAtualizarEventoEPortador(strCodBco,strCodOco,strMotOco) Then
        Result := qryCons.FieldByName('RET_CODEVE').AsString + '_' + qryCons.FieldByName('RET_CODPOR').AsString;
    End;

    If Not fEmptyStr(strMotOco) Then
    Begin
      LContadorMotivos := 1;
      While LContadorMotivos < strMotOco.Length Do
      Begin
        LMotivo := Copy(strMotOco, LContadorMotivos, 2);
        If qryCons.Locate('RET_MOTOCO',VarArrayOf([LMotivo]), []) Then
        Begin
          Result := qryCons.FieldByName('RET_CODEVE').AsString + '_' + qryCons.FieldByName('RET_CODPOR').AsString;
          Break;
        End;
        Inc(LContadorMotivos, 2);
      End;
    End;

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TfrmPrincipal.fRetRelatSQL: String;
begin
  Result := '';
  Result := Result + 'SELECT                                       ';
  Result := Result + '    CTR_NUMDUP,                              ';
  Result := Result + '    CTR_PARCEL,                              ';
  Result := Result + '    CTR_ESPDOC,                              ';
  Result := Result + '    CTR_CODEMP,                              ';
  Result := Result + '    CTR_CODCLI,                              ';
  Result := Result + '    CTR_DTACAD,                              ';
  Result := Result + '    CTR_DTAVEN,                              ';
  Result := Result + '    CTR_DTAREC,                              ';
  Result := Result + '    CTR_NOSNUM,                              ';
  Result := Result + '    CTR_VALDUP,                              ';
  Result := Result + '    CTR_VALREC,                              ';
  Result := Result + '    CTR_VALJUR,                              ';
  Result := Result + '    CTR_VALDES,                              ';
  Result := Result + '    CTR_VALDES AS CTR_TARIFA,                ';
  Result := Result + '    CTR_OBSAG1 AS CLI_NOMCLI,                ';
  Result := Result + '    CTR_OBSAG1 AS DESCRI,                    ';
  Result := Result + '    CTR_VALDES AS TARIFA_CARTEIRA            ';
  Result := Result + 'FROM                                         ';
  Result := Result + '    CADREC                                   ';
  Result := Result + 'WHERE FALSE                                  ';
end;

function TfrmPrincipal.fUsaTabelaOCORET(qryCons: TUniQuery;
                                        strCodBco: String): Boolean;
begin
  With qryCons Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT COUNT(*) AS CONTADOR FROM OCORET WHERE RET_CODBCO = :CODBCO AND RET_CODEMP = :CODEMP ');
    ParamByName('CODBCO').AsString := strCodBco;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;

    Result := FieldByName('CONTADOR').AsInteger > 0;
  End;
end;

function TfrmPrincipal.GetValorPago(ACodBco: String; AValPag,
  ATarifa,AValDup: Double): Double;
begin
  Result := AValPag;
  If ACodBco.Equals('341') Then
  Begin
    If AValDup < ATarifa Then
      Result := AValPag + ATarifa;
  End;
end;

procedure TfrmPrincipal.GravarMovCtr(const AAutoIncremContasReceber,
  ASequencialMovimentacaoBancaria, AEmpresaMovimentacaoBancaria: string);
begin
  Try
    TInseridorMovCtrLote.
     ObterInstancia.
      AdicionarParaInserir(AAutoIncremContasReceber,
                           ASequencialMovimentacaoBancaria,
                           AEmpresaMovimentacaoBancaria);

    TInseridorLogMcrLote.
     ObterInstancia.
      AdicionarParaInserir(AAutoIncremContasReceber,
                           ASequencialMovimentacaoBancaria,
                           AEmpresaMovimentacaoBancaria,
                           'BAIXA AUTOMATICA (AUTBAN)',
                           'TBaixaDuplicatas');
  except
    on E: Exception do
      Raise Exception.Create(E.Message);
  End;
end;

function TfrmPrincipal.LancamentoDeTarifa(ACodBco, ACodOco,AMotOco: String): Boolean;
begin
  Result := False;
   {*********************************************************
   * BANCO SICRED QUANDO CONFIGURADO PARA LANÇAR TARIFA     *
   * NA OCORRENCIA 28, MOTIVO B3 IGNORA SE A DUPLICATA ESTÁ *
   * BAIXADA OU NÃO                                         *
   *******************************************************MT*}
  If (LeftStr(ACodBco, 3) = '748') or
     (ACodBco = '237') Then //MF: 284336 - 18/05/2023
  Begin
    If (Pos(ACodOco,LOcoTar) <= 0) Then Exit
    Else If (ACodOco <> '28') Then Exit
    Else If (not MatchStr(AMotOco, ['B3','S5','05'])) Then Exit;

    Result:= True;
  End;

  If ACodBco.Equals('341') Then
  Begin
    If MatchStr(ACodOco,['35','29']) Then
    Begin
      If (Pos(ACodOco,LOcoTar) > 0) Then
        Result := True;
    End;
  End;

  If ACodBco.Equals('756') Then
  Begin
    If MatchStr(ACodOco,['09']) Then
    Begin
      If (Pos(ACodOco,LOcoTar) > 0) Then
        Result := True;
    End;
  End;

end;

function TfrmPrincipal.LancarTarifasNaLiquidacao(ACodBco,
  ACodOco: String): Boolean;
begin
  Result := False;

  If Not MatchStr(ACodBco,['237']) Then
    Exit;

  If Not MatchStr(ACodOco,['15']) Then
    Exit;

  Result := True;
end;

procedure TfrmPrincipal.LiberaDuplicatas;
var
  LForm: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando,LForm);
  try
    LForm.fExecutarAcao := DesmarcandoDuplicatas;
    LForm.lblGravando.Caption := 'Aguarde... Liberando Duplicatas.';
    LForm.ShowModal;
  finally
    pFreeAndNil(LForm);
  end;
end;

procedure TfrmPrincipal.LimpaDadosDuplicatasBaixadasPeloBanco(
  AAutoIncremCadRec, ACodigoBanco, ACodigoOcorrencia: String);
  Var
    LAtualiza: TUniQuery;
begin
  If AAutoIncremCadRec.IsEmpty Then
    Exit;

  Try
    LAtualiza := fCriaQuery;
    LAtualiza.SQL.Text := 'UPDATE CADREC SET ' +
                          '    CTR_HIST01 = CONCAT(IFNULL(CTR_HIST01, ""), ' +
                          '                        "<<csq>>", ' +
                          '                        "Boleto Baixado Ocorrência 10: ", ' +
                          '                        "Nosso Número: ", CTR_NOSNUM, ' +
                          '                        " Banco: ", IFNULL(CTR_BCOBOL, CTR_BCOENV)), ' +
                          '    CTR_NOSNUM=NULL, CTR_BCOBOL=NULL, CTR_DTABOL=NULL, ' +
                          '    CTR_CARTEI="" ' +
                          'WHERE AUTOINCREM="' + AAutoIncremCadRec + '"' +
                          '  AND (CTR_NOSNUM IS NOT NULL AND CTR_NOSNUM<>"")';

    LAtualiza.ExecSQL;

    If LAtualiza.RowsAffected > 0 Then
    Begin
      untLogCtr.GravaLogCtr(AAutoIncremCadRec,
                            'DUPLICATA BAIXADA NO BANCO [' + ACodigoBanco + '] - OCORRÊNCIA ' + ACodigoOcorrencia,
                            Self.Name,
                            '',
                            0,
                            0,
                            '',
                            '',
                            Nil,
                            fProximoAutoIncremReservado(FReservaLogCtr, VarToStr(fCampoTabela('CTR_CODEMP', 'CADREC', ['AUTOINCREM'], [AAutoIncremCadRec]))));

      s033Oco10 := True;
    End;
  Finally
    FreeAndNil(LAtualiza);
  End;
end;

procedure TfrmPrincipal.MarcaDuplicatas;
var
  LForm: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando,LForm);
  try
    LForm.fExecutarAcao := MarcandoDuplicatas;
    LForm.lblGravando.Caption := 'Aguarde... Marcando Duplicatas.';
    LForm.ShowModal;
  finally
    pFreeAndNil(LForm);
  end;
end;

function TfrmPrincipal.MarcandoDuplicatas(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LQryAux: TUniQuery;
    LChaLck: String;
    LUsaTarifa: Boolean;
    LEmpresasDireitoBaixa : String;
begin
  Try
    Result := True;
    LUsaTarifa := fCfgSis('ENCBAN', varBoolean);
    LEmpresasDireitoBaixa := fCampoTabela('OPE_EMPCTR', 'CADOPE', ['OPE_CODOPE'], [strLoginUsuarioLogado]);

    If Not Assigned(LQryRetBcoGer) Then Exit;
    If LQryRetBcoGer.IsEmpty Then Exit;

    LQryAux := fCriaQuery(Nil);
    LQryRetBcoGer.First;
    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := LQryRetBcoGer.RecordCount;

    Try
      While Not LQryRetBcoGer.Eof Do
      Begin

        LChaLck := 'CADREC' +
                   LQryRetBcoGer.FieldByName('RET_NUMDUP').AsString +
                   LQryRetBcoGer.FieldByName('RET_ESPDOC').AsString +
                   LQryRetBcoGer.FieldByName('RET_CODEMP').AsString +
                   LQryRetBcoGer.FieldByName('RET_CODCLI').AsString +
                   LQryRetBcoGer.FieldByName('RET_PARCEL').AsString ;



        If Not fLockedByCurrentConnection(LChaLck) And
           Not objLock.fLock_Unlock(LChaLck, True, False, False, '',True,'')Then
        Begin
          AtualizaDivergenciaRetBco(LQryRetBcoGer.FieldByName('RET_NUMDUP').AsString,
                                    LQryRetBcoGer.FieldByName('RET_PARCEL').AsString,
                                    LQryRetBcoGer.FieldByName('RET_ESPDOC').AsString,
                                    LQryRetBcoGer.FieldByName('RET_CODEMP').AsString,
                                    LQryRetBcoGer.FieldByName('RET_CODCLI').AsString,
                                    'DUPLICATA EM USO POR OUTRA ESTAÇÃO: ' + fGetHostLock(LChaLck));

        End
        Else If Not VerificaSeOperadorPossuiDireitoABaixaNaEmpresa(LEmpresasDireitoBaixa) Then
        Begin
          LQryRetBcoGer.Next;
          Continue;
        End
        Else If Not VerificaPermissaoParaBaixaEmEmpresaDiferenteDoCadastro Then
        Begin
          LQryRetBcoGer.Next;
          Continue;
        End
        Else
        Begin
          pGravaHisRet(LQryRetBcoGer, LNomBanco);

          If LQryRetBcoGer.FieldByName('RET_DUPDIV').AsString.Equals('S') And
             (Pos('DUPLICATA EM USO POR OUTRA ESTAÇÃO',LQryRetBcoGer.FieldByName('RET_MOTDIV').AsString) > 0) Then
          Begin
            AtualizaDivergenciaRetBco(LQryRetBcoGer.FieldByName('RET_NUMDUP').AsString,
                                      LQryRetBcoGer.FieldByName('RET_PARCEL').AsString,
                                      LQryRetBcoGer.FieldByName('RET_ESPDOC').AsString,
                                      LQryRetBcoGer.FieldByName('RET_CODEMP').AsString,
                                      LQryRetBcoGer.FieldByName('RET_CODCLI').AsString,
                                      '',
                                      False);
          End;

          AtualizaEventoPortador(LQryRetBcoGer,LQryAux,LCodBco);

          // SICRED 400P MANDA A TARIFA DA OCORRENCIA 02 NA OCORRENCIA 28, POR ISSO TEM QUE ATUALIZAR
          If LeftStr(LCodBco, 3).Equals('748') And
             LQryRetBcoGer.FieldByName('RET_CODOCO').AsString.Equals('28') And
             (lQryRetBcoGer.FieldByName('RET_MOTOCO').AsString.Equals('B3') Or lQryRetBcoGer.FieldByName('RET_MOTOCO').AsString.Equals('05')) And
             LUsaTarifa And (Pos(LQryRetBcoGer.FieldByName('RET_CODOCO').AsString,LOcoTar) <= 0) Then
          Begin
            pAtualizaTarifaArqBco(LQryRetBcoGer.FieldByName('RET_NUMDUP').AsString,
                                  LQryRetBcoGer.FieldByName('RET_PARCEL').AsString,
                                  LQryRetBcoGer.FieldByName('RET_CODCLI').AsString,
                                  LQryRetBcoGer.FieldByName('RET_CODEMP').AsString,
                                  LQryRetBcoGer.FieldByName('RET_ESPDOC').AsString,
                                  LQryRetBcoGer.FieldByName('RET_DTAOCO').AsString,
                                  LQryRetBcoGer.FieldByName('RET_TARIFA').AsString);

            pApagaRetBco(LeftStr(LCodBco, 3),
                         LQryRetBcoGer.FieldByName('RET_NUMDUP').AsString,
                         LQryRetBcoGer.FieldByName('RET_PARCEL').AsString,
                         LQryRetBcoGer.FieldByName('RET_ESPDOC').AsString,
                         LQryRetBcoGer.FieldByName('RET_CODEMP').AsString,
                         LQryRetBcoGer.FieldByName('RET_CODCLI').AsString,
                         LQryRetBcoGer.FieldByName('RET_CODOCO').AsString,
                         LQryRetBcoGer.FieldByName('RET_CNAB__').AsString,
                         LQryRetBcoGer.FieldByName('RET_MOTOCO').AsString);

          End;

        End;

        LQryRetBcoGer.Next;
        pStepStatusSelecao(pgbProgresso);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmPrincipal.MarcandoDuplicatas]');
      End;
    End;
  Finally

    If Assigned(LQryAux) Then
      FreeAndNil(LQryAux);

    LNomBanco := '';
    LCodBco   := '';
  End;
end;

function TfrmPrincipal.OcorrenciaSemVinculoCtrBan(AAutCtr, AOcorrencia, ABanco: String;  AMotivo: String = ''): Boolean;
Var
  qryBusca: TUniQuery;
begin

  If Not ((ABanco = '341') and (Pos(AOcorrencia,'09_35') > 0)) And
     Not ((LeftStr(ABanco, 3) = '748') and (Pos(AOcorrencia,'28') > 0)) Then
  Begin
    Result := True;
    Exit;
  End;

  Try
    qryBusca := fCriaQuery;
    qryBusca.Close;
    qryBusca.SQL.Clear;
    qryBusca.SQL.Add('SELECT COUNT(BAN_AUTCTR) AS QUANTIDADE ');
    qryBusca.SQL.Add('FROM CTRBAN ');
    qryBusca.SQL.Add('WHERE BAN_AUTCTR = :AUTCTR AND ');
    qryBusca.SQL.Add('      BAN_CODOCO = :CODOCO ');

    If Not fEmptyStr(AMotivo) Then
      qryBusca.SQL.Add('   AND BAN_MOTOCO = :MOTOCO ');

    qryBusca.ParamByName('AUTCTR').AsString := AAutCtr;
    qryBusca.ParamByName('CODOCO').AsString := AOcorrencia;

    If Not fEmptyStr(AMotivo) Then
      qryBusca.ParamByName('MOTOCO').AsString := AMotivo;

    qryBusca.Open;

    Result := qryBusca.FieldByName('QUANTIDADE').AsInteger = 0;
  Finally
    FreeAndNil(qryBusca);
  End;
end;


procedure TfrmPrincipal.FormCreate(Sender: TObject);
  Var
    strSenha: String;
    strCodEmp: String;
    stl: TStringList;
    qryEmp: TUniQuery;

  function fGetRevisionSVN: String;
  {$I rev.inc}
  Begin
    Result := SVN_REVISION;
  End;

begin
  untFuncoesSimples.VS_objTraceViewer := TTraceViewer.Create;

  pIniciaLogLeak(DebugHook, 'Autcom');

  Self.Caption := 'AutBan';

  {**************************************}
  {* PEGA O LOGIN DO USUÁRIO E VERIFICA *}
  {* SE É PARA EXPORTAR O TXT           *}
  {***********************************AF*}
  If ParamCount > 0 Then
  Begin
    If ParamStr(1) = 'GETREVISION' Then
    Begin
      TThreadFinalizarAutcomMonitor.Monitorar;

      Self.Hide;
      stl := TStringList.Create;

      stl.Add('Rev: ' + fGetRevisionSVN);
      stl.SaveToFile(ExtractFilePath(Application.ExeName) + '\AutBanRev.txt');

      FreeAndNil(stl);

      Application.Terminate;
      Exit;
    End;

    strLoginUsuarioLogado := ParamStr(2);

    If ParamCount > 1 Then
    Begin

      pSetaEmpresaLogada(ParamStr(4));

    End;
  End;

  pCriarModulo(TfrmModulo, TDataModule(frmModulo));
  pCriarModulo(TfrmModuloSPR, TDataModule(frmModuloSPR));
  pCriarModulo(TfrmModuloCons, TDataModule(frmModuloCons));

  pCriarModulo(TfrmModuloReplicacao, TDataModule(frmModuloReplicacao));

  pCriarModulo(TfrmModuloCadCbi, TDataModule(frmModuloCadCbi));

  pCriarModulo(TfrmModuloCadPgi, TDataModule(frmModuloCadPgi));

  pCriarModulo(TfrmModuloRetBco, TDataModule(frmModuloRetBco));
  pCriarModulo(TfrmModuloRetCtp, TDataModule(frmModuloRetCtp));

  pCriarModulo(TfrmModuloCfgAtb, TDataModule(frmModuloCfgAtb));

  pCarregaTabNre;

  {***************************************}
  {* VERIFICA SE O PARAMETRO COM O LOGIN *}
  {* DO USUÁRIO FOI PASSADO CORRETAMENTE *}
  {************************************AF*}
  If (strLoginUsuarioLogado = '') Then
  Begin
    ffrmSenhaEmpresa(strSenha, strCodEmp, 'AutBan - Senha Gerencial');

    If strSenha <> SENHAADM_AUTBAN Then
    Begin
      TThreadFinalizarAutcomMonitor.Monitorar;
      fMensagem('','Não foi passado o parametro com o código do operador!',['&O K']);
      Application.Terminate;
      Exit;
    End
    Else
    Begin
      strLoginUsuarioLogado := '999';
    End;

    pSetaEmpresaLogada(strCodEmp);
  End;

  If fEmptyStr(VS_strCodEmp) Then
  Begin
    TThreadFinalizarAutcomMonitor.Monitorar;
    fMensagem('','A empresa não está configurada no opcoes.ini!!!',['&O K']);
    Application.Terminate;
    Exit;
  End;

  tmrRelogio.Enabled := True;

  fAjustaDataSistema;

  DefinirTimeZoneEmSessaoMySql(frmModulo.GetCurrentConnection, VS_strCodEmp);

  strEmpAcessoUsuarioLogado := fRetEmpAcessoUsuario(strLoginUsuarioLogado);

  {********************************}
  {* INICIANDO A DLL "libFuncoes" *}
  {*****************************DP*}
//  dxInitializeFuncoes;
  pCarregaTabNre;
  pAtuVarGlobaisSimples;
  pIniciaDllFuncoes(frmModulo.GetCurrentConnection, strLoginUsuarioLogado, VS_strCodEmp, DebugHook, TCfgSis.Create(), VS_objTraceViewer,
                    VS_Date, VS_ComputerNetName, VS_UserFromWindows, VS_IPAddressAsString, VS_MacAddress);

  If fCfgSis('DACPOR', varBoolean) Then
    strPortadoresOperador := fRetPortadoresOperador(strLoginUsuarioLogado);

  pVerificaProCod;

  qryEmp := fCriaQuery;

  with qryEmp do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT CONCAT(EMP_CODEMP, '' - '' , EMP_NOMEMP) AS EMPRESA FROM CADEMP ');
    SQL.Add('WHERE EMP_CODEMP = :CODEMP ');
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  end;

  if Not qryEmp.IsEmpty Then
    Self.Caption := 'AutBan - ' + qryEmp.FieldByName('EMPRESA').AsString;

  stbStatus.Panels[0].Text := Concat(frmModulo.GetCurrentConnection.Server, '/', frmModulo.GetCurrentConnection.Database);
  TLogAut.New().pLogin();

end;

procedure TfrmPrincipal.FormDestroy(Sender: TObject);
begin
//
end;

{*****************************************}
{* MONTA MENU CONFORME DIREITO DE ACESSO *}
{**************************************AF*}
procedure TfrmPrincipal.pVerificaMenu;
  Var
    intCount   : Integer;
    intLetra   : Integer;
Begin
  {***************************************}
  {* SE O USUÁRIO LOGADO FOR 999 NÃO FAZ *}
  {* A VERIFICAÇÃO DE ACESSO E DA ACESSO *}
  {* COMPLETO                            *}
  {************************************AF*}
  If strLoginUsuarioLogado <>  '999' Then
  Begin
    {**************************}
    {* VERIFICAÇÃO DO DIREITO *}
    {***********************AF*}
    intCount := -1;

    While intCount <> FrameMenu.trvMenu.Items.Count-1 Do
    Begin
      inc(intCount);

      If Not fVerificaDireitoAutBan(Trim(arrMenu[intCount].strNomform)) Then
      Begin
        FrameMenu.trvMenu.Items[intCount].Delete;

        {For intContador := intCount To Length(arrMenu) -2 Do
        Begin
          arrMenu[intContador].strNomform := arrMenu[intContador+1].strNomform;
        End;}

        pGeraVetor;

        intCount := -1;
      End;

    End;
  End;

  {***********************}
  {* MONTAGEM DAS LETRAS *}
  {********************AF*}
  intLetra := 65;

  For intCount := 0 To FrameMenu.trvMenu.Items.Count -1 Do
  Begin
    If LeftStr(arrMenu[intcount].strNomform,3) <> 'mnu' Then
    Begin
      FrameMenu.trvMenu.Items[intcount].Text := Chr(intLetra) + ' - ' + FrameMenu.trvMenu.Items[intcount].Text;
      inc(intLetra);
    End
    Else
      intLetra := 65;
  End;
End;

function TfrmPrincipal.RetornaPlanoContasParaBaixa(ABanco: String; ACartei: Integer; ABancoApi: Boolean = False): String;
begin
  If ABanco = '341' Then
  Begin
    if ACartei = 0 then
    begin
      Result := fGetBancoConfig(0, 'CONFIGIEPTBSP', 'CTABAI_', '');
    end
    else
    begin
      Result := fGetBancoConfig(0, 'CONFIGCTA341-' + IntToStr(ACartei), 'CTABAI_', '');
    end;
  End
  Else
  If ABanco = '237_240' Then
  Begin
    Result := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(ACartei), 'CTABAI_', '');
  End
  Else
  begin
    If ABancoApi Then
      Result := fGetBancoConfig(0, 'CONFIGCTAAPI' + ABanco + '-' + IntToStr(ACartei), 'CTABAI_', '')
    Else
      Result := fGetBancoConfig(0, 'CONFIGCTA' + ABanco + '-' + IntToStr(ACartei), 'CTABAI_', '');
  end;

  If fEmptyStr(Result) Then
    Result := fGetBancoConfig(0, 'CONFIGPGG' + ABanco + '-' + IntToStr(ACartei), 'CTABAI_', '');

end;

function TfrmPrincipal.RetornaPortadorParaBaixa(ABanco: String;
  ACartei: Integer; ABancoApi: Boolean = False): String;
begin
  If ABanco = '341' Then
  Begin
    if ACartei = 0 then
    begin
      Result := fGetBancoConfig(0, 'CONFIGIEPTBSP', 'PORBAI_', '');
    end
    else
    begin
      Result := fGetBancoConfig(0, 'CONFIGCTA341-' + IntToStr(ACartei), 'PORBAI_', '');
    end;
  End
  Else
  If ABanco = '237_240' Then
  Begin
    Result := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(ACartei), 'PORBAI_', '');
  End
  else
  begin
    If ABancoApi Then
      Result := fGetBancoConfig(0, 'CONFIGCTAAPI' + ABanco + '-' + IntToStr(ACartei), 'PORBAI_', '')
    Else
      Result := fGetBancoConfig(0, 'CONFIGCTA' + ABanco + '-' + IntToStr(ACartei), 'PORBAI_', '')
  end;
end;

function TfrmPrincipal.SelecionaPortadorPlanoDeContasPorRegistro(ACodBco,
  AConfig: String): Boolean;
begin
  Result := False;

  If (ACodBco = '033B') Then
    Result := True
  Else If ((ACodBco = '001') And (blnBcoBra7d)) Then
    Result := True
  Else If  (ACodBco = '341') Then
    Result := True
  Else If Copy(AConfig, 7, 6).Equals('001API') Then
    Result := True;

end;

procedure TfrmPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

  If (fMensagem('', 'Deseja sair do AutBan?', ['&Sim', '&Não']) = 2) Then
  Begin
    Action := caNone;
  End
  Else
  Begin
    TLogAut.New().pLogout();
    LiberaDuplicatas;
//    dxFinalizeFuncoes;
    pFecharBanco(frmModulo.GetCurrentConnection);
    FreeAndNil(frmModulo);
    FreeAndNil(frmModuloSPR);
    FreeAndNil(frmModuloCons);

    pFinalizaLibrarys;

    pDestroiModulo(frmModuloCadCbi);
    pDestroiModulo(frmModuloRetBco);
    pDestroiModulo(frmModuloCfgAtb);

    If Assigned(VS_ListaDeCarteiras) Then
      FreeAndNil(VS_ListaDeCarteiras);

    Action := caFree;
  End;

end;

procedure TfrmPrincipal.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

  If Key = VK_Escape Then
  Begin
    btnSair.Click;
  End;

end;

function TfrmPrincipal.ValidacaoParaLancamentoDeTarifaNaConfirmacao(
  APermitidoLancarTarifa: Boolean; ADatasetRetBco,
  ADatasetCadRec: TDataset): Boolean;
begin
  Result := APermitidoLancarTarifa;
  If Not Result Then
    Exit;

  Result := ADatasetRetBco.FieldByName('RET_CODOCO').AsString = '02';
  If Not Result Then
    Exit;

  Result := ADatasetRetBco.FieldByName('RET_DUPDES').AsString <> 'S';
  If Not Result Then
    Exit;

  Result := ADatasetRetBco.FieldByName('RET_TARIFA').AsFloat > 0;
  If Not Result Then
    Exit;

  Result := fEmptyStr(ADatasetCadRec.FieldByName('CTR_CTPTXE').AsString);
end;

procedure TfrmPrincipal.ValidaEAtualizaVersoesDLLsAPI;
  Var
    LVersaoLibeay32,
    LVersaoSsleay32,
    LVersaoLibeay32AutBan,
    LVersaoSsleay32AutBan: String;
begin
  Try
    LVersaoLibeay32 := untFuncoesSimples.fRetornaVersao(ExtractFilePath(Application.ExeName) + '..\libeay32.dll');
    LVersaoSsleay32 := untFuncoesSimples.fRetornaVersao(ExtractFilePath(Application.ExeName) + '..\ssleay32.dll');

    If LVersaoLibeay32.IsEmpty Then
      Exit;

    If LVersaoSsleay32.IsEmpty Then
      Exit;

    LVersaoLibeay32AutBan := untFuncoesSimples.fRetornaVersao(ExtractFilePath(Application.ExeName) + 'libeay32.dll');
    LVersaoSsleay32AutBan := untFuncoesSimples.fRetornaVersao(ExtractFilePath(Application.ExeName) + 'ssleay32.dll');

    If (LVersaoLibeay32 <> LVersaoLibeay32AutBan) Then
      CopyFile(PWideChar(ExtractFilePath(Application.ExeName) + '..\libeay32.dll'), PWideChar(ExtractFilePath(Application.ExeName) + 'libeay32.dll'), False);

    If (LVersaoSsleay32 <> LVersaoSsleay32AutBan) Then
      CopyFile(PWideChar(ExtractFilePath(Application.ExeName) + '..\ssleay32.dll'), PWideChar(ExtractFilePath(Application.ExeName) + 'ssleay32.dll'), False);
  Except

  End;
end;

function TfrmPrincipal.VerificaPermissaoParaBaixaEmEmpresaDiferenteDoCadastro: Boolean;
begin
  Result := True;

  If Not FBaixaEmpresaCadastro Then
    Exit;

  If (LQryRetBcoGer.FieldByName('RET_CODEMP').AsString <> VS_strCodEmp)  Then
  Begin
    If Not (LQryRetBcoGer.FieldByName('RET_DUPDIV').AsString.Equals('S') And
           (Pos('DUPLICATA NÃO PERTENCE A EMPRESA LOGADA',LQryRetBcoGer.FieldByName('RET_MOTDIV').AsString) > 0)) Then

      AtualizaDivergenciaRetBco(LQryRetBcoGer.FieldByName('RET_NUMDUP').AsString,
                                LQryRetBcoGer.FieldByName('RET_PARCEL').AsString,
                                LQryRetBcoGer.FieldByName('RET_ESPDOC').AsString,
                                LQryRetBcoGer.FieldByName('RET_CODEMP').AsString,
                                LQryRetBcoGer.FieldByName('RET_CODCLI').AsString,
                                'DUPLICATA NÃO PERTENCE A EMPRESA LOGADA');
    Result := False;
  End Else
  Begin
    If LQryRetBcoGer.FieldByName('RET_DUPDIV').AsString.Equals('S') And
       (Pos('DUPLICATA NÃO PERTENCE A EMPRESA LOGADA',LQryRetBcoGer.FieldByName('RET_MOTDIV').AsString) > 0) Then
    Begin
      AtualizaDivergenciaRetBco(LQryRetBcoGer.FieldByName('RET_NUMDUP').AsString,
                                LQryRetBcoGer.FieldByName('RET_PARCEL').AsString,
                                LQryRetBcoGer.FieldByName('RET_ESPDOC').AsString,
                                LQryRetBcoGer.FieldByName('RET_CODEMP').AsString,
                                LQryRetBcoGer.FieldByName('RET_CODCLI').AsString,
                                '',
                                False);
    End;
    Result := True;
  End;
end;


function TfrmPrincipal.VerificaSeOperadorPossuiDireitoABaixaNaEmpresa(AEmpresasComDireito: String): Boolean;
begin

  If Not ((LQryRetBcoGer.FieldByName('RET_VALPAG').AsFloat <> 0.0) And
          (LQryRetBcoGer.FieldByName('RET_DTAPAG').Value <> Null)) Then
    Exit(True);

  If Not (Pos(LQryRetBcoGer.FieldByName('RET_CODEMP').AsString, AEmpresasComDireito) > 0) Then
  Begin
    If Not (LQryRetBcoGer.FieldByName('RET_DUPDIV').AsString.Equals('S') And
           (Pos('NÃO TEM PERMISSÃO PARA FAZER BAIXA NA EMPRESA',LQryRetBcoGer.FieldByName('RET_MOTDIV').AsString) > 0)) Then
      AtualizaDivergenciaRetBco(LQryRetBcoGer.FieldByName('RET_NUMDUP').AsString,
                                LQryRetBcoGer.FieldByName('RET_PARCEL').AsString,
                                LQryRetBcoGer.FieldByName('RET_ESPDOC').AsString,
                                LQryRetBcoGer.FieldByName('RET_CODEMP').AsString,
                                LQryRetBcoGer.FieldByName('RET_CODCLI').AsString,
                                'OPERADOR '+strLoginUsuarioLogado+' NÃO TEM PERMISSÃO PARA FAZER BAIXA NA EMPRESA ' + LQryRetBcoGer.FieldByName('RET_CODEMP').AsString);
    Result := False;
  End Else
  Begin
    If LQryRetBcoGer.FieldByName('RET_DUPDIV').AsString.Equals('S') And
       (Pos('NÃO TEM PERMISSÃO PARA FAZER BAIXA NA EMPRESA',LQryRetBcoGer.FieldByName('RET_MOTDIV').AsString) > 0) Then
    Begin
      AtualizaDivergenciaRetBco(LQryRetBcoGer.FieldByName('RET_NUMDUP').AsString,
                                LQryRetBcoGer.FieldByName('RET_PARCEL').AsString,
                                LQryRetBcoGer.FieldByName('RET_ESPDOC').AsString,
                                LQryRetBcoGer.FieldByName('RET_CODEMP').AsString,
                                LQryRetBcoGer.FieldByName('RET_CODCLI').AsString,
                                '',
                                False);
    End;
    Result := True;
  End;
end;

{**********************************************}
{* MONTA MENU NOVAMENTE COM OS NOMES CORRETOS *}
{* E GERA O VETOR COM OS NOMES DOS FORMS E OS *}
{* INDICES                                    *}
{*******************************************AF*}
procedure TfrmPrincipal.pGeraVetor;
  Var
    intContador: Integer;
    strValor: String;
Begin
  {**************}
  {* ZERA VETOR *}
  {***********AF*}
  SetLength(arrMenu,0);

  For intContador := 0 To FrameMenu.trvMenu.Items.Count -1 Do
  Begin
    strValor := Trim(RightStr(FrameMenu.trvMenu.Items[intContador].Text, Length(FrameMenu.trvMenu.Items[intContador].Text) - Pos('>', FrameMenu.trvMenu.Items[intContador].Text)));
    //FrameMenu.trvMenu.Items[intContador].Text := LeftStr(FrameMenu.trvMenu.Items[intContador].Text, Pos('>', FrameMenu.trvMenu.Items[intContador].Text)-1);

    SetLength(arrMenu,Length(arrMenu)+1);

    arrMenu[intContador].strNomform := strValor;
  End;

End;

procedure TfrmPrincipal.pGetDiasParaCreditoOcorrencia01(ABanco: String; ACodOco: String; ACarteira: Integer);
Var
   LDiasParaCredito: string;
begin
  If Not SameText(ABanco, '136') Then
    Exit;

  If SameText(ACodOco, '01') Then
    LDiasParaCredito := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(ACarteira),'DIACR01','')
  Else
    LDiasParaCredito := fGetBancoConfig(0,'CONFIG136_400p-' + IntToStr(ACarteira),'DIACRED','');

  If Not fEmptyStr(LDiasParaCredito) Then
    intDiaCred :=  StrToIntDef(LDiasParaCredito, 0);
end;

procedure TfrmPrincipal.pGravaCtrBan(strAutCtr, strAutCtb, strAutCtp: String;
                                     intTipDes: Integer = 2;
                                     AOcorrencia: String = '';
                                     AMotivo: String = '');
  Var
    qryGravar: TUniQuery;
begin
  Try
    qryGravar := fCriaQuery;
    qryGravar.Close;
    qryGravar.SQL.Clear;
    qryGravar.SQL.Add('INSERT INTO CTRBAN (BAN_AUTCTR, BAN_AUTCTB, BAN_AUTCTP, BAN_TIPDES, BAN_CODOCO, BAN_MOTOCO) ');
    qryGravar.SQL.Add(' VALUES            (:AUTCTR,    :AUTCTB,    :AUTCTP,    :TIPDES,    :CODOCO,   :MOTOCO)     ');

    qryGravar.ParamByName('AUTCTR').AsString := strAutCtr;
    qryGravar.ParamByName('AUTCTB').AsString := strAutCtb;
    qryGravar.ParamByName('AUTCTP').AsString := strAutCtp;

    Case intTipDes Of
      1   : qryGravar.ParamByName('TIPDES').AsString := 'IOF';
      2   : qryGravar.ParamByName('TIPDES').AsString := 'BOLETO';
      3   : qryGravar.ParamByName('TIPDES').AsString := 'DESCONTADA';
      4   : qryGravar.ParamByName('TIPDES').AsString := 'JUROS OPERAÇÃO';
      Else  qryGravar.ParamByName('TIPDES').AsString := 'CARTORIO/OUTROS';
    End;

    qryGravar.ParamByName('CODOCO').AsString := AOcorrencia;
    qryGravar.ParamByName('MOTOCO').AsString := AMotivo;
    qryGravar.ExecSQL;
  Except
    On E:Exception Do
      Raise Exception.Create('Ocorreu um erro ao vincular as tarifas com o Contas a Receber.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

procedure TfrmPrincipal.AtualizaDespesasDeCobranca(ADatasetCadRec,
  ADatasetRetBco: TDataset);
  Var
    LUpdate: TUniQuery;
begin
  LUpdate := fCriaQuery;
  Try
    LUpdate.SQL.Text := 'UPDATE CADREC ' +
                        'SET CTR_DESCOB = :DESCOB ' +
                        'WHERE AUTOINCREM = :AUTINC ';

    LUpdate.ParamByName('DESCOB').AsFloat := ADatasetCadRec.FieldByName('CTR_DESCOB').AsFloat +
                                             ADatasetRetBco.FieldByName('RET_OUTVAL').AsFloat;
    LUpdate.ParamByName('AUTINC').AsString := ADatasetCadRec.FieldByName('AUTOINCREM').AsString;

    LUpdate.ExecSQL;

    untLogCtr.GravaLogCtr(ADatasetCadRec.FieldByName('AUTOINCREM').AsString,
                          'ATUALIZAÇÃO DE DESPESA COBRANÇA(AUTBAN)',
                          Self.Name,
                          '',
                          0,
                          0,
                          '',
                          '',
                          Nil,
                          fProximoAutoIncremReservado(FReservaLogCtr, ADatasetCadRec.FieldByName('CTR_CODEMP').AsString));
  Finally
    LUpdate.Close;
    FreeAndNil(LUpdate);
  End;
end;

procedure TfrmPrincipal.AtualizaDivergenciaRetBco(strNumDup, strParcel, strEspDoc,
  strCodEmp, strCodCli, strMotDiv: String; AComDivergencia: Boolean = True);
  Var
    qryAux : TUniQuery;
    strSQL : String;
begin

  qryAux := fCriaQuery(Nil);

  strSQL := '';
  strSQL := strSQL + ' UPDATE                     ';
  strSQL := strSQL + '   RETBCO                   ';
  strSQL := strSQL + ' SET                        ';

  if AComDivergencia Then
    strSQL := strSQL + '   RET_DUPDIV = "S",      '
  else
    strSQL := strSQL + '   RET_DUPDIV = "N",      ';

  strSQL := strSQL + '   RET_MOTDIV = :MOTDIV     ';
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '   RET_NUMDUP = :NUMDUP     ';
  strSQL := strSQL + '   AND RET_PARCEL = :PARCEL ';
  strSQL := strSQL + '   AND RET_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '   AND RET_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND RET_CODCLI = :CODCLI ';

  With qryAux Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If AComDivergencia then
      ParamByName('MOTDIV').AsString := strMotDiv
    else
      ParamByName('MOTDIV').Value := Null;

    ParamByName('NUMDUP').AsString := strNumDup;
    ParamByName('PARCEL').AsString := strParcel;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;
    ExecSQL;
  End;

  FreeAndNil(qryAux);

end;

procedure TfrmPrincipal.pGravaHisRet(qryDados: TUniQuery; strNomBanco: String);
  Var
    qryHisRet: TUniQuery;
    strSQL   : String;
begin
  strSQL := '';
  strSQL := strSQL + ' INSERT INTO          ';
  strSQL := strSQL + '   HISRET ( ';
  strSQL := strSQL + '          HIS_NUMDUP, ';
  strSQL := strSQL + '          HIS_PARCEL, ';
  strSQL := strSQL + '          HIS_SEQBAI, ';
  strSQL := strSQL + '          HIS_ESPDOC, ';
  strSQL := strSQL + '          HIS_CODCLI, ';
  strSQL := strSQL + '          HIS_CODEMP, ';
  strSQL := strSQL + '          HIS_DTAIMP, ';
  strSQL := strSQL + '          HIS_DTAOCO, ';
  strSQL := strSQL + '          HIS_CODOCO, ';
  strSQL := strSQL + '          HIS_DESOCO, ';
  strSQL := strSQL + '          HIS_NOMARQ, ';
  strSQL := strSQL + '          HIS_MOTOCO, ';
  strSQL := strSQL + '          HIS_CODBCO, ';
  strSQL := strSQL + '          HIS_CARTEI, ';
  strSQL := strSQL + '          HIS_DTAPAG, ';
  strSQL := strSQL + '          HIS_VALPAG, ';
  strSQL := strSQL + '          HIS_DTAVEN, ';
  strSQL := strSQL + '          HIS_DESCON, ';
  strSQL := strSQL + '          HIS_JURMOR, ';
  strSQL := strSQL + '          HIS_DESCOB  ';
  strSQL := strSQL + '         )            ';
  strSQL := strSQL + ' VALUES(              ';
  strSQL := strSQL + '        :NUMDUP,      ';
  strSQL := strSQL + '        :PARCEL,      ';
  strSQL := strSQL + '        :SEQBAI,      ';
  strSQL := strSQL + '        :ESPDOC,      ';
  strSQL := strSQL + '        :CODCLI,      ';
  strSQL := strSQL + '        :CODEMP,      ';
  strSQL := strSQL + '        :DTAIMP,      ';
  strSQL := strSQL + '        :DTAOCO,      ';
  strSQL := strSQL + '        :CODOCO,      ';
  strSQL := strSQL + '        :DESOCO,      ';
  strSQL := strSQL + '        :NOMARQ,      ';
  strSQL := strSQL + '        :MOTOCO,      ';
  strSQL := strSQL + '        :CODBCO,      ';
  strSQL := strSQL + '        :CARTEI,      ';
  strSQL := strSQL + '        :DTAPAG,      ';
  strSQL := strSQL + '        :VALPAG,      ';
  strSQL := strSQL + '        :DTAVEN,      ';
  strSQL := strSQL + '        :DESCON,      ';
  strSQL := strSQL + '        :JURMOR,      ';
  strSQL := strSQL + '        :DESCOB       ';
  strSQL := strSQL + '       )              ';

  qryHisRet := fCriaQuery(Nil);

  Try
    qryHisRet.SQL.Text := strSQL;
    qryHisRet.ParamByName('NUMDUP').AsString  := qryDados.FieldByName('RET_NUMDUP').AsString;
    qryHisRet.ParamByName('PARCEL').AsString  := qryDados.FieldByName('RET_PARCEL').AsString;
    qryHisRet.ParamByName('SEQBAI').AsInteger := 0;
    qryHisRet.ParamByName('ESPDOC').AsString  := qryDados.FieldByName('RET_ESPDOC').AsString;
    qryHisRet.ParamByName('CODCLI').AsString  := qryDados.FieldByName('RET_CODCLI').AsString;
    qryHisRet.ParamByName('CODEMP').AsString  := qryDados.FieldByName('RET_CODEMP').AsString;
    qryHisRet.ParamByName('DTAIMP').AsDateTime:= VS_Date;
    qryHisRet.ParamByName('DTAOCO').AsDateTime:= qryDados.FieldByName('RET_DTAOCO').AsDateTime;
    qryHisRet.ParamByName('CODOCO').AsString  := qryDados.FieldByName('RET_CODOCO').AsString;
    qryHisRet.ParamByName('DESOCO').AsString  := fRetDescOco(qryDados.FieldByName('RET_CODBCO').AsString,
                                                             qryDados.FieldByName('RET_CODOCO').AsString,
                                                             strNomBanco);
    qryHisRet.ParamByName('NOMARQ').AsString  := qryDados.FieldByName('RET_NOMARQ').AsString;
    qryHisRet.ParamByName('MOTOCO').AsString  := qryDados.FieldByName('RET_MOTOCO').AsString;
    qryHisRet.ParamByName('CODBCO').AsString  := qryDados.FieldByName('RET_CODBCO').AsString;
    qryHisRet.ParamByName('CARTEI').AsString  := qryDados.FieldByName('RET_CARTEI').AsString;
    qryHisRet.ParamByName('DTAPAG').AsDateTime:= qryDados.FieldByName('RET_DTAPAG').AsDateTime;
    qryHisRet.ParamByName('VALPAG').AsFloat   := qryDados.FieldByName('RET_VALPAG').AsFloat;
    qryHisRet.ParamByName('DTAVEN').AsDateTime:= qryDados.FieldByName('RET_DTAVEN').AsDateTime;
    qryHisRet.ParamByName('DESCON').AsFloat   := qryDados.FieldByName('RET_DESCON').AsFloat;
    qryHisRet.ParamByName('JURMOR').AsFloat   := qryDados.FieldByName('RET_JURMOR').AsFloat;
    qryHisRet.ParamByName('DESCOB').AsFloat   := qryDados.FieldByName('RET_OUTVAL').AsFloat;

    qryHisRet.ExecSQL;
  Finally
    qryHisRet.Close;

    FreeAndNil(qryHisRet);
  End;
end;

procedure TfrmPrincipal.pMostraDupNBaixadas(strCodBco: String);
begin
  If (Not Assigned(cdsNaoBai)) Then
    Exit;

  If (cdsNaoBai.IsEmpty) Then
    Exit;

  pCriarFormularios(TfrmArqDivRetBco, frmArqDivRetBco);

  frmArqDivRetBco.frxDBNaoGra.Dataset := cdsNaoBai;
  frmArqDivRetBco.frxReportJ.Script.Variables['NOMEMP'] := VS_strCodEmp + ' - ' + fRetNomeEmpresa;
  frmArqDivRetBco.frxReportJ.Script.Variables['NOMREL'] := 'DUPLICATAS COM DIVERGÊNCIAS - ' + strCodBco;
  TfrxMemoView(frmArqDivRetBco.frxReportJ.FindObject('rllZebra')).Highlight.Color := fCfgSis('CORZEB');

  If fCfgSis('ENCBAN') <> 'S' Then
  Begin
    TfrxMemoView(frmArqDivRetBco.frxReportJ.FindObject('rllTarifaCarteira')).Visible := False;
    TfrxMemoView(frmArqDivRetBco.frxReportJ.FindObject('rllTarifaCarteiraValor')).Visible := False;
    TfrxMemoView(frmArqDivRetBco.frxReportJ.FindObject('rllTarifaDuplicata')).Visible := False;
    TfrxMemoView(frmArqDivRetBco.frxReportJ.FindObject('rllTarifaDuplicataValor')).Visible := False;

    TfrxMemoView(frmArqDivRetBco.frxReportJ.FindObject('Memo9')).Left :=
        TfrxMemoView(frmArqDivRetBco.frxReportJ.FindObject('rllTarifaDuplicata')).Left;

    TfrxMemoView(frmArqDivRetBco.frxReportJ.FindObject('Memo15')).Left :=
        TfrxMemoView(frmArqDivRetBco.frxReportJ.FindObject('rllTarifaDuplicataValor')).Left;
  End;

  pPreviewReport('frmArqDivRetBco', 'Duplicatas com divergências - ' + strCodBco, frmArqDivRetBco.frxReportJ);

  FreeAndNil(frmArqDivRetBco);
end;

procedure TfrmPrincipal.pRelatorioNosNum(strCodBco: String);
var
  qryRelatorio: TUniQuery;
begin
  qryRelatorio := fCriaQuery;

  with qryRelatorio do
  begin
    Sql.Text := ' SELECT ' +
                '   R.*, ' +
                '   R1.CTR_DTAVEN, ' +
                '   CONCAT(C.CLI_CODCLI, " - ", C.CLI_NOMCLI) AS CTR_CLIENTE,      ' +
                '   CONCAT(B.BCO_CODBCO, " - ", B.BCO_NOMBCO) AS CTR_BANCO_ ' +
                ' FROM ' +
                '   CADREC_BOL R ' +
                ' LEFT JOIN CADCLI C ON C.CLI_CODCLI = R.CTR_CODCLI ' +
                ' LEFT JOIN CADBCO B ON B.BCO_CODBCO = R.CTR_BCOBOL ' +
                ' LEFT JOIN CADREC R1 ON R1.AUTOINCREM = R.AUTOINCREM ';

    if strCodBco <> '' then
    begin
      Sql.Text := Sql.Text + ' WHERE R.CTR_BCOBOL = :BCOBOL ' ;

      ParamByName('BCOBOL').AsString := strCodBco;
    end;

    Open;

    if not isEmpty then
    begin
      frmRelNossoNum := TfrmRelNossoNum.Create(Nil);

      try
        frmRelNossoNum.dsRegistros.DataSet := qryRelatorio;
        frmRelNossoNum.pExportaExcel;
      finally
        frmRelNossoNum.Free;
      end;
    end;
  end;

  FreeAndNil(qryRelatorio);
end;

procedure TfrmPrincipal.pRemoveNomeForms;
  Var
    intContador: Integer;
Begin

  For intContador := 0 To FrameMenu.trvMenu.Items.Count -1 Do
  Begin
    FrameMenu.trvMenu.Items[intContador].Text := LeftStr(FrameMenu.trvMenu.Items[intContador].Text, Pos('>', FrameMenu.trvMenu.Items[intContador].Text)-1);
  End;

End;


procedure TfrmPrincipal.pRestaurarBoleto(AAutoIncremento, ACodigoBanco,
  ANumeroDuplicata, AParcela, AEspecieDocumento, ACodigoEmpresa, ACodigoCliente,
  ACodigoOcorrencia, AMotivoOcorrencia, ACnab: String);
const
  LSQL : String = ' UPDATE CADREC '
                + ' SET CTR_BCOENV = NULL, '
                + '     CTR_DTAENV = NULL, '
                + '     CTR_CTREME = NULL, '
                + '     CTR_NOSNUM = NULL, '
                + '     CTR_DTABOL = NULL, '
                + '     CTR_BCOBOL = NULL, '
                + '     CTR_CARTEI = NULL, '
                + '     CTR_LINDIG = NULL  '
                + ' WHERE '
                + '   CTR_NUMDUP = :NUMDUP AND '
                + '   CTR_PARCEL = :PARCEL AND '
                + '   CTR_ESPDOC = :ESPDOC AND '
                + '   CTR_CODEMP = :CODEMP AND '
                + '   CTR_CODCLI = :CODCLI AND '
                + '   CTR_SEQBAI = 0 ';
var
  LQryUpdate : TUniQuery;
begin
  LQryUpdate := fCriaQuery(Self);

  try

    LQryUpdate.Close;
    LQryUpdate.SQL.Clear;
    LQryUpdate.SQL.Add(LSQL);
    LQryUpdate.ParamByName('NUMDUP').AsString := ANumeroDuplicata;
    LQryUpdate.ParamByName('PARCEL').AsString := AParcela;
    LQryUpdate.ParamByName('ESPDOC').AsString := AEspecieDocumento;
    LQryUpdate.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LQryUpdate.ParamByName('CODCLI').AsString := ACodigoCliente;
    LQryUpdate.ExecSQL;

    {**************************}
    {* GRAVA LOG DA ALTERAÇÃO *}
    {***********************JS*}
    untLogCtr.GravaLogCtr(AAutoIncremento,
                          'BOLETO RESTAURADO COM OCORRENCIA 09 (AUTBAN)',
                          'frmPrincipal',
                          '',
                          0,
                          0,
                          '',
                          '',
                          Nil,
                          fProximoAutoIncremReservado(FReservaLogCtr, ACodigoEmpresa));

    pApagaRetBco(LeftStr(ACodigoBanco, 3),
                 ANumeroDuplicata,
                 AParcela,
                 AEspecieDocumento,
                 ACodigoEmpresa,
                 ACodigoCliente,
                 ACodigoOcorrencia,
                 ACnab,
                 AMotivoOcorrencia);

  finally
    if Assigned(LQryUpdate) then
      FreeandNil(LQryUpdate);
  end;
end;

procedure TfrmPrincipal.pStepStatusSelecao(pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Position := pgbStatus.Position + 1;
    Application.ProcessMessages;
  End;
end;

function TfrmPrincipal.fSelecionaPortadorPlanodeContas(strConfig: String;
  cdsConRet: TUniClientDataSet; qryRetBco: TUniQuery): Boolean;
begin
  {*************************************************}
  {* PEGANDO PORTADOR E PLANO DE CONTAS PARA BAIXA *}
  {**********************************************AJ*}
  Result    := True;
  strPorBai := fGetBancoConfig(0, strConfig, 'PORBAI_', '');
  strCtaBai := fGetBancoConfig(0, strConfig, 'CTABAI_', '');
  strPorDes := fGetBancoConfig(0, strConfig, 'PORTDES', '');

  If (Copy(strConfig, 7, 3) = '001') And (blnBcoBra7d) Then
  Begin

    If fEmptyStr(fGetBancoConfig(0, strConfig, 'PORBAI_', '')) Or
       fEmptyStr(fGetBancoConfig(0, strConfig, 'CTABAI_', '')) Or
       fEmptyStr(fGetBancoConfig(0, strConfig, 'PORBAII', '')) Or
       fEmptyStr(fGetBancoConfig(0, strConfig, 'CTABAII', '')) Or
       fEmptyStr(fGetBancoConfig(0, strConfig, 'PORBAID', '')) Or
       fEmptyStr(fGetBancoConfig(0, strConfig, 'CTABAID', '')) Or
       fEmptyStr(fGetBancoConfig(0, strConfig, 'PORBAIR', '')) Or
       fEmptyStr(fGetBancoConfig(0, strConfig, 'CTABAIR', '')) Or
       fEmptyStr(fGetBancoConfig(0, strConfig, 'PORBAIV', '')) Or
       fEmptyStr(fGetBancoConfig(0, strConfig, 'CTABAIV', '')) Then
    Begin
      fMensagem('','Existem portadores ou contas não cadastrados. Verifique!',['&OK']);
      Exit;
    End;

    If LeftStr(qryRetBco.FieldByName('RET_NOMARQ').AsString,1) = '1' Then
    Begin
      strPorBai := fGetBancoConfig(0, strConfig, 'PORBAI_', '');
      strCtaBai := fGetBancoConfig(0, strConfig, 'CTABAI_', '');
    End
    Else If LeftStr(qryRetBco.FieldByName('RET_NOMARQ').AsString,1) = '2' Then
    Begin
      strPorBai := fGetBancoConfig(0, strConfig, 'PORBAII', '');
      strCtaBai := fGetBancoConfig(0, strConfig, 'CTABAII', '');
    End
    Else If LeftStr(qryRetBco.FieldByName('RET_NOMARQ').AsString,1) = '4' Then
    Begin
      strPorBai := fGetBancoConfig(0, strConfig, 'PORBAID', '');
      strCtaBai := fGetBancoConfig(0, strConfig, 'CTABAID', '');
    End
    Else If LeftStr(qryRetBco.FieldByName('RET_NOMARQ').AsString,1) = '7' Then
    Begin
      strPorBai := fGetBancoConfig(0, strConfig, 'PORBAIR', '');
      strCtaBai := fGetBancoConfig(0, strConfig, 'CTABAIR', '');
    End
    Else If LeftStr(qryRetBco.FieldByName('RET_NOMARQ').AsString,1) = '8' Then
    Begin
      strPorBai := fGetBancoConfig(0, strConfig, 'PORBAIV', '');
      strCtaBai := fGetBancoConfig(0, strConfig, 'CTABAIV', '');
    End
    Else
    Begin
      fMensagem('','Tipo de cobrança não suportado pelo AutBan! Entre em contato com a Citel!',['&OK']);
      Result := False;
    End;

  End
  Else If (Copy(strConfig, 7, 4) = '033B') And Assigned(cdsConRet) Then
  Begin
    If (Not cdsConRet.IsEmpty) And
       cdsConRet.Locate('CONRET', qryRetBco.FieldByName('RET_CONRET').AsString, []) Then
    Begin
      strPorBai := cdsConRet.FieldByName('PORBAI').AsString;
      strCtaBai := cdsConRet.FieldByName('CONBAI').AsString;
    End;
  End
  Else If (Copy(strConfig, 7, 3) = '341') Then
  Begin
    if (Copy(strConfig, 11, 1) = '0') then
    begin
      strPorBai := fGetBancoConfig(0, 'CONFIGIEPTBSP', 'PORBAI_', '');
      strCtaBai := fGetBancoConfig(0, 'CONFIGIEPTBSP', 'CTABAI_', '');
    end
    else
    begin
      strPorBai := fGetBancoConfig(0, strConfig, 'PORBAI_', '');
      strCtaBai := fGetBancoConfig(0, strConfig, 'CTABAI_', '');
    end;
  End
  Else If Copy(strConfig, 7, 6).Equals('001API') Then
  Begin
    If fEmptyStr(fGetBancoConfig(0, strConfig, 'PORBAI_', '')) Or
       fEmptyStr(fGetBancoConfig(0, strConfig, 'CTABAI_', '')) Or
       fEmptyStr(fGetBancoConfig(0, strConfig, 'PORBAI_VIN', '')) Or
       fEmptyStr(fGetBancoConfig(0, strConfig, 'CTABAI_VIN', ''))  Then
    Begin
      fMensagem('ATENÇÃO','Existem portadores ou contas não cadastrados. Verifique!',['&OK']);
      Exit(False);
    End;

    If LeftStr(qryRetBco.FieldByName('RET_NOMARQ').AsString,3).Equals('[4]') Then
    Begin
      strPorBai := fGetBancoConfig(0, strConfig, 'PORBAI_VIN', '');
      strCtaBai := fGetBancoConfig(0, strConfig, 'CTABAI_VIN', '');
    End
    Else
     Begin
      strPorBai := fGetBancoConfig(0, strConfig, 'PORBAI_', '');
      strCtaBai := fGetBancoConfig(0, strConfig, 'CTABAI_', '');
    End;

  End
  Else If Copy(strConfig, 7, 6).Equals('097API') Then
  Begin
    If fEmptyStr(fGetBancoConfig(0, strConfig, 'PORBAI_', '')) Or
       fEmptyStr(fGetBancoConfig(0, strConfig, 'CTABAI_', '')) Then
    Begin
      fMensagem('ATENÇÃO','Existem portadores ou contas não cadastrados. Verifique!',['&OK']);
      Exit(False);
    End;

  End;

end;


procedure TfrmPrincipal.AtualizaEventoPortador(ARetBco, AQryAux: TUniQuery; ACodBco: String);
  Var
    LCodEve : String;
    LCodPor : String;
    LBaiRet : Integer;

    LAutoIncremCadRec: String;
begin
  Try
    If (ARetBco.FieldByName('RET_CODBCO').AsString = '033') And (ARetBco.FieldByName('RET_CODOCO').AsString = '10') Then
    Begin
      LCodEve := fRetornaCodEvento(AQryAux,
                                   ARetBco.FieldByName('RET_CODOCO').AsString,
                                   ARetBco.FieldByName('RET_CODBCO').AsString);

      LCodPor := Copy(LCodEve, Pos('_', LCodEve) + 1);
      LCodEve := Copy(LCodEve, 1, Pos('_', LCodEve) - 1);


      LBaiRet := untCadRec.fRetSeqBaiCadRec(ARetBco.FieldByName('RET_NUMDUP').AsString,
                                            ARetBco.FieldByName('RET_PARCEL').AsString,
                                            ARetBco.FieldByName('RET_CODEMP').AsString,
                                            ARetBco.FieldByName('RET_ESPDOC').AsString,
                                            ARetBco.FieldByName('RET_CODCLI').AsString);

      LAutoIncremCadRec := fCampoTabela('AUTOINCREM', 'CADREC',
                                        ['CTR_NUMDUP', 'CTR_PARCEL', 'CTR_ESPDOC', 'CTR_CODEMP', 'CTR_CODCLI', 'CTR_SEQBAI'],
                                        [ARetBco.FieldByName('RET_NUMDUP').AsString, ARetBco.FieldByName('RET_PARCEL').AsString,
                                         ARetBco.FieldByName('RET_ESPDOC').AsString,ARetBco.FieldByName('RET_CODEMP').AsString,
                                         ARetBco.FieldByName('RET_CODCLI').AsString, 0]);

      If fAtualizaCodEve(AQryAux,
                         'CADREC',
                         LCodEve,
                         ARetBco.FieldByName('RET_NUMDUP').AsString,
                         ARetBco.FieldByName('RET_PARCEL').AsString,
                         ARetBco.FieldByName('RET_ESPDOC').AsString,
                         ARetBco.FieldByName('RET_CODEMP').AsString,
                         ARetBco.FieldByName('RET_CODCLI').AsString,
                         LBaiRet,
                         LCodPor) Then
      Begin
          untLogCtr.GravaLogCtr(LAutoIncremCadRec,
                                'ATUALIZAÇÃO EVENTO/PORTADOR (033-OCORRÊNCIA 10) (AUTBAN)',
                                Self.Name,
                                '',
                                0,
                                0,
                                '',
                                '',
                                Nil,
                                fProximoAutoIncremReservado(FReservaLogCtr, ARetBco.FieldByName('RET_CODEMP').AsString));

          pApagaRetBco(LeftStr(ACodBco, 3),
                       ARetBco.FieldByName('RET_NUMDUP').AsString,
                       ARetBco.FieldByName('RET_PARCEL').AsString,
                       ARetBco.FieldByName('RET_ESPDOC').AsString,
                       ARetBco.FieldByName('RET_CODEMP').AsString,
                       ARetBco.FieldByName('RET_CODCLI').AsString,
                       ARetBco.FieldByName('RET_CODOCO').AsString,
                       ARetBco.FieldByName('RET_CNAB__').AsString,
                       ARetBco.FieldByName('RET_MOTOCO').AsString);


          s033Oco10 := True;
      End;

      {*******************************************}
      {* LIMPAR DADOS DUPLICATA BAIXADA NO BANCO *}
      {****************************************AJ*}
      LimpaDadosDuplicatasBaixadasPeloBanco(LAutoIncremCadRec,
                                            '033',
                                            '10');

    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmPrincipal.AtualizaEventoPortador]');
    End;
  End;
end;

procedure TfrmPrincipal.AtualizaQRCodeCADREC(AAutoIncremCadRec, AQRCodeRetBco : String);
var
  LUpdate: TUniQuery;
begin
  if fEmptyStr(AQRCodeRetBco) then
    Exit;

  Try
    if Trim(AQRCodeRetBco) = '' then
      Exit;

    Try
      LUpdate := fCriaQuery;
      LUpdate.SQL.Text := 'UPDATE CADREC              ' +
                          'SET CTR_QRCODE = :QRCODE   ' +
                          'WHERE AUTOINCREM = :AUTINC ';

      LUpdate.ParamByName('QRCODE').AsString := AQRCodeRetBco;
      LUpdate.ParamByName('AUTINC').AsString := AAutoIncremCadRec;

      LUpdate.ExecSQL;

      untLogCtr.GravaLogCtr(AAutoIncremCadRec, 'ATUALIZAÇÃO DE QRCODE (AUTBAN)', Self.Name, '', 0, 0, '', '', Nil, fProximoAutoIncremReservado(FReservaLogCtr, VarToStr(fCampoTabela('CTR_CODEMP', 'CADREC', ['AUTOINCREM'], [AAutoIncremCadRec]))));
    Finally
      LUpdate.Close;
      FreeAndNil(LUpdate);
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmPrincipal.AtualizaQRCodeCADREC]');
    End;
  End;
end;

procedure TfrmPrincipal.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPrincipal.CalculaValorCorrigido(ARetBco:TDataSet);
  Var
    LValorCorrigido: Double;
    LDiferencaNoValorRecebido : Double;
begin
  Try

    If Not ((ARetBco.FieldByName('RET_VALPAG').AsFloat <> 0.0) And
            (ARetBco.FieldByName('RET_DTAPAG').Value <> Null)) Then
      Exit;

    If Not (ARetBco.FieldByName('CTR_DESSUJ').AsFloat > 0.00) Then Exit;

    LValorCorrigido:= ARetBco.FieldByName('CTR_VALDUP').AsFloat + fCalculaJurosCadCtr(fAcertaDataParaDiaUtil(ARetBco.FieldByName('CTR_DTAVEN').AsDateTime),
                                                                                                             ARetBco.FieldByName('RET_DTAPAG').AsString,
                                                                                                             ARetBco.FieldByName('CTR_VALDUP').AsFloat);

    LDiferencaNoValorRecebido := RoundTo(LValorCorrigido - (ARetBco.FieldByName('RET_VALPAG').AsFloat +
                                                            ARetBco.FieldByName('RET_TARIFA').AsFloat),-2);

    If (fFormataFloat(LDiferencaNoValorRecebido,2) > 0) Then
    Begin
      If (LDiferencaNoValorRecebido = ARetBco.FieldByName('CTR_DESSUJ').AsFloat) Then
      Begin
        ARetBco.Edit;
        ARetBco.FieldByName('RET_DESCON').AsFloat := fFormataFloat(ARetBco.FieldByName('RET_DESCON').AsFloat +  LDiferencaNoValorRecebido, 2);

        If (fFormataFloat(ARetBco.FieldByName('CTR_VALDUP').AsFloat - ARetBco.FieldByName('RET_VALDUP').AsFloat , 2) = LDiferencaNoValorRecebido) Then
        Begin
          ARetBco.FieldByName('RET_VALDUP').AsFloat := fFormataFloat(ARetBco.FieldByName('RET_VALDUP').AsFloat + LDiferencaNoValorRecebido, 2);
        End;

        ARetBco.Post;
      End;
    End;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

function TfrmPrincipal.DesmarcandoDuplicatas(pgbProgresso: TcxProgressBar): Boolean;
  Var
    LChaLck: String;
    LStartTransaction : Boolean;
    LCommit: Boolean;
begin
  Try
    Result := True;

    If Not Assigned(LQryRetBcoGer) Then Exit;
    If LQryRetBcoGer.IsEmpty Then Exit;

    LQryRetBcoGer.First;
    pgbProgresso.Position := 0;
    pgbProgresso.Properties.Max := LQryRetBcoGer.RecordCount;

    Try
      While Not LQryRetBcoGer.Eof Do
      Begin
        LChaLck := 'CADREC' +
                   LQryRetBcoGer.FieldByName('RET_NUMDUP').AsString +
                   LQryRetBcoGer.FieldByName('RET_ESPDOC').AsString +
                   LQryRetBcoGer.FieldByName('RET_CODEMP').AsString +
                   LQryRetBcoGer.FieldByName('RET_CODCLI').AsString +
                   LQryRetBcoGer.FieldByName('RET_PARCEL').AsString ;


        LStartTransaction := LQryRetBcoGer.RecNo = 1;  // Inicia a transação no primeiro registro
        LCommit := (LQryRetBcoGer.RecNo = LQryRetBcoGer.RecordCount);  // commit no ultimo registro

        objLock.fLock_Unlock(LChaLck, False, False, False, '',True,'',LStartTransaction,LCommit);

        LQryRetBcoGer.Next;
        pStepStatusSelecao(pgbProgresso);
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmPrincipal.DesmarcandoDuplicatas]');
      End;
    End;
  Finally
    If Assigned(LQryRetBcoGer) Then
      FreeAndNil(LQryRetBcoGer);
    If Assigned(objLock) Then
      FreeAndNil(objLock);
  End;
end;

function TfrmPrincipal.DeveAtualizarDespesaDeCobranca(APermite: Boolean;
  AValorDespesa: Double; ACodigoBanco, AConfiguracao: String): Boolean;
begin
  Result := False;

  If Not APermite Then
    Exit;

  If Not MatchStr(ACodigoBanco, ['341', '001']) Then
    Exit;

  If Not fGetBancoConfig(0, AConfiguracao, 'ATUALIZA_DESPCOB', 'N').Equals('S') Then
    Exit;

  Result := fFormataFloat(AValorDespesa, 2) > 0.00;
end;

function TfrmPrincipal.DeveAtualizarEventoEPortador(ACodigoBanco: String;
                                                    AOcorrencia,
                                                    AMotivo: String): Boolean;
begin
  Result := True;

  If ACodigoBanco = '237' Then
  Begin
    If AOcorrencia = '10' Then
      Result := AMotivo = '20';
  End;
end;

procedure TfrmPrincipal.trvMenuKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_Return Then
  Begin
    trvMenuDblClick(Sender);
  End;
end;

procedure TfrmPrincipal.trvMenuDblClick(Sender: TObject);
  Var
    intCartei  : Integer;
    intIndex   : Integer;
    blnConfirma: Boolean;
    strCarBco  : String;
begin

  {*****************}
  {* CONFIGURAÇOES *}
  {**************AF*}
//  If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigBanespa' Then
//  Begin
//    Try
//      pCriarForm(TfrmConfigBanespa,frmConfigBanespa);
//    Finally
//      FreeAndNil(frmConfigBanespa);
//    End;
//  End

  intIndex := FrameMenu.trvMenu.Selected.AbsoluteIndex;
  blnBcoBra7d := false;

  If arrMenu[intIndex].strNomform = 'frmConfigBradesco' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBradesco,frmConfigBradesco);
      frmConfigBradesco.strConfig := 'CONFIG237-';
      frmConfigBradesco.ShowModal;
    Finally
      FreeAndNil(frmConfigBradesco);
    End;

  End
  Else
  If arrMenu[intIndex].strNomform = 'frmConfigDaycoval400' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigDaycoval, frmConfigDaycoval);
      frmConfigDaycoval.strConfig := 'CONFIG995-';
      frmConfigDaycoval.ShowModal;
    Finally
      FreeAndNil(frmConfigDaycoval);
    End;

  End

  {******************************************}
  {*        BANCO DAYCOVAL [400P]           *}
  {*            LAYOUT PRÓPRIO              *}
  {*REQ:147378****************************MT*}
  Else
  If arrMenu[intIndex].strNomform = 'frmConfigDaycoval_707[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigDaycoval_707,frmConfigDaycoval_707);
      frmConfigDaycoval_707.strConfig := 'CONFIG707-';
      frmConfigDaycoval_707.ShowModal;
    Finally
      FreeAndNil(frmConfigDaycoval_707);
    End;

  End

  Else
  If arrMenu[intIndex].strNomform = 'frmConfigSBCredito_988[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSBCredito,frmConfigSBCredito);
      frmConfigSBCredito.strConfig := 'CONFIG988-';
      frmConfigSBCredito.ShowModal;
    Finally
      FreeAndNil(frmConfigSBCredito);
    End;

  End

  // **********************************
  // *     SB CREDITO BRADESCO        *
  // **********************************
  Else
  If arrMenu[intIndex].strNomform = 'frmConfigSBCredito_Bradesco_987[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSBCredito_Bradesco,frmConfigSBCredito_Bradesco);
      frmConfigSBCredito_Bradesco.strConfig := 'CONFIG987-';
      frmConfigSBCredito_Bradesco.ShowModal;
    Finally
      FreeAndNil(frmConfigSBCredito_Bradesco);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigSerrana' Then
    TSerranaMenu.Configuracao

  Else If arrMenu[intIndex].strNomform = 'frmConfigRubi' Then
    TRubiMenu.Configuracao

  Else
  If arrMenu[intIndex].strNomform = 'frmConfigBancoInter' Then
    TBancoInterMenu.Configuracao

  Else If arrMenu[intIndex].strNomform = 'frmConfigBancoDoBrasilApi' Then
    TBancoDoBrasilMenu.Configuracao

  Else If arrMenu[intIndex].strNomform = 'frmConfigBancoCredisisApi' Then
    TBancoCredisisMenu.Configuracao

  Else If arrMenu[intIndex].strNomform = 'frmConfigBancoSicrediApi' Then
    TBancoSicrediMenu.Configuracao

  Else If arrMenu[intIndex].strNomform = 'frmConfigItauApi' Then
    TItauMenu.Configuracao

  Else If arrMenu[intIndex].strNomform = 'frmConfigSicoobApi' Then
    TBancoSicoobMenu.Configuracao

  Else If arrMenu[intIndex].strNomform = 'frmConfigSantanderApi' Then
    TBancoSantanderMenu.Configuracao

  Else If arrMenu[intIndex].strNomform = 'frmConfigBradescoApi' Then
    TBancoBradescoMenu.Configuracao

  Else
  If arrMenu[intIndex].strNomform = 'frmConfigFomentoMercantil400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigFomentoMercantil400,frmConfigFomentoMercantil400);
      frmConfigFomentoMercantil400.strConfig := 'CONFIG994-';
      frmConfigFomentoMercantil400.ShowModal;
    Finally
      FreeAndNil(frmConfigFomentoMercantil400);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigBMPMoneyPlus' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBMPMoneyPlus,frmConfigBMPMoneyPlus);
      frmConfigBMPMoneyPlus.ShowModal;
    Finally
      FreeAndNil(frmConfigBMPMoneyPlus);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigBmpMoneyPlus_LP_400nv' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBMPMoneyPlus_LP_400, frmConfigBMPMoneyPlus_LP_400);
      frmConfigBMPMoneyPlus_LP_400.strConfig := 'CONFIG274LP400p-';
      frmConfigBMPMoneyPlus_LP_400.ShowModal;
    Finally
      FreeAndNil(frmConfigBMPMoneyPlus_LP_400);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigAthenaAtlanta400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigAthenaAtlanta,frmConfigAthenaAtlanta);
      frmConfigAthenaAtlanta.strConfig := 'CONFIG996-';
      frmConfigAthenaAtlanta.ShowModal;
    Finally
      FreeAndNil(frmConfigAthenaAtlanta);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigMultibank400' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigMultibank, frmConfigMultibank);
      frmConfigMultibank.strConfig := 'CONFIG983-';
      frmConfigMultibank.ShowModal;
    Finally
      FreeAndNil(frmConfigMultibank);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigBancoJpiFidc' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigJpiFidc, frmConfigJpiFidc);
      frmConfigJpiFidc.strConfig := 'CONFIG906-';
      frmConfigJpiFidc.ShowModal;
    Finally
      FreeAndNil(frmConfigJpiFidc);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigBancoCapitalFinancas' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCapitalFinancas, frmConfigCapitalFinancas);
      frmConfigCapitalFinancas.strConfig := 'CONFIG978-';
      frmConfigCapitalFinancas.ShowModal;
    Finally
      FreeAndNil(frmConfigCapitalFinancas);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigBancoSrm' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigSRM, frmConfigSRM);
      frmConfigSRM.strConfig := 'CONFIG990-';
      frmConfigSRM.ShowModal;
    Finally
      FreeAndNil(frmConfigSRM);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigBancoFidussia' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigFidussia, frmConfigFidussia);
      frmConfigFidussia.strConfig := 'CONFIG970-';
      frmConfigFidussia.ShowModal;
    Finally
      FreeAndNil(frmConfigFidussia);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigBancoMultiplike' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigMultiplike, frmConfigMultiplike);
      frmConfigMultiplike.strConfig := 'CONFIG981-';
      frmConfigMultiplike.ShowModal;
    Finally
      FreeAndNil(frmConfigMultiplike);
    End;
  End

  Else
  If arrMenu[intIndex].strNomform = 'frmConfigRedasset' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigRedasset, frmConfigRedasset);
      frmConfigRedasset.strConfig := 'CONFIG993-';
      frmConfigRedasset.ShowModal;
    Finally
      FreeAndNil(frmConfigRedasset);
    End;

  End
  Else
  If arrMenu[intIndex].strNomform = 'frmConfigCreditBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCreditBrasil, frmConfigCreditBrasil);
      frmConfigCreditBrasil.strConfig := 'CONFIG992-';
      frmConfigCreditBrasil.ShowModal;
    Finally
      FreeAndNil(frmConfigCreditBrasil);
    End;

  End
  Else
  If arrMenu[intIndex].strNomform = 'frmConfigGarsonCredito' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigGarsonCredito, frmConfigGarsonCredito);
      frmConfigGarsonCredito.strConfig := 'CONFIG997-';
      frmConfigGarsonCredito.ShowModal;
    Finally
      FreeAndNil(frmConfigGarsonCredito);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSifra, frmConfigSifra);
      frmConfigSifra.strConfig := 'CONFIG998-';
      frmConfigSifra.ShowModal;
    Finally
      FreeAndNil(frmConfigSifra);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmConfigGrupoSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigGrupoSifra, frmConfigGrupoSifra);
      frmConfigGrupoSifra.strConfig := 'CONFIG979-';
      frmConfigGrupoSifra.ShowModal;
    Finally
      FreeAndNil(frmConfigGrupoSifra);
    End;

  End
  Else
  If arrMenu[intIndex].strNomform = 'frmConfigUnicred400_136' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigUnicred400_136, frmConfigUnicred400_136);
      frmConfigUnicred400_136.strConfig := 'CONFIG136_400p';
      frmConfigUnicred400_136.ShowModal;
    Finally
      FreeAndNil(frmConfigUnicred400_136);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigUniprime400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigUniprime400,frmConfigUniprime400);
      frmConfigUniprime400.strConfig := 'CONFIG099-';
      frmConfigUniprime400.ShowModal;
    Finally
      FreeAndNil(frmConfigUniprime400);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigBcoSisprime' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigSisprime , frmConfigSisprime);
      frmConfigSisprime.strConfig := 'CONFIG084-';
      frmConfigSisprime.ShowModal;
    Finally
      FreeAndNil(frmConfigSisprime);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigLakeBank' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigLakeBank , frmConfigLakeBank);
      frmConfigLakeBank.strConfig := 'CONFIG977-';
      frmConfigLakeBank.ShowModal;
    Finally
      FreeAndNil(frmConfigLakeBank);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigLotus' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigLotus , frmConfigLotus);
      frmConfigLotus.strConfig := 'CONFIG976-';
      frmConfigLotus.ShowModal;
    Finally
      FreeAndNil(frmConfigLotus);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigJPCapital' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigJPCapital , frmConfigJPCapital);
      frmConfigJPCapital.strConfig := 'CONFIG975-';
      frmConfigJPCapital.ShowModal;
    Finally
      FreeAndNil(frmConfigJPCapital);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigOlam' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigOlam , frmConfigOlam);
      frmConfigOlam.strConfig := 'CONFIG974-';
      frmConfigOlam.ShowModal;
    Finally
      FreeAndNil(frmConfigOlam);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigBelaVista' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigBelaVista , frmConfigBelaVista);
      frmConfigBelaVista.strConfig := 'CONFIG973-';
      frmConfigBelaVista.ShowModal;
    Finally
      FreeAndNil(frmConfigBelaVista);
    End;
  End

  {*********************************}
  {* BANCO BRADESCO - 240P VENDOR  *}
  {******************************KP*}
  Else If arrMenu[intIndex].strNomform = 'frmConfigBradesco240V' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBradesco240Vendor, frmConfigBradesco240Vendor);
      frmConfigBradesco240Vendor.strConfig := 'CONFIG237_VENDOR-';
      frmConfigBradesco240Vendor.ShowModal;
    Finally
      FreeAndNil(frmConfigBradesco240Vendor);
    End;

  End

  {*********************************}
  {* BANCO DO BRASIL COM 6 DIGITOS *}
  {******************************LB*}
  Else If arrMenu[intIndex].strNomform = 'frmConfigBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBrasil, frmConfigBrasil);
      frmConfigBrasil.strConfig := 'CONFIG001-';
      frmConfigBrasil.ShowModal;
    Finally
      FreeAndNil(frmConfigBrasil);
    End;

  End

  {*********************************}
  {* BANCO DO BRASIL COM 7 DIGITOS *}
  {******************************LB*}
  Else If arrMenu[intIndex].strNomform = 'frmConfigBrasil7d' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBrasil7d, frmConfigBrasil7d);
      frmConfigBrasil7d.blnPeFin  := False;
      frmConfigBrasil7d.strConfig := 'CONFIG001D7-';
      frmConfigBrasil7d.ShowModal;
    Finally
      FreeAndNil(frmConfigBrasil7d);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigCxFederal' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCxFederal,frmConfigCxFederal);
      frmConfigCxFederal.strConfig := 'CONFIG104-';
      frmConfigCxFederal.ShowModal;
    Finally
      FreeAndNil(frmConfigCxFederal);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigCxFederal7D' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCxFederal7D,frmConfigCxFederal7D);
      frmConfigCxFederal7D.strConfig := 'CONFIG1047D-';
      frmConfigCxFederal7D.ShowModal;
    Finally
      FreeAndNil(frmConfigCxFederal7D);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigCxFederal400p' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCxFederal400p,frmConfigCxFederal400p);
      frmConfigCxFederal400p.strConfig := 'CONFIG104p400-';
      frmConfigCxFederal400p.ShowModal;
    Finally
      FreeAndNil(frmConfigCxFederal400p);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigBRB400p' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBRB400p,frmConfigBRB400p);
      frmConfigBRB400p.strConfig := 'CONFIG070p400-';
      frmConfigBRB400p.ShowModal;
    Finally
      FreeAndNil(frmConfigBRB400p);
    End;

  End


  Else If arrMenu[intIndex].strNomform = 'frmConfigHsbc' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigHsbc,frmConfigHsbc);
      frmConfigHsbc.strConfig := 'CONFIG399-';
      frmConfigHsbc.ShowModal;
    Finally
      FreeAndNil(frmConfigHsbc);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigItau' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigItau, frmConfigItau);
      frmConfigItau.strConfig := 'CONFIG341-';
      frmConfigItau.ShowModal;
    Finally
      FreeAndNil(frmConfigItau);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigMercantil' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigMercantil,frmConfigMercantil);
      frmConfigMercantil.strConfig := 'CONFIG389-';
      frmConfigMercantil.ShowModal;
    Finally
      FreeAndNil(frmConfigMercantil);
    End;

  End

//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigNossaCx' Then
//  Begin
//
//    Try
//      pCriarForm(TfrmConfigNossaCx,frmConfigNossaCx);
//    Finally
//      FreeAndNil(frmConfigNossaCx);
//    End;
//
//  End

//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigRibPreto' Then
//  Begin
//
//    Try
//      pCriarForm(TfrmConfigRibPreto,frmConfigRibPreto);
//    Finally
//      FreeAndNil(frmConfigRibPreto);
//    End;
//
//  End


  //*************************************************//
  // CONFIGURACOES DO UNIBANCO                       //
  //**********************************************ED*//
//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigUnibanco' Then
//  Begin
//
//    Try
//      pCriarForm(TfrmConfigUnibanco,frmConfigUnibanco);
//    Finally
//      FreeAndNil(frmConfigUnibanco);
//    End;
//
//  End

  {*********************************************************}
  {* CONFIGURACOES CHAMADAS BANCO 964 - FINANCEIRA FORMULA *}
  {*********************************************************}
  Else If arrMenu[intIndex].strNomform = 'frmConfigFinanceiraFormula' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigFinanceiraFormula, frmConfigFinanceiraFormula);
      frmConfigFinanceiraFormula.strConfig := 'CONFIG964-';
      frmConfigFinanceiraFormula.ShowModal;
    Finally
      FreeAndNil(frmConfigFinanceiraFormula);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupFinanceiraFormula' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 964 - Financeira Formula (itau) [400p]';
      frmGerDup.strNomBanco     := '964 - Financeira Formula (Itau) [400p]';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemFinanceiraFormula' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 964 - Financeira Formula (Itau) [400p]';
      frmRelRelDuplicatas.strNomBanco      := '964 - Financeira Formula [400p]';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstFinanceiraFormula' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '964';
      frmEstorno.edtDesBco.Text  := 'Financeira Formula';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemFinanceiraFormula' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigFinanceiraFormula, frmConfigFinanceiraFormula);
      frmConfigFinanceiraFormula.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigFinanceiraFormula.btnGravar.Caption := '&OK';
      frmConfigFinanceiraFormula.blnNaoEditar      := True;
      frmConfigFinanceiraFormula.ShowModal;

      If frmConfigFinanceiraFormula.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigFinanceiraFormula);
        Exit;
      End;

      intCartei := frmConfigFinanceiraFormula.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigFinanceiraFormula);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemFinanceiraFormula, frmExpArqRemFinanceiraFormula);
      frmExpArqRemFinanceiraFormula.intCartei  := intCartei;
      frmExpArqRemFinanceiraFormula.strNomForm := 'frmExpArqRemFinanceiraFormula';
      frmExpArqRemFinanceiraFormula.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemFinanceiraFormula);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvFinanceiraFormula' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '964';
      frmEstorno.edtDesBco.Text  := 'Financeira Formula';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetFinanceiraFormula' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigFinanceiraFormula, frmConfigFinanceiraFormula);
      frmConfigFinanceiraFormula.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigFinanceiraFormula.btnGravar.Caption := '&OK';
      frmConfigFinanceiraFormula.blnNaoEditar      := True;
      frmConfigFinanceiraFormula.ShowModal;

      If frmConfigFinanceiraFormula.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigFinanceiraFormula);
        Exit;
      End;

      intCartei := frmConfigFinanceiraFormula.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigFinanceiraFormula);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 964 - Financeira Formula [400p]';
      frmRetBco.strNomBanco            := '964 - Financeira Formula [400p]';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG964-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetFinanceiraFormula' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 964 - Financeira Formula [400p]';
      frmRelRetBco.strNomBanco      := '964 - Financeira Formula [400p]';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupFinanceiraFormula' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigFinanceiraFormula, frmConfigFinanceiraFormula);
      frmConfigFinanceiraFormula.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigFinanceiraFormula.btnGravar.Caption := '&OK';
      frmConfigFinanceiraFormula.blnNaoEditar      := True;
      frmConfigFinanceiraFormula.ShowModal;

      If frmConfigFinanceiraFormula.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigFinanceiraFormula);
        Exit;
      End;

      If Trim(frmConfigFinanceiraFormula.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigFinanceiraFormula.edtDiasCred.Text);

      intCartei := frmConfigFinanceiraFormula.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigFinanceiraFormula);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('964',intCartei);
    End;
  End

  {**********************************************************}
  {* CONFIGURACOES CHAMADAS BANCO 962 - BANCO CREDVALE FIDC *}
  {**********************************************************}
  Else If arrMenu[intIndex].strNomform = 'frmConfigBancoCredVale' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigBancoCredVale, frmConfigBancoCredVale);
      frmConfigBancoCredVale.strConfig := 'CONFIG962-';
      frmConfigBancoCredVale.ShowModal;
    Finally
      FreeAndNil(frmConfigBancoCredVale);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupBancoCredVale' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 962 - Banco CredVale (Bradesco) [400p]';
      frmGerDup.strNomBanco     := '962 - Banco CredVale (Bradesco) [400p]';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBancoCredVale' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 962 - Banco CredVale (Bradesco) [400p]';
      frmRelRelDuplicatas.strNomBanco      := '962 - Banco CredVale [400p]';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBancoCredVale' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '962';
      frmEstorno.edtDesBco.Text  := 'Banco CredVale';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBancoCredVale' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigBancoCredVale, frmConfigBancoCredVale);
      frmConfigBancoCredVale.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoCredVale.btnGravar.Caption := '&OK';
      frmConfigBancoCredVale.blnNaoEditar      := True;
      frmConfigBancoCredVale.ShowModal;

      If frmConfigBancoCredVale.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoCredVale);
        Exit;
      End;

      intCartei := frmConfigBancoCredVale.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBancoCredVale);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemBancoCredVale, frmExpArqRemBancoCredVale);
      frmExpArqRemBancoCredVale.intCartei  := intCartei;
      frmExpArqRemBancoCredVale.strNomForm := 'frmExpArqRemBancoCredVale';
      frmExpArqRemBancoCredVale.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemBancoCredVale);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBancoCredVale' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '962';
      frmEstorno.edtDesBco.Text  := 'Banco CredVale';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBancoCredVale' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigBancoCredVale, frmConfigBancoCredVale);
      frmConfigBancoCredVale.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoCredVale.btnGravar.Caption := '&OK';
      frmConfigBancoCredVale.blnNaoEditar      := True;
      frmConfigBancoCredVale.ShowModal;

      If frmConfigBancoCredVale.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoCredVale);
        Exit;
      End;

      intCartei := frmConfigBancoCredVale.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBancoCredVale);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 962 - Banco CredVale [400p]';
      frmRetBco.strNomBanco            := '962 - Banco CredVale [400p]';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG962-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBancoCredVale' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 962 - Banco CredVale [400p]';
      frmRelRetBco.strNomBanco      := '962 - Banco CredVale [400p]';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBancoCredVale' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBancoCredVale, frmConfigBancoCredVale);
      frmConfigBancoCredVale.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoCredVale.btnGravar.Caption := '&OK';
      frmConfigBancoCredVale.blnNaoEditar      := True;
      frmConfigBancoCredVale.ShowModal;

      If frmConfigBancoCredVale.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoCredVale);
        Exit;
      End;

      If Trim(frmConfigBancoCredVale.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigBancoCredVale.edtDiasCred.Text);

      intCartei := frmConfigBancoCredVale.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBancoCredVale);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('962',intCartei);
    End;
  End



  //*************************************************//
  // CONFIGURACOES DO SICREDI                        //
  //**********************************************ED*//
  Else If arrMenu[intIndex].strNomform = 'frmConfigSicredi' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSicredi,frmConfigSicredi);
      frmConfigSicredi.strConfig := 'CONFIG748-';
      frmConfigSicredi.ShowModal;
    Finally
      FreeAndNil(frmConfigSicredi);
    End;

  End

  //*************************************************//
  // CONFIGURACOES DO SICREDI 240                    //
  //**********************************************MO*//
  Else If arrMenu[intIndex].strNomform = 'frmConfigSicredi240' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSicredi240, frmConfigSicredi240);
      frmConfigSicredi240.strConfig := 'CONFIG748_240p-';
      frmConfigSicredi240.ShowModal;
    Finally
      FreeAndNil(frmConfigSicredi240);
    End;

  End


  //*************************************************//
  // CONFIGURACOES DO BANRISUL                       //
  //**********************************************ED*//
  Else If arrMenu[intIndex].strNomform = 'frmConfigBanrisul' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBanrisul,frmConfigBanrisul);
      frmConfigBanrisul.strConfig := 'CONFIG041-';
      frmConfigBanrisul.ShowModal;
    Finally
      FreeAndNil(frmConfigBanrisul);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigBanrisul240' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBanrisul240,frmConfigBanrisul240);
      frmConfigBanrisul240.strConfig := 'CONFIG041_240p-';
      frmConfigBanrisul240.ShowModal;
    Finally
      FreeAndNil(frmConfigBanrisul240);
    End;

  End

  {***************************************************}
  {* CONFIGURACOES DO BANCO REAL                     *}
  {************************************************LB*}
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmConfigReal' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigReal,frmConfigReal);
      frmConfigReal.strConfig := 'CONFIG356-';
      frmConfigReal.ShowModal;
    Finally
      FreeAndNil(frmConfigReal);
    End;

  End

  {***************************************************}
  {* CONFIGURACOES DO BANCO SANTANDER                *}
  {************************************************AC*}
//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmConfigSantander' Then
//  Begin
//
//    Try
//      pCriarForm(TfrmConfigSantander, frmConfigSantander);
//    Finally
//      FreeAndNil(frmConfigSantander);
//    End;
//
//  End

  {****************************************}
  {* CONFIGURACOES DO BANCO SANTANDER 033 *}
  {*************************************AF*}
  Else If SameText(arrMenu[intIndex].strNomForm,'frmConfigSantanderBan') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSantanderBan, frmConfigSantanderBan);
      frmConfigSantanderBan.ShowModal;
    Finally
      FreeAndNil(frmConfigSantanderBan);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmConfigSantander240p') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSantander240p,frmConfigSantander240p);
      frmConfigSantander240p.ShowModal;
    Finally
      FreeAndNil(frmConfigSantander240p);
    End;

  End

  {****************************************}
  {* CONFIGURACOES DO BANESTES 021        *}
  {*************************************AF*}
  Else If SameText(arrMenu[intIndex].strNomForm,'frmConfigBanestes') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBanestes,frmConfigBanestes);
      frmConfigBanestes.strConfig := 'CONFIG021-';
      frmConfigBanestes.ShowModal;
    Finally
      FreeAndNil(frmConfigBanestes);
    End;

  End

  {***************************************************}
  {* CONFIGURACOES DO BANCO SANTANDER                *}
  {************************************************JB*}
  Else If arrMenu[intIndex].strNomForm = 'frmConfigBancoob' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBancoob,frmConfigBancoob);
      frmConfigBancoob.strConfig := 'CONFIG756-';
      frmConfigBancoob.ShowModal;
    Finally
      FreeAndNil(frmConfigBancoob);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmConfigBancoob240' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBancoob240,frmConfigBancoob240);
      frmConfigBancoob240.strConfig := 'CONFIG756_240p-';
      frmConfigBancoob240.ShowModal;
    Finally
      FreeAndNil(frmConfigBancoob240);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmConfigSafra' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSafra,frmConfigSafra);
      frmConfigSafra.strConfig := 'CONFIG422-';
      frmConfigSafra.ShowModal;
    Finally
      FreeAndNil(frmConfigSafra);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmConfigBancoSafraApi' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSafraApi, frmConfigSafraApi);
      frmConfigSafraApi.ShowModal;
    Finally
      FreeAndNil(frmConfigSafraApi);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmConfigSofisa' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSofisa,frmConfigSofisa);
      frmConfigSofisa.strConfig := 'CONFIG637-';
      frmConfigSofisa.ShowModal;
    Finally
      FreeAndNil(frmConfigSofisa);
    End;

  End

  {*********************}
  {* BANCO SOFISA 444  *}
  {*********************}
  Else If arrMenu[intIndex].strNomForm = 'frmConfigSofisa_444' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSofisa_444,frmConfigSofisa_444);
      frmConfigSofisa_444.strConfig := 'CONFIG637_444p-';
      frmConfigSofisa_444.ShowModal;
    Finally
      FreeAndNil(frmConfigSofisa_444);
    End;

  End

  {**************************************}
  {* CONFIGURAÇÃO BANCO BTG PACTUAL 240 *}
  {**************************************}
  Else If arrMenu[intIndex].strNomForm = 'frmConfigBtgPactual_240p' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBtgPactual_240p,frmConfigBtgPactual_240p);
      frmConfigBtgPactual_240p.strConfig := 'CONFIG208-';
      frmConfigBtgPactual_240p.ShowModal;
    Finally
      FreeAndNil(frmConfigBtgPactual_240p);
    End;

  End

  {**************************************}
  {* CONFIGURAÇÃO GERENCIANET 240       *}
  {MF: 284963 - 12/07/23 ****************}
  Else If arrMenu[intIndex].strNomForm = 'frmConfigGerencianet240p' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigGerencianet240p,frmConfigGerencianet240p);
      frmConfigGerencianet240p.strConfig := 'CONFIG364-';
      frmConfigGerencianet240p.ShowModal;
    Finally
      FreeAndNil(frmConfigGerencianet240p);
    End;
  End


  {**************************************}
  {* CONFIGURAÇÃO CRESOL 240            *}
  {MF: 287323 - 14/07/23 ****************}
  Else If arrMenu[intIndex].strNomForm = 'frmConfigCresol240p' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCresol240p,frmConfigCresol240p);
      frmConfigCresol240p.strConfig := 'CONFIG133-';
      frmConfigCresol240p.ShowModal;
    Finally
      FreeAndNil(frmConfigCresol240p);
    End;
  End

  {*********************}
  {* BANCO DA AMAZONIA *}
  {******************JU*}
  Else If arrMenu[intIndex].strNomForm = 'frmConfigBancoAmazonia' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBancoAmazonia,frmConfigBancoAmazonia);
      frmConfigBancoAmazonia.strConfig := 'CONFIG003-';
      frmConfigBancoAmazonia.ShowModal;
    Finally
      FreeAndNil(frmConfigBancoAmazonia);
    End;

  End

  {************}
  {* CREDISAN *}
  {*********MO*}
  Else If arrMenu[intIndex].strNomForm = 'frmConfigCredisan400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCredisan400, frmConfigCredisan400);
      frmConfigCredisan400.strConfig := 'CONFIG089-';
      frmConfigCredisan400.ShowModal;
    Finally
      FreeAndNil(frmConfigCredisan400);
    End;

  End

  {*********************}
  {* BANCO RENDIMENTO  *}
  {******************JU*}
  Else If arrMenu[intIndex].strNomForm = 'frmConfigRendimento' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigRendimento,frmConfigRendimento);
      frmConfigRendimento.strConfig := 'CONFIG633-';
      frmConfigRendimento.ShowModal;
    Finally
      FreeAndNil(frmConfigRendimento);
    End;

  End
  {************************}
  {* CONFIGURAÇÕES CECRED *}
  {*REQ-29077-**********JU*}
  Else If arrMenu[intIndex].strNomForm = 'frmConfigCecred' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCecred,frmConfigCecred);
      frmConfigCecred.strConfig := 'CONFIG085-';
      frmConfigCecred.ShowModal;
    Finally
      FreeAndNil(frmConfigCecred);
    End;

  End

  {***********************************}
  {* CONFIGURAÇÕES BANCO DO NORDESTE *}
  {*REQ-95543**********************MO*}
  Else If arrMenu[intIndex].strNomForm = 'frmConfigNordeste400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigNordeste400, frmConfigNordeste400);
      frmConfigNordeste400.strConfig := 'CONFIG004-';
      frmConfigNordeste400.ShowModal;
    Finally
      FreeAndNil(frmConfigNordeste400);
    End;

  End

  {*************************}
  {* CONFIGURAÇÕES UNICRED *}
  {*REQ-30140-***********JU*}
  Else If arrMenu[intIndex].strNomForm = 'frmConfigUnicred' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigUnicred,frmConfigUnicred);
      frmConfigUnicred.strConfig := 'CONFIG090-';
      frmConfigUnicred.ShowModal;
    Finally
      FreeAndNil(frmConfigUnicred);
    End;

  End
  Else If arrMenu[intIndex].strNomForm = 'frmConfigUnicred400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigUnicred400,frmConfigUnicred400);
      frmConfigUnicred400.strConfig := 'CONFIG090_400p-';
      frmConfigUnicred400.ShowModal;
    Finally
      FreeAndNil(frmConfigUnicred400);
    End;

  End
  {***********************************}
  {* BANCO ABC BRASIL                *}
  {*REQ.34692 29/05/2015***********JU*}
  Else If arrMenu[intIndex].strNomForm = 'frmConfigABCBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigABCBrasil,frmConfigABCBrasil);
      frmConfigABCBrasil.strConfig := 'CONFIG246-';
      frmConfigABCBrasil.ShowModal;
    Finally
      FreeAndNil(frmConfigABCBrasil);
    End;

  End

  {*************************}
  {* CONFIGURAÇÕES IEPTBSP *}
  {*REQ-65923-************MO}
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmConfigIEPTBSP' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigIEPTBSP, frmConfigIEPTBSP);
      frmConfigIEPTBSP.ShowModal;
    Finally
      FreeAndNil(frmConfigIEPTBSP);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigSparti' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSparti,frmConfigSparti);
      frmConfigSparti.ShowModal;
    Finally
      FreeAndNil(frmConfigSparti);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigLecca' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBancoLecca,frmConfigBancoLecca);
      frmConfigBancoLecca.strConfig := 'CONFIG984-';
      frmConfigBancoLecca.ShowModal;
    Finally
      FreeAndNil(frmConfigBancoLecca);
    End;

  End

  //**NOVOBANCO**
  {*************************}
  {* GERAÇÃO DE DUPLICATAS *}
  {**********************AF*}
  Else If arrMenu[intIndex].strNomform = 'frmGerDupBanespa' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 033 - Banespa';
      frmGerDup.strNomBanco      := '033 - Banespa';
      frmGerDup.strNumPos := 'B';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupBradesco' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 237 - Bradesco';
      frmGerDup.strNomBanco     := '237 - Bradesco';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupFomentoMercantil400' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 994 - Na Fomento Mercantil';
      frmGerDup.strNomBanco     := '994 - Na Fomento Mercantil';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupBMPMoneyPlus' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 274 - BMPMoneyPlus';
      frmGerDup.strNomBanco     := '274 - BMPMoneyPlus';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupBmpMoneyPlus_LP_400' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 274 - BMP Money Plus LP [400p]';
      frmGerDup.strNomBanco      := '274 - BMP Money Plus LP [400p]';
      frmGerDup.strNumPos := '_400p';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupAthenaAtlanta400' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 996 - Athena Atlanta';
      frmGerDup.strNomBanco     := '996 - Athena Atlanta';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupMultibank' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 983 - Banco Multibank';
      frmGerDup.strNomBanco     := '983 - Banco Multibank';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupBancoJpiFidc' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 906 - Banco FIDC';
      frmGerDup.strNomBanco     := '906 - Banco FIDC';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupBancoCapitalFinancas' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 978 - Capital Finanças';
      frmGerDup.strNomBanco     := '978 - Capital Finanças';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupBancoSrm' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 990 - Banco SRM';
      frmGerDup.strNomBanco     := '990 - Banco SRM';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupBancoFidussia' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 970 - Banco Fidussia';
      frmGerDup.strNomBanco     := '970 - Banco Fidussia';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupBancoMultiplike' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 981 - Banco Multiplike';
      frmGerDup.strNomBanco     := '981 - Banco Multiplike';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupRedasset' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 993 - Redasset';
      frmGerDup.strNomBanco     := '993 - Redasset';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupCreditBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 992 - Credit Brasil';
      frmGerDup.strNomBanco     := '992 - Credit Brasil';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupUnicred400_136' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 136 - Unicred [400p]';
      frmGerDup.strNomBanco     := '136 - Unicred [400p]';
      frmGerDup.strNumPos := '400p';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End


  Else If arrMenu[intIndex].strNomform = 'frmGerDupGarsonCredito' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 997 - Garson Crédito';
      frmGerDup.strNomBanco     := '997 - Garson Crédito';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 998 - Sifra';
      frmGerDup.strNomBanco     := '998 - Sifra';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupGrupoSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 979 - Sifra';
      frmGerDup.strNomBanco     := '979 - Sifra';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupDaycoval400' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 995 - Banco Daycoval';
      frmGerDup.strNomBanco     := '995 - Banco Daycoval';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

 {******************************************}
 {*        BANCO DAYCOVAL [400P]           *}
 {*            LAYOUT PRÓPRIO              *}
 {*REQ:147378****************************MT*}
  Else If arrMenu[intIndex].strNomform = 'frmGerDupDaycoval_707[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 707 - Daycoval[400p]';
      frmGerDup.strNomBanco     := '707 - Daycoval[400p]';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupSBCredito_988[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 988 - SB Crédito[400p]';
      frmGerDup.strNomBanco     := '988 - SB Credito[400p]';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  // *****************************
  // *    SB CREDITO BRADESCO    *
  // *****************************
  Else If arrMenu[intIndex].strNomform = 'frmGerDupSBCredito_Bradesco_987[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 987 - SB Crédito (Bradesco) [400p]';
      frmGerDup.strNomBanco     := '987 - SB Credito Bradesco[400p]';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupSerrana' Then
    TSerranaMenu.GeracaoDeDuplicatas

  Else If arrMenu[intIndex].strNomform = 'frmGerDupRubi' Then
    TRubiMenu.GeracaoDeDuplicatas

  Else If arrMenu[intIndex].strNomform = 'frmGerDupUniprime400' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 099 - Uniprime';
      frmGerDup.strNomBanco     := '099 - Uniprime';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupBcoSisprime' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 084 - Sisprime';
      frmGerDup.strNomBanco     := '084 - Sisprime';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupLakeBank' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 977 - Lake Bank';
      frmGerDup.strNomBanco     := '977 - Lake Bank';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupLotus' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 976 - Lotus';
      frmGerDup.strNomBanco     := '976 - Lotus';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupJPCapital' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 975 - JP Capital';
      frmGerDup.strNomBanco     := '975 - JP Capital';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupOlam' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 974 - Olam';
      frmGerDup.strNomBanco     := '974 - Olam';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupBelaVista' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 973 - Bela Vista';
      frmGerDup.strNomBanco     := '973 - Bela Vista';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupCredisan400' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup, frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 089 - Credisan';
      frmGerDup.strNomBanco     := '089 - Credisan';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  {*************************}
  {* BANCO DO NORDESTE     *}
  {**********************MO*}
  Else If arrMenu[intIndex].strNomform = 'frmGerDupNordeste' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 004 - B. do Nordeste';
      frmGerDup.strNomBanco      := '004 - B. do Nordeste';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  {********************************}
  {* BANCO DO BRASIL DE 6 DIGITOS *}
  {*****************************LB*}
  Else If arrMenu[intIndex].strNomform = 'frmGerDupBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 001 - Brasil';
      frmGerDup.strNomBanco      := '001 - Brasil';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  {********************************}
  {* BANCO DO BRASIL DE 7 DIGITOS *}
  {*****************************LB*}
  Else If arrMenu[intIndex].strNomform = 'frmGerDupBrasil7d' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 001 - Brasil7d';
      frmGerDup.strNomBanco      := '001 - Brasil7d';
      frmGerDup.strNumPos := '400_D7';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupCxFed' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 104 - Caixa Fed.';
      frmGerDup.strNomBanco      := '104 - Caixa Federal';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupCxFed7D' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 104 - Caixa Fed. [7D]';
      frmGerDup.strNomBanco      := '104 - Caixa Federal [7D]';
      frmGerDup.strNumPos := '7D';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End


  Else If arrMenu[intIndex].strNomform = 'frmGerDupCxFed400p' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 104 - Caixa Fed.400p';
      frmGerDup.strNomBanco      := '104 - Caixa Federal.400p';
      frmGerDup.strNumPos := 'p400';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupBRB400p' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 070 - BRB 400p';
      frmGerDup.strNomBanco      := '070 - BRB 400p';
      frmGerDup.strNumPos := 'p400';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End


  Else If arrMenu[intIndex].strNomform = 'frmGerDupHsbc' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 399 - HSBC';
      frmGerDup.strNomBanco      := '399 - HSBC';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupItau' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 341 - Itaú';
      frmGerDup.strNomBanco      := '341 - Itaú';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmGerDupIEPTBSP' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - IEPTB-SP - Central de Protestos';
      frmGerDup.strNomBanco      := 'IEPTB-SP';
      frmGerDup.strNumPos := '';
      frmGerDup.blnEnvPro        := True;
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmGerDupSparti' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 982 - Sparti';
      frmGerDup.strNomBanco     := '982 - Sparti';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmGerDupLecca' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption := 'Geração de Duplicatas - 984 - Banco Lecca';
      frmGerDup.strNomBanco     := '984 - Banco Lecca';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupReal' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 356 - Real';
      frmGerDup.strNomBanco      := '356 - Real';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End


  Else If arrMenu[intIndex].strNomform = 'frmGerDupMerc' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 389 - Mercantil';
      frmGerDup.strNomBanco      := '389 - Banco Mercantil';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupNossaCx' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 151 - N.C.N.B.';
      frmGerDup.strNomBanco      := '151 - N.C.N.B.';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupRibPreto' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 741 - Rib. Preto';
      frmGerDup.strNomBanco      := '741 - Banco Rib Preto';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupSicredi' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 748 - Sicredi';
      frmGerDup.strNomBanco      := '748 - Sicredi';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupSicredi240' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup, frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 748 - Sicredi [240p]';
      frmGerDup.strNomBanco      := '748 - Sicredi240p';
      frmGerDup.strNumPos := '240p';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End


  Else If arrMenu[intIndex].strNomform = 'frmGerDupBanrisul' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 041 - Banrisul';
      frmGerDup.strNomBanco      := '041 - Banrisul';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupBanrisul240' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 041 - Banrisul [240p]';
      frmGerDup.strNomBanco      := '041 - Banrisul [240p]';
      frmGerDup.strNumPos := '240p';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupUnibanco' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 409 - Unibanco';
      frmGerDup.strNomBanco      := '409 - Unibanco';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmGerDupSantander' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 353 - Santander';
      frmGerDup.strNomBanco            := '353 - Santander';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmGerDupSantanderBan') Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 033 - Santander';
      frmGerDup.strNomBanco            := '033 - Santander';
      frmGerDup.strNumPos := 'B';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmGerDupSantander240p') Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 033 - Santander[240p]';
      frmGerDup.strNomBanco            := '033 - Santander[240p]';
      frmGerDup.strNumPos := 'B240p';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmGerDupBanestes') Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 021 - Banestes';
      frmGerDup.strNomBanco            := '021 - Banestes';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmGerDupBancoob' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 756 - Bancoob';
      frmGerDup.strNomBanco            := '756 - Bancoob';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmGerDupBancoob240' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 756 - Bancoob(240p)';
      frmGerDup.strNomBanco            := '756 - Bancoob_240p';
      frmGerDup.strNumPos := '240p';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmGerDupBradesco240V' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 237 - Bradesco(240p_Vendor)';
      frmGerDup.strNomBanco            := '237 - Bradesco_240p_Vendor';
      frmGerDup.strNumPos              := '_VENDOR';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmGerDupSafra' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 422 - Safra';
      frmGerDup.strNomBanco            := '422 - Safra';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupSofisa' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 637 - Sofisa';
      frmGerDup.strNomBanco      := '637 - Sofisa';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  {*********************}
  {* BANCO SOFISA 444p *}
  {*********************}
  Else If arrMenu[intIndex].strNomform = 'frmGerDupSofisa_444' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 637 - Sofisa [444p]';
      frmGerDup.strNomBanco      := '637 - Sofisa [444p]';
      frmGerDup.strNumPos := '_444p';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  {*************************}
  {* BANCO BTG PACTUAL 240 *}
  {*************************}
  Else If arrMenu[intIndex].strNomform = 'frmGerDupBtgPactual_240p' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 208 - Btg Pactual [240p]';
      frmGerDup.strNomBanco      := '208 - Btg Pactual [240p]';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  {**************************}
  {* BANCO GERENCIANET 240  *}
  {MF: 284963 - 12/07/23 ****}
  Else If arrMenu[intIndex].strNomform = 'frmGerDupGerencianet240p' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 364 - Efí Gerencianet [240p]';
      frmGerDup.strNomBanco      := '364 - Efí Gerencianet [240p]';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  {**************************}
  {* BANCO CRESOL      240  *}
  {MF: 287323 - 14/07/23 ****}
  Else If arrMenu[intIndex].strNomform = 'frmGerDupCresol240p' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 133 - Cresol [240p]';
      frmGerDup.strNomBanco      := '133 - Cresol [240p]';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  {*********************}
  {* BANCO DA AMAZONIA *}
  {******************JU*}
  Else If arrMenu[intIndex].strNomform = 'frmGerDupBancoAmazonia' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 003 - Banco da Amazônia';
      frmGerDup.strNomBanco      := '003 - Banco da Amazonia';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  {********************}
  {* BANCO RENDIMENTO *}
  {*****************JU*}
  Else If arrMenu[intIndex].strNomform = 'frmGerDupBancoRendimento' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 633 - Banco Rendimento';
      frmGerDup.strNomBanco      := '633 - Banco Rendimento';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  {********************}
  {* BANCO CECRED     *}
  {*****************JU*}
  Else If arrMenu[intIndex].strNomform = 'frmGerDupCecred' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 085 - Cecred';
      frmGerDup.strNomBanco      := '085 - Cecred';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  {********************}
  {* BANCO UNICRED    *}
  {*REQ. 30140******JU*}
  Else If arrMenu[intIndex].strNomform = 'frmGerDupUnicred' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 090 - Unicred';
      frmGerDup.strNomBanco      := '090 - Unicred';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupUnicred400' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 090 - Unicred (400p)';
      frmGerDup.strNomBanco      := '090 - Unicred (400p)';
      frmGerDup.strNumPos := '400p';

      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End
  {***********************************}
  {* BANCO ABC BRASIL                *}
  {*REQ.34692 29/05/2015***********JU*}
  Else If arrMenu[intIndex].strNomform = 'frmGerDupABCBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 246 - ABC Brasil';
      frmGerDup.strNomBanco      := '246 - ABC Brasil';
      frmGerDup.strNumPos := '';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  End

//**NOVOBANCO**
  {*************************}
  {* RELAÇÃO DE DUPLICATAS *}
  {**********************AF*}
  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBanespa' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 033 - Banespa';
      frmRelRelDuplicatas.strNomBanco      := '033 - Banespa';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBradesco' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 237 - Bradesco';
      frmRelRelDuplicatas.strNomBanco      := '237 - Bradesco';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemFomentoMercantil400' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 994 - Na Fomento Mercantil';
      frmRelRelDuplicatas.strNomBanco      := '994 - Na Fomento Mercantil';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBMPMoneyPlus' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 274 - BMPMoneyPlus';
      frmRelRelDuplicatas.strNomBanco      := '274 - BMPMoneyPlus';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBmpMoneyPlus_LP_400' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 274 - BMP Money Plus LP [400p]';
      frmRelRelDuplicatas.strNomBanco      := '274 - BMP Money Plus LP [400p]';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemAthenaAtlanta400' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 996 - Athena Atlanta';
      frmRelRelDuplicatas.strNomBanco      := '996 - Athena Atlanta';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemMultibank' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 983 - Banco Multibank';
      frmRelRelDuplicatas.strNomBanco      := '983 - Banco Multibank';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBancoJpiFidc' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 906 - Banco FIDC';
      frmRelRelDuplicatas.strNomBanco      := '906 - Banco FIDC';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBancoCapitalFinancas' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 978 - Capital Finanças';
      frmRelRelDuplicatas.strNomBanco      := '978 - Capital Finanças';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBancoSrm' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 990 - Banco SRM';
      frmRelRelDuplicatas.strNomBanco      := '990 - Banco SRM';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBancoFidussia' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 970 - Banco Fidussia';
      frmRelRelDuplicatas.strNomBanco      := '970 - Banco Fidussia';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBancoMultiplike' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 981 - Banco Multiplike';
      frmRelRelDuplicatas.strNomBanco      := '981 - Banco Multiplike';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemRedasset' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 993 - Redasset';
      frmRelRelDuplicatas.strNomBanco      := '993 - Redasset';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemCreditBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 992 - Credit Brasil';
      frmRelRelDuplicatas.strNomBanco      := '992 - Credit Brasil';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemGarsonCredito' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 997 - Garson Crédito';
      frmRelRelDuplicatas.strNomBanco      := '997 - Garson Crédito';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 998 - Sifra';
      frmRelRelDuplicatas.strNomBanco      := '998 - Sifra';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemGrupoSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 979 - Sifra';
      frmRelRelDuplicatas.strNomBanco      := '979 - Sifra';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemUnicred400_136' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 136 - Unicred [400p]';
      frmRelRelDuplicatas.strNomBanco      := '136 - Unicred';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemDaycoval400' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 995 - Banco Daycoval';
      frmRelRelDuplicatas.strNomBanco      := '995 - Banco Daycoval';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  {******************************************}
  {*        BANCO DAYCOVAL [400P]           *}
  {*            LAYOUT PRÓPRIO              *}
  {*REQ:147378****************************MT*}
  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemDaycoval_707[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 707 - Daycoval[400p]';
      frmRelRelDuplicatas.strNomBanco      := '707 - Daycoval[400p]';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemSBCredito_988[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 988 - SB Crédito[400p]';
      frmRelRelDuplicatas.strNomBanco      := '988 - SB Crédito[400p]';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  // **********************************
  // *     SB CREDITO BRADESCO        *
  // **********************************
  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemSBCredito_Bradesco_987[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 987 - SB Crédito (Bradesco)[400p]';
      frmRelRelDuplicatas.strNomBanco      := '987 - SB Crédito Bradesco[400p]';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemSerrana' Then
    TSerranaMenu.RelatorioDuplicatasGeradas

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemRubi' Then
    TRubiMenu.RelatorioDuplicatasGeradas

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemUniprime400' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 099 - Uniprime';
      frmRelRelDuplicatas.strNomBanco      := '099 - Uniprime';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBcoSisprime' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 084 - Sisprime';
      frmRelRelDuplicatas.strNomBanco      := '084 - Sisprime';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemLakeBank' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 977 - Lake Bank';
      frmRelRelDuplicatas.strNomBanco      := '977 - Lake Bank';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemLotus' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 976 - Lotus';
      frmRelRelDuplicatas.strNomBanco      := '976 - Lotus';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemJPCapital' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 975 - JP Capital';
      frmRelRelDuplicatas.strNomBanco      := '975 - JP Capital';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemOlam' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 974 - Olam';
      frmRelRelDuplicatas.strNomBanco      := '974 - Olam';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBelaVista' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 973 - Bela Vista';
      frmRelRelDuplicatas.strNomBanco      := '973 - Bela Vista';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemCredisan400' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas, frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 089 - Credisan';
      frmRelRelDuplicatas.strNomBanco      := '089 - Credisan';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  {********************************}
  {* BANCO DO BRASIL DE 6 DIGITOS *}
  {*****************************LB*}
  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 001 - Brasil';
      frmRelRelDuplicatas.strNomBanco      := '001 - Brasil';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  {********************************}
  {* BANCO DO BRASIL DE 7 DIGITOS *}
  {*****************************LB*}
  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBrasil7d' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 001 - Brasil7d';
      frmRelRelDuplicatas.strNomBanco      := '001 - Brasil7d';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemCxFed' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 104 - Caixa Fed.';
      frmRelRelDuplicatas.strNomBanco      := '104 - Caixa Federal';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemCxFed7D' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 104 - Caixa Fed. [7D]';
      frmRelRelDuplicatas.strNomBanco      := '104 - Caixa Federal [7D]';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End


  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemCxFed400p' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 104 - Caixa Fed.400p';
      frmRelRelDuplicatas.strNomBanco      := '104 - Caixa Federal';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBRB400p' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 070 - BRB 400p';
      frmRelRelDuplicatas.strNomBanco      := '070 - BRB';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End   

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemHsbc' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 399 - HSBC';
      frmRelRelDuplicatas.strNomBanco      := '399 - HSBC';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemItau' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 341 - Itaú';
      frmRelRelDuplicatas.strNomBanco      := '341 - Itaú';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmRelDupRemIEPTBSP' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - IEPTB-SP - Central de Protestos';
      frmRelRelDuplicatas.strNomBanco      := 'IEPTB-SP';
      frmRelRelDuplicatas.blnEnvPro        := True;
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmRelDupRemSparti' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - Sparti';
      frmRelRelDuplicatas.strNomBanco      := '982 - Sparti';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmRelDupRemLecca' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - Banco Lecca';
      frmRelRelDuplicatas.strNomBanco      := '984 - Banco Lecca';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemReal' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 356 - Real';
      frmRelRelDuplicatas.strNomBanco      := '356 - Real';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemMerc' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 389 - Mercantil';
      frmRelRelDuplicatas.strNomBanco      := '389 - Mercantil';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemNossaCx' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 151 - N.C.N.B.';
      frmRelRelDuplicatas.strNomBanco      := '151 - N.C.N.B.';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemRibPreto' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 741 - Rib. Preto';
      frmRelRelDuplicatas.strNomBanco      := '741 - Banco Rib Preto';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemUnibanco' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 409 - Unibanco';
      frmRelRelDuplicatas.strNomBanco      := '409 - Unibanco';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemSicredi' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 748 - Sicredi';
      frmRelRelDuplicatas.strNomBanco      := '748 - Sicredi';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemSicredi240' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas, frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 748 - Sicredi [240p]';
      frmRelRelDuplicatas.strNomBanco      := '748 - Sicredi240';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBanrisul' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 041 - Banrisul';
      frmRelRelDuplicatas.strNomBanco      := '041 - Banrisul';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBanrisul240' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 041 - Banrisul [240p]';
      frmRelRelDuplicatas.strNomBanco      := '041 - Banrisul [240p]';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemSantander' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 353 - Santander';
      frmRelRelDuplicatas.strNomBanco      := '353 - Santander';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomform, 'frmRelDupRemSantanderBan') Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 033 - Santander';
      frmRelRelDuplicatas.strNomBanco      := '033 - Santander';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomform, 'frmRelDupRemSantander240p') Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 033 - Santander[240p]';
      frmRelRelDuplicatas.strNomBanco      := '033 - Santander[240p]';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomform, 'frmRelDupRemBanestes') Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 021 - Banestes';
      frmRelRelDuplicatas.strNomBanco      := '021 - Banestes';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBancoob' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 756 - Bancoob';
      frmRelRelDuplicatas.strNomBanco      := '756 - Bancoob';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBancoob240' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 756 - Bancoob(240p)';
      frmRelRelDuplicatas.strNomBanco      := '756 - Bancoob_240p';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBradesco240V' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 237 - Bradesco(240p_Vendor)';
      frmRelRelDuplicatas.strNomBanco      := '237 - Bradesco_240p_Vendor';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemSafra' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 422 - Safra';
      frmRelRelDuplicatas.strNomBanco      := '422 - Safra';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemSofisa' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 637 - Sofisa';
      frmRelRelDuplicatas.strNomBanco      := '637 - Sofisa';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  {*********************}
  {* BANCO SOFISA 444p *}
  {******************JU*}
  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemSofisa_444' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 637 - Sofisa [444p]';
      frmRelRelDuplicatas.strNomBanco      := '637 - Sofisa [444p]';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBtgPactual_240p' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 208 - Btg Pactual [240p]';
      frmRelRelDuplicatas.strNomBanco      := '208 - Btg Pactual [240p]';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  {**************************}
  {* BANCO GERENCIANET 240  *}
  {MF: 284963 - 12/07/23 ****}
  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemGerencianet240p' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 364 - Efí Gerencianet [240p]';
      frmRelRelDuplicatas.strNomBanco      := '364 - Efí Gerencianet [240p]';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  {**************************}
  {* BANCO CRESOL      240  *}
  {MF: 287323 - 12/07/23 ****}
  Else If arrMenu[intIndex].strNomform = 'frmRelDupCresol240p' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 133 - Cresol [240p]';
      frmRelRelDuplicatas.strNomBanco      := '133 - Cresol [240p]';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  {*********************}
  {* BANCO DA AMAZÕNIA *}
  {******************JU*}
  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBancoAmazonia' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 003 - Banco da Amazônia';
      frmRelRelDuplicatas.strNomBanco      := '003 - Banco da Amazonia';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  {********************}
  {* BANCO RENDIMENTO *}
  {*****************JU*}
  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBancoRendimento' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 633 - Banco Rendimento';
      frmRelRelDuplicatas.strNomBanco      := '633 - Banco Rendimento';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  {*********************}
  {* BANCO DO NORDESTE *}
  {******************MO*}
  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemNordeste' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 004 - B. do Nordeste';
      frmRelRelDuplicatas.strNomBanco      := '004 - B. do Nordeste';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End

  {********************}
  {* BANCO CECRED     *}
  {*****************JU*}
  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemCecred' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 085 - Cecred';
      frmRelRelDuplicatas.strNomBanco      := '085 - Cecred';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  {********************}
  {* BANCO UNICRED    *}
  {*REQ. 30140******JU*}
  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemUnicred' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 090 - Unicred';
      frmRelRelDuplicatas.strNomBanco      := '090 - Unicred';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemUnicred400' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 090 - Unicred (400p)';
      frmRelRelDuplicatas.strNomBanco      := '090 - Unicred (400p)';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End
  {***********************************}
  {* BANCO ABC BRASIL                *}
  {*REQ.34692 29/05/2015***********JU*}
  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemABCBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 246 - ABC Brasil';
      frmRelRelDuplicatas.strNomBanco      := '246 - ABC Brasil';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

//**NOVOBANCO**
  {*************************}
  {* ESTORNO DE DUPLICATAS *}
  {**********************AF*}
  Else If arrMenu[intIndex].strNomform = 'frmEstBanespa' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '033';
      frmEstorno.edtDesBco.Text  := 'Banespa';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBradesco' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '237';
      frmEstorno.edtDesBco.Text  := 'Bradesco';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstFomentoMercantil400' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '994';
      frmEstorno.edtDesBco.Text  := 'Na Fomento Mercantil';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBMPMoneyPlus' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '274';
      frmEstorno.edtDesBco.Text  := 'BMPMoneyPlus';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBmpMoneyPlus_LP_400' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '274';
      frmEstorno.edtDesBco.Text  := 'BMP Money Plus LP [400p]';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstAthenaAtlanta400' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '996';
      frmEstorno.edtDesBco.Text  := 'Athena Atlanta';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstMultibank' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '983';
      frmEstorno.edtDesBco.Text  := '983-Banco Multibank';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBancoJpiFidc' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '906';
      frmEstorno.edtDesBco.Text  := '906-Banco FIDC';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBancoCapitalFinancas' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '978';
      frmEstorno.edtDesBco.Text  := '978-Capital Finanças';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBancoSrm' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '990';
      frmEstorno.edtDesBco.Text  := '990-Banco SRM';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBancoFidussia' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '970';
      frmEstorno.edtDesBco.Text  := '970-Banco Fidussia';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBancoMultiplike' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '981';
      frmEstorno.edtDesBco.Text  := '981-Banco Multiplike';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstRedasset' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '993';
      frmEstorno.edtDesBco.Text  := 'Redasset';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstCreditBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '992';
      frmEstorno.edtDesBco.Text  := 'Credit Brasil';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstGarsonCredito' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '997';
      frmEstorno.edtDesBco.Text  := 'Garson Crédito';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '998';
      frmEstorno.edtDesBco.Text  := 'Sifra';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstGrupoSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '979';
      frmEstorno.edtDesBco.Text  := 'Sifra';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstUnicred400_136' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '136';
      frmEstorno.edtDesBco.Text  := 'Unicred [400p]';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstDaycoval400' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '995';
      frmEstorno.edtDesBco.Text  := 'Banco Daycoval';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  {******************************************}
  {*        BANCO DAYCOVAL [400P]           *}
  {*            LAYOUT PRÓPRIO              *}
  {*REQ:147378****************************MT*}
  Else If arrMenu[intIndex].strNomform = 'frmEstDaycoval_707[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '707';
      frmEstorno.edtDesBco.Text  := '707-Daycoval[400p]';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstSBCredito_988[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '988';
      frmEstorno.edtDesBco.Text  := '988-SB Credito[400p]';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  // **********************************
  // *     SB CREDITO BRADESCO        *
  // **********************************
  Else If arrMenu[intIndex].strNomform = 'frmEstSBCredito_Bradesco_987[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '987';
      frmEstorno.edtDesBco.Text  := '987-SB Credito Bradesco[400p]';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstSerrana' Then
    TSerranaMenu.CancelamentoDuplicatasGeradas

  Else If arrMenu[intIndex].strNomform = 'frmEstRubi' Then
    TRubiMenu.CancelamentoDuplicatasGeradas

  Else If arrMenu[intIndex].strNomform = 'frmEstUniprime400' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '099';
      frmEstorno.edtDesBco.Text  := 'Uniprime';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBcoSisprime' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '084';
      frmEstorno.edtDesBco.Text  := 'Sisprime';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstLakeBank' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '977';
      frmEstorno.edtDesBco.Text  := 'Lake Bank';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstLotus' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '976';
      frmEstorno.edtDesBco.Text  := 'Lotus';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstJPCapital' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '975';
      frmEstorno.edtDesBco.Text  := 'JP Capital';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstOlam' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '974';
      frmEstorno.edtDesBco.Text  := 'Olam';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBelaVista' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '973';
      frmEstorno.edtDesBco.Text  := 'Bela Vista';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstCredisan400' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno, frmEstorno);
      frmEstorno.edtCodBco.Text  := '089';
      frmEstorno.edtDesBco.Text  := 'Credisan';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  {********************************}
  {* BANCO DO BRASIL DE 6 DIGITOS *}
  {*****************************LB*}
  Else If arrMenu[intIndex].strNomform = 'frmEstBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '001';
      frmEstorno.edtDesBco.Text  := 'Brasil';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  {********************************}
  {* BANCO DO BRASIL DE 7 DIGITOS *}
  {*****************************LB*}
  Else If arrMenu[intIndex].strNomform = 'frmEstBrasil7d' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '001';
      frmEstorno.edtDesBco.Text  := 'Brasil7d';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstCxFed' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '104';
      frmEstorno.edtDesBco.Text  := 'Caixa Federal';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstCxFed7D' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '104';
      frmEstorno.edtDesBco.Text  := 'Caixa Federal [7D]';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End


  Else If arrMenu[intIndex].strNomform = 'frmEstCxFed400p' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '104';
      frmEstorno.edtDesBco.Text  := 'Caixa Federal 400p';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBRB400p' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '070';
      frmEstorno.edtDesBco.Text  := 'BRB 400p';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstHsbc' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '399';
      frmEstorno.edtDesBco.Text  := 'HSBC';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstItau' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '341';
      frmEstorno.edtDesBco.Text  := 'Itaú';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmEstIEPTBSP' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text    := 'IEP';
      frmEstorno.edtDesBco.Text    := 'IEPTB-SP - Central de Protesto';
      frmEstorno.blnApenasCadRec   := False;
      frmEstorno.blnEnvPro         := True;
      frmEstorno.edtCodBco.Enabled := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmEstSparti' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '982';
      frmEstorno.edtDesBco.Text  := 'Sparti';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmEstLecca' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '984';
      frmEstorno.edtDesBco.Text  := 'Banco Lecca';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstReal' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '356';
      frmEstorno.edtDesBco.Text  := 'Real';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstMerc' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '389';
      frmEstorno.edtDesBco.Text  := 'Mercantil';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstNossaCx' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '151';
      frmEstorno.edtDesBco.Text  := 'N.C.N.B.';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstRibPreto' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '741';
      frmEstorno.edtDesBco.Text  := 'Banco Rib Preto';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstUnibanco' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '409';
      frmEstorno.edtDesBco.Text  := 'Unibanco';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstSicredi' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '748';
      frmEstorno.edtDesBco.Text  := 'Sicredi';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstSicredi240' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno, frmEstorno);
      frmEstorno.edtCodBco.Text  := '748';
      frmEstorno.edtDesBco.Text  := 'Sicredi [240p]';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBanrisul' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '041';
      frmEstorno.edtDesBco.Text  := 'Banrisul';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBanrisul240' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '041';
      frmEstorno.edtDesBco.Text  := 'Banrisul [240p]';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstSantander' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '353';
      frmEstorno.edtDesBco.Text  := 'Santander';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomform, 'frmEstSantanderBan') Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '033';
      frmEstorno.edtDesBco.Text  := 'Santander';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

   Else If SameText(arrMenu[intIndex].strNomform, 'frmEstSantander240p') Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '033';
      frmEstorno.edtDesBco.Text  := 'Santander[240p]';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomform, 'frmEstBanestes') Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '021';
      frmEstorno.edtDesBco.Text  := 'Banestes';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBancoob' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '756';
      frmEstorno.edtDesBco.Text  := 'Bancoob';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBancoob240' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '756';
      frmEstorno.edtDesBco.Text  := 'Bancoob(240p)';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBradesco240V' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '237';
      frmEstorno.edtDesBco.Text  := 'Bradesco(240p_Vendor)';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstSafra' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '422';
      frmEstorno.edtDesBco.Text  := 'Safra';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstSofisa' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '637';
      frmEstorno.edtDesBco.Text  := 'Sofisa';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstSofisa_444' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '637';
      frmEstorno.edtDesBco.Text  := 'Sofisa [444p]';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBtgPactual_240p' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '208';
      frmEstorno.edtDesBco.Text  := 'Btg Pactual [240p]';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  {**************************}
  {* BANCO GERENCIANET 240  *}
  {MF: 284963 - 12/07/23 ****}
  Else If arrMenu[intIndex].strNomform = 'frmEstGerencianet240p' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '364';
      frmEstorno.edtDesBco.Text  := 'Efí Gerencianet [240p]';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  {**************************}
  {* BANCO CRESOL 240       *}
  {MF: 287323 - 14/07/23 ****}
  Else If arrMenu[intIndex].strNomform = 'frmEstCresol240p' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '133';
      frmEstorno.edtDesBco.Text  := 'Cresol [240p]';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBancoAmazonia' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '003';
      frmEstorno.edtDesBco.Text  := 'Banco da Amazônia';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBancoRendimento' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '633';
      frmEstorno.edtDesBco.Text  := 'Banco Rendimento';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstNordeste' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '004';
      frmEstorno.edtDesBco.Text  := 'Banco do Nordeste';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstCecred' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '085';
      frmEstorno.edtDesBco.Text  := 'Cecred';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstUnicred' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '090';
      frmEstorno.edtDesBco.Text  := 'Unicred';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstUnicred400' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '090';
      frmEstorno.edtDesBco.Text  := 'Unicred (400p)';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End
  {***********************************}
  {* BANCO ABC BRASIL                *}
  {*REQ.34692 29/05/2015***********JU*}
  Else If arrMenu[intIndex].strNomform = 'frmEstABCBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '246';
      frmEstorno.edtDesBco.Text  := 'ABC Brasil';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

//**NOVOBANCO**
  {*********************************************}
  {* ESTORNO DE DUPLICATAS ENVIADAS PARA BANCO *}
  {******************************************AF*}
  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBanespa' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '033';
      frmEstorno.edtDesBco.Text  := 'Banespa';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBradesco' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '237';
      frmEstorno.edtDesBco.Text  := 'Bradesco';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvFomentoMercantil400' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '994';
      frmEstorno.edtDesBco.Text  := 'Na Fomento Mercantil';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBMPMoneyPlus' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '274';
      frmEstorno.edtDesBco.Text  := 'BMPMoneyPlus';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBmpMoneyPlus_LP_400' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '274';
      frmEstorno.edtDesBco.Text  := 'BMp Money Plus LP [400p]';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvAthenaAtlanta400' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '996';
      frmEstorno.edtDesBco.Text  := 'Athena Atlanta';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvMultibank' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '983';
      frmEstorno.edtDesBco.Text  := '983-Banco Multibank';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBancoJpiFidc' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '906';
      frmEstorno.edtDesBco.Text  := '906-Banco FIDC';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBancoCapitalFinancas' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '978';
      frmEstorno.edtDesBco.Text  := '978-Capital Finanças';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBancoSrm' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '990';
      frmEstorno.edtDesBco.Text  := '990-Banco SRM';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBancoFidussia' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '970';
      frmEstorno.edtDesBco.Text  := '970-Banco Fidussia';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBancoMultiplike' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '981';
      frmEstorno.edtDesBco.Text  := '981-Banco Multiplike';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvRedasset' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '993';
      frmEstorno.edtDesBco.Text  := 'Redasset';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvCreditBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '992';
      frmEstorno.edtDesBco.Text  := 'Credit Brasil';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvGarsonCredito' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '997';
      frmEstorno.edtDesBco.Text  := 'Garson Crédito';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End
  End


  Else If arrMenu[intIndex].strNomform = 'frmEstEnvSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '998';
      frmEstorno.edtDesBco.Text  := 'Sifra';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvGrupoSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '979';
      frmEstorno.edtDesBco.Text  := 'Sifra';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvUnicred400_136' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '136';
      frmEstorno.edtDesBco.Text  := 'Unicred [400p]';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End


  Else If arrMenu[intIndex].strNomform = 'frmEstEnvDaycoval400' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '995';
      frmEstorno.edtDesBco.Text  := 'Banco Daycoval';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End


  {******************************************}
  {*        BANCO DAYCOVAL [400P]           *}
  {*            LAYOUT PRÓPRIO              *}
  {*REQ:147378****************************MT*}
  Else If arrMenu[intIndex].strNomform = 'frmEstEnvDaycoval_707[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '707';
      frmEstorno.edtDesBco.Text  := '707-Daycoval[400p]';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvSBCredito_988[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '988';
      frmEstorno.edtDesBco.Text  := '988-SB Credito[400p]';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  // **********************************
  // *     SB CREDITO BRADESCO        *
  // **********************************
  Else If arrMenu[intIndex].strNomform = 'frmEstEnvSBCredito_Bradesco_987[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '987';
      frmEstorno.edtDesBco.Text  := '987-SB Credito Bradesco[400p]';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvSerrana' Then
    TSerranaMenu.CancelamentoDuplicatasEnviadasAoBanco

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvRubi' Then
    TRubiMenu.CancelamentoDuplicatasEnviadasAoBanco

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvUniprime400' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '099';
      frmEstorno.edtDesBco.Text  := 'Uniprime';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBcoSisprime' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '084';
      frmEstorno.edtDesBco.Text  := 'Sisprime';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvLakeBank' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '977';
      frmEstorno.edtDesBco.Text  := 'Lake Bank';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvLotus' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '976';
      frmEstorno.edtDesBco.Text  := 'Lotus';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvJPCapital' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '975';
      frmEstorno.edtDesBco.Text  := 'JP Capital';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvOlam' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '974';
      frmEstorno.edtDesBco.Text  := 'Olam';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBelaVista' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '973';
      frmEstorno.edtDesBco.Text  := 'Bela Vista';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvCredisan400' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno, frmEstorno);
      frmEstorno.edtCodBco.Text  := '089';
      frmEstorno.edtDesBco.Text  := 'Credisan';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  {********************************}
  {* BANCO DO BRASIL DE 6 DIGITOS *}
  {*****************************LB*}
  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '001';
      frmEstorno.edtDesBco.Text  := 'Brasil';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  {********************************}
  {* BANCO DO BRASIL DE 7 DIGITOS *}
  {*****************************LB*}
  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBrasil7d' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '001';
      frmEstorno.edtDesBco.Text  := 'Brasil7d';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvCxFed' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '104';
      frmEstorno.edtDesBco.Text  := 'Caixa Federal';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvCxFed7D' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '104';
      frmEstorno.edtDesBco.Text  := 'Caixa Federal [7D]';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End


  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBRB400p' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '070';
      frmEstorno.edtDesBco.Text  := 'BRB';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvCxFed400p' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '104';
      frmEstorno.edtDesBco.Text  := 'Caixa Federal 400p';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvHsbc' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '399';
      frmEstorno.edtDesBco.Text  := 'HSBC';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvItau' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '341';
      frmEstorno.edtDesBco.Text  := 'Itaú';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmEstEnvIEPTBSP' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text    := 'IEP';
      frmEstorno.edtDesBco.Text    := 'IEPTB-SP - Central de Protesto';
      frmEstorno.edtCodBco.Enabled := False;
      frmEstorno.blnApenasCadRec   := True;
      frmEstorno.blnEnvPro         := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmEstEnvSparti' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '982';
      frmEstorno.edtDesBco.Text  := 'Sparti';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmEstEnvLecca' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '984';
      frmEstorno.edtDesBco.Text  := 'Banco Lecca';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvReal' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '356';
      frmEstorno.edtDesBco.Text  := 'Real';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvMerc' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '389';
      frmEstorno.edtDesBco.Text  := 'Mercantil';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvNossaCx' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '151';
      frmEstorno.edtDesBco.Text  := 'N.C.N.B.';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvRibPreto' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '741';
      frmEstorno.edtDesBco.Text  := 'Banco Rib Preto';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvUnibanco' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '409';
      frmEstorno.edtDesBco.Text  := 'Unibanco';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvSicredi' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '748';
      frmEstorno.edtDesBco.Text  := 'Sicredi';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvSicredi240' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno, frmEstorno);
      frmEstorno.edtCodBco.Text  := '748';
      frmEstorno.edtDesBco.Text  := 'Sicredi [240p]';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBanrisul' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '041';
      frmEstorno.edtDesBco.Text  := 'Banrisul';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBanrisul240' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '041';
      frmEstorno.edtDesBco.Text  := 'Banrisul [240p]';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvSantander' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '353';
      frmEstorno.edtDesBco.Text  := 'Santander';
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomform,'frmEstEnvSantanderBan') Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '033';
      frmEstorno.edtDesBco.Text  := 'Santander';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomform,'frmEstEnvSantander240p') Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '033';
      frmEstorno.edtDesBco.Text  := 'Santander[240p]';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomform,'frmEstEnvBanestes') Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '021';
      frmEstorno.edtDesBco.Text  := 'Banestes';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBancoob' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '756';
      frmEstorno.edtDesBco.Text  := 'Bancoob';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBancoob240' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '756';
      frmEstorno.edtDesBco.Text  := 'Bancoob(240p)';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBradesco240V' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '237';
      frmEstorno.edtDesBco.Text  := 'Bradesco(240p_Vendor)';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvSafra' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '422';
      frmEstorno.edtDesBco.Text  := 'Safra';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvSofisa' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '637';
      frmEstorno.edtDesBco.Text  := 'Sofisa';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvSofisa_444' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '637';
      frmEstorno.edtDesBco.Text  := 'Sofisa [444p]';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBtgPactual_240p' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '208';
      frmEstorno.edtDesBco.Text  := 'Btg Pactual [240p]';
      frmEstorno.blnApenasCadRec := TRUE;
      frmEstorno.blnCancEnvBanco := TRUE;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  {**************************}
  {* BANCO GERENCIANET 240  *}
  {MF: 284963 - 12/07/23 ****}
  Else If arrMenu[intIndex].strNomform = 'frmEstEnvGerencianet240p' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '364';
      frmEstorno.edtDesBco.Text  := 'Efí Gerencianet [240p]';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  {**************************}
  {* BANCO CRESOL 240       *}
  {MF: 287323 - 12/07/23 ****}
  Else If arrMenu[intIndex].strNomform = 'frmEstEnvCresol240p' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '133';
      frmEstorno.edtDesBco.Text  := 'Cresol [240p]';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBancoAmazonia' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '003';
      frmEstorno.edtDesBco.Text  := 'Banco da Amazônia';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBancoRendimento' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '633';
      frmEstorno.edtDesBco.Text  := 'Banco Rendimento';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvCecred' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '085';
      frmEstorno.edtDesBco.Text  := 'Cecred';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvNordeste' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '004';
      frmEstorno.edtDesBco.Text  := 'B. do Nordeste';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvUnicred' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '090';
      frmEstorno.edtDesBco.Text  := 'Unicred';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvUnicred400' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '090';
      frmEstorno.edtDesBco.Text  := 'Unicred (400p)';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End
  {***********************************}
  {* BANCO ABC BRASIL                *}
  {*REQ.34692 29/05/2015***********JU*}
  Else If arrMenu[intIndex].strNomform = 'frmEstEnvABCBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '246';
      frmEstorno.edtDesBco.Text  := 'ABC Brasil';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.blnCancEnvBanco := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

//**NOVOBANCO**
  {*************************************}
  {* EXPORTAÇÃO DE ARQUIVOS DE REMESSA *}
  {**********************************AF*}
//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmExpArqRemBanespa' Then
//  Begin
//
//    Try
//      pCriarFormularios(TfrmConfigBanespa,frmConfigBanespa);
//      frmConfigBanespa.pnlTopo.Caption   := 'Selecione a carteira';
//      frmConfigBanespa.btnGravar.Caption := '&OK';
//      frmConfigBanespa.ShowModal;
//
//      If frmConfigBanespa.ModalResult <> mrOK Then
//      Begin
//        FreeAndNil(frmConfigBanespa);
//        Exit;
//      End;
//
//      intCartei := frmConfigBanespa.tabCarteira.TabIndex + 1;
//
//    Finally
//      FreeAndNil(frmConfigBanespa);
//    End;
//
//    Try
//      pCriarFormularios(TfrmExpArqRemBanespa,frmExpArqRemBanespa);
//      frmExpArqRemBanespa.intCartei  := intCartei;
//      frmExpArqRemBanespa.strNomForm := 'frmConfigBanespa';
//      frmExpArqRemBanespa.ShowModal;
//    Finally
//      FreeAndNil(frmExpArqRemBanespa);
//    End;
//
//  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBradesco' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBradesco,frmConfigBradesco);
      frmConfigBradesco.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBradesco.btnGravar.Caption := '&OK';
      frmConfigBradesco.blnNaoEditar      := True;
      frmConfigBradesco.ShowModal;

      If frmConfigBradesco.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBradesco);
        Exit;
      End;

      intCartei := frmConfigBradesco.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBradesco);
    End;

//    If fFiltraIndiceCarteiraBanco('237', 'CONFIG237-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
      Try
        pCriarFormularios(TfrmExpArqRemBradesco,frmExpArqRemBradesco);
        frmExpArqRemBradesco.intCartei  := intCartei;
        frmExpArqRemBradesco.strNomForm := 'frmConfigBradesco';
        frmExpArqRemBradesco.ShowModal;
      Finally
        FreeAndNil(frmExpArqRemBradesco);
      End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 237 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemFomentoMercantil400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigFomentoMercantil400, frmConfigFomentoMercantil400);
      frmConfigFomentoMercantil400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigFomentoMercantil400.btnGravar.Caption := '&OK';
      frmConfigFomentoMercantil400.blnNaoEditar      := True;
      frmConfigFomentoMercantil400.ShowModal;

      If frmConfigFomentoMercantil400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigFomentoMercantil400);
        Exit;
      End;

      intCartei := frmConfigFomentoMercantil400.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigFomentoMercantil400);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemFomentoMercantil400, frmExpArqRemFomentoMercantil400);
      frmExpArqRemFomentoMercantil400.intCartei  := intCartei;
      frmExpArqRemFomentoMercantil400.strNomForm := 'frmConfigBradesco';
      frmExpArqRemFomentoMercantil400.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemFomentoMercantil400);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBMPMoneyPlus' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBMPMoneyPlus, frmConfigBMPMoneyPlus);
      frmConfigBMPMoneyPlus.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBMPMoneyPlus.btnGravar.Caption := '&OK';
      frmConfigBMPMoneyPlus.blnNaoEditar      := True;
      frmConfigBMPMoneyPlus.ShowModal;

      If frmConfigBMPMoneyPlus.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBMPMoneyPlus);
        Exit;
      End;

      intCartei := frmConfigBMPMoneyPlus.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBMPMoneyPlus);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemBMPMoneyPlus, frmExpArqRemBMPMoneyPlus);
      frmExpArqRemBMPMoneyPlus.intCartei  := intCartei;
      frmExpArqRemBMPMoneyPlus.strNomForm := 'frmConfigBMPMoneyPlus';
      frmExpArqRemBMPMoneyPlus.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemBMPMoneyPlus);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqBmpMoneyPlus_LP_400nv' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBMPMoneyPlus_LP_400, frmConfigBMPMoneyPlus_LP_400);
      frmConfigBMPMoneyPlus_LP_400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBMPMoneyPlus_LP_400.btnGravar.Caption := '&OK';
      frmConfigBMPMoneyPlus_LP_400.blnNaoEditar      := True;
      frmConfigBMPMoneyPlus_LP_400.ShowModal;

      If frmConfigBMPMoneyPlus_LP_400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBMPMoneyPlus_LP_400);
        Exit;
      End;

      intCartei := frmConfigBMPMoneyPlus_LP_400.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBMPMoneyPlus_LP_400);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemBMPMoneyPlus_LP_400, frmExpArqRemBMPMoneyPlus_LP_400);
      frmExpArqRemBMPMoneyPlus_LP_400.intCartei  := intCartei;
      frmExpArqRemBMPMoneyPlus_LP_400.strNomForm := 'frmConfigBMPMoneyPlus_LP_400';
      frmExpArqRemBMPMoneyPlus_LP_400.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemBMPMoneyPlus_LP_400);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemAthenaAtlanta400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigAthenaAtlanta, frmConfigAthenaAtlanta);
      frmConfigAthenaAtlanta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigAthenaAtlanta.btnGravar.Caption := '&OK';
      frmConfigAthenaAtlanta.strConfig         := 'CONFIG996-';
      frmConfigAthenaAtlanta.blnNaoEditar      := True;
      frmConfigAthenaAtlanta.ShowModal;

      If frmConfigAthenaAtlanta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigAthenaAtlanta);
        Exit;
      End;

      intCartei := frmConfigAthenaAtlanta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigAthenaAtlanta);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemAthenaAtlanta, frmExpArqRemAthenaAtlanta);
      frmExpArqRemAthenaAtlanta.intCartei  := intCartei;
      frmExpArqRemAthenaAtlanta.strNomForm := 'frmConfigAthenaAtlanta';
      frmExpArqRemAthenaAtlanta.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemAthenaAtlanta);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemMultibank400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigMultibank, frmConfigMultibank);
      frmConfigMultibank.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigMultibank.strConfig         := 'CONFIG983-';
      frmConfigMultibank.btnGravar.Caption := '&OK';
      frmConfigMultibank.blnNaoEditar      := True;
      frmConfigMultibank.ShowModal;

      If frmConfigMultibank.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigMultibank);
        Exit;
      End;

      intCartei := frmConfigMultibank.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigMultibank);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemMultibank, frmExpArqRemMultibank);
      frmExpArqRemMultibank.intCartei  := intCartei;
      frmExpArqRemMultibank.strNomForm := 'frmExpArqRemMultibank';
      frmExpArqRemMultibank.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemMultibank);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBancoJpiFidc' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigJpiFidc, frmConfigJpiFidc);
      frmConfigJpiFidc.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigJpiFidc.strConfig         := 'CONFIG906-';
      frmConfigJpiFidc.btnGravar.Caption := '&OK';
      frmConfigJpiFidc.blnNaoEditar      := True;
      frmConfigJpiFidc.ShowModal;

      If frmConfigJpiFidc.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigJpiFidc);
        Exit;
      End;

      intCartei := frmConfigJpiFidc.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigJpiFidc);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemJpiFidc, frmExpArqRemJpiFidc);
      frmExpArqRemJpiFidc.intCartei  := intCartei;
      frmExpArqRemJpiFidc.strNomForm := 'frmExpArqRemJpiFidc';
      frmExpArqRemJpiFidc.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemJpiFidc);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBancoCapitalFinancas' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCapitalFinancas, frmConfigCapitalFinancas);
      frmConfigCapitalFinancas.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCapitalFinancas.strConfig         := 'CONFIG978-';
      frmConfigCapitalFinancas.btnGravar.Caption := '&OK';
      frmConfigCapitalFinancas.blnNaoEditar      := True;
      frmConfigCapitalFinancas.ShowModal;

      If frmConfigCapitalFinancas.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCapitalFinancas);
        Exit;
      End;

      intCartei := frmConfigCapitalFinancas.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCapitalFinancas);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemCapitalFinancas, frmExpArqRemCapitalFinancas);
      frmExpArqRemCapitalFinancas.NumeroCarteira  := intCartei;
      frmExpArqRemCapitalFinancas.NomeForm := 'frmExpArqRemCapitalFinancas';
      frmExpArqRemCapitalFinancas.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemCapitalFinancas);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemLakeBank' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigLakeBank, frmConfigLakeBank);
      frmConfigLakeBank.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigLakeBank.strConfig         := 'CONFIG977-';
      frmConfigLakeBank.btnGravar.Caption := '&OK';
      frmConfigLakeBank.blnNaoEditar      := True;
      frmConfigLakeBank.ShowModal;

      If frmConfigLakeBank.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigLakeBank);
        Exit;
      End;

      intCartei := frmConfigLakeBank.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigLakeBank);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemLakeBank,frmExpArqRemLakeBank);
      frmExpArqRemLakeBank.intCartei  := intCartei;
      frmExpArqRemLakeBank.strNomForm := 'frmExpArqRemLakeBank';
      frmExpArqRemLakeBank.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemLakeBank);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemLotus' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigLotus, frmConfigLotus);
      frmConfigLotus.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigLotus.strConfig         := 'CONFIG976-';
      frmConfigLotus.btnGravar.Caption := '&OK';
      frmConfigLotus.blnNaoEditar      := True;
      frmConfigLotus.ShowModal;

      If frmConfigLotus.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigLotus);
        Exit;
      End;

      intCartei := frmConfigLotus.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigLotus);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemLotus,frmExpArqRemLotus);
      frmExpArqRemLotus.intCartei  := intCartei;
      frmExpArqRemLotus.strNomForm := 'frmExpArqRemLotus';
      frmExpArqRemLotus.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemLotus);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemJPCapital' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigJPCapital, frmConfigJPCapital);
      frmConfigJPCapital.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigJPCapital.strConfig         := 'CONFIG975-';
      frmConfigJPCapital.btnGravar.Caption := '&OK';
      frmConfigJPCapital.blnNaoEditar      := True;
      frmConfigJPCapital.ShowModal;

      If frmConfigJPCapital.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigJPCapital);
        Exit;
      End;

      intCartei := frmConfigJPCapital.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigJPCapital);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemJPCapital,frmExpArqRemJPCapital);
      frmExpArqRemJPCapital.intCartei  := intCartei;
      frmExpArqRemJPCapital.strNomForm := 'frmExpArqRemJPCapital';
      frmExpArqRemJPCapital.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemJPCapital);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemOlam' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigOlam, frmConfigOlam);
      frmConfigOlam.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigOlam.strConfig         := 'CONFIG974-';
      frmConfigOlam.btnGravar.Caption := '&OK';
      frmConfigOlam.blnNaoEditar      := True;
      frmConfigOlam.ShowModal;

      If frmConfigOlam.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigOlam);
        Exit;
      End;

      intCartei := frmConfigOlam.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigOlam);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemOlam,frmExpArqRemOlam);
      frmExpArqRemOlam.intCartei  := intCartei;
      frmExpArqRemOlam.strNomForm := 'frmExpArqRemOlam';
      frmExpArqRemOlam.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemOlam);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBelaVista' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBelaVista, frmConfigBelaVista);
      frmConfigBelaVista.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBelaVista.strConfig         := 'CONFIG973-';
      frmConfigBelaVista.btnGravar.Caption := '&OK';
      frmConfigBelaVista.blnNaoEditar      := True;
      frmConfigBelaVista.ShowModal;

      If frmConfigBelaVista.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBelaVista);
        Exit;
      End;

      intCartei := frmConfigBelaVista.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBelaVista);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemBelaVista,frmExpArqRemBelaVista);
      frmExpArqRemBelaVista.intCartei  := intCartei;
      frmExpArqRemBelaVista.strNomForm := 'frmExpArqRemBelaVista';
      frmExpArqRemBelaVista.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemBelaVista);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBancoSrm' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSRM, frmConfigSRM);
      frmConfigSRM.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSRM.strConfig         := 'CONFIG990-';
      frmConfigSRM.btnGravar.Caption := '&OK';
      frmConfigSRM.blnNaoEditar      := True;
      frmConfigSRM.ShowModal;

      If frmConfigSRM.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSRM);
        Exit;
      End;

      intCartei := frmConfigSRM.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSRM);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemSRM, frmExpArqRemSRM);
      frmExpArqRemSRM.intCartei  := intCartei;
      frmExpArqRemSRM.strNomForm := 'frmExpArqRemSRM';
      frmExpArqRemSRM.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemSRM);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBancoFidussia' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigFidussia, frmConfigFidussia);
      frmConfigFidussia.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigFidussia.strConfig         := 'CONFIG970-';
      frmConfigFidussia.btnGravar.Caption := '&OK';
      frmConfigFidussia.blnNaoEditar      := True;
      frmConfigFidussia.ShowModal;

      If frmConfigFidussia.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigFidussia);
        Exit;
      End;

      intCartei := frmConfigFidussia.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigFidussia);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemFidussia, frmExpArqRemFidussia);
      frmExpArqRemFidussia.intCartei  := intCartei;
      frmExpArqRemFidussia.strNomForm := 'frmExpArqRemFidussia';
      frmExpArqRemFidussia.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemFidussia);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBancoMultiplike' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigMultiplike, frmConfigMultiplike);
      frmConfigMultiplike.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigMultiplike.strConfig         := 'CONFIG981-';
      frmConfigMultiplike.btnGravar.Caption := '&OK';
      frmConfigMultiplike.blnNaoEditar      := True;
      frmConfigMultiplike.ShowModal;

      If frmConfigMultiplike.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigMultiplike);
        Exit;
      End;

      intCartei := frmConfigMultiplike.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigMultiplike);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemMultiplike, frmExpArqRemMultiplike);
      frmExpArqRemMultiplike.intCartei  := intCartei;
      frmExpArqRemMultiplike.strNomForm := 'frmExpArqRemMultiplike';
      frmExpArqRemMultiplike.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemMultiplike);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemRedasset' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigRedasset, frmConfigRedasset);
      frmConfigRedasset.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigRedasset.btnGravar.Caption := '&OK';
      frmConfigRedasset.blnNaoEditar      := True;
      frmConfigRedasset.ShowModal;

      If frmConfigRedasset.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigRedasset);
        Exit;
      End;

      intCartei := frmConfigRedasset.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigRedasset);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemRedasset, frmExpArqRemRedasset);
      frmExpArqRemRedasset.intCartei  := intCartei;
      frmExpArqRemRedasset.strNomForm := 'frmConfigRedasset';
      frmExpArqRemRedasset.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemRedasset);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemCreditBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCreditBrasil, frmConfigCreditBrasil);
      frmConfigCreditBrasil.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCreditBrasil.btnGravar.Caption := '&OK';
      frmConfigCreditBrasil.blnNaoEditar      := True;
      frmConfigCreditBrasil.ShowModal;

      If frmConfigCreditBrasil.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigRedasset);
        Exit;
      End;

      intCartei := frmConfigCreditBrasil.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCreditBrasil);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemCreditBrasil, frmExpArqRemCreditBrasil);
      frmExpArqRemCreditBrasil.intCartei  := intCartei;
      frmExpArqRemCreditBrasil.strNomForm := 'frmConfigCreditBrasil';
      frmExpArqRemCreditBrasil.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemCreditBrasil);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemGarsonCredito' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigGarsonCredito, frmConfigGarsonCredito);
      frmConfigGarsonCredito.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigGarsonCredito.btnGravar.Caption := '&OK';
      frmConfigGarsonCredito.blnNaoEditar      := True;
      frmConfigGarsonCredito.ShowModal;

      If frmConfigGarsonCredito.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigGarsonCredito);
        Exit;
      End;

      intCartei := frmConfigGarsonCredito.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigGarsonCredito);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemGarsonCredito, frmExpArqRemGarsonCredito);
      frmExpArqRemGarsonCredito.intCartei  := intCartei;
      frmExpArqRemGarsonCredito.strNomForm := 'frmConfigGarsonCredito';
      frmExpArqRemGarsonCredito.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemGarsonCredito);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSifra, frmConfigSifra);
      frmConfigSifra.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSifra.btnGravar.Caption := '&OK';
      frmConfigSifra.blnNaoEditar      := True;
      frmConfigSifra.ShowModal;

      If frmConfigSifra.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSifra);
        Exit;
      End;

      intCartei := frmConfigSifra.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSifra);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemSifra, frmExpArqRemSifra);
      frmExpArqRemSifra.intCartei  := intCartei;
      frmExpArqRemSifra.strNomForm := 'frmConfigSifra';
      frmExpArqRemSifra.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemSifra);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemGrupoSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigGrupoSifra, frmConfigGrupoSifra);
      frmConfigGrupoSifra.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigGrupoSifra.btnGravar.Caption := '&OK';
      frmConfigGrupoSifra.blnNaoEditar      := True;
      frmConfigGrupoSifra.ShowModal;

      If frmConfigGrupoSifra.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigGrupoSifra);
        Exit;
      End;

      intCartei := frmConfigGrupoSifra.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigGrupoSifra);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemGrupoSifra, frmExpArqRemGrupoSifra);
      frmExpArqRemGrupoSifra.intCartei  := intCartei;
      frmExpArqRemGrupoSifra.strNomForm := 'frmConfigGrupoSifra';
      frmExpArqRemGrupoSifra.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemGrupoSifra);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemUnicred400_136' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigUnicred400_136, frmConfigUnicred400_136);
      frmConfigUnicred400_136.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigUnicred400_136.btnGravar.Caption := '&OK';
      frmConfigUnicred400_136.blnNaoEditar      := True;
      frmConfigUnicred400_136.ShowModal;

      If frmConfigUnicred400_136.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigUnicred400_136);
        Exit;
      End;

      intCartei := frmConfigUnicred400_136.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigUnicred400_136);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemUnicred400_136, frmExpArqRemUnicred400_136);
      frmExpArqRemUnicred400_136.intCartei  := intCartei;
      frmExpArqRemUnicred400_136.strNomForm := 'frmConfigUnicred400_136';
      frmExpArqRemUnicred400_136.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemUnicred400_136);
    End;
  End


  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemDaycoval400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigDaycoval, frmConfigDaycoval);
      frmConfigDaycoval.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigDaycoval.btnGravar.Caption := '&OK';
      frmConfigDaycoval.blnNaoEditar      := True;
      frmConfigDaycoval.ShowModal;

      If frmConfigDaycoval.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigDaycoval);
        Exit;
      End;

      intCartei := frmConfigDaycoval.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigDaycoval);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemDaycoval, frmExpArqRemDaycoval);
      frmExpArqRemDaycoval.intCartei  := intCartei;
      frmExpArqRemDaycoval.strNomForm := 'frmConfigDaycoval';
      frmExpArqRemDaycoval.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemDaycoval);
    End;
  End


  {******************************************}
  {*        BANCO DAYCOVAL [400P]           *}
  {*            LAYOUT PRÓPRIO              *}
  {*REQ:147378****************************MT*}
  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemDaycoval_707[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigDaycoval_707, frmConfigDaycoval_707);
      frmConfigDaycoval_707.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigDaycoval_707.btnGravar.Caption := '&OK';
      frmConfigDaycoval_707.blnNaoEditar      := True;
      frmConfigDaycoval_707.ShowModal;

      If frmConfigDaycoval_707.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigDaycoval_707);
        Exit;
      End;

      intCartei := frmConfigDaycoval_707.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigDaycoval_707);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemDaycoval_707, frmExpArqRemDaycoval_707);
      frmExpArqRemDaycoval_707.intCartei  := intCartei;
      frmExpArqRemDaycoval_707.strNomForm := 'frmConfigDaycoval_707';
      frmExpArqRemDaycoval_707.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemDaycoval_707);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemSBCredito_988[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSBCredito, frmConfigSBCredito);
      frmConfigSBCredito.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSBCredito.btnGravar.Caption := '&OK';
      frmConfigSBCredito.blnNaoEditar      := True;
      frmConfigSBCredito.ShowModal;

      If frmConfigSBCredito.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSBCredito);
        Exit;
      End;

      intCartei := frmConfigSBCredito.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSBCredito);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemSBCredito, frmExpArqRemSBCredito);
      frmExpArqRemSBCredito.intCartei  := intCartei;
      frmExpArqRemSBCredito.strNomForm := 'frmExpArqRemSBCredito';
      frmExpArqRemSBCredito.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemSBCredito);
    End;
  End

  // **********************************
  // *     SB CREDITO BRADESCO        *
  // **********************************
  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemSBCredito_Bradesco_987[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSBCredito_Bradesco, frmConfigSBCredito_Bradesco);
      frmConfigSBCredito_Bradesco.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSBCredito_Bradesco.btnGravar.Caption := '&OK';
      frmConfigSBCredito_Bradesco.blnNaoEditar      := True;
      frmConfigSBCredito_Bradesco.ShowModal;

      If frmConfigSBCredito_Bradesco.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSBCredito_Bradesco);
        Exit;
      End;

      intCartei := frmConfigSBCredito_Bradesco.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSBCredito_Bradesco);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemSBCredito_Bradesco, frmExpArqRemSBCredito_Bradesco);
      frmExpArqRemSBCredito_Bradesco.intCartei  := intCartei;
      frmExpArqRemSBCredito_Bradesco.strNomForm := 'frmExpArqRemSBCredito_Bradesco';
      frmExpArqRemSBCredito_Bradesco.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemSBCredito_Bradesco);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemSerrana' Then
    TSerranaMenu.ExportaArquivoDeRemessa

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemRubi' Then
    TRubiMenu.ExportaArquivoDeRemessa

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemUniprime400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigUniprime400, frmConfigUniprime400);
      frmConfigUniprime400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigUniprime400.btnGravar.Caption := '&OK';
      frmConfigUniprime400.blnNaoEditar      := True;
      frmConfigUniprime400.ShowModal;

      If frmConfigUniprime400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigUniprime400);
        Exit;
      End;

      intCartei := frmConfigUniprime400.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigUniprime400);
    End;

//    If fFiltraIndiceCarteiraBanco('237', 'CONFIG237-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
      Try
        pCriarFormularios(TfrmExpArqRemUniprime400,frmExpArqRemUniprime400);
        frmExpArqRemUniprime400.intCartei  := intCartei;
        frmExpArqRemUniprime400.strNomForm := 'frmConfigUniprime400';
        frmExpArqRemUniprime400.ShowModal;
      Finally
        FreeAndNil(frmExpArqRemUniprime400);
      End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 237 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBcoSisprime' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigSisprime, frmConfigSisprime);
      frmConfigSisprime.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSisprime.btnGravar.Caption := '&OK';
      frmConfigSisprime.blnNaoEditar      := True;
      frmConfigSisprime.ShowModal;

      If frmConfigSisprime.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSisprime);
        Exit;
      End;

      intCartei := frmConfigSisprime.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSisprime);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemSisprime, frmExpArqRemSisprime);
      frmExpArqRemSisprime.intCartei  := intCartei;
      frmExpArqRemSisprime.strNomForm := 'frmConfigSisprime';
      frmExpArqRemSisprime.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemSisprime);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemCredisan400' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCredisan400, frmConfigCredisan400);
      frmConfigCredisan400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCredisan400.btnGravar.Caption := '&OK';
      frmConfigCredisan400.blnNaoEditar      := True;
      frmConfigCredisan400.ShowModal;

      If frmConfigCredisan400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCredisan400);
        Exit;
      End;

      intCartei := frmConfigCredisan400.tabCarteira.TabIndex + 1;
    Finally
      FreeAndNil(frmConfigCredisan400);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemCredisan400, frmExpArqRemCredisan400);
      frmExpArqRemCredisan400.intCartei  := intCartei;
      frmExpArqRemCredisan400.strNomForm := 'frmConfigCredisan400';
      frmExpArqRemCredisan400.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemCredisan400);
    End;
  End

  {********************************}
  {* BANCO DO BRASIL DE 6 DIGITOS *}
  {*****************************LB*}
  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBrasil,frmConfigBrasil);
      frmConfigBrasil.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBrasil.btnGravar.Caption := '&OK';
      frmConfigBrasil.blnNaoEditar      := True;
      frmConfigBrasil.ShowModal;

      If frmConfigBrasil.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBrasil);
        Exit;
      End;

      intCartei := frmConfigBrasil.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBrasil);
    End;

//    If fFiltraIndiceCarteiraBanco('001', 'CONFIG001-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
      Try
        pCriarFormularios(TfrmExpArqRemBrasil,frmExpArqRemBrasil);
        frmExpArqRemBrasil.intCartei  := intCartei;
        frmExpArqRemBrasil.strNomForm := 'frmConfigBrasil';
        frmExpArqRemBrasil.ShowModal;
      Finally
        FreeAndNil(frmExpArqRemBrasil);
      End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 001 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  {********************************}
  {* BANCO DO BRASIL DE 7 DIGITOS *}
  {*****************************LB*}
  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBrasil7d' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBrasil7d,frmConfigBrasil7d);
      frmConfigBrasil7d.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBrasil7d.btnGravar.Caption := '&OK';
      frmConfigBrasil7d.blnPeFin := False;
      frmConfigBrasil7d.blnNaoEditar := True;
      frmConfigBrasil7d.ShowModal;

      If frmConfigBrasil7d.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBrasil7d);
        Exit;
      End;

      intCartei := frmConfigBrasil7d.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBrasil7d);
    End;

//   If fFiltraIndiceCarteiraBanco('001', 'CONFIG001D7-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
        Try
          pCriarFormularios(TfrmExpArqRemBrasil7d,frmExpArqRemBrasil7d);
          frmExpArqRemBrasil7d.intCartei  := intCartei;
          frmExpArqRemBrasil7d.strNomForm := 'frmConfigBrasil7d';
          frmExpArqRemBrasil7d.ShowModal;
        Finally
          FreeAndNil(frmExpArqRemBrasil7d);
        End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 001 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemCxFed' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCxFederal,frmConfigCxFederal);
      frmConfigCxFederal.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCxFederal.btnGravar.Caption := '&OK';
      frmConfigCxFederal.blnNaoEditar      := true;
      frmConfigCxFederal.ShowModal;

      If frmConfigCxFederal.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCxFederal);
        Exit;
      End;

      intCartei := frmConfigCxFederal.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCxFederal);
    End;

//   If fFiltraIndiceCarteiraBanco('104', 'CONFIG104-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
        Try
          pCriarFormularios(TfrmExpArqRemCxFed,frmExpArqRemCxFed);
          frmExpArqRemCxFed.intCartei  := intCartei;
          frmExpArqRemCxFed.strNomForm := 'frmConfigCxFederal';
          frmExpArqRemCxFed.ShowModal;
        Finally
          FreeAndNil(frmExpArqRemCxFed);
        End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 104 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemCxFed7D' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCxFederal7D,frmConfigCxFederal7D);
      frmConfigCxFederal7D.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCxFederal7D.btnGravar.Caption := '&OK';
      frmConfigCxFederal7D.blnNaoEditar      := true;
      frmConfigCxFederal7D.ShowModal;

      If frmConfigCxFederal7D.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCxFederal7D);
        Exit;
      End;

      intCartei := frmConfigCxFederal7D.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCxFederal7D);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemCxFed7D,frmExpArqRemCxFed7D);
      frmExpArqRemCxFed7D.intCartei  := intCartei;
      frmExpArqRemCxFed7D.strNomForm := 'frmConfigCxFederal7D';
      frmExpArqRemCxFed7D.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemCxFed7D);
    End;

  End

  {***************************************************}
  {* ARQUIVO DE EXPORTACAO BANCO CX. FEDRAL 400P     *}
  {************************************************LB*}
  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemCxFed400p' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCxFederal400p,frmConfigCxFederal400p);
      frmConfigCxFederal400p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCxFederal400p.btnGravar.Caption := '&OK';
      frmConfigCxFederal400p.blnNaoEditar      := True;
      frmConfigCxFederal400p.ShowModal;

      If frmConfigCxFederal400p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCxFederal400p);
        Exit;
      End;

      intCartei := frmConfigCxFederal400p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCxFederal400p);
    End;

//   If fFiltraIndiceCarteiraBanco('104', 'CONFIG104p400-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
        Try
          pCriarFormularios(TfrmExpArqRemCxFed400p,frmExpArqRemCxFed400p);
          frmExpArqRemCxFed400p.intCartei  := intCartei;
          frmExpArqRemCxFed400p.strNomForm := 'frmConfigCxFederal400p';
          frmExpArqRemCxFed400p.ShowModal;
        Finally
          FreeAndNil(frmExpArqRemCxFed400p);
        End;
//    End
//    Else
//    Begin
//     fMensagem('','Não há duplicatas do banco 104 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  {***************************************************}
  {* ARQUIVO DE EXPORTACAO BANCO BRB 400P            *}
  {************************************************LB*}
  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBRB400p' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBRB400p,frmConfigBRB400p);
      frmConfigBRB400p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBRB400p.btnGravar.Caption := '&OK';
      frmConfigBRB400p.blnNaoEditar      := True;
      frmConfigBRB400p.ShowModal;

      If frmConfigBRB400p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBRB400p);
        Exit;
      End;

      intCartei := frmConfigBRB400p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBRB400p);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemBRB400p,frmExpArqRemBRB400p);
      frmExpArqRemBRB400p.intCartei  := intCartei;
      frmExpArqRemBRB400p.strNomForm := 'frmConfigBRB400p';
      frmExpArqRemBRB400p.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemBRB400p);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemHsbc' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigHsbc,frmConfigHsbc);
      frmConfigHsbc.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigHsbc.btnGravar.Caption := '&OK';
      frmConfigHsbc.blnNaoEditar := true;
      frmConfigHsbc.ShowModal;

      If frmConfigHsbc.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigHsbc);
        Exit;
      End;

      intCartei := frmConfigHsbc.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigHsbc);
    End;

//    If fFiltraIndiceCarteiraBanco('399', 'CONFIG399-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
      Try
        pCriarFormularios(TfrmExpArqRemHsbc,frmExpArqRemHsbc);
        frmExpArqRemHsbc.intCartei  := intCartei;
        frmExpArqRemHsbc.strNomForm := 'frmConfigHsbc';
        frmExpArqRemHsbc.ShowModal;
      Finally
        FreeAndNil(frmExpArqRemHsbc);
      End;
//    End
//    Else
//    Begin
//     fMensagem('','Não há duplicatas do banco 399 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemItau' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigItau,frmConfigItau);
      frmConfigItau.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigItau.btnGravar.Caption := '&OK';
      frmConfigItau.blnNaoEditar := true;
      frmConfigItau.ShowModal;

      If frmConfigItau.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigItau);
        Exit;
      End;

      intCartei := frmConfigItau.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigItau);
    End;

//   If fFiltraIndiceCarteiraBanco('341', 'CONFIG341-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
        Try
          pCriarFormularios(TfrmExpArqRemItau,frmExpArqRemItau);
          frmExpArqRemItau.intCartei  := intCartei;
          frmExpArqRemItau.strNomForm := 'frmConfigItau';
          frmExpArqRemItau.ShowModal;
        Finally
          FreeAndNil(frmExpArqRemItau);
        End;
//    End
//    Else
//    Begin
//     fMensagem('','Não há duplicatas do banco 341 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmExpArqRemIEPTBSP' Then
  Begin

    Try
      pCriarFormularios(TfrmExpArqRemIEPTBSP,frmExpArqRemIEPTBSP);
      frmExpArqRemIEPTBSP.fraPathRemessa.edtDirectory.Text := fGetBancoConfig(0, 'CONFIGIEPTBSP', 'PATHREM', '');
      frmExpArqRemIEPTBSP.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemIEPTBSP);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmExpArqRemSparti' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSparti, frmConfigSparti);
      frmConfigSparti.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSparti.btnGravar.Caption := '&OK';
      frmConfigSparti.blnNaoEditar      := True;
      frmConfigSparti.ShowModal;

      If frmConfigSparti.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSparti);
        Exit;
      End;

      intCartei := frmConfigSparti.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmExpArqRemSparti);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemSparti, frmExpArqRemSparti);
      frmExpArqRemSparti.intCartei  := intCartei;
      frmExpArqRemSparti.strNomForm := 'frmExpArqSparti';
      frmExpArqRemSparti.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemSparti);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmExpArqRemLecca' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBancoLecca, frmConfigBancoLecca);
      frmConfigBancoLecca.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoLecca.btnGravar.Caption := '&OK';
      frmConfigBancoLecca.blnNaoEditar      := True;
      frmConfigBancoLecca.ShowModal;

      If frmConfigBancoLecca.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoLecca);
        Exit;
      End;

      intCartei := frmConfigBancoLecca.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBancoLecca);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemBancoLecca, frmExpArqRemBancoLecca);
      frmExpArqRemBancoLecca.intCartei  := intCartei;
      frmExpArqRemBancoLecca.strNomForm := 'frmExpArqRemBancoLecca';
      frmExpArqRemBancoLecca.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemBancoLecca);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmExpArqRemReal' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigReal,frmConfigReal);
      frmConfigReal.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigReal.btnGravar.Caption := '&OK';
      frmConfigReal.blnNaoEditar := true;
      frmConfigReal.ShowModal;

      If frmConfigReal.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigReal);
        Exit;
      End;

      intCartei := frmConfigReal.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigReal);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemReal, frmExpArqRemReal);
      frmExpArqRemReal.intCartei  := intCartei;
      frmExpArqRemReal.strNomForm := 'frmConfigReal';
      frmExpArqRemReal.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemReal);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemMerc' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigMercantil,frmConfigMercantil);
      frmConfigMercantil.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigMercantil.btnGravar.Caption := '&OK';
      frmConfigMercantil.blnNaoEditar := true;
      frmConfigMercantil.ShowModal;

      If frmConfigMercantil.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigMercantil);
        Exit;
      End;

      intCartei := frmConfigMercantil.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigMercantil);
    End;

//    If fFiltraIndiceCarteiraBanco('389', 'CONFIG389-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
      Try
        pCriarFormularios(TfrmExpArqRemMerc,frmExpArqRemMerc);
        frmExpArqRemMerc.intCartei := intCartei;
        frmExpArqRemMerc.strNomForm := 'frmConfigMercantil';
        frmExpArqRemMerc.ShowModal;
      Finally
        FreeAndNil(frmExpArqRemMerc);
      End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 389 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmExpArqRemNossaCx' Then
//  Begin
//
//    Try
//      pCriarFormularios(TfrmConfigNossaCx,frmConfigNossaCx);
//      frmConfigNossaCx.pnlTopo.Caption   := 'Selecione a carteira';
//      frmConfigNossaCx.btnGravar.Caption := '&OK';
//      frmConfigNossaCx.ShowModal;
//
//      If frmConfigNossaCx.ModalResult <> mrOK Then
//      Begin
//        FreeAndNil(frmConfigNossaCx);
//        Exit;
//      End;
//
//      intCartei := frmConfigNossaCx.tabCarteira.TabIndex + 1;
//
//    Finally
//      FreeAndNil(frmConfigNossaCx);
//    End;
//
//    Try
//      pCriarFormularios(TfrmExpArqRemNossaCx,frmExpArqRemNossaCx);
//      frmExpArqRemNossaCx.intCartei  := intCartei;
//      frmExpArqRemNossaCx.strNomForm := 'frmConfigNossaCx';
//      frmExpArqRemNossaCx.ShowModal;
//    Finally
//      FreeAndNil(frmExpArqRemNossaCx);
//    End;
//
//  End

//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmExpArqRemRibPreto' Then
//  Begin
//
//    Try
//      pCriarFormularios(TfrmConfigRibPreto,frmConfigRibPreto);
//      frmConfigRibPreto.pnlTopo.Caption   := 'Selecione a carteira';
//      frmConfigRibPreto.btnGravar.Caption := '&OK';
//      frmConfigRibPreto.ShowModal;
//
//      If frmConfigRibPreto.ModalResult <> mrOK Then
//      Begin
//        FreeAndNil(frmConfigRibPreto);
//        Exit;
//      End;
//
//      intCartei := frmConfigRibPreto.tabCarteira.TabIndex + 1;
//
//    Finally
//      FreeAndNil(frmConfigRibPreto);
//    End;
//
//    Try
//      pCriarFormularios(TfrmExpArqRemRibPreto,frmExpArqRemRibPreto);
//      frmExpArqRemRibPreto.intCartei  := intCartei;
//      frmExpArqRemRibPreto.strNomForm := 'frmConfigRibPreto';
//      frmExpArqRemRibPreto.ShowModal;
//    Finally
//      FreeAndNil(frmExpArqRemRibPreto);
//    End;
//
//  End

//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmExpArqRemUnibanco' Then
//  Begin
//
//    Try
//      pCriarFormularios(TfrmConfigUnibanco,frmConfigUnibanco);
//      frmConfigUnibanco.pnlTopo.Caption   := 'Selecione a carteira';
//      frmConfigUnibanco.btnGravar.Caption := '&OK';
//      frmConfigUnibanco.ShowModal;
//
//      If frmConfigUnibanco.ModalResult <> mrOK Then
//      Begin
//        FreeAndNil(frmConfigUnibanco);
//        Exit;
//      End;
//
//      intCartei := frmConfigUnibanco.tabCarteira.TabIndex + 1;
//
//    Finally
//      FreeAndNil(frmConfigUnibanco);
//    End;
//
//    Try
//      pCriarFormularios(TfrmExpArqRemUnibanco,frmExpArqRemUnibanco);
//      frmExpArqRemUnibanco.intCartei  := intCartei;
//      frmExpArqRemUnibanco.strNomForm := 'frmConfigUnibanco';
//      frmExpArqRemUnibanco.ShowModal;
//    Finally
//      FreeAndNil(frmExpArqRemUnibanco);
//    End;
//
//  End


  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemSicredi' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSicredi, frmConfigSicredi);
      frmConfigSicredi.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSicredi.btnGravar.Caption := '&OK';
      frmConfigSicredi.strConfig         := 'CONFIG748-';
      frmConfigSicredi.blnNaoEditar := true;
      frmConfigSicredi.ShowModal;

      If frmConfigSicredi.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSicredi);
        Exit;
      End;

      intCartei := frmConfigSicredi.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSicredi);
    End;

//    If fFiltraIndiceCarteiraBanco('748', 'CONFIG748-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
      Try
        pCriarFormularios(TfrmExpArqRemSicredi, frmExpArqRemSicredi);
        frmExpArqRemSicredi.intCartei  := intCartei;
        frmExpArqRemSicredi.strNomForm := 'frmConfigSicredi';
        frmExpArqRemSicredi.ShowModal;
      Finally
        FreeAndNil(frmExpArqRemSicredi);
      End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 748 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemSicredi240' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSicredi240, frmConfigSicredi240);
      frmConfigSicredi240.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSicredi240.btnGravar.Caption := '&OK';
      frmConfigSicredi240.blnNaoEditar := true;
      frmConfigSicredi240.ShowModal;

      If frmConfigSicredi240.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSicredi240);
        Exit;
      End;

      intCartei := frmConfigSicredi240.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSicredi240);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemSicredi240, frmExpArqRemSicredi240);
      frmExpArqRemSicredi240.intCartei  := intCartei;
      frmExpArqRemSicredi240.strNomForm := 'frmConfigSicredi240';
      frmExpArqRemSicredi240.ShowModal;

    Finally
      FreeAndNil(frmExpArqRemSicredi240);
    End;
  End


  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBanrisul' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBanrisul, frmConfigBanrisul);
      frmConfigBanrisul.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBanrisul.btnGravar.Caption := '&OK';
      frmConfigBanrisul.blnNaoEditar := true;
      frmConfigBanrisul.ShowModal;

      If frmConfigBanrisul.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBanrisul);
        Exit;
      End;

      intCartei := frmConfigBanrisul.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBanrisul);
    End;

//    If fFiltraIndiceCarteiraBanco('041', 'CONFIG041-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
      Try
        pCriarFormularios(TfrmExpArqRemBanrisul, frmExpArqRemBanrisul);
        frmExpArqRemBanrisul.intCartei  := intCartei;
        frmExpArqRemBanrisul.strNomForm := 'frmConfigBanrisul';
        frmExpArqRemBanrisul.ShowModal;
      Finally
        FreeAndNil(frmExpArqRemBanrisul);
      End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 041 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBanrisul240' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBanrisul240, frmConfigBanrisul240);
      frmConfigBanrisul240.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBanrisul240.btnGravar.Caption := '&OK';
      frmConfigBanrisul240.blnNaoEditar := true;
      frmConfigBanrisul240.ShowModal;

      If frmConfigBanrisul240.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBanrisul240);
        Exit;
      End;

      intCartei := frmConfigBanrisul240.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBanrisul240);
    End;

      Try
        pCriarFormularios(TfrmExpArqRemBanrisul240, frmExpArqRemBanrisul240);
        frmExpArqRemBanrisul240.intCartei  := intCartei;
        frmExpArqRemBanrisul240.strNomForm := 'frmConfigBanrisul240';
        frmExpArqRemBanrisul240.ShowModal;
      Finally
        FreeAndNil(frmExpArqRemBanrisul240);
      End;

  End

//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmExpArqRemSantander' Then
//  Begin
//
//    Try
//      pCriarFormularios(TfrmConfigSantander,frmConfigSantander);
//      frmConfigSantander.pnlTopo.Caption   := 'Selecione a carteira';
//      frmConfigSantander.btnGravar.Caption := '&OK';
//      frmConfigSantander.ShowModal;
//
//      If frmConfigSantander.ModalResult <> mrOK Then
//      Begin
//        FreeAndNil(frmConfigSantander);
//        Exit;
//      End;
//
//      intCartei := frmConfigSantander.tabCarteira.TabIndex + 1;
//
//    Finally
//      FreeAndNil(frmConfigSantander);
//    End;
//
//    Try
//      pCriarFormularios(TfrmExpArqRemSantander,frmExpArqRemSantander);
//      frmExpArqRemSantander.intCartei  := intCartei;
//      frmExpArqRemSantander.strNomForm := 'frmConfigSantander';
//      frmExpArqRemSantander.ShowModal;
//    Finally
//      FreeAndNil(frmExpArqRemSantander);
//    End;
//
//  End

  Else If SameText(arrMenu[intIndex].strNomform, 'frmExpArqRemSantanderBan') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSantanderBan,frmConfigSantanderBan);
      frmConfigSantanderBan.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSantanderBan.btnGravar.Caption := '&OK';
      frmConfigSantanderBan.blnNaoEditar := true;
      frmConfigSantanderBan.ShowModal;

      If frmConfigSantanderBan.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSantanderBan);
        Exit;
      End;

      intCartei := frmConfigSantanderBan.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSantanderBan);
    End;

//   If fFiltraIndiceCarteiraBanco('033', 'CONFIG033-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
        Try
          pCriarFormularios(TfrmExpArqRemSantanderBan,frmExpArqRemSantanderBan);
          frmExpArqRemSantanderBan.intCartei  := intCartei;
          frmExpArqRemSantanderBan.strNomForm := 'frmConfigSantanderBan';
          frmExpArqRemSantanderBan.ShowModal;
        Finally
          FreeAndNil(frmExpArqRemSantanderBan);
        End;
//    End
//    Else
//    Begin
//     fMensagem('','Não há duplicatas do banco 033 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  Else If SameText(arrMenu[intIndex].strNomform, 'frmExpArqRemSantander240p') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSantander240p,frmConfigSantander240p);
      frmConfigSantander240p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSantander240p.btnGravar.Caption := '&OK';
      frmConfigSantander240p.blnNaoEditar      := True;
      frmConfigSantander240p.ShowModal;

      If frmConfigSantander240p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSantander240p);
        Exit;
      End;

      intCartei := frmConfigSantander240p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSantander240p);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemSantander240p,frmExpArqRemSantander240p);
      frmExpArqRemSantander240p.intCartei  := intCartei;
      frmExpArqRemSantander240p.strNomForm := 'frmConfigSantander240p';
      frmExpArqRemSantander240p.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemSantander240p);
    End;

  End


  Else If SameText(arrMenu[intIndex].strNomform, 'frmExpArqRemBanestes') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBanestes,frmConfigBanestes);
      frmConfigBanestes.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBanestes.btnGravar.Caption := '&OK';
      frmConfigBanestes.blnNaoEditar := true;
      frmConfigBanestes.ShowModal;

      If frmConfigBanestes.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBanestes);
        Exit;
      End;

      intCartei := frmConfigBanestes.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBanestes);
    End;

//    If fFiltraIndiceCarteiraBanco('021', 'CONFIG021-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
      Try
        pCriarFormularios(TfrmExpArqRemBanestes,frmExpArqRemBanestes);
        frmExpArqRemBanestes.intCartei  := intCartei;
        frmExpArqRemBanestes.strNomForm := 'frmConfigBanestes';
        frmExpArqRemBanestes.ShowModal;
      Finally
        FreeAndNil(frmExpArqRemBanestes);
      End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 021 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBancoob' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBancoob,frmConfigBancoob);
      frmConfigBancoob.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoob.btnGravar.Caption := '&OK';
      frmConfigBancoob.blnNaoEditar      := True;
      frmConfigBancoob.ShowModal;

      If frmConfigBancoob.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoob);
        Exit;
      End;

      intCartei := frmConfigBancoob.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBancoob);
    End;

//    If fFiltraIndiceCarteiraBanco('756', 'CONFIG756-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
      Try
        pCriarFormularios(TfrmExpArqRemBancoob, frmExpArqRemBancoob);
        frmExpArqRemBancoob.intCartei  := intCartei;
        frmExpArqRemBancoob.strNomForm := 'frmConfigBancoob';
        frmExpArqRemBancoob.ShowModal;
      Finally
        FreeAndNil(frmExpArqRemBancoob);
      End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 756 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBancoob240' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBancoob240,frmConfigBancoob240);
      frmConfigBancoob240.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoob240.btnGravar.Caption := '&OK';
      frmConfigBancoob240.blnNaoEditar := true;
      frmConfigBancoob240.ShowModal;

      If frmConfigBancoob240.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoob240);
        Exit;
      End;

      intCartei := frmConfigBancoob240.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBancoob240);
    End;

//    If fFiltraIndiceCarteiraBanco('756', 'CONFIG756_240p-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
      Try
        pCriarFormularios(TfrmExpArqRemBancoob240, frmExpArqRemBancoob240);
        frmExpArqRemBancoob240.intCartei  := intCartei;
        frmExpArqRemBancoob240.strNomForm := 'frmConfigBancoob240';
        frmExpArqRemBancoob240.ShowModal;
      Finally
        FreeAndNil(frmExpArqRemBancoob240);
      End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 756 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBradesco240V' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBradesco240Vendor,frmConfigBradesco240Vendor);
      frmConfigBradesco240Vendor.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBradesco240Vendor.btnGravar.Caption := '&OK';
      frmConfigBradesco240Vendor.blnNaoEditar := true;
      frmConfigBradesco240Vendor.ShowModal;

      If frmConfigBradesco240Vendor.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBradesco240Vendor);
        Exit;
      End;

      intCartei := frmConfigBradesco240Vendor.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBradesco240Vendor);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemBradesco240Vendor, frmExpArqRemBradesco240Vendor);
      frmExpArqRemBradesco240Vendor.intCartei  := intCartei;
      frmExpArqRemBradesco240Vendor.strNomForm := 'frmExpArqRemBradesco240Vendor';
      frmExpArqRemBradesco240Vendor.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemBradesco240Vendor);
    End;
  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmExpArqRemSafra' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSafra,frmConfigSafra);
      frmConfigSafra.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSafra.btnGravar.Caption := '&OK';
      frmConfigSafra.blnNaoEditar := true;
      frmConfigSafra.ShowModal;

      If frmConfigSafra.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSafra);
        Exit;
      End;

      intCartei := frmConfigSafra.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSafra);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemSafra, frmExpArqRemSafra);
      frmExpArqRemSafra.intCartei  := intCartei;
      frmExpArqRemSafra.strNomForm := 'frmConfigSafra';
      frmExpArqRemSafra.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemSafra);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemSofisa' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSofisa,frmConfigSofisa);
      frmConfigSofisa.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSofisa.btnGravar.Caption := '&OK';
      frmConfigSofisa.blnNaoEditar := true;
      frmConfigSofisa.ShowModal;

      If frmConfigSofisa.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSofisa);
        Exit;
      End;

      intCartei := frmConfigSofisa.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSofisa);
    End;

//    If fFiltraIndiceCarteiraBanco('637', 'CONFIG637-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
      Try
        pCriarFormularios(TfrmExpArqRemSofisa,frmExpArqRemSofisa);
        frmExpArqRemSofisa.intCartei  := intCartei;
        frmExpArqRemSofisa.strNomForm := 'frmConfigSofisa';
        frmExpArqRemSofisa.ShowModal;
      Finally
        FreeAndNil(frmExpArqRemSofisa);
      End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 637 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemSofisa_444' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSofisa_444,frmConfigSofisa_444);
      frmConfigSofisa_444.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSofisa_444.btnGravar.Caption := '&OK';
      frmConfigSofisa_444.blnNaoEditar := true;
      frmConfigSofisa_444.ShowModal;

      If frmConfigSofisa_444.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSofisa_444);
        Exit;
      End;

      intCartei := frmConfigSofisa_444.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSofisa_444);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemSofisa_444,frmExpArqRemSofisa_444);
      frmExpArqRemSofisa_444.intCartei  := intCartei;
      frmExpArqRemSofisa_444.strNomForm := 'frmConfigSofisa_444';
      frmExpArqRemSofisa_444.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemSofisa_444);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBtgPactual_240p' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBtgPactual_240p,frmConfigBtgPactual_240p);
      frmConfigBtgPactual_240p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBtgPactual_240p.btnGravar.Caption := '&OK';
      frmConfigBtgPactual_240p.blnNaoEditar := true;
      frmConfigBtgPactual_240p.ShowModal;

      If frmConfigBtgPactual_240p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBtgPactual_240p);
        Exit;
      End;

      intCartei := frmConfigBtgPactual_240p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBtgPactual_240p);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemBtgPactual_240p,frmExpArqRemBtgPactual_240p);
      frmExpArqRemBtgPactual_240p.intCartei  := intCartei;
      frmExpArqRemBtgPactual_240p.strNomForm := 'frmConfigBtgPactual_240p';
      frmExpArqRemBtgPactual_240p.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemBtgPactual_240p);
    End;

  End

  {**************************}
  {* BANCO GERENCIANET 240  *}
  {MF: 284963 - 12/07/23 ****}
  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemGerencianet240p' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigGerencianet240p,frmConfigGerencianet240p);
      frmConfigGerencianet240p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigGerencianet240p.btnGravar.Caption := '&OK';
      frmConfigGerencianet240p.strConfig         := 'CONFIG364-';
      frmConfigGerencianet240p.blnNaoEditar      := True;
      frmConfigGerencianet240p.ShowModal;

      If frmConfigGerencianet240p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigGerencianet240p);
        Exit;
      End;

      intCartei := frmConfigGerencianet240p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigGerencianet240p);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemGerencianet240p,frmExpArqRemGerencianet240p);
      frmExpArqRemGerencianet240p.intCartei  := intCartei;
      frmExpArqRemGerencianet240p.strNomForm := 'frmConfigGerencianet240p';
      frmExpArqRemGerencianet240p.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemGerencianet240p);
    End;

  End

  {**************************}
  {* BANCO CRESOL 240       *}
  {MF: 287323 - 14/07/23 ****}
  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemCresol240p' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCresol240p,frmConfigCresol240p);
      frmConfigCresol240p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCresol240p.btnGravar.Caption := '&OK';
      frmConfigCresol240p.strConfig         := 'CONFIG133-';
      frmConfigCresol240p.blnNaoEditar      := True;
      frmConfigCresol240p.ShowModal;

      If frmConfigCresol240p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCresol240p);
        Exit;
      End;

      intCartei := frmConfigCresol240p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCresol240p);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemCresol240p,frmExpArqRemCresol240p);
      frmExpArqRemCresol240p.intCartei  := intCartei;
      frmExpArqRemCresol240p.strNomForm := 'frmConfigCresol240p';
      frmExpArqRemCresol240p.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemCresol240p);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBancoAmazonia' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBancoAmazonia,frmConfigBancoAmazonia);
      frmConfigBancoAmazonia.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoAmazonia.btnGravar.Caption := '&OK';
      frmConfigBancoAmazonia.blnNaoEditar := true;
      frmConfigBancoAmazonia.ShowModal;

      If frmConfigBancoAmazonia.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoAmazonia);
        Exit;
      End;

      intCartei := frmConfigBancoAmazonia.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBancoAmazonia);
    End;

//    If fFiltraIndiceCarteiraBanco('003', 'CONFIG003-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
      If fGetBancoConfig(0,'CONFIG003-' + IntToStr(intCartei),'COBREG_','') = 'N' Then
      Begin
        fMensagem('ATENÇÃO!', 'Só é permitido gerar remessa utilizando carteiras com registro!',['&Ok']);
        Exit;
      End
      Else
      Begin
        Try
          pCriarFormularios(TfrmExpArqRemBancoAmazonia,frmExpArqRemBancoAmazonia);
          frmExpArqRemBancoAmazonia.intCartei  := intCartei;
          frmExpArqRemBancoAmazonia.strNomForm := 'frmConfigBancoAmazonia';
          frmExpArqRemBancoAmazonia.ShowModal;
        Finally
          FreeAndNil(frmExpArqRemBancoAmazonia);
        End;
      End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 003 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemRendimento' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigRendimento,frmConfigRendimento);
      frmConfigRendimento.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigRendimento.btnGravar.Caption := '&OK';
      frmConfigRendimento.blnNaoEditar := true;
      frmConfigRendimento.ShowModal;

      If frmConfigRendimento.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigRendimento);
        Exit;
      End;

      intCartei := frmConfigRendimento.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigRendimento);
    End;

//    If fFiltraIndiceCarteiraBanco('633', 'CONFIG633-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
      Try
        pCriarFormularios(TfrmExpArqRemRendimento,frmExpArqRemRendimento);
        frmExpArqRemRendimento.intCartei  := intCartei;
        frmExpArqRemRendimento.strNomForm := 'frmConfigRendimento';
        frmExpArqRemRendimento.ShowModal;
      Finally
        FreeAndNil(frmExpArqRemRendimento);
      End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 633 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemNordeste400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigNordeste400,frmConfigNordeste400);
      frmConfigNordeste400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigNordeste400.btnGravar.Caption := '&OK';
      frmConfigNordeste400.blnNaoEditar      := True;
      frmConfigNordeste400.ShowModal;

      If frmConfigNordeste400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigNordeste400);
        Exit;
      End;

      intCartei := frmConfigNordeste400.tabCarteira.TabIndex + 1;
    Finally
      FreeAndNil(frmConfigNordeste400);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemNordeste400,frmExpArqRemNordeste400);
      frmExpArqRemNordeste400.intCartei  := intCartei;
      frmExpArqRemNordeste400.strNomForm := 'frmConfigNordeste400';
      frmExpArqRemNordeste400.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemNordeste400);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemCecred' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCecred,frmConfigCecred);
      frmConfigCecred.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCecred.btnGravar.Caption := '&OK';
      frmConfigCecred.blnNaoEditar := true;
      frmConfigCecred.ShowModal;

      If frmConfigCecred.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCecred);
        Exit;
      End;

      intCartei := frmConfigCecred.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCecred);
    End;

//    If fFiltraIndiceCarteiraBanco('085', 'CONFIG085-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
      Try
        pCriarFormularios(TfrmExpArqRemCecred,frmExpArqRemCecred);
        frmExpArqRemCecred.intCartei  := intCartei;
        frmExpArqRemCecred.strNomForm := 'frmConfigCecred';
        frmExpArqRemCecred.ShowModal;
      Finally
        FreeAndNil(frmExpArqRemCecred);
      End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 085 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemUnicred' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigUnicred,frmConfigUnicred);
      frmConfigUnicred.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigUnicred.btnGravar.Caption := '&OK';
      frmConfigUnicred.blnNaoEditar := true;
      frmConfigUnicred.ShowModal;

      If frmConfigUnicred.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigUnicred);
        Exit;
      End;

      intCartei := frmConfigUnicred.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigUnicred);
    End;

//    If fFiltraIndiceCarteiraBanco('090', 'CONFIG090-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
      Try
        pCriarFormularios(TfrmExpArqRemUnicred,frmExpArqRemUnicred);
        frmExpArqRemUnicred.intCartei  := intCartei;
        frmExpArqRemUnicred.strNomForm := 'frmConfigUnicred';
        frmExpArqRemUnicred.ShowModal;
      Finally
        FreeAndNil(frmExpArqRemUnicred);
      End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 090 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemUnicred400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigUnicred400,frmConfigUnicred400);
      frmConfigUnicred400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigUnicred400.btnGravar.Caption := '&OK';
      frmConfigUnicred400.blnNaoEditar := true;
      frmConfigUnicred400.ShowModal;

      If frmConfigUnicred400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigUnicred400);
        Exit;
      End;

      intCartei := frmConfigUnicred400.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigUnicred400);
    End;

//    If fFiltraIndiceCarteiraBanco('090', 'CONFIG090_400p-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
      Try
        pCriarFormularios(TfrmExpArqRemUnicred400,frmExpArqRemUnicred400);
        frmExpArqRemUnicred400.intCartei  := intCartei;
        frmExpArqRemUnicred400.strNomForm := 'frmConfigUnicred400';
        frmExpArqRemUnicred400.ShowModal;
      Finally
        FreeAndNil(frmExpArqRemUnicred400);
      End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 090 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End
  {***********************************}
  {* BANCO ABC BRASIL                *}
  {*REQ.34692 29/05/2015***********JU*}
  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemABCBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigABCBrasil,frmConfigABCBrasil);
      frmConfigABCBrasil.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigABCBrasil.btnGravar.Caption := '&OK';
      frmConfigABCBrasil.blnNaoEditar := true;
      frmConfigABCBrasil.ShowModal;

      If frmConfigABCBrasil.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigABCBrasil);
        Exit;
      End;

      intCartei := frmConfigABCBrasil.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigABCBrasil);
    End;

//    If fFiltraIndiceCarteiraBanco('246', 'CONFIG246-' + IntToStr(intCartei) + '-' + VS_strCodEmp) Then
//    Begin
      Try
        pCriarFormularios(TfrmExpArqRemABCBrasil,frmExpArqRemABCBrasil);
        frmExpArqRemABCBrasil.intCartei  := intCartei;
        frmExpArqRemABCBrasil.strNomForm := 'frmConfigABCBrasil';
        frmExpArqRemABCBrasil.ShowModal;
      Finally
        FreeAndNil(frmExpArqRemABCBrasil);
      End;
//    End
//    Else
//    Begin
//      fMensagem('','Não há duplicatas do banco 246 da carteira ' + IntToStr(intCartei) + ' para serem exportadas!', ['&Ok']);
//      Exit;
//    End;

  End

  {****************}
  {*    IEPTBSP   *}
  {*REQ-65923-***MO}
  Else If arrMenu[intIndex].strNomForm = 'frmArqRetIEPTBSP' Then
    Begin
    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno IEPTB-SP - Central de Protesto';
      frmRetBco.strNomBanco      := 'IEPTB-SP';
      frmRetBco.intCartei        := 0;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIGIEPTBSP', 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmArqRetSparti' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSparti, frmConfigSparti);
      frmConfigSparti.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSparti.btnGravar.Caption := '&OK';
      frmConfigSparti.blnNaoEditar      := True;
      frmConfigSparti.ShowModal;

      If frmConfigSparti.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSparti);
        Exit;
      End;

      intCartei := frmConfigSparti.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSparti);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - Sparti';
      frmRetBco.strNomBanco      := '982 - Sparti';
      frmRetBco.intCartei        := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG982-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmArqRetLecca' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBancoLecca, frmConfigBancoLecca);
      frmConfigBancoLecca.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoLecca.btnGravar.Caption := '&OK';
      frmConfigBancoLecca.blnNaoEditar      := True;
      frmConfigBancoLecca.ShowModal;

      If frmConfigBancoLecca.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoLecca);
        Exit;
      End;

      intCartei := frmConfigBancoLecca.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBancoLecca);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - Lecca';
      frmRetBco.strNomBanco      := '984 - Banco Lecca';
      frmRetBco.intCartei        := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG984-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

//**NOVOBANCO
  {********************************}
  {* ARQUIVO DE RETORNO           *}
  {*****************************LB*}
  {********************************}
  {* BANDO DO BRASIL DE 6 DIGITOS *}
  {*****************************LB*}
  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBrasil,frmConfigBrasil);
      frmConfigBrasil.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBrasil.btnGravar.Caption := '&OK';
      frmConfigBrasil.blnNaoEditar      := True;
      frmConfigBrasil.ShowModal;

      If frmConfigBrasil.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBrasil);
        Exit;
      End;

      intCartei := frmConfigBrasil.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBrasil);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 001 - Brasil';
      frmRetBco.strNomBanco            := '001 - Brasil';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.strDigito              := 'D6-';
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG001-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  {********************************}
  {* BANCO DO BRASIL DE 7 DIGITOS *}
  {*****************************LB*}
  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBrasil7d' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBrasil7d,frmConfigBrasil7d);
      frmConfigBrasil7d.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBrasil7d.btnGravar.Caption := '&OK';
      frmConfigBrasil7d.blnPeFin := False;
      frmConfigBrasil7d.blnNaoEditar := True;
      frmConfigBrasil7d.ShowModal;

      If frmConfigBrasil7d.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBrasil7d);
        Exit;
      End;

      intCartei := frmConfigBrasil7d.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBrasil7d);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 001 - Brasil7d';
      frmRetBco.strNomBanco            := '001 - Brasil7d';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.strDigito              := 'D7-';
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG001D7-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End


//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmArqRetBanespa' Then
//  Begin
//
//    Try
//      pCriarFormularios(TfrmConfigBanespa,frmConfigBanespa);
//      frmConfigBanespa.pnlTopo.Caption   := 'Selecione a carteira';
//      frmConfigBanespa.btnGravar.Caption := '&OK';
//      frmConfigBanespa.ShowModal;
//
//      If frmConfigBanespa.ModalResult <> mrOK Then
//      Begin
//        FreeAndNil(frmConfigBanespa);
//        Exit;
//      End;
//
//      intCartei := frmConfigBanespa.tabCarteira.TabIndex + 1;
//
//    Finally
//      FreeAndNil(frmConfigBanespa);
//    End;
//
//    Try
//      pCriarFormularios(TfrmRetBco,frmRetBco);
//      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 033 - Banespa';
//      frmRetBco.strNomBanco      := '033 - Banespa';
//      frmRetBco.intCartei  := intCartei;
//      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG033-' + IntToStr(intCartei), 'PATHRET', '');
//      frmRetBco.ShowModal;
//    Finally
//      FreeAndNil(frmRetBco);
//    End;
//
//  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBradesco' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBradesco,frmConfigBradesco);
      frmConfigBradesco.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBradesco.btnGravar.Caption := '&OK';
      frmConfigBradesco.blnNaoEditar      := True;
      frmConfigBradesco.ShowModal;

      If frmConfigBradesco.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBradesco);
        Exit;
      End;

      intCartei := frmConfigBradesco.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBradesco);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 237 - Bradesco';
      frmRetBco.strNomBanco      := '237 - Bradesco';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG237-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.UtilizaAlpe := (fGetBancoConfig(0, 'CONFIG237-' + IntToStr(intCartei), 'UTILIZA_ALPE', '') = 'S');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetFomentoMercantil400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigFomentoMercantil400, frmConfigFomentoMercantil400);
      frmConfigFomentoMercantil400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigFomentoMercantil400.btnGravar.Caption := '&OK';
      frmConfigFomentoMercantil400.blnNaoEditar      := True;
      frmConfigFomentoMercantil400.ShowModal;

      If frmConfigFomentoMercantil400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigFomentoMercantil400);
        Exit;
      End;

      intCartei := frmConfigFomentoMercantil400.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigFomentoMercantil400);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 994 - Na Fomento Mercantil';
      frmRetBco.strNomBanco            := '994 - Na Fomento Mercantil';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG994-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBMPMoneyPlus' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBMPMoneyPlus, frmConfigBMPMoneyPlus);
      frmConfigBMPMoneyPlus.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBMPMoneyPlus.btnGravar.Caption := '&OK';
      frmConfigBMPMoneyPlus.blnNaoEditar      := True;
      frmConfigBMPMoneyPlus.ShowModal;

      If frmConfigBMPMoneyPlus.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBMPMoneyPlus);
        Exit;
      End;

      intCartei := frmConfigBMPMoneyPlus.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBMPMoneyPlus);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 274 - BMPMoneyPlus';
      frmRetBco.strNomBanco      := '274 - BMPMoneyPlus';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG274-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBmpMoneyPlus_LP_400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBMPMoneyPlus_LP_400, frmConfigBMPMoneyPlus_LP_400);
      frmConfigBMPMoneyPlus_LP_400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBMPMoneyPlus_LP_400.btnGravar.Caption := '&OK';
      frmConfigBMPMoneyPlus_LP_400.blnNaoEditar      := True;
      frmConfigBMPMoneyPlus_LP_400.ShowModal;

      If frmConfigBMPMoneyPlus_LP_400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBMPMoneyPlus_LP_400);
        Exit;
      End;

      intCartei := frmConfigBMPMoneyPlus_LP_400.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBMPMoneyPlus_LP_400);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 274 - BMP Money Plus LP [400p]';
      frmRetBco.strNomBanco      := '274 - BMP Money Plus LP [400p]';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG274LP400p-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetAthenaAtlanta400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigAthenaAtlanta, frmConfigAthenaAtlanta);
      frmConfigAthenaAtlanta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigAthenaAtlanta.btnGravar.Caption := '&OK';
      frmConfigAthenaAtlanta.strConfig         := 'CONFIG996-';
      frmConfigAthenaAtlanta.blnNaoEditar      := True;
      frmConfigAthenaAtlanta.ShowModal;

      If frmConfigAthenaAtlanta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigAthenaAtlanta);
        Exit;
      End;

      intCartei := frmConfigAthenaAtlanta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigAthenaAtlanta);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 996 - Athena Atlanta';
      frmRetBco.strNomBanco            := '996 - Athena Atlanta';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG996-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetMultibank' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigMultibank,frmConfigMultibank);
      frmConfigMultibank.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigMultibank.btnGravar.Caption := '&OK';
      frmConfigMultibank.strConfig         := 'CONFIG983-';
      frmConfigMultibank.blnNaoEditar      := True;
      frmConfigMultibank.ShowModal;

      If frmConfigMultibank.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigMultibank);
        Exit;
      End;

      intCartei := frmConfigMultibank.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigMultibank);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 983 - Banco Multibank';
      frmRetBco.strNomBanco            := '983 - Banco Multibank';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG983-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBancoJpiFidc' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigJpiFidc,frmConfigJpiFidc);
      frmConfigJpiFidc.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigJpiFidc.btnGravar.Caption := '&OK';
      frmConfigJpiFidc.strConfig         := 'CONFIG906-';
      frmConfigJpiFidc.blnNaoEditar      := True;
      frmConfigJpiFidc.ShowModal;

      If frmConfigJpiFidc.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigJpiFidc);
        Exit;
      End;

      intCartei := frmConfigJpiFidc.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigJpiFidc);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 906 - Banco FIDC';
      frmRetBco.strNomBanco            := '906 - Banco FIDC';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG906-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBancoCapitalFinancas' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCapitalFinancas,frmConfigCapitalFinancas);
      frmConfigCapitalFinancas.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCapitalFinancas.btnGravar.Caption := '&OK';
      frmConfigCapitalFinancas.strConfig         := 'CONFIG978-';
      frmConfigCapitalFinancas.blnNaoEditar      := True;
      frmConfigCapitalFinancas.ShowModal;

      If frmConfigCapitalFinancas.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCapitalFinancas);
        Exit;
      End;

      intCartei := frmConfigCapitalFinancas.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCapitalFinancas);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 978 - Capital Finanças';
      frmRetBco.strNomBanco            := '978 - Capital Finanças';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG978-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBancoSrm' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigSRM,frmConfigSRM);
      frmConfigSRM.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSRM.btnGravar.Caption := '&OK';
      frmConfigSRM.strConfig         := 'CONFIG990-';
      frmConfigSRM.blnNaoEditar      := True;
      frmConfigSRM.ShowModal;

      If frmConfigSRM.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSRM);
        Exit;
      End;

      intCartei := frmConfigSRM.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSRM);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 990 - Banco SRM';
      frmRetBco.strNomBanco            := '990 - Banco SRM';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG990-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBancoFidussia' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigFidussia,frmConfigFidussia);
      frmConfigFidussia.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigFidussia.btnGravar.Caption := '&OK';
      frmConfigFidussia.strConfig         := 'CONFIG970-';
      frmConfigFidussia.blnNaoEditar      := True;
      frmConfigFidussia.ShowModal;

      If frmConfigFidussia.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigFidussia);
        Exit;
      End;

      intCartei := frmConfigFidussia.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigFidussia);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 970 - Banco Fidussia';
      frmRetBco.strNomBanco            := '970 - Banco Fidussia';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG970-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBancoMultiplike' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigMultiplike,frmConfigMultiplike);
      frmConfigMultiplike.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigMultiplike.btnGravar.Caption := '&OK';
      frmConfigMultiplike.strConfig         := 'CONFIG981-';
      frmConfigMultiplike.blnNaoEditar      := True;
      frmConfigMultiplike.ShowModal;

      If frmConfigMultiplike.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigMultiplike);
        Exit;
      End;

      intCartei := frmConfigMultiplike.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigMultiplike);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 981 - Banco Multiplike';
      frmRetBco.strNomBanco            := '981 - Banco Multiplike';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG981-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetRedasset' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigRedasset, frmConfigRedasset);
      frmConfigRedasset.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigRedasset.btnGravar.Caption := '&OK';
      frmConfigRedasset.blnNaoEditar      := True;
      frmConfigRedasset.ShowModal;

      If frmConfigRedasset.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigRedasset);
        Exit;
      End;

      intCartei := frmConfigRedasset.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigRedasset);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 993 - Redasset';
      frmRetBco.strNomBanco            := '993 - Redasset';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG993-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetCreditBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCreditBrasil, frmConfigCreditBrasil);
      frmConfigCreditBrasil.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCreditBrasil.btnGravar.Caption := '&OK';
      frmConfigCreditBrasil.blnNaoEditar      := True;
      frmConfigCreditBrasil.ShowModal;

      If frmConfigCreditBrasil.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCreditBrasil);
        Exit;
      End;

      intCartei := frmConfigCreditBrasil.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCreditBrasil);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 992 - Credit Brasil';
      frmRetBco.strNomBanco            := '992 - Credit Brasil';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG992-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetGarsonCredito' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigGarsonCredito, frmConfigGarsonCredito);
      frmConfigGarsonCredito.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigGarsonCredito.btnGravar.Caption := '&OK';
      frmConfigGarsonCredito.blnNaoEditar      := True;
      frmConfigGarsonCredito.ShowModal;

      If frmConfigGarsonCredito.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigGarsonCredito);
        Exit;
      End;

      intCartei := frmConfigGarsonCredito.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigGarsonCredito);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 997 - Garson Crédito';
      frmRetBco.strNomBanco            := '997 - Garson Crédito';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG997-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSifra, frmConfigSifra);
      frmConfigSifra.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSifra.btnGravar.Caption := '&OK';
      frmConfigSifra.blnNaoEditar      := True;
      frmConfigSifra.ShowModal;

      If frmConfigSifra.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSifra);
        Exit;
      End;

      intCartei := frmConfigSifra.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSifra);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 998 - Sifra';
      frmRetBco.strNomBanco            := '998 - Sifra';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG998-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetGrupoSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigGrupoSifra, frmConfigGrupoSifra);
      frmConfigGrupoSifra.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigGrupoSifra.btnGravar.Caption := '&OK';
      frmConfigGrupoSifra.blnNaoEditar      := True;
      frmConfigGrupoSifra.ShowModal;

      If frmConfigGrupoSifra.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigGrupoSifra);
        Exit;
      End;

      intCartei := frmConfigGrupoSifra.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigGrupoSifra);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 979 - Sifra';
      frmRetBco.strNomBanco            := '979 - Sifra';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG979-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetUnicred400_136' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigUnicred400_136, frmConfigUnicred400_136);
      frmConfigUnicred400_136.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigUnicred400_136.btnGravar.Caption := '&OK';
      frmConfigUnicred400_136.blnNaoEditar      := True;
      frmConfigUnicred400_136.ShowModal;

      If frmConfigUnicred400_136.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigUnicred400_136);
        Exit;
      End;

      intCartei := frmConfigUnicred400_136.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigUnicred400_136);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 136 - Unicred [400p]';
      frmRetBco.strNomBanco            := '136 - Unicred [400p]';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG136_400p-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End


  Else If arrMenu[intIndex].strNomForm = 'frmArqRetDaycoval400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigDaycoval, frmConfigDaycoval);
      frmConfigDaycoval.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigDaycoval.btnGravar.Caption := '&OK';
      frmConfigDaycoval.blnNaoEditar      := True;
      frmConfigDaycoval.ShowModal;

      If frmConfigDaycoval.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigDaycoval);
        Exit;
      End;

      intCartei := frmConfigDaycoval.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigDaycoval);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 995 - Banco Daycoval';
      frmRetBco.strNomBanco            := '995 - Banco Daycoval';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG995-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End



  {******************************************}
  {*        BANCO DAYCOVAL [400P]           *}
  {*            LAYOUT PRÓPRIO              *}
  {*REQ:147378****************************MT*}
  Else If arrMenu[intIndex].strNomForm = 'frmArqRetDaycoval_707[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigDaycoval_707,frmConfigDaycoval_707);
      frmConfigDaycoval_707.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigDaycoval_707.btnGravar.Caption := '&OK';
      frmConfigDaycoval_707.blnNaoEditar      := True;
      frmConfigDaycoval_707.ShowModal;

      If frmConfigDaycoval_707.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigDaycoval_707);
        Exit;
      End;

      intCartei := frmConfigDaycoval_707.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigDaycoval_707);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 707 - Daycoval[400p]';
      frmRetBco.strNomBanco            := '707 - Daycoval';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fArqIniAutban(0, 'CONFIG707-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetSBCredito_988[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSBCredito,frmConfigSBCredito);
      frmConfigSBCredito.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSBCredito.btnGravar.Caption := '&OK';
      frmConfigSBCredito.blnNaoEditar      := True;
      frmConfigSBCredito.ShowModal;

      If frmConfigSBCredito.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSBCredito);
        Exit;
      End;

      intCartei := frmConfigSBCredito.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSBCredito);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 988 - SB Crédito[400p]';
      frmRetBco.strNomBanco            := '988 - SB Credito';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG988-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  // **********************************
  // *     SB CREDITO BRADESCO        *
  // **********************************
  Else If arrMenu[intIndex].strNomForm = 'frmArqRetSBCredito_Bradesco_987[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSBCredito_Bradesco,frmConfigSBCredito_Bradesco);
      frmConfigSBCredito_Bradesco.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSBCredito_Bradesco.btnGravar.Caption := '&OK';
      frmConfigSBCredito_Bradesco.blnNaoEditar      := True;
      frmConfigSBCredito_Bradesco.ShowModal;

      If frmConfigSBCredito_Bradesco.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSBCredito_Bradesco);
        Exit;
      End;

      intCartei := frmConfigSBCredito_Bradesco.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSBCredito_Bradesco);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 987 - SB Crédito Bradesco[400p]';
      frmRetBco.strNomBanco            := '987 - SB Credito Bradesco';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG987-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetSerrana' Then
    TSerranaMenu.ImportacaoArquivoRetorno

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetRubi' Then
    TRubiMenu.ImportacaoArquivoRetorno

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetUniprime400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigUniprime400,frmConfigUniprime400);
      frmConfigUniprime400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigUniprime400.btnGravar.Caption := '&OK';
      frmConfigUniprime400.blnNaoEditar      := True;
      frmConfigUniprime400.ShowModal;

      If frmConfigUniprime400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigUniprime400);
        Exit;
      End;

      intCartei := frmConfigUniprime400.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigUniprime400);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 099 - Uniprime';
      frmRetBco.strNomBanco            := '099 - Uniprime';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG099-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBcoSisprime' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigSisprime, frmConfigSisprime);
      frmConfigSisprime.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSisprime.btnGravar.Caption := '&OK';
      frmConfigSisprime.blnNaoEditar      := True;
      frmConfigSisprime.ShowModal;

      If frmConfigSisprime.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSisprime);
        Exit;
      End;

      intCartei := frmConfigSisprime.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSisprime);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 084 - Sisprime';
      frmRetBco.strNomBanco            := '084 - Sisprime';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG084-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetLakeBank' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigLakeBank, frmConfigLakeBank);
      frmConfigLakeBank.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigLakeBank.btnGravar.Caption := '&OK';
      frmConfigLakeBank.blnNaoEditar      := True;
      frmConfigLakeBank.ShowModal;

      If frmConfigLakeBank.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigLakeBank);
        Exit;
      End;

      intCartei := frmConfigLakeBank.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigLakeBank);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 977 - Lake Bank';
      frmRetBco.strNomBanco            := '977 - Lake Bank';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG977-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetLotus' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigLotus, frmConfigLotus);
      frmConfigLotus.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigLotus.btnGravar.Caption := '&OK';
      frmConfigLotus.blnNaoEditar      := True;
      frmConfigLotus.ShowModal;

      If frmConfigLotus.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigLotus);
        Exit;
      End;

      intCartei := frmConfigLotus.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigLotus);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 976 - Lotus';
      frmRetBco.strNomBanco            := '976 - Lotus';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG976-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetJPCapital' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigJPCapital, frmConfigJPCapital);
      frmConfigJPCapital.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigJPCapital.btnGravar.Caption := '&OK';
      frmConfigJPCapital.blnNaoEditar      := True;
      frmConfigJPCapital.ShowModal;

      If frmConfigJPCapital.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigJPCapital);
        Exit;
      End;

      intCartei := frmConfigJPCapital.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigJPCapital);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 975 - JP Capital';
      frmRetBco.strNomBanco            := '975 - JP Capital';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG975-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetOlam' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigOlam, frmConfigOlam);
      frmConfigOlam.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigOlam.btnGravar.Caption := '&OK';
      frmConfigOlam.blnNaoEditar      := True;
      frmConfigOlam.ShowModal;

      If frmConfigOlam.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigOlam);
        Exit;
      End;

      intCartei := frmConfigOlam.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigOlam);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 974 - Olam';
      frmRetBco.strNomBanco            := '974 - Olam';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG974-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBelaVista' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigBelaVista, frmConfigBelaVista);
      frmConfigBelaVista.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBelaVista.btnGravar.Caption := '&OK';
      frmConfigBelaVista.blnNaoEditar      := True;
      frmConfigBelaVista.ShowModal;

      If frmConfigBelaVista.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBelaVista);
        Exit;
      End;

      intCartei := frmConfigBelaVista.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBelaVista);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 973 - Bela Vista';
      frmRetBco.strNomBanco            := '973 - Bela Vista';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG973-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetCredisan400' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCredisan400, frmConfigCredisan400);
      frmConfigCredisan400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCredisan400.btnGravar.Caption := '&OK';
      frmConfigCredisan400.blnNaoEditar      := True;
      frmConfigCredisan400.ShowModal;

      If frmConfigCredisan400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCredisan400);
        Exit;
      End;

      intCartei := frmConfigCredisan400.tabCarteira.TabIndex + 1;
    Finally
      FreeAndNil(frmConfigUniprime400);
    End;

    Try
      pCriarFormularios(TfrmRetBco, frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 089 - Credisan';
      frmRetBco.strNomBanco            := '089 - Credisan';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG089-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetCxFed' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCxFederal,frmConfigCxFederal);
      frmConfigCxFederal.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCxFederal.btnGravar.Caption := '&OK';
      frmConfigCxFederal.blnNaoEditar      := true;
      frmConfigCxFederal.ShowModal;

      If frmConfigCxFederal.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCxFederal);
        Exit;
      End;

      intCartei := frmConfigCxFederal.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCxFederal);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 104 - Caixa Federal';
      frmRetBco.strNomBanco      := '104 - Caixa Federal';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG104-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetCxFed7D' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCxFederal7D,frmConfigCxFederal7D);
      frmConfigCxFederal7D.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCxFederal7D.btnGravar.Caption := '&OK';
      frmConfigCxFederal7D.blnNaoEditar      := true;
      frmConfigCxFederal7D.ShowModal;

      If frmConfigCxFederal7D.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCxFederal7D);
        Exit;
      End;

      intCartei := frmConfigCxFederal7D.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCxFederal7D);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 104 - Caixa Federal[7D]';
      frmRetBco.strNomBanco      := '104 - Caixa Federal[7D]';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG1047D-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End


  Else If arrMenu[intIndex].strNomForm = 'frmArqRetCxFed400p' Then
  Begin


    Try
      pCriarFormularios(TfrmConfigCxFederal400p,frmConfigCxFederal400p);
      frmConfigCxFederal400p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCxFederal400p.btnGravar.Caption := '&OK';
      frmConfigCxFederal400p.blnNaoEditar      := true;
      frmConfigCxFederal400p.ShowModal;

      If frmConfigCxFederal400p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCxFederal400p);
        Exit;
      End;

      intCartei := frmConfigCxFederal400p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCxFederal400p);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 104 - Caixa Federal400p';
      frmRetBco.strNomBanco      := '104 - Caixa Federal400p';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG104p400-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBRB400p' Then
  Begin


    Try
      pCriarFormularios(TfrmConfigBRB400p,frmConfigBRB400p);
      frmConfigBRB400p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBRB400p.btnGravar.Caption := '&OK';
      frmConfigBRB400p.blnNaoEditar      := true;
      frmConfigBRB400p.ShowModal;

      If frmConfigBRB400p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBRB400p);
        Exit;
      End;

      intCartei := frmConfigBRB400p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBRB400p);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 070 - BRB 400p';
      frmRetBco.strNomBanco      := '070 - BRB 400p';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG070p400-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetHsbc' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigHsbc,frmConfigHsbc);
      frmConfigHsbc.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigHsbc.btnGravar.Caption := '&OK';
      frmConfigHsbc.blnNaoEditar := true;
      frmConfigHsbc.ShowModal;

      If frmConfigHsbc.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigHsbc);
        Exit;
      End;

      intCartei := frmConfigHsbc.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigHsbc);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 399 - Hsbc';
      frmRetBco.strNomBanco      := '399 - Hsbc';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG399-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetItau' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigItau,frmConfigItau);
      frmConfigItau.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigItau.btnGravar.Caption := '&OK';
      frmConfigItau.blnNaoEditar      := True;
      frmConfigItau.ShowModal;

      If frmConfigItau.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigItau);
        Exit;
      End;

      intCartei := frmConfigItau.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigItau);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 341 - Itau';
      frmRetBco.strNomBanco      := '341 - Itau';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBancoInter' Then
    TBancoInterMenu.ImportacaoBoletosPagos

  Else If arrMenu[intIndex].strNomForm = 'frmCancelarBancoInterApi' Then
    TBancoInterMenu.CancelarBoletosRegistrados

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBancoDoBrasilApi' Then
    TBancoDoBrasilMenu.ImportacaoBoletosPagos

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBancoCredisisApi' Then
    TBancoCredisisMenu.ImportacaoBoletosPagos

  Else If arrMenu[intIndex].strNomForm = 'frmAlterarBancoDoBrasilApi' Then
    TBancoDoBrasilMenu.AlterarBoletosRegistrados

  Else If arrMenu[intIndex].strNomForm = 'frmCancelarBancoDoBrasilApi' Then
    TBancoDoBrasilMenu.CancelarBoletosRegistrados

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBancoSicrediApi' Then
    TBancoSicrediMenu.ImportacaoBoletosPagos

  Else If arrMenu[intIndex].strNomForm = 'frmAlterarBancoSicrediApi' Then
    TBancoSicrediMenu.AlterarBoletosRegistrados

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBancoSafraApi' Then
    TBancoSafraMenu.ImportacaoBoletosPagos

  Else If arrMenu[intIndex].strNomForm = 'frmCancelarBancoSicrediApi' Then
    TBancoSicrediMenu.CancelarBoletosRegistrados

  Else If arrMenu[intIndex].strNomForm = 'frmCancelarItauApi' Then
    TItauMenu.CancelarBoletosRegistrados

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetItauApi' Then
    TItauMenu.ImportacaoBoletosPagos

  Else If arrMenu[intIndex].strNomForm = 'frmCancelarSicoobApi' Then
    TBancoSicoobMenu.CancelarBoletosRegistrados

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetSicoobApi' Then
    TBancoSicoobMenu.ImportacaoBoletosPagos

  Else If arrMenu[intIndex].strNomForm = 'frmCancelarSantanderApi' Then
    TBancoSantanderMenu.CancelarBoletosRegistrados

  Else If arrMenu[intIndex].strNomForm = 'frmCancelarBradescoApi' Then
    TBancoBradescoMenu.CancelarBoletosRegistrados

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetSantanderApi' Then
    TBancoSantanderMenu.ImportacaoBoletosPagos

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBradescoApi' Then
    TBancoBradescoMenu.ImportacaoBoletosPagos

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmArqRetReal' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigReal,frmConfigReal);
      frmConfigReal.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigReal.btnGravar.Caption := '&OK';
      frmConfigReal.blnNaoEditar := true;
      frmConfigReal.ShowModal;

      intCartei := frmConfigReal.tabCarteira.TabIndex + 1;

      If frmConfigReal.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigReal);
        Exit;
      End;

    Finally
      FreeAndNil(frmConfigReal);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 356 - Real';
      frmRetBco.strNomBanco      := '356 - Real';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG356-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.intCartei := intCartei;
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetMerc' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigMercantil,frmConfigMercantil);
      frmConfigMercantil.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigMercantil.btnGravar.Caption := '&OK';
      frmConfigMercantil.blnNaoEditar := true;
      frmConfigMercantil.ShowModal;

      If frmConfigMercantil.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigMercantil);
        Exit;
      End;

      intCartei := frmConfigMercantil.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigMercantil);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 389 - Mercantil';
      frmRetBco.strNomBanco      := '389 - Mercantil';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG389-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;

    Finally
      FreeAndNil(frmRetBco);
    End;

  End

//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmArqRetNossaCx' Then
//  Begin
//
//    Try
//      pCriarFormularios(TfrmConfigNossaCx,frmConfigNossaCx);
//      frmConfigNossaCx.pnlTopo.Caption   := 'Selecione a carteira';
//      frmConfigNossaCx.btnGravar.Caption := '&OK';
//      frmConfigNossaCx.ShowModal;
//
//      If frmConfigNossaCx.ModalResult <> mrOK Then
//      Begin
//        FreeAndNil(frmConfigNossaCx);
//        Exit;
//      End;
//
//      intCartei := frmConfigNossaCx.tabCarteira.TabIndex + 1;
//
//    Finally
//      FreeAndNil(frmConfigNossaCx);
//    End;
//
//    Try
//      pCriarFormularios(TfrmRetBco,frmRetBco);
//      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 151 - N.C.N.B.';
//      frmRetBco.strNomBanco      := '151 - N.C.N.B.';
//      frmRetBco.intCartei  := intCartei;
//      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG151-' + IntToStr(intCartei), 'PATHRET', '');
//      frmRetBco.ShowModal;
//    Finally
//      FreeAndNil(frmRetBco);
//    End;
//
//  End

//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmArqRetRibPreto' Then
//  Begin
//
//    Try
//      pCriarFormularios(TfrmConfigRibPreto,frmConfigRibPreto);
//      frmConfigRibPreto.pnlTopo.Caption   := 'Selecione a carteira';
//      frmConfigRibPreto.btnGravar.Caption := '&OK';
//      frmConfigRibPreto.ShowModal;
//
//      If frmConfigRibPreto.ModalResult <> mrOK Then
//      Begin
//        FreeAndNil(frmConfigRibPreto);
//        Exit;
//      End;
//
//      intCartei := frmConfigRibPreto.tabCarteira.TabIndex + 1;
//
//    Finally
//      FreeAndNil(frmConfigRibPreto);
//    End;
//
//    Try
//      pCriarFormularios(TfrmRetBco,frmRetBco);
//      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 741 - Banco Rib. Preto';
//      frmRetBco.strNomBanco      := '741 - Banco Rib. Preto';
//      frmRetBco.intCartei  := intCartei;
//      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG741-' + IntToStr(intCartei), 'PATHRET', '');
//      frmRetBco.ShowModal;
//    Finally
//      FreeAndNil(frmRetBco);
//    End;
//
//  End

  //*************************************************//
  // ARQUIVO DE RETORNO DO UNIBANCO                  //
  //**********************************************ED*//
//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmArqRetUnibanco' Then
//  Begin
//
//    Try
//      pCriarFormularios(TfrmConfigUnibanco,frmConfigUnibanco);
//      frmConfigUnibanco.pnlTopo.Caption   := 'Selecione a carteira';
//      frmConfigUnibanco.btnGravar.Caption := '&OK';
//      frmConfigUnibanco.ShowModal;
//
//      If frmConfigUnibanco.ModalResult <> mrOK Then
//      Begin
//        FreeAndNil(frmConfigUnibanco);
//        Exit;
//      End;
//
//      intCartei := frmConfigUnibanco.tabCarteira.TabIndex + 1;
//
//    Finally
//      FreeAndNil(frmConfigUnibanco);
//    End;
//
//    Try
//      pCriarFormularios(TfrmRetBco,frmRetBco);
//      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 409 - Unibanco';
//      frmRetBco.strNomBanco      := '409 - Unibanco';
//      frmRetBco.intCartei  := intCartei;
//      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG409-' + IntToStr(intCartei), 'PATHRET', '');
//      frmRetBco.ShowModal;
//    Finally
//      FreeAndNil(frmRetBco);
//    End;
//
//  End


  //*************************************************//
  // ARQUIVO DE RETORNO DO SICREDI                   //
  //**********************************************ED*//
  Else If arrMenu[intIndex].strNomForm = 'frmArqRetSicredi' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSicredi,frmConfigSicredi);
      frmConfigSicredi.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSicredi.btnGravar.Caption := '&OK';
      frmConfigSicredi.blnNaoEditar := true;
      frmConfigSicredi.ShowModal;

      If frmConfigSicredi.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSicredi);
        Exit;
      End;

      intCartei := frmConfigSicredi.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSicredi);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 748 - Sicredi';
      frmRetBco.strNomBanco      := '748 - Sicredi';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG748-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  //*************************************************//
  // ARQUIVO DE RETORNO DO SICREDI 240               //
  //**********************************************ED*//
  Else If arrMenu[intIndex].strNomForm = 'frmArqRetSicredi240' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSicredi240, frmConfigSicredi240);
      frmConfigSicredi240.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSicredi240.btnGravar.Caption := '&OK';
      frmConfigSicredi240.blnNaoEditar := true;
      frmConfigSicredi240.ShowModal;

      If frmConfigSicredi240.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSicredi240);
        Exit;
      End;

      intCartei := frmConfigSicredi240.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSicredi240);
    End;

    Try
      pCriarFormularios(TfrmRetBco, frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 748 - Sicredi [240p]';
      frmRetBco.strNomBanco      := '748 - Sicredi_240p';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG748_240p-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;

    Finally
      FreeAndNil(frmRetBco);
    End;
  End


  //*************************************************//
  // ARQUIVO DE RETORNO DO BANRISUL                  //
  //**********************************************ED*//
  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBanrisul' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBanrisul, frmConfigBanrisul);
      frmConfigBanrisul.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBanrisul.btnGravar.Caption := '&OK';
      frmConfigBanrisul.blnNaoEditar := true;
      frmConfigBanrisul.ShowModal;

      If frmConfigBanrisul.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBanrisul);
        Exit;
      End;

      intCartei := frmConfigBanrisul.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBanrisul);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 041 - Banrisul';
      frmRetBco.strNomBanco      := '041 - Banrisul';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBanrisul240' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBanrisul240, frmConfigBanrisul240);
      frmConfigBanrisul240.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBanrisul240.btnGravar.Caption := '&OK';
      frmConfigBanrisul240.blnNaoEditar := true;
      frmConfigBanrisul240.ShowModal;

      If frmConfigBanrisul240.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBanrisul240);
        Exit;
      End;

      intCartei := frmConfigBanrisul240.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBanrisul240);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 041 - Banrisul [240p]';
      frmRetBco.strNomBanco      := '041 - Banrisul [240p]';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG041_240p-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmArqRetSantander' Then
//  Begin
//
//    Try
//      pCriarFormularios(TfrmConfigSantander,frmConfigSantander);
//      frmConfigSantander.pnlTopo.Caption   := 'Selecione a carteira';
//      frmConfigSantander.btnGravar.Caption := '&OK';
//      frmConfigSantander.ShowModal;
//
//      If frmConfigSantander.ModalResult <> mrOK Then
//      Begin
//        FreeAndNil(frmConfigSantander);
//        Exit;
//      End;
//
//      intCartei := frmConfigSantander.tabCarteira.TabIndex + 1;
//
//    Finally
//      FreeAndNil(frmConfigSantander);
//    End;
//
//    Try
//      pCriarFormularios(TfrmRetBco,frmRetBco);
//      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 353 - Santander';
//      frmRetBco.strNomBanco      := '353 - Santander';
//      frmRetBco.intCartei  := intCartei;
//      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG353-' + IntToStr(intCartei), 'PATHRET', '');
//      frmRetBco.ShowModal;
//    Finally
//      FreeAndNil(frmRetBco);
//    End;
//
//  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmArqRetSantanderBan') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSantanderBan,frmConfigSantanderBan);
      frmConfigSantanderBan.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSantanderBan.btnGravar.Caption := '&OK';
      frmConfigSantanderBan.blnNaoEditar := true;
      frmConfigSantanderBan.ShowModal;

      If frmConfigSantanderBan.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSantanderBan);
        Exit;
      End;

      intCartei := frmConfigSantanderBan.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSantanderBan);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 033 - Santander';
      frmRetBco.strNomBanco      := '033 - Santander';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmArqRetSantander240p') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSantander240p,frmConfigSantander240p);
      frmConfigSantander240p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSantander240p.btnGravar.Caption := '&OK';
      frmConfigSantander240p.blnNaoEditar      := True;
      frmConfigSantander240p.ShowModal;

      If frmConfigSantander240p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSantander240p);
        Exit;
      End;

      intCartei := frmConfigSantander240p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSantander240p);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 033 - Santander[240p]';
      frmRetBco.strNomBanco      := '033 - Santander[240p]';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text  := fGetBancoConfig(0, 'CONFIG033B240p-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmArqRetBanestes') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBanestes,frmConfigBanestes);
      frmConfigBanestes.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBanestes.btnGravar.Caption := '&OK';
      frmConfigBanestes.blnNaoEditar := true;
      frmConfigBanestes.ShowModal;

      If frmConfigBanestes.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBanestes);
        Exit;
      End;

      intCartei := frmConfigBanestes.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBanestes);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 021 - Banestes';
      frmRetBco.strNomBanco      := '021 - Banestes';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG021-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBancoob' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBancoob, frmConfigBancoob);
      frmConfigBancoob.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoob.btnGravar.Caption := '&OK';
      frmConfigBancoob.blnNaoEditar      := True;
      frmConfigBancoob.ShowModal;

      If frmConfigBancoob.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoob);
        Exit;
      End;

      intCartei := frmConfigBancoob.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBancoob);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 756 - Bancoob';
      frmRetBco.strNomBanco      := '756 - Bancoob';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG756-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBancoob240' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBancoob240, frmConfigBancoob240);
      frmConfigBancoob240.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoob240.btnGravar.Caption := '&OK';
      frmConfigBancoob240.blnNaoEditar      := true;
      frmConfigBancoob240.ShowModal;

      If frmConfigBancoob240.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoob240);
        Exit;
      End;

      intCartei := frmConfigBancoob240.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBancoob240);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 756 - Bancoob(240p)';
      frmRetBco.strNomBanco      := '756 - Bancoob_240p';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBradesco240V' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBradesco240Vendor, frmConfigBradesco240Vendor);
      frmConfigBradesco240Vendor.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBradesco240Vendor.btnGravar.Caption := '&OK';
      frmConfigBradesco240Vendor.blnNaoEditar      := true;
      frmConfigBradesco240Vendor.ShowModal;

      If frmConfigBradesco240Vendor.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBradesco240Vendor);
        Exit;
      End;

      intCartei := frmConfigBradesco240Vendor.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBradesco240Vendor);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 237 - Bradesco(240p_Vendor)';
      frmRetBco.strNomBanco      := '237 - Bradesco_240p_Vendor';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG237_VENDOR-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If SameText(arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm,'frmArqRetSafra') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSafra,frmConfigSafra);
      frmConfigSafra.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSafra.btnGravar.Caption := '&OK';
      frmConfigSafra.blnNaoEditar := true;
      frmConfigSafra.ShowModal;

      If frmConfigSafra.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSafra);
        Exit;
      End;

      intCartei := frmConfigSafra.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSafra);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 422 - Safra';
      frmRetBco.strNomBanco      := '422 - Safra';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG422-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  {**************************}
  {* BANCO GERENCIANET 240  *}
  {MF: 284963 - 12/07/23 ****}
  Else If arrMenu[intIndex].strNomForm = 'frmArqRetGerencianet240p' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigGerencianet240p,frmConfigGerencianet240p);
      frmConfigGerencianet240p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigGerencianet240p.btnGravar.Caption := '&OK';
      frmConfigGerencianet240p.strConfig         := 'CONFIG364-';
      frmConfigGerencianet240p.blnNaoEditar := True;
      frmConfigGerencianet240p.ShowModal;

      If frmConfigGerencianet240p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigGerencianet240p);
        EXIT;
      End;

      intCartei := frmConfigGerencianet240p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigGerencianet240p);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 364 - Efí Gerencianet[240p]';
      frmRetBco.strNomBanco      := '364 - Efí Gerencianet[240p]';
      frmRetBco.intCartei        := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG364-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  {**************************}
  {* BANCO CRESOL 240       *}
  {MF: 287323 - 12/07/23 ****}
  Else If arrMenu[intIndex].strNomForm = 'frmArqRetCresol240p' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCresol240p,frmConfigCresol240p);
      frmConfigCresol240p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCresol240p.btnGravar.Caption := '&OK';
      frmConfigCresol240p.strConfig         := 'CONFIG133-';
      frmConfigCresol240p.blnNaoEditar := True;
      frmConfigCresol240p.ShowModal;

      If frmConfigCresol240p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCresol240p);
        Exit;
      End;

      intCartei := frmConfigCresol240p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCresol240p);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 133 - Cresol[240p]';
      frmRetBco.strNomBanco      := '133 - Cresol[240p]';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG133-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBancoAmazonia' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBancoAmazonia,frmConfigBancoAmazonia);
      frmConfigBancoAmazonia.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoAmazonia.btnGravar.Caption := '&OK';
      frmConfigBancoAmazonia.blnNaoEditar := true;
      frmConfigBancoAmazonia.ShowModal;

      If frmConfigBancoAmazonia.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoAmazonia);
        Exit;
      End;

      intCartei := frmConfigBancoAmazonia.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBancoAmazonia);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 003 - Amazônia';
      frmRetBco.strNomBanco      := '003 - Banco da Amazonia';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG003-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetNordeste' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigNordeste400,frmConfigNordeste400);
      frmConfigNordeste400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigNordeste400.btnGravar.Caption := '&OK';
      frmConfigNordeste400.blnNaoEditar      := True;
      frmConfigNordeste400.ShowModal;

      If frmConfigNordeste400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigNordeste400);
        Exit;
      End;

      intCartei := frmConfigNordeste400.tabCarteira.TabIndex + 1;
    Finally
      FreeAndNil(frmConfigNordeste400);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 004 - B. do Nordeste';
      frmRetBco.strNomBanco      := '004 - B. do Nordeste';
      frmRetBco.intCartei        := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG004-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBancoRendimento' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigRendimento, frmConfigRendimento);
      frmConfigRendimento.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigRendimento.btnGravar.Caption := '&OK';
      frmConfigRendimento.blnNaoEditar := true;
      frmConfigRendimento.ShowModal;

      If frmConfigRendimento.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigRendimento);
        Exit;
      End;

      intCartei := frmConfigRendimento.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigRendimento);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 633 - Rendimento';
      frmRetBco.strNomBanco      := '633 - Banco Rendimento';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG633-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  {***********************************}
  {* BAIXA AUTOMATICA DE DUPLICATAS  *}
  {***********************************}
  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupIEPTBSP' Then
  Begin
    intCartei := 0;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('341',intCartei);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetCecred' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCecred,frmConfigCecred);
      frmConfigCecred.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCecred.btnGravar.Caption := '&OK';
      frmConfigCecred.blnNaoEditar := true;
      frmConfigCecred.ShowModal;

      If frmConfigCecred.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCecred);
        Exit;
      End;

      intCartei := frmConfigCecred.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCecred);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 085 - Cecred';
      frmRetBco.strNomBanco      := '085 - Cecred';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG085-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetUnicred' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigUnicred,frmConfigUnicred);
      frmConfigUnicred.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigUnicred.btnGravar.Caption := '&OK';
      frmConfigUnicred.blnNaoEditar := true;
      frmConfigUnicred.ShowModal;

      If frmConfigUnicred.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigUnicred);
        Exit;
      End;

      intCartei := frmConfigUnicred.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigUnicred);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 090 - Unicred';
      frmRetBco.strNomBanco      := '090 - Unicred';
      frmRetBco.intCartei  := intCartei;
      Try
        frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG090-' + IntToStr(intCartei), 'PATHRET', '');
      Except
        fMensagem('','Não foi possível localizar o Path de Retorno informado. Favor Verificar!',['&O K']);
      End;
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetUnicred400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigUnicred400,frmConfigUnicred400);
      frmConfigUnicred400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigUnicred400.btnGravar.Caption := '&OK';
      frmConfigUnicred400.blnNaoEditar := true;
      frmConfigUnicred400.ShowModal;

      If frmConfigUnicred400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigUnicred400);
        Exit;
      End;

      intCartei := frmConfigUnicred400.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigUnicred400);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 090 - Unicred (400p)';
      frmRetBco.strNomBanco      := '090 - Unicred_400p';
      frmRetBco.intCartei  := intCartei;
      Try
        frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG090_400p-' + IntToStr(intCartei), 'PATHRET', '');
      Except
        fMensagem('','Não foi possível localizar o Path de Retorno informado. Favor Verificar!',['&O K']);
      End;
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End
  {***********************************}
  {* BANCO ABC BRASIL                *}
  {*REQ.34692 29/05/2015***********JU*}
  Else If arrMenu[intIndex].strNomForm = 'frmArqRetABCBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigABCBrasil,frmConfigABCBrasil);
      frmConfigABCBrasil.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigABCBrasil.btnGravar.Caption := '&OK';
      frmConfigABCBrasil.blnNaoEditar := true;
      frmConfigABCBrasil.ShowModal;

      If frmConfigABCBrasil.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigABCBrasil);
        Exit;
      End;

      intCartei := frmConfigABCBrasil.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigABCBrasil);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 246 - ABC Brasil';
      frmRetBco.strNomBanco      := '246 - ABC Brasil';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG246-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetSofisa' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSofisa,frmConfigSofisa);
      frmConfigSofisa.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSofisa.btnGravar.Caption := '&OK';
      frmConfigSofisa.blnNaoEditar := true;
      frmConfigSofisa.ShowModal;

      If frmConfigSofisa.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSofisa);
        Exit;
      End;

      intCartei := frmConfigSofisa.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSofisa);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 637 - Sofisa';
      frmRetBco.strNomBanco      := '637 - Sofisa';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIG637-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetSofisa_444' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSofisa_444,frmConfigSofisa_444);
      frmConfigSofisa_444.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSofisa_444.btnGravar.Caption := '&OK';
      frmConfigSofisa_444.blnNaoEditar := true;
      frmConfigSofisa_444.ShowModal;

      If frmConfigSofisa_444.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSofisa_444);
        Exit;
      End;

      intCartei := frmConfigSofisa_444.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSofisa_444);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 637 - Sofisa[444p]';
      frmRetBco.strNomBanco      := '637 - Sofisa[444p]';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG637_444p-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBtgPactual_240p' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBtgPactual_240p,frmConfigBtgPactual_240p);
      frmConfigBtgPactual_240p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBtgPactual_240p.btnGravar.Caption := '&OK';
      frmConfigBtgPactual_240p.blnNaoEditar := True;
      frmConfigBtgPactual_240p.ShowModal;

      If frmConfigBtgPactual_240p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBtgPactual_240p);
        EXIT;
      End;

      intCartei := frmConfigBtgPactual_240p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBtgPactual_240p);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 208 - Btg Pactual[240p]';
      frmRetBco.strNomBanco      := '208 - Btg Pactual[240p]';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG208-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End


//**NOVOBANCO**
  {***********************************}
  {* RELATORIO DE ARQUIVO DE RETORNO *}
  {********************************LB*}
  {***********************************}
  {* BANCO DO BRASIL DE 6 DIGITOS    *}
  {********************************LB*}
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 001 - Brasil';
      frmRelRetBco.strNomBanco      := '001 - Banco do Brasil';
      frmRelRetBco.ATipoCnab        := '6D';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  {***********************************}
  {* BANCO DO BRASIL DE 7 DIGITOS    *}
  {********************************LB*}
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBrasil7d' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 001 - Brasil7d';
      frmRelRetBco.strNomBanco      := '001 - Banco do Brasil7d';
      frmRelRetBco.ATipoCnab        := '7D';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBanespa' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 033 - Banespa';
      frmRelRetBco.strNomBanco      := '033 - Banespa';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetItau' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 341 - Itau ';
      frmRelRetBco.strNomBanco      := '341 - Itau ';
      frmRelRetBco.ATipoCnab        := '400';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelRetBancoInter' Then
    TBancoInterMenu.ImprimirBoletosImportados

  Else If arrMenu[intIndex].strNomForm = 'frmRelRetBancoDoBrasilApi' Then
    TBancoDoBrasilMenu.ImprimirBoletosImportados

  Else If arrMenu[intIndex].strNomForm = 'frmRelRetBancoCredisisApi' Then
    TBancoCredisisMenu.ImprimirBoletosImportados

  Else If arrMenu[intIndex].strNomForm = 'frmRelRetBancoSicrediApi' Then
    TBancoSicrediMenu.ImprimirBoletosImportados

  Else If arrMenu[intIndex].strNomForm = 'frmRelRetItauApi' Then
    TItauMenu.ImprimirBoletosImportados

  Else If arrMenu[intIndex].strNomForm = 'frmRelRetSicoobApi' Then
    TBancoSicoobMenu.ImprimirBoletosImportados

  Else If arrMenu[intIndex].strNomForm = 'frmRelRetBancoSafraApi' Then
    TBancoSafraMenu.ImprimirBoletosImportados

  Else If arrMenu[intIndex].strNomForm = 'frmRelRetSantanderApi' Then
    TBancoSantanderMenu.ImprimirBoletosImportados

  Else If arrMenu[intIndex].strNomForm = 'frmRelRetBradescoApi' Then
    TBancoBradescoMenu.ImprimirBoletosImportados

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBradesco' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 237 - Bradesco';
      frmRelRetBco.strNomBanco      := '237 - Bradesco';
      frmRelRetBco.ATipoCnab        := '400';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetFomentoMercantil400' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco, frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 994 - Na Fomento Mercantil';
      frmRelRetBco.strNomBanco      := '994 - Na Fomento Mercantil';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBMPMoneyPlus' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 274 - BMPMoneyPlus';
      frmRelRetBco.strNomBanco      := '274 - BMPMoneyPlus';
      frmRelRetBco.ATipoCnab        := '400';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBmpMoneyPlus_LP_400' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 274 - BMP Money Plus LP [400p]';
      frmRelRetBco.strNomBanco      := '274 - BMP Money Plus LP [400p]';
      frmRelRetBco.ATipoCnab        := '400';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetAthenaAtlanta400' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco, frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 996 - Athena Atlanta';
      frmRelRetBco.strNomBanco      := '996 - Athena Atlanta';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetMultibank' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 983 - Banco Multibank';
      frmRelRetBco.strNomBanco      := '983 - Banco Multibank';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBancoJpiFidc' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 906 - Banco FIDC';
      frmRelRetBco.strNomBanco      := '906 - Banco FIDC';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBancoCapitalFinancas' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 978 - Capital Finanças';
      frmRelRetBco.strNomBanco      := '978 - Capital Finanças';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBancoSrm' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 990 - Banco SRM';
      frmRelRetBco.strNomBanco      := '990 - Banco SRM';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBancoFidussia' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 970 - Banco Fidussia';
      frmRelRetBco.strNomBanco      := '970 - Banco Fidussia';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBancoMultiplike' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 981 - Banco Multiplike';
      frmRelRetBco.strNomBanco      := '981 - Banco Multiplike';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetRedasset' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco, frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 993 - Redasset';
      frmRelRetBco.strNomBanco      := '993 - Redasset';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetCreditBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco, frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 992 - Credit Brasil';
      frmRelRetBco.strNomBanco      := '992 - Credit Brasil';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetGarsonCredito' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco, frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 997 - Garson Crédito';
      frmRelRetBco.strNomBanco      := '997 - Garson Crédito';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco, frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 998 - Sifra';
      frmRelRetBco.strNomBanco      := '998 - Sifra';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetGrupoSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco, frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 979 - Sifra';
      frmRelRetBco.strNomBanco      := '979 - Sifra';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetUnicred400_136' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco, frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 136 - Unicred [400p]';
      frmRelRetBco.strNomBanco      := '136 - Unicred [400p]';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End


  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetDaycoval400' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco, frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 995 - Daycoval';
      frmRelRetBco.strNomBanco      := '995 - Banco Daycoval';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End


 {******************************************}
 {*        BANCO DAYCOVAL [400P]           *}
 {*            LAYOUT PRÓPRIO              *}
 {*REQ:147378****************************MT*}

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetDaycoval_707[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 707 - Daycoval[400p]';
      frmRelRetBco.strNomBanco      := '707 - Daycoval[400p]';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  {******************************************}
  {*        BANCO DAYCOVAL [400P]           *}
  {*            LAYOUT PRÓPRIO              *}
  {*REQ:147378****************************MT*}
  Else If arrMenu[intIndex].strNomForm = 'frmArqRetDaycoval_707[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigDaycoval_707,frmConfigDaycoval_707);
      frmConfigDaycoval_707.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigDaycoval_707.btnGravar.Caption := '&OK';
      frmConfigDaycoval_707.blnNaoEditar      := True;
      frmConfigDaycoval_707.ShowModal;

      If frmConfigDaycoval_707.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigDaycoval_707);
        Exit;
      End;

      intCartei := frmConfigDaycoval_707.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigDaycoval_707);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 707 - Daycoval[400p]';
      frmRetBco.strNomBanco            := '707 - Daycoval';
      frmRetBco.intCartei              := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fArqIniAutban(0, 'CONFIG707-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetSBCredito_988[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 988 - SB Credito[400p]';
      frmRelRetBco.strNomBanco      := '988 - SB Credito[400p]';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  // **********************************
  // *     SB CREDITO BRADESCO        *
  // **********************************
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetSBCredito_Bradesco_987[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 987 - SB Credito Bradesco[400p]';
      frmRelRetBco.strNomBanco      := '987 - SB Credito Bradesco[400p]';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupSBCredito_988[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSBCredito,frmConfigSBCredito);
      frmConfigSBCredito.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSBCredito.btnGravar.Caption := '&OK';
      frmConfigSBCredito.blnNaoEditar      := True;
      frmConfigSBCredito.ShowModal;

      If frmConfigSBCredito.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSBCredito);
        Exit;
      End;

      intCartei := frmConfigSBCredito.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSBCredito);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao'],2) = 1 Then
    Begin
      pBaixaAtuDup('988',intCartei);
    End;

  End

  // **********************************
  // *     SB CREDITO BRADESCO        *
  // **********************************
  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupSBCredito_Bradesco_987[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSBCredito_Bradesco,frmConfigSBCredito_Bradesco);
      frmConfigSBCredito_Bradesco.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSBCredito_Bradesco.btnGravar.Caption := '&OK';
      frmConfigSBCredito_Bradesco.blnNaoEditar      := True;
      frmConfigSBCredito_Bradesco.ShowModal;

      If frmConfigSBCredito_Bradesco.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSBCredito_Bradesco);
        Exit;
      End;

      intCartei := frmConfigSBCredito_Bradesco.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSBCredito);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao'],2) = 1 Then
    Begin
      pBaixaAtuDup('987',intCartei);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetSerrana' Then
    TSerranaMenu.RelatorioDuplicatasImportadas

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetRubi' Then
    TRubiMenu.RelatorioDuplicatasImportadas

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetUniprime400' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 099 - Uniprime';
      frmRelRetBco.strNomBanco      := '099 - Uniprime';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBcoSisprime' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 084 - Sisprime';
      frmRelRetBco.strNomBanco      := '084 - Sisprime';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetLakeBank' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 977 - Lake Bank';
      frmRelRetBco.strNomBanco      := '977 - Lake Bank';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetLotus' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 976 - Lotus';
      frmRelRetBco.strNomBanco      := '976 - Lotus';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetJPCapital' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 975 - JP Capital';
      frmRelRetBco.strNomBanco      := '975 - JP Capital';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetOlam' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 974 - Olam';
      frmRelRetBco.strNomBanco      := '974 - Olam';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBelaVista' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 973 - Bela Vista';
      frmRelRetBco.strNomBanco      := '973 - Bela Vista';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetCredisan400' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco, frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 089 - Credisan';
      frmRelRetBco.strNomBanco      := '089 - Credisan';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetMerc' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 389 - Mercantil';
      frmRelRetBco.strNomBanco      := '389 - Mercantil';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetHsbc' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 399 - HSBC';
      frmRelRetBco.strNomBanco      := '399 - HSBC';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetNossaCx' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 151 - N.C.N.B.';
      frmRelRetBco.strNomBanco      := '151 - N.C.N.B.';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetCxFed' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 104 - C.E.F.';
      frmRelRetBco.strNomBanco      := '104 - C.E.F.';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetCxFed7D' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 104 - C.E.F. [7D]';
      frmRelRetBco.strNomBanco      := '104 - C.E.F. [7D]';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End


  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetCxFed400p' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 104 - C.E.F. 400p';
      frmRelRetBco.strNomBanco      := '104 - C.E.F. 400p';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBRB400p' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 070 - BRB 400p';
      frmRelRetBco.strNomBanco      := '070 - BRB 400p';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetRibPreto' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 741 - Banco Rib Preto';
      frmRelRetBco.strNomBanco      := '741 - Banco Rib Preto';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetReal' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 356 - Banco Real';
      frmRelRetBco.strNomBanco      := '356 - Banco Real';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End


  //*************************************************//
  // RELATORIO DO ARQUIVO DE RETORNO DO UNIBANCO     //
  //**********************************************ED*//
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetUnibanco' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 409 - Unibanco';
      frmRelRetBco.strNomBanco      := '409 - Unibanco';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End



  //*************************************************//
  // RELATORIO DO ARQUIVO DE RETORNO DO SICREDI      //
  //**********************************************ED*//
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetSicredi' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 748 - Sicredi';
      frmRelRetBco.strNomBanco      := '748 - Sicredi';
      frmRelRetBco.ATipoCnab        := '400';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  //*************************************************//
  // RELATORIO DO ARQUIVO DE RETORNO DO SICREDI 240  //
  //**********************************************ED*//
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetSicredi240' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco, frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 748 - Sicredi [240p]';
      frmRelRetBco.strNomBanco      := '748 - Sicredi [240p]';
      frmRelRetBco.ATipoCnab        := '240';
      frmRelRetBco.ShowModal;

    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End


  //*************************************************//
  // RELATORIO DO ARQUIVO DE RETORNO DO BANRISUL     //
  //**********************************************ED*//
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBanrisul' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 041 - Banrisul';
      frmRelRetBco.strNomBanco      := '041 - Banrisul';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBanrisul240' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 041 - Banrisul [240p]';
      frmRelRetBco.strNomBanco      := '041 - Banrisul [240p]';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetSantander' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 353 - Santander';
      frmRelRetBco.strNomBanco      := '353 - Santander';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmRelArqRetSantanderBan') Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 033 - Santander';
      frmRelRetBco.strNomBanco      := '033 - Santander';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmRelArqRetSantander240p') Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 033 - Santander[240p]';
      frmRelRetBco.strNomBanco      := '033 - Santander[240p]';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End


  Else If SameText(arrMenu[intIndex].strNomForm,'frmRelArqRetBanestes') Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 021 - Banestes';
      frmRelRetBco.strNomBanco      := '021 - Banestes';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBancoob' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 756 - Bancoob';
      frmRelRetBco.strNomBanco      := '756 - Bancoob';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBancoob240' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 756 - Bancoob';
      frmRelRetBco.strNomBanco      := '756 - Bancoob_240p';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBradesco240V' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 237 - Bradesco';
      frmRelRetBco.strNomBanco      := '237 - Bradesco_240p_Vendor';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End


  Else If SameText(arrMenu[intIndex].strNomForm,'frmRelArqRetSafra') Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 422 - Safra';
      frmRelRetBco.strNomBanco      := '422 - Safra';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetSofisa' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 637 - Sofisa';
      frmRelRetBco.strNomBanco      := '637 - Sofisa';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetSofisa_444' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 637 - Sofisa [444p]';
      frmRelRetBco.strNomBanco      := '637 - Sofisa [444p]';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBtgPactual_240p' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 208 - Btg Pactual [240p]';
      frmRelRetBco.strNomBanco      := '208 - Btg Pactual [240p]';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetNordeste' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 004 - B. do Nordeste';
      frmRelRetBco.strNomBanco      := '004 - B. do Nordeste';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End

  {**************************}
  {* BANCO GERENCIANET 240  *}
  {MF: 284963 - 12/07/23 ****}
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetGerencianet240p' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 364 - Efí Gerencianet [240p]';
      frmRelRetBco.strNomBanco      := '364 - Efí Gerencianet [240p]';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  {**************************}
  {* BANCO CRESOL 240       *}
  {MF: 287323 - 14/07/23 ****}
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetCresol240p' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 133 - Cresol [240p]';
      frmRelRetBco.strNomBanco      := '133 - Cresol [240p]';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetSparti' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - Sparti';
      frmRelRetBco.strNomBanco      := '982 - Sparti';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetLecca' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - Lecca';
      frmRelRetBco.strNomBanco      := '984 - Lecca';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBancoAmazonia' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 003 - Amazônia';
      frmRelRetBco.strNomBanco      := '003 - Banco da Amazonia';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBancoRendimento' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 633 - Rendimento';
      frmRelRetBco.strNomBanco      := '633 - Banco Rendimento';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmBaiAutDupNordeste') Then
  Begin
    Try
      pCriarFormularios(TfrmConfigNordeste400,frmConfigNordeste400);
      frmConfigNordeste400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigNordeste400.btnGravar.Caption := '&OK';
      frmConfigNordeste400.blnNaoEditar      := True;
      frmConfigNordeste400.ShowModal;

      If frmConfigNordeste400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigNordeste400);
        Exit;
      End;

      If Trim(frmConfigNordeste400.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigNordeste400.edtDiasCred.Text);

      intCartei := frmConfigNordeste400.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigNordeste400);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('004',intCartei);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetCecred' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 085 - Cecred';
      frmRelRetBco.strNomBanco      := '085 - Cecred';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetUnicred' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 090 - Unicred';
      frmRelRetBco.strNomBanco      := '090 - Unicred';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetUnicred400' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 090 - Unicred (400p)';
      frmRelRetBco.strNomBanco      := '090 - Unicred (400p)';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End
  {***********************************}
  {* BANCO ABC BRASIL                *}
  {*REQ.34692 29/05/2015***********JU*}
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetABCBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 246 - ABC Brasil';
      frmRelRetBco.strNomBanco      := '246 - ABC Brasil';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

  {****************}
  {*    IEPTBSP   *}
  {*REQ-65923-***MO}
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetIEPTBSP' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno IEPTB-SP - Central de Protesto';
      frmRelRetBco.strNomBanco      := '341';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;

  End

//**NOVOBANCO**
  {***********************************}
  {* BAIXA AUTOMATICA DE DUPLICATAS  *}
  {********************************LB*}
  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupItau' Then
  Begin
    pIniciarBaixa('341');

    {Try
      pCriarFormularios(TfrmConfigItau,frmConfigItau);
      frmConfigItau.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigItau.btnGravar.Caption := '&OK';
      frmConfigItau.blnNaoEditar      := True;
      frmConfigItau.ShowModal;

      If frmConfigItau.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigItau);
        Exit;
      End;

      If Trim(frmConfigItau.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigItau.edtDiasCred.Text);

      intCartei := frmConfigItau.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigItau);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('341',intCartei);
    End; }

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBancoInter' Then
  Begin
    intCartei := TBancoInterMenu.CarteiraParaBaixa;

    If intCartei = 0 Then
      Exit;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
      pBaixaAtuDup('077',intCartei);
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBancoDoBrasilApi' Then
  Begin
    intCartei := TBancoDoBrasilMenu.CarteiraParaBaixa;

    If intCartei = 0 Then
      Exit;
    FDiasParaCreditoOcorrencia12 := fGetDiasParaCreditoOcorrencia12('001API', intCartei);

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
      pBaixaAtuDup('001API',intCartei);
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBancoCredisisApi' Then
  Begin
    intCartei := TBancoCredisisMenu.CarteiraParaBaixa;

    If intCartei = 0 Then
      Exit;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
      pBaixaAtuDup('097API',intCartei);
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBancoSicrediApi' Then
  Begin
    intCartei := TBancoSicrediMenu.CarteiraParaBaixa;

    If intCartei = 0 Then
      Exit;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
      pBaixaAtuDup('748API',intCartei);
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupItauApi' Then
  Begin
    intCartei := TItauMenu.CarteiraParaBaixa;

    If intCartei = 0 Then
      Exit;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
      pBaixaAtuDup('341API',intCartei);
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupSicoobApi' Then
  Begin
    intCartei := TBancoSicoobMenu.CarteiraParaBaixa;

    If intCartei = 0 Then
      Exit;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
      pBaixaAtuDup('756API',intCartei);
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBancoSafraApi' Then
  Begin
    intCartei := TBancoSafraMenu.CarteiraParaBaixa;

    If intCartei = 0 Then
      Exit;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
      pBaixaAtuDup('422API',intCartei);
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupSantanderApi' Then
  Begin
    intDiaCred := 0;

    intCartei := TBancoSantanderMenu.CarteiraParaBaixa;

    If intCartei = 0 Then
      Exit;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
      pBaixaAtuDup('033API',intCartei);
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBradescoApi' Then
  Begin
    intDiaCred := 0;

    intCartei := TBancoBradescoMenu.CarteiraParaBaixa;

    If intCartei = 0 Then
      Exit;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
      pBaixaAtuDup('237API',intCartei);
  End

  {********************************************}
  {* BAIXA AUTOMATICA DE DUPLICATAS 6 DIGITOS *}
  {*****************************************LB*}
  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBrasil,frmConfigBrasil);
      frmConfigBrasil.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBrasil.btnGravar.Caption := '&OK';
      frmConfigBrasil.blnNaoEditar      := True;
      frmConfigBrasil.ShowModal;

      If frmConfigBrasil.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBrasil);
        Exit;
      End;

      If Trim(frmConfigBrasil.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigBrasil.edtDiasCred.Text);

      intCartei := frmConfigBrasil.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBrasil);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      blnBcoBra7d := False;
      pBaixaAtuDup('001',intCartei);
    End;

  End

  {********************************************}
  {* BAIXA AUTOMATICA DE DUPLICATAS 7 DIGITOS *}
  {*****************************************LB*}
  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBrasil7d' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBrasil7d,frmConfigBrasil7d);
      frmConfigBrasil7d.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBrasil7d.btnGravar.Caption := '&OK';
      frmConfigBrasil7d.blnPeFin := False;
      frmConfigBrasil7d.blnNaoEditar := True;
      frmConfigBrasil7d.ShowModal;

      If frmConfigBrasil7d.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBrasil7d);
        Exit;
      End;

      If Trim(frmConfigBrasil7d.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigBrasil7d.edtDiasCred.Text);

      intCartei := frmConfigBrasil7d.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBrasil7d);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      blnBcoBra7d := True;
      pBaixaAtuDup('001',intCartei);
    End;

  End

  {***********************************}
  {* BAIXA AUTOMATICA DE DUPLICATAS  *}
  {********************************LB*}
  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBradesco' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBradesco,frmConfigBradesco);
      frmConfigBradesco.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBradesco.btnGravar.Caption := '&OK';
      frmConfigBradesco.blnNaoEditar      := True;
      frmConfigBradesco.ShowModal;

      If frmConfigBradesco.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBradesco);
        Exit;
      End;

      If Trim(frmConfigBradesco.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigBradesco.edtDiasCred.Text);

      intCartei := frmConfigBradesco.tabCarteira.TabIndex + 1;
      strCarBco := frmConfigBradesco.edtCodCar.Text;

    Finally
      FreeAndNil(frmConfigBradesco);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      Try
        pBaixaAtuDup('237',intCartei,strCarBco);
      Except
        On E: Exception Do
        Begin
          fLiberaLockBaixaAutomatica('237');
        End
      End;
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupFomentoMercantil400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigFomentoMercantil400, frmConfigFomentoMercantil400);
      frmConfigFomentoMercantil400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigFomentoMercantil400.btnGravar.Caption := '&OK';
      frmConfigFomentoMercantil400.blnNaoEditar      := True;
      frmConfigFomentoMercantil400.ShowModal;

      If frmConfigFomentoMercantil400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigFomentoMercantil400);
        Exit;
      End;

      If Trim(frmConfigFomentoMercantil400.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigFomentoMercantil400.edtDiasCred.Text);

      intCartei := frmConfigFomentoMercantil400.tabCarteira.TabIndex + 1;
    Finally
      FreeAndNil(frmConfigFomentoMercantil400);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('994',intCartei,strCarBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBMPMoneyPlus' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBMPMoneyPlus, frmConfigBMPMoneyPlus);
      frmConfigBMPMoneyPlus.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBMPMoneyPlus.btnGravar.Caption := '&OK';
      frmConfigBMPMoneyPlus.blnNaoEditar      := True;
      frmConfigBMPMoneyPlus.ShowModal;

      If frmConfigBMPMoneyPlus.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBMPMoneyPlus);
        Exit;
      End;

      If Trim(frmConfigBMPMoneyPlus.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigBMPMoneyPlus.edtDiasCred.Text);

      intCartei := frmConfigBMPMoneyPlus.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBMPMoneyPlus);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao'],2) = 1 Then
    Begin
      pBaixaAtuDup('274',intCartei);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBmpMoneyPlus_LP_400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBMPMoneyPlus_LP_400, frmConfigBMPMoneyPlus_LP_400);
      frmConfigBMPMoneyPlus_LP_400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBMPMoneyPlus_LP_400.btnGravar.Caption := '&OK';
      frmConfigBMPMoneyPlus_LP_400.blnNaoEditar      := True;
      frmConfigBMPMoneyPlus_LP_400.ShowModal;

      If frmConfigBMPMoneyPlus_LP_400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBMPMoneyPlus_LP_400);
        Exit;
      End;

      If Trim(frmConfigBMPMoneyPlus_LP_400.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigBMPMoneyPlus_LP_400.edtDiasCred.Text);

      intCartei := frmConfigBMPMoneyPlus_LP_400.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBMPMoneyPlus_LP_400);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao'],2) = 1 Then
    Begin
      pBaixaAtuDup('274LP400p',intCartei);
    End;

  End


  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupAthenaAtlanta400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigAthenaAtlanta, frmConfigAthenaAtlanta);
      frmConfigAthenaAtlanta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigAthenaAtlanta.btnGravar.Caption := '&OK';
      frmConfigAthenaAtlanta.strConfig         := 'CONFIG996-';
      frmConfigAthenaAtlanta.blnNaoEditar      := True;
      frmConfigAthenaAtlanta.ShowModal;

      If frmConfigAthenaAtlanta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigAthenaAtlanta);
        Exit;
      End;

      If Trim(frmConfigAthenaAtlanta.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigAthenaAtlanta.edtDiasCred.Text);

      intCartei := frmConfigAthenaAtlanta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigAthenaAtlanta);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao'],2) = 1 Then
    Begin
      pBaixaAtuDup('996',intCartei,strCarBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupMultibank' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigMultibank, frmConfigMultibank);
      frmConfigMultibank.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigMultibank.btnGravar.Caption := '&OK';
      frmConfigMultibank.strConfig         := 'CONFIG983-';
      frmConfigMultibank.blnNaoEditar      := True;
      frmConfigMultibank.ShowModal;

      If frmConfigMultibank.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigMultibank);
        Exit;
      End;

      If Trim(frmConfigMultibank.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigMultibank.edtDiasCred.Text);

      intCartei := frmConfigMultibank.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigMultibank);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao'],2) = 1 Then
    Begin
      pBaixaAtuDup('983',intCartei,strCarBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBancoJpiFidc' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigJpiFidc, frmConfigJpiFidc);
      frmConfigJpiFidc.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigJpiFidc.btnGravar.Caption := '&OK';
      frmConfigJpiFidc.strConfig         := 'CONFIG906-';
      frmConfigJpiFidc.blnNaoEditar      := True;
      frmConfigJpiFidc.ShowModal;

      If frmConfigJpiFidc.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigJpiFidc);
        Exit;
      End;

      If Trim(frmConfigJpiFidc.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigJpiFidc.edtDiasCred.Text);

      intCartei := frmConfigJpiFidc.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigJpiFidc);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao'],2) = 1 Then
    Begin
      pBaixaAtuDup('906',intCartei,strCarBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBancoCapitalFinancas' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCapitalFinancas, frmConfigCapitalFinancas);
      frmConfigCapitalFinancas.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCapitalFinancas.btnGravar.Caption := '&OK';
      frmConfigCapitalFinancas.strConfig         := 'CONFIG978-';
      frmConfigCapitalFinancas.blnNaoEditar      := True;
      frmConfigCapitalFinancas.ShowModal;

      If frmConfigCapitalFinancas.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCapitalFinancas);
        Exit;
      End;

      If Trim(frmConfigCapitalFinancas.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigCapitalFinancas.edtDiasCred.Text);

      intCartei := frmConfigCapitalFinancas.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCapitalFinancas);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao'],2) = 1 Then
    Begin
      pBaixaAtuDup('978',intCartei,strCarBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBancoSrm' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSRM, frmConfigSRM);
      frmConfigSRM.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSRM.btnGravar.Caption := '&OK';
      frmConfigSRM.strConfig         := 'CONFIG990-';
      frmConfigSRM.blnNaoEditar      := True;
      frmConfigSRM.ShowModal;

      If frmConfigSRM.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSRM);
        Exit;
      End;

      If Trim(frmConfigSRM.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigSRM.edtDiasCred.Text);

      intCartei := frmConfigSRM.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSRM);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao'],2) = 1 Then
    Begin
      pBaixaAtuDup('990',intCartei,strCarBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBancoFidussia' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigFidussia, frmConfigFidussia);
      frmConfigFidussia.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigFidussia.btnGravar.Caption := '&OK';
      frmConfigFidussia.strConfig         := 'CONFIG970-';
      frmConfigFidussia.blnNaoEditar      := True;
      frmConfigFidussia.ShowModal;

      If frmConfigFidussia.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigFidussia);
        Exit;
      End;

      If Trim(frmConfigFidussia.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigFidussia.edtDiasCred.Text);

      intCartei := frmConfigFidussia.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigFidussia);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao'],2) = 1 Then
    Begin
      pBaixaAtuDup('970', intCartei, strCarBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBancoMultiplike' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigMultiplike, frmConfigMultiplike);
      frmConfigMultiplike.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigMultiplike.btnGravar.Caption := '&OK';
      frmConfigMultiplike.strConfig         := 'CONFIG981-';
      frmConfigMultiplike.blnNaoEditar      := True;
      frmConfigMultiplike.ShowModal;

      If frmConfigMultiplike.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigMultiplike);
        Exit;
      End;

      If Trim(frmConfigMultiplike.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigMultiplike.edtDiasCred.Text);

      intCartei := frmConfigMultiplike.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigMultiplike);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao'],2) = 1 Then
    Begin
      pBaixaAtuDup('981', intCartei, strCarBco);
    End;
  End


  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupRedasset' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigRedasset, frmConfigRedasset);
      frmConfigRedasset.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigRedasset.btnGravar.Caption := '&OK';
      frmConfigRedasset.blnNaoEditar      := True;
      frmConfigRedasset.ShowModal;

      If frmConfigRedasset.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigRedasset);
        Exit;
      End;

      If Trim(frmConfigRedasset.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigRedasset.edtDiasCred.Text);

      intCartei := frmConfigRedasset.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigRedasset);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('993',intCartei,strCarBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupCreditBrasil' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCreditBrasil, frmConfigCreditBrasil);
      frmConfigCreditBrasil.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCreditBrasil.btnGravar.Caption := '&OK';
      frmConfigCreditBrasil.blnNaoEditar      := True;
      frmConfigCreditBrasil.ShowModal;

      If frmConfigCreditBrasil.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCreditBrasil);
        Exit;
      End;

      If Trim(frmConfigCreditBrasil.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigCreditBrasil.edtDiasCred.Text);

      intCartei := frmConfigCreditBrasil.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCreditBrasil);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('992',intCartei,strCarBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupGarsonCredito' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigGarsonCredito, frmConfigGarsonCredito);
      frmConfigGarsonCredito.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigGarsonCredito.btnGravar.Caption := '&OK';
      frmConfigGarsonCredito.blnNaoEditar      := True;
      frmConfigGarsonCredito.ShowModal;

      If frmConfigGarsonCredito.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigGarsonCredito);
        Exit;
      End;

      If Trim(frmConfigGarsonCredito.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigGarsonCredito.edtDiasCred.Text);

      intCartei := frmConfigGarsonCredito.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigGarsonCredito);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('997',intCartei,strCarBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSifra, frmConfigSifra);
      frmConfigSifra.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSifra.btnGravar.Caption := '&OK';
      frmConfigSifra.blnNaoEditar      := True;
      frmConfigSifra.ShowModal;

      If frmConfigSifra.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSifra);
        Exit;
      End;

      If Trim(frmConfigSifra.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigSifra.edtDiasCred.Text);

      intCartei := frmConfigSifra.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSifra);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('998',intCartei,strCarBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupGrupoSifra' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigGrupoSifra, frmConfigGrupoSifra);
      frmConfigGrupoSifra.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigGrupoSifra.btnGravar.Caption := '&OK';
      frmConfigGrupoSifra.blnNaoEditar      := True;
      frmConfigGrupoSifra.ShowModal;

      If frmConfigGrupoSifra.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigGrupoSifra);
        Exit;
      End;

      If Trim(frmConfigGrupoSifra.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigGrupoSifra.edtDiasCred.Text);

      intCartei := frmConfigGrupoSifra.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigGrupoSifra);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('979',intCartei,strCarBco);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupUnicred400_136' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigUnicred400_136, frmConfigUnicred400_136);
      frmConfigUnicred400_136.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigUnicred400_136.btnGravar.Caption := '&OK';
      frmConfigUnicred400_136.blnNaoEditar      := True;
      frmConfigUnicred400_136.ShowModal;

      If frmConfigUnicred400_136.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigUnicred400_136);
        Exit;
      End;

      If Trim(frmConfigUnicred400_136.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigUnicred400_136.edtDiasCred.Text);

      intCartei := frmConfigUnicred400_136.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigUnicred400_136);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao'],2) = 1 Then
    Begin
      pBaixaAtuDup('136',intCartei,strCarBco);
    End;
  End


  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupDaycoval400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigDaycoval, frmConfigDaycoval);
      frmConfigDaycoval.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigDaycoval.btnGravar.Caption := '&OK';
      frmConfigDaycoval.blnNaoEditar      := True;
      frmConfigDaycoval.ShowModal;

      If frmConfigDaycoval.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigDaycoval);
        Exit;
      End;

      If Trim(frmConfigDaycoval.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigDaycoval.edtDiasCred.Text);

      intCartei := frmConfigDaycoval.tabCarteira.TabIndex + 1;
      strCarBco := frmConfigDaycoval.edtCodCar.Text;

    Finally
      FreeAndNil(frmConfigDaycoval);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('995',intCartei);
    End;
  End


  {******************************************}
  {*        BANCO DAYCOVAL [400P]           *}
  {*            LAYOUT PRÓPRIO              *}
  {*REQ:147378****************************MT*}

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupDaycoval_707[400p]' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigDaycoval_707, frmConfigDaycoval_707);
      frmConfigDaycoval_707.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigDaycoval_707.btnGravar.Caption := '&OK';
      frmConfigDaycoval_707.blnNaoEditar      := True;
      frmConfigDaycoval_707.ShowModal;

      If frmConfigDaycoval_707.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigDaycoval_707);
        Exit;
      End;

      If Trim(frmConfigDaycoval_707.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigDaycoval_707.edtDiasCred.Text);

      intCartei := frmConfigDaycoval_707.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigDaycoval_707);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao'],2) = 1 Then
    Begin
      pBaixaAtuDup('707',intCartei);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupSerrana' Then
  Begin
    intCartei := TSerranaMenu.CarteiraParaBaixa;

    If intCartei = 0 Then
      Exit;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
      pBaixaAtuDup('991',intCartei);
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupRubi' Then
  Begin
    intCartei := TRubiMenu.CarteiraParaBaixa;

    If intCartei = 0 Then
      Exit;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
      pBaixaAtuDup('989',intCartei);
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupUniprime400' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigUniprime400, frmConfigUniprime400);
      frmConfigUniprime400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigUniprime400.btnGravar.Caption := '&OK';
      frmConfigUniprime400.blnNaoEditar      := True;
      frmConfigUniprime400.ShowModal;

      If frmConfigUniprime400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigUniprime400);
        Exit;
      End;

      If Trim(frmConfigUniprime400.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigUniprime400.edtDiasCred.Text);

      intCartei := frmConfigUniprime400.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigUniprime400);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('099',intCartei);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBcoSisprime' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSisprime, frmConfigSisprime);
      frmConfigSisprime.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSisprime.btnGravar.Caption := '&OK';
      frmConfigSisprime.blnNaoEditar      := True;
      frmConfigSisprime.ShowModal;

      If frmConfigSisprime.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSisprime);
        Exit;
      End;

      If Trim(frmConfigSisprime.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigSisprime.edtDiasCred.Text);

      intCartei := frmConfigSisprime.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSisprime);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('084',intCartei);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupLakeBank' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigLakeBank, frmConfigLakeBank);
      frmConfigLakeBank.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigLakeBank.btnGravar.Caption := '&OK';
      frmConfigLakeBank.blnNaoEditar      := True;
      frmConfigLakeBank.ShowModal;

      If frmConfigLakeBank.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigLakeBank);
        Exit;
      End;

      If Trim(frmConfigLakeBank.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigLakeBank.edtDiasCred.Text);

      intCartei := frmConfigLakeBank.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigLakeBank);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('977',intCartei);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupLotus' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigLotus, frmConfigLotus);
      frmConfigLotus.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigLotus.btnGravar.Caption := '&OK';
      frmConfigLotus.blnNaoEditar      := True;
      frmConfigLotus.ShowModal;

      If frmConfigLotus.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigLotus);
        Exit;
      End;

      If Trim(frmConfigLotus.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigLotus.edtDiasCred.Text);

      intCartei := frmConfigLotus.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigLotus);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('976',intCartei);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupJPCapital' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigJPCapital, frmConfigJPCapital);
      frmConfigJPCapital.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigJPCapital.btnGravar.Caption := '&OK';
      frmConfigJPCapital.blnNaoEditar      := True;
      frmConfigJPCapital.ShowModal;

      If frmConfigJPCapital.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigJPCapital);
        Exit;
      End;

      If Trim(frmConfigJPCapital.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigJPCapital.edtDiasCred.Text);

      intCartei := frmConfigJPCapital.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigJPCapital);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('975',intCartei);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupOlam' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigOlam, frmConfigOlam);
      frmConfigOlam.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigOlam.btnGravar.Caption := '&OK';
      frmConfigOlam.blnNaoEditar      := True;
      frmConfigOlam.ShowModal;

      If frmConfigOlam.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigOlam);
        Exit;
      End;

      If Trim(frmConfigOlam.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigOlam.edtDiasCred.Text);

      intCartei := frmConfigOlam.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigOlam);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('974',intCartei);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBelaVista' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBelaVista, frmConfigBelaVista);
      frmConfigBelaVista.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBelaVista.btnGravar.Caption := '&OK';
      frmConfigBelaVista.blnNaoEditar      := True;
      frmConfigBelaVista.ShowModal;

      If frmConfigBelaVista.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBelaVista);
        Exit;
      End;

      If Trim(frmConfigBelaVista.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigBelaVista.edtDiasCred.Text);

      intCartei := frmConfigBelaVista.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBelaVista);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('973',intCartei);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupCredisan400' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCredisan400, frmConfigCredisan400);
      frmConfigCredisan400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCredisan400.btnGravar.Caption := '&OK';
      frmConfigCredisan400.blnNaoEditar      := True;
      frmConfigCredisan400.ShowModal;

      If frmConfigCredisan400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCredisan400);
        Exit;
      End;

      If Trim(frmConfigCredisan400.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigCRedisan400.edtDiasCred.Text);

      intCartei := frmConfigCredisan400.tabCarteira.TabIndex + 1;
    Finally
      FreeAndNil(frmConfigCredisan400);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('089',intCartei);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBradesco240V' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBradesco240Vendor,frmConfigBradesco240Vendor);
      frmConfigBradesco240Vendor.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBradesco240Vendor.btnGravar.Caption := '&OK';
      frmConfigBradesco240Vendor.blnNaoEditar      := True;
      frmConfigBradesco240Vendor.ShowModal;

      If frmConfigBradesco240Vendor.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBradesco240Vendor);
        Exit;
      End;

      intDiaCred := 0;

      intCartei := frmConfigBradesco240Vendor.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBradesco240Vendor);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      Try
        pBaixaAtuDup('237_VENDOR',intCartei);
      Except
        On E: Exception Do
        Begin
          fLiberaLockBaixaAutomatica('237');
        End
      End;
    End;

  End

  {***********************************}
  {* BAIXA AUTOMATICA DE DUPLICATAS  *}
  {********************************LB*}
//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmBaiAutDupBanespa' Then
//  Begin
//
//    Try
//      pCriarFormularios(TfrmConfigBanespa,frmConfigBanespa);
//      frmConfigBanespa.pnlTopo.Caption   := 'Selecione a carteira';
//      frmConfigBanespa.btnGravar.Caption := '&OK';
//      frmConfigBanespa.ShowModal;
//
//      If frmConfigBanespa.ModalResult <> mrOK Then
//      Begin
//        FreeAndNil(frmConfigBanespa);
//        Exit;
//      End;
//
//      If Trim(frmConfigBanespa.edtDiasCred.Text) = '' Then
//        intDiaCred := 0
//      Else
//        intDiaCred := StrToInt(frmConfigBanespa.edtDiasCred.Text);
//
//      intCartei := frmConfigBanespa.tabCarteira.TabIndex + 1;
//
//    Finally
//      FreeAndNil(frmConfigBanespa);
//    End;
//
//    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
//    Begin
//      pBaixaAtuDup('033',intCartei);
//    End;
//
//  End

//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmBaiAutDupSantander' Then
//  Begin
//
//    Try
//      pCriarFormularios(TfrmConfigSantander,frmConfigSantander);
//      frmConfigSantander.pnlTopo.Caption   := 'Selecione a carteira';
//      frmConfigSantander.btnGravar.Caption := '&OK';
//      frmConfigSantander.ShowModal;
//
//      If frmConfigSantander.ModalResult <> mrOK Then
//      Begin
//        FreeAndNil(frmConfigSantander);
//        Exit;
//      End;
//
//      If Trim(frmConfigSantander.edtDiasCred.Text) = '' Then
//        intDiaCred := 0
//      Else
//        intDiaCred := StrToInt(frmConfigSantander.edtDiasCred.Text);
//
//      intCartei := frmConfigSantander.tabCarteira.TabIndex + 1;
//
//    Finally
//      FreeAndNil(frmConfigSantander);
//    End;
//
//    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
//    Begin
//      pBaixaAtuDup('353',intCartei);
//    End;
//
//  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmBaiAutDupSantanderBan') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSantanderBan,frmConfigSantanderBan);
      frmConfigSantanderBan.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSantanderBan.btnGravar.Caption := '&OK';
      frmConfigSantanderBan.blnNaoEditar := true;
      frmConfigSantanderBan.ShowModal;

      If frmConfigSantanderBan.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSantanderBan);
        Exit;
      End;

      If Trim(frmConfigSantanderBan.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigSantanderBan.edtDiasCred.Text);

      intCartei := frmConfigSantanderBan.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSantanderBan);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('033B',intCartei);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmBaiAutDupSantander240p') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSantander240p,frmConfigSantander240p);
      frmConfigSantander240p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSantander240p.btnGravar.Caption := '&OK';
      frmConfigSantander240p.blnNaoEditar       := True;
      frmConfigSantander240p.ShowModal;

      If frmConfigSantander240p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSantander240p);
        Exit;
      End;

      If Trim(frmConfigSantander240p.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigSantander240p.edtDiasCred.Text);

      intCartei := frmConfigSantander240p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSantander240p);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao'],2) = 1 Then
    Begin
      pBaixaAtuDup('033B240p',intCartei);
    End;

  End


  Else If SameText(arrMenu[intIndex].strNomForm,'frmBaiAutDupBanestes') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBanestes,frmConfigBanestes);
      frmConfigBanestes.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBanestes.btnGravar.Caption := '&OK';
      frmConfigBanestes.blnNaoEditar := true;
      frmConfigBanestes.ShowModal;

      If frmConfigBanestes.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBanestes);
        Exit;
      End;

      If Trim(frmConfigBanestes.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigBanestes.edtDiasCred.Text);

      intCartei := frmConfigBanestes.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBanestes);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('021',intCartei);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBancoob' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBancoob,frmConfigBancoob);
      frmConfigBancoob.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoob.btnGravar.Caption := '&OK';
      frmConfigBancoob.blnNaoEditar      := True;
      frmConfigBancoob.ShowModal;

      If frmConfigBancoob.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoob);
        Exit;
      End;

      If Trim(frmConfigBancoob.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigBancoob.edtDiasCred.Text);

      intCartei := frmConfigBancoob.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBancoob);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('756',intCartei);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBancoob240' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBancoob240,frmConfigBancoob240);
      frmConfigBancoob240.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoob240.btnGravar.Caption := '&OK';
      frmConfigBancoob240.blnNaoEditar := True;
      frmConfigBancoob240.ShowModal;

      If frmConfigBancoob240.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoob240);
        Exit;
      End;

      If Trim(frmConfigBancoob240.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigBancoob240.edtDiasCred.Text);

      intCartei := frmConfigBancoob240.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBancoob240);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('756_240p',intCartei);
    End;

  End

  {***********************************}
  {* BAIXA AUTOMATICA DE DUPLICATAS  *}
  {********************************LB*}
  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupCxFed' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCxFederal,frmConfigCxFederal);
      frmConfigCxFederal.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCxFederal.btnGravar.Caption := '&OK';
      frmConfigCxFederal.blnNaoEditar      := true;
      frmConfigCxFederal.ShowModal;

      If frmConfigCxFederal.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCxFederal);
        Exit;
      End;

      If Trim(frmConfigCxFederal.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigCxFederal.edtDiasCred.Text);

      intCartei := frmConfigCxFederal.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCxFederal);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('104',intCartei);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupCxFed7D' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCxFederal7D,frmConfigCxFederal7D);
      frmConfigCxFederal7D.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCxFederal7D.btnGravar.Caption := '&OK';
      frmConfigCxFederal7D.blnNaoEditar      := true;
      frmConfigCxFederal7D.ShowModal;

      If frmConfigCxFederal7D.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCxFederal7D);
        Exit;
      End;

      If Trim(frmConfigCxFederal7D.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigCxFederal7D.edtDiasCred.Text);

      intCartei := frmConfigCxFederal7D.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCxFederal7D);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('1047D',intCartei);
    End;

  End


  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupCxFed400p' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCxFederal400p,frmConfigCxFederal400p);
      frmConfigCxFederal400p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCxFederal400p.btnGravar.Caption := '&OK';
      frmConfigCxFederal400p.blnNaoEditar      := true;
      frmConfigCxFederal400p.ShowModal;

      If frmConfigCxFederal400p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCxFederal400p);
        Exit;
      End;

      If Trim(frmConfigCxFederal400p.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigCxFederal400p.edtDiasCred.Text);

      intCartei := frmConfigCxFederal400p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCxFederal400p);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('104p400',intCartei);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBRB400p' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBRB400p,frmConfigBRB400p);
      frmConfigBRB400p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBRB400p.btnGravar.Caption := '&OK';
      frmConfigBRB400p.blnNaoEditar      := true;
      frmConfigBRB400p.ShowModal;

      If frmConfigBRB400p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBRB400p);
        Exit;
      End;

      If Trim(frmConfigBRB400p.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigBRB400p.edtDiasCred.Text);

      intCartei := frmConfigBRB400p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBRB400p);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('070p400',intCartei);
    End;

  End

  {***********************************}
  {* BAIXA AUTOMATICA DE DUPLICATAS  *}
  {********************************LB*}
//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmBaiAutDupNossaCx' Then
//  Begin
//
//    Try
//      pCriarFormularios(TfrmConfigNossaCx,frmConfigNossaCx);
//      frmConfigNossaCx.pnlTopo.Caption   := 'Selecione a carteira';
//      frmConfigNossaCx.btnGravar.Caption := '&OK';
//      frmConfigNossaCx.ShowModal;
//
//      If frmConfigNossaCx.ModalResult <> mrOK Then
//      Begin
//        FreeAndNil(frmConfigNossaCx);
//        Exit;
//      End;
//
//      If Trim(frmConfigNossaCx.edtDiasCred.Text) = '' Then
//        intDiaCred := 0
//      Else
//        intDiaCred := StrToInt(frmConfigNossaCx.edtDiasCred.Text);
//
//      intCartei := frmConfigNossaCx.tabCarteira.TabIndex + 1;
//
//    Finally
//      FreeAndNil(frmConfigNossaCx);
//    End;
//
//    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
//    Begin
//      pBaixaAtuDup('151',intCartei);
//    End;
//
//  End

  {***********************************}
  {* BAIXA AUTOMATICA DE DUPLICATAS  *}
  {********************************LB*}
  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupMerc' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigMercantil,frmConfigMercantil);
      frmConfigMercantil.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigMercantil.btnGravar.Caption := '&OK';
      frmConfigMercantil.blnNaoEditar := true;
      frmConfigMercantil.ShowModal;

      If frmConfigMercantil.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigMercantil);
        Exit;
      End;

      If Trim(frmConfigMercantil.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigMercantil.edtDiasCred.Text);

      intCartei := frmConfigMercantil.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigMercantil);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('389',intCartei);
    End;

  End

  {***********************************}
  {* BAIXA AUTOMATICA DE DUPLICATAS  *}
  {********************************LB*}
  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupHsbc' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigHsbc,frmConfigHsbc);
      frmConfigHsbc.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigHsbc.btnGravar.Caption := '&OK';
      frmConfigHsbc.blnNaoEditar := true;
      frmConfigHsbc.ShowModal;

      If frmConfigHsbc.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigHsbc);
        Exit;
      End;

      If Trim(frmConfigHsbc.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigHsbc.edtDiasCred.Text);

      intCartei := frmConfigHsbc.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigHsbc);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('399',intCartei);
    End;

  End

  {***********************************}
  {* BAIXA AUTOMATICA DE DUPLICATAS  *}
  {********************************LB*}
//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmBaiAutDupRibPreto' Then
//  Begin
//
//    Try
//      pCriarFormularios(TfrmConfigRibPreto,frmConfigRibPreto);
//      frmConfigRibPreto.pnlTopo.Caption   := 'Selecione a carteira';
//      frmConfigRibPreto.btnGravar.Caption := '&OK';
//      frmConfigRibPreto.ShowModal;
//
//      If frmConfigRibPreto.ModalResult <> mrOK Then
//      Begin
//        FreeAndNil(frmConfigRibPreto);
//        Exit;
//      End;
//
//      If Trim(frmConfigRibPreto.edtDiasCred.Text) = '' Then
//        intDiaCred := 0
//      Else
//        intDiaCred := StrToInt(frmConfigRibPreto.edtDiasCred.Text);
//
//      intCartei := frmConfigRibPreto.tabCarteira.TabIndex + 1;
//
//    Finally
//      FreeAndNil(frmConfigRibPreto);
//    End;
//
//    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
//    Begin
//      pBaixaAtuDup('741',intCartei);
//    End;
//
//  End

  {***********************************}
  {* BAIXA AUTOMATICA DE DUPLICATAS  *}
  {********************************LB*}
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmBaiAutDupReal' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigReal,frmConfigReal);
      frmConfigReal.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigReal.btnGravar.Caption := '&OK';
      frmConfigReal.blnNaoEditar := true;
      frmConfigReal.ShowModal;

      If frmConfigReal.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigReal);
        Exit;
      End;

      If Trim(frmConfigReal.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigReal.edtDiasCred.Text);

      intCartei := frmConfigReal.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigReal);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('356',intCartei);
    End;

  End


  //*************************************************//
  // BAIXA AUTOMATICA DE DUPLICATAS DO UNIBANCO      //
  //**********************************************ED*//
//  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmBaiAutDupUnibanco' Then
//  Begin
//
//    Try
//      pCriarFormularios(TfrmConfigUnibanco,frmConfigUnibanco);
//      frmConfigUnibanco.pnlTopo.Caption   := 'Selecione a carteira';
//      frmConfigUnibanco.btnGravar.Caption := '&OK';
//      frmConfigUnibanco.ShowModal;
//
//      If frmConfigUnibanco.ModalResult <> mrOK Then
//      Begin
//        FreeAndNil(frmConfigUnibanco);
//        Exit;
//      End;
//
//      If Trim(frmConfigUnibanco.edtDiasCred.Text) = '' Then
//        intDiaCred := 0
//      Else
//        intDiaCred := StrToInt(frmConfigUnibanco.edtDiasCred.Text);
//
//      intCartei := frmConfigUnibanco.tabCarteira.TabIndex + 1;
//
//    Finally
//      FreeAndNil(frmConfigUnibanco);
//    End;
//
//    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
//    Begin
//      pBaixaAtuDup('409',intCartei);
//    End;
//
//  End


  //*************************************************//
  // BAIXA AUTOMATICA DE DUPLICATAS DO SICREDI       //
  //**********************************************ED*//
  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupSicredi' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSicredi, frmConfigSicredi);
      frmConfigSicredi.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSicredi.btnGravar.Caption := '&OK';
      frmConfigSicredi.blnNaoEditar := true;
      frmConfigSicredi.ShowModal;

      If frmConfigSicredi.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSicredi);
        Exit;
      End;

      intDiaCred := 0;
      If Trim(frmConfigSicredi.edtDiasCred.Text) <> '' Then
        intDiaCred := StrToInt(frmConfigSicredi.edtDiasCred.Text);

      intCartei := frmConfigSicredi.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSicredi);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('748',intCartei);
    End;

  End

  //*************************************************//
  // BAIXA AUTOMATICA DE DUPLICATAS DO SICREDI 240   //
  //**********************************************ED*//
  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupSicredi240' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSicredi240, frmConfigSicredi240);
      frmConfigSicredi240.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSicredi240.btnGravar.Caption := '&OK';
      frmConfigSicredi240.blnNaoEditar      := true;
      frmConfigSicredi240.ShowModal;

      If frmConfigSicredi240.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSicredi240);
        Exit;
      End;

      intDiaCred := 0;
      If Trim(frmConfigSicredi240.edtDiasCred.Text) <> '' Then
        intDiaCred := StrToInt(frmConfigSicredi240.edtDiasCred.Text);

      intCartei := frmConfigSicredi240.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSicredi240);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('748_240p',intCartei);
    End;
  End

  //*************************************************//
  // BAIXA AUTOMATICA DE DUPLICATAS DO BANRISUL      //
  //**********************************************ED*//
  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBanrisul' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBanrisul, frmConfigBanrisul);
      frmConfigBanrisul.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBanrisul.btnGravar.Caption := '&OK';
      frmConfigBanrisul.blnNaoEditar := true;
      frmConfigBanrisul.ShowModal;

      If frmConfigBanrisul.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBanrisul);
        Exit;
      End;

      intDiaCred := 0;
      If Trim(frmConfigBanrisul.edtDiasCred.Text) <> '' Then
        intDiaCred := StrToInt(frmConfigBanrisul.edtDiasCred.Text);

      intCartei := frmConfigBanrisul.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBanrisul);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('041',intCartei);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBanrisul240' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBanrisul240, frmConfigBanrisul240);
      frmConfigBanrisul240.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBanrisul240.btnGravar.Caption := '&OK';
      frmConfigBanrisul240.blnNaoEditar := true;
      frmConfigBanrisul240.ShowModal;

      If frmConfigBanrisul240.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBanrisul240);
        Exit;
      End;

      intDiaCred := 0;
      If Trim(frmConfigBanrisul240.edtDiasCred.Text) <> '' Then
        intDiaCred := StrToInt(frmConfigBanrisul240.edtDiasCred.Text);

      intCartei := frmConfigBanrisul240.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBanrisul240);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao'],2) = 1 Then
    Begin
      pBaixaAtuDup('041_240p',intCartei);
    End;

  End

  Else If SameText(arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm,'frmBaiAutDupSafra') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSafra,frmConfigSafra);
      frmConfigSafra.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSafra.btnGravar.Caption := '&OK';
      frmConfigSafra.blnNaoEditar := true;
      frmConfigSafra.ShowModal;

      If frmConfigSafra.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSafra);
        Exit;
      End;

      If Trim(frmConfigSafra.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigSafra.edtDiasCred.Text);

      intCartei := frmConfigSafra.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSafra);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('422',intCartei);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmBaiAutDupSofisa') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSofisa,frmConfigSofisa);
      frmConfigSofisa.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSofisa.btnGravar.Caption := '&OK';
      frmConfigSofisa.blnNaoEditar := true;
      frmConfigSofisa.ShowModal;

      If frmConfigSofisa.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSofisa);
        Exit;
      End;

      If Trim(frmConfigSofisa.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigSofisa.edtDiasCred.Text);

      intCartei := frmConfigSofisa.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSofisa);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('637',intCartei);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmBaiAutDupBtgPactual_240p') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBtgPactual_240p,frmConfigBtgPactual_240p);
      frmConfigBtgPactual_240p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBtgPactual_240p.btnGravar.Caption := '&OK';
      frmConfigBtgPactual_240p.blnNaoEditar := TRUE;
      frmConfigBtgPactual_240p.ShowModal;

      If frmConfigBtgPactual_240p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBtgPactual_240p);
        exit;
      End;

      If Trim(frmConfigBtgPactual_240p.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigBtgPactual_240p.edtDiasCred.Text);

      intCartei := frmConfigBtgPactual_240p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBtgPactual_240p);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('208',intCartei);
    End;

  End

  {* BANCO GERENCIANET 240  *}
  {MF: 284963 - 12/07/23 ****}
  Else If SameText(arrMenu[intIndex].strNomForm,'frmBaiAutDupGerencianet240p') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigGerencianet240p,frmConfigGerencianet240p);
      frmConfigGerencianet240p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigGerencianet240p.btnGravar.Caption := '&OK';
      frmConfigGerencianet240p.strConfig         := 'CONFIG364-';
      frmConfigGerencianet240p.blnNaoEditar      := True;
      frmConfigGerencianet240p.ShowModal;

      If frmConfigGerencianet240p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigGerencianet240p);
        exit;
      End;

      If Trim(frmConfigGerencianet240p.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigGerencianet240p.edtDiasCred.Text);

      intCartei := frmConfigGerencianet240p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigGerencianet240p);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('364',intCartei);
    End;

  End

  {**************************}
  {* BANCO CRESOL           *}
  {MF: 287323 - 12/07/23 ****}
  Else If SameText(arrMenu[intIndex].strNomForm,'frmBaiAutDupCresol240p') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCresol240p,frmConfigCresol240p);
      frmConfigCresol240p.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCresol240p.btnGravar.Caption := '&OK';
      frmConfigCresol240p.strConfig         := 'CONFIG133-';
      frmConfigCresol240p.blnNaoEditar := True;
      frmConfigCresol240p.ShowModal;

      If frmConfigCresol240p.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCresol240p);
        Exit;
      End;

      If Trim(frmConfigCresol240p.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigCresol240p.edtDiasCred.Text);

      intCartei := frmConfigCresol240p.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCresol240p);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('133',intCartei);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupSparti' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSparti, frmConfigSparti);
      frmConfigSparti.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSparti.btnGravar.Caption := '&OK';
      frmConfigSparti.blnNaoEditar      := True;
      frmConfigSparti.ShowModal;

      If frmConfigSparti.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSparti);
        Exit;
      End;

      If Trim(frmConfigSparti.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigSparti.edtDiasCred.Text);

      intCartei := frmConfigSparti.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSparti);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao'],2) = 1 Then
    Begin
      pBaixaAtuDup('982',intCartei);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupLecca' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBancoLecca, frmConfigBancoLecca);
      frmConfigBancoLecca.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoLecca.btnGravar.Caption := '&OK';
      frmConfigBancoLecca.blnNaoEditar      := True;
      frmConfigBancoLecca.ShowModal;

      If frmConfigBancoLecca.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoLecca);
        Exit;
      End;

      If Trim(frmConfigBancoLecca.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigBancoLecca.edtDiasCred.Text);

      intCartei := frmConfigBancoLecca.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBancoLecca);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao'],2) = 1 Then
    Begin
      pBaixaAtuDup('984',intCartei);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmBaiAutDupBancoAmazonia') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBancoAmazonia,frmConfigBancoAmazonia);
      frmConfigBancoAmazonia.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoAmazonia.btnGravar.Caption := '&OK';
      frmConfigBancoAmazonia.blnNaoEditar := true;
      frmConfigBancoAmazonia.ShowModal;

      If frmConfigBancoAmazonia.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoAmazonia);
        Exit;
      End;

      If Trim(frmConfigBancoAmazonia.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigBancoAmazonia.edtDiasCred.Text);

      intCartei := frmConfigBancoAmazonia.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBancoAmazonia);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('003',intCartei);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmBaiAutDupBancoRendimento') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigRendimento,frmConfigRendimento);
      frmConfigRendimento.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigRendimento.btnGravar.Caption := '&OK';
      frmConfigRendimento.blnNaoEditar := true;
      frmConfigRendimento.ShowModal;

      If frmConfigRendimento.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigRendimento);
        Exit;
      End;

      If Trim(frmConfigRendimento.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigRendimento.edtDiasCred.Text);

      intCartei := frmConfigRendimento.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigRendimento);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('633',intCartei);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmBaiAutDupCecred') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCecred,frmConfigCecred);
      frmConfigCecred.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigCecred.btnGravar.Caption := '&OK';
      frmConfigCecred.blnNaoEditar := true;
      frmConfigCecred.ShowModal;

      If frmConfigCecred.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigCecred);
        Exit;
      End;

      If Trim(frmConfigCecred.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigCecred.edtDiasCred.Text);

      intCartei := frmConfigCecred.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigCecred);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('085',intCartei);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmBaiAutDupUnicred') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigUnicred,frmConfigUnicred);
      frmConfigUnicred.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigUnicred.btnGravar.Caption := '&OK';
      frmConfigUnicred.blnNaoEditar := true;
      frmConfigUnicred.ShowModal;

      If frmConfigUnicred.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigUnicred);
        Exit;
      End;

      If Trim(frmConfigUnicred.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigUnicred.edtDiasCred.Text);

      intCartei := frmConfigUnicred.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigUnicred);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('090',intCartei);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmBaiAutDupUnicred400') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigUnicred400,frmConfigUnicred400);
      frmConfigUnicred400.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigUnicred400.btnGravar.Caption := '&OK';
      frmConfigUnicred400.blnNaoEditar := true;
      frmConfigUnicred400.ShowModal;

      If frmConfigUnicred400.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigUnicred400);
        Exit;
      End;

      If Trim(frmConfigUnicred400.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigUnicred400.edtDiasCred.Text);

      intCartei := frmConfigUnicred400.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigUnicred400);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('090',intCartei);
    End;

  End

  Else If SameText(arrMenu[intIndex].strNomForm,'frmBaiAutDupSofisa_444') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSofisa_444,frmConfigSofisa_444);
      frmConfigSofisa_444.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSofisa_444.btnGravar.Caption := '&OK';
      frmConfigSofisa_444.blnNaoEditar := true;
      frmConfigSofisa_444.ShowModal;

      If frmConfigSofisa_444.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSofisa_444);
        Exit;
      End;

      If Trim(frmConfigSofisa_444.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigSofisa_444.edtDiasCred.Text);

      intCartei := frmConfigSofisa_444.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSofisa_444);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('637_444p',intCartei);
    End;

  End

  {***********************************}
  {* BANCO ABC BRASIL                *}
  {*REQ.34692 29/05/2015***********JU*}
  Else If SameText(arrMenu[intIndex].strNomForm,'frmBaiAutDupABCBrasil') Then
  Begin

    Try
      pCriarFormularios(TfrmConfigABCBrasil,frmConfigABCBrasil);
      frmConfigABCBrasil.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigABCBrasil.btnGravar.Caption := '&OK';
      frmConfigABCBrasil.blnNaoEditar := true;
      frmConfigABCBrasil.ShowModal;

      If frmConfigABCBrasil.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigABCBrasil);
        Exit;
      End;

      If Trim(frmConfigABCBrasil.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigABCBrasil.edtDiasCred.Text);

      intCartei := frmConfigABCBrasil.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigABCBrasil);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('246',intCartei);
    End;

  End

//**NOVOBANCO**

{******************}
{* CONTAS A PAGAR *}
{******************}
  Else If arrMenu[intIndex].strNomForm = 'frmGerDupBBCta' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 001 - Banco do Brasil';
      frmGerDup.strNomBanco            := '001 - Banco do Brasil';
      frmGerDup.strTipGer              := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmGerDup.blnMosTED              := True;
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmGerDupBBCtaApi' Then
    TPagForMenu.GeracaoDeDuplicata('001', True)

  Else If arrMenu[intIndex].strNomForm = 'frmGerDupCxFederalCta' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 104 - Caixa Federal';
      frmGerDup.strNomBanco            := '104 - Caixa Federal';
      frmGerDup.strTipGer              := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmGerDup.blnMosTED              := True;
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmGerDupItauCta' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 341 - Itaú';
      frmGerDup.strNomBanco            := '341 - Itaú';
      frmGerDup.strTipGer              := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmGerDup.blnMosTED              := True;
      frmGerDup.edtDesPortador.Enabled := False;
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmGerDupSicrediCta' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 748 - Sicredi';
      frmGerDup.strNomBanco            := '748 - Sicredi';
      frmGerDup.strTipGer              := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmGerDup.blnMosTED              := True;
      frmGerDup.edtDesPortador.Enabled := False;
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'GerDupBradescoCta240' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 237 - Bradesco [240p]';
      frmGerDup.strNomBanco            := '237 - Bradesco';
      frmGerDup.strTipGer              := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmGerDup.edtPortador.Enabled    := False;
      frmGerDup.edtDesPortador.Enabled := False;
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmGerDupSafraCta' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 422 - Safra';
      frmGerDup.strNomBanco            := '422 - Safra';
      frmGerDup.strTipGer              := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmGerDupBanestesCta' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 021 - Banestes';
      frmGerDup.strNomBanco            := '021 - Banestes';
      frmGerDup.strTipGer              := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBBCta' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelCtaDuplicatas,frmRelRelCtaDuplicatas);
      frmRelRelCtaDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 001 - Banco do Brasil';
      frmRelRelCtaDuplicatas.strNomBanco      := '001 - Banco do Brasil';
      frmRelRelCtaDuplicatas.blnMosPagto      := True;
      frmRelRelCtaDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelCtaDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBBCtaApi' Then
    TPagForMenu.RelatorioDeDuplicataRemessa('001', True)

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemCxFederalCta' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelCtaDuplicatas,frmRelRelCtaDuplicatas);
      frmRelRelCtaDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 104 - Caixa Federal';
      frmRelRelCtaDuplicatas.strNomBanco      := '104 - Caixa Federal';
      frmRelRelCtaDuplicatas.blnMosPagto      := True;
      frmRelRelCtaDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelCtaDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemItauCta' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelCtaDuplicatas,frmRelRelCtaDuplicatas);
      frmRelRelCtaDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 341 - Itaú';
      frmRelRelCtaDuplicatas.strNomBanco      := '341 - Itaú';
      frmRelRelCtaDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelCtaDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemSicrediCta' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelCtaDuplicatas,frmRelRelCtaDuplicatas);
      frmRelRelCtaDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 748 - Sicredi';
      frmRelRelCtaDuplicatas.strNomBanco      := '748 - Sicredi';
      frmRelRelCtaDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelCtaDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBradescoCta240' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelCtaDuplicatas,frmRelRelCtaDuplicatas);
      frmRelRelCtaDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 237 - Bradesco';
      frmRelRelCtaDuplicatas.strNomBanco      := '237 - Bradesco';
      frmRelRelCtaDuplicatas.blnMosPagto      := True;
      frmRelRelCtaDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelCtaDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemSafraCta' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelCtaDuplicatas,frmRelRelCtaDuplicatas);
      frmRelRelCtaDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 422 - Safra';
      frmRelRelCtaDuplicatas.strNomBanco      := '422 - Safra';
      frmRelRelCtaDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelCtaDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBanestesCta' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelCtaDuplicatas,frmRelRelCtaDuplicatas);
      frmRelRelCtaDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 021 - Banestes';
      frmRelRelCtaDuplicatas.strNomBanco      := '021 - Banestes';
      frmRelRelCtaDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelCtaDuplicatas);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmEstBBCta' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '001';
      frmEstorno.edtDesBco.Text  := 'Banco do Brasil';
      frmEstorno.blnApenasCadPag := False;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBBCtaApi' Then
    TPagForMenu.CancelaDuplicatasRemessa('001', True)

  Else If arrMenu[intIndex].strNomform = 'frmEstCxFederalCta' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '104';
      frmEstorno.edtDesBco.Text  := 'Caixa Federal';
      frmEstorno.blnApenasCadPag := False;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmEstItauCta' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '341';
      frmEstorno.edtDesBco.Text  := 'Itaú';
      frmEstorno.blnApenasCadPag := False;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmEstSicrediCta' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '748';
      frmEstorno.edtDesBco.Text  := 'Sicredi';
      frmEstorno.blnApenasCadPag := False;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmEstBradescoCta240' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '237';
      frmEstorno.edtDesBco.Text  := 'Bradesco';
      frmEstorno.blnApenasCadPag := False;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstSafraCta' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '422';
      frmEstorno.edtDesBco.Text  := 'Safra';
      frmEstorno.blnApenasCadPag := False;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstBanestesCta' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '021';
      frmEstorno.edtDesBco.Text  := 'Banestes';
      frmEstorno.blnApenasCadPag := False;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBBCta' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '001';
      frmEstorno.edtDesBco.Text  := 'Banco do Brasil';
      frmEstorno.blnApenasCadPag := True;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBBCtaApi' Then
    TPagForMenu.CancelaDuplicatasEnviadasAoBanco('001', True)

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvCxFederalCta' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '104';
      frmEstorno.edtDesBco.Text  := 'Caixa Federal';
      frmEstorno.blnApenasCadPag := True;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmEstEnvItauCta' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '341';
      frmEstorno.edtDesBco.Text  := 'Itaú';
      frmEstorno.blnApenasCadPag := True;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmEstEnvSicrediCta' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '748';
      frmEstorno.edtDesBco.Text  := 'Sicredi';
      frmEstorno.blnApenasCadPag := True;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmEstEnvSafraCta' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '422';
      frmEstorno.edtDesBco.Text  := 'Safra';
      frmEstorno.blnApenasCadPag := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBanestesCta' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '021';
      frmEstorno.edtDesBco.Text  := 'Banestes';
      frmEstorno.blnApenasCadPag := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigBradescoCta240' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBradescoCta240,frmConfigBradescoCta240);
      frmConfigBradescoCta240.strConfig := 'CONFIGCTA237_240p-';
      frmConfigBradescoCta240.ShowModal;
    Finally
      FreeAndNil(frmConfigBradescoCta240);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigSafraCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSafraCta,frmConfigSafraCta);
      frmConfigSafraCta.strConfig := 'CONFIGCTA422-';
      frmConfigSafraCta.ShowModal;
    Finally
      FreeAndNil(frmConfigSafraCta);
    End;

  End


  Else If arrMenu[intIndex].strNomform = 'frmConfigBanestesCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBanestesCta,frmConfigBanestesCta);
      frmConfigBanestesCta.strConfig := 'CONFIGCTA021-';
      frmConfigBanestesCta.ShowModal;
    Finally
      FreeAndNil(frmConfigBanestesCta);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigItauCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigPagFor,frmConfigPagFor);
      frmConfigPagFor.pnlTopo.Caption  := 'Configurações Contas a Pagar - 341 - Itaú';
      frmConfigPagFor.strConfig        := 'CONFIGCTA341';
      frmConfigPagFor.strCodBco        := '341';
      frmConfigPagFor.ShowModal;
    Finally
      FreeAndNil(frmConfigPagFor);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmConfigSicrediCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigPagFor,frmConfigPagFor);
      frmConfigPagFor.pnlTopo.Caption  := 'Configurações Contas a Pagar - 748 - Sicredi';
      frmConfigPagFor.strConfig        := 'CONFIGCTA748';
      frmConfigPagFor.strCodBco        := '748';
      frmConfigPagFor.ShowModal;
    Finally
      FreeAndNil(frmConfigPagFor);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigBBCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigPagFor,frmConfigPagFor);
      frmConfigPagFor.pnlTopo.Caption  := 'Configurações Contas a Pagar - 001 - Banco do Brasil';
      frmConfigPagFor.strConfig        := 'CONFIGCTA001';
      frmConfigPagFor.strCodBco        := '001';
      frmConfigPagFor.ShowModal;
    Finally
      FreeAndNil(frmConfigPagFor);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmConfigBBCtaApi' Then
    TPagForMenu.Configuracao('001', 'CONFIGCTAAPI001', True)

  Else If arrMenu[intIndex].strNomform = 'frmConfigCxFederalCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigPagFor,frmConfigPagFor);
      frmConfigPagFor.pnlTopo.Caption  := 'Configurações Contas a Pagar - 104 - Caixa Federal';
      frmConfigPagFor.strConfig        := 'CONFIGCTA104';
      frmConfigPagFor.strCodBco        := '104';
      frmConfigPagFor.ShowModal;
    Finally
      FreeAndNil(frmConfigPagFor);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemItauCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigPagFor,frmConfigPagFor);
      frmConfigPagFor.pnlTopo.Caption   := 'Selecione a Carteira - 341 - Itaú';
      frmConfigPagFor.btnGravar.Caption := '&OK';
      frmConfigPagFor.strConfig         := 'CONFIGCTA341';
      frmConfigPagFor.strCodBco         := '341';
      frmConfigPagFor.blnNaoEditar      := True;
      frmConfigPagFor.ShowModal;
      intCartei := + frmConfigPagFor.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigPagFor.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigPagFor);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmExpArqPagFor,frmExpArqPagFor);
        frmExpArqPagFor.pnlTopo.Caption  := 'Geração de Arquivo de Remessa - 341 - Itaú';
        frmExpArqPagFor.strConfig        := 'CONFIGCTA341-' + InttoStr(intCartei);
        frmExpArqPagFor.strCodBco        := '341';
        frmExpArqPagFor.strNomBco        := 'ITAU';
        frmExpArqPagFor.ShowModal;
      Finally
        FreeAndNil(frmExpArqPagFor);
      End;
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemSicrediCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigPagFor,frmConfigPagFor);
      frmConfigPagFor.pnlTopo.Caption   := 'Selecione a Carteira - 748 - Sicredi';
      frmConfigPagFor.btnGravar.Caption := '&OK';
      frmConfigPagFor.strConfig         := 'CONFIGCTA748';
      frmConfigPagFor.strCodBco         := '748';
      frmConfigPagFor.blnNaoEditar      := True;
      frmConfigPagFor.ShowModal;
      intCartei := + frmConfigPagFor.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigPagFor.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigPagFor);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmExpArqPagFor,frmExpArqPagFor);
        frmExpArqPagFor.pnlTopo.Caption  := 'Geração de Arquivo de Remessa - 748 - Sicredi';
        frmExpArqPagFor.strConfig        := 'CONFIGCTA748-' + InttoStr(intCartei);
        frmExpArqPagFor.strCodBco        := '748';
        frmExpArqPagFor.strNomBco        := 'SICREDI';
        frmExpArqPagFor.ShowModal;
      Finally
        FreeAndNil(frmExpArqPagFor);
      End;
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmExpArqRemBBCta' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigPagFor,frmConfigPagFor);
      frmConfigPagFor.pnlTopo.Caption   := 'Selecione a Carteira - 001 - Banco do Brasil';
      frmConfigPagFor.btnGravar.Caption := '&OK';
      frmConfigPagFor.strConfig         := 'CONFIGCTA001';
      frmConfigPagFor.blnNaoEditar      := True;
      frmConfigPagFor.ShowModal;
      intCartei := + frmConfigPagFor.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigPagFor.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigPagFor);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmExpArqPagFor,frmExpArqPagFor);
        frmExpArqPagFor.pnlTopo.Caption  := 'Geração de Arquivo de Remessa - 001 - Banco do Brasil';
        frmExpArqPagFor.strConfig        := 'CONFIGCTA001-' + InttoStr(intCartei);
        frmExpArqPagFor.strCodBco        := '001';
        frmExpArqPagFor.strNomBco        := 'BANCO DO BRASIL';
        frmExpArqPagFor.ShowModal;
      Finally
        FreeAndNil(frmExpArqPagFor);
      End;
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmEnviaRemBBCtaApi' Then
    TPagForMenu.EnviaDuplicatasRemessaApi('001')

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmExpArqRemCxFederalCta' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigPagFor,frmConfigPagFor);
      frmConfigPagFor.pnlTopo.Caption   := 'Selecione a Carteira - 104 - Caixa Federal';
      frmConfigPagFor.btnGravar.Caption := '&OK';
      frmConfigPagFor.strConfig         := 'CONFIGCTA104';
      frmConfigPagFor.blnNaoEditar      := True;
      frmConfigPagFor.ShowModal;
      intCartei := + frmConfigPagFor.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigPagFor.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigPagFor);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmExpArqPagFor,frmExpArqPagFor);
        frmExpArqPagFor.pnlTopo.Caption  := 'Geração de Arquivo de Remessa - 104 - Caixa Federal';
        frmExpArqPagFor.strConfig        := 'CONFIGCTA104-' + InttoStr(intCartei);
        frmExpArqPagFor.strCodBco        := '104';
        frmExpArqPagFor.strNomBco        := 'CAIXA FEDERAL';
        frmExpArqPagFor.ShowModal;
      Finally
        FreeAndNil(frmExpArqPagFor);
      End;
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBradescoCta240' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBradescoCta240,frmConfigBradescoCta240);
      frmConfigBradescoCta240.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBradescoCta240.btnGravar.Caption := '&OK';
      frmConfigBradescoCta240.blnNaoEditar       := True;
      frmConfigBradescoCta240.ShowModal;

      If frmConfigBradescoCta240.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBradescoCta240);
        Exit;
      End;

      intCartei := frmConfigBradescoCta240.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBradescoCta240);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemBradescoCta240,frmExpArqRemBradescoCta240);
      frmExpArqRemBradescoCta240.intCartei  := intCartei;
      frmExpArqRemBradescoCta240.strNomForm := 'frmConfigBradescoCta240';
      frmExpArqRemBradescoCta240.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemBradescoCta240);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemSafraCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSafraCta,frmConfigSafraCta);
      frmConfigSafraCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSafraCta.btnGravar.Caption := '&OK';
      frmConfigSafraCta.blnNaoEditar      := True;
      frmConfigSafraCta.strConfig  := 'CONFIGCTA422-';
      frmConfigSafraCta.ShowModal;

      If frmConfigSafraCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSafraCta);
        Exit;
      End;

      intCartei := frmConfigSafraCta.tabCarteira.TabIndex + 1;
    Finally
      FreeAndNil(frmConfigSafraCta);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemSafraCta,frmExpArqRemSafraCta);
      frmExpArqRemSafraCta.strConfig  := 'CONFIGCTA422-' + InttoStr(intCartei);
      frmExpArqRemSafraCta.strNomForm := Name;
      frmExpArqRemSafraCta.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemSafraCta);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBanestesCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBanestesCta,frmConfigBanestesCta);
      frmConfigBanestesCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBanestesCta.btnGravar.Caption := '&OK';
      frmConfigBanestesCta.blnNaoEditar      := True;
      frmConfigBanestesCta.strConfig         := 'CONFIGCTA021-';
      frmConfigBanestesCta.ShowModal;

      If frmConfigBanestesCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBanestesCta);
        Exit;
      End;

      intCartei := frmConfigBanestesCta.tabCarteira.TabIndex + 1;
    Finally
      FreeAndNil(frmConfigBanestesCta);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemBanestesCta,frmExpArqRemBanestesCta);
      frmExpArqRemBanestesCta.strConfig  := 'CONFIGCTA021-' + InttoStr(intCartei);
      frmExpArqRemBanestesCta.strNomForm := Name;
      frmExpArqRemBanestesCta.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemBanestesCta);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetItauCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigPagFor,frmConfigPagFor);
      frmConfigPagFor.pnlTopo.Caption   := 'Selecione a Carteira - 341 - Itaú';
      frmConfigPagFor.btnGravar.Caption := '&OK';
      frmConfigPagFor.strConfig         := 'CONFIGCTA341';
      frmConfigPagFor.blnNaoEditar      := True;
      frmConfigPagFor.ShowModal;
      intCartei := + frmConfigPagFor.tabContas.TabIndex + 1;
    Finally
      blnConfirma := frmConfigPagFor.ModalResult = mrOK;
      FreeAndNil(frmConfigPagFor);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmRetPagFor,frmRetPagFor);
        frmRetPagFor.pnlTopo.Caption  := 'Arquivo de Retorno - 341 - Itaú';
        frmRetPagFor.strCodBco        := '341';
        frmRetPagFor.strNomBco        := 'ITAU';
        frmRetPagFor.strConfig        := 'CONFIGCTA341-' + InttoStr(intCartei);
        frmRetPagFor.ShowModal;
      Finally
        FreeAndNil(frmRetPagFor);
      End;
    End;

  End
  Else If arrMenu[intIndex].strNomForm = 'frmArqRetSicrediCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigPagFor,frmConfigPagFor);
      frmConfigPagFor.pnlTopo.Caption   := 'Selecione a Carteira - 748 - Sicredi';
      frmConfigPagFor.btnGravar.Caption := '&OK';
      frmConfigPagFor.strConfig         := 'CONFIGCTA748';
      frmConfigPagFor.blnNaoEditar      := True;
      frmConfigPagFor.ShowModal;
      intCartei := + frmConfigPagFor.tabContas.TabIndex + 1;
    Finally
      blnConfirma := frmConfigPagFor.ModalResult = mrOK;
      FreeAndNil(frmConfigPagFor);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmRetPagFor,frmRetPagFor);
        frmRetPagFor.pnlTopo.Caption  := 'Arquivo de Retorno - 748 - Sicredi';
        frmRetPagFor.strCodBco        := '748';
        frmRetPagFor.strNomBco        := 'SICREDI';
        frmRetPagFor.strConfig        := 'CONFIGCTA748-' + InttoStr(intCartei);
        frmRetPagFor.ShowModal;
      Finally
        FreeAndNil(frmRetPagFor);
      End;
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmArqRetBBCta' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigPagFor,frmConfigPagFor);
      frmConfigPagFor.pnlTopo.Caption   := 'Selecione a Carteira - 001 - Banco do Brasil';
      frmConfigPagFor.btnGravar.Caption := '&OK';
      frmConfigPagFor.strConfig         := 'CONFIGCTA001';
      frmConfigPagFor.blnNaoEditar      := True;
      frmConfigPagFor.ShowModal;
      intCartei := + frmConfigPagFor.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigPagFor.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigPagFor);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmRetPagFor,frmRetPagFor);
        frmRetPagFor.pnlTopo.Caption  := 'Arquivo de Retorno - 001 - Banco do Brasil';
        frmRetPagFor.strCodBco        := '001';
        frmRetPagFor.strNomBco        := 'BANCO DO BRASIL';
        frmRetPagFor.strConfig        := 'CONFIGCTA001-' + InttoStr(intCartei);
        frmRetPagFor.ShowModal;
      Finally
        FreeAndNil(frmRetPagFor);
      End;
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmArqRetBBCtaApi' Then
    TPagForMenu.ImportarBoletosAPI('001')

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmArqRetCxFederalCta' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigPagFor,frmConfigPagFor);
      frmConfigPagFor.pnlTopo.Caption   := 'Selecione a Carteira - 104 - Caixa Federal';
      frmConfigPagFor.btnGravar.Caption := '&OK';
      frmConfigPagFor.strConfig         := 'CONFIGCTA104';
      frmConfigPagFor.blnNaoEditar      := True;
      frmConfigPagFor.ShowModal;
      intCartei := + frmConfigPagFor.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigPagFor.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigPagFor);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmRetPagFor,frmRetPagFor);
        frmRetPagFor.pnlTopo.Caption  := 'Arquivo de Retorno - 104 - Caixa Federal';
        frmRetPagFor.strCodBco        := '104';
        frmRetPagFor.strNomBco        := 'CAIXA FEDERAL';
        frmRetPagFor.strConfig        := 'CONFIGCTA104-' + InttoStr(intCartei);
        frmRetPagFor.ShowModal;
      Finally
        FreeAndNil(frmRetPagFor);
      End;
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetSafraCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSafraCta,frmConfigSafraCta);
      frmConfigSafraCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSafraCta.btnGravar.Caption := '&OK';
      frmConfigSafraCta.blnNaoEditar      := True;
      frmConfigSafraCta.strConfig  := 'CONFIGCTA422-';
      frmConfigSafraCta.ShowModal;

      If frmConfigSafraCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSafraCta);
        Exit;
      End;
      intCartei := frmConfigSafraCta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSafraCta);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 422 - Safra';
      frmRetBco.strNomBanco            := '422 - Safra';
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIGCTA422-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.strTipGer              := 'P';  // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBanestesCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBanestesCta,frmConfigBanestesCta);
      frmConfigBanestesCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBanestesCta.btnGravar.Caption := '&OK';
      frmConfigBanestesCta.blnNaoEditar      := True;
      frmConfigBanestesCta.strConfig         := 'CONFIGCTA021-';
      frmConfigBanestesCta.ShowModal;

      If frmConfigBanestesCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBanestesCta);
        Exit;
      End;
      intCartei := frmConfigBanestesCta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBanestesCta);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 021 - Banestes';
      frmRetBco.strNomBanco            := '021 - Banestes';
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIGCTA021-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.strTipGer              := 'P';  // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBBCta' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBcoCta,frmRelRetBcoCta);
      frmRelRetBcoCta.pnlTopo.Caption  := 'Relatório de Retorno Banco - 001 - BB ';
      frmRelRetBcoCta.strNomBanco      := '001 - Banco do Brasil ';
      frmRelRetBcoCta.ShowModal;
    Finally
      FreeAndNil(frmRelRetBcoCta);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBBCtaApi' Then
    TPagForMenu.RelatorioDeDuplicatasImportadas('001', True)

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetCxFederalCta' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBcoCta,frmRelRetBcoCta);
      frmRelRetBcoCta.pnlTopo.Caption  := 'Relatório de Retorno Banco - 104 - Caixa Federal ';
      frmRelRetBcoCta.strNomBanco      := '104 - Caixa Federal ';
      frmRelRetBcoCta.ShowModal;
    Finally
      FreeAndNil(frmRelRetBcoCta);
    End;

  End
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetItauCta' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBcoCta,frmRelRetBcoCta);
      frmRelRetBcoCta.pnlTopo.Caption  := 'Relatório de Retorno Banco - 341 - Itau ';
      frmRelRetBcoCta.strNomBanco      := '341 - Itau ';
      frmRelRetBcoCta.ShowModal;
    Finally
      FreeAndNil(frmRelRetBcoCta);
    End;

  End
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetSicrediCta' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBcoCta,frmRelRetBcoCta);
      frmRelRetBcoCta.pnlTopo.Caption  := 'Relatório de Retorno Banco - 748 - Sicredi ';
      frmRelRetBcoCta.strNomBanco      := '748 - Sicredi ';
      frmRelRetBcoCta.ShowModal;
    Finally
      FreeAndNil(frmRelRetBcoCta);
    End;

  End
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetSafraCta' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBcoCta,frmRelRetBcoCta);
      frmRelRetBcoCta.pnlTopo.Caption  := 'Relatório de Retorno Banco - 422 - Safra ';
      frmRelRetBcoCta.strNomBanco      := '422 - Safra ';
      frmRelRetBcoCta.ShowModal;
    Finally
      FreeAndNil(frmRelRetBcoCta);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBanestesCta' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBcoCta,frmRelRetBcoCta);
      frmRelRetBcoCta.pnlTopo.Caption  := 'Relatório de Retorno Banco - 021 - Banestes ';
      frmRelRetBcoCta.strNomBanco      := '021 - Banestes ';
      frmRelRetBcoCta.ShowModal;
    Finally
      FreeAndNil(frmRelRetBcoCta);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupItauCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigPagFor,frmConfigPagFor);
      frmConfigPagFor.pnlTopo.Caption    := 'Selecione a carteira - 341 - Itaú';
      frmConfigPagFor.strConfig          := 'CONFIGCTA341';
      frmConfigPagFor.strCodBco          := '341';
      frmConfigPagFor.btnGravar.Caption  := '&OK';
      frmConfigPagFor.blnNaoEditar       := True;
      frmConfigPagFor.ShowModal;

      If frmConfigPagFor.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigPagFor);
        Exit;
      End;

      If Trim(frmConfigPagFor.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigPagFor.edtDiasCred.Text);

      intCartei := frmConfigPagFor.tabContas.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigPagFor);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDupContasPagar('341',intCartei);
    End;

  End
  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupSicrediCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigPagFor,frmConfigPagFor);
      frmConfigPagFor.pnlTopo.Caption    := 'Selecione a carteira - 748 - Sicredi';
      frmConfigPagFor.strConfig          := 'CONFIGCTA748';
      frmConfigPagFor.strCodBco          := '748';
      frmConfigPagFor.btnGravar.Caption  := '&OK';
      frmConfigPagFor.blnNaoEditar       := True;
      frmConfigPagFor.ShowModal;

      If frmConfigPagFor.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigPagFor);
        Exit;
      End;

      If Trim(frmConfigPagFor.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigPagFor.edtDiasCred.Text);

      intCartei := frmConfigPagFor.tabContas.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigPagFor);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDupContasPagar('748',intCartei);
    End;

  End
  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBBCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigPagFor,frmConfigPagFor);
      frmConfigPagFor.pnlTopo.Caption   := 'Selecione a carteira - 001 - Banco do Brasil';
      frmConfigPagFor.btnGravar.Caption := '&OK';
      frmConfigPagFor.strConfig         := 'CONFIGCTA001';
      frmConfigPagFor.blnNaoEditar      := True;
      frmConfigPagFor.ShowModal;

      If frmConfigPagFor.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigPagFor);
        Exit;
      End;

      If Trim(frmConfigPagFor.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigPagFor.edtDiasCred.Text);

      intCartei := frmConfigPagFor.tabContas.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigPagFor);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDupContasPagar('001', intCartei, 'CONFIGCTA001-' + InttoStr(intCartei));
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBBCtaApi' Then
  Begin
    intCartei := TPagForMenu.CarteiraParaBaixa('001', True,intDiaCred);

    If intCartei = 0 Then
      Exit;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
      pBaixaAtuDupContasPagar('001', intCartei, 'CONFIGCTAAPI001-' + InttoStr(intCartei), False, True);
  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupCxFederalCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigPagFor,frmConfigPagFor);
      frmConfigPagFor.pnlTopo.Caption   := 'Selecione a carteira - 104 - Caixa Federal';
      frmConfigPagFor.btnGravar.Caption := '&OK';
      frmConfigPagFor.strConfig         := 'CONFIGCTA104';
      frmConfigPagFor.blnNaoEditar      := True;
      frmConfigPagFor.ShowModal;

      If frmConfigPagFor.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigPagFor);
        Exit;
      End;

      If Trim(frmConfigPagFor.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigPagFor.edtDiasCred.Text);

      intCartei := frmConfigPagFor.tabContas.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigPagFor);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDupContasPagar('104', intCartei, 'CONFIGCTA104-' + InttoStr(intCartei));
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupSafraCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSafraCta,frmConfigSafraCta);
      frmConfigSafraCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSafraCta.strConfig := 'CONFIGCTA422-';
      frmConfigSafraCta.blnNaoEditar := True;
      frmConfigSafraCta.btnGravar.Caption := '&OK';
      frmConfigSafraCta.ShowModal;

      If frmConfigSafraCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSafraCta);
        Exit;
      End;

      If Trim(frmConfigSafraCta.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigSafraCta.edtDiasCred.Text);

      intCartei := frmConfigSafraCta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSafraCta);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDupContasPagar('422',intCartei);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBanestesCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBanestesCta,frmConfigBanestesCta);
      frmConfigBanestesCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBanestesCta.strConfig := 'CONFIGCTA021-';
      frmConfigBanestesCta.blnNaoEditar := True;
      frmConfigBanestesCta.btnGravar.Caption := '&OK';
      frmConfigBanestesCta.ShowModal;

      If frmConfigBanestesCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBanestesCta);
        Exit;
      End;

      intCartei := frmConfigBanestesCta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBanestesCta);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDupContasPagar('021',intCartei);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBradescoCta' Then
  Begin

    Try
      pCriarFormularios(TFrmConfigBradescoCta,frmConfigBradescoCta);
      frmConfigBradescoCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBradescoCta.btnGravar.Caption := '&OK';
      frmConfigBradescoCta.blnNaoEditar       := True;
      frmConfigBradescoCta.ShowModal;

      If frmConfigBradescoCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBradescoCta);
        Exit;
      End;

      intCartei := frmConfigBradescoCta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBradescoCta);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDupContasPagar('237',intCartei);
    End;

  End
  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupBradescoCta240' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBradescoCta240,frmConfigBradescoCta240);
      frmConfigBradescoCta240.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBradescoCta240.btnGravar.Caption := '&OK';
      frmConfigBradescoCta240.blnNaoEditar       := True;
      frmConfigBradescoCta240.ShowModal;

      If frmConfigBradescoCta240.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBradescoCta240);
        Exit;
      End;

      intCartei := frmConfigBradescoCta240.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBradescoCta240);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDupContasPagar('237_240',intCartei);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmGerDupBradescoCta' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 237 - Bradesco';
      frmGerDup.strNomBanco            := '237 - Bradesco';
      frmGerDup.strTipGer              := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmGerDup.edtDesPortador.Enabled := False;
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomForm = 'frmGerDupBradescoCta240' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 237 - Bradesco';
      frmGerDup.strNomBanco            := '237 - Bradesco';
      frmGerDup.strTipoBanco           := '240p';
      frmGerDup.strTipGer              := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmGerDup.blnMosTED              := True;

      frmGerDup.edtDesPortador.Enabled := False;
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemBradescoCta' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelCtaDuplicatas,frmRelRelCtaDuplicatas);
      frmRelRelCtaDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 237 - Bradesco';
      frmRelRelCtaDuplicatas.strNomBanco      := '237 - Bradesco';
      frmRelRelCtaDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelCtaDuplicatas);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmEstBradescoCta' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '237';
      frmEstorno.edtDesBco.Text  := 'Bradesco';
      frmEstorno.blnApenasCadPag := False;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBradescoCta' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '237';
      frmEstorno.edtDesBco.Text  := 'Bradesco';
      frmEstorno.blnApenasCadPag := True;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBradescoCta240' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '237';
      frmEstorno.edtDesBco.Text  := 'Bradesco';
      frmEstorno.blnApenasCadPag := True;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipoBanco    := '240p';
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmConfigBradescoCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBradescoCta,frmConfigBradescoCta);
      frmConfigBradescoCta.strConfig := 'CONFIGCTA237-';
      frmConfigBradescoCta.ShowModal;
    Finally
      FreeAndNil(frmConfigBradescoCta);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemBradescoCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBradescoCta,frmConfigBradescoCta);
      frmConfigBradescoCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBradescoCta.btnGravar.Caption := '&OK';
      frmConfigBradescoCta.blnNaoEditar       := True;
      frmConfigBradescoCta.ShowModal;

      If frmConfigBradescoCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBradescoCta);
        Exit;
      End;

      intCartei := frmConfigBradescoCta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBradescoCta);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemBradescoCta,frmExpArqRemBradescoCta);
      frmExpArqRemBradescoCta.intCartei  := intCartei;
      frmExpArqRemBradescoCta.strNomForm := 'frmConfigBradescoCta';
      frmExpArqRemBradescoCta.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemBradescoCta);
    End;

  End
  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBradescoCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBradescoCta,frmConfigBradescoCta);
      frmConfigBradescoCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBradescoCta.btnGravar.Caption := '&OK';
      frmConfigBradescoCta.blnNaoEditar       := True;
      frmConfigBradescoCta.ShowModal;

      If frmConfigBradescoCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBradescoCta);
        Exit;
      End;

      intCartei := frmConfigBradescoCta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBradescoCta);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 237 - Bradesco';
      frmRetBco.strNomBanco            := '237 - Bradesco';
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIGCTA237-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.strTipGer              := 'P';  // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End
  Else If arrMenu[intIndex].strNomForm = 'frmArqRetBradescoCta240' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBradescoCta240,frmConfigBradescoCta240);
      frmConfigBradescoCta240.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBradescoCta240.btnGravar.Caption := '&OK';
      frmConfigBradescoCta240.blnNaoEditar       := True;
      frmConfigBradescoCta240.ShowModal;

      If frmConfigBradescoCta240.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBradescoCta240);
        Exit;
      End;

      intCartei := frmConfigBradescoCta240.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBradescoCta240);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 237 - Bradesco';
      frmRetBco.strNomBanco            := '237 - Bradesco';
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIGCTA237_240p-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.strTipGer              := 'P';  // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;

  End
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBradescoCta' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBcoCta,frmRelRetBcoCta);
      frmRelRetBcoCta.pnlTopo.Caption  := 'Relatório de Retorno Banco - 237 - Bradesco ';
      frmRelRetBcoCta.strNomBanco      := '237 - Bradesco ';
      frmRelRetBcoCta.ShowModal;
    Finally
      FreeAndNil(frmRelRetBcoCta);
    End;

  End
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetBradescoCta240' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBcoCta,frmRelRetBcoCta);
      frmRelRetBcoCta.pnlTopo.Caption  := 'Relatório de Retorno Banco - 237 - Bradesco ';
      frmRelRetBcoCta.strNomBanco      := '237 - Bradesco ';
      frmRelRetBcoCta.ShowModal;
    Finally
      FreeAndNil(frmRelRetBcoCta);
    End;

  End

  Else If arrMenu[intIndex].strNomForm = 'frmBaixaAtuDupBradescoCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigBradescoCta,frmConfigBradescoCta);
      frmConfigBradescoCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBradescoCta.btnGravar.Caption := '&OK';
      frmConfigBradescoCta.blnNaoEditar       := True;
      frmConfigBradescoCta.ShowModal;

      If frmConfigBradescoCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBradescoCta);
        Exit;
      End;

      intCartei := frmConfigBradescoCta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBradescoCta);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDupContasPagar('237',intCartei);
    End;

  End

  {*************************************************}
  {* SELEÇÃO DE DUPLICATAS PARA SERASA             *}
  {**********************************************JU*}
  Else If arrMenu[intIndex].strNomForm = 'frmGeraArqSerasaCon' Then
  Begin
    Try
      pCriarFormularios(TfrmGeraArqSerasaCon, frmGeraArqSerasaCon);
      frmGeraArqSerasaCon.Caption := 'Gerar Arquivo de Conciliação (Serasa)';
      frmGeraArqSerasaCon.ShowModal;
    Finally
      FreeAndNil(frmGeraArqSerasaCon);
    End;
  End

  {*******************************************}
  { GERAÇÃO DE ARQUIVO PARA SERASA            }
  {****************************************JU*}
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmExpArqSer' Then
    pCriarForm(TfrmExpArqSer, frmExpArqSer)

  {*********************************}
  {* RETORNO SERASA                *}
  {******************************JU*}

  Else If arrMenu[intIndex].strNomForm = 'frmGeraArqSerasa' Then
  Begin
    Try
      pCriarFormularios(TfrmGeraArqSerasa, frmGeraArqSerasa);
      frmGeraArqSerasa.Caption := 'Gerar Arquivo (Serasa)';
      frmGeraArqSerasa.ShowModal;
    Finally
      FreeAndNil(frmGeraArqSerasa);
    End;
  End

  {*************************************************}
  {* GERACAO DE ARQUIVO PARA SERASA                *}
  {**********************************************PH*}

  Else If arrMenu[intIndex].strNomForm = 'frmProcArqSerasa' Then
  Begin
    Try
      pCriarFormularios(TfrmProcArqSerasa,frmProcArqSerasa);
      frmProcArqSerasa.Caption := 'Processa Arquivo de Retorno (Serasa)';
      frmProcArqSerasa.ShowModal;
    Finally
      FreeAndNil(frmProcArqSerasa);
    End;
  End

  {*************************************************}
  {* CANCELAMENTO DUPLICATAS REMESSA (SERASA)      *}
  {***********************************************PB}

  Else If arrMenu[intIndex].strNomform = 'frmEstSerasa' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := 'SER';
      frmEstorno.edtDesBco.Text  := 'Serasa';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  {******************************************************}
  {* CANCELAMENTO DUPLICATAS ENVIADAS P/ BANCO (SERASA) *}
  {****************************************************PB}

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvSerasa' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := 'SER';
      frmEstorno.edtDesBco.Text  := 'Serasa';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End







  {***********************************}
  {* GERAÇÃO DE DUPLICATAS BOA VISTA *}
  {********************************AJ*}
  Else If arrMenu[intIndex].strNomForm = 'frmGeraArqBoaVista' Then
  Begin
    Try
      pCriarFormularios(TfrmGeraArqSerasa, frmGeraArqSerasa);
      frmGeraArqSerasa.pnlTopo.Caption := 'Seleção de Registros (Boa Vista)';
       frmGeraArqSerasa.strNomAdm      := 'BOA VISTA';
      frmGeraArqSerasa.ShowModal;
    Finally
      FreeAndNil(frmGeraArqSerasa);
    End;
  End

  {***********************************************}
  {* CANCELAMENTO DUPLICATAS REMESSA (BOA VISTA) *}
  {********************************************AJ*}

  Else If arrMenu[intIndex].strNomform = 'frmEstBoaVista' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := 'BOA';
      frmEstorno.edtDesBco.Text  := 'Boa Vista';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  {*********************************************}
  { EXPORTAÇÃO DE ARQUIVO DE REMESSA BOA VISTA *}
  {******************************************AJ*}
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmExpArqBoaVista' Then
  Begin
    Try
      pCriarFormularios(TfrmExpArqSer, frmExpArqSer);
      frmExpArqSer.strCodBco       := 'BOA';
      frmExpArqSer.pnlTopo.Caption := 'Geração de Arquivo para BOA VISTA';
      frmExpArqSer.ShowModal;
    Finally
      FreeAndNil(frmExpArqSer);
    End;
  End

  {***************************************************}
  {* IMPORTAÇÃO DE ARQUIVO de RETORNO PARA BOA VISTA *}
  {************************************************AJ*}
  Else If arrMenu[intIndex].strNomForm = 'frmProcArqBoaVista' Then
  Begin
    Try
      pCriarFormularios(TfrmProcArqSerasa,frmProcArqSerasa);
      frmProcArqSerasa.pnlTopo.Caption := 'Processa Arquivo de Retorno (Boa Vista)';
      frmProcArqSerasa.ShowModal;
    Finally
      FreeAndNil(frmProcArqSerasa);
    End;
  End

  {*************************************************}
  {* CANCELAMENTO DUPLICATAS ENVIADAS P/ BOA VISTA *}
  {**********************************************AJ*}
  Else If arrMenu[intIndex].strNomform = 'frmEstEnvBoaVista' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := 'BOA';
      frmEstorno.edtDesBco.Text  := 'Boa Vista';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End


  {*************************************************}
  {* CANCELAMENTO DUPLICATAS REMESSA (SERASA)      *}
  {***********************************************PB}

  Else If arrMenu[intIndex].strNomform = 'frmEstSerasa' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := 'SER';
      frmEstorno.edtDesBco.Text  := 'Serasa';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  {******************************************************}
  {* CANCELAMENTO DUPLICATAS ENVIADAS P/ BANCO (SERASA) *}
  {****************************************************PB}

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvSerasa' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := 'SER';
      frmEstorno.edtDesBco.Text  := 'Serasa';
      frmEstorno.blnApenasCadRec := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  {*******************************************}
  {* GERACAO DE ARQUIVO DE COBRANÇA JUDICIAL *}
  {****************************************MO*}
  Else
  If arrMenu[intIndex].strNomForm = 'frmGerDupCob' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDupCob,frmGerDupCob);
      frmGerDupCob.pnlTopo.Caption := 'Geração de Duplicatas - Global Cobrança Judicial';
      frmGerDupCob.ShowModal;
    Finally
      FreeAndNil(frmGerDupCob);
    End;
  End

  {**********************************}
  {* RELATÓRIO DE COBRANÇA JUDICIAL *}
  {*******************************MO*}
  Else
  If arrMenu[intIndex].strNomForm = 'frmRelCobJudicial' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption   := 'Relação de Duplicatas - Global Cobrança Judicial';
      frmRelRelDuplicatas.ckbQbrEmp.Visible := False;
      frmRelRelDuplicatas.strNomBanco       := 'GLOBAL Cobrança Judicial';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End

  {****************************************}
  {* EXPORTA REMESSA DE COBRANÇA JUDICIAL *}
  {*************************************MO*}
  Else
  If arrMenu[intIndex].strNomForm = 'frmExpArqCobJudicial' Then
  Begin
    Try
      pCriarFormularios(TfrmExpArqCobJudicial,frmExpArqCobJudicial);
      frmExpArqCobJudicial.pnlTopo.Caption        := 'Exportação de Cobrança Judicial';
      frmExpArqCobJudicial.ShowModal;
    Finally
      FreeAndNil(frmExpArqCobJudicial);
    End;
  End

  {**************************************}
  {* CONFIGURAÇÕES PARA SPC - BRASIL    *}
  {***********************************MO*}
  Else If arrMenu[intIndex].strNomForm = 'frmConfigSPC' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigSPC, frmConfigSPC);
      frmConfigSPC.ShowModal;
    Finally
      FreeAndNil(frmConfigSPC);
    End;
  End

  {*************************************************}
  {* SELECAO DE DUPLICATA PARA SPC - BRASIL        *}
  {**********************************************MO*}
  Else If arrMenu[intIndex].strNomForm = 'frmGeraArqSPC' Then
  Begin
    Try
      pCriarFormularios(TfrmGeraArqSPC, frmGeraArqSPC);
      frmGeraArqSPC.Caption := 'Gerar Arquivo (SPC - Brasil)';
      frmGeraArqSPC.ShowModal;
    Finally
      FreeAndNil(frmGeraArqSPC);
    End;
  End

  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemSPC' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption   := 'Relação de Duplicatas - SPC Brasil';
      frmRelRelDuplicatas.ckbQbrEmp.Visible := False;
      frmRelRelDuplicatas.strNomBanco       := 'SPC Brasil';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstSPC' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := 'SPC';
      frmEstorno.edtDesBco.Text  := 'Brasil';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[intIndex].strNomform = 'frmEstEnvSPC' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := 'SPC';
      frmEstorno.edtDesBco.Text  := 'Brasil';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.blnEstEnvSPC    := True;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End

  {*******************************************}
  { PROCESSA ARQUIVO RETORNO SPC - BRASIL     }
  {****************************************MO*}
  Else
  If arrMenu[intIndex].strNomform = 'frmProcArqSPC' Then
  begin
    pCriarForm(TfrmProcArqSPC, frmProcArqSPC);
  end

  {*******************************************}
  { GERAÇÃO DE ARQUIVO PARA SPC - BRASIL      }
  {****************************************MO*}
  Else
  If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomForm = 'frmExpArqSPC' Then
  begin
    if fEmptyStr(fGetBancoConfig(0, 'CONFIGSPC', 'CODENTI', '')) then
    begin
      fMensagem('ATENÇÃO!', 'Você deve configurar o campo: Código da Entidade na aba Configurar!', ['&O K ']);
      Exit;
    end
    else
    if fEmptyStr(fGetBancoConfig(0, 'CONFIGSPC', 'CODASSO', '')) then
    begin
      fMensagem('ATENÇÃO!', 'Você deve configurar o campo: Código do Associado na aba Configurar!', ['&O K ']);
      Exit;
    end
    else
    if fEmptyStr(fGetBancoConfig(0, 'CONFIGSPC', 'PROXNUM', '')) then
    begin
      fMensagem('ATENÇÃO!', 'Você deve configurar o campo: Próximo Núm. Seq. Arq. Remessa na aba Configurar!', ['&O K ']);
      Exit;
    end
    else
    if fEmptyStr(fGetBancoConfig(0, 'CONFIGSPC', 'MOTISPC', '')) then
    begin
      fMensagem('ATENÇÃO!', 'Você deve configurar o campo: Motivo da Exclusão na aba Configurar!', ['&O K ']);
      Exit;
    end
    else
      pCriarForm(TfrmExpArqSPC, frmExpArqSPC)
  end

  {****************}
  {* SERASA PEFIN *}
  {*************JU*}
  Else If arrMenu[intIndex].strNomForm = 'frmGeraArqSerasaPEFIN' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigBrasil7d,frmConfigBrasil7d);
      frmConfigBrasil7d.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBrasil7d.btnGravar.Caption := '&OK';
      frmConfigBrasil7d.blnPeFin := True;
      frmConfigBrasil7d.blnNaoEditar := Not fEmptyStr(fGetBancoConfig(0,'PEFIN','SEQARQ',''));
      frmConfigBrasil7d.ShowModal;

      If frmConfigBrasil7d.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBrasil7d);
        Exit;
      End;

      intCartei := frmConfigBrasil7d.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBrasil7d);
    End;

    Try
      pCriarFormularios(TfrmGeraArqSerasaPEFIN, frmGeraArqSerasaPEFIN);
      frmGeraArqSerasaPEFIN.Caption  := 'Gerar Arquivo (Serasa - PEFIN)';
      frmGeraArqSerasaPEFIN.intCartei:= intCartei;
      frmGeraArqSerasaPEFIN.ShowModal;
    Finally
      FreeAndNil(frmGeraArqSerasaPEFIN);
    End;
  End
  Else  If arrMenu[intIndex].strNomForm = 'frmProcArqSerasaPEFIN' Then
  Begin
    Try
      pCriarFormularios(TfrmProcArqSerasaPEFIN,frmProcArqSerasaPEFIN);
      frmProcArqSerasaPEFIN.Caption := 'Processa Arquivo de Retorno (Serasa - PEFIN)';
      frmProcArqSerasaPEFIN.ShowModal;
    Finally
      FreeAndNil(frmProcArqSerasaPEFIN);
    End;
  End

  {****************************}
  {* CONTAS A PAGAR SANTANDER *}
  {*************************JU*}
  Else If arrMenu[intIndex].strNomform = 'frmConfigSantanderCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSantanderCta,frmConfigSantanderCta);
      frmConfigSantanderCta.strConfig := 'CONFIGCTA033-';
      frmConfigSantanderCta.ShowModal;
    Finally
      FreeAndNil(frmConfigSantanderCta);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmRelDupRemSantanderCta' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRelCtaDuplicatas,frmRelRelCtaDuplicatas);
      frmRelRelCtaDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 033 - Santander';
      frmRelRelCtaDuplicatas.strNomBanco      := '033 - Santander';
      frmRelRelCtaDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelCtaDuplicatas);
    End;

  End
  Else If arrMenu[intIndex].strNomForm = 'frmGerDupSantanderCta' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 033 - Santander';
      frmGerDup.strNomBanco            := '033 - Santander';
      frmGerDup.strTipGer              := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmGerDup.edtDesPortador.Enabled := False;
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End
  Else If arrMenu[intIndex].strNomform = 'frmEstSantanderCta' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '033';
      frmEstorno.edtDesBco.Text  := 'Santander';
      frmEstorno.blnApenasCadPag := False;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End
  Else If arrMenu[intIndex].strNomForm = 'frmArqRetSantanderCta' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigSantanderCta,frmConfigSantanderCta);
      frmConfigSantanderCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSantanderCta.btnGravar.Caption := '&OK';
      frmConfigSantanderCta.blnNaoEditar       := True;
      frmConfigSantanderCta.ShowModal;

      If frmConfigSantanderCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSantanderCta);
        Exit;
      End;

      intCartei := frmConfigSantanderCta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSantanderCta);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 033 - Santander';
      frmRetBco.strNomBanco            := '033 - Santander';
      frmRetBco.fraPathRetornoBco.edtDirectory.text := fGetBancoConfig(0, 'CONFIGCTA033-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.strTipGer              := 'P';  // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End
  Else If arrMenu[intIndex].strNomForm = 'frmRelArqRetSantanderCta' Then
  Begin

    Try
      pCriarFormularios(TfrmRelRetBcoCta,frmRelRetBcoCta);
      frmRelRetBcoCta.pnlTopo.Caption  := 'Relatório de Retorno Banco - 033 - Santander ';
      frmRelRetBcoCta.strNomBanco      := '033 - Santander ';
      frmRelRetBcoCta.ShowModal;
    Finally
      FreeAndNil(frmRelRetBcoCta);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmExpArqRemSantanderCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSantanderCta,frmConfigSantanderCta);
      frmConfigSantanderCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSantanderCta.btnGravar.Caption := '&OK';
      frmConfigSantanderCta.blnNaoEditar       := True;
      frmConfigSantanderCta.ShowModal;

      If frmConfigSantanderCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSantanderCta);
        Exit;
      End;

      intCartei := frmConfigSantanderCta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSantanderCta);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemSantanderCta,frmExpArqRemSantanderCta);
      frmExpArqRemSantanderCta.intCartei  := intCartei;
      frmExpArqRemSantanderCta.strNomForm := 'frmConfigSantanderCta';
      frmExpArqRemSantanderCta.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemSantanderCta);
    End;

  End
  Else If arrMenu[intIndex].strNomform = 'frmEstEnvSantanderCta' Then
  Begin

    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '033';
      frmEstorno.edtDesBco.Text  := 'Santander';
      frmEstorno.blnApenasCadPag := True;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End
  Else If arrMenu[intIndex].strNomForm = 'frmBaiAutDupSantanderCta' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigSantanderCta,frmConfigSantanderCta);
      frmConfigSantanderCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSantanderCta.btnGravar.Caption := '&OK';
      frmConfigSantanderCta.blnNaoEditar       := True;
      frmConfigSantanderCta.ShowModal;

      If frmConfigSantanderCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSantanderCta);
        Exit;
      End;

      If Trim(frmConfigSantanderCta.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigSantanderCta.edtDiasCred.Text);

      intCartei := frmConfigSantanderCta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigSantanderCta);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDupContasPagar('033',intCartei);
    End;

  {*************************}
  {* CONFIGURAÇÃO DDA      *}
  {**********************AJ*}
  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigCtaDDAItau' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption  := 'Configurações DDA - 341 - Itaú';
      frmConfigCtaDDA.strConfig        := 'CONFIGDDA341';
      frmConfigCtaDDA.strCodBco        := '341';
      frmConfigCtaDDA.ShowModal;
    Finally
      FreeAndNil(frmConfigCtaDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigCtaDDABradesco' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption  := 'Configurações DDA - 237 - Bradesco';
      frmConfigCtaDDA.strConfig        := 'CONFIGDDA237';
      frmConfigCtaDDA.strCodBco        := '237';
      frmConfigCtaDDA.ShowModal;
    Finally
      FreeAndNil(frmConfigCtaDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigCtaDDABradesco240' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption  := 'Configurações DDA - 237 - Bradesco [240p]';
      frmConfigCtaDDA.strConfig        := 'CONFIGDDA237_240';
      frmConfigCtaDDA.strCodBco        := '237';
      frmConfigCtaDDA.ShowModal;
    Finally
      FreeAndNil(frmConfigCtaDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigCtaDDASantander' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption  := 'Configurações DDA - 033 - Santander';
      frmConfigCtaDDA.strCodBco        := '033';
      frmConfigCtaDDA.strConfig        := 'CONFIGDDA033';
      frmConfigCtaDDA.ShowModal;
    Finally
      FreeAndNil(frmConfigCtaDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigCtaDDACEF' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption  := 'Configurações DDA - 104 - Caixa Econômica Federal';
      frmConfigCtaDDA.strCodBco        := '104';
      frmConfigCtaDDA.strConfig        := 'CONFIGDDA104';
      frmConfigCtaDDA.ShowModal;
    Finally
      FreeAndNil(frmConfigCtaDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigCtaDDABB' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption  := 'Configurações DDA - 001 - Banco do Brasil';
      frmConfigCtaDDA.strCodBco        := '001';
      frmConfigCtaDDA.strConfig        := 'CONFIGDDA001';
      frmConfigCtaDDA.ShowModal;
    Finally
      FreeAndNil(frmConfigCtaDDA);
    End;


  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigCtaDDABanrisul' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption  := 'Configurações DDA - 041 - Banrisul';
      frmConfigCtaDDA.strCodBco        := '041';
      frmConfigCtaDDA.strConfig        := 'CONFIGDDA041';
      frmConfigCtaDDA.ShowModal;
    Finally
      FreeAndNil(frmConfigCtaDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigCtaDDASicredi' Then
  Begin

    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption  := 'Configurações DDA - 748 - Sicredi';
      frmConfigCtaDDA.strCodBco        := '748';
      frmConfigCtaDDA.strConfig        := 'CONFIGDDA748';
      frmConfigCtaDDA.ShowModal;
    Finally
      FreeAndNil(frmConfigCtaDDA);
    End;

  {*************************}
  {* IMPORTAÇÃO DDA        *}
  {**********************AJ*}
  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaImpDDAItau' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption   := 'Selecione a Conta DDA - 341 - Itaú';
      frmConfigCtaDDA.btnGravar.Caption := '&OK';
      frmConfigCtaDDA.strConfig         := 'CONFIGDDA341';
      frmConfigCtaDDA.blnNaoEditar      := True;
      frmConfigCtaDDA.ShowModal;
      intCartei := + frmConfigCtaDDA.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigCtaDDA.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigCtaDDA);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmCtaImpDDA,frmCtaImpDDA);
        frmCtaImpDDA.pnlTopo.Caption  := 'Importação de Arquivos - DDA - 341 - Itaú';
        frmCtaImpDDA.strConfig        := 'CONFIGDDA341-' + InttoStr(intCartei);
        frmCtaImpDDA.strCodBco        := '341';
        frmCtaImpDDA.ShowModal;
      Finally
        FreeAndNil(frmCtaImpDDA);
      End;
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaImpDDABradesco' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption  := 'Selecione a Conta DDA - 237 - Bradesco';
      frmConfigCtaDDA.btnGravar.Caption := '&OK';
      frmConfigCtaDDA.strConfig        := 'CONFIGDDA237';
      frmConfigCtaDDA.blnNaoEditar := true;
      frmConfigCtaDDA.ShowModal;
      intCartei := + frmConfigCtaDDA.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigCtaDDA.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigCtaDDA);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmCtaImpDDA,frmCtaImpDDA);
        frmCtaImpDDA.pnlTopo.Caption  := 'Importação de Arquivos - DDA - 237 - Bradesco';
        frmCtaImpDDA.strConfig        := 'CONFIGDDA237-' + InttoStr(intCartei);
        frmCtaImpDDA.strCodBco        := '237';
        frmCtaImpDDA.ShowModal;
      Finally
        FreeAndNil(frmCtaImpDDA);
      End;
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaImpDDABradesco240' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption   := 'Selecione a Conta DDA - 237 - Bradesco [240p]';
      frmConfigCtaDDA.btnGravar.Caption := '&OK';
      frmConfigCtaDDA.strConfig         := 'CONFIGDDA237_240';
      frmConfigCtaDDA.blnNaoEditar      := true;
      frmConfigCtaDDA.ShowModal;
      intCartei := + frmConfigCtaDDA.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigCtaDDA.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigCtaDDA);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmCtaImpDDA,frmCtaImpDDA);
        frmCtaImpDDA.pnlTopo.Caption  := 'Importação de Arquivos - DDA - 237 - Bradesco [240p]';
        frmCtaImpDDA.strConfig        := 'CONFIGDDA237_240-' + InttoStr(intCartei);
        frmCtaImpDDA.strCodBco        := '237_240';
        frmCtaImpDDA.ShowModal;
      Finally
        FreeAndNil(frmCtaImpDDA);
      End;
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaImpDDASantander' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption  := 'Selecione a Conta DDA - 033 - Santander';
      frmConfigCtaDDA.btnGravar.Caption := '&OK';
      frmConfigCtaDDA.strConfig        := 'CONFIGDDA033';
      frmConfigCtaDDA.blnNaoEditar := true;
      frmConfigCtaDDA.ShowModal;
      intCartei := + frmConfigCtaDDA.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigCtaDDA.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigCtaDDA);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmCtaImpDDA,frmCtaImpDDA);
        frmCtaImpDDA.pnlTopo.Caption  := 'Importação de Arquivos - DDA - 033 - Santander';
        frmCtaImpDDA.strConfig        := 'CONFIGDDA033-' + InttoStr(intCartei);
        frmCtaImpDDA.strCodBco        := '033';
        frmCtaImpDDA.ShowModal;
      Finally
        FreeAndNil(frmCtaImpDDA);
      End;
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaImpDDACEF' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption  := 'Selecione a Conta DDA - 104 - Caixa Econômica Federal';
      frmConfigCtaDDA.btnGravar.Caption := '&OK';
      frmConfigCtaDDA.strConfig        := 'CONFIGDDA104';
      frmConfigCtaDDA.blnNaoEditar := true;
      frmConfigCtaDDA.ShowModal;
      intCartei := + frmConfigCtaDDA.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigCtaDDA.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigCtaDDA);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmCtaImpDDA,frmCtaImpDDA);
        frmCtaImpDDA.pnlTopo.Caption  := 'Importação de Arquivos - DDA - 104 - Caixa Econômica Federal';
        frmCtaImpDDA.strConfig        := 'CONFIGDDA104-' + InttoStr(intCartei);
        frmCtaImpDDA.strCodBco        := '104';
        frmCtaImpDDA.ShowModal;
      Finally
        FreeAndNil(frmCtaImpDDA);
      End;
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaImpDDABB' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption   := 'Selecione a Conta DDA - 001 - Banco do Brasil';
      frmConfigCtaDDA.btnGravar.Caption := '&OK';
      frmConfigCtaDDA.strConfig         := 'CONFIGDDA001';
      frmConfigCtaDDA.blnNaoEditar      := True;
      frmConfigCtaDDA.ShowModal;
      intCartei := + frmConfigCtaDDA.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigCtaDDA.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigCtaDDA);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmCtaImpDDA,frmCtaImpDDA);
        frmCtaImpDDA.pnlTopo.Caption  := 'Importação de Arquivos - DDA - 001 - Banco do Brasil';
        frmCtaImpDDA.strConfig        := 'CONFIGDDA001-' + InttoStr(intCartei);
        frmCtaImpDDA.strCodBco        := '001';
        frmCtaImpDDA.ShowModal;
      Finally
        FreeAndNil(frmCtaImpDDA);
      End;
    End;


  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaImpDDABanrisul' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption   := 'Selecione a Conta DDA - 041 - Banrisul';
      frmConfigCtaDDA.btnGravar.Caption := '&OK';
      frmConfigCtaDDA.strConfig         := 'CONFIGDDA041';
      frmConfigCtaDDA.blnNaoEditar      := True;
      frmConfigCtaDDA.ShowModal;
      intCartei := + frmConfigCtaDDA.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigCtaDDA.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigCtaDDA);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmCtaImpDDA,frmCtaImpDDA);
        frmCtaImpDDA.pnlTopo.Caption  := 'Importação de Arquivos - DDA - 041 - Banrisul';
        frmCtaImpDDA.strConfig        := 'CONFIGDDA041-' + InttoStr(intCartei);
        frmCtaImpDDA.strCodBco        := '041';
        frmCtaImpDDA.ShowModal;
      Finally
        FreeAndNil(frmCtaImpDDA);
      End;
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaImpDDASicredi' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption   := 'Selecione a Conta DDA - 748 - Sicredi';
      frmConfigCtaDDA.btnGravar.Caption := '&OK';
      frmConfigCtaDDA.strConfig         := 'CONFIGDDA748';
      frmConfigCtaDDA.blnNaoEditar      := True;
      frmConfigCtaDDA.ShowModal;
      intCartei := + frmConfigCtaDDA.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigCtaDDA.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigCtaDDA);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmCtaImpDDA,frmCtaImpDDA);
        frmCtaImpDDA.pnlTopo.Caption  := 'Importação de Arquivos - DDA - 748 - Sicredi';
        frmCtaImpDDA.strConfig        := 'CONFIGDDA748-' + InttoStr(intCartei);
        frmCtaImpDDA.strCodBco        := '748';
        frmCtaImpDDA.ShowModal;
      Finally
        FreeAndNil(frmCtaImpDDA);
      End;
    End;

  {*************************}
  {* RELATÓRIO CTA DDA     *}
  {**********************AJ*}
  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaRelDupDDAItau' Then
  Begin

    Try
      pCriarFormularios(TfrmCtaRelDupDDA,frmCtaRelDupDDA);
      frmCtaRelDupDDA.pnlTopo.Caption  := 'Relatório de Arq. Retorno DDA - 341 - Itaú';
      frmCtaRelDupDDA.strConfig        := 'CONFIGDDA341';
      frmCtaRelDupDDA.ShowModal;
    Finally
      FreeAndNil(frmCtaRelDupDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaRelDupDDABradesco' Then
  Begin

    Try
      pCriarFormularios(TfrmCtaRelDupDDA,frmCtaRelDupDDA);
      frmCtaRelDupDDA.pnlTopo.Caption  := 'Relatório de Arq. Retorno DDA - 237 - Bradesco';
      frmCtaRelDupDDA.strConfig        := 'CONFIGDDA237';
      frmCtaRelDupDDA.ShowModal;
    Finally
      FreeAndNil(frmCtaRelDupDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaRelDupDDABradesco240' Then
  Begin

    Try
      pCriarFormularios(TfrmCtaRelDupDDA,frmCtaRelDupDDA);
      frmCtaRelDupDDA.pnlTopo.Caption  := 'Relatório de Arq. Retorno DDA - 237 - Bradesco [240p]';
      frmCtaRelDupDDA.strConfig        := 'CONFIGDDA237_240';
      frmCtaRelDupDDA.ShowModal;
    Finally
      FreeAndNil(frmCtaRelDupDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaRelDupDDASantander' Then
  Begin

    Try
      pCriarFormularios(TfrmCtaRelDupDDA,frmCtaRelDupDDA);
      frmCtaRelDupDDA.pnlTopo.Caption  := 'Relatório de Arq. Retorno DDA - 033 - Santander';
      frmCtaRelDupDDA.strConfig        := 'CONFIGDDA033';
      frmCtaRelDupDDA.ShowModal;
    Finally
      FreeAndNil(frmCtaRelDupDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaRelDupDDACEF' Then
  Begin

    Try
      pCriarFormularios(TfrmCtaRelDupDDA,frmCtaRelDupDDA);
      frmCtaRelDupDDA.pnlTopo.Caption  := 'Relatório de Arq. Retorno DDA - 104 - Caixa Econômica Federal';
      frmCtaRelDupDDA.strConfig        := 'CONFIGDDA104';
      frmCtaRelDupDDA.ShowModal;
    Finally
      FreeAndNil(frmCtaRelDupDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaRelDupDDABB' Then
  Begin

    Try
      pCriarFormularios(TfrmCtaRelDupDDA,frmCtaRelDupDDA);
      frmCtaRelDupDDA.pnlTopo.Caption  := 'Relatório de Arq. Retorno DDA - 001 - Banco do Brasil';
      frmCtaRelDupDDA.strConfig        := 'CONFIGDDA001';
      frmCtaRelDupDDA.ShowModal;
    Finally
      FreeAndNil(frmCtaRelDupDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaRelDupDDABanrisul' Then
  Begin

    Try
      pCriarFormularios(TfrmCtaRelDupDDA,frmCtaRelDupDDA);
      frmCtaRelDupDDA.pnlTopo.Caption  := 'Relatório de Arq. Retorno DDA - 041 - Banrisul';
      frmCtaRelDupDDA.strConfig        := 'CONFIGDDA041';
      frmCtaRelDupDDA.ShowModal;
    Finally
      FreeAndNil(frmCtaRelDupDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaRelDupDDASicredi' Then
  Begin

    Try
      pCriarFormularios(TfrmCtaRelDupDDA,frmCtaRelDupDDA);
      frmCtaRelDupDDA.pnlTopo.Caption  := 'Relatório de Arq. Retorno DDA - 748 - Sicredi';
      frmCtaRelDupDDA.strConfig        := 'CONFIGDDA748';
      frmCtaRelDupDDA.ShowModal;
    Finally
      FreeAndNil(frmCtaRelDupDDA);
    End;

  {*************************}
  {* ATUALIZAR CTA DDA     *}
  {**********************AJ*}
  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaAtuDupDDAItau' Then
  Begin

    Try
      pCriarFormularios(TfrmCtaAtuDupDDA,frmCtaAtuDupDDA);
      frmCtaAtuDupDDA.pnlTopo.Caption  := 'Atualização de Dados de Duplicatas Encontradas DDA - 341 - Itaú';
      frmCtaAtuDupDDA.strConfig        := 'CONFIGDDA341';
      frmCtaAtuDupDDA.strCodBco        := '341';
      frmCtaAtuDupDDA.ShowModal;
    Finally
      FreeAndNil(frmCtaAtuDupDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaAtuDupDDABradesco' Then
  Begin

    Try
      pCriarFormularios(TfrmCtaAtuDupDDA,frmCtaAtuDupDDA);
      frmCtaAtuDupDDA.pnlTopo.Caption  := 'Atualização de Dados de Duplicatas Encontradas DDA - 237 - Bradesco';
      frmCtaAtuDupDDA.strConfig        := 'CONFIGDDA237';
      frmCtaAtuDupDDA.strCodBco        := '237';
      frmCtaAtuDupDDA.ShowModal;
    Finally
      FreeAndNil(frmCtaAtuDupDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaAtuDupDDABradesco240' Then
  Begin

    Try
      pCriarFormularios(TfrmCtaAtuDupDDA,frmCtaAtuDupDDA);
      frmCtaAtuDupDDA.pnlTopo.Caption  := 'Atualização de Dados de Duplicatas Encontradas DDA - 237 - Bradesco [240p]';
      frmCtaAtuDupDDA.strConfig        := 'CONFIGDDA237';
      frmCtaAtuDupDDA.strCodBco        := '237_240';
      frmCtaAtuDupDDA.ShowModal;
    Finally
      FreeAndNil(frmCtaAtuDupDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaAtuDupDDASantander' Then
  Begin

    Try
      pCriarFormularios(TfrmCtaAtuDupDDA,frmCtaAtuDupDDA);
      frmCtaAtuDupDDA.pnlTopo.Caption  := 'Atualização de Dados de Duplicatas Encontradas DDA - 033 - Santander';
      frmCtaAtuDupDDA.strConfig        := 'CONFIGDDA033';
      frmCtaAtuDupDDA.strCodBco        := '033';
      frmCtaAtuDupDDA.ShowModal;
    Finally
      FreeAndNil(frmCtaAtuDupDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaAtuDupDDACEF' Then
  Begin

    Try
      pCriarFormularios(TfrmCtaAtuDupDDA,frmCtaAtuDupDDA);
      frmCtaAtuDupDDA.pnlTopo.Caption  := 'Atualização de Dados de Duplicatas Encontradas DDA - 104 - Caixa Econômica Federal';
      frmCtaAtuDupDDA.strConfig        := 'CONFIGDDA104';
      frmCtaAtuDupDDA.strCodBco        := '104';
      frmCtaAtuDupDDA.ShowModal;
    Finally
      FreeAndNil(frmCtaAtuDupDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaAtuDupDDABB' Then
  Begin

    Try
      pCriarFormularios(TfrmCtaAtuDupDDA,frmCtaAtuDupDDA);
      frmCtaAtuDupDDA.pnlTopo.Caption  := 'Atualização de Dados de Duplicatas Encontradas DDA - 001 - Banco do Brasil';
      frmCtaAtuDupDDA.strConfig        := 'CONFIGDDA001';
      frmCtaAtuDupDDA.strCodBco        := '001';
      frmCtaAtuDupDDA.ShowModal;
    Finally
      FreeAndNil(frmCtaAtuDupDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaAtuDupDDABanrisul' Then
  Begin

    Try
      pCriarFormularios(TfrmCtaAtuDupDDA,frmCtaAtuDupDDA);
      frmCtaAtuDupDDA.pnlTopo.Caption  := 'Atualização de Dados de Duplicatas Encontradas DDA - 041 - Banrisul';
      frmCtaAtuDupDDA.strConfig        := 'CONFIGDDA041';
      frmCtaAtuDupDDA.strCodBco        := '041';
      frmCtaAtuDupDDA.ShowModal;
    Finally
      FreeAndNil(frmCtaAtuDupDDA);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaAtuDupDDASicredi' Then
  Begin

    Try
      pCriarFormularios(TfrmCtaAtuDupDDA,frmCtaAtuDupDDA);
      frmCtaAtuDupDDA.pnlTopo.Caption  := 'Atualização de Dados de Duplicatas Encontradas DDA - 748 - Sicredi';
      frmCtaAtuDupDDA.strConfig        := 'CONFIGDDA748';
      frmCtaAtuDupDDA.strCodBco        := '748';
      frmCtaAtuDupDDA.ShowModal;
    Finally
      FreeAndNil(frmCtaAtuDupDDA);
    End;

  {*************************}
  {* CADASTRAR CTA DDA     *}
  {**********************AJ*}
  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaCadDupDDAItau' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption  := 'Selecione a Conta DDA - 341 - Itaú';
      frmConfigCtaDDA.btnGravar.Caption := '&OK';
      frmConfigCtaDDA.strConfig        := 'CONFIGDDA341';
      frmConfigCtaDDA.blnNaoEditar    := True;
      frmConfigCtaDDA.ShowModal;
      intCartei := + frmConfigCtaDDA.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigCtaDDA.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigCtaDDA);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmCtaCadDupDDA,frmCtaCadDupDDA);
        frmCtaCadDupDDA.pnlTopo.Caption  := 'Cadastro de Duplicatas não Identificadas DDA - 341 - Itaú';
        frmCtaCadDupDDA.strConfig        := 'CONFIGDDA341-' + InttoStr(intCartei);
        frmCtaCadDupDDA.ShowModal;
      Finally
        FreeAndNil(frmCtaCadDupDDA);
      End;
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaCadDupDDABradesco' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption  := 'Selecione a Conta DDA - 237 - Bradesco';
      frmConfigCtaDDA.btnGravar.Caption := '&OK';
      frmConfigCtaDDA.strConfig        := 'CONFIGDDA237';
      frmConfigCtaDDA.blnNaoEditar := true;
      frmConfigCtaDDA.ShowModal;
      intCartei := + frmConfigCtaDDA.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigCtaDDA.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigCtaDDA);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmCtaCadDupDDA,frmCtaCadDupDDA);
        frmCtaCadDupDDA.pnlTopo.Caption  := 'Cadastro de Duplicatas não Identificadas DDA - 237 - Bradesco';
        frmCtaCadDupDDA.strConfig        := 'CONFIGDDA237-' + InttoStr(intCartei);
        frmCtaCadDupDDA.ShowModal;
      Finally
        FreeAndNil(frmCtaCadDupDDA);
      End;
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaCadDupDDABradesco240' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption   := 'Selecione a Conta DDA - 237 - Bradesco [240p]';
      frmConfigCtaDDA.btnGravar.Caption := '&OK';
      frmConfigCtaDDA.strConfig         := 'CONFIGDDA237_240';
      frmConfigCtaDDA.blnNaoEditar      := true;
      frmConfigCtaDDA.ShowModal;
      intCartei := + frmConfigCtaDDA.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigCtaDDA.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigCtaDDA);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmCtaCadDupDDA,frmCtaCadDupDDA);
        frmCtaCadDupDDA.pnlTopo.Caption  := 'Cadastro de Duplicatas não Identificadas DDA - 237 - Bradesco [240p]';
        frmCtaCadDupDDA.strConfig        := 'CONFIGDDA237_240-' + InttoStr(intCartei);
        frmCtaCadDupDDA.ShowModal;
      Finally
        FreeAndNil(frmCtaCadDupDDA);
      End;
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaCadDupDDASantander' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption   := 'Selecione a Conta DDA - 033 - Santander';
      frmConfigCtaDDA.btnGravar.Caption := '&OK';
      frmConfigCtaDDA.strConfig         := 'CONFIGDDA033';
      frmConfigCtaDDA.blnNaoEditar      := True;
      frmConfigCtaDDA.ShowModal;
      intCartei := + frmConfigCtaDDA.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigCtaDDA.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigCtaDDA);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmCtaCadDupDDA,frmCtaCadDupDDA);
        frmCtaCadDupDDA.pnlTopo.Caption  := 'Cadastro de Duplicatas não Identificadas DDA - 033 - Santander';
        frmCtaCadDupDDA.strConfig        := 'CONFIGDDA033-' + InttoStr(intCartei);
        frmCtaCadDupDDA.ShowModal;
      Finally
        FreeAndNil(frmCtaCadDupDDA);
      End;
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaCadDupDDACEF' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption   := 'Selecione a Conta DDA - 104 - Caixa Econômica Federal';
      frmConfigCtaDDA.btnGravar.Caption := '&OK';
      frmConfigCtaDDA.strConfig         := 'CONFIGDDA104';
      frmConfigCtaDDA.blnNaoEditar      := True;
      frmConfigCtaDDA.ShowModal;
      intCartei := + frmConfigCtaDDA.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigCtaDDA.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigCtaDDA);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmCtaCadDupDDA,frmCtaCadDupDDA);
        frmCtaCadDupDDA.pnlTopo.Caption  := 'Cadastro de Duplicatas não Identificadas DDA - 104 - Caixa Econômica Federal';
        frmCtaCadDupDDA.strConfig        := 'CONFIGDDA104-' + InttoStr(intCartei);
        frmCtaCadDupDDA.ShowModal;
      Finally
        FreeAndNil(frmCtaCadDupDDA);
      End;
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaCadDupDDABB' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption   := 'Selecione a Conta DDA - 001 - Banco do Brasil';
      frmConfigCtaDDA.btnGravar.Caption := '&OK';
      frmConfigCtaDDA.strConfig         := 'CONFIGDDA001';
      frmConfigCtaDDA.blnNaoEditar      := True;
      frmConfigCtaDDA.ShowModal;
      intCartei := + frmConfigCtaDDA.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigCtaDDA.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigCtaDDA);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmCtaCadDupDDA,frmCtaCadDupDDA);
        frmCtaCadDupDDA.pnlTopo.Caption  := 'Cadastro de Duplicatas não Identificadas DDA - 001 - Banco do Brasil';
        frmCtaCadDupDDA.strConfig        := 'CONFIGDDA001-' + InttoStr(intCartei);
        frmCtaCadDupDDA.ShowModal;
      Finally
        FreeAndNil(frmCtaCadDupDDA);
      End;
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaCadDupDDABanrisul' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption   := 'Selecione a Conta DDA - 041 - Banrisul';
      frmConfigCtaDDA.btnGravar.Caption := '&OK';
      frmConfigCtaDDA.strConfig         := 'CONFIGDDA041';
      frmConfigCtaDDA.blnNaoEditar      := True;
      frmConfigCtaDDA.ShowModal;
      intCartei := + frmConfigCtaDDA.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigCtaDDA.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigCtaDDA);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmCtaCadDupDDA,frmCtaCadDupDDA);
        frmCtaCadDupDDA.pnlTopo.Caption  := 'Cadastro de Duplicatas não Identificadas DDA - 041 - Banrisul';
        frmCtaCadDupDDA.strConfig        := 'CONFIGDDA041-' + InttoStr(intCartei);
        frmCtaCadDupDDA.ShowModal;
      Finally
        FreeAndNil(frmCtaCadDupDDA);
      End;
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaCadDupDDASicredi' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigCtaDDA,frmConfigCtaDDA);
      frmConfigCtaDDA.pnlTopo.Caption   := 'Selecione a Conta DDA - 748 - Sicredi';
      frmConfigCtaDDA.btnGravar.Caption := '&OK';
      frmConfigCtaDDA.strConfig         := 'CONFIGDDA748';
      frmConfigCtaDDA.blnNaoEditar      := True;
      frmConfigCtaDDA.ShowModal;
      intCartei := + frmConfigCtaDDA.tabContas.TabIndex + 1;
    Finally
      blnConfirma := False;
      If frmConfigCtaDDA.ModalResult = mrOK Then
        blnConfirma := True;
      FreeAndNil(frmConfigCtaDDA);
    End;

    If blnConfirma Then
    Begin
      Try
        pCriarFormularios(TfrmCtaCadDupDDA,frmCtaCadDupDDA);
        frmCtaCadDupDDA.pnlTopo.Caption  := 'Cadastro de Duplicatas não Identificadas DDA - 748 - Sicredi';
        frmCtaCadDupDDA.strConfig        := 'CONFIGDDA748-' + InttoStr(intCartei);
        frmCtaCadDupDDA.ShowModal;
      Finally
        FreeAndNil(frmCtaCadDupDDA);
      End;
    End;
  End
  {***************************}
  {* CONFIGURAÇÃO DDA ONLINE *}
  {***************************}
  else if arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigCtaDDASicoob' then
  begin
    TDDAMenu.Configuracao('756', 'CONFIGDDA756API', True);
  end
  {*************************}
  {* IMPORTAÇÃO DDA ONLINE *}
  {*************************}
  else if arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaImpDDASicoob' then
  begin
    TDDAMenu.ImportarBoletosAPI('756');
  end
  {**************************************}
  {* RELATÓRIO DE DUPLICATAS DDA ONLINE *}
  {**************************************}
  else if arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaRelDupDDASicoob' then
  begin
    TDDAMenu.RelatorioDuplicatasDDA('756', True);
  end
  {******************************************}
  {* ATUALIZAR DUPLICATAS DO CONTAS A PAGAR *}
  {******************************************}
  else if arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaAtuDupDDASicoob' then
  begin
    TDDAMenu.AtualizarDuplicataDDASicoob('756', True);
  end
  {******************************************}
  {* CADASTRAR  / VINCULAR DUPLICATAS NÃO IDENTIFICADO *}
  {******************************************}
  else if arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmCtaCadDupDDASicoob' then
  begin
    TDDAMenu.CadastroDuplicataDDANaoIdentificadas('756', True);
  end
  {***********FIM DO GRUPO DDA*******************}
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigBancoobCta' Then
  begin
    Try
      pCriarFormularios(TfrmConfigBancoobCta,frmConfigBancoobCta);
      frmConfigBancoobCta.strConfig := 'CONFIGCTA756-';
      frmConfigBancoobCta.ShowModal;
    Finally
      FreeAndNil(frmConfigBancoobCta);
    End;
  end

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigBBPGG' Then
  begin
    Try
      pCriarFormularios(TfrmConfiguracaoBancoBrasilPGG,frmConfiguracaoBancoBrasilPGG);
      frmConfiguracaoBancoBrasilPGG.strConfig := 'CONFIGPGG001-';
      frmConfiguracaoBancoBrasilPGG.ShowModal;
    Finally
      FreeAndNil(frmConfiguracaoBancoBrasilPGG);
    End;
  end


  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmGerDupBancoobCta' Then
  begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 756 - Bancoob';
      frmGerDup.strNomBanco            := '756 - Bancoob';
      frmGerDup.strTipGer              := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  end

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmGerDupBBPGG' Then
  begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 001 - Banco do Brasil';
      frmGerDup.strNomBanco            := '001 - Banco do Brasil';
      frmGerDup.strTipGer              := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmGerDup.blnPGG                 := True;
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  end

  {***********************************}
  {* CONFIGURAÇÕES BANCO DO NORDESTE *}
  {*REQ-95543**********************MO*}
  Else If arrMenu[intIndex].strNomForm = 'frmConfigNordeste400' Then
  Begin

    Try
      pCriarForm(TfrmConfigNordeste400, frmConfigNordeste400);
    Finally
      FreeAndNil(frmConfigNordeste400);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmRelDupRemBancoobCta' Then
  begin
    Try
      pCriarFormularios(TfrmRelRelCtaDuplicatas, frmRelRelCtaDuplicatas);
      frmRelRelCtaDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 756 - Bancoob';
      frmRelRelCtaDuplicatas.strNomBanco      := '756 - Bancoob';
      frmRelRelCtaDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelCtaDuplicatas);
    End;

  end

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmRelDupRemBBPGG' Then
  begin
    Try
      pCriarFormularios(TfrmRelRelCtaDuplicatas, frmRelRelCtaDuplicatas);
      frmRelRelCtaDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 001 - Banco do Brasil';
      frmRelRelCtaDuplicatas.strNomBanco      := '001 - Banco do Brasil';
      frmRelRelCtaDuplicatas.blnPGG := True;
      frmRelRelCtaDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelCtaDuplicatas);
    End;

  end

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmEstBancoobCta' Then
  begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '756';
      frmEstorno.edtDesBco.Text  := 'Bancoob';
      frmEstorno.blnApenasCadPag := True;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  end

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmEstBBPGG' Then
  begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '001';
      frmEstorno.edtDesBco.Text  := 'Banco do Brasil';
      frmEstorno.blnApenasCadPag := True;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  end

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmExpArqRemBancoobCta' Then
  begin
    Try
      pCriarFormularios(TfrmConfigBancoobCta, frmConfigBancoobCta);
      frmConfigBancoobCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoobCta.btnGravar.Caption := '&OK';
      frmConfigBancoobCta.blnNaoEditar       := True;
      frmConfigBancoobCta.ShowModal;

      If frmConfigBancoobCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoobCta);
        Exit;
      End;

      intCartei := frmConfigBancoobCta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBancoobCta);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemBancoobCta,frmExpArqRemBancoobCta);
      frmExpArqRemBancoobCta.intCartei  := intCartei;
      frmExpArqRemBancoobCta.strNomForm := 'frmConfigBancoobCta';
      frmExpArqRemBancoobCta.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemBancoobCta);
    End;

  end

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmExpArqRemBBPGG' Then
  begin
    Try
      pCriarFormularios(TfrmConfiguracaoBancoBrasilPGG, frmConfiguracaoBancoBrasilPGG);
      frmConfiguracaoBancoBrasilPGG.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfiguracaoBancoBrasilPGG.btnGravar.Caption := '&OK';
      frmConfiguracaoBancoBrasilPGG.blnNaoEditar       := True;
      frmConfiguracaoBancoBrasilPGG.ShowModal;

      If frmConfiguracaoBancoBrasilPGG.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfiguracaoBancoBrasilPGG);
        Exit;
      End;

      intCartei := frmConfiguracaoBancoBrasilPGG.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfiguracaoBancoBrasilPGG);
    End;

    Try
      pCriarFormularios(TfrmExpRemessaBancoBrasilPGG,frmExpRemessaBancoBrasilPGG);
      frmExpRemessaBancoBrasilPGG.intCartei  := intCartei;
      frmExpRemessaBancoBrasilPGG.strNomForm := 'frmExpRemessaBancoBrasilPGG';
      frmExpRemessaBancoBrasilPGG.ShowModal;
    Finally
      FreeAndNil(frmExpRemessaBancoBrasilPGG);
    End;

  end

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmEstEnvBancoobCta' Then
  begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '756';
      frmEstorno.edtDesBco.Text  := 'Bancoob';
      frmEstorno.blnApenasCadPag := True;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmEstEnvBBPGG' Then
  begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '001';
      frmEstorno.edtDesBco.Text  := 'Banco do Brasil';
      frmEstorno.blnApenasCadPag := True;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;

    Finally
      FreeAndNil(frmEstorno);
    End;

  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmArqRetBancoobCta' Then
  begin

    Try
      pCriarFormularios(TfrmConfigBancoobCta,frmConfigBancoobCta);
      frmConfigBancoobCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoobCta.btnGravar.Caption := '&OK';
      frmConfigBancoobCta.blnNaoEditar       := True;
      frmConfigBancoobCta.ShowModal;

      If frmConfigBancoobCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoobCta);
        Exit;
      End;

      intCartei := frmConfigBancoobCta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBancoobCta);
    End;

    Try
      pCriarFormularios(TfrmRetPagFor,frmRetPagFor);
      frmRetPagFor.pnlTopo.Caption  := 'Arquivo de Retorno - 756 - Sicoob';
      frmRetPagFor.strCodBco        := '756';
      frmRetPagFor.strNomBco        := 'SICOOB';
      frmRetPagFor.strConfig        := 'CONFIGCTA756-' + InttoStr(intCartei);
      frmRetPagFor.ShowModal;
    Finally
      FreeAndNil(frmRetPagFor);
    End;
  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmArqRetBBPGG' Then
  begin

    Try
      pCriarFormularios(TfrmConfiguracaoBancoBrasilPGG,frmConfiguracaoBancoBrasilPGG);
      frmConfiguracaoBancoBrasilPGG.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfiguracaoBancoBrasilPGG.btnGravar.Caption := '&OK';
      frmConfiguracaoBancoBrasilPGG.blnNaoEditar       := True;
      frmConfiguracaoBancoBrasilPGG.ShowModal;

      If frmConfiguracaoBancoBrasilPGG.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfiguracaoBancoBrasilPGG);
        Exit;
      End;

      intCartei := frmConfiguracaoBancoBrasilPGG.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfiguracaoBancoBrasilPGG);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 001 - Banco do Brasil';
      frmRetBco.strNomBanco            := '001 - Banco do Brasil';
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fArqIniAutban(0, 'CONFIGPGG001-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.strTipGer              := 'P';  // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmRetBco.blnPGG := True;
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmRelArqRetBancoobCta' Then
  begin
    Try
      pCriarFormularios(TfrmRelRetBcoCta,frmRelRetBcoCta);
      frmRelRetBcoCta.pnlTopo.Caption  := 'Relatório de Retorno Banco - 756 - Bancoob ';
      frmRelRetBcoCta.strNomBanco      := '756 - Bancoob ';
      frmRelRetBcoCta.ShowModal;
    Finally
      FreeAndNil(frmRelRetBcoCta);
    End;
  end

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmRelArqRetBBPGG' Then
  begin
    Try
      pCriarFormularios(TfrmRelRetBcoCta,frmRelRetBcoCta);
      frmRelRetBcoCta.pnlTopo.Caption  := 'Relatório de Retorno - Banco do Brasil [001] ';
      frmRelRetBcoCta.strNomBanco      := '001 - Banco do Brasil ';
      frmRelRetBcoCta.blnPGG           := True;
      frmRelRetBcoCta.ShowModal;
    Finally
      FreeAndNil(frmRelRetBcoCta);
    End;
  end

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmBaiAutDupBancoobCta' Then
  begin
    Try
      pCriarFormularios(TfrmConfigBancoobCta,frmConfigBancoobCta);
      frmConfigBancoobCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBancoobCta.btnGravar.Caption := '&OK';
      frmConfigBancoobCta.blnNaoEditar       := True;
      frmConfigBancoobCta.ShowModal;

      If frmConfigBancoobCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBancoobCta);
        Exit;
      End;

      If Trim(frmConfigBancoobCta.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigBancoobCta.edtDiasCred.Text);

      intCartei := frmConfigBancoobCta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigItauCta);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDupContasPagar('756',intCartei);
    End;

  end

  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmBaiAutDupBBPGG' Then
  begin
    Try
      pCriarFormularios(TfrmConfiguracaoBancoBrasilPGG,frmConfiguracaoBancoBrasilPGG);
      frmConfiguracaoBancoBrasilPGG.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfiguracaoBancoBrasilPGG.btnGravar.Caption := '&OK';
      frmConfiguracaoBancoBrasilPGG.blnNaoEditar       := True;
      frmConfiguracaoBancoBrasilPGG.ShowModal;

      If frmConfiguracaoBancoBrasilPGG.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfiguracaoBancoBrasilPGG);
        Exit;
      End;

      If Trim(frmConfiguracaoBancoBrasilPGG.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfiguracaoBancoBrasilPGG.edtDiasCred.Text);

      intCartei := frmConfiguracaoBancoBrasilPGG.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfiguracaoBancoBrasilPGG);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDupContasPagar('001',intCartei,'CONFIGPGG001-' + IntToStr(intCartei),True);
    End;

  end

  //*************************************/
  //   BANRISUL [240p]   PAGAR          */
  //*************************************/
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigBanrisulCta' Then
  begin
    Try
      pCriarFormularios(TfrmConfigBanrisulCta240,frmConfigBanrisulCta240);
      frmConfigBanrisulCta240.strConfig := 'CONFIGCTA041-';
      frmConfigBanrisulCta240.ShowModal;
    Finally
      FreeAndNil(frmConfigBanrisulCta240);
    End;
  end
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmGerDupBanrisulCta' Then
  begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 041 - Banrisul';
      frmGerDup.strNomBanco            := '041 - Banrisul';
      frmGerDup.strTipGer              := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmGerDup.blnMosTED              := True;
      frmGerDup.edtPortador.Enabled    := False;
      frmGerDup.edtDesPortador.Enabled := False;
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  end
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmRelDupRemBanrisulCta' Then
  begin
    Try
      pCriarFormularios(TfrmRelRelCtaDuplicatas, frmRelRelCtaDuplicatas);
      frmRelRelCtaDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 041 - Banrisul';
      frmRelRelCtaDuplicatas.strNomBanco      := '041 - Banrisul';
      frmRelRelCtaDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelCtaDuplicatas);
    End;

  end
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmEstBanrisulCta' Then
  begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '041';
      frmEstorno.edtDesBco.Text  := 'Banrisul';
      frmEstorno.blnApenasCadPag := True;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  end
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmExpArqRemBanrisulCta' Then
  begin
    Try
      pCriarFormularios(TfrmConfigBanrisulCta240, frmConfigBanrisulCta240);
      frmConfigBanrisulCta240.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBanrisulCta240.btnGravar.Caption := '&OK';
      frmConfigBanrisulCta240.blnNaoEditar      := True;
      frmConfigBanrisulCta240.ShowModal;

      If frmConfigBanrisulCta240.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBanrisulCta240);
        Exit;
      End;

      intCartei := frmConfigBanrisulCta240.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBanrisulCta240);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemBanrisulCta240,frmExpArqRemBanrisulCta240);
      frmExpArqRemBanrisulCta240.intCartei  := intCartei;
      frmExpArqRemBanrisulCta240.strNomForm := 'frmConfigBanrisulCta';
      frmExpArqRemBanrisulCta240.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemBanrisulCta240);
    End;

  end
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmEstEnvBanrisulCta' Then
  begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '041';
      frmEstorno.edtDesBco.Text  := 'Banrisul';
      frmEstorno.blnApenasCadPag := True;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmArqRetBanrisulCta' Then
  begin

    Try
      pCriarFormularios(TfrmConfigBanrisulCta240,frmConfigBanrisulCta240);
      frmConfigBanrisulCta240.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBanrisulCta240.btnGravar.Caption := '&OK';
      frmConfigBanrisulCta240.blnNaoEditar      := True;
      frmConfigBanrisulCta240.ShowModal;

      If frmConfigBanrisulCta240.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBanrisulCta240);
        Exit;
      End;

      intCartei := frmConfigBanrisulCta240.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBanrisulCta240);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 041 - Banrisul';
      frmRetBco.strNomBanco            := '041 - Banrisul';
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIGCTA041-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.strTipGer              := 'P';  // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmRelArqRetBanrisulCta' Then
  begin
    Try
      pCriarFormularios(TfrmRelRetBcoCta,frmRelRetBcoCta);
      frmRelRetBcoCta.pnlTopo.Caption  := 'Relatório de Retorno Banco - 041 - Banrisul ';
      frmRelRetBcoCta.strNomBanco      := '041 - Banrisul ';
      frmRelRetBcoCta.ShowModal;
    Finally
      FreeAndNil(frmRelRetBcoCta);
    End;
  end
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmBaiAutDupBanrisulCta' Then
  begin
    Try
      pCriarFormularios(TfrmConfigBanrisulCta240,frmConfigBanrisulCta240);
      frmConfigBanrisulCta240.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigBanrisulCta240.btnGravar.Caption := '&OK';
      frmConfigBanrisulCta240.blnNaoEditar       := True;
      frmConfigBanrisulCta240.ShowModal;

      If frmConfigBanrisulCta240.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigBanrisulCta240);
        Exit;
      End;

      If Trim(frmConfigBanrisulCta240.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigBanrisulCta240.edtDiasCred.Text);

      intCartei := frmConfigBanrisulCta240.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBanrisulCta240);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDupContasPagar('041',intCartei);
    End;

  end

  //*************************************/
  //   ABC BRASIL [240p]  PAGAR         */
  //*************************************/
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigABCBrasilCta' Then
  begin
    Try
      pCriarFormularios(TfrmConfigABCBrasilCta,frmConfigABCBrasilCta);
      frmConfigABCBrasilCta.strConfig := 'CONFIGCTA246-';
      frmConfigABCBrasilCta.ShowModal;
    Finally
      FreeAndNil(frmConfigABCBrasilCta);
    End;
  end
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmGerDupABCBrasilCta' Then
  begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption        := 'Geração de Duplicatas - 246 - ABC Brasil';
      frmGerDup.strNomBanco            := '246 - ABC Brasil';
      frmGerDup.strTipGer              := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmGerDup.blnMosTED              := True;
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;

  end
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmRelDupRemABCBrasilCta' Then
  begin
    Try
      pCriarFormularios(TfrmRelRelCtaDuplicatas, frmRelRelCtaDuplicatas);
      frmRelRelCtaDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 246 - ABC Brasil';
      frmRelRelCtaDuplicatas.strNomBanco      := '246 - ABC Brasil';
      frmRelRelCtaDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelCtaDuplicatas);
    End;

  end
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmEstABCBrasilCta' Then
  begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '246';
      frmEstorno.edtDesBco.Text  := 'ABC Brasil';
      frmEstorno.blnApenasCadPag := True;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  end
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmExpArqRemABCBrasilCta' Then
  begin
    Try
      pCriarFormularios(TfrmConfigABCBrasilCta, frmConfigABCBrasilCta);
      frmConfigABCBrasilCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigABCBrasilCta.btnGravar.Caption := '&OK';
      frmConfigABCBrasilCta.blnNaoEditar      := True;
      frmConfigABCBrasilCta.ShowModal;

      If frmConfigABCBrasilCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigABCBrasilCta);
        Exit;
      End;

      intCartei := frmConfigABCBrasilCta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigABCBrasilCta);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemABCBrasilCta,frmExpArqRemABCBrasilCta);
      frmExpArqRemABCBrasilCta.intCartei  := intCartei;
      frmExpArqRemABCBrasilCta.strNomForm := 'frmConfigABCBrasilCta';
      frmExpArqRemABCBrasilCta.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemABCBrasilCta);
    End;

  end
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmEstEnvABCBrasilCta' Then
  begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '246';
      frmEstorno.edtDesBco.Text  := 'ABC Brasil';
      frmEstorno.blnApenasCadPag := True;
      frmEstorno.blnApareceDtaPg := True;
      frmEstorno.strTipGer       := 'P'; // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;

  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmArqRetABCBrasilCta' Then
  begin

    Try
      pCriarFormularios(TfrmConfigABCBrasilCta,frmConfigABCBrasilCta);
      frmConfigABCBrasilCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigABCBrasilCta.btnGravar.Caption := '&OK';
      frmConfigABCBrasilCta.blnNaoEditar      := True;
      frmConfigABCBrasilCta.ShowModal;

      If frmConfigABCBrasilCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigABCBrasilCta);
        Exit;
      End;

      intCartei := frmConfigABCBrasilCta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigABCBrasilCta);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption        := 'Arquivo de Retorno Banco - 246 - ABC Brasil';
      frmRetBco.strNomBanco            := '246 - ABC Brsail';
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIGCTA246-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.strTipGer              := 'P';  // P = CONTAS A PAGAR / R = CONTAS A RECEBER
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmRelArqRetABCBrasilCta' Then
  begin
    Try
      pCriarFormularios(TfrmRelRetBcoCta,frmRelRetBcoCta);
      frmRelRetBcoCta.pnlTopo.Caption  := 'Relatório de Retorno Banco - 246 - ABC Brasil ';
      frmRelRetBcoCta.strNomBanco      := '246 - ABC Brasil ';
      frmRelRetBcoCta.ShowModal;
    Finally
      FreeAndNil(frmRelRetBcoCta);
    End;
  end
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmBaiAutDupABCBrasilCta' Then
  begin
    Try
      pCriarFormularios(TfrmConfigABCBrasilCta,frmConfigABCBrasilCta);
      frmConfigABCBrasilCta.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigABCBrasilCta.btnGravar.Caption := '&OK';
      frmConfigABCBrasilCta.blnNaoEditar       := True;
      frmConfigABCBrasilCta.ShowModal;

      If frmConfigABCBrasilCta.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigABCBrasilCta);
        Exit;
      End;

      If Trim(frmConfigABCBrasilCta.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigABCBrasilCta.edtDiasCred.Text);

      intCartei := frmConfigABCBrasilCta.tabCarteira.TabIndex + 1;

    Finally
      FreeAndNil(frmConfigBanrisulCta240);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDupContasPagar('246',intCartei);
    End;

  end
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmConfigSofisa_LP_444' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigSofisa_LP_444,frmConfigSofisa_LP_444);
      frmConfigSofisa_LP_444.strConfig := 'CONFIG637LP444p-';
      frmConfigSofisa_LP_444.ShowModal;
    Finally
      FreeAndNil(frmConfigSofisa_LP_444);
    End;
  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmGerDupSofisa_LP_444' Then
  Begin
    Try
      pCriarFormularios(TfrmGerDup,frmGerDup);
      frmGerDup.pnlTopo.Caption  := 'Geração de Duplicatas - 637 - Sofisa LP [444p]';
      frmGerDup.strNomBanco      := '637 - Sofisa LP [444p]';
      frmGerDup.strNumPos := '_444p';
      frmGerDup.ShowModal;
    Finally
      FreeAndNil(frmGerDup);
    End;
  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmRelDupRemSofisa_LP_444' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRelDuplicatas,frmRelRelDuplicatas);
      frmRelRelDuplicatas.pnlTopo.Caption  := 'Relação de Duplicatas - 637 - Sofisa LP [444p]';
      frmRelRelDuplicatas.strNomBanco      := '637 - Sofisa LP [444p]';
      frmRelRelDuplicatas.ShowModal;
    Finally
      FreeAndNil(frmRelRelDuplicatas);
    End;
  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmEstSofisa_LP_444' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '637';
      frmEstorno.edtDesBco.Text  := 'Sofisa LP [444p]';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmExpArqRemSofisa_LP_444' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigSofisa_LP_444,frmConfigSofisa_LP_444);
      frmConfigSofisa_LP_444.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSofisa_LP_444.btnGravar.Caption := '&OK';
      frmConfigSofisa_LP_444.blnNaoEditar := true;
      frmConfigSofisa_LP_444.ShowModal;

      If frmConfigSofisa_LP_444.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSofisa_LP_444);
        Exit;
      End;

      intCartei := frmConfigSofisa_LP_444.tabCarteira.TabIndex + 1;
    Finally
      FreeAndNil(frmConfigSofisa_LP_444);
    End;

    Try
      pCriarFormularios(TfrmExpArqRemSofisa_LP_444,frmExpArqRemSofisa_LP_444);
      frmExpArqRemSofisa_LP_444.intCartei  := intCartei;
      frmExpArqRemSofisa_LP_444.strNomForm := 'frmConfigSofisa_LP_444';
      frmExpArqRemSofisa_LP_444.ShowModal;
    Finally
      FreeAndNil(frmExpArqRemSofisa_LP_444);
    End;
  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmEstEnvSofisa_LP_444' Then
  Begin
    Try
      pCriarFormularios(TfrmEstorno,frmEstorno);
      frmEstorno.edtCodBco.Text  := '637';
      frmEstorno.edtDesBco.Text  := 'Sofisa LP [444p]';
      frmEstorno.blnApenasCadRec := False;
      frmEstorno.ShowModal;
    Finally
      FreeAndNil(frmEstorno);
    End;
  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmArqRetSofisa_LP_444' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigSofisa_LP_444,frmConfigSofisa_LP_444);
      frmConfigSofisa_LP_444.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSofisa_LP_444.btnGravar.Caption := '&OK';
      frmConfigSofisa_LP_444.blnNaoEditar := true;
      frmConfigSofisa_LP_444.ShowModal;

      If frmConfigSofisa_LP_444.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSofisa_LP_444);
        Exit;
      End;

      intCartei := frmConfigSofisa_LP_444.tabCarteira.TabIndex + 1;
    Finally
      FreeAndNil(frmConfigSofisa_LP_444);
    End;

    Try
      pCriarFormularios(TfrmRetBco,frmRetBco);
      frmRetBco.pnlTopo.Caption  := 'Arquivo de Retorno Banco - 637 - Sofisa LP [444p]';
      frmRetBco.strNomBanco      := '637 - Sofisa LP [444p]';
      frmRetBco.intCartei  := intCartei;
      frmRetBco.fraPathRetornoBco.edtDirectory.Text := fGetBancoConfig(0, 'CONFIG637LP444p-' + IntToStr(intCartei), 'PATHRET', '');
      frmRetBco.ShowModal;
    Finally
      FreeAndNil(frmRetBco);
    End;
  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmRelArqRetSofisa_LP_444' Then
  Begin
    Try
      pCriarFormularios(TfrmRelRetBco,frmRelRetBco);
      frmRelRetBco.pnlTopo.Caption  := 'Relatório de Retorno Banco - 637 - Sofisa LP [444p]';
      frmRelRetBco.strNomBanco      := '637 - Sofisa LP [444p]';
      frmRelRetBco.ShowModal;
    Finally
      FreeAndNil(frmRelRetBco);
    End;
  End
  Else If arrMenu[FrameMenu.trvMenu.Selected.AbsoluteIndex].strNomform = 'frmBaiAutDupSofisa_LP_444' Then
  Begin
    Try
      pCriarFormularios(TfrmConfigSofisa_LP_444,frmConfigSofisa_LP_444);
      frmConfigSofisa_LP_444.pnlTopo.Caption   := 'Selecione a carteira';
      frmConfigSofisa_LP_444.btnGravar.Caption := '&OK';
      frmConfigSofisa_LP_444.blnNaoEditar := true;
      frmConfigSofisa_LP_444.ShowModal;

      If frmConfigSofisa_LP_444.ModalResult <> mrOK Then
      Begin
        FreeAndNil(frmConfigSofisa_LP_444);
        Exit;
      End;

      If Trim(frmConfigSofisa_LP_444.edtDiasCred.Text) = '' Then
        intDiaCred := 0
      Else
        intDiaCred := StrToInt(frmConfigSofisa_LP_444.edtDiasCred.Text);

      intCartei := frmConfigSofisa_LP_444.tabCarteira.TabIndex + 1;
    Finally
      FreeAndNil(frmConfigSofisa_LP_444);
    End;

    If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
    Begin
      pBaixaAtuDup('637LP444p',intCartei);
    End;
  End;

end;

procedure TfrmPrincipal.tmrCertificadosExpiradosTimer(Sender: TObject);
begin
  tmrCertificadosExpirados.Enabled := False;
  TBancoInterMenu.VerificaExpiracaoCertificadoDigitalBancoInter;
end;

procedure TfrmPrincipal.tmrRelogioTimer(Sender: TObject);
begin
  If fEmptyStr(VS_strCodEmp) Then
    Exit;
  fAjustaDataSistema;
end;

procedure TfrmPrincipal.EstornoDuplicataDescontadaParaCobrancaSimples(qryRetBco, qryCadRec: TUniQuery; AstrCodBco: String; objCnfDao: TCnfOcoDao; AintDiasCredito: integer);
 Var
  strSQL   : String;
  qryUpdate: TUniQuery;
  lstBanCtr: array of TBanCtrRepository;
  AstrSeqLan: String;
  objCnfOco: TCnfOco;
Begin
  //LANÇAR DÉBITO NA MOVBAN DO VALOR
  //LIMPAR MOVDES E DESCON PARA 'N'
  If (qryRetBco.FieldByName('RET_DUPDES').AsString = 'S') Then
  Begin
    Try
      If (qryRetBco.FieldByName('RET_TXADES').AsFloat <> 0) And Assigned(objCnfDao) Then
      Begin
        objCnfOco := objCnfDao.fBuscaPorOcorrencia(qryRetBco.FieldByName('RET_CODOCO').AsString,'','',4);
        If Assigned(objCnfOco) Then
        Begin
          If objCnfOco.blnGerpag Then
          Begin
            pGravaTarifa(objCnfOco,
                         qryCadRec.FieldByName('CTR_CODEMP').AsString,
                         qryRetBco.FieldByName('RET_TXADES').AsFloat,
                         fAcertaDataParaDiaUtil(qryRetBco.FieldByName('RET_DTAOCO').AsFloat+IIF(objCnfOco.blnUsaDia, AintDiasCredito, 0)),
                         qryCadRec,
                         True);
          End;
          objCnfOco.Free;
        End;
      End;

      If qryRetBco.FieldByName('RET_IOFDES').AsFloat <> 0 Then
      Begin
        objCnfOco := objCnfDao.fBuscaPorOcorrencia(qryRetBco.FieldByName('RET_CODOCO').AsString,'','',1);
        If Assigned(objCnfOco) Then
        Begin
          If objCnfOco.blnGerpag Then
          Begin
            pGravaTarifa(objCnfOco,
                         qryCadRec.FieldByName('CTR_CODEMP').AsString,
                         qryRetBco.FieldByName('RET_IOFDES').AsFloat,
                         fAcertaDataParaDiaUtil(qryRetBco.FieldByName('RET_DTAOCO').AsFloat+IIF(objCnfOco.blnUsaDia, AintDiasCredito, 0)),
                         qryCadRec,
                         True);
          End;
          objCnfOco.Free;
        End;
      End;


      SetLength(lstBanCtr, 1);
      lstBanCtr[0] := TBanCtrRepository.Create;
      lstBanCtr[0].fAdd(qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                        qryCadRec.FieldByName('CTR_PARCEL').AsString,
                        qryCadRec.FieldByName('CTR_ESPDOC').AsString,
                        qryCadRec.FieldByName('CTR_CODEMP').AsString,
                        qryCadRec.FieldByName('CTR_CODCLI').AsString,
                        qryCadRec.FieldByName('CTR_HIST01').AsString,
                        qryCadRec.FieldByName('CTR_HIST02').AsString,
                        qryCadRec.FieldByName('CTR_SEQBAI').AsInteger,
                        qryCadRec.FieldByName('CTR_VALDUP').AsFloat);

      AstrSeqLan := fGravaMovBan(strCtaBai,
                                 strPorBai,
                                 strOpeBai,
                                 qryRetBco.FieldByName('RET_DTAOCO').AsFloat,
                                 qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                                 'D',
                                 qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                 qryCadRec.FieldByName('CTR_VALDUP').AsFloat,
                                 'Estorno de duplicata descontada para cob',
                                 'rança simples - Banco: ' + LeftStr(AstrCodBco, 3),
                                 qryCadRec.FieldByName('CTR_CODCLI').AsString,
                                 '',
                                 qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                                 0,
                                 qryCadRec.FieldByName('CTR_PARCEL').AsString,
                                 qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                 '',
                                 '',
                                 strCodEve,
                                 lstBanCtr[0].fGetList,
                                 FormatDateTime('mm/yyyy',  qryRetBco.FieldByName('RET_DTAOCO').AsFloat),
                                 qryCadRec.FieldByName('CTR_SEQCON').AsInteger);

      strSQL := '';
      strSQL := strSQL + ' UPDATE CADREC              ';
      strSQL := strSQL + ' SET                        ';
      strSQL := strSQL + '   CTR_DESCON = "N",        ';
      strSQL := strSQL + '   CTR_MOVDES = NULL        ';
      strSQL := strSQL + ' WHERE                      ';
      strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
      strSQL := strSQL + '   CTR_SEQBAI = 0           ';

      qryUpdate := fCriaQuery;
      With qryUpdate Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := qryCadRec.FieldByName('CTR_NUMDUP').AsString;
        ParamByName('PARCEL').AsString := qryCadRec.FieldByName('CTR_PARCEL').AsString;
        ParamByName('ESPDOC').AsString := qryCadRec.FieldByName('CTR_ESPDOC').AsString;
        ParamByName('CODEMP').AsString := qryCadRec.FieldByName('CTR_CODEMP').AsString;
        ParamByName('CODCLI').AsString := qryCadRec.FieldByName('CTR_CODCLI').AsString;
        ExecSQL;
        Close;
      End;

      FreeAndNil(qryUpdate);

      {**************************}
      {* GRAVA LOG DA ALTERAÇÃO *}
      {**************************}
      untLogCtr.GravaLogCtr(qryCadRec.FieldByName('AUTOINCREM').AsString,
                            'ESTORNO DE DUPLICATA DESCONTADA PARA COBRANÇA SIMPLES (AUTBAN)',
                            Self.Name,
                            '',
                            0,
                            0,
                            '',
                            '',
                            Nil,
                            fProximoAutoIncremReservado(FReservaLogCtr, qryCadRec.FieldByName('CTR_CODEMP').AsString));

      FreeAndNil(lstBanCtr[0]);
      SetLength(lstBanCtr, 0);
    Except
      On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao gravar estorno de duplicata descontada para cobrança simples.' + #13 +
                               'Erro gerado: ' + E.Message);
    End;
  end;
end;

{***************************************}
{* PROCEDURE BAIXA AUTOMATICA DUPLICATA*}
{************************************LB*}
function TfrmPrincipal.fAtualizaCodEve(qryUpdate: TUniQuery;
                                       strTabela,
                                       strCodEve,
                                       strNumDup,
                                       strParcel,
                                       strEspDoc,
                                       strCodEmp,
                                       strCodCli: String;
                                       intSeqBai: Integer;
                                       strCodPor: String = ''): Boolean;
  Var
    strSQL : String;

begin
  Result:= True;

  Try

    strSQL := '';
    strSQL := strSQL + ' UPDATE ' + strTabela;
    strSQL := strSQL + ' SET CTR_CODEVE = IF(:CODEVE IS NULL, CTR_CODEVE, :CODEVE)  ';
    If Not fEmptyStr(strCodPor) Then
      strSQL := strSQL + ', CTR_CODPOR = :CODPOR   ';
    strSQL := strSQL + 'WHERE                      ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  CTR_SEQBAI = :SEQBAI     ';

    With qryUpdate Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If fEmptyStr(strCodEve) Then
        ParamByName('CODEVE').Value    := Null
      Else
        ParamByName('CODEVE').AsString := strCodEve;

      If Not fEmptyStr(strCodPor) Then
        ParamByName('CODPOR').AsString := strCodPor;

      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('SEQBAI').AsInteger:= intSeqBai;
      ExecSQL;
    End;

  Except
    On E: exception Do
    Begin
      pMensagensErro(E.Message, 'TfrmPrincipal.fAtualizaCodEve');
      Result := False;
    End;
  End;
end;

{**********************************************************************************}
{* PEGA A MENOR DATA DE OCORRÊNCIA DA RETBCO/RETCTP DA DUPLICATA QUE SERÁ BAIXADA *}
{* E VERIFICA O FECHAMENTO FINANCEIRO *********************************************}
{*******************************************************************************MO*}
function TfrmPrincipal.FechamentoFinanceiroJaRealizado(ACarteira, ATotalCarteiras: Integer; ACarteiraBanco, ACodBanco, AReceberPagar: String): Boolean;
var
  qryBusca: TUniQuery;
begin
  Result := False;
  qryBusca := fCriaQuery;

  qryBusca.Close;
  qryBusca.SQL.Clear;
  qryBusca.SQL.Add(' SELECT MIN(RET_DTAOCO) AS MENORDATA ');

  //RECEBER
  If AReceberPagar = 'R' then
  begin

    qryBusca.SQL.Add(' FROM RETBCO ');
    qryBusca.SQL.Add(' WHERE ');

    If (fCfgSis('CONREM', varString) = 'C') Or
       (ATotalCarteiras > 1) Then
      qryBusca.SQL.Add('  RET_CARTEI = :CARTEI AND ');
    If Not fEmptyStr(ACarteiraBanco) Then
      qryBusca.SQL.Add('  RET_CARBCO = :CARBCO AND ');

    qryBusca.SQL.Add('       RET_CODBCO = :CODBCO AND ');
    qryBusca.SQL.Add('       RET_DTAPAG IS NOT NULL AND ');
    qryBusca.SQL.Add('       RET_VALPAG > 0 ');

    If (fCfgSis('CONREM', varString) = 'C') Or
       (ATotalCarteiras > 1) Then
      qryBusca.ParamByName('CARTEI').AsInteger := ACarteira;
    If Not fEmptyStr(ACarteiraBanco) Then
      qryBusca.ParamByName('CARBCO').AsString := ACarteiraBanco;
  end
  else
  //PAGAR
  if AReceberPagar = 'P' Then
  begin
    qryBusca.SQL.Add(' FROM RETCTP ');
    qryBusca.SQL.Add(' WHERE RET_CODBCO = :CODBCO AND ');
    qryBusca.SQL.Add('       RET_DTAPAG IS NOT NULL AND ');

    IF Pos(Copy(ACodBanco, 1, 3), '341_033_756_237_001_104_') > 0 THEN
      qryBusca.SQL.Add('     RET_CODOCO = "00" AND ') // 00 = PAGAMENTO EFETUADO
    ELSE IF Pos(Copy(ACodBanco, 1, 3), '422_') > 0 THEN
      qryBusca.SQL.Add('     LOCATE(RET_CODOCO, "01_17_18_") > 0 AND ');

    qryBusca.SQL.Add('       RET_VALPAG <> 0 ');
  end;

  qryBusca.ParamByName('CODBCO').AsString  := LeftStr(ACodBanco, 3);
  qryBusca.Open;

  If not qryBusca.IsEmpty then
    if objFechamento.FechamentoFinanceiroJaRealizado(VS_strCodEmp, qryBusca.FieldByName('MENORDATA').AsDateTime) then
      Result := True;

  FreeAndNil(qryBusca);
end;

{function TfrmPrincipal.fFiltraIndiceCarteiraBanco(strCodBco: String; strCartei: String): Boolean;
  Var
    strSQL   : String;
    qryCadCbi: TUniQuery;
begin

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE        ';
  strSQL := strSQL + '   COUNT(*) AS QTD          ';
  strSQL := strSQL + ' FROM                       ';
  strSQL := strSQL + '   CADCBI                   ';
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '   CBI_CODBCO = :CODBCO AND ';
  strSQL := strSQL + '   CBI_CARTEI = :CARTEI     ';

  qryCadCbi := fCriaQuery;

  With qryCadCbi Do
  Begin
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODBCO').AsString := strCodBco;
    ParamByName('CARTEI').AsString := strCartei;
    Open;
  End;

  Result := qryCadCbi.FieldByName('QTD').AsInteger > 0;

  FreeAndNil(qryCadCbi);

end;}

procedure TfrmPrincipal.pApagaRetBco(strCodBco, strNumDup, strParcel, strEspDoc,
  strCodEmp, strCodCli, strCodOco: String; strCNAB: String = ''; AMotOco: String = '');
  Var
   LChave: TChaveRetBco;
begin
  Try
    LChave.ACodigoBanco := strCodBco;
    LChave.ANumeroDuplicata := strNumDup;
    LChave.AParcela := strParcel;
    LChave.ATipoDocumento := strEspDoc;
    LChave.ACodigoEmpresa := strCodEmp;
    LChave.ACodigoCliente := strCodCli;
    LChave.ACodigoOcorrencia := strCodOco;
    LChave.ADuplicataComDivergencia := 'N';
    LChave.ACnab := strCNAB;
    LChave.AMotivoOcorrencia := AMotOco;

    // Adicionar para deleção
    TDeletorRetBco.ObterInstancia.AdicionarParaDeletar(LChave);

  Except
    On E: Exception Do
    Begin
      pMensagensErro('Ocorreu um erro ao baixar as duplicatas: ' + E.Message, '[pApagaRetBco]');
    End;
  End;
end;

procedure TfrmPrincipal.pApagaRetCtp(strCodBco, strNumDup, strParcel, strSerie,
  strCodEmp, strCodFor: String);
  Var
    strSQL   : String;
    qryDelRet: TUniQuery;
begin
  qryDelRet := fCriaQuery(Self);

  Try
    strSQL := '';
    strSQL := strSQL + ' DELETE                     ';
    strSQL := strSQL + ' FROM                       ';
    strSQL := strSQL + '   RETCTP                   ';
    strSQL := strSQL + ' WHERE                      ';
    strSQL := strSQL + '   RET_CODBCO = :CODBCO     ';
    strSQL := strSQL + '   AND RET_NUMDUP = :NUMDUP ';
    strSQL := strSQL + '   AND RET_PARCEL = :PARCEL ';
    strSQL := strSQL + '   AND RET_SERIE_ = :SERIE_ ';
    strSQL := strSQL + '   AND RET_CODEMP = :CODEMP ';
    strSQL := strSQL + '   AND RET_CODFOR = :CODFOR ';

    With qryDelRet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODBCO').AsString := strCodBco;
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('SERIE_').AsString := strSerie;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODFOR').AsString := strCodFor;

      ExecSQL;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[TfrmPrincipal.pApagaRetBco]');
    End;
  End;

  FreeAndNil(qryDelRet);

end;

procedure TfrmPrincipal.pAtualizaAutoIncremTarifasBoletosEmAberto;
  Var
    qryUpdate: TUniQuery;
    intCont  : Integer;
    strAutCtr: String;
begin
  Try
    If Length(objGravacaoTarifa.arrDuplicatasTarifa) > 0 Then
    Begin
      qryUpdate := fCriaQuery;
      qryUpdate.SQL.Add('UPDATE CADREC SET CTR_CTPTXE=:AUTCTP ');
      qryUpdate.SQL.Add('WHERE AUTOINCREM IN (:AUTCTR)        ');

      qryUpdate.ParamByName('AUTCTP').AsString := objGravacaoTarifa.strAutCtp;

      strAutCtr := '';
      For intCont := 0 To Length(objGravacaoTarifa.arrDuplicatasTarifa) -1 Do
        strAutCtr := strAutCtr + '"' + objGravacaoTarifa.arrDuplicatasTarifa[intCont] + '",';

      qryUpdate.SQL.Text := StringReplace(qryUpdate.SQL.Text, ':AUTCTR', LeftStr(strAutCtr, Length(strAutCtr) - 1), [rfReplaceAll]);
      qryUpdate.ExecSQL;

      FreeAndNil(qryUpdate);

      //Grava log
      For intCont := 0 To Length(objGravacaoTarifa.arrDuplicatasTarifa) -1 Do
        untLogCtr.GravaLogCtr(objGravacaoTarifa.arrDuplicatasTarifa[intCont],
                              'ATUALIZAÇÃO DE TARIFA NA CONFIRMAÇÃO',
                              Self.Name,
                              '',
                              0,
                              0,
                              '',
                              '',
                              Nil,
                              fProximoAutoIncremReservado(FReservaLogCtr, VarToStr(fCampoTabela('CTR_CODEMP', 'CADREC', ['AUTOINCREM'], [objGravacaoTarifa.arrDuplicatasTarifa[intCont]]))));

      SetLength(objGravacaoTarifa.arrDuplicatasTarifa, 0);
    End;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao atualizar as tarifas das duplicatas. ' + #13 +
                             'Erro gerado: ' + E.Message);
  end;
end;

procedure TfrmPrincipal.AtualizaHistoricoDuplicata(AHistorico,ANumeroDuplicata,AParcela,AEspecieDocumento,ACodigoEmpresa,ACodigoCliente,AAutoIncremento: String);
  var
  LStrSql : string;
  LQryUpdate      : TUniQuery;
begin
  Try
    LQryUpdate := fCriaQuery(Self);

    LStrSql := LStrSql + ' UPDATE CADREC ';
    LStrSql := LStrSql + ' SET ';
    LStrSql := LStrSql + ' CTR_HIST01 = '  + QuotedStr(AHistorico);
    LStrSql := LStrSql + ' WHERE ';
    LStrSql := LStrSql + ' CTR_NUMDUP = :NUMDUP AND ';
    LStrSql := LStrSql + ' CTR_PARCEL = :PARCEL AND ';
    LStrSql := LStrSql + ' CTR_ESPDOC = :ESPDOC AND ';
    LStrSql := LStrSql + ' CTR_CODEMP = :CODEMP AND ';
    LStrSql := LStrSql + ' CTR_CODCLI = :CODCLI AND ';
    LStrSql := LStrSql + ' CTR_SEQBAI = 0 ';

    LQryUpdate.Close;
    LQryUpdate.SQL.Clear;
    LQryUpdate.SQL.Add(LStrSql);
    LQryUpdate.ParamByName('NUMDUP').AsString := ANumeroDuplicata;
    LQryUpdate.ParamByName('PARCEL').AsString := AParcela;
    LQryUpdate.ParamByName('ESPDOC').AsString := AEspecieDocumento;
    LQryUpdate.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LQryUpdate.ParamByName('CODCLI').AsString := ACodigoCliente;
    LQryUpdate.ExecSQL;
    LQryUpdate.Close;

    {**************************}
    {* GRAVA LOG DA ALTERAÇÃO *}
    {***********************JS*}
     untLogCtr.GravaLogCtr(AAutoIncremento,'ATUALIZAÇÃO HISTÓRICO (AUTBAN)',Self.Name, '', 0, 0, '', '', Nil, fProximoAutoIncremReservado(FReservaLogCtr, ACodigoEmpresa));
  Finally
    FreeAndNil(LQryUpdate);
  End;

end;

procedure TfrmPrincipal.pBaixaAtuDup(strCodBco: String; intCartei: Integer; strCarBco: String = '';
                                     intTotalCarteiras: Integer = 1);
  Var
    strSQL         : String;
    strSQL2        : String;
    strCreDeb      : String;
    fltValLan      : Double;
    intSeqCon      : Integer;
    LChaveCarteiraCompleta: String;
    LLancarTarifasNaLiquidacao:Boolean;
    intCont        : Integer;
    strSeqLan      : String;
    blnExisteCadRec: Boolean;
    LExecutarRoboImpressaoBoleto: Boolean;
    LImprimeBoletoAutomaticamente: Boolean;
    fltValLanBanCtr: Double;
    qryRetBco      : TUniQuery;
    qryCadRec      : TUniQuery;
    qryUpdate      : TUniQuery;

    blnBaiAna      : Boolean;
    fltValLanMovBan: Double;

    stlRegMovBan: TStringList;
    arrRegMovBan: Array Of TBaixa;

    blnCartorio,
    blnEstornoProtesto,
    LBaixaProtesto: Boolean;

    fltValJur: Double;
    fltValpag,
    fltTarifa,
    fltValDes,
    LValorDuplicata: Double;
    dtaDtaRec: TDateTime;
    blnSolDta: Boolean;

    dtVencRetDet: TDateTime;

    cdsConRet: TUniClientDataSet;

    strCodPor: String;
    qryAux   : TUniQuery;
    qryGen   : TUniQuery;
    blnUsaRet: Boolean;
    intBaiRet: Integer;
    fltTotalTarifa: Double;
    blnComita: Boolean;

    strNomBanco: String;

    strValOco05: String;

    lstBanCtr: array of TBanCtrRepository;

    fltVlrTit: Double;

    lstCnfOco: TObjectList<TCnfOco>;
    objCnfOco: TCnfOco;
    objCnfDao: TCnfOcoDao;
    strOcoBco: String;
    strOcoLay: String;
    strNumPos: String;
    strOcoEsp: String;
    strOcoEmp: String;
    intOcoCar: Integer;

    strOcoTar: String;

    qryNaoBai: TUniQuery;
    blnImpMsg: Boolean;
    blnBaiDivValores: Boolean;
    blnUsaTarifa: Boolean;
    strConfig: String;

    LDescricao: String;
    LValorEsperado: Double;
    LValorRecebido: Double;
    LDiferenca: Double;
    LExisteDiferencaEntrePagoEEsperado : Boolean;

    LValorTedAlpe,
    LValorDescontoAlpe: Double;

    LUtilizaAlpe,
    blnLancarTarifaSinteticaBoletoEmAberto,
    blnLancaTarifaNaConfirmacaoDoBanco    : Boolean;

    documento: TDocAdiantamento;
    dadosAdiantamento: TDadosAdiantamento;

    LOcoRet: String;
    LHistorico : String;
    LValorJurosOutrosValores : Double;

    function fInfDup(strCampo, strTitulo: String): String;
    begin
      If Not fEmptyStr(qrycadRec.FieldByName('CTR_' + strCampo).AsString) Then
        Result := ' - ' + strTitulo + ': ' + qrycadRec.FieldByName('CTR_' + strCampo).AsString;
    end;

    Function fConsideraDataAtualParaTarifa: Boolean;
    Begin
      Result := fGetBancoConfig(0, strConfig, 'DTCOMTA', '2') = '1';
    End;

    function fUsaRotinaBoletoAdiantamento(): Boolean;
    begin
      Result := False;

      If fCfgSis('BOLADT', VarBoolean) Then
        Exit(True);

      If TAdiantamentoGenerico.fPedidoTemBoletoAdiantamento(
          qryCadRec.FieldByName('CTR_NUMDUP').AsString,
          qryCadRec.FieldByName('CTR_ESPDOC').AsString,
          qryCadRec.FieldByName('CTR_CODEMP').AsString) Then
        Exit(True);
    end;

    function fApagarBoletoDeAdiantamentoPedido(): Boolean;
    begin
      Result := False;

      If Not qryCadRec.FieldByName('CTR_ESPDOC').AsString.Equals('PD') Then
        Exit;

      If Not fUsaRotinaBoletoAdiantamento() Then
        Exit;

      If fExisteDocumentoEmitidoParaPedido(qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                                           qryCadRec.FieldByName('CTR_ESPDOC').AsString,
                                           qryCadRec.FieldByName('CTR_CODEMP').AsString) Then
        Exit;

      Result := True;
    end;

    function RetornaDataCreditoConsiderandoApenasDiasUteis:TDateTime;
      Var
        LFeriadoFimDeSemana : TFeriadoFimDeSemana;
        LDataCredito : TDateTime;
        LDay : Integer;
    Begin
      LDataCredito := qryRetBco.FieldByName('RET_DTAPAG').AsDateTime;

      For LDay := 1 to intDiaCred Do
      Begin

        LFeriadoFimDeSemana.blnDataEDiaUtil   := False;
        LFeriadoFimDeSemana.dtaProximoDiaUtil := 0;

        While Not LFeriadoFimDeSemana.blnDataEDiaUtil Do
        Begin
          LDataCredito := LDataCredito + 1;
          LFeriadoFimDeSemana := fBuscaProxDiaUtil(LDataCredito,VS_strCodEmp);
        End;

      End;

      Result := LFeriadoFimDeSemana.dtaProximoDiaUtil ;

      If Result = 0 Then
        Result := fAcertaDataParaDiaUtil(qryRetBco.FieldByName('RET_DTAPAG').AsDateTime + intDiaCred);

    End;

    procedure pDefineDataMovimentoDoctoPgtoPix();
    begin

        If fGetBancoConfig(0, strConfig, 'CDIACREPIX', 'N').Equals('N') Then
        Begin

          If (qryRetBco.FieldByName('RET_CODOCO').AsString = '06') And (qryRetBco.FieldByName('RET_MOTOCO').AsString = '01') Then
          Begin
            dtaDtaLan := qryRetBco.FieldByName('RET_DTAPAG').AsDateTime;
          End;

        End;

    End;

    //melhorar
    procedure pAchaDataDeLancamentoETarifa;
    Begin
      If blnSolDta Then
      begin
        dtaDtaLan := fAcertaDataParaDiaUtil(dtaDtaRec + intDiaCred);
        If(qryRetBco.FieldByName('RET_CODOCO').AsString = '12') And (FDiasParaCreditoOcorrencia12 <> -1) then
          dtaDtaLan := fAcertaDataParaDiaUtil(dtaDtaRec + FDiasParaCreditoOcorrencia12);
      end
      Else
      Begin
        If qryRetBco.FieldByName('RET_DTACRE').AsDateTime > 0 Then
        begin
          dtaDtaLan := qryRetBco.FieldByName('RET_DTACRE').AsDateTime;

          If(qryRetBco.FieldByName('RET_CODOCO').AsString = '12') And (FDiasParaCreditoOcorrencia12 <> -1) then
            dtaDtaLan := fAcertaDataParaDiaUtil(qryRetBco.FieldByName('RET_DTAPAG').AsDateTime + FDiasParaCreditoOcorrencia12);

        end
        Else
        Begin
          If (qryRetBco.FieldByName('RET_DTAPAG').AsDateTime > 0) Then
          begin
            dtaDtaLan := fAcertaDataParaDiaUtil(qryRetBco.FieldByName('RET_DTAPAG').AsDateTime + intDiaCred);

            If(qryRetBco.FieldByName('RET_CODOCO').AsString = '12') And (FDiasParaCreditoOcorrencia12 <> -1) then
              dtaDtaLan := fAcertaDataParaDiaUtil(qryRetBco.FieldByName('RET_DTAPAG').AsDateTime + FDiasParaCreditoOcorrencia12);
          end;

          If fGetBancoConfig(0, strConfig, 'TIPODTACRE', '0').Equals('1') Then
          Begin
            If (qryRetBco.FieldByName('RET_DTAPAG').AsDateTime > 0) Then
              dtaDtaLan := RetornaDataCreditoConsiderandoApenasDiasUteis;
          end;

          If strCodBco.Equals('748API') Then
             pDefineDataMovimentoDoctoPgtoPix();

        End;

        dtaDtaTar :=  dtaDtaLan;

        If Pos(LeftStr(strCodBco, 3), '341_001') > 0 then
        begin
          if fConsideraDataAtualParaTarifa Then
          begin
            dtaDtaTar := qryRetBco.FieldByName('RET_DTAPAG').AsDateTime;
          end
          Else
          begin
            //VERIFICAÇÃO DE CÓDIGO DE LIQUIDAÇÃO PARA ITAÚ E DAYCOVAL
            If (strCodBco = '341') Then
            Begin
              If fGetBancoConfig(0, strConfig, 'CODLIQU', 'N') = 'S' Then
                dtaDtaTar := fAcertaDataParaDiaUtil(qryRetBco.FieldByName('RET_DTAPAG').AsDateTime + intDiaCred);
            End
            else
              dtaDtaTar :=  dtaDtaLan;
          end;
        end;
      End;
    End;
Var
  LQtdTitulos,
  LQtdLiquidacoes: Integer;
begin
  cdsConRet := Nil;
  objCnfDao := Nil;

  strNomBanco := '';
  strValOco05 := '';
  strCtaBai   := '';
  strPorBai   := '';
  strCodEve   := '';
  strHisBai   := '';
  strOcoTar   := '';
  LOcoRet     := '';
  strForTar   := '';
  strCtaTar   := '';
  strPorTar   := '';
  s033Oco10   := False;
  LExecutarRoboImpressaoBoleto := False;
  LImprimeBoletoAutomaticamente := fCfgSis('BOLAUT', varBoolean);

  blnExisteCadRec := False;
  blnCartorio  := False;
  blnImpMsg    := False;
  blnUsaTarifa := fCfgSis('ENCBAN', varBoolean);
  strConfig    := 'CONFIG' + IIF(blnBcoBra7d, '001D7', strCodBco) + '-' + IntToStr(intCartei);

  If Pos(strCodBco, '136_') > 0 Then
    strConfig := 'CONFIG136_400p-'+ IntToStr(intCartei);

  LChaveCarteiraCompleta := strConfig + '-' + VS_strCodEmp;

  If strCodBco.Equals('748API') Then
     intDiaCred := StrToIntDef(( fGetBancoConfig(0, 'CONFIG748API-' + IntToStr(intCartei), 'DIACRED', '1') ),0);

  blnLancarTarifaSinteticaBoletoEmAberto := False;

    untProcessaAtualizacaoOcorrenciasCRM.
     TControllerDuplicatasPendentes.GetInstancia.
       LiberarInstancia;

  blnLancaTarifaNaConfirmacaoDoBanco := untFuncAutban.RetornaSeOBancoLancaTarifaNaConfirmacao(blnUsaTarifa,
                                                                                              LeftStr(strCodBco, 3),
                                                                                              strConfig);

  If SameText(strCodBco, '033B') Then
  Begin
    pCriaCdsContaRetorno(cdsConRet, Nil, Nil, Nil, Nil);
    pLeContasRetorno(cdsConRet, intCartei);

    strNomBanco := 'Santander';
  End;

  LUtilizaAlpe := False;
  LValorTedAlpe := 0.00;
  If MatchStr(strCodBco, ['237']) Then
  Begin
    LUtilizaAlpe := fGetBancoConfig(0, strConfig, 'UTILIZA_ALPE', 'N') = 'S';

    If LUtilizaAlpe Then
      LValorTedAlpe := fStrToFloat(fGetBancoConfig(0, strConfig, 'TEDALPE', ''), 0);
  End;

  blnBaiAna := (fCfgSis('CTR_AS') = 'A');
  fltValLanMovBan := 0.0;

  objGravacaoTarifa.strAutCtp      := '';
  objGravacaoTarifa.strSeqLan      := '';
  objGravacaoTarifa.strSeqPag      := '';
  objGravacaoTarifa.intSeqConP     := 0;
  objGravacaoTarifa.fltTotalTarifa := 0;
  objGravacaoTarifa.AOcorrencia    := '';
  SetLength(objGravacaoTarifa.arrDuplicatasTarifa, 0);

  {**************************************}
  {* SOLICITADO PELO MARIO PARA A MENIL *}
  {* TER A OPCAO DE ESCOLHER A DATA QUE *}
  {* VAI SER GRAVADO O DTAREC           *}
  {* 18/11/2011                         *}
  {***********************************AF*}
  blnSolDta := False;
  fltTarifa := 0;

  blnUtlDesDup := (fGetBancoConfig(0, strConfig, 'UTLDESDUP', '') <> 'N'); // CARTEIRA UTILIZA DESCONTO DE DUPLICATAS? REQ: 174721
  LConsiderarDescontoSugerido := (fGetBancoConfig(0, strConfig, 'CONSIDESSUJ', '') = 'S');

  //Vamos diminuir a coisa aqui. Está ficando difícil de ler.
  if blnUsaTarifa then
  begin
    fltTarifa := fStrToFloat(fGetBancoConfig(0, strConfig, 'VALOTAR', '0'));
    strForTar := fGetBancoConfig(0, strConfig, 'FORNTAR', '0');
    strCtaTar := fGetBancoConfig(0, strConfig, 'CONTTAR', '0');
    strPorTar := fGetBancoConfig(0, strConfig, 'PORTTAR', '0');

    If (strCodBco = '033B') Or (strCodBco = '341') Or
       (LeftStr(strCodBco, 3) = '748')  Or (strCodBco = '001') Or
       (strCodBco = '756_240p') Or (strCodBco = '237') Or (strCodBco = '033B240p') Or
       MatchStr(strCodBco,['001API', '341API']) Then
    Begin
      pDesmembraCarteira(strConfig + '-' + VS_strCodEmp,
                         strOcoBco, strOcoLay, strNumPos, strOcoEsp, strOcoEmp, intOcoCar);

      objCnfDao := TCnfOcoDao.Create(strOcoBco, strOcoLay, strNumPos,
                                     strOcoEsp, strOcoEmp, intOcoCar);

      lstCnfOco := objCnfDao.fBuscaTodas;
      If Assigned(lstCnfOco) Then
      Begin
        For objCnfOco in lstCnfOco Do
        Begin
          If fEmptyStr(strOcoTar) Then
            strOcoTar := '"'+objCnfOco.strCodOco+'"'
          Else
            strOcoTar := strOcoTar + ',"'+objCnfOco.strCodOco+'"';
        End;

        lstCnfOco.Free;
      End;
    End;
  end;

  if MatchStr(strCodBco, ['237']) then
    LOcoRet := fRetornarListaOcoRet(strCodBco);


  If MatchStr(strCodBco, ['001','237']) Then
  Begin
    blnSolDta   := (fGetBancoConfig(0, strConfig, 'SOLIDTA', 'N') = 'S');
    strValOco05 := fGetBancoConfig(0, strConfig, 'VALOCO5', '');

    If blnBcoBra7d Then
      strNomBanco := 'Brasil7d';

    If blnSolDta Then
    Begin

      dtaDtaRec := VS_Date;
      If (Not ffrmData(dtaDtaRec, 'Data para baixa', 'Data de Pagamento',IIF(strCodBco = '001',VS_Date,0))) Then
        Exit;
    End;
  End
  Else If (strCodBco = '104') Then
    strNomBanco := '104 - C.E.F.'
  Else If (strCodBco = '104p400') Then
    strNomBanco := '104 - C.E.F. 400p'
  Else If strCodBco.Equals('756API')Then
    strNomBanco := 'BANCO SICOOB ONLINE'
  Else If strCodBco.Equals('033API')Then
    strNomBanco := 'BANCO SANTANDER ONLINE';;

  strOpeBai := strLoginUsuarioLogado;

  stlRegMovBan := TStringList.Create;

  SetLength(arrRegMovBan, 0);

  If fCfgSis('JURSEP') = 'S' Then
  Begin
     stlRegMovBanSep := TStringList.Create;
     SetLength(arrRegMovBanSep, 0);
     SetLength(ArrGravaMovCarSep,0);

     stlRegMovBanSepJur := TStringList.Create;
     SetLength(arrRegMovBanSepJur, 0);
     SetLength(ArrGravaMovCarSepJur,0);

     stlRegMovBanSepDes := TStringList.Create;
     SetLength(arrRegMovBanSepDes, 0);
     SetLength(ArrGravaMovCarSepDes,0);
  End;

  pCriarFormularios(TfrmWaitWindow, frmWaitWindow);
  frmWaitWindow.lblTexto.Caption := 'Aguarde, Efetuando Baixa de Duplicatas...';
  AnimateWindow(frmWaitWindow.Handle, 200, AW_BLEND);
  frmWaitWindow.Show;
  frmWaitWindow.tmrWait.Enabled := False;
  frmWaitWindow.Refresh;

  RealizarRemocaoAutomaticaDaLckatc;

  qryRetBco := fCriaQuery(Self);
  qryCadRec := fCriaQuery(Self);
  qryUpdate := fCriaQuery(Self);
  objLock := TLock.Create;
  LQryRetBcoGer := fCriaQuery(Nil);

  cdsNaoBai := TUniClientDataSet.Create(Self);
  qryNaoBai := fCriaQuery;
  qryNaoBai.SQL.Text := fRetRelatSQL;
  qryNaoBai.Open;
  pSetaClientDataSet(qryNaoBai, cdsNaoBai);
  cdsNaoBai.IndexFieldNames := 'DESCRI;CTR_NUMDUP;CTR_PARCEL';

  If blnBaiAna Then
  Begin
    SetLength(lstBanCtr, 1);
    lstBanCtr[0] := TBanCtrRepository.Create;

    If fCfgSis('JURSEP') = 'S' Then
    Begin
       SetLength(lstBanCtrSep, 1);
       lstBanCtrSep[0] := TBanCtrRepository.Create;
    End;

  End;

  lstBanCtp := TBanCtpRepository.Create;
  blnComita := False;

  //FECHAMENTO FINANCEIRO
  if FechamentoFinanceiroJaRealizado(intCartei, intTotalCarteiras, strCarBco, LeftStr(strCodBco, 3), 'R') then
  Begin
    frmWaitWindow.Close;
    frmWaitWindow.Free;
    Exit;
  End;

  Try
    Try
      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  RETBCO.*, ';
      strSQL := strSQL + '  CADCLI.CLI_NOMCLI AS NOMCLI, ';
      strSQL := strSQL + '  CADCLI.CLI_C_G_C_,';
      strSQL := strSQL + '  R.CTR_DTAVEN, R.CTR_VALDUP, R.CTR_DESSUJ ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  RETBCO  ';
      strSQL := strSQL + '  JOIN CADCLI ON RET_CODCLI = CADCLI.CLI_CODCLI ';
      strSQL := strSQL + '  LEFT JOIN CADREC R ON R.CTR_CODEMP = RET_CODEMP    ';
      strSQL := strSQL + '                    AND R.CTR_CODCLI = RET_CODCLI    ';
      strSQL := strSQL + '                    AND R.CTR_NUMDUP = RET_NUMDUP    ';
      strSQL := strSQL + '                    AND R.CTR_PARCEL = RET_PARCEL    ';
      strSQL := strSQL + '                    AND R.CTR_ESPDOC = RET_ESPDOC    ';
      strSQL := strSQL + '                    AND R.CTR_SEQBAI = 0             ';

      strSQL := strSQL + 'WHERE ';
      If (fCfgSis('CONREM', varString) = 'C') Or
         (intTotalCarteiras > 1) Or
         (MatchStr(strCodBco, ['077','001API','097API','748API', '341API','756API','033API'])) Then
        strSQL := strSQL + '  RET_CARTEI = :CARTEI AND ';
      If (Not fEmptyStr(strCarBco)) And
         (intTotalCarteiras > 1) Then
        strSQL := strSQL + '  RET_CARBCO = :CARBCO AND ';
      strSQL := strSQL + '  RET_CODBCO = :CODBCO     ';

      If MatchStr(LeftStr(strCodBco, 3), ['001', '097', '748', '341', '756', '033']) Then
      Begin
        If RightStr(strCodBco, 3).Equals('API') Then
          strSQL := strSQL + ' AND IFNULL(RET_CNAB__,"") = "API" '
        Else
          strSQL := strSQL + ' AND IFNULL(RET_CNAB__,"") <> "API" ';
      End;

      If fCfgSis('EMPIMP', varBoolean) Then
        strSQL := strSQL + ' AND RET_EMPIMP = ' + VS_strCodEmp.QuotedString;

      LQryRetBcoGer.Close;
      LQryRetBcoGer.SQL.Clear;
      LQryRetBcoGer.SQL.Add(strSQL);
      If (fCfgSis('CONREM', varString) = 'C') Or
         (intTotalCarteiras > 1) Or
         (MatchStr(strCodBco, ['077','001API','097API','748API', '341API','756API','033API'])) Then
        LQryRetBcoGer.ParamByName('CARTEI').AsInteger := intCartei;
      If (Not fEmptyStr(strCarBco)) And
         (intTotalCarteiras > 1) Then
        LQryRetBcoGer.ParamByName('CARBCO').AsString := strCarBco;
      LQryRetBcoGer.ParamByName('CODBCO').AsString  := LeftStr(strCodBco, 3);
      LQryRetBcoGer.Open;

      LNomBanco := strNomBanco;
      LCodBco   := strCodBco;
      LOcoTar   := strOcoTar;
      FBaixaEmpresaCadastro := fGetBancoConfig(0, strConfig, 'BAIXAEMPCAD', 'N') = 'S';
      MarcaDuplicatas;

      strPorBai   := '';
      strCodEve   := '';

      {***********************************}
      {* FILTRANDO OCORRÊNCIAS POR BANCO *}
      {********************************AJ*}
      strSQL := strSQL + ' AND (' + fRetSQLOcoBancos(strCodBco, strConfig, strOcoTar, LOcoRet, strValOco05) + ')';

      {********************************************************************
      * APENAS DUPLICATAS DE EMPRESAS QUE O OPERADOR TEM DIREITO DE ACESSO*
      **************************************************RQ:183634******MT**}
      If (LeftStr(strCodBco, 3) = '237') Then
      Begin
        strSQL := strSQL + ' AND RET_CODEMP IN (' + untFuncAutban.fRetStrToSQLIn(fRetEmpAcessoUsuario(strLoginUsuarioLogado)) + ') ';  // DIREITO DE ACESSO A EMPRESA
        strSQL := strSQL + ' AND RET_CODEMP IN (' + untFuncAutban.fRetStrToSQLIn(fRetEmpAcessoCTR(strLoginUsuarioLogado)) + ') ';// DIREITO DE ACESSO PARA REALIZAR BAIXAS NA EMPRESA
      End;

      With qryRetBco Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        If (fCfgSis('CONREM', varString) = 'C')  Or
           (intTotalCarteiras > 1) Or
           (MatchStr(strCodBco, ['077','001API','097API','748API', '341API','756API','033API'])) Then
          ParamByName('CARTEI').AsInteger := intCartei;
        If (Not fEmptyStr(strCarBco)) And
           (intTotalCarteiras > 1) Then
          ParamByName('CARBCO').AsString := strCarBco;
        ParamByName('CODBCO').AsString := LeftStr(strCodBco, 3);
        Open;
      End;

      If Not qryRetBco.IsEmpty Then
      Begin

        fLockBaixaAutomatica(LeftStr(strCodBco, 3),False,True);

        {******************************************************}
        {* SELECIONANDO PORTADOR E PLANO DE CONTAS PARA BAIXA *}
        {***************************************************AJ*}
        If Not fSelecionaPortadorPlanodeContas(strConfig, cdsConRet, qryRetBco) Then
          Exit;

        blnExisteCadRec := False;
        fltTotalTarifa  := 0;
        strSeqLan := '';
        objGravacaoTarifa.strSeqLan := '';

      {**********************************************************************
       * Atualizando a configuração CFG_RCXCON, referente o intervalo de    *
       * registros da tabela RetBco, estamos fazendo assim para evitar      *
       * abrir e fechar uma transação toda vez que for baixar uma duplicata,*
       * gerando uma lentidão na baixa automática. Agora pegamos esse       *
       * intervalo de duplicatas e já deixamos a configuração CFG_RCXCON    *
       * pronta para outras rotinas e mantemos a baixa das duplicatas,      *
       * em uma transação só.                                               *
       ******************************************************Req.70105****KP*}
        if (fltTarifa = 0) or (blnBaiAna) then
        begin
          fStartTransaction;
          intSeqCon := StrToInt(fRetRcxCon);
          fAtuCfgSis('RCXCON', IntToStr(intSeqCon + (qryRetBco.RecordCount) + 1), VS_strCodEmp);

          {If Not blnBaiAna Then
            strSeqLan := fSeqContaBanco;}

          fCommit;
        end
        else
        begin
          fStartTransaction;
          intSeqCon := StrToInt(fRetRcxCon);
          strSeqLan := fSeqContaBanco;
          fCommit;
        end;

        if ((fltTarifa > 0) and  (not blnBaiAna)) then
        begin
          fStartTransaction;
          objGravacaoTarifa.strAutCtp  := fRetAutoIncrem('CADPAG', VS_strCodEmp);
          objGravacaoTarifa.intSeqConp := fRetCtpCon;
          fCommit;
        end;

        pContarReservasDoRetorno(qryRetBco, LQtdTitulos, LQtdLiquidacoes, FQuantidadeTarifas);

        pReservaAutoIncrem(FReservaBanCtr, 'BANCTR', LQtdLiquidacoes);
        pReservaAutoIncrem(FReservaLogCtr, 'LOGCTR', LQtdTitulos * 2);
        If blnBaiAna Then
        Begin
          pReservaAutoIncrem(FReservaMovBan, 'MOVBAN', LQtdLiquidacoes);
          pReservaSeqLan(FReservaSeqLan, LQtdLiquidacoes);
        End;

        fStartTransaction;
        blnComita := True;

        {colocar subfuncao}
        qryAux := fCriaQuery(Nil);

        blnUsaRet := fUsaTabelaOCORET(qryAux,
                                      LeftStr(strCodBco, 3));

        While Not qryRetBco.Eof Do
        Begin
          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  * ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  CADREC ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
          strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
          strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
          strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
          strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';

          qryCadRec.Close;
          qryCadRec.SQL.Clear;

          If Not LancamentoDeTarifa(LeftStr(strCodBco, 3),
                                    qryRetBco.FieldByName('RET_CODOCO').AsString,
                                    qryRetBco.FieldByName('RET_MOTOCO').AsString) Then
          Begin
            {**************************************************************}
            {* SOMENTE ITAÚ E OCORRÊNCIAS DE BAIXA SIMPLES OU CARTÓRIO, ***}
            {* FILTRA DUPLICATA JÁ BAIXADA NO SISTEMA, PARA LANÇAR TARIFA *}
            {*REQ*126006************************************************MO*}
            If (LeftStr(strCodBco, 3) = '341') And (Pos(qryRetBco.FieldByName('RET_CODOCO').AsString,'09_35') > 0) And (Not fGetBancoConfig(0, strConfig, 'ATUALIZA_DESPCOB', 'N').Equals('S')) Then
              strSQL := strSQL + '  AND CTR_VALDUP = 0 '
            Else
              strSQL := strSQL + '  AND CTR_VALDUP <> 0 ';
          End;

          qryCadRec.SQL.Add(strSQL);
          qryCadRec.ParamByName('NUMDUP').AsString := qryRetBco.FieldByName('RET_NUMDUP').AsString;
          qryCadRec.ParamByName('PARCEL').AsString := qryRetBco.FieldByName('RET_PARCEL').AsString;
          qryCadRec.ParamByName('ESPDOC').AsString := qryRetBco.FieldByName('RET_ESPDOC').AsString;
          qryCadRec.ParamByName('CODEMP').AsString := qryRetBco.FieldByName('RET_CODEMP').AsString;
          qryCadRec.ParamByName('CODCLI').AsString := qryRetBco.FieldByName('RET_CODCLI').AsString;
          qryCadRec.Open;

          If qryRetBco.FieldByName('RET_DUPDIV').AsString.Equals('S') And
            (Pos('DUPLICATA EM USO POR OUTRA ESTAÇÃO',qryRetBco.FieldByName('RET_MOTDIV').AsString) > 0) Then
          Begin
            pGravaNaoBai(qryRetBco, qryCadRec,qryRetBco.FieldByName('RET_MOTDIV').AsString, fltTarifa);
            qryRetBco.Next;
            Continue;
          End;

          If qryRetBco.FieldByName('RET_DUPDIV').AsString.Equals('S') And
            (Pos('NÃO TEM PERMISSÃO PARA FAZER BAIXA NA EMPRESA',qryRetBco.FieldByName('RET_MOTDIV').AsString) > 0) Then
          Begin
            pGravaNaoBai(qryRetBco, qryCadRec,qryRetBco.FieldByName('RET_MOTDIV').AsString, fltTarifa);
            qryRetBco.Next;
            Continue;
          End;

          If qryRetBco.FieldByName('RET_DUPDIV').AsString.Equals('S') And
            (Pos('DUPLICATA NÃO PERTENCE A EMPRESA LOGADA',qryRetBco.FieldByName('RET_MOTDIV').AsString) > 0) Then
          Begin
            pGravaNaoBai(qryRetBco, qryCadRec,qryRetBco.FieldByName('RET_MOTDIV').AsString, fltTarifa);
            qryRetBco.Next;
            Continue;
          End;

          pGetDiasParaCreditoOcorrencia01(strCodBco, qryRetBco.FieldByName('RET_CODOCO').AsString, intCartei);

          AtualizaQRCodeCADREC(qryCadRec.FieldByName('AUTOINCREM').AsString,
                               qryRetBco.FieldByName('RET_QRCODE').AsString);

          If LConsiderarDescontoSugerido Then
            CalculaValorCorrigido(qryRetBco);

          If SelecionaPortadorPlanoDeContasPorRegistro(strCodBco,strConfig) Then
              fSelecionaPortadorPlanodeContas(strConfig, cdsConRet, qryRetBco);

          If Not blnUsaRet Then
            strCodEve := qryCadRec.FieldByName('CTR_CODEVE').AsString
          Else
          Begin
            strCodEve := '';
            strCodPor := '';

            strCodEve := fRetornaCodEvento(qryAux,
                                           qryRetBco.FieldByName('RET_CODOCO').AsString,
                                           qryRetBco.FieldByName('RET_CODBCO').AsString,
                                           qryRetBco.FieldByName('RET_MOTOCO').AsString,
                                           intCartei);

            strCodPor := Copy(strCodEve, Pos('_', strCodEve) + 1);
            strCodEve := Copy(strCodEve, 1, Pos('_', strCodEve) - 1);

            If Not strCodEve.IsEmpty Then
            Begin

              If Not fAtualizaCodEve(qryAux,
                                     'CADREC',
                                     strCodEve,
                                     qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                                     qryCadRec.FieldByName('CTR_PARCEL').AsString,
                                     qryCadRec.FieldByName('CTR_ESPDOC').AsString,
                                     qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                     qryCadRec.FieldByName('CTR_CODCLI').AsString,
                                     qryCadRec.FieldByName('CTR_SEQBAI').AsInteger,
                                     strCodPor) Then
                Break
              Else
                untLogCtr.GravaLogCtr(fCampoTabela('AUTOINCREM', 'CADREC',
                                                   ['CTR_NUMDUP', 'CTR_PARCEL', 'CTR_ESPDOC', 'CTR_CODEMP', 'CTR_CODCLI', 'CTR_SEQBAI'],
                                                   [qryRetBco.FieldByName('RET_NUMDUP').AsString, qryRetBco.FieldByName('RET_PARCEL').AsString,
                                                   qryRetBco.FieldByName('RET_ESPDOC').AsString,qryRetBco.FieldByName('RET_CODEMP').AsString,
                                                   qryRetBco.FieldByName('RET_CODCLI').AsString, 0]),
                                                   'ATUALIZAÇÃO CENTRO DE CUSTO/PORTADOR',
                                                    Self.Name,
                                      '',
                                      0,
                                      0,
                                      '',
                                      '',
                                      Nil,
                                      fProximoAutoIncremReservado(FReservaLogCtr, qryRetBco.FieldByName('RET_CODEMP').AsString));

            End;
          End;

          If Not qryCadRec.IsEmpty Then
          Begin

            blnExisteCadRec := True;
            LLancarTarifasNaLiquidacao := LancarTarifasNaLiquidacao(qryRetBco.FieldByName('RET_CODBCO').AsString,
                                                                    qryRetBco.FieldByName('RET_CODOCO').AsString);

            LBaixaProtesto := (strCodBco = '001') And
                              (Pos(qryRetBco.FieldByName('RET_CODOCO').AsString,'98_') > 0);

            Try

              blnEstornoProtesto := False;
              blnCartorio := False;

              //TUDO ISSO AQUI DEVE SER MELHORADO
              If strCodBco = '104p400' Then
              Begin
                blnCartorio := Pos(qryRetBco.FieldByName('RET_CODOCO').AsString,'26_') > 0;
                blnEstornoProtesto := Pos(qryRetBco.FieldByName('RET_CODOCO').AsString,'28_') > 0;
                strNomBanco := 'CEF400p';
              End
              Else If strCodBco = '104' Then
              Begin
                blnCartorio := Pos(qryRetBco.FieldByName('RET_CODOCO').AsString,'23_') > 0;
                blnEstornoProtesto := Pos(qryRetBco.FieldByName('RET_CODOCO').AsString,'24_') > 0;
              End
              Else If (blnLancaTarifaNaConfirmacaoDoBanco) And
                      (qryRetBco.FieldByName('RET_CODOCO').AsString = '02') And
                      (qryRetBco.FieldByName('RET_CODBCO').AsString <> '341') And
                      (qryRetBco.FieldByName('RET_TARIFA').AsFloat > 0) And
                      (fEmptyStr(qryCadRec.FieldByName('CTR_CTPTXE').AsString))  Then
              Begin

                If qryRetBco.FieldByName('RET_CODBCO').AsString = '237' Then
                Begin
                  dtaDtaLan := 0;
                  dtaDtaTar := 0;
                  pAchaDataDeLancamentoETarifa;
                End;

                fltTarifa := qryRetBco.FieldByName('RET_TARIFA').AsFloat;

                SetLength(objGravacaoTarifa.arrDuplicatasTarifa,
                          Length(objGravacaoTarifa.arrDuplicatasTarifa) + 1);
                objGravacaoTarifa.arrDuplicatasTarifa[Length(objGravacaoTarifa.arrDuplicatasTarifa) - 1] := qryCadRec.FieldByName('AUTOINCREM').AsString;

                If blnBaiAna Then
                Begin
                  pLancaTarifaDoBoletoAnalitico(qryRetBco, qryCadRec,0,strConfig);
                  pAtualizaAutoIncremTarifasBoletosEmAberto;
                End
                Else
                Begin
                  fltTotalTarifa := fltTotalTarifa + qryRetBco.FieldByName('RET_TARIFA').AsFloat;
                  blnLancarTarifaSinteticaBoletoEmAberto := True;
                  objGravacaoTarifa.AOcorrencia          := qryRetBco.FieldByName('RET_CODOCO').AsString;
                  objGravacaoTarifa.dtaDtaOcoSintetica   := qryRetBco.FieldByName('RET_DTAOCO').AsDateTime;
                  objGravacaoTarifa.strDadosDuplicatas   := objGravacaoTarifa.strDadosDuplicatas  + '/' +
                                                            qryCadRec.FieldByName('CTR_NUMDUP').AsString +
                                                            qryCadRec.FieldByName('CTR_PARCEL').AsString + '-' +
                                                            qryCadRec.FieldByName('CTR_ESPDOC').AsString + '-' +
                                                            qryCadRec.FieldByName('CTR_CODEMP').AsString;
                End;
              End
              Else If strCodBco = '033B' Then
              Begin
                blnCartorio := Pos(qryRetBco.FieldByName('RET_CODOCO').AsString,'15_21_') > 0;
              End
              Else If LeftStr(strCodBco, 3) = '341' Then
              Begin
                blnCartorio := Pos(qryRetBco.FieldByName('RET_CODOCO').AsString,'23_') > 0 ;

                If (Pos(strOcoTar, '35') > 0) Then
                  LBaixaProtesto := Pos(qryRetBco.FieldByName('RET_CODOCO').AsString,'32_33_34_') > 0
                Else
                  LBaixaProtesto := Pos(qryRetBco.FieldByName('RET_CODOCO').AsString,'32_33_34_35_') > 0 ;

                // APENAS SE ESTIVER CONFIGURADO PARA CONSIDERAR A DATA DO RETORNO QUE VEM NO ARQUIVO. CAMPO DET_DTAVEN;
                If  (fGetBancoConfig(0, 'CONFIG341-' + IntToStr(intCartei), 'CONDTRET', 'N') = 'S')
                And (qryRetBco.FieldByName('RET_CODOCO').AsString = '04') Then
                Begin

                    dtVencRetDet := fRetornaDataVenctoRetDet(qryCadRec.FieldByName('AUTOINCREM').AsString,
                                                             qryRetBco.FieldByName('RET_NOMARQ').AsString);

                    If dtVencRetDet <> 0 Then
                    Begin
                       strSQL := '';
                       strSQL := strSQL + ' UPDATE CADREC ';
                       strSQL := strSQL + ' SET ';
                       strSQL := strSQL + '   CTR_DTAVEN = :DTVENC ';
                       strSQL := strSQL + ' WHERE ';
                       strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
                       strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
                       strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
                       strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
                       strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
                       strSQL := strSQL + '   AUTOINCREM = :AUTOIN ';

                       With qryUpdate Do
                       Begin
                         Close;
                         SQL.Clear;
                         SQL.Add(strSQL);
                         ParamByName('DTVENC').AsDateTime := dtVencRetDet;
                         ParamByName('AUTOIN').AsString   := qryCadRec.FieldByName('AUTOINCREM').AsString;
                         //ParamByName('NOSNUM').AsString   := qryRetBco.FieldByName('RET_NOSNUM').AsString;
                         ParamByName('NUMDUP').AsString   := qryCadRec.FieldByName('CTR_NUMDUP').AsString;
                         ParamByName('PARCEL').AsString   := qryCadRec.FieldByName('CTR_PARCEL').AsString;
                         ParamByName('ESPDOC').AsString   := qryCadRec.FieldByName('CTR_ESPDOC').AsString;
                         ParamByName('CODEMP').AsString   := qryCadRec.FieldByName('CTR_CODEMP').AsString;
                         ParamByName('CODCLI').AsString   := qryCadRec.FieldByName('CTR_CODCLI').AsString;
                         ExecSQL;
                         Close;
                       End;

                       {************************************************}
                       {* GRAVA LOG DA ALTERAÇÃO DA DATA DE VENCIMENTO *}
                       {************************************************}
                       untLogCtr.GravaLogCtr(qryCadRec.FieldByName('AUTOINCREM').AsString,
                                             'ATUALIZAÇÃO DE DATA DE VENCIMENTO (AUTBAN)',
                                             Self.Name,
                                             '',
                                             0,
                                             0,
                                             '',
                                             '',
                                             Nil,
                                             fProximoAutoIncremReservado(FReservaLogCtr, qryCadRec.FieldByName('CTR_CODEMP').AsString));

                    End;

                End;

                {****************************************************************}
                {* FEITA VALIDAÇÃO PARA O ITAU CASO A OCORRENCIA FOR 02 OU 04 E *}
                {* O NOSNUM DO CADREC FOR NULL, ATUALIZA O NOSNUM               *}
                {*************************************************************JU*}
                If ((MatchStr(qryRetBco.FieldByName('RET_CODOCO').AsString, ['02', '04'])) And
                   (fEmptyStr(qryCadRec.FieldByName('CTR_NOSNUM').AsString)))      Or
                   ((qryRetBco.FieldByName('RET_CODOCO').AsInteger In [15, 19, 24, 09, 35]) And
                    (Not DeveAtualizarDespesaDeCobranca(strCodBco.Equals('341') And (qryRetBco.FieldByName('RET_CODOCO').AsInteger In [33, 34, 35, 36]),
                                                        qryRetBco.FieldByName('RET_OUTVAL').AsFloat,
                                                        strCodBco,
                                                        strConfig))) Then
                Begin
                  If Not (qryRetBco.FieldByName('RET_CODOCO').AsInteger In [15, 19, 24, 09, 35]) Then
                  Begin
                    strSQL := '';
                    strSQL := strSQL + ' UPDATE CADREC ';
                    strSQL := strSQL + ' SET ';
                    strSQL := strSQL + '   CTR_NOSNUM = :NOSNUM ';

                    If MatchStr(qryRetBco.FieldByName('RET_CODOCO').AsString, ['02', '04']) Then
                      strSQL := strSQL + ', CTR_DTABOL = IF(CTR_DTABOL IS NULL, "' + FormatDateTime('yyyy/mm/dd', qryRetBco.FieldByName('RET_DTAOCO').AsDateTime) + '", CTR_DTABOL) ';

                    If blnUsaRet Then
                    Begin
                      If Not fEmptyStr(strCodEve) Then
                        strSQL := strSQL + ', CTR_CODEVE = ' + QuotedStr(strCodEve)
                      Else
                        strSQL := strSQL + ', CTR_CODEVE = NULL ';

                      If Not fEmptyStr(strCodPor) Then
                        strSQL := strSQL + ', CTR_CODPOR = ' + QuotedStr(strCodPor);
                    End;

                    strSQL := strSQL + ' WHERE ';
                    strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
                    strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
                    strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
                    strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
                    strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
                    strSQL := strSQL + '   CTR_SEQBAI = 0 ';

                    qryUpdate.Close;
                    qryUpdate.SQL.Text := strSQL;
                    qryUpdate.ParamByName('NOSNUM').AsString := qryRetBco.FieldByName('RET_NOSNUM').AsString;
                    qryUpdate.ParamByName('NUMDUP').AsString := qryCadRec.FieldByName('CTR_NUMDUP').AsString;
                    qryUpdate. ParamByName('PARCEL').AsString := qryCadRec.FieldByName('CTR_PARCEL').AsString;
                    qryUpdate.ParamByName('ESPDOC').AsString := qryCadRec.FieldByName('CTR_ESPDOC').AsString;
                    qryUpdate.ParamByName('CODEMP').AsString := qryCadRec.FieldByName('CTR_CODEMP').AsString;
                    qryUpdate.ParamByName('CODCLI').AsString := qryCadRec.FieldByName('CTR_CODCLI').AsString;

                    qryUpdate.ExecSQL;
                    qryUpdate.Close;

                    {**************************}
                    {* GRAVA LOG DA ALTERAÇÃO *}
                    {***********************JS*}
                    untLogCtr.GravaLogCtr(qryCadRec.FieldByName('AUTOINCREM').AsString,
                                          LDescricao + 'ATUALIZAÇÃO NOSSO NÚMERO (AUTBAN)',
                                          Self.Name,
                                          '',
                                          0,
                                          0,
                                          '',
                                          '',
                                          Nil,
                                          fProximoAutoIncremReservado(FReservaLogCtr, qryCadRec.FieldByName('CTR_CODEMP').AsString));


                    If LImprimeBoletoAutomaticamente Then
                    Begin
                      GravarTabelaImpressaoBoletoAutomatico(qryCadRec.FieldByName('AUTOINCREM').AsString);
                      LExecutarRoboImpressaoBoleto := True;
                    End;

                  End;


                  If Not ValidacaoParaLancamentoDeTarifaNaConfirmacao(blnLancaTarifaNaConfirmacaoDoBanco,
                                                                      qryRetBco,
                                                                      qryCadRec) Then
                  Begin

                    If ((qryRetBco.FieldByName('RET_TARIFA').AsFloat > 0) Or
                             (qryRetBco.FieldByName('RET_CUSCAR').AsFloat > 0)) Then
                    Begin

                      objCnfOco := objCnfDao.fBuscaPorOcorrencia(qryRetBco.FieldByName('RET_CODOCO').AsString); // tarifa sem tipo

                      If Not Assigned(objCnfOco) Then
                        objCnfOco := objCnfDao.fBuscaPorOcorrencia(qryRetBco.FieldByName('RET_CODOCO').AsString,'','',2);// tarifa boleto

                      If Assigned(objCnfOco) Then
                      Begin
                        If objCnfOco.blnGerpag Then
                        Begin
                          pGravaTarifa(objCnfOco,
                                       qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                       IIF(objCnfOco.blnCusCar, qryRetBco.FieldByName('RET_CUSCAR').AsFloat, qryRetBco.FieldByName('RET_TARIFA').AsFloat),
                                       fAcertaDataParaDiaUtil(qryRetBco.FieldByName('RET_DTAOCO').AsFloat+IIF(objCnfOco.blnUsaDia, intDiaCred, 0)),
                                       qryCadRec);
                        End;

                        objCnfOco.Free;
                      End;
                    End;

                    pApagaRetBco(LeftStr(strCodBco, 3),
                                 qryRetBco.FieldByName('RET_NUMDUP').AsString,
                                 qryRetBco.FieldByName('RET_PARCEL').AsString,
                                 qryRetBco.FieldByName('RET_ESPDOC').AsString,
                                 qryRetBco.FieldByName('RET_CODEMP').AsString,
                                 qryRetBco.FieldByName('RET_CODCLI').AsString,
                                 qryRetBco.FieldByName('RET_CODOCO').AsString,
                                 qryRetBco.FieldByName('RET_CNAB__').AsString,
                                 qryRetBco.FieldByName('RET_MOTOCO').AsString);

                    qryRetBco.Next;
                    Continue;
                  End;
                End;

                If ValidacaoParaLancamentoDeTarifaNaConfirmacao(blnLancaTarifaNaConfirmacaoDoBanco,
                                                                      qryRetBco,
                                                                      qryCadRec) Then
                Begin
                  fltTarifa := qryRetBco.FieldByName('RET_TARIFA').AsFloat;

                  SetLength(objGravacaoTarifa.arrDuplicatasTarifa,
                            Length(objGravacaoTarifa.arrDuplicatasTarifa) + 1);
                  objGravacaoTarifa.arrDuplicatasTarifa[Length(objGravacaoTarifa.arrDuplicatasTarifa) - 1] := qryCadRec.FieldByName('AUTOINCREM').AsString;

                  If blnBaiAna Then
                  Begin
                    pLancaTarifaDoBoletoAnalitico(qryRetBco, qryCadRec);
                    pAtualizaAutoIncremTarifasBoletosEmAberto;
                  End
                  Else
                  Begin
                    fltTotalTarifa := fltTotalTarifa + qryRetBco.FieldByName('RET_TARIFA').AsFloat;
                    blnLancarTarifaSinteticaBoletoEmAberto := True;
                    objGravacaoTarifa.AOcorrencia          := qryRetBco.FieldByName('RET_CODBCO').AsString;
                    objGravacaoTarifa.dtaDtaOcoSintetica   := qryRetBco.FieldByName('RET_DTAOCO').AsDateTime;
                    objGravacaoTarifa.strDadosDuplicatas   := objGravacaoTarifa.strDadosDuplicatas  + '/' +
                                                              qryCadRec.FieldByName('CTR_NUMDUP').AsString +
                                                              qryCadRec.FieldByName('CTR_PARCEL').AsString + '-' +
                                                              qryCadRec.FieldByName('CTR_ESPDOC').AsString + '-' +
                                                              qryCadRec.FieldByName('CTR_CODEMP').AsString;
                  End;


                  pApagaRetBco(LeftStr(strCodBco, 3),
                               qryRetBco.FieldByName('RET_NUMDUP').AsString,
                               qryRetBco.FieldByName('RET_PARCEL').AsString,
                               qryRetBco.FieldByName('RET_ESPDOC').AsString,
                               qryRetBco.FieldByName('RET_CODEMP').AsString,
                               qryRetBco.FieldByName('RET_CODCLI').AsString,
                               qryRetBco.FieldByName('RET_CODOCO').AsString,
                               qryRetBco.FieldByName('RET_CNAB__').AsString,
                               qryRetBco.FieldByName('RET_MOTOCO').AsString);

                  qryRetBco.Next;
                  Continue;
                End;

                //OCORRÊNCIA 48 LIQUIDAÇÃO PELO CEDENTE COM TRANSFERÊNCIA PARA COBRANÇA SIMPLES
                if (qryRetBco.FieldByName('RET_CODOCO').AsString = '48') then
                Begin

                  If qryCadRec.FieldByName('CTR_DESCON').AsString.Equals('S') Then
                    EstornoDuplicataDescontadaParaCobrancaSimples(qryRetBco, qryCadRec, '341', objCnfDao, intDiaCred);

                  pApagaRetBco(LeftStr(strCodBco, 3),
                               qryRetBco.FieldByName('RET_NUMDUP').AsString,
                               qryRetBco.FieldByName('RET_PARCEL').AsString,
                               qryRetBco.FieldByName('RET_ESPDOC').AsString,
                               qryRetBco.FieldByName('RET_CODEMP').AsString,
                               qryRetBco.FieldByName('RET_CODCLI').AsString,
                               qryRetBco.FieldByName('RET_CODOCO').AsString,
                               qryRetBco.FieldByName('RET_CNAB__').AsString,
                               qryRetBco.FieldByName('RET_MOTOCO').AsString);

                  qryRetBco.Next;
                  Continue;
                end;

              End
              Else If strCodBco = '756_240p' Then
              Begin
                If (qryRetBco.FieldByName('RET_CODOCO').AsString = '04') then
                Begin
                  EstornoDuplicataDescontadaParaCobrancaSimples(qryRetBco, qryCadRec, '756', objCnfDao, intDiaCred);

                  pApagaRetBco(LeftStr(strCodBco, 3),
                               qryRetBco.FieldByName('RET_NUMDUP').AsString,
                               qryRetBco.FieldByName('RET_PARCEL').AsString,
                               qryRetBco.FieldByName('RET_ESPDOC').AsString,
                               qryRetBco.FieldByName('RET_CODEMP').AsString,
                               qryRetBco.FieldByName('RET_CODCLI').AsString,
                               qryRetBco.FieldByName('RET_CODOCO').AsString,
                               qryRetBco.FieldByName('RET_CNAB__').AsString,
                               qryRetBco.FieldByName('RET_MOTOCO').AsString);

                  qryRetBco.Next;
                  Continue;
                end;
              End
              Else If fOcorrenciaParaRestaurarBoleto(strConfig, qryRetBco.FieldByName('RET_CODOCO').AsString)  Then
              Begin
                try
                  pRestaurarBoleto(qryCadRec.FieldByName('AUTOINCREM').AsString,
                                   LeftStr(strCodBco, 3),
                                   qryRetBco.FieldByName('RET_NUMDUP').AsString,
                                   qryRetBco.FieldByName('RET_PARCEL').AsString,
                                   qryRetBco.FieldByName('RET_ESPDOC').AsString,
                                   qryRetBco.FieldByName('RET_CODEMP').AsString,
                                   qryRetBco.FieldByName('RET_CODCLI').AsString,
                                   qryRetBco.FieldByName('RET_CODOCO').AsString,
                                   qryRetBco.FieldByName('RET_MOTOCO').AsString,
                                   qryRetBco.FieldByName('RET_CNAB__').AsString);
                except
                  on E: Exception do
                  begin
                    raise Exception.Create('Ocorreu um erro ao restaurar as duplicatas: ' + E.Message + ' [RestaurarBoleto]');
                  end;
                end;

                qryRetBco.Next;
                Continue;
              End
              Else If (strCodBco = '237') And (qryRetBco.FieldByName('RET_CODOCO').AsString = '09')  Then
              Begin
                EstornoDuplicataDescontadaParaCobrancaSimples(qryRetBco, qryCadRec, '237', objCnfDao, intDiaCred);

                pApagaRetBco(LeftStr(strCodBco, 3),
                             qryRetBco.FieldByName('RET_NUMDUP').AsString,
                             qryRetBco.FieldByName('RET_PARCEL').AsString,
                             qryRetBco.FieldByName('RET_ESPDOC').AsString,
                             qryRetBco.FieldByName('RET_CODEMP').AsString,
                             qryRetBco.FieldByName('RET_CODCLI').AsString,
                             qryRetBco.FieldByName('RET_CODOCO').AsString,
                             qryRetBco.FieldByName('RET_CNAB__').AsString,
                             qryRetBco.FieldByName('RET_MOTOCO').AsString);

                qryRetBco.Next;
                Continue;
              End
              Else If LeftStr(strCodBco, 3) = '422' Then
              Begin
                blnCartorio := Pos(qryRetBco.FieldByName('RET_CODOCO').AsString,'23_') > 0;

                If Pos(qryRetBco.FieldByName('RET_CODOCO').AsString,'21_') > 0 Then
                Begin
                  strSQL := '';
                  strSQL := strSQL + ' UPDATE CADREC ';
                  strSQL := strSQL + ' SET ';
                  strSQL := strSQL + '   CTR_HIST01 = :HIST01 ' ;
                  strSQL := strSQL + ' WHERE ';
                  strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
                  strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
                  strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
                  strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
                  strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
                  strSQL := strSQL + '   CTR_SEQBAI = 0 ';

                  With qryUpdate Do
                  Begin
                    Close;
                    SQL.Clear;
                    SQL.Add(strSQL);
                    ParamByName('HIST01').AsString := 'TRANSFERÊNCIA DE BENEFICIÁRIO ';
                    ParamByName('NUMDUP').AsString := qryCadRec.FieldByName('CTR_NUMDUP').AsString;
                    ParamByName('PARCEL').AsString := qryCadRec.FieldByName('CTR_PARCEL').AsString;
                    ParamByName('ESPDOC').AsString := qryCadRec.FieldByName('CTR_ESPDOC').AsString;
                    ParamByName('CODEMP').AsString := qryCadRec.FieldByName('CTR_CODEMP').AsString;
                    ParamByName('CODCLI').AsString := qryCadRec.FieldByName('CTR_CODCLI').AsString;
                    ExecSQL;
                    Close;
                  End;

                  {**************************}
                  {* GRAVA LOG DA ALTERAÇÃO *}
                  {***********************JS*}
                  untLogCtr.GravaLogCtr(qryCadRec.FieldByName('AUTOINCREM').AsString,
                                        'ATUALIZAÇÃO HISTÓRICO (AUTBAN)',
                                        Self.Name,
                                        '',
                                        0,
                                        0,
                                        '',
                                        '',
                                        Nil,
                                        fProximoAutoIncremReservado(FReservaLogCtr, qryCadRec.FieldByName('CTR_CODEMP').AsString));


                  pApagaRetBco(LeftStr(strCodBco, 3),
                               qryRetBco.FieldByName('RET_NUMDUP').AsString,
                               qryRetBco.FieldByName('RET_PARCEL').AsString,
                               qryRetBco.FieldByName('RET_ESPDOC').AsString,
                               qryRetBco.FieldByName('RET_CODEMP').AsString,
                               qryRetBco.FieldByName('RET_CODCLI').AsString,
                               qryRetBco.FieldByName('RET_CODOCO').AsString,
                               qryRetBco.FieldByName('RET_CNAB__').AsString,
                               qryRetBco.FieldByName('RET_MOTOCO').AsString);

                  qryRetBco.Next;
                  Continue;
                End;

              End
              Else
              Begin
                blnCartorio := Pos(qryRetBco.FieldByName('RET_CODOCO').AsString,'23_21_') > 0
              End;

              {**************************************************}
              {* CASO A OCORRENCIA FOR 02 OU 04 E               *}
              {* O NOSNUM DO CADREC FOR NULL, ATUALIZA O NOSNUM *}
              {***********************************************JB*}
              If (((strCodBco = '104p400') And (qryRetBco.FieldByName('RET_CODOCO').AsString = '01')) Or
                   (strCodBco <> '104p400')) And
                 (fEmptyStr(qryCadRec.FieldByName('CTR_NOSNUM').AsString)) Then
              Begin

                untFuncoesBoleto.strLinDig := '';
                strSQL := '';
                strSQL := strSQL + ' UPDATE CADREC ';
                strSQL := strSQL + ' SET ';
                strSQL := strSQL + '   CTR_NOSNUM = :NOSNUM ';

                If (qryRetBco.FieldByName('RET_CODOCO').AsString = '02') Then
                Begin
                  strSQL := strSQL + '  , CTR_DTABOL = :DTABOL ';
                  If (strCodBco = '033B') Then
                  Begin
                    {******************************************}
                    {* CALCULA LINHA DIGITAVEL PARA SANTANDER *}
                    {***************************************PA*}
                    untFuncoesBoleto.strNosNum := qryRetBco.FieldByName('RET_NOSNUM').AsString;
                    untFuncoesBoleto.strIdeBan := LeftStr(strCodBco,3);
                    untFuncoesBoleto.strMoeda1 := '9';
                    untFuncoesBoleto.strCodCed := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'NUMCTAC', '');
                    untFuncoesBoleto.strCodCar := fGetBancoConfig(0, 'CONFIG033B-' + IntToStr(intCartei), 'CODCART', '');
                    untFuncoesBoleto.strFatVen := CalcularFatorVencimento(StrToDateTime(qryRetBco.FieldByName('RET_DTAVEN').AsString)) ;
                    untFuncoesBoleto.strVlrTit := AnsiReplaceStr(qryRetBco.FieldByName('RET_VALDUP').AsString, '.', ',') ;
                    fltVlrTit := fStrToFloat(untFuncoesBoleto.strVlrTit);
                    untFuncoesBoleto.strVlrTit := fPadL(FloatToStr(fFormataFloat(fltVlrTit, 02) * 100), 14, '0');
                    untFuncoesBoleto.strVlrTit := RightStr(untFuncoesBoleto.strVlrTit,10);
                    If( fGeLiDi033B )Then
                    Begin
                      untFuncoesBoleto.strLinDig := untFuncoesBoleto.strLinDig;
                      untFuncoesBoleto.strLinDig := AnsiReplaceStr(strLinDig, '.', '');
                      untFuncoesBoleto.strLinDig := AnsiReplaceStr(strLinDig, ' ', '');
                    End;
                    If Not fEmptyStr(strLinDig) Then
                      strSQL := strSQL + '  , CTR_LINDIG = :LINDIG ';
                  End;
                End;

                If blnUsaRet Then
                Begin
                  If Not fEmptyStr(strCodEve) Then
                    strSQL := strSQL + ', CTR_CODEVE = ' + QuotedStr(strCodEve)
                  Else
                    strSQL := strSQL + ', CTR_CODEVE = NULL ';
                End;

                strSQL := strSQL + ' WHERE ';
                strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
                strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
                strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
                strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
                strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
                strSQL := strSQL + '   CTR_SEQBAI = 0 ';

                With qryUpdate Do
                Begin
                  Close;
                  SQL.Clear;
                  SQL.Add(strSQL);

                  If (qryRetBco.FieldByName('RET_CODOCO').AsString = '02') Then
                    ParamByName('DTABOL').AsDateTime:= qryRetBco.FieldByName('RET_DTAOCO').AsDateTime;

                  ParamByName('NOSNUM').AsString := qryRetBco.FieldByName('RET_NOSNUM').AsString;
                  ParamByName('NUMDUP').AsString := qryCadRec.FieldByName('CTR_NUMDUP').AsString;
                  ParamByName('PARCEL').AsString := qryCadRec.FieldByName('CTR_PARCEL').AsString;
                  ParamByName('ESPDOC').AsString := qryCadRec.FieldByName('CTR_ESPDOC').AsString;
                  ParamByName('CODEMP').AsString := qryCadRec.FieldByName('CTR_CODEMP').AsString;
                  ParamByName('CODCLI').AsString := qryCadRec.FieldByName('CTR_CODCLI').AsString;
                  If Not fEmptyStr(untFuncoesBoleto.strLinDig) Then
                    ParamByName('LINDIG').AsString := untFuncoesBoleto.strLinDig;
                  ExecSQL;
                  Close;
                End;

                {**************************}
                {* GRAVA LOG DA ALTERAÇÃO *}
                {***********************JS*}
                untLogCtr.GravaLogCtr(qryCadRec.FieldByName('AUTOINCREM').AsString,
                                      'ATUALIZAÇÃO NOSSO NÚMERO (AUTBAN)',
                                      Self.Name,
                                      '',
                                      0,
                                      0,
                                      '',
                                      '',
                                      Nil,
                                      fProximoAutoIncremReservado(FReservaLogCtr, qryCadRec.FieldByName('CTR_CODEMP').AsString));
              End;

              If ((strCodBco = '041') and (qryRetBco.FieldByName('RET_CODOCO').AsString = '30')) Then //somente 400p
              Begin

                strSQL := '';
                strSQL := strSQL + ' UPDATE CADREC ';
                strSQL := strSQL + ' SET ';
                strSQL := strSQL + '   CTR_HIST01 = :HIST01 ' ;
                strSQL := strSQL + ' WHERE ';
                strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
                strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
                strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
                strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
                strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
                strSQL := strSQL + '   CTR_SEQBAI = 0 ';

                With qryUpdate Do
                Begin
                  Close;
                  SQL.Clear;
                  SQL.Add(strSQL);
                  ParamByName('HIST01').AsString := 'COBRANÇA A CREDITAR (LIQUIDAÇÃO EM TRÂNSITO)';
                  ParamByName('NUMDUP').AsString := qryCadRec.FieldByName('CTR_NUMDUP').AsString;
                  ParamByName('PARCEL').AsString := qryCadRec.FieldByName('CTR_PARCEL').AsString;
                  ParamByName('ESPDOC').AsString := qryCadRec.FieldByName('CTR_ESPDOC').AsString;
                  ParamByName('CODEMP').AsString := qryCadRec.FieldByName('CTR_CODEMP').AsString;
                  ParamByName('CODCLI').AsString := qryCadRec.FieldByName('CTR_CODCLI').AsString;
                  ExecSQL;
                  Close;
                End;

                {**************************}
                {* GRAVA LOG DA ALTERAÇÃO *}
                {***********************JS*}
                untLogCtr.GravaLogCtr(qryCadRec.FieldByName('AUTOINCREM').AsString,
                                      'ATUALIZAÇÃO HISTÓRICO (AUTBAN)',
                                      Self.Name,
                                      '',
                                      0,
                                      0,
                                      '',
                                      '',
                                      Nil,
                                      fProximoAutoIncremReservado(FReservaLogCtr, qryCadRec.FieldByName('CTR_CODEMP').AsString));
              End;

              If (LeftStr(strCodBco, 3) = '341') And (qryRetBco.FieldByName('RET_CODOCO').AsString = '32') Then
              Begin
                LHistorico := '';

                If fEmptyStr(qryCadRec.FieldByName('CTR_HIST01').AsString) Then
                  LHistorico := 'PROTESTADO '
                Else
                  LHistorico := qryCadRec.FieldByName('CTR_HIST01').AsString + ' - ' + 'PROTESTADO ';

                AtualizaHistoricoDuplicata(LHistorico,
                                           qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                                           qryCadRec.FieldByName('CTR_PARCEL').AsString,
                                           qryCadRec.FieldByName('CTR_ESPDOC').AsString,
                                           qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                           qryCadRec.FieldByName('CTR_CODCLI').AsString,
                                           qryCadRec.FieldByName('AUTOINCREM').AsString);
              End;

              if MatchStr(strCodBco, ['001API']) then
              begin
                LDiferenca  := 0;
                LExisteDiferencaEntrePagoEEsperado := False;

                LValorRecebido := fFormataFloat(qryRetBco.FieldByName('RET_VALPAG').AsFloat, 2);
                if LValorRecebido > 0 THEN
                begin

                  LValorEsperado := qryCadRec.FieldByName('CTR_VALDUP').AsFloat;
                  if qryRetBco.FieldByName('RET_TARIFA').AsFloat > 0 then
                    LValorEsperado := LValorEsperado - qryRetBco.FieldByName('RET_TARIFA').AsFloat;

                  if qryRetBco.FieldByName('RET_JURMOR').AsFloat > 0 then
                    LValorEsperado := LValorEsperado + qryRetBco.FieldByName('RET_JURMOR').AsFloat;

                  if qryRetBco.FieldByName('RET_OUTVAL').AsFloat > 0 then
                    LValorEsperado := LValorEsperado + qryRetBco.FieldByName('RET_OUTVAL').AsFloat;

                  if qryRetBco.FieldByName('RET_DESCON').AsFloat > 0 then
                    LValorEsperado := LValorEsperado - qryRetBco.FieldByName('RET_DESCON').AsFloat;

                  LValorEsperado := fFormataFloat(LValorEsperado, 2);

                  LDiferenca := fFormataFloat(LValorRecebido - LValorEsperado, 2);

                  LExisteDiferencaEntrePagoEEsperado := (LDiferenca <> 0);
                  if LExisteDiferencaEntrePagoEEsperado then
                  begin
                    LDescricao := 'DIVERGÊNCIA NO VALOR TOTAL PAGO E ESPERADO';
                    pGravaNaoBai(qryRetBco, qryCadRec, LDescricao + ' (NÃO BAIXADOS)', fltTarifa);

                    AtualizaDivergenciaRetBco(qryRetBco.FieldByName('RET_NUMDUP').AsString,
                                              qryRetBco.FieldByName('RET_PARCEL').AsString,
                                              qryRetBco.FieldByName('RET_ESPDOC').AsString,
                                              qryRetBco.FieldByName('RET_CODEMP').AsString,
                                              qryRetBco.FieldByName('RET_CODCLI').AsString,
                                              LDescricao);

                    pApagaRetBco(LeftStr(strCodBco, 3),
                                 qryRetBco.FieldByName('RET_NUMDUP').AsString,
                                 qryRetBco.FieldByName('RET_PARCEL').AsString,
                                 qryRetBco.FieldByName('RET_ESPDOC').AsString,
                                 qryRetBco.FieldByName('RET_CODEMP').AsString,
                                 qryRetBco.FieldByName('RET_CODCLI').AsString,
                                 qryRetBco.FieldByName('RET_CODOCO').AsString,
                                 qryRetBco.FieldByName('RET_CNAB__').AsString,
                                 qryRetBco.FieldByName('RET_MOTOCO').AsString);

                    qryRetBco.Next;
                    Continue;
                  end;

                end;

              end;

              If ((qryRetBco.FieldByName('RET_CODOCO').AsString = '10') And (strCodBco = '237')) Or
                 ((qryRetBco.FieldByName('RET_CODOCO').AsString = '05') And (strCodBco = '033B')) Then
                blnUsaTarifa := True;

              If blnCartorio Or blnEstornoProtesto Then
              Begin
                If (blnUsaRet) and (blnCartorio) Then
                Begin
                  strCodEve := fRetornaCodEvento(qryAux,
                                                 qryRetBco.FieldByName('RET_CODOCO').AsString,
                                                 qryRetBco.FieldByName('RET_CODBCO').AsString,
                                                 qryRetBco.FieldByName('RET_MOTOCO').AsString);
                  strCodPor := Copy(strCodEve, Pos('_', strCodEve) + 1);
                  strCodEve := Copy(strCodEve, 1, Pos('_', strCodEve) - 1);
                End;

                strSQL := '';
                strSQL := strSQL + ' UPDATE CADREC ';
                strSQL := strSQL + ' SET ';
                strSQL := strSQL + '   CTR_HIST01 = ' + QuotedStr(qryCadRec.FieldByName('CTR_HIST01').AsString + ' - ' + IIF(blnEstornoProtesto, 'ESTORNO DE PROTESTO ', 'CARTORIO '));

                If (blnUsaRet) and (blnCartorio) Then
                Begin
                  If Not fEmptyStr(strCodEve) Then
                    strSQL := strSQL + ', CTR_CODEVE = ' + QuotedStr(strCodEve)
                  Else
                    strSQL := strSQL + ', CTR_CODEVE = NULL ';

                  If Not fEmptyStr(strCodPor) Then
                    strSQL := strSQL + ', CTR_CODPOR = ' + QuotedStr(strCodPor);
                End;

                If DeveAtualizarDespesaDeCobranca(blnCartorio,
                                                  qryRetBco.FieldByName('RET_OUTVAL').AsFloat,
                                                  strCodBco,
                                                  strConfig) Then
                  strSQL := strSQL + ' , CTR_DESCOB = :DESCOB ';

                strSQL := strSQL + ' WHERE ';
                strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
                strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
                strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
                strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
                strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
                strSQL := strSQL + '   CTR_SEQBAI = 0 ';

                qryUpdate.Close;
                qryUpdate.SQL.Clear;
                qryUpdate.SQL.Add(strSQL);
                qryUpdate.ParamByName('NUMDUP').AsString := qryCadRec.FieldByName('CTR_NUMDUP').AsString;
                qryUpdate.ParamByName('PARCEL').AsString := qryCadRec.FieldByName('CTR_PARCEL').AsString;
                qryUpdate.ParamByName('ESPDOC').AsString := qryCadRec.FieldByName('CTR_ESPDOC').AsString;
                qryUpdate.ParamByName('CODEMP').AsString := qryCadRec.FieldByName('CTR_CODEMP').AsString;
                qryUpdate.ParamByName('CODCLI').AsString := qryCadRec.FieldByName('CTR_CODCLI').AsString;

                LDescricao := 'ATUALIZAÇÃO HISTÓRICO';
                If DeveAtualizarDespesaDeCobranca(blnCartorio,
                                                  qryRetBco.FieldByName('RET_OUTVAL').AsFloat,
                                                  strCodBco,
                                                  strConfig) Then
                Begin
                  LDescricao := LDescricao + ' E/OU DESPESA COBRANÇA';

                  If (Not fEhDocumentoDesCobJaAtualizado(qryRetBco.FieldByName('RET_NUMDUP').AsString, qryRetBco.FieldByName('RET_PARCEL').AsString,
                                                         qryRetBco.FieldByName('RET_ESPDOC').AsString, qryRetBco.FieldByName('RET_CODEMP').AsString,
                                                         qryRetBco.FieldByName('RET_CODCLI').AsString, qryRetBco.FieldByName('RET_NOMARQ').AsString,
                                                         qryRetBco.FieldByName('RET_CODBCO').AsString, qryRetBco.FieldByName('RET_OUTVAL').AsFloat,
                                                         qryRetBco.FieldByName('RET_CODOCO').AsInteger)) Then
                    qryUpdate.ParamByName('DESCOB').AsFloat := qryCadRec.FieldByName('CTR_DESCOB').AsFloat + qryRetBco.FieldByName('RET_OUTVAL').AsFloat
                  Else
                    qryUpdate.ParamByName('DESCOB').AsFloat := qryCadRec.FieldByName('CTR_DESCOB').AsFloat;
                End;

                qryUpdate.ExecSQL;
                qryUpdate.Close;

                {**************************}
                {* GRAVA LOG DA ALTERAÇÃO *}
                {***********************JS*}
                untLogCtr.GravaLogCtr(qryCadRec.FieldByName('AUTOINCREM').AsString,
                                      LDescricao + '(AUTBAN)',
                                      Self.Name,
                                      '',
                                      0,
                                      0,
                                      '',
                                      '',
                                      Nil,
                                      fProximoAutoIncremReservado(FReservaLogCtr, qryCadRec.FieldByName('CTR_CODEMP').AsString));

                {***********************************************************************}
                {* LANÇA TAXAS AUXILIARES (COM TRATAMENTO PARA DUPLICATAS DESCONTADAS) *}
                {********************************************************************AJ*}
                If (blnUsaTarifa) Then
                  pLancaTarifasAuxiliares(qryRetBco, qryCadRec, objCnfDao, strCodBco, strOcoTar, intDiaCred);

              End

              Else If DeveAtualizarDespesaDeCobranca(LBaixaProtesto,
                                                     qryRetBco.FieldByName('RET_OUTVAL').AsFloat,
                                                     strCodBco,
                                                     strConfig) And
                 (Not fEhDocumentoDesCobJaAtualizado(qryRetBco.FieldByName('RET_NUMDUP').AsString, qryRetBco.FieldByName('RET_PARCEL').AsString,
                                                     qryRetBco.FieldByName('RET_ESPDOC').AsString, qryRetBco.FieldByName('RET_CODEMP').AsString,
                                                     qryRetBco.FieldByName('RET_CODCLI').AsString, qryRetBco.FieldByName('RET_NOMARQ').AsString,
                                                     qryRetBco.FieldByName('RET_CODBCO').AsString, qryRetBco.FieldByName('RET_OUTVAL').AsFloat,
                                                     qryRetBco.FieldByName('RET_CODOCO').AsInteger)) Then
              Begin
                AtualizaDespesasDeCobranca(qryCadRec,
                                           qryRetBco);
              End

              {***********************************************************************}
              {* LANÇA TAXAS AUXILIARES (COM TRATAMENTO PARA DUPLICATAS DESCONTADAS) *}
              {********************************************************************AJ*}
              Else If (blnUsaTarifa) And Not LLancarTarifasNaLiquidacao And
                      (((qryRetBco.FieldByName('RET_DUPDES').AsString = 'S') And
                        (Pos(qryRetBco.FieldByName('RET_CODOCO').AsString, strOcoTar) > 0)) Or
                      ((Pos(qryRetBco.FieldByName('RET_CODOCO').AsString, strOcoTar) > 0) And
                        Not(LeftStr(strCodBco, 3)  = '748') And Not (qryRetBco.FieldByName('RET_CODOCO').AsString = '02')) Or
                      ((qryRetBco.FieldByName('RET_CODOCO').AsString = '28') And
                        (qryRetBco.FieldByName('RET_MOTOCO').AsString <> '00') And
                        (LeftStr(strCodBco, 3) = '748') And
                        (qryRetBco.FieldByName('RET_VALPAG').AsFloat > 0))  Or
                      ((qryRetBco.FieldByName('RET_CODOCO').AsString = '10') And
                        (strCodBco = '237')) Or
                      ((qryRetBco.FieldByName('RET_CODOCO').AsString = '05') And
                        (strCodBco = '033B')) Or
                      ((Pos(qryRetBco.FieldByName('RET_CODOCO').AsString, strOcoTar) > 0)) And
                        (strCodBco = '237') Or
                      ((LeftStr(strCodBco, 3)  = '748') And (qryRetBco.FieldByName('RET_CODOCO').AsString = '28')) Or
                      ((Pos(qryRetBco.FieldByName('RET_CODOCO').AsString, strOcoTar) > 0) And
                       (strCodBco = '033B240p'))) Then
                pLancaTarifasAuxiliares(qryRetBco, qryCadRec, objCnfDao, strCodBco, strOcoTar, intDiaCred)

              //Se Ocorrencia 06 e baixa duplicata
              Else
              If ((qryRetBco.FieldByName('RET_VALPAG').AsFloat <> 0.0) And
                  (qryRetBco.FieldByName('RET_DTAPAG').Value <> Null)) Then
              Begin

                If blnUsaTarifa And
                   LLancarTarifasNaLiquidacao And
                  (Pos(qryRetBco.FieldByName('RET_CODOCO').AsString, strOcoTar) > 0) Then
                Begin
                  pLancaTarifasAuxiliares(qryRetBco, qryCadRec, objCnfDao, strCodBco, strOcoTar, intDiaCred);
                End;

                {***************************************************************************}
                {* SE TIVER VALOR DE PAGAMENTO E DATA DE PAGAMENTO, VERIFICA SE É 041_240, *}
                {* SE FOR SÓ BAIXA QUANDO FOR OCORRÊNCIA DE BAIXA 06, 09 E 17. *************}
                {* CASO CONTRÁRIO, NÃO BAIXA E EXIBE EM RELATÓRIO. *************************}
                {*REQ*148044*************************************************************MO*}
                If ((strCodBco = '041_240p') and (Pos(qryRetBco.FieldByName('RET_CODOCO').AsString,'06_09_17_') <= 0)) Or
                   ((strCodBco = '041') and (Pos(qryRetBco.FieldByName('RET_CODOCO').AsString,'33_') > 0)) Or
                   ((strCodBco = '341') and (Pos(qryRetBco.FieldByName('RET_CODOCO').AsString,'20_') > 0)) Then
                Begin
                  pGravaNaoBai(qryRetBco, qryCadRec,
                               IIF(qryCadRec.RecordCount > 1, 'BAIXA PARCIAL', 'OCORRÊNCIA '+ qryRetBco.FieldByName('RET_CODOCO').AsString + ' NÃO É OCORRÊNCIA DE BAIXA.') + ' (NÃO LIQUIDADO)', fltTarifa);

                  AtualizaDivergenciaRetBco(qryRetBco.FieldByName('RET_NUMDUP').AsString,
                                            qryRetBco.FieldByName('RET_PARCEL').AsString,
                                            qryRetBco.FieldByName('RET_ESPDOC').AsString,
                                            qryRetBco.FieldByName('RET_CODEMP').AsString,
                                            qryRetBco.FieldByName('RET_CODCLI').AsString,
                                            IIF(qryCadRec.RecordCount > 1, ' BAIXA PARCIAL', 'NÃO É OCORRÊNCIA DE BAIXA.'));

                  pApagaRetBco(LeftStr(strCodBco, 3),
                               qryRetBco.FieldByName('RET_NUMDUP').AsString,
                               qryRetBco.FieldByName('RET_PARCEL').AsString,
                               qryRetBco.FieldByName('RET_ESPDOC').AsString,
                               qryRetBco.FieldByName('RET_CODEMP').AsString,
                               qryRetBco.FieldByName('RET_CODCLI').AsString,
                               qryRetBco.FieldByName('RET_CODOCO').AsString,
                               qryRetBco.FieldByName('RET_CNAB__').AsString,
                               qryRetBco.FieldByName('RET_MOTOCO').AsString);

                  qryRetBco.Next;
                  Continue;
                end;

                // REQ. 146236 - MO
                // A CONFIG 'BAIXAOCO25' NÃO É MAIS UTILIZADA (Req.151476) - RP
               { if (strCodBco = '756_240p') And //BANCOOB 240
                   (qryRetBco.FieldByName('RET_CODOCO').AsString = '25') Then // OCORRÊNCIA 25 PROTESTADO E BAIXADO (BAIXA POR TER SIDO PROTESTADO)
                begin
                  If (fGetBancoConfig(0, 'CONFIG756_240p-' + IntToStr(intCartei), 'BAIXAOCO25', '') = 'N') then // CONFIGURAÇÃO PARA NÃO BAIXAR AUTOMATICAMENTE OCORRÊNCIA 25 }

                if fEhBancoQueIgnoraOcorrenciaNaBaixa(strCodbco) Then
                Begin
                  If Pos(qryRetBco.FieldByName('RET_CODOCO').AsString, fGetBancoConfig(0, 'CONFIG'+strCodbco+'-' + IntToStr(intCartei), 'OCOIGNORA', '')) > 0 Then
                  begin
                    pGravaNaoBai(qryRetBco, qryCadRec,
                                 IIF(qryCadRec.RecordCount > 1, 'BAIXA PARCIAL', 'OCORRÊNCIA '+ qryRetBco.FieldByName('RET_CODOCO').AsString +', CONFIGURADA PARA NÃO BAIXAR AUTOMATICAMENTE.'), fltTarifa);

                    //ATUALIZA DIVERGENCIA PARA 'S'
                    AtualizaDivergenciaRetBco(qryRetBco.FieldByName('RET_NUMDUP').AsString,
                                              qryRetBco.FieldByName('RET_PARCEL').AsString,
                                              qryRetBco.FieldByName('RET_ESPDOC').AsString,
                                              qryRetBco.FieldByName('RET_CODEMP').AsString,
                                              qryRetBco.FieldByName('RET_CODCLI').AsString,
                                              IIF(qryCadRec.RecordCount > 1, ' BAIXA PARCIAL', 'CONFIG. PARA NÃO BAIXAR AUTOMATICAMENTE'));

                    qryRetBco.Next;
                    Continue;
                  end
                  else
                  begin
                    //ATUALIZA DIVERGENCIA PARA 'N'
                    AtualizaDivergenciaRetBco(qryRetBco.FieldByName('RET_NUMDUP').AsString,
                                              qryRetBco.FieldByName('RET_PARCEL').AsString,
                                              qryRetBco.FieldByName('RET_ESPDOC').AsString,
                                              qryRetBco.FieldByName('RET_CODEMP').AsString,
                                              qryRetBco.FieldByName('RET_CODCLI').AsString,
                                              '',
                                              False);
                  end;
                end;

                If Not qryCadRec.FieldByName('CTR_TX_PIX').AsString.IsEmpty Then
                Begin
                  pGravaNaoBai(qryRetBco, qryCadRec,
                               'DUPLICATA COM PIX GERADO (NÃO LIQUIDADO)', fltTarifa);

                  AtualizaDivergenciaRetBco(qryRetBco.FieldByName('RET_NUMDUP').AsString,
                                            qryRetBco.FieldByName('RET_PARCEL').AsString,
                                            qryRetBco.FieldByName('RET_ESPDOC').AsString,
                                            qryRetBco.FieldByName('RET_CODEMP').AsString,
                                            qryRetBco.FieldByName('RET_CODCLI').AsString,
                                            'DUPLICATA COM PIX GERADO');
                  qryRetBco.Next;
                  Continue;
                End;

                fltValpag := qryRetBco.FieldByName('RET_VALPAG').AsFloat;

                blnBaiDivValores := ((fGetBancoConfig(0,'CONFIG' + strCodBco+IIF(blnBcoBra7d, 'D7', ''), 'BAIDIVAUT', '') = 'N') Or
                                     (fEmptyStr(fGetBancoConfig(0,'CONFIG' + strCodBco+IIF(blnBcoBra7d, 'D7', ''), 'BAIDIVAUT', ''))))  Or
                                    ((fGetBancoConfig(0,'CONFIG' + strCodBco+IIF(blnBcoBra7d, 'D7', ''), 'BAIDIVAUT', '') = 'S') And
                                     (strCodBco = '041') And
                                     (fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'VALPRCA', '') = 'S') And
                                     (fGetBancoConfig(0, 'CONFIG041-' + IntToStr(intCartei), 'DIVPRCA', '') = 'S') And
                                     ((qryRetBco.FieldByName('RET_CODOCO').AsString = '15') Or
                                      (qryRetBco.FieldByName('RET_CODOCO').AsString = '40')));

                If (Not blnBaiDivValores) And
                   ((qryCadRec.RecordCount > 1) Or (LUtilizaAlpe) Or
                    (fFormataFloat(fltValpag, 2) <>
                    (fFormataFloat(qryCadRec.FieldByName('CTR_VALDUP').AsFloat
                                   - IIF(qryRetBco.FieldByName('RET_TARIFA').AsFloat > 0, fltTarifa, 0)
                                   + qryRetBco.FieldByName('RET_JURMOR').AsFloat
                                   + qryRetBco.FieldByName('RET_OUTVAL').AsFloat
                                   - qryRetBco.FieldByName('RET_DESCON').AsFloat, 2))) Or
                   ((qryCadRec.FieldByName('CTR_VALORI').AsFloat =
                     qryCadRec.FieldByName('CTR_VALDUP').AsFloat) And
                     (qryRetBco.FieldByName('RET_VALDUP').AsFloat <>
                     qryCadRec.FieldByName('CTR_VALORI').AsFloat))) or
                   ((strCodBco = '041') And (qryRetBco.FieldByName('RET_CODOCO').AsString = '10'))   Then
                Begin
                  if ((strCodBco = '041') And (qryRetBco.FieldByName('RET_CODOCO').AsString = '10'))   Then
                  begin
                    pGravaNaoBai(qryRetBco, qryCadRec,
                                 IIF(qryCadRec.RecordCount > 1, 'BAIXA PARCIAL', 'OCORRÊNCIA 010 - BAIXADO CONFORME INSTRUÇÕES') + ' (NÃO LIQUIDADO)', fltTarifa);

                    AtualizaDivergenciaRetBco(qryRetBco.FieldByName('RET_NUMDUP').AsString,
                                              qryRetBco.FieldByName('RET_PARCEL').AsString,
                                              qryRetBco.FieldByName('RET_ESPDOC').AsString,
                                              qryRetBco.FieldByName('RET_CODEMP').AsString,
                                              qryRetBco.FieldByName('RET_CODCLI').AsString,
                                              IIF(qryCadRec.RecordCount > 1, ' BAIXA PARCIAL', ' OCORRÊNCIA 010 - BAIXADO CONFORME INSTRUÇÕES'));

                    pApagaRetBco(LeftStr(strCodBco, 3),
                                 qryRetBco.FieldByName('RET_NUMDUP').AsString,
                                 qryRetBco.FieldByName('RET_PARCEL').AsString,
                                 qryRetBco.FieldByName('RET_ESPDOC').AsString,
                                 qryRetBco.FieldByName('RET_CODEMP').AsString,
                                 qryRetBco.FieldByName('RET_CODCLI').AsString,
                                 qryRetBco.FieldByName('RET_CODOCO').AsString,
                                 qryRetBco.FieldByName('RET_CNAB__').AsString,
                                 qryRetBco.FieldByName('RET_MOTOCO').AsString);

                    qryRetBco.Next;
                    Continue;
                  end
                  else
                  begin
                    If LUtilizaAlpe Then
                    Begin
                      LValorDescontoAlpe := TBoletoAlpe.RetornaValorDescontoAlpeDuplicata(qryCadRec);

                      If Not fBetween(fFormataFloat(fltValpag, 2) -
                                      fFormataFloat(qryCadRec.FieldByName('CTR_VALDUP').AsFloat -
                                                    IIF(qryRetBco.FieldByName('RET_TARIFA').AsFloat > 0, fltTarifa + LValorTedAlpe, 0) -
                                                    LValorDescontoAlpe, 2),
                                      -0.01, 0.01) Then //feito isso por conta do arredondamento do float referente a terceira casa decimal
                      Begin
                        LDescricao := IIF(qryCadRec.RecordCount > 1, 'BAIXA PARCIAL', 'DIVERGÊNCIA DE VALORES');
                        If fFormataFloat(LValorDescontoAlpe, 2) <> fFormataFloat(qryRetBco.FieldByName('RET_DESCON').AsFloat, 2) Then
                          LDescricao := 'DIVERGÊNCIA DE PERCENTUAL DE DESCONTO ALPE'
                        Else If fFormataFloat(fltTarifa + LValorTedAlpe, 2) <> fFormataFloat(qryRetBco.FieldByName('RET_TARIFA').AsFloat, 2) Then
                          LDescricao := 'DIVERGÊNCIA DE TOTAL DE TARIFAS (BOLETO+TED) ALPE';

                        pGravaNaoBai(qryRetBco, qryCadRec, LDescricao + ' (NÃO BAIXADOS)', fltTarifa);

                        AtualizaDivergenciaRetBco(qryRetBco.FieldByName('RET_NUMDUP').AsString,
                                                  qryRetBco.FieldByName('RET_PARCEL').AsString,
                                                  qryRetBco.FieldByName('RET_ESPDOC').AsString,
                                                  qryRetBco.FieldByName('RET_CODEMP').AsString,
                                                  qryRetBco.FieldByName('RET_CODCLI').AsString,
                                                  LDescricao);

                        pApagaRetBco(LeftStr(strCodBco, 3),
                                     qryRetBco.FieldByName('RET_NUMDUP').AsString,
                                     qryRetBco.FieldByName('RET_PARCEL').AsString,
                                     qryRetBco.FieldByName('RET_ESPDOC').AsString,
                                     qryRetBco.FieldByName('RET_CODEMP').AsString,
                                     qryRetBco.FieldByName('RET_CODCLI').AsString,
                                     qryRetBco.FieldByName('RET_CODOCO').AsString,
                                     qryRetBco.FieldByName('RET_CNAB__').AsString,
                                     qryRetBco.FieldByName('RET_MOTOCO').AsString);

                        qryRetBco.Next;
                        Continue;
                      End;
                    End
                    Else
                    Begin
                      LDescricao := IIF(qryCadRec.RecordCount > 1, 'BAIXA PARCIAL', 'DIVERGÊNCIA DE VALORES');
                      If (qryRetBco.FieldByName('RET_TARIFA').AsFloat > 0) And (qryRetBco.FieldByName('RET_TARIFA').AsFloat <> fltTarifa) Then
                        LDescricao := 'DIVERGÊNCIA NO VALOR DA TARIFA COBRADA PELO BANCO';

                      pGravaNaoBai(qryRetBco, qryCadRec, LDescricao + ' (NÃO BAIXADOS)', fltTarifa);

                      AtualizaDivergenciaRetBco(qryRetBco.FieldByName('RET_NUMDUP').AsString,
                                                qryRetBco.FieldByName('RET_PARCEL').AsString,
                                                qryRetBco.FieldByName('RET_ESPDOC').AsString,
                                                qryRetBco.FieldByName('RET_CODEMP').AsString,
                                                qryRetBco.FieldByName('RET_CODCLI').AsString,
                                                LDescricao);

                      If DeveAtualizarDespesaDeCobranca(strCodBco.Equals('341') And (qryRetBco.FieldByName('RET_CODOCO').AsInteger In [33, 34, 35, 36]),
                                                      qryRetBco.FieldByName('RET_OUTVAL').AsFloat,
                                                      strCodBco,
                                                      strConfig) Then
                      Begin
                        If qryCadRec.RecordCount = 1 Then
                        Begin
                          If Not fEhDocumentoDesCobJaAtualizado(qryRetBco.FieldByName('RET_NUMDUP').AsString, qryRetBco.FieldByName('RET_PARCEL').AsString,
                                                                qryRetBco.FieldByName('RET_ESPDOC').AsString, qryRetBco.FieldByName('RET_CODEMP').AsString,
                                                                qryRetBco.FieldByName('RET_CODCLI').AsString, qryRetBco.FieldByName('RET_NOMARQ').AsString,
                                                                qryRetBco.FieldByName('RET_CODBCO').AsString, qryRetBco.FieldByName('RET_OUTVAL').AsFloat,
                                                                qryRetBco.FieldByName('RET_CODOCO').AsInteger) Then
                            AtualizaDespesasDeCobranca(qryCadRec, qryRetBco);
                        End;
                      End;

                      pApagaRetBco(LeftStr(strCodBco, 3),
                                   qryRetBco.FieldByName('RET_NUMDUP').AsString,
                                   qryRetBco.FieldByName('RET_PARCEL').AsString,
                                   qryRetBco.FieldByName('RET_ESPDOC').AsString,
                                   qryRetBco.FieldByName('RET_CODEMP').AsString,
                                   qryRetBco.FieldByName('RET_CODCLI').AsString,
                                   qryRetBco.FieldByName('RET_CODOCO').AsString,
                                   qryRetBco.FieldByName('RET_CNAB__').AsString,
                                   qryRetBco.FieldByName('RET_MOTOCO').AsString);

                      qryRetBco.Next;
                      Continue;
                    end;
                  End;
                End
                Else If (blnBaiDivValores) Then
                Begin

                  LValorDuplicata := qryCadRec.FieldByName('CTR_VALDUP').AsFloat;

                  If (strCodBco = '756_240p')  And fCfgSis('VALIMP', varBoolean) Then
                  Begin
                    LValorDuplicata := LValorDuplicata + qryCadRec.FieldByName('CTR_JURSUJ').AsFloat +
                                                         qryCadRec.FieldByName('CTR_DESCOB').AsFloat;
                  End;

                  If fFormataFloat(fltValpag
                                 + qryRetBco.FieldByName('RET_TARIFA').AsFloat, 2) <
                    (fFormataFloat(LValorDuplicata
                                 + qryRetBco.FieldByName('RET_JURMOR').AsFloat
                                 + qryRetBco.FieldByName('RET_OUTVAL').AsFloat
                                 - qryRetBco.FieldByName('RET_DESCON').AsFloat, 2)) Then
                  Begin
                    LDescricao := IIF(qryCadRec.RecordCount > 1, 'BAIXA PARCIAL', 'DIVERGÊNCIA DE VALORES');
                    If (qryRetBco.FieldByName('RET_TARIFA').AsFloat > 0) And (qryRetBco.FieldByName('RET_TARIFA').AsFloat <> fltTarifa) Then
                      LDescricao := 'DIVERGÊNCIA NO VALOR DA TARIFA COBRADA PELO BANCO';

                    pGravaNaoBai(qryRetBco, qryCadRec, LDescricao + ' (NÃO BAIXADOS)', fltTarifa);

                    AtualizaDivergenciaRetBco(qryRetBco.FieldByName('RET_NUMDUP').AsString,
                                              qryRetBco.FieldByName('RET_PARCEL').AsString,
                                              qryRetBco.FieldByName('RET_ESPDOC').AsString,
                                              qryRetBco.FieldByName('RET_CODEMP').AsString,
                                              qryRetBco.FieldByName('RET_CODCLI').AsString,
                                              LDescricao);

                    If DeveAtualizarDespesaDeCobranca(strCodBco.Equals('341') And (qryRetBco.FieldByName('RET_CODOCO').AsInteger In [33, 34, 35, 36]),
                                                      qryRetBco.FieldByName('RET_OUTVAL').AsFloat,
                                                      strCodBco,
                                                      strConfig) Then
                    Begin
                      If qryCadRec.RecordCount = 1 Then
                      Begin
                        If Not fEhDocumentoDesCobJaAtualizado(qryRetBco.FieldByName('RET_NUMDUP').AsString, qryRetBco.FieldByName('RET_PARCEL').AsString,
                                                              qryRetBco.FieldByName('RET_ESPDOC').AsString, qryRetBco.FieldByName('RET_CODEMP').AsString,
                                                              qryRetBco.FieldByName('RET_CODCLI').AsString, qryRetBco.FieldByName('RET_NOMARQ').AsString,
                                                              qryRetBco.FieldByName('RET_CODBCO').AsString, qryRetBco.FieldByName('RET_OUTVAL').AsFloat,
                                                              qryRetBco.FieldByName('RET_CODOCO').AsInteger) Then
                          AtualizaDespesasDeCobranca(qryCadRec, qryRetBco);
                      End;
                    End;

                    pApagaRetBco(LeftStr(strCodBco, 3),
                               qryRetBco.FieldByName('RET_NUMDUP').AsString,
                               qryRetBco.FieldByName('RET_PARCEL').AsString,
                               qryRetBco.FieldByName('RET_ESPDOC').AsString,
                               qryRetBco.FieldByName('RET_CODEMP').AsString,
                               qryRetBco.FieldByName('RET_CODCLI').AsString,
                               qryRetBco.FieldByName('RET_CODOCO').AsString,
                               qryRetBco.FieldByName('RET_CNAB__').AsString,
                               qryRetBco.FieldByName('RET_MOTOCO').AsString);

                    qryRetBco.Next;
                    Continue;
                  End
                  Else if fFormataFloat(fltValpag
                                      + qryRetBco.FieldByName('RET_TARIFA').AsFloat, 2) >
                         (fFormataFloat(qryRetBco.FieldByName('RET_VALDUP').AsFloat
                                      + qryRetBco.FieldByName('RET_JURMOR').AsFloat
                                      + qryRetBco.FieldByName('RET_OUTVAL').AsFloat
                                      - qryRetBco.FieldByName('RET_DESCON').AsFloat, 2)) Then
                  Begin
                    qryRetBco.Edit;

                    If (MatchStr(strCodBco,['341']) And fCfgSis('VALIMP', varBoolean)) And
                       (qryRetBco.FieldByName('RET_JURMOR').AsFloat > 0) And
                       (qryCadRec.FieldByName('CTR_JURSUJ').AsFloat > 0) Then
                    Begin
                      qryRetBco.FieldByName('RET_JURMOR').AsFloat := qryRetBco.FieldByName('RET_JURMOR').AsFloat +
                                                                     (qryRetBco.FieldByName('RET_VALPAG').AsFloat
                                                                   + qryRetBco.FieldByName('RET_TARIFA').AsFloat
                                                                     - (qryCadRec.FieldByName('CTR_VALDUP').AsFloat
                                                                      + qryRetBco.FieldByName('RET_JURMOR').AsFloat
                                                                      + qryRetBco.FieldByName('RET_OUTVAL').AsFloat
                                                                      - qryRetBco.FieldByName('RET_DESCON').AsFloat));
                    End

                    Else If (strCodBco = '756_240p') And (qryRetBco.FieldByName('RET_JURMOR').AsFloat > 0) Then
                    Begin
                      qryRetBco.FieldByName('RET_JURMOR').AsFloat := qryRetBco.FieldByName('RET_JURMOR').AsFloat +
                                                                     (qryRetBco.FieldByName('RET_VALPAG').AsFloat
                                                                     + qryRetBco.FieldByName('RET_TARIFA').AsFloat
                                                                     - (qryCadRec.FieldByName('CTR_VALDUP').AsFloat
                                                                      + qryRetBco.FieldByName('RET_JURMOR').AsFloat
                                                                      + qryRetBco.FieldByName('RET_OUTVAL').AsFloat
                                                                      - qryRetBco.FieldByName('RET_DESCON').AsFloat));
                    End
                    Else
                      qryRetBco.FieldByName('RET_JURMOR').AsFloat := qryRetBco.FieldByName('RET_VALPAG').AsFloat
                                                                   + qryRetBco.FieldByName('RET_TARIFA').AsFloat
                                                                     - (qryCadRec.FieldByName('CTR_VALDUP').AsFloat
                                                                      + qryRetBco.FieldByName('RET_JURMOR').AsFloat
                                                                      + qryRetBco.FieldByName('RET_OUTVAL').AsFloat
                                                                      - qryRetBco.FieldByName('RET_DESCON').AsFloat);
                    qryRetBco.Post;
                  End;
                End;

                {*********************************************************************
                * Incrementando o SeqCon, para se manter dentro do intevalo correto *
                *******************************************************Req.70105**KP*}
                if (fltTarifa = 0) or (blnBaiAna) then
                  intSeqCon := intSeqCon+1 ;

                strHisBai := (qryRetBco.FieldByName('RET_CODCLI').AsString + ' - ' +
                              qryRetBco.FieldByName('NOMCLI').AsString);

                If strCodBco = '033' Then
                  strNomBanco := 'Banespa'
                Else If strCodBco = '353' Then
                  strNomBanco := 'Santander'
                Else If strCodBco = '237_VENDOR' Then
                  strNomBanco := 'Bradesco 240p_VENDOR';

                If (GetValorPago(strCodBco,qryRetBco.FieldByName('RET_VALPAG').AsFloat,
                                           qryRetBco.FieldByName('RET_TARIFA').AsFloat,
                                           qryCadRec.FieldByName('CTR_VALDUP').AsFloat) < 0 ) Then
                Begin
                  fltValLan := - (qryRetBco.FieldByName('RET_VALPAG').AsFloat + qryRetBco.FieldByName('RET_TARIFA').AsFloat);
                  strCreDeb := 'D';
                End
                Else
                Begin
                  fltValLan := (qryRetBco.FieldByName('RET_VALPAG').AsFloat + qryRetBco.FieldByName('RET_TARIFA').AsFloat);
                  strCreDeb := 'C';
                End;

                //**********************************************//
                // SOMA NA DATA DO PAGAMENTO, O NÚMERO DE      *//
                // DIAS QUE O BANCO LEVA PARA CREDITAR O       *//
                // VALOR PAGO NA CONTA. ESSA É A DATA QUE SERÁ *//
                // GRAVADA NA TABELA MOVBAN. O NÚMERO DE DIAS  *//
                // É ALIMENTADO PELA CHAVE 'DIACRED' QUE ESTÁ  *//
                // NO ARQUIVO cnfbco.ini                       *//
                //*******************************************RL*//
                pAchaDataDeLancamentoETarifa;

                fltValLanBanCtr := qryRetBco.FieldByName('RET_VALDUP').AsFloat;

                if qryRetBco.FieldByName('RET_DESCON').AsFloat > 0.0 THEN
                  fltValLanBanCtr := fltValLanBanCtr - qryRetBco.FieldByName('RET_DESCON').AsFloat;

                if qryRetBco.FieldByName('RET_JURMOR').AsFloat > 0.0 Then
                  fltValLanBanCtr := fltValLanBanCtr + qryRetBco.FieldByName('RET_JURMOR').AsFloat;

                If strCodBco.Equals('748API') Then
                begin
                  if qryRetBco.FieldByName('RET_OUTVAL').AsFloat > 0 then
                    fltValLanBanCtr := fltValLanBanCtr + qryRetBco.FieldByName('RET_OUTVAL').AsFloat;
                end;

                {**********************************************************}
                {* MUDA O PORTADOR DE BAIXA PARA O PORTADOR DE DESCONTADA *}
                {* CASO CONFIGURADO PARA USAR O PORTADOR DE DESCONTADA ****}
                {* NO PORTADOR DE BAIXA, QUANDO FOR ITAU, EMPRESTIMO E ****}
                {* OCORRÊNCIA 06 ******************************************}
                {*REQ 135083 *******************************************MO*}
                If (qryRetBco.FieldByName('RET_CODBCO').AsString = '341') and
                   (qryRetBco.FieldByName('RET_DUPDES').AsString = 'S') and
                   (qryRetBco.FieldByName('RET_CODOCO').AsString = '06') and
                   (fGetBancoConfig(0, strConfig, 'PORDESPORBAI', '') = 'S') Then
                  strPorBai := strPorDes;

                If blnBaiAna Then
                Begin

                  objGravacaoTarifa.strAutCtp := '';
                 (*****************************************************************************
                  * Gerando o movimento do contas a pagar caso a configuração para tratamento *
                  * de tarifas esteja habilitada.                                             *
                  **************************************************************************KP*)
                  if ((fltTarifa > 0) and
                      (qryRetBco.FieldByName('RET_TARIFA').AsFloat > 0)) then
                  Begin
                    pLancaTarifaDoBoletoAnalitico(qryRetBco, qryCadRec, LValorTedAlpe);
                    strSeqLan  := objGravacaoTarifa.strSeqLan;
                  End;

                  LValorJurosOutrosValores := qryRetBco.FieldByName('RET_JURMOR').AsFloat;
                  If strCodBco.Equals('748API') Then
                  begin
                    if qryRetBco.FieldByName('RET_OUTVAL').AsFloat > 0 then
                      LValorJurosOutrosValores := LValorJurosOutrosValores + qryRetBco.FieldByName('RET_OUTVAL').AsFloat;
                  end;

                  If fCfgSis('JURSEP') = 'N' Then
                  Begin

                    //Só grava MOVBAN se a duplicata não foi descontada anteriormente ou se foi paga em cartório
                    If (qryCadRec.FieldByName('CTR_MOVDES').IsNull) Or (blnCartorio) Then
                    Begin
                      lstBanCtr[0].pClear;
                      lstBanCtr[0].fAdd(qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                                     qryCadRec.FieldByName('CTR_PARCEL').AsString,
                                     qryCadRec.FieldByName('CTR_ESPDOC').AsString,
                                     qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                     qryCadRec.FieldByName('CTR_CODCLI').AsString,
                                     qryCadRec.FieldByName('CTR_HIST01').AsString,
                                     qryCadRec.FieldByName('CTR_HIST02').AsString,
                                     qryCadRec.FieldByName('CTR_SEQBAI').AsInteger,
                                     fltValLanBanCtr);

                      lstBanCtr[0].fGetList.Last.strAutInc := fProximoAutoIncremReservado(FReservaBanCtr, qryCadRec.FieldByName('CTR_CODEMP').AsString);


                      strSeqLan := fGravaMovBan(strCtaBai,
                                                strPorBai,
                                                strOpeBai,
                                                dtaDtaLan,
                                                qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                                                strCreDeb,
                                                qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                                fltValLan,
                                                fPadR(strHisBai,40,''),
                                                '',
                                                qryCadRec.FieldByName('CTR_CODCLI').AsString,
                                                '',
                                                qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                                                0,
                                                qryCadRec.FieldByName('CTR_PARCEL').AsString,
                                                qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                                '',
                                                fProximoSeqLanReservado(FReservaSeqLan),
                                                strCodEve,
                                                lstBanCtr[0].fGetList,
                                                FormatDateTime('mm/yyyy',  dtaDtaLan),
                                                qryCadRec.FieldByName('CTR_SEQCON').AsInteger,
                                                fProximoAutoIncremReservado(FReservaMovBan, qryCadRec.FieldByName('CTR_CODEMP').AsString));
                    End;

                  End
                  Else If (strCodBco <> '341API') Or (qryCadRec.FieldByName('CTR_MOVDES').IsNull) Or (blnCartorio) Then //GRAVA JUROS E DESCONTO SEPARADOS NA MOVBAN
                  Begin

                    strSeqLan := fGravaMovBanJurDescSeparadosAnalitico(strCtaBai,
                                                                       strPorBai,
                                                                       strOpeBai,
                                                                       dtaDtaLan,
                                                                       fTime(),
                                                                       qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                                                                       qryCadRec.FieldByName('CTR_PARCEL').AsString,
                                                                       qryCadRec.FieldByName('CTR_ESPDOC').AsString,
                                                                       qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                                                       qryCadRec.FieldByName('CTR_CODCLI').AsString,
                                                                       qryCadRec.FieldByName('CTR_HIST01').AsString,
                                                                       qryCadRec.FieldByName('CTR_HIST01').AsString,
                                                                       fPadR(strHisBai,40,''),
                                                                       strCodEve,
                                                                       qryCadRec.FieldByName('AUTOINCREM').AsString,
                                                                       qryCadRec.FieldByName('CTR_SEQCON').AsInteger,
                                                                       qryCadRec.FieldByName('CTR_SEQBAI').AsInteger,
                                                                       fltValLanBanCtr, //fltValLan,
                                                                       LValorJurosOutrosValores,
                                                                       qryRetBco.FieldByName('RET_DESCON').AsFloat);

                  End;

                End
                Else
                Begin
                  if fltTarifa > 0 then
                  Begin
                    fltTotalTarifa := fltTotalTarifa + qryRetBco.FieldByName('RET_TARIFA').AsFloat + LValorTedAlpe;

                    objGravacaoTarifa.strDadosDuplicatas   := objGravacaoTarifa.strDadosDuplicatas  + '/' +
                                                              qryCadRec.FieldByName('CTR_NUMDUP').AsString +
                                                              qryCadRec.FieldByName('CTR_PARCEL').AsString + '-' +
                                                              qryCadRec.FieldByName('CTR_ESPDOC').AsString + '-' +
                                                              qryCadRec.FieldByName('CTR_CODEMP').AsString;
                  End;

                  //Só grava MOVBAN se a duplicata não foi descontada anteriormente ou se foi paga em cartório
                  If (qryCadRec.FieldByName('CTR_MOVDES').IsNull) Or (blnCartorio) Then
                  Begin

                    If fCfgSis('JURSEP') = 'N' Then
                    Begin

                      If stlRegMovBan.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan)) >= 0 Then
                      Begin
                        arrRegMovBan[stlRegMovBan.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].strPortad := strPorBai;
                        arrRegMovBan[stlRegMovBan.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].strCtaBai := strCtaBai;
                        arrRegMovBan[stlRegMovBan.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].fltValCtb := arrRegMovBan[stlRegMovBan.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].fltValCtb + fltValLan;
                      End
                      Else
                      Begin
                        stlRegMovBan.Add(strPorBai + strCtaBai  + FormatDateTime('yyyy-mm-dd', dtaDtaLan));
                        SetLength(lstBanCtr, Length(lstBanCtr) + 1);
                        lstBanCtr[Length(lstBanCtr)-1] := TBanCtrRepository.Create;
                        SetLength(arrRegMovBan, Length(arrRegMovBan) + 1);
                        arrRegMovBan[Length(arrRegMovBan)-1].strPortad := strPorBai;
                        arrRegMovBan[Length(arrRegMovBan)-1].strCtaBai := strCtaBai;
                        arrRegMovBan[Length(arrRegMovBan)-1].dtaDtaLan := dtaDtaLan;
                        arrRegMovBan[Length(arrRegMovBan)-1].fltValCtb := fltValLan;
                      End;

                      lstBanCtr[stlRegMovBan.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].fAdd(qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                                     qryCadRec.FieldByName('CTR_PARCEL').AsString,
                                     qryCadRec.FieldByName('CTR_ESPDOC').AsString,
                                     qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                     qryCadRec.FieldByName('CTR_CODCLI').AsString,
                                     qryCadRec.FieldByName('CTR_HIST01').AsString,
                                     qryCadRec.FieldByName('CTR_HIST02').AsString,
                                     qryCadRec.FieldByName('CTR_SEQBAI').AsInteger,
                                     fltValLanBanCtr);

                      lstBanCtr[stlRegMovBan.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].fGetList.Last.strAutInc := fProximoAutoIncremReservado(FReservaBanCtr, VS_strCodEmp);

                      fltValLanMovBan := fltValLanMovBan + fltValLan;

                    End
                    Else //GRAVA JUROS E DESCONTO SEPARADOS NA MOVBAN
                    Begin

                      fMovBanJurDescSeparadosSintetico(strCtaBai,
                                                       strPorBai,
                                                       strOpeBai,
                                                       dtaDtaLan,
                                                       fTime(),
                                                       qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                                                       qryCadRec.FieldByName('CTR_PARCEL').AsString,
                                                       qryCadRec.FieldByName('CTR_ESPDOC').AsString,
                                                       qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                                       qryCadRec.FieldByName('CTR_CODCLI').AsString,
                                                       qryCadRec.FieldByName('CTR_HIST01').AsString,
                                                       qryCadRec.FieldByName('CTR_HIST02').AsString,
                                                       qryCadRec.FieldByName('AUTOINCREM').AsString,
                                                       qryCadRec.FieldByName('CTR_SEQBAI').AsInteger,
                                                       fltValLan,
                                                       qryRetBco.FieldByName('RET_JURMOR').AsFloat,
                                                       qryRetBco.FieldByName('RET_DESCON').AsFloat
                                                      );

                      fltValLanMovBan := fltValLanMovBan + fltValLan;

                    End;

                  End;
                End;

                If ((Not fEmptyStr( strSeqLan )) Or (Not qryCadRec.FieldByName('CTR_MOVDES').IsNull)) Or
                   (Not blnBaiAna) Then
                Begin

                  fltValJur := 0.0;
                  fltValDes := 0.0;

                  If (fCfgSis('VALMEN') = 'S') And
                     (fFormataFloat(qryRetBco.FieldByName('RET_VALPAG').AsFloat +
                        IIF(blnUsaTarifa, qryRetBco.FieldByName('RET_TARIFA').AsFloat, 0), 2) <
                      qryCadRec.FieldByName('CTR_VALDUP').AsFloat) Then
                    pGravaNaoBai(qryRetBco, qryCadRec, 'BAIXADO COM VALOR MENOR AO VALOR DA DUPLICATA', fltTarifa);

                  fBaixaTotal(qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                              qryCadRec.FieldByName('CTR_PARCEL').AsString,
                              qryCadRec.FieldByName('CTR_ESPDOC').AsString,
                              qryCadRec.FieldByName('CTR_CODEMP').AsString,
                              qryCadRec.FieldByName('CTR_CODCLI').AsString,
                              qryCadRec.FieldByName('CTR_VALDUP').AsFloat,
                              qryRetBco.FieldByName('RET_VALPAG').AsFloat + qryRetBco.FieldByName('RET_OUTCOB').AsFloat + qryRetBco.FieldByName('RET_TARIFA').AsFloat,
                              qryRetBco.FieldByName('RET_JURMOR').AsFloat+fltValJur,
                              qryRetBco.FieldByName('RET_DESCON').AsFloat+fltValDes,
                              0,
                              0,
                              qryRetBco.FieldByName('RET_VALPAG').AsFloat + qryRetBco.FieldByName('RET_OUTCOB').AsFloat + qryRetBco.FieldByName('RET_TARIFA').AsFloat,
                              0,
                              0,
                              0,
                              IIF(blnSolDta, dtaDtaRec,
                                  IIF(Not fEmptyStr(qryRetBco.FieldByName('RET_DTAOCO').AsString),
                                                    qryRetBco.FieldByName('RET_DTAOCO').AsDateTime,
                                                    qryRetBco.FieldByName('RET_DTAPAG').AsDateTime)),
                              IIF(qryCadRec.FieldByName('CTR_MOVDES').IsNull,
                                  strSeqLan,
                                  ''),
                              fPadR(strHisBai,40,''),
                              strCtaBai,
                              strPorBai,
                              strOpeBai,
                              0,
                              False,
                              False,
                              True,
                              False,
                              False,
                              False,
                              0,
                              intSeqCon,
                              dtaDtaLan,
                              'N',
                              '',
                              '',
                              '',
                              IIF((Not fEmptyStr(objGravacaoTarifa.strAutCtp)) And (qryRetBco.FieldByName('RET_TARIFA').AsFloat > 0),
                                  objGravacaoTarifa.strAutCtp,
                                  ''),
                              True,
                              qryRetBco.FieldByName('RET_OUTVAL').AsFloat,
                              'N',
                              qryRetBco.FieldByName('RET_RECPIX').AsString,
                              qryRetBco.FieldByName('RET_END_ID').AsString,
                              qryRetBco.FieldByName('RET_RECPIX').AsString <> 'S',
                              LChaveCarteiraCompleta,
                              False);

                  TAtualizadorBolCtrLote.ObterInstancia.AdicionarParaAtualizar(qryCadRec.FieldByName('AUTOINCREM').AsString);

                  {**********************}
                  {* GRAVA LOG DA BAIXA *}
                  {*******************JS*}
                  untLogCtr.GravaLogCtr(qryCadRec.FieldByName('AUTOINCREM').AsString,
                                        'BAIXA TOTAL (AUTBAN)',
                                        Self.Name,
                                        '',
                                        0,
                                        0,
                                        '',
                                        '',
                                        Nil,
                                        fProximoAutoIncremReservado(FReservaLogCtr, qryCadRec.FieldByName('CTR_CODEMP').AsString));

                  If fCfgSis('UTICRM', varBoolean) And (Not fEmptyStr(fCfgSis('OCOFIN', varString)))  Then
                  Begin
                    untProcessaAtualizacaoOcorrenciasCRM.
                     TControllerDuplicatasPendentes.GetInstancia.
                      AdicionarDuplicata(
                       qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                       qryCadRec.FieldByName('CTR_ESPDOC').AsString,
                       qryCadRec.FieldByName('CTR_CODEMP').AsString,
                       qryCadRec.FieldByName('CTR_CODCLI').AsString,
                       qryCadRec.FieldByName('CTR_PARCEL').AsString,
                       strLoginUsuarioLogado,
                       qryRetBco.FieldByName('CLI_C_G_C_').AsString,
                       afcBaixaTotal, True);
                  End;

                  If Not fCfgSis('PERHBD', VarBoolean) Then
                    TAtualizadorDupCobLote.ObterInstancia.AdicionarParaAtualizar(qryCadRec.FieldByName('AUTOINCREM').AsString);

                  If fApagarBoletoDeAdiantamentoPedido() Then
                  Begin
                    fApagaDuplicataContasReceber(qryCadRec,'AUTBAN: BAIXA DUPLICATA/INCLUSAO DE ADIANTAMENTO (REMESSA AUTOMATICA - BOLETO DE ADIANTAMENTO)');

                    FillChar(documento, SizeOf(documento), #0);
                    FillChar(dadosAdiantamento, SizeOf(dadosAdiantamento), #0);

                    documento.strNumDoc := qryCadRec.FieldByName('CTR_NUMDUP').AsString;
                    documento.strEspDoc := qryCadRec.FieldByName('CTR_ESPDOC').AsString;
                    documento.strCodEmp := qryCadRec.FieldByName('CTR_CODEMP').AsString;
                    documento.strCodCli := qryCadRec.FieldByName('CTR_CODCLI').AsString;
                    documento.fltValLan := qryRetBco.FieldByName('RET_VALPAG').AsFloat +
                                           qryRetBco.FieldByName('RET_OUTCOB').AsFloat;

                    documento.fltValLan := IIF(documento.fltValLan > qryCadRec.FieldByName('CTR_VALDUP').AsFloat,
                                               qryCadRec.FieldByName('CTR_VALDUP').AsFloat,
                                               documento.fltValLan);

                    dadosAdiantamento.AddDocumento(documento);

                    dadosAdiantamento.strDescri :=
                      'AUTBAN: BAIXA DUPLICATA/INCLUSAO DE ADIANTAMENTO ' + fInfDup('NUMDUP', 'Docto.') +
                                                                            fInfDup('ESPDOC', 'Esp.') +
                                                                            fInfDup('PARCEL', 'Parc.') +
                                                                            fInfDup('CODEMP', 'Emp.') +
                                                                            fInfDup('NOSNUM', 'Nosso Nº') +
                                                                            fInfDup('DTABOL', 'Emiss.') +
                                                                            fInfDup('BCOBOL', 'Banco') +
                                                                            fInfDup('CARTEI', 'Cartei.') +
                                                                            fInfDup('BCOENV', 'Bco Envio') +
                                                                            fInfDup('DTAENV', 'Dta Envio') +
                                                                            fInfDup('LINDIG', 'Lin.Digit.');

                    dadosAdiantamento.strParcel := qryCadRec.FieldByName('CTR_PARCEL').AsString;
                    dadosAdiantamento.strNosNum := qryCadRec.FieldByName('CTR_NOSNUM').AsString;
                    dadosAdiantamento.strDtaBol := qryCadRec.FieldByName('CTR_DTABOL').AsString;
                    dadosAdiantamento.strBcoBol := qryCadRec.FieldByName('CTR_BCOBOL').AsString;
                    dadosAdiantamento.strBcoEnv := qryCadRec.FieldByName('CTR_BCOENV').AsString;
                    dadosAdiantamento.strDtaEnv := qryCadRec.FieldByName('CTR_DTAENV').AsString;
                    dadosAdiantamento.strCartei := qryCadRec.FieldByName('CTR_CARTEI').AsString;
                    dadosAdiantamento.strLinDig := qryCadRec.FieldByName('CTR_LINDIG').AsString;
                    dadosAdiantamento.strCodCed := qryCadRec.FieldByName('CTR_CODCED').AsString;
                    dadosAdiantamento.strOrigem := 'CTR';
                    dadosAdiantamento.strTipLan := 'C';
                    dadosAdiantamento.dtaDtaLan := VS_Date;
                    dadosAdiantamento.horHorLan := fTime();
                    dadosAdiantamento.strCodPor := strPorBai;
                    dadosAdiantamento.strCodCta := strCtaBai;
                    dadosAdiantamento.strOpeLan := strOpeBai;
                    dadosAdiantamento.strEmpLan := VS_strCodEmp;
                    dadosAdiantamento.intSeqCon := intSeqCon;
                    dadosAdiantamento.fltValDin := documento.fltValLan;
                    dadosAdiantamento.fltValChV := 0.00;
                    dadosAdiantamento.fltValChP := 0.00;
                    dadosAdiantamento.fltValCar := 0.00;
                    dadosAdiantamento.fltValOrd := 0.00;
                    dadosAdiantamento.fltValCre := 0.00;
                    dadosAdiantamento.fltValLan := documento.fltValLan;

                    dadosAdiantamento.RecebidoPorPix := False;

                    TAdiantamentoGenerico.fGravaAdiantamentoCliente(dadosAdiantamento);

                    TAdiantamentoGenerico.pAtualizaValorBoletosAdiantamentoDoPedido(documento.strNumDoc,
                      documento.strEspDoc, documento.strCodEmp, documento.strCodCli);
                  End;

                End;

              End;
            Except
              On E: Exception Do
              Begin
                Raise Exception.Create('[pBaixaAtuDup] - ' + E.Message);
                fLiberaLockBaixaAutomatica(LeftStr(strCodBco, 3));
                LiberaDuplicatas;
              End;
            End;

          End;

          pApagaRetBco(LeftStr(strCodBco, 3),
                       qryRetBco.FieldByName('RET_NUMDUP').AsString,
                       qryRetBco.FieldByName('RET_PARCEL').AsString,
                       qryRetBco.FieldByName('RET_ESPDOC').AsString,
                       qryRetBco.FieldByName('RET_CODEMP').AsString,
                       qryRetBco.FieldByName('RET_CODCLI').AsString,
                       qryRetBco.FieldByName('RET_CODOCO').AsString,
                       IIF( RightStr(strCodBco,3).Equals('API'), 'API',qryRetBco.FieldByName('RET_CNAB__').AsString),
                       qryRetBco.FieldByName('RET_MOTOCO').AsString);
          qryRetBco.Next;
        End;

        If ((Not blnBaiAna) And ((stlRegMovBan.Count > 0) Or (Assigned(stlRegMovBanSep) And (stlRegMovBanSep.Count > 0))) ) Or
           (blnLancarTarifaSinteticaBoletoEmAberto) Then
        Begin

          {***********************************************************************}
          {* "stlRegMovBan" nunca vai ser mais de "um" pois o código do banco é  *}
          {* passado por parâmetro, e é ele quem define o "strPorBai,strCtaBai"  *}
          {* CASO ESSA REGRA MUDAR, MUDAR A FORMA DE GRAVAR O LOG BANCÁRIO!      *}
          {********************************************************************RN*}

          If fCfgSis('JURSEP') = 'N' Then
          Begin

            For intCont := 0 To stlRegMovBan.Count -1 Do
            Begin
              If (intCont > 0) Then
                strSeqLan := fSeqContaBanco;

              fGravaMovBan(arrRegMovBan[intCont].strCtaBai,
                           arrRegMovBan[intCont].strPortad,
                           strOpeBai,
                           arrRegMovBan[intCont].dtaDtaLan,
                           '',
                           strCreDeb,
                           VS_strCodEmp,
                           arrRegMovBan[intCont].fltValCtb,
                           'BAIXA AUTOMATICA DE DUPLICATAS',
                           '',
                           '',
                           '',
                           '',
                           0,
                           '',
                           '',
                           '',
                           strSeqLan,
                           '',
                           lstBanCtr[intCont].fGetList,
                           FormatDateTime('mm/yyyy',  arrRegMovBan[intCont].dtaDtaLan));
            End;

          End
          Else
          Begin

            pGravaMovBanSinteticoBanco(strOpeBai);

          End;

          if ((fltTarifa > 0) and
              (fltTotalTarifa > 0)) then
          begin
            objGravacaoTarifa.strSeqPag  := fRetSequencialCadPag;

            objGravacaoTarifa.fltTotalTarifa := fltTotalTarifa;
            pLancaTarifaDoBoletoSintetico(strCodBco);
            If (blnLancaTarifaNaConfirmacaoDoBanco) Then
              pAtualizaAutoIncremTarifasBoletosEmAberto;
          end;


        End;

      End
      Else
      Begin
        blnExisteCadRec := False;
        blnImpMsg := True;
      End;

    Except
      On E: Exception Do
      Begin
        If blnComita Then
          fRollBack;
        fLiberaLockBaixaAutomatica(LeftStr(strCodBco, 3));
        LiberaDuplicatas;
        blnComita := False;
        blnExisteCadRec := False;
        pMensagensErro(E.Message, '[pBaixaAtuDup]');
      End;
    End;
  Finally
      TDeletorRetBco.ObterInstancia.ExecutarTodasPendentes;
      TDeletorRetBco.DestruirInstancia;

      TInseridorMovCtrLote.ObterInstancia.ExecutarTodasPendentes;
      TInseridorMovCtrLote.DestruirInstancia;

      TInseridorLogMcrLote.ObterInstancia.ExecutarTodasPendentes;
      TInseridorLogMcrLote.DestruirInstancia;

      TOCOBANCache.DestruirInstancia;

      If blnComita Then
        fCommit;

      TAtualizadorDupCobLote.ObterInstancia.ExecutarTodasPendentes;
      TAtualizadorDupCobLote.DestruirInstancia;

      TAtualizadorBolCtrLote.ObterInstancia.ExecutarTodasPendentes;
      TAtualizadorBolCtrLote.DestruirInstancia;

      untProcessaAtualizacaoOcorrenciasCRM.
       TControllerDuplicatasPendentes.GetInstancia.
        Processar;

      untProcessaAtualizacaoOcorrenciasCRM.
       TControllerDuplicatasPendentes.GetInstancia.
         LiberarInstancia;

    If (fGetBancoConfig(0,'CONFIG' + strCodBco+IIF(blnBcoBra7d, 'D7', ''), 'BAIDIVAUT', '') = 'S') And (Assigned(cdsNaoBai)) Then
    Begin
      If cdsNaoBai.RecordCount > 0 Then
      Begin
        fMensagem('ATENÇÃO', 'Existem duplicatas do arquivo retorno com divergência, Aguarde impressão do relatório para conferir o motivo.', ['&O K']);
        pMostraDupNBaixadas(Copy(strCodBco, 1, 3) + ' - ' + fRetNomBanco(LeftStr(strCodBco, 3)));
      End;
    End
    Else
    Begin
      If (Assigned(cdsNaoBai)) And (cdsNaoBai.RecordCount > 0) Then
      Begin
        fMensagem('ATENÇÃO', 'Existem duplicatas do arquivo retorno com divergência, Aguarde impressão do relatório para conferir o motivo.', ['&O K']);
        pMostraDupNBaixadas(Copy(strCodBco, 1, 3) + ' - ' + fRetNomBanco(LeftStr(strCodBco, 3)));
      End;
    End;

    If blnExisteCadRec Then
    Begin
      If Assigned(cdsNaoBai) Then
      Begin
        If (cdsNaoBai.RecordCount = qryRetBco.RecordCount) And (cdsNaoBai.RecordCount > 0) Then //If Not stlNaoBai.Count = qryRetBco.RecordCount Then
          fMensagem('ATENÇÃO','Foram encontradas divergências em todas as duplicatas deste arquivo retorno!',['&O K'])
        Else If (intContadorCarteiras = intTotalCarteiras) Then
          fMensagem('ATENÇÃO','Duplicatas baixadas/atualizadas com sucesso!',['&O K']);
      End
      Else If (intContadorCarteiras = intTotalCarteiras) Then
        fMensagem('ATENÇÃO','Duplicatas baixadas/atualizadas com sucesso!',['&O K']);
    End
    Else If (s033Oco10) And Not blnImpMsg Then
      fMensagem('ATENÇÃO','Duplicatas atualizadas com sucesso!',['&O K'])
    Else If blnImpMsg Or Not(blnExisteCadRec) Then
      fMensagem('ATENÇÃO','Não existe duplicata para ser baixada/atualizada!',['&O K']);

    If Not fEmptyStr(strCarBco) Then
    Begin
      qryGen := fCriaQuery(Nil);
      Try
        strSQL := 'SELECT RET_CODBCO FROM RETBCO WHERE RET_CODBCO = :CODBCO ';

        If fCfgSis('EMPIMP', varBoolean) Then
          strSQL := strSQL + ' AND RET_EMPIMP = ' + VS_strCodEmp.QuotedString;

        With qryGen Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('CODBCO').AsString := LeftStr(strCodBco, 3);
          Open;
        End;
        If Not qryGen.IsEmpty Then
        Begin
          If (LeftStr(strCodBco, 3) = '237') Then
            fMensagem('ATENÇÃO','Existem duplicatas que não foram baixadas/atualizadas! Verifique no relatório de Arquivo de Retorno a Carteira, Ocorrência e o Acesso do Operador a Empresa.',['&O K'])
          Else
            fMensagem('ATENÇÃO','Existem duplicatas que não foram baixadas/atualizadas! Verifique no relatório de Arquivo de Retorno a Carteira e a Ocorrência.',['&O K']);
        End;
      Finally
        FreeAndNil(qryGen);
      End;
    End;

    pRelatorioNosNum(Copy(strCodBco, 1, 3));

    If Assigned(qryAux) Then
      FreeAndNil(qryAux);

    FreeAndNil(qryRetBco);
    FreeAndNil(qryCadRec);
    FreeAndNil(qryUpdate);
    For intCont := 0 To Length(lstBanCtr) - 1 Do
      FreeAndNil(lstBanCtr[intCont]);
    SetLength(lstBanCtr, 0);
    if Assigned(lstBanCtp) then
      FreeAndNil(lstBanCtp);

    For intCont := 0 To Length(lstBanCtrSep) - 1 Do
      FreeAndNil(lstBanCtrSep[intCont]);
    SetLength(lstBanCtrSep, 0);

    For intCont := 0 To Length(lstBanCtrSepJur) - 1 Do
      FreeAndNil(lstBanCtrSepJur[intCont]);
    SetLength(lstBanCtrSepJur, 0);

    For intCont := 0 To Length(lstBanCtrSepDes) - 1 Do
      FreeAndNil(lstBanCtrSepDes[intCont]);
    SetLength(lstBanCtrSepDes, 0);

    frmWaitWindow.Close;
    frmWaitWindow.Free;
    If Assigned(objCnfDao) Then
      FreeAndNil(objCnfDao);

    pLimparReservasAutoIncrem;
  End;

  intDiaCred := 0;

  If Assigned(cdsConRet) Then
    FreeAndNil(cdsConRet);
  If Assigned(cdsNaoBai) Then
    FreeAndNil(cdsNaoBai);

  FreeAndNil(stlRegMovBan);
  pSetFocus(frmPrincipal);
  fLiberaLockBaixaAutomatica(LeftStr(strCodBco, 3));
  LiberaDuplicatas;

  If LExecutarRoboImpressaoBoleto Then
    untTMonitorGeraBoletos.TMonitorGeraBoletos.ExecutaMonitorGeraBoletos;

end;

{***************************************}
{* PROCEDURE BAIXA AUTOMATICA DUPLICATA*}
{************************************LB*}
procedure TfrmPrincipal.pBaixaAtuDupContasPagar(strCodBco: String; intCartei: Integer; strConfig: String = ''; AblnPGG : Boolean = False; ABancoAPI: Boolean = False);
  Var
    strSQL         : String;
    strHisBai      : String;
    strCtaBai      : String;
    strPorBai      : String;
    strOpeBai      : String;
    strCreDeb      : String;
    blnComita      : Boolean;
    fltValLan      : Double;
    intSeqBai,
    intSeqCon,
    intCrxCon      : Integer;
    strSeqLan      : String;
    blnExisteCadPag,
    blnComErro     : Boolean;
    qryRetCtp      : TUniQuery;
    qryCadPag      : TUniQuery;
    qryUpdate      : TUniQuery;
    blnBaiAna      : Boolean;
    stlRegMovBan   : TStringList;
    fltValLanMovBan: Double;
    arrRegMovBan   : Array Of TBaixa;
    lstBanCtp      : Array of TBanCtpRepository;
    intCont        : Integer;
    LGerarMovBanDesmembrado: Boolean;
    LDuplicataDesmembrada: TDuplicataDesmembrada;
    LListaDesmembramentosDuplicata: TDesmembramentosDuplicata;
begin
  stlRegMovBan    := TStringList.Create;
  blnExisteCadPag := False;
  blnComita       := False;
  blnComErro      := False;
  blnBaiAna       := (fCfgSis('CTP_AS') = 'A');
  LGerarMovBanDesmembrado := (fCfgSis('PRBAMB') = '1');
  fltValLanMovBan := 0;
  SetLength(arrRegMovBan, 0);

  pCriarFormularios(TfrmWaitWindow, frmWaitWindow);
  frmWaitWindow.lblTexto.Caption := 'Aguarde, Efetuando Baixa de Duplicatas...';
  AnimateWindow(frmWaitWindow.Handle, 200, AW_BLEND);
  frmWaitWindow.Show;
  frmWaitWindow.tmrWait.Enabled := False;
  frmWaitWindow.Refresh;

  //FECHAMENTO FINANCEIRO
  if FechamentoFinanceiroJaRealizado(intCartei, 0, '', LeftStr(strCodBco, 3), 'P') then
  Begin
    frmWaitWindow.Close;
    frmWaitWindow.Free;
    Exit;
  End;

  Try
    Try
      qryRetCtp := fCriaQuery(Self);
      qryCadPag := fCriaQuery(Self);
      qryUpdate := fCriaQuery(Self);

      If blnBaiAna Then
      Begin
        SetLength(lstBanCtp, 1);
        lstBanCtp[0] := TBanCtpRepository.Create;
      End;

      strSQL := '';
      strSQL := strSQL + 'SELECT ';
      strSQL := strSQL + '  RETCTP.*, ';
      strSQL := strSQL + '  CADFOR.FOR_NOMFOR AS NOMFOR ';
      strSQL := strSQL + 'FROM ';
      strSQL := strSQL + '  RETCTP ';
      strSQL := strSQL + '  JOIN CADFOR ON CADFOR.FOR_CODFOR = RETCTP.RET_CODFOR ';
      strSQL := strSQL + 'WHERE ';

      If AblnPGG Then
        strSQL := strSQL + '  RET_BCOPGG = RET_CODBCO AND '
      Else
        strSQL := strSQL + '  RET_BCOPGG IS NULL AND ';

      strSQL := strSQL + '  RET_CODBCO = :CODBCO AND ';
      strSQL := strSQL + '  RET_DTAPAG IS NOT NULL AND ';

      If ABancoAPI Then
        strSQL := strSQL + '  RET_TIPLAY = "API" AND '
      Else
        strSQL := strSQL + '  RET_TIPLAY IS NULL AND ';

      {***************************************}
      {* TRATAMENTO PARA CODIGOS DE          *}
      {* OCORRENCIA                          *}
      {************************************LB*}
      If Pos(Copy(strCodBco, 1, 3), '341_033_756_001_104_') > 0 Then
        strSQL := strSQL + '  RET_CODOCO = "00" AND ' // 00 = PAGAMENTO EFETUADO
      Else If Pos(Copy(strCodBco, 1, 3), '237_') > 0 Then
        strSQL := strSQL + '  RET_CODOCO IN ("00","5THF") AND '
      Else If Pos(Copy(strCodBco, 1, 3), '422_') > 0 Then
        strSQL := strSQL + '  LOCATE(RET_CODOCO, "01_17_18_") > 0 AND ';
      strSQL := strSQL + '  RET_VALPAG <> 0 ';

      With qryRetCtp Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODBCO').AsString := Copy(strCodBco, 1, 3);
        Open;
      End;

      If Not qryRetCtp.IsEmpty Then
      Begin
        strSeqLan := '';
        //Pegando os sequenciais e atualizando o banco para não travar a baixa
        fStartTransaction;
        intSeqCon := fRetCtpCon;
        intCrxCon := StrToInt(fRetRcxCon);
        If Not blnBaiAna Then 
          strSeqLan := fSeqContaBanco;
        fCommit;

        fStartTransaction;
        blnComita := True;

        While Not qryRetCtp.Eof Do
        Begin
          strSQL := '';
          strSQL := strSQL + 'SELECT ';
          strSQL := strSQL + '  * ';
          strSQL := strSQL + 'FROM ';
          strSQL := strSQL + '  CADPAG ';
          strSQL := strSQL + 'WHERE ';
          strSQL := strSQL + '  CTP_NUMDUP = :NUMDUP AND ';
          strSQL := strSQL + '  CTP_PARCEL = :PARCEL AND ';
          strSQL := strSQL + '  CTP_CODEMP = :CODEMP AND ';
          strSQL := strSQL + '  CTP_CODFOR = :CODFOR AND ';
          strSQL := strSQL + '  CTP_SEQBAI = :SEQBAI AND ';
          strSQL := strSQL + '  CTP_SERIE_ = :SERIE_ AND ';
          strSQL := strSQL + '  CTP_VALDUP <> 0 ';

          With qryCadPag Do
          Begin
            Close;
            SQL.Clear;
            SQL.Add(strSQL);
            ParamByName('NUMDUP').AsString := qryRetCtp.FieldByName('RET_NUMDUP').AsString;
            ParamByName('PARCEL').AsString := qryRetCtp.FieldByName('RET_PARCEL').AsString;
            ParamByName('CODEMP').AsString := qryRetCtp.FieldByName('RET_CODEMP').AsString;
            ParamByName('CODFOR').AsString := qryRetCtp.FieldByName('RET_CODFOR').AsString;
            ParamByName('SEQBAI').AsString := qryRetCtp.FieldByName('RET_SEQBAI').AsString;
            ParamByName('SERIE_').AsString := qryRetCtp.FieldByName('RET_SERIE_').AsString;
            Open;
          End;

          If Not qryCadPag.IsEmpty Then
          Begin
            blnExisteCadPag := True;

            //Se ocorrência 00 - Pagamento Efetuado
            If fOcorrenciaContasAPagarValida(qryRetCtp.FieldByName('RET_CODBCO').AsString,
                                             qryRetCtp.FieldByName('RET_CODOCO').AsString) Then
            Begin
              strHisBai := (qryRetCtp.FieldByName('RET_CODFOR').AsString + ' - ' +
                            qryRetCtp.FieldByName('NOMFOR').AsString);
              strCtaBai := '';

              {******************************************************************************************************}
              {* Quando estiver sintético, considerar o plano de contas do cadastro da carteira. ********************}
              {* Quando estiver analítico, considerar o plano de contas do cadastro da duplicata no contas a pagar. *}
              {* Sendo analítico e não tem plano de contas no cadastro da cduplicata ********************************}
              {* considerar o cadastrado na carteira, para que a rotina automática seja realizada com sucesso. ******}
              {**REQ*115659***************************************************************************************MO*}
              If blnBaiAna Then
              Begin
                strPorBai := RetornaPortadorParaBaixa(strCodBco, intCartei,ABancoApi);

                if not fEmptyStr(qryCadPag.FieldByName('CTP_CODCTA').AsString) then
                  strCtaBai := qryCadPag.FieldByName('CTP_CODCTA').AsString
                else
                  strCtaBai := RetornaPlanoContasParaBaixa(strCodBco, intCartei,ABancoApi);
              End
              Else
              Begin
                If fEmptyStr(strConfig) Then
                Begin
                  {tirar isso futuramente}
                  //antes de colocar mais um IF AQUI, verifique o Else do IF anterior
                  strCtaBai := RetornaPlanoContasParaBaixa(strCodBco, intCartei,ABancoApi);
                  strPorBai := RetornaPortadorParaBaixa(strCodBco, intCartei,ABancoApi);
                End
                Else
                Begin
                  strPorBai := fGetBancoConfig(0, strConfig, 'PORBAI_', '');
                  strCtaBai := fGetBancoConfig(0, strConfig, 'CTABAI_', '');
                End;
              End;

              strOpeBai := strLoginUsuarioLogado;

              If ( qryRetCtp.FieldByName('RET_VALPAG').AsFloat < 0 ) Then
              Begin
                fltValLan := - qryRetCtp.FieldByName('RET_VALPAG').AsFloat;
                strCreDeb := 'C';
              End
              Else
              Begin
                fltValLan := qryRetCtp.FieldByName('RET_VALPAG').AsFloat;
                strCreDeb := 'D';
              End;

              dtaDtaLan := fAcertaDataParaDiaUtil(qryRetCtp.FieldByName('RET_DTAPAG').AsDateTime + intDiaCred);

              LDuplicataDesmembrada.Numero := qryRetCtp.FieldByName('RET_NUMDUP').AsString;
              LDuplicataDesmembrada.Parcela := qryRetCtp.FieldByName('RET_PARCEL').AsString;
              LDuplicataDesmembrada.Fornecedor := qryRetCtp.FieldByName('RET_CODFOR').AsString;
              LDuplicataDesmembrada.Empresa := qryRetCtp.FieldByName('RET_CODEMP').AsString;
              LDuplicataDesmembrada.Serie := qryRetCtp.FieldByName('RET_SERIE_').AsString;
              LDuplicataDesmembrada.Historico1 := qryCadPag.FieldByName('CTP_HIST01').AsString;
              LDuplicataDesmembrada.Historico2 := qryCadPag.FieldByName('CTP_HIST02').AsString;
              LDuplicataDesmembrada.Competencia := qryCadPag.FieldByName('CTP_COMPET').AsString;

              LListaDesmembramentosDuplicata := nil;
              If blnBaiAna And LGerarMovBanDesmembrado Then
                LListaDesmembramentosDuplicata := TDesmembramentosDuplicata.RetornarDemembramentosDeDuplicata(LDuplicataDesmembrada);

              If Assigned(LListaDesmembramentosDuplicata) Then
              Begin
                Try
                  LListaDesmembramentosDuplicata.DataLancamento := dtaDtaLan;
                  LListaDesmembramentosDuplicata.ValorBaixa := fltValLan;
                  LListaDesmembramentosDuplicata.PortadorBaixa := strPorBai;
                  LListaDesmembramentosDuplicata.OperadorBaixa := strOpeBai;
                  LListaDesmembramentosDuplicata.EmpresaBaixa := VS_strCodEmp;
                  LListaDesmembramentosDuplicata.HistoricoBaixa := fPadR(strHisBai, 40, '');
                  LListaDesmembramentosDuplicata.SequenciaConciliacao := intSeqCon;

                  strSeqLan := LListaDesmembramentosDuplicata.GerarMovBanParaCadaDesmembramento(fGravaMovBan);
                Finally
                  FreeAndNil(LListaDesmembramentosDuplicata);
                End;
              End
              Else
              Begin
                intSeqBai := untCadPag.fRetSeqBaiCadPag(qryCadPag.FieldByName('CTP_NUMDUP').AsString,
                                                        qryCadPag.FieldByName('CTP_PARCEL').AsString,
                                                        qryCadPag.FieldByName('CTP_CODEMP').AsString,
                                                        qryCadPag.FieldByName('CTP_CODFOR').AsString,
                                                        qryCadPag.FieldByName('CTP_SERIE_').AsString);
                If blnBaiAna Then
                Begin
                  lstBanCtp[0].pClear;
                  lstBanCtp[0].fAdd(qryCadPag.FieldByName('CTP_NUMDUP').AsString,
                                    qryCadPag.FieldByName('CTP_PARCEL').AsString,
                                    qryCadPag.FieldByName('CTP_SERIE_').AsString,
                                    qryCadPag.FieldByName('CTP_CODEMP').AsString,
                                    qryCadPag.FieldByName('CTP_CODFOR').AsString,
                                    qryCadPag.FieldByName('CTP_HIST01').AsString,
                                    qryCadPag.FieldByName('CTP_HIST02').AsString,
                                    qryCadPag.FieldByName('CTP_CODCTA').AsString,
                                    VS_strCodEmp,
                                    qryCadPag.FieldByName('CTP_SEQBAI').AsInteger,
                                    qryRetCtp.FieldByName('RET_VALPAG').AsFloat,
                                    qryRetCtp.FieldByName('RET_VALPAG').AsFloat,
                                    0,
                                    0,
                                    0);

                  strSeqLan := fGravaMovBan(strCtaBai,
                                            strPorBai,
                                            strOpeBai,
                                            dtaDtaLan,
                                            qryCadPag.FieldByName('CTP_NUMDUP').AsString,
                                            strCreDeb,
                                            qryCadPag.FieldByName('CTP_CODEMP').AsString,
                                            fltValLan,
                                            fPadR(strHisBai,40,''),
                                            '',
                                            '',
                                            qryCadPag.FieldByName('CTP_CODFOR').AsString,
                                            qryCadPag.FieldByName('CTP_NUMDUP').AsString,
                                            intSeqBai,
                                            qryCadPag.FieldByName('CTP_PARCEL').AsString,
                                            qryCadPag.FieldByName('CTP_CODEMP').AsString,
                                            qryCadPag.FieldByName('CTP_SERIE_').AsString,
                                            '',
                                            qryCadPag.FieldByName('CTP_CODEVE').AsString,
                                            lstBanCtp[0].fGetList,
                                            qryCadPag.FieldByName('CTP_COMPET').AsString,
                                            intSeqCon);
                End
                Else
                Begin
                  If stlRegMovBan.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan)) >= 0 Then
                  Begin
                    arrRegMovBan[stlRegMovBan.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].strPortad := strPorBai;
                    arrRegMovBan[stlRegMovBan.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].strCtaBai := strCtaBai;
                    arrRegMovBan[stlRegMovBan.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].fltValCtb := arrRegMovBan[stlRegMovBan.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].fltValCtb + fltValLan;
                  End
                  Else
                  Begin
                    stlRegMovBan.Add(strPorBai + strCtaBai  + FormatDateTime('yyyy-mm-dd', dtaDtaLan));
                    SetLength(lstBanCtp, Length(lstBanCtp) + 1);
                    lstBanCtp[Length(lstBanCtp)-1] := TBanCtpRepository.Create;
                    SetLength(arrRegMovBan, Length(arrRegMovBan) + 1);
                    arrRegMovBan[Length(arrRegMovBan)-1].strPortad := strPorBai;
                    arrRegMovBan[Length(arrRegMovBan)-1].strCtaBai := strCtaBai;
                    arrRegMovBan[Length(arrRegMovBan)-1].dtaDtaLan := dtaDtaLan;
                    arrRegMovBan[Length(arrRegMovBan)-1].fltValCtb := fltValLan;
                  End;

                  lstBanCtp[stlRegMovBan.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].fAdd(qryCadPag.FieldByName('CTP_NUMDUP').AsString,
                                                                                                                        qryCadPag.FieldByName('CTP_PARCEL').AsString,
                                                                                                                        qryCadPag.FieldByName('CTP_SERIE_').AsString,
                                                                                                                        qryCadPag.FieldByName('CTP_CODEMP').AsString,
                                                                                                                        qryCadPag.FieldByName('CTP_CODFOR').AsString,
                                                                                                                        qryCadPag.FieldByName('CTP_HIST01').AsString,
                                                                                                                        qryCadPag.FieldByName('CTP_HIST02').AsString,
                                                                                                                        qryCadPag.FieldByName('CTP_CODCTA').AsString,
                                                                                                                        VS_strCodEmp,
                                                                                                                        qryCadPag.FieldByName('CTP_SEQBAI').AsInteger,
                                                                                                                        qryRetCtp.FieldByName('RET_VALPAG').AsFloat,
                                                                                                                        qryRetCtp.FieldByName('RET_VALPAG').AsFloat,
                                                                                                                        0,
                                                                                                                        0,
                                                                                                                        0);

                  fltValLanMovBan := fltValLanMovBan + fltValLan;
                End;
              End;

              If (Not fEmptyStr( strSeqLan )) Or (Not blnBaiAna) Then
              Begin
                pBaixaTotal(qryCadPag.FieldByName('CTP_NUMDUP').AsString,
                            qryCadPag.FieldByName('CTP_PARCEL').AsString,
                            qryCadPag.FieldByName('CTP_CODEMP').AsString,
                            qryCadPag.FieldByName('CTP_CODFOR').AsString,
                            qryCadPag.FieldByName('CTP_SERIE_').AsString,
                            qryRetCtp.FieldByName('RET_VALDUP').AsFloat,
                            qryRetCtp.FieldByName('RET_VALPAG').AsFloat,
                            qryRetCtp.FieldByName('RET_DTAPAG').AsDateTime,
                            strPorBai,
                            fPadR(strHisBai,40,''),
                            '',
                            strSeqLan,
                            strCtaBai,
                            strOpeBai,
                            '',
                            '',
                            intSeqCon,
                            0,
                            0,
                            intCrxCon,
                            0,
                            qryRetCtp.FieldByName('RET_VALPAG').AsFloat,
                            0,
                            0,
                            0,
                            0,
                            0,
                            qryCadPag.FieldByName('CTP_OUTENT').AsFloat);

                pGravaLogCtp(qryCadPag.FieldByName('AUTOINCREM').AsString,
                             'BAIXA TOTAL - AUTBAN');
              End;

            End;

          End;

          pApagaRetCtp(LeftStr(strCodBco, 3),
                       qryRetCtp.FieldByName('RET_NUMDUP').AsString,
                       qryRetCtp.FieldByName('RET_PARCEL').AsString,
                       qryRetCtp.FieldByName('RET_SERIE_').AsString,
                       qryRetCtp.FieldByName('RET_CODEMP').AsString,
                       qryRetCtp.FieldByName('RET_CODFOR').AsString);

          qryRetCtp.Next;
        End;

        If (Not blnBaiAna) And (stlRegMovBan.Count > 0) Then
        Begin
          For intCont := 0 To stlRegMovBan.Count -1 Do
          Begin
            If  arrRegMovBan[intCont].fltValCtb < 0 Then
              StrCreDeb := 'C'
            Else
              StrCreDeb := 'D';

            If (intCont > 0) Then
              strSeqLan := fSeqContaBanco;

            fGravaMovBan(arrRegMovBan[intCont].strCtaBai,
                         arrRegMovBan[intCont].strPortad,
                         strOpeBai,
                         arrRegMovBan[intCont].dtaDtaLan,
                         '',
                         strCreDeb,
                         VS_strCodEmp,
                         arrRegMovBan[intCont].fltValCtb,
                         'BAIXA AUTOMATICA DE DUPLICATAS',
                         '',
                         '',
                         '',
                         '',
                         0,
                         '',
                         '',
                         '',
                         strSeqLan,
                         '',
                         lstBanCtp[intCont].fGetList,
                         FormatDateTime('mm/yyyy',  arrRegMovBan[intCont].dtaDtaLan),
                         intSeqCon);
          End;
        End;

      End;

    Finally
      If blnComita Then
        fCommit;
    End;

  Except
  On E: Exception Do
    Begin
      If blnComita Then
        fRollBack;

      blnComErro := True;

      fMensagem('ATENÇÃO','Ocorreu o seguinte erro ao baixar as duplicatas: ' + e.Message, ['&O K']);
    End;
  End;

  If Not blnComErro Then
  Begin
    If blnExisteCadPag Then
      fMensagem('ATENÇÃO','Duplicatas baixadas com sucesso!',['&O K'])
    Else
      fMensagem('ATENÇÃO','Não existe duplicata para ser baixada!',['&O K']);
  End;

  frmWaitWindow.Close;
  frmWaitWindow.Free;

  FreeAndNil(stlRegMovBan);
  FreeAndNil(qryRetCtp);
  FreeAndNil(qryCadPag);
  FreeAndNil(qryUpdate);

  For intCont := 0 To Length(lstBanCtp) - 1 Do
    FreeAndNil(lstBanCtp[intCont]);

  SetLength(lstBanCtp, 0);

  pSetFocus(frmPrincipal);
end;

procedure TfrmPrincipal.pGravaLogCtp(AAutoIncremCadPag, strDescricaoLog: String);
begin
  Try
    untLogCtp.GravaLogCtp(AAutoIncremCadPag,
                          strDescricaoLog,
                          Self.Name);
  Except
    On E: Exception Do
      pMensagensErro(E.Message,'[frmPrincipal.pGravaLogCtp]');
  End;
end;


procedure TfrmPrincipal.pGravaNaoBai(qryRetBco,
                                     qryCadRec: TUniQuery;
                                     strDescri: String;
                                     ATarifaCarteira: Double);
  Var
    LUsaTarifa: Boolean;
begin
  try
    LUsaTarifa := fCfgSis('ENCBAN') = 'S';

    cdsNaoBai.Append;
    cdsNaoBai.FieldByName('CTR_NUMDUP').AsString := qryCadRec.FieldByName('CTR_NUMDUP').AsString;
    cdsNaoBai.FieldByName('CTR_PARCEL').AsString := qryCadRec.FieldByName('CTR_PARCEL').AsString;
    cdsNaoBai.FieldByName('CTR_ESPDOC').AsString := qryCadRec.FieldByName('CTR_ESPDOC').AsString;
    cdsNaoBai.FieldByName('CTR_CODEMP').AsString := qryCadRec.FieldByName('CTR_CODEMP').AsString;
    cdsNaoBai.FieldByName('CTR_CODCLI').AsString := qryCadRec.FieldByName('CTR_CODCLI').AsString;
    cdsNaoBai.FieldByName('CTR_DTACAD').AsString := qryCadRec.FieldByName('CTR_DTACAD').AsString;
    cdsNaoBai.FieldByName('CTR_DTAVEN').AsString := qryCadRec.FieldByName('CTR_DTAVEN').AsString;
    cdsNaoBai.FieldByName('CTR_DTAREC').AsString := qryRetBco.FieldByName('RET_DTAPAG').AsString;
    cdsNaoBai.FieldByName('CTR_NOSNUM').AsString := qryRetBco.FieldByName('RET_NOSNUM').AsString;
    cdsNaoBai.FieldByName('CTR_VALDUP').AsString := qryCadRec.FieldByName('CTR_VALDUP').AsString;
    cdsNaoBai.FieldByName('CTR_VALREC').AsString := qryRetBco.FieldByName('RET_VALPAG').AsString;
    cdsNaoBai.FieldByName('CTR_TARIFA').AsFloat  := 0.00;

    cdsNaoBai.FieldByName('TARIFA_CARTEIRA').AsFloat := 0.00;

    If LUsaTarifa Then
    Begin
      cdsNaoBai.FieldByName('CTR_VALREC').AsFloat := cdsNaoBai.FieldByName('CTR_VALREC').AsFloat +
                                                     qryRetBco.FieldByName('RET_TARIFA').AsFloat;
      cdsNaoBai.FieldByName('CTR_TARIFA').AsFloat := qryRetBco.FieldByName('RET_TARIFA').AsFloat;

      cdsNaoBai.FieldByName('TARIFA_CARTEIRA').AsFloat := ATarifaCarteira;
    End;
                                                    IIF(fCfgSis('ENCBAN') = 'S', qryRetBco.FieldByName('RET_TARIFA').AsFloat, 0);
    cdsNaoBai.FieldByName('CTR_VALJUR').AsString := qryRetBco.FieldByName('RET_JURMOR').AsString;
    cdsNaoBai.FieldByName('CTR_VALDES').AsString := qryRetBco.FieldByName('RET_DESCON').AsString;
    cdsNaoBai.FieldByName('CLI_NOMCLI').AsString := qryCadRec.FieldByName('CTR_CODCLI').AsString + '-' +
                                                    fRetNomCliente(qryCadRec.FieldByName('CTR_CODCLI').AsString);
    cdsNaoBai.FieldByName('DESCRI').AsString     := strDescri;
    cdsNaoBai.Post;

    untLogCtr.GravaLogCtr(qryCadRec.FieldByName('AUTOINCREM').AsString,
                          strDescri + ' (AUTBAN)',
                          Self.Name,
                          '',
                          0,
                          0,
                          '',
                          '',
                          Nil,
                          fProximoAutoIncremReservado(FReservaLogCtr, qryCadRec.FieldByName('CTR_CODEMP').AsString));
  except
    On E: Exception do
      raise Exception.Create('Problemas ao gravar duplicatas que não serão baixadas. ' + E.Message);
  end;
end;

procedure TfrmPrincipal.pGravaTarifa(objCnfOco: TCnfOco;
                                     strCodEmp: String;
                                     fltValTar: Double;
                                     dteDtaLan: TDate;
                                     qryCadRec: TDataset;
                                     AblnHistoricoEstorno: Boolean = False);
Var
  strSeqPag: String;
  strAutCtp: String;
  intSeqCon: Integer;
  strSeqLan: String;
  lstBanCtp: TBanCtpRepository;
  strHist01: String;
  strHist02: String;
  strHistor: String;
  LAutoIncLogCtp: String;
Begin
  strSeqPag  := fRetSequencialCadPag;
  intSeqCon  := fRetCtpCon;


  if AblnHistoricoEstorno then
    strHistor := 'Tarifa de estorno duplic. descontada ' + #13
  else
    strHistor  := 'Pgto. Tarifa -  ' + objCnfOco.strDesOco + ' ' + #13;

  strHistor := strHistor + 'Ref. Duplicata: ' + qryCadRec.FieldByName('CTR_NUMDUP').AsString +
                                                qryCadRec.FieldByName('CTR_PARCEL').AsString + '-' +
                                                qryCadRec.FieldByName('CTR_ESPDOC').AsString + '-' +
                                                qryCadRec.FieldByName('CTR_CODEMP').AsString;

  strHist01 := Copy(strHistor, 01, 40);
  strHist02 := '';
  If Length(strHistor) > 40 Then
    strHist02 := Copy(strHistor, 41, 40);

  {***************************************************************************************}
  {* FUNÇÃO QUE VERIFICA SE A DUPLICATA + OCORRÊNCIA JÁ ESTÃO VINCULADAS NA CTRBAN. ******}
  {* SÓ GRAVA A TARIFA, CASO NÃO TENHA NENHUM REGISTRO PARA ESSA DUPLICATA + OCORRÊNCIA, *}
  {* ISSO GARANTE QUE SE O ARQUIVO DE RETORNO FOR IMPORTADO MAIS DE UMA VEZ, A TARIFA ****}
  {* NÃO SEJA GERADA COM DUPLICIDADE. ****************************************************}
  {*REQ*126006*************************************************************************MO*}
  if OcorrenciaSemVinculoCtrBan(qryCadRec.FieldByName('AUTOINCREM').AsString, objCnfOco.strCodOco, objCnfOco.strCodBco, objCnfOco.strMotOco) then
  begin
    lstBanCtp  := TBanCtpRepository.Create;
    Try
      lstBanCtp.pClear;
      lstBanCtp.fAdd(strSeqPag,
                     'A',
                     IIF((objCnfOco.intTipDes > 0), 'BLD', 'BLT'),
                     strCodEmp,
                     objCnfOco.strCodFor,
                     strHist01,
                     strHist02,
                     objCnfOco.strCodCta,
                     strCodEmp,
                     0,
                     fltValTar,
                     fltValTar,
                     0,
                     0,
                     0);

      If fEmptyStr(FReservaSeqLanTarifa.Prefixo) And (FQuantidadeTarifas > 0) Then
        pReservaSeqLan(FReservaSeqLanTarifa, FQuantidadeTarifas);

      If fEmptyStr(FReservaMovBanTarifa.Prefixo) And (FQuantidadeTarifas > 0) Then
        pReservaAutoIncrem(FReservaMovBanTarifa, 'MOVBAN', FQuantidadeTarifas);

      If fEmptyStr(FReservaBanCtpTarifa.Prefixo) And (FQuantidadeTarifas > 0) Then
        pReservaAutoIncrem(FReservaBanCtpTarifa, 'BANCTP', FQuantidadeTarifas);

      If fEmptyStr(FReservaCadPagTarifa.Prefixo) And (FQuantidadeTarifas > 0) Then
        pReservaAutoIncrem(FReservaCadPagTarifa, 'CADPAG', FQuantidadeTarifas);

      If fEmptyStr(FReservaLogCtpTarifa.Prefixo) And (FQuantidadeTarifas > 0) Then
        pReservaAutoIncrem(FReservaLogCtpTarifa, 'LOGCTP', FQuantidadeTarifas);

      lstBanCtp.fGetList.Last.strAutInc := fProximoAutoIncremReservado(FReservaBanCtpTarifa, strCodEmp);

      strAutCtp := fProximoAutoIncremReservado(FReservaCadPagTarifa, VS_strCodEmp);
      If fEmptyStr(strAutCtp) Then
        strAutCtp := fRetAutoIncrem('CADPAG', VS_strCodEmp);

      LAutoIncLogCtp := fProximoAutoIncremReservado(FReservaLogCtpTarifa, strCodEmp);

      strSeqLan := fGravaMovBan(objCnfOco.strCodCta,
                                objCnfOco.strCodPor,
                                strLoginUsuarioLogado,
                                dteDtaLan,
                                strSeqPag,
                                'D',
                                strCodEmp,
                                fltValTar,
                                strHist01,
                                strHist02,
                                '',
                                objCnfOco.strCodFor,
                                strSeqPag,
                                0,
                                'A',
                                strCodEmp,
                                IIF((objCnfOco.strCodBco = '341') And (objCnfOco.strCodOco = '02'), 'BLD', 'BLT'),
                                fProximoSeqLanReservado(FReservaSeqLanTarifa),
                                '',
                                lstBanCtp.fGetList,
                                FormatDateTime('mm/yyyy',  dteDtaLan),
                                intSeqCon,
                                fProximoAutoIncremReservado(FReservaMovBanTarifa, strCodEmp));

      fGravaCadPag('frmPrincipal',
                   'INCLUSAO DA TARIFA',
                   objCnfOco.strCodFor,
                   strSeqPag,
                   'A',
                   strCodEmp,
                   objCnfOco.strCodCta,
                   IIF((objCnfOco.strCodBco = '341') And (objCnfOco.strCodOco = '02'), 'BLD', 'BLT'),
                   0,
                   dteDtaLan,
                   dteDtaLan,
                   0,
                   fltValTar,
                   'N',
                   'N',
                   'N',
                   //strHist01+strHist02, //MF: 286759 - 29/05/2023
                   strHistor, //MF: 286759 - 29/05/2023
                   '',
                   strHist01,
                   objCnfOco.strCodPor,
                   objCnfOco.strCodCta,
                   strSeqLan,
                   strLoginUsuarioLogado,
                   dteDtaLan,
                   fltValTar,
                   0,
                   0,
                   VS_strCodEmp,
                   '',
                   'N',
                   '',
                   '',
                   0.0,
                   0.0,
                   intSeqCon,
                   False,
                   0,
                   '',
                   0,
                   'N',
                   '',
                   '',
                   '',
                   strAutCtp,
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
                   fltValTar,
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
                   LAutoIncLogCtp);
    Finally
      lstBanCtp.Free;
    End;

    //Vincula a Cadrec com Movban e CadPag
    If (Not fEmptyStr(strRetAutIncMovBan)) Then
      pGravaCtrBan(qryCadRec.FieldByName('AUTOINCREM').AsString,
                   strRetAutIncMovBan,
                   strAutCtp,
                   objCnfOco.intTipDes,
                   objCnfOco.strCodOco,
                   objCnfOco.strMotOco);
  end;
end;

Function TfrmPrincipal.fGravaReceber( qryCadRec: TDataset;
                                      fltValTar: Double ) : Boolean;
Var
  strNumDup : String;
  LOperador : String;
  strAutIncRastreio : String;
Begin

  Result := False;

  Try

    strNumDup := fRetSequencialCadRec;

    If VerificaVinculoTarifaLancada(qryCadRec.FieldByName('AUTOINCREM').AsString) Then
    begin

      LOperador := strLoginUsuarioLogado;

      Result := fGravaCadRec('frmPrincipal',
                             'INCLUSÃO DA TARIFA',
                             strNumDup,                                                          // Duplicata
                             'A',                                                                // Parcela
                             0,                                                                  // Sequencial de Baixa
                             qryCadRec.FieldByName('CTR_ESPDOC').AsString,                       // Espécie ->> TARIFA
                             qryCadRec.FieldByName('CTR_CODCLI').AsString,                       // Cliente
                             VS_strCodEmp,                                                       // Empresa
                             LOperador,                                                          // Vendedor
                             LOperador,                                                          // Digitador
                             qryCadRec.FieldByName('CTR_CODPOR').AsString,                       // Portador
                             VS_Date,                                                            // Data de Cadastro
                             VS_Date,                                                            // Data de Vencimento
                             fltValTar,                                                          // Valor da Duplicata
                             fltValTar,                                                          // Valor Original
                             0.0,                                                                // Despesa de Cobrança
                             'N',                                                                // Desconto
                             'REGISTRO GERADO REF. A CUSTOS/TARIFAS',                            // Histórico 1
                             '',                                                                 // Histórico 2
                             '',                                                                 // Portador da Baixa
                             '',                                                                 // Centro de Custo da Baixa
                             '',                                                                 // Operador da Baixa
                             '',                                                                 // Documento da Baixa
                             0.0,                                                                // Valor do Recebimento
                             0,                                                                  // Data do Recebimento
                             'N',
                             '',                                                                 // Código do Evento
                             '',                                                                 // Código Velho (CONVERSÃO)
                             '',                                                                 // Tipo de Fora (Condição de Pagamento)
                             '',                                                                 // Código da Condição de Pagamento
                             False,
                             '',                                                                 // Codigo do Centro de Custo
                             0,                                                                  // Sequencial de Controle
                             0);

      If Result Then
      Begin

         // Vincula a Cadrec
         strAutIncRastreio := pRetornaAutoinVinculoCtr(strNumDup,
                                                       'A',
                                                       qryCadRec.FieldByName('CTR_ESPDOC').AsString,
                                                       qryCadRec.FieldByName('CTR_CODCLI').AsString,
                                                       VS_strCodEmp);

         pGravaVinculoCtr(strAutIncRastreio, qryCadRec.FieldByName('AUTOINCREM').AsString);

      End;

    End;

  Except
    On E:Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar o Contas a Receber referente aos custos/tarifa.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
End;

function TfrmPrincipal.VerificaVinculoTarifaLancada(AAutCtr : String): Boolean;
Var
  qryBusca: TUniQuery;
begin

  Try
    qryBusca := fCriaQuery;
    qryBusca.Close;
    qryBusca.SQL.Clear;
    qryBusca.SQL.Add('SELECT COUNT(AUTOINCREM) AS QUANTIDADE ');
    qryBusca.SQL.Add('FROM CADREC ');
    qryBusca.SQL.Add('WHERE CTR_TARDUP = :AUTCTR ');
    qryBusca.ParamByName('AUTCTR').AsString := AAutCtr;
    qryBusca.Open;

    Result := qryBusca.FieldByName('QUANTIDADE').AsInteger = 0;
  Finally
    FreeAndNil(qryBusca);
  End;

end;

Function TfrmPrincipal.pRetornaAutoinVinculoCtr(strNumDup, strParcel, strEspDoc, strCodCli, strCodEmp : String ): String;
  Var
    qryBusca: TUniQuery;
begin
  Try
    Result := '';

    qryBusca := fCriaQuery;
    qryBusca.Close;
    qryBusca.SQL.Clear;
    qryBusca.SQL.Add('SELECT AUTOINCREM FROM CADREC ');
    qryBusca.SQL.Add(' WHERE CTR_NUMDUP = :NUMDUP ');
    qryBusca.SQL.Add('   AND CTR_PARCEL = :PARCEL ');
    qryBusca.SQL.Add('   AND CTR_ESPDOC = :ESPDOC ');
    qryBusca.SQL.Add('   AND CTR_CODCLI = :CODCLI ');
    qryBusca.SQL.Add('   AND CTR_CODEMP = :CODEMP ');

    qryBusca.ParamByName('NUMDUP').AsString := strNumDup;
    qryBusca.ParamByName('PARCEL').AsString := strParcel;
    qryBusca.ParamByName('ESPDOC').AsString := strEspDoc;
    qryBusca.ParamByName('CODCLI').AsString := strCodCli;
    qryBusca.ParamByName('CODEMP').AsString := strCodEmp;

    qryBusca.Open;

    If Not qryBusca.IsEmpty Then
       Result := qryBusca.FieldByName('AUTOINCREM').AsString;

  Except
    On E:Exception Do
      Raise Exception.Create('Ocorreu um erro ao buscar o sequencial vinculado do Contas a Receber.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

procedure TfrmPrincipal.pGravaVinculoCtr(strAutCtr, strAutCtr_Rastreio : String );
  Var
    qryGravar: TUniQuery;
begin
  Try
    qryGravar := fCriaQuery;
    qryGravar.Close;
    qryGravar.SQL.Clear;
    qryGravar.SQL.Add('UPDATE CADREC SET CTR_TARDUP = :TARDUP ');
    qryGravar.SQL.Add(' WHERE AUTOINCREM = :AUTOIN ');

    qryGravar.ParamByName('AUTOIN').AsString := strAutCtr;
    qryGravar.ParamByName('TARDUP').AsString := strAutCtr_Rastreio;

    qryGravar.ExecSQL;
  Except
    On E:Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar vinculo da tarifa com o Contas a Receber.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

procedure TfrmPrincipal.pIniciarBaixa(strCodBco: String);
  Var
    qryCarteiras: TUniQuery;
    intCartei   : Integer;
begin
  Try
    //apenas itau por enquanto
    {*************************************}
    {* A IDÉIA É RETIRAR ESSA SELEÇÃO DE *}
    {* CARTEIRAS PARA REALIZAR A BAIXA.  *}
    {**********************************AJ*}
    pCriarFormularios(TfrmConfigItau,frmConfigItau);
    frmConfigItau.pnlTopo.Caption   := 'Selecione a carteira';
    frmConfigItau.btnGravar.Caption := '&OK';
    frmConfigItau.blnNaoEditar      := True;
    frmConfigItau.ShowModal;

    If frmConfigItau.ModalResult <> mrOK Then
    Begin
      FreeAndNil(frmConfigItau);
      Exit;
    End;

    If Trim(frmConfigItau.edtDiasCred.Text) = '' Then
      intDiaCred := 0
    Else
      intDiaCred := StrToInt(frmConfigItau.edtDiasCred.Text);

    intCartei := frmConfigItau.tabCarteira.TabIndex + 1;

    If (fCfgSis('ENCBAN', VarBoolean)) Then
    Begin
      qryCarteiras          := fCriaQuery;
      qryCarteiras.SQL.Text := 'SELECT RET_CARTEI   ' +
                               'FROM RETBCO         ' +
                               'WHERE RET_CODBCO = "' + Copy(strCodBco, 1, 3) + '"' +
                               'GROUP BY RET_CARTEI ' +
                               'ORDER BY RET_CARTEI ';
      qryCarteiras.Open;

      intContadorCarteiras := 1;
      If qryCarteiras.IsEmpty Then
        fMensagem('ATENÇÃO', 'Não existem registros para serem baixados/atualizados.', ['&OK'], 1)
      Else If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
      Begin
        If qryCarteiras.RecordCount > 1 Then
          fMensagem('ATENÇÃO', 'Será realizada a baixa/atualização dos boletos de ' +
                               qryCarteiras.RecordCount.ToString +
                               ' carteiras diferentes.', ['&OK'], 1);

        While Not qryCarteiras.Eof Do
        Begin
          intDiaCred := StrToIntDef(untfuncoesSimples.fGetBancoConfig(0,
                                                        'CONFIG' + strCodBco + '-' + qryCarteiras.FieldByName('RET_CARTEI').AsString,
                                                        'DIACRED',
                                                        '0'),0);

          pBaixaAtuDup(strCodBco,
                       qryCarteiras.FieldByName('RET_CARTEI').AsInteger,
                       '',
                       qryCarteiras.RecordCount);

          qryCarteiras.Next;
          Inc(intContadorCarteiras);
        End;
      End;
    End
    Else If fMensagem('ATENÇÃO','Confirma a baixa das duplicatas?',['&Sim','&Nao']) = 1 Then
      pBaixaAtuDup(strCodBco, intCartei);
  Finally
    intContadorCarteiras := 1;
    If Assigned(qryCarteiras) Then
      FreeAndNil(qryCarteiras);
    FreeAndNil(frmConfigItau);
  End;
end;

function TfrmPrincipal.fRetornarListaOcoRet(ACodBco: string): string;
var
  LConsulta: TUniQuery;
begin
  Result := '';
  LConsulta := fCriaQuery;
  try
    LConsulta.SQL.Add(
      'SELECT DISTINCT '+
        'GROUP_CONCAT(''"'',RET_CODOCO,''"'') '+
      'FROM '+
        'OCORET '+
      'WHERE RET_CODBCO = :CODBCO '+
        'AND RET_CODEMP = :CODEMP ');
    LConsulta.ParamByName('CODBCO').AsString := LeftStr(ACodBco, 3);
    LConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp;
    LConsulta.Open;

    if not LConsulta.Eof then
      Result := LConsulta.Fields[0].AsString;
  finally
    FreeAndNil(LConsulta);
  end;
end;

function TfrmPrincipal.fRetSQLOcoBancos(strCodBco, strConfig, strOcoTar, AOcoRet, strValOco05: String): String;
Begin
  Result := '';

  If strCodBco = '033B' Then
    Result := Result + '  ((RET_DTAPAG IS NOT NULL) OR (RET_CODOCO IN ("02","05","15","21","23","28","25"'+IIF(fEmptyStr(strOcoTar), '', ',' + strOcoTar)+'))) '
  Else If strCodBco = '021' Then
    Result := Result + '  ((RET_DTAPAG IS NOT NULL) OR (RET_CODOCO IN ("02","23"))) '
  Else If strCodBco = '104p400' Then
    Result := Result + '  ((RET_DTAPAG IS NOT NULL) OR (RET_CODOCO IN ("02","32","21"))) '
  Else If strCodBco = '041' Then
    {*************************************************************}
    {* ACRESCENTAR A OCORRÊNCIA 10 - BAIXADO CONFORME INSTRUÇÕES *}
    {* REQ 104396                                                *}
    {**********************************************************CH*}
    Result := Result + '  (((RET_DTAPAG IS NOT NULL) OR (RET_CODOCO IN ("02","10","32","30"))) AND RET_CODOCO <> "09" ) '
    {*}

  Else If strCodBco = '041_240p' Then
    Result := Result + '  ((RET_DTAPAG IS NOT NULL) OR (RET_CODOCO IN ("02","06","09","17","28"))) '

  {***************************************************}
  {* TRATAMENTO PARA CODIGOS DE OCORRENCIAS BRADESCO *}
  {***************************************************}

  Else If (strCodBco = '237') Then
  Begin
    Result := Result + '  ((RET_DTAPAG IS NOT NULL) OR (RET_CODOCO IN ("02","06","10","15","17","19","23","32"';

    If Not fEmptyStr(strOcoTar) Then
      Result := Result + ',' + strOcoTar;

    If Not fEmptyStr(AOcoRet) Then
      Result := Result + ',' + AOcoRet;

    Result := Result + '))) ';
  End

  Else If (strCodBco = '237_VENDOR') Or (strCodBco = '099') Or (strCodBco = '084') Then
    Result := Result + '  ((RET_DTAPAG IS NOT NULL) OR (RET_CODOCO IN ("02","06","10","15","17","19","23","32"'+ IIF(fEmptyStr(strOcoTar), '', ',' + strOcoTar)+'))) '

  {****************************************************}
  {* TRATAMENTO PARA CODIGOS DE OCORRENCIAS MERCANTIL *}
  {****************************************************}
  Else If (strCodBco = '389') Then
    Result := Result + '  ((RET_DTAPAG IS NOT NULL) OR (RET_CODOCO IN ("02","06","15","16","32"))) '

  {****************************************************}
  {* TRATAMENTO PARA CODIGOS DE OCORRENCIA BB         *}
  {****************************************************}
  Else If LeftStr(strCodBco,3) = '001' Then
  Begin

    If (strCodBco = '001API') Then
    Begin
      Result := Result + '  ((RET_DTAPAG IS NOT NULL) OR (RET_CODOCO = "02" OR ';
      Result := Result + '  RET_CODOCO = "01" OR ';
      Result := Result + '  RET_CODOCO = "03" OR ';
      Result := Result + '  RET_CODOCO = "04" OR ';
      Result := Result + '  RET_CODOCO = "05" OR ';
      Result := Result + '  RET_CODOCO = "06" OR ';
      Result := Result + '  RET_CODOCO = "07" OR ';
      Result := Result + '  RET_CODOCO = "08" OR ';
      Result := Result + '  RET_CODOCO = "09" OR ';
      Result := Result + '  RET_CODOCO = "10" OR ';
      Result := Result + '  RET_CODOCO = "11" OR ';
      Result := Result + '  RET_CODOCO = "12" OR ';
      Result := Result + '  RET_CODOCO = "13" OR ';
      Result := Result + '  RET_CODOCO = "14" OR ';
      Result := Result + '  RET_CODOCO = "15" OR ';
      Result := Result + '  RET_CODOCO = "16" OR ';
      Result := Result + '  RET_CODOCO = "17" OR ';
      Result := Result + '  RET_CODOCO = "18" OR ';
      Result := Result + '  RET_CODOCO = "80"))  ';
    End
    Else
    Begin
      Result := Result + '  ((RET_DTAPAG IS NOT NULL) OR (RET_CODOCO = "02" OR ';
      Result := Result + '  RET_CODOCO = "06" OR ';
      Result := Result + '  RET_CODOCO = "07" OR ';
      Result := Result + '  RET_CODOCO = "08" OR ';
      Result := Result + '  RET_CODOCO = "09" OR ';
      Result := Result + '  RET_CODOCO = "15" OR ';
      Result := Result + '  RET_CODOCO = "72" OR ';
      Result := Result + '  RET_CODOCO = "98" OR ';
      If strValOco05 = 'N' Then
        Result := Result + ' RET_CODOCO = "05" OR ';
      Result := Result + '  RET_CODOCO = "23"))  ';
    End;

  End
  Else If strCodBco = '422' Then
    Result := Result + ' ((RET_DTAPAG IS NOT NULL) OR (RET_CODOCO IN ("02","23","21"))) '
  Else If strCodBco = '341' Then
  Begin
    //PRIMEIRO BLOCO VERIFICA SE É OCORRENCIA 48 E VEIO DE UM ARQUIVO DE EMPRESTIMO
    //SEGUNDO BLOCO SÃO AS OUTRAS OCORRÊNCIAS PARA QUANDO FOR ARQUIVO DE COBRANÇA SEM A OCORRÊNCIA 48 E 29
    Result := Result + ' ( ';
    Result := Result + '  (RET_CODOCO = "48" AND RET_DUPDES = "S") OR ';
    Result := Result + '  ((  ';
    Result := Result + '    (RET_DTAPAG IS NOT NULL) AND ((RET_CODOCO <> "48") AND (RET_CODOCO <> "29"))) OR ( ';
    Result := Result + '         RET_CODOCO IN ("02", "32", ';
    Result := Result + '         "04", "06", "08", "15", ';
    Result := Result + '         "19", "23", "24", "35"' +IIF(fEmptyStr(strOcoTar), '', ',' + strOcoTar)+ ') ';
    Result := Result + '  )) ';
    Result := Result + ' )   ';
  End
  Else If strCodBco = '341API' Then
    Result := Result + '  ((RET_DTAPAG IS NOT NULL) OR (RET_CODOCO = "48" AND RET_DUPDES = "S") OR ' +
                       '   (RET_CODOCO IN ("02","32"'+IIF(fEmptyStr(strOcoTar), '', ',' + strOcoTar)+'))) '
  Else
  If strCodBco = '033B240p' Then
    Result := Result + '  ((RET_DTAPAG IS NOT NULL) OR (RET_CODOCO IN ("02","32"'+IIF(fEmptyStr(strOcoTar), '', ',' + strOcoTar)+'))) '
  Else
    Result := Result + '  ((RET_DTAPAG IS NOT NULL) OR (RET_CODOCO IN ("02","32"))) ';

  If (LeftStr(strCodBco, 3)  = '748') And fEmptyStr(strOcoTar) Then
  Begin
    Result := Result + '  AND RET_CODOCO <> "28" ';
  End
  Else If (LeftStr(strCodBco, 3)  = '748') And Not fEmptyStr(strOcoTar) Then
  Begin
    Result := Result + '  AND RET_CODOCO <> "28" ';
    Result := Result + '  OR RET_CODOCO IN (' + strOcoTar + ')';
  End;

  {***************************************}
  {* TRATAMENTO PARA CODIGOS DE          *}
  {* OCORRENCIA                          *}
  {************************************LB*}

  If (strCodBco = '982') Then
  Begin
    Result := Result + ' AND (RET_CODOCO = "02" OR ';
    Result := Result + '  RET_CODOCO = "06" OR ';
    Result := Result + '  RET_CODOCO = "15" OR ';
    Result := Result + '  RET_CODOCO = "17" OR ';
    Result := Result + '  RET_CODOCO = "23") ';
  End;

  If strCodBco = '637' Then
  Begin

    Result := Result + ' AND (RET_CODOCO = "02" OR ';
    Result := Result + '  RET_CODOCO = "06" OR ';
    Result := Result + '  RET_CODOCO = "08" OR ';
    Result := Result + '  RET_CODOCO = "09" OR ';
    Result := Result + '  RET_CODOCO = "10") ';

  End;

  {***************************************}
  {* TRATAMENTO DE CÓDIGOS DE OCORRÊNCIA *}
  {* BANCO DA AMAZÔNIA                   *}
  {************************************JU*}

  If strCodBco = '003' Then
  Begin

    Result := Result + ' AND (RET_CODOCO = "06" OR ';
    Result := Result + '  RET_CODOCO = "15" OR ';
    Result := Result + '  RET_CODOCO = "17") ';

  End;

  {***************************************}
  {* TRATAMENTO DE CÓDIGOS DE OCORRÊNCIA *}
  {* BANCO DO NORDESTE                   *}
  {************************************MO*}
  If strCodBco = '004' Then
  Begin

    Result := Result + ' AND (RET_CODOCO = "02" OR ';
    Result := Result + '  RET_CODOCO = "06" OR ';
    Result := Result + '  RET_CODOCO = "09" OR ';
    Result := Result + '  RET_CODOCO = "15") ';

  End;

  {***************************************}
  {* TRATAMENTO DE CÓDIGOS DE OCORRÊNCIA *}
  {* BANCO RENDIMENTO                    *}
  {************************************JU*}

  If strCodBco = '633' Then
  Begin

    Result := Result + ' AND (RET_CODOCO = "06" OR ';
    Result := Result + '  RET_CODOCO = "08" OR ';
    Result := Result + '  RET_CODOCO = "09" OR ';
    Result := Result + '  RET_CODOCO = "10" OR ';
    Result := Result + '  RET_CODOCO = "43")   ';

  End;

  {***************************************}
  {* TRATAMENTO DE CÓDIGOS DE OCORRÊNCIA *}
  {* BANCO CECRED                        *}
  {************************************JU*}
  If strCodBco = '085' Then
  Begin

    Result := Result + ' AND (RET_CODOCO = "02" OR ';
    Result := Result + '  RET_CODOCO = "06" OR ';
    Result := Result + '  RET_CODOCO = "09" OR ';
    Result := Result + '  RET_CODOCO = "17") ';

  End;

  {***************************************}
  {* TRATAMENTO DE CÓDIGOS DE OCORRÊNCIA *}
  {* BANCO UNICRED                       *}
  {************************************JU*}
  If strCodBco = '090' Then
  Begin

    Result := Result + ' AND (RET_CODOCO = "02" OR ';
    Result := Result + '  RET_CODOCO = "06" OR ';
    Result := Result + '  RET_CODOCO = "09") ';

  End;

  {***************************************}
  {* TRATAMENTO DE CÓDIGOS DE OCORRÊNCIA *}
  {* CEF 240 SIGCB                       *}
  {************************************JU*}
  If (strCodBco = '104') Then
  Begin
    Result := Result + ' AND (RET_CODOCO = "06" OR ';
    Result := Result + '  RET_CODOCO = "02" OR ';
    Result := Result + '  RET_CODOCO = "04" OR ';
    Result := Result + '  RET_CODOCO = "09" OR ';
    Result := Result + IIF((fGetBancoConfig(0,'CONFIG' + strCodBco, 'SISCOB', '') = 'SIGCB'), '', '  RET_CODOCO = "17" OR ');
    Result := Result + '  RET_CODOCO = "23" OR ';
    Result := Result + '  RET_CODOCO = "24") ';
  End;

  If Pos('756', strCodBco) > 0 Then
  Begin
    Result := Result + ' OR (RET_CODOCO = "02" OR ';
    Result := Result + '     RET_CODOCO = "09" OR ';
    Result := Result + '     RET_CODOCO = "06" OR ';
    Result := Result + '     RET_CODOCO = "19" OR ';
    Result := Result + '     RET_CODOCO = "23" OR ';
    Result := Result + '     RET_CODOCO = "25") ' ;
  End;

  If strCodBco = '070' Then
    Result := Result + '  AND RET_CODOCO = "06" ';
End;

procedure TfrmPrincipal.pLancaTarifasAuxiliares(qryRetBco, qryCadRec: TUniQuery;
      objCnfDao: TCnfOcoDao; strCodBco: String; strOcoTar: String; intDiasCredito: Integer);
  Var
    objCnfOco: TCnfOco;
    strSQL   : String;
    qryUpdate: TUniQuery;
    lstBanCtr: array of TBanCtrRepository;
    strSeqLan: String;
Begin
  Try
    //Lança tarifa auxiliares
    If (Pos(qryRetBco.FieldByName('RET_CODOCO').AsString, strOcoTar) > 0) And
       (qryRetBco.FieldByName('RET_DUPDES').AsString = 'N') And
       Not(LeftStr(strCodBco, 3)  = '748') And Not (qryRetBco.FieldByName('RET_CODOCO').AsString = '02') Then
    Begin
      If ((qryRetBco.FieldByName('RET_TARIFA').AsFloat > 0) Or
          (qryRetBco.FieldByName('RET_CUSCAR').AsFloat > 0)) Then
      Begin

        //MF: 284336 - 18/05/2023
        If (strCodBco = '237') and (qryRetBco.FieldByName('RET_MOTOCO').AsString <> '00') Then
          objCnfOco := objCnfDao.fBuscaPorOcorrencia(qryRetBco.FieldByName('RET_CODOCO').AsString,qryRetBco.FieldByName('RET_MOTOCO').AsString)
        Else
        objCnfOco := objCnfDao.fBuscaPorOcorrencia(qryRetBco.FieldByName('RET_CODOCO').AsString);

        If Not (Assigned(objCnfOco)) Then //MF: 284336 - 18/05/2023 - procura pela configuraçao com MOTCOD em branco
          objCnfOco := objCnfDao.fBuscaPorOcorrencia(qryRetBco.FieldByName('RET_CODOCO').AsString);

        If Assigned(objCnfOco) Then
        Begin
          If objCnfOco.blnGerpag Then
          Begin
            pGravaTarifa(objCnfOco,
                         qryCadRec.FieldByName('CTR_CODEMP').AsString,
                         IIF(objCnfOco.blnCusCar, qryRetBco.FieldByName('RET_CUSCAR').AsFloat, qryRetBco.FieldByName('RET_TARIFA').AsFloat),
                         fAcertaDataParaDiaUtil(qryRetBco.FieldByName('RET_DTAOCO').AsFloat+IIF(objCnfOco.blnUsaDia, intDiasCredito, 0)),
                         qryCadRec);
          End;

          objCnfOco.Free;
        End;
      End;
    End
    {----------------------------------------------------------------------------------------------
    |TRATAMENTO DIFERENTE PARA AS TARIFAS DO BANCO SICREDI POIS TODAS SÃO ENVIADAS NA OCORRÊNCIA 28|
    ---------------------------------------------------------------------------------------------PA}
    Else If (qryRetBco.FieldByName('RET_CODOCO').AsString = '28') And
            (qryRetBco.FieldByName('RET_MOTOCO').AsString <> '00') And
            (LeftStr(strCodBco, 3)  = '748') And (qryRetBco.FieldByName('RET_VALPAG').AsFloat > 0) Then
    Begin
      objCnfOco := objCnfDao.fBuscaPorOcorrencia(qryRetBco.FieldByName('RET_CODOCO').AsString,qryRetBco.FieldByName('RET_MOTOCO').AsString);
      If Assigned(objCnfOco) Then
      Begin
        If objCnfOco.blnGerpag Then
        Begin
          pGravaTarifa(objCnfOco,
                       qryCadRec.FieldByName('CTR_CODEMP').AsString,
                       qryRetBco.FieldByName('RET_VALPAG').AsFloat,
                       fAcertaDataParaDiaUtil(qryRetBco.FieldByName('RET_DTAOCO').AsFloat+IIF(objCnfOco.blnUsaDia, intDiasCredito, 0)),
                       qryCadRec);
        End;

        If (objCnfOco.blnGerRec ) Then
        Begin

          If (strCodBco = '237') Then
          Begin
             fGravaReceber(qryCadRec,
                           IIF(objCnfOco.blnCusCar, qryRetBco.FieldByName('RET_CUSCAR').AsFloat, qryRetBco.FieldByName('RET_TARIFA').AsFloat)
                          );
          End;

        End;

        objCnfOco.Free;
      End;
    End

    Else If (qryRetBco.FieldByName('RET_CODOCO').AsString = '28') And
            (qryRetBco.FieldByName('RET_MOTOCO').AsString <> '00') And
            (LeftStr(strCodBco, 3)  = '748') And (qryRetBco.FieldByName('RET_TARIFA').AsFloat > 0) Then
    Begin
      objCnfOco := objCnfDao.fBuscaPorOcorrencia(qryRetBco.FieldByName('RET_CODOCO').AsString,qryRetBco.FieldByName('RET_MOTOCO').AsString);
      If Assigned(objCnfOco) Then
      Begin
        If objCnfOco.blnGerpag Then
        Begin
          pGravaTarifa(objCnfOco,
                       qryCadRec.FieldByName('CTR_CODEMP').AsString,
                       qryRetBco.FieldByName('RET_TARIFA').AsFloat,
                       fAcertaDataParaDiaUtil(qryRetBco.FieldByName('RET_DTAOCO').AsFloat+IIF(objCnfOco.blnUsaDia, intDiasCredito, 0)),
                       qryCadRec);
        End;
        objCnfOco.Free;
      End;
    End

    {************************************************}
    {* TARIFAS AUXILIARES PARA DUPLICATA DESCONTADA *}
    {*********************************************AJ*}
    Else If (qryRetBco.FieldByName('RET_DUPDES').AsString = 'S') And
            (qryCadRec.FieldByName('CTR_MOVDES').IsNull) And
            (blnUtlDesDup) Then
    Begin
      If qryRetBco.FieldByName('RET_IOFDES').AsFloat <> 0 Then
      Begin
        objCnfOco := objCnfDao.fBuscaPorOcorrencia(qryRetBco.FieldByName('RET_CODOCO').AsString,'','',1);
        If Assigned(objCnfOco) Then
        Begin
          If objCnfOco.blnGerpag Then
          Begin
            pGravaTarifa(objCnfOco,
                         qryCadRec.FieldByName('CTR_CODEMP').AsString,
                         qryRetBco.FieldByName('RET_IOFDES').AsFloat,
                         fAcertaDataParaDiaUtil(qryRetBco.FieldByName('RET_DTAOCO').AsFloat+IIF(objCnfOco.blnUsaDia, intDiasCredito, 0)),
                         qryCadRec);
          End;
          objCnfOco.Free;
        End;
      End;

      If qryRetBco.FieldByName('RET_TARIFA').AsFloat <> 0 Then
      Begin
        objCnfOco := objCnfDao.fBuscaPorOcorrencia(qryRetBco.FieldByName('RET_CODOCO').AsString,'','',2);
        If Assigned(objCnfOco) Then
        Begin
          If objCnfOco.blnGerpag Then
          Begin
            pGravaTarifa(objCnfOco,
                         qryCadRec.FieldByName('CTR_CODEMP').AsString,
                         qryRetBco.FieldByName('RET_TARIFA').AsFloat,
                         fAcertaDataParaDiaUtil(qryRetBco.FieldByName('RET_DTAOCO').AsFloat+IIF(objCnfOco.blnUsaDia, intDiasCredito, 0)),
                         qryCadRec);
          End;
          objCnfOco.Free;
        End;
      End;

      If qryRetBco.FieldByName('RET_TXADES').AsFloat <> 0 Then
      Begin
        objCnfOco := objCnfDao.fBuscaPorOcorrencia(qryRetBco.FieldByName('RET_CODOCO').AsString,'','',3);
        If Assigned(objCnfOco) Then
        Begin
          If objCnfOco.blnGerpag Then
          Begin
            pGravaTarifa(objCnfOco,
                         qryCadRec.FieldByName('CTR_CODEMP').AsString,
                         qryRetBco.FieldByName('RET_TXADES').AsFloat,
                         fAcertaDataParaDiaUtil(qryRetBco.FieldByName('RET_DTAOCO').AsFloat+IIF(objCnfOco.blnUsaDia, intDiasCredito, 0)),
                         qryCadRec);
          End;
          objCnfOco.Free;
        End;
      End;

      If qryRetBco.FieldByName('RET_JUROPE').AsFloat <> 0 Then
      Begin
        objCnfOco := objCnfDao.fBuscaPorOcorrencia(qryRetBco.FieldByName('RET_CODOCO').AsString,'','',4);
        If Assigned(objCnfOco) Then
        Begin
          If objCnfOco.blnGerpag Then
          Begin
            pGravaTarifa(objCnfOco,
                         qryCadRec.FieldByName('CTR_CODEMP').AsString,
                         qryRetBco.FieldByName('RET_JUROPE').AsFloat,
                         qryRetBco.FieldByName('RET_DTAOCO').AsFloat,
                         qryCadRec);
          End;
          objCnfOco.Free;
        End;
      End;

      SetLength(lstBanCtr, 1);
      lstBanCtr[0] := TBanCtrRepository.Create;
      lstBanCtr[0].fAdd(qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                        qryCadRec.FieldByName('CTR_PARCEL').AsString,
                        qryCadRec.FieldByName('CTR_ESPDOC').AsString,
                        qryCadRec.FieldByName('CTR_CODEMP').AsString,
                        qryCadRec.FieldByName('CTR_CODCLI').AsString,
                        qryCadRec.FieldByName('CTR_HIST01').AsString,
                        qryCadRec.FieldByName('CTR_HIST02').AsString,
                        qryCadRec.FieldByName('CTR_SEQBAI').AsInteger,
                        qryCadRec.FieldByName('CTR_VALDUP').AsFloat);

      strSeqLan := fGravaMovBan(strCtaBai,
                                strPorBai,
                                strOpeBai,
                                qryRetBco.FieldByName('RET_DTAOCO').AsFloat,
                                qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                                'C',
                                qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                qryCadRec.FieldByName('CTR_VALDUP').AsFloat,
                                fPadR('Desconto de Duplicata - Banco: ' + LeftStr(strCodBco, 3) ,40,''),
                                '',
                                qryCadRec.FieldByName('CTR_CODCLI').AsString,
                                '',
                                qryCadRec.FieldByName('CTR_NUMDUP').AsString,
                                0,
                                qryCadRec.FieldByName('CTR_PARCEL').AsString,
                                qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                '',
                                '',
                                strCodEve,
                                lstBanCtr[0].fGetList,
                                FormatDateTime('mm/yyyy',  qryRetBco.FieldByName('RET_DTAOCO').AsFloat),
                                qryCadRec.FieldByName('CTR_SEQCON').AsInteger);

      strSQL := '';
      strSQL := strSQL + ' UPDATE CADREC              ';
      strSQL := strSQL + ' SET                        ';
      strSQL := strSQL + '   CTR_DESCON = "S",        ';
      strSQL := strSQL + '   CTR_MOVDES = :MOVDES     ';
      If Not fEmptyStr(strPorDes) Then
        strSQL := strSQL + '   ,CTR_CODPOR = :CODPOR  ';
      strSQL := strSQL + ' WHERE                      ';
      strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
      strSQL := strSQL + '   CTR_SEQBAI = 0           ';

      qryUpdate := fCriaQuery;
      With qryUpdate Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('MOVDES').AsString := strSeqLan;
        If Not fEmptyStr(strPorDes) Then
          ParamByName('CODPOR').AsString := strPorDes;

        ParamByName('NUMDUP').AsString := qryCadRec.FieldByName('CTR_NUMDUP').AsString;
        ParamByName('PARCEL').AsString := qryCadRec.FieldByName('CTR_PARCEL').AsString;
        ParamByName('ESPDOC').AsString := qryCadRec.FieldByName('CTR_ESPDOC').AsString;
        ParamByName('CODEMP').AsString := qryCadRec.FieldByName('CTR_CODEMP').AsString;
        ParamByName('CODCLI').AsString := qryCadRec.FieldByName('CTR_CODCLI').AsString;
        ExecSQL;
        Close;
      End;
      FreeAndNil(qryUpdate);

      {**************************}
      {* GRAVA LOG DA ALTERAÇÃO *}
      {***********************AJ*}
      untLogCtr.GravaLogCtr(qryCadRec.FieldByName('AUTOINCREM').AsString,
                            'ATUALIZAÇÃO PARA DUPLICATA DESCONTADA (AUTBAN)',
                            Self.Name,
                            '',
                            0,
                            0,
                            '',
                            '',
                            Nil,
                            fProximoAutoIncremReservado(FReservaLogCtr, qryCadRec.FieldByName('CTR_CODEMP').AsString));

      FreeAndNil(lstBanCtr[0]);
      SetLength(lstBanCtr, 0);
    End;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar as tarifas auxiliares.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

procedure TfrmPrincipal.pReservaAutoIncrem(var AReserva: TReservaSequencial;
  const ATabela: String; const AQuantidade: Integer);
Var
  LPrimeiro: String;
Begin
  AReserva.Restantes := 0;

  If AQuantidade <= 1 Then
    Exit;

  LPrimeiro := fRetAutoIncrem(ATabela, VS_strCodEmp, AQuantidade);

  AReserva.Prefixo   := LeftStr(LPrimeiro, 3);
  AReserva.Proximo   := Copy(LPrimeiro, 4, 14).ToInt64;
  AReserva.Restantes := AQuantidade;
End;

procedure TfrmPrincipal.pReservaSeqLan(var AReserva: TReservaSequencial;
  const AQuantidade: Integer);
Var
  LPrimeiro: String;

  function fSeqLanEmUso: Boolean;
  Var
    LConsulta: TUniQuery;
  Begin
    LConsulta := fCriaQuery(Nil);
    Try
      LConsulta.SQL.Text := 'SELECT CTB_SEQLAN FROM MOVBAN ' +
                            'WHERE CTB_SEQLAN BETWEEN :INICIO AND :FIM LIMIT 1';
      LConsulta.ParamByName('INICIO').AsString := AReserva.Prefixo + fPadL(IntToStr(AReserva.Proximo), AReserva.Largura, '0');
      LConsulta.ParamByName('FIM').AsString    := AReserva.Prefixo + fPadL(IntToStr(AReserva.Proximo + AQuantidade - 1), AReserva.Largura, '0');
      LConsulta.Open;
      Result := Not LConsulta.IsEmpty;
    Finally
      FreeAndNil(LConsulta);
    End;
  End;

Begin
  AReserva.Restantes := 0;

  If AQuantidade <= 1 Then
    Exit;

  If VarToStr(fCampoTabela('PRO_SEQEMP', 'PROCOD', ['PRO_NOMARQ'], ['MOVBAN'])) = 'S' Then
    Exit;

  Repeat
    LPrimeiro := fSeqContaBanco(AQuantidade);

    AReserva.Prefixo   := LeftStr(LPrimeiro, Length(VS_strCodEmp));
    AReserva.Largura   := Length(LPrimeiro) - Length(VS_strCodEmp);
    AReserva.Proximo   := StrToInt64(Copy(LPrimeiro, Length(VS_strCodEmp) + 1, AReserva.Largura));
  Until Not fSeqLanEmUso;

  AReserva.Restantes := AQuantidade;
End;

function TfrmPrincipal.fProximoAutoIncremReservado(var AReserva: TReservaSequencial;
  const ACodEmp: String): String;
Begin
  Result := '';

  If (AReserva.Restantes <= 0) Or (ACodEmp <> VS_strCodEmp) Then
    Exit;

  Result := fFormataAutInc(AReserva.Proximo, ACodEmp, AReserva.Prefixo);

  Inc(AReserva.Proximo);
  Dec(AReserva.Restantes);
End;

function TfrmPrincipal.fProximoSeqLanReservado(var AReserva: TReservaSequencial): String;
Begin
  Result := '';

  If AReserva.Restantes <= 0 Then
    Exit;

  Result := AReserva.Prefixo + fPadL(IntToStr(AReserva.Proximo), AReserva.Largura, '0');

  Inc(AReserva.Proximo);
  Dec(AReserva.Restantes);
End;

procedure TfrmPrincipal.pLimparReservasAutoIncrem;
Begin
  FReservaMovBan       := Default(TReservaSequencial);
  FReservaBanCtr       := Default(TReservaSequencial);
  FReservaLogCtr       := Default(TReservaSequencial);
  FReservaSeqLan       := Default(TReservaSequencial);
  FReservaCadPagTarifa := Default(TReservaSequencial);
  FReservaLogCtpTarifa := Default(TReservaSequencial);
  FReservaSeqLanTarifa := Default(TReservaSequencial);
  FReservaMovBanTarifa := Default(TReservaSequencial);
  FReservaBanCtpTarifa := Default(TReservaSequencial);
  FQuantidadeTarifas   := 0;
End;

procedure TfrmPrincipal.pContarReservasDoRetorno(ARetBco: TDataSet;
  out AQtdTitulos, AQtdLiquidacoes, AQtdTarifas: Integer);
Begin
  AQtdTitulos     := 0;
  AQtdLiquidacoes := 0;
  AQtdTarifas     := 0;

  ARetBco.First;
  While Not ARetBco.Eof Do
  Begin
    If ARetBco.FieldByName('CTR_VALDUP').AsFloat > 0 Then
    Begin
      Inc(AQtdTitulos);
      If (ARetBco.FieldByName('RET_VALPAG').AsFloat > 0) And
         (Not ARetBco.FieldByName('RET_DTAPAG').IsNull) Then
        Inc(AQtdLiquidacoes);
    End;

    If (ARetBco.FieldByName('RET_TARIFA').AsFloat > 0) Or
       (ARetBco.FieldByName('RET_CUSCAR').AsFloat > 0) Then
      Inc(AQtdTarifas);

    ARetBco.Next;
  End;
  ARetBco.First;
End;

procedure TfrmPrincipal.pLancaTarifaDoBoletoAnalitico(qryRetBco, qryCadRec: TUniQuery; ATarifaTed: Double = 0; AConfiguracao:String = '');
  Var
    LDataLancamento : TDateTime;
begin
  Try
    objGravacaoTarifa.strSeqPag  := fRetSequencialCadPag;
    objGravacaoTarifa.intSeqConp := fRetCtpCon;
    objGravacaoTarifa.strAutCtp  := fRetAutoIncrem('CADPAG', VS_strCodEmp);

    lstBanCtp.pClear;
    lstBanCtp.fAdd(objGravacaoTarifa.strSeqPag,
                   'A',
                   'BLT',
                   qryCadRec.FieldByName('CTR_CODEMP').AsString,
                   strForTar,
                   'Ref. ao pagamento de tarifas',
                   '',
                   strCtaTar,
                   qryCadRec.FieldByName('CTR_CODEMP').AsString,
                   0,
                   qryRetBco.FieldByName('RET_TARIFA').AsFloat + ATarifaTed,
                   qryRetBco.FieldByName('RET_TARIFA').AsFloat + ATarifaTed,
                   0,
                   0,
                   0);

    If fEmptyStr(FReservaSeqLanTarifa.Prefixo) And (FQuantidadeTarifas > 0) Then
      pReservaSeqLan(FReservaSeqLanTarifa, FQuantidadeTarifas);

    If fEmptyStr(FReservaMovBanTarifa.Prefixo) And (FQuantidadeTarifas > 0) Then
      pReservaAutoIncrem(FReservaMovBanTarifa, 'MOVBAN', FQuantidadeTarifas);

    If fEmptyStr(FReservaBanCtpTarifa.Prefixo) And (FQuantidadeTarifas > 0) Then
      pReservaAutoIncrem(FReservaBanCtpTarifa, 'BANCTP', FQuantidadeTarifas);

    lstBanCtp.fGetList.Last.strAutInc := fProximoAutoIncremReservado(FReservaBanCtpTarifa, qryCadRec.FieldByName('CTR_CODEMP').AsString);

    LDataLancamento := IIF(dtaDtaTar > 0,
                       IIF(qryRetBco.FieldByName('RET_CODBCO').AsString <> '748', dtaDtaTar, dtaDtaTar - intDiaCred),
                       qryRetBco.FieldByName('RET_DTAOCO').AsDateTime);

     If fGetBancoConfig(0, AConfiguracao, 'DIASCREDITOTARIFA', 'N') = 'S' Then
     Begin
       If (dtaDtaTar <= 0) Then
         LDataLancamento := fAcertaDataParaDiaUtil(LDataLancamento + intDiaCred);
     End;



    objGravacaoTarifa.strSeqLan := fGravaMovBan(strCtaTar,
                                                strPorTar,
                                                strOpeBai,
                                                LDataLancamento,
                                                objGravacaoTarifa.strSeqPag,
                                                'D',
                                                qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                                qryRetBco.FieldByName('RET_TARIFA').AsFloat + ATarifaTed,
                                                'Ref. ao pagamento de tarifas',
                                                '',
                                                '',
                                                strForTar,
                                                objGravacaoTarifa.strSeqPag,
                                                0,
                                                'A',
                                                qryCadRec.FieldByName('CTR_CODEMP').AsString,
                                                'BLT',
                                                fProximoSeqLanReservado(FReservaSeqLanTarifa),
                                                '',
                                                lstBanCtp.fGetList,
                                                FormatDateTime('mm/yyyy',LDataLancamento),
                                                objGravacaoTarifa.intSeqConP,
                                                fProximoAutoIncremReservado(FReservaMovBanTarifa, qryCadRec.FieldByName('CTR_CODEMP').AsString));

    fGravaCadPag('frmPrincipal',
                 'INCLUSAO DA TARIFA',
                 strForTar,
                 objGravacaoTarifa.strSeqPag,
                 'A',
                 qryCadRec.FieldByName('CTR_CODEMP').AsString,
                 strCtaTar,
                 'BLT',
                 0,
                 LDataLancamento,
                 LDataLancamento,
                 0,
                 qryRetBco.FieldByName('RET_TARIFA').AsFloat + ATarifaTed,
                 'N',
                 'N',
                 'N',
                 'Ref. ao pagamento de tarifas' + #13 +
                 'Ref. Duplicata: ' + qryCadRec.FieldByName('CTR_NUMDUP').AsString +
                                      qryCadRec.FieldByName('CTR_PARCEL').AsString + '-' +
                                      qryCadRec.FieldByName('CTR_ESPDOC').AsString + '-' +
                                      qryCadRec.FieldByName('CTR_CODEMP').AsString,
                 '',
                 'Ref. ao pagamento de tarifas',
                 strPorTar,
                 strCtaTar,
                 objGravacaoTarifa.strSeqLan,
                 strLoginUsuarioLogado,
                 LDataLancamento,
                 qryRetBco.FieldByName('RET_TARIFA').AsFloat + ATarifaTed,
                 0,
                 0,
                 VS_strCodEmp,
                 '',
                 'N',
                 '',
                 '',
                 0.0,
                 0.0,
                 objGravacaoTarifa.intSeqConP,
                 False,
                 0,
                 '',
                 0,
                 'N',
                 '',
                 '',
                 '',
                 objGravacaoTarifa.strAutCtp,
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
                 qryRetBco.FieldByName('RET_TARIFA').AsFloat + ATarifaTed);

    //Vincula a Cadrec com Movban e CadPag
    If (Assigned(qryCadRec)) And
       (Not fEmptyStr(strRetAutIncMovBan)) Then
      pGravaCtrBan(qryCadRec.FieldByName('AUTOINCREM').AsString,
                   strRetAutIncMovBan,
                   objGravacaoTarifa.strAutCtp,
                   2,
                   qryRetBco.FieldByName('RET_CODOCO').AsString);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar a tarifa do boleto.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

procedure TfrmPrincipal.pLancaTarifaDoBoletoSintetico(strCodBco: String);
  Var
    intCont: Integer;
begin
  Try
    lstBanCtp.pClear;
    lstBanCtp.fAdd(objGravacaoTarifa.strSeqPag,
                   'A',
                   'BLT',
                   VS_strCodEmp,
                   strForTar,
                   'Ref. ao pagamento de tarifas',
                   '',
                   strCtaTar,
                   VS_strCodEmp,
                   0,
                   objGravacaoTarifa.fltTotalTarifa,
                   objGravacaoTarifa.fltTotalTarifa,
                   0,
                   0,
                   0);

    objGravacaoTarifa.strSeqLan := fGravaMovBan(strCtaTar,
                                                strPorTar,
                                                strOpeBai,
                                                IIF(dtaDtaTar > 0,
                                                    IIF(LeftStr(strCodBco, 3)  <> '748', dtaDtaTar, dtaDtaTar - intDiaCred),
                                                    objGravacaoTarifa.dtaDtaOcoSintetica),
                                                objGravacaoTarifa.strSeqPag,
                                                'D',
                                                VS_strCodEmp,
                                                objGravacaoTarifa.fltTotalTarifa,
                                                'Ref. ao pagamento de tarifas',
                                                '',
                                                '',
                                                strForTar,
                                                objGravacaoTarifa.strSeqPag,
                                                0,
                                                'A',
                                                VS_strCodEmp,
                                                'BLT',
                                                '',
                                                '',
                                                lstBanCtp.fGetList,
                                                FormatDateTime('mm/yyyy',  dtaDtaLan),
                                                objGravacaoTarifa.intSeqConP);

    fGravaCadPag('frmPrincipal',
                 'INCLUSAO DA TARIFA',
                 strForTar,
                 objGravacaoTarifa.strSeqPag,
                 'A',
                 VS_strCodEmp,
                 strCtaTar,
                 'BLT',
                 0,
                 IIF(dtaDtaTar > 0,
                     IIF(LeftStr(strCodBco, 3)  <> '748', dtaDtaTar, dtaDtaTar - intDiaCred),
                     objGravacaoTarifa.dtaDtaOcoSintetica),
                 IIF(dtaDtaTar > 0,
                     IIF(LeftStr(strCodBco, 3)  <> '748', dtaDtaTar, dtaDtaTar - intDiaCred),
                     objGravacaoTarifa.dtaDtaOcoSintetica),
                 0,
                 objGravacaoTarifa.fltTotalTarifa,
                 'N',
                 'N',
                 'N',
                 'Ref. ao pagamento de tarifas' + #13 +
                 'Ref. Duplicata(s): ' + Copy(objGravacaoTarifa.strDadosDuplicatas, 2),
                 '',
                 'Ref. ao pagamento de tarifas',
                 strPorTar,
                 strCtaTar,
                 objGravacaoTarifa.strSeqLan,
                 strLoginUsuarioLogado,
                 IIF(dtaDtaTar > 0,
                     IIF(LeftStr(strCodBco, 3)  <> '748', dtaDtaTar, dtaDtaTar - intDiaCred),
                     objGravacaoTarifa.dtaDtaOcoSintetica),
                 objGravacaoTarifa.fltTotalTarifa,
                 0,
                 0,
                 VS_strCodEmp,
                 '',
                 'N',
                 '',
                 '',
                 0.0,
                 0.0,
                 objGravacaoTarifa.intSeqConP,
                 False,
                 0,
                 '',
                 0,
                 'N',
                 '',
                '',
                 '',
                 objGravacaoTarifa.strAutCtp,
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
                 objGravacaoTarifa.fltTotalTarifa);

    //Vincula a Cadrec com Movban e CadPag
    For intCont := 0 To Length(objGravacaoTarifa.arrDuplicatasTarifa) - 1 Do
    Begin
      If (Not fEmptyStr(strRetAutIncMovBan)) Then
        pGravaCtrBan(objGravacaoTarifa.arrDuplicatasTarifa[intCont],
                     strRetAutIncMovBan,
                     objGravacaoTarifa.strAutCtp,
                     2,
                     objGravacaoTarifa.AOcorrencia);
    End;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar a tarifa do boleto.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
end;

function TfrmPrincipal.fRetornaDataVenctoRetDet(strAutoincrem, strNomarq : String): TdateTime;
  Var
    LQryAux: TUniQuery;
begin

  Try

    LQryAux := fCriaQuery(Nil);

    LQryAux.Close;
    LQryAux.SQL.Clear;
    //LQryAux.SQL.Add(' SELECT DET_DTAVEN FROM RETDET WHERE DET_DUPLIC = :AUTOIN ');

    LQryAux.SQL.Add('SELECT RG.GER_CARTEI, RG.GER_NOMARQ, RD.DET_DUPLIC, RD.DET_DTAVEN ');
    LQryAux.SQL.Add('  FROM RETGER RG ');
    LQryAux.SQL.Add('  INNER JOIN RETDET RD ON RD.DET_SEQGER = RG.AUTOINCREM ');
    LQryAux.SQL.Add('WHERE ');
    LQryAux.SQL.Add('      GER_NOMARQ = :NOMARQ ');
    LQryAux.SQL.Add('  AND RD.DET_DUPLIC = :AUTOIN ');

    LQryAux.ParamByName('AUTOIN').AsString := strAutoincrem;
    LQryAux.ParamByName('NOMARQ').AsString := strNomarq;
    LQryAux.Open;

    If Not LQryAux.IsEmpty Then
    Begin
       If LQryAux.FieldByName('DET_DTAVEN').IsNull Then
          Result := 0
       Else
          Result := LQryAux.FieldByName('DET_DTAVEN').AsDatetime;
    End
    Else
      result := 0;

  Finally
    If Assigned(LQryAux) Then
       FreeAndNil(LQryAux);
  End;

end;

Function TfrmPrincipal.fGravaMovBanJurDescSeparadosAnalitico(strCtaBai,
                                                             strPorBai,
                                                             strOpeBai : String;
                                                             dtaDtaLan,
                                                             dtaHraLan : TDateTime;
                                                             strNumdup,
                                                             strParcel,
                                                             strEspDoc,
                                                             strCodEmp,
                                                             strCodCli,
                                                             strHist01,
                                                             strHist02,
                                                             strHisBai,
                                                             strCodEve,
                                                             strAutoIn : String;
                                                             intSeqCon : Integer;
                                                             intSeqBai : Integer;
                                                             fltValLan,
                                                             fltValJur,
                                                             fltValDes : Double) : String;
Var
    lstBanCtrN : TBanCtrRepository;
    strSeqLanPrinc,
    strSeqLan : String;
    blnOk : Boolean;
    fltValorLanc : Double;
begin

    Try
      lstBanCtrN := TBanCtrRepository.Create;

      blnOk := False;
      strSeqLanPrinc := '';

      fltValorLanc := (fltValLan - fltValJur) + fltValDes;

      lstBanCtrN.fAdd(strNumdup,
                      strParcel,
                      strEspDoc,
                      strCodEmp,
                      strCodCli,
                      strHist01,
                      strHist02,
                      intSeqBai,
                      fltValorLanc); //fltValLan,

      strSeqLanPrinc := fGravaMovBan(strCtaBai,
                                     strPorBai,
                                     strOpeBai,
                                     dtaDtaLan,
                                     strNumdup,
                                     'C',//strCreDeb,
                                     strCodEmp,
                                     fltValorLanc, //fltValLan,
                                     strHisBai,
                                     '',
                                     strCodCli,
                                     '',
                                     strNumdup,
                                     0,
                                     strParcel,
                                     strCodEmp,
                                     '',
                                     '',
                                     strCodEve,
                                     lstBanCtrN.fGetList,
                                     FormatDateTime('mm/yyyy', dtaDtaLan),
                                     intSeqCon);

      If Not fEmptyStr(strSeqLanPrinc) Then
      Begin
        GravarMovCtr(strAutoin, strSeqlan, strCodEmp);
        blnOk := True;
      End;

      If Blnok Then
      Begin

        // Grava Juros.
        If (strSeqLanPrinc <> '') And (fltValJur > 0) Then
        Begin
          strSeqLan := pGravaMovBanJuros(strPorBai,
                                         strOpeBai,
                                         dtaDtaLan,
                                         dtaHraLan,
                                         strNumdup,
                                         strParcel,
                                         strEspDoc,
                                         strCodEmp,
                                         strCodCli,
                                         strHist01,
                                         strHist02,
                                         strHisBai,
                                         strCodEve,
                                         strAutoIn,
                                         intSeqCon,
                                         intSeqBai,
                                         fltValJur);
        End;

        // Grava Desconto.
        If (strSeqLanPrinc <> '') And (fltValDes > 0) Then
        Begin

          strSeqLan := fGravaMovBanDesconto(strPorBai,
                                            strOpeBai,
                                            dtaDtaLan,
                                            dtaHraLan,
                                            strNumdup,
                                            strParcel,
                                            strEspDoc,
                                            strCodEmp,
                                            strCodCli,
                                            strHist01,
                                            strHist02,
                                            strHisBai,
                                            strCodEve,
                                            strAutoIn,
                                            intSeqCon,
                                            intSeqBai,
                                            fltValDes);
        End;

      End;

      result := strSeqLanPrinc;

    Finally
      If Assigned(lstBanCtrN) Then
         FreeAndNil(lstBanCtrN);

    End;

End;

Function TfrmPrincipal.pGravaMovBanJuros(strPorBai,
                                         strOpeBai : String;
                                         dtaDtaLan,
                                         dtaHraLan : TDateTime;
                                         strNumdup,
                                         strParcel,
                                         strEspDoc,
                                         strCodEmp,
                                         strCodCli,
                                         strHist01,
                                         strHist02,
                                         strHisBai,
                                         strCodEve,
                                         strAutoIn : String;
                                         intSeqCon : Integer;
                                         intSeqBai : Integer;
                                         fltValJur : Double) : String;
Var
    lstBanCtrN : TBanCtrRepository;
    strSeqLan,
    strPlConta_juros : String;
    blnOk : Boolean;
begin

    Try
      Result := '';
      blnOk  := False;

      lstBanCtrN := TBanCtrRepository.Create;

      strPlConta_juros := fCfgSis('PLJURM');

      lstBanCtrN.fAdd(strNumdup,
                      strParcel,
                      strEspDoc,
                      strCodEmp,
                      strCodCli,
                      strHist01,
                      strHist02,
                      intSeqBai,
                      fltValJur);

      strSeqLan := fGravaMovBan(strPlConta_juros,
                                strPorBai,
                                strOpeBai,
                                dtaDtaLan,
                                strNumdup,
                                'C',
                                strCodEmp,
                                fltValJur,
                                strHisBai,
                                '',
                                strCodCli,
                                '',
                                strNumdup,
                                0,
                                strParcel,
                                strCodEmp,
                                '',
                                '',
                                strCodEve,
                                lstBanCtrN.fGetList,
                                FormatDateTime('mm/yyyy', dtaDtaLan),
                                intSeqCon);

      If Not fEmptyStr(strSeqLan) Then
      Begin
        GravarMovCtr(strAutoin, strSeqlan, strCodEmp);
        blnOk := True;
      End;

      If blnOk Then
         Result := strSeqLan;

    Finally
      If Assigned(lstBanCtrN) Then
         FreeAndNil(lstBanCtrN);
    End;

End;

Function TfrmPrincipal.fGravaMovBanDesconto(strPorBai,
                                            strOpeBai : String;
                                            dtaDtaLan,
                                            dtaHraLan : TDateTime;
                                            strNumdup,
                                            strParcel,
                                            strEspDoc,
                                            strCodEmp,
                                            strCodCli,
                                            strHist01,
                                            strHist02,
                                            strHisBai,
                                            strCodEve,
                                            strAutoIn : String;
                                            intSeqCon : Integer;
                                            intSeqBai : Integer;
                                            fltValDes : Double): String;
Var
    lstBanCtrN : TBanCtrRepository;
    strSeqLan,
    strPlConta_desc : String;
    blnOk : Boolean;
begin

    Try
      Result := '';
      blnOk  := False;

      lstBanCtrN := TBanCtrRepository.Create;

      strPlConta_desc  := fCfgSis('PLDESM');

      lstBanCtrN.fAdd(strNumdup,
                      strParcel,
                      strEspDoc,
                      strCodEmp,
                      strCodCli,
                      strHist01,
                      strHist02,
                      intSeqBai,
                      fltValDes);

      strSeqLan := fGravaMovBan(strPlConta_desc,
                                strPorBai,
                                strOpeBai,
                                dtaDtaLan,
                                strNumdup,
                                'D',
                                strCodEmp,
                                fltValDes,
                                strHisBai,
                                '',
                                strCodCli,
                                '',
                                strNumdup,
                                0,
                                strParcel,
                                strCodEmp,
                                '',
                                '',
                                strCodEve,
                                lstBanCtrN.fGetList,
                                FormatDateTime('mm/yyyy', dtaDtaLan),
                                intSeqCon);

      If Not fEmptyStr(strSeqLan) Then
      Begin
        GravarMovCtr(strAutoin, strSeqlan, strCodEmp);
        blnOk := True;
      End;

      If blnOk Then
         Result := strSeqLan;

    Finally
      If Assigned(lstBanCtrN) Then
         FreeAndNil(lstBanCtrN);
    End;

End;

Function TfrmPrincipal.fMovBanJurDescSeparadosSintetico(strCtaBai,
                                                        strPorBai,
                                                        strOpeBai : String;
                                                        dtaDtaLan,
                                                        dtaHraLan : TDateTime;
                                                        strNumdup,
                                                        strParcel,
                                                        strEspDoc,
                                                        strCodEmp,
                                                        strCodCli,
                                                        strHist01,
                                                        strHist02,
                                                        strAutoIn : String;
                                                        intSeqBai : Integer;
                                                        fltValLan,
                                                        fltValJur,
                                                        fltValDes : Double) : String;
Var
    strPlConta_desc,
    strPlConta_juros : String;
    fltValorLanc : Double;
begin

  strPlConta_juros := fCfgSis('PLJURM');
  strPlConta_desc  := fCfgSis('PLDESM');

  fltValorLanc := (fltValLan - fltValJur) + fltValDes;

  // ***** Registro principal;
  If stlRegMovBanSep.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan)) >= 0 Then
  Begin
    arrRegMovBanSep[stlRegMovBanSep.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].strPortad := strPorBai;
    arrRegMovBanSep[stlRegMovBanSep.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].strCtaBai := strCtaBai;
    arrRegMovBanSep[stlRegMovBanSep.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].fltValCtb := arrRegMovBanSep[stlRegMovBanSep.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].fltValCtb + fltValorLanc; //fltValLan;

    // Armazena autoincrem para gravação da movctr.
    SetLength(ArrGravaMovCarSep, Length(ArrGravaMovCarSep) + 1);
    ArrGravaMovCarSep[Length(ArrGravaMovCarSep)-1].IntCont    := stlRegMovBanSep.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan));
    ArrGravaMovCarSep[Length(ArrGravaMovCarSep)-1].strAutoInc := strAutoIn;
  End
  Else
  Begin
    stlRegMovBanSep.Add(strPorBai + strCtaBai  + FormatDateTime('yyyy-mm-dd', dtaDtaLan));
    SetLength(lstBanCtrSep, Length(lstBanCtrSep) + 1);
    lstBanCtrSep[Length(lstBanCtrSep)-1] := TBanCtrRepository.Create;
    SetLength(arrRegMovBanSep, Length(arrRegMovBanSep) + 1);
    arrRegMovBanSep[Length(arrRegMovBanSep)-1].strPortad := strPorBai;
    arrRegMovBanSep[Length(arrRegMovBanSep)-1].strCtaBai := strCtaBai;
    arrRegMovBanSep[Length(arrRegMovBanSep)-1].dtaDtaLan := dtaDtaLan;
    arrRegMovBanSep[Length(arrRegMovBanSep)-1].fltValCtb := fltValorLanc; //fltValLan;

    // Armazena autoincrem para gravação da movctr.
    SetLength(ArrGravaMovCarSep, Length(ArrGravaMovCarSep) + 1);
    ArrGravaMovCarSep[Length(ArrGravaMovCarSep)-1].IntCont    := Length(arrRegMovBanSep)-1;
    ArrGravaMovCarSep[Length(ArrGravaMovCarSep)-1].strAutoInc := strAutoIn;
  End;

  lstBanCtrSep[stlRegMovBanSep.IndexOf(strPorBai + strCtaBai + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].fAdd(strNumdup,
                                                                                                              strParcel,
                                                                                                              strEspDoc,
                                                                                                              strCodEmp,
                                                                                                              strCodCli,
                                                                                                              strHist01,
                                                                                                              strHist02,
                                                                                                              intSeqBai,
                                                                                                              fltValorLanc); //fltValLan);

  // ***** GRAVA JUROS *****
  If (fltValJur > 0) Then
  Begin

    If stlRegMovBanSepJur.IndexOf(strPorBai + strPlConta_juros + FormatDateTime('yyyy-mm-dd', dtaDtaLan)) >= 0 Then
    Begin
      arrRegMovBanSepJur[stlRegMovBanSepJur.IndexOf(strPorBai + strPlConta_juros + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].strPortad := strPorBai;
      arrRegMovBanSepJur[stlRegMovBanSepJur.IndexOf(strPorBai + strPlConta_juros + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].strCtaBai := strPlConta_juros;
      arrRegMovBanSepJur[stlRegMovBanSepJur.IndexOf(strPorBai + strPlConta_juros + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].fltValCtb := arrRegMovBanSepJur[stlRegMovBanSepJur.IndexOf(strPorBai + strPlConta_juros + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].fltValCtb + fltValJur;

      // Armazena autoincrem para gravação da movctr.
      SetLength(ArrGravaMovCarSepJur, Length(ArrGravaMovCarSepJur) + 1);
      ArrGravaMovCarSepJur[Length(ArrGravaMovCarSepJur)-1].IntCont    := stlRegMovBanSepJur.IndexOf(strPorBai + strPlConta_juros + FormatDateTime('yyyy-mm-dd', dtaDtaLan));
      ArrGravaMovCarSepJur[Length(ArrGravaMovCarSepJur)-1].strAutoInc := strAutoIn;
    End
    Else
    Begin
      stlRegMovBanSepJur.Add(strPorBai + strPlConta_juros  + FormatDateTime('yyyy-mm-dd', dtaDtaLan));
      SetLength(lstBanCtrSepJur, Length(lstBanCtrSepJur) + 1);
      lstBanCtrSepJur[Length(lstBanCtrSepJur)-1] := TBanCtrRepository.Create;
      SetLength(arrRegMovBanSepJur, Length(arrRegMovBanSepJur) + 1);
      arrRegMovBanSepJur[Length(arrRegMovBanSepJur)-1].strPortad := strPorBai;
      arrRegMovBanSepJur[Length(arrRegMovBanSepJur)-1].strCtaBai := strPlConta_juros;
      arrRegMovBanSepJur[Length(arrRegMovBanSepJur)-1].dtaDtaLan := dtaDtaLan;
      arrRegMovBanSepJur[Length(arrRegMovBanSepJur)-1].fltValCtb := fltValJur;

      // Armazena autoincrem para gravação da movctr.
      SetLength(ArrGravaMovCarSepJur, Length(ArrGravaMovCarSepJur) + 1);
      ArrGravaMovCarSepJur[Length(ArrGravaMovCarSepJur)-1].IntCont    := Length(arrRegMovBanSepJur)-1;
      ArrGravaMovCarSepJur[Length(ArrGravaMovCarSepJur)-1].strAutoInc := strAutoIn;
    End;

    lstBanCtrSepJur[stlRegMovBanSepJur.IndexOf(strPorBai + strPlConta_juros + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].fAdd(strNumdup,
                                                                                                                             strParcel,
                                                                                                                             strEspDoc,
                                                                                                                             strCodEmp,
                                                                                                                             strCodCli,
                                                                                                                             strHist01,
                                                                                                                             strHist02,
                                                                                                                             intSeqBai,
                                                                                                                             fltValJur);
  End;

  // ***** GRAVA DESCONTO *****
  If (fltValDes > 0) Then
  Begin

    If stlRegMovBanSepDes.IndexOf(strPorBai + strPlConta_desc + FormatDateTime('yyyy-mm-dd', dtaDtaLan)) >= 0 Then
    Begin
      arrRegMovBanSepDes[stlRegMovBanSepDes.IndexOf(strPorBai + strPlConta_desc + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].strPortad := strPorBai;
      arrRegMovBanSepDes[stlRegMovBanSepDes.IndexOf(strPorBai + strPlConta_desc + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].strCtaBai := strPlConta_desc;
      arrRegMovBanSepDes[stlRegMovBanSepDes.IndexOf(strPorBai + strPlConta_desc + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].fltValCtb := arrRegMovBanSepDes[stlRegMovBanSepDes.IndexOf(strPorBai + strPlConta_desc + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].fltValCtb + fltValDes;

      // Armazena autoincrem para gravação da movctr.
      SetLength(ArrGravaMovCarSepDes, Length(ArrGravaMovCarSepDes) + 1);
      ArrGravaMovCarSepDes[Length(ArrGravaMovCarSepDes)-1].IntCont    := stlRegMovBanSepDes.IndexOf(strPorBai + strPlConta_desc + FormatDateTime('yyyy-mm-dd', dtaDtaLan));
      ArrGravaMovCarSepDes[Length(ArrGravaMovCarSepDes)-1].strAutoInc := strAutoIn;
    End
    Else
    Begin
      stlRegMovBanSepDes.Add(strPorBai + strPlConta_desc + FormatDateTime('yyyy-mm-dd', dtaDtaLan));
      SetLength(lstBanCtrSepDes, Length(lstBanCtrSepDes) + 1);
      lstBanCtrSepDes[Length(lstBanCtrSepDes)-1] := TBanCtrRepository.Create;
      SetLength(arrRegMovBanSepDes, Length(arrRegMovBanSepDes) + 1);
      arrRegMovBanSepDes[Length(arrRegMovBanSepDes)-1].strPortad := strPorBai;
      arrRegMovBanSepDes[Length(arrRegMovBanSepDes)-1].strCtaBai := strPlConta_desc;
      arrRegMovBanSepDes[Length(arrRegMovBanSepDes)-1].dtaDtaLan := dtaDtaLan;
      arrRegMovBanSepDes[Length(arrRegMovBanSepDes)-1].fltValCtb := fltValDes;

      // Armazena autoincrem para gravação da movctr.
      SetLength(ArrGravaMovCarSepDes, Length(ArrGravaMovCarSepDes) + 1);
      ArrGravaMovCarSepDes[Length(ArrGravaMovCarSepDes)-1].IntCont    := Length(arrRegMovBanSepDes)-1;
      ArrGravaMovCarSepDes[Length(ArrGravaMovCarSepDes)-1].strAutoInc := strAutoIn;
    End;

    lstBanCtrSepDes[stlRegMovBanSepDes.IndexOf(strPorBai + strPlConta_desc + FormatDateTime('yyyy-mm-dd', dtaDtaLan))].fAdd(strNumdup,
                                                                                                                            strParcel,
                                                                                                                            strEspDoc,
                                                                                                                            strCodEmp,
                                                                                                                            strCodCli,
                                                                                                                            strHist01,
                                                                                                                            strHist02,
                                                                                                                            intSeqBai,
                                                                                                                            fltValDes);
  End;

End;

function TfrmPrincipal.fOcorrenciaContasAPagarValida(ACodigoBanco,
  AOcorrencia: string): Boolean;
begin
  Result := True;

  ACodigoBanco := Trim(ACodigoBanco);
  AOcorrencia  := Trim(AOcorrencia);

  If Pos(AOcorrencia,'00_01_17_18_') > 0 Then
    Exit;

  If fEhOcorrenciaPagamentoCondicaoTesteBradesco(ACodigoBanco, AOcorrencia) Then
    Exit;

  Result := False;
end;

function TfrmPrincipal.fEhOcorrenciaPagamentoCondicaoTesteBradesco(ACodigoBanco,
  AOcorrencia: string): Boolean;
begin
  Result := False;

  If ACodigoBanco <> '237' Then
    Exit;

  If AOcorrencia <> '5THF' Then
    Exit;

  Result := True;
end;

function TfrmPrincipal.fOcorrenciaParaRestaurarBoleto(AConfiguracaoCarteira,
  AOcorrencia: String): Boolean;
begin
  Result := False;

  if not AOcorrencia.Equals('09') then
    Exit;

  Result := fGetBancoConfig(0,AConfiguracaoCarteira, 'RESTAURABOL09', '') = 'S';
end;

Procedure TfrmPrincipal.pGravaMovBanSinteticoBanco(strOpeBai : String);
 Var
     intCont, intArr : Integer;
     strSeqLan,
     strSeqLanMovBan : String;
Begin

   Try

     // Registro principal
     For intCont := 0 To stlRegMovBanSep.Count -1 Do
     Begin
       strSeqLan := fSeqContaBanco;

       strSeqLanMovBan := fGravaMovBan(arrRegMovBanSep[intCont].strCtaBai,
                                       arrRegMovBanSep[intCont].strPortad,
                                       strOpeBai,
                                       arrRegMovBanSep[intCont].dtaDtaLan,
                                       '',
                                       'C',
                                       VS_strCodEmp,
                                       arrRegMovBanSep[intCont].fltValCtb,
                                       'BAIXA AUTOMATICA DE DUPLICATAS',
                                       '',
                                       '',
                                       '',
                                       '',
                                       0,
                                       '',
                                       '',
                                       '',
                                       strSeqLan,
                                       '',
                                       lstBanCtrSep[intCont].fGetList,
                                       FormatDateTime('mm/yyyy',  arrRegMovBanSep[intCont].dtaDtaLan));

       If Not fEmptyStr(strSeqLanMovBan) Then
       Begin

          For intArr := 0 To (Length(ArrGravaMovCarSepDes) -1) Do
          Begin
              If ArrGravaMovCarSep[intArr].intCont = intCont Then
              Begin
                GravarMovCtr(ArrGravaMovCarSep[intArr].strAutoinc,
                             strSeqLanMovBan,
                             VS_strCodEmp)
              End;
          End;


       End;

     End;

     // ***** Registros Juros *****
     For intCont := 0 To stlRegMovBanSepJur.Count -1 Do
     Begin
       strSeqLan := fSeqContaBanco;

       strSeqLanMovBan := fGravaMovBan(arrRegMovBanSepJur[intCont].strCtaBai,
                                       arrRegMovBanSepJur[intCont].strPortad,
                                       strOpeBai,
                                       arrRegMovBanSepJur[intCont].dtaDtaLan,
                                       '',
                                       'C',
                                       VS_strCodEmp,
                                       arrRegMovBanSepJur[intCont].fltValCtb,
                                       'BAIXA AUTOMATICA DE DUPLICATAS REF. JUROS',
                                       '',
                                       '',
                                       '',
                                       '',
                                        0,
                                       '',
                                       '',
                                       '',
                                       strSeqLan,
                                       '',
                                       lstBanCtrSepJur[intCont].fGetList,
                                       FormatDateTime('mm/yyyy',  arrRegMovBanSepJur[intCont].dtaDtaLan));

       If Not fEmptyStr(strSeqLanMovBan) Then
       Begin

          For intArr := 0 To (Length(ArrGravaMovCarSepJur) -1) Do
          Begin
              If ArrGravaMovCarSepJur[intArr].intCont = intCont Then
              Begin
                 GravarMovCtr(ArrGravaMovCarSepJur[intArr].strAutoinc,
                              strSeqLanMovBan,
                              VS_strCodEmp)
              End;
          End;

       End;

     End;

     // ***** Registros Descontos *****
     For intCont := 0 To stlRegMovBanSepDes.Count -1 Do
     Begin
       strSeqLan := fSeqContaBanco;

       strSeqLanMovBan := fGravaMovBan(arrRegMovBanSepDes[intCont].strCtaBai,
                                        arrRegMovBanSepDes[intCont].strPortad,
                                        strOpeBai,
                                        arrRegMovBanSepDes[intCont].dtaDtaLan,
                                        '',
                                        'D',
                                        VS_strCodEmp,
                                        arrRegMovBanSepDes[intCont].fltValCtb,
                                        'BAIXA AUTOMATICA DE DUPLICATAS REF. DESCONTOS',
                                        '',
                                        '',
                                        '',
                                        '',
                                        0,
                                        '',
                                        '',
                                        '',
                                        strSeqLan,
                                        '',
                                        lstBanCtrSepDes[intCont].fGetList,
                                        FormatDateTime('mm/yyyy',  arrRegMovBanSepDes[intCont].dtaDtaLan));

       If Not fEmptyStr(strSeqLanMovBan) Then
       Begin

          For intArr := 0 To (Length(ArrGravaMovCarSepDes) -1) Do
          Begin
              If ArrGravaMovCarSepDes[intArr].intCont = intCont Then
              Begin
                 GravarMovCtr(ArrGravaMovCarSepDes[intArr].strAutoinc,
                              strSeqLanMovBan,
                              VS_strCodEmp)
              End;
          End;

       End;

     End;

   Except
     On E: Exception Do
        Raise Exception.Create('Ocorreu um erro ao gravar os registros separados da movimentação bancária sintética.' + #13 +
                               'Erro gerado: ' + E.Message);
   End;

End;

end.
