unit untCadRec;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untfuncoesSimples, UniClientDataSet, Winapi.Windows, untFuncoesBoleto,
{$ENDIF}
  IOUtils, Classes, DB, Uni,  DateUtils, untLogCtr,
  untFuncoesGenerica,untTypesSistema, Math;

Var
  FCamposCadRec,
  FCamposNovoCadRec,
  FParametrosNovoCadRec: String;
Const
  FArrayCamposIgnorados: Array of String = ['AUTOINCREM', 'CTR_DINHEI', 'CTR_CARTAO', 'CTR_CHQAVI', 'CTR_CHQPRE',
                                            'CTR_CREDIT', 'CTR_ORDPAG'];

  FArrEspRecebidas: Array of String = ['CTR_DINHEI', 'CTR_CARTAO', 'CTR_CHQAVI', 'CTR_CHQPRE', 'CTR_CREDIT', 'CTR_ORDPAG'];

Type
  TModal = Record
    fltDin: Double;
    fltCqV: Double;
    fltCqP: Double;
    fltCar: Double;
    fltOrd: Double;
    fltFin: Double;
    fltTot: Double;
    fltDif: Double;
    fltRec: Double;
  End;

  function fValidaExclusaoBoletoAdiantamento(strNumDup, strEspDoc, strCodEmp, strCodCli: String): Boolean;

  procedure pSetaEmp_PD(qryTabCadRec: TUniQuery; strEmp_PD, strCodVen, strCodEmp: String);

  function fCriaCdsRateio(AOwner: TComponent): TUniClientDataSet;

  function fAutenticaTRDV(strNumDup,
                          strParcel,
                          strEspDoc,
                          strCodEmp,
                          strCodCli: String;
                          intSeqBai: Integer;
                          fltVrTrDv: Double): Boolean;

  procedure pGravaRateio(cdsRateio: TUniClientDataSet;
                         intSeqBai: Integer;
                         strNumDup: String;
                         strParcel: String;
                         strEspDoc: String;
                         strCodEmp: String;
                         strCodCli: String;
                         fltValRec: Double;
                         fltValDin: Double;
                         fltValCqV: Double;
                         fltValCqP: Double;
                         fltValCar: Double;
                         fltValOrd: Double;
                         fltValFin: Double);

  function RetornaSelectLinkDoBoleto: String;
  function RetornaSQLDuplicatasDVCCVincularMovCar: String;

  function fAcertaRateio(cdsRateio: TUniClientDataSet; fltCredGer: Double = 0; blnCreMai: Boolean = False): Boolean;

  function fGravaHistoricoParcelamento(strNumDup, strEspDoc, strCodEmp, strCodCli, strInfPar: String): Boolean;
  function fHistoricoParcelamento(strNumDup, strEspDoc, strCodEmp, strCodCli: String): String;

  procedure GeraListaDeCamposCADREC();
  function VerificaSeTemVariasEspeciesRecbto(AAutoIncrem: String) : Boolean;
  function DesmembraDuplicatasPorEspecie(AAutoIncrem: String; APortadorTF : String = ''; fltValCreArm: Double = 0; fltTotPgto : Double = 0; const APortadorAdtCredito : String = ''; const AValorAdtCredito : Double = 0) : TStringArray;
  procedure RateiaCreditoPorEspecie(fltCredito : Double; ARecEspeciesCC: array of TEspeciesGerCC);
  Procedure VerificaValoresRateioCredito(intSeqCon : Integer; fltCredito: Double);


  function fGravaCadRec(strNomFrmLogCtr,
                        strDescriLogCtr,
                        strNumDup,
                        strParcel: String;
                        intSeqBai: Integer;
                        strEspDoc,
                        strCodCli,
                        strCodEmp,
                        strCodVen,
                        strCodDig,
                        strCodPor: String;
                        dtaDtaCad,
                        dtaDtaVen: TDateTime;
                        fltValDup,
                        fltValOri,
                        fltDesCob: Double;
                        strDescon,
                        strHist01,
                        strHist02,
                        strPorBai,
                        strCtaBai,
                        strOpeBai,
                        strDocBai: String;
                        fltValRec: Double;
                        dtaDtaRec: TDateTime;
                        strAdtCli,
                        strCodEve,
                        strCodVel,
                        strTipFor,
                        strCodCnd: String;
                        blnConApr: Boolean;
                        strCodCta: String;
                        intSeqCon: Integer;
                        fltGrvOri: Double;
                        strObsAg1: String = '';
                        strObsAg2: String = '';
                        strObsAg3: String = '';
                        strCtaSer: String = '';
                        fltValSer: Double = 0;
                        intResCai: Integer = 0;
                        fltVlrCom: Double = 0;
                        fltFatCom: Double = 0;
                        strEmpBai: String = '';
                        strEmp_PD: String = '';
                        strDocDiv: String = '';
                        strEspDiv: String = '';
                        strEmpDiv: String = '';
                        strCliDiv: String = '';
                        fltVlrRep: Double = 0;
                        fltFatRep: Double = 0;
                        strCodRep: String = '';
                        fltValIPI: Double = 0;
                        fltValRet: Double = 0;
                        strOriF11: String = 'N';
                        fltDesSuj: Double = 0;
                        fltJurSuj: Double = 0;
                        fltValCqP: Double = 0;
                        fltValCqV: Double = 0;
                        fltValDin: Double = 0;
                        fltValCar: Double = 0;
                        fltValOrd: Double = 0;
                        fltValFin: Double = 0;
                        strBarCon: String = '';
                        fltPerDPo: Double = 0;
                        intQtdDAV: Integer = 0;
                        fltVrTrDv: Double = 0;
                        strHisBai: String = '';
                        fltValAce: Double = 0;
                        fltValFre: Double = 0;
                        fltDifOri: Double = 0;
                        fltValAnt: Double = 0;
                        fltComDiv: Double = 0;
                        fltFatDiv: Double = 0;
                        strCodDiv: String = '';
                        fltValFCP: Double = 0;
                        strStatusDEPS: String = 'INCLUSÃO';
                        strOpcDoc: String = '';
                        strAutincMovGerFC: String = '';
                        strINCDOC: String = '';
                        strRecPix: String = 'N';
                        strNoFaFF: String = 'N';
                        strChaveMeiaNota: String = '';
                        strPedidoRef: String = '';
                        ASeqMpx: String = '';
                        strSeqEqu: String = '';
                        ASequencialDaBaixaAnterior : Integer = 0;
                        ADataDaBaixaAnterior : TDateTime = 0;
                        strCodPrj: String = '';
                        fltValCBS: Double = 0;
                        fltValIBS: Double = 0;
                        fltVal_IS: Double = 0): Boolean; Overload;

  function fGravaCadRec(Var strAutoInc: String;
                        strNomFrmLogCtr,
                        strDescriLogCtr,
                        strNumDup,
                        strParcel: String;
                        intSeqBai: Integer;
                        strEspDoc,
                        strCodCli,
                        strCodEmp,
                        strCodVen,
                        strCodDig,
                        strCodPor: String;
                        dtaDtaCad,
                        dtaDtaVen: TDateTime;
                        fltValDup,
                        fltValOri,
                        fltDesCob: Double;
                        strDescon,
                        strHist01,
                        strHist02,
                        strPorBai,
                        strCtaBai,
                        strOpeBai,
                        strDocBai: String;
                        fltValRec: Double;
                        dtaDtaRec: TDateTime;
                        strAdtCli,
                        strCodEve,
                        strCodVel,
                        strTipFor,
                        strCodCnd: String;
                        blnConApr: Boolean;
                        strCodCta: String;
                        intSeqCon: Integer;
                        fltGrvOri: Double;
                        strObsAg1: String = '';
                        strObsAg2: String = '';
                        strObsAg3: String = '';
                        strCtaSer: String = '';
                        fltValSer: Double = 0;
                        intResCai: Integer = 0;
                        fltVlrCom: Double = 0;
                        fltFatCom: Double = 0;
                        strEmpBai: String = '';
                        strEmp_PD: String = '';
                        strDocDiv: String = '';
                        strEspDiv: String = '';
                        strEmpDiv: String = '';
                        strCliDiv: String = '';
                        fltVlrRep: Double = 0;
                        fltFatRep: Double = 0;
                        strCodRep: String = '';
                        fltValIPI: Double = 0;
                        fltValRet: Double = 0;
                        strOriF11: String = 'N';
                        fltDesSuj: Double = 0;
                        fltJurSuj: Double = 0;
                        fltValCqP: Double = 0;
                        fltValCqV: Double = 0;
                        fltValDin: Double = 0;
                        fltValCar: Double = 0;
                        fltValOrd: Double = 0;
                        fltValFin: Double = 0;
                        strBarCon: String = '';
                        fltPerDPo: Double = 0;
                        intQtdDAV: Integer = 0;
                        fltVrTrDv: Double = 0;
                        strHisBai: String = '';
                        fltValAce: Double = 0;
                        fltValFre: Double = 0;
                        fltDifOri: Double = 0;
                        fltValAnt: Double = 0;
                        fltComDiv: Double = 0;
                        fltFatDiv: Double = 0;
                        strCodDiv: String = '';
                        fltValFCP: Double = 0;
                        strStatusDEPS: String = 'INCLUSÃO';
                        strOpcDoc: String = '';
                        strAutincMovGerFC: String = '';
                        strINCDOC: String = '';
                        strRecPix: String = 'N';
                        strNoFaFF: String = 'N';
                        strChaveMeiaNota: String = '';
                        strPedidoRef: String = '';
                        ASeqMpx: String = '';
                        strSeqEqu: String = '';
                        ASequencialDaBaixaAnterior : Integer = 0;
                        ADataDaBaixaAnterior : TDateTime = 0;
                        strCodPrj: String = '';
                        fltValCBS: Double = 0;
                        fltValIBS: Double = 0;
                        fltVal_IS: Double = 0): Boolean; Overload;

  Function fBaixaParcial(strNumDup,
                         strParcel,
                         strCodEmp,
                         strEspDoc,
                         strCodCli: String;
                         fltValRec,
                         fltValJur,
                         fltValDes: Double;
                         dtaDtaRec,
                         dtaDtaVen: TDateTime;
                         strPorBai,
                         strHisBai,
                         strCtaBai,
                         strOpeBai,
                         strSeqLan: String;
                         fltNovoValOri,
                         fltNovoValDup,
                         fltValCqP,
                         fltValCqV,
                         fltValDin,
                         fltValCar,
                         fltValOrd,
                         fltValFin: Double;
                         intResCai: Integer;
                         intSeqMod: Integer;
                         blnRecCqP,
                         blnRecCqV,
                         blnRecDin,
                         blnRecCar,
                         blnRecOrd,
                         blnRecFin : boolean;
                     Var intSeqBai : Integer;
                     Var strAutIncNov: String;
                         intSeqCon: Integer;
                         fltValIpi,
                         fltValRet,
                         fltValAce,
                         fltValFre,
                         fltValFCP,
                         fltDifOri: Double;
                         dtaMovimentacaoBancaria : TDate;
                         AValorBaixadoDuplicata,
                         ANovoJurSuj,
                         AFatorDuplicata,
                         AFatorJuros,
                         ANovoDesSuj,
                         AValorCorrigido: Double;
                         strRecAut: String = 'N';
                         strEmpBai: String = '';
                         fltGrvOri: Double = 0;
                         strId_Loc: String = '';
                         strId_Doc: String = '';
                         strAutincMovGerFC: String = '';
                         strRecPix: String = 'N';
                         ADespesasBaixaDuplicata: Double = 0;
                         ADespesasNovaDuplicata: Double = 0;
                         fltValCBS: Double = 0;
                         fltValIBS: Double = 0;
                         fltVal_IS: Double = 0): Boolean;

  Function fBaixaTotal( strNumDup,
                        strParcel,
                        strEspDoc,
                        strCodEmp,
                        strCodCli: String;
                        fltValDup,
                        fltValRec,
                        fltValJur,
                        fltValDes,
                        fltValCqP,
                        fltValCqV,
                        fltValDin,
                        fltValCar,
                        fltValOrd,
                        fltValFin: Double;
                        dtaDtaRec: TDateTime;
                        strSeqLan,
                        strHisBai,
                        strCtaBai,
                        strPorBai,
                        strOpeBai: String;
                        intSeqMod: Integer;
                        blnRecCqP,
                        blnRecCqV,
                        blnRecDin,
                        blnRecCar,
                        blnRecOrd,
                        blnRecFin: boolean;
                        intResCai: Integer;
                        intSeqCon: Integer;
                        dtaMovimentacaoBancaria : TDate;
                        strRecAut: String = 'N';
                        strEmpBai: String = '';
                        strId_Loc: String = '';
                        strId_Doc: String = '';
                        strAutCtp: String = '';
                        blnAutBan: Boolean = False;
                        fltValCob: Double = 0;
                        strBaiMan: String = 'N';
                        strRecPix: String = 'N';
                        strEnd_ID: String = '';
                        blnLimpaDadosPixBoleto: Boolean = False;
                        AChaveCarteiraBaixa: String = '';
                        AAtualizarBolCtr: Boolean = True): Boolean;

  function fRetSeqBaiCadRec(strNumDup,
                            strParcel,
                            strCodEmp,
                            strEspDoc,
                            strCodCli: String): Integer;

  function fVerificaNumAgr(strNumAgr,
                           strCodCli: String): Boolean;

  function fCreditoDiretoComMovBan(arrDupSel : TArrDupSel = Nil): String;

  function fRetDoctosCadRecAgr(strNumAgr,
                               strCodCli: String): TStringList;

  function fGetValOriDuplicata(strNumDup,
                               strEspDoc,
                               strCodEmp,
                               strParcel,
                               strCodCli: String): Double;

  function fValidaNossoNumero(strNosNum,
                              strCodEmp,
                              strCodBco: String;
                              Var strNumDup: String;
                              strDupAlt: String): Boolean;

  function fDuplicataCtrBaixada(strNumDup,
                                strParcel,
                                strEspDoc,
                                strCodEmp,
                                strCodCli: String;
                                intSeqBai: Integer): Boolean;

  function fRetornaCodigoProjeto(strNumDup,
                                 strEspDoc,
                                 strCodEmp,
                                 strCodCli: String): String;
  function fGetSqlCodigoProjeto(strEspDoc : String): String;

  {$IFNDEF LINUX}
  function fGravaNumBco(strCodBco,
                      strCodPor: String;
                      Var strNosNum: String;
                      Var strNumDig: String;
                      qryArqCtr: TDataSet;
                      ctrDuplicata: PTDuplicataCtr = Nil;
                      strBcoIni: String = '';
                      intCodCar: Integer = 0;
                      strBB_Crr: String = '';
                      fltPerMor: Double = 0;
                      fltPerMul: Double = 0;
                      strBraCrr: String = '';
                      strEmpresaImpressao: String = '';
                      ALinhaDigitavel: String = '';
                      AObservacao01: String = '';
                      AObservacao02: String = ''): Boolean;
  {$ENDIF}

  function fLimpaDadosRemessa(strNumDup,
                              strParcel,
                              strEspDoc,
                              strCodEmp,
                              strCodCli: String;
                              intSeqBai: Integer): Boolean;

  function fDeletaDupAgr(strNumAgr, strCodCli: String): Boolean;

  function fDeletaDel_CadRec(strNumDup,
                             strParcel,
                             strEspDoc,
                             strCodEmp,
                             strCodCli: String;
                             intSeqBai: Integer): Boolean;

  function fGravaDupAgr(strNumAgr,
                        strNumDup,
                        strParcel: String;
                        intSeqBai: Integer;
                        strEspDoc,
                        strCodCli,
                        strCodEmp,
                        strCodPor,
                        strCodVen,
                        strCodDig: String;
                        dtaDtaCad,
                        dtaDtaVen: TDateTime;
                        fltValDup,
                        fltValOri,
                        fltDesCob: Double;
                        strDesCon,
                        strHist01,
                        strHist02,
                        strAdtCli,
                        strCodEve,
                        strCodVel,
                        strTipFor,
                        strCodCnd: String;
                        blnConApr: Boolean;
                        strEmpAgr,
                        strCodCta: String;
                        strEmp_PD: String;
                        intSeqCon: Integer;
                        fltDifOri,
                        fltValAnt,
                        fltGrvOri: Double;
                        strCtaSer: String = '';
                        fltSerVal: Double = 0;
                        fltVlrCom: Double = 0;
                        fltFatCom: Double = 0;
                        fltFatCo2: Double = 0;
                        fltValDes: Double = 0;
                        fltValJur: Double = 0;
                        strConPag: String = '';
                        strCodRep: String = '';
                        fltVlrRep: Double = 0;
                        fltFatRep: Double = 0;
                        fltValIPI: Double = 0;
                        fltValRet: Double = 0;
                        fltDesSuj: Double = 0;
                        fltJurSuj: Double = 0;
                        strBarCon: String = '';
                        fltPerDpo: Double = 0;
                        intQtdDAV: Integer = 0;
                        fltValAce: Double = 0;
                        fltValFre: Double = 0;
                        fltValCob: Double = 0;
                        strDocDiv: String = '';
                        strEspDiv: String = '';
                        strEmpDiv: String = '';
                        strCliDiv: String = '';
                        fltComDiv: Double = 0;
                        fltFatDiv: Double = 0;
                        strCodDiv: String = '';
                        fltValFCP: Double = 0;
                        strAutoIncremCadRec: String = '';
                        LIncDoc: String = '';
                        ASeqMpx: String = '';
                        fltValCBS: Double = 0;
                        fltValIBS: Double = 0;
                        fltVal_IS: Double = 0): Boolean;

  function fApagaDuplicataContasReceber(qryTabCadRec: TUniQuery;
                                        strNomeFormulario: String;
                                        strDescri: String = '';
                                        blnGravaSistemaDEPS: Boolean = True;
                                        ARaiseException: Boolean = False): Boolean; Overload;

  function fApagaDuplicataContasReceber(cdsTabCadRec: TUniClientDataSet;
                                        strNomeFormulario: String;
                                        strDescri: String = '';
                                        blnGravaSistemaDEPS: Boolean = True;
                                        ARaiseException: Boolean = False): Boolean; Overload;


  function fRateioRec(fltTotGer, fltTotDup, fltValRec: Double): Double;

  {$IFNDEF LINUX}
  function fGravaDtaBoletoImpresso(qryArqCtr: TDataSet; ACodigoBanco: String = ''): Boolean;
  {$ENDIF}

  function fGravaDespProt(strNumPro,
                          strNumDup,
                          strParcel,
                          strEspDoc,
                          strCodCli,
                          strCodEmp: String): Boolean;

  procedure pDesvinculaDespesaCobrancaDaDuplicataOrigem(strNumDup,strParcel,
                                                        strEspDoc,strCodCli,
                                                        strCodEmp: String);

  function fRetornaDuplicataOrigemDespesaCobranca(strProtes,strCodCli,strCodEmp: String): TUniQuery;

  function fRetAutIncCadRecSeqBaiZero(strNumDoc, strEspDoc, strCodEmp, strCodCli, strParcela: string): String;
  function fRetSeqBaiCadRecDesmembrados(const strNumDoc, strEspDoc, strCodEmp, strCodCli, strParcela : String) : Integer;
  function fAlteraValorBoleto(strAutInc: string; fltValBol: Double; dtaDtaVenc: TDate): Boolean;

  function RetornaDadosDaBaixa(ANumDup,AParcel,AEspDoc,ACodEmp,
                               ACodCli,AAdtCli,AEmpBai : String;
                               ASeqCon : Integer): TDadosDaBaixaContasReceber;

  function RetornaValorAnterior(ASeqCon: Integer;
                                AEmpBai,
                                ANumDup,
                                AParcel,
                                AEspDoc,
                                ACodEmp,
                                ACodCli: String;
                                ASeqBai: Integer): Double;

  function RetornaValorAnteriorBaixaTotal(ASeqCon: Integer;
                                          AEmpBai,
                                          ANumDup,
                                          AParcel,
                                          AEspDoc,
                                          ACodEmp,
                                          ACodCli: String): Double;

  function fCriaQryDadosDuplic(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli: String): TUniQuery;
  function fGravaNumCart( strCodBco, strCodPor: String;
                          Var strNosNum: String;
                          Var strNumDig: String;
                          qryArqCtr: TDataSet;
                          ctrDuplicata: PTDuplicataCtr = Nil;
                          strBcoIni: String = '';
                          intCodCar: Integer = 0;
                          strBB_Crr: String = '';
                          fltPerMor: Double = 0;
                          fltPerMul: Double = 0;
                          strEmpresaImpressao: String = ''): Boolean;

  function fGravaVencimento(dteVencimento: TDate; fltDesSuj, fltJurSuj: Double; strHistorico, strAutoincrem, strNomeForm: String; strHisPro : String = ''): Boolean;

  function fRetUltimaAlteracaoCadRecGeral(strNumDup, strEspDoc, strCodEmp, strCodCli: String): TDateTime;
  
  procedure pLimpaVariaveisCadRec;

  procedure pGravaLogCtr(strAutInc, strDescricaoLog, strNomForm: String); Overload;
  procedure pGravaLogCtr(strNumDup, strEspDoc, strCodCli,
  strCodEmp, strParcel: String; intSeqBai: Integer; strDescricaoLog, strNomForm: String); Overload;

  procedure pGravaLogCtr(strNumDup, strEspDoc, strCodCli,
  strCodEmp, strParcel: String; intSeqBai: Integer; strDescricaoLog, strNomForm: String; fltDespCobr : Double); Overload;

  function fRetUltimaAlteracaoCadRec(strNumDup, strParcel, strEspDoc, strCodCli,
                                     strCodEmp: String; intSeqBai: Integer = 0): TDateTime;

  function fGetUltimaAlteracaoCadRec(strNumDup, strParcel, strEspDoc, strCodCli,
                                     strCodEmp: String; intSeqBai: Integer = 0): String;

  function fCreditoGeradoPeloAdiantamento(strNumDup,
                                        strParcel,
                                        strCodEmp,
                                        strCodCli: String;
                                        Var strNumeroPedido: String): Boolean;

  function fRetornaSobraDeJurosDeBaixasAnteriores(strNumDup,
                                                  strParcel,
                                                  strEspDoc,
                                                  strCodEmp,
                                                  strCodCli,
                                                  strSeqBai: String): Double;

  function ValidaSeAlgumDosDocumentosSofreuAlteracao(ADataset: TUniClientDataSet): Boolean;

  {***********************************}
  {* FUNÇÃO QUE GRAVA LOG ESPECÍFICO *}
  {* DE PRORROGAÇÃO DE VENCIMENTO CTR*}
  {********************************FS*}
  function fGravaCtrPrd(strNumDup,
                        strParcel: String;
                        intSeqBai: Integer;
                        strEspDoc,
                        strCodCli,
                        strCodEmp: String;
                        fltValDup: Double;
                        dtaDtaVc1,
                        dtaDtaVc2: TDateTime;
                        strOpeAlt,
                        strNomFrm: String;
                        strHisPro: String = ''): Boolean;

  function fPermitiDesagruparDuplicata(AstrNumeroAgrupamento, AstrCodigoCliente: String): Boolean;

  function fCadRecExiste(strNumDup, strEspDoc, strCodEmp, strCodCli: string): boolean; overload;
  function fCadRecExiste(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli: string): boolean; overload;

  function ExisteCartaoOuChequeVinculadoDoResumoDeCaixa(ANumDup, AParcel, AEspDoc, ACodEmp, ACodCli: string): Boolean;

  function fRetornaCodigoEmpresaDup(strAutoInc: string): String;

  function fRetornaNomeArquivoBol(strAutoInc: string): String;

  procedure GravarCarteiraBoleto(ADuplicata: TDuplicataCtr; AChaveCarteira: String);

  procedure DeletarCarteiraBoleto(ADuplicata: TDuplicataCtr);

  procedure GravarPDFBoleto(AAutoIncremCadRec,
                            ACaminhoDoArquivo: String;
                            AArquivo: TFileStream = Nil);

  procedure GravarPDFBoletosCarne(ABoletos: Array Of TDuplicataCtr;
                                  APastaBoletos: String);

  procedure GravaPDFPorEmpresa(AAutoIncremCadRec,
                               ACaminhoDoArquivo: String);

  procedure GravarPDFPorEmpresaBoletosCarne(ABoletos: Array Of TDuplicataCtr;
                                            APastaBoletos: String);


  procedure RemovePDFRealocadosPorEmpresa( stlBolRealoc : TStringlist );

  procedure GravarTabelaImpressaoBoletoAutomatico(ASeqCtr: String);

  procedure AtualizarAutoIncremBOLCTR(AAutoIncremParcial,
                                      AAutoIncremAberta: String);

  procedure AtualizaBOLCTRBoletosBaixaTotal(AAutoIncremCtr: String);

  procedure AtualizaBOLCTRBoletosEstornoTotal(AAutoIncremCtr: String);

  procedure AtualizaBOLCTRBoletosEstornoParcial(AAutoIncremCtr: String;
                                                AAtualizaBaixa: Boolean);

  procedure MarcarComoBoletoBancoInter(AAutoIncrem: String);

  function fExecutadoViaRoboEnvioEmail: Boolean;

  function VerificaExclusaoOuAlteracaoDeDuplicatasNoCaixa(ARegistros: TUniCLientDataset): Boolean;

  procedure EPermissaoNegadaGravacaoCadRec(strMsgMotivo: String);

  procedure pVerificaTravaCCCliente(strCodCli: String; fltValDup: Double);

  procedure pTravaDestravaCredito(blnTrava: Boolean; strCodCli: string);
  function fVerificaUtilizacaoDeCredito(strCodCli: string): Boolean;
  function fGravaValAdt(strAutIncFgo, strAutIncCadRec: string; fltValAdt: Double): Boolean;
  function fExcluiValAdtPeloSeqCtr(strAutIncCadRec: String): Boolean;

  procedure AtualizarCADRECEmailPix(ADataset: TDataset;
                                    ATxIdPix: String;
                                    ANomeFormulario: String);

  function DuplicataCorrespondenteAOutroBanco(ABcoIni,AAutoIncrem: String; Var ANomBcoApi: String): Boolean;

  function BoletoApiCancelado(AAutoIncremCadRec: String): Boolean;

  function RetornaSQLEmailCliente: String;
  function RetornaSQLCamposTabelasTemporaria(ADescFinanSomenteAteVenc: Boolean;
                                             ACodigoEvento,
                                             ARomaneio: String): String;

  function RetornaDuplicatasDosPixJaGerado(ATxIdPix,
                                           AEmpresaPix: String): TUniClientDataSet;

  Procedure BaixaAutomaticaAgendamentosEmAberto(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel : String);
  procedure FreeAndNilQuery(Out AQuery: TUniQuery);

  function ExisteAlgumaCobrancaComQRCodePix: Boolean;

  procedure pAtualizaDespesaCobranca(strAutoInc :String; fltNovoDespCob: Double);

  function fDeletaCadRec(strAutInc, strNomFrm: String; ADescricao: String = ''): Boolean;
  procedure pGravaDelCadRec(strAutInc, strNomFrm: String);
  function GetIncrementosCadRec(const strNumDup, strEspDoc, strCodEmp, strCodCli : String): TStringList;

  function DuplicataCreditoReferenteATroco(ANumeroDuplicata,
                                           AParcela,
                                           AEspecieDocumento,
                                           ACodigoEmpresa,
                                           ACodigoCliente: String;
                                           ASeqConBaixa: Integer): Boolean;

  function UtilizaContabilidadeERecebidoPorAdiantamento(out APedidoAdiantantamento: String;
                                                        ANumeroDuplicata,
                                                        AEspecieDuplicata,
                                                        AEmpresaDuplicata,
                                                        AClienteDuplicata: String;
                                                        AParcelaDuplicata: String = '';
                                                        ASequencialBaixa: Integer = -1): Boolean;
  procedure pAtualizarSequencialMovBanInclusaoCredito(const strAutIncCadRec : String; const strSeqLanMovBan : String);

  Var
    strLogCtrNosNum,
    strLogCtrCodCar,
    strLogCtrCodBco,
    linhaDigitavel:String;
    FRecEspeciesCC: array of TEspeciesGerCC;


implementation

uses
{$IFDEF LINUX}
{$ELSE}
  untModulo, untFuncAutban, untFuncoes, Forms,
{$ENDIF}
  untValidacoesSistemaDEPS, SysUtils, Variants, StrUtils, untConstantes,
  System.NetEncoding, Soap.EncdDecd, IdCoderMIME;

function GetIncrementosCadRec(const strNumDup, strEspDoc, strCodEmp, strCodCli : String): TStringList;
  Var
    LConsulta: TUniQuery;
Begin
  LConsulta := fCriaQuery;
  Try
    Result := TStringList.Create;
    LConsulta.SQL.Add(' SELECT AUTOINCREM ');
    LConsulta.SQL.Add('   FROM CADREC ');
    LConsulta.SQL.Add('  WHERE CTR_NUMDUP  = :NUMDOC  ');
    LConsulta.SQL.Add('    AND CTR_ESPDOC  = :ESPDOC ');
    LConsulta.SQL.Add('    AND CTR_CODEMP  = :CODEMP ');
    LConsulta.SQL.Add('    AND CTR_CODCLI  = :CODCLI ');
    LConsulta.SQL.Add('  ORDER BY CTR_NUMDUP, CTR_PARCEL ');
    LConsulta.ParamByName('NUMDOC').AsString := strNumDup;
    LConsulta.ParamByName('ESPDOC').AsString := strEspDoc;
    LConsulta.ParamByName('CODEMP').AsString := strCodEmp;
    LConsulta.ParamByName('CODCLI').AsString := strCodCli;
    LConsulta.Open;
    LConsulta.First;
    While Not LConsulta.Eof Do
    Begin
      Result.Add(LConsulta.FieldByName('AUTOINCREM').AsString);
      LConsulta.Next;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
End;


function fValidaExclusaoBoletoAdiantamento(strNumDup, strEspDoc, strCodEmp, strCodCli: String): Boolean;
var
  qryQtdDup : TUniQuery;
  strParcEnv, strParcRec : String;
begin
  Result := True;

  qryQtdDup :=  fCriaQuery(nil);
  try
    qryQtdDup.SQL.Add('SELECT * FROM CADREC');
    qryQtdDup.SQL.Add('WHERE CTR_NUMDUP = :NUMDUP');
    qryQtdDup.SQL.Add('  AND CTR_ESPDOC = :ESPDOC');
    qryQtdDup.SQL.Add('  AND CTR_CODEMP = :CODEMP');
    qryQtdDup.SQL.Add('  AND CTR_CODCLI = :CODCLI');
    qryQtdDup.SQL.Add('ORDER BY CTR_PARCEL');
    qryQtdDup.ParamByname('NUMDUP').AsString := strNumDup;
    qryQtdDup.ParamByname('ESPDOC').AsString := strEspDoc;
    qryQtdDup.ParamByname('CODEMP').AsString := strCodEmp;
    qryQtdDup.ParamByname('CODCLI').AsString := strCodCli;
    qryQtdDup.Open;

    if qryQtdDup.RecordCount > 1 then
    begin
      if not fPergunta('O pedido selecionado possui mais de uma parcela de boleto de adiantamento para o pedido. Ao continuar, '+
                       'todas as parcelas serão excluídas.'+ sLineBreak +'Deseja realmente continuar com a exclusão?') then
        Exit(False);
    end;

    strParcEnv := '';
    strParcRec := '';

    qryQtdDup.First;
    while not qryQtdDup.Eof do
    begin
      if not qryQtdDup.FieldByName('CTR_DTAENV').IsNull then
        strParcEnv := strParcEnv + qryQtdDup.FieldByName('CTR_PARCEL').AsString +', ';

      if not qryQtdDup.FieldByName('CTR_DTAREC').IsNull then
        strParcRec := strParcRec + qryQtdDup.FieldByName('CTR_PARCEL').AsString +', ';

      qryQtdDup.Next;
    end;

    if not fEmptyStr(strParcEnv) then
    begin
      strParcEnv := Copy(strParcEnv, 1, Length(strParcEnv) -2);

      pMensagemOk('Não será possível excluir as parcelas do boleto de adiantamento do pedido selecionado '+
                  'pois as parcelas listadas abaixo já foram enviadas ao banco: '+ sLineBreak +
                  'Parcela(s): '+ strParcEnv + sLineBreak +
                  'Faça o cancelamento da remessa no autban e comunique ao banco antes de excluir! Depois, refaça o processo.');
      Exit(False);
    end;

    if not fEmptyStr(strParcRec) then
    begin
      strParcRec := Copy(strParcRec, 1, Length(strParcRec) -2);

      pMensagemOk('Não será possível excluir as parcelas do boleto de adiantamento do pedido selecionado '+
                  'pois as parcelas listadas abaixo já foram recebidas: '+ sLineBreak +
                  'Parcela(s): '+ strParcRec + sLineBreak +
                  'Faça o estorno do recebimento se possível e depois, refaça o processo.');
      Exit(False);
    end;
  finally
    FreeAndNil(qryQtdDup);
  end;
end;

procedure pSetaEmp_PD(qryTabCadRec: TUniQuery; strEmp_PD, strCodVen, strCodEmp: String);
begin
  If (fCfgSis('GEMPPD', varString) = '1') Then
  Begin
    If fEmptyStr(strEmp_Pd) Then
      qryTabCadRec.ParamByName('EMP_PD').AsString := strCodEmp
    Else
      qryTabCadRec.ParamByName('EMP_PD').AsString := strEmp_Pd;
  End
  Else
  Begin
    qryTabCadRec.ParamByName('EMP_PD').AsString := fRetEmpresaOperador(strCodVen);

    If (fEmptyStr(qryTabCadRec.ParamByName('EMP_PD').AsString)) Then
      qryTabCadRec.ParamByName('EMP_PD').AsString := strCodEmp;
  End;
end;

function fAcertaRateio(cdsRateio: TUniClientDataSet; fltCredGer: Double = 0; blnCreMai: Boolean = False): Boolean;
  Var
    fltDin: Double;
    fltCqV: Double;
    fltCqP: Double;
    fltCar: Double;
    fltOrd: Double;
    fltFin: Double;
    qryRec: TUniQuery;

    intCont  : Integer;
    intIdxUltimaPositiva: Integer;
    fltTotGer: Double;
    fltTotCre: Double;
    arrModal : Array Of TModal;
    fltSldDin: Double;
    fltSldChV: Double;
    fltSldChP: Double;
    fltSldCar: Double;
    fltSldOrd: Double;
    fltSldFin: Double;
    fltAjuDin: Double;
    fltAjuChV: Double;
    fltAjuChP: Double;
    fltAjuCar: Double;
    fltAjuOrd: Double;
    fltAjuFin: Double;

  procedure pSomaModals;
  Begin
    arrModal[intCont].fltTot := arrModal[intCont].fltDin + arrModal[intCont].fltCqV +
                                arrModal[intCont].fltCqP + arrModal[intCont].fltCar +
                                arrModal[intCont].fltOrd + arrModal[intCont].fltFin;
  End;

  {**********************************************************}
  {* Define qual a melhor modalidade para se fazer o ajuste *}
  {*******************************************************RS*}
  function fModalidadeAjustar(fltValDif: Double): Integer;
  var
    fltMenorAjuste: Double;
  Begin
    Result := -1;
    fltMenorAjuste := 0;

    If (fltSldDin <> 0) Then
    Begin
      Result := 0;
      fltMenorAjuste := Abs(fltAjuDin + fltValDif);
    End;

    If (fltSldChV <> 0) And ((Result = -1) Or (Abs(fltAjuChV + fltValDif) < fltMenorAjuste)) Then
    Begin
      Result := 1;
      fltMenorAjuste := Abs(fltAjuChV + fltValDif);
    End;

    If (fltSldChP <> 0) And ((Result = -1) Or (Abs(fltAjuChP + fltValDif) < fltMenorAjuste)) Then
    Begin
      Result := 2;
      fltMenorAjuste := Abs(fltAjuChP + fltValDif);
    End;

    If (fltSldCar <> 0) And ((Result = -1) Or (Abs(fltAjuCar + fltValDif) < fltMenorAjuste)) Then
    Begin
      Result := 3;
      fltMenorAjuste := Abs(fltAjuCar + fltValDif);
    End;

    If (fltSldOrd <> 0) And ((Result = -1) Or (Abs(fltAjuOrd + fltValDif) < fltMenorAjuste)) Then
    Begin
      Result := 4;
      fltMenorAjuste := Abs(fltAjuOrd + fltValDif);
    End;

    If (fltSldFin <> 0) And ((Result = -1) Or (Abs(fltAjuFin + fltValDif) < fltMenorAjuste)) Then
      Result := 5;
  End;

begin
  If (cdsRateio.IsEmpty) Then
  Begin
    Result  := True;

    Exit;
  end;

  SetLength(arrModal, cdsRateio.RecordCount);

  Try
    {******************************}
    {* CALCULA TOTAL SEM CREDITOS *}
    {***************************AF*}
    fltTotGer := 0;
    fltTotCre := 0;
    cdsRateio.First;
    While Not cdsRateio.Eof Do
    Begin
      If cdsRateio.FieldByName('VALREC').AsFloat > 0 Then
        fltTotGer := fltTotGer + Abs(cdsRateio.FieldByName('VALREC').AsFloat)
      Else
        fltTotCre := fltTotCre + Abs(cdsRateio.FieldByName('VALREC').AsFloat);

      cdsRateio.Next;
    End;

    If fltTotGer <= fltTotCre Then
      fltTotCre := 0;

    intCont := 0;
    fltDin  := 0;
    fltCqV  := 0;
    fltCqP  := 0;
    fltCar  := 0;
    fltOrd  := 0;
    fltFin  := 0;

    {*************************************}
    {* INICIA O SALDO EM CADA MODALIDADE *}
    {**********************************RS*}
    fltSldDin := fFormataFloat(cdsRateio.FieldByName('DINHEI').AsFloat, 2);
    fltSldChV := fFormataFloat(cdsRateio.FieldByName('CHQAVI').AsFloat, 2);
    fltSldChP := fFormataFloat(cdsRateio.FieldByName('CHQPRE').AsFloat, 2);
    fltSldCar := fFormataFloat(cdsRateio.FieldByName('CARTAO').AsFloat, 2);
    fltSldOrd := fFormataFloat(cdsRateio.FieldByName('ORDPAG').AsFloat, 2);
    fltSldFin := fFormataFloat(cdsRateio.FieldByName('VALFIN').AsFloat, 2);

    fltAjuDin := 0;
    fltAjuChV := 0;
    fltAjuChP := 0;
    fltAjuCar := 0;
    fltAjuOrd := 0;
    fltAjuFin := 0;

    intIdxUltimaPositiva := 0;
    cdsRateio.First;
    While Not cdsRateio.Eof Do
    Begin
      arrModal[intCont].fltDin := 0;
      arrModal[intCont].fltCqV := 0;
      arrModal[intCont].fltCqP := 0;
      arrModal[intCont].fltCar := 0;
      arrModal[intCont].fltOrd := 0;
      arrModal[intCont].fltFin := 0;

      If cdsRateio.FieldByName('VALREC').AsFloat < 0 Then
        arrModal[intCont].fltDin := cdsRateio.FieldByName('VALREC').AsFloat
      Else
      Begin
        arrModal[intCont].fltDin := fRateioRec(fltTotGer, cdsRateio.FieldByName('VALREC').AsFloat, cdsRateio.FieldByName('DINHEI').AsFloat);
        arrModal[intCont].fltCqV := fRateioRec(fltTotGer, cdsRateio.FieldByName('VALREC').AsFloat, cdsRateio.FieldByName('CHQAVI').AsFloat);
        arrModal[intCont].fltCqP := fRateioRec(fltTotGer, cdsRateio.FieldByName('VALREC').AsFloat, cdsRateio.FieldByName('CHQPRE').AsFloat);
        arrModal[intCont].fltCar := fRateioRec(fltTotGer, cdsRateio.FieldByName('VALREC').AsFloat, cdsRateio.FieldByName('CARTAO').AsFloat);
        arrModal[intCont].fltOrd := fRateioRec(fltTotGer, cdsRateio.FieldByName('VALREC').AsFloat, cdsRateio.FieldByName('ORDPAG').AsFloat);
        arrModal[intCont].fltFin := fRateioRec(fltTotGer, cdsRateio.FieldByName('VALREC').AsFloat, cdsRateio.FieldByName('VALFIN').AsFloat);
        arrModal[intCont].fltRec := cdsRateio.FieldByName('VALREC').AsFloat;

        arrModal[intCont].fltDin := arrModal[intCont].fltDin + fRateioRec(fltTotGer, cdsRateio.FieldByName('VALREC').AsFloat, fltTotCre);

        If fFormataFloat(fltCredGer,2) <> 0 Then
          arrModal[intCont].fltDin := arrModal[intCont].fltDin + fRateioRec(fltTotGer, cdsRateio.FieldByName('VALREC').AsFloat, fltCredGer);

        fltDin := fltDin + arrModal[intCont].fltDin;
        fltCqV := fltCqV + arrModal[intCont].fltCqV;
        fltCqP := fltCqP + arrModal[intCont].fltCqP;
        fltCar := fltCar + arrModal[intCont].fltCar;
        fltOrd := fltOrd + arrModal[intCont].fltOrd;
        fltFin := fltFin + arrModal[intCont].fltFin;

        intIdxUltimaPositiva := intCont;
      End;

      pSomaModals;
      arrModal[intCont].fltDif := fFormataFloat(cdsRateio.FieldByName('VALREC').AsFloat - arrModal[intCont].fltTot, 2);

      Inc(intCont);
      cdsRateio.Next;
    End;

    For intCont := 0 to Length(arrModal) - 1 Do
    Begin
      If (intCont <> intIdxUltimaPositiva) Then
      Begin
        {***********************************************************}
        {* AJUSTA TODAS AS DUPLICATAS QUE TIVEREM INCONSISTÊNCIAS, *}
        {* EXCETO A ÚLTIMA POSITIVA                                *}
        {********************************************************RS*}
        If (arrModal[intCont].fltDif <> 0) Then
        Begin
          If arrModal[intCont].fltDin < 0 then
          Begin
            arrModal[intCont].fltDin := arrModal[intCont].fltDin + arrModal[intCont].fltDif;
            fltAjuDin := fltAjuDin + arrModal[intCont].fltDif;
          End
          Else
          Begin
            Case fModalidadeAjustar(arrModal[intCont].fltDif) Of
              0: Begin
                   arrModal[intCont].fltDin := arrModal[intCont].fltDin + arrModal[intCont].fltDif;
                   fltAjuDin := fltAjuDin + arrModal[intCont].fltDif;
                 End;
              1: Begin
                   arrModal[intCont].fltCqV := arrModal[intCont].fltCqV + arrModal[intCont].fltDif;
                   fltAjuChV := fltAjuChV + arrModal[intCont].fltDif;
                 End;
              2: Begin
                   arrModal[intCont].fltCqP := arrModal[intCont].fltCqP + arrModal[intCont].fltDif;
                   fltAjuChP := fltAjuChP + arrModal[intCont].fltDif;
                 End;
              3: Begin
                   arrModal[intCont].fltCar := arrModal[intCont].fltCar + arrModal[intCont].fltDif;
                   fltAjuCar := fltAjuCar + arrModal[intCont].fltDif;
                 End;
              4: Begin
                   arrModal[intCont].fltOrd := arrModal[intCont].fltOrd + arrModal[intCont].fltDif;
                   fltAjuOrd := fltAjuOrd + arrModal[intCont].fltDif;
                 End;
              5: Begin
                   arrModal[intCont].fltFin := arrModal[intCont].fltFin + arrModal[intCont].fltDif;
                   fltAjuFin := fltAjuFin + arrModal[intCont].fltDif;
                 End;
            End;
          End;
        End;
        If blnCreMai Then
          fltSldDin := fltSldDin - IIF(arrModal[intCont].fltDin < 0, (arrModal[intCont].fltDin * -1), arrModal[intCont].fltDin)
        Else
          fltSldDin := fltSldDin - arrModal[intCont].fltDin;
        fltSldChV := fltSldChV - arrModal[intCont].fltCqV;
        fltSldChP := fltSldChP - arrModal[intCont].fltCqP;
        fltSldCar := fltSldCar - arrModal[intCont].fltCar;
        fltSldOrd := fltSldOrd - arrModal[intCont].fltOrd;
        fltSldFin := fltSldFin - arrModal[intCont].fltFin;
      End;
    End;

    {**************************************************}
    {* AJUSTA A ÚLTIMA DUPLICATA POSITIVA COM O SALDO *}
    {* RESTANTE EM CADA MODALIDADE                    *}
    {***********************************************RS*}
    If fltSldDin <> 0 Then
      arrModal[intIdxUltimaPositiva].fltDin := fltSldDin;
    arrModal[intIdxUltimaPositiva].fltCqV := fltSldChV;
    arrModal[intIdxUltimaPositiva].fltCqP := fltSldChP;
    arrModal[intIdxUltimaPositiva].fltCar := fltSldCar;
    arrModal[intIdxUltimaPositiva].fltOrd := fltSldOrd;
    arrModal[intIdxUltimaPositiva].fltFin := fltSldFin;

    If blnCreMai Then
    Begin
      If arrModal[intIdxUltimaPositiva].fltRec <> (arrModal[intIdxUltimaPositiva].fltDin +
      arrModal[intIdxUltimaPositiva].fltCqV +
      arrModal[intIdxUltimaPositiva].fltCqP +
      arrModal[intIdxUltimaPositiva].fltCar +
      arrModal[intIdxUltimaPositiva].fltOrd +
      arrModal[intIdxUltimaPositiva].fltFin) Then
        arrModal[intIdxUltimaPositiva].fltDin := arrModal[intIdxUltimaPositiva].fltRec - (
                                                 arrModal[intIdxUltimaPositiva].fltCqV +
                                                 arrModal[intIdxUltimaPositiva].fltCqP +
                                                 arrModal[intIdxUltimaPositiva].fltCar +
                                                 arrModal[intIdxUltimaPositiva].fltOrd +
                                                 arrModal[intIdxUltimaPositiva].fltFin);
    End;

    intCont := 0;
    cdsRateio.First;
    While Not cdsRateio.Eof Do
    Begin
      qryRec := fCriaQuery;

      qryRec.Close;
      qryRec.SQL.Text := '';
      qryRec.SQL.Text := 'UPDATE CADREC '
                        + 'SET '
                        + '  CTR_DINHEI = :DINHEI, '
                        + '  CTR_CHQAVI = :CHQAVI, '
                        + '  CTR_CHQPRE = :CHQPRE, '
                        + '  CTR_CARTAO = :CARTAO, '
                        + '  CTR_ORDPAG = :ORDPAG, '
                        + '  CTR_VALFIN = :VALFIN  '
                        + 'WHERE '
                        + '  CTR_NUMDUP = :NUMDUP AND '
                        + '  CTR_ESPDOC = :ESPDOC AND '
                        + '  CTR_CODEMP = :CODEMP AND '
                        + '  CTR_CODCLI = :CODCLI AND '
                        + '  CTR_PARCEL = :PARCEL AND '
                        + '  CTR_SEQBAI = :SEQBAI ';

      qryRec.ParamByName('DINHEI').AsFloat   := arrModal[intCont].fltDin;
      qryRec.ParamByName('CHQAVI').AsFloat   := arrModal[intCont].fltCqV;
      qryRec.ParamByName('CHQPRE').AsFloat   := arrModal[intCont].fltCqP;
      qryRec.ParamByName('CARTAO').AsFloat   := arrModal[intCont].fltCar;
      qryRec.ParamByName('ORDPAG').AsFloat   := arrModal[intCont].fltOrd;
      qryRec.ParamByName('VALFIN').AsFloat   := arrModal[intCont].fltFin;
      qryRec.ParamByName('NUMDUP').AsString  := cdsRateio.FieldByName('NUMDUP').AsString;
      qryRec.ParamByName('ESPDOC').AsString  := cdsRateio.FieldByName('ESPDOC').AsString;
      qryRec.ParamByName('CODEMP').AsString  := cdsRateio.FieldByName('CODEMP').AsString;
      qryRec.ParamByName('CODCLI').AsString  := cdsRateio.FieldByName('CODCLI').AsString;
      qryRec.ParamByName('PARCEL').AsString  := cdsRateio.FieldByName('PARCEL').AsString;
      qryRec.ParamByName('SEQBAI').AsInteger := cdsRateio.FieldByName('SEQBAI').AsInteger;
      qryRec.ExecSQL;

      Inc(intCont);
      FreeAndNil(qryRec);
      cdsRateio.Next;
    End;

    cdsRateio.EmptyDataSet;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

{******************************************************}
{* FUNCAO QUE APAGA DUPLICATAS DO CADREC              *}
{* OBS: JA GRAVA NAS TABELAS LOGCTR E DEL_CADREC      *}
{***************************************************JS*}
function fApagaDuplicataContasReceber(qryTabCadRec: TUniQuery;
                                      strNomeFormulario: String;
                                      strDescri: String = '';
                                      blnGravaSistemaDEPS: Boolean = True;
                                      ARaiseException: Boolean = False): Boolean;
  Var
    strSQL: String;
    blnCommit: Boolean;
    qryRemDet    : TUniQuery;
    qryRetDet    : TUniQuery;
    LDuplicataBoleto: TDuplicataCtr;
Begin
  Try
    {*************************************************}
    {*  CASO NAO ESTEJA EM TRANSACAO INICIA UMA NOVA *}
    {**********************************************JC*}
    blnCommit := (Not fInTransaction);

    If blnCommit Then
      fStartTransaction;

    qryRemDet := fCriarQuery('SELECT * FROM REMDET WHERE DET_DUPLIC = ' +
      qryTabCadRec.FieldByName('AUTOINCREM').AsString.QuotedString);

    Try
      qryRemDet.Open;
      While Not qryRemDet.IsEmpty Do
      Begin
        GravaTabelaDelecao(strNomeFormulario, 'REMDET', qryRemDet);
        qryRemDet.Delete;
      End;
    Finally
      FreeAndNil(qryRemDet);
    End;

    qryRetDet := fCriarQuery('SELECT * FROM RETDET WHERE DET_DUPLIC = ' +
      qryTabCadRec.FieldByName('AUTOINCREM').AsString.QuotedString);

    Try
      qryRetDet.Open;
      While Not qryRetDet.IsEmpty Do
      Begin
        GravaTabelaDelecao(strNomeFormulario, 'RETDET', qryRetDet);
        qryRetDet.Delete;
      End;
    Finally
      FreeAndNil(qryRetDet);
    End;

    With qryTabCadRec Do
    Begin
      {******************************************}
      {* FORÇA NULO NO CAMPO NOMFRM PRA GRAVAR  *}
      {* O NOME DO FORMULÁRIO NA TAB DEL_CADREC *}
      {***************************************JS*}
      qryTabCadRec.Edit;
      qryTabCadRec.FieldByName('CTR_NOMFRM').Value := Null;
      qryTabCadRec.Post;

      {**********************}
      {* GRAVA DEL_CADREC   *}
      {*******************JC*}
      GravaTabelaDelecao(strNomeFormulario, 'CADREC', qryTabCadRec);

      {****************}
      {* GRAVA LOGCTR *}
      {*************JS*}
      untLogCtr.GravaLogCtr(FieldByName('AUTOINCREM').AsString, IIF(fEmptyStr(strDescri), 'EXCLUSÃO DE DUPLICATA', strDescri), strNomeFormulario);

      {*********************************}
      {* GRAVAR TABELA DO SISTEMA DEPS *}
      {******************************AJ*}
      If (blnGravaSistemaDEPS) And
         (fCfgSis('USADEP') = 'S') Then
        TValidacoesSistemaDEPS.pGravaLancamentoSistemaDEPS(Concat(FieldByName('CTR_NUMDUP').AsString, '-',
                                                                  FieldByName('CTR_PARCEL').AsString, '-',
                                                                  FieldByName('CTR_ESPDOC').AsString, '-',
                                                                  FieldByName('CTR_CODEMP').AsString, '-',
                                                                  FieldByName('CTR_CODCLI').AsString, '-',
                                                                  FieldByName('CTR_SEQBAI').AsString),
                                                           'EXCLUSÃO');

      If fCfgSis('BADAUT', VarBoolean) Then
        Result := fExcluiValAdtPeloSeqCtr(qryTabCadRec.FieldByName('AUTOINCREM').AsString)
      Else
        Result := True;

      {********************}
      {* EXCLUI DUPLICATA *}
      {*****************JC*}
      strSQL := '';
      strSQL := strSQL + ' DELETE   ';
      strSQL := strSQL + ' FROM     ';
      strSQL := strSQL + '   CADREC ';
      strSQL := strSQL + ' WHERE    ';
      strSQL := strSQL + '   CTR_NUMDUP = ' + QuotedStr(FieldByName('CTR_NUMDUP').AsString) + ' AND ';
      strSQL := strSQL + '   CTR_PARCEL = ' + QuotedStr(FieldByName('CTR_PARCEL').AsString) + ' AND ';
      strSQL := strSQL + '   CTR_ESPDOC = ' + QuotedStr(FieldByName('CTR_ESPDOC').AsString) + ' AND ';
      strSQL := strSQL + '   CTR_CODEMP = ' + QuotedStr(FieldByName('CTR_CODEMP').AsString) + ' AND ';
      strSQL := strSQL + '   CTR_CODCLI = ' + QuotedStr(FieldByName('CTR_CODCLI').AsString) + ' AND ';
      strSQL := strSQL + '   CTR_SEQBAI = ' +           FieldByName('CTR_SEQBAI').AsString  + '     ';

      Result := Result And fExecutaSQL(strSQL, ARaiseException);

      If Result Then
      Begin
        If qryTabCadRec.FieldByName('CTR_SEQBAI').AsInteger = 0 Then
        begin
          LDuplicataBoleto.strNumDup := qryTabCadRec.FieldByName('CTR_NUMDUP').AsString;
          LDuplicataBoleto.strParcel := qryTabCadRec.FieldByName('CTR_PARCEL').AsString;
          LDuplicataBoleto.strEspDoc := qryTabCadRec.FieldByName('CTR_ESPDOC').AsString;
          LDuplicataBoleto.strCodEmp := qryTabCadRec.FieldByName('CTR_CODEMP').AsString;
          LDuplicataBoleto.strCodCli := qryTabCadRec.FieldByName('CTR_CODCLI').AsString;
          DeletarCarteiraBoleto(LDuplicataBoleto);
        End;
      End;

      {**********************************************}
      {* CASO CRIOU UMA NOVA TRANSACAO ENTAO COMITA *}
      {*******************************************JC*}
      If blnCommit and Result Then
        fCommit;
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Raise Exception.Create('[fApagaDuplicataContasReceber] - ' + E.Message);
    End;
  End;

end;


function fApagaDuplicataContasReceber(cdsTabCadRec: TUniClientDataSet;
                                      strNomeFormulario: String;
                                      strDescri: String = '';
                                      blnGravaSistemaDEPS: Boolean = True;
                                      ARaiseException: Boolean = False): Boolean;
  Var
    strSQL: String;
    blnCommit: Boolean;
    qryRemDet    : TUniQuery;
    qryRetDet    : TUniQuery;
Begin
  Try
    {*************************************************}
    {*  CASO NAO ESTEJA EM TRANSACAO INICIA UMA NOVA *}
    {**********************************************JC*}
    blnCommit := (Not fInTransaction);

    If blnCommit Then
      fStartTransaction;

    qryRemDet := fCriarQuery('SELECT * FROM REMDET WHERE DET_DUPLIC = ' +
      cdsTabCadRec.FieldByName('AUTOINCREM').AsString.QuotedString);

    Try
      qryRemDet.Open;
      While Not qryRemDet.IsEmpty Do
      Begin
        GravaTabelaDelecao(strNomeFormulario, 'REMDET', qryRemDet);
        qryRemDet.Delete;
      End;
    Finally
      FreeAndNil(qryRemDet);
    End;

    qryRetDet := fCriarQuery('SELECT * FROM RETDET WHERE DET_DUPLIC = ' +
      cdsTabCadRec.FieldByName('AUTOINCREM').AsString.QuotedString);

    Try
      qryRetDet.Open;
      While Not qryRetDet.IsEmpty Do
      Begin
        GravaTabelaDelecao(strNomeFormulario, 'RETDET', qryRetDet);
        qryRetDet.Delete;
      End;
    Finally
      FreeAndNil(qryRetDet);
    End;

    With cdsTabCadRec Do
    Begin
      {**********************}
      {* GRAVA DEL_CADREC   *}
      {*******************JC*}
      pGravaDelCadRec(cdsTabCadRec.FieldByName('AUTOINCREM').AsString, strNomeFormulario);

      {****************}
      {* GRAVA LOGCTR *}
      {*************JS*}
      untLogCtr.GravaLogCtr(FieldByName('AUTOINCREM').AsString, IIF(fEmptyStr(strDescri), 'EXCLUSÃO DE DUPLICATA', strDescri), strNomeFormulario);

      {*********************************}
      {* GRAVAR TABELA DO SISTEMA DEPS *}
      {******************************AJ*}
      If (blnGravaSistemaDEPS) And
         (fCfgSis('USADEP') = 'S') Then
        TValidacoesSistemaDEPS.pGravaLancamentoSistemaDEPS(Concat(FieldByName('NRODUP').AsString, '-',
                                                                  FieldByName('PARDUP').AsString, '-',
                                                                  FieldByName('CTR_ESPDOC').AsString, '-',
                                                                  FieldByName('CTR_CODEMP').AsString, '-',
                                                                  FieldByName('CTR_CODCLI').AsString, '-',
                                                                  FieldByName('CTR_SEQBAI').AsString),
                                                           'EXCLUSÃO');

      {********************}
      {* EXCLUI DUPLICATA *}
      {*****************JC*}
      strSQL := '';
      strSQL := strSQL + ' DELETE   ';
      strSQL := strSQL + ' FROM     ';
      strSQL := strSQL + '   CADREC ';
      strSQL := strSQL + ' WHERE    ';
      strSQL := strSQL + '   CTR_NUMDUP = ' + QuotedStr(FieldByName('NRODUP').AsString) + ' AND ';
      strSQL := strSQL + '   CTR_PARCEL = ' + QuotedStr(FieldByName('PARDUP').AsString) + ' AND ';
      strSQL := strSQL + '   CTR_ESPDOC = ' + QuotedStr(FieldByName('CTR_ESPDOC').AsString) + ' AND ';
      strSQL := strSQL + '   CTR_CODEMP = ' + QuotedStr(FieldByName('CTR_CODEMP').AsString) + ' AND ';
      strSQL := strSQL + '   CTR_CODCLI = ' + QuotedStr(FieldByName('CTR_CODCLI').AsString) + ' AND ';
      strSQL := strSQL + '   CTR_SEQBAI = ' +           FieldByName('CTR_SEQBAI').AsString  + '     ';

      Result := fExecutaSQL(strSQL, ARaiseException);

      {**********************************************}
      {* CASO CRIOU UMA NOVA TRANSACAO ENTAO COMITA *}
      {*******************************************JC*}
      If blnCommit and Result Then
        fCommit;
    End;

  Except
    On E: Exception Do
    Begin
      fRollBack;
      Raise Exception.Create('[fApagaDuplicataContasReceber] - ' + E.Message);
    End;
  End;

end;


function fRateioRec(fltTotGer, fltTotDup, fltValRec: Double): Double;
begin
  If (fltValRec = 0) Then
    Result := 0
  Else
    Result := fFormataFloat((fltTotDup / fltTotGer) * fltValRec, 2);
end;

function fRetSeqBaiCadRec(strNumDup,
                          strParcel,
                          strCodEmp,
                          strEspDoc,
                          strCodCli: String): Integer;
  Var
    strSQL   : String;
    qryGenRec: TUniQuery;

begin
  Try

    qryGenRec := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  MAX(CTR_SEQBAI) AS QTD ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';

    With qryGenRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODCLI').AsString := strCodCli;
      Open;
      Result := FieldByName('QTD').AsInteger;
      Close;
    End;

  Finally
    FreeAndNil(qryGenRec);
  End;

end;

function fGravaHistoricoParcelamento(strNumDup, strEspDoc, strCodEmp, strCodCli, strInfPar: String): Boolean;
  Var
    qryHisPar: TUniQuery;
begin
  strInfPar := AnsiReplaceStr(strInfPar, STRING_ENTER, STRING_QUEBRA);

  Try
    qryHisPar := fCriaQuery;
    qryHisPar.Sql.Text := 'SELECT * FROM HISPAR WHERE FALSE ';
    qryHisPar.Open;

    qryHisPar.Append;
    qryHisPar.FieldByName('HIS_NUMDUP').AsString := strNumDup;
    qryHisPar.FieldByName('HIS_ESPDOC').AsString := strEspDoc;
    qryHisPar.FieldByName('HIS_CODEMP').AsString := strCodEmp;
    qryHisPar.FieldByName('HIS_CODCLI').AsString := strCodCli;
    qryHisPar.FieldByName('HIS_INFPAR').AsString := strInfPar;
    qryHisPar.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('HISPAR', VS_strCodEmp);
    qryHisPar.Post;

    Result := True;
  Finally
    FreeAndNil(qryHisPar);
  End;

end;


procedure GeraListaDeCamposCADREC();
  Var
    LConsulta: TUniQuery;

    LCampo: TField;
Begin
  If Not FCamposNovoCadrec.IsEmpty Then
    Exit;

  Try
    LConsulta := fCriaQuery();
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Add('SELECT * FROM CADREC WHERE FALSE');
    LConsulta.Open;

    FCamposNovoCadrec := '';
    FParametrosNovoCadrec := '';
    FCamposCadRec := '';

    For LCampo In LConsulta.Fields Do
    Begin
      FCamposNovoCadrec := FCamposNovoCadrec + LCampo.FieldName + ',';
      FParametrosNovoCadrec := FParametrosNovoCadrec + ':' + LCampo.FieldName + ',';

      FCamposCadRec := FCamposCadRec + LCampo.FieldName + ',';
    End;

    FCamposNovoCadrec := LeftStr(FCamposNovoCadrec, FCamposNovoCadrec.Length - 1);
    FParametrosNovoCadrec := LeftStr(FParametrosNovoCadrec, FParametrosNovoCadrec.Length - 1);

    FCamposCadRec := LeftStr(FCamposCadRec, FCamposCadRec.Length - 1);
  Finally
    FreeAndNil(LConsulta);
  End;
End;

Function VerificaSeTemVariasEspeciesRecbto(AAutoIncrem: String) : Boolean;
  Var
    i,
    iqtdeEsp : integer;
    LAux : TUniQuery;
Begin

  result := False;
  iqtdeEsp := 0;

  Try
    LAux := fCriaQuery();

    LAux.SQL.Text := 'SELECT ' + FCamposCadRec + ' FROM CADREC WHERE AUTOINCREM="' + AAutoIncrem + '"';
    LAux.Open;

    For i := 0 To Length(FArrEspRecebidas) - 1 Do
    Begin

       If LAux.FieldByName(FArrEspRecebidas[i]).Asfloat > 0 Then
          iqtdeEsp := iqtdeEsp + 1;

    End;

    If iqtdeEsp > 1 Then
       Result := True;

    FreeAndNil(LAux);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;

End;

function DesmembraDuplicatasPorEspecie(AAutoIncrem: String; APortadorTF : String = ''; fltValCreArm: Double = 0; fltTotPgto : Double = 0; const APortadorAdtCredito : String = ''; const AValorAdtCredito : Double = 0) : TStringArray;
  Var
    LConsulta,
    LUpdate,
    LGravarNovoReg,
    LAux : TUniQuery;

    LCampo: TField;
    iCont, iSeqBai, iSeqBaiParcial : Integer;

    fltRestArredJuros,
    fltRestArredDescto : Double;

    fltJurosDupInicial,
    fltDesctoDupInicial,
    fltJurosSujDupInicial,
    fltDesctoSujDupInicial,
    fltTotalDupInicial : Double;

    fltValOriCalc,
    fltValRecCalc,
    fltPercJurosDup,
    fltPercDesctoDup,
    fltPercJurosSujDup,
    fltPercDesctoSujDup,
    fltdifJur,
    fltdifDes,
    fltUltimoValOriCalc : Double;

    sUltAutoIncrem : String;
    blnParcial : Boolean;

    fltPercDuplicata : double; //percentual da duplicata referente ao pagamento;
    fltPercCredDup : double;   //percentual de credito referente a modalidade do pagamento;
    fltValorCreditoModalidade : double;
Begin
  SetLength(Result, 0);

  GeraListaDeCamposCADREC();

  If Not VerificaSeTemVariasEspeciesRecbto(AAutoIncrem) Then
     Exit;

  LConsulta := fCriaQuery();
  LGravarNovoReg := fCriaQuery();
  LUpdate := fCriaQuery();
  LAux    := fCriaQuery();
  blnParcial := False;
  iSeqBaiParcial:= 0;
  Try

    LConsulta.SQL.Text := 'SELECT ' + FCamposCadRec + ' FROM CADREC WHERE AUTOINCREM="' + AAutoIncrem + '"';
    LConsulta.Open;

    LUpdate.SQL.Text := 'SELECT ' + FCamposCadRec + ' FROM CADREC WHERE AUTOINCREM="' + AAutoIncrem + '"';
    LUpdate.Open;

    If Not LConsulta.IsEmpty Then
    Begin

      //Retorna o maior seqbai que estiver relacionado a esta duplicata no caso de ter sido feita uma baixa parcial;
      LAux.Close;
      LAux.SQL.Text := 'SELECT MAX(CTR_SEQBAI) AS CTR_SEQBAI  FROM CADREC '+
                       ' WHERE CTR_NUMDUP = ' + QuotedStr(LConsulta.FieldByName('CTR_NUMDUP').AsString) +
                       '   AND CTR_ESPDOC = ' + QuotedStr(LConsulta.FieldByName('CTR_ESPDOC').AsString) +
                       '   AND CTR_CODCLI = ' + LConsulta.FieldByName('CTR_CODCLI').AsString +
                       '   AND CTR_CODEMP = ' + LConsulta.FieldByName('CTR_CODEMP').AsString +
                       '   AND CTR_PARCEL = ' + QuotedStr(LConsulta.FieldByName('CTR_PARCEL').AsString);
      LAux.Open;

      If (LAux.FieldByName('CTR_SEQBAI').AsInteger > 0) Then
      Begin
         iSeqBaiParcial := LAux.FieldByName('CTR_SEQBAI').AsInteger;
         blnParcial := True;
      End;

      iseqbai := LConsulta.FieldByName('CTR_SEQBAI').AsInteger;
      fltJurosDupInicial  := LConsulta.FieldByName('CTR_VALJUR').AsFloat;
      fltDesctoDupInicial := LConsulta.FieldByName('CTR_VALDES').AsFloat;
      fltTotalDupInicial  := (LConsulta.FieldByName('CTR_VALORI').AsFloat + LConsulta.FieldByName('CTR_VALJUR').AsFloat)
                                                                          - LConsulta.FieldByName('CTR_VALDES').AsFloat
                                                                          + LConsulta.FieldByName('CTR_DESCOB').AsFloat;

      fltJurosSujDupInicial  := LConsulta.FieldByName('CTR_JURSUJ').AsFloat;
      fltDesctoSujDupInicial := LConsulta.FieldByName('CTR_DESSUJ').AsFloat;

      fltRestArredJuros   := 0;
      fltRestArredDescto  := 0;
      fltUltimoValOriCalc := 0;

      If fltValCreArm > 0 Then
      Begin
        fltPercDuplicata := (fltTotalDupInicial / (fltTotPgto - fltValCreArm)) * 100; //percentual da duplicata referente ao pagamento;
        fltPercCredDup   := ((fltPercDuplicata * fltValCreArm)/100);
      End;

      For iCont := 0 To Length(FArrEspRecebidas) - 1 Do
      Begin

         If LConsulta.FieldByName(FArrEspRecebidas[iCont]).Asfloat > 0 Then
         Begin
            // OBS: DIVIDIR JUROS E DESCONTO DE FORMA PROPORCIONAL.
            // 1 = ( 30,00 / 167,00 ) * 17,00 = 3,05
            // 2 = ( 40,00 / 167,00 ) * 17,00 = 4,07
            // 3 = ( 97,00 / 167,00 ) * 17,00 = 9,07 --> FAZER ARREDONDAMENTO NO ULTIMO SEQBAI GERADO, PARA BATER COM O VALOR EXATO.

            fltUltimoValOriCalc := 0;
            // Calcula juros proporcionalmente;
            fltPercJurosDup := 0;

            If fltJurosDupInicial > 0 Then
            Begin
               fltPercJurosDup   := fFormataFloat(((LConsulta.FieldByName(FArrEspRecebidas[iCont]).AsFloat / fltTotalDupInicial) * fltJurosDupInicial) ,2);
               fltRestArredJuros := fltRestArredJuros + fltPercJurosDup;
            End;

            fltValOriCalc := (LConsulta.FieldByName(FArrEspRecebidas[iCont]).AsFloat - fltPercJurosDup);

            // Calcula desconto proporcionalmente;
            fltPercDesctoDup := 0;
            If fltDesctoDupInicial > 0 Then
            Begin
               fltPercDesctoDup := fFormataFloat(((LConsulta.FieldByName(FArrEspRecebidas[iCont]).AsFloat / fltTotalDupInicial) * fltDesctoDupInicial) ,2);
               fltRestArredDescto := fltRestArredDescto + fltPercDesctoDup;
            End;

            fltValOriCalc := fltValOriCalc + fltPercDesctoDup;
            fltValRecCalc := LConsulta.FieldByName(FArrEspRecebidas[iCont]).AsFloat;

            // Calcula Juros/descontos sugeridos
            fltPercJurosSujDup  := 0;
            If fltJurosSujDupInicial > 0 Then
               fltPercJurosSujDup := fFormataFloat(((LConsulta.FieldByName(FArrEspRecebidas[iCont]).AsFloat / fltTotalDupInicial) * fltJurosSujDupInicial) ,2);

            fltPercDesctoSujDup := 0;
            If fltDesctoSujDupInicial > 0 Then
               fltPercDesctoSujDup := fFormataFloat(((LConsulta.FieldByName(FArrEspRecebidas[iCont]).AsFloat / fltTotalDupInicial) * fltDesctoSujDupInicial) ,2);

            //Calcula o percentual de credito para cada modalidade;
            fltValorCreditoModalidade := 0;

            If fltValCreArm > 0 Then
            Begin
              fltValorCreditoModalidade := ((fltValRecCalc / fltTotalDupInicial) * 100);
              fltValorCreditoModalidade := ((fltValorCreditoModalidade * fltPercCredDup)/100);
            End;

            If iseqbai = LUpdate.FieldByName('CTR_SEQBAI').AsInteger Then
            Begin
              LUpdate.Edit;
              LUpdate.FieldByName('CTR_DINHEI').AsFloat    := 0;
              LUpdate.FieldByName('CTR_CARTAO').AsFloat    := 0;
              LUpdate.FieldByName('CTR_CHQAVI').AsFloat    := 0;
              LUpdate.FieldByName('CTR_CHQPRE').AsFloat    := 0;
              LUpdate.FieldByName('CTR_CREDIT').AsFloat    := 0;
              LUpdate.FieldByName('CTR_ORDPAG').AsFloat    := 0;
             // LUpdate.FieldByName('CTR_JURANT').AsFloat    := fltJurosDupInicial;   // ALTERADO PARA ESTORNO
             // LUpdate.FieldByName('CTR_DESANT').AsFloat    := fltDesctoDupInicial;  // ALTERADO PARA ESTORNO
              LUpdate.FieldByName('CTR_VALANT').AsFloat    := fltTotalDupInicial; //LConsulta.FieldByName(FArrEspRecebidas[iCont]).AsFloat;
              LUpdate.FieldByName(FArrEspRecebidas[iCont]).AsFloat := LConsulta.FieldByName(FArrEspRecebidas[iCont]).AsFloat;
              LUpdate.FieldByName('CTR_VALORI').AsFloat    := fltValOriCalc;
              LUpdate.FieldByName('CTR_VALREC').AsFloat    := fltValRecCalc;
              LUpdate.FieldByName('CTR_VALDUP').AsFloat    := 0;
              LUpdate.FieldByName('CTR_VALJUR').AsFloat    := fltPercJurosDup;
              LUpdate.FieldByName('CTR_VALDES').AsFloat    := fltPercDesctoDup;
              LUpdate.FieldByName('CTR_JURSUJ').AsFloat    := fltPercJurosSujDup;
              LUpdate.FieldByName('CTR_DESSUJ').AsFloat    := fltPercDesctoSujDup;
              LUpdate.FieldByName('CTR_VLCRED').AsFloat    := IIF((fltValCreArm <> 0), -fltValorCreditoModalidade, 0);

              If FArrEspRecebidas[iCont] = 'CTR_ORDPAG' Then
              Begin
                 If Not FEmptyStr(APortadorTF) Then
                    LUpdate.FieldByName('CTR_PORBAI').AsString := APortadorTF;
              End;

              If (FArrEspRecebidas[iCont] = 'CTR_DINHEI') And
                 (fFormataFloat(AValorAdtCredito, 2) = fFormataFloat(LUpdate.FieldByName(FArrEspRecebidas[iCont]).AsFloat, 2)) Then
              Begin
                If Not fEmptyStr(APortadorAdtCredito) Then
                  LUpdate.FieldByName('CTR_PORBAI').AsString := APortadorAdtCredito;
              End;

              LUpdate.Post;

              If blnParcial Then
                 iseqbai := iSeqBaiParcial + 1
              Else
                 iseqbai := iseqbai + 1;

              Continue;
            End;

            LGravarNovoReg.SQL.Text := 'INSERT INTO CADREC (' + FCamposNovoCadrec + ') ' +
                                                  ' VALUES (' + FParametrosNovoCadrec + ') ';

            For LCampo In LConsulta.Fields Do
            Begin
              If MatchStr(LCampo.FieldName, FArrayCamposIgnorados) Then
                Continue;

              LGravarNovoReg.ParamByName(LCampo.FieldName).Value := LCampo.Value;
            End;

            LGravarNovoReg.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('CADREC', LConsulta.FieldByName('CTR_CODEMP').AsString);

            SetLength(Result, Length(Result) + 1);
            Result[Length(Result) - 1] := LGravarNovoReg.ParamByName('AUTOINCREM').AsString;

            LGravarNovoReg.ParamByName('CTR_DINHEI').AsFloat    := 0;
            LGravarNovoReg.ParamByName('CTR_CARTAO').AsFloat    := 0;
            LGravarNovoReg.ParamByName('CTR_CHQAVI').AsFloat    := 0;
            LGravarNovoReg.ParamByName('CTR_CHQPRE').AsFloat    := 0;
            LGravarNovoReg.ParamByName('CTR_CREDIT').AsFloat    := 0;
            LGravarNovoReg.ParamByName('CTR_ORDPAG').AsFloat    := 0;
            //LGravarNovoReg.ParamByName('CTR_JURANT').AsFloat    := fltJurosDupInicial;  // ALTERADO PARA ESTORNO
            //LGravarNovoReg.ParamByName('CTR_DESANT').AsFloat    := fltDesctoDupInicial; // ALTERADO PARA ESTORNO
            LGravarNovoReg.ParamByName('CTR_VALANT').AsFloat    := fltTotalDupInicial; //LConsulta.FieldByName(FArrEspRecebidas[iCont]).AsFloat;
            LGravarNovoReg.ParamByName(FArrEspRecebidas[iCont]).AsFloat := LConsulta.FieldByName(FArrEspRecebidas[iCont]).AsFloat;
            LGravarNovoReg.ParamByName('CTR_VALORI').AsFloat    := fltValOriCalc;
            LGravarNovoReg.ParamByName('CTR_VALREC').AsFloat    := fltValRecCalc;
            LGravarNovoReg.ParamByName('CTR_VALDUP').AsFloat    := 0;
            LGravarNovoReg.ParamByName('CTR_VALJUR').AsFloat    := fltPercJurosDup;
            LGravarNovoReg.ParamByName('CTR_VALDES').AsFloat    := fltPercDesctoDup;
            LGravarNovoReg.ParamByName('CTR_JURSUJ').AsFloat    := fltPercJurosSujDup;
            LGravarNovoReg.ParamByName('CTR_DESSUJ').AsFloat    := fltPercDesctoSujDup;
            LGravarNovoReg.ParamByName('CTR_SEQBAI').AsInteger  := iseqbai;
            LGravarNovoReg.ParamByName('CTR_VLCRED').AsFloat    := IIF((fltValCreArm <> 0), -fltValorCreditoModalidade, 0);

            If FArrEspRecebidas[iCont] = 'CTR_ORDPAG' Then
            Begin
               If Not FEmptyStr(APortadorTF) Then
                  LGravarNovoReg.ParamByName('CTR_PORBAI').AsString := APortadorTF;
            End;

            If (FArrEspRecebidas[iCont] = 'CTR_DINHEI') And
               (fFormataFloat(AValorAdtCredito, 2) = fFormataFloat(LGravarNovoReg.ParamByName(FArrEspRecebidas[iCont]).AsFloat, 2))  Then
            Begin
              If Not fEmptyStr(APortadorAdtCredito) Then
                LGravarNovoReg.ParamByName('CTR_PORBAI').AsString := APortadorAdtCredito;
            End;

            iseqbai := iseqbai + 1;

            fltUltimoValOriCalc := fltValOriCalc;
            sUltAutoIncrem := LGravarNovoReg.ParamByName('AUTOINCREM').AsString;

            LGravarNovoReg.ExecSQL;

         End;

      End;

      fltdifJur := 0;
      fltdifDes := 0;

      // Atualiza diferença de juros/desconto no ultimo autoincrem atualizado;
      If fltJurosDupInicial <> fltRestArredJuros Then
         fltdifJur := fFormataFloat(fltJurosDupInicial - fltRestArredJuros,2);

      If fltDesctoDupInicial <> fltRestArredDescto Then
         fltdifDes :=  fFormataFloat(fltDesctoDupInicial - fltRestArredDescto,2);

      If (fltdifJur <> 0) Or (fltdifDes <> 0) Then
      Begin

        fltUltimoValOriCalc := ((fltUltimoValOriCalc - fltdifJur) + fltdifDes);

        LUpdate.Close;
        LUpdate.Sql.Clear;
        LUpdate.Sql.Add('UPDATE CADREC SET ');
        LUpdate.Sql.Add(' CTR_VALORI = :VALORI ');

        If fltdifJur <> 0 Then
           LUpdate.Sql.Add(' ,CTR_VALJUR = CTR_VALJUR + :DIFJUR ');

        If fltdifDes <> 0 Then
           LUpdate.Sql.Add(' ,CTR_VALDES = CTR_VALDES + :DIFDES ');

        LUpdate.Sql.Add(' WHERE AUTOINCREM = :AUTOINC ');

        LUpdate.ParamByName('VALORI').AsFloat := fltUltimoValOriCalc;

        If fltdifJur <> 0 Then
           LUpdate.ParamByName('DIFJUR').AsFloat := fltdifJur;

        If fltdifDes <> 0 Then
           LUpdate.ParamByName('DIFDES').AsFloat := fltdifDes;

        LUpdate.ParamByName('AUTOINC').AsString   := sUltAutoIncrem;
        LUpdate.ExecSql;
      End;

    End;

    FreeAndNil(LConsulta);
    FreeAndNil(LGravarNovoReg);
    FreeAndNil(LUpdate);
    FreeAndNil(LAux);
  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
End;

function fHistoricoParcelamento(strNumDup, strEspDoc, strCodEmp, strCodCli: String): String;
  Var
    qryHisPar: TUniQuery;
begin
  Result := '';

  Try
    qryHisPar := fCriaQuery;

    qryHisPar.Sql.Text := ' SELECT HIS_INFPAR '+
                          ' FROM HISPAR ' +
                          ' WHERE HIS_NUMDUP = ' + QuotedStr(strNumDup) +
                          '   AND HIS_ESPDOC = ' + QuotedStr(strEspDoc) +
                          '   AND HIS_CODEMP = ' + QuotedStr(strCodEmp) +
                          '   AND HIS_CODCLI = ' + QuotedStr(strCodCli) ;
    qryHisPar.Open;

    Result := qryHisPar.FieldByName('HIS_INFPAR').AsString;

  Finally
    FreeAndNil(qryHisPar);
  End;

end;

procedure EPermissaoNegadaGravacaoCadRec(strMsgMotivo: String);
begin
  raise Exception.Create(strMsgMotivo);
end;

procedure pVerificaTravaCCCliente(strCodCli: String; fltValDup: Double);
begin
  if (fCfgSis('TRACCC', varBoolean)) and
     (fltValDup < 0) and
     (fClienteConsumidor(fRetNomCliente(strCodCli))) then
    EPermissaoNegadaGravacaoCadRec('Atenção! O sistema está configurado para não permitir '+
                                   'geração de crédito para cliente consumidor (CFG_TRACCC)!'+#13#10+
                                   'Cliente: '+strCodCli+'-'+fRetNomCliente(strCodCli)+#13#10+
                                   'Valor do Crédito: '+Format('%m', [fltValDup*-1]));
end;

  function fGravaCadRec(strNomFrmLogCtr,
                        strDescriLogCtr,
                        strNumDup,
                        strParcel: String;
                        intSeqBai: Integer;
                        strEspDoc,
                        strCodCli,
                        strCodEmp,
                        strCodVen,
                        strCodDig,
                        strCodPor: String;
                        dtaDtaCad,
                        dtaDtaVen: TDateTime;
                        fltValDup,
                        fltValOri,
                        fltDesCob: Double;
                        strDescon,
                        strHist01,
                        strHist02,
                        strPorBai,
                        strCtaBai,
                        strOpeBai,
                        strDocBai: String;
                        fltValRec: Double;
                        dtaDtaRec: TDateTime;
                        strAdtCli,
                        strCodEve,
                        strCodVel,
                        strTipFor,
                        strCodCnd: String;
                        blnConApr: Boolean;
                        strCodCta: String;
                        intSeqCon: Integer;
                        fltGrvOri: Double;
                        strObsAg1: String = '';
                        strObsAg2: String = '';
                        strObsAg3: String = '';
                        strCtaSer: String = '';
                        fltValSer: Double = 0;
                        intResCai: Integer = 0;
                        fltVlrCom: Double = 0;
                        fltFatCom: Double = 0;
                        strEmpBai: String = '';
                        strEmp_PD: String = '';
                        strDocDiv: String = '';
                        strEspDiv: String = '';
                        strEmpDiv: String = '';
                        strCliDiv: String = '';
                        fltVlrRep: Double = 0;
                        fltFatRep: Double = 0;
                        strCodRep: String = '';
                        fltValIPI: Double = 0;
                        fltValRet: Double = 0;
                        strOriF11: String = 'N';
                        fltDesSuj: Double = 0;
                        fltJurSuj: Double = 0;
                        fltValCqP: Double = 0;
                        fltValCqV: Double = 0;
                        fltValDin: Double = 0;
                        fltValCar: Double = 0;
                        fltValOrd: Double = 0;
                        fltValFin: Double = 0;
                        strBarCon: String = '';
                        fltPerDPo: Double = 0;
                        intQtdDAV: Integer = 0;
                        fltVrTrDv: Double = 0;
                        strHisBai: String = '';
                        fltValAce: Double = 0;
                        fltValFre: Double = 0;
                        fltDifOri: Double = 0;
                        fltValAnt: Double = 0;
                        fltComDiv: Double = 0;
                        fltFatDiv: Double = 0;
                        strCodDiv: String = '';
                        fltValFCP: Double = 0;
                        strStatusDEPS: String = 'INCLUSÃO';
                        strOpcDoc: String = '';
                        strAutincMovGerFC: String = '';
                        strINCDOC: String = '';
                        strRecPix: String = 'N';
                        strNoFaFF: String = 'N';
                        strChaveMeiaNota: String = '';
                        strPedidoRef: String = '';
                        ASeqMpx: String = '';
                        strSeqEqu: String = '';
                        ASequencialDaBaixaAnterior : Integer = 0;
                        ADataDaBaixaAnterior : TDateTime = 0;
                        strCodPrj: String = '';
                        fltValCBS: Double = 0;
                        fltValIBS: Double = 0;
                        fltVal_IS: Double = 0): Boolean;
Var
  lstrAutInc: String;
begin
  lstrAutInc := EmptyStr;
  Result :=
           fGravaCadRec(lstrAutInc,
                        strNomFrmLogCtr,
                        strDescriLogCtr,
                        strNumDup,
                        strParcel,
                        intSeqBai,
                        strEspDoc,
                        strCodCli,
                        strCodEmp,
                        strCodVen,
                        strCodDig,
                        strCodPor,
                        dtaDtaCad,
                        dtaDtaVen,
                        fltValDup,
                        fltValOri,
                        fltDesCob,
                        strDescon,
                        strHist01,
                        strHist02,
                        strPorBai,
                        strCtaBai,
                        strOpeBai,
                        strDocBai,
                        fltValRec,
                        dtaDtaRec,
                        strAdtCli,
                        strCodEve,
                        strCodVel,
                        strTipFor,
                        strCodCnd,
                        blnConApr,
                        strCodCta,
                        intSeqCon,
                        fltGrvOri,
                        strObsAg1,
                        strObsAg2,
                        strObsAg3,
                        strCtaSer,
                        fltValSer,
                        intResCai,
                        fltVlrCom,
                        fltFatCom,
                        strEmpBai,
                        strEmp_PD,
                        strDocDiv,
                        strEspDiv,
                        strEmpDiv,
                        strCliDiv,
                        fltVlrRep,
                        fltFatRep,
                        strCodRep,
                        fltValIPI,
                        fltValRet,
                        strOriF11,
                        fltDesSuj,
                        fltJurSuj,
                        fltValCqP,
                        fltValCqV,
                        fltValDin,
                        fltValCar,
                        fltValOrd,
                        fltValFin,
                        strBarCon,
                        fltPerDPo,
                        intQtdDAV,
                        fltVrTrDv,
                        strHisBai,
                        fltValAce,
                        fltValFre,
                        fltDifOri,
                        fltValAnt,
                        fltComDiv,
                        fltFatDiv,
                        strCodDiv,
                        fltValFCP,
                        strStatusDEPS,
                        strOpcDoc,
                        strAutincMovGerFC,
                        strINCDOC,
                        strRecPix,
                        strNoFaFF,
                        strChaveMeiaNota,
                        strPedidoRef,
                        ASeqMpx,
                        strSeqEqu,
                        ASequencialDaBaixaAnterior,
                        ADataDaBaixaAnterior,
                        strCodPrj,
                        fltValCBS,
                        fltValIBS,
                        fltVal_IS);
end;

function fGravaCadRec(Var strAutoInc: String;
                      strNomFrmLogCtr,
                      strDescriLogCtr,
                      strNumDup,
                      strParcel: String;
                      intSeqBai: Integer;
                      strEspDoc,
                      strCodCli,
                      strCodEmp,
                      strCodVen,
                      strCodDig,
                      strCodPor: String;
                      dtaDtaCad,
                      dtaDtaVen: TDateTime;
                      fltValDup,
                      fltValOri,
                      fltDesCob: Double;
                      strDescon,
                      strHist01,
                      strHist02,
                      strPorBai,
                      strCtaBai,
                      strOpeBai,
                      strDocBai: String;
                      fltValRec: Double;
                      dtaDtaRec: TDateTime;
                      strAdtCli,
                      strCodEve,
                      strCodVel,
                      strTipFor,
                      strCodCnd: String;
                      blnConApr: Boolean;
                      strCodCta: String;
                      intSeqCon: Integer;
                      fltGrvOri: Double;
                      strObsAg1: String = '';
                      strObsAg2: String = '';
                      strObsAg3: String = '';
                      strCtaSer: String = '';
                      fltValSer: Double = 0;
                      intResCai: Integer = 0;
                      fltVlrCom: Double = 0;
                      fltFatCom: Double = 0;
                      strEmpBai: String = '';
                      strEmp_PD: String = '';
                      strDocDiv: String = '';
                      strEspDiv: String = '';
                      strEmpDiv: String = '';
                      strCliDiv: String = '';
                      fltVlrRep: Double = 0;
                      fltFatRep: Double = 0;
                      strCodRep: String = '';
                      fltValIPI: Double = 0;
                      fltValRet: Double = 0;
                      strOriF11: String = 'N';
                      fltDesSuj: Double = 0;
                      fltJurSuj: Double = 0;
                      fltValCqP: Double = 0;
                      fltValCqV: Double = 0;
                      fltValDin: Double = 0;
                      fltValCar: Double = 0;
                      fltValOrd: Double = 0;
                      fltValFin: Double = 0;
                      strBarCon: String = '';
                      fltPerDPo: Double = 0;
                      intQtdDAV: Integer = 0;
                      fltVrTrDv: Double = 0;
                      strHisBai: String = '';
                      fltValAce: Double = 0;
                      fltValFre: Double = 0;
                      fltDifOri: Double = 0;
                      fltValAnt: Double = 0;
                      fltComDiv: Double = 0;
                      fltFatDiv: Double = 0;
                      strCodDiv: String = '';
                      fltValFCP: Double = 0;
                      strStatusDEPS: String = 'INCLUSÃO';
                      strOpcDoc: String = '';
                      strAutincMovGerFC: String = '';
                      strINCDOC: String = '';
                      strRecPix: String = 'N';
                      strNoFaFF: String = 'N';
                      strChaveMeiaNota: String = '';
                      strPedidoRef: String = '';
                      ASeqMpx: String = '';
                      strSeqEqu: String = '';
                      ASequencialDaBaixaAnterior : Integer = 0;
                      ADataDaBaixaAnterior : TDateTime = 0;
                      strCodPrj: String = '';
                      fltValCBS: Double = 0;
                      fltValIBS: Double = 0;
                      fltVal_IS: Double = 0): Boolean;

  Var
    strSQL: String;
    qryGenCtr : TUniQuery;

    LSeqConLog,
    LResCaiLog: Integer;

    LRecPixLog: String;
    arrEspCC : Array Of TEspeciesGerCC;
begin
  pVerificaTravaCCCliente(strCodCli, fltValDup);

  SetLength(arrEspCC, 0);

  qryGenCtr := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'INSERT INTO CADREC ';
  strSQL := strSQL + '( ';
  strSQL := strSQL + '  CTR_NUMDUP, ';
  strSQL := strSQL + '  CTR_PARCEL, ';
  strSQL := strSQL + '  CTR_SEQBAI, ';
  strSQL := strSQL + '  CTR_ESPDOC, ';
  strSQL := strSQL + '  CTR_CODCLI, ';
  strSQL := strSQL + '  CTR_CODEMP, ';
  strSQL := strSQL + '  CTR_CODVEN, ';
  strSQL := strSQL + '  CTR_CODDIG, ';
  strSQL := strSQL + '  CTR_CODPOR, ';
  strSQL := strSQL + '  CTR_DTACAD, ';
  strSQL := strSQL + '  CTR_DTAVEN, ';
  strSQL := strSQL + '  CTR_VALDUP, ';
  strSQL := strSQL + '  CTR_VALORI, ';
  strSQL := strSQL + '  CTR_DESCOB, ';
  strSQL := strSQL + '  CTR_DESCON, ';
  strSQL := strSQL + '  CTR_HIST01, ';
  strSQL := strSQL + '  CTR_HIST02, ';
  strSQL := strSQL + '  CTR_OBSAG1, ';
  strSQL := strSQL + '  CTR_OBSAG2, ';
  strSQL := strSQL + '  CTR_OBSAG3, ';
  strSQL := strSQL + '  CTR_VALREC, ';
  strSQL := strSQL + '  CTR_RESCAI, ';
  strSQL := strSQL + '  CTR_ADTCLI, ';

  If (Not fEmptyStr(strCodEve)) Then
    strSQL := strSQL + '  CTR_CODEVE, ';

  If (Not fEmptyStr(strCtaBai)) Then
    strSQL := strSQL + '  CTR_CTABAI, ';

  If (Not fEmptyStr(strOpeBai)) Then
    strSQL := strSQL + '  CTR_OPEBAI, ';

  If (Not fEmptyStr(strDocBai)) Then
    strSQL := strSQL + '  CTR_DOCBAI, ';

  If (Not fEmptyStr(strPorBai)) Then
    strSQL := strSQL + '  CTR_PORBAI, ';

  If (dtaDtaRec > 0) Then
  Begin
    strSQL := strSQL + '  CTR_DTAREC, ';
    strSQL := strSQL + '  CTR_DTABAI, ';
    strSQL := strSQL + '  CTR_AMORTI, ';
    strSQL := strSQL + '  CTR_VALCOR, ';
  end;

  strSQL := strSQL + '  CTR_BAIANT, ';
  strSQL := strSQL + '  CTR_SEQANT, ';

  If (fltValCqV <> 0) Then
    strSQL := strSQL + '  CTR_CHQAVI, ';
  strSQL := strSQL + '  CTR_RECCHE, ';

  If (fltValCqP <> 0) Then
    strSQL := strSQL + '  CTR_CHQPRE, ';
  strSQL := strSQL + '  CTR_RECPRE, ';

  If (fltValDin <> 0) Then
    strSQL := strSQL + '  CTR_DINHEI, ';
  strSQL := strSQL + '  CTR_RECDIN, ';

  If (fltValCar <> 0) Then
    strSQL := strSQL + '  CTR_CARTAO, ';
  strSQL := strSQL + '  CTR_RECCAR, ';

  If (fltValOrd <> 0) Then
    strSQL := strSQL + '  CTR_ORDPAG, ';
  strSQL := strSQL + '  CTR_RECORD, ';

  If (fltValFin <> 0) Then
    strSQL := strSQL + '  CTR_VALFIN, ';
  strSQL := strSQL + '  CTR_RECFIN, ';

  If (Not fEmptyStr(strCodVel)) Then
    strSQL := strSQL + '  CTR_CODVEL, ';

  If (Not fEmptyStr(strTipFor)) Then
    strSQL := strSQL + '  CTR_TIPFOR, ';

  If (Not fEmptyStr(strCodCnd)) Then
    strSQL := strSQL + '  CTR_CODCND, ';

  If (Not fEmptyStr(strCodCta)) Then
    strSQL := strSQL + '  CTR_CODCTA, ';

  If (Not fEmptyStr(strCtaSer)) Then
  Begin
    strSQL := strSQL + '  CTR_CTASER, ';
    strSQL := strSQL + '  CTR_SERVAL, ';
  End;

  strSQL := strSQL + '  CTR_CONAPR, ';

  strSQL := strSQL + '  CTR_VALCOM, ';
  strSQL := strSQL + '  CTR_FATCOM, ';

  If (Not fEmptyStr(strEmpBai)) Then
    strSQL := strSQL + '  CTR_EMPBAI, ';

  strSQL := strSQL + '  CTR_EMP_PD, ';

  If (Not fEmptyStr(strDocDiv)) Then
    strSQL := strSQL + '  CTR_DOCDIV, ';

  If (Not fEmptyStr(strEspDiv)) Then
    strSQL := strSQL + '  CTR_ESPDIV, ';

  If (Not fEmptyStr(strEmpDiv)) Then
    strSQL := strSQL + '  CTR_EMPDIV, ';

  If (Not fEmptyStr(strCliDiv)) Then
    strSQL := strSQL + '  CTR_CLIDIV, ';

  If (Not fEmptyStr(strCodDiv)) Then
    strSQL := strSQL + '  CTR_CODDIV, ';

  strSQL := strSQL + '  CTR_COMDIV, ';
  strSQL := strSQL + '  CTR_FATDIV, ';

  strSQL := strSQL + '  CTR_SEQCON, ';
  strSQL := strSQL + '  CTR_PERDPO, ';
  strSQL := strSQL + '  CTR_QTDDAV, ';

  strSQL := strSQL + '  CTR_COMREP, ';
  strSQL := strSQL + '  CTR_FATREP, ';
  strSQL := strSQL + '  CTR_CODREP, ';
  strSQL := strSQL + '  CTR_VALIPI, ';
  strSQL := strSQL + '  CTR_VALRET, ';
  strSQL := strSQL + '  CTR_VALFCP, ';
  strSQL := strSQL + '  CTR_VALCBS, ';
  strSQL := strSQL + '  CTR_VALIBS, ';
  strSQL := strSQL + '  CTR_VAL_IS, ';
  strSQL := strSQL + '  CTR_ORIF11, ';
  strSQL := strSQL + '  CTR_JURSUJ, ';
  strSQL := strSQL + '  CTR_DESSUJ, ';
  strSQL := strSQL + '  CTR_VRTRDV, ';
  strSQL := strSQL + '  CTR_GRVORI, ';

  If Not fEmptyStr(strBarCon) Then
    strSQL := strSQL + '  CTR_BARCON, ';

  If Not fEmptyStr(strHisBai) Then
    strSQL := strSQL + '  CTR_HISBAI, ';

  strSQL := strSQL + '  CTR_VALACE, ';
  strSQL := strSQL + '  CTR_VALFRE, ';

  If fltDifOri > 0 Then
    strSQL := strSQL + '  CTR_DIFORI, ';

  If fltValAnt > 0 Then
    strSQL := strSQL + '  CTR_VALANT, ';

  If Not fEmptyStr(strAutincMovGerFC) Then
    strSQL := strSQL + '  CTR_SEQFCO, ';

  If not fEmptyStr(strChaveMeiaNota) Then
    strSQL := strSQL + '  CTR_CHVPFF, ';

  If not fEmptyStr(strCodPrj) Then
    strSQL := strSQL + '  CTR_CODPRJ, ';

  strSQL := strSQL + '  AUTOINCREM, ';
  strSQL := strSQL + '  CTR_INCDOC, ';

  strSQL := strSQL + '  CTR_EMPORI, ';
  strSQL := strSQL + '  CTR_NOFAFF, ';
  strSQL := strSQL + '  CTR_RECPIX, ';
  strSQL := strSQL + '  CTR_SEQMPX, ';
  strSQL := strSQL + '  CTR_SEQEQU) ';

  strSQL := strSQL + 'VALUES ( ';
  strSQL := strSQL + '  :NUMDUP, ';
  strSQL := strSQL + '  :PARCEL, ';
  strSQL := strSQL + '  :SEQBAI, ';
  strSQL := strSQL + '  :ESPDOC, ';
  strSQL := strSQL + '  :CODCLI, ';
  strSQL := strSQL + '  :CODEMP, ';
  strSQL := strSQL + '  :CODVEN, ';
  strSQL := strSQL + '  :CODDIG, ';
  strSQL := strSQL + '  :CODPOR, ';
  strSQL := strSQL + '  :DTACAD, ';
  strSQL := strSQL + '  :DTAVEN, ';
  strSQL := strSQL + '  :VALDUP, ';
  strSQL := strSQL + '  :VALORI, ';
  strSQL := strSQL + '  :DESCOB, ';
  strSQL := strSQL + '  :DESCON, ';
  strSQL := strSQL + '  :HIST01, ';
  strSQL := strSQL + '  :HIST02, ';
  strSQL := strSQL + '  :OBSAG1, ';
  strSQL := strSQL + '  :OBSAG2, ';
  strSQL := strSQL + '  :OBSAG3, ';
  strSQL := strSQL + '  :VALREC, ';
  strSQL := strSQL + '  :RESCAI, ';
  strSQL := strSQL + '  :ADTCLI, ';

  If (Not fEmptyStr(strCodEve)) Then
    strSQL := strSQL + '  :CODEVE, ';

  If (Not fEmptyStr(strCtaBai)) Then
    strSQL := strSQL + '  :CTABAI, ';

  If (Not fEmptyStr(strOpeBai)) Then
    strSQL := strSQL + '  :OPEBAI, ';

  If (Not fEmptyStr(strDocBai)) Then
    strSQL := strSQL + '  :DOCBAI, ';

  If (Not fEmptyStr(strPorBai)) Then
    strSQL := strSQL + '  :PORBAI, ';

  If (dtaDtaRec > 0) Then
  Begin
    strSQL := strSQL + '  :DTAREC, ';
    strSQL := strSQL + '  :DTABAI, ';
    strSQL := strSQL + '  :AMORTI, ';
    strSQL := strSQL + '  :VALCOR, ';
  end;

  strSQL := strSQL + '  :BAIANT, ';
  strSQL := strSQL + '  :SEQANT, ';

  If (fltValCqV <> 0) Then
    strSQL := strSQL + '  :CHQAVI, ';
  strSQL := strSQL + '  :RECAVI, ';

  If (fltValCqP <> 0) Then
    strSQL := strSQL + '  :CHQPRE, ';
  strSQL := strSQL + '  :RECPRE, ';

  If (fltValDin <> 0) Then
    strSQL := strSQL + '  :DINHEI, ';
  strSQL := strSQL + '  :RECDIN, ';

  If (fltValCar <> 0) Then
    strSQL := strSQL + '  :CARTAO, ';
  strSQL := strSQL + '  :RECCAR, ';

  If (fltValOrd <> 0) Then
    strSQL := strSQL + '  :ORDPAG, ';
  strSQL := strSQL + '  :RECORD, ';

  If (fltValFin <> 0) Then
    strSQL := strSQL + '  :VALFIN, ';
  strSQL := strSQL + '  :RECFIN, ';

  If (Not fEmptyStr(strCodVel)) Then
    strSQL := strSQL + '  :CODVEL, ';

  If (Not fEmptyStr(strTipFor)) Then
    strSQL := strSQL + '  :TIPFOR, ';

  If (Not fEmptyStr(strCodCnd)) Then
    strSQL := strSQL + '  :CODCND, ';

  If (Not fEmptyStr(strCodCta)) Then
    strSQL := strSQL + '  :CODCTA, ';

  If (Not fEmptyStr(strCtaSer)) Then
  Begin
    strSQL := strSQL + '  :CTASER, ';
    strSQL := strSQL + '  :SERVAL, ';
  End;

  strSQL := strSQL + '  :CONAPR, ';

  strSQL := strSQL + '  :VALCOM, ';
  strSQL := strSQL + '  :FATCOM, ';

  If (Not fEmptyStr(strEmpBai)) Then
    strSQL := strSQL + ' :EMPBAI, ';

  strSQL := strSQL + ' :EMP_PD, ';

  If (Not fEmptyStr(strDocDiv)) Then
    strSQL := strSQL + '  :DOCDIV, ';

  If (Not fEmptyStr(strEspDiv)) Then
    strSQL := strSQL + '  :ESPDIV, ';

  If (Not fEmptyStr(strEmpDiv)) Then
    strSQL := strSQL + '  :EMPDIV, ';

  If (Not fEmptyStr(strCliDiv)) Then
    strSQL := strSQL + '  :CLIDIV, ';

  If (Not fEmptyStr(strCodDiv)) Then
    strSQL := strSQL + '  :CODDIV, ';

  strSQL := strSQL + '  :COMDIV, ';
  strSQL := strSQL + '  :FATDIV, ';

  strSQL := strSQL + '  :SEQCON, ';
  strSQL := strSQL + '  :PERDPO, ';
  strSQL := strSQL + '  :QTDDAV, ';

  strSQL := strSQL + '  :COMREP, ';
  strSQL := strSQL + '  :FATREP, ';
  strSQL := strSQL + '  :CODREP, ';
  strSQL := strSQL + '  :VALIPI, ';
  strSQL := strSQL + '  :VALRET, ';
  strSQL := strSQL + '  :VALFCP, ';
  strSQL := strSQL + '  :VALCBS, ';
  strSQL := strSQL + '  :VALIBS, ';
  strSQL := strSQL + '  :VAL_IS, ';
  strSQL := strSQL + '  :ORIF11, ';
  strSQL := strSQL + '  :JURSUJ, ';
  strSQL := strSQL + '  :DESSUJ, ';
  strSQL := strSQL + '  :VRTRDV, ';
  strSQL := strSQL + '  :GRVORI, ';

  If Not fEmptyStr(strBarCon) Then
    strSQL := strSQL + '  :BARCON, ';

  If Not fEmptyStr(strHisBai) Then
    strSQL := strSQL + '  :HISBAI, ';

  strSQL := strSQL + '  :VALACE, ';
  strSQL := strSQL + '  :VALFRE, ';

  If fltDifOri > 0 Then
    strSQL := strSQL + '  :DIFORI, ';

  If fltValAnt > 0 Then
    strSQL := strSQL + '  :VALANT, ';

  If Not fEmptyStr(strAutincMovGerFC) Then
    strSQL := strSQL + '  :SEQFCO, ';

  If not fEmptyStr(strChaveMeiaNota) Then
    strSQL := strSQL + '  :CHVPFF, ';

  If not fEmptyStr(strCodPrj) Then
    strSQL := strSQL + '  :CODPRJ, ';

  strSQL := strSQL + '  :AUTINC,  ';

  strSQL := strSQL + '  :INCDOC, ';

  strSQL := strSQL + '  :EMPORI,  ';
  strSQL := strSQL + '  :NOFAFF,  ';
  strSQL := strSQL + '  :RECPIX,  ';
  strSQL := strSQL + '  :SEQMPX,  ';
  strSQL := strSQL + '  :SEQEQU)  ';

  try
    With qryGenCtr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString   := strNumDup;
      ParamByName('PARCEL').AsString   := strParcel;
      ParamByName('SEQBAI').AsInteger  := intSeqBai;
      ParamByName('ESPDOC').AsString   := strEspDoc;
      ParamByName('CODCLI').AsString   := strCodCli;
      ParamByName('CODEMP').AsString   := strCodEmp;
      ParamByName('CODVEN').AsString   := strCodVen;


      If fEmptyStr(strIncDoc) Then
        ParamByName('INCDOC').Value    := Null
      Else
        ParamByName('INCDOC').AsString := strINCDOC;


      If fEmptyStr(strCodDig) Then
        ParamByName('CODDIG').Value    := Null
      Else
        ParamByName('CODDIG').AsString := strCodDig;

      If fEmptyStr(strCodPor) Then
        ParamByName('CODPOR').Value    := Null
      Else
        ParamByName('CODPOR').AsString := strCodPor;

      ParamByName('DTACAD').AsDateTime := dtaDtaCad;
      ParamByName('DTAVEN').AsDateTime := dtaDtaVen;
      ParamByName('VALDUP').AsFloat    := fltValDup;
      ParamByName('VALORI').AsFloat    := fltValOri;
      ParamByName('DESCOB').AsFloat    := fltDesCob;

      If fEmptyStr(strDescon) Then
        ParamByName('DESCON').AsString := 'N'
      Else
        ParamByName('DESCON').AsString := strDescon;

      ParamByName('HIST01').AsString   := strHist01;

      if (not fEmptyStr(strPedidoRef)) then
        ParamByName('HIST01').AsString   := ParamByName('HIST01').AsString +
                                          IIF(strHist01.IsEmpty, '', #13) +
                                          'PD VENDA: ' + strPedidoRef;

      ParamByName('HIST02').AsString   := strHist02;
      If fEmptyStr(strObsAg1) Then
      Begin
        ParamByName('OBSAG1').Value := Null;
        ParamByName('OBSAG2').Value := Null;
        ParamByName('OBSAG3').Value := Null;
      End
      Else
      Begin
        ParamByName('OBSAG1').AsString := strObsAg1;
        ParamByName('OBSAG2').AsString := strObsAg2;
        ParamByName('OBSAG3').AsString := strObsAg3;
      End;

      ParamByName('VALREC').AsFloat    := fltValRec;

      ParamByName('RESCAI').AsInteger  := intResCai;

      ParamByName('ADTCLI').AsString   := strAdtCli;

      If (Not fEmptyStr(strCodEve)) Then
        ParamByName('CODEVE').AsString   := strCodEve;

      If (Not fEmptyStr(strCtaBai)) Then
        ParamByName('CTABAI').Value    := strCtaBai;

      If (Not fEmptyStr(strOpeBai)) Then
        ParamByName('OPEBAI').Value    := strOpeBai;

      If (Not fEmptyStr(strDocBai)) Then
        ParamByName('DOCBAI').Value    := strDocBai;

      If (Not fEmptyStr(strPorBai)) Then
        ParamByName('PORBAI').AsString := strPorBai;

      If (dtaDtaRec > 0) Then
      Begin
        ParamByName('DTAREC').AsDateTime := dtaDtaRec;
        ParamByName('DTABAI').AsDateTime := VS_Date;
        ParamByName('AMORTI').AsFloat    := fltValRec;
        ParamByName('VALCOR').AsFloat    := fltValRec;
      end;

      ParamByName('BAIANT').Value := Null;
      If ADataDaBaixaAnterior > 0 Then
        ParamByName('BAIANT').AsDateTime := ADataDaBaixaAnterior;

      ParamByName('SEQANT').Value := Null;
      If ASequencialDaBaixaAnterior > 0 Then
        ParamByName('SEQANT').AsInteger := ASequencialDaBaixaAnterior;

      If (fltValCqV <> 0) Then
      Begin
        ParamByName('CHQAVI').AsFloat  := fltValCqV;
        ParamByName('RECAVI').AsString := 'S';
      End
      Else ParamByName('RECAVI').AsString := 'N';

      If (fltValCqP <> 0) Then
      Begin
        ParamByName('CHQPRE').AsFloat  := fltValCqP;
        ParamByName('RECPRE').AsString := 'S';
      End
      Else ParamByName('RECPRE').AsString := 'N';

      If (fltValDin <> 0) Then
      Begin
        ParamByName('DINHEI').AsFloat  := fltValDin;
        ParamByName('RECDIN').AsString := 'S';
      End
      Else ParamByName('RECDIN').AsString := 'N';

      If (fltValCar <> 0) Then
      Begin
        ParamByName('CARTAO').AsFloat  := fltValCar;
        ParamByName('RECCAR').AsString := 'S';
      End
      Else ParamByName('RECCAR').AsString := 'N';

      If (fltValOrd <> 0) Then
      Begin
        ParamByName('ORDPAG').AsFloat  := fltValOrd;
        ParamByName('RECORD').AsString := 'S';
      End
      Else ParamByName('RECORD').AsString := 'N';

      If (fltValFin <> 0) Then
      Begin
        ParamByName('VALFIN').AsFloat := fltValFin;
        ParamByName('RECFIN').AsString := 'S';
      End
      Else ParamByName('RECFIN').AsString := 'N';

      If (Not fEmptyStr(strCodVel)) Then
        ParamByName('CODVEL').AsString := strCodVel;

      If (Not fEmptyStr(strTipFor)) Then
        ParamByName('TIPFOR').AsString := strTipFor;

      If (Not fEmptyStr(strCodCnd)) Then
        ParamByName('CODCND').AsString := strCodCnd;

      If (Not fEmptyStr(strCodCta)) Then
        ParamByName('CODCTA').AsString := strCodCta;

      If (Not fEmptyStr(strCtaSer)) Then
      Begin
        ParamByName('CTASER').AsString := strCtaSer;
        ParamByName('SERVAL').AsFloat  := fltValSer;
      End;

      ParamByName('CONAPR').AsInteger := IIF(blnConApr, 1, 0);

      If (Not fEmptyStr(strEmpBai)) Then
        ParamByName('EMPBAI').AsString := strEmpBai;

      ParamByName('VALCOM').AsFloat   := Abs(IIF(fltVlrCom < 0, fltVlrCom * -1, fltVlrCom));
      ParamByName('FATCOM').AsFloat   := Abs(IIF(fltFatCom < 0, fltFatCom * -1, fltFatCom));

      pSetaEmp_PD(qryGenCtr, strEmp_PD, strCodVen, strCodEmp);

      If (Not fEmptyStr(strDocDiv)) Then
        ParamByName('DOCDIV').AsString := strDocDiv;

      If (Not fEmptyStr(strEspDiv)) Then
        ParamByName('ESPDIV').AsString := strEspDiv;

      If (Not fEmptyStr(strEmpDiv)) Then
        ParamByName('EMPDIV').AsString := strEmpDiv;

      If (Not fEmptyStr(strCliDiv)) Then
        ParamByName('CLIDIV').AsString := strCliDiv;

      If (Not fEmptyStr(strCodDiv)) Then
        ParamByName('CODDIV').AsString := strCodDiv;

      ParamByName('COMDIV').AsFloat  := fltComDiv;
      ParamByName('FATDIV').AsFloat  := fltFatDiv;

      If (strEspDoc = 'CC') And (strOpcDoc <> 'FC') Then
      Begin
        ParamByName('SEQCON').AsInteger := 0;
        ParamByName('RECPIX').AsString := 'N';
      End
      Else
      Begin
        ParamByName('SEQCON').AsInteger := intSeqCon;
        ParamByName('RECPIX').AsString := 'N';
        If Not strRecPix.IsEmpty Then
          ParamByName('RECPIX').AsString := strRecPix;
      End;

      ParamByName('PERDPO').AsFloat   := fltPerDPo;
      ParamByName('QTDDAV').AsInteger := intQtdDAV;

      ParamByName('COMREP').AsFloat   := Abs(IIF(fltVlrRep < 0, fltVlrRep * -1, fltVlrRep));
      ParamByName('FATREP').AsFloat   := Abs(IIF(fltFatRep < 0, fltFatRep * -1, fltFatRep));

      ParamByName('CODREP').AsString  := strCodRep;
      If fEmptyStr(ParamByName('CODREP').AsString) Then
        ParamByName('CODREP').Clear;

      ParamByName('VALIPI').AsFloat  := fltValIPI;
      ParamByName('VALRET').AsFloat  := fltValRet;
      ParamByName('VALFCP').AsFloat  := fltValFCP;
      ParamByName('VALCBS').AsFloat  := fltValCBS;
      ParamByName('VALIBS').AsFloat  := fltValIBS;
      ParamByName('VAL_IS').AsFloat  := fltVal_IS;
      ParamByName('ORIF11').AsString := strOriF11;
      ParamByName('JURSUJ').AsFloat  := fltJurSuj;
      ParamByName('DESSUJ').AsFloat  := fltDesSuj;
      ParamByName('VRTRDV').AsFloat  := fltVrTrDv;

      If fltGrvOri <> 0 Then
        ParamByName('GRVORI').AsFloat := fltGrvOri
      Else
        ParamByName('GRVORI').AsFloat := fltValOri;

      If Not fEmptyStr(strAutincMovGerFC) Then
        ParamByName('SEQFCO').AsString  := strAutincMovGerFC;

      If not fEmptyStr(strChaveMeiaNota) Then
        ParamByName('CHVPFF').AsString  := strChaveMeiaNota;

      If not fEmptyStr(strCodPrj) Then
        ParamByName('CODPRJ').AsString  := strCodPrj;

      strAutoInc := fRetAutoIncrem('CADREC', strCodEmp);
      ParamByName('AUTINC').AsString  := strAutoInc;

      If Not fEmptyStr(strBarCon) Then
        ParamByName('BARCON').AsString := strBarCon;

      If Not fEmptyStr(strHisBai) Then
        ParamByName('HISBAI').AsString := strHisBai;

      ParamByName('VALACE').AsFloat := fltValAce;
      ParamByName('VALFRE').AsFloat := fltValFre;

      If fltDifOri > 0 Then
        ParamByName('DIFORI').AsFloat := fltDifOri;

      If fltValAnt > 0 Then
        ParamByName('VALANT').AsFloat := fltValAnt;

      if fEmptyStr(strEmp_PD) then
        ParamByName('EMPORI').AsString  := strCodEmp
      else
        ParamByName('EMPORI').AsString  := strEmp_PD;

      ParamByName('NOFAFF').AsString := IIF(fEmptyStr(strChaveMeiaNota), strNoFaFF, 'S');
      ParamByName('SEQMPX').Value := IIF(ASeqMpx.IsEmpty, Null, ASeqMpx);
      ParamByName('SEQEQU').Value := IIF(strSeqEqu.IsEmpty, Null, strSeqEqu);

      ExecSQL;
      Close;

      {*********************************}
      {* GRAVAR TABELA DO SISTEMA DEPS *}
      {******************************AJ*}
      If fCfgSis('USADEP') = 'S' Then
      Begin
        TValidacoesSistemaDEPS.pGravaLancamentoSistemaDEPS(Concat(strNumDup, '-',
                                                                  strParcel, '-',
                                                                  strEspDoc, '-',
                                                                  strCodEmp, '-',
                                                                  strCodCli, '-',
                                                                  intSeqBai.ToString),
                                                           strStatusDEPS);

        If dtaDtaRec > 0 Then
          TValidacoesSistemaDEPS.pGravaLancamentoSistemaDEPS(Concat(strNumDup, '-',
                                                                    strParcel, '-',
                                                                    strEspDoc, '-',
                                                                    strCodEmp, '-',
                                                                    strCodCli, '-',
                                                                    intSeqBai.ToString),
                                                             'BAIXA');
      End;

      LSeqConLog := 0;
      LResCaiLog := 0;

      LRecPixLog := 'N';

      If strEspDoc = 'CC' Then
      Begin
        LSeqConLog := intSeqCon;

        If strNomFrmLogCtr = 'frmBaixaReceber' Then
          LResCaiLog := intResCai
        else
          LResCaiLog := 1;

        LRecPixLog := strRecPix;
      End;

      If strEspDoc = 'CC' Then
         untLogCtr.GravaLogCtr(strAutoInc, strDescriLogCtr, strNomFrmLogCtr, FRecEspeciesCC, '', LSeqConLog, LResCaiLog, '', LRecPixLog, nil, '')
      Else
         untLogCtr.GravaLogCtr(strAutoInc, strDescriLogCtr, strNomFrmLogCtr, '', LSeqConLog, LResCaiLog, '', LRecPixLog, nil, '');

      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[fGravaCadRec] - ' + E.Message);
    End;
  End;

  FreeAndNil(qryGenCtr);
end;

Function  fBaixaParcial(strNumDup,
                        strParcel,
                        strCodEmp,
                        strEspDoc,
                        strCodCli: String;
                        fltValRec,
                        fltValJur,
                        fltValDes: Double;
                        dtaDtaRec,
                        dtaDtaVen: TDateTime;
                        strPorBai,
                        strHisBai,
                        strCtaBai,
                        strOpeBai,
                        strSeqLan: String;
                        fltNovoValOri,
                        fltNovoValDup,
                        fltValCqP,
                        fltValCqV,
                        fltValDin,
                        fltValCar,
                        fltValOrd,
                        fltValFin: Double;
                        intResCai: Integer;
                        intSeqMod: Integer;
                        blnRecCqP,
                        blnRecCqV,
                        blnRecDin,
                        blnRecCar,
                        blnRecOrd,
                        blnRecFin: boolean;
                    Var intSeqBai: Integer;
                    Var strAutIncNov: String;
                        intSeqCon: Integer;
                        fltValIpi,
                        fltValRet,
                        fltValAce,
                        fltValFre,
                        fltValFCP,
                        fltDifOri: Double;
                        dtaMovimentacaoBancaria : TDate;
                        AValorBaixadoDuplicata,
                        ANovoJurSuj,
                        AFatorDuplicata,
                        AFatorJuros,
                        ANovoDesSuj,
                        AValorCorrigido: Double;
                        strRecAut: String = 'N';
                        strEmpBai: String = '';
                        fltGrvOri: Double = 0;
                        strId_Loc: String = '';
                        strId_Doc: String = '';
                        strAutincMovGerFC: String = '';
                        strRecPix: String = 'N';
                        ADespesasBaixaDuplicata: Double = 0;
                        ADespesasNovaDuplicata: Double = 0;
                        fltValCBS: Double = 0;
                        fltValIBS: Double = 0;
                        fltVal_IS: Double = 0): Boolean;
  Var
    strSQL    : String;
    qryGenCtr : TUniQuery;
    qryGenDup : TUniQuery;
    qryGenTmp : TUniQuery;
    //intPosTra : Integer;
    strHist01 : String;
    fltProporcaoImposto,
    fltValIpi_prop,
    fltValRet_prop,
    fltValAce_prop,
    fltValFre_prop,
    fltValFCP_prop,
    fltValCBS_prop,
    fltValIBS_prop,
    fltVal_IS_prop,
    fltSobraDeJuros,
    fltDescontoAteVencimento: Double;
begin

  Try
    qryGenCtr := fCriaQuery;
    qryGenDup := fCriaQuery;
    qryGenTmp := fCriaQuery;

    intSeqBai := fRetSeqBaiCadRec(strNumDup,
                                  strParcel,
                                  strCodEmp,
                                  strEspDoc,
                                  strCodCli);
    Inc(intSeqBai);

    {*****************************************}
    {* SALVA DADOS DA DUPLICATA ANTES DE     *}
    {* BAIXAR                                *}
    {**************************************MV*}
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';

    strSQL := strSQL + '  ( (CTR_DTAREC IS NULL) OR (CTR_SEQBAI = 0 AND IFNULL(CTR_ID_DOC, "") <> "") ) ';

    qryGenCtr.Close;
    qryGenCtr.SQL.Clear;
    qryGenCtr.SQL.Add(strSQL);
    qryGenCtr.ParamByName('NUMDUP').AsString := strNumDup;
    qryGenCtr.ParamByName('PARCEL').AsString := strParcel;
    qryGenCtr.ParamByName('CODEMP').AsString := strCodEmp;
    qryGenCtr.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGenCtr.ParamByName('CODCLI').AsString := strCodCli;
    qryGenCtr.Open;

    strHist01 := qryGenCtr.FieldByName('CTR_HIST01').AsString;

    If Not fEmptyStr(qryGenCtr.FieldByName('CTR_NOSNUM').AsString) Then
      strHist01 := 'Nosso número: ' + qryGenCtr.FieldByName('CTR_NOSNUM').AsString + IIF(fEmptyStr(strHist01), '', ' - ' + strHist01);

    {**********************************}
    {* PEGA A SOBRA DE JUROS DE TODAS *}
    {* AS BAIXAS ANTERIORES PARA      *}
    {* CALCULAR AMORTIZAÇÃO           *}
    {*******************************AJ*}
    fltSobraDeJuros := 0;
    If qryGenCtr.FieldByName('CTR_VALDUP').AsFloat > 0 Then
      fltSobraDeJuros := fRetornaSobraDeJurosDeBaixasAnteriores(strNumDup,
                                                                strParcel,
                                                                strEspDoc,
                                                                strCodEmp,
                                                                strCodCli,
                                                                intSeqBai.ToString);

    {*****************************************}
    {* BAIXA A DUPLICATA...                  *}
    {**************************************MV*}
    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CTR_VALANT = :VALANT, ';
    strSQL := strSQL + '  CTR_JURANT = CTR_JURSUJ, ';
    strSQL := strSQL + '  CTR_DESANT = CTR_DESSUJ, ';
    strSQL := strSQL + '  CTR_COBANT = CTR_DESCOB, ';
    strSQL := strSQL + '  CTR_VALDUP = 0, ';
    strSQL := strSQL + '  CTR_JURSUJ = 0, ';
    strSQL := strSQL + '  CTR_DESSUJ = 0, ';
    strSQL := strSQL + '  CTR_DESCOB = 0, ';
    strSQL := strSQL + '  CTR_DTAREC = :DTAREC, ';
    strSQL := strSQL + '  CTR_SEQBAI = :SEQBAI, ';
    strSQL := strSQL + '  CTR_VALORI = :VALORI, ';
    strSQL := strSQL + '  CTR_VALJUR = :VALJUR, ';
    strSQL := strSQL + '  CTR_VALDES = :VALDES, ';
    strSQL := strSQL + '  CTR_VALCOB = :VALCOB, ';
    strSQL := strSQL + '  CTR_VALREC = :VALREC, ';
    strSQL := strSQL + '  CTR_PORBAI = :PORBAI, ';
    strSQL := strSQL + '  CTR_HIST01 = :HIST01, ';
    strSQL := strSQL + '  CTR_HISBAI = :HISBAI, ';
    strSQL := strSQL + '  CTR_DOCBAI = :DOCBAI, ';
    strSQL := strSQL + '  CTR_CTABAI = :CTABAI, ';
    strSQL := strSQL + '  CTR_OPEBAI = :OPEBAI, ';
    strSQL := strSQL + '  CTR_DTABAI = ' + fCurrentDate + ', ';
    strSQL := strSQL + '  CTR_EMPBAI = :EMPBAI, ';
    strSQL := strSQL + '  CTR_CHQPRE = :CHQPRE, ';
    strSQL := strSQL + '  CTR_CHQAVI = :CHQAVI, ';
    strSQL := strSQL + '  CTR_DINHEI = :DINHEI, ';
    strSQL := strSQL + '  CTR_CARTAO = :CARTAO, ';
    strSQL := strSQL + '  CTR_ORDPAG = :ORDPAG, ';
    strSQL := strSQL + '  CTR_VALFIN = :VALFIN, ';
    strSQL := strSQL + '  CTR_RECDIN = :RECDIN, ';
    strSQL := strSQL + '  CTR_RECCHE = :RECCHE, ';
    strSQL := strSQL + '  CTR_RECPRE = :RECPRE, ';
    strSQL := strSQL + '  CTR_RECCAR = :RECCAR, ';
    strSQL := strSQL + '  CTR_RECORD = :RECORD, ';
    strSQL := strSQL + '  CTR_RECFIN = :RECFIN, ';

    If Not fEmptyStr(strId_Loc) Then
      strSQL := strSQL + '  CTR_ID_LOC = :ID_LOC, ';

    If Not fEmptyStr(strId_Doc) Then
      strSQL := strSQL + '  CTR_ID_DOC = :ID_DOC, ';

    strSQL := strSQL + '  CTR_SEQMOD = :SEQMOD, ';
    strSQL := strSQL + '  CTR_RESCAI = :RESCAI, ';
    strSQL := strSQL + '  CTR_SEQCON = :SEQCON, ';
    strSQL := strSQL + '  CTR_VALIPI = :VALIPI, ';
    strSQL := strSQL + '  CTR_VALRET = :VALRET, ';
    strSQL := strSQL + '  CTR_VALFCP = :VALFCP, ';
    strSQL := strSQL + '  CTR_VALCBS = :VALCBS, ';
    strSQL := strSQL + '  CTR_VALIBS = :VALIBS, ';
    strSQL := strSQL + '  CTR_VAL_IS = :VAL_IS, ';
    strSQL := strSQL + '  CTR_VALACE = :VALACE, ';
    strSQL := strSQL + '  CTR_VALFRE = :VALFRE, ';
    strSQL := strSQL + '  CTR_DIFORI = :DIFORI, ';
    strSQL := strSQL + '  CTR_NOSNUM = :NOSNUM, ';
    strSQL := strSQL + '  CTR_ID_BOL =  NULL, ';
    strSQL := strSQL + '  CTR_RECAUT = :RECAUT, ';
    strSQL := strSQL + '  CTR_JURBAI = :JURBAI, ';
    strSQL := strSQL + '  CTR_AMORTI = :AMORTI, ';
    strSQL := strSQL + '  CTR_VALCOR = :VALANT + IF(:VALANT > 0, :DIFORI, 0) + :VALCOR, ';
    strSQL := strSQL + '  CTR_DESBAI = :DESBAI, ';
    strSQL := strSQL + '  CTR_SEQFCO = :SEQFCO, ';
    strSQL := strSQL + '  CTR_DTABAN = :DTABAN, ';
    strSQL := strSQL + '  CTR_VALCAL = :VALCAL, ';
    strSQL := strSQL + '  CTR_JURCAL = :JURCAL, ';
    strSQL := strSQL + '  CTR_DESCAL = :DESCAL, ';
    strSQL := strSQL + '  CTR_FATDUP = :FATDUP, ';
    strSQL := strSQL + '  CTR_FATJUR = :FATJUR, ';
    strSQL := strSQL + '  CTR_NOVBAI = "S",      ';
    strSQL := strSQL + '  CTR_RECPIX = :RECPIX, ';

    //Limpando campos do Pix
    strSQL := strSQL + '  CTR_PIXTIP=NULL,      ';
    strSQL := strSQL + '  CTR_PIXREC=NULL,      ';
    strSQL := strSQL + '  CTR_PIXJUR=NULL,      ';
    strSQL := strSQL + '  CTR_PIXDES=NULL,      ';
    strSQL := strSQL + '  CTR_PIXCOB=NULL,      ';
    strSQL := strSQL + '  CTR_PIXCOR=NULL       ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  ( (CTR_DTAREC IS NULL) OR (CTR_SEQBAI = 0 AND IFNULL(CTR_ID_DOC, "") <> "") ) ';

    With qryGenTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      {*****************************************}
      {* DADOS QUE SERO ALTERADOS             *}
      {**************************************MV*}
      ParamByName('VALREC').AsFloat    := fltValRec;
      ParamByName('DTAREC').AsDateTime := dtaDtaRec;
      ParamByName('PORBAI').AsString   := strPorBai;
      ParamByName('SEQBAI').AsInteger  := intSeqBai;

      ParamByName('HIST01').AsString   := strHist01;
      If fCfgSis('HISBAI', varBoolean) Then
      Begin
        ParamByName('HIST01').AsString := ParamByName('HIST01').AsString +
                                          IIF(strHist01.IsEmpty, '', #13) +
                                          strHisBai;
      End;

      ParamByName('HISBAI').AsString   := strHisBai;
      ParamByName('DOCBAI').AsString   := strSeqLan;
      ParamByName('CTABAI').AsString   := strCtaBai;
      ParamByName('OPEBAI').AsString   := strOpeBai;
      ParamByName('EMPBAI').AsString   := IIF(Not fEmptyStr(strEmpBai), strEmpBai, VS_strCodEmp);
      ParamByName('CHQPRE').AsFloat    := fltValCqP;
      ParamByName('CHQAVI').AsFloat    := fltValCqV;
      ParamByName('DINHEI').AsFloat    := fltValDin;
      ParamByName('CARTAO').AsFloat    := fltValCar;
      ParamByName('ORDPAG').AsFloat    := fltValOrd;
      ParamByName('VALFIN').AsFloat    := fltValFin;
      ParamByName('RESCAI').AsInteger  := intResCai;

      If blnRecDin Then
        ParamByName('RECDIN').AsString := 'S'
      Else
        ParamByName('RECDIN').AsString := 'N';

      If blnRecCqV Then
        ParamByName('RECCHE').AsString := 'S'
      Else
        ParamByName('RECCHE').AsString := 'N';

      If blnRecCqP Then
        ParamByName('RECPRE').AsString := 'S'
      Else
        ParamByName('RECPRE').AsString := 'N';

      If blnRecCar Then
        ParamByName('RECCAR').AsString := 'S'
      Else
        ParamByName('RECCAR').AsString := 'N';

      If blnRecOrd Then
        ParamByName('RECORD').AsString := 'S'
      Else
        ParamByName('RECORD').AsString := 'N';

      If blnRecFin Then
        ParamByName('RECFIN').AsString := 'S'
      Else
        ParamByName('RECFIN').AsString := 'N';

      If Not fEmptyStr(strId_Loc) Then
        ParamByName('ID_LOC').AsString := strId_Loc;

      If Not fEmptyStr(strId_Doc) Then
        ParamByName('ID_DOC').AsString := strId_Doc;

      If intSeqMod = 0 Then
        ParamByName('SEQMOD').Value := Null
      Else
        ParamByName('SEQMOD').AsInteger := intSeqMod;

      If fEmptyStr(strAutincMovGerFC) Then
        ParamByName('SEQFCO').Value    := Null
      Else
        ParamByName('SEQFCO').AsString := strAutincMovGerFC;

      ParamByName('SEQCON').AsInteger := intSeqCon;

      ParamByName('RECPIX').AsString := strRecPix;


      ParamByName('VALCAL').AsFloat := AValorCorrigido;
      ParamByName('JURCAL').AsFloat := fFormataFloat(fltValJur + ANovoJurSuj, 2);
      ParamByName('DESCAL').AsFloat := fFormataFloat(fltValDes + ANovoDesSuj, 2);
      ParamByName('FATDUP').AsFloat := AFatorDuplicata;
      ParamByName('FATJUR').AsFloat := AFatorJuros;
      ParamByName('VALORI').AsFloat := AValorBaixadoDuplicata;
      ParamByName('VALJUR').AsFloat := fltValJur;
      ParamByName('VALDES').AsFloat := fltValDes;
      ParamByName('VALCOB').AsFloat := ADespesasBaixaDuplicata;


      // Calcula a proporção do imposto
      Try
        fltProporcaoImposto := (fltValRec - fltValJur + fltValDes) / (fltNovoValDup + fltValRec - fltValJur + fltValDes);
      Except
        fltProporcaoImposto := 0;
      End;

      fltValIpi_prop := fltValIpi * fltProporcaoImposto;
      fltValRet_prop := fltValRet * fltProporcaoImposto;
      fltValAce_prop := fltValAce * fltProporcaoImposto;
      fltValFre_prop := fltValFre * fltProporcaoImposto;
      fltValFCP_prop := fltValFCP * fltProporcaoImposto;
      fltValCBS_prop := fltValCBS * fltProporcaoImposto;
      fltValIBS_prop := fltValIBS * fltProporcaoImposto;
      fltVal_IS_prop := fltVal_IS * fltProporcaoImposto;

      ParamByName('VALIPI').AsFloat := fltValIpi_prop;
      ParamByName('VALRET').AsFloat := fltValRet_prop;
      ParamByName('VALACE').AsFloat := fltValAce_prop;
      ParamByName('VALFRE').AsFloat := fltValFre_prop;
      ParamByName('VALFCP').AsFloat := fltValFCP_prop;
      ParamByName('VALCBS').AsFloat := fltValCBS_prop;
      ParamByName('VALIBS').AsFloat := fltValIBS_prop;
      ParamByName('VAL_IS').AsFloat := fltVal_IS_prop;

      ParamByName('DIFORI').AsFloat := fltDifOri;

      ParamByName('NOSNUM').Value    := Null;
      ParamByName('RECAUT').AsString := strRecAut;
      //ParamByName('NOVDUP').AsFloat    := fltNovoValDup;
      ParamByName('VALANT').AsFloat := qryGenCtr.FieldByName('CTR_VALDUP').AsFloat;

      ParamByName('JURBAI').AsFloat := 0.00;
      If (qryGenCtr.FieldByName('CTR_VALDUP').AsFloat > 0) And
         (fltDifOri + fltSobraDeJuros + qryGenCtr.FieldByName('CTR_JURSUJ').AsFloat <> 0) Then
        ParamByName('JURBAI').AsFloat := fFormataFloat(fltSobraDeJuros + fltDifOri + qryGenCtr.FieldByName('CTR_JURSUJ').AsFloat, 2);

      fltDescontoAteVencimento := 0.00;
      If (fCfgSis('UTDEFN', varString) = '1') Or
         ((fCfgSis('UTDEFN', varString) = '2') And
          (VS_Date <= qryGenCtr.FieldByName('CTR_DTAVEN').AsDateTime)) Then
        fltDescontoAteVencimento := qryGenCtr.FieldByName('CTR_DESSUJ').AsFloat;

      ParamByName('AMORTI').AsFloat := 0.00;
      If fltValRec > (fltDifOri + fltSobraDeJuros + qryGenCtr.FieldByName('CTR_JURSUJ').AsFloat + qryGenCtr.FieldByName('CTR_DESCOB').AsFloat - fltDescontoAteVencimento) Then
        ParamByName('AMORTI').AsFloat := fFormataFloat(fltValRec - (fltDifOri + fltSobraDeJuros + qryGenCtr.FieldByName('CTR_JURSUJ').AsFloat + qryGenCtr.FieldByName('CTR_DESCOB').AsFloat - fltDescontoAteVencimento), 2)
      Else If qryGenCtr.FieldByName('CTR_VALDUP').AsFloat < 0 Then
        ParamByName('AMORTI').AsFloat := fFormataFloat(fltValRec, 2);

      ParamByName('VALCOR').AsFloat := qryGenCtr.FieldByName('CTR_JURSUJ').AsFloat + qryGenCtr.FieldByName('CTR_DESCOB').AsFloat - fltDescontoAteVencimento;
      ParamByName('DESBAI').AsFloat := fltDescontoAteVencimento;

      if dtaMovimentacaoBancaria = 0 then
        ParamByName('DTABAN').Value := Null
      else
        ParamByName('DTABAN').AsDateTime := dtaMovimentacaoBancaria;

      {*****************************************}
      {* DADOS REFERENTES AO FILTRO            *}
      {**************************************MV*}
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;

      ExecSQL;
      Close;

      {*********************************}
      {* GRAVAR TABELA DO SISTEMA DEPS *}
      {******************************AJ*}
      If fCfgSis('USADEP') = 'S' Then
        TValidacoesSistemaDEPS.pGravaLancamentoSistemaDEPS(Concat(strNumDup, '-',
                                                                  strParcel, '-',
                                                                  strEspDoc, '-',
                                                                  strCodEmp, '-',
                                                                  strCodCli, '-',
                                                                  intSeqBai.ToString),
                                                           'BAIXA');
    End;

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO CADREC (';
    strSQL := strSQL + '  CTR_CODVEN, ';
    strSQL := strSQL + '  CTR_CODREP, ';
    strSQL := strSQL + '  CTR_CODDIG, ';
    strSQL := strSQL + '  CTR_CODPOR, ';
    strSQL := strSQL + '  CTR_CODCLI, ';
    strSQL := strSQL + '  CTR_NUMDUP, ';
    strSQL := strSQL + '  CTR_PARCEL, ';
    strSQL := strSQL + '  CTR_SEQBAI, ';
    strSQL := strSQL + '  CTR_ESPDOC, ';
    strSQL := strSQL + '  CTR_DTACAD, ';
    strSQL := strSQL + '  CTR_DTAVEN, ';
    strSQL := strSQL + '  CTR_VALDUP, ';
    strSQL := strSQL + '  CTR_VALORI, ';
    strSQL := strSQL + '  CTR_DESCOB, ';
    strSQL := strSQL + '  CTR_DESCON, ';
    strSQL := strSQL + '  CTR_HIST01, ';
    strSQL := strSQL + '  CTR_HIST02, ';
    strSQL := strSQL + '  CTR_PORBAI, ';
    strSQL := strSQL + '  CTR_HISBAI, ';
    strSQL := strSQL + '  CTR_DOCBAI, ';
    strSQL := strSQL + '  CTR_DTAREC, ';
    strSQL := strSQL + '  CTR_VALREC, ';
    strSQL := strSQL + '  CTR_VALJUR, ';
    strSQL := strSQL + '  CTR_VALDES, ';
    strSQL := strSQL + '  CTR_RESCAI, ';
    strSQL := strSQL + '  CTR_NOSNUM, ';
    strSQL := strSQL + '  CTR_ID_BOL, ';
    strSQL := strSQL + '  CTR_BCOBOL, ';
    strSQL := strSQL + '  CTR_BCOENV, ';
    strSQL := strSQL + '  CTR_DTAENV, ';
    strSQL := strSQL + '  CTR_CODEMP, ';
    strSQL := strSQL + '  CTR_EMPBAI, ';
    strSQL := strSQL + '  CTR_CTABAI, ';
    strSQL := strSQL + '  CTR_OPEBAI, ';
    strSQL := strSQL + '  CTR_DTABAI, ';
    strSQL := strSQL + '  CTR_ADTCLI, ';
    strSQL := strSQL + '  CTR_CODEVE, ';
    strSQL := strSQL + '  CTR_CODCND, ';
    strSQL := strSQL + '  CTR_FATCOM, ';
    strSQL := strSQL + '  CTR_FATREP, ';
    strSQL := strSQL + '  CTR_BARCON, ';
    strSQL := strSQL + '  CTR_DTABOL, ';
    strSQL := strSQL + '  CTR_VALIPI, ';
    strSQL := strSQL + '  CTR_VALRET, ';
    strSQL := strSQL + '  CTR_VALFCP, ';
    strSQL := strSQL + '  CTR_VALCBS, ';
    strSQL := strSQL + '  CTR_VALIBS, ';
    strSQL := strSQL + '  CTR_VAL_IS, ';
    strSQL := strSQL + '  CTR_VALACE, ';
    strSQL := strSQL + '  CTR_VALFRE, ';
    strSQL := strSQL + '  CTR_DIFORI, ';
    strSQL := strSQL + '  CTR_PERDPO, ';

    strSQL := strSQL + '  CTR_DOCDIV, ';
    strSQL := strSQL + '  CTR_ESPDIV, ';
    strSQL := strSQL + '  CTR_EMPDIV, ';
    strSQL := strSQL + '  CTR_CLIDIV, ';
    strSQL := strSQL + '  CTR_COMDIV, ';
    strSQL := strSQL + '  CTR_FATDIV, ';
    strSQL := strSQL + '  CTR_CODDIV, ';

    strSQL := strSQL + '  CTR_ID_LOC, ';
    strSQL := strSQL + '  CTR_ID_DOC, ';
    strSQL := strSQL + '  CTR_RECAUT, ';
    strSQL := strSQL + '  CTR_VALANT, ';
    strSQL := strSQL + '  CTR_GRVORI, ';
    strSQL := strSQL + '  CTR_VALCOM, ';
    strSQL := strSQL + '  AUTOINCREM, ';
    strSQL := strSQL + '  CTR_JURSUJ, ';
    strSQL := strSQL + '  CTR_PERMOR, ';
    strSQL := strSQL + '  CTR_PERMUL, ';
    strSQL := strSQL + '  CTR_DESSUJ, ';
    strSQL := strSQL + '  CTR_JURANT, ';
    strSQL := strSQL + '  CTR_DESANT, ';
    strSQL := strSQL + '  CTR_COBANT, ';
    strSQL := strSQL + '  CTR_CARTEI, ';
    strSQL := strSQL + '  CTR_SBANCC, ';
    strSQL := strSQL + '  CTR_DTASER, ';
    strSQL := strSQL + '  CTR_CODCTA, ';
    strSQL := strSQL + '  CTR_EMPORI, ';
    strSQL := strSQL + '  CTR_EMP_PD, ';
    strSQL := strSQL + '  CTR_DTAEMA, ';
    strSQL := strSQL + '  CTR_DTASMS, ';
    strSQL := strSQL + '  CTR_SEQMPX, ';
    strSQL := strSQL + '  CTR_CODPRJ) ';
    strSQL := strSQL + 'VALUES ( ';
    strSQL := strSQL + '  :CODVEN, ';
    strSQL := strSQL + '  :CODREP, ';
    strSQL := strSQL + '  :CODDIG, ';
    strSQL := strSQL + '  :CODPOR, ';
    strSQL := strSQL + '  :CODCLI, ';
    strSQL := strSQL + '  :NUMDUP, ';
    strSQL := strSQL + '  :PARCEL, ';
    strSQL := strSQL + '  :SEQBAI, ';
    strSQL := strSQL + '  :ESPDOC, ';
    strSQL := strSQL + '  :DTACAD, ';
    strSQL := strSQL + '  :DTAVEN, ';
    strSQL := strSQL + '  :VALDUP, ';
    strSQL := strSQL + '  :VALORI, ';
    strSQL := strSQL + '  :DESCOB, ';
    strSQL := strSQL + '  :DESCON, ';
    strSQL := strSQL + '  :HIST01, ';
    strSQL := strSQL + '  :HIST02, ';
    strSQL := strSQL + '  :PORBAI, ';
    strSQL := strSQL + '  :HISBAI, ';
    strSQL := strSQL + '  :DOCBAI, ';
    strSQL := strSQL + '  :DTAREC, ';
    strSQL := strSQL + '  :VALREC, ';
    strSQL := strSQL + '  :VALJUR, ';
    strSQL := strSQL + '  :VALDES, ';
    strSQL := strSQL + '  :RESCAI, ';
    strSQL := strSQL + '  :NOSNUM, ';
    strSQL := strSQL + '  :ID_BOL, ';
    strSQL := strSQL + '  :BCOBOL, ';
    strSQL := strSQL + '  :BCOENV, ';
    strSQL := strSQL + '  :DTAENV, ';
    strSQL := strSQL + '  :CODEMP, ';
    strSQL := strSQL + '  :EMPBAI, ';
    strSQL := strSQL + '  :CTABAI, ';
    strSQL := strSQL + '  :OPEBAI, ';
    strSQL := strSQL + '  :DTABAI, ';
    strSQL := strSQL + '  :ADTCLI, ';
    strSQL := strSQL + '  :CODEVE, ';
    strSQL := strSQL + '  :CODCND, ';
    strSQL := strSQL + '  :FATCOM, ';
    strSQL := strSQL + '  :FATREP, ';
    strSQL := strSQL + '  :BARCON, ';
    strSQL := strSQL + '  :DTABOL, ';
    strSQL := strSQL + '  :VALIPI, ';
    strSQL := strSQL + '  :VALRET, ';
    strSQL := strSQL + '  :VALFCP, ';
    strSQL := strSQL + '  :VALCBS, ';
    strSQL := strSQL + '  :VALIBS, ';
    strSQL := strSQL + '  :VAL_IS, ';
    strSQL := strSQL + '  :VALACE, ';
    strSQL := strSQL + '  :VALFRE, ';
    strSQL := strSQL + '  :DIFORI, ';
    strSQL := strSQL + '  :PERDPO, ';

    strSQL := strSQL + '  :DOCDIV, ';
    strSQL := strSQL + '  :ESPDIV, ';
    strSQL := strSQL + '  :EMPDIV, ';
    strSQL := strSQL + '  :CLIDIV, ';
    strSQL := strSQL + '  :COMDIV, ';
    strSQL := strSQL + '  :FATDIV, ';
    strSQL := strSQL + '  :CODDIV, ';

    strSQL := strSQL + '  :ID_LOC, ';
    strSQL := strSQL + '  :ID_DOC, ';
    strSQL := strSQL + '  :RECAUT, ';
    strSQL := strSQL + '  :VALANT, ';
    strSQL := strSQL + '  :GRVORI, ';
    strSQL := strSQL + '  :VALCOM, ';
    strSQL := strSQL + '  :AUTINC, ';
    strSQL := strSQL + '  :JURSUJ, ';
    strSQL := strSQL + '  :PERMOR, ';
    strSQL := strSQL + '  :PERMUL, ';
    strSQL := strSQL + '  :DESSUJ, ';
    strSQL := strSQL + '  :JURANT, ';
    strSQL := strSQL + '  :DESANT, ';
    strSQL := strSQL + '  :COBANT, ';
    strSQL := strSQL + '  :CARTEI, ';
    strSQL := strSQL + '  :SBANCC, ';
    strSQL := strSQL + '  :DTASER, ';
    strSQL := strSQL + '  :CODCTA, ';
    strSQL := strSQL + '  :EMPORI, ';
    strSQL := strSQL + '  :EMP_PD, ';
    strSQL := strSQL + '  :DTAEMA, ';
    strSQL := strSQL + '  :DTASMS, ';
    strSQL := strSQL + '  :SEQMPX, ';
    strSQL := strSQL + '  :CODPRJ) ';

    {*****************************************}
    {* GRAVA NOVA DUPLICATA                  *}
    {**************************************MV*}
    With qryGenDup Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('CODVEN').AsString   := qryGenCtr.FieldByName('CTR_CODVEN').AsString;
      ParamByName('CODDIG').AsString   := qryGenCtr.FieldByName('CTR_CODDIG').AsString;

      If fEmptyStr(qryGenCtr.FieldByName('CTR_CODREP').AsString) Then
        ParamByName('CODREP').Value := Null
      Else
        ParamByName('CODREP').AsString := qryGenCtr.FieldByName('CTR_CODREP').AsString;

      If fEmptyStr(ParamByName('CODDIG').AsString) Then
        ParamByName('CODDIG').AsString := ParamByName('CODVEN').AsString;

      If fEmptyStr(qryGenCtr.FieldByName('CTR_CODPOR').AsString) Then
        ParamByName('CODPOR').Value := Null
      Else
        ParamByName('CODPOR').AsString := qryGenCtr.FieldByName('CTR_CODPOR').AsString;

      ParamByName('CODCLI').AsString   := qryGenCtr.FieldByName('CTR_CODCLI').AsString;
      ParamByName('NUMDUP').AsString   := qryGenCtr.FieldByName('CTR_NUMDUP').AsString;
      ParamByName('PARCEL').AsString   := qryGenCtr.FieldByName('CTR_PARCEL').AsString;
      ParamByName('SEQBAI').AsInteger  := 0;
      ParamByName('ESPDOC').AsString   := qryGenCtr.FieldByName('CTR_ESPDOC').AsString;
      ParamByName('DTACAD').AsDateTime := qryGenCtr.FieldByName('CTR_DTACAD').AsDateTime;
      ParamByName('DTAVEN').AsDateTime := dtaDtaVen;
      ParamByName('VALDUP').AsFloat    := fltNovoValDup;
      ParamByName('VALORI').AsFloat    := qryGenCtr.FieldByName('CTR_VALORI').AsFloat; //fltNovoValOri; não mudar se mudar falar com alexandre
      ParamByName('DESCON').AsString   := qryGenCtr.FieldByName('CTR_DESCON').AsString;
      ParamByName('VALCOM').AsFloat    := qryGenCtr.FieldByName('CTR_VALCOM').AsFloat;

      ParamByName('EMP_PD').Value   := Null;
      If Not fEmptyStr(qryGenCtr.FieldByName('CTR_EMP_PD').AsString) Then
        ParamByName('EMP_PD').AsString := qryGenCtr.FieldByName('CTR_EMP_PD').AsString;

      ParamByName('HIST01').AsString   := qryGenCtr.FieldByName('CTR_HIST01').AsString +
                                          ' - PAGTO.PARCIAL - DTA. REC.: ' +
                                          FormatDateTime('dd/mm/yyyy', dtaDtaRec) +
                                          ' - VR. ORIGINAL: ' +
                                          FormatFloat('#,##0.00', fltNovoValOri) +
                                          ' - VR. PAGO: ' +
                                          FormatFloat('#,##0.00', fltValRec);

      ParamByName('HIST02').AsString   := qryGenCtr.FieldByName('CTR_HIST02').AsString;
      ParamByName('PORBAI').AsString   := '';
      ParamByName('PORBAI').Clear;
      ParamByName('HISBAI').AsString   := '';
      ParamByName('DOCBAI').AsString   := '';

      If (fEmptyStr(qryGenCtr.FieldByName('CTR_DTAREC').AsString))     Or
         (Not fEmptyStr(qryGenCtr.FieldByName('CTR_ID_LOC').AsString)) Then
      Begin
        ParamByName('DTAREC').Value := Null;
        ParamByName('DTABAI').Value := Null;
      End
      Else
      Begin
        ParamByName('DTAREC').AsDateTime := qryGenCtr.FieldByName('CTR_DTAREC').AsDateTime;
        ParamByName('DTABAI').AsDateTime := VS_Date;
      End;

      If (Not fEmptyStr(qryGenCtr.FieldByName('CTR_ID_LOC').AsString)) Then
      Begin
        ParamByName('VALREC').Value := Null;
        ParamByName('ID_LOC').AsString := qryGenCtr.FieldByName('CTR_ID_LOC').AsString;
        ParamByName('ID_DOC').AsString := qryGenCtr.FieldByName('CTR_ID_DOC').AsString;
      End
      Else
      Begin
        ParamByName('VALREC').AsFloat  := qryGenCtr.FieldByName('CTR_VALREC').AsFloat;
        ParamByName('ID_LOC').Value := Null;
        ParamByName('ID_DOC').Value := Null;
      End;

      ParamByName('VALJUR').AsFloat    := qryGenCtr.FieldByName('CTR_VALJUR').AsFloat;
      ParamByName('VALDES').AsFloat    := qryGenCtr.FieldByName('CTR_VALDES').AsFloat;
      ParamByName('RESCAI').AsInteger  := 0;

      ParamByName('DIFORI').AsFloat    := qryGenCtr.FieldByName('CTR_DIFORI').AsFloat + fltDifOri;
      ParamByName('PERDPO').AsFloat    := qryGenCtr.FieldByName('CTR_PERDPO').AsFloat;

      If fEmptyStr(qryGenCtr.FieldByName('CTR_NOSNUM').AsString) Then
      ParamByName('NOSNUM').Value    := Null
      Else
        ParamByName('NOSNUM').AsString := qryGenCtr.FieldByName('CTR_NOSNUM').AsString;

      ParamByName('ID_BOL').Value    := Null;
      If Not fEmptyStr(qryGenCtr.FieldByName('CTR_ID_BOL').AsString) Then
        ParamByName('ID_BOL').AsString := qryGenCtr.FieldByName('CTR_ID_BOL').AsString;

      If fEmptyStr(qryGenCtr.FieldByName('CTR_DTASER').AsString) Then
        ParamByName('DTASER').Value := Null
      Else
        ParamByName('DTASER').AsDateTime := qryGenCtr.FieldByName('CTR_DTASER').AsDateTime;

      If fEmptyStr(qryGenCtr.FieldByName('CTR_DTABOL').AsString) Then
      ParamByName('DTABOL').Value := Null
      Else
        ParamByName('DTABOL').AsDateTime := qryGenCtr.FieldByName('CTR_DTABOL').AsDateTime;

      If fEmptyStr(qryGenCtr.FieldByName('CTR_BCOBOL').AsString) Then
        ParamByName('BCOBOL').Value    := Null
      Else
        ParamByName('BCOBOL').AsString := qryGenCtr.FieldByName('CTR_BCOBOL').AsString;

      If fEmptyStr(qryGenCtr.FieldByName('CTR_BCOENV').AsString) Then
        ParamByName('BCOENV').Value    := Null
      Else
        ParamByName('BCOENV').AsString := qryGenCtr.FieldByName('CTR_BCOENV').AsString;

      If fEmptyStr(qryGenCtr.FieldByName('CTR_DTAENV').AsString) Then
        ParamByName('DTAENV').Value := Null
      Else
        ParamByName('DTAENV').AsDateTime := qryGenCtr.FieldByName('CTR_DTAENV').AsDateTime;

      ParamByName('CODEMP').AsString   := qryGenCtr.FieldByName('CTR_CODEMP').AsString;

      strAutIncNov := fRetAutoIncrem('CADREC', qryGenCtr.FieldByName('CTR_CODEMP').AsString);

      ParamByName('RECAUT').AsString := strRecAut;

      ParamByName('AUTINC').AsString   := strAutIncNov;

      ParamByName('EMPBAI').AsString   := '';
      ParamByName('EMPBAI').Clear;
      ParamByName('CTABAI').AsString   := '';
      ParamByName('CTABAI').Clear;
      ParamByName('OPEBAI').AsString   := '';
      ParamByName('OPEBAI').Clear;

      ParamByName('ADTCLI').AsString   := qryGenCtr.FieldByName('CTR_ADTCLI').AsString;

      If fEmptyStr(qryGenCtr.FieldByName('CTR_CODEVE').AsString) Then
        ParamByName('CODEVE').Value := Null
      Else
        ParamByName('CODEVE').AsString   := qryGenCtr.FieldByName('CTR_CODEVE').AsString;

      If fEmptyStr(qryGenCtr.FieldByName('CTR_CODCND').AsString) Then
        ParamByName('CODCND').Value := Null
      Else
        ParamByName('CODCND').AsString   := qryGenCtr.FieldByName('CTR_CODCND').AsString;

      ParamByName('FATCOM').AsFloat    := Abs(IIF(qryGenCtr.FieldByName('CTR_FATCOM').AsFloat < 0, qryGenCtr.FieldByName('CTR_FATCOM').AsFloat * -1, qryGenCtr.FieldByName('CTR_FATCOM').AsFloat));
      ParamByName('FATREP').AsFloat    := Abs(IIF(qryGenCtr.FieldByName('CTR_FATREP').AsFloat < 0, qryGenCtr.FieldByName('CTR_FATREP').AsFloat * -1, qryGenCtr.FieldByName('CTR_FATREP').AsFloat));

      If fEmptyStr(qryGenCtr.FieldByName('CTR_BARCON').AsString) Then
        ParamByName('BARCON').Value := Null
      Else
        ParamByName('BARCON').AsString   := qryGenCtr.FieldByName('CTR_BARCON').AsString;

      If fEmptyStr(qryGenCtr.FieldByName('CTR_DOCDIV').AsString) Then
        ParamByName('DOCDIV').Value := Null
      Else
        ParamByName('DOCDIV').AsString := qryGenCtr.FieldByName('CTR_DOCDIV').AsString;

      If fEmptyStr(qryGenCtr.FieldByName('CTR_ESPDIV').AsString) Then
        ParamByName('ESPDIV').Value := Null
      Else
        ParamByName('ESPDIV').AsString := qryGenCtr.FieldByName('CTR_ESPDIV').AsString;

      If fEmptyStr(qryGenCtr.FieldByName('CTR_EMPDIV').AsString) Then
        ParamByName('EMPDIV').Value := Null
      Else
        ParamByName('EMPDIV').AsString := qryGenCtr.FieldByName('CTR_EMPDIV').AsString;

      If fEmptyStr(qryGenCtr.FieldByName('CTR_CLIDIV').AsString) Then
        ParamByName('CLIDIV').Value := Null
      Else
        ParamByName('CLIDIV').AsString := qryGenCtr.FieldByName('CTR_CLIDIV').AsString;

      ParamByName('COMDIV').AsFloat  := qryGenCtr.FieldByName('CTR_COMDIV').AsFloat;
      ParamByName('FATDIV').AsFloat  := qryGenCtr.FieldByName('CTR_FATDIV').AsFloat;

      If fEmptyStr(qryGenCtr.FieldByName('CTR_CODDIV').AsString) Then
        ParamByName('CODDIV').Value := Null
      Else
        ParamByName('CODDIV').AsString := qryGenCtr.FieldByName('CTR_CODDIV').AsString;

      ParamByName('VALIPI').AsFloat := fltValIpi - fltValIpi_prop;
      ParamByName('VALRET').AsFloat := fltValRet - fltValRet_prop;
      ParamByName('VALACE').AsFloat := fltValAce - fltValAce_prop;
      ParamByName('VALFRE').AsFloat := fltValFre - fltValFre_prop;
      ParamByName('VALFCP').AsFloat := fltValFCP - fltValFCP_prop;
      ParamByName('VALCBS').AsFloat := fltValCBS - fltValCBS_prop;
      ParamByName('VALIBS').AsFloat := fltValIBS - fltValIBS_prop;
      ParamByName('VAL_IS').AsFloat := fltVal_IS - fltVal_IS_prop;
      ParamByName('VALANT').AsFloat := qryGenCtr.FieldByName('CTR_VALDUP').AsFloat;

      If fltGrvOri <> 0 Then
        ParamByName('GRVORI').AsFloat := fltGrvOri
      Else
        ParamByName('GRVORI').AsFloat := qryGenCtr.FieldByName('CTR_GRVORI').AsFloat;

      ParamByName('JURANT').AsFloat := qryGenCtr.FieldByName('CTR_JURSUJ').AsFloat;
      ParamByName('PERMOR').AsFloat := qryGenCtr.FieldByName('CTR_PERMOR').AsFloat;
      ParamByName('PERMUL').AsFloat := qryGenCtr.FieldByName('CTR_PERMUL').AsFloat;
      ParamByName('DESANT').AsFloat := qryGenCtr.FieldByName('CTR_DESSUJ').AsFloat;
      ParamByName('DESCOB').AsFloat := ADespesasNovaDuplicata;
      ParamByName('COBANT').AsFloat := qryGenCtr.FieldByName('CTR_DESCOB').AsFloat;
      ParamByName('CARTEI').AsString := qryGenCtr.FieldByName('CTR_CARTEI').AsString;

      ParamByName('SBANCC').Value := Null;
      If Not fEmptyStr(qryGenCtr.FieldByName('CTR_SBANCC').AsString) Then
        ParamByName('SBANCC').AsString := qryGenCtr.FieldByName('CTR_SBANCC').AsString;

      ParamByName('DESSUJ').AsFloat := ANovoDesSuj;
      ParamByName('JURSUJ').AsFloat := ANovoJurSuj;

      If (fFormataFloat(AValorBaixadoDuplicata, 2) <> 0) And (fCfgSis('MANVEN') = 'S') Then
      Begin
        ParamByName('JURSUJ').AsFloat := 0.00;
        ParamByName('DESSUJ').AsFloat := 0.00;
      End;

      If fEmptyStr(qryGenCtr.FieldByName('CTR_CODCTA').AsString) Then
        ParamByName('CODCTA').Value    := Null
      Else
        ParamByName('CODCTA').AsString := qryGenCtr.FieldByName('CTR_CODCTA').AsString;

      ParamByName('EMPORI').AsString  := IIF(fEmptyStr(qryGenCtr.FieldByName('CTR_EMPORI').AsString), strCodEmp, qryGenCtr.FieldByName('CTR_EMPORI').AsString);

      ParamByName('DTAEMA').Value := Null;
      If Not qryGenCtr.FieldByName('CTR_DTAEMA').AsString.IsEmpty Then
        ParamByName('DTAEMA').AsDateTime := qryGenCtr.FieldByName('CTR_DTAEMA').AsDateTime;

      ParamByName('DTASMS').Value := Null;
      If Not qryGenCtr.FieldByName('CTR_DTASMS').AsString.IsEmpty Then
        ParamByName('DTASMS').AsDateTime := qryGenCtr.FieldByName('CTR_DTASMS').AsDateTime;

      ParamByName('SEQMPX').Value   := qryGenCtr.FieldByName('CTR_SEQMPX').AsString;

      If fEmptyStr(qryGenCtr.FieldByName('CTR_CODPRJ').AsString) Then
        ParamByName('CODPRJ').Value    := Null
      Else
        ParamByName('CODPRJ').AsString := qryGenCtr.FieldByName('CTR_CODPRJ').AsString;

      ExecSQL;
      Close;
    End;

    AtualizarAutoIncremBOLCTR(qryGenCtr.FieldByName('AUTOINCREM').AsString,
                              strAutIncNov);

    FreeAndNil(qryGenCtr);
    FreeAndNil(qryGenDup);
    FreeAndNil(qryGenTmp);

    Result := TRUE;
  Except
    On E: Exception Do
    Begin
      FreeAndNil(qryGenCtr);
      FreeAndNil(qryGenDup);
      FreeAndNil(qryGenTmp);
      Raise Exception.Create(E.Message);
    End;
  End;

end;

Function fBaixaTotal(strNumDup,
                     strParcel,
                     strEspDoc,
                     strCodEmp,
                     strCodCli: String;
                     fltValDup,
                     fltValRec,
                     fltValJur,
                     fltValDes,
                     fltValCqP,
                     fltValCqV,
                     fltValDin,
                     fltValCar,
                     fltValOrd,
                     fltValFin: Double;
                     dtaDtaRec: TDateTime;
                     strSeqLan,
                     strHisBai,
                     strCtaBai,
                     strPorBai,
                     strOpeBai: String;
                     intSeqMod: Integer;
                     blnRecCqP,
                     blnRecCqV,
                     blnRecDin,
                     blnRecCar,
                     blnRecOrd,
                     blnRecFin: boolean;
                     intResCai: Integer;
                     intSeqCon: Integer;
                     dtaMovimentacaoBancaria : TDate;
                     strRecAut: String = 'N';
                     strEmpBai: String = '';
                     strId_Loc: String = '';
                     strId_Doc: String = '';
                     strAutCtp: String = '';
                     blnAutBan: Boolean = False;
                     fltValCob: Double = 0;
                     strBaiMan: String = 'N';
                     strRecPix: String = 'N';
                     strEnd_ID: String = '';
                     blnLimpaDadosPixBoleto: Boolean = False;
                     AChaveCarteiraBaixa: String = '';
                     AAtualizarBolCtr: Boolean = True): Boolean;
  Var
    strSQL   : String;
    qryGenRec: TUniQuery;
    qrySelPar: TUniQuery;

    fltSobraDeJuros: Double;
    LDuplicataBoleto: TDuplicataCtr;
begin
  qryGenRec := fCriaQuery;
  qrySelPar := fCriaQuery;

  Try
    {**************************************}
    {* SELECIONA PARCIAIS PARA DETERMINAR *}
    {* SE SERÁ ALTERADO O VALORI          *}
    {* SÓ AUTBAN, POR ENQUANTO            *}
    {***********************************AJ*}
    If blnAutBan Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT COALESCE(COUNT(CTR_SEQBAI), 0) AS QTD, ';
      strSQL := strSQL + ' SUM(COALESCE(CTR_VALORI, 0)) AS VALORI ';
      strSQL := strSQL + ' FROM CADREC ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
      strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
      strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
      strSQL := strSQL + '  CTR_SEQBAI > 0 ';

      With qrySelPar Do
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
    End;

    {**********************************}
    {* PEGA A SOBRA DE JUROS DE TODAS *}
    {* AS BAIXAS ANTERIORES PARA      *}
    {* CALCULAR AMORTIZAÇÃO           *}
    {*******************************AJ*}
    fltSobraDeJuros := 0;
    If fltValRec > 0 Then
      fltSobraDeJuros := fRetornaSobraDeJurosDeBaixasAnteriores(strNumDup,
                                                                strParcel,
                                                                strEspDoc,
                                                                strCodEmp,
                                                                strCodCli,
                                                                '0');

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CTR_VALANT = CTR_VALDUP, ';

    If blnAutBan Then
    Begin
      If (qrySelPar.FieldByName('QTD').AsInteger > 0) Then
        strSQL := strSQL + '  CTR_VALORI = CTR_VALORI - IF(:VALORI > 0, :VALORI, (:VALORI) * (-1)), ';
    End
    Else
      strSQL := strSQL + '  CTR_VALORI = :VALORI, ';

    strSQL := strSQL + '  CTR_VALDUP = 0, ';
    strSQL := strSQL + '  CTR_JURANT = CTR_JURSUJ, ';
    strSQL := strSQL + '  CTR_DESANT = CTR_DESSUJ, ';
    strSQL := strSQL + '  CTR_COBANT = CTR_DESCOB, ';
    strSQL := strSQL + '  CTR_JURSUJ = 0, ';
    strSQL := strSQL + '  CTR_DESSUJ = 0, ';
    strSQL := strSQL + '  CTR_DESCOB = 0, ';
    strSQL := strSQL + '  CTR_DTAREC = :DTAREC, ';
    strSQL := strSQL + '  CTR_VALREC = :VALREC, ';
    strSQL := strSQL + '  CTR_VALDES = :VALDES, ';
    strSQL := strSQL + '  CTR_VALJUR = :VALJUR, ';
    strSQL := strSQL + '  CTR_VALCOB = :VALCOB, ';
    strSQL := strSQL + '  CTR_PORBAI = :PORBAI, ';
    strSQL := strSQL + '  CTR_HISBAI = :HISBAI, ';
    strSQL := strSQL + '  CTR_DOCBAI = :DOCBAI, ';
    strSQL := strSQL + '  CTR_CTABAI = :CTABAI, ';
    strSQL := strSQL + '  CTR_OPEBAI = :OPEBAI, ';
    strSQL := strSQL + '  CTR_DTABAI = ' + fCurrentDate + ', ';
    strSQL := strSQL + '  CTR_EMPBAI = :EMPBAI, ';
    strSQL := strSQL + '  CTR_CHQPRE = :CHQPRE, ';
    strSQL := strSQL + '  CTR_CHQAVI = :CHQAVI, ';
    strSQL := strSQL + '  CTR_DINHEI = :DINHEI, ';
    strSQL := strSQL + '  CTR_CARTAO = :CARTAO, ';
    strSQL := strSQL + '  CTR_ORDPAG = :ORDPAG, ';
    strSQL := strSQL + '  CTR_VALFIN = :VALFIN, ';
    strSQL := strSQL + '  CTR_RESCAI = :RESCAI, ';
    strSQL := strSQL + '  CTR_RECDIN = :RECDIN, ';
    strSQL := strSQL + '  CTR_RECCHE = :RECCHE, ';
    strSQL := strSQL + '  CTR_RECPRE = :RECPRE, ';
    strSQL := strSQL + '  CTR_RECCAR = :RECCAR, ';
    strSQL := strSQL + '  CTR_RECORD = :RECORD, ';
    strSQL := strSQL + '  CTR_RECFIN = :RECFIN, ';
    strSQL := strSQL + '  CTR_BAIMAN = :BAIMAN, ';

    If fCfgSis('HISBAI', varBoolean) Then
    Begin
      strSQL := strSQL + '  CTR_HIST01 = CONCAT(IFNULL(CTR_HIST01, ""), ';
      strSQL := strSQL + '                      IF(IFNULL(CTR_HIST01, "") = "", "", "\n"), ';
      strSQL := strSQL + '                      :HISBAI), ';
    End;

    If Not fEmptyStr(strId_Loc) Then
      strSQL := strSQL + '  CTR_ID_LOC = :ID_LOC, ';

    If Not fEmptyStr(strId_Doc) Then
      strSQL := strSQL + '  CTR_ID_DOC = :ID_DOC, ';

    if strAutCtp <> '' then
      strSQL := strSQL + '  CTR_AUTCTP = :AUTCTP, ';

    strSQL := strSQL + '  CTR_SEQMOD = :SEQMOD, ';
    strSQL := strSQL + '  CTR_SEQCON = :SEQCON, ';
    strSQL := strSQL + '  CTR_RECAUT = :RECAUT, ';
    strSQL := strSQL + '  CTR_JURBAI = :JURBAI, ';
    strSQL := strSQL + '  CTR_DESBAI = :DESBAI, ';
    strSQL := strSQL + '  CTR_AMORTI = :AMORTI, ';
    strSQL := strSQL + '  CTR_VALCOR = :VALCOR, ';
    strSQL := strSQL + '  CTR_DTABAN = :DTABAN, ';
    strSQL := strSQL + '  CTR_RECPIX = :RECPIX, ';
    strSQL := strSQL + '  CTR_END_ID = :END_ID, ';
    strSQL := strSQL + '  CTR_CARBAI = :CARBAI, ';

    If blnLimpaDadosPixBoleto Then
    Begin
      strSQL := strSQL + '  CTR_TX_BOL=NULL,    ';
      strSQL := strSQL + '  CTR_QRCODE=NULL,    ';
      strSQL := strSQL + '  CTR_LNKCIT=NULL,    ';
      strSQL := strSQL + '  CTR_PIXLOC=NULL,    ';
    End;

    //Limpando campos do Pix
    strSQL := strSQL + '  CTR_PIXTIP=NULL,      ';
    strSQL := strSQL + '  CTR_PIXREC=NULL,      ';
    strSQL := strSQL + '  CTR_PIXJUR=NULL,      ';
    strSQL := strSQL + '  CTR_PIXDES=NULL,      ';
    strSQL := strSQL + '  CTR_PIXCOB=NULL,      ';
    strSQL := strSQL + '  CTR_PIXCOR=NULL       ';

    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  CTR_SEQBAI = 0 ';

    With qryGenRec Do
    Begin

      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      {*****************************************}
      {* DADOS QUE SERAO ALTERADOS             *}
      {**************************************MV*}
      ParamByName('VALREC').AsFloat    := fltValRec;

      If blnAutBan Then
      Begin
        If (qrySelPar.FieldByName('QTD').AsInteger > 0) Then
          ParamByName('VALORI').AsFloat  := qrySelPar.FieldByName('VALORI').AsFloat;
      End
      Else
        ParamByName('VALORI').AsFloat    := fltValRec - fltValJur - fltValCob + fltValDes;

      ParamByName('DTAREC').AsDateTime := dtaDtaRec;
      ParamByName('VALDES').AsFloat    := fltValDes;
      ParamByName('VALJUR').AsFloat    := fltValJur;
      ParamByName('VALCOB').AsFloat    := fltValCob;
      ParamByName('PORBAI').AsString   := strPorBai;
      ParamByName('HISBAI').AsString   := strHisBai;
      ParamByName('DOCBAI').AsString   := strSeqLan;
      ParamByName('CTABAI').AsString   := strCtaBai;
      ParamByName('OPEBAI').AsString   := strOpeBai;
      ParamByName('EMPBAI').AsString   := IIF(Not fEmptyStr(strEmpBai), strEmpBai, VS_strCodEmp);
      ParamByName('CHQPRE').AsFloat    := fltValCqP;
      ParamByName('CHQAVI').AsFloat    := fltValCqV;
      ParamByName('DINHEI').AsFloat    := fltValDin;
      ParamByName('CARTAO').AsFloat    := fltValCar;
      ParamByName('ORDPAG').AsFloat    := fltValOrd;
      ParamByName('VALFIN').AsFloat    := fltValFin;
      ParamByName('RESCAI').AsInteger  := intResCai;
      ParamByName('BAIMAN').AsString   := strBaiMan;

      If blnRecDin Then
        ParamByName('RECDIN').AsString := 'S'
      Else
        ParamByName('RECDIN').AsString := 'N';

      If blnRecCqV Then
        ParamByName('RECCHE').AsString := 'S'
      Else
        ParamByName('RECCHE').AsString := 'N';

      If blnRecCqP Then
        ParamByName('RECPRE').AsString := 'S'
      Else
        ParamByName('RECPRE').AsString := 'N';

      If blnRecCar Then
        ParamByName('RECCAR').AsString := 'S'
      Else
        ParamByName('RECCAR').AsString := 'N';

      If blnRecOrd Then
        ParamByName('RECORD').AsString := 'S'
      Else
        ParamByName('RECORD').AsString := 'N';

      If blnRecFin Then
        ParamByName('RECFIN').AsString := 'S'
      Else
        ParamByName('RECFIN').AsString := 'N';

      If Not fEmptyStr(strId_Loc) Then
        ParamByName('ID_LOC').AsString := strId_Loc;

      If Not fEmptyStr(strId_Doc) Then
        ParamByName('ID_DOC').AsString := strId_Doc;

      If intSeqMod = 0 Then
        ParamByName('SEQMOD').Value := Null
      Else
        ParamByName('SEQMOD').AsInteger  := intSeqMod;

      if strAutCtp <> '' then
        ParamByName('AUTCTP').AsString := strAutCtp;

      ParamByName('SEQCON').AsInteger := intSeqCon;
      ParamByName('RECAUT').AsString := strRecAut;

      ParamByName('JURBAI').AsFloat := 0.00;
      If fltValJur + fltSobraDeJuros <> 0 Then
        ParamByName('JURBAI').AsFloat := fFormataFloat(fltSobraDeJuros + fltValJur, 2);

      ParamByName('DESBAI').AsFloat := 0.00;
      If fltValDes <> 0 Then
        ParamByName('DESBAI').AsFloat := fFormataFloat(fltValDes, 2);

      ParamByName('AMORTI').AsFloat := fFormataFloat(fltValRec - fltValJur - fltSobraDeJuros - fltValCob + fltValDes, 2);

      ParamByName('VALCOR').AsFloat := fltValDup + fltValJur + fltValCob - fltValDes;

      if dtaMovimentacaoBancaria = 0 then
        ParamByName('DTABAN').Value := Null
      else
        ParamByName('DTABAN').AsDateTime := dtaMovimentacaoBancaria;

      ParamByName('RECPIX').AsString := 'N';
      If Not strRecPix.IsEmpty Then
        ParamByName('RECPIX').AsString := strRecPix;

      ParamByName('END_ID').Value := Null;
      If Not strEnd_Id.IsEmpty Then
        ParamByName('END_ID').AsString := strEnd_Id;

      ParamByName('CARBAI').Value := Null;
      If Not AChaveCarteiraBaixa.IsEmpty Then
        ParamByName('CARBAI').AsString := AChaveCarteiraBaixa;

      {*****************************************}
      {* DADOS REFERENTES AO FILTRO            *}
      {**************************************MV*}
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      ExecSQL;
      Close;


      If AAtualizarBolCtr Then
        AtualizaBOLCTRBoletosBaixaTotal(fCampoTabela('AUTOINCREM', 'CADREC',
                                                     ['CTR_NUMDUP', 'CTR_PARCEL', 'CTR_ESPDOC','CTR_CODEMP', 'CTR_CODCLI', 'CTR_SEQBAI'],
                                                     [strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli, '0']));


      {*********************************}
      {* GRAVAR TABELA DO SISTEMA DEPS *}
      {******************************AJ*}
      If fCfgSis('USADEP') = 'S' Then
        TValidacoesSistemaDEPS.pGravaLancamentoSistemaDEPS(Concat(strNumDup, '-',
                                                                  strParcel, '-',
                                                                  strEspDoc, '-',
                                                                  strCodEmp, '-',
                                                                  strCodCli, '-',
                                                                  '0'),
                                                           'BAIXA');

      {*************************************}
      {* REALIZA A LIBERAÇÃO AUTOMÁTICA DO *}
      {* DOCUMENTO RECEBIDO PARA EXPEDIR   *}
      {**********************************PZ*}
      pLiberaDoctoParaExpedicaoAutomatico(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel);

      LDuplicataBoleto.strNumDup := strNumDup;
      LDuplicataBoleto.strParcel := strParcel;
      LDuplicataBoleto.strEspDoc := strEspDoc;
      LDuplicataBoleto.strCodEmp := strCodEmp;
      LDuplicataBoleto.strCodCli := strCodCli;
      DeletarCarteiraBoleto(LDuplicataBoleto);

    End;

    Result := TRUE;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

  FreeAndNil(qryGenRec);
  FreeAndNil(qrySelpar);

end;

function fCriaCdsRateio(AOwner: TComponent): TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(AOwner);

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'SEQBAI';
    DataType := ftInteger;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'NUMDUP';
    DataType := ftString;
    Size     := 12;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'PARCEL';
    DataType := ftString;
    Size     := 3;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ESPDOC';
    DataType := ftString;
    Size     := 2;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODEMP';
    DataType := ftString;
    Size     := 3;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CODCLI';
    DataType := ftString;
    Size     := 8;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALREC';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'DINHEI';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CHQAVI';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CHQPRE';
    DataType := ftFloat;
    Required := False;
  End;
  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'CARTAO';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'ORDPAG';
    DataType := ftFloat;
    Required := False;
  End;

  With Result.FieldDefs.AddFieldDef Do
  Begin
    Name     := 'VALFIN';
    DataType := ftFloat;
    Required := False;
  End;
  
  Result.CreateDataSet;
  Result.Open;
end;

{*****************************************}
{* VERIFICA SE EXISTE UM DETERMINADO N- *}
{* MERO DE AGRUPAMENTO                   *}
{**************************************MV*}
function  fVerificaNumAgr(strNumAgr,
                          strCodCli: String): Boolean;
  Var
    strSQL : String;
    qryGen1: TUniQuery;
    qryGen2: TUniQuery;
    //strDupl: String;
begin

  qryGen1 := fCriaQuery;
  qryGen2 := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  DUPAGR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_NUMAGR = :NUMAGR AND ';
  strSQL := strSQL + '  CTR_EMPAGR = :EMPAGR AND ';
  strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';

  With qryGen1 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMAGR').AsString := strNumAgr;
    ParamByName('EMPAGR').AsString := VS_strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;
    Open;

    If Not IsEmpty Then
      Result := True
    Else
    Begin
      Result := False;
      fMensagem('', 'Agrupamento não encontrado!', ['&O k']);
    End;

  End;

  If Result Then
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  C.*, ';
    strSQL := strSQL + '  D.CTR_NUMAGR AS NUMAGR, ';
    strSQL := strSQL + '  D.CTR_NUMDUP AS DUPLIC  ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + 'CADREC C ';
    strSQL := strSQL + 'INNER JOIN DUPAGR D ON ';
    strSQL := strSQL + '   D.CTR_EMPAGR = :EMPAGR AND  ';
    strSQL := strSQL + '   D.CTR_NUMAGR = C.CTR_NUMDUP ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  C.CTR_NUMDUP = :NUMAGR AND ';
    strSQL := strSQL + '  C.CTR_ESPDOC = "AG"    AND ';
    strSQL := strSQL + '  C.CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  C.CTR_CODEMP = :EMPAGR AND ';
    strSQL := strSQL + '  C.CTR_DTAREC IS NOT NULL ';

    With qryGen2 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('EMPAGR').AsString := VS_strCodEmp;
      ParamByName('NUMAGR').AsString := strNumAgr;
      ParamByName('CODCLI').AsString := qryGen1.FieldByName('CTR_CODCLI').AsString;
      Open;

      If IsEmpty Then
        Result := True
      Else
      Begin
        Result := False;

        First;

        {strDupl := '';

        While Not Eof Do
        Begin
          strDupl := strDupl + FieldByName('DUPLIC').AsString + ' - ' + FieldByName('CTR_PARCEL').AsString + ', ';
          Next;
        End;

        strDupl := LeftStr(strDupl, Length(strDupl) - 2) + '.';
        strDupl := strDupl + #13 + #10 + ' Agrupamento '}

        fMensagem('', 'Não é possivel realizar o desagrupamento, ' + #13 + #10 +
                      'pois o mesmo está baixado. ' + #13 + #10 +
                      'Para realizar a operação estorne o agrupamento.', ['&O k']);
      End;

    End;

  End;

  If Result Then
  Begin

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   * ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADREC ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTR_NUMDUP = :NUMAGR AND ';
    strSQL := strSQL + '   CTR_ESPDOC = "AG"    AND ';
    strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '   CTR_CODEMP = :EMPAGR AND ';
    strSQL := strSQL + '   CTR_DTAENV IS NOT NULL ';

    With qryGen2 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('EMPAGR').AsString := VS_strCodEmp;
      ParamByName('NUMAGR').AsString := strNumAgr;
      ParamByName('CODCLI').AsString := qryGen1.FieldByName('CTR_CODCLI').AsString;
      Open;

      If IsEmpty Then
        Result := True
      Else
      Begin
        Result := False;
        fMensagem('', 'Não é possivel realizar o desagrupamento, pois há duplicatas enviadas para o banco.', ['&O k']);
      End;

    End;

  End;

  If Result Then
  Begin

    qryGen1.First;
    While Not qryGen1.Eof Do
    Begin
      strSQL := '';
      strSQL := strSQL + ' SELECT GER_NUMFAT, GER_TIPFAT, GER_EMPFAT FROM MOVGER WHERE GER_JAFATU = 1 AND IFNULL(GER_NUMFAT, "") <> "" ';
      strSQL := strSQL + ' AND GER_NUMDOC = :NUMDOC ';
      strSQL := strSQL + ' AND GER_ESPDOC = :ESPDOC ';
      strSQL := strSQL + ' AND GER_CODEMP = :CODEMP ';
      strSQL := strSQL + ' AND GER_CODCLI = :CODCLI ';

      strSQL := strSQL + ' UNION ALL ' + AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER' );

      With qryGen2 Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := qryGen1.FieldByName('CTR_NUMDUP').AsString;
        ParamByName('ESPDOC').AsString := qryGen1.FieldByName('CTR_ESPDOC').AsString;
        ParamByName('CODEMP').AsString := qryGen1.FieldByName('CTR_CODEMP').AsString;
        ParamByName('CODCLI').AsString := qryGen1.FieldByName('CTR_CODCLI').AsString;
        Open;

        If Not IsEmpty Then
        Begin
          Result := False;
          pMensagemOk('Não é possível realizar o desagrupamento, pois o agrupamento contém o documento ' +
                                                            qryGen1.FieldByName('CTR_NUMDUP').AsString + '-' +
                                                            qryGen1.FieldByName('CTR_ESPDOC').AsString + '-' +
                                                            qryGen1.FieldByName('CTR_CODEMP').AsString +
                      ' que foi confirmado no documento ' + FieldByName('GER_NUMFAT').AsString + '-' +
                                                            FieldByName('GER_TIPFAT').AsString + '-' +
                                                            FieldByName('GER_EMPFAT').AsString);
          Break;
        End;
      End;

      qryGen1.Next;
    End;

  End;

  qryGen1.Close;
  qryGen2.Close;

  FreeAndNil(qryGen1);
  FreeAndNil(qryGen2);

end;

function fRetDoctosCadRecAgr(strNumAgr,
                             strCodCli: String): TStringList;
  Var
    strSQL : String;
    qryGen1: TUniQuery;
    qryGen2: TUniQuery;
begin
  Result := Nil;

  qryGen1 := fCriaQuery;
  qryGen2 := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  * ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + ' DUPAGR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_NUMAGR = :NUMAGR AND ';
  strSQL := strSQL + '  CTR_EMPAGR = :EMPAGR AND ';
  strSQL := strSQL + '  CTR_CODCLI = :CODCLI ';

  With qryGen1 Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMAGR').AsString := strNumAgr;
    ParamByName('EMPAGR').AsString := VS_strCodEmp;
    ParamByName('CODCLI').AsString := strCodCli;
    Open;
  End;

  If Not qryGen1.IsEmpty Then
  Begin
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  * ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + ' CADREC C ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  C.CTR_NUMDUP = :NUMAGR AND ';
    strSQL := strSQL + '  C.CTR_ESPDOC = "AG"    AND ';
    strSQL := strSQL + '  C.CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  C.CTR_CODEMP = :EMPAGR AND ';
    strSQL := strSQL + '  C.CTR_SEQBAI = 0 ';

    With qryGen2 Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('EMPAGR').AsString := VS_strCodEmp;
      ParamByName('NUMAGR').AsString := strNumAgr;
      ParamByName('CODCLI').AsString := qryGen1.FieldByName('CTR_CODCLI').AsString;
      Open;

      If Not IsEmpty Then
      Begin
        Result := TStringList.Create;

        First;
        While Not Eof Do
        Begin
          Result.Add(FieldByName('CTR_NUMDUP').AsString +
                     FieldByName('CTR_ESPDOC').AsString +
                     VS_strCodEmp +
                     FieldByName('CTR_CODCLI').AsString +
                     FieldByName('CTR_PARCEL').AsString);

          Next;
        End;
      End;
    End;
  End;

  qryGen1.Close;
  qryGen2.Close;

  FreeAndNil(qryGen1);
  FreeAndNil(qryGen2);
End;

function fGetValOriDuplicata(strNumDup,
                             strEspDoc,
                             strCodEmp,
                             strParcel,
                             strCodCli: String): Double;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   IF(CTR_SEQBAI = 0, CTR_VALORI, CTR_GRVORI) AS VALORI ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADREC ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '   CTR_CODCLI = :CODCLI ';
  strSQL := strSQL + ' ORDER BY ';
  strSQL := strSQL + '   CTR_PARCEL, ';
  strSQL := strSQL + '   CTR_SEQBAI  ';
  strSQL := strSQL + ' LIMIT 1 ';

  Try
    qryGen := fCriaQuery;

    With qryGen Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('CODCLI').AsString := strCodCli;

      Open;

      If Not IsEmpty Then
        Result := FieldByName('VALORI').AsFloat
      Else
        Result := 0;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
End;

function fCreditoDiretoComMovBan(arrDupSel : TArrDupSel = Nil): String;
  Var
    qryGen: TUniQuery;
    strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' SELECT           ';
  strSQL := strSQL + '   M.CTB_SEQLAN AS SEQLAN  ';
  strSQL := strSQL + ' FROM             ';
  strSQL := strSQL + '   BANCTR B       ';
  strSQL := strSQL + '    JOIN MOVBAN M ON M.CTB_SEQLAN = B.CTB_SEQLAN ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '   CTR_CODCLI = :CODCLI ';

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

      If Not IsEmpty Then
        Result := FieldByName('SEQLAN').AsString
      Else
        Result := '';
    End;
  Finally
    FreeAndNil(qryGen);
  End;
End;

procedure pGravaRateio(cdsRateio: TUniClientDataSet;
                       intSeqBai: Integer;
                       strNumDup,
                       strParcel,
                       strEspDoc,
                       strCodEmp,
                       strCodCli: String;
                       fltValRec,
                       fltValDin,
                       fltValCqV,
                       fltValCqP,
                       fltValCar,
                       fltValOrd,
                       fltValFin: Double);
begin
  Try
    With cdsRateio Do
    Begin
      Insert;
      FieldByName('SEQBAI').AsInteger := intSeqBai;
      FieldByName('NUMDUP').AsString  := strNumDup;
      FieldByName('PARCEL').AsString  := strParcel;
      FieldByName('ESPDOC').AsString  := strEspDoc;
      FieldByName('CODEMP').AsString  := strCodEmp;
      FieldByName('CODCLI').AsString  := strCodCli;
      FieldByName('VALREC').AsFloat   := fltValRec;
      FieldByName('DINHEI').AsFloat   := fltValDin;
      FieldByName('CHQAVI').AsFloat   := fltValCqV;
      FieldByName('CHQPRE').AsFloat   := fltValCqP;
      FieldByName('CARTAO').AsFloat   := fltValCar;
      FieldByName('ORDPAG').AsFloat   := fltValOrd;
      FieldByName('VALFIN').AsFloat   := fltValFin;
      Post;
    End;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

{*****************************************}
{* VERIFICA SE UM NOSSO NUMERO ESTÁ CA-  *}
{* DASTRADO EM ALGUMA DUPLICATA, E RE-   *}
{* TORNA O NÚMERO DA MESMA, CASO ESTEJA  *}
{**************************************MV*}
function fValidaNossoNumero(strNosNum,
                            strCodEmp,
                            strCodBco: String;
                            Var strNumDup: String;
                            strDupAlt: String): Boolean;
  Var
    strSQL   : String;
    qryGenCtr: TUniQuery;

begin
  Try

    Result := False;

    qryGenCtr := fCriaQuery;

    If fEmptyStr(strNosNum) Then
    Begin
      Exit;
    End;

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTR_NOSNUM, ';
    strSQL := strSQL + '  CTR_NUMDUP ';
    strSQL := strSQL + 'FROM CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NOSNUM = :NOSNUM AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_BCOBOL = :CODBCO ';

    {**********************************}
    { CASO A VERIFICACAO FOR UTILIZADA }
    { NA ALTERACAO DA DUPLICATA        }
    {*******************************JB*}
    If Not fEmptyStr(strDupAlt) Then
      strSQL := strSQL + '  AND CTR_NUMDUP <> ' + QuotedStr(strDupAlt);

    With qryGenCtr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NOSNUM').AsString := strNosNum;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODBCO').AsString := strCodBco;
      Open;
      If Not IsEmpty Then
      Begin
        Result    := True;
        strNumDup := FieldByName('CTR_NUMDUP').AsString;
      End;

      Close;

    End;

  Finally
    FreeAndNil(qryGenCtr);
  End;

end;

{*****************************************}
{* RETORNA 'TRUE' CASO A DUPLICATA JA    *}
{* ESTEJA BAIXADA                        *}
{**************************************MV*}
function fDuplicataCtrBaixada(strNumDup,
                              strParcel,
                              strEspDoc,
                              strCodEmp,
                              strCodCli: String;
                              intSeqBai: Integer): Boolean;
  Var
    strSQL: String;
    qryGenRec: TUniQuery;

begin
  Try

    qryGenRec := fCriaQuery;

    Result := False;
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CTR_DTAREC AS DTAREC ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  CTR_SEQBAI = :SEQBAI ';

    With qryGenRec Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString  := strNumDup;
      ParamByName('PARCEL').AsString  := strParcel;
      ParamByName('ESPDOC').AsString  := strEspDoc;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODCLI').AsString  := strCodCli;
      ParamByName('SEQBAI').AsInteger := intSeqBai;
      Open;

      If Not FieldByName('DTAREC').IsNull Then
        Result := True;
      Close;
    End;

  Finally
    FreeAndNil(qryGenRec);
  End;

end;

function fGetSqlCodigoProjeto(strEspDoc : String): String;
  Var
    strSQL: String;
Begin

  If (strEspDoc = 'AG') Then
  Begin
    strSQL := '';
    strSQL := strSQL + '  SELECT                                ';
    strSQL := strSQL + '    CODPRJ,                             ';
    strSQL := strSQL + '    NUMDOC,                             ';
    strSQL := strSQL + '    DTAENT                              ';
    strSQL := strSQL + '  FROM                                  ';
    strSQL := strSQL + '    (SELECT                             ';
    strSQL := strSQL + '      A.AUX_CODPRJ AS CODPRJ,           ';
    strSQL := strSQL + '      G.GER_NUMDOC AS NUMDOC,           ';
    strSQL := strSQL + '      G.GER_DTAENT AS DTAENT            ';
    strSQL := strSQL + '    FROM                                ';
    strSQL := strSQL + '      AUXMOV A                          ';
    strSQL := strSQL + '      INNER JOIN MOVGER G               ';
    strSQL := strSQL + '        ON G.AUTOINCREM = A.AUX_SEQGER  ';
    strSQL := strSQL + '      INNER JOIN DUPAGR                 ';
    strSQL := strSQL + '        ON G.GER_NUMDOC = CTR_NUMDUP    ';
    strSQL := strSQL + '        AND G.GER_ESPDOC = CTR_ESPDOC   ';
    strSQL := strSQL + '        AND G.GER_CODCLI = CTR_CODCLI   ';
    strSQL := strSQL + '        AND G.GER_CODEMP = CTR_CODEMP   ';
    strSQL := strSQL + '    WHERE CTR_NUMAGR =:NUMDOC           ';
    strSQL := strSQL + '      AND CTR_EMPAGR =:CODEMP           ';
    strSQL := strSQL + '      AND CTR_CODCLI =:CODCLI           ';
    strSQL := strSQL + '      AND A.AUX_CODPRJ IS NOT NULL      ';
    strSQL := strSQL + '    UNION ALL                           ';
    strSQL := strSQL + '    SELECT                              ';
    strSQL := strSQL + '      A.AUX_CODPRJ AS CODPRJ,           ';
    strSQL := strSQL + '      G.GER_NUMDOC AS NUMDOC,           ';
    strSQL := strSQL + '      G.GER_DTAENT AS DTAENT            ';
    strSQL := strSQL + '    FROM                                ';
    strSQL := strSQL + '      AUXNOT A                          ';
    strSQL := strSQL + '      INNER JOIN NOTGER G               ';
    strSQL := strSQL + '        ON G.AUTOINCREM = A.AUX_SEQGER  ';
    strSQL := strSQL + '      INNER JOIN DUPAGR                 ';
    strSQL := strSQL + '        ON G.GER_NUMDOC = CTR_NUMDUP    ';
    strSQL := strSQL + '        AND G.GER_ESPDOC = CTR_ESPDOC   ';
    strSQL := strSQL + '        AND G.GER_CODCLI = CTR_CODCLI   ';
    strSQL := strSQL + '        AND G.GER_CODEMP = CTR_CODEMP   ';
    strSQL := strSQL + '    WHERE CTR_NUMAGR =:NUMDOC           ';
    strSQL := strSQL + '      AND CTR_EMPAGR =:CODEMP           ';
    strSQL := strSQL + '      AND CTR_CODCLI =:CODCLI           ';
    strSQL := strSQL + '      AND A.AUX_CODPRJ IS NOT NULL      ';
    strSQL := strSQL + '    ) CP                                ';
    strSQL := strSQL + '  GROUP BY CODPRJ                       ';
    strSQL := strSQL + '  ORDER BY DTAENT,                      ';
    strSQL := strSQL + '    NUMDOC                              ';
  End
  Else
  Begin
    strSQL := '';
    strSQL := strSQL + '  SELECT                                ';
    strSQL := strSQL + '    CODPRJ,                             ';
    strSQL := strSQL + '    NUMDOC,                             ';
    strSQL := strSQL + '    DTAENT                              ';
    strSQL := strSQL + '  FROM                                  ';
    strSQL := strSQL + '    (SELECT                             ';
    strSQL := strSQL + '      A.AUX_CODPRJ AS CODPRJ,           ';
    strSQL := strSQL + '      G.GER_NUMDOC AS NUMDOC,           ';
    strSQL := strSQL + '      G.GER_DTAENT AS DTAENT            ';
    strSQL := strSQL + '    FROM                                ';
    strSQL := strSQL + '      AUXMOV A                          ';
    strSQL := strSQL + '      INNER JOIN MOVGER G               ';
    strSQL := strSQL + '        ON G.AUTOINCREM = A.AUX_SEQGER  ';
    strSQL := strSQL + '    WHERE G.GER_NUMDOC =:NUMDOC         ';
    strSQL := strSQL + '      AND G.GER_ESPDOC =:ESPDOC         ';
    strSQL := strSQL + '      AND G.GER_CODCLI =:CODCLI         ';
    strSQL := strSQL + '      AND G.GER_CODEMP =:CODEMP         ';
    strSQL := strSQL + '      AND G.GER_ORIDOC = "V"            ';
    strSQL := strSQL + '  	AND A.AUX_CODPRJ IS NOT NULL        ';
    strSQL := strSQL + '    UNION ALL                           ';
    strSQL := strSQL + '    SELECT                              ';
    strSQL := strSQL + '      A.AUX_CODPRJ AS CODPRJ,           ';
    strSQL := strSQL + '      G.GER_NUMDOC AS NUMDOC,           ';
    strSQL := strSQL + '      G.GER_DTAENT AS DTAENT            ';
    strSQL := strSQL + '    FROM                                ';
    strSQL := strSQL + '      AUXNOT A                          ';
    strSQL := strSQL + '      INNER JOIN NOTGER G               ';
    strSQL := strSQL + '        ON G.AUTOINCREM = A.AUX_SEQGER  ';
    strSQL := strSQL + '    WHERE G.GER_NUMDOC =:NUMDOC         ';
    strSQL := strSQL + '      AND G.GER_ESPDOC =:ESPDOC         ';
    strSQL := strSQL + '      AND G.GER_CODCLI =:CODCLI         ';
    strSQL := strSQL + '      AND G.GER_CODEMP =:CODEMP         ';
    strSQL := strSQL + '      AND G.GER_ORIDOC = "V"            ';
    strSQL := strSQL + '      AND A.AUX_CODPRJ IS NOT NULL) CP  ';
    strSQL := strSQL + '  ORDER BY DTAENT, NUMDOC               ';
  End;

  Result := strSQL;
End;

function fRetornaCodigoProjeto(strNumDup,
                               strEspDoc,
                               strCodEmp,
                               strCodCli: String): String;
  Var
    qryGenRec: TUniQuery;
begin
  Result := '';
  Try
    qryGenRec := fCriaQuery;

    Try
      qryGenRec.Close;
      qryGenRec.SQL.Clear;
      qryGenRec.SQL.Add(fGetSqlCodigoProjeto(strEspDoc));
      qryGenRec.ParamByName('NUMDOC').AsString  := strNumDup;
      If (strEspDoc <> 'AG') Then
        qryGenRec.ParamByName('ESPDOC').AsString  := strEspDoc;
      qryGenRec.ParamByName('CODEMP').AsString  := strCodEmp;
      qryGenRec.ParamByName('CODCLI').AsString  := strCodCli;
      qryGenRec.Open;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message,'[untCadRec.fRetornaCodigoProjeto]');
      End;
    End;

    Result := qryGenRec.FieldByName('CODPRJ').AsString;

  Finally
    FreeAndNil(qryGenRec);
  End;

end;


function fAutenticaTRDV(strNumDup,
                        strParcel,
                        strEspDoc,
                        strCodEmp,
                        strCodCli: String;
                        intSeqBai: Integer;
                        fltVrTrDv: Double): Boolean;
  Var
    strSQL: String;
    qryGen: TUniQuery;
begin

  Try
    qryGen := fCriaQuery(Nil);

    strSQL := '';
    strSQL := strSQL + ' UPDATE                 ';
    strSQL := strSQL + '   CADREC               ';
    strSQL := strSQL + ' SET                    ';
    strSQL := strSQL + '   CTR_VRTRDV = 0,      ';
    strSQL := strSQL + '   CTR_VALORI = :VALOR, ';
    strSQL := strSQL + '   CTR_VALDUP = :VALOR  ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDUP').AsString  := strNumDup;
      ParamByName('PARCEL').AsString  := strParcel;
      ParamByName('ESPDOC').AsString  := strEspDoc;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('CODCLI').AsString  := strCodCli;
      ParamByName('SEQBAI').AsInteger := intSeqBai;
      ParamByName('VALOR').AsFloat    := fltVrTrDv;
      ExecSql;
      Close;
    End;

    Result := True;
  Except
    On E: Exception Do
    begin
      Raise Exception.Create(E.Message);
    end;
  End;

  FreeAndNil(qryGen);
end;

{$IFNDEF LINUX}
function fGravaNumBco(strCodBco,
                      strCodPor: String;
                      Var strNosNum: String;
                      Var strNumDig: String;
                      qryArqCtr: TDataSet;
                      ctrDuplicata: PTDuplicataCtr = Nil;
                      strBcoIni: String = '';
                      intCodCar: Integer = 0;
                      strBB_Crr: String = '';
                      fltPerMor: Double = 0;
                      fltPerMul: Double = 0;
                      strBraCrr: String = '';
                      strEmpresaImpressao: String = '';
                      ALinhaDigitavel: String = '';
                      AObservacao01: String = '';
                      AObservacao02: String = ''): Boolean;

  Var
    strSQL      : String;
    qryGenBco   : TUniQuery;
    qryLogCtr   : TUniQuery;
    strCfgNosNum: String;
    strTpIden   : String;
    blnNosNu7   : Boolean;
    strProxNum  : String;

begin
  qryGenBco := Nil;
  qryLogCtr := Nil;
  Result := False;

  Try
    If strEmpresaImpressao.isEmpty Then
      strEmpresaImpressao := VS_strCodEmp;

    qryGenBco    := fCriaQuery;
    strCfgNosNum := fCfgSis('NOSNUM', varString, strEmpresaImpressao);

    If (strCodBco <> '077') and (strCodBco <> '097') and (strBcoIni <> '748API') and (strBcoIni <> '756API') Then
    Begin
      strNumDig := '';
      fLock_Unlock('CADBCO', True);
      Try

        strSQL := '';
        strSQL := strSQL + 'UPDATE ';
        strSQL := strSQL + '  CADBCO ';
        strSQL := strSQL + 'SET ';

        If strCodBco = '001' Then
        Begin
          If (fEmptyStr(strCfgNosNum)) Or (strCfgNosNum = '1') Then
          Begin
            strSQL    := strSQL + '  BCO_PRONUM = :PRONUM ';
            blnNosNu7 := False;
          End
          Else
          Begin
            strSQL    := strSQL + '  BCO_PRONU7 = :PRONUM ';
            blnNosNu7 := True;
          End;
        End
        Else If (strCodBco = '104') Or
                (strCodBco = '041') Or
                (strCodBco = '756') Or
                (strCodBco = '246') Or
                (strCodBco = '906') Then
        Begin

          If fEmptyStr(fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'NUMNOSS', '', strEmpresaImpressao)) Or
                      (fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar), 'NUMNOSS', '', strEmpresaImpressao) = '1') Then
          Begin
            strSQL    := strSQL + '  BCO_PRONUM = :PRONUM ';
            blnNosNu7 := False;
          End
          Else
          Begin
            strSQL    := strSQL + '  BCO_PRONU7 = :PRONUM ';
            blnNosNu7 := True;
          End;

        End
        Else
        Begin
          strSQL    := strSQL + '  BCO_PRONUM = :PRONUM ';
          blnNosNu7 := False;
        End;

        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  BCO_CODBCO = :CODBCO ';

        {*****************************************}
        {* ATUALIZA O PROXIMO NOSSO NUMERO DO    *}
        {* CADBCO                                *}
        {**************************************MV*}
        If Not fEmptyStr(strNosNum) Then
          strNosNum := IntToStr(StrToInt64(strNosNum));

        strProxNum := IIF( (intCodCar <> 0) And (Not fEmptyStr(strBcoIni)),
                           fRetNossoNumeroDisponivel(strCodBco, IntToStr(StrToInt64(strNosNum)+1), strBcoIni, intCodCar, strEmpresaImpressao),
                           IntToStr(StrToInt64(strNosNum)+1)
                         );

        pGravaLogBan(strCodBco, fRetNomBanco(strCodBco), IIF(Not blnNosNu7, IntToStr(StrToInt64(strProxNum)), ''), IIF(blnNosNu7, IntToStr(StrToInt64(strProxNum)), ''), False, False, True, strNosNum);

        qryGenBco.Close;
        qryGenBco.SQL.Clear;
        qryGenBco.SQL.Add(strSQL);

        If Not fEmptyStr(strNosNum) Then
          qryGenBco.ParamByName('PRONUM').AsString := IntToStr(StrToInt64(strProxNum))
        Else
          qryGenBco.ParamByName('PRONUM').AsString := '';

        qryGenBco.ParamByName('CODBCO').AsString := strCodBco;
        qryGenBco.ExecSQL;
        qryGenBco.Close;

        fLock_Unlock('CADBCO', False);
      Except

        On E: Exception Do
        Begin
          fLock_Unlock('CADBCO', False);
          Raise Exception.Create('[fGravaNumBco] - ' + E.Message);
        End;

      End;

      {*********************************}
      {* HSBC 399 SEM REGISTRO TPIDENT *}
      {* RQ: 35192 ******************BB*}
      If strCodBco = '399' Then
        strTpIden := fGetBancoConfig(0, 'CONFIG' + strBcoIni + '-' +  IntToStr(intCodCar), 'TPIDENT', '5', strEmpresaImpressao);

      {*****************************************}
      {* CALCULA O NOSSO NÚMERO                *}
      {**************************************MV*}
      If (Pos(strCodBco, '777_778') <= 0) Then
        strNosNum := fCalcNossoNumero(strCodBco, strNosNum, strBcoIni, intCodCar, strEmpresaImpressao);

      If strBcoIni = '707' Then
        strNosNum := fPadL(strNosNum, 8, '0');

      {*****************************************}
      {* CALCULA O DIGITO VERIFICADOR          *}
      {**************************************MV*}
      If (Pos(strCodBco, '777_778') <= 0) Then
      Begin
        If (strTpIden = '4') And Assigned(qryArqCtr) Then
          strNumDig := fCalcDigito(strCodBco, strNosNum, strBcoIni, intCodCar, strEmpresaImpressao, qryArqCtr.FieldByName('CTR_DTAVEN').AsDateTime)
        Else
          strNumDig := fCalcDigito(strCodBco, strNosNum, strBcoIni, intCodCar, strEmpresaImpressao);
      End;
    End;



    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CTR_BCOBOL = :BCOBOL, ';
    strSQL := strSQL + '  CTR_NOSNUM = :NOSNUM, ';
    strSQL := strSQL + '  CTR_CODPOR = :CODPOR, ';
    strSQL := strSQL + '  CTR_CARTEI = :CARTEI, ';
    strSQL := strSQL + '  CTR_OBSV01 = :OBSV01, ';
    strSQL := strSQL + '  CTR_OBSV02 = :OBSV02, ';

    if (not fEmptyStr(strLinDig)) Or (Not ALinhaDigitavel.IsEmpty) then
      strSQL := strSQL + ' CTR_LINDIG = :LINDIG, ';

    If strCodBco = '077' Then
      strSQL := strSQL + '  CTR_BCOENV = :BCOBOL, ';

    If ctrDuplicata <> Nil Then
    Begin
      If ctrDuplicata.QRCodePix.IsEmpty Then
      Begin
        strSQL := strSQL + '  CTR_TX_BOL = NULL, ';
        strSQL := strSQL + '  CTR_QRCODE = NULL, ';
        strSQL := strSQL + '  CTR_LNKCIT = NULL, ';
        strSQL := strSQL + '  CTR_PIXLOC = NULL, ';
      End;
    End;
  
    strSQL := strSQL + '  CTR_PERMOR = :PERMOR, ';
    strSQL := strSQL + '  CTR_PERMUL = :PERMUL  ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  CTR_SEQBAI = 0 ';

    Try

      If (Not fEmptyStr(strNosNum)) Or (strCodBco = '778') Then
      Begin

        qryGenBco.Close;
        qryGenBco.SQL.Clear;
        qryGenBco.SQL.Add(strSQL);

        {*****************************************}
        {* DADOS QUE SERO ATUALIZADOS           *}
        {**************************************MV*}
        If fEmptyStr(strCodBco) Then
          qryGenBco.ParamByName('BCOBOL').Value    := Null
        Else
          qryGenBco.ParamByName('BCOBOL').AsString := strCodBco;

        strLogCtrCodBco := qryGenBco.ParamByName('BCOBOL').AsString;

        {DADOS DA LINHA DIGITAVEL A SER INSERIDA PARA POSTERIORMENTE
         CAPTURADA PARA LOGCTR}
        if not fEmptyStr(strLinDig) then
          qryGenBco.ParamByName('LINDIG').AsString := StringReplace(StringReplace(strLinDig,' ','',[rfReplaceAll]),'.','',[rfReplaceAll]);

        if not ALinhaDigitavel.IsEmpty then
          qryGenBco.ParamByName('LINDIG').AsString := StringReplace(StringReplace(ALinhaDigitavel,' ','',[rfReplaceAll]),'.','',[rfReplaceAll]);

        {************************************************************************************}
        {* CAMPO CTR_CARTEI FOI ALTERADO PARA GRAVAR TODA A CHAVE DA CONFIGURAÇÃO DO AUTBAN *}
        {*REQ-25848-22/01/2015************************************************************JU*}
        strLogCtrCodCar := 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar) + '-' + strEmpresaImpressao;
        qryGenBco.ParamByName('CARTEI').AsString := strLogCtrCodCar;

        If ((strCodBco = '637') And (strBcoIni = '637_444p')) Then
           strLogCtrNosNum := RightStr( (strNosNum + strNumDig), 13)
        Else
        If (strBcoIni = '097API') Then
           strLogCtrNosNum := strNosNum
        Else
           strLogCtrNosNum := RightStr( (strNosNum + strNumDig), 12);

        qryGenBco.ParamByName('NOSNUM').AsString := strLogCtrNosNum;
        //  ParamByName('NOSNUM').AsString := fStrZero(IntToStr(StrToInt64(strNosNum)) + strNumDig, 12);

        If fEmptyStr(strCodPor) Then
          qryGenBco.ParamByName('CODPOR').Value    := Null
        Else
          qryGenBco.ParamByName('CODPOR').AsString := strCodPor;

        {************************************************************************************}
        {* CRIADADOS CAMPOS PERCENTUAL DE MORA E PERCENTUAL DE MULTA PARA BOLETOS IMPRESSOS *}
        {*REQ-25848-22/01/2015************************************************************JU*}
        qryGenBco.ParamByName('PERMOR').AsFloat := fltPerMor;
        qryGenBco.ParamByName('PERMUL').AsFloat := fltPerMul;

        qryGenBco.ParamByName('OBSV01').AsString := AObservacao01;
        qryGenBco.ParamByName('OBSV02').AsString := AObservacao02;

        {*****************************************}
        {* DADOS DO FILTRO                       *}
        {**************************************MV*}
        If (ctrDuplicata = Nil) Then
        Begin
          qryGenBco.ParamByName('NUMDUP').AsString := qryArqCtr.FieldByName('CTR_NUMDUP').AsString;
          qryGenBco.ParamByName('PARCEL').AsString := qryArqCtr.FieldByName('CTR_PARCEL').AsString;
          qryGenBco.ParamByName('CODCLI').AsString := qryArqCtr.FieldByName('CTR_CODCLI').AsString;
          qryGenBco.ParamByName('CODEMP').AsString := qryArqCtr.FieldByName('CTR_CODEMP').AsString;
          qryGenBco.ParamByName('ESPDOC').AsString := qryArqCtr.FieldByName('CTR_ESPDOC').AsString;

          qryLogCtr := fCriaQryDadosDuplic(qryArqCtr.FieldByName('CTR_NUMDUP').AsString,
                                           qryArqCtr.FieldByName('CTR_PARCEL').AsString,
                                           qryArqCtr.FieldByName('CTR_ESPDOC').AsString,
                                           qryArqCtr.FieldByName('CTR_CODEMP').AsString,
                                           qryArqCtr.FieldByName('CTR_CODCLI').AsString);
        End
        Else
        Begin
          qryGenBco.ParamByName('NUMDUP').AsString := ctrDuplicata^.strNumDup;
          qryGenBco.ParamByName('PARCEL').AsString := ctrDuplicata^.strParcel;
          qryGenBco.ParamByName('CODCLI').AsString := ctrDuplicata^.strCodCli;
          qryGenBco.ParamByName('CODEMP').AsString := ctrDuplicata^.strCodEmp;
          qryGenBco.ParamByName('ESPDOC').AsString := ctrDuplicata^.strEspDoc;

          qryLogCtr := fCriaQryDadosDuplic(ctrDuplicata^.strNumDup,
                                           ctrDuplicata^.strParcel,
                                           ctrDuplicata^.strEspDoc,
                                           ctrDuplicata^.strCodEmp,
                                           ctrDuplicata^.strCodCli);

        End;
        qryGenBco.ExecSQL;


        if fEmptyStr(qryLogCtr.FieldByName('CTR_LINDIG').AsString) then
          linhaDigitavel := StringReplace(StringReplace(strLinDig,' ','',[rfReplaceAll]),'.','',[rfReplaceAll])
        else
          linhaDigitavel := qryLogCtr.FieldByName('CTR_LINDIG').AsString;

        If linhaDigitavel.IsEmpty THen
        Begin
          If Not ALinhaDigitavel.IsEmpty Then
            linhaDigitavel := ALinhaDigitavel;
        End;

        qryGenBco.Close;

      End;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create('[fGravaNumBco] - ' + E.Message);
      End;

    End;
  Finally
    If Assigned(qryGenBco) Then  FreeAndNil(qryGenBco);
    If Assigned(qryLogCtr) Then  FreeAndNil(qryLogCtr);
  End;
end;
{$ENDIF}

function fLimpaDadosRemessa(strNumDup,
                            strParcel,
                            strEspDoc,
                            strCodEmp,
                            strCodCli: String;
                            intSeqBai: Integer): Boolean;
  Var
    strUpdate: String;
begin
  strUpdate := '';
  strUpdate := strUpdate + ' UPDATE ';
  strUpdate := strUpdate + '   CADREC ';
  strUpdate := strUpdate + ' SET ';
  strUpdate := strUpdate + '   CTR_DTAENV = NULL, ';
  strUpdate := strUpdate + '   CTR_BCOBOL = NULL, ';
  strUpdate := strUpdate + '   CTR_BCOENV = NULL  ';
  strUpdate := strUpdate + ' WHERE ';
  strUpdate := strUpdate + '   CTR_NUMDUP = ' + QuotedStr(strNumDup) + ' AND ';
  strUpdate := strUpdate + '   CTR_PARCEL = ' + QuotedStr(strParcel) + ' AND ';
  strUpdate := strUpdate + '   CTR_ESPDOC = ' + QuotedStr(strEspDoc) + ' AND ';
  strUpdate := strUpdate + '   CTR_CODEMP = ' + QuotedStr(strCodEmp) + ' AND ';
  strUpdate := strUpdate + '   CTR_CODCLI = ' + QuotedStr(strCodCli) + ' AND ';
  strUpdate := strUpdate + '   CTR_SEQBAI = ' + intToStr(intSeqBai);

  Result := fExecutaSQL(strUpdate);
end;

function fDeletaDel_CadRec(strNumDup,
                           strParcel,
                           strEspDoc,
                           strCodEmp,
                           strCodCli: String;
                           intSeqBai: Integer): Boolean;
Var
  strSQL   : String;
  qryGenCtr: TUniQuery;

begin
  Try

    qryGenCtr := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' DELETE   ';
    strSQL := strSQL + ' FROM     ';
    strSQL := strSQL + '   DEL_CADREC ';
    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND  ';
    strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND  ';
    strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND  ';
    strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND  ';
    strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND  ';
    strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI      ';

    Try
      With qryGenCtr Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString  := strNumDup;
        ParamByName('PARCEL').AsString  := strParcel;
        ParamByName('ESPDOC').AsString  := strEspDoc;
        ParamByName('CODEMP').AsString  := strCodEmp;
        ParamByName('CODCLI').AsString  := strCodCli;
        ParamByName('SEQBAI').AsInteger := intSeqBai;
        ExecSQL;
        Close;
        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        Raise Exception.Create('[fDeletaDel_CadRec] - ' + E.Message);
      End;

    End;

  Finally
    FreeAndNil(qryGenCtr);
  End;

end;


function fDeletaDupAgr(strNumAgr, strCodCli: String): Boolean;
  Var
    strSQL   : String;
    qryGenCtr: TUniQuery;

begin
  Try

    qryGenCtr := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM ';
    strSQL := strSQL + '  DUPAGR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMAGR = :NUMAGR AND ';
    strSQL := strSQL + '  CTR_EMPAGR = :EMPAGR AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI     ';

    Try
      With qryGenCtr Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMAGR').AsString := strNumAgr;
        ParamByName('EMPAGR').AsString := VS_strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        ExecSQL;
        Close;
        Result := True;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        Raise Exception.Create('[fDeletaDupAgr] - ' + E.Message);
      End;

    End;

  Finally
    FreeAndNil(qryGenCtr);
  End;

end;

function fGravaDupAgr(strNumAgr,
                      strNumDup,
                      strParcel: String;
                      intSeqBai: Integer;
                      strEspDoc,
                      strCodCli,
                      strCodEmp,
                      strCodPor,
                      strCodVen,
                      strCodDig: String;
                      dtaDtaCad,
                      dtaDtaVen: TDateTime;
                      fltValDup,
                      fltValOri,
                      fltDesCob: Double;
                      strDesCon,
                      strHist01,
                      strHist02,
                      strAdtCli,
                      strCodEve,
                      strCodVel,
                      strTipFor,
                      strCodCnd: String;
                      blnConApr: Boolean;
                      strEmpAgr,
                      strCodCta: String;
                      strEmp_PD: String;
                      intSeqCon: Integer;
                      fltDifOri,
                      fltValAnt,
                      fltGrvOri: Double;
                      strCtaSer: String = '';
                      fltSerVal: Double = 0;
                      fltVlrCom: Double = 0;
                      fltFatCom: Double = 0;
                      fltFatCo2: Double = 0;
                      fltValDes: Double = 0;
                      fltValJur: Double = 0;
                      strConPag: String = '';
                      strCodRep: String = '';
                      fltVlrRep: Double = 0;
                      fltFatRep: Double = 0;
                      fltValIPI: Double = 0;
                      fltValRet: Double = 0;
                      fltDesSuj: Double = 0;
                      fltJurSuj: Double = 0;
                      strBarCon: String = '';
                      fltPerDpo: Double = 0;
                      intQtdDAV: Integer = 0;
                      fltValAce: Double = 0;
                      fltValFre: Double = 0;
                      fltValCob: Double = 0;
                      strDocDiv: String = '';
                      strEspDiv: String = '';
                      strEmpDiv: String = '';
                      strCliDiv: String = '';
                      fltComDiv: Double = 0;
                      fltFatDiv: Double = 0;
                      strCodDiv: String = '';
                      fltValFCP: Double = 0;
                      strAutoIncremCadRec: String = '';
                      LIncDoc: String = '';
                      ASeqMpx: String = '';
                      fltValCBS: Double = 0;
                      fltValIBS: Double = 0;
                      fltVal_IS: Double = 0): Boolean;
  Var
    strSQL   : String;
    strAutInc: String;
    qryGenCtr: TUniQuery;
begin

  Try
    qryGenCtr := fCriaQuery;

    strAutInc := fRetAutoIncrem('DUPAGR', VS_strCodEmp);

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO DUPAGR ';
    strSQL := strSQL + '( ';
    strSQL := strSQL + '  CTR_NUMAGR, ';
    strSQL := strSQL + '  CTR_NUMDUP, ';
    strSQL := strSQL + '  CTR_PARCEL, ';
    strSQL := strSQL + '  CTR_SEQBAI, ';
    strSQL := strSQL + '  CTR_ESPDOC, ';
    strSQL := strSQL + '  CTR_CODCLI, ';
    strSQL := strSQL + '  CTR_CODEMP, ';
    strSQL := strSQL + '  CTR_CODPOR, ';
    strSQL := strSQL + '  CTR_CODVEN, ';
    strSQL := strSQL + '  CTR_CODDIG, ';
    strSQL := strSQL + '  CTR_DTACAD, ';
    strSQL := strSQL + '  CTR_DTAVEN, ';
    strSQL := strSQL + '  CTR_VALDUP, ';
    strSQL := strSQL + '  CTR_VALORI, ';
    strSQL := strSQL + '  CTR_DESCOB, ';
    strSQL := strSQL + '  CTR_DESCON, ';
    strSQL := strSQL + '  CTR_HIST01, ';
    strSQL := strSQL + '  CTR_HIST02, ';
    strSQL := strSQL + '  CTR_ADTCLI, ';
    strSQL := strSQL + '  CTR_CODEVE, ';

    If (Not fEmptyStr(strTipFor)) Then
      strSQL := strSQL + '  CTR_TIPFOR, ';

    If (Not fEmptyStr(strCodCnd)) Then
      strSQL := strSQL + '  CTR_CODCND, ';

    If (Not fEmptyStr(strCodCta)) Then
      strSQL := strSQL + '  CTR_CODCTA, ';

    If (Not fEmptyStr(strCtaSer)) Then
    Begin
      strSQL := strSQL + '  CTR_CTASER, ';
      strSQL := strSQL + '  CTR_SERVAL, ';
    End;

    strSQL := strSQL + '  CTR_CONAPR, ';

    strSQL := strSQL + '  CTR_CODVEL, ';
    strSQL := strSQL + '  AUTOINCREM, ';
    strSQL := strSQL + '  CTR_EMPAGR, ';
    strSQL := strSQL + '  CTR_VALCOM, ';
    strSQL := strSQL + '  CTR_FATCOM, ';
    strSQL := strSQL + '  CTR_FATCO2, ';
    strSQL := strSQL + '  CTR_VALDES, ';
    strSQL := strSQL + '  CTR_VALJUR, ';
    strSQL := strSQL + '  CTR_VALCOB, ';
    strSQL := strSQL + '  CTR_CONPAG, ';
    strSQL := strSQL + '  CTR_CODREP, ';
    strSQL := strSQL + '  CTR_COMREP, ';
    strSQL := strSQL + '  CTR_FATREP, ';
    strSQL := strSQL + '  CTR_VALIPI, ';
    strSQL := strSQL + '  CTR_VALRET, ';
    strSQL := strSQL + '  CTR_VALFCP, ';
    strSQL := strSQL + '  CTR_VALCBS, ';
    strSQL := strSQL + '  CTR_VALIBS, ';
    strSQL := strSQL + '  CTR_VAL_IS, ';
    strSQL := strSQL + '  CTR_EMP_PD, ';
    strSQL := strSQL + '  CTR_DESSUJ, ';
    strSQL := strSQL + '  CTR_JURSUJ, ';
    strSQL := strSQL + '  CTR_BARCON, ';    
    strSQL := strSQL + '  CTR_PERDPO, ';
    strSQL := strSQL + '  CTR_QTDDAV, ';
    strSQL := strSQL + '  CTR_VALACE, ';
    strSQL := strSQL + '  CTR_VALFRE, ';
    strSQL := strSQL + '  CTR_SEQCON, ';
    strSQL := strSQL + '  CTR_VALANT, ';
    strSQL := strSQL + '  CTR_GRVORI, ';
    strSQL := strSQL + '  CTR_DIFORI, ';
    strSQL := strSQL + '  CTR_DOCDIV, ';
    strSQL := strSQL + '  CTR_ESPDIV, ';
    strSQL := strSQL + '  CTR_EMPDIV, ';
    strSQL := strSQL + '  CTR_CLIDIV, ';
    strSQL := strSQL + '  CTR_COMDIV, ';
    strSQL := strSQL + '  CTR_FATDIV, ';
    strSQL := strSQL + '  CTR_CODDIV, ';
    strSQL := strSQL + '  CTR_EMPORI, ';
    strSQL := strSQL + '  CTR_INCDOC, ';
    strSQL := strSQL + '  CTR_SEQMPX) ';
    strSQL := strSQL + 'VALUES ( ';
    strSQL := strSQL + '  :NUMAGR, ';
    strSQL := strSQL + '  :NUMDUP, ';
    strSQL := strSQL + '  :PARCEL, ';
    strSQL := strSQL + '  :SEQBAI, ';
    strSQL := strSQL + '  :ESPDOC, ';
    strSQL := strSQL + '  :CODCLI, ';
    strSQL := strSQL + '  :CODEMP, ';
    strSQL := strSQL + '  :CODPOR, ';
    strSQL := strSQL + '  :CODVEN, ';
    strSQL := strSQL + '  :CODDIG, ';
    strSQL := strSQL + '  :DTACAD, ';
    strSQL := strSQL + '  :DTAVEN, ';
    strSQL := strSQL + '  :VALDUP, ';
    strSQL := strSQL + '  :VALORI, ';
    strSQL := strSQL + '  :DESCOB, ';
    strSQL := strSQL + '  :DESCON, ';
    strSQL := strSQL + '  :HIST01, ';
    strSQL := strSQL + '  :HIST02, ';
    strSQL := strSQL + '  :ADTCLI, ';
    strSQL := strSQL + '  :CODEVE, ';

    If (Not fEmptyStr(strTipFor)) Then
      strSQL := strSQL + '  :TIPFOR, ';

    If (Not fEmptyStr(strCodCnd)) Then
      strSQL := strSQL + '  :CODCND, ';

    If (Not fEmptyStr(strCodCta)) Then
      strSQL := strSQL + '  :CODCTA, ';

    If (Not fEmptyStr(strCtaSer)) Then
    Begin
      strSQL := strSQL + '  :CTASER, ';
      strSQL := strSQL + '  :SERVAL, ';
    End;

    strSQL := strSQL + '  :CONAPR, ';

    strSQL := strSQL + '  :CODVEL, ';
    strSQL := strSQL + '  :AUTINC, ';
    strSQL := strSQL + '  :EMPAGR, ';
    strSQL := strSQL + '  :VALCOM, ';
    strSQL := strSQL + '  :FATCOM, ';
    strSQL := strSQL + '  :FATCO2, ';
    strSQL := strSQL + '  :VALDES, ';
    strSQL := strSQL + '  :VALJUR, ';
    strSQL := strSQL + '  :VALCOB, ';
    strSQL := strSQL + '  :CONPAG, ';
    strSQL := strSQL + '  :CODREP, ';
    strSQL := strSQL + '  :COMREP, ';
    strSQL := strSQL + '  :FATREP, ';
    strSQL := strSQL + '  :VALIPI, ';
    strSQL := strSQL + '  :VALRET, ';
    strSQL := strSQL + '  :VALFCP, ';
    strSQL := strSQL + '  :VALCBS, ';
    strSQL := strSQL + '  :VALIBS, ';
    strSQL := strSQL + '  :VAL_IS, ';
    strSQL := strSQL + '  :EMP_PD, ';
    strSQL := strSQL + '  :DESSUJ, ';
    strSQL := strSQL + '  :JURSUJ, ';
    strSQL := strSQL + '  :BARCON, ';
    strSQL := strSQL + '  :PERDPO, ';
    strSQL := strSQL + '  :QTDDAV, ';
    strSQL := strSQL + '  :VALACE, ';
    strSQL := strSQL + '  :VALFRE, ';
    strSQL := strSQL + '  :SEQCON, ';
    strSQL := strSQL + '  :VALANT, ';
    strSQL := strSQL + '  :GRVORI, ';
    strSQL := strSQL + '  :DIFORI, ';
    strSQL := strSQL + '  :DOCDIV, ';
    strSQL := strSQL + '  :ESPDIV, ';
    strSQL := strSQL + '  :EMPDIV, ';
    strSQL := strSQL + '  :CLIDIV, ';
    strSQL := strSQL + '  :COMDIV, ';
    strSQL := strSQL + '  :FATDIV, ';
    strSQL := strSQL + '  :CODDIV, ';
    strSQL := strSQL + '  :EMPORI, ';
    strSQL := strSQL + '  :INCDOC, ';
    strSQL := strSQL + '  :SEQMPX) ';

    With qryGenCtr Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMAGR').AsString   := strNumAgr;
      ParamByName('NUMDUP').AsString   := strNumDup;
      ParamByName('PARCEL').AsString   := strParcel;
      ParamByName('SEQBAI').AsInteger  := intSeqBai;
      ParamByName('ESPDOC').AsString   := strEspDoc;
      ParamByName('CODCLI').AsString   := strCodCli;
      ParamByName('CODEMP').AsString   := strCodEmp;
      ParamByName('CODVEN').AsString   := strCodVen;

      If fEmptyStr(strCodPor) Then
        ParamByName('CODPOR').Value := Null
      Else
        ParamByName('CODPOR').AsString := strCodPor;

      If fEmptyStr(strCodDig) Then
        ParamByName('CODDIG').Value    := Null
      Else
        ParamByName('CODDIG').AsString := strCodDig;

      ParamByName('DTACAD').AsDateTime := dtaDtaCad;
      ParamByName('DTAVEN').AsDateTime := dtaDtaVen;
      ParamByName('VALDUP').AsFloat    := fltValDup;
      ParamByName('VALORI').AsFloat    := fltValOri;
      ParamByName('DESCOB').AsFloat    := fltDesCob;
      ParamByName('DESCON').AsString   := strDesCon;
      ParamByName('HIST01').AsString   := strHist01;
      ParamByName('HIST02').AsString   := strHist02;
      ParamByName('ADTCLI').AsString   := strAdtCli;

      If (fEmptyStr(strCodEve)) Then
        ParamByName('CODEVE').Value := Null
      Else
        ParamByName('CODEVE').AsString   := strCodEve;

      If (Not fEmptyStr(strTipFor)) Then
        ParamByName('TIPFOR').AsString   := strTipFor;

      If (fEmptyStr(strCodVel)) Then
        ParamByName('CODVEL').Value := Null
      Else
        ParamByName('CODVEL').AsString   := strCodVel;

      If (Not fEmptyStr(strCodCnd)) Then
        ParamByName('CODCND').AsString   := strCodCnd;

      If (Not fEmptyStr(strCodCta)) Then
        ParamByName('CODCTA').AsString   := strCodCta;

      If (Not fEmptyStr(strCtaSer)) Then
      Begin
        ParamByName('CTASER').AsString := strCtaSer;
        ParamByName('SERVAL').AsFloat  := fltSerVal;
      End;

      ParamByName('CONAPR').AsInteger  := IIF(blnConApr, 1, 0);
      ParamByName('EMPAGR').AsString   := strEmpAgr;
      ParamByName('AUTINC').AsString   := strAutInc;

      ParamByName('VALCOM').AsFloat   := Abs(IIF(fltVlrCom < 0, fltVlrCom * -1, fltVlrCom));
      ParamByName('FATCOM').AsFloat   := Abs(IIF(fltFatCom < 0, fltFatCom * -1, fltFatCom));
      ParamByName('FATCO2').AsFloat   := fltFatCo2;
      ParamByName('VALDES').AsFloat   := fltValDes;
      ParamByName('VALJUR').AsFloat   := fltValJur;
      ParamByName('VALCOB').AsFloat   := fltValCob;
      ParamByName('CONPAG').AsString  := strConPag;

      pSetaEmp_PD(qryGenCtr, strEmp_PD, strCodVen, strCodEmp);

      ParamByName('SEQCON').AsInteger := intSeqCon;

      ParamByName('CODREP').AsString  := strCodRep;
      If fEmptyStr(ParamByName('CODREP').AsString) Then
        ParamByName('CODREP').Clear;

      ParamByName('COMREP').AsFloat   := Abs(IIF(fltVlrRep < 0, fltVlrRep * -1, fltVlrRep));
      ParamByName('FATREP').AsFloat   := Abs(IIF(fltFatRep < 0, fltFatRep * -1, fltFatRep));
      ParamByName('VALIPI').AsFloat   := fltValIPI;
      ParamByName('VALRET').AsFloat   := fltValRet;
      ParamByName('VALFCP').AsFloat   := fltValFCP;
      ParamByName('VALCBS').AsFloat   := fltValCBS;
      ParamByName('VALIBS').AsFloat   := fltValIBS;
      ParamByName('VAL_IS').AsFloat   := fltVal_IS;

      ParamByName('DESSUJ').AsFloat   := fltDesSuj;
      ParamByName('JURSUJ').AsFloat   := fltJurSuj;

      If fEmptyStr(strBarCon) Then
        ParamByName('BARCON').Clear
      Else
        ParamByName('BARCON').AsString := strBarCon;

      ParamByName('PERDPO').AsFloat   := fltPerDpo;
      ParamByName('QTDDAV').AsInteger := intQtdDAV;
      ParamByName('VALACE').AsFloat   := fltValAce;
      ParamByName('VALFRE').AsFloat   := fltValFre;
      ParamByName('DIFORI').AsFloat   := fltDifOri;
      ParamByName('VALANT').AsFloat   := fltValAnt;
      ParamByName('DOCDIV').AsString  := strDocDiv;
      ParamByName('ESPDIV').AsString  := strEspDiv;
      ParamByName('EMPDIV').AsString  := strEmpDiv;
      ParamByName('CLIDIV').AsString  := strCliDiv;
      ParamByName('COMDIV').AsFloat   := fltComDiv;
      ParamByName('FATDIV').AsFloat   := fltFatDiv;

      If (fEmptyStr(strCodDiv)) Then
        ParamByName('CODDIV').Value := Null
      Else
        ParamByName('CODDIV').AsString := strCodDiv;

      If fltGrvOri <> 0 Then
        ParamByName('GRVORI').AsFloat := fltGrvOri
      Else
        ParamByName('GRVORI').AsFloat := fltValOri;

      if fEmptyStr(strEmp_PD) then
        ParamByName('EMPORI').AsString  := strCodEmp
      else
        ParamByName('EMPORI').AsString  := strEmp_PD;

      ParamByName('INCDOC').Value  := IIF(fEmptyStr(LIncDoc),Null,LIncDoc);
      ParamByName('SEQMPX').Value  := IIF(ASeqMpx.IsEmpty, Null, ASeqMpx);

      ExecSQL;
      Close;

      Result := True;
    End;

    {*********************************}
    {* GRAVAR TABELA DO SISTEMA DEPS *}
    {******************************AJ*}
    If fCfgSis('USADEP') = 'S' Then
      TValidacoesSistemaDEPS.pGravaLancamentoSistemaDEPS(Concat(strNumDup, '-',
                                                                strParcel, '-',
                                                                strEspDoc, '-',
                                                                strCodEmp, '-',
                                                                strCodCli, '-',
                                                                intSeqBai.ToString),
                                                         'BAIXA');

    FreeAndNil(qryGenCtr);

  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[fGravaDupAgr] - ' + E.Message);
    End;

  End;

  FreeAndNil(qryGenCtr);
end;

{$IFNDEF LINUX}
function fGravaDtaBoletoImpresso(qryArqCtr: TDataSet; ACodigoBanco: String = ''): Boolean;
Var
  strSQL      : String;
  qryGenBco   : TUniQuery;
begin
  qryGenBco := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  CADREC ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  CTR_DTABOL = :DTABOL, ';

  If ACodigoBanco = '077' Then
    strSQL := strSQL + '  CTR_DTAENV = IFNULL(CTR_DTAENV, :DTABOL), ';

  strSQL := strSQL + '  CTR_LINDIG = :LINDIG  ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  CTR_SEQBAI = 0 ';

  Try

    linhaDigitavel := StringReplace(StringReplace(strLinDig,' ','',[rfReplaceAll]),'.','',[rfReplaceAll]) ;

    With qryGenBco Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('DTABOL').AsDateTime := VS_Date;

      ParamByName('NUMDUP').AsString := qryArqCtr.FieldByName('CTR_NUMDUP').AsString;
      ParamByName('PARCEL').AsString := qryArqCtr.FieldByName('CTR_PARCEL').AsString;
      ParamByName('CODCLI').AsString := qryArqCtr.FieldByName('CTR_CODCLI').AsString;
      ParamByName('CODEMP').AsString := qryArqCtr.FieldByName('CTR_CODEMP').AsString;
      ParamByName('ESPDOC').AsString := qryArqCtr.FieldByName('CTR_ESPDOC').AsString;
      // parametro para armazenar a linha digitavel do codigo de barras.
      ParamByName('LINDIG').AsString := linhaDigitavel;

      ExecSQL;
      Close;
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[fGravaDtaBoletoImpresso] - ' + E.Message);
      Exit;
    End;

  End;

  FreeAndNil(qryGenBco);

end;
{$ENDIF}

function fRetornaDuplicataOrigemDespesaCobranca(strProtes,strCodCli,strCodEmp : String): TUniQuery;
Var
  strSQL      : String;
begin
  Result := fCriaQuery();

  strSQL := '';
  strSQL := strSQL + 'SELECT                     ';
  strSQL := strSQL + ' * FROM  CADREC            ';
  strSQL := strSQL + 'WHERE                      ';
  strSQL := strSQL + '  CTR_PROTES = :PROTES     ';
  strSQL := strSQL + '  AND CTR_CODCLI = :CODCLI ';
  strSQL := strSQL + '  AND CTR_CODEMP = :CODEMP ';

  Try
    With Result Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('PROTES').AsString := strProtes;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODEMP').AsString := strCodEmp;
      ExecSQL;
      If Not isEmpty Then
        Result.CreateConstraints;
    End;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
End;

procedure pDesvinculaDespesaCobrancaDaDuplicataOrigem(strNumDup,strParcel,
                                                      strEspDoc,strCodCli,
                                                      strCodEmp: String);
Var
  strSQL      : String;
  qryGenBco   : TUniQuery;
  qryAux      : TUniQuery;
  strProtes   : String;
begin
  Try
    strProtes := strNumDup+strParcel+strEspDoc+strCodEmp;

    qryAux := fRetornaDuplicataOrigemDespesaCobranca(strProtes,strCodCli,strCodEmp);
    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  CTR_PROTES = NULL ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
    strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
    strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC ';
    qryGenBco := fCriaQuery();
    Try
      With qryGenBco Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('NUMDUP').AsString := qryAux.FieldByName('CTR_NUMDUP').AsString;
        ParamByName('PARCEL').AsString := qryAux.FieldByName('CTR_PARCEL').AsString;
        ParamByName('CODCLI').AsString := qryAux.FieldByName('CTR_CODCLI').AsString;
        ParamByName('CODEMP').AsString := qryAux.FieldByName('CTR_CODEMP').AsString;
        ParamByName('ESPDOC').AsString := qryAux.FieldByName('CTR_ESPDOC').AsString;

        ExecSQL;
        Close;
      End;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;

    End;
  Finally
    FreeAndNil(qryGenBco);
    FreeAndNil(qryAux);
  End;
end;

function fGravaDespProt(strNumPro,
                        strNumDup,
                        strParcel,
                        strEspDoc,
                        strCodCli,
                        strCodEmp: String): Boolean;
Var
  strSQL      : String;
  qryGenBco   : TUniQuery;

begin

  qryGenBco := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + 'UPDATE ';
  strSQL := strSQL + '  CADREC ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  CTR_PROTES = :PROTES     ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC ';

  Try

    With qryGenBco Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('PROTES').AsString := strNumPro + 'A' + 'DC' + strCodEmp;
      ParamByName('NUMDUP').AsString := strNumDup;
      ParamByName('PARCEL').AsString := strParcel;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('ESPDOC').AsString := strEspDoc;

      ExecSQL;
      Close;
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;

  End;

  FreeAndNil(qryGenBco);
end;

function fRetAutIncCadRecSeqBaiZero(strNumDoc, strEspDoc, strCodEmp, strCodCli, strParcela: string): String;
begin
  Result := fCampoTabela('AUTOINCREM','CADREC',['CTR_NUMDUP','CTR_ESPDOC','CTR_CODEMP','CTR_CODCLI','CTR_PARCEL','CTR_SEQBAI'],[strNumDoc, strEspDoc, strCodEmp, strCodCli, strParcela, 0],False);
end;

function fRetSeqBaiCadRecDesmembrados(const strNumDoc, strEspDoc, strCodEmp, strCodCli, strParcela : String) : Integer;
  Var
    qryCadRec : TUniQuery;
begin
  qryCadRec := fCriaQuery();
  Try
    Result := 1;
    qryCadRec.Close;
    qryCadRec.SQL.Clear;
    qryCadRec.SQL.Add(' SELECT CTR_SEQBAI ');
    qryCadRec.SQL.Add('   FROM CADREC ');
    qryCadRec.SQL.Add('  WHERE CTR_NUMDUP = :NUMDUP ');
    qryCadRec.SQL.Add('    AND CTR_ESPDOC = :ESPDOC ');
    qryCadRec.SQL.Add('    AND CTR_CODEMP = :CODEMP ');
    qryCadRec.SQL.Add('    AND CTR_CODCLI = :CODCLI ');
    qryCadRec.SQL.Add('    AND CTR_PARCEL = :PARCEL ');
    qryCadRec.SQL.Add('  ORDER BY CTR_SEQBAI ');
    qryCadRec.ParamByName('NUMDUP').AsString := strNumDoc;
    qryCadRec.ParamByName('ESPDOC').AsString := strEspDoc;
    qryCadRec.ParamByName('CODEMP').AsString := strCodEmp;
    qryCadRec.ParamByName('CODCLI').AsString := strCodCli;
    qryCadRec.ParamByName('PARCEL').AsString := strParcela;
    qryCadRec.Open;
    If (qryCadRec.IsEmpty) Then
      Exit;
    qryCadRec.Last;
    Result := qryCadRec.FieldByName('CTR_SEQBAI').AsInteger + 1;
  Finally
    FreeAndNil(qryCadRec);
  End;
end;

function fAlteraValorBoleto(strAutInc: string;
  fltValBol: Double; dtaDtaVenc: TDate): Boolean;
var
  qryBoleto: TUniQuery;
begin
  qryBoleto := fCriaQuery;

  try
    Result := False;

    qryBoleto.Close;
    qryBoleto.SQL.Clear;
    qryBoleto.SQL.Add('UPDATE CADREC');
    qryBoleto.SQL.Add('SET CTR_VALDUP = :VALOR,');
    qryBoleto.SQL.Add('CTR_VALORI = :VALOR,');
    qryBoleto.SQL.Add('CTR_GRVORI = :VALOR,');
    qryBoleto.SQL.Add('CTR_DTAVEN = :DTAVEN');
    qryBoleto.SQL.Add('WHERE AUTOINCREM = :AUTINC');

    qryBoleto.ParamByName('AUTINC').AsString := strAutInc;
    qryBoleto.ParamByName('VALOR').AsFloat := fltValBol;
    qryBoleto.ParamByName('DTAVEN').AsDate := dtaDtaVenc;

    qryBoleto.ExecSQL;

    Result := True;
  finally
    FreeAndNil(qryBoleto);
  end;
end;

function fCriaQryDadosDuplic(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli: String): TUniQuery;
  Var
    strSQL: String;
Begin

  strSQL := '';
  strSQL := strSQL + ' SELECT                     ';
  strSQL := strSQL + '   *                        ';
  strSQL := strSQL + ' FROM                       ';
  strSQL := strSQL + '   CADREC                   ';
  strSQL := strSQL + ' WHERE                      ';
  strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '   CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '   CTR_SEQBAI = 0           ';

  Try
    Result := fCriaQuery(Nil);

    With Result Do
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
  Except
    Result := Nil;
  End;

End;

function fGravaNumCart(strCodBco,
                       strCodPor: String;
                       Var strNosNum: String;
                       Var strNumDig: String;
                       qryArqCtr: TDataSet;
                       ctrDuplicata: PTDuplicataCtr = Nil;
                       strBcoIni: String = '';
                       intCodCar: Integer = 0;
                       strBB_Crr: String = '';
                       fltPerMor: Double = 0;
                       fltPerMul: Double = 0;
                       strEmpresaImpressao: String = ''): Boolean;
Var
    strSQL      : String;
    qryGenCart   : TUniQuery;
    qryLogCtr   : TUniQuery;
    strCfgNosNum: String;

Begin

  qryGenCart    := fCriaQuery;
  strCfgNosNum := fCfgSis('NOSNUM', varString);

  If strEmpresaImpressao.IsEmpty Then
    strEmpresaImpressao := VS_strCodEmp;

  strSQL := '';
  strSQL := strSQL + 'UPDATE CADREC ';
  strSQL := strSQL + 'SET ';
  strSQL := strSQL + '  CTR_CARTEI = :CARTEI,    ';
  strSQL := strSQL + '  CTR_PERMOR = :PERMOR,    ';
  strSQL := strSQL + '  CTR_PERMUL = :PERMUL     ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP AND ';
  strSQL := strSQL + '  CTR_PARCEL = :PARCEL AND ';
  strSQL := strSQL + '  CTR_CODCLI = :CODCLI AND ';
  strSQL := strSQL + '  CTR_CODEMP = :CODEMP AND ';
  strSQL := strSQL + '  CTR_ESPDOC = :ESPDOC AND ';
  strSQL := strSQL + '  CTR_SEQBAI = 0 ';

  Try

    If (Not fEmptyStr(strNosNum)) Or (strCodBco = '778') Then
    Begin

      qryGenCart.Close;
      qryGenCart.SQL.Clear;
      qryGenCart.SQL.Add(strSQL);

      {*****************************************}
      {* DADOS QUE SERO ATUALIZADOS            *}
      {**************************************MV*}

      {************************************************************************************}
      {* CAMPO CTR_CARTEI FOI ALTERADO PARA GRAVAR TODA A CHAVE DA CONFIGURAÇÃO DO AUTBAN *}
      {*REQ-25848-22/01/2015************************************************************JU*}
      qryGenCart.ParamByName('CARTEI').AsString := 'CONFIG' + strBcoIni + '-' + IntToStr(intCodCar) + '-' + strEmpresaImpressao;

      {************************************************************************************}
      {* CRIADADOS CAMPOS PERCENTUAL DE MORA E PERCENTUAL DE MULTA PARA BOLETOS IMPRESSOS *}
      {*REQ-25848-22/01/2015************************************************************JU*}
      qryGenCart.ParamByName('PERMOR').AsFloat  := fltPerMor;
      qryGenCart.ParamByName('PERMUL').AsFloat  := fltPerMul;

      {*****************************************}
      {* DADOS DO FILTRO                       *}
      {**************************************MV*}
      If (ctrDuplicata = Nil) Then
      Begin
        qryGenCart.ParamByName('NUMDUP').AsString := qryArqCtr.FieldByName('CTR_NUMDUP').AsString;
        qryGenCart.ParamByName('PARCEL').AsString := qryArqCtr.FieldByName('CTR_PARCEL').AsString;
        qryGenCart.ParamByName('CODCLI').AsString := qryArqCtr.FieldByName('CTR_CODCLI').AsString;
        qryGenCart.ParamByName('CODEMP').AsString := qryArqCtr.FieldByName('CTR_CODEMP').AsString;
        qryGenCart.ParamByName('ESPDOC').AsString := qryArqCtr.FieldByName('CTR_ESPDOC').AsString;

        qryLogCtr := fCriaQryDadosDuplic(qryArqCtr.FieldByName('CTR_NUMDUP').AsString,
                                         qryArqCtr.FieldByName('CTR_PARCEL').AsString,
                                         qryArqCtr.FieldByName('CTR_ESPDOC').AsString,
                                         qryArqCtr.FieldByName('CTR_CODEMP').AsString,
                                         qryArqCtr.FieldByName('CTR_CODCLI').AsString);
      End
      Else
      Begin
        qryGenCart.ParamByName('NUMDUP').AsString := ctrDuplicata^.strNumDup;
        qryGenCart.ParamByName('PARCEL').AsString := ctrDuplicata^.strParcel;
        qryGenCart.ParamByName('CODCLI').AsString := ctrDuplicata^.strCodCli;
        qryGenCart.ParamByName('CODEMP').AsString := ctrDuplicata^.strCodEmp;
        qryGenCart.ParamByName('ESPDOC').AsString := ctrDuplicata^.strEspDoc;

        qryLogCtr := fCriaQryDadosDuplic(ctrDuplicata^.strNumDup,
                                         ctrDuplicata^.strParcel,
                                         ctrDuplicata^.strEspDoc,
                                         ctrDuplicata^.strCodEmp,
                                         ctrDuplicata^.strCodCli);
      End;
      qryGenCart.ExecSQL;

      qryGenCart.Close;

    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[fGravaNumBco] - ' + E.Message);
      Exit;
    End;

  End;

  FreeAndNil(qryGenCart);
  FreeAndNil(qryLogCtr);
end;

function fGravaVencimento(dteVencimento: TDate; fltDesSuj, fltJurSuj: Double;
  strHistorico, strAutoincrem, strNomeForm: String; strHisPro : String = ''): Boolean;
Var
  strSQL : String;
  qryGen : TUniQuery;
  qryAux : TUniQuery;
  strSQLAux: String;
begin
  Try
    strSQL := '';
    strSQL := strSQL + 'UPDATE CADREC              ';
    strSQL := strSQL + 'SET                        ';
    strSQL := strSQL + '  CTR_DTAVEN = :DTAVEN,    ';
    strSQL := strSQL + '  CTR_DESSUJ = :DESSUJ,    ';
    strSQL := strSQL + '  CTR_JURSUJ = :JURSUJ,    ';
    strSQL := strSQL + '  CTR_HIST01 = :HIST01     ';
    strSQL := strSQL + 'WHERE                      ';
    strSQL := strSQL + '  AUTOINCREM = :AUTOINCREM ';

    strSQLAux := '';
    strSQLAux := strSQLAux + ' SELECT SQL_NO_CACHE        ';
    strSQLAux := strSQLAux + '   CTR_NUMDUP,              ';
    strSQLAux := strSQLAux + '   CTR_PARCEL,              ';
    strSQLAux := strSQLAux + '   CTR_SEQBAI,              ';
    strSQLAux := strSQLAux + '   CTR_ESPDOC,              ';
    strSQLAux := strSQLAux + '   CTR_CODCLI,              ';
    strSQLAux := strSQLAux + '   CTR_CODEMP,              ';
    strSQLAux := strSQLAux + '   CTR_VALDUP,              ';
    strSQLAux := strSQLAux + '   CTR_DTAVEN               ';
    strSQLAux := strSQLAux + ' FROM                       ';
    strSQLAux := strSQLAux + '   CADREC                   ';
    strSQLAux := strSQLAux + ' WHERE                      ';
    strSQLAux := strSQLAux + '  AUTOINCREM = :AUTOINCREM  ';

    qryGen := fCriaQuery;
    qryAux := fCriaQuery;

    Try
      With qryAux Do
      Begin
        SQL.Add(strSQLAux);
        ParamByName('AUTOINCREM').AsString := strAutoincrem;
        Open;

        If Not IsEmpty Then
        Begin
          If dteVencimento > FieldByName('CTR_DTAVEN').AsDateTime Then
          Begin
            fGravaCtrPrd(FieldByName('CTR_NUMDUP').AsString,
                         FieldByName('CTR_PARCEL').AsString,
                         FieldByName('CTR_SEQBAI').AsInteger,
                         FieldByName('CTR_ESPDOC').AsString,
                         FieldByName('CTR_CODCLI').AsString,
                         FieldByName('CTR_CODEMP').AsString,
                         FieldByName('CTR_VALDUP').AsFloat,
                         FieldByName('CTR_DTAVEN').AsDateTime,
                         dteVencimento,
                         strLoginUsuarioLogado,
                         strNomeForm,
                         strHisPro);
          End;
        End;
      End;

      With qryGen Do
      Begin
        SQL.Add(strSQL);
        ParamByName('DTAVEN').AsDateTime   := dteVencimento;
        ParamByName('DESSUJ').AsFloat      := fltDesSuj;
        ParamByName('JURSUJ').AsFloat      := fltJurSuj;
        ParamByName('HIST01').AsString     := strHistorico;
        ParamByName('AUTOINCREM').AsString := strAutoincrem;
        ExecSQL;
      End;
    Finally
      FreeAndNil(qryGen);
      FreeAndNil(qryAux);
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create('[fGravaVencimento] - ' + E.Message);
    End;
  End;
end;

function fRetUltimaAlteracaoCadRecGeral(strNumDup, strEspDoc, strCodEmp, strCodCli: String): TDateTime;
  Var
    qryLogCtr: TUniQuery;
    strSQL   : String;
Begin
  Result := 0;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT                          ';
    strSQL := strSQL + '      CTR_DTALOG,               ';
    strSQL := strSQL + '      CTR_HORLOG                ';
    strSQL := strSQL + 'FROM LOGCTR                     ';
    strSQL := strSQL + 'WHERE CTR_NUMDUP = :NUMDUP AND  ';
    strSQL := strSQL + '      CTR_ESPDOC = :ESPDOC AND  ';
    strSQL := strSQL + '      CTR_CODCLI = :CODCLI AND  ';
    strSQL := strSQL + '      CTR_CODEMP = :CODEMP      ';
    strSQL := strSQL + 'ORDER BY CTR_DTALOG DESC,       ';
    strSQL := strSQL + '         CTR_HORLOG DESC        ';

    qryLogCtr := fCriaQuery;
    With qryLogCtr Do
    Begin
      SQL.Text := strSQL;

      ParamByName('NUMDUP').AsString  := strNumDup;
      ParamByName('ESPDOC').AsString  := strEspDoc;
      ParamByName('CODCLI').AsString  := strCodCli;
      ParamByName('CODEMP').AsString  := strCodEmp;
      Open;
      First;

      If Not IsEmpty Then
        Result := StrToDateTime(FieldByName('CTR_DTALOG').AsString + ' ' +
                                FieldByName('CTR_HORLOG').AsString);
    End;

    FreeAndNil(qryLogCtr);
  Except
    On E:Exception Do
      Raise Exception.Create('Ocorreu um erro ao buscar a última alteração da duplicata de contas a receber.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
End;

procedure pLimpaVariaveisCadRec;
begin
  strLogCtrNosNum := '';
  strLogCtrCodCar := '';
  strLogCtrCodBco := '';
  linhaDigitavel  := '';
end;

procedure pGravaLogCtr(strAutInc, strDescricaoLog, strNomForm: String); Overload;
begin
  Try
    untLogCtr.GravaLogCtr(strAutInc,
                          strDescricaoLog,
                          strNomForm);
  Except
    On E: EUniError Do
    Begin
      if (fExecutadoViaRoboEnvioEmail) then
        fRollBack;
      If E.ErrorCode = ERROR_PRIMARY_KEY_INSERT Then
        Raise ExceptionAutCom.Create('Já existe um registro com esses Dados! - ' + E.Message)
      Else
        Raise Exception.Create('[untCadRec.pGravaLogCtr] - ' + E.Message);
    End;

    On E: Exception Do
    Begin
      if (fExecutadoViaRoboEnvioEmail) then
        fRollBack;
      Raise Exception.Create('[untCadRec.pGravaLogCtr] - ' + E.Message);
    End;
  End;
end;

procedure pGravaLogCtr(strNumDup, strEspDoc, strCodCli,
  strCodEmp, strParcel: String; intSeqBai: Integer;
  strDescricaoLog, strNomForm: String); Overload;
begin
  Try
    untLogCtr.GravaLogCtr(strNumDup,
                          strEspDoc,
                          strCodCli,
                          strCodEmp,
                          strParcel,
                          intSeqBai,
                          strDescricaoLog,
                          strNomForm);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar o log: ' + E.Message);
  End;
end;

procedure pGravaLogCtr(strNumDup, strEspDoc, strCodCli,
  strCodEmp, strParcel: String; intSeqBai: Integer;
  strDescricaoLog, strNomForm: String; fltDespCobr : Double); Overload;
begin
  Try
    untLogCtr.GravaLogCtr(strNumDup,
                          strEspDoc,
                          strCodCli,
                          strCodEmp,
                          strParcel,
                          intSeqBai,
                          strDescricaoLog,
                          strNomForm,
                          fltDespCobr);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar o log: ' + E.Message);
  End;
end;

function fRetUltimaAlteracaoCadRec(strNumDup, strParcel, strEspDoc, strCodCli,
                                   strCodEmp: String; intSeqBai: Integer = 0): TDateTime;
  Var
    qryLogCtr: TUniQuery;
    strSQL   : String;
Begin
  Result := 0;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT                          ';
    strSQL := strSQL + '      CTR_DTALOG,               ';
    strSQL := strSQL + '      CTR_HORLOG                ';
    strSQL := strSQL + 'FROM LOGCTR                     ';
    strSQL := strSQL + 'WHERE CTR_NUMDUP = :NUMDUP AND  ';
    strSQL := strSQL + '      CTR_PARCEL = :PARCEL AND  ';
    strSQL := strSQL + '      CTR_ESPDOC = :ESPDOC AND  ';
    strSQL := strSQL + '      CTR_CODCLI = :CODCLI AND  ';
    strSQL := strSQL + '      CTR_CODEMP = :CODEMP AND  ';
    strSQL := strSQL + '      CTR_SEQBAI = :SEQBAI AND  ';
    strSQL := strSQL + '      CTR_NOMFRM NOT IN("untTEnvioEmailAutController") ';
    strSQL := strSQL + 'ORDER BY CTR_DTALOG DESC,       ';
    strSQL := strSQL + '         CTR_HORLOG DESC        ';

    qryLogCtr := fCriaQuery;
    With qryLogCtr Do
    Begin
      SQL.Text := strSQL;

      ParamByName('NUMDUP').AsString  := strNumDup;
      ParamByName('PARCEL').AsString  := strParcel;
      ParamByName('ESPDOC').AsString  := strEspDoc;
      ParamByName('CODCLI').AsString  := strCodCli;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('SEQBAI').AsInteger := intSeqBai;
      Open;

      If Not IsEmpty Then
      Begin
        Result := StrtoDateTime(FieldByName('CTR_DTALOG').AsString + ' ' +
                                FieldByName('CTR_HORLOG').AsString);

        Result := IncHour(Result, -fCfgSis('HRAATM',varInteger));
      End;


    End;

    FreeAndNil(qryLogCtr);
  Except
    On E:Exception Do
      Raise Exception.Create('Ocorreu um erro ao buscar a última alteração da duplicata de contas a receber.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
End;

function fGetUltimaAlteracaoCadRec(strNumDup, strParcel, strEspDoc, strCodCli,
                                   strCodEmp: String; intSeqBai: Integer = 0): String;
  Var
    qryLogCtr: TUniQuery;
    strSQL   : String;
Begin
  Result := '';
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT                          ';
    strSQL := strSQL + '      CTR_DESCRI                ';
    strSQL := strSQL + 'FROM LOGCTR                     ';
    strSQL := strSQL + 'WHERE CTR_NUMDUP = :NUMDUP AND  ';
    strSQL := strSQL + '      CTR_PARCEL = :PARCEL AND  ';
    strSQL := strSQL + '      CTR_ESPDOC = :ESPDOC AND  ';
    strSQL := strSQL + '      CTR_CODCLI = :CODCLI AND  ';
    strSQL := strSQL + '      CTR_CODEMP = :CODEMP AND  ';
    strSQL := strSQL + '      CTR_SEQBAI = :SEQBAI AND  ';
    strSQL := strSQL + '      CTR_NOMFRM NOT IN("untTEnvioEmailAutController") ';
    strSQL := strSQL + 'ORDER BY CTR_DTALOG DESC,       ';
    strSQL := strSQL + '         CTR_HORLOG DESC        ';

    qryLogCtr := fCriaQuery;
    With qryLogCtr Do
    Begin
      SQL.Text := strSQL;

      ParamByName('NUMDUP').AsString  := strNumDup;
      ParamByName('PARCEL').AsString  := strParcel;
      ParamByName('ESPDOC').AsString  := strEspDoc;
      ParamByName('CODCLI').AsString  := strCodCli;
      ParamByName('CODEMP').AsString  := strCodEmp;
      ParamByName('SEQBAI').AsInteger := intSeqBai;
      Open;

      If Not IsEmpty Then
        Result :=  FieldByName('CTR_DESCRI').AsString;
    End;

    FreeAndNil(qryLogCtr);
  Except
    On E:Exception Do
      Raise Exception.Create('Ocorreu um erro ao buscar a última alteração da duplicata de contas a receber.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
End;

{***********************************}
{* FUNÇÃO QUE GRAVA LOG ESPECÍFICO *}
{* DE PRORROGAÇÃO DE VENCIMENTO CTR*}
{********************************JU*}
function fGravaCtrPrd(strNumDup,
                      strParcel: String;
                      intSeqBai: Integer;
                      strEspDoc,
                      strCodCli,
                      strCodEmp: String;
                      fltValDup: Double;
                      dtaDtaVc1,
                      dtaDtaVc2: TDateTime;
                      strOpeAlt,
                      strNomFrm: String;
                      strHisPro: String): Boolean;
  Var
    fltDiaPrd: Double;
    intSeqPrd: Integer;
    qryAux   : TUniQuery;
    qryCtrPrd: TUniQuery;
    strSQL   : String;
Begin
  Try
    Try
      qryAux    := fCriaQuery(Nil);
      qryCtrPrd := fCriaQuery(Nil);

      strSQL := '';
      strSQL := strSQL + ' SELECT SQL_NO_CACHE          ';
      strSQL := strSQL + '   MAX(CTR_SEQPRD) AS  SEQPRD ';
      strSQL := strSQL + ' FROM                         ';
      strSQL := strSQL + '   CTRPRD                     ';
      strSQL := strSQL + ' WHERE                        ';
      strSQL := strSQL + '   CTR_NUMDUP = :NUMDUP AND   ';
      strSQL := strSQL + '   CTR_PARCEL = :PARCEL AND   ';
      strSQL := strSQL + '   CTR_SEQBAI = :SEQBAI AND   ';
      strSQL := strSQL + '   CTR_ESPDOC = :ESPDOC AND   ';
      strSQL := strSQL + '   CTR_CODCLI = :CODCLI AND   ';
      strSQL := strSQL + '   CTR_CODEMP = :CODEMP       ';

      With qryAux Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDUP').AsString := strNumDup;
        ParamByName('PARCEL').AsString := strParcel;
        ParamByName('SEQBAI').AsInteger:= intSeqBai;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODCLI').AsString := strCodCli;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        If Not IsEmpty Then
          intSeqPrd := FieldByName('SEQPRD').AsInteger + 1
        Else
          intSeqPrd := 0;
      End;

      strSQL := '';
      strSQL := strSQL + ' INSERT INTO CTRPRD (';
      strSQL := strSQL + '   AUTOINCREM,       ';
      strSQL := strSQL + '   CTR_NUMDUP,       ';
      strSQL := strSQL + '   CTR_PARCEL,       ';
      strSQL := strSQL + '   CTR_SEQBAI,       ';
      strSQL := strSQL + '   CTR_ESPDOC,       ';
      strSQL := strSQL + '   CTR_CODCLI,       ';
      strSQL := strSQL + '   CTR_CODEMP,       ';
      strSQL := strSQL + '   CTR_VALDUP,       ';
      strSQL := strSQL + '   CTR_DTAVC1,       ';
      strSQL := strSQL + '   CTR_DTAVC2,       ';
      strSQL := strSQL + '   CTR_DTAALT,       ';
      strSQL := strSQL + '   CTR_HORALT,       ';
      strSQL := strSQL + '   CTR_OPEALT,       ';
      strSQL := strSQL + '   CTR_NOMFRM,       ';
      strSQL := strSQL + '   CTR_DIAPRD,       ';
      strSQL := strSQL + '   CTR_SEQPRD,       ';
      strSQL := strSQL + '   CTR_HISPRO)       ';
      strSQL := strSQL + ' VALUES (            ';
      strSQL := strSQL + '   :AUTINC,          ';
      strSQL := strSQL + '   :NUMDUP,          ';
      strSQL := strSQL + '   :PARCEL,          ';
      strSQL := strSQL + '   :SEQBAI,          ';
      strSQL := strSQL + '   :ESPDOC,          ';
      strSQL := strSQL + '   :CODCLI,          ';
      strSQL := strSQL + '   :CODEMP,          ';
      strSQL := strSQL + '   :VALDUP,          ';
      strSQL := strSQL + '   :DTAVC1,          ';
      strSQL := strSQL + '   :DTAVC2,          ';
      strSQL := strSQL + '   :DTAALT,          ';
      strSQL := strSQL + '   :HORALT,          ';
      strSQL := strSQL + '   :OPEALT,          ';
      strSQL := strSQL + '   :NOMFRM,          ';
      strSQL := strSQL + '   :DIAPRD,          ';
      strSQL := strSQL + '   :SEQPRD,          ';
      strSQL := strSQL + '   :HISPRO)          ';

      fltDiaPrd := dtaDtaVc2 - dtaDtaVc1;

      With qryCtrPrd Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTINC').AsString  := fRetAutoIncrem('CTRPRD', strCodEmp);
        ParamByName('NUMDUP').AsString  := strNumDup;
        ParamByName('PARCEL').AsString  := strParcel;
        ParamByName('SEQBAI').AsInteger := intSeqBai;
        ParamByName('ESPDOC').AsString  := strEspDoc;
        ParamByName('CODCLI').AsString  := strCodCli;
        ParamByName('CODEMP').AsString  := strCodEmp;
        ParamByName('VALDUP').AsFloat   := fltValDup;
        ParamByName('DTAVC1').AsDateTime:= dtaDtaVc1;
        ParamByName('DTAVC2').AsDateTime:= dtaDtaVc2;
        ParamByName('DTAALT').AsDateTime:= VS_Date;
        ParamByName('HORALT').AsDateTime:= fTime();
        ParamByName('OPEALT').AsString  := strLoginUsuarioLogado;
        ParamByName('NOMFRM').AsString  := strNomFrm;
        ParamByName('DIAPRD').AsFloat   := fltDiaPrd;
        ParamByName('SEQPRD').AsInteger := intSeqPrd;
        ParamByName('HISPRO').AsString  := strHisPro;
        ExecSQL;
      End;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(qryAux);
    FreeAndNil(qryCtrPrd);
  End;
End;

function fCreditoGeradoPeloAdiantamento(strNumDup,
                                        strParcel,
                                        strCodEmp,
                                        strCodCli: String;
                                        Var strNumeroPedido: String): Boolean;
  Var
    qryConsulta: TUniQuery;
Begin
  qryConsulta := fCriaQuery;

  qryConsulta.SQL.Add('SELECT L.*, CONCAT(A.ADT_NUMDOC, "-", A.ADT_ESPDOC) ');
  qryConsulta.SQL.Add('       AS NUMDOC                                    ');
  qryConsulta.SQL.Add('FROM LOGCTR L                                       ');
  qryConsulta.SQL.Add('  JOIN ADTCLI A ON A.ADT_SEQCON=L.CTR_SEQCON        ');
  qryConsulta.SQL.Add('               AND A.ADT_CODEMP=L.CTR_CODEMP        ');
  qryConsulta.SQL.Add('               AND A.ADT_TIPLAN="D"                 ');
  qryConsulta.SQL.Add('WHERE L.CTR_NUMDUP=:NUMDUP                          ');
  qryConsulta.SQL.Add('  AND L.CTR_PARCEL=:PARCEL                          ');
  qryConsulta.SQL.Add('  AND L.CTR_CODEMP=:CODEMP                          ');
  qryConsulta.SQL.Add('  AND L.CTR_CODCLI=:CODCLI                          ');
  qryConsulta.SQL.Add('  AND L.CTR_ESPDOC="CC"                             ');
  qryConsulta.SQL.Add('  AND L.CTR_DESCRI IN("INCLUSÃO","INCLUSÃO LD")     ');
  qryConsulta.SQL.Add('  AND L.CTR_SEQCON IS NOT NULL AND L.CTR_SEQCON > 0 ');

  qryConsulta.ParamByName('NUMDUP').AsString := strNumDup;
  qryConsulta.ParamByName('PARCEL').AsString := strParcel;
  qryConsulta.ParamByName('CODEMP').AsString := strCodEmp;
  qryConsulta.ParamByName('CODCLI').AsString := strCodCli;

  qryConsulta.Open;

  Result := (Not qryConsulta.IsEmpty);

  strNumeroPedido := '';
  If Result Then
    strNumeroPedido := qryConsulta.FieldByName('NUMDOC').AsString;

  FreeAndNil(qryConsulta);
End;

function fPermitiDesagruparDuplicata(AstrNumeroAgrupamento, AstrCodigoCliente: String): Boolean;
Var
  SQuery : TUniQuery;
  SMensagem : String;
begin
  Result := True;

  Try
    SQuery := fCriaQuery;

    Try
      SQuery.SQL.Text := ' SELECT DISTINCT D.CTR_NUMAGR '+
                         '   FROM DUPAGR D '+
                         '  WHERE D.CTR_NUMDUP = :CTR_NUMDUP '+
                         '    AND D.CTR_EMPAGR = :CTR_EMPAGR '+
                         '    AND D.CTR_CODCLI = :CTR_CODCLI '+
                         '    AND D.CTR_ESPDOC = "AG"        ';
      SQuery.ParamByName('CTR_NUMDUP').AsString := AstrNumeroAgrupamento;
      SQuery.ParamByName('CTR_EMPAGR').AsString := VS_strCodEmp;
      SQuery.ParamByName('CTR_CODCLI').AsString := AstrCodigoCliente;
      SQuery.Open;
      if not SQuery.IsEmpty then
        begin
          Result    := False;
          SMensagem := '';
          while not SQuery.Eof do
            begin
              if fEmptyStr(SMensagem) then
                SMensagem := SQuery.FieldByName('CTR_NUMAGR').AsString
              else
                SMensagem := SMensagem + ', ' + SQuery.FieldByName('CTR_NUMAGR').AsString;
              SQuery.Next;
            end;
          pMensagemOk('Não será possível desagrupar esta duplicata pois existem outros agrupamentos '+
            'provenientes desta. É necessário desagrupar as duplicatas provenientes.'+
            ' São elas: '+SMensagem);
        end;
      SQuery.Close;
    Except
      On E: Exception Do
      Begin
        Result := False;
        Raise Exception.Create('[fPermitiDesagruparDuplicata] - ' + E.Message);
      End;

    End;
  Finally
    FreeAndNil(SQuery);
  End;

end;

function fRetornaSobraDeJurosDeBaixasAnteriores(strNumDup,
                                                strParcel,
                                                strEspDoc,
                                                strCodEmp,
                                                strCodCli,
                                                strSeqBai: String): Double;
  Var
    qrySobraJuros: TUniQuery;
Begin
  Try
    qrySobraJuros := fCriaQuery;

    qrySobraJuros.SQL.Text := 'SELECT IFNULL(fRetornaSobraJurosCTR("' + strNumDup + '", "' +
                                                                        strEspDoc + '", "' +
                                                                        strCodEmp + '", "' +
                                                                        strParcel + '", "' +
                                                                        strCodCli + '", ' +
                                                                        strSeqBai + '), 0) AS VALOR';
    qrySobraJuros.Open;

    Result := qrySobraJuros.FieldByName('VALOR').AsFloat;
  Finally
    FreeAndNil(qrySobraJuros);
  End;
End;

function fCadRecExiste(strNumDup, strEspDoc, strCodEmp, strCodCli: string): boolean;
  var
    qryCadRec : TUniQuery;
Begin
  qryCadRec := fCriaQuery;
  Try
    qryCadRec.SQL.Add(' SELECT COUNT(*) AS CNT ');
    qryCadRec.SQL.Add('   FROM CADREC ');
    qryCadRec.SQL.Add('  WHERE CTR_NUMDUP = :NUMDUP ');
    qryCadRec.SQL.Add('    AND CTR_ESPDOC = :ESPDOC ');
    qryCadRec.SQL.Add('    AND CTR_CODEMP = :CODEMP ');
    qryCadRec.SQL.Add('    AND CTR_CODCLI = :CODCLI ');
    qryCadRec.ParamByName('NUMDUP').AsString  := strNumDup;
    qryCadRec.ParamByName('ESPDOC').AsString  := strEspDoc;
    qryCadRec.ParamByName('CODEMP').AsString  := strCodEmp;
    qryCadRec.ParamByName('CODCLI').AsString  := strCodCli;
    qryCadRec.Open;
    Result := (qryCadRec.FieldByName('CNT').AsInteger > 0);
    qryCadRec.Close;
  finally
    FreeAndNil(qryCadRec);
  End;
End;

function fRetornaCodigoEmpresaDup(strAutoInc: string): String;
  var
    qryCadRec : TUniQuery;
Begin
  qryCadRec := fCriaQuery;
  Try
    qryCadRec.SQL.Add(' SELECT CTR_CODEMP ');
    qryCadRec.SQL.Add('   FROM CADREC ');
    qryCadRec.SQL.Add('  WHERE AUTOINCREM = :AUTOIN ');
    qryCadRec.ParamByName('AUTOIN').AsString  := strAutoInc;
    qryCadRec.Open;
    Result := qryCadRec.FieldByName('CTR_CODEMP').AsString;
    qryCadRec.Close;
  finally
    FreeAndNil(qryCadRec);
  End;
End;

function fRetornaNomeArquivoBol(strAutoInc: string): String;
  var
    qryCadRec : TUniQuery;
Begin
  qryCadRec := fCriaQuery;
  Try
    qryCadRec.SQL.Add(' SELECT '); //CONCAT(CTR_NUMDUP, CTR_PARCEL) AS NUMDUP ');

    If fCfgSis('NOVLAY') = 'C' Then
       qryCadRec.SQL.Add(' CTR_NUMDUP AS NUMDUP ')
    Else
       qryCadRec.SQL.Add(' CONCAT(CTR_NUMDUP, CTR_PARCEL) AS NUMDUP ');

    qryCadRec.SQL.Add('   FROM CADREC ');
    qryCadRec.SQL.Add('  WHERE AUTOINCREM = :AUTOIN ');
    qryCadRec.ParamByName('AUTOIN').AsString  := strAutoInc;
    qryCadRec.Open;
    Result := qryCadRec.FieldByName('NUMDUP').AsString;
    qryCadRec.Close;
  finally
    FreeAndNil(qryCadRec);
  End;
End;

procedure GravarCarteiraBoleto(ADuplicata: TDuplicataCtr; AChaveCarteira: String);
  Var
    LCarBol: TUniQuery;
    LChaveSemCarteira: String;
Begin

  If Not fCfgSis('BOLORI', varBoolean) Then
    Exit;

  Try
    LCarBol := fCriaQuery(Nil);

    LChaveSemCarteira := LeftStr(AChaveCarteira, AChaveCarteira.Length - 6);
    LChaveSemCarteira := LChaveSemCarteira + RightStr(AChaveCarteira,4);

    Try
      DeletarCarteiraBoleto(ADuplicata);

      LCarBol.Close;
      LCarBol.SQL.Clear;
      LCarBol.SQL.Text := ' REPLACE INTO CARBOL (       '+
                          '   CAR_CHAVE_,               '+
                          '   CAR_CODCFG,               '+
                          '   CAR_VALCFG,               '+
                          '   CAR_NUMDUP,               '+
                          '   CAR_PARCEL,               '+
                          '   CAR_ESPDOC,               '+
                          '   CAR_CODEMP,               '+
                          '   CAR_CODCLI                '+
                          ' )                           '+
                          ' SELECT                      '+
                          '   SIS_CHAVE_,               '+
                          '   SIS_CODCFG,               '+
                          '   SIS_VALCFG,               '+
                          '   :NUMDUP,                  '+
                          '   :PARCEL,                  '+
                          '   :ESPDOC,                  '+
                          '   :CODEMP,                  '+
                          '   :CODCLI                   '+
                          ' FROM                        '+
                          '   CFGBAN                    '+
                          ' WHERE SIS_CHAVE_ IN (       '+
                          '  :CHAVECOMPLETA,            '+
                          '  :CHAVERESUMIDA)            ';

      LCarBol.ParamByName('CHAVECOMPLETA').AsString := AChaveCarteira;
      LCarBol.ParamByName('CHAVERESUMIDA').AsString := LChaveSemCarteira;

      LCarBol.ParamByName('NUMDUP').AsString := ADuplicata.strNumDup;
      LCarBol.ParamByName('PARCEL').AsString := ADuplicata.strParcel;
      LCarBol.ParamByName('ESPDOC').AsString := ADuplicata.strEspDoc;
      LCarBol.ParamByName('CODEMP').AsString := ADuplicata.strCodEmp;
      LCarBol.ParamByName('CODCLI').AsString := ADuplicata.strCodCli;

      LCarBol.ExecSQL;

      LCarBol.Close;
      LCarBol.SQL.Clear;
      LCarBol.SQL.Text := ' REPLACE INTO CARBOL (       '+
                          '   CAR_CHAVE_,               '+
                          '   CAR_CODCFG,               '+
                          '   CAR_VALCFG,               '+
                          '   CAR_NUMDUP,               '+
                          '   CAR_PARCEL,               '+
                          '   CAR_ESPDOC,               '+
                          '   CAR_CODEMP,               '+
                          '   CAR_CODCLI                '+
                          ' )                           '+
                          ' VALUES (                    '+
                          '   :CHAVE,                   '+
                          '   :CODCFG,                  '+
                          '   :VALCFG,                  '+
                          '   :NUMDUP,                  '+
                          '   :PARCEL,                  '+
                          '   :ESPDOC,                  '+
                          '   :CODEMP,                  '+
                          '   :CODCLI)                  ';

      LCarBol.ParamByName('CHAVE').AsString := AChaveCarteira;
      LCarBol.ParamByName('CODCFG').AsString := 'CFG_TAXDIA';
      LCarBol.ParamByName('VALCFG').AsString := FloatToStrF(fCfgSis('TAXDIA', varDouble), ffFixed, 12, 2);

      LCarBol.ParamByName('NUMDUP').AsString := ADuplicata.strNumDup;
      LCarBol.ParamByName('PARCEL').AsString := ADuplicata.strParcel;
      LCarBol.ParamByName('ESPDOC').AsString := ADuplicata.strEspDoc;
      LCarBol.ParamByName('CODEMP').AsString := ADuplicata.strCodEmp;
      LCarBol.ParamByName('CODCLI').AsString := ADuplicata.strCodCli;

      LCarBol.ExecSQL;



    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LCarBol);
  End;
End;

procedure DeletarCarteiraBoleto(ADuplicata: TDuplicataCtr);
  Var
    LCarBol: TUniQuery;
Begin

  If Not fCfgSis('BOLORI', varBoolean) Then
    Exit;

  Try
    LCarBol := fCriaQuery(Nil);

    Try
      LCarBol.Close;
      LCarBol.SQL.Clear;
      LCarBol.SQL.Text := '  DELETE                      '+
                          '  FROM                        '+
                          '    CARBOL                    '+
                          '  WHERE CAR_NUMDUP = :NUMDUP  '+
                          '    AND CAR_PARCEL = :PARCEL  '+
                          '    AND CAR_ESPDOC = :ESPDOC  '+
                          '    AND CAR_CODEMP = :CODEMP  '+
                          '    AND CAR_CODCLI = :CODCLI  ';

      LCarBol.ParamByName('NUMDUP').AsString := ADuplicata.strNumDup;
      LCarBol.ParamByName('PARCEL').AsString := ADuplicata.strParcel;
      LCarBol.ParamByName('ESPDOC').AsString := ADuplicata.strEspDoc;
      LCarBol.ParamByName('CODEMP').AsString := ADuplicata.strCodEmp;
      LCarBol.ParamByName('CODCLI').AsString := ADuplicata.strCodCli;

      LCarBol.ExecSQL;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LCarBol);
  End;
End;

procedure GravarPDFBoleto(AAutoIncremCadRec,
                          ACaminhoDoArquivo: String;
                          AArquivo: TFileStream = Nil);
  Var
    LQueryBolCtr: TUniQuery;

    LSQL,
    LBase64: String;
    intCont: Integer;
    LArqCopy : String;
Begin
  If Not fCfgSis('BOLCTR', varBoolean) Then
    Exit;

  intCont := 0;

  Try
    If AArquivo = Nil Then
    Begin
      If Not FileExists(ACaminhoDoArquivo) Then
        Exit;
    End;

    {USAMOS UMA COPIA DO BOLETO ORIGINAL PARA EVITAR ERROS DE DOCUMENTOS SENDO USADO POR OUTRO PROCESSO}
    LArqCopy := ExtractFilePath(Application.ExeName) + 'Boletos\' +  AAutoIncremCadRec + FormatDateTime('DDMMYYYYHHNNSS', Date + fTime()) + '.pdf' ;

    LQueryBolCtr := fCriarQuery('SELECT AUTOINCREM FROM BOLCTR ' +
                                ' WHERE BOL_SEQCTR=' + AAutoIncremCadRec.QuotedString);
    try
      LQueryBolCtr.Open;

      LSQL := '';
      If Not LQueryBolCtr.IsEmpty Then
        LSQL := LSQL + 'UPDATE BOLCTR SET BOL_BOLETO=:BOLETO ' +
                       ' WHERE AUTOINCREM=' + LQueryBolCtr.FieldByName('AUTOINCREM').AsString.QuotedString
      Else
        LSQL := LSQL + 'INSERT INTO BOLCTR (AUTOINCREM, BOL_SEQCTR, ' +
                       '                     BOL_BOLETO) VALUES    (' +
                       fRetAutoIncrem('BOLCTR', VS_strCodEmp).QuotedString + ', ' +
                       AAutoIncremCadRec.QuotedString + ', ' +
                       ':BOLETO) ';

      LQueryBolCtr.Close;
      LQueryBolCtr.SQL.Text := LSQL;

      If AArquivo = Nil Then
      Begin
        while not Assigned(AArquivo) and (intCont <= 2) do
        begin
          try
            Inc(intCont);
            Sleep(200);
            Try

              If Not FileExists(LArqCopy) Then
                TFile.Copy(ACaminhoDoArquivo, LArqCopy);

              AArquivo := TFileStream.Create(LArqCopy, fmOpenRead or fmShareDenyWrite);
              LBase64 := TIdEncoderMIME.EncodeStream(AArquivo);

            Finally
              If Assigned (AArquivo) Then
                FreeAndNil(AArquivo);
            end;
          except
            on E: Exception do
            begin
              if not ((Pos('o arquivo já está sendo usado por outro processo', LowerCase(E.Message)) > 0) and (intCont < 2)) then
                Raise Exception.Create('Ocorreu um erro ao gravar o PDF do boleto.' + #13 +
                                       'Erro gerado: ' + E.Message);
            end;
          end;
        end;
      End
      Else
        LBase64 := TIdEncoderMIME.EncodeStream(AArquivo);

      LQueryBolCtr.ParamByName('BOLETO').AsString := LBase64;

      LQueryBolCtr.ExecSQL;
    finally
      If Assigned(LQueryBolCtr) Then
        FreeAndNil(LQueryBolCtr);

      If FileExists(LArqCopy) Then
        DeleteFile(LArqCopy);
    end;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar o PDF do boleto.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
End;

procedure GravarPDFBoletosCarne(ABoletos: Array Of TDuplicataCtr;
                                APastaBoletos: String);
  Var
    LContadorDuplicatas: Integer;

    LUltimoArquivo: String;
Begin
  Try
    LUltimoArquivo := '';
    For LContadorDuplicatas := 0 To Length(ABoletos) - 1 Do
    Begin
      If LUltimoArquivo <> ABoletos[LContadorDuplicatas].strNumDup + '.pdf' Then
      Begin
        LUltimoArquivo := ABoletos[LContadorDuplicatas].strNumDup + '.pdf';


      End;

      GravarPDFBoleto(ABoletos[LContadorDuplicatas].strAutoIn,
                      APastaBoletos + ABoletos[LContadorDuplicatas].strNumDup + '.pdf');
    End;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar o PDF do boleto carnê.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
End;

procedure AtualizarAutoIncremBOLCTR(AAutoIncremParcial,
                                    AAutoIncremAberta: String);
Begin
  If Not fCfgSis('BOLCTR', varBoolean) Then
    Exit;

  Try
    fExecutaSQL('UPDATE BOLCTR SET BOL_SEQCTR=' + AAutoIncremAberta.QuotedString + ', ' +
                ' BOL_TIPBAI="P" WHERE BOL_SEQCTR=' + AAutoIncremParcial.QuotedString);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao atualizar o registro.' + #13 +
                             'Erro gerado: ' + E.Message + ' - [AtualizarAutoIncremBOLCTR]');
  End;
End;

procedure AtualizaBOLCTRBoletosBaixaTotal(AAutoIncremCtr: String);
Begin
  If Not fCfgSis('BOLCTR', varBoolean) Then
    Exit;

  Try
    fExecutaSQL('UPDATE BOLCTR SET BOL_TIPBAI="T" ' +
                ' WHERE BOL_SEQCTR=' + AAutoIncremCtr.QuotedString);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao atualizar o registro.' + #13 +
                             'Erro gerado: ' + E.Message + ' - [AtualizaBOLCTRBoletosBaixaTotal]');
  End;
End;

procedure AtualizaBOLCTRBoletosEstornoTotal(AAutoIncremCtr: String);
Begin
  If Not fCfgSis('BOLCTR', varBoolean) Then
    Exit;

  Try
    fExecutaSQL('UPDATE BOLCTR SET BOL_TIPBAI=NULL ' +
                ' WHERE BOL_SEQCTR=' + AAutoIncremCtr.QuotedString);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao atualizar o registro.' + #13 +
                             'Erro gerado: ' + E.Message + ' - [AtualizaBOLCTRBoletosEstornoTotal]');
  End;
End;

procedure AtualizaBOLCTRBoletosEstornoParcial(AAutoIncremCtr: String;
                                              AAtualizaBaixa: Boolean);
  Var
    LQueryBolCtr: TUniQuery;
Begin
  If Not fCfgSis('BOLCTR', varBoolean) Then
    Exit;

  Try
    LQueryBolCtr := fCriarQuery('SELECT AUTOINCREM FROM BOLCTR ' +
                                ' WHERE BOL_SEQCTR=' + AAutoIncremCtr.QuotedString);
    LQueryBolCtr.Open;

    If Not LQueryBolCtr.IsEmpty Then
    Begin
      If AAtualizaBaixa Then
        fExecutaSQL('UPDATE BOLCTR SET BOL_TIPBAI=NULL '  +
                    ' WHERE AUTOINCREM=' + LQueryBolCtr.FieldByName('AUTOINCREM').AsString.QuotedString);
    End;

    LQueryBolCtr.Close;
    FreeAndNil(LQueryBolCtr);
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao atualizar o PDF do boleto.' + #13 +
                             'Erro gerado: ' + E.Message + ' - [AtualizaBOLCTRBoletosEstornoTotal]');
  End;
End;

function fCadRecExiste(strNumDup, strParcel, strEspDoc, strCodEmp, strCodCli: string): boolean;
  var
    qryCadRec : TUniQuery;
Begin
  qryCadRec := fCriaQuery;
  Try
    qryCadRec.SQL.Add(' SELECT COUNT(*) AS CNT ');
    qryCadRec.SQL.Add('   FROM CADREC ');
    qryCadRec.SQL.Add('  WHERE CTR_NUMDUP = :NUMDUP ');
    qryCadRec.SQL.Add('    AND CTR_PARCEL = :PARCEL ');
    qryCadRec.SQL.Add('    AND CTR_ESPDOC = :ESPDOC ');
    qryCadRec.SQL.Add('    AND CTR_CODEMP = :CODEMP ');
    qryCadRec.SQL.Add('    AND CTR_CODCLI = :CODCLI ');
    qryCadRec.ParamByName('NUMDUP').AsString  := strNumDup;
    qryCadRec.ParamByName('PARCEL').AsString  := strParcel;
    qryCadRec.ParamByName('ESPDOC').AsString  := strEspDoc;
    qryCadRec.ParamByName('CODEMP').AsString  := strCodEmp;
    qryCadRec.ParamByName('CODCLI').AsString  := strCodCli;
    qryCadRec.Open;
    Result := (qryCadRec.FieldByName('CNT').AsInteger > 0);
    qryCadRec.Close;
  finally
    FreeAndNil(qryCadRec);
  End;
End;

function ExisteCartaoOuChequeVinculadoDoResumoDeCaixa(ANumDup, AParcel, AEspDoc, ACodEmp, ACodCli: string): Boolean;
  Var
    LConsulta: TUniQuery;
Begin
  Try
    LConsulta := fCriarQuery('SELECT MCA.MCA_NUMDUP, CHQ.CHQ_NUMCHQ            ' +
                             'FROM LOGCTR LOG                                  ' +
                             'LEFT JOIN CADRCXX RCX ON                         ' +
                             ' RCX.RCX_NUMDOC=LOG.CTR_NUMDUP AND               ' +
                             ' RCX.RCX_ESPDOC=LOG.CTR_ESPDOC AND               ' +
                             ' RCX.RCX_CODEMP=LOG.CTR_CODEMP AND               ' +
                             ' RCX.RCX_CODCLI=LOG.CTR_CODCLI                   ' +
                             'LEFT JOIN MOVCAR MCA ON                          ' +
                             ' MCA.MCA_SEQCON=RCX.RCX_SEQCON AND               ' +
                             ' MCA.MCA_EMPRCX=RCX.RCX_CODEMP AND               ' +
                             ' MCA.MCA_RESCAI=1                                ' +
                             'LEFT JOIN CADCHQ CHQ ON                          ' +
                             ' CHQ.CHQ_SEQCON=RCX.RCX_SEQCON AND               ' +
                             ' CHQ.CHQ_EMPRCX=RCX.RCX_CODEMP AND               ' +
                             ' CHQ.CHQ_RESCAI=1                                ' +
                             'WHERE                                            ' +
                             ' LOG.CTR_NUMDUP=' + ANumDup.QuotedString + ' AND ' +
                             ' LOG.CTR_PARCEL=' + AParcel.QuotedString + ' AND ' +
                             ' LOG.CTR_ESPDOC=' + AEspDoc.QuotedString + ' AND ' +
                             ' LOG.CTR_CODEMP=' + ACodEmp.QuotedString + ' AND ' +
                             ' LOG.CTR_CODCLI=' + ACodCli.QuotedString + ' AND ' +
                             ' LOG.CTR_SEQBAI=0 AND LOG.CTR_DESCRI IN("INCLUSÃO","INCLUSÃO LD")  ' +
                             ' AND RCX_NUMDOC IS NOT NULL                      ');
    LConsulta.Open;

    Result := Not LConsulta.FieldByName('MCA_NUMDUP').AsString.IsEmpty;
    If Not Result Then
      Result := Not LConsulta.FieldByName('CHQ_NUMCHQ').AsString.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
End;

function ValidaSeAlgumDosDocumentosSofreuAlteracao(ADataset: TUniClientDataSet): Boolean;
  Var
    LQuery: TUniQuery;
    LSQL  : String;
Begin
  Result := False;

  If ADataset.IsEmpty Then
    Exit;

  Try
    LSQL := '';
    LSQL := LSQL + 'SELECT                          ';
    LSQL := LSQL + '      CTR_DTALOG,               ';
    LSQL := LSQL + '      CTR_HORLOG                ';
    LSQL := LSQL + 'FROM LOGCTR                     ';
    LSQL := LSQL + 'WHERE                           ';

    ADataset.First;
    While Not ADataset.Eof Do
    Begin
      If ADataset.FieldByName('CTR_MARDES').AsString = 'M' Then
        LSQL :=  LSQL + '(CTR_NUMDUP = "' + ADataset.FieldByName('NRODUP').AsString + '" AND ' +
                        ' CTR_PARCEL = "' + ADataset.FieldByName('PARDUP').AsString + '" AND ' +
                        ' CTR_ESPDOC = "' + ADataset.FieldByName('CTR_ESPDOC').AsString + '" AND ' +
                        ' CTR_CODEMP = "' + ADataset.FieldByName('CTR_CODEMP').AsString + '" AND ' +
                        ' CTR_CODCLI = "' + ADataset.FieldByName('CTR_CODCLI').AsString + '" AND ' +
                        ' CTR_SEQBAI=0) OR ';

      ADataset.Next;
    End;
    ADataset.First;

    LSQL := LeftStr(LSQL, LSQL.Length - 3) + ' ';

    LSQL := LSQL + 'ORDER BY CTR_DTALOG DESC,        ';
    LSQL := LSQL + '         CTR_HORLOG DESC LIMIT 1 ';

    LQuery := fCriaQuery;
    LQuery.SQL.Text := LSQL;
    LQuery.Open;

    If Not LQuery.IsEmpty Then
      Result := StrtoDateTime(LQuery.FieldByName('CTR_DTALOG').AsString + ' ' +
                              LQuery.FieldByName('CTR_HORLOG').AsString) >
                              ADataset.FieldByName('HRAFIL').AsDateTime;

    FreeAndNil(LQuery);
  Except
    On E:Exception Do
      Raise Exception.Create('Ocorreu um erro ao buscar a última alteração das duplicatas de contas a receber.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
End;

procedure MarcarComoBoletoBancoInter(AAutoIncrem: String);
  Var
    LAtualiza: TUniQuery;
Begin
  Try
    fStartTransaction;

    LAtualiza := fCriaQuery(Nil);
    LAtualiza.SQL.Text := 'UPDATE CADREC SET CTR_BOLINT="S" WHERE AUTOINCREM IN (' + AAutoIncrem + ')';
    LAtualiza.ExecSQL;

    FreeAndNil(LAtualiza);

    fCommit;
  Except
    fRollBack;
  End;
End;

function fExecutadoViaRoboEnvioEmail: Boolean;
begin
  Result := (Pos('EnviaEmailBoletoMonitor', Application.ExeName) > 0);
end;

function VerificaExclusaoOuAlteracaoDeDuplicatasNoCaixa(ARegistros: TUniClientDataset): Boolean;
Begin
  Result := False;

  ARegistros.First;
  While Not ARegistros.Eof Do
  Begin
    If ARegistros.FieldByName('CTR_MARDES').AsString <> 'M' Then
    Begin
      ARegistros.Next;
      Continue;
    End;

    Result := fDuplicataCtrBaixada(ARegistros.FieldByName('CTR_NUMDUP').AsString,
                                   ARegistros.FieldByName('CTR_PARCEL').AsString,
                                   ARegistros.FieldByName('CTR_ESPDOC').AsString,
                                   ARegistros.FieldByName('CTR_CODCLI').AsString,
                                   ARegistros.FieldByName('CTR_CODEMP').AsString,
                                   ARegistros.FieldByName('CTR_SEQBAI').AsInteger);

    If Result Then
    Begin
      fMensagem('ATENÇÃO', 'A duplicata (' + ARegistros.FieldByName('CTR_NUMDUP').AsString +
                                             ARegistros.FieldByName('CTR_PARCEL').AsString + '-' +
                                             ARegistros.FieldByName('CTR_ESPDOC').AsString + '-' +
                                             ARegistros.FieldByName('CTR_CODEMP').AsString +
                            ') já está baixada!', ['&Ok']);

      Break;
    End;

    Result := Not fCadRecExiste(ARegistros.FieldByName('CTR_NUMDUP').AsString,
                                ARegistros.FieldByName('CTR_PARCEL').AsString,
                                ARegistros.FieldByName('CTR_ESPDOC').AsString,
                                ARegistros.FieldByName('CTR_CODEMP').AsString,
                                ARegistros.FieldByName('CTR_CODCLI').AsString);

    If Result Then
    Begin
      fMensagem('ATENÇÃO', 'A duplicata (' + ARegistros.FieldByName('CTR_NUMDUP').AsString +
                                             ARegistros.FieldByName('CTR_PARCEL').AsString + '-' +
                                             ARegistros.FieldByName('CTR_ESPDOC').AsString + '-' +
                                             ARegistros.FieldByName('CTR_CODEMP').AsString +
                            ') não existe mais, possivelmente foi confirmada, cancelada ou agrupada. Verifique!', ['&Ok']);

      Break;
    End;

    //Verificando qualquer outra alteração
    Result := fRetUltimaAlteracaoCadRec(ARegistros.FieldByName('CTR_NUMDUP').AsString,
                                        ARegistros.FieldByName('CTR_PARCEL').AsString,
                                        ARegistros.FieldByName('CTR_ESPDOC').AsString,
                                        ARegistros.FieldByName('CTR_CODCLI').AsString,
                                        ARegistros.FieldByName('CTR_CODEMP').AsString) > ARegistros.FieldByName('HRAFIL').AsDateTime;

    If Result Then
    Begin
      fMensagem('ATENÇÃO', 'A duplicata (' + ARegistros.FieldByName('CTR_NUMDUP').AsString +
                                             ARegistros.FieldByName('CTR_PARCEL').AsString + '-' +
                                             ARegistros.FieldByName('CTR_ESPDOC').AsString + '-' +
                                             ARegistros.FieldByName('CTR_CODEMP').AsString +
                            ') sofreu alterações por outro operador. ' + #13 +
                            'Selecione as duplicatas novamente para realizar a baixa.', ['&Ok']);

      Break;
    End;

    ARegistros.Next;
  End;

  ARegistros.First;
End;

procedure pTravaDestravaCredito(blnTrava: Boolean; strCodCli: string);
var
  qryTrava: TUniQuery;
  strChave: String;
begin
  qryTrava := fCriaQuery;

  try
    qryTrava.Close;
    qryTrava.SQL.Clear;
    qryTrava.SQL.Add('');
    qryTrava.SQL.Add(' SELECT CTR_NUMDUP, CTR_ESPDOC, CTR_CODEMP, CTR_CODCLI, CTR_PARCEL');
    qryTrava.SQL.Add(' FROM CADREC ');
    qryTrava.SQL.Add(' WHERE ');
    qryTrava.SQL.Add('   CTR_DTAREC IS NULL AND ');
    qryTrava.SQL.Add('   CTR_VALDUP < 0     AND ');
    qryTrava.SQL.Add('   CTR_CODCLI = :CODCLI ');

    qryTrava.ParamByName('CODCLI').AsString := strCodCli;

    qryTrava.Open;

    if qryTrava.IsEmpty then
      Exit;

    while not qryTrava.Eof do
    begin
      strChave := 'CADREC' +
                  qryTrava.FieldByName('CTR_NUMDUP').AsString +
                  qryTrava.FieldByName('CTR_ESPDOC').AsString +
                  qryTrava.FieldByName('CTR_CODEMP').AsString +
                  qryTrava.FieldByName('CTR_CODCLI').AsString +
                  qryTrava.FieldByName('CTR_PARCEL').AsString;

      fLock_Unlock(strChave, blnTrava, False);

      qryTrava.Next;
    end;

  finally
    FreeAndNil(qryTrava);
  end;
end;

function fVerificaUtilizacaoDeCredito(strCodCli: string): Boolean;
var
  qryCredito: TUniQuery;
  strChave: String;
begin
  qryCredito := fCriaQuery;
  Result := False;

  try
    qryCredito.Close;
    qryCredito.SQL.Clear;
    qryCredito.SQL.Add('');
    qryCredito.SQL.Add(' SELECT CTR_NUMDUP, CTR_ESPDOC, CTR_CODEMP, CTR_CODCLI, CTR_PARCEL');
    qryCredito.SQL.Add(' FROM CADREC ');
    qryCredito.SQL.Add(' WHERE ');
    qryCredito.SQL.Add('   CTR_DTAREC IS NULL AND ');
    qryCredito.SQL.Add('   CTR_VALDUP < 0     AND ');
    qryCredito.SQL.Add('   CTR_CODCLI = :CODCLI ');

    qryCredito.ParamByName('CODCLI').AsString := strCodCli;

    qryCredito.Open;

    if qryCredito.IsEmpty then
      Exit;

    while not qryCredito.Eof do
    begin
      strChave := '%CADREC' +
                  qryCredito.FieldByName('CTR_NUMDUP').AsString +
                  qryCredito.FieldByName('CTR_ESPDOC').AsString +
                  qryCredito.FieldByName('CTR_CODEMP').AsString +
                  qryCredito.FieldByName('CTR_CODCLI').AsString +
                  qryCredito.FieldByName('CTR_PARCEL').AsString;

      if not fEmptyStr(fGetIdConnectionLock(strChave)) then
      begin
        Result := True;
        Exit;
      end;

      qryCredito.Next;
    end;

  finally
    FreeAndNil(qryCredito);
  end;
end;

function fGravaValAdt(strAutIncFgo, strAutIncCadRec: string; fltValAdt: Double): Boolean;
var
  qryValAdt: TUniQuery;
begin
  qryValAdt := fCriaQuery;

  try
    Result := False;

    qryValAdt.Close;
    qryValAdt.SQL.Clear;
    qryValAdt.SQL.Add('INSERT INTO VALADT(AUTOINCREM, ADT_SEQFGO, ADT_SEQCTR, ADT_VALADT)');
    qryValAdt.SQL.Add('VALUES(:AUTINC, :SEQFGO, :SEQCTR, :VALADT)');

    qryValAdt.ParamByName('AUTINC').AsString := fRetAutoIncrem('VALADT', VS_strCodEmp);
    qryValAdt.ParamByName('SEQFGO').AsString := strAutIncFgo;
    qryValAdt.ParamByName('SEQCTR').AsString := strAutIncCadRec;
    qryValAdt.ParamByName('VALADT').AsFloat := fltValAdt;

    qryValAdt.ExecSQL;

    Result := True;
  finally
    FreeAndNil(qryValAdt);
  end;
end;

function fExcluiValAdtPeloSeqCtr(strAutIncCadRec: String): Boolean;
var
  qryValAdt: TUniQuery;
begin
  qryValAdt := fCriaQuery;

  Try
    Result := False;

    qryValAdt.SQL.Add('  DELETE FROM           ');
    qryValAdt.SQL.Add('    VALADT              ');
    qryValAdt.SQL.Add('  WHERE                 ');
    qryValAdt.SQL.Add('    ADT_SEQCTR=:SEQCTR  ');

    qryValAdt.ParamByName('SEQCTR').AsString := strAutIncCadRec;

    qryValAdt.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryValAdt);
  End;
end;

procedure AtualizarCADRECEmailPix(ADataset: TDataset;
                                  ATxIdPix: String;
                                  ANomeFormulario: String);
  Var
    LAtualizar: TUniQuery;
begin
  ADataset.First;

  Try
    LAtualizar := fCriaQuery;

    LAtualizar.SQL.Text := 'UPDATE CADREC SET ' +
                           '  CTR_EMPPIX=:EMPPIX, ' +
                           '  CTR_TX_PIX=:TX_PIX, ' +
                           '  CTR_PIXTIP=:PIXTIP, ' +
                           '  CTR_PIXREC=:PIXREC, ' +
                           '  CTR_PIXJUR=:PIXJUR, ' +
                           '  CTR_PIXDES=:PIXDES, ' +
                           '  CTR_PIXCOB=:PIXCOB, ' +
                           '  CTR_PIXCOR=:PIXCOR  ' +
                           'WHERE AUTOINCREM=:AUTOIN';

    While Not ADataset.Eof Do
    Begin
      LAtualizar.ParamByName('EMPPIX').AsString := VS_strCodEmp;
      LAtualizar.ParamByName('TX_PIX').AsString := ATxIdPix;
      LAtualizar.ParamByName('PIXTIP').AsString := 'T';
      If ADataset.FieldByName('CTR_TIPBAI').AsString = 'P' Then
        LAtualizar.ParamByName('PIXTIP').AsString := 'P';
      LAtualizar.ParamByName('PIXREC').AsFloat := ADataset.FieldByName('CTR_VALREC').AsFloat;
      LAtualizar.ParamByName('PIXJUR').AsFloat := ADataset.FieldByName('CTR_VALJUR').AsFloat;
      LAtualizar.ParamByName('PIXDES').AsFloat := ADataset.FieldByName('CTR_VALDES').AsFloat;
      LAtualizar.ParamByName('PIXCOB').AsFloat := ADataset.FieldByName('CTR_DESCOB').AsFloat;
      LAtualizar.ParamByName('PIXCOR').AsFloat := ADataset.FieldByName('CTR_VALCAL').AsFloat;

      LAtualizar.ParamByName('AUTOIN').AsString := ADataset.FieldByName('AUTOINCREM').AsString;

      LAtualizar.ExecSQL;

      untLogCtr.GravaLogCtr(ADataset.FieldByName('AUTOINCREM').AsString,
                            'ENVIO EMAIL PIX',
                            ANomeFormulario,
                            strLoginUsuarioLogado);

      ADataset.Next;
    End;
  Finally
    FreeAndNil(LAtualizar);
  End;
end;

function BoletoApiCancelado(AAutoIncremCadRec: String): Boolean;
var
  LConsulta: TUniQuery;
  LSQL: String;
begin
  Result := False;
  LConsulta := fCriaQuery;
  try
    LSQL := 'SELECT                                          '+
            ' 1                                              '+
            'FROM                                            '+
            ' CADREC C                                       '+
            ' LEFT JOIN REGBOL R                             '+
            '   ON C.AUTOINCREM = REG_DUPLIC                 '+
            'WHERE REG_DUPLIC = :AUTOINCREM                  '+
            ' AND REG_DESCRI IN ("CANCELAMENTO", "REGISTRO") '+
            ' AND IFNULL(CTR_CARTEI, "") = ""                '+
            ' AND REG_EXCEPT IS NULL                         '+
            'GROUP BY REG_DUPLIC;                            ';

    try
      LConsulta.Close;
      LConsulta.SQL.Clear;
      LConsulta.SQL.Add(LSQL);
      LConsulta.Params[0].AsString := AAutoIncremCadRec;
      LConsulta.Open;
      Result := (LConsulta.RecordCount > 0);
    except
      On E: Exception do
        raise Exception.Create('Problemas ao verificar se o boleto foi cancelado. ' + E.Message);
    end;
  finally
    FreeAndNil(LConsulta);
  end;
end;

{NO FATURAMENTO, SE FOR PARCELADO EM 10X POR EXEMPLO E, NA TERCEIRA PARCELA O SISTEMA NÃO CONSEGUIR CADASTRAR O BOLETO, O SISTEMA
 DEVERÁ EMITIR UM AVISO INFORMANDO QUAIS PARCELAS AINDA FALTAM E AS MARCARÁ PARA SER IMPRESSAS APENAS NO BANCO DO BRASIL ONLINE.
 CASO NENHUMA PARCELA FOR IMPRESSA, FICARÁ EM ABERTO PARA IMPRIMIR EM QUALQUER BANCO.}
function DuplicataCorrespondenteAOutroBanco(ABcoIni,AAutoIncrem: String; Var ANomBcoApi: String): Boolean;
  Var
    LRegBol : TUniQuery;
    LSql: String;
    LCarteira : String;
    LBcoIni : String;
Begin
  Result := False;
  LRegBol := fCriaQuery(Nil);

  Try
    LSql := 'SELECT                                                    '+
            '  *                                                       '+
            'FROM                                                      '+
            '  CADREC A                                                '+
            '  LEFT JOIN CADREC B                                      '+
            '    ON B.CTR_NUMDUP = A.CTR_NUMDUP                        '+
            '    AND B.CTR_ESPDOC = A.CTR_ESPDOC                       '+
            '    AND B.CTR_CODCLI = A.CTR_CODCLI                       '+
            '    AND B.CTR_CODEMP = A.CTR_CODEMP                       '+
            '    AND B.CTR_PARCEL = "A"                                '+
            '  JOIN REGBOL                                             '+
            '    ON REG_DUPLIC = B.AUTOINCREM                          '+
            'WHERE REGBOL.REG_LOCIMP = "FAT"                           '+
            '  AND REGBOL.REG_EXCEPT IS NULL                           '+
            '  AND A.AUTOINCREM = :DUPLIC                              '+
            '  AND IFNULL(REGBOL.REG_DESCRI, "REGISTRO") = "REGISTRO"  '+
            'ORDER BY REGBOL.REG_DTAREG DESC,                          '+
            '  REGBOL.REG_HRAREG DESC                                  '+
            'LIMIT 1                                                   ';

    Try
      LRegBol.Close;
      LRegBol.SQL.Clear;
      LRegBol.SQL.Add(LSql);
      LRegBol.ParamByName('DUPLIC').AsString := AAutoIncrem;
      LRegBol.Open;

      If Not LRegBol.IsEmpty Then
      Begin

        LCarteira := LRegBol.FieldByName('REG_CARTEI').AsString;
        LBcoIni   := (Copy(LCarteira,7,Pos('-',RightStr(LCarteira,Length(LCarteira) - 6)) -1));

        If (ABcoIni <> LBcoIni) then
        Begin
          Result := True;
          ANomBcoApi := Concat(LRegBol.FieldByName('REG_CODBCO').AsString,' - ', fRetNomBanco(LRegBol.FieldByName('REG_CODBCO').AsString), ' [Online].');
        End;

      End;

    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;
  Finally
    FreeAndNil(LRegBol);
  End;
End;

function RetornaSQLEmailCliente: String;
begin
  Result := 'CONCAT(' +
            '  (CASE ' +
            '     WHEN (TRIM(IFNULL(C.CLI_EMCOB1,"")) <> "") THEN ' +
            '       C.CLI_EMCOB1 ' +
            '     WHEN (TRIM(IFNULL(C.CLI_EMCOB2,"")) <> "") THEN ' +
            '       C.CLI_EMCOB2 ' +
            '     WHEN (TRIM(IFNULL(C.CLI_EMAIL_,"")) <> "") THEN ' +
            '       C.CLI_EMAIL_ ' +
            '     WHEN (TRIM(IFNULL(C.CLI_EMAIL2,"")) <> "") THEN ' +
            '       C.CLI_EMAIL2 ' +
            '     ELSE "" ' +
            '  END), ' +
            ' IF((TRIM(IFNULL(C.CLI_EMAIL3,"")) <> ""),' +
            '     CONCAT(";",C.CLI_EMAIL3),"")) ' +
            ' AS CTR_EMACLI ';
end;

function RetornaSQLCamposTabelasTemporaria(ADescFinanSomenteAteVenc: Boolean;
                                           ACodigoEvento,
                                           ARomaneio: String): String;
begin
  Result := '';
  Result := Result + 'SELECT SQL_NO_CACHE ';
  Result := Result + '  R.AUTOINCREM, ';
  Result := Result + '  CTR_NUMDUP AS NRODUP, ';
  Result := Result + '  CTR_PARCEL AS PARDUP, ';
  Result := Result + '  CONCAT(R.CTR_NUMDUP, R.CTR_PARCEL) AS CTR_NUMDUP, ';
  Result := Result + '  R.CTR_ESPDOC AS CTR_ESPDOC, ';
  Result := Result + '  R.CTR_DTAVEN AS CTR_DTAVEN, ';
  Result := Result + '  R.CTR_DTAENV AS CTR_DTAENV, ';
  Result := Result + '  R.CTR_LINDIG AS CTR_LINDIG, ';
  Result := Result + '  R.CTR_BCOBOL AS CTR_BCOBOL, ';
  Result := Result + '  R.CTR_BCOENV AS CTR_BCOENV, ';
  Result := Result + '  R.CTR_CARTEI AS CTR_CARTEI, ';
  Result := Result + '  B.BCO_NOMBCO AS CTR_NOMBCO, ';
  Result := Result + '  R.CTR_VALDUP AS CTR_VALDUP, ';
  Result := Result + '  R.CTR_DTABOL AS CTR_DTABOL, ';
  Result := Result + '  R.CTR_CODCED AS CTR_CODCED, ';
  Result := Result + '  FGO_BOLADT AS FGO_BOLADT,    ';
  Result := Result + '  R.CTR_VALORI AS CTR_VALORI, ';
  Result := Result + '  0,00        AS CTR_CREDITO, ';

  Result := Result + '  R.CTR_VALFCP AS CTR_VALFCP, ';
  Result := Result + '  R.CTR_VALIPI AS CTR_VALIPI, ';
  Result := Result + '  R.CTR_VALRET AS CTR_VALRET, ';
  Result := Result + '  R.CTR_VALCBS AS CTR_VALCBS, ';
  Result := Result + '  R.CTR_VALIBS AS CTR_VALIBS, ';
  Result := Result + '  R.CTR_VAL_IS AS CTR_VAL_IS, ';
  Result := Result + '  R.CTR_VALACE AS CTR_VALACE, ';
  Result := Result + '  R.CTR_VALFRE AS CTR_VALFRE, ';

  Result := Result + '  R.CTR_PORBAI AS CTR_PORBAI, ';
  Result := Result + '  R.CTR_OPEBAI AS CTR_OPEBAI, ';
  Result := Result + '  R.CTR_HISBAI AS CTR_HISBAI, ';
  Result := Result + '  R.CTR_CODCTA AS CTR_CODCTA, ';


  Result := Result + '  R.CTR_CODCLI AS CTR_CODCLI, ';
  Result := Result + '  IFNULL(C.CLI_CODRED, "00000") AS CLI_CODRED, ';
  Result := Result + '  (IF(C.CLI_NOMCLI LIKE "%CONSUMIDOR%" OR ';
  Result := Result + '      C.CLI_NOMCLI LIKE "%BALCAO%"     OR ';
  Result := Result + '      C.CLI_NOMCLI LIKE "%BALCÃO%",       ';
  Result := Result + '        IF(R.CTR_ESPDOC = "PD", ';
  Result := Result + '           CONCAT(FATGOR.FGO_CODCLI,"-",FATGOR.FGO_NOMCON), ';
  Result := Result + '           IF(IFNULL(MOVGER.GER_NOMCON, "") = "", ';
  Result := Result + '              CONCAT(NOTGER.GER_CODCLI,"-", NOTGER.GER_NOMCON), CONCAT(MOVGER.GER_CODCLI,"-", MOVGER.GER_NOMCON))), ';
  Result := Result + '      CONCAT(R.CTR_CODCLI,"-",C.CLI_NOMCLI))) AS CLI_NOMCLI, ';
  Result := Result + '  C.CLI_FONE01 AS CLI_FONE01, ';
  Result := Result + '  C.CLI_F_A_X_ AS CLI_F_A_X_, ';
  Result := Result + '  C.CLI_BAIRRO AS CLI_BAIRRO, ';
  Result := Result + '  C.CLI_ENDERE AS CLI_ENDERE, ';
  Result := Result + '  C.CLI_ENDNUM AS CLI_ENDNUM, ';
  Result := Result + '  C.CLI_ENDCOM AS CLI_ENDCOM, ';
  Result := Result + '  C.CLI_C_E_P_ AS CLI_C_E_P_, ';
  Result := Result + '  C.CLI_C_G_C_ AS CLI_C_G_C_, ';
  Result := Result + '  C.CLI_CGCCPF AS CLI_CGCCPF, '; // CPF OU CNPJ
  Result := Result + '  C.CLI_CODCID AS CLI_CODCID, ';
  Result := Result + '  D.CID_NOMCID AS CID_NOMCID, ';
  Result := Result + '  D.CID_ESTADO AS CID_ESTADO, ';
  {***********************************************************************************************************}
  {* SENDO CONSUMIDOR OU BALCAO, VERIFICAMOS SE É ESPDOC = 'PD', SE FOR, USA O NOME DA FATGOR. ***************}
  {* CASO NÃO FOR ESPDOC = 'PD', O NOME É OU DA MOVGER OU DA NOTGER. *****************************************}
  {* EM TODO CASO SE O NOME NA FATGOR, MOVGER OU NOTGER ESTIVER VAZIO, O SISTEMA IRÁ PEGAR O NOME DA CADCLI. *}
  {***********************************************************************************************************}
  Result := Result + '  (IF(C.CLI_NOMCLI LIKE "%CONSUMIDOR%" OR ';
  Result := Result + '      C.CLI_NOMCLI LIKE "%BALCAO%"     OR ';
  Result := Result + '      C.CLI_NOMCLI LIKE "%BALCÃO%",       ';
  Result := Result + '        IF(R.CTR_ESPDOC = "PD", IF(IFNULL(FATGOR.FGO_NOMCON, "") = "", C.CLI_NOMCLI, FATGOR.FGO_NOMCON), ';
  Result := Result + '                                IF(IFNULL(MOVGER.GER_NOMCON, "") = "", IF(IFNULL(NOTGER.GER_NOMCON, "") = "", C.CLI_NOMCLI, ';
  Result := Result + '                                NOTGER.GER_NOMCON), MOVGER.GER_NOMCON)), ';
  Result := Result + '      C.CLI_NOMCLI)) AS CTR_NOMCLI, ';
  Result := Result + '      C.CLI_FANSOB AS CTR_FANSOB, ';

  Result := Result + '  MOVGER.GER_NUMDOC AS GER_NUMDOC, ';
  Result := Result + '  R.CTR_CODEMP AS CTR_CODEMP, ';
  Result := Result + '  R.CTR_CODPOR AS CTR_CODPOR, ';
  Result := Result + '  P.POR_NOMPOR AS POR_NOMPOR, ';
  Result := Result + '  P.POR_BAICTF AS POR_BAICTF, ';
  Result := Result + '  R.CTR_NOSNUM AS CTR_NOSNUM, ';
  Result := Result + '  R.CTR_HIST01 AS CTR_HIST01, ';
  Result := Result + '  R.CTR_HIST02 AS CTR_HIST02, ';
  Result := Result + '  R.CTR_ADTCLI AS CTR_ADTCLI, ';
  Result := Result + '  R.CTR_CODEVE AS CTR_CODEVE, ';
  Result := Result + '  E.EVE_DESEVE AS EVE_DESEVE, ';
  Result := Result + '  R.CTR_CODVEL AS CTR_CODVEL, ';
  Result := Result + '  R.CTR_CODVEN AS CTR_CODVEN, ';
  Result := Result + '  R.CTR_CODDIG AS CTR_CODDIG, ';
  Result := Result + '  R.CTR_DTACAD AS CTR_DTACAD, ';
  Result := Result + '  R.CTR_DESCOB AS CTR_DESCOB, ';
  Result := Result + '  R.CTR_DESCOB AS CTR_DESCOB_ORI, ';
  Result := Result + '  R.CTR_COBANT AS CTR_COBANT, ';
  Result := Result + '  R.CTR_DESCON AS CTR_DESCON, ';
  Result := Result + '  R.CTR_OBSAG1 AS CTR_OBSAG1, ';
  Result := Result + '  R.CTR_OBSAG2 AS CTR_OBSAG2, ';
  Result := Result + '  R.CTR_OBSAG3 AS CTR_OBSAG3, ';
  Result := Result + '  CAST(" " AS CHAR(1)) AS CTR_BAIPAR, ';
  Result := Result + '  R.CTR_TX_BOL AS CTR_TX_BOL, ';
  Result := Result + '  CAST(" " AS CHAR(5)) AS  QTD_DIAS_RECEBIMENTO_APOS_VENCIMENTO_REGISTRADO, ';
  Result := Result + '  CURRENT_DATE AS VENCIMENTO_REGISTRADO, ';
  Result := Result + '  CAST(" " AS CHAR(500)) AS  ENDERECO_PAGADOR_REGISTRADO,           ';
  Result := Result + '  CAST(" " AS CHAR(500)) AS  ENDERECO_ATUAL_PAGADOR,                ';
  Result := Result + '  CONCAT(R.CTR_NUMDUP, R.CTR_PARCEL,"-",R.CTR_ESPDOC) AS DUPLICATA, ';
  Result := Result + RetornaSelectLinkDoBoleto + ',';
  Result := Result + '  R.CTR_LNKCIT AS CTR_LNKCIT, ';
  Result := Result + '  CTR_SEQBAI   AS CTR_SEQBAI, ';
  Result := Result + '  CTR_DOCDIV   AS CTR_DOCDIV, ';
  Result := Result + '  CTR_CLIDIV   AS CTR_CLIDIV, ';
  Result := Result + '  CTR_PARCEL   AS CTR_PARCEL, ';
  Result := Result + '  CURRENT_TIMESTAMP AS HRAFIL, ';

  If Not ADescFinanSomenteAteVenc Then
  Begin
    Result := Result + '  (R.CTR_VALDUP - IFNULL(R.CTR_DESSUJ, 0) + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0)) AS CTR_VALSUJ, ';
  End
  Else
  Begin
    Result := Result + '  (R.CTR_VALDUP - IFNULL(R.CTR_DESSUJ, 0) + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0)) AS CTR_VALSUJ_COM_DESC, ';
    Result := Result + '  (R.CTR_VALDUP - IF( R.CTR_DTAVEN >= ' + fCurrentDate + ', IFNULL(R.CTR_DESSUJ, 0), 0 ) + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0)) AS CTR_VALSUJ, ';
    Result := Result + '  (R.CTR_VALDUP - IF( R.CTR_DTAVEN >= ' + fCurrentDate + ', IFNULL(R.CTR_DESSUJ, 0), 0 ) + IFNULL(R.CTR_JURSUJ, 0) + IFNULL(R.CTR_DESCOB, 0)) AS CTR_VALSUJ_ORI, ';
  End;

  Result := Result + '  IFNULL(R.CTR_DESSUJ, 0) AS CTR_DESSUJ, ';
  Result := Result + '  IFNULL(R.CTR_JURSUJ, 0) AS CTR_JURSUJ, ';
  Result := Result + '  CONVERT(NULL, DATE)     AS CTR_DTAREC, ';
  Result := Result + '  IFNULL(R.CTR_PERDPO, 0) AS CTR_PERDPO, ';
  Result := Result + '  IFNULL(R.CTR_QTDDAV, 0) AS CTR_QTDDAV, ';
  Result := Result + '  0.00 AS CTR_VALDES, ';
  Result := Result + '  0.00 AS CTR_VALJUR, ';
  Result := Result + '  0.00 AS CTR_VALCOB, ';
  Result := Result + '  0.00 AS CTR_VALCAL, ';
  Result := Result + '  0.00 AS CTR_VALCAL_ORI, ';
  Result := Result + '  0.00 AS CTR_VALREC, ';
  Result := Result + '  0.00 AS CTR_VALRES, ';
  Result := Result + '  0.00 AS CALCULOBAIXAPARCIAL, ';
  Result := Result + '  CAST(" " AS CHAR(1))  AS CTR_TIPBAI, ';
  Result := Result + '  "D"  AS CTR_MARDES, ';
  Result := Result + '  IF(NOTGER.GER_NUMDOC IS NULL, MOVGER.GER_DTLBEX, ' + fCurrentDate + ') AS CTR_DTLBEX, ';
  Result := Result + '  IFNULL(NOTGER.GER_ENTFUT, IFNULL(MOVGER.GER_ENTFUT, "N")) AS CTR_ENTFUT, ';
  Result := Result + '  ' + AnsiReplaceStr(FloatToStrF(fCfgSis('JURATR', varDouble), ffFixed, 12, 4), ',', '.') + ' AS CTR_TAXJUR, ';
  Result := Result + '  ' + AnsiReplaceStr(FloatToStrF(fCfgSis('MULATR', varDouble), ffFixed, 12, 4), ',', '.') + ' AS CTR_PERMUL, ';
  Result := Result + '  MOVGER.GER_ENTFAT,  ';
  Result := Result + '  FIS_NUMCOO,         ';
  Result := Result + '  R.CTR_RECAUT,       ';
  Result := Result + '  C.CLI_STATUS,       ';
  Result := Result + '  IF(IFNULL(CTR_DOCDIV, "") <> "", CTR_VALDUP, 0) AS CTR_CREPRO, ';
  Result := Result + '  R.CTR_TX_PIX, ';
  Result := Result + '  R.CTR_EMPPIX, ';
  Result := Result + '  R.CTR_PIXCOR, ';
  Result := Result + '  R.CTR_PIXREC, ';
  Result := Result + '  R.CTR_PIXTIP, ';
  Result := Result + '  R.CTR_PIXJUR, ';
  Result := Result + '  R.CTR_PIXDES, ';
  Result := Result + '  R.CTR_PIXCOB, ';
  Result := Result + '  C.CLI_CELULA, ';
  Result := Result + RetornaSQLEmailCliente+', ';
  Result := Result + '  IF((R.CTR_DTAVEN >= IF(R.CTR_DTAREC IS NULL, '+ fCurrentDate +',R.CTR_DTAREC)) OR (R.CTR_VALORI < 0), ';
  Result := Result + '     0, ';
  Result := Result + '     IF(R.CTR_DTAREC <= FRETPROXDIAUTIL (R.CTR_DTAVEN),0,DATEDIFF(IF(R.CTR_DTAREC IS NULL,'+ fCurrentDate +',R.CTR_DTAREC),R.CTR_DTAVEN)) ';
  Result := Result + '  ) AS DIASATRASO, ';
  Result := Result + '  0.00 AS CTR_CALORI, ';
  Result := Result + '  0.00 AS VALORNOVADUPLICATA,       ';
  Result := Result + '  0.00 AS JUROSNOVADUPLICATA,       ';
  Result := Result + '  0.00 AS DESCONTONOVADUPLICATA,    ';
  Result := Result + '  0.00 AS DESPESASNOVADUPLICATA,    ';
  Result := Result + '  0.00 AS VALORBAIXADUPLICATA,      ';
  Result := Result + '  0.00 AS DESPESASBAIXADUPLICATA,   ';
  Result := Result + '  0.0000000 AS FATORBAIXADUPLICATA, ';
  Result := Result + '  0.0000000 AS FATORJUROSDUPLICATA  ';
  Result := Result + 'FROM ';
  Result := Result + '  CADREC R ';
  Result := Result + '  LEFT JOIN CADCLI C ON C.CLI_CODCLI = R.CTR_CODCLI ';
  Result := Result + '  LEFT JOIN CADPOR P ON P.POR_CODPOR = R.CTR_CODPOR ';
  Result := Result + '  LEFT JOIN CADCID D ON D.CID_CODCID = C.CLI_CODCID ';

  Result := Result + '  LEFT JOIN CADBCO B ON B.BCO_CODBCO = R.CTR_BCOBOL ';

  Result := Result + '  LEFT JOIN MOVGER ON MOVGER.GER_CODCLI = R.CTR_CODCLI ';
  Result := Result + '                  AND MOVGER.GER_NUMDOC = R.CTR_NUMDUP ';
  Result := Result + '                  AND MOVGER.GER_ESPDOC = R.CTR_ESPDOC ';
  Result := Result + '                  AND MOVGER.GER_CODEMP = R.CTR_CODEMP ';
  Result := Result + '                  AND MOVGER.GER_ORIDOC = "V" ';

  Result := Result + '  LEFT JOIN AUXMOV ON AUX_SEQGER = MOVGER.AUTOINCREM  ';

  Result := Result + '  LEFT JOIN NOTGER ON NOTGER.GER_CODCLI = R.CTR_CODCLI ';
  Result := Result + '                  AND NOTGER.GER_NUMDOC = R.CTR_NUMDUP ';
  Result := Result + '                  AND NOTGER.GER_ESPDOC = R.CTR_ESPDOC ';
  Result := Result + '                  AND NOTGER.GER_CODEMP = R.CTR_CODEMP ';

  Result := Result + '  LEFT JOIN FATGOR ON FATGOR.FGO_CODCLI = R.CTR_CODCLI ';
  Result := Result + '                  AND FATGOR.FGO_NUMDOC = R.CTR_NUMDUP ';
  Result := Result + '                  AND FATGOR.FGO_ESPDOC = R.CTR_ESPDOC ';
  Result := Result + '                  AND FATGOR.FGO_CODEMP = R.CTR_CODEMP ';

  Result := Result + '  LEFT JOIN EXTGOR ON FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';

  If fEmptyStr(ACodigoEvento) Then
    Result := Result + '   LEFT JOIN CADEVE E ON R.CTR_CODEVE = E.EVE_CODEVE '
  Else
    Result := Result + '  INNER JOIN CADEVE E ON R.CTR_CODEVE = E.EVE_CODEVE ';

  Result := Result + ' LEFT JOIN CADFIS ON FIS_NUMDOC = MOVGER.GER_NUMDOC AND ';
  Result := Result + '                     FIS_ESPDOC = MOVGER.GER_ESPDOC AND ';
  Result := Result + '                     FIS_CODEMP = MOVGER.GER_CODEMP AND ';
  Result := Result + '                     FIS_FORCLI = IF(FIS_TIP_FC = "C", MOVGER.GER_CODCLI, MOVGER.GER_CODFOR) AND ';
  Result := Result + '                     FIS_SERIE_ = MOVGER.GER_SERIE_     ';

  If Not fEmptyStr(ARomaneio) Then
  Begin
    Result := Result + '  LEFT JOIN ROMGERX ON ROMGERX.GER_NUMDOC = CTR_NUMDUP AND ';
    Result := Result + '                       ROMGERX.GER_ESPDOC = CTR_ESPDOC AND ';
    Result := Result + '                       ROMGERX.GER_CODEMP = CTR_CODEMP AND ';
    Result := Result + '                       ROMGERX.GER_CODCLI = CTR_CODCLI     ';
  End;
end;

function RetornaSQLDuplicatasDVCCVincularMovCar: String;
Begin
  Result := EmptyStr;
  Result := Result + 'SELECT R.AUTOINCREM, ';
  Result := Result + '       R.CTR_NUMDUP, ';
  Result := Result + '       R.CTR_PARCEL, ';
  Result := Result + '       R.CTR_ESPDOC, ';
  Result := Result + '       R.CTR_CODEMP, ';
  Result := Result + '       R.CTR_CODCLI, ';
  Result := Result + '       R.CTR_DTACAD, ';
  Result := Result + '       R.CTR_DTAVEN, ';
  Result := Result + '       R.CTR_VALDUP, ';
  Result := Result + '       CONCAT(C.CLI_CODCLI, "-", C.CLI_NOMCLI) AS CLIENTE ';
  Result := Result + 'FROM CADREC R ';
  Result := Result + 'JOIN CADCLI C ON C.CLI_CODCLI=R.CTR_CODCLI ';

  Result := Result + 'WHERE R.CTR_DTAREC IS NULL ';
  Result := Result + '  AND R.CTR_ESPDOC IN ("CC", "DV", "NF") ';
  Result := Result + '  AND R.CTR_VALORI < 0 ';
  Result := Result + '  AND R.CTR_CHAMCA IS NULL ';
End;


function RetornaSelectLinkDoBoleto: String;
  Var
    LConfBoleto: String;
begin
  LConfBoleto := fCfgSis('LNKBOL');

  If LConfBoleto.IsEmpty Then
    Exit(' CAST(" " AS CHAR(1000)) AS LINK_DO_BOLETO');

  Result := 'CONCAT("' + LConfBoleto + '", ' +
            'TO_BASE64(              ' +
            'CONCAT(                 ' +
            '       CTR_NUMDUP, "|", ' +
            '       CTR_ESPDOC, "|", ' +
            '       CTR_PARCEL, "|", ' +
            '       CTR_CODEMP, "|", ' +
            '       CTR_CODCLI, "|", ' +
            'UPPER(                  ' +
            '      MD5(              ' +
            '          CONCAT(       ' +
            '       CTR_NUMDUP, "|", ' +
            '       CTR_ESPDOC, "|", ' +
            '       CTR_PARCEL, "|", ' +
            '       CTR_CODEMP, "|", ' +
            '       CTR_CODCLI, "|", ' +
            ' "CITEL_BOLETO_@_13347" ' +
            ' ) ) ) )  ) )           ' +
            ' AS LINK_DO_BOLETO      ';
end;

function RetornaDuplicatasDosPixJaGerado(ATxIdPix,
                                         AEmpresaPix: String): TUniClientDataSet;
  Var
    LDataset: TUniQuery;

    LValorDuplicataAnterior,
    LValorCorrigido,
    LDespesas,
    LValorRecebido,
    LJuros,
    LDesconto,
    LJurosCalculado,
    LDescontoCalculado,
    LDespesasCalculado,
    LDiferenca: Double;
begin
  Try
    LDataset := fCriaQuery;
    LDataset.SQL.Text := RetornaSQLCamposTabelasTemporaria(fCfgSis('UTDEFN') = '2', '', '') +
                         ' WHERE CTR_EMPPIX="' + AEmpresaPix + '" ' +
                         '   AND CTR_TX_PIX="' + ATxIdPix + '" ' +
                         ' ORDER BY CTR_DTAVEN, CTR_CODCLI, CTR_NUMDUP, CTR_CODEMP ';
    LDataset.Open;

    Result := fCriaClientDatSet(LDataset);

    Result.First;
    While Not Result.Eof Do
    Begin
      Result.Edit;

      Result.FieldByName('CTR_BAIPAR').AsString := ' ';
      Result.FieldByName('CTR_TIPBAI').AsString := 'T';
      If Result.FieldByName('CTR_PIXTIP').AsString = 'P' Then
      Begin
        Result.FieldByName('CTR_BAIPAR').AsString := 'S';
        Result.FieldByName('CTR_TIPBAI').AsString := 'P';
      End;

      Result.FieldByName('CTR_VALCAL').AsFloat := Result.FieldByName('CTR_PIXCOR').AsFloat;
      Result.FieldByName('CTR_VALJUR').AsFloat := Result.FieldByName('CTR_PIXJUR').AsFloat;
      Result.FieldByName('CTR_VALDES').AsFloat := Result.FieldByName('CTR_PIXDES').AsFloat;
      Result.FieldByName('CTR_VALCOB').AsFloat := Result.FieldByName('CTR_PIXCOB').AsFloat;
      Result.FieldByName('CTR_VALCAL').AsFloat := Result.FieldByName('CTR_PIXCOR').AsFloat;
      Result.FieldByName('CTR_VALREC').AsFloat := Result.FieldByName('CTR_PIXREC').AsFloat;
      Result.FieldByName('CTR_DTAREC').AsDateTime := VS_Date;
      Result.FieldByName('CTR_CALORI').AsFloat := Result.FieldByName('CTR_VALCAL').AsFloat;

      If Result.FieldByName('CTR_PIXTIP').AsString.Equals('P') Then
      Begin
        LValorDuplicataAnterior := Result.FieldByName('CTR_VALDUP').AsFloat;
        LValorCorrigido         := Result.FieldByName('CTR_PIXCOR').AsFloat;
        LValorRecebido          := Result.FieldByName('CTR_PIXREC').AsFloat;
        LDesconto               := Result.FieldByName('CTR_PIXDES').AsFloat;
        LDespesas               := Result.FieldByName('CTR_PIXCOB').AsFloat;
        LJuros                  := Result.FieldByName('CTR_PIXJUR').AsFloat;

        LJurosCalculado         := fFormataFloat((LJuros/LValorRecebido)    * LValorCorrigido, 2);
        LDescontoCalculado      := fFormataFloat((LDesconto/LValorRecebido) * LValorCorrigido, 2);
        LDespesasCalculado      := fFormataFloat((LDespesas/LValorRecebido) * LValorCorrigido, 2);

        LDiferenca              := (LValorCorrigido - LValorDuplicataAnterior);
        LDiferenca              := fFormataFloat(LDiferenca - (LJurosCalculado + LDespesasCalculado - LDescontoCalculado),2);

        Result.FieldByName('FATORBAIXADUPLICATA').AsFloat := LValorDuplicataAnterior/LValorCorrigido;
        Result.FieldByName('FATORJUROSDUPLICATA').AsFloat := LJurosCalculado/LValorCorrigido;

        Result.FieldByName('VALORBAIXADUPLICATA').AsFloat := fFormataFloat(LValorRecebido - LJuros - LDespesas + LDesconto,2);
        Result.FieldByName('DESPESASBAIXADUPLICATA').AsFloat := LDespesas;

        Result.FieldByName('DESPESASNOVADUPLICATA').AsFloat := fFormataFloat(LDespesasCalculado - LDespesas,2);
        Result.FieldByName('DESCONTONOVADUPLICATA').AsFloat := fFormataFloat(LDescontoCalculado - LDesconto,2);
        Result.FieldByName('JUROSNOVADUPLICATA').AsFloat    := fFormataFloat(LJurosCalculado - LJuros,2);
        Result.FieldByName('VALORNOVADUPLICATA').AsFloat    := fFormataFloat((LValorDuplicataAnterior -
                                                                              Result.FieldByName('VALORBAIXADUPLICATA').AsFloat) +
                                                                              LDiferenca,2);
      End;

      Result.Post;

      Result.Next;
    End;

    Result.First;
  Finally
    FreeAndNil(LDataset);
  End;
end;

procedure GravaPDFPorEmpresa(AAutoIncremCadRec,
                             ACaminhoDoArquivo: String);   // PEGA DA PASTA BOLETOS;
  Var

    intCont: Integer;
    LArqCopy : String;
    LNomePasta : String;
    LCodEmpresa : String;
    strPathEmpresa : String;
    strNomeArquivo : String;
    blnCriado : Boolean;
Begin
  intCont := 0;
  blnCriado := False;

  Try

    If Not FileExists(ACaminhoDoArquivo) Then
       Exit;

    LCodEmpresa := fRetornaCodigoEmpresaDup(AAutoIncremCadRec);

    LNomePasta := 'Boletos_' + LCodEmpresa;

    strNomeArquivo := fRetornaNomeArquivoBol(AAutoIncremCadRec);

    If Not DirectoryExists(ExtractFilePath(Application.ExeName) + LNomePasta) Then
       CreateDir(ExtractFilePath(Application.ExeName) + LNomePasta);

    strPathEmpresa := ExtractFilePath(Application.ExeName) + LNomePasta;

    {USAMOS UMA COPIA DO BOLETO ORIGINAL PARA EVITAR ERROS DE DOCUMENTOS SENDO USADO POR OUTRO PROCESSO}
    LArqCopy := ExtractFilePath(Application.ExeName) + 'Boletos\' +  AAutoIncremCadRec + FormatDateTime('DDMMYYYYHHNNSS', Date + fTime()) + '.pdf' ;

    try

        while not (blnCriado) and (intCont <= 2) do
        begin
          try
            Inc(intCont);
            Sleep(200);

            If Not FileExists(LArqCopy) Then
            Begin
              TFile.Copy(ACaminhoDoArquivo, LArqCopy);
              sleep(100);

              If FileExists(strPathEmpresa +'\'+strNomeArquivo+'.pdf') Then
              Begin
                 TFile.Delete(strPathEmpresa +'\'+strNomeArquivo+'.pdf');

                 TFile.Copy(LArqCopy, strPathEmpresa +'\'+strNomeArquivo+'.pdf' );
                 blnCriado := True;
              End
              Else
              Begin
                 TFile.Copy(LArqCopy, strPathEmpresa +'\'+strNomeArquivo+'.pdf' );
                 blnCriado := True;
              End;

            End;

          except
            on E: Exception do
            begin
              if not ((Pos('o arquivo já está sendo usado por outro processo', LowerCase(E.Message)) > 0) and (intCont < 2)) then
                Raise Exception.Create('Ocorreu um erro ao gravar o PDF do boleto.' + #13 +
                                       'Erro gerado: ' + E.Message);
            end;
          end;
        end;

    finally

      If FileExists(LArqCopy) Then
        DeleteFile(LArqCopy);
    end;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao organizar o PDF do boleto por empresa.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
End;

procedure RateiaCreditoPorEspecie(fltCredito : Double; ARecEspeciesCC: array of TEspeciesGerCC);
  Var
      intCont : integer;
      fltDif : Double;
      fltSoma : Double;
      intposicaoValor : integer;
Begin

    fltSoma := 0;
    intposicaoValor := 0;

    If (Length(ARecEspeciesCC) > 0) Then
    Begin
       For intCont := 0 To Length(ARecEspeciesCC) -1 Do
       Begin
          If FRecEspeciesCC[intCont].fltValor > 0 Then
          Begin
             fltSoma := fltSoma + fFormataFloat( ((ARecEspeciesCC[intCont].fltVlrCredito * ARecEspeciesCC[intCont].fltPercPgto)/100), 2);
             intposicaoValor := intCont;
          End;
       End;
    End;

    fltDif := (fltCredito - fltSoma);

    ARecEspeciesCC[intPosicaoValor].fltCreditoCalc := (ARecEspeciesCC[intPosicaoValor].fltCreditoCalc + fltDif);

End;

Procedure VerificaValoresRateioCredito(intSeqCon : Integer; fltCredito: Double);
  Var
    LConsulta,
    LUpdate : TUniQuery;

    fltCreditoGrv : Double;
    StrUltimoAutoInc : String;
    fltDif : Double;
begin

  Try
    LConsulta := fCriaQuery();
    LUpdate   := fCriaQuery();

    LConsulta.SQL.Text := 'SELECT AUTOINCREM, IFNULL(CTR_VLCRED,0) AS VLCRED FROM CADREC WHERE CTR_SEQCON = :SEQCON AND CTR_EMPBAI = :EMPBAI ';  // IN (' + AAutoIncrem + ')';
    LConsulta.ParamByName('SEQCON').AsInteger := intSeqCon;
    LConsulta.ParamByName('EMPBAI').AsString  := VS_strCodEmp;
    LConsulta.Open;

    fltCreditoGrv    := 0;
    StrUltimoAutoInc := '';
    fltDif := 0;

    If Not LConsulta.IsEmpty Then
    Begin

      LConsulta.First;
      While Not LConsulta.Eof Do
      Begin
        fltCreditoGrv    := fltCreditoGrv + Abs(LConsulta.FieldByName('VLCRED').AsFloat);
        StrUltimoAutoInc := LConsulta.FieldByName('AUTOINCREM').AsString;
        LConsulta.Next;
      End;

      If ( fFormataFloat(fltCreditoGrv,2) <> fFormataFloat(fltCredito,2)) Then
      Begin
        If fltCredito > fltCreditoGrv Then
           fltDif := -(fltCredito - fltCreditoGrv)
        Else
        If fltCredito < fltCreditoGrv Then
           fltDif := fltCreditoGrv - fltCredito;

        If fltDif <> 0 Then
        Begin
          LUpdate.Close;
          LUpdate.SQL.Text := '';
          LUpdate.SQL.Text := 'UPDATE CADREC '
                            + 'SET '
                            + '  CTR_VLCRED = CTR_VLCRED + :VLCRED '
                            + 'WHERE '
                            + '  AUTOINCREM = :ULTAUTINC ';

          LUpdate.ParamByName('VLCRED').AsFloat      := fltDif;
          LUpdate.ParamByName('ULTAUTINC').AsString := StrUltimoAutoInc;
          LUpdate.ExecSQL;
        End;

      End;

    End;

    FreeAndNil(LUpdate);
    FreeAndNil(LConsulta);
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;
end;

procedure GravarPDFPorEmpresaBoletosCarne(ABoletos: Array Of TDuplicataCtr;
                                          APastaBoletos: String);
  Var
    LContadorDuplicatas: Integer;

    LUltimoArquivo: String;
Begin
  Try
    LUltimoArquivo := '';
    For LContadorDuplicatas := 0 To Length(ABoletos) - 1 Do
    Begin
      If LUltimoArquivo <> ABoletos[LContadorDuplicatas].strNumDup + '.pdf' Then
      Begin
        LUltimoArquivo := ABoletos[LContadorDuplicatas].strNumDup + '.pdf';


      End;

      GravaPDFPorEmpresa(ABoletos[LContadorDuplicatas].strAutoIn,
                         APastaBoletos + ABoletos[LContadorDuplicatas].strNumDup + '.pdf');

    End;
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao gravar o PDF do boleto carnê por empresa.' + #13 +
                             'Erro gerado: ' + E.Message);
  End;
End;

procedure RemovePDFRealocadosPorEmpresa( stlBolRealoc : TStringlist );
  Var
    intCont: Integer;
    LArqBol,
    strPathBase : String;
Begin

    LArqBol := '';

    If stlBolRealoc = Nil Then
       Exit;

    Try

      strPathBase := ExtractFilePath(Application.ExeName) + 'Boletos\';

      For intCont := 0 To stlBolRealoc.Count -1 Do
      Begin

        LArqBol := strPathBase + stlBolRealoc[intCont];

        If FileExists(LArqBol) Then
           DeleteFile(LArqBol);

      End;

    Except
      on E: Exception do
      begin
          Raise Exception.Create('Ocorreu um erro ao excluir arquivo do boleto realocado.' + #13 +
                                 'Erro gerado: ' + E.Message);
      end;
    End;

End;

procedure FreeAndNilQuery(Out AQuery: TUniQuery);
Begin
  Try
    If Assigned(AQuery) Then
      FreeAndNil(AQuery);
  Except
    //
  End;
End;

Procedure BaixaAutomaticaAgendamentosEmAberto(strNumDup, strEspDoc, strCodEmp, strCodCli, strParcel : String);
  Var
    LDataset: TUniQuery;
    LDataset1: TUniQuery;
    LExec: TUniQuery;
    strSQL,
    strAutoInc : String;
begin
  Try
    LDataset := fCriaQuery;
    LDataset.SQL.Clear;
    LDataset.SQL.Text := ' SELECT AUTOINCREM FROM CADREC  ' +
                         '  WHERE CTR_NUMDUP = :CTR_NUMDUP' +
                         '    AND CTR_ESPDOC = :CTR_ESPDOC' +
                         '    AND CTR_CODEMP = :CTR_CODEMP' +
                         '    AND CTR_CODCLI = :CTR_CODCLI' +
                         '    AND CTR_PARCEL = :CTR_PARCEL' ;
    LDataset.ParamByName('CTR_NUMDUP').AsString := strNumDup;
    LDataset.ParamByName('CTR_ESPDOC').AsString := strEspDoc;
    LDataset.ParamByName('CTR_CODEMP').AsString := strCodEmp;
    LDataset.ParamByName('CTR_CODCLI').AsString := strCodCli;
    LDataset.ParamByName('CTR_PARCEL').AsString := strParcel;
    LDataset.Open;

    If Not LDataset.IsEmpty Then
    Begin
       strAutoInc := LDataset.FieldByName('AUTOINCREM').AsString;

      LDataset1 := fCriaQuery;
      LDataset1.SQL.Clear;
      LDataset1.SQL.Text := ' SELECT DUP_SEQCOB FROM DUPCOB WHERE DUP_SEQDUP = :AUTOIN ';
      LDataset1.ParamByName('AUTOIN').AsString := strAutoInc;
      LDataset1.Open;

      If Not LDataset1.IsEmpty Then
      Begin

        strSQL := '';
        strSQL := strSQL + 'UPDATE ';
        strSQL := strSQL + '  CADCOB ';
        strSQL := strSQL + 'SET ';
        strSQL := strSQL + '  COB_BAIXAD = "S", ';
        strSQL := strSQL + '  COB_OPEBAI = :OPEBAI ';
        strSQL := strSQL + 'WHERE ';
        strSQL := strSQL + '  AUTOINCREM = :AUTINC ';

        LExec := fCriaQuery;

        LDataset1.First;
        While Not LDataset1.Eof Do
        Begin

          LExec.SQL.Clear;
          LExec.SQL.Text := strSQL;
          LExec.ParamByName('AUTINC').AsString := LDataset1.FieldByName('DUP_SEQCOB').AsString;
          LExec.ParamByName('OPEBAI').AsString := strLoginUsuarioLogado;
          LExec.ExecSql;

          LDataset1.Next;
        End;

      End;

    End;

  Finally
    FreeAndNilQuery(LDataset);
    FreeAndNilQuery(LDataset1);
    FreeAndNilQuery(LExec);
  End;
end;

{ Esta função verifica o valor anterior da baixa.
  Caso o valor anterior (CTR_VALANT) seja igual ao valor recebido,
  significa que o sistema erroneamente rateou o valor anterior original na baixa.
  Nessa situação, é necessário buscar o valor anterior original
  diretamente na tabela LOGCTR para manter a consistência dos dados. }

function RetornaValorAnterior(ASeqCon: Integer;
                              AEmpBai,
                              ANumDup,
                              AParcel,
                              AEspDoc,
                              ACodEmp,
                              ACodCli: String;
                              ASeqBai: Integer): Double;
var
  LConsulta : TUniQuery;
begin
  Result := 0;
  LConsulta := fCriaQuery(nil);
  try
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Text := ' SELECT CTR_VALANT             '+
                          ' FROM LOGCTR                   '+
                          ' WHERE CTR_SEQCON = :SEQCON    '+
                          '   AND CTR_EMPBAI = :EMPBAI    '+
                          '   AND CTR_NUMDUP = :NUMDUP    '+
                          '   AND CTR_PARCEL = :PARCEL    '+
                          '   AND CTR_ESPDOC = :ESPDOC    '+
                          '   AND CTR_CODEMP = :CODEMP    '+
                          '   AND CTR_CODCLI = :CODCLI    '+
                          '   AND CTR_SEQBAI = :SEQBAI    '+
                          '   AND LOCATE("BAIXA PARCIAL", TRIM(CTR_DESCRI)) > 0';
    Try
      LConsulta.ParamByName('SEQCON').AsInteger := ASeqCon;
      LConsulta.ParamByName('EMPBAI').AsString  := AEmpBai;
      LConsulta.ParamByName('NUMDUP').AsString  := ANumDup;
      LConsulta.ParamByName('PARCEL').AsString  := AParcel;
      LConsulta.ParamByName('ESPDOC').AsString  := AEspDoc;
      LConsulta.ParamByName('CODEMP').AsString  := ACodEmp;
      LConsulta.ParamByName('CODCLI').AsString  := ACodCli;
      LConsulta.ParamByName('SEQBAI').AsInteger := ASeqBai;

      LConsulta.Open;

      if not LConsulta.IsEmpty then
        Result := LConsulta.FieldByName('CTR_VALANT').AsFloat;

    except
      on E: Exception do
        raise Exception.Create('[RetornaValorAnterior] -> Erro ao buscar CTR_VALANT: ' + E.Message);
    end;

  Finally
    FreeAndNil(LConsulta);
  End;
end;


function RetornaValorAnteriorBaixaTotal(ASeqCon: Integer;
                                        AEmpBai,
                                        ANumDup,
                                        AParcel,
                                        AEspDoc,
                                        ACodEmp,
                                        ACodCli: String): Double;
var
  LConsulta : TUniQuery;
begin
  Result := 0;
  LConsulta := fCriaQuery(nil);
  try
    LConsulta.Close;
    LConsulta.SQL.Clear;
    LConsulta.SQL.Text := ' SELECT CTR_VALORI             '+
                          ' FROM LOGCTR                   '+
                          ' WHERE CTR_SEQCON = :SEQCON    '+
                          '   AND CTR_EMPBAI = :EMPBAI    '+
                          '   AND CTR_NUMDUP = :NUMDUP    '+
                          '   AND CTR_PARCEL = :PARCEL    '+
                          '   AND CTR_ESPDOC = :ESPDOC    '+
                          '   AND CTR_CODEMP = :CODEMP    '+
                          '   AND CTR_CODCLI = :CODCLI    '+
                          '   AND LOCATE("BAIXA TOTAL", TRIM(CTR_DESCRI)) > 0';
    Try
      LConsulta.ParamByName('SEQCON').AsInteger := ASeqCon;
      LConsulta.ParamByName('EMPBAI').AsString  := AEmpBai;
      LConsulta.ParamByName('NUMDUP').AsString  := ANumDup;
      LConsulta.ParamByName('PARCEL').AsString  := AParcel;
      LConsulta.ParamByName('ESPDOC').AsString  := AEspDoc;
      LConsulta.ParamByName('CODEMP').AsString  := ACodEmp;
      LConsulta.ParamByName('CODCLI').AsString  := ACodCli;

      LConsulta.Open;

      if not LConsulta.IsEmpty then
        Result := LConsulta.FieldByName('CTR_VALORI').AsFloat;

    except
      on E: Exception do
        raise Exception.Create('[RetornaValorAnterior] -> Erro ao buscar CTR_VALANT: ' + E.Message);
    end;

  Finally
    FreeAndNil(LConsulta);
  End;
end;


function RetornaDadosDaBaixa(ANumDup,AParcel,AEspDoc,ACodEmp,
                               ACodCli,AAdtCli,AEmpBai : String;
                               ASeqCon : Integer): TDadosDaBaixaContasReceber;
  Var
    qryAux : TUniQuery;
    LSql: String ;
begin
  Result := TDadosDaBaixaContasReceber.Create;
  Result.FEmpBai := AEmpBai;
  Result.FSeqCon := ASeqCon;

  If Not AAdtCli.Equals('S') Then
    Exit;

  Try
    qryAux  := fCriaQuery(Nil);

    LSql := 'SELECT                                                    '+
            '  A.ADT_SEQCON,                                           '+
            '  A.ADT_EMPLAN                                            '+
            'FROM                                                      '+
            '  (SELECT                                                 '+
            '    TABAUX3.*                                             '+
            '  FROM                                                    '+
            '    (SELECT                                               '+
            '      A.ADT_SEQCON,                                       '+
            '      A.ADT_TIPLAN,                                       '+
            '      A.ADT_ESPDOC,                                       '+
            '      A.ADT_NUMDOC,                                       '+
            '      A.ADT_CODCLI,                                       '+
            '      A.ADT_EMPLAN,                                       '+
            '      A.ADT_CODEMP                                        '+
            '    FROM                                                  '+
            '      (SELECT                                             '+
            '        A.ADT_SEQCON AS SEQCON,                           '+
            '        A.ADT_TIPLAN,                                     '+
            '        A.ADT_ESPDOC,                                     '+
            '        A.ADT_NUMDOC,                                     '+
            '        A.ADT_CODCLI,                                     '+
            '        A.ADT_EMPLAN,                                     '+
            '        A.ADT_CODEMP,                                     '+
            '        CTR_NUMDUP,                                       '+
            '        CTR_CODCLI,                                       '+
            '        CTR_CODEMP,                                       '+
            '        CTR_ESPDOC,                                       '+
            '        CTR_PARCEL                                        '+
            '      FROM                                                '+
            '        (SELECT                                           '+
            '          ADT_TIPLAN,                                     '+
            '          ADT_ESPDOC,                                     '+
            '          ADT_NUMDOC,                                     '+
            '          ADT_CODCLI,                                     '+
            '          ADT_CODEMP,                                     '+
            '          CTR_NUMDUP,                                     '+
            '          CTR_CODCLI,                                     '+
            '          CTR_CODEMP,                                     '+
            '          CTR_ESPDOC,                                     '+
            '          CTR_PARCEL                                      '+
            '        FROM                                              '+
            '          ADTCLI                                          '+
            '          INNER JOIN CADREC                               '+
            '            ON CTR_SEQCON = ADT_SEQCON                    '+
            '        WHERE ADT_CODCLI = :CODCLI                        '+
            '          AND ADT_SEQCON = :SEQCON) AS TABAUX             '+
            '        INNER JOIN ADTCLI AS A                            '+
            '          ON TABAUX.ADT_NUMDOC = A.ADT_NUMDOC             '+
            '          AND TABAUX.ADT_CODCLI = A.ADT_CODCLI            '+
            '          AND TABAUX.ADT_CODEMP = A.ADT_CODEMP            '+
            '          AND TABAUX.ADT_ESPDOC = A.ADT_ESPDOC            '+
            '      WHERE CTR_NUMDUP = :NUMDUP                          '+
            '        AND CTR_CODCLI = :CODCLI                          '+
            '        AND CTR_CODEMP = :CODEMP                          '+
            '        AND CTR_ESPDOC = :ESPDOC                          '+
            '        AND CTR_PARCEL = :PARCEL) AS TABAUX2              '+
            '      JOIN ADTCLI AS A                                    '+
            '        ON A.ADT_SEQCON = TABAUX2.SEQCON                  '+
            '        AND A.ADT_EMPLAN = TABAUX2.ADT_EMPLAN) AS TABAUX3 '+
            '    INNER JOIN ADTCLI AS A                                '+
            '      ON TABAUX3.ADT_NUMDOC = A.ADT_NUMDOC                '+
            '      AND TABAUX3.ADT_CODCLI = A.ADT_CODCLI               '+
            '      AND TABAUX3.ADT_CODEMP = A.ADT_CODEMP               '+
            '      AND TABAUX3.ADT_ESPDOC = A.ADT_ESPDOC) AS TABAUX4   '+
            '  INNER JOIN ADTCLI AS A                                  '+
            '    ON TABAUX4.ADT_NUMDOC = A.ADT_NUMDOC                  '+
            '    AND TABAUX4.ADT_CODCLI = A.ADT_CODCLI                 '+
            '    AND TABAUX4.ADT_CODEMP = A.ADT_CODEMP                 '+
            '    AND TABAUX4.ADT_ESPDOC = A.ADT_ESPDOC                 '+
            'WHERE A.ADT_TIPLAN = "C"                                  '+
            '  AND A.ADT_ESTORN = "N"                                  '+
            'ORDER BY ADT_DTALAN,                                      '+
            '  ADT_HORLAN                                              '+
            'LIMIT 1                                                   ';

    qryAux.Close;
    qryAux.SQL.Add(LSql);

    qryAux.ParamByName('NUMDUP').AsString  := ANumDup;
    qryAux.ParamByName('PARCEL').AsString  := AParcel;
    qryAux.ParamByName('ESPDOC').AsString  := AEspDoc;
    qryAux.ParamByName('CODEMP').AsString  := ACodEmp;
    qryAux.ParamByName('CODCLI').AsString  := ACodCli;
    qryAux.ParamByName('SEQCON').AsInteger := ASeqCon;

    qryAux.Open;

    If Not qryAux.isEmpty Then
    Begin
      Result.FEmpBai := qryAux.FieldByName('ADT_EMPLAN').AsString;
      Result.FSeqCon := qryAux.FieldByName('ADT_SEQCON').AsInteger;
    End;


  Finally
    FreeAndNil(qryAux);
  End;
end;

function ExisteAlgumaCobrancaComQRCodePix: Boolean;
  Var
    LConsulta: TUniQuery;
Begin
  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT AUTOINCREM FROM CADREC ' +
                          'WHERE CTR_TX_BOL IS NOT NULL ' +
                          'ORDER BY CTR_DTACAD DESC LIMIT 1 ';

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    FreeAndNil(LConsulta);
  End;
End;

procedure pAtualizaDespesaCobranca(strAutoInc :String; fltNovoDespCob: Double);
  Var
    LConsulta: TUniQuery;
Begin
  Try

    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'UPDATE CADREC SET CTR_DESCOB = :DESCOB ' +
                          ' WHERE AUTOINCREM = :AUTOIN ';

    LConsulta.ParamByName('DESCOB').AsFloat  := fltNovoDespCob;
    LConsulta.ParamByName('AUTOIN').AsString := strAutoInc;
    LConsulta.ExecSql;

  Finally
    FreeAndNil(LConsulta);
  End;
end;

procedure GravarTabelaImpressaoBoletoAutomatico(ASeqCtr: String);
  Var
    LBolAut: TUniQuery;
Begin

  If Not fCfgSis('BOLAUT', varBoolean) Then
    Exit;

  Try
    LBolAut := fCriaQuery(Nil);

    Try
      LBolAut.Close;
      LBolAut.SQL.Clear;
      LBolAut.SQL.Text := 'REPLACE INTO BOLAUT ( '+
                          '  BOL_SEQCTR,         '+
                          '  BOL_DTAOCO,         '+
                          '  BOL_CODOPE,         '+
                          '  BOL_CODEMP          '+
                          ')                     '+
                          'VALUES                '+
                          '  (                   '+
                          '    :BOL_SEQCTR,      '+
                          '    :BOL_DTAOCO,      '+
                          '    :BOL_CODOPE,      '+
                          '    :BOL_CODEMP       '+
                          ' )                    ';

      LBolAut.ParamByName('BOL_SEQCTR').AsString   := ASeqCtr;
      LBolAut.ParamByName('BOL_DTAOCO').AsDateTime := VS_Date;
      LBolAut.ParamByName('BOL_CODOPE').AsString   := strLoginUsuarioLogado;
      LBolAut.ParamByName('BOL_CODEMP').AsString   := VS_strCodEmp;

      LBolAut.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Raise Exception.Create(E.Message);
      End;
    End;

  Finally
    FreeAndNil(LBolAut);
  End;
End;

function fDeletaCadRec(strAutInc, strNomFrm: String; ADescricao: String = ''): Boolean;
  Var
    qryDados: TUniQuery;
    blnCommit: Boolean;
begin
  Result := False;
  qryDados := fCriaQuery;
  blnCommit := (Not fInTransaction);

  Try
    Try
      If ADescricao.IsEmpty Then
        ADescricao := 'EXCLUSÃO DE DUPLICATA';

      pGravaDelCadRec(strAutInc, strNomFrm);
      GravaLogCtr(strAutInc, ADescricao, strNomFrm);

      If (blnCommit) Then
        fStartTransaction;

      qryDados.Close;
      qryDados.SQL.Clear;
      qryDados.SQL.Text := ' DELETE FROM CADREC WHERE AUTOINCREM = :AUTINC ';
      qryDados.ParamByName('AUTINC').AsString := strAutInc;
      qryDados.ExecSQL;

      If (blnCommit) Then
        fCommit;

      Result := True;
    Except
      On E: Exception Do
      Begin
        If (blnCommit) Then
          fRollBack;
        Raise Exception.Create('[fDeletaCadRec] - ' + E.Message);
      End;
    End;
  Finally
    FreeAndNil(qryDados);
  End;
end;

procedure pGravaDelCadRec(strAutInc, strNomFrm: String);
  Var
    qryDados: TUniQuery;
begin
  qryDados := fCriarQuery('SELECT * FROM CADREC WHERE AUTOINCREM = ' + strAutInc.QuotedString);

  Try
    qryDados.Open;

    qryDados.Edit;
    qryDados.FieldByName('CTR_NOMFRM').Value := Null;
    qryDados.Post;

    GravaTabelaDelecao(strNomFrm, 'CADREC', qryDados);
  Finally
    FreeAndNil(qryDados);
  End;
end;

function UtilizaContabilidadeERecebidoPorAdiantamento(out APedidoAdiantantamento: String;
  ANumeroDuplicata, AEspecieDuplicata, AEmpresaDuplicata, AClienteDuplicata: String;
  AParcelaDuplicata: String = ''; ASequencialBaixa: Integer = -1): Boolean;
  Var
    LConsulta: TUniQuery;
Begin
  Result := False;

  APedidoAdiantantamento := EmptyStr;

  If Not fCfgSis('UTICON', varBoolean) Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT CONCAT(A.ADT_NUMDOC, "-", A.ADT_ESPDOC, "-", A.ADT_CODEMP) AS PEDIDO ' +
                          'FROM CADREC C ' +
                          'JOIN ADTCLI A ON A.ADT_SEQCON=C.CTR_SEQCON ' +
                          '             AND A.ADT_EMPLAN=C.CTR_EMPBAI ' +
                          '             AND A.ADT_DTALAN=C.CTR_DTAREC ' +
                          '             AND A.ADT_CODCLI=C.CTR_CODCLI ' +
                          'WHERE C.CTR_NUMDUP=:NUMDUP ';

    If Not AParcelaDuplicata.IsEmpty Then
    Begin
      LConsulta.SQL.Add('  AND C.CTR_PARCEL=:PARCEL ');

      LConsulta.ParamByName('PARCEL').AsString := AParcelaDuplicata;
    End;

    LConsulta.SQL.Add('  AND C.CTR_ESPDOC=:ESPDOC ' +
                      '  AND C.CTR_CODEMP=:CODEMP ' +
                      '  AND C.CTR_CODCLI=:CODCLI ');

    If ASequencialBaixa >= 0 Then
    Begin
      LConsulta.SQL.Add('  AND C.CTR_SEQBAI=:SEQBAI ');

      LConsulta.ParamByName('SEQBAI').AsInteger := ASequencialBaixa;
    End;

    LConsulta.SQL.Add('  AND C.CTR_DTAREC IS NOT NULL ');

    LConsulta.ParamByName('NUMDUP').AsString := ANumeroDuplicata;
    LConsulta.ParamByName('ESPDOC').AsString := AEspecieDuplicata;
    LConsulta.ParamByName('CODEMP').AsString := AEmpresaDuplicata;
    LConsulta.ParamByName('CODCLI').AsString := AClienteDuplicata;

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
    If Result Then
      APedidoAdiantantamento := LConsulta.FieldByName('PEDIDO').AsString;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
End;

function DuplicataCreditoReferenteATroco(ANumeroDuplicata,
                                         AParcela,
                                         AEspecieDocumento,
                                         ACodigoEmpresa,
                                         ACodigoCliente: String;
                                         ASeqConBaixa: Integer): Boolean;
  Var
    LConsulta: TUniQuery;
Begin
  Result := False;

  If ANumeroDuplicata.IsEmpty Then
    Exit;

  If ASeqConBaixa = 0 Then
    Exit;

  If Not AEspecieDocumento.Equals('CC') Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT AUTOINCREM ' +
                          'FROM LOGCTR ' +
                          'WHERE CTR_NUMDUP=:NUMDUP ' +
                          '  AND CTR_PARCEL=:PARCEL ' +
                          '  AND CTR_ESPDOC=:ESPDOC ' +
                          '  AND CTR_CODEMP=:CODEMP ' +
                          '  AND CTR_CODCLI=:CODCLI ' +
                          '  AND CTR_SEQBAI=0 ' +
                          '  AND CTR_DTAREC IS NOT NULL ' +
                          '  AND CTR_SEQCON=:SEQCON ' +
                          '  AND CTR_VALREC < 0 ' +
                          '  AND CTR_DESCRI IN ("INCLUSÃO", "INCLUSÃO LD") ';

    LConsulta.ParamByName('NUMDUP').AsString := ANumeroDuplicata;
    LConsulta.ParamByName('PARCEL').AsString := AParcela;
    LConsulta.ParamByName('ESPDOC').AsString := AEspecieDocumento;
    LConsulta.ParamByName('CODEMP').AsString := ACodigoEmpresa;
    LConsulta.ParamByName('CODCLI').AsString := ACodigoCliente;
    LConsulta.ParamByName('SEQCON').AsInteger := ASeqConBaixa;

    LConsulta.Open;

    Result := Not LConsulta.IsEmpty;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
End;

procedure pAtualizarSequencialMovBanInclusaoCredito(const strAutIncCadRec : String; const strSeqLanMovBan : String);
  Var
    qryCadRec : TUniQuery;
begin
  If fEmptyStr(strSeqLanMovBan) Then
    Exit;
  If fEmptyStr(strAutIncCadRec) Then
    Exit;
  qryCadRec := fCriaQuery;
  Try
    qryCadRec.SQL.Text := 'UPDATE CADREC SET CTR_SBANCC = :SBANCC WHERE AUTOINCREM = :AUTINC';
    qryCadRec.ParamByName('SBANCC').AsString := strSeqLanMovBan;
    qryCadRec.ParamByName('AUTINC').AsString := strAutIncCadRec;
    qryCadRec.ExecSQL;
  Finally
    FreeAndNil(qryCadRec);
  End;
end;

end.
