unit untNotGer;

interface

uses
  SysUtils, Classes, DB,   Uni, untTypesSistema,
  Variants, untfuncoesSimples, untFinanceira, StrUtils;

    function fGravaNotGer(Var strAutInc: String;
                          strCodEmp,
                          strNumDoc,
                          strEspDoc,
                          strCodCli,
                          strCodTra,
                          strCodVen,
                          strSerie: String;
                          dtaDtaEnt,
                          dtaHorEnt: TDateTime;
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
                          blnJaFatu: Boolean;
                          strTipFat,
                          strNumFat,
                          strEmpFat: String;
                          dtaDtaFat: TDateTime;
                          strVenFat,
                          strCndFat: String;
                          fltValFat: Double;
                          strNotEsp: String;
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
                          strTip_Fc,
                          strCodFor: String;
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
                          fltCsSeDv,
                          fltDupRec,
                          fltValAdt,
                          fltBasOrg,
                          fltIcmOrg: Double;
                          intNConhe: Integer;
                          strEntFat,
                          strCliFat,
                          strOpeExp: String;
                          fltBaRtSp,
                          fltVlRtSp: Double; // Operador da Expedição
                          strNumReg: String;
                          intGrpNot: Integer;
                          strClaFi4,
                          strCodEve: String;
                          strAutEnt,
                          strObsNfe,
                          strConsum: String;
                          dtaDtEntr: TDateTime;
                          fltValCre: Double = 0;
                          dtaDtEsNf: TDateTime = 0;
                          tmrHrEsNf: TDateTime = 0;
                          objFinanc: TFinanceira = Nil;
                          intIpDpCi: Integer = 0;
                          strCodObr: String = '';
                          strCodArt: String = '';
                          strRetIss: String = '';
                          strOpcDoc: String = '';
                          fltBasAnt: Double = 0;            //BASE DE ICMS ANTECIPADO
                          fltValAnt: Double = 0;            //VALOR DE ICMS ANTECIPADO
                          strEntUrg: String = '';
                          fltDeDVCf: Double = 0;
                          fltImpPag: Double = 0;
                          strChvNfeDev: String = '';
                          strNumCOODev: String = '';
                          strNumSerDev: String = '';
                          strNumUSUDev: String = '';
                          strTipDocDev: String = '';
                          fltTotDif: Double = 0;
                          objFazenda: Pointer = nil;
                          fltFedImp: Double = 0;
                          fltEstImp: Double = 0;
                          fltMunImp: Double = 0;
                          fltTroco_: Double = 0;
                          strObsNfeFis: String = '';
                          strEmlCon: String = '';
                          strComVal: String = '';
                          strPlaVei: String = '';
                          strKm_Vei: String = '';
                          strVenPre: String = 'N';
                          strNumera: String = '';
                          strEdiPes: String = 'N';
                          fltVrdIcm: Double = 0;
                          fltBasVrd: Double = 0;
                          blnImpPdv: Boolean = False;
                          strCodEmbarcacao: String = '';
                          strNotPau: String = 'S';
                          fltTotBri: Double = 0;
                          strCliCtt: String = '';
                          strNatCfo: String = '';
                          strPlaFat: String = '';
                          strEntFutOpc: String = '';
                          fltTotIpiEntFut: Double = 0;
                          fltTotRetEntFut: Double = 0;
                          fltTotFcpSTEntFut: Double = 0;
                          strNumeroRandomico : String = '';
                          strNumeroDrawback : string = '';
                          fltFreCot: Double = 0;
                          blnRegEs2: Boolean = False;
                          strAutIcv: String = '';
                          strDocAba: String = '';
                          strEspAba: String = '';
                          strEmpAba: String = '';
                          strCliCEO: String = '';
                          fltVolSepExc: Double = 0;
                          fltVolSepNExc: Double = 0;
                          strCodPrj: String = '';
                          strAbf_Uf: String = '';
                          strCelCon: String = '';
                          strVchCdp: String = '';
                          strCodCno: String = '';
                          fltTotIbs:   Double = 0;
                          fltTotCbs:   Double = 0;
                          fltTotIs:    Double = 0;
                          fltTotProIs: Double = 0;
                          fltTotNf:    Double = 0;
                          strInsImo : String = '';
                          strCodCib : String = ''
                          ): Boolean;

    function fGravaNotDet(Var strAutInc: String;
                          strSeqGer: String;
                          strCodEmp,
                          strCodCli,
                          strNumDoc,
                          strEspDoc,
                          strSerie,
                          strCodIte,
                          strCodDiv,
                          strCodMar,
                          strCodVen: String;
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
                          strNotEsp,
                          strCodDig,
                          strCodCnd,
                          strCodFpg,
                          strProEmb,
                          strIteEmb,
                          strGruEmb: String;
                          intLazQua: Integer;
                          strPromoc,
                          strSeqTin: String;
                          fltQtdPul: Double;
                          strOriDoc,
                          strTip_Fc,
                          strCodFor: String;
                          fltQtdEmb,
                          fltPreEmb: Double;
                          strCliFat: String;
                          fltBcaMin,
                          fltBcaCom,
                          fltVolPro: Double;
                          strTabPre: String;
                          fltUniDig: Double;
                          fltQtdPon: Double;
                          strEntFut,
                          strMotFut: String;
                          dtaDtaFut: TDateTime;
                          fltTotCu2: Double;
                          fltComRep,
                          fltPerRep: Double;
                          strCodAca,
                          strEmpAca: String;
                          blnProAca: Boolean;
                          fltTotUlt,
                          fltImpUlt,
                          fltBaRtSp,
                          fltVaRtSp,
                          fltIcOpPr: Double;
                          intSeqCcr: Integer;
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
                          fltPesLiq: Double;
                          fltBasAnt: Double = 0;
                          fltIcmAnt: Double = 0;
                          fltOutIcm: Double = 0;
                          fltIseIcm: Double = 0;
                          fltFreSug: Double = 0;
                          strNatPis: String = '';
                          strNatCof: String = '';
                          fltDeDVCf: Double = 0;
                          strRICMPR: String = 'N';
                          fltComLiq: Double = 0;
                          strNcmTin: String = '';
                          strNumLot: String = '';
                          fltValIva: Double = 0;
                          strCliBus: string = 'N';
                          strTurEnt: String = '';
                          fltPeBaST: Double = 0;
                          fltVal_RT: Double = 0;
                          fltImpPag: Double = 0;
                          fltTaxJur: Double = 0;
                          strNumCmp: String = '';
                          intNItCmp: Integer = 0;
                          strProBri: String = '';
                          fltPonBri: Double = 0;
                          fltOutVal: Double = 0;
                          fltIcmSai: Double = 0;
                          fltImpFed: Double = 0;
                          fltDesOpe: Double = 0;
                          fltValDif: Double = 0;
                          fltFedImp: Double = 0;
                          fltEstImp: Double = 0;
                          fltMunImp: Double = 0;
                          fltIcmOrg: Double = 0;
                          fltVrdIcm: Double = 0;
                          fltBasVrd: Double = 0;
                          strMtdIcm: String = '';
                          strAtivac: String = 'N';
                          intSeqCom: Integer = 0;
                          strSeqDet: String = '';
                          strDesNes: String = '';
                          strNotUlt: String = '';
                          fltPICMEF: Double = 0;
                          fltBICMEF: Double = 0;
                          fltAICMEF: Double = 0;
                          fltVICMEF: Double = 0;
                          fltBSTANT: Double = 0;
                          fltVSTANT: Double = 0;
                          strNotC17: String = '';
                          fltSICMEF: Double = 0;
                          fltBFCPST: Double = 0;
                          fltPFCPST: Double = 0;
                          fltVFCPST: Double = 0;
                          strChaveAcesso: String = '';
                          fltQtdCom: Double = 0;
                          strEmpCar: String = '';
                          fltValIpiEntFut: Double = 0;
                          fltValRetEntFut: Double = 0;
                          fltValFcpSTEntFut: Double = 0;
                          blnAtoDeclaratorioDF: Boolean = False;
                          fltVDesST: Double = 0;
                          strMDesST: String = '';
                          strCForDi: String = '';
                          strNumDrw: String = '';
                          strNumPla: String = '';
                          strParNum: String = '';
                          strReqCom: String = '';
                          fltFreCot: Double = 0;
                          intDetItem: Integer = 0;
                          fltVFCPOP: Double = 0;
                          fltVFCPDF: Double = 0;
                          fltCfbIpi: Double = 0;
                          fltCfaIpi: Double = 0;
                          fltCfvIpi: Double = 0;
                          strCipiOK: String = 'N';
                          strDocIpi: String = '';
                          strEspIpi: String = '';
                          strEmpIpi: String = '';
                          strNcmIte: String = '';
                          strComple: String = '';
                          dtaDtaCmp: TDateTime = 0;
                          fltOutValPD: Double = 0;
                          strCbenef: string = '';
                          strCodPre: string = '';
                          fltBasPre: Double = 0;
                          fltPerPre: Double = 0;
                          fltValPre: Double = 0;
                          strCodCmg: String = '';
                          fltVimRet: Double = 0;
                          fltValSeg: Double = 0;
                          fltPerDif: Double = 0;
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
                          fltBimRet: Double = 0;
                          fltAimRet: Double = 0;
                          blnRefEspelhaDocumento: Boolean = False): Boolean;

    function fGravaNotDetSimplificada(
                          Var strAutInc: String;
                          strSeqGer: String;
                          strCodEmp,
                          strCodCli,
                          strNumDoc,
                          strEspDoc,
                          strSerie,
                          strCodIte,
                          strCodDiv,
                          strCodMar,
                          strCodVen: String;
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
                          strNotEsp,
                          strCodDig,
                          strCodCnd,
                          strCodFpg,
                          strProEmb,
                          strIteEmb,
                          strGruEmb: String;
                          intLazQua: Integer;
                          strPromoc,
                          strSeqTin: String;
                          fltQtdPul: Double;
                          strOriDoc,
                          strTip_Fc,
                          strCodFor: String;
                          fltQtdEmb,
                          fltPreEmb: Double;
                          strCliFat: String;
                          fltBcaMin,
                          fltBcaCom,
                          fltVolPro: Double;
                          strTabPre: String;
                          fltUniDig,
                          fltQtdPon: Double;
                          strEntFut,
                          strMotFut: String;
                          dtaDtaFut: TDateTime;
                          fltTotCu2: Double;
                          fltComRep,
                          fltPerRep: Double;
                          strCodAca,
                          strEmpAca: String;
                          blnProAca: Boolean;
                          fltTotUlt,
                          fltImpUlt,
                          fltBaRtSp,
                          fltVaRtSp,
                          fltIcOpPr: Double;
                          intSeqCcr: Integer;
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
                          fltPesLiq: Double;
                          const objParams: TNotDetParams): Boolean;

    procedure fGravaNOTCND(strAutInc: String; arrDuplic: TarrDuplicata );

    function fGravaIncEfd(strSeqGer: String;
                          strRefNfe: String;
                          strInfAdc: String;
                          strIdenti: String;
                          strPeriod: String): Boolean;

    function fJaExisteConfirmacaoParaMeiaNota(ANumeroDocumento,
                                              AEspecieDocumento,
                                              AEmpresaDocumento : String) : Boolean;

    function fGravarConfirmacaoMeiaNota(AstrIdMeiaNota,
                                        AstrNumeroDocumento,
                                        AstrEspecieDocumento,
                                        AstrEmpresaDocumento : String) : Boolean;

    function fExcluirVinculoMeiaNota(AstrNumeroDocumento,
                                     AstrEspecieDocumento,
                                     AstrEmpresaDocumento : String) : Boolean;

  procedure pGravarVinculacaoDocumentoComodatoCilindroVasilhameNotGer(
    const strAutInc: String; const strEspDoc: String);

  function fGravaNdtCha(strAutInc: String;
                        fltQtdCha: Double;
                        fltMedB_L: Double;
                        fltMedB_A: Double;
                        fltMedL_L: Double;
                        fltMedL_A: Double;
                        fltEspess: Double): Boolean;

implementation

uses untFuncoes, untFuncFatTypes;

Procedure pIncluiAuxNot(strAutInc,
                        strAutEnt: String;
                        fltValCre: Double;
                        dtaNasCon: TDate;
                        strCodObr,
                        strCodART,
                        strRetIss,
                        strOpcDoc: String;
                        fltBasAnt: Double;   //BASE DE ICMS ANTECIPADO
                        fltValAnt: Double;  //VALOR DE ICMS ANTECIPADO
                        strEntUrg: String;
                        fltDeDVCf: Double;
                        fltImpPag: Double;
                        strChvNfeDev: String;
                        strNumCOODev: String;
                        strNumSerDev: String;
                        strNumUSUDev: String;
                        strTipDocDev: String;
                        fltTotDif: Double;
                        fltValAdt: Double;
                        recServicos: TDadosServicos;
                        objFazenda: Pointer;
                        fltFedImp: Double;
                        fltEstImp: Double;
                        fltMunImp: Double;
                        strComVal: String;
                        strEdiPes: String;
                        fltTroco_: Double = 0;
                        strPlaVei: String = '';
                        strKm_Vei: String = '';
                        strVenPre: String = 'N';
                        strNumera: String = '';
                        fltVrdIcm: Double = 0;
                        fltBasVrd: Double = 0;
                        strCodEmbarcacao: String = '';
                        strNotPau: String = 'S';
                        fltTotBri: Double = 0;
                        strCliCtt: String = '';
                        strNatCfo: String = '';
                        strPlaFat: String = '';
                        strEntFutOpc: String = '';
                        fltTotIpiEntFut: Double = 0;
                        fltTotRetEntFut: Double = 0;
                        fltTotFcpSTEntFut: Double = 0;
                        strNumeroRandomico : String = '';
                        strNumeroDrawback : String = '';
                        fltFreCot: Double = 0;
                        blnRegEs2: Boolean = False;
                        strAutIcv: String = '';
                        strEspDoc: String = '';
                        strDocAba: String = '';
                        strEspAba: String = '';
                        strEmpAba: String = '';
                        strCliCEO: String = '';
                        fltVolSepExc: Double = 0;
                        fltVolSepNExc: Double = 0;
                        strCodPrj: String = '';
                        strAbf_Uf: String = '';
                        strCelCon: String = '';
                        strTem_ST: String = 'N';
                        strTipAbf: string = '';
                        strVchCdp: String = '';
                        strCodCno: String = '';
                        fltTotIbs:   Double = 0;
                        fltTotCbs:   Double = 0;
                        fltTotIs:    Double = 0;
                        fltTotProIs: Double = 0;
                        fltTotNf:    Double = 0;
                        strInsImo : String = '';
                        strCodCib : String = ''
                        );
  Var
    qryAuxGer: TUniQuery;
Begin
  qryAuxGer := fCriaQuery(Nil);

  With qryAuxGer, SQL Do
  Begin
    Add('SELECT * FROM AUXNOT WHERE FALSE ');
    Open;
    qryAuxGer.Insert;

    FieldByName('AUX_SEQGER').AsString := strAutInc;

    If Not fEmptyStr(strAutEnt) Then
      FieldByName('AUX_ENTGER').AsString := strAutEnt;

    If dtaNasCon > 0 Then
      FieldByName('AUX_NASCON').AsDateTime := dtaNasCon;

    FieldByName('AUX_VALCRE').AsFloat  := fltValCre;
    FieldByName('AUX_CODOBR').AsString := strCodObr;
    FieldByName('AUX_CODART').AsString := strCodART;
    FieldByName('AUX_CODCNO').AsString := strCodCno;
    FieldByName('AUX_INSIMO').AsString := strInsImo;
    FieldByName('AUX_CODCIB').AsString := strCodCib;

    If Not fEmptyStr(strRetIss) Then
      FieldByName('AUX_RETISS').AsString  := strRetIss;

    FieldByName('AUX_OPCDOC').AsString  := strOpcDoc;

    FieldByName('AUX_BASANT').AsFloat  := fltBasAnt;
    FieldByName('AUX_TOTANT').AsFloat  := fltValAnt;

    FieldByName('AUX_ENTURG').AsString  := strEntUrg;

    If Not fUsaImpostoFonteIBPT Then
      FieldByName('AUX_IMPPAG').AsFloat  := fltImpPag
    Else
    Begin
      FieldByName('AUX_IMPPAG').AsFloat  := fltFedImp + fltEstImp + fltMunImp;
      FieldByName('AUX_FEDIMP').AsFloat  := fltFedImp;
      FieldByName('AUX_ESTIMP').AsFloat  := fltEstImp;
      FieldByName('AUX_MUNIMP').AsFloat  := fltMunImp;
    End;

    FieldByName('AUX_DEDVCF').AsFloat  := fltDeDVCf;
    FieldByName('AUX_CHVNFE').AsString := strChvNfeDev;
    FieldByName('AUX_NUMCOO').AsString := strNumCOODev;
    FieldByName('AUX_NUMSER').AsString := strNumSerDev;
    FieldByName('AUX_NUMUSU').AsString := strNumUSUDev;
    FieldByName('AUX_TIPDOC').AsString := strTipDocDev;
    FieldByName('AUX_TOTDIF').AsFloat  := fltTotDif;
    FieldByName('AUX_BASISS').AsFloat  := recServicos.fltBasIss;
    FieldByName('AUX_REDISS').AsFloat  := recServicos.fltRedIss;
    FieldByName('AUX_DEDISS').AsFloat  := recServicos.fltDedIss;

    If (Assigned(objFazenda) And Not fEmptyStr(TDadosFazendaBase(objFazenda).strCodFaz)) Then
      FieldByName('AUX_CODFAZ').AsString := TDadosFazendaBase(objFazenda).strCodFaz
    Else
      FieldByName('AUX_CODFAZ').Value := Null;

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

    FieldByName('AUX_VALADT').AsFloat  := fltValAdt;

    FieldByName('AUX_TROCO_').AsFloat := fltTroco_;

    FieldByName('AUX_COMVAL').AsString := 'N';

    If (Not fEmptyStr(strComVal)) Then
      FieldByName('AUX_COMVAL').AsString := strComVal;

    FieldByName('AUX_VENPRE').AsString := strVenPre;
    FieldByName('AUX_NUMERA').AsString := strNumera;
    FieldByName('AUX_EDIPES').AsString := strEdiPes;

    FieldByName('AUX_VRDICM').AsFloat  := fltVrdIcm;
    FieldByName('AUX_BASVRD').AsFloat  := fltBasVrd;

    If fEmptyStr(strCodEmbarcacao) Then
      FieldByName('AUX_CODEMB').Value := Null
    Else
      FieldByName('AUX_CODEMB').AsString := strCodEmbarcacao;

    FieldByName('AUX_NOTPAU').AsString := strNotPau;

    FieldByName('AUX_TOTBRI').AsFloat := fltTotBri;

    If fEmptyStr(strCliCtt) Then
      FieldByName('AUX_CLICTT').Value := Null
    Else
      FieldByName('AUX_CLICTT').AsString := strCliCtt;

    If fEmptyStr(strNatCfo) Then
      FieldByName('AUX_NATCFO').Value := Null
    Else
      FieldByName('AUX_NATCFO').AsString := strNatCfo;

    FieldByName('AUX_PLAFAT').AsString := AnsiReplaceStr(strPlaFat, '-', '');

    If fEmptyStr(strEntFutOpc) Then
      FieldByName('AUX_ENFUOP').Value := Null
    Else
      FieldByName('AUX_ENFUOP').AsString := strEntFutOpc;

    If fEmptyStr(strDocAba) Then
      FieldByName('AUX_DOCABA').Value := Null
    Else
      FieldByName('AUX_DOCABA').AsString := strDocAba;

    If fEmptyStr(strEspAba) Then
      FieldByName('AUX_ESPABA').Value := Null
    Else
      FieldByName('AUX_ESPABA').AsString := strEspAba;

    If fEmptyStr(strEmpAba) Then
      FieldByName('AUX_EMPABA').Value := Null
    Else
      FieldByName('AUX_EMPABA').AsString := strEmpAba;

    FieldByName('AUX_TIPIBF').AsFloat := fltTotIpiEntFut;
    FieldByName('AUX_TRETBF').AsFloat := fltTotRetEntFut;
    FieldByName('AUX_TFSTBF').AsFloat := fltTotFcpSTEntFut;

    FieldByName('AUX_NUMRAN').AsString := strNumeroRandomico;

    If (Not fEmptyStr(strNumeroDrawback)) Then
      FieldByName('AUX_NUMDRW').AsString := strNumeroDrawback;

    FieldByName('AUX_FRECOT').AsFloat := fltFreCot;
    FieldByName('AUX_REGES2').AsString := IIF(blnRegEs2, 'S', 'N');

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

    If (fEmptyStr(strCliCEO)) Then
      FieldByName('AUX_CLICEO').Value := Null
    Else
      FieldByName('AUX_CLICEO').AsString := strCliCEO;

    FieldByName('AUX_VOLEXS').AsFloat := fltVolSepExc;
    FieldByName('AUX_VOLEXN').AsFloat := fltVolSepNExc;

    FieldByName('AUX_ABF_UF').AsString := strAbf_Uf;

    If fEmptyStr(strCodPrj) Then
      FieldByName('AUX_CODPRJ').Value := Null
    else
      FieldByName('AUX_CODPRJ').AsString := strCodPrj;

    FieldByName('AUX_CELCON').AsString := strCelCon;

    FieldByName('AUX_TEM_ST').AsString := strTem_ST;

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

    If FindField('AUX_TOTIBS') <> Nil Then
      FieldByName('AUX_TOTIBS').AsFloat := fltTotIbs;
    If FindField('AUX_TOTCBS') <> Nil Then
      FieldByName('AUX_TOTCBS').AsFloat := fltTotCbs;
    If FindField('AUX_TOT_IS') <> Nil Then
      FieldByName('AUX_TOT_IS').AsFloat := fltTotIs;
    If FindField('AUX_TPROIS') <> Nil Then
      FieldByName('AUX_TPROIS').AsFloat := fltTotProIs;
    If FindField('AUX_TOT_NF') <> Nil Then
      FieldByName('AUX_TOT_NF').AsFloat := fltTotNf;

    Post;

  End;

  FreeAndNil(qryAuxGer);
End;

Procedure pIncluiSerNot(strAutInc: String;
                        recServicos: TDadosServicos);
  Var
    qrySerNot: TUniQuery;
Begin
  qrySerNot := fCriaQuery(Nil);

  With qrySerNot, SQL Do
  Begin
    Add('SELECT * FROM SERNOT WHERE FALSE ');
    Open;
    qrySerNot.Insert;

    FieldByName('GER_SEQGER').AsString := strAutInc;

    FieldByName('GER_CODS07').AsString := recServicos.strCodS07;
    FieldByName('GER_CODS08').AsString := recServicos.strCodS08;
    FieldByName('GER_CODS09').AsString := recServicos.strCodS09;
    FieldByName('GER_CODS10').AsString := recServicos.strCodS10;

    FieldByName('GER_CODS11').AsString := recServicos.strCodS11;
    FieldByName('GER_CODS12').AsString := recServicos.strCodS12;
    FieldByName('GER_CODS13').AsString := recServicos.strCodS13;
    FieldByName('GER_CODS14').AsString := recServicos.strCodS14;
    FieldByName('GER_CODS15').AsString := recServicos.strCodS15;
    FieldByName('GER_CODS16').AsString := recServicos.strCodS16;
    FieldByName('GER_CODS17').AsString := recServicos.strCodS17;
    FieldByName('GER_CODS18').AsString := recServicos.strCodS18;
    FieldByName('GER_CODS19').AsString := recServicos.strCodS19;
    FieldByName('GER_CODS20').AsString := recServicos.strCodS20;
    FieldByName('GER_CODS21').AsString := recServicos.strCodS21;
    FieldByName('GER_CODS22').AsString := recServicos.strCodS22;
    FieldByName('GER_CODS23').AsString := recServicos.strCodS23;
    FieldByName('GER_CODS24').AsString := recServicos.strCodS24;
    FieldByName('GER_CODS25').AsString := recServicos.strCodS25;
    FieldByName('GER_CODS26').AsString := recServicos.strCodS26;
    FieldByName('GER_CODS27').AsString := recServicos.strCodS27;
    FieldByName('GER_CODS28').AsString := recServicos.strCodS28;
    FieldByName('GER_CODS29').AsString := recServicos.strCodS29;
    FieldByName('GER_CODS30').AsString := recServicos.strCodS30;

    FieldByName('GER_DESS07').AsString := recServicos.strDesS07;
    FieldByName('GER_DESS08').AsString := recServicos.strDesS08;
    FieldByName('GER_DESS09').AsString := recServicos.strDesS09;
    FieldByName('GER_DESS10').AsString := recServicos.strDesS10;

    FieldByName('GER_DESS11').AsString := recServicos.strDesS11;
    FieldByName('GER_DESS12').AsString := recServicos.strDesS12;
    FieldByName('GER_DESS13').AsString := recServicos.strDesS13;
    FieldByName('GER_DESS14').AsString := recServicos.strDesS14;
    FieldByName('GER_DESS15').AsString := recServicos.strDesS15;
    FieldByName('GER_DESS16').AsString := recServicos.strDesS16;
    FieldByName('GER_DESS17').AsString := recServicos.strDesS17;
    FieldByName('GER_DESS18').AsString := recServicos.strDesS18;
    FieldByName('GER_DESS19').AsString := recServicos.strDesS19;
    FieldByName('GER_DESS20').AsString := recServicos.strDesS20;
    FieldByName('GER_DESS21').AsString := recServicos.strDesS21;
    FieldByName('GER_DESS22').AsString := recServicos.strDesS22;
    FieldByName('GER_DESS23').AsString := recServicos.strDesS23;
    FieldByName('GER_DESS24').AsString := recServicos.strDesS24;
    FieldByName('GER_DESS25').AsString := recServicos.strDesS25;
    FieldByName('GER_DESS26').AsString := recServicos.strDesS26;
    FieldByName('GER_DESS27').AsString := recServicos.strDesS27;
    FieldByName('GER_DESS28').AsString := recServicos.strDesS28;
    FieldByName('GER_DESS29').AsString := recServicos.strDesS29;
    FieldByName('GER_DESS30').AsString := recServicos.strDesS30;

    FieldByName('GER_VALS07').AsFloat := recServicos.fltValS07;
    FieldByName('GER_VALS08').AsFloat := recServicos.fltValS08;
    FieldByName('GER_VALS09').AsFloat := recServicos.fltValS09;
    FieldByName('GER_VALS10').AsFloat := recServicos.fltValS10;

    FieldByName('GER_VALS11').AsFloat := recServicos.fltValS11;
    FieldByName('GER_VALS12').AsFloat := recServicos.fltValS12;
    FieldByName('GER_VALS13').AsFloat := recServicos.fltValS13;
    FieldByName('GER_VALS14').AsFloat := recServicos.fltValS14;
    FieldByName('GER_VALS15').AsFloat := recServicos.fltValS15;
    FieldByName('GER_VALS16').AsFloat := recServicos.fltValS16;
    FieldByName('GER_VALS17').AsFloat := recServicos.fltValS17;
    FieldByName('GER_VALS18').AsFloat := recServicos.fltValS18;
    FieldByName('GER_VALS19').AsFloat := recServicos.fltValS19;
    FieldByName('GER_VALS20').AsFloat := recServicos.fltValS20;
    FieldByName('GER_VALS21').AsFloat := recServicos.fltValS21;
    FieldByName('GER_VALS22').AsFloat := recServicos.fltValS22;
    FieldByName('GER_VALS23').AsFloat := recServicos.fltValS23;
    FieldByName('GER_VALS24').AsFloat := recServicos.fltValS24;
    FieldByName('GER_VALS25').AsFloat := recServicos.fltValS25;
    FieldByName('GER_VALS26').AsFloat := recServicos.fltValS26;
    FieldByName('GER_VALS27').AsFloat := recServicos.fltValS27;
    FieldByName('GER_VALS28').AsFloat := recServicos.fltValS28;
    FieldByName('GER_VALS29').AsFloat := recServicos.fltValS29;
    FieldByName('GER_VALS30').AsFloat := recServicos.fltValS30;

    FieldByName('GER_QTDS01').AsFloat  := recServicos.fltQtdS01;
    FieldByName('GER_QTDS02').AsFloat  := recServicos.fltQtdS02;
    FieldByName('GER_QTDS03').AsFloat  := recServicos.fltQtdS03;
    FieldByName('GER_QTDS04').AsFloat  := recServicos.fltQtdS04;
    FieldByName('GER_QTDS05').AsFloat  := recServicos.fltQtdS05;
    FieldByName('GER_QTDS06').AsFloat  := recServicos.fltQtdS06;
    FieldByName('GER_QTDS07').AsFloat  := recServicos.fltQtdS07;
    FieldByName('GER_QTDS08').AsFloat  := recServicos.fltQtdS08;
    FieldByName('GER_QTDS09').AsFloat  := recServicos.fltQtdS09;
    FieldByName('GER_QTDS10').AsFloat  := recServicos.fltQtdS10;

    FieldByName('GER_QTDS11').AsFloat  := recServicos.fltQtdS11;
    FieldByName('GER_QTDS12').AsFloat  := recServicos.fltQtdS12;
    FieldByName('GER_QTDS13').AsFloat  := recServicos.fltQtdS13;
    FieldByName('GER_QTDS14').AsFloat  := recServicos.fltQtdS14;
    FieldByName('GER_QTDS15').AsFloat  := recServicos.fltQtdS15;
    FieldByName('GER_QTDS16').AsFloat  := recServicos.fltQtdS16;
    FieldByName('GER_QTDS17').AsFloat  := recServicos.fltQtdS17;
    FieldByName('GER_QTDS18').AsFloat  := recServicos.fltQtdS18;
    FieldByName('GER_QTDS19').AsFloat  := recServicos.fltQtdS19;
    FieldByName('GER_QTDS20').AsFloat  := recServicos.fltQtdS20;
    FieldByName('GER_QTDS21').AsFloat  := recServicos.fltQtdS21;
    FieldByName('GER_QTDS22').AsFloat  := recServicos.fltQtdS22;
    FieldByName('GER_QTDS23').AsFloat  := recServicos.fltQtdS23;
    FieldByName('GER_QTDS24').AsFloat  := recServicos.fltQtdS24;
    FieldByName('GER_QTDS25').AsFloat  := recServicos.fltQtdS25;
    FieldByName('GER_QTDS26').AsFloat  := recServicos.fltQtdS26;
    FieldByName('GER_QTDS27').AsFloat  := recServicos.fltQtdS27;
    FieldByName('GER_QTDS28').AsFloat  := recServicos.fltQtdS28;
    FieldByName('GER_QTDS29').AsFloat  := recServicos.fltQtdS29;
    FieldByName('GER_QTDS30').AsFloat  := recServicos.fltQtdS30;

    FieldByName('GER_UNIS01').AsFloat  := recServicos.fltUniS01;
    FieldByName('GER_UNIS02').AsFloat  := recServicos.fltUniS02;
    FieldByName('GER_UNIS03').AsFloat  := recServicos.fltUniS03;
    FieldByName('GER_UNIS04').AsFloat  := recServicos.fltUniS04;
    FieldByName('GER_UNIS05').AsFloat  := recServicos.fltUniS05;
    FieldByName('GER_UNIS06').AsFloat  := recServicos.fltUniS06;
    FieldByName('GER_UNIS07').AsFloat  := recServicos.fltUniS07;
    FieldByName('GER_UNIS08').AsFloat  := recServicos.fltUniS08;
    FieldByName('GER_UNIS09').AsFloat  := recServicos.fltUniS09;
    FieldByName('GER_UNIS10').AsFloat  := recServicos.fltUniS10;

    FieldByName('GER_UNIS11').AsFloat  := recServicos.fltUniS11;
    FieldByName('GER_UNIS12').AsFloat  := recServicos.fltUniS12;
    FieldByName('GER_UNIS13').AsFloat  := recServicos.fltUniS13;
    FieldByName('GER_UNIS14').AsFloat  := recServicos.fltUniS14;
    FieldByName('GER_UNIS15').AsFloat  := recServicos.fltUniS15;
    FieldByName('GER_UNIS16').AsFloat  := recServicos.fltUniS16;
    FieldByName('GER_UNIS17').AsFloat  := recServicos.fltUniS17;
    FieldByName('GER_UNIS18').AsFloat  := recServicos.fltUniS18;
    FieldByName('GER_UNIS19').AsFloat  := recServicos.fltUniS19;
    FieldByName('GER_UNIS20').AsFloat  := recServicos.fltUniS20;
    FieldByName('GER_UNIS21').AsFloat  := recServicos.fltUniS21;
    FieldByName('GER_UNIS22').AsFloat  := recServicos.fltUniS22;
    FieldByName('GER_UNIS23').AsFloat  := recServicos.fltUniS23;
    FieldByName('GER_UNIS24').AsFloat  := recServicos.fltUniS24;
    FieldByName('GER_UNIS25').AsFloat  := recServicos.fltUniS25;
    FieldByName('GER_UNIS26').AsFloat  := recServicos.fltUniS26;
    FieldByName('GER_UNIS27').AsFloat  := recServicos.fltUniS27;
    FieldByName('GER_UNIS28').AsFloat  := recServicos.fltUniS28;
    FieldByName('GER_UNIS29').AsFloat  := recServicos.fltUniS29;
    FieldByName('GER_UNIS30').AsFloat  := recServicos.fltUniS30;

    FieldByName('GER_DECS01').AsFloat  := recServicos.fltDecS01;
    FieldByName('GER_DECS02').AsFloat  := recServicos.fltDecS02;
    FieldByName('GER_DECS03').AsFloat  := recServicos.fltDecS03;
    FieldByName('GER_DECS04').AsFloat  := recServicos.fltDecS04;
    FieldByName('GER_DECS05').AsFloat  := recServicos.fltDecS05;
    FieldByName('GER_DECS06').AsFloat  := recServicos.fltDecS06;
    FieldByName('GER_DECS07').AsFloat  := recServicos.fltDecS07;
    FieldByName('GER_DECS08').AsFloat  := recServicos.fltDecS08;
    FieldByName('GER_DECS09').AsFloat  := recServicos.fltDecS09;
    FieldByName('GER_DECS10').AsFloat  := recServicos.fltDecS10;

    FieldByName('GER_DECS11').AsFloat  := recServicos.fltDecS11;
    FieldByName('GER_DECS12').AsFloat  := recServicos.fltDecS12;
    FieldByName('GER_DECS13').AsFloat  := recServicos.fltDecS13;
    FieldByName('GER_DECS14').AsFloat  := recServicos.fltDecS14;
    FieldByName('GER_DECS15').AsFloat  := recServicos.fltDecS15;
    FieldByName('GER_DECS16').AsFloat  := recServicos.fltDecS16;
    FieldByName('GER_DECS17').AsFloat  := recServicos.fltDecS17;
    FieldByName('GER_DECS18').AsFloat  := recServicos.fltDecS18;
    FieldByName('GER_DECS19').AsFloat  := recServicos.fltDecS19;
    FieldByName('GER_DECS20').AsFloat  := recServicos.fltDecS20;
    FieldByName('GER_DECS21').AsFloat  := recServicos.fltDecS21;
    FieldByName('GER_DECS22').AsFloat  := recServicos.fltDecS22;
    FieldByName('GER_DECS23').AsFloat  := recServicos.fltDecS23;
    FieldByName('GER_DECS24').AsFloat  := recServicos.fltDecS24;
    FieldByName('GER_DECS25').AsFloat  := recServicos.fltDecS25;
    FieldByName('GER_DECS26').AsFloat  := recServicos.fltDecS26;
    FieldByName('GER_DECS27').AsFloat  := recServicos.fltDecS27;
    FieldByName('GER_DECS28').AsFloat  := recServicos.fltDecS28;
    FieldByName('GER_DECS29').AsFloat  := recServicos.fltDecS29;
    FieldByName('GER_DECS30').AsFloat  := recServicos.fltDecS30;

    FieldByName('GER_NROPRO').AsInteger := recServicos.intNroPro;

    If recServicos.dtaSerIni > 0 Then
      FieldByName('GER_SERINI').AsDateTime := recServicos.dtaSerIni;

    If recServicos.dtaSerFin > 0 Then
      FieldByName('GER_SERFIN').AsDateTime := recServicos.dtaSerFin;

    If Not fEmptyStr(recServicos.strSerObs) Then
      FieldByName('GER_SEROBS').AsString := recServicos.strSerObs;

    FieldByName('GER_MUNPRE').AsString := recServicos.strMunPre;
    FieldByName('GER_NATSER').AsString := recServicos.strNatSer;

    Post;

  End;

  FreeAndNil(qrySerNot);
End;

function fGravaNotGer(Var strAutInc: String;
                      strCodEmp,
                      strNumDoc,
                      strEspDoc,
                      strCodCli,
                      strCodTra,
                      strCodVen,
                      strSerie: String;
                      dtaDtaEnt,
                      dtaHorEnt: TDateTime;
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
                      blnJaFatu: Boolean;
                      strTipFat,
                      strNumFat,
                      strEmpFat: String;
                      dtaDtaFat: TDateTime;
                      strVenFat,
                      strCndFat: String;
                      fltValFat: Double;
                      strNotEsp: String;
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
                      strTip_Fc,
                      strCodFor: String;
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
                      fltCsSeDv,
                      fltDupRec,
                      fltValAdt,
                      fltBasOrg,
                      fltIcmOrg: Double;
                      intNConhe: Integer;
                      strEntFat,
                      strCliFat,
                      strOpeExp: String; // Operador da Expedição
                      fltBaRtSp,
                      fltVlRtSp: Double;
                      strNumReg: String;
                      intGrpNot: Integer;
                      strClaFi4,
                      strCodEve: String;
                      strAutEnt,
                      strObsNfe,
                      strConsum: String;
                      dtaDtEntr: TDateTime;
                      fltValCre: Double = 0;
                      dtaDtEsNf: TDateTime = 0;
                      tmrHrEsNf: TDateTime = 0;
                      objFinanc: TFinanceira = Nil;
                      intIpDpCi: Integer = 0;
                      strCodObr: String = '';
                      strCodArt: String = '';
                      strRetIss: String = '';
                      strOpcDoc: String = '';
                      fltBasAnt: Double = 0;  //BASE DE ICMS ANTECIPADO
                      fltValAnt: Double = 0;  //VALOR DE ICMS ANTECIPADO
                      strEntUrg: String = '';
                      fltDeDVCf: Double = 0;
                      fltImpPag: Double = 0;
                      strChvNfeDev: String = '';
                      strNumCOODev: String = '';
                      strNumSerDev: String = '';
                      strNumUSUDev: String = '';
                      strTipDocDev: String = '';
                      fltTotDif: Double = 0;
                      objFazenda: Pointer = nil;
                      fltFedImp: Double = 0;
                      fltEstImp: Double = 0;
                      fltMunImp: Double = 0;
                      fltTroco_: Double = 0;
                      strObsNfeFis: String = '';
                      strEmlCon: String = '';
                      strComVal: String = '';
                      strPlaVei: String = '';
                      strKm_Vei: String = '';
                      strVenPre: String = 'N';
                      strNumera: String = '';
                      strEdiPes: String = 'N';
                      fltVrdIcm: Double = 0;
                      fltBasVrd: Double = 0;
                      blnImpPdv: Boolean = False;
                      strCodEmbarcacao: String = '';
                      strNotPau: String = 'S';
                      fltTotBri: Double = 0;
                      strCliCtt: String = '';
                      strNatCfo: String = '';
                      strPlaFat: String = '';
                      strEntFutOpc: String = '';
                      fltTotIpiEntFut: Double = 0;
                      fltTotRetEntFut: Double = 0;
                      fltTotFcpSTEntFut: Double = 0;
                      strNumeroRandomico : String = '';
                      strNumeroDrawback : String = '';
                      fltFreCot: Double = 0;
                      blnRegEs2: Boolean = False;
                      strAutIcv: String = '';
                      strDocAba: String = '';
                      strEspAba: String = '';
                      strEmpAba: String = '';
                      strCliCEO: String = '';
                      fltVolSepExc: Double = 0;
                      fltVolSepNExc: Double = 0;
                      strCodPrj: String = '';
                      strAbf_Uf: String = '';
                      strCelCon: String = '';
                      strVchCdp: String = '';
                      strCodCno: String = '';
                      fltTotIbs:   Double = 0;
                      fltTotCbs:   Double = 0;
                      fltTotIs:    Double = 0;
                      fltTotProIs: Double = 0;
                      fltTotNf:    Double = 0;
                      strInsImo : String = '';
                      strCodCib : String = ''
                      ): Boolean;
  Var
    qryTblNotGer: TUniQuery;
    qryTblNotObs: TUniQuery;
    blnSolDtaEntSaiNfe: Boolean;
    RegistroContabilidade: TrecRegistroContabilidade;
    strTem_ST: String;
    strTipAbf: String;
Begin
  Result := True;

  blnSolDtaEntSaiNfe := fCfgSis('SOLDSE', varBoolean);

  If (strEspDoc = 'IF') And
     (fltTotFre = 0) And
     (strTipFre <> '9') And
     ( (fCfgSis('USNFCE', varBoolean)) Or fUsaSat ) Then
    strTipFre:='9';

  qryTblNotGer := fCriaQuery();
  qryTblNotGer.SQL.Add('INSERT INTO NOTGER ( ');

  qryTblNotGer.SQL.Add('AUTOINCREM,');
  qryTblNotGer.SQL.Add('GER_CODEMP,');
  qryTblNotGer.SQL.Add('GER_NUMDOC,');
  qryTblNotGer.SQL.Add('GER_ESPDOC,');
  qryTblNotGer.SQL.Add('GER_CODCLI,');
  qryTblNotGer.SQL.Add('GER_CODTRA,');
  qryTblNotGer.SQL.Add('GER_CODVEN,');
  qryTblNotGer.SQL.Add('GER_SERIE_,');
  qryTblNotGer.SQL.Add('GER_DTAENT,');
  qryTblNotGer.SQL.Add('GER_HORENT,');
  qryTblNotGer.SQL.Add('GER_CONPAG,');
  qryTblNotGer.SQL.Add('GER_ESTADO,');
  qryTblNotGer.SQL.Add('GER_NOMCON,');
  qryTblNotGer.SQL.Add('GER_ENDCON,');
  qryTblNotGer.SQL.Add('GER_BAICON,');
  qryTblNotGer.SQL.Add('GER_CEPCON,');
  qryTblNotGer.SQL.Add('GER_CIDCON,');
  qryTblNotGer.SQL.Add('GER_ESTCON,');
  qryTblNotGer.SQL.Add('GER_TELCON,');
  qryTblNotGer.SQL.Add('GER_CGCCPF,');
  qryTblNotGer.SQL.Add('GER_CGCCON,');
  qryTblNotGer.SQL.Add('GER_IESCON,');
  qryTblNotGer.SQL.Add('GER_R_GCON,');
  qryTblNotGer.SQL.Add('GER_BASSIM,');
  qryTblNotGer.SQL.Add('GER_BASIPI,');
  qryTblNotGer.SQL.Add('GER_ALQIPI,');
  qryTblNotGer.SQL.Add('GER_TOTIPI,');
  qryTblNotGer.SQL.Add('GER_BASICM,');
  qryTblNotGer.SQL.Add('GER_ALQICM,');
  qryTblNotGer.SQL.Add('GER_TOTICM,');
  qryTblNotGer.SQL.Add('GER_TOTRET,');
  qryTblNotGer.SQL.Add('GER_RET_SP,');
  qryTblNotGer.SQL.Add('GER_ALQRET,');
  qryTblNotGer.SQL.Add('GER_BASRET,');
  qryTblNotGer.SQL.Add('GER_DESESP,');
  qryTblNotGer.SQL.Add('GER_VLRCON,');
  qryTblNotGer.SQL.Add('GER_TOTPRO,');
  qryTblNotGer.SQL.Add('GER_TOTCUS,');
  qryTblNotGer.SQL.Add('GER_TOTMED,');
  qryTblNotGer.SQL.Add('GER_TIPFRE,');
  qryTblNotGer.SQL.Add('GER_TOTFRE,');
  qryTblNotGer.SQL.Add('GER_PESBRU,');
  qryTblNotGer.SQL.Add('GER_PESLIQ,');
  qryTblNotGer.SQL.Add('GER_VOLUME,');
  qryTblNotGer.SQL.Add('GER_ESPECI,');
  qryTblNotGer.SQL.Add('GER_MARCA_,');
  qryTblNotGer.SQL.Add('GER_MEN001,');
  qryTblNotGer.SQL.Add('GER_MEN002,');
  qryTblNotGer.SQL.Add('GER_MEN003,');
  qryTblNotGer.SQL.Add('GER_MEN004,');
  qryTblNotGer.SQL.Add('GER_MEN005,');
  qryTblNotGer.SQL.Add('GER_JAFATU,');
  qryTblNotGer.SQL.Add('GER_TIPFAT,');
  qryTblNotGer.SQL.Add('GER_NUMFAT,');
  qryTblNotGer.SQL.Add('GER_EMPFAT,');
  qryTblNotGer.SQL.Add('GER_DTAFAT,');
  qryTblNotGer.SQL.Add('GER_VENFAT,');
  qryTblNotGer.SQL.Add('GER_CNDFAT,');
  qryTblNotGer.SQL.Add('GER_VALFAT,');
  qryTblNotGer.SQL.Add('GER_NOTESP,');
  qryTblNotGer.SQL.Add('GER_VPAR01,');
  qryTblNotGer.SQL.Add('GER_VPAR02,');
  qryTblNotGer.SQL.Add('GER_VPAR03,');
  qryTblNotGer.SQL.Add('GER_VPAR04,');
  qryTblNotGer.SQL.Add('GER_VPAR05,');
  qryTblNotGer.SQL.Add('GER_VPAR06,');
  qryTblNotGer.SQL.Add('GER_VPAR07,');
  qryTblNotGer.SQL.Add('GER_VPAR08,');
  qryTblNotGer.SQL.Add('GER_VPAR09,');
  qryTblNotGer.SQL.Add('GER_VPAR10,');
  qryTblNotGer.SQL.Add('GER_VPAR11,');
  qryTblNotGer.SQL.Add('GER_VPAR12,');
  qryTblNotGer.SQL.Add('GER_CLAFIS,');
  qryTblNotGer.SQL.Add('GER_CLAFI2,');
  qryTblNotGer.SQL.Add('GER_CLAFI3,');
  qryTblNotGer.SQL.Add('GER_NATOPE,');
  qryTblNotGer.SQL.Add('GER_PORDES,');
  qryTblNotGer.SQL.Add('GER_CODDIG,');
  qryTblNotGer.SQL.Add('GER_CODCND,');
  qryTblNotGer.SQL.Add('GER_CODFPG,');
  qryTblNotGer.SQL.Add('GER_FATNOT,');
  qryTblNotGer.SQL.Add('GER_CODS01,');
  qryTblNotGer.SQL.Add('GER_CODS02,');
  qryTblNotGer.SQL.Add('GER_CODS03,');
  qryTblNotGer.SQL.Add('GER_CODS04,');
  qryTblNotGer.SQL.Add('GER_CODS05,');
  qryTblNotGer.SQL.Add('GER_CODS06,');
  qryTblNotGer.SQL.Add('GER_DESS01,');
  qryTblNotGer.SQL.Add('GER_DESS02,');
  qryTblNotGer.SQL.Add('GER_DESS03,');
  qryTblNotGer.SQL.Add('GER_DESS04,');
  qryTblNotGer.SQL.Add('GER_DESS05,');
  qryTblNotGer.SQL.Add('GER_DESS06,');
  qryTblNotGer.SQL.Add('GER_VALS01,');
  qryTblNotGer.SQL.Add('GER_VALS02,');
  qryTblNotGer.SQL.Add('GER_VALS03,');
  qryTblNotGer.SQL.Add('GER_VALS04,');
  qryTblNotGer.SQL.Add('GER_VALS05,');
  qryTblNotGer.SQL.Add('GER_VALS06,');
  qryTblNotGer.SQL.Add('GER_PRAENT,');
  qryTblNotGer.SQL.Add('GER_TOTSER,');
  qryTblNotGer.SQL.Add('GER_PERISS,');
  qryTblNotGer.SQL.Add('GER_VALISS,');
  qryTblNotGer.SQL.Add('GER_DESACE,');
  qryTblNotGer.SQL.Add('GER_ORIDOC,');
  qryTblNotGer.SQL.Add('GER_TIP_FC,');
  qryTblNotGer.SQL.Add('GER_CODFOR,');
  qryTblNotGer.SQL.Add('GER_IMPRES,');
  qryTblNotGer.SQL.Add('GER_ALQIRF,');
  qryTblNotGer.SQL.Add('GER_VALIRF,');
  qryTblNotGer.SQL.Add('GER_ALQPIS,');
  qryTblNotGer.SQL.Add('GER_VALPIS,');
  qryTblNotGer.SQL.Add('GER_ALQCOF,');
  qryTblNotGer.SQL.Add('GER_VALCOF,');
  qryTblNotGer.SQL.Add('GER_ALQCSL,');
  qryTblNotGer.SQL.Add('GER_VALCSL,');
  qryTblNotGer.SQL.Add('GER_IRFRET,');
  qryTblNotGer.SQL.Add('GER_PISRET,');
  qryTblNotGer.SQL.Add('GER_COFRET,');
  qryTblNotGer.SQL.Add('GER_CSLRET,');
  qryTblNotGer.SQL.Add('GER_NOTRET,');
  qryTblNotGer.SQL.Add('GER_ALIRFP,');
  qryTblNotGer.SQL.Add('GER_ALPISP,');
  qryTblNotGer.SQL.Add('GER_ALCOFP,');
  qryTblNotGer.SQL.Add('GER_ALCSLP,');
  qryTblNotGer.SQL.Add('GER_SERRET,');
  qryTblNotGer.SQL.Add('GER_NORESE,');
  qryTblNotGer.SQL.Add('GER_PESGSO,');
  qryTblNotGer.SQL.Add('GER_VLSGSO,');
  qryTblNotGer.SQL.Add('GER_IRPRRT,');
  qryTblNotGer.SQL.Add('GER_IRPRDV,');
  qryTblNotGer.SQL.Add('GER_IRSERT,');
  qryTblNotGer.SQL.Add('GER_IRSEDV,');
  qryTblNotGer.SQL.Add('GER_PIPRRT,');
  qryTblNotGer.SQL.Add('GER_PIPRDV,');
  qryTblNotGer.SQL.Add('GER_PISERT,');
  qryTblNotGer.SQL.Add('GER_PISEDV,');
  qryTblNotGer.SQL.Add('GER_COPRRT,');
  qryTblNotGer.SQL.Add('GER_COPRDV,');
  qryTblNotGer.SQL.Add('GER_COSERT,');
  qryTblNotGer.SQL.Add('GER_COSEDV,');
  qryTblNotGer.SQL.Add('GER_CSPRRT,');
  qryTblNotGer.SQL.Add('GER_CSPRDV,');
  qryTblNotGer.SQL.Add('GER_CSSERT,');
  qryTblNotGer.SQL.Add('GER_CSSEDV,');
  qryTblNotGer.SQL.Add('GER_DUPREC,');
  qryTblNotGer.SQL.Add('GER_BASORG,');
  qryTblNotGer.SQL.Add('GER_ICMORG,');
  qryTblNotGer.SQL.Add('GER_NCONHE,');
  qryTblNotGer.SQL.Add('GER_ENTFAT,');
  qryTblNotGer.SQL.Add('GER_CLIFAT,');
  qryTblNotGer.SQL.Add('GER_OPEEXP,');
  qryTblNotGer.SQL.Add('GER_BARTSP,');
  qryTblNotGer.SQL.Add('GER_VLRTSP,');
  qryTblNotGer.SQL.Add('GER_DTALAN,');
  qryTblNotGer.SQL.Add('GER_NUMREG,');
  qryTblNotGer.SQL.Add('GER_GRPNOT,');
  qryTblNotGer.SQL.Add('GER_CLAFI4,');
  qryTblNotGer.SQL.Add('GER_CODEVE,');
  qryTblNotGer.SQL.Add('GER_DTENTR,');
  qryTblNotGer.SQL.Add('GER_CONSUM,');
  qryTblNotGer.SQL.Add('GER_EMLCON)');

  qryTblNotGer.SQL.Add('VALUES ( ');

  qryTblNotGer.SQL.Add(':AUTOINCREM,' +
                       ':GER_CODEMP,' +
                       ':GER_NUMDOC,' +
                       ':GER_ESPDOC,' +
                       ':GER_CODCLI,' +
                       ':GER_CODTRA,' +
                       ':GER_CODVEN,' +
                       ':GER_SERIE_,' +
                       ':GER_DTAENT,' +
                       ':GER_HORENT,' +
                       ':GER_CONPAG,' +
                       ':GER_ESTADO,' +
                       ':GER_NOMCON,' +
                       ':GER_ENDCON,' +
                       ':GER_BAICON,' +
                       ':GER_CEPCON,' +
                       ':GER_CIDCON,' +
                       ':GER_ESTCON,' +
                       ':GER_TELCON,' +
                       ':GER_CGCCPF,' +
                       ':GER_CGCCON,' +
                       ':GER_IESCON,' +
                       ':GER_R_GCON,' +
                       ':GER_BASSIM,' +
                       ':GER_BASIPI,' +
                       ':GER_ALQIPI,' +
                       ':GER_TOTIPI,' +
                       ':GER_BASICM,' +
                       ':GER_ALQICM,' +
                       ':GER_TOTICM,' +
                       ':GER_TOTRET,' +
                       ':GER_RET_SP,' +
                       ':GER_ALQRET,' +
                       ':GER_BASRET,' +
                       ':GER_DESESP,' +
                       ':GER_VLRCON,' +
                       ':GER_TOTPRO,' +
                       ':GER_TOTCUS,' +
                       ':GER_TOTMED,' +
                       ':GER_TIPFRE,' +
                       ':GER_TOTFRE,' +
                       ':GER_PESBRU,' +
                       ':GER_PESLIQ,' +
                       ':GER_VOLUME,' +
                       ':GER_ESPECI,' +
                       ':GER_MARCA_,' +
                       ':GER_MEN001,' +
                       ':GER_MEN002,' +
                       ':GER_MEN003,' +
                       ':GER_MEN004,' +
                       ':GER_MEN005,' +
                       ':GER_JAFATU,' +
                       ':GER_TIPFAT,' +
                       ':GER_NUMFAT,' +
                       ':GER_EMPFAT,' +
                       ':GER_DTAFAT,' +
                       ':GER_VENFAT,' +
                       ':GER_CNDFAT,' +
                       ':GER_VALFAT,' +
                       ':GER_NOTESP,' +
                       ':GER_VPAR01,' +
                       ':GER_VPAR02,' +
                       ':GER_VPAR03,' +
                       ':GER_VPAR04,' +
                       ':GER_VPAR05,' +
                       ':GER_VPAR06,' +
                       ':GER_VPAR07,' +
                       ':GER_VPAR08,' +
                       ':GER_VPAR09,' +
                       ':GER_VPAR10,' +
                       ':GER_VPAR11,' +
                       ':GER_VPAR12,' +
                       ':GER_CLAFIS,' +
                       ':GER_CLAFI2,' +
                       ':GER_CLAFI3,' +
                       ':GER_NATOPE,' +
                       ':GER_PORDES,' +
                       ':GER_CODDIG,' +
                       ':GER_CODCND,' +
                       ':GER_CODFPG,' +
                       ':GER_FATNOT,' +
                       ':GER_CODS01,' +
                       ':GER_CODS02,' +
                       ':GER_CODS03,' +
                       ':GER_CODS04,' +
                       ':GER_CODS05,' +
                       ':GER_CODS06,' +
                       ':GER_DESS01,' +
                       ':GER_DESS02,' +
                       ':GER_DESS03,' +
                       ':GER_DESS04,' +
                       ':GER_DESS05,' +
                       ':GER_DESS06,' +
                       ':GER_VALS01,' +
                       ':GER_VALS02,' +
                       ':GER_VALS03,' +
                       ':GER_VALS04,' +
                       ':GER_VALS05,' +
                       ':GER_VALS06,' +
                       ':GER_PRAENT,' +
                       ':GER_TOTSER,' +
                       ':GER_PERISS,' +
                       ':GER_VALISS,' +
                       ':GER_DESACE,' +
                       ':GER_ORIDOC,' +
                       ':GER_TIP_FC,' +
                       ':GER_CODFOR,' +
                       ':GER_IMPRES,' +
                       ':GER_ALQIRF,' +
                       ':GER_VALIRF,' +
                       ':GER_ALQPIS,' +
                       ':GER_VALPIS,' +
                       ':GER_ALQCOF,' +
                       ':GER_VALCOF,' +
                       ':GER_ALQCSL,' +
                       ':GER_VALCSL,' +
                       ':GER_IRFRET,' +
                       ':GER_PISRET,' +
                       ':GER_COFRET,' +
                       ':GER_CSLRET,' +
                       ':GER_NOTRET,' +
                       ':GER_ALIRFP,' +
                       ':GER_ALPISP,' +
                       ':GER_ALCOFP,' +
                       ':GER_ALCSLP,' +
                       ':GER_SERRET,' +
                       ':GER_NORESE,' +
                       ':GER_PESGSO,' +
                       ':GER_VLSGSO,' +
                       ':GER_IRPRRT,' +
                       ':GER_IRPRDV,' +
                       ':GER_IRSERT,' +
                       ':GER_IRSEDV,' +
                       ':GER_PIPRRT,' +
                       ':GER_PIPRDV,' +
                       ':GER_PISERT,' +
                       ':GER_PISEDV,' +
                       ':GER_COPRRT,' +
                       ':GER_COPRDV,' +
                       ':GER_COSERT,' +
                       ':GER_COSEDV,' +
                       ':GER_CSPRRT,' +
                       ':GER_CSPRDV,' +
                       ':GER_CSSERT,' +
                       ':GER_CSSEDV,' +
                       ':GER_DUPREC,' +
                       ':GER_BASORG,' +
                       ':GER_ICMORG,' +
                       ':GER_NCONHE,' +
                       ':GER_ENTFAT,' +
                       ':GER_CLIFAT,' +
                       ':GER_OPEEXP,' +
                       ':GER_BARTSP,' +
                       ':GER_VLRTSP,' +
                       ':GER_DTALAN,' +
                       ':GER_NUMREG,' +
                       ':GER_GRPNOT,' +
                       ':GER_CLAFI4,' +
                       ':GER_CODEVE,' +
                       ':GER_DTENTR,' +
                       ':GER_CONSUM,' +
                       ':GER_EMLCON) ');

  Try

    strAutInc := fRetAutoIncrem('NOTGER', strCodEmp);

    With qryTblNotGer Do
    Begin
      ParamByName('AUTOINCREM').AsString   := strAutInc;
      ParamByName('GER_CODEMP').AsString   := strCodEmp;
      ParamByName('GER_NUMDOC').AsString   := strNumDoc;
      ParamByName('GER_ESPDOC').AsString   := strEspDoc;

      If (fEmptyStr(strCodCli)) Then
        ParamByName('GER_CODCLI').Value    := Null
      Else
        ParamByName('GER_CODCLI').AsString := strCodCli;

      If fEmptyStr(strCodTra) Then
        ParamByName('GER_CODTRA').Value := Null
      Else
        ParamByName('GER_CODTRA').AsString := strCodTra;

      ParamByName('GER_CODVEN').AsString   := strCodVen;
      ParamByName('GER_SERIE_').AsString   := strSerie;

      If dtaDtaEnt = 0 Then
        ParamByName('GER_DTAENT').Value := Null
      Else
        ParamByName('GER_DTAENT').AsDateTime := dtaDtaEnt;

      If dtaHorEnt = 0 Then
        ParamByName('GER_HORENT').Value := Null
      Else
        ParamByName('GER_HORENT').AsDateTime := dtaHorEnt;

      ParamByName('GER_CONPAG').AsString   := strConPag;
      ParamByName('GER_ESTADO').AsString   := strEstado;

      If (fEmptyStr(strNomCon)) And (Not fClienteConsumidor(fRetNomCliente(strCodCli), True, True)) Then
      Begin
        ParamByName('GER_NOMCON').Value := Null;
        ParamByName('GER_ENDCON').Value := Null;
        ParamByName('GER_BAICON').Value := Null;
        ParamByName('GER_CEPCON').Value := Null;
        ParamByName('GER_CIDCON').Value := Null;
        ParamByName('GER_ESTCON').Value := Null;
        ParamByName('GER_TELCON').Value := Null;
        ParamByName('GER_CGCCPF').Value := Null;
        ParamByName('GER_CGCCON').Value := Null;
        ParamByName('GER_IESCON').Value := Null;
        ParamByName('GER_R_GCON').Value := Null;
        ParamByName('GER_EMLCON').Value := Null;
        dtaNasCon := 0;
      End
      Else
      Begin
        ParamByName('GER_NOMCON').AsString := strNomCon;
        ParamByName('GER_ENDCON').AsString := strEndCon;
        ParamByName('GER_BAICON').AsString := strBaiCon;
        ParamByName('GER_CEPCON').AsString := strCepCon;
        ParamByName('GER_CIDCON').AsString := strCidCon;
        ParamByName('GER_ESTCON').AsString := strEstCon;
        ParamByName('GER_TELCON').AsString := strTelCon;
        ParamByName('GER_CGCCPF').AsString := strCgcCpf;
        ParamByName('GER_CGCCON').AsString := strCgcCon;

        If (strCgcCpf = '2') Then
        Begin
          ParamByName('GER_IESCON').AsString := '';
          ParamByName('GER_R_GCON').AsString := strCli_Rg;
        End
        Else
        Begin
          ParamByName('GER_IESCON').AsString := strIesCon;
          ParamByName('GER_R_GCON').AsString := '';
        End;

        ParamByName('GER_EMLCON').AsString := strEmlCon;
      End;

      If Assigned(objFazenda) And Not fEmptyStr(TDadosFazendaBase(objFazenda).strCodFaz) Then
      Begin
        ParamByName('GER_NOMCON').AsString := strNomCon;
        ParamByName('GER_ENDCON').AsString := TDadosFazendaBase(objFazenda).strNomFaz;
        ParamByName('GER_BAICON').AsString := TDadosFazendaBase(objFazenda).strBairro;
        ParamByName('GER_CEPCON').AsString := TDadosFazendaBase(objFazenda).strEndCep;
        ParamByName('GER_CIDCON').AsString := TDadosFazendaBase(objFazenda).strCodCid;
        ParamByName('GER_ESTCON').AsString := TDadosFazendaBase(objFazenda).strEstado;

        ParamByName('GER_CGCCPF').AsString := TDadosFazendaBase(objFazenda).intCgcCpf.ToString;
        ParamByName('GER_CGCCON').AsString := TDadosFazendaBase(objFazenda).strNuCnpj;
        ParamByName('GER_IESCON').AsString := TDadosFazendaBase(objFazenda).strNumIes;

        ParamByName('GER_EMLCON').AsString := strEmlCon;
        ParamByName('GER_R_GCON').AsString := '';
        ParamByName('GER_TELCON').AsString := strTelCon;//Dados do cliente
      End;

      ParamByName('GER_BASSIM').AsFloat    := fltBasSim;
      ParamByName('GER_BASIPI').AsFloat    := fltBasIpi;
      ParamByName('GER_ALQIPI').AsFloat    := fltAlqIpi;
      ParamByName('GER_TOTIPI').AsFloat    := fltTotIpi;
      ParamByName('GER_BASICM').AsFloat    := fltBasIcm;
      ParamByName('GER_ALQICM').AsFloat    := fltAlqIcm;
      ParamByName('GER_TOTICM').AsFloat    := fltTotIcm;
      ParamByName('GER_TOTRET').AsFloat    := fltTotRet;
      ParamByName('GER_RET_SP').AsFloat    := fltRet_SP;
      ParamByName('GER_ALQRET').AsFloat    := fltAlqRet;
      ParamByName('GER_BASRET').AsFloat    := fltBasRet;
      ParamByName('GER_DESESP').AsFloat    := fltDesEsp;
      ParamByName('GER_VLRCON').AsFloat    := fltVlrCon;
      ParamByName('GER_TOTPRO').AsFloat    := fltTotPro;
      ParamByName('GER_TOTCUS').AsFloat    := fltTotCus;
      ParamByName('GER_TOTMED').AsFloat    := fltTotMed;
      ParamByName('GER_TIPFRE').AsString   := strTipFre;
      ParamByName('GER_TOTFRE').AsFloat    := fltTotFre;
      ParamByName('GER_PESBRU').AsFloat    := fltPesBru;
      ParamByName('GER_PESLIQ').AsFloat    := fltPesLiq;
      ParamByName('GER_VOLUME').AsFloat    := fltVolume;
      ParamByName('GER_ESPECI').AsString   := strEspeci;
      ParamByName('GER_MARCA_').AsString   := strMarca;
      ParamByName('GER_MEN001').AsString   := strMen001;
      ParamByName('GER_MEN002').AsString   := strMen002;
      ParamByName('GER_MEN003').AsString   := strMen003;
      ParamByName('GER_MEN004').AsString   := strMen004;
      ParamByName('GER_MEN005').AsString   := strMen005;

      if ParamByName('GER_JAFATU').DataType = ftInteger then
        ParamByName('GER_JAFATU').AsInteger := IIF(blnJaFatu,1,0)
      Else
        ParamByName('GER_JAFATU').AsBoolean := blnJaFatu;

      ParamByName('GER_TIPFAT').AsString   := strTipFat;
      ParamByName('GER_NUMFAT').AsString   := strNumFat;
      if fEmptyStr(strNumFat) Then
        strEmpFat := '';

      If fEmptyStr(strEmpFat) Then
        ParamByName('GER_EMPFAT').Value    := Null
      Else
        ParamByName('GER_EMPFAT').AsString := strEmpFat;

      If dtaDtaFat = 0 Then
        ParamByName('GER_DTAFAT').Value := Null
      Else
        ParamByName('GER_DTAFAT').AsDateTime := dtaDtaFat;

      If Not fEmptyStr(strVenFat) Then
        ParamByName('GER_VENFAT').AsString := strVenFat
      Else
        ParamByName('GER_VENFAT').Value := Null;

      ParamByName('GER_CNDFAT').AsString   := strCndFat;
      ParamByName('GER_VALFAT').AsFloat    := fltValFat;
      ParamByName('GER_NOTESP').AsString   := strNotEsp;
      ParamByName('GER_VPAR01').AsFloat    := fltVPar01;
      ParamByName('GER_VPAR02').AsFloat    := fltVPar02;
      ParamByName('GER_VPAR03').AsFloat    := fltVPar03;
      ParamByName('GER_VPAR04').AsFloat    := fltVPar04;
      ParamByName('GER_VPAR05').AsFloat    := fltVPar05;
      ParamByName('GER_VPAR06').AsFloat    := fltVPar06;
      ParamByName('GER_VPAR07').AsFloat    := fltVPar07;
      ParamByName('GER_VPAR08').AsFloat    := fltVPar08;
      ParamByName('GER_VPAR09').AsFloat    := fltVPar09;
      ParamByName('GER_VPAR10').AsFloat    := fltVPar10;
      ParamByName('GER_VPAR11').AsFloat    := fltVPar11;
      ParamByName('GER_VPAR12').AsFloat    := fltVPar12;
      ParamByName('GER_CLAFIS').AsString   := strClaFis;
      ParamByName('GER_CLAFI2').AsString   := strClaFi2;
      ParamByName('GER_CLAFI3').AsString   := strClaFi3;
      ParamByName('GER_NATOPE').AsString   := strNatOpe;
      ParamByName('GER_PORDES').AsFloat    := fltPorDes;

      If (fEmptyStr(strCodDig)) Then
        ParamByName('GER_CODDIG').Value := Null
      Else
        ParamByName('GER_CODDIG').AsString   := strCodDig;

      If (fEmptyStr(strCodCnd)) Then
        ParamByName('GER_CODCND').Value := Null
      Else
        ParamByName('GER_CODCND').AsString   := strCodCnd;

      If (fEmptyStr(strCodFpg)) Then
        ParamByName('GER_CODFPG').Value := Null
      Else
        ParamByName('GER_CODFPG').AsString := strCodFpg;

      ParamByName('GER_FATNOT').AsFloat := fltFatNot;

      If (fEmptyStr(recServicos.strCodS01)) Then
        ParamByName('GER_CODS01').Value := Null
      Else
        ParamByName('GER_CODS01').AsString := recServicos.strCodS01;

      If (fEmptyStr(recServicos.strCodS02)) Then
        ParamByName('GER_CODS02').Value := Null
      Else
        ParamByName('GER_CODS02').AsString := recServicos.strCodS02;

      If (fEmptyStr(recServicos.strCodS03)) Then
        ParamByName('GER_CODS03').Value := Null
      Else
        ParamByName('GER_CODS03').AsString := recServicos.strCodS03;

      If (fEmptyStr(recServicos.strCodS04)) Then
        ParamByName('GER_CODS04').Value := Null
      Else
        ParamByName('GER_CODS04').AsString := recServicos.strCodS04;

      If (fEmptyStr(recServicos.strCodS05)) Then
        ParamByName('GER_CODS05').Value := Null
      Else
        ParamByName('GER_CODS05').AsString := recServicos.strCodS05;

      If (fEmptyStr(recServicos.strCodS06)) Then
        ParamByName('GER_CODS06').Value := Null
      Else
        ParamByName('GER_CODS06').AsString := recServicos.strCodS06;

      If (fEmptyStr(recServicos.strDesS01)) Then
        ParamByName('GER_DESS01').Value := Null
      Else
        ParamByName('GER_DESS01').AsString := recServicos.strDesS01;

      If (fEmptyStr(recServicos.strDesS02)) Then
        ParamByName('GER_DESS02').Value := Null
      Else
        ParamByName('GER_DESS02').AsString := recServicos.strDesS02;

      If (fEmptyStr(recServicos.strDesS03)) Then
        ParamByName('GER_DESS03').Value := Null
      Else
        ParamByName('GER_DESS03').AsString := recServicos.strDesS03;

      If (fEmptyStr(recServicos.strDesS04)) Then
        ParamByName('GER_DESS04').Value := Null
      Else
        ParamByName('GER_DESS04').AsString := recServicos.strDesS04;

      If (fEmptyStr(recServicos.strDesS05)) Then
        ParamByName('GER_DESS05').Value := Null
      Else
        ParamByName('GER_DESS05').AsString := recServicos.strDesS05;

      If (fEmptyStr(recServicos.strDesS06)) Then
        ParamByName('GER_DESS06').Value := Null
      Else
        ParamByName('GER_DESS06').AsString := recServicos.strDesS06;

      ParamByName('GER_VALS01').AsFloat   := recServicos.fltValS01;
      ParamByName('GER_VALS02').AsFloat   := recServicos.fltValS02;
      ParamByName('GER_VALS03').AsFloat   := recServicos.fltValS03;
      ParamByName('GER_VALS04').AsFloat   := recServicos.fltValS04;
      ParamByName('GER_VALS05').AsFloat   := recServicos.fltValS05;
      ParamByName('GER_VALS06').AsFloat   := recServicos.fltValS06;
      ParamByName('GER_PRAENT').AsInteger := recServicos.intPraEnt;
      ParamByName('GER_TOTSER').AsFloat   := recServicos.fltTotSer;
      ParamByName('GER_PERISS').AsFloat   := recServicos.fltPerIss;
      ParamByName('GER_VALISS').AsFloat   := recServicos.fltValIss;

      ParamByName('GER_DESACE').AsFloat   := fltDesAce;
      ParamByName('GER_ORIDOC').AsString := strOriDoc;
      ParamByName('GER_TIP_FC').AsString := strTip_Fc;

      If (Not fEmptyStr(strCodFor)) Then
        ParamByName('GER_CODFOR').AsString := strCodFor
      Else
        ParamByName('GER_CODFOR').Value := Null;

      if ParamByName('GER_IMPRES').DataType = ftInteger then
        ParamByName('GER_IMPRES').AsInteger := IIF(fCfgSis('USNFCE', varBoolean) Or fUsaSat Or blnImpPdv, 1, 0)
      Else
      Begin
        If (fCfgSis('USNFCE', varBoolean)) Or fUsaSat Or blnImpPdv Then
          ParamByName('GER_IMPRES').AsBoolean := True
        Else
          ParamByName('GER_IMPRES').AsBoolean := False;
      End;

      //************************************************//
      // ESSES CAMPOS REFERENTES A RETENÇÃO DE ALIQUOTA //
      //*********************************************MV*//
      ParamByName('GER_ALQIRF').AsFloat  := fltAlqIrf;
      ParamByName('GER_VALIRF').AsFloat  := fltValIrf;
      ParamByName('GER_ALQPIS').AsFloat  := fltAlqPis;
      ParamByName('GER_VALPIS').AsFloat  := fltValPis;
      ParamByName('GER_ALQCOF').AsFloat  := fltAlqCof;
      ParamByName('GER_VALCOF').AsFloat  := fltValCof;
      ParamByName('GER_ALQCSL').AsFloat  := fltAlqCsl;
      ParamByName('GER_VALCSL').AsFloat  := fltValCsL;

      ParamByName('GER_IRFRET').AsFloat  := fltIrfRet;
      ParamByName('GER_PISRET').AsFloat  := fltPisRet;
      ParamByName('GER_COFRET').AsFloat  := fltCofRet;
      ParamByName('GER_CSLRET').AsFloat  := fltCslRet;
      ParamByName('GER_NOTRET').AsString := strNotRet;

      ParamByName('GER_ALIRFP').AsFloat  := fltAlIrfP;
      ParamByName('GER_ALPISP').AsFloat  := fltAlPisP;
      ParamByName('GER_ALCOFP').AsFloat  := fltAlCofP;
      ParamByName('GER_ALCSLP').AsFloat  := fltAlCslP;

      ParamByName('GER_SERRET').AsFloat  := fltSerRet;
      ParamByName('GER_NORESE').AsString := strNoReSe;

      ParamByName('GER_PESGSO').AsFloat  := fltPeSgSo;
      ParamByName('GER_VLSGSO').AsFloat  := fltVlSgSo;

      ParamByName('GER_IRPRRT').AsFloat  := fltIrPrRt;
      ParamByName('GER_IRPRDV').AsFloat  := fltIrPrDv;
      ParamByName('GER_IRSERT').AsFloat  := fltIrSeRt;
      ParamByName('GER_IRSEDV').AsFloat  := fltIrSeDv;
      ParamByName('GER_PIPRRT').AsFloat  := fltPiPrRt;
      ParamByName('GER_PIPRDV').AsFloat  := fltPiPrDv;
      ParamByName('GER_PISERT').AsFloat  := fltPiSeRt;
      ParamByName('GER_PISEDV').AsFloat  := fltPiSeDv;
      ParamByName('GER_COPRRT').AsFloat  := fltCoPrRt;
      ParamByName('GER_COPRDV').AsFloat  := fltCoPrDv;
      ParamByName('GER_COSERT').AsFloat  := fltCoSeRt;
      ParamByName('GER_COSEDV').AsFloat  := fltCoSeDv;
      ParamByName('GER_CSPRRT').AsFloat  := fltCsPrRt;
      ParamByName('GER_CSPRDV').AsFloat  := fltCsPrDv;
      ParamByName('GER_CSSERT').AsFloat  := fltCsSeRt;
      ParamByName('GER_CSSEDV').AsFloat  := fltCsSeDv;

      ParamByName('GER_DUPREC').AsFloat  := fltDupRec;
      ParamByName('GER_BASORG').AsFloat  := fltBasOrg;
      ParamByName('GER_ICMORG').AsFloat  := fltIcmOrg;

      If (intNConhe = -1) Then
        ParamByName('GER_NCONHE').Value := Null
      Else
        ParamByName('GER_NCONHE').AsInteger:= intNConhe;

      ParamByName('GER_ENTFAT').AsString := strEntFat;

      If (fEmptyStr(strCliFat)) Then
        ParamByName('GER_CLIFAT').Value := Null
      Else
        ParamByName('GER_CLIFAT').AsString := strCliFat;

      ParamByName('GER_OPEEXP').AsString := strOpeExp;
      If fEmptyStr(strOpeExp) Then
        ParamByName('GER_OPEEXP').Clear;

      ParamByName('GER_BARTSP').AsFloat := fltBaRtSp;
      ParamByName('GER_VLRTSP').AsFloat := fltVlRtSp;

      ParamByName('GER_DTALAN').AsDateTime := VS_Date;

      ParamByName('GER_NUMREG').AsString := strNumReg;

      ParamByName('GER_GRPNOT').AsInteger := intGrpNot;

      ParamByName('GER_CLAFI4').AsString := strClaFi4;

      If fEmptyStr(strCodEve) Then
        ParamByName('GER_CODEVE').Value := Null
      Else
        ParamByName('GER_CODEVE').AsString := strCodEve;

      If dtaDtEntr <> 0 Then
        ParamByName('GER_DTENTR').AsDateTime := dtaDtEntr
      Else
        ParamByName('GER_DTENTR').Value := Null;

      ParamByName('GER_CONSUM').AsString := strConsum;

      ExecSQL;

      If ParamByName('GER_CONPAG').AsString = '00' Then
      Begin
        fRollBack;

        Raise Exception.Create(ParamByName('GER_NUMDOC').AsString+'-'+ParamByName('GER_ESPDOC').AsString+
                               ' com valor das parcelas inconsistentes. Se possível feche o autcom '+
                               ' e repita essa operação. Se o problema persistir entre em contato com a Citel!');
      End;

      RegistroContabilidade.ttpTabela := ttNotGer;
      RegistroContabilidade.strClafis := strClaFis;
      RegistroContabilidade.strEspDoc := strEspDoc;
      RegistroContabilidade.strSeqGer := strAutInc;
      RegistroContabilidade.mlModLan := mlInclusao;
      RegistroContabilidade.strEmpLan := strCodEmp;
      pGravaRegistroContabilidade(RegistroContabilidade);

      if fEmptyStr(strNatCfo) then
        strNatCfo := fCampoTabela('AUTOINCREM', 'NATCFO', ['NAT_CODCFO', 'NAT_DESCRI'], [strClaFis, strNatOpe]);

      strTem_ST := IIF(fltTotRet > 0, 'S', 'N');
      strTipAbf := '';
      If strTip_Fc = 'F' then
        strTipAbf := Copy(fRetDesTipoAbf('F', strCodFor), 1, 3);

      pIncluiAuxNot(strAutInc,
                    strAutEnt,
                    fltValCre,
                    dtaNasCon,
                    strCodObr,
                    strCodArt,
                    strRetIss,
                    strOpcDoc,
                    fltBasAnt,
                    fltValAnt,
                    strEntUrg,
                    fltDeDVCf,
                    fltImpPag,
                    strChvNfeDev,
                    strNumCOODev,
                    strNumSerDev,
                    strNumUSUDev,
                    strTipDocDev,
                    fltTotDif,
                    fltValAdt,
                    recServicos,
                    objFazenda,
                    fltFedImp,
                    fltEstImp,
                    fltMunImp,
                    strComVal,
                    strEdiPes,
                    fltTroco_,
                    strPlaVei,
                    strKm_Vei,
                    strVenPre,
                    strNumera,
                    fltVrdIcm,
                    fltBasVrd,
                    strCodEmbarcacao,
                    strNotPau,
                    fltTotBri,
                    strCliCtt,
                    strNatCfo,
                    strPlaFat,
                    strEntFutOpc,
                    fltTotIpiEntFut,
                    fltTotRetEntFut,
                    fltTotFcpSTEntFut,
                    strNumeroRandomico,
                    strNumeroDrawback,
                    fltFreCot,
                    blnRegEs2,
                    strAutIcv,
                    strEspDoc,
                    strDocAba,
                    strEspAba,
                    strEmpAba,
                    strCliCEO,
                    fltVolSepExc,
                    fltVolSepNExc,
                    strCodPrj,
                    strAbf_Uf,
                    strCelCon,
                    strTem_ST,
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

      If Not fEmptyStr(recServicos.strCodS01) Then
        pIncluiSerNot(strAutInc,
                      recServicos);

      If Assigned(objFinanc) Then
        objFinanc.fGravaFinanciamento('NOTGER', strAutInc);

    End;

    qryTblNotObs := fCriaQuery;

    With qryTblNotObs Do
    Begin
      qryTblNotObs.SQL.Text := 'SELECT * FROM NOTOBS WHERE FALSE';
      Open;
      Append;
      FieldByName('MOV_SEQGER').AsString := strAutInc;

      {**************************************************************************}
      {* O CAMPO "MOV_OBSERV" É ATUALIZADO NO ENVIO/RE-ENVIO DA NFE, POR ISSO   *}
      {* SE FAZ NECESSÁRIO PRESERVAR SEU VALOR EM OUTRO CAMPO, CASO A NOTA      *}
      {* FIQUE COM ERRO E SEJA REENVIADA O SEU VALOR SERÁ ATUALIZADO!           *}
      {**************************************************************************}
      {* FIZ UMA NF COM O PAINEL FECHADO, AO FINALIZAR A GRAVAÇÃO ABRI O PAINEL,*}
      {* ALTEREI O STATUS E RE-ENVIEI, O VALOR DE "MOV_OBSERV" DOBROU           *}
      {***********************************************************************RN*}
      FieldByName('MOV_OBSERV').AsString := strObsNfe;
      FieldByName('MOV_CNFNFE').AsString := strObsNfe;

      FieldByName('MOV_OBSFIS').AsString := strObsNfeFis;
      FieldByName('MOV_CNFFIS').AsString := strObsNfeFis;

      FieldByName('MOV_IPDPCI').AsInteger := intIpDpCi;

      If (dtaDtESNf > 0) And blnSolDtaEntSaiNfe Then
      Begin
        FieldByName('MOV_DTESNF').AsDateTime := dtaDtESNf;
        FieldByName('MOV_HRESNF').AsDateTime := tmrHrESNf;
      End;

      FieldByName('MOV_DISSER').AsString := recServicos.strDisSer;
      Post;
    End;

    FreeAndNil(qryTblNotObs);

    fGravaNOTCND(strAutInc, arrDuplic );
  Except
    On E: Exception Do
    Begin

      Result := False;
      qryTblNotGer.Cancel;
      pMensagensErro(E.Message, '[fGravaNotGer]');

    End;
  End;

  FreeAndNil(qryTblNotGer);

end;

function fGravaNotDet(Var strAutInc: String;
                      strSeqGer: String;
                      strCodEmp,
                      strCodCli,
                      strNumDoc,
                      strEspDoc,
                      strSerie,
                      strCodIte,
                      strCodDiv,
                      strCodMar,
                      strCodVen: String;
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
                      strNotEsp,
                      strCodDig,
                      strCodCnd,
                      strCodFpg,
                      strProEmb,
                      strIteEmb,
                      strGruEmb: String;
                      intLazQua: Integer;
                      strPromoc,
                      strSeqTin: String;
                      fltQtdPul: Double;
                      strOriDoc,
                      strTip_Fc,
                      strCodFor: String;
                      fltQtdEmb,
                      fltPreEmb: Double;
                      strCliFat: String;
                      fltBcaMin,
                      fltBcaCom,
                      fltVolPro: Double;
                      strTabPre: String;
                      fltUniDig: Double;
                      fltQtdPon: Double;
                      strEntFut,
                      strMotFut: String;
                      dtaDtaFut: TDateTime;
                      fltTotCu2: Double;
                      fltComRep,
                      fltPerRep: Double;
                      strCodAca,
                      strEmpAca: String;
                      blnProAca: Boolean;
                      fltTotUlt,
                      fltImpUlt,
                      fltBaRtSp,
                      fltVaRtSp,
                      fltIcOpPr: Double;
                      intSeqCcr: Integer;
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
                      fltPesLiq: Double;
                      fltBasAnt: Double = 0;
                      fltIcmAnt: Double = 0;
                      fltOutIcm: Double = 0;
                      fltIseIcm: Double = 0;
                      fltFreSug: Double = 0;
                      strNatPis: String = '';
                      strNatCof: String = '';
                      fltDeDVCf: Double = 0;
                      strRICMPR: String = 'N';
                      fltComLiq: Double = 0;
                      strNcmTin: String = '';
                      strNumLot: String = '';
                      fltValIva: Double = 0;
                      strCliBus: string = 'N';
                      strTurEnt: String = '';
                      fltPeBaST: Double = 0;
                      fltVal_RT: Double = 0;
                      fltImpPag: Double = 0;
                      fltTaxJur: Double = 0;
                      strNumCmp: String = '';
                      intNItCmp: Integer = 0;
                      strProBri: String = '';
                      fltPonBri: Double = 0;
                      fltOutVal: Double = 0;
                      fltIcmSai: Double = 0;
                      fltImpFed: Double = 0;
                      fltDesOpe: Double = 0;
                      fltValDif: Double = 0;
                      fltFedImp: Double = 0;
                      fltEstImp: Double = 0;
                      fltMunImp: Double = 0;
                      fltIcmOrg: Double = 0;
                      fltVrdIcm: Double = 0;
                      fltBasVrd: Double = 0;
                      strMtdIcm: String = '';
                      strAtivac: String = 'N';
                      intSeqCom: Integer = 0;
                      strSeqDet: String = '';
                      strDesNes: String = '';
                      strNotUlt: String = '';
                      fltPICMEF: Double = 0;
                      fltBICMEF: Double = 0;
                      fltAICMEF: Double = 0;
                      fltVICMEF: Double = 0;
                      fltBSTANT: Double = 0;
                      fltVSTANT: Double = 0;
                      strNotC17: String = '';
                      fltSICMEF: Double = 0;
                      fltBFCPST: Double = 0;
                      fltPFCPST: Double = 0;
                      fltVFCPST: Double = 0;
                      strChaveAcesso: String = '';
                      fltQtdCom: Double = 0;
                      strEmpCar: String = '';
                      fltValIpiEntFut: Double = 0;
                      fltValRetEntFut: Double = 0;
                      fltValFcpSTEntFut: Double = 0;
                      blnAtoDeclaratorioDF: Boolean = False;
                      fltVDesST: Double = 0;
                      strMDesST: String = '';
                      strCForDi: String = '';
                      strNumDrw: String = '';
                      strNumPla: String = '';
                      strParNum: String = '';
                      strReqCom: String = '';
                      fltFreCot: Double = 0;
                      intDetItem: Integer = 0;
                      fltVFCPOP: Double = 0;
                      fltVFCPDF: Double = 0;
                      fltCfbIpi: Double = 0;
                      fltCfaIpi: Double = 0;
                      fltCfvIpi: Double = 0;
                      strCipiOK: String = 'N';
                      strDocIpi: String = '';
                      strEspIpi: String = '';
                      strEmpIpi: String = '';
                      strNcmIte: String = '';
                      strComple: String = '';
                      dtaDtaCmp: TDateTime = 0;
                      fltOutValPD: Double = 0;
                      strCbenef: string = '';
                      strCodPre: string = '';
                      fltBasPre: Double = 0;
                      fltPerPre: Double = 0;
                      fltValPre: Double = 0;
                      strCodCmg: String = '';
                      fltVimRet: Double = 0;
                      fltValSeg: Double = 0;
                      fltPerDif: Double = 0;
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
                      fltBimRet: Double = 0;
                      fltAimRet: Double = 0;
                      blnRefEspelhaDocumento: Boolean = False): Boolean;
  Var
    qryTblNotDet: TUniQuery;
    qryTblNotTri: TUniQuery;
    qryTblNotAux: TUniQuery;
Begin

  Result := True;

  qryTblNotDet := fCriaQuery();
  qryTblNotDet.SQL.Add('INSERT INTO NOTDET (');
  qryTblNotDet.SQL.Add('DET_SEQGER, ');
  qryTblNotDet.SQL.Add('AUTOINCREM, ');
  qryTblNotDet.SQL.Add('DET_CODEMP, ');
  qryTblNotDet.SQL.Add('DET_CODCLI, ');
  qryTblNotDet.SQL.Add('DET_NUMDOC, ');
  qryTblNotDet.SQL.Add('DET_ESPDOC, ');
  qryTblNotDet.SQL.Add('DET_SERIE_, ');
  qryTblNotDet.SQL.Add('DET_CODITE, ');
  qryTblNotDet.SQL.Add('DET_CODDIV, ');
  qryTblNotDet.SQL.Add('DET_CODMAR, ');
  qryTblNotDet.SQL.Add('DET_DTAENT, ');
  qryTblNotDet.SQL.Add('DET_HORENT, ');
  qryTblNotDet.SQL.Add('DET_CONPAG, ');
  qryTblNotDet.SQL.Add('DET_ESTADO, ');
  qryTblNotDet.SQL.Add('DET_DESCRI, ');
  qryTblNotDet.SQL.Add('DET_REFERE, ');
  qryTblNotDet.SQL.Add('DET_UNIDAD, ');
  qryTblNotDet.SQL.Add('DET_FORITE, ');
  qryTblNotDet.SQL.Add('DET_QTDITE, ');
  qryTblNotDet.SQL.Add('DET_UNITAR, ');
  qryTblNotDet.SQL.Add('DET_UNIORI, ');
  qryTblNotDet.SQL.Add('DET_UNIDIG, ');
  qryTblNotDet.SQL.Add('DET_TOTITE, ');
  qryTblNotDet.SQL.Add('DET_VLRCON, ');
  qryTblNotDet.SQL.Add('DET_TOTCUS, ');
  qryTblNotDet.SQL.Add('DET_TOTMED, ');
  qryTblNotDet.SQL.Add('DET_DESCON, ');
  qryTblNotDet.SQL.Add('DET_TOTFRE, ');
  qryTblNotDet.SQL.Add('DET_DESESP, ');
  qryTblNotDet.SQL.Add('DET_DESACE, ');
  qryTblNotDet.SQL.Add('DET_CODREP, ');
  qryTblNotDet.SQL.Add('DET_CODVE2, ');
  qryTblNotDet.SQL.Add('DET_PERCOM, ');
  qryTblNotDet.SQL.Add('DET_TOTCOM, ');
  qryTblNotDet.SQL.Add('DET_TOTCO2, ');
  qryTblNotDet.SQL.Add('DET_CLAFIS, ');
  qryTblNotDet.SQL.Add('DET_CODFIS, ');
  qryTblNotDet.SQL.Add('DET_VALIPI, ');
  qryTblNotDet.SQL.Add('DET_ALQIPI, ');
  qryTblNotDet.SQL.Add('DET_BASIPI, ');
  qryTblNotDet.SQL.Add('DET_VALICM, ');
  qryTblNotDet.SQL.Add('DET_ALQICM, ');
  qryTblNotDet.SQL.Add('DET_BASICM, ');
  qryTblNotDet.SQL.Add('DET_VALRET, ');
  qryTblNotDet.SQL.Add('DET_ALQRET, ');
  qryTblNotDet.SQL.Add('DET_BASRET, ');
  qryTblNotDet.SQL.Add('DET_TOTPES, ');
  qryTblNotDet.SQL.Add('DET_PERBAS, ');
  qryTblNotDet.SQL.Add('DET_PERRED, ');
  qryTblNotDet.SQL.Add('DET_JAFATU, ');
  qryTblNotDet.SQL.Add('DET_TIPFAT, ');
  qryTblNotDet.SQL.Add('DET_NUMFAT, ');
  qryTblNotDet.SQL.Add('DET_EMPFAT, ');
  qryTblNotDet.SQL.Add('DET_DTAFAT, ');
  qryTblNotDet.SQL.Add('DET_VENFAT, ');
  qryTblNotDet.SQL.Add('DET_CNDFAT, ');
  qryTblNotDet.SQL.Add('DET_VALFAT, ');
  qryTblNotDet.SQL.Add('DET_IDEPRO, ');
  qryTblNotDet.SQL.Add('DET_INCPIS, ');
  qryTblNotDet.SQL.Add('DET_NOTESP, ');
  qryTblNotDet.SQL.Add('DET_CODDIG, ');
  qryTblNotDet.SQL.Add('DET_CODCND, ');
  qryTblNotDet.SQL.Add('DET_CODFPG, ');
  qryTblNotDet.SQL.Add('DET_PROEMB, ');
  qryTblNotDet.SQL.Add('DET_ITEEMB, ');
  qryTblNotDet.SQL.Add('DET_LAZQUA, ');
  qryTblNotDet.SQL.Add('DET_PROMOC, ');
  qryTblNotDet.SQL.Add('DET_SEQTIN, ');
  qryTblNotDet.SQL.Add('DET_QTDPUL, ');
  qryTblNotDet.SQL.Add('DET_ORIDOC, ');
  qryTblNotDet.SQL.Add('DET_TIP_FC, ');
  qryTblNotDet.SQL.Add('DET_CODFOR, ');
  qryTblNotDet.SQL.Add('DET_QTDEMB, ');
  qryTblNotDet.SQL.Add('DET_PREEMB, ');
  qryTblNotDet.SQL.Add('DET_TMPGAR, ');
  qryTblNotDet.SQL.Add('DET_CLIFAT, ');
  qryTblNotDet.SQL.Add('DET_CODVEN, ');
  qryTblNotDet.SQL.Add('DET_BCAMIN, ');
  qryTblNotDet.SQL.Add('DET_BCACOM, ');
  qryTblNotDet.SQL.Add('DET_VOLPRO, ');
  qryTblNotDet.SQL.Add('DET_TABPRE, ');
  qryTblNotDet.SQL.Add('DET_QTDPON, ');
  qryTblNotDet.SQL.Add('DET_CODACA, ');
  qryTblNotDet.SQL.Add('DET_EMPACA, ');
  qryTblNotDet.SQL.Add('DET_PROACA, ');
  qryTblNotDet.SQL.Add('DET_ENTFUT, ');
  qryTblNotDet.SQL.Add('DET_MOTFUT, ');
  qryTblNotDet.SQL.Add('DET_DTAFUT, ');
  qryTblNotDet.SQL.Add('DET_TOTCU2, ');
  qryTblNotDet.SQL.Add('DET_COMREP, ');
  qryTblNotDet.SQL.Add('DET_PERREP, ');
  qryTblNotDet.SQL.Add('DET_QTDROM, ');
  qryTblNotDet.SQL.Add('DET_NUMLOT, ');
  qryTblNotDet.SQL.Add('DET_FILKAR) ');

  qryTblNotDet.SQL.Add('VALUES ( ');

  qryTblNotDet.SQL.Add(':DET_SEQGER, ' +
                       ':AUTOINCREM, ' +
                       ':DET_CODEMP, ' +
                       ':DET_CODCLI, ' +
                       ':DET_NUMDOC, ' +
                       ':DET_ESPDOC, ' +
                       ':DET_SERIE_, ' +
                       ':DET_CODITE, ' +
                       ':DET_CODDIV, ' +
                       ':DET_CODMAR, ' +
                       ':DET_DTAENT, ' +
                       ':DET_HORENT, ' +
                       ':DET_CONPAG, ' +
                       ':DET_ESTADO, ' +
                       ':DET_DESCRI, ' +
                       ':DET_REFERE, ' +
                       ':DET_UNIDAD, ' +
                       ':DET_FORITE, ' +
                       ':DET_QTDITE, ' +
                       ':DET_UNITAR, ' +
                       ':DET_UNIORI, ' +
                       ':DET_UNIDIG, ' +
                       ':DET_TOTITE, ' +
                       ':DET_VLRCON, ' +
                       ':DET_TOTCUS, ' +
                       ':DET_TOTMED, ' +
                       ':DET_DESCON, ' +
                       ':DET_TOTFRE, ' +
                       ':DET_DESESP, ' +
                       ':DET_DESACE, ' +
                       ':DET_CODREP, ' +
                       ':DET_CODVE2, ' +
                       ':DET_PERCOM, ' +
                       ':DET_TOTCOM, ' +
                       ':DET_TOTCO2, ' +
                       ':DET_CLAFIS, ' +
                       ':DET_CODFIS, ' +
                       ':DET_VALIPI, ' +
                       ':DET_ALQIPI, ' +
                       ':DET_BASIPI, ' +
                       ':DET_VALICM, ' +
                       ':DET_ALQICM, ' +
                       ':DET_BASICM, ' +
                       ':DET_VALRET, ' +
                       ':DET_ALQRET, ' +
                       ':DET_BASRET, ' +
                       ':DET_TOTPES, ' +
                       ':DET_PERBAS, ' +
                       ':DET_PERRED, ' +
                       ':DET_JAFATU, ' +
                       ':DET_TIPFAT, ' +
                       ':DET_NUMFAT, ' +
                       ':DET_EMPFAT, ' +
                       ':DET_DTAFAT, ' +
                       ':DET_VENFAT, ' +
                       ':DET_CNDFAT, ' +
                       ':DET_VALFAT, ' +
                       ':DET_IDEPRO, ' +
                       ':DET_INCPIS, ' +
                       ':DET_NOTESP, ' +
                       ':DET_CODDIG, ' +
                       ':DET_CODCND, ' +
                       ':DET_CODFPG, ' +
                       ':DET_PROEMB, ' +
                       ':DET_ITEEMB, ' +
                       ':DET_LAZQUA, ' +
                       ':DET_PROMOC, ' +
                       ':DET_SEQTIN, ' +
                       ':DET_QTDPUL, ' +
                       ':DET_ORIDOC, ' +
                       ':DET_TIP_FC, ' +
                       ':DET_CODFOR, ' +
                       ':DET_QTDEMB, ' +
                       ':DET_PREEMB, ' +
                       ':DET_TMPGAR, ' +
                       ':DET_CLIFAT, ' +
                       ':DET_CODVEN, ' +
                       ':DET_BCAMIN, ' +
                       ':DET_BCACOM, ' +
                       ':DET_VOLPRO, ' +
                       ':DET_TABPRE, ' +
                       ':DET_QTDPON, ' +
                       ':DET_CODACA, ' +
                       ':DET_EMPACA, ' +
                       ':DET_PROACA, ' +
                       ':DET_ENTFUT, ' +
                       ':DET_MOTFUT, ' +
                       ':DET_DTAFUT, ' +
                       ':DET_TOTCU2, ' +
                       ':DET_COMREP, ' +
                       ':DET_PERREP, ' +
                       ':DET_QTDROM, ' +
                       ':DET_NUMLOT, ' +
                       ':DET_FILKAR) ');

  qryTblNotTri := fCriaQuery();
  qryTblNotTri.SQL.Text := 'SELECT * FROM NOTTRI WHERE FALSE';

  qryTblNotAux := fCriaQuery();
  qryTblNotAux.SQL.Text := 'SELECT * FROM NOTAUX WHERE FALSE';

  Try

    strAutInc := fRetAutoIncrem('NOTDET', strCodEmp);

    With qryTblNotDet Do
    Begin
      ParamByName('DET_SEQGER').AsString  := strSeqGer;
      ParamByName('AUTOINCREM').AsString   := strAutInc;
      ParamByName('DET_CODEMP').AsString   := strCodEmp;

      If (fEmptyStr(strCodCli)) Then
        ParamByName('DET_CODCLI').Value := Null
      Else
        ParamByName('DET_CODCLI').AsString   := strCodCli;

      ParamByName('DET_NUMDOC').AsString   := strNumDoc;
      ParamByName('DET_ESPDOC').AsString   := strEspDoc;
      ParamByName('DET_SERIE_').AsString   := strSerie;
      ParamByName('DET_CODITE').AsString   := strCodIte;

      If fEmptyStr(strCodDiv) Then
        ParamByName('DET_CODDIV').Value := Null
      Else
        ParamByName('DET_CODDIV').AsString   := strCodDiv;

      If fEmptyStr(strCodMar) Then
        ParamByName('DET_CODMAR').Value := Null
      Else
        ParamByName('DET_CODMAR').AsString   := strCodMar;

      If dtaDtaEnt = 0 Then
        ParamByName('DET_DTAENT').Value := Null
      Else
        ParamByName('DET_DTAENT').AsDateTime := dtaDtaEnt;

      If dtaHorEnt = 0 Then
        ParamByName('DET_HORENT').Value := Null
      Else
        ParamByName('DET_HORENT').AsDateTime := dtaHorEnt;

      ParamByName('DET_CONPAG').AsString   := strConPag;
      ParamByName('DET_ESTADO').AsString   := strEstado;
      ParamByName('DET_DESCRI').AsString   := strDescri;
      ParamByName('DET_REFERE').AsString   := strRefere;
      ParamByName('DET_UNIDAD').AsString   := strUnidad;

      If fEmptyStr(strForIte) Then
        ParamByName('DET_FORITE').Value := Null
      Else
        ParamByName('DET_FORITE').AsString := strForIte;

      ParamByName('DET_QTDITE').AsFloat    := fltQtdIte;
      ParamByName('DET_UNITAR').AsFloat    := fltUnitar;
      ParamByName('DET_UNIORI').AsFloat    := fltUniOri;
      ParamByName('DET_UNIDIG').AsFloat    := fltUniDig;
      ParamByName('DET_TOTITE').AsFloat    := fltTotIte;
      ParamByName('DET_VLRCON').AsFloat    := fltVlrCon;
      ParamByName('DET_TOTCUS').AsFloat    := fltTotCus;
      ParamByName('DET_TOTMED').AsFloat    := fltTotMed;
      ParamByName('DET_DESCON').AsFloat    := fltDesCon;
      ParamByName('DET_TOTFRE').AsFloat    := fltTotFre;
      ParamByName('DET_DESESP').AsFloat    := fltDesEsp;
      ParamByName('DET_DESACE').AsFloat    := fltDesAce;

      If (fEmptyStr(strCodRep)) Then
        ParamByName('DET_CODREP').Value := Null
      Else
        ParamByName('DET_CODREP').AsString := strCodRep;

      If fEmptyStr(strCodVe2) Then
        ParamByName('DET_CODVE2').Value := Null
      Else
        ParamByName('DET_CODVE2').AsString   := strCodVe2;

      ParamByName('DET_PERCOM').AsFloat    := fltPerCom;
      ParamByName('DET_TOTCOM').AsFloat    := fltTotCom;
      ParamByName('DET_TOTCO2').AsFloat    := fltTotCo2;
      ParamByName('DET_CLAFIS').AsString   := strClaFis;
      ParamByName('DET_CODFIS').AsString   := strCodFis;
      ParamByName('DET_VALIPI').AsFloat    := fltValIpi;
      ParamByName('DET_ALQIPI').AsFloat    := fltAlqIpi;
      ParamByName('DET_BASIPI').AsFloat    := fltBasIpi;
      ParamByName('DET_VALICM').AsFloat    := fltValIcm;
      ParamByName('DET_ALQICM').AsFloat    := fltAlqIcm;
      ParamByName('DET_BASICM').AsFloat    := fltBasIcm;
      ParamByName('DET_VALRET').AsFloat    := fltValRet;
      ParamByName('DET_ALQRET').AsFloat    := fltAlqRet;
      ParamByName('DET_BASRET').AsFloat    := fltBasRet;
      ParamByName('DET_TOTPES').AsFloat    := fltTotPes;
      ParamByName('DET_PERBAS').AsFloat    := fltPerBas;
      ParamByName('DET_PERRED').AsFloat    := fltPerRed;

      if ParamByName('DET_JAFATU').DataType = ftInteger then
        ParamByName('DET_JAFATU').AsInteger := IIF(blnJaFatu,1,0)
      Else
        ParamByName('DET_JAFATU').AsBoolean := blnJaFatu;

      ParamByName('DET_TIPFAT').AsString   := strTipFat;
      ParamByName('DET_NUMFAT').AsString   := strNumFat;
      if fEmptyStr(strNumFat) Then
        strEmpFat := '';

      If fEmptyStr(strEmpFat) Then
        ParamByName('DET_EMPFAT').Value    := Null
      Else
        ParamByName('DET_EMPFAT').AsString := strEmpFat;

      If dtaDtaFat = 0 Then
        ParamByName('DET_DTAFAT').Value := Null
      Else
        ParamByName('DET_DTAFAT').AsDateTime := dtaDtaFat;

      If Not fEmptyStr(strVenFat) Then
        ParamByName('DET_VENFAT').AsString := strVenFat
      Else
        ParamByName('DET_VENFAT').Value := Null;

      ParamByName('DET_CNDFAT').AsString   := strCndFat;
      ParamByName('DET_VALFAT').AsFloat    := fltValFat;
      ParamByName('DET_IDEPRO').AsString   := strIdePro;
      ParamByName('DET_INCPIS').AsString   := strIncPis;
      ParamByName('DET_NOTESP').AsString   := strNotEsp;

      If (fEmptyStr(strCodDig)) Then
        ParamByName('DET_CODDIG').Value := Null
      Else
        ParamByName('DET_CODDIG').AsString   := strCodDig;

      If (fEmptyStr(strCodCnd)) Then
        ParamByName('DET_CODCND').Value := Null
      Else
        ParamByName('DET_CODCND').AsString   := strCodCnd;

      If (fEmptyStr(strCodFpg)) Then
        ParamByName('DET_CODFPG').Value := Null
      Else
        ParamByName('DET_CODFPG').AsString   := strCodFpg;

      If (fEmptyStr(strProEmb)) Then
        ParamByName('DET_PROEMB').Value := 'N'
      Else
        ParamByName('DET_PROEMB').AsString   := strProEmb;

      If (fEmptyStr(strIteEmb)) Then
        ParamByName('DET_ITEEMB').Value := Null
      Else
        ParamByName('DET_ITEEMB').AsString  := strIteEmb;

      ParamByName('DET_LAZQUA').AsInteger := intLazQua;
      ParamByName('DET_PROMOC').AsString  := strPromoc;
      ParamByName('DET_SEQTIN').AsString  := strSeqTin;
      ParamByName('DET_QTDPUL').AsFloat   := fltQtdPul;
      ParamByName('DET_ORIDOC').AsString  := strOriDoc;
      ParamByName('DET_TIP_FC').AsString  := strTip_Fc;

      If (Not fEmptyStr(strCodFor)) Then
        ParamByName('DET_CODFOR').AsString := strCodFor
      Else
        ParamByName('DET_CODFOR').Value := Null;

      ParamByName('DET_QTDEMB').AsFloat := fltQtdEmb;
      ParamByName('DET_PREEMB').AsFloat := fltPreEmb;

      ParamByName('DET_TMPGAR').AsInteger := fRetTempoGarantia(strCodIte, strClaFis);

      If (fEmptyStr(strCliFat)) Then
        ParamByName('DET_CLIFAT').Value := Null
      Else
        ParamByName('DET_CLIFAT').AsString := strCliFat;

      If (fEmptyStr(strCodVen)) Then
        ParamByName('DET_CODVEN').Value := Null
      Else
        ParamByName('DET_CODVEN').AsString := strCodVen;

      ParamByName('DET_BCAMIN').AsFloat  := fltBcaMin;
      ParamByName('DET_BCACOM').AsFloat  := fltBcaCom;
      ParamByName('DET_VOLPRO').AsFloat  := fltVolPro;

      If (fEmptyStr(strTabPre)) Then
        ParamByName('DET_TABPRE').Value := Null
      Else
        ParamByName('DET_TABPRE').AsString := strTabPre;

      ParamByName('DET_QTDPON').AsFloat := fltQtdPon;

      If fEmptyStr(strCodAca) Then
        ParamByName('DET_CODACA').Value := Null
      Else
        ParamByName('DET_CODACA').AsString := strCodAca;

      If fEmptyStr(strEmpAca) Then
        ParamByName('DET_EMPACA').Value := Null
      Else
        ParamByName('DET_EMPACA').AsString := strEmpAca;

      ParamByName('DET_PROACA').AsString  := IIF(blnProAca, 'S', 'N');

      If Pos(strEntFut,'SN') <= 0 Then
        strEntFut := 'N';

      ParamByName('DET_ENTFUT').AsString  := strEntFut;
      ParamByName('DET_MOTFUT').AsString  := strMotFut;

      If dtaDtaFut = 0 Then
        ParamByName('DET_DTAFUT').Value := Null
      Else
        ParamByName('DET_DTAFUT').AsDateTime := dtaDtaFut;

      ParamByName('DET_TOTCU2').AsFloat   := fltTotCu2;

      ParamByName('DET_COMREP').AsFloat    := fltComRep;
      ParamByName('DET_PERREP').AsFloat    := fltPerRep;
      ParamByName('DET_QTDROM').AsFloat    := 0;
      ParamByName('DET_NUMLOT').AsString   := strNumLot;
      ParamByName('DET_FILKAR').AsInteger  := IIF(strNotEsp='S', 1, 0);

      ExecSQL;

      qryTblNotTri.Open;
      qryTblNotTri.Append;

      qryTblNotTri.FieldByName('DET_SEQGER').AsString := strAutInc;
      qryTblNotTri.FieldByName('DET_BARTSP').AsFloat  := fltBaRtSP;
      qryTblNotTri.FieldByName('DET_VLRTSP').AsFloat  := fltVaRtSP;
      qryTblNotTri.FieldByName('DET_ICOPPR').AsFloat  := fltIcOpPr;
      qryTblNotTri.FieldByName('DET_TOTULT').AsFloat  := fltTotUlt;
      qryTblNotTri.FieldByName('DET_IMPULT').AsFloat  := fltImpUlt;

      If fltUniVis = 0 Then
        qryTblNotTri.FieldByName('DET_UNIVIS').AsFloat := fltUniOri
      Else
        qryTblNotTri.FieldByName('DET_UNIVIS').AsFloat := fltUniVis;

      qryTblNotTri.FieldByName('DET_BASCOF').AsFloat  := fltBasCof;
      qryTblNotTri.FieldByName('DET_ALQCOF').AsFloat  := fltAlqCof;
      qryTblNotTri.FieldByName('DET_VALCOF').AsFloat  := fltValCof;
      qryTblNotTri.FieldByName('DET_CSTCOF').AsString := strCSTCof;
      qryTblNotTri.FieldByName('DET_BASPIS').AsFloat  := fltBasPis;
      qryTblNotTri.FieldByName('DET_ALQPIS').AsFloat  := fltAlqPis;
      qryTblNotTri.FieldByName('DET_VALPIS').AsFloat  := fltValPis;
      qryTblNotTri.FieldByName('DET_CSTPIS').AsString := strCSTPis;
      qryTblNotTri.FieldByName('DET_NR_PIS').AsString := strNatPis;
      qryTblNotTri.FieldByName('DET_NR_COF').AsString := strNatCof;
      qryTblNotTri.FieldByName('DET_CSTIPI').AsString := strCstIpi;
      qryTblNotTri.FieldByName('DET_ENQIPI').AsString := strEnqIpi;

      qryTblNotTri.FieldByName('DET_RICMPR').AsString := strRICMPR;

      If qryTblNotTri.FindField('TRI_NCMTIN') <> Nil Then
        qryTblNotTri.FieldByName('TRI_NCMTIN').AsString := strNcmTin;

      If qryTblNotTri.FindField('DET_COMLIQ') <> Nil Then
        qryTblNotTri.FieldByName('DET_COMLIQ').AsFloat  := fltComLiq;

      If qryTblNotTri.FindField('DET_VALIVA') <> Nil Then
        qryTblNotTri.FieldByName('DET_VALIVA').AsFloat  := fltValIva;

      If qryTblNotTri.FindField('DET_EMPORI') <> Nil Then
        qryTblNotTri.FieldByName('DET_EMPORI').AsString := strCodEmp;

      If qryTblNotTri.FindField('DET_PERDIF') <> Nil Then
        qryTblNotTri.FieldByName('DET_PERDIF').AsFloat := fltPerDif;

      If intSeqCcr > 0 Then
        qryTblNotTri.FieldByName('DET_SEQCCR').AsInteger := intSeqCcr;

      qryTblNotTri.FieldByName('DET_BASANT').AsFloat  := fltBasAnt;
      qryTblNotTri.FieldByName('DET_ICMANT').AsFloat  := fltIcmAnt;

      qryTblNotTri.FieldByName('DET_OUTICM').AsFloat := fltOutIcm;
      qryTblNotTri.FieldByName('DET_ISEICM').AsFloat := fltIseIcm;

      qryTblNotTri.FieldByName('DET_FRESUG').AsFloat := fltFreSug;

      qryTblNotTri.FieldByName('DET_DEDVCF').AsFloat := fltDeDVCf;

      qryTblNotTri.FieldByName('DET_PESLIQ').AsFloat := fltPesLiq;

      qryTblNotTri.FieldByName('DET_CLIBUS').AsString := strCliBus;
      qryTblNotTri.FieldByName('DET_TURENT').AsString := AnsiUpperCase(strTurEnt);

      qryTblNotTri.FieldByName('DET_PEBAST').AsFloat  := fltPeBaST;
      qryTblNotTri.FieldByName('DET_VAL_RT').AsFloat  := fltVal_RT;
      qryTblNotTri.FieldByName('DET_TAXJUR').AsFloat  := fltTaxJur;

      If Not fUsaImpostoFonteIBPT Then
        qryTblNotTri.FieldByName('DET_IMPPAG').AsFloat  := fltImpPag
      Else
      Begin
        qryTblNotTri.FieldByName('DET_IMPPAG').AsFloat  := fltFedImp + fltEstImp + fltMunImp;
        qryTblNotTri.FieldByName('DET_FEDIMP').AsFloat  := fltFedImp;
        qryTblNotTri.FieldByName('DET_ESTIMP').AsFloat  := fltEstImp;
        qryTblNotTri.FieldByName('DET_MUNIMP').AsFloat  := fltMunImp;
      End;

      qryTblNotTri.FieldByName('DET_ICMORG').AsFloat := fltIcmOrg;

      qryTblNotTri.FieldByName('DET_NUMCMP').AsString  := strNumCmp;
      qryTblNotTri.FieldByName('DET_NITCMP').AsInteger := intNItCmp;

      if (dtaDtaCmp = 0) then
        qryTblNotTri.FieldByName('DET_DTACMP').Value := Null
      else
        qryTblNotTri.FieldByName('DET_DTACMP').AsDateTime := dtaDtaCmp;

      If Not fEmptyStr(strProBri) Then
      Begin
        qryTblNotTri.FieldByName('DET_PROBRI').AsString := strProBri;
        qryTblNotTri.FieldByName('DET_PONBRI').AsFloat  := fltPonBri;
      End;

      qryTblNotTri.FieldByName('DET_OUTVAL').AsFloat := (fltOutVal * fltQtdIte) + fltOutValPD;
      qryTblNotTri.FieldByName('DET_IMPFED').AsFloat := (fltTotIte - fltDesEsp) * fltImpFed / 100;
      qryTblNotTri.FieldByName('DET_DESOPE').AsFloat := (fltTotIte - fltDesEsp) * fltDesOpe / 100;

      If (fCfgSis('IMPCF4') = 'S') And (Not fCfgSis('RAICF4', varBoolean)) Then
      Begin
        If (((fCfgSis('CLPVDI', varString) = 'S') And (fCfgSis('ICMSEP', varString) = 'S')) Or (fCfgSis('UASCCR', varString) = 'S')) And (fltIcmPrd > 0) Then
          qryTblNotTri.FieldByName('DET_ICMSAI').AsFloat := (fltTotIte - fltDesEsp) * fltIcmPrd / 100
        Else
          qryTblNotTri.FieldByName('DET_ICMSAI').AsFloat := (fltTotIte - fltDesEsp) * fltAlqIcm / 100;
      End
      Else
        qryTblNotTri.FieldByName('DET_ICMSAI').AsFloat := (fltTotIte - fltDesEsp) * fltIcmSai / 100;

      {***************************************************************}
      {* Caso for tinta de máquina, o icmsai já está                 *}
      {* preenchido corretamente respeitando a configuração 'IMPCF4' *}
      {************************************************************AC*}
      If (strIdePro <> 'NOR') Then
        qryTblNotTri.FieldByName('DET_ICMSAI').AsFloat := (fltTotIte - fltDesEsp) * fltIcmSai / 100;

      qryTblNotTri.FieldByName('DET_VRDICM').AsFloat  := fltVrdIcm;
      qryTblNotTri.FieldByName('DET_BASVRD').AsFloat  := fltBasVrd;
      qryTblNotTri.FieldByName('DET_MTDICM').AsString := Copy(strMtdIcm, 1, 2);
      qryTblNotTri.FieldByName('DET_VALDIF').AsFloat   := fltValDif;

      qryTblNotTri.FieldByName('DET_ATIVAC').AsString  := 'N';

      If (Not fEmptyStr(strAtivac)) Then
        qryTblNotTri.FieldByName('DET_ATIVAC').AsString  := strAtivac;

      qryTblNotTri.FieldByName('DET_SEQCOM').AsInteger := intSeqCom;

      If Not fEmptyStr(strSeqDet) Then
        qryTblNotTri.FieldByName('DET_SEQDET').AsString := strSeqDet;

      If fEmptyStr(strDesNes) Then
        qryTblNotTri.FieldByName('DET_DESNES').Value := Null
      Else
        qryTblNotTri.FieldByName('DET_DESNES').AsString := strDesNes;

      qryTblNotTri.FieldByName('DET_BFCPST').AsFloat := fltBFCPST;
      qryTblNotTri.FieldByName('DET_PFCPST').AsFloat := fltPFCPST;
      qryTblNotTri.FieldByName('DET_VFCPST').AsFloat := fltVFCPST;
      qryTblNotTri.FieldByName('DET_CHACES').AsString := strChaveAcesso;
      qryTblNotTri.FieldByName('DET_QTDCOM').AsFloat := fltQtdCom;
      qryTblNotTri.FieldByName('DET_CFORDI').AsString := strCForDi;

      if fEmptyStr(strNumDrw) then
        qryTblNotTri.FieldByName('DET_NUMDRW').Value := Null
      else
        qryTblNotTri.FieldByName('DET_NUMDRW').AsString := strNumDrw;

      qryTblNotTri.FieldByName('DET_NUMPLA').AsString  := strNumPla;
      qryTblNotTri.FieldByName('DET_PARNUM').AsString  := strParNum;
      qryTblNotTri.FieldByName('DET_REQCOM').AsString  := strReqCom;
      qryTblNotTri.FieldByName('DET_FRECOT').AsFloat   := fltFreCot;
      qryTblNotTri.FieldByName('DET_NITEM_').AsInteger := intDetItem+1;
      qryTblNotTri.FieldByName('DET_CFBIPI').AsFloat   := fltCfbIpi;
      qryTblNotTri.FieldByName('DET_CFAIPI').AsFloat   := fltCfaIpi;
      qryTblNotTri.FieldByName('DET_CFVIPI').AsFloat   := fltCfvIpi;
      qryTblNotTri.FieldByName('DET_CIPIOK').AsString  := strCipiOK;
      qryTblNotTri.FieldByName('DET_DOCIPI').AsString  := strDocIpi;
      qryTblNotTri.FieldByName('DET_ESPIPI').AsString  := strEspIpi;
      qryTblNotTri.FieldByName('DET_EMPIPI').AsString  := strEmpIpi;
      qryTblNotTri.FieldByName('DET_NCMITE').AsString  := strNcmIte;
      qryTblNotTri.FieldByName('DET_COMPLE').AsString  := strComple;
      qryTblNotTri.FieldByName('DET_CBENEF').AsString  := strCbenef;
      qryTblNotTri.FieldByName('DET_CODPRE').AsString  := strCodPre;
      qryTblNotTri.FieldByName('DET_BASPRE').AsFloat   := fltBasPre;
      qryTblNotTri.FieldByName('DET_PERPRE').AsFloat   := fltPerPre;
      qryTblNotTri.FieldByName('DET_VALPRE').AsFloat   := fltValPre;
      qryTblNotTri.FieldByName('DET_VALSEG').AsFloat   := fltValSeg;
      
      qryTblNotTri.Post;


      qryTblNotAux.Open;
      qryTblNotAux.Append;

      qryTblNotAux.FieldByName('DET_SEQGER').AsString := strAutInc;
      qryTblNotAux.FieldByName('DET_NOTULT').AsString := strNotUlt;
      qryTblNotAux.FieldByName('DET_PICMEF').AsFloat  := fltPICMEF;
      qryTblNotAux.FieldByName('DET_BICMEF').AsFloat  := fltBICMEF;
      qryTblNotAux.FieldByName('DET_AICMEF').AsFloat  := fltAICMEF;
      qryTblNotAux.FieldByName('DET_VICMEF').AsFloat  := fltVICMEF;
      qryTblNotAux.FieldByName('DET_SICMEF').AsFloat  := fltSICMEF;
      qryTblNotAux.FieldByName('DET_BSTANT').AsFloat  := fltBSTANT;
      qryTblNotAux.FieldByName('DET_VSTANT').AsFloat  := fltVSTANT;
      qryTblNotAux.FieldByName('DET_NOTC17').AsString := strNotC17;
      qryTblNotAux.FieldByName('DET_VIPIBF').AsFloat  := fltValIpiEntFut;
      qryTblNotAux.FieldByName('DET_VRETBF').AsFloat  := fltValRetEntFut;
      qryTblNotAux.FieldByName('DET_VFSTBF').AsFloat  := fltValFcpSTEntFut;
      qryTblNotAux.FieldByName('DET_ATODDF').AsString := IIF(blnAtoDeclaratorioDF, 'S', 'N');

      If fEmptyStr(strEmpCar) Then
        qryTblNotAux.FieldByName('DET_EMPCAR').Clear
      Else
        qryTblNotAux.FieldByName('DET_EMPCAR').AsString := strEmpCar;

      qryTblNotAux.FieldByName('DET_MDESST').AsString := strMDesST;
      qryTblNotAux.FieldByName('DET_VDESST').AsFloat  := fltVDesST;
      qryTblNotAux.FieldByName('DET_VFCPOP').AsFloat  := fltVFCPOP;
      qryTblNotAux.FieldByName('DET_VFCPDF').AsFloat  := fltVFCPDF;

      If (Not fEmptyStr(strCodCmg)) Then
        qryTblNotAux.FieldByName('DET_CODCMG').AsString := strCodCmg;

      qryTblNotAux.FieldByName('DET_BIMRET').AsFloat  := fltBimRet;
      qryTblNotAux.FieldByName('DET_AIMRET').AsFloat  := fltAimRet;
      qryTblNotAux.FieldByName('DET_VIMRET').AsFloat  := fltVimRet;

      qryTblNotAux.Post;

      If (Not fEmptyStr(strRefCodCst)) Or (blnRefEspelhaDocumento And (Not fEmptyStr(strRefSelCst))) Then
      Begin
        With fCriaQuery Do
        Try
          SQL.Text := 'SELECT * FROM NOTREF WHERE FALSE';
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
          Post;
        Finally
          Free;
        End;
      End;

    End;

  Except
    On E: Exception Do
    Begin

      Result := False;
      qryTblNotDet.Cancel;
      pMensagensErro(E.Message, '[fGravaNotDet]');

    End;
  End;

  FreeAndNil(qryTblNotTri);
  FreeAndNil(qryTblNotDet);
  FreeAndNil(qryTblNotAux);

end;

function fGravaNotDetSimplificada(
                          Var strAutInc: String;
                          strSeqGer: String;
                          strCodEmp,
                          strCodCli,
                          strNumDoc,
                          strEspDoc,
                          strSerie,
                          strCodIte,
                          strCodDiv,
                          strCodMar,
                          strCodVen: String;
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
                          strNotEsp,
                          strCodDig,
                          strCodCnd,
                          strCodFpg,
                          strProEmb,
                          strIteEmb,
                          strGruEmb: String;
                          intLazQua: Integer;
                          strPromoc,
                          strSeqTin: String;
                          fltQtdPul: Double;
                          strOriDoc,
                          strTip_Fc,
                          strCodFor: String;
                          fltQtdEmb,
                          fltPreEmb: Double;
                          strCliFat: String;
                          fltBcaMin,
                          fltBcaCom,
                          fltVolPro: Double;
                          strTabPre: String;
                          fltUniDig,
                          fltQtdPon: Double;
                          strEntFut,
                          strMotFut: String;
                          dtaDtaFut: TDateTime;
                          fltTotCu2: Double;
                          fltComRep,
                          fltPerRep: Double;
                          strCodAca,
                          strEmpAca: String;
                          blnProAca: Boolean;
                          fltTotUlt,
                          fltImpUlt,
                          fltBaRtSp,
                          fltVaRtSp,
                          fltIcOpPr: Double;
                          intSeqCcr: Integer;
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
                          fltPesLiq: Double;
                          const objParams: TNotDetParams): Boolean;
Begin
  Result := fGravaNotDet(
               strAutInc,
               strSeqGer,
               strCodEmp,
               strCodCli,
               strNumDoc,
               strEspDoc,
               strSerie,
               strCodIte,
               strCodDiv,
               strCodMar,
               strCodVen,
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
               strNotEsp,
               strCodDig,
               strCodCnd,
               strCodFpg,
               strProEmb,
               strIteEmb,
               strGruEmb,
               intLazQua,
               strPromoc,
               strSeqTin,
               fltQtdPul,
               strOriDoc,
               strTip_Fc,
               strCodFor,
               fltQtdEmb,
               fltPreEmb,
               strCliFat,
               fltBcaMin,
               fltBcaCom,
               fltVolPro,
               strTabPre,
               fltUniDig,
               fltQtdPon,
               strEntFut,
               strMotFut,
               dtaDtaFut,
               fltTotCu2,
               fltComRep,
               fltPerRep,
               strCodAca,
               strEmpAca,
               blnProAca,
               fltTotUlt,
               fltImpUlt,
               fltBaRtSp,
               fltVaRtSp,
               fltIcOpPr,
               intSeqCcr,
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
               fltPesLiq,
               objParams.fltBasAnt,
               objParams.fltIcmAnt,
               objParams.fltOutIcm,
               objParams.fltIseIcm,
               objParams.fltFreSug,
               objParams.strNatPis,
               objParams.strNatCof,
               objParams.fltDeDVCf,
               objParams.strRICMPR,
               objParams.fltComLiq,
               objParams.strNcmTin,
               objParams.strNumLot,
               objParams.fltValIva,
               objParams.strCliBus,
               objParams.strTurEnt,
               objParams.fltPeBaST,
               objParams.fltVal_RT,
               objParams.fltImpPag,
               objParams.fltTaxJur,
               objParams.strNumCmp,
               objParams.intNItCmp,
               objParams.strProBri,
               objParams.fltPonBri,
               objParams.fltOutVal,
               objParams.fltIcmSai,
               objParams.fltImpFed,
               objParams.fltDesOpe,
               objParams.fltValDif,
               objParams.fltFedImp,
               objParams.fltEstImp,
               objParams.fltMunImp,
               objParams.fltIcmOrg,
               objParams.fltVrdIcm,
               objParams.fltBasVrd,
               objParams.strMtdIcm,
               objParams.strAtivac,
               objParams.intSeqCom,
               objParams.strSeqDet,
               objParams.strDesNes,
               objParams.strNotUlt,
               objParams.fltPICMEF,
               objParams.fltBICMEF,
               objParams.fltAICMEF,
               objParams.fltVICMEF,
               objParams.fltBSTANT,
               objParams.fltVSTANT,
               objParams.strNotC17,
               objParams.fltSICMEF,
               objParams.fltBFCPST,
               objParams.fltPFCPST,
               objParams.fltVFCPST,
               objParams.strChaveAcesso,
               objParams.fltQtdCom,
               objParams.strEmpCar,
               objParams.fltValIpiEntFut,
               objParams.fltValRetEntFut,
               objParams.fltValFcpSTEntFut,
               objParams.blnAtoDeclaratorioDF,
               objParams.fltVDesST,
               objParams.strMDesST,
               objParams.strCForDi,
               objParams.strNumDrw,
               objParams.strNumPla,
               objParams.strParNum,
               objParams.strReqCom,
               objParams.fltFreCot,
               objParams.intDetItem,
               objParams.fltVFCPOP,
               objParams.fltVFCPDF,
               objParams.fltCfbIpi,
               objParams.fltCfaIpi,
               objParams.fltCfvIpi,
               objParams.strCipiOK,
               objParams.strDocIpi,
               objParams.strEspIpi,
               objParams.strEmpIpi,
               objParams.strNcmIte,
               objParams.strComple,
               objParams.dtaDtaCmp,
               objParams.fltOutValPD,
               objParams.strCbenef,
               objParams.strCodPre,
               objParams.fltBasPre,
               objParams.fltPerPre,
               objParams.fltValPre,
               objParams.strCodCmg,
               objParams.fltVimRet,
               objParams.fltValSeg,
               objParams.fltPerDif,
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
               objParams.fltIcmPrd
             );
End;

procedure fGravaNOTCND(strAutInc: String; arrDuplic: TarrDuplicata );
Var
  qryNotCnd: TUniQuery;
  intContador: Integer;
Begin
  Try
    qryNotCnd := fCriaQuery(Nil);

    With qryNotCnd, SQL Do
    Begin
      Add('SELECT * FROM NOTCND ');
      Add('WHERE FALSE');

      Open;

      For intContador := Low(arrDuplic) To High(arrDuplic) Do
      Begin
        If arrDuplic[intContador].curValor > 0 Then
        Begin
          qryNotCnd.Insert;
          FieldByName('GER_SEQGER').AsString := strAutInc;
          FieldByName('GER_PARCEL').AsString := arrDuplic[intContador].strSequen;
          FieldByName('GER_VALPAR').AsFloat  := arrDuplic[intContador].curValor;
          qryNotCnd.Post;
        End;
      End;

    End;

  Finally
    FreeAndNil(qryNotCnd);
  End;
End;

function fGravaIncEfd(strSeqGer: String;
                      strRefNfe: String;
                      strInfAdc: String;
                      strIdenti: String;
                      strPeriod: String): Boolean;
  Var
    qryIncEfd: TUniQuery;
begin
  Result := True;

  qryIncEfd := fCriaQuery;
  Try
    Try
      qryIncEfd.SQL.Text := 'SELECT * FROM INCEFD WHERE FALSE';
      qryIncEfd.Open;
      qryIncEfd.Append;
      qryIncEfd.FieldByName('AUTOINCREM').AsString := fRetAutoincrem('INCEFD', VS_strCodEmp);
      qryIncEfd.FieldByName('EFD_SEQGER').AsString := strSeqGer;
      qryIncEfd.FieldByName('EFD_REFNFE').AsString := strRefNfe;
      qryIncEfd.FieldByName('EFD_INFADC').AsString := strInfAdc;
      qryIncEfd.FieldByName('EFD_IDENTI').AsString := strIdenti;
      qryIncEfd.FieldByName('EFD_PERIOD').AsString := strPeriod;
      qryIncEfd.Post;
    Except
      On E: Exception Do
      Begin
        Result := False;
        qryIncEfd.Cancel;
        pMensagensErro(E.Message, '[fGravaIncEfd]');
      End;
    End;
  Finally
    FreeAndNil(qryIncEfd);
  End;
end;

function fJaExisteConfirmacaoParaMeiaNota(ANumeroDocumento,
                                          AEspecieDocumento,
                                          AEmpresaDocumento : String) : Boolean;
  Var
    LQuery : TUniQuery;
Begin
  LQuery := fCriaQuery();
  Try
    LQuery.Sql.Text := ' SELECT G.GER_NUMFAT AS NUMFAT  '+
                       '   FROM NOTGER G  '+
                       '  WHERE G.GER_NUMFAT = :NUMFAT '+
                       '    AND G.GER_TIPFAT = :TIPFAT '+
                       '    AND G.GER_EMPFAT = :EMPFAT '+
                       ' UNION '+
                       ' SELECT M.MNO_NUMFAT AS NUMFAT  '+
                       '   FROM CNFMNO M  '+
                       '  WHERE M.MNO_NUMFAT = :NUMFAT '+
                       '    AND M.MNO_ESPFAT = :TIPFAT '+
                       '    AND M.MNO_EMPFAT = :EMPFAT ';
    LQuery.ParamByName('NUMFAT').AsString := ANumeroDocumento;
    LQuery.ParamByName('TIPFAT').AsString := AEspecieDocumento;
    LQuery.ParamByName('EMPFAT').AsString := AEmpresaDocumento;
    LQuery.Open;
    Result := not LQuery.IsEmpty;
    LQuery.Close;
  Finally
    FreeAndNil(LQuery);
  End;
End;

function fGravarConfirmacaoMeiaNota(AstrIdMeiaNota,
                                    AstrNumeroDocumento,
                                    AstrEspecieDocumento,
                                    AstrEmpresaDocumento : String) : Boolean;
  Var
    LQuery : TUniQuery;
Begin
  Result := True;

  LQuery := fCriaQuery();
  Try
    Try
      LQuery.Sql.Text := ' INSERT INTO CNFMNO (MNO_SEQGER, MNO_NUMFAT, MNO_ESPFAT, MNO_EMPFAT) VALUES '+
                         ' (:SEQGER, :NUMFAT, :ESPFAT, :EMPFAT) ';
      LQuery.ParamByName('SEQGER').AsString := AstrIdMeiaNota;
      LQuery.ParamByName('NUMFAT').AsString := AstrNumeroDocumento;
      LQuery.ParamByName('ESPFAT').AsString := AstrEspecieDocumento;
      LQuery.ParamByName('EMPFAT').AsString := AstrEmpresaDocumento;
      LQuery.ExecSql;
    Finally
      FreeAndNil(LQuery);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fGravarConfirmacaoMeiaNota]');
    End;
  End;
End;

function fExcluirVinculoMeiaNota(AstrNumeroDocumento,
                                 AstrEspecieDocumento,
                                 AstrEmpresaDocumento : String) : Boolean;
  Var
    LQuery : TUniQuery;
Begin
  Result := True;

  LQuery := fCriaQuery();
  Try
    Try
      LQuery.Sql.Text := ' SELECT CNFMNO.* '+
                         '   FROM CNFMNO  '+
                         '   JOIN NOTGER ON CNFMNO.MNO_SEQGER = NOTGER.AUTOINCREM  '+
                         '  WHERE NOTGER.GER_NUMDOC = :NUMDOC '+
                         '    AND NOTGER.GER_CODEMP = :CODEMP '+
                         '    AND NOTGER.GER_ESPDOC = :ESPDOC ';
      LQuery.ParamByName('NUMDOC').AsString := AstrNumeroDocumento;
      LQuery.ParamByName('CODEMP').AsString := AstrEmpresaDocumento;
      LQuery.ParamByName('ESPDOC').AsString := AstrEspecieDocumento;
      LQuery.Open;
      fVerificaIntegridade('untCancelamentoDocumentos', 'CNFMNO', LQuery);
      LQuery.Close;

      LQuery.Sql.Clear;
      LQuery.Sql.Text := ' DELETE CNFMNO FROM CNFMNO  '+
                         '   JOIN NOTGER ON CNFMNO.MNO_SEQGER = NOTGER.AUTOINCREM  '+
                         '  WHERE NOTGER.GER_NUMDOC = :NUMDOC '+
                         '    AND NOTGER.GER_CODEMP = :CODEMP '+
                         '    AND NOTGER.GER_ESPDOC = :ESPDOC ';
      LQuery.ParamByName('NUMDOC').AsString := AstrNumeroDocumento;
      LQuery.ParamByName('CODEMP').AsString := AstrEmpresaDocumento;
      LQuery.ParamByName('ESPDOC').AsString := AstrEspecieDocumento;
      LQuery.ExecSql;

    Finally
      FreeAndNil(LQuery);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fExcluirVinculoMeiaNota]');
    End;
  End;
End;

procedure pGravarVinculacaoDocumentoComodatoCilindroVasilhameNotGer(
  const strAutInc: String; const strEspDoc: String);
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
            + '       N.AUTOINCREM AS GER_AUTINC '
            + '     , A.AUX_CILVAS AS NOT_CILVAS '
            + '     , A.AUX_AUTICV AS NOT_AUTICV '
            + '     , M.AUTOINCREM AS MOV_AUTINC '
            + '     , E.AUX_CILVAS '
            + '     , E.AUX_AUTICV '
            + '     , X.AUX_SEQGER '
            + '     , X.AUX_CILVAS AS REL_CILVAS '
            + '     , G.AUTOINCREM AS REL_AUTINC '
            + '     , M.GER_NUMDOC '
            + '  FROM MOVGER M '
            + ' INNER JOIN AUXMOV E ON E.AUX_SEQGER = M.AUTOINCREM '
            + ' INNER JOIN NOTGER N ON N.GER_NUMDOC = M.GER_NUMFAT '
            + '                    AND N.GER_ESPDOC = N.GER_TIPFAT '
            + '                    AND N.GER_CODEMP = M.GER_EMPFAT '
            + ' INNER JOIN AUXNOT A ON A.AUX_SEQGER = N.AUTOINCREM '
            + '  LEFT JOIN AUXMOV X ON X.AUX_AUTICV = M.AUTOINCREM '
            + '  LEFT JOIN MOVGER T ON T.AUTOINCREM = X.AUX_SEQGER '
            + '  LEFT JOIN NOTGER G ON G.GER_NUMDOC = T.GER_NUMFAT '
            + '                    AND G.GER_ESPDOC = T.GER_TIPFAT '
            + '                    AND G.GER_CODEMP = T.GER_EMPFAT ';

    qryConsulta.Close;
    qryConsulta.SQL.Text := strSql
                          + ' WHERE N.AUTOINCREM = :AUTINC ';
    qryConsulta.ParamByName('AUTINC').AsString := strAutInc;
    qryConsulta.Open;

    If Not ((qryConsulta.FieldByName('NOT_CILVAS').AsString = 'S') Or
            (qryConsulta.FieldByName('REL_CILVAS').AsString = 'S')) Then
      Exit;

    If (qryConsulta.FieldByName('AUX_CILVAS').AsString <> 'S') And
       (qryConsulta.FieldByName('REL_CILVAS').AsString = 'S') And
       (Not fEmptyStr(qryConsulta.FieldByName('REL_AUTINC').AsString)) Then
    Begin
      strAutIcv    := qryConsulta.FieldByName('REL_AUTINC').AsString;
      blnAtualizar := True;
    End
    Else
    If (qryConsulta.FieldByName('AUX_CILVAS').AsString = 'S') And
       (qryConsulta.FieldByName('REL_CILVAS').AsString <> 'S') And
       (fEmptyStr(qryConsulta.FieldByName('REL_AUTINC').AsString)) Then
    Begin
      strGerAutInc := qryConsulta.FieldByName('MOV_AUTINC').AsString;

      qryConsulta.Close;
      qryConsulta.SQL.Text := strSql
                            + ' WHERE X.AUX_SEQGER = :AUTINC ';
      qryConsulta.ParamByName('AUTINC').AsString := strGerAutInc;
      qryConsulta.Open;

      strAutIcv    := qryConsulta.FieldByName('GER_AUTINC').AsString;
      blnAtualizar := True;
    End;

    If blnAtualizar Then
    Begin
      qryGravacao.SQL.Text := 'UPDATE AUXNOT '
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

function fGravaNdtCha(strAutInc: String;
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
    qryDetCha.SQL.Add('  INSERT INTO NDTCHA (  ');
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


end.
