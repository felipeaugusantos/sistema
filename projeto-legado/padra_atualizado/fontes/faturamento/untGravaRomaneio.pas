unit untGravaRomaneio;

interface

uses
  SysUtils, Classes, DB,
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Forms, Uni, UniClientDataSet,
{$ENDIF}
  Variants, StrUtils,
  untTypesSistema, untConstantes, Romaneio.TemporariaDocumentos;

type
  IProcessCRM = Interface
  ['{80EC3067-E4EB-40F5-992B-1CACF77749BE}']
    function NumDoc(const AValue: String): IProcessCRM;
    function EspDoc(const AValue: String): IProcessCRM;
    function CodEmp(const AValue: String): IProcessCRM;

    function DocumentsFgo(const AValue: String): IProcessCRM;
    function DocumentsGer(const AValue: String): IProcessCRM;
    function StlDocumentsBkp(const AValue: TStringList): IProcessCRM;
    function ProcessaStatusIndividualRomaneio(const AValue: Boolean): IProcessCRM;
    function objTemporariaDocsRomaneio(const AValue: TTemporariaDocumentosRomaneio): IProcessCRM;

    procedure pRun;
  end;

  TProcessCRM = class sealed(TInterfacedObject, IProcessCRM)
  protected
    FNumDoc: String;
    FEspDoc: String;
    FCodEmp: String;
    FDocumentsFgo: String;
    FDocumentsGer: String;
    FStlDocumentsBkp: TStringList;
    FProcessaStatusIndividualRomaneio: Boolean;
    FTemporariaDocsRomaneio: TTemporariaDocumentosRomaneio;

    constructor Create;

    function fReportedDocument: Boolean;
    procedure pAtualizaStatusParaFaturadoEmTransito(AListaSeqFGO: String);
  public
    function NumDoc(const AValue: String): IProcessCRM;
    function EspDoc(const AValue: String): IProcessCRM;
    function CodEmp(const AValue: String): IProcessCRM;

    function DocumentsFgo(const AValue: String): IProcessCRM;
    function DocumentsGer(const AValue: String): IProcessCRM;
    function StlDocumentsBkp(const AValue: TStringList): IProcessCRM;
    function ProcessaStatusIndividualRomaneio(const AValue: Boolean): IProcessCRM;
    function objTemporariaDocsRomaneio(const AValue: TTemporariaDocumentosRomaneio): IProcessCRM;

    procedure pRun;

    class function New: IProcessCRM;
  end;

  {Exemplo insert em batch: INSERT INTO tbl_name (a,b,c) VALUES (1,2,3), (4,5,6), (7,8,9)}

  TInsertsInBatch = class
  protected
    FCommand       : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
    FUltimoRegistro: Boolean;
    FExecutar      : Boolean;
    procedure HeadInsertInto; Virtual;
  public

    constructor New(); Reintroduce;
    destructor Destroy; Override;

    procedure AddCommand(ACommand : String);

    procedure SetUltimoRegistro(AValue : Boolean);
    function  GetUltimoRegistro : Boolean;

    procedure ExecSQL;
  end;

  TInsertsInBatchROMGERX = class(TInsertsInBatch)
  protected
    procedure HeadInsertInto; Override;
  public
    constructor New(); Reintroduce;
  end;

  TInsertsInBatchROMDETX = class(TInsertsInBatch)
  protected
    procedure HeadInsertInto; Override;
  public
    constructor New(); Reintroduce;
  end;

  TInsertsInBatchROMCND = class(TInsertsInBatch)
  protected
    procedure HeadInsertInto; Override;
  public
    constructor New(); Reintroduce;
  end;

  TInsertsInBatchAUXROMX = class(TInsertsInBatch)
  protected
    procedure HeadInsertInto; Override;
  public
    constructor New(); Reintroduce;
  end;

  TInsertsInBatchHISPED = class(TInsertsInBatch)
  protected
    procedure HeadInsertInto; Override;
  public
    constructor New(); Reintroduce;
  end;

  TInsertsInBatchROMTRAX = class(TInsertsInBatch)
  protected
    procedure HeadInsertInto; Override;
  public
    constructor New(); Reintroduce;
  end;

  function fGravacaoEmLote: Boolean;

  function fGravaRomGer(Var strNumRom: String;
                        Var strAutInc: String;
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
                        strTelCon,
                        strCgcCpf,
                        strCgcCon,
                        strIesCon,
                        strCli_Rg,
                        strRomImp: String;
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
                        fltPesBru,
                        fltPesLiq,
                        fltVolume: Double;
                        strEspeci,
                        strMarca,
                        strMen001,
                        strMen002: String;
                        blnJafatu: Boolean;
                        strTipFat,
                        strNumFat: String;
                        dtaDtaFat: TDateTime;
                        strVenFat,
                        strCndFat: String;
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
                        strClaFis: String;
                        fltPorDes: Double;
                        strCodDig,
                        strCodCnd,
                        strCodFpg,
                        strPlaVei,
                        strCodMot,
                        strCodAj1,
                        strCodAj2,
                        strCodAj3,
                        strCodAj4,
                        strObsFec,
                        strCodReg: String;
                        dtaDtaRom,
                        dtaHorRom: TDateTime;
                        strOpeRom: String;
                        intOrdImp: Integer;
                        fltVlrOri: Double;
                        strOpeSol: String;
                        strAutEnt: String;
                        fltFrete_,
                        fltAdiFre,
                        fltPerFre: Double;
                        strMsgExp,
                        strPalet,
                        strStatus,
                        strNumBox,
                        strNomTab,
                        strEntSai: String;
                        strAutIncGer: String;
                        strMenExp: String;
                        strMenEx2: String;
                        strMenEx3: String;
                        strMenEx4: String;
                        strLocali: String;
                        strLibApp: String;
                        strEvitar: String;
                        fltDistan,
                        fltTmpEnt: Double;
                        strEndEnt,
                        strBaiEnt,
                        strCepEnt,
                        strCidEnt,
                        strRefEnt,
                        strFilial,
                        strIniPar,
                        strCodFil,
                        strSeqTra,
                        strAltEnd: String;
                        qryRomGerX_: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX} = Nil;
                        strLatLon: String = '';
                        intPriori: Integer = 0;
                        strIntFus: String = 'N';
                        strRomFus: String = '';
                        dtaDtaIni: TDateTime = 0;
                        hraHorIni: TDateTime = 0;
                        strFstSht: String = '';
                        strFinRot: String = '';
                        AInsertsInBatchROMGERX: TInsertsInBatchROMGERX = nil;
                        AInsertsInBatchAUXROMX: TInsertsInBatchAUXROMX = nil;
                        AInsertsInBatchRomCnd: TInsertsInBatchROMCND = nil;
                        strAutIncRomGerX: String = '';
                        strDefCon: String = ''): Boolean;

  function fGravaRomDet(strNumRom: String;
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
                        fltTotIte,
                        fltVlrCon,
                        fltTotCus,
                        fltTotMed,
                        fltDesCon,
                        fltTotFre,
                        fltDesEsp: Double;
                        strCodRep: String;
                        fltPerCom,
                        fltTotCom: Double;
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
                        strNumFat: String;
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
                        strCodFpg: String;
                        fltQtdBai: Double;
                        strInfIte,
                        strSepImp,
                        strAutInc,
                        strNumLot: String;
                        fltPesLiq: Double;
                        fltVolume: Double;
                        fltValCbs: Double;
                        fltValIbs: Double;
                        fltVal_Is: Double;
                        strEmpOri: String = '';
                        qryRomDetX_: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX} = Nil;
                        objInsertsInBatch : TInsertsInBatchROMDETX = Nil;
                        strAutIncRomDetX  : String = ''): Boolean;

  function fGravaRomTra(ASeqGer, AEmpDes: String; AInsertsInBatch: TInsertsInBatchROMTRAX = nil): Boolean;

  procedure fAddValue(var ACommand: String;
                     AValue      : Variant;
                     AFieldType  : TFieldType;
                     AUltimo     : Boolean = False);

  function fRetValuesRomGer(strNumRom,
                            strAutInc,
                            strNumDoc,
                            strSerie,
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
                            strTelCon,
                            strCgcCpf,
                            strCgcCon,
                            strIesCon,
                            strCli_Rg,
                            strEndEnt,
                            strBaiEnt,
                            strCepEnt,
                            strCidEnt,
                            strRefEnt: String;
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
                            fltPesBru,
                            fltPesLiq,
                            fltVolume: Double;
                            strEspeci,
                            strMarca,
                            strMen001,
                            strMen002: String;
                            intJafatu: Integer;
                            strTipFat,
                            strNumFat: String;
                            dtaDtaFat: TDateTime;
                            strVenFat,
                            strCndFat: String;
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
                            strNotEsp,
                            strClaFis: String;
                            fltPorDes: Double;
                            strCodDig,
                            strCodCnd,
                            strCodFpg,
                            strCodMot,
                            strCodAj1,
                            strCodAj2,
                            strCodAj3,
                            strCodAj4,
                            strObsFec,
                            strPlaVei,
                            strCodReg: String;
                            dtaDtaRom,
                            dtaHorRom: TDateTime;
                            strOpeRom: String;
                            fltVlrOri: Double;
                            strRomImp: String;
                            intOrdImp: Integer;
                            strLocali,
                            strLibApp,
                            strEvitar: String;
                            fltDistan,
                            fltTmpEnt: Double;
                            strFilial,
                            strIniPar,
                            strFstSht,
                            strFinRot,
                            strOpeSol,
                            strEmpRom,
                            strAutEnt,
                            strNumBox: String;
                            fltFrete_,
                            fltAdiFre,
                            fltPerFre: Double;
                            strPalet,
                            strStatus,
                            strCodBar,
                            strNomTab,
                            strEntSai,
                            strAutIncGer,
                            strRetFil,
                            strCodFil,
                            strSeqTra,
                            strAltEnd,
                            strLatLon: String;
                            intPriori: Integer;
                            strIntFus,
                            strRomFus: String;
                            dtaDtaIni,
                            hraHorIni: TDateTime;
                            strDefCon: String): String;

  function fRetValuesRomDet(strNumRom: String;
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
                            fltTotIte,
                            fltVlrCon,
                            fltTotCus,
                            fltTotMed,
                            fltDesCon,
                            fltTotFre,
                            fltDesEsp: Double;
                            strCodRep: String;
                            fltPerCom,
                            fltTotCom: Double;
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
                            strNumFat: String;
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
                            strCodFpg: String;
                            fltQtdBai: Double;
                            strInfIte,
                            strSepImp,
                            strAutInc,
                            strNumLot: String;
                            fltPesLiq: Double;
                            fltVolume: Double;
                            fltValCbs: Double;
                            fltValIbs: Double;
                            fltVal_Is: Double;
                            strEmpOri: String = '';
                            strAutIncRomDetX : String = '') : String;

  procedure fGravaROMCND(strAutInc: String; arrDuplic: TarrDuplicata; AInsertsInBatchRomCnd: TInsertsInBatchROMCND = nil);

  procedure pDeletaRomaneio(strNumRom: String; blnEntDev: Boolean; blnProcessaCRM: Boolean = False);

  procedure pSubtrairValRomDocumentos(qryDocs: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX}; strNumRom: String; blnEntDev: Boolean);
  procedure pRemoverVinculoRomaneioComDocumento(qryDocs: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX}; strOpcRom: String);
  procedure pDeletaRomOutX(strNumRom: String; strSeqDig: String = '');
  procedure pAtualizaRASROM(strNumRom: String);
  function fCriaDataSetOutDig: TUniClientDataSet;
  procedure pInsereOutDigXDefinicaoRotas(const AOutDig, ATmpDoc: TUniClientDataSet);
  function fSqlValoresReformaTributariaRomaneio(const ATabelaDetalhe, AAliasDetalhe: String; const AExpressaoRateio: String = ''): String;

implementation

uses

{$IFNDEF LINUX}
  untFuncoesSimples,
{$ELSE}
  untFuncoesGenerica,
{$ENDIF LINUX}

{$IFNDEF FUSION}
  untSIGEPWebFuncoes,
{$ENDIF FUSION}
  untTSituacaoPedidoVenda,
  untAtualizaOcorrenciasCRM, untTypesCRM;

Procedure pGravaAuxRomx(strAutInc, strMsgExp, strMenExp, strMenEx2, strMenEx3, strMenEx4: String);
var
  qryAuxRomX: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
Begin
  qryAuxRomX := fCriaQuery;

  try
    qryAuxRomX.SQL.Add('INSERT INTO AUXROMX ');
    qryAuxRomX.SQL.Add('  (AUX_SEQGER, AUX_MSGEXP, AUX_MENEXP, AUX_MENEX2, AUX_MENEX3, AUX_MENEX4) ');
    qryAuxRomX.SQL.Add('VALUES ');
    qryAuxRomX.SQL.Add('  (:AUX_SEQGER, :AUX_MSGEXP, :AUX_MENEXP, :AUX_MENEX2, :AUX_MENEX3, :AUX_MENEX4) ');
    qryAuxRomX.ParamByName('AUX_SEQGER').Value := strAutInc;
    qryAuxRomX.ParamByName('AUX_MSGEXP').Value := strMsgExp;
    qryAuxRomX.ParamByName('AUX_MENEXP').Value := strMenExp;
    qryAuxRomX.ParamByName('AUX_MENEX2').Value := strMenEx2;
    qryAuxRomX.ParamByName('AUX_MENEX3').Value := strMenEx3;
    qryAuxRomX.ParamByName('AUX_MENEX4').Value := strMenEx4;
    qryAuxRomX.ExecSQL;
  finally
{$IFNDEF LINUX}
    FreeAndNil(qryAuxRomX);
{$ENDIF LINUX}
  end;
End;

function fGravaRomGer(Var strNumRom: String;
                      Var strAutInc: String;
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
                      strTelCon,
                      strCgcCpf,
                      strCgcCon,
                      strIesCon,
                      strCli_Rg,
                      strRomImp: String;
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
                      fltPesBru,
                      fltPesLiq,
                      fltVolume: Double;
                      strEspeci,
                      strMarca,
                      strMen001,
                      strMen002: String;
                      blnJafatu: Boolean;
                      strTipFat,
                      strNumFat: String;
                      dtaDtaFat: TDateTime;
                      strVenFat,
                      strCndFat: String;
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
                      strClaFis: String;
                      fltPorDes: Double;
                      strCodDig,
                      strCodCnd,
                      strCodFpg,
                      strPlaVei,
                      strCodMot,
                      strCodAj1,
                      strCodAj2,
                      strCodAj3,
                      strCodAj4,
                      strObsFec,
                      strCodReg: String;
                      dtaDtaRom,
                      dtaHorRom: TDateTime;
                      strOpeRom: String;
                      intOrdImp: Integer;
                      fltVlrOri: Double;
                      strOpeSol: String;
                      strAutEnt: String;
                      fltFrete_,
                      fltAdiFre,
                      fltPerFre: Double;
                      strMsgExp,
                      strPalet,
                      strStatus,
                      strNumBox,
                      strNomTab,
                      strEntSai: String;
                      strAutIncGer: String;
                      strMenExp: String;
                      strMenEx2: String;
                      strMenEx3: String;
                      strMenEx4: String;
                      strLocali: String;
                      strLibApp: String;
                      strEvitar: String;
                      fltDistan,
                      fltTmpEnt: Double;
                      strEndEnt,
                      strBaiEnt,
                      strCepEnt,
                      strCidEnt,
                      strRefEnt,
                      strFilial,
                      strIniPar,
                      strCodFil,
                      strSeqTra,
                      strAltEnd: String;
                      qryRomGerX_: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX} = Nil;
                      strLatLon: String = '';
                      intPriori: Integer = 0;
                      strIntFus: String = 'N';
                      strRomFus: String = '';
                      dtaDtaIni: TDateTime = 0;
                      hraHorIni: TDateTime = 0;
                      strFstSht: String = '';
                      strFinRot: String = '';
                      AInsertsInBatchROMGERX: TInsertsInBatchROMGERX = nil;
                      AInsertsInBatchAUXROMX: TInsertsInBatchAUXROMX = nil;
                      AInsertsInBatchRomCnd: TInsertsInBatchROMCND = nil;
                      strAutIncRomGerX: String = '';
                      strDefCon: String = ''): Boolean;
var
  qryRomGerX: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LValuesRomGer: String;
Begin
  if (not strAutIncRomGerX.IsEmpty) then
    strAutInc := strAutIncRomGerX
  else
    strAutInc := fRetAutoIncrem('ROMGERX', strCodEmp);

  if (fEmptyStr(strNumRom)) then
    strNumRom := fAtualizaProCod('ROMGERX', 'GER_NUMROM');

  try
    if Assigned(AInsertsInBatchROMGERX) and fGravacaoEmLote then
    begin
      Result := True;
      LValuesRomGer := fRetValuesRomGer(strNumRom,
                                        strAutInc,
                                        strNumDoc,
                                        strSerie,
                                        strEspDoc,
                                        strCodEmp,
                                        strCodTra,
                                        strCodVen,
                                        strCodFor,
                                        strCodCli,
                                        strTip_Fc,
                                        dtaDtaEnt,
                                        tmrHorEnt,
                                        dtaDtaDoc,
                                        fTiraCaracEspeciais(strConPag),
                                        strEstado,
                                        strNomCon,
                                        strEndCon,
                                        strBaiCon,
                                        strCepCon,
                                        strCidCon,
                                        strEstCon,
                                        strTelCon,
                                        strCgcCpf,
                                        strCgcCon,
                                        strIesCon,
                                        strCli_Rg,
                                        strEndEnt,
                                        strBaiEnt,
                                        strCepEnt,
                                        strCidEnt,
                                        strRefEnt,
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
                                        fltPesBru,
                                        IIF((fFormataFloat(fltPesLiq, 2) <= 0), fltPesBru, fltPesLiq),
                                        fltVolume,
                                        strEspeci,
                                        strMarca,
                                        strMen001,
                                        strMen002,
                                        IIF(blnJafatu, 1, 0),
                                        strTipFat,
                                        strNumFat,
                                        dtaDtaFat,
                                        strVenFat,
                                        strCndFat,
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
                                        fltVPar12,
                                        strNotEsp,IIF(Pos(strEspDoc, 'BR_TE_') > 0, '5999', strClaFis),
                                        fltPorDes,
                                        strCodDig,
                                        strCodCnd,
                                        strCodFpg,
                                        strCodMot,
                                        strCodAj1,
                                        strCodAj2,
                                        strCodAj3,
                                        strCodAj4,
                                        strObsFec,
                                        strPlaVei,
                                        strCodReg,
                                        dtaDtaRom,
                                        dtaHorRom,
                                        strOpeRom,
                                        fltVlrOri,
                                        strRomImp,
                                        intOrdImp,
                                        strLocali,
                                        strLibApp,
                                        strEvitar,
                                        fltDistan,
                                        fltTmpEnt,
                                        strFilial,
                                        strIniPar,
                                        strFstSht,
                                        strFinRot,
                                        strOpeSol,
                                        VS_strCodEmp,
                                        strAutEnt,
                                        strNumBox,
                                        fltFrete_,
                                        fltAdiFre,
                                        fltPerFre,
                                        strPalet,
                                        strStatus,
                                        IfThen(strStatus = 'P', fGeraCodBarraEAN13('1' + strNumRom + '91' + VS_strCodEmp), ''),
                                        strNomTab,
                                        strEntSai,
                                        strAutIncGer,
                                        IIF((not fEmptyStr(strCodFil)), 'S', ''),
                                        strCodFil,
                                        strSeqTra,
                                        strAltEnd,
                                        strLatLon,
                                        intPriori,
                                        strIntFus,
                                        strRomFus,
                                        dtaDtaIni,
                                        hraHorIni,
                                        strDefCon);

      AInsertsInBatchROMGERX.AddCommand(LValuesRomGer);

      AInsertsInBatchAUXROMX.AddCommand('(' +
                                        QuotedStr(strAutInc) + ',' +
                                        QuotedStr(strMsgExp + ' ') + ',' +
                                        QuotedStr(strMenExp + ' ') + ',' +
                                        QuotedStr(strMenEx2 + ' ') + ',' +
                                        QuotedStr(strMenEx3 + ' ') + ',' +
                                        QuotedStr(strMenEx4 + ' ') + ')');

      fGravaROMCND(strAutInc, arrDuplic, AInsertsInBatchRomCnd);

      Exit;
    end;
  except on E: Exception do
    raise;
  end;

  if (Assigned(qryRomGerX_)) then
    qryRomGerX := qryRomGerX_
  else
  begin
    qryRomGerX := fCriarQuery('SELECT * FROM ROMGERX WHERE FALSE');
    qryRomGerX.Open;
  end;

  try
    Try
      qryRomGerX.Append;
      qryRomGerX.FieldByName('GER_NUMROM').AsString   := strNumRom;
      qryRomGerX.FieldByName('AUTOINCREM').AsString   := strAutInc;
      qryRomGerX.FieldByName('GER_NUMDOC').AsString   := strNumDoc;
      qryRomGerX.FieldByName('GER_SERIE_').AsString   := strSerie;
      qryRomGerX.FieldByName('GER_ESPDOC').AsString   := strEspDoc;
      qryRomGerX.FieldByName('GER_CODEMP').AsString   := strCodEmp;

      If fEmptyStr(strCodTra) Then
        qryRomGerX.FieldByName('GER_CODTRA').Value    := Null
      Else
        qryRomGerX.FieldByName('GER_CODTRA').AsString := strCodTra;

      If fEmptyStr(strCodVen) Then
        qryRomGerX.FieldByName('GER_CODVEN').Value    := Null
      Else
        qryRomGerX.FieldByName('GER_CODVEN').AsString := strCodVen;

      If fEmptyStr(strCodFor) Then
        qryRomGerX.FieldByName('GER_CODFOR').Value    := Null
      Else
        qryRomGerX.FieldByName('GER_CODFOR').AsString := strCodFor;

      If fEmptyStr(strCodCli) Then
        qryRomGerX.FieldByName('GER_CODCLI').Value    := Null
      Else
        qryRomGerX.FieldByName('GER_CODCLI').AsString := strCodCli;

      qryRomGerX.FieldByName('GER_TIP_FC').AsString   := strTip_Fc;

      If (dtaDtaEnt = 0) Then
        qryRomGerX.FieldByName('GER_DTAENT').Value      := Null
      Else
        qryRomGerX.FieldByName('GER_DTAENT').AsDateTime := dtaDtaEnt;

      If (tmrHorEnt = 0) Then
        qryRomGerX.FieldByName('GER_HORENT').Value      := Null
      Else
        qryRomGerX.FieldByName('GER_HORENT').AsDateTime := tmrHorEnt;

      If (dtaDtaDoc = 0) Then
        qryRomGerX.FieldByName('GER_DTADOC').Value      := Null
      Else
        qryRomGerX.FieldByName('GER_DTADOC').AsDateTime := dtaDtaDoc;

      If fEmptyStr(fTiraCaracEspeciais(strConPag)) Then
        qryRomGerX.FieldByName('GER_CONPAG').Value := Null
      Else
        qryRomGerX.FieldByName('GER_CONPAG').AsString := fTiraCaracEspeciais(strConPag);

      qryRomGerX.FieldByName('GER_ESTADO').AsString   := strEstado;

      qryRomGerX.FieldByName('GER_NOMCON').AsString := strNomCon;

      If fEmptyStr(strNomCon) Then
      Begin
        qryRomGerX.FieldByName('GER_NOMCON').Value := Null;
        qryRomGerX.FieldByName('GER_ENDCON').Value := Null;
        qryRomGerX.FieldByName('GER_BAICON').Value := Null;
        qryRomGerX.FieldByName('GER_CEPCON').Value := Null;
        qryRomGerX.FieldByName('GER_CIDCON').Value := Null;
        qryRomGerX.FieldByName('GER_ESTCON').Value := Null;
        qryRomGerX.FieldByName('GER_TELCON').Value := Null;
        qryRomGerX.FieldByName('GER_CGCCPF').Value := Null;
        qryRomGerX.FieldByName('GER_CGCCON').Value := Null;
        qryRomGerX.FieldByName('GER_IESCON').Value := Null;
        qryRomGerX.FieldByName('GER_R_GCON').Value := Null;
      End
      Else
      Begin
        qryRomGerX.FieldByName('GER_NOMCON').AsString := strNomCon;
        qryRomGerX.FieldByName('GER_ENDCON').AsString := strEndCon;
        qryRomGerX.FieldByName('GER_BAICON').AsString := strBaiCon;
        qryRomGerX.FieldByName('GER_CEPCON').AsString := strCepCon;
        qryRomGerX.FieldByName('GER_CIDCON').AsString := strCidCon;
        qryRomGerX.FieldByName('GER_ESTCON').AsString := strEstCon;
        qryRomGerX.FieldByName('GER_TELCON').AsString := strTelCon;
        qryRomGerX.FieldByName('GER_CGCCPF').AsString := strCgcCpf;
        qryRomGerX.FieldByName('GER_CGCCON').AsString := strCgcCon;
        qryRomGerX.FieldByName('GER_IESCON').AsString := strIesCon;
        qryRomGerX.FieldByName('GER_R_GCON').AsString := strCli_Rg;
      End;

      qryRomGerX.FieldByName('GER_ENDENT').AsString := strEndEnt;
      qryRomGerX.FieldByName('GER_BAIENT').AsString := strBaiEnt;
      qryRomGerX.FieldByName('GER_CEPENT').AsString := strCepEnt;
      qryRomGerX.FieldByName('GER_CIDENT').AsString := strCidEnt;
      qryRomGerX.FieldByName('GER_REFENT').AsString := strRefEnt;

      qryRomGerX.FieldByName('GER_BASSIM').AsFloat    := fltBasSim;
      qryRomGerX.FieldByName('GER_BASIPI').AsFloat    := fltBasIpi;
      qryRomGerX.FieldByName('GER_ALQIPI').AsFloat    := fltAlqIpi;
      qryRomGerX.FieldByName('GER_TOTIPI').AsFloat    := fltTotIpi;
      qryRomGerX.FieldByName('GER_BASICM').AsFloat    := fltBasIcm;
      qryRomGerX.FieldByName('GER_ALQICM').AsFloat    := fltAlqIcm;
      qryRomGerX.FieldByName('GER_TOTICM').AsFloat    := fltTotIcm;
      qryRomGerX.FieldByName('GER_TOTRET').AsFloat    := fltTotRet;
      qryRomGerX.FieldByName('GER_ALQRET').AsFloat    := fltAlqRet;
      qryRomGerX.FieldByName('GER_BASRET').AsFloat    := fltBasRet;
      qryRomGerX.FieldByName('GER_DESESP').AsFloat    := fltDesEsp;
      qryRomGerX.FieldByName('GER_VLRCON').AsFloat    := fltVlrCon;
      qryRomGerX.FieldByName('GER_TOTPRO').AsFloat    := fltTotPro;
      qryRomGerX.FieldByName('GER_TOTCUS').AsFloat    := fltTotCus;
      qryRomGerX.FieldByName('GER_TOTMED').AsFloat    := fltTotMed;
      qryRomGerX.FieldByName('GER_TIPFRE').AsString   := strTipFre;
      qryRomGerX.FieldByName('GER_TOTFRE').AsFloat    := fltTotFre;
      qryRomGerX.FieldByName('GER_PESBRU').AsFloat    := fltPesBru;

      If fFormataFloat(fltPesLiq,2) <= 0 Then
        qryRomGerX.FieldByName('GER_PESLIQ').AsFloat  := fltPesBru
      Else
        qryRomGerX.FieldByName('GER_PESLIQ').AsFloat  := fltPesLiq;

      qryRomGerX.FieldByName('GER_VOLUME').AsFloat    := fltVolume;
      qryRomGerX.FieldByName('GER_ESPECI').AsString   := strEspeci;
      qryRomGerX.FieldByName('GER_MARCA_').AsString   := strMarca;
      qryRomGerX.FieldByName('GER_MEN001').AsString   := strMen001;
      qryRomGerX.FieldByName('GER_MEN002').AsString   := strMen002;

      If qryRomGerX.FieldByName('GER_JAFATU').DataType = ftInteger Then
        qryRomGerX.FieldByName('GER_JAFATU').AsInteger := IIF(blnJafatu, 1, 0)
      else
        qryRomGerX.FieldByName('GER_JAFATU').AsBoolean := IIF(blnJafatu, True, False);

      qryRomGerX.FieldByName('GER_TIPFAT').AsString   := strTipFat;
      qryRomGerX.FieldByName('GER_NUMFAT').AsString   := strNumFat;

      If (dtaDtaFat = 0) Then
        qryRomGerX.FieldByName('GER_DTAFAT').Value      := Null
      Else
        qryRomGerX.FieldByName('GER_DTAFAT').AsDateTime := dtaDtaFat;

      If Not fEmptyStr(strVenFat) Then
        qryRomGerX.FieldByName('GER_VENFAT').AsString := strVenFat
      Else
        qryRomGerX.FieldByName('GER_VENFAT').Value := Null;

      qryRomGerX.FieldByName('GER_CNDFAT').AsString   := strCndFat;
      qryRomGerX.FieldByName('GER_VALFAT').AsFloat    := fltValFat;
      qryRomGerX.FieldByName('GER_VPAR01').AsFloat    := fltVPar01;
      qryRomGerX.FieldByName('GER_VPAR02').AsFloat    := fltVPar02;
      qryRomGerX.FieldByName('GER_VPAR03').AsFloat    := fltVPar03;
      qryRomGerX.FieldByName('GER_VPAR04').AsFloat    := fltVPar04;
      qryRomGerX.FieldByName('GER_VPAR05').AsFloat    := fltVPar05;
      qryRomGerX.FieldByName('GER_VPAR06').AsFloat    := fltVPar06;
      qryRomGerX.FieldByName('GER_VPAR07').AsFloat    := fltVPar07;
      qryRomGerX.FieldByName('GER_VPAR08').AsFloat    := fltVPar08;
      qryRomGerX.FieldByName('GER_VPAR09').AsFloat    := fltVPar09;
      qryRomGerX.FieldByName('GER_VPAR10').AsFloat    := fltVPar10;
      qryRomGerX.FieldByName('GER_VPAR11').AsFloat    := fltVPar11;
      qryRomGerX.FieldByName('GER_VPAR12').AsFloat    := fltVPar12;
      qryRomGerX.FieldByName('GER_NOTESP').AsString   := strNotEsp;
      qryRomGerX.FieldByName('GER_CLAFIS').AsString   := IIF(Pos(strEspDoc, 'BR_TE_') > 0, '5999', strClaFis);
      qryRomGerX.FieldByName('GER_PORDES').AsFloat    := fltPorDes;

      If (fEmptyStr(strCodDig)) Then
        qryRomGerX.FieldByName('GER_CODDIG').Value := Null
      Else
        qryRomGerX.FieldByName('GER_CODDIG').AsString   := strCodDig;

      If (fEmptyStr(strCodCnd)) Then
        qryRomGerX.FieldByName('GER_CODCND').Value := Null
      Else
        qryRomGerX.FieldByName('GER_CODCND').AsString   := strCodCnd;

      If (fEmptyStr(strCodFpg)) Then
        qryRomGerX.FieldByName('GER_CODFPG').Value := Null
      Else
        qryRomGerX.FieldByName('GER_CODFPG').AsString := strCodFpg;

      If (fEmptyStr(strCodMot)) Then
        qryRomGerX.FieldByName('GER_CODMOT').Value := Null
      Else
        qryRomGerX.FieldByName('GER_CODMOT').AsString   := strCodMot;

      If (fEmptyStr(strCodAj1)) Then
           qryRomGerX.FieldByName('GER_CODAJ1').Value    := Null
      Else qryRomGerX.FieldByName('GER_CODAJ1').AsString := strCodAj1;

      If (fEmptyStr(strCodAj2)) Then
           qryRomGerX.FieldByName('GER_CODAJ2').Value    := Null
      Else qryRomGerX.FieldByName('GER_CODAJ2').AsString := strCodAj2;

      If (fEmptyStr(strCodAj3)) Then
        qryRomGerX.FieldByName('GER_CODAJ3').Value    := Null
      Else
        qryRomGerX.FieldByName('GER_CODAJ3').AsString := strCodAj3;

      If (fEmptyStr(strCodAj4)) Then
        qryRomGerX.FieldByName('GER_CODAJ4').Value    := Null
      Else
        qryRomGerX.FieldByName('GER_CODAJ4').AsString := strCodAj4;

      If (fEmptyStr(strObsFec)) Then
        qryRomGerX.FieldByName('GER_OBSFEC').Value    := Null
      Else
        qryRomGerX.FieldByName('GER_OBSFEC').AsString := strObsFec;

      If fEmptyStr(fTiraCaracEspeciais(strPlaVei)) Then
        qryRomGerX.FieldByName('GER_PLAVEI').Value := Null
      Else
        qryRomGerX.FieldByName('GER_PLAVEI').AsString := strPlaVei;

      If fEmptyStr(strCodReg) Then
        qryRomGerX.FieldByName('GER_CODREG').Value    := Null
      Else
        qryRomGerX.FieldByName('GER_CODREG').AsString := strCodReg;

      qryRomGerX.FieldByName('GER_DTAROM').AsDateTime := dtaDtaRom;
      qryRomGerX.FieldByName('GER_HORROM').AsDateTime := dtaHorRom;
      qryRomGerX.FieldByName('GER_OPEROM').AsString   := strOpeRom;
      qryRomGerX.FieldByName('GER_VLRORI').AsFloat    := fltVlrOri;
      qryRomGerX.FieldByName('GER_ROMIMP').AsString   := strRomImp;
      qryRomGerX.FieldByName('GER_ORDIMP').AsInteger  := intOrdImp;

      if fCfgSis('MATDIS', varBoolean) then
      begin
        qryRomGerX.FieldByName('GER_LOCALI').AsString := strLocali;
        qryRomGerX.FieldByName('GER_LIBAPP').AsString := strLibApp;
        qryRomGerX.FieldByName('GER_EVITAR').AsString := strEvitar;
        qryRomGerX.FieldByName('GER_DISTAN').AsFloat := fltDistan;
        qryRomGerX.FieldByName('GER_TMPENT').AsFloat := fltTmpEnt;
        qryRomGerX.FieldByName('GER_FILIAL').AsString := strFilial;
        qryRomGerX.FieldByName('GER_INIPAR').AsString := strIniPar;
        qryRomGerX.FieldByName('GER_FSTSHT').AsString := strFstSht;
        qryRomGerX.FieldByName('GER_FINROT').AsString := strFinRot;
      end;

      If fEmptyStr(strOpeSol) Then
        qryRomGerX.FieldByName('GER_OPESOL').Value := Null
      Else
        qryRomGerX.FieldByName('GER_OPESOL').AsString := strOpeSol;

      qryRomGerX.FieldByName('GER_EMPROM').AsString := VS_strCodEmp;
      qryRomGerX.FieldByName('GER_ENTGER').AsString := strAutEnt;

      qryRomGerX.FieldByName('GER_NUMBOX').AsString   := strNumBox;
      qryRomGerX.FieldByName('GER_FRETE_').AsFloat    := fltFrete_;
      qryRomGerX.FieldByName('GER_ADIFRE').AsFloat    := fltAdiFre;
      qryRomGerX.FieldByName('GER_PERFRE').AsFloat    := fltPerFre;
      qryRomGerX.FieldByName('GER_PALET_').AsString   := strPalet;
      qryRomGerX.FieldByName('GER_STATUS').AsString   := strStatus;
      qryRomGerX.FieldByName('GER_CODBAR').AsString   := IfThen(strStatus = 'P', fGeraCodBarraEAN13('1' + strNumRom + '91' + VS_strCodEmp), '');
      qryRomGerX.FieldByName('GER_NOMTAB').AsString   := strNomTab;
      qryRomGerX.FieldByName('GER_ENTSAI').AsString   := strEntSai;
      qryRomGerX.FieldByName('GER_AUTINC').AsString   := strAutIncGer;

      If not fEmptyStr(strCodFil) Then
      Begin
        qryRomGerX.FieldByName('GER_RETFIL').AsString := 'S';
        qryRomGerX.FieldByName('GER_CODFIL').AsString := strCodFil;
      End;

      qryRomGerX.FieldByName('GER_SEQTRA').AsString   := strSeqTra;

      qryRomGerX.FieldByName('GER_ALTEND').AsString   := strAltEnd;

      qryRomGerX.FieldByName('GER_LATLON').AsString   := strLatLon;

      qryRomGerX.FieldByName('GER_PRIORI').AsInteger  := intPriori;

      qryRomGerX.FieldByName('GER_INTFUS').AsString   := strIntFus;

      if (fEmptyStr(strRomFus)) then
        qryRomGerX.FieldByName('GER_ROMFUS').Value := Null
      else
        qryRomGerX.FieldByName('GER_ROMFUS').AsString   := strRomFus;

      if (dtaDtaIni > 0) then
        qryRomGerX.FieldByName('GER_DTAINI').AsDateTime := dtaDtaIni
      else
        qryRomGerX.FieldByName('GER_DTAINI').Value := Null;

      if (hraHorIni > 0) then
        qryRomGerX.FieldByName('GER_HORINI').AsDateTime := hraHorIni
      else
        qryRomGerX.FieldByName('GER_HORINI').Value := Null;

      qryRomGerX.FieldByName('GER_DEFCON').AsString   := strDefCon;

      qryRomGerX.Post;

      pGravaAuxRomx(strAutInc, strMsgExp, strMenExp, strMenEx2, strMenEx3, strMenEx4);

      fGravaROMCND(strAutInc, arrDuplic);

      Result := True;
    Except
      On E: Exception Do
      Begin
        qryRomGerX.Cancel;
{$IFNDEF FUSION}
        Result := False;
        pMensagensErro(E.Message, '[fGravaRomGer]');
{$ELSE }
        raise;
{$ENDIF FUSION}
      End;
    End;
  finally
{$IFNDEF LINUX}
    if (not Assigned(qryRomGerX_)) then
      FreeAndNil(qryRomGerX);
{$ENDIF LINUX}
  end;
End;

function fGravaRomDet(strNumRom: String;
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
                      fltTotIte,
                      fltVlrCon,
                      fltTotCus,
                      fltTotMed,
                      fltDesCon,
                      fltTotFre,
                      fltDesEsp: Double;
                      strCodRep: String;
                      fltPerCom,
                      fltTotCom: Double;
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
                      strNumFat: String;
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
                      strCodFpg: String;
                      fltQtdBai: Double;
                      strInfIte,
                      strSepImp,
                      strAutInc,
                      strNumLot: String;
                      fltPesLiq: Double;
                      fltVolume: Double;
                      fltValCbs: Double;
                      fltValIbs: Double;
                      fltVal_Is: Double;
                      strEmpOri: String = '';
                      qryRomDetX_: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX} = Nil;
                      objInsertsInBatch : TInsertsInBatchROMDETX = Nil;
                      strAutIncRomDetX  : String = ''): Boolean;
var
  strAutIncArq: String;
  qryRomDetX: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  strValuesRomDet : String;
Begin
  Result := True;

  If fGravacaoEmLote And Assigned(objInsertsInBatch) Then
  Begin
    strValuesRomDet := fRetValuesRomDet(strNumRom,
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
                                        fltTotIte,
                                        fltVlrCon,
                                        fltTotCus,
                                        fltTotMed,
                                        fltDesCon,
                                        fltTotFre,
                                        fltDesEsp,
                                        strCodRep,
                                        fltPerCom,
                                        fltTotCom,
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
                                        fltQtdBai,
                                        strInfIte,
                                        strSepImp,
                                        strAutInc,
                                        strNumLot,
                                        fltPesLiq,
                                        fltVolume,
                                        fltValCbs,
                                        fltValIbs,
                                        fltVal_Is,
                                        strEmpOri,
                                        strAutIncRomDetX);

    objInsertsInBatch.AddCommand(strValuesRomDet);
    Exit;
  End;

  if (Assigned(qryRomDetX_)) then
    qryRomDetX := qryRomDetX_
  else
  begin
    qryRomDetX := fCriarQuery('SELECT * FROM ROMDETX WHERE FALSE');
    qryRomDetX.Open;
  end;

  try
    Try
      If Not strAutIncRomDetX.IsEmpty Then
        strAutIncArq := strAutIncRomDetX
      Else
        strAutIncArq := fRetAutoIncrem('ROMDETX', strCodEmp);

      qryRomDetX.Append;
      qryRomDetX.FieldByName('DET_NUMROM').AsString   := strNumRom;
      qryRomDetX.FieldByName('DET_SEQGER').AsString   := strSeqGer;
      qryRomDetX.FieldByName('DET_NUMDOC').AsString   := strNumDoc;
      qryRomDetX.FieldByName('DET_ESPDOC').AsString   := strEspDoc;
      qryRomDetX.FieldByName('DET_CODEMP').AsString   := strCodEmp;
      qryRomDetX.FieldByName('DET_CODITE').AsString   := strCodIte;

      If fEmptyStr(strCodVen) Then
        qryRomDetX.FieldByName('DET_CODVEN').Value      := Null
      Else
        qryRomDetX.FieldByName('DET_CODVEN').AsString   := strCodVen;

      If fEmptyStr(strCodDiv) Then
        qryRomDetX.FieldByName('DET_CODDIV').Value      := Null
      Else
        qryRomDetX.FieldByName('DET_CODDIV').AsString   := strCodDiv;

      If fEmptyStr(strCodMar) Then
        qryRomDetX.FieldByName('DET_CODMAR').Value      := Null
      Else
        qryRomDetX.FieldByName('DET_CODMAR').AsString   := strCodMar;

      If fEmptyStr(strCodFor) Then
        qryRomDetX.FieldByName('DET_CODFOR').Value      := Null
      Else
        qryRomDetX.FieldByName('DET_CODFOR').AsString   := strCodFor;

      If fEmptyStr(strCodCli) Then
        qryRomDetX.FieldByName('DET_CODCLI').Value      := Null
      Else
        qryRomDetX.FieldByName('DET_CODCLI').AsString   := strCodCli;

      qryRomDetX.FieldByName('DET_DTAENT').AsDateTime := dtaDtaEnt;
      qryRomDetX.FieldByName('DET_HORENT').AsDateTime := dtaHorEnt;
      qryRomDetX.FieldByName('DET_DTADOC').AsDateTime := dtaDtaDoc;
      qryRomDetX.FieldByName('DET_CONPAG').AsString   := fTiraCaracEspeciais(strConPag);
      qryRomDetX.FieldByName('DET_TIP_FC').AsString   := strTip_Fc;
      qryRomDetX.FieldByName('DET_ESTADO').AsString   := strEstado;
      qryRomDetX.FieldByName('DET_DESCRI').AsString   := strDescri;
      qryRomDetX.FieldByName('DET_REFERE').AsString   := strRefere;
      qryRomDetX.FieldByName('DET_UNIDAD').AsString   := strUnidad;

      If fEmptyStr(strForIte) Then
        qryRomDetX.FieldByName('DET_FORITE').Value := Null
      Else
        qryRomDetX.FieldByName('DET_FORITE').AsString := strForIte;

      qryRomDetX.FieldByName('DET_QTDITE').AsFloat    := fltQtdIte;
      qryRomDetX.FieldByName('DET_UNITAR').AsFloat    := fltUnitar;
      qryRomDetX.FieldByName('DET_UNIORI').AsFloat    := fltUniOri;
      qryRomDetX.FieldByName('DET_TOTITE').AsFloat    := fltTotIte;
      qryRomDetX.FieldByName('DET_VLRCON').AsFloat    := fltVlrCon;
      qryRomDetX.FieldByName('DET_TOTCUS').AsFloat    := fltTotCus;
      qryRomDetX.FieldByName('DET_TOTMED').AsFloat    := fltTotMed;
      qryRomDetX.FieldByName('DET_DESCON').AsFloat    := fltDesCon;
      qryRomDetX.FieldByName('DET_TOTFRE').AsFloat    := fltTotFre;
      qryRomDetX.FieldByName('DET_DESESP').AsFloat    := fltDesEsp;

      If (fEmptyStr(strCodRep)) Then
        qryRomDetX.FieldByName('DET_CODREP').Value := Null
      Else
        qryRomDetX.FieldByName('DET_CODREP').AsString := strCodRep;

      qryRomDetX.FieldByName('DET_PERCOM').AsFloat    := fltPerCom;
      qryRomDetX.FieldByName('DET_TOTCOM').AsFloat    := fltTotCom;
      qryRomDetX.FieldByName('DET_CLAFIS').AsString   := strClaFis;
      qryRomDetX.FieldByName('DET_CODFIS').AsString   := strCodFis;
      qryRomDetX.FieldByName('DET_VALIPI').AsFloat    := fltValIpi;
      qryRomDetX.FieldByName('DET_ALQIPI').AsFloat    := fltAlqIpi;
      qryRomDetX.FieldByName('DET_BASIPI').AsFloat    := fltBasIpi;
      qryRomDetX.FieldByName('DET_VALICM').AsFloat    := fltValIcm;
      qryRomDetX.FieldByName('DET_ALQICM').AsFloat    := fltAlqIcm;
      qryRomDetX.FieldByName('DET_BASICM').AsFloat    := fltBasIcm;
      qryRomDetX.FieldByName('DET_VALRET').AsFloat    := fltValRet;
      qryRomDetX.FieldByName('DET_ALQRET').AsFloat    := fltAlqRet;
      qryRomDetX.FieldByName('DET_BASRET').AsFloat    := fltBasRet;
      qryRomDetX.FieldByName('DET_TOTPES').AsFloat    := fltTotPes;
      qryRomDetX.FieldByName('DET_PERBAS').AsFloat    := fltPerBas;
      qryRomDetX.FieldByName('DET_PERRED').AsFloat    := fltPerRed;

      If qryRomDetX.FieldByName('DET_JAFATU').DataType = ftInteger Then
        qryRomDetX.FieldByName('DET_JAFATU').AsInteger  := IIF(blnJaFatu, 1, 0)
      else
        qryRomDetX.FieldByName('DET_JAFATU').AsBoolean  := IIF(blnJaFatu, True, False);

      qryRomDetX.FieldByName('DET_TIPFAT').AsString   := strTipFat;
      qryRomDetX.FieldByName('DET_NUMFAT').AsString   := strNumFat;

      If (dtaDtaFat = 0) Then
        qryRomDetX.FieldByName('DET_DTAFAT').Value      := Null
      Else
        qryRomDetX.FieldByName('DET_DTAFAT').AsDateTime := dtaDtaFat;

      If Not fEmptyStr(strVenFat) Then
        qryRomDetX.FieldByName('DET_VENFAT').AsString := strVenFat
      Else
        qryRomDetX.FieldByName('DET_VENFAT').Value := Null;

      qryRomDetX.FieldByName('DET_CNDFAT').AsString   := strCndFat;
      qryRomDetX.FieldByName('DET_VALFAT').AsFloat    := fltValFat;
      qryRomDetX.FieldByName('DET_IDEPRO').AsString   := strIdePro;
      qryRomDetX.FieldByName('DET_INCPIS').AsString   := strIncPis;
      qryRomDetX.FieldByName('DET_SERIE_').AsString   := strSerie;
      qryRomDetX.FieldByName('DET_DESACE').AsFloat    := fltDesAce;
      qryRomDetX.FieldByName('DET_NOTESP').AsString   := strNotEsp;

      If (fEmptyStr(strDocDev)) Then
        qryRomDetX.FieldByName('DET_DOCDEV').Value    := Null
      Else
        qryRomDetX.FieldByName('DET_DOCDEV').AsString := strDocDev;

      If (fEmptyStr(strEspDev)) Then
        qryRomDetX.FieldByName('DET_ESPDEV').Value    := Null
      Else
        qryRomDetX.FieldByName('DET_ESPDEV').AsString := strEspDev;

      If (fEmptyStr(strEmpDev)) Then
        qryRomDetX.FieldByName('DET_EMPDEV').Value    := Null
      Else
        qryRomDetX.FieldByName('DET_EMPDEV').AsString := strEmpDev;

      If (fEmptyStr(strIteCha)) Then
        qryRomDetX.FieldByName('DET_ITECHA').Value := Null
      Else
        qryRomDetX.FieldByName('DET_ITECHA').AsString  := strIteCha;

      qryRomDetX.FieldByName('DET_ITETIN').AsString   := strIteTin;
      qryRomDetX.FieldByName('DET_DESCOR').AsString   := strDesCor;

      qryRomDetX.FieldByName('DET_TIPEMB').AsString   := strTipEmb;
      qryRomDetX.FieldByName('DET_QTDEMB').AsFloat    := fltQtdEmb;
      qryRomDetX.FieldByName('DET_PREEMB').AsFloat    := fltPreEmb;
      qryRomDetX.FieldByName('DET_TIPPRE').AsString   := strTipPre;
      qryRomDetX.FieldByName('DET_PRVTIN').AsFloat    := fltPrvTin;
      qryRomDetX.FieldByName('DET_PRCTIN').AsFloat    := fltPrcTin;
      qryRomDetX.FieldByName('DET_FATTIN').AsFloat    := fltFatTin;
      qryRomDetX.FieldByName('DET_PROEMB').AsString   := strProEmb;

      If (fEmptyStr(strCodDig)) Then
        qryRomDetX.FieldByName('DET_CODDIG').Value := Null
      Else
        qryRomDetX.FieldByName('DET_CODDIG').AsString   := strCodDig;

      If (fEmptyStr(strCodCnd)) Then
        qryRomDetX.FieldByName('DET_CODCND').Value := Null
      Else
        qryRomDetX.FieldByName('DET_CODCND').AsString   := strCodCnd;

      If (fEmptyStr(strCodFpg)) Then
        qryRomDetX.FieldByName('DET_CODFPG').Value := Null
      Else
        qryRomDetX.FieldByName('DET_CODFPG').AsString   := strCodFpg;

      qryRomDetX.FieldByName('DET_QTDBAI').AsFloat  := fltQtdBai;

      qryRomDetX.FieldByName('DET_INFITE').AsString   := strInfIte;
      qryRomDetX.FieldByName('DET_SEPIMP').AsString   := strSepImp;

      qryRomDetX.FieldByName('AUTOINCREM').AsString := strAutIncArq;
      {*******************************************}
      {* AUTO INCREMENTO DO VINDO DO MOVDET      *}
      {****************************************MV*}
      qryRomDetX.FieldByName('DET_AUTINC').AsString := strAutInc;
      qryRomDetX.FieldByName('DET_EMPROM').AsString := VS_strCodEmp;

      qryRomDetX.FieldByName('DET_NUMLOT').AsString := strNumLot;
      qryRomDetX.FieldByName('DET_PESLIQ').AsFloat  := fltPesLiq;
      qryRomDetX.FieldByName('DET_VOLUME').AsFloat  := fltVolume;
      qryRomDetX.FieldByName('DET_EMPORI').AsString := strEmpOri;

      qryRomDetX.FieldByName('DET_QTDROM').AsFloat  := IIF(fltQtdBai = 0, fltQtdIte, fltQtdBai);

      qryRomDetX.FieldByName('DET_VALCBS').AsFloat  := fltValCbs;
      qryRomDetX.FieldByName('DET_VALIBS').AsFloat  := fltValIbs;
      qryRomDetX.FieldByName('DET_VAL_IS').AsFloat  := fltVal_Is;

      qryRomDetX.Post;
    Except
      On E: Exception Do
      Begin
        qryRomDetX.Cancel;
{$IFNDEF FUSION}
        Result := False;
        pMensagensErro(E.Message, '[fGravaRomDetX]');
{$ELSE }
        raise;
{$ENDIF FUSION}
      End;
    End;
  finally
{$IFNDEF LINUX}
    if (not Assigned(qryRomDetX_)) then
      FreeAndNil(qryRomDetX);
{$ENDIF LINUX}
  end;
End;

function fGravaRomTra(ASeqGer, AEmpDes: String; AInsertsInBatch: TInsertsInBatchROMTRAX = nil): Boolean;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  Result := True;

  If fGravacaoEmLote And Assigned(AInsertsInBatch) Then
  Begin
    AInsertsInBatch.AddCommand('(' + QuotedStr(fRetAutoIncrem('ROMTRAX', VS_strCodEmp)) + ', ' +
                                     QuotedStr(ASeqGer) + ', ' +
                                     QuotedStr(FormatDateTime('YYYY-MM-DD', fNow)) + ', ' +
                                     QuotedStr(FormatDateTime('YYYY-MM-DD hh:mm:ss', fNow)) + ', ' +
                                     QuotedStr(VS_strCodEmp) + ', ' +
                                     QuotedStr(AEmpDes) + ')');
    Exit;
  End;

  LQry := fCriaQuery;

  try
    try
      LQry.SQL.Text := 'SELECT * FROM ROMTRAX WHERE FALSE';
      LQry.Open;

      LQry.Append;
      LQry.FieldByName('AUTOINCREM').AsString   := fRetAutoIncrem('ROMTRAX', VS_strCodEmp);
      LQry.FieldByName('TRA_SEQGER').AsString   := ASeqGer;
      LQry.FieldByName('TRA_DTATRA').AsDateTime := fNow;
      LQry.FieldByName('TRA_HRATRA').AsDateTime := fTime;
      LQry.FieldByName('TRA_EMPORI').AsString   := VS_strCodEmp;
      LQry.FieldByName('TRA_EMPDES').AsString   := AEmpDes;

      LQry.Post;
    except
      on e: Exception do
      begin
        Result := False;
{$IFNDEF FUSION}
        pMensagensErro(E.Message, '[fGravaRomTra]');
{$ELSE }
        raise;
{$ENDIF FUSION}
      end;
    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

procedure fAddValue(var ACommand: String;
                   AValue      : Variant;
                   AFieldType  : TFieldType;
                   AUltimo     : Boolean = False);
var
  LValue: String;
begin
  case AFieldType of
    ftDate:
      begin
        if (FormatDateTime('YYYY-MM-DD', AValue) = '1899-12-30') or
           (FormatDateTime('YYYY-MM-DD', AValue) = '0000-00-00') then
          LValue:= 'NULL'
        else
          LValue := QuotedStr(FormatDateTime('YYYY-MM-DD', AValue));
      end;

    ftDateTime:
      begin
        if (FormatDateTime('YYYY-MM-DD hh:mm:ss', AValue) = '1899-12-30 00:00:00') or
           (FormatDateTime('YYYY-MM-DD hh:mm:ss', AValue) = '0000-00-00 00:00:00') then
          LValue := 'NULL'
        else
          LValue := QuotedStr(FormatDateTime('YYYY-MM-DD hh:mm:ss', AValue));
      end;

    ftFloat   : LValue := ReplaceStr(AValue, ',', '.');
    ftInteger : LValue := AValue;
    ftString  : LValue := IIF(fEmptyStr(AValue), 'NULL', fRemoveCaracterNulo(QuotedStr(fRemoveBarraInvertidaFinalDaLinha(AValue))));
    ftVariant : LValue := IIF(VarIsNull(AValue), 'NULL', QuotedStr(AValue));
  End;

  ACommand := ACommand + LValue + IIF(AUltimo, '', ', ');
End;

function fRetValuesRomGer(strNumRom,
                          strAutInc,
                          strNumDoc,
                          strSerie,
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
                          strTelCon,
                          strCgcCpf,
                          strCgcCon,
                          strIesCon,
                          strCli_Rg,
                          strEndEnt,
                          strBaiEnt,
                          strCepEnt,
                          strCidEnt,
                          strRefEnt: String;
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
                          fltPesBru,
                          fltPesLiq,
                          fltVolume: Double;
                          strEspeci,
                          strMarca,
                          strMen001,
                          strMen002: String;
                          intJafatu: Integer;
                          strTipFat,
                          strNumFat: String;
                          dtaDtaFat: TDateTime;
                          strVenFat,
                          strCndFat: String;
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
                          strNotEsp,
                          strClaFis: String;
                          fltPorDes: Double;
                          strCodDig,
                          strCodCnd,
                          strCodFpg,
                          strCodMot,
                          strCodAj1,
                          strCodAj2,
                          strCodAj3,
                          strCodAj4,
                          strObsFec,
                          strPlaVei,
                          strCodReg: String;
                          dtaDtaRom,
                          dtaHorRom: TDateTime;
                          strOpeRom: String;
                          fltVlrOri: Double;
                          strRomImp: String;
                          intOrdImp: Integer;
                          strLocali,
                          strLibApp,
                          strEvitar: String;
                          fltDistan,
                          fltTmpEnt: Double;
                          strFilial,
                          strIniPar,
                          strFstSht,
                          strFinRot,
                          strOpeSol,
                          strEmpRom,
                          strAutEnt,
                          strNumBox: String;
                          fltFrete_,
                          fltAdiFre,
                          fltPerFre: Double;
                          strPalet,
                          strStatus,
                          strCodBar,
                          strNomTab,
                          strEntSai,
                          strAutIncGer,
                          strRetFil,
                          strCodFil,
                          strSeqTra,
                          strAltEnd,
                          strLatLon: String;
                          intPriori: Integer;
                          strIntFus,
                          strRomFus: String;
                          dtaDtaIni,
                          hraHorIni: TDateTime;
                          strDefCon: String): String;
var
  LCommand : String;
begin
  strConPag  := fTiraCaracEspeciais(strConPag);

  LCommand := '(';

  fAddValue(LCommand, strNumRom, ftString);
  fAddValue(LCommand, strAutInc, ftString);
  fAddValue(LCommand, strNumDoc, ftString);
  fAddValue(LCommand, strSerie,  ftVariant);
  fAddValue(LCommand, strEspDoc, ftString);
  fAddValue(LCommand, strCodEmp, ftString);
  fAddValue(LCommand, strCodTra, ftString);
  fAddValue(LCommand, strCodVen, ftString);
  fAddValue(LCommand, strCodFor, ftString);
  fAddValue(LCommand, strCodCli, ftString);
  fAddValue(LCommand, strTip_Fc, ftString);
  fAddValue(LCommand, dtaDtaEnt, ftDateTime);
  fAddValue(LCommand, tmrHorEnt, ftDateTime);
  fAddValue(LCommand, dtaDtaDoc, ftDateTime);
  fAddValue(LCommand, strConPag, ftString);
  fAddValue(LCommand, strEstado, ftString);
  fAddValue(LCommand, strNomCon, ftString);
  fAddValue(LCommand, strEndCon, ftString);
  fAddValue(LCommand, strBaiCon, ftString);
  fAddValue(LCommand, strCepCon, ftString);
  fAddValue(LCommand, strCidCon, ftString);
  fAddValue(LCommand, strEstCon, ftString);
  fAddValue(LCommand, strTelCon, ftString);
  fAddValue(LCommand, strCgcCpf, ftString);
  fAddValue(LCommand, strCgcCon, ftString);
  fAddValue(LCommand, strIesCon, ftString);
  fAddValue(LCommand, strCli_Rg, ftString);
  fAddValue(LCommand, strEndEnt, ftString);
  fAddValue(LCommand, strBaiEnt, ftString);
  fAddValue(LCommand, strCepEnt, ftString);
  fAddValue(LCommand, strCidEnt, ftString);
  fAddValue(LCommand, strRefEnt, ftString);
  fAddValue(LCommand, fltBasSim, ftFloat);
  fAddValue(LCommand, fltBasIpi, ftFloat);
  fAddValue(LCommand, fltAlqIpi, ftFloat);
  fAddValue(LCommand, fltTotIpi, ftFloat);
  fAddValue(LCommand, fltBasIcm, ftFloat);
  fAddValue(LCommand, fltAlqIcm, ftFloat);
  fAddValue(LCommand, fltTotIcm, ftFloat);
  fAddValue(LCommand, fltTotRet, ftFloat);
  fAddValue(LCommand, fltAlqRet, ftFloat);
  fAddValue(LCommand, fltBasRet, ftFloat);
  fAddValue(LCommand, fltDesEsp, ftFloat);
  fAddValue(LCommand, fltVlrCon, ftFloat);
  fAddValue(LCommand, fltTotPro, ftFloat);
  fAddValue(LCommand, fltTotCus, ftFloat);
  fAddValue(LCommand, fltTotMed, ftFloat);
  fAddValue(LCommand, strTipFre, ftString);
  fAddValue(LCommand, fltTotFre, ftFloat);
  fAddValue(LCommand, fltPesBru, ftFloat);
  fAddValue(LCommand, fltPesLiq, ftFloat);
  fAddValue(LCommand, fltVolume, ftFloat);
  fAddValue(LCommand, strEspeci, ftString);
  fAddValue(LCommand, strMarca,  ftString);
  fAddValue(LCommand, strMen001, ftString);
  fAddValue(LCommand, strMen002, ftString);
  fAddValue(LCommand, intJafatu, ftInteger);
  fAddValue(LCommand, strTipFat, ftString);
  fAddValue(LCommand, strNumFat, ftString);
  fAddValue(LCommand, dtaDtaFat, ftDateTime);
  fAddValue(LCommand, strVenFat, ftString);
  fAddValue(LCommand, strCndFat, ftString);
  fAddValue(LCommand, fltValFat, ftFloat);
  fAddValue(LCommand, fltVPar01, ftFloat);
  fAddValue(LCommand, fltVPar02, ftFloat);
  fAddValue(LCommand, fltVPar03, ftFloat);
  fAddValue(LCommand, fltVPar04, ftFloat);
  fAddValue(LCommand, fltVPar05, ftFloat);
  fAddValue(LCommand, fltVPar06, ftFloat);
  fAddValue(LCommand, fltVPar07, ftFloat);
  fAddValue(LCommand, fltVPar08, ftFloat);
  fAddValue(LCommand, fltVPar09, ftFloat);
  fAddValue(LCommand, fltVPar10, ftFloat);
  fAddValue(LCommand, fltVPar11, ftFloat);
  fAddValue(LCommand, fltVPar12, ftFloat);
  fAddValue(LCommand, strNotEsp, ftString);
  fAddValue(LCommand, strClaFis, ftString);
  fAddValue(LCommand, fltPorDes, ftFloat);
  fAddValue(LCommand, strCodDig, ftString);
  fAddValue(LCommand, strCodCnd, ftString);
  fAddValue(LCommand, strCodFpg, ftString);
  fAddValue(LCommand, strCodMot, ftString);
  fAddValue(LCommand, strCodAj1, ftString);
  fAddValue(LCommand, strCodAj2, ftString);
  fAddValue(LCommand, strCodAj3, ftString);
  fAddValue(LCommand, strCodAj4, ftString);
  fAddValue(LCommand, strObsFec, ftString);
  fAddValue(LCommand, strPlaVei, ftString);
  fAddValue(LCommand, strCodReg, ftString);
  fAddValue(LCommand, dtaDtaRom, ftDateTime);
  fAddValue(LCommand, dtaHorRom, ftDateTime);
  fAddValue(LCommand, strOpeRom, ftString);
  fAddValue(LCommand, fltVlrOri, ftFloat);
  fAddValue(LCommand, strRomImp, ftString);
  fAddValue(LCommand, intOrdImp, ftInteger);
  fAddValue(LCommand, strLocali, ftString);
  fAddValue(LCommand, strLibApp, ftString);
  fAddValue(LCommand, strEvitar, ftString);
  fAddValue(LCommand, fltDistan, ftFloat);
  fAddValue(LCommand, fltTmpEnt, ftFloat);
  fAddValue(LCommand, strFilial, ftString);
  fAddValue(LCommand, strIniPar, ftString);
  fAddValue(LCommand, strFstSht, ftString);
  fAddValue(LCommand, strFinRot, ftString);
  fAddValue(LCommand, strOpeSol, ftString);
  fAddValue(LCommand, strEmpRom, ftString);
  fAddValue(LCommand, strAutEnt, ftString);
  fAddValue(LCommand, strNumBox, ftString);
  fAddValue(LCommand, fltFrete_, ftFloat);
  fAddValue(LCommand, fltAdiFre, ftFloat);
  fAddValue(LCommand, fltPerFre, ftFloat);
  fAddValue(LCommand, strPalet,  ftString);
  fAddValue(LCommand, strStatus, ftString);
  fAddValue(LCommand, strCodBar, ftString);
  fAddValue(LCommand, strNomTab, ftString);
  fAddValue(LCommand, strEntSai, ftString);
  fAddValue(LCommand, strAutIncGer, ftString);
  fAddValue(LCommand, strRetFil, ftString);
  fAddValue(LCommand, strCodFil, ftString);
  fAddValue(LCommand, strSeqTra, ftString);
  fAddValue(LCommand, strAltEnd, ftString);
  fAddValue(LCommand, strLatLon, ftString);
  fAddValue(LCommand, intPriori, ftInteger);
  fAddValue(LCommand, strIntFus, ftString);
  fAddValue(LCommand, strRomFus, ftString);
  fAddValue(LCommand, dtaDtaIni, ftDateTime);
  fAddValue(LCommand, hraHorIni, ftDateTime);
  fAddValue(LCommand, strDefCon, ftString, True);

  LCommand := LCommand + ')';

  Result := LCommand;
end;

function fRetValuesRomDet(strNumRom: String;
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
                          fltTotIte,
                          fltVlrCon,
                          fltTotCus,
                          fltTotMed,
                          fltDesCon,
                          fltTotFre,
                          fltDesEsp: Double;
                          strCodRep: String;
                          fltPerCom,
                          fltTotCom: Double;
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
                          strNumFat: String;
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
                          strCodFpg: String;
                          fltQtdBai: Double;
                          strInfIte,
                          strSepImp,
                          strAutInc,
                          strNumLot: String;
                          fltPesLiq: Double;
                          fltVolume: Double;
                          fltValCbs: Double;
                          fltValIbs: Double;
                          fltVal_Is: Double;
                          strEmpOri: String = '';
                          strAutIncRomDetX : String = '') : String;
var
  LCommand   : String;
  LAutIncArq : String;
Begin
  LAutIncArq := strAutIncRomDetX;
  strConPag  := fTiraCaracEspeciais(strConPag);

  LCommand := '(';

  fAddValue(LCommand, strNumRom, ftString);	                                   //LCommand := LCommand + 'DET_NUMROM, ';
  fAddValue(LCommand, strSeqGer, ftString);	                                   //LCommand := LCommand + 'DET_SEQGER, ';
  fAddValue(LCommand, strNumDoc, ftString);	                                   //LCommand := LCommand + 'DET_NUMDOC, ';
  fAddValue(LCommand, strEspDoc, ftString);	                                   //LCommand := LCommand + 'DET_ESPDOC, ';
  fAddValue(LCommand, strCodEmp, ftString);	                                   //LCommand := LCommand + 'DET_CODEMP, ';
  fAddValue(LCommand, strCodIte, ftString);	                                   //LCommand := LCommand + 'DET_CODITE, ';
  fAddValue(LCommand, strCodVen, ftString);	                                   //LCommand := LCommand + 'DET_CODVEN, ';
  fAddValue(LCommand, strCodDiv, ftString);	                                   //LCommand := LCommand + 'DET_CODDIV, ';
  fAddValue(LCommand, strCodMar, ftString);	                                   //LCommand := LCommand + 'DET_CODMAR, ';
  fAddValue(LCommand, strCodFor, ftString);	                                   //LCommand := LCommand + 'DET_CODFOR, ';
  fAddValue(LCommand, strCodCli, ftString);	                                   //LCommand := LCommand + 'DET_CODCLI, ';
  fAddValue(LCommand, dtaDtaEnt, ftDateTime);                                   //LCommand := LCommand + 'DET_DTAENT, ';
  fAddValue(LCommand, dtaHorEnt, ftDateTime);                                   //LCommand := LCommand + 'DET_HORENT, ';
  fAddValue(LCommand, dtaDtaDoc, ftDateTime);                                   //LCommand := LCommand + 'DET_DTADOC, ';
  fAddValue(LCommand, strConPag, ftString);	                                   //LCommand := LCommand + 'DET_CONPAG, ';
  fAddValue(LCommand, strTip_Fc, ftString);	                                   //LCommand := LCommand + 'DET_TIP_FC, ';
  fAddValue(LCommand, strEstado, ftString);	                                   //LCommand := LCommand + 'DET_ESTADO, ';
  fAddValue(LCommand, strDescri, ftString);	                                   //LCommand := LCommand + 'DET_DESCRI, ';
  fAddValue(LCommand, strRefere, ftString);	                                   //LCommand := LCommand + 'DET_REFERE, ';
  fAddValue(LCommand, strUnidad, ftString);	                                   //LCommand := LCommand + 'DET_UNIDAD, ';
  fAddValue(LCommand, strForIte, ftString);	                                   //LCommand := LCommand + 'DET_FORITE, ';
  fAddValue(LCommand, fltQtdIte, ftFloat);	                                     //LCommand := LCommand + 'DET_QTDITE, ';
  fAddValue(LCommand, fltUnitar, ftFloat);	                                     //LCommand := LCommand + 'DET_UNITAR, ';
  fAddValue(LCommand, fltUniOri, ftFloat);	                                     //LCommand := LCommand + 'DET_UNIORI, ';
  fAddValue(LCommand, fltTotIte, ftFloat);	                                     //LCommand := LCommand + 'DET_TOTITE, ';
  fAddValue(LCommand, fltVlrCon, ftFloat);	                                     //LCommand := LCommand + 'DET_VLRCON, ';
  fAddValue(LCommand, fltTotCus, ftFloat);	                                     //LCommand := LCommand + 'DET_TOTCUS, ';
  fAddValue(LCommand, fltTotMed, ftFloat);	                                     //LCommand := LCommand + 'DET_TOTMED, ';
  fAddValue(LCommand, fltDesCon, ftFloat);	                                     //LCommand := LCommand + 'DET_DESCON, ';
  fAddValue(LCommand, fltTotFre, ftFloat);	                                     //LCommand := LCommand + 'DET_TOTFRE, ';
  fAddValue(LCommand, fltDesEsp, ftFloat);	                                     //LCommand := LCommand + 'DET_DESESP, ';
  fAddValue(LCommand, strCodRep, ftString);	                                   //LCommand := LCommand + 'DET_CODREP, ';
  fAddValue(LCommand, fltPerCom, ftFloat);	                                     //LCommand := LCommand + 'DET_PERCOM, ';
  fAddValue(LCommand, fltTotCom, ftFloat);	                                     //LCommand := LCommand + 'DET_TOTCOM, ';
  fAddValue(LCommand, strClaFis, ftString);	                                   //LCommand := LCommand + 'DET_CLAFIS, ';
  fAddValue(LCommand, strCodFis, ftString);	                                   //LCommand := LCommand + 'DET_CODFIS, ';
  fAddValue(LCommand, fltValIpi, ftFloat);	                                     //LCommand := LCommand + 'DET_VALIPI, ';
  fAddValue(LCommand, fltAlqIpi, ftFloat);	                                     //LCommand := LCommand + 'DET_ALQIPI, ';
  fAddValue(LCommand, fltBasIpi, ftFloat);	                                     //LCommand := LCommand + 'DET_BASIPI, ';
  fAddValue(LCommand, fltValIcm, ftFloat);	                                     //LCommand := LCommand + 'DET_VALICM, ';
  fAddValue(LCommand, fltAlqIcm, ftFloat);	                                     //LCommand := LCommand + 'DET_ALQICM, ';
  fAddValue(LCommand, fltBasIcm, ftFloat);	                                     //LCommand := LCommand + 'DET_BASICM, ';
  fAddValue(LCommand, fltValRet, ftFloat);	                                     //LCommand := LCommand + 'DET_VALRET, ';
  fAddValue(LCommand, fltAlqRet, ftFloat);	                                     //LCommand := LCommand + 'DET_ALQRET, ';
  fAddValue(LCommand, fltBasRet, ftFloat);	                                     //LCommand := LCommand + 'DET_BASRET, ';
  fAddValue(LCommand, fltTotPes, ftFloat);	                                     //LCommand := LCommand + 'DET_TOTPES, ';
  fAddValue(LCommand, fltPerBas, ftFloat);	                                     //LCommand := LCommand + 'DET_PERBAS, ';
  fAddValue(LCommand, fltPerRed, ftFloat);	                                     //LCommand := LCommand + 'DET_PERRED, ';
  fAddValue(LCommand, IIF(blnJaFatu, 1, 0), ftInteger);	                       //LCommand := LCommand + 'DET_JAFATU, ';
  fAddValue(LCommand, strTipFat, ftString);	                                   //LCommand := LCommand + 'DET_TIPFAT, ';
  fAddValue(LCommand, strNumFat, ftString);	                                   //LCommand := LCommand + 'DET_NUMFAT, ';
  fAddValue(LCommand, dtaDtaFat, ftDateTime);	                                 //LCommand := LCommand + 'DET_DTAFAT, ';
  fAddValue(LCommand, strVenFat, ftString);	                                   //LCommand := LCommand + 'DET_VENFAT, ';
  fAddValue(LCommand, strCndFat, ftString);	                                   //LCommand := LCommand + 'DET_CNDFAT, ';
  fAddValue(LCommand, fltValFat, ftFloat);	                                     //LCommand := LCommand + 'DET_VALFAT, ';
  fAddValue(LCommand, strIdePro, ftString);	                                   //LCommand := LCommand + 'DET_IDEPRO, ';
  fAddValue(LCommand, strIncPis, ftString);	                                   //LCommand := LCommand + 'DET_INCPIS, ';
  fAddValue(LCommand, strSerie,  ftVariant);	                                   //LCommand := LCommand + 'DET_SERIE_, ';
  fAddValue(LCommand, fltDesAce, ftFloat);	                                     //LCommand := LCommand + 'DET_DESACE, ';
  fAddValue(LCommand, strNotEsp, ftString);	                                   //LCommand := LCommand + 'DET_NOTESP, ';
  fAddValue(LCommand, strDocDev, ftString);                                     //LCommand := LCommand + 'DET_DOCDEV, ';
  fAddValue(LCommand, strEspDev, ftString);                                     //LCommand := LCommand + 'DET_ESPDEV, ';
  fAddValue(LCommand, strEmpDev, ftString);                                     //LCommand := LCommand + 'DET_EMPDEV, ';
  fAddValue(LCommand, strIteCha, ftString);                                     //LCommand := LCommand + 'DET_ITECHA, ';
  fAddValue(LCommand, strIteTin, ftString);                                     //LCommand := LCommand + 'DET_ITETIN, ';
  fAddValue(LCommand, strDesCor, ftString);                                     //LCommand := LCommand + 'DET_DESCOR, ';
  fAddValue(LCommand, strTipEmb, ftString);                                     //LCommand := LCommand + 'DET_TIPEMB, ';
  fAddValue(LCommand, fltQtdEmb, ftFloat);                                      //LCommand := LCommand + 'DET_QTDEMB, ';
  fAddValue(LCommand, fltPreEmb, ftFloat);                                      //LCommand := LCommand + 'DET_PREEMB, ';
  fAddValue(LCommand, strTipPre, ftString);                                     //LCommand := LCommand + 'DET_TIPPRE, ';
  fAddValue(LCommand, fltPrvTin, ftFloat);                                      //LCommand := LCommand + 'DET_PRVTIN, ';
  fAddValue(LCommand, fltPrcTin, ftFloat);                                      //LCommand := LCommand + 'DET_PRCTIN, ';
  fAddValue(LCommand, fltFatTin, ftFloat);                                      //LCommand := LCommand + 'DET_FATTIN, ';
  fAddValue(LCommand, strProEmb, ftString);                                     //LCommand := LCommand + 'DET_PROEMB, ';
  fAddValue(LCommand, strCodDig, ftString);                                     //LCommand := LCommand + 'DET_CODDIG, ';
  fAddValue(LCommand, strCodCnd, ftString);                                     //LCommand := LCommand + 'DET_CODCND, ';
  fAddValue(LCommand, strCodFpg, ftString);                                     //LCommand := LCommand + 'DET_CODFPG, ';
  fAddValue(LCommand, fltQtdBai, ftFloat);                                      //LCommand := LCommand + 'DET_QTDBAI, ';
  fAddValue(LCommand, strInfIte, ftString);                                     //LCommand := LCommand + 'DET_INFITE, ';
  fAddValue(LCommand, strSepImp, ftString);                                     //LCommand := LCommand + 'DET_SEPIMP, ';
  fAddValue(LCommand, LAutIncArq, ftString);                                    //LCommand := LCommand + 'AUTOINCREM, ';
  fAddValue(LCommand, strAutInc, ftString);                                     //LCommand := LCommand + 'DET_AUTINC, ';
  fAddValue(LCommand, VS_strCodEmp, ftString);                                  //LCommand := LCommand + 'DET_EMPROM, ';
  fAddValue(LCommand, strNumLot, ftString);                                     //LCommand := LCommand + 'DET_NUMLOT, ';
  fAddValue(LCommand, fltPesLiq, ftFloat);                                      //LCommand := LCommand + 'DET_PESLIQ, ';
  fAddValue(LCommand, fltVolume, ftFloat);                                      //LCommand := LCommand + 'DET_VOLUME, ';
  fAddValue(LCommand, strEmpOri, ftString);                                     //LCommand := LCommand + 'DET_EMPORI, ';
  fAddValue(LCommand, IIF(fltQtdBai = 0, fltQtdIte, fltQtdBai), ftFloat);       //LCommand := LCommand + 'DET_QTDROM, ';
  fAddValue(LCommand, fltValCbs, ftFloat);                                      //LCommand := LCommand + 'DET_VALCBS, ';
  fAddValue(LCommand, fltValIbs, ftFloat);                                      //LCommand := LCommand + 'DET_VALIBS, ';
  fAddValue(LCommand, fltVal_Is, ftFloat, True);                                //LCommand := LCommand + 'DET_VAL_IS  ';

  LCommand := LCommand + ')';

  Result := LCommand;
End;

function fSqlValoresReformaTributariaRomaneio(const ATabelaDetalhe, AAliasDetalhe: String; const AExpressaoRateio: String = ''): String;
var
  LTabelaReforma: String;

  function fSubSelect(const ACampo: String): String;
  begin
    Result := ' ((SELECT IFNULL(SUM(R.' + ACampo + '), 0) FROM ' + LTabelaReforma + ' R ' +
              'WHERE R.' + fCampoSeqReformaRef(LTabelaReforma) + ' = ' + AAliasDetalhe + '.AUTOINCREM)' + AExpressaoRateio + ') AS ' + ACampo;
  end;

begin
  If (ATabelaDetalhe = 'FATDOR') Then
    LTabelaReforma := 'FDOREF'
  Else If (ATabelaDetalhe = 'MOVDET') Then
    LTabelaReforma := 'MOVREF'
  Else If (ATabelaDetalhe = 'NOTDET') Then
    LTabelaReforma := 'NOTREF'
  Else
    LTabelaReforma := '';

  If fEmptyStr(LTabelaReforma) Or (Not fSomarNovosImpostosDaReformaAoValorContabil) Then
  Begin
    Result := ' 0.0 AS REF_CBSVAL, 0.0 AS REF_VALIBS, 0.0 AS REF_SELVAL ';
    Exit;
  End;

  Result := fSubSelect('REF_CBSVAL') + ',' + fSubSelect('REF_VALIBS') + ',' + fSubSelect('REF_SELVAL') + ' ';
end;

procedure fGravaROMCND(strAutInc: String; arrDuplic: TarrDuplicata; AInsertsInBatchRomCnd: TInsertsInBatchROMCND = nil);
var
  intContador: Integer;
  LExecutar: Boolean;
  LInsertsInBatch: TInsertsInBatchROMCND;
Begin
  LExecutar := (not (fGravacaoEmLote and Assigned(AInsertsInBatchRomCnd)));

  if LExecutar then
    LInsertsInBatch := TInsertsInBatchROMCND.New
  else
    LInsertsInBatch := AInsertsInBatchRomCnd;

  try
    for intContador := Low(arrDuplic) to High(arrDuplic) do
    begin
      if (arrDuplic[intContador].curValor > 0) then
        LInsertsInBatch.AddCommand('(' +
                                   QuotedStr(strAutInc) + ',' +
                                   QuotedStr(arrDuplic[intContador].strSequen) + ',' +
                                   fFloatToSQL(arrDuplic[intContador].curValor) + ')');
    end;

    if LExecutar then
      LInsertsInBatch.ExecSQL;
  finally
    if LExecutar then
      FreeAndNil(LInsertsInBatch);
  end;
end;

procedure pDeletaRomaneio(strNumRom: String; blnEntDev: Boolean; blnProcessaCRM: Boolean = False);
var
  strSQL   : String;
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LGer: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LNotGer: Boolean;
  LOpcRom: String;

  procedure pCarregaDocumentosDoRomaneio(AQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX});
  Begin
    With AQry Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(' SELECT GER_NUMDOC, GER_ESPDOC, GER_CODEMP, GER_TIP_FC, GER_ENTSAI ');
      SQL.Add('   FROM ROMGERX ');
      SQL.Add('  WHERE GER_NUMROM = :NUMROM ');
      SQL.Add('    AND GER_EMPROM = :EMPROM ');
      SQL.Add('  GROUP BY GER_NUMDOC, GER_ESPDOC, GER_CODEMP, GER_TIP_FC, GER_ENTSAI ');
      ParamByName('NUMROM').AsString := strNumRom;
      ParamByName('EMPROM').AsString := VS_strCodEmp;
      Open;
    End;
  End;

  procedure pExecutaSQL(const ASQL: String);
  begin
    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Add(ASQL);
    LQry.ParamByName('NUMROM').AsString := strNumRom;
    LQry.ParamByName('EMPROM').AsString := VS_strCodEmp;
    LQry.ExecSQL;
  end;

begin
  {*******************************************}
  {* VERIFICA QUAIS TABELAS TEM (MOV/NOT)GER *}
  {****************************************MV*}
  LOpcRom := fCfgSis('OPCROM');
  LNotGer := (Pos(LOpcRom, '34') > 0);

  Try
    LQry := fCriaQuery;
    LGer := fCriaQuery;

    pCarregaDocumentosDoRomaneio(LGer);

    If (fCfgSis('UTITDE', varBoolean)) Then
    Begin
      strSQL := '';
      strSQL := strSQL + '   UPDATE ROMTRAX TRA, ROMGERX GER ';
      strSQL := strSQL + '   SET TRA.TRA_SEQ_BX = NULL ';
      strSQL := strSQL + '   WHERE TRA.AUTOINCREM = GER.GER_SEQTRA ';
      strSQL := strSQL + '   AND GER_NUMROM = :NUMROM ';
      strSQL := strSQL + '   AND GER_EMPROM = :EMPROM ';

      pExecutaSQL(strSQL);
    End;

    If (Pos(LOpcRom, '234') > 0) Then
    Begin
      strSQL := '';
      strSQL := strSQL + ' UPDATE ';
      strSQL := strSQL + '   NOTDET D, ROMDETX R ';
      strSQL := strSQL + ' SET ';
      if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
        strSQL := strSQL + '   D.DET_QTDROM = D.DET_QTDROM - R.DET_QTDITE '
      else
        strSQL := strSQL + '   D.DET_QTDROM = D.DET_QTDROM - R.DET_QTDBAI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '   D.AUTOINCREM = R.DET_AUTINC AND ';
      strSQL := strSQL + '   D.DET_NUMDOC = R.DET_NUMDOC AND ';
      strSQL := strSQL + '   D.DET_ESPDOC = R.DET_ESPDOC AND ';
      strSQL := strSQL + '   D.DET_CODCLI = R.DET_CODCLI AND ';
      strSQL := strSQL + '   D.DET_CODEMP = R.DET_CODEMP AND ';
      strSQL := strSQL + '   R.DET_NUMROM = :NUMROM AND ';
      strSQL := strSQL + '   R.DET_EMPROM = :EMPROM ';

      If (LNotGer) Then
        pExecutaSQL(strSQL);
    End;

    {*************************************************************}
    {* CASO SEJA ROMANEIO PARA PEDIDOS OU ESTIVER CONFIGURADO    *}
    {* PARA EXIBIR DEVOLUÇÕES NO ROMANEIO, AUTALIZA A QUANTIDADE *}
    {* INCLUIDA NO ROMANEIO NA TABELA FATDOR, POIS PODEM EXISTIR *}
    {* PEDIDOS DE RETIRADA(ESPÉCIE PR).                          *}
    {**********************************************************PZ*}
    If (Pos(LOpcRom, '1_5_') > 0) Or (blnEntDev) Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'UPDATE ';
      strSQL := strSQL + '  FATDOR D, ROMDETX R ';
      strSQL := strSQL + 'SET ';
      if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
        strSQL := strSQL + '   D.FDO_QTDROM = D.FDO_QTDROM - R.DET_QTDITE '
      else
        strSQL := strSQL + '   D.FDO_QTDROM = D.FDO_QTDROM - R.DET_QTDBAI ';
      strSQL := strSQL + 'WHERE ';
      strSQL := strSQL + '  D.AUTOINCREM = R.DET_AUTINC AND ';
      strSQL := strSQL + '  D.FDO_NUMDOC = R.DET_NUMDOC AND ';
      strSQL := strSQL + '  D.FDO_ESPDOC = R.DET_ESPDOC AND ';
      strSQL := strSQL + '  D.FDO_CODCLI = R.DET_CODCLI AND ';
      strSQL := strSQL + '  D.FDO_CODEMP = R.DET_CODEMP AND ';
      strSQL := strSQL + '  R.DET_NUMROM = :NUMROM AND ';
      strSQL := strSQL + '  R.DET_EMPROM = :EMPROM ';

      pExecutaSQL(strSQL);
    End;

    {*******************************************}
    {* CAIXA 2: APAGA MI, FF, TR E DV          *}
    {****************************************MV*}
    strSQL := '';
    strSQL := strSQL + 'UPDATE ';
    strSQL := strSQL + '  MOVDET D, ROMDETX R ';
    strSQL := strSQL + 'SET ';
      if fCfgSis('USPRRO', varBoolean) and fCfgSis('RMPDPA', varBoolean) then
        strSQL := strSQL + '   D.DET_QTDROM = D.DET_QTDROM - R.DET_QTDITE '
      else
        strSQL := strSQL + '   D.DET_QTDROM = D.DET_QTDROM - R.DET_QTDBAI ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  D.AUTOINCREM = R.DET_AUTINC AND ';
    strSQL := strSQL + '  D.DET_NUMDOC = R.DET_NUMDOC AND ';
    strSQL := strSQL + '  D.DET_ESPDOC = R.DET_ESPDOC AND ';
    strSQL := strSQL + '  D.DET_CODCLI = R.DET_CODCLI AND ';
    strSQL := strSQL + '  D.DET_CODEMP = R.DET_CODEMP AND ';
    strSQL := strSQL + '  R.DET_NUMROM = :NUMROM AND ';
    strSQL := strSQL + '  R.DET_EMPROM = :EMPROM ';

    pExecutaSQL(strSQL);

{$IFNDEF FUSION}
    if fCfgSis('ROMPLP', varBoolean) then
    begin
      pRemoveVinculoDocumentosPLPEmAbertoRomaneio(strNumRom);
      if blnProcessaCRM then
        pDeletaPLPEmAbertoSemObjetoRomaneio(strNumRom);
    end;
{$ENDIF FUSION}

    if fCfgSis('MATDIS', varBoolean) then
      pAtualizaRASROM(strNumRom);

    pSubtrairValRomDocumentos(LGer, strNumRom, blnEntDev);
    pRemoverVinculoRomaneioComDocumento(LGer, LOpcRom);
    pDeletaRomOutX(strNumRom);

    strSQL := 'DELETE FROM ROMDETX WHERE DET_NUMROM = :NUMROM AND DET_EMPROM = :EMPROM ';
    pExecutaSQL(strSQL);

    strSQL := 'DELETE FROM ROMGERX WHERE GER_NUMROM = :NUMROM AND GER_EMPROM = :EMPROM ';
    pExecutaSQL(strSQL);

    If blnProcessaCRM And
      (fCfgSis('EXISTA', varBoolean) Or VS_strHabilitarCRM) Then
    Begin
      LGer.First;

      While (Not LGer.Eof) Do
      Begin
        TProcessCRM.New()
          .NumDoc(LGer.FieldByName('GER_NUMDOC').AsString)
          .EspDoc(LGer.FieldByName('GER_ESPDOC').AsString)
          .CodEmp(LGer.FieldByName('GER_CODEMP').AsString)
          .pRun();

        LGer.Next();
      End;
    End;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
    FreeAndNil(LGer);
{$ENDIF LINUX}
  End;
end;

procedure pSubtrairValRomDocumentos(qryDocs: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX}; strNumRom: String; blnEntDev: Boolean);
var
  qryUpdate : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  blnNotGer : Boolean;
  strOpcRom : String;
  LFGO,
  LMOV,
  LNOT: String;

  procedure pAlteraValRomGer(strNomTab, AParams: String);
  var
    LSQL: String;
  begin
    LSQL := '';
    LSQL := LSQL + 'UPDATE ' + strNomTab + ' MG ';
    LSQL := LSQL + 'INNER JOIN ROMGERX R ON R.GER_NUMDOC = MG.GER_NUMDOC ';
    LSQL := LSQL + '  AND R.GER_ESPDOC = MG.GER_ESPDOC ';
    LSQL := LSQL + '  AND R.GER_CODEMP = MG.GER_CODEMP ';
    LSQL := LSQL + 'SET ';
    LSQL := LSQL + '  MG.GER_VALROM = IF(MG.GER_VALROM - R.GER_VLRCON < 0, 0, MG.GER_VALROM - R.GER_VLRCON)  ';
    LSQL := LSQL + 'WHERE R.GER_NUMROM = ' + QuotedStr(strNumRom);
    LSQL := LSQL + '  AND R.GER_EMPROM = ' + QuotedStr(VS_strCodEmp);
    LSQL := LSQL + '  AND (' + AParams + ') ';

    qryUpdate.Close;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(LSQL);
    qryUpdate.ExecSQL;
  end;

  procedure pAlteraValRomGor(AParams: String);
  var
    LSQL: String;
  begin
    LSQL := '';
    LSQL := LSQL + 'UPDATE FATGOR G ';
    LSQL := LSQL + 'INNER JOIN ROMGERX R ON R.GER_NUMDOC = G.FGO_NUMDOC ';
    LSQL := LSQL + '  AND R.GER_ESPDOC = G.FGO_ESPDOC ';
    LSQL := LSQL + '  AND R.GER_CODEMP = G.FGO_CODEMP ';
    LSQL := LSQL + 'SET ';
    LSQL := LSQL + '  G.FGO_VALROM = IF(G.FGO_VALROM - R.GER_VLRCON < 0, 0, G.FGO_VALROM - R.GER_VLRCON) ';
    LSQL := LSQL + 'WHERE R.GER_NUMROM = ' + QuotedStr(strNumRom);
    LSQL := LSQL + '  AND R.GER_EMPROM = ' + QuotedStr(VS_strCodEmp);
    LSQL := LSQL + '  AND (' + AParams + ') ';

    qryUpdate.Close;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(LSQL);
    qryUpdate.ExecSQL;
  end;

  procedure fAddDocumento(ATabela, ANumDoc, AEspDoc, AEmpDoc, AEntSai: String);
  var
    LAux: String;
  begin
    LAux := '';
    LAux := LAux + '(R.GER_NUMDOC = ' + QuotedStr(ANumDoc) + ' AND ';
    LAux := LAux + ' R.GER_ESPDOC = ' + QuotedStr(AEspDoc) + ' AND ';
    LAux := LAux + ' R.GER_CODEMP = ' + QuotedStr(AEmpDoc) + ' AND ';
    LAux := LAux + ' R.GER_ENTSAI = ' + QuotedStr(AEntSai) + ') OR ';

    case AnsiIndexStr(ATabela, ['FATGOR', 'MOVGER', 'NOTGER']) of
      0: LFGO := LFGO + LAux;
      1: LMOV := LMOV + LAux;
      2: LNOT := LNOT + LAux;
    end;
  end;
begin
  qryUpdate := fCriaQuery();

  try
    strOpcRom := fCfgSis('OPCROM');
    blnNotGer := (Pos(strOpcRom, '34') > 0);

    qryDocs.First;

    while not qryDocs.Eof do
    begin
      {*************************************************************}
      {* CASO SEJA ROMANEIO PARA PEDIDOS OU ESTIVER CONFIGURADO    *}
      {* PARA EXIBIR DEVOLUÇÕES NO ROMANEIO, AUTALIZA O VALOR DO   *}
      {* ROMANEIO NA TABELA FATDOR, POIS PODEM EXISTIR PEDIDOS DE  *}
      {* RETIRADA(ESPÉCIE PR).                                     *}
      {**********************************************************PZ*}
      if (Pos(strOpcRom, '1_5_') > 0) or (blnEntDev) then
        fAddDocumento('FATGOR',
                      qryDocs.FieldByName('GER_NUMDOC').AsString,
                      qryDocs.FieldByName('GER_ESPDOC').AsString,
                      qryDocs.FieldByName('GER_CODEMP').AsString,
                      qryDocs.FieldByName('GER_ENTSAI').AsString);

      fAddDocumento('MOVGER',
                    qryDocs.FieldByName('GER_NUMDOC').AsString,
                    qryDocs.FieldByName('GER_ESPDOC').AsString,
                    qryDocs.FieldByName('GER_CODEMP').AsString,
                    qryDocs.FieldByName('GER_ENTSAI').AsString);

      if (blnNotGer) then
        fAddDocumento('NOTGER',
                      qryDocs.FieldByName('GER_NUMDOC').AsString,
                      qryDocs.FieldByName('GER_ESPDOC').AsString,
                      qryDocs.FieldByName('GER_CODEMP').AsString,
                      qryDocs.FieldByName('GER_ENTSAI').AsString);

      qryDocs.Next;
    end;

    if (not fEmptyStr(LFGO)) then
      pAlteraValRomGor(Copy(LFGO, 1, Length(LFGO)-3));

    if (not fEmptyStr(LMOV)) then
      pAlteraValRomGer('MOVGER', Copy(LMOV, 1, Length(LMOV)-3));

    if (not fEmptyStr(LNOT)) then
      pAlteraValRomGer('NOTGER', Copy(LNOT, 1, Length(LNOT)-3));
  finally
{$IFNDEF LINUX}
    FreeAndNil(qryUpdate);
{$ENDIF LINUX}
  end;
end;

procedure pRemoverVinculoRomaneioComDocumento(qryDocs: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX}; strOpcRom: String);
var
  qryGenDet : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  strSigGer : String;
  strTabela : String;
  intCnt    : Integer;
  intCntDocs: Integer;
  arrTabela : Array [1..2] Of String;
  LFGO,
  LMOV,
  LNOT,
  LOUT: String;

  procedure pExecutaUpdate(aTabela, ASigGer, AParams: String);
  var
    LSQL: String;
  begin
    LSQL := '';
    LSQL := LSQL + 'UPDATE ';
    LSQL := LSQL + ' ' + aTabela + ' ';
    LSQL := LSQL + 'SET ';
    LSQL := LSQL + '  ' + ASigGer + '_DTAROM = NULL, ';
    LSQL := LSQL + '  ' + ASigGer + '_HORROM = NULL, ';
    LSQL := LSQL + '  ' + ASigGer + '_OPEROM = NULL, ';
    LSQL := LSQL + '  ' + ASigGer + '_NUMROM = NULL, ';
    LSQL := LSQL + '  ' + ASigGer + '_EMPROM = NULL ';
    LSQL := LSQL + 'WHERE ' + AParams;

    qryGenDet.Close;
    qryGenDet.SQL.Text := LSQL;
    qryGenDet.ExecSQL;
  End;

  procedure fAddDocumento(ATabela, ANumDoc, AEspDoc, AEmpDoc: String; ATip_FC: String = '');
  begin
    case AnsiIndexStr(ATabela, ['FATGOR', 'MOVGER', 'NOTGER', 'OUTDIGX']) of
      0:
        begin
          LFGO := LFGO + '(FGO_NUMDOC = ' + QuotedStr(ANumDoc) + ' AND ';
          LFGO := LFGO + ' FGO_ESPDOC = ' + QuotedStr(AEspDoc) + ' AND ';
          LFGO := LFGO + ' FGO_CODEMP = ' + QuotedStr(AEmpDoc) + ') OR ';
        end;
      1:
        begin
          LMOV := LMOV + '(GER_NUMDOC = ' + QuotedStr(ANumDoc) + ' AND ';
          LMOV := LMOV + ' GER_ESPDOC = ' + QuotedStr(AEspDoc) + ' AND ';
          LMOV := LMOV + ' GER_CODEMP = ' + QuotedStr(AEmpDoc) + ' AND ';
          LMOV := LMOV + ' GER_TIP_FC = ' + QuotedStr(ATip_FC) + ') OR ';
        end;
      2:
        begin
          LNOT := LNOT + '(GER_NUMDOC = ' + QuotedStr(ANumDoc) + ' AND ';
          LNOT := LNOT + ' GER_ESPDOC = ' + QuotedStr(AEspDoc) + ' AND ';
          LNOT := LNOT + ' GER_CODEMP = ' + QuotedStr(AEmpDoc) + ' AND ';
          LNOT := LNOT + ' GER_TIP_FC = ' + QuotedStr(ATip_FC) + ') OR ';
        end;
      3:
        begin
          LOUT := LOUT + '(DIG_NUMDOC = ' + QuotedStr(ANumDoc) + ' AND ';
          LOUT := LOUT + ' DIG_ESPDOC = ' + QuotedStr(AEspDoc) + ' AND ';
          LOUT := LOUT + ' DIG_CODEMP = ' + QuotedStr(AEmpDoc) + ') OR ';
        end;
    end;
  end;
Begin
  arrTabela[1] := 'MOVGER';
  arrTabela[2] := 'NOTGER';

  LFGO := EmptyStr;
  LMOV := EmptyStr;
  LNOT := EmptyStr;
  LOUT := EmptyStr;

  qryGenDet := fCriaQuery;
  intCntDocs := 2; // MOVGER, NOTGER

  try
    Try
      For intCnt := 1 To intCntDocs Do
      Begin
        qryDocs.First;

        While Not qryDocs.Eof Do
        Begin
          strSigGer := 'GER';
          strTabela := 'MOVGER';

          If (Pos(qryDocs.FieldByName('GER_ESPDOC').AsString, 'PD_PR_') > 0) Then
          Begin
            strSigGer := 'FGO';
            strTabela := 'FATGOR';

            If (intCnt > 1) Then
            Begin
              qryDocs.Next;
              Continue;
            End;
          End;

          If (qryDocs.FieldByName('GER_ESPDOC').AsString = 'OX') Then
          Begin
            fAddDocumento('OUTDIGX',
                          qryDocs.FieldByName('GER_NUMDOC').AsString,
                          qryDocs.FieldByName('GER_ESPDOC').AsString,
                          qryDocs.FieldByName('GER_CODEMP').AsString);
          End
          Else
          Begin
            If (SameText(strTabela, 'FATGOR')) Then
              fAddDocumento('FATGOR',
                            qryDocs.FieldByName('GER_NUMDOC').AsString,
                            qryDocs.FieldByName('GER_ESPDOC').AsString,
                            qryDocs.FieldByName('GER_CODEMP').AsString)
            Else
              fAddDocumento(arrTabela[intCnt],
                            qryDocs.FieldByName('GER_NUMDOC').AsString,
                            qryDocs.FieldByName('GER_ESPDOC').AsString,
                            qryDocs.FieldByName('GER_CODEMP').AsString,
                            IIF((strSigGer = 'GER'), qryDocs.FieldByName('GER_TIP_FC').AsString, ''));

            If (SameText(strTabela, 'FATGOR')) Then
              fAddDocumento('MOVGER',
                            qryDocs.FieldByName('GER_NUMDOC').AsString,
                            qryDocs.FieldByName('GER_ESPDOC').AsString,
                            qryDocs.FieldByName('GER_CODEMP').AsString,
                            qryDocs.FieldByName('GER_TIP_FC').AsString);
          End;

          qryDocs.Next;
        End;
      End;

      if (not fEmptyStr(LFGO)) then
        pExecutaUpdate('FATGOR', 'FGO', Copy(LFGO, 1, Length(LFGO)-3));

      if (not fEmptyStr(LMOV)) then
        pExecutaUpdate('MOVGER', 'GER', Copy(LMOV, 1, Length(LMOV)-3));

      if (not fEmptyStr(LNOT)) then
        pExecutaUpdate('NOTGER', 'GER', Copy(LNOT, 1, Length(LNOT)-3));

      if (not fEmptyStr(LOUT)) then
        pExecutaUpdate('OUTDIGX', 'DIG', Copy(LOUT, 1, Length(LOUT)-3));
    Except
      On E: Exception Do
  {$IFNDEF FUSION}
        pMensagensErro(E.Message, '[pRemoverVinculoRomaneioComDocumento]');
  {$ELSE }
        raise;
  {$ENDIF FUSION}
    End;
  finally
{$IFNDEF LINUX}
    FreeAndNil(qryGenDet);
{$ENDIF LINUX}
  end;
End;

procedure pDeletaRomOutX(strNumRom: String; strSeqDig: String = '');
  Var
    qryRomOutX : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryRomOutX := fCriaQuery();

  With qryRomOutX Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' DELETE ');
    SQL.Add('   FROM ROMOUTX ');
    SQL.Add('  WHERE OUT_NUMROM = :NUMROM ');
    SQL.Add('    AND OUT_ROMEMP = :CODEMP ');

    If Not fEmptyStr(strSeqDig) Then
      SQL.Add('  AND OUT_SEQDIG = :SEQDIG ');

    ParamByName('NUMROM').AsString := strNumRom;
    ParamByName('CODEMP').AsString := VS_strCodEmp;

    If Not fEmptyStr(strSeqDig) Then
      ParamByName('SEQDIG').AsString := strSeqDig;

    ExecSQL;
  End;

{$IFNDEF LINUX}
  FreeAndNil(qryRomOutX);
{$ENDIF LINUX}
end;

procedure pAtualizaRASROM(strNumRom: String);
  Var
    qryUpdt : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  qryUpdt := fCriaQuery();

  With qryUpdt Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' UPDATE RASROM ');
    SQL.Add('    SET RAS_EXPGPX = "N" ');
    SQL.Add('  WHERE RAS_NUMROM = :NUMROM ');
    SQL.Add('    AND RAS_EMPROM = :CODEMP ');
    ParamByName('NUMROM').AsString := strNumRom;
    ParamByName('CODEMP').AsString := VS_strCodEmp;
    ExecSQL;
  End;

{$IFNDEF LINUX}
  FreeAndNil(qryUpdt);
{$ENDIF LINUX}
end;

function fCriaDataSetOutDig: TUniClientDataSet;
begin
  Result := TUniClientDataSet.Create(nil);

  Result.FieldDefs.Add('AUTINC', ftString, 20);
  Result.FieldDefs.Add('NUMDOC', ftString, 6);
  Result.FieldDefs.Add('CODVEN', ftString, 3);
  Result.FieldDefs.Add('ESPDOC', ftString, 2);
  Result.FieldDefs.Add('DTAENT', ftDateTime);
  Result.FieldDefs.Add('HORENT', ftDatetime);
  Result.FieldDefs.Add('DESCRI', ftString, 200);
  Result.FieldDefs.Add('CODEMP', ftString, 3);
  Result.FieldDefs.Add('DTAETR', ftDatetime);
  Result.FieldDefs.Add('ENDCON', ftString, 80);
  Result.FieldDefs.Add('BAIRRO', ftString, 30);
  Result.FieldDefs.Add('CEPCON', ftString, 8);
  Result.FieldDefs.Add('CODCID', ftString, 5);
  Result.FieldDefs.Add('NOMCID', ftString, 40);
  Result.FieldDefs.Add('ESTADO', ftString, 2);
  Result.FieldDefs.Add('FILIAL', ftString, 1);
  Result.CreateDataSet;
end;

procedure pInsereOutDigXDefinicaoRotas(const AOutDig, ATmpDoc: TUniClientDataSet);
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LDados: TUniClientDataSet;
begin
  if AOutDig.IsEmpty then
    Exit;

  LQry := fCriaQuery;
  LDados := TUniClientDataSet.Create(nil);

  try
    LQry.SQL.Add('INSERT INTO OUTDIGX ');
    LQry.SQL.Add('  (AUTOINCREM, DIG_NUMDOC, DIG_CODVEN, DIG_ESPDOC, DIG_DTAENT, DIG_HORENT, DIG_DESCRI, DIG_CODEMP, ');
    LQry.SQL.Add('   DIG_CODCID, DIG_NOMCID, DIG_DTAETR, DIG_ENDCON, DIG_BAIRRO, DIG_CEPCON, DIG_ESTADO, DIG_FILIAL) ');
    LQry.SQL.Add('VALUES ');
    LQry.SQL.Add('  (:AUTINC, :NUMDOC, :CODVEN, :ESPDOC, :DTAENT, :HORENT, :DESCRI, :CODEMP, ');
    LQry.SQL.Add('   :CODCID, :NOMCID, :DTAETR, :ENDCON, :BAIRRO, :CEPCON, :ESTADO, :FILIAL) ');

    try
      pCloneDataSet(LDados, ATmpDoc);

      LDados.Filtered := False;
      LDados.Filter := 'GER_MARDES=''M''';
      LDados.Filtered := True;

      AOutDig.First;

      while not AOutDig.Eof do
      begin
        if (not LDados.Locate('GER_AUTINC', AOutDig.FieldByName('AUTINC').AsString, [])) then
        begin
          AOutDig.Next;
          Continue;
        end;

        LQry.Close;
        LQry.ParamByName('AUTINC').AsString   := AOutDig.FieldByName('AUTINC').AsString;
        LQry.ParamByName('NUMDOC').AsString   := AOutDig.FieldByName('NUMDOC').AsString;
        LQry.ParamByName('CODVEN').AsString   := AOutDig.FieldByName('CODVEN').AsString;
        LQry.ParamByName('ESPDOC').AsString   := AOutDig.FieldByName('ESPDOC').AsString;
        LQry.ParamByName('DTAENT').AsDateTime := AOutDig.FieldByName('DTAENT').AsDateTime;
        LQry.ParamByName('HORENT').AsDateTime := AOutDig.FieldByName('HORENT').AsDateTime;
        LQry.ParamByName('DESCRI').AsString   := AOutDig.FieldByName('DESCRI').AsString;
        LQry.ParamByName('CODEMP').AsString   := AOutDig.FieldByName('CODEMP').AsString;
        LQry.ParamByName('DTAETR').AsDateTime := AOutDig.FieldByName('DTAETR').AsDateTime;
        LQry.ParamByName('ENDCON').AsString   := AOutDig.FieldByName('ENDCON').AsString;
        LQry.ParamByName('BAIRRO').AsString   := AOutDig.FieldByName('BAIRRO').AsString;
        LQry.ParamByName('CEPCON').AsString   := AOutDig.FieldByName('CEPCON').AsString;
        LQry.ParamByName('CODCID').AsString   := AOutDig.FieldByName('CODCID').AsString;
        LQry.ParamByName('NOMCID').AsString   := AOutDig.FieldByName('NOMCID').AsString;
        LQry.ParamByName('ESTADO').AsString   := AOutDig.FieldByName('ESTADO').AsString;
        LQry.ParamByName('FILIAL').AsString   := AOutDig.FieldByName('FILIAL').AsString;
        LQry.ExecSQL;

        AOutDig.Next;
      end;
    except on E: Exception do
      raise;
    end;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
    FreeAndNil(LDados);
  end;
end;

function fGravacaoEmLote : Boolean;
begin
  Result := fCfgSis('ROMGRA', varBoolean);
end;

{ TProcessCRM }

function TProcessCRM.CodEmp(const AValue: String): IProcessCRM;
begin
  FCodEmp := AValue;
  Result := Self;
end;

constructor TProcessCRM.Create;
begin
  FNumDoc := '';
  FEspDoc := '';
  FCodEmp := '';
  FDocumentsFgo := '';
  FDocumentsGer := '';
  FStlDocumentsBkp := nil;
  FProcessaStatusIndividualRomaneio := True;
end;

function TProcessCRM.DocumentsFgo(const AValue: String): IProcessCRM;
begin
  FDocumentsFgo := AValue;
  Result := Self;
end;

function TProcessCRM.DocumentsGer(const AValue: String): IProcessCRM;
begin
  FDocumentsGer := AValue;
  Result := Self;
end;

function TProcessCRM.EspDoc(const AValue: String): IProcessCRM;
begin
  FEspDoc := AValue;
  Result := Self;
end;

function TProcessCRM.fReportedDocument: Boolean;
begin
  Result := (Not fEmptyStr(FNumDoc)) And
            (Not fEmptyStr(FEspDoc)) And
            (Not fEmptyStr(FCodEmp));
end;

class function TProcessCRM.New: IProcessCRM;
begin
  Result := TProcessCRM.Create();
end;

function TProcessCRM.NumDoc(const AValue: String): IProcessCRM;
begin
  FNumDoc := AValue;
  Result := Self;
end;

function TProcessCRM.objTemporariaDocsRomaneio(const AValue: TTemporariaDocumentosRomaneio): IProcessCRM;
begin
  Result := Self;
  FTemporariaDocsRomaneio := AValue;
end;

procedure TProcessCRM.pAtualizaStatusParaFaturadoEmTransito(AListaSeqFGO: String);
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
begin
  if fEmptyStr(AListaSeqFGO) then
    Exit;

  AListaSeqFGO := Copy(AListaSeqFGO, 1, Length(AListaSeqFGO) - 1);

  LQry := fCriaQuery();

  try
    LQry.Close;
    LQry.SQL.Clear;
    LQry.SQL.Add('UPDATE EXTGOR');
    LQry.SQL.Add('SET FGO_STATUS = ' + pvFaturadoEmTransito.fGetId().ToString());
    LQry.SQL.Add('WHERE FGO_SEQFGO IN (' + AListaSeqFGO + ')');
    LQry.ExecSQL;
  finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  end;
end;

function TProcessCRM.ProcessaStatusIndividualRomaneio(const AValue: Boolean): IProcessCRM;
begin
  Result := Self;
  FProcessaStatusIndividualRomaneio := AValue;
end;

procedure TProcessCRM.pRun;
var
  LQry: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery {$ENDIF LINUX};
  LIsRemoval: Boolean;
  LCont: Integer;
  LListaSeqFGO: String;
  LSQL, LSQL2: String;
begin
  LQry := fCriaQuery();

  Try
    try
      LSQL := '';
      LSQL := LSQL + 'SELECT F.FGO_NUMDOC, F.FGO_ESPDOC, F.FGO_CODEMP,      ';
      LSQL := LSQL + '  M.GER_NUMDOC, M.GER_ESPDOC, M.GER_CODEMP,           ';
      LSQL := LSQL + '  F.AUTOINCREM SEQFGO, M.AUTOINCREM GER_AUTINC,       ';
      LSQL := LSQL + '  IF(LEFT(GER_CLAFIS, 1) >= "5", "S", "E") GER_ENTSAI ';
      LSQL := LSQL + 'FROM FATGOR F                                         ';
      LSQL := LSQL + ' %s ';
      LSQL := LSQL + 'JOIN MOVGER M ON M.GER_NUMDOC = F.FGO_NUMFAT    ';
      LSQL := LSQL + '             AND M.GER_ESPDOC = F.FGO_TIPFAT    ';
      LSQL := LSQL + '             AND M.GER_CODEMP = F.FGO_EMPFAT    ';
      LSQL := LSQL + '             AND M.GER_CODCLI = F.FGO_CODCLI    ';
      LSQL := LSQL + ' %s ';
      LSQL := LSQL + 'WHERE F.FGO_JAFATU = 1 ';

      LSQL2 := LSQL2 + 'SELECT F.FGO_NUMDOC, F.FGO_ESPDOC, F.FGO_CODEMP,      ';
      LSQL2 := LSQL2 + '  M.GER_NUMDOC, M.GER_ESPDOC, M.GER_CODEMP,           ';
      LSQL2 := LSQL2 + '  F.AUTOINCREM SEQFGO, M.AUTOINCREM GER_AUTINC,       ';
      LSQL2 := LSQL2 + '  IF(LEFT(GER_CLAFIS, 1) >= "5", "S", "E") GER_ENTSAI ';
      LSQL2 := LSQL2 + 'FROM FATDOR FD                                   ';
      LSQL2 := LSQL2 + 'JOIN FATGOR F ON FD.FDO_SEQGER = F.AUTOINCREM    ';
      LSQL2 := LSQL2 + ' %s ';
      LSQL2 := LSQL2 + 'JOIN EXTGOR E ON E.FGO_SEQFGO = F.AUTOINCREM     ';
      LSQL2 := LSQL2 + 'JOIN MOVGER M ON M.GER_NUMDOC = FD.FDO_NUMFAT    ';
      LSQL2 := LSQL2 + '             AND M.GER_ESPDOC = FD.FDO_TIPFAT    ';
      LSQL2 := LSQL2 + '             AND M.GER_CODEMP = FD.FDO_EMPFAT    ';
      LSQL2 := LSQL2 + '             AND M.GER_CODCLI = FD.FDO_CODCLI    ';
      LSQL2 := LSQL2 + ' %s ';
      LSQL2 := LSQL2 + 'WHERE F.FGO_JAFATU = 1 AND E.FGO_UTIPEN = "S" ';

      if (fReportedDocument()) then
      begin
        LQry.SQL.Add(Format(LSQL, ['', '']));

        If (FEspDoc.Equals('PD')) Then
          LQry.SQL.Add('AND (F.FGO_NUMDOC = ' + QuotedStr(FNumDoc) +
                       ' AND F.FGO_ESPDOC = ' + QuotedStr(FEspDoc) +
                       ' AND F.FGO_CODEMP = ' + QuotedStr(FCodEmp) + ')')
        Else
          LQry.SQL.Add('AND (M.GER_NUMDOC = ' + QuotedStr(FNumDoc) +
                       ' AND M.GER_ESPDOC = ' + QuotedStr(FEspDoc) +
                       ' AND M.GER_CODEMP = ' + QuotedStr(FCodEmp) + ')');
      end
      else
      begin
        LQry.SQL.Add(Format(LSQL, [FTemporariaDocsRomaneio.fGetJoinDocumentos(FDocumentsFgo, 'F.AUTOINCREM'), '']));
        LQry.SQL.Add(' UNION ');
        LQry.SQL.Add(Format(LSQL, ['', FTemporariaDocsRomaneio.fGetJoinDocumentos(FDocumentsGer,
          'M.AUTOINCREM', 'IF(LEFT(GER_CLAFIS, 1) >= "5", "S", "E")')]));
      end;

      LQry.SQL.Add('UNION');

      if (fReportedDocument()) then
      begin
        LQry.SQL.Add(Format(LSQL2, ['', '']));

        If (FEspDoc.Equals('PD')) Then
          LQry.SQL.Add('AND (F.FGO_NUMDOC = ' + QuotedStr(FNumDoc) +
                       ' AND F.FGO_ESPDOC = ' + QuotedStr(FEspDoc) +
                       ' AND F.FGO_CODEMP = ' + QuotedStr(FCodEmp) + ')')
        Else
          LQry.SQL.Add('AND (M.GER_NUMDOC = ' + QuotedStr(FNumDoc) +
                       ' AND M.GER_ESPDOC = ' + QuotedStr(FEspDoc) +
                       ' AND M.GER_CODEMP = ' + QuotedStr(FCodEmp) + ')');
      end
      else
      begin
        LQry.SQL.Add(Format(LSQL2, [FTemporariaDocsRomaneio.fGetJoinDocumentos(FDocumentsFgo, 'F.AUTOINCREM'), '']));
        LQry.SQL.Add(' UNION ');
        LQry.SQL.Add(Format(LSQL2, ['', FTemporariaDocsRomaneio.fGetJoinDocumentos(FDocumentsGer, 'M.AUTOINCREM',
          'IF(LEFT(GER_CLAFIS, 1) >= "5", "S", "E")')]));
      end;

      LQry.SQL.Add('GROUP BY F.FGO_NUMDOC, F.FGO_ESPDOC, F.FGO_CODEMP');

      LQry.Open;

      LCont := 0;
      LListaSeqFGO := '';

      While (Not LQry.Eof) Do
      Begin
        If LQry.FieldByName('FGO_ESPDOC').AsString = 'PD' Then
        Begin
          If Assigned(FStlDocumentsBkp) Then
            LIsRemoval := (FStlDocumentsBkp.IndexOf(Concat(
                                      LQry.FieldByName('FGO_NUMDOC').AsString, '-',
                                      LQry.FieldByName('FGO_ESPDOC').AsString, '-',
                                      LQry.FieldByName('FGO_CODEMP').AsString, '-',
                                      'S')) >= 0) Or
                          (FStlDocumentsBkp.IndexOf(Concat(
                                      LQry.FieldByName('GER_NUMDOC').AsString, '-',
                                      LQry.FieldByName('GER_ESPDOC').AsString, '-',
                                      LQry.FieldByName('GER_CODEMP').AsString, '-',
                                      LQry.FieldByName('GER_AUTINC').AsString, '-',
                                      LQry.FieldByName('GER_ENTSAI').AsString)) >= 0)
          Else
            LIsRemoval := False;

          If VS_strHabilitarCRM And (LIsRemoval Or fReportedDocument()) Then
            TUpdateOccurrenceCRM.New()
              .NumDoc(LQry.FieldByName('FGO_NUMDOC').AsString)
              .EspDoc(LQry.FieldByName('FGO_ESPDOC').AsString)
              .CodEmp(LQry.FieldByName('FGO_CODEMP').AsString)
              .AcaFat(afcRomaneioExclusao)
              .strNomFrm('untRomGer - [TProcessCRM.pRun]')
              .pRun();

          If fCfgSis('EXISTA', varBoolean) Then
          Begin
            if FProcessaStatusIndividualRomaneio then
              TUpdateStatus.New(TParamStatus.New()
                                .NumDoc(LQry.FieldByName('FGO_NUMDOC').AsString)
                                .EspDoc(LQry.FieldByName('FGO_ESPDOC').AsString)
                                .CodEmp(LQry.FieldByName('FGO_CODEMP').AsString)).pExecute()
            else
            begin
              if LCont <= 500 then
              begin
                LListaSeqFGO := LListaSeqFGO + QuotedStr(LQry.FieldByName('SEQFGO').AsString) + ',';
                LCont := LCont + 1;
              end
              else
              begin
                pAtualizaStatusParaFaturadoEmTransito(LListaSeqFGO);
                LListaSeqFGO := '';
                LCont := 0;
              end;
            end;
          End;
        End;

        LQry.Next();
      End;

      pAtualizaStatusParaFaturadoEmTransito(LListaSeqFGO);
    except on e: Exception do
      raise e;
    end;
  Finally
{$IFNDEF LINUX}
    FreeAndNil(LQry);
{$ENDIF LINUX}
  End;
end;

function TProcessCRM.StlDocumentsBkp(const AValue: TStringList): IProcessCRM;
var
  LBkp: Integer;
begin
  FStlDocumentsBkp := AValue;
  Result := Self;

  For LBkp := 0 To Pred(FStlDocumentsBkp.Count) Do
  Begin
    If (Pos('PD', FStlDocumentsBkp[LBkp]) > 0) Then
      FTemporariaDocsRomaneio.fInserirDocumentoTemporaria(FDocumentsFgo, Copy(FStlDocumentsBkp[LBkp], 21, 20), RightStr(FStlDocumentsBkp[LBkp], 1))
    Else
      FTemporariaDocsRomaneio.fInserirDocumentoTemporaria(FDocumentsGer, Copy(FStlDocumentsBkp[LBkp], 21, 20), RightStr(FStlDocumentsBkp[LBkp], 1));
  End;
end;

{ TInsertsInBatch }

procedure TInsertsInBatch.AddCommand(ACommand: String);
begin
  FCommand.SQL.Add(ACommand + IIF(FUltimoRegistro, '', ', '));
  FExecutar := True;
end;

destructor TInsertsInBatch.Destroy;
begin
  inherited;

{$IFNDEF LINUX}
  If Assigned(FCommand) Then
    FreeAndNil(FCommand);
{$ENDIF LINUX}
end;

procedure TInsertsInBatch.ExecSQL;
{*** Essa procedure "RemoverVirgulaNoFinalCasoExista" existe por
   causa do romaneio parcial, para evitar erros de sintax de SQL ***}

  procedure RemoverVirgulaNoFinalCasoExista;
  var
    LTamanho        : Integer;
    LUltimoCaracter : String;
  begin

    LTamanho        := Length(FCommand.SQL.Text);
    LUltimoCaracter := Copy(FCommand.SQL.Text, LTamanho -3, 1);

    If LUltimoCaracter.Equals(',') Then
      FCommand.SQL.Text := Copy(FCommand.SQL.Text, 1, LTamanho -4);

  end;
begin
  RemoverVirgulaNoFinalCasoExista;

  if (not FExecutar) then
    Exit;

  Try
    FCommand.ExecSQL;
    FCommand.SQL.Clear;
  Except
    Raise;
  End;
end;

function TInsertsInBatch.GetUltimoRegistro: Boolean;
begin
  Result := FUltimoRegistro;
end;

procedure TInsertsInBatch.HeadInsertInto;
begin
end;

constructor TInsertsInBatch.New;
begin
  FCommand := fCriaQuery();
  FUltimoRegistro := False;
  FExecutar := False;
end;

procedure TInsertsInBatch.SetUltimoRegistro(AValue : Boolean);
begin
  FUltimoRegistro := AValue;
end;

{ TInsertsInBatchROMGERX }

procedure TInsertsInBatchROMDETX.HeadInsertInto;
var
  LCommand : String;
begin
  LCommand := 'INSERT INTO ROMDETX ';

  LCommand := LCommand + '(DET_NUMROM, DET_SEQGER, DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_CODITE,';
  LCommand := LCommand + ' DET_CODVEN, DET_CODDIV, DET_CODMAR, DET_CODFOR, DET_CODCLI, DET_DTAENT,';
  LCommand := LCommand + ' DET_HORENT, DET_DTADOC, DET_CONPAG, DET_TIP_FC, DET_ESTADO, DET_DESCRI,';
  LCommand := LCommand + ' DET_REFERE, DET_UNIDAD, DET_FORITE, DET_QTDITE, DET_UNITAR, DET_UNIORI,';
  LCommand := LCommand + ' DET_TOTITE, DET_VLRCON, DET_TOTCUS, DET_TOTMED, DET_DESCON, DET_TOTFRE,';
  LCommand := LCommand + ' DET_DESESP, DET_CODREP, DET_PERCOM, DET_TOTCOM, DET_CLAFIS, DET_CODFIS,';
  LCommand := LCommand + ' DET_VALIPI, DET_ALQIPI, DET_BASIPI, DET_VALICM, DET_ALQICM, DET_BASICM,';
  LCommand := LCommand + ' DET_VALRET, DET_ALQRET, DET_BASRET, DET_TOTPES, DET_PERBAS, DET_PERRED,';
  LCommand := LCommand + ' DET_JAFATU, DET_TIPFAT, DET_NUMFAT, DET_DTAFAT, DET_VENFAT, DET_CNDFAT,';
  LCommand := LCommand + ' DET_VALFAT, DET_IDEPRO, DET_INCPIS, DET_SERIE_, DET_DESACE, DET_NOTESP,';
  LCommand := LCommand + ' DET_DOCDEV, DET_ESPDEV, DET_EMPDEV, DET_ITECHA, DET_ITETIN, DET_DESCOR,';
  LCommand := LCommand + ' DET_TIPEMB, DET_QTDEMB, DET_PREEMB, DET_TIPPRE, DET_PRVTIN, DET_PRCTIN,';
  LCommand := LCommand + ' DET_FATTIN, DET_PROEMB, DET_CODDIG, DET_CODCND, DET_CODFPG, DET_QTDBAI,';
  LCommand := LCommand + ' DET_INFITE, DET_SEPIMP, AUTOINCREM, DET_AUTINC, DET_EMPROM, DET_NUMLOT,';
  LCommand := LCommand + ' DET_PESLIQ, DET_VOLUME, DET_EMPORI, DET_QTDROM, DET_VALCBS, DET_VALIBS, DET_VAL_IS)';

  LCommand := LCommand + ' VALUES ';

  FCommand.SQL.Add(LCommand);
end;

constructor TInsertsInBatchROMDETX.New;
begin
  inherited;
  HeadInsertInto;
end;

{ TInsertsInBatchROMGERX }

procedure TInsertsInBatchROMGERX.HeadInsertInto;
var
  LCommand : String;
begin
  LCommand := 'INSERT INTO ROMGERX ';

  LCommand := LCommand + '(GER_NUMROM, AUTOINCREM, GER_NUMDOC, GER_SERIE_, GER_ESPDOC, GER_CODEMP,';
  LCommand := LCommand + ' GER_CODTRA, GER_CODVEN, GER_CODFOR, GER_CODCLI, GER_TIP_FC, GER_DTAENT,';
  LCommand := LCommand + ' GER_HORENT, GER_DTADOC, GER_CONPAG, GER_ESTADO, GER_NOMCON, GER_ENDCON,';
  LCommand := LCommand + ' GER_BAICON, GER_CEPCON, GER_CIDCON, GER_ESTCON, GER_TELCON, GER_CGCCPF,';
  LCommand := LCommand + ' GER_CGCCON, GER_IESCON, GER_R_GCON, GER_ENDENT, GER_BAIENT, GER_CEPENT,';
  LCommand := LCommand + ' GER_CIDENT, GER_REFENT, GER_BASSIM, GER_BASIPI, GER_ALQIPI, GER_TOTIPI,';
  LCommand := LCommand + ' GER_BASICM, GER_ALQICM, GER_TOTICM, GER_TOTRET, GER_ALQRET, GER_BASRET,';
  LCommand := LCommand + ' GER_DESESP, GER_VLRCON, GER_TOTPRO, GER_TOTCUS, GER_TOTMED, GER_TIPFRE,';
  LCommand := LCommand + ' GER_TOTFRE, GER_PESBRU, GER_PESLIQ, GER_VOLUME, GER_ESPECI, GER_MARCA_,';
  LCommand := LCommand + ' GER_MEN001, GER_MEN002, GER_JAFATU, GER_TIPFAT, GER_NUMFAT, GER_DTAFAT,';
  LCommand := LCommand + ' GER_VENFAT, GER_CNDFAT, GER_VALFAT, GER_VPAR01, GER_VPAR02, GER_VPAR03,';
  LCommand := LCommand + ' GER_VPAR04, GER_VPAR05, GER_VPAR06, GER_VPAR07, GER_VPAR08, GER_VPAR09,';
  LCommand := LCommand + ' GER_VPAR10, GER_VPAR11, GER_VPAR12, GER_NOTESP, GER_CLAFIS, GER_PORDES,';
  LCommand := LCommand + ' GER_CODDIG, GER_CODCND, GER_CODFPG, GER_CODMOT, GER_CODAJ1, GER_CODAJ2,';
  LCommand := LCommand + ' GER_CODAJ3, GER_CODAJ4, GER_OBSFEC, GER_PLAVEI, GER_CODREG, GER_DTAROM,';
  LCommand := LCommand + ' GER_HORROM, GER_OPEROM, GER_VLRORI, GER_ROMIMP, GER_ORDIMP, GER_LOCALI,';
  LCommand := LCommand + ' GER_LIBAPP, GER_EVITAR, GER_DISTAN, GER_TMPENT, GER_FILIAL, GER_INIPAR,';
  LCommand := LCommand + ' GER_FSTSHT, GER_FINROT, GER_OPESOL, GER_EMPROM, GER_ENTGER, GER_NUMBOX,';
  LCommand := LCommand + ' GER_FRETE_, GER_ADIFRE, GER_PERFRE, GER_PALET_, GER_STATUS, GER_CODBAR,';
  LCommand := LCommand + ' GER_NOMTAB, GER_ENTSAI, GER_AUTINC, GER_RETFIL, GER_CODFIL, GER_SEQTRA,';
  LCommand := LCommand + ' GER_ALTEND, GER_LATLON, GER_PRIORI, GER_INTFUS, GER_ROMFUS, GER_DTAINI,';
  LCommand := LCommand + ' GER_HORINI, GER_DEFCON)';

  LCommand := LCommand + ' VALUES ';

  FCommand.SQL.Add(LCommand);
end;

constructor TInsertsInBatchROMGERX.New;
begin
  inherited;
  HeadInsertInto;
end;

{ TInsertsInBatchROMCND }

procedure TInsertsInBatchROMCND.HeadInsertInto;
var
  LCommand: String;
begin
  LCommand := '';
  LCommand := LCommand + ' INSERT INTO ROMCND ';
  LCommand := LCommand + '  (GER_SEQGER, GER_PARCEL, GER_VALPAR) ';
  LCommand := LCommand + ' VALUES ';

  FCommand.SQL.Add(LCommand);
end;

constructor TInsertsInBatchROMCND.New;
begin
  inherited;
  HeadInsertInto;
end;

{ TInsertsInBatchAUXROMX }

procedure TInsertsInBatchAUXROMX.HeadInsertInto;
var
  LCommand: String;
begin
  LCommand := '';
  LCommand := LCommand + ' INSERT INTO AUXROMX ';
  LCommand := LCommand + '   (AUX_SEQGER, AUX_MSGEXP, AUX_MENEXP, AUX_MENEX2, AUX_MENEX3, AUX_MENEX4) ';
  LCommand := LCommand + ' VALUES ';

  FCommand.SQL.Add(LCommand);
end;

constructor TInsertsInBatchAUXROMX.New;
begin
  inherited;
  HeadInsertInto;
end;

{ TInsertsInBatchHISPED }

procedure TInsertsInBatchHISPED.HeadInsertInto;
var
  LCommand: String;
begin
  LCommand := '';
  LCommand := LCommand + 'INSERT INTO HISPED';
  LCommand := LCommand + ' (HIS_NUMDOC, HIS_ESPDOC, HIS_NUMROM, HIS_DTAROM, HIS_HORROM, HIS_CODMOT, HIS_CODTRA, HIS_CODEMP, HIS_ENTREG, AUTOINCREM)';
  LCommand := LCommand + ' VALUES ';

  FCommand.SQL.Add(LCommand);
end;

constructor TInsertsInBatchHISPED.New;
begin
  inherited;
  HeadInsertInto;
end;

{ TInsertsInBatchROMTRA }

procedure TInsertsInBatchROMTRAX.HeadInsertInto;
var
  LCommand: String;
begin
  LCommand := '';
  LCommand := LCommand + 'INSERT INTO ROMTRAX';
  LCommand := LCommand + ' (AUTOINCREM, TRA_SEQGER, TRA_DTATRA, TRA_HRATRA, TRA_EMPORI, TRA_EMPDES)';
  LCommand := LCommand + ' VALUES ';

  FCommand.SQL.Add(LCommand);
end;

constructor TInsertsInBatchROMTRAX.New;
begin
  inherited;
  HeadInsertInto;
end;

end.
