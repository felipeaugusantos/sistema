unit untGarantiaLibFuncoesFaturamento;

interface

uses
  untFuncFat, BitBtnLockedIncrem, UniClientDataSet, untFuncFatTypes, untFuncoes,
  untTypesSistema;
Type
  TParametrosPAdicionarRegistroTemporaria = class
  public
   {$Region 'Fields'}
    cdsDados: TUniClientDataSet;
    btnAdicionar: TBitBtnLocked;
    strIdePro: String;
    strCodGru: String;
    strCodIte: String;
    strDesOri: String;
    strDesIte: String;
    strDesFab: String;
    strUnidad: String;
    strCodUni: String;
    strCodMar: String;
    strCodFor: String;
    strRefere: String;
    fltUniOri: Double;
    fltUniVis: Double;
    fltUniTar: Double;
    fltUniTmp: Double;
    fltDesCon: Double;
    fltQtdIte: Double;
    fltTotIte: Double;
    strEntSai: String;
    fltPreCus: Double;
    fltTotCus: Double;
    strComLub: String;
    fltIpiSai: Double;
    fltDesMax: Double;
    fltPreVe1: Double;
    fltPreVe2: Double;
    fltPreVe3: Double;
    fltPreVe4: Double;
    fltPreVe5: Double;
    fltPreVe6: Double;
    fltPreVe7: Double;
    fltMarLuc: Double;
    fltSaldos: Double;
    strIncPis: String;
    fltComVar: Double;
    fltComAta: Double;
    fltComDis: Double;
    strDocDev: String;
    strEspDev: String;
    strEmpDev: String;
    fltQtdDev: Double;
    fltUniDev: Double;
    strIncDev: String;
    fltTotUlt: Double;
    fltImpUlt: Double;
    fltPreUlt: Double;
    fltPreMed: Double;
    strClaIpi: String;
    strIteCha: String;
    strIteTin: String;
    strDesCor: String;
    strTipPre: String;
    intLazQua: Integer;
    strTipEmb: String;
    fltQtdEmb: Double;
    fltPreEmb: Double;
    fltPrvTin: Double;
    fltPrcTin: Double;
    fltFatTin: Double;
    strProEmb: String;
    strIteEmb: String;
    fltUniEmb: Double;
    fltEmbAnt: Double;
    strCodAbf: String;
    fltPesoIt: Double;
    fltPesLiq: Double;
    strPromoc: String;
    fltProPreCus: Double;
    fltProPreVen: Double;
    fltProComVar: Double;
    fltProDesF07: Double;
    strTipTin: String;
    fltGPeCom: Double;
    strCodFab: String;
    intSeqInd: Integer;
    fltQtdBai: Double;
    strNumOrc: String;
    strEspOrc: String;
    strEmpOrc: String;
    fltMarMin: Double;
    fltMarMSG: Double;
    fltMarMGe: Double;
    strMarca: String;
    strStatus: String;
    fltComDev: Double;
    fltDesDev: Double;
    strSeqDet: String;
    strCatalize: String;
    strLinTin: String;
    fltEmbala: Double;
    strDesNes: String;
    strSemEst: String;
    strLibEst: String;//Liberou sem estoque mediante senha
    fltPreCom: Double;
    fltUniDig: Double;
    fltQtdPon: Double;
    strComple: String;
    strDivDev: String;
    strObrCpf: String;
    strMontad: String;
    strA_n_o_: String;
    strSigUni: String;
    fltVolPro: Double;
    intOrdite: Integer;
    strChaFor: String;
    strCodAca: String;
    strEmpAca: String;
    blnProAca: Boolean;
    strEspFut: String;
    strDocFut: String;
    strEmpFut: String;
    fltOutVal: Double;
    fltComTbl: Double;
    fltDesOpe: Double;
    fltICMSai: Double;
    fltImpFed: Double;
    fltDesMge: Double;
    strDocCnf: String;
    strEspCnf: String;
    strEmpCnf: String;
    strTabPre: String;
    fltIpiEnt: Double;
    fltFreEnt: Double;
    strCodDil: String;
    fltPorDil: Double;
    strDilCon: String;
    fltPorCat: Double;
    strEntRet: String;
    strLocRet: String;
    strEntFut: String;
    strMotFut: String;
    dtaDtaEnt: TDateTime;
    fltQtdOri: Double;
    fltDesEsp: Double;
    fltDesBai: Double;
    strImpDir: String;
    strLocFis: String;
    fltPreCu2: Double;
    fltTotCu2: Double;
    fltProComAta: Double;
    fltProComDis: Double;
    fltTotPed: Double;
    fltPanUti: Double;
    fltTotDes: Double;
    ftlTotFre: Double;
    recForTin: TForTin;
    strKey_EP: String;
    strLotAnt: String;
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
    fltDesFin: Double;
    fltPreLot: Double;
    fltCoDvRp: Double;
    strEmpIte: String;
    fltFatAce: Double;
    blnPodAlt: Boolean;
    strEmpSol: String;
    strCndDev: String;
    strCCndDv: String;
    dtaEmiDev: TDate;
    fltCusIte: Double;
    strDesSim: String;
    strOrdPro: String;
    recMadeira: untTypesSistema.TDadosMadeira;
    fltTotImp: Double;
    fltVal_RT: Double;
    fltTaxJur: Double;
    strSeqGad: String;
    fltQtdExp: Double;
    strBarEmb: String;
    strNumCmp: String;
    intNItCmp: Integer;
    fltDeDVCf: Double;
    strCodMec: String;
    strSeqRcd: String;
    intSeqInc: Integer;
    strCodVenIte: String;
    strAltPCoIte: String;
    fltPerComIte: Double;
    fltFreDev: Double;
    fltDeADev: Double;
    blnAlterandoPDORCarregado: Boolean;
    blnInserindoPDORCarregado: Boolean;
    strCliBus: String;
    strTurEnt: String;
    intSeqCcr: Integer;
    fltDopTin: Double;
    strCodVe2Ite: String;
    strLibUni: String;
    fltValDif: Double;
    strLotAba: String;
    strIncFut: String;
    strSepExp: String;
    strTabPreEmb: String;
    strExcIpi: String;
    fltDesMSu: Double;
    strAiDvOr: String;
    strClaFis: String;
    strSeqOpI: String;
    strRatDes: String;
    strBrinde: String;
    strCodPar: String;
    strTipBri: String;
    strSeqGer: String;
    strBaseQtdZerada: String;
    blnEdiPes: Boolean;
    fltPesoItCad: Double;
    fltPesLiqCad: Double;
    strPegou_: String;
    strIteAbf: String;
    strAtivac: String;
    intSeqCom: Integer;
    fltQtdAti: Double;
    fltQtdCom: Double;
    strTabCom: String;
    fltPorGer: Double;
    fltPorDet: Double;
    intSeqEst: Integer;
    strIteEst: String;
    fltUniEst: Double;
    fltQtdSbi: Double;
    fltUniSbi: Double;
    strLotSep: String;
    strObsColorista: String;
    intTipoFormulacao: Integer;
    fltFreMkp: Double;
    fltComMkp: Double;
    blnJaFatu: Boolean;
    strTipFat: String;
    strNumFat: String;
    strEmpFat: String;
    strVenFat: String;
    strCndFat: String;
    fltValFat: Double;
    dtaDtaFat: TDateTime;
    fltComDig: Double;
    fltBFCPST: Double;
    fltPFCPST: Double;
    fltVFCPST: Double;
    intQDEntr: Integer;
    strNotC17: String;
    strCodCmg: String;
    fltQtdSep: Double;
    fltDesCnd: Double;
    strProEsp: String;
    strPorPer: String;
    strExibSE: String;
    strFdoIteRecalcPrecos: String;
    strOpBxSe: String;
    dtaDtBxSe: TDateTime;
    dtaHrBxSe: TDateTime;
    strEmpCar: String;
    strAutoinDevCar: String;
    strEntFutDocOri: String;
    strTemNumSerie: String;
    strOpSeEx: String;
    strConExp: String;
    strEmbExp: String;
    strObsExp: String;
    strChkOut: String;
    {$Endregion}
  public
    constructor Create(cdsDados: TUniClientDataSet; btnAdicionar: TBitBtnLocked; recMadeira: untTypesSistema.TDadosMadeira);
    procedure pInicializar;
    procedure pInicializarValoresDefaultMetodo;

  public
    class procedure pAdicionarRegistroTemporaria(aFatVenda: TFatVenda; Parametros: TParametrosPAdicionarRegistroTemporaria);
  end;

implementation

{ TParametrosPAdicionarRegistroTemporaria }

constructor TParametrosPAdicionarRegistroTemporaria.Create(cdsDados: TUniClientDataSet; btnAdicionar: TBitBtnLocked;
  recMadeira: untTypesSistema.TDadosMadeira);
begin
  Self.cdsDados := cdsDados;
  Self.btnAdicionar := btnAdicionar;
  Self.RecMadeira := recMadeira;
  Self.pInicializar;
end;

procedure TParametrosPAdicionarRegistroTemporaria.pInicializar;
begin
  {$Region 'Inicializando parâmetros'}
  Self.fltUniOri:= 0;
  Self.fltUniVis:= 0;
  Self.fltUniTar:= 0;
  Self.fltUniTmp:= 0;
  Self.fltDesCon:= 0;
  Self.fltQtdIte:= 0;
  Self.fltTotIte:= 0;
  Self.fltPreCus:= 0;
  Self.fltTotCus:= 0;
  Self.fltIpiSai:= 0;
  Self.fltDesMax:= 0;
  Self.fltPreVe1:= 0;
  Self.fltPreVe2:= 0;
  Self.fltPreVe3:= 0;
  Self.fltPreVe4:= 0;
  Self.fltPreVe5:= 0;
  Self.fltPreVe6:= 0;
  Self.fltPreVe7:= 0;
  Self.fltMarLuc:= 0;
  Self.fltSaldos:= 0;
  Self.fltComVar:= 0;
  Self.fltComAta:= 0;
  Self.fltComDis:= 0;
  Self.fltQtdDev:= 0;
  Self.fltUniDev:= 0;
  Self.fltTotUlt:= 0;
  Self.fltImpUlt:= 0;
  Self.fltPreUlt:= 0;
  Self.fltPreMed:= 0;
  Self.intLazQua:= 0;
  Self.fltQtdEmb:= 0;
  Self.fltPreEmb:= 0;
  Self.fltPrvTin:= 0;
  Self.fltPrcTin:= 0;
  Self.fltFatTin:= 0;
  Self.fltUniEmb:= 0;
  Self.fltEmbAnt:= 0;
  Self.fltPesoIt:= 0;
  Self.fltPesLiq:= 0;
  Self.fltProPreCus:= 0;
  Self.fltProPreVen:= 0;
  Self.fltProComVar:= 0;
  Self.fltProDesF07:= 0;
  Self.fltGPeCom:= 0;
  Self.intSeqInd:= 0;
  Self.fltQtdBai:= 0;
  Self.fltMarMin:= 0;
  Self.fltMarMSG:= 0;
  Self.fltMarMGe:= 0;
  Self.fltComDev:= 0;
  Self.fltDesDev:= 0;
  Self.fltEmbala:= 0;
  Self.fltPreCom:= 0;
  Self.fltUniDig:= 0;
  Self.fltQtdPon:= 0;
  Self.fltVolPro:= 0;
  Self.intOrdite:= 0;
  Self.fltOutVal:= 0;
  Self.fltComTbl:= 0;
  Self.fltDesOpe:= 0;
  Self.fltICMSai:= 0;
  Self.fltImpFed:= 0;
  Self.fltDesMge:= 0;
  Self.fltIpiEnt:= 0;
  Self.fltFreEnt:= 0;
  Self.fltPorDil:= 0;
  Self.fltPorCat:= 0;
  Self.dtaDtaEnt:= 0;
  Self.fltQtdOri:= 0;
  Self.fltDesEsp:= 0;
  Self.fltDesBai:= 0;
  Self.fltPreCu2:= 0;
  Self.fltTotCu2:= 0;
  Self.fltProComAta:= 0;
  Self.fltProComDis:= 0;
  Self.fltTotPed:= 0;
  Self.fltPanUti:= 0;
  Self.fltTotDes:= 0;
  Self.ftlTotFre:= 0;


  Self.fltQtdDet:= 0;
  Self.fltDesFin:= 0;
  Self.fltPreLot:= 0;
  Self.fltCoDvRp:= 0;
  Self.fltFatAce:= 0;

  Self.dtaEmiDev:= 0;
  Self.fltCusIte:= 0;

  Self.fltTotImp:= 0;
  Self.pInicializarValoresDefaultMetodo;
  {$EndRegion}
end;

procedure TParametrosPAdicionarRegistroTemporaria.pInicializarValoresDefaultMetodo;
begin
  {$Region 'Parâmetros que possuem valor "Default" na assinatura do método principal'}
  fltVal_RT:= 0;
  fltTaxJur:= 0;
  strSeqGad:= '';
  fltQtdExp:= 0;
  strBarEmb:= '';
  strNumCmp:= '';
  intNItCmp:= 0;
  fltDeDVCf:= 0;
  strCodMec:= '';
  strSeqRcd:= '';
  intSeqInc:= 0;
  strCodVenIte:= '';
  strAltPCoIte:= 'N';
  fltPerComIte:= 0;
  fltFreDev:= 0;
  fltDeADev:= 0;
  blnAlterandoPDORCarregado:= False;
  blnInserindoPDORCarregado:= False;
  strCliBus:= 'N';
  strTurEnt:= '';
  intSeqCcr:= 0;
  fltDopTin:= 0;
  strCodVe2Ite:= '';
  strLibUni:= 'N';
  fltValDif:= 0;
  strLotAba:= '';
  strIncFut:= '';
  strSepExp:= '';
  strTabPreEmb:= '';
  strExcIpi:= '';
  fltDesMSu:= 0.00;
  strAiDvOr:= '';
  strClaFis:= '';
  strSeqOpI:= '';
  strRatDes:= 'S';
  strBrinde:= 'N';
  strCodPar:= '';
  strTipBri:= '';
  strSeqGer:= '';
  strBaseQtdZerada:= '';
  blnEdiPes:=False;
  fltPesoItCad:= -1;
  fltPesLiqCad:= -1;
  strPegou_:= 'N';
  strIteAbf:= '';
  strAtivac:= 'N';
  intSeqCom:= 0;
  fltQtdAti:= 0;
  fltQtdCom:= 0;
  strTabCom:= '';
  fltPorGer:= 0;
  fltPorDet:= 0;
  intSeqEst:= 0;
  strIteEst:= '';
  fltUniEst:= 0;
  fltQtdSbi:= 0;
  fltUniSbi:= 0;
  strLotSep:= '';
  strObsColorista:= '';
  intTipoFormulacao:= 0;
  fltFreMkp:= 0;
  fltComMkp:= 0;
  blnJaFatu:= False;
  strTipFat:= '';
  strNumFat:= '';
  strEmpFat:= '';
  strVenFat:= '';
  strCndFat:= '';
  fltValFat:= 0;
  dtaDtaFat:= 0;
  fltComDig:= 0;
  fltBFCPST:= 0;
  fltPFCPST:= 0;
  fltVFCPST:= 0;
  intQDEntr:= 0;
  strNotC17:= '';
  strCodCmg:= '';
  fltQtdSep:= 0;
  fltDesCnd:= 0;
  strProEsp:= '';
  strPorPer:= '';
  strExibSE:= 'N';
  strFdoIteRecalcPrecos:= 'N';
  strOpBxSe:= '';
  dtaDtBxSe:= 0;
  dtaHrBxSe:= 0;
  strEmpCar:= '';
  strAutoinDevCar:= '';
  strEntFutDocOri:= '';
  strTemNumSerie:= '';
  strOpSeEx:= '';
  strConExp:= '';
  strEmbExp:= '';
  strObsExp:= '';
  strChkOut:= '';
  {$Endregion}
end;
class procedure TParametrosPAdicionarRegistroTemporaria.pAdicionarRegistroTemporaria(aFatVenda: TFatVenda; Parametros: TParametrosPAdicionarRegistroTemporaria);
begin
  {$Region 'pAdicionarRegistroTemporaria - principal'}

  aFatVenda.pAdicionaRegistroTemporaria(Parametros.cdsDados,
                                        Parametros.btnAdicionar,
                                        Parametros.strIdePro,
                                        Parametros.strCodGru,
                                        Parametros.strCodIte,
                                        Parametros.strDesOri,
                                        Parametros.strDesIte,
                                        Parametros.strDesFab,
                                        Parametros.strUnidad,
                                        Parametros.strCodUni,
                                        Parametros.strCodMar,
                                        Parametros.strCodFor,
                                        Parametros.strRefere,
                                        Parametros.fltUniOri,
                                        Parametros.fltUniVis,
                                        Parametros.fltUniTar,
                                        Parametros.fltUniTmp,
                                        Parametros.fltDesCon,
                                        Parametros.fltQtdIte,
                                        Parametros.fltTotIte,
                                        Parametros.strEntSai,
                                        Parametros.fltPreCus,
                                        Parametros.fltTotCus,
                                        Parametros.strComLub,
                                        Parametros.fltIpiSai,
                                        Parametros.fltDesMax,
                                        Parametros.fltPreVe1,
                                        Parametros.fltPreVe2,
                                        Parametros.fltPreVe3,
                                        Parametros.fltPreVe4,
                                        Parametros.fltPreVe5,
                                        Parametros.fltPreVe6,
                                        Parametros.fltPreVe7,
                                        Parametros.fltMarLuc,
                                        Parametros.fltSaldos,
                                        Parametros.strIncPis,
                                        Parametros.fltComVar,
                                        Parametros.fltComAta,
                                        Parametros.fltComDis,
                                        Parametros.strDocDev,
                                        Parametros.strEspDev,
                                        Parametros.strEmpDev,
                                        Parametros.fltQtdDev,
                                        Parametros.fltUniDev,
                                        Parametros.strIncDev,
                                        Parametros.fltTotUlt,
                                        Parametros.fltImpUlt,
                                        Parametros.fltPreUlt,
                                        Parametros.fltPreMed,
                                        Parametros.strClaIpi,
                                        Parametros.strIteCha,
                                        Parametros.strIteTin,
                                        Parametros.strDesCor,
                                        Parametros.strTipPre,
                                        Parametros.intLazQua,
                                        Parametros.strTipEmb,
                                        Parametros.fltQtdEmb,
                                        Parametros.fltPreEmb,
                                        Parametros.fltPrvTin,
                                        Parametros.fltPrcTin,
                                        Parametros.fltFatTin,
                                        Parametros.strProEmb,
                                        Parametros.strIteEmb,
                                        Parametros.fltUniEmb,
                                        Parametros.fltEmbAnt,
                                        Parametros.strCodAbf,
                                        Parametros.fltPesoIt,
                                        Parametros.fltPesLiq,
                                        Parametros.strPromoc,
                                        Parametros.fltProPreCus,
                                        Parametros.fltProPreVen,
                                        Parametros.fltProComVar,
                                        Parametros.fltProDesF07,
                                        Parametros.strTipTin,
                                        Parametros.fltGPeCom,
                                        Parametros.strCodFab,
                                        Parametros.intSeqInd,
                                        Parametros.fltQtdBai,
                                        Parametros.strNumOrc,
                                        Parametros.strEspOrc,
                                        Parametros.strEmpOrc,
                                        Parametros.fltMarMin,
                                        Parametros.fltMarMSG,
                                        Parametros.fltMarMGe,
                                        Parametros.strMarca,
                                        Parametros.strStatus,
                                        Parametros.fltComDev,
                                        Parametros.fltDesDev,
                                        Parametros.strSeqDet,
                                        Parametros.strCatalize,
                                        Parametros.strLinTin,
                                        Parametros.fltEmbala,
                                        Parametros.strDesNes,
                                        Parametros.strSemEst,
                                        Parametros.strLibEst,
                                        Parametros.fltPreCom,
                                        Parametros.fltUniDig,
                                        Parametros.fltQtdPon,
                                        Parametros.strComple,
                                        Parametros.strDivDev,
                                        Parametros.strObrCpf,
                                        Parametros.strMontad,
                                        Parametros.strA_n_o_,
                                        Parametros.strSigUni,
                                        Parametros.fltVolPro,
                                        Parametros.intOrdite,
                                        Parametros.strChaFor,
                                        Parametros.strCodAca,
                                        Parametros.strEmpAca,
                                        Parametros.blnProAca,
                                        Parametros.strEspFut,
                                        Parametros.strDocFut,
                                        Parametros.strEmpFut,
                                        Parametros.fltOutVal,
                                        Parametros.fltComTbl,
                                        Parametros.fltDesOpe,
                                        Parametros.fltICMSai,
                                        Parametros.fltImpFed,
                                        Parametros.fltDesMge,
                                        Parametros.strDocCnf,
                                        Parametros.strEspCnf,
                                        Parametros.strEmpCnf,
                                        Parametros.strTabPre,
                                        Parametros.fltIpiEnt,
                                        Parametros.fltFreEnt,
                                        Parametros.strCodDil,
                                        Parametros.fltPorDil,
                                        Parametros.strDilCon,
                                        Parametros.fltPorCat,
                                        Parametros.strEntRet,
                                        Parametros.strLocRet,
                                        Parametros.strEntFut,
                                        Parametros.strMotFut,
                                        Parametros.dtaDtaEnt,
                                        Parametros.fltQtdOri,
                                        Parametros.fltDesEsp,
                                        Parametros.fltDesBai,
                                        Parametros.strImpDir,
                                        Parametros.strLocFis,
                                        Parametros.fltPreCu2,
                                        Parametros.fltTotCu2,
                                        Parametros.fltProComAta,
                                        Parametros.fltProComDis,
                                        Parametros.fltTotPed,
                                        Parametros.fltPanUti,
                                        Parametros.fltTotDes,
                                        Parametros.ftlTotFre,
                                        Parametros.recForTin,
                                        Parametros.strKey_EP,
                                        Parametros.strLotAnt,
                                        Parametros.strNumLot,
                                        Parametros.strEmpPrd,
                                        Parametros.strVenCnf,
                                        Parametros.blnBxSbIt,
                                        Parametros.strPigBas,
                                        Parametros.strIdeDev,
                                        Parametros.fltQtdDet,
                                        Parametros.strTabDev,
                                        Parametros.strCodBar,
                                        Parametros.strTipFin,
                                        Parametros.fltDesFin,
                                        Parametros.fltPreLot,
                                        Parametros.fltCoDvRp,
                                        Parametros.strEmpIte,
                                        Parametros.fltFatAce,
                                        Parametros.blnPodAlt,
                                        Parametros.strEmpSol,
                                        Parametros.strCndDev,
                                        Parametros.strCCndDv,
                                        Parametros.dtaEmiDev,
                                        Parametros.fltCusIte,
                                        Parametros.strDesSim,
                                        Parametros.strOrdPro,
                                        Parametros.recMadeira,
                                        Parametros.fltTotImp,
                                        Parametros.fltVal_RT,
                                        Parametros.fltTaxJur,
                                        Parametros.strSeqGad,
                                        Parametros.fltQtdExp,
                                        Parametros.strBarEmb,
                                        Parametros.strNumCmp,
                                        Parametros.intNItCmp,
                                        Parametros.fltDeDVCf,
                                        Parametros.strCodMec,
                                        Parametros.strSeqRcd,
                                        Parametros.intSeqInc,
                                        Parametros.strCodVenIte,
                                        Parametros.strAltPCoIte,
                                        Parametros.fltPerComIte,
                                        Parametros.fltFreDev,
                                        Parametros.fltDeADev,
                                        Parametros.blnAlterandoPDORCarregado,
                                        Parametros.blnInserindoPDORCarregado,
                                        Parametros.strCliBus,
                                        Parametros.strTurEnt,
                                        Parametros.intSeqCcr,
                                        Parametros.fltDopTin,
                                        Parametros.strCodVe2Ite,
                                        Parametros.strLibUni,
                                        Parametros.fltValDif,
                                        Parametros.strLotAba,
                                        Parametros.strIncFut,
                                        Parametros.strSepExp,
                                        Parametros.strTabPreEmb,
                                        Parametros.strExcIpi,
                                        Parametros.fltDesMSu,
                                        Parametros.strAiDvOr,
                                        Parametros.strClaFis,
                                        Parametros.strSeqOpI,
                                        Parametros.strRatDes,
                                        Parametros.strBrinde,
                                        Parametros.strCodPar,
                                        Parametros.strTipBri,
                                        Parametros.strSeqGer,
                                        Parametros.strBaseQtdZerada,
                                        Parametros.blnEdiPes,
                                        Parametros.fltPesoItCad,
                                        Parametros.fltPesLiqCad,
                                        Parametros.strPegou_,
                                        Parametros.strIteAbf,
                                        Parametros.strAtivac,
                                        Parametros.intSeqCom,
                                        Parametros.fltQtdAti,
                                        Parametros.fltQtdCom,
                                        Parametros.strTabCom,
                                        Parametros.fltPorGer,
                                        Parametros.fltPorDet,
                                        Parametros.intSeqEst,
                                        Parametros.strIteEst,
                                        Parametros.fltUniEst,
                                        Parametros.fltQtdSbi,
                                        Parametros.fltUniSbi,
                                        Parametros.strLotSep,
                                        Parametros.strObsColorista,
                                        Parametros.intTipoFormulacao,
                                        Parametros.fltFreMkp,
                                        Parametros.fltComMkp,
                                        Parametros.blnJaFatu,
                                        Parametros.strTipFat,
                                        Parametros.strNumFat,
                                        Parametros.strEmpFat,
                                        Parametros.strVenFat,
                                        Parametros.strCndFat,
                                        Parametros.fltValFat,
                                        Parametros.dtaDtaFat,
                                        Parametros.fltComDig,
                                        Parametros.fltBFCPST,
                                        Parametros.fltPFCPST,
                                        Parametros.fltVFCPST,
                                        Parametros.intQDEntr,
                                        Parametros.strNotC17,
                                        Parametros.strCodCmg,
                                        Parametros.fltQtdSep,
                                        Parametros.fltDesCnd,
                                        Parametros.strProEsp,
                                        Parametros.strPorPer,
                                        Parametros.strExibSE,
                                        Parametros.strFdoIteRecalcPrecos,
                                        Parametros.strOpBxSe,
                                        Parametros.dtaDtBxSe,
                                        Parametros.dtaHrBxSe,
                                        Parametros.strEmpCar,
                                        Parametros.strAutoinDevCar,
                                        Parametros.strEntFutDocOri,
                                        Parametros.strTemNumSerie,
                                        Parametros.strOpSeEx,
                                        Parametros.strConExp,
                                        Parametros.strEmbExp,
                                        Parametros.strObsExp,
                                        Parametros.strChkOut);
  {$EndRegion}
end;
end.

