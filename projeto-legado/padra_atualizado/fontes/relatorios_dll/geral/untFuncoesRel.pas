unit untFuncoesRel;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  UniClientDataSet,
{$ENDIF}
  untTypesSistema, untTipoTinta;

Type
  TfGravaFatGor = function (Var strAutInc: String;
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
                          intLibera: Integer;
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
                          strPerEnt,
                          strEmlCon: String;
                          blnPedBlo: Boolean;
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
                          strTFTNEs: String;
                          dtaHPrevi: TDateTime;
                          strCodCar: String;
                          intQtdPaC: Integer;
                          strFasObr: String;
                          strEntUrg: String;
                          strSepImp: String;
                          strCorte_: String;
                          strNumGui: string = '';
                          strOrcOri: string = '';
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
                          fltFreMkp: Double = 0;
                          fltComMkp: Double = 0;
                          blnDevwms: Boolean = false;
                          strHisCom: String = '';
                          strCodEve: string = '';
                          dtaDH_Imp: TDateTime = 0;
                          strOpBxSe: String = '';
                          strOpeLib: String = '';
                          strDigLib: String = '';
                          dtaHorLib: TDateTime = 0;
                          dtaDtaLib: TDateTime = 0;
                          blnCortPD: Boolean = False;
                          strEntFutOpc: String = '';
                          AblnGeradoPelaConsignacao : Boolean = False;
                          blnAbaDep: Boolean = False;
                          strNumOrigem: String = '';
                          strEspOrigem: String = '';
                          strEmpOrigem: String = '';
                          blnLoc_PD: Boolean = False;
                          strPlaVei_ : String = '';
                          strCodMot  : String = '';
                          strBetone  : String = '';
                          strLacre_  : String = '';
                          strConBom  : String = '';
                          intFckDia  : Integer = 0;
                          strAbatim  : String = '';
                          strTipMps  : String = '';
                          strBrita_  : String = '';
                          strTipBom  : String = '';
                          fltQtdBom  : Double = 0;
                          fltPrcBom  : Double = 0;
                          fltTotBom  : Double = 0;
                          strCodObr  : String = '';
                          strCodArt  : String = '';
                          blnUPSEML: Boolean = False;
                          strComplementoFrmLogGor: String = '';
                          ATxIdPix: String = '';
                          AEmpresaPix: String = '';
                          blnColeta: Boolean = False;
                          strIncTer  : String = '';
                          strPorDes  : String = '';
                          strPorEmb  : String = '';
                          strAeropo  : String = '';
                          fltTarifa  : Double = 0;
                          fltSeguro  : Double = 0;
                          fltFrete_  : Double = 0;
                          strNotify  : String = '';
                          strEWorks  : String = '';
                          strContai  : String = '';
                          strPackin  : String = '';
                          strNumeroDrawback : String = '';
                          blnConEqu: Boolean = False;
                          fltTotCredAutomatico: Double = 0;
                          dtaDtLbEx: TDateTime = 0;
                          hraHrLbEx: TDateTime = 0;
                          fltFreCot: Double = 0;
                          blnRegEs2: Boolean = False;
                          strFornecedorUsoConsumo: String = '';
                          strCentroCustoUsoConsumo: String = '';
                          strHistoricoUsoConsumo: String = '';
                          strEventoUsoConsumo: String = '';
                          blnDesmembraPedRegEsp: Boolean = False;
                          strAutIcv: String = '';
                          blnDesmembrouSaindoDoRegime: Boolean = False;
                          strCliCEO: String = '';
                          strEmpFatSemSaldo: String = '';
                          fltVolSepExc: Double = 0;
                          fltVolSepNExc: Double = 0;
                          strEmpExpPrioridadeEstoque: String = '';
                          strCliTop: String = '';
                          strAutRco: String = '';
                          strSupGer : String = '';
                          strSupReg : String = '';
                          strObsExp: String = '';
                          strOpeExp: String = '';
                          strIntFus: String = 'N';
                          fltFatSer: Double = 0;
                          strSeqSep: String = '';
                          strSeqOnd: String = '';
                          strCelCon: String = '';
                          strPerguntaDevAbaDep: String = '';
                          fltDecZfm : Double = 0;
                          blnUtiAbaAutoCredPend: Boolean = False;
                          strSepAnt: String = '';
                          dtaDtaAnt: TDateTime = 0;
                          dtaHraAnt: TDateTime = 0;
                          strAcpCar: String = '';
                          fltAcpCom: Double = 0;
                          blnGeraDocOriMesmoNumDoc: Boolean = False;
                          strVchCdp: String = '';
                          strCotLal : String = '';
                          strOndaOp: String = '';
                          dtaOndaDt: TDateTime = 0;
                          hraOndaHr: TDateTime = 0;
                          strCodCno: String = '';
                          intCdcOpo: Integer = 0;
                          strCdcSta: String = '';
                          strInsImo : String = '';
                          strCodCib : String = '';
                          fltTotIbs : Double = 0;
                          fltTotCbs : Double = 0;
                          fltTotIs : Double = 0
                          ): Boolean;

   TfGravaFatDor = function (Var strAutInc: String;
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
                          strEmpIte,
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
                          fltFreMkp: Double = 0;
                          fltComMkp: Double = 0;
                          strProEsp: String = '';
                          strVenCbo: String = '';
                          strCodPro: String = '';
                          fltUniDol: Double = 0;
                          fltTotDol: Double = 0;
                          fltQtdRco: Double = 0;
                          blnExiBSe: Boolean = True;
                          strAIdKitPromocao : String = '';
                          strOpBxSe: String = '';
                          dtaDtBxSe: TDateTime = 0;
                          dtaHrBxSe: TDateTime = 0;
                          strEmpCar: String = '';
                          fltDesBai: Double = 0;
                          strTemNumSerie: String = '';
                          fltVDesST: Double = 0;
                          strMDesST: String = '';
                          strReserv: String = 'S';
                          intSeqInv: Integer = 0 ;
                          strSeqEql: String = '';
                          strNumDrw: String = '';
                          blnMntPrc: Boolean = False;
                          fltQtdRet: Double = 0;
                          strNumPla: String = '';
                          strParNum: String = '';
                          strReqCom: String = '';
                          strAutEnd: String = '';
                          strRegEsp: String = '';
                          fltFreCot: Double = 0;
                          blnAltEst: Boolean = False;
                          intSeqPer: Integer = 0;
                          blnRatEst: Boolean = False;
                          strObsRco: String = '';
                          strNumPok: String = '';
                          strDocOri: String = '';
                          strEspOri: String = '';
                          strEmpOri: String = '';
                          strOpeSep: String = '';
                          strOpeExp: String = '';
                          strEmpDmp: String = '';
                          fltUnDiDe: Double = 0;
                          strBasTro: String = '';
                          dtaDtaCmp: TDateTime = 0;
                          fltOutValPD: Double = 0;
                          fltFreEntPD: Double = 0;
                          fltAcpProPD: Double = 0;
                          fltAcpTxcPD: Double = 0;
                          fltAcpVctPD: Double = 0;
                          fltAcpResPD: Double = 0;
                          fltAcpMarPD: Double = 0;
                          strTckQbt: String = '';
                          strSeqPre: String = '';
                          fltSomaColorantes : Double = 0;
                          strAutLdg: String = '';
                          fltIcmPrd: Double = 0;
                          fltValPis : Double = 0;
                          fltValCof : Double = 0): Boolean;

  TfExecutaRelatorioCodigo = Function(strCodRel: String;
                                      arrParametros: Array Of String;
                                      arrValores: Array Of String;
                                      arrParametrosReadOnly: TArrString = Nil;
                                      blnExecutarDireto: Boolean = False;
                                      blnExibirMensagem: Boolean = True;
                                      strDirAce: String = '';
                                      blnValidacao: Boolean = False;
                                      objRetornoRelatorio: TRetornoRelatorio = Nil;
                                      fecharJanelaDeDadosAoImprimir: Boolean = False;
                                      HandleSelPedidoCompra: THandle = 0): Boolean Of Object;

  TExecutaRelatorio = Procedure(intCodigoAtalho,
                                intChaveDefault: integer;
                                intChavesPossiveis: Array Of Integer;
                                arrParametros: Array Of String;
                                arrValores: Array Of String;
                                SenderChamada: TObject;
                                arrParametrosReadOnly: TArrString = Nil;
                                blnExecutarDireto: Boolean = False;
                                blnExibirMensagem: Boolean = True;
                                strDirAce: String = '';
                                blnUsuarioLogadoDefaultVerdeVermelho: Boolean = False;
                                objParametrosRelatorio: TParametrosRelatorio = Nil) Of Object;

  TfExecutaRelatorio = Function(intCodigoAtalho,
                                intChaveDefault: integer;
                                intChavesPossiveis: Array Of Integer;
                                arrParametros: Array Of String;
                                arrValores: Array Of String;
                                SenderChamada: TObject;
                                arrParametrosReadOnly: TArrString = Nil;
                                blnExecutarDireto: Boolean = False;
                                blnExibirMensagem: Boolean = True;
                                strDirAce: String = '';
                                blnDestinoJson: Boolean = False;
                                blnMostrarProgresso: Boolean = True): Boolean Of Object;

  TRetornaSelectEditorDashBoard = Function(intCodigoAtalho,
                                            intChaveDefault: integer;
                                            arrParametros: Array Of String;
                                            arrValores: Array Of String;
                                            Var strTemporarias: String): string Of Object;

  TRetornaJsonEditorDashBoard = Function(intCodigoAtalho,
                                         intChaveDefault: integer;
                                         arrParametros: Array Of String;
                                         arrValores: Array Of String;
                                         blnMostrarProgresso: Boolean;
                                         blnExecutarDireto: Boolean = True): string Of Object;

  TImprimeDocumento = Procedure (strNumDoc, strEspDoc, strCodEmp: String);

  TSimplesProcedure = Procedure;

  TAbreCadastroProcedure = Procedure (strCodIte: String);
  TExibeRequisicaoCompra = procedure(strCodigo: String; strCodEmp: String) of object;
  TGerarEmail = function (strNumDoc,
                          strEspDoc: String;
                          opcComSemPreco: TImpressaoComSemPrecoOrPd;
                          blnComMarca: Boolean;
                          strTipExp: String;
                          strModo: String = 'R';
                          strOrdem        : String = '';
                          strCodEmpPar    : String = '';
                          blnLocFis       : Boolean = False;
                          strNomEmp       : String = 'R';
                          strCodCli       : String = '';
                          blnCabecalhoCD  : Boolean = False;
                          blnDocCancelado : Boolean = False;
                          blnQtdOri       : Boolean = True): String of Object;

  TGrupoChamada = (tpcTelaFiltros, tpcGrid);

  TfVerificaSeRelatorioExiste = Function(intCodigoAtalho,
                                         intChaveDefault: integer): Boolean Of Object;

 Const
   INT_GRUPO_FILTROS = 1;
   INT_GRUPO_GRID = 2;

 Var
   prcExecutaRelatorio: TExecutaRelatorio;
   fncExecutaRelatorio: TfExecutaRelatorio;
   fncExecutaRelatorioCodigo: TfExecutaRelatorioCodigo;
   fncRetornaSelectEditorDashBoard: TRetornaSelectEditorDashBoard;
   fncRetornaJsonEditorDashBoard: TRetornaJsonEditorDashBoard;
   fncVerificaSeRelatorioExiste: TfVerificaSeRelatorioExiste;

implementation

initialization
  prcExecutaRelatorio := Nil;
  fncExecutaRelatorio := Nil;
  fncExecutaRelatorioCodigo := Nil;
  fncRetornaSelectEditorDashBoard := Nil;
  fncRetornaJsonEditorDashBoard := Nil;
  fncVerificaSeRelatorioExiste := Nil;

end.

