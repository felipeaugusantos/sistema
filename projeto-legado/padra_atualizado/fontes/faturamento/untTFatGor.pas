unit untTFatGor;

interface

uses classes, untIFatGor, untConstantes,  sysutils, strutils, UniClientDataSet, untFatGor, untTypesSistema,
  untFuncoesSimples;

  Type
    TFatGor = class(TInterfacedPersistent, IFatGor)
    public
      procedure pNotificaRobo(strNumeroDocumento, strEspecie, strCodigoEmpresa : String);
      function fGravaFatGor(Var strAutInc: String;
                          strCodEmp,
                          strNumDoc,
                          strEspDoc,
                          strCodCli,
                          strCodVen,
                          strCodTra,
                          strSerie: String;
                          dtaDtaEnt,
                          dtaHorEnt: TDateTime;
                          strConPag,
                          strEstado,
                          strNomCom,
                          strEndCon,
                          strBaiCon,
                          strCepCon,
                          strCidCon,
                          strEstCon,
                          strCodAti,
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
                          fltDesEsp,
                          fltVlrCon,
                          fltTotPro,
                          fltTotCus,
                          fltTotMed: Double;
                          strTipFre: String;
                          fltTotFre,
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
                          fltVPar12,
                          fltDesAce,
                          fltPesBru,
                          fltPesLiq,
                          fltVolume: Double;
                          arrDuplic: TarrDuplicata;
                          strEspeci,
                          strMarca,
                          strMen001,
                          strMen002: String;
                          blnJaFatu: Boolean;
                          strTipFat,
                          strNumFat,
                          strEmpFat: String;
                          dtaDtaFat: TDateTime;
                          strVenFat,
                          strCndFat: String;
                          fltValFat,
                          fltPorDes: Double;
                          strCodDig,
                          strCodCnd,
                          strCodFpg: String;
                          recServicos: TDadosServicos;
                          strConEnt: String;
                          dtaPreVis: TDateTime;
                          fltVPgAnt: Double;
                          dtaUltAlt: TDateTime;
                          strNTrava,
                          strTipPed: String;
                          strCliCtt: String;
                          blnLibera: Boolean;
                          strEntFat: String;
                          fltDesCon: Double;
                          strTabPre,
                          strEntFut: String;
                          fltMargem: Double;
                          strNumPok: String;
                          strEmp_CD: String;
                          blnEnt_CD: Boolean;
                          strOprFlj,
                          strMenExp,
                          strMenEx2,
                          strMenEx3,
                          strMenEx4: String;
                          strNumReg,
                          strPedSit: String;
                          blnPedLib: Boolean;
                          dtaDtEntr: TDateTime;
                          strZerTax,
                          strTipOpe: String;
                          dtaDtaOri: TDateTime;
                          strTipFin: String;
                          fltDesFin: Double;
                          strAutEnt,
                          strPerEnt: String;
                          strEmlCon: String;
                          blnLibCom: Boolean;
                          strMotLib: String;
                          objFinanc: Pointer;
                          strEmpFor,
                          strEmp_TE: String;
                          dtaHorImp,
                          dtaDtaTra,
                          dtaHorTra: TDateTime;
                          strIndCom: string;
                          objOcoCrm: Pointer;
                          strGerPen: String;
                          fltFatNot,
                          fltFreSug: Double;
                          strPtNfMn,
                          strTFTNes: String;
                          dtaHPrevi: TDateTime;
                          strCodCar: String;
                          intQtdPaC: Integer;
                          strFasObr: String;
                          strEntUrg: String;
                          strSepImp: String;
                          strCorte_: String;
                          strNumGui: String = '';
                          strOrcOri: String = '';
                          strCodTpA: String = '';
                          strPlaVei: String = '';
                          strKm_Vei: String = '';
                          strCodPor: String = '';
                          strRelAba: String = '';
                          blnGravarDavPv: Boolean=False;
                          blnAlterado: Boolean=False;
                          dtaImpSep: TDateTime = 0;
                          horImpSep: TDateTime = 0;
                          strNumPedRefOR: String = '';
                          strEmpPedRefOR: String = '';
                          strLatitu: String = '';
                          strLongit: String = '';
                          strRaio__: String = '';
                          objFazenda: Pointer = nil;
                          strEnvLib: String = 'S';
                          fltFreRat: Double = 0;
                          strNumPedAba: String = '';
                          strEspPedAba: String = '';
                          strEmpPedAba: String = '';
                          strObsL01: String = '';
                          strObsL02: String = '';
                          strVenPre: String = 'N';
                          strTemBri: String = 'N';
                          strEdiPes: String = 'N';
                          fltTaxEnt: Double = 0;
                          strCodSup: String = '';
                          strOrcEsp: String = 'N';
                          strProspe: String = '';
                          strCodOco: String = '';
                          blnImpSfaPag: Boolean = False;
                          strCodEmbarcacao: String = '';
                          fltDesOpeGor: Double =0;
                          strCliCon: String = '';
                          strInRqCp: String = '';
                          strOriGor: String = '';
                          strBarCom: String = '';
                          strPD_Exp: String = 'S';
                          dtaValOrc: TDateTime = 0;
                          strCodRot: String = '';
                          fltTotBri: Double = 0;
                          fltBolAdt: Double = 0;
                          blnBolVen: Boolean = False;
                          fltTaxJur: Double = 0;
                          strFatTot: String = 'N';
                          strTraRdp: String = '';
                          strCliLoj: String = '';
                          strSeqDmp: String = '';
                          dtaDtFiCo : TDateTime = 0;
                          dtaDtInCo : TDateTime = 0;
                          dtaDtInSe : TDateTime = 0;
                          dtaDtBxSe : TDateTime = 0;
                          hraHrFiCo : TDateTime = 0;
                          hraHrInCo : TDateTime = 0;
                          hraHrInSe : TDateTime = 0;
                          hraHrBxSe : TDateTime = 0;
                          cdsExpRet: TUniClientDataSet=nil;
                          strUsaQue: string = 'N';
                          strDocQue: string = '';
                          strCodPrj: String = '';
                          strTpOper: String = '';
                          strNLeads: String = '';
                          strCupDes: String = '';
                          strNotPau: String = 'S';
                          dtaDtCtVn: TDatetime = 0;
                          fltVlCtVn: Double    = 0;
                          strCodCat: String    = '';
                          strMen003: String = '';
                          strMen004: String = '';
                          strMen005: String = '';
                          blnDevWms: Boolean = False;
                          strHisCom: String = '';
                          strCodEve: string = ''): Boolean;

    function fGravaFatDor(Var strAutInc: String;
                          strSeqGer: String;
                          strCodEmp,
                          strCodCli,
                          strCodVen,
                          strCodIte,
                          strCodMar,
                          strCodDiv,
                          strNumDoc,
                          strEspDoc,
                          strSerie: String;
                          dtaDtaEnt,
                          dtaHorEnt: TDateTime;
                          strConPag,
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
                          fltDesEsp,
                          fltDesAce: Double;
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
                          blnJaFatu: Boolean;
                          strTipFat,
                          strNumFat,
                          strEmpFat: String;
                          dtaDtaFat: TDateTime;
                          strVenFat,
                          strCndFat: String;
                          fltValFat: Double;
                          strIdePro,
                          strIncPis,
                          strCodDig,
                          strCodCnd,
                          strProEmb,
                          strCodFpg: String;
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
                          strIteEmb,
                          strGruEmb: String;
                          intLazQua: Integer;
                          strPromoc,
                          strSeqTin: String;
                          fltQtdPul: Double;
                          intSeqInd: Integer;
                          fltQtdBai,
                          fltUniDig: Double;
                          strComple: String;
                          fltVolPro: Double;
                          strCodAca,
                          strEmpAca: String;
                          blnProAca: Boolean;
                          strTabPre: String;
                          strLinha: String;
                          strCatali: String;
                          strCodDil: String;
                          fltPorDil: Double;
                          strDilCon: String;
                          fltPorCat: Double;
                          strEntRet,
                          strLocRet,
                          strEntFut,
                          strMotFut: String;
                          dtaDtEntr: TDateTime;
                          fltTotCu2: Double;
                          fltComRep,
                          fltPerRep: Double;
                          strKey_EP,
                          strNumLot: String;
                          strEmpPrd: String;
                          blnBxSbIt: Boolean;
                          strEmpIte: String;
                          strDocDev,
                          strEspDev,
                          strEmpDev: String;
                          strEmpFor: String;
                          strOrdPro: String;
                          fltFreSug: Double;
                          fltQtdExp: Double;
                          strBarEmb: String;
                          strNumCmp: String;
                          intNItCmp: Integer;
                          strCodMec: String;
                          strSeqRcd: String;
                          intSeqInc: Integer;
                          intOrdIte: Integer;
                          fltPesLiq: Double;
                          strAltPCo: String = 'N';
                          strCliBus: string = 'N';
                          strTurEnt: String = '';
                          fltVal_RT: Double = 0;
                          fltTaxJur: Double = 0;
                          blnInseridoOuAlterado: Boolean=False;
                          strLotAba: String = '';
                          strLotAnt: String = '';
                          strIncFut: String = '';
                          fltSerRat: Double = 0;
                          strSepExp: String = '';
                          fltFreRat: Double = 0;
                          strPigBas: String = 'N';
                          strIncDev: String = '';
                          strSeqOpI: String = '';
                          strBrinde: String = 'N';
                          strCodPar: String = '';
                          strTipBri: String = '';
                          strBaqtze: String = '';
                          fltDesMax: Double = 0;
                          fltValFle: Double = 0;
                          strPegou_: String = 'N';
                          fltTaxEnt: Double = 0;
                          strAtivac: String = 'N';
                          intSeqCom: Integer = 0;
                          fltQtdAti: Double = 0;
                          fltQtdCom: Double = 0;
                          strTabCom: String = '';
                          strDesNes: String = '';
                          blnIcmSai: Boolean = False;
                          fltIcmPav: Double = 0;
                          fltIcmSai: Double = 0;
                          fltImpFed: Double = 0;
                          fltDesOpe: Double = 0;
                          fltAlDifa: Double = 0;
                          strAutDet: String = '';
                          fltValFCP: Double = 0;
                          fltPesBru: Double = 0;
                          intSeqUlt: Integer = 0;
                          intQDEntr: Integer = 0;
                          strNcmTin: String = '';
                          strNotC17: String = '';
                          fltAlq922: Double = 0;
                          strCodCmg: String = '';
                          fltQtdSep: Double = 0;
                          fltDesCnd: Double = 0;
                          intSeqEst: Integer = 0;
                          strIteEst: String = '';
                          fltUniEst: Double = 0;
                          fltQtdSbi: Double = 0;
                          fltUniSbi: Double = 0;
                          strProEsp: String = '';
                          strVenCbo: String = '';
                          strCodPro: String = '';
                          fltUniDol: Double = 0;
                          fltTotDol: Double = 0;
                          fltQtdRco: Double = 0;
                          blnExiBSe: Boolean = True;
                          strAIdKitPromocao : String = ''): Boolean;
    end;

implementation

{ TFatGor }

function TFatGor.fGravaFatDor(Var strAutInc: String;
                          strSeqGer: String;
                          strCodEmp,
                          strCodCli,
                          strCodVen,
                          strCodIte,
                          strCodMar,
                          strCodDiv,
                          strNumDoc,
                          strEspDoc,
                          strSerie: String;
                          dtaDtaEnt,
                          dtaHorEnt: TDateTime;
                          strConPag,
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
                          fltDesEsp,
                          fltDesAce: Double;
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
                          blnJaFatu: Boolean;
                          strTipFat,
                          strNumFat,
                          strEmpFat: String;
                          dtaDtaFat: TDateTime;
                          strVenFat,
                          strCndFat: String;
                          fltValFat: Double;
                          strIdePro,
                          strIncPis,
                          strCodDig,
                          strCodCnd,
                          strProEmb,
                          strCodFpg: String;
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
                          strIteEmb,
                          strGruEmb: String;
                          intLazQua: Integer;
                          strPromoc,
                          strSeqTin: String;
                          fltQtdPul: Double;
                          intSeqInd: Integer;
                          fltQtdBai,
                          fltUniDig: Double;
                          strComple: String;
                          fltVolPro: Double;
                          strCodAca,
                          strEmpAca: String;
                          blnProAca: Boolean;
                          strTabPre: String;
                          strLinha: String;
                          strCatali: String;
                          strCodDil: String;
                          fltPorDil: Double;
                          strDilCon: String;
                          fltPorCat: Double;
                          strEntRet,
                          strLocRet,
                          strEntFut,
                          strMotFut: String;
                          dtaDtEntr: TDateTime;
                          fltTotCu2: Double;
                          fltComRep,
                          fltPerRep: Double;
                          strKey_EP,
                          strNumLot: String;
                          strEmpPrd: String;
                          blnBxSbIt: Boolean;
                          strEmpIte: String;
                          strDocDev,
                          strEspDev,
                          strEmpDev: String;
                          strEmpFor: String;
                          strOrdPro: String;
                          fltFreSug: Double;
                          fltQtdExp: Double;
                          strBarEmb: String;
                          strNumCmp: String;
                          intNItCmp: Integer;
                          strCodMec: String;
                          strSeqRcd: String;
                          intSeqInc: Integer;
                          intOrdIte: Integer;
                          fltPesLiq: Double;
                          strAltPCo: String = 'N';
                          strCliBus: string = 'N';
                          strTurEnt: String = '';
                          fltVal_RT: Double = 0;
                          fltTaxJur: Double = 0;
                          blnInseridoOuAlterado: Boolean=False;
                          strLotAba: String = '';
                          strLotAnt: String = '';
                          strIncFut: String = '';
                          fltSerRat: Double = 0;
                          strSepExp: String = '';
                          fltFreRat: Double = 0;
                          strPigBas: String = 'N';
                          strIncDev: String = '';
                          strSeqOpI: String = '';
                          strBrinde: String = 'N';
                          strCodPar: String = '';
                          strTipBri: String = '';
                          strBaqtze: String = '';
                          fltDesMax: Double = 0;
                          fltValFle: Double = 0;
                          strPegou_: String = 'N';
                          fltTaxEnt: Double = 0;
                          strAtivac: String = 'N';
                          intSeqCom: Integer = 0;
                          fltQtdAti: Double = 0;
                          fltQtdCom: Double = 0;
                          strTabCom: String = '';
                          strDesNes: String = '';
                          blnIcmSai: Boolean = False;
                          fltIcmPav: Double = 0;
                          fltIcmSai: Double = 0;
                          fltImpFed: Double = 0;
                          fltDesOpe: Double = 0;
                          fltAlDifa: Double = 0;
                          strAutDet: String = '';
                          fltValFCP: Double = 0;
                          fltPesBru: Double = 0;
                          intSeqUlt: Integer = 0;
                          intQDEntr: Integer = 0;
                          strNcmTin: String = '';
                          strNotC17: String = '';
                          fltAlq922: Double = 0;
                          strCodCmg: String = '';
                          fltQtdSep: Double = 0;
                          fltDesCnd: Double = 0;
                          intSeqEst: Integer = 0;
                          strIteEst: String = '';
                          fltUniEst: Double = 0;
                          fltQtdSbi: Double = 0;
                          fltUniSbi: Double = 0;
                          strProEsp: String = '';
                          strVenCbo: String = '';
                          strCodPro: String = '';
                          fltUniDol: Double = 0;
                          fltTotDol: Double = 0;
                          fltQtdRco: Double = 0;
                          blnExiBSe: Boolean = True;
                          strAIdKitPromocao : String = ''): Boolean;
begin
  Result := untFatGor.fGravaFatDor(strAutInc,
                          strSeqGer,
                          strCodEmp,
                          strCodCli,
                          strCodVen,
                          strCodIte,
                          strCodMar,
                          strCodDiv,
                          strNumDoc,
                          strEspDoc,
                          strSerie,
                          dtaDtaEnt,
                          dtaHorEnt,
                          strConPag,
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
                          fltDesAce,
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
                          blnJaFatu,
                          strTipFat,
                          strNumFat,
                          strEmpFat,
                          dtaDtaFat,
                          strVenFat,
                          strCndFat,
                          fltValFat,
                          strIdePro,
                          strIncPis,
                          strCodDig,
                          strCodCnd,
                          strProEmb,
                          strCodFpg,
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
                          strIteEmb,
                          strGruEmb,
                          intLazQua,
                          strPromoc,
                          strSeqTin,
                          fltQtdPul,
                          intSeqInd,
                          fltQtdBai,
                          fltUniDig,
                          strComple,
                          fltVolPro,
                          strCodAca,
                          strEmpAca,
                          blnProAca,
                          strTabPre,
                          strLinha,
                          strCatali,
                          strCodDil,
                          fltPorDil,
                          strDilCon,
                          fltPorCat,
                          strEntRet,
                          strLocRet,
                          strEntFut,
                          strMotFut,
                          dtaDtEntr,
                          fltTotCu2,
                          fltComRep,
                          fltPerRep,
                          strKey_EP,
                          strNumLot,
                          strEmpPrd,
                          blnBxSbIt,
                          strEmpIte,
                          strDocDev,
                          strEspDev,
                          strEmpDev,
                          strEmpFor,
                          strOrdPro,
                          fltFreSug,
                          fltQtdExp,
                          strBarEmb,
                          strNumCmp,
                          intNItCmp,
                          strCodMec,
                          strSeqRcd,
                          intSeqInc,
                          intOrdIte,
                          fltPesLiq,
                          strAltPCo,
                          strCliBus,
                          strTurEnt,
                          fltVal_RT,
                          fltTaxJur,
                          blnInseridoOuAlterado,
                          strLotAba,
                          strLotAnt,
                          strIncFut,
                          fltSerRat,
                          strSepExp,
                          fltFreRat,
                          strPigBas,
                          strIncDev,
                          strSeqOpI,
                          strBrinde,
                          strCodPar,
                          strTipBri,
                          strBaqtze,
                          fltDesMax,
                          fltValFle,
                          strPegou_,
                          fltTaxEnt,
                          strAtivac,
                          intSeqCom,
                          fltQtdAti,
                          fltQtdCom,
                          strTabCom,
                          strDesNes,
                          blnIcmSai,
                          fltIcmPav,
                          fltIcmSai,
                          fltImpFed,
                          fltDesOpe,
                          fltAlDifa,
                          strAutDet,
                          fltValFCP,
                          fltPesBru,
                          intSeqUlt,
                          intQDEntr,
                          strNcmTin,
                          strNotC17,
                          fltAlq922,
                          strCodCmg,
                          fltQtdSep,
                          fltDesCnd,
                          intSeqEst,
                          strIteEst,
                          fltUniEst,
                          fltQtdSbi,
                          fltUniSbi,
                          0, // fltFreMkp
                          0, // fltComMkp
                          strProEsp,
                          strVenCbo,
                          strCodPro,
                          fltUniDol,
                          fltTotDol,
                          fltQtdRco,
                          blnExiBSe,
                          strAIdKitPromocao);
end;

function TFatGor.fGravaFatGor(Var strAutInc: String;
                          strCodEmp,
                          strNumDoc,
                          strEspDoc,
                          strCodCli,
                          strCodVen,
                          strCodTra,
                          strSerie: String;
                          dtaDtaEnt,
                          dtaHorEnt: TDateTime;
                          strConPag,
                          strEstado,
                          strNomCom,
                          strEndCon,
                          strBaiCon,
                          strCepCon,
                          strCidCon,
                          strEstCon,
                          strCodAti,
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
                          fltDesEsp,
                          fltVlrCon,
                          fltTotPro,
                          fltTotCus,
                          fltTotMed: Double;
                          strTipFre: String;
                          fltTotFre,
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
                          fltVPar12,
                          fltDesAce,
                          fltPesBru,
                          fltPesLiq,
                          fltVolume: Double;
                          arrDuplic: TarrDuplicata;
                          strEspeci,
                          strMarca,
                          strMen001,
                          strMen002: String;
                          blnJaFatu: Boolean;
                          strTipFat,
                          strNumFat,
                          strEmpFat: String;
                          dtaDtaFat: TDateTime;
                          strVenFat,
                          strCndFat: String;
                          fltValFat,
                          fltPorDes: Double;
                          strCodDig,
                          strCodCnd,
                          strCodFpg: String;
                          recServicos: TDadosServicos;
                          strConEnt: String;
                          dtaPreVis: TDateTime;
                          fltVPgAnt: Double;
                          dtaUltAlt: TDateTime;
                          strNTrava,
                          strTipPed: String;
                          strCliCtt: String;
                          blnLibera: Boolean;
                          strEntFat: String;
                          fltDesCon: Double;
                          strTabPre,
                          strEntFut: String;
                          fltMargem: Double;
                          strNumPok: String;
                          strEmp_CD: String;
                          blnEnt_CD: Boolean;
                          strOprFlj,
                          strMenExp,
                          strMenEx2,
                          strMenEx3,
                          strMenEx4: String;
                          strNumReg,
                          strPedSit: String;
                          blnPedLib: Boolean;
                          dtaDtEntr: TDateTime;
                          strZerTax,
                          strTipOpe: String;
                          dtaDtaOri: TDateTime;
                          strTipFin: String;
                          fltDesFin: Double;
                          strAutEnt,
                          strPerEnt: String;
                          strEmlCon: String;
                          blnLibCom: Boolean;
                          strMotLib: String;
                          objFinanc: Pointer;
                          strEmpFor,
                          strEmp_TE: String;
                          dtaHorImp,
                          dtaDtaTra,
                          dtaHorTra: TDateTime;
                          strIndCom: string;
                          objOcoCrm: Pointer;
                          strGerPen: String;
                          fltFatNot,
                          fltFreSug: Double;
                          strPtNfMn,
                          strTFTNes: String;
                          dtaHPrevi: TDateTime;
                          strCodCar: String;
                          intQtdPaC: Integer;
                          strFasObr: String;
                          strEntUrg: String;
                          strSepImp: String;
                          strCorte_: String;
                          strNumGui: String = '';
                          strOrcOri: String = '';
                          strCodTpA: String = '';
                          strPlaVei: String = '';
                          strKm_Vei: String = '';
                          strCodPor: String = '';
                          strRelAba: String = '';
                          blnGravarDavPv: Boolean=False;
                          blnAlterado: Boolean=False;
                          dtaImpSep: TDateTime = 0;
                          horImpSep: TDateTime = 0;
                          strNumPedRefOR: String = '';
                          strEmpPedRefOR: String = '';
                          strLatitu: String = '';
                          strLongit: String = '';
                          strRaio__: String = '';
                          objFazenda: Pointer = nil;
                          strEnvLib: String = 'S';
                          fltFreRat: Double = 0;
                          strNumPedAba: String = '';
                          strEspPedAba: String = '';
                          strEmpPedAba: String = '';
                          strObsL01: String = '';
                          strObsL02: String = '';
                          strVenPre: String = 'N';
                          strTemBri: String = 'N';
                          strEdiPes: String = 'N';
                          fltTaxEnt: Double = 0;
                          strCodSup: String = '';
                          strOrcEsp: String = 'N';
                          strProspe: String = '';
                          strCodOco: String = '';
                          blnImpSfaPag: Boolean = False;
                          strCodEmbarcacao: String = '';
                          fltDesOpeGor: Double =0;
                          strCliCon: String = '';
                          strInRqCp: String = '';
                          strOriGor: String = '';
                          strBarCom: String = '';
                          strPD_Exp: String = 'S';
                          dtaValOrc: TDateTime = 0;
                          strCodRot: String = '';
                          fltTotBri: Double = 0;
                          fltBolAdt: Double = 0;
                          blnBolVen: Boolean = False;
                          fltTaxJur: Double = 0;
                          strFatTot: String = 'N';
                          strTraRdp: String = '';
                          strCliLoj: String = '';
                          strSeqDmp: String = '';
                          dtaDtFiCo : TDateTime = 0;
                          dtaDtInCo : TDateTime = 0;
                          dtaDtInSe : TDateTime = 0;
                          dtaDtBxSe : TDateTime = 0;
                          hraHrFiCo : TDateTime = 0;
                          hraHrInCo : TDateTime = 0;
                          hraHrInSe : TDateTime = 0;
                          hraHrBxSe : TDateTime = 0;
                          cdsExpRet: TUniClientDataSet=nil;
                          strUsaQue: string = 'N';
                          strDocQue: string = '';
                          strCodPrj: String = '';
                          strTpOper: String = '';
                          strNLeads: String = '';
                          strCupDes: String = '';
                          strNotPau: String = 'S';
                          dtaDtCtVn: TDatetime = 0;
                          fltVlCtVn: Double    = 0;
                          strCodCat: String    = '';
                          strMen003: String = '';
                          strMen004: String = '';
                          strMen005: String = '';
                          blnDevWms: Boolean = False;
                          strHisCom: String = '';
                          strCodEve: string = ''): Boolean;
begin
  Result := untFatGor.fGravaFatGor(strAutInc,
                          strCodEmp,
                          strNumDoc,
                          strEspDoc,
                          strCodCli,
                          strCodVen,
                          strCodTra,
                          strSerie,
                          dtaDtaEnt,
                          dtaHorEnt,
                          strConPag,
                          strEstado,
                          strNomCom,
                          strEndCon,
                          strBaiCon,
                          strCepCon,
                          strCidCon,
                          strEstCon,
                          strCodAti,
                          strTelCon,
                          dtaNasCon,
                          strCgcCpf,
                          strCgcCon,
                          strIesCon,
                          strCli_Rg,
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
                          fltDesEsp,
                          fltVlrCon,
                          fltTotPro,
                          fltTotCus,
                          fltTotMed,
                          strTipFre,
                          fltTotFre,
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
                          fltVPar12,
                          fltDesAce,
                          fltPesBru,
                          fltPesLiq,
                          fltVolume,
                          arrDuplic,
                          strEspeci,
                          strMarca,
                          strMen001,
                          strMen002,
                          blnJaFatu,
                          strTipFat,
                          strNumFat,
                          strEmpFat,
                          dtaDtaFat,
                          strVenFat,
                          strCndFat,
                          fltValFat,
                          fltPorDes,
                          strCodDig,
                          strCodCnd,
                          strCodFpg,
                          recServicos,
                          strConEnt,
                          dtaPreVis,
                          fltVPgAnt,
                          dtaUltAlt,
                          strNTrava,
                          strTipPed,
                          strCliCtt,
                          IIF(blnLibera, 1, 0),
                          strEntFat,
                          fltDesCon,
                          strTabPre,
                          strEntFut,
                          fltMargem,
                          strNumPok,
                          strEmp_CD,
                          blnEnt_CD,
                          strOprFlj,
                          strMenExp,
                          strMenEx2,
                          strMenEx3,
                          strMenEx4,
                          strNumReg,
                          strPedSit,
                          blnPedLib,
                          dtaDtEntr,
                          strZerTax,
                          strTipOpe,
                          dtaDtaOri,
                          strTipFin,
                          fltDesFin,
                          strAutEnt,
                          strPerEnt,
                          strEmlCon,
                          blnLibCom,
                          strMotLib,
                          objFinanc,
                          strEmpFor,
                          strEmp_TE,
                          dtaHorImp,
                          dtaDtaTra,
                          dtaHorTra,
                          strIndCom,
                          objOcoCrm,
                          strGerPen,
                          fltFatNot,
                          fltFreSug,
                          strPtNfMn,
                          strTFTNes,
                          dtaHPrevi,
                          strCodCar,
                          intQtdPaC,
                          strFasObr,
                          strEntUrg,
                          strSepImp,
                          strCorte_,
                          strNumGui,
                          strOrcOri,
                          strCodTpA,
                          strPlaVei,
                          strKm_Vei,
                          strCodPor,
                          strRelAba,
                          blnGravarDavPv,
                          blnAlterado,
                          dtaImpSep,
                          horImpSep,
                          strNumPedRefOR,
                          strEmpPedRefOR,
                          strLatitu,
                          strLongit,
                          strRaio__,
                          objFazenda,
                          strEnvLib,
                          fltFreRat,
                          strNumPedAba,
                          strEspPedAba,
                          strEmpPedAba,
                          strObsL01,
                          strObsL02,
                          strVenPre,
                          strTemBri,
                          strEdiPes,
                          fltTaxEnt,
                          strCodSup,
                          strOrcEsp,
                          strProspe,
                          strCodOco,
                          blnImpSfaPag,
                          strCodEmbarcacao,
                          fltDesOpeGor,
                          strCliCon,
                          strInRqCp,
                          strOriGor,
                          strBarCom,
                          strPD_Exp,
                          dtaValOrc,
                          strCodRot,
                          fltTotBri,
                          fltBolAdt,
                          blnBolVen,
                          fltTaxJur,
                          strFatTot,
                          strTraRdp,
                          strCliLoj,
                          strSeqDmp,
                          dtaDtFiCo,
                          dtaDtInCo,
                          dtaDtInSe,
                          dtaDtBxSe,
                          hraHrFiCo,
                          hraHrInCo,
                          hraHrInSe,
                          hraHrBxSe,
                          cdsExpRet,
                          strUsaQue,
                          strDocQue,
                          strCodPrj,
                          strTpOper,
                          strNLeads,
                          strCupDes,
                          strNotPau,
                          dtaDtCtVn,
                          fltVlCtVn,
                          strCodCat,
                          strMen003,
                          strMen004,
                          strMen005,
                          0, // fltFreMkp
                          0, // fltComMkp
                          blnDevWms,
                          strHisCom,
                          strCodEve);
end;

procedure TFatGor.pNotificaRobo(strNumeroDocumento, strEspecie, strCodigoEmpresa: String);
begin
  untFatGor.pNotificaRobo(strNumeroDocumento, strEspecie, strCodigoEmpresa);
end;

initialization

  RegisterClass(TFatGor);

end.
