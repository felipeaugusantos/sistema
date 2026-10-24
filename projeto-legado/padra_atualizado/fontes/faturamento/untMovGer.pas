unit untMovGer;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  Forms, UniClientDataSet, Dialogs, untFuncoesSimples,
{$ENDIF}
  untTBatchSQL, untTBatchSQL.Helper,   {Req. 456948}
  SysUtils, Classes, DB, Uni, untTypesSistema, Variants, untZClient,
  TypInfo, untFuncFatTypes, StrUtils, untTFatReprocessarSaldoItem, Fulfillment.RegrasMovimentacaoEstoque;

  procedure pIncluiAuxMov(strNomTab,
                          strAutInc,
                          strAutEnt,
                          strDocCon: String;
                          fltValCre: Double;
                          dtaNasCon: TDate;
                          strCodObr,
                          strCodArt,
                          strPermut,
                          strRetIss: String;
                          strOpcDoc: String;
                          fltFreSug: Double;
                          strNumAde: String;
                          fltBasAnt: Double;   //BASE DE ICMS ANTECIPADO
                          fltValAnt: Double;   //VALOR DE ICMS ANTECIPADO
                          strNaoAtu: String;
                          strEntUrg: String;
                          fltDupRec: Double;
                          fltValAdt: Double;
                          strNumGui: string;
                          objServicos: TClassDadosServicos;
                          fltDeDVCf: Double = 0;
                          strPlaVei: String = '';
                          strKm_Vei: String = '';
                          strCliOri: String = '';
                          strCodMot: String = '';
                          strBetone: String = '';
                          strLacre_: String = '';
                          strTipMps: String = '';
                          strAbatim: String = '';
                          strBrita_: String = '';
                          strConBom: String = '';
                          intFckDia: Integer = 0;
                          fltImpPag: Double = 0;
                          intPrzMed: integer = 0;
                          strChvNfeDev: String = '';
                          strOpeSol: String = '';
                          blnEst_Dv: Boolean = False;
                          strNumCOODev: String = '';
                          strNumSerDev: String = '';
                          strNumUSUDev: String = '';
                          strTipDocDev: String = '';
                          fltTotDif: Double = 0;
                          strFasObr: String = '';
                          objFazenda: Pointer = nil;
                          fltFedImp   : Double = 0;
                          fltEstImp   : Double = 0;
                          fltMunImp   : Double = 0;
                          fltTroco_: Double = 0;
                          strVenPre: String = 'N';
                          strSeqDocOri: String = '';
                          blnConEqu: Boolean = False;
                          blnDescIncond: Boolean = False;
                          blnGraCTP: Boolean = True;
                          strNumera: String = '';
                          strEdiPes: String = 'N';
                          fltTaxEnt: Double = 0;
                          fltVrdIcm: Double = 0;
                          fltBasVrd: Double = 0;
                          strCodEmbarcacao: String = '';
                          fltTotBri: Double = 0;
                          blnDevEsp: Boolean=False;
                          strTraRdp: String = '';
                          strCliCtt: String = '';
                          strCodMod: String = '';
                          strCodAti: String = '';
                          strHisCom: String = '';
                          strCodPrj: String = '';
                          strNatCfo: String = '';
                          strTpOper: String = '';
                          strCupDes: String = '';
                          strNotPau: String = 'S';
                          fltCotMoe: Double = 0;
                          fltFreMkp: Double = 0;
                          fltComMkp: Double = 0;
                          strPlaFat: String = '';
                          blnDevWms: Boolean = False;
                          fltFreCot: Double = 0;
                          fltFreRat: Double = 0;
                          strEntSim: String = 'N';
                          strSeqDmp: String = '';
                          strEntFutOpc: String = '';
                          fltTotIpiEntFut: Double = 0;
                          fltTotRetEntFut: Double = 0;
                          fltTotFcpSTEntFut: Double = 0;
                          fltICMDes: Double = 0;
                          fltDesPis: Double = 0;
                          strOpFaEx: String = '';
                          strDocAba: String = '';
                          strEspAba: String = '';
                          strEmpAba: String = '';
                          strCliAba: String = '';
                          strTem_ST: String = 'N';
                          blnColeta: Boolean = False;
                          strNumeroRandomico : String = '';
                          strNumeroDrawback : String = '';
                          strCodFinalidadeAjuste : String = '';
                          strDoc_RE: String = '';
                          strEsp_RE: String = '';
                          strEmp_RE: String = '';
                          strCli_RE: String = '';
                          strDocRE2: String = '';
                          strEspRE2: String = '';
                          strEmpRE2: String = '';
                          strCliRE2: String = '';
                          strEmp_TE: String = '';
                          strAutIcv: String = '';
                          strEspDoc: String = '';
                          strEmp_PR: String = '';
                          strCliCEO: String = '';
                          fltVolSepExc: Double = 0;
                          fltVolSepNExc: Double = 0;
                          strSupGer : String = '';
                          strSupReg : String = '';
                          strCelCon: String = '';
                          strAbaDep: String = 'N';
                          strEmpDep: String = '';
                          strAbf_Uf: String = '';
                          strEstornoNotaFiscal: String = '';
                          strCodTpA: String = '';
                          strMatRev: String = '';
                          strTipAbf: string = '';
                          strVchCdp: String = '';
                          strCodCno : String = '';
                          fltTotIbs:            Double = 0;
                          fltTotCbs:            Double = 0;
                          fltTotIs:             Double = 0;
                          fltTotProIs:          Double = 0;
                          fltTotNf:             Double = 0;
                          strInsImo : String = '';
                          strCodCib : String = ''
                          );

  {*****************************************}
  {* =============> ANTEÇÃO <============= *}
  {* AO CRIAR UM PARAMETRO NESSA FUNÇÃO,   *}
  {* RECOMPILAR O AUTCOMTINTA              *}
  {**************************************MV*}
  function fGravaMovGer(Var strAutInc: String;
                        strNumDoc,
                        strEspDoc,
                        strCodEmp,
                        strCodTra,
                        strCodVen,
                        strCodFor,
                        strCodCli,
                        strTip_Fc: String;
                        dtaDtaEnt,
                        tmrHorEnt,
                        dtaDtaDoc: TDateTime;
                        strConPag,
                        strEstado,
                        strNomCon,
                        strEndCon,
                        strBaiCon,
                        strCepCon,
                        strCidCon,
                        strEstCon,
                        strTelCon: String;
                        dtaNasCon: TDate;
                        strCgcCpf,
                        strCgcCon,
                        strIesCon,
                        strCli_Rg: String;
                        fltBasSim,
                        fltBasIpi,
                        fltAlqIpi,
                        fltTotIpi,
                        fltBasIcm,
                        fltAlqIcm,
                        fltTotIcm,
                        fltTotRet,
                        fltAlqRet,
                        fltBasRet,
                        fltRet_SP,
                        fltDesEsp,
                        fltVlrCon,
                        fltTotPro,
                        fltTotCus,
                        fltTotMed: Double;
                        strTipFre: String;
                        fltTotFre,
                        fltPesBru,
                        fltPesLiq,
                        fltVolume: Double;
                        strEspeci,
                        strMarca,
                        strMen001,
                        strMen002,
                        strMen003,
                        strMen004,
                        strMen005: String;
                        blnJafatu: Boolean;
                        strTipFat,
                        strNumFat,
                        strEmpFat: String;
                        dtaDtaFat: TDateTime;
                        strVenFat,
                        strCndFat: String;
                        blnDevEsp: Boolean;
                        fltValFat,
                        fltVPar01,
                        fltVPar02,
                        fltVPar03,
                        fltVPar04,
                        fltVPar05,
                        fltVPar06,
                        fltVPar07,
                        fltVPar08,
                        fltVPar09,
                        fltVPar10,
                        fltVPar11,
                        fltVPar12: Double;
                        arrDuplic: TarrDuplicata;
                        strSerie,
                        strNotEsp,
                        strClaFis,
                        strClaFi2,
                        strClaFi3,
                        strNatOpe: String;
                        fltPorDes: Double;
                        strCodDig,
                        strCodCnd,
                        strCodFpg: String;
                        fltFatNot: Double;
                        recServicos: TDadosServicos;
                        fltDesAce: Double;
                        strOriDoc,
                        strConEnt,
                        strCodRep: String;
                        fltAlqIrf,
                        fltValIrf,
                        fltAlqPis,
                        fltValPis,
                        fltAlqCof,
                        fltValCof,
                        fltAlqCsl,
                        fltValCsL,
                        fltIrfRet,
                        fltPisRet,
                        fltCofRet,
                        fltCslRet: Double;
                        strNotRet: String;
                        fltAlIrfP,
                        fltAlPisP,
                        fltAlCofP,
                        fltAlCslP,
                        fltSerRet: Double;
                        strNoReSe: String;
                        fltPeSgSo,
                        fltVlSgSo,
                        fltIrPrRt,
                        fltIrPrDv,
                        fltIrSeRt,
                        fltIrSeDv,
                        fltPiPrRt,
                        fltPiPrDv,
                        fltPiSeRt,
                        fltPiSeDv,
                        fltCoPrRt,
                        fltCoPrDv,
                        fltCoSeRt,
                        fltCoSeDv,
                        fltCsPrRt,
                        fltCsPrDv,
                        fltCsSeRt,
                        fltCsSeDv: Double;
                        strOrdPro: String;
                        fltBasOrg,
                        fltIcmOrg: Double;
                        intNConhe: Integer;
                        strConsum,                     // Consumidor final
                        strEntFat,
                        strCliFat,
                        strOpeExp,
                        strSepExp,
                        strTabPre,
                        strNum_Pr,
                        strEntFut: String;
                        blnBaiFut: Boolean;
                        fltMargem: Double;
                        fltBaRtSp,
                        fltVlRtSp: Double;
                        strOprFlj,
                        strNumReg: String;
                        dtaDtEntr: TDateTime;
                        strClaFi4,
                        strAutSer,
                        strCodEve,
                        strAutEnt,
                        strObsNfe,
                        strCodOco: String;
                        strFasObr: String;
                        blnIpDpNf: Boolean;
                        fltValCre: Double    = 0;
                        dtadtlBex: TDateTime = 0;
                        strEmlCon: String    = '';
                        dtaDtESNf: TDateTime = 0;
                        tmrHrESNf: TDateTime = 0;
                        objFinanc: Pointer = Nil;
                        strDocCon: String = '';           // Conhecimento de Frete
                        strCodObr: String = '';
                        strCodArt: String = '';
                        strPermut: String = 'N';          // Permuta para isenção de pagamento de comissão
                        strRetIss: String = '';
                        strOpcDoc: String = '';
                        fltFreSug: Double = 0;
                        strNumAde: String = '';
                        fltBasAnt: Double = 0;            //BASE DE ICMS ANTECIPADO
                        fltValAnt: Double = 0;            //VALOR DE ICMS ANTECIPADO
                        strNaoAtu: String = '';
                        strEntUrg: String = '';
                        strMenExp: String = '';
                        strMenEx2: String = '';
                        strMenEx3: String = '';
                        strMenEx4: String = '';
                        fltDupRec: Double = 0;
                        fltValAdt: Double = 0;
                        fltDeDVCf: Double = 0;
                        strPlaVei: String = '';
                        strKm_Vei: String = '';
                        strCliOri: String = '';
                        strCodMot: String = '';
                        strBetone: String = '';
                        strLacre_: String = '';
                        strTipMps: String = '';
                        strAbatim: String = '';
                        strBrita_: String = '';
                        strConBom: String = '';
                        intFckDia: Integer = 0;
                        fltImpPag: Double = 0;
                        intPrzMed: integer = 0;
                        blnImpPdv: Boolean = False;
                        blnDTEXREP: Boolean = False;
                        strChvNfeDev: String = '';
                        strOpeSol: String = '';
                        blnEst_Dv: Boolean = False;
                        strNumCOODev: String = '';
                        strNumSerDev: String = '';
                        strNumUSUDev: String = '';
                        strTipDocDev: String = '';
                        fltTotDif: Double = 0;
                        objFazenda: Pointer = nil;
                        fltFedImp : Double = 0;
                        fltEstImp : Double = 0;
                        fltMunImp : Double = 0;
                        fltTroco_: Double = 0;
                        strObsNfeFis: String = '';
                        strVenPre: String = 'N';
                        strSeqDocOri: String = '';
                        blnConEqu: Boolean = False;
                        blnDescIncond: Boolean = False;
                        blnGraCTP: Boolean = True;
                        strNumera: String = '';
                        strEdiPes: String = 'N';
                        fltTaxEnt: Double = 0;
                        fltVrdIcm: Double = 0;
                        fltBasVrd: Double = 0;
                        intNroBox: Integer = 0;
                        strCodEmbarcacao: String = '';
                        fltTotBri: Double = 0;
                        strTraRdp: String = '';
                        strCliCtt: String = '';
                        strCodMod: String = '';
                        strNumGui: String = '';
                        strHisCom: String = '';
                        strCodPrj: String = '';
                        strNatCfo: String = '';
                        strTpOper: String = '';
                        strCupDes: String = '';
                        strNotPau: String = 'S';
                        fltCotMoe: Double = 0;
                        fltFreMkp: Double = 0;
                        fltComMkp: Double = 0;
                        strPlaFat: String = '';
                        blnDevWms: Boolean = False;
                        blnFulfillmentModoRobo : Boolean = False;
                        fltFreCot: Double = 0;
                        fltFreRat: Double = 0;
                        strEntSim: String = 'N';
                        strSeqDmp: String = '';
                        strEntFutOpc: String = '';
                        fltTotIpiEntFut: Double = 0;
                        fltTotRetEntFut: Double = 0;
                        fltTotFcpSTEntFut: Double = 0;
                        fltICMDes: Double = 0;
                        fltDesPis: Double = 0;
                        strOpFaEx: String = '';
                        strDocAba: String = '';
                        strEspAba: String = '';
                        strEmpAba: String = '';
                        strCliAba: String = '';
                        blnColeta: Boolean = False;
                        strNumeroRandomico : String = '';
                        strNumeroDrawback : String = '';
                        strCodFinalidadeAjuste : String = '';
                        strDoc_RE: String = '';
                        strEsp_RE: String = '';
                        strEmp_RE: String = '';
                        strCli_RE: String = '';
                        strDocRE2: String = '';
                        strEspRE2: String = '';
                        strEmpRE2: String = '';
                        strCliRE2: String = '';
                        strEmp_TE: String = '';
                        strAutIcv: String = '';
                        strEmp_PR: String = '';
                        strCliCEO: String = '';
                        fltVolSepExc: Double = 0;
                        fltVolSepNExc: Double = 0;
                        strSupGer: String = '';
                        strSupReg: String = '';
                        strCelCon: String = '';
                        strAbaDep: String = 'N';
                        strEmpDep: String = '';
                        strAbf_Uf: String = '';
                        strEstornoNotaFiscal: String = '';
                        strCodTpA: String = '';
                        strMatRev: String = '';
                        strVchCdp: String = '';
                        strCodCno : String = '';
                        fltTotIbs:            Double = 0;
                        fltTotCbs:            Double = 0;
                        fltTotIs:             Double = 0;
                        fltTotProIs:          Double = 0;
                        fltTotNf:             Double = 0;
                        strInsImo : String = '';
                        strCodCib : String = ''
                        ): Boolean;

  {*********************************************************}
  {*****==================> ATENÇÃO <==================*****}
  {*AO CRIAR PARAMETRO NESTA FUNÇÃO BUSCAR POR TfGravaMovGer*}
  {* E ADICIONAR OS PARAMETROS CRIADOS EM 'TfGravaMovGer', *}
  {* POIS A ROTINA DE FORMULAÇÃO DE TINTAS PARA DE FUNCIONAR*}
  {******************************************************RG**}

  {*****************************************}
  {* =============> ANTEÇÃO <============= *}
  {* AO CRIAR UM PARAMETRO NESSA FUNÇÃO,   *}
  {* RECOMPILAR O AUTCOMTINTA              *}
  {**************************************MV*}
  function fGravaMovDet(Var strAutInc: String;
                        strSeqGer: String;
                        strNumDoc,
                        strEspDoc,
                        strCodEmp,
                        strCodIte,
                        strCodVen,
                        strCodDiv,
                        strCodMar,
                        strCodFor,
                        strCodCli: String;
                        dtaDtaEnt,
                        dtaHorEnt,
                        dtaDtaDoc: TDateTime;
                        strConPag,
                        strTip_Fc,
                        strEstado,
                        strDescri,
                        strRefere,
                        strUnidad,
                        strForIte: String;
                        fltQtdIte,
                        fltUnitar,
                        fltUniOri,
                        fltUniVis,
                        fltTotIte,
                        fltVlrCon,
                        fltTotCus,
                        fltTotMed,
                        fltDesCon,
                        fltTotFre,
                        fltDesEsp: Double;
                        strCodRep,
                        strCodVe2: String;
                        fltPerCom,
                        fltTotCom,
                        fltTotCo2: Double;
                        strClaFis,
                        strCodFis: String;
                        fltValIpi,
                        fltAlqIpi,
                        fltBasIpi,
                        fltValIcm,
                        fltAlqIcm,
                        fltBasIcm,
                        fltValRet,
                        fltAlqRet,
                        fltBasRet,
                        fltTotPes,
                        fltPerBas,
                        fltPerRed: Double;
                        blnJafatu: Boolean;
                        strTipFat,
                        strNumFat,
                        strEmpFat: String;
                        dtaDtaFat: TDateTime;
                        strVenFat,
                        strCndFat: String;
                        fltValFat: Double;
                        strIdePro,
                        strIncPis,
                        strSerie: String;
                        fltDesAce: Double;
                        strNotEsp,
                        strDocDev,
                        strEspDev,
                        strEmpDev,
                        strIteCha,
                        strIteTin,
                        strDesCor,
                        strTipEmb: String;
                        fltQtdEmb,
                        fltPreEmb: Double;
                        strTipPre: String;
                        fltPrvTin,
                        fltPrcTin,
                        fltFatTin: Double;
                        strProEmb,
                        strCodDig,
                        strCodCnd,
                        strCodFpg,
                        strIteEmb,
                        strGruEmb: String;
                        intLazQua: Integer;
                        strPromoc,
                        strSeqTin: String;
                        fltQtdPul: Double;
                        strPedCom,
                        strOriDoc,
                        strNum_Pd,
                        strEsp_Pd,
                        strEmp_Pd: String;
                        intInd_Pd: Integer;
                        strOrdPro,
                        strDesNes,
                        strCliFat: String;
                        fltBcaMin,
                        fltBcaCom,
                        fltVolPro: Double;
                        strCodAca,
                        strEmpAca: String;
                        blnProAca,
                        blnFilKar: Boolean;
                        strEspFut,
                        strDocFut,
                        strEmpFut,
                        strTabPre,
                        strEmpCom: String;
                        strLinha: String;
                        strCatali: String;
                        strCodDil: String;
                        fltPorDil: Double;
                        strDilCon: String;
                        fltPorCat: Double;
                        fltUniDig: Double;
                        fltQtdPon: Double;
                        strEntFut,
                        strMotFut: String;
                        dtaDtaFut: TDateTime;
                        fltTotCu2: Double;
                        fltComRep,
                        fltPerRep: Double;
                        strKey_EP,
                        strNumLot,
                        strPigBas: String;
                        fltVaEIpi,
                        fltAlEIpi,
                        fltBaEIpi,
                        fltTotUlt,
                        fltImpUlt,
                        fltBaRtSP,
                        fltVaRtSP,
                        fltIcOpPr: Double;
                        intSeqCcr: Integer;
                        fltEmbala,
                        fltAlqPis,
                        fltBasPis,
                        fltValPis: Double;
                        strCSTPis: String;
                        fltAlqCof,
                        fltBasCof,
                        fltValCof: Double;
                        strCSTCof,
                        strCSTIpi,
                        strEnqIpi: String;
                        fltVaERet,
                        fltAlERet,
                        fltBaERet: Double;
                        fltPesLiq: Double;
                        fltUniTab: Double = 0;
                        strLot_TA: String = '';
                        fltConFre: Double = 0;
                        fltBasAnt: Double = 0;
                        fltIcmAnt: Double = 0;
                        fltVendor: Double = 0;
                        fltOutDes: Double = 0;
                        fltVlGnre: Double = 0;
                        strGnrOri: string = 'P';
                        fltOutIcm: Double = 0;
                        fltIseIcm: Double = 0;
                        fltFreSug: Double = 0;
                        strCodMot: String = '';
                        strNatPis: String = '';
                        strNatCof: string = '';
                        strSeqGad: string = '';
                        fltOutVal: Double = 0;
                        fltIcmSai: Double = 0;
                        fltImpFed: Double = 0;
                        fltDesOpe: Double = 0;
                        fltQtdExp: Double = 0;
                        strNumCmp: String = '';
                        intNItCmp: Integer = 0;
                        fltDeDVCf: Double = 0;
                        strCodMec: String = '';
                        strAntPro: String = 'N';
                        strAntFre: String = 'N';
                        fltMedAnt: Double = 0;
                        fltPreAnt: Double = 0;
                        fltImpAnt: Double = 0;
                        strSeqAnt: string = '';
                        strRICMPR: String = 'N';
                        fltComLiq: Double = 0;
                        strNcmTin: String = '';
                        fltValIva: Double = 0;
                        strCliBus: String = 'N';
                        strTurEnt: String = '';
                        strIdeDev: String = 'NOR';
                        fltPeBaST: Double = 0;
                        fltVal_RT: Double = 0;
                        fltDesCli: Double = 0;
                        fltImpPag: Double = 0;
                        fltTaxJur: Double = 0;
                        fltSerRat: Double = 0;
                        strProBri: String = '';
                        fltPonBri: Double = 0;
                        fltValDif: Double = 0;
                        fltVaFrAn: Double = 0;
                        strLotAba: String = '';
                        fltFedImp: Double = 0;
                        fltEstImp: Double = 0;
                        fltMunImp: Double = 0;
                        strIncDev: String = '';
                        strBrinde: String = 'N';
                        strCodPar: String = '';
                        strTipBri: String = '';
                        fltIcmOrg: Double = 0;
                        strBaqtze: String = '';
                        strIncFut: String = '';
                        fltValFle: Double = 0;
                        fltTaxEnt: Double = 0;
                        fltVrdIcm: Double = 0;
                        fltBasVrd: Double = 0;
                        strMtdIcm: String = '';
                        strBxSbIt: String = 'N';
                        strIteAbf: String = '';
                        strAtivac: String = 'N';
                        intSeqCom: Integer = 0;
                        fltVICMDe: Double = 0;
                        strNcmIte: String = '';
                        fltComDig: Double = 0;
                        fltPerDig: Double = 0;
                        fltIcmPav: Double = 0;
                        blnIcmSai: Boolean = False;
                        fltAlDifa: Double = 0;
                        strAutSai: String = '';
                        fltBFCPST: Double = 0;
                        fltPFCPST: Double = 0;
                        fltVFCPST: Double = 0;
                        strDadSep: String = '';
                        strAutEle: String = '';
                        strNotUlt: String = '';
                        fltPICMEF: Double = 0;
                        fltBICMEF: Double = 0;
                        fltAICMEF: Double = 0;
                        fltVICMEF: Double = 0;
                        fltBSTANT: Double = 0;
                        fltVSTANT: Double = 0;
                        strNotC17: String = '';
                        fltAlq922: Double = 0;
                        fltDesCnd: Double = 0;
                        strProEsp: String = '';
                        strCodPro: String = '';
                        strInc_Pd: String = '';
                        fltSICMEF: Double = 0;
                        fltValTCI: Double = 0;
                        fltCalTCI: Double = 0;
                        fltVal_TS: Double = 0;
                        strExtFul: String = '';
                        strCodExt: String = '';
                        fltFreMkp: Double = 0;
                        fltComMkp: Double = 0;
                        strAIdKitPromocao : String = '';
                        strChaveAcesso: String = '';
                        fltQtdCom: Double = 0;
                        fltFreCot: Double = 0;
                        AstrComplemento : String = '';
                        strEmpCar: String = '';
                        strAutoinDevCar: String = '';
                        AfltBaseOperacaoPropriaICMSEntrada : Double = 0;
                        AfltAliquotaOperacaoPropriaICMSEntrada : Double = 0;
                        AfltValorOperacaoPropriaIMCSEntrada : Double = 0;
                        fltFreRat: Double = 0;
                        fltValIpiEntFut: Double = 0;
                        fltValRetEntFut: Double = 0;
                        fltValFcpSTEntFut: Double = 0;
                        fltDesPis: Double = 0;
                        blnClaRet: Boolean = False;
                        strOpSeEx: String = '';
                        strConExp: String = '';
                        strEmbExp: String = '';
                        strObsExp: String = '';
                        blnAtoDeclaratorioDF: Boolean = False;
                        strMovTriLocFis: String = '';
                        fltVDesST: Double = 0;
                        strMDesST: String = '';
                        strNumDrw: String = '';
                        strTipBus: String = '';
                        strNumPla: String = '';
                        strParNum: String = '';
                        strReqCom: String = '';
                        strNatOpe: String = '';
                        fltRpaFre: Double = 0;
                        fltPerRic: Double = 0;
                        blnAltEst: Boolean = False;
                        intSeqPer: Integer = 0;
                        intDetItem: Integer = 0;
                        fltICMCFR: Double = 0;
                        fltFreteCalc: Double = 0;
                        fltFreConCalc: Double = 0;
                        strPegou_ : String = 'N';
                        fltVFCPOP: Double = 0;
                        fltVFCPDF: Double = 0;
                        fltCubage: Double = 0;
                        fltCfbIpi: Double = 0;
                        fltCfaIpi: Double = 0;
                        fltCfvIpi: Double = 0;
                        strCipiOK: String = 'N';
                        strDocIpi: String = '';
                        strEspIpi: String = '';
                        strEmpIpi: String = '';
                        intRemFil: Integer = 0;
                        fltQtdRemFil: Double = 0;
                        blnFulfillmentModoRobo: Boolean = False;
                        blnFilFul: Boolean = True;
                        blnBaiDev: Boolean = False;
                        strAutEnt: String = '';
                        dtaDtaCmp: TDateTime = 0;
                        strFullHubMkp: String = '';
                        fltOutValPD: Double = 0;
                        strFilFul_EntSai: String = '';
                        strIncOri: String = '';
                        strTckQbt: String = '';
                        strEntTri: String = 'N';
                        strFulDif: String = '';
                        strClaFat: String = '';
                        fltICMNCR: Double = 0;
                        fltFCPNCR: Double = 0;
                        strColoranteDeEntregaFutura : String = 'N';
                        strCbenef: string = '';
                        strCodPre: string = '';
                        fltBasPre: Double = 0;
                        fltPerPre: Double = 0;
                        fltValPre: Double = 0;
                        strCodCmg: string = '';
                        fltVimRet: Double = 0;
                        dobQIcmsMonRet: Double = 0;
                        dobAdBcMonRet: Double = 0;
                        dobVrEmIcmsRet: Double = 0;
                        fltValSeg: Double = 0;
                        fltPerDif: Double = 0;
                        fltAlqSTXML: Double = 0;
                        fltCliDes: Double = 0;
                        strRefCodCst: String = '';
                        strRefClaTri: String = '';
                        fltRefValOpe: Double = 0;
                        fltRefBasCal: Double = 0;
                        fltRefCbsAlq: Double = 0;
                        fltRefCbsAlD: Double = 0;
                        fltRefCbsVlD: Double = 0;
                        fltRefCbsAlR: Double = 0;
                        fltRefCbsVlT: Double = 0;
                        fltRefCbsAlE: Double = 0;
                        fltRefCbsVal: Double = 0;
                        fltRefIbsUfA: Double = 0;
                        fltRefIbsUfD: Double = 0;
                        fltRefIbsUvD: Double = 0;
                        fltRefIbsUfR: Double = 0;
                        fltRefIbsUfT: Double = 0;
                        fltRefIbsUfE: Double = 0;
                        fltRefIbsUfV: Double = 0;
                        fltRefIbsMnA: Double = 0;
                        fltRefIbsMnD: Double = 0;
                        fltRefIbsMvD: Double = 0;
                        fltRefIbsMnR: Double = 0;
                        fltRefIbsMnT: Double = 0;
                        fltRefIbsMnE: Double = 0;
                        fltRefIbsMnV: Double = 0;
                        strRefSelCst: String = '';
                        strRefSelCla: String = '';
                        fltRefSelBas: Double = 0;
                        fltRefSelAlq: Double = 0;
                        fltRefSelVal: Double = 0;
                        strRefTriReg: String = 'N';
                        strRefCrePre: String = 'N';
                        strRefMonoFa: String = 'N';
                        fltRefValIbs: Double = 0;
                        strRefCesBas: String = '';
                        strRefCstReg: String = '';
                        strRefClaReg: String = '';
                        fltRefAiuReg: Double = 0;
                        fltRefTiuReg: Double = 0;
                        fltRefAimReg: Double = 0;
                        fltRefTimReg: Double = 0;
                        fltRefCbsReg: Double = 0;
                        fltRefTcbReg: Double = 0;
                        fltIcmPrd: Double = 0;
                        fltSiscomex: Double = 0;
                        strChvRef: String = '';
                        strIteRef: String = '';
                        ABatch: Pointer = Nil; {Req. 456948}
                        fltBimRet: Double = 0;
                        fltAimRet: Double = 0;
                        blnRefEspelhaDocumento: Boolean = False): Boolean;

  function fGravaMovDetSimplificada(
                        Var strAutInc: String;
                        strSeqGer: String;
                        strNumDoc,
                        strEspDoc,
                        strCodEmp,
                        strCodIte,
                        strCodVen,
                        strCodDiv,
                        strCodMar,
                        strCodFor,
                        strCodCli: String;
                        dtaDtaEnt,
                        dtaHorEnt,
                        dtaDtaDoc: TDateTime;
                        strConPag,
                        strTip_Fc,
                        strEstado,
                        strDescri,
                        strRefere,
                        strUnidad,
                        strForIte: String;
                        fltQtdIte,
                        fltUnitar,
                        fltUniOri,
                        fltUniVis,
                        fltTotIte,
                        fltVlrCon,
                        fltTotCus,
                        fltTotMed,
                        fltDesCon,
                        fltTotFre,
                        fltDesEsp: Double;
                        strCodRep,
                        strCodVe2: String;
                        fltPerCom,
                        fltTotCom,
                        fltTotCo2: Double;
                        strClaFis,
                        strCodFis: String;
                        fltValIpi,
                        fltAlqIpi,
                        fltBasIpi,
                        fltValIcm,
                        fltAlqIcm,
                        fltBasIcm,
                        fltValRet,
                        fltAlqRet,
                        fltBasRet,
                        fltTotPes,
                        fltPerBas,
                        fltPerRed: Double;
                        blnJafatu: Boolean;
                        strTipFat,
                        strNumFat,
                        strEmpFat: String;
                        dtaDtaFat: TDateTime;
                        strVenFat,
                        strCndFat: String;
                        fltValFat: Double;
                        strIdePro,
                        strIncPis,
                        strSerie: String;
                        fltDesAce: Double;
                        strNotEsp,
                        strDocDev,
                        strEspDev,
                        strEmpDev,
                        strIteCha,
                        strIteTin,
                        strDesCor,
                        strTipEmb: String;
                        fltQtdEmb,
                        fltPreEmb: Double;
                        strTipPre: String;
                        fltPrvTin,
                        fltPrcTin,
                        fltFatTin: Double;
                        strProEmb,
                        strCodDig,
                        strCodCnd,
                        strCodFpg,
                        strIteEmb,
                        strGruEmb: String;
                        intLazQua: Integer;
                        strPromoc,
                        strSeqTin: String;
                        fltQtdPul: Double;
                        strPedCom,
                        strOriDoc,
                        strNum_Pd,
                        strEsp_Pd,
                        strEmp_Pd: String;
                        intInd_Pd: Integer;
                        strOrdPro,
                        strDesNes,
                        strCliFat: String;
                        fltBcaMin,
                        fltBcaCom,
                        fltVolPro: Double;
                        strCodAca,
                        strEmpAca: String;
                        blnProAca,
                        blnFilKar: Boolean;
                        strEspFut,
                        strDocFut,
                        strEmpFut,
                        strTabPre,
                        strEmpCom: String;
                        strLinha,
                        strCatali,
                        strCodDil: String;
                        fltPorDil: Double;
                        strDilCon: String;
                        fltPorCat,
                        fltUniDig,
                        fltQtdPon: Double;
                        strEntFut,
                        strMotFut: String;
                        dtaDtaFut: TDateTime;
                        fltTotCu2,
                        fltComRep,
                        fltPerRep: Double;
                        strKey_EP,
                        strNumLot,
                        strPigBas: String;
                        fltVaEIpi,
                        fltAlEIpi,
                        fltBaEIpi,
                        fltTotUlt,
                        fltImpUlt,
                        fltBaRtSP,
                        fltVaRtSP,
                        fltIcOpPr: Double;
                        intSeqCcr: Integer;
                        fltEmbala,
                        fltAlqPis,
                        fltBasPis,
                        fltValPis: Double;
                        strCSTPis: String;
                        fltAlqCof,
                        fltBasCof,
                        fltValCof: Double;
                        strCSTCof,
                        strCSTIpi,
                        strEnqIpi: String;
                        fltVaERet,
                        fltAlERet,
                        fltBaERet,
                        fltPesLiq: Double;
                        const objParams: TMovDetParams): Boolean;

  {Req. 456948-B - B10b. Moldes de dataset compartilhados entre chamadas de
   fGravaMovDet. Fora do par Abre/Fecha nada muda: as variaveis ficam Nil e a
   funcao cria e abre os proprios datasets como sempre fez.

   O ciclo de vida e do chamador, igual ao ABatch: quem abre, fecha - e fecha
   em TODOS os caminhos de saida, inclusive Except.}
  procedure pAbreMoldesMovDet;
  procedure pFechaMoldesMovDet;

  function fGravaDetCha(strAutInc: String;
                        fltQtdCha: Double;
                        fltMedB_L: Double;
                        fltMedB_A: Double;
                        fltMedL_L: Double;
                        fltMedL_A: Double;
                        fltEspess: Double): Boolean;

  function fRetornaDadosDetCha(strAutInc: String;
                               fltQtdIte: Double;
                               Out fltQtdCha: Double;
                               Out fltMedB_L: Double;
                               Out fltMedB_A: Double;
                               Out fltMedL_L: Double;
                               Out fltMedL_A: Double;
                               Out fltEspess: Double):Boolean;

  function fSetaOperadorESeparadorDaExpedicao(const strSepExp, strOpeExp, strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  function fMarcaDocumentoComoExpedido(const strSepExp, strNumDoc, strEspDoc, strCodEmp, strCodCli: String; const strSerie_: String=''): Boolean;

  procedure pMarcarDataExpedicaoFaturamentoAutomatico(ANumFat, ATipFat, AEmpFat, ACliFat: String; dtaDtlBex: TDate;
                                                      ANumOrc: String=''; AEspOrc: String=''; AEmpOrc: String=''; ASerFat: String='');

  procedure pMarcaRomImp(strNumDoc, strEspDoc, strCodEmp, strTip_Fc: String; blnPrevia: Boolean = False);

  function fGravaMovMod(strNumDoc,
                        strEspDoc,
                        strCodEmp,
                        strCodCli,
                        strSerie_,
                        strCodMod: String;
                        fltValMod: Double;
                        strDocume: String;
                        fltValPag: Double;
                        strTipCar : String = '';
                        strCodRed : String = '';
                        strPixS_N : String = ''): Boolean;

  function fRetNumPed(strTabela,
                      strNumDoc,
                      strEspDoc,
                      strCodEmp: String): String;

  {$IFNDEF LINUX}
  procedure pCarregaItensLogSeparacaoImpressao(cdsLogSep: TUniClientDataSet; Var cdsImpLogSep: TUniClientDataSet; blnEnt_CD, blnLocFisEmpEmi: Boolean);
  {$ENDIF}

  function fCarregaItensPendenteSeparacao(cdsItensPendSeparacao: TUniClientDataSet; strCodEmp, strNumDoc, strEspDoc, strCodCli: String): Boolean;
  procedure pPreencheCDSItensPendSeparacao(qryItens: TUniQuery; cdsItensPend, cdsImpLogSep: TUniClientDataSet; blnEnt_CD, blnLocFisEmpEmi: Boolean);

  function fGravaMovInf( var strAutInc : String;
                         strSeqGer : String;
                         strInfCpl : String ):Boolean;

  function fAtualizaCnfNfeMovNotObs(strNumDoc, strEspDoc, strCodEmp, strValAdicCnfCom, strValAdicCnfFis: String): Boolean;
  procedure fGravaGERCND(strAutInc: String; arrDuplic: TarrDuplicata );

  procedure pAjustaEstoqueExterno(strCodEmp, strCodIte, strCodExt, strClaFis, strChaAce, strHubMkp: String; fltQtdIte: Double);

  procedure pAtualizaIndiceNFEConformeOrdenacao(strSEQGER, strTabela: String);

  procedure pGravarVinculacaoDocumentoComodatoCilindroVasilhameMovGer(
    strAutInc: String; const strEspDoc: String);
  function fDocumentoExpedido(const strNumDoc, strEspDoc, strCodEmp : string) : Boolean;

  Var
    strSQLMovGer: String;
    objReprocessarSaldoItens: IReprocessarSaldoItem;
  {Req. 456948-B - B10b. Moldes compartilhados. Ficam na implementation de
   proposito: ninguem fora desta unit deve alcancar as variaveis, so o par
   pAbreMoldesMovDet / pFechaMoldesMovDet.}
  Var
    objMoldeMovDet: TUniQuery = Nil;
    objMoldeMovTri: TUniQuery = Nil;
    objMoldeMovAux: TUniQuery = Nil;
implementation

uses
{$IFDEF LINUX}
  untFuncoesGenerica,
{$ELSE}
  untFuncoes,
  untSQLRepositorio,
{$ENDIF}
  untFinanceira,
  untFuncoesAutocenter,
  untConstantes,
  untCadPro;

procedure pIncluiAuxMov(strNomTab,
                        strAutInc,
                        strAutEnt,
                        strDocCon: String;
                        fltValCre: Double;
                        dtaNasCon: TDate;
                        strCodObr,
                        strCodArt,
                        strPermut,
                        strRetIss: String;
                        strOpcDoc: String;
                        fltFreSug: Double;
                        strNumAde: String;
                        fltBasAnt: Double;   //BASE DE ICMS ANTECIPADO
                        fltValAnt: Double;   //VALOR DE ICMS ANTECIPADO
                        strNaoAtu: String;
                        strEntUrg: String;
                        fltDupRec: Double;
                        fltValAdt: Double;
                        strNumGui: String;
                        objServicos: TClassDadosServicos;
                        fltDeDVCf: Double = 0;
                        strPlaVei: String = '';
                        strKm_Vei: String = '';
                        strCliOri: String = '';
                        strCodMot: String = '';
                        strBetone: String = '';
                        strLacre_: String = '';
                        strTipMps: String = '';
                        strAbatim: String = '';
                        strBrita_: String = '';
                        strConBom: String = '';
                        intFckDia: Integer = 0;
                        fltImpPag: Double = 0;
                        intPrzMed: integer = 0;
                        strChvNfeDev: String = '';
                        strOpeSol: String = '';
                        blnEst_Dv: Boolean = False;
                        strNumCOODev: String = '';
                        strNumSerDev: String = '';
                        strNumUSUDev: String = '';
                        strTipDocDev: String = '';
                        fltTotDif: Double = 0;
                        strFasObr: String = '';
                        objFazenda: Pointer = nil;
                        fltFedImp: Double = 0;
                        fltEstImp: Double = 0;
                        fltMunImp: Double = 0;
                        fltTroco_: Double = 0;
                        strVenPre: String = 'N';
                        strSeqDocOri: String = '';
                        blnConEqu: Boolean = False;
                        blnDescIncond: Boolean = False;
                        blnGraCTP: Boolean = True;
                        strNumera: String = '';
                        strEdiPes: String = 'N';
                        fltTaxEnt: Double = 0;
                        fltVrdIcm: Double = 0;
                        fltBasVrd: Double = 0;
                        strCodEmbarcacao: String = '';
                        fltTotBri: Double = 0;
                        blnDevEsp: Boolean=False;
                        strTraRdp: String = '';
                        strCliCtt: String = '';
                        strCodMod: String = '';
                        strCodAti: String = '';
                        strHisCom: String = '';
                        strCodPrj: String = '';
                        strNatCfo: String = '';
                        strTpOper: String = '';
                        strCupDes: String = '';
                        strNotPau: String = 'S';
                        fltCotMoe: Double = 0;
                        fltFreMkp: Double = 0;
                        fltComMkp: Double = 0;
                        strPlaFat: String = '';
                        blnDevWms: Boolean = False;
                        fltFreCot: Double = 0;
                        fltFreRat: Double = 0;
                        strEntSim: String = 'N';
                        strSeqDmp: String = '';
                        strEntFutOpc: String = '';
                        fltTotIpiEntFut: Double = 0;
                        fltTotRetEntFut: Double = 0;
                        fltTotFcpSTEntFut: Double = 0;
                        fltICMDes: Double = 0;
                        fltDesPis: Double = 0;
                        strOpFaEx: String = '';
                        strDocAba: String = '';
                        strEspAba: String = '';
                        strEmpAba: String = '';
                        strCliAba: String = '';
                        strTem_ST: String = 'N';
                        blnColeta: Boolean = False;
                        strNumeroRandomico : String = '';
                        strNumeroDrawback : String = '';
                        strCodFinalidadeAjuste : String = '';
                        strDoc_RE: String = '';
                        strEsp_RE: String = '';
                        strEmp_RE: String = '';
                        strCli_RE: String = '';
                        strDocRE2: String = '';
                        strEspRE2: String = '';
                        strEmpRE2: String = '';
                        strCliRE2: String = '';
                        strEmp_TE: String = '';
                        strAutIcv: String = '';
                        strEspDoc: String = '';
                        strEmp_PR: String = '';
                        strCliCEO: String = '';
                        fltVolSepExc: Double = 0;
                        fltVolSepNExc: Double = 0;
                        strSupGer : String = '';
                        strSupReg : String = '';
                        strCelCon: String = '';
                        strAbaDep: String = 'N';
                        strEmpDep: String = '';
                        strAbf_Uf: String = '';
                        strEstornoNotaFiscal: String = '';
                        strCodTpA: String = '';
                        strMatRev: String = '';
                        strTipAbf: string = '';
                        strVchCdp: String = '';
                        strCodCno : String = '';
                        fltTotIbs:            Double = 0;
                        fltTotCbs:            Double = 0;
                        fltTotIs:             Double = 0;
                        fltTotProIs:          Double = 0;
                        fltTotNf:             Double = 0;
                        strInsImo : String = '';
                        strCodCib : String = ''
                        );

  Var
    qryAuxGer: TUniQuery;
Begin
  qryAuxGer := fCriaQuery(Nil);
  Try
    With qryAuxGer, SQL Do
    Begin
      Add('SELECT * FROM AUXMOV WHERE FALSE');

      Open;
      qryAuxGer.Insert;

      FieldByName('AUX_SEQGER').AsString := strAutInc;

      If Not fEmptyStr(strAutEnt) Then
        FieldByName('AUX_ENTGER').AsString := strAutEnt;

      FieldByName('AUX_VALCRE').AsFloat  := fltValCre;
      FieldByName('AUX_DOCCON').AsString := strDocCon;
      FieldByName('AUX_CODOBR').AsString := strCodObr;
      FieldByName('AUX_CODART').AsString := strCodArt;
      FieldByName('AUX_CODCNO').AsString := strCodCno;
      FieldByName('AUX_INSIMO').AsString := strInsImo;
      FieldByName('AUX_CODCIB').AsString := strCodCib;
      FieldByName('AUX_PERMUT').AsString := strPermut;

      If dtaNasCon > 0 Then
        FieldByName('AUX_NASCON').AsDateTime := dtaNasCon;

      If Not fEmptyStr(strRetIss) Then
        FieldByName('AUX_RETISS').AsString := strRetIss;

      FieldByName('AUX_OPCDOC').AsString := strOpcDoc;
      FieldByName('AUX_FRESUG').AsFloat  := fltFreSug;
      FieldByName('AUX_CODADE').AsString := strNumAde;
      FieldByName('AUX_BASANT').AsFloat  := fltBasAnt;
      FieldByName('AUX_TOTANT').AsFloat  := fltValAnt;
      FieldByName('AUX_NAOATU').AsString := strNaoAtu;
      FieldByName('AUX_ENTURG').AsString := strEntUrg;
      FieldByName('AUX_DUPREC').AsFloat  := fltDupRec;
      FieldByName('AUX_VALADT').AsFloat  := fltValAdt;
      FieldByName('AUX_NUMGUI').AsString := strNumGui;
      FieldByName('AUX_TAXENT').AsFloat  := fltTaxEnt;

      If Not fUsaImpostoFonteIBPT Then
        FieldByName('AUX_IMPPAG').AsFloat  := fltImpPag
      Else
      Begin
        FieldByName('AUX_IMPPAG').AsFloat  := fltFedImp + fltEstImp + fltMunImp;
        FieldByName('AUX_FEDIMP').AsFloat  := fltFedImp;
        FieldByName('AUX_ESTIMP').AsFloat  := fltEstImp;
        FieldByName('AUX_MUNIMP').AsFloat  := fltMunImp;
      End;

      FieldByName('AUX_PRZMED').AsInteger:= intPrzMed;

      If Not fEmptyStr(strPlaVei) Then
      Begin
        FieldByName('AUX_PLAVEI').AsString := strPlaVei;
        FieldByName('AUX_KM_VEI').AsString := strKm_Vei;
      End
      Else
      Begin
        FieldByName('AUX_PLAVEI').Value := Null;
        FieldByName('AUX_KM_VEI').Value := Null;
      End;

      If fEmptyStr(strCodMot) Then
        FieldByName('AUX_CODMOT').Value := Null
      Else
        FieldByName('AUX_CODMOT').AsString := strCodMot;

      If fEmptyStr(strCliOri) Then
        FieldByName('AUX_CLIORI').Value := Null
      Else
        FieldByName('AUX_CLIORI').AsString := strCliOri;

      If fEmptyStr(strOpeSol) Then
        FieldByName('AUX_OPESOL').Value := Null
      Else
        FieldByName('AUX_OPESOL').AsString := strOpeSol;

      If Not fEmptyStr(strFasObr) Then
        FieldByName('AUX_FASOBR').AsString := strFasObr;

      FieldByName('AUX_BETONE').AsString  := strBetone;
      FieldByName('AUX_LACRE_').AsString  := strLacre_;
      FieldByName('AUX_TIPMPS').AsString  := strTipMps;
      FieldByName('AUX_ABATIM').AsString  := strAbatim;
      FieldByName('AUX_BRITA_').AsString  := strBrita_;
      FieldByName('AUX_CONBOM').AsString  := strConBom;
      FieldByName('AUX_FCKDIA').AsInteger := intFckDia;
      FieldByName('AUX_CHVNFE').AsString  := strChvNfeDev;
      FieldByName('AUX_EST_DV').AsString  := IIF(blnEst_Dv, 'S', 'N');
      FieldByName('AUX_NUMCOO').AsString  := strNumCOODev;
      FieldByName('AUX_NUMSER').AsString  := strNumSerDev;
      FieldByName('AUX_NUMUSU').AsString  := strNumUSUDev;
      FieldByName('AUX_TIPDOC').AsString  := strTipDocDev;
      FieldByName('AUX_DESINC').AsString  := IIf(blnDescIncond, 'S', 'N');
      FieldByName('AUX_BASISS').AsFloat   := objServicos.fltBasIss;
      FieldByName('AUX_REDISS').AsFloat   := objServicos.fltRedIss;
      FieldByName('AUX_DEDISS').AsFloat   := objServicos.fltDedIss;
      FieldByName('AUX_TOTDIF').AsFloat   := fltTotDif;

      If (Assigned(objFazenda) And Not fEmptyStr(TDadosFazendaBase(objFazenda).strCodFaz)) Then
        FieldByName('AUX_CODFAZ').AsString := TDadosFazendaBase(objFazenda).strCodFaz
      Else
        FieldByName('AUX_CODFAZ').Value := Null;

      FieldByName('AUX_TROCO_').AsFloat  := fltTroco_;
      FieldByName('AUX_LBRCAU').AsString := 'N';
      FieldByName('AUX_VENPRE').AsString := strVenPre;

      If fEmptyStr(strSeqDocOri) Then
        FieldByName('AUX_SEQDOR').Value := Null
      Else
        FieldByName('AUX_SEQDOR').AsString  := strSeqDocOri;

      If blnConEqu Then
        FieldByName('AUX_CONEQU').AsString := 'S'
      Else
        FieldByName('AUX_CONEQU').AsString := 'N';

      FieldByName('AUX_GRACTP').AsString  := IIf(blnGraCTP, 'S', 'N');
      FieldByName('AUX_NUMERA').AsString  := strNumera;
      FieldByName('AUX_EDIPES').AsString  := strEdiPes;

      FieldByName('AUX_VRDICM').AsFloat  := fltVrdIcm;
      FieldByName('AUX_BASVRD').AsFloat  := fltBasVrd;

      If fEmptyStr(strCodEmbarcacao) Then
        FieldByName('AUX_CODEMB').Value := Null
      Else
        FieldByName('AUX_CODEMB').AsString := strCodEmbarcacao;

      If fEmptyStr(strCodFinalidadeAjuste) Then
        FieldByName('AUX_FINAJU').Value := Null
      Else
        FieldByName('AUX_FINAJU').AsString := strCodFinalidadeAjuste;

      FieldByName('AUX_TOTBRI').AsFloat := fltTotBri;

      FieldByName('AUX_DEVESP').AsString  := IIf(blnDevEsp, 'S', 'N');

      If fEmptyStr(strTraRdp) Then
        FieldByName('AUX_TRARDP').Value := Null
      Else
        FieldByName('AUX_TRARDP').AsString := strTraRdp;

      If fEmptyStr(strCliCtt) Then
        FieldByName('AUX_CLICTT').Value := Null
      Else
        FieldByName('AUX_CLICTT').AsString := strCliCtt;

      If fEmptyStr(strCodMod) Then
        FieldByName('AUX_CODMOD').Value := Null
      Else
        FieldByName('AUX_CODMOD').AsString := strCodMod;

      If fEmptyStr(strCodPrj) Then
        FieldByName('AUX_CODPRJ').Value := Null
      Else
        FieldByName('AUX_CODPRJ').AsString := strCodPrj;

      FieldByName('AUX_CODATI').AsString := strCodAti;
      FieldByName('AUX_HISCOM').AsString := strHisCom;
      FieldByName('AUX_EMP_TE').Value := IIF(fEmptyStr(strEmp_TE), Null, strEmp_TE);
      FieldByName('AUX_TPOPER').AsString := strTpOper;

      If not fEmptyStr(strCupDes) Then
        FieldByName('AUX_CUPDES').AsString := strCupDes;

      FieldByName('AUX_NOTPAU').AsString := strNotPau;

      If fEmptyStr(strNatCfo) Then
        FieldByName('AUX_NATCFO').Value := Null
      Else
        FieldByName('AUX_NATCFO').AsString := strNatCfo;

      FieldByName('AUX_FREMKP').AsFloat := fltFreMkp;
      FieldByName('AUX_COMMKP').AsFloat := fltComMkp;
      FieldByName('AUX_COTMOE').AsFloat := fltCotMoe;
      FieldByName('AUX_SEFREC').AsString := 'N';
      FieldByName('AUX_PLAFAT').AsString := AnsiReplaceStr(strPlaFat, '-', '');
      FieldByName('AUX_DEVWMS').AsString  := IIf(blnDevWms, 'S', 'N');
      FieldByName('AUX_FRECOT').AsFloat  := fltFreCot;
      FieldByName('AUX_FRERAT').AsFloat  := fltFreRat;

      FieldByName('AUX_ENTSIM').AsString := strEntSim;
      FieldByName('AUX_SEQDMP').AsString := strSeqDmp;

      If fEmptyStr(strEntFutOpc) Then
        FieldByName('AUX_ENFUOP').Value := Null
      Else
        FieldByName('AUX_ENFUOP').AsString := strEntFutOpc;

      FieldByName('AUX_TIPIBF').AsFloat := fltTotIpiEntFut;
      FieldByName('AUX_TRETBF').AsFloat := fltTotRetEntFut;
      FieldByName('AUX_TFSTBF').AsFloat := fltTotFcpSTEntFut;

      FieldByName('AUX_ICMDES').AsFloat  := fltIcmDes;
      FieldByName('AUX_DESPIS').AsFloat  := fltDesPis;

      If fEmptyStr(strOpFaEx) Then
        FieldByName('AUX_OPFAEX').Value := Null
      Else
        FieldByName('AUX_OPFAEX').AsString := strOpfaEx;

      FieldByName('AUX_DOCABA').Value := IIF(fEmptyStr(strDocAba), Null, strDocAba);
      FieldByName('AUX_ESPABA').Value := IIF(fEmptyStr(strEspAba), Null, strEspAba);
      FieldByName('AUX_EMPABA').Value := IIF(fEmptyStr(strEmpAba), Null, strEmpAba);
      FieldByName('AUX_CLIABA').Value := IIF(fEmptyStr(strCliAba), Null, strCliAba);

      FieldByName('AUX_DOC_RE').Value := IIF(fEmptyStr(strDoc_RE), Null, strDoc_RE);
      FieldByName('AUX_ESP_RE').Value := IIF(fEmptyStr(strEsp_RE), Null, strEsp_RE);
      FieldByName('AUX_EMP_RE').Value := IIF(fEmptyStr(strEmp_RE), Null, strEmp_RE);
      FieldByName('AUX_CLI_RE').Value := IIF(fEmptyStr(strCli_RE), Null, strCli_RE);

      FieldByName('AUX_DOCRE2').Value := IIF(fEmptyStr(strDocRE2), Null, strDocRE2);
      FieldByName('AUX_ESPRE2').Value := IIF(fEmptyStr(strEspRE2), Null, strEspRE2);
      FieldByName('AUX_EMPRE2').Value := IIF(fEmptyStr(strEmpRE2), Null, strEmpRE2);
      FieldByName('AUX_CLIRE2').Value := IIF(fEmptyStr(strCliRE2), Null, strCliRE2);

      FieldByName('AUX_TEM_ST').AsString := strTem_ST;

      FieldByName('AUX_COLETA').AsString := IIf(blnColeta, 'S', 'N');

      FieldByName('AUX_NUMRAN').AsString := strNumeroRandomico;

      FieldByName('AUX_NUMDRW').AsString := strNumeroDrawback;

      If (fCfgSis('CDTCLV', varBoolean)) And
         (Pos(strEspDoc, 'FF_IF_NF_') > 0) And
         (Not fEmptyStr(strAutIcv)) Then
      Begin
        FieldByName('AUX_AUTICV').AsString := strAutIcv;
        FieldByName('AUX_CILVAS').AsString := 'S'
      End
      Else
      Begin
        FieldByName('AUX_AUTICV').Value    := Null;
        FieldByName('AUX_CILVAS').AsString := 'N'
      End;

      If Not fEmptyStr(strEmp_PR) Then
        FieldByName('AUX_EMP_PR').AsString := strEmp_PR;

      If fEmptyStr(strCliCEO) Then
        FieldByName('AUX_CLICEO').Value := Null
      Else
        FieldByName('AUX_CLICEO').AsString := strCliCEO;

      FieldByName('AUX_VOLEXS').AsFloat := fltVolSepExc;
      FieldByName('AUX_VOLEXN').AsFloat := fltVolSepNExc;

      If fEmptyStr(strSupGer) Then
        FieldByName('AUX_SUPGER').Value := Null
      Else
        FieldByName('AUX_SUPGER').AsString := strSupGer;

      If fEmptyStr(strSupReg) Then
        FieldByName('AUX_SUPREG').Value := Null
      Else
        FieldByName('AUX_SUPREG').AsString := strSupReg;

      FieldByName('AUX_CELCON').AsString := strCelCon;

      FieldByName('AUX_ABADEP').AsString := strAbaDep;

      FieldByName('AUX_ABF_UF').AsString := strAbf_Uf;

      If fEmptyStr(strEmpDep) Then
        FieldByName('AUX_EMPDEP').Value := Null
      Else
        FieldByName('AUX_EMPDEP').AsString := strEmpDep;

      FieldByName('AUX_ESTNFE').AsString := strEstornoNotaFiscal;

      If fEmptyStr(strCodTpA) Then
        FieldByName('AUX_CODTPA').Value := null
      Else
        FieldByName('AUX_CODTPA').AsString := strCodTpA;

      If fEmptyStr(strMatRev) Then
        FieldByName('AUX_MATREV').Value := Null
      Else
        FieldByName('AUX_MATREV').AsString  := strMatRev;

      FieldByName('AUX_TIPABF').Value := Null;
      If Not fEmptyStr(strTipAbf) Then
        FieldByName('AUX_TIPABF').AsString  := strTipAbf;

      If FindField('AUX_VCHCDP') <> Nil Then
      Begin
        If fEmptyStr(strVchCdp) Then
          FieldByName('AUX_VCHCDP').Value := Null
        Else
          FieldByName('AUX_VCHCDP').AsString  := strVchCdp;
      End;

      qryAuxGer.FieldByName('AUX_TOTIBS').AsFloat := fltTotIbs;
      qryAuxGer.FieldByName('AUX_TOTCBS').AsFloat := fltTotCbs;
      qryAuxGer.FieldByName('AUX_TOT_IS').AsFloat := fltTotIs;
      qryAuxGer.FieldByName('AUX_TPROIS').AsFloat := fltTotProIs;
      qryAuxGer.FieldByName('AUX_TOT_NF').AsFloat := fltTotNf;

      Post;

    End;
  Finally
    FreeAndNil(qryAuxGer);
  End;
End;

{*****************************************}
{* =============> ANTEÇÃO <============= *}
{* AO CRIAR UM PARAMETRO NESSA FUNÇÃO,   *}
{* RECOMPILAR O AUTCOMTINTA              *}
{**************************************MV*}
function fGravaMovGer(Var strAutInc: String;
                      strNumDoc,
                      strEspDoc,
                      strCodEmp,
                      strCodTra,
                      strCodVen,
                      strCodFor,
                      strCodCli,
                      strTip_Fc: String;
                      dtaDtaEnt,
                      tmrHorEnt,
                      dtaDtaDoc: TDateTime;
                      strConPag,
                      strEstado,
                      strNomCon,
                      strEndCon,
                      strBaiCon,
                      strCepCon,
                      strCidCon,
                      strEstCon,
                      strTelCon: String;
                      dtaNasCon: TDate;
                      strCgcCpf,
                      strCgcCon,
                      strIesCon,
                      strCli_Rg: String;
                      fltBasSim,
                      fltBasIpi,
                      fltAlqIpi,
                      fltTotIpi,
                      fltBasIcm,
                      fltAlqIcm,
                      fltTotIcm,
                      fltTotRet,
                      fltAlqRet,
                      fltBasRet,
                      fltRet_SP,
                      fltDesEsp,
                      fltVlrCon,
                      fltTotPro,
                      fltTotCus,
                      fltTotMed: Double;
                      strTipFre: String;
                      fltTotFre,
                      fltPesBru,
                      fltPesLiq,
                      fltVolume: Double;
                      strEspeci,
                      strMarca,
                      strMen001,
                      strMen002,
                      strMen003,
                      strMen004,
                      strMen005: String;
                      blnJafatu: Boolean;
                      strTipFat,
                      strNumFat,
                      strEmpFat: String;
                      dtaDtaFat: TDateTime;
                      strVenFat,
                      strCndFat: String;
                      blnDevEsp: Boolean;
                      fltValFat,
                      fltVPar01,
                      fltVPar02,
                      fltVPar03,
                      fltVPar04,
                      fltVPar05,
                      fltVPar06,
                      fltVPar07,
                      fltVPar08,
                      fltVPar09,
                      fltVPar10,
                      fltVPar11,
                      fltVPar12: Double;
                      arrDuplic: TarrDuplicata;
                      strSerie,
                      strNotEsp,
                      strClaFis,
                      strClaFi2,
                      strClaFi3,
                      strNatOpe: String;
                      fltPorDes: Double;
                      strCodDig,
                      strCodCnd,
                      strCodFpg: String;
                      fltFatNot: Double;
                      recServicos: TDadosServicos;
                      fltDesAce: Double;
                      strOriDoc,
                      strConEnt,
                      strCodRep: String;
                      fltAlqIrf,
                      fltValIrf,
                      fltAlqPis,
                      fltValPis,
                      fltAlqCof,
                      fltValCof,
                      fltAlqCsl,
                      fltValCsL,
                      fltIrfRet,
                      fltPisRet,
                      fltCofRet,
                      fltCslRet: Double;
                      strNotRet: String;
                      fltAlIrfP,
                      fltAlPisP,
                      fltAlCofP,
                      fltAlCslP,
                      fltSerRet: Double;
                      strNoReSe: String;
                      fltPeSgSo,
                      fltVlSgSo,
                      fltIrPrRt,
                      fltIrPrDv,
                      fltIrSeRt,
                      fltIrSeDv,
                      fltPiPrRt,
                      fltPiPrDv,
                      fltPiSeRt,
                      fltPiSeDv,
                      fltCoPrRt,
                      fltCoPrDv,
                      fltCoSeRt,
                      fltCoSeDv,
                      fltCsPrRt,
                      fltCsPrDv,
                      fltCsSeRt,
                      fltCsSeDv: Double;
                      strOrdPro: String;
                      fltBasOrg,
                      fltIcmOrg: Double;
                      intNConhe: Integer;
                      strConsum,                     // Consumidor final
                      strEntFat,
                      strCliFat,
                      strOpeExp,
                      strSepExp,
                      strTabPre,
                      strNum_Pr,
                      strEntFut: String;
                      blnBaiFut: Boolean;
                      fltMargem: Double;
                      fltBaRtSp,
                      fltVlRtSp: Double;
                      strOprFlj,
                      strNumReg: String;
                      dtaDtEntr: TDateTime;
                      strClaFi4,
                      strAutSer,
                      strCodEve,
                      strAutEnt,
                      strObsNfe,
                      strCodOco: String;
                      strFasObr: String;
                      blnIpDpNf: Boolean;
                      fltValCre: Double    = 0;
                      dtadtlBex: TDateTime = 0;
                      strEmlCon: String    = '';
                      dtaDtESNf: TDateTime = 0;
                      tmrHrESNf: TDateTime = 0;
                      objFinanc: Pointer = Nil;
                      strDocCon: String = '';            // Conhecimento de Frete
                      strCodObr: String = '';
                      strCodArt: String = '';
                      strPermut: String = 'N'; // Permuta para isenção de pagamento de comissão
                      strRetIss: String = '';
                      strOpcDoc: String = '';
                      fltFreSug: Double = 0;
                      strNumAde: String = '';
                      fltBasAnt: Double = 0;            //BASE DE ICMS ANTECIPADO
                      fltValAnt: Double = 0;            //VALOR DE ICMS ANTECIPADO
                      strNaoAtu: String = '';
                      strEntUrg: String = '';
                      strMenExp: String = '';
                      strMenEx2: String = '';
                      strMenEx3: String = '';
                      strMenEx4: String = '';
                      fltDupRec: Double = 0;
                      fltValAdt: Double = 0;
                      fltDeDVCf: Double = 0;
                      strPlaVei: String = '';
                      strKm_Vei: String = '';
                      strCliOri: String = '';
                      strCodMot: String = '';
                      strBetone: String = '';
                      strLacre_: String = '';
                      strTipMps: String = '';
                      strAbatim: String = '';
                      strBrita_: String = '';
                      strConBom: String = '';
                      intFckDia: Integer = 0;
                      fltImpPag: Double = 0;
                      intPrzMed: integer = 0;
                      blnImpPdv: Boolean = False;
                      blnDTEXREP: Boolean = False;
                      strChvNfeDev: String = '';
                      strOpeSol: String = '';
                      blnEst_Dv: Boolean = False;
                      strNumCOODev: String = '';
                      strNumSerDev: String = '';
                      strNumUSUDev: String = '';
                      strTipDocDev: String = '';
                      fltTotDif: Double = 0;
                      objFazenda: Pointer = nil;
                      fltFedImp   : Double = 0;
                      fltEstImp   : Double = 0;
                      fltMunImp   : Double = 0;
                      fltTroco_: Double = 0;
                      strObsNfeFis: String = '';
                      strVenPre: String = 'N';
                      strSeqDocOri: String = '';
                      blnConEqu: Boolean = False;
                      blnDescIncond: Boolean = False;
                      blnGraCTP: Boolean = True;
                      strNumera: String = '';
                      strEdiPes: String = 'N';
                      fltTaxEnt: Double = 0;
                      fltVrdIcm: Double = 0;
                      fltBasVrd: Double = 0;
                      intNroBox: Integer = 0;
                      strCodEmbarcacao: String = '';
                      fltTotBri: Double = 0;
                      strTraRdp: String = '';
                      strCliCtt: String = '';
                      strCodMod: String = '';
                      strNumGui: String = '';
                      strHisCom: String = '';
                      strCodPrj: String = '';
                      strNatCfo: String = '';
                      strTpOper: String = '';
                      strCupDes: String = '';
                      strNotPau: String = 'S';
                      fltCotMoe: Double = 0;
                      fltFreMkp: Double = 0;
                      fltComMkp: Double = 0;
                      strPlaFat: String = '';
                      blnDevWms: Boolean = False;
                      blnFulfillmentModoRobo : Boolean = False;
                      fltFreCot: Double = 0;
                      fltFreRat: Double = 0;
                      strEntSim: String = 'N';
                      strSeqDmp: String = '';
                      strEntFutOpc: String = '';
                      fltTotIpiEntFut: Double = 0;
                      fltTotRetEntFut: Double = 0;
                      fltTotFcpSTEntFut: Double = 0;
                      fltICMDes: Double = 0;
                      fltDesPis: Double = 0;
                      strOpFaEx: String = '';
                      strDocAba: String = '';
                      strEspAba: String = '';
                      strEmpAba: String = '';
                      strCliAba: String = '';
                      blnColeta: Boolean = False;
                      strNumeroRandomico : String = '';
                      strNumeroDrawback : String = '';
                      strCodFinalidadeAjuste : String = '';
                      strDoc_RE: String = '';
                      strEsp_RE: String = '';
                      strEmp_RE: String = '';
                      strCli_RE: String = '';
                      strDocRE2: String = '';
                      strEspRE2: String = '';
                      strEmpRE2: String = '';
                      strCliRE2: String = '';
                      strEmp_TE: String = '';
                      strAutIcv: String = '';
                      strEmp_PR: String = '';
                      strCliCEO: String = '';
                      fltVolSepExc: Double = 0;
                      fltVolSepNExc: Double = 0;
                      strSupGer: String = '';
                      strSupReg: String = '';
                      strCelCon: String = '';
                      strAbaDep: String = 'N';
                      strEmpDep: String = '';
                      strAbf_Uf: String = '';
                      strEstornoNotaFiscal: String = '';
                      strCodTpA: String = '';
                      strMatRev: String = '';
                      strVchCdp: String = '';
                      strCodCno : String = '';
                      fltTotIbs:            Double = 0;
                      fltTotCbs:            Double = 0;
                      fltTotIs:             Double = 0;
                      fltTotProIs:          Double = 0;
                      fltTotNf:             Double = 0;
                      strInsImo : String = '';
                      strCodCib : String = ''
                      ): Boolean;

  Var
    blnLiberado: Boolean;
    RegistroContabilidade: TrecRegistroContabilidade;

  function fQtdSer(fltQtdSer: Double): Double;
  begin
    If fCfgSis('QTDSER', VarBoolean) Then
      Result := fltQtdSer
    Else
      Result := 1;
  end;

  Var
    intServico: Integer;
    objServicos: TClassDadosServicos;
    qryTblMovGer: TUniQuery;
    qryTblMovObs: TUniQuery;
    blnSolDtaEntSaiNfe: Boolean;
    strTem_ST: String;
    strTipAbf: String;
Begin
  Result := True;

  objServicos := TClassDadosServicos.Create(recServicos);

  blnSolDtaEntSaiNfe := fCfgSis('SOLDSE', varBoolean);

  If (strEspDoc = 'IF') And
     (fltTotFre = 0) And
     (strTipFre <> '9') And
     ( (fCfgSis('USNFCE', varBoolean)) Or fUsaSat ) Then
    strTipFre:='9';

  Try
    qryTblMovGer := fCriaQuery;

    Try
      qryTblMovGer.SQL.Text := 'SELECT * FROM MOVGER WHERE FALSE';

      strAutInc := fRetAutoIncrem('MOVGER', strCodEmp);

      With qryTblMovGer Do
      Begin
        Open;
        Insert;
        FieldByName('AUTOINCREM').AsString   := strAutInc;
        FieldByName('GER_NUMDOC').AsString   := strNumDoc;
        FieldByName('GER_SERIE_').AsString   := strSerie;
        FieldByName('GER_ESPDOC').AsString   := strEspDoc;
        FieldByName('GER_CODEMP').AsString   := strCodEmp;

        If fEmptyStr(strCodTra) Then
          FieldByName('GER_CODTRA').Value    := Null
        Else
          FieldByName('GER_CODTRA').AsString := strCodTra;

        If fEmptyStr(strCodVen) Then
          FieldByName('GER_CODVEN').Value    := strLoginUsuarioLogado
        Else
          FieldByName('GER_CODVEN').AsString := strCodVen;

        If fEmptyStr(strCodFor) Then
          FieldByName('GER_CODFOR').Value    := Null
        Else
          FieldByName('GER_CODFOR').AsString := strCodFor;

        If fEmptyStr(strCodCli) Then
          FieldByName('GER_CODCLI').Value    := Null
        Else
          FieldByName('GER_CODCLI').AsString := strCodCli;

        FieldByName('GER_TIP_FC').AsString   := strTip_Fc;

        If (dtaDtaEnt = 0) Then
          FieldByName('GER_DTAENT').Value      := Null
        Else
          FieldByName('GER_DTAENT').AsDateTime := dtaDtaEnt;

        If (tmrHorEnt = 0) Then
          FieldByName('GER_HORENT').Value      := Null
        Else
          FieldByName('GER_HORENT').AsDateTime := tmrHorEnt;

        If (dtaDtaDoc = 0) Then
          FieldByName('GER_DTADOC').Value      := Null
        Else
          FieldByName('GER_DTADOC').AsDateTime := dtaDtaDoc;

        If fEmptyStr(fTiraCaracEspeciais(strConPag)) Then
          FieldByName('GER_CONPAG').Value := Null
        Else
          FieldByName('GER_CONPAG').AsString := fTiraCaracEspeciais(strConPag);

        FieldByName('GER_ESTADO').AsString   := strEstado;

        If (fEmptyStr(strNomCon)) And (Not fClienteConsumidor(fRetNomCliente(strCodCli), True, True)) Then
        Begin
          FieldByName('GER_NOMCON').Value := Null;
          FieldByName('GER_ENDCON').Value := Null;
          FieldByName('GER_BAICON').Value := Null;
          FieldByName('GER_CEPCON').Value := Null;
          FieldByName('GER_CIDCON').Value := Null;
          FieldByName('GER_ESTCON').Value := Null;
          FieldByName('GER_TELCON').Value := Null;
          FieldByName('GER_CGCCPF').Value := Null;
          FieldByName('GER_CGCCON').Value := Null;
          FieldByName('GER_IESCON').Value := Null;
          FieldByName('GER_R_GCON').Value := Null;
          FieldByName('GER_EMLCON').Value := Null;
          dtaNasCon := 0;
        End
        Else
        Begin
          FieldByName('GER_NOMCON').AsString := strNomCon;
          FieldByName('GER_ENDCON').AsString := Trim(strEndCon);
          FieldByName('GER_BAICON').AsString := strBaiCon;
          FieldByName('GER_CEPCON').AsString := strCepCon;
          FieldByName('GER_CIDCON').Value    := IIF(fEmptyStr(strCidCon), Null, strCidCon);
          FieldByName('GER_ESTCON').AsString := strEstCon;
          FieldByName('GER_TELCON').AsString := strTelCon;
          FieldByName('GER_CGCCPF').AsString := strCgcCpf;
          FieldByName('GER_CGCCON').AsString := strCgcCon;
          If (strCgcCpf = '2') Then
          Begin
            FieldByName('GER_IESCON').AsString := '';
            FieldByName('GER_R_GCON').AsString := strCli_Rg;
          End
          Else
          Begin
            FieldByName('GER_IESCON').AsString := strIesCon;
            FieldByName('GER_R_GCON').AsString := '';
          End;
          FieldByName('GER_EMLCON').AsString := strEmlCon;
        End;

        If Assigned(objFazenda) And Not fEmptyStr(TDadosFazendaBase(objFazenda).strCodFaz) Then
        Begin
          FieldByName('GER_NOMCON').AsString := strNomCon;
          FieldByName('GER_ENDCON').AsString := TDadosFazendaBase(objFazenda).strNomFaz;
          FieldByName('GER_BAICON').AsString := TDadosFazendaBase(objFazenda).strBairro;
          FieldByName('GER_CEPCON').AsString := TDadosFazendaBase(objFazenda).strEndCep;
          FieldByName('GER_CIDCON').AsString := TDadosFazendaBase(objFazenda).strCodCid;
          FieldByName('GER_ESTCON').AsString := TDadosFazendaBase(objFazenda).strEstado;

          FieldByName('GER_CGCCPF').AsString := TDadosFazendaBase(objFazenda).intCgcCpf.ToString;
          FieldByName('GER_CGCCON').AsString := TDadosFazendaBase(objFazenda).strNuCnpj;
          FieldByName('GER_IESCON').AsString := TDadosFazendaBase(objFazenda).strNumIes;

          FieldByName('GER_R_GCON').AsString := '';
          FieldByName('GER_TELCON').AsString := strTelCon;//Dados do cliente
          FieldByName('GER_EMLCON').AsString := strEmlCon;//Dados do cliente
        End;

        FieldByName('GER_BASSIM').AsFloat    := fltBasSim;
        FieldByName('GER_BASIPI').AsFloat    := fltBasIpi;
        FieldByName('GER_ALQIPI').AsFloat    := fltAlqIpi;
        FieldByName('GER_TOTIPI').AsFloat    := fltTotIpi;
        FieldByName('GER_BASICM').AsFloat    := fltBasIcm;
        FieldByName('GER_ALQICM').AsFloat    := fltAlqIcm;
        FieldByName('GER_TOTICM').AsFloat    := fltTotIcm;
        FieldByName('GER_TOTRET').AsFloat    := fltTotRet;
        FieldByName('GER_RET_SP').AsFloat    := fltRet_SP;
        FieldByName('GER_ALQRET').AsFloat    := fltAlqRet;
        FieldByName('GER_BASRET').AsFloat    := fltBasRet;
        FieldByName('GER_DESESP').AsFloat    := fltDesEsp;
        FieldByName('GER_VLRCON').AsFloat    := fltVlrCon;
        FieldByName('GER_TOTPRO').AsFloat    := fltTotPro;
        FieldByName('GER_TOTCUS').AsFloat    := fltTotCus;
        FieldByName('GER_TOTMED').AsFloat    := fltTotMed;
        FieldByName('GER_TIPFRE').AsString   := strTipFre;
        FieldByName('GER_TOTFRE').AsFloat    := fltTotFre;
        FieldByName('GER_PESBRU').AsFloat    := fltPesBru;

        If fFormataFloat(fltPesLiq,2) <= 0 Then
          FieldByName('GER_PESLIQ').AsFloat  := fltPesBru
        Else
          FieldByName('GER_PESLIQ').AsFloat  := fltPesLiq;

        FieldByName('GER_VOLUME').AsFloat    := fltVolume;
        FieldByName('GER_ESPECI').AsString   := strEspeci;
        FieldByName('GER_MARCA_').AsString   := strMarca;
        FieldByName('GER_MEN001').AsString   := strMen001;
        FieldByName('GER_MEN002').AsString   := strMen002;
        FieldByName('GER_MEN003').AsString   := strMen003;
        FieldByName('GER_MEN004').AsString   := strMen004;
        FieldByName('GER_MEN005').AsString   := strMen005;

        if FieldByName('GER_JAFATU').DataType = ftInteger then
          FieldByName('GER_JAFATU').AsInteger := IIF(blnJafatu,1,0)
        Else
          FieldByName('GER_JAFATU').AsBoolean := blnJafatu;

        FieldByName('GER_TIPFAT').AsString   := strTipFat;
        FieldByName('GER_NUMFAT').AsString   := strNumFat;
        if fEmptyStr(strNumFat) Then
          strEmpFat := '';

        If fEmptyStr(strEmpFat) Then
          FieldByName('GER_EMPFAT').Value    := Null
        Else
          FieldByName('GER_EMPFAT').AsString := strEmpFat;

        If (dtaDtaFat = 0) Then
          FieldByName('GER_DTAFAT').Value      := Null
        Else
          FieldByName('GER_DTAFAT').AsDateTime := dtaDtaFat;

        If Not fEmptyStr(strVenFat) Then
          FieldByName('GER_VENFAT').AsString := strVenFat
        Else
          FieldByName('GER_VENFAT').Value := Null;

        FieldByName('GER_EMPORI').Value      := Null;
        FieldByName('GER_CNDFAT').AsString   := strCndFat;
        FieldByName('GER_VALFAT').AsFloat    := fltValFat;
        FieldByName('GER_VPAR01').AsFloat    := fltVPar01;
        FieldByName('GER_VPAR02').AsFloat    := fltVPar02;
        FieldByName('GER_VPAR03').AsFloat    := fltVPar03;
        FieldByName('GER_VPAR04').AsFloat    := fltVPar04;
        FieldByName('GER_VPAR05').AsFloat    := fltVPar05;
        FieldByName('GER_VPAR06').AsFloat    := fltVPar06;
        FieldByName('GER_VPAR07').AsFloat    := fltVPar07;
        FieldByName('GER_VPAR08').AsFloat    := fltVPar08;
        FieldByName('GER_VPAR09').AsFloat    := fltVPar09;
        FieldByName('GER_VPAR10').AsFloat    := fltVPar10;
        FieldByName('GER_VPAR11').AsFloat    := fltVPar11;
        FieldByName('GER_VPAR12').AsFloat    := fltVPar12;
        FieldByName('GER_NOTESP').AsString   := strNotEsp;
        FieldByName('GER_CLAFIS').AsString   := IIF(Pos(strEspDoc, 'PI_') > 0, '5999', strClaFis);
        FieldByName('GER_CLAFI2').AsString   := strClaFi2;
        FieldByName('GER_CLAFI3').AsString   := strClaFi3;
        FieldByName('GER_NATOPE').AsString   := strNatOpe;
        FieldByName('GER_PORDES').AsFloat    := fltPorDes;

        If (fEmptyStr(strCodDig)) Then
          FieldByName('GER_CODDIG').Value := Null
        Else
          FieldByName('GER_CODDIG').AsString   := strCodDig;

        If (fEmptyStr(strCodCnd)) Then
          FieldByName('GER_CODCND').Value := Null
        Else
          FieldByName('GER_CODCND').AsString   := strCodCnd;

        If (fEmptyStr(strCodFpg)) Then
          FieldByName('GER_CODFPG').Value := Null
        Else
          FieldByName('GER_CODFPG').AsString := strCodFpg;

        FieldByName('GER_FATNOT').AsFloat := fltFatNot;

        If (fEmptyStr(objServicos.strCodS01)) Then
          FieldByName('GER_CODS01').Value := Null
        Else
          FieldByName('GER_CODS01').AsString := objServicos.strCodS01;

        If (fEmptyStr(objServicos.strCodS02)) Then
          FieldByName('GER_CODS02').Value := Null
        Else
          FieldByName('GER_CODS02').AsString := objServicos.strCodS02;

        If (fEmptyStr(objServicos.strCodS03)) Then
          FieldByName('GER_CODS03').Value := Null
        Else
          FieldByName('GER_CODS03').AsString := objServicos.strCodS03;

        If (fEmptyStr(objServicos.strCodS04)) Then
          FieldByName('GER_CODS04').Value := Null
        Else
          FieldByName('GER_CODS04').AsString := objServicos.strCodS04;

        If (fEmptyStr(objServicos.strCodS05)) Then
          FieldByName('GER_CODS05').Value := Null
        Else
          FieldByName('GER_CODS05').AsString := objServicos.strCodS05;

        If (fEmptyStr(objServicos.strCodS06)) Then
          FieldByName('GER_CODS06').Value := Null
        Else
          FieldByName('GER_CODS06').AsString := objServicos.strCodS06;

        If (fEmptyStr(objServicos.strDesS01)) Then
          FieldByName('GER_DESS01').Value := Null
        Else
          FieldByName('GER_DESS01').AsString := objServicos.strDesS01;

        If (fEmptyStr(objServicos.strDesS02)) Then
          FieldByName('GER_DESS02').Value := Null
        Else
          FieldByName('GER_DESS02').AsString := objServicos.strDesS02;

        If (fEmptyStr(objServicos.strDesS03)) Then
          FieldByName('GER_DESS03').Value := Null
        Else
          FieldByName('GER_DESS03').AsString := objServicos.strDesS03;

        If (fEmptyStr(objServicos.strDesS04)) Then
          FieldByName('GER_DESS04').Value := Null
        Else
          FieldByName('GER_DESS04').AsString := objServicos.strDesS04;

        If (fEmptyStr(objServicos.strDesS05)) Then
          FieldByName('GER_DESS05').Value := Null
        Else
          FieldByName('GER_DESS05').AsString := objServicos.strDesS05;

        If (fEmptyStr(objServicos.strDesS06)) Then
          FieldByName('GER_DESS06').Value := Null
        Else
          FieldByName('GER_DESS06').AsString := objServicos.strDesS06;


        FieldByName('GER_VALS01').AsFloat   := objServicos.fltValS01;
        FieldByName('GER_VALS02').AsFloat   := objServicos.fltValS02;
        FieldByName('GER_VALS03').AsFloat   := objServicos.fltValS03;
        FieldByName('GER_VALS04').AsFloat   := objServicos.fltValS04;
        FieldByName('GER_VALS05').AsFloat   := objServicos.fltValS05;
        FieldByName('GER_VALS06').AsFloat   := objServicos.fltValS06;

        FieldByName('GER_PRAENT').AsInteger := objServicos.intPraEnt;
        FieldByName('GER_TOTSER').AsFloat   := objServicos.fltTotSer;
        FieldByName('GER_PERISS').AsFloat   := objServicos.fltPerIss;
        FieldByName('GER_VALISS').AsFloat   := objServicos.fltValIss;
        FieldByName('GER_NROCEI').AsString  := objServicos.strNroCEI;

        FieldByName('GER_DESACE').AsFloat   := fltDesAce;

        FieldByName('GER_ORIDOC').AsString := strOriDoc;

        If (Not fEmptyStr(strOrdPro)) Then
          FieldByName('GER_ORDPRO').AsString := strOrdPro
        Else
          FieldByName('GER_ORDPRO').Value := Null;

        FieldByName('GER_CONENT').AsString  := strConEnt;

        If FieldByName('GER_IMPRES').DataType = ftInteger Then
          FieldByName('GER_IMPRES').AsInteger := IIF(fCfgSis('USNFCE', varBoolean) Or fUsaSat Or blnImpPdv, 1, 0)
        Else
          FieldByName('GER_IMPRES').AsBoolean := IIF(fCfgSis('USNFCE', varBoolean) Or fUsaSat Or blnImpPdv, True, False);

        If (fEmptyStr(strCodRep)) Then
          FieldByName('GER_CODREP').Value := Null
        Else
          FieldByName('GER_CODREP').AsString := strCodRep;

        FieldByName('GER_VALROM').AsFloat   := 0.0;

        //************************************************//
        // ESSES CAMPOS REFERENTES A RETENÇÃO DE ALIQUOTA //
        //*********************************************MV*//
        FieldByName('GER_ALQIRF').AsFloat  := fltAlqIrf;
        FieldByName('GER_VALIRF').AsFloat  := fltValIrf;
        FieldByName('GER_ALQPIS').AsFloat  := fltAlqPis;
        FieldByName('GER_VALPIS').AsFloat  := fltValPis;
        FieldByName('GER_ALQCOF').AsFloat  := fltAlqCof;
        FieldByName('GER_VALCOF').AsFloat  := fltValCof;
        FieldByName('GER_ALQCSL').AsFloat  := fltAlqCsl;
        FieldByName('GER_VALCSL').AsFloat  := fltValCsL;

        FieldByName('GER_IRFRET').AsFloat  := fltIrfRet;
        FieldByName('GER_PISRET').AsFloat  := fltPisRet;
        FieldByName('GER_COFRET').AsFloat  := fltCofRet;
        FieldByName('GER_CSLRET').AsFloat  := fltCslRet;
        FieldByName('GER_NOTRET').AsString := strNotRet;

        FieldByName('GER_ALIRFP').AsFloat  := fltAlIrfP;
        FieldByName('GER_ALPISP').AsFloat  := fltAlPisP;
        FieldByName('GER_ALCOFP').AsFloat  := fltAlCofP;
        FieldByName('GER_ALCSLP').AsFloat  := fltAlCslP;

        FieldByName('GER_SERRET').AsFloat  := fltSerRet;
        FieldByName('GER_NORESE').AsString := strNoReSe;

        FieldByName('GER_PESGSO').AsFloat  := fltPeSgSo;
        FieldByName('GER_VLSGSO').AsFloat  := fltVlSgSo;

        FieldByName('GER_IRPRRT').AsFloat  := fltIrPrRt;
        FieldByName('GER_IRPRDV').AsFloat  := fltIrPrDv;
        FieldByName('GER_IRSERT').AsFloat  := fltIrSeRt;
        FieldByName('GER_IRSEDV').AsFloat  := fltIrSeDv;
        FieldByName('GER_PIPRRT').AsFloat  := fltPiPrRt;
        FieldByName('GER_PIPRDV').AsFloat  := fltPiPrDv;
        FieldByName('GER_PISERT').AsFloat  := fltPiSeRt;
        FieldByName('GER_PISEDV').AsFloat  := fltPiSeDv;
        FieldByName('GER_COPRRT').AsFloat  := fltCoPrRt;
        FieldByName('GER_COPRDV').AsFloat  := fltCoPrDv;
        FieldByName('GER_COSERT').AsFloat  := fltCoSeRt;
        FieldByName('GER_COSEDV').AsFloat  := fltCoSeDv;
        FieldByName('GER_CSPRRT').AsFloat  := fltCsPrRt;
        FieldByName('GER_CSPRDV').AsFloat  := fltCsPrDv;
        FieldByName('GER_CSSERT').AsFloat  := fltCsSeRt;
        FieldByName('GER_CSSEDV').AsFloat  := fltCsSeDv;

        FieldByName('GER_BASORG').AsFloat  := fltBasOrg;
        FieldByName('GER_ICMORG').AsFloat  := fltIcmOrg;

        If (intNConhe = -1) Then
          FieldByName('GER_NCONHE').Value := Null
        Else
          FieldByName('GER_NCONHE').AsInteger:= intNConhe;

        FieldByName('GER_CONSUM').AsString   := strConsum;
        FieldByName('GER_ENTFAT').AsString   := strEntFat;

        If (fEmptyStr(strCliFat)) Then
          FieldByName('GER_CLIFAT').Value := Null
        Else
          FieldByName('GER_CLIFAT').AsString := strCliFat;

        FieldByName('GER_OPEEXP').AsString   := strOpeExp;
        If fEmptyStr(strOpeExp) Then
          FieldByName('GER_OPEEXP').Clear;

        FieldByName('GER_SEPEXP').AsString   := strSepExp;
        If fEmptyStr(strSepExp) Then
          FieldByName('GER_SEPEXP').Clear;

        FieldByName('GER_TABPRE').AsString   := strTabPre;

        FieldByName('GER_NUM_PR').AsString   := strNum_Pr;

        If Pos(strEntFut,'SN') <= 0 Then
          strEntFut := 'N';

        FieldByName('GER_ENTFUT').AsString   := strEntFut;

        blnLiberado := ((Copy(strConPag, 3, 3) <> '000') And (fStatusCndPag(strConPag) = A_PRAZO)) Or
                       (fClienteFilial(strCodCli)) Or
                       ((strOpcDoc = '11') And (fStatusCndPag(strConPag) = A_VISTA) And (strCodFpg= '015'));

        If (fCfgSis('CXAEXP') = '1') And
           (blnBaiFut Or (strEspDoc = 'UC') Or (VS_strTipExp = '3') Or blnLiberado) Then
        Begin
          FieldByName('GER_OPLBRC').AsString   := strLoginUsuarioLogado;
          FieldByName('GER_DTLBRC').AsDateTime := VS_Date;
          FieldByName('GER_HRLBRC').AsDateTime := fTime();
        End;

        FieldByName('GER_MARGEM').AsFloat := fltMargem;

        FieldByName('GER_BARTSP').AsFloat := fltBaRtSp;
        FieldByName('GER_VLRTSP').AsFloat := fltVlRtSp;

        FieldByName('GER_OPRFLJ').AsString := strOprFlj;

        FieldByName('GER_DTALAN').AsDateTime := VS_Date;

        FieldByName('GER_NUMREG').AsString  := strNumReg;
        FieldByName('GER_DTENTR').AsDateTime := dtaDtEntr;

        FieldByName('GER_CLAFI4').AsString := strClaFi4;

        FieldByName('GER_AUTSER').AsString := strAutSer;

        FieldByName('GER_MENEXP').AsString := strMenExp;
        FieldByName('GER_MENEX2').AsString := strMenEx2;
        FieldByName('GER_MENEX3').AsString := strMenEx3;
        FieldByName('GER_MENEX4').AsString := strMenEx4;

        If fEmptyStr(strCodEve) Then
          FieldByName('GER_CODEVE').Value := Null
        Else
          FieldByName('GER_CODEVE').AsString := strCodEve;

        If fEmptyStr(strCodOco) Then
          FieldByName('GER_CODOCO').Value    := Null
        Else
          FieldByName('GER_CODOCO').AsString := strCodOco;


        if blnFulfillmentModoRobo then
        begin
          FieldByName('GER_DTLBEX').AsDateTime := dtaDtaEnt;
          FieldByName('GER_HRLBEX').AsDateTime := tmrHorEnt;
        end
        else
        if not blnDTEXREP then
        begin
          If (dtadtlBex > 0) Then
          Begin
            FieldByName('GER_DTLBEX').AsDateTime := dtadtlBex;
            FieldByName('GER_OPLBEX').AsString := strLoginUsuarioLogado;
          End;

          FieldByName('GER_HRLBEX').AsDateTime := fNow - Trunc(fNow);
          {***************************************************************}
          {* Não deve gravar o documento de venda como expedido, pois    *}
          {* na Imperio das Tintas eles trabalham com diferentes tipos   *}
          {* de VS_strTipExp conforme configurado no arquivo de opcoes   *}
          {* locais (por maquina).                                       *}
          {* Em caso de Duvida falar com Ronaldo ou Joao catarino        *}
          {*********************************************************RO,JC*}
          {If (VS_strTipExp = '3') Or (VS_strTipExp = '1') Then
            FieldByName('GER_DTLBEX').AsDateTime := VS_Date;}
        End Else Begin
          FieldByName('GER_DTLBEX').Clear();
          FieldByName('GER_HRLBEX').Clear();
        End;

        If (intNroBox > 0) Then
          FieldByName('GER_NROBOX').AsInteger := intNroBox
        Else
          FieldByName('GER_NROBOX').Value := Null;

        Post;

        If FieldByName('GER_CONPAG').AsString = '00' Then
        Begin
          fRollBack;

          Raise Exception.Create(FieldByName('GER_NUMDOC').AsString+'-'+FieldByName('GER_ESPDOC').AsString+
                                 ' com valor das parcelas inconsistentes. Se possível feche o autcom '+
                                 ' e repita essa operação. Se o problema persistir entre em contato com a Citel!');
        End;

        if fEmptyStr(strNatCfo) then
          strNatCfo := fCampoTabela('AUTOINCREM', 'NATCFO', ['NAT_CODCFO', 'NAT_DESCRI'], [qryTblMovGer.FieldByName('GER_CLAFIS').AsString, qryTblMovGer.FieldByName('GER_NATOPE').AsString]);

        strTem_ST := IIF(fltTotRet > 0, 'S', 'N');
        strTipAbf := '';
        If strTip_Fc = 'F' then
          strTipAbf := Copy(fRetDesTipoAbf('F', strCodFor), 1, 3);

        pIncluiAuxMov('MOVGER',
                      strAutInc,
                      strAutEnt,
                      strDocCon,
                      fltValCre,
                      dtaNasCon,
                      strCodObr,
                      strCodArt,
                      strPermut,
                      strRetIss,
                      strOpcDoc,
                      fltFreSug,
                      strNumAde,
                      fltBasAnt,
                      fltValAnt,
                      strNaoAtu,
                      strEntUrg,
                      fltDupRec,
                      fltValAdt,
                      strNumGui,
                      objServicos,
                      fltDeDVCf,
                      strPlaVei,
                      strKm_Vei,
                      strCliOri,
                      strCodMot,
                      strBetone,
                      strLacre_,
                      strTipMps,
                      strAbatim,
                      strBrita_,
                      strConBom,
                      intFckDia,
                      fltImpPag,
                      intPrzMed,
                      strChvNfeDev,
                      strOpeSol,
                      blnEst_Dv,
                      strNumCOODev,
                      strNumSerDev,
                      strNumUSUDev,
                      strTipDocDev,
                      fltTotDif,
                      strFasObr,
                      objFazenda,
                      fltFedImp,
                      fltEstImp,
                      fltMunImp,
                      fltTroco_,
                      strVenPre,
                      strSeqDocOri,
                      blnConEqu,
                      blnDescIncond,
                      blnGraCTP,
                      strNumera,
                      strEdiPes,
                      fltTaxEnt,
                      fltVrdIcm,
                      fltBasVrd,
                      strCodEmbarcacao,
                      fltTotBri,
                      blnDevEsp,
                      strTraRdp,
                      strCliCtt,
                      strCodMod,
                      strNumGui,
                      strHisCom,
                      strCodPrj,
                      strNatCfo,
                      strTpOper,
                      strCupDes,
                      strNotPau,
                      fltCotMoe,
                      fltFreMkp,
                      fltComMkp,
                      strPlaFat,
                      blnDevWms,
                      fltFreCot,
                      fltFreRat,
                      strEntSim,
                      strSeqDmp,
                      strEntFutOpc,
                      fltTotIpiEntFut,
                      fltTotRetEntFut,
                      fltTotFcpSTEntFut,
                      fltICMDes,
                      fltDesPis,
                      strOpFaEx,
                      strDocAba,
                      strEspAba,
                      strEmpAba,
                      strCliAba,
                      strTem_ST,
                      blnColeta,
                      strNumeroRandomico,
                      strNumeroDrawback,
                      strCodFinalidadeAjuste,
                      strDoc_RE,
                      strEsp_RE,
                      strEmp_RE,
                      strCli_RE,
                      strDocRE2,
                      strEspRE2,
                      strEmpRE2,
                      strCliRE2,
                      strEmp_TE,
                      strAutIcv,
                      strEspDoc,
                      strEmp_PR,
                      strCliCEO,
                      fltVolSepExc,
                      fltVolSepNExc,
                      strSupGer,
                      strSupReg,
                      strCelCon,
                      strAbaDep,
                      strEmpDep,
                      strAbf_Uf,
                      strEstornoNotaFiscal,
                      strCodTpA,
                      strMatRev,
                      strTipAbf,
                      strVchCdp,
                      strCodCno,
                      fltTotIbs,
                      fltTotCbs,
                      fltTotIs,
                      fltTotProIs,
                      fltTotNf,
                      strInsImo,
                      strCodCib
                      );

        If Not fEmptyStr(objServicos.strCodS01) Then
        Begin
          pIncluiSerMov('MOVGER', strAutInc, objServicos.recServicos);

          For intServico := 1 To 30 Do
          Begin
            pGravaMecanicosServico('MOVGER', strAutInc, fStrZero(intServico.ToString, 2),
                                                        GetPropValue(objServicos, 'strCodS' + fStrZero(intServico.ToString, 2)),
                                                        GetPropValue(objServicos, 'fltValS' + fStrZero(intServico.ToString, 2)),
                                                        GetPropValue(objServicos, 'strMecS' + fStrZero(intServico.ToString, 2)),
                                                fQtdSer(GetPropValue(objServicos, 'fltQtdS' + fStrZero(intServico.ToString, 2))));

            pGravaObservacaoServico('MOVGER', strAutInc, fStrZero(intServico.ToString, 2),
                                                         GetPropValue(objServicos, 'strObsS' + fStrZero(intServico.ToString, 2)));
          End;

        End;

        If Assigned(objFinanc) Then
          TFinanceira(objFinanc).fGravaFinanciamento('MOVGER', strAutInc);
      End;

      RegistroContabilidade.strClafis := IIF(Pos(strEspDoc, 'PI_') > 0, '5999', strClaFis);
      RegistroContabilidade.strEspDoc := strEspDoc;
      RegistroContabilidade.ttpTabela := ttMovger;
      RegistroContabilidade.strSeqGer := strAutInc;
      RegistroContabilidade.mlModLan :=  mlInclusao;
      RegistroContabilidade.strEmpLan := strCodEmp;
      RegistroContabilidade.strEmpLan := strCodEmp;
      pGravaRegistroContabilidade(RegistroContabilidade);

      qryTblMovObs := fCriaQuery;

      qryTblMovObs.SQL.Add('SELECT * FROM MOVOBS WHERE FALSE');
      qryTblMovObs.Open;
      qryTblMovObs.Append;
      qryTblMovObs.FieldByName('MOV_SEQGER').AsString  := strAutInc;

      {**************************************************************************}
      {* O CAMPO "MOV_OBSERV" É ATUALIZADO NO ENVIO/RE-ENVIO DA NFE, POR ISSO   *}
      {* SE FAZ NECESSÁRIO PRESERVAR SEU VALOR EM OUTRO CAMPO, CASO A NOTA      *}
      {* FIQUE COM ERRO E SEJA REENVIADA O SEU VALOR SERÁ ATUALIZADO!           *}
      {**************************************************************************}
      {* FIZ UMA NF COM O PAINEL FECHADO, AO FINALIZAR A GRAVAÇÃO ABRI O PAINEL,*}
      {* ALTEREI O STATUS E RE-ENVIEI, O VALOR DE "MOV_OBSERV" DOBROU           *}
      {***********************************************************************RN*}
      qryTblMovObs.FieldByName('MOV_OBSERV').AsString  := strObsNfe;
      qryTblMovObs.FieldByName('MOV_CNFNFE').AsString  := strObsNfe;

      qryTblMovObs.FieldByName('MOV_OBSFIS').AsString  := strObsNfeFis;
      qryTblMovObs.FieldByName('MOV_CNFFIS').AsString  := strObsNfeFis;

      qryTblMovObs.FieldByName('MOV_IPDPNF').AsInteger := IIF(blnIpDpNf, 1, 0);

      If (dtaDtESNf > 0) And blnSolDtaEntSaiNfe Then
      Begin
        qryTblMovObs.FieldByName('MOV_DTESNF').AsDateTime := dtaDtESNf;
        qryTblMovObs.FieldByName('MOV_HRESNF').AsDateTime := tmrHrESNf;
      End;

      qryTblMovObs.FieldByName('MOV_DISSER').AsString := objServicos.strDisSer;
      qryTblMovObs.Post;

      FreeAndNil(qryTblMovObs);

      fGravaGERCND(strAutInc, arrDuplic );

    Except
      On E: Exception Do
      Begin
        Result := False;
        qryTblMovGer.Cancel;
        pMensagensErro(E.Message, '[fGravaMovGer]');
      End;
    End;

    strSQLMovGer := qryTblMovGer.SQL.Text;

  Finally
    FreeAndNil(objServicos);
    FreeAndNil(qryTblMovGer);
  End;

End;

{*****************************************}
{* =============> ATENÇÃO <============= *}
{* AO CRIAR UM PARAMETRO NESSA FUNÇÃO,   *}
{* RECOMPILAR O AUTCOMTINTA              *}
{**************************************MV*}
{Req. 456948-B - B10b. Abre os tres moldes uma vez. A partir daqui e ate o
 pFechaMoldesMovDet, fGravaMovDet reaproveita em vez de criar e abrir um
 dataset por linha - eram 3 round-trips por linha, 42.000 numa rodada de
 14.000 linhas.}
procedure pAbreMoldesMovDet;
begin
  pFechaMoldesMovDet;   {sobra de uma rodada que caiu no meio}

  objMoldeMovDet := fCriaQuery;
  objMoldeMovDet.SQL.Text := 'SELECT * FROM MOVDET WHERE FALSE';
  objMoldeMovDet.Open;

  objMoldeMovTri := fCriaQuery;
  objMoldeMovTri.SQL.Text := 'SELECT * FROM MOVTRI WHERE FALSE';
  objMoldeMovTri.Open;

  objMoldeMovAux := fCriaQuery;
  objMoldeMovAux.SQL.Text := 'SELECT * FROM MOVAUX WHERE FALSE';
  objMoldeMovAux.Open;
end;

{Req. 456948-B - B10b. Fecha e volta ao comportamento normal. Tem que rodar em
 todos os caminhos de saida do chamador, Except incluido: molde aberto depois
 da rotina terminar seria estado global vazando para o resto do ERP.}
procedure pFechaMoldesMovDet;
begin
  If Assigned(objMoldeMovDet) Then
  Begin
    If objMoldeMovDet.State In [dsInsert, dsEdit] Then
      objMoldeMovDet.Cancel;
    FreeAndNil(objMoldeMovDet);
  End;

  If Assigned(objMoldeMovTri) Then
  Begin
    If objMoldeMovTri.State In [dsInsert, dsEdit] Then
      objMoldeMovTri.Cancel;
    FreeAndNil(objMoldeMovTri);
  End;

  If Assigned(objMoldeMovAux) Then
  Begin
    If objMoldeMovAux.State In [dsInsert, dsEdit] Then
      objMoldeMovAux.Cancel;
    FreeAndNil(objMoldeMovAux);
  End;
end;

function fGravaMovDet(Var strAutInc: String;
                      strSeqGer: String;
                      strNumDoc,
                      strEspDoc,
                      strCodEmp,
                      strCodIte,
                      strCodVen,
                      strCodDiv,
                      strCodMar,
                      strCodFor,
                      strCodCli: String;
                      dtaDtaEnt,
                      dtaHorEnt,
                      dtaDtaDoc: TDateTime;
                      strConPag,
                      strTip_Fc,
                      strEstado,
                      strDescri,
                      strRefere,
                      strUnidad,
                      strForIte: String;
                      fltQtdIte,
                      fltUnitar,
                      fltUniOri,
                      fltUniVis,
                      fltTotIte,
                      fltVlrCon,
                      fltTotCus,
                      fltTotMed,
                      fltDesCon,
                      fltTotFre,
                      fltDesEsp: Double;
                      strCodRep,
                      strCodVe2: String;
                      fltPerCom,
                      fltTotCom,
                      fltTotCo2: Double;
                      strClaFis,
                      strCodFis: String;
                      fltValIpi,
                      fltAlqIpi,
                      fltBasIpi,
                      fltValIcm,
                      fltAlqIcm,
                      fltBasIcm,
                      fltValRet,
                      fltAlqRet,
                      fltBasRet,
                      fltTotPes,
                      fltPerBas,
                      fltPerRed: Double;
                      blnJafatu: Boolean;
                      strTipFat,
                      strNumFat,
                      strEmpFat: String;
                      dtaDtaFat: TDateTime;
                      strVenFat,
                      strCndFat: String;
                      fltValFat: Double;
                      strIdePro,
                      strIncPis,
                      strSerie: String;
                      fltDesAce: Double;
                      strNotEsp,
                      strDocDev,
                      strEspDev,
                      strEmpDev,
                      strIteCha,
                      strIteTin,
                      strDesCor,
                      strTipEmb: String;
                      fltQtdEmb,
                      fltPreEmb: Double;
                      strTipPre: String;
                      fltPrvTin,
                      fltPrcTin,
                      fltFatTin: Double;
                      strProEmb,
                      strCodDig,
                      strCodCnd,
                      strCodFpg,
                      strIteEmb,
                      strGruEmb: String;
                      intLazQua: Integer;
                      strPromoc,
                      strSeqTin: String;
                      fltQtdPul: Double;
                      strPedCom,
                      strOriDoc,
                      strNum_Pd,
                      strEsp_Pd,
                      strEmp_Pd: String;
                      intInd_Pd: Integer;
                      strOrdPro,
                      strDesNes,
                      strCliFat: String;
                      fltBcaMin,
                      fltBcaCom,
                      fltVolPro: Double;
                      strCodAca,
                      strEmpAca: String;
                      blnProAca,
                      blnFilKar: Boolean;
                      strEspFut,
                      strDocFut,
                      strEmpFut,
                      strTabPre,
                      strEmpCom: String;
                      strLinha: String;
                      strCatali: String;
                      strCodDil: String;
                      fltPorDil: Double;
                      strDilCon: String;
                      fltPorCat: Double;
                      fltUniDig: Double;
                      fltQtdPon: Double;
                      strEntFut,
                      strMotFut: String;
                      dtaDtaFut: TDateTime;
                      fltTotCu2: Double;
                      fltComRep,
                      fltPerRep: Double;
                      strKey_EP,
                      strNumLot,
                      strPigBas: String;
                      fltVaEIpi,
                      fltAlEIpi,
                      fltBaEIpi,
                      fltTotUlt,
                      fltImpUlt,
                      fltBaRtSP,
                      fltVaRtSP,
                      fltIcOpPr: Double;
                      intSeqCcr: Integer;
                      fltEmbala,
                      fltAlqPis,
                      fltBasPis,
                      fltValPis: Double;
                      strCSTPis: String;
                      fltAlqCof,
                      fltBasCof,
                      fltValCof: Double;
                      strCSTCof,
                      strCSTIpi,
                      strEnqIpi: String;
                      fltVaERet,
                      fltAlERet,
                      fltBaERet: Double;
                      fltPesLiq: Double;
                      fltUniTab: Double = 0;
                      strLot_TA: String = '';
                      fltConFre: Double = 0;
                      fltBasAnt: Double = 0;
                      fltIcmAnt: Double = 0;
                      fltVendor: Double = 0;
                      fltOutDes: Double = 0;
                      fltVlGnre: Double = 0;
                      strGnrOri: String = 'P';
                      fltOutIcm: Double = 0;
                      fltIseIcm: Double = 0;
                      fltFreSug: Double = 0;
                      strCodMot: String = '';
                      strNatPis: String = '';
                      strNatCof: string = '';
                      strSeqGad: string = '';
                      fltOutVal: Double = 0;
                      fltIcmSai: Double = 0;
                      fltImpFed: Double = 0;
                      fltDesOpe: Double = 0;
                      fltQtdExp: Double = 0;
                      strNumCmp: String = '';
                      intNItCmp: Integer = 0;
                      fltDeDVCf: Double = 0;
                      strCodMec: String = '';
                      strAntPro: String = 'N';
                      strAntFre: String = 'N';
                      fltMedAnt: Double = 0;
                      fltPreAnt: Double = 0;
                      fltImpAnt: Double = 0;
                      strSeqAnt: String = '';
                      strRICMPR: String = 'N';
                      fltComLiq: Double = 0;
                      strNcmTin: String = '';
                      fltValIva: Double = 0;
                      strCliBus: String = 'N';
                      strTurEnt: String = '';
                      strIdeDev: String = 'NOR';
                      fltPeBaST: Double = 0;
                      fltVal_RT: Double = 0;
                      fltDesCli: Double = 0;
                      fltImpPag: Double = 0;
                      fltTaxJur: Double = 0;
                      fltSerRat: Double = 0;
                      strProBri: String = '';
                      fltPonBri: Double = 0;
                      fltValDif: Double = 0;
                      fltVaFrAn: Double = 0;
                      strLotAba: String = '';
                      fltFedImp: Double = 0;
                      fltEstImp: Double = 0;
                      fltMunImp: Double = 0;
                      strIncDev: String = '';
                      strBrinde: String = 'N';
                      strCodPar: String = '';
                      strTipBri: String = '';
                      fltIcmOrg: Double = 0;
                      strBaqtze: String = '';
                      strIncFut: String = '';
                      fltValFle: Double = 0;
                      fltTaxEnt: Double = 0;
                      fltVrdIcm: Double = 0;
                      fltBasVrd: Double = 0;
                      strMtdIcm: String = '';
                      strBxSbIt: String = 'N';
                      strIteAbf: String = '';
                      strAtivac: String = 'N';
                      intSeqCom: integer = 0;
                      fltVICMDe: Double = 0;
                      strNcmIte: String = '';
                      fltComDig: Double = 0;
                      fltPerDig: Double = 0;
                      fltIcmPav: Double = 0;
                      blnIcmSai: Boolean = False;
                      fltAlDifa: Double = 0;
                      strAutSai: String = '';
                      fltBFCPST: Double = 0;
                      fltPFCPST: Double = 0;
                      fltVFCPST: Double = 0;
                      strDadSep: String = '';
                      strAutEle: String = '';
                      strNotUlt: String = '';
                      fltPICMEF: Double = 0;
                      fltBICMEF: Double = 0;
                      fltAICMEF: Double = 0;
                      fltVICMEF: Double = 0;
                      fltBSTANT: Double = 0;
                      fltVSTANT: Double = 0;
                      strNotC17: String = '';
                      fltAlq922: Double = 0;
                      fltDesCnd: Double = 0;
                      strProEsp: String = '';
                      strCodPro: String = '';
                      strInc_Pd: String = '';
                      fltSICMEF: Double = 0;
                      fltValTCI: Double = 0;
                      fltCalTCI: Double = 0;
                      fltVal_TS: Double = 0;
                      strExtFul: String = '';
                      strCodExt: String = '';
                      fltFreMkp: Double = 0;
                      fltComMkp: Double = 0;
                      strAIdKitPromocao : String = '';
                      strChaveAcesso: String = '';
                      fltQtdCom: Double = 0;
                      fltFreCot: Double = 0;
                      AstrComplemento : String = '';
                      strEmpCar: String = '';
                      strAutoinDevCar: String = '';
                      AfltBaseOperacaoPropriaICMSEntrada : Double = 0;
                      AfltAliquotaOperacaoPropriaICMSEntrada : Double = 0;
                      AfltValorOperacaoPropriaIMCSEntrada : Double = 0;
                      fltFreRat: Double = 0;
                      fltValIpiEntFut: Double = 0;
                      fltValRetEntFut: Double = 0;
                      fltValFcpSTEntFut: Double = 0;
                      fltDesPis: Double = 0;
                      blnClaRet: Boolean = False;
                      strOpSeEx: String = '';
                      strConExp: String = '';
                      strEmbExp: String = '';
                      strObsExp: String = '';
                      blnAtoDeclaratorioDF: Boolean = False;
                      strMovTriLocFis: String = '';
                      fltVDesST: Double = 0;
                      strMDesST: String = '';
                      strNumDrw: String = '';
                      strTipBus: String = '';
                      strNumPla: String = '';
                      strParNum: String = '';
                      strReqCom: String = '';
                      strNatOpe: String = '';
                      fltRpaFre: Double = 0;
                      fltPerRic: Double = 0;
                      blnAltEst: Boolean = False;
                      intSeqPer: Integer = 0;
                      intDetItem: Integer = 0;
                      fltICMCFR: Double = 0;
                      fltFreteCalc: Double = 0;
                      fltFreConCalc: Double = 0;
                      strPegou_ : String = 'N';
                      fltVFCPOP: Double = 0;
                      fltVFCPDF: Double = 0;
                      fltCubage: Double = 0;
                      fltCfbIpi: Double = 0;
                      fltCfaIpi: Double = 0;
                      fltCfvIpi: Double = 0;
                      strCipiOK: String = 'N';
                      strDocIpi: String = '';
                      strEspIpi: String = '';
                      strEmpIpi: String = '';
                      intRemFil: Integer = 0;
                      fltQtdRemFil: Double = 0;
                      blnFulfillmentModoRobo: Boolean = False;
                      blnFilFul: Boolean = True;
                      blnBaiDev: Boolean = False;
                      strAutEnt: String = '';
                      dtaDtaCmp: TDateTime = 0;
                      strFullHubMkp: String = '';
                      fltOutValPD: Double = 0;
                      strFilFul_EntSai: String = '';
                      strIncOri: String = '';
                      strTckQbt: String = '';
                      strEntTri: String = 'N';
                      strFulDif: String = '';
                      strClaFat: String = '';
                      fltICMNCR: Double = 0;
                      fltFCPNCR: Double = 0;
                      strColoranteDeEntregaFutura : String = 'N';
                      strCbenef: string = '';
                      strCodPre: string = '';
                      fltBasPre: Double = 0;
                      fltPerPre: Double = 0;
                      fltValPre: Double = 0;
                      strCodCmg: string = '';
                      fltVimRet: Double = 0;
                      dobQIcmsMonRet: Double = 0;
                      dobAdBcMonRet: Double = 0;
                      dobVrEmIcmsRet: Double = 0;
                      fltValSeg: Double = 0;
                      fltPerDif: Double = 0;
                      fltAlqSTXML: Double = 0;
                      fltCliDes: Double = 0;
                      strRefCodCst: String = '';
                      strRefClaTri: String = '';
                      fltRefValOpe: Double = 0;
                      fltRefBasCal: Double = 0;
                      fltRefCbsAlq: Double = 0;
                      fltRefCbsAlD: Double = 0;
                      fltRefCbsVlD: Double = 0;
                      fltRefCbsAlR: Double = 0;
                      fltRefCbsVlT: Double = 0;
                      fltRefCbsAlE: Double = 0;
                      fltRefCbsVal: Double = 0;
                      fltRefIbsUfA: Double = 0;
                      fltRefIbsUfD: Double = 0;
                      fltRefIbsUvD: Double = 0;
                      fltRefIbsUfR: Double = 0;
                      fltRefIbsUfT: Double = 0;
                      fltRefIbsUfE: Double = 0;
                      fltRefIbsUfV: Double = 0;
                      fltRefIbsMnA: Double = 0;
                      fltRefIbsMnD: Double = 0;
                      fltRefIbsMvD: Double = 0;
                      fltRefIbsMnR: Double = 0;
                      fltRefIbsMnT: Double = 0;
                      fltRefIbsMnE: Double = 0;
                      fltRefIbsMnV: Double = 0;
                      strRefSelCst: String = '';
                      strRefSelCla: String = '';
                      fltRefSelBas: Double = 0;
                      fltRefSelAlq: Double = 0;
                      fltRefSelVal: Double = 0;
                      strRefTriReg: String = 'N';
                      strRefCrePre: String = 'N';
                      strRefMonoFa: String = 'N';
                      fltRefValIbs: Double = 0;
                      strRefCesBas: String = '';
                      strRefCstReg: String = '';
                      strRefClaReg: String = '';
                      fltRefAiuReg: Double = 0;
                      fltRefTiuReg: Double = 0;
                      fltRefAimReg: Double = 0;
                      fltRefTimReg: Double = 0;
                      fltRefCbsReg: Double = 0;
                      fltRefTcbReg: Double = 0;
                      fltIcmPrd: Double = 0;
                      fltSiscomex: Double = 0;
                      strChvRef: String = '';
                      strIteRef: String = '';
                      ABatch: Pointer = Nil; {Req. 456948}
                      fltBimRet: Double = 0;
                      fltAimRet: Double = 0;
                      blnRefEspelhaDocumento: Boolean = False): Boolean;
var
  qryTblMovDet: TUniQuery;
  qryTblMovRef: TUniQuery;   {Req. 456948 - era query anonima}
  qryTblMovTri: TUniQuery;
  qryTblBriDet: TUniQuery;
  qryTblMovAux: TUniQuery;

  strPesEsp,
  strCodCor,
  strFormula,
  strCodIteGra: String;

  strDadSepOpe: String;
  fltDadSepQtd: Double;

  LEntregaFutura: Boolean;
  LEmpresa: String;
  LEmpresas: TArray<String>;

  blnSomaTotFreDesAce : Boolean;
  blnPedidoOrigemSite : Boolean;

  objPromocaoLimitePorClienteOuVenda : TPromocaoLimitePorClienteOuVenda;

  LQtdRemessaFulfillment : Double;

  function fRetornaInc_PD: String;
  Begin
    Result := '';
    If (Not fEmptyStr(strNum_Pd)) And (Length(strInc_Pd) = 20) Then
      Result := strInc_Pd
    Else If (Length(strInc_Pd) > 20) And (Pos(CNS_TAG_FAT_DUP, strInc_Pd) > 0) Then
      Result := Copy(strInc_Pd, 1, 20);
  End;

  function fRetornaEmpresaOrigemDevolucaoPor_PR: String;
  var
    qryAuxiliar: TUniQuery;

    function fRetornaSQL(strPrefix: String):String;
    begin
      Result := 'SELECT '
              + '       T.DET_EMPORI '
              + '  FROM ' + strPrefix + 'DET D '
              + ' INNER JOIN ' + strPrefix + 'TRI T ON D.AUTOINCREM = T.DET_SEQGER '
              + ' INNER JOIN EXTDOR B ON B.FDO_INCDEV = D.AUTOINCREM '
              + ' INNER JOIN FATDOR F ON F.AUTOINCREM = B.FDO_SEQFDO '
              + ' WHERE D.DET_NUMDOC = :NUMDOC '
              + '   AND D.DET_ESPDOC = :ESPDOC '
              + '   AND D.DET_CODEMP = :CODEMP '
              + '   AND D.AUTOINCREM = :INCDET '
              + '   AND F.FDO_ESPDOC = "PR" ';
    end;

    function fTrocaSQL(strSQL: String):Boolean;
    begin
      qryAuxiliar.Close;
      qryAuxiliar.SQL.Clear;
      qryAuxiliar.SQL.Add(strSQL);

      qryAuxiliar.ParamByName('NUMDOC').AsString := strDocDev;
      qryAuxiliar.ParamByName('ESPDOC').AsString := strEspDev;
      qryAuxiliar.ParamByName('CODEMP').AsString := strEmpDev;
      qryAuxiliar.ParamByName('INCDET').AsString := strIncDev;

      qryAuxiliar.Open;

      Result := (Not qryAuxiliar.IsEmpty);
    end;

  begin
    Result := '';

    qryAuxiliar := fCriaQuery();
    Try
      If fTrocaSQL(fRetornaSQL('MOV')) Then
        Result := qryAuxiliar.FieldByName('DET_EMPORI').AsString
      Else If fTrocaSQL(fRetornaSQL('NOT')) Then
        Result := qryAuxiliar.FieldByName('DET_EMPORI').AsString;
    Finally
      FreeAndNil(qryAuxiliar);
    End;
  end;

  function fRetornaEmpOri: String;
    Var
      strEmpOS: String;
      strEmpOriLoc: String;
      strEmpOriEXTGOR: String;
  Begin
    Result := '';

    {Req. 456948-B - B10a. A consulta so roda se houver chave. O If abaixo ja
     exigia (Not fEmptyStr(strIncFut)), entao com strIncFut vazio o resultado
     era buscado no banco e descartado - 280 execucoes numa rodada de 280
     linhas do balanco, medido em 2026-08-20. strEmpOriLoc e reatribuida mais
     adiante nesta funcao antes de qualquer outro uso.}
    strEmpOriLoc := '';
    If Not fEmptyStr(strIncFut) Then
      strEmpOriLoc := fCampoTabela('IFNULL(MOVTRI.DET_EMPORI,"")',
                                   'MOVDET INNER JOIN MOVTRI ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER',
                                   ['MOVDET.AUTOINCREM'],
                                   [strIncFut]);

    If (Not fEmptyStr(strEmpOriLoc)) And (strEmpOriLoc <> VS_strCodEmp) And (Not fEmptyStr(strIncFut)) Then
    Begin
      Result := strEmpOriLoc;
      Exit;
    End;

    if fOSVerificaOriPDO(strNum_PD, strEsp_PD, strEmp_PD, strEmpOS) then
      Result := strEmpOS
    Else If (fCfgSis('GEMPPD', varString) = '1') Then
    Begin
      If Not fEmptyStr(fRetornaInc_PD) Then
      Begin
        strEmpOriLoc := fCampoTabela('FDO_EMPORI', 'EXTDOR', ['FDO_SEQFDO'], [fRetornaInc_PD]);

        If Not fEmptyStr(strEmpOriLoc) Then
          Exit(strEmpOriLoc);
      End;

      strEmpOriEXTGOR := fRetEmpOriEXTGOR(strNum_PD, strEsp_PD, strEmp_PD);

      If (Not fEmptyStr(strEmpOriEXTGOR)) And (strEmpOriEXTGOR <> strCodEmp) Then
        Result := strEmpOriEXTGOR
      Else If fEmptyStr(strEmp_Pd) Then
        Result := strCodEmp
      Else
        Result := strEmp_Pd;
    End
    Else
    Begin
      Result := fRetEmpresaOperador(strCodVen);

      If (fEmptyStr(Result)) Then
        Result := strCodEmp;
    End;

    If (Not fEmptyStr(strDocDev)) Then
    Begin
      strEmpOriLoc := fRetornaEmpresaOrigemDevolucaoPor_PR;

      If (Not fEmptyStr(strEmpOriLoc)) And
         (strEmpOriLoc <> Result) Then
       Result := strEmpOriLoc;
    End;
  End;

  function MovimentaEstoqueExterno : Boolean;
  begin

    Result := False;

    LQtdRemessaFulfillment := IIF(intRemFil = 1, fltQtdRemFil, fltQtdIte);

    If Not strExtFul.Equals('S') Then
      Exit;

    If blnFilFul Then
      Exit;

    If (LQtdRemessaFulfillment <= 0) Then
      Exit;

    Result := True;

  end;

Begin

  Result := True;

  Try
    {Req. 456948-B - B10b. Com os moldes abertos pelo chamador, reaproveita;
     sem eles, cria e abre como sempre. Eram 3 round-trips por linha so para
     obter estrutura de campos, que e a mesma em todas.}
    If Assigned(objMoldeMovDet) Then
      qryTblMovDet := objMoldeMovDet
    Else
    Begin
      qryTblMovDet := fCriaQuery;
      qryTblMovDet.SQL.Text := 'SELECT * FROM MOVDET WHERE FALSE';
      qryTblMovDet.Open;
    End;

    If Assigned(objMoldeMovTri) Then
      qryTblMovTri := objMoldeMovTri
    Else
    Begin
      qryTblMovTri := fCriaQuery;
      qryTblMovTri.SQL.Text := 'SELECT * FROM MOVTRI WHERE FALSE';
      qryTblMovTri.Open;
    End;

    If Assigned(objMoldeMovAux) Then
      qryTblMovAux := objMoldeMovAux
    Else
    Begin
      qryTblMovAux := fCriaQuery;
      qryTblMovAux.SQL.Text := 'SELECT * FROM MOVAUX WHERE FALSE';
      qryTblMovAux.Open;
    End;

    Try
      If fEmptyStr(strAutInc) Then
        strAutInc := fRetAutoIncrem('MOVDET', strCodEmp);

      With qryTblMovDet Do
      Begin
        Insert;
        FieldByName('DET_SEQGER').AsString   := strSeqGer;
        FieldByName('DET_NUMDOC').AsString   := strNumDoc;
        FieldByName('DET_ESPDOC').AsString   := strEspDoc;
        FieldByName('DET_CODEMP').AsString   := strCodEmp;
        FieldByName('DET_CODITE').AsString   := strCodIte;

        If fEmptyStr(strCodDiv) Then
          FieldByName('DET_CODDIV').Value      := Null
        Else
          FieldByName('DET_CODDIV').AsString   := strCodDiv;

        If fEmptyStr(strCodMar) Then
          FieldByName('DET_CODMAR').Value      := Null
        Else
          FieldByName('DET_CODMAR').AsString   := strCodMar;

        If fEmptyStr(strCodFor) Then
          FieldByName('DET_CODFOR').Value      := Null
        Else
          FieldByName('DET_CODFOR').AsString   := strCodFor;

        If fEmptyStr(strCodCli) Then
          FieldByName('DET_CODCLI').Value      := Null
        Else
          FieldByName('DET_CODCLI').AsString   := strCodCli;

        If (dtaDtaEnt = 0) Then
          FieldByName('DET_DTAENT').Value      := Null
        Else
          FieldByName('DET_DTAENT').AsDateTime := dtaDtaEnt;

        If (dtaHorEnt = 0) Then
          FieldByName('DET_HORENT').Value := Null
        Else
          FieldByName('DET_HORENT').AsDateTime := dtaHorEnt;

        FieldByName('DET_DTADOC').AsDateTime := dtaDtaDoc;
        FieldByName('DET_CONPAG').AsString   := fTiraCaracEspeciais(strConPag);
        FieldByName('DET_TIP_FC').AsString   := strTip_Fc;
        FieldByName('DET_ESTADO').AsString   := strEstado;
        FieldByName('DET_DESCRI').AsString   := strDescri;
        FieldByName('DET_REFERE').AsString   := strRefere;
        FieldByName('DET_UNIDAD').AsString   := strUnidad;
        if fEmptyStr(strUnidad) Then
          FieldByName('DET_UNIDAD').Clear;

        If fEmptyStr(strForIte) Then
          FieldByName('DET_FORITE').Value := Null
        Else
          FieldByName('DET_FORITE').AsString := strForIte;

        FieldByName('DET_QTDITE').AsFloat    := fltQtdIte;
        FieldByName('DET_UNITAR').AsFloat    := fltUnitar;
        FieldByName('DET_UNIORI').AsFloat    := fltUniOri;
        FieldByName('DET_UNIDIG').AsFloat    := fltUniDig;
        FieldByName('DET_TOTITE').AsFloat    := fltTotIte;
        FieldByName('DET_VLRCON').AsFloat    := fltVlrCon;
        FieldByName('DET_TOTCUS').AsFloat    := fltTotCus;
        FieldByName('DET_TOTMED').AsFloat    := fltTotMed;
        FieldByName('DET_DESCON').AsFloat    := fltDesCon;
        FieldByName('DET_TOTFRE').AsFloat    := fltTotFre;
        FieldByName('DET_DESESP').AsFloat    := fltDesEsp;

        If (fEmptyStr(strCodRep)) Then
          FieldByName('DET_CODREP').Value := Null
        Else
          FieldByName('DET_CODREP').AsString := strCodRep;

        If fEmptyStr(strCodVe2) Then
          FieldByName('DET_CODVE2').AsVariant := Null
        Else
          FieldByName('DET_CODVE2').AsString := strCodVe2;

        FieldByName('DET_PERCOM').AsFloat    := fltPerCom;
        FieldByName('DET_TOTCOM').AsFloat    := fltTotCom;
        FieldByName('DET_TOTCO2').AsFloat    := fltTotCo2;
        FieldByName('DET_CLAFIS').AsString   := strClaFis;
        FieldByName('DET_CODFIS').AsString   := strCodFis;
        FieldByName('DET_VALIPI').AsFloat    := fltValIpi;
        FieldByName('DET_ALQIPI').AsFloat    := fltAlqIpi;
        FieldByName('DET_BASIPI').AsFloat    := fltBasIpi;
        FieldByName('DET_VALICM').AsFloat    := fltValIcm;
        FieldByName('DET_ALQICM').AsFloat    := fltAlqIcm;
        FieldByName('DET_BASICM').AsFloat    := fltBasIcm;
        FieldByName('DET_VALRET').AsFloat    := fltValRet;
        FieldByName('DET_ALQRET').AsFloat    := fltAlqRet;
        FieldByName('DET_BASRET').AsFloat    := fltBasRet;
        FieldByName('DET_TOTPES').AsFloat    := fltTotPes;
        FieldByName('DET_PERBAS').AsFloat    := fltPerBas;
        FieldByName('DET_PERRED').AsFloat    := fltPerRed;

        If FieldByName('DET_JAFATU').DataType = ftInteger Then
          FieldByName('DET_JAFATU').AsInteger :=  IIF(blnJafatu,1,0)
        Else
          FieldByName('DET_JAFATU').AsBoolean :=  blnJafatu;

        FieldByName('DET_TIPFAT').AsString   := strTipFat;
        FieldByName('DET_NUMFAT').AsString   := strNumFat;
        if fEmptyStr(strNumFat) Then
          strEmpFat := '';

        If fEmptyStr(strEmpFat) Then
          FieldByName('DET_EMPFAT').Value    := Null
        Else
          FieldByName('DET_EMPFAT').AsString := strEmpFat;

        If (dtaDtaFat = 0) Then
          FieldByName('DET_DTAFAT').Value      := Null
        Else
          FieldByName('DET_DTAFAT').AsDateTime := dtaDtaFat;

        If Not fEmptyStr(strVenFat) Then
          FieldByName('DET_VENFAT').AsString := strVenFat
        Else
          FieldByName('DET_VENFAT').Value := Null;

        FieldByName('DET_CNDFAT').AsString   := strCndFat;
        FieldByName('DET_VALFAT').AsFloat    := fltValFat;
        FieldByName('DET_IDEPRO').AsString   := strIdePro;
        FieldByName('DET_INCPIS').AsString   := strIncPis;
        FieldByName('DET_SERIE_').AsString   := strSerie;
        FieldByName('DET_DESACE').AsFloat    := fltDesAce;
        FieldByName('DET_NOTESP').AsString   := strNotEsp;

        If (fEmptyStr(strDocDev)) Then
          FieldByName('DET_DOCDEV').Value    := Null
        Else
          FieldByName('DET_DOCDEV').AsString := strDocDev;

        If (fEmptyStr(strEspDev)) Then
          FieldByName('DET_ESPDEV').Value    := Null
        Else
          FieldByName('DET_ESPDEV').AsString := strEspDev;

        If (fEmptyStr(strEmpDev)) Then
          FieldByName('DET_EMPDEV').Value    := Null
        Else
          FieldByName('DET_EMPDEV').AsString := strEmpDev;

        if fEmptyStr(strIteCha) then
          FieldByName('DET_ITECHA').Value := Null
        else
          FieldByName('DET_ITECHA').AsString   := strIteCha;

        FieldByName('DET_ITETIN').AsString   := strIteTin;
        FieldByName('DET_DESCOR').AsString   := strDesCor;

        FieldByName('DET_TIPEMB').AsString   := strTipEmb;
        FieldByName('DET_QTDEMB').AsFloat    := fltQtdEmb;
        FieldByName('DET_PREEMB').AsFloat    := fltPreEmb;
        FieldByName('DET_TIPPRE').AsString   := strTipPre;
        FieldByName('DET_PRVTIN').AsFloat    := fltPrvTin;
        FieldByName('DET_PRCTIN').AsFloat    := fltPrcTin;
        FieldByName('DET_FATTIN').AsFloat    := fltFatTin;
        FieldByName('DET_PROEMB').AsString   := strProEmb;

        If (fEmptyStr(strCodDig)) Then
          FieldByName('DET_CODDIG').Value := Null
        Else
          FieldByName('DET_CODDIG').AsString   := strCodDig;

        If (fEmptyStr(strCodCnd)) Then
          FieldByName('DET_CODCND').Value := Null
        Else
          FieldByName('DET_CODCND').AsString   := strCodCnd;

        If (fEmptyStr(strCodFpg)) Then
          FieldByName('DET_CODFPG').Value := Null
        Else
          FieldByName('DET_CODFPG').AsString   := strCodFpg;

        if fEmptyStr(strIteEmb) then
          FieldByName('DET_ITEEMB').Value := Null
        else
          FieldByName('DET_ITEEMB').AsString  := strIteEmb;

        FieldByName('DET_LAZQUA').AsInteger := intLazQua;

        FieldByName('DET_PROMOC').AsString  := strPromoc;
        FieldByName('DET_SEQTIN').AsString  := strSeqTin;
        FieldByName('DET_QTDPUL').AsFloat   := fltQtdPul;

        If (fEmptyStr(strPedCom)) Then
          FieldByName('DET_PEDCOM').Value := Null
        Else
          FieldByName('DET_PEDCOM').AsString := strPedCom;

        FieldByName('DET_ORIDOC').AsString := strOriDoc;

        If (Not fEmptyStr(strOrdPro)) Then
          FieldByName('DET_ORDPRO').AsString := strOrdPro
        Else
          FieldByName('DET_ORDPRO').Value := Null;

        FieldByName('DET_QTDROM').AsFloat  := 0.0;

        FieldByName('DET_NUM_PD').AsString := strNum_Pd;
        FieldByName('DET_ESP_PD').AsString := strEsp_Pd;
        FieldByName('DET_EMP_PD').AsString := strEmp_Pd;

        If (fEmptyStr(FieldByName('DET_EMP_PD').AsString)) Then
          FieldByName('DET_EMP_PD').Value := Null;

        FieldByName('DET_IND_PD').AsInteger := intInd_Pd;

        FieldByName('DET_TMPGAR').AsInteger := fRetTempoGarantia(strCodIte, strClaFis);

        FieldByName('DET_DESNES').AsString := strDesNes;
        FieldByName('AUTOINCREM').AsString := strAutInc;

        If (fEmptyStr(strCliFat)) Then
          FieldByName('DET_CLIFAT').Value := Null
        Else
          FieldByName('DET_CLIFAT').AsString := strCliFat;

        FieldByName('DET_CODVEN').AsString := IIF(fEmptyStr(strCodVen), strLoginUsuarioLogado, strCodVen);
        FieldByName('DET_BCAMIN').AsFloat  := fltBcaMin;
        FieldByName('DET_BCACOM').AsFloat  := fltBcaCom;
        FieldByName('DET_VOLPRO').AsFloat  := fltVolPro;

        If fEmptyStr(strCodAca) Then
          FieldByName('DET_CODACA').Value := Null
        Else
          FieldByName('DET_CODACA').AsString := strCodAca;

        If fEmptyStr(strEmpAca) Then
          FieldByName('DET_EMPACA').Value := Null
        Else
          FieldByName('DET_EMPACA').AsString := strEmpAca;

        FieldByName('DET_PROACA').AsString  := IIF(blnProAca, 'S', 'N');

        If FieldByName('DET_FILKAR').DataType = ftInteger Then
          FieldByName('DET_FILKAR').AsInteger :=  IIF(blnFilKar,1,0)
        Else
          FieldByName('DET_FILKAR').AsBoolean :=  blnFilKar;

        FieldByName('DET_DOCFUT').AsString   := strDocFut;
        FieldByName('DET_ESPFUT').AsString   := strEspFut;
        FieldByName('DET_EMPFUT').AsString   := strEmpFut;

        If fEmptyStr(strDocFut) Then
          FieldByName('DET_DOCFUT').Clear;
        If fEmptyStr(strEspFut) Then
          FieldByName('DET_ESPFUT').Clear;
        If fEmptyStr(strEmpFut) Then
          FieldByName('DET_EMPFUT').Clear;

        FieldByName('DET_TABPRE').AsString   := strTabPre;

        If Not fEmptyStr(strEmpCom) Then
          FieldByName('DET_EMPCOM').AsString := strEmpCom
        Else
          FieldByName('DET_EMPCOM').Value := Null;


        {***************************************************}
        {* CAMPOS USADOS PARA DINTAS COM DILUIÇÃO DINAMICA *}
        {************************************************PH*}
        FieldByName('DET_LINLIN').AsString  := strLinha;
        FieldByName('DET_CATALI').AsString  := strCatali;
        FieldByName('DET_CODDIL').AsString  := strCodDil;
        FieldByName('DET_PORDIL').AsFloat   := fltPorDil;
        FieldByName('DET_DILCON').AsString  := strDilCon;
        FieldByName('DET_PORCAT').AsFloat   := fltPorCat;

        FieldByName('DET_QTDPON').AsFloat := fltQtdPon;

        If Pos(strEntFut,'SN') <= 0 Then
          strEntFut := 'N';

        FieldByName('DET_ENTFUT').AsString := strEntFut;
        FieldByName('DET_MOTFUT').AsString := strMotFut;

        If dtaDtaFut = 0 Then
          FieldByName('DET_DTAFUT').Value := Null
        Else
          FieldByName('DET_DTAFUT').AsDateTime := dtaDtaFut;

        FieldByName('DET_TOTCU2').AsFloat   := fFormataFloat(fltTotCu2, 2);

        FieldByName('DET_COMREP').AsFloat    := fltComRep;
        FieldByName('DET_PERREP').AsFloat    := fltPerRep;

        FieldByName('DET_KEY_EP').AsString   := strKey_EP;

        If fEmptyStr(strNumLot) Then
          FieldByName('DET_NUMLOT').Value := Null
        Else
          FieldByName('DET_NUMLOT').AsString := strNumLot;

        FieldByName('DET_PIGBAS').AsString := strPigBas;

        If FindField('DET_ORIEMP') <> Nil Then
          FieldByName('DET_ORIEMP').AsString := fRetornaEmpOri;

        {Req. 456948 - com ABatch atribuido, acumula em vez de executar.
         MOVTRI, MOVAUX, MOVREF e BRIDET sao filhas desta tabela e entram no
         MESMO lote: conversao parcial quebraria a FK, porque a filha nao
         encontraria o pai ainda nao gravado.}
        TBatchHelper.PostOuAcumula(qryTblMovDet, 'MOVDET', ABatch);

      End;

      With qryTblMovTri Do
      Begin
        Append;

        FieldByName('DET_SEQGER').AsString := strAutInc;

        If (fltTotFre + fltConFre)> 0 Then
          FieldByName('DET_ALQFRE').AsFloat  := fltICMCFR
        Else
          FieldByName('DET_ALQFRE').AsFloat  := 0;

        FieldByName('DET_CFRETE').AsFloat  := fltFreteCalc;
        FieldByName('DET_CFRECO').AsFloat  := fltFreConCalc;

        FieldByName('DET_PICMST').AsFloat  := fltAlqSTXML;

        FieldByName('DET_ICMNCR').AsFloat  := fltICMNCR;
        FieldByName('DET_FCPNCR').AsFloat  := fltFCPNCR;

        FieldByName('DET_BARTSP').AsFloat  := fltBaRtSP;
        FieldByName('DET_VLRTSP').AsFloat  := fltVaRtSP;
        FieldByName('DET_ICOPPR').AsFloat  := fltIcOpPr;
        FieldByName('DET_VAEIPI').AsFloat  := fltVaEIpi;
        FieldByName('DET_ALEIPI').AsFloat  := fltAlEIpi;
        FieldByName('DET_BAEIPI').AsFloat  := fltBaEIpi;
        FieldByName('DET_TOTULT').AsFloat  := fltTotUlt;
        FieldByName('DET_IMPULT').AsFloat  := fltImpUlt;
        FieldByName('TRI_EMBALA').AsFloat  := fltEmbala;
        FieldByName('DET_BASCOF').AsFloat  := fltBasCof;
        FieldByName('DET_ALQCOF').AsFloat  := fltAlqCof;
        FieldByName('DET_VALCOF').AsFloat  := fltValCof;
        FieldByName('DET_CSTCOF').AsString := strCSTCof;
        FieldByName('DET_BASPIS').AsFloat  := fltBasPis;
        FieldByName('DET_ALQPIS').AsFloat  := fltAlqPis;
        FieldByName('DET_VALPIS').AsFloat  := fltValPis;
        FieldByName('DET_CSTPIS').AsString := strCSTPis;
        FieldByName('DET_LOT_TA').AsString := strLot_TA;
        FieldByName('DET_CONFRE').AsFloat  := fltConFre;
        FieldByName('DET_RPAFRE').AsFloat  := fltRpaFre;
        FieldByName('DET_NR_PIS').AsString := strNatPis;
        FieldByName('DET_NR_COF').AsString := strNatCof;
        FieldByName('DET_AUTSAI').AsString := strAutSai;

        If Not fEmptyStr(strTipBus) Then
          FieldByName('DET_TIPBUS').AsString := strTipBus;

        If fEmptyStr(strAutSai) Then
          FieldByName('DET_AUTSAI').Clear;

        If intSeqCcr > 0 Then
          FieldByName('DET_SEQCCR').AsInteger := intSeqCcr;

        If fltUniTab = 0 Then
          FieldByName('DET_UNITAB').AsFloat := fltUniOri
        Else
          FieldByName('DET_UNITAB').AsFloat := fltUniTab;

        If fltUniVis = 0 Then
          FieldByName('DET_UNIVIS').AsFloat := fltUniOri
        Else
          FieldByName('DET_UNIVIS').AsFloat := fltUniVis;

        FieldByName('DET_BASANT').AsFloat  := fltBasAnt;
        FieldByName('DET_ICMANT').AsFloat  := fltIcmAnt;
        FieldByName('DET_VENDOR').AsFloat  := fltVendor;
        FieldByName('DET_OUTDES').AsFloat  := fltOutDes;
        FieldByName('DET_VLGNRE').AsFloat  := fltVlGnre;
        FieldByName('DET_GNRORI').AsString := strGnrOri;
        FieldByName('DET_OUTICM').AsFloat := fltOutIcm;
        FieldByName('DET_ISEICM').AsFloat := fltIseIcm;

        FieldByName('DET_FRESUG').AsFloat := fltFreSug;

        If fEmptyStr(strCodMot) Then
          FieldByName('DET_CODMOT').IsNull
        Else
          FieldByName('DET_CODMOT').AsString := strCodMot;

        {*******************************************}
        {* SE FOR RETORNO DE FORNECEDOR (GARANTIA) *}
        {* SALVA O AUTOINCREMENTO DA TABELA MOVGAD *}
        {*******************************************}
        If Not fEmptyStr(strSeqGad) Then
          FieldByName('DET_SEQGAD').AsString := strSeqGad;

        FieldByName('DET_OUTVAL').AsFloat := (fltOutVal * fltQtdIte) + fltOutValPD;
        FieldByName('DET_IMPFED').AsFloat := (fltTotIte - fltDesEsp + fltTotFre + fltDesAce) * fltImpFed / 100;

        blnPedidoOrigemSite := fPedidoEhOrigemTabletSite(strNum_Pd, strEsp_Pd, strEmp_Pd);
        blnSomaTotFreDesAce := (Not blnPedidoOrigemSite) Or (blnPedidoOrigemSite And (fCfgSis('CALDES', varString) = '1'));

        FieldByName('DET_DESOPE').AsFloat := (fltTotIte - fltDesEsp + IIF(blnSomaTotFreDesAce, (fltTotFre + fltDesAce), 0)) * fltDesOpe / 100;

        FieldByName('DET_DESCLI').AsFloat := (fltTotIte - fltDesEsp) * fltDesCli / 100;

        If (blnIcmSai) Then
          FieldByName('DET_ICMSAI').AsFloat := (fltIcmPav * fltQtdIte)
        Else
        Begin
          If (fCfgSis('IMPCF4') = 'S') And (Not fCfgSis('RAICF4', varBoolean)) Then
          Begin
            If (((fCfgSis('CLPVDI', varString) = 'S') And (fCfgSis('ICMSEP', varString) = 'S')) Or (fCfgSis('UASCCR', varString) = 'S')) And (fltIcmPrd > 0) Then
              FieldByName('DET_ICMSAI').AsFloat := (fltTotIte - fltDesEsp + fltTotFre + fltDesAce) * (fltIcmPrd+fltAlDifa) / 100
            Else
              FieldByName('DET_ICMSAI').AsFloat := (fltTotIte - fltDesEsp + fltTotFre + fltDesAce) * (fltAlqIcm+fltAlDifa) / 100;
          End
          Else
            FieldByName('DET_ICMSAI').AsFloat := (fltTotIte - fltDesEsp + fltTotFre + fltDesAce) * (fltIcmSai+fltAlDifa) / 100;
        End;

        If (not blnIcmSai) And (fCfgSis('IMPCF4') = 'S') And (strRICMPR = 'S') Then
        Begin
          fltAlqIcm := fFormataFloat(fltAlqIcm * fMultiplicadorReducaoRICMS(fltPerRic), 2);
          FieldByName('DET_ICMSAI').AsFloat := (fltTotIte - fltDesEsp + fltTotFre + fltDesAce) * (fltAlqIcm+fltAlDifa) / 100;
        End;

        {***************************************************************}
        {* Caso for tinta de máquina, o icmsai já está                 *}
        {* preenchido corretamente respeitando a configuração 'IMPCF4' *}
        {************************************************************AC*}
        If fEmptyStr(strIdeDev) Then
           strIdeDev := 'NOR' ;

        If ((strIdePro <> 'NOR') Or (strIdeDev <> 'NOR')) Then
          FieldByName('DET_ICMSAI').AsFloat := (fltTotIte - fltDesEsp + fltTotFre + fltDesAce) * fltIcmSai / 100;

        {***************************************************************}
        {* Caso for item venda de vidro, o icmsai já está              *}
        {* preenchido corretamente respeitando a configuração 'IMPCF4' *}
        {************************************************************JC*}
        If fEhItemVendaVidro(strCodIte) And fCfgSis('VENVID', VarBoolean) Then
          FieldByName('DET_ICMSAI').AsFloat := (fltTotIte - fltDesEsp + fltTotFre + fltDesAce) * fltIcmSai / 100;

        If (fltAlq922 > 0) Then
          FieldByName('DET_ICMSAI').AsFloat := (fltTotIte - fltDesEsp + fltTotFre + fltDesAce) * fltAlq922 / 100;

        If (fltCfvIpi > 0) Then
        Begin
          FieldByName('DET_DESOPE').AsFloat := (fltTotIte - fltDesEsp + IIF(blnSomaTotFreDesAce, fltTotFre, 0)) * fltDesOpe / 100;
          FieldByName('DET_IMPFED').AsFloat := (fltTotIte - fltDesEsp + fltTotFre) * fltImpFed / 100;
          FieldByName('DET_ICMSAI').AsFloat := (fltTotIte - fltDesEsp + fltTotFre) * (fltAlqIcm+fltAlDifa) / 100;
        End;

        FieldByName('DET_QTDEXP').AsFloat := fltQtdExp;

        FieldByName('DET_CSTIPI').AsString := strCSTIpi;
        FieldByName('DET_ENQIPI').AsString := strEnqIpi;
        FieldByName('DET_DEDVCF').AsFloat  := fltDeDVCf;

        FieldByName('DET_NUMCMP').AsString  := strNumCmp;
        FieldByName('DET_NITCMP').AsInteger := intNItCmp;

        if (dtaDtaCmp = 0) then
          FieldByName('DET_DTACMP').Value := Null
        else
          FieldByName('DET_DTACMP').AsDateTime := dtaDtaCmp;

        FieldByName('DET_VAERET').AsFloat  := fltVaERet;
        FieldByName('DET_ALERET').AsFloat  := fltAlERet;
        FieldByName('DET_BAERET').AsFloat  := fltBaERet;

        FieldByName('DET_PEBAST').AsFloat  := fltPeBaST;
        FieldByName('DET_VAL_RT').AsFloat  := fltVal_RT;
        FieldByName('DET_TAXJUR').AsFloat  := fltTaxJur;

        FieldByName('DET_ANTPRO').AsString := strAntPro;
        FieldByName('DET_ANTFRE').AsString := strAntFre;

        FieldByName('DET_MEDANT').AsFloat  := fltMedAnt;
        FieldByName('DET_PREANT').AsFloat  := fltPreAnt;
        FieldByName('DET_IMPANT').AsFloat  := fltImpAnt;
        If fEmptyStr(strSeqAnt) Then
          FieldByName('DET_SEQANT').Clear
        Else
          FieldByName('DET_SEQANT').AsString := strSeqAnt;
        
        FieldByName('DET_PESLIQ').AsFloat  := fltPesLiq;

        FieldByName('DET_RICMPR').AsString := strRICMPR;

        If Not fEmptyStr(strCliBus) Then
          FieldByName('DET_CLIBUS').AsString  := strCliBus
        Else
          FieldByName('DET_CLIBUS').AsString  := 'N';

        FieldByName('DET_TURENT').AsString := AnsiUpperCase(strTurEnt);

        If FindField('TRI_NCMTIN') <> Nil Then
          FieldByName('TRI_NCMTIN').AsString := strNcmTin;

        If FindField('DET_COMLIQ') <> Nil Then
          FieldByName('DET_COMLIQ').AsFloat  := fltComLiq;

        If FindField('DET_VALIVA') <> Nil Then
          FieldByName('DET_VALIVA').AsFloat  := fltValIva;

        If FindField('DET_EMPORI') <> Nil Then
          FieldByName('DET_EMPORI').AsString := fRetornaEmpOri;

        If FindField('DET_PERDIF') <> Nil Then
          FieldByName('DET_PERDIF').AsFloat := fltPerDif;

        If fCfgSis('UTIIND', varBoolean) Then
        Begin
          strCodIteGra := fGetItemAhGranel(strCodIte);

          If Not fEmptyStr(strCodIteGra) Then
          Begin
            strCodCor := fGetCodCorItem(strCodIte);

            {*********************************************************}
            {* FEITO O FORMATFLOAT PARA GARANTIR O TRUNCAMENTO IGUAL *}
            {* A DATA TELA DE CADASTRO DE ESTRUTURA INDUSTRIAL       *}
            {******************************************************FC*}
            strPesEsp := FormatFloat('#,##0.0000', fGetPesoEspecificoItemGranel(strCodIteGra, strCodCor, strFormula));

            FieldByName('DET_PESESP').AsFloat  := fStrToFloat(strPesEsp);
            FieldByName('DET_CHVFOR').AsString := strCodIteGra + '-' + strCodCor + '-' + strFormula;
          End;
        End;

        FieldByName('DET_TAXENT').AsFloat  := fltTaxEnt;

        If Not fUsaImpostoFonteIBPT Then
          FieldByName('DET_IMPPAG').AsFloat  := fltImpPag
        Else
        Begin
          FieldByName('DET_IMPPAG').AsFloat  := fltFedImp + fltEstImp + fltMunImp;
          FieldByName('DET_FEDIMP').AsFloat  := fltFedImp;
          FieldByName('DET_ESTIMP').AsFloat  := fltEstImp;
          FieldByName('DET_MUNIMP').AsFloat  := fltMunImp;
        End;

        FieldByName('DET_SERRAT').AsFloat  := fltSerRat;

        If Not fEmptyStr(strProBri) Then
        Begin
          FieldByName('DET_PROBRI').AsString := strProBri;
          FieldByName('DET_PONBRI').AsFloat  := fltPonBri;
        End;

        FieldByName('DET_VALDIF').AsFloat  := fltValDif;

        FieldByName('DET_VAFRAN').AsFloat := fltVaFrAn;

        FieldByName('DET_LOTABA').AsString := strLotAba;

        If (fEmptyStr(strIncDev)) Then
          FieldByName('DET_INCDEV').Value    := Null
        Else
          FieldByName('DET_INCDEV').AsString := strIncDev;

        FieldByName('DET_ICMORG').AsFloat := fltIcmOrg;

        If fEmptyStr(strBaqtze) Then
          FieldByName('DET_BAQTZE').Value := Null
        Else
          FieldByName('DET_BAQTZE').AsString := strBaqtze;

        If (fEmptyStr(strIncFut)) Then
          FieldByName('DET_INCFUT').Value    := Null
        Else
          FieldByName('DET_INCFUT').AsString := strIncFut;

        FieldByName('DET_VALFLE').AsFloat  := fltValFle;

        FieldByName('DET_VRDICM').AsFloat  := fltVrdIcm;
        FieldByName('DET_BASVRD').AsFloat  := fltBasVrd;
        FieldByName('DET_MTDICM').AsString := Copy(strMtdIcm, 1, 2);
        FieldByName('DET_BXSBIT').AsString := strBxSbIt;

        If fEmptyStr(strIteAbf) Then
          strIteAbf := strCodIte;

        FieldByName('DET_ITEABF').AsString := strIteAbf;

        FieldByName('DET_ATIVAC').AsString  := 'N';

        If (Not fEmptyStr(strAtivac)) Then
          FieldByName('DET_ATIVAC').AsString  := strAtivac;

        FieldByName('DET_SEQCOM').AsInteger := intSeqCom;
        FieldByName('DET_VICMDE').AsFloat := fltVICMDe;

        If (Not fEmptyStr(strNcmIte)) Then
          FieldByName('DET_NCMITE').AsString  := strNcmIte;

        If (Not fEmptyStr(strAutEle)) Then
          FieldByName('DET_AUTELE').AsString := strAutEle;

        FieldByName('DET_COMDIG').AsFloat := fltComDig;
        FieldByName('DET_PERDIG').AsFloat := fltPerDig;

        FieldByName('DET_ICMPAV').AsFloat := fltIcmPav;
        FieldByName('DET_BFCPST').AsFloat := fltBFCPST;
        FieldByName('DET_PFCPST').AsFloat := fltPFCPST;
        FieldByName('DET_VFCPST').AsFloat := fltVFCPST;

        FieldByName('DET_DESCND').AsFloat  := fltDesCnd;

        FieldByName('DET_PROESP').AsString := strProEsp;

        FieldByName('DET_CODPRO').AsString := strCodPro;

        FieldByName('DET_VALTCI').AsFloat := fltValTCI;
        FieldByName('DET_CALTCI').AsFloat := fltCalTCI;
        FieldByName('DET_VAL_TS').AsFloat := fltVal_TS;

        FieldByName('DET_EXTFUL').AsString := strExtFul;

        If fEmptyStr(strCodExt) Then
          FieldByName('DET_CODEXT').Value := Null
        Else
          FieldByName('DET_CODEXT').AsString := strCodExt;


        FieldByName('DET_PROKIT').AsString := strAIdKitPromocao;

        if fEmptyStr(strChaveAcesso) then
          FieldByName('DET_CHACES').Clear
        else
          FieldByName('DET_CHACES').AsString := strChaveAcesso;

        FieldByName('DET_QTDCOM').AsFloat := fltQtdCom;
        FieldByName('DET_FRECOT').AsFloat := fltFreCot;

        FieldByName('DET_FREMKP').AsFloat := fltFreMkp;
        FieldByName('DET_COMMKP').AsFloat := fltComMkp;

        if fEmptyStr(AstrComplemento) then
          FieldByName('DET_COMPLE').Clear
        else
          FieldByName('DET_COMPLE').AsString := AstrComplemento;

        FieldByName('DET_OPBICM').AsFloat  := AfltBaseOperacaoPropriaICMSEntrada;
        FieldByName('DET_OPAICM').AsFloat  := AfltAliquotaOperacaoPropriaICMSEntrada;
        FieldByName('DET_OPVICM').AsFloat  := AfltValorOperacaoPropriaIMCSEntrada;
        FieldByName('DET_FRERAT').AsFloat  := fltFreRat;

        FieldByName('DET_DESPIS').AsFloat  := fltDesPis;
        FieldByName('DET_CLARET').AsInteger := IIf(blnClaRet, 1, 0);

        FieldByName('DET_OPSEEX').AsString := strOpSeEx;
        FieldByName('DET_OPEEXP').AsString := strConExp;
        FieldByName('DET_EMBEXP').AsString := strEmbExp;
        FieldByName('DET_OBSEXP').AsString := strObsExp;

        FieldByName('DET_NUMPLA').AsString := strNumPla;
        FieldByName('DET_PARNUM').AsString := strParNum;
        FieldByName('DET_REQCOM').AsString := strReqCom;

        if fEmptyStr(strMovTriLocFis) then
          FieldByName('DET_LOCFIS').Clear
        else
          FieldByName('DET_LOCFIS').AsString := strMovTriLocFis;

        if fEmptyStr(strNumDrw) then
          FieldByName('DET_NUMDRW').Value := Null
        else
          FieldByName('DET_NUMDRW').AsString := strNumDrw;


         if fEmptyStr(strNatOpe) then
         Begin
           FieldByName('DET_NATOPE').AsString := fRetNomGeral('NAT_DESCRI','NAT_CODCFO','NATCFO',fStrToFloat(strClaFis));
           If fEmptyStr(FieldByName('DET_NATOPE').AsString) Then
             FieldByName('DET_NATOPE').Value := Null;
         End
         else
         begin
           If strNatOpe = '#VAZIO' then
             FieldByName('DET_NATOPE').Value := Null
           Else
             FieldByName('DET_NATOPE').AsString := strNatOpe;
         end;

        FieldByName('DET_ALTEST').AsString  := IIF(blnAltEst, 'S', 'N');
        FieldByName('DET_SEQPER').AsInteger := intSeqPer;
        FieldByName('DET_NITEM_').AsInteger := intDetItem+1;
        FieldByName('DET_PEGOU_').AsString := strPegou_;
        FieldByName('DET_CUBAGE').AsFloat   := fltCubage;
        FieldByName('DET_CFBIPI').AsFloat   := fltCfbIpi;
        FieldByName('DET_CFAIPI').AsFloat   := fltCfaIpi;
        FieldByName('DET_CFVIPI').AsFloat   := fltCfvIpi;
        FieldByName('DET_CIPIOK').AsString  := strCipiOK;
        FieldByName('DET_DOCIPI').AsString  := strDocIpi;
        FieldByName('DET_ESPIPI').AsString  := strEspIpi;
        FieldByName('DET_EMPIPI').AsString  := strEmpIpi;
        FieldByName('DET_ENTTRI').AsString  := strEntTri;
        FieldByName('DET_CBENEF').AsString  := strCbenef;
        FieldByName('DET_CODPRE').AsString  := strCodPre;
        FieldByName('DET_BASPRE').AsFloat   := fltBasPre;
        FieldByName('DET_PERPRE').AsFloat   := fltPerPre;
        FieldByName('DET_VALPRE').AsFloat   := fltValPre;
        FieldByName('DET_VALSEG').AsFloat   := fltValSeg;
        FieldByName('DET_SISCOM').AsFloat   := fltSiscomex;
        FieldByName('DET_CHVREF').AsString  := strChvRef;
        FieldByName('DET_ITEREF').AsString  := strIteRef;

        If Not fEmptyStr(strAutEnt) Then
          FieldByName('DET_AUTENT').AsString := strAutEnt;

        FieldByName('DET_TCKQBT').AsString  := strTckQbt;

        If fCfgSis('CRDMNF', varString) = 'S' Then
          If dobQIcmsMonRet > 0 Then
          Begin
            If FindField('DET_QBCMON') <> nil then
              FieldByName('DET_QBCMON').AsFloat   := dobQIcmsMonRet;
            If FindField('DET_ADREMN') <> nil then
              FieldByName('DET_ADREMN').AsFloat   := dobAdBcMonRet;
            If FindField('DET_VALMON') <> nil then
              FieldByName('DET_VALMON').AsFloat   := dobVrEmIcmsRet;
          End;
        TBatchHelper.PostOuAcumula(qryTblMovTri, 'MOVTRI', ABatch);   {Req. 456948}
      End;

      if (MovimentaEstoqueExterno) then
      Begin

        pAjustaEstoqueExterno(strCodEmp,
                              strCodIte,
                              strCodExt,
                              strClaFis,
                              strChaveAcesso,
                              strFullHubMkp,
                              LQtdRemessaFulfillment);

      End;

      If strBrinde = 'S' Then
      Begin
        qryTblBriDet := fCriaQuery;

        qryTblBriDet.SQL.Add('SELECT * FROM BRIDET WHERE FALSE');
        qryTblBriDet.Open;
        qryTblBriDet.Append;
        qryTblBriDet.FieldByName('BRI_SEQDET').AsString := strAutInc;

        If (Not fEmptyStr(strCodPar)) Then
          qryTblBriDet.FieldByName('BRI_CODPAR').AsString := strCodPar
        Else
          qryTblBriDet.FieldByName('BRI_CODPAR').Value := Null;

        qryTblBriDet.FieldByName('BRI_TIPBRI').AsString := strTipBri;
        TBatchHelper.PostOuAcumula(qryTblBriDet, 'BRIDET', ABatch);   {Req. 456948}

        FreeAndNil(qryTblBriDet);
      end;

      If not fEmptyStr(strDadSep) Then
      Begin
        qryTblBriDet := fCriaQuery;

        With qryTblBriDet, SQL Do
        Begin
          Close;
          Clear;
          Add(' INSERT INTO DETSEP( AUTOINCREM, ');
          Add('                     DET_SEPEXP, ');
          Add('                     DET_QTDSEP, ');
          Add('                     DET_SEQDET) ');
          Add('             VALUES( :AUTINC,    ');
          Add('                     :SEPEXP,    ');
          Add('                     :QTDSEP,    ');
          Add('                     :SEQDET)    ');

          While not fEmptyStr(strDadSep) Do
          Begin
            //Prepara os dados, essa String vem assim:
            //OOO#QQQQ##
            //Onde : OOO = codigo do Operador
            //         # = 1 Hastag separa o operador da quantidade
            //       QQQ = Quantidade (Quantidade de caracteres Ilimitado
            //        ## = 2 Hastag indica fim do operador para esse item.

            strDadSepOpe := Copy(strDadSep, 1, 3);
            fltDadSepQtd := fStrToFloat( ReplaceStr( Copy(strDadSep, 5, Pos('##',strDadSep) - 5), '.', ',') );

            strDadSep := Copy(strDadSep, Pos('##',strDadSep) + 2, Length(strDadSep));

            ParamByName('AUTINC').AsString := fRetAutoIncrem('DETSEP', strCodEmp);
            ParamByName('SEQDET').AsString := strAutInc;
            ParamByName('SEPEXP').AsString := strDadSepOpe;
            ParamByName('QTDSEP').AsFloat  := fltDadSepQtd;
            ExecSQL;
          End;

        End;

        FreeAndNil(qryTblBriDet);
      End;

      With qryTblMovAux Do
      Begin
        Append;

        FieldByName('DET_SEQGER').AsString := strAutInc;
        FieldByName('DET_NOTULT').AsString := strNotUlt;
        FieldByName('DET_PICMEF').AsFloat  := fltPICMEF;
        FieldByName('DET_BICMEF').AsFloat  := fltBICMEF;
        FieldByName('DET_AICMEF').AsFloat  := fltAICMEF;
        FieldByName('DET_VICMEF').AsFloat  := fltVICMEF;
        FieldByName('DET_BSTANT').AsFloat  := fltBSTANT;
        FieldByName('DET_VSTANT').AsFloat  := fltVSTANT;
        FieldByName('DET_NOTC17').AsString := strNotC17;
        FieldByName('DET_SICMEF').AsFloat  := fltSICMEF;

        If fEmptyStr(strEmpCar) Then
          FieldByName('DET_EMPCAR').Clear
        Else
          FieldByName('DET_EMPCAR').AsString := strEmpCar;

        If fEmptyStr(strAutoinDevCar) Then
          FieldByName('DET_DEVCAR').Clear
        Else
          FieldByName('DET_DEVCAR').AsString := strAutoinDevCar;

        If (Not fEmptyStr(fRetornaInc_PD)) Then
          FieldByName('DET_INC_PD').AsString := fRetornaInc_PD;

        FieldByName('DET_VIPIBF').AsFloat := fltValIpiEntFut;
        FieldByName('DET_VRETBF').AsFloat := fltValRetEntFut;
        FieldByName('DET_VFSTBF').AsFloat := fltValFcpSTEntFut;
        FieldByName('DET_ATODDF').AsString := IIF(blnAtoDeclaratorioDF, 'S', 'N');
        FieldByName('DET_MDESST').AsString := strMDesST;
        FieldByName('DET_VDESST').AsFloat  := fltVDesST;
        FieldByName('DET_VFCPOP').AsFloat  := fltVFCPOP;
        FieldByName('DET_VFCPDF').AsFloat  := fltVFCPDF;
        FieldByName('DET_REMFIL').AsInteger := intRemFil;
        FieldByName('DET_FILFUL').AsInteger := IIF(blnFilFul, 1, 0);

        FieldByName('DET_BAIDEV').AsString := IIF(blnBaiDev, 'S', 'N');

        If (Not fEmptyStr(strFilFul_EntSai)) Then
          FieldByName('DET_FULE_S').AsString := strFilFul_EntSai;

        If (Not fEmptyStr(strIncOri)) Then
          FieldByName('DET_INCORI').AsString := strIncOri;

        FieldByName('DET_FULDIF').Value := Null;

        If (Not fEmptyStr(strFulDif)) Then
          FieldByName('DET_FULDIF').AsString := strFulDif;

        If (Not fEmptyStr(strClaFat)) Then
          FieldByName('DET_CLAFAT').AsString := strClaFat;

        If (Not fEmptyStr(strCodCmg)) Then
          FieldByName('DET_CODCMG').AsString := strCodCmg;

        FieldByName('DET_BIMRET').AsFloat  := fltBimRet;
        FieldByName('DET_AIMRET').AsFloat  := fltAimRet;
        FieldByName('DET_VIMRET').AsFloat  := fltVimRet;

        TBatchHelper.PostOuAcumula(qryTblMovAux, 'MOVAUX', ABatch);   {Req. 456948}

      End;

      pGravaMecanicosItem('MOVDET', strAutInc, strCodIte, fltTotIte - fltDesEsp - fltSerRat, strCodMec, fltQtdIte);

      If (Not fEmptyStr(strRefCodCst)) Or (blnRefEspelhaDocumento And (Not fEmptyStr(strRefSelCst))) Then
      Begin
        {Req. 456948 - era With fCriaQuery anonimo. PostOuAcumula precisa da
         referencia do dataset, entao a query passou a ter nome.}
        qryTblMovRef := fCriaQuery;
        With qryTblMovRef Do
        Try
          SQL.Text := 'SELECT * FROM MOVREF WHERE FALSE';
          Open;
          Insert;
          FieldByName('REF_SEQGER').AsString  := strAutInc;
          FieldByName('REF_CODCST').AsString  := strRefCodCst;
          FieldByName('REF_CLATRI').AsString  := strRefClaTri;
          FieldByName('REF_VALOPE').AsFloat   := fltRefValOpe;
          FieldByName('REF_BASCAL').AsFloat   := fltRefBasCal;
          FieldByName('REF_CBSALQ').AsFloat   := fltRefCbsAlq;
          FieldByName('REF_CBSALD').AsFloat   := fltRefCbsAlD;
          FieldByName('REF_CBSVLD').AsFloat   := fltRefCbsVlD;
          FieldByName('REF_CBSALR').AsFloat   := fltRefCbsAlR;
          FieldByName('REF_CBSVLT').AsFloat   := fltRefCbsVlT;
          FieldByName('REF_CBSALE').AsFloat   := fltRefCbsAlE;
          FieldByName('REF_CBSVAL').AsFloat   := fltRefCbsVal;
          FieldByName('REF_IBSUFA').AsFloat   := fltRefIbsUfA;
          FieldByName('REF_IBSUFD').AsFloat   := fltRefIbsUfD;
          FieldByName('REF_IBSUVD').AsFloat   := fltRefIbsUvD;
          FieldByName('REF_IBSUFR').AsFloat   := fltRefIbsUfR;
          FieldByName('REF_IBSUFT').AsFloat   := fltRefIbsUfT;
          FieldByName('REF_IBSUFE').AsFloat   := fltRefIbsUfE;
          FieldByName('REF_IBSUFV').AsFloat   := fltRefIbsUfV;
          FieldByName('REF_IBSMNA').AsFloat   := fltRefIbsMnA;
          FieldByName('REF_IBSMND').AsFloat   := fltRefIbsMnD;
          FieldByName('REF_IBSMVD').AsFloat   := fltRefIbsMvD;
          FieldByName('REF_IBSMNR').AsFloat   := fltRefIbsMnR;
          FieldByName('REF_IBSMNT').AsFloat   := fltRefIbsMnT;
          FieldByName('REF_IBSMNE').AsFloat   := fltRefIbsMnE;
          FieldByName('REF_IBSMNV').AsFloat   := fltRefIbsMnV;
          If Not fEmptyStr(strRefSelCst) Then
          Begin
            FieldByName('REF_SELCST').AsString := strRefSelCst;
            FieldByName('REF_SELCLA').AsString := strRefSelCla;
            FieldByName('REF_SELBAS').AsFloat  := fltRefSelBas;
            FieldByName('REF_SELALQ').AsFloat  := fltRefSelAlq;
            FieldByName('REF_SELVAL').AsFloat  := fltRefSelVal;
          End;
          FieldByName('REF_TRIREG').AsString  := strRefTriReg;
          FieldByName('REF_CREPRE').AsString  := strRefCrePre;
          FieldByName('REF_MONOFA').AsString  := strRefMonoFa;
          FieldByName('REF_VALIBS').AsFloat   := fltRefValIbs;
          If Not fEmptyStr(strRefCesBas) Then
            FieldByName('REF_CESBAS').AsString := strRefCesBas;
          If Not fEmptyStr(strRefCstReg) Then
          Begin
            FieldByName('REF_CSTREG').AsString := strRefCstReg;
            FieldByName('REF_CLAREG').AsString := strRefClaReg;
            FieldByName('REF_AIUREG').AsFloat  := fltRefAiuReg;
            FieldByName('REF_TIUREG').AsFloat  := fltRefTiuReg;
            FieldByName('REF_AIMREG').AsFloat  := fltRefAimReg;
            FieldByName('REF_TIMREG').AsFloat  := fltRefTimReg;
            FieldByName('REF_CBSREG').AsFloat  := fltRefCbsReg;
            FieldByName('REF_TCBREG').AsFloat  := fltRefTcbReg;
          End;
          TBatchHelper.PostOuAcumula(qryTblMovRef, 'MOVREF', ABatch);   {Req. 456948}
        Finally
          FreeAndNil(qryTblMovRef);
        End;
      End;

      If (strPromoc.Equals('S')) And (Not strCodPro.IsEmpty) Then
      Begin

        objPromocaoLimitePorClienteOuVenda := TPromocaoLimitePorClienteOuVenda.Create(strCodPro);

        Try
          objPromocaoLimitePorClienteOuVenda.pSetNumDoc(strNumDoc);
          objPromocaoLimitePorClienteOuVenda.pSetEspDoc(strEspDoc);
          objPromocaoLimitePorClienteOuVenda.pSetEmpDoc(strCodEmp);
          objPromocaoLimitePorClienteOuVenda.pSetCodCli(strCodCli);
          objPromocaoLimitePorClienteOuVenda.pSetCodIte(strCodIte);
          objPromocaoLimitePorClienteOuVenda.pSetQtdVen(fltQtdIte);
          objPromocaoLimitePorClienteOuVenda.pGravar;
        Finally
          FreeAndNil(objPromocaoLimitePorClienteOuVenda);
        End;

      End;

      If strPromoc.Equals('S') And ((fEmptyStr(strNum_Pd)) Or ((strEsp_Pd = 'OR') And (fCfgSis('DOCPRO', varString) = '2'))) Then
        TUpdatePromo.New(
          TParametrosPromocao.New()
            .CodIte(strCodIte)
            .CodEmp(strCodEmp)
            .CodCli(strCodCli)
            .TabPre(strTabPre)
            .NumOrc(strNum_Pd)
            .EspOrc(strEsp_Pd)
            .LevantarExcecao(True)
          ).fAtualizaQtdDisponivel();

      If (strEspDoc <> 'AJ') And (strOriDoc = 'V') Then
      Begin
        LEntregaFutura := (strEntFut = 'S') Or (strDocFut <> '') Or (strIncFut <> '') Or (strColoranteDeEntregaFutura = 'S');

        If Assigned(objReprocessarSaldoItens) Then
          objReprocessarSaldoItens.AddItem(TItemReprocessarSaldo.New
                                             .Codigo(strCodIte)
                                             .Empresa(strCodEmp)
                                             .EhItemEntregaFutura(LEntregaFutura))
        Else
          ReprocessarItem(strCodIte, strCodEmp, LEntregaFutura);

        If Not strNum_Pd.IsEmpty Then
        Begin
          LEmpresas := fGetEmpresasReprocessarItemPedido(strNum_Pd, strEsp_Pd, strEmp_Pd, strCodIte);

          For LEmpresa In LEmpresas Do
          Begin
            If Assigned(objReprocessarSaldoItens) Then
              objReprocessarSaldoItens.AddItem(TItemReprocessarSaldo.New
                                                 .Codigo(strCodIte)
                                                 .Empresa(LEmpresa)
                                                 .EhItemEntregaFutura(LEntregaFutura))
            Else
              ReprocessarItem(strCodIte, LEmpresa, LEntregaFutura);
          End;

          SetLength(LEmpresas, 0);
        End;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        qryTblMovDet.Cancel;
        pMensagensErro(E.Message, '[fGravaMovDet]');
      End;
    End;

  Finally
    {Req. 456948-B - B10b. Libera SO o que esta chamada criou. Quando o dataset
     e o molde compartilhado, quem libera e pFechaMoldesMovDet - liberar aqui
     deixaria ponteiro pendurado para a linha seguinte.}
    If qryTblMovDet <> objMoldeMovDet Then
      FreeAndNil(qryTblMovDet);

    If qryTblMovTri <> objMoldeMovTri Then
      FreeAndNil(qryTblMovTri);

    If qryTblMovAux <> objMoldeMovAux Then
      FreeAndNil(qryTblMovAux);
  End;

End;

procedure pMarcaRomImp(strNumDoc, strEspDoc, strCodEmp, strTip_Fc: String; blnPrevia: Boolean = False);
var
  strSQL, strSQL2, strSQL3, strSQL5, strSQL6: String;
  blnExiste: Boolean;
  qryGenGer: TUniQuery;

begin

  qryGenGer := fCriaQuery;

  fStartTransaction;

  strSQL := '';
  strSQL := strSQL + ' SELECT                       ';
  strSQL := strSQL + '   GER_NUMDOC                 ';
  strSQL := strSQL + ' FROM                         ';
  strSQL := strSQL + '   ROMGERX                    ';
  strSQL := strSQL + ' WHERE                        ';
  strSQL := strSQL + '   GER_NUMDOC = :NUMDOC AND   ';
  strSQL := strSQL + '   GER_ESPDOC = :ESPDOC AND   ';
  strSQL := strSQL + '   GER_CODEMP = :CODEMP AND   ';
  strSQL := strSQL + '   GER_TIP_FC = :TIP_FC       ';

  strSQL2 := strSQL2 + ' UPDATE                     ';
  strSQL2 := strSQL2 + '    ROMGERX                 ';
  strSQL2 := strSQL2 + ' SET                        ';
  If blnPrevia Then
    strSQL2 := strSQL2 + '   GER_PRVIMP = "S"       '
  Else
    strSQL2 := strSQL2 + '   GER_ROMIMP = "SIM"     ';
  strSQL2 := strSQL2 + ' WHERE                      ';
  strSQL2 := strSQL2 + '   GER_NUMDOC = :NUMDOC AND ';
  strSQL2 := strSQL2 + '   GER_ESPDOC = :ESPDOC AND ';
  strSQL2 := strSQL2 + '   GER_CODEMP = :CODEMP AND ';
  strSQL2 := strSQL2 + '   GER_TIP_FC = :TIP_FC     ';

  strSQL3 := strSQL3 + ' UPDATE                     ';
  strSQL3 := strSQL3 + '    MOVGER                  ';
  strSQL3 := strSQL3 + ' SET                        ';
  If blnPrevia Then
    strSQL3 := strSQL3 + '   GER_PRVIMP = "S"       '
  Else
    strSQL3 := strSQL3 + '   GER_ROMIMP = "SIM"     ';
  strSQL3 := strSQL3 + ' WHERE                      ';
  strSQL3 := strSQL3 + '   GER_NUMDOC = :NUMDOC AND ';
  strSQL3 := strSQL3 + '   GER_ESPDOC = :ESPDOC AND ';
  strSQL3 := strSQL3 + '   GER_CODEMP = :CODEMP AND ';
  strSQL3 := strSQL3 + '   GER_TIP_FC = :TIP_FC     ';

  strSQL5 := strSQL5 + ' UPDATE                     ';
  strSQL5 := strSQL5 + '    FATGOR                  ';
  strSQL5 := strSQL5 + ' SET                        ';
  If blnPrevia Then
    strSQL5 := strSQL5 + '   FGO_PRVIMP = "S"       '
  Else
    strSQL5 := strSQL5 + '   FGO_ROMIMP = "SIM"     ';
  strSQL5 := strSQL5 + ' WHERE                      ';
  strSQL5 := strSQL5 + '   FGO_NUMDOC = :NUMDOC AND ';
  strSQL5 := strSQL5 + '   FGO_ESPDOC = :ESPDOC AND ';
  strSQL5 := strSQL5 + '   FGO_CODEMP = :CODEMP     ';

  strSQL6 := ReplaceStr(strSQL3, 'MOVGER', 'NOTGER');

  Try
    With qryGenGer Do
    Begin
      {***********************************************}
      {* VERIFICA SE EXISTE REGISTRO EM ROMGERX PARA *}
      {* MARCÁ-LO COM IMPRESSO                       *}
      {********************************************ER*}
      SQL.Text := strSQL;
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('TIP_FC').AsString := strTip_Fc;
      Open;

      blnExiste := (Not IsEmpty);

      If blnExiste Then
      Begin
        SQL.Text := strSQL2;
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('TIP_FC').AsString := strTip_Fc;
        ExecSQL;
      End;

      SQL.Text := strSQL3;
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('TIP_FC').AsString := strTip_Fc;
      ExecSQL;

      SQL.Text := strSQL6;
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('TIP_FC').AsString := strTip_Fc;
      ExecSQL;

      {***********************************************}
      {* ALTERA ROMIMP EM FATGOR PARA                *}
      {* MARCÁ-LO COM IMPRESSO                       *}
      {********************************************ER*}
      If Pos(strEspDoc,'PD_OR_') > 0 Then
      Begin
        SQL.Text := strSQL5;
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('CODEMP').AsString := strCodEmp;
        ExecSQL;
      End;
    End;

    fCommit;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[pMarcaRomImp]');
    End;
  End;

  FreeAndNil(qryGenGer);

end;

function fGravaMovMod(strNumDoc,
                      strEspDoc,
                      strCodEmp,
                      strCodCli,
                      strSerie_,
                      strCodMod: String;
                      fltValMod: Double;
                      strDocume: String;
                      fltValPag: Double;
                      strTipCar : String = '';
                      strCodRed : String = '';
                      strPixS_N : String = ''): Boolean;
  Var
    qryAux: TUniQuery;
begin

  Result := True;

  Try
    qryAux := fCriaQuery;

    qryAux.SQL.Add('INSERT INTO ');
    qryAux.SQL.Add('  MOVMOD ');
    qryAux.SQL.Add('( ');
    qryAux.SQL.Add('  MOD_NUMDOC, ');
    qryAux.SQL.Add('  MOD_ESPDOC, ');
    qryAux.SQL.Add('  MOD_CODEMP, ');
    qryAux.SQL.Add('  MOD_CODCLI, ');
    qryAux.SQL.Add('  MOD_SERIE_, ');
    qryAux.SQL.Add('  MOD_CODMOD, ');
    qryAux.SQL.Add('  MOD_VALMOD, ');
    qryAux.SQL.Add('  MOD_DOCUME, ');
    qryAux.SQL.Add('  MOD_VALPAG, ');
    qryAux.SQL.Add('  MOD_TIPCAR, ');
    qryAux.SQL.Add('  MOD_CODRED, ');
    qryAux.SQL.Add('  MOD_PIXS_N, ');
    qryAux.SQL.Add('  AUTOINCREM) ');
    qryAux.SQL.Add('VALUES ( ');
    qryAux.SQL.Add('  :NUMDOC, ');
    qryAux.SQL.Add('  :ESPDOC, ');
    qryAux.SQL.Add('  :CODEMP, ');
    qryAux.SQL.Add('  :CODCLI, ');
    qryAux.SQL.Add('  :SERIE_, ');
    qryAux.SQL.Add('  :CODMOD, ');
    qryAux.SQL.Add('  :VALMOD, ');
    qryAux.SQL.Add('  :DOCUME, ');
    qryAux.SQL.Add('  :VALPAG, ');
    qryAux.SQL.Add('  :TIPCAR, ');
    qryAux.SQL.Add('  :CODRED, ');
    qryAux.SQL.Add('  :PIXS_N, ');
    qryAux.SQL.Add('  :AUTINC) ');

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;
    qryAux.ParamByName('SERIE_').AsString := strSerie_;
    qryAux.ParamByName('CODMOD').AsString := strCodMod;
    qryAux.ParamByName('VALMOD').AsFloat  := fltValMod;
    qryAux.ParamByName('DOCUME').AsString := strDocume;
    qryAux.ParamByName('VALPAG').AsFloat  := fltValPag;
    qryAux.ParamByName('TIPCAR').AsString := strTipCar;
    qryAux.ParamByName('CODRED').AsString := strCodRed;
    qryAux.ParamByName('PIXS_N').AsString := strPixS_N;
    qryAux.ParamByName('AUTINC').AsString := fRetAutoIncrem('MOVMOD', strCodEmp);

    qryAux.ExecSQL;

    FreeAndNil(qryAux);
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravaMovMod]');
    End;
  End;

end;

function fRetNumPed(strTabela,
                    strNumDoc,
                    strEspDoc,
                    strCodEmp: String): String;
  Var
    qryAux: TUniQuery;
begin
  Result := '';

  If Pos(strTabela,'MOVDET_') <= 0 Then
    Exit;

  qryAux := fCriaQuery;

  strTabela := 'MOVGER';

  With qryAux Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT ');
    SQL.Add('  FGO_NUMDOC ');
    SQL.Add('FROM ');
    SQL.Add(' ' + strTabela + ' ');
    SQL.Add('  LEFT JOIN FATGOR ON FGO_TIPFAT = GER_ESPDOC AND FGO_NUMFAT = GER_NUMDOC AND FGO_EMPFAT = GER_CODEMP AND FGO_JAFATU = 1 ');
    SQL.Add('WHERE ');
    SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
    SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
    SQL.Add('  GER_CODEMP = :CODEMP     ');

    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;
    Result := FieldByName('FGO_NUMDOC').AsString;
  End;
  FreeAndNil(qryAux);
end;

function fCarregaItensPendenteSeparacao(cdsItensPendSeparacao: TUniClientDataSet; strCodEmp, strNumDoc, strEspDoc, strCodCli: String): Boolean;
  Var
    qryFdoSep: TUniQuery;
begin
  Result := False;
  If Not fCfgSis('AUTCEN', varBoolean) Then
    Exit;

  If Not fCfgSis('USAEXS', varBoolean) Then
    Exit;

  If strEspDoc <> 'PD' Then
    Exit;

  qryFdoSep := fCriaQuery;
  Try
    qryFdoSep.SQL.Add('SELECT CODITE,');
    qryFdoSep.SQL.Add('       SEQINC,');
    qryFdoSep.SQL.Add('       QTDITE ');
    qryFdoSep.SQL.Add('  FROM (SELECT FDO_CODITE AS CODITE,');
    qryFdoSep.SQL.Add('               FDO_SEQINC AS SEQINC,');
    qryFdoSep.SQL.Add('               SUM(FDO_QTDITE * IF(FDO_ENTSAI = "S", 1, -1)) AS QTDITE');
    qryFdoSep.SQL.Add('          FROM FDOSEP');
    qryFdoSep.SQL.Add('         WHERE FDO_CODEMP = :CODEMP');
    qryFdoSep.SQL.Add('           AND FDO_NUMDOC = :NUMDOC');
    qryFdoSep.SQL.Add('           AND FDO_PENDEN = 1');
    qryFdoSep.SQL.Add('         GROUP BY FDO_CODITE, FDO_SEQINC) TAB ');
    qryFdoSep.SQL.Add(' WHERE QTDITE <> 0');

    qryFdoSep.ParamByName('CODEMP').AsString := strCodEmp;
    qryFdoSep.ParamByName('NUMDOC').AsString := strNumDoc;
    qryFdoSep.Open;

    If qryFdoSep.IsEmpty Then
    Begin
      // Se for pedido com serviço então retorna True para exibir mensagem "SEM ITENS PENDENTES DE SEPARAÇÃO"
      If fTemServicoPD(strCodEmp, strNumDoc, strCodCli) Then
        Result := True;

      Exit;
    End;

    While Not qryFdoSep.Eof Do
    Begin
      cdsItensPendSeparacao.Append;
      cdsItensPendSeparacao.FieldByName('CODITE').AsString := qryFdoSep.FieldByName('CODITE').AsString;
      cdsItensPendSeparacao.FieldByName('SEQINC').AsString := qryFdoSep.FieldByName('SEQINC').AsString;
      cdsItensPendSeparacao.FieldByName('QTDITE').AsString := qryFdoSep.FieldByName('QTDITE').AsString;
      cdsItensPendSeparacao.Post;

      qryFdoSep.Next;
    End;

    Result := True;
  Finally
    FreeAndNil(qryFdoSep);
  End;
End;

{$IFNDEF LINUX}
procedure pCarregaItensLogSeparacaoImpressao(cdsLogSep: TUniClientDataSet; Var cdsImpLogSep: TUniClientDataSet; blnEnt_CD, blnLocFisEmpEmi: Boolean);
  Var
    strOrdSep: String;
    cdsLogSepTmp: TUniClientDataSet;
    fltQtdDigItem: Double;

  procedure pDefineLocalizacaoFisica;
    Var
      strCodIte: String;
      strNumLot: String;
      strEmpIte: String;

  begin
    With cdsLogSepTmp Do
    Begin
      First;
      While Not Eof Do
      Begin
        Edit;
        strCodIte := FieldByName('ITE_CODITE').AsString;
        strNumLot := FieldByName('ITE_NUMLOT').AsString;
        strEmpIte := FieldByName('ITE_EMPITE').AsString;

        If blnEnt_CD Then
        Begin
          FieldByName('ITE_LOCFIS').AsString :=
            fCampoTabela(fRetLocFisicaEmpCD(QuotedStr(strNumLot), 'CADITE.ITE_CODITE', QuotedStr(strEmpIte), False), 'CADITE', ['ITE_CODITE'], [strCodIte]);

          FieldByName('ITE_DESFIS').AsString :=
            fCampoTabela(fRetDesFisicaEmpCD(QuotedStr(strNumLot), 'CADITE.ITE_CODITE', QuotedStr(strEmpIte), False), 'CADITE', ['ITE_CODITE'], [strCodIte]);

        End

        Else If blnLocFisEmpEmi Then
        Begin
          FieldByName('ITE_LOCFIS').AsString :=
            fCampoTabela(fRetLocFisicaEmpEmissora(QuotedStr(strNumLot), 'CADITE.ITE_CODITE', QuotedStr(strEmpIte), False), 'CADITE', ['ITE_CODITE'], [strCodIte]);

          FieldByName('ITE_DESFIS').AsString :=
            fCampoTabela(fRetDesFisicaEmpEmissora(QuotedStr(strNumLot), 'CADITE.ITE_CODITE', QuotedStr(strEmpIte), False), 'CADITE', ['ITE_CODITE'], [strCodIte]);

        End

        Else If fEmptyStr(strNumLot) Then
        Begin
          FieldByName('ITE_LOCFIS').AsString := fCampoTabela('ITE_LOCFIS', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, strEmpIte]);
          FieldByName('ITE_DESFIS').AsString := fCampoTabela('LOC_DESCRI', 'ITEGER LEFT JOIN CADLOC ON LOC_CODLOC = ITE_LOCFIS AND LOC_CODEMP = ITE_CODEMP', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, strEmpIte], False);
        End

        Else
        Begin
          FieldByName('ITE_LOCFIS').AsString := fCampoTabela('LOT_LOCFIS', 'CADLOT', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT'], [strCodIte, strEmpIte, strNumLot]);
          FieldByName('ITE_DESFIS').AsString := fCampoTabela('LOC_DESCRI', 'CADLOT LEFT JOIN CADLOC ON LOC_CODLOC = LOT_LOCFIS AND LOC_CODEMP = LOT_CODEMP', ['LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT'], [strCodIte, strEmpIte, strNumLot], False);
        End;

        Post;
        Next;
      End;
      First;
    End;
  end;

  procedure pInsereItensSeparacao;
    Var
      strCodIte,
      strNumLot,
      strEmpIte,
      strCodLse: String;
      fltMltVen: Double;

  begin
    With cdsLogSepTmp Do
    Begin
      First;

      While Not Eof Do
      Begin
        cdsImpLogSep.Append;

        strCodIte := FieldByName('ITE_CODITE').AsString;
        strNumLot := FieldByName('ITE_NUMLOT').AsString;
        strEmpIte := FieldByName('ITE_EMPITE').AsString;
        fltMltVen := fRetMltVenItem(strCodIte);

        cdsImpLogSep.FieldByName('CODITE').AsString := FieldByName('ITE_CODITE').AsString;
        cdsImpLogSep.FieldByName('TABPRE').AsString := FieldByName('ITE_TABPRE').AsString;
        cdsImpLogSep.FieldByName('PROMOC').AsString := FieldByName('ITE_PROMOC').AsString;
        cdsImpLogSep.FieldByName('EMPITE').AsString := FieldByName('ITE_EMPITE').AsString;
        cdsImpLogSep.FieldByName('NUMLOT').AsString := FieldByName('ITE_NUMLOT').AsString;
        cdsImpLogSep.FieldByName('CODACA').AsString := FieldByName('ITE_CODACA').AsString;
        cdsImpLogSep.FieldByName('EMPACA').AsString := FieldByName('ITE_EMPACA').AsString;
        cdsImpLogSep.FieldByName('CODFAB').AsString := FieldByName('ITE_CODFAB').AsString;
        cdsImpLogSep.FieldByName('CODBAR').AsString := FieldByName('ITE_CODBAR').AsString;
        cdsImpLogSep.FieldByName('CLAIPI').AsString := FieldByName('ITE_CLAIPI').AsString;
        cdsImpLogSep.FieldByName('DESITE').AsString := FieldByName('ITE_DESITE').AsString;
        cdsImpLogSep.FieldByName('DESSIM').AsString := FieldByName('ITE_DESSIM').AsString;
        cdsImpLogSep.FieldByName('DESITE_M4').AsString := FieldByName('ITE_DESITE').AsString;
        cdsImpLogSep.FieldByName('REFERE').AsString := FieldByName('ITE_REFERE').AsString;
        cdsImpLogSep.FieldByName('QTDITE').AsFloat  := FieldByName('ITE_QTDITE').AsFloat;

        If fltMltVen > 0 Then
          cdsImpLogSep.FieldByName('QTDEMB').AsFloat := FieldByName('ITE_QTDITE').AsFloat / fltMltVen
        Else
          cdsImpLogSep.FieldByName('QTDEMB').AsFloat := 0.00;

        cdsImpLogSep.FieldByName('UNIDAD').AsString := FieldByName('ITE_SIGUNI').AsString;
        cdsImpLogSep.FieldByName('DESUNI').AsString := FieldByName('ITE_DESUNI').AsString;
        cdsImpLogSep.FieldByName('VALUNI').AsFloat  := FieldByName('ITE_UNITAR').AsFloat;
        cdsImpLogSep.FieldByName('UNIORI').AsFloat  := FieldByName('ITE_UNIORI').AsFloat;
        cdsImpLogSep.FieldByName('VALITE').AsFloat  := FieldByName('ITE_TOTITE').AsFloat;

        cdsImpLogSep.FieldByName('FDO_ESPDOC').AsString   := '';
        cdsImpLogSep.FieldByName('FDO_CODVEN').AsString   := '';
        cdsImpLogSep.FieldByName('FDO_CODVE2').AsString   := '';
        cdsImpLogSep.FieldByName('FDO_CODREP').AsString   := '';
        cdsImpLogSep.FieldByName('FDO_DTAENT').AsDateTime := VS_Date;
        cdsImpLogSep.FieldByName('FDO_CODEMP').AsString   := FieldByName('ITE_EMPITE').AsString;
        cdsImpLogSep.FieldByName('FDO_CODDIV').AsString   := '';

        cdsImpLogSep.FieldByName('CODREG').AsString := '';
        cdsImpLogSep.FieldByName('EMBALA').AsFloat  := FieldByName('ITE_EMBALA').AsFloat;
        cdsImpLogSep.FieldByName('MLTVEN').AsFloat  := fltMltVen;
        cdsImpLogSep.FieldByName('SALDOS').AsFloat  := FieldByName('ITE_SALDOS').AsFloat;
        cdsImpLogSep.FieldByName('MARDES').AsString := fRetNomeMarca(FieldByName('ITE_CODMAR').AsString);
        cdsImpLogSep.FieldByName('DESMAR').AsString := FieldByName('ITE_CODMAR').AsString + '-' + fRetNomeMarca(FieldByName('ITE_CODMAR').AsString);
        cdsImpLogSep.FieldByName('CODFIS').AsString := '';
        cdsImpLogSep.FieldByName('VALIPI').AsFloat  := FieldByName('ITE_VALIPI').AsFloat;
        cdsImpLogSep.FieldByName('VALRET').AsFloat  := FieldByName('ITE_VALRET').AsFloat;
        cdsImpLogSep.FieldByName('LOCFIS').AsString := FieldByName('ITE_LOCFIS').AsString;
        cdsImpLogSep.FieldByName('DESFIS').AsString := FieldByName('ITE_DESFIS').AsString;
        cdsImpLogSep.FieldByName('LOCSUP').AsString := fCampoTabela('ITE_LOCSUP', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, strEmpIte]);

        cdsImpLogSep.FieldByName('ENTRET').AsString := FieldByName('ITE_ENTRET').AsString;
        cdsImpLogSep.FieldByName('LOCRET').AsString := FieldByName('ITE_LOCRET').AsString;
        cdsImpLogSep.FieldByName('ENTFUT').AsString := FieldByName('ITE_ENTFUT').AsString;
        cdsImpLogSep.FieldByName('MOTFUT').AsString := FieldByName('ITE_MOTFUT').AsString;

        cdsImpLogSep.FieldByName('DESCON').AsFloat := IIF(FieldByName('ITE_DESCON').AsFloat < 0, 0, FieldByName('ITE_DESCON').AsFloat);
        cdsImpLogSep.FieldByName('TOTFRE').AsFloat := FieldByName('ITE_TOTFRE').AsFloat;
        cdsImpLogSep.FieldByName('DESESP').AsFloat := FieldByName('ITE_DESESP').AsFloat;
        cdsImpLogSep.FieldByName('UNIDIG').AsFloat := IIF(FieldByName('ITE_DESCON').AsFloat < 0, FieldByName('ITE_UNITAR').AsFloat, FieldByName('ITE_UNIDIG').AsFloat);

        cdsImpLogSep.FieldByName('ENTSAI').AsString := 'SAI';
        cdsImpLogSep.FieldByName('FDO_DESCRI').AsString := FieldByName('ITE_DESITE').AsString;

        If (fCfgSis('GRUSEP', VarString) = 'S') then
        Begin
          strCodLse := fCampoTabela('ITE_CODLSE', 'ITEGER', ['ITE_CODITE', 'ITE_CODEMP'], [strCodIte, strEmpIte]);
          cdsImpLogSep.FieldByName('SETOR_').AsString := fCampoTabela('LSE_DESCRI', 'CADLSE', ['LSE_codigo'], [strCodLse]);
        End
        Else
          cdsImpLogSep.FieldByName('SETOR_').AsString := LeftStr(cdsImpLogSep.FieldByName('LOCFIS').AsString, 1);

        cdsImpLogSep.FieldByName('COMPLE').AsString := FieldByName('ITE_COMPLE').AsString;

        If fCfgSis('VENMAD', varBoolean) Or fCfgSis('VENVID', varBoolean) Or fCfgSis('VENMTL', varBoolean) Then
        Begin
          cdsImpLogSep.FieldByName('QTDPEC').AsFloat  := FieldByName('ITE_QTDPEC').AsFloat;
          cdsImpLogSep.FieldByName('COMPEC').AsFloat  := FieldByName('ITE_COMPEC').AsFloat;
          cdsImpLogSep.FieldByName('LARPEC').AsFloat  := FieldByName('ITE_LARPEC').AsFloat;
          cdsImpLogSep.FieldByName('ESPPEC').AsFloat  := FieldByName('ITE_ESPPEC').AsFloat;
          cdsImpLogSep.FieldByName('APAREL').AsString := FieldByName('ITE_APAREL').AsString;
          cdsImpLogSep.FieldByName('BENEFI').AsString := FieldByName('ITE_BENEFI').AsString;
        End;

        cdsImpLogSep.Post;

        cdsLogSepTmp.Next;
      End;
    End;
  end;

begin

  cdsLogSepTmp := TUniClientDataSet.Create(nil);
  pCloneDataSet(cdsLogSepTmp, cdsLogSep);

  strOrdSep := fCfgSisL('ORDSEP');

  pDefineLocalizacaoFisica;

  With cdsLogSepTmp Do
  Begin
    First;

    While Not Eof Do
    Begin
      Edit;

      fltQtdDigItem := FieldByName('ITE_QTDITE').AsFloat;

      If FieldByName('ITE_STALOG').AsString = 'A' Then
      Begin
        If FieldByName('ITE_QTDITE').AsFloat > FieldByName('ITE_QTDANT').AsFloat Then
        Begin
          FieldByName('ITE_STALOG').AsString := 'I';
          FieldByName('ITE_QTDITE').AsFloat  := FieldByName('ITE_QTDITE').AsFloat - FieldByName('ITE_QTDANT').AsFloat;
        end
        Else
        If FieldByName('ITE_QTDITE').AsFloat < FieldByName('ITE_QTDANT').AsFloat Then
        Begin
          FieldByName('ITE_STALOG').AsString := 'E';
          FieldByName('ITE_QTDITE').AsFloat  := FieldByName('ITE_QTDANT').AsFloat - FieldByName('ITE_QTDITE').AsFloat;
        end;
      End
      Else If FieldByName('ITE_STALOG').AsString = 'E' Then
      Begin
        FieldByName('ITE_QTDITE').AsFloat := FieldByName('ITE_QTDANT').AsFloat;
      End;

      FieldByName('ITE_TOTITE').AsFloat := FieldByName('ITE_TOTITE').AsFloat / fltQtdDigItem * FieldByName('ITE_QTDITE').AsFloat;
      FieldByName('ITE_DESESP').AsFloat := FieldByName('ITE_DESESP').AsFloat / fltQtdDigItem * FieldByName('ITE_QTDITE').AsFloat;
      FieldByName('ITE_VALIPI').AsFloat := FieldByName('ITE_VALIPI').AsFloat / fltQtdDigItem * FieldByName('ITE_QTDITE').AsFloat;
      FieldByName('ITE_VALRET').AsFloat := FieldByName('ITE_VALRET').AsFloat / fltQtdDigItem * FieldByName('ITE_QTDITE').AsFloat;
      FieldByName('ITE_TOTFRE').AsFloat := FieldByName('ITE_TOTFRE').AsFloat / fltQtdDigItem * FieldByName('ITE_QTDITE').AsFloat;

      Post;
      Next;
    End;

    IndexFieldNames := 'AUTOINCREM';

    {**************************************************}
    {* FOI CRIADO NOVA ORDENAÇÃO PARA DOC. SEPARAÇÃO. *}
    {* E NÃO SE APLICOU AQUI POIS NÃO TEMOS TODAS AS  *}
    {* OPÇÕES CONFORME CONFIGURAÇÃO "".               *}
    {***********************************************MA*}

    If SameText(strOrdSep, '1') Then
      IndexFieldNames := 'ITE_DESITE;ITE_LOCFIS'
    Else If SameText(strOrdSep, '2') Then
      IndexFieldNames := 'ITE_LOCFIS;ITE_DESITE';

    Filtered := False;
    Filter   := 'ITE_STALOG = ''I''';
    Filtered := True;

    If Not IsEmpty Then
    Begin
      cdsImpLogSep.Append;
      cdsImpLogSep.FieldByName('DESITE').AsString     := '<<' + INF_RETIRAR_ALMOXARIFADO + '>>';
      cdsImpLogSep.FieldByName('DESSIM').AsString     := '<<' + INF_RETIRAR_ALMOXARIFADO + '>>';
      cdsImpLogSep.FieldByName('DESITE_M4').AsString  := '<<' + INF_RETIRAR_ALMOXARIFADO + '>>';
      cdsImpLogSep.FieldByName('FDO_DESCRI').AsString := '<<' + INF_RETIRAR_ALMOXARIFADO + '>>';
      cdsImpLogSep.Post;

      pInsereItensSeparacao;
    End;

    Filtered := False;
    Filter   := 'ITE_STALOG = ''E''';
    Filtered := True;

    If Not IsEmpty Then
    Begin
      cdsImpLogSep.Append;
      cdsImpLogSep.FieldByName('DESITE').AsString     := '<<' + INF_DEVOLVER_ALMOXARIFADO + '>>';
      cdsImpLogSep.FieldByName('DESSIM').AsString     := '<<' + INF_DEVOLVER_ALMOXARIFADO + '>>';
      cdsImpLogSep.FieldByName('DESITE_M4').AsString  := '<<' + INF_DEVOLVER_ALMOXARIFADO + '>>';
      cdsImpLogSep.FieldByName('FDO_DESCRI').AsString := '<<' + INF_DEVOLVER_ALMOXARIFADO + '>>';
      cdsImpLogSep.Post;

      pInsereItensSeparacao;
    End;

    Filtered := False;
    Filter   := '';
  End;

  FreeAndNil(cdsLogSepTmp);

end;
{$ENDIF}

procedure pPreencheCDSItensPendSeparacao(qryItens: TUniQuery; cdsItensPend, cdsImpLogSep: TUniClientDataSet; blnEnt_CD, blnLocFisEmpEmi: Boolean);
  const
    INF_ADICIONAL_ITEM = 'INFAD';
    INF_DEVOLVER_ALMOXARIFADO = 'PRODUTOS A DEVOLVER PARA O ALMOXARIFADO';
    INF_RETIRAR_ALMOXARIFADO  = 'PRODUTOS A RETIRAR DO ALMOXARIFADO';
    INF_SEM_ITENS_SEPARACAO   = 'SEM ITENS PENDENTES DE SEPARAÇÃO';
  Var
    cdsItens: TUniClientDataSet;
    strOrdSep: String;
    field: TField;
    fltProporcao: Double;
Begin

  // Se não houver itens pendentes, não precisa separar
  If cdsItensPend.IsEmpty Then
  Begin
    cdsImpLogSep.Append;
    cdsImpLogSep.FieldByName('DESITE').AsString     := '<<' + INF_SEM_ITENS_SEPARACAO + '>>';
    cdsImpLogSep.FieldByName('DESSIM').AsString     := '<<' + INF_SEM_ITENS_SEPARACAO + '>>';
    cdsImpLogSep.FieldByName('DESITE_M4').AsString  := '<<' + INF_SEM_ITENS_SEPARACAO + '>>';
    cdsImpLogSep.FieldByName('FDO_DESCRI').AsString := '<<' + INF_SEM_ITENS_SEPARACAO + '>>';
    cdsImpLogSep.Post;

    Exit;
  End;

  cdsItens := fCriaClientDatset(qryItens);
  Try
    cdsItens.First;
    // Ajusta a quantidade dos itens que estão no pedido
    While Not cdsItens.Eof Do
    Begin
      // Se não estiver no client de itens pendentes então apaga
      If Not cdsItensPend.Locate('CODITE;SEQINC', VarArrayOf([cdsItens.FieldByName('CODITE').AsString,
                                                              cdsItens.FieldByName('SEQINC').AsInteger]), []) Then
        cdsItens.Delete
      // Se estiver no client de itens pendentes, altera quantidade/valores
      Else
      Begin
        fltProporcao := Abs(cdsItensPend.FieldByName('QTDITE').AsFloat) / cdsItens.FieldByName('QTDITE').AsFloat;

        cdsItens.Edit;
        cdsItens.FieldByName('QTDITE').AsFloat := cdsItensPend.FieldByName('QTDITE').AsFloat;
        cdsItens.FieldByName('VALITE').AsFloat := cdsItens.FieldByName('VALITE').AsFloat * fltProporcao;
        cdsItens.FieldByName('DESESP').AsFloat := cdsItens.FieldByName('DESESP').AsFloat * fltProporcao;
        cdsItens.FieldByName('VALIPI').AsFloat := cdsItens.FieldByName('VALIPI').AsFloat * fltProporcao;
        cdsItens.FieldByName('VALRET').AsFloat := cdsItens.FieldByName('VALRET').AsFloat * fltProporcao;
        cdsItens.FieldByName('TOTFRE').AsFloat := cdsItens.FieldByName('TOTFRE').AsFloat * fltProporcao;
        cdsItens.Post;

        cdsItens.Next;
      End;
    End;

    // Adiciona os itens que não estão mais no pedido  (Devem retornar ao armazém)
    cdsItensPend.First;
    While Not cdsItensPend.Eof Do
    Begin
      If Not cdsItens.Locate('CODITE;SEQINC', VarArrayOf([cdsItensPend.FieldByName('CODITE').AsString,
                                                          cdsItensPend.FieldByName('SEQINC').AsInteger]), []) Then
      Begin
        cdsItens.Append;
        cdsItens.FieldByName('CODITE').AsString     := cdsItensPend.FieldByName('CODITE').AsString;
        cdsItens.FieldByName('DESITE').AsString     := fRetNomProduto(cdsItensPend.FieldByName('CODITE').AsString);
        cdsItens.FieldByName('DESSIM').AsString     := cdsItens.FieldByName('DESITE').AsString;
        cdsItens.FieldByName('DESITE_M4').AsString  := cdsItens.FieldByName('DESITE').AsString;
        cdsItens.FieldByName('FDO_DESCRI').AsString := cdsItens.FieldByName('DESITE').AsString;

        cdsItens.FieldByName('QTDITE').AsFloat      := cdsItensPend.FieldByName('QTDITE').AsFloat;

        cdsItens.Post;
      End;

      cdsItensPend.Next;
    End;

    strOrdSep := fCfgSis('ORDSEP');

    If SameText(strOrdSep, '1') Then
      cdsItens.IndexFieldNames := 'DESITE;LOCFIS'
    Else If SameText(strOrdSep, '2') Then
      cdsItens.IndexFieldNames := 'LOCFIS;DESITE';

    cdsItens.Filtered := False;
    cdsItens.Filter := 'QTDITE > 0';
    cdsItens.Filtered := True;

    If Not cdsItens.IsEmpty Then
    Begin
      cdsImpLogSep.Append;
      cdsImpLogSep.FieldByName('DESITE').AsString     := '<<' + INF_RETIRAR_ALMOXARIFADO + '>>';
      cdsImpLogSep.FieldByName('DESSIM').AsString     := '<<' + INF_RETIRAR_ALMOXARIFADO + '>>';
      cdsImpLogSep.FieldByName('DESITE_M4').AsString  := '<<' + INF_RETIRAR_ALMOXARIFADO + '>>';
      cdsImpLogSep.FieldByName('FDO_DESCRI').AsString := '<<' + INF_RETIRAR_ALMOXARIFADO + '>>';
      cdsImpLogSep.Post;

      // Passa todos os campos dos itens para o client de log
      cdsItens.First;
      While Not cdsItens.Eof Do
      Begin
        cdsImpLogSep.Append;
        For field In cdsItens.Fields Do
        Begin
          If cdsImpLogSep.Fields.FindField(field.FieldName) <> Nil Then
            cdsImpLogSep.FieldByName(field.FieldName).Value := field.Value;
        End;
        cdsImpLogSep.Post;

        cdsItens.Next;
      End;
    End;

    cdsItens.Filtered := False;
    cdsItens.Filter := 'QTDITE < 0';
    cdsItens.Filtered := True;

    If Not cdsItens.IsEmpty Then
    Begin
      cdsImpLogSep.Append;
      cdsImpLogSep.FieldByName('DESITE').AsString     := '<<' + INF_DEVOLVER_ALMOXARIFADO + '>>';
      cdsImpLogSep.FieldByName('DESSIM').AsString     := '<<' + INF_DEVOLVER_ALMOXARIFADO + '>>';
      cdsImpLogSep.FieldByName('DESITE_M4').AsString  := '<<' + INF_DEVOLVER_ALMOXARIFADO + '>>';
      cdsImpLogSep.FieldByName('FDO_DESCRI').AsString := '<<' + INF_DEVOLVER_ALMOXARIFADO + '>>';
      cdsImpLogSep.Post;

      // Passa todos os campos dos itens para o client de log
      cdsItens.First;
      While Not cdsItens.Eof Do
      Begin
        cdsImpLogSep.Append;
        For field In cdsItens.Fields Do
        Begin
          If cdsImpLogSep.Fields.FindField(field.FieldName) <> Nil Then
          Begin
            cdsImpLogSep.FieldByName(field.FieldName).Value := field.Value;

            If field.FieldName = 'QTDITE' Then
              cdsImpLogSep.FieldByName(field.FieldName).Value := Abs(cdsImpLogSep.FieldByName(field.FieldName).Value);
          End;
        End;
        cdsImpLogSep.Post;

        cdsItens.Next;
      End;
    End;
  Finally
    cdsItens.Free;
  End;

end;

function fGravaMovInf( var strAutInc : String;
                       strSeqGer : String;
                       strInfCpl : String ):Boolean;
  Var
    qryMovInf : TUniQuery;
Begin
  Try
    qryMovInf := fCriaQuery;
    qryMovInf.SQL.Text := 'SELECT * FROM MOVINF WHERE FALSE';
    With qryMovInf Do
    Begin
      Open;
      Insert;

      strAutInc := fRetAutoIncrem('MOVINF', VS_strCodEmp);

      FieldByName('AUTOINCREM').AsString := strAutInc;
      FieldByName('MOV_SEQGER').AsString := strSeqGer;
      FieldByName('Z03_INFCPL').AsString := strInfCpl;

      Post;
      Result := True;
    End;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGravaMovGer]');
      Result := False;
    End;
  End;
  FreeAndNil(qryMovInf)

End;

function fAtualizaCnfNfeMovNotObs(strNumDoc, strEspDoc, strCodEmp, strValAdicCnfCom, strValAdicCnfFis: String): Boolean;
  Var
    qryMovObs : TUniQuery;
    strIncMovGer : String;
    strIncNotGer : String;
begin
  qryMovObs := fCriaQuery(Nil);
  Try
    Try
      strIncNotGer := '';
      strIncMovGer := fCampoTabela('AUTOINCREM', 'MOVGER' , ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [strNumDoc, strEspDoc, strCodEmp]);

      If fEmptyStr(strIncMovGer) Then
        strIncNotGer := fCampoTabela('AUTOINCREM', 'NOTGER' , ['GER_NUMDOC', 'GER_ESPDOC', 'GER_CODEMP'], [strNumDoc, strEspDoc, strCodEmp]);

      If (Not fEmptyStr(strIncMovGer)) Or (Not fEmptyStr(strIncNotGer)) Then
      Begin
        With qryMovObs Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add('SELECT * ');
          SQL.Add('  FROM ' + IIF(fEmptyStr(strIncMovGer), 'NOTOBS', 'MOVOBS'));
          SQL.Add(' WHERE MOV_SEQGER = ' + QuotedStr(strIncMovGer + strIncNotGer));
          Open;

          If (Not IsEmpty) Then
          Begin
            Edit;
            If (Not fEmptyStr(strValAdicCnfCom)) Then
            Begin
              FieldByName('MOV_OBSERV').AsString := FieldByName('MOV_OBSERV').AsString + strValAdicCnfCom + #13#10;
              FieldByName('MOV_CNFNFE').AsString := FieldByName('MOV_CNFNFE').AsString + strValAdicCnfCom + #13#10;
            End;
            If (Not fEmptyStr(strValAdicCnfFis)) Then
            Begin
              FieldByName('MOV_OBSFIS').AsString := FieldByName('MOV_OBSFIS').AsString + strValAdicCnfFis + #13#10;
              FieldByName('MOV_CNFFIS').AsString := FieldByName('MOV_CNFFIS').AsString + strValAdicCnfFis + #13#10;
            End;
            Post;
          End;

          Close;
        End;
      End;

      Result := True;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fAtualizaCnfNfeMovObs]');
      End;
    End;
  Finally
    FreeAndNil(qryMovObs);
  End;
end;

procedure fGravaGERCND(strAutInc: String; arrDuplic: TarrDuplicata );
Var
  qryGerCnd: TUniQuery;
  intContador: Integer;
Begin
  Try
    qryGerCnd := fCriaQuery(Nil);

    With qryGerCnd, SQL Do
    Begin
      Add('SELECT * FROM GERCND ');
      Add('WHERE FALSE');

      Open;

      For intContador := Low(arrDuplic) To High(arrDuplic) Do
      Begin
        If arrDuplic[intContador].curValor > 0 Then
        Begin
          qryGerCnd.Insert;
          FieldByName('GER_SEQGER').AsString := strAutInc;
          FieldByName('GER_PARCEL').AsString := arrDuplic[intContador].strSequen;
          FieldByName('GER_VALPAR').AsFloat  := arrDuplic[intContador].curValor;
          qryGerCnd.Post;
        End;
      End;

    End;

  Finally
    FreeAndNil(qryGerCnd);
  End;
End;

procedure pAjustaEstoqueExterno(strCodEmp, strCodIte, strCodExt, strClaFis, strChaAce, strHubMkp: String; fltQtdIte: Double);
Var
  qryAux : TUniQuery;
  LEntradaSaida : String;
  LFulfillmentRegrasMovimentacaoEstoque : FulfillmentRegrasMovimentacaoEstoque;

  function fEhOperacaoApenasDeMovimentacaoSemRegraDefinida : Boolean;
  begin

    Result := False;

    If Not AnsiMatchText(strClaFis, ['1999', '5999']) Then
      Exit;

    Result := True;

  end;

begin

  If fEhOperacaoApenasDeMovimentacaoSemRegraDefinida Then
  Begin

    LEntradaSaida := IIF(strClaFis.Equals('1999'), 'E', 'S');

  End
  Else Begin

    LFulfillmentRegrasMovimentacaoEstoque := FulfillmentMovimentacaoEstoque(strClaFis, strChaAce, strHubMkp);

    If (Not LFulfillmentRegrasMovimentacaoEstoque.MovimentaEstoqueExterno) Then
      Exit;

    LEntradaSaida := LFulfillmentRegrasMovimentacaoEstoque.EntradaSaida;

  End;

  qryAux := fCriaQuery;

  try
    qryAux.SQL.Add('SELECT * FROM ESTEXT');
    qryAux.SQL.Add(' WHERE EXT_CODITE = :CODITE');
    qryAux.SQL.Add('   AND EXT_CODEMP = :CODEMP');
    qryAux.SQL.Add('   AND EXT_CODEEE = :CODEEE');

    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODEEE').AsString := strCodExt;
    qryAux.Open;

    if qryAux.IsEmpty then
    begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('INSERT INTO ESTEXT(');
      qryAux.SQL.Add('  AUTOINCREM,');
      qryAux.SQL.Add('  EXT_CODITE,');
      qryAux.SQL.Add('  EXT_CODEMP,');
      qryAux.SQL.Add('  EXT_CODEEE,');
      qryAux.SQL.Add('  EXT_SALDO_)');
      qryAux.SQL.Add('VALUES(');
      qryAux.SQL.Add('  :AUTINC,');
      qryAux.SQL.Add('  :CODITE,');
      qryAux.SQL.Add('  :CODEMP,');
      qryAux.SQL.Add('  :CODEEE,');
      qryAux.SQL.Add('  :SALDO_)');

      qryAux.ParamByName('AUTINC').AsString := fRetAutoIncrem('ESTEXT', strCodEmp);
      qryAux.ParamByName('CODITE').AsString := strCodIte;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ParamByName('CODEEE').AsString := strCodExt;

      If LEntradaSaida.Equals('E') Then
        qryAux.ParamByName('SALDO_').AsFloat := + fltQtdIte
      Else
        qryAux.ParamByName('SALDO_').AsFloat := - fltQtdIte;

      qryAux.ExecSQL;
    end
    else
    begin
      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('UPDATE ESTEXT SET');

      If LEntradaSaida.Equals('E') Then
        qryAux.SQL.Add('EXT_SALDO_ = IFNULL(EXT_SALDO_, 0) + :QTDITE')
      Else
        qryAux.SQL.Add('EXT_SALDO_ = IFNULL(EXT_SALDO_, 0) - :QTDITE');

      qryAux.SQL.Add('WHERE EXT_CODITE = :CODITE');
      qryAux.SQL.Add('  AND EXT_CODEMP = :CODEMP');
      qryAux.SQL.Add('  AND EXT_CODEEE = :CODEEE');

      qryAux.ParamByName('CODITE').AsString := strCodIte;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ParamByName('CODEEE').AsString := strCodExt;
      qryAux.ParamByName('QTDITE').AsFloat  := fltQtdIte;

      qryAux.ExecSQL;
    end;

    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE ITEGER SET');

    If LEntradaSaida.Equals('E') Then
      qryAux.SQL.Add('ITE_SALEXT = IFNULL(ITE_SALEXT, 0) + :QTDITE')
    Else
      qryAux.SQL.Add('ITE_SALEXT = IFNULL(ITE_SALEXT, 0) - :QTDITE');

    qryAux.SQL.Add('WHERE ITE_CODITE = :CODITE');
    qryAux.SQL.Add('  AND ITE_CODEMP = :CODEMP ');

    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('QTDITE').AsFloat  := fltQtdIte;

    qryAux.ExecSQL;

    If fTabelaExiste('RESERVA_SALDO_ATUALIZAR', True) Then
    Begin
      {$IFNDEF LINUX}untFuncoesSimples.{$ENDIF}
        fExecutaSQL('REPLACE INTO RESERVA_SALDO_ATUALIZAR (CODITE, CODEMP, CAMRES, DTAINC) VALUES ' +
        '("' + strCodIte + '", "' + strCodEmp + '", "SALEXT", ' + fCurrentDateTime(VS_Date + fTime()) + ')', True);
    End;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure pAtualizaIndiceNFEConformeOrdenacao(strSEQGER, strTabela: String);
  Var
    strSQL, strSQLUpd, strOrdenacao : string;
    qryDados, qryUpdate: TUniQuery;

Begin
  strOrdenacao := fCfgSis('ORDALF', varString);

  strSQL := 'SET @INDICE = 0;                                       '+
            'SELECT @INDICE := @INDICE +  1 AS INDICE, T.DET_SEQGER '+
            'FROM MOVDET D                                          '+
            'JOIN MOVTRI T ON D.AUTOINCREM = T.DET_SEQGER           '+
            'LEFT JOIN CADUNI AS UV ON UV.UNI_CODUNI = DET_UNIDAD   '+
            'WHERE D.DET_SEQGER = :SEQGER';

  strSQLUpd := ' UPDATE MOVTRI '+
               ' SET '+
               ' DET_NITEM_ = :INDICE '+
               ' WHERE  DET_SEQGER = :SEQGER';

  qryDados := fCriaQuery(Nil);
  qryUpdate := fCriaQuery(Nil);

  If (strTabela <> 'MOVDET') Then
  Begin
    strSQL := AnsiReplaceStr(strSQL, 'MOVDET', 'NOTDET');
    strSQL := AnsiReplaceStr(strSQL, 'MOVTRI', 'NOTTRI');
    strSQLUpd := AnsiReplaceStr(strSQLUpd, 'MOVTRI', 'NOTTRI');
  End;

  Try
    qrydados.Sql.Text := strSQL;
    qryUpdate.Sql.Text := strSQLUpd;

    If (strOrdenacao = 'A') Then      //ORDEM (A)LFABETICA
      qryDados.SQL.Add('  ORDER BY DET_DESCRI, D.AUTOINCREM ')
    Else If (strOrdenacao = 'C') Then //ORDEM (C)ODIGO DO ITEM
      qryDados.SQL.Add('  ORDER BY DET_CODITE, D.AUTOINCREM ')
    Else If (strOrdenacao = 'U') Then //ORDEM (U)NIDADE + DESCRIÇÃO
      qryDados.SQL.Add('  ORDER BY UNI_SIGUNI, DET_DESCRI, D.AUTOINCREM ')
    Else If (strOrdenacao = 'F') Then // ORDEM (F)ORNECEDOR DO ITEM
      qryDados.SQL.Add('  ORDER BY DET_FORITE, D.AUTOINCREM ')
    Else If (strOrdenacao = 'L') Then // ORDEM (L)OCALIZACAO FISICA
      qryDados.SQL.Add('  ORDER BY DET_LOCFIS, D.AUTOINCREM ')
    Else If (strOrdenacao = 'P') Then // ORDEM (P)ESO UNIDADE + UNIDADE + DESCRIÇÃO DO PRODUTO
      qryDados.SQL.Add('  ORDER BY UNI_PESLIT, UNI_SIGUNI, DET_DESCRI, D.AUTOINCREM ');

    qryDados.ParamByName('SEQGER').AsString := strSEQGER;

    qryDados.Open;

    If (Not qryDados.IsEmpty) Then
    Begin

      qryDados.First;
      While (Not qryDados.Eof) Do
      Begin;
        qryUpdate.ParamByName('INDICE').AsInteger := qryDados.FieldByName('INDICE').AsInteger;
        qryUpdate.ParamByName('SEQGER').AsString := qryDados.FieldByName('DET_SEQGER').AsString;
        qryUpdate.ExecSQL;
        qryDados.Next;
      End;
    End;

  Finally
    FreeAndNil(qryUpdate);
    FreeAndNil(qryDados);
  End;
End;

procedure pGravarVinculacaoDocumentoComodatoCilindroVasilhameMovGer(
  strAutInc: String; const strEspDoc: String);
var
  strSql       : String;
  strAutIcv    : String;
  strGerAutInc : String;
  blnAtualizar : Boolean;
  qryConsulta  : TUniQuery;
  qryGravacao  : TUniQuery;
begin
  If (Not fCfgSis('CDTCLV', varBoolean)) Or
     (Pos(strEspDoc, 'FF_IF_NF_') = 0) Then
    Exit;

  qryConsulta := fCriaQuery();
  qryGravacao := fCriaQuery();

  Try
    blnAtualizar := False;

    strSql := 'SELECT '
            + '       M.AUTOINCREM AS GER_AUTINC '
            + '     , A.AUX_CILVAS '
            + '     , A.AUX_AUTICV '
            + '     , F.AUTOINCREM AS FGO_AUTINC '
            + '     , E.FGO_CILVAS '
            + '     , E.FGO_AUTICV '
            + '     , X.FGO_SEQFGO '
            + '     , X.FGO_CILVAS AS REL_CILVAS '
            + '     , G.AUTOINCREM AS REL_AUTINC '
            + '     , F.FGO_NUMDOC '
            + '  FROM FATGOR F '
            + ' INNER JOIN EXTGOR E ON E.FGO_SEQFGO = F.AUTOINCREM '
            + ' INNER JOIN MOVGER M ON M.GER_NUMDOC = F.FGO_NUMFAT '
            + '                    AND M.GER_ESPDOC = F.FGO_TIPFAT '
            + '                    AND M.GER_CODEMP = F.FGO_EMPFAT '
            + ' INNER JOIN AUXMOV A ON A.AUX_SEQGER = M.AUTOINCREM '
            + '  LEFT JOIN EXTGOR X ON X.FGO_AUTICV = F.AUTOINCREM '
            + '  LEFT JOIN FATGOR T ON T.AUTOINCREM = X.FGO_SEQFGO '
            + '  LEFT JOIN MOVGER G ON G.GER_NUMDOC = T.FGO_NUMFAT '
            + '                    AND G.GER_ESPDOC = T.FGO_TIPFAT '
            + '                    AND G.GER_CODEMP = T.FGO_EMPFAT ';

    qryConsulta.Close;
    qryConsulta.SQL.Text := strSql
                          + ' WHERE M.AUTOINCREM = :AUTINC ';
    qryConsulta.ParamByName('AUTINC').AsString := strAutInc;
    qryConsulta.Open;

    If Not ((qryConsulta.FieldByName('FGO_CILVAS').AsString = 'S') Or
            (qryConsulta.FieldByName('REL_CILVAS').AsString = 'S')) Then
      Exit;

    If (qryConsulta.FieldByName('FGO_CILVAS').AsString <> 'S') And
       (qryConsulta.FieldByName('REL_CILVAS').AsString = 'S') And
       (Not fEmptyStr(qryConsulta.FieldByName('REL_AUTINC').AsString)) Then
    Begin
      strAutIcv    := strAutInc;
      strAutInc    := qryConsulta.FieldByName('REL_AUTINC').AsString;
      blnAtualizar := True;
    End
    Else
    If (qryConsulta.FieldByName('FGO_CILVAS').AsString = 'S') And
       (qryConsulta.FieldByName('REL_CILVAS').AsString <> 'S') And
       (fEmptyStr(qryConsulta.FieldByName('REL_AUTINC').AsString)) Then
    Begin
      strGerAutInc := qryConsulta.FieldByName('FGO_AUTINC').AsString;

      qryConsulta.Close;
      qryConsulta.SQL.Text := strSql
                            + ' WHERE X.FGO_SEQFGO = :AUTINC ';
      qryConsulta.ParamByName('AUTINC').AsString := strGerAutInc;
      qryConsulta.Open;

      strAutIcv    := qryConsulta.FieldByName('GER_AUTINC').AsString;
      blnAtualizar := True;
    End;

    If fEmptyStr(strAutIcv) Then
      blnAtualizar := False;

    If blnAtualizar Then
    Begin
      qryGravacao.SQL.Text := 'UPDATE AUXMOV '
                            + '   SET AUX_AUTICV = :AUTICV '
                            + '     , AUX_CILVAS = :CILVAS '
                            + ' WHERE AUX_SEQGER = :SEQGER ';

      qryGravacao.ParambyName('SEQGER').AsString := strAutInc;
      qryGravacao.ParambyName('AUTICV').AsString := strAutIcv;
      qryGravacao.ParambyName('CILVAS').AsString := 'S';
      qryGravacao.ExecSql;
    End;
  Finally
    FreeAndNil(qryConsulta);
    FreeAndNil(qryGravacao);
  End;
end;

function fDocumentoExpedido(const strNumDoc, strEspDoc, strCodEmp : string) : Boolean;
  Var
    qryAux: TUniQuery;

Begin
  Result := False;
  qryAux := fCriaQuery;
  Try

    qryAux.SQL.Add('SELECT GER_DTLBEX                 ');
    qryAux.SQL.Add('  FROM MOVGER                     ');
    qryAux.SQL.Add(' WHERE GER_NUMDOC = :NUMDOC AND   ');
    qryAux.SQL.Add('       GER_ESPDOC = :ESPDOC AND   ');
    qryAux.SQL.Add('       GER_CODEMP = :CODEMP AND   ');
    qryAux.SQL.Add('       GER_DTLBEX IS NOT NULL AND ');
    qryAux.SQL.Add('       GER_TIP_FC = "C" AND       ');
    qryAux.SQL.Add('       GER_ORIDOC = "V"           ');

    qryAux.ParamByName('NUMDOC').AsString   := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString   := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString   := strCodEmp;

    qryAux.Open;

    If (Not qryAux.isEmpty()) Then
      Result := True;

    qryAux.Close;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function fGravaMovDetSimplificada(
                        Var strAutInc: String;
                        strSeqGer: String;
                        strNumDoc,
                        strEspDoc,
                        strCodEmp,
                        strCodIte,
                        strCodVen,
                        strCodDiv,
                        strCodMar,
                        strCodFor,
                        strCodCli: String;
                        dtaDtaEnt,
                        dtaHorEnt,
                        dtaDtaDoc: TDateTime;
                        strConPag,
                        strTip_Fc,
                        strEstado,
                        strDescri,
                        strRefere,
                        strUnidad,
                        strForIte: String;
                        fltQtdIte,
                        fltUnitar,
                        fltUniOri,
                        fltUniVis,
                        fltTotIte,
                        fltVlrCon,
                        fltTotCus,
                        fltTotMed,
                        fltDesCon,
                        fltTotFre,
                        fltDesEsp: Double;
                        strCodRep,
                        strCodVe2: String;
                        fltPerCom,
                        fltTotCom,
                        fltTotCo2: Double;
                        strClaFis,
                        strCodFis: String;
                        fltValIpi,
                        fltAlqIpi,
                        fltBasIpi,
                        fltValIcm,
                        fltAlqIcm,
                        fltBasIcm,
                        fltValRet,
                        fltAlqRet,
                        fltBasRet,
                        fltTotPes,
                        fltPerBas,
                        fltPerRed: Double;
                        blnJafatu: Boolean;
                        strTipFat,
                        strNumFat,
                        strEmpFat: String;
                        dtaDtaFat: TDateTime;
                        strVenFat,
                        strCndFat: String;
                        fltValFat: Double;
                        strIdePro,
                        strIncPis,
                        strSerie: String;
                        fltDesAce: Double;
                        strNotEsp,
                        strDocDev,
                        strEspDev,
                        strEmpDev,
                        strIteCha,
                        strIteTin,
                        strDesCor,
                        strTipEmb: String;
                        fltQtdEmb,
                        fltPreEmb: Double;
                        strTipPre: String;
                        fltPrvTin,
                        fltPrcTin,
                        fltFatTin: Double;
                        strProEmb,
                        strCodDig,
                        strCodCnd,
                        strCodFpg,
                        strIteEmb,
                        strGruEmb: String;
                        intLazQua: Integer;
                        strPromoc,
                        strSeqTin: String;
                        fltQtdPul: Double;
                        strPedCom,
                        strOriDoc,
                        strNum_Pd,
                        strEsp_Pd,
                        strEmp_Pd: String;
                        intInd_Pd: Integer;
                        strOrdPro,
                        strDesNes,
                        strCliFat: String;
                        fltBcaMin,
                        fltBcaCom,
                        fltVolPro: Double;
                        strCodAca,
                        strEmpAca: String;
                        blnProAca,
                        blnFilKar: Boolean;
                        strEspFut,
                        strDocFut,
                        strEmpFut,
                        strTabPre,
                        strEmpCom: String;
                        strLinha,
                        strCatali,
                        strCodDil: String;
                        fltPorDil: Double;
                        strDilCon: String;
                        fltPorCat,
                        fltUniDig,
                        fltQtdPon: Double;
                        strEntFut,
                        strMotFut: String;
                        dtaDtaFut: TDateTime;
                        fltTotCu2,
                        fltComRep,
                        fltPerRep: Double;
                        strKey_EP,
                        strNumLot,
                        strPigBas: String;
                        fltVaEIpi,
                        fltAlEIpi,
                        fltBaEIpi,
                        fltTotUlt,
                        fltImpUlt,
                        fltBaRtSP,
                        fltVaRtSP,
                        fltIcOpPr: Double;
                        intSeqCcr: Integer;
                        fltEmbala,
                        fltAlqPis,
                        fltBasPis,
                        fltValPis: Double;
                        strCSTPis: String;
                        fltAlqCof,
                        fltBasCof,
                        fltValCof: Double;
                        strCSTCof,
                        strCSTIpi,
                        strEnqIpi: String;
                        fltVaERet,
                        fltAlERet,
                        fltBaERet,
                        fltPesLiq: Double;
                        const objParams: TMovDetParams): Boolean;
Begin
  Result := fGravaMovDet(
               strAutInc,
               strSeqGer,
               strNumDoc,
               strEspDoc,
               strCodEmp,
               strCodIte,
               strCodVen,
               strCodDiv,
               strCodMar,
               strCodFor,
               strCodCli,
               dtaDtaEnt,
               dtaHorEnt,
               dtaDtaDoc,
               strConPag,
               strTip_Fc,
               strEstado,
               strDescri,
               strRefere,
               strUnidad,
               strForIte,
               fltQtdIte,
               fltUnitar,
               fltUniOri,
               fltUniVis,
               fltTotIte,
               fltVlrCon,
               fltTotCus,
               fltTotMed,
               fltDesCon,
               fltTotFre,
               fltDesEsp,
               strCodRep,
               strCodVe2,
               fltPerCom,
               fltTotCom,
               fltTotCo2,
               strClaFis,
               strCodFis,
               fltValIpi,
               fltAlqIpi,
               fltBasIpi,
               fltValIcm,
               fltAlqIcm,
               fltBasIcm,
               fltValRet,
               fltAlqRet,
               fltBasRet,
               fltTotPes,
               fltPerBas,
               fltPerRed,
               blnJafatu,
               strTipFat,
               strNumFat,
               strEmpFat,
               dtaDtaFat,
               strVenFat,
               strCndFat,
               fltValFat,
               strIdePro,
               strIncPis,
               strSerie,
               fltDesAce,
               strNotEsp,
               strDocDev,
               strEspDev,
               strEmpDev,
               strIteCha,
               strIteTin,
               strDesCor,
               strTipEmb,
               fltQtdEmb,
               fltPreEmb,
               strTipPre,
               fltPrvTin,
               fltPrcTin,
               fltFatTin,
               strProEmb,
               strCodDig,
               strCodCnd,
               strCodFpg,
               strIteEmb,
               strGruEmb,
               intLazQua,
               strPromoc,
               strSeqTin,
               fltQtdPul,
               strPedCom,
               strOriDoc,
               strNum_Pd,
               strEsp_Pd,
               strEmp_Pd,
               intInd_Pd,
               strOrdPro,
               strDesNes,
               strCliFat,
               fltBcaMin,
               fltBcaCom,
               fltVolPro,
               strCodAca,
               strEmpAca,
               blnProAca,
               blnFilKar,
               strEspFut,
               strDocFut,
               strEmpFut,
               strTabPre,
               strEmpCom,
               strLinha,
               strCatali,
               strCodDil,
               fltPorDil,
               strDilCon,
               fltPorCat,
               fltUniDig,
               fltQtdPon,
               strEntFut,
               strMotFut,
               dtaDtaFut,
               fltTotCu2,
               fltComRep,
               fltPerRep,
               strKey_EP,
               strNumLot,
               strPigBas,
               fltVaEIpi,
               fltAlEIpi,
               fltBaEIpi,
               fltTotUlt,
               fltImpUlt,
               fltBaRtSP,
               fltVaRtSP,
               fltIcOpPr,
               intSeqCcr,
               fltEmbala,
               fltAlqPis,
               fltBasPis,
               fltValPis,
               strCSTPis,
               fltAlqCof,
               fltBasCof,
               fltValCof,
               strCSTCof,
               strCSTIpi,
               strEnqIpi,
               fltVaERet,
               fltAlERet,
               fltBaERet,
               fltPesLiq,
               objParams.fltUniTab,
               objParams.strLot_TA,
               objParams.fltConFre,
               objParams.fltBasAnt,
               objParams.fltIcmAnt,
               objParams.fltVendor,
               objParams.fltOutDes,
               objParams.fltVlGnre,
               objParams.strGnrOri,
               objParams.fltOutIcm,
               objParams.fltIseIcm,
               objParams.fltFreSug,
               objParams.strCodMot,
               objParams.strNatPis,
               objParams.strNatCof,
               objParams.strSeqGad,
               objParams.fltOutVal,
               objParams.fltIcmSai,
               objParams.fltImpFed,
               objParams.fltDesOpe,
               objParams.fltQtdExp,
               objParams.strNumCmp,
               objParams.intNItCmp,
               objParams.fltDeDVCf,
               objParams.strCodMec,
               objParams.strAntPro,
               objParams.strAntFre,
               objParams.fltMedAnt,
               objParams.fltPreAnt,
               objParams.fltImpAnt,
               objParams.strSeqAnt,
               objParams.strRICMPR,
               objParams.fltComLiq,
               objParams.strNcmTin,
               objParams.fltValIva,
               objParams.strCliBus,
               objParams.strTurEnt,
               objParams.strIdeDev,
               objParams.fltPeBaST,
               objParams.fltVal_RT,
               objParams.fltDesCli,
               objParams.fltImpPag,
               objParams.fltTaxJur,
               objParams.fltSerRat,
               objParams.strProBri,
               objParams.fltPonBri,
               objParams.fltValDif,
               objParams.fltVaFrAn,
               objParams.strLotAba,
               objParams.fltFedImp,
               objParams.fltEstImp,
               objParams.fltMunImp,
               objParams.strIncDev,
               objParams.strBrinde,
               objParams.strCodPar,
               objParams.strTipBri,
               objParams.fltIcmOrg,
               objParams.strBaqtze,
               objParams.strIncFut,
               objParams.fltValFle,
               objParams.fltTaxEnt,
               objParams.fltVrdIcm,
               objParams.fltBasVrd,
               objParams.strMtdIcm,
               objParams.strBxSbIt,
               objParams.strIteAbf,
               objParams.strAtivac,
               objParams.intSeqCom,
               objParams.fltVICMDe,
               objParams.strNcmIte,
               objParams.fltComDig,
               objParams.fltPerDig,
               objParams.fltIcmPav,
               objParams.blnIcmSai,
               objParams.fltAlDifa,
               objParams.strAutSai,
               objParams.fltBFCPST,
               objParams.fltPFCPST,
               objParams.fltVFCPST,
               objParams.strDadSep,
               objParams.strAutEle,
               objParams.strNotUlt,
               objParams.fltPICMEF,
               objParams.fltBICMEF,
               objParams.fltAICMEF,
               objParams.fltVICMEF,
               objParams.fltBSTANT,
               objParams.fltVSTANT,
               objParams.strNotC17,
               objParams.fltAlq922,
               objParams.fltDesCnd,
               objParams.strProEsp,
               objParams.strCodPro,
               objParams.strInc_Pd,
               objParams.fltSICMEF,
               objParams.fltValTCI,
               objParams.fltCalTCI,
               objParams.fltVal_TS,
               objParams.strExtFul,
               objParams.strCodExt,
               objParams.fltFreMkp,
               objParams.fltComMkp,
               objParams.strAIdKitPromocao,
               objParams.strChaveAcesso,
               objParams.fltQtdCom,
               objParams.fltFreCot,
               objParams.AstrComplemento,
               objParams.strEmpCar,
               objParams.strAutoinDevCar,
               objParams.AfltBaseOperacaoPropriaICMSEntrada,
               objParams.AfltAliquotaOperacaoPropriaICMSEntrada,
               objParams.AfltValorOperacaoPropriaIMCSEntrada,
               objParams.fltFreRat,
               objParams.fltValIpiEntFut,
               objParams.fltValRetEntFut,
               objParams.fltValFcpSTEntFut,
               objParams.fltDesPis,
               objParams.blnClaRet,
               objParams.strOpSeEx,
               objParams.strConExp,
               objParams.strEmbExp,
               objParams.strObsExp,
               objParams.blnAtoDeclaratorioDF,
               objParams.strMovTriLocFis,
               objParams.fltVDesST,
               objParams.strMDesST,
               objParams.strNumDrw,
               objParams.strTipBus,
               objParams.strNumPla,
               objParams.strParNum,
               objParams.strReqCom,
               objParams.strNatOpe,
               objParams.fltRpaFre,
               objParams.fltPerRic,
               objParams.blnAltEst,
               objParams.intSeqPer,
               objParams.intDetItem,
               objParams.fltICMCFR,
               objParams.fltFreteCalc,
               objParams.fltFreConCalc,
               objParams.strPegou_,
               objParams.fltVFCPOP,
               objParams.fltVFCPDF,
               objParams.fltCubage,
               objParams.fltCfbIpi,
               objParams.fltCfaIpi,
               objParams.fltCfvIpi,
               objParams.strCipiOK,
               objParams.strDocIpi,
               objParams.strEspIpi,
               objParams.strEmpIpi,
               objParams.intRemFil,
               objParams.fltQtdRemFil,
               objParams.blnFulfillmentModoRobo,
               objParams.blnFilFul,
               objParams.blnBaiDev,
               objParams.strAutEnt,
               objParams.dtaDtaCmp,
               objParams.strFullHubMkp,
               objParams.fltOutValPD,
               objParams.strFilFul_EntSai,
               objParams.strIncOri,
               objParams.strTckQbt,
               objParams.strEntTri,
               objParams.strFulDif,
               objParams.strClaFat,
               objParams.fltICMNCR,
               objParams.fltFCPNCR,
               objParams.strColoranteDeEntregaFutura,
               objParams.strCbenef,
               objParams.strCodPre,
               objParams.fltBasPre,
               objParams.fltPerPre,
               objParams.fltValPre,
               objParams.strCodCmg,
               objParams.fltVimRet,
               objParams.dobQIcmsMonRet,
               objParams.dobAdBcMonRet,
               objParams.dobVrEmIcmsRet,
               objParams.fltValSeg,
               objParams.fltPerDif,
               objParams.fltAlqSTXML,
               objParams.fltCliDes,
               objParams.strRefCodCst,
               objParams.strRefClaTri,
               objParams.fltRefValOpe,
               objParams.fltRefBasCal,
               objParams.fltRefCbsAlq,
               objParams.fltRefCbsAlD,
               objParams.fltRefCbsVlD,
               objParams.fltRefCbsAlR,
               objParams.fltRefCbsVlT,
               objParams.fltRefCbsAlE,
               objParams.fltRefCbsVal,
               objParams.fltRefIbsUfA,
               objParams.fltRefIbsUfD,
               objParams.fltRefIbsUvD,
               objParams.fltRefIbsUfR,
               objParams.fltRefIbsUfT,
               objParams.fltRefIbsUfE,
               objParams.fltRefIbsUfV,
               objParams.fltRefIbsMnA,
               objParams.fltRefIbsMnD,
               objParams.fltRefIbsMvD,
               objParams.fltRefIbsMnR,
               objParams.fltRefIbsMnT,
               objParams.fltRefIbsMnE,
               objParams.fltRefIbsMnV,
               objParams.strRefSelCst,
               objParams.strRefSelCla,
               objParams.fltRefSelBas,
               objParams.fltRefSelAlq,
               objParams.fltRefSelVal,
               objParams.strRefTriReg,
               objParams.strRefCrePre,
               objParams.strRefMonoFa,
               objParams.fltRefValIbs,
               objParams.strRefCesBas,
               objParams.strRefCstReg,
               objParams.strRefClaReg,
               objParams.fltRefAiuReg,
               objParams.fltRefTiuReg,
               objParams.fltRefAimReg,
               objParams.fltRefTimReg,
               objParams.fltRefCbsReg,
               objParams.fltRefTcbReg,
               objParams.fltIcmPrd,
               objParams.fltSiscomex,
               objParams.strChvRef,
               objParams.strIteRef,
               objParams.ABatch
             );
End;

function fGravaDetCha(strAutInc: String;
                      fltQtdCha: Double;
                      fltMedB_L: Double;
                      fltMedB_A: Double;
                      fltMedL_L: Double;
                      fltMedL_A: Double;
                      fltEspess: Double): Boolean;
Var
  qryDetCha: TUniQuery;
begin
  qryDetCha := fCriaQuery();

  Try
    qryDetCha.SQL.Add('  INSERT INTO DETCHA (  ');
    qryDetCha.SQL.Add('    DET_SEQGER,         ');
    qryDetCha.SQL.Add('    DET_QTDCHA,         ');
    qryDetCha.SQL.Add('    DET_MEDB_L,         ');
    qryDetCha.SQL.Add('    DET_MEDB_A,         ');
    qryDetCha.SQL.Add('    DET_MEDL_L,         ');
    qryDetCha.SQL.Add('    DET_MEDL_A,         ');
    qryDetCha.SQL.Add('    DET_ESPESS          ');
    qryDetCha.SQL.Add('  ) VALUES (            ');
    qryDetCha.SQL.Add('    :SEQGER,            ');
    qryDetCha.SQL.Add('    :QTDCHA,            ');
    qryDetCha.SQL.Add('    :MEDB_L,            ');
    qryDetCha.SQL.Add('    :MEDB_A,            ');
    qryDetCha.SQL.Add('    :MEDL_L,            ');
    qryDetCha.SQL.Add('    :MEDL_A,            ');
    qryDetCha.SQL.Add('    :ESPESS)            ');


    qryDetCha.ParamByName('SEQGER').AsString := strAutInc;
    qryDetCha.ParamByName('QTDCHA').AsFloat  := fltQtdCha;
    qryDetCha.ParamByName('MEDB_L').AsFloat  := fltMedB_L;
    qryDetCha.ParamByName('MEDB_A').AsFloat  := fltMedB_A;
    qryDetCha.ParamByName('MEDL_L').AsFloat  := fltMedL_L;
    qryDetCha.ParamByName('MEDL_A').AsFloat  := fltMedL_A;
    qryDetCha.ParamByName('ESPESS').AsFloat  := fltEspess;

    qryDetCha.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryDetCha);
  End;
end;

function fRetornaDadosDetCha(strAutInc: String;
                             fltQtdIte: Double;
                             Out fltQtdCha: Double;
                             Out fltMedB_L: Double;
                             Out fltMedB_A: Double;
                             Out fltMedL_L: Double;
                             Out fltMedL_A: Double;
                             Out fltEspess: Double):Boolean;
Var
  qryDetCha: TUniQuery;
Begin
  Result := False;

  If fEmptyStr(strAutInc) Then
    Exit;

  If (fCfgSis('MARMOR', varString) = 'N') Then
    Exit;

  qryDetCha := fCriaQuery();
  Try
    qryDetCha.SQL.Add('  SELECT               ');
    qryDetCha.SQL.Add('    DET_MEDB_L,        ');
    qryDetCha.SQL.Add('    DET_MEDB_A,        ');
    qryDetCha.SQL.Add('    DET_MEDL_L,        ');
    qryDetCha.SQL.Add('    DET_MEDL_A,        ');
    qryDetCha.SQL.Add('    DET_ESPESS         ');
    qryDetCha.SQL.Add('  FROM                 ');
    qryDetCha.SQL.Add('    DETCHA             ');
    qryDetCha.SQL.Add('  WHERE                ');
    qryDetCha.SQL.Add('    DET_SEQGER=:AUTINC ');

    qryDetCha.ParamByName('AUTINC').AsString := strAutInc;
    qryDetCha.Open;

    If (Not qryDetCha.IsEmpty) Then
    Begin
      fltMedB_L := qryDetCha.FieldByName('DET_MEDB_L').AsFloat;
      fltMedB_A := qryDetCha.FieldByName('DET_MEDB_A').AsFloat;
      fltMedL_L := qryDetCha.FieldByName('DET_MEDL_L').AsFloat;
      fltMedL_A := qryDetCha.FieldByName('DET_MEDL_A').AsFloat;
      fltEspess := qryDetCha.FieldByName('DET_ESPESS').AsFloat;

      If (fltMedL_L = 0) Or (fltMedL_A = 0) Then
        fltQtdCha := 0
      Else
        fltQtdCha := fFormataFloat(fltQtdIte / (fltMedL_L * fltMedL_A), 4);

      Result := True;
    End;
  Finally
    FreeAndNil(qryDetCha);
  End;
End;

function fSetaOperadorESeparadorDaExpedicao(const strSepExp, strOpeExp, strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  Var
   qryAux : TUniQuery;
begin
  Result := True;
  qryAux := fCriaQuery;
  Try
    Try
      qryAux.SQL.Add('UPDATE ');
      qryAux.SQL.Add(' MOVGER ');
      qryAux.SQL.Add(' SET ');

      qryAux.SQL.Add('  GER_SEPEXP = :SEPEXP, ');
      qryAux.SQL.Add('  GER_OPEEXP = :OPEEXP  ');

      qryAux.SQL.Add(' WHERE ');
      qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('  GER_CODEMP = :CODEMP ');

      If fEmptyStr(strSepExp) Then
        qryAux.ParamByName('SEPEXP').Value := Null
      Else
        qryAux.ParamByName('SEPEXP').AsString := strSepExp;

      If fEmptyStr(strOpeExp) Then
        qryAux.ParamByName('OPEEXP').Value := Null
      Else
        qryAux.ParamByName('OPEEXP').AsString := strOpeExp;

      qryAux.ParamByName('NUMDOC').AsString   := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString   := strEspDoc;
      qryAux.ParamByName('CODEMP').AsString   := strCodEmp;

      qryAux.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fSetaOperadorESeparadorDaExpedicao]');
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

procedure pMarcarDataExpedicaoFaturamentoAutomatico(ANumFat, ATipFat, AEmpFat, ACliFat: String; dtaDtlBex: TDate;
                                                    ANumOrc: String=''; AEspOrc: String=''; AEmpOrc: String=''; ASerFat: String='');
  Var
    strWhere: String;
begin
  If dtaDtlBex <= 0 Then
    Exit;

  If fEmptyStr(ANumOrc) Then
  Begin
    strWhere := ' AND FATAUT.FAT_NUMFAT = "' + ANumFat + '" ' +
                ' AND FATAUT.FAT_TIPFAT = "' + ATipFat + '" ' +
                ' AND FATAUT.FAT_EMPFAT = "' + AEmpFat + '" ' +
                ' AND FATAUT.FAT_CLIFAT = "' + ACliFat + '" ';

    If Not fEmptyStr(ASerFat) Then
      strWhere := strWhere + ' AND FATAUT.FAT_SERFAT = "' + ASerFat + '" ';
  End
  Else
  Begin
    strWhere := ' AND FATAUT.FAT_NUMDOC = "' + ANumOrc + '" ' +
                ' AND FATAUT.FAT_ESPDOC = "' + AEspOrc + '" ' +
                ' AND FATAUT.FAT_EMPDOC = "' + AEmpOrc + '" ';
  End;

  fExecutaSQL(
    ' UPDATE   ' +
    '   FATAUT ' +
    ' SET      ' +
    '   FATAUT.FAT_DTLBEX = ' + fCurrentDate(dtaDtlBex) +
    ' WHERE TRUE ' + strWhere, True);
end;

function fMarcaDocumentoComoExpedido(const strSepExp, strNumDoc, strEspDoc, strCodEmp, strCodCli: String; const strSerie_: String=''): Boolean;
  Var
   qryAux : TUniQuery;
begin
  Result := True;
  qryAux := fCriaQuery;
  Try
    Try
      qryAux.SQL.Add('UPDATE ');
      qryAux.SQL.Add(' MOVGER ');
      qryAux.SQL.Add(' SET ');

      qryAux.SQL.Add('  GER_OPLBEX = :OPLBEX, ');
      qryAux.SQL.Add('  GER_DTLBEX = :DTAEXP, ');
      qryAux.SQL.Add('  GER_HRLBEX = :HOREXP, ');
      qryAux.SQL.Add('  GER_SEPEXP = :SEPEXP  ');

      qryAux.SQL.Add(' WHERE ');
      qryAux.SQL.Add('  GER_NUMDOC = :NUMDOC AND ');
      qryAux.SQL.Add('  GER_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('  GER_CODEMP = :CODEMP ');

      If fEmptyStr(strSepExp) Then
        qryAux.ParamByName('SEPEXP').Value := Null
      Else
        qryAux.ParamByName('SEPEXP').AsString := strSepExp;

      qryAux.ParamByName('OPLBEX').AsString   := strLoginUsuarioLogado;
      qryAux.ParamByName('DTAEXP').AsDateTime := VS_Date;
      qryAux.ParamByName('HOREXP').AsDateTime := fRetHoraServidor;

      qryAux.ParamByName('NUMDOC').AsString   := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString   := strEspDoc;
      qryAux.ParamByName('CODEMP').AsString   := strCodEmp;

      qryAux.ExecSQL;

      pMarcarDataExpedicaoFaturamentoAutomatico(strNumDoc, strEspDoc, strCodEmp, strCodCli, VS_Date, '', '', '', strSerie_);
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fMarcaDocumentoComoExpedido]');
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

initialization
  objReprocessarSaldoItens := nil;

end.

