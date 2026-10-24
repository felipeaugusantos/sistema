unit untFatGor;

interface

uses
   SysUtils, Classes, TypInfo, DB, Uni,Variants, StrUtils, Forms, UniClientDataSet,
   frxClass, frxDBSet, frxExportPDF, untfuncoesSimples, untTypesSistema, untTFatReprocessarSaldoItem,
   Faturamento.Origem.TOrigemFaturamento, untFuncFatTypes, untCadLote, untTransferenciaArmazens;

Type
  TExcluirExtLarOpcoes = (eeloPerguntar, eeloNaoExcluir, eeloExcluir);

  TFunctionLimparSeparacao = reference to function(const AAutIncGor: String; const AApagarExtLar: Boolean): Boolean;

  TAnexosPedido = Record
    strAutInc: String;
    strSeqFgo: String;
    strArqB64: String;
    strNomArq: String;
  End;

  TArrayAnexosPedido = Array Of TAnexosPedido;

  TControleLiberacaoPedidos = record
  strict private
    type
      TEnviaSomentePedidosDeOrigemExternaParaLiberacao = record
      strict private
        type
          TParametros = record
          public
            strEspDoc: string;
            strNumPok: string;
            DataSet: TDataSet;
            procedure Clear;
          end;
        const
          intSIM = 1;
      public
        class var Parametros: TParametros;
        class procedure Execute; static;
      end;
  public
    class var EnviaSomentePedidosDeOrigemExternaParaLiberacao: TEnviaSomentePedidosDeOrigemExternaParaLiberacao;
  end;

  procedure pAtualizaDuplicataBolAdt(strNumDupDC, strEspDocDC, strCodEmpDC, strCodCliDC : String);

  procedure pIncluiAutEnt(strAutInc,
                          strAutEnt,
                          strMen003,
                          strMen004,
                          strMen005: String;
                          strEntFutOpc: String = '';
                          fltVolSepExc: Double = 0;
                          fltVolSepNExc: Double = 0);

  Function fRetQtdRom(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte, strAutInc: String): Double;

  Function fAtualizaQtdRom(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte,
    strAutIncAnt, strAutIncAtu: String; fltQtdIte: Double): Boolean;

  procedure pGravaSimulacaoCondPagtoPedido(strAutInc, strCodCnd: String; fltTotCnd: Double);

  function fEMPEXP(strCodEmp,
                   strEmpFor,
                   strEmp_Te,
                   strEnt_CD,
                   strEmp_CD,
                   strAbaDep,
                   strRegEs2 : String;
                   blnConEqu: Boolean;
                   strMen001 : String) : String;

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
                        fltFreMkp: Double = 0;
                        fltComMkp: Double = 0;
                        blnDevWms: Boolean = False;
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
                        blnLOC_PD: Boolean = False;
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
                        ATxIdPix   : String = '';
                        AEmpresaPix: String = '';
                        blnColeta  : Boolean = False;
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
                        strCliCEO : String = '';
                        strEmpFatSemSaldo: String = '';
                        fltVolSepExc: Double = 0;
                        fltVolSepNExc: Double = 0;
                        strEmpExpPrioridadeEstoque: String = '';
                        strCliTop : String = '';
                        strAutRco : String = '';
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

  function fGravaFdoCha(strAutInc: String;
                        fltQtdCha: Double;
                        fltMedB_L: Double;
                        fltMedB_A: Double;
                        fltMedL_L: Double;
                        fltMedL_A: Double;
                        fltEspess: Double): Boolean;

  function fRetornaDadosFdoCha(strAutInc: String;
                               fltQtdIte: Double;
                               Out fltQtdCha: Double;
                               Out fltMedB_L: Double;
                               Out fltMedB_A: Double;
                               Out fltMedL_L: Double;
                               Out fltMedL_A: Double;
                               Out fltEspess: Double):Boolean;

  procedure pFaturaConDor(strNumDoc, strEspDoc, strCodEmp, strLisCodIte, strLisFdoSeqGer, strAutoincrem : String; blnFaturandoServicoOuExpedicaoParcial: boolean);

  function fMarcaOrcPed(strNumDoc,
                        strEspDoc,
                        strNumOrc,
                        strEspOrc,
                        strVenFat,
                        strCndFat: String;
                        fltValFat: Double;
                        strEmpOrc: String;
                        blnAtuExp: Boolean;
                        strLisDet: String = '';
                        strEmpFat: String = '';
                        strLisCodIte: String = '';
                        strLisFdoSeqGer: String = '';
                        strLisSeqIndFatGor: String = '';
                        blnTinDor: Boolean = False;
                        blnValidaGorCndSeGravaCadRec: Boolean = True;
                        strCliFat: String = '';
                        strSerFat: String = '';
                        blnFaturamentoAutomatico: Boolean = False): Boolean;

  function fApagaOrcPed(strNumDoc, strEspDoc, strCodEmp: String; strAutIncIteDel: String = ''; blnDelOco: Boolean = False): Boolean;

  procedure pExcluiCadRecTrocaRecebimentoPendente(strNumDoc, strEspDoc, strCodEmp: String);

  procedure pCarregaArrayAnexosPedidos(strAutInc: String; var arrAnexosPedido: TArrayAnexosPedido);

  function fInsereArrayAnexosPedidosNoBanco(strAutInc: String; arrAnexosPedido: TArrayAnexosPedido): Boolean;

  procedure pBaixaTinDor(strNumOrc, strEspOrc, strCodEmp, strVenFat: String; strLisDet: String='');

  function fGeraHtml(strNumDoc, strEspDoc: String; blnComPre: Boolean): String;

  procedure pRetNumeroPedido(strNumFat,
                             strTipFat,
                             strEmpFat: String;
                             Var strNumPed,
                             strEspPed,
                             strEmpPed: String);

  function fGravaTinDor(strSeqGer,
                        strCodEmp,
                        strCodDiv,
                        strCodMar,
                        strCodIte,
                        strCodVen,
                        strCodCli,
                        strNumDoc,
                        strEspDoc: String;
                        dtaDtaEnt,
                        dtaHorEnt: TDateTime;
                        strConPag,
                        strEstado,
                        strDescri,
                        strRefere,
                        strUnidad,
                        strForIte: String;
                        fltQtdIte: Double;
                        strIncPis,
                        strNotEsp,
                        strIdePro,
                        strIteTin,
                        strIteCha,
                        strDesCor,
                        strTipEmb: String;
                        fltQtdEmb,
                        fltPreEmb: Double;
                        strTipPre,
                        strMontad,
                        strA_n_o_,
                        strForm01,
                        strIteC01: String;
                        fltQtdb01: Double;
                        strForm02,
                        strIteC02: String;
                        fltQtdb02: Double;
                        strForm03,
                        strIteC03: String;
                        fltQtdb03: Double;
                        strForm04,
                        strIteC04: String;
                        fltQtdb04: Double;
                        strForm05,
                        strIteC05: String;
                        fltQtdb05: Double;
                        strForm06,
                        strIteC06: String;
                        fltQtdb06: Double;
                        strForm07,
                        strIteC07: String;
                        fltQtdb07: Double;
                        strForm08,
                        strIteC08: String;
                        fltQtdb08: Double;
                        strForm09,
                        strIteC09: String;
                        fltQtdb09: Double;
                        strForm10,
                        strIteC10: String;
                        fltQtdb10: Double;
                        strForm11,
                        strIteC11: String;
                        fltQtdb11: Double;
                        strForm12,
                        strIteC12: String;
                        fltQtdb12: Double;
                        strForm13,
                        strIteC13: String;
                        fltQtdb13: Double;
                        strForm14,
                        strIteC14: String;
                        fltQtdb14: Double;
                        strForm15,
                        strIteC15: String;
                        fltQtdb15: Double;
                        strForm16,
                        strIteC16: String;
                        fltQtdb16: Double;
                        strForm17,
                        strIteC17: String;
                        fltQtdb17: Double;
                        strForm18,
                        strIteC18: String;
                        fltQtdb18: Double;
                        strForm19,
                        strIteC19: String;
                        fltQtdb19: Double;
                        strForm20,
                        strIteC20: String;
                        fltQtdb20: Double;
                        strCodDig,
                        strCodAca,
                        strEmpAca: String;
                        fltUnitar,
                        fltTotIte: Double;
                        strLinha: String;
                        strCatali: String;
                        strCodDil: String;
                        fltPorDil: Double;
                        strDilCon: String;
                        fltPorCat: Double;
                        intModDil: Integer;
                        strTexBas,
                        strTipCor,
                        strIteCob,
                        strUniver: String;
                        blnBaixad: Boolean;
                        fltFatAce: Double;
                        strCatal_: String;
                        blnTinAut: Boolean;
                        strObsCol: String = '';
                        intTipFor: Integer = 0;
                        strAutIncTinDor : String = ''): Boolean;

  function fGravaTinGor(var strAutInc: String;
                        strCodEmp,
                        strCodVen,
                        strNumDoc,
                        strEspDoc: String;
                        dtaDtaEnt,
                        dtaHorEnt: TDateTime;
                        strConPag,
                        strCodCli,
                        strEstado,
                        strNomCon,
                        strEndCon,
                        strBaiCon,
                        strCepCon,
                        strCidCon,
                        strEstCon,
                        strTelCon: String;
                        intCgcCpf: Integer;
                        strCgcCon,
                        strIesCon,
                        strCli_Rg,
                        strJaProd,
                        strMenFor: String): Boolean;

procedure fGravaGORCND(strAutInc: String; arrDuplic: TarrDuplicata );
procedure fGravaDAVCND(strAutInc: String; arrDuplic: TarrDuplicata );
procedure fAlteraROMCND(strNumDoc, strEspDoc, strCodCli, strCodEmp: String; arrDuplic: TarrDuplicata );

function fSelecionaStatusSepImp(strNumOrc, strEspOrc, strCodEmp: String): String;

procedure pGravaDavPVG(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCgcCon,
  strNomCon, strEndCon, strEstado, strCodFpg, strCodCnd, strCodPor, strBaiCon,
  strCidCon, strTelCon: String;
  fltTotPro, fltDesEsp, fltTotRet, fltTotSer, fltTotFre, fltTotIpi, fltVlrCon,
  fltVPar01, fltVPar02, fltVPar03, fltVPar04, fltVPar05, fltVPar06,
  fltVPar07, fltVPar08, fltVPar09, fltVPar10, fltVPar11, fltVPar12: Double;
  arrDuplic: TarrDuplicata);

procedure pGravaDavPVD(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte, strDescri: String;
  fltQtdIte, fltUnitar, fltTotIte, fltDesEsp: Double; strCodUni, strCodFis: String;
  fltAlqIcm: Double; strCodAca, strEmpAca, strIteEmb, strNumLot: String;
  intSeqInd: Integer);

procedure pApagaDavPVG(strNumDoc, strEspDoc, strCodEmp: String);

procedure pAtualizaDadosConsumidor(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCgcCon,
  strNomCon, strEndCon, strBaiCon, strCepCon, strCidCon, strEstCon, strTelCon,
  strCgcCpf, strIesCon, strCli_Rg, strEmlCon, strCodAti: String; dtaNasCon: TDate);

procedure pAtualizaPedidoTransferencia(strNumDoc, strCodEmp: String);
function fItensConferidosNaoFaturados(strAutInc : String): Boolean;
function fValidouLimpaExpedicaoPedido(var blnExcluirExtLar: Boolean; const strAutInc : String; const blnFatAut: Boolean = False; const opcExcluirExtLar: TExcluirExtLarOpcoes = eeloPerguntar): Boolean;
function fLimpaExpedicaoPedido(strAutInc : String; blnFatAut: Boolean = False; opcExcluirExtLar: TExcluirExtLarOpcoes = eeloPerguntar; blnLimpaLotDor: Boolean = True;
  ASeqsFDO: String = '') : Boolean;
function fGerarTLItensSeparadosLocTransitoriaVAGAO(const ASeqGer: String): Boolean;
procedure pGravarLogLpv(strCodOpe, strNumDoc, strEspDoc, strCodEmp, strCodCli: String);
procedure pLiberarPedidoDiretoParaConferencia(strNumDoc, strEspDoc, strEmpDoc: String; blnAtualizarSomenteItens: Boolean = False);
procedure pLimpaExtLar(const AIncFatGor: string);

procedure pGravaExpRet(strAutoinc, strCodSep:String; dtaSepIni, horSepIni, dtaSepFin, horSepFin: TDateTime );
procedure pRegravarExpRet(strAutoinc:String; cdsExpRet: TUniClientDataSet);

procedure pGravaStatusDEPS(cdsGen: TDataset);
function fBaixarPedOrcNaoEntregue(strNumDoc, strEspDoc, strCodEmp: String;
  bolExecutandoPeloCRM : Boolean = False; strNomeForm: String = ''): Boolean;

function fTemFatDorSemExtDor(ANumeroDocumento, AEspecieDocumento, ACodigoEmpresa : string; var AMensagem : string) : Boolean;
procedure pNotificaRobo(strNumeroDocumento, strEspecie, strCodigoEmpresa : String);

function fPedidoBaixadoTotalmente(strNumDoc, strEspDoc, strCodEmp: String): Boolean;

procedure pBaixaSeparacaoDosItens(const strEspDoc, strIncGer, strOpeBai: string);

function fRetRotasPorPedido(strNumDoc, strEspDoc, strCodEmp: string): string;
function fRetRegioesPorPedido(strNumDoc, strEspDoc, strCodEmp: string): string;
function fPedidoUtiPen(const strNumdoc, strEspDoc, strCodEmp: String): Boolean;

function fEhPedidoOriginadoPelaConsignacao(const AstrNumero, AstrEspecie, AstrCodigoEmpresa : String): Boolean;

function fRetQtdPedidosEntFutCD(strCodEmp: String): Integer;

function fPedidoGeraPedencia(strAutInc: string): Boolean;

function fTipoOperacao(strNumDoc, strEspDoc, strCodEmp: String): String;

function fGravaBoletoExtGor(strAutInc: string; fltValBol: Double): Boolean;

procedure pLimpaNseDor(strSeqFdo: String);
function fGravaNseDor(strSeqFdo, strNumSer: String; fltQtdSer: Double): Boolean;

function fGetSqlProdControlado(stlPedidos: TStringList): String;

function fVerificaExisteItemProdutoTransferenciaNaoFaturadas(const strCodEmp,
  strCodCli, strCodIte: String): Boolean;

procedure pVerificaIntegridadeLOTDOR(strSeqGer: String);

procedure pApagaDelLotDor(strSeqGer: String);

procedure pAtualizaTotalItensFatGor(strNumDoc, strEspDoc, strCodEmp: String);

function fRetornaValorTotalItensFatDor(strNumDoc, strEspDoc, strCodEmp: String): Double;

procedure pGravaFreFat(const strNumDoc,
                             strEspDoc,
                             strCodEmp,
                             strCodCli,
                             strCodVen,
                             strCodTra,
                             strPlaVei,
                             strCidOri,
                             strCidDes,
                             strTipApi : String;
                       const fltDistan,
                             fltVlrPed,
                             fltVlrCmb,
                             fltTotFre : Double;
                             intCodTab: Integer;
                             strCotId_: String;
                             strAutIncEndPartida: String;
                             intDiasEnt: Integer);

  procedure pGravarCobrancaEletronica(const ATipRec, strNumDoc,
    strEspDoc: String);
  procedure pCancelaCobrancaEletronica(const ATipRec, strNumDoc,
    strEspDoc: String);

  function fExisteItemPD_OR(strNumDoc, strEspDoc, strEmpDoc, strCodIte, strSeqInc : String): Boolean;
  function fPedidoPossuiSomenteItensEntregaFutura(strNumDoc, strEspDoc, strCodEmp: String): Boolean;

  procedure pAtualizaBaixaSepExtDor(ADtBxSe, AHrBxSe: TDateTime; ANumDoc, AEspDoc, ACodCli, ACodEmp, AOpBxSe: String);

  function fPedidoEmOndaSeparacao(const strAutInc: String): Boolean;

  function fExisteDocumentoContaOrdemComRemessaNaoFaturada(
    const strAutInc: String): Boolean; overload;
  function fExisteDocumentoContaOrdemComRemessaNaoFaturada(
    const strNumDoc, strEspDoc, strCodEmp: String): Boolean; overload;
  function fEhDocumentoContaOrdemComRemessa(const strNumDoc,
    strEspDoc: String): Boolean;

  function fExisteDocumentoContaOrdemComRemessaNaoEmitidaNF(
    const strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  function fExisteDocumentoRemessaContaOrdemNaoCancelado(const strNumDoc,
    strEspDoc: String): Boolean;
  function fPermiteCancelarDocumentosContaOrdemRemessaContaOrdem(
    const strNumDoc, strEspDoc: String; var objPedidoVinculado: TPedidoVenda;
    var LNumDocRemessa, LEspDocRemessa, LCodEmpRemessa, LCodCliRemessa,
    LMen001Remessa: String): Boolean;
  function fPermiteBaixarDocumentosContaOrdemRemessaContaOrdem(
    const strNumDoc, strEspDoc: String; var LNumDocRemessa, LEspDocRemessa,
    LCodEmpRemessa: String): Boolean;
  function fValidaTipoDocumentoRemessaEmitida(const strNumDoc, strEspDoc,
    strCodEmp, strEspDocSelecionado: String): Boolean;

  function fEhPedidoAbastecimentoDeposito(strNumDoc, strEspDoc, strCodEmp: String):Boolean;

  function fEhPedidoComProducaoForaLoja(const strNumDoc, strEspDoc,
    strCodEmp: String): Boolean;
  procedure pAtualizaQtdExpItemPedido(strAutIncIte: String; fltQtdExp: Double; blnAtualizaOperadores: Boolean=False;
    strCodCon: String=''; strCodSep: String=''; strObsExp: String=''; strEmbExp: String='');
  function fPedidoExpedido(strAutGor: String; blnNaoVerificaRetiraBalcao: Boolean = False; blnNaoVerificaRetiraCaixa: Boolean = False; strEmpIte: String = ''): Boolean; overload;
  function fPedidoExpedido(objPedido: TPedidoVenda): Boolean; overload;
  function fPedidoFoiExpedido(strNumDoc, strCodEmp, strCodCli: String; blnConsiderarPedidoSohComServicoComoExpedido: Boolean=True;
    blnNaoVerificaRetiraBalcao: Boolean = False; blnNaoVerificaRetiraCaixa: Boolean = False; strEmpIte: String = '';
    blnConsiderarParcialmenteExp: Boolean = False): Boolean;
  function fAtualizaQtdExpedida(const strCodSep, strCodCon, strEmExp, strObsExp, strAutIncMovDet : String; fltQtdExp: Double): Boolean;
  function fAtualizaTipBus(const strDetInc, strTipBus: String): Boolean;
  function fSelectFromFatgorLeftAuxiliares(const blnJoinRomaneio: Boolean): String;
  function fRetornaUltimoSeqInd(const strNumDoc, strEspDoc, strCodEmp: String): Integer;
  procedure pDeletaSepDor(AAutInc: String);

Var
  intSeqFdo: Integer;
  objReprocessarSaldoItens: IReprocessarSaldoItem;

implementation

uses untConstantes,untModulo,untFinanceira, untAtualizaOcorrenciasCRM, untFuncoesAutocenter,
     untFuncoes, untAutcomDllTinta, untHashDavPvG,
     untMovFlex, untNetpoints, untDuplicatas, untLogGor, untCadPro,
     untTSituacaoPedidoVenda, untTypesCRM, System.Math, untTSaldoReservadoPedido,
     untIFatReservaSaldo, untTFatReservaSaldo,
     untValidacoesSistemaDEPS, untLiberacao, untFuncoesGenerica, untMsgLiberacao,
     untFuncoesCRM, untFuncFat, untAdiantamentoClienteGenerico,
     untProjetos, untFatAltQtdeItensPedido, untMovRcd, untSeparacaoFina, untAdiantamentoCliente,
     untFatBaixarPedOrcNaoEntregue, untAlpe, CobrancaEletronica.Lib.Facade,
     CobrancaEletronica.Lib.Types;

procedure pAtualizaDuplicataBolAdt(strNumDupDC, strEspDocDC, strCodEmpDC, strCodCliDC : String);
var
  qryAtualizaAdtBol : TUniQuery;
  strSQL : String;
begin
  qryAtualizaAdtBol := fCriaQuery(nil);

  strSQL := ' UPDATE '+
            '   EXTGOR INNER JOIN FATGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM '+
            ' SET '+
            '   FGO_BOLADT = 0.00, '+
            '   FGO_BOLVEN = "N" '+
            ' WHERE FGO_NUMDOC = :NUMDOC '+
            '   AND FGO_ESPDOC = :ESPDOC '+
            '   AND FGO_CODEMP = :CODEMP '+
            '   AND FGO_CODCLI = :CODCLI ';

  try
    qryAtualizaAdtBol.Close;
    qryAtualizaAdtBol.SQL.Clear;
    qryAtualizaAdtBol.SQL.Text := strSQL;

    qryAtualizaAdtBol.ParamByName('NUMDOC').AsString := strNumDupDC;
    qryAtualizaAdtBol.ParamByName('ESPDOC').AsString := strEspDocDC;
    qryAtualizaAdtBol.ParamByName('CODEMP').AsString := strCodEmpDC;
    qryAtualizaAdtBol.ParamByName('CODCLI').AsString := strCodCliDC;

    qryAtualizaAdtBol.ExecSQL;
  finally
    FreeAndNil(qryAtualizaAdtBol);
  end;
end;

function fPedidoBaixadoTotalmente(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
  Var
    qryVerCondicoes: TUniQuery;

Begin

  qryVerCondicoes := fCriaQuery;

  Try
    qryVerCondicoes.Close;
    qryVerCondicoes.SQL.Text := 'SELECT                                                     '+
                                '  COUNT(*) AS QTDREG                                       '+
                                'FROM                                                       '+
                                '  FATDOR                                                   '+
                                'WHERE FDO_NUMDOC = :NUMDOC                                 '+
                                '  AND FDO_ESPDOC = :ESPDOC                                 '+
                                '  AND FDO_CODEMP = :CODEMP                                 '+
                                '  AND ( ROUND(FDO_QTDITE, 2) - ROUND(FDO_QTDBAI, 2)) > 0 ; ';

    qryVerCondicoes.ParamByName('NUMDOC').asString := strNumDoc;
    qryVerCondicoes.ParamByName('ESPDOC').asString := strEspDoc;
    qryVerCondicoes.ParamByName('CODEMP').asString := strCodEmp;

    qryVerCondicoes.Open;

    Result := ( qryVerCondicoes.FieldByName('QTDREG').asInteger = 0 );

  Finally
    FreeAndNil(qryVerCondicoes);
  End;

End;

procedure pBaixaSeparacaoDosItens(const strEspDoc, strIncGer, strOpeBai: string);
  var
    qryUpd : TUniQuery;
begin
  if fEmptyStr(strEspDoc) then
    Exit;

  if fEmptyStr(strIncGer) then
    Exit;

  qryUpd := fCriaQuery;
  try
    if (strEspDoc = 'PD') then
    begin
      qryUpd.SQL.Text := ' UPDATE FATDOR, EXTDOR ' +
                         '    SET FDO_OPBXSE = :OPBXSE,           ' +
                         '        FDO_DTBXSE = :DTBXSE,           ' +
                         '        FDO_HRBXSE = :HRBXSE,           ' +
                         '        FDO_QTDSEP = FDO_QTDITE         ' +
                         '  WHERE FATDOR.FDO_SEQGER = :INCGER     ' +
                         '    AND EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ' ;
    end
    else
    begin
      qryUpd.SQL.Text := ' UPDATE MOVDET, MOVTRI ' +
                         '    SET DET_OPBXSE = :OPBXSE,           ' +
                         '        DET_DTBXSE = :DTBXSE,           ' +
                         '        DET_HRBXSE = :HRBXSE,           ' +
                         '        DET_QTDSEP = DET_QTDITE         ' +
                         '  WHERE MOVDET.DET_SEQGER = :INCGER     ' +
                         '    AND MOVTRI.DET_SEQGER = MOVDET.AUTOINCREM ' ;
    end;

    qryUpd.ParamByName('OPBXSE').AsString := strOpeBai;
    qryUpd.ParamByName('DTBXSE').AsDateTime := VS_Date;
    qryUpd.ParamByName('HRBXSE').AsDateTime := fRetHoraServidor;
    qryUpd.ParamByName('INCGER').AsString := strIncGer;
    qryUpd.ExecSQL;
  finally
    FreeAndNil(qryUpd);
  end;
end;

procedure pIncluiAutEnt(strAutInc,
                        strAutEnt,
                        strMen003,
                        strMen004,
                        strMen005: String;
                        strEntFutOpc: String = '';
                        fltVolSepExc: Double = 0;
                        fltVolSepNExc: Double = 0);
  Var
    qryAuxGer: TUniQuery;
Begin

  Try
    qryAuxGer := fCriaQuery(Nil);

    With qryAuxGer, SQL Do
    Begin
      Add('SELECT * FROM AUXGOR');
      Add('WHERE FALSE');

      Open;
      qryAuxGer.Insert;

      FieldByName('AUX_SEQGER').AsString := strAutInc;
      If Not fEmptyStr(strAutEnt) Then
        FieldByName('AUX_ENTGER').AsString := strAutEnt;
      FieldByName('AUX_MEN003').AsString := strMen003;
      FieldByName('AUX_MEN004').AsString := strMen004;
      FieldByName('AUX_MEN005').AsString := strMen005;
      If Not fEmptyStr(strEntFutOpc) Then
        FieldByName('AUX_ENFUOP').AsString := strEntFutOpc;
      FieldByName('AUX_VOLEXS').AsFloat := fltVolSepExc;
      FieldByName('AUX_VOLEXN').AsFloat := fltVolSepNExc;

      Post;

    End;

  Finally
    FreeAndNil(qryAuxGer);
  End;

End;

Function fAtualizaQtdRom(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte,
  strAutIncAnt, strAutIncAtu: String; fltQtdIte: Double): Boolean;
  Var
    qryUpd: TUniQuery;
begin
  If (fCfgSis('USPRRO', varBoolean)) Then
  Begin
    qryUpd := fCriaQuery(Nil);

    With qryUpd Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE ROMDETX              ');
      SQL.Add('SET    DET_AUTINC = :INCATU,');
      SQL.Add('       DET_QTDITE = :QTDITE,');
      SQL.Add('       DET_QTDBAI = IF((:QTDITE - DET_QTDBAI) >= 0, DET_QTDBAI, :QTDITE) ');
      SQL.Add('WHERE  DET_NUMDOC = :NUMDOC ');
      SQL.Add('AND    DET_ESPDOC = :ESPDOC ');
      SQL.Add('AND    DET_CODEMP = :CODEMP ');
      SQL.Add('AND    DET_CODCLI = :CODCLI ');
      SQL.Add('AND    DET_CODITE = :CODITE ');
      SQL.Add('AND    DET_AUTINC = :INCANT ');

      ParamByName('QTDITE').AsFloat  := fltQtdIte;
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('INCATU').AsString := strAutIncAtu;
      ParamByName('INCANT').AsString := strAutIncAnt;

      ExecSQL;

      Close;
      SQL.Clear;
      SQL.Add('UPDATE FATDOR SET FDO_QTDROM = :QTDROM WHERE AUTOINCREM = :AUTINC');

      ParamByName('AUTINC').AsString := strAutIncAtu;
      ParamByName('QTDROM').AsFloat  := fRetQtdRom(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte, strAutIncAtu);

      ExecSQL;
    End;

    FreeAndNil(qryUpd);
  End;

  Result := True;
end;

Function fRetQtdRom(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte, strAutInc: String): Double;
  Var
    qryAux: TUniQuery;
Begin
  Try
    qryAux := fCriaQuery(Nil);

    With qryAux Do
    Begin
      SQL.Clear;
      SQL.Add('SELECT DET_QTDBAI           ');
      SQL.Add('FROM   ROMDETX              ');
      SQL.Add('WHERE  DET_NUMDOC = :NUMDOC ');
      SQL.Add('AND    DET_ESPDOC = :ESPDOC ');
      SQL.Add('AND    DET_CODEMP = :CODEMP ');
      SQL.Add('AND    DET_CODCLI = :CODCLI ');
      SQL.Add('AND    DET_CODITE = :CODITE ');
      SQL.Add('AND    DET_AUTINC = :AUTINC ');

      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('AUTINC').AsString := strAutInc;

      Open;

      If IsEmpty Then
        Result := 0.00
      Else
        Result := FieldByName('DET_QTDBAI').AsFloat;
    End;

  Finally
    FreeAndNil(qryAux);
  End;
End;

procedure pGravaSimulacaoCondPagtoPedido(strAutInc, strCodCnd: String; fltTotCnd: Double);
  Var
    qryAuxGer: TUniQuery;
Begin

  Try
    qryAuxGer := fCriaQuery(Nil);

    With qryAuxGer, SQL Do
    Begin
      Add('SELECT * FROM FGOCND');
      Add('WHERE FALSE');

      Open;
      qryAuxGer.Insert;

      FieldByName('FGO_SEQGER').AsString := strAutInc;
      FieldByName('FGO_CODCND').AsString := strCodCnd;
      FieldByName('FGO_TOTCND').AsFloat  := fltTotCnd;

      Post;

    End;

  Finally
    FreeAndNil(qryAuxGer);
  End;

End;

function fEMPEXP(strCodEmp,
                   strEmpFor,
                   strEmp_Te,
                   strEnt_CD,
                   strEmp_CD,
                   strAbaDep,
                   strRegEs2 : String;
                   blnConEqu: Boolean;
                   strMen001 : String) : String;
begin

  if Pos('PEDIDO DE RESERVA DE ESTOQUE',  AnsiUpperCase(strMen001)) > 0 then
    Exit('');

  If (fCfgSis('UTIRE2', varString, strCodEmp) = 'S') Then
  Begin

    If (strRegEs2 = 'S') And (Not fEmptyStr(strEmp_CD)) Then
      Result := strEmp_CD
    Else
      Result := strCodEmp;

  End
  Else
  If (fCfgSis('ABADEP', varString, strCodEmp) = 'S') And (strAbaDep = 'S') Then
  Begin

    If (Not fEmptyStr(strEmp_CD)) Then
      Result := strEmp_CD
    Else
      Result := strCodEmp;

  End
  Else
  If (fCfgSis('ENT_CD', varString, strCodEmp) = 'S') Then
  Begin

    If (strEnt_CD = 'S') And (Not fEmptyStr(strEmp_CD)) Then
      Result := strEmp_CD
    Else If (Not fEmptyStr(strEmp_Te)) Then
      Result := strEmp_Te
    Else If (fCfgSis('CEATMN', varString, strCodEmp) = '2') And (Not fEmptyStr(strEmpFor)) Then
      Result := strEmpFor
    Else
      Result := strCodEmp;

  End
  Else
  Begin
    If blnConEqu And (strEnt_CD = 'S') And (Not fEmptyStr(strEmp_CD)) Then
      Result := strEmp_CD
    Else If Not fEmptyStr(strEmp_Te) Then
      Result := strEmp_Te
    Else If (fCfgSis('CEATMN', varString, strCodEmp) = '2') And (Not fEmptyStr(strEmpFor)) Then
      Result := strEmpFor
    Else
      Result := strCodEmp;

  End;

end;

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
                        fltFreMkp: Double = 0;
                        fltComMkp: Double = 0;
                        blnDevWms: Boolean = False;
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
                        blnLOC_PD: Boolean = False;
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
                        ATxIdPix   : String = '';
                        AEmpresaPix: String = '';
                        blnColeta  : Boolean = False;
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
                        strCliCEO : String = '';
                        strEmpFatSemSaldo: String = '';
                        fltVolSepExc: Double = 0;
                        fltVolSepNExc: Double = 0;
                        strEmpExpPrioridadeEstoque: String = '';
                        strCliTop : String = '';
                        strAutRco : String = '';
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

  const
    POS_TRAVA_COM_PEDIDO      = 9;
    POS_TRAVA_COM_BONIFICACAO = 11;

  Var
    qryTblRtm  : TUniQuery;
    qryFatGor  : TUniQuery;
    qryExtGor  : TUniQuery;
    qrySerGor  : TUniQuery;
    qryRomGer  : TUniQuery;
    qryInvoic  : TUniQuery;
    intServico : Integer;
    objServicos: TClassDadosServicos;
    recDadosRot: TDadosRota;
    intField   : Integer;
    strEmpExp  : String;
    strUsaDeps : String;
    strSQL     : String;

  procedure pAtualizaOrigemDocumento;
  var
    OrigemFaturamento: TOrigemFaturamento;
  begin
    OrigemFaturamento := TOrigemFaturamento.GetOrigemDocumento(strNumDoc, strEspDoc, strCodEmp);
    if not OrigemFaturamento.IsValid then
      TOrigemFaturamento.AtualizarOrigemDocumento(strNumDoc,strEspDoc, strCodEmp, OrigemFaturamento);
  end;

Begin
  Try
    Try
      Result := True;

      TLogGor.pLimpar;
      TLogGor.strNumDoc := strNumDoc;
      TLogGor.strEspDoc := strEspDoc;
      TLogGor.strCodEmp := strCodEmp;

      objServicos := TClassDadosServicos.Create(recServicos);

      strSQL := '';
      strSQL := strSQL + 'INSERT INTO   ';
      strSQL := strSQL + '  EXTGOR      ';
      strSQL := strSQL + '(             ';
      strSQL := strSQL + '  FGO_SEQFGO, ';
      strSQL := strSQL + '  FGO_NASCON, ';
      strSQL := strSQL + '  FGO_CODATI, ';
      strSQL := strSQL + '  FGO_EMP_TE, ';
      strSQL := strSQL + '  FGO_EMP_CD, ';
      strSQL := strSQL + '  FGO_DTAIMP, ';
      strSQL := strSQL + '  FGO_HORIMP, ';
      strSQL := strSQL + '  FGO_HORFIN, ';
      strSQL := strSQL + '  FGO_INDCOM, ';
      strSQL := strSQL + '  FGO_GERPEN, ';
      strSQL := strSQL + '  FGO_DTATRA, ';
      strSQL := strSQL + '  FGO_HORTRA, ';
      strSQL := strSQL + '  FGO_FRESUG, ';
      strSQL := strSQL + '  FGO_FRERAT, ';
      strSQL := strSQL + '  FGO_TAXENT, ';
      strSQL := strSQL + '  FGO_CODFAZ, ';
      strSQL := strSQL + '  FGO_ENVLIB, ';
      strSQL := strSQL + '  FGO_CODCAR, ';
      strSQL := strSQL + '  FGO_QTDPAC, ';
      strSQL := strSQL + '  FGO_ENTURG, ';
      strSQL := strSQL + '  FGO_PD_EXP, ';
      strSQL := strSQL + '  FGO_CORTE_, ';
      strSQL := strSQL + '  FGO_PTNFMN, ';
      strSQL := strSQL + '  FGO_CODPOR, ';
      strSQL := strSQL + '  FGO_NUMGUI, ';
      strSQL := strSQL + '  FGO_ORCORI, ';
      strSQL := strSQL + '  FGO_CODTPA, ';
      strSQL := strSQL + '  FGO_PLAVEI, ';
      strSQL := strSQL + '  FGO_KM_VEI, ';
      strSQL := strSQL + '  FGO_RELABA, ';
      strSQL := strSQL + '  FGO_ALTERA, ';
      strSQL := strSQL + '  FGO_DTIMSE, ';
      strSQL := strSQL + '  FGO_HRIMSE, ';
      strSQL := strSQL + '  FGO_BASISS, ';
      strSQL := strSQL + '  FGO_REDISS, ';
      strSQL := strSQL + '  FGO_DEDISS, ';
      strSQL := strSQL + '  FGO_NPDROR, ';
      strSQL := strSQL + '  FGO_EPDROR, ';
      strSQL := strSQL + '  FGO_LATITU, ';
      strSQL := strSQL + '  FGO_LONGIT, ';
      strSQL := strSQL + '  FGO_RAIO__, ';
      strSQL := strSQL + '  FGO_TFTNES, ';
      strSQL := strSQL + '  FGO_FASOBR, ';
      strSQL := strSQL + '  FGO_NMPDAB, ';
      strSQL := strSQL + '  FGO_ESPDAB, ';
      strSQL := strSQL + '  FGO_VENPRE, ';
      strSQL := strSQL + '  FGO_TEMBRI, ';
      strSQL := strSQL + '  FGO_EDIPES, ';
      strSQL := strSQL + '  FGO_CODSUP, ';
      strSQL := strSQL + '  FGO_ORCESP, ';
      strSQL := strSQL + '  FGO_EMPDAB, ';
      strSQL := strSQL + '  FGO_CODOCO, ';
      strSQL := strSQL + '  FGO_CODEMB, ';
      strSQL := strSQL + '  FGO_CONSUM, ';
      strSQL := strSQL + '  FGO_BARCOM, ';
      strSQL := strSQL + '  FGO_DESOPE, ';
      strSQL := strSQL + '  FGO_INRQCP, ';
      strSQL := strSQL + '  FGO_PROSPE, ';
      strSQL := strSQL + '  FGO_CODROT, ';
      strSQL := strSQL + '  FGO_TOTBRI, ';
      strSQL := strSQL + '  FGO_BOLADT, ';
      strSQL := strSQL + '  FGO_BOLVEN, ';
      strSQL := strSQL + '  FGO_TAXJUR, ';
      strSQL := strSQL + '  FGO_FATTOT, ';
      strSQL := strSQL + '  FGO_VALORC, ';
      strSQL := strSQL + '  FGO_TRARDP, ';
      strSQL := strSQL + '  FGO_CLILOJ, ';
      strSQL := strSQL + '  FGO_SEQDMP, ';
      strSQL := strSQL + '  FGO_DTFICO, ';
      strSQL := strSQL + '  FGO_DTINCO, ';
      strSQL := strSQL + '  FGO_DTINSE, ';
      strSQL := strSQL + '  FGO_DTBXSE, ';
      strSQL := strSQL + '  FGO_HRFICO, ';
      strSQL := strSQL + '  FGO_HRINCO, ';
      strSQL := strSQL + '  FGO_HRINSE, ';
      strSQL := strSQL + '  FGO_HRBXSE, ';
      strSQL := strSQL + '  FGO_USAQUE, ';
      strSQL := strSQL + '  FGO_DOCQUE, ';
      strSQL := strSQL + '  FGO_TPOPER, ';
      strSQL := strSQL + '  FGO_CODPRJ, ';
      strSQL := strSQL + '  FGO_EMPEXP, ';
      strSQL := strSQL + '  FGO_DTCTVN, ';
      strSQL := strSQL + '  FGO_VLCTVN, ';
      strSQL := strSQL + '  FGO_NLEADS, ';
      strSQL := strSQL + '  FGO_CUPDES, ';
      strSQL := strSQL + '  FGO_NOTPAU, ';
      strSQL := strSQL + '  FGO_USADEP, ';
      strSQL := strSQL + '  FGO_STSDEP, ';
      strSQL := strSQL + '  FGO_CODCAT, ';
      strSQL := strSQL + '  FGO_DEVWMS, ';
      strSQL := strSQL + '  FGO_FREMKP, ';
      strSQL := strSQL + '  FGO_COMMKP, ';
      strSQL := strSQL + '  FGO_HISCOM, ';
      strSQL := strSQL + '  FGO_CODEVE, ';
      strSQL := strSQL + '  FGO_DH_IMP, ';
      strSQL := strSQL + '  FGO_OPBXSE, ';
      strSQL := strSQL + '  FGO_ENVCON, ';
      strSQL := strSQL + '  FGO_TIPREC, ';
      strSQL := strSQL + '  FGO_TX_PIX, ';
      strSQL := strSQL + '  FGO_EMPPIX, ';
      strSQL := strSQL + '  FGO_ABADEP, ';
      strSQL := strSQL + '  FGO_NUMORI, ';
      strSQL := strSQL + '  FGO_ESPORI, ';
      strSQL := strSQL + '  FGO_EMPORI, ';
      strSQL := strSQL + '  FGO_LOC_PD, ';
      strSQL := strSQL + '  FGO_COLETA, ';

      If (Not fEmptyStr(strObsExp)) Then
        strSQL := strSQL + '  FGO_OBSEXP, ';

      If (Not fEmptyStr(strOpeExp)) Then
        strSQL := strSQL + '  FGO_OPEEXP, ';

      strSQL := strSQL + '  FGO_EMPEPE, ';
      {Concreto}
      strSQL := strSQL + '  FGO_CCRPLA, ';
      strSQL := strSQL + '  FGO_CCRMOT, ';
      strSQL := strSQL + '  FGO_CCRBET, ';
      strSQL := strSQL + '  FGO_CCRLAC, ';
      strSQL := strSQL + '  FGO_CCR_CB, ';
      strSQL := strSQL + '  FGO_CCRFCK, ';
      strSQL := strSQL + '  FGO_CCRABA, ';
      strSQL := strSQL + '  FGO_CCRTIP, ';
      strSQL := strSQL + '  FGO_CCRBRI, ';
      strSQL := strSQL + '  FGO_CCR_ML, ';
      strSQL := strSQL + '  FGO_CCRQTD, ';
      strSQL := strSQL + '  FGO_CCRVLR, ';
      strSQL := strSQL + '  FGO_CCRTOT, ';
      strSQL := strSQL + '  FGO_CCROBR, ';
      strSQL := strSQL + '  FGO_CCRART, ';
      strSQL := strSQL + '  FGO_CODCNO, ';
      strSQL := strSQL + '  FGO_INSIMO, ';
      strSQL := strSQL + '  FGO_CODCIB, ';
      strSQL := strSQL + '  FGO_NUMDRW, ';
      strSQL := strSQL + '  FGO_VALCRE, ';
      strSQL := strSQL + '  FGO_UPSEML, ';
      strSQL := strSQL + '  FGO_DTLBEX, ';
      strSQL := strSQL + '  FGO_HRLBEX, ';
      strSQL := strSQL + '  FGO_FRECOT, ';
      strSQL := strSQL + '  FGO_REGES2, ';

      strSQL := strSQL + '  FGO_CILVAS, ';
      strSQL := strSQL + '  FGO_AUTICV, ';
      strSQL := strSQL + '  FGO_CDCOPO, ';
      strSQL := strSQL + '  FGO_CDCSTA, ';
      strSQL := strSQL + '  FGO_FORUCO, ';
      strSQL := strSQL + '  FGO_CTAUCO, ';
      strSQL := strSQL + '  FGO_HISUCO, ';
      strSQL := strSQL + '  FGO_EVEUCO, ';
      strSQL := strSQL + '  FGO_DESREN, ';
      strSQL := strSQL + '  FGO_REGDES, ';
      strSQL := strSQL + '  FGO_CLICEO, ';
      strSQL := strSQL + '  FGO_FATSSA, ';
      strSQL := strSQL + '  FGO_CLITOP, ';
      strSQL := strSQL + '  FGO_SUPGER, ';
      strSQL := strSQL + '  FGO_SUPREG, ';
      strSQL := strSQL + '  FGO_AUTRCO, ';
      strSQL := strSQL + '  FGO_FATSER, ';
      strSQL := strSQL + '  FGO_CANFAT, ';
      strSQL := strSQL + '  FGO_INTFUS, ';
      strSQL := strSQL + '  FGO_SEQSEP, ';
      strSQL := strSQL + '  FGO_SEQOND, ';
      strSQL := strSQL + '  FGO_ONDAOP, ';
      strSQL := strSQL + '  FGO_ONDADT, ';
      strSQL := strSQL + '  FGO_ONDAHR, ';
      strSQL := strSQL + '  FGO_PERDAD, ';
      strSQL := strSQL + '  FGO_DECZFM, ';
      strSQL := strSQL + '  FGO_CELCON, ';
      strSQL := strSQL + '  FGO_UTIAAC, ';
      strSQL := strSQL + '  FGO_ACPCAR, ';
      strSQL := strSQL + '  FGO_ACPCOM, ';
      strSQL := strSQL + '  FGO_SEPANT, ';
      strSQL := strSQL + '  FGO_DTSANT, ';
      strSQL := strSQL + '  FGO_HRSANT, ';
      strSQL := strSQL + '  FGO_COTLAL, ';
      strSQL := strSQL + '  FGO_TOTCBS, ';
      strSQL := strSQL + '  FGO_TOTIBS, ';
      strSQL := strSQL + '  FGO_TOT_IS, ';
      strSQL := strSQL + '  FGO_VCHCDP) ';

      strSQL := strSQL + 'VALUES (      ';
      strSQL := strSQL + '  :SEQFGO,    ';
      strSQL := strSQL + '  :NASCON,    ';
      strSQL := strSQL + '  :CODATI,    ';
      strSQL := strSQL + '  :EMP_TE,    ';
      strSQL := strSQL + '  :EMP_CD,    ';
      strSQL := strSQL + '  :DTAIMP,    ';
      strSQL := strSQL + '  :HORIMP,    ';
      strSQL := strSQL + '  :HORFIN,    ';
      strSQL := strSQL + '  :INDCOM,    ';
      strSQL := strSQL + '  :GERPEN,    ';
      strSQL := strSQL + '  :DTATRA,    ';
      strSQL := strSQL + '  :HORTRA,    ';
      strSQL := strSQL + '  :FRESUG,    ';
      strSQL := strSQL + '  :FRERAT,    ';
      strSQL := strSQL + '  :TAXENT,    ';
      strSQL := strSQL + '  :CODFAZ,    ';
      strSQL := strSQL + '  :ENVLIB,    ';
      strSQL := strSQL + '  :CODCAR,    ';
      strSQL := strSQL + '  :QTDPAC,    ';
      strSQL := strSQL + '  :ENTURG,    ';
      strSQL := strSQL + '  :PD_EXP,    ';
      strSQL := strSQL + '  :CORTE_,    ';
      strSQL := strSQL + '  :PTNFMN,    ';
      strSQL := strSQL + '  :CODPOR,    ';
      strSQL := strSQL + '  :NUMGUI,    ';
      strSQL := strSQL + '  :ORCORI,    ';
      strSQL := strSQL + '  :CODTPA,    ';
      strSQL := strSQL + '  :PLAVEI,    ';
      strSQL := strSQL + '  :KM_VEI,    ';
      strSQL := strSQL + '  :RELABA,    ';
      strSQL := strSQL + '  :ALTERA,    ';
      strSQL := strSQL + '  :DTIMSE,    ';
      strSQL := strSQL + '  :HRIMSE,    ';
      strSQL := strSQL + '  :BASISS,    ';
      strSQL := strSQL + '  :REDISS,    ';
      strSQL := strSQL + '  :DEDISS,    ';
      strSQL := strSQL + '  :NPDROR,    ';
      strSQL := strSQL + '  :EPDROR,    ';
      strSQL := strSQL + '  :LATITU,    ';
      strSQL := strSQL + '  :LONGIT,    ';
      strSQL := strSQL + '  :RAIO__,    ';
      strSQL := strSQL + '  :TFTNES,    ';
      strSQL := strSQL + '  :FASOBR,    ';
      strSQL := strSQL + '  :NMPDAB,    ';
      strSQL := strSQL + '  :ESPDAB,    ';
      strSQL := strSQL + '  :VENPRE,    ';
      strSQL := strSQL + '  :TEMBRI,    ';
      strSQL := strSQL + '  :EDIPES,    ';
      strSQL := strSQL + '  :CODSUP,    ';
      strSQL := strSQL + '  :ORCESP,    ';
      strSQL := strSQL + '  :EMPDAB,    ';
      strSQL := strSQL + '  :CODOCO,    ';
      strSQL := strSQL + '  :CODEMB,    ';
      strSQL := strSQL + '  :CONSUM,    ';
      strSQL := strSQL + '  :BARCOM,    ';
      strSQL := strSQL + '  :DESOPE,    ';
      strSQL := strSQL + '  :INRQCP,    ';
      strSQL := strSQL + '  :PROSPE,    ';
      strSQL := strSQL + '  :CODROT,    ';
      strSQL := strSQL + '  :TOTBRI,    ';
      strSQL := strSQL + '  :BOLADT,    ';
      strSQL := strSQL + '  :BOLVEN,    ';
      strSQL := strSQL + '  :TAXJUR,    ';
      strSQL := strSQL + '  :FATTOT,    ';
      strSQL := strSQL + '  :VALORC,    ';
      strSQL := strSQL + '  :TRARDP,    ';
      strSQL := strSQL + '  :CLILOJ,    ';
      strSQL := strSQL + '  :SEQDMP,    ';
      strSQL := strSQL + '  :DTFICO,    ';
      strSQL := strSQL + '  :DTINCO,    ';
      strSQL := strSQL + '  :DTINSE,    ';
      strSQL := strSQL + '  :DTBXSE,    ';
      strSQL := strSQL + '  :HRFICO,    ';
      strSQL := strSQL + '  :HRINCO,    ';
      strSQL := strSQL + '  :HRINSE,    ';
      strSQL := strSQL + '  :HRBXSE,    ';
      strSQL := strSQL + '  :USAQUE,    ';
      strSQL := strSQL + '  :DOCQUE,    ';
      strSQL := strSQL + '  :TPOPER,    ';
      strSQL := strSQL + '  :CODPRJ,    ';
      strSQL := strSQL + '  :EMPEXP,    ';
      strSQL := strSQL + '  :DTCTVN,    ';
      strSQL := strSQL + '  :VLCTVN,    ';
      strSQL := strSQL + '  :NLEADS,    ';
      strSQL := strSQL + '  :CUPDES,    ';
      strSQL := strSQL + '  :NOTPAU,    ';
      strSQL := strSQL + '  :USADEP,    ';
      strSQL := strSQL + '  :STSDEP,    ';
      strSQL := strSQL + '  :CODCAT,    ';
      strSQL := strSQL + '  :DEVWMS,    ';
      strSQL := strSQL + '  :FREMKP,    ';
      strSQL := strSQL + '  :COMMKP,    ';
      strSQL := strSQL + '  :HISCOM,    ';
      strSQL := strSQL + '  :CODEVE,    ';
      strSQL := strSQL + '  :DH_IMP,    ';
      strSQL := strSQL + '  :OPBXSE,    ';
      strSQL := strSQL + '  :ENVCON,    ';
      strSQL := strSQL + '  :TIPREC,    ';
      strSQL := strSQL + '  :TX_PIX,    ';
      strSQL := strSQL + '  :EMPPIX,    ';
      strSQL := strSQL + '  :ABADEP,    ';
      strSQL := strSQL + '  :NUMORI,    ';
      strSQL := strSQL + '  :ESPORI,    ';
      strSQL := strSQL + '  :EMPORI,    ';
      strSQL := strSQL + '  :LOC_PD,    ';
      strSQL := strSQL + '  :COLETA,    ';

      If (Not fEmptyStr(strObsExp)) Then
        strSQL := strSQL + '  :OBSEXP, ';

      If (Not fEmptyStr(strOpeExp)) Then
        strSQL := strSQL + '  :OPEEXP, ';

      strSQL := strSQL + '  :EMPEPE,    ';

      {Concreto}
      strSQL := strSQL + '  :CCRPLA,    ';
      strSQL := strSQL + '  :CCRMOT,    ';
      strSQL := strSQL + '  :CCRBET,    ';
      strSQL := strSQL + '  :CCRLAC,    ';
      strSQL := strSQL + '  :CCR_CB,    ';
      strSQL := strSQL + '  :CCRFCK,    ';
      strSQL := strSQL + '  :CCRABA,    ';
      strSQL := strSQL + '  :CCRTIP,    ';
      strSQL := strSQL + '  :CCRBRI,    ';
      strSQL := strSQL + '  :CCR_ML,    ';
      strSQL := strSQL + '  :CCRQTD,    ';
      strSQL := strSQL + '  :CCRVLR,    ';
      strSQL := strSQL + '  :CCRTOT,    ';
      strSQL := strSQL + '  :CCROBR,    ';
      strSQL := strSQL + '  :CCRART,    ';
      strSQL := strSQL + '  :CODCNO,    ';
      strSQL := strSQL + '  :INSIMO,    ';
      strSQL := strSQL + '  :CODCIB,    ';
      strSQL := strSQL + '  :NUMDRW,    ';
      strSQL := strSQL + '  :VALCRE,    ';
      strSQL := strSQL + '  :UPSEML,    ';
      strSQL := strSQL + '  :DTLBEX,    ';
      strSQL := strSQL + '  :HRLBEX,    ';
      strSQL := strSQL + '  :FRECOT,    ';
      strSQL := strSQL + '  :REGES2,    ';

      strSQL := strSQL + '  :CILVAS,    ';
      strSQL := strSQL + '  :AUTICV,    ';
      strSQL := strSQL + '  :CDCOPO,    ';
      strSQL := strSQL + '  :CDCSTA,    ';
      strSQL := strSQL + '  :FORUCO,    ';
      strSQL := strSQL + '  :CTAUCO,    ';
      strSQL := strSQL + '  :HISUCO,    ';
      strSQL := strSQL + '  :EVEUCO,    ';
      strSQL := strSQL + '  :DESREN,    ';
      strSQL := strSQL + '  :REGDES,    ';
      strSQL := strSQL + '  :CLICEO,    ';
      strSQL := strSQL + '  :FATSSA,    ';
      strSQL := strSQL + '  :CLITOP,    ';
      strSQL := strSQL + '  :SUPGER,    ';
      strSQL := strSQL + '  :SUPREG,    ';
      strSQL := strSQL + '  :AUTRCO,    ';
      strSQL := strSQL + '  :FATSER,    ';
      strSQL := strSQL + '  :CANFAT,    ';
      strSQL := strSQL + '  :INTFUS,    ';
      strSQL := strSQL + '  :SEQSEP,    ';
      strSQL := strSQL + '  :SEQOND,    ';
      strSQL := strSQL + '  :ONDAOP,    ';
      strSQL := strSQL + '  :ONDADT,    ';
      strSQL := strSQL + '  :ONDAHR,    ';
      strSQL := strSQL + '  :PERDAD,    ';
      strSQL := strSQL + '  :DECZFM,    ';
      strSQL := strSQL + '  :CELCON,    ';
      strSQL := strSQL + '  :UTIAAC,    ';
      strSQL := strSQL + '  :ACPCAR,    ';
      strSQL := strSQL + '  :ACPCOM,    ';
      strSQL := strSQL + '  :SEPANT,    ';
      strSQL := strSQL + '  :DTSANT,    ';
      strSQL := strSQL + '  :HRSANT,    ';
      strSQL := strSQL + '  :COTLAL,    ';
      strSQL := strSQL + '  :TOTCBS, ';
      strSQL := strSQL + '  :TOTIBS, ';
      strSQL := strSQL + '  :TOT_IS, ';
      strSQL := strSQL + '  :VCHCDP)    ';

      qryExtGor := fCriaQuery(Nil);
      qryExtGor.SQL.Text := strSQL;

      qrySerGor := fCriaQuery(Nil);
      qrySerGor.SQL.Text := fGetSQLInsertTabelasServico('SERGOR');

      strUsaDeps := 'N';
      If (strEspdoc = 'OR') Then
        strUsaDeps := TValidacoesSistemaDEPS.fRealizarValidacaoSistemaDEPS(strCodCnd);

      qryFatGor := fCriaQuery;

      strAutInc := fRetAutoIncrem('FATGOR', strCodEmp);

      With qryFatGor Do
      Begin
        qryFatGor.SQL.Text := 'SELECT * FROM FATGOR WHERE FALSE';
        qryFatGor.Open;

        Insert;

        FieldByName('AUTOINCREM').AsString   := strAutInc;
        FieldByName('FGO_CODEMP').AsString   := strCodEmp;
        FieldByName('FGO_NUMDOC').AsString   := strNumDoc;
        FieldByName('FGO_ESPDOC').AsString   := strEspDoc;

        If fEmptyStr(strCodCli) Then
          FieldByName('FGO_CODCLI').Value := Null
        Else
          FieldByName('FGO_CODCLI').AsString   := strCodCli;

        If fEmptyStr(strCodVen) Then
          FieldByName('FGO_CODVEN').Value := Null
        Else
          FieldByName('FGO_CODVEN').AsString   := strCodVen;

        If fEmptyStr(strCodTra) Then
          FieldByName('FGO_CODTRA').Value := Null
        Else
          FieldByName('FGO_CODTRA').AsString   := strCodTra;

        FieldByName('FGO_SERIE_').AsString   := strSerie;

        If dtaDtaEnt = 0 Then
          FieldByName('FGO_DTAENT').Value := Null
        Else
          FieldByName('FGO_DTAENT').AsDateTime := dtaDtaEnt;

        If dtaHorEnt = 0 Then
          FieldByName('FGO_HORENT').Value := Null
        Else
          FieldByName('FGO_HORENT').AsDateTime := dtaHorEnt;

        FieldByName('FGO_CONPAG').AsString   := strConPag;
        FieldByName('FGO_ESTADO').AsString := strEstado;

        If Not fClienteConsumidor(fRetNomCliente(strCodCli), True, True) Then
        Begin
          FieldByName('FGO_NOMCON').Value := Null;
          FieldByName('FGO_ENDCON').Value := Null;
          FieldByName('FGO_BAICON').Value := Null;
          FieldByName('FGO_CEPCON').Value := Null;
          FieldByName('FGO_CIDCON').Value := Null;
          FieldByName('FGO_ESTCON').Value := Null;
          FieldByName('FGO_TELCON').Value := Null;
          FieldByName('FGO_CGCCPF').Value := Null;
          FieldByName('FGO_CGCCON').Value := Null;
          FieldByName('FGO_IESCON').Value := Null;
          FieldByName('FGO_R_GCON').Value := Null;
          FieldByName('FGO_EMLCON').Value := Null;
          strCodAti := '';
          dtaNasCon := 0;
        End
        Else
        Begin
          FieldByName('FGO_NOMCON').AsString := strNomCom;
          FieldByName('FGO_ENDCON').AsString := strEndCon;
          FieldByName('FGO_BAICON').AsString := strBaiCon;
          FieldByName('FGO_CEPCON').AsString := strCepCon;
          FieldByName('FGO_CIDCON').AsString := strCidCon;
          FieldByName('FGO_ESTCON').AsString := strEstCon;
          FieldByName('FGO_TELCON').AsString := strTelCon;
          FieldByName('FGO_CGCCPF').AsString := strCgcCpf;
          FieldByName('FGO_CGCCON').AsString := strCgcCon;
          FieldByName('FGO_IESCON').AsString := strIesCon;
          FieldByName('FGO_R_GCON').AsString := strCli_Rg;
          FieldByName('FGO_EMLCON').AsString := strEmlCon;
        End;

        If Assigned(objFazenda) And Not fEmptyStr(TDadosFazendaBase(objFazenda).strCodFaz) Then
        Begin
          FieldByName('FGO_NOMCON').AsString := strNomCom;
          FieldByName('FGO_ENDCON').AsString := TDadosFazendaBase(objFazenda).strNomFaz;
          FieldByName('FGO_BAICON').AsString := TDadosFazendaBase(objFazenda).strBairro;
          FieldByName('FGO_CEPCON').AsString := TDadosFazendaBase(objFazenda).strEndCep;
          FieldByName('FGO_CIDCON').AsString := TDadosFazendaBase(objFazenda).strCodCid;
          FieldByName('FGO_ESTCON').AsString := TDadosFazendaBase(objFazenda).strEstado;

          FieldByName('FGO_CGCCPF').AsString := TDadosFazendaBase(objFazenda).intCgcCpf.ToString;
          FieldByName('FGO_CGCCON').AsString := TDadosFazendaBase(objFazenda).strNuCnpj;
          FieldByName('FGO_IESCON').AsString := TDadosFazendaBase(objFazenda).strNumIes;

          FieldByName('FGO_R_GCON').AsString := '';
          FieldByName('FGO_TELCON').AsString := strTelCon;//Dados do cliente
          FieldByName('FGO_EMLCON').AsString := strEmlCon;//Dados do cliente
        End;

        If fEmptyStr(FieldByName('FGO_CIDCON').AsString) Then
          FieldByName('FGO_CIDCON').Clear;

        FieldByName('FGO_BASSIM').AsFloat    := fltBasSim;
        FieldByName('FGO_BASIPI').AsFloat    := fltBasIpi;
        FieldByName('FGO_ALQIPI').AsFloat    := fltAlqIpi;
        FieldByName('FGO_TOTIPI').AsFloat    := fltTotIpi;
        FieldByName('FGO_BASICM').AsFloat    := fltBasIcm;
        FieldByName('FGO_ALQICM').AsFloat    := fltAlqIcm;
        FieldByName('FGO_TOTICM').AsFloat    := fltTotIcm;
        FieldByName('FGO_TOTRET').AsFloat    := fltTotRet;
        FieldByName('FGO_ALQRET').AsFloat    := fltAlqRet;
        FieldByName('FGO_BASRET').AsFloat    := fltBasRet;
        FieldByName('FGO_DESESP').AsFloat    := fltDesEsp;
        FieldByName('FGO_VLRCON').AsFloat    := fltVlrCon;
        FieldByName('FGO_TOTPRO').AsFloat    := fltTotPro;
        FieldByName('FGO_TOTCUS').AsFloat    := fltTotCus;
        FieldByName('FGO_TOTMED').AsFloat    := fltTotMed;
        FieldByName('FGO_TIPFRE').AsString   := strTipFre;
        FieldByName('FGO_TOTFRE').AsFloat    := fltTotFre;

        FieldByName('FGO_VPAR01').AsFloat    := fltVPar01;
        FieldByName('FGO_VPAR02').AsFloat    := fltVPar02;
        FieldByName('FGO_VPAR03').AsFloat    := fltVPar03;
        FieldByName('FGO_VPAR04').AsFloat    := fltVPar04;
        FieldByName('FGO_VPAR05').AsFloat    := fltVPar05;
        FieldByName('FGO_VPAR06').AsFloat    := fltVPar06;
        FieldByName('FGO_VPAR07').AsFloat    := fltVPar07;
        FieldByName('FGO_VPAR08').AsFloat    := fltVPar08;
        FieldByName('FGO_VPAR09').AsFloat    := fltVPar09;
        FieldByName('FGO_VPAR10').AsFloat    := fltVPar10;
        FieldByName('FGO_VPAR11').AsFloat    := fltVPar11;
        FieldByName('FGO_VPAR12').AsFloat    := fltVPar12;

        FieldByName('FGO_DESACE').AsFloat    := fltDesAce;
        FieldByName('FGO_PESBRU').AsFloat    := fltPesBru;

        If fFormataFloat(fltPesLiq,2) <= 0 Then
          FieldByName('FGO_PESLIQ').AsFloat  := fltPesBru
        Else
          FieldByName('FGO_PESLIQ').AsFloat  := fltPesLiq;

        FieldByName('FGO_VOLUME').AsFloat    := fltVolume;
        FieldByName('FGO_ESPECI').AsString   := strEspeci;
        FieldByName('FGO_MARCA_').AsString   := strMarca;
        FieldByName('FGO_MEN001').AsString   := strMen001;
        FieldByName('FGO_MEN002').AsString   := strMen002;

        If blnJaFatu Then
          FieldByName('FGO_JAFATU').AsInteger  := 1
        Else
          FieldByName('FGO_JAFATU').AsInteger  := 0;

        If (fEmptyStr(strEmpFat)) Then
          FieldByName('FGO_EMPFAT').Value := Null
        Else
          FieldByName('FGO_EMPFAT').AsString   := strEmpFat;

        FieldByName('FGO_TIPFAT').AsString   := strTipFat;
        FieldByName('FGO_NUMFAT').AsString   := strNumFat;

        If dtaDtaFat = 0 Then
          FieldByName('FGO_DTAFAT').Value := Null
        Else
          FieldByName('FGO_DTAFAT').AsDateTime := dtaDtaFat;

        If (fEmptyStr(strVenFat)) Then
          FieldByName('FGO_VENFAT').Value := Null
        Else
          FieldByName('FGO_VENFAT').AsString   := strVenFat;

        FieldByName('FGO_CNDFAT').AsString   := strCndFat;
        FieldByName('FGO_VALFAT').AsFloat    := fltValFat;
        FieldByName('FGO_PORDES').AsFloat    := fltPorDes;

        If (fEmptyStr(strCodDig)) Then
          FieldByName('FGO_CODDIG').Value := Null
        Else
          FieldByName('FGO_CODDIG').AsString   := strCodDig;

        If (fEmptyStr(strCodCnd)) Then
          FieldByName('FGO_CODCND').Value := Null
        Else
          FieldByName('FGO_CODCND').AsString   := strCodCnd;

        If (fEmptyStr(strCodFpg)) Then
          FieldByName('FGO_CODFPG').Value := Null
        Else
          FieldByName('FGO_CODFPG').AsString := strCodFpg;

        If (fEmptyStr(objServicos.strCodS01)) Then
          FieldByName('FGO_CODS01').Value := Null
        Else
          FieldByName('FGO_CODS01').AsString := objServicos.strCodS01;

        If (fEmptyStr(objServicos.strCodS02)) Then
          FieldByName('FGO_CODS02').Value := Null
        Else
          FieldByName('FGO_CODS02').AsString := objServicos.strCodS02;

        If (fEmptyStr(objServicos.strCodS03)) Then
          FieldByName('FGO_CODS03').Value := Null
        Else
          FieldByName('FGO_CODS03').AsString := objServicos.strCodS03;

        If (fEmptyStr(objServicos.strCodS04)) Then
          FieldByName('FGO_CODS04').Value := Null
        Else
          FieldByName('FGO_CODS04').AsString := objServicos.strCodS04;

        If (fEmptyStr(objServicos.strCodS05)) Then
          FieldByName('FGO_CODS05').Value := Null
        Else
          FieldByName('FGO_CODS05').AsString := objServicos.strCodS05;

        If (fEmptyStr(objServicos.strCodS06)) Then
          FieldByName('FGO_CODS06').Value := Null
        Else
          FieldByName('FGO_CODS06').AsString := objServicos.strCodS06;

        If (fEmptyStr(objServicos.strDesS01)) Then
          FieldByName('FGO_DESS01').Value := Null
        Else
          FieldByName('FGO_DESS01').AsString := objServicos.strDesS01;

        If (fEmptyStr(objServicos.strDesS02)) Then
          FieldByName('FGO_DESS02').Value := Null
        Else
          FieldByName('FGO_DESS02').AsString := objServicos.strDesS02;

        If (fEmptyStr(objServicos.strDesS03)) Then
          FieldByName('FGO_DESS03').Value := Null
        Else
          FieldByName('FGO_DESS03').AsString := objServicos.strDesS03;

        If (fEmptyStr(objServicos.strDesS04)) Then
          FieldByName('FGO_DESS04').Value := Null
        Else
          FieldByName('FGO_DESS04').AsString := objServicos.strDesS04;

        If (fEmptyStr(objServicos.strDesS05)) Then
          FieldByName('FGO_DESS05').Value := Null
        Else
          FieldByName('FGO_DESS05').AsString := objServicos.strDesS05;

        If (fEmptyStr(objServicos.strDesS06)) Then
          FieldByName('FGO_DESS06').Value := Null
        Else
          FieldByName('FGO_DESS06').AsString := objServicos.strDesS06;

        FieldByName('FGO_VALS01').AsFloat    := objServicos.fltValS01;
        FieldByName('FGO_VALS02').AsFloat    := objServicos.fltValS02;
        FieldByName('FGO_VALS03').AsFloat    := objServicos.fltValS03;
        FieldByName('FGO_VALS04').AsFloat    := objServicos.fltValS04;
        FieldByName('FGO_VALS05').AsFloat    := objServicos.fltValS05;
        FieldByName('FGO_VALS06').AsFloat    := objServicos.fltValS06;

        FieldByName('FGO_PRAENT').AsInteger  := objServicos.intPraEnt;
        FieldByName('FGO_TOTSER').AsFloat    := objServicos.fltTotSer;
        FieldByName('FGO_PERISS').AsFloat    := objServicos.fltPerIss;
        FieldByName('FGO_VALISS').AsFloat    := objServicos.fltValIss;
        FieldByName('FGO_CONENT').AsString   := strConEnt;
        FieldByName('FGO_PREVIS').AsDateTime := IIF(dtaPreVis = 0, dtaDtaEnt, dtaPreVis);

        FieldByName('FGO_VPGANT').AsFloat    := 0.0;

        FieldByName('FGO_DEESPB').AsFloat    := 0.0;

        FieldByName('FGO_VALROM').AsFloat    := 0.0;

        FieldByName('FGO_ULTALT').AsDateTime := dtaUltAlt;

        If Pos('S', strNTrava) > 0 Then
          FieldByName('FGO_NTRAVA').AsString := strNTrava;

        FieldByName('FGO_TIPPED').AsString   := strTipPed;

        If (fEmptyStr(strCliCtt)) Then
          FieldByName('FGO_CLICTT').Value    := Null
        Else
          FieldByName('FGO_CLICTT').AsString := strCliCtt;

        FieldByName('FGO_ENTFAT').AsString   := strEntFat;
        FieldByName('FGO_DESCON').AsFLoat    := fltDesCon;
        FieldByName('FGO_TABPRE').AsString   := strTabPre;

        If blnLOC_PD Then
        Begin
          intLibera := 1;
          blnPedLib := False;
          blnLibCom := False;
        End;

        If ((Not fCfgSis('LIBPED', varBoolean)) And (strEspDoc = 'PD') And (Not blnImpSfaPag)) Or
           (blnPedLib) Then
        Begin
          if (fCfgSis('USAALP', varBoolean)) and
             (fCfgSis('CPGALP', varString) = strCodCnd) then
            FieldByName('FGO_LIBERA').AsInteger := 0
          else
            FieldByName('FGO_LIBERA').AsInteger := 1;

          If fEmptyStr(strCodVen) Then
            FieldByName('FGO_OPELIB').Value := Null
          Else
            FieldByName('FGO_OPELIB').AsString   := strCodVen;

          If fEmptyStr(strCodDig) Then
            FieldByName('FGO_DIGLIB').Value := Null
          Else
            FieldByName('FGO_DIGLIB').AsString   := strCodDig;

          If dtaHorEnt = 0 Then
            FieldByName('FGO_HORLIB').Value := Null
          Else
            FieldByName('FGO_HORLIB').AsDateTime := dtaHorEnt;

          If dtaDtaEnt = 0 Then
            FieldByName('FGO_DTALIB').Value := Null
          Else
            FieldByName('FGO_DTALIB').AsDateTime := dtaDtaEnt;
        End
        Else
        Begin
          if (fCfgSis('USAALP', varBoolean)) and
             (fCfgSis('CPGALP', varString) = strCodCnd) and
             (strEspDoc = 'PD') then
            FieldByName('FGO_LIBERA').AsInteger := 0
          else
            FieldByName('FGO_LIBERA').AsInteger  := intLibera;

          if not fEmptyStr(strOpeLib) then
            FieldByName('FGO_OPELIB').AsString   := strOpeLib;

          if not fEmptyStr(strDigLib) then
            FieldByName('FGO_DIGLIB').AsString   := strDigLib;

          if dtaHorLib <> 0 then
            FieldByName('FGO_HORLIB').AsDateTime := dtaHorLib;

          if dtaDtaLib <> 0 then
            FieldByName('FGO_DTALIB').AsDateTime := dtaDtaLib;
        End;

        {*******************************************}
        {* PEDIDO - NECESSÁRIO LIBERAÇÃO COMERCIAL *}
        {****************************************RV*}
        If blnLibCom Then
        Begin
          If (Pos('S', strNTrava) = 0) Then
            strNTrava := 'NNNNNNNNSNNNNNNNNNNN'
          Else
          begin
            if fCfgSis('LIBPSE',varBoolean) and (Copy(strNTrava, 15, 1) = 'S') then
              strNTrava := Copy(strNTrava, 1, 8) + 'SNNNNNSNNNNN'
            else
              strNTrava := Copy(strNTrava, 1, 8) + 'SNNNNNNNNNNN';
          end;

          FieldByName('FGO_NTRAVA').AsString  := strNTrava;
          FieldByName('FGO_LIBCOM').AsInteger := 0;
          FieldByName('FGO_OPELIC').Value     := Null;
          FieldByName('FGO_DIGLIC').Value     := Null;
          FieldByName('FGO_HORLIC').Value     := Null;
          FieldByName('FGO_DTALIC').Value     := Null;
        End
        Else
        Begin
          FieldByName('FGO_LIBCOM').AsInteger    := 1;
          If fEmptyStr(strCodVen) Then
            FieldByName('FGO_OPELIC').Value      := Null
          Else
            FieldByName('FGO_OPELIC').AsString   := strCodVen;

          If fEmptyStr(strCodDig) Then
            FieldByName('FGO_DIGLIC').Value      := Null
          Else
            FieldByName('FGO_DIGLIC').AsString   := strCodDig;

          If dtaHorEnt = 0 Then
            FieldByName('FGO_HORLIC').Value      := Null
          Else
            FieldByName('FGO_HORLIC').AsDateTime := dtaHorEnt;

          If dtaDtaEnt = 0 Then
            FieldByName('FGO_DTALIC').Value      := Null
          Else
            FieldByName('FGO_DTALIC').AsDateTime := dtaDtaEnt;
        End;
        FieldByName('FGO_MOTLIB').AsString       := strMotLib;

        {*******************************************}
        {* BONIFICAÇÃO - NECESSÁRIO LIBERAÇÃO      *}
        {* FINANCEIRA SEMPRE, COMERCIAL SE MARCADA *}
        {****************************************RV*}
        If fCfgSis('LIBPED', varBoolean) And (strEspDoc = 'PD') And (strTipOpe = 'B') And
           Not fVerificaAcessoSistema('PEDJLB') Then
        Begin
          If (Pos('S', strNTrava) = 0) Then
            strNTrava := 'NNNNNNNNNSNNNNNNNNNN'
          Else
            strNTrava := Copy(strNTrava, 1, 9) + 'SNNNNNNNNNN';

          FieldByName('FGO_NTRAVA').AsString  := strNTrava;
          FieldByName('FGO_LIBERA').AsInteger := 0;
          FieldByName('FGO_OPELIB').Value     := Null;
          FieldByName('FGO_DIGLIB').Value     := Null;
          FieldByName('FGO_HORLIB').Value     := Null;
          FieldByName('FGO_DTALIB').Value     := Null;

          If (fCfgSis('AGDLIB', VarBoolean) Or fCfgSis('AGDLBT', VarBoolean)) Then
          Begin
            If (Pos('S', strNTrava) = 0) Then
              strNTrava := 'NNNNNNNNNNSNNNNNNNN'
            Else
              strNTrava := Copy(strNTrava, 1, 10) + 'SNNNNNNNNN';

            FieldByName('FGO_NTRAVA').AsString  := strNTrava;
            FieldByName('FGO_LIBCOM').AsInteger := 0;
            FieldByName('FGO_OPELIC').Value     := Null;
            FieldByName('FGO_DIGLIC').Value     := Null;
            FieldByName('FGO_HORLIC').Value     := Null;
            FieldByName('FGO_DTALIC').Value     := Null;
          End
          Else
          Begin
            FieldByName('FGO_LIBCOM').AsInteger    := 1;
            If fEmptyStr(strCodVen) Then
              FieldByName('FGO_OPELIC').Value      := Null
            Else
              FieldByName('FGO_OPELIC').AsString   := strCodVen;

            If fEmptyStr(strCodDig) Then
              FieldByName('FGO_DIGLIC').Value      := Null
            Else
              FieldByName('FGO_DIGLIC').AsString   := strCodDig;

            If dtaHorEnt = 0 Then
              FieldByName('FGO_HORLIC').Value      := Null
            Else
              FieldByName('FGO_HORLIC').AsDateTime := dtaHorEnt;

            If dtaDtaEnt = 0 Then
              FieldByName('FGO_DTALIC').Value      := Null
            Else
              FieldByName('FGO_DTALIC').AsDateTime := dtaDtaEnt;
          End;
        End;

        {******************************************}
        {* PEDIDO PAGAR.ME É LIBERADO PELO ROBÔ   *}
        {* PROCESSACOBRANCAELETRONICA QUANDO HÁ A *}
        {* CONFIRMAÇÃO DO PAGAMENTO               *}
        {***************************************WL*}
        if (strEspDoc = 'PD') and
           (fCfgSis('PMEHAB', varBoolean)) and
           (TFacadeCobrancaEletronica.fCondicaoPagamentoCobrancaEletronica(strCodCnd, tcPagarMe)) then
        begin
          FieldByName('FGO_LIBERA').AsInteger := 0;

          if fCfgSis('AGDLBT', VarBoolean) or
            (fCfgSis('AGDLIB', varBoolean) and fCfgSis('LPPDBL', varBoolean)) then
          begin
            FieldByName('FGO_LIBCOM').AsInteger := 0;
          end
          else
          begin
            if Length(strNTrava) >= 11 then
            begin
              if strNTrava[POS_TRAVA_COM_PEDIDO]  = 'S' then
                strNTrava[POS_TRAVA_COM_PEDIDO]  := 'N';

              if strNTrava[POS_TRAVA_COM_BONIFICACAO] = 'S' then
                strNTrava[POS_TRAVA_COM_BONIFICACAO] := 'N';

              FieldByName('FGO_NTRAVA').AsString := strNTrava;
            end;

            FieldByName('FGO_LIBCOM').AsInteger := 1;
          end;
        end;

        If Pos(strEntFut,'SN') <= 0 Then
          strEntFut := 'N';

        FieldByName('FGO_ENTFUT').AsString  := strEntFut;
        FieldByName('FGO_MARGEM').AsFloat   := fltMargem;

        FieldByName('FGO_NUMPOK').AsString  := strNumPok;

        FieldByName('FGO_ENT_CD').AsString  := IIF(blnEnt_CD, 'S', 'N');
        FieldByName('FGO_OPRFLJ').AsString  := strOprFlj;

        FieldByName('FGO_MENEXP').AsString  := strMenExp;
        FieldByName('FGO_MENEX2').AsString  := strMenEx2;
        FieldByName('FGO_MENEX3').AsString  := strMenEx3;
        FieldByName('FGO_MENEX4').AsString  := strMenEx4;

        FieldByName('FGO_NUMREG').AsString  := strNumReg;
        FieldByName('FGO_PEDSIT').AsString  := strPedSit;
        FieldByName('FGO_DTENTR').AsDateTime := dtaDtEntr;
        FieldByName('FGO_ZERTAX').AsString  := strZerTax;

        If (Pos(strTipOpe, 'VBCAUER' + IIF(fCfgSis('PERDEM', varBoolean), 'D', '')) <= 0) Then
          strTipOpe := 'V';

        FieldByName('FGO_TIPOPE').AsString  := strTipOpe;

        FieldByName('FGO_DTAORI').AsDateTime := dtaDtaOri;

        FieldByName('FGO_DESFIN').AsFloat   := fltDesFin;
        FieldByName('FGO_TIPFIN').AsString  := strTipFin;
        FieldByName('FGO_PERENT').AsString  := strPerEnt;

        If fEmptyStr(strEmpFor) Then
          FieldByName('FGO_EMPFOR').Value := Null
        Else
          FieldByName('FGO_EMPFOR').AsString := strEmpFor;

        FieldByName('FGO_IMPDAV').AsInteger := 1;
        FieldByName('FGO_FATNOT').AsFloat   := fltFatNot;

        FieldByName('FGO_OBSL01').AsString  := strObsL01;
        FieldByName('FGO_OBSL02').AsString  := strObsL02;

        If dtaHPrevi = 0 Then
          FieldByName('FGO_HPREVI').Value := Null
        Else
          FieldByName('FGO_HPREVI').AsDateTime := dtaHPrevi;

        If strEspDoc = 'PD' Then
          FieldByName('FGO_SEPIMP').AsString := IIF((strSepImp = '1') Or (strSepImp = 'S'),'2',IIF((fEmptyStr(strSepImp)) Or (strSepImp = 'N'),'0',strSepImp));

        FieldByName('FGO_ORIGEM').AsString  := strOriGor;

        FieldByName('FGO_CORTPD').AsString := IIF(blnCortPD, 'S', 'N');

        {**********************************}
        {* VERIFICAÇÃO PARA CAPTURAR ERRO *}
        {* RETORNO REQ 116167             *}
        {*******************************FS*}
        For intField := 0 To Pred(Fields.Count) Do
        Begin
          If (Fields[intField].DataType in [ftSingle, ftFloat, ftExtended, ftCurrency, ftBCD, ftFMTBCD]) And
            IsNan(Fields[intField].AsFloat) Then
            Raise Exception.Create(Concat('Campo: ', Fields[intField].FieldName, ' com valor inválido!'));
        End;

        TControleLiberacaoPedidos.EnviaSomentePedidosDeOrigemExternaParaLiberacao.Parametros.Clear;
        TControleLiberacaoPedidos.EnviaSomentePedidosDeOrigemExternaParaLiberacao.Parametros.strEspDoc := strEspDoc;
        TControleLiberacaoPedidos.EnviaSomentePedidosDeOrigemExternaParaLiberacao.Parametros.strNumPok := strNumPok;
        TControleLiberacaoPedidos.EnviaSomentePedidosDeOrigemExternaParaLiberacao.Parametros.DataSet := qryFatGor;
        TControleLiberacaoPedidos.EnviaSomentePedidosDeOrigemExternaParaLiberacao.Execute;

        Post;

        If FieldByName('FGO_CONPAG').AsString = '00' Then
        Begin
          fRollBack;

          Raise Exception.Create(FieldByName('FGO_NUMDOC').AsString+'-'+FieldByName('FGO_ESPDOC').AsString+
                                 ' com valor das parcelas inconsistentes. Se possível feche o autcom '+
                                 ' e repita essa operação. Se o problema persistir entre em contato com a Citel!');
        End;

        TLogGor.strComplementoFrmLogGor := strComplementoFrmLogGor;
        TLogGor.strCodPor := strCodPor;
        TLogGor.pLog(qryFatGor, 'FATGOR');

        pIncluiAutEnt(strAutInc,
                      strAutEnt,
                      strMen003,
                      strMen004,
                      strMen005,
                      strEntFutOpc,
                      fltVolSepExc,
                      fltVolSepNExc);

        If Assigned(objFinanc) Then
          TFinanceira(objFinanc).fGravaFinanciamento('FATGOR', strAutInc);

        If Assigned(TAtuOcoCrm(objOcoCrm)) Then
        Begin
          If fEmptyStr(TAtuOcoCrm(objOcoCrm).strNomFrm) Then
            TAtuOcoCrm(objOcoCrm).strNomFrm := '[untFatGor.fGravaFatGor]';
          TAtuOcoCrm(objOcoCrm).pProcessaFatOcorrenciasCRM;
        End;

        If (Length(arrDuplic) > 0) And (fArrDuplicatasVazio(arrDuplic)) Then
        Begin
          arrDuplic[0].strSequen := 'A';
          arrDuplic[0].curValor  := fltVPar01;
        End;

        fGravaGORCND(strAutInc, arrDuplic);
      End;

      qryExtGor.ParamByName('SEQFGO').AsString := strAutInc;

      If dtaNasCon > 0 Then
        qryExtGor.ParamByName('NASCON').AsDateTime := dtaNasCon;

      If Not fEmptyStr(strCodAti) Then
        qryExtGor.paramByName('CODATI').AsString := strCodAti
      Else
        qryExtGor.paramByName('CODATI').Value := Null;

      If fEmptyStr(strEmp_TE) Then
        qryExtGor.ParamByName('EMP_TE').Value := Null
      Else
        qryExtGor.ParamByName('EMP_TE').AsString := strEmp_TE;

      If fEmptyStr(strEmp_CD) Then
        qryExtGor.ParamByName('EMP_CD').Value := Null
      Else
        qryExtGor.ParamByName('EMP_CD').AsString := strEmp_CD;

      qryExtGor.ParamByName('DTAIMP').AsDateTime := VS_DATE;
      qryExtGor.ParamByName('HORIMP').AsDateTime := fRetHoraServidor;

      If (dtaHorImp = 0) Then
        qryExtGor.ParamByName('HORFIN').Value := Null
      Else
        qryExtGor.ParamByName('HORFIN').AsDateTime := dtaHorImp;

      If fEmptyStr(strIndCom) Then
        strIndCom := 'C';

      qryExtGor.ParamByName('INDCOM').AsString := strIndCom;
      qryExtGor.ParamByName('GERPEN').AsString := strGerPen;

      If (dtaDtaTra = 0) Then
        qryExtGor.ParamByName('DTATRA').Value := Null
      Else
        qryExtGor.ParamByName('DTATRA').AsDateTime := dtaDtaTra;

      If (dtaHorTra = 0) Then
        qryExtGor.ParamByName('HORTRA').Value := Null
      Else
        qryExtGor.ParamByName('HORTRA').AsDateTime := dtaHorTra;

      qryExtGor.ParamByName('FRESUG').AsFloat := fltFreSug;
      qryExtGor.ParamByName('FRERAT').AsFloat := fltFreRat;
      qryExtGor.ParamByName('TAXENT').AsFloat := fltTaxEnt;

      If (Assigned(objFazenda) And Not fEmptyStr(TDadosFazendaBase(objFazenda).strCodFaz)) Then
        qryExtGor.ParamByName('CODFAZ').AsString := TDadosFazendaBase(objFazenda).strCodFaz
      Else
        qryExtGor.ParamByName('CODFAZ').Value := Null;

      qryExtGor.ParamByName('ENVLIB').AsString := strEnvLib;

      If Not fEmptyStr(strCodCar) Then
        qryExtGor.ParamByName('CODCAR').AsString := strCodCar
      Else
        qryExtGor.ParamByName('CODCAR').Value := Null;

      qryExtGor.ParamByName('QTDPAC').AsInteger := intQtdPaC;

      qryExtGor.ParamByName('ENTURG').AsString := strEntUrg;
      qryExtGor.ParamByName('PD_EXP').AsString := strPD_Exp;
      qryExtGor.ParamByName('CORTE_').AsString := strCorte_;

      If fEmptyStr(strCodPor) Then
        qryExtGor.ParamByName('CODPOR').Value := Null
      Else
        qryExtGor.ParamByName('CODPOR').AsString := strCodPor;

      qryExtGor.ParamByName('PTNFMN').AsString := strPtNfMn;
      qryExtGor.ParamByName('NUMGUI').AsString := strNumGui;
      qryExtGor.ParamByName('TFTNES').AsString := strTFTNEs;

      If Not fEmptyStr(strFasObr) Then
        qryExtGor.ParamByName('FASOBR').AsString := strFasObr;

      qryExtGor.ParamByName('ORCORI').AsString := strOrcOri;

      If Not fEmptyStr(strCodTpA) Then
        qryExtGor.ParamByName('CODTPA').AsString := strCodTpA
      Else
        qryExtGor.ParamByName('CODTPA').Value := Null;

      If Not fEmptyStr(strPlaVei) Then
      Begin
        qryExtGor.ParamByName('PLAVEI').AsString := strPlaVei;
        qryExtGor.ParamByName('KM_VEI').AsString := strKm_Vei;
      End
      Else
      Begin
        qryExtGor.ParamByName('PLAVEI').Value := Null;
        qryExtGor.ParamByName('KM_VEI').Value := Null;
      End;

      If Not fEmptyStr(strRelAba) Then
        qryExtGor.ParamByName('RELABA').AsString := strRelAba
      Else
        qryExtGor.ParamByName('RELABA').Value := Null;

      qryExtGor.ParamByName('ALTERA').Value := IfThen(blnAlterado, 'S', 'N');

      If dtaImpSep > 0 Then
        qryExtGor.ParamByName('DTIMSE').AsDateTime := dtaImpSep;

      If horImpSep > 0 Then
        qryExtGor.ParamByName('HRIMSE').AsDateTime := horImpSep;

      qryExtGor.ParamByName('NPDROR').AsString := strNumPedRefOR;
      qryExtGor.ParamByName('EPDROR').AsString := strEmpPedRefOR;
      qryExtGor.ParamByName('LATITU').AsString := strLatitu;
      qryExtGor.ParamByName('LONGIT').AsString := strLongit;
      qryExtGor.ParamByName('RAIO__').AsString := strRaio__;

      qryExtGor.ParamByName('BASISS').AsFloat := objServicos.fltBasIss;
      qryExtGor.ParamByName('REDISS').AsFloat := objServicos.fltRedIss;
      qryExtGor.ParamByName('DEDISS').AsFloat := objServicos.fltDedIss;

      If Not strNumPedAba.IsEmpty Then
        qryExtGor.ParamByName('NMPDAB').AsString := strNumPedAba;

      If Not strEspPedAba.IsEmpty Then
        qryExtGor.ParamByName('ESPDAB').AsString := strEspPedAba;

      If Not strEmpPedAba.IsEmpty Then
        qryExtGor.ParamByName('EMPDAB').AsString := strEmpPedAba;

      If fEmptyStr(strCodOco) Then
        qryExtGor.ParamByName('CODOCO').Value := Null
      Else
        qryExtGor.ParamByName('CODOCO').AsString := strCodOco;

      If fEmptyStr(strTraRdp) Then
        qryExtGor.ParamByName('TRARDP').Value := Null
      Else
        qryExtGor.ParamByName('TRARDP').AsString := strTraRdp;

      qryExtGor.ParamByName('CLILOJ').AsString := strCliLoj;
      qryExtGor.ParamByName('SEQDMP').AsString := strSeqDmp;
      qryExtGor.ParamByName('VENPRE').AsString := strVenPre;
      qryExtGor.ParamByName('TEMBRI').AsString := strTemBri;
      qryExtGor.ParamByName('EDIPES').AsString := strEdiPes;

      If Not fEmptyStr(strCodSup) Then
        qryExtGor.ParamByName('CODSUP').AsString := strCodSup
      Else
        qryExtGor.ParamByName('CODSUP').Value := Null;

      qryExtGor.ParamByName('ORCESP').AsString := strOrcEsp;

      if fEmptyStr(strProspe) Then
        qryExtGor.ParamByName('PROSPE').Clear
      Else
        qryExtGor.ParamByName('PROSPE').AsString := strProspe;

      If fEmptyStr(strCodEmbarcacao) Then
        qryExtGor.ParamByName('CODEMB').Value := Null
      Else
        qryExtGor.ParamByName('CODEMB').AsString := strCodEmbarcacao;

      qryExtGor.ParamByName('DESOPE').AsFloat := fltDesOpeGor;

      If fEmptyStr(strInRqCp) Then
        qryExtGor.ParamByName('INRQCP').Value := Null
      Else
        qryExtGor.ParamByName('INRQCP').AsString := strInRqCp;

      {Comanda}
      If fEmptyStr(strBarCom) Then
        qryExtGor.ParamByName('BARCOM').Value := Null
      Else
        qryExtGor.ParamByName('BARCOM').AsString := strBarCom;

      qryExtGor.ParamByName('CONSUM').AsString := strCliCon;
      qryExtGor.ParamByName('TPOPER').AsString := strTpOper;

      If dtaValOrc = 0 Then
        qryExtGor.ParamByName('VALORC').Value := Null
      Else
        qryExtGor.ParamByName('VALORC').Value := dtaValOrc;

      qryExtGor.ParamByName('CODROT').Value := Null;
      If Not fEmptyStr(strCodRot) Then
      Begin
        qryExtGor.ParamByName('CODROT').AsString := strCodRot;
        recDadosRot := fRetornaDadosRota(strCodRot);
      End;

      qryExtGor.ParamByName('CODPRJ').Value := Null;
      If Not fEmptyStr(strCodPrj) Then
      Begin
        qryExtGor.ParamByName('CODPRJ').AsString := strCodPrj;
      End;

      If (strEspDoc = 'OR') And (Not fCfgSis('UTICAO', varBoolean)) Then
        strCodCat := '';

      If (strEspDoc = 'PD') And (Not fCfgSis('UTICAP', varBoolean)) Then
        strCodCat := '';

      qryExtGor.ParamByName('CODCAT').Value := Null;
      If Not fEmptyStr(strCodCat) Then
      Begin
        qryExtGor.ParamByName('CODCAT').AsString := strCodCat;
      End;

      qryExtGor.ParamByName('DEVWMS').AsString := IIF(blnDevWms, 'S', 'N');

      qryExtGor.ParamByName('FREMKP').AsFloat := fltFreMkp;
      qryExtGor.ParamByName('COMMKP').AsFloat := fltComMkp;

      qryExtGor.ParamByName('HISCOM').Value := Null;
      If Not fEmptyStr(strHisCom) Then
        qryExtGor.ParamByName('HISCOM').AsString := strHisCom;

      qryExtGor.ParamByName('CODEVE').Clear;
      If Not fEmptyStr(strCodEve) Then
        qryExtGor.ParamByName('CODEVE').AsString := strCodEve;

      {Retorna empresa de expedição}
      strEmpExp := fEMPEXP(strCodEmp,
                           strEmpFor,
                           strEmp_TE,
                           IIF(blnEnt_CD, 'S', 'N'),
                           strEmp_CD,
                           IIF(blnAbaDep, 'S', 'N'),
                           IIF(blnRegEs2, 'S', 'N'),
                           blnConEqu,
                           strMen001);

      qryExtGor.ParamByName('EMPEXP').Value := Null;
      If Not fEmptyStr(strEmpExp) Then
      Begin
        qryExtGor.ParamByName('EMPEXP').AsString := strEmpExp;
      End;

      qryExtGor.ParamByName('TOTBRI').AsFloat := fltTotBri;
      qryExtGor.ParamByName('BOLADT').AsFloat := fltBolAdt;
      qryExtGor.ParamByName('BOLVEN').AsString := IIF(blnBolVen, 'S', 'N');

      qryExtGor.ParamByName('TAXJUR').AsFloat  := fltTaxJur;
      qryExtGor.ParamByName('FATTOT').AsString := strFatTot;

      qryExtGor.ParamByName('DTFICO').AsDateTime := dtaDtFiCo;
      qryExtGor.ParamByName('DTINCO').AsDateTime := dtaDtInCo;
      qryExtGor.ParamByName('DTINSE').AsDateTime := dtaDtInSe;
      qryExtGor.ParamByName('DTBXSE').AsDateTime := dtaDtBxSe;
      qryExtGor.ParamByName('HRFICO').AsDateTime := hraHrFiCo;
      qryExtGor.ParamByName('HRINCO').AsDateTime := hraHrInCo;
      qryExtGor.ParamByName('HRINSE').AsDateTime := hraHrInSe;
      qryExtGor.ParamByName('HRBXSE').AsDateTime := hraHrBxSe;

      qryExtGor.ParamByName('USAQUE').AsString := IIF(strUsaQue = 'S', strUsaQue, 'N');
      qryExtGor.ParamByName('DOCQUE').AsString := strDocQue;

      If qryExtGor.ParamByName('DTFICO').AsDateTime = 0 Then qryExtGor.ParamByName('DTFICO').Clear;
      If qryExtGor.ParamByName('DTINCO').AsDateTime = 0 Then qryExtGor.ParamByName('DTINCO').Clear;
      If qryExtGor.ParamByName('DTINSE').AsDateTime = 0 Then qryExtGor.ParamByName('DTINSE').Clear;
      If qryExtGor.ParamByName('DTBXSE').AsDateTime = 0 Then qryExtGor.ParamByName('DTBXSE').Clear;
      If qryExtGor.ParamByName('HRFICO').AsDateTime = 0 Then qryExtGor.ParamByName('HRFICO').Clear;
      If qryExtGor.ParamByName('HRINCO').AsDateTime = 0 Then qryExtGor.ParamByName('HRINCO').Clear;
      If qryExtGor.ParamByName('HRINSE').AsDateTime = 0 Then qryExtGor.ParamByName('HRINSE').Clear;
      If qryExtGor.ParamByName('HRBXSE').AsDateTime = 0 Then qryExtGor.ParamByName('HRBXSE').Clear;

      if not fEmptyStr(strNLeads) Then
        qryExtGor.ParamByName('NLEADS').AsString := strNLeads;

      if not fEmptyStr(strCupDes) Then
        qryExtGor.ParamByName('CUPDES').AsString := strCupDes;

      qryExtGor.ParamByName('NOTPAU').AsString := strNotPau;

      If dtaDtCtVn > 0 Then
      Begin
        qryExtGor.ParamByName('DTCTVN').AsDateTime := dtaDtCtVn;
        qryExtGor.ParamByName('VLCTVN').AsFloat    := fltVlCtVn;
      end;

      If dtaDH_Imp > 0 Then
      Begin
        qryExtGor.ParamByName('DH_IMP').AsDateTime := dtaDH_Imp;
      End;

      If not fEmptyStr(StrOpBxSe) Then
        qryExtGor.ParamByName('OPBXSE').AsString := strOpBxSe;

      {**************************}
      {* VALIDAÇÃO SISTEMA DEPS *}
      {***********************AJ*}
      qryExtGor.ParamByName('USADEP').AsString := strUsaDeps;
      qryExtGor.ParamByName('STSDEP').AsString := 'DISPENSA ANÁLISE';
      If strUsaDeps = 'S' Then
        qryExtGor.ParamByName('STSDEP').AsString := 'NÃO ENVIADO';

      qryExtGor.ParamByName('ENVCON').AsString := IIF(AblnGeradoPelaConsignacao, 'S', 'N');

      qryExtGor.ParamByName('TIPREC').AsString := '';
      If (Not fEmptyStr(strCodCnd)) And
         ((fCfgSis('USAALP', varBoolean)) Or (fCfgSis('ALPKNK', varBoolean))) Then
      Begin
        If strCodCnd = fCfgSis('CPGALP', varString) Then
        Begin
          If Not fEmptyStr(strNumPok) Then
            qryExtGor.ParamByName('TIPREC').AsString := 'ALPES'
          Else
            qryExtGor.ParamByName('TIPREC').AsString := 'ALPE';
        End
        Else If (Pos(strCodCnd, fCfgSis('CNDBOL', varString)) > 0) then
          qryExtGor.ParamByName('TIPREC').AsString := 'ALPE_BOLETO';
      End;

      qryExtGor.ParamByName('TX_PIX').Value := Null;
      qryExtGor.ParamByName('EMPPIX').Value := Null;
      If Not ATxIdPix.IsEmpty Then
      Begin
        qryExtGor.ParamByName('TX_PIX').AsString := ATxIdPix;
        qryExtGor.ParamByName('EMPPIX').AsString := AEmpresaPix;
      End;

      qryExtGor.ParamByName('ABADEP').AsString := IIF(blnAbaDep, 'S', 'N');

      If fEmptyStr(strNumOrigem) Then
      Begin
        qryExtGor.ParamByName('NUMORI').Clear;
        If blnGeraDocOriMesmoNumDoc Then
          qryExtGor.ParamByName('NUMORI').AsString := strNumDoc;
      End
      Else
        qryExtGor.ParamByName('NUMORI').AsString := strNumOrigem;

      If fEmptyStr(strEspOrigem) Then
      Begin
        qryExtGor.ParamByName('ESPORI').Clear;
        If blnGeraDocOriMesmoNumDoc Then
          qryExtGor.ParamByName('ESPORI').AsString := strEspDoc;
      End
      Else
        qryExtGor.ParamByName('ESPORI').AsString := strEspOrigem;

      If fEmptyStr(strEmpOrigem) Then
      Begin
        qryExtGor.ParamByName('EMPORI').Clear;
        If blnGeraDocOriMesmoNumDoc Then
          qryExtGor.ParamByName('EMPORI').AsString := strCodEmp;
      End
      Else
        qryExtGor.ParamByName('EMPORI').AsString := strEmpOrigem;

      qryExtGor.ParamByName('LOC_PD').AsString := IIF(blnLOC_PD, 'S', 'N');

      qryExtGor.ParamByName('COLETA').AsString := IIF(blnColeta, 'S', 'N');

      If (Not fEmptyStr(strObsExp)) Then
        qryExtGor.ParamByName('OBSEXP').AsString := strObsExp;

      If (Not fEmptyStr(strOpeExp)) Then
      Begin
        qryExtGor.ParamByName('OPEEXP').AsString := strOpeExp;
        If (strOriGor = 'AGRUPAMENTO') Then
        Begin
          if dtaDtLbEx = 0 then
            dtaDtLbEx := VS_Date;

          if hraHrLbEx = 0 then
            hraHrLbEx := fRetHoraServidor;
        End;
      End;

      If fEmptyStr(strEmpExpPrioridadeEstoque) then
        qryExtGor.ParamByName('EMPEPE').Clear
      Else
        qryExtGor.ParamByName('EMPEPE').AsString := strEmpExpPrioridadeEstoque;

      {Concreto}
      qryExtGor.ParamByName('CCRPLA').AsString := strPlaVei_;
      qryExtGor.ParamByName('CCRMOT').AsString := strCodMot;
      qryExtGor.ParamByName('CCRBET').AsString := strBetone;
      qryExtGor.ParamByName('CCRLAC').AsString := strLacre_;
      qryExtGor.ParamByName('CCR_CB').AsString := strConBom;
      qryExtGor.ParamByName('CCRFCK').AsInteger := intFckDia;
      qryExtGor.ParamByName('CCRABA').AsString := strAbatim;
      qryExtGor.ParamByName('CCRTIP').AsString := strTipMps;
      qryExtGor.ParamByName('CCRBRI').AsString := strBrita_;
      qryExtGor.ParamByName('CCR_ML').AsString := strTipBom;
      qryExtGor.ParamByName('CCRQTD').AsFloat  := fltQtdBom;
      qryExtGor.ParamByName('CCRVLR').AsFloat  := fltPrcBom;
      qryExtGor.ParamByName('CCRTOT').AsFloat  := fltTotBom;
      qryExtGor.ParamByName('CCROBR').AsString := strCodObr;
      qryExtGor.ParamByName('CCRART').AsString := strCodArt;
      qryExtGor.ParamByName('CODCNO').AsString := strCodCno;
      qryExtGor.ParamByName('INSIMO').AsString := strInsImo;
      qryExtGor.ParamByName('CODCIB').AsString := strCodCib;

      If fEmptyStr(strNumeroDrawback) Then
        qryExtGor.ParamByName('NUMDRW').Value := Null
      Else
        qryExtGor.ParamByName('NUMDRW').AsString := strNumeroDrawback;

      qryExtGor.ParamByName('VALCRE').AsFloat := fltTotCredAutomatico;

      qryExtGor.ParamByName('UPSEML').AsString := IIF(blnUPSEML, 'S', 'N');

      if dtaDtLbEx = 0 then
        qryExtGor.ParamByName('DTLBEX').Clear
      else
        qryExtGor.ParamByName('DTLBEX').AsDateTime := dtaDtLbEx;

      if hraHrLbEx = 0 then
        qryExtGor.ParamByName('HRLBEX').Clear
      else
        qryExtGor.ParamByName('HRLBEX').AsDateTime := hraHrLbEx;

      qryExtGor.ParamByName('FRECOT').AsFloat := fltFreCot;
      qryExtGor.ParamByName('REGES2').AsString := IIF(blnRegEs2, 'S', 'N');

      If (fCfgSis('CDTCLV', varBoolean)) And
         (strEspDoc = 'PD') And
         (Not fEmptyStr(strAutIcv)) Then
      Begin
        qryExtGor.ParamByName('AUTICV').AsString := strAutIcv;
        qryExtGor.ParamByName('CILVAS').AsString := 'S'
      End
      Else
      Begin
        qryExtGor.ParamByName('AUTICV').Value    := Null;
        qryExtGor.ParamByName('CILVAS').AsString := 'N'
      End;

      If (fCfgSis('CDCHAB') = 'S') And
         (intCdcOpo > 0) Then
      begin
        qryExtGor.ParamByName('CDCOPO').AsInteger := intCdcOpo;
        qryExtGor.ParamByName('CDCSTA').AsString  := strCdcSta;
      end
      else
      begin
        qryExtGor.ParamByName('CDCOPO').Value := Null;
        qryExtGor.ParamByName('CDCSTA').Value := Null;
      end;

      If Not fEmptyStr(strFornecedorUsoConsumo) Then
        qryExtGor.ParamByName('FORUCO').AsString := strFornecedorUsoConsumo
      Else
        qryExtGor.ParamByName('FORUCO').Value := Null;

      If Not fEmptyStr(strCentroCustoUsoConsumo) Then
        qryExtGor.ParamByName('CTAUCO').AsString := strCentroCustoUsoConsumo
      Else
        qryExtGor.ParamByName('CTAUCO').Value := Null;

      If Not fEmptyStr(strHistoricoUsoConsumo) Then
        qryExtGor.ParamByName('HISUCO').AsString := strHistoricoUsoConsumo
      Else
        qryExtGor.ParamByName('HISUCO').Value := Null;

      If Not fEmptyStr(strEventoUsoConsumo) Then
        qryExtGor.ParamByName('EVEUCO').AsString := strEventoUsoConsumo
      Else
        qryExtGor.ParamByName('EVEUCO').Value := Null;

      qryExtGor.ParamByName('DESREN').AsString := IIF(blnDesmembrouSaindoDoRegime, 'S', 'N');
      qryExtGor.ParamByName('REGDES').AsString := IIF(blnDesmembraPedRegEsp, 'S', 'N');

       If Not fEmptyStr(strCliCEO) Then
        qryExtGor.ParamByName('CLICEO').AsString := strCliCEO
      Else
        qryExtGor.ParamByName('CLICEO').Value := Null;

      If Not fEmptyStr(strEmpFatSemSaldo) Then
        qryExtGor.ParamByName('FATSSA').AsString := strEmpFatSemSaldo
      Else
        qryExtGor.ParamByName('FATSSA').Value := Null;

      If Not fEmptyStr(strCliTop) Then
        qryExtGor.ParamByName('CLITOP').AsString := strCliTop
      Else
        qryExtGor.ParamByName('CLITOP').Value := Null;

      If Not fEmptyStr(strSupGer) Then
        qryExtGor.ParamByName('SUPGER').AsString := strSupGer
      Else
        qryExtGor.ParamByName('SUPGER').Value := Null;

      If Not fEmptyStr(strSupReg) Then
        qryExtGor.ParamByName('SUPREG').AsString := strSupReg
      Else
        qryExtGor.ParamByName('SUPREG').Value := Null;

      If Not fEmptyStr(strAutRco) Then
        qryExtGor.ParamByName('AUTRCO').AsString := strAutRco
      Else
        qryExtGor.ParamByName('AUTRCO').Value := Null;

      qryExtGor.ParamByName('FATSER').AsFloat := fltFatSer;
      qryExtGor.ParamByName('CANFAT').AsInteger := 0;
      qryExtGor.ParamByName('INTFUS').AsString := IIF(fEmptyStr(strIntFus), 'N', strIntFus);

      If Not fEmptyStr(strSeqSep) Then
        qryExtGor.ParamByName('SEQSEP').AsString := strSeqSep
      Else
        qryExtGor.ParamByName('SEQSEP').Clear;

      If Not fEmptyStr(strSeqOnd) Then
        qryExtGor.ParamByName('SEQOND').AsString := strSeqOnd
      Else
        qryExtGor.ParamByName('SEQOND').Clear;

      if (not fEmptyStr(strOndaOp)) then
        qryExtGor.ParamByName('ONDAOP').AsString := strOndaOp
      else
        qryExtGor.ParamByName('ONDAOP').Clear;

      if (dtaOndaDt = 0) then
        qryExtGor.ParamByName('ONDADT').Clear
      else
        qryExtGor.ParamByName('ONDADT').AsDateTime := dtaOndaDt;

      if (hraOndaHr = 0) then
        qryExtGor.ParamByName('ONDAHR').Clear
      else
        qryExtGor.ParamByName('ONDAHR').AsDateTime := hraOndaHr;

      If fEmptyStr(strPerguntaDevAbaDep) Then
        qryExtGor.ParamByName('PERDAD').Clear
      Else
        qryExtGor.ParamByName('PERDAD').AsString := strPerguntaDevAbaDep;

      qryExtGor.ParamByName('DECZFM').AsFloat := fltDecZfm;
      qryExtGor.ParamByName('CELCON').AsString := strCelCon;

      qryExtGor.ParamByName('UTIAAC').AsString := IIF(blnUtiAbaAutoCredPend, 'S', 'N');

      If fEmptyStr(strAcpCar) Then
        qryExtGor.ParamByName('ACPCAR').Clear
      Else
        qryExtGor.ParamByName('ACPCAR').AsString := strAcpCar;

      qryExtGor.ParamByName('ACPCOM').AsFloat := fltAcpCom;

      If fEmptyStr(strSepAnt) Then
        qryExtGor.ParamByName('SEPANT').Clear
      Else
        qryExtGor.ParamByName('SEPANT').AsString := strSepAnt;

      If (dtaDtaAnt = 0) Then
        qryExtGor.ParamByName('DTSANT').Clear
      Else
        qryExtGor.ParamByName('DTSANT').AsDateTime := dtaDtaAnt;

      If (dtaHraAnt = 0) Then
        qryExtGor.ParamByName('HRSANT').Clear
      Else
        qryExtGor.ParamByName('HRSANT').AsDateTime := dtaHraAnt;

      If fEmptyStr(strVchCdp) Then
        qryExtGor.ParamByName('VCHCDP').Value := Null
      Else
        qryExtGor.ParamByName('VCHCDP').AsString  := strVchCdp;

      If fEmptyStr(strCotLal) Then
        qryExtGor.ParamByName('COTLAL').Value := Null
      Else
        qryExtGor.ParamByName('COTLAL').AsString := strCotLal;

      qryExtGor.ParamByName('TOTCBS').AsFloat := fltTotCbs;
      qryExtGor.ParamByName('TOTIBS').AsFloat := fltTotIbs;
      qryExtGor.ParamByName('TOT_IS').AsFloat := fltTotIs;
      qryExtGor.ExecSQL;

      FreeAndNil(qryExtGor);

      pAtualizaOrigemDocumento;

      If Not fEmptyStr(objServicos.strCodS01) Then
      Begin
        qrySerGor.ParamByName('SEQFGO').AsString := strAutInc;

        For intServico := 1 To 30 Do
        Begin
          If intServico >= 7 Then
          Begin
            If fEmptyStr(GetPropValue(objServicos, 'strCodS' + fStrZero(intServico.ToString, 2))) Then
              qrySerGor.ParamByName('CODS' + fStrZero(intServico.ToString, 2)).Value:= Null
            Else
              qrySerGor.ParamByName('CODS' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strCodS' + fStrZero(intServico.ToString, 2));

            qrySerGor.ParamByName('DESS' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strDesS' + fStrZero(intServico.ToString, 2));
            qrySerGor.ParamByName('VALS' + fStrZero(intServico.ToString, 2)).AsFloat  := GetPropValue(objServicos, 'fltValS' + fStrZero(intServico.ToString, 2));
          End;

          qrySerGor.ParamByName('QTDS' + fStrZero(intServico.ToString, 2)).AsFloat  := GetPropValue(objServicos, 'fltQtdS' + fStrZero(intServico.ToString, 2));
          qrySerGor.ParamByName('UNIS' + fStrZero(intServico.ToString, 2)).AsFloat  := GetPropValue(objServicos, 'fltUniS' + fStrZero(intServico.ToString, 2));
          qrySerGor.ParamByName('CUSS' + fStrZero(intServico.ToString, 2)).AsFloat  := GetPropValue(objServicos, 'fltCusS' + fStrZero(intServico.ToString, 2));
          qrySerGor.ParamByName('DECS' + fStrZero(intServico.ToString, 2)).AsFloat  := GetPropValue(objServicos, 'fltDecS' + fStrZero(intServico.ToString, 2));

          If Not fEmptyStr(GetPropValue(objServicos, 'strStaS' + fStrZero(intServico.ToString, 2))) Then
            qrySerGor.ParamByName('STAS' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strStaS' + fStrZero(intServico.ToString, 2));

          qrySerGor.ParamByName('BRIS' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strBriS' + fStrZero(intServico.ToString, 2));

          If Not fEmptyStr(GetPropValue(objServicos, 'strParS' + fStrZero(intServico.ToString, 2))) Then
            qrySerGor.ParamByName('PARS' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strParS' + fStrZero(intServico.ToString, 2));

          qrySerGor.ParamByName('TBRS' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strTBrS' + fStrZero(intServico.ToString, 2));
          qrySerGor.ParamByName('PRIS' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strPriS' + fStrZero(intServico.ToString, 2));
          qrySerGor.ParamByName('IDES' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strIdeS' + fStrZero(intServico.ToString, 2));

          If Not fEmptyStr(GetPropValue(objServicos, 'strVenS' + fStrZero(intServico.ToString, 2))) Then
            qrySerGor.ParamByName('VENS' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strVenS' + fStrZero(intServico.ToString, 2));

          If Not fEmptyStr(GetPropValue(objServicos, 'strVe2S' + fStrZero(intServico.ToString, 2))) Then
            qrySerGor.ParamByName('VE2S' + fStrZero(intServico.ToString, 2)).AsString := GetPropValue(objServicos, 'strVe2S' + fStrZero(intServico.ToString, 2));

          qrySerGor.ParamByName('CMVS' + fStrZero(intServico.ToString, 2)).AsFloat :=
            fGetValComVendedorServico(GetPropValue(objServicos, 'fltQtdS' + fStrZero(intServico.ToString, 2)),
                                      GetPropValue(objServicos, 'fltUniS' + fStrZero(intServico.ToString, 2)),
                                      GetPropValue(objServicos, 'strVenS' + fStrZero(intServico.ToString, 2)),
                                      GetPropValue(objServicos, 'strCodS' + fStrZero(intServico.ToString, 2)));

          If (fCfgSis('REPVEN', varBoolean)) And (Not fEmptyStr(GetPropValue(objServicos, 'strVe2S' + fStrZero(intServico.ToString, 2)))) Then
          Begin
            qrySerGor.ParamByName('CV2S' + fStrZero(intServico.ToString, 2)).AsFloat :=
              qrySerGor.ParamByName('CMVS' + fStrZero(intServico.ToString, 2)).AsFloat * (fCfgSis('TAXREP', varDouble) / 100);

            qrySerGor.ParamByName('CMVS' + fStrZero(intServico.ToString, 2)).AsFloat :=
              qrySerGor.ParamByName('CMVS' + fStrZero(intServico.ToString, 2)).AsFloat - qrySerGor.ParamByName('CV2S' + fStrZero(intServico.ToString, 2)).AsFloat;
          End
          Else
            qrySerGor.ParamByName('CV2S' + fStrZero(intServico.ToString, 2)).AsFloat := 0;

        End;

        qrySerGor.ParamByName('NROPRO').AsInteger := objServicos.intNroPro;
        qrySerGor.ParamByName('NROCEI').AsString  := objServicos.strNroCEI;

        If objServicos.dtaSerIni > 0 Then
          qrySerGor.ParamByName('SERINI').AsDate := objServicos.dtaSerIni;

        If objServicos.dtaSerFin > 0 Then
          qrySerGor.ParamByName('SERFIN').AsDate := objServicos.dtaSerFin;

        If Not fEmptyStr(objServicos.strSerObs) Then
          qrySerGor.ParamByName('SEROBS').AsString := objServicos.strSerObs;

        If Not fEmptyStr(objServicos.strDisSer) Then
          qrySerGor.ParamByName('DISSER').AsString := objServicos.strDisSer
        Else
          qrySerGor.ParamByName('DISSER').Value := Null;

        qrySerGor.ParamByName('DTAGES').AsDateTime := objServicos.dtaDtAgeS;
        qrySerGor.ParamByName('HRAGES').AsDateTime := objServicos.horHrAgeS;
        qrySerGor.ParamByName('DTENTS').AsDateTime := objServicos.dtaDtEntS;
        qrySerGor.ParamByName('HRENTS').AsDateTime := objServicos.horHrEntS;
        qrySerGor.ParamByName('NATSER').AsString   := objServicos.strNatSer;
        qrySerGor.ParamByName('MUNPRE').AsString   := objServicos.strMunPre;

        qrySerGor.ExecSQL;

        For intServico := 1 To 30 Do
        Begin
          pGravaMecanicosServicoPD(strAutInc , fStrZero(intServico.ToString, 2), GetPropValue(objServicos, 'strMecS' + fStrZero(intServico.ToString, 2)));
          pGravaObservacaoServicoPD(strAutInc, fStrZero(intServico.ToString, 2), GetPropValue(objServicos, 'strObsS' + fStrZero(intServico.ToString, 2)));
        End;
      End;

      FreeAndNil(qrySerGor);

      If (fCfgSis('PAFECF', varBoolean)) Then
      Begin
        If (blnGravarDavPV) Then
        Begin
          pGravaDavPVG(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCgcCon, strNomCom,
            strEndCon, strEstado, strCodFpg, strCodCnd, strCodPor, strBaiCon,
            strCidCon, strTelCon,
            fltTotPro, fltDesEsp, fltTotRet, 0, fltTotFre, fltTotIpi, fltVlrCon,
            fltVPar01, fltVPar02, fltVPar03, fltVPar04, fltVPar05, fltVPar06,
            fltVPar07, fltVPar08, fltVPar09, fltVPar10, fltVPar11, fltVPar12,
            arrDuplic);
        End
        Else
        Begin
          pApagaDavPVG(strNumDoc, strEspDoc, strCodEmp);
        End;
      End;

      If (fCfgSis('USPRRO', varBoolean)) Then
      Begin
        qryRomGer := fCriaQuery(Nil);

        With qryRomGer Do
        Begin
          SQL.Clear;
          SQL.Add('UPDATE ROMGERX               ');
          SQL.Add('SET    GER_NUMDOC = :NUMDOC, ');
          SQL.Add('       GER_ESPDOC = :ESPDOC, ');
          SQL.Add('       GER_CODEMP = :CODEMP, ');
          SQL.Add('       GER_CODVEN = :CODVEN, ');
          SQL.Add('       GER_CODCLI = :CODCLI, ');
          SQL.Add('       GER_TIP_FC = :TIP_FC, ');
          SQL.Add('       GER_DTAENT = :DTAENT, ');
          SQL.Add('       GER_HORENT = :HORENT, ');
          SQL.Add('       GER_CONPAG = :CONPAG, ');
          SQL.Add('       GER_ESTADO = :ESTADO, ');
          SQL.Add('       GER_NOMCON = :NOMCON, ');
          SQL.Add('       GER_ENDCON = :ENDCON, ');
          SQL.Add('       GER_BAICON = :BAICON, ');
          SQL.Add('       GER_CEPCON = :CEPCON, ');
          SQL.Add('       GER_CIDCON = :CIDCON, ');
          SQL.Add('       GER_ESTCON = :ESTCON, ');
          SQL.Add('       GER_TELCON = :TELCON, ');
          SQL.Add('       GER_CGCCPF = :CGCCPF, ');
          SQL.Add('       GER_CGCCON = :CGCCON, ');
          SQL.Add('       GER_IESCON = :IESCON, ');
          SQL.Add('       GER_R_GCON = :R_GCON, ');
          SQL.Add('       GER_BASSIM = :BASSIM, ');
          SQL.Add('       GER_BASIPI = :BASIPI, ');
          SQL.Add('       GER_ALQIPI = :ALQIPI, ');
          SQL.Add('       GER_TOTIPI = :TOTIPI, ');
          SQL.Add('       GER_BASICM = :BASICM, ');
          SQL.Add('       GER_ALQICM = :ALQICM, ');
          SQL.Add('       GER_TOTICM = :TOTICM, ');
          SQL.Add('       GER_TOTRET = :TOTRET, ');
          SQL.Add('       GER_ALQRET = :ALQRET, ');
          SQL.Add('       GER_BASRET = :BASRET, ');
          SQL.Add('       GER_DESESP = :DESESP, ');
          SQL.Add('       GER_VLRCON = :VLRCON, ');
          SQL.Add('       GER_TOTPRO = :TOTPRO, ');
          SQL.Add('       GER_TOTCUS = :TOTCUS, ');
          SQL.Add('       GER_TOTMED = :TOTMED, ');
          SQL.Add('       GER_TIPFRE = :TIPFRE, ');
          SQL.Add('       GER_TOTFRE = :TOTFRE, ');
          SQL.Add('       GER_VOLUME = :VOLUME, ');
          SQL.Add('       GER_ESPECI = :ESPECI, ');
          SQL.Add('       GER_MARCA_ = :MARCA_, ');
          SQL.Add('       GER_MEN001 = :MEN001, ');
          SQL.Add('       GER_MEN002 = :MEN002, ');
          SQL.Add('       GER_TIPFAT = :TIPFAT, ');
          SQL.Add('       GER_NUMFAT = :NUMFAT, ');
          SQL.Add('       GER_DTAFAT = :DTAFAT, ');

          If Not fEmptyStr(strVenFat) Then
            SQL.Add('       GER_VENFAT = :VENFAT, ');

          SQL.Add('       GER_CNDFAT = :CNDFAT, ');
          SQL.Add('       GER_VALFAT = :VALFAT, ');
          SQL.Add('       GER_VPAR01 = :VPAR01, ');
          SQL.Add('       GER_VPAR02 = :VPAR02, ');
          SQL.Add('       GER_VPAR03 = :VPAR03, ');
          SQL.Add('       GER_VPAR04 = :VPAR04, ');
          SQL.Add('       GER_VPAR05 = :VPAR05, ');
          SQL.Add('       GER_VPAR06 = :VPAR06, ');
          SQL.Add('       GER_VPAR07 = :VPAR07, ');
          SQL.Add('       GER_VPAR08 = :VPAR08, ');
          SQL.Add('       GER_VPAR09 = :VPAR09, ');
          SQL.Add('       GER_VPAR10 = :VPAR10, ');
          SQL.Add('       GER_VPAR11 = :VPAR11, ');
          SQL.Add('       GER_VPAR12 = :VPAR12, ');
          SQL.Add('       GER_SERIE_ = :SERIE_, ');
          SQL.Add('       GER_PORDES = :PORDES, ');
          SQL.Add('       GER_CODDIG = :CODDIG, ');
          SQL.Add('       GER_CODCND = :CODCND, ');
          SQL.Add('       GER_CODFPG = :CODFPG, ');
          SQL.Add('       GER_TOTPRO = :TOTPRO, ');
          SQL.Add('       GER_PESLIQ = :PESLIQ, ');
          SQL.Add('       GER_PESBRU = :PESBRU  ');
          SQL.Add('WHERE  GER_NUMDOC = :NUMDOC  ');
          SQL.Add('AND    GER_ESPDOC = :ESPDOC  ');
          SQL.Add('AND    GER_CODEMP = :CODEMP  ');
          SQL.Add('AND    GER_CODCLI = :CODCLI  ');
          SQL.Add('AND    GER_STATUS = "P"      ');

          ParamByName('NUMDOC').AsString   := strNumDoc;
          ParamByName('ESPDOC').AsString   := strEspDoc;
          ParamByName('CODEMP').AsString   := strCodEmp;
          ParamByName('CODVEN').AsString   := strCodVen;
          ParamByName('CODCLI').AsString   := strCodCli;
          ParamByName('TIP_FC').AsString   := 'C';
          ParamByName('DTAENT').AsDatetime := dtaDtaEnt;
          ParamByName('HORENT').AsDatetime := dtaHorEnt;
          ParamByName('CONPAG').AsString   := strConPag;
          ParamByName('ESTADO').AsString   := strEstado;
          ParamByName('NOMCON').AsString   := strNomCom;
          ParamByName('ENDCON').AsString   := strEndCon;
          ParamByName('BAICON').AsString   := strBaiCon;
          ParamByName('CEPCON').AsString   := strCepCon;
          ParamByName('CIDCON').AsString   := strCidCon;
          ParamByName('ESTCON').AsString   := strEstCon;
          ParamByName('TELCON').AsString   := strTelCon;
          ParamByName('CGCCPF').AsString   := strCgcCpf;
          ParamByName('CGCCON').AsString   := strCgcCon;
          ParamByName('IESCON').AsString   := strIesCon;
          ParamByName('R_GCON').AsString   := strCli_Rg;
          ParamByName('BASSIM').AsFloat    := fltBasSim;
          ParamByName('BASIPI').AsFloat    := fltBasIpi;
          ParamByName('ALQIPI').AsFloat    := fltAlqIpi;
          ParamByName('TOTIPI').AsFloat    := fltTotIpi;
          ParamByName('BASICM').AsFloat    := fltBasIcm;
          ParamByName('ALQICM').AsFloat    := fltAlqIcm;
          ParamByName('TOTICM').AsFloat    := fltTotIcm;
          ParamByName('TOTRET').AsFloat    := fltTotRet;
          ParamByName('ALQRET').AsFloat    := fltAlqRet;
          ParamByName('BASRET').AsFloat    := fltBasRet;
          ParamByName('DESESP').AsFloat    := fltDesEsp;
          ParamByName('VLRCON').AsFloat    := fltVlrCon;
          ParamByName('TOTPRO').AsFloat    := fltTotPro;
          ParamByName('TOTCUS').AsFloat    := fltTotCus;
          ParamByName('TOTMED').AsFloat    := fltTotMed;
          ParamByName('TIPFRE').AsString   := strTipFre;
          ParamByName('TOTFRE').AsFloat    := fltTotFre;
          ParamByName('VOLUME').AsFloat    := fltVolume;
          ParamByName('ESPECI').AsString   := strEspeci;
          ParamByName('MARCA_').AsString   := strMarca;
          ParamByName('MEN001').AsString   := strMen001;
          ParamByName('MEN002').AsString   := strMen002;
          ParamByName('TIPFAT').AsString   := strTipFat;
          ParamByName('NUMFAT').AsString   := strNUmFat;
          ParamByName('DTAFAT').AsDatetime := dtaDtaFat;

          If Not fEmptyStr(strVenFat) Then
            ParamByName('VENFAT').AsString   := strVenFat;

          ParamByName('CNDFAT').AsString   := strCndFat;
          ParamByName('VALFAT').AsFloat    := fltValFat;
          ParamByName('VPAR01').AsFloat    := fltVpar01;
          ParamByName('VPAR02').AsFloat    := fltVpar02;
          ParamByName('VPAR03').AsFloat    := fltVpar03;
          ParamByName('VPAR04').AsFloat    := fltVpar04;
          ParamByName('VPAR05').AsFloat    := fltVpar05;
          ParamByName('VPAR06').AsFloat    := fltVpar06;
          ParamByName('VPAR07').AsFloat    := fltVpar07;
          ParamByName('VPAR08').AsFloat    := fltVpar08;
          ParamByName('VPAR09').AsFloat    := fltVpar09;
          ParamByName('VPAR10').AsFloat    := fltVpar10;
          ParamByName('VPAR11').AsFloat    := fltVpar11;
          ParamByName('VPAR12').AsFloat    := fltVpar12;
          ParamByName('SERIE_').AsString   := strSerie;
          ParamByName('PORDES').AsFloat    := fltPorDes;

          If (fEmptyStr(strCodDig)) Then
            ParamByName('CODDIG').Value    := Null
          Else
            ParamByName('CODDIG').AsString := strCodDig;

          ParamByName('CODCND').AsString   := strCodCnd;
          ParamByName('CODFPG').AsString   := strCodFpg;
          ParamByName('TOTPRO').AsFloat    := fltTotPro;
          ParamByName('PESLIQ').AsFloat    := fltPesLiq;
          ParamByName('PESBRU').AsFloat    := fltPesBru;

          ExecSQL;
          fAlteraROMCND(strNumDoc, strEspDoc, strCodCli, strCodEmp, arrDuplic );
        End;

        FreeAndNil(qryRomGer);
      End;

      pReprocessarPedidoFaturamentoAutomatico(strNumDoc, strEspDoc, strCodEmp);

      {**********************************************}
      { ACRESCENTA REGISTRO DE TRANSPORTE/CORREIOS   }
      {*******************************************CH*}

      If fTabelaExiste('FATRTM', True) Then
      Begin
        Try
          strSQL := '';
          strSQL := strSQL + 'INSERT INTO FATRTM ';
          strSQL := strSQL + '(AUTOINCREM, ';
          strSQL := strSQL + ' RTM_CODEMP, ';
          strSQL := strSQL + ' RTM_NUMDOC, ';
          strSQL := strSQL + ' RTM_NUMREG) ';
          strSQL := strSQL + 'VALUES ';
          strSQL := strSQL + '(:AUTOIN, ';
          strSQL := strSQL + ' :CODEMP, ';
          strSQL := strSQL + ' :NUMDOC, ';
          strSQL := strSQL + ' :NUMREG) ';

          qryTblRtm := fCriaQuery;

          qryTblRtm.SQL.Text := strSQL;

          qryTblRtm.ParamByName('AUTOIN').AsString :=fRetAutoIncrem('FATRTM', strCodEmp);
          qryTblRtm.ParamByName('CODEMP').AsString := strCodEmp;
          qryTblRtm.ParamByName('NUMDOC').AsString := strNumDoc;
          qryTblRtm.ParamByName('NUMREG').AsString := strNumReg;

          qryTblRtm.ExecSQL;

          qryTblRtm.SQL.Clear;

          qryTblRtm.SQL.Text := ' UPDATE EXTGOR SET FGO_REGCON = '+QuotedStr(strNumReg) +
                                ' WHERE FGO_SEQFGO = :SEQFGO  ';

          qryTblRtm.ParambyName('SEQFGO').AsString := strAutInc;

          qryTblRtm.ExecSQL;

        Except
          On E: Exception Do
          Begin
            qryTblRtm.Cancel;
          End;
        End;
      End;

      If not fEmptyStr(strIncTer) Then
      Begin
        Try
          strSQL := '';
          strSQL := strSQL + 'INSERT INTO INVOIC ';
          strSQL := strSQL + '(INV_SEQFGO, ';
          strSQL := strSQL + ' INV_INCTER, ';
          strSQL := strSQL + ' INV_PORDES, ';
          strSQL := strSQL + ' INV_POREMB, ';
          strSQL := strSQL + ' INV_AEROPO, ';
          strSQL := strSQL + ' INV_TARIFA, ';
          strSQL := strSQL + ' INV_SEGURO, ';
          strSQL := strSQL + ' INV_FRETE_, ';
          strSQL := strSQL + ' INV_NOTIFY, ';
          strSQL := strSQL + ' INV_EWORKS, ';
          strSQL := strSQL + ' INV_CONTAI, ';
          strSQL := strSQL + ' INV_PACKIN) ';
          strSQL := strSQL + 'VALUES ';
          strSQL := strSQL + '(:SEQFGO, ';
          strSQL := strSQL + ' :INCTER, ';
          strSQL := strSQL + ' :PORDES, ';
          strSQL := strSQL + ' :POREMB, ';
          strSQL := strSQL + ' :AEROPO, ';
          strSQL := strSQL + ' :TARIFA, ';
          strSQL := strSQL + ' :SEGURO, ';
          strSQL := strSQL + ' :FRETE_, ';
          strSQL := strSQL + ' :NOTIFY, ';
          strSQL := strSQL + ' :EWORKS, ';
          strSQL := strSQL + ' :CONTAI, ';
          strSQL := strSQL + ' :PACKIN) ';

          qryInvoic := fCriaQuery;
          qryInvoic.SQL.Text := strSQL;

          qryInvoic.ParamByName('SEQFGO').AsString := strAutInc;
          qryInvoic.ParamByName('INCTER').AsString := strIncTer;

          If not fEmptyStr(strPorDes) Then
            qryInvoic.ParamByName('PORDES').AsString := strPorDes;

          If not fEmptyStr(strPorEmb) Then
            qryInvoic.ParamByName('POREMB').AsString := strPorEmb;

          If not fEmptyStr(strAeropo) Then
            qryInvoic.ParamByName('AEROPO').AsString := strAeropo;

          qryInvoic.ParamByName('TARIFA').AsFloat  := fltTarifa;
          qryInvoic.ParamByName('SEGURO').AsFloat  := fltSeguro;
          qryInvoic.ParamByName('FRETE_').AsFloat  := fltFrete_;
          qryInvoic.ParamByName('NOTIFY').AsString := strNotify;
          qryInvoic.ParamByName('EWORKS').AsString := strEWorks;
          qryInvoic.ParamByName('CONTAI').AsString := strContai;
          qryInvoic.ParamByName('PACKIN').AsString := strPackin;

          qryInvoic.ExecSQL;

        Finally
          FreeAndNil(qryInvoic);
        End;
      End;

      if assigned(cdsExpRet) then
        pRegravarExpRet(strAutInc, cdsExpRet);

    Except
      On E: Exception Do
      Begin
        Result := False;
        qryFatGor.Cancel;
        pMensagensErro(E.Message, '[fGravaFatGor]');
      End;
    End;

  Finally
    {* Atualiza pedido de transferência atrelado *}
    pAtualizaPedidoTransferencia(strNumDoc, strCodEmp);
    FreeAndNil(objServicos);
    FreeAndNil(qryFatGor);
    FreeAndNil(qryTblRtm);
  End;

End;

procedure pGravaDavPVG(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCgcCon,
  strNomCon, strEndCon, strEstado, strCodFpg, strCodCnd, strCodPor, strBaiCon,
  strCidCon, strTelCon: String;
  fltTotPro, fltDesEsp, fltTotRet, fltTotSer, fltTotFre, fltTotIpi, fltVlrCon,
  fltVPar01, fltVPar02, fltVPar03, fltVPar04, fltVPar05, fltVPar06,
  fltVPar07, fltVPar08, fltVPar09, fltVPar10, fltVPar11, fltVPar12: Double;
  arrDuplic: TarrDuplicata);
  Var
    qryDAVPVG: TUniQuery;
    fltTotDup: Double;

    strSQL: string;
    strAutInc: String;
    strNumDavPv: String;

  function fMD5Paf: String;
    Var
      hash: THashDavPvG;
  begin
    hash := THashDavPvG.Create;
    Result := hash.fRetornaSQLMD5;
    FreeAndNil(hash);
  end;
begin
  fltTotDup := fltVPar01 + fltVPar02 + fltVPar03 + fltVPar04 + fltVPar05 + fltVPar06 +
               fltVPar07 + fltVPar08 + fltVPar09 + fltVPar10 + fltVPar11 + fltVPar12;

  qryDAVPVG := fCriaQuery(Nil);

  qryDAVPVG.SQL.Text :=
    ' SELECT AUTOINCREM, DPG_NDAVPV FROM DAVPVG ' +
    ' WHERE ' +
    '   DPG_NUMDOC = :NUMDOC AND ' +
    '   DPG_ESPDOC = :ESPDOC AND ' +
    '   DPG_CODEMP = :CODEMP ';

  qryDAVPVG.ParamByName('NUMDOC').AsString := strNumDoc;
  qryDAVPVG.ParamByName('ESPDOC').AsString := strEspDoc;
  qryDAVPVG.ParamByName('CODEMP').AsString := strCodEmp;

  qryDAVPVG.Open;

  If qryDAVPVG.IsEmpty Then
  Begin
    strAutInc := fRetAutoIncrem('DAVPVG', VS_strCodEmp);
    strNumDavPv := fRetSequencial('PRODAV');
  End
  Else
  Begin
    strAutInc := qryDAVPVG.FieldByName('AUTOINCREM').AsString;
    strNumDavPv := qryDAVPVG.FieldByName('DPG_NDAVPV').AsString;
  End;

  strSQL := '';
  strSQL := strSQL + 'REPLACE INTO DAVPVG (';
  strSQL := strSQL + '  AUTOINCREM, ';
  strSQL := strSQL + '  DPG_NDAVPV, ';
  strSQL := strSQL + '  DPG_NUMDOC, ';
  strSQL := strSQL + '  DPG_ESPDOC, ';
  strSQL := strSQL + '  DPG_CODEMP, ';
  strSQL := strSQL + '  DPG_CODCLI, ';
  strSQL := strSQL + '  DPG_DTAENT, ';
  strSQL := strSQL + '  DPG_CGCCON, ';
  strSQL := strSQL + '  DPG_NOMCON, ';
  strSQL := strSQL + '  DPG_ENDCON, ';
  strSQL := strSQL + '  DPG_BAICON, ';
  strSQL := strSQL + '  DPG_CIDCON, ';
  strSQL := strSQL + '  DPG_ESTADO, ';
  strSQL := strSQL + '  DPG_TELCON, ';
  strSQL := strSQL + '  DPG_JAFATU, ';
  strSQL := strSQL + '  DPG_CODFPG, ';
  strSQL := strSQL + '  DPG_CODCND, ';
  strSQL := strSQL + '  DPG_CODPOR, ';

  strSQL := strSQL + '  DPG_TOTPRO, ';
  strSQL := strSQL + '  DPG_DESESP, ';
  strSQL := strSQL + '  DPG_TOTRET, ';
  strSQL := strSQL + '  DPG_TOTSER, ';
  strSQL := strSQL + '  DPG_TOTFRE, ';
  strSQL := strSQL + '  DPG_TOTIPI, ';
  strSQL := strSQL + '  DPG_VLRCON, ';
  strSQL := strSQL + '  DPG_TOTDUP, ';

  strSQL := strSQL + '  DPG_VPAR01, ';
  strSQL := strSQL + '  DPG_VPAR02, ';
  strSQL := strSQL + '  DPG_VPAR03, ';
  strSQL := strSQL + '  DPG_VPAR04, ';
  strSQL := strSQL + '  DPG_VPAR05, ';
  strSQL := strSQL + '  DPG_VPAR06, ';
  strSQL := strSQL + '  DPG_VPAR07, ';
  strSQL := strSQL + '  DPG_VPAR08, ';
  strSQL := strSQL + '  DPG_VPAR09, ';
  strSQL := strSQL + '  DPG_VPAR10, ';
  strSQL := strSQL + '  DPG_VPAR11, ';
  strSQL := strSQL + '  DPG_VPAR12, ';

  strSQL := strSQL + '  DPG_MD5PAF ';

  strSQL := strSQL + ') VALUE ( ';
  strSQL := strSQL + '  :AUTINC, ';
  strSQL := strSQL + '  :NDAVPV, ';
  strSQL := strSQL + '  :NUMDOC, ';
  strSQL := strSQL + '  :ESPDOC, ';
  strSQL := strSQL + '  :CODEMP, ';
  strSQL := strSQL + '  :CODCLI, ';
  strSQL := strSQL + '  :DTAENT, ';
  strSQL := strSQL + '  :CGCCON, ';
  strSQL := strSQL + '  :NOMCON, ';
  strSQL := strSQL + '  :ENDCON, ';
  strSQL := strSQL + '  :BAICON, ';
  strSQL := strSQL + '  :CIDCON, ';
  strSQL := strSQL + '  :ESTADO, ';
  strSQL := strSQL + '  :TELCON, ';
  strSQL := strSQL + '  :JAFATU, ';
  strSQL := strSQL + '  :CODFPG, ';
  strSQL := strSQL + '  :CODCND, ';
  strSQL := strSQL + '  :CODPOR, ';

  strSQL := strSQL + '  :TOTPRO, ';
  strSQL := strSQL + '  :DESESP, ';
  strSQL := strSQL + '  :TOTRET, ';
  strSQL := strSQL + '  :TOTSER, ';
  strSQL := strSQL + '  :TOTFRE, ';
  strSQL := strSQL + '  :TOTIPI, ';
  strSQL := strSQL + '  :VLRCON, ';
  strSQL := strSQL + '  :TOTDUP, ';

  strSQL := strSQL + '  :VPAR01, ';
  strSQL := strSQL + '  :VPAR02, ';
  strSQL := strSQL + '  :VPAR03, ';
  strSQL := strSQL + '  :VPAR04, ';
  strSQL := strSQL + '  :VPAR05, ';
  strSQL := strSQL + '  :VPAR06, ';
  strSQL := strSQL + '  :VPAR07, ';
  strSQL := strSQL + '  :VPAR08, ';
  strSQL := strSQL + '  :VPAR09, ';
  strSQL := strSQL + '  :VPAR10, ';
  strSQL := strSQL + '  :VPAR11, ';
  strSQL := strSQL + '  :VPAR12, ';

  strSQL := strSQL + '  ' + fMD5Paf + ') ';

  qryDAVPVG.SQL.Text := strSQL;

  qryDAVPVG.ParamByName('AUTINC').AsString   := strAutInc;
  qryDAVPVG.ParamByName('NDAVPV').AsString   := strNumDavPv;
  qryDAVPVG.ParamByName('NUMDOC').AsString   := strNumDoc;
  qryDAVPVG.ParamByName('ESPDOC').AsString   := strEspDoc;
  qryDAVPVG.ParamByName('CODEMP').AsString   := strCodEmp;
  qryDAVPVG.ParamByName('CODCLI').AsString   := strCodCli;
  qryDAVPVG.ParamByName('DTAENT').AsDateTime := VS_Date;
  qryDAVPVG.ParamByName('CGCCON').AsString   := strCgcCon;
  qryDAVPVG.ParamByName('NOMCON').AsString   := strNomCon;
  qryDAVPVG.ParamByName('ENDCON').AsString   := strEndCon;
  qryDAVPVG.ParamByName('BAICON').AsString   := strBaiCon;
  qryDAVPVG.ParamByName('CIDCON').AsString   := strCidCon;
  qryDAVPVG.ParamByName('ESTADO').AsString   := strEstado;
  qryDAVPVG.ParamByName('TELCON').AsString   := strTelCon;
  qryDAVPVG.ParamByName('JAFATU').AsInteger  := 0;
  qryDAVPVG.ParamByName('CODFPG').AsString   := strCodFpg;
  qryDAVPVG.ParamByName('CODCND').AsString   := strCodCnd;
  qryDAVPVG.ParamByName('CODPOR').AsString   := strCodPor;

  qryDAVPVG.ParamByName('TOTPRO').AsFloat    := fltTotPro;
  qryDAVPVG.ParamByName('DESESP').AsFloat    := fltDesEsp;
  qryDAVPVG.ParamByName('TOTRET').AsFloat    := fltTotRet;
  qryDAVPVG.ParamByName('TOTSER').AsFloat    := fltTotSer;
  qryDAVPVG.ParamByName('TOTFRE').AsFloat    := fltTotFre;
  qryDAVPVG.ParamByName('TOTIPI').AsFloat    := fltTotIpi;
  qryDAVPVG.ParamByName('VLRCON').AsFloat    := fltVlrCon;

  qryDAVPVG.ParamByName('VPAR01').AsFloat    := fltVPar01;
  qryDAVPVG.ParamByName('VPAR02').AsFloat    := fltVPar02;
  qryDAVPVG.ParamByName('VPAR03').AsFloat    := fltVPar03;
  qryDAVPVG.ParamByName('VPAR04').AsFloat    := fltVPar04;
  qryDAVPVG.ParamByName('VPAR05').AsFloat    := fltVPar05;
  qryDAVPVG.ParamByName('VPAR06').AsFloat    := fltVPar06;
  qryDAVPVG.ParamByName('VPAR07').AsFloat    := fltVPar07;
  qryDAVPVG.ParamByName('VPAR08').AsFloat    := fltVPar08;
  qryDAVPVG.ParamByName('VPAR09').AsFloat    := fltVPar09;
  qryDAVPVG.ParamByName('VPAR10').AsFloat    := fltVPar10;
  qryDAVPVG.ParamByName('VPAR11').AsFloat    := fltVPar11;
  qryDAVPVG.ParamByName('VPAR12').AsFloat    := fltVPar12;
  // Quando for fazer o PDV precisa calcular a fltTotDup usando o arrDuplic
  qryDAVPVG.ParamByName('TOTDUP').AsFloat    := fltTotDup;

  qryDAVPVG.ExecSQL;

  fGravaDAVCND(strAutInc, arrDuplic );

  FreeAndNil(qryDAVPVG);
end;

procedure pGravaDavPVD(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte, strDescri: String;
  fltQtdIte, fltUnitar, fltTotIte, fltDesEsp: Double; strCodUni, strCodFis: String;
  fltAlqIcm: Double; strCodAca, strEmpAca, strIteEmb, strNumLot: String;
  intSeqInd: Integer);
  Var
    qryDAVPVD: TUniQuery;
    strSeqGer: String;
    strSQL: string;

  function fMD5Paf: String;
    Var
      hash: THashDavPvD;
  begin
    hash := THashDavPvD.Create;
    Result := hash.fRetornaSQLMD5;
    FreeAndNil(hash);
  end;

  function fRetSeqGer: String;
    Var
      qryAux: TUniQuery;
  begin
    qryAux := fCriaQuery(Nil);
    qryAux.SQL.Text :=
      ' SELECT AUTOINCREM FROM DAVPVG WHERE ' +
      '   DPG_NUMDOC = :NUMDOC AND ' +
      '   DPG_ESPDOC = :ESPDOC AND ' +
      '   DPG_CODEMP = :CODEMP AND ' +
      '   DPG_CODCLI = :CODCLI ';

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString := strCodCli;

    qryAux.Open;

    Result := qryAux.FieldByName('AUTOINCREM').AsString;

    FreeAndNil(qryAux);
  end;
begin

  strSeqGer := fRetSeqGer;
  If fEmptyStr(strSeqGer) Then
  Begin
    Exit;
  End;

  strSQL := '';
  strSQL := strSQL + 'INSERT INTO DAVPVD (';
  strSQL := strSQL + '  AUTOINCREM, ';
  strSQL := strSQL + '  DPD_SEQGER, ';
  strSQL := strSQL + '  DPD_CODEMP, ';
  strSQL := strSQL + '  DPD_CODITE, ';
  strSQL := strSQL + '  DPD_DESCRI, ';
  strSQL := strSQL + '  DPD_QTDITE, ';
  strSQL := strSQL + '  DPD_UNITAR, ';
  strSQL := strSQL + '  DPD_TOTITE, ';
  strSQL := strSQL + '  DPD_DESESP, ';
  strSQL := strSQL + '  DPD_CODUNI, ';

  strSQL := strSQL + '  DPD_CANCEL, ';
  strSQL := strSQL + '  DPD_CODFIS, ';
  strSQL := strSQL + '  DPD_DTAENT, ';
  strSQL := strSQL + '  DPD_ALQICM, ';

  strSQL := strSQL + '  DPD_CODACA, ';
  strSQL := strSQL + '  DPD_EMPACA, ';
  strSQL := strSQL + '  DPD_ITEEMB, ';
  strSQL := strSQL + '  DPD_NUMLOT, ';
  strSQL := strSQL + '  DPD_SEQIND, ';

  strSQL := strSQL + '  DPD_MD5PAF ';
  strSQL := strSQL + ') VALUE ( ';
  strSQL := strSQL + '  :AUTINC, ';
  strSQL := strSQL + '  :SEQGER, ';
  strSQL := strSQL + '  :CODEMP, ';
  strSQL := strSQL + '  :CODITE, ';
  strSQL := strSQL + '  :DESCRI, ';
  strSQL := strSQL + '  :QTDITE, ';
  strSQL := strSQL + '  :UNITAR, ';
  strSQL := strSQL + '  :TOTITE, ';
  strSQL := strSQL + '  :DESESP, ';
  strSQL := strSQL + '  :CODUNI, ';

  strSQL := strSQL + '  :CANCEL, ';
  strSQL := strSQL + '  :CODFIS, ';
  strSQL := strSQL + '  :DTAENT, ';
  strSQL := strSQL + '  :ALQICM, ';

  strSQL := strSQL + '  :CODACA, ';
  strSQL := strSQL + '  :EMPACA, ';
  strSQL := strSQL + '  :ITEEMB, ';
  strSQL := strSQL + '  :NUMLOT, ';
  strSQL := strSQL + '  :SEQIND, ';

  strSQL := strSQL + '  ' + fMD5Paf + ') ';

  qryDAVPVD := fCriaQuery(Nil);
  qryDAVPVD.SQL.Text := strSQL;

  qryDAVPVD.ParamByName('AUTINC').AsString := fRetAutoIncrem('DAVPVD', VS_strCodEmp);
  qryDAVPVD.ParamByName('SEQGER').AsString := strSeqGer;
  qryDAVPVD.ParamByName('CODEMP').AsString := strCodEmp;
  qryDAVPVD.ParamByName('CODITE').AsString := strCodIte;
  qryDAVPVD.ParamByName('DESCRI').AsString := strDescri;
  qryDAVPVD.ParamByName('QTDITE').AsFloat  := fltQtdIte;
  qryDAVPVD.ParamByName('UNITAR').AsFloat  := fltUnitar;
  qryDAVPVD.ParamByName('TOTITE').AsFloat  := fltTotIte;
  qryDAVPVD.ParamByName('DESESP').AsFloat  := fltDesEsp;
  qryDAVPVD.ParamByName('CODUNI').AsString := strCodUni;

  qryDAVPVD.ParamByName('CANCEL').AsInteger := 0;
  qryDAVPVD.ParamByName('CODFIS').AsString := strCodFis;
  qryDAVPVD.ParamByName('DTAENT').AsDateTime := VS_Date;
  qryDAVPVD.ParamByName('ALQICM').AsFloat := fltAlqIcm;

  qryDAVPVD.ParamByName('CODACA').AsString := strCodAca;
  qryDAVPVD.ParamByName('EMPACA').AsString := strEmpAca;
  qryDAVPVD.ParamByName('ITEEMB').AsString := strIteEmb;
  qryDAVPVD.ParamByName('NUMLOT').AsString := strNumLot;
  qryDAVPVD.ParamByName('SEQIND').AsInteger := intSeqInd;

  qryDAVPVD.ExecSQL;

  FreeAndNil(qryDAVPVD);
end;

procedure pApagaDavPVG(strNumDoc, strEspDoc, strCodEmp: String);
  Var
    qryDel: TUniQuery;
begin
  qryDel := fCriaQuery;
  Try
    qryDel.SQL.Text :=
      ' DELETE ' +
      '   FROM DAVPVG ' +
      '  WHERE DPG_NUMDOC = :NUMDOC ' +
      '    AND DPG_ESPDOC = :ESPDOC ' +
      '    AND DPG_CODEMP = :CODEMP ';
    qryDel.ParamByName('NUMDOC').AsString := strNumDoc;
    qryDel.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDel.ParamByName('CODEMP').AsString := strCodEmp;
    qryDel.ExecSQL;
  Finally
    FreeAndNil(qryDel);
  End;
end;

procedure pAtualizaDadosConsumidor(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCgcCon,
  strNomCon, strEndCon, strBaiCon, strCepCon, strCidCon, strEstCon, strTelCon,
  strCgcCpf, strIesCon, strCli_Rg, strEmlCon, strCodAti: String; dtaNasCon: TDate);
  Var
    strSQL: string;
    qryUpdate: TUniQuery;
begin
  If Not fClienteConsumidor(fRetNomCliente(strCodCli), True, True) Then
    Exit;

  qryUpdate := fCriaQuery();
  Try
    strSQL := '';
    strSQL := strSQL + ' UPDATE FATGOR, EXTGOR SET';
    strSQL := strSQL + '   FGO_NOMCON = :NOMCON,';
    strSQL := strSQL + '   FGO_ENDCON = :ENDCON,';
    strSQL := strSQL + '   FGO_BAICON = :BAICON,';
    strSQL := strSQL + '   FGO_CEPCON = :CEPCON,';
    strSQL := strSQL + '   FGO_CIDCON = :CIDCON,';
    strSQL := strSQL + '   FGO_ESTCON = :ESTCON,';
    strSQL := strSQL + '   FGO_TELCON = :TELCON,';
    strSQL := strSQL + '   FGO_NASCON = :NASCON,';
    strSQL := strSQL + '   FGO_CGCCPF = :CGCCPF,';
    strSQL := strSQL + '   FGO_CGCCON = :CGCCON,';
    strSQL := strSQL + '   FGO_IESCON = :IESCON,';
    strSQL := strSQL + '   FGO_R_GCON = :CLI_RG,';
    strSQL := strSQL + '   FGO_EMLCON = :EMLCON,';
    strSQL := strSQL + '   FGO_CODATI = :CODATI ';
    strSQL := strSQL + ' WHERE FGO_NUMDOC = :NUMDOC';
    strSQL := strSQL + '   AND FGO_ESPDOC = :ESPDOC';
    strSQL := strSQL + '   AND FGO_CODEMP = :CODEMP';
    strSQL := strSQL + '   AND FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ';

    qryUpdate.SQL.Text := strSQL;

    qryUpdate.ParamByName('NOMCON').AsString := strNomCon;
    qryUpdate.ParamByName('ENDCON').AsString := strEndCon;
    qryUpdate.ParamByName('BAICON').AsString := strBaiCon;
    qryUpdate.ParamByName('CEPCON').AsString := strCepCon;
    qryUpdate.ParamByName('CIDCON').AsString := strCidCon;
    qryUpdate.ParamByName('ESTCON').AsString := strEstCon;
    qryUpdate.ParamByName('TELCON').AsString := strTelCon;
    If dtaNasCon > 0 Then
      qryUpdate.ParamByName('NASCON').AsDateTime := dtaNasCon
    Else
      qryUpdate.ParamByName('NASCON').Value := Null;
    qryUpdate.ParamByName('CGCCPF').AsString := strCgcCpf;
    qryUpdate.ParamByName('CGCCON').AsString := strCgcCon;

    If (strCgcCpf = '2') Then
    Begin
      qryUpdate.ParamByName('IESCON').AsString := '';
      qryUpdate.ParamByName('CLI_RG').AsString := strCli_Rg;
    End
    Else
    Begin
      qryUpdate.ParamByName('IESCON').AsString := strIesCon;
      qryUpdate.ParamByName('CLI_RG').AsString := '';
    End;

    qryUpdate.ParamByName('EMLCON').AsString := strEmlCon;
    qryUpdate.ParamByName('NUMDOC').AsString := strNumDoc;
    qryUpdate.ParamByName('ESPDOC').AsString := strEspDoc;
    qryUpdate.ParamByName('CODEMP').AsString := strCodEmp;
    If fEmptyStr(strCodAti) Then
      qryUpdate.ParamByName('CODATI').Value := Null
    Else
      qryUpdate.ParamByName('CODATI').AsString := strCodAti;

    qryUpdate.ExecSQL;
  Finally
    FreeAndNil(qryUpdate);
  End;
end;

procedure pAtualizaPedidoTransferencia(strNumDoc, strCodEmp: String);
Var
  strSQL: string;
  qryPedTransf: TUniQuery;
  qryExecUpdt: TUniQuery;
begin
  qryPedTransf := fCriaQuery(nil);
  qryExecUpdt  := fCriaQuery(nil);

  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT FG.FGO_NUMDOC, FG.FGO_ESPDOC, FG.FGO_CODEMP, FG.FGO_CODCLI';
    strSQL := strSQL + '  FROM EXTGOR EG                                                 ';
    strSQL := strSQL + '  JOIN FATGOR FG ON EG.FGO_SEQFGO = FG.AUTOINCREM                ';
    strSQL := strSQL + ' WHERE EG.FGO_NMPDAB = :NUMDOC                                   ';
    strSQL := strSQL + '   AND EG.FGO_ESPDAB = "PD"                                      ';
    strSQL := strSQL + '   AND EG.FGO_EMPDAB = :CODEMP                                   ';
    strSQL := strSQL + '   AND IFNULL(FGO_DOCEND,  "") = ""                              ';
    strSQL := strSQL + '   AND FGO_ENVLIB = "N"                                          ';
    strSQL := strSQL + '   AND FGO_VLRCON > 0                                            ';
    strSQL := strSQL + '   AND FGO_VLRCON > 0                                            ';
    strSQL := strSQL + '   AND FG.FGO_JAFATU = 0                                         ';
    strSQL := strSQL + '   AND (IFNULL(FGO_LIBERA, 0) = 0                                ';
    strSQL := strSQL + '        OR IFNULL(FGO_LIBCOM, 0) = 0)                            ';

    qryPedTransf.SQL.Text := strSQL;

    qryPedTransf.ParamByName('NUMDOC').AsString := strNumDoc;
    qryPedTransf.ParamByName('CODEMP').AsString := strCodEmp;

    qryPedTransf.Open;

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  EXTGOR E INNER JOIN FATGOR F ON F.AUTOINCREM = E.FGO_SEQFGO ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  E.FGO_ENVLIB = "S"       ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  F.FGO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  F.FGO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  F.FGO_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  F.FGO_CODCLI = :CODCLI ';

    qryExecUpdt.SQL.Text := strSQL;

    While Not qryPedTransf.Eof Do
    Begin
      qryExecUpdt.Close;
      qryExecUpdt.ParamByName('NUMDOC').AsString   := qryPedTransf.FieldByName('FGO_NUMDOC').AsString;
      qryExecUpdt.ParamByName('ESPDOC').AsString   := qryPedTransf.FieldByName('FGO_ESPDOC').AsString;
      qryExecUpdt.ParamByName('CODEMP').AsString   := qryPedTransf.FieldByName('FGO_CODEMP').AsString;
      qryExecUpdt.ParamByName('CODCLI').AsString   := qryPedTransf.FieldByName('FGO_CODCLI').AsString;
      qryExecUpdt.ExecSQL;
      qryPedTransf.Next;
    End;
  Finally
    FreeAndNil(qryPedTransf);
    FreeAndNil(qryExecUpdt);
  End;
end;

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
                      fltQtdAti: Double  = 0;
                      fltQtdCom: Double  = 0;
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
                      strNumPla: STring = '';
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
  Var
    qryFatDor: TUniQuery;
    qryExtDor: TUniQuery;
    qryBriDor: TUniQuery;
    strSQL: string;
    LEmpresa: String;
    LEmpresas: TArray<String>;
    LSubItem: String;
    LSubItens: TArray<String>;
    blnPedidoOrigemSite,
    blnSomaTotFreDesAce: Boolean;

    objPromocaoLimitePorClienteOuVenda : TPromocaoLimitePorClienteOuVenda;

Begin

  Try
    Try
      Result := True;

      strSQL := '';
      strSQL := strSQL + 'INSERT INTO ';
      strSQL := strSQL + '  EXTDOR ';
      strSQL := strSQL + '( ';
      strSQL := strSQL + '  FDO_SEQFDO, ';
      strSQL := strSQL + '  FDO_UNIVIS, ';
      strSQL := strSQL + '  FDO_VAL_RT, ';
      strSQL := strSQL + '  FDO_TAXJUR, ';
      strSQL := strSQL + '  FDO_EMPFOR, ';
      strSQL := strSQL + '  FDO_ENTRET, '; // (E)NTREGA (R)ETIRA
      strSQL := strSQL + '  FDO_LOCRET, '; // (C)AIXA (E)XPEDICAO
      strSQL := strSQL + '  FDO_DTENTR, ';
      strSQL := strSQL + '  FDO_FRESUG, ';
      strSQL := strSQL + '  FDO_FRERAT, ';
      strSQL := strSQL + '  FDO_TAXENT, ';
      strSQL := strSQL + '  FDO_QTDEXP, ';
      strSQL := strSQL + '  FDO_NUMCMP, ';
      strSQL := strSQL + '  FDO_NITCMP, ';
      strSQL := strSQL + '  FDO_DTACMP, ';
      strSQL := strSQL + '  FDO_SEQRCD, ';
      strSQL := strSQL + '  FDO_SEQINC, ';
      strSQL := strSQL + '  FDO_ORDITE, ';
      strSQL := strSQL + '  FDO_BAREMB, ';
      strSQL := strSQL + '  FDO_ALTPCO, ';
      strSQL := strSQL + '  FDO_CLIBUS, ';
      strSQL := strSQL + '  FDO_TURENT, ';
      strSQL := strSQL + '  FDO_INSALT, ';
      strSQL := strSQL + '  FDO_SERRAT, ';
      strSQL := strSQL + '  FDO_SEQOPI, ';
      strSQL := strSQL + '  FDO_BAIOPI, ';
      strSQL := strSQL + '  FDO_LOTABA, ';
      strSQL := strSQL + '  FDO_LOTANT, ';
      strSQL := strSQL + '  FDO_INCFUT, ';
      strSQL := strSQL + '  FDO_SEPEXP, ';
      strSQL := strSQL + '  FDO_PESLIQ, ';
      strSQL := strSQL + '  FDO_PESBRU, ';
      strSQL := strSQL + '  FDO_PIGBAS, ';
      strSQL := strSQL + '  FDO_INCDEV, ';
      strSQL := strSQL + '  FDO_DESMAX, ';
      strSQL := strSQL + '  FDO_VALFLE, ';
      strSQL := strSQL + '  FDO_PEGOU_, ';
      strSQL := strSQL + '  FDO_BAQTZE, ';
      strSQL := strSQL + '  FDO_ATIVAC, ';
      strSQL := strSQL + '  FDO_SEQCOM, ';
      strSQL := strSQL + '  FDO_QTDATI, ';
      strSQL := strSQL + '  FDO_QTDCOM, ';
      strSQL := strSQL + '  FDO_TABCOM, ';
      strSQL := strSQL + '  FDO_ICMPAV, ';
      strSQL := strSQL + '  FDO_VALFCP, ';
      strSQL := strSQL + '  FDO_ICMSAI, ';
      strSQL := strSQL + '  FDO_IMPFED, ';
      strSQL := strSQL + '  FDO_DESOPE, ';
      strSQL := strSQL + '  FDO_AUTDET, ';
      strSQL := strSQL + '  FDO_DESNES, ';
      strSQL := strSQL + '  TRI_NCMTIN, ';
      strSQL := strSQL + '  FDO_NOTC17, ';

      If fltQtdSep > 0 Then
        strSQL := strSQL + ' FDO_QTDSEP, ';

      If (Not fEmptyStr(strOpeSep)) Then
        strSQL := strSQL + ' FDO_OPESEP, ';

      If (Not fEmptyStr(strOpeExp)) Then
        strSQL := strSQL + ' FDO_OPEEXP, ';

      strSQL := strSQL + '  FDO_DESCND, ';
      strSQL := strSQL + '  FDO_QDENTR, ';
      strSQL := strSQL + '  FDO_PROESP, ';
      strSQL := strSQL + '  FDO_CODCMG, ';
      strSQL := strSQL + '  FDO_SEQEST, ';
      strSQL := strSQL + '  FDO_ITEEST, ';
      strSQL := strSQL + '  FDO_UNIEST, ';
      strSQL := strSQL + '  FDO_QTDSBI, ';
      strSQL := strSQL + '  FDO_UNISBI, ';
      strSQL := strSQL + '  FDO_FREMKP, ';
      strSQL := strSQL + '  FDO_COMMKP, ';
      strSQL := strSQL + '  FDO_VENCBO, ';
      strSQL := strSQL + '  FDO_UNIDOL, ';
      strSQL := strSQL + '  FDO_TOTDOL, ';
      strSQL := strSQL + '  FDO_QTDRCO, ';
      strSQL := strSQL + '  FDO_OBSRCO, ';
      strSQL := strSQL + '  FDO_EXIBSE, ';
      strSQL := strSQL + '  FDO_CODPRO, ';
      strSQL := strSQL + '  FDO_PROKIT, ';
      strSQL := strSQL + '  FDO_OPBXSE, ';
      strSQL := strSQL + '  FDO_DTBXSE, ';
      strSQL := strSQL + '  FDO_HRBXSE, ';
      strSQL := strSQL + '  FDO_EMPCAR, ';
      strSQL := strSQL + '  FDO_TEMNSE, ';
      strSQL := strSQL + '  FDO_RESERV, ';

      if (not fEmptyStr(strNumLot)) and (strNumLot <> 'A DEFINIR') and (fCfgSis('TIPEXP', varInteger) = 5) And fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis then
      begin
        strSQL := strSQL + '  FDO_INFLOT, ';
      end;

      strSQL := strSQL + '  FDO_TIPREC, ';
      strSQL := strSQL + '  FDO_VDESST, ';
      strSQL := strSQL + '  FDO_NUMPLA, ';
      strSQL := strSQL + '  FDO_PARNUM, ';
      strSQL := strSQL + '  FDO_REQCOM, ';
      strSQL := strSQL + '  FDO_REGESP, ';
      If Not fEmptyStr(strSeqEql) Then
        strSQL := strSQL + '  FDO_SEQEQL, ';

      strSQL := strSQL + '  FDO_MDESST, ';
      strSQL := strSQL + '  FDO_SEQINV, ';
      strSQL := strSQL + '  FDO_NUMDRW, ';
      strSQL := strSQL + '  FDO_MNTPRC, ';
      strSQL := strSQL + '  FDO_QTDRET, ';
      strSQL := strSQL + '  FDO_AUTEND, ';
      strSQL := strSQL + '  FDO_FRECOT, ';
      strSQL := strSQL + '  FDO_ALTEST, ';
      strSQL := strSQL + '  FDO_RATEST, ';
      strSQL := strSQL + '  FDO_SEQPER, ';
      strSQL := strSQL + '  FDO_DOCORI, ';
      strSQL := strSQL + '  FDO_ESPORI, ';
      strSQL := strSQL + '  FDO_EMPORI, ';
      strSQL := strSQL + '  FDO_EMPDMP, ';
      strSQL := strSQL + '  FDO_UNDIDE, ';
      strSQL := strSQL + '  FDO_CUBAGE, ';
      strSQL := strSQL + '  FDO_NOTESP, ';
      strSQL := strSQL + '  FDO_FREENT, ';
      strSQL := strSQL + '  FDO_ACPPRO, ';
      strSQL := strSQL + '  FDO_ACPTXC, ';
      strSQL := strSQL + '  FDO_ACPVCT, ';
      strSQL := strSQL + '  FDO_ACPRES, ';
      strSQL := strSQL + '  FDO_ACPMAR, ';
      strSQL := strSQL + '  FDO_OUTVAL, ';
      strSQL := strSQL + '  FDO_BASTRO, ';
      strSQL := strSQL + '  FDO_TCKQBT, ';
      strSQL := strSQL + '  FDO_SOMCOL, ';
      strSQL := strSQL + '  FDO_VALPIS, ';
      strSQL := strSQL + '  FDO_VALCOF, ';
      strSQL := strSQL + '  FDO_SEQPRE) ';
      strSQL := strSQL + 'VALUES ( ';
      strSQL := strSQL + '  :SEQFDO, ';
      strSQL := strSQL + '  :UNIVIS, ';
      strSQL := strSQL + '  :VAL_RT, ';
      strSQL := strSQL + '  :TAXJUR, ';
      strSQL := strSQL + '  :EMPFOR, ';
      strSQL := strSQL + '  :ENTRET, ';
      strSQL := strSQL + '  :LOCRET, ';
      strSQL := strSQL + '  :DTENTR, ';
      strSQL := strSQL + '  :FRESUG, ';
      strSQL := strSQL + '  :FRERAT, ';
      strSQL := strSQL + '  :TAXENT, ';
      strSQL := strSQL + '  :QTDEXP, ';
      strSQL := strSQL + '  :NUMCMP, ';
      strSQL := strSQL + '  :NITCMP, ';
      strSQL := strSQL + '  :DTACMP, ';
      strSQL := strSQL + '  :SEQRCD, ';
      strSQL := strSQL + '  :SEQINC, ';
      strSQL := strSQL + '  :ORDITE, ';
      strSQL := strSQL + '  :BAREMB, ';
      strSQL := strSQL + '  :ALTPCO, ';
      strSQL := strSQL + '  :CLIBUS, ';
      strSQL := strSQL + '  :TURENT, ';
      strSQL := strSQL + '  :INSALT, ';
      strSQL := strSQL + '  :SERRAT, ';
      strSQL := strSQL + '  :SEQOPI, ';
      strSQL := strSQL + '  :BAIOPI, ';
      strSQL := strSQL + '  :LOTABA, ';
      strSQL := strSQL + '  :LOTANT, ';
      strSQL := strSQL + '  :INCFUT, ';
      strSQL := strSQL + '  :SEPEXP, ';
      strSQL := strSQL + '  :PESLIQ, ';
      strSQL := strSQL + '  :PESBRU, ';
      strSQL := strSQL + '  :PIGBAS, ';
      strSQL := strSQL + '  :INCDEV, ';
      strSQL := strSQL + '  :DESMAX, ';
      strSQL := strSQL + '  :VALFLE, ';
      strSQL := strSQL + '  :PEGOU_, ';
      strSQL := strSQL + '  :BAQTZE, ';
      strSQL := strSQL + '  :ATIVAC, ';
      strSQL := strSQL + '  :SEQCOM, ';
      strSQL := strSQL + '  :QTDATI, ';
      strSQL := strSQL + '  :QTDCOM, ';
      strSQL := strSQL + '  :TABCOM, ';
      strSQL := strSQL + '  :ICMPAV, ';
      strSQL := strSQL + '  :VALFCP, ';
      strSQL := strSQL + '  :ICMSAI, ';
      strSQL := strSQL + '  :IMPFED, ';
      strSQL := strSQL + '  :DESOPE, ';
      strSQL := strSQL + '  :AUTDET, ';
      strSQL := strSQL + '  :DESNES, ';
      strSQL := strSQL + '  :NCMTIN, ';
      strSQL := strSQL + '  :NOTC17, ';

      If fltQtdSep > 0 Then
       strSQL := strSQL + '  :QTDSEP, ';

      If (Not fEmptyStr(strOpeSep)) Then
        strSQL := strSQL + ' :OPESEP, ';

      If (Not fEmptyStr(strOpeExp)) Then
        strSQL := strSQL + ' :OPEEXP, ';

      strSQL := strSQL + '  :DESCND, ';
      strSQL := strSQL + '  :QDENTR, ';
      strSQL := strSQL + '  :PROESP, ';
      strSQL := strSQL + '  :CODCMG, ';
      strSQL := strSQL + '  :SEQEST, ';
      strSQL := strSQL + '  :ITEEST, ';
      strSQL := strSQL + '  :UNIEST, ';
      strSQL := strSQL + '  :QTDSBI, ';
      strSQL := strSQL + '  :UNISBI, ';
      strSQL := strSQL + '  :FREMKP, ';
      strSQL := strSQL + '  :COMMKP, ';
      strSQL := strSQL + '  :VENCBO, ';
      strSQL := strSQL + '  :UNIDOL, ';
      strSQL := strSQL + '  :TOTDOL, ';
      strSQL := strSQL + '  :QTDRCO, ';
      strSQL := strSQL + '  :OBSRCO, ';
      strSQL := strSQL + '  :EXIBSE, ';
      strSQL := strSQL + '  :CODPRO, ';
      strSQL := strSQL + '  :PROKIT, ';
      strSQL := strSQL + '  :OPBXSE, ';
      strSQL := strSQL + '  :DTBXSE, ';
      strSQL := strSQL + '  :HRBXSE, ';
      strSQL := strSQL + '  :EMPCAR, ';
      strSQL := strSQL + '  :TEMNSE, ';
      strSQL := strSQL + '  :RESERV, ';

      if (not fEmptyStr(strNumLot)) and (strNumLot <> 'A DEFINIR') and (fCfgSis('TIPEXP', varInteger) = 5) And fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis then
      begin
        strSQL := strSQL + '  :INFLOT, ';
      end;

      strSQL := strSQL + '  :TIPREC, ';
      strSQL := strSQL + '  :VDESST, ';

      strSQL := strSQL + '  :NUMPLA, ';
      strSQL := strSQL + '  :PARNUM, ';
      strSQL := strSQL + '  :REQCOM, ';
      strSQL := strSQL + '  :REGESP, ';

      If Not fEmptyStr(strSeqEql) Then
        strSQL := strSQL + '  :SEQEQL, ';

      strSQL := strSQL + '  :MDESST, ';
      strSQL := strSQL + '  :SEQINV, ';
      strSQL := strSQL + '  :NUMDRW, ';
      strSQL := strSQL + '  :MNTPRC, ';
      strSQL := strSQL + '  :QTDRET, ';
      strSQL := strSQL + '  :AUTEND, ';
      strSQL := strSQL + '  :FRECOT, ';
      strSQL := strSQL + '  :ALTEST, ';
      strSQL := strSQL + '  :RATEST, ';
      strSQL := strSQL + '  :SEQPER, ';
      strSQL := strSQL + '  :DOCORI, ';
      strSQL := strSQL + '  :ESPORI, ';
      strSQL := strSQL + '  :EMPORI, ';
      strSQL := strSQL + '  :EMPDMP, ';
      strSQL := strSQL + '  :UNDIDE, ';
      strSQL := strSQL + '  :CUBAGE, ';
      strSQL := strSQL + '  :NOTESP, ';
      strSQL := strSQL + '  :FREENT, ';
      strSQL := strSQL + '  :ACPPRO, ';
      strSQL := strSQL + '  :ACPTXC, ';
      strSQL := strSQL + '  :ACPVCT, ';
      strSQL := strSQL + '  :ACPRES, ';
      strSQL := strSQL + '  :ACPMAR, ';
      strSQL := strSQL + '  :OUTVAL, ';
      strSQL := strSQL + '  :BASTRO, ';
      strSQL := strSQL + '  :TCKQBT, ';
      strSQL := strSQL + '  :SOMCOL, ';
      strSQL := strSQL + '  :VALPIS, ';
      strSQL := strSQL + '  :VALCOF, ';
      strSQL := strSQL + '  :SEQPRE) ';

      qryExtDor := fCriaQuery(Nil);
      qryExtDor.SQL.Text := strSQL;

      qryFatDor := fCriaQuery;

      If (intSeqInd <> -1) Then
      Begin
        if (intSeqUlt = 0) then
          intSeqInd := intSeqFdo;
        Inc(intSeqFdo);
      End;

      If fEmptyStr(strAutInc) Then
        strAutInc := fRetAutoIncrem('FATDOR', strCodEmp);

      With qryFatDor Do
      Begin
        qryFatDor.SQL.Text := 'SELECT * FROM FATDOR WHERE FALSE';
        qryFatDor.Open;

        Insert;

        FieldByName('FDO_SEQGER').AsString   := strSeqGer;
        FieldByName('AUTOINCREM').AsString   := strAutInc;
        FieldByName('FDO_CODEMP').AsString   := strCodEmp;
        FieldByName('FDO_CODCLI').AsString   := strCodCli;
        FieldByName('FDO_CODVEN').AsString   := strCodVen;
        FieldByName('FDO_CODITE').AsString   := strCodIte;

        If fEmptyStr(strCodMar) Then
          FieldByName('FDO_CODMAR').Value := Null
        Else
          FieldByName('FDO_CODMAR').AsString := strCodMar;

        If fEmptyStr(strCodDiv) Then
          FieldByName('FDO_CODDIV').Value := Null
        Else
          FieldByName('FDO_CODDIV').AsString := strCodDiv;

        FieldByName('FDO_NUMDOC').AsString   := strNumDoc;
        FieldByName('FDO_ESPDOC').AsString   := strEspDoc;
        FieldByName('FDO_SERIE_').AsString   := strSerie;

        If dtaDtaEnt = 0 Then
          FieldByName('FDO_DTAENT').Value := Null
        Else
          FieldByName('FDO_DTAENT').AsDateTime := dtaDtaEnt;

        If dtaHorEnt = 0 Then
          FieldByName('FDO_HORENT').Value := Null
        Else
          FieldByName('FDO_HORENT').AsDateTime := dtaHorEnt;

        FieldByName('FDO_CONPAG').AsString   := strConPag;
        FieldByName('FDO_ESTADO').AsString   := strEstado;
        FieldByName('FDO_DESCRI').AsString   := strDescri;
        FieldByName('FDO_REFERE').AsString   := strRefere;
        FieldByName('FDO_UNIDAD').AsString   := strUnidad;

        If fEmptyStr(strForIte) Then
          FieldByName('FDO_FORITE').Value    := Null
        Else
          FieldByName('FDO_FORITE').AsString := strForIte;

        FieldByName('FDO_QTDITE').AsFloat    := fltQtdIte;
        FieldByName('FDO_UNITAR').AsFloat    := fltUnitar;
        FieldByName('FDO_UNIORI').AsFloat    := fltUniOri;
        FieldByName('FDO_TOTITE').AsFloat    := fltTotIte;
        FieldByName('FDO_VLRCON').AsFloat    := fltVlrCon;
        FieldByName('FDO_TOTCUS').AsFloat    := fltTotCus;
        FieldByName('FDO_TOTMED').AsFloat    := fltTotMed;
        FieldByName('FDO_DESCON').AsFloat    := fltDesCon;
        FieldByName('FDO_TOTFRE').AsFloat    := fltTotFre;
        FieldByName('FDO_DESESP').AsFloat    := fltDesEsp;
        FieldByName('FDO_DESACE').AsFloat    := fltDesAce;

        If fltDesBai > 0 Then
        Begin
          FieldByName('FDO_DESBAI').AsFloat := fltDesBai;
        End;

        If fEmptyStr(strCodRep) Then
          FieldByName('FDO_CODREP').AsVariant := null
        Else
          FieldByName('FDO_CODREP').AsString := strCodRep;

        If fEmptyStr(strCodVe2) Then
          FieldByName('FDO_CODVE2').AsVariant := Null
        Else
          FieldByName('FDO_CODVE2').AsString := strCodVe2;

        FieldByName('FDO_PERCOM').AsFloat    := fltPerCom;
        FieldByName('FDO_TOTCOM').AsFloat    := fltTotCom;
        FieldByName('FDO_TOTCO2').AsFloat    := fltTotCo2;
        FieldByName('FDO_CLAFIS').AsString   := strClaFis;
        FieldByName('FDO_CODFIS').AsString   := strCodFis;
        FieldByName('FDO_VALIPI').AsFloat    := fltValIpi;
        FieldByName('FDO_ALQIPI').AsFloat    := fltAlqIpi;
        FieldByName('FDO_BASIPI').AsFloat    := fltBasIpi;
        FieldByName('FDO_VALICM').AsFloat    := fltValIcm;
        FieldByName('FDO_ALQICM').AsFloat    := fltAlqIcm;
        FieldByName('FDO_BASICM').AsFloat    := fltBasIcm;
        FieldByName('FDO_VALRET').AsFloat    := fltValRet;
        FieldByName('FDO_ALQRET').AsFloat    := fltAlqRet;
        FieldByName('FDO_BASRET').AsFloat    := fltBasRet;
        FieldByName('FDO_TOTPES').AsFloat    := fltTotPes;
        FieldByName('FDO_PERBAS').AsFloat    := fltPerBas;
        FieldByName('FDO_PERRED').AsFloat    := fltPerRed;

        If blnJaFatu Then
          FieldByName('FDO_JAFATU').AsInteger  := 1
        Else
          FieldByName('FDO_JAFATU').AsInteger  := 0;

        FieldByName('FDO_TIPFAT').AsString   := strTipFat;

        If fEmptyStr(strNumFat) Then
          FieldByName('FDO_NUMFAT').Value := Null
        Else
          FieldByName('FDO_NUMFAT').AsString := strNumFat;

        If fEmptyStr(strEmpFat) Then
          FieldByName('FDO_EMPFAT').Value := Null
        Else
          FieldByName('FDO_EMPFAT').AsString := strEmpFat;

        If dtaDtaFat = 0 Then
          FieldByName('FDO_DTAFAT').Value := Null
        Else
          FieldByName('FDO_DTAFAT').AsDateTime := dtaDtaFat;

        If (fEmptyStr(strVenFat)) Then
          FieldByName('FDO_VENFAT').Value := Null
        Else
          FieldByName('FDO_VENFAT').AsString   := strVenFat;

        FieldByName('FDO_CNDFAT').AsString   := strCndFat;
        FieldByName('FDO_VALFAT').AsFloat    := fltValFat;
        FieldByName('FDO_IDEPRO').AsString   := strIdePro;
        FieldByName('FDO_INCPIS').AsString   := strIncPis;

        If (fEmptyStr(strCodDig)) Then
          FieldByName('FDO_CODDIG').Value := Null
        Else
          FieldByName('FDO_CODDIG').AsString := strCodDig;

        If (fEmptyStr(strCodCnd)) Then
          FieldByName('FDO_CODCND').Value := Null
        Else
          FieldByName('FDO_CODCND').AsString   := strCodCnd;

        If (fEmptyStr(strProEmb)) Then
          strProEmb := 'N';

        FieldByName('FDO_PROEMB').AsString := strProEmb;

        If (fEmptyStr(strCodFpg)) Then
          FieldByName('FDO_CODFPG').Value := Null
        Else
          FieldByName('FDO_CODFPG').AsString := strCodFpg;

        If (fEmptyStr(strIteCha)) Then
          FieldByName('FDO_ITECHA').Value := Null
        Else
          FieldByName('FDO_ITECHA').AsString  := strIteCha;

        FieldByName('FDO_ITETIN').AsString  := strIteTin;
        FieldByName('FDO_DESCOR').AsString  := strDesCor;
        FieldByName('FDO_TIPEMB').AsString  := strTipEmb;
        FieldByName('FDO_QTDEMB').AsFloat   := fltQtdEmb;
        FieldByName('FDO_PREEMB').AsFloat   := fltPreEmb;
        FieldByName('FDO_TIPPRE').AsString  := strTipPre;
        FieldByName('FDO_PRVTIN').AsFloat   := fltPrvTin;
        FieldByName('FDO_PRCTIN').AsFloat   := fltPrcTin;
        FieldByName('FDO_FATTIN').AsFloat   := fltFatTin;

        If (fEmptyStr(strIteEmb)) Then
          FieldByName('FDO_ITEEMB').Value := Null
        Else
          FieldByName('FDO_ITEEMB').AsString  := strIteEmb;

        FieldByName('FDO_LAZQUA').AsInteger := intLazQua;
        FieldByName('FDO_PROMOC').AsString  := strPromoc;
        FieldByName('FDO_SEQTIN').AsString  := strSeqTin;
        FieldByName('FDO_QTDPUL').AsFloat   := fltQtdPul;
        FieldByName('FDO_SEQIND').AsInteger := intSeqInd;

        FieldByName('FDO_QTDBAI').AsFloat   := fltQtdBai;
        FieldByName('FDO_UNIDIG').AsFloat   := fltUniDig;

        FieldByName('FDO_COMPLE').AsString  := strComple;
        FieldByName('FDO_VOLPRO').AsFloat   := fltVolPro;

        If fEmptyStr(strCodAca) Then
          FieldByName('FDO_CODACA').Value := Null
        Else
          FieldByName('FDO_CODACA').AsString := strCodAca;

        If fEmptyStr(strEmpAca) Then
          FieldByName('FDO_EMPACA').Value := Null
        Else
          FieldByName('FDO_EMPACA').AsString := strEmpAca;

        FieldByName('FDO_PROACA').AsString := IfThen(blnProAca, 'S', 'N');

        FieldByName('FDO_TABPRE').AsString := strTabPre;

        {********************************************}
        {* CAMPOS PARA TINTAS COM DILUIÇÃO DINAMICA *}
        {*****************************************PH*}
        FieldByName('FDO_LINLIN').AsString := strLinha;
        FieldByName('FDO_CATALI').AsString := strCatali;
        FieldByName('FDO_CODDIL').AsString := strCodDil;
        FieldByName('FDO_PORDIL').AsFloat  := fltPorDil;
        FieldByName('FDO_DILCON').AsString := strDilCon;
        FieldByName('FDO_PORCAT').AsFloat  := fltPorCat;

        If Pos(strEntFut,'SN') <= 0 Then
          strEntFut := 'N';

        FieldByName('FDO_ENTFUT').AsString := strEntFut;
        FieldByName('FDO_MOTFUT').AsString := strMotFut;

        If (dtaDtEntr = 0) Or (strEntFut = 'N') Then
          FieldByName('FDO_DTAFUT').Value := Null
        Else
        Begin
          If (Pos(strMotFut, 'P_F') > 0) And (dtaDtEntr < VS_Date) Then
            dtaDtEntr := Vs_Date;

          FieldByName('FDO_DTAFUT').AsDateTime := dtaDtEntr;
        End;

        FieldByName('FDO_TOTCU2').AsFloat  := fltTotCu2;
        FieldByName('FDO_COMREP').AsFloat  := fltComRep;
        FieldByName('FDO_PERREP').AsFloat  := fltPerRep;

        FieldByName('FDO_KEY_EP').AsString := strKey_EP;

        FieldByName('FDO_NUMLOT').AsString := strNumLot;

        If fEmptyStr(strEmpPrd) Then
          FieldByName('FDO_EMPPRD').Value := Null
        Else
          FieldByName('FDO_EMPPRD').AsString := strEmpPrd;

        FieldByName('FDO_BXSBIT').AsString := IIF(blnBxSbIt, 'S', 'N');

        FieldByName('FDO_EMPITE').AsString := strEmpIte;
        If fEmptyStr(strEmpIte) Then
          FieldByName('FDO_EMPITE').Clear;

        If Not fEmptyStr(strOrdPro) Then
          FieldByName('FDO_ORDPRO').AsString := strOrdPro;

        If fEmptyStr(strNumLot) Then
          FieldByName('FDO_NUMLOT').Clear;

        If Not fEmptyStr(strDocDev) Then
        Begin
          FieldByName('FDO_DOCDEV').AsString := strDocDev;
          FieldByName('FDO_ESPDEV').AsString := strEspDev;
          FieldByName('FDO_EMPDEV').AsString := strEmpDev;
        End;

        Post;

        If fEmptyStr(strEntRet) Then
        Begin
          If fCfgSis('SUJROM') = 'S' Then
            strEntRet := 'E'  //Entrega
          Else
            strEntRet := 'R'; //Entrega

          If (strEntRet = 'E') And (dtaDtEntr = 0) Then
            dtaDtEntr := VS_DATE;
        End;

        TLogGor.strEntRet := strEntRet;
        TLogGor.strEmpCar := strEmpCar;
        TLogGor.pLog(qryFatDor, 'FATDOR', strAutLdg);

      End;

      qryExtDor.ParamByName('SEQFDO').AsString := strAutInc;

      If fltUniVis = 0 Then
      Begin
        fltTaxJur := 0;
        fltUniVis := fltUniOri;
      End;

      qryExtDor.ParamByName('UNIVIS').AsFloat := fltUniVis;
      qryExtDor.ParamByName('VAL_RT').AsFloat := fltVal_RT;
      qryExtDor.ParamByName('TAXJUR').AsFloat := fltTaxJur;
      qryExtDor.ParamByName('CUBAGE').AsFloat := fRetCubagemItem(strCodIte, fltQtdIte);

      If fCfgSis('ITEDIV', varString) = 'P' Then
        qryExtDor.ParamByName('NOTESP').AsString := fCampoTabela('ITE_NOTESP', 'CADITE', ['ITE_CODITE'], [strCodIte], False)
      Else
        qryExtDor.ParamByName('NOTESP').Value := Null;

      If fEmptyStr(strEmpFor) Then
        qryExtDor.ParamByName('EMPFOR').Value := Null
      Else
        qryExtDor.ParamByName('EMPFOR').AsString := strEmpFor;

      qryExtDor.ParamByName('FRESUG').AsFloat := fltFreSug;
      qryExtDor.ParamByName('FRERAT').AsFloat := fltFreRat;
      qryExtDor.ParamByName('TAXENT').AsFloat := fltTaxEnt;
      qryExtDor.ParamByName('QTDEXP').AsFloat := fltQtdExp;

      qryExtDor.ParamByName('NUMCMP').AsString  := strNumCmp;
      qryExtDor.ParamByName('NITCMP').AsInteger := intNItCmp;

      if (dtaDtaCmp = 0) then
        qryExtDor.ParamByName('DTACMP').Value := Null
      else
        qryExtDor.ParamByName('DTACMP').AsDateTime := dtaDtaCmp;

      qryExtDor.ParamByName('BAREMB').AsString := strBarEmb;
      qryExtDor.ParamByName('PESLIQ').AsFloat  := fltPesLiq;
      qryExtDor.ParamByName('PESBRU').AsFloat  := fltPesBru;

      qryExtDor.ParamByName('ALTPCO').AsString := strAltPCo;
      qryExtDor.ParamByName('CLIBUS').AsString := strCliBus;      
      qryExtDor.ParamByName('TURENT').AsString := AnsiUpperCase(strTurEnt);

      If Not fCfgSis('LOCRET', VarBoolean) Then
        strLocRet := ''
      Else If strEntRet <> 'R' Then
        strLocRet := ''
      Else If (strEntRet = 'R') And fEmptyStr(strLocRet) Then
        strLocRet := 'C'
      Else If (strEntRet = 'R') And (strLocRet = '-') Then
        strLocRet := '';

      qryExtDor.ParamByName('ENTRET').AsString := strEntRet;
      qryExtDor.ParamByName('LOCRET').AsString := strLocRet;

      {Data de Entrega}
      If dtaDtEntr = 0 Then
        qryExtDor.ParamByName('DTENTR').Value := Null
      Else
        qryExtDor.ParamByName('DTENTR').AsDateTime := dtaDtEntr;

      {Prazo em Dias "Entrega"}
      If intQDEntr = 0 Then
        qryExtDor.ParamByName('QDENTR').AsInteger := 0
      Else
        qryExtDor.ParamByName('QDENTR').AsInteger := intQDEntr;

      If fEmptyStr(strSeqRcd) Then
        qryExtDor.ParamByName('SEQRCD').Value := Null
      Else
        qryExtDor.ParamByName('SEQRCD').AsString := strSeqRcd;

      If intSeqInc <= 0 Then
        qryExtDor.ParamByName('SEQINC').Value := Null
      Else
        qryExtDor.ParamByName('SEQINC').AsInteger := intSeqInc;

      If intOrdIte <= 0 Then
        qryExtDor.ParamByName('ORDITE').Value := 0
      Else
        qryExtDor.ParamByName('ORDITE').AsInteger := intOrdIte;

      qryExtDor.ParamByName('INSALT').AsString := IIF(blnInseridoOuAlterado, 'S', 'N');

      qryExtDor.ParamByName('SERRAT').AsFloat  := fltSerRat;
      qryExtDor.ParamByName('LOTABA').AsString := strLotAba;

      qryExtDor.ParamByName('INCFUT').AsString := strIncFut;

      If fEmptyStr(strIncFut) Then
        qryExtDor.ParamByName('INCFUT').Clear;

      qryExtDor.ParamByName('LOTANT').AsString := strLotAnt;

      If fEmptyStr(strLotAnt) Then
        qryExtDor.ParamByName('LOTANT').Clear;

      If fEmptyStr(strSepExp) Then
        strSepExp := 'N';

      qryExtDor.ParamByName('SEPEXP').AsString := strSepExp;

      qryExtDor.ParamByName('PIGBAS').AsString := strPigBas;

      If (fEmptyStr(strIncDev)) Then
        qryExtDor.ParamByName('INCDEV').Value := Null
      Else
        qryExtDor.ParamByName('INCDEV').AsString := strIncDev;

      If not fEmptyStr(strSeqOpI) Then
      Begin
        qryExtDor.ParamByName('SEQOPI').AsString := strSeqOpI;
        qryExtDor.ParamByName('BAIOPI').AsString := 'S';
      End
      Else
      Begin
        qryExtDor.ParamByName('SEQOPI').Clear;
        qryExtDor.ParamByName('BAIOPI').AsString := 'N';
      End;

      If fEmptyStr(strBaqtze) Then
        qryExtDor.ParamByName('BAQTZE').Value := Null
      Else
        qryExtDor.ParamByName('BAQTZE').AsString := strBaqtze;

      qryExtDor.ParamByName('DESMAX').AsFloat := fltDesMax;
      qryExtDor.ParamByName('VALFLE').AsFloat := fltValFle;
      qryExtDor.ParamByName('PEGOU_').AsString := strPegou_;
      qryExtDor.ParamByName('BASTRO').AsString := strBasTro;

      qryExtDor.ParamByName('ATIVAC').AsString  := strAtivac;
      qryExtDor.ParamByName('SEQCOM').AsInteger := intSeqCom;

      if fEmptyStr(strVenCbo) then
        qryExtDor.ParamByName('VENCBO').AsString  := IIF(intSeqCom > 0, 'S', 'N')
      else
        qryExtDor.ParamByName('VENCBO').AsString  := strVenCbo;

      qryExtDor.ParamByName('QTDATI').AsFloat   := fltQtdAti;
      qryExtDor.ParamByName('QTDCOM').AsFloat   := fltQtdCom;
      qryExtDor.ParamByName('TABCOM').AsString  := strTabCom;

      qryExtDor.ParamByName('AUTDET').AsString  := strAutDet;

      If fEmptyStr(strAutDet) Then
        qryExtDor.ParamByName('AUTDET').Clear;

      qryExtDor.ParamByName('ICMPAV').AsFloat := fltIcmPav;
      qryExtDor.ParamByName('IMPFED').AsFloat := (fltTotIte - fltDesEsp + fltTotFre + fltDesAce) * fltImpFed / 100;

      blnPedidoOrigemSite := (not fEmptyStr(strNumPok));
      blnSomaTotFreDesAce := (Not blnPedidoOrigemSite) Or (blnPedidoOrigemSite And (fCfgSis('CALDES', varString) = '1'));

      qryExtDor.ParamByName('DESOPE').AsFloat := (fltTotIte - fltDesEsp + IIF(blnSomaTotFreDesAce, (fltTotFre + fltDesAce), 0)) * fltDesOpe / 100;

      qryExtDor.ParamByName('VALFCP').AsFloat  := fltValFCP;
      qryExtDor.ParamByName('NOTC17').AsString := strNotC17;

      If (blnIcmSai) Then
        qryExtDor.ParamByName('ICMSAI').AsFloat := (fltIcmPav * fltQtdIte)
      Else
      Begin
        If (fCfgSis('IMPCF4') = 'S') And (Not fCfgSis('RAICF4', varBoolean)) Then
        Begin
          If (((fCfgSis('CLPVDI', varString) = 'S') And (fCfgSis('ICMSEP', varString) = 'S')) Or (fCfgSis('UASCCR', varString) = 'S')) And (fltIcmPrd > 0) Then
            qryExtDor.ParamByName('ICMSAI').AsFloat := (fltTotIte - fltDesEsp) * (fltIcmPrd+fltAlDifa) / 100
          Else
            qryExtDor.ParamByName('ICMSAI').AsFloat := (fltTotIte - fltDesEsp) * (fltAlqIcm+fltAlDifa) / 100;
        End
        Else
          qryExtDor.ParamByName('ICMSAI').AsFloat := (fltTotIte - fltDesEsp) * (fltIcmSai+fltAlDifa) / 100;
      End;

      If (fltAlq922 > 0) Then
        qryExtDor.ParamByName('ICMSAI').AsFloat := (fltTotIte - fltDesEsp) * fltAlq922 / 100;

      If fEmptyStr(strDesNes) Then
        qryExtDor.ParamByName('DESNES').Value := Null
      Else
        qryExtDor.ParamByName('DESNES').AsString := strDesNes;

      If fEmptyStr(strNcmTin) Then
        qryExtDor.ParamByName('NCMTIN').Value := Null
      Else
        qryExtDor.ParamByName('NCMTIN').AsString := strNcmTin;

      If fEmptyStr(strCodCmg) Then
        qryExtDor.ParamByName('CODCMG').Value := Null
      Else
        qryExtDor.ParamByName('CODCMG').AsString := strCodCmg;

      If Not fEmptyStr(strIteEst) Then
        qryExtDor.ParamByName('ITEEST').AsString  := strIteEst;

      If intSeqEst > 0 Then
      Begin
        qryExtDor.ParamByName('SEQEST').AsInteger := intSeqEst;
        qryExtDor.ParamByName('UNIEST').AsFloat   := fltUniEst;
        qryExtDor.ParamByName('QTDSBI').AsFloat   := fltQtdSbi;
        qryExtDor.ParamByName('UNISBI').AsFloat   := fltUniSbi;
      End;

      qryExtDor.ParamByName('FREMKP').AsFloat := fltFreMkp;
      qryExtDor.ParamByName('COMMKP').AsFloat := fltComMkp;

      If fltQtdSep > 0 Then
        qryExtDor.ParamByName('QTDSEP').AsFloat := fltQtdSep;

      If (Not fEmptyStr(strOpeSep)) Then
        qryExtDor.ParamByName('OPESEP').AsString := strOpeSep;

      If (Not fEmptyStr(strOpeExp)) Then
        qryExtDor.ParamByName('OPEEXP').AsString := strOpeExp;

      qryExtDor.ParamByName('DESCND').AsFloat   := fltDesCnd;

      qryExtDor.ParamByName('PROESP').AsString := strProEsp;

      qryExtDor.ParamByName('CODPRO').AsString := strCodPro;

      qryExtDor.ParamByName('PROKIT').AsString := strAIdKitPromocao;
      qryExtDor.ParamByName('TEMNSE').AsString := IIF(fEmptyStr(strTemNumSerie), 'N', strTemNumSerie);

      qryExtDor.ParamByName('RESERV').AsString := strReserv;

      If fEmptyStr(strEmpCar) Then
        qryExtDor.ParamByName('EMPCAR').Value := Null
      Else
        qryExtDor.ParamByName('EMPCAR').AsString := strEmpCar;

      if (not fEmptyStr(strNumLot)) and (strNumLot <> 'A DEFINIR') and (fCfgSis('TIPEXP', varInteger) = 5) And fQuandoWMSPermitirAlterarLoteDeProdutosRastreaveis then
      begin
        qryExtDor.ParamByName('INFLOT').AsString := 'S';
      end;


      qryExtDor.ParamByName('UNIDOL').AsFloat   := fltUniDol;
      qryExtDor.ParamByName('TOTDOL').AsFloat   := fltTotDol;
      qryExtDor.ParamByName('QTDRCO').AsFloat   := fltQtdRco;
      qryExtDor.ParamByName('OBSRCO').AsString  := strObsRco;

      qryExtDor.ParamByName('EXIBSE').AsString  := IIF(blnExiBSe, 'S', 'N');

      if not fEmptyStr(strOpBxSe) then
        qryExtDor.ParamByName('OPBXSE').AsString := strOpBxSe;

      if dtaDtBxSe <> 0 then
        qryExtDor.ParamByName('DTBXSE').AsDateTime := dtaDtBxSe;

      if dtaHrBxSe <> 0 then
        qryExtDor.ParamByName('HRBXSE').AsDateTime := dtaHrBxSe;

      qryExtDor.ParamByName('TIPREC').AsString := '';
      If (not fEmptyStr(strCodCnd)) And
         ((fCfgSis('USAALP', varBoolean)) Or (fCfgSis('ALPKNK', varBoolean))) Then
      Begin
        If strCodCnd = fCfgSis('CPGALP', varString) Then
          qryExtDor.ParamByName('TIPREC').AsString := 'ALPE'
        Else If (Pos(strCodCnd, fCfgSis('CNDBOL', varString)) > 0) then
          qryExtDor.ParamByName('TIPREC').AsString := 'ALPE_BOLETO';
      End;

      qryExtDor.ParamByName('VDESST').AsFloat   := fltVDesST;
      qryExtDor.ParamByName('MDESST').AsString  := strMDesST;

      qryExtDor.ParamByName('NUMPLA').AsString  := strNumPla;
      qryExtDor.ParamByName('PARNUM').AsString  := strParNum;
      qryExtDor.ParamByName('REQCOM').AsString  := strReqCom;
      qryExtDor.ParamByName('REGESP').AsString  := strRegEsp;

      If Not fEmptyStr(strSeqEql) Then
        qryExtDor.ParamByName('SEQEQL').AsString := strSeqEql;

      qryExtDor.ParamByName('SEQINV').AsInteger := intSeqInv;

      if fEmptyStr(strNumDrw) Then
        qryExtDor.ParamByName('NUMDRW').Value := Null
      else
        qryExtDor.ParamByName('NUMDRW').AsString := strNumDrw;

      qryExtDor.ParamByName('MNTPRC').AsString := IfThen(blnMntPrc, 'S', 'N');

      qryExtDor.ParamByName('QTDRET').AsFloat  := fltQtdRet;

      if not fEmptyStr(strAutEnd) then
        qryExtDor.ParamByName('AUTEND').AsString := strAutEnd;

      qryExtDor.ParamByName('FRECOT').AsFloat := fltFreCot;

      qryExtDor.ParamByName('ALTEST').AsString  := IfThen(blnAltEst, 'S', 'N');

      If blnRatEst Then
       qryExtDor.ParamByName('RATEST').AsString := 'S';

      qryExtDor.ParamByName('SEQPER').AsInteger := intSeqPer;

      qryExtDor.ParamByName('DOCORI').Value := IIF(Not fEmptyStr(strDocOri), strDocOri, Null);
      qryExtDor.ParamByName('ESPORI').Value := IIF(Not fEmptyStr(strEspOri), strEspOri, Null);
      qryExtDor.ParamByName('EMPORI').Value := IIF(Not fEmptyStr(strEmpOri), strEmpOri, Null);
      qryExtDor.ParamByName('EMPDMP').Value := IIF(Not fEmptyStr(strEmpDmp), strEmpDmp, Null);
      qryExtDor.ParamByName('UNDIDE').AsFloat := fltUnDiDe;

      qryExtDor.ParamByName('FREENT').AsFloat := fltFreEntPD;
      qryExtDor.ParamByName('ACPPRO').AsFloat := fltAcpProPD;
      qryExtDor.ParamByName('ACPTXC').AsFloat := fltAcpTxcPD;
      qryExtDor.ParamByName('ACPVCT').AsFloat := fltAcpVctPD;
      qryExtDor.ParamByName('ACPRES').AsFloat := fltAcpResPD;
      qryExtDor.ParamByName('ACPMAR').AsFloat := fltAcpMarPD;
      qryExtDor.ParamByName('OUTVAL').AsFloat := fltOutValPD;
      qryExtDor.ParamByName('TCKQBT').AsString := strTckQbt;
      qryExtDor.ParamByName('SOMCOL').AsFloat := fltSomaColorantes;
      qryExtDor.ParamByName('VALPIS').AsFloat := fltValPis;
      qryExtDor.ParamByName('VALCOF').AsFloat := fltValCof;

      If Not fEmptyStr(strSeqPre) Then
        qryExtDor.ParamByName('SEQPRE').AsString := strSeqPre;

      qryExtDor.ExecSQL;

      FreeAndNil(qryExtDor);

      If strBrinde = 'S' Then
      Begin
        qryBriDor := fCriaQuery;

        qryBriDor.SQL.Text := 'SELECT * FROM BRIDOR WHERE FALSE';
        qryBriDor.Open;
        qryBriDor.Append;
        qryBriDor.FieldByName('BRI_SEQDET').AsString := strAutInc;

        If (Not fEmptyStr(strCodPar)) Then
          qryBriDor.FieldByName('BRI_CODPAR').AsString := strCodPar
        Else
          qryBriDor.FieldByName('BRI_CODPAR').Value := Null;

        qryBriDor.FieldByName('BRI_TIPBRI').AsString := strTipBri;
        qryBriDor.Post;

        FreeAndNil(qryBriDor);
      end;

      pGravaMecanicosItemPD(strAutInc, strCodMec);

      If strEspDoc.Equals('PD') Or
         strEspDoc.Equals('OR') Then
      Begin

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

      End;

      If (fCfgSis('PAFECF', varBoolean)) Then
        pGravaDavPVD(strNumDoc, strEspDoc, strCodEmp, strCodCli, strCodIte, strDescri,
          fltQtdIte, fltUnitar, fltTotIte, fltDesEsp, strUnidad, strCodFis,
          fltAlqIcm, strCodAca, strEmpAca, strIteEmb, strNumLot, intSeqInd);

      If strPromoc.Equals('S') And ((strEspDoc <> 'OR') Or (fCfgSis('DOCPRO', varString) = '1')) Then
        TUpdatePromo.New(
          TParametrosPromocao.New()
            .CodIte(strCodIte)
            .CodEmp(IIF(fEmptyStr(strEmpIte), strCodEmp, strEmpIte))
            .CodCli(strCodCli)
            .TabPre(strTabPre)
          ).fAtualizaQtdDisponivel();

      LEmpresas := untFuncoesGenerica.fGetEmpresasReprocessarItemPedido(strAutInc);

      For LEmpresa In LEmpresas Do
      Begin
        If Assigned(objReprocessarSaldoItens) Then
          objReprocessarSaldoItens.AddItem(TItemReprocessarSaldo.New
                                             .Codigo(strCodIte)
                                             .Empresa(LEmpresa)
                                             .EhItemEntregaFutura(fReprocessarSaldoReservadoEntregaFutura(
                                                                    strEntFut, strClaFis, strIncFut, EmptyStr)))
        Else
          ReprocessarItem(strCodIte, LEmpresa, fReprocessarSaldoReservadoEntregaFutura(
                                                 strEntFut, strClaFis, strIncFut, EmptyStr));
      End;

      If blnBxSbIt And (fCfgSis('BXSBIT') = '2') And (fCfgSis('EMOPPD') = 'N') Then
      Begin
        For LEmpresa In LEmpresas Do
        Begin
          LSubItens := fGetSubItensEstrutura(strCodIte);

          For LSubItem In LSubItens Do
            If Assigned(objReprocessarSaldoItens) Then
              objReprocessarSaldoItens.AddItem(TItemReprocessarSaldo.New.Codigo(LSubItem).Empresa(LEmpresa))
            Else
              ReprocessarItem(LSubItem, LEmpresa);
        End;
      End;

    Except

      On E: Exception Do
      Begin
        Result := False;
        qryFatDor.Cancel;
        pMensagensErro(E.Message, '[fGravaFatDor]');
      End;

    End;

  Finally
    FreeAndNil(qryFatDor);
  End;

end;

procedure pFaturaConDor(strNumDoc, strEspDoc, strCodEmp, strLisCodIte, strLisFdoSeqGer, strAutoincrem : String; blnFaturandoServicoOuExpedicaoParcial: boolean);
Var
  strSQL: string;
  qryGen: TUniQuery;
Begin

  if  (fCfgSis('TIPEXP', varString) =  '3') or (fCfgSis('TIPEXP', varString) =  '4')then
  begin
    qryGen := fCriaQuery;
    try
      If ((blnFaturandoServicoOuExpedicaoParcial) and ((Not fEmptyStr(strLisCodIte)) and (Not fEmptyStr(strLisFdoSeqGer)))) or
         (Not blnFaturandoServicoOuExpedicaoParcial) Then
      begin
        strSQL := '';
        strSQL := strSQL + 'UPDATE CONDOR CD INNER JOIN FATDOR FD ON CD.CON_SEQFDO = FD.AUTOINCREM ';
        strSQL := strSQL + '      SET CD.CON_NUMFAT = :NUMFAT ' ;
        strSQL := strSQL + 'WHERE CD.CON_NUMFAT IS NULL ';

        if blnFaturandoServicoOuExpedicaoParcial then
        begin
          if Not fEmptyStr(strLisCodIte) then
            strSQL := strSQL + ' AND FD.FDO_CODITE IN (' + strLisCodIte + ') ';
          if Not fEmptyStr(strLisFdoSeqGer) then
            strSQL := strSQL + ' AND FD.FDO_SEQGER IN (' + strLisFdoSeqGer + ') ';
        end
        else
        begin
          strSQL := strSQL + ' AND FD.FDO_NUMDOC = :NUMDOC ';
          strSQL := strSQL + ' AND FD.FDO_ESPDOC = :ESPDOC ';
          strSQL := strSQL + ' AND FD.FDO_CODEMP = :CODEMP ';
        end;

        qryGen.SQL.Text := strSQL;

        If qryGen.FindParam('NUMDOC') <> Nil Then
          qryGen.ParamByName('NUMDOC').AsString := strNumDoc;

        If qryGen.FindParam('ESPDOC') <> Nil Then
          qryGen.ParamByName('ESPDOC').AsString := strEspDoc;

        If qryGen.FindParam('CODEMP') <> Nil Then
          qryGen.ParamByName('CODEMP').AsString := strCodEmp;

        qryGen.ParamByName('NUMFAT').AsString := strAutoincrem;

        qryGen.ExecSQL;

        qryGen.Close;
        qryGen.SQL.Text := qryGen.SQL.Text.Replace('CONDOR', 'CONDOR_AUTCOM');
        qryGen.ExecSQL;

      end;
    finally
      FreeAndNil(qryGen);
    end;
  end;
End;

function fMarcaOrcPed(strNumDoc,
                      strEspDoc,
                      strNumOrc,
                      strEspOrc,
                      strVenFat,
                      strCndFat: String;
                      fltValFat: Double;
                      strEmpOrc: String;
                      blnAtuExp: Boolean;
                      strLisDet: String = '';
                      strEmpFat: String = '';
                      strLisCodIte: String = '';
                      strLisFdoSeqGer: String = '';
                      strLisSeqIndFatGor: String = '';
                      blnTinDor: Boolean = False;
                      blnValidaGorCndSeGravaCadRec: Boolean = True;
                      strCliFat: String = '';
                      strSerFat: String = '';
                      blnFaturamentoAutomatico: Boolean = False): Boolean;

  Var
    strLisPedidosSohComServico: String;
    strSQL   : String;
    qryGenGor: TUniQuery;
    blnFaturandoServicoOuExpedicaoParcial: Boolean;
    blnTotalmenteFaturado: Boolean;

   function fWhereFatDor: String;
   begin
     Result := '';
     If blnFaturandoServicoOuExpedicaoParcial Then
     Begin
       If Not fEmptyStr(strLisFdoSeqGer) Then
         Result := Result + '  AND FATDOR.FDO_SEQGER IN (' + strLisFdoSeqGer + ') ';
       If Not fEmptyStr(strLisCodIte) Then
         Result := Result + '  AND FATDOR.FDO_CODITE IN (' + strLisCodIte + ') ';
       If Not fEmptyStr(strLisSeqIndFatGor) Then
         Result := Result + '  AND FATDOR.FDO_SEQIND IN (' + strLisSeqIndFatGor + ') ';
     End
     Else
     Begin
       Result := Result + '  AND FATDOR.FDO_NUMDOC = :NUMORC ';
       Result := Result + '  AND FATDOR.FDO_ESPDOC = :ESPORC ';
       Result := Result + '  AND FATDOR.FDO_CODEMP = :EMPORC ';

       If Not fEmptyStr(strLisDet) Then
         Result := Result + '  AND FATDOR.AUTOINCREM IN (' +  strLisDet + ') ';
     End;
   end;

   function fOrcPedSemGorCnd: Boolean;
     Var
       qryGen: TUniQuery;
       strSQL: String;
       strMsg: String;
       strDoc: String;
   begin
     Result := False;

     If Not blnValidaGorCndSeGravaCadRec Then
       Exit;

     qryGen := fCriaQuery;
     Try
       strSQL := '';
       strSQL := strSQL + ' SELECT  ';
       strSQL := strSQL + '   FGO_NUMDOC, FGO_ESPDOC, FGO_CODEMP ';
       strSQL := strSQL + ' FROM    ';
       strSQL := strSQL + '   FATGOR ';
       strSQL := strSQL + '    INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ';
       strSQL := strSQL + '     LEFT JOIN GORCND ON GORCND.FGO_SEQGER = FATGOR.AUTOINCREM ';
       strSQL := strSQL + ' WHERE GORCND.FGO_SEQGER IS NULL ';
       strSQL := strSQL + '   AND FATGOR.FGO_VPAR01 > 0 ';

       strSQL := strSQL + fWhereFatDor;

       qryGen.SQL.Clear;
       qryGen.SQL.Text := strSQL;

       If qryGen.FindParam('NUMORC') <> Nil Then
         qryGen.ParamByName('NUMORC').AsString := strNumOrc;

       If qryGen.FindParam('ESPORC') <> Nil Then
         qryGen.ParamByName('ESPORC').AsString := strEspOrc;

       If qryGen.FindParam('EMPORC') <> Nil Then
         qryGen.ParamByName('EMPORC').AsString := IIF(fEmptyStr(strEmpOrc), VS_strCodEmp, strEmpOrc);

       qryGen.Open;
       qryGen.First;
         
       If (Not qryGen.IsEmpty) Then
       Begin
         Result := True;
         
         While Not qryGen.Eof Do
         Begin
           pIncrementaListaStr(qryGen.FieldByName('FGO_NUMDOC').AsString+'-'+
                               qryGen.FieldByName('FGO_ESPDOC').AsString+'-'+
                               qryGen.FieldByName('FGO_CODEMP').AsString, strMsg);
           
           qryGen.Next;
         End;

         strDoc := IIF(qryGen.FieldByName('FGO_ESPDOC').AsString='PD','Pedido','Orçamento');  
           
         fRollBack;

         Raise Exception.Create(strDoc+' com valor das parcelas inconsistentes. Regrave esse '+strDoc+
                                ' com essa versão do Autcom e repita essa operação. '+
                                'Se o problema persistir entre em contato com a Citel: '+strMsg);
       End;
     Finally
       FreeAndNil(qryGen);
     End;
   end;

   function fPedidoSohComServico: String;
     Var
       qryGen: TUniQuery;
   begin
     Result := '';

     If Not fEmptyStr(strLisFdoSeqGer) Then
     Begin
       qryGen := fCriaQuery;
       Try
         qryGen.SQL.Text := 'SELECT '+
                            '     AUTOINCREM, '+
                            '     IF(FGO_TOTPRO <= 0 AND FGO_TOTSER > 0, "S", "N") AS SOMENTESERVICO '+
                            ' FROM FATGOR WHERE AUTOINCREM IN ('+strLisFdoSeqGer+')';
         qryGen.Open;
         If Not qryGen.IsEmpty Then
         Begin
           qryGen.First;
           While Not qryGen.Eof Do
           Begin
              If qryGen.FieldByName('SOMENTESERVICO').AsString = 'S' Then
                pIncrementaListaStr(qryGen.FieldByName('AUTOINCREM').AsString, Result, True);

             qryGen.Next;
           End;
         End;
       Finally
         FreeAndNil(qryGen);
       End;
     End;
   end;

begin
  {*******************************************************************************}
  {* SOBRE O PARÂMETRO strEmpFat.                                                *}
  {* NA ROTINA fGravaArquivosDesmembrandoVenda A VS_strCodEmp É ALTERADA CONFORME*}
  {* CADA DOCUMENTO SALVO PELA PROCEDURE pSetarEmpresaLogada.                    *}
  {* NO REQ.: 52475 HOUVE UMA CORREÇÃO REFERENTE A TRANSFORMAÇÃO DE OR > PD      *}
  {* MULTI-LOJA, ENTRETANTO OPTEI POR NÃO ALTERAR VS_strCodEmp POIS É USADA PARA *}
  {* ESSA OPERAÇÃO OUTRA PROCEDURE: A fDesmembraPDORMultiLoja POR ISSO PRECISEI  *}
  {* CRIAR O PARÂMETRO strEmpFat.                                                *}
  {****************************************************************************VA*}
  Result  := True;

  strLisPedidosSohComServico := fPedidoSohComServico;

  blnFaturandoServicoOuExpedicaoParcial := (Not fEmptyStr(strLisCodIte)) And (Not fEmptyStr(strLisFdoSeqGer));

  If fOrcPedSemGorCnd Then
  Begin
    Result := False;
    Exit;
  End;
  
  qryGenGor := fCriaQuery(nil);
  Try

    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  FATDOR ';
    strSQL := strSQL + 'SET ';
    strSQL := strSQL + '  FDO_NUMFAT = :NUMDOC, ';
    strSQL := strSQL + '  FDO_TIPFAT = :ESPDOC, ';
    strSQL := strSQL + '  FDO_EMPFAT = :EMPFAT, ';
    strSQL := strSQL + '  FDO_JAFATU = IF(FDO_QTDBAI > 0 AND FDO_QTDBAI < FDO_QTDITE, FALSE, TRUE), ';
    strSQL := strSQL + '  FDO_DTAFAT = ' + fCurrentDate + ', ';
    strSQL := strSQL + '  FDO_DTAFUT = IF((FDO_MOTFUT IN ("P", "F")) AND FDO_DTAFUT < ' + fCurrentDate + ', ' + fCurrentDate + ', FDO_DTAFUT), ';
    strSQL := strSQL + '  FDO_VENFAT = :VENFAT, ';
    strSQL := strSQL + '  FDO_CNDFAT = :CNDFAT, ';
    strSQL := strSQL + '  FDO_VALFAT = :VALFAT ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  TRUE ';
    strSQL := strSQL + '  AND FDO_JAFATU = 0 ';

    strSQL := strSQL + fWhereFatDor;

    strSQL := strSQL + ' ORDER BY FDO_CODITE ';

    With qryGenGor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('EMPFAT').AsString := IIF(fEmptyStr(strEmpFat), VS_strCodEmp, strEmpFat);

      If FindParam('NUMORC') <> Nil Then
        ParamByName('NUMORC').AsString := strNumOrc;

      If FindParam('ESPORC') <> Nil Then
        ParamByName('ESPORC').AsString := strEspOrc;

      If (fEmptyStr(strVenFat)) Then
        ParamByName('VENFAT').Value := Null
      Else
        ParamByName('VENFAT').AsString   := strVenFat;

      ParamByName('CNDFAT').AsString := strCndFat;
      ParamByName('VALFAT').AsFloat  := fltValFat;

      If FindParam('EMPORC') <> Nil Then
        ParamByName('EMPORC').AsString := IIF(fEmptyStr(strEmpOrc), VS_strCodEmp, strEmpOrc);

      ExecSQL;
      Close;
    End;

    if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
      blnTotalmenteFaturado := fCampoTabela(
        'COUNT(*)',
        'FATDOR',
        ['FDO_JAFATU', 'FDO_NUMDOC', 'FDO_ESPDOC', 'FDO_CODEMP'],
        [0, strNumOrc, strEspOrc, IIF(fEmptyStr(strEmpOrc), VS_strCodEmp, strEmpOrc)]) = 0
     else
       blnTotalmenteFaturado := True;

    If ((Not blnFaturandoServicoOuExpedicaoParcial) Or (Not fEmptyStr(strLisPedidosSohComServico))) And (blnTotalmenteFaturado) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  FATGOR ';
      strSQL := strSQL + '  INNER JOIN EXTGOR ON FGO_SEQFGO = AUTOINCREM ';
      strSQL := strSQL + 'SET ';
      strSQL := strSQL + '  FGO_NUMFAT = :NUMDOC, ';
      strSQL := strSQL + '  FGO_TIPFAT = :ESPDOC, ';
      strSQL := strSQL + '  FGO_EMPFAT = :EMPFAT, ';
      strSQL := strSQL + '  FGO_JAFATU = TRUE, ';
      strSQL := strSQL + '  FGO_CANFAT = FALSE, ';
      strSQL := strSQL + '  FGO_DTAFAT = ' + fCurrentDate + ', ';

      If (blnAtuExp) Then
      Begin
        strSQL := strSQL + '  FGO_DTLBEX = ' + fCurrentDate + ', ';
        strSQL := strSQL + '  FGO_HRLBEX = ' + fCurrentTime + ', ';
      End;

      strSQL := strSQL + '  FGO_VENFAT = :VENFAT, ';
      strSQL := strSQL + '  FGO_CNDFAT = :CNDFAT, ';
      strSQL := strSQL + '  FGO_VALFAT = :VALFAT ';
      strSQL := strSQL + 'WHERE ';
      If (Not fEmptyStr(strLisPedidosSohComServico)) Then
        strSQL := strSQL + ' (FGO_JAFATU = 0 AND AUTOINCREM IN ('+strLisPedidosSohComServico+')) '+IIF(Not blnFaturandoServicoOuExpedicaoParcial, ' OR ', '');

      If (Not blnFaturandoServicoOuExpedicaoParcial) Then
      Begin
        strSQL := strSQL + ' (FGO_NUMDOC = :NUMORC AND ';
        strSQL := strSQL + '  FGO_ESPDOC = :ESPORC AND ';
        strSQL := strSQL + '  FGO_CODEMP = :EMPORC)    ';
      End;

      With qryGenGor Do
      Begin

        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := strEspDoc;
        ParamByName('EMPFAT').AsString := IIF(fEmptyStr(strEmpFat), VS_strCodEmp, strEmpFat);

        If (fEmptyStr(strVenFat)) Then
          ParamByName('VENFAT').Value := Null
        Else
          ParamByName('VENFAT').AsString := strVenFat;

        ParamByName('CNDFAT').AsString := strCndFat;
        ParamByName('VALFAT').AsFloat  := fltValFat;

        If FindParam('NUMORC') <> Nil Then
        Begin
          ParamByName('NUMORC').AsString := strNumOrc;
          ParamByName('ESPORC').AsString := strEspOrc;
          ParamByName('EMPORC').AsString := IIF(fEmptyStr(strEmpOrc), VS_strCodEmp, strEmpOrc);
        End;

        ExecSQL;
        Close;

      End;
    End;

    If blnTinDor Then
    Begin
      pBaixaTinDor(strNumOrc, strEspOrc, strEmpOrc, strVenFat, strLisDet);
    End;

    If (strEspOrc = 'PD') Then
    Begin
      TUpdateStatus.New(TParamStatus.New()
                          .NumDoc(strNumOrc)
                          .EspDoc(strEspOrc)
                          .CodEmp(IIF(fEmptyStr(strEmpOrc), VS_strCodEmp, strEmpOrc))).pExecute();

      {Reprocessar Saldos}
      TReprocessarSaldoItem.New
        .AddItensDoDocumento(
          TItensReprocessarDoDocumento.New
            .Documento(strNumOrc)
            .Especie(strEspOrc)
            .Empresa(IIF(fEmptyStr(strEmpOrc), VS_strCodEmp, strEmpOrc))
          ).NotificarRoboParaReprocessarSaldos;

      If (VS_strHabilitarCRM) Then
      Begin
        TUpdateOccurrenceCRM.New()
          .NumDoc(strNumDoc)
          .EspDoc(strEspDoc)
          .CodEmp(IIF(fEmptyStr(strEmpFat), VS_strCodEmp, strEmpFat))
          .AcaFat(afcPDTransferenciaFaturado)
          .strNomFrm('[unrFatGor.fMarcaOrcPed]')
          .pRun();
      End;
    End;

    pFaturaConDor(strNumOrc,
                  strEspOrc,
                  IIF(fEmptyStr(strEmpOrc), VS_strCodEmp, strEmpOrc),
                  strLisCodIte,
                  strLisFdoSeqGer,
                  fRetAutoIncremMovGerNotGer(strNumDoc, strEspDoc, IIF(fEmptyStr(strEmpFat), VS_strCodEmp, strEmpFat)),
                  blnFaturandoServicoOuExpedicaoParcial);

  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fMarcaOrcPed]');
    End;
  End;

  FreeAndNil(qryGenGor);

end;

function fApagaOrcPed(strNumDoc, strEspDoc, strCodEmp: String;
  strAutIncIteDel: String = ''; blnDelOco: Boolean = False): Boolean;
Var
  strSQL            : String;
  qryGenGor         : TUniQuery;
  blnTransacaoLocal : Boolean;
  blnExcluiuFgo     : Boolean;
begin

  Result := True;
  qryGenGor := fCriaQuery(nil);

  blnTransacaoLocal := False;
  If Not fInTransaction() Then
  Begin
    fStartTransaction();
    blnTransacaoLocal := True;
  End;

  Try

    If (strEspDoc = 'OR') And
       (fCfgSis('USADEP') = 'S') Then
    Begin
      qryGenGor.SQL.Text := 'SELECT F.AUTOINCREM, E.FGO_USADEP FROM FATGOR F ' +
                            'LEFT JOIN EXTGOR E ON E.FGO_SEQFGO=F.AUTOINCREM ' +
                            'WHERE F.FGO_NUMDOC=' + strNumDoc.QuotedString     +
                            '  AND F.FGO_ESPDOC=' + strEspDoc.QuotedString     +
                            '  AND F.FGO_CODEMP=' + strCodEmp.QuotedString;
      qryGenGor.Open;

      If (qryGenGor.FieldByName('FGO_USADEP').AsString = 'S') Then
        TValidacoesSistemaDEPS.pGravaLogDeStatusDoSistemaDEPS(qryGenGor.FieldByName('AUTOINCREM').AsString,
                                                              'CANCELAMENTO');
    End;

    {**************************************************}
    {* BUSCA OS DADOS DOS ITENS EXCLUÍDOS, ANTES DE   *}
    {* APAGAR A FATGOR. SERÁ USADO NA GRAVAÇÃO DO LOG *}
    {*REQ.173491************************************RP*}
    If Not fEmptyStr(strAutIncIteDel) Then
      TLogGor.pBuscaDadosItensExcluidos(strAutIncIteDel);

    strSQL := '';
    strSQL := strSQL + 'DELETE FROM FATGOR ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FGO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FGO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  FGO_CODEMP = :CODEMP ';

    With qryGenGor Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := strEspDoc;
      ParamByName('CODEMP').AsString := strCodEmp;

      {Reprocessar Saldos}
      TReprocessarSaldoItem.New
        .AddItensDoDocumento(
          TItensReprocessarDoDocumento.New
            .Documento(strNumDoc)
            .Especie(strEspDoc)
            .Empresa(strCodEmp)
          ).NotificarRoboParaReprocessarSaldos;

      ExecSQL;

      pExcluiCadRecTrocaRecebimentoPendente(strNumDoc, strEspDoc, strCodEmp);

      blnExcluiuFgo := True;

      If blnTransacaoLocal Then
        fCommit();

    End;

    If (strEspDoc = 'PD') Then
      TMovFlex.pExcluir(strNumDoc, strEspDoc, strCodEmp, '', '', '');

    If (fCfgSis('UTINPS', varBoolean)) Then
      TNetpoints.pDeletarPedidoOrcamento(strNumDoc, strEspDoc, strCodEmp);

    If blnDelOco And blnExcluiuFgo Then
      TDeleteOccurrenceCRM.New()
        .NumDoc(strNumDoc)
        .EspDoc(strEspDoc)
        .CodEmp(strCodEmp)
        .NomFrm('[untFatGor.fApagaOrcPed]')
        .pDelete()

  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[fApagaOrcPed]');

      If blnTransacaoLocal Then
        fRollBack();

    End;

  End;

  FreeAndNil(qryGenGor);

end;

procedure pExcluiCadRecTrocaRecebimentoPendente(strNumDoc, strEspDoc, strCodEmp: String);
var
  strAutIncCadRec: String;
  qryExclui: TUniQuery;
begin
  strAutIncCadRec := fCampoTabela('FGO_SEQDVB','FATGOR INNER JOIN EXTGOR ON(FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO)',['FGO_NUMDOC','FGO_ESPDOC','FGO_CODEMP'],[strNumDoc, strEspDoc, strCodEmp],False);

  if fEmptyStr(strAutIncCadRec) then
    Exit;

  qryExclui := fCriaQuery;

  try
    qryExclui.Close;
    qryExclui.SQL.Clear;
    qryExclui.SQL.Add('DELETE FROM CADREC WHERE AUTOINCREM = :AUTINC');
    qryExclui.ParamByName('AUTINC').AsString := strAutIncCadRec;
    qryExclui.ExecSQL;
  finally
    FreeAndNil(qryExclui);
  end;
end;

procedure pCarregaArrayAnexosPedidos(strAutInc: String; var arrAnexosPedido: TArrayAnexosPedido);
  Var
    strSQL    : String;
    qryGenGor : TUniQuery;
begin
  qryGenGor := fCriaQuery(nil);
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT * FROM ARQAPD ';
    strSQL := strSQL + ' WHERE APD_SEQFGO = :APD_SEQFGO ';

    qryGenGor.Close;
    qryGenGor.SQL.Clear;
    qryGenGor.SQL.Text := strSQL;
    qryGenGor.ParamByName('APD_SEQFGO').AsString  := strAutInc;
    qryGenGor.Open;

    SetLength(arrAnexosPedido, qryGenGor.RecordCount);

    qryGenGor.First;
    While Not qryGenGor.Eof Do
    Begin
      arrAnexosPedido[qryGenGor.recNo-1].strAutInc := qryGenGor.FieldByName('AUTOINCREM').AsString;
      arrAnexosPedido[qryGenGor.recNo-1].strSeqFgo := qryGenGor.FieldByName('APD_SEQFGO').AsString;
      arrAnexosPedido[qryGenGor.recNo-1].strArqB64 := qryGenGor.FieldByName('APD_ARQB64').AsString;
      arrAnexosPedido[qryGenGor.recNo-1].strNomArq := qryGenGor.FieldByName('APD_NOMARQ').AsString;

      qryGenGor.Next;
    End;
  Finally
    FreeAndNil(qryGenGor);
  End;
end;

function fInsereArrayAnexosPedidosNoBanco(strAutInc: String; arrAnexosPedido: TArrayAnexosPedido): Boolean;
  Var
    strSQL    : String;
    qryGenGor : TUniQuery;
    intCont   : Integer;
begin
  Result := True;
  qryGenGor := fCriaQuery(nil);
  Try
    Try
      strSQL := '';
      strSQL := strSQL + ' INSERT INTO ARQAPD ( ';
      strSQL := strSQL + '   AUTOINCREM, ';
      strSQL := strSQL + '   APD_SEQFGO, ';
      strSQL := strSQL + '   APD_ARQB64, ';
      strSQL := strSQL + '   APD_NOMARQ ';
      strSQL := strSQL + ' ) VALUES ( ';
      strSQL := strSQL + '   :AUTOINCREM, ';
      strSQL := strSQL + '   :APD_SEQFGO, ';
      strSQL := strSQL + '   :APD_ARQB64, ';
      strSQL := strSQL + '   :APD_NOMARQ ';
      strSQL := strSQL + ' ); ';


      qryGenGor.Close;
      qryGenGor.SQL.Clear;
      qryGenGor.SQL.Text := strSQL;

      For intCont := 0 to Pred(Length(arrAnexosPedido)) Do
      Begin
        qryGenGor.ParamByName('AUTOINCREM').AsString  := arrAnexosPedido[intCont].strAutInc;
        qryGenGor.ParamByName('APD_SEQFGO').AsString  := strAutInc;
        qryGenGor.ParamByName('APD_ARQB64').AsString  := arrAnexosPedido[intCont].strArqB64;
        qryGenGor.ParamByName('APD_NOMARQ').AsString  := arrAnexosPedido[intCont].strNomArq;
        qryGenGor.ExecSQL;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fInsereArrayAnexosPedidosNoBanco]');
      End;
    End;
  Finally
    FreeAndNil(qryGenGor);
  End;
end;

procedure pBaixaTinDor(strNumOrc, strEspOrc, strCodEmp, strVenFat: String; strLisDet: String='');
var
  strSQL: String;
  qryGenTin: TUniQuery;
begin
  qryGenTin := fCriaQuery(nil);
  Try
    If fEmptyStr(strLisDet) Then
    Begin
      strSQL := 'UPDATE TINDOR ' +
                '   SET FDO_BAIXAD =  ''1''  ' +
                '     , FDO_OPEBAI = :OPEBAI ' +
                '     , FDO_HORBAI = ' + fCurrentTime +
                '     , FDO_DTABAI = ' + fCurrentDate +
                ' WHERE FDO_NUMDOC = :NUMDOC ' +
                '   AND FDO_ESPDOC = :ESPDOC ' +
                '   AND FDO_CODEMP = :CODEMP ';

    End
    Else
    Begin
      strSQL := 'UPDATE TINDOR '+
                ' INNER JOIN FATDOR ON FATDOR.FDO_NUMDOC = TINDOR.FDO_NUMDOC '+
                '                  AND FATDOR.FDO_ESPDOC = TINDOR.FDO_ESPDOC '+
                '                  AND FATDOR.FDO_CODEMP = TINDOR.FDO_CODEMP '+
                '                  AND FATDOR.FDO_CODACA = TINDOR.FDO_CODACA '+
                '                  AND FATDOR.FDO_EMPACA = TINDOR.FDO_EMPACA '+
                '                  AND FATDOR.FDO_CODITE = TINDOR.FDO_CODITE '+
                '                  AND FATDOR.FDO_CODCLI = TINDOR.FDO_CODCLI '+
                '   SET TINDOR.FDO_BAIXAD =  ''1''  ' +
                '     , TINDOR.FDO_OPEBAI = :OPEBAI ' +
                '     , TINDOR.FDO_HORBAI = ' + fCurrentTime +
                '     , TINDOR.FDO_DTABAI = ' + fCurrentDate +
                ' WHERE FATDOR.FDO_NUMDOC = :NUMDOC ' +
                '   AND FATDOR.FDO_ESPDOC = :ESPDOC ' +
                '   AND FATDOR.FDO_CODEMP = :CODEMP ' +
                '   AND FATDOR.AUTOINCREM IN ('+strLisDet+') ';
    End;

    With qryGenTin Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('NUMDOC').AsString := strNumOrc;
      ParamByName('ESPDOC').AsString := strEspOrc;

      If fEmptyStr(strCodEmp) Then
        ParamByName('CODEMP').AsString := VS_strCodEmp
      Else
        ParamByName('CODEMP').AsString := strCodEmp;

      If (fEmptyStr(strVenFat)) Then
        ParamByName('OPEBAI').Value := Null
      Else
        ParamByName('OPEBAI').AsString := strVenFat;

      ExecSQL;
      Close;
    End;
  Finally
    FreeAndNil(qryGenTin);
  End;
end;

function fGeraHtml(strNumDoc, strEspDoc: String; blnComPre: Boolean): String;
  Var
    intContador        : Integer;
    strSQL             : String;
    strLinha           : String;
    qryTblFatGor       : TUniQuery;
    qryTblFatDor       : TUniQuery;
    qryTblCadEmp       : TUniQuery;

    strLetDup1         : String;
    strLetDup2         : String;
    strDtaDup1         : String;
    strDtaDup2         : String;
    strValDup1         : String;
    strValDup2         : String;
    strPedidoOrcamento : String;

    arrCorIte          : Array Of String;
    intCorAtu          : Integer;

    strHtmlItens       : String;
    strHtmlParcelas    : String;
    strHtmlTotais      : String;
    strHtmlCabecalho   : String;

    arqHtmlModelo      : TextFile;
    arqHtmlSaida       : TextFile;
    arrDuplicata       : TarrDuplicata;

begin

  If (strEspDoc = 'PD') Then
    strPedidoOrcamento := 'Pedido'
  Else
    strPedidoOrcamento := 'Or&ccedil;amento';

  SetLength(arrCorIte, 2);
  arrCorIte[0] := '#CCCCCC';
  arrCorIte[1] := '#E6E6E6';

  qryTblFatGor := TUniQuery.Create(Nil);
  qryTblFatDor := TUniQuery.Create(Nil);
  qryTblCadEmp := TUniQuery.Create(Nil);

  qryTblFatGor.Connection := frmModulo.GetCurrentConnection;
  qryTblFatDor.Connection := frmModulo.GetCurrentConnection;
  qryTblCadEmp.Connection := frmModulo.GetCurrentConnection;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   FATGOR.*, ';
  strSQL := strSQL + '   CADCLI.*, ';
  strSQL := strSQL + '   IF(FATGOR.FGO_NOMCON IS NULL OR FGO_NOMCON = "", CADCLI.CLI_NOMCLI, FATGOR.FGO_NOMCON) AS FGO_NOMCLI, ';
  strSQL := strSQL + '   IF(FATGOR.FGO_NOMCON IS NULL OR FGO_NOMCON = "", CADCLI.CLI_ENDERE, FATGOR.FGO_ENDCON) AS FGO_ENDERE, ';
  strSQL := strSQL + '   IF(FATGOR.FGO_NOMCON IS NULL OR FGO_NOMCON = "", CADCID.CID_NOMCID, CIDCON.CID_NOMCID) AS FGO_NOMCID, ';
  strSQL := strSQL + '   IF(FATGOR.FGO_NOMCON IS NULL OR FGO_NOMCON = "", CADCLI.CLI_C_G_C_, FATGOR.FGO_CGCCON) AS FGO_C_G_C_, ';
  strSQL := strSQL + '   IF(FATGOR.FGO_NOMCON IS NULL OR FGO_NOMCON = "", CADCLI.CLI_FONE01, FATGOR.FGO_TELCON) AS FGO_FONE01, ';
  strSQL := strSQL + '   IF(FATGOR.FGO_NOMCON IS NULL OR FGO_NOMCON = "", CADCLI.CLI_BAIRRO, FATGOR.FGO_BAICON) AS FGO_BAIRRO, ';
  strSQL := strSQL + '   IF(FATGOR.FGO_NOMCON IS NULL OR FGO_NOMCON = "", CADCLI.CLI_C_E_P_, FATGOR.FGO_CEPCON) AS FGO_C_E_P_, ';
  strSQL := strSQL + '   IF(FATGOR.FGO_NOMCON IS NULL OR FGO_NOMCON = "", CADCLI.CLI_I_E_S_, FATGOR.FGO_IESCON) AS FGO_I_E_S_, ';
  strSQL := strSQL + '   CADOPE.*, ';
  strSQL := strSQL + '   CADCID.CID_NOMCID AS CLI_NOMCID, ';
  strSQL := strSQL + '   CADCID.CID_ESTADO AS CLI_ESTADO ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   FATGOR ';
  strSQL := strSQL + '   JOIN CADCLI ON FATGOR.FGO_CODCLI = CADCLI.CLI_CODCLI ';
  strSQL := strSQL + '   JOIN CADOPE ON FATGOR.FGO_CODVEN = CADOPE.OPE_CODOPE ';
  strSQL := strSQL + '   JOIN CADCID ON CADCLI.CLI_CODCID = CADCID.CID_CODCID ';
  strSQL := strSQL + '   LEFT JOIN CADCID AS CIDCON ON FGO_CIDCON = CIDCON.CID_CODCID ';
  strSQL := strSQL + ' WHERE FATGOR.FGO_NUMDOC = :NUMDOC ';
  strSQL := strSQL + '   AND FATGOR.FGO_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '   AND FATGOR.FGO_CODEMP = :CODEMP ';

  With qryTblFatGor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CADEMP.*, ';
  strSQL := strSQL + '  CADCID.CID_NOMCID AS EMP_NOMCID, ';
  strSQL := strSQL + '  CADCID.CID_ESTADO AS EMP_ESTADO ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADEMP ';
  strSQL := strSQL + '  JOIN CADCID ON CADEMP.EMP_CODCID = CADCID.CID_CODCID';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CADEMP.EMP_CODEMP = :CODEMP ';

  With qryTblCadEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODEMP').AsString := qryTblFatGor.FieldByName('FGO_CODEMP').AsString;
    Open;
  End;

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  FATDOR.*, ';
  strSQL := strSQL + '  CADITE.*, ';
  strSQL := strSQL + '  UNI_SIGUNI AS FDO_SIGUNI, ';
  strSQL := strSQL + '  CADMAR.MAR_DESMAR ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FATDOR ';
  strSQL := strSQL + '  JOIN CADITE ON FATDOR.FDO_CODITE = CADITE.ITE_CODITE ';
  strSQL := strSQL + '  JOIN CADUNI ON CADITE.ITE_CODUNI = UNI_CODUNI ';
  strSQL := strSQL + '  JOIN CADMAR ON CADITE.ITE_CODMAR = CADMAR.MAR_CODMAR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FATDOR.FDO_NUMDOC     = :NUMDOC ';
  strSQL := strSQL + '  AND FATDOR.FDO_ESPDOC = :ESPDOC ';
  strSQL := strSQL + '  AND FATDOR.FDO_CODEMP = :CODEMP ';

  With qryTblFatDor Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDOC').AsString := strNumDoc;
    ParamByName('ESPDOC').AsString := strEspDoc;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    Open;
  End;

  intCorAtu := 0;

  {*******************************************}
  {* HTML COM CABEÇALHO (PREÇO, IPI E TOTAL) *}
  {****************************************MV*}
  strHtmlCabecalho := '';
  If (blnComPre) Then
  Begin
    strHtmlCabecalho := strHtmlCabecalho + ' <td width="9%"><div align="center"><font color="#CCCCCC"><strong><font size="4" face="Verdana, Arial, Helvetica, sans-serif">Pre&ccedil;o<br> ' + #13#10;
    strHtmlCabecalho := strHtmlCabecalho + ' Unit. </font></strong></font></div> ' + #13#10;
    strHtmlCabecalho := strHtmlCabecalho + ' </td> ' + #13#10;
    strHtmlCabecalho := strHtmlCabecalho + ' <td width="9%"><div align="center"><font color="#CCCCCC"><strong><font size="4" face="Verdana, Arial, Helvetica, sans-serif">Pre&ccedil;o<br> ' + #13#10;
    strHtmlCabecalho := strHtmlCabecalho + ' Total </font></strong></font></div> ' + #13#10;
    If (fCfgSis('CONIPI', varBoolean)) Then
    Begin
      strHtmlCabecalho := strHtmlCabecalho + ' <td width="9%"><div align="center"><font color="#CCCCCC"><strong><font size="4" face="Verdana, Arial, Helvetica, sans-serif">VR. IPI ' + #13#10;
      strHtmlCabecalho := strHtmlCabecalho + ' </font></strong></font></div> ' + #13#10;
      strHtmlCabecalho := strHtmlCabecalho + ' </td> ' + #13#10;
    End;
    strHtmlCabecalho := strHtmlCabecalho + ' </td> ' + #13#10;
  End;

  strHtmlItens := '';
  While (Not qryTblFatDor.Eof) Do
  Begin

    strHtmlItens := strHtmlItens + '<tr bgcolor="' + arrCorIte[intCorAtu] + '">' + #13#10;
    strHtmlItens := strHtmlItens + '  <td><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">' + qryTblFatDor.FieldByName('FDO_CODITE').AsString + '</font></div></td>' + #13#10;
    strHtmlItens := strHtmlItens + '  <td><font size="1" face="Verdana, Arial, Helvetica, sans-serif">' + qryTblFatDor.FieldByName('FDO_DESCRI').AsString + ' ' + qryTblFatDor.FieldByName('FDO_COMPLE').AsString + '</font></td>' + #13#10;
    strHtmlItens := strHtmlItens + '  <td><font size="1" face="Verdana, Arial, Helvetica, sans-serif">' + qryTblFatDor.FieldByName('MAR_DESMAR').AsString + '</font></td>' + #13#10;
    strHtmlItens := strHtmlItens + '  <td><div align="center"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">' + qryTblFatDor.FieldByName('FDO_SIGUNI').AsString + '</font></div></td>' + #13#10;
    strHtmlItens := strHtmlItens + '  <td><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">' + FloatToStrF(qryTblFatDor.FieldByName('FDO_QTDITE').AsFloat, ffFixed, 12, 2) + '</font></div></td>' + #13#10;

    If (blnComPre) Then
    Begin
      strHtmlItens := strHtmlItens + '  <td><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">' + FloatToStrF(qryTblFatDor.FieldByName('FDO_UNITAR').AsFloat, ffFixed, 12, 2) + '</font></div></td>' + #13#10;
      strHtmlItens := strHtmlItens + '  <td><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">' + FloatToStrF(qryTblFatDor.FieldByName('FDO_TOTITE').AsFloat, ffFixed, 12, 2) + '</font></div></td>' + #13#10;
      If (fCfgSis('CONIPI', varBoolean)) Then
      Begin
        strHtmlItens := strHtmlItens + '  <td><div align="right"><font size="1" face="Verdana, Arial, Helvetica, sans-serif">' + FloatToStrF(qryTblFatDor.FieldByName('FDO_VALIPI').AsFloat, ffFixed, 12, 2) + '</font></div></td>' + #13#10;
      End;
    End;

    strHtmlItens := strHtmlItens + '</tr>' + #13#10;

    intCorAtu := IIF(intCorAtu = 0, 1, 0);

    qryTblFatDor.Next;
  End;

  {*******************************************}
  {* GERA MATRIZ DE DUPLICATAS               *}
  {****************************************MV*}
  If (fEmptyStr(qryTblFatGor.FieldByName('FGO_CONPAG').AsString))               Or
     (fStatusCndPag(qryTblFatGor.FieldByName('FGO_CONPAG').AsString) = A_VISTA) Then
  Begin
    pZeraDigDuplic(arrDuplicata);
  End
  Else
  Begin
    fDigDuplic(arrDuplicata,
               qryTblFatGor.FieldByName('FGO_CONPAG').AsString,
               qryTblFatGor.FieldByName('FGO_NUMDOC').AsInteger,
               qryTblFatGor.FieldByName('FGO_VLRCON').AsFloat,
               False, True, False,
               qryTblFatGor.FieldByName('FGO_DTAENT').AsDateTime,
               False);
  End;

  strHtmlParcelas := '';

  For intContador := 0 To 5 Do
  Begin

    strLetDup1 := IIF(fEmptyStr(arrDuplicata[intContador].strSequen), '', arrDuplicata[intContador].strSequen + ')');

    If (fStatusCndPag(qryTblFatGor.FieldByName('FGO_CONPAG').AsString) = A_VISTA) And (intContador= 1) Then
       strDtaDup1 := 'A VISTA'
    Else
       strDtaDup1 := IIF(fEmptyStr(arrDuplicata[intContador].dtaDtaVen), '', arrDuplicata[intContador].dtaDtaVen);

    strValDup1 := IIF(fEmptyStr(arrDuplicata[intContador].strSequen), '', FloatToStrF(arrDuplicata[intContador].curValor, ffFixed, 12, 2));

    strLetDup2 := IIF(fEmptyStr(arrDuplicata[intContador+6].strSequen), '', arrDuplicata[intContador+6].strSequen + ')');
    strDtaDup2 := IIF(fEmptyStr(arrDuplicata[intContador+6].dtaDtaVen), '', arrDuplicata[intContador+6].dtaDtaVen);
    strValDup2 := IIF(fEmptyStr(arrDuplicata[intContador+6].strSequen), '', FloatToStrF(arrDuplicata[intContador+6].curValor, ffFixed, 12, 2));

    strHtmlParcelas := strHtmlParcelas + '<tr> ' + #13#10;
    strHtmlParcelas := strHtmlParcelas + '  <td><div align="right"><b><font color="blue">'  + strLetDup1 + '</font></b></div></td> ' + #13#10;
    strHtmlParcelas := strHtmlParcelas + '  <td><div align="center"><b><font color="blue">' + strDtaDup1 + '</font></b></div></td> ' + #13#10;
    strHtmlParcelas := strHtmlParcelas + '  <td><div align="right"><b><font color="blue">'  + strValDup1 + '</font></b></div></td> ' + #13#10;
    strHtmlParcelas := strHtmlParcelas + '  <td></td> ' + #13#10;
    strHtmlParcelas := strHtmlParcelas + '  <td><div align="right"><b><font color="blue">'  + strLetDup2 + '</font></b></div></td> ' + #13#10;
    strHtmlParcelas := strHtmlParcelas + '  <td><div align="center"><b><font color="blue">' + strDtaDup2 + '</font></b></div></td> ' + #13#10;
    strHtmlParcelas := strHtmlParcelas + '  <td><div align="right"><b><font color="blue">'  + strValDup2 + '</font></b></div></td> ' + #13#10;
    strHtmlParcelas := strHtmlParcelas + '  <td></td> ' + #13#10;

    If (intContador = 0) Then
             strHtmlParcelas := strHtmlParcelas + '<td bgcolor="#CCCCCC"><div align="left">' + qryTblFatGor.FieldByName('FGO_MEN001').AsString + '</div></td> ' + #13#10

    Else If (intContador = 1) Then
             strHtmlParcelas := strHtmlParcelas + '<td bgcolor="#CCCCCC"><div align="left">' + qryTblFatGor.FieldByName('FGO_MEN002').AsString + '</div></td> ' + #13#10

    Else If (intContador = 2) Then
             strHtmlParcelas := strHtmlParcelas + '<td bgcolor="#330099"><div align="center"><strong><font color="#FFFFFF" size="3" face="Verdana, Arial, Helvetica, sans-serif">Data do ' + strPedidoOrcamento + ':</font></strong></div></td> ' + #13#10

    Else If (intContador = 3) Then
             strHtmlParcelas := strHtmlParcelas + '<td bgcolor="#CCCCCC"><div align="left">' + qryTblFatGor.FieldByName('FGO_DTAENT').AsString + '</div></td> ' + #13#10

    Else If (intContador = 4) Then
             strHtmlParcelas := strHtmlParcelas + '<td bgcolor="#330099"><div align="center"><strong><font color="#FFFFFF" size="3" face="Verdana, Arial, Helvetica, sans-serif">Validade do ' + strPedidoOrcamento + ':</font></strong></div></td> ' + #13#10

    Else If (intContador = 5) Then
             strHtmlParcelas := strHtmlParcelas + '<td bgcolor="#CCCCCC"><div align="left">' + qryTblFatGor.FieldByName('FGO_DTAENT').AsString + '</div></td> ' + #13#10;

    strHtmlParcelas := strHtmlParcelas + '</tr> ' + #13#10;
  End;

  strHtmlTotais := '';

  If (blnComPre) Then
  Begin

    If (qryTblFatGor.FieldByName('FGO_DESESP').AsFloat > 0) Then
    Begin
      strHtmlTotais := strHtmlTotais + '<tr bgcolor="#330099">' + #13#10;
      strHtmlTotais := strHtmlTotais + '  <td width="88%"><div align="right"><font color="#FFFFFF" size="3" face="Verdana, Arial, Helvetica, sans-serif"><strong>Total do produtos...:</strong></font></div></td>' + #13#10;
      strHtmlTotais := strHtmlTotais + '  <td width="12%"><div align="right"><b><font color="yellow" size="3">' + FloatToStrF(qryTblFatGor.FieldByName('FGO_TOTPRO').AsFloat, ffFixed, 12, 2) + '</font></b></div></td>' + #13#10;
      strHtmlTotais := strHtmlTotais + '</tr>' + #13#10;
      strHtmlTotais := strHtmlTotais + '<tr bgcolor="#0066CC">' + #13#10;
      strHtmlTotais := strHtmlTotais + '  <td width="88%"><div align="right"><font color="#FFFFFF" size="3" face="Verdana, Arial, Helvetica, sans-serif"><strong>Total do desconto...:</strong></font></div></td>' + #13#10;
      strHtmlTotais := strHtmlTotais + '  <td width="12%"><div align="right"><b><font color="yellow" size="3">' + FloatToStrF(qryTblFatGor.FieldByName('FGO_DESESP').AsFloat, ffFixed, 12, 2) + '</font></b></div></td>' + #13#10;
      strHtmlTotais := strHtmlTotais + '</tr>' + #13#10;
    End;

    If  (fCfgSis('CONIPI', varBoolean)) Then
    Begin
      strHtmlTotais := strHtmlTotais + '<tr bgcolor="#330099">' + #13#10;
      strHtmlTotais := strHtmlTotais + '  <td width="88%"><div align="right"><font color="#FFFFFF" size="3" face="Verdana, Arial, Helvetica, sans-serif"><strong>Total do IPI...:</strong></font></div></td>' + #13#10;
      strHtmlTotais := strHtmlTotais + '  <td width="12%"><div align="right"><b><font color="yellow" size="3">' + FloatToStrF(qryTblFatGor.FieldByName('FGO_TOTIPI').AsFloat, ffFixed, 12, 2) + '</font></b></div></td>' + #13#10;
      strHtmlTotais := strHtmlTotais + '</tr>' + #13#10;
    End;

    strHtmlTotais := strHtmlTotais + '<tr bgcolor="#330099">' + #13#10;
    strHtmlTotais := strHtmlTotais + '  <td width="88%"><div align="right"><font color="#FFFFFF" size="3" face="Verdana, Arial, Helvetica, sans-serif"><strong>Total do ' + strPedidoOrcamento + '...:</strong></font></div></td>' + #13#10;
    strHtmlTotais := strHtmlTotais + '  <td width="12%"><div align="right"><b><font color="yellow" size="3">' + FloatToStrF(qryTblFatGor.FieldByName('FGO_VLRCON').AsFloat, ffFixed, 12, 2) + '</font></b></div></td>' + #13#10;
    strHtmlTotais := strHtmlTotais + '</tr>' + #13#10;

  End;


  Result := ExtractFilePath(Application.ExeName) + '\fat' + strEspDoc + '_' + strNumDoc + '.html';

  {*******************************************}
  {* ABRE ARQUIVO MODELO E DE SAIDA          *}
  {****************************************MV*}
  AssignFile(arqHtmlModelo, ExtractFilePath(Application.ExeName) + '\modelo_fat_orcamento.html');
  AssignFile(arqHtmlSaida, Result);

  Reset(arqHtmlModelo);
  Rewrite(arqHtmlSaida);

  While (Not Eof(arqHtmlModelo)) Do
  Begin

    ReadLn(arqHtmlModelo, strLinha);

    {*******************************************}
    {* IMPRIME LOGOTIPO DO CLIENTE SE EXISTIR  *}
    {****************************************AC*}
    If FileExists(fCfgSis('PATLOG')) Then
      strLinha := AnsiReplaceStr(strLinha, '{{PATH_LOGOTIPO}}', '<p align=center> <img src= ' + QuotedStr(fCfgSis('PATLOG')) + ' width="350" height="140"> </p>')
    Else
      strLinha := AnsiReplaceStr(strLinha, '{{PATH_LOGOTIPO}}', '');

    strLinha := AnsiReplaceStr(strLinha, '{{CABECALHO_PRECO}}',  strHtmlCabecalho);
    strLinha := AnsiReplaceStr(strLinha, '{{DADOS_ITENS}}',      strHtmlItens);
    strLinha := AnsiReplaceStr(strLinha, '{{DADOS_PARCELAS}}',   strHtmlParcelas);
    strLinha := AnsiReplaceStr(strLinha, '{{DADOS_TOTAIS}}',     strHtmlTotais);
    strLinha := AnsiReplaceStr(strLinha, '{{PEDIDO_ORCAMENTO}}', strPedidoOrcamento);

    For intContador := 0 To qryTblFatGor.FieldCount -1 Do
    Begin

      If (qryTblFatGor.Fields[intContador].FieldName = 'FGO_CONPAG') Then
      Begin
        strLinha := AnsiReplaceStr(strLinha,
                                   '{{' + 'FATGOR->' + qryTblFatGor.Fields[intContador].FieldName + '}}',
                                   fFormataCondPag(qryTblFatGor.Fields[intContador].AsString));
      End

      Else If (qryTblFatGor.Fields[intContador].DataType = ftFloat)                        And
              (Not fEmptyStr(TFloatField(qryTblFatGor.Fields[intContador]).DisplayFormat)) Then
      Begin
        strLinha := AnsiReplaceStr(strLinha,
                                   '{{' + 'FATGOR->' + qryTblFatGor.Fields[intContador].FieldName + '}}',
                                   FormatFloat(TFloatField(qryTblFatGor.Fields[intContador]).DisplayFormat, qryTblFatGor.Fields[intContador].AsFloat));
      End
      Else
      Begin
        strLinha := AnsiReplaceStr(strLinha,
                                   '{{' + 'FATGOR->' + qryTblFatGor.Fields[intContador].FieldName + '}}',
                                   qryTblFatGor.Fields[intContador].AsString);
      End;
    End;

    For intContador := 0 To qryTblCadEmp.FieldCount -1 Do
    Begin
      strLinha := AnsiReplaceStr(strLinha,
                                 '{{' + 'CADEMP->' + qryTblCadEmp.Fields[intContador].FieldName + '}}',
                                 qryTblCadEmp.Fields[intContador].AsString);
    End;

    WriteLn(arqHtmlSaida, strLinha);

  End;

  CloseFile(arqHtmlModelo);
  CloseFile(arqHtmlSaida);

  FreeAndNil(qryTblFatGor);
  FreeAndNil(qryTblFatDor);
  FreeAndNil(qryTblCadEmp);
end;

procedure pRetNumeroPedido(strNumFat,
                           strTipFat,
                           strEmpFat: String;
                           Var strNumPed,
                           strEspPed,
                           strEmpPed: String);
  Var
    strSQL: String;
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(nil);

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  DISTINCT FDO_NUMDOC, ';
  strSQL := strSQL + '           FDO_ESPDOC, ';
  strSQL := strSQL + '           FDO_CODEMP ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FATDOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  FDO_NUMFAT = :NUMFAT AND ';
  strSQL := strSQL + '  FDO_TIPFAT = :TIPFAT AND ';
  strSQL := strSQL + '  FDO_EMPFAT = :EMPFAT ';

  qryAux.SQL.Text := strSQL;
  qryAux.ParamByName('NUMFAT').AsString := strNumFat;
  qryAux.ParamByName('TIPFAT').AsString := strTipFat;
  qryAux.ParamByName('EMPFAT').AsString := strEmpFat;
  qryAux.Open;

  strNumPed := qryAux.FieldByName('FDO_NUMDOC').AsString;
  strEspPed := qryAux.FieldByName('FDO_ESPDOC').AsString;
  strEmpPed := qryAux.FieldByName('FDO_CODEMP').AsString;

  qryAux.Close;
  FreeAndNil(qryAux);

end;

function fGravaTinGor(Var strAutInc: String;
                      strCodEmp,
                      strCodVen,
                      strNumDoc,
                      strEspDoc: String;
                      dtaDtaEnt,
                      dtaHorEnt: TDateTime;
                      strConPag,
                      strCodCli,
                      strEstado,
                      strNomCon,
                      strEndCon,
                      strBaiCon,
                      strCepCon,
                      strCidCon,
                      strEstCon,
                      strTelCon: String;
                      intCgcCpf: Integer;
                      strCgcCon,
                      strIesCon,
                      strCli_Rg,
                      strJaProd,
                      strMenFor: String): Boolean;
  Var
    qryTinGor: TUniQuery;
Begin

  qryTinGor := fCriaQuery(Nil);
  qryTinGor.SQL.Text := 'SELECT * FROM TINGOR LIMIT 0 ';
  qryTinGor.Open;

  Try

    With qryTinGor Do
    Begin

      If Not Active Then
        Open;

      Insert;
      FieldByName('FGO_CODEMP').AsString   := strCodEmp;
      FieldByName('FGO_CODVEN').AsString   := strCodVen;
      FieldByName('FGO_NUMDOC').AsString   := strNumDoc;
      FieldByName('FGO_ESPDOC').AsString   := strEspDoc;
      FieldByName('FGO_DTAENT').AsDateTime := dtaDtaEnt;
      FieldByName('FGO_HORENT').AsDateTime := dtaHorEnt;
      FieldByName('FGO_CONPAG').AsString   := strConPag;
      FieldByName('FGO_CODCLI').AsString   := strCodCli;

      FieldByName('FGO_NOMCON').AsString   := strNomCon;
      FieldByName('FGO_ESTADO').AsString   := strEstado;

      If Not fEmptyStr(strMenFor) Then
        FieldByName('FGO_MENFOR').AsString := strMenFor;

      If (fEmptyStr(strNomCon)) And (Not fClienteConsumidor(fRetNomCliente(strCodCli), True, True)) Then
      Begin
        FieldByName('FGO_NOMCON').Value := Null;
        FieldByName('FGO_ENDCON').Value := Null;
        FieldByName('FGO_BAICON').Value := Null;
        FieldByName('FGO_CEPCON').Value := Null;
        FieldByName('FGO_CIDCON').Value := Null;
        FieldByName('FGO_ESTCON').Value := Null;
        FieldByName('FGO_TELCON').Value := Null;
        FieldByName('FGO_CGCCPF').Value := Null;
        FieldByName('FGO_CGCCON').Value := Null;
        FieldByName('FGO_IESCON').Value := Null;
        FieldByName('FGO_R_GCON').Value := Null;
      End
      Else
      Begin
        FieldByName('FGO_NOMCON').AsString   := strNomCon;
        FieldByName('FGO_ENDCON').AsString   := strEndCon;
        FieldByName('FGO_BAICON').AsString   := strBaiCon;
        FieldByName('FGO_CEPCON').AsString   := strCepCon;
        FieldByName('FGO_CIDCON').AsString   := strCidCon;
        FieldByName('FGO_ESTCON').AsString   := strEstCon;
        FieldByName('FGO_TELCON').AsString   := strTelCon;
        FieldByName('FGO_CGCCPF').AsInteger  := intCgcCpf;
        FieldByName('FGO_CGCCON').AsString   := strCgcCon;
        FieldByName('FGO_IESCON').AsString   := strIesCon;
        FieldByName('FGO_R_GCON').AsString   := strCli_Rg;
      End;
      FieldByName('FGO_JAPROD').AsString   := strJaProd;
      FieldByName('AUTOINCREM').AsString   := strAutInc;
      Post;

    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGravaTinGor]');
      Result := False;
    End;
  End;

  FreeAndNil(qryTinGor);

end;

function fGravaTinDor(strSeqGer: String;
                      strCodEmp,
                      strCodDiv,
                      strCodMar,
                      strCodIte,
                      strCodVen,
                      strCodCli,
                      strNumDoc,
                      strEspDoc: String;
                      dtaDtaEnt,
                      dtaHorEnt: TDateTime;
                      strConPag,
                      strEstado,
                      strDescri,
                      strRefere,
                      strUnidad,
                      strForIte: String;
                      fltQtdIte: Double;
                      strIncPis,
                      strNotEsp,
                      strIdePro,
                      strIteTin,
                      strIteCha,
                      strDesCor,
                      strTipEmb: String;
                      fltQtdEmb,
                      fltPreEmb: Double;
                      strTipPre,
                      strMontad,
                      strA_n_o_,
                      strForm01,
                      strIteC01: String;
                      fltQtdb01: Double;
                      strForm02,
                      strIteC02: String;
                      fltQtdb02: Double;
                      strForm03,
                      strIteC03: String;
                      fltQtdb03: Double;
                      strForm04,
                      strIteC04: String;
                      fltQtdb04: Double;
                      strForm05,
                      strIteC05: String;
                      fltQtdb05: Double;
                      strForm06,
                      strIteC06: String;
                      fltQtdb06: Double;
                      strForm07,
                      strIteC07: String;
                      fltQtdb07: Double;
                      strForm08,
                      strIteC08: String;
                      fltQtdb08: Double;
                      strForm09,
                      strIteC09: String;
                      fltQtdb09: Double;
                      strForm10,
                      strIteC10: String;
                      fltQtdb10: Double;
                      strForm11,
                      strIteC11: String;
                      fltQtdb11: Double;
                      strForm12,
                      strIteC12: String;
                      fltQtdb12: Double;
                      strForm13,
                      strIteC13: String;
                      fltQtdb13: Double;
                      strForm14,
                      strIteC14: String;
                      fltQtdb14: Double;
                      strForm15,
                      strIteC15: String;
                      fltQtdb15: Double;
                      strForm16,
                      strIteC16: String;
                      fltQtdb16: Double;
                      strForm17,
                      strIteC17: String;
                      fltQtdb17: Double;
                      strForm18,
                      strIteC18: String;
                      fltQtdb18: Double;
                      strForm19,
                      strIteC19: String;
                      fltQtdb19: Double;
                      strForm20,
                      strIteC20: String;
                      fltQtdb20: Double;
                      strCodDig,
                      strCodAca,
                      strEmpAca: String;
                      fltUnitar,
                      fltTotIte: Double;
                      strLinha: String;
                      strCatali: String;
                      strCodDil: String;
                      fltPorDil: Double;
                      strDilCon: String;
                      fltPorCat: Double;
                      intModDil: Integer;
                      strTexBas,
                      strTipCor,
                      strIteCob,
                      strUniver: String;
                      blnBaixad: Boolean;
                      fltFatAce: Double;
                      strCatal_: String;
                      blnTinAut: Boolean;
                      strObsCol: String = '';
                      intTipFor: Integer = 0;
                      strAutIncTinDor : String = ''): Boolean;
  Var
    strAutInc: String;
    qryTinDor: TUniQuery;
Begin

  qryTinDor := fCriaQuery(Nil);
  qryTinDor.SQL.Text := 'SELECT * FROM TINDOR LIMIT 0 ';
  qryTinDor.Open;

  Try

    If fEmptyStr(strAutIncTinDor) Then
      strAutInc := fRetAutoIncrem('TINDOR', strCodEmp)
    Else
      strAutInc := strAutIncTinDor;

    With qryTinDor Do
    Begin

      If Not Active Then
        Open;

      Insert;
      FieldByName('FDO_SEQGER').AsString   := strSeqGer;
      FieldByName('FDO_CODEMP').AsString   := strCodEmp;

      If fEmptyStr(strCodDiv) Then
        FieldByName('FDO_CODDIV').Value := Null
      Else
        FieldByName('FDO_CODDIV').AsString := strCodDiv;

      If (fEmptyStr(strCodMar)) Then
        FieldByName('FDO_CODMAR').Value := Null
      Else
        FieldByName('FDO_CODMAR').AsString := strCodMar;

      FieldByName('FDO_CODITE').AsString   := strCodIte;
      FieldByName('FDO_CODVEN').AsString   := strCodVen;
      FieldByName('FDO_CODCLI').AsString   := strCodCli;
      FieldByName('FDO_NUMDOC').AsString   := strNumDoc;
      FieldByName('FDO_ESPDOC').AsString   := strEspDoc;
      FieldByName('FDO_DTAENT').AsDateTime := dtaDtaEnt;
      FieldByName('FDO_HORENT').AsDateTime := dtaHorEnt;
      FieldByName('FDO_CONPAG').AsString   := strConPag;
      FieldByName('FDO_ESTADO').AsString   := strEstado;
      FieldByName('FDO_DESCRI').AsString   := strDescri;
      FieldByName('FDO_REFERE').AsString   := strRefere;
      FieldByName('FDO_UNIDAD').AsString   := strUnidad;

      If fEmptyStr(strForIte) Then
        FieldByName('FDO_FORITE').Value    := Null
      Else
        FieldByName('FDO_FORITE').AsString := strForIte;

      FieldByName('FDO_QTDITE').AsFloat    := fltQtdIte;
      FieldByName('FDO_INCPIS').AsString   := strIncPis;
      FieldByName('FDO_NOTESP').AsString   := strNotEsp;
      FieldByName('FDO_IDEPRO').AsString   := strIdePro;
      FieldByName('FDO_ITETIN').AsString   := strIteTin;

      If (fEmptyStr(strIteCha)) Then
        FieldByName('FDO_ITECHA').Value := Null
      Else
        FieldByName('FDO_ITECHA').AsString  := strIteCha;

      FieldByName('FDO_DESCOR').AsString   := strDesCor;
      FieldByName('FDO_TIPEMB').AsString   := strTipEmb;
      FieldByName('FDO_QTDEMB').AsFloat    := fltQtdEmb;
      FieldByName('FDO_PREEMB').AsFloat    := fltPreEmb;
      FieldByName('FDO_TIPPRE').AsString   := strTipPre;
      FieldByName('FDO_MONTAD').AsString   := strMontad;
      FieldByName('FDO_A_N_O_').AsString   := strA_n_o_;
      FieldByName('FDO_FORM01').AsString   := strForm01;
      FieldByName('FDO_ITEC01').AsString   := strIteC01;
      FieldByName('FDO_QTDB01').AsFloat    := fltQtdb01;
      FieldByName('FDO_FORM02').AsString   := strForm02;
      FieldByName('FDO_ITEC02').AsString   := strIteC02;
      FieldByName('FDO_QTDB02').AsFloat    := fltQtdb02;
      FieldByName('FDO_FORM03').AsString   := strForm03;
      FieldByName('FDO_ITEC03').AsString   := strIteC03;
      FieldByName('FDO_QTDB03').AsFloat    := fltQtdb03;
      FieldByName('FDO_FORM04').AsString   := strForm04;
      FieldByName('FDO_ITEC04').AsString   := strIteC04;
      FieldByName('FDO_QTDB04').AsFloat    := fltQtdb04;
      FieldByName('FDO_FORM05').AsString   := strForm05;
      FieldByName('FDO_ITEC05').AsString   := strIteC05;
      FieldByName('FDO_QTDB05').AsFloat    := fltQtdb05;
      FieldByName('FDO_FORM06').AsString   := strForm06;
      FieldByName('FDO_ITEC06').AsString   := strIteC06;
      FieldByName('FDO_QTDB06').AsFloat    := fltQtdb06;
      FieldByName('FDO_FORM07').AsString   := strForm07;
      FieldByName('FDO_ITEC07').AsString   := strIteC07;
      FieldByName('FDO_QTDB07').AsFloat    := fltQtdb07;
      FieldByName('FDO_FORM08').AsString   := strForm08;
      FieldByName('FDO_ITEC08').AsString   := strIteC08;
      FieldByName('FDO_QTDB08').AsFloat    := fltQtdb08;
      FieldByName('FDO_FORM09').AsString   := strForm09;
      FieldByName('FDO_ITEC09').AsString   := strIteC09;
      FieldByName('FDO_QTDB09').AsFloat    := fltQtdb09;
      FieldByName('FDO_FORM10').AsString   := strForm10;
      FieldByName('FDO_ITEC10').AsString   := strIteC10;
      FieldByName('FDO_QTDB10').AsFloat    := fltQtdb10;
      FieldByName('FDO_FORM11').AsString   := strForm11;
      FieldByName('FDO_ITEC11').AsString   := strIteC11;
      FieldByName('FDO_QTDB11').AsFloat    := fltQtdb11;
      FieldByName('FDO_FORM12').AsString   := strForm12;
      FieldByName('FDO_ITEC12').AsString   := strIteC12;
      FieldByName('FDO_QTDB12').AsFloat    := fltQtdb12;
      FieldByName('FDO_FORM13').AsString   := strForm13;
      FieldByName('FDO_ITEC13').AsString   := strIteC13;
      FieldByName('FDO_QTDB13').AsFloat    := fltQtdb13;
      FieldByName('FDO_FORM14').AsString   := strForm14;
      FieldByName('FDO_ITEC14').AsString   := strIteC14;
      FieldByName('FDO_QTDB14').AsFloat    := fltQtdb14;
      FieldByName('FDO_FORM15').AsString   := strForm15;
      FieldByName('FDO_ITEC15').AsString   := strIteC15;
      FieldByName('FDO_QTDB15').AsFloat    := fltQtdb15;
      FieldByName('FDO_FORM16').AsString   := strForm16;
      FieldByName('FDO_ITEC16').AsString   := strIteC16;
      FieldByName('FDO_QTDB16').AsFloat    := fltQtdb16;
      FieldByName('FDO_FORM17').AsString   := strForm17;
      FieldByName('FDO_ITEC17').AsString   := strIteC17;
      FieldByName('FDO_QTDB17').AsFloat    := fltQtdb17;
      FieldByName('FDO_FORM18').AsString   := strForm18;
      FieldByName('FDO_ITEC18').AsString   := strIteC18;
      FieldByName('FDO_QTDB18').AsFloat    := fltQtdb18;
      FieldByName('FDO_FORM19').AsString   := strForm19;
      FieldByName('FDO_ITEC19').AsString   := strIteC19;
      FieldByName('FDO_QTDB19').AsFloat    := fltQtdb19;
      FieldByName('FDO_FORM20').AsString   := strForm20;
      FieldByName('FDO_ITEC20').AsString   := strIteC20;
      FieldByName('FDO_QTDB20').AsFloat    := fltQtdb20;
      FieldByName('AUTOINCREM').AsString   := strAutInc;

      If fEmptyStr(strCodDig) Then
        FieldByName('FDO_CODDIG').Value    := Null
      Else
        FieldByName('FDO_CODDIG').AsString := strCodDig;

      If fEmptyStr(strCodAca) Then
        FieldByName('FDO_CODACA').Value := Null
      Else
        FieldByName('FDO_CODACA').AsString := strCodAca;

      If fEmptyStr(strEmpAca) Then
        FieldByName('FDO_EMPACA').Value := Null
      Else
        FieldByName('FDO_EMPACA').AsString := strEmpAca;

      FieldByName('FDO_UNITAR').AsFloat    := fltUnitar;
      FieldByName('FDO_TOTITE').AsFloat    := fltTotIte;


      {********************************************}
      {* CAMPOS PARA TINTAS COM DILUIÇÃO DINAMICA *}
      {*****************************************PH*}
      FieldByName('FDO_LINLIN').AsString := strLinha;
      FieldByName('FDO_CATALI').AsString := strCatali;
      FieldByName('FDO_CODDIL').AsString := strCodDil;
      FieldByName('FDO_PORDIL').AsFloat := fltPorDil;
      FieldByName('FDO_DILCON').AsString := strDilCon;
      FieldByName('FDO_PORCAT').AsFloat := fltPorCat;

      If (blnBaixad) Then
      Begin
        FieldByName('FDO_BAIXAD').AsString   := 'S';
        FieldByName('FDO_OPEBAI').AsString   := strLoginUsuarioLogado;
        FieldByName('FDO_DTABAI').AsDateTime := VS_DATE;
        FieldByName('FDO_HORBAI').AsDateTime := fTime();
      End Else
        FieldByName('FDO_BAIXAD').AsString := 'N';

      FieldByName('FDO_TINAUT').AsInteger := IIF(blnTinAut, 1, 0);

      FieldByName('FDO_OBSCOL').AsString  := strObsCol;
      FieldByName('FDO_TIPFOR').AsInteger := IntTipFor;

      Post;

    End;

    If Not fEmptyStr(strCodAca) Then
    Begin
      fGravaForTin(strCodAca, strTexBas, strTipCor, intModDil, strEmpAca, strIteCob, strUniver, fltFatAce, strCatal_);
    End;

    Result := True;

  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGravaTinGor]');
      Result := False;
    End;

  End;

  FreeAndNil(qryTinDor);

End;

function fSelecionaStatusSepImp(strNumOrc, strEspOrc, strCodEmp: String): String;
var
  qryCons: TUniQuery;
begin
  Result := '0';
  Try
    Try
      qryCons := fCriaQuery(nil);
      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT FGO_SEPIMP ');
        SQL.Add('   FROM FATGOR     ');
        SQL.Add('  WHERE FGO_NUMDOC = :NUMDOC ');
        SQL.Add('    AND FGO_ESPDOC = :ESPDOC ');
        SQL.Add('    AND FGO_CODEMP = :CODEMP ');
        ParamByName('NUMDOC').AsString := strNumOrc;
        ParamByName('ESPDOC').AsString := strEspOrc;
        ParamByName('CODEMP').AsString := strCodEmp;
        Open;

        If Not fEmptyStr(FieldByName('FGO_SEPIMP').AsString) Then
          Result := FieldByName('FGO_SEPIMP').AsString;
      End;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[fSelecionaStatusSepImp]');
      end;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

procedure pLiberarPedidoDiretoParaConferencia(strNumDoc, strEspDoc, strEmpDoc: String; blnAtualizarSomenteItens: Boolean = False);
Var
  qryUpd: TUniQuery;
  strEntRet: String;
  strLocRet: String;
  strPegou_: String;
  strCodVen: String;
  strSQL: string;

  function fFatDor(strCampo: String): String;
  begin
    Result := fCampoTabela(strCampo,
      'FATDOR INNER JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM',
      ['FDO_NUMDOC', 'FDO_ESPDOC', 'FDO_CODEMP'],
      [strNumDoc, strEspDoc, strEmpDoc]);
  end;

begin
  If Not fUsaRotinaExpedicaoConferenciaRetiraCaixa Then
    Exit;

  If strEspDoc <> 'PD' Then
    Exit;

  strEntRet := fFatDor('GROUP_CONCAT(DISTINCT FDO_ENTRET)');
  strPegou_ := fFatDor('GROUP_CONCAT(DISTINCT FDO_PEGOU_)');
  strLocRet := fFatDor('GROUP_CONCAT(DISTINCT FDO_LOCRET)');
  strCodVen := fFatDor('FDO_CODVEN');

  Try
    qryUpd := fCriaQuery;

    qryUpd.Close;

    strSQL := '';
    strSQL := strSQL + ' UPDATE FATGOR, EXTGOR, FATDOR, EXTDOR ' +
                       '   SET FDO_OPBXSE = :OPBXSE,           ' +
                       '       FDO_DTBXSE = :DTBXSE,           ' +
                       '       FDO_HRBXSE = :HRBXSE,           ' +
                       '       FDO_QTDSEP = FDO_QTDITE         ' +
                       ' WHERE EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ' +
                       '   AND FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ' +
                       '   AND EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ' +
                       '   AND FATGOR.FGO_NUMDOC = :NUMDOC ' +
                       '   AND FATGOR.FGO_ESPDOC = :ESPDOC ' +
                       '   AND FATGOR.FGO_CODEMP = :CODEMP ' ;

    If fUsaRotinaWMS(VS_strCodEmp) Then
    Begin
      strSQL := strSQL + '   AND EXTDOR.FDO_PEGOU_ = "S"     ';
      strSQL := strSQL + '   AND EXTDOR.FDO_ENTRET = "R"     ';
    End
    Else
    Begin
      strSQL := strSQL + '   AND (EXTDOR.FDO_PEGOU_ = "S" OR EXTDOR.FDO_LOCRET = "C") ';
      strSQL := strSQL + '   AND EXTDOR.FDO_ENTRET = "R"     ';
    End;

    qryUpd.SQL.Text := strSQL;

    qryUpd.ParamByName('OPBXSE').AsString   := strCodVen;
    qryUpd.ParamByName('DTBXSE').AsDateTime := VS_Date;
    qryUpd.ParamByName('HRBXSE').AsDateTime := fRetHoraServidor;
    qryUpd.ParamByName('NUMDOC').AsString   := strNumDoc;
    qryUpd.ParamByName('ESPDOC').AsString   := strEspDoc;
    qryUpd.ParamByName('CODEMP').AsString   := strEmpDoc;
    qryUpd.ExecSQL;

    If (strEntRet <> 'R') Then
      Exit;

    If fUsaRotinaWMS(VS_strCodEmp) Then
      If (strPegou_ <> 'S') ThEn
        Exit;

    If Not fUsaRotinaWMS(VS_strCodEmp) Then
    Begin
      If (strPegou_ <> 'S') and (strLocRet = 'C') Then
        Exit
      Else If (strPegou_ <> 'S') and (strLocRet = 'E') Then
        Exit
    End;

    If blnAtualizarSomenteItens Then
      Exit;

    { Se o documento possui somente itens de retira como ja pegou entao marca como conferido }
    qryUpd.Close;
    qryUpd.SQL.Text := ' UPDATE FATGOR, EXTGOR, FATDOR, EXTDOR ' +
                       '   SET FGO_OPBXSE = :OPBXSE,           ' +
                       '       FGO_DTBXSE = :DTBXSE,           ' +
                       '       FGO_HRBXSE = :HRBXSE,           ' +
                       '       FGO_SEPIMP = 1                  ' +
                       ' WHERE EXTGOR.FGO_SEQFGO = FATGOR.AUTOINCREM ' +
                       '   AND FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM ' +
                       '   AND EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM ' +
                       '   AND FATGOR.FGO_NUMDOC = :NUMDOC ' +
                       '   AND FATGOR.FGO_ESPDOC = :ESPDOC ' +
                       '   AND FATGOR.FGO_CODEMP = :CODEMP ' ;

    qryUpd.ParamByName('OPBXSE').AsString   := strCodVen;
    qryUpd.ParamByName('DTBXSE').AsDateTime := VS_Date;
    qryUpd.ParamByName('HRBXSE').AsDateTime := fRetHoraServidor;
    qryUpd.ParamByName('NUMDOC').AsString   := strNumDoc;
    qryUpd.ParamByName('ESPDOC').AsString   := strEspDoc;
    qryUpd.ParamByName('CODEMP').AsString   := strEmpDoc;
    qryUpd.ExecSQL;
  Finally
    FreeAndNil(qryUpd);
  End;

end;

procedure pLimpaExtLar(const AIncFatGor: string);
  var
    qryDelete : TUniQuery;
begin
  qryDelete := fCriaQuery;
  try
    qryDelete.SQL.Text := 'DELETE FROM EXTLAR WHERE COD_FATGOR = :INCGOR';
    qryDelete.ParamByName('INCGOR').AsString := AIncFatGor;
    qryDelete.ExecSQL;
  finally
    FreeAndNil(qryDelete);
  end;
end;

function fItensConferidosNaoFaturados(strAutInc : String): Boolean;
  Var
    qryConsulta : TUniQuery;
begin
  Result := False;

  If fEmptyStr(strAutInc) Then
    Exit;

  qryConsulta := fCriaQuery;
  Try
    qryConsulta.Close;
    qryConsulta.SQL.Clear;
    qryConsulta.SQL.Text :=
      ' SELECT D.AUTOINCREM ' +
      ' FROM EXTDOR E ' +
      '   INNER JOIN FATDOR D ON D.AUTOINCREM = E.FDO_SEQFDO ' +
      ' WHERE E.FDO_QTDEXP > 0 ' +
      '   AND D.FDO_JAFATU = 0 ' +
      '   AND D.FDO_SEQGER IN ('+strAutInc+') ';
    qryConsulta.Open;

    Result := qryConsulta.RecordCount > 0;
  Finally
    FreeAndNil(qryConsulta);
  End;
end;

function fValidouLimpaExpedicaoPedido(var blnExcluirExtLar: Boolean; const strAutInc : String; const blnFatAut: Boolean = False; const opcExcluirExtLar: TExcluirExtLarOpcoes = eeloPerguntar): Boolean;
  Var
    qryExtLat: TUniQuery;
    qryGen : TUniQuery;
    strTravaColetor : String;

  procedure pCarregaFatGor;
  begin
    qryGen.Close();
    qryGen.SQL.Clear();
    qryGen.SQL.Add('SELECT G.AUTOINCREM, G.FGO_CODCLI, G.FGO_NUMDOC,   ');
    qryGen.SQL.Add('       G.FGO_ESPDOC, G.FGO_CODEMP, G.FGO_JAFATU,   ');
    qryGen.SQL.Add('       G.FGO_MOTBAI, G.FGO_NUMDOC, G.FGO_ESPDOC,   ');
    qryGen.SQL.Add('       G.FGO_CODEMP, E.FGO_EMPEXP                  ');
    qryGen.SQL.Add('FROM FATGOR G                                      ');
    qryGen.SQL.Add('INNER JOIN EXTGOR E ON G.AUTOINCREM = E.FGO_SEQFGO ');
    qryGen.SQL.Add('WHERE G.AUTOINCREM = :AUTOINCREM                   ');

    qryGen.ParamByName('AUTOINCREM').AsString := strAutInc;

    qryGen.Open();
  end;

begin
  Result := True;
  qryGen := fCriaQuery(Nil);
  Try
    pCarregaFatGor;
    strTravaColetor := 'FATGOR' +
                          qryGen.FieldByName('FGO_NUMDOC').AsString +
                          qryGen.FieldByName('FGO_ESPDOC').AsString +
                          qryGen.FieldByName('FGO_CODEMP').AsString +
                          STR_TRAVA_COLETOR;

    If (fVerificaLockAtivo(strTravaColetor)) then
    Begin
      fRollBack;
      fMensagem('ATENÇÃO!', 'O pedido '+ qryGen.FieldByName('FGO_NUMDOC').AsString +
                              ' está em uso pelo operador ' + fGetHostLock(strTravaColetor) + '!', ['&OK']);
      Result := False;
      Exit;
    End;

    If (qryGen.FieldByName('FGO_JAFATU').AsInteger = 1) And (Not blnFatAut) Then
    Begin
      fRollBack;
      fMensagem('ATENÇÃO!', 'Esse ' + IIF(qryGen.FieldByName('FGO_ESPDOC').AsString = 'PD','pedido','orçamento') +
                            ' já foi ' + IIF(fEmptyStr(qryGen.FieldByName('FGO_MOTBAI').AsString), 'faturado', 'baixado') + '!', ['&OK']);
      Result := False;
      Exit;
    End;

    if fCfgSis('TLEXOL', varBoolean) and (qryGen.FieldByName('FGO_EMPEXP').AsString <> VS_strCodEmp) then
    begin
      fRollBack;
      fMensagem('ATENÇÃO!', 'Este Pedido de Venda será atendido pela loja ' + qryGen.FieldByName('FGO_EMPEXP').AsString +
                            ', solicite ao separador limpar a separação, e posteriormente realize a baixa do pedido.', ['&OK']);
      Result := False;
      Exit;
    end;

    if fExistemItensSeparadosLocTransitoriaVAGAO(qryGen.FieldByName('AUTOINCREM').AsString) then
    begin
      fRollBack;
      fMensagem('ATENÇÃO!', 'Este Pedido de Venda possui item(ns) separado(s) na localização transitória (VAGÃO). ' +
                    'Não será possível limpar a separação.', ['&OK']);
      Result := False;
      Exit;
    end;

    if fCfgSis('SEPCON', VarBoolean) then
    begin
      if opcExcluirExtLar = eeloPerguntar then
      begin
        qryExtLat := fCriaQuery;
        try
          qryExtLat.SQL.Add('SELECT AUTOINCREM FROM EXTLAR WHERE COD_FATGOR = :AUTINC');
          qryExtLat.ParamByName('AUTINC').AsString := strAutInc;
          qryExtLat.Open;
          if not qryExtLat.IsEmpty then
            blnExcluirExtLar := (fMensagem('', 'Deseja limpar os locais de armazenamento?', ['&Sim', '&Não'], 2) = 1)
          else
            blnExcluirExtLar := False;

        finally
          FreeAndNil(qryExtLat);
        end;
      end
      else
        blnExcluirExtLar := opcExcluirExtLar = eeloExcluir;
    end
    else
      blnExcluirExtLar := True;
  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure pGravarLogLpv(strCodOpe: String; strNumDoc: String; strEspDoc: String;
  strCodEmp: String; strCodCli: String);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Nil);
  Try
    qryAux.SQL.Add('INSERT INTO LOGLPV (');
    qryAux.SQL.Add('  AUTOINCREM, ');
    qryAux.SQL.Add('  LOG_CODOPE, ');
    qryAux.SQL.Add('  LOG_DTAATU, ');
    qryAux.SQL.Add('  LOG_HORATU, ');
    qryAux.SQL.Add('  LOG_CODEMP, ');
    qryAux.SQL.Add('  LOG_CODCLI, ');
    qryAux.SQL.Add('  LOG_ESPDOC, ');
    qryAux.SQL.Add('  LOG_NUMDOC ');

    qryAux.SQL.Add(') VALUES ( ');

    qryAux.SQL.Add('  :AUTINC, ');
    qryAux.SQL.Add('  :CODOPE, ');
    qryAux.SQL.Add('  :DTAATU, ');
    qryAux.SQL.Add('  :HORATU, ');
    qryAux.SQL.Add('  :CODEMP, ');
    qryAux.SQL.Add('  :CODCLI, ');
    qryAux.SQL.Add('  :ESPDOC, ');
    qryAux.SQL.Add('  :NUMDOC) ');

    qryAux.ParamByName('AUTINC').AsString   := fRetAutoIncrem('LOGLPV', strCodEmp);
    qryAux.ParamByName('CODOPE').AsString   := strCodOpe;
    qryAux.ParamByName('DTAATU').AsDateTime := VS_Date;
    qryAux.ParamByName('HORATU').AsDateTime := fRetHoraServidor;
    qryAux.ParamByName('CODEMP').AsString   := strCodEmp;
    qryAux.ParamByName('CODCLI').AsString   := strCodCli;
    qryAux.ParamByName('ESPDOC').AsString   := strEspDoc;
    qryAux.ParamByName('NUMDOC').AsString   := strNumDoc;
    qryAux.ExecSQL;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fLimpaExpedicaoPedido(strAutInc : String; blnFatAut: Boolean = False; opcExcluirExtLar: TExcluirExtLarOpcoes = eeloPerguntar; blnLimpaLotDor: Boolean = True;
  ASeqsFDO: String = ''): Boolean;
  Var
    qryUpdate : TUniQuery;
    blnCommit : Boolean;
    qryGen: TUniQuery;
    qryDor: TUniQuery;
    objSeparacaoFina : TSeparacaoFina;
    blnExcluirExtLar: Boolean;
    LobjReprocessarSaldoItens: IReprocessarSaldoItem;
    LLisNumLot : String;

  procedure pCarregaFatGor;
  begin
    qryGen.Close;
    qryGen.SQL.Text :=
      ' SELECT G.AUTOINCREM,  ' +
      '        G.FGO_CODCLI,  ' +
      '        G.FGO_NUMDOC,  ' +
      '        G.FGO_ESPDOC,  ' +
      '        G.FGO_CODEMP   ' +
      '   FROM FATGOR G       ' +
      '  WHERE G.AUTOINCREM = :AUTOINCREM ';

    qryGen.ParamByName('AUTOINCREM').AsString := strAutInc;

    qryGen.Open;

    qryGen.First;
  end;

  procedure pCarregaFatDor;
    Var
      LEmpresa: String;
      LEmpresas: TArray<String>;
      LUtiWms: Boolean;
  begin
    LUtiWms := fUsaRotinaWMS;

    qryDor.Close;
    qryDor.SQL.Text :=
      ' SELECT D.AUTOINCREM, ' +
      '        D.FDO_CODITE, ' +
      '        D.FDO_NUMLOT, ' +
      '        L.LDO_NUMLOT  ' +
      '  FROM FATDOR D       ' +
      '      LEFT JOIN LOTDOR L ON L.LDO_SEQFDO = D.AUTOINCREM '+
      ' WHERE D.FDO_SEQGER = :AUTOINCREM ';

    qryDor.ParamByName('AUTOINCREM').AsString := strAutInc;

    qryDor.Open;

    qryDor.First;

    While Not qryDor.Eof Do
    Begin
      If LUtiWms Then
      Begin
        If (qryDor.FieldByName('FDO_NUMLOT').AsString <> '') Then
          pIncrementaListaStr(qryDor.FieldByName('FDO_NUMLOT').AsString, LLisNumLot, True, True);

        If (qryDor.FieldByName('LDO_NUMLOT').AsString <> '') Then
          pIncrementaListaStr(qryDor.FieldByName('LDO_NUMLOT').AsString, LLisNumLot, True, True);
      End;

      LEmpresas := untFuncoesGenerica.fGetEmpresasReprocessarItemPedido(qryDor.FieldByName('AUTOINCREM').AsString);

      For LEmpresa In LEmpresas Do
        LobjReprocessarSaldoItens.AddItem(TItemReprocessarSaldo.New.Codigo(qryDor.FieldByName('FDO_CODITE').AsString).Empresa(LEmpresa));

      qryDor.Next;
    End;
  end;

Begin
  blnCommit := not fInTransaction();

  qryUpdate := fCriaQuery();
  qryGen    := fCriaQuery();
  qryDor    := fCriaQuery();

  LobjReprocessarSaldoItens := TReprocessarSaldoItem.New();
  Try
    blnExcluirExtLar := False;

    pCarregaFatGor;

    If Not fValidouLimpaExpedicaoPedido(blnExcluirExtLar, strAutInc, blnFatAut, opcExcluirExtLar) Then
    Begin
      Result := False;
      Exit;
    End;

    pCarregaFatDor;

    Try
      If blnCommit Then
        fStartTransaction();

      If fUsaRotinaWMS Then
        fGerarTLItensSeparadosLocTransitoriaVAGAO(strAutInc);

      fGerarPedidoReservaEstoqueParaEnderecamentoProdutosSeparados(
        qryGen.FieldByName('FGO_NUMDOC').AsString,
        qryGen.FieldByName('FGO_ESPDOC').AsString,
        qryGen.FieldByName('FGO_CODEMP').AsString);

      With qryUpdate, SQL Do
      Begin
        {Limpa informações da separação}
        Close;
        SQL.Clear;
        SQL.Add('UPDATE    ');
        SQL.Add('  FATGOR, ');
        SQL.Add('  EXTGOR  ');
        SQL.Add('SET  ');
        SQL.Add('  FGO_EXTSEP = "S",  '); {<<== Extorno da Separação}
        SQL.Add('  FGO_OPESSE = ' + QuotedStr(strLoginUsuarioLogado) + ', ');
        SQL.Add('  FGO_SEPIMP = "0",  ');
        SQL.Add('  FGO_DTIMSE = NULL, ');
        SQL.Add('  FGO_HRIMSE = NULL, ');
        SQL.Add('  FGO_SEPEXP = NULL, ');
        SQL.Add('  FGO_PEDIMP = "N",  ');

        {Remessa de Separação}
        SQL.Add('  FGO_SEQOND = NULL, ');
        SQL.Add('  FGO_DTAOND = NULL, ');
        SQL.Add('  FGO_ONDUNI = "N",  ');
        SQL.Add('  FGO_ONDKIT = NULL, ');

        {Remessa de Pedido/Onda de Separação}
        SQL.Add('  FGO_SEQSEP = NULL, ');
        SQL.Add('  FGO_ONDAOP = NULL, ');
        SQL.Add('  FGO_ONDADT = NULL, ');
        SQL.Add('  FGO_ONDAHR = NULL, ');

        {Dados da Baixa}
        SQL.Add('  FGO_DTBXSE = NULL, ');
        SQL.Add('  FGO_HRBXSE = NULL, ');
        SQL.Add('  FGO_OPBXSE = NULL, ');
        SQL.Add('  FGO_OPEEXP = NULL, ');
        SQL.Add('  FGO_DTLBEX = NULL, ');
        SQL.Add('  FGO_HRLBEX = NULL  ');

        SQL.Add('WHERE ');
        SQL.Add('  FATGOR.AUTOINCREM = ' + QuotedStr(strAutInc) + ' AND ');
        SQL.Add('  FATGOR.AUTOINCREM = EXTGOR.FGO_SEQFGO ');
        ExecSQL;

        {Limpa LOTDOR}
        If (fUsaRotinaWms) And (blnLimpaLotDor) Then
        Begin
          pVerificaIntegridadeLOTDOR(strAutInc);

          Close;
          SQL.Clear;

          SQL.Add(' DELETE FROM LOTDOR USING LOTDOR, FATDOR ');
          SQL.Add(' WHERE LOTDOR.LDO_SEQFDO = FATDOR.AUTOINCREM AND FDO_SEQGER = ' + QuotedStr(strAutInc) );

          if (not fEmptyStr(ASeqsFDO)) then
          begin
            SQL.Add(' AND FATDOR.AUTOINCREM IN (' + ASeqsFDO + ')');
            SQL.Add(' AND IFNULL(LOTDOR.LDO_QTDSEP, 0) = 0 ');
          end;

          ExecSQL;
        End;

        Close;
        SQL.Clear;

        SQL.Add(' UPDATE EXTDOR X ');
        SQL.Add('   INNER JOIN FATDOR D ON D.AUTOINCREM = X.FDO_SEQFDO ');

        If (fCfgSis('FATAUT', varString) = 'S') And
           (blnFatAut) Then
          SQL.Add(' SET FDO_QTDSEP = 0, ')
        Else
          SQL.Add(' SET FDO_QTDSEP = FDO_QTDBAI, ');

        SQL.Add('     FDO_DTBXSE = NULL, ');
        SQL.Add('     FDO_HRBXSE = NULL, ');
        SQL.Add('     FDO_OPBXSE = NULL, ');
        SQL.Add('     FDO_OPEEXP = NULL, ');
        SQL.Add('     FDO_OPESEP = NULL, ');
        SQL.Add('     FDO_QTDEXP = 0, ');
        SQL.Add('     FDO_SEPPAR = "N"   ');

        if fUsaOndaSeparacaoAgrupamento() then
        begin
          SQL.Add('  ,FDO_DTASTA = NULL ');
          SQL.Add('  ,FDO_HRASTA = NULL ');
        end;

        SQL.Add(' WHERE FDO_SEQGER = ' + QuotedStr(strAutInc) );

        if (not fEmptyStr(ASeqsFDO)) then
          SQL.Add(' AND D.AUTOINCREM IN (' + ASeqsFDO + ')');

        ExecSQL;
      End;

      if blnExcluirExtLar then
        pLimpaExtLar(strAutInc);

      objSeparacaoFina := TSeparacaoFina.Create(tdsPedido, qryGen.FieldByName('FGO_CODEMP').AsString);
      try
        objSeparacaoFina.strNumeroDocumento := qryGen.FieldByName('FGO_NUMDOC').AsString;
        objSeparacaoFina.pLimpaSeparacaoEConferenciaStatus;
      finally
        FreeAndNil(objSeparacaoFina);
      end;

      pLiberarPedidoDiretoParaConferencia(qryGen.FieldByName('FGO_NUMDOC').AsString,
                                          qryGen.FieldByName('FGO_ESPDOC').AsString,
                                          qryGen.FieldByName('FGO_CODEMP').AsString, True);

      If fImpressaoParcialConsiderandoJaImpresso Then
      Begin
        qryUpdate.Close;
        qryUpdate.SQL.Clear;
        qryUpdate.SQL.Add('SELECT * FROM SEPPAR');
        qryUpdate.SQL.Add('WHERE SEP_NUMDOC = :NUMDOC');
        qryUpdate.SQL.Add('  AND SEP_ESPDOC = :ESPDOC');
        qryUpdate.SQL.Add('  AND SEP_CODEMP = :CODEMP');

        qryUpdate.ParamByName('NUMDOC').AsString := qryGen.FieldByName('FGO_NUMDOC').AsString;
        qryUpdate.ParamByName('ESPDOC').AsString := qryGen.FieldByName('FGO_ESPDOC').AsString;
        qryUpdate.ParamByName('CODEMP').AsString := qryGen.FieldByName('FGO_CODEMP').AsString;
        qryUpdate.Open;

        qryUpdate.First;
        While Not qryUpdate.Eof Do
        Begin
          fVerificaIntegridade('', 'SEPPAR', qryUpdate);
          qryUpdate.Delete;
        End;
      End;

      pGravarLogLpv(strLoginUsuarioLogado,
                    qryGen.FieldByName('FGO_NUMDOC').AsString,
                    qryGen.FieldByName('FGO_ESPDOC').AsString,
                    qryGen.FieldByName('FGO_CODEMP').AsString,
                    qryGen.FieldByName('FGO_CODCLI').AsString);

      TUpdateStatus.New(TParamStatus.New()
                          .NumDoc(qryGen.FieldByName('FGO_NUMDOC').AsString)
                          .EspDoc(qryGen.FieldByName('FGO_ESPDOC').AsString)
                          .CodEmp(qryGen.FieldByName('FGO_CODEMP').AsString)
                          .CodCli(qryGen.FieldByName('FGO_CODCLI').AsString)).pExecute();

      LobjReprocessarSaldoItens.NotificarRoboParaReprocessarSaldos(0, (Not LLisNumLot.IsEmpty), LLisNumLot);

      If blnCommit Then
        fCommit();

      Result := True;

    Except
      On E : Exception Do
      Begin
        fRollBack;
        Result := False;
        pMensagensErro(E.message, 'fLimpaExpedicaoPedido');
      End;
    End;

  Finally
    FreeAndNil(qryUpdate);
    FreeAndNil(qryGen);
    FreeAndNil(qryDor);
  End;

End;

function fGerarTLItensSeparadosLocTransitoriaVAGAO(const ASeqGer: String): Boolean;
var
  LNumLot,
  LLocFis,
  LLoteTA: String;
  LQry: TUniQuery;
  LItensTL: TUniClientDataSet;
  LCadLot: TCadLot;
  LTransf: TTransferenciaArmazens;
begin
  Result := True;

  if (not fGuardarItensSeparadosQuandoUtilizarLocTransitoriaVAGAO) then
    Exit;

  LQry := fCriaQuery;
  LCadLot := TCadLot.Create(nil);

  try
    try
      LLoteTA := fCfgSis('LTTAPC', varString);
      LLocFis := fCfgSis('LCTAPC', varString);

      if fEmptyStr(LLocFis) or fEmptyStr(LLoteTA) then
      begin
        raise Exception.Create('É necessário definir as configurações [CFG_LCTAPC] e [CFG_LTTAPC] para guardar os itens.');
        Exit;
      end;

      LQry.SQL.Add('SELECT FDO_NUMDOC NUMFAT, FDO_ESPDOC TIPFAT, FDO_CODEMP EMPFAT, FDO_CODCLI CODCLI, FDO_CODITE CODITE, ');
      LQry.SQL.Add('  LDO_QTDSEP QTDITE, LDO_NUMLOT NUMLOT, FDO_CODEMP CODEMP, FGO_EMPEXP EMPEXP, LOT_DTAVAL DTAVAL ');
      LQry.SQL.Add('FROM FATDOR F ');
      LQry.SQL.Add('INNER JOIN LOTDOR L ON (L.LDO_SEQFDO = F.AUTOINCREM) ');
      LQry.SQL.Add('INNER JOIN EXTGOR E ON FDO_SEQGER = FGO_SEQFGO ');
      LQry.SQL.Add('LEFT  JOIN CADLOT   ON FDO_CODITE = LOT_CODITE ');
      LQry.SQL.Add('                   AND LDO_NUMLOT = LOT_NUMLOT ');
      LQry.SQL.Add('                   AND FGO_EMPEXP = LOT_CODEMP ');
      LQry.SQL.Add('WHERE FDO_SEQGER = :SEQGER ');
      LQry.SQL.Add('  AND LDO_QTDSEP > 0 ');
      LQry.SQL.Add('  AND (LEFT(LDO_NUMLOT, 1) = "' + fCfgSis('LTTALC', varString) + '" ');
      LQry.SQL.Add('  OR (LEFT(LDO_NUMLOT, 1) = "L" ');
      LQry.SQL.Add('  AND EXISTS (SELECT LOT_NUMLOT ');
      LQry.SQL.Add('              FROM CADLOT ');
      LQry.SQL.Add('              WHERE LDO_NUMLOT = LOT_NUMLOT ');
      LQry.SQL.Add('                AND FDO_CODITE = LOT_CODITE ');
      LQry.SQL.Add('                AND LOT_CODEMP = IFNULL(FGO_EMP_CD, IFNULL(FDO_EMPITE, FDO_CODEMP)) ');
      LQry.SQL.Add('                AND LOT_TRANSI = "S"))) ');
      LQry.ParamByName('SEQGER').AsString := ASeqGer;
      LQry.Open;

      if LQry.IsEmpty then
        Exit;

      pCriaDataSetItensTL(LItensTL);
      LTransf := TTransferenciaArmazens.Create(nil, LItensTL, Nil, nil);

      while not LQry.Eof do
      begin
        if (not fCfgSis('MDTVGI', varBoolean)) then
        begin
          if (not LCadLot.fExisteLote(LQry.FieldByName('CODITE').AsString,
                                      LQry.FieldByName('EMPEXP').AsString,
                                      LLoteTA,
                                      False,
                                      False)) then
            LCadLot.GeraLoteAtivo(LQry.FieldByName('CODITE').AsString, LLoteTA, LLocFis, '', True);

          LNumLot := LLoteTA;
        end
        else
        begin
          LNumLot := LCadLot.fRetornaLoteGuardar(LLoteTA,
                                                 LQry.FieldByName('CODITE').AsString,
                                                 LQry.FieldByName('EMPEXP').AsString,
                                                 LLocFis,
                                                 LQry.FieldByName('DTAVAL').AsDateTime);
        end;

        if fFormataFloat(LQry.FieldByName('QTDITE').AsFloat, 4) > 0 then
        begin
          LItensTL.Append;
          LItensTL.FieldByName('CODITE').AsString := LQry.FieldByName('CODITE').AsString;
          LItensTL.FieldByName('ARMDES').AsString := LNumLot;
          LItensTL.FieldByName('ARMORI').AsString := LQry.FieldByName('NUMLOT').AsString;
          LItensTL.FieldByName('QTDITE').AsFloat  := LQry.FieldByName('QTDITE').AsFloat;
          LItensTL.Post;
        end;

        LQry.Next;
      end;

      LTransf.strDocFat := LQry.FieldByName('NUMFAT').AsString;
      LTransf.strEspFat := LQry.FieldByName('TIPFAT').AsString;
      LTransf.strEmpFat := LQry.FieldByName('EMPFAT').AsString;
      LTransf.strCliFat := LQry.FieldByName('CODCLI').AsString;

      if (not LItensTL.IsEmpty) then
        Result := LTransf.fGeraTransferencia(True, False);
    except
      on e: Exception do
        raise;
    end;
  finally
    FreeAndNil(LCadLot);
    FreeAndNil(LQry);
    FreeAndNil(LItensTL);
    FreeAndNil(LTransf);
  end;
end;

procedure pGravaExpRet(strAutoinc, strCodSep:String; dtaSepIni, horSepIni, dtaSepFin, horSepFin: TDateTime );
var qryExpRet: TUniQuery;
begin
  Try
    qryExpRet := fCriaQuery(nil);
    With qryExpRet Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT * FROM EXPRET ');
      SQL.Add(' WHERE FALSE ');
      Open;

      Insert;
      FieldByName('EXP_SEQFGO').AsString   := strAutoinc;
      FieldByName('EXP_SEPRET').AsString   := strCodSep;
      FieldByName('EXP_DTAINI').AsDateTime := dtaSepIni;
      FieldByName('EXP_HORINI').AsDateTime := horSepIni;
      FieldByName('EXP_DTAFIN').AsDateTime := dtaSepFin;
      FieldByName('EXP_HORFIN').AsDateTime := horSepFin;
      Post;

    End;
  Finally
    FreeAndNil(qryExpRet);
  End;

end;

procedure pRegravarExpRet(strAutoinc:String; cdsExpRet: TUniClientDataSet);
begin
  if not cdsExpRet.isEmpty then
  Begin
    with cdsExpRet do
    begin
      First;
      While not eof do
      Begin
        pGravaExpRet(strAutoinc,
                     FieldByName('EXP_SEPRET').AsString,
                     FieldByName('EXP_DTAINI').AsDateTime,
                     FieldByName('EXP_HORINI').AsDateTime,
                     FieldByName('EXP_DTAFIN').AsDateTime,
                     FieldByName('EXP_HORFIN').AsDateTime);
        Next;
      End;
    end;
  End;
end;

procedure pGravaStatusDEPS(cdsGen: TDataset);
  Var
    qryOrcamento: TUniQuery;
Begin
  If (cdsGen.FieldByName('FGO_ESPDOC').AsString = 'OR') And
     (cdsGen.FieldByName('FGO_USADEP').AsString = 'S') Then
    TValidacoesSistemaDEPS.pGravaLogDeStatusDoSistemaDEPS(cdsGen.FieldByName('AUTOINCREM').AsString,
                                                          'CANCELAMENTO')
  Else
  Begin
    qryOrcamento := fCriaQuery;
    Try
      qryOrcamento.SQL.Text := 'SELECT F.AUTOINCREM, E.FGO_USADEP ' +
                                  'FROM FATGOR F                     ' +
                                  'LEFT JOIN EXTGOR E ON             ' +
                                  ' E.FGO_SEQFGO=F.AUTOINCREM        ' +
                                  'WHERE F.FGO_NUMFAT=' + cdsGen.FieldByName('FGO_NUMDOC').AsString.QuotedString +
                                  '  AND F.FGO_ESPDOC="OR"           ' +
                                  '  AND F.FGO_CODEMP=' + cdsGen.FieldByName('FGO_CODEMP').AsString.QuotedString;
      qryOrcamento.Open;

      If (qryOrcamento.FieldByName('FGO_USADEP').AsString = 'S') Then
        TValidacoesSistemaDEPS.pGravaLogDeStatusDoSistemaDEPS(qryOrcamento.FieldByName('AUTOINCREM').AsString,
                                                              'CANCELAMENTO');
    Finally
      FreeAndNil(qryOrcamento);
    End;
  End;
End;

function fBaixarPedOrcNaoEntregue(strNumDoc, strEspDoc, strCodEmp: String;
  bolExecutandoPeloCRM : Boolean = False; strNomeForm: String = ''): Boolean;
var
  BaixarPedOrcNaoEntregue: TBaixarPedOrcNaoEntregue;
begin
  BaixarPedOrcNaoEntregue := TBaixarPedOrcNaoEntregue.Create;
  try
    BaixarPedOrcNaoEntregue.ExecutandoPeloCRM := bolExecutandoPeloCRM;
    BaixarPedOrcNaoEntregue.strNomeForm := strNomeForm;
    BaixarPedOrcNaoEntregue.AddDocumento(
      strNumDoc,
      strEspDoc,
      strCodEmp
    );

    Try
      BaixarPedOrcNaoEntregue.Executar;
    Except
      On E: EValidaPedidoPossuiItensEmSeparacao Do
      Begin
        If not fEmptyStr(E.Message) Then
          fMensagem('ATENÇÃO!', E.Message, ['&Ok']);
        Exit(False);
      End;
    End;

    Result := True;

  finally
    FreeAndNil(BaixarPedOrcNaoEntregue);
  end;
end;

procedure fGravaGORCND(strAutInc: String; arrDuplic: TarrDuplicata );
Var
  qryGorCnd: TUniQuery;
  intContador: Integer;
Begin
  Try
    qryGorCnd := fCriaQuery(Nil);

    With qryGorCnd, SQL Do
    Begin
      Add('SELECT * FROM GORCND ');
      Add('WHERE FALSE');

      Open;

      For intContador := Low(arrDuplic) To High(arrDuplic) Do
      Begin
        If arrDuplic[intContador].curValor > 0 Then
        Begin
          qryGorCnd.Insert;
          FieldByName('FGO_SEQGER').AsString := strAutInc;
          FieldByName('FGO_PARCEL').AsString := arrDuplic[intContador].strSequen;
          FieldByName('FGO_VALPAR').AsFloat  := arrDuplic[intContador].curValor;
          qryGorCnd.Post;
        End;
      End;

    End;

  Finally
    FreeAndNil(qryGorCnd);
  End;
End;

procedure fGravaDAVCND(strAutInc: String; arrDuplic: TarrDuplicata );
Var
  qryDavCnd: TUniQuery;
  intContador: Integer;
Begin
  Try
    qryDavCnd := fCriaQuery(Nil);

    With qryDavCnd, SQL Do
    Begin
      Add('SELECT * FROM DAVCND ');
      Add('WHERE FALSE');

      Open;

      For intContador := Low(arrDuplic) To High(arrDuplic) Do
      Begin
        If arrDuplic[intContador].curValor > 0 Then
        Begin
          qryDavCnd.Insert;
          FieldByName('DPG_SEQDAV').AsString := strAutInc;
          FieldByName('DPG_PARCEL').AsString := arrDuplic[intContador].strSequen;
          FieldByName('DPG_VALPAR').AsFloat  := arrDuplic[intContador].curValor;
          qryDavCnd.Post;
        End;
      End;

    End;

  Finally
    FreeAndNil(qryDavCnd);
  End;
End;

procedure fAlteraROMCND(strNumDoc, strEspDoc, strCodCli, strCodEmp: String; arrDuplic: TarrDuplicata );
Var
  qryRomCnd: TUniQuery;
  strAutInc: String;
  intContador: Integer;
Begin
  Try
    qryRomCnd := fCriaQuery(Nil);

    With qryRomCnd, SQL Do
    Begin
      Close;
      Clear;
      Add('SELECT AUTOINCREM FROM ROMGERX ');
      Add('WHERE GER_NUMDOC = :NUMDOC     ');
      Add('  AND GER_ESPDOC = :ESPDOC     ');
      Add('  AND GER_CODCLI = :CODCLI     ');
      Add('  AND GER_CODEMP = :CODEMP     ');
      ParamByName('NUMDOC').AsString := strNumDoc ;
      ParamByName('ESPDOC').AsString := strEspDoc ;
      ParamByName('CODCLI').AsString := strCodCli ;
      ParamByName('CODEMP').AsString := strCodEmp ;
      Open;

      strAutInc := FieldByName('AUTOINCREM').AsString ;

      If not fEmptyStr(strAutInc) Then
      Begin
        Close;
        Clear;
        Add('DELETE FROM ROMCND              ');
        Add('WHERE GER_SEQGER = :AUTOINCREM  ');
        ParamByName('AUTOINCREM').AsString := strAutInc;
        ExecSQL;

        Close;
        Clear;
        Add('SELECT * FROM ROMCND ');
        Add('WHERE FALSE');
        Open;

        For intContador := Low(arrDuplic) To High(arrDuplic) Do
        Begin
          If arrDuplic[intContador].curValor > 0 Then
          Begin
            qryRomCnd.Insert;
            FieldByName('GER_SEQGER').AsString := strAutInc;
            FieldByName('GER_PARCEL').AsString := arrDuplic[intContador].strSequen;
            FieldByName('GER_VALPAR').AsFloat  := arrDuplic[intContador].curValor;
            qryRomCnd.Post;
          End;
        End;
      End;

    End;

  Finally
    FreeAndNil(qryRomCnd);
  End;
End;

function fTemFatDorSemExtDor(ANumeroDocumento, AEspecieDocumento, ACodigoEmpresa : string; var AMensagem : string) : Boolean;
var LQuery : TUniQuery;
begin
  Try
    LQuery := fCriaQuery(nil);
    LQuery.SQL.Text := 'SELECT F.FDO_CODITE '+
                       '  FROM FATDOR F '+
                       ' WHERE F.FDO_NUMDOC = :NUMDOC '+
                       '   AND F.FDO_ESPDOC = :ESPDOC '+
                       '   AND F.FDO_CODEMP = :CODEMP '+
                       '   AND F.AUTOINCREM NOT IN (SELECT E.FDO_SEQFDO '+
                       '                              FROM EXTDOR E     '+
                       '                              JOIN FATDOR FF ON FF.FDO_NUMDOC = :NUMDOC '+
                       '                                            AND FF.FDO_ESPDOC = :ESPDOC '+
                       '                                            AND FF.FDO_CODEMP = :CODEMP '+
                       '                                            AND E.FDO_SEQFDO  = FF.AUTOINCREM) ';
    LQuery.ParamByname('NUMDOC').AsString := ANumeroDocumento;
    LQuery.ParamByname('ESPDOC').AsString := AEspecieDocumento;
    LQuery.ParamByname('CODEMP').AsString := ACodigoEmpresa;
    LQuery.Open;
    Result := LQuery.Recordcount > 0;
    if Result then
      AMensagem := 'A replicação do pedido "'+ANumeroDocumento+'" não foi finalizada. Tabela faltante: "EXTDOR". Aguarde '+
        'alguns minutos e tente novamente mais tarde ou entre em contato com a citel';
    LQuery.Close;
  Finally
    FreeAndNil(LQuery);
  End;
end;

procedure pNotificaRobo(strNumeroDocumento, strEspecie, strCodigoEmpresa : String);
begin
  TReprocessarSaldoItem.New
       .AddItensDoDocumento(
         TItensReprocessarDoDocumento.New
           .Documento(strNumeroDocumento)
           .Especie(strEspecie)
           .Empresa(strCodigoEmpresa)
         ).NotificarRoboParaReprocessarSaldos();
end;

procedure TControleLiberacaoPedidos.TEnviaSomentePedidosDeOrigemExternaParaLiberacao.TParametros.Clear;
begin
  FillChar(Self, SizeOf(Self), #0);
end;

class procedure TControleLiberacaoPedidos.TEnviaSomentePedidosDeOrigemExternaParaLiberacao.Execute;
begin
  if Parametros.strEspDoc <> 'PD' then
    Exit;

  if not fCfgSis('LIBPED', varBoolean) then
    Exit;

  if not fCfgSis('LIBSFA', varBoolean) then
    Exit;

  if not fCfgSis('LPSTER', varBoolean) then
    Exit;

  if not Parametros.strNumPok.IsEmpty then
    Exit;

  Parametros.DataSet.FieldByName('FGO_LIBERA').AsInteger := intSIM;
  Parametros.DataSet.FieldByName('FGO_LIBCOM').AsInteger := intSIM;

end;

function fRetRotasPorPedido(strNumDoc, strEspDoc, strCodEmp: string): string;
Var
  qryAux: TUniQuery;
  strSQL: string;
begin
  Result := '';

  qryAux := fCriaQuery(nil);

  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT CONCAT( B.FGO_CODROT, " - ", RG.REG_DESREG ) AS ROTA ';
    strSQL := strSQL + '   FROM ';
    strSQL := strSQL + ' FATGOR A ';
    strSQL := strSQL + '  INNER JOIN EXTGOR B  ON A.AUTOINCREM  =  B.FGO_SEQFGO ';
    strSQL := strSQL + '   LEFT JOIN ENTREG ER ON B.FGO_CODROT  = ER.ENT_CODIGO ';
    strSQL := strSQL + '   LEFT JOIN CADREG RG ON RG.REG_CODREG = ER.ENT_CODREG ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   A.FGO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '   A.FGO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   A.FGO_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '     FGO_CODROT IS NOT NULL   ';

    qryAux.SQL.Text := strSQL;

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;

    qryAux.Open;

    If Not qryAux.isEmpty Then
      Result := qryAux.FieldByName('ROTA').asString;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function fRetRegioesPorPedido(strNumDoc, strEspDoc, strCodEmp: string): string;
Var
  qryAux: TUniQuery;
  strSQL: string;
begin
  Result := '';

  qryAux := fCriaQuery(nil);

  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT CONCAT( RG.REG_CODREG, " - ", RG.REG_DESREG ) AS REGIAO ';
    strSQL := strSQL + '   FROM ';
    strSQL := strSQL + ' FATGOR A ';
    strSQL := strSQL + '  INNER JOIN EXTGOR B  ON A.AUTOINCREM  =  B.FGO_SEQFGO ';
    strSQL := strSQL + '   LEFT JOIN ENTREG ER ON B.FGO_CODROT  = ER.ENT_CODIGO ';
    strSQL := strSQL + '   LEFT JOIN CADREG RG ON RG.REG_CODREG = ER.ENT_CODREG ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   A.FGO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '   A.FGO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   A.FGO_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '     FGO_CODROT IS NOT NULL   ';

    qryAux.SQL.Text := strSQL;

    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;

    qryAux.Open;

    If Not qryAux.isEmpty Then
      Result := qryAux.FieldByName('REGIAO').asString;

  Finally
    FreeAndNil(qryAux);
  End;

end;

function fPedidoUtiPen(const strNumdoc, strEspDoc, strCodEmp: String): Boolean;
var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;
  try
    qryGen.Close;
    qryGen.SQL.Clear;

    qryGen.SQL.Text :=
      ' SELECT FGO_UTIPEN '+
      ' FROM FATGOR '+
      ' INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM '+
      ' WHERE FGO_NUMDOC = :NUMDOC '+
      '   AND FGO_ESPDOC = :ESPDOC '+
      '   AND FGO_CODEMP = :CODEMP ';

    qryGen.ParamByName('NUMDOC').AsString := strNumdoc;
    qryGen.ParamByName('ESPDOC').AsString := strEspDoc;
    qryGen.ParamByName('CODEMP').AsString := strCodEmp;

    qryGen.Open;

    Result := qryGen.FieldByName('FGO_UTIPEN').AsString = 'S';

  finally
    FreeAndNil(qryGen);
  end;
end;

function fEhPedidoOriginadoPelaConsignacao(const AstrNumero, AstrEspecie, AstrCodigoEmpresa : String): Boolean;
  var
    LQuery : TUniQuery;
begin
  Result := False;

  If fEmptyStr(AstrNumero) Then
    Exit;

  LQuery := fCriaQuery;
  try
    LQuery.SQL.Text :=
      ' SELECT EXTGOR.FGO_ENVCON '+
      '   FROM FATGOR '+
      '   JOIN EXTGOR ON FATGOR.AUTOINCREM  = EXTGOR.FGO_SEQFGO '+
      '  WHERE FATGOR.FGO_NUMDOC = :NUMDOC '+
      '    AND FATGOR.FGO_ESPDOC = :ESPDOC '+
      '    AND FATGOR.FGO_CODEMP = :CODEMP ';

    LQuery.ParamByName('NUMDOC').AsString := AstrNumero;
    LQuery.ParamByName('ESPDOC').AsString := AstrEspecie;
    LQuery.ParamByName('CODEMP').AsString := AstrCodigoEmpresa;

    LQuery.Open;
    if not LQuery.IsEmpty then
      Result := LQuery.FieldByName('FGO_ENVCON').AsString = 'S';
    LQuery.CLose;

  finally
    FreeAndNil(LQuery);
  end;

End;

procedure pLimpaNseDor(strSeqFdo: String);
Var
  qryNseDor: TUniQuery;
begin
  qryNseDor := fCriaQuery;

  Try
    qryNseDor.SQL.Add(' DELETE FROM NSEDOR WHERE NSE_SEQFDO=:SEQFDO ');
    qryNseDor.ParamByName('SEQFDO').AsString := strSeqFdo;
    qryNseDor.ExecSQL;
  Finally
    FreeAndNil(qryNseDor);
  End;
end;

function fGravaNseDor(strSeqFdo, strNumSer: String; fltQtdSer: Double): Boolean;
  Var
    qryNseDor: TUniQuery;
Begin
  If (fltQtdSer <= 0) Then
    Exit(True);

  qryNseDor := fCriaQuery;
  Try
    qryNseDor.SQL.Text :=
      ' SELECT * FROM NSEDOR ' +
      ' WHERE NSE_SEQFDO = :SEQFDO ' +
      '   AND NSE_NUMSER = :NUMSER ';

    qryNseDor.ParamByName('SEQFDO').AsString := strSeqFdo;
    qryNseDor.ParamByName('NUMSER').AsString := strNumSer;
    qryNseDor.Open;

    If qryNseDor.IsEmpty Then
    Begin
      qryNseDor.Append;
      qryNseDor.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('NSEDOR', VS_strCodEmp);
    End
    Else
      qryNseDor.Edit;

    qryNseDor.FieldByName('NSE_SEQFDO').AsString := strSeqFdo;
    qryNseDor.FieldByName('NSE_NUMSER').AsString := strNumSer;
    qryNseDor.FieldByName('NSE_QTDSER').AsFloat  := fltQtdSer;
    qryNseDor.Post;

    Result := True;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[fGravaNseDor]');
      Result := False;
    End;
  End;

  FreeAndNil(qryNseDor);
end;

function fGravaBoletoExtGor(strAutInc: string; fltValBol: Double): Boolean;
var
  qryBoleto: TUniQuery;
begin
  qryBoleto := fCriaQuery;

  try
    Result := False;
    qryBoleto.Close;
    qryBoleto.SQL.Clear;
    qryBoleto.SQL.Text := ' UPDATE EXTGOR SET FGO_BOLADT = :VALBOL WHERE FGO_SEQFGO = :SEQFGO ';
    qryBoleto.ParamByName('VALBOL').AsFloat := fltValBol;
    qryBoleto.ParamByName('SEQFGO').AsString := strAutInc;

    qryBoleto.ExecSQL;

    Result := True;
  finally
    FreeAndNil(qryBoleto);
  end;
end;

function fRetQtdPedidosEntFutCD(strCodEmp: String): Integer;
var
  qryGen: TUniquery;
  strSQL: string;
begin
  qryGen := fCriaQuery(nil);
  try
    strSQL := '';
    strSQL := strSQL + ' SELECT COUNT(*) as QtdPedidosEntFutCD ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   FATGOR ';
    strSQL := strSQL + '   INNER JOIN CADCLI ON CLI_CODCLI = FGO_CODCLI ';
    strSQL := strSQL + '   INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM ';
    strSQL := strSQL + '   LEFT JOIN CADFPG ON (CADFPG.FPG_CODIGO = FATGOR.FGO_CODFPG) ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   FGO_ESPDOC = "PD" AND ';
    strSQL := strSQL + '   FGO_JAFATU = 0 AND ';
    strSQL := strSQL + '   FGO_ENTFUT = "S" AND ';
    strSQL := strSQL + '   FGO_ENT_CD = "S" AND ';
    strSQL := strSQL + '   FGO_EMP_CD = "' + VS_strCodEmp + '" AND ';
    strSQL := strSQL + '   IFNULL(FGO_LIBERA, 0) > 0 AND  ';
    strSQL := strSQL + '   IFNULL(FGO_LIBCOM, 0) > 0 ';
    strSQL := strSQL + ' ORDER BY ';
    strSQL := strSQL + '   FGO_DTAENT, FGO_HORENT, FGO_CODEMP, FGO_NUMDOC ';

    qryGen.SQL.Text := strSQL;
    qryGen.Open;

    Result := 0;
    if qryGen.fieldByName('QtdPedidosEntFutCD').AsInteger > 0 then
      Result := qryGen.fieldByName('QtdPedidosEntFutCD').AsInteger;

  finally
    FreeAndNil(qryGen);
  end;
end;

function fPedidoGeraPedencia(strAutInc: string): Boolean;
begin
  Result := fCampoTabela('FGO_GERPEN','EXTGOR',['FGO_SEQFGO'],[strAutInc],False) = 'S';
end;

function fTipoOperacao(strNumDoc, strEspDoc, strCodEmp: String): String;
begin
  Result := fCampoTabela('FGO_TIPOPE','FATGOR', ['FGO_NUMDOC','FGO_ESPDOC', 'FGO_CODEMP'], [strNumDoc, strEspDoc, strCodEmp]);
end;

function fGetSqlProdControlado(stlPedidos: TStringList): String;
  var
    intCon    : Integer;
    strSQL    : String;
    objPedido : TPedidoVenda;

begin

  strSQL := '';
  strSQL := strSQL + 'SELECT                                                              ';

  strSQL := strSQL + '  E.EMP_CODEMP AS CODEMP,                                           ';
  strSQL := strSQL + '  E.EMP_NOMEMP AS NOMEMP,                                           ';
  strSQL := strSQL + '  E.EMP_C_G_C_ AS CGCEMP,                                           ';
  strSQL := strSQL + '  E.EMP_FONE01 AS FONE01,                                           ';
  strSQL := strSQL + '  I.ITE_DESITE AS DESITE,                                           ';
  strSQL := strSQL + '  CONCAT(D.FDO_TIPFAT,"-",D.FDO_NUMFAT,"-",D.FDO_EMPFAT) AS NUMCON, ';
  strSQL := strSQL + '  SUBSTR(G.ITE_NOTULT, 1, 12) AS NUMENT,                            ';
  strSQL := strSQL + '  F.FOR_NOMFOR AS NOMFOR                                            ';

  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  FATDOR D                                                                           ';
  strSQL := strSQL + '  INNER JOIN CADITE I ON I.ITE_CODITE = D.FDO_CODITE AND I.ITE_INFLAM = "S"          ';
  strSQL := strSQL + '   LEFT JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE AND G.ITE_CODEMP = D.FDO_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADFOR F ON F.FOR_CODFOR = G.ITE_FORULT                                 ';
  strSQL := strSQL + '   LEFT JOIN CADEMP E ON E.EMP_CODEMP = D.FDO_CODEMP                                 ';

  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  ( ';
  For intCon := 0 To stlPedidos.Count -1 Do
  Begin
    objPedido  := TPedidoVenda(stlPedidos.Objects[intCon]);

    strSQL := strSQL + '  (D.FDO_NUMDOC = ' + QuotedStr(objPedido.strNumDoc) + ' AND ';
    strSQL := strSQL + '   D.FDO_ESPDOC = ' + QuotedStr(objPedido.strEspDoc) + ' AND ';
    strSQL := strSQL + '   D.FDO_CODEMP = ' + QuotedStr(objPedido.strCodEmp) + ')    ';

    If intCon < stlPedidos.Count -1 Then
      strSQL := strSQL + ' OR ';
  End;
  strSQL := strSQL + '  )   ';

  result := strSQL ;

end;

function fVerificaExisteItemProdutoTransferenciaNaoFaturadas(const strCodEmp,
  strCodCli,strCodIte: String): Boolean;
  Var
    qryAux : TUniQuery;
Begin
  qryAux := fCriaQuery;
  Try
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT COUNT(0) AS CNT ');
    qryAux.SQL.Add('   FROM FATDOR ');
    qryAux.SQL.Add('  WHERE FDO_CODEMP = :CODEMP ');
    qryAux.SQL.Add('    AND FDO_CODCLI = :CODCLI ');
    qryAux.SQL.Add('    AND FDO_CODITE = :CODITE ');
    qryAux.SQL.Add('    AND FDO_JAFATU = 0 ');
    qryAux.ParambyName('CODEMP').AsString := strCodEmp;
    qryAux.ParambyName('CODCLI').AsString := strCodCli;
    qryAux.ParambyName('CODITE').AsString := strCodIte;
    qryAux.Open;
    Result := qryAux.FieldByName('CNT').AsInteger > 0;
  Finally
    FreeAndNil(qryAux);
  End;
End;

procedure pGravaFreFat(const strNumDoc,
                             strEspDoc,
                             strCodEmp,
                             strCodCli,
                             strCodVen,
                             strCodTra,
                             strPlaVei,
                             strCidOri,
                             strCidDes,
                             strTipApi : String;
                       const fltDistan,
                             fltVlrPed,
                             fltVlrCmb,
                             fltTotFre : Double;
                             intCodTab: Integer;
                             strCotId_: String;
                             strAutIncEndPartida: String;
                             intDiasEnt: Integer);
var
  LQuery : TUniQuery;
begin
  if fEmptyStr(strCodCli) or fEmptyStr(strCodVen) or
     fEmptyStr(strCidDes) or fEmptyStr(strTipApi) then
    Exit;

  try
    LQuery := fCriaQuery(nil);
    LQuery.Close;
    LQuery.SQL.Text := 'SELECT * FROM FREFAT '
                     + ' WHERE FRE_NUMDOC = :NUMDOC '
                     + '   AND FRE_ESPDOC = :ESPDOC '
                     + '   AND FRE_CODEMP = :CODEMP ';

    LQuery.ParamByName('NUMDOC').AsString := strNumDoc;
    LQuery.ParamByName('ESPDOC').AsString := strEspDoc;
    LQuery.ParamByName('CODEMP').AsString := strCodEmp;
    LQuery.Open;

    if LQuery.IsEmpty then
    begin
      LQuery.Append;
      LQuery.FieldByName('AUTOINCREM').AsString  := fRetAutoIncrem('FREFAT', VS_strCodEmp);
      LQuery.FieldByName('FRE_NUMDOC').AsString := strNumDoc;
      LQuery.FieldByName('FRE_ESPDOC').AsString := strEspDoc;
      LQuery.FieldByName('FRE_CODEMP').AsString := strCodEmp;
    end
    else
      LQuery.Edit;

    LQuery.FieldByName('FRE_CODCLI').AsString := strCodCli;
    LQuery.FieldByName('FRE_CODVEN').AsString := strCodVen;
    LQuery.FieldByName('FRE_CODTRA').AsString := strCodTra;
    LQuery.FieldByName('FRE_PLAVEI').AsString := strPlaVei;
    LQuery.FieldByName('FRE_CIDORI').AsString := strCidOri;
    LQuery.FieldByName('FRE_CIDDES').AsString := strCidDes;
    LQuery.FieldByName('FRE_TIPAPI').AsString := strTipApi;
    LQuery.FieldByName('FRE_DISTAN').AsFloat  := fltDistan;
    LQuery.FieldByName('FRE_VLRPED').AsFloat  := fltVlrPed;
    LQuery.FieldByName('FRE_VLRCMB').AsFloat  := fltVlrCmb;
    LQuery.FieldByName('FRE_TOTFRE').AsFloat  := fltTotFre;

    if fEmptyStr(LQuery.FieldByName('FRE_PLAVEI').AsString) then
      LQuery.FieldByName('FRE_PLAVEI').Value := null;

    if fEmptyStr(LQuery.FieldByName('FRE_CODTRA').AsString) then
      LQuery.FieldByName('FRE_CODTRA').Value := null;

    LQuery.FieldByName('FRE_CODTAB').AsInteger := intCodTab;
    LQuery.FieldByName('FRE_COTID_').AsString  := strCotId_;

    If Not fEmptyStr(strAutIncEndPartida) Then
      LQuery.FieldByName('FRE_AIENPA').AsString := strAutIncEndPartida;

    LQuery.FieldByName('FRE_DIAENT').AsInteger  := intDiasEnt;

    LQuery.Post;
  finally
    FreeAndNil(LQuery);
  end;
end;

procedure pGravarCobrancaEletronica(const ATipRec, strNumDoc,
  strEspDoc: String);
var
  qryAux : TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    qryAux.Close;
    qryAux.SQL.Text := 'UPDATE EXTGOR '
                     + '   SET FGO_TIPREC = :TIPREC '
                     + ' WHERE FGO_SEQFGO = (SELECT AUTOINCREM FROM FATGOR '
                     + '                      WHERE FGO_NUMDOC = :NUMDOC '
                     + '                        AND FGO_ESPDOC = :ESPDOC '
                     + '                        AND FGO_CODEMP = :CODEMP) ';

    qryAux.ParamByName('TIPREC').AsString := ATipRec;
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.ExecSQL;

  finally
    FreeAndNil(qryAux);
  end;
end;

procedure pCancelaCobrancaEletronica(const ATipRec, strNumDoc,
  strEspDoc: String);
var
  qryAux : TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    qryAux.Close;
    qryAux.SQL.Text := 'UPDATE COBELT '
                     + '   SET CBE_APICOB = :TIPREC '
                     + ' WHERE CBE_NUMDOC = :NUMDOC '
                     + '   AND CBE_ESPDOC = :ESPDOC '
                     + '   AND CBE_CODEMP = :CODEMP ';

    qryAux.ParamByName('TIPREC').AsString := ATipRec;
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryAux.ExecSQL;

  finally
    FreeAndNil(qryAux);
  end;
end;

function fExisteItemPD_OR(strNumDoc, strEspDoc, strEmpDoc, strCodIte, strSeqInc : String): Boolean;
var
  qryAux : TUniQuery;
const
  SQL = 'SELECT         ' +
        '  COUNT(*) TOT ' +
        'FROM           ' +
        '  FATDOR       ' +
        '  INNER JOIN EXTDOR ON (EXTDOR.FDO_SEQFDO = FATDOR.AUTOINCREM) ' +
        'WHERE          ' +
        '  FDO_NUMDOC = :NUMDOC AND ' +
        '  FDO_ESPDOC = :ESPDOC AND ' +
        '  FDO_CODEMP = :CODEMP AND ' +
        '  FDO_CODITE = :CODITE AND ' +
        '  FDO_SEQINC = :SEQINC ';
begin

  If fEmptyStr(strNumDoc) Then
    Exit(False);

  If fEmptyStr(strEspDoc) Then
    Exit(False);

  If fEmptyStr(strEmpDoc) Then
    Exit(False);

  If fEmptyStr(strCodIte) Then
    Exit(False);

  If fEmptyStr(strSeqInc) Then
    Exit(False);

  qryAux := fCriaQuery;

  Try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Text := SQL;
    qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := strEmpDoc;
    qryAux.ParamByName('CODITE').AsString := strCodIte;
    qryAux.ParamByName('SEQINC').AsString := strSeqInc;
    qryAux.Open;

    Result := (Not qryAux.IsEmpty) And (qryAux.FieldByName('TOT').AsInteger > 0);
  Finally
    FreeAndNil(qryAux);
  End;

end;

function fPedidoPossuiSomenteItensEntregaFutura(strNumDoc, strEspDoc, strCodEmp: String): Boolean;
Var
  qryFatDor: TUniQuery;
  strSQL: string;
Begin
  qryFatDor := fCriaQuery;
  Result := False;
  Try
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   COUNT(AUTOINCREM) AS QTDTOT, ';
    strSQL := strSQL + '   IFNULL(SUM((CASE WHEN FDO_ENTFUT = "S" ';
    strSQL := strSQL + '                     AND FDO_ENTRET = "E" ';
    strSQL := strSQL + '          THEN 1 ELSE 0 END))';
    strSQL := strSQL + '         ,0) AS QTDFUT ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   FATDOR F ';
    strSQL := strSQL + '   INNER JOIN EXTDOR E ON E.FDO_SEQFDO = F.AUTOINCREM ';
    strSQL := strSQL + ' WHERE';
    strSQL := strSQL + '   FDO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '   FDO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '   FDO_CODEMP = :CODEMP     ';

    qryFatDor.SQL.Text := strSQL;

    qryFatDor.ParamByName('NUMDOC').AsString := strNumDoc;
    qryFatDor.ParamByName('ESPDOC').AsString := strEspDoc;
    qryFatDor.ParamByName('CODEMP').AsString := strCodEmp;

    qryFatDor.Open;
    If Not qryFatDor.IsEmpty Then
    Begin
      Result := (qryFatDor.FieldByName('QTDTOT').AsInteger >  0) And
                (qryFatDor.FieldByName('QTDTOT').AsInteger = qryFatDor.FieldByName('QTDFUT').AsInteger);
    End;
  Finally
    qryFatDor.Close;
    FreeAndNil(qryFatDor);
  End
end;

procedure pVerificaIntegridadeLOTDOR(strSeqGer: String);
  Var
    qryLotDor: TUniQuery;
begin
  If fEmptyStr(strSeqGer) Then
    Exit;

  pApagaDelLotDor(strSeqGer);

  qryLotDor := fCriaQuery;
  Try
    qryLotDor.Close;
    qryLotDor.SQL.Clear;
    qryLotDor.SQL.Text :=
      ' SELECT LOTDOR.* FROM LOTDOR ' +
      ' INNER JOIN FATDOR ON LOTDOR.LDO_SEQFDO = FATDOR.AUTOINCREM ' +
      ' WHERE FDO_SEQGER = :SEQGER';
    qryLotDor.ParamByName('SEQGER').AsString := strSeqGer;
    qryLotDor.Open;

    qryLotDor.First;
    While Not qryLotDor.Eof Do
    Begin
      fVerificaIntegridade('', 'LOTDOR', qryLotDor, True, False, '', '', False, '');

      qryLotDor.Next;
    End;
  Finally
    FreeAndNil(qryLotDor);
  End;
end;

procedure pApagaDelLotDor(strSeqGer: String);
  Var
    qryDel: TUniQuery;
begin
  qryDel := fCriaQuery;
  Try
    qryDel.Close;
    qryDel.SQL.Clear;
    qryDel.SQL.Text :=
      ' DELETE FROM DEL_LOTDOR USING DEL_LOTDOR, FATDOR ' +
      ' WHERE DEL_LOTDOR.LDO_SEQFDO = FATDOR.AUTOINCREM AND FATDOR.FDO_SEQGER = :SEQGER';
    qryDel.ParamByName('SEQGER').AsString := strSeqGer;
    qryDel.ExecSQL;
  Finally
    FreeAndNil(qryDel);
  End;
end;

procedure pAtualizaTotalItensFatGor(strNumDoc, strEspDoc, strCodEmp: String);
  Var
    qryFatGor: TUniQuery;
    fltTotalItens: Double;
begin
  fltTotalItens := fRetornaValorTotalItensFatDor(strNumDoc, strEspDoc, strCodEmp);

  qryFatGor := fCriaQuery;
  Try
    qryFatGor.Close;
    qryFatGor.SQL.Clear;

    qryFatGor.SQL.Text :=
      ' UPDATE FATGOR SET FGO_TOTPRO = :TOTAL_ITEM ' +
      ' WHERE FGO_NUMDOC = :NUMDOC ' +
      '   AND FGO_ESPDOC = :ESPDOC ' +
      '   AND FGO_CODEMP = :CODEMP ' ;

    qryFatGor.ParamByName('TOTAL_ITEM').AsFloat := fltTotalItens;
    qryFatGor.ParamByName('NUMDOC').AsString    := strNumDoc;
    qryFatGor.ParamByName('ESPDOC').AsString    := strEspDoc;
    qryFatGor.ParamByName('CODEMP').AsString    := strCodEmp;

    qryFatGor.ExecSQL;
  Finally
    FreeAndNil(qryFatGor);
  End;
end;

function fRetornaValorTotalItensFatDor(strNumDoc, strEspDoc, strCodEmp: String): Double;
  Var
    qryFatDor: TUniQuery;
begin
  qryFatDor := fCriaQuery;
  Try
    qryFatDor.Close;
    qryFatDor.SQL.Clear;

    qryFatDor.SQL.Text :=
      ' SELECT SUM(FDO_TOTITE) AS FDO_TOTITE FROM FATDOR ' +
      ' WHERE FDO_NUMDOC = :NUMDOC ' +
      '   AND FDO_ESPDOC = :ESPDOC ' +
      '   AND FDO_CODEMP = :CODEMP ' ;

    qryFatDor.ParamByName('NUMDOC').AsString := strNumDoc;
    qryFatDor.ParamByName('ESPDOC').AsString := strEspDoc;
    qryFatDor.ParamByName('CODEMP').AsString := strCodEmp;

    qryFatDor.Open;

    Result := qryFatDor.FieldByName('FDO_TOTITE').AsFloat;
  Finally
    FreeAndNil(qryFatDor);
  End;
end;

procedure pAtualizaBaixaSepExtDor(ADtBxSe, AHrBxSe: TDateTime; ANumDoc, AEspDoc, ACodCli, ACodEmp, AOpBxSe: String);
var
  strSQL: String;
  qryTmp: TUniQuery;
begin
  qryTmp := fCriaQuery();

  try
    strSQL := '';
    strSQL := strSQL + 'UPDATE     ';
    strSQL := strSQL + '  EXTDOR E ';
    strSQL := strSQL + '  INNER JOIN FATDOR F ON F.AUTOINCREM = E.FDO_SEQFDO ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  E.FDO_DTBXSE = :DTBXSE, ';
    strSQL := strSQL + '  E.FDO_HRBXSE = :HRBXSE, ';
    strSQL := strSQL + '  E.FDO_OPBXSE = :OPBXSE  ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  F.FDO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  F.FDO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  F.FDO_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  F.FDO_CODCLI = :CODCLI     ';

    qryTmp.Close;
    qryTmp.SQL.Clear;
    qryTmp.SQL.Text := strSQL;
    qryTmp.ParamByName('NUMDOC').AsString := ANumDoc;
    qryTmp.ParamByName('ESPDOC').AsString := AEspDoc;
    qryTmp.ParamByName('CODEMP').AsString := ACodEmp;
    qryTmp.ParamByName('CODCLI').AsString := ACodCli;

    if (ADtBxSe > 0) then
      qryTmp.ParamByName('DTBXSE').AsDateTime := ADtBxSe
    else
      qryTmp.ParamByName('DTBXSE').Clear();

    if (AHrBxSe > 0) then
      qryTmp.ParamByName('HRBXSE').AsDateTime := AHrBxSe
    else
      qryTmp.ParamByName('HRBXSE').Clear();

    if (not fEmptyStr(AOpBxSe)) then
      qryTmp.ParamByName('OPBXSE').AsString := AOpBxSe
    else
      qryTmp.ParamByName('OPBXSE').Clear();

    qryTmp.ExecSQL;
  finally
    FreeAndNil(qryTmp);
  end;
end;

function fPedidoEmOndaSeparacao(const strAutInc: String): Boolean;
var
  qryInfo: TUniQuery;
begin
  qryInfo := fCriaQuery();
  Try
    qryInfo.Close;
    qryInfo.SQL.Text := 'SELECT '
                      + '       E.FGO_SEQSEP '
                      + '     , F.FGO_NUMDOC '
                      + '     , F.FGO_ESPDOC '
                      + '     , F.FGO_CODEMP '
                      + '  FROM FATGOR F '
                      + ' INNER JOIN EXTGOR E ON E.FGO_SEQFGO = F.AUTOINCREM '
                      + ' WHERE IFNULL(FGO_SEQSEP, "") <> "" '
                      + '   AND F.AUTOINCREM = :AUTINC ';

    qryInfo.ParamByName('AUTINC').AsString := strAutInc;
    qryInfo.Open;

    Result := (Not qryInfo.IsEmpty);
  Finally
    FreeAndNil(qryInfo);
  End;
end;

function fGravaFdoCha(strAutInc: String;
                      fltQtdCha: Double;
                      fltMedB_L: Double;
                      fltMedB_A: Double;
                      fltMedL_L: Double;
                      fltMedL_A: Double;
                      fltEspess: Double): Boolean;
Var
  qryFdoCha: TUniQuery;
  strSQL: string;
begin
  qryFdoCha := fCriaQuery();

  Try
    strSQL := '';
    strSQL := strSQL + '  INSERT INTO FDOCHA (  ';
    strSQL := strSQL + '    FDO_SEQFDO,         ';
    strSQL := strSQL + '    FDO_QTDCHA,         ';
    strSQL := strSQL + '    FDO_MEDB_L,         ';
    strSQL := strSQL + '    FDO_MEDB_A,         ';
    strSQL := strSQL + '    FDO_MEDL_L,         ';
    strSQL := strSQL + '    FDO_MEDL_A,         ';
    strSQL := strSQL + '    FDO_ESPESS          ';
    strSQL := strSQL + '  ) VALUES (            ';
    strSQL := strSQL + '    :SEQFDO,            ';
    strSQL := strSQL + '    :QTDCHA,            ';
    strSQL := strSQL + '    :MEDB_L,            ';
    strSQL := strSQL + '    :MEDB_A,            ';
    strSQL := strSQL + '    :MEDL_L,            ';
    strSQL := strSQL + '    :MEDL_A,            ';
    strSQL := strSQL + '    :ESPESS)            ';

    qryFdoCha.SQL.Text := strSQL;

    qryFdoCha.ParamByName('SEQFDO').AsString := strAutInc;
    qryFdoCha.ParamByName('QTDCHA').AsFloat  := fltQtdCha;
    qryFdoCha.ParamByName('MEDB_L').AsFloat  := fltMedB_L;
    qryFdoCha.ParamByName('MEDB_A').AsFloat  := fltMedB_A;
    qryFdoCha.ParamByName('MEDL_L').AsFloat  := fltMedL_L;
    qryFdoCha.ParamByName('MEDL_A').AsFloat  := fltMedL_A;
    qryFdoCha.ParamByName('ESPESS').AsFloat  := fltEspess;

    qryFdoCha.ExecSQL;

    Result := True;
  Finally
    FreeAndNil(qryFdoCha);
  End;
end;

function fRetornaDadosFdoCha(strAutInc: String;
                             fltQtdIte: Double;
                             Out fltQtdCha: Double;
                             Out fltMedB_L: Double;
                             Out fltMedB_A: Double;
                             Out fltMedL_L: Double;
                             Out fltMedL_A: Double;
                             Out fltEspess: Double):Boolean;
Var
  qryFdoCha: TUniQuery;
  strSQL: string;
Begin
  Result := False;

  If fEmptyStr(strAutInc) Then
    Exit;

  qryFdoCha := fCriaQuery();
  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT               ';
    strSQL := strSQL + '    FDO_MEDB_L,        ';
    strSQL := strSQL + '    FDO_MEDB_A,        ';
    strSQL := strSQL + '    FDO_MEDL_L,        ';
    strSQL := strSQL + '    FDO_MEDL_A,        ';
    strSQL := strSQL + '    FDO_ESPESS         ';
    strSQL := strSQL + '  FROM                 ';
    strSQL := strSQL + '    FDOCHA             ';
    strSQL := strSQL + '  WHERE                ';
    strSQL := strSQL + '    FDO_SEQFDO=:AUTINC ';

    qryFdoCha.SQL.Text := strSQL;

    qryFdoCha.ParamByName('AUTINC').AsString := strAutInc;
    qryFdoCha.Open;

    If (Not qryFdoCha.IsEmpty) Then
    Begin
      fltMedB_L := qryFdoCha.FieldByName('FDO_MEDB_L').AsFloat;
      fltMedB_A := qryFdoCha.FieldByName('FDO_MEDB_A').AsFloat;
      fltMedL_L := qryFdoCha.FieldByName('FDO_MEDL_L').AsFloat;
      fltMedL_A := qryFdoCha.FieldByName('FDO_MEDL_A').AsFloat;
      fltEspess := qryFdoCha.FieldByName('FDO_ESPESS').AsFloat;

      If (fltMedL_L = 0) Or (fltMedL_A = 0) Then
        fltQtdCha := 0
      Else
        fltQtdCha := fFormataFloat(fltQtdIte / (fltMedL_L * fltMedL_A), 4);

      Result := True;
    End;
  Finally
    FreeAndNil(qryFdoCha);
  End;
End;

procedure pValidaDocumentoContaOrdemRemessa(const qryDados: TUniQuery;
  const strNumDoc, strEspDoc, strCodEmp: String);
const
  strEspDocQueNaoVal = 'DV_TR_';
var
  strSQL : String;
begin
  strSQL := 'SELECT '
          + '       * '
          + '  FROM (SELECT '
          + '               G.FGO_DTAENT '
          + '             , G.AUTOINCREM '
          + '             , G.FGO_NUMDOC '
          + '             , G.FGO_ESPDOC '
          + '             , G.FGO_CODEMP '
          + '             , G.FGO_TIPOPE '
          + '             , E.FGO_AUTRCO '
          + '             , R.AUTOINCREM AS AUTINC_VINCULACAO '
          + '             , R.FGO_NUMDOC AS NUMDOC_VINCULACAO '
          + '             , R.FGO_ESPDOC AS ESPDOC_VINCULACAO '
          + '             , R.FGO_CODEMP AS CODEMP_VINCULACAO '
          + '             , R.FGO_CODCLI AS CODCLI_VINCULACAO '
          + '             , IFNULL(G.FGO_MOTBAI,"") AS MOTIVO_BAIXA '
          + '             , IFNULL(V.GER_NUMDOC,"") AS NUMDOC_FATURAMENTO '
          + '             , IFNULL(V.GER_ESPDOC,"") AS ESPDOC_FATURAMENTO '
          + '             , IFNULL(V.GER_CODEMP,"") AS CODEMP_FATURAMENTO '
          + '             , IFNULL(R.FGO_NUMFAT,"") AS NUMDOC_REMESSA_FATURADA '
          + '             , IFNULL(R.FGO_TIPFAT,"") AS ESPDOC_REMESSA_FATURADA '
          + '             , IFNULL(R.FGO_EMPFAT,"") AS CODEMP_REMESSA_FATURADA '
          + '             , IFNULL(N.GER_NUMDOC,"") AS NUMDOC_NOTGER '
          + '             , IFNULL(N.GER_ESPDOC,"") AS ESPDOC_NOTGER '
          + '             , IFNULL(N.GER_CODEMP,"") AS CODEMP_NOTGER '
          + '             , IFNULL(T.GER_NUMDOC,"") AS NUMDOC_NOTGER_REMESSA '
          + '             , IFNULL(T.GER_ESPDOC,"") AS ESPDOC_NOTGER_REMESSA '
          + '             , IFNULL(T.GER_CODEMP,"") AS CODEMP_NOTGER_REMESSA '
          + '             , (CASE '
          + '                  WHEN IFNULL(F.FIS_ACESSO, "") <> "" THEN '
          + '                    IFNULL(F.FIS_ACESSO, "") '
          + '                ELSE '
          + '                  IFNULL(I.FIS_ACESSO, "") '
          + '                END)                   AS CHAVE_REMESSA '
          + '          FROM FATGOR G '
          + '         INNER JOIN EXTGOR X ON X.FGO_SEQFGO = G.AUTOINCREM '
          + '         INNER JOIN EXTGOR E ON E.FGO_AUTRCO = G.AUTOINCREM '
          + '         INNER JOIN FATGOR R ON R.AUTOINCREM = E.FGO_SEQFGO '
          + '          LEFT JOIN MOVGER V ON V.GER_NUMDOC = G.FGO_NUMFAT '
          + '                            AND V.GER_ESPDOC = G.FGO_TIPFAT '
          + '                            AND V.GER_CODEMP = G.FGO_EMPFAT '
          + '          LEFT JOIN NOTGER N ON N.GER_NUMDOC = V.GER_NUMFAT '
          + '                            AND N.GER_ESPDOC = V.GER_TIPFAT '
          + '                            AND N.GER_CODEMP = V.GER_EMPFAT '
          + '          LEFT JOIN MOVGER O ON O.GER_NUMDOC = R.FGO_NUMFAT '
          + '                            AND O.GER_ESPDOC = R.FGO_TIPFAT '
          + '                            AND O.GER_CODEMP = R.FGO_EMPFAT '
          + '          LEFT JOIN NOTGER T ON T.GER_NUMDOC = O.GER_NUMFAT '
          + '                            AND T.GER_ESPDOC = O.GER_TIPFAT '
          + '                            AND T.GER_CODEMP = O.GER_EMPFAT '
          + '          LEFT JOIN CADFIS F ON F.FIS_NUMDOC = O.GER_NUMDOC '
          + '                            AND F.FIS_ESPDOC = O.GER_ESPDOC '
          + '                            AND F.FIS_CODEMP = O.GER_CODEMP '
          + '          LEFT JOIN CADFIS I ON I.FIS_NUMDOC = T.GER_NUMDOC '
          + '                            AND I.FIS_ESPDOC = T.GER_ESPDOC '
          + '                            AND I.FIS_CODEMP = T.GER_CODEMP '
          + '         WHERE G.FGO_TIPOPE = "C" '
          + '           AND G.FGO_ESPDOC = "PD") AS DADOS '
          + ' WHERE TRUE ';

  If (strEspDoc = 'PD') Then
  Begin
    strSQL := strSQL
            + '   AND FGO_NUMDOC = :NUMDOC '
            + '   AND FGO_ESPDOC = :ESPDOC '
            + '   AND FGO_CODEMP = :CODEMP ';
  End
  Else If (strEspDoc = 'FF') Then
  Begin
    strSQL := strSQL
            + '   AND NUMDOC_FATURAMENTO = :NUMDOC '
            + '   AND ESPDOC_FATURAMENTO = :ESPDOC '
            + '   AND CODEMP_FATURAMENTO = :CODEMP ';
  End
  Else If (strEspDoc = 'NF') Then
  Begin
    strSQL := strSQL
            + '   AND ((NUMDOC_FATURAMENTO = :NUMDOC '
            + '   AND   ESPDOC_FATURAMENTO = :ESPDOC '
            + '   AND   CODEMP_FATURAMENTO = :CODEMP) '
            + '    OR  (NUMDOC_NOTGER = :NUMDOC '
            + '   AND   ESPDOC_NOTGER = :ESPDOC '
            + '   AND   CODEMP_NOTGER = :CODEMP)) ';
  End
  Else If (Pos(strEspDoc, strEspDocQueNaoVal) > 0) Then
  Begin
    strSQL := strSQL
            + '   AND FALSE ';
  End;

  qryDados.SQL.Text := strSQL;
  If (Pos(strEspDoc, strEspDocQueNaoVal) = 0) Then
  Begin
    If Assigned(qryDados.FindField('NUMDOC')) Then
      qryDados.ParamByName('NUMDOC').AsString := strNumDoc;
    If Assigned(qryDados.FindField('ESPDOC')) Then
      qryDados.ParamByName('ESPDOC').AsString := strEspDoc;
    If Assigned(qryDados.FindField('CODEMP')) Then
      qryDados.ParamByName('CODEMP').AsString := strCodEmp;
  End;
  qryDados.Open;
end;

function fExisteDocumentoContaOrdemComRemessaNaoFaturada(
  const strNumDoc, strEspDoc, strCodEmp: String): Boolean; overload;
var
  qryDados : TUniQuery;
begin
  Result := False;

  If (Not fCfgSis('HBFPRC', varBoolean)) Then
    Exit;

  qryDados := fCriaQuery;
  Try
    pValidaDocumentoContaOrdemRemessa(qryDados, strNumDoc, strEspDoc, strCodEmp);

    If (qryDados.RecordCount = 0) Then
      Exit;

    Result := (fEmptyStr(qryDados.FieldByName('NUMDOC_REMESSA_FATURADA').AsString));

    If Result Then
    Begin
      fMensagem('','Esse pedido está vinculado a uma remessa de conta e ordem '+
                   'que não foi faturada!', ['&Ok']);
    End
    Else
      Result := fExisteDocumentoContaOrdemComRemessaNaoEmitidaNF(
                  strNumDoc, strEspDoc, strCodEmp);
  Finally
    FreeAndNil(qryDados);
  End;
end;

function fExisteDocumentoContaOrdemComRemessaNaoFaturada(
  const strAutInc: String): Boolean;
var
  qryDados : TUniQuery;
begin
  If (Not fCfgSis('HBFPRC', varBoolean)) Then
    Exit(False);

  qryDados := fCriaQuery;
  Try
    qryDados.SQL.Text := 'SELECT '
                       + '       FGO_NUMDOC '
                       + '     , FGO_ESPDOC '
                       + '     , FGO_CODEMP '
                       + '  FROM FATGOR '
                       + ' WHERE AUTOINCREM = :AUTINC ';

    qryDados.ParamByName('AUTINC').AsString := strAutInc;
    qryDados.Open;

    Result := fExisteDocumentoContaOrdemComRemessaNaoFaturada(
                qryDados.FieldByName('FGO_NUMDOC').AsString,
                qryDados.FieldByName('FGO_ESPDOC').AsString,
                qryDados.FieldByName('FGO_CODEMP').AsString);
  Finally
    FreeAndNil(qryDados);
  End;
end;

function fEhDocumentoContaOrdemComRemessa(const strNumDoc,
  strEspDoc: String): Boolean;
var
  qryDados : TUniQuery;
begin
  If (Not fCfgSis('HBFPRC', varBoolean)) Then
    Exit(False);

  qryDados := fCriaQuery;
  Try
    pValidaDocumentoContaOrdemRemessa(qryDados, strNumDoc, strEspDoc, VS_strCodEmp);

    Result := Not qryDados.IsEmpty;
  Finally
    FreeAndNil(qryDados);
  End;
end;

function fExisteDocumentoRemessaContaOrdemNaoCancelado(const strNumDoc,
  strEspDoc: String): Boolean;
var
  qryDados : TUniQuery;
begin
  Result := False;

  If (Not fCfgSis('HBFPRC', varBoolean)) Then
    Exit;

  qryDados := fCriaQuery;
  Try
    pValidaDocumentoContaOrdemRemessa(qryDados, strNumDoc, strEspDoc, VS_strCodEmp);

    If (qryDados.RecordCount = 0) Then
      Exit;

    If (strEspDoc = 'FF') Then
    Begin
      Result := (Not fEmptyStr(qryDados.FieldByName('NUMDOC_REMESSA_FATURADA').AsString));
    End
    Else If (strEspDoc = 'NF') Then
    Begin
      Result := ((qryDados.FieldByName('ESPDOC_FATURAMENTO').AsString = 'FF') And
                 (Not fEmptyStr(qryDados.FieldByName('NUMDOC_NOTGER_REMESSA').AsString))) Or
                ((qryDados.FieldByName('ESPDOC_FATURAMENTO').AsString = 'NF') And
                 (Not fEmptyStr(qryDados.FieldByName('NUMDOC_REMESSA_FATURADA').AsString)));
    End;
  Finally
    FreeAndNil(qryDados);
  End;
end;

function fSqlDocumentosContaOrdemRemessaContaOrdem(
  const strEspDoc: String): String;
begin
  Result := EmptyStr;

  If strEspDoc = 'PD' Then
  Begin
    Result := 'SELECT '
            + '       G.AUTOINCREM '
            + '     , G.FGO_NUMDOC '
            + '     , G.FGO_ESPDOC '
            + '     , G.FGO_CODEMP '
            + '     , G.FGO_TIPOPE '
            + '     , X.FGO_AUTRCO '
            + '     , IFNULL(F.AUTOINCREM, R.AUTOINCREM) AS AUTINC_VINCULACAO '
            + '     , IFNULL(F.FGO_NUMDOC, R.FGO_NUMDOC) AS NUMDOC_VINCULACAO '
            + '     , IFNULL(F.FGO_ESPDOC, R.FGO_ESPDOC) AS ESPDOC_VINCULACAO '
            + '     , IFNULL(F.FGO_CODEMP, R.FGO_CODEMP) AS CODEMP_VINCULACAO '
            + '     , IFNULL(F.FGO_CODCLI, R.FGO_CODCLI) AS CODCLI_VINCULACAO '
            + '  FROM FATGOR G '
            + ' INNER JOIN EXTGOR X ON X.FGO_SEQFGO = G.AUTOINCREM '
            + '  LEFT JOIN FATGOR F ON F.AUTOINCREM = X.FGO_AUTRCO '
            + '  LEFT JOIN EXTGOR E ON E.FGO_AUTRCO = G.AUTOINCREM '
            + '  LEFT JOIN FATGOR R ON R.AUTOINCREM = E.FGO_SEQFGO '
            + ' WHERE G.FGO_TIPOPE IN ("C","R") '
            + '   AND G.FGO_NUMDOC = :NUMDOC '
            + '   AND G.FGO_ESPDOC = :ESPDOC '
            + '   AND G.FGO_CODEMP = :CODEMP '
            + ' ORDER BY '
            + '       G.FGO_NUMDOC ';
  End
  Else If (MatchStr(strEspDoc,['NF','FF'])) Then
  Begin
    Result := 'SELECT '
            + '       G.AUTOINCREM '
            + '     , G.GER_NUMDOC '
            + '     , G.GER_ESPDOC '
            + '     , G.GER_CODEMP '
            + '     , T.FGO_TIPOPE '
            + '     , A.AUX_AUTRCO '
            + '     , O.FGO_NUMDOC                       AS NUMDOC_REMESSA '
            + '     , O.FGO_ESPDOC                       AS ESPDOC_REMESSA '
            + '     , O.FGO_CODEMP                       AS CODEMP_REMESSA '
            + '     , O.FGO_CODCLI                       AS CODCLI_REMESSA '
            + '     , O.FGO_MEN001                       AS MEN001_REMESSA '
            + '     , IFNULL(F.AUTOINCREM, R.AUTOINCREM) AS AUTINC_VINCULACAO '
            + '     , IFNULL(F.GER_NUMDOC, R.GER_NUMDOC) AS NUMDOC_VINCULACAO '
            + '     , IFNULL(F.GER_ESPDOC, R.GER_ESPDOC) AS ESPDOC_VINCULACAO '
            + '     , IFNULL(F.GER_CODEMP, R.GER_CODEMP) AS CODEMP_VINCULACAO '
            + '     , IFNULL(F.GER_CODCLI, R.GER_CODCLI) AS CODCLI_VINCULACAO '
            + '  FROM MOVGER G '
            + ' INNER JOIN AUXMOV A ON A.AUX_SEQGER = G.AUTOINCREM '
            + ' INNER JOIN FATGOR T ON T.FGO_NUMFAT = G.GER_NUMDOC '
            + '                    AND T.FGO_TIPFAT = G.GER_ESPDOC '
            + '                    AND T.FGO_EMPFAT = G.GER_CODEMP '
            + '  LEFT JOIN MOVGER F ON F.AUTOINCREM = A.AUX_AUTRCO '
            + '  LEFT JOIN AUXMOV E ON E.AUX_AUTRCO = G.AUTOINCREM '
            + '  LEFT JOIN MOVGER R ON R.AUTOINCREM = E.AUX_SEQGER '
            + '  LEFT JOIN FATGOR O ON O.FGO_NUMFAT = IFNULL(F.GER_NUMDOC, R.GER_NUMDOC) '
            + '                    AND O.FGO_TIPFAT = IFNULL(F.GER_ESPDOC, R.GER_ESPDOC) '
            + '                    AND O.FGO_EMPFAT = IFNULL(F.GER_CODEMP, R.GER_CODEMP) '
            + ' WHERE T.FGO_TIPOPE IN ("C","R") '
            + '   AND G.GER_NUMDOC = :NUMDOC '
            + '   AND G.GER_ESPDOC = :ESPDOC '
            + '   AND G.GER_CODEMP = :CODEMP '
            + ' ORDER BY '
            + '       G.GER_NUMDOC ';
  End;
end;

function fPermiteCancelarDocumentosContaOrdemRemessaContaOrdem(
  const strNumDoc, strEspDoc: String; var objPedidoVinculado: TPedidoVenda;
  var LNumDocRemessa, LEspDocRemessa, LCodEmpRemessa, LCodCliRemessa,
  LMen001Remessa: String): Boolean;
Var
  qryDados : TUniQuery;
begin
  Result := True;

  If (Not fCfgSis('HBFPRC', varBoolean)) Then
    Exit;

  qryDados := fCriaQuery;
  Try
    qryDados.SQL.Text := fSqlDocumentosContaOrdemRemessaContaOrdem(strEspDoc);

    If fEmptyStr(qryDados.SQL.Text) Then
      Exit;

    qryDados.ParamByName('NUMDOC').AsString := strNumDoc;
    qryDados.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryDados.Open;

    If (qryDados.IsEmpty) Then
      Exit;

    If (fEmptyStr(qryDados.FieldByName('AUTINC_VINCULACAO').AsString)) Then
      Exit;

    If Not Assigned(objPedidoVinculado) Then
      objPedidoVinculado := TPedidoVenda.Create;

    objPedidoVinculado.strNumDoc := qryDados.FieldByName('NUMDOC_VINCULACAO').AsString;
    objPedidoVinculado.strEspDoc := qryDados.FieldByName('ESPDOC_VINCULACAO').AsString;
    objPedidoVinculado.strCodEmp := qryDados.FieldByName('CODEMP_VINCULACAO').AsString;
    objPedidoVinculado.strCodCli := qryDados.FieldByName('CODCLI_VINCULACAO').AsString;

    If (MatchStr(strEspDoc, ['NF','FF'])) Then
    Begin
      LNumDocRemessa := qryDados.FieldByName('NUMDOC_REMESSA').AsString;
      LEspDocRemessa := qryDados.FieldByName('ESPDOC_REMESSA').AsString;
      LCodEmpRemessa := qryDados.FieldByName('CODEMP_REMESSA').AsString;
      LCodCliRemessa := qryDados.FieldByName('CODCLI_REMESSA').AsString;
      LMen001Remessa := qryDados.FieldByName('MEN001_REMESSA').AsString;
    End;
  Finally
    FreeAndNil(qryDados);
  End;
end;

function fPermiteBaixarDocumentosContaOrdemRemessaContaOrdem(
  const strNumDoc, strEspDoc: String; var LNumDocRemessa, LEspDocRemessa,
  LCodEmpRemessa: String): Boolean;
Var
  qryDados : TUniQuery;
begin
  Result := False;

  If (Not fCfgSis('HBFPRC', varBoolean)) Then
    Exit;

  qryDados := fCriaQuery;
  Try
    qryDados.SQL.Text := fSqlDocumentosContaOrdemRemessaContaOrdem(strEspDoc);

    qryDados.ParamByName('NUMDOC').AsString := strNumDoc;
    qryDados.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDados.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryDados.Open;

    If (qryDados.IsEmpty) Then
      Exit;

    If (fEmptyStr(qryDados.FieldByName('AUTINC_VINCULACAO').AsString)) Then
      Exit;

    LNumDocRemessa := qryDados.FieldByName('NUMDOC_VINCULACAO').AsString;
    LEspDocRemessa := qryDados.FieldByName('ESPDOC_VINCULACAO').AsString;
    LCodEmpRemessa := qryDados.FieldByName('CODEMP_VINCULACAO').AsString;

    Result := True;
  Finally
    FreeAndNil(qryDados);
  End;
end;

function fExisteDocumentoContaOrdemComRemessaNaoEmitidaNF(const strNumDoc,
  strEspDoc, strCodEmp: String): Boolean;
Var
  qryDados                 : TUniQuery;
  blnVerificarChaveRemessa : Boolean;
begin
  Result                   := False;
  blnVerificarChaveRemessa := True;

  If (Not fCfgSis('HBFPRC', varBoolean)) Then
    Exit;

  qryDados := fCriaQuery;
  Try
    pValidaDocumentoContaOrdemRemessa(qryDados, strNumDoc, strEspDoc, strCodEmp);

    If (qryDados.RecordCount = 0) Then
      Exit;

    If (strEspDoc = 'PD') Then
    Begin
      If (qryDados.FieldByName('ESPDOC_REMESSA_FATURADA').AsString = 'FF') And
         (fEmptyStr(qryDados.FieldByName('NUMDOC_NOTGER_REMESSA').AsString)) Then
      Begin
        blnVerificarChaveRemessa := False;
      End;
    End
    Else If (strEspDoc = 'FF') Then
    Begin
      If fEmptyStr(qryDados.FieldByName('NUMDOC_NOTGER_REMESSA').AsString) Then
      Begin
        Result := True;

        fMensagem('','Esse documento está vinculado a uma remessa de conta e ordem '+
                     'que não foi emitida a NF!', ['&Ok']);

        blnVerificarChaveRemessa := False;
      End;
    End;

    If (blnVerificarChaveRemessa) And
       (fEmptyStr(qryDados.FieldByName('CHAVE_REMESSA').AsString)) Then
    Begin
      Result := True;

      fMensagem('','Esse documento está vinculado a uma remessa de conta e ordem '+
                   'com NF emitida mas sem chave de acesso. É necessário que a '+
                   'chave de acesso da remessa seja gerada para prosseguir.', ['&Ok']);
    End;
  Finally
    FreeAndNil(qryDados);
  End;
End;

function fValidaTipoDocumentoRemessaEmitida(const strNumDoc, strEspDoc,
  strCodEmp, strEspDocSelecionado: String): Boolean;
Var
  qryDados : TUniQuery;
begin
  Result := True;

  qryDados := fCriaQuery;
  Try
    pValidaDocumentoContaOrdemRemessa(qryDados, strNumDoc, strEspDoc, strCodEmp);

    If (qryDados.RecordCount = 0) Then
      Exit;

    If (fEmptyStr(qryDados.FieldByName('ESPDOC_REMESSA_FATURADA').AsString)) And
       (fEmptyStr(qryDados.FieldByName('ESPDOC_NOTGER_REMESSA').AsString)) Then
    Begin
      Result := False;

      fMensagem('ATENÇÃO', 'A remessa vinculada a essa conta e ordem ainda '
                         + 'não foi faturada!', ['&Ok']);
      Exit;
    End;

    If ((qryDados.FieldByName('ESPDOC_REMESSA_FATURADA').AsString <> strEspDocSelecionado) And
        (fEmptyStr(qryDados.FieldByName('ESPDOC_NOTGER_REMESSA').AsString))) Or
       ((Not fEmptyStr(qryDados.FieldByName('ESPDOC_NOTGER_REMESSA').AsString)) And
        (qryDados.FieldByName('ESPDOC_NOTGER_REMESSA').AsString <> strEspDocSelecionado) And
        (qryDados.FieldByName('ESPDOC_REMESSA_FATURADA').AsString = 'FF')) Then
    Begin
      Result := False;

      fMensagem('ATENÇÃO', 'Não é possível continuar o faturamento, pois a '
                         + 'espécie do documento está diferente da remessa '
                         + 'já faturada!', ['&Ok']);
    End;
  Finally
    FreeAndNil(qryDados);
  End;
end;

function fEhPedidoAbastecimentoDeposito(strNumDoc, strEspDoc, strCodEmp: String):Boolean;
Var
  qryAbaDep: TUniQuery;
  strSQL: string;
begin
  qryAbaDep := fCriaQuery();

  Try
    strSQL := '';
    strSQL := strSQL + '  SELECT                                  ';
    strSQL := strSQL + '    FGO_ABADEP                            ';
    strSQL := strSQL + '  FROM                                    ';
    strSQL := strSQL + '    FATGOR FG                             ';
    strSQL := strSQL + '    INNER JOIN EXTGOR EG                  ';
    strSQL := strSQL + '      ON (FG.AUTOINCREM = EG.FGO_SEQFGO)  ';
    strSQL := strSQL + '  WHERE FG.FGO_NUMDOC = :NUMDOC           ';
    strSQL := strSQL + '    AND FG.FGO_ESPDOC = :ESPDOC           ';
    strSQL := strSQL + '    AND FG.FGO_CODEMP = :CODEMP           ';

    qryAbaDep.SQL.Text := strSQL;

    qryAbaDep.ParamByName('NUMDOC').AsString := strNumDoc;
    qryAbaDep.ParamByName('ESPDOC').AsString := strEspDoc;
    qryAbaDep.ParamByName('CODEMP').AsString := strCodEmp;
    qryAbaDep.Open;

    Result := (qryAbaDep.FieldByName('FGO_ABADEP').AsString = 'S');
  Finally
    FreeAndNil(qryAbaDep);
  End;
end;

function fEhPedidoComProducaoForaLoja(const strNumDoc, strEspDoc,
  strCodEmp: String): Boolean;
var
  qryDados : TUniQuery;
begin
  qryDados := fCriaQuery;
  Try
    qryDados.SQL.Text := 'SELECT '
                       + '       FATGOR.AUTOINCREM '
                       + '  FROM FATGOR '
                       + ' INNER JOIN FATDOR ON FATDOR.FDO_SEQGER = FATGOR.AUTOINCREM '
                       + ' WHERE FATGOR.FGO_NUMDOC = :NUMDOC '
                       + '   AND FATGOR.FGO_ESPDOC = :ESPDOC '
                       + '   AND FATGOR.FGO_CODEMP = :CODEMP '
                       + '   AND FATGOR.FGO_OPRFLJ = "S" '
                       + '   AND FATDOR.FDO_EMPPRD <> :CODEMP ';

    qryDados.ParamByName('NUMDOC').AsString := strNumDoc;
    qryDados.ParamByName('ESPDOC').AsString := strEspDoc;
    qryDados.ParamByName('CODEMP').AsString := strCodEmp;
    qryDados.Open;

    Result := Not qryDados.IsEmpty;
  Finally
    FreeAndNil(qryDados);
  End;
end;

procedure pAtualizaQtdExpItemPedido(strAutIncIte: String; fltQtdExp: Double; blnAtualizaOperadores: Boolean=False;
  strCodCon: String=''; strCodSep: String=''; strObsExp: String=''; strEmbExp: String='');
var
  qryAux: TUniQuery;
  strAutInc: string;
  strSQL: string;
begin
  qryAux := fCriaQuery(Nil);
  Try
    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + '   EXTDOR ';
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + '   FDO_QTDEXP = :QTDEXP ';

    If blnAtualizaOperadores Then
    Begin
      strSQL := strSQL + '   ,FDO_OPSEEX = :OPSEEX, ';
      strSQL := strSQL + '    FDO_OPEEXP = :OPEEXP, ';
      strSQL := strSQL + '    FDO_EMBEXP = :EMBEXP, ';
      strSQL := strSQL + '    FDO_OBSEXP = :OBSEXP  ';
    End;

    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   FDO_SEQFDO = :SEQFDO ';

    qryAux.SQL.Text := strSQL;

    qryAux.ParamByName('QTDEXP').AsFloat  := fltQtdExp;
    qryAux.ParamByName('SEQFDO').AsString := strAutIncIte;

    If blnAtualizaOperadores Then
    Begin
      qryAux.ParamByName('OPSEEX').AsString := strCodSep;
      qryAux.ParamByName('OPEEXP').AsString := strCodCon;
      qryAux.ParamByName('EMBEXP').AsString := strEmbExp;
      qryAux.ParamByName('OBSEXP').AsString := strObsExp;
    End;

    qryAux.ExecSQL;
    qryAux.Close;

    if (fCfgSis('LCEPAR', varBoolean)) then
    begin
      qryAux.SQL.Clear;
      qryAux.SQL.Text :=
        ' SELECT FDO_SEQGER FROM FATDOR ' +
        ' WHERE AUTOINCREM = :AUTINC ';
      qryAux.ParamByName('AUTINC').AsString := strAutIncIte;
      qryAux.Open;

      strAutInc := qryAux.FieldByName('FDO_SEQGER').AsString;

      if not fPedidoExpedido(strAutInc) then
      begin
        qryAux.SQL.Clear;
        qryAux.SQL.Text :=
          ' UPDATE EXTGOR SET FGO_DTLBEX = NULL, FGO_HRLBEX = NULL, FGO_OPEEXP = NULL, FGO_OBSEXP = NULL ' +
          ' WHERE FGO_SEQFGO = :AUTINC ';
        qryAux.ParamByName('AUTINC').AsString := strAutInc;
        qryAux.ExecSQL;

        qryAux.SQL.Clear;
        qryAux.SQL.Text :=
          ' UPDATE EXTDOR ' +
          ' JOIN FATDOR ON FATDOR.AUTOINCREM = FDO_SEQFDO ' +
          ' SET FDO_OPEEXP = NULL, FDO_OBSEXP = NULL ' +
          ' WHERE FDO_SEQGER = :AUTINC ' +
          '   AND FDO_JAFATU = 0 ' +
          '   AND (ROUND(FDO_QTDITE - FDO_QTDBAI, 4) - ROUND(FDO_QTDEXP, 4)) > 0';
        qryAux.ParamByName('AUTINC').AsString := strAutInc;
        qryAux.ExecSQL;
      end;
    end;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fPedidoExpedido(strAutGor: String; blnNaoVerificaRetiraBalcao: Boolean = False; blnNaoVerificaRetiraCaixa: Boolean = False; strEmpIte: String = ''): Boolean; overload;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery;
  Try
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('  COUNT(*) ');
      SQL.Add('FROM ');
      SQL.Add('  FATDOR ');
      SQL.Add('   LEFT JOIN EXTDOR ON FDO_SEQFDO        = FATDOR.AUTOINCREM ');
      SQL.Add('  INNER JOIN FATGOR ON FATGOR.AUTOINCREM = FATDOR.FDO_SEQGER ');
      SQL.Add('WHERE ');
      SQL.Add('  FATGOR.AUTOINCREM = :AUTINC AND ');
      SQL.Add('  FDO_ESPDOC  = :ESPDOC AND ');
      SQL.Add('  FDO_CODITE <> :ITESER AND ');
      SQL.Add('  FDO_CODITE <> :SERTER AND ');
      SQL.Add('  FDO_CODITE <> :ITEBOM AND ');
      SQL.Add('  FDO_CODITE <> :ITETAX AND ');
      SQL.Add('  FDO_CODITE <> :ITEMAN AND ');
      SQL.Add('  FDO_CODITE <> :ITELAN AND ');
      SQL.Add('  (ROUND(FDO_QTDITE - FDO_QTDBAI, 4) - ROUND(FDO_QTDEXP, 4)) > 0 ');

      If Not fEmptyStr(strEmpIte) Then
        SQL.Add('  AND IFNULL(FDO_EMPITE, "'+strEmpIte+'") = "'+strEmpIte+'" ');

      if blnNaoVerificaRetiraBalcao then
        SQL.Add('  AND NOT (FDO_ENTRET = "R" AND FDO_LOCRET IN ("B", "B2")) ');

      if blnNaoVerificaRetiraCaixa then
        SQL.Add('  AND NOT (FDO_ENTRET = "R" AND FDO_LOCRET = "C") ');

      ParamByName('AUTINC').AsString := strAutGor;
      ParamByName('ESPDOC').AsString := 'PD';
      ParamByName('ITESER').AsString := fCfgSis('ITESER', varString);
      ParamByName('SERTER').AsString := fCfgSis('SERTER', varString);
      ParamByName('ITEBOM').AsString := fCfgSis('ITEBOM', varString);
      ParamByName('ITETAX').AsString := fCfgSis('ITETAX', varString);
      ParamByName('ITEMAN').AsString := fCfgSis('ITEMAN', varString);
      ParamByName('ITELAN').AsString := fCfgSis('ITELAN', varString);

      Open;
      Result := (Fields[0].AsInteger = 0);
      Close;
    End;
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fPedidoExpedido(objPedido: TPedidoVenda): Boolean; overload;
var
  qryGen: TUniQuery;
  strSQL: string;
begin
  qryGen := fCriaQuery;
  Try
    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  COUNT(*) ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  FATDOR ';
    strSQL := strSQL + '  LEFT JOIN EXTDOR ON FDO_SEQFDO = FATDOR.AUTOINCREM ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  FDO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '  FDO_ESPDOC = :ESPDOC AND ';
    strSQL := strSQL + '  FDO_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  FDO_CODCLI = :CODCLI AND ';

    If Not fEmptyStr(fCfgSis('ITEMAN', varString)) Then
      strSQL := strSQL + '  FDO_CODITE <> :ITEMAN AND ';

    If Not fEmptyStr(fCfgSis('ITELAN', varString)) Then
      strSQL := strSQL + '  FDO_CODITE <> :ITELAN AND ';

    If Not fEmptyStr(fCfgSis('ITEBOM', varString)) Then
      strSQL := strSQL + '  FDO_CODITE <> :ITEBOM AND ';

    If Not fEmptyStr(fCfgSis('ITETAX', varString)) Then
      strSQL := strSQL + '  FDO_CODITE <> :ITETAX AND ';

    strSQL := strSQL + '  FDO_CODITE <> :ITESER AND ';
    strSQL := strSQL + '  FDO_CODITE <> :SERTER AND ';
    strSQL := strSQL + '  (ROUND(FDO_QTDITE - FDO_QTDBAI, 4) - ROUND(FDO_QTDEXP, 4)) > 0 ';

    qryGen.SQL.Text := strSQL;

    qryGen.ParamByName('NUMDOC').AsString := objPedido.strNumDoc;
    qryGen.ParamByName('ESPDOC').AsString := 'PD';
    qryGen.ParamByName('CODEMP').AsString := objPedido.strCodEmp;
    qryGen.ParamByName('CODCLI').AsString := objPedido.strCodCli;

    If qryGen.FindParam('ITEMAN') <> Nil Then
      qryGen.ParamByName('ITEMAN').AsString := fCfgSis('ITEMAN', varString);

    If qryGen.FindParam('ITELAN') <> Nil Then
      qryGen.ParamByName('ITELAN').AsString := fCfgSis('ITELAN', varString);

    If qryGen.FindParam('ITEBOM') <> Nil Then
      qryGen.ParamByName('ITEBOM').AsString := fCfgSis('ITEBOM', varString);
    If qryGen.FindParam('ITETAX') <> Nil Then
      qryGen.ParamByName('ITETAX').AsString := fCfgSis('ITETAX', varString);
    qryGen.ParamByName('ITESER').AsString := fCfgSis('ITESER', varString);
    qryGen.ParamByName('SERTER').AsString := fCfgSis('SERTER', varString);

    qryGen.Open;

    Result := (qryGen.Fields[0].AsInteger = 0);
  Finally
    FreeAndNil(qryGen);
  End;
end;

function fPedidoFoiExpedido(strNumDoc, strCodEmp, strCodCli: String; blnConsiderarPedidoSohComServicoComoExpedido: Boolean=True;
  blnNaoVerificaRetiraBalcao: Boolean = False; blnNaoVerificaRetiraCaixa: Boolean = False; strEmpIte: String = '';
  blnConsiderarParcialmenteExp: Boolean = False): Boolean;
Var
  strSQL: String;
  qryFgo: TUniQuery;
  qryGen: TUniQuery;

  function fProvenienteConserto: Boolean;
  Begin
    Result := Not fEmptyStr(fRetornaOrdemServicoPedido(
      strNumDoc, strCodEmp, qryFgo.FieldByName('FGO_CODVEN').AsString));
  End;

  function fSomenteServico: Boolean;
  Begin
    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT        ');
      SQL.Add('  *           ');
      SQL.Add('FROM          ');
      SQL.Add('  FATDOR      ');
      SQL.Add('WHERE         ');
      SQL.Add('  FDO_SEQGER = :AUTINC ');
      ParamByName('AUTINC').AsString := qryFgo.FieldByName('AUTOINCREM').AsString;
      Open;

      Result := True;

      First;
      While Not Eof Do
      Begin
        If Not fEhItemServico(qryGen.FieldByName('FDO_CODITE').AsString) Then
          Result := False;
        Next;
      End;

      Close;
    End;
  End;

Begin
  Result := False;

  qryFgo := fCriaQuery;
  qryGen := fCriaQuery;
  Try
    Try
      strSQL := strSQL + 'SELECT          ';
      strSQL := strSQL + '  F.AUTOINCREM, ';
      strSQL := strSQL + '  F.FGO_NUMDOC, ';
      strSQL := strSQL + '  F.FGO_CODVEN, ';
      strSQL := strSQL + '  E.FGO_DTLBEX  ';
      strSQL := strSQL + 'FROM            ';
      strSQL := strSQL + '  EXTGOR E      ';
      strSQL := strSQL + '  LEFT JOIN FATGOR F ON F.AUTOINCREM = E.FGO_SEQFGO ';
      strSQL := strSQL + 'WHERE                         ';
      strSQL := strSQL + '  F.FGO_NUMDOC = :NUMDOC AND  ';
      strSQL := strSQL + '  F.FGO_ESPDOC = :ESPDOC AND  ';
      strSQL := strSQL + '  F.FGO_CODEMP = :CODEMP AND  ';
      strSQL := strSQL + '  F.FGO_CODCLI = :CODCLI      ';

      With qryFgo Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := strNumDoc;
        ParamByName('ESPDOC').AsString := 'PD';
        ParamByName('CODEMP').AsString := strCodEmp;
        ParamByName('CODCLI').AsString := strCodCli;
        Open;

        If FieldByName('FGO_DTLBEX').AsDateTime > 0 Then
          Result := True
        Else If (VS_strTipExp = '4') Then

        begin
          if blnConsiderarParcialmenteExp then
            Result := fPedidoPossuiItemExpedido(FieldByName('AUTOINCREM').AsString)
          else
            Result := fPedidoExpedido(FieldByName('AUTOINCREM').AsString, blnNaoVerificaRetiraBalcao, blnNaoVerificaRetiraCaixa, strEmpIte);
        end;

        If (Not Result) And (fCfgSis('CONEQU') = 'S') Then
          Result := fProvenienteConserto;

        If (Not Result) And (blnConsiderarPedidoSohComServicoComoExpedido) Then
          Result := fSomenteServico;

      End;

    Except
      On E: Exception Do
        pMensagensErro(E.Message,'');
    End;
  Finally
    FreeAndNil(qryFgo);
    FreeAndNil(qryGen);
  End;
End;

function fAtualizaQtdExpedida(const strCodSep, strCodCon, strEmExp, strObsExp, strAutIncMovDet : String; fltQtdExp: Double): Boolean;
Var
  qryAux: TUniQuery;
  strSQL: string;
begin
  Result := True;
  qryAux := fCriaQuery;
  Try
    Try
      strSQL := '';
      strSQL := strSQL + ' UPDATE  ';
      strSQL := strSQL + '   MOVTRI ';
      strSQL := strSQL + ' SET ';
      strSQL := strSQL + '  DET_QTDEXP = IFNULL(DET_QTDEXP, 0) + :QTDEXP, ';
      strSQL := strSQL + '  DET_OPSEEX = :OPSEEX, ';
      strSQL := strSQL + '  DET_OPEEXP = :OPEEXP, ';
      strSQL := strSQL + '  DET_EMBEXP = :EMBEXP, ';
      strSQL := strSQL + '  DET_OBSEXP = :OBSEXP  ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '  DET_SEQGER = :SEQGER ';

      qryAux.SQL.Text := strSQL;

      qryAux.ParamByName('QTDEXP').AsFloat  := fltQtdExp;
      qryAux.ParamByName('SEQGER').AsString := strAutIncMovDet;

      qryAux.ParamByName('OPSEEX').AsString := strCodSep;
      qryAux.ParamByName('OPEEXP').AsString := strCodCon;
      qryAux.ParamByName('EMBEXP').AsString := strEmExp;
      qryAux.ParamByName('OBSEXP').AsString := strObsExp;

      qryAux.ExecSQL;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fAtualizaQtdExpedida]');
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fAtualizaTipBus(const strDetInc, strTipBus: String): Boolean;
  Var
   qryAux : TUniQuery;
begin
  Result := True;
  qryAux := fCriaQuery;
  Try
    Try
      With qryAux Do
      Begin
        SQL.Add(' UPDATE FATDOR ');
        SQL.Add('   JOIN MOVDET ON DET_NUM_PD = FDO_NUMDOC ');
        SQL.Add('              AND DET_ESP_PD = FDO_ESPDOC ');
        SQL.Add('              AND DET_EMP_PD = FDO_CODEMP ');
        SQL.Add('              AND DET_CODITE = FDO_CODITE ');
        SQL.Add('              AND DET_IND_PD = FDO_SEQIND ');
        SQL.Add('    SET FDO_TIPBUS = :TIPBUS ');
        SQL.Add('  WHERE MOVDET.AUTOINCREM = :AUTINC ');
        ParamByName('AUTINC').AsString := strDetInc;
        ParamByName('TIPBUS').AsString := strTipBus;

        ExecSQL;
      End;

      if fCfgSis('TIPEXP', varString) = 2 then
      begin
        qryAux.SQL.Clear;
        qryAux.SQL.Text :=
          ' UPDATE MOVTRI ' +
          '   JOIN MOVDET ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ' +
          '   SET DET_TIPBUS = :TIPBUS ' +
          ' WHERE MOVDET.AUTOINCREM = :AUTINC ';
        qryAux.ParamByName('AUTINC').AsString := strDetInc;
        qryAux.ParamByName('TIPBUS').AsString := strTipBus;
        qryAux.ExecSQL;
      end;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[fAtualizaTipBus]');
      End;
    End;
  Finally
    FreeAndNil(qryAux);
  End;
end;

function fSelectFromFatgorLeftAuxiliares(const blnJoinRomaneio: Boolean): String;
begin
  Result := EmptyStr;
  Result := Result + ' SELECT * ';
  Result := Result + '   FROM FATGOR F ';

  If (blnJoinRomaneio) Then
  Begin
    Result := Result + ' INNER JOIN ROMGERX R ON R.GER_CODEMP = F.FGO_CODEMP ';
    Result := Result + '                     AND R.GER_NUMDOC = F.FGO_NUMDOC ';
    Result := Result + '                     AND R.GER_ESPDOC = F.FGO_ESPDOC ';
    Result := Result + '                     AND R.GER_CODCLI = F.FGO_CODCLI ';
  End;

  Result := Result + '   LEFT JOIN EXTGOR E ON E.FGO_SEQFGO = F.AUTOINCREM ';
  Result := Result + '   LEFT JOIN SERGOR S ON S.FGO_SEQFGO = F.AUTOINCREM ';
  Result := Result + '   LEFT JOIN AUXGOR A ON A.AUX_SEQGER = F.AUTOINCREM ';
end;

function fRetornaUltimoSeqInd(const strNumDoc, strEspDoc, strCodEmp: String): Integer;
begin
   Result := fCampoTabela('COALESCE(MAX(FDO_SEQIND),0)', 'FATDOR',
                         ['FDO_NUMDOC', 'FDO_ESPDOC', 'FDO_CODEMP'],
                         [strNumDoc, strEspDoc, strCodEmp]);

   If (Result < 0) Then
     Result := 0;
end;

procedure pDeletaSepDor(AAutInc: String);
const
  strSQLFDO = 'SELECT AUTOINCREM FROM FATDOR WHERE FDO_SEQGER = :SEQGER ';
  strSQLDel = 'DELETE FROM SEPDOR WHERE SEP_SEQFDO = :SEQFDO ';
var
  LQryPed: TUniQuery;
  LQryAux: TUniQuery;
begin
  if (not fUsaOndaSeparacaoAgrupamento()) then
    Exit;

  LQryPed := fCriaQuery;
  LQryAux := fCriaQuery;

  try
    LQryPed.SQL.Text := strSQLFDO;
    LQryAux.SQL.Text := strSQLDel;

    LQryPed.ParamByName('SEQGER').AsString := AAutInc;
    LQryPed.Open;

    while not LQryPed.Eof do
    begin
      LQryAux.Close;
      LQryAux.ParamByName('SEQFDO').AsString := LQryPed.FieldByName('AUTOINCREM').AsString;
      LQryAux.ExecSQL;

      LQryPed.Next;
    end;
  finally
    FreeAndNil(LQryPed);
    FreeAndNil(LQryAux);
  end;
end;

initialization
  untFatGor.objReprocessarSaldoItens := nil;

end.


