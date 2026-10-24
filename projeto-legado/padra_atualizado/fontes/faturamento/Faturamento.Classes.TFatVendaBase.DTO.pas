unit Faturamento.Classes.TFatVendaBase.DTO;

interface

uses UniClientDataSet, BitBtnLockedIncrem, untFuncFatTypes, untTypesSistema;

type
  TDadosItemDTO = class
  private
    FCdsDados: TUniClientDataSet;
    FBtnAdicionar: TBitBtnLocked;
    FstrIdePro,
    FstrCodGru,
    FstrCodIte,
    FstrDesOri,
    FstrDesIte,
    FstrDesFab,
    FstrUnidad,
    FstrCodUni,
    FstrCodMar,
    FstrCodFor,
    FstrRefere: String;
    FfltUniOri,
    FfltUniVis,
    FfltUniTar,
    FfltUniTmp,
    FfltDesCon,
    FfltQtdIte,
    FfltTotIte: Double;
    FstrEntSai: String;
    FfltPreCus,
    FfltTotCus: Double;
    FstrComLub: String;
    FfltIpiSai,
    FfltDesMax,
    FfltPreVe1,
    FfltPreVe2,
    FfltPreVe3,
    FfltPreVe4,
    FfltPreVe5,
    FfltPreVe6,
    FfltPreVe7,
    FfltMarLuc,
    FfltSaldos: Double;
    FstrIncPis: String;
    FfltComVar,
    FfltComAta,
    FfltComDis: Double;
    FstrDocDev,
    FstrEspDev,
    FstrEmpDev: String;
    FfltQtdDev,
    FfltUniDev: Double;
    FstrIncDev: String;
    FfltTotUlt,
    FfltImpUlt,
    FfltPreUlt,
    FfltPreMed: Double;
    FstrClaIpi,
    FstrIteCha,
    FstrIteTin,
    FstrDesCor,
    FstrTipPre: String;
    FintLazQua: Integer;
    FstrTipEmb: String;
    FfltQtdEmb,
    FfltPreEmb: Double;
    FfltPrvTin,
    FfltPrcTin,
    FfltFatTin: Double;
    FstrProEmb,
    FstrIteEmb: String;
    FfltUniEmb,
    FfltEmbAnt: Double;
    FstrCodAbf: String;
    FfltPesoIt: Double;
    FfltPesLiq: Double;
    FstrPromoc: String;
    FfltProPreCus,
    FfltProPreVen,
    FfltProComVar,
    FfltProDesF07: Double;
    FstrTipTin: String;
    FfltGPeCom: Double;
    FstrCodFab: String;
    FintSeqInd: Integer;
    FfltQtdBai: Double;
    FstrNumOrc,
    FstrEspOrc,
    FstrEmpOrc: String;
    FfltMarMin,
    FfltMarMSG,
    FfltMarMGe: Double;
    FstrMarca,
    FstrStatus: String;
    FfltComDev,
    FfltDesDev: Double;
    FstrSeqDet,
    FstrCatalize,
    FstrLinTin: String;
    FfltEmbala: Double;
    FstrDesNes,
    FstrSemEst,
    FstrLibEst: String; //Liberou sem estoque mediante senha
    FfltPreCom,
    FfltUniDig: Double;
    FfltQtdPon: Double;
    FstrComple,
    FstrDivDev,
    FstrObrCpf,
    FstrMontad,
    FstrA_n_o_: String;
    FstrSigUni: String;
    FfltVolPro: Double;
    FintOrdite: Integer;
    FstrChaFor,
    FstrCodAca,
    FstrEmpAca: String;
    FblnProAca: Boolean;
    FstrEspFut,
    FstrDocFut,
    FstrEmpFut: String;
    FfltOutVal,
    FfltComTbl,
    FfltDesOpe,
    FfltICMSai,
    FfltImpFed,
    FfltDesMge: Double;
    FstrDocCnf,
    FstrEspCnf,
    FstrEmpCnf,
    FstrTabPre: String;
    FfltIpiEnt,
    FfltFreEnt: Double;
    FstrCodDil: String;
    FfltPorDil: Double;
    FstrDilCon: String;
    FfltPorCat: Double;
    FstrEntRet,
    FstrLocRet,
    FstrEntFut,
    FstrMotFut: String;
    FdtaDtaEnt: TDateTime;
    FfltQtdOri,
    FfltDesEsp,
    FfltDesBai: Double;
    FstrImpDir,
    FstrLocFis: String;
    FfltPreCu2,
    FfltTotCu2,
    FfltProComAta,
    FfltProComDis,
    FfltTotPed,
    FfltPanUti,
    FfltTotDes,
    FftlTotFre: Double;
    FrecForTin: TForTin;
    FstrKey_EP,
    FstrLotAnt,
    FstrNumLot: String;
    FstrEmpPrd: String;
    FstrVenCnf: String;
    FblnBxSbIt: Boolean;
    FstrPigBas: String;
    FstrIdeDev: String;
    FfltQtdDet: Double;
    FstrTabDev: String;
    FstrCodBar: String;
    FstrTipFin: String;
    FfltDesFin,
    FfltPreLot,
    FfltCoDvRp: Double;
    FstrEmpIte: String;
    FfltFatAce: Double;
    FblnPodAlt: Boolean;
    FstrEmpSol,
    FstrCndDev,
    FstrCCndDv: String;
    FdtaEmiDev: TDate;
    FfltCusIte: Double;
    FstrDesSim: String;
    FstrOrdPro: String;
    FrecMadeira: untTypesSistema.TDadosMadeira;
    FfltTotImp: Double;
    FfltVal_RT: Double;
    FfltTaxJur: Double;
    FstrSeqGad: String;
    FfltQtdExp: Double;
    FstrBarEmb: String;
    FstrNumCmp: String;
    FintNItCmp: Integer;
    FfltDeDVCf: Double;
    FstrCodMec: String;
    FstrSeqRcd: String;
    FintSeqInc: Integer;
    FstrCodVenIte: String;
    FstrAltPCoIte: String;
    FfltPerComIte: Double;
    FfltFreDev: Double;
    FfltDeADev: Double;
    FblnAlterandoPDORCarregado: Boolean;
    FblnInserindoPDORCarregado: Boolean;
    FstrCliBus: String;
    FstrTurEnt: String;
    FintSeqCcr: Integer;
    FfltDopTin: Double;
    FstrCodVe2Ite: String;
    FstrLibUni: String;
    FfltValDif: Double;
    FstrLotAba: String;
    FstrIncFut: String;
    FstrSepExp: String;
    FstrTabPreEmb: String;
    FstrExcIpi: String;
    FfltDesMSu: Double;
    FstrAiDvOr: String;
    FstrClaFis: String;
    FstrSeqOpI: String;
    FstrRatDes: String;
    FstrBrinde: String;
    FstrCodPar: String;
    FstrTipBri: String;
    FstrSeqGer: String;
    FstrBaseQtdZerada: String;
    FblnEdiPes: Boolean;
    FfltPesoItCad: Double;
    FfltPesLiqCad: Double;
    FstrPegou_: String;
    FstrIteAbf: String;
    FstrAtivac: String;
    FintSeqCom: Integer;
    FfltQtdAti: Double;
    FfltQtdCom: Double;
    FstrTabCom: String;
    FfltPorGer: Double;
    FfltPorDet: Double;
    FintSeqEst: Integer;
    FstrIteEst: String;
    FfltUniEst: Double;
    FfltQtdSbi: Double;
    FfltUniSbi: Double;
    FstrLotSep: String;
    FstrObsColorista: String;
    FintTipoFormulacao: Integer;
    FfltFreMkp: Double;
    FfltComMkp: Double;
    FblnJaFatu: Boolean;
    FstrTipFat: String;
    FstrNumFat: String;
    FstrEmpFat: String;
    FstrVenFat: String;
    FstrCndFat: String;
    FfltValFat: Double;
    FdtaDtaFat: TDateTime;
    FfltComDig: Double;
    FfltBFCPST: Double;
    FfltPFCPST: Double;
    FfltVFCPST: Double;
    FintQDEntr: Integer;
    FstrNotC17: String;
    FstrCodCmg: String;
    FfltQtdSep: Double;
    FfltDesCnd: Double;
    FstrProEsp: String;
    FstrPorPer: String;
    FstrExibSE: String;
    FstrFdoIteRecalcPrecos: String;
    FstrOpBxSe: String;
    FdtaDtBxSe: TDateTime;
    FdtaHrBxSe: TDateTime;
    FstrEmpCar: String;
    FstrAutoinDevCar: String;
    FstrEntFutDocOri: String;
    FstrTemNumSerie: String;
    FstrOpSeEx: String;
    FstrConExp: String;
    FstrEmbExp: String;
    FstrObsExp: String;
    FstrChkOut: String;
    FfltDesMVM: Double;
    FfltDesMSM: Double;
    FfltDesMGM: Double;
    FfltMarMMV: Double;
    FfltMarMMS: Double;
    FfltMarMMG: Double;
    FfltVDesST: Double;
    FstrMDesST: String;
    FstrReserv: String;
    FstrMovTriLocFis: String;
    FintSeqInv: Integer;
    FstrSeqEql: String;
    FfltQtdCha: Double;
    FintSeqIte: Integer;
    FstrNumDrw: String;
    FblnMntPrc: Boolean;
    FfltQtdRet: Double;
    FstrNumPla: String;
    FstrParNum: String;
    FstrReqCom: String;
    FstrRegEsp: String;
    FfltFreCot: Double;
    FblnAltEst: Boolean;
    FintSeqPer: Integer;
    FfltValorOriginalItemEstrutura: Double;
    FblnCalcularComissao: Boolean;
    FblnCalcularImpostos: Boolean;
    FstrCilvas: String;
    FblnRatEst: Boolean;
    FstrPedRet: String;
    FblnUpseml: Boolean;
    FstrEmpExp: String;
    FstrSobEnc: String;
    FstrOpeSep: String;
    FstrIteOpeExp: String;
    FstrEmpDmp: String;
    FblnTraIte: Boolean;
    FstrTabAnt: String;
    FfltPreAnt: Double;
    FfltCfbIpi: Double;
    FfltCfaIpi: Double;
    FfltCfvIpi: Double;
    FstrDocIpi: String;
    FstrEspIpi: String;
    FstrEmpIpi: String;
    FstrSeqVdp: String;
    FstrBasTro: String;
    FstrITinDv: String;
    FblnTipBusCodBar: Boolean;
    FdtaDtaCmp: TDate;
    FstrCodDig: String;
    FstrTckQbt: String;
  public
    constructor Create;
    {$region 'Criar objeto setando os atributos'}
    constructor CreateComAtributos(
                cdsDados: TUniClientDataSet;
                btnAdicionar: TBitBtnLocked;
                strIdePro,
                strCodGru,
                strCodIte,
                strDesOri,
                strDesIte,
                strDesFab,
                strUnidad,
                strCodUni,
                strCodMar,
                strCodFor,
                strRefere: String;
                fltUniOri,
                fltUniVis,
                fltUniTar,
                fltUniTmp,
                fltDesCon,
                fltQtdIte,
                fltTotIte: Double;
                strEntSai: String;
                fltPreCus,
                fltTotCus: Double;
                strComLub: String;
                fltIpiSai,
                fltDesMax,
                fltPreVe1,
                fltPreVe2,
                fltPreVe3,
                fltPreVe4,
                fltPreVe5,
                fltPreVe6,
                fltPreVe7,
                fltMarLuc,
                fltSaldos: Double;
                strIncPis: String;
                fltComVar,
                fltComAta,
                fltComDis: Double;
                strDocDev,
                strEspDev,
                strEmpDev: String;
                fltQtdDev,
                fltUniDev: Double;
                strIncDev: String;
                fltTotUlt,
                fltImpUlt,
                fltPreUlt,
                fltPreMed: Double;
                strClaIpi,
                strIteCha,
                strIteTin,
                strDesCor,
                strTipPre: String;
                intLazQua: Integer;
                strTipEmb: String;
                fltQtdEmb,
                fltPreEmb: Double;
                fltPrvTin,
                fltPrcTin,
                fltFatTin: Double;
                strProEmb,
                strIteEmb: String;
                fltUniEmb,
                fltEmbAnt: Double;
                strCodAbf: String;
                fltPesoIt: Double;
                fltPesLiq: Double;
                strPromoc: String;
                fltProPreCus,
                fltProPreVen,
                fltProComVar,
                fltProDesF07 : Double;
                strTipTin: String;
                fltGPeCom: Double;
                strCodFab: String;
                intSeqInd: Integer;
                fltQtdBai: Double;
                strNumOrc,
                strEspOrc,
                strEmpOrc: String;
                fltMarMin,
                fltMarMSG,
                fltMarMGe: Double;
                strMarca,
                strStatus: String;
                fltComDev,
                fltDesDev: Double;
                strSeqDet,
                strCatalize,
                strLinTin: String;
                fltEmbala: Double;
                strDesNes,
                strSemEst,
                strLibEst: String;//Liberou sem estoque mediante senha
                fltPreCom,
                fltUniDig: Double;
                fltQtdPon: Double;
                strComple,
                strDivDev,
                strObrCpf,
                strMontad,
                strA_n_o_: String;
                strSigUni: String;
                fltVolPro: Double;
                intOrdite: Integer;
                strChaFor,
                strCodAca,
                strEmpAca: String;
                blnProAca: Boolean;
                strEspFut,
                strDocFut,
                strEmpFut: String;
                fltOutVal,
                fltComTbl,
                fltDesOpe,
                fltICMSai,
                fltImpFed,
                fltDesMge: Double;
                strDocCnf,
                strEspCnf,
                strEmpCnf,
                strTabPre: String;
                fltIpiEnt,
                fltFreEnt: Double;
                strCodDil: String;
                fltPorDil: Double;
                strDilCon: String;
                fltPorCat: Double;
                strEntRet,
                strLocRet,
                strEntFut,
                strMotFut: String;
                dtaDtaEnt: TDateTime;
                fltQtdOri,
                fltDesEsp,
                fltDesBai: Double;
                strImpDir,
                strLocFis: String;
                fltPreCu2,
                fltTotCu2,
                fltProComAta,
                fltProComDis,
                fltTotPed,
                fltPanUti,
                fltTotDes,
                ftlTotFre: Double;
                recForTin: TForTin;
                strKey_EP,
                strLotAnt,
                strNumLot: String;
                strEmpPrd: String;
                strVenCnf: String;
                blnBxSbIt: Boolean;
                strPigBas: String;
                strIdeDev: String;
                fltQtdDet: Double;
                strTabDev: String;
                strCodBar: String;
                strTipFin: String;
                fltDesFin,
                fltPreLot,
                fltCoDvRp: Double;
                strEmpIte: String;
                fltFatAce: Double;
                blnPodAlt: Boolean;
                strEmpSol,
                strCndDev,
                strCCndDv: String;
                dtaEmiDev: TDate;
                fltCusIte: Double;
                strDesSim: String;
                strOrdPro: String;
                recMadeira: untTypesSistema.TDadosMadeira;
                fltTotImp: Double;
                fltVal_RT: Double = 0;
                fltTaxJur: Double = 0;
                strSeqGad: String = '';
                fltQtdExp: Double = 0;
                strBarEmb: String = '';
                strNumCmp: String = '';
                intNItCmp: Integer = 0;
                fltDeDVCf: Double = 0;
                strCodMec: String = '';
                strSeqRcd: String = '';
                intSeqInc: Integer = 0;
                strCodVenIte: String = '';
                strAltPCoIte: String = 'N';
                fltPerComIte: Double = 0;
                fltFreDev: Double = 0;
                fltDeADev: Double = 0;
                blnAlterandoPDORCarregado: Boolean = False;
                blnInserindoPDORCarregado: Boolean = False;
                strCliBus: String = 'N';
                strTurEnt: String = '';
                intSeqCcr: Integer = 0;
                fltDopTin: Double = 0;
                strCodVe2Ite: String = '';
                strLibUni: String = 'N';
                fltValDif: Double = 0;
                strLotAba: String = '';
                strIncFut: String = '';
                strSepExp: String = '';
                strTabPreEmb: String = '';
                strExcIpi: String = '';
                fltDesMSu: Double = 0.00;
                strAiDvOr: String = '';
                strClaFis: String = '';
                strSeqOpI: String = '';
                strRatDes: String = 'S';
                strBrinde: String = 'N';
                strCodPar: String = '';
                strTipBri: String = '';
                strSeqGer: String = '';
                strBaseQtdZerada: String = '';
                blnEdiPes: Boolean = False;
                fltPesoItCad: Double = -1;
                fltPesLiqCad: Double = -1;
                strPegou_: String = 'N';
                strIteAbf: String = '';
                strAtivac: String = 'N';
                intSeqCom: Integer = 0;
                fltQtdAti: Double = 0;
                fltQtdCom: Double = 0;
                strTabCom: String = '';
                fltPorGer: Double = 0;
                fltPorDet: Double = 0;
                intSeqEst: Integer = 0;
                strIteEst: String = '';
                fltUniEst: Double = 0;
                fltQtdSbi: Double = 0;
                fltUniSbi: Double = 0;
                strLotSep: String='';
                strObsColorista : String = '';
                intTipoFormulacao : Integer = 0;
                fltFreMkp: Double = 0;
                fltComMkp: Double = 0;
                blnJaFatu: Boolean = False;
                strTipFat: String = '';
                strNumFat: String = '';
                strEmpFat: String = '';
                strVenFat: String = '';
                strCndFat: String = '';
                fltValFat: Double = 0;
                dtaDtaFat: TDateTime = 0;
                fltComDig: Double = 0;
                fltBFCPST: Double = 0;
                fltPFCPST: Double = 0;
                fltVFCPST: Double = 0;
                intQDEntr: Integer = 0;
                strNotC17: String = '';
                strCodCmg: String = '';
                fltQtdSep: Double = 0;
                fltDesCnd: Double = 0;
                strProEsp: String = '';
                strPorPer: String = '';
                strExibSE: String = 'N';
                strFdoIteRecalcPrecos: String = 'N';
                strOpBxSe: String = '';
                dtaDtBxSe: TDateTime = 0;
                dtaHrBxSe: TDateTime = 0;
                strEmpCar: String = '';
                strAutoinDevCar: String = '';
                strEntFutDocOri: String = '';
                strTemNumSerie: String = '';
                strOpSeEx: String = '';
                strConExp: String = '';
                strEmbExp: String = '';
                strObsExp: String = '';
                strChkOut: String = '';
                fltDesMVM: Double = 0;
                fltDesMSM: Double = 0;
                fltDesMGM: Double = 0;
                fltMarMMV: Double = 0;
                fltMarMMS: Double = 0;
                fltMarMMG: Double = 0;
                fltVDesST: Double = 0;
                strMDesST: String = '';
                strReserv: String = 'S';
                strMovTriLocFis: String = '';
                intSeqInv: Integer = 0;
                strSeqEql: String = '';
                fltQtdCha: Double = 0;
                intSeqIte: Integer = 0;
                strNumDrw: String = '';
                blnMntPrc: Boolean = False;
                fltQtdRet: Double = 0;
                strNumPla: String = '';
                strParNum: String = '';
                strReqCom: String = '';
                strRegEsp: String = '';
                fltFreCot: Double = 0;
                blnAltEst: Boolean = False;
                intSeqPer: Integer = 0;
                fltValorOriginalItemEstrutura: Double = 0;
                blnCalcularComissao: Boolean = True;
                blnCalcularImpostos: Boolean = True;
                strCilvas: String = 'N';
                blnRatEst: Boolean = False;
                strPedRet: String = '';
                blnUpseml: Boolean = False;
                strEmpExp: String = '';
                strSobEnc: String = '';
                strOpeSep: String = '';
                strIteOpeExp: String = '';
                strEmpDmp: String = '';
                blnTraIte: Boolean = False;
                strTabAnt: String = '';
                fltPreAnt: Double = 0;
                fltCfbIpi: Double = 0;
                fltCfaIpi: Double = 0;
                fltCfvIpi: Double = 0;
                strDocIpi: String = '';
                strEspIpi: String = '';
                strEmpIpi: String = '';
                strSeqVdp: String = '';
                strBasTro: String = 'N';
                strITinDv: String = '';
                blnTipBusCodBar: Boolean = False;
                dtaDtaCmp: TDate = 0;
                strCodDig: String = '';
                strTckQbt: String = '');
    {$endregion}

    property CdsDados: TUniClientDataSet read FCdsDados write FCdsDados;
    property BtnAdicionar: TBitBtnLocked read FBtnAdicionar write FBtnAdicionar;
    property strIdePro: String read FstrIdePro write FstrIdePro;
    property strCodGru: String read FstrCodGru write FstrCodGru;
    property strCodIte: String read FstrCodIte write FstrCodIte;
    property strDesOri: String read FstrDesOri write FstrDesOri;
    property strDesIte: String read FstrDesIte write FstrDesIte;
    property strDesFab: String read FstrDesFab write FstrDesFab;
    property strUnidad: String read FstrUnidad write FstrUnidad;
    property strCodUni: String read FstrCodUni write FstrCodUni;
    property strCodMar: String read FstrCodMar write FstrCodMar;
    property strCodFor: String read FstrCodFor write FstrCodFor;
    property strRefere: String read FstrRefere write FstrRefere;
    property fltUniOri: Double read FfltUniOri write FfltUniOri;
    property fltUniVis: Double read FfltUniVis write FfltUniVis;
    property fltUniTar: Double read FfltUniTar write FfltUniTar;
    property fltUniTmp: Double read FfltUniTmp write FfltUniTmp;
    property fltDesCon: Double read FfltDesCon write FfltDesCon;
    property fltQtdIte: Double read FfltQtdIte write FfltQtdIte;
    property fltTotIte: Double read FfltTotIte write FfltTotIte;
    property strEntSai: String read FstrEntSai write FstrEntSai;
    property fltPreCus: Double read FfltPreCus write FfltPreCus;
    property fltTotCus: Double read FfltTotCus write FfltTotCus;
    property strComLub: String read FstrComLub write FstrComLub;
    property fltIpiSai: Double read FfltIpiSai write FfltIpiSai;
    property fltDesMax: Double read FfltDesMax write FfltDesMax;
    property fltPreVe1: Double read FfltPreVe1 write FfltPreVe1;
    property fltPreVe2: Double read FfltPreVe2 write FfltPreVe2;
    property fltPreVe3: Double read FfltPreVe3 write FfltPreVe3;
    property fltPreVe4: Double read FfltPreVe4 write FfltPreVe4;
    property fltPreVe5: Double read FfltPreVe5 write FfltPreVe5;
    property fltPreVe6: Double read FfltPreVe6 write FfltPreVe6;
    property fltPreVe7: Double read FfltPreVe7 write FfltPreVe7;
    property fltMarLuc: Double read FfltMarLuc write FfltMarLuc;
    property fltSaldos: Double read FfltSaldos write FfltSaldos;
    property strIncPis: String read FstrIncPis write FstrIncPis;
    property fltComVar: Double read FfltComVar write FfltComVar;
    property fltComAta: Double read FfltComAta write FfltComAta;
    property fltComDis: Double read FfltComDis write FfltComDis;
    property strDocDev: String read FstrDocDev write FstrDocDev;
    property strEspDev: String read FstrEspDev write FstrEspDev;
    property strEmpDev: String read FstrEmpDev write FstrEmpDev;
    property fltQtdDev: Double read FfltQtdDev write FfltQtdDev;
    property fltUniDev: Double read FfltUniDev write FfltUniDev;
    property strIncDev: String read FstrIncDev write FstrIncDev;
    property fltTotUlt: Double read FfltTotUlt write FfltTotUlt;
    property fltImpUlt: Double read FfltImpUlt write FfltImpUlt;
    property fltPreUlt: Double read FfltPreUlt write FfltPreUlt;
    property fltPreMed: Double read FfltPreMed write FfltPreMed;
    property strClaIpi: String read FstrClaIpi write FstrClaIpi;
    property strIteCha: String read FstrIteCha write FstrIteCha;
    property strIteTin: String read FstrIteTin write FstrIteTin;
    property strDesCor: String read FstrDesCor write FstrDesCor;
    property strTipPre: String read FstrTipPre write FstrTipPre;
    property intLazQua: Integer read FintLazQua write FintLazQua;
    property strTipEmb: String read FstrTipEmb write FstrTipEmb;
    property fltQtdEmb: Double read FfltQtdEmb write FfltQtdEmb;
    property fltPreEmb: Double read FfltPreEmb write FfltPreEmb;
    property fltPrvTin: Double read FfltPrvTin write FfltPrvTin;
    property fltPrcTin: Double read FfltPrcTin write FfltPrcTin;
    property fltFatTin: Double read FfltFatTin write FfltFatTin;
    property strProEmb: String read FstrProEmb write FstrProEmb;
    property strIteEmb: String read FstrIteEmb write FstrIteEmb;
    property fltUniEmb: Double read FfltUniEmb write FfltUniEmb;
    property fltEmbAnt: Double read FfltEmbAnt write FfltEmbAnt;
    property strCodAbf: String read FstrCodAbf write FstrCodAbf;
    property fltPesoIt: Double read FfltPesoIt write FfltPesoIt;
    property fltPesLiq: Double read FfltPesLiq write FfltPesLiq;
    property strPromoc: String read FstrPromoc write FstrPromoc;
    property fltProPreCus: Double read FfltProPreCus write FfltProPreCus;
    property fltProPreVen: Double read FfltProPreVen write FfltProPreVen;
    property fltProComVar: Double read FfltProComVar write FfltProComVar;
    property fltProDesF07: Double read FfltProDesF07 write FfltProDesF07;
    property strTipTin: String read FstrTipTin write FstrTipTin;
    property fltGPeCom: Double read FfltGPeCom write FfltGPeCom;
    property strCodFab: String read FstrCodFab write FstrCodFab;
    property intSeqInd: Integer read FintSeqInd write FintSeqInd;
    property fltQtdBai: Double read FfltQtdBai write FfltQtdBai;
    property strNumOrc: String read FstrNumOrc write FstrNumOrc;
    property strEspOrc: String read FstrEspOrc write FstrEspOrc;
    property strEmpOrc: String read FstrEmpOrc write FstrEmpOrc;
    property fltMarMin: Double read FfltMarMin write FfltMarMin;
    property fltMarMSG: Double read FfltMarMSG write FfltMarMSG;
    property fltMarMGe: Double read FfltMarMGe write FfltMarMGe;
    property strMarca: String read FstrMarca write FstrMarca;
    property strStatus: String read FstrStatus write FstrStatus;
    property fltComDev: Double read FfltComDev write FfltComDev;
    property fltDesDev: Double read FfltDesDev write FfltDesDev;
    property strSeqDet: String read FstrSeqDet write FstrSeqDet;
    property strCatalize: String read FstrCatalize write FstrCatalize;
    property strLinTin: String read FstrLinTin write FstrLinTin;
    property fltEmbala: Double read FfltEmbala write FfltEmbala;
    property strDesNes: String read FstrDesNes write FstrDesNes;
    property strSemEst: String read FstrSemEst write FstrSemEst;
    property strLibEst: String read FstrLibEst write FstrLibEst;
    property fltPreCom: Double read FfltPreCom write FfltPreCom;
    property fltUniDig: Double read FfltUniDig write FfltUniDig;
    property fltQtdPon: Double read FfltQtdPon write FfltQtdPon;
    property strComple: String read FstrComple write FstrComple;
    property strDivDev: String read FstrDivDev write FstrDivDev;
    property strObrCpf: String read FstrObrCpf write FstrObrCpf;
    property strMontad: String read FstrMontad write FstrMontad;
    property strA_n_o_: String read FstrA_n_o_ write FstrA_n_o_;
    property strSigUni: String read FstrSigUni write FstrSigUni;
    property fltVolPro: Double read FfltVolPro write FfltVolPro;
    property intOrdite: Integer read FintOrdite write FintOrdite;
    property strChaFor: String read FstrChaFor write FstrChaFor;
    property strCodAca: String read FstrCodAca write FstrCodAca;
    property strEmpAca: String read FstrEmpAca write FstrEmpAca;
    property blnProAca: Boolean read FblnProAca write FblnProAca;
    property strEspFut: String read FstrEspFut write FstrEspFut;
    property strDocFut: String read FstrDocFut write FstrDocFut;
    property strEmpFut: String read FstrEmpFut write FstrEmpFut;
    property fltOutVal: Double read FfltOutVal write FfltOutVal;
    property fltComTbl: Double read FfltComTbl write FfltComTbl;
    property fltDesOpe: Double read FfltDesOpe write FfltDesOpe;
    property fltICMSai: Double read FfltICMSai write FfltICMSai;
    property fltImpFed: Double read FfltImpFed write FfltImpFed;
    property fltDesMge: Double read FfltDesMge write FfltDesMge;
    property strDocCnf: String read FstrDocCnf write FstrDocCnf;
    property strEspCnf: String read FstrEspCnf write FstrEspCnf;
    property strEmpCnf: String read FstrEmpCnf write FstrEmpCnf;
    property strTabPre: String read FstrTabPre write FstrTabPre;
    property fltIpiEnt: Double read FfltIpiEnt write FfltIpiEnt;
    property fltFreEnt: Double read FfltFreEnt write FfltFreEnt;
    property strCodDil: String read FstrCodDil write FstrCodDil;
    property fltPorDil: Double read FfltPorDil write FfltPorDil;
    property strDilCon: String read FstrDilCon write FstrDilCon;
    property fltPorCat: Double read FfltPorCat write FfltPorCat;
    property strEntRet: String read FstrEntRet write FstrEntRet;
    property strLocRet: String read FstrLocRet write FstrLocRet;
    property strEntFut: String read FstrEntFut write FstrEntFut;
    property strMotFut: String read FstrMotFut write FstrMotFut;
    property dtaDtaEnt: TDateTime read FdtaDtaEnt write FdtaDtaEnt;
    property fltQtdOri: Double read FfltQtdOri write FfltQtdOri;
    property fltDesEsp: Double read FfltDesEsp write FfltDesEsp;
    property fltDesBai: Double read FfltDesBai write FfltDesBai;
    property strImpDir: String read FstrImpDir write FstrImpDir;
    property strLocFis: String read FstrLocFis write FstrLocFis;
    property fltPreCu2: Double read FfltPreCu2 write FfltPreCu2;
    property fltTotCu2: Double read FfltTotCu2 write FfltTotCu2;
    property fltProComAta: Double read FfltProComAta write FfltProComAta;
    property fltProComDis: Double read FfltProComDis write FfltProComDis;
    property fltTotPed: Double read FfltTotPed write FfltTotPed;
    property fltPanUti: Double read FfltPanUti write FfltPanUti;
    property fltTotDes: Double read FfltTotDes write FfltTotDes;
    property ftlTotFre: Double read FftlTotFre write FftlTotFre;
    property recForTin: TForTin read FrecForTin write FrecForTin;
    property strKey_EP: String read FstrKey_EP write FstrKey_EP;
    property strLotAnt: String read FstrLotAnt write FstrLotAnt;
    property strNumLot: String read FstrNumLot write FstrNumLot;
    property strEmpPrd: String read FstrEmpPrd write FstrEmpPrd;
    property strVenCnf: String read FstrVenCnf write FstrVenCnf;
    property blnBxSbIt: Boolean read FblnBxSbIt write FblnBxSbIt;
    property strPigBas: String read FstrPigBas write FstrPigBas;
    property strIdeDev: String read FstrIdeDev write FstrIdeDev;
    property fltQtdDet: Double read FfltQtdDet write FfltQtdDet;
    property strTabDev: String read FstrTabDev write FstrTabDev;
    property strCodBar: String read FstrCodBar write FstrCodBar;
    property strTipFin: String read FstrTipFin write FstrTipFin;
    property fltDesFin: Double read FfltDesFin write FfltDesFin;
    property fltPreLot: Double read FfltPreLot write FfltPreLot;
    property fltCoDvRp: Double read FfltCoDvRp write FfltCoDvRp;
    property strEmpIte: String read FstrEmpIte write FstrEmpIte;
    property fltFatAce: Double read FfltFatAce write FfltFatAce;
    property blnPodAlt: Boolean read FblnPodAlt write FblnPodAlt;
    property strEmpSol: String read FstrEmpSol write FstrEmpSol;
    property strCndDev: String read FstrCndDev write FstrCndDev;
    property strCCndDv: String read FstrCCndDv write FstrCCndDv;
    property dtaEmiDev: TDate read FdtaEmiDev write FdtaEmiDev;
    property fltCusIte: Double read FfltCusIte write FfltCusIte;
    property strDesSim: String read FstrDesSim write FstrDesSim;
    property strOrdPro: String read FstrOrdPro write FstrOrdPro;
    property recMadeira: untTypesSistema.TDadosMadeira read FrecMadeira write FrecMadeira;
    property fltTotImp: Double read FfltTotImp write FfltTotImp;
    property fltVal_RT: Double read FfltVal_RT write FfltVal_RT;
    property fltTaxJur: Double read FfltTaxJur write FfltTaxJur;
    property strSeqGad: String read FstrSeqGad write FstrSeqGad;
    property fltQtdExp: Double read FfltQtdExp write FfltQtdExp;
    property strBarEmb: String read FstrBarEmb write FstrBarEmb;
    property strNumCmp: String read FstrNumCmp write FstrNumCmp;
    property intNItCmp: Integer read FintNItCmp write FintNItCmp;
    property fltDeDVCf: Double read FfltDeDVCf write FfltDeDVCf;
    property strCodMec: String read FstrCodMec write FstrCodMec;
    property strSeqRcd: String read FstrSeqRcd write FstrSeqRcd;
    property intSeqInc: Integer read FintSeqInc write FintSeqInc;
    property strCodVenIte: String read FstrCodVenIte write FstrCodVenIte;
    property strAltPCoIte: String read FstrAltPCoIte write FstrAltPCoIte;
    property fltPerComIte: Double read FfltPerComIte write FfltPerComIte;
    property fltFreDev: Double read FfltFreDev write FfltFreDev;
    property fltDeADev: Double read FfltDeADev write FfltDeADev;
    property blnAlterandoPDORCarregado: Boolean read FblnAlterandoPDORCarregado write FblnAlterandoPDORCarregado;
    property blnInserindoPDORCarregado: Boolean read FblnInserindoPDORCarregado write FblnInserindoPDORCarregado;
    property strCliBus: String read FstrCliBus write FstrCliBus;
    property strTurEnt: String read FstrTurEnt write FstrTurEnt;
    property intSeqCcr: Integer read FintSeqCcr write FintSeqCcr;
    property fltDopTin: Double read FfltDopTin write FfltDopTin;
    property strCodVe2Ite: String read FstrCodVe2Ite write FstrCodVe2Ite;
    property strLibUni: String read FstrLibUni write FstrLibUni;
    property fltValDif: Double read FfltValDif write FfltValDif;
    property strLotAba: String read FstrLotAba write FstrLotAba;
    property strIncFut: String read FstrIncFut write FstrIncFut;
    property strSepExp: String read FstrSepExp write FstrSepExp;
    property strTabPreEmb: String read FstrTabPreEmb write FstrTabPreEmb;
    property strExcIpi: String read FstrExcIpi write FstrExcIpi;
    property fltDesMSu: Double read FfltDesMSu write FfltDesMSu;
    property strAiDvOr: String read FstrAiDvOr write FstrAiDvOr;
    property strClaFis: String read FstrClaFis write FstrClaFis;
    property strSeqOpI: String read FstrSeqOpI write FstrSeqOpI;
    property strRatDes: String read FstrRatDes write FstrRatDes;
    property strBrinde: String read FstrBrinde write FstrBrinde;
    property strCodPar: String read FstrCodPar write FstrCodPar;
    property strTipBri: String read FstrTipBri write FstrTipBri;
    property strSeqGer: String read FstrSeqGer write FstrSeqGer;
    property strBaseQtdZerada: String read FstrBaseQtdZerada write FstrBaseQtdZerada;
    property blnEdiPes: Boolean read FblnEdiPes write FblnEdiPes;
    property fltPesoItCad: Double read FfltPesoItCad write FfltPesoItCad;
    property fltPesLiqCad: Double read FfltPesLiqCad write FfltPesLiqCad;
    property strPegou_: String read FstrPegou_ write FstrPegou_;
    property strIteAbf: String read FstrIteAbf write FstrIteAbf;
    property strAtivac: String read FstrAtivac write FstrAtivac;
    property intSeqCom: Integer read FintSeqCom write FintSeqCom;
    property fltQtdAti: Double read FfltQtdAti write FfltQtdAti;
    property fltQtdCom: Double read FfltQtdCom write FfltQtdCom;
    property strTabCom: String read FstrTabCom write FstrTabCom;
    property fltPorGer: Double read FfltPorGer write FfltPorGer;
    property fltPorDet: Double read FfltPorDet write FfltPorDet;
    property intSeqEst: Integer read FintSeqEst write FintSeqEst;
    property strIteEst: String read FstrIteEst write FstrIteEst;
    property fltUniEst: Double read FfltUniEst write FfltUniEst;
    property fltQtdSbi: Double read FfltQtdSbi write FfltQtdSbi;
    property fltUniSbi: Double read FfltUniSbi write FfltUniSbi;
    property strLotSep: String read FstrLotSep write FstrLotSep;
    property strObsColorista: String read FstrObsColorista write FstrObsColorista;
    property intTipoFormulacao: Integer read FintTipoFormulacao write FintTipoFormulacao;
    property fltFreMkp: Double read FfltFreMkp write FfltFreMkp;
    property fltComMkp: Double read FfltComMkp write FfltComMkp;
    property blnJaFatu: Boolean read FblnJaFatu write FblnJaFatu;
    property strTipFat: String read FstrTipFat write FstrTipFat;
    property strNumFat: String read FstrNumFat write FstrNumFat;
    property strEmpFat: String read FstrEmpFat write FstrEmpFat;
    property strVenFat: String read FstrVenFat write FstrVenFat;
    property strCndFat: String read FstrCndFat write FstrCndFat;
    property fltValFat: Double read FfltValFat write FfltValFat;
    property dtaDtaFat: TDateTime read FdtaDtaFat write FdtaDtaFat;
    property fltComDig: Double read FfltComDig write FfltComDig;
    property fltBFCPST: Double read FfltBFCPST write FfltBFCPST;
    property fltPFCPST: Double read FfltPFCPST write FfltPFCPST;
    property fltVFCPST: Double read FfltVFCPST write FfltVFCPST;
    property intQDEntr: Integer read FintQDEntr write FintQDEntr;
    property strNotC17: String read FstrNotC17 write FstrNotC17;
    property strCodCmg: String read FstrCodCmg write FstrCodCmg;
    property fltQtdSep: Double read FfltQtdSep write FfltQtdSep;
    property fltDesCnd: Double read FfltDesCnd write FfltDesCnd;
    property strProEsp: String read FstrProEsp write FstrProEsp;
    property strPorPer: String read FstrPorPer write FstrPorPer;
    property strExibSE: String read FstrExibSE write FstrExibSE;
    property strFdoIteRecalcPrecos: String read FstrFdoIteRecalcPrecos write FstrFdoIteRecalcPrecos;
    property strOpBxSe: String read FstrOpBxSe write FstrOpBxSe;
    property dtaDtBxSe: TDateTime read FdtaDtBxSe write FdtaDtBxSe;
    property dtaHrBxSe: TDateTime read FdtaHrBxSe write FdtaHrBxSe;
    property strEmpCar: String read FstrEmpCar write FstrEmpCar;
    property strAutoinDevCar: String read FstrAutoinDevCar write FstrAutoinDevCar;
    property strEntFutDocOri: String read FstrEntFutDocOri write FstrEntFutDocOri;
    property strTemNumSerie: String read FstrTemNumSerie write FstrTemNumSerie;
    property strOpSeEx: String read FstrOpSeEx write FstrOpSeEx;
    property strConExp: String read FstrConExp write FstrConExp;
    property strEmbExp: String read FstrEmbExp write FstrEmbExp;
    property strObsExp: String read FstrObsExp write FstrObsExp;
    property strChkOut: String read FstrChkOut write FstrChkOut;
    property fltDesMVM: Double read FfltDesMVM write FfltDesMVM;
    property fltDesMSM: Double read FfltDesMSM write FfltDesMSM;
    property fltDesMGM: Double read FfltDesMGM write FfltDesMGM;
    property fltMarMMV: Double read FfltMarMMV write FfltMarMMV;
    property fltMarMMS: Double read FfltMarMMS write FfltMarMMS;
    property fltMarMMG: Double read FfltMarMMG write FfltMarMMG;
    property fltVDesST: Double read FfltVDesST write FfltVDesST;
    property strMDesST: String read FstrMDesST write FstrMDesST;
    property strReserv: String read FstrReserv write FstrReserv;
    property strMovTriLocFis: String read FstrMovTriLocFis write FstrMovTriLocFis;
    property intSeqInv: Integer read FintSeqInv write FintSeqInv;
    property strSeqEql: String read FstrSeqEql write FstrSeqEql;
    property fltQtdCha: Double read FfltQtdCha write FfltQtdCha;
    property intSeqIte: Integer read FintSeqIte write FintSeqIte;
    property strNumDrw: String read FstrNumDrw write FstrNumDrw;
    property blnMntPrc: Boolean read FblnMntPrc write FblnMntPrc;
    property fltQtdRet: Double read FfltQtdRet write FfltQtdRet;
    property strNumPla: String read FstrNumPla write FstrNumPla;
    property strParNum: String read FstrParNum write FstrParNum;
    property strReqCom: String read FstrReqCom write FstrReqCom;
    property strRegEsp: String read FstrRegEsp write FstrRegEsp;
    property fltFreCot: Double read FfltFreCot write FfltFreCot;
    property blnAltEst: Boolean read FblnAltEst write FblnAltEst;
    property intSeqPer: Integer read FintSeqPer write FintSeqPer;
    property fltValorOriginalItemEstrutura: Double read FfltValorOriginalItemEstrutura write FfltValorOriginalItemEstrutura;
    property blnCalcularComissao: Boolean read FblnCalcularComissao write FblnCalcularComissao;
    property blnCalcularImpostos: Boolean read FblnCalcularImpostos write FblnCalcularImpostos;
    property strCilvas: String read FstrCilvas write FstrCilvas;
    property blnRatEst: Boolean read FblnRatEst write FblnRatEst;
    property strPedRet: String read FstrPedRet write FstrPedRet;
    property blnUpseml: Boolean read FblnUpseml write FblnUpseml;
    property strEmpExp: String read FstrEmpExp write FstrEmpExp;
    property strSobEnc: String read FstrSobEnc write FstrSobEnc;
    property strOpeSep: String read FstrOpeSep write FstrOpeSep;
    property strIteOpeExp: String read FstrIteOpeExp write FstrIteOpeExp;
    property strEmpDmp: String read FstrEmpDmp write FstrEmpDmp;
    property blnTraIte: Boolean read FblnTraIte write FblnTraIte;
    property strTabAnt: String read FstrTabAnt write FstrTabAnt;
    property fltPreAnt: Double read FfltPreAnt write FfltPreAnt;
    property fltCfbIpi: Double read FfltCfbIpi write FfltCfbIpi;
    property fltCfaIpi: Double read FfltCfaIpi write FfltCfaIpi;
    property fltCfvIpi: Double read FfltCfvIpi write FfltCfvIpi;
    property strDocIpi: String read FstrDocIpi write FstrDocIpi;
    property strEspIpi: String read FstrEspIpi write FstrEspIpi;
    property strEmpIpi: String read FstrEmpIpi write FstrEmpIpi;
    property strSeqVdp: String read FstrSeqVdp write FstrSeqVdp;
    property strBasTro: String read FstrBasTro write FstrBasTro;
    property strITinDv: String read FstrITinDv write FstrITinDv;
    property blnTipBusCodBar: Boolean read FblnTipBusCodBar write FblnTipBusCodBar;
    property dtaDtaCmp: TDate read FdtaDtaCmp write FdtaDtaCmp;
    property strCodDig: String read FstrCodDig write FstrCodDig;
    property strTckQbt: String read FstrTckQbt write FstrTckQbt;

  end;
implementation

{ TDadosItemDTO }

constructor TDadosItemDTO.CreateComAtributos(
                          cdsDados: TUniClientDataSet;
                          btnAdicionar: TBitBtnLocked;
                          strIdePro,
                          strCodGru,
                          strCodIte,
                          strDesOri,
                          strDesIte,
                          strDesFab,
                          strUnidad,
                          strCodUni,
                          strCodMar,
                          strCodFor,
                          strRefere: String;
                          fltUniOri,
                          fltUniVis,
                          fltUniTar,
                          fltUniTmp,
                          fltDesCon,
                          fltQtdIte,
                          fltTotIte: Double;
                          strEntSai: String;
                          fltPreCus,
                          fltTotCus: Double;
                          strComLub: String;
                          fltIpiSai,
                          fltDesMax,

                          fltPreVe1,
                          fltPreVe2,
                          fltPreVe3,
                          fltPreVe4,
                          fltPreVe5,
                          fltPreVe6,
                          fltPreVe7,

                          fltMarLuc,
                          fltSaldos: Double;
                          strIncPis: String;
                          fltComVar,
                          fltComAta,
                          fltComDis: Double;
                          strDocDev,
                          strEspDev,
                          strEmpDev: String;
                          fltQtdDev,
                          fltUniDev: Double;
                          strIncDev: String;
                          fltTotUlt,
                          fltImpUlt,
                          fltPreUlt,
                          fltPreMed: Double;
                          strClaIpi,
                          strIteCha,
                          strIteTin,
                          strDesCor,
                          strTipPre: String;
                          intLazQua: Integer;
                          strTipEmb: String;
                          fltQtdEmb,
                          fltPreEmb: Double;
                          fltPrvTin,
                          fltPrcTin,
                          fltFatTin: Double;
                          strProEmb,
                          strIteEmb: String;
                          fltUniEmb,
                          fltEmbAnt: Double;

                          strCodAbf: String;
                          fltPesoIt: Double;
                          fltPesLiq: Double;
                          strPromoc: String;
                          fltProPreCus,
                          fltProPreVen,
                          fltProComVar,
                          fltProDesF07 : Double;
                          strTipTin: String;
                          fltGPeCom: Double;
                          strCodFab: String;
                          intSeqInd: Integer;
                          fltQtdBai: Double;
                          strNumOrc,
                          strEspOrc,
                          strEmpOrc: String;
                          fltMarMin,
                          fltMarMSG,
                          fltMarMGe: Double;
                          strMarca,
                          strStatus: String;
                          fltComDev,
                          fltDesDev: Double;
                          strSeqDet,
                          strCatalize,
                          strLinTin: String;
                          fltEmbala: Double;
                          strDesNes,
                          strSemEst,
                          strLibEst: String;//Liberou sem estoque mediante senha
                          fltPreCom,
                          fltUniDig: Double;
                          fltQtdPon: Double;
                          strComple,
                          strDivDev,
                          strObrCpf,
                          strMontad,
                          strA_n_o_: String;
                          strSigUni: String;
                          fltVolPro: Double;
                          intOrdite: Integer;
                          strChaFor,
                          strCodAca,
                          strEmpAca: String;
                          blnProAca: Boolean;
                          strEspFut,
                          strDocFut,
                          strEmpFut: String;
                          fltOutVal,
                          fltComTbl,
                          fltDesOpe,
                          fltICMSai,
                          fltImpFed,
                          fltDesMge: Double;
                          strDocCnf,
                          strEspCnf,
                          strEmpCnf,
                          strTabPre: String;
                          fltIpiEnt,
                          fltFreEnt: Double;
                          strCodDil: String;
                          fltPorDil: Double;
                          strDilCon: String;
                          fltPorCat: Double;
                          strEntRet,
                          strLocRet,
                          strEntFut,
                          strMotFut: String;
                          dtaDtaEnt: TDateTime;
                          fltQtdOri,
                          fltDesEsp,
                          fltDesBai: Double;
                          strImpDir,
                          strLocFis: String;
                          fltPreCu2,
                          fltTotCu2,
                          fltProComAta,
                          fltProComDis,
                          fltTotPed,
                          fltPanUti,
                          fltTotDes,
                          ftlTotFre: Double;
                          recForTin: TForTin;
                          strKey_EP,
                          strLotAnt,
                          strNumLot: String;
                          strEmpPrd: String;
                          strVenCnf: String;
                          blnBxSbIt: Boolean;
                          strPigBas: String;
                          strIdeDev: String;
                          fltQtdDet: Double;
                          strTabDev: String;
                          strCodBar: String;
                          strTipFin: String;
                          fltDesFin,
                          fltPreLot,
                          fltCoDvRp: Double;
                          strEmpIte: String;
                          fltFatAce: Double;
                          blnPodAlt: Boolean;
                          strEmpSol,
                          strCndDev,
                          strCCndDv: String;
                          dtaEmiDev: TDate;
                          fltCusIte: Double;
                          strDesSim: String;
                          strOrdPro: String;
                          recMadeira: untTypesSistema.TDadosMadeira;
                          fltTotImp: Double;
                          fltVal_RT: Double = 0;
                          fltTaxJur: Double = 0;
                          strSeqGad: String = '';
                          fltQtdExp: Double = 0;
                          strBarEmb: String = '';
                          strNumCmp: String = '';
                          intNItCmp: Integer = 0;
                          fltDeDVCf: Double = 0;
                          strCodMec: String = '';
                          strSeqRcd: String = '';
                          intSeqInc: Integer = 0;
                          strCodVenIte: String = '';
                          strAltPCoIte: String = 'N';
                          fltPerComIte: Double = 0;
                          fltFreDev: Double = 0;
                          fltDeADev: Double = 0;
                          blnAlterandoPDORCarregado: Boolean = False;
                          blnInserindoPDORCarregado: Boolean = False;
                          strCliBus: String = 'N';
                          strTurEnt: String = '';
                          intSeqCcr: Integer = 0;
                          fltDopTin: Double = 0;
                          strCodVe2Ite: String = '';
                          strLibUni: String = 'N';
                          fltValDif: Double = 0;
                          strLotAba: String = '';
                          strIncFut: String = '';
                          strSepExp: String = '';
                          strTabPreEmb: String = '';
                          strExcIpi: String = '';
                          fltDesMSu: Double = 0.00;
                          strAiDvOr: String = '';
                          strClaFis: String = '';
                          strSeqOpI: String = '';
                          strRatDes: String = 'S';
                          strBrinde: String = 'N';
                          strCodPar: String = '';
                          strTipBri: String = '';
                          strSeqGer: String = '';
                          strBaseQtdZerada: String = '';
                          blnEdiPes: Boolean = False;
                          fltPesoItCad: Double = -1;
                          fltPesLiqCad: Double = -1;
                          strPegou_: String = 'N';
                          strIteAbf: String = '';
                          strAtivac: String = 'N';
                          intSeqCom: Integer = 0;
                          fltQtdAti: Double = 0;
                          fltQtdCom: Double = 0;
                          strTabCom: String = '';
                          fltPorGer: Double = 0;
                          fltPorDet: Double = 0;
                          intSeqEst: Integer = 0;
                          strIteEst: String = '';
                          fltUniEst: Double = 0;
                          fltQtdSbi: Double = 0;
                          fltUniSbi: Double = 0;
                          strLotSep: String='';
                          strObsColorista : String = '';
                          intTipoFormulacao : Integer = 0;
                          fltFreMkp: Double = 0;
                          fltComMkp: Double = 0;
                          blnJaFatu: Boolean = False;
                          strTipFat: String = '';
                          strNumFat: String = '';
                          strEmpFat: String = '';
                          strVenFat: String = '';
                          strCndFat: String = '';
                          fltValFat: Double = 0;
                          dtaDtaFat: TDateTime = 0;
                          fltComDig: Double = 0;
                          fltBFCPST: Double = 0;
                          fltPFCPST: Double = 0;
                          fltVFCPST: Double = 0;
                          intQDEntr: Integer = 0;
                          strNotC17: String = '';
                          strCodCmg: String = '';
                          fltQtdSep: Double = 0;
                          fltDesCnd: Double = 0;
                          strProEsp: String = '';
                          strPorPer: String = '';
                          strExibSE: String = 'N';
                          strFdoIteRecalcPrecos: String = 'N';
                          strOpBxSe: String = '';
                          dtaDtBxSe: TDateTime = 0;
                          dtaHrBxSe: TDateTime = 0;
                          strEmpCar: String = '';
                          strAutoinDevCar: String = '';
                          strEntFutDocOri: String = '';
                          strTemNumSerie: String = '';
                          strOpSeEx: String = '';
                          strConExp: String = '';
                          strEmbExp: String = '';
                          strObsExp: String = '';
                          strChkOut: String = '';
                          fltDesMVM: Double = 0;
                          fltDesMSM: Double = 0;
                          fltDesMGM: Double = 0;
                          fltMarMMV: Double = 0;
                          fltMarMMS: Double = 0;
                          fltMarMMG: Double = 0;
                          fltVDesST: Double = 0;
                          strMDesST: String = '';
                          strReserv: String = 'S';
                          strMovTriLocFis: String = '';
                          intSeqInv: Integer = 0;
                          strSeqEql: String = '';
                          fltQtdCha: Double = 0;
                          intSeqIte: Integer = 0;
                          strNumDrw: String = '';
                          blnMntPrc: Boolean = False;
                          fltQtdRet: Double = 0;
                          strNumPla: String = '';
                          strParNum: String = '';
                          strReqCom: String = '';
                          strRegEsp: String = '';
                          fltFreCot: Double = 0;
                          blnAltEst: Boolean = False;
                          intSeqPer: Integer = 0;
                          fltValorOriginalItemEstrutura: Double = 0;
                          blnCalcularComissao: Boolean = True;
                          blnCalcularImpostos: Boolean = True;
                          strCilvas: String = 'N';
                          blnRatEst: Boolean = False;
                          strPedRet: String = '';
                          blnUpseml: Boolean = False;
                          strEmpExp: String = '';
                          strSobEnc: String = '';
                          strOpeSep: String = '';
                          strIteOpeExp: String = '';
                          strEmpDmp: String = '';
                          blnTraIte: Boolean = False;
                          strTabAnt: String = '';
                          fltPreAnt: Double = 0;
                          fltCfbIpi: Double = 0;
                          fltCfaIpi: Double = 0;
                          fltCfvIpi: Double = 0;
                          strDocIpi: String = '';
                          strEspIpi: String = '';
                          strEmpIpi: String = '';
                          strSeqVdp: String = '';
                          strBasTro: String = 'N';
                          strITinDv: String = '';
                          blnTipBusCodBar: Boolean = False;
                          dtaDtaCmp: TDate = 0;
                          strCodDig: String = '';
                          strTckQbt: String = ''
                          );
begin
  FCdsDados := CdsDados;
  FBtnAdicionar := BtnAdicionar;
  FstrIdePro := strIdePro;
  FstrCodGru := strCodGru;
  FstrCodIte := strCodIte;
  FstrDesOri := strDesOri;
  FstrDesIte := strDesIte;
  FstrDesFab := strDesFab;
  FstrUnidad := strUnidad;
  FstrCodUni := strCodUni;
  FstrCodMar := strCodMar;
  FstrCodFor := strCodFor;
  FstrRefere := strRefere;
  FfltUniOri := fltUniOri;
  FfltUniVis := fltUniVis;
  FfltUniTar := fltUniTar;
  FfltUniTmp := fltUniTmp;
  FfltDesCon := fltDesCon;
  FfltQtdIte := fltQtdIte;
  FfltTotIte := fltTotIte;
  FstrEntSai := strEntSai;
  FfltPreCus := fltPreCus;
  FfltTotCus := fltTotCus;
  FstrComLub := strComLub;
  FfltIpiSai := fltIpiSai;
  FfltDesMax := fltDesMax;
  FfltPreVe1 := fltPreVe1;
  FfltPreVe2 := fltPreVe2;
  FfltPreVe3 := fltPreVe3;
  FfltPreVe4 := fltPreVe4;
  FfltPreVe5 := fltPreVe5;
  FfltPreVe6 := fltPreVe6;
  FfltPreVe7 := fltPreVe7;
  FfltMarLuc := fltMarLuc;
  FfltSaldos := fltSaldos;
  FstrIncPis := strIncPis;
  FfltComVar := fltComVar;
  FfltComAta := fltComAta;
  FfltComDis := fltComDis;
  FstrDocDev := strDocDev;
  FstrEspDev := strEspDev;
  FstrEmpDev := strEmpDev;
  FfltQtdDev := fltQtdDev;
  FfltUniDev := fltUniDev;
  FstrIncDev := strIncDev;
  FfltTotUlt := fltTotUlt;
  FfltImpUlt := fltImpUlt;
  FfltPreUlt := fltPreUlt;
  FfltPreMed := fltPreMed;
  FstrClaIpi := strClaIpi;
  FstrIteCha := strIteCha;
  FstrIteTin := strIteTin;
  FstrDesCor := strDesCor;
  FstrTipPre := strTipPre;
  FintLazQua := intLazQua;
  FstrTipEmb := strTipEmb;
  FfltQtdEmb := fltQtdEmb;
  FfltPreEmb := fltPreEmb;
  FfltPrvTin := fltPrvTin;
  FfltPrcTin := fltPrcTin;
  FfltFatTin := fltFatTin;
  FstrProEmb := strProEmb;
  FstrIteEmb := strIteEmb;
  FfltUniEmb := fltUniEmb;
  FfltEmbAnt := fltEmbAnt;
  FstrCodAbf := strCodAbf;
  FfltPesoIt := fltPesoIt;
  FfltPesLiq := fltPesLiq;
  FstrPromoc := strPromoc;
  FfltProPreCus := fltProPreCus;
  FfltProPreVen := fltProPreVen;
  FfltProComVar := fltProComVar;
  FfltProDesF07 := fltProDesF07;
  FstrTipTin := strTipTin;
  FfltGPeCom := fltGPeCom;
  FstrCodFab := strCodFab;
  FintSeqInd := intSeqInd;
  FfltQtdBai := fltQtdBai;
  FstrNumOrc := strNumOrc;
  FstrEspOrc := strEspOrc;
  FstrEmpOrc := strEmpOrc;
  FfltMarMin := fltMarMin;
  FfltMarMSG := fltMarMSG;
  FfltMarMGe := fltMarMGe;
  FstrMarca := strMarca;
  FstrStatus := strStatus;
  FfltComDev := fltComDev;
  FfltDesDev := fltDesDev;
  FstrSeqDet := strSeqDet;
  FstrCatalize := strCatalize;
  FstrLinTin := strLinTin;
  FfltEmbala := fltEmbala;
  FstrDesNes := strDesNes;
  FstrSemEst := strSemEst;
  FstrLibEst := strLibEst;
  FfltPreCom := fltPreCom;
  FfltUniDig := fltUniDig;
  FfltQtdPon := fltQtdPon;
  FstrComple := strComple;
  FstrDivDev := strDivDev;
  FstrObrCpf := strObrCpf;
  FstrMontad := strMontad;
  FstrA_n_o_ := strA_n_o_;
  FstrSigUni := strSigUni;
  FfltVolPro := fltVolPro;
  FintOrdite := intOrdite;
  FstrChaFor := strChaFor;
  FstrCodAca := strCodAca;
  FstrEmpAca := strEmpAca;
  FblnProAca := blnProAca;
  FstrEspFut := strEspFut;
  FstrDocFut := strDocFut;
  FstrEmpFut := strEmpFut;
  FfltOutVal := fltOutVal;
  FfltComTbl := fltComTbl;
  FfltDesOpe := fltDesOpe;
  FfltICMSai := fltICMSai;
  FfltImpFed := fltImpFed;
  FfltDesMge := fltDesMge;
  FstrDocCnf := strDocCnf;
  FstrEspCnf := strEspCnf;
  FstrEmpCnf := strEmpCnf;
  FstrTabPre := strTabPre;
  FfltIpiEnt := fltIpiEnt;
  FfltFreEnt := fltFreEnt;
  FstrCodDil := strCodDil;
  FfltPorDil := fltPorDil;
  FstrDilCon := strDilCon;
  FfltPorCat := fltPorCat;
  FstrEntRet := strEntRet;
  FstrLocRet := strLocRet;
  FstrEntFut := strEntFut;
  FstrMotFut := strMotFut;
  FdtaDtaEnt := dtaDtaEnt;
  FfltQtdOri := fltQtdOri;
  FfltDesEsp := fltDesEsp;
  FfltDesBai := fltDesBai;
  FstrImpDir := strImpDir;
  FstrLocFis := strLocFis;
  FfltPreCu2 := fltPreCu2;
  FfltTotCu2 := fltTotCu2;
  FfltProComAta := fltProComAta;
  FfltProComDis := fltProComDis;
  FfltTotPed := fltTotPed;
  FfltPanUti := fltPanUti;
  FfltTotDes := fltTotDes;
  FftlTotFre := ftlTotFre;
  FrecForTin := recForTin;
  FstrKey_EP := strKey_EP;
  FstrLotAnt := strLotAnt;
  FstrNumLot := strNumLot;
  FstrEmpPrd := strEmpPrd;
  FstrVenCnf := strVenCnf;
  FblnBxSbIt := blnBxSbIt;
  FstrPigBas := strPigBas;
  FstrIdeDev := strIdeDev;
  FfltQtdDet := fltQtdDet;
  FstrTabDev := strTabDev;
  FstrCodBar := strCodBar;
  FstrTipFin := strTipFin;
  FfltDesFin := fltDesFin;
  FfltPreLot := fltPreLot;
  FfltCoDvRp := fltCoDvRp;
  FstrEmpIte := strEmpIte;
  FfltFatAce := fltFatAce;
  FblnPodAlt := blnPodAlt;
  FstrEmpSol := strEmpSol;
  FstrCndDev := strCndDev;
  FstrCCndDv := strCCndDv;
  FdtaEmiDev := dtaEmiDev;
  FfltCusIte := fltCusIte;
  FstrDesSim := strDesSim;
  FstrOrdPro := strOrdPro;
  FrecMadeira := recMadeira;
  FfltTotImp := fltTotImp;
  FfltVal_RT := fltVal_RT;
  FfltTaxJur := fltTaxJur;
  FstrSeqGad := strSeqGad;
  FfltQtdExp := fltQtdExp;
  FstrBarEmb := strBarEmb;
  FstrNumCmp := strNumCmp;
  FintNItCmp := intNItCmp;
  FfltDeDVCf := fltDeDVCf;
  FstrCodMec := strCodMec;
  FstrSeqRcd := strSeqRcd;
  FintSeqInc := intSeqInc;
  FstrCodVenIte := strCodVenIte;
  FstrAltPCoIte := strAltPCoIte;
  FfltPerComIte := fltPerComIte;
  FfltFreDev := fltFreDev;
  FfltDeADev := fltDeADev;
  FblnAlterandoPDORCarregado := blnAlterandoPDORCarregado;
  FblnInserindoPDORCarregado := blnInserindoPDORCarregado;
  FstrCliBus := strCliBus;
  FstrTurEnt := strTurEnt;
  FintSeqCcr := intSeqCcr;
  FfltDopTin := fltDopTin;
  FstrCodVe2Ite := strCodVe2Ite;
  FstrLibUni := strLibUni;
  FfltValDif := fltValDif;
  FstrLotAba := strLotAba;
  FstrIncFut := strIncFut;
  FstrSepExp := strSepExp;
  FstrTabPreEmb := strTabPreEmb;
  FstrExcIpi := strExcIpi;
  FfltDesMSu := fltDesMSu;
  FstrAiDvOr := strAiDvOr;
  FstrClaFis := strClaFis;
  FstrSeqOpI := strSeqOpI;
  FstrRatDes := strRatDes;
  FstrBrinde := strBrinde;
  FstrCodPar := strCodPar;
  FstrTipBri := strTipBri;
  FstrSeqGer := strSeqGer;
  FstrBaseQtdZerada := strBaseQtdZerada;
  FblnEdiPes := blnEdiPes;
  FfltPesoItCad := fltPesoItCad;
  FfltPesLiqCad := fltPesLiqCad;
  FstrPegou_ := strPegou_;
  FstrIteAbf := strIteAbf;
  FstrAtivac := strAtivac;
  FintSeqCom := intSeqCom;
  FfltQtdAti := fltQtdAti;
  FfltQtdCom := fltQtdCom;
  FstrTabCom := strTabCom;
  FfltPorGer := fltPorGer;
  FfltPorDet := fltPorDet;
  FintSeqEst := intSeqEst;
  FstrIteEst := strIteEst;
  FfltUniEst := fltUniEst;
  FfltQtdSbi := fltQtdSbi;
  FfltUniSbi := fltUniSbi;
  FstrLotSep := strLotSep;
  FstrObsColorista := strObsColorista;
  FintTipoFormulacao := intTipoFormulacao;
  FfltFreMkp := fltFreMkp;
  FfltComMkp := fltComMkp;
  FblnJaFatu := blnJaFatu;
  FstrTipFat := strTipFat;
  FstrNumFat := strNumFat;
  FstrEmpFat := strEmpFat;
  FstrVenFat := strVenFat;
  FstrCndFat := strCndFat;
  FfltValFat := fltValFat;
  FdtaDtaFat := dtaDtaFat;
  FfltComDig := fltComDig;
  FfltBFCPST := fltBFCPST;
  FfltPFCPST := fltPFCPST;
  FfltVFCPST := fltVFCPST;
  FintQDEntr := intQDEntr;
  FstrNotC17 := strNotC17;
  FstrCodCmg := strCodCmg;
  FfltQtdSep := fltQtdSep;
  FfltDesCnd := fltDesCnd;
  FstrProEsp := strProEsp;
  FstrPorPer := strPorPer;
  FstrExibSE := strExibSE;
  FstrFdoIteRecalcPrecos := strFdoIteRecalcPrecos;
  FstrOpBxSe := strOpBxSe;
  FdtaDtBxSe := dtaDtBxSe;
  FdtaHrBxSe := dtaHrBxSe;
  FstrEmpCar := strEmpCar;
  FstrAutoinDevCar := strAutoinDevCar;
  FstrEntFutDocOri := strEntFutDocOri;
  FstrTemNumSerie := strTemNumSerie;
  FstrOpSeEx := strOpSeEx;
  FstrConExp := strConExp;
  FstrEmbExp := strEmbExp;
  FstrObsExp := strObsExp;
  FstrChkOut := strChkOut;
  FfltDesMVM := fltDesMVM;
  FfltDesMSM := fltDesMSM;
  FfltDesMGM := fltDesMGM;
  FfltMarMMV := fltMarMMV;
  FfltMarMMS := fltMarMMS;
  FfltMarMMG := fltMarMMG;
  FfltVDesST := fltVDesST;
  FstrMDesST := strMDesST;
  FstrReserv := strReserv;
  FstrMovTriLocFis := strMovTriLocFis;
  FintSeqInv := intSeqInv;
  FstrSeqEql := strSeqEql;
  FfltQtdCha := fltQtdCha;
  FintSeqIte := intSeqIte;
  FstrNumDrw := strNumDrw;
  FblnMntPrc := blnMntPrc;
  FfltQtdRet := fltQtdRet;
  FstrNumPla := strNumPla;
  FstrParNum := strParNum;
  FstrReqCom := strReqCom;
  FstrRegEsp := strRegEsp;
  FfltFreCot := fltFreCot;
  FblnAltEst := blnAltEst;
  FintSeqPer := intSeqPer;
  FfltValorOriginalItemEstrutura := fltValorOriginalItemEstrutura;
  FblnCalcularComissao := blnCalcularComissao;
  FblnCalcularImpostos := blnCalcularImpostos;
  FstrCilvas := strCilvas;
  FblnRatEst := blnRatEst;
  FstrPedRet := strPedRet;
  FblnUpseml := blnUpseml;
  FstrEmpExp := strEmpExp;
  FstrSobEnc := strSobEnc;
  FstrOpeSep := strOpeSep;
  FstrIteOpeExp := strIteOpeExp;
  FstrEmpDmp := strEmpDmp;
  FblnTraIte := blnTraIte;
  FstrTabAnt := strTabAnt;
  FfltPreAnt := fltPreAnt;
  FfltCfbIpi := fltCfbIpi;
  FfltCfaIpi := fltCfaIpi;
  FfltCfvIpi := fltCfvIpi;
  FstrDocIpi := strDocIpi;
  FstrEspIpi := strEspIpi;
  FstrEmpIpi := strEmpIpi;
  FstrSeqVdp := strSeqVdp;
  FstrBasTro := strBasTro;
  FstrITinDv := strITinDv;
  FblnTipBusCodBar := blnTipBusCodBar;
  FdtaDtaCmp := dtaDtaCmp;
  FstrCodDig := strCodDig;
  FstrTckQbt := strTckQbt;
end;

constructor TDadosItemDTO.Create;
begin
  //Valores Default
  FfltVal_RT := 0;
  FfltTaxJur := 0;
  FstrSeqGad := '';
  FfltQtdExp := 0;
  FstrBarEmb := '';
  FstrNumCmp := '';
  FintNItCmp := 0;
  FfltDeDVCf := 0;
  FstrCodMec := '';
  FstrSeqRcd := '';
  FintSeqInc := 0;
  FstrCodVenIte := '';
  FstrAltPCoIte := 'N';
  FfltPerComIte := 0;
  FfltFreDev := 0;
  FfltDeADev := 0;
  FblnAlterandoPDORCarregado := False;
  FblnInserindoPDORCarregado := False;
  FstrCliBus := 'N';
  FstrTurEnt := '';
  FintSeqCcr := 0;
  FfltDopTin := 0;
  FstrCodVe2Ite := '';
  FstrLibUni := 'N';
  FfltValDif := 0;
  FstrLotAba := '';
  FstrIncFut := '';
  FstrSepExp := '';
  FstrTabPreEmb := '';
  FstrExcIpi := '';
  FfltDesMSu := 0.00;
  FstrAiDvOr := '';
  FstrClaFis := '';
  FstrSeqOpI := '';
  FstrRatDes := 'S';
  FstrBrinde := 'N';
  FstrCodPar := '';
  FstrTipBri := '';
  FstrSeqGer := '';
  FstrBaseQtdZerada := '';
  FblnEdiPes := False;
  FfltPesoItCad := -1;
  FfltPesLiqCad := -1;
  FstrPegou_ := 'N';
  FstrIteAbf := '';
  FstrAtivac := 'N';
  FintSeqCom := 0;
  FfltQtdAti := 0;
  FfltQtdCom := 0;
  FstrTabCom := '';
  FfltPorGer := 0;
  FfltPorDet := 0;
  FintSeqEst := 0;
  FstrIteEst := '';
  FfltUniEst := 0;
  FfltQtdSbi := 0;
  FfltUniSbi := 0;
  FstrLotSep := '';
  FstrObsColorista := '';
  FintTipoFormulacao := 0;
  FfltFreMkp := 0;
  FfltComMkp := 0;
  FblnJaFatu := False;
  FstrTipFat := '';
  FstrNumFat := '';
  FstrEmpFat := '';
  FstrVenFat := '';
  FstrCndFat := '';
  FfltValFat := 0;
  FdtaDtaFat := 0;
  FfltComDig := 0;
  FfltBFCPST := 0;
  FfltPFCPST := 0;
  FfltVFCPST := 0;
  FintQDEntr := 0;
  FstrNotC17 := '';
  FstrCodCmg := '';
  FfltQtdSep := 0;
  FfltDesCnd := 0;
  FstrProEsp := '';
  FstrPorPer := '';
  FstrExibSE := 'N';
  FstrFdoIteRecalcPrecos := 'N';
  FstrOpBxSe := '';
  FdtaDtBxSe := 0;
  FdtaHrBxSe := 0;
  FstrEmpCar := '';
  FstrAutoinDevCar := '';
  FstrEntFutDocOri := '';
  FstrTemNumSerie := '';
  FstrOpSeEx := '';
  FstrConExp := '';
  FstrEmbExp := '';
  FstrObsExp := '';
  FstrChkOut := '';
  FfltDesMVM := 0;
  FfltDesMSM := 0;
  FfltDesMGM := 0;
  FfltMarMMV := 0;
  FfltMarMMS := 0;
  FfltMarMMG := 0;
  FfltVDesST := 0;
  FstrMDesST := '';
  FstrReserv := 'S';
  FstrMovTriLocFis := '';
  FintSeqInv := 0;
  FstrSeqEql := '';
  FfltQtdCha := 0;
  FintSeqIte := 0;
  FstrNumDrw := '';
  FblnMntPrc := False;
  FfltQtdRet := 0;
  FstrNumPla := '';
  FstrParNum := '';
  FstrReqCom := '';
  FstrRegEsp := '';
  FfltFreCot := 0;
  FblnAltEst := False;
  FintSeqPer := 0;
  FfltValorOriginalItemEstrutura := 0;
  FblnCalcularComissao := True;
  FblnCalcularImpostos := True;
  FstrCilvas := 'N';
  FblnRatEst := False;
  FstrPedRet := '';
  FblnUpseml := False;
  FstrEmpExp := '';
  FstrSobEnc := '';
  FstrOpeSep := '';
  FstrIteOpeExp := '';
  FstrEmpDmp := '';
  FblnTraIte := False;
  FstrTabAnt := '';
  FfltPreAnt := 0;
  FfltCfbIpi := 0;
  FfltCfaIpi := 0;
  FfltCfvIpi := 0;
  FstrDocIpi := '';
  FstrEspIpi := '';
  FstrEmpIpi := '';
  FstrSeqVdp := '';
  FstrBasTro := 'N';
  FstrITinDv := '';
  FblnTipBusCodBar := False;
  FdtaDtaCmp := 0;
  FstrCodDig := '';
  FstrTckQbt := '';
end;

end.
