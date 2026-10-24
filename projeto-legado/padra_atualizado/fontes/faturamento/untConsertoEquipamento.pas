{***********************************************************}
{* CLASSE PARA CONSERTO DE EQUIPAMENTOS / ORDEM DE SERVIÇO *}
{* (MANUTENÇÃO / RELATORIO)                                *}
{*                                                         *}
{* DATA......: 25/03/2009                                  *}
{* AUTOR.....: LUCIENE                                     *}
{********************************************************LU*}
{* LEGENDA STATUS         | SUB-STATUS                     *}
{*---------------------------------------------------------*}
{* - "E" -> "EM ABERTO"   | - "O" -> "ORCAMENTO"           *}
{*                        | - "P" -> "AGUARDANDO PECAS"    *}
{*                        | - "C" -> "AGUARDANDO CLIENTE"  *}
{*---------------------------------------------------------*}
{* - "F", "ORCAMENTO REALIZADO"|                           *}
{*---------------------------------------------------------*}
{* - "A" -> "APROVADA"    | - "C" -> "APROVADO CLIENTE"    *}
{*                        | - "G" -> "APROVADO GARANTIA"   *}
{*---------------------------------------------------------*}
{* - "N" -> "REPROVADA"   | - "C" -> "DEVOLVIDA AO CLIENTE"*}
{*                        | - "A" -> "ARMAZENADA"          *}
{*---------------------------------------------------------*}
{* - "M", "EM MANUTENÇÃO" | - "C" -> "MANUTENÇÃO COMPLETA" *}
{*                        | - "A" -> "AGUARDANDO ITENS"    *}
{*---------------------------------------------------------*}
{* - "R", "REALIZADA"     | - "C" -> "DEVOLVIDA AO CLIENTE"*}
{*                        | - "A" -> "ARMAZENADA"          *}
{********************************************************JC*}

{***********************************************************}
{* SITUAÇÃO DO EQUIPAMENTO: EQUGER.EQU_SITEQU              *}
{***********************************************************}
{* SA - OS REALIZADA - ARMAZENADO                          *}
{* SR - OS REALIZADA - RETIRADO PELO CLIENTE               *}
{* NA - OS REPROVADA - ARMAZENADO                          *}
{* NR - OS REPROVADA - RETIRADO PELO CLIENTE               *}
{********************************************************CA*}

{*******************************************************************************************}
{*                       CAMPOS USADOS NO FLUXO DE ORDEM DE SERVIÇO                        *}
{* FASE: EQU_FLXFAS    | SITUAÇÃO: EQU_FLXSIT           | COMPLEMENTO: EQU_FLXCOM          *}
{*******************************************************************************************}
{* A - OS Aberta       | OI - OS Incluída               | AT - Ag. Análise Técnica         *}
{*-----------------------------------------------------------------------------------------*}
{* T - Análise Técnica | TC - Análise Técnica Concluída | AO - Ag. Orçamento               *}
{*                     | TA - Análise Técnica Andamento | AT - Ag. Análise Técnica         *}
{*                     | OA - Orçamento Aprovado        | OI - Orçamento Interrompido      *}
{*                                                      | MI - Manutenção Interrompida     *}
{*-----------------------------------------------------------------------------------------*}
{* O - Orçamento       | OR - Orçamento Realizado       | AE - Ag. Envio                   *}
{*                                                      | PF - Ag. Envio - Peças Faltantes *}
{*                                                      | AC - Enviado - Ag. Cliente       *}
{*                                                      | RC - Reprovação Cancelada        *}
{*                     | ON - Orçamento Reprovado       | AA - Ag. Armazenamento           *}
{*                                                      | AR - Ag. Retirada do Equipamento *}
{*-----------------------------------------------------------------------------------------*}
{* M - Manutenção      | EM - Em Manutenção             | AM - Ag. Manutenção              *}
{*                     | AP - Ag. Peças                 | AM - Ag. Manutenção              *}
{*                     | AS - Ag. Separação             | AM - Ag. Manutenção              *}
{*                     | MF - Manutenção Finalizada     | AA - Ag. Armazenamento           *}
{*                     | AR - Armazenada                | AF - Ag. Faturamento             *}
{*-----------------------------------------------------------------------------------------*}
{* R - OS Finalizada   | FA - Faturado                  | ER - Equipamento Retirado        *}
{*                     | ON - Orçamento Reprovado       | ER - Equipamento Retirado        *}
{*                     | AF - Ag. Faturamento           | ER - Equipamento Retirado        *}
{*                     | NF - OS Não Faturada           | ER - Equipamento Retirado        *}
{*                     | OB - OS Baixada - Desistência  | AA - Ag. Armazenamento           *}
{*                     |                                | AR - Ag. Retirada do Equipamento *}
{*                     |                                | ER - Equipamento Retirado        *}
{*-----------------------------------------------------------------------------------------*}
{* F - Faturamento     | FA - Faturado                  | AR - Ag. Retirada do Equipamento *}
{*                     |                                | AA - Ag. Armazenamento           *}
{*                     | NF - OS Não Faturada           | AR - Ag. Retirada do Equipamento *}
{*                     |                                | AA - Ag. Armazenamento           *}
{*-----------------------------------------------------------------------------------------*}
{* C - OS CANCELADA    | CA - CANCELADA                 | CA - CANCELADA                   *} // OBS.: SITUAÇÃO USADA APENAS NO LOG (LOGFLX)
{****************************************************************************************DH*}

unit untConsertoEquipamento;

interface


uses Classes, StrUtils, SysUtils, Uni, UniClientDataSet, UniDataSetProvider, DB, Forms,
  Variants,untAtualizaOcorrenciasCRM, untTypesSistema, untLiberacao, untMsgLiberacao, TypInfo,
  untSaldoLojas, untFuncFatTypes, untFuncFatImp, untConsertoEquipMeqMer, untFuncFat,
  untAuditoriaGravacaoConsertoEquip, Faturamento.Classes.TFatVendaBase;

Type
  TRecSeqInd = Record
    intSeqInd: Integer;
    strCodIte: String;
    fltQtdIte: Double;
    blnGravou: Boolean;
  End;

  TRecPedidos = Record
    strNumPed: String;
    strCodEmp: String;
    strGarant: String;
    strItePed: String;
    strEmpIte: String;
  End;

  TArrPedidos = Array of TRecPedidos;

Type
  EDeletaFATGOR = class(Exception);

  TTribEquGer = Record
    fltBasSim,
    fltBasIpi,
    fltAlqIpi,
    fltTotIpi,
    fltBasIcm,
    fltAlqIcm,
    fltTotIcm,
    fltTotRet,
    fltTotCbs,
    fltTotIbs,
    fltTotIs,
    fltAlqRet,
    fltBasRet,
    fltPerIss,
    fltValIss,
    fltBasIss,
    fltRedIss: Double;
  End;

  TTribEquDet = Record
    strCodIte,
    strClaFis,
    strCodFis,
    strIncPis: String;
    fltValIpi,
    fltAlqIpi,
    fltBasIpi,
    fltValIcm,
    fltAlqIcm,
    fltBasIcm,
    fltValRet,
    fltAlqRet,
    fltBasRet,
    fltValCbs,
    fltValIbs,
    fltVal_Is,
    fltPerBas,
    fltPerRed,
    fltVlrCon,
    fltDesEsp: Double;
  End;

  TTribItensEquDet = Array of TTribEquDet;

  TConEqu = Class(TComponent)
  Private
    FEmpFat: Boolean;
    FOperac: String;
    FUltOpe: String;
    FTemPed: String;

    FAutInc: String;
    FCodEmp: String;
    FNumero: String;
    FDtaEnt: TDateTime;
    FHorEnt: TDateTime;
    FPrevis: TDateTime;
    FCodCli: String;
    FCodCliAnt: String;
    FTabPre: String;
    FEntGer: String;

    FCliNom: String;  //CONSUMIDOR
    FCliEnd: String;  //CONSUMIDOR
    FCliBai: String;  //CONSUMIDOR
    FCliCep: String;  //CONSUMIDOR
    FCodCid: String;  //CONSUMIDOR
    FCliCid: String;  //CONSUMIDOR
    FCliEst: String;  //CONSUMIDOR
    FCliTel: String;  //CONSUMIDOR
    FCgcCpf: Integer; //CONSUMIDOR
    FCliCgc: String;  //CONSUMIDOR
    FCliIes: String;  //CONSUMIDOR
    FCli_Rg: String;  //CONSUMIDOR
    FCliEma: String;  //CONSUMIDOR
    FCodAti: String;  //CONSUMIDOR
    FNasCon: TDate;   //CONSUMIDOR

    FCodTec: String;
    FCodVen: String;
    FCodEqu: String;
    FDescri: String;
    FObsGer: String;
    FObsNFS: String;
    FDisSer: String;
    FMarEqu: String;
    FStaAnt: String;
    FStatus: String;
    FSubSta: String;
    FAg_Mon: Boolean;
    FVlrCon: Double;
    FVlrPro: Double;
    FVlrSer: Double;
    FJaPedi: String;
    FTipPed: String;
    FEmpPed: String;
    FNumPed: String;
    FCliPed: String;
    FDtaPed: String;
    FVenPed: String;
    FValPed: Double;
    FVlrCus: Double;
    FVlrMed: Double;
    FObserv: String;

    FCodIte: String;
    FDesIte: String;
    FDesMar: String;
    FRefere: String;
    FUnidad: String;
    FCodUni: String;
    FQtdIte: Double;
    FUniOri: Double;
    FUniVis: Double;
    FUnitar: Double;
    FTaxJur: Double;
    FPerDes: Double;
    FTotIte: Double;
    FTotCus: Double;
    FValIpi: Double;
    FValRet: Double;
    FValCbs: Double;
    FValIbs: Double;
    FVal_Is: Double;
    FTotIpi: Double;
    FTotRet: Double;
    FTotCbs: Double;
    FTotIbs: Double;
    FTotIs: Double;
    FAguard: String;
    FTabPreIte: String;
    FEntRet: String;
    FEmpIte: String;
    FEmpSer: String;
    FEmpApr: String;
    FLocRet: String;

    FCodSer: String;
    FDesSer: String;
    FValSer: Double;
    FValUni: Double;
    FTecSer: String;
    FQtdSer: Double;

    FCodDfe: String;
    FDesDfe: String;

    FCodAce: String;
    FDesAce: String;
    FQtdAce: Double;

    FDtaIni: TDateTime;
    FDtaFin: TDateTime;
    FPrvIni: TDateTime;
    FPrvFin: TDateTime;
    FPedIni: TDateTime;
    FPedFin: TDateTime;
    FReaIni: TDateTime;
    FReaFin: TDateTime;
    FFatIni: TDateTime;
    FFatFin: TDateTime;

    FCodFor: String;
    FCodFab: String;
    FCodmar: String;
    FEstoqu: String;
    FSaldos: Double;
    FSal_OS: Double;
    FLocFis: String;
    FLocSup: String;
    FCliGar: String;

    FBrinde: String;
    FPromoc: String;
    FCodPar: String;
    FTipBri: String;

    FCliImp,
    FEndImp,
    FBaiImp,
    FCidImp,
    FCepImp,
    FFonImp,
    FTitImp,
    FCodCnd,
    FCodFpg,
    FConPag: String;

    FNSerie: String;
    FAcesso: String;
    FGarant: String;
    FNFComp: String;
    FDtNFCo: TDateTime;
    FRevend: String;
    FConRet: String;
    FDeiPor: String;
    FRetPor: String;
    FReaPor: String;
    FReaTel: String;
    FSitDtr: TDateTime;
    FOsPdCl: String;
    FEntreg: TDateTime;
    FDiaEnt: Integer;
    FRea_RG: String;

    FTemItemAg_Pec: Boolean;

    FCodVe2,
    FCodRep,
    FCodDig: String;

    FLogModificao : Boolean;
    FCdsIteEquLog : TUniClientDataSet;
    FCdsSerEquLog : TUniClientDataSet;
    FCdsDfeEquLog : TUniClientDataSet;
    FCdsAceEquLog : TUniClientDataSet;
    FSubStaAnt    : String;

    FDesEsp   : Double;
    FPorDes   : Double;
    FValDes   : Double;
    FDesEspIte: Double;
    FDesEspSer: Double;

    FDtIniOrc : TDate;
    FHrIniOrc : TTime;
    FOpIniOrc : String;
    FDtFinOrc : TDate;
    FHrFinOrc : TTime;
    FOpFinOrc : String;
    FDtIniMan : TDate;
    FHrIniMan : TTime;
    FOpIniMan : String;
    FDtFinMan : TDate;
    FHrFinMan : TTime;

    FDtRetOrc : TDate;
    FHrRetOrc : TTime;
    FDtRetMan : TDate;
    FHrRetMan : TTime;

    FDtPauMan : TDate;
    FHrPauMan : TTime;
    FDtReManu : TDate;
    FHrReManu : TTime;

    FOpPauOrc : String;
    FOpRetOrc : String;

    FOpFinMan : String;

    FTribEquGer: TTribEquGer;

    FCodTra: String;
    FValFre: Double;
    FEspTra: String;
    FLocFisEqu: String;
    FTipFre: String;
    FQtdTra: Integer;
    FSepImp: String;

    FDtLbEx: TDateTime;
    FHrLbEx: TDateTime;
    FDtBxSe: TDateTime;
    FHrBxSe: TDateTime;
    FOpBxSe: String;

    FPermiteAltDig: Boolean;
    FPermiteAltTec: Boolean;

    FVenPre: Boolean;
    FDigRet: String;

    recSeqIndFATDOR: Array of TRecSeqInd;
    objLiberacao : TLiberacao;

    FCodigoProfissional : string;
    FcdsListaCodigoProfissionais : TUniClientDataSet;
    FcdsMovRcd : TUniClientDataSet;
    FstrInRqCp: string;

    FProtoc: string;
    FCntCli: String;
    FCntTel: String;
    FNumPat: String;
    FDadFab: String;
    FNOSAnt: String;
    FDtEAnt: TDateTime;
    FDtRAnt: TDateTime;
    FCodEpr: String;
    FTmpGar: Integer;
    FFlxFas: String;
    FFlxSit: String;
    FFlxCom: String;
    FPrtAtd: Boolean;
    FNOSFab: String;

    FVlrProOri: Double;
    FVlrSerOri: Double;
    FResSal: Boolean;
    FOSCanc: Boolean;

    FFlxFasAnt: String;
    FFlxSitAnt: String;
    FFlxComAnt: String;

    FCobAPaIte: String;
    FCobAPaSer: String;
    FCobApa: Boolean;
    FNumDocSer: String;
    FNumDocCli: String;

    FNFReme: String;
    FDtNFRe: TDateTime;

    FMulLoj: Boolean;

    FNegociacao: Boolean;

    FrecSaldos,
    FrecSaldosML: TRecSaldos;
    FArrPedidos: TArrPedidos;

    FSeqIte: Integer;
    FAtiCom: String;
    FIteEsp: Boolean;

    FDtaArm: TDateTime;
    FDtTxAr: TDateTime;
    FblnAutDes: Boolean;

    FTipApr: String;
    FEmpFatSemSaldo: String;

    FOri_PD: String;
    FCodFaz: String;
    FFazenda: TDadosFazenda;

    FAudit: IAuditoriaGravacaoConsertoEquip;

    function getDtaFin: String;
    function getDtaIni: String;
    function getPrvIni: String;
    function getPrvFin: String;
    function getPedIni: String;
    function getPedFin: String;
    function getDtaEnt: String;
    function getHorEnt: String;
    function getPrevis: String;

    procedure setDtaFin(const Value: String);
    procedure setDtaIni(const Value: String);
    procedure setPrvIni(const Value: String);
    procedure setPrvFin(const Value: String);
    procedure setPedIni(const Value: String);
    procedure setPedFin(const Value: String);
    procedure setDtaEnt(const Value: String);
    procedure setHorEnt(const Value: String);
    procedure setPrevis(const Value: String);
    procedure setSitEqu(const Value: String);

    procedure pAfterOpenIte(DataSet: TDataSet);
    procedure pAfterOpenSer(DataSet: TDataSet);

    function getSitEqu: String;
    function getFatFin: String;
    function getFatIni: String;
    function getReaFin: String;
    function getReaIni: String;
    procedure setFatFin(const Value: String);
    procedure setFatIni(const Value: String);
    procedure setReaFin(const Value: String);
    procedure setReaIni(const Value: String);

    function fVerificarAlteracoesItem: TRegistroMsgLiberaTabela;
    function fVerificarAlteracoesServico: TRegistroMsgLiberaTabela;
    function fVerificarAlteracoesDefeito: TRegistroMsgLiberaTabela;
    function fVerificarAlteracoesAcessorio: TRegistroMsgLiberaTabela;
    procedure pDescreverLogAlteracoesOS;
    function fPossuiItemEspecial: Boolean;
    function fAtualizarDadosServicos: TDadosServicos;

    function fDeletaFATGOR(strNumDoc,
                           strEspDoc,
                           strCodEmp : String;
                           strCodCli : String = '';
                           dtaDtaEnt : TDateTime = 0;
                           blnEstorn : Boolean = False;
                           strNomeForm: String = '';
                           blnGravarTabDel: Boolean = False) : Boolean;

    function fPodeExcluirItemRequsicaoCompra: Boolean;
    function fQtdTotItem: Double;
    function fDeletarFATDOR(strNumDoc,
                            strEmpPed: String;
                            strCodCli: String = '';
                            dtaDtaPed: TDateTime = 0;
                            blnEstorn: Boolean = False;
                            strNomeForm: String = '';
                            blnGravarTabDel: Boolean = False): Boolean;
    function fCarregaRecServicos(strCliente, strCobAPa: String): TDadosServicos;
    procedure pBaixaPedidoBrinde(strNumDoc, strEspDoc, strCodEmp, strMotAju: String);
    function fValorCobAParte(strCobAPa: String): Double;
    procedure pCarregaNumDocEQUGOR;
    function fVerificaItensServicosCobAParte: Boolean;
    procedure pGravarOrdemMaoObraCli(strSeqFGO: String);
    procedure pCarregaEmpIte(var cdsEmpIte: TUniClientDataSet);
    procedure pDeletaPedidos(strNumDoc: String);
    function fVerificaPedExistente(cdsEmpIte: TDataSet; strEmpIte: String = ''): Boolean;
    function fGetNumPed(strEmpIte, strGarant, strItePed: String): String; overload;
    function fGetNumPed(strEmpIte: String): String; overload;
    procedure pCriaCdsDocGer;
    procedure pIncluirDocumentoCdsDocGer(cdsDocs: TDataSet; documento: TDadosImpressaoVenda; strCodEmp, strEmpIte: String);
    function fGerDesEsp: Double;
    function fNumLoteGeraPedido: String;
    function fDefineTipPed: String;
    function fTemStatusFluxoPreenchido: Boolean;
    function fEhOSOriginadaDePedido: Boolean;
  Public

    qryEquGer: TUniQuery;
    qryEquDet: TUniQuery;
    qryEquSer: TUniQuery;
    qryEquDfe: TUniQuery;
    qryEquAce: TUniQuery;
    qryEquApo: TUniQuery;
    qryRelatorio: TUniQuery;

    cdsIteEqu  : TUniClientDataSet;
    cdsSerEqu  : TUniClientDataSet;
    cdsDfeEqu  : TUniClientDataSet;
    cdsAceEqu  : TUniClientDataSet;
    cdsApoEqu  : TUniClientDataSet;
    cdsGerMOS  : TUniClientDataSet;
    cdsDocGer  : TUniClientDataSet;
    cdsDocGerNeg: TUniClientDataSet;

    objFatVendaImp: TFatVendaImp;
    objFatVendaImpNeg : TFatVendaImp;

    FSituacao : string;
    FStatusDadosAlterado: Boolean;

    property strOperac: String Read FOperac Write FOperac;
    property strUltOpe: String Read FUltOpe Write FUltOpe;
    property strTemPed: String Read FTemPed Write FTemPed;

    property strAutInc: String Read FAutInc Write FAutInc;
    property strCodEmp: String Read FCodEmp Write FCodEmp;
    property strNumero: String Read FNumero Write FNumero;
    property strDtaEnt: String Read getDtaEnt Write setDtaEnt;
    property strHorEnt: String Read getHorEnt Write setHorEnt;
    property strPrevis: String Read getPrevis Write setPrevis;
    property strCodCli: String Read FCodCli Write FCodCli;
    property strCodCliAnt: String Read FCodCliAnt Write FCodCliAnt;
    property strTabPre: String Read FTabPre Write FTabPre;
    property strEntGer: String Read FEntGer Write FEntGer;

    {****************************}
    {* DADOS CLIENTE CONSUMIDOR *}
    {*************************JC*}
    property strCliNom: String Read FCliNom Write FCliNom;
    property strCliEnd: String Read FCliEnd Write FCliEnd;
    property strCliBai: String Read FCliBai Write FCliBai;
    property strCliCep: String Read FCliCep Write FCliCep;
    property strCodCid: String Read FCodCid Write FCodCid;
    property strCliCid: String Read FCliCid Write FCliCid;
    property strCliEst: String Read FCliEst Write FCliEst;
    property strCliTel: String Read FCliTel Write FCliTel;
    property intCgcCpf: Integer Read FCgcCpf Write FCgcCpf;
    property strCliCgc: String Read FCliCgc Write FCliCgc;
    property strCliIes: String Read FCliIes Write FCliIes;
    property strCli_Rg: String Read FCli_Rg Write FCli_Rg;
    property strCliEma: String Read FCliEma Write FCliEma;
    property strCodAti: String Read FCodAti Write FCodAti;
    property dtaNasCon: TDate  Read FNasCon Write FNasCon;

    property strCodTec: String Read FCodTec Write FCodTec;
    property strCodVen: String Read FCodVen Write FCodVen;
    property strCodEqu: String Read FCodEqu Write FCodEqu;
    property strDescri: String Read FDescri Write FDescri;
    property strObsGer: String Read FObsGer Write FObsGer;
    property strObsNFS: String Read FObsNFS Write FObsNFS;
    property strDisSer: String Read FDisSer write FDisSer;
    property strMarEqu: String Read FMarEqu Write FMarEqu;
    property strObserv: String Read FObserv Write FObserv;
    property strStaAnt: String Read FStaAnt Write FStaAnt;
    property strStatus: String Read FStatus Write FStatus;
    property strSubSta: String Read FSubSta Write FSubSta;
    property strSubStaAnt: String Read FSubStaAnt Write FSubStaAnt;
    property blnAg_Mon: Boolean Read FAg_Mon Write FAg_Mon;
    property fltVlrCon: Double Read FVlrCon Write FVlrCon;
    property fltVlrPro: Double Read FVlrPro Write FVlrPro;
    property fltVlrSer: Double Read FVlrSer Write FVlrSer;
    property strJaPedi: String Read FJaPedi Write FJaPedi;
    property strTipPed: String Read FTipPed Write FTipPed;
    property strEmpPed: String Read FEmpPed Write FEmpPed;
    property strNumPed: String Read FNumPed Write FNumPed;
    property strCliPed: String Read FCliPed Write FCliPed;
    property strDtaPed: String Read FDtaPed Write FDtaPed;
    property strVenPed: String Read FVenPed Write FVenPed;
    property fltValPed: Double Read FValPed Write FValPed;
    property strEmpSer: String Read FEmpSer Write FEmpSer;
    property strEmpApr: String Read FEmpApr Write FEmpApr;

    property strCodIte: String Read FCodIte Write FCodIte;
    property strDesIte: String Read FDesIte Write FDesIte;
    property strDesMar: String Read FDesMar Write FDesMar;
    property strRefere: String Read FRefere Write FRefere;
    property strUnidad: String Read FUnidad Write FUnidad;
    property strCodUni: String Read FCodUni Write FCodUni;
    property fltQtdIte: Double Read FQtdIte Write FQtdIte;
    property fltUniOri: Double Read FUniOri Write FUniOri;
    property fltUniVis: Double Read FUniVis Write FUniVis;
    property fltUnitar: Double Read FUnitar Write FUnitar;
    property fltTaxJur: Double Read FTaxJur Write FTaxJur;
    property fltPerDes: Double Read FPerDes Write FPerDes;
    property fltTotIte: Double Read FTotIte Write FTotIte;
    property fltValIpi: Double Read FValIpi Write FValIpi;
    property fltValRet: Double Read FValRet Write FValRet;
    property fltValCbs: Double Read FValCbs Write FValCbs;
    property fltValIbs: Double Read FValIbs Write FValIbs;
    property fltVal_Is: Double Read FVal_Is Write FVal_Is;
    property fltTotIpi: Double Read FTotIpi Write FTotIpi;
    property fltTotRet: Double Read FTotRet Write FTotRet;
    property fltTotCbs: Double Read FTotCbs Write FTotCbs;
    property fltTotIbs: Double Read FTotIbs Write FTotIbs;
    property fltTotIs: Double Read FTotIs Write FTotIs;
    property fltSaldos: Double Read FSaldos Write FSaldos;
    property fltSal_OS: Double Read FSal_OS Write FSal_OS;
    property fltTotCus: Double Read FTotCus Write FTotCus;
    property strLocFis: String Read FLocFis Write FLocFis;
    property strLocSup: String Read FLocSup Write FLocSup;
    property strAguard: String Read FAguard Write FAguard;
    property strTabPreIte: String Read FTabPreIte Write FTabPreIte;
    property strEntRet: String Read FEntRet Write FEntRet;
    property strEmpIte: String Read FEmpIte Write FEmpIte;
    property strLocRet: String Read FLocRet Write FLocRet;

    property strCodSer: String Read FCodSer Write FCodSer;
    property strDesSer: String Read FDesSer Write FDesSer;
    property fltValSer: Double Read FValSer Write FValSer;
    property fltValUni: Double Read FValUni Write FValUni;
    property strTecSer: String Read FTecSer Write FTecSer;
    property fltQtdSer: Double Read FQtdSer Write FQtdSer;

    property strCodDfe: String Read FCodDfe Write FCodDfe;
    property strDesDfe: String Read FDesDfe Write FDesDfe;

    property strCodAce: String Read FCodAce Write FCodAce;
    property strDesAce: String Read FDesAce Write FDesAce;
    property fltQtdAce: Double Read FQtdAce Write FQtdAce;

    property strDtaIni: String Read getDtaIni Write setDtaIni;
    property strDtaFin: String Read getDtaFin Write setDtaFin;
    property strPrvIni: String Read getPrvIni Write setPrvIni;
    property strPrvFin: String Read getPrvFin Write setPrvFin;
    property strPedIni: String Read getPedIni Write setPedIni;
    property strPedFin: String Read getPedFin Write setPedFin;
    property strReaIni: String Read getReaIni Write setReaIni;
    property strReaFin: String Read getReaFin Write setReaFin;
    property strFatIni: String Read getFatIni Write setFatIni;
    property strFatFin: String Read getFatFin Write setFatFin;
    property strSitEqu: String Read getSitEqu Write setSitEqu;

    property strCodFor: String Read FCodFor Write FCodFor;
    property strCodFab: String Read FCodFab Write FCodFab;
    property strCodMar: String Read FCodMar Write FCodMar;
    property strEstoqu: String Read FEstoqu Write FEstoqu;
    property strCliGar: String Read FCliGar Write FCliGar;

    property strBrinde: String Read FBrinde Write FBrinde;
    property strPromoc: String Read FPromoc Write FPromoc;
    property strCodPar: String Read FCodPar Write FCodPar;
    property strTipBri: String Read FTipBri Write FTipBri;

    property strCliImp: String Read FCliImp Write FCliImp;
    property strEndImp: String Read FEndImp Write FEndImp;
    property strBaiImp: String Read FBaiImp Write FBaiImp;
    property strCidImp: String Read FCidImp Write FCidImp;
    property strCepImp: String Read FCepImp Write FCepImp;
    property strFonImp: String Read FFonImp Write FFonImp;
    property strTitImp: String Read FTitImp Write FTitImp;
    property strCodCnd: String Read FCodCnd Write FCodCnd;
    property strCodFpg: String Read FCodFpg Write FCodFpg;
    property strConPag: String Read FConPag Write FConPag;
    property strNSerie: String Read FNSerie Write FNSerie;
    property strAcesso: String Read FAcesso Write FAcesso;
    property strGarant: String Read FGarant Write FGarant;
    property strNFComp: String Read FNFComp Write FNFComp;
    property dtaDtNFCo: TDatetime Read FDtNFCo Write FDtNFCo;
    property strRevend: String Read FRevend Write FRevend;
    property strConRet: String Read FConRet Write FConRet;
    property strDeiPor: String Read FDeiPor Write FDeiPor;
    property strRetPor: String Read FRetPor Write FRetPor;
    property strReaPor: String Read FReaPor Write FReaPor;
    property strReaTel: String Read FReaTel Write FReaTel;
    property dtaSitDtr: TDateTime Read FSitDtr Write FSitDtr;
    property strOsPdCl: String Read FOsPdCl Write FOsPdCl;
    property dtaEntreg: TDatetime Read FEntreg Write FEntreg;
    property intDiaEnt: Integer Read FDiaEnt Write FDiaEnt;
    property strRea_RG: String Read FRea_RG Write FRea_RG;

    property blnTemItemAg_Pec: Boolean Read FTemItemAg_Pec Write FTemItemAg_Pec;

    property strCodVe2: String Read FCodVe2 Write FCodVe2;
    property strCodRep: String Read FCodRep Write FCodRep;
    property strCodDig: String Read FCodDig Write FCodDig;

    property fltDesEsp: Double Read FDesEsp Write FDesEsp;
    property fltPorDes: Double Read FPorDes Write FPorDes;
    property fltValDes: Double Read FValDes Write FValDes;
    property fltDesEspSer: Double Read FDesEspSer Write FDesEspSer;

    property fltDesEspIte: Double Read FDesEspIte Write FDesEspIte;

    property dtaIniOrc: TDate  Read FDtIniOrc Write FDtIniOrc;
    property hraIniOrc: TTime  Read FHrIniOrc Write FHrIniOrc;
    property opeIniOrc: String Read FOpIniOrc Write FOpIniOrc;
    property dtaFinOrc: TDate  Read FDtFinOrc Write FDtFinOrc;
    property hraFinOrc: TTime  Read FHrFinOrc Write FHrFinOrc;
    property opeFinOrc: String Read FOpFinOrc Write FOpFinOrc;
    property dtaIniMan: TDate  Read FDtIniMan Write FDtIniMan;
    property hraIniMan: TTime  Read FHrIniMan Write FHrIniMan;
    property opeIniMan: String Read FOpIniMan Write FOpIniMan;
    property dtaFinMan: TDate  Read FDtFinMan Write FDtFinMan;
    property hraFinMan: TTime  Read FHrFinMan Write FHrFinMan;

    property dtaRetOrc: TDate  Read FDtRetOrc Write FDtRetOrc;
    property hraRetOrc: TTime  Read FHrRetOrc Write FHrRetOrc;
    property dtaRetMan: TDate  Read FDtRetMan Write FDtRetMan;
    property hraHorMan: TTime  Read FHrRetMan Write FHrRetMan;
    property opePauOrc: String Read FOpPauOrc Write FOpPauOrc;
    property opeRetOrc: String Read FOpRetOrc Write FOpRetOrc;

    property dtaPauMan: TDate  Read FDtPauMan Write FDtPauMan;
    property hraPauMan: TTime  Read FHrPauMan Write FHrPauMan;
    property dtaReManu: TDate  Read FDtReManu Write FDtReManu;
    property hraHoManu: TTime  Read FHrReManu Write FHrReManu;

    property opeFinMan: String Read FOpFinMan Write FOpFinMan;
    property strCodTra: String Read FCodTra   Write FCodTra;
    property fltValFre: Double Read FValFre   Write FValFre;
    property strEspTra: String Read FEspTra   Write FEspTra;
    property strLocFisEqu: String Read FLocFisEqu Write FLocFisEqu;
    property strTipFre: String Read FTipFre   Write FTipFre;
    property intQtdTra: Integer Read FQtdTra  Write FQtdTra;
    property dteDtLbEx: TDateTime Read FDtLbEx Write FDtLbEx;
    property dteHrLbEx: TDateTime Read FHrLbEx Write FHrLbEx;
    property dteDtBxSe: TDateTime Read FDtBxSe Write FDtBxSe;
    property dteHrBxSe: TDateTime Read FHrBxSe Write FHrBxSe;
    property strOpBxSe: String Read FOpBxSe Write FOpBxSe;
    property blnPermiteAltDig: Boolean Read FPermiteAltDig Write FPermiteAltDig;
    property blnPermiteAltTec: Boolean Read FPermiteAltTec Write FPermiteAltTec;
    property blnVenPre: Boolean Read FVenPre Write FVenPre;
    property strProtoc: string Read FProtoc Write FProtoc;
    property strCntCli: String Read FCntCli Write FCntCli;
    property strCntTel: String Read FCntTel Write FCntTel;
    property strNumPat: String Read FNumPat Write FNumPat;
    property strDadFab: String Read FDadFab Write FDadFab;
    property strNOSAnt: String Read FNOSAnt Write FNOSAnt;
    property dtaDtEAnt: TDateTime Read FDtEAnt Write FDtEAnt;
    property dtaDtRAnt: TDateTime Read FDtRAnt Write FDtRAnt;
    property strCodEpr: String Read FCodEpr Write FCodEpr;
    property intTmpGar: Integer Read FTmpGar Write FTmpGar;
    property strFlxFas: String Read FFlxFas Write FFlxFas;
    property strFlxSit: String Read FFlxSit Write FFlxSit;
    property strFlxCom: String Read FFlxCom Write FFlxCom;
    property blnPrtAtd: Boolean Read FPrtAtd Write FPrtAtd;
    property strNOSFab: String Read FNOSFab Write FNOSFab;
    property blnResSal: Boolean Read FResSal Write FResSal;

    property CodigoProfissional       : string            read FCodigoProfissional       write FCodigoProfissional;
    property cdsListaCodigoProfissionais : TUniClientDataSet read FcdsListaCodigoProfissionais write FcdsListaCodigoProfissionais;
    property cdsMovRcd : TUniClientDataSet read FcdsMovRcd write FcdsMovRcd;
    property strInRqCp : string read FstrInRqCp write FstrInRqCp;

    property fltVlrProOri: Double Read FVlrProOri Write FVlrProOri;
    property fltVlrSerOri: Double Read FVlrSerOri Write FVlrSerOri;
    property blnOSCancelada: Boolean Read FOSCanc Write FOSCanc;

    property strCobAPaIte: string read FCobAPaIte write FCobAPaIte;
    property strCobAPaSer: string read FCobAPaSer write FCobAPaSer;

    property strNFReme: String Read FNFReme Write FNFReme;
    property dtaDtNFRe: TDatetime Read FDtNFRe Write FDtNFRe;

    property recSaldos: TRecSaldos Read FrecSaldos Write FrecSaldos;
    property recSaldosML: TRecSaldos Read FrecSaldosML Write FrecSaldosML;

    property intSeqIte: Integer read FSeqIte write FSeqIte;
    property blnMulLoj: Boolean Read FMulLoj Write FMulLoj;
    property blnNegociacao: Boolean Read FNegociacao Write FNegociacao;
    property strDigRet: String Read FDigRet Write FDigRet;

    property strAtiCom: String Read FAtiCom Write FAtiCom;
    property blnIteEsp: Boolean Read FIteEsp Write FIteEsp;
    property dtaDtaArm: TDateTime Read FDtaArm Write FDtaArm;
    property dtaDtTxAr: TDateTime Read FDtTxAr Write FDtTxAr;
    property blnAutorizaDescarte: Boolean read FblnAutDes write FblnAutDes;
    property strTipApr: String read FTipApr write FTipApr;
    property strEmpFatSemSaldo: String Read FEmpFatSemSaldo Write FEmpFatSemSaldo;
    property strOri_PD: String read FOri_PD write FOri_PD;
    property strCodFaz: String read FCodFaz write FCodFaz;
    property objFazenda: TDadosFazenda read FFazenda write FFazenda;
    property StatusDadosAlterado: Boolean read FStatusDadosAlterado write FStatusDadosAlterado;

    Constructor Create(Owner: TComponent); Reintroduce;
    Destructor Destroy; override;

    procedure pLimparDadosFiscaisTotais;
    procedure pAdicionarDadosFiscaisItem(recTriItem: TTribEquDet);
    procedure pAdicionarDadosFiscaisTotais(recTribOS: TTribEquGer);
    procedure pAtualizarDadosServicosFatVenda(var recServicos: TDadosServicos);
    procedure fAtualizaSaldos;
    procedure pAtualizaInicioFimOperacoes(intTipo: Integer; blnGeraMensgObsTecnica: Boolean = False;
      dtaOperac: TDateTime = 0; strOperador: String = '');
    procedure pVerificaOperacoes(Var blnTemIniOrc, blnTemFinOrc, blnTemIniMan, blnTemFinMan: Boolean);
    procedure pCriaClientItens; // cria clientdataset para armazenar os itens da ordem de servico
    procedure pCriaClientServico; // cria clientdataset para armazenar os servicos vinculados a ordem de servico
    procedure pCriaClientDefeito; // cria clientdataset para armazenar os defeitos relatados na ordem de serviço
    procedure pCriaClientAcessorio; // cria clientdataset para armazenar os acessórios relatados na ordem de serviço
    procedure pCriaClientApontamentos; // cria clientdataset para exibir os apontamentos de horas
    procedure pAdicionaItem(strTipo: String); // adiciona item
    procedure pIncluiItemGrid;  // inclui item no grid
    procedure pAlteraItemGrid;  // altera item do grid
    procedure pIncluiServicoGrid;  // inclui servico no grid
    procedure pAlteraServicoGrid;  // altera item do grid
    procedure pIncluiDefeitoGrid;  // inclui defeito no grid
    procedure pIncluiAcessorioGrid;  // inclui acessório no grid
    procedure pAlteraAcessorioGrid;  // altera acessório do grid
    function  fItemJaInclusoGrid(strCodIte: String): Boolean; // verifica se o item já está incluso no grid
    function  fDefeitoJaInclusoGrid(strCodDfe: String): Boolean; // verifica se o defeito já está incluso no grid
    function  fAcessorioJaInclusoGrid(strCodAce: String): Boolean; // verifica se o acessório já está incluso no grid
    function  fServicoJaInclusoGrid(strCodSer, strCodTec: String): Boolean; // verifica se o serviço/técnico já está incluso no grid
    function  fVerificaOrdServExiste(strNumOse: String; strCodEmp: String; blnEhRotinaTecnico: Boolean = False): Boolean; // verifica se a ordem de servico já existe
    procedure pLimpaValoresItens; // limpa os valores dos itens
    procedure pCarregaItens; // carrega itens
    procedure pCarregaServicos; // carrega servicos
    procedure pCarregaDefeitos; // carrega defeitos
    procedure pCarregaAcessorios; // carrega acessórios
    procedure pCarregaApontamentos; // carrega apontamentos
    procedure pCarregaGridApo; // carrega grid apontamentos
    procedure pCarregaTela; // dados dos na tela
    procedure pAlteraStatusDados(strNovStatus,
                                 strNovSubStatus: String;
                                 strCodMre: String = '';
                                 blnDelPD: Boolean = False;
                                 strRetPor: String = '';
                                 strOsPdCl: String = '';
                                 strReaPor: String = '';
                                 strReaTel: string = '';
                                 dtaSitDtr: TDateTime = 0;
                                 strRea_RG: String = '';
                                 blnFluPro: Boolean = False;
                                 blnLimMan: Boolean = False;
                                 blnLimMRe: Boolean = False); // altera o status da ordem de servico

    function fStatusToSituacaoEquipamento(strStatus, strSubStatus : String) : String;

    procedure pAlteraStatusAguardandoMontagem;
    procedure pAlteraStatusPeca(strCodIte, strAguard: String);
    function  fVerificaRealizacao(objTabela : TRegistroMsgLiberaTabela): Boolean; // verifica se o ordem de servico pode ser realizada - estoque
    function  fVerificaEstoqueItem(strCodigo, strEmpIte: String; fltQtdNec: Double; objLinha : TLinhaMsgLibera): Boolean; // verifica se os itens tem estoque
    function fGeraPedidoVenda(Var strNumDoc: String; blnAtualizaPed: Boolean; strEmpIte: String = ''): Boolean; // gera o pedido de venda apartir da ordem de servico
    procedure pMarcaNumeroPedidoVenda(strNumDoc: String; blnLimParDadosPed: Boolean); //Marca o numero do pedido de venda gerado
    procedure pCarregaCustoPreMed(strEstado: String); // carrega informacoes dos itens necessarias para gravar o pedido
    procedure pCarregarCliente(qryCliente: TUniQuery; strCliente: String; blnAtualizaDados: Boolean);
    function fCancelaOrdServico(strNomeForm: String): Boolean; // cancela/apaga uma ordem de servico - desde que nao tenha sido gerado pedido ainda
    function  fRetornaSaldoDisponivel(strCodIte, strEmpIte: String; out fltSaldoDisp, fltSalResTot: Double): Double; // Retorna o saldo do item menos o saldo reservado
    Function fRetornaLocFis_LocSup(strCodIte, strEmpIte: String; out strLocFis, strLocSup: String): boolean; // Retorna Localização Física
    function fRetPreVen(strCodIte, strTabPrecos: String; Var strPromoc : String): Double;
    procedure pRecalculaPrecos(strTabPrecos: String; strCodIte: String = ''; blnTrocouCondPag: Boolean = False; blnManterPrecoDigitado: Boolean = False);

    function fGravaEquGer(blnNegociacao: Boolean = False): Boolean;
    function fGravaEquDet: Boolean;
    function fGravaEquSer: Boolean;
    function fGravaEquDfe: Boolean;
    function fGravaEquAce: Boolean;

    function fTitStatus: String;

    function fPodeExcluirItensServicosDefeitos: Boolean;
    function fPodeModificarItensServicosDefeitos: Boolean;
    function fPodeAlterarClienteOrdemServico: Boolean;
    function fPodeCancelarOrdemServicoRealizada: Boolean;
    function fPodeIncluirItemEspecial: Boolean;

    procedure pGravarLogSta(strCodOpe, strStaAnt, strStaAtu, strNumOse, strCodDig: String);

    function fCopiarFieldsDataSet(cdsOrigem: TUniClientDataSet): TUniClientDataSet;

    function fAdicionarObservacao(strMensagem: String): Boolean;
    function fProdutosNaoExpedidos(strNumDoc, strCodEmp, strCodCli: String): Boolean;

    function fPermiteDesvincularNFSaida(objMeqMer: TMeqMer): Boolean;
    function fValidarEstoqueInsuficiente: Boolean;
    procedure pDefinirDtHrLibExp(ADtLbEx, AHrLbEx, ADtBxSe, AHrBxSe: TDateTime; ANumDoc, ACodCli, ACodEmp, AOpBxSe: String);
    function fVerificaAcessoSistemaOS(strDirAce, strObserv, strUsuarioLogado: String): Boolean;
    procedure pCarregarSeqIndFATDOR;
    function fRetSeqInd(strCodIte: String; fltQtdIte: Double): Integer;
    function fPedidoJaFaturado: Boolean;
    function fVerificaValidade: Boolean;

    function fRetArmazemPrincipal(const strCodEmp, strCodIte: String): String;
    function fVerificaLoteItens(const strCodEmp: String): Boolean;

    function fTemItensEntrega: Boolean;
    function fCarregaOSAnt(strCodEqu, strCampo, strValor, strNumOse: String): Boolean;
    function fGravaApontamento(strCodTec, strCodApo, strTipOpe: String): Boolean;
    function fCarregaHistoricoEquip(strNumOse, strCodCli, strCodEqu, strNSerie: String): String;

    function fVerificaExisteNegociacao(blnEmAberto: Boolean = True): String;

    function fVerificaEstoqueItens: Boolean;
    function fDesmembrarItensServicos: Boolean;
    procedure pGravarDesmembramento(strSeqFgo, strSeqEqu, strGarant, strItePed: String; blnMulLoj: Boolean);
    procedure pCriaClientGeracaoMultipasOS; // cria clientdataset para geração de múltiplas OS
    function fGravarNOSFab: Boolean;
    function fVerificaEstoqueItensArmazem: Boolean;
    procedure pGravarLogFlx(blnFluxo: Boolean);
    procedure pCdsDocGerBeforePost(dtsDocGer: TDataSet);
    procedure pAdicionaDocumentoParaImpressao(aFatVenda: TFatVenda; aCodEmp, aEmpIte: String);

    function fCarregaDadosOSAnterior(strNumOse, strCodEqu: String): Boolean;
    procedure pInsereObsTecnicas(const ASitPro: Integer; const ADescri: String);

    class function fRetDadosMeqMer(strAutInc, strCodEmp, strNumero, strTipOpe: String): TMeqMer;
    class function fVinculaOSemNotaFiscal(Var objMeqMer: TMeqMer): Boolean;
    class function fDesvinculaOSemNotaFiscal(objMeqMer: TMeqMer): Boolean;
    class function fDesvinculaNotaFiscalEmOS(objMeqMer: TMeqMer): Boolean;
    class function fNotaEntradaPossuiVinculoOS(strNumDoc, strEspDoc, strSerie, strCodCli, strCodEmp, strTipOpe: String; out strDadosOS: String): Boolean;
    class function fNotaEntradaEquipamentoExiste(strNumDoc, strEspDoc, strSerie, strCliFor, strCodEmp, strTip_FC: String): Boolean;
    class function fItemEquipNotaEntrEmUso(strAutDet: String; Var strConEqu: String): Boolean;
    class function fAtualizarDadosVinculoNotaEntrada(objMeqMer: TMeqMer): Boolean;

    class function VerificaPedidoComRequisicaoEmAbertoComPedidoDeCompra(strNumDoc, strEspDoc, strCodEmp : String; out strCodRcd, strEmpRcd: String; out blnLiberouTrava: Boolean; blnTravar: Boolean = True; strCodIte: String = ''): Boolean;
    class function VerificaPedidoComRequisicaoEmAbertoSemPedidoDeCompra(strNumDoc, strEspDoc, strCodEmp : String; out strCodRcd, strEmpRcd: String; strCodIte: String = ''): Boolean;
  End;

  function fTitStatusExt(strStatus, strSubSta : String): String;
  function fRetPerComissaoMecTecServico(sCodSer : String): Double;
  function fGetValComVendOrdServico(dQtdSer: Double; sCodSer : String): Double;
  function fRetOrdemMaoObra(strNumDoc, strEspDoc, strCodEmp: String): String;

implementation

uses untFatGor, untConstantes, untFuncoesSimples,
     untFuncoesCRM, untFuncoes, untLogGor, Faturamento.Classes.TEmitirPedido,
     untTestabilidade, untIFatReservaSaldo, untTFatReservaSaldo,
     untIFatEntregaFutura, untTFatEntregaFutura, untTFatReprocessarSaldoItem, untCadPro,
     untFuncoesGenerica, DateUtils, untFatManConsertoEquip;

{ TConEqu }

constructor TConEqu.Create(Owner: TComponent);
begin
  inherited Create(Owner);

  FEmpFat := fCfgSis('EMPFAT', varBoolean);

  qryEquGer := fCriaQuery(Self);
  qryEquDet := fCriaQuery(Self);
  qryEquSer := fCriaQuery(Self);
  qryEquDfe := fCriaQuery(Self);
  qryEquAce := fCriaQuery(Self);
  qryEquApo := fCriaQuery(Self);
  qryRelatorio := fCriaQuery(Self);
  objLiberacao := TLiberacao.Create;

  cdsIteEqu := TUniClientDataSet.Create(Self);
  cdsIteEqu.AfterOpen    := pAfterOpenIte;

  cdsSerEqu := TUniClientDataSet.Create(Self);
  cdsSerEqu.AfterOpen := pAfterOpenSer;

  cdsDfeEqu := TUniClientDataSet.Create(Self);
  cdsAceEqu := TUniClientDataSet.Create(Self);
  cdsApoEqu := TUniClientDataSet.Create(Self);
  cdsGerMOS := TUniClientDataSet.Create(Self);

  FVlrPro := 0;
  FVlrCon := 0;
  FVlrSer := 0;
  FSepImp := '0';
  FVenPre := False;
  FPrtAtd := False;
  FResSal := True;
  FOSCanc := False;
  FCobAPa := False;
  FSeqIte := 1;

  pCriaClientItens;
  pCriaClientServico;
  pCriaClientDefeito;
  pCriaClientAcessorio;
  pCriaClientApontamentos;
  pCriaClientGeracaoMultipasOS;
  pCriaCdsDocGer;

  FLogModificao  := False;
  FTemItemAg_Pec := False;
  FEmpFatSemSaldo := '';
  FOri_PD := 'N';
  FCodFaz := '';

  FcdsListaCodigoProfissionais := TUniClientDataSet.Create(Self);
  FcdsMovRcd := TUniClientDataSet.Create(Self);

  FMulLoj := fCfgSis('MLPSOS', varBoolean);
  SetLength(FArrPedidos, 0);

  FAudit := TAuditoriaGravacaoConsertoEquip.New;

  FFazenda := TDadosFazenda.Create;
  FFazenda.pLimparDadosFazenda;
end;

procedure TConEqu.pAtualizaInicioFimOperacoes(intTipo: Integer; blnGeraMensgObsTecnica: Boolean = False;
  dtaOperac: TDateTime = 0; strOperador: String = '');
var
  strUpdate: String;
  qryOperac: TUniQuery;
  dteData, dteHora: TDateTime;
  strOper: String;
begin
  strUpdate := '';
  strUpdate := strUpdate + ' UPDATE EQUGER SET ';

  dteData := IIF(dtaOperac > 0, dtaOperac, VS_Date);
  dteHora := fTime();
  strOper := IIF((not fEmptyStr(strOperador)), strOperador, strLoginUsuarioLogado);

  case intTipo of
    1: begin
         strUpdate := strUpdate + 'EQU_DTINOR = :DATA, ';
         strUpdate := strUpdate + 'EQU_HRINOR = :HORA, ';
         strUpdate := strUpdate + 'EQU_OPINOR = :OPER  ';

         FDtIniOrc := dteData;
         FHrIniOrc := dteHora;
         FOpIniOrc := strOper;
       end;

    2: begin
         strUpdate := strUpdate + 'EQU_DTFIOR = :DATA, ';
         strUpdate := strUpdate + 'EQU_HRFIOR = :HORA, ';
         strUpdate := strUpdate + 'EQU_OPFIOR = :OPER  ';

         FDtFinOrc := dteData;
         FHrFinOrc := dteHora;
         FOpFinOrc := strOper;
       end;

    3: begin
         strUpdate := strUpdate + 'EQU_DTINMA = :DATA, ';
         strUpdate := strUpdate + 'EQU_HRINMA = :HORA, ';
         strUpdate := strUpdate + 'EQU_OPINMA = :OPER  ';

         FDtIniMan := dteData;
         FHrIniMan := dteHora;
         FOpIniMan := strOper;
       end;

    4: begin
         strUpdate := strUpdate + 'EQU_DTFIMA = :DATA, ';
         strUpdate := strUpdate + 'EQU_HRFIMA = :HORA, ';
         strUpdate := strUpdate + 'EQU_OPFIMA = :OPER  ';

         FDtFinMan := dteData;
         FHrFinMan := dteHora;
         FOpFinMan := strOper;
       end;

    5: begin
         strUpdate := strUpdate + 'EQU_DTRORC = :DATA, ';
         strUpdate := strUpdate + 'EQU_HRPORC = :HORA, ';
         strUpdate := strUpdate + 'EQU_OPFIOR = :OPER  ';

         FDtRetOrc := dteData;
         FHrRetOrc := dteHora;
         FOpPauOrc := strOper;
       end;

    6: begin
         strUpdate := strUpdate + 'EQU_DTRMAN = :DATA, ';
         strUpdate := strUpdate + 'EQU_HRPMAN = :HORA, ';
         strUpdate := strUpdate + 'EQU_OPFIOR = :OPER  ';

         FDtRetMan := dteData;
         FHrRetMan := dteHora;
         FOpRetOrc := strOper;
       end;

    7: begin
         strUpdate := strUpdate + 'EQU_DTPAMA = :DATA, ';
         strUpdate := strUpdate + 'EQU_HRPAMA = :HORA, ';
         strUpdate := strUpdate + 'EQU_OPFIOR = :OPER  ';

         FDtPauMan := dteData;
         FHrPauMan := dteHora;
         FOpPauOrc := strOper;
       end;

    8: begin
         strUpdate := strUpdate + 'EQU_DTREMA = :DATA, ';
         strUpdate := strUpdate + 'EQU_HRREMA = :HORA, ';
         strUpdate := strUpdate + 'EQU_OPFIOR = :OPER  ';

         FDtReManu := dteData;
         FHrReManu := dteHora;
         FOpRetOrc := strOper;
       end;

  end;

  strUpdate := strUpdate + ' ,EQU_SITPRO =:SITPRO ';
  strUpdate := strUpdate + ' WHERE AUTOINCREM = :AUTINC ';

  try
    qryOperac := fCriaQuery(Self);

    with qryOperac, SQL do
    begin
      Close;
      Clear;
      Add(strUpdate);

      ParamByName('DATA').AsDateTime := dteData;
      ParamByName('HORA').AsDateTime := dteHora;
      ParamByName('OPER').AsString   := strOper;
      ParamByName('AUTINC').AsString := FAutInc;
      ParamByName('SITPRO').AsString := intToStr(intTipo);

      ExecSQL;

      If (blnGeraMensgObsTecnica) And (intTipo = 2) Then
        Self.fAdicionarObservacao('Finalizar Orçamento' + ' - ' + fRetNomeOperador(strLoginUsuarioLogado));

      If (blnGeraMensgObsTecnica) And (intTipo = 4) Then
        Self.fAdicionarObservacao('Finalizar Manutenção' + ' - ' + fRetNomeOperador(strLoginUsuarioLogado));

      If (blnGeraMensgObsTecnica) And (intTipo = 5) Then
        Self.fAdicionarObservacao('Pausar Orçamento' + ' - ' + fRetNomeOperador(strLoginUsuarioLogado));

      If (blnGeraMensgObsTecnica) And (intTipo = 6) Then
        Self.fAdicionarObservacao('Retornar Orçamento' + ' - ' + fRetNomeOperador(strLoginUsuarioLogado));

      If (blnGeraMensgObsTecnica) And (intTipo = 7) Then
        Self.fAdicionarObservacao('Pausar Manutenção' + ' - ' + fRetNomeOperador(strLoginUsuarioLogado));

      If (blnGeraMensgObsTecnica) And (intTipo = 8) Then
        Self.fAdicionarObservacao('Retornar Manutenção' + ' - ' + fRetNomeOperador(strLoginUsuarioLogado));
    end;
  finally
    FreeAndNil(qryOperac);
  end;
end;

procedure TConEqu.pAfterOpenIte(DataSet: TDataSet);
begin

  With DataSet Do
  Begin
    (FieldByName('QTDITE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
    (FieldByName('QTDITE') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECQTD', varInteger));

    (FieldByName('UNITAR') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    (FieldByName('UNITAR') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECUNI', varInteger));

    (FieldByName('UNIORI') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    (FieldByName('UNIORI') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECUNI', varInteger));

    (FieldByName('UNIVIS') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    (FieldByName('UNIVIS') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECUNI', varInteger));

    (FieldByName('TAXJUR') As TFloatField).DisplayFormat := fMskDigitos(2);
    (FieldByName('TAXJUR') As TFloatField).EditFormat    := fMskDigitos(2);

    (FieldByName('PERDES') As TFloatField).DisplayFormat := fMskDigitos(2);
    (FieldByName('PERDES') As TFloatField).EditFormat    := fMskDigitos(2);

    (FieldByName('TOTCUS') As TFloatField).DisplayFormat := fMskDigitos(2);
    (FieldByName('TOTCUS') As TFloatField).EditFormat    := fMskDigitos(2);

    (FieldByName('PREMED') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
    (FieldByName('PREMED') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECUNI', varInteger));

    (FieldByName('TOTITE') As TFloatField).DisplayFormat := fMskDigitos(2);
    (FieldByName('TOTITE') As TFloatField).EditFormat    := fMskDigitos(2);

    (FieldByName('VALIPI') As TFloatField).DisplayFormat := fMskDigitos(2);
    (FieldByName('VALIPI') As TFloatField).EditFormat    := fMskDigitos(2);

    (FieldByName('VALRET') As TFloatField).DisplayFormat := fMskDigitos(2);
    (FieldByName('VALRET') As TFloatField).EditFormat    := fMskDigitos(2);

    (FieldByName('VALCBS') As TFloatField).DisplayFormat := fMskDigitos(2);
    (FieldByName('VALCBS') As TFloatField).EditFormat    := fMskDigitos(2);

    (FieldByName('VALIBS') As TFloatField).DisplayFormat := fMskDigitos(2);
    (FieldByName('VALIBS') As TFloatField).EditFormat    := fMskDigitos(2);

    (FieldByName('VAL_IS') As TFloatField).DisplayFormat := fMskDigitos(2);
    (FieldByName('VAL_IS') As TFloatField).EditFormat    := fMskDigitos(2);

    (FieldByName('DESESP') As TFloatField).DisplayFormat := fMskDigitos(2);
    (FieldByName('DESESP') As TFloatField).EditFormat    := fMskDigitos(2);
  End;

end;

procedure TConEqu.pAfterOpenSer(DataSet: TDataSet);
begin
  With DataSet Do
  Begin
    (FieldByName('VALSER') As TFloatField).DisplayFormat := fMskDigitos(2);
    (FieldByName('VALSER') As TFloatField).EditFormat    := fMskDigitos(2);

    (FieldByName('VALUNI') As TFloatField).DisplayFormat := fMskDigitos(2);
    (FieldByName('VALUNI') As TFloatField).EditFormat    := fMskDigitos(2);

    (FieldByName('DESESP') As TFloatField).DisplayFormat := fMskDigitos(2);
    (FieldByName('DESESP') As TFloatField).EditFormat    := fMskDigitos(2);

    (FieldByName('PORDES') As TFloatField).DisplayFormat := fMskDigitos(2);
    (FieldByName('PORDES') As TFloatField).EditFormat    := fMskDigitos(2);

    (FieldByName('QTDSER') As TFloatField).DisplayFormat := fMskDigitos(2);
    (FieldByName('QTDSER') As TFloatField).EditFormat    := fMskDigitos(2);
  End;
end;

function TConEqu.getDtaFin: String;
begin
  Result := IfThen(FDtaFin = 0, '', FormatDateTime('dd/mm/yyyy', FDtaFin));
end;

function TConEqu.getDtaIni: String;
begin
  Result := IfThen(FDtaIni = 0, '', FormatDateTime('dd/mm/yyyy', FDtaIni));
end;

function TConEqu.getFatFin: String;
begin
  Result := IfThen(FFatFin = 0, '', FormatDateTime('dd/mm/yyyy', FFatFin));
end;

function TConEqu.getFatIni: String;
begin
  Result := IfThen(FFatIni = 0, '', FormatDateTime('dd/mm/yyyy', FFatIni));
end;

function TConEqu.getPrvIni: String;
begin
  Result := IfThen(FPrvIni = 0, '', FormatDateTime('dd/mm/yyyy', FPrvIni));
end;

function TConEqu.getReaFin: String;
begin
  Result := IfThen(FReaFin = 0, '', FormatDateTime('dd/mm/yyyy', FReaFin));
end;

function TConEqu.getReaIni: String;
begin
  Result := IfThen(FReaIni = 0, '', FormatDateTime('dd/mm/yyyy', FReaIni));
end;

function TConEqu.getSitEqu: String;
begin
  Result := FSituacao;
end;

function TConEqu.getPrvFin: String;
begin
  Result := IfThen(FPrvFin = 0, '', FormatDateTime('dd/mm/yyyy', FPrvFin));
end;

procedure TConEqu.setDtaFin(const Value: String);
begin
  FDtaFin := StrToDateDef(Value, 0);
end;

procedure TConEqu.setDtaIni(const Value: String);
begin
  FDtaIni := StrToDateDef(Value, 0);
end;

procedure TConEqu.setFatFin(const Value: String);
begin
  FFatFin := StrToDateDef(Value, 0);
end;

procedure TConEqu.setFatIni(const Value: String);
begin
  FFatIni := StrToDateDef(Value, 0);
end;

procedure TConEqu.setPrvIni(const Value: String);
begin
  FPrvIni := StrToDateDef(Value, 0);
end;

procedure TConEqu.setReaFin(const Value: String);
begin
  FReaFin := StrToDateDef(Value, 0);
end;

procedure TConEqu.setReaIni(const Value: String);
begin
  FReaIni := StrToDateDef(Value, 0);
end;

procedure TConEqu.setSitEqu(const Value: String);
begin
  FSituacao := Value;
end;

procedure TConEqu.setPrvFin(const Value: String);
begin
  FPrvFin := StrToDateDef(Value, 0);
end;

procedure TConEqu.pCriaClientItens;
Begin
  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'AUTINC';
    DataType := ftString;
    Size := 20;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CLTRIB';
    DataType := ftString;
    Size := 1;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODITE';
    DataType := ftString;
    Size := fTamCodIte;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESITE';
    DataType := ftString;
    Size := 57;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESMAR';
    DataType := ftString;
    Size := 57;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'REFERE';
    DataType := ftString;
    Size := 16;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'UNIDAD';
    DataType := ftString;
    Size := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODUNI';
    DataType := ftString;
    Size := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODGRU';
    DataType := ftString;
    Size := 6;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODMAR';
    DataType := ftString;
    Size := 6;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODFOR';
    DataType := ftString;
    Size := 8;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODFAB';
    DataType := ftString;
    Size := 25;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'BRINDE';
    DataType := ftString;
    Size := 1;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PROMOC';
    DataType := ftString;
    Size := 1;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODPAR';
    DataType := ftString;
    Size := 5;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TIPBRI';
    DataType := ftString;
    Size := 1;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QTDITE';
    DataType := ftFloat;
    Precision := fCfgSis('DECQTD', varInteger);
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'UNITAR';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'UNIORI';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'UNIVIS';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TAXJUR';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PERDES';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTCUS';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PREMED';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTITE';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SALDOS';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SAL_OS';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'LOCFIS';
    DataType := ftString;
    Size := 50;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'LOCSUP';
    DataType := ftString;
    Size := 20;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'AGUARD';
    DataType := ftString;
    Size := 1;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SALDIS';
    DataType := ftString;
    Size := 1;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TABPRE';
    DataType := ftString;
    Size := 1;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMCMP';
    DataType := ftString;
    Size := 15;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NITCMP';
    DataType := ftInteger;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESESP';
    DataType  := ftFloat;
    Precision := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VLRCON';
    DataType  := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CLAFIS';
    DataType := ftString;
    Size := 4;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODFIS';
    DataType := ftString;
    Size := 3;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'INCPIS';
    DataType := ftString;
    Size := 1;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALIPI';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ALQIPI';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'BASIPI';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALICM';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ALQICM';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'BASICM';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALRET';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALCBS';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALIBS';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VAL_IS';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ALQRET';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'BASRET';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PERBAS';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PERRED';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QTDEXP';
    DataType  := ftFloat;
    Precision := 4;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ENTRET';
    DataType := ftString;
    Size := 1;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'COPCFB';
    DataType := ftString;
    Size := 1;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'COPREF';
    DataType := ftString;
    Size := 1;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMLOT';
    DataType := ftString;
    Size := VS_Size_NumLot;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'LOTORI';
    DataType := ftString;
    Size := VS_Size_NumLot;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'COBAPA';
    DataType := ftString;
    Size := 1;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'RESERV';
    DataType := ftString;
    Size := 1;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ABRSAL';
    DataType := ftString;
    Size := 1;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MARDES';
    DataType := ftString;
    Size := 1;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'SEQITE';
    DataType := ftInteger;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'EMPITE';
    DataType := ftString;
    Size := 3;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ATICOM';
    DataType := ftString;
    Size := 1;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ITEESP';
    DataType := ftString;
    Size := 1;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'LOCRET';
    DataType := ftString;
    Size := 2;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTACMP';
    DataType := ftDate;
  End;

  With cdsIteEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'INCORI';
    DataType := ftString;
    Size := 20;
  End;

  cdsIteEqu.CreateDataSet;

  cdsIteEqu.IndexFieldNames := 'SEQITE';

  FCdsIteEquLog := fCopiarFieldsDataSet(cdsIteEqu);
End;

procedure TConEqu.pCriaClientServico;
Begin
  With cdsSerEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'AUTINC';
    DataType := ftString;
    Size := 20;
  End;

  With cdsSerEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODSER';
    DataType := ftString;
    Size := 5;
  End;

  With cdsSerEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESSER';
    DataType := ftString;
    Size := 80;
  End;

  With cdsSerEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALSER';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsSerEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESESP';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsSerEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALUNI';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsSerEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PORDES';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsSerEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TECSER';
    DataType := ftString;
    Size := 3;
  End;

  With cdsSerEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'BRINDE';
    DataType := ftString;
    Size := 1;
  End;

  With cdsSerEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODPAR';
    DataType := ftString;
    Size := 5;
  End;

  With cdsSerEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TIPBRI';
    DataType := ftString;
    Size := 1;
  End;

  With cdsSerEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODDES';
    DataType := ftString;
    Size := 36;
  End;

  With cdsSerEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MARDES';
    DataType := ftInteger;
  End;

  With cdsSerEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'COBAPA';
    DataType := ftString;
    Size := 1;
  End;

  With cdsSerEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QTDSER';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  With cdsSerEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'MAOCLI';
    DataType := ftString;
    Size := 15;
  End;

  cdsSerEqu.CreateDataSet;

  FCdsSerEquLog := fCopiarFieldsDataSet(cdsSerEqu);
End;

procedure TConEqu.pDefinirDtHrLibExp(ADtLbEx, AHrLbEx, ADtBxSe, AHrBxSe: TDateTime; ANumDoc, ACodCli, ACodEmp, AOpBxSe: String);
  Var
    strSQL: String;
    qryTmp: TUniQuery;
begin
  Try
    qryTmp := fCriaQuery();

    Try
      strSQL := '';
      strSQL := strSQL + 'UPDATE     ';
      strSQL := strSQL + '  EXTGOR E ';
      strSQL := strSQL + '  INNER JOIN FATGOR F ON F.AUTOINCREM = E.FGO_SEQFGO ';
      strSQL := strSQL + 'SET      ';
      strSQL := strSQL + '   E.FGO_DTLBEX = :DTLBEX  ';
      strSQL := strSQL + '  ,E.FGO_HRLBEX = :HRLBEX  ';
      strSQL := strSQL + '  ,E.FGO_DTBXSE = :DTBXSE  ';
      strSQL := strSQL + '  ,E.FGO_HRBXSE = :HRBXSE  ';
      strSQL := strSQL + '  ,E.FGO_OPBXSE = :OPBXSE  ';
      strSQL := strSQL + 'WHERE    ';
      strSQL := strSQL + '  F.FGO_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + '  F.FGO_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + '  F.FGO_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '  F.FGO_CODCLI = :CODCLI     ';

      With qryTmp Do Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('NUMDOC').AsString := ANumDoc;
        ParamByName('ESPDOC').AsString := 'PD';
        ParamByName('CODEMP').AsString := ACodEmp;
        ParamByName('CODCLI').AsString := ACodCli;

        If (ADtLbEx > 0) Then
          ParamByName('DTLBEX').AsDateTime := ADtLbEx
        Else
          ParamByName('DTLBEX').Clear();

        If (AHrLbEx > 0) Then
          ParamByName('HRLBEX').AsDateTime := AHrLbEx
        Else
          ParamByName('HRLBEX').Clear();

        If (ADtBxSe > 0) Then
          ParamByName('DTBXSE').AsDateTime := ADtBxSe
        Else
          ParamByName('DTBXSE').Clear();

        If (AHrBxSe > 0) Then
          ParamByName('HRBXSE').AsDateTime := AHrBxSe
        Else
          ParamByName('HRBXSE').Clear();

        If (Not fEmptyStr(AOpBxSe)) Then
          ParamByName('OPBXSE').AsString := AOpBxSe
        Else
          ParamByName('OPBXSE').Clear();

        ExecSQL;
      End;

      pAtualizaBaixaSepExtDor(ADtBxSe, AHrBxSe, ANumDoc, 'PD', ACodCli, ACodEmp, AOpBxSe);
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TConEqu.pDefinirDtHrLibExp]');
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
end;

procedure TConEqu.pDeletaPedidos(strNumDoc: String);
var
  qryFGOEQU: TUniQuery;
begin
  If (FOperac <> 'I') And (Not fEmptyStr(strNumDoc)) Then
  Begin
    qryFGOEQU := fCriaQuery;

    try
      qryFGOEQU.SQL.Text := SELECT_PD_EQUGOR;

      qryFGOEQU.Close;
      qryFGOEQU.ParamByName('SEQEQU').AsString := FAutInc;
      qryFGOEQU.Open;

      if (not qryFGOEQU.IsEmpty) then
      begin
        while not qryFGOEQU.Eof do
        begin
          fDeletarFATDOR(qryFGOEQU.FieldByName('NUMDOC').AsString, qryFGOEQU.FieldByName('CODEMP').AsString,
            '', qryFGOEQU.FieldByName('DTAENT').AsDateTime);

          qryFGOEQU.Next;
        end;
      end
      else
        fDeletarFATDOR(strNumDoc, FEmpPed, '', StrToDate(FDtaPed));
    finally
      FreeAndNil(qryFGOEQU);
    end;
  End;
end;

function TConEqu.fDeletarFATDOR(strNumDoc, strEmpPed: String; strCodCli: String = ''; dtaDtaPed: TDateTime = 0;
  blnEstorn: Boolean = False; strNomeForm: String = ''; blnGravarTabDel: Boolean = False): Boolean;
var
  strSQL: String;
  qryDel,
  qryDor: TUniQuery;
begin
  qryDel := fCriaQuery;
  qryDor := fCriaQuery;

  try
    TLogGor.pLogDel(strNumDoc, 'PD', strEmpPed);

    if blnGravarTabDel then
    begin
      qryDor.SQL.Text := 'SELECT * FROM FATDOR WHERE FDO_CODEMP = :CODEMP AND FDO_NUMDOC = :NUMDOC AND FDO_ESPDOC = "PD" ';
      qryDor.ParamByName('CODEMP').AsString := strEmpPed;
      qryDor.ParamByName('NUMDOC').AsString := strNumDoc;
      qryDor.Open;

      fVerificaIntegridade(strNomeForm, 'FATDOR', qryDor, True);
    end;

    strSQL := '';
    strSQL := strSQL + ' DELETE FROM FATDOR ';
    strSQL := strSQL + ' WHERE FDO_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '     FDO_NUMDOC = :NUMDOC AND ';
    strSQL := strSQL + '     FDO_DTAENT = :DTAPED AND ';
    strSQL := strSQL + '     FDO_ESPDOC = "PD" ';

    qryDel.Close;
    qryDel.SQL.Clear;
    qryDel.SQL.Add(strSQL);
    qryDel.ParamByName('CODEMP').AsString := strEmpPed;
    qryDel.ParamByName('NUMDOC').AsString := strNumDoc;
    qryDel.ParamByName('DTAPED').AsDateTime := dtaDtaPed;
    qryDel.ExecSQL;

    Result := fDeletaFATGOR(strNumDoc, 'PD', strEmpPed, strCodCli, dtaDtaPed, blnEstorn, strNomeForm, blnGravarTabDel);
  finally
    FreeAndNil(qryDel);
    FreeAndNil(qryDor);
  end;
end;

function TConEqu.fDeletaFATGOR(strNumDoc,
                               strEspDoc,
                               strCodEmp : String;
                               strCodCli : String = '';
                               dtaDtaEnt : TDateTime = 0;
                               blnEstorn : Boolean = False;
                               strNomeForm: String = '';
                               blnGravarTabDel: Boolean = False) : Boolean;
var
  LQryDel,
  LQryGor           : TUniQuery;
  blnTransacaoLocal : Boolean;
  blnTemRequisicaoCompra: Boolean;
  blnLiberouTrava: Boolean;
  strCodRcd, strEmpRcd: String;
begin

  Result := False;

  If fEmptyStr(strNumDoc) Or
     fEmptyStr(strEspDoc) Or
     fEmptyStr(strCodEmp) Then
    Exit;

  blnTemRequisicaoCompra := False;
  if blnEstorn then
  begin
    if VerificaPedidoComRequisicaoEmAbertoComPedidoDeCompra(strNumDoc, strEspDoc, strCodEmp, strCodRcd, strEmpRcd, blnLiberouTrava) then
    begin
      if not blnLiberouTrava then
        raise EDeletaFATGOR.Create('Este pedido de venda está vinculado a uma requisição que foi comprada por um ou mais'+
          ' pedido(s) de compra. '+ #13#10+ 'Para baixar o pedido de venda, é necessário solicitar senha de liberação.');

      blnTemRequisicaoCompra := True;
    end
    else
    if VerificaPedidoComRequisicaoEmAbertoSemPedidoDeCompra(strNumDoc, strEspDoc, strCodEmp, strCodRcd, strEmpRcd) then
      blnTemRequisicaoCompra := True;
  end;

  blnTransacaoLocal := False;

  LQryDel := fCriaQuery();
  LQryGor := fCriaQuery();

  Try
    Try
      If Not fInTransaction() Then
      Begin
        fStartTransaction();
        blnTransacaoLocal := True;
      End;

      if blnTemRequisicaoCompra and blnEstorn then
        pExcluiRequisicaoCompra(strCodRcd, strEmpRcd, 'TConEqu.fDeletaFATGOR');

      if blnGravarTabDel then
      begin
        LQryGor.SQL.Text := 'SELECT * FROM FATGOR WHERE FGO_NUMDOC = :NUMDOC AND FGO_ESPDOC = :ESPDOC AND FGO_CODEMP = :CODEMP ';
        LQryGor.ParamByName('NUMDOC').AsString := strNumDoc;
        LQryGor.ParamByName('ESPDOC').AsString := strEspDoc;
        LQryGor.ParamByName('CODEMP').AsString := strCodEmp;
        LQryGor.Open;

        fVerificaIntegridade(strNomeForm, 'FATGOR', LQryGor, True);
      end;

      LQryDel.Close;
      LQryDel.SQL.Clear;
      LQryDel.SQL.Add('DELETE FROM FATGOR ');
      LQryDel.SQL.Add('WHERE  FGO_NUMDOC = :NUMDOC ');
      LQryDel.SQL.Add('AND    FGO_ESPDOC = :ESPDOC ');
      LQryDel.SQL.Add('AND    FGO_CODEMP = :CODEMP ');

      If Not fEmptyStr(strCodCli) Then
        LQryDel.SQL.Add('AND    FGO_CODCLI = :CODCLI ');

      If dtaDtaEnt > 0 Then
        LQryDel.SQL.Add('AND    FGO_DTAENT = :DTAPED ');

      LQryDel.ParamByName('NUMDOC').AsString := strNumDoc;
      LQryDel.ParamByName('ESPDOC').AsString := strEspDoc;
      LQryDel.ParamByName('CODEMP').AsString := strCodEmp;

      If Not fEmptyStr(strCodCli) Then
        LQryDel.ParamByName('CODCLI').AsString := strCodCli;

      If dtaDtaEnt > 0 Then
        LQryDel.ParamByName('DTAPED').AsDateTime := dtaDtaEnt;

      {Reprocessar Saldos}
      TReprocessarSaldoItem.New
        .AddItensDoDocumento(
          TItensReprocessarDoDocumento.New
            .Documento(strNumDoc)
            .Especie(strEspDoc)
            .Empresa(strCodEmp)
          ).NotificarRoboParaReprocessarSaldos;

      LQryDel.ExecSQL;

      If blnTransacaoLocal Then
        fCommit();

      Result := True;
    Except
      If blnTransacaoLocal Then
        fRollBack();

      Raise;
    End;
  Finally
    FreeAndNil(LQryDel);
    FreeAndNil(LQryGor);
  End;
end;

class function TConEqu.fAtualizarDadosVinculoNotaEntrada(objMeqMer: TMeqMer): Boolean;
  Var
    strSQL: String;
    qryTmp: TUniQuery;
begin
  Try
    qryTmp := fCriaQuery;

    Try
      strSQL := ' UPDATE MEQMER SET ';
      strSQL := strSQL + '     MER_AUTDET = :AUTDET, ';
      strSQL := strSQL + '     MER_NCMEQU = :NCMEQU  ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '     AUTOINCREM = :AUTINC  ';

      With qryTmp Do Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('AUTINC').AsString := objMeqMer.strAutInc;

        If Not fEmptyStr(objMeqMer.strAutDet) Then
          ParamByName('AUTDET').AsString := objMeqMer.strAutDet
        Else
          ParamByName('AUTDET').Value    := Null;

        If Not fEmptyStr(objMeqMer.strNCMEqu) Then
          ParamByName('NCMEQU').AsString := objMeqMer.strNCMEqu
        Else
          ParamByName('NCMEQU').Value    := Null;

        ExecSQL;

        Result := RowsAffected > 0;
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro(E.Message, '[TfrmSelecionarNota.fAtualizarDadosVinculoNotaEntrada]');
      End;
    End;
  Finally
    FreeAndNil(qryTmp);
  End;
end;

function TConEqu.fCopiarFieldsDataSet(cdsOrigem: TUniClientDataSet): TUniClientDataSet;
Var
  i: Integer;
begin

  Result := TUniClientDataSet.Create(Self);

  If (Not Assigned(cdsOrigem)) Then
    Exit;

  For i := 0 To cdsOrigem.Fields.Count - 1 Do
  Begin

    With Result.FieldDefs.AddFieldDef Do
    Begin

      Name      := cdsOrigem.Fields[i].FieldName;
      DataType  := cdsOrigem.Fields[i].DataType;
      Required  := False;
      Size      := cdsOrigem.Fields[i].Size;

      If (cdsOrigem.Fields[i].DataType = ftFloat) Then
        Precision := TFloatField(cdsOrigem.Fields[i]).Precision;

    End;

  End;

  Result.CreateDataSet;

end;

procedure TConEqu.pCriaCdsDocGer;
begin
  cdsDocGer := TUniClientDataSet.Create(Self);

  With cdsDocGer, FieldDefs Do
  Begin
    With AddFieldDef Do Begin Name := 'AUTINC'; DataType := ftAutoInc; Required := False; End;
    With AddFieldDef Do Begin Name := 'NUMDOC'; DataType := ftString;  Required := False; End;
    With AddFieldDef Do Begin Name := 'ESPDOC'; DataType := ftString;  Required := False; End;
    With AddFieldDef Do Begin Name := 'CODEMP'; DataType := ftString;  Required := False; End;
    With AddFieldDef Do Begin Name := 'VLRTOT'; DataType := ftFloat;   Required := False; End;
    With AddFieldDef Do Begin Name := 'SERIE_'; DataType := ftString;  Required := False; End;
    With AddFieldDef Do Begin Name := 'CODCLI'; DataType := ftString;  Required := False; End;

    With AddFieldDef Do Begin Name := 'IMPRIM'; DataType := ftBoolean; Required := False; End;
    With AddFieldDef Do Begin Name := 'QTDVIA'; DataType := ftInteger; Required := False; End;
    With AddFieldDef Do Begin Name := 'IMPPRE'; DataType := ftBoolean; Required := False; End;
    With AddFieldDef Do Begin Name := 'IMPTOT'; DataType := ftBoolean; Required := False; End;
    With AddFieldDef Do Begin Name := 'IMPTRM'; DataType := ftBoolean; Required := False; End;

    With AddFieldDef Do Begin Name := 'IMPSEP'; DataType := ftBoolean; Required := False; End;
    With AddFieldDef Do Begin Name := 'SEPVIA'; DataType := ftInteger; Required := False; End;

    With AddFieldDef Do Begin Name := 'LIBPED'; DataType := ftBoolean; Required := False; End;

    With AddFieldDef Do Begin Name := 'PRDAMO'; DataType := ftBoolean; Required := False; End;

    With AddFieldDef Do Begin Name := 'NUMOSE'; DataType := ftString;  Required := False; End;
    With AddFieldDef Do Begin Name := 'EMPOSE'; DataType := ftString;  Required := False; End;
    With AddFieldDef Do Begin Name := 'EMPITE'; DataType := ftString;  Required := False; End;

    CreateDataSet;

    LogChanges := False;

    IndexFieldNames := 'CODEMP';

    Open;

    FieldByName('IMPPRE').Visible := False;
    FieldByName('IMPTOT').Visible := False;
    FieldByName('IMPTRM').Visible := False;

    FieldByName('NUMDOC').Alignment := taCenter;
    FieldByName('ESPDOC').Alignment := taCenter;
    FieldByName('CODEMP').Alignment := taCenter;
    FieldByName('SERIE_').Alignment := taCenter;

    TFloatField(FieldByName('VLRTOT')).DisplayFormat := '###,##0.00';
  End;
end;

procedure TConEqu.pCriaClientAcessorio;
begin
  With cdsAceEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'AUTINC';
    DataType := ftString;
    Size := 20;
  End;

  With cdsAceEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODACE';
    DataType := ftString;
    Size := 5;
  End;

  With cdsAceEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESACE';
    DataType := ftString;
    Size := 40;
  End;

  With cdsAceEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QTDACE';
    DataType := ftFloat;
    Precision := fCfgSis('DECUNI', varInteger);
  End;

  cdsAceEqu.CreateDataSet;

  (cdsAceEqu.FieldByName('QTDACE') As TFloatField).DisplayFormat := fMskDigitos(fCfgSis('DECQTD', varInteger));
  (cdsAceEqu.FieldByName('QTDACE') As TFloatField).EditFormat    := fMskDigitos(fCfgSis('DECQTD', varInteger));

  FCdsAceEquLog := fCopiarFieldsDataSet(cdsAceEqu);
end;

procedure TConEqu.pCriaClientApontamentos;
begin
  cdsApoEqu.FieldDefs.Add('NOMTEC', ftString, 30);
  cdsApoEqu.FieldDefs.Add('FASEAP', ftString, 50);
  cdsApoEqu.FieldDefs.Add('DTAINI', ftString, 16);
  cdsApoEqu.FieldDefs.Add('DTAFIN', ftString, 16);
  cdsApoEqu.FieldDefs.Add('TMPDUR', ftString,  5);
  cdsApoEqu.CreateDataSet;
end;

procedure TConEqu.pCriaClientDefeito;
begin
  With cdsDfeEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'AUTINC';
    DataType := ftString;
    Size := 20;
  End;

  With cdsDfeEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODDFE';
    DataType := ftString;
    Size := 5;
  End;

  With cdsDfeEqu.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESDFE';
    DataType := ftString;
    Size := 40;
  End;

  cdsDfeEqu.CreateDataSet;

  FCdsDfeEquLog := fCopiarFieldsDataSet(cdsDfeEqu);
end;

procedure TConEqu.pCriaClientGeracaoMultipasOS;
begin
  cdsGerMOS.FieldDefs.Add('SEQUEN', ftString, 5);
  cdsGerMOS.FieldDefs.Add('CODEQU', ftString, 48);
  cdsGerMOS.FieldDefs.Add('CODMAR', ftString, 39);
  cdsGerMOS.FieldDefs.Add('NSERIE', ftString, 30);
  cdsGerMOS.FieldDefs.Add('NUMPAT', ftString, 30);
  cdsGerMOS.CreateDataSet;

  cdsGerMOS.IndexFieldNames := 'SEQUEN';
end;

procedure TConEqu.pAdicionaDocumentoParaImpressao(aFatVenda: TFatVenda; aCodEmp, aEmpIte: String);
var
  dadosImpressao: TDadosImpressaoVenda;
begin
  dadosImpressao.strOpcDocTrue := aFatVenda.strOpcDocTrue;
  dadosImpressao.strOpcDoc := aFatVenda.strOpcDoc;
  dadosImpressao.strNumDoc := aFatVenda.strNumDoc;
  dadosImpressao.strEspDoc := aFatVenda.strEspDoc;
  dadosImpressao.strEmpDoc := aFatVenda.strEmpDoc;

  dadosImpressao.strSerFsc := aFatVenda.strSerFsc;
  dadosImpressao.strCodCli := aFatVenda.strCodCli;
  dadosImpressao.strTip_FC := IIF(aFatVenda.fDocumentoParaFornecedor,'F','C');
  dadosImpressao.strCliNom := aFatVenda.strCliNom;
  dadosImpressao.strCliCgc := aFatVenda.strCliCgc;
  dadosImpressao.strCliIes := aFatVenda.strCliIes;
  dadosImpressao.strCli_Rg := aFatVenda.strCli_Rg;
  dadosImpressao.strCliEnd := aFatVenda.strCliEnd;
  dadosImpressao.strCliNum := aFatVenda.strCliNum;
  dadosImpressao.strCliBai := aFatVenda.strCliBai;
  dadosImpressao.strCliCom := aFatVenda.strCliCom;
  dadosImpressao.strCliCep := aFatVenda.strCliCep;
  dadosImpressao.strCliCid := aFatVenda.strCliCid;
  dadosImpressao.strCliEst := aFatVenda.strCliEst;
  dadosImpressao.strCodVen := aFatVenda.strCodVen;
  dadosImpressao.strNomVen := aFatVenda.strNomVen;
  dadosImpressao.strConPag := aFatVenda.strConPag;
  dadosImpressao.strCodCnd := aFatVenda.strCodCnd;
  dadosImpressao.strCodFpg := aFatVenda.strCodFpg;

  dadosImpressao.strEndCob := aFatVenda.strEndCob;
  dadosImpressao.strBaiCob := aFatVenda.strBaiCob;
  dadosImpressao.strCepCob := aFatVenda.strCepCob;
  dadosImpressao.strEstCob := aFatVenda.strEstCob;

  dadosImpressao.strMen001 := aFatVenda.strMen001;
  dadosImpressao.strMen002 := aFatVenda.strMen002;
  dadosImpressao.strMen003 := aFatVenda.strMen003;
  dadosImpressao.strMen004 := aFatVenda.strMen004;
  dadosImpressao.strMen005 := aFatVenda.strMen005;

  dadosImpressao.strNumOrc := aFatVenda.strNumOrc;
  dadosImpressao.strEspOrc := aFatVenda.strEspOrc;
  dadosImpressao.strEmpOrc := aFatVenda.strEmpOri;
  dadosImpressao.strEntFut := aFatVenda.strEntFut;
  dadosImpressao.strEntFat := aFatVenda.strEntFat;
  dadosImpressao.strCodAca := aFatVenda.stlCodAca.CommaText;
  dadosImpressao.strNomImp := aFatVenda.strNomImp;

  dadosImpressao.strDocsConf   :=  aFatVenda.strDocsConf;
  dadosImpressao.strDocsConfTE :=  aFatVenda.strDocsConfTE;
  dadosImpressao.strDocsConfIF :=  aFatVenda.strDocsConfIF;
  dadosImpressao.strCupCon     :=  aFatVenda.strCupCon;
  dadosImpressao.strCupConDev  :=  aFatVenda.strCupConDev;
  dadosImpressao.strCliNFV     :=  aFatVenda.strCliNFV;
  dadosImpressao.strCGCNFV     :=  aFatVenda.strCGCNFV;
  dadosImpressao.strIE_NFV     :=  aFatVenda.strIE_NFV;
  dadosImpressao.strNroNFV     :=  aFatVenda.strNroNFV;
  dadosImpressao.strDtaNFV     :=  aFatVenda.strDtaNFV;
  dadosImpressao.strClaFis     :=  aFatVenda.strClaFis;
  dadosImpressao.fltValNFV     :=  aFatVenda.fltValNFV;
  dadosImpressao.strCodPor     :=  aFatVenda.strCodPor;
  dadosImpressao.blnNotaFatFF  :=  IIF(fEmptyStr(aFatVenda.strPorNotaEspFator), False, True);

  dadosImpressao.strPorBol := aFatVenda.strPorBol;
  dadosImpressao.strBanBol := aFatVenda.strBanBol;
  dadosImpressao.strBcoIni := aFatVenda.strBcoIni;
  dadosImpressao.intCodCar := aFatVenda.intCodCar;
  dadosImpressao.intNosNum := aFatVenda.intNosNum;
  dadosImpressao.fltValMor := aFatVenda.fltValMor;

  dadosImpressao.recEndEnt := aFatVenda.enderecoEntrega;
  dadosImpressao.intQtdTra := aFatVenda.intQtdTra;
  dadosImpressao.fltPesBru := aFatVenda.fltPesBru;
  dadosImpressao.fltPesLiq := aFatVenda.fltPesLiq;
  dadosImpressao.fltTotIcm := aFatVenda.fltTotIcm;
  dadosImpressao.fltTotPro := aFatVenda.fltTotPro;
  dadosImpressao.fltTotGer := aFatVenda.fltTotGer;
  dadosImpressao.fltDesEsp := aFatVenda.fltDesEsp;
  dadosImpressao.fltTotDeb := aFatVenda.fltTotDeb;
  dadosImpressao.fltDupRec := aFatVenda.fltDupRec;

  dadosImpressao.fltValAdt := aFatVenda.fltValAdt;
  dadosImpressao.fltBolAdt := aFatVenda.fltBolAdt;
  dadosImpressao.blnBolVen := aFatVenda.blnBolVen;

  dadosImpressao.fltBolEnv := aFatVenda.fltTotalBoletosAdiantamentoJaEnviados;

  dadosImpressao.fltImpPag := aFatVenda.fltImpPag;
  dadosImpressao.fltPeImPg := aFatVenda.fltPeImPg;
  dadosImpressao.fltFedImp := aFatVenda.fltFedImp;
  dadosImpressao.fltPeImFd := aFatVenda.fltPeImFd;
  dadosImpressao.fltEstImp := aFatVenda.fltEstImp;
  dadosImpressao.fltPeImEs := aFatVenda.fltPeImEs;
  dadosImpressao.fltMunImp := aFatVenda.fltMunImp;
  dadosImpressao.fltPeImMn := aFatVenda.fltPeImMn;

  If (fStatusCndPag(aFatVenda.strConPag) = A_VISTA) Then
    dadosImpressao.fltTotDeb := dadosImpressao.fltTotDeb - aFatVenda.fltTotGer;

  dadosImpressao.arrMatItens := aFatVenda.arrMatItens;
  dadosImpressao.blnEntregaImediataEmNovoPedido := aFatVenda.blnEntregaImediataEmNovoPedido;
  dadosImpressao.blnEmitirNovoPedidoEntregaCD   := aFatVenda.blnEmitirNovoPedidoEntregaCD;
  dadosImpressao.blnRetiraOutraLojaEmNovoPedido := aFatVenda.blnRetiraOutraLojaEmNovoPedido;
  dadosImpressao.blnRetiraExpedicaoEmNovoPedido := aFatVenda.blnRetiraExpedicaoEmNovoPedido;

  dadosImpressao.blnConfOrcamento := aFatVenda.blnConfOrcamento;
  dadosImpressao.blnImportacaoSpedPisCofins := aFatVenda.blnImportacaoSpedPisCofins;

  dadosImpressao.blnExpedi := aFatVenda.blnExpedi;
  dadosImpressao.blnEnt_CD := aFatVenda.blnEnt_CD;
  dadosImpressao.opcComSemPreco := aFatVenda.opcComSemPreco;
  dadosImpressao.blnValTot := aFatVenda.blnValTot;
  dadosImpressao.blnPedBlo := aFatVenda.fPedidoBloqueado;
  dadosImpressao.blnGerNfe := aFatVenda.blnGerNfe;
  dadosImpressao.strPonImp := aFatVenda.strPonImp;
  dadosImpressao.blnPedPen := aFatVenda.fPedidoPendente;
  dadosImpressao.blnMenFor := aFatVenda.blnMenFor;
  dadosImpressao.blnLibCnf := aFatVenda.blnLibCnf;
  dadosImpressao.blnNotEsp := aFatVenda.blnNotEsp;
  dadosImpressao.blnMeiaNota := aFatVenda.blnMeiaNota;
  dadosImpressao.blnBaiEntFut := aFatVenda.blnBaiEntFut;
  dadosImpressao.blnBaixaEmprestimos := aFatVenda.blnBaixaEmprestimos;

  dadosImpressao.blnImpReq := aFatVenda.blnImpReq;
  dadosImpressao.blnImprimeSep := True;

  If (dadosImpressao.blnImprimeSep) Then
  Begin
    {**************************************************}
    {* CASO SEJA UM DOCUMENTO QUE SÓ POSSUA SERVIÇOS, *}
    {* NÃO IMPRIME SEPARAÇÃO.                         *}
    {***********************************************PZ*}
    If (aFatVenda.fltTotPro = 0) And (aFatVenda.fltTotSer > 0) Then
      dadosImpressao.blnImprimeSep := False;
  End;

  dadosImpressao.blnImpSepGarantia := aFatVenda.blnImpSepGarantia;
  dadosImpressao.blnImprimeTicketIF := aFatVenda.blnImprimeTicketIF;
  dadosImpressao.blnImprimeEtiqDespacho := aFatVenda.blnImprimeEtiqDespacho;

  dadosImpressao.Profissionais := aFatVenda.fGetProfissionaisVenda;

  aFatVenda.pCriaCdsLogItensSep;
  aFatVenda.pInsereTodosItensNoCdsLogItensSep;

  If Assigned(aFatVenda.cdsLogItensSep) Then
    dadosImpressao.cdsLogSep := aFatVenda.cdsLogItensSep;

  If assigned(dadosImpressao.cdsLogSep) Then
    dadosImpressao.cdsLogSep.Open;

  dadosImpressao.dtaDtaEnt := aFatVenda.dtaDtaEnt;
  dadosImpressao.strHorEnt := aFatVenda.strHorSai;
  dadosImpressao.objFatVenda := aFatVenda;
  dadosImpressao.blnPedOrcBrinde := aFatVenda.fEmissaoPedidoBrinde();
  dadosImpressao.strImportacaoGeoSales := IIF(aFatVenda.blnImportacaoGeoSales, 'S', 'N');

  {*******************************************************************}
  {* adiciona o documento para exibir ou imprimir no caso de pedidos *}
  {****************************************************************DH*}
  if (not FNegociacao) then
  begin
    objFatVendaImp.Add(dadosImpressao);
    pIncluirDocumentoCdsDocGer(cdsDocGer, dadosImpressao, aCodEmp, aEmpIte);
  end
  else
  begin
    objFatVendaImpNeg.Add(dadosImpressao);
    pIncluirDocumentoCdsDocGer(cdsDocGerNeg, dadosImpressao, aCodEmp, aEmpIte);
  end;
end;

procedure TConEqu.pAdicionaItem(strTipo: String);
begin
  {**********************************************}
  {* VERIFICA SE O ITEM JÁ ESTA INCLUSO NO GRID *}
  {*******************************************LU*}
  If (strTipo = 'I') Then
    pIncluiItemGrid
  Else
    pAlteraItemGrid;
end;

procedure TConEqu.pIncluiAcessorioGrid;
begin
  cdsAceEqu.Append;
  cdsAceEqu.FieldByName('AUTINC').AsString := '';
  cdsAceEqu.FieldByName('CODACE').AsString := FCodAce;
  cdsAceEqu.FieldByName('DESACE').AsString := FDesAce;
  cdsAceEqu.FieldByName('QTDACE').AsFloat  := FQtdAce;
  cdsAceEqu.Post;
end;

procedure TConEqu.pIncluiDefeitoGrid;
begin
  cdsDfeEqu.Append;
  cdsDfeEqu.FieldByName('AUTINC').AsString := '';
  cdsDfeEqu.FieldByName('CODDFE').AsString := FCodDfe;
  cdsDfeEqu.FieldByName('DESDFE').AsString := FDesDfe;
  cdsDfeEqu.Post;
end;

procedure TConEqu.pIncluiItemGrid;
Begin

  if not fRetornaLocFis_LocSup(FCodIte, FEmpIte, FLocFis, FLocSup) then
  begin
    FLocFis := '';
    FLocSup  := '';
  end;

  cdsIteEqu.Append;
  cdsIteEqu.FieldByName('AUTINC').AsString := '';
  cdsIteEqu.FieldByName('INCORI').AsString := '';
  cdsIteEqu.FieldByName('CODITE').AsString := FCodIte;
  cdsIteEqu.FieldByName('ENTRET').AsString := FEntRet;
  cdsIteEqu.FieldByName('LOCRET').AsString := FLocRet;
  cdsIteEqu.FieldByName('DESITE').AsString := FDesite;
  cdsIteEqu.FieldByName('DESMAR').AsString := FDesMar;
  cdsIteEqu.FieldByName('REFERE').AsString := FRefere;

  if not fEmptyStr(cdsIteEqu.FieldByName('REFERE').AsString) then
    cdsIteEqu.FieldByName('COPREF').AsString := 'S'
  else
    cdsIteEqu.FieldByName('COPREF').AsString := '';

  cdsIteEqu.FieldByName('UNIDAD').AsString := FUnidad;
  cdsIteEqu.FieldByName('CODUNI').AsString := FCodUni;
  cdsIteEqu.FieldByName('CODGRU').AsString := '';
  cdsIteEqu.FieldByName('CODMAR').AsString := '';
  cdsIteEqu.FieldByName('CODFOR').AsString := '';
  cdsIteEqu.FieldByName('CODFAB').AsString := fRetCodFabrica(FCodIte);

  if not fEmptyStr(cdsIteEqu.FieldByName('CODFAB').AsString) then
    cdsIteEqu.FieldByName('COPCFB').AsString := 'S'
  else
    cdsIteEqu.FieldByName('COPCFB').AsString := '';

  cdsIteEqu.FieldByName('CODFIS').AsString := '';
  cdsIteEqu.FieldByName('QTDITE').AsFloat  := FQtdIte;
  cdsIteEqu.FieldByName('UNITAR').AsFloat  := FUnitar;
  cdsIteEqu.FieldByName('UNIORI').AsFloat  := FUniOri;
  cdsIteEqu.FieldByName('UNIVIS').AsFloat  := FUniVis;
  cdsIteEqu.FieldByName('TAXJUR').AsFloat  := FTaxJur;
  cdsIteEqu.FieldByName('PERDES').AsFloat  := FPerDes;
  cdsIteEqu.FieldByName('TOTCUS').AsFloat  := FTotCus * FQtdIte;
  cdsIteEqu.FieldByName('PREMED').AsFloat  := 0;
  cdsIteEqu.FieldByName('TOTITE').AsFloat  := FTotIte;
  cdsIteEqu.FieldByName('SALDOS').AsFloat  := FSaldos;
  cdsIteEqu.FieldByName('SAL_OS').AsFloat  := FSal_OS;
  cdsIteEqu.FieldByName('LOCFIS').AsString := FLocFis;
  cdsIteEqu.FieldByName('LOCSUP').AsString := FLocSup;
  cdsIteEqu.FieldByName('AGUARD').AsString := FAguard;
  cdsIteEqu.FieldByName('SALDIS').AsString := FAguard;
  cdsIteEqu.FieldByName('BRINDE').AsString := FBrinde;
  cdsIteEqu.FieldByName('PROMOC').AsString := FPromoc;
  cdsIteEqu.FieldByName('CODPAR').AsString := FCodPar;
  cdsIteEqu.FieldByName('TIPBRI').AsString := FTipBri;
  cdsIteEqu.FieldByName('TABPRE').AsString := FTabPreIte;
  cdsIteEqu.FieldByName('DESESP').AsFloat  := FDesEspIte;
  cdsIteEqu.FieldByName('VLRCON').AsFloat  := FTotIte - FDesEspIte;
  cdsIteEqu.FieldByName('COBAPA').AsString := FCobAPaIte;
  cdsIteEqu.FieldByName('RESERV').AsString := 'S';
  cdsIteEqu.FieldByName('ABRSAL').AsString := 'S';
  cdsIteEqu.FieldByName('MARDES').AsInteger:= 0;
  cdsIteEqu.FieldByName('SEQITE').AsInteger:= FSeqIte;
  cdsIteEqu.FieldByName('EMPITE').AsString := FEmpIte;
  cdsIteEqu.FieldByName('ATICOM').AsString := FAtiCom;
  cdsIteEqu.FieldByName('ITEESP').AsString := IIF(FIteEsp, 'S', 'N');
  cdsIteEqu.Post;
End;

procedure TConEqu.pIncluirDocumentoCdsDocGer(cdsDocs: TDataSet; documento: TDadosImpressaoVenda; strCodEmp, strEmpIte: String);
var
  LstrPrgPor: String;
Begin
  LstrPrgPor := fCfgSis('PRGPOR');

  cdsDocs.Insert;
  cdsDocs.FieldByName('NUMDOC').AsString := documento.strNumDoc;
  cdsDocs.FieldByName('ESPDOC').AsString := documento.strEspDoc;
  cdsDocs.FieldByName('CODEMP').AsString := documento.strEmpDoc;
  cdsDocs.FieldByName('VLRTOT').AsFloat  := documento.fltTotGer;
  cdsDocs.FieldByName('SERIE_').AsString := documento.strSerFsc;
  cdsDocs.FieldByName('CODCLI').AsString := documento.strCodCli;
  cdsDocs.FieldByName('PRDAMO').AsBoolean := documento.blnImprimeAmostraVeiculo;
  cdsDocs.FieldByName('QTDVIA').AsInteger := fCfgSis('VIA_PD', varInteger, strCodEmp);
  cdsDocs.FieldByName('IMPRIM').AsBoolean := (cdsDocs.FieldByName('QTDVIA').AsInteger > 0) And
                                     (Not documento.blnEntregaImediataEmNovoPedido) And
                                     (Not documento.blnRetiraOutraLojaEmNovoPedido) And
                                     (Not documento.blnRetiraExpedicaoEmNovoPedido);

  cdsDocs.FieldByName('IMPPRE').Visible := fCfgSis('ORCSPR', varBoolean, strCodEmp);
  cdsDocs.FieldByName('IMPTOT').Visible := fCfgSis('ORCSPR', varBoolean, strCodEmp);

  cdsDocs.FieldByName('LIBPED').AsBoolean := fCfgSis('LIBPED', varBoolean, strCodEmp);
  cdsDocs.FieldByName('IMPSEP').AsBoolean := objFatVendaImp.fVerificaSeImprimeSeparacao(documento);
  cdsDocs.FieldByName('SEPVIA').AsInteger := fCfgSis('QTDVSE', varInteger, strCodEmp);
  cdsDocs.FieldByName('IMPPRE').AsBoolean := True;
  cdsDocs.FieldByName('IMPTOT').AsBoolean := True;
  cdsDocs.FieldByName('IMPTRM').Visible   := ((LstrPrgPor = '1') or (LstrPrgPor = '3'));
  cdsDocs.FieldByName('IMPTRM').AsBoolean := cdsDocs.FieldByName('IMPTRM').Visible;
  cdsDocs.FieldByName('NUMOSE').AsString := FNumero;
  cdsDocs.FieldByName('EMPOSE').AsString := FCodEmp;
  cdsDocs.FieldByName('EMPITE').AsString := strEmpIte;
  cdsDocs.Post;
end;

procedure TConEqu.pAlteraAcessorioGrid;
begin
  cdsAceEqu.Edit;
  cdsAceEqu.FieldByName('CODACE').AsString := FCodAce;
  cdsAceEqu.FieldByName('DESACE').AsString := FDesAce;
  cdsAceEqu.FieldByName('QTDACE').AsFloat  := FQtdAce;
  cdsAceEqu.Post;
end;

procedure TConEqu.pAlteraItemGrid;
Begin
  cdsIteEqu.Edit;
  cdsIteEqu.FieldByName('ENTRET').AsString := FEntRet;
  cdsIteEqu.FieldByName('LOCRET').AsString := FLocRet;
  cdsIteEqu.FieldByName('DESITE').AsString := FDesIte;
  cdsIteEqu.FieldByName('UNIDAD').AsString := FUnidad;
  cdsIteEqu.FieldByName('CODUNI').AsString := FCodUni;
  cdsIteEqu.FieldByName('TOTCUS').AsFloat  := FTotCus * FQtdIte;
  cdsIteEqu.FieldByName('QTDITE').AsFloat  := FQtdIte;
  cdsIteEqu.FieldByName('UNITAR').AsFloat  := FUnitar;
  cdsIteEqu.FieldByName('UNIORI').AsFloat  := FUniOri;
  cdsIteEqu.FieldByName('UNIVIS').AsFloat  := FUniVis;
  cdsIteEqu.FieldByName('TAXJUR').AsFloat  := FTaxJur;
  cdsIteEqu.FieldByName('PERDES').AsFloat  := FPerDes;
  cdsIteEqu.FieldByName('TOTITE').AsFloat  := FTotIte;
  cdsIteEqu.FieldByName('LOCFIS').AsString := FLocFis;
  cdsIteEqu.FieldByName('LOCSUP').AsString := FLocSup;
  cdsIteEqu.FieldByName('AGUARD').AsString := FAguard;
  cdsIteEqu.FieldByName('SALDIS').AsString := FAguard;
  cdsIteEqu.FieldByName('BRINDE').AsString := FBrinde;
  cdsIteEqu.FieldByName('PROMOC').AsString := FPromoc;
  cdsIteEqu.FieldByName('CODPAR').AsString := FCodPar;
  cdsIteEqu.FieldByName('TIPBRI').AsString := FTipBri;
  cdsIteEqu.FieldByName('TABPRE').AsString := FTabPreIte;
  cdsIteEqu.FieldByName('DESESP').AsFloat  := FDesEspIte;
  cdsIteEqu.FieldByName('VLRCON').AsFloat  := FTotIte - FDesEspIte;
  cdsIteEqu.FieldByName('COBAPA').AsString := FCobAPaIte;
  cdsIteEqu.FieldByName('EMPITE').AsString := FEmpIte;
  cdsIteEqu.FieldByName('ATICOM').AsString := FAtiCom;
  cdsIteEqu.FieldByName('ITEESP').AsString := IIF(FIteEsp, 'S', 'N');
  cdsIteEqu.Post;
End;

procedure TConEqu.pIncluiServicoGrid;
Begin
  cdsSerEqu.Append;
  cdsSerEqu.FieldByName('AUTINC').AsString := '';
  cdsSerEqu.FieldByName('CODSER').AsString := FCodSer;
  cdsSerEqu.FieldByName('DESSER').AsString := FDesSer;
  cdsSerEqu.FieldByName('TECSER').AsString := FTecSer;
  cdsSerEqu.FieldByName('BRINDE').AsString := FBrinde;
  cdsSerEqu.FieldByName('CODPAR').AsString := FCodPar;
  cdsSerEqu.FieldByName('TIPBRI').AsString := FTipBri;
  cdsSerEqu.FieldByName('PORDES').AsFloat  := FPorDes;
  cdsSerEqu.FieldByName('VALUNI').AsFloat  := FValUni;
  cdsSerEqu.FieldByName('DESESP').AsFloat  := FValSer * (FPorDes / 100);
  cdsSerEqu.FieldByName('VALSER').AsFloat  := FValSer * (1 - (FPorDes / 100));
  cdsSerEqu.FieldByName('CODDES').AsString := FTecSer + ' - ' + fRetNomeOperador(FTecSer);
  cdsSerEqu.FieldByName('COBAPA').AsString := FCobAPaSer;
  cdsSerEqu.FieldByName('QTDSER').AsFloat  := FQtdSer;
  cdsSerEqu.Post;
End;

procedure TConEqu.pInsereObsTecnicas(const ASitPro: Integer; const ADescri: String);
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery(Self);

  try
    LQry.SQL.Add('INSERT INTO EQUOBT ');
    LQry.SQL.Add('  (AUTOINCREM, EQU_SEQGER, EQU_CODEMP, EQU_DTAENT, EQU_HORENT, EQU_CODOPE, EQU_SITPRO, EQU_DESCRI) ');
    LQry.SQL.Add('VALUES ');
    LQry.SQL.Add('  (:AUTINC, :SEQGER, :CODEMP, :DTAENT, :HORENT, :CODOPE, :SITPRO, :DESCRI) ');

    LQry.ParamByName('AUTINC').AsString   := fRetAutoIncrem('EQUOBT', VS_strCodEmp);
    LQry.ParamByName('SEQGER').AsString   := FAutInc;
    LQry.ParamByName('CODEMP').AsString   := VS_strCodEmp;
    LQry.ParamByName('DTAENT').AsDatetime := VS_Date;
    LQry.ParamByName('HORENT').AsDatetime := fTime();
    LQry.ParamByName('CODOPE').AsString   := strLoginUsuarioLogado;
    LQry.ParamByName('SITPRO').AsInteger  := ASitPro;
    LQry.ParamByName('DESCRI').AsString   := ADescri;
    LQry.ExecSQL;
  finally
    FreeAndNil(LQry);
  end;
end;

class function TConEqu.fItemEquipNotaEntrEmUso(strAutDet: String; Var strConEqu: String): Boolean;
const
  strSQL = 'FROM MEQMER ' +
           'INNER JOIN EQUGER ON MER_AUTEQU = EQUGER.AUTOINCREM ' +
           'WHERE MER_AUTDET = :AUTDET ' +
           '  AND EQU_STATUS <> "N" ';
var
  intQtdeTotal, intQtdeUtilizado: integer;
  qryAux: TUniQuery;
begin
  qryAux := fCriaQuery;

  try
    if fCfgSis('ENTEQU', varString) = 'A' then
    begin
      intQtdeTotal := fCampoTabela('CAST(DET_QTDITE AS SIGNED) AS QTD', 'MOVDET', ['AUTOINCREM'], [strAutDet]);

      qryAux.SQL.Add('SELECT COUNT(1) AS QTD ');
      qryAux.SQL.Add(strSQL);
      qryAux.ParamByName('AUTDET').AsString := strAutDet;
      qryAux.Open;

      intQtdeUtilizado := qryAux.FieldByName('QTD').AsInteger;

      if (intQtdeTotal - intQtdeUtilizado) <= 0 then
        strConEqu := '0';
    end
    else
    begin
      qryAux.SQL.Add('SELECT CONCAT(MER_NUMOSE, "-", MER_EMPEQU) AS NUMOSE ');
      qryAux.SQL.Add(strSQL);
      qryAux.ParamByName('AUTDET').AsString := strAutDet;
      qryAux.Open;

      strConEqu := qryAux.FieldByName('NUMOSE').AsString;
    end;
  finally
    FreeAndNil(qryAux);
  end;

  Result := (Not fEmptyStr(strConEqu));
end;

function TConEqu.fItemJaInclusoGrid(strCodIte: String): Boolean;
begin
  Result := False;

  If fIsItemEspecial(strCodIte) Then
    Exit;

  If Assigned(cdsIteEqu) Then
  Begin
    cdsIteEqu.First;
    While Not cdsIteEqu.Eof Do
    Begin

      If (cdsIteEqu.FieldByName('CODITE').AsString = strCodIte) Then
      Begin
        Result := True;
        Exit;
      End;

      cdsIteEqu.Next;
    End;
  End;

end;

class function TConEqu.fNotaEntradaEquipamentoExiste(strNumDoc, strEspDoc,
  strSerie, strCliFor, strCodEmp, strTip_FC: String): Boolean;
  Var
    strAutinc: String;
begin
  strAutinc := fCampoTabela('AUTOINCREM',
                             'MOVGER',
                             ['GER_NUMDOC',
                               'GER_ESPDOC',
                               'GER_SERIE_',
                               IIF(strTip_FC = 'C', 'GER_CODCLI', 'GER_CODFOR'),
                               'GER_CODEMP',
                               'GER_TIP_FC'],
                             [strNumDoc,
                               strEspDoc,
                               strSerie,
                               strCliFor,
                               strCodEmp,
                               strTip_FC]);

  Result := (Not fEmptyStr(strAutinc));
end;

class function TConEqu.fNotaEntradaPossuiVinculoOS(strNumDoc, strEspDoc,
  strSerie, strCodCli, strCodEmp, strTipOpe: String; out strDadosOS: String): Boolean;
begin
  strDadosOS := fCampoTabela('CONCAT(MER_NUMOSE, "-", MER_EMPEQU)',
                             'MEQMER',
                             ['MER_NUMDOC',
                               'MER_ESPDOC',
                               'MER_SERIE_',
                               'MER_CODCLI',
                               'MER_EMPGER',
                               'MER_TIPOPE'],
                             [strNumDoc,
                               strEspDoc,
                               strSerie,
                               strCodCli,
                               strCodEmp,
                               strTipOpe]);

  Result := (Not fEmptyStr(strDadosOS));
end;

function TConEqu.fNumLoteGeraPedido: String;
begin
  if (not fEmptyStr(cdsIteEqu.FieldByName('NUMLOT').AsString)) then
  begin
    Result := cdsIteEqu.FieldByName('NUMLOT').AsString;
    Exit;
  end;

  Result := fRetArmazemPrincipal(IIF(FMulLoj, cdsIteEqu.FieldByName('EMPITE').AsString, FCodEmp), cdsIteEqu.FieldByName('CODITE').AsString);
end;

procedure TConEqu.pVerificaOperacoes(Var blnTemIniOrc, blnTemFinOrc, blnTemIniMan, blnTemFinMan: Boolean);
var
  strSQL   : String;
  qryOperac: TUniQuery;
begin
  blnTemIniOrc := False;
  blnTemFinOrc := False;
  blnTemIniMan := False;
  blnTemFinMan := False;

  strSQL := '';
  strSQL := strSQL + ' SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   IF(EQU_DTINOR IS NULL, 0, 1) AS INIORC, ';
  strSQL := strSQL + '   IF(EQU_DTFIOR IS NULL, 0, 1) AS FINORC, ';
  strSQL := strSQL + '   IF(EQU_DTINMA IS NULL, 0, 1) AS INIMAN, ';
  strSQL := strSQL + '   IF(EQU_DTFIMA IS NULL, 0, 1) AS FINMAN, ';
  strSQL := strSQL + '   EQU_DTINOR, ';
  strSQL := strSQL + '   EQU_HRINOR, ';
  strSQL := strSQL + '   EQU_OPINOR, ';
  strSQL := strSQL + '   EQU_DTFIOR, ';
  strSQL := strSQL + '   EQU_HRFIOR, ';
  strSQL := strSQL + '   EQU_OPFIOR, ';
  strSQL := strSQL + '   EQU_DTINMA, ';
  strSQL := strSQL + '   EQU_HRINMA, ';
  strSQL := strSQL + '   EQU_OPINMA, ';
  strSQL := strSQL + '   EQU_DTFIMA, ';
  strSQL := strSQL + '   EQU_HRFIMA, ';
  strSQL := strSQL + '   EQU_OPFIMA, ';
  strSQL := strSQL + '   EQU_SITPRO, ';
  strSQL := strSQL + '   EQU_DTRORC, ';
  strSQL := strSQL + '   EQU_HRPORC, ';
  strSQL := strSQL + '   EQU_DTRMAN, ';
  strSQL := strSQL + '   EQU_HRPMAN, ';
  strSQL := strSQL + '   EQU_DTPAMA, ';
  strSQL := strSQL + '   EQU_HRPAMA, ';
  strSQL := strSQL + '   EQU_DTREMA, ';
  strSQL := strSQL + '   EQU_HRREMA  ';
  strSQL := strSQL + ' FROM EQUGER   ';
  strSQL := strSQL + ' WHERE AUTOINCREM = :AUTINC ';

  try
    qryOperac := fCriaQuery(Self);

    with qryOperac, SQL do
    begin
      Close;
      Clear;
      Add(strSQL);
      ParamByName('AUTINC').AsString := FAutInc;
      Open;

      if not IsEmpty then
      begin
        if FieldByName('INIORC').AsInteger = 1 then
        begin
          blnTemIniOrc := True;
          FDtIniOrc    := FieldByName('EQU_DTINOR').AsDateTime;
          FHrIniOrc    := FieldByName('EQU_HRINOR').AsDateTime;
          FOpIniOrc    := FieldByName('EQU_OPINOR').AsString;
        end;

        if FieldByName('FINORC').AsInteger = 1 then
        begin
          blnTemFinOrc := True;
          FDtFinOrc    := FieldByName('EQU_DTFIOR').AsDateTime;
          FHrFinOrc    := FieldByName('EQU_HRFIOR').AsDateTime;
          FOpFinOrc    := FieldByName('EQU_OPFIOR').AsString;
        end;

        if FieldByName('INIMAN').AsInteger = 1 then
        begin
          blnTemIniMan := True;
          FDtIniMan    := FieldByName('EQU_DTINMA').AsDateTime;
          FHrIniMan    := FieldByName('EQU_HRINMA').AsDateTime;
          FOpIniMan    := FieldByName('EQU_OPINMA').AsString;
        end;

        if FieldByName('FINMAN').AsInteger = 1 then
        begin
          blnTemFinMan := True;
          FDtFinMan    := FieldByName('EQU_DTFIMA').AsDateTime;
          FHrFinMan    := FieldByName('EQU_HRFIMA').AsDateTime;
          FOpFinMan    := FieldByName('EQU_OPFIMA').AsString;
        end;

        FDtRetOrc    := FieldByName('EQU_DTRORC').AsDateTime;
        FHrRetOrc    := FieldByName('EQU_HRPORC').AsDateTime;
        FDtRetMan    := FieldByName('EQU_DTRMAN').AsDateTime;
        FHrRetMan    := FieldByName('EQU_HRPMAN').AsDateTime;

        FDtPauMan    := FieldByName('EQU_DTPAMA').AsDateTime;
        FHrPauMan    := FieldByName('EQU_HRPAMA').AsDateTime;
        FDtReManu    := FieldByName('EQU_DTREMA').AsDateTime;
        FHrReManu    := FieldByName('EQU_HRREMA').AsDateTime;

        FOpPauOrc    := FieldByName('EQU_OPINOR').AsString;
        FOpRetOrc    := FieldByName('EQU_OPINOR').AsString;

        if (not FieldByName('EQU_SITPRO').IsNull) then
          FSituacao    := FieldByName('EQU_SITPRO').AsString
        else if blnTemFinMan then
          FSituacao    := '4'
        else if blnTemIniMan then
          FSituacao    := '3'
        else if blnTemFinOrc then
          FSituacao    := '2'
        else if blnTemIniOrc then
          FSituacao    := '1'
        else
          FSituacao    := '0';
      end;
    end;
  finally
    FreeAndNil(qryOperac);
  end;
end;

function TConEqu.fVerificaOrdServExiste(strNumOse: String; strCodEmp: String; blnEhRotinaTecnico: Boolean = False): Boolean;
var
  strSQL,
  strPre: String;
Begin
  strPre := '';

  if FOSCanc then
    strPre := 'DEL_';

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   ' + strPre + 'EQUGER.*, ';
  strSQL := strSQL + '   ' + strPre + 'FATGOR.FGO_CODCND, ';
  strSQL := strSQL + '   ' + strPre + 'FATGOR.FGO_CODFPG, ';
  strSQL := strSQL + '   ' + strPre + 'FATGOR.FGO_CONPAG, ';
  strSQL := strSQL + '   ' + strPre + 'FATGOR.FGO_CODCLI, ';
  strSQL := strSQL + '   ' + strPre + 'EXTGOR.FGO_DTLBEX, ';
  strSQL := strSQL + '   ' + strPre + 'EXTGOR.FGO_HRLBEX, ';
  strSQL := strSQL + '   ' + strPre + 'EXTGOR.FGO_DTBXSE, ';
  strSQL := strSQL + '   ' + strPre + 'EXTGOR.FGO_HRBXSE, ';
  strSQL := strSQL + '   ' + strPre + 'EXTGOR.FGO_OPBXSE, ';
  strSQL := strSQL + '   ' + strPre + 'EXTGOR.FGO_FATSSA  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   ' + strPre + 'EQUGER ';
  strSQL := strSQL + ' LEFT JOIN ' + strPre + 'FATGOR ON EQU_NUMPED = FGO_NUMDOC ';
  strSQL := strSQL + '                          AND EQU_TIPPED = FGO_ESPDOC ';
  strSQL := strSQL + '                          AND EQU_EMPPED = FGO_CODEMP ';
  strSQL := strSQL + ' LEFT JOIN ' + strPre + 'EXTGOR ON ' + strPre + 'FATGOR.AUTOINCREM = ' + strPre + 'EXTGOR.FGO_SEQFGO ';
  strSQL := strSQL + ' WHERE EQU_NUMOSE = :NUMOSE ';
  strSQL := strSQL + '   AND EQU_CODEMP = :CODEMP ';

  If (blnEhRotinaTecnico) Then
  Begin
    strSQL := strSQL + ' AND (NOT (((EQU_STATUS = "R") AND (IF(EQU_SUBSTA = "", "N", IFNULL(EQU_SUBSTA, "N")) IN ("C", "N", "G"))) OR (EQU_STATUS = "N"))) ';
  End;

  With qryEquGer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMOSE').AsString := strNumOse;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If Not IsEmpty Then
    Begin
      Result := True;
      FNumero := strNumOse;
      FCodEmp := strCodEmp;
      pCarregaItens;
      pCarregaServicos;
      pCarregaDefeitos;
      pCarregaAcessorios;
      pCarregaApontamentos;

      If FieldByName('EQU_JAPEDI').AsInteger = 1 Then
      Begin
        FTemPed := 'S';
        FEmpPed := FieldByName('EQU_EMPPED').AsString;
        FNumPed := FieldByName('EQU_NUMPED').AsString;
        FCliPed := FieldByName('FGO_CODCLI').AsString;
        FDtaPed := DateToStr(FieldByName('EQU_DTAPED').AsDateTime);
      End
      Else
      Begin
        FEmpPed := '';
        FNumPed := '';
        FCliPed := '';
        FDtaPed := '';
        FNumDocSer := '';
        FNumDocCli := '';
      End;

      pCarregaTela;
      pCarregaNumDocEQUGOR;
    End
    Else
      Result := False;
  End;
End;

function TConEqu.fVerificaPedExistente(cdsEmpIte: TDataSet; strEmpIte: String): Boolean;
var
  i: Integer;
begin
  Result := False;

  if not fEmptyStr(strEmpIte) then
  begin
    for I := Low(FArrPedidos) To High(FArrPedidos) do
    begin
      if (FArrPedidos[i].strNumPed = FNumPed) and (FArrPedidos[i].strEmpIte = strEmpIte) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end
  else
  begin
    cdsEmpIte.First;

    while not cdsEmpIte.Eof do
    begin
      for I := Low(FArrPedidos) To High(FArrPedidos) do
      begin
        if (FArrPedidos[i].strNumPed = FNumPed) and (FArrPedidos[i].strEmpIte = cdsEmpIte.FieldByName('EMPITE').AsString) then
        begin
          Result := True;
          Exit;
        end;
      end;

      cdsEmpIte.Next;
    end;
  end;
end;

function TConEqu.fCarregaDadosOSAnterior(strNumOse, strCodEqu: String): Boolean;
var
  strSQL: String;
  qryOSAnt: TUniQuery;
begin
  Result := False;

  FNOSAnt := strNumOse;
  FDtEAnt := 0;
  FDtRAnt := 0;

  qryOSAnt := fCriaQuery(Self);

  try
    try
      strSQL := '';
      strSQL := strSQL + 'SELECT EQU_DTAENT DTAENT, EQU_SITDTR DTARET ';
      strSQL := strSQL + 'FROM EQUGER ';
      strSQL := strSQL + 'WHERE EQU_CODCLI = :CODCLI ';
      strSQL := strSQL + '    AND EQU_CODEQU = :CODEQU';
      strSQL := strSQL + '    AND EQU_NUMOSE = :NUMOSE ';

      qryOSAnt.Close;
      qryOSAnt.SQL.Clear;
      qryOSAnt.SQL.Text := strSQL;
      qryOSAnt.ParamByName('CODCLI').AsString := FCodCli;
      qryOSAnt.ParamByName('CODEQU').AsString := strCodEqu;
      qryOSAnt.ParamByName('NUMOSE').AsString   := strNumOse;
      qryOSAnt.Open;

      if not qryOSAnt.IsEmpty then
      begin
        FDtEAnt := qryOSAnt.FieldByName('DTAENT').AsDateTime;
        FDtRAnt := qryOSAnt.FieldByName('DTARET').AsDateTime;
        Result := True;
      end;
    except
      on E: Exception do
      begin
        Result := False;
        pMensagensErro(E.Message, '[TConEqu.fCarregaDadosOSAnterior]');
      end;
    end;
  finally
    FreeAndNil(qryOSAnt);
  end
end;

function TConEqu.fCarregaHistoricoEquip(strNumOse, strCodCli, strCodEqu, strNSerie: String): String;
var
  strSQL,
  strValor,
  strSQLItens,
  strLinha   : String;
  qryOS      : TUniQuery;
  qryItensOS : TUniQuery;
begin
  Result := '';

  try
    qryOS      := fCriaQuery(Self);
    qryItensOS := fCriaQuery(Self);

    try
      strSQL := '';
      strSQL := strSQL + ' SELECT EQU_NUMOSE NUMOSE, EQU_CODEMP CODEMP, EQU_DTAFIN DTAFIN, ';
      strSQL := strSQL + '     EQU_SITDTR SITDTR, EQU_VLRCON VLRCON ';
      strSQL := strSQL + ' FROM EQUGER ';
      strSQL := strSQL + ' WHERE EQU_CODCLI = :CODCLI ';
      strSQL := strSQL + '     AND EQU_CODEQU = :CODEQU ';
      strSQL := strSQL + '     AND EQU_NSERIE = :NSERIE ';
      if not fEmptyStr(strNumOse) then
        strSQL := strSQL + '     AND EQU_NUMOSE <> "' + strNumOse + '" ';
      strSQL := strSQL + ' ORDER BY EQU_NUMOSE ';

      strSQLItens := '';
      strSQLItens := strSQLItens + ' SELECT CONCAT("P -> ", EQU_CODITE, " - ", RPAD(EQU_DESCRI, 80, " ")) DESCRI, ';
      strSQLItens := strSQLItens + '     LPAD(FORMAT(EQU_QTDITE, 2), 8, " ") QTDITE, EQU_TOTITE TOTITE ';
      strSQLItens := strSQLItens + ' FROM EQUDET ';
      strSQLItens := strSQLItens + ' WHERE EQU_NUMOSE = :NUMOSE ';
      strSQLItens := strSQLItens + '     AND EQU_CODEMP = :CODEMP ';
      strSQLItens := strSQLItens + ' UNION ALL ';
      strSQLItens := strSQLItens + ' SELECT CONCAT("S -> ", EQU_CODSER, " - ", RPAD(EQU_DESSER, 80, " ")) DESCRI, ';
      strSQLItens := strSQLItens + '     EQU_QTDSER QTDITE, EQU_VALSER TOTITE ';
      strSQLItens := strSQLItens + ' FROM EQUSER ';
      strSQLItens := strSQLItens + ' WHERE EQU_NUMOSE = :NUMOSE ';
      strSQLItens := strSQLItens + '     AND EQU_CODEMP = :CODEMP ';

      qryOS.Close;
      qryOS.SQL.Text := strSQL;
      qryOS.ParamByName('CODCLI').AsString := strCodCli;
      qryOS.ParamByName('CODEQU').AsString := strCodEqu;
      qryOS.ParamByName('NSERIE').AsString := strNSerie;
      qryOS.Open;

      while not qryOS.Eof do
      begin
        if Pos(qryOS.FieldByName('CODEMP').AsString, strEmpAcessoUsuarioLogado) > 0 then
        begin
          if not fEmptyStr(Result) then
            Result := Result + #13;

          strLinha := 'O.S.: ' + qryOS.FieldByName('NUMOSE').AsString;

          if not qryOS.FieldByName('DTAFIN').IsNull then
            strLinha := strLinha + ' - Data Conclusão: ' + FormatDateTime('dd/mm/yyyy', qryOS.FieldByName('DTAFIN').AsDateTime);

          if not qryOS.FieldByName('SITDTR').IsNull then
            strLinha := strLinha + ' - Data Retirada: ' + FormatDateTime('dd/mm/yyyy', qryOS.FieldByName('SITDTR').AsDateTime);

          strLinha := strLinha + ' - Total: ' + FormatFloat('R$ #,##0.00', qryOS.FieldByName('VLRCON').AsFloat);
          Result := Result + strLinha + StringOfChar(' ', 150 - Length(strLinha));

          qryItensOS.Close;
          qryItensOS.SQL.Text := strSQLItens;
          qryItensOS.ParamByName('NUMOSE').AsString := qryOS.FieldByName('NUMOSE').AsString;
          qryItensOS.ParamByName('CODEMP').AsString := qryOS.FieldByName('CODEMP').AsString;
          qryItensOS.Open;

          while not qryItensOS.Eof do
          begin
            strValor := FormatFloat('R$ #,##0.00', qryItensOS.FieldByName('TOTITE').AsFloat);
            strLinha := qryItensOS.FieldByName('DESCRI').AsString;
            strLinha := strLinha + ' - ' + qryItensOS.FieldByName('QTDITE').AsString;
            strLinha := strLinha + ' - ' + StringOfChar(' ', 12 - Length(strValor)) + strValor;
            Result := Result + #13 + ' ' + strLinha + StringOfChar(' ', 140 - Length(strLinha));

            qryItensOS.Next;
          end;
        end;

        qryOS.Next;
      end;
    except
      on E: Exception do
        pMensagensErro(E.Message, '[TConEqu.fCarregaHistoricoEquip]');
    end;
  finally
    pFreeAndNil(qryOS);
    pFreeAndNil(qryItensOS);
  end;
end;

function TConEqu.fCarregaOSAnt(strCodEqu, strCampo, strValor, strNumOse: String): Boolean;
var
  strSQL: String;
  qryOSAnt: TUniQuery;
begin
  Result := False;

  FNOSAnt := '';
  FDtEAnt := 0;
  FDtRAnt := 0;

  qryOSAnt := fCriaQuery(Self);

  try
    try
      strSQL := '';
      strSQL := strSQL + 'SELECT EQU_NUMOSE NUMOSE, EQU_DTAENT DTAENT, EQU_SITDTR DTARET ';
      strSQL := strSQL + 'FROM EQUGER ';
      strSQL := strSQL + 'WHERE EQU_CODCLI = :CODCLI ';
      strSQL := strSQL + '    AND EQU_CODEQU = :CODEQU';
      strSQL := strSQL + '    AND EQU_' + strCampo + ' = :' + strCampo;
      strSQL := strSQL + '    AND EQU_DTAENT = ';
      strSQL := strSQL + '        (SELECT MAX(E.EQU_DTAENT) ';
      strSQL := strSQL + '         FROM EQUGER E ';
      strSQL := strSQL + '         WHERE EQUGER.EQU_CODCLI = E.EQU_CODCLI ';
      strSQL := strSQL + '             AND EQUGER.EQU_' + strCampo + ' = E.EQU_' + strCampo;
      strSQL := strSQL + '             AND EQUGER.EQU_CODEQU = E.EQU_CODEQU ';

      if not fEmptyStr(strNumOse) then
      begin
        strSQL := strSQL + '             AND E.EQU_NUMOSE <> :NUMOSE ';
        strSQL := strSQL + '             AND ((E.EQU_DTAENT < :DTAENT) ';
        strSQL := strSQL + '             OR (E.EQU_DTAENT = :DTAENT AND E.EQU_HORENT < :HORENT)) ';
      end;

      strSQL := strSQL + '        ) ';

      strSQL := strSQL + '    AND EQU_HORENT = ';
      strSQL := strSQL + '        (SELECT MAX(E.EQU_HORENT) ';
      strSQL := strSQL + '         FROM EQUGER E ';
      strSQL := strSQL + '         WHERE EQUGER.EQU_CODCLI = E.EQU_CODCLI ';
      strSQL := strSQL + '             AND EQUGER.EQU_' + strCampo + ' = E.EQU_' + strCampo;
      strSQL := strSQL + '             AND EQUGER.EQU_CODEQU = E.EQU_CODEQU ';

      if not fEmptyStr(strNumOse) then
        strSQL := strSQL + '             AND E.EQU_NUMOSE <> :NUMOSE ';

      strSQL := strSQL + '             AND E.EQU_DTAENT = EQUGER.EQU_DTAENT) ';

      qryOSAnt.Close;
      qryOSAnt.SQL.Clear;
      qryOSAnt.SQL.Text := strSQL;
      qryOSAnt.ParamByName('CODCLI').AsString := FCodCli;
      qryOSAnt.ParamByName('CODEQU').AsString := strCodEqu;

      if not fEmptyStr(strNumOse) then
      begin
        qryOSAnt.ParamByName('NUMOSE').AsString   := strNumOse;
        qryOSAnt.ParamByName('DTAENT').AsDateTime := FDtaEnt;
        qryOSAnt.ParamByName('HORENT').AsDateTime := FHorEnt;
      end;

      qryOSAnt.ParamByName(strCampo).AsString := strValor;
      qryOSAnt.Open;

      if not qryOSAnt.IsEmpty then
      begin
        FNOSAnt := qryOSAnt.FieldByName('NUMOSE').AsString;
        FDtEAnt := qryOSAnt.FieldByName('DTAENT').AsDateTime;
        FDtRAnt := qryOSAnt.FieldByName('DTARET').AsDateTime;
        Result := True;
      end;
    except
      on E: Exception do
      begin
        Result := False;
        pMensagensErro(E.Message, '[TConEqu.fVerificaOSAnt]');
      end;
    end;
  finally
    FreeAndNil(qryOSAnt);
  end
end;

function TConEqu.fCarregaRecServicos(strCliente, strCobAPa: String): TDadosServicos;
var
  intIndSer  : Integer;
  objServicos: TClassDadosServicos;
begin
  Result := fAtualizarDadosServicos();

  Result.fltTotSer := FVlrSer - fValorCobAParte(strCobAPa);
  Result.fltPerIss := fCampoTabela('CLI_ALQISS', 'CADCLI', ['CLI_CODCLI'], [strCliente]);
  Result.fltRedIss := fCampoTabela('CLI_REDISS', 'CADCLI', ['CLI_CODCLI'], [strCliente]);

  if (Result.fltPerIss <= 0) and fCfgSis('ISSSER', varBoolean) then
  begin
    objServicos := TClassDadosServicos.Create(Result);
    try
      for intIndSer := 1 to 30 do
      begin
        strCodSer := GetPropValue(objServicos, 'strCodS' + fStrZero(intToStr(intIndSer), 2));
        Result.fltPerIss := fCampoTabela('SER_ALQISS','CADSER', ['SER_CODSER'], [strCodSer]);
        Result.fltRedIss := fCampoTabela('SER_REDISS','CADSER', ['SER_CODSER'], [strCodSer]);

        if Result.fltPerIss > 0 then
          Break;
      end;
    finally
      FreeAndNil(objServicos);
    end;
  end;

  if Result.fltPerIss <= 0 then
  begin
    Result.fltPerIss := fRetAliquotaIssCidade(FCodCid);
    Result.fltRedIss := fRetReducaoBaseIssCidade(FCodCid);
  end;

  if Result.fltPerIss <= 0 then
  begin
    Result.fltPerIss := fCfgSis('PERISS', varDouble);
    Result.fltRedIss := fCfgSis('REDISS', varDouble);
  end;

  Result.fltBasIss := fFormataFloat(Result.fltTotSer * (1 - Result.fltRedIss / 100), 2);
  Result.fltValIss := fFormataFloat(Result.fltBasIss * (Result.fltPerIss / 100), 2);
  Result.strDisSer := FDisSer;
end;

function TConEqu.fVerificarAlteracoesAcessorio: TRegistroMsgLiberaTabela;
Var
    prcScroll    : TprcScroll;

  function fRegistroAdicionado(): Boolean;
  begin
    FCdsAceEquLog.Filtered := False;
    FCdsAceEquLog.Filter   := 'CODACE = ' + QuotedStr(cdsAceEqu.FieldByName('CODACE').AsString);
    FCdsAceEquLog.Filtered := True;

    Result := (FCdsAceEquLog.IsEmpty);
  end;

  function fRegistroRemovido(): Boolean;
  begin
    cdsAceEqu.Filtered := False;
    cdsAceEqu.Filter   := 'CODACE = ' + QuotedStr(FCdsAceEquLog.FieldByName('CODACE').AsString);
    cdsAceEqu.Filtered := True;

    Result := (cdsAceEqu.IsEmpty);
  end;

  procedure pDetalharRegistroAdicionado(objTabela : TRegistroMsgLiberaTabela);
  var
    objLinha  : TLinhaMsgLibera;
  begin

    If (Not cdsAceEqu.IsEmpty) Then
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('OPERAÇÃO'   , 'INSERIR'                                , 15  , alEsquerda );
      objLinha.pAddColuna('CÓD.'       , cdsAceEqu.FieldByName('CODACE').AsString , 5   , alCentro   );
      objLinha.pAddColuna('DESCRIÇÃO'  , cdsAceEqu.FieldByName('DESACE').AsString , 104 , alEsquerda );
      objLinha.pAddColuna('QUANTIDADE' , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsAceEqu.FieldByName('QTDACE').AsFloat), 10 , alDireita);
      objTabela.lstLinhas.Add(objLinha);
    End;
  end;

  procedure pDetalharRegistroRemovido(objTabela : TRegistroMsgLiberaTabela);
  var
    objLinha  : TLinhaMsgLibera;
  begin
    If (Not FCdsAceEquLog.IsEmpty) Then
    Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('OPERAÇÃO'   , 'REMOVER'                                    , 15  , alEsquerda );
      objLinha.pAddColuna('CÓD.'       , FCdsAceEquLog.FieldByName('CODACE').AsString , 5   , alCentro   );
      objLinha.pAddColuna('DESCRIÇÃO'  , FCdsAceEquLog.FieldByName('DESACE').AsString , 104 , alEsquerda );
      objLinha.pAddColuna('QUANTIDADE' , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), FCdsAceEquLog.FieldByName('QTDACE').AsFloat), 10 , alDireita);
      objTabela.lstLinhas.Add(objLinha);
    End;
  end;

begin
  Try
    Result := TRegistroMsgLiberaTabela.Create;

    If (Assigned(cdsAceEqu)) And (Assigned(FCdsAceEquLog)) Then
    Begin
      Try
        pDisableControls(cdsAceEqu, prcScroll);

        cdsAceEqu.First();
        While Not cdsAceEqu.Eof Do
        Begin
          //verifica se foi adicionado
          If (fRegistroAdicionado()) Then
            pDetalharRegistroAdicionado(Result);

          cdsAceEqu.Next();
        End;

        FCdsAceEquLog.Filtered := False;
        FCdsAceEquLog.Filter   := '';

        FCdsAceEquLog.First();
        While Not FCdsAceEquLog.Eof Do
        Begin
          //verifica se foi excluído
          If (fRegistroRemovido()) Then
            pDetalharRegistroRemovido(Result);

          FCdsAceEquLog.Next();
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TConEqu.fVerificarAlteracoesAcessorio]');
      End;
    End;
  Finally
    cdsAceEqu.Filtered := False;
    cdsAceEqu.Filter   := '';

    FCdsAceEquLog.Filtered := False;
    FCdsAceEquLog.Filter   := '';

    pEnableControls(cdsAceEqu, prcScroll);
  End;
end;

function TConEqu.fVerificarAlteracoesDefeito: TRegistroMsgLiberaTabela;
  Var
    prcScroll    : TprcScroll;

  function fRegistroAdicionado(): Boolean;
  begin
    FCdsDfeEquLog.Filtered := False;
    FCdsDfeEquLog.Filter   := 'CODDFE = ' + QuotedStr(cdsDfeEqu.FieldByName('CODDFE').AsString);
    FCdsDfeEquLog.Filtered := True;

    Result := (FCdsDfeEquLog.IsEmpty);
  end;

  function fRegistroRemovido(): Boolean;
  begin
    cdsDfeEqu.Filtered := False;
    cdsDfeEqu.Filter   := 'CODDFE = ' + QuotedStr(FCdsDfeEquLog.FieldByName('CODDFE').AsString);
    cdsDfeEqu.Filtered := True;

    Result := (cdsDfeEqu.IsEmpty);
  end;

  procedure pDetalharRegistroAdicionado(objTabela : TRegistroMsgLiberaTabela);
  var
    objLinha  : TLinhaMsgLibera;
  begin

    If (Not cdsDfeEqu.IsEmpty) Then Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('OPERAÇÃO'   , 'INSERIR'                                , 15  , alEsquerda );
      objLinha.pAddColuna('CÓD.'       , cdsDfeEqu.FieldByName('CODDFE').AsString , 5   , alCentro   );
      objLinha.pAddColuna('DESCRIÇÃO'  , cdsDfeEqu.FieldByName('DESDFE').AsString , 104 , alEsquerda );
      objTabela.lstLinhas.Add(objLinha);
    End;
  end;

  procedure pDetalharRegistroRemovido(objTabela : TRegistroMsgLiberaTabela);
  var
    objLinha  : TLinhaMsgLibera;
  begin

    If (Not FCdsDfeEquLog.IsEmpty) Then Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('OPERAÇÃO'   , 'REMOVER'                                    , 15  , alEsquerda );
      objLinha.pAddColuna('CÓD.'       , FCdsDfeEquLog.FieldByName('CODDFE').AsString , 5   , alCentro   );
      objLinha.pAddColuna('DESCRIÇÃO'  , FCdsDfeEquLog.FieldByName('DESDFE').AsString , 104 , alEsquerda );
      objTabela.lstLinhas.Add(objLinha);

    End;
  end;

begin
  Try
    Result := TRegistroMsgLiberaTabela.Create;

    If (Assigned(cdsDfeEqu)) And (Assigned(FCdsDfeEquLog)) Then Begin
      Try
        pDisableControls(cdsDfeEqu, prcScroll);

        cdsDfeEqu.First();
        While Not cdsDfeEqu.Eof Do Begin
          //verifica se foi adicionado
          If (fRegistroAdicionado()) Then
            pDetalharRegistroAdicionado(Result);

          cdsDfeEqu.Next();
        End;

        FCdsDfeEquLog.Filtered := False;
        FCdsDfeEquLog.Filter   := '';

        FCdsDfeEquLog.First();
        While Not FCdsDfeEquLog.Eof Do Begin
          //verifica se foi excluído
          If (fRegistroRemovido()) Then
            pDetalharRegistroRemovido(Result);

          FCdsDfeEquLog.Next();
        End;

      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TConEqu.fVerificarAlteracoesDefeito]');
      End;
    End;
  Finally
    cdsDfeEqu.Filtered := False;
    cdsDfeEqu.Filter   := '';

    FCdsDfeEquLog.Filtered := False;
    FCdsDfeEquLog.Filter   := '';

    pEnableControls(cdsDfeEqu, prcScroll);
  End;
end;

function TConEqu.fVerificarAlteracoesItem: TRegistroMsgLiberaTabela;
  Var
    prcScroll    : TprcScroll;

  function fRegistroAlterado(): Boolean;
    Var
      i: Integer;
  begin
    Result := False;

    FCdsIteEquLog.Filtered := False;
    FCdsIteEquLog.Filter   := 'CODITE = ' + QuotedStr(cdsIteEqu.FieldByName('CODITE').AsString);
    FCdsIteEquLog.Filtered := True;

    If (Not FCdsIteEquLog.IsEmpty) Then Begin
      For i := 0 To cdsIteEqu.Fields.Count - 1 Do Begin
        If (cdsIteEqu.Fields[i].Value <> FCdsIteEquLog.Fields[i].Value) Then Begin
          Result := True;
          Break;
        End;
      End;
    End;
  end;

  function fRegistroAdicionado(): Boolean;
  begin
    FCdsIteEquLog.Filtered := False;
    FCdsIteEquLog.Filter   := 'CODITE = ' + QuotedStr(cdsIteEqu.FieldByName('CODITE').AsString);
    FCdsIteEquLog.Filtered := True;

    Result := (FCdsIteEquLog.IsEmpty);
  end;

  function fRegistroRemovido(): Boolean;
  begin
    cdsIteEqu.Filtered := False;
    cdsIteEqu.Filter   := 'CODITE = ' + QuotedStr(FCdsIteEquLog.FieldByName('CODITE').AsString);
    cdsIteEqu.Filtered := True;

    Result := (cdsIteEqu.IsEmpty);
  end;

  procedure pDetalharRegistroAlterado(objTabela : TRegistroMsgLiberaTabela);
  var
    objLinha  : TLinhaMsgLibera;
  begin

    If (Not FCdsIteEquLog.IsEmpty) Then Begin
      objLinha := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('OPERAÇÃO'   , 'ALTERAR (atual)'                                                    , 15 , alEsquerda);
      objLinha.pAddColuna('CÓD.'       , FCdsIteEquLog.FieldByName('CODITE').AsString                         , fTamCodIte  , alCentro  );
      objLinha.pAddColuna('DESCRIÇÃO'  , FCdsIteEquLog.FieldByName('DESITE').AsString                         , 34 , alEsquerda);
      objLinha.pAddColuna('REFERÊNCIA' , FCdsIteEquLog.FieldByName('REFERE').AsString                         , 11 , alEsquerda);
      objLinha.pAddColuna('FÁBRICA'    , FCdsIteEquLog.FieldByName('CODFAB').AsString                         , 11 , alEsquerda);
      objLinha.pAddColuna('UN'         , FCdsIteEquLog.FieldByName('UNIDAD').AsString                         , 2  , alCentro  );
      objLinha.pAddColuna('QUANTIDADE' , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), FCdsIteEquLog.FieldByName('QTDITE').AsFloat) , 10 , alDireita );
      objLinha.pAddColuna('VR.UNITÁRIO', FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), FCdsIteEquLog.FieldByName('UNITAR').AsFloat) , 12 , alDireita );
      objLinha.pAddColuna('VR.TOTAL'   , FormatFloat('#,##0.00', FCdsIteEquLog.FieldByName('TOTITE').AsFloat) , 12 , alDireita );
      objTabela.lstLinhas.Add(objLinha);
    End;

    If (Not cdsIteEqu.IsEmpty) Then Begin
      objLinha := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('OPERAÇÃO'   , 'ALTERAR (novo)'                                                 , 15 , alEsquerda);
      objLinha.pAddColuna('CÓD.'       , cdsIteEqu.FieldByName('CODITE').AsString                         , ftamCodite  , alCentro  );
      objLinha.pAddColuna('DESCRIÇÃO'  , cdsIteEqu.FieldByName('DESITE').AsString                         , 34 , alEsquerda);
      objLinha.pAddColuna('REFERÊNCIA' , cdsIteEqu.FieldByName('REFERE').AsString                         , 11 , alEsquerda);
      objLinha.pAddColuna('FÁBRICA'    , cdsIteEqu.FieldByName('CODFAB').AsString                         , 11 , alEsquerda);
      objLinha.pAddColuna('UN'         , cdsIteEqu.FieldByName('UNIDAD').AsString                         , 2  , alCentro  );
      objLinha.pAddColuna('QUANTIDADE' , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsIteEqu.FieldByName('QTDITE').AsFloat) , 10 , alDireita );
      objLinha.pAddColuna('VR.UNITÁRIO', FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), cdsIteEqu.FieldByName('UNITAR').AsFloat) , 12 , alDireita );
      objLinha.pAddColuna('VR.TOTAL'   , FormatFloat('#,##0.00', cdsIteEqu.FieldByName('TOTITE').AsFloat) , 12 , alDireita );
      objTabela.lstLinhas.Add(objLinha);
    End;
  end;

  procedure pDetalharRegistroAdicionado(objTabela : TRegistroMsgLiberaTabela);
  var
    objLinha  : TLinhaMsgLibera;
  begin
     If (Not cdsIteEqu.IsEmpty) Then Begin
      objLinha := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('OPERAÇÃO'   , 'INSERIR'                                                        , 15 , alEsquerda);
      objLinha.pAddColuna('CÓD.'       , cdsIteEqu.FieldByName('CODITE').AsString                         , fTamCodite  , alCentro  );
      objLinha.pAddColuna('DESCRIÇÃO'  , cdsIteEqu.FieldByName('DESITE').AsString                         , 34 , alEsquerda);
      objLinha.pAddColuna('REFERÊNCIA' , cdsIteEqu.FieldByName('REFERE').AsString                         , 11 , alEsquerda);
      objLinha.pAddColuna('FÁBRICA'    , cdsIteEqu.FieldByName('CODFAB').AsString                         , 11 , alEsquerda);
      objLinha.pAddColuna('UN'         , cdsIteEqu.FieldByName('UNIDAD').AsString                         , 2  , alCentro  );
      objLinha.pAddColuna('QUANTIDADE' , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), cdsIteEqu.FieldByName('QTDITE').AsFloat) , 10 , alDireita );
      objLinha.pAddColuna('VR.UNITÁRIO', FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), cdsIteEqu.FieldByName('UNITAR').AsFloat) , 12 , alDireita );
      objLinha.pAddColuna('VR.TOTAL'   , FormatFloat('#,##0.00', cdsIteEqu.FieldByName('TOTITE').AsFloat) , 12 , alDireita );
      objTabela.lstLinhas.Add(objLinha);
    End;

  end;

  procedure pDetalharRegistroRemovido(objTabela : TRegistroMsgLiberaTabela);
  var
    objLinha  : TLinhaMsgLibera;
  begin

    If (Not FCdsIteEquLog.IsEmpty) Then Begin
      objLinha := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('OPERAÇÃO'   , 'REMOVER'                                                            , 15 , alEsquerda);
      objLinha.pAddColuna('CÓD.'       , FCdsIteEquLog.FieldByName('CODITE').AsString                         , fTamCodite  , alCentro  );
      objLinha.pAddColuna('DESCRIÇÃO'  , FCdsIteEquLog.FieldByName('DESITE').AsString                         , 34 , alEsquerda);
      objLinha.pAddColuna('REFERÊNCIA' , FCdsIteEquLog.FieldByName('REFERE').AsString                         , 11 , alEsquerda);
      objLinha.pAddColuna('FÁBRICA'    , FCdsIteEquLog.FieldByName('CODFAB').AsString                         , 11 , alEsquerda);
      objLinha.pAddColuna('UN'         , FCdsIteEquLog.FieldByName('UNIDAD').AsString                         , 2  , alCentro  );
      objLinha.pAddColuna('QUANTIDADE' , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), FCdsIteEquLog.FieldByName('QTDITE').AsFloat) , 10 , alDireita );
      objLinha.pAddColuna('VR.UNITÁRIO', FormatFloat(fMskDigitos(fCfgSis('DECUNI', varInteger)), FCdsIteEquLog.FieldByName('UNITAR').AsFloat) , 12 , alDireita );
      objLinha.pAddColuna('VR.TOTAL'   , FormatFloat('#,##0.00', FCdsIteEquLog.FieldByName('TOTITE').AsFloat) , 12 , alDireita );
      objTabela.lstLinhas.Add(objLinha);
    End;

  end;

begin
  Try
    Result := TRegistroMsgLiberaTabela.Create;

    If (Assigned(cdsIteEqu)) And (Assigned(FCdsIteEquLog)) Then Begin
      Try
        pDisableControls(cdsIteEqu, prcScroll);

        cdsIteEqu.First();
        While Not cdsIteEqu.Eof Do Begin
          //verifica se foi alterado
          If (fRegistroAlterado()) Then
            pDetalharRegistroAlterado(Result);

          //verifica se foi adicionado
          If (fRegistroAdicionado()) Then
            pDetalharRegistroAdicionado(Result);

          cdsIteEqu.Next();
        End;

        FCdsIteEquLog.Filtered := False;
        FCdsIteEquLog.Filter   := '';

        FCdsIteEquLog.First();
        While Not FCdsIteEquLog.Eof Do Begin
          //verifica se foi excluído
          If (fRegistroRemovido()) Then
            pDetalharRegistroRemovido(Result);

          FCdsIteEquLog.Next();
        End;

      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TConEqu.fVerificarAlteracoesItem]');
      End;
    End;
  Finally
    cdsIteEqu.Filtered := False;
    cdsIteEqu.Filter   := '';

    FCdsIteEquLog.Filtered := False;
    FCdsIteEquLog.Filter   := '';

    pEnableControls(cdsIteEqu, prcScroll);
  End;
end;

function TConEqu.fVerificarAlteracoesServico: TRegistroMsgLiberaTabela;
  Var
    prcScroll    : TprcScroll;

  function fRegistroAlterado(): Boolean;
    Var
      i: Integer;
  begin
    Result := False;

    FCdsSerEquLog.Filtered := False;
    FCdsSerEquLog.Filter   := 'CODSER = ' + QuotedStr(cdsSerEqu.FieldByName('CODSER').AsString) +
      ' AND TECSER = ' + QuotedStr(cdsSerEqu.FieldByName('TECSER').AsString);
    FCdsSerEquLog.Filtered := True;

    If (Not FCdsSerEquLog.IsEmpty) Then Begin
      For i := 0 To cdsSerEqu.Fields.Count - 1 Do Begin
        If (cdsSerEqu.Fields[i].Value <> FCdsSerEquLog.Fields[i].Value) Then Begin
          Result := True;
          Break;
        End;
      End;
    End;
  end;

  function fRegistroAdicionado(): Boolean;
  begin
    FCdsSerEquLog.Filtered := False;
    FCdsSerEquLog.Filter   := 'CODSER = ' + QuotedStr(cdsSerEqu.FieldByName('CODSER').AsString) +
      ' AND TECSER = ' + QuotedStr(cdsSerEqu.FieldByName('TECSER').AsString);
    FCdsSerEquLog.Filtered := True;

    Result := (FCdsSerEquLog.IsEmpty);
  end;

  function fRegistroRemovido(): Boolean;
  begin
    cdsSerEqu.Filtered := False;
    cdsSerEqu.Filter   := 'CODSER = ' + QuotedStr(FCdsSerEquLog.FieldByName('CODSER').AsString) +
      ' AND TECSER = ' + QuotedStr(FCdsSerEquLog.FieldByName('TECSER').AsString);
    cdsSerEqu.Filtered := True;

    Result := (cdsSerEqu.IsEmpty);
  end;

  procedure pDetalharRegistroAlterado(objTabela : TRegistroMsgLiberaTabela);
   var
    objLinha  : TLinhaMsgLibera;
  begin
    If (Not FCdsSerEquLog.IsEmpty) Then Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('OPERAÇÃO'   , 'REMOVER'                                                        , 15 , alEsquerda);
      objLinha.pAddColuna('CÓD.'       , FCdsSerEquLog.FieldByName('CODSER').AsString                         , 5  , alCentro  );
      objLinha.pAddColuna('DESCRIÇÃO'  , FCdsSerEquLog.FieldByName('DESSER').AsString                         , 58 , alEsquerda);
      objLinha.pAddColuna('TÉCNICO'    , FCdsSerEquLog.FieldByName('TECSER').AsString + '-' +
                                         fRetNomeOperador(FCdsSerEquLog.FieldByName('TECSER').AsString)       , 30 , alEsquerda);
      objLinha.pAddColuna('VR.TOTAL'   , FormatFloat('#,##0.00', FCdsSerEquLog.FieldByName('VALSER').AsFloat) , 12 , alDireita );
      objTabela.lstLinhas.Add(objLinha);
    End;

    If (Not cdsSerEqu.IsEmpty) Then Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('OPERAÇÃO'   , 'ALTERAR (novo)'                                                 , 15 , alEsquerda);
      objLinha.pAddColuna('CÓD.'       , cdsSerEqu.FieldByName('CODSER').AsString                         , 5  , alCentro  );
      objLinha.pAddColuna('DESCRIÇÃO'  , cdsSerEqu.FieldByName('DESSER').AsString                         , 58 , alEsquerda);
      objLinha.pAddColuna('TÉCNICO'    , cdsSerEqu.FieldByName('TECSER').AsString + '-' +
                                         fRetNomeOperador(cdsSerEqu.FieldByName('TECSER').AsString)       , 30 , alEsquerda);
      objLinha.pAddColuna('VR.TOTAL'   , FormatFloat('#,##0.00', cdsSerEqu.FieldByName('VALSER').AsFloat) , 12 , alDireita );
      objTabela.lstLinhas.Add(objLinha);
    End;
  end;

  procedure pDetalharRegistroAdicionado(objTabela : TRegistroMsgLiberaTabela);
  var
    objLinha  : TLinhaMsgLibera;
  begin

    If (Not cdsSerEqu.IsEmpty) Then Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('OPERAÇÃO'   , 'INSERIR'                                                        , 15 , alEsquerda);
      objLinha.pAddColuna('CÓD.'       , cdsSerEqu.FieldByName('CODSER').AsString                         , 5  , alCentro  );
      objLinha.pAddColuna('DESCRIÇÃO'  , cdsSerEqu.FieldByName('DESSER').AsString                         , 58 , alEsquerda);
      objLinha.pAddColuna('TÉCNICO'    , cdsSerEqu.FieldByName('TECSER').AsString + '-' +
                                         fRetNomeOperador(cdsSerEqu.FieldByName('TECSER').AsString)       , 30 , alEsquerda);
      objLinha.pAddColuna('VR.TOTAL'   , FormatFloat('#,##0.00', cdsSerEqu.FieldByName('VALSER').AsFloat) , 12 , alDireita );
      objTabela.lstLinhas.Add(objLinha);
    End;
  end;

  procedure pDetalharRegistroRemovido(objTabela : TRegistroMsgLiberaTabela);
   var
    objLinha  : TLinhaMsgLibera;
  begin
    If (Not FCdsSerEquLog.IsEmpty) Then Begin
      objLinha  := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha := tlValor;
      objLinha.pAddColuna('OPERAÇÃO'   , 'REMOVER'                                                        , 15 , alEsquerda);
      objLinha.pAddColuna('CÓD.'       , FCdsSerEquLog.FieldByName('CODSER').AsString                         , 5  , alCentro  );
      objLinha.pAddColuna('DESCRIÇÃO'  , FCdsSerEquLog.FieldByName('DESSER').AsString                         , 58 , alEsquerda);
      objLinha.pAddColuna('TÉCNICO'    , FCdsSerEquLog.FieldByName('TECSER').AsString + '-' +
                                         fRetNomeOperador(FCdsSerEquLog.FieldByName('TECSER').AsString)       , 30 , alEsquerda);
      objLinha.pAddColuna('VR.TOTAL'   , FormatFloat('#,##0.00', FCdsSerEquLog.FieldByName('VALSER').AsFloat) , 12 , alDireita );
      objTabela.lstLinhas.Add(objLinha);
    End;
  end;

begin

  Result := TRegistroMsgLiberaTabela.Create;

  Try
    If (Assigned(cdsSerEqu)) And (Assigned(FCdsSerEquLog)) Then Begin
      Try
        pDisableControls(cdsSerEqu, prcScroll);

        cdsSerEqu.First();
        While Not cdsSerEqu.Eof Do Begin
          //verifica se foi alterado
          If (fRegistroAlterado()) Then
            pDetalharRegistroAlterado(Result);

          //verifica se foi adicionado
          If (fRegistroAdicionado()) Then
            pDetalharRegistroAdicionado(Result);

          cdsSerEqu.Next();
        End;

        FCdsSerEquLog.Filtered := False;
        FCdsSerEquLog.Filter   := '';

        FCdsSerEquLog.First();
        While Not FCdsSerEquLog.Eof Do Begin
          //verifica se foi excluído
          If (fRegistroRemovido()) Then
            pDetalharRegistroRemovido(Result);

          FCdsSerEquLog.Next();
        End;
      Except
        On E: Exception Do
          pMensagensErro(E.Message, '[TConEqu.fVerificarAlteracoesServico]');
      End;
    End;
  Finally
    cdsSerEqu.Filtered := False;
    cdsSerEqu.Filter   := '';

    FCdsSerEquLog.Filtered := False;
    FCdsSerEquLog.Filter   := '';

    pEnableControls(cdsSerEqu, prcScroll);
  End;
end;

function TConEqu.fGravaEquGer(blnNegociacao: Boolean = False): Boolean;
Var
  strSQL: String;
  qryGen: TUniQuery;
  strErrAudit: String;
  blnTransacaoLocal : Boolean;

  function fValidaTotRet(StrNumero: String; StrCodEmp: String): Boolean;
    var
      strSQLValImp: String;
      qryValImp: TUniQuery;
  begin
    Result := False;

    if fEmptyStr(StrNumero) or fEmptyStr(StrCodEmp) then
      exit;

    qryValImp := fCriaQuery;

    strSQLValImp := '';
    strSQLValImp := strSQLValImp + ' SELECT            ';
    strSQLValImp := strSQLValImp + '   GER.EQU_TOTRET  ';
    strSQLValImp := strSQLValImp + ' FROM              ';
    strSQLValImp := strSQLValImp + '   EQUGER GER      ';
    strSQLValImp := strSQLValImp + ' WHERE             ';
    strSQLValImp := strSQLValImp + '   GER.EQU_CODEMP = :CODEMP AND  ';
    strSQLValImp := strSQLValImp + '   GER.EQU_NUMOSE = :NUMOSE AND  ';
    strSQLValImp := strSQLValImp + '   GER.EQU_TOTRET = 0 AND        ';
    strSQLValImp := strSQLValImp + '   (SELECT SUM(DET.EQU_VALRET) FROM EQUDET DET WHERE DET.EQU_CODEMP = :CODEMP AND DET.EQU_NUMOSE = :NUMOSE) > 0 ';

    qryValImp.Close;
    qryValImp.SQL.Clear;
    qryValImp.SQL.Add(strSQLValImp);
    qryValImp.ParamByName('CODEMP').AsString := StrCodEmp;
    qryValImp.ParamByName('NUMOSE').AsString := StrNumero;
    qryValImp.Open;

    if Assigned(qryValImp) And qryValImp.Active then
      Result := (not qryValImp.IsEmpty);
  end;
Begin
  Result := True;

  if (not fTemStatusFluxoPreenchido) then
  begin
    pMensagemOk('Houve uma inconsistência ao gravar a OS. Por favor, feche a rotina e tente novamente.');
    Exit(False);
  end;

  blnTransacaoLocal := False;
  Try
    FAudit.Limpar;

    If (Not blnNegociacao) Then
    Begin
      If (Not fInTransaction) Then
      Begin
        fStartTransaction;
        blnTransacaoLocal := True;
      End;
    End;

    Try
      If FOperac = 'I' Then
      Begin
        If fEmptyStr(FNumero) Then
          FNumero := fRetSequencial('PRO_OS');

        FAutInc := fRetAutoIncrem('EQUGER', FCodEmp);
        FAudit.Adicionar(FAutInc, 'EQUGER');

        If fEmptyStr(Trim(FNumero)) Or fEmptyStr(Trim(FAutInc)) Then
        Begin
          pMensagemOk('Ocorreu um erro ao pegar o próximo número do Conserto de Equipamento' + #13 + 'Tente novamente!');
          Result := False;
        End
        Else
        Begin
          strSQL := '';
          strSQL := strSQL + ' INSERT INTO EQUGER( ';
          strSQL := strSQL + '   AUTOINCREM, ';
          strSQL := strSQL + '   EQU_CODEMP, ';
          strSQL := strSQL + '   EQU_NUMOSE, ';
          strSQL := strSQL + '   EQU_DTAENT, ';
          strSQL := strSQL + '   EQU_HORENT, ';
          strSQL := strSQL + '   EQU_PREVIS, ';
          strSQL := strSQL + '   EQU_CODCLI, ';
          strSQL := strSQL + '   EQU_TABPRE, ';
          strSQL := strSQL + '   EQU_NOMCON, ';
          strSQL := strSQL + '   EQU_ENDCON, ';
          strSQL := strSQL + '   EQU_BAICON, ';
          strSQL := strSQL + '   EQU_CEPCON, ';
          strSQL := strSQL + '   EQU_CIDCON, ';
          strSQL := strSQL + '   EQU_TELCON, ';
          strSQL := strSQL + '   EQU_CGCCPF, ';
          strSQL := strSQL + '   EQU_CGCCON, ';
          If Not fEmptyStr(FCliEma) Then
            strSQL := strSQL + '   EQU_EMLCON, ';
          strSQL := strSQL + '   EQU_IESCON, ';
          strSQL := strSQL + '   EQU_R_GCON, ';
          strSQL := strSQL + '   EQU_CODTEC, ';
          strSQL := strSQL + '   EQU_CODVEN, ';
          strSQL := strSQL + '   EQU_CODEQU, ';
          strSQL := strSQL + '   EQU_DESCRI, ';
          strSQL := strSQL + '   EQU_DISSER, ';
          strSQL := strSQL + '   EQU_CODMAR, ';
          strSQL := strSQL + '   EQU_STATUS, ';
          strSQL := strSQL + '   EQU_SUBSTA, ';
          strSQL := strSQL + '   EQU_AG_MON, ';
          strSQL := strSQL + '   EQU_VLRCON, ';
          strSQL := strSQL + '   EQU_VLRPRO, ';
          strSQL := strSQL + '   EQU_VLRSER, ';
          strSQL := strSQL + '   EQU_OBSERV, ';
          strSQL := strSQL + '   EQU_ENTGER, ';
          strSQL := strSQL + '   EQU_JAPEDI, ';
          strSQL := strSQL + '   EQU_CODCND, ';
          strSQL := strSQL + '   EQU_CODFPG, ';
          strSQL := strSQL + '   EQU_NSERIE, ';
          strSQL := strSQL + '   EQU_ACESSO, ';
          strSQL := strSQL + '   EQU_GARANT, ';
          strSQL := strSQL + '   EQU_NFCOMP, ';
          strSQL := strSQL + '   EQU_REVEND, ';
          strSQL := strSQL + '   EQU_CONRET, ';
          strSQL := strSQL + '   EQU_DEIPOR, ';
          strSQL := strSQL + '   EQU_RETPOR, ';
          strSQL := strSQL + '   EQU_REAPOR, ';
          strSQL := strSQL + '   EQU_OSPDCL, ';
          strSQL := strSQL + '   EQU_DTNFCO, ';

          If FEntreg <> 0 Then
            strSQL := strSQL + '   EQU_ENTREG, ';

          strSQL := strSQL + '   EQU_CONPAG, ';
          strSQL := strSQL + '   EQU_CODVE2, ';
          strSQL := strSQL + '   EQU_DESESP, ';
          strSQL := strSQL + '   EQU_PORDES, ';
          strSQL := strSQL + '   EQU_VALDES, ';
          strSQL := strSQL + '   EQU_CODDIG, ';
          strSQL := strSQL + '   EQU_BASSIM, ';
          strSQL := strSQL + '   EQU_BASIPI, ';
          strSQL := strSQL + '   EQU_ALQIPI, ';
          strSQL := strSQL + '   EQU_TOTIPI, ';
          strSQL := strSQL + '   EQU_BASICM, ';
          strSQL := strSQL + '   EQU_ALQICM, ';
          strSQL := strSQL + '   EQU_TOTICM, ';
          strSQL := strSQL + '   EQU_TOTRET, ';
          strSQL := strSQL + '   EQU_TOTCBS, ';
          strSQL := strSQL + '   EQU_TOTIBS, ';
          strSQL := strSQL + '   EQU_TOT_IS, ';
          strSQL := strSQL + '   EQU_ALQRET, ';
          strSQL := strSQL + '   EQU_BASRET, ';
          strSQL := strSQL + '   EQU_PERISS, ';
          strSQL := strSQL + '   EQU_VALISS, ';
          strSQL := strSQL + '   EQU_BASISS, ';
          strSQL := strSQL + '   EQU_CODTRA, ';
          strSQL := strSQL + '   EQU_TIPFRE, ';
          strSQL := strSQL + '   EQU_TOTFRE, ';
          strSQL := strSQL + '   EQU_VOLUME, ';
          strSQL := strSQL + '   EQU_ESPECI, ';
          strSQL := strSQL + '   EQU_LOCFIS, ';
          strSQL := strSQL + '   EQU_REDISS, ';
          strSQL := strSQL + '   EQU_CODATI, ';
          strSQL := strSQL + '   EQU_NASCON, ';
          strSQL := strSQL + '   EQU_PROTOC, ';
          strSQL := strSQL + '   EQU_VENPRE, ';
          strSQL := strSQL + '   EQU_CNTCLI, ';
          strSQL := strSQL + '   EQU_CNTTEL, ';
          strSQL := strSQL + '   EQU_NUMPAT, ';
          strSQL := strSQL + '   EQU_DADFAB, ';
          strSQL := strSQL + '   EQU_CODEPR, ';
          strSQL := strSQL + '   EQU_REATEL, ';
          strSQL := strSQL + '   EQU_SITDTR, ';
          strSQL := strSQL + '   EQU_TMPGAR, ';
          strSQL := strSQL + '   EQU_FLXFAS, ';
          strSQL := strSQL + '   EQU_FLXSIT, ';
          strSQL := strSQL + '   EQU_FLXCOM, ';
          strSQL := strSQL + '   EQU_REA_RG, ';
          strSQL := strSQL + '   EQU_PRTATD, ';
          strSQL := strSQL + '   EQU_NOSFAB, ';
          strSQL := strSQL + '   EQU_NOSANT, ';
          strSQL := strSQL + '   EQU_DTEANT, ';
          strSQL := strSQL + '   EQU_DTRANT, ';
          strSQL := strSQL + '   EQU_NFREME, ';
          strSQL := strSQL + '   EQU_DTNFRE, ';
          strSQL := strSQL + '   EQU_EMPSER, ';
          strSQL := strSQL + '   EQU_DIAENT, ';
          strSQL := strSQL + '   EQU_DIGRET, ';
          strSQL := strSQL + '   EQU_OBSGER, ';
          strSQL := strSQL + '   EQU_OBSNFS, ';
          strSQL := strSQL + '   EQU_AUTDES, ';
          strSQL := strSQL + '   EQU_TIPAPR, ';
          strSQL := strSQL + '   EQU_ORI_PD, ';
          strSQL := strSQL + '   EQU_CODFAZ) ';
          strSQL := strSQL + '   VALUES ( ';
          strSQL := strSQL + '   :AUTINC, ';
          strSQL := strSQL + '   :CODEMP, ';
          strSQL := strSQL + '   :NUMOSE, ';
          strSQL := strSQL + '   :DTAENT, ';
          strSQL := strSQL + '   :HORENT, ';
          strSQL := strSQL + '   :PREVIS, ';
          strSQL := strSQL + '   :CODCLI, ';
          strSQL := strSQL + '   :TABPRE, ';
          strSQL := strSQL + '   :NOMCON, ';
          strSQL := strSQL + '   :ENDCON, ';
          strSQL := strSQL + '   :BAICON, ';
          strSQL := strSQL + '   :CEPCON, ';
          strSQL := strSQL + '   :CIDCON, ';
          strSQL := strSQL + '   :TELCON, ';
          strSQL := strSQL + '   :CGCCPF, ';
          strSQL := strSQL + '   :CGCCON, ';
          If Not fEmptyStr(FCliEma) Then
            strSQL := strSQL + '   :EMLCON, ';
          strSQL := strSQL + '   :IESCON, ';
          strSQL := strSQL + '   :R_GCON, ';
          strSQL := strSQL + '   :CODTEC, ';
          strSQL := strSQL + '   :CODVEN, ';
          strSQL := strSQL + '   :CODEQU, ';
          strSQL := strSQL + '   :DESCRI, ';
          strSQL := strSQL + '   :DISSER, ';
          strSQL := strSQL + '   :CODMAR, ';
          strSQL := strSQL + '   :STATUS, ';
          strSQL := strSQL + '   :SUBSTA, ';
          strSQL := strSQL + '   :AG_MON, ';
          strSQL := strSQL + '   :VLRCON, ';
          strSQL := strSQL + '   :VLRPRO, ';
          strSQL := strSQL + '   :VLRSER, ';
          strSQL := strSQL + '   :OBSERV, ';
          strSQL := strSQL + '   :ENTGER, ';
          strSQL := strSQL + '   :JAPEDI, ';
          strSQL := strSQL + '   :CODCND, ';
          strSQL := strSQL + '   :CODFPG, ';
          strSQL := strSQL + '   :NSERIE, ';
          strSQL := strSQL + '   :ACESSO, ';
          strSQL := strSQL + '   :GARANT, ';
          strSQL := strSQL + '   :NFCOMP, ';
          strSQL := strSQL + '   :REVEND, ';
          strSQL := strSQL + '   :CONRET, ';
          strSQL := strSQL + '   :DEIPOR, ';
          strSQL := strSQL + '   :RETPOR, ';
          strSQL := strSQL + '   :REAPOR, ';
          strSQL := strSQL + '   :OSPDCL, ';
          strSQL := strSQL + '   :DTNFCO, ';

          If FEntreg <> 0 Then
            strSQL := strSQL + '   :ENTREG, ';

          strSQL := strSQL + '   :CONPAG, ';
          strSQL := strSQL + '   :CODVE2, ';
          strSQL := strSQL + '   :DESESP, ';
          strSQL := strSQL + '   :PORDES, ';
          strSQL := strSQL + '   :VALDES, ';
          strSQL := strSQL + '   :CODDIG, ';
          strSQL := strSQL + '   :BASSIM, ';
          strSQL := strSQL + '   :BASIPI, ';
          strSQL := strSQL + '   :ALQIPI, ';
          strSQL := strSQL + '   :TOTIPI, ';
          strSQL := strSQL + '   :BASICM, ';
          strSQL := strSQL + '   :ALQICM, ';
          strSQL := strSQL + '   :TOTICM, ';
          strSQL := strSQL + '   :TOTRET, ';
          strSQL := strSQL + '   :TOTCBS, ';
          strSQL := strSQL + '   :TOTIBS, ';
          strSQL := strSQL + '   :TOT_IS, ';
          strSQL := strSQL + '   :ALQRET, ';
          strSQL := strSQL + '   :BASRET, ';
          strSQL := strSQL + '   :PERISS, ';
          strSQL := strSQL + '   :VALISS, ';
          strSQL := strSQL + '   :BASISS, ';
          strSQL := strSQL + '   :CODTRA, ';
          strSQL := strSQL + '   :TIPFRE, ';
          strSQL := strSQL + '   :TOTFRE, ';
          strSQL := strSQL + '   :VOLUME, ';
          strSQL := strSQL + '   :ESPECI, ';
          strSQL := strSQL + '   :LOCFIS, ';
          strSQL := strSQL + '   :REDISS, ';
          strSQL := strSQL + '   :CODATI, ';
          strSQL := strSQL + '   :NASCON, ';
          strSQL := strSQL + '   :PROTOC, ';
          strSQL := strSQL + '   :VENPRE, ';
          strSQL := strSQL + '   :CNTCLI, ';
          strSQL := strSQL + '   :CNTTEL, ';
          strSQL := strSQL + '   :NUMPAT, ';
          strSQL := strSQL + '   :DADFAB, ';
          strSQL := strSQL + '   :CODEPR, ';
          strSQL := strSQL + '   :REATEL, ';
          strSQL := strSQL + '   :SITDTR, ';
          strSQL := strSQL + '   :TMPGAR, ';
          strSQL := strSQL + '   :FLXFAS, ';
          strSQL := strSQL + '   :FLXSIT, ';
          strSQL := strSQL + '   :FLXCOM, ';
          strSQL := strSQL + '   :REA_RG, ';
          strSQL := strSQL + '   :PRTATD, ';
          strSQL := strSQL + '   :NOSFAB, ';
          strSQL := strSQL + '   :NOSANT, ';
          strSQL := strSQL + '   :DTEANT, ';
          strSQL := strSQL + '   :DTRANT, ';
          strSQL := strSQL + '   :NFREME, ';
          strSQL := strSQL + '   :DTNFRE, ';
          strSQL := strSQL + '   :EMPSER, ';
          strSQL := strSQL + '   :DIAENT, ';
          strSQL := strSQL + '   :DIGRET, ';
          strSQL := strSQL + '   :OBSGER, ';
          strSQL := strSQL + '   :OBSNFS, ';
          strSQL := strSQL + '   :AUTDES, ';
          strSQL := strSQL + '   :TIPAPR, ';
          strSQL := strSQL + '   :ORI_PD, ';
          strSQL := strSQL + '   :CODFAZ) ';
        End;
      End
      Else
      Begin
        strSQL := '';
        strSQL := strSQL + ' UPDATE EQUGER SET ';
        strSQL := strSQL + '   EQU_NOMCON = :NOMCON, ';
        strSQL := strSQL + '   EQU_ENDCON = :ENDCON, ';
        strSQL := strSQL + '   EQU_BAICON = :BAICON, ';
        strSQL := strSQL + '   EQU_CEPCON = :CEPCON, ';
        strSQL := strSQL + '   EQU_CIDCON = :CIDCON, ';
        strSQL := strSQL + '   EQU_TELCON = :TELCON, ';
        strSQL := strSQL + '   EQU_CGCCPF = :CGCCPF, ';
        strSQL := strSQL + '   EQU_CGCCON = :CGCCON, ';
        If Not fEmptyStr(FCliEma) Then
          strSQL := strSQL + '   EQU_EMLCON = :EMLCON, ';
        strSQL := strSQL + '   EQU_IESCON = :IESCON, ';
        strSQL := strSQL + '   EQU_R_GCON = :R_GCON, ';
        strSQL := strSQL + '   EQU_PREVIS = :PREVIS, ';
        strSQL := strSQL + '   EQU_CODVEN = :CODVEN, ';
        strSQL := strSQL + '   EQU_CODEQU = :CODEQU, ';
        strSQL := strSQL + '   EQU_DESCRI = :DESCRI, ';
        strSQL := strSQL + '   EQU_DISSER = :DISSER, ';
        strSQL := strSQL + '   EQU_CODMAR = :CODMAR, ';
        strSQL := strSQL + '   EQU_STATUS = :STATUS, ';
        strSQL := strSQL + '   EQU_SUBSTA = :SUBSTA, ';
        strSQL := strSQL + '   EQU_AG_MON = :AG_MON, ';
        strSQL := strSQL + '   EQU_VLRCON = :VLRCON, ';
        strSQL := strSQL + '   EQU_VLRPRO = :VLRPRO, ';
        strSQL := strSQL + '   EQU_VLRSER = :VLRSER, ';
        strSQL := strSQL + '   EQU_TABPRE = :TABPRE, ';
        strSQL := strSQL + '   EQU_OBSERV = :OBSERV, ';
        strSQL := strSQL + '   EQU_CODTEC = :CODTEC, ';
        strSQL := strSQL + '   EQU_ENTGER = :ENTGER, ';
        strSQL := strSQL + '   EQU_CODCND = :CODCND, ';
        strSQL := strSQL + '   EQU_CODFPG = :CODFPG, ';
        strSQL := strSQL + '   EQU_NSERIE = :NSERIE, ';
        strSQL := strSQL + '   EQU_ACESSO = :ACESSO, ';
        strSQL := strSQL + '   EQU_GARANT = :GARANT, ';
        strSQL := strSQL + '   EQU_NFCOMP = :NFCOMP, ';
        strSQL := strSQL + '   EQU_REVEND = :REVEND, ';
        strSQL := strSQL + '   EQU_CONRET = :CONRET, ';
        strSQL := strSQL + '   EQU_DEIPOR = :DEIPOR, ';
        strSQL := strSQL + '   EQU_RETPOR = :RETPOR, ';
        strSQL := strSQL + '   EQU_REAPOR = :REAPOR, ';
        strSQL := strSQL + '   EQU_OSPDCL = :OSPDCL, ';
        strSQL := strSQL + '   EQU_CODCLI = :CODCLI, ';
        strSQL := strSQL + '   EQU_TABPRE = :TABPRE, ';
        strSQL := strSQL + '   EQU_DTNFCO = :DTNFCO, ';

        If FEntreg <> 0 Then
          strSQL := strSQL + '   EQU_ENTREG = :ENTREG, ';

        strSQL := strSQL + '   EQU_CONPAG = :CONPAG,  ';
        strSQL := strSQL + '   EQU_CODVE2 = :CODVE2,  ';
        strSQL := strSQL + '   EQU_DESESP = :DESESP,  ';
        strSQL := strSQL + '   EQU_PORDES = :PORDES,  ';
        strSQL := strSQL + '   EQU_VALDES = :VALDES,  ';
        strSQL := strSQL + '   EQU_CODDIG = :CODDIG,  ';
        strSQL := strSQL + '   EQU_BASSIM = :BASSIM,  ';
        strSQL := strSQL + '   EQU_BASIPI = :BASIPI,  ';
        strSQL := strSQL + '   EQU_ALQIPI = :ALQIPI,  ';
        strSQL := strSQL + '   EQU_TOTIPI = :TOTIPI,  ';
        strSQL := strSQL + '   EQU_BASICM = :BASICM,  ';
        strSQL := strSQL + '   EQU_ALQICM = :ALQICM,  ';
        strSQL := strSQL + '   EQU_TOTICM = :TOTICM,  ';
        strSQL := strSQL + '   EQU_TOTRET = :TOTRET,  ';
        strSQL := strSQL + '   EQU_TOTCBS = :TOTCBS,  ';
        strSQL := strSQL + '   EQU_TOTIBS = :TOTIBS,  ';
        strSQL := strSQL + '   EQU_TOT_IS = :TOT_IS,  ';
        strSQL := strSQL + '   EQU_ALQRET = :ALQRET,  ';
        strSQL := strSQL + '   EQU_BASRET = :BASRET,  ';
        strSQL := strSQL + '   EQU_PERISS = :PERISS,  ';
        strSQL := strSQL + '   EQU_VALISS = :VALISS,  ';
        strSQL := strSQL + '   EQU_BASISS = :BASISS,  ';
        strSQL := strSQL + '   EQU_REDISS = :REDISS,  ';
        strSQL := strSQL + '   EQU_CODTRA = :CODTRA,  ';
        strSQL := strSQL + '   EQU_TIPFRE = :TIPFRE,  ';
        strSQL := strSQL + '   EQU_TOTFRE = :TOTFRE,  ';
        strSQL := strSQL + '   EQU_VOLUME = :VOLUME,  ';
        strSQL := strSQL + '   EQU_ESPECI = :ESPECI,  ';
        strSQL := strSQL + '   EQU_LOCFIS = :LOCFIS,  ';
        strSQL := strSQL + '   EQU_CODATI = :CODATI,  ';
        strSQL := strSQL + '   EQU_NASCON = :NASCON,  ';
        strSQL := strSQL + '   EQU_PROTOC = :PROTOC,  ';
        strSQL := strSQL + '   EQU_VENPRE = :VENPRE,  ';
        strSQL := strSQL + '   EQU_CNTCLI = :CNTCLI,  ';
        strSQL := strSQL + '   EQU_CNTTEL = :CNTTEL,  ';
        strSQL := strSQL + '   EQU_NUMPAT = :NUMPAT,  ';
        strSQL := strSQL + '   EQU_DADFAB = :DADFAB,  ';
        strSQL := strSQL + '   EQU_CODEPR = :CODEPR,  ';
        strSQL := strSQL + '   EQU_REATEL = :REATEL,  ';
        strSQL := strSQL + '   EQU_SITDTR = :SITDTR,  ';
        strSQL := strSQL + '   EQU_TMPGAR = :TMPGAR,  ';
        strSQL := strSQL + '   EQU_FLXFAS = :FLXFAS,  ';
        strSQL := strSQL + '   EQU_FLXSIT = :FLXSIT,  ';
        strSQL := strSQL + '   EQU_FLXCOM = :FLXCOM,  ';
        strSQL := strSQL + '   EQU_REA_RG = :REA_RG,  ';
        strSQL := strSQL + '   EQU_PRTATD = :PRTATD,  ';
        strSQL := strSQL + '   EQU_NOSFAB = :NOSFAB,  ';
        strSQL := strSQL + '   EQU_NOSANT = :NOSANT,  ';
        strSQL := strSQL + '   EQU_DTEANT = :DTEANT,  ';
        strSQL := strSQL + '   EQU_DTRANT = :DTRANT,  ';
        strSQL := strSQL + '   EQU_NFREME = :NFREME,  ';
        strSQL := strSQL + '   EQU_DTNFRE = :DTNFRE,  ';
        strSQL := strSQL + '   EQU_EMPSER = :EMPSER,  ';
        strSQL := strSQL + '   EQU_DIAENT = :DIAENT,  ';
        strSQL := strSQL + '   EQU_DIGRET = :DIGRET,  ';
        strSQL := strSQL + '   EQU_OBSGER = :OBSGER,  ';
        strSQL := strSQL + '   EQU_OBSNFS = :OBSNFS,  ';
        strSQL := strSQL + '   EQU_AUTDES = :AUTDES,  ';
        strSQL := strSQL + '   EQU_TIPAPR = :TIPAPR,  ';
        strSQL := strSQL + '   EQU_ORI_PD = :ORI_PD,  ';
        strSQL := strSQL + '   EQU_CODFAZ = :CODFAZ   ';
        strSQL := strSQL + ' WHERE ';
        strSQL := strSQL + '   EQU_CODEMP = :CODEMP AND ';
        strSQL := strSQL + '   EQU_NUMOSE = :NUMOSE ';
      End;

      If Result Then
      Begin
        qryGen := fCriaQuery;

        With qryGen Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);

          If FOperac = 'I' Then
          Begin
            ParamByName('AUTINC').AsString   := FAutInc;
            ParamByName('CODEMP').AsString   := FCodEmp;
            ParamByName('NUMOSE').AsString   := FNumero;
            ParamByName('DTAENT').AsDateTime := FDtaEnt; //VS_Date;
            ParamByName('HORENT').AsDateTime := FHorEnt;
            ParamByName('PREVIS').Value      := IIF(FPrevis > 0, FPrevis, Null);
            ParamByName('CODCLI').AsString   := FCodCli;
            ParamByName('TABPRE').AsString   := FTabPre;

            {**********************}
            {* CLIENTE CONSUMIDOR *}
            {*******************JC*}
            ParamByName('NOMCON').AsString   := FCliNom;
            ParamByName('ENDCON').AsString   := FCliEnd;
            ParamByName('BAICON').AsString   := FCliBai;
            ParamByName('CEPCON').AsString   := FCliCep;

            If fEmptyStr(FCodCid) Then
              ParamByName('CIDCON').Value    := Null
            Else
              ParamByName('CIDCON').AsString := FCodCid;

            If Not fEmptyStr(FCliEma) Then
              ParamByName('EMLCON').AsString   := FCliEma;

            ParamByName('TELCON').AsString   := FCliTel;
            ParamByName('CGCCPF').AsInteger  := FCgcCpf;
            ParamByName('CGCCON').AsString   := FCliCgc;
            ParamByName('IESCON').AsString   := FCliIes;
            ParamByName('R_GCON').AsString   := FCli_Rg;

            If fEmptyStr(FCodTec) Then
              ParamByName('CODTEC').Value    := Null
            Else
              ParamByName('CODTEC').AsString := FCodTec;

            ParamByName('CODVEN').AsString   := FCodVen;
            ParamByName('CODEQU').AsString   := FCodEqu;
            ParamByName('DESCRI').AsString   := FDescri;
            ParamByName('DISSER').AsString   := FDisSer;

            If fEmptyStr(strMarEqu) Then
              ParamByName('CODMAR').Value    := Null
            Else
              ParamByName('CODMAR').AsString := FMarEqu;

            ParamByName('STATUS').AsString   := FStatus;
            ParamByName('SUBSTA').AsString   := FSubSta;
            ParamByName('AG_MON').AsString   := IIF(FAg_Mon, 'S', 'N');
            ParamByName('VLRCON').AsFloat    := FVlrCon;
            ParamByName('VLRPRO').AsFloat    := FVlrPro;
            ParamByName('VLRSER').AsFloat    := FVlrSer;
            ParamByName('JAPEDI').AsInteger  := 0;
            ParamByName('OBSERV').AsString   := FObserv;
            ParamByName('ENTGER').AsString   := FEntGer;

            ParamByName('NSERIE').AsString   := FNSerie;
            ParamByName('ACESSO').AsString   := FAcesso;
            ParamByName('GARANT').AsString   := FGarant;
            ParamByName('REVEND').AsString   := FRevend;
            ParamByName('CONRET').AsString   := FConRet;
            ParamByName('DEIPOR').AsString   := FDeiPor;
            ParamByName('RETPOR').AsString   := FRetPor;
            ParamByName('REAPOR').AsString   := FReaPor;
            ParamByName('OSPDCL').AsString   := FOsPdCl;
            ParamByName('NFCOMP').AsString   := FNFComp;
            ParamByName('DTNFCO').AsDatetime := FDtNFCo;

            If (Not fEmptyStr(FCodTra)) Then
              ParamByName('CODTRA').AsString := FCodTra
            Else
              ParamByName('CODTRA').Value    := Null;

            If (Not fEmptyStr(FTipFre)) Then
              ParamByName('TIPFRE').AsString := FTipFre
            Else
              ParamByName('TIPFRE').Value    := Null;

            If (FValFre > 0) Then
              ParamByName('TOTFRE').AsFloat  := FValFre
            Else
              ParamByName('TOTFRE').Value    := Null;

            If (FQtdTra > 0) Then
              ParamByName('VOLUME').AsInteger := FQtdTra
            Else
              ParamByName('VOLUME').Value     := Null;

            If (Not fEmptyStr(FEspTra)) Then
              ParamByName('ESPECI').AsString := FEspTra
            Else
              ParamByName('ESPECI').Value    := Null;

            If (Not fEmptyStr(FLocFisEqu)) Then
              ParamByName('LOCFIS').AsString := FLocFisEqu
            Else
              ParamByName('LOCFIS').Value    := Null;

            If FEntreg <> 0Then
              ParamByName('ENTREG').AsDatetime := FEntreg;

          End
          Else
          Begin
            {**********************}
            {* CLIENTE CONSUMIDOR *}
            {*******************JC*}
            ParamByName('NOMCON').AsString   := FCliNom;
            ParamByName('ENDCON').AsString   := FCliEnd;
            ParamByName('BAICON').AsString   := FCliBai;
            ParamByName('CEPCON').AsString   := FCliCep;

            If fEmptyStr(FCodCid) Then
              ParamByName('CIDCON').Value    := Null
            Else
              ParamByName('CIDCON').AsString := FCodCid;

            ParamByName('TELCON').AsString   := FCliTel;
            ParamByName('CGCCPF').AsInteger  := FCgcCpf;
            ParamByName('CGCCON').AsString   := FCliCgc;
            ParamByName('IESCON').AsString   := FCliIes;
            ParamByName('R_GCON').AsString   := FCli_Rg;
            If Not fEmptyStr(FCliEma) Then
              ParamByName('EMLCON').AsString   := FCliEma;

            ParamByName('PREVIS').Value      := IIF(FPrevis > 0, FPrevis, Null);
            ParamByName('CODEMP').AsString   := FCodEmp;
            ParamByName('NUMOSE').AsString   := FNumero;
            ParamByName('CODVEN').AsString   := FCodVen;
            ParamByName('CODEQU').AsString   := FCodEqu;
            ParamByName('DESCRI').AsString   := FDescri;
            ParamByName('DISSER').AsString   := FDisSer;

            If fEmptyStr(strMarEqu) Then
              ParamByName('CODMAR').Value    := Null
            Else
              ParamByName('CODMAR').AsString := FMarEqu;

            ParamByName('STATUS').AsString   := FStatus;
            ParamByName('SUBSTA').AsString   := FSubSta;
            ParamByName('AG_MON').AsString   := IIF(FAg_Mon, 'S', 'N');
            ParamByName('VLRCON').AsFloat    := FVlrCon;
            ParamByName('VLRPRO').AsFloat    := FVlrPro;
            ParamByName('VLRSER').AsFloat    := FVlrSer;
            ParamByName('TABPRE').AsString   := FTabPre;
            ParamByName('OBSERV').AsString   := FObserv;
            ParamByName('ENTGER').AsString   := FEntGer;

            If fEmptyStr(FCodTec) Then
              ParamByName('CODTEC').Value    := Null
            Else
              ParamByName('CODTEC').AsString := FCodTec;

            ParamByName('NSERIE').AsString   := FNSerie;
            ParamByName('ACESSO').AsString   := FAcesso;
            ParamByName('GARANT').AsString   := FGarant;
            ParamByName('REVEND').AsString   := FRevend;
            ParamByName('CONRET').AsString   := FConRet;
            ParamByName('DEIPOR').AsString   := FDeiPor;
            ParamByName('RETPOR').AsString   := FRetPor;
            ParamByName('REAPOR').AsString   := FReaPor;
            ParamByName('OSPDCL').AsString   := FOsPdCl;
            ParamByName('NFCOMP').AsString   := FNFComp;
            ParamByName('CODCLI').AsString   := FCodCli;
            ParamByName('TABPRE').AsString   := FTabPre;
            ParamByName('DTNFCO').AsDatetime := FDtNFCo;

            If (Not fEmptyStr(FCodTra)) Then
              ParamByName('CODTRA').AsString := FCodTra
            Else
              ParamByName('CODTRA').Value    := Null;

            If (Not fEmptyStr(FTipFre)) Then
              ParamByName('TIPFRE').AsString := FTipFre
            Else
              ParamByName('TIPFRE').Value    := Null;

            If (FValFre > 0) Then
              ParamByName('TOTFRE').AsFloat  := FValFre
            Else
              ParamByName('TOTFRE').Value    := Null;

            If (FQtdTra > 0) Then
              ParamByName('VOLUME').AsInteger := FQtdTra
            Else
              ParamByName('VOLUME').Value     := Null;

            If (Not fEmptyStr(FEspTra)) Then
              ParamByName('ESPECI').AsString := FEspTra
            Else
              ParamByName('ESPECI').Value    := Null;

            If (Not fEmptyStr(FLocFisEqu)) Then
              ParamByName('LOCFIS').AsString := FLocFisEqu
            Else
              ParamByName('LOCFIS').Value    := Null;

            If FEntreg <> 0 Then
              ParamByName('ENTREG').AsDatetime := FEntreg;
          End;

          ParamByName('CODCND').AsString := FCodCnd;
          ParamByName('CODFPG').AsString := FCodFpg;
          ParamByName('CONPAG').AsString := FConPag;

          If (fEmptyStr(FCodVe2)) Then
            ParamByName('CODVE2').Value    := Null
          Else
            ParamByName('CODVE2').AsString := FCodVe2;

          If (fEmptyStr(FCodDig)) Then
            ParamByName('CODDIG').Value    := Null
          Else
            ParamByName('CODDIG').AsString := FCodDig;

          ParamByName('DESESP').AsFloat := FDesEsp;
          ParamByName('PORDES').AsFloat := FPorDes;
          ParamByName('VALDES').AsFloat := FValDes;
          ParamByName('BASSIM').AsFloat := FTribEquGer.fltBASSIM;
          ParamByName('BASIPI').AsFloat := FTribEquGer.fltBASIPI;
          ParamByName('ALQIPI').AsFloat := FTribEquGer.fltALQIPI;
          ParamByName('TOTIPI').AsFloat := FTribEquGer.fltTOTIPI;
          ParamByName('BASICM').AsFloat := FTribEquGer.fltBASICM;
          ParamByName('ALQICM').AsFloat := FTribEquGer.fltALQICM;
          ParamByName('TOTICM').AsFloat := FTribEquGer.fltTOTICM;
          ParamByName('TOTRET').AsFloat := FTribEquGer.fltTOTRET;
          ParamByName('TOTCBS').AsFloat := FTribEquGer.fltTotCbs;
          ParamByName('TOTIBS').AsFloat := FTribEquGer.fltTotIbs;
          ParamByName('TOT_IS').AsFloat := FTribEquGer.fltTotIs;
          ParamByName('ALQRET').AsFloat := FTribEquGer.fltALQRET;
          ParamByName('BASRET').AsFloat := FTribEquGer.fltBASRET;
          ParamByName('PERISS').AsFloat := FTribEquGer.fltPERISS;
          ParamByName('VALISS').AsFloat := FTribEquGer.fltVALISS;
          ParamByName('BASISS').AsFloat := FTribEquGer.fltBASISS;
          ParamByName('REDISS').AsFloat := FTribEquGer.fltREDISS;
          ParamByName('CODATI').AsString := FCodAti;

          If FNasCon > 0 Then
            ParamByName('NASCON').AsDateTime := FNasCon;

          If (fEmptyStr(FProtoc)) Then
          Begin
            ParamByName('PROTOC').Value := Null;
          End
          Else
          Begin
            ParamByName('PROTOC').AsString := FProtoc;
          End;

          ParamByName('VENPRE').AsString := IIF(FVenPre, 'S', 'N');

          ParamByName('CNTCLI').AsString   := FCntCli;
          ParamByName('CNTTEL').AsString   := FCntTel;
          ParamByName('NUMPAT').AsString   := FNumPat;
          ParamByName('DADFAB').AsString   := FDadFab;

          If (fEmptyStr(FCodEpr)) Then
            ParamByName('CODEPR').Value   := Null
          Else
            ParamByName('CODEPR').AsString   := FCodEpr;

          ParamByName('REATEL').AsString   := FReaTel;

          If FSitDtr > 0 Then
            ParamByName('SITDTR').AsDateTime := FSitDtr
          Else
            ParamByName('SITDTR').Value := Null;

          If FTmpGar > 0 Then
            ParamByName('TMPGAR').AsInteger := FTmpGar
          Else
            ParamByName('TMPGAR').Value := Null;

          ParamByName('FLXFAS').AsString   := FFlxFas;
          ParamByName('FLXSIT').AsString   := FFlxSit;
          ParamByName('FLXCOM').AsString   := FFlxCom;
          ParamByName('REA_RG').AsString   := FRea_RG;
          ParamByName('PRTATD').AsString   := IIF(FPrtAtd, 'S', 'N');
          ParamByName('NOSFAB').AsString   := FNOSFab;

          if (not fEmptyStr(FNOSAnt)) then
            ParamByName('NOSANT').AsString   := FNOSAnt
          else
            ParamByName('NOSANT').Value      := Null;

          if (FDtEAnt > 0) then
            ParamByName('DTEANT').AsDateTime := FDtEAnt
          else
            ParamByName('DTEANT').Value      := Null;

          if (FDtRAnt > 0) then
            ParamByName('DTRANT').AsDateTime := FDtRAnt
          else
            ParamByName('DTRANT').Value      := Null;

          ParamByName('NFREME').AsString   := FNFReme;

          if (FDtNFRe > 0) then
            ParamByName('DTNFRE').AsDateTime := FDtNFRe
          else
            ParamByName('DTNFRE').Value      := Null;

          ParamByName('EMPSER').AsString  := FEmpSer;
          ParamByName('DIAENT').AsInteger := FDiaEnt;

          if (not fEmptyStr(FDigRet)) then
            ParamByName('DIGRET').AsString   := FDigRet
          else
            ParamByName('DIGRET').Value      := Null;

          ParamByName('OBSGER').AsString  := FObsGer;
          ParamByName('OBSNFS').AsString  := FObsNFS;
          ParamByName('AUTDES').AsString := IIF(FblnAutDes, 'S', 'N');
          ParamByName('TIPAPR').AsString := FTipApr;
          ParamByName('ORI_PD').AsString := FOri_PD;
          ParamByName('CODFAZ').AsString := FCodFaz;

          ExecSQL;
          Result := True;

          TTestabilidade.fGetTestabilidade.NumeroDocumento  := FNumero;
          TTestabilidade.fGetTestabilidade.EspecieDocumento := FEspTra;
          TTestabilidade.fGetTestabilidade.EmpresaDocumento := VS_strCodEmp;
          TTestabilidade.fGetTestabilidade.ClienteDocumento := strCodCli;
          TTestabilidade.fGetTestabilidade.DocumentoOriginal:= FNumero;
        End;

        Result := fGravaEquDet;
        Result := Result And fGravaEquSer;
        Result := Result And fGravaEquDfe;
        Result := Result And fGravaEquAce;

        if Result And fValidaTotRet(FNumero, FCodEmp) then
        Begin
          Raise Exception.Create('Houve um erro na totalização dos impostos desta ordem de serviço. '+ #13 +
                                 'Feche o AutCom, reabra e redigite a ordem de serviço. '+ #13 +
                                 'Caso o erro ocorra novamente entre em contato com a Citel! ');
        End;

        FreeAndNil(qryGen);
      End;
    except
      on E: Exception do
      begin
        if blnTransacaoLocal then
          fRollback;

        Result := False;
        pMensagensErro(E.Message, '[TConEqu.fGravaEquGer]');
      end;
    end;
  Finally
    If (Not blnNegociacao) Then
    Begin
      If (Result) And (Not FAudit.fValidouTodas(strErrAudit)) Then
      Begin
        Result := False;
        fRollBack;
        pMostraErrosAuditoria(strErrAudit);
      End;

      If blnTransacaoLocal Then
      Begin
        If Result Then
          fCommit
        Else
          fRollback;
      End;
    End;
  End;
End;

destructor TConEqu.Destroy;
begin
  cdsIteEqu.AfterOpen := nil;
  cdsSerEqu.AfterOpen := nil;
  cdsDfeEqu.AfterOpen := nil;
  cdsAceEqu.AfterOpen := nil;
  cdsApoEqu.AfterOpen := nil;
  Application.ProcessMessages;

  FreeAndNil(cdsIteEqu);
  FreeAndNil(cdsSerEqu);
  FreeAndNil(cdsDfeEqu);
  FreeAndNil(cdsAceEqu);
  FreeAndNil(cdsApoEqu);
  FreeAndNil(cdsGerMOS);

  FreeAndNil(qryEquGer);
  FreeAndNil(qryEquDet);
  FreeAndNil(qryEquSer);
  FreeAndNil(qryEquDfe);
  FreeAndNil(qryEquAce);
  FreeAndNil(qryEquApo);
  FreeAndNil(qryRelatorio);

  If (Assigned(FCdsIteEquLog)) Then FreeAndNil(FCdsIteEquLog);
  If (Assigned(FCdsSerEquLog)) Then FreeAndNil(FCdsSerEquLog);
  If (Assigned(FCdsDfeEquLog)) Then FreeAndNil(FCdsDfeEquLog);
  If (Assigned(FCdsAceEquLog)) Then FreeAndNil(FCdsAceEquLog);
  if (Assigned(objLiberacao) ) Then FreeAndNil(objLiberacao);
  If (Assigned(FcdsListaCodigoProfissionais)) Then FreeAndNil(FcdsListaCodigoProfissionais);
  If (Assigned(FcdsMovRcd))    Then FreeAndNil(FcdsMovRcd);
  If (Assigned(cdsDocGer))     Then FreeAndNil(cdsDocGer);
  If (Assigned(objFatVendaImp))Then objFatVendaImp.Destroy;

  if Assigned(FFazenda) then
    FreeAndNil(FFazenda);

  inherited Destroy;
end;

function TConEqu.fDefeitoJaInclusoGrid(strCodDfe: String): Boolean;
begin
  Result := False;

  If fEmptyStr(strCodDfe) Then
    Exit;

  If Assigned(cdsDfeEqu) Then Begin
    cdsDfeEqu.First;
    While Not cdsDfeEqu.Eof Do Begin

      If (cdsDfeEqu.FieldByName('CODDFE').AsString = strCodDfe) Then Begin
        Result := True;
        Exit;
      End;

      cdsDfeEqu.Next;
    End;
  End;
end;

function TConEqu.fDefineTipPed: String;
begin
  if (Pos(fCfgSis('TIPEXP'), '3_4_') > 0) and (fCfgSis('TPDCEX') = '2') then
    Result := ''
  else
    Result := IIF(strSubSta = 'B', 'B', 'A');
end;

procedure TConEqu.pDescreverLogAlteracoesOS;
var
  objTabelaItem      : TRegistroMsgLiberaTabela;
  objTabelaDefeito   : TRegistroMsgLiberaTabela;
  objTabelaServico   : TRegistroMsgLiberaTabela;
  objTabelaAcessorio : TRegistroMsgLiberaTabela;
  objLinha           : TLinhaMsgLibera;
begin
  objTabelaItem      := fVerificarAlteracoesItem();
  objTabelaDefeito   := fVerificarAlteracoesDefeito();
  objTabelaServico   := fVerificarAlteracoesServico();
  objTabelaAcessorio := fVerificarAlteracoesAcessorio();

  If (Not objTabelaDefeito.isEmpty) Then 
  Begin
    If (objLiberacao.objMsgRemota.isEmpty) Then
      objLiberacao.objMsgRemota.pAddQuebra;

    objLiberacao.objMsgRemota.pAddSeparador(131);

    objLiberacao.objMsgRemota.pAddTexto('MANUTENÇÃO DE DEFEITOS NA ORDEM DE SERVIÇO', alCentro, teAmbos, '', 131);

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'OPERAÇÃO'   , 15  , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'CÓD.'       , 5   , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'DESCRIÇÃO'  , 104 , alEsquerda , teAutcom);
    objTabelaDefeito.lstLinhas.Insert(0, objLinha);

    objLiberacao.objMsgRemota.lstRegistros.Add(objTabelaDefeito);
  End
  else
    FreeAndNil(objTabelaDefeito);

  If (Not objTabelaItem.isEmpty) Then 
  Begin
    If (objLiberacao.objMsgRemota.isEmpty) Then
      objLiberacao.objMsgRemota.pAddQuebra;

    If Assigned(objTabelaDefeito) Then
      objLiberacao.objMsgRemota.pAddSeparador(131);

    objLiberacao.objMsgRemota.pAddTexto('MANUTENÇÃO DE ITENS NA ORDEM DE SERVIÇO', alCentro, teAmbos, '', 131);

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'OPERAÇÃO'   , 15 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'CÓD.'       , 5  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'DESCRIÇÃO'  , 34 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'REFERÊNCIA' , 11 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'FÁBRICA'    , 11 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'UN'         , 2  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'QUANTIDADE' , 10 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'VR.UNITÁRIO', 12 , alDireita  , teAutcom);
    objLinha.pAddColuna(''  , 'VR.TOTAL'   , 12 , alDireita  , teAutcom);
    objTabelaItem.lstLinhas.Insert(0, objLinha);

    objLiberacao.objMsgRemota.lstRegistros.Add(objTabelaItem);
  End
  else
    FreeAndNil(objTabelaItem);

  If (Not objTabelaServico.isEmpty ) Then 
  Begin
    If (objLiberacao.objMsgRemota.isEmpty) Then
      objLiberacao.objMsgRemota.pAddQuebra;

    If Assigned(objTabelaItem) Then
      objLiberacao.objMsgRemota.pAddSeparador(131);

    objLiberacao.objMsgRemota.pAddTexto('MANUTENÇÃO DE SERVIÇOS NA ORDEM DE SERVIÇO', alCentro, teAmbos, '', 131);

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'OPERAÇÃO'   , 15 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'CÓD.'       , 5  , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'DESCRIÇÃO'  , 58 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'TÉCNICO'    , 30 , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'VR.TOTAL'   , 12 , alDireita  , teAutcom);
    objTabelaServico.lstLinhas.Insert(0, objLinha);

    objLiberacao.objMsgRemota.lstRegistros.Add(objTabelaServico);
  End
  else
    FreeAndNil(objTabelaServico);

  If (Not objTabelaAcessorio.isEmpty) Then 
  Begin
    If (objLiberacao.objMsgRemota.isEmpty) Then
      objLiberacao.objMsgRemota.pAddQuebra;

    objLiberacao.objMsgRemota.pAddSeparador(131);

    objLiberacao.objMsgRemota.pAddTexto('MANUTENÇÃO DE ACESSÓRIOS NA ORDEM DE SERVIÇO', alCentro, teAmbos, '', 131);

    objLinha  := TLinhaMsgLibera.Create;
    objLinha.enuTipoLinha := tlCabecalho;
    objLinha.pAddColuna(''  , 'OPERAÇÃO'   , 15  , alEsquerda , teAutcom);
    objLinha.pAddColuna(''  , 'CÓD.'       , 5   , alCentro   , teAutcom);
    objLinha.pAddColuna(''  , 'DESCRIÇÃO'  , 104 , alEsquerda , teAutcom);
    objTabelaAcessorio.lstLinhas.Insert(0, objLinha);

    objLiberacao.objMsgRemota.lstRegistros.Add(objTabelaAcessorio);
  End
  else
    FreeAndNil(objTabelaAcessorio);

  FLogModificao := (Not Assigned(objTabelaItem)) Or (Not Assigned(objTabelaServico));

end;

function TConEqu.fDesmembrarItensServicos: Boolean;
begin
  Result := False;

  if (FTipApr = 'B') and fCfgSis('DESOSC', varBoolean) then
    Exit(True);

  if (not fCfgSis('DESOSG', varBoolean)) then
    Exit;

  if (FGarant <> 'F') then
    Exit;

  if (fEmptyStr(FCliGar)) then
    Exit;

  Result := True;
end;

class function TConEqu.fDesvinculaNotaFiscalEmOS(objMeqMer: TMeqMer): Boolean;
  Var
    strSQL: String;
    qryTmp: TUniQuery;
begin
  Try
    qryTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' DELETE FROM ';
    strSQL := strSQL + '   MEQMER    ';
    strSQL := strSQL + ' WHERE       ';

    If Not fEmptyStr(objMeqMer.strAutGer) Then
      strSQL := strSQL + ' MER_AUTGER = :AUTINC '
    Else
    Begin
      strSQL := strSQL + ' MER_NUMDOC = :NUMDOC AND ';
      strSQL := strSQL + ' MER_ESPDOC = :ESPDOC AND ';
      strSQL := strSQL + ' MER_EMPGER = :EMPGER AND ';
      strSQL := strSQL + ' MER_CODCLI = :CODCLI AND ';
      strSQL := strSQL + ' MER_SERIE_ = :SERIE_ AND ';
      strSQL := strSQL + ' MER_TIPOPE = :TIPOPE     ';
    End;

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(objMeqMer.strAutGer) Then
        ParamByName('AUTINC').AsString := objMeqMer.strAutGer
      Else
      Begin
        ParamByName('NUMDOC').AsString := objMeqMer.strNumDoc;
        ParamByName('ESPDOC').AsString := objMeqMer.strEspDoc;
        ParamByName('EMPGER').AsString := objMeqMer.strEmpGer;
        ParamByName('CODCLI').AsString := objMeqMer.strCodCli;
        ParamByName('SERIE_').AsString := objMeqMer.strSerie_;
        ParamByName('TIPOPE').AsString := objMeqMer.strTipOpe;
      End;

      ExecSQL;

      Result := RowsAffected > 0;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TConEqu.fDesvinculaNotaFiscalEmOS]');
    End;
  End;

  FreeAndNil(qryTmp);
end;

class function TConEqu.fDesvinculaOSemNotaFiscal(objMeqMer: TMeqMer): Boolean;
  Var
    strSQL: String;
    qryTmp: TUniQuery;
begin
  Try
    qryTmp := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' DELETE FROM ';
    strSQL := strSQL + '   MEQMER    ';
    strSQL := strSQL + ' WHERE       ';

    If Not fEmptyStr(objMeqMer.strAutInc) Then
      strSQL := strSQL + ' AUTOINCREM = :AUTINC '
    Else
    Begin
      strSQL := strSQL + ' MER_AUTEQU = :AUTEQU AND ';
      strSQL := strSQL + ' MER_EMPEQU = :EMPEQU AND ';
      strSQL := strSQL + ' MER_NUMOSE = :NUMOSE AND ';
      strSQL := strSQL + ' MER_TIPOPE = :TIPOPE     ';
    End;

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(objMeqMer.strAutInc) Then
        ParamByName('AUTINC').AsString := objMeqMer.strAutInc
      Else
      Begin
        ParamByName('AUTEQU').AsString := objMeqMer.strAutEqu;
        ParamByName('EMPEQU').AsString := objMeqMer.strEmpEqu;
        ParamByName('NUMOSE').AsString := objMeqMer.strNumOse;
        ParamByName('TIPOPE').AsString := objMeqMer.strTipOpe;
      End;

      ExecSQL;

      Result := RowsAffected > 0;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TConEqu.fDesvinculaOSemNotaFiscal]');
    End;
  End;

  FreeAndNil(qryTmp);
end;

function TConEqu.fEhOSOriginadaDePedido: Boolean;
begin
  Result := True;

  if (FOri_PD = 'S') then
    Exit;

  if (AnsiUpperCase(FDescri).StartsWith('OS GERADA PELO DOCUMENTO')) then
    Exit;

  Result := False;
end;

function TConEqu.fGravaApontamento(strCodTec, strCodApo, strTipOpe: String): Boolean;
var
  strSQL: String;
  qryGen: TUniQuery;
begin
  Result := True;

  try
    fStartTransaction;
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' INSERT INTO EQUAPO ';
    strSQL := strSQL + '    (AUTOINCREM, ';
    strSQL := strSQL + '     EQU_SEQGER, ';
    strSQL := strSQL + '     EQU_CODTEC, ';
    strSQL := strSQL + '     EQU_CODAPO, ';
    strSQL := strSQL + '     EQU_TIPOPE, ';
    strSQL := strSQL + '     EQU_DTAAPO) ';
    strSQL := strSQL + ' VALUES ';
    strSQL := strSQL + '    (:AUTINC, ';
    strSQL := strSQL + '     :SEQGER, ';
    strSQL := strSQL + '     :CODTEC, ';
    strSQL := strSQL + '     :CODAPO, ';
    strSQL := strSQL + '     :TIPOPE, ';
    strSQL := strSQL + '     :DTAAPO) ';

    try
      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);

      qryGen.ParamByName('AUTINC').AsString   := fRetAutoIncrem('EQUAPO', FCodEmp);
      qryGen.ParamByName('SEQGER').AsString   := FAutInc;
      qryGen.ParamByName('CODTEC').AsString   := strCodTec;
      qryGen.ParamByName('CODAPO').AsString   := strCodApo;
      qryGen.ParamByName('TIPOPE').AsString   := strTipOpe;
      qryGen.ParamByName('DTAAPO').AsDateTime := nOw;
      qryGen.ExecSQL;

      fCommit;
    except
      on E: Exception do
      begin
        fRollback;
        pMensagensErro(E.Message, '[TConEqu.fGravaApontamento]');
        Result := False;
      end;
    end;
  finally
    FreeAndNil(qryGen);
  end;
end;

function TConEqu.fGravaEquAce: Boolean;
var
  strSQL: String;
  qryGen: TUniQuery;
Begin
  Result := True;

  Try
    cdsAceEqu.DisableControls;
    qryGen := fCriaQuery;

    If FOperac <> 'I' Then
    Begin
      strSQL := '';
      strSQL := strSQL + ' DELETE FROM EQUACE ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + ' EQU_CODEMP = :CODEMP AND ';
      strSQL := strSQL + ' EQU_NUMOSE = :NUMOSE ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('NUMOSE').AsString := FNumero;
        ExecSQL;
      End;
    End;

    strSQL := '';
    strSQL := strSQL + ' INSERT INTO EQUACE( ';
    strSQL := strSQL + '   AUTOINCREM, ';
    strSQL := strSQL + '   EQU_SEQGER, ';
    strSQL := strSQL + '   EQU_CODEMP, ';
    strSQL := strSQL + '   EQU_NUMOSE, ';
    strSQL := strSQL + '   EQU_CODACE, ';
    strSQL := strSQL + '   EQU_DESACE, ';
    strSQL := strSQL + '   EQU_QTDACE) ';
    strSQL := strSQL + ' VALUES ( ';
    strSQL := strSQL + '   :AUTINC, ';
    strSQL := strSQL + '   :SEQGER, ';
    strSQL := strSQL + '   :CODEMP, ';
    strSQL := strSQL + '   :NUMOSE, ';
    strSQL := strSQL + '   :CODACE, ';
    strSQL := strSQL + '   :DESACE, ';
    strSQL := strSQL + '   :QTDACE) ';
    cdsAceEqu.First;

    While Not cdsAceEqu.Eof Do
    Begin
      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('AUTINC').AsString   := fRetAutoIncrem('EQUACE', FCodEmp);
        ParamByName('SEQGER').AsString   := FAutInc;
        ParamByName('CODEMP').AsString   := FCodEmp;
        ParamByName('NUMOSE').AsString   := FNumero;
        ParamByName('CODACE').AsString   := cdsAceEqu.fieldbyname('CODACE').AsString;
        ParamByName('DESACE').AsString   := cdsAceEqu.fieldbyname('DESACE').AsString;
        ParamByName('QTDACE').AsFloat    := cdsAceEqu.fieldbyname('QTDACE').AsFloat;
        ExecSQL;
      End;

      cdsAceEqu.Next;
    End;
    cdsAceEqu.EnableControls;

  Except
    On E: Exception Do Begin
      pMensagensErro(E.Message, '[TConEqu.fGravaEquAce]');
      Result := False;
    End;
  End;

  FreeAndNil(qryGen);
end;

function TConEqu.fGravaEquDet: Boolean;
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin

  Try
    Result := True;

    cdsIteEqu.DisableControls;
    qryGen := fCriaQuery;

    If FOperac <> 'I' Then
    Begin
      strSQL := '';
      strSQL := strSQL + ' DELETE FROM EQUDET ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + ' EQU_CODEMP = :CODEMP AND ';
      strSQL := strSQL + ' EQU_NUMOSE = :NUMOSE ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('NUMOSE').AsString := FNumero;
        ExecSQL;
      End;

    End;

    strSQL := '';
    strSQL := strSQL + ' INSERT INTO EQUDET( ';
    strSQL := strSQL + '   AUTOINCREM, ';
    strSQL := strSQL + '   EQU_SEQGER, ';
    strSQL := strSQL + '   EQU_CODEMP, ';
    strSQL := strSQL + '   EQU_NUMOSE, ';
    strSQL := strSQL + '   EQU_CODCLI, ';
    strSQL := strSQL + '   EQU_CODVEN, ';
    strSQL := strSQL + '   EQU_CODITE, ';
    strSQL := strSQL + '   EQU_DESCRI, ';
    strSQL := strSQL + '   EQU_REFERE, ';
    strSQL := strSQL + '   EQU_UNIDAD, ';
    strSQL := strSQL + '   EQU_QTDITE, ';
    strSQL := strSQL + '   EQU_TOTCUS, ';
    strSQL := strSQL + '   EQU_UNITAR, ';
    strSQL := strSQL + '   EQU_UNIORI, ';
    strSQL := strSQL + '   EQU_UNIVIS, ';
    strSQL := strSQL + '   EQU_TAXJUR, ';
    strSQL := strSQL + '   EQU_PERDES, ';
    strSQL := strSQL + '   EQU_AGUARD, ';
    strSQL := strSQL + '   EQU_BRINDE, ';
    strSQL := strSQL + '   EQU_PROMOC, ';
    strSQL := strSQL + '   EQU_CODPAR, ';
    strSQL := strSQL + '   EQU_TIPBRI, ';
    strSQL := strSQL + '   EQU_TOTITE, ';
    strSQL := strSQL + '   EQU_DESESP, ';
    strSQL := strSQL + '   EQU_TABPRE, ';
    strSQL := strSQL + '   EQU_CLAFIS, ';
    strSQL := strSQL + '   EQU_CODFIS, ';
    strSQL := strSQL + '   EQU_VALIPI, ';
    strSQL := strSQL + '   EQU_ALQIPI, ';
    strSQL := strSQL + '   EQU_BASIPI, ';
    strSQL := strSQL + '   EQU_VALICM, ';
    strSQL := strSQL + '   EQU_ALQICM, ';
    strSQL := strSQL + '   EQU_BASICM, ';
    strSQL := strSQL + '   EQU_VALRET, ';
    strSQL := strSQL + '   EQU_ALQRET, ';
    strSQL := strSQL + '   EQU_BASRET, ';
    strSQL := strSQL + '   EQU_VALCBS, ';
    strSQL := strSQL + '   EQU_VALIBS, ';
    strSQL := strSQL + '   EQU_VAL_IS, ';
    strSQL := strSQL + '   EQU_PERBAS, ';
    strSQL := strSQL + '   EQU_PERRED, ';
    strSQL := strSQL + '   EQU_SEQIND, ';
    strSQL := strSQL + '   EQU_INCPIS, ';
    strSQL := strSQL + '   EQU_ENTRET, ';
    strSQL := strSQL + '   EQU_COBAPA, ';
    strSQL := strSQL + '   EQU_EMPITE, ';
    strSQL := strSQL + '   EQU_LOCRET) ';
    strSQL := strSQL + '   VALUES ( ';
    strSQL := strSQL + '   :AUTINC, ';
    strSQL := strSQL + '   :SEQGER, ';
    strSQL := strSQL + '   :CODEMP, ';
    strSQL := strSQL + '   :NUMOSE, ';
    strSQL := strSQL + '   :CODCLI, ';
    strSQL := strSQL + '   :CODVEN, ';
    strSQL := strSQL + '   :CODITE, ';
    strSQL := strSQL + '   :DESCRI, ';
    strSQL := strSQL + '   :REFERE, ';
    strSQL := strSQL + '   :UNIDAD, ';
    strSQL := strSQL + '   :QTDITE, ';
    strSQL := strSQL + '   :TOTCUS, ';
    strSQL := strSQL + '   :UNITAR, ';
    strSQL := strSQL + '   :UNIORI, ';
    strSQL := strSQL + '   :UNIVIS, ';
    strSQL := strSQL + '   :TAXJUR, ';
    strSQL := strSQL + '   :PERDES, ';
    strSQL := strSQL + '   :AGUARD, ';
    strSQL := strSQL + '   :BRINDE, ';
    strSQL := strSQL + '   :PROMOC, ';
    strSQL := strSQL + '   :CODPAR, ';
    strSQL := strSQL + '   :TIPBRI, ';
    strSQL := strSQL + '   :TOTITE, ';
    strSQL := strSQL + '   :DESESP, ';
    strSQL := strSQL + '   :TABPRE, ';
    strSQL := strSQL + '   :CLAFIS, ';
    strSQL := strSQL + '   :CODFIS, ';
    strSQL := strSQL + '   :VALIPI, ';
    strSQL := strSQL + '   :ALQIPI, ';
    strSQL := strSQL + '   :BASIPI, ';
    strSQL := strSQL + '   :VALICM, ';
    strSQL := strSQL + '   :ALQICM, ';
    strSQL := strSQL + '   :BASICM, ';
    strSQL := strSQL + '   :VALRET, ';
    strSQL := strSQL + '   :ALQRET, ';
    strSQL := strSQL + '   :BASRET, ';
    strSQL := strSQL + '   :VALCBS, ';
    strSQL := strSQL + '   :VALIBS, ';
    strSQL := strSQL + '   :VAL_IS, ';
    strSQL := strSQL + '   :PERBAS, ';
    strSQL := strSQL + '   :PERRED, ';
    strSQL := strSQL + '   :SEQIND, ';
    strSQL := strSQL + '   :INCPIS, ';
    strSQL := strSQL + '   :ENTRET, ';
    strSQL := strSQL + '   :COBAPA, ';
    strSQL := strSQL + '   :EMPITE, ';
    strSQL := strSQL + '   :LOCRET) ';

    pCarregarSeqIndFATDOR();

    cdsIteEqu.First;

    While Not cdsIteEqu.Eof Do
    Begin

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('AUTINC').AsString   := fRetAutoIncrem('EQUDET', FCodEmp);

        if Assigned(FAudit) then
          FAudit.Adicionar(ParamByName('AUTINC').AsString, 'EQUDET');

        ParamByName('SEQGER').AsString   := FAutInc;
        ParamByName('CODEMP').AsString   := FCodEmp;
        ParamByName('NUMOSE').AsString   := FNumero;
        ParamByName('CODCLI').AsString   := FCodCli;
        ParamByName('CODVEN').AsString   := FCodVen;
        ParamByName('CODITE').AsString   := cdsIteEqu.fieldbyname('CODITE').AsString;
        ParamByName('ENTRET').AsString   := cdsIteEqu.fieldbyname('ENTRET').AsString;
        ParamByName('LOCRET').AsString   := cdsIteEqu.fieldbyname('LOCRET').AsString;
        ParamByName('DESCRI').AsString   := cdsIteEqu.fieldbyname('DESITE').AsString;
        ParamByName('REFERE').AsString   := cdsIteEqu.fieldbyname('REFERE').AsString;
        
        If fEmptyStr(cdsIteEqu.fieldbyname('CODUNI').AsString) Then
          ParamByName('UNIDAD').Value    := Null
        Else
          ParamByName('UNIDAD').AsString   := cdsIteEqu.fieldbyname('CODUNI').AsString;

        ParamByName('QTDITE').AsFloat    := cdsIteEqu.fieldbyname('QTDITE').AsFloat;
        ParamByName('TOTCUS').AsFloat    := cdsIteEqu.fieldbyname('TOTCUS').AsFloat;
        ParamByName('UNITAR').AsFloat    := cdsIteEqu.fieldbyname('UNITAR').AsFloat;
        ParamByName('UNIORI').AsFloat    := cdsIteEqu.fieldbyname('UNIORI').AsFloat;
        ParamByName('UNIVIS').AsFloat    := cdsIteEqu.fieldbyname('UNIVIS').AsFloat;
        ParamByName('TAXJUR').AsFloat    := cdsIteEqu.fieldbyname('TAXJUR').AsFloat;
        ParamByName('PERDES').AsFloat    := cdsIteEqu.fieldbyname('PERDES').AsFloat;
        ParamByName('AGUARD').AsString   := cdsIteEqu.fieldbyname('AGUARD').AsString;
        ParamByName('TOTITE').AsFloat    := cdsIteEqu.fieldbyname('TOTITE').AsFloat;

        If fEmptyStr(cdsIteEqu.fieldbyname('CODPAR').AsString) Then
          ParamByName('CODPAR').Value    := Null
        Else
          ParamByName('CODPAR').AsString := cdsIteEqu.fieldbyname('CODPAR').AsString;

        ParamByName('BRINDE').AsString := cdsIteEqu.fieldbyname('BRINDE').AsString;
        ParamByName('PROMOC').AsString := IIF(fEmptyStr(cdsIteEqu.fieldbyname('PROMOC').AsString), 'N', cdsIteEqu.fieldbyname('PROMOC').AsString);

        ParamByName('TIPBRI').AsString := cdsIteEqu.fieldbyname('TIPBRI').AsString;

        If fEmptyStr(cdsIteEqu.fieldbyname('TABPRE').AsString) Then
          ParamByName('TABPRE').Value    := Null
        Else
          ParamByName('TABPRE').AsString := cdsIteEqu.fieldbyname('TABPRE').AsString;

        ParamByName('DESESP').AsFloat    := cdsIteEqu.fieldbyname('DESESP').AsFloat;

        ParamByName('CLAFIS').AsString := cdsIteEqu.fieldbyname('CLAFIS').AsString;
        ParamByName('CODFIS').AsString := cdsIteEqu.fieldbyname('CODFIS').AsString;
        ParamByName('INCPIS').AsString := cdsIteEqu.fieldbyname('INCPIS').AsString;
        ParamByName('VALIPI').AsFloat  := cdsIteEqu.fieldbyname('VALIPI').AsFloat;
        ParamByName('ALQIPI').AsFloat  := cdsIteEqu.fieldbyname('ALQIPI').AsFloat;
        ParamByName('BASIPI').AsFloat  := cdsIteEqu.fieldbyname('BASIPI').AsFloat;
        ParamByName('VALICM').AsFloat  := cdsIteEqu.fieldbyname('VALICM').AsFloat;
        ParamByName('ALQICM').AsFloat  := cdsIteEqu.fieldbyname('ALQICM').AsFloat;
        ParamByName('BASICM').AsFloat  := cdsIteEqu.fieldbyname('BASICM').AsFloat;
        ParamByName('VALRET').AsFloat  := cdsIteEqu.fieldbyname('VALRET').AsFloat;
        ParamByName('ALQRET').AsFloat  := cdsIteEqu.fieldbyname('ALQRET').AsFloat;
        ParamByName('BASRET').AsFloat  := cdsIteEqu.fieldbyname('BASRET').AsFloat;
        ParamByName('VALCBS').AsFloat  := cdsIteEqu.fieldbyname('VALCBS').AsFloat;
        ParamByName('VALIBS').AsFloat  := cdsIteEqu.fieldbyname('VALIBS').AsFloat;
        ParamByName('VAL_IS').AsFloat  := cdsIteEqu.fieldbyname('VAL_IS').AsFloat;
        ParamByName('PERBAS').AsFloat  := cdsIteEqu.fieldbyname('PERBAS').AsFloat;
        ParamByName('PERRED').AsFloat  := cdsIteEqu.fieldbyname('PERRED').AsFloat;
        ParamByName('SEQIND').AsInteger:= fRetSeqInd(cdsIteEqu.FieldByName('CODITE').AsString, cdsIteEqu.fieldbyname('QTDITE').AsFloat);
        ParamByName('COBAPA').AsString := cdsIteEqu.fieldbyname('COBAPA').AsString;
        ParamByName('EMPITE').AsString := cdsIteEqu.fieldbyname('EMPITE').AsString;

        cdsIteEqu.Edit;
        cdsIteEqu.FieldByName('AUTINC').AsString := ParamByName('AUTINC').AsString;
        cdsIteEqu.Post;

        ExecSQL;
      End;

      cdsIteEqu.Next;
    End;
    cdsIteEqu.EnableControls;

  Except

    On E: Exception Do Begin
      pMensagensErro(E.Message, '[TConEqu.fGravaEquDet]');
      Result := False;
    End;

  End;

  FreeAndNil(qryGen);
End;

function TConEqu.fGravaEquDfe: Boolean;
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin
  Result := True;

  Try

    cdsDfeEqu.DisableControls;
    qryGen := fCriaQuery;

    If FOperac <> 'I' Then
    Begin
      strSQL := '';
      strSQL := strSQL + ' DELETE FROM EQUDFE ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + ' EQU_CODEMP = :CODEMP AND ';
      strSQL := strSQL + ' EQU_NUMOSE = :NUMOSE ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('NUMOSE').AsString := FNumero;
        ExecSQL;
      End;

    End;

    strSQL := '';
    strSQL := strSQL + ' INSERT INTO EQUDFE( ';
    strSQL := strSQL + '   AUTOINCREM, ';
    strSQL := strSQL + '   EQU_SEQGER, ';
    strSQL := strSQL + '   EQU_CODEMP, ';
    strSQL := strSQL + '   EQU_NUMOSE, ';
    strSQL := strSQL + '   EQU_CODDFE, ';
    strSQL := strSQL + '   EQU_DESDFE) ';
    strSQL := strSQL + '   VALUES ( ';
    strSQL := strSQL + '   :AUTINC, ';
    strSQL := strSQL + '   :SEQGER, ';
    strSQL := strSQL + '   :CODEMP, ';
    strSQL := strSQL + '   :NUMOSE, ';
    strSQL := strSQL + '   :CODDFE, ';
    strSQL := strSQL + '   :DESDFE) ';
    cdsDfeEqu.First;

    While Not cdsDfeEqu.Eof Do
    Begin

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('AUTINC').AsString   := fRetAutoIncrem('EQUDFE', FCodEmp);
        ParamByName('SEQGER').AsString   := FAutInc;
        ParamByName('CODEMP').AsString   := FCodEmp;
        ParamByName('NUMOSE').AsString   := FNumero;
        ParamByName('CODDFE').AsString   := cdsDfeEqu.fieldbyname('CODDFE').AsString;
        ParamByName('DESDFE').AsString   := cdsDfeEqu.fieldbyname('DESDFE').AsString;
        ExecSQL;
      End;

      cdsDfeEqu.Next;
    End;
    cdsDfeEqu.EnableControls;

  Except
    On E: Exception Do Begin
      pMensagensErro(E.Message, '[TConEqu.fGravaEquDfe]');
      Result := False;
    End;
  End;

  FreeAndNil(qryGen);
end;

function TConEqu.fGravaEquSer: Boolean;
Var
  strSQL: String;
  qryGen: TUniQuery;
Begin
  Result := True;

  Try

    cdsSerEqu.DisableControls;
    qryGen := fCriaQuery;

    If FOperac <> 'I' Then
    Begin
      strSQL := '';
      strSQL := strSQL + ' DELETE FROM EQUSER ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + ' EQU_CODEMP = :CODEMP AND ';
      strSQL := strSQL + ' EQU_NUMOSE = :NUMOSE ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('NUMOSE').AsString := FNumero;
        ExecSQL;
      End;

    End;

    strSQL := '';
    strSQL := strSQL + ' INSERT INTO EQUSER( ';
    strSQL := strSQL + '   AUTOINCREM, ';
    strSQL := strSQL + '   EQU_SEQGER, ';
    strSQL := strSQL + '   EQU_CODEMP, ';
    strSQL := strSQL + '   EQU_NUMOSE, ';
    strSQL := strSQL + '   EQU_CODSER, ';
    strSQL := strSQL + '   EQU_DESSER, ';
    strSQL := strSQL + '   EQU_VALSER, ';
    strSQL := strSQL + '   EQU_VALUNI, ';
    strSQL := strSQL + '   EQU_PORDES, ';
    strSQL := strSQL + '   EQU_DESESP, ';
    strSQL := strSQL + '   EQU_BRINDE, ';
    strSQL := strSQL + '   EQU_CODPAR, ';
    strSQL := strSQL + '   EQU_TIPBRI, ';
    strSQL := strSQL + '   EQU_TECSER, ';
    strSQL := strSQL + '   EQU_COBAPA, ';
    strSQL := strSQL + '   EQU_QTDSER, ';
    strSQL := strSQL + '   EQU_MAOCLI) ';
    strSQL := strSQL + '   VALUES ( ';
    strSQL := strSQL + '   :AUTINC, ';
    strSQL := strSQL + '   :SEQGER, ';
    strSQL := strSQL + '   :CODEMP, ';
    strSQL := strSQL + '   :NUMOSE, ';
    strSQL := strSQL + '   :CODSER, ';
    strSQL := strSQL + '   :DESSER, ';
    strSQL := strSQL + '   :VALSER, ';
    strSQL := strSQL + '   :VALUNI, ';
    strSQL := strSQL + '   :PORDES, ';
    strSQL := strSQL + '   :DESESP, ';
    strSQL := strSQL + '   :BRINDE, ';
    strSQL := strSQL + '   :CODPAR, ';
    strSQL := strSQL + '   :TIPBRI, ';
    strSQL := strSQL + '   :TECSER, ';
    strSQL := strSQL + '   :COBAPA, ';
    strSQL := strSQL + '   :QTDSER, ';
    strSQL := strSQL + '   :MAOCLI) ';
    cdsSerEqu.First;

    While Not cdsSerEqu.Eof Do
    Begin

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);

        ParamByName('AUTINC').AsString   := fRetAutoIncrem('EQUSER', FCodEmp);
        ParamByName('SEQGER').AsString   := FAutInc;
        ParamByName('CODEMP').AsString   := FCodEmp;
        ParamByName('NUMOSE').AsString   := FNumero;
        ParamByName('CODSER').AsString   := cdsSerEqu.fieldbyname('CODSER').AsString;
        ParamByName('DESSER').AsString   := cdsSerEqu.fieldbyname('DESSER').AsString;
        ParamByName('VALSER').AsFloat    := cdsSerEqu.fieldbyname('VALSER').AsFloat;
        ParamByName('VALUNI').AsFloat    := cdsSerEqu.fieldbyname('VALUNI').AsFloat;
        ParamByName('PORDES').AsFloat    := cdsSerEqu.fieldbyname('PORDES').AsFloat;
        ParamByName('DESESP').AsFloat    := cdsSerEqu.fieldbyname('DESESP').AsFloat;

        If fEmptyStr(cdsSerEqu.fieldbyname('TECSER').AsString) Then
          ParamByName('TECSER').Value    := Null
        Else
          ParamByName('TECSER').AsString := cdsSerEqu.fieldbyname('TECSER').AsString;

        If fEmptyStr(cdsSerEqu.fieldbyname('CODPAR').AsString) Then
          ParamByName('CODPAR').Value    := Null
        Else
          ParamByName('CODPAR').AsString := cdsSerEqu.fieldbyname('CODPAR').AsString;

        ParamByName('BRINDE').AsString := cdsSerEqu.fieldbyname('BRINDE').AsString;
        ParamByName('TIPBRI').AsString := cdsSerEqu.fieldbyname('TIPBRI').AsString;
        ParamByName('COBAPA').AsString := cdsSerEqu.fieldbyname('COBAPA').AsString;
        ParamByName('QTDSER').AsFloat  := cdsSerEqu.fieldbyname('QTDSER').AsFloat;
        ParamByName('MAOCLI').AsString := cdsSerEqu.fieldbyname('MAOCLI').AsString;

        ExecSQL;
      End;

      cdsSerEqu.Next;
    End;
    cdsSerEqu.EnableControls;

  Except
    On E: Exception Do Begin
      pMensagensErro(E.Message, '[TConEqu.fGravaEquSer]');
      Result := False;
    End;
  End;

  FreeAndNil(qryGen);
End;

function TConEqu.fGravarNOSFab: Boolean;
var
  qryAux: TUniQuery;
begin
  Result := True;

  qryAux := fCriaQuery;

  try
    try
      fStartTransaction;

      qryAux.SQL.Text := 'UPDATE EQUGER SET EQU_NOSFAB = :NOSFAB WHERE EQU_NUMOSE = :NUMOSE AND EQU_CODEMP = :CODEMP ';
      qryAux.ParamByName('NOSFAB').AsString := FNOSFab;
      qryAux.ParamByName('NUMOSE').AsString := FNumero;
      qryAux.ParamByName('CODEMP').AsString := FCodEmp;
      qryAux.ExecSQL;

      fCommit;
    except on E: Exception do
      begin
        Result := False;
        fRollback;
      end;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

procedure TConEqu.pLimpaValoresItens;
Begin
  FCodIte := '';
  FDesite := '';
  FDesMar := '';
  FRefere := '';
  FCodFab := '';
  FUnidad := '';
  FCodUni := '';
  FLocFis := '';
  FBrinde := '';
  FPromoc := 'N';
  FCodPar := '';
  FTipBri := '';
  FTabPreIte := '';
  FCobAPaIte := '';
  FQtdIte := 0;
  FUniOri := 0;
  FUniVis := 0;
  FTaxJur := 0;
  FPerDes := 0;
  FUnitar := 0;
  FSaldos := 0;
  FSal_OS := 0;
  FTotIte := 0;
  FDesEspIte := 0;
  FEmpIte := '';
  FAtiCom := '';
  FIteEsp := False;

  if (FOperac = 'G') then
    FOperac := IIF(fEmptyStr(FNumero),'I','A');
End;

function TConEqu.fRetPreVen(strCodIte, strTabPrecos: String; Var strPromoc : String): Double;
Var
  qryPrecos         : TUniQuery;
  fltValPromocAtual : Double;
begin
  qryPrecos := fCriaQuery(Nil);

  Try
    {Promoção}
    strPromoc := 'N';
    fltValPromocAtual := fRetornaValorPromocional(strCodIte, FCodCli, strTabPrecos);

    If (fltValPromocAtual > 0) Then
    Begin
      strPromoc := 'S';
      Result    := fltValPromocAtual;
    End
    Else
    Begin
      qryPrecos.Close;
      qryPrecos.SQL.Add(' SELECT ITE_PREVE' + strTabPrecos + ' FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP ');
      qryPrecos.ParamByName('CODITE').AsString := strCodIte;
      qryPrecos.ParamByName('CODEMP').AsString := VS_strCodEmp;
      qryPrecos.Open;

      Result := qryPrecos.Fields[0].AsFloat;
    End;
  Finally
    FreeAndNil(qryPrecos);
  End;
end;

function TConEqu.fRetSeqInd(strCodIte: String; fltQtdIte: Double): Integer;
  Var
    i: Integer;
begin
  Result := 0;

  For i := 0 To Length(recSeqIndFATDOR) - 1 Do Begin
    If (Not recSeqIndFATDOR[i].blnGravou) And (recSeqIndFATDOR[i].strCodIte = strCodIte) And (recSeqIndFATDOR[i].fltQtdIte = fltQtdIte) Then Begin
      Result := recSeqIndFATDOR[i].intSeqInd;
      recSeqIndFATDOR[i].blnGravou := True;
      Break;
    End;
  End;
end;

function TConEqu.fServicoJaInclusoGrid(strCodSer, strCodTec: String): Boolean;
begin
  Result := False;

  If (fEmptyStr(strCodSer)) Or (fEmptyStr(strCodTec)) Then
    Exit;

  If Assigned(cdsSerEqu) Then Begin
    cdsSerEqu.First;
    While Not cdsSerEqu.Eof Do Begin

      If (cdsSerEqu.FieldByName('CODSER').AsString = strCodSer)
        And (cdsSerEqu.FieldByName('TECSER').AsString = strCodTec) Then Begin
        Result := True;
        Exit;
      End;

      cdsSerEqu.Next;
    End;
  End;
end;

function TConEqu.fStatusToSituacaoEquipamento(strStatus, strSubStatus: String): String;
begin

  {* - "N" -> "REPROVADA"   | - "C" -> "DEVOLVIDA AO CLIENTE"*}
  {*                        | - "A" -> "ARMAZENADA"          *}
  {*---------------------------------------------------------*}
  {* - "R", "REALIZADA"     | - "C" -> "DEVOLVIDA AO CLIENTE"*}
  {*                        | - "A" -> "ARMAZENADA"          *}
  {***********************************************************}

  {***********************************************************}
  {* SITUAÇÃO DO EQUIPAMENTO: EQUGER.EQU_SITEQU              *}
  {***********************************************************}
  {* SA - OS REALIZADA - ARMAZENADO                          *}
  {* SR - OS REALIZADA - RETIRADO PELO CLIENTE               *}
  {* NA - OS REPROVADA - ARMAZENADO                          *}
  {* NR - OS REPROVADA - RETIRADO PELO CLIENTE               *}
  {***********************************************************}

  Result := '';

  If (strStatus = 'N') Then
    Result := IIF(strSubStatus = 'C', 'NR', 'NA')
  Else
  If (strStatus = 'R') Then
    Result := IIF(strSubStatus = 'C', 'SR', 'SA');

end;

procedure TConEqu.pRecalculaPrecos(strTabPrecos: String; strCodIte: String = ''; blnTrocouCondPag: Boolean = False; blnManterPrecoDigitado: Boolean = False);
Var
  fltPreVen,
  fltPreVenNeg,
  fltUniOri    : Double;
  blnTabPreAlt : Boolean;
  strPromoc    : String;
begin

  blnTabPreAlt := (fEmptyStr(strCodIte)) And (FTabPre <> strTabPrecos);

  If (fEmptyStr(strCodIte)) Then
    FTabPre := strTabPrecos
  Else
    FTabPreIte := strTabPrecos;

  With cdsIteEqu Do
  Begin

    If IsEmpty Then
      Exit;

    If (fEmptyStr(strCodIte)) Then
    Begin
      FVlrPro := 0;
      FDesEsp := 0;
      First;
    End;

    While (Not IsEmpty) And (Not Eof) Do
    Begin

      If (FieldByName('BRINDE').AsString = 'S') And (fEmptyStr(strCodIte)) Then
      Begin
        Next;
        Continue;
      End;

      If (fCfgSis('TABITE', varBoolean)) And (fCfgSis('TBPOSE', varBoolean)) And (fEmptyStr(strCodIte)) Then
      Begin
        If blnTabPreAlt Then
          FTabPreIte := FTabPre
        Else
          FTabPreIte := FieldByName('TABPRE').AsString;
      End;

      If (Not fEmptyStr(strCodIte)) Then
        FVlrPro := FVlrPro - FieldByName('VLRCON').AsFloat;

      fltUniOri    := FieldByName('UNIORI').AsFloat;
      fltPreVenNeg := FieldByName('UNITAR').AsFloat;

      If (Not fEmptyStr(FTabPreIte)) And (FTabPre <> FTabPreIte) Then
        fltPreVen := fRetPreVen(FieldByname('CODITE').AsString, FTabPreIte, strPromoc)
      Else
        fltPreVen := fRetPreVen(FieldByname('CODITE').AsString, FTabPre, strPromoc);

      If (fltPreVenNeg <> fltPreVen) Then Begin
        fltUniOri := fltPreVen;

        If (Not blnTabPreAlt) And (Not blnTrocouCondPag) Then
          fltPreVen := fltPreVenNeg
        Else
          fltPreVenNeg := fltPreVen;
      End;

      If fltPreVen > 0 Then
      Begin
        Edit;
        FieldByName('PROMOC').AsString := strPromoc;
        FieldByName('TAXJUR').AsFloat  := fFormataFloat(fltTaxJur, 2);
        FieldByName('PERDES').AsFloat  := fFormataFloat(fltPerDes, 2);
        If (not blnManterPrecoDigitado) Then
        Begin
          FieldByName('UNIVIS').AsFloat := fFormataFloat(fltUniOri, fCfgSis('DECUNI',varInteger));
          FieldByName('UNIORI').AsFloat := fFormataFloat(fltUniOri + (fltPreVen * fltTaxJur /100), fCfgSis('DECUNI',varInteger));
          FieldByName('UNITAR').AsFloat := fFormataFloat(fltPreVenNeg + (fltPreVenNeg * fltTaxJur /100) - (fltPreVenNeg * fltPerDes /100), fCfgSis('DECUNI',varInteger));
          FieldByName('TOTITE').AsFloat := fFormataFloat(( fFormataFloat(fltPreVen + (fltPreVen * fltTaxJur /100),2) * FieldByname('QTDITE').AsFloat), 2);
        End;

        {Req: 103957 - Recalcula "FDesEsp" quando existe "FPorDes" pois pode ter ocorrido acréscimo de juros}
        If FPorDes > 0 Then
          FieldByName('DESESP').AsFloat := ((FieldByName('TOTITE').AsFloat * FPorDes) / 100);

        {Req: 103957 - Totaliza novamente}
        If (fEmptyStr(strCodIte)) Then
          FDesEsp := FDesEsp + FieldByName('DESESP').AsFloat;

        FieldByName('VLRCON').AsFloat := (FieldByName('TOTITE').AsFloat - FieldByName('DESESP').AsFloat);

        {Req: 101607  - Quando ocorre a troca da condição de pagamento não
         necessita validar alteração de tabela de preço, pois a intenção é somente recalcular os juros.}
        If Not blnTrocouCondPag Then
          FieldByName('TABPRE').AsString := IIF((Not fEmptyStr(FTabPreIte)) And (FTabPre <> FTabPreIte), FTabPreIte, FTabPre);

        FVlrPro := FVlrPro + FieldByName('VLRCON').AsFloat;
        Post;

        If (Not fEmptyStr(strCodIte)) Then
          Break;

        If (fEmptyStr(strCodIte)) Then
          Next;

      End
      Else
      Begin
        fMensagem('', 'O produto ('+FieldByname('CODITE').AsString+') está com o preço de venda Zerado!' + #13#10 + 'O mesmo será deletado da ordem de serviço.', ['&Ok']);
        Delete;
      End;

    End;

    FVlrCon := FVlrPro + FVlrSer + FTotIpi + FTotRet;
    If fSomarNovosImpostosDaReformaAoValorContabil Then
      FVlrCon := FVlrCon + FTotCbs + FTotIbs + FTotIs;

  End;

end;

procedure TConEqu.pCarregaItens;
var
  strSQL,
  strPre: String;
Begin
  strPre := '';

  if FOSCanc then
    strPre := 'DEL_';

  strSQL := '';
  strSQL := strSQL + ' SELECT ' + strPre + 'EQUDET.*, ';
  strSQL := strSQL + ' COALESCE(G.ITE_LOCFIS, "") AS LOCFIS, ';
  strSQL := strSQL + ' COALESCE(M.MAR_DESMAR, "") AS DESMAR, ';
  strSQL := strSQL + ' COALESCE(G.ITE_LOCSUP, "") AS LOCSUP, ';
  strSQL := strSQL + ' ED.FDO_QTDEXP   AS QTDEXP, ';
  strSQL := strSQL + '  CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
  strSQL := strSQL + '                   FROM NUMCMP ';
  strSQL := strSQL + '                  WHERE CMP_SEQGER = F.AUTOINCREM ';
  strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
  strSQL := strSQL + '         IFNULL(ED.FDO_NUMCMP, "")) AS NUMCMP, ';
  strSQL := strSQL + ' ED.FDO_NITCMP AS NITCMP, ED.FDO_DTACMP AS DTACMP, D.FDO_NUMLOT, IFNULL(ED.FDO_RESERV, "S") AS RESERV, ';
  strSQL := strSQL + ' U.UNI_SIGUNI, I.ITE_ATICOM, I.ITE_DESITE ';
  strSQL := strSQL + ' FROM ' + strPre + 'EQUDET ';
  strSQL := strSQL + ' JOIN CADITE I ON (I.ITE_CODITE = ' + strPre + 'EQUDET.EQU_CODITE) ';
  strSQL := strSQL + ' JOIN ITEGER G ON (G.ITE_CODITE = ' + strPre + 'EQUDET.EQU_CODITE AND ';
  strSQL := strSQL + '                   G.ITE_CODEMP = ' + strPre + 'EQUDET.EQU_CODEMP) ';
  strSQL := strSQL + ' LEFT JOIN CADUNI U ON (U.UNI_CODUNI = ' + strPre + 'EQUDET.EQU_UNIDAD) ';
  strSQL := strSQL + ' LEFT JOIN CADMAR M ON (M.MAR_CODMAR = I.ITE_CODMAR) ';
  strSQL := strSQL + ' LEFT JOIN ' + strPre + 'EQUGER EG ON EG.AUTOINCREM = ' + strPre + 'EQUDET.EQU_SEQGER ';
  strSQL := strSQL + ' LEFT JOIN ' + strPre + 'FATGOR F ON (F.FGO_NUMDOC = EG.EQU_NUMPED) AND (F.FGO_ESPDOC = EG.EQU_TIPPED) AND (F.FGO_CODEMP = EG.EQU_EMPPED) ';
  strSQL := strSQL + ' LEFT JOIN ' + strPre + 'FATDOR D  ON (F.AUTOINCREM = D.FDO_SEQGER) ';
  strSQL := strSQL + '                    AND (D.FDO_CODITE = ' + strPre + 'EQUDET.EQU_CODITE) ';
  strSQL := strSQL + '                    AND (D.FDO_SEQIND = ' + strPre + 'EQUDET.EQU_SEQIND) ';
  strSQL := strSQL + ' LEFT JOIN ' + strPre + 'EXTDOR ED ON (D.AUTOINCREM = ED.FDO_SEQFDO) ';
  strSQL := strSQL + ' WHERE ' + strPre + 'EQUDET.EQU_NUMOSE = :NUMOSE ';
  strSQL := strSQL + '   AND ' + strPre + 'EQUDET.EQU_CODEMP = :CODEMP ';
  strSQL := strSQL + '   AND NOT EXISTS (SELECT EQUGOR.FGO_SEQEQU FROM EQUGOR WHERE EQUGOR.FGO_SEQEQU = EG.AUTOINCREM) ';
  strSQL := strSQL + ' GROUP BY ' + strPre + 'EQUDET.AUTOINCREM ';

  strSQL := strSQL + ' UNION ';

  strSQL := strSQL + ' SELECT ' + strPre + 'EQUDET.*, ';
  strSQL := strSQL + ' COALESCE(G.ITE_LOCFIS, "") AS LOCFIS, ';
  strSQL := strSQL + ' COALESCE(M.MAR_DESMAR, "") AS DESMAR, ';
  strSQL := strSQL + ' COALESCE(G.ITE_LOCSUP, "") AS LOCSUP, ';
  strSQL := strSQL + ' ED.FDO_QTDEXP   AS QTDEXP, ';
  strSQL := strSQL + '  CONCAT(IFNULL((SELECT IF(IFNULL(CMP_NUMCMP,"") <> "", CONCAT(GROUP_CONCAT(CMP_NUMCMP SEPARATOR ";"), ";"), "") ';
  strSQL := strSQL + '                   FROM NUMCMP ';
  strSQL := strSQL + '                  WHERE CMP_SEQGER = F.AUTOINCREM ';
  strSQL := strSQL + '                    AND IFNULL(CMP_NUMCMP, "") <> ""), ""), ';
  strSQL := strSQL + '         IFNULL(ED.FDO_NUMCMP, "")) AS NUMCMP, ';
  strSQL := strSQL + ' ED.FDO_NITCMP AS NITCMP, ED.FDO_DTACMP AS DTACMP, D.FDO_NUMLOT, IFNULL(ED.FDO_RESERV, "S") AS RESERV, ';
  strSQL := strSQL + ' U.UNI_SIGUNI, I.ITE_ATICOM, I.ITE_DESITE ';
  strSQL := strSQL + ' FROM ' + strPre + 'EQUDET ';
  strSQL := strSQL + ' JOIN CADITE I ON (I.ITE_CODITE = ' + strPre + 'EQUDET.EQU_CODITE) ';
  strSQL := strSQL + ' JOIN ITEGER G ON (G.ITE_CODITE = ' + strPre + 'EQUDET.EQU_CODITE AND ';
  strSQL := strSQL + '                   G.ITE_CODEMP = ' + strPre + 'EQUDET.EQU_CODEMP) ';
  strSQL := strSQL + ' LEFT JOIN CADUNI U ON (U.UNI_CODUNI = ' + strPre + 'EQUDET.EQU_UNIDAD) ';
  strSQL := strSQL + ' LEFT JOIN CADMAR M ON (M.MAR_CODMAR = I.ITE_CODMAR) ';
  strSQL := strSQL + ' INNER JOIN ' + strPre + 'EQUGER EG ON EG.AUTOINCREM = ' + strPre + 'EQUDET.EQU_SEQGER ';
  strSQL := strSQL + ' INNER JOIN ' + strPre + 'EQUGOR EGO ON EGO.FGO_SEQEQU = EG.AUTOINCREM ';
  strSQL := strSQL + '    AND IF(' + strPre + 'EQUDET.EQU_COBAPA = "S", EGO.FGO_GARANT = "C", EGO.FGO_GARANT <> "C") ';
  strSQL := strSQL + ' INNER JOIN ' + strPre + 'FATGOR F ON (EGO.FGO_SEQFGO = F.AUTOINCREM) ';
  strSQL := strSQL + ' INNER JOIN ' + strPre + 'FATDOR D  ON (F.AUTOINCREM = D.FDO_SEQGER) ';
  strSQL := strSQL + '                    AND (D.FDO_CODITE = '+ strPre +'EQUDET.EQU_CODITE) ';
  strSQL := strSQL + '                    AND (                                              ';
  strSQL := strSQL + '                          ('+ strPre +'EQUDET.EQU_SEQIND > 0 AND D.FDO_SEQIND = '+ strPre +'EQUDET.EQU_SEQIND) ';
  strSQL := strSQL + '                          OR                                                                                   ';
  strSQL := strSQL + '                          ('+ strPre +'EQUDET.EQU_SEQIND = 0 AND D.FDO_SEQIND = (                              ';
  strSQL := strSQL + '                              SELECT MIN(D2.FDO_SEQIND)                                                        ';
  strSQL := strSQL + '                              FROM '+ strPre + 'FATDOR D2                                                                   ';
  strSQL := strSQL + '                              WHERE D2.FDO_SEQGER = D.FDO_SEQGER                                               ';
  strSQL := strSQL + '                                AND D2.FDO_CODITE = D.FDO_CODITE                                               ';
  strSQL := strSQL + '                          ))                                                                                   ';
  strSQL := strSQL + '                         )                                                                                     ';
  strSQL := strSQL + ' INNER JOIN ' + strPre + 'EXTDOR ED ON (D.AUTOINCREM = ED.FDO_SEQFDO) ';
  strSQL := strSQL + ' WHERE ' + strPre + 'EQUDET.EQU_NUMOSE = :NUMOSE ';
  strSQL := strSQL + '   AND ' + strPre + 'EQUDET.EQU_CODEMP = :CODEMP ';
  strSQL := strSQL + ' GROUP BY ' + strPre + 'EQUDET.AUTOINCREM ';

  qryEquDet.Close;
  qryEquDet.SQL.Clear;
  qryEquDet.SQL.Add(strSQL);
  qryEquDet.ParamByName('NUMOSE').AsString := FNumero;
  qryEquDet.ParamByName('CODEMP').AsString := FCodEmp;
  qryEquDet.Open;
End;

procedure TConEqu.pCarregaNumDocEQUGOR;
var
  qryFGOEQU: TUniQuery;
begin
  FNumDocSer := '';
  FNumDocCli := '';
  SetLength(FArrPedidos, 0);

  qryFGOEQU := fCriaQuery;

  try
    qryFGOEQU.Close;
    qryFGOEQU.SQL.Text := SELECT_PD_EQUGOR;
    qryFGOEQU.ParamByName('SEQEQU').AsString := FAutInc;
    qryFGOEQU.Open;

    if (not qryFGOEQU.IsEmpty) then
    begin
      SetLength(FArrPedidos, qryFGOEQU.RecordCount);

      while not qryFGOEQU.Eof do
      begin
        if (qryFGOEQU.FieldByName('ITEPED').AsString = 'S') and (qryFGOEQU.FieldByName('NUMDOC').AsString <> FNumPed) then
          FNumDocSer := qryFGOEQU.FieldByName('NUMDOC').AsString
        else if (qryFGOEQU.FieldByName('GARANT').AsString = 'C') then
          FNumDocCli := qryFGOEQU.FieldByName('NUMDOC').AsString;

        FArrPedidos[qryFGOEQU.RecNo - 1].strNumPed := qryFGOEQU.FieldByName('NUMDOC').AsString;
        FArrPedidos[qryFGOEQU.RecNo - 1].strCodEmp := qryFGOEQU.FieldByName('CODEMP').AsString;
        FArrPedidos[qryFGOEQU.RecNo - 1].strGarant := qryFGOEQU.FieldByName('GARANT').AsString;
        FArrPedidos[qryFGOEQU.RecNo - 1].strItePed := qryFGOEQU.FieldByName('ITEPED').AsString;
        FArrPedidos[qryFGOEQU.RecNo - 1].strEmpIte := qryFGOEQU.FieldByName('EMPITE').AsString;

        qryFGOEQU.Next;
      end;
    end
    else if (not fEmptyStr(FNumPed)) then
    begin
      SetLength(FArrPedidos, 1);

      FArrPedidos[0].strNumPed := FNumPed;
      FArrPedidos[0].strCodEmp := FEmpPed;
      FArrPedidos[0].strGarant := FGarant;
      FArrPedidos[0].strItePed := 'T';
      FArrPedidos[0].strEmpIte := FEmpPed;
    end;
  finally
    FreeAndNil(qryFGOEQU);
  end;
end;

procedure TConEqu.pCarregarSeqIndFATDOR;
  Var
    qryTemp: TUniQuery;
begin
  Try
    qryTemp := fCriaQuery(Self);

    Try
      qryTemp.Close();
      qryTemp.SQL.Clear();
      qryTemp.SQL.Text := 'SELECT FDO_CODITE, FDO_SEQIND, FDO_QTDITE FROM FATDOR WHERE FDO_NUMDOC = :NUMDOC AND FDO_ESPDOC = :ESPDOC AND FDO_CODCLI = :CODCLI AND FDO_CODEMP = :CODEMP';
      qryTemp.ParamByName('NUMDOC').AsString := FNumPed;
      qryTemp.ParamByName('ESPDOC').AsString := 'PD';
      qryTemp.ParamByName('CODCLI').AsString := FCodCli;
      qryTemp.ParamByName('CODEMP').AsString := FEmpPed;
      qryTemp.Open();
      qryTemp.First();

      SetLength(recSeqIndFATDOR, 0);

      While (Not qryTemp.Eof) Do Begin
        If (qryTemp.FieldByName('FDO_CODITE').AsString <> fCfgSis('ITESER', varString)) And
           (qryTemp.FieldByName('FDO_CODITE').AsString <> fCfgSis('SERTER', varString)) Then Begin

          SetLength(recSeqIndFATDOR, Length(recSeqIndFATDOR) + 1);

          recSeqIndFATDOR[Length(recSeqIndFATDOR) - 1].intSeqInd := qryTemp.FieldByName('FDO_SEQIND').AsInteger;
          recSeqIndFATDOR[Length(recSeqIndFATDOR) - 1].strCodIte := qryTemp.FieldByName('FDO_CODITE').AsString;
          recSeqIndFATDOR[Length(recSeqIndFATDOR) - 1].fltQtdIte := qryTemp.FieldByName('FDO_QTDITE').AsFloat;
          recSeqIndFATDOR[Length(recSeqIndFATDOR) - 1].blnGravou := False;
        End;

        qryTemp.Next();
      End;

      qryTemp.Close();
    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[TConEqu.pCarregarSeqIndFATDOR]');
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TConEqu.pCarregaServicos;
var
  strSQL,
  strPre: String;
Begin
  strPre := '';

  if FOSCanc then
    strPre := 'DEL_';

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   * ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   ' + strPre + 'EQUSER ';
  strSQL := strSQL + ' WHERE EQU_NUMOSE = :NUMOSE ';
  strSQL := strSQL + '   AND EQU_CODEMP = :CODEMP ';

  With qryEquSer Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMOSE').AsString := FNumero;
    ParamByName('CODEMP').AsString := FCodEmp;
    Open;
  End;
End;

procedure TConEqu.fAtualizaSaldos;
const
  arrFlxSit: array [0..5] of string = ('EM', 'MF', 'AR', 'FA', 'AF', 'NF');
var fltSaldo,
    fltSaldoOS,
    fltSaldoIte,
    fltSalResTot,
    fltQtdReqAbe: Double;
    strCodIteAnt,
    strCodRcd,
    strEmpRcd: String;
    blnTrava,
    blnReqAbe: Boolean;
    strIndexFieldAnt: String;
begin
  fltSaldo := 0;
  fltSaldoOS := 0;
  fltQtdReqAbe := 0;

  Try
    cdsIteEqu.DisableControls;
    strIndexFieldAnt := cdsIteEqu.IndexFieldNames;
    cdsIteEqu.IndexFieldNames := 'CODITE;QTDITE';
    cdsIteEqu.first;
    strCodIteAnt := '';

    while not cdsIteEqu.eof do
    begin
      if strCodIteAnt <> cdsIteEqu.FieldByName('CODITE').AsString then
      begin
        fltSaldo  := fRetornaSaldoDisponivel(cdsIteEqu.FieldByName('CODITE').AsString,
          IIF(FMulLoj, cdsIteEqu.FieldByName('EMPITE').AsString, VS_strCodEmp), fltSaldoIte, fltSalResTot);
        fltQtdReqAbe := fQtdeItemReqAberta(cdsIteEqu.FieldByName('CODITE').AsString, IIF(FMulLoj, cdsIteEqu.FieldByName('EMPITE').AsString, FEmpPed));
        fltSaldoOS := fltSaldo + fltQtdReqAbe;
      end;

      cdsIteEqu.edit;

      if (not fEmptyStr(strNumPed)) then
      begin
        blnReqAbe := (VerificaPedidoComRequisicaoEmAbertoComPedidoDeCompra(strNumPed, 'PD', strEmpPed, strCodRcd, strEmpRcd,
          blnTrava, False, cdsIteEqu.FieldByName('CODITE').AsString) or
          VerificaPedidoComRequisicaoEmAbertoSemPedidoDeCompra(strNumPed, 'PD', strEmpPed, strCodRcd, strEmpRcd, cdsIteEqu.FieldByName('CODITE').AsString));

        if (cdsIteEqu.FieldByName('RESERV').AsString = 'S') then
        begin
          fltSaldo  := fltSaldo + cdsIteEqu.FieldByName('QTDITE').AsFloat;
          if (not blnReqAbe) then
            fltSaldoOS := fltSaldoOS + cdsIteEqu.FieldByName('QTDITE').AsFloat
          else
            fltSaldoOS := fltSaldoOS + cdsIteEqu.FieldByName('QTDITE').AsFloat - fltQtdReqAbe;
        end;
      end;

      If (fltSaldo <= 0) Then
        cdsIteEqu.FieldByName('AGUARD').AsString := 'S'
      Else
      Begin
        If (cdsIteEqu.FieldByName('QTDITE').AsFloat > fltSaldo) Then
          cdsIteEqu.FieldByName('AGUARD').AsString := 'S'
        Else
          cdsIteEqu.FieldByName('AGUARD').AsString := 'N';
      End;

      If (fltSaldoOS <= 0) Then
        cdsIteEqu.FieldByName('SALDIS').AsString := 'S'
      Else
      Begin
        If (cdsIteEqu.FieldByName('QTDITE').AsFloat > fltSaldoOS) Then
          cdsIteEqu.FieldByName('SALDIS').AsString := 'S'
        Else
          cdsIteEqu.FieldByName('SALDIS').AsString := 'N';
      End;

      if (not fEmptyStr(strNumPed)) and (cdsIteEqu.FieldByName('RESERV').AsString = 'S') then
        fltSaldo := fltSaldo - cdsIteEqu.FieldByName('QTDITE').AsFloat;

      cdsIteEqu.FieldByName('SALDOS').AsFloat := fltSaldo;
      cdsIteEqu.FieldByName('SAL_OS').AsFloat := fltSaldoOS;
      cdsIteEqu.post;

      strCodIteAnt := cdsIteEqu.FieldByName('CODITE').AsString;

      cdsIteEqu.next;
    end;
  Finally
    cdsIteEqu.IndexFieldNames := strIndexFieldAnt;
    cdsIteEqu.EnableControls;
  end;
end;

procedure TConEqu.pCarregaTela;
Begin
  FSeqIte := 1;

  With qryEquGer Do
  Begin
    FAutInc := FieldByName('AUTOINCREM').AsString;
    FNumero := FieldByName('EQU_NUMOSE').AsString;
    FCodEmp := FieldByName('EQU_CODEMP').AsString;
    FCodCli := FieldByName('EQU_CODCLI').AsString;
    FTabPre := FieldByName('EQU_TABPRE').AsString;
    FCliNom := FieldByName('EQU_NOMCON').AsString;
    FCliEnd := FieldByName('EQU_ENDCON').AsString;
    FCliBai := FieldByName('EQU_BAICON').AsString;
    FCliCep := FieldByName('EQU_CEPCON').AsString;
    FCodCid := FieldByName('EQU_CIDCON').AsString;
    FCliCid := fRetNomCidade(FCodCid);
    FCliEst := fRetNomCidade(FCodCid,1);
    FCliTel := FieldByName('EQU_TELCON').AsString;
    FCgcCpf := FieldByName('EQU_CGCCPF').AsInteger;
    FCliCgc := FieldByName('EQU_CGCCON').AsString;
    FCliIes := FieldByName('EQU_IESCON').AsString;
    FCli_Rg := FieldByName('EQU_R_GCON').AsString;
    FCodTec := FieldByName('EQU_CODTEC').AsString;
    FCodVen := FieldByName('EQU_CODVEN').AsString;
    FCodEqu := FieldByName('EQU_CODEQU').AsString;
    FDescri := FieldByName('EQU_DESCRI').AsString;
    FDisSer := FieldByName('EQU_DISSER').AsString;
    FNSerie := FieldByName('EQU_NSERIE').AsString;
    FAcesso := FieldByName('EQU_ACESSO').AsString;
    FGarant := FieldByName('EQU_GARANT').AsString;
    FNFComp := FieldByName('EQU_NFCOMP').AsString;
    FDtNFCo := FieldByName('EQU_DTNFCO').AsDateTime;
    FRevend := FieldByName('EQU_REVEND').AsString;
    FConRet := FieldByName('EQU_CONRET').AsString;
    FDeiPor := FieldByName('EQU_DEIPOR').AsString;
    FRetPor := FieldByName('EQU_RETPOR').AsString;
    FReaPor := FieldByName('EQU_REAPOR').AsString;
    FOsPdCl := FieldByName('EQU_OSPDCL').AsString;
    FEntreg := FieldByName('EQU_ENTREG').AsDateTime;
    FMarEqu := FieldByName('EQU_CODMAR').AsString;
    FStatus := FieldByName('EQU_STATUS').AsString;
    FSubSta := FieldByName('EQU_SUBSTA').AsString;
    FAg_Mon := FieldByName('EQU_AG_MON').AsString = 'S';
    FVlrCon := FieldByName('EQU_VLRCON').AsFloat;
    FDtaEnt := FieldByName('EQU_DTAENT').AsDateTime;
    FPrevis := FieldByName('EQU_PREVIS').AsDateTime;
    FHorEnt := FieldByName('EQU_HORENT').AsDateTime;
    FObserv := FieldByName('EQU_OBSERV').AsString;
    FEntGer := FieldByName('EQU_ENTGER').AsString;
    FCliGar := FieldByName('EQU_CLIGAR').AsString;
    FCodCnd := IfThen(fEmptyStr(FieldByName('EQU_CODCND').AsString), FieldByName('FGO_CODCND').AsString, FieldByName('EQU_CODCND').AsString);
    FCodFpg := IfThen(fEmptyStr(FieldByName('EQU_CODFPG').AsString), FieldByName('FGO_CODFPG').AsString, FieldByName('EQU_CODFPG').AsString);
    FConPag := IfThen(fEmptyStr(FieldByName('EQU_CONPAG').AsString), FieldByName('FGO_CONPAG').AsString, FieldByName('EQU_CONPAG').AsString);
    FCodVe2 := FieldByName('EQU_CODVE2').AsString;
    FCodDig := FieldByName('EQU_CODDIG').AsString;
    FDesEsp := FieldByName('EQU_DESESP').AsFloat;
    FPorDes := FieldByName('EQU_PORDES').AsFloat;
    FValDes := FieldByName('EQU_VALDES').AsFloat;
    FDtIniOrc := FieldByName('EQU_DTINOR').AsDateTime;
    FHrIniOrc := FieldByName('EQU_HRINOR').AsDateTime;
    FOpIniOrc := FieldByName('EQU_OPINOR').AsString;
    FDtFinOrc := FieldByName('EQU_DTFIOR').AsDateTime;
    FHrFinOrc := FieldByName('EQU_HRFIOR').AsDateTime;
    FOpFinOrc := FieldByName('EQU_OPFIOR').AsString;
    FDtIniMan := FieldByName('EQU_DTINMA').AsDateTime;
    FHrIniMan := FieldByName('EQU_HRINMA').AsDateTime;
    FOpIniMan := FieldByName('EQU_OPINMA').AsString;
    FDtFinMan := FieldByName('EQU_DTFIMA').AsDateTime;
    FHrFinMan := FieldByName('EQU_HRFIMA').AsDateTime;
    FOpFinMan := FieldByName('EQU_OPFIMA').AsString;
    FCodTra   := FieldByName('EQU_CODTRA').AsString;
    FValFre   := FieldByName('EQU_TOTFRE').AsFloat;
    FEspTra   := FieldByName('EQU_ESPECI').AsString;
    FLocFisEqu:= FieldByName('EQU_LOCFIS').AsString;
    FTipFre   := FieldByName('EQU_TIPFRE').AsString;
    FQtdTra   := FieldByName('EQU_VOLUME').AsInteger;
    FSepImp   := fSelecionaStatusSepImp(FieldByName('EQU_NUMPED').AsString, 'PD', FieldByName('EQU_EMPPED').AsString);
    FDtLbEx   := FieldByName('FGO_DTLBEX').AsDateTime;
    FHrLbEx   := FieldByName('FGO_HRLBEX').AsDateTime;
    FDtBxSe   := FieldByName('FGO_DTBXSE').AsDateTime;
    FHrBxSe   := FieldByName('FGO_HRBXSE').AsDateTime;
    FOpBxSe   := FieldByName('FGO_OPBXSE').AsString;
    FVenPre   := FieldByName('EQU_VENPRE').AsString = 'S';
    FCliEma   := FieldByName('EQU_EMLCON').AsString;
    FProtoc   := FieldByName('EQU_PROTOC').AsString;
    FSituacao := FieldByName('EQU_SITPRO').AsString;
    FDtRetOrc := FieldByName('EQU_DTRORC').AsDateTime;
    FHrRetOrc := FieldByName('EQU_HRPORC').AsDateTime;
    FDtRetMan := FieldByName('EQU_DTRMAN').AsDateTime;
    FHrRetMan := FieldByName('EQU_HRPMAN').AsDateTime;
    FDtPauMan := FieldByName('EQU_DTPAMA').AsDateTime;
    FHrPauMan := FieldByName('EQU_HRPAMA').AsDateTime;
    FDtReManu := FieldByName('EQU_DTREMA').AsDateTime;
    FHrReManu := FieldByName('EQU_HRREMA').AsDateTime;
    FCntCli   := FieldByName('EQU_CNTCLI').AsString;
    FCntTel   := FieldByName('EQU_CNTTEL').AsString;
    FNumPat   := FieldByName('EQU_NUMPAT').AsString;
    FDadFab   := FieldByName('EQU_DADFAB').AsString;
    FCodEpr   := FieldByName('EQU_CODEPR').AsString;
    FReaTel   := FieldByName('EQU_REATEL').AsString;
    FSitDtr   := FieldByName('EQU_SITDTR').AsDateTime;
    FTmpGar   := FieldByName('EQU_TMPGAR').AsInteger;
    FFlxFas   := FieldByName('EQU_FLXFAS').AsString;
    FFlxSit   := FieldByName('EQU_FLXSIT').AsString;
    FFlxCom   := FieldByName('EQU_FLXCOM').AsString;
    FRea_RG   := FieldByName('EQU_REA_RG').AsString;
    FPrtAtd   := FieldByName('EQU_PRTATD').AsString = 'S';
    FNOSFab   := FieldByName('EQU_NOSFAB').AsString;
    FNOSAnt   := FieldByName('EQU_NOSANT').AsString;
    FDtEAnt   := FieldByName('EQU_DTEANT').AsDateTime;
    FDtRAnt   := FieldByName('EQU_DTRANT').AsDateTime;
    FFlxFasAnt:= FieldByName('EQU_FLXFAS').AsString;
    FFlxSitAnt:= FieldByName('EQU_FLXSIT').AsString;
    FFlxComAnt:= FieldByName('EQU_FLXCOM').AsString;
    FNFReme   := FieldByName('EQU_NFREME').AsString;
    FDtNFRe   := FieldByName('EQU_DTNFRE').AsDateTime;
    FEmpSer   := FieldByName('EQU_EMPSER').AsString;
    FEmpApr   := FieldByName('EQU_EMPAPR').AsString;
    FDiaEnt   := FieldByName('EQU_DIAENT').AsInteger;
    FDigRet   := FieldByName('EQU_DIGRET').AsString;
    FObsGer   := FieldByName('EQU_OBSGER').AsString;
    FObsNFS   := FieldByName('EQU_OBSNFS').AsString;
    FCodCliAnt:= FieldByName('EQU_CODCLI').AsString;
    FDtaArm   := FieldByName('EQU_DTAARM').AsDateTime;
    FDtTxAr   := FieldByName('EQU_DTTXAR').AsDateTime;
    FblnAutDes:= (FieldByName('EQU_AUTDES').AsString = 'S');
    FTipApr   := FieldByName('EQU_TIPAPR').AsString;
    FEmpFatSemSaldo := FieldByName('FGO_FATSSA').AsString;
    FOri_PD   := FieldByName('EQU_ORI_PD').AsString;
    FCodFaz   := FieldByName('EQU_CODFAZ').AsString;
  End;

  FCdsIteEquLog.EmptyDataSet();

  With qryEquDet Do
  Begin
    FVlrPro := 0;

    First;
    cdsIteEqu.DisableControls;
    While Not Eof Do
    Begin
      cdsIteEqu.Append;
      cdsIteEqu.FieldByName('AUTINC').AsString  := FieldByName('AUTOINCREM').AsString;
      cdsIteEqu.FieldByName('INCORI').AsString  := FieldByName('AUTOINCREM').AsString;
      cdsIteEqu.FieldByName('CODITE').AsString  := FieldByName('EQU_CODITE').AsString;
      cdsIteEqu.FieldByName('ENTRET').AsString  := FieldByName('EQU_ENTRET').AsString;
      cdsIteEqu.FieldByName('LOCRET').AsString  := FieldByName('EQU_LOCRET').AsString;
      cdsIteEqu.FieldByName('DESITE').AsString  := FieldByName('EQU_DESCRI').AsString;
      cdsIteEqu.FieldByName('DESMAR').AsString  := FieldByName('DESMAR').AsString;
      cdsIteEqu.FieldByName('REFERE').AsString  := FieldByName('EQU_REFERE').AsString;

      if not fEmptyStr(cdsIteEqu.FieldByName('REFERE').AsString) then
        cdsIteEqu.FieldByName('COPREF').AsString := 'S'
      else
        cdsIteEqu.FieldByName('COPREF').AsString := '';

      cdsIteEqu.FieldByName('CODFAB').AsString  := fRetCodFabrica(FieldByName('EQU_CODITE').AsString);

      if not fEmptyStr(cdsIteEqu.FieldByName('CODFAB').AsString) then
        cdsIteEqu.FieldByName('COPCFB').AsString := 'S'
      else
        cdsIteEqu.FieldByName('COPCFB').AsString := '';

      cdsIteEqu.FieldByName('UNIDAD').AsString  := FieldByName('UNI_SIGUNI').AsString;
      cdsIteEqu.FieldByName('CODUNI').AsString  := FieldByName('EQU_UNIDAD').AsString;
      cdsIteEqu.FieldByName('QTDITE').AsFloat   := FieldByName('EQU_QTDITE').AsFloat;
      cdsIteEqu.FieldByName('TOTCUS').AsFloat   := FieldByName('EQU_TOTCUS').AsFloat;
      cdsIteEqu.FieldByName('UNITAR').AsFloat   := FieldByName('EQU_UNITAR').AsFloat;
      cdsIteEqu.FieldByName('UNIORI').AsFloat   := FieldByName('EQU_UNIORI').AsFloat;
      cdsIteEqu.FieldByName('UNIVIS').AsFloat   := FieldByName('EQU_UNIVIS').AsFloat;
      cdsIteEqu.FieldByName('TAXJUR').AsFloat   := FieldByName('EQU_TAXJUR').AsFloat;
      cdsIteEqu.FieldByName('PERDES').AsFloat   := FieldByName('EQU_PERDES').AsFloat;
      cdsIteEqu.FieldByName('TOTITE').AsFloat   := FieldByName('EQU_TOTITE').AsFloat;
      cdsIteEqu.FieldByName('LOCFIS').AsString  := FieldByName('LOCFIS').AsString;
      cdsIteEqu.FieldByName('BRINDE').AsString  := FieldByName('EQU_BRINDE').AsString;
      cdsIteEqu.FieldByName('PROMOC').AsString  := FieldByName('EQU_PROMOC').AsString;
      cdsIteEqu.FieldByName('CODPAR').AsString  := FieldByName('EQU_CODPAR').AsString;
      cdsIteEqu.FieldByName('TIPBRI').AsString  := FieldByName('EQU_TIPBRI').AsString;
      cdsIteEqu.FieldByName('TABPRE').AsString  := IIF(fEmptyStr(FieldByName('EQU_TABPRE').AsString), FTabPre, FieldByName('EQU_TABPRE').AsString);
      cdsIteEqu.FieldByName('NUMCMP').AsString  := LeftStr(FieldByName('NUMCMP').AsString, 15);
      cdsIteEqu.FieldByName('NITCMP').AsInteger := FieldByName('NITCMP').AsInteger;
      cdsIteEqu.FieldByName('DTACMP').AsDateTime := FieldByName('DTACMP').AsDateTime;
      cdsIteEqu.FieldByName('QTDEXP').AsFloat   := FieldByName('QTDEXP').AsFloat;
      cdsIteEqu.FieldByName('DESESP').AsFloat   := FieldByName('EQU_DESESP').AsFloat;
      cdsIteEqu.FieldByName('CLAFIS').AsString  := FieldByName('EQU_CLAFIS').AsString;
      cdsIteEqu.FieldByName('CODFIS').AsString  := FieldByName('EQU_CODFIS').AsString;
      cdsIteEqu.FieldByName('INCPIS').AsString  := FieldByName('EQU_INCPIS').AsString;
      cdsIteEqu.FieldByName('VALIPI').AsFloat   := FieldByName('EQU_VALIPI').AsFloat;
      cdsIteEqu.FieldByName('ALQIPI').AsFloat   := FieldByName('EQU_ALQIPI').AsFloat;
      cdsIteEqu.FieldByName('BASIPI').AsFloat   := FieldByName('EQU_BASIPI').AsFloat;
      cdsIteEqu.FieldByName('VALICM').AsFloat   := FieldByName('EQU_VALICM').AsFloat;
      cdsIteEqu.FieldByName('ALQICM').AsFloat   := FieldByName('EQU_ALQICM').AsFloat;
      cdsIteEqu.FieldByName('BASICM').AsFloat   := FieldByName('EQU_BASICM').AsFloat;
      cdsIteEqu.FieldByName('VALRET').AsFloat   := FieldByName('EQU_VALRET').AsFloat;

      If Assigned(FindField('EQU_VALCBS')) Then
      Begin
        cdsIteEqu.FieldByName('VALCBS').AsFloat := FieldByName('EQU_VALCBS').AsFloat;
        cdsIteEqu.FieldByName('VALIBS').AsFloat := FieldByName('EQU_VALIBS').AsFloat;
        cdsIteEqu.FieldByName('VAL_IS').AsFloat := FieldByName('EQU_VAL_IS').AsFloat;
      End;
      cdsIteEqu.FieldByName('ALQRET').AsFloat   := FieldByName('EQU_ALQRET').AsFloat;
      cdsIteEqu.FieldByName('BASRET').AsFloat   := FieldByName('EQU_BASRET').AsFloat;
      cdsIteEqu.FieldByName('PERBAS').AsFloat   := FieldByName('EQU_PERBAS').AsFloat;
      cdsIteEqu.FieldByName('PERRED').AsFloat   := FieldByName('EQU_PERRED').AsFloat;
      cdsIteEqu.FieldByName('VLRCON').AsFloat   := (FieldByName('EQU_TOTITE').AsFloat - FieldByName('EQU_DESESP').AsFloat) +
                                                   FieldByName('EQU_VALIPI').AsFloat +
                                                   FieldByName('EQU_VALRET').AsFloat;
      If fSomarNovosImpostosDaReformaAoValorContabil Then
        cdsIteEqu.FieldByName('VLRCON').AsFloat := cdsIteEqu.FieldByName('VLRCON').AsFloat +
                                                   cdsIteEqu.FieldByName('VALCBS').AsFloat +
                                                   cdsIteEqu.FieldByName('VALIBS').AsFloat +
                                                   cdsIteEqu.FieldByName('VAL_IS').AsFloat;

      cdsIteEqu.FieldByName('LOCSUP').AsString  := FieldByName('LOCSUP').AsString;
      cdsIteEqu.FieldByName('COBAPA').AsString  := FieldByName('EQU_COBAPA').AsString;
      cdsIteEqu.FieldByName('NUMLOT').AsString  := FieldByName('FDO_NUMLOT').AsString;
      cdsIteEqu.FieldByName('RESERV').AsString  := FieldByName('RESERV').AsString;
      cdsIteEqu.FieldByName('EMPITE').AsString  := FieldByName('EQU_EMPITE').AsString;
      cdsIteEqu.FieldByName('ABRSAL').AsString  := 'S';
      cdsIteEqu.FieldByName('MARDES').AsInteger:= 0;
      cdsIteEqu.FieldByName('SEQITE').AsInteger:= FSeqIte;
      cdsIteEqu.FieldByName('ATICOM').AsString  := FieldByName('ITE_ATICOM').AsString;
      cdsIteEqu.FieldByName('ITEESP').AsString  := IIF((Pos('ITEM ESPECIAL', FieldByName('ITE_DESITE').AsString) > 0), 'S', 'N');

      FSeqIte := FSeqIte + 1;
      cdsIteEqu.Post;

      FVlrPro := FVlrPro + cdsIteEqu.FieldByName('TOTITE').AsFloat - FieldByName('EQU_DESESP').AsFloat;
      FTotRet := FTotRet + cdsIteEqu.FieldByName('VALRET').AsFloat;
      FTotIPI := FTotIPI + cdsIteEqu.FieldByName('VALIPI').AsFloat;
      FTotCbs := FTotCbs + cdsIteEqu.FieldByName('VALCBS').AsFloat;
      FTotIbs := FTotIbs + cdsIteEqu.FieldByName('VALIBS').AsFloat;
      FTotIs  := FTotIs  + cdsIteEqu.FieldByName('VAL_IS').AsFloat;

      pCopiaRegistroDataSet(cdsIteEqu, FCdsIteEquLog);

      Next;
    End;

    fAtualizaSaldos;

    cdsIteEqu.EnableControls;
  End;

  FCdsSerEquLog.EmptyDataSet();

  With qryEquSer Do
  Begin
    FVlrSer    := 0;
    FDesEspSer := 0;

    First;
    cdsSerEqu.DisableControls;
    While Not Eof Do
    Begin
      cdsSerEqu.Append;
      cdsSerEqu.FieldByName('AUTINC').AsString := fieldbyname('AUTOINCREM').AsString;
      cdsSerEqu.FieldByName('CODSER').AsString := fieldbyname('EQU_CODSER').AsString;
      cdsSerEqu.FieldByName('DESSER').AsString := fieldbyname('EQU_DESSER').AsString;
      cdsSerEqu.FieldByName('VALSER').AsFloat  := fieldbyname('EQU_VALSER').AsFloat;
      cdsSerEqu.FieldByName('VALUNI').AsFloat  := fieldbyname('EQU_VALUNI').AsFloat;
      cdsSerEqu.FieldByName('PORDES').AsFloat  := fieldbyname('EQU_PORDES').AsFloat;
      cdsSerEqu.FieldByName('DESESP').AsFloat  := fieldbyname('EQU_DESESP').AsFloat;
      cdsSerEqu.FieldByName('TECSER').AsString := fieldbyname('EQU_TECSER').AsString;
      cdsSerEqu.FieldByName('BRINDE').AsString := fieldbyname('EQU_BRINDE').AsString;
      cdsSerEqu.FieldByName('CODPAR').AsString := fieldbyname('EQU_CODPAR').AsString;
      cdsSerEqu.FieldByName('TIPBRI').AsString := fieldbyname('EQU_TIPBRI').AsString;
      cdsSerEqu.FieldByName('CODDES').AsString := fieldbyname('EQU_TECSER').AsString + ' - ' + fRetNomeOperador(fieldbyname('EQU_TECSER').AsString);
      cdsSerEqu.FieldByName('COBAPA').AsString := fieldbyname('EQU_COBAPA').AsString;
      cdsSerEqu.FieldByName('QTDSER').AsFloat  := fieldbyname('EQU_QTDSER').AsFloat;
      cdsSerEqu.FieldByName('MAOCLI').AsString := fieldbyname('EQU_MAOCLI').AsString;
      cdsSerEqu.Post;

      FDesEspSer := FDesEspSer + cdsSerEqu.FieldByName('DESESP').AsFloat;
      FVlrSer := FVlrSer + cdsSerEqu.FieldByName('VALSER').AsFloat;

      pCopiaRegistroDataSet(cdsSerEqu, FCdsSerEquLog);

      Next;
    End;
    cdsSerEqu.EnableControls;
  End;

  FCdsDfeEquLog.EmptyDataSet();

  With qryEquDfe Do
  Begin
    First;
    cdsDfeEqu.DisableControls;
    While Not Eof Do
    Begin
      cdsDfeEqu.Append;
      cdsDfeEqu.FieldByName('AUTINC').AsString := fieldbyname('AUTOINCREM').AsString;
      cdsDfeEqu.FieldByName('CODDFE').AsString := fieldbyname('EQU_CODDFE').AsString;
      cdsDfeEqu.FieldByName('DESDFE').AsString := fieldbyname('EQU_DESDFE').AsString;
      cdsDfeEqu.Post;

      pCopiaRegistroDataSet(cdsDfeEqu, FCdsDfeEquLog);

      Next;
    End;
    cdsDfeEqu.EnableControls;
  End;

  FCdsAceEquLog.EmptyDataSet();

  With qryEquAce Do
  Begin
    First;
    cdsAceEqu.DisableControls;
    While Not Eof Do
    Begin
      cdsAceEqu.Append;
      cdsAceEqu.FieldByName('AUTINC').AsString := fieldbyname('AUTOINCREM').AsString;
      cdsAceEqu.FieldByName('CODACE').AsString := fieldbyname('EQU_CODACE').AsString;
      cdsAceEqu.FieldByName('DESACE').AsString := fieldbyname('EQU_DESACE').AsString;
      cdsAceEqu.FieldByName('QTDACE').AsFloat  := fieldbyname('EQU_QTDACE').AsFloat;
      cdsAceEqu.Post;

      pCopiaRegistroDataSet(cdsAceEqu, FCdsAceEquLog);

      Next;
    End;

    cdsAceEqu.EnableControls;
  End;

  pCarregaGridApo;
End;

procedure TConEqu.pCdsDocGerBeforePost(dtsDocGer: TDataSet);
begin
  if dtsDocGer.FieldByName('IMPSEP').AsBoolean and
     dtsDocGer.FieldByName('LIBPED').AsBoolean then
  begin
    pMensagemOk('É necessário liberar o pedido!');
    dtsDocGer.Cancel;
    Abort;
  end;
end;

function TConEqu.fRetArmazemPrincipal(const strCodEmp, strCodIte: String): String;
var
  LQry: TUniQuery;
begin
  LQry := fCriaQuery;
  try
    LQry.SQL.Add(' SELECT');
    LQry.SQL.Add('   LOT_NUMLOT');
    LQry.SQL.Add(' FROM CADLOT ');
    LQry.SQL.Add(' WHERE LOT_ARMPCE = "S" ');
    LQry.SQL.Add('   AND LOT_STATUS = "S" ');
    LQry.SQL.Add('   AND LOT_CODITE = :CODITE ');
    LQry.SQL.Add('   AND LOT_CODEMP = :CODEMP ');

    LQry.ParamByName('CODITE').AsString := strCodIte;
    LQry.ParamByName('CODEMP').AsString := strCodEmp;
    LQry.Open;

    Result := LQry.FieldByName('LOT_NUMLOT').AsString;
  finally
    FreeAndNil(LQry);
  end;
end;

class function TConEqu.fRetDadosMeqMer(strAutInc, strCodEmp,
  strNumero, strTipOpe: String): TMeqMer;
  Var
    strSQL: String;
    qryMeqMer: TUniQuery;
begin
  Try
    Result := TMeqMer.Create;

    strSQL := '';
    strSQL := strSQL + ' SELECT   ';
    strSQL := strSQL + '   *      ';
    strSQL := strSQL + ' FROM     ';
    strSQL := strSQL + '   MEQMER ';
    strSQL := strSQL + ' WHERE    ';
    strSQL := strSQL + '   TRUE   ';

    If Not fEmptyStr(strAutInc) Then
      strSQL := strSQL + ' AND MER_AUTEQU = :AUTEQU ';

    If Not fEmptyStr(strCodEmp) Then
      strSQL := strSQL + ' AND MER_EMPEQU = :EMPEQU ';

    If Not fEmptyStr(strNumero) Then
      strSQL := strSQL + ' AND MER_NUMOSE = :NUMOSE ';

    If Not fEmptyStr(strTipOpe) Then
      strSQL := strSQL + ' AND MER_TIPOPE = :TIPOPE ';

    qryMeqMer := fCriaQuery;

    With qryMeqMer Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      If Not fEmptyStr(strAutInc) Then
        ParamByName('AUTEQU').AsString := strAutInc;

      If Not fEmptyStr(strCodEmp) Then
        ParamByName('EMPEQU').AsString := strCodEmp;

      If Not fEmptyStr(strNumero) Then
        ParamByName('NUMOSE').AsString := strNumero;

      If Not fEmptyStr(strTipOpe) Then
        ParamByName('TIPOPE').AsString := strTipOpe;

      Open;

      If Not IsEmpty Then
      Begin
        Result.strAutInc := FieldByName('AUTOINCREM').AsString;
        Result.strAutEqu := FieldByName('MER_AUTEQU').AsString;
        Result.strEmpEqu := FieldByName('MER_EMPEQU').AsString;
        Result.strNumOse := FieldByName('MER_NUMOSE').AsString;
        Result.strAutGer := FieldByName('MER_AUTGER').AsString;
        Result.strNumDoc := FieldByName('MER_NUMDOC').AsString;
        Result.strEspDoc := FieldByName('MER_ESPDOC').AsString;
        Result.strEmpGer := FieldByName('MER_EMPGER').AsString;
        Result.strSerie_ := FieldByName('MER_SERIE_').AsString;
        Result.strCodCli := FieldByName('MER_CODCLI').AsString;
        Result.strTipOpe := FieldByName('MER_TIPOPE').AsString;
        Result.dtaDtaGer := FieldByName('MER_DTAGER').AsDateTime;
        Result.strChaveAcesso := FieldByName('MER_ACESSO').AsString;
        Result.strNCMEqu := FieldByName('MER_NCMEQU').AsString;
        Result.strAutDet := FieldByName('MER_AUTDET').AsString;
      End
      Else
        FreeAndNil(Result);
    End;
  Except
    On E: Exception Do
    Begin
      FreeAndNil(Result);
      pMensagensErro(E.Message, '[TConEqu.fRetDadosMeqMer]');
    End;
  End;

  FreeAndNil(qryMeqMer);
end;

Function TConEqu.fRetornaLocFis_LocSup(strCodIte, strEmpIte: String; out strLocFis, strLocSup: String): boolean;
Var
  strSQL: String;
  qryIteger: TUniQuery;
Begin

  Result := False;

  Try
    qryIteger := fCriaQuery;
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   ITE_LOCFIS, ';
    strSQL := strSQL + '   ITE_LOCSUP ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   ITEGER ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '   ITE_CODEMP = :CODEMP ';

    With qryIteger Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := strEmpIte;
      Open;

      strLocFis := FieldByName('ITE_LOCFIS').AsString;
      strLocSup := FieldByName('ITE_LOCSUP').AsString;

      if not IsEmpty then
        Result := True;

    End;

  Finally
    FreeAndNil(qryIteger);
  End;

End;

function TConEqu.fRetornaSaldoDisponivel(strCodIte, strEmpIte: String; out fltSaldoDisp, fltSalResTot: Double): Double;
Var
  strSQL: String;
  qryIteger: TUniQuery;
  objSalLoj: TSaldoLojas;

  intCalSal: Integer;
  blnEntFut,
  blnOrdPro: Boolean;
Begin
  intCalSal := fCfgSis('CALSAL', varInteger);
  blnEntFut := fCfgSis('ENTFUT', varBoolean);
  blnOrdPro := fCfgSis('ORDPRO', varBoolean);

  Try
    objSalLoj := TSaldoLojas.Create(Self);

    qryIteger := fCriaQuery;
    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   ITE_SALDOS ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   ITEGER ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '   ITE_CODEMP = :CODEMP ';

    With qryIteger Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('CODEMP').AsString := strEmpIte;
      Open;

      objSalLoj.pCalculaSaldos(qryIteger,
                               FrecSaldos, FrecSaldosML,
                               qryIteger.FieldByName('ITE_SALDOS').AsFloat, VS_strCodEmp, strEmpIte,
                               strCodIte, 0,
                               blnEntFut, False, blnOrdPro, intCalSal);

      Result := FrecSaldos.fltSalDis;
    End;
  Finally
    FreeAndNil(objSalLoj);
    FreeAndNil(qryIteger);
  End;
End;

procedure TConEqu.pAlteraServicoGrid;
begin
  cdsSerEqu.Edit;
  cdsSerEqu.FieldByName('CODSER').AsString := FCodSer;
  cdsSerEqu.FieldByName('DESSER').AsString := FDesSer;
  cdsSerEqu.FieldByName('TECSER').AsString := FTecSer;
  cdsSerEqu.FieldByName('BRINDE').AsString := FBrinde;
  cdsSerEqu.FieldByName('CODPAR').AsString := FCodPar;
  cdsSerEqu.FieldByName('TIPBRI').AsString := FTipBri;
  cdsSerEqu.FieldByName('PORDES').AsFloat  := FPorDes;
  cdsSerEqu.FieldByName('VALUNI').AsFloat  := FValUni;
  cdsSerEqu.FieldByName('DESESP').AsFloat  := (FValUni * FQtdSer) * (FPorDes / 100);
  cdsSerEqu.FieldByName('VALSER').AsFloat  := (FValUni * FQtdSer) * (1 - (FPorDes / 100));
  cdsSerEqu.FieldByName('CODDES').AsString := FTecSer + ' - ' + fRetNomeOperador(FTecSer);
  cdsSerEqu.FieldByName('COBAPA').AsString := FCobAPaSer;
  cdsSerEqu.FieldByName('QTDSER').AsFloat  := FQtdSer;
  cdsSerEqu.Post;
end;

procedure TConEqu.pAlteraStatusAguardandoMontagem;
Var
  strSQL : String;
  qryGen : TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + '   EQUGER ';
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + '   EQU_AG_MON = :AG_MON ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   EQU_NUMOSE = :NUMOSE AND ';
    strSQL := strSQL + '   EQU_CODEMP = :CODEMP ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AG_MON').AsString := IIF(FAg_Mon, 'S', 'N');
      ParamByName('NUMOSE').AsString := FNumero;
      ParamByName('CODEMP').AsString := fCodEmp;

      ExecSQL;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

procedure TConEqu.pAlteraStatusDados(strNovStatus,
                                     strNovSubStatus: String;
                                     strCodMre: String = '';
                                     blnDelPD: Boolean = False;
                                     strRetPor: String = '';
                                     strOsPdCl: String = '';
                                     strReaPor: String = '';
                                     strReaTel: string = '';
                                     dtaSitDtr: TDateTime = 0;
                                     strRea_RG: String = '';
                                     blnFluPro: Boolean = False;
                                     blnLimMan: Boolean = False;
                                     blnLimMRe: Boolean = False);
Var
  strSQL : String;
  qryGen,
  qryFGOEQU : TUniQuery;
  blnDeletouPed: Boolean;
  blnJaFaturado: Boolean;
  blnTemPed: Boolean;
  blnEncontrouPed: Boolean;
  strPedido: String;
  cdsEmpIte: TUniClientDataSet;
  blnEmTransacao: Boolean;
Begin
  FStatusDadosAlterado := False;

  blnEmTransacao := fInTransaction;

  if fEmptyStr(FEmpPed) then
    FEmpPed := VS_strCodEmp;

  Try
    If Not blnEmTransacao Then
      fStartTransaction;

    qryGen := fCriaQuery(Self);
    qryFGOEQU := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + '   EQUGER ';
    strSQL := strSQL + ' SET ';

    If (strNovStatus = 'R') Then
      strSQL := strSQL + '   EQU_DTAFIN  = ' + fCurrentDate + ', ';

    strSQL := strSQL + '   EQU_STATUS = :STATUS, ';
    strSQL := strSQL + '   EQU_SUBSTA = :SUBSTA, ';
    strSQL := strSQL + '   EQU_SITEQU = :SITEQU, ';
    strSQL := strSQL + '   EQU_AG_MON = :AG_MON, ';
    strSQL := strSQL + '   EQU_CLIGAR = :CLIGAR, ';
    strSQL := strSQL + '   EQU_NOMCON = :NOMCON, ';
    strSQL := strSQL + '   EQU_ENDCON = :ENDCON, ';
    strSQL := strSQL + '   EQU_BAICON = :BAICON, ';
    strSQL := strSQL + '   EQU_CEPCON = :CEPCON, ';
    strSQL := strSQL + '   EQU_CIDCON = :CIDCON, ';
    strSQL := strSQL + '   EQU_TELCON = :TELCON, ';
    strSQL := strSQL + '   EQU_CGCCPF = :CGCCPF, ';
    strSQL := strSQL + '   EQU_CGCCON = :CGCCON, ';
    strSQL := strSQL + '   EQU_IESCON = :IESCON, ';
    strSQL := strSQL + '   EQU_R_GCON = :R_GCON, ';

    If (Not fEmptyStr(strCodMre)) or blnLimMRe Then
      strSQL := strSQL + '   EQU_CODMRE = :CODMRE, ';

    strSQL := strSQL + '   EQU_RETPOR = :RETPOR, ';
    strSQL := strSQL + '   EQU_REAPOR = :REAPOR, ';
    strSQL := strSQL + '   EQU_OSPDCL = :OSPDCL, ';
    strSQL := strSQL + '   EQU_ENTGER = :ENTGER, ';
    strSQL := strSQL + '   EQU_LOCFIS = :LOCFIS, ';
    strSQL := strSQL + '   EQU_REATEL = :REATEL, ';
    strSQL := strSQL + '   EQU_SITDTR = :SITDTR, ';
    strSQL := strSQL + '   EQU_FLXFAS = :FLXFAS, ';
    strSQL := strSQL + '   EQU_FLXSIT = :FLXSIT, ';
    strSQL := strSQL + '   EQU_FLXCOM = :FLXCOM, ';
    strSQL := strSQL + '   EQU_REA_RG = :REA_RG, ';
    strSQL := strSQL + '   EQU_ENTREG = :ENTREG, ';
    strSQL := strSQL + '   EQU_DIGRET = :DIGRET, ';
    strSQL := strSQL + '   EQU_DTAARM = :DTAARM, ';
    strSQL := strSQL + '   EQU_DTTXAR = :DTTXAR, ';
    strSQL := strSQL + '   EQU_AUTDES = :AUTDES, ';
    strSQL := strSQL + '   EQU_TIPAPR = :TIPAPR  ';

    If Not fEmptyStr(FCliEma) Then
      strSQL := strSQL + '   ,EQU_EMLCON = :EMLCON  ';

    if blnLimMan then
    begin
      strSQL := strSQL + '   ,EQU_DTFIMA = NULL ';
      strSQL := strSQL + '   ,EQU_OPFIMA = NULL ';
    end;

    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   EQU_NUMOSE = :NUMOSE AND ';
    strSQL := strSQL + '   EQU_CODEMP = :CODEMP ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('STATUS').AsString := strNovStatus;
      ParamByName('SUBSTA').AsString := strNovSubStatus;

      {Situação do Equipamento}
      ParamByName('SITEQU').AsString := fStatusToSituacaoEquipamento(strNovStatus, strNovSubStatus);

      ParamByName('AG_MON').AsString := IIF(FAg_Mon, 'S', 'N');

      If fEmptyStr(FCliGar) Then
        ParamByName('CLIGAR').Value := Null
      Else
        ParamByName('CLIGAR').AsString := FCliGar;

      ParamByName('NOMCON').AsString := FCliNom;
      ParamByName('ENDCON').AsString := FCliEnd;
      ParamByName('BAICON').AsString := FCliBai;
      ParamByName('CEPCON').AsString := FCliCep;

      If fEmptyStr(FCodCid) Then
        ParamByName('CIDCON').Value    := Null
      Else
        ParamByName('CIDCON').AsString := FCodCid;

      ParamByName('TELCON').AsString := FCliTel;
      ParamByName('CGCCPF').AsInteger:= FCgcCpf;
      ParamByName('CGCCON').AsString := FCliCgc;
      ParamByName('IESCON').AsString := FCliIes;
      ParamByName('R_GCON').AsString := FCli_Rg;

      If Not fEmptyStr(FCliEma) Then
        ParamByName('EMLCON').AsString := FCliEma;
      ParamByName('NUMOSE').AsString := FNumero;

      If blnLimMRe Then
        ParamByName('CODMRE').Value := Null
      Else If Not fEmptyStr(strCodMre) Then
        ParamByName('CODMRE').AsString := strCodMre;

      If Not fEmptyStr(strRetPor) Then
        ParamByName('RETPOR').AsString := strRetPor
      Else
        ParamByName('RETPOR').Value    := Null;

      If Not fEmptyStr(strReaPor) Then
        ParamByName('REAPOR').AsString := strReaPor
      Else
        ParamByName('REAPOR').Value    := Null;

      If Not fEmptyStr(strOsPdCl) Then
        ParamByName('OSPDCL').AsString := strOsPdCl
      Else
        ParamByName('OSPDCL').Value    := Null;

      If fEmptyStr(FLocFisEqu) Then
        ParamByName('LOCFIS').Value    := Null
      Else
        ParamByName('LOCFIS').AsString := FLocFisEqu;

      If Not fEmptyStr(strReaTel) Then
        ParamByName('REATEL').AsString := strReaTel
      Else
        ParamByName('REATEL').Value    := Null;

      If dtaSitDtr > 0 Then
        ParamByName('SITDTR').AsDateTime := dtaSitDtr
      Else
        ParamByName('SITDTR').Value    := Null;

      If Not fEmptyStr(strRea_RG) Then
        ParamByName('REA_RG').AsString := strRea_RG
      Else
        ParamByName('REA_RG').Value    := Null;

      If FEntreg <> 0 Then
        ParamByName('ENTREG').AsDateTime := FEntreg
      Else
        ParamByName('ENTREG').Value      := Null;

      If (not fEmptyStr(FDigRet)) Then
        ParamByName('DIGRET').AsString := FDigRet
      Else
        ParamByName('DIGRET').Value    := Null;

      If FDtaArm <> 0 Then
        ParamByName('DTAARM').AsDateTime := FDtaArm
      Else
        ParamByName('DTAARM').Value      := Null;

      If FDtTxAr <> 0 Then
        ParamByName('DTTXAR').AsDateTime := FDtTxAr
      Else
        ParamByName('DTTXAR').Value      := Null;

      ParamByName('AUTDES').AsString := IIF(FblnAutDes, 'S', 'N');

      ParamByName('TIPAPR').AsString := FTipApr;

      ParamByName('FLXFAS').AsString := FFlxFas;
      ParamByName('FLXSIT').AsString := FFlxSit;
      ParamByName('FLXCOM').AsString := FFlxCom;
      ParamByName('ENTGER').AsString := FEntGer;
      ParamByName('CODEMP').AsString := fCodEmp;
      ExecSQL;
    End;

    {*****************************************************************}
    {* SE A O.S. ESTÁ SENDO "REPROVADA", O PEDIDO VINCULADO DEVE SER *}
    {* CANCELADO, DESDE QUE NÃO ESTEJA FATURADO.                     *}
    {**************************************************************MM*}

    blnDeletouPed := False;
    blnJaFaturado := fRetornaInformacaoVenda(FNumPed, 'PD', FEmpPed, 'JAFATU') = '1';
    If Not blnJaFaturado Then
      blnJaFaturado := fCampoTabela('FDO_JAFATU', 'FATDOR', ['FDO_NUMDOC', 'FDO_CODEMP', 'FDO_ESPDOC', 'FDO_JAFATU'], [FNumPed,FEmpPed,'PD','1']) = '1';

    If (blnDelPD) And (Not fEmptyStr(FNumPed)) Then
    Begin
      If (Not blnJaFaturado) Then
      Begin
        qryFGOEQU.Close;
        qryFGOEQU.SQL.Text := SELECT_PD_EQUGOR;
        qryFGOEQU.ParamByName('SEQEQU').AsString := FAutInc;
        qryFGOEQU.Open;

        if (not qryFGOEQU.IsEmpty) then
        begin
          while not qryFGOEQU.Eof do
          begin
            blnDeletouPed := fDeletarFATDOR(qryFGOEQU.FieldByName('NUMDOC').AsString, qryFGOEQU.FieldByName('CODEMP').AsString,
              qryFGOEQU.FieldByName('CODCLI').AsString, 0, strNovStatus = 'N');

            qryFGOEQU.Next;
          end;
        end
        else
          blnDeletouPed := fDeletarFATDOR(FNumPed, FEmpPed, FCliPed, 0, strNovStatus = 'N');
      end;
    End;

    If (Not fCfgSis('GER_OS', VarBoolean)) And
       ( (blnDelPD) Or (strNovStatus = 'A') Or (blnDeletouPed) ) And
       (Not blnJaFaturado) And //Pedido nao esteja faturado
       (strNovStatus <> 'N') And  //Reprovada
       (strNovStatus <> 'F') And  //Orçamento
       (strNovStatus <> 'E') Then  //Em Aberto
    Begin
      if fEmptyStr(FEmpApr) then
        FEmpApr := VS_strCodEmp;

      cdsDocGer.EmptyDataSet;

      if Assigned(objFatVendaImp) then
        FreeAndNil(objFatVendaImp);

      objFatVendaImp := TFatVendaImp.Create;

      pDeletaPedidos(FNumPed);
      cdsEmpIte := TUniClientDataSet.Create(Self);
      pCarregaEmpIte(cdsEmpIte);

      if (cdsEmpIte.RecordCount = 1) and (cdsEmpIte.FieldByName('EMPITE').AsString = VS_strCodEmp) and (Length(FArrPedidos) <= 1) then
        FMulLoj := False;

      try
        if FMulLoj then
        begin
          blnTemPed := not fEmptyStr(FNumPed);
          blnEncontrouPed := blnTemPed and fVerificaPedExistente(cdsEmpIte);

          cdsEmpIte.First;

          while not cdsEmpIte.Eof do
          begin
            strPedido := '';
            cdsIteEqu.Filtered := False;
            cdsIteEqu.Filter   := 'EMPITE=' + QuotedStr(cdsEmpIte.FieldByName('EMPITE').AsString);
            cdsIteEqu.Filtered := True;

            if (not blnTemPed) and (cdsEmpIte.RecNo = 1) then
            begin
              If Not fGeraPedidoVenda(FNumPed, True, cdsEmpIte.FieldByName('EMPITE').AsString) Then
                Raise Exception.Create('Não foi possível gerar o pedido de venda!');
            end
            else if (blnTemPed) then
            begin
              if (blnEncontrouPed) and fVerificaPedExistente(Nil, cdsEmpIte.FieldByName('EMPITE').AsString) then
              begin
                If Not fGeraPedidoVenda(FNumPed, True, cdsEmpIte.FieldByName('EMPITE').AsString) Then
                  Raise Exception.Create('Não foi possível gerar o pedido de venda!');
              end
              else if (not blnEncontrouPed) and (cdsEmpIte.RecNo = 1) then
              begin
                FNumPed := fGetNumPed(cdsEmpIte.FieldByName('EMPITE').AsString);
                If Not fGeraPedidoVenda(FNumPed, True, cdsEmpIte.FieldByName('EMPITE').AsString) Then
                  Raise Exception.Create('Não foi possível gerar o pedido de venda!');
              end
              else
              begin
                If Not fGeraPedidoVenda(strPedido, False, cdsEmpIte.FieldByName('EMPITE').AsString) Then
                  Raise Exception.Create('Não foi possível gerar o pedido de venda!');
              end;
            end
            else
            begin
              If Not fGeraPedidoVenda(strPedido, False, cdsEmpIte.FieldByName('EMPITE').AsString) Then
                Raise Exception.Create('Não foi possível gerar o pedido de venda!');
            end;

            cdsEmpIte.Next;
          end;
        end
        else
        begin
          If Not fGeraPedidoVenda(FNumPed, True) Then
            Raise Exception.Create('Não foi possível gerar o pedido de venda!');
        end;
      finally
        cdsIteEqu.Filtered := False;
        cdsIteEqu.Filter   := '';
        cdsIteEqu.Filtered := True;

        FreeAndNil(cdsEmpIte);
        FMulLoj := fCfgSis('MLPSOS', varBoolean);
      end;
    End;

    If ((strNovStatus = 'N') And (Not fEmptyStr(FNumPed))) or (blnFluPro) Then
      pMarcaNumeroPedidoVenda(FNumPed, True);

    If Not blnEmTransacao Then
      fCommit;

    FStatusDadosAlterado := True;

  Except
    On E: EDeletaFATGOR Do
    Begin
      FStatusDadosAlterado := False;

      If Not blnEmTransacao Then
        fRollback;

      pMensagensErro(E.Message, '');
    End;

    On E: Exception Do
    Begin
      FStatusDadosAlterado := False;

      If Not blnEmTransacao Then
        fRollback;

      Raise;
    End;
  End;

  FreeAndNil(qryGen);
  FreeAndNil(qryFGOEQU);
End;

procedure TConEqu.pAlteraStatusPeca(strCodIte, strAguard: String);
Var
  strSQL : String;
  qryGen : TUniQuery;
Begin
  Try
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' UPDATE ';
    strSQL := strSQL + '   EQUDET ';
    strSQL := strSQL + ' SET ';
    strSQL := strSQL + '   EQU_AGUARD = :AGUARD ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   EQU_CODITE = :CODITE AND ';
    strSQL := strSQL + '   EQU_NUMOSE = :NUMOSE AND ';
    strSQL := strSQL + '   EQU_CODEMP = :CODEMP ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AGUARD').AsString := strAguard;
      ParamByName('CODITE').AsString := strCodIte;
      ParamByName('NUMOSE').AsString := FNumero;
      ParamByName('CODEMP').AsString := fCodEmp;

      ExecSQL;
    End;

  Finally
    FreeAndNil(qryGen);
  End;
end;

function TConEqu.fVerificaRealizacao(objTabela : TRegistroMsgLiberaTabela): Boolean;
Var
  objLinha : TLinhaMsgLibera;
  blnAvisa: Boolean;
Begin
  Result := True;

  If (Pos(fCfgSis('SLDPED'), 'AT') <= 0) Then
    Exit;

  blnAvisa := (fCfgSis('SLDPED') = 'A');

  cdsIteEqu.DisableControls;
  With cdsIteEqu Do
  Begin
    First;

    objTabela.Clear;

    While Not Eof Do
    Begin
      If fIsItemEspecial(fieldbyname('CODITE').AsString) and (Pos('ITEM ESPECIAL', fieldbyname('DESITE').AsString) > 0) Then
      Begin
        Next;
        Continue;
      End;

      objLinha := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha :=tlValor;
      If not fVerificaEstoqueItem(fieldbyname('CODITE').AsString, IIF(FMulLoj, fieldbyname('EMPITE').AsString, VS_strCodEmp), fieldbyname('QTDITE').AsFloat, objLinha) Then
      Begin
        objTabela.lstLinhas.Add(objLinha);

        If Not blnAvisa Then
          Result := False;
      End
      else
        FreeAndNil(objLinha);

      Next;
    End;
  End;
  cdsIteEqu.EnableControls;

End;

function TConEqu.fVerificaValidade: Boolean;
var
  blnVencido: Boolean;
begin
  Result := True;
  if (fCfgSis('EQUVEN', varInteger) = 0) or (not fCfgSis('EQUVBL', varBoolean)) then
    Exit;

  blnVencido := (FDtaEnt + fCfgSis('EQUVEN', varInteger)) < untFuncoesSimples.VS_Date;

  if blnVencido then
  begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddSeparador(80);
    objLiberacao.objMsgLibera.pAddTexto('ORDEM DE SERVIÇO FORA DO PRAZO DE VALIDADE');
    objLiberacao.objMsgLibera.pAddSeparador(80);
    objLiberacao.objMsgLibera.pAddTextoCaption('Número'     , strNumero, 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'       , strCodCli + '-' + fRetNomCliente(strCodCli), 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Dt. Emissão'   , strDtaEnt, 14);
    objLiberacao.objMsgLibera.pAddTextoCaption('Dt. Validade', FDtaEnt + fCfgSis('EQUVEN', varInteger), 14);
    objLiberacao.objMsgLibera.pAddSeparador(80);

    objLiberacao.strDirAce := 'EQUVBL';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.blnSempreVariavelUsuario := True;
    Result := objLiberacao.fLibera;
  end;
end;

class function TConEqu.fVinculaOSemNotaFiscal(Var objMeqMer: TMeqMer): Boolean;
  Var
    strSQL: String;
    qryTmp: TUniQuery;
begin
  Try
    qryTmp := fCriaQuery;

    fDesvinculaOSemNotaFiscal(objMeqMer);

    strSQL := '';
    strSQL := strSQL + ' INSERT INTO     ';
    strSQL := strSQL + '   MEQMER(       ';
    strSQL := strSQL + '     AUTOINCREM, ';
    strSQL := strSQL + '     MER_AUTEQU, ';
    strSQL := strSQL + '     MER_EMPEQU, ';
    strSQL := strSQL + '     MER_NUMOSE, ';
    strSQL := strSQL + '     MER_AUTGER, ';
    strSQL := strSQL + '     MER_NUMDOC, ';
    strSQL := strSQL + '     MER_ESPDOC, ';
    strSQL := strSQL + '     MER_EMPGER, ';
    strSQL := strSQL + '     MER_SERIE_, ';
    strSQL := strSQL + '     MER_CODCLI, ';
    strSQL := strSQL + '     MER_TIPOPE, ';
    strSQL := strSQL + '     MER_DTAGER, ';
    strSQL := strSQL + '     MER_ACESSO, ';
    strSQL := strSQL + '     MER_AUTDET, ';
    strSQL := strSQL + '     MER_NCMEQU) ';
    strSQL := strSQL + ' VALUES(     ';
    strSQL := strSQL + '     :AUTINC, ';
    strSQL := strSQL + '     :AUTEQU, ';
    strSQL := strSQL + '     :EMPEQU, ';
    strSQL := strSQL + '     :NUMOSE, ';
    strSQL := strSQL + '     :AUTGER, ';
    strSQL := strSQL + '     :NUMDOC, ';
    strSQL := strSQL + '     :ESPDOC, ';
    strSQL := strSQL + '     :EMPGER, ';
    strSQL := strSQL + '     :SERIE_, ';
    strSQL := strSQL + '     :CODCLI, ';
    strSQL := strSQL + '     :TIPOPE, ';
    strSQL := strSQL + '     :DTAGER, ';
    strSQL := strSQL + '     :ACESSO, ';
    strSQL := strSQL + '     :AUTDET, ';
    strSQL := strSQL + '     :NCMEQU) ';

    With qryTmp Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('AUTINC').AsString   := fRetAutoIncrem('MEQMER', VS_strCodEmp);

      objMeqMer.strAutInc := ParamByName('AUTINC').AsString;

      If Not fEmptyStr(objMeqMer.strAutEqu) Then
        ParamByName('AUTEQU').AsString := objMeqMer.strAutEqu
      Else
        ParamByName('AUTEQU').Value    := Null;

      If Not fEmptyStr(objMeqMer.strEmpEqu) Then
        ParamByName('EMPEQU').AsString := objMeqMer.strEmpEqu
      Else
        ParamByName('EMPEQU').Value    := Null;

      If Not fEmptyStr(objMeqMer.strNumOse) Then
        ParamByName('NUMOSE').AsString := objMeqMer.strNumOse
      Else
        ParamByName('NUMOSE').Value    := Null;

      If Not fEmptyStr(objMeqMer.strAutGer) Then
        ParamByName('AUTGER').AsString := objMeqMer.strAutGer
      Else
        ParamByName('AUTGER').Value    := Null;

      If Not fEmptyStr(objMeqMer.strNumDoc) Then
        ParamByName('NUMDOC').AsString := objMeqMer.strNumDoc
      Else
        ParamByName('NUMDOC').Value    := Null;

      If Not fEmptyStr(objMeqMer.strEspDoc) Then
        ParamByName('ESPDOC').AsString := objMeqMer.strEspDoc
      Else
        ParamByName('ESPDOC').Value := Null;

      If Not fEmptyStr(objMeqMer.strEmpGer) Then
        ParamByName('EMPGER').AsString := objMeqMer.strEmpGer
      Else
        ParamByName('EMPGER').Value    := Null;

      If Not fEmptyStr(objMeqMer.strSerie_) Then
        ParamByName('SERIE_').AsString := objMeqMer.strSerie_
      Else
        ParamByName('SERIE_').Value := Null;

      If Not fEmptyStr(objMeqMer.strCodCli) Then
        ParamByName('CODCLI').AsString := objMeqMer.strCodCli
      Else
        ParamByName('CODCLI').Value    := Null;

      ParamByName('TIPOPE').AsString   := objMeqMer.strTipOpe;
      ParamByName('DTAGER').AsDateTime := objMeqMer.dtaDtaGer;

      If Not fEmptyStr(objMeqMer.strChaveAcesso) Then
        ParamByName('ACESSO').AsString := objMeqMer.strChaveAcesso
      Else
        ParamByName('ACESSO').Value    := Null;

      If Not fEmptyStr(objMeqMer.strAutDet) Then
        ParamByName('AUTDET').AsString := objMeqMer.strAutDet
      Else
        ParamByName('AUTDET').Value    := Null;

      If Not fEmptyStr(objMeqMer.strNCMEqu) Then
        ParamByName('NCMEQU').AsString := objMeqMer.strNCMEqu
      Else
        ParamByName('NCMEQU').Value    := Null;

      ExecSQL;

      Result := RowsAffected > 0;
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '[TfrmSelecionarNota.fValidaNotaFiscal]');
    End;
  End;

  FreeAndNil(qryTmp);
end;

function TConEqu.fValidarEstoqueInsuficiente: Boolean;
  Var
    strNtrava,
    strOpcTra : String;
    objMsg : TMensagemLiberacao;
    objTabela : TRegistroMsgLiberaTabela;
    objLinha : TLinhaMsgLibera;
begin
  Result   := False;

  objTabela := TRegistroMsgLiberaTabela.Create;
  fVerificaRealizacao(objTabela);

  If (Not objTabela.isEmpty ) Then
  Begin
    objMsg := TMensagemLiberacao.Create(Self);
    try
      strOpcTra := fCfgSis('SLDPED', varString);

      objMsg.pAddTexto('Liberação de itens sem saldo no pedido - Conserto de Equipamento!');
      objMsg.pAddTexto('Os Itens abaixo não possuem saldo de estoque:');
      objMsg.pAddQuebra;

      objLinha := TLinhaMsgLibera.Create;
      objLinha.enuTipoLinha :=tlCabecalho;
      objLinha.pAddColuna('', 'CÓDIGO'     , 7 , alCentro   , teAutcom);
      objLinha.pAddColuna('', 'DESCRIÇÃO'  , 40, alEsquerda , teAutcom);
      objLinha.pAddColuna('', 'QTDE. PEDID', 12, alDireita  , teAutcom);
      objLinha.pAddColuna('', 'SALDO'      , 12, alDireita  , teAutcom);

      objTabela.lstLinhas.Insert(0, objLinha);

      objMsg.lstRegistros.AdD(objTabela);

      If CharInSet(strOpcTra[1], ['A', 'T']) And
         (Not fSenhaLiberacaoSemSaldoPE(FCodVen,
                                        strLoginUsuarioLogado,
                                        strNtrava,
                                        Nil,
                                        objMsg,
                                        True,
                                        '',
                                        False,
                                        False,
                                        strOpcTra[1] = 'T')) Then
        Result := True;

    finally
      FreeAndNil(objMsg);
    end;
  End
  else
    FreeAndNil(objTabela);
end;

function TConEqu.fValorCobAParte(strCobAPa: String): Double;
var
  cdsDados: TUniClientDataSet;
begin
  Result := 0;

  if (not FCobApa) then
    Exit;

  cdsDados := TUniClientDataSet.Create(Self);

  try
    pCloneDataSet(cdsDados, cdsSerEqu);
    cdsDados.Filtered := False;
    cdsDados.Filter   := 'COBAPA=' + QuotedStr(IIF(strCobAPa = 'S', 'N', 'S'));
    cdsDados.Filtered := True;

    cdsDados.First;

    while not cdsDados.Eof do
    begin
      Result := Result + cdsDados.FieldByName('VALSER').AsFloat;

      cdsDados.Next;
    end;
  finally
    FreeAndNil(cdsDados);
  end;
end;

function TConEqu.fVerificaAcessoSistemaOS(strDirAce, strObserv, strUsuarioLogado: String): Boolean;
  Var
    strCodVenDig: String;
begin
  If (Not fEmptyStr(strUsuarioLogado)) Then
    Result := fVerificaAcessoSistema(strDirAce, strUsuarioLogado)
  Else
    Result := fVerificaAcessoSistema(strDirAce);

  If (Not fEmptyStr(FCodDig)) Then
    strCodVenDig := FCodDig
  Else
    strCodVenDig := FCodVen;

  If (fEmptyStr(strCodVenDig)) Then
    strCodVenDig := strLoginUsuarioLogado;

  If (Result) Then
    pGeraLogLiberacao(FNumero, 'OS', FCodEmp, strObserv, strLoginUsuarioLogado, strCodVenDig, strObserv);
end;

function TConEqu.fVerificaEstoqueItem(strCodigo, strEmpIte: String; fltQtdNec: Double; objLinha : TLinhaMsgLibera): Boolean;
Var
  qrySaldo: TUniQuery;
  fltSalRes: Double;
  fltSaldo: Double;
  strSQL: String;
Begin

  objLinha.Clear;

  Result := True;

  If fIsItemEspecial(strCodigo) Then
    Exit;

  Try
    {***********************************}
    {* BUSCA O SALDO RESERVADO DO ITEM *}
    {********************************LU*}
    fltSalRes := TSaldoReservado.New(
                   TReservaParametros.New()
                     .EmpresaItem(strEmpIte)
                     .CodigoItem(strCodigo)
                     .CodEmpresa(VS_strCodEmp)
                     .NumeroDocumento(strNumPed)
                     .TipoFiltroDocumento(IIF(fEmptyStr(strNumPed), tfdTodos, tfdIgnorarDocumento))
                   ).fGetQuantidade();

    qrySaldo := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   CADITE.ITE_CODITE, ';
    strSQL := strSQL + '   CADITE.ITE_DESITE, ';
    strSQL := strSQL + '   ITEGER.ITE_SALDOS ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADITE, ';
    strSQL := strSQL + '   ITEGER  ';
    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   CADITE.ITE_CODITE = ITEGER.ITE_CODITE AND ';
    strSQL := strSQL + '   CADITE.ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '   ITEGER.ITE_CODEMP = :CODEMP ';

    {*************************}
    {* BUSCA O SALDO DO ITEM *}
    {**********************LU*}
    With qrySaldo Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODITE').AsString := strCodigo;
      ParamByName('CODEMP').AsString := strEmpIte;
      Open;
    End;

    fltSaldo := qrySaldo.fieldbyname('ITE_SALDOS').AsFloat - fltSalRes;

    If (fltSaldo >= fltQtdNec) Then
      Result := True
    Else
    Begin
      Result := False;
      objLinha.pAddColuna('CÓDIGO'     , qrySaldo.fieldbyname('ITE_CODITE').asString   , 7 , alCentro);
      objLinha.pAddColuna('DESCRIÇÃO'  , qrySaldo.fieldbyname('ITE_DESITE').asString   , 40, alEsquerda);
      objLinha.pAddColuna('QTDE. PEDID', FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), fltQtdNec)            , 12, alDireita);
      objLinha.pAddColuna('SALDO'      , FormatFloat(fMskDigitos(fCfgSis('DECQTD', varInteger)), fltSaldo - fltQtdNec) , 12, alDireita);
    End;

  Finally
    FreeAndNil(qrySaldo);
  End;

End;

function TConEqu.fVerificaEstoqueItens: Boolean;
var
  objTabela: TRegistroMsgLiberaTabela;
begin
  Result   := False;

  objTabela := TRegistroMsgLiberaTabela.Create;
  fVerificaRealizacao(objTabela);

  If (Not objTabela.isEmpty ) Then
    Result := True;

  FreeAndNil(objTabela);
end;

function TConEqu.fVerificaEstoqueItensArmazem: Boolean;
var
  fltSalRes,
  fltSaldos: Double;
  cdsDados : TUniClientDataSet;
begin
  Result := True;

  cdsDados := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsDados, cdsIteEqu);

  try
    cdsDados.First;

    while not cdsDados.Eof do
    begin
      fltSaldos := fCampoTabela('IFNULL(LOT_SALDOS, 0)', 'CADLOT', ['LOT_STATUS', 'LOT_CODITE', 'LOT_CODEMP', 'LOT_NUMLOT'],
          ['S', cdsDados.FieldByName('CODITE').AsString, VS_strCodEmp, cdsDados.FieldByName('NUMLOT').AsString]);

      fltSalRes := TSaldoReservado.New(
                     TReservaParametros.New()
                       .EmpresaItem(IIF(FMulLoj, cdsDados.FieldByName('EMPITE').AsString, VS_strCodEmp))
                       .CodigoItem(cdsDados.FieldByName('CODITE').AsString)
                       .CodEmpresa(VS_strCodEmp)
                       .NumeroDocumento(strNumPed)
                       .TipoFiltroDocumento(IIF(fEmptyStr(strNumPed), tfdTodos, tfdIgnorarDocumento))
                       .NumeroLote(cdsDados.FieldByName('NUMLOT').AsString)
                   ).fGetQuantidade();

      if (fFormataFloat(fltSaldos - fltSalRes, 2) < fFormataFloat(cdsDados.FieldByName('QTDITE').AsFloat, 2)) then
      begin
        Result := False;
        Exit;
      end;

      cdsDados.Next;
    end;
  finally
    FreeAndNil(cdsDados);
  end;
end;

function TConEqu.fVerificaExisteNegociacao(blnEmAberto: Boolean = True): String;
var
  strSQL       : String;
  qryNegociacao: TUniQuery;
begin
  Result := '';
  qryNegociacao := fCriaQuery;

  try
    strSQL := '';
    strSQL := strSQL + ' SELECT NEG_NRONEG ';
    strSQL := strSQL + ' FROM NEGOSE ';
    strSQL := strSQL + ' INNER JOIN NEGEQU ON NEGOSE.AUTOINCREM = NEGEQU.NEG_SEQNEG ';
    strSQL := strSQL + ' WHERE NEGEQU.NEG_SEQGER = :SEQGER ';

    if blnEmAberto then
      strSQL := strSQL + '     AND NEGOSE.NEG_STATUS = "A" ';

    qryNegociacao.SQL.Text := strSQL;
    qryNegociacao.ParamByName('SEQGER').AsString := FAutInc;
    qryNegociacao.Open;

    Result := qryNegociacao.FieldByName('NEG_NRONEG').AsString;
  finally
    pFreeAndNil(qryNegociacao);
  end;
end;

function TConEqu.fVerificaItensServicosCobAParte: Boolean;
begin
  Result := False;

  if (FGarant = 'N') then
    Exit;

  if (not cdsIteEqu.Locate('COBAPA', 'S', [])) and (not cdsSerEqu.Locate('COBAPA', 'S', [])) then
    Exit;

  Result := True;
end;

function TConEqu.fVerificaLoteItens(const strCodEmp: String):Boolean;
  Var
    strNumLot : String;
    strMensagem : String;
    strEmpresaItem : String;
    strTipoControle : String;
begin
  Result := True;
  strMensagem := '';

  cdsIteEqu.First;
  while not cdsIteEqu.Eof do
  begin
    If (Not untFuncoesSimples.fExisteLote(cdsIteEqu.FieldByName('CODITE').AsString, strCodEmp)) Then
    Begin
      cdsIteEqu.Next;
      Continue;
    End;

    If (FMulLoj) Then
      strEmpresaItem := cdsIteEqu.FieldByName('EMPITE').AsString
    Else
      strEmpresaItem := strCodEmp;

    strNumLot := fRetArmazemPrincipal(strEmpresaItem, cdsIteEqu.FieldByName('CODITE').AsString);

    if fEmptyStr(strNumLot) then
      strMensagem := strMensagem + sLineBreak + cdsIteEqu.FieldByName('CODITE').AsString + ' - ' + cdsIteEqu.FieldByName('DESITE').AsString
    else
    begin
      cdsIteEqu.Edit;
      cdsIteEqu.FieldByName('NUMLOT').AsString := strNumLot;
      cdsIteEqu.FieldByName('LOTORI').AsString := strNumLot;
      cdsIteEqu.Post;
    end;

    cdsIteEqu.Next;
  end;

  if not fEmptyStr(strMensagem) then
  begin
    If fCfgSis('CTLEST') = '1' Then
      strTipoControle := 'Lote'
    Else
      strTipoControle := 'Armazém';

    fMensagem('ATENÇÃO!', 'O(s) produto(s) abaixo não possuem ' + strTipoControle + ' principal para conserto de equipamentos: ' + sLineBreak + strMensagem, ['&Ok']);
    Result := False;
  end;
end;

procedure TConEqu.pMarcaNumeroPedidoVenda(strNumDoc: String; blnLimParDadosPed: Boolean);
  Var
    qryGen: TUniQuery;
    strSQL: String;
begin
  If fEmptyStr(FEmpPed) Then
    FEmpPed := VS_strCodEmp;

  {************************************************************}
  {* ATUALIZA A ORDEM DE SERVICO COM AS INFORMACOES DO PEDIDO *}
  {*********************************************************LU*}
  strSQL := '';
  strSQL := strSQL + ' UPDATE ';
  strSQL := strSQL + '   EQUGER ';
  strSQL := strSQL + ' SET ';
  strSQL := strSQL + '   EQU_JAPEDI = :JAPEDI, ';
  strSQL := strSQL + '   EQU_TIPPED = :TIPPED, ';
  strSQL := strSQL + '   EQU_EMPPED = :EMPPED, ';
  strSQL := strSQL + '   EQU_NUMPED = :NUMPED, ';
  strSQL := strSQL + '   EQU_DTAPED = :DTAPED, ';
  strSQL := strSQL + '   EQU_VENPED = :VENPED, ';
  strSQL := strSQL + '   EQU_VALPED = :VALPED, ';
  strSQL := strSQL + '   EQU_EMPAPR = :EMPAPR  ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   EQU_NUMOSE = :NUMOSE AND ';
  strSQL := strSQL + '   EQU_CODEMP = :CODEMP ';

  qryGen := fCriaQuery;

  With qryGen Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);

    If (Not blnLimParDadosPed) Then Begin
      ParamByName('JAPEDI').AsInteger := 1;
      ParamByName('TIPPED').AsString  := 'PD';
      ParamByName('EMPPED').AsString  := FEmpPed;
      ParamByName('NUMPED').AsString  := strNumDoc;
      ParamByName('DTAPED').AsDateTime:= VS_Date;

      If fEmptyStr(FCodVen) Then
        ParamByName('VENPED').Value     := Null
      Else
        ParamByName('VENPED').AsString  := FCodVen;

      ParamByName('VALPED').AsFloat   := FVlrCon;
      ParamByName('EMPAPR').AsString  := FEmpApr;
      ParamByName('NUMOSE').AsString  := FNumero;
      ParamByName('CODEMP').AsString  := FCodEmp;
    End Else Begin
      ParamByName('JAPEDI').AsInteger := 0;
      ParamByName('TIPPED').Value  := Null;
      ParamByName('EMPPED').Value  := Null;
      ParamByName('NUMPED').Value  := Null;
      ParamByName('DTAPED').Value  := Null;
      ParamByName('VENPED').Value  := Null;
      ParamByName('VALPED').AsFloat  := 0;
      ParamByName('EMPAPR').Value  := Null;
      ParamByName('NUMOSE').AsString := FNumero;
      ParamByName('CODEMP').AsString := FCodEmp;
    End;

    ExecSQL;
  End;

  FreeAndNil(qryGen);
end;

procedure TConEqu.pCarregarCliente(qryCliente: TUniQuery; strCliente: String; blnAtualizaDados: Boolean);
  Var
    blnAssigned: Boolean;
    strSQL: String;
begin
  blnAssigned := Assigned(qryCliente);

  If Not blnAssigned Then
    qryCliente := fCriaQuery;

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   CLI_NOMCLI AS NOMCLI, ';
  strSQL := strSQL + '   CLI_ENDERE AS ENDERE, ';
  strSQL := strSQL + '   CLI_BAIRRO AS BAIRRO, ';
  strSQL := strSQL + '   CLI_C_E_P_ AS C_E_P_, ';
  strSQL := strSQL + '   CLI_FONE01 AS FONE01, ';
  strSQL := strSQL + '   CLI_CGCCPF AS CGCCPF, ';
  strSQL := strSQL + '   CLI_C_G_C_ AS C_G_C_, ';
  strSQL := strSQL + '   CLI_I_E_S_ AS I_E_S_, ';
  strSQL := strSQL + '   CLI_NUMR_G AS NUMR_G, ';
  strSQL := strSQL + '   CLI_CODCID AS CODCID, ';
  strSQL := strSQL + '   CID_ESTADO AS ESTADO, ';
  strSQL := strSQL + '   CLI_EMAIL3 AS EMLCLI  ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   CADCLI ';
  strSQL := strSQL + '   JOIN CADCID ON (CLI_CODCID=CID_CODCID) ';
  strSQL := strSQL + ' WHERE ';
  strSQL := strSQL + '   CLI_CODCLI = :CODCLI ';

  With qryCliente Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('CODCLI').AsString := strCliente;
    Open;
  End;

  If blnAtualizaDados Then
  Begin
    FCliNom := qryCliente.FieldByName('NOMCLI').AsString;
    FCliEnd := qryCliente.FieldByName('ENDERE').AsString;
    FCliBai := qryCliente.FieldByName('BAIRRO').AsString;
    FCliCep := qryCliente.FieldByName('C_E_P_').AsString;
    FCodCid := qryCliente.FieldByName('CODCID').AsString;
    FCliEst := qryCliente.FieldByName('ESTADO').AsString;
    FCliTel := qryCliente.FieldByName('FONE01').AsString;
    FCgcCpf := qryCliente.FieldByName('CGCCPF').AsInteger;
    FCliCgc := qryCliente.FieldByName('C_G_C_').AsString;
    FCliIes := qryCliente.FieldByName('I_E_S_').AsString;
    FCli_Rg := qryCliente.FieldByName('NUMR_G').AsString;
    FCliEma := qryCliente.FieldByName('EMLCLI').AsString;
  End;

  If Not blnAssigned Then
    FreeAndNil(qryCliente);
end;

procedure TConEqu.pCarregaDefeitos;
var
  strSQL,
  strPre: String;
Begin
  strPre := '';

  if FOSCanc then
    strPre := 'DEL_';

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   * ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   ' + strPre + 'EQUDFE ';
  strSQL := strSQL + ' WHERE EQU_NUMOSE = :NUMOSE ';
  strSQL := strSQL + '   AND EQU_CODEMP = :CODEMP ';

  With qryEquDfe Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMOSE').AsString := FNumero;
    ParamByName('CODEMP').AsString := FCodEmp;
    Open;
  End;
end;

procedure TConEqu.pCarregaEmpIte(var cdsEmpIte: TUniClientDataSet);
var
  cdsDados: TUniClientDataSet;
begin
  cdsDados := TUniClientDataSet.Create(Self);

  try
    cdsEmpIte.FieldDefs.Add('ORDENA', ftInteger);
    cdsEmpIte.FieldDefs.Add('EMPITE', ftString,  3);
    cdsEmpIte.CreateDataSet;

    cdsEmpIte.IndexFieldNames := 'ORDENA';

    pCloneDataSet(cdsDados, cdsIteEqu);
    cdsDados.First;

    while not cdsDados.Eof do
    begin
      if not cdsEmpIte.Locate('EMPITE', cdsDados.FieldByName('EMPITE').AsString, []) then
      begin
        cdsEmpIte.Append;
        cdsEmpIte.FieldByName('ORDENA').AsInteger := IIF((cdsDados.FieldByName('EMPITE').AsString = VS_strCodEmp), 0, 1);
        cdsEmpIte.FieldByName('EMPITE').AsString := cdsDados.FieldByName('EMPITE').AsString;
        cdsEmpIte.Post;
      end;

      cdsDados.Next;
    end;

    if (not fEmptyStr(FEmpSer)) and (not cdsSerEqu.IsEmpty) and (not cdsEmpIte.Locate('EMPITE', FEmpSer, [])) then
    begin
      cdsEmpIte.Append;
      cdsEmpIte.FieldByName('EMPITE').AsString := FEmpSer;
      cdsEmpIte.Post;
    end;
  finally
    FreeAndNil(cdsDados);
  end;
end;

procedure TConEqu.pCarregaGridApo;
var
  wano, wmes, wdia, whora, wminuto, wsegundo, wmilisegundo: Word;
  dtaIni, dtaFin: TDateTime;
  intDiff, intHoras, intMinutos: integer;
begin
  qryEquApo.First;
  cdsApoEqu.DisableControls;
  cdsApoEqu.EmptyDataSet;

  While Not qryEquApo.Eof Do
  Begin
    cdsApoEqu.Append;
    cdsApoEqu.FieldByName('NOMTEC').AsString := qryEquApo.FieldByName('NOMTEC').AsString;
    cdsApoEqu.FieldByName('FASEAP').AsString := qryEquApo.FieldByName('FASEAP').AsString;
    cdsApoEqu.FieldByName('DTAINI').AsString := FormatDateTime('dd/mm/yyyy hh:mm', qryEquApo.FieldByName('DTAINI').AsDateTime);

    if (not qryEquApo.FieldByName('DTAFIN').IsNull) then
    begin
      DecodeDateTime(qryEquApo.FieldByName('DTAINI').AsDateTime, wano, wmes, wdia, whora, wminuto, wsegundo, wmilisegundo);
      dtaIni := EncodeDateTime(wano, wmes, wdia, whora, wminuto, 0, 0);

      DecodeDateTime(qryEquApo.FieldByName('DTAFIN').AsDateTime, wano, wmes, wdia, whora, wminuto, wsegundo, wmilisegundo);
      dtaFin := EncodeDateTime(wano, wmes, wdia, whora, wminuto, 0, 0);

      cdsApoEqu.FieldByName('DTAFIN').AsString := FormatDateTime('dd/mm/yyyy hh:mm', dtaFin);

      intDiff := (SecondsBetween(dtaIni, dtaFin));
      intHoras := intDiff div 3600;
      intMinutos := intDiff div 60 - intHoras * 60;

      cdsApoEqu.FieldByName('TMPDUR').AsString := Format('%0.2d:%0.2d', [intHoras, intMinutos]);
    end;

    cdsApoEqu.Post;

    qryEquApo.Next;
  End;

  cdsApoEqu.EnableControls;
end;

procedure TConEqu.pCarregaAcessorios;
var
  strSQL,
  strPre: String;
Begin
  strPre := '';

  if FOSCanc then
    strPre := 'DEL_';

  strSQL := '';
  strSQL := strSQL + ' SELECT ';
  strSQL := strSQL + '   * ';
  strSQL := strSQL + ' FROM ';
  strSQL := strSQL + '   ' + strPre + 'EQUACE ';
  strSQL := strSQL + ' WHERE EQU_NUMOSE = :NUMOSE ';
  strSQL := strSQL + '   AND EQU_CODEMP = :CODEMP ';

  With qryEquAce Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMOSE').AsString := FNumero;
    ParamByName('CODEMP').AsString := FCodEmp;
    Open;
  End;
end;

procedure TConEqu.pCarregaApontamentos;
var
  strSQL,
  strPre: String;
Begin
  strPre := '';

  if FOSCanc then
    strPre := 'DEL_';

  strSQL := '';
  strSQL := strSQL + ' SELECT CADOPE.OPE_NOMOPE NOMTEC, CADAPO.APO_DESCRI FASEAP, ' + strPre + 'EQUAPO.EQU_DTAAPO DTAINI, ';
  strSQL := strSQL + '     (SELECT MIN(E.EQU_DTAAPO) ';
  strSQL := strSQL + '      FROM ' + strPre + 'EQUAPO E ';
  strSQL := strSQL + '      WHERE ' + strPre + 'EQUAPO.EQU_SEQGER = E.EQU_SEQGER ';
  strSQL := strSQL + '          AND ' + strPre + 'EQUAPO.EQU_CODAPO = E.EQU_CODAPO ';
  strSQL := strSQL + '          AND E.EQU_TIPOPE = "T" AND E.EQU_DTAAPO > ' + strPre + 'EQUAPO.EQU_DTAAPO) DTAFIN ';
  strSQL := strSQL + ' FROM ' + strPre + 'EQUAPO ';
  strSQL := strSQL + ' INNER JOIN ' + strPre + 'EQUGER ON ' + strPre + 'EQUAPO.EQU_SEQGER = ' + strPre + 'EQUGER.AUTOINCREM ';
  strSQL := strSQL + ' INNER JOIN CADAPO ON ' + strPre + 'EQUAPO.EQU_CODAPO = CADAPO.APO_CODAPO ';
  strSQL := strSQL + ' INNER JOIN CADOPE ON ' + strPre + 'EQUAPO.EQU_CODTEC = CADOPE.OPE_CODOPE ';
  strSQL := strSQL + ' WHERE ' + strPre + 'EQUAPO.EQU_TIPOPE = "I" ';
  strSQL := strSQL + '     AND ' + strPre + 'EQUGER.EQU_NUMOSE = :NUMOSE ';
  strSQL := strSQL + '     AND ' + strPre + 'EQUGER.EQU_CODEMP = :CODEMP ';
  strSQL := strSQL + ' ORDER BY ' + strPre + 'EQUAPO.EQU_DTAAPO ';

  qryEquApo.Close;
  qryEquApo.SQL.Clear;
  qryEquApo.SQL.Add(strSQL);
  qryEquApo.ParamByName('NUMOSE').AsString := FNumero;
  qryEquApo.ParamByName('CODEMP').AsString := FCodEmp;
  qryEquApo.Open;
end;

procedure TConEqu.pCarregaCustoPreMed(strEstado: String);
Var
  strSQL : String;
  strTipAbf: String;
  qryProduto: TUniQuery;
  fltQuant: Double;
  fltCusto: Double;
  fltMedio: Double;
Begin

  Try
    qryProduto := fCriaQuery;

    strTipAbf := fGetTipoAbfCliente(strCodCli);

    strSQL := '';
    strSQL := strSQL + ' SELECT ';
    strSQL := strSQL + '   I.ITE_PRECUS AS PRECUS, ';
    strSQL := strSQL + '   I.ITE_PREMED AS PREMED, ';
    strSQL := strSQL + '   C.ITE_CODGRU AS CODGRU, ';
    strSQL := strSQL + '   C.ITE_CODFOR AS CODFOR, ';
    strSQL := strSQL + '   C.ITE_CODMAR AS CODMAR, ';
    strSQL := strSQL + '   A.ABF_CODSIT' + strTipAbf + ' AS CODFIS ';
    strSQL := strSQL + ' FROM ';
    strSQL := strSQL + '   CADITE C ';
    strSQL := strSQL + '   JOIN ITEGER I ON (C.ITE_CODITE=I.ITE_CODITE) ';
    If fCfgSIs('TIPABF') = '1' Then
      strSQL := strSQL + '   JOIN ABFICM A ON (C.ITE_CODABF=A.ABF_CODABF) '
    Else
      strSQL := strSQL + '   JOIN ABFICM A ON (I.ITE_CODABF=A.ABF_CODABF) ';

    strSQL := strSQL + ' WHERE ';
    strSQL := strSQL + '   I.ITE_CODITE = :CODITE AND ';
    strSQL := strSQL + '   I.ITE_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '   A.ABF_ESTADO = :ESTADO ';

    FVlrCus := 0;
    FVlrMed := 0;

    cdsIteEqu.DisableControls;
    cdsIteEqu.First;

    While Not cdsIteEqu.Eof Do
    Begin

      With qryProduto Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODITE').AsString := cdsIteEqu.fieldbyname('CODITE').AsString;
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('ESTADO').AsString := strEstado;
        Open;
      End;

      fltQuant := cdsIteEqu.fieldbyname('QTDITE').AsFloat;
      fltCusto := qryProduto.fieldbyname('PRECUS').AsFloat * fltQuant;
      fltMedio := qryProduto.fieldbyname('PREMED').AsFloat * fltQuant;

      FVlrCus := FVlrCus + fltCusto;
      FVlrMed := FVlrMed + fltMedio;

      cdsIteEqu.Edit;

      If Not fIsItemEspecial(cdsIteEqu.fieldbyname('CODITE').AsString) Then
        cdsIteEqu.FieldByName('TOTCUS').AsFloat  := fltCusto;

      cdsIteEqu.FieldByName('PREMED').AsFloat  := fltMedio;
      cdsIteEqu.FieldByName('CODGRU').AsString := qryProduto.fieldbyname('CODGRU').AsString;
      cdsIteEqu.FieldByName('CODMAR').AsString := qryProduto.fieldbyname('CODMAR').AsString;
      cdsIteEqu.FieldByName('CODFOR').AsString := qryProduto.fieldbyname('CODFOR').AsString;
      cdsIteEqu.FieldByName('CODFIS').AsString := qryProduto.fieldbyname('CODFIS').AsString;
      cdsIteEqu.Post;

      cdsIteEqu.Next;
    End;
    cdsIteEqu.EnableControls;

  Finally
    FreeAndNil(qryProduto);
  End;

End;

function TConEqu.fCancelaOrdServico(strNomeForm: String): Boolean;
Var
  strSQL: String;
  qryGen,
  qryFGOEQU: TUniQuery;
  objAtuCrm: TAtuOcoCrm;
  blnDelPedido: Boolean;
  blnTransacaoLocal: Boolean;
Begin
  Result := False;

  blnDelPedido := True;
  blnTransacaoLocal := False;

  if (not fEmptyStr(fVerificaExisteNegociacao(False))) then
  begin
    fMensagem('ATENÇÃO', 'A ordem de serviço ' + FNumero + ' possui negociação vinculada. ' +
              'Favor entrar em contato com a citel.' , ['&Ok']);
    Exit;
  end;

  if fEhOSOriginadaDePedido then
  begin
    if (fMensagem('', 'A O.S ' + FNumero + ' foi originada a partir do documento ' + FNumPed + '-PD-' + FEmpPed + '.' + #13 +
      'Deseja baixar o pedido agora?', ['&Sim', '&Não']) = 2) then
      blnDelPedido := False;
  end;

  objAtuCrm := TAtuOcoCrm.Create(Nil);

  if fEmptyStr(FEmpPed) then
    FEmpPed := VS_strCodEmp;

  Try
    qryGen    := fCriaQuery;
    qryFGOEQU := fCriaQuery;

    Try
      if (not fInTransaction) then
      begin
        fStartTransaction;
        blnTransacaoLocal := True;
      end;

      If (Not fEmptyStr(FNumPed)) and blnDelPedido Then
      Begin
        qryFGOEQU.Close;
        qryFGOEQU.SQL.Text := SELECT_PD_EQUGOR;
        qryFGOEQU.ParamByName('SEQEQU').AsString := FAutInc;
        qryFGOEQU.Open;

        if (not qryFGOEQU.IsEmpty) then
        begin
          while not qryFGOEQU.Eof do
          begin
            if fCfgSis('UTICRM', varBoolean) then
            begin
              objAtuCrm.pCarregaOcorrenciaCliente(qryFGOEQU.FieldByName('CODEMP').AsString, 'PD',
                qryFGOEQU.FieldByName('NUMDOC').AsString, qryFGOEQU.FieldByName('CODCLI').AsString);
              objAtuCrm.pFinalizaOcorrencia('Baixa realizada pela rotina de Conserto de Equipamentos.');
            end;

            fDeletarFATDOR(qryFGOEQU.FieldByName('NUMDOC').AsString, qryFGOEQU.FieldByName('CODEMP').AsString,
              '', 0, True, strNomeForm, True);

            qryFGOEQU.Next;
          end;
        end
        else
        begin
          if fCfgSis('UTICRM', varBoolean) and (not fEmptyStr(FNumPed)) then
          begin
            objAtuCrm.pCarregaOcorrenciaCliente(FEmpPed, 'PD', FNumPed, IIF((FGarant <> 'N') and (not fEmptyStr(FCliGar)), FCliGar, FCodCli));
            objAtuCrm.pFinalizaOcorrencia('Baixa realizada pela rotina de Conserto de Equipamentos.');
          end;

          fDeletarFATDOR(FNumPed, FEmpPed, '', 0, True, strNomeForm, True);
        end;
      End;

      cdsSerEqu.First();

      While (Not cdsSerEqu.Eof) Do
      Begin
        strSQL := 'SELECT * FROM EQUSER WHERE AUTOINCREM = :AUTINC';

        With qryGen Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('AUTINC').AsString := cdsSerEqu.FieldByName('AUTINC').AsString;
          Open;
          fVerificaIntegridade(strNomeForm, 'EQUSER', qryGen, True);
          Close;
        End;

        cdsSerEqu.Next();
      End;

      strSQL := '';
      strSQL := strSQL + ' DELETE FROM ';
      strSQL := strSQL + '   EQUSER ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   EQU_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '   EQU_NUMOSE = :NUMOSE ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('NUMOSE').AsString := FNumero;
        ExecSQL;
      End;

      cdsDfeEqu.First();

      While (Not cdsDfeEqu.Eof) Do Begin
        strSQL := 'SELECT * FROM EQUDFE WHERE AUTOINCREM = :AUTINC';

        With qryGen Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('AUTINC').AsString := cdsDfeEqu.FieldByName('AUTINC').AsString;
          Open;
          fVerificaIntegridade(strNomeForm, 'EQUDFE', qryGen, True);
          Close;
        End;

        cdsDfeEqu.Next();
      End;

      strSQL := '';
      strSQL := strSQL + ' DELETE FROM ';
      strSQL := strSQL + '   EQUDFE ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   EQU_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '   EQU_NUMOSE = :NUMOSE ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('NUMOSE').AsString := FNumero;
        ExecSQL;
      End;

      cdsIteEqu.First();

      While (Not cdsIteEqu.Eof) Do Begin
        strSQL := 'SELECT * FROM EQUDET WHERE AUTOINCREM = :AUTINC';

        With qryGen Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('AUTINC').AsString := cdsIteEqu.FieldByName('AUTINC').AsString;
          Open;
          fVerificaIntegridade(strNomeForm, 'EQUDET', qryGen, True);
          Close;
        End;

        cdsIteEqu.Next();
      End;

      strSQL := '';
      strSQL := strSQL + ' DELETE FROM ';
      strSQL := strSQL + '   EQUDET ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   EQU_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '   EQU_NUMOSE = :NUMOSE ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('NUMOSE').AsString := FNumero;
        ExecSQL;
      End;

      cdsAceEqu.First();

      While (Not cdsAceEqu.Eof) Do
      Begin
        strSQL := 'SELECT * FROM EQUACE WHERE AUTOINCREM = :AUTINC';

        With qryGen Do
        Begin
          Close;
          SQL.Clear;
          SQL.Add(strSQL);
          ParamByName('AUTINC').AsString := cdsAceEqu.FieldByName('AUTINC').AsString;
          Open;
          fVerificaIntegridade(strNomeForm, 'EQUACE', qryGen, True);
          Close;
        End;

        cdsAceEqu.Next();
      End;

      strSQL := '';
      strSQL := strSQL + ' DELETE FROM ';
      strSQL := strSQL + '   EQUACE ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   EQU_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '   EQU_NUMOSE = :NUMOSE ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('NUMOSE').AsString := FNumero;
        ExecSQL;
      End;

      strSQL := '';
      strSQL := strSQL + ' SELECT * FROM ';
      strSQL := strSQL + '   EQUCOM ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   EQC_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '   EQC_NUMOSE = :NUMOSE ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('NUMOSE').AsString := FNumero;
        Open;
        First;
        while not Eof do
        begin
          fVerificaIntegridade(strNomeForm, 'EQUCOM', qryGen, True);
          Next;
        end;
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + ' DELETE FROM ';
      strSQL := strSQL + '   EQUCOM ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   EQC_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '   EQC_NUMOSE = :NUMOSE ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('NUMOSE').AsString := FNumero;
        ExecSQL;
      End;

      strSQL := '';
      strSQL := strSQL + ' SELECT * FROM ';
      strSQL := strSQL + '   EQUGER ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   EQU_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '   EQU_NUMOSE = :NUMOSE ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('NUMOSE').AsString := FNumero;
        Open;
        fVerificaIntegridade(strNomeForm, 'EQUGER', qryGen, True);
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + ' DELETE FROM ';
      strSQL := strSQL + '   EQUGER ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   EQU_CODEMP = :CODEMP AND ';
      strSQL := strSQL + '   EQU_NUMOSE = :NUMOSE ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('NUMOSE').AsString := FNumero;
        ExecSQL;
      End;

      strSQL := '';
      strSQL := strSQL + ' SELECT * FROM ';
      strSQL := strSQL + '   MEQMER ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   MER_EMPEQU = :CODEMP AND ';
      strSQL := strSQL + '   MER_NUMOSE = :NUMOSE AND ';
      strSQL := strSQL + '   MER_TIPOPE = "S" ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('NUMOSE').AsString := FNumero;
        Open;
        fVerificaIntegridade(strNomeForm, 'MEQMER', qryGen, True);
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + ' SELECT * FROM ';
      strSQL := strSQL + '   MEQMER ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   MER_EMPEQU = :CODEMP AND ';
      strSQL := strSQL + '   MER_NUMOSE = :NUMOSE AND ';
      strSQL := strSQL + '   MER_TIPOPE = "E" ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('NUMOSE').AsString := FNumero;
        Open;
        fVerificaIntegridade(strNomeForm, 'MEQMER', qryGen, True);
        Close;
      End;

      strSQL := '';
      strSQL := strSQL + ' DELETE FROM ';
      strSQL := strSQL + '   MEQMER ';
      strSQL := strSQL + ' WHERE ';
      strSQL := strSQL + '   MER_EMPEQU = :CODEMP AND ';
      strSQL := strSQL + '   MER_NUMOSE = :NUMOSE ';

      With qryGen Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('CODEMP').AsString := FCodEmp;
        ParamByName('NUMOSE').AsString := FNumero;
        ExecSQL;
      End;

      if blnTransacaoLocal then
        fCommit;

      Result := True;
    Except
      On E: Exception Do Begin
        if blnTransacaoLocal then
          fRollback;

        pMensagensErro(E.Message, '[TConEqu.fCancelaOrdServico]');
      End;
    End;
  Finally
    FreeAndNil(qryGen);
    FreeAndNil(qryFGOEQU);
    FreeAndNil(objAtuCrm);
  End;
End;

procedure TConEqu.pGravarDesmembramento(strSeqFgo, strSeqEqu, strGarant, strItePed: String; blnMulLoj: Boolean);
var
  strSQL   : String;
  qryGravar: TUniQuery;
begin
  qryGravar := fCriaQuery;

  try
    strSQL := '';
    strSQL := strSQL  + ' INSERT INTO EQUGOR ( ';
    strSQL := strSQL  + '     FGO_SEQFGO, ';
    strSQL := strSQL  + '     FGO_SEQEQU, ';
    strSQL := strSQL  + '     FGO_GARANT, ';
    strSQL := strSQL  + '     FGO_ITEPED, ';
    strSQL := strSQL  + '     FGO_MULLOJ, ';
    strSQL := strSQL  + '     FGO_TIPAPR) ';
    strSQL := strSQL  + ' VALUES ( ';
    strSQL := strSQL  + '     :SEQFGO, ';
    strSQL := strSQL  + '     :SEQEQU, ';
    strSQL := strSQL  + '     :GARANT, ';
    strSQL := strSQL  + '     :ITEPED, ';
    strSQL := strSQL  + '     :MULLOJ, ';
    strSQL := strSQL  + '     :TIPAPR) ';

    qryGravar.Close;
    qryGravar.SQL.Text := strSQL;
    qryGravar.ParamByName('SEQFGO').AsString := strSeqFgo;
    qryGravar.ParamByName('SEQEQU').AsString := strSeqEqu;
    qryGravar.ParamByName('GARANT').AsString := strGarant;
    qryGravar.ParamByName('ITEPED').AsString := strItePed;
    qryGravar.ParamByName('MULLOJ').AsString := IIF(blnMulLoj, 'S', 'N');
    qryGravar.ParamByName('TIPAPR').AsString := FTipApr;
    qryGravar.ExecSQL;
  finally
    FreeAndNil(qryGravar);
  end;
end;

procedure TConEqu.pGravarLogFlx(blnFluxo: Boolean);
var
  strSQL: String;
  qryLog: TUniQuery;
begin
  if (FFlxFas = FFlxFasAnt) and (FFlxSit = FFlxSitAnt) and (FFlxCom = FFlxComAnt) then
    Exit;

  qryLog := fCriaQuery;

  try
    strSQL := '';
    strSQL := strSQL + ' INSERT INTO LOGFLX ( ';
    strSQL := strSQL + '     AUTOINCREM, LOG_DTALOG, LOG_HORLOG, LOG_NUMOSE, ';
    strSQL := strSQL + '     LOG_CODEMP, LOG_CODOPE, LOG_CODDIG, LOG_FASANT, ';
    strSQL := strSQL + '     LOG_SITANT, LOG_COMANT, LOG_FASATU, LOG_SITATU, ';
    strSQL := strSQL + '     LOG_COMATU, LOG_EMPLOG, LOG_FLXLOG) ';
    strSQL := strSQL + ' VALUES ( ';
    strSQL := strSQL + '     :AUTOINCREM, :LOG_DTALOG, :LOG_HORLOG, :LOG_NUMOSE, ';
    strSQL := strSQL + '     :LOG_CODEMP, :LOG_CODOPE, :LOG_CODDIG, :LOG_FASANT, ';
    strSQL := strSQL + '     :LOG_SITANT, :LOG_COMANT, :LOG_FASATU, :LOG_SITATU, ';
    strSQL := strSQL + '     :LOG_COMATU, :LOG_EMPLOG, :LOG_FLXLOG) ';

    qryLog.SQL.Text := strSQL;
    qryLog.ParamByName('AUTOINCREM').AsString   := fRetAutoIncrem('LOGFLX', FCodEmp);
    qryLog.ParamByName('LOG_DTALOG').AsDate     := VS_Date;
    qryLog.ParamByName('LOG_HORLOG').AsDateTime := fTime();
    qryLog.ParamByName('LOG_NUMOSE').AsString   := FNumero;
    qryLog.ParamByName('LOG_CODEMP').AsString   := FCodEmp;
    qryLog.ParamByName('LOG_CODOPE').AsString   := strLoginUsuarioLogado;

    if fEmptyStr(FCodDig) then
      qryLog.ParamByName('LOG_CODDIG').Value    := Null
    else
      qryLog.ParamByName('LOG_CODDIG').AsString := FCodDig;

    qryLog.ParamByName('LOG_FASANT').AsString   := FFlxFasAnt;
    qryLog.ParamByName('LOG_SITANT').AsString   := FFlxSitAnt;
    qryLog.ParamByName('LOG_COMANT').AsString   := FFlxComAnt;
    qryLog.ParamByName('LOG_FASATU').AsString   := FFlxFas;
    qryLog.ParamByName('LOG_SITATU').AsString   := FFlxSit;
    qryLog.ParamByName('LOG_COMATU').AsString   := FFlxCom;
    qryLog.ParamByName('LOG_EMPLOG').AsString   := VS_strCodEmp;
    qryLog.ParamByName('LOG_FLXLOG').AsString   := IIF(blnFluxo, 'S', 'N');
    qryLog.ExecSQL;
  finally
    FreeAndNil(qryLog);
  end;
end;

procedure TConEqu.pGravarLogSta(strCodOpe, strStaAnt, strStaAtu, strNumOse, strCodDig: String);
  Var
    strSQL: String;
    qryGen: TUniQuery;
Begin
  If (strStaAnt <> strStaAtu) Or (strStaAtu = 'E') Then
  Begin
    qryGen := fCriaQuery;

    strSQL := '';
    strSQL := strSQL + 'INSERT INTO     ';
    strSQL := strSQL + '  LOGSTA(       ';
    strSQL := strSQL + '    AUTOINCREM, ';
    strSQL := strSQL + '    LOG_DTALOG, ';
    strSQL := strSQL + '    LOG_HORLOG, ';
    strSQL := strSQL + '    LOG_CODEMP, ';
    strSQL := strSQL + '    LOG_CODOPE, ';
    strSQL := strSQL + '    LOG_STAANT, ';
    strSQL := strSQL + '    LOG_STAATU, ';
    strSQL := strSQL + '    LOG_NUMOSE, ';
    strSQL := strSQL + '    LOG_CODDIG) ';
    strSQL := strSQL + '  VALUES (      ';
    strSQL := strSQL + '    :AUTINC,    ';
    strSQL := strSQL + '    :DTALOG,    ';
    strSQL := strSQL + '    :HORLOG,    ';
    strSQL := strSQL + '    :CODEMP,    ';
    strSQL := strSQL + '    :CODOPE,    ';
    strSQL := strSQL + '    :STAANT,    ';
    strSQL := strSQL + '    :STAATU,    ';
    strSQL := strSQL + '    :NUMOSE,    ';
    strSQL := strSQL + '    :CODDIG)    ';

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);

      ParamByName('AUTINC').AsString   := fRetAutoIncrem('EQUDET', FCodEmp);
      ParamByName('DTALOG').AsDate     := VS_date;
      ParamByName('HORLOG').AsDateTime := fTime();
      ParamByName('CODEMP').AsString   := FCodEmp;
      ParamByName('CODOPE').AsString   := strCodOpe;
      ParamByName('STAANT').AsString   := strStaAnt;
      ParamByName('STAATU').AsString   := strStaAtu;
      ParamByName('NUMOSE').AsString   := strNumOse;

      If fEmptyStr(strCodDig) Then
        ParamByName('CODDIG').Value    := Null
      Else
        ParamByName('CODDIG').AsString := strCodDig;

      ExecSQL;
    End;

    FreeAndNil(qryGen);
  End;
end;

procedure TConEqu.pGravarOrdemMaoObraCli(strSeqFGO: String);
var
  strSQL: String;
  qryAux: TUniQuery;
  cdsDados: TUniClientDataSet;
begin
  qryAux   := fCriaQuery;
  cdsDados := TUniClientDataSet.Create(Self);

  try
    pCloneDataSet(cdsDados, cdsSerEqu);

    strSQL := '';
    strSQL := strSQL + ' INSERT INTO OMOCLI ';
    strSQL := strSQL + '     (AUTOINCREM, OMO_SEQFGO, OMO_CODSER, OMO_MAOCLI) ';
    strSQL := strSQL + ' VALUES ';
    strSQL := strSQL + '     (:AUTINC, :SEQFGO, :CODSER, :MAOCLI)';

    qryAux.SQL.Text := strSQL;
    cdsDados.First;

    while not cdsDados.Eof do
    begin
      if (not fEmptyStr(cdsDados.FieldByName('MAOCLI').AsString)) then
      begin
        qryAux.Close;
        qryAux.ParamByName('AUTINC').AsString := fRetAutoIncrem('OMOCLI', FCodEmp);
        qryAux.ParamByName('SEQFGO').AsString := strSeqFGO;
        qryAux.ParamByName('CODSER').AsString := cdsDados.FieldByName('CODSER').AsString;
        qryAux.ParamByName('MAOCLI').AsString := cdsDados.FieldByName('MAOCLI').AsString;
        qryAux.ExecSQL;
      end;

      cdsDados.Next;
    end;
  finally
    FreeAndNil(qryAux);
    FreeAndNil(cdsDados);
  end;
end;

function TConEqu.getDtaEnt: String;
begin
  Result := FormatDateTime('dd/mm/yyyy', FDtaEnt);
end;

function TConEqu.getPrevis: String;
begin
  Result := FormatDateTime('dd/mm/yyyy', FPrevis);
end;

function TConEqu.getHorEnt: String;
begin
  Result := FormatDateTime('hh:mm:ss', FHorEnt);
end;

procedure TConEqu.setDtaEnt(const Value: String);
begin
  FDtaEnt := StrToDate(Value);
end;

procedure TConEqu.setPrevis(const Value: String);
begin
  FPrevis := StrToDate(Value);
end;

procedure TConEqu.setHorEnt(const Value: String);
begin
  FHorEnt := StrToTime(Value);
end;

function TConEqu.fTemItensEntrega: Boolean;
Var
  cdsDados: TUniClientDataSet;
Begin
  cdsDados := TUniClientDataSet.Create(Self);
  pCloneDataSet(cdsDados, cdsIteEqu);

  cdsDados.Filter := cdsIteEqu.Filter;

  If Not fEmptyStr(cdsDados.Filter) Then
    cdsDados.Filter := cdsDados.Filter + ' AND ';

  cdsDados.Filter := cdsDados.Filter + ' ENTRET = ' + QuotedStr('E');

  cdsDados.Filtered := True;

  Result := Not cdsDados.IsEmpty;
  FreeAndNil(cdsDados);
end;

function TConEqu.fTemStatusFluxoPreenchido: Boolean;
begin
  Result := False;

  if fEmptyStr(FFlxFas) then
    Exit;

  if fEmptyStr(FFlxSit) then
    Exit;

  if fEmptyStr(FFlxCom) then
    Exit;

  Result := True;
end;

function TConEqu.fTitStatus: String;
Begin
  fTitStatusExt(strStatus, strSubSta);
End;

function fTitStatusExt(strStatus, strSubSta : String): String;
begin

  Result := '';

  If strStatus = 'E' Then
  Begin
    Result := 'EM ABERTO';

    If strSubSta = 'O' Then
      Result := Result + ' / ORCAMENTO'
    Else If strSubSta = 'P' Then
      Result := Result + ' / AGUARDANDO PEÇAS'
    Else If strSubSta = 'C' Then
      Result := Result + ' / AGUARDANDO CLIENTE';

  End

  Else If strStatus = 'F' Then
    Result := 'ORCAMENTO REALIZADO'

  Else If (Not fEmptyStr(strStatus)) And CharInSet(strStatus[1], ['A','R']) Then
  Begin
    Result := IIF(strStatus = 'A', 'APROVAÇÃO', 'REALIZADA');

    If strSubSta = 'C' Then
      Result := Result + ' / APROVADA CLIENTE'
    Else If strSubSta = 'G' Then
      Result := Result + ' / APROVADA GARANTIA'
    Else If strSubSta = 'B' Then
      Result := Result + ' / APROVADA CORTESIA';

  End

  Else If strStatus = 'N' Then
  Begin
    Result := 'REPROVADA';

    If strSubSta = 'C' Then
      Result := Result + ' / DEVOLVIDA AO CLIENTE'
    Else If strSubSta = 'A' Then
      Result := Result + ' / ARMAZENADA';

  End

  Else If strStatus = 'M' Then
  Begin
    Result := 'EM MANUTENÇÃO';

    If strSubSta = 'C' Then
      Result := Result + ' / MANUTENÇÃO COMPLETA'
    Else If strSubSta = 'A' Then
      Result := Result + ' / AGUARDANDO ITENS';

  End;

end;

function TConEqu.getPedFin: String;
begin
  Result := IfThen(FPedFin = 0, '', FormatDateTime('dd/mm/yyyy', FPedFin));
end;

function TConEqu.getPedIni: String;
begin
  Result := IfThen(FPedIni = 0, '', FormatDateTime('dd/mm/yyyy', FPedIni));
end;

procedure TConEqu.setPedFin(const Value: String);
begin
  FPedFin := StrToDateDef(Value, 0);
end;

procedure TConEqu.setPedIni(const Value: String);
begin
  FPedIni := StrToDateDef(Value, 0);
end;

function TConEqu.fPedidoJaFaturado: Boolean;
  Var
    qryTemp: TUniQuery;
    blnJafatu, blnJaBaix, blnTemp: Boolean;
    LCodVen: String;
begin
  Result := False;

  Try
    qryTemp := fCriaQuery(nil);

    If (Not fEmptyStr(FNumPed)) Then Begin
      fDocumentoFatExiste(qryTemp,
                          FNumPed,
                          'PD',
                          FEmpPed,
                          blnJafatu,
                          blnJaBaix,
                          blnTemp,
                          LCodVen,
                          blnTemp);

      Result := blnJafatu;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

function TConEqu.fPermiteDesvincularNFSaida(objMeqMer: TMeqMer): Boolean;
begin
  Result := False;

  Try
    If (objMeqMer.strTipOpe <> 'S') Or (fEmptyStr(objMeqMer.strAutGer)) Then
      Exit;

    Result := (
                fEmptyStr(
                           fCampoTabela('AUTOINCREM',
                                        'MOVGER',
                                        ['AUTOINCREM'],
                                        [objMeqMer.strAutGer])
                         )
              );
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '[TConEqu.fPermiteDesvincularNFSaida]');
  End;
end;

function TConEqu.fPodeAlterarClienteOrdemServico: Boolean;
begin
  Result := True;

  If (Not fCfgSis('OSTRCL', varBoolean)) Then
    Exit;

  If (fCfgSis('EQUFVU') = 'V') Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('A T E N C A O - Alteração de cliente de O.S.');
    objLiberacao.objMsgLibera.pAddTexto('                Somente mediante uma confirmação de senha...');

    objLiberacao.strDirAce := 'ALCLOS';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strMsgSen := 'Alteração de cliente de O.S. em Manutenção de Equipamentos';
    objLiberacao.strCliente := FCodCli;
    objLiberacao.strSenFvu := fCfgSis('EQUFVU');

    If Not objLiberacao.fLibera Then
    Begin
      Result := False;
    End;
  End
  Else If Not fVerificaAcessoSistemaOS('ALCLOS', 'Liberado direito de acesso à Alteração de cliente de O.S.!', '') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso à Alteração de cliente de O.S.!', ['&O k']);
    Result := False;
  End;
end;

function TConEqu.fPodeCancelarOrdemServicoRealizada: Boolean;
begin
  Result := True;

  If (fCfgSis('EQUFVU') = 'V') Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('A T E N C A O - Cancelamento de O.S. Realizada');
    objLiberacao.objMsgLibera.pAddTexto('                Somente mediante uma confirmação de senha...');

    objLiberacao.strDirAce := 'CANCOS';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strMsgSen := 'Cancelamento de O.S. Realizada em Manutenção de Equipamentos';
    objLiberacao.strCliente := FCodCli;
    objLiberacao.strSenFvu := fCfgSis('EQUFVU');


    If Not objLiberacao.fLibera Then
    Begin
      Result := False;
    End;
  End
  Else If Not fVerificaAcessoSistemaOS('CANCOS', 'Liberado direito de acesso ao Cancelamento de O.S. Realizada!', '') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso ao Cancelamento de O.S. Realizada!', ['&O k']);
    Result := False;
  End;
end;

function TConEqu.fPodeExcluirItensServicosDefeitos: Boolean;
begin
  Result := True;

  If (strStatus = 'E') Then
    Exit;

  If (cdsIteEqu.fieldbyname('QTDEXP').AsFloat > 0) Then Begin
    fMensagem('ALERTA!', 'Este produto não pode ser deletado, pois já foi expedido!', ['&OK']);
    Result := False;
    Exit;
  End;

  If Not fPodeExcluirItemRequsicaoCompra Then
  Begin
    Result := False;
    Exit;
  End;

  If (fCfgSis('EQUFVU') = 'V') Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('A T E N C A O - Exclusão de itens e serviços de O.S. que não esteja em aberto.');
    objLiberacao.objMsgLibera.pAddTexto('                Somente mediante uma confirmação de senha...');

    objLiberacao.strDirAce := 'EXCMEQ';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strMsgSen := 'Exclusão de itens e serviços de O.S. em Manutenção de Equipamentos';
    objLiberacao.strCliente := FCodCli;
    objLiberacao.strSenFvu := fCfgSis('EQUFVU');

    If Not objLiberacao.fLibera Then
    Begin
      Result := False;
    End;
  End
  Else If Not fVerificaAcessoSistemaOS('EXCMEQ', 'Liberado direito de acesso à Exclusão de itens e serviços de O.S. que não esteja em aberto.!', '') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso à Exclusão de itens e serviços de O.S. que não esteja em aberto.!', ['&O k']);
    Result := False;
  End;
end;

function TConEqu.fPodeIncluirItemEspecial: Boolean;
begin
  Result := True;

  If (fPossuiItemEspecial()) Then Begin
    If (Not fPermiteItemEspecial('PD')) Then Begin
      fMensagem('ATENÇÃO!', 'Item especial não permitido para Pedido!', ['&Ok']);
      Result := False;
    End Else If (Not fEmptyStr(fCfgSis('SENIES', varString))) Then Begin
      objLiberacao.Clear;
      objLiberacao.objMsgLibera.pAddTexto('Item especial - necessário digitação de senha para liberação!');

      objLiberacao.strDirAce := 'LBITES';
      objLiberacao.strSenLib := fCfgSis('SENIES');
      objLiberacao.strMsgSen := 'Liberação de Item Especial';
      objLiberacao.strCodOpe := strCodVen;
      objLiberacao.strCodDig := strCodDig;
      objLiberacao.strCliente := strCodCli + '-' + fRetNomCliente(strCodCli);
      objLiberacao.strCpfCnpj := strCliCgc;

      If Not (objLiberacao.fLibera) Then
      Begin
        fMensagem('ATENÇÃO!','Senha para Item Especial incorreta!',['&OK']);
        Result := False;
      End;
    End;
  End;
end;

function TConEqu.fPodeModificarItensServicosDefeitos: Boolean;
begin
  Result := True;

  If (strStatus = 'E') Then
    Exit;

  pDescreverLogAlteracoesOS;

  If (objLiberacao.objMsgRemota.isEmpty) Or (Not FLogModificao) Then
    Exit;

  If (fCfgSis('EQUFVU') = 'V') Then
  Begin
    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('A T E N C A O - Alteração de itens e serviços de O.S. que não esteja em aberto.');
    objLiberacao.objMsgLibera.pAddTexto('                Somente mediante confirmação de senha...');

    objLiberacao.strDirAce := 'ALTMEQ';
    objLiberacao.strCodOpe := strLoginUsuarioLogado;
    objLiberacao.strMsgSen := 'Alteração de itens e serviços de O.S. em Manutenção de Equipamentos';
    objLiberacao.strCliente := FCodCli;
    objLiberacao.strSenFvu := fCfgSis('EQUFVU');

    If Not objLiberacao.fLibera Then
    Begin
      Result := False;
    End;
  End
  Else If Not fVerificaAcessoSistemaOS('ALTMEQ', 'Liberado direito de acesso à Alteração de itens e serviços de O.S. que não esteja em aberto.!', '') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso à Alteração de itens e serviços de O.S. que não esteja em aberto.!', ['&O k']);
    Result := False;
  End;
end;

function TConEqu.fPossuiItemEspecial: Boolean;
begin
  Result := False;

  If (Not cdsIteEqu.IsEmpty) Then Begin

    cdsIteEqu.DisableControls;
    cdsIteEqu.First;

    While (Not cdsIteEqu.Eof) Do Begin

      If (Pos('ITEM ESPECIAL', cdsIteEqu.FieldByName('DESITE').AsString) > 0) Then Begin
        Result := True;
        Break;
      End;

      cdsIteEqu.Next;
    End;

    cdsIteEqu.EnableControls;

  End;
end;

function TConEqu.fProdutosNaoExpedidos(strNumDoc, strCodEmp, strCodCli: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  Try
    qryAux := fCriaQuery(Nil);

    With qryAux do Begin
      SQL.Clear;
      SQL.Add('SELECT');
      SQL.Add('  SUM(D.FDO_QTDITE - ED.FDO_QTDEXP) AS QTD');
      SQL.Add('FROM');
      SQL.Add('  FATDOR D');
      SQL.Add('  INNER JOIN EXTDOR ED');
      SQL.Add('    ON ED.FDO_SEQFDO = D.AUTOINCREM');
      SQL.Add('WHERE D.FDO_NUMDOC = :NUMDOC');
      SQL.Add('  AND D.FDO_ESPDOC = :ESPDOC');
      SQL.Add('  AND D.FDO_CODEMP = :CODEMP');
      SQL.Add('  AND D.FDO_CODCLI = :CODCLI');
      SQL.Add('  AND D.FDO_CODITE <> :ITESER');
      SQL.Add('  AND D.FDO_CODITE <> :SERTER');
      ParamByName('NUMDOC').AsString := strNumDoc;
      ParamByName('ESPDOC').AsString := 'PD';
      ParamByName('CODEMP').AsString := strCodEmp;
      ParamByName('CODCLI').AsString := strCodCli;
      ParamByName('ITESER').AsString := fCfgSis('ITESER', varString);
      ParamByName('SERTER').AsString := fCfgSis('SERTER', varString);
      Open;

      Result := (FieldByName('QTD').AsInteger > 0);
    End;
  Finally
    FreeANdNil(qryAux);
  End;
end;

function fRetPerComissaoMecTecServico(sCodSer : String): Double;
  Var
    fltCom : Double;
    blnPerc: Boolean;
begin
  Result := 0.000;

  If (Not fEmptyStr(sCodSer)) And (StrToInt(sCodSer) > 0) Then Begin
    blnPerc := (fCampoTabela('SER_TPCOMC', 'CADSER', ['SER_CODSER'], [sCodSer]) = 'P');
    fltCom  := fCampoTabela('SER_COMMEC', 'CADSER', ['SER_CODSER'], [sCodSer]);

    If (blnPerc) Then
      Result := fltCom / 100
    Else
      Result := 0;
  End;
end;

function fGetValComVendOrdServico(dQtdSer: Double; sCodSer : String): Double;
  Var
    fltCom : Double;
    blnPerc: Boolean;
begin
  Result := 0.000;

  If (Not fEmptyStr(sCodSer)) And (StrToInt(sCodSer) > 0) Then Begin
    blnPerc := (fCampoTabela('SER_TPCOMC', 'CADSER', ['SER_CODSER'], [sCodSer]) = 'P');
    fltCom  := fCampoTabela('SER_COMMEC', 'CADSER', ['SER_CODSER'], [sCodSer]);

    If (Not blnPerc) Then
      Result := dQtdSer * fltCom
    Else
      Result := 0;
  End;
end;

function fRetOrdemMaoObra(strNumDoc, strEspDoc, strCodEmp: String): String;
var
  LQryOrdMO: TUniQuery;
begin
  result := '';

  try

    LQryOrdMO := fCriaQuery();
    LQryOrdMO.Close;
    LQryOrdMO.SQL.Clear;
    LQryOrdMO.SQL.Add('SELECT ');
    LQryOrdMO.SQL.Add('  GROUP_CONCAT(DISTINCT OC.OMO_MAOCLI) AS MAOCLI ');
    LQryOrdMO.SQL.Add('FROM ');
    LQryOrdMO.SQL.Add('  FATDOR FD LEFT JOIN OMOCLI OC ON OC.OMO_SEQFGO = FD.FDO_SEQGER ');
    LQryOrdMO.SQL.Add('WHERE FD.FDO_NUMFAT = '+QuotedStr(strNumDoc));
    LQryOrdMO.SQL.Add('  AND FD.FDO_TIPFAT = '+QuotedStr(strEspDoc));
    LQryOrdMO.SQL.Add('  AND FD.FDO_EMPFAT = '+QuotedStr(strCodEmp));
    LQryOrdMO.Open;

    if not LQryOrdMO.isEmpty then
      result := LQryOrdMO.FieldByName('MAOCLI').asString;

  finally
    FreeAndNil(LQryOrdMO);
  end;

end;

function TConEqu.fAtualizarDadosServicos: TDadosServicos;
  Var
    prcScroll: TprcScroll;
begin
  Result.fltValS01 := 0.0;
  Result.fltValS02 := 0.0;
  Result.fltValS03 := 0.0;
  Result.fltValS04 := 0.0;
  Result.fltValS05 := 0.0;
  Result.fltValS06 := 0.0;
  Result.fltValS07 := 0.0;
  Result.fltValS08 := 0.0;
  Result.fltValS09 := 0.0;
  Result.fltValS10 := 0.0;
  Result.fltValS11 := 0.0;
  Result.fltValS12 := 0.0;
  Result.fltValS13 := 0.0;
  Result.fltValS14 := 0.0;
  Result.fltValS15 := 0.0;
  Result.fltValS16 := 0.0;
  Result.fltValS17 := 0.0;
  Result.fltValS18 := 0.0;
  Result.fltValS19 := 0.0;
  Result.fltValS20 := 0.0;
  Result.fltValS21 := 0.0;
  Result.fltValS22 := 0.0;
  Result.fltValS23 := 0.0;
  Result.fltValS24 := 0.0;
  Result.fltValS25 := 0.0;
  Result.fltValS26 := 0.0;
  Result.fltValS27 := 0.0;
  Result.fltValS28 := 0.0;
  Result.fltValS29 := 0.0;
  Result.fltValS30 := 0.0;

  Try
    pDisableControls(cdsSerEqu, prcScroll);

    With cdsSerEqu Do Begin

      First;

      If Not IsEmpty Then Begin
        Result.strCodS01 := fieldbyname('CODSER').AsString;
        Result.strDesS01 := fieldbyname('DESSER').AsString;
        Result.fltQtdS01 := fieldbyname('QTDSER').AsFloat;
        Result.fltUniS01 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
        Result.fltValS01 := fieldbyname('VALSER').AsFloat;
        Result.strBriS01 := fieldbyname('BRINDE').AsString;
        Result.strParS01 := fieldbyname('CODPAR').AsString;
        Result.strTBrS01 := fieldbyname('TIPBRI').AsString;
        Result.strMecS01 := fieldbyname('TECSER').AsString;
        Result.strVenS01 := fieldbyname('TECSER').AsString;
        Result.strIdeS01 := 'S';
        Next;

        If RecordCount > 1 Then Begin
          Result.strCodS02 := fieldbyname('CODSER').AsString;
          Result.strDesS02 := fieldbyname('DESSER').AsString;
          Result.fltQtdS02 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS02 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS02 := fieldbyname('VALSER').AsFloat;
          Result.strBriS02 := fieldbyname('BRINDE').AsString;
          Result.strParS02 := fieldbyname('CODPAR').AsString;
          Result.strTBrS02 := fieldbyname('TIPBRI').AsString;
          Result.strMecS02 := fieldbyname('TECSER').AsString;
          Result.strVenS02 := fieldbyname('TECSER').AsString;
          Result.strIdeS02 := 'S';
          Next;
        End;

        If RecordCount > 2 Then Begin
          Result.strCodS03 := fieldbyname('CODSER').AsString;
          Result.strDesS03 := fieldbyname('DESSER').AsString;
          Result.fltQtdS03 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS03 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS03 := fieldbyname('VALSER').AsFloat;
          Result.strBriS03 := fieldbyname('BRINDE').AsString;
          Result.strParS03 := fieldbyname('CODPAR').AsString;
          Result.strTBrS03 := fieldbyname('TIPBRI').AsString;
          Result.strMecS03 := fieldbyname('TECSER').AsString;
          Result.strVenS03 := fieldbyname('TECSER').AsString;
          Result.strIdeS03 := 'S';
          Next;
        End;

        If RecordCount > 3 Then Begin
          Result.strCodS04 := fieldbyname('CODSER').AsString;
          Result.strDesS04 := fieldbyname('DESSER').AsString;
          Result.fltQtdS04 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS04 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS04 := fieldbyname('VALSER').AsFloat;
          Result.strBriS04 := fieldbyname('BRINDE').AsString;
          Result.strParS04 := fieldbyname('CODPAR').AsString;
          Result.strTBrS04 := fieldbyname('TIPBRI').AsString;
          Result.strMecS04 := fieldbyname('TECSER').AsString;
          Result.strVenS04 := fieldbyname('TECSER').AsString;
          Result.strIdeS04 := 'S';
          Next;
        End;

        If RecordCount > 4 Then Begin
          Result.strCodS05 := fieldbyname('CODSER').AsString;
          Result.strDesS05 := fieldbyname('DESSER').AsString;
          Result.fltQtdS05 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS05 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS05 := fieldbyname('VALSER').AsFloat;
          Result.strBriS05 := fieldbyname('BRINDE').AsString;
          Result.strParS05 := fieldbyname('CODPAR').AsString;
          Result.strTBrS05 := fieldbyname('TIPBRI').AsString;
          Result.strMecS05 := fieldbyname('TECSER').AsString;
          Result.strVenS05 := fieldbyname('TECSER').AsString;
          Result.strIdeS05 := 'S';
          Next;
        End;

        If RecordCount > 5 Then Begin
          Result.strCodS06 := fieldbyname('CODSER').AsString;
          Result.strDesS06 := fieldbyname('DESSER').AsString;
          Result.fltQtdS06 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS06 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS06 := fieldbyname('VALSER').AsFloat;
          Result.strBriS06 := fieldbyname('BRINDE').AsString;
          Result.strParS06 := fieldbyname('CODPAR').AsString;
          Result.strTBrS06 := fieldbyname('TIPBRI').AsString;
          Result.strMecS06 := fieldbyname('TECSER').AsString;
          Result.strVenS06 := fieldbyname('TECSER').AsString;
          Result.strIdeS06 := 'S';
          Next;
        End;

        If RecordCount > 6 Then Begin
          Result.strCodS07 := fieldbyname('CODSER').AsString;
          Result.strDesS07 := fieldbyname('DESSER').AsString;
          Result.fltQtdS07 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS07 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS07 := fieldbyname('VALSER').AsFloat;
          Result.strBriS07 := fieldbyname('BRINDE').AsString;
          Result.strParS07 := fieldbyname('CODPAR').AsString;
          Result.strTBrS07 := fieldbyname('TIPBRI').AsString;
          Result.strMecS07 := fieldbyname('TECSER').AsString;
          Result.strVenS07 := fieldbyname('TECSER').AsString;
          Result.strIdeS07 := 'S';
          Next;
        End;

        If RecordCount > 7 Then Begin
          Result.strCodS08 := fieldbyname('CODSER').AsString;
          Result.strDesS08 := fieldbyname('DESSER').AsString;
          Result.fltQtdS08 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS08 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS08 := fieldbyname('VALSER').AsFloat;
          Result.strBriS08 := fieldbyname('BRINDE').AsString;
          Result.strParS08 := fieldbyname('CODPAR').AsString;
          Result.strTBrS08 := fieldbyname('TIPBRI').AsString;
          Result.strMecS08 := fieldbyname('TECSER').AsString;
          Result.strVenS08 := fieldbyname('TECSER').AsString;
          Result.strIdeS08 := 'S';
          Next;
        End;

        If RecordCount > 8 Then Begin
          Result.strCodS09 := fieldbyname('CODSER').AsString;
          Result.strDesS09 := fieldbyname('DESSER').AsString;
          Result.fltQtdS09 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS09 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS09 := fieldbyname('VALSER').AsFloat;
          Result.strBriS09 := fieldbyname('BRINDE').AsString;
          Result.strParS09 := fieldbyname('CODPAR').AsString;
          Result.strTBrS09 := fieldbyname('TIPBRI').AsString;
          Result.strMecS09 := fieldbyname('TECSER').AsString;
          Result.strVenS09 := fieldbyname('TECSER').AsString;
          Result.strIdeS09 := 'S';
          Next;
        End;

        If RecordCount > 9 Then Begin
          Result.strCodS10 := fieldbyname('CODSER').AsString;
          Result.strDesS10 := fieldbyname('DESSER').AsString;
          Result.fltQtdS10 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS10 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS10 := fieldbyname('VALSER').AsFloat;
          Result.strBriS10 := fieldbyname('BRINDE').AsString;
          Result.strParS10 := fieldbyname('CODPAR').AsString;
          Result.strTBrS10 := fieldbyname('TIPBRI').AsString;
          Result.strMecS10 := fieldbyname('TECSER').AsString;
          Result.strVenS10 := fieldbyname('TECSER').AsString;
          Result.strIdeS10 := 'S';
          Next;
        End;

        If RecordCount > 10 Then Begin
          Result.strCodS11 := fieldbyname('CODSER').AsString;
          Result.strDesS11 := fieldbyname('DESSER').AsString;
          Result.fltQtdS11 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS11 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS11 := fieldbyname('VALSER').AsFloat;
          Result.strBriS11 := fieldbyname('BRINDE').AsString;
          Result.strParS11 := fieldbyname('CODPAR').AsString;
          Result.strTBrS11 := fieldbyname('TIPBRI').AsString;
          Result.strMecS11 := fieldbyname('TECSER').AsString;
          Result.strVenS11 := fieldbyname('TECSER').AsString;
          Result.strIdeS11 := 'S';
          Next;
        End;

        If RecordCount > 11 Then Begin
          Result.strCodS12 := fieldbyname('CODSER').AsString;
          Result.strDesS12 := fieldbyname('DESSER').AsString;
          Result.fltQtdS12 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS12 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS12 := fieldbyname('VALSER').AsFloat;
          Result.strBriS12 := fieldbyname('BRINDE').AsString;
          Result.strParS12 := fieldbyname('CODPAR').AsString;
          Result.strTBrS12 := fieldbyname('TIPBRI').AsString;
          Result.strMecS12 := fieldbyname('TECSER').AsString;
          Result.strVenS12 := fieldbyname('TECSER').AsString;
          Result.strIdeS12 := 'S';
          Next;
        End;

        If RecordCount > 12 Then Begin
          Result.strCodS13 := fieldbyname('CODSER').AsString;
          Result.strDesS13 := fieldbyname('DESSER').AsString;
          Result.fltQtdS13 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS13 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS13 := fieldbyname('VALSER').AsFloat;
          Result.strBriS13 := fieldbyname('BRINDE').AsString;
          Result.strParS13 := fieldbyname('CODPAR').AsString;
          Result.strTBrS13 := fieldbyname('TIPBRI').AsString;
          Result.strMecS13 := fieldbyname('TECSER').AsString;
          Result.strVenS13 := fieldbyname('TECSER').AsString;
          Result.strIdeS13 := 'S';
          Next;
        End;

        If RecordCount > 13 Then Begin
          Result.strCodS14 := fieldbyname('CODSER').AsString;
          Result.strDesS14 := fieldbyname('DESSER').AsString;
          Result.fltQtdS14 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS14 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS14 := fieldbyname('VALSER').AsFloat;
          Result.strBriS14 := fieldbyname('BRINDE').AsString;
          Result.strParS14 := fieldbyname('CODPAR').AsString;
          Result.strTBrS14 := fieldbyname('TIPBRI').AsString;
          Result.strMecS14 := fieldbyname('TECSER').AsString;
          Result.strVenS14 := fieldbyname('TECSER').AsString;
          Result.strIdeS14 := 'S';
          Next;
        End;

        If RecordCount > 14 Then Begin
          Result.strCodS15 := fieldbyname('CODSER').AsString;
          Result.strDesS15 := fieldbyname('DESSER').AsString;
          Result.fltQtdS15 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS15 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS15 := fieldbyname('VALSER').AsFloat;
          Result.strBriS15 := fieldbyname('BRINDE').AsString;
          Result.strParS15 := fieldbyname('CODPAR').AsString;
          Result.strTBrS15 := fieldbyname('TIPBRI').AsString;
          Result.strMecS15 := fieldbyname('TECSER').AsString;
          Result.strVenS15 := fieldbyname('TECSER').AsString;
          Result.strIdeS15 := 'S';
          Next;
        End;

        If RecordCount > 15 Then Begin
          Result.strCodS16 := fieldbyname('CODSER').AsString;
          Result.strDesS16 := fieldbyname('DESSER').AsString;
          Result.fltQtdS16 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS16 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS16 := fieldbyname('VALSER').AsFloat;
          Result.strBriS16 := fieldbyname('BRINDE').AsString;
          Result.strParS16 := fieldbyname('CODPAR').AsString;
          Result.strTBrS16 := fieldbyname('TIPBRI').AsString;
          Result.strMecS16 := fieldbyname('TECSER').AsString;
          Result.strVenS16 := fieldbyname('TECSER').AsString;
          Result.strIdeS16 := 'S';
          Next;
        End;

        If RecordCount > 16 Then Begin
          Result.strCodS17 := fieldbyname('CODSER').AsString;
          Result.strDesS17 := fieldbyname('DESSER').AsString;
          Result.fltQtdS17 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS17 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS17 := fieldbyname('VALSER').AsFloat;
          Result.strBriS17 := fieldbyname('BRINDE').AsString;
          Result.strParS17 := fieldbyname('CODPAR').AsString;
          Result.strTBrS17 := fieldbyname('TIPBRI').AsString;
          Result.strMecS17 := fieldbyname('TECSER').AsString;
          Result.strVenS17 := fieldbyname('TECSER').AsString;
          Result.strIdeS17 := 'S';
          Next;
        End;

        If RecordCount > 17 Then Begin
          Result.strCodS18 := fieldbyname('CODSER').AsString;
          Result.strDesS18 := fieldbyname('DESSER').AsString;
          Result.fltQtdS18 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS18 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS18 := fieldbyname('VALSER').AsFloat;
          Result.strBriS18 := fieldbyname('BRINDE').AsString;
          Result.strParS18 := fieldbyname('CODPAR').AsString;
          Result.strTBrS18 := fieldbyname('TIPBRI').AsString;
          Result.strMecS18 := fieldbyname('TECSER').AsString;
          Result.strVenS18 := fieldbyname('TECSER').AsString;
          Result.strIdeS18 := 'S';
          Next;
        End;

        If RecordCount > 18 Then Begin
          Result.strCodS19 := fieldbyname('CODSER').AsString;
          Result.strDesS19 := fieldbyname('DESSER').AsString;
          Result.fltQtdS19 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS19 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS19 := fieldbyname('VALSER').AsFloat;
          Result.strBriS19 := fieldbyname('BRINDE').AsString;
          Result.strParS19 := fieldbyname('CODPAR').AsString;
          Result.strTBrS19 := fieldbyname('TIPBRI').AsString;
          Result.strMecS19 := fieldbyname('TECSER').AsString;
          Result.strVenS19 := fieldbyname('TECSER').AsString;
          Result.strIdeS19 := 'S';
          Next;
        End;

        If RecordCount > 19 Then Begin
          Result.strCodS20 := fieldbyname('CODSER').AsString;
          Result.strDesS20 := fieldbyname('DESSER').AsString;
          Result.fltQtdS20 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS20 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS20 := fieldbyname('VALSER').AsFloat;
          Result.strBriS20 := fieldbyname('BRINDE').AsString;
          Result.strParS20 := fieldbyname('CODPAR').AsString;
          Result.strTBrS20 := fieldbyname('TIPBRI').AsString;
          Result.strMecS20 := fieldbyname('TECSER').AsString;
          Result.strVenS20 := fieldbyname('TECSER').AsString;
          Result.strIdeS20 := 'S';
          Next;
        End;

        If RecordCount > 20 Then Begin
          Result.strCodS21 := fieldbyname('CODSER').AsString;
          Result.strDesS21 := fieldbyname('DESSER').AsString;
          Result.fltQtdS21 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS21 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS21 := fieldbyname('VALSER').AsFloat;
          Result.strBriS21 := fieldbyname('BRINDE').AsString;
          Result.strParS21 := fieldbyname('CODPAR').AsString;
          Result.strTBrS21 := fieldbyname('TIPBRI').AsString;
          Result.strMecS21 := fieldbyname('TECSER').AsString;
          Result.strVenS21 := fieldbyname('TECSER').AsString;
          Result.strIdeS21 := 'S';
          Next;
        End;

        If RecordCount > 21 Then Begin
          Result.strCodS22 := fieldbyname('CODSER').AsString;
          Result.strDesS22 := fieldbyname('DESSER').AsString;
          Result.fltQtdS22 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS22 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS22 := fieldbyname('VALSER').AsFloat;
          Result.strBriS22 := fieldbyname('BRINDE').AsString;
          Result.strParS22 := fieldbyname('CODPAR').AsString;
          Result.strTBrS22 := fieldbyname('TIPBRI').AsString;
          Result.strMecS22 := fieldbyname('TECSER').AsString;
          Result.strVenS22 := fieldbyname('TECSER').AsString;
          Result.strIdeS22 := 'S';
          Next;
        End;

        If RecordCount > 22 Then Begin
          Result.strCodS23 := fieldbyname('CODSER').AsString;
          Result.strDesS23 := fieldbyname('DESSER').AsString;
          Result.fltQtdS23 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS23 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS23 := fieldbyname('VALSER').AsFloat;
          Result.strBriS23 := fieldbyname('BRINDE').AsString;
          Result.strParS23 := fieldbyname('CODPAR').AsString;
          Result.strTBrS23 := fieldbyname('TIPBRI').AsString;
          Result.strMecS23 := fieldbyname('TECSER').AsString;
          Result.strVenS23 := fieldbyname('TECSER').AsString;
          Result.strIdeS23 := 'S';
          Next;
        End;

        If RecordCount > 23 Then Begin
          Result.strCodS24 := fieldbyname('CODSER').AsString;
          Result.strDesS24 := fieldbyname('DESSER').AsString;
          Result.fltQtdS24 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS24 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS24 := fieldbyname('VALSER').AsFloat;
          Result.strBriS24 := fieldbyname('BRINDE').AsString;
          Result.strParS24 := fieldbyname('CODPAR').AsString;
          Result.strTBrS24 := fieldbyname('TIPBRI').AsString;
          Result.strMecS24 := fieldbyname('TECSER').AsString;
          Result.strVenS24 := fieldbyname('TECSER').AsString;
          Result.strIdeS24 := 'S';
          Next;
        End;

        If RecordCount > 24 Then Begin
          Result.strCodS25 := fieldbyname('CODSER').AsString;
          Result.strDesS25 := fieldbyname('DESSER').AsString;
          Result.fltQtdS25 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS25 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS25 := fieldbyname('VALSER').AsFloat;
          Result.strBriS25 := fieldbyname('BRINDE').AsString;
          Result.strParS25 := fieldbyname('CODPAR').AsString;
          Result.strTBrS25 := fieldbyname('TIPBRI').AsString;
          Result.strMecS25 := fieldbyname('TECSER').AsString;
          Result.strVenS25 := fieldbyname('TECSER').AsString;
          Result.strIdeS25 := 'S';
          Next;
        End;

        If RecordCount > 25 Then Begin
          Result.strCodS26 := fieldbyname('CODSER').AsString;
          Result.strDesS26 := fieldbyname('DESSER').AsString;
          Result.fltQtdS26 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS26 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS26 := fieldbyname('VALSER').AsFloat;
          Result.strBriS26 := fieldbyname('BRINDE').AsString;
          Result.strParS26 := fieldbyname('CODPAR').AsString;
          Result.strTBrS26 := fieldbyname('TIPBRI').AsString;
          Result.strMecS26 := fieldbyname('TECSER').AsString;
          Result.strVenS26 := fieldbyname('TECSER').AsString;
          Result.strIdeS26 := 'S';
          Next;
        End;

        If RecordCount > 26 Then Begin
          Result.strCodS27 := fieldbyname('CODSER').AsString;
          Result.strDesS27 := fieldbyname('DESSER').AsString;
          Result.fltQtdS27 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS27 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS27 := fieldbyname('VALSER').AsFloat;
          Result.strBriS27 := fieldbyname('BRINDE').AsString;
          Result.strParS27 := fieldbyname('CODPAR').AsString;
          Result.strTBrS27 := fieldbyname('TIPBRI').AsString;
          Result.strMecS27 := fieldbyname('TECSER').AsString;
          Result.strVenS27 := fieldbyname('TECSER').AsString;
          Result.strIdeS27 := 'S';
          Next;
        End;

        If RecordCount > 27 Then Begin
          Result.strCodS28 := fieldbyname('CODSER').AsString;
          Result.strDesS28 := fieldbyname('DESSER').AsString;
          Result.fltQtdS28 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS28 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS28 := fieldbyname('VALSER').AsFloat;
          Result.strBriS28 := fieldbyname('BRINDE').AsString;
          Result.strParS28 := fieldbyname('CODPAR').AsString;
          Result.strTBrS28 := fieldbyname('TIPBRI').AsString;
          Result.strMecS28 := fieldbyname('TECSER').AsString;
          Result.strVenS28 := fieldbyname('TECSER').AsString;
          Result.strIdeS28 := 'S';
          Next;
        End;

        If RecordCount > 28 Then Begin
          Result.strCodS29 := fieldbyname('CODSER').AsString;
          Result.strDesS29 := fieldbyname('DESSER').AsString;
          Result.fltQtdS29 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS29 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS29 := fieldbyname('VALSER').AsFloat;
          Result.strBriS29 := fieldbyname('BRINDE').AsString;
          Result.strParS29 := fieldbyname('CODPAR').AsString;
          Result.strTBrS29 := fieldbyname('TIPBRI').AsString;
          Result.strMecS29 := fieldbyname('TECSER').AsString;
          Result.strVenS29 := fieldbyname('TECSER').AsString;
          Result.strIdeS29 := 'S';
          Next;
        End;

        If RecordCount > 29 Then Begin
          Result.strCodS30 := fieldbyname('CODSER').AsString;
          Result.strDesS30 := fieldbyname('DESSER').AsString;
          Result.fltQtdS30 := fieldbyname('QTDSER').AsFloat;
          Result.fltUniS30 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          Result.fltValS30 := fieldbyname('VALSER').AsFloat;
          Result.strBriS30 := fieldbyname('BRINDE').AsString;
          Result.strParS30 := fieldbyname('CODPAR').AsString;
          Result.strTBrS30 := fieldbyname('TIPBRI').AsString;
          Result.strMecS30 := fieldbyname('TECSER').AsString;
          Result.strVenS30 := fieldbyname('TECSER').AsString;
          Result.strIdeS30 := 'S';
        End;
      End;
    End;
  Finally
    pEnableControls(cdsSerEqu, prcScroll);
  End
end;

function TConEqu.fGeraPedidoVenda(Var strNumDoc: String; blnAtualizaPed: Boolean; strEmpIte: String = ''): Boolean;
var
  strCliente    : String;
  strCodCndInt  : String;
  strCodFpgInt  : String;
  strConPagInt  : String;
  strPedMen001  : String;
  strPedMen002  : String;
  strSeqFgo     : String;
  strItePed     : String;
  recServicos   : TDadosServicos;
  dadosItem     : TDadosProduto;
  dadosPedido   : TDadosPedido;
  objEmitirPedido: TEmitirPedido;
  blnSomenteBrindeServ: Boolean;
  strEmpLog     : String;
  strFiltro     : String;

  procedure pSetarEmpresaItem(strCodEmp: String);
  begin
    objEmitirPedido.objFatVenda.pCarregaCfgSis;
    objEmitirPedido.objFatVenda.pAtualizaClassTransferencias;
  end;

  function fIniciaPedido(strNumPed: String = ''): Boolean;
  begin
    objEmitirPedido.blnCriaTmp := not fInTransaction();
    Result := objEmitirPedido.fIniciarPedido(dadosPedido);

    pSetarEmpresaItem(VS_strCodEmp);

    If not fEmptyStr(strNumPed) Then
      objEmitirPedido.fSetNumDocs(strNumPed);

    if FMulLoj and (strEmpIte <> VS_strCodEmp) then
    begin
      objEmitirPedido.objFatVenda.strEmp_CD := strEmpIte;
      objEmitirPedido.objFatVenda.blnEnt_CD := True;
    end;

    If fClienteConsumidor(objEmitirPedido.objFatVenda.strCliOri, False, True) and (not fEmptyStr(FCliNom)) Then
    Begin
      objEmitirPedido.objFatVenda.strCliNom := FCliNom;
      objEmitirPedido.objFatVenda.strCliEnd := FCliEnd;
      objEmitirPedido.objFatVenda.strCliBai := FCliBai;
      objEmitirPedido.objFatVenda.strCliCep := FCliCep;
      objEmitirPedido.objFatVenda.strCodCid := FCodCid;
      objEmitirPedido.objFatVenda.strCliCid := fRetNomCidade(FCodCid);
      objEmitirPedido.objFatVenda.strCliEst := fRetNomCidade(FCodCid, 1);
      objEmitirPedido.objFatVenda.strCliTel := FCliTel;
      objEmitirPedido.objFatVenda.intCgcCpf := FCgcCpf;
      objEmitirPedido.objFatVenda.strCliCgc := FCliCgc;
      objEmitirPedido.objFatVenda.strCliIes := FCliIes;
      objEmitirPedido.objFatVenda.strCli_Rg := FCli_Rg;
      objEmitirPedido.objFatVenda.strCliEma := FCliEma;
      objEmitirPedido.objFatVenda.strCodAti := FCodAti;
      objEmitirPedido.objFatVenda.dtaNasCon := FNasCon;
      objEmitirPedido.objFatVenda.strNomAti := fRetAtividade(FCodAti);
    End;

    objEmitirPedido.objFatVenda.strEntFat := 'N';
  end;

  function fCarregaDadosItem: Boolean;
  begin
    Result := True;

    cdsIteEqu.DisableControls;
    cdsIteEqu.First;

    dadosPedido.strEntFat                := 'N';

    While (Not cdsIteEqu.Eof)  Do
    Begin
      dadosItem.strCodIte := cdsIteEqu.FieldByName('CODITE').AsString;
      dadosItem.strEntRet := cdsIteEqu.FieldByName('ENTRET').AsString;
      dadosItem.strLocRet := cdsIteEqu.FieldByName('LOCRET').AsString;

      If (dadosItem.strEntRet = 'E') Then
      Begin
        dadosPedido.strEntFat                := 'S';
        objEmitirPedido.objFatVenda.strEntFat := 'S';
      End;

      dadosItem.strIdePro := 'NOR';
      dadosItem.strPromoc := IIF(fEmptyStr(cdsIteEqu.FieldByName('PROMOC').AsString), 'N', cdsIteEqu.FieldByName('PROMOC').AsString);
      dadosItem.strDesIte := cdsIteEqu.FieldByName('DESITE').AsString;
      dadosItem.fltQtdIte := cdsIteEqu.FieldByName('QTDITE').AsFloat;
      dadosItem.fltUnitar := cdsIteEqu.FieldByName('UNITAR').AsFloat;
      dadosItem.fltDesEsp := cdsIteEqu.FieldByName('DESESP').AsFloat;
      dadosItem.fltUniOri := cdsIteEqu.FieldByName('UNIORI').AsFloat;
      dadosItem.strTabIte := cdsIteEqu.FieldByName('TABPRE').AsString;
      dadosItem.strBrinde := cdsIteEqu.FieldByName('BRINDE').AsString;
      dadosItem.strNumCmp := cdsIteEqu.FieldByName('NUMCMP').AsString;
      dadosItem.intNitCmp := cdsIteEqu.FieldByName('NITCMP').AsString;
      dadosItem.dtaDtaCmp := cdsIteEqu.FieldByName('DTACMP').AsDateTime;
      dadosItem.fltQtdExp := cdsIteEqu.FieldByName('QTDEXP').AsFloat;

      if not FResSal then
        dadosItem.strReserv := 'N';

      dadosItem.strNumLot := fNumLoteGeraPedido;

      dadosItem.strEmpIte := IIF(not fEmptyStr(strEmpIte), strEmpIte, '');
      FillChar(dadosItem.recForTin, SizeOf(dadosItem.recForTin), #0);
      Result := Result And objEmitirPedido.fInserirProduto(dadosItem);

      If Not Result Then
         Break;

      cdsIteEqu.Next;
    end;

    cdsIteEqu.EnableControls;
  end;

  procedure pCarregaCobAParte(aFiltro: String = '');
  begin
    cdsIteEqu.Filtered := False;
    cdsIteEqu.Filter   := IIF((not fEmptyStr(strFiltro)) and (not fEmptyStr(aFiltro)), strFiltro + ' AND ', strFiltro) + IIF(fEmptyStr(aFiltro), '', 'COBAPA=' + Quotedstr(aFiltro));
    cdsIteEqu.Filtered := True;

    cdsSerEqu.Filtered := False;
    cdsSerEqu.Filter   := IIF(fEmptyStr(aFiltro), '', 'COBAPA=' + Quotedstr(aFiltro));
    cdsSerEqu.Filtered := True;
  end;

  function fGravarPedidoAParte: Boolean;
  begin
    Try

      pCarregaCobAParte('S');

      dadosPedido.strCodCli := FCodCli;

      if Assigned(objEmitirPedido) then
        FreeAndNil(objEmitirPedido);

      objEmitirPedido := TEmitirPedido.Create(Self);
      FNumDocCli := fGetNumPed(IIF(fEmptyStr(strEmpIte), FEmpPed, strEmpIte), 'C', 'T');

      dadosPedido.fltDesEsp := fGerDesEsp;
      dadosPedido.blnPedRemGar := False;

      Result := fIniciaPedido(FNumDocCli);

      if Result then
      begin
        Result      := fCarregaDadosItem;

        If Result Then
        Begin

          if (not FMulLoj) or (FMulLoj and (FEmpSer = strEmpIte)) then
          begin
            recServicos := fCarregaRecServicos(FCodCli, 'S');
            objEmitirPedido.fSetServicos(recServicos, IIF(FMulLoj, FEmpSer, ''));
          end;

          objEmitirPedido.fSetImprimeDocs(false);

        End;

        If Result Then
          Result := objEmitirPedido.fCalcularTotais And
                    objEmitirPedido.fValidarPedido  And
                    objEmitirPedido.fGravarPedido;


      end;

      if Result then
      begin
        pAdicionaDocumentoParaImpressao(objEmitirPedido.objFatVenda, strEmpLog, IIF(fEmptyStr(strEmpIte), strEmpLog, strEmpIte));
        FNumDocCli := objEmitirPedido.fGetNumDoc;
        strSeqFgo := objEmitirPedido.fGetAutInc;

        if not fEmptyStr(FNumDocCli) then
        begin
          pGravarOrdemMaoObraCli(strSeqFgo);
          pDefinirDtHrLibExp(FDtLbEx, FHrLbEx, FDtBxSe, FHrBxSe, FNumDocCli, FCodCli, FEmpPed, FOpBxSe);
          TTestabilidade.fGetTestabilidade.PedidoConsertoEquipamento := FNumDocCli;
          blnSomenteBrindeServ := (objEmitirPedido.objfatvenda.fPossuiSomenteBrinde()) and (not objEmitirPedido.objfatvenda.fPossuiBrindeProduto());

          if blnSomenteBrindeServ and (objEmitirPedido.objfatvenda.fltTotGer = 0) and (not fCfgSis('PERBBS', varBoolean)) then
          Begin
            pBaixaPedidoBrinde(FNumDocCli, 'PD', strCodEmp, 'DADOS BAIXA: ' + FormatDateTime('DD/MM/YYYY', VS_Date) + ' - ' +
                               FormatDateTime('HH:MM:SS', fRetHoraServidor) + ' ' + 'OPE: ' + strLoginUsuarioLogado + ' - ' +
                               fRetNomeOperador(strLoginUsuarioLogado) + ' - ' + 'MOTIVO: ORIUNDO DE ORDEM DE SERVIÇO BRINDE.');
          end;
        end;

        if FCobApa or FMulLoj then
          pGravarDesmembramento(strSeqFgo, FAutInc, 'C', 'T', FMulLoj);
      end;

      dadosPedido.blnPedRemGar := (not fEmptyStr(strCliGar));

    Except
      raise;
    End;
  end;

begin
  strFiltro := IIF(not fEmptyStr(cdsIteEqu.Filter), cdsIteEqu.Filter + ' ', '');

  strEmpLog := VS_strCodEmp;

  if (not fEmptyStr(strEmpIte)) and (not fCfgSis('ENT_CD', varBoolean)) then
    pSetaEmpresaLogada(strEmpIte);

  if fEmptyStr(FEmpPed) or FMulLoj then
    FEmpPed := VS_strCodEmp;

  if fEmptyStr(strCliGar) then
    strCliente := FCodCli
  else
    strCliente := strCliGar;

  FCobApa := fVerificaItensServicosCobAParte;

  if FCobApa then
    pCarregaCobAParte('N');

  strPedMen001 := AnsiReplaceStr(strDescri, #13#10, ' ');
  strPedMen002 := AnsiReplaceStr(strObserv, #13#10, ' ');

  try

    Try
      if (fCfgSis('USCNFP', varBoolean)) then
      begin
        strConPagInt := FConPag;
        strCodCndInt := FCodCnd;
        strCodFpgInt := FCodFpg;
      end
      else
      begin
        strConPagInt := '01000';
        strCodCndInt := '';
        If fCfgSis('USACND', VarBoolean) then
          strCodCndInt := fRetCodCndAVista;
        strCodFpgInt := '';
        If fCfgSis('USAFPG', VarBoolean) then
          strCodFpgInt := '001';
      end;

      dadosPedido.strCodCli := strCliente;
      dadosPedido.strCodVen := FCodVen;
      dadosPedido.strCodVe2 := FCodVe2;

      If (fEmptyStr(FCodDig)) Then Begin
        If fCfgSis('USADIG', varBoolean) Then
          dadosPedido.strCodDig := FCodVen
        Else
          dadosPedido.strCodDig := strLoginUsuarioLogado;
      End Else
        dadosPedido.strCodDig := FCodDig;

      dadosPedido.strConPag := strConPagInt;
      dadosPedido.strCodCnd := strCodCndInt;
      dadosPedido.strCodFpg := strCodFpgInt;
      dadosPedido.fltDesEsp := FDesEsp;
      dadosPedido.strMen001 := strPedMen001;
      dadosPedido.strMen002 := strPedMen002;
      dadosPedido.strMenExp := '';
      dadosPedido.strTipPed := fDefineTipPed;
      dadosPedido.strTipOpe := 'V';
      dadosPedido.strTabPre := FTabPre;
      dadosPedido.strTipFin := 'P';
      dadosPedido.strEntFat := '';
      dadosPedido.strNumPok := '';
      dadosPedido.dtaPreVis := VS_Date;
      dadosPedido.dtaDtaOri := VS_Date;
      dadosPedido.dtaGraPed := VS_Date;
      dadosPedido.dtaHorImp := 0;
      dadosPedido.strCodTra := FCodTra;
      dadosPedido.intQtdTra := FQtdTra;
      dadosPedido.strEspTra := FEspTra;
      dadosPedido.fltValFre := FValFre;
      dadosPedido.strTipFre := FTipFre;
      dadosPedido.dtaDtaTra := 0;
      dadosPedido.dtaHorTra := 0;
      dadosPedido.strAutEnt := FEntGer;
      dadosPedido.strEspDoc := 'PD';
      dadosPedido.strEmp_CD := '';
      dadosPedido.blnEnt_CD := False;
      dadosPedido.strTipOpe := IIF( (strSubSta = 'B'), 'B', 'V' );
      dadosPedido.blnPedRemGar := ( not fEmptyStr(strCliGar) );
      dadosPedido.blnConEqu := True;
      dadosPedido.strSepImp := FSepImp;
      dadosPedido.strEnvLib := 'S';
      dadosPedido.blnVenPre := FVenPre;
      dadosPedido.strCodDiv := FCodigoProfissional;
      dadosPedido.strInRqCp := FstrInRqCp;

      if Assigned(FFazenda) and (not fEmptyStr(FFazenda.strCodFaz)) then
        dadosPedido.objFazenda := FFazenda;

      If fCfgSis('FATSSA', varBoolean) Then
        dadosPedido.strEmpFatSemSaldo := FEmpFatSemSaldo;

      if (fCfgSis('FLXSEP', varBoolean)) and (FFlxSitAnt = 'MF') then
        dadosPedido.strOpBxSe := FOpBxSe;

      if not FcdsListaCodigoProfissionais.IsEmpty then
      begin
        if not Assigned(dadosPedido.cdsProfiss) then
          dadosPedido.cdsProfiss := TUniClientDataSet.create(nil);
        pCloneDataSet(dadosPedido.cdsProfiss, FcdsListaCodigoProfissionais);
      end;

      if not FcdsMovRcd.IsEmpty then
      begin
        if not Assigned(dadosPedido.cdsMovRcd) then
          dadosPedido.cdsMovRcd := TUniClientDataSet.create(nil);
        pCloneDataSet(dadosPedido.cdsMovRcd, FcdsMovRcd);

        if fCfgSis('SLRCON', varBoolean) then
          dadosPedido.blnRequisicaoCompraConsertoEquip := True;
      end;

      untFatGor.intSeqFdo := 1;

      if (fDesmembrarItensServicos) then
      begin
        if (cdsIteEqu.RecordCount > 0) and (cdsSerEqu.RecordCount > 0) then
        begin
          {*** GERA PEDIDO PRODUTOS ***}
          objEmitirPedido := TEmitirPedido.Create(Self);

          if (not blnAtualizaPed) then
            strNumDoc := fGetNumPed(strEmpIte, FGarant, 'I');

          dadosPedido.fltDesEsp := fGerDesEsp;

          Result := fIniciaPedido(strNumDoc);

          if Result then
          begin
            Result := fCarregaDadosItem;

            If Result Then
            Begin

              objEmitirPedido.fSetImprimeDocs(false);

               If Result Then
                Result := objEmitirPedido.fCalcularTotais And
                          objEmitirPedido.fValidarPedido  And
                          objEmitirPedido.fGravarPedido;

            End;
          end;

          if Result then
          begin
            pAdicionaDocumentoParaImpressao(objEmitirPedido.objFatVenda, strEmpLog, IIF(fEmptyStr(strEmpIte), strEmpLog, strEmpIte));
            strNumDoc := objEmitirPedido.fGetNumDoc;
            strSeqFgo := objEmitirPedido.fGetAutInc;

            if not fEmptyStr(strNumDoc) then
            begin
              if blnAtualizaPed then
                pMarcaNumeroPedidoVenda(strNumDoc, False);

              pDefinirDtHrLibExp(FDtLbEx, FHrLbEx, FDtBxSe, FHrBxSe, strNumDoc, strCliente, FEmpPed, FOpBxSe);
              TTestabilidade.fGetTestabilidade.PedidoConsertoEquipamento := strNumDoc;
              blnSomenteBrindeServ := (objEmitirPedido.objfatvenda.fPossuiSomenteBrinde()) and (not objEmitirPedido.objfatvenda.fPossuiBrindeProduto());

              if blnSomenteBrindeServ and (objEmitirPedido.objfatvenda.fltTotGer = 0) and (not fCfgSis('PERBBS', varBoolean)) then
              Begin
                pBaixaPedidoBrinde(strNumDoc, 'PD', strCodEmp, 'DADOS BAIXA: ' + FormatDateTime('DD/MM/YYYY', VS_Date) + ' - ' +
                                                         FormatDateTime('HH:MM:SS', fRetHoraServidor)      + ' '   +
                                                         'OPE: ' + strLoginUsuarioLogado       + ' - ' +
                                                         fRetNomeOperador(strLoginUsuarioLogado)+ ' - ' +
                                                         'MOTIVO: ORIUNDO DE ORDEM DE SERVIÇO BRINDE.');
              end;
            end;

            pGravarDesmembramento(strSeqFgo, FAutInc, FGarant, 'I', FMulLoj);
          end;

          if (not FMulLoj) or (FMulLoj and (FEmpSer = strEmpIte)) then
          begin
            {*** GERA PEDIDO SERVIÇOS ***}
            dadosPedido.blnRequisicaoCompraConsertoEquip := False;

            if Assigned(objEmitirPedido) then
              FreeAndNil(objEmitirPedido);

            objEmitirPedido := TEmitirPedido.Create(Self);

            FNumDocSer := fGetNumPed(IIF(fEmptyStr(strEmpIte), FEmpPed, strEmpIte), FGarant, 'S');
            dadosPedido.fltDesEsp := 0;

            Result := fIniciaPedido(FNumDocSer);

            if Result then
            begin
              recServicos := fCarregaRecServicos(strCliente, 'N');
              objEmitirPedido.fSetServicos(recServicos, IIF(FMulLoj, FEmpSer, ''));
              objEmitirPedido.fSetImprimeDocs(false);

              If Result Then
                Result := objEmitirPedido.fCalcularTotais And
                          objEmitirPedido.fValidarPedido  And
                          objEmitirPedido.fGravarPedido;
            end;

            if Result then
            begin
              pAdicionaDocumentoParaImpressao(objEmitirPedido.objFatVenda, strEmpLog, IIF(fEmptyStr(strEmpIte), strEmpLog, strEmpIte));
              FNumDocSer := objEmitirPedido.fGetNumDoc;
              strSeqFgo := objEmitirPedido.fGetAutInc;

              if not fEmptyStr(FNumDocSer) then
              begin
                pGravarOrdemMaoObraCli(strSeqFgo);
                pDefinirDtHrLibExp(FDtLbEx, FHrLbEx, FDtBxSe, FHrBxSe, FNumDocSer, strCliente, FEmpPed, FOpBxSe);
                TTestabilidade.fGetTestabilidade.PedidoConsertoEquipamento := FNumDocSer;
                blnSomenteBrindeServ := (objEmitirPedido.objfatvenda.fPossuiSomenteBrinde()) and (not objEmitirPedido.objfatvenda.fPossuiBrindeProduto());

                if blnSomenteBrindeServ and (objEmitirPedido.objfatvenda.fltTotGer = 0) and (not fCfgSis('PERBBS', varBoolean)) then
                Begin
                  pBaixaPedidoBrinde(FNumDocSer, 'PD', strCodEmp, 'DADOS BAIXA: ' + FormatDateTime('DD/MM/YYYY', VS_Date) + ' - ' +
                                                           FormatDateTime('HH:MM:SS', fRetHoraServidor)      + ' '   +
                                                           'OPE: ' + strLoginUsuarioLogado       + ' - ' +
                                                           fRetNomeOperador(strLoginUsuarioLogado)+ ' - ' +
                                                           'MOTIVO: ORIUNDO DE ORDEM DE SERVIÇO BRINDE.');
                end;
              end;

              pGravarDesmembramento(strSeqFgo, FAutInc, FGarant, 'S', FMulLoj);
            end;
          end;
        end
        else
        begin
          objEmitirPedido := TEmitirPedido.Create(Self);

          if (cdsIteEqu.RecordCount > 0) then
          begin
            {*** CARREGA PRODUTOS ***}
            if (not blnAtualizaPed) then
              strNumDoc := fGetNumPed(strEmpIte, FGarant, 'I');

            dadosPedido.fltDesEsp := fGerDesEsp;

            Result := fIniciaPedido(strNumDoc);

            if Result then
            begin
              Result := fCarregaDadosItem;
              strItePed := 'I';
            end;
          end
          else
          begin
            {*** CARREGA SERVIÇOS ***}
            if (not blnAtualizaPed) then
              strNumDoc := fGetNumPed(strEmpIte, FGarant, 'S');

            dadosPedido.fltDesEsp := 0;

            Result := fIniciaPedido(strNumDoc);

            if Result and ((not FMulLoj) or (FMulLoj and (FEmpSer = strEmpIte))) then
            begin
              recServicos := fCarregaRecServicos(strCliente, 'N');
              objEmitirPedido.fSetServicos(recServicos, IIF(FMulLoj, FEmpSer, ''));
              strItePed := 'S';
            end;
          end;

          if (cdsIteEqu.RecordCount > 0) or ((cdsSerEqu.RecordCount > 0) and (FEmpSer = strEmpIte)) then
          begin
            objEmitirPedido.fSetImprimeDocs(false);

            If Result Then
              Result := objEmitirPedido.fCalcularTotais And
                        objEmitirPedido.fValidarPedido  And
                        objEmitirPedido.fGravarPedido;

            if Result then
            begin
              pAdicionaDocumentoParaImpressao(objEmitirPedido.objFatVenda, strEmpLog, IIF(fEmptyStr(strEmpIte), strEmpLog, strEmpIte));
              strNumDoc := objEmitirPedido.fGetNumDoc;
              strSeqFgo := objEmitirPedido.fGetAutInc;

              if not fEmptyStr(strNumDoc) then
              begin
                pGravarOrdemMaoObraCli(strSeqFgo);

                if blnAtualizaPed then
                  pMarcaNumeroPedidoVenda(strNumDoc, False);

                pDefinirDtHrLibExp(FDtLbEx, FHrLbEx, FDtBxSe, FHrBxSe, strNumDoc, strCliente, FEmpPed, FOpBxSe);
                TTestabilidade.fGetTestabilidade.PedidoConsertoEquipamento := strNumDoc;
                blnSomenteBrindeServ := (objEmitirPedido.objfatvenda.fPossuiSomenteBrinde()) and (not objEmitirPedido.objfatvenda.fPossuiBrindeProduto());

                if blnSomenteBrindeServ and (objEmitirPedido.objfatvenda.fltTotGer = 0) and (not fCfgSis('PERBBS', varBoolean)) then
                Begin
                  pBaixaPedidoBrinde(strNumDoc, 'PD', strCodEmp, 'DADOS BAIXA: ' + FormatDateTime('DD/MM/YYYY', VS_Date) + ' - ' +
                                                           FormatDateTime('HH:MM:SS', fRetHoraServidor)      + ' '   +
                                                           'OPE: ' + strLoginUsuarioLogado       + ' - ' +
                                                           fRetNomeOperador(strLoginUsuarioLogado)+ ' - ' +
                                                           'MOTIVO: ORIUNDO DE ORDEM DE SERVIÇO BRINDE.');
                end;
              end;

              pGravarDesmembramento(strSeqFgo, FAutInc, FGarant, strItePed, FMulLoj);
            end;
          end;
        end;

        Result := fGravarPedidoAParte;
      end
      else
      begin
        objEmitirPedido := TEmitirPedido.Create(Self);

        if (not blnAtualizaPed) then
          strNumDoc := fGetNumPed(strEmpIte, FGarant, 'T');

        dadosPedido.fltDesEsp := fGerDesEsp;

        Result := fIniciaPedido(strNumDoc);

        if Result then
        begin
          Result      := fCarregaDadosItem;

          If Result Then
          Begin

            if (not FMulLoj) or (FMulLoj and (FEmpSer = strEmpIte)) then
            begin
              recServicos := fCarregaRecServicos(strCliente, 'N');
              objEmitirPedido.fSetServicos(recServicos, IIF(FMulLoj, FEmpSer, ''));
            end;

            objEmitirPedido.fSetImprimeDocs(false);

          End;

          If Result Then

            Result := objEmitirPedido.fCalcularTotais And
                      objEmitirPedido.fValidarPedido  And
                      objEmitirPedido.fGravarPedido;
        end;

        if Result then
        begin
          pAdicionaDocumentoParaImpressao(objEmitirPedido.objFatVenda, strEmpLog, IIF(fEmptyStr(strEmpIte), strEmpLog, strEmpIte));
          strNumDoc := objEmitirPedido.fGetNumDoc;
          strSeqFgo := objEmitirPedido.fGetAutInc;

          if not fEmptyStr(strNumDoc) then
          begin
            pGravarOrdemMaoObraCli(strSeqFgo);

            if blnAtualizaPed then
              pMarcaNumeroPedidoVenda(strNumDoc, False);

            pDefinirDtHrLibExp(FDtLbEx, FHrLbEx, FDtBxSe, FHrBxSe, strNumDoc, strCliente, FEmpPed, FOpBxSe);

            TTestabilidade.fGetTestabilidade.PedidoConsertoEquipamento := strNumDoc;

            blnSomenteBrindeServ := (objEmitirPedido.objfatvenda.fPossuiSomenteBrinde()) and (not objEmitirPedido.objfatvenda.fPossuiBrindeProduto());

            if blnSomenteBrindeServ and (objEmitirPedido.objfatvenda.fltTotGer = 0) and (not fCfgSis('PERBBS', varBoolean)) then
            Begin
              pBaixaPedidoBrinde(strNumDoc, 'PD', strCodEmp, 'DADOS BAIXA: ' + FormatDateTime('DD/MM/YYYY', VS_Date) + ' - ' +
                                                       FormatDateTime('HH:MM:SS', fRetHoraServidor)      + ' '   +
                                                       'OPE: ' + strLoginUsuarioLogado       + ' - ' +
                                                       fRetNomeOperador(strLoginUsuarioLogado)+ ' - ' +
                                                       'MOTIVO: ORIUNDO DE ORDEM DE SERVIÇO BRINDE.');
            end;
          end;

          if FCobApa or FMulLoj then
            pGravarDesmembramento(strSeqFgo, FAutInc, FGarant, 'T', FMulLoj);
        end;


        If (FCobAPa) Then
          Result := fGravarPedidoAParte;
      end;

    Except
      Result := False;
      raise;
    End;

  finally

    pSetaEmpresaLogada(strEmpLog);
    pSetarEmpresaItem(strEmpLog);
    pCarregaCobAParte;
    FCobApa := False;

    if Assigned(objEmitirPedido) then
      FreeAndNil(objEmitirPedido);

    if Assigned(dadosPedido.cdsProfiss) then
      FreeAndNil(dadosPedido.cdsProfiss);
  end;
end;

function TConEqu.fGerDesEsp: Double;
var
  cdsDados: TUniClientDataSet;
begin
  Result := 0;

  cdsDados := TUniClientDataSet.Create(Self);

  try
    pCloneDataSet(cdsDados, cdsIteEqu);

    cdsDados.Filtered := False;
    cdsDados.Filter   := cdsIteEqu.Filter;
    cdsDados.Filtered := True;

    cdsDados.First;

    while not cdsDados.Eof do
    begin
      Result := Result + cdsDados.FieldByName('DESESP').AsFloat;

      cdsDados.Next;
    end;
  finally
    FreeAndNil(cdsDados);
  end;
end;

function TConEqu.fGetNumPed(strEmpIte: String): String;
begin
  Result := '';

  if (fCfgSis('DESOSG', varBoolean)) and (FGarant = 'F') then
  begin
    Result := fGetNumPed(strEmpIte, FGarant, 'I');

    if not fEmptyStr(Result) then
      Exit;

    Result := fGetNumPed(strEmpIte, FGarant, 'S');

    if not fEmptyStr(Result) then
      Exit;

    Result := fGetNumPed(strEmpIte, 'C', 'T');
  end
  else
  begin
    Result := fGetNumPed(strEmpIte, FGarant, 'T');

    if not fEmptyStr(Result) then
      Exit;

    Result := fGetNumPed(strEmpIte, 'C', 'T');
  end;
end;

function TConEqu.fGetNumPed(strEmpIte, strGarant, strItePed: String): String;
var
  i: Integer;
begin
  Result := '';

  for I := Low(FArrPedidos) To High(FArrPedidos) do
  begin
    if (FArrPedidos[i].strNumPed <> FNumPed)
      and (FArrPedidos[i].strEmpIte = strEmpIte)
      and (FArrPedidos[i].strGarant = strGarant)
      and (FArrPedidos[i].strItePed = strItePed) then
    begin
      Result := FArrPedidos[i].strNumPed;
      Exit;
    end;
  end;
end;

procedure TConEqu.pAdicionarDadosFiscaisItem(recTriItem: TTribEquDet);
begin
  If (Not fEmptyStr(recTriItem.strCodIte)) Then Begin
    If (cdsIteEqu.Locate('CODITE;CLTRIB', VarArrayOf([recTriItem.strCodIte, 'N']), [])) Then Begin
      cdsIteEqu.Edit();
      cdsIteEqu.FieldByName('CLAFIS').AsString := recTriItem.strClaFis;
      cdsIteEqu.FieldByName('CODFIS').AsString := recTriItem.strCodFis;
      cdsIteEqu.FieldByName('INCPIS').AsString := recTriItem.strIncPis;
      cdsIteEqu.FieldByName('VALIPI').AsFloat  := recTriItem.fltValIpi;
      cdsIteEqu.FieldByName('ALQIPI').AsFloat  := recTriItem.fltAlqIpi;
      cdsIteEqu.FieldByName('BASIPI').AsFloat  := recTriItem.fltBasIpi;
      cdsIteEqu.FieldByName('VALICM').AsFloat  := recTriItem.fltValIcm;
      cdsIteEqu.FieldByName('ALQICM').AsFloat  := recTriItem.fltAlqIcm;
      cdsIteEqu.FieldByName('BASICM').AsFloat  := recTriItem.fltBasIcm;
      cdsIteEqu.FieldByName('VALRET').AsFloat  := recTriItem.fltValRet;
      cdsIteEqu.FieldByName('VALCBS').AsFloat  := recTriItem.fltValCbs;
      cdsIteEqu.FieldByName('VALIBS').AsFloat  := recTriItem.fltValIbs;
      cdsIteEqu.FieldByName('VAL_IS').AsFloat  := recTriItem.fltVal_Is;
      cdsIteEqu.FieldByName('ALQRET').AsFloat  := recTriItem.fltAlqRet;
      cdsIteEqu.FieldByName('BASRET').AsFloat  := recTriItem.fltBasRet;
      cdsIteEqu.FieldByName('PERBAS').AsFloat  := recTriItem.fltPerBas;
      cdsIteEqu.FieldByName('PERRED').AsFloat  := recTriItem.fltPerRed;
      cdsIteEqu.FieldByName('VLRCON').AsFloat  := recTriItem.fltVlrCon;
      cdsIteEqu.FieldByName('DESESP').AsFloat  := recTriItem.fltDesEsp;
      cdsIteEqu.FieldByName('CLTRIB').AsString := 'S';
      cdsIteEqu.Post();

      FValIpi := recTriItem.fltValIpi;
      FValRet := recTriItem.fltValRet;
      FValCbs := recTriItem.fltValCbs;
      FValIbs := recTriItem.fltValIbs;
      FVal_Is := recTriItem.fltVal_Is;
    End;
  End;
end;

procedure TConEqu.pAdicionarDadosFiscaisTotais(recTribOS: TTribEquGer);
begin
  FTribEquGer.fltBasSim := recTribOS.fltBasSim;
  FTribEquGer.fltBasIpi := recTribOS.fltBasIpi;
  FTribEquGer.fltAlqIpi := recTribOS.fltAlqIpi;
  FTribEquGer.fltTotIpi := recTribOS.fltTotIpi;
  FTribEquGer.fltBasIcm := recTribOS.fltBasIcm;
  FTribEquGer.fltAlqIcm := recTribOS.fltAlqIcm;
  FTribEquGer.fltTotIcm := recTribOS.fltTotIcm;
  FTribEquGer.fltTotRet := recTribOS.fltTotRet;
  FTribEquGer.fltTotCbs := recTribOS.fltTotCbs;
  FTribEquGer.fltTotIbs := recTribOS.fltTotIbs;
  FTribEquGer.fltTotIs  := recTribOS.fltTotIs;
  FTribEquGer.fltAlqRet := recTribOS.fltAlqRet;
  FTribEquGer.fltBasRet := recTribOS.fltBasRet;
  FTribEquGer.fltPerIss := recTribOS.fltPerIss;
  FTribEquGer.fltValIss := recTribOS.fltValIss;
  FTribEquGer.fltBasIss := recTribOS.fltBasIss;
  FTribEquGer.fltRedIss := recTribOS.fltRedIss;
end;

function TConEqu.fAcessorioJaInclusoGrid(strCodAce: String): Boolean;
begin
  Result := False;

  If fEmptyStr(strCodAce) Then
    Exit;

  If Assigned(cdsAceEqu) Then
  Begin
    cdsAceEqu.First;

    While Not cdsAceEqu.Eof Do
    Begin
      If (cdsAceEqu.FieldByName('CODACE').AsString = strCodAce) Then
      Begin
        Result := True;
        Exit;
      End;

      cdsAceEqu.Next;
    End;
  End;
end;

function TConEqu.fAdicionarObservacao(strMensagem: String): Boolean;
  Var
    qryAux: TUniQuery;
begin
  Result := False;

  If fEmptyStr(strMensagem) Then
    Exit;

  Try
    fStartTransaction;
    qryAux := fCriaQuery(Self);

    With qryAux Do
    Begin
      SQL.Clear;
      SQL.Add(' INSERT INTO EQUOBS (');
      SQL.Add('   AUTOINCREM, ');
      SQL.Add('   EQU_SEQGER, ');
      SQL.Add('   EQU_CODEMP, ');
      SQL.Add('   EQU_DTAENT, ');
      SQL.Add('   EQU_HORENT, ');
      SQL.Add('   EQU_OBSERV) ');
      SQL.Add(' VALUES (      ');
      SQL.Add('   :AUTINC,    ');
      SQL.Add('   :SEQGER,    ');
      SQL.Add('   :CODEMP,    ');
      SQL.Add('   :DTAENT,    ');
      SQL.Add('   :HORENT,    ');
      SQL.Add('   :OBSERV)    ');

      ParamByName('AUTINC').AsString   := fRetAutoIncrem('EQUOBS', VS_strCodEmp);
      ParamByName('SEQGER').AsString   := FAutInc;
      ParamByName('CODEMP').AsString   := VS_strCodEmp;
      ParamByName('DTAENT').AsDatetime := VS_date;
      ParamByName('HORENT').AsDatetime := fTime();
      ParamByName('OBSERV').AsString   := strMensagem;

      ExecSQL;

      Result := True;
    End;

  Finally
    If Result Then
      fCommit
    Else
      fRollback;
  End;

  FreeAndNil(qryAux);
end;

procedure TConEqu.pAtualizarDadosServicosFatVenda(Var recServicos: TDadosServicos);
  Var
    prcScroll: TprcScroll;
begin
  recServicos.fltValS01 := 0.0;
  recServicos.fltValS02 := 0.0;
  recServicos.fltValS03 := 0.0;
  recServicos.fltValS04 := 0.0;
  recServicos.fltValS05 := 0.0;
  recServicos.fltValS06 := 0.0;
  recServicos.fltValS07 := 0.0;
  recServicos.fltValS08 := 0.0;
  recServicos.fltValS09 := 0.0;
  recServicos.fltValS10 := 0.0;
  recServicos.fltValS11 := 0.0;
  recServicos.fltValS12 := 0.0;
  recServicos.fltValS13 := 0.0;
  recServicos.fltValS14 := 0.0;
  recServicos.fltValS15 := 0.0;
  recServicos.fltValS16 := 0.0;
  recServicos.fltValS17 := 0.0;
  recServicos.fltValS18 := 0.0;
  recServicos.fltValS19 := 0.0;
  recServicos.fltValS20 := 0.0;
  recServicos.fltValS21 := 0.0;
  recServicos.fltValS22 := 0.0;
  recServicos.fltValS23 := 0.0;
  recServicos.fltValS24 := 0.0;
  recServicos.fltValS25 := 0.0;
  recServicos.fltValS26 := 0.0;
  recServicos.fltValS27 := 0.0;
  recServicos.fltValS28 := 0.0;
  recServicos.fltValS29 := 0.0;
  recServicos.fltValS30 := 0.0;

  Try
    pDisableControls(cdsSerEqu, prcScroll);

    With cdsSerEqu Do Begin

      First;

      If Not IsEmpty Then Begin
        recServicos.strCodS01 := fieldbyname('CODSER').AsString;
        recServicos.strDesS01 := fieldbyname('DESSER').AsString;
        recServicos.fltQtdS01 := fieldbyname('QTDSER').AsFloat;
        recServicos.fltUniS01 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
        recServicos.fltValS01 := fieldbyname('VALSER').AsFloat;
        recServicos.strBriS01 := fieldbyname('BRINDE').AsString;
        recServicos.strParS01 := fieldbyname('CODPAR').AsString;
        recServicos.strTBrS01 := fieldbyname('TIPBRI').AsString;
        recServicos.strMecS01 := fieldbyname('TECSER').AsString;
        recServicos.strVenS01 := fieldbyname('TECSER').AsString;
        recServicos.strIdeS01 := 'S';
        Next;

        If RecordCount > 1 Then Begin
          recServicos.strCodS02 := fieldbyname('CODSER').AsString;
          recServicos.strDesS02 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS02 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS02 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS02 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS02 := fieldbyname('BRINDE').AsString;
          recServicos.strParS02 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS02 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS02 := fieldbyname('TECSER').AsString;
          recServicos.strVenS02 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS02 := 'S';
          Next;
        End;

        If RecordCount > 2 Then Begin
          recServicos.strCodS03 := fieldbyname('CODSER').AsString;
          recServicos.strDesS03 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS03 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS03 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS03 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS03 := fieldbyname('BRINDE').AsString;
          recServicos.strParS03 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS03 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS03 := fieldbyname('TECSER').AsString;
          recServicos.strVenS03 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS03 := 'S';
          Next;
        End;

        If RecordCount > 3 Then Begin
          recServicos.strCodS04 := fieldbyname('CODSER').AsString;
          recServicos.strDesS04 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS04 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS04 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS04 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS04 := fieldbyname('BRINDE').AsString;
          recServicos.strParS04 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS04 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS04 := fieldbyname('TECSER').AsString;
          recServicos.strVenS04 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS04 := 'S';
          Next;
        End;

        If RecordCount > 4 Then Begin
          recServicos.strCodS05 := fieldbyname('CODSER').AsString;
          recServicos.strDesS05 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS05 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS05 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS05 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS05 := fieldbyname('BRINDE').AsString;
          recServicos.strParS05 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS05 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS05 := fieldbyname('TECSER').AsString;
          recServicos.strVenS05 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS05 := 'S';
          Next;
        End;

        If RecordCount > 5 Then Begin
          recServicos.strCodS06 := fieldbyname('CODSER').AsString;
          recServicos.strDesS06 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS06 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS06 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS06 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS06 := fieldbyname('BRINDE').AsString;
          recServicos.strParS06 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS06 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS06 := fieldbyname('TECSER').AsString;
          recServicos.strVenS06 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS06 := 'S';
          Next;
        End;

        If RecordCount > 6 Then Begin
          recServicos.strCodS07 := fieldbyname('CODSER').AsString;
          recServicos.strDesS07 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS07 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS07 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS07 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS07 := fieldbyname('BRINDE').AsString;
          recServicos.strParS07 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS07 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS07 := fieldbyname('TECSER').AsString;
          recServicos.strVenS07 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS07 := 'S';
          Next;
        End;

        If RecordCount > 7 Then Begin
          recServicos.strCodS08 := fieldbyname('CODSER').AsString;
          recServicos.strDesS08 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS08 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS08 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS08 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS08 := fieldbyname('BRINDE').AsString;
          recServicos.strParS08 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS08 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS08 := fieldbyname('TECSER').AsString;
          recServicos.strVenS08 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS08 := 'S';
          Next;
        End;

        If RecordCount > 8 Then Begin
          recServicos.strCodS09 := fieldbyname('CODSER').AsString;
          recServicos.strDesS09 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS09 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS09 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS09 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS09 := fieldbyname('BRINDE').AsString;
          recServicos.strParS09 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS09 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS09 := fieldbyname('TECSER').AsString;
          recServicos.strVenS09 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS09 := 'S';
          Next;
        End;

        If RecordCount > 9 Then Begin
          recServicos.strCodS10 := fieldbyname('CODSER').AsString;
          recServicos.strDesS10 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS10 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS10 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS10 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS10 := fieldbyname('BRINDE').AsString;
          recServicos.strParS10 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS10 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS10 := fieldbyname('TECSER').AsString;
          recServicos.strVenS10 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS10 := 'S';
          Next;
        End;

        If RecordCount > 10 Then Begin
          recServicos.strCodS11 := fieldbyname('CODSER').AsString;
          recServicos.strDesS11 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS11 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS11 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS11 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS11 := fieldbyname('BRINDE').AsString;
          recServicos.strParS11 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS11 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS11 := fieldbyname('TECSER').AsString;
          recServicos.strVenS11 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS11 := 'S';
          Next;
        End;

        If RecordCount > 11 Then Begin
          recServicos.strCodS12 := fieldbyname('CODSER').AsString;
          recServicos.strDesS12 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS12 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS12 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS12 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS12 := fieldbyname('BRINDE').AsString;
          recServicos.strParS12 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS12 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS12 := fieldbyname('TECSER').AsString;
          recServicos.strVenS12 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS12 := 'S';
          Next;
        End;

        If RecordCount > 12 Then Begin
          recServicos.strCodS13 := fieldbyname('CODSER').AsString;
          recServicos.strDesS13 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS13 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS13 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS13 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS13 := fieldbyname('BRINDE').AsString;
          recServicos.strParS13 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS13 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS13 := fieldbyname('TECSER').AsString;
          recServicos.strVenS13 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS13 := 'S';
          Next;
        End;

        If RecordCount > 13 Then Begin
          recServicos.strCodS14 := fieldbyname('CODSER').AsString;
          recServicos.strDesS14 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS14 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS14 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS14 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS14 := fieldbyname('BRINDE').AsString;
          recServicos.strParS14 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS14 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS14 := fieldbyname('TECSER').AsString;
          recServicos.strVenS14 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS14 := 'S';
          Next;
        End;

        If RecordCount > 14 Then Begin
          recServicos.strCodS15 := fieldbyname('CODSER').AsString;
          recServicos.strDesS15 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS15 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS15 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS15 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS15 := fieldbyname('BRINDE').AsString;
          recServicos.strParS15 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS15 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS15 := fieldbyname('TECSER').AsString;
          recServicos.strVenS15 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS15 := 'S';
          Next;
        End;

        If RecordCount > 15 Then Begin
          recServicos.strCodS16 := fieldbyname('CODSER').AsString;
          recServicos.strDesS16 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS16 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS16 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS16 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS16 := fieldbyname('BRINDE').AsString;
          recServicos.strParS16 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS16 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS16 := fieldbyname('TECSER').AsString;
          recServicos.strVenS16 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS16 := 'S';
          Next;
        End;

        If RecordCount > 16 Then Begin
          recServicos.strCodS17 := fieldbyname('CODSER').AsString;
          recServicos.strDesS17 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS17 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS17 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS17 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS17 := fieldbyname('BRINDE').AsString;
          recServicos.strParS17 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS17 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS17 := fieldbyname('TECSER').AsString;
          recServicos.strVenS17 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS17 := 'S';
          Next;
        End;

        If RecordCount > 17 Then Begin
          recServicos.strCodS18 := fieldbyname('CODSER').AsString;
          recServicos.strDesS18 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS18 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS18 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS18 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS18 := fieldbyname('BRINDE').AsString;
          recServicos.strParS18 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS18 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS18 := fieldbyname('TECSER').AsString;
          recServicos.strVenS18 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS18 := 'S';
          Next;
        End;

        If RecordCount > 18 Then Begin
          recServicos.strCodS19 := fieldbyname('CODSER').AsString;
          recServicos.strDesS19 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS19 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS19 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS19 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS19 := fieldbyname('BRINDE').AsString;
          recServicos.strParS19 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS19 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS19 := fieldbyname('TECSER').AsString;
          recServicos.strVenS19 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS19 := 'S';
          Next;
        End;

        If RecordCount > 19 Then Begin
          recServicos.strCodS20 := fieldbyname('CODSER').AsString;
          recServicos.strDesS20 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS20 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS20 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS20 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS20 := fieldbyname('BRINDE').AsString;
          recServicos.strParS20 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS20 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS20 := fieldbyname('TECSER').AsString;
          recServicos.strVenS20 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS20 := 'S';
          Next;
        End;

        If RecordCount > 20 Then Begin
          recServicos.strCodS21 := fieldbyname('CODSER').AsString;
          recServicos.strDesS21 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS21 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS21 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS21 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS21 := fieldbyname('BRINDE').AsString;
          recServicos.strParS21 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS21 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS21 := fieldbyname('TECSER').AsString;
          recServicos.strVenS21 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS21 := 'S';
          Next;
        End;

        If RecordCount > 21 Then Begin
          recServicos.strCodS22 := fieldbyname('CODSER').AsString;
          recServicos.strDesS22 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS22 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS22 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS22 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS22 := fieldbyname('BRINDE').AsString;
          recServicos.strParS22 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS22 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS22 := fieldbyname('TECSER').AsString;
          recServicos.strVenS22 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS22 := 'S';
          Next;
        End;

        If RecordCount > 22 Then Begin
          recServicos.strCodS23 := fieldbyname('CODSER').AsString;
          recServicos.strDesS23 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS23 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS23 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS23 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS23 := fieldbyname('BRINDE').AsString;
          recServicos.strParS23 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS23 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS23 := fieldbyname('TECSER').AsString;
          recServicos.strVenS23 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS23 := 'S';
          Next;
        End;

        If RecordCount > 23 Then Begin
          recServicos.strCodS24 := fieldbyname('CODSER').AsString;
          recServicos.strDesS24 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS24 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS24 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS24 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS24 := fieldbyname('BRINDE').AsString;
          recServicos.strParS24 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS24 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS24 := fieldbyname('TECSER').AsString;
          recServicos.strVenS24 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS24 := 'S';
          Next;
        End;

        If RecordCount > 24 Then Begin
          recServicos.strCodS25 := fieldbyname('CODSER').AsString;
          recServicos.strDesS25 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS25 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS25 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS25 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS25 := fieldbyname('BRINDE').AsString;
          recServicos.strParS25 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS25 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS25 := fieldbyname('TECSER').AsString;
          recServicos.strVenS25 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS25 := 'S';
          Next;
        End;

        If RecordCount > 25 Then Begin
          recServicos.strCodS26 := fieldbyname('CODSER').AsString;
          recServicos.strDesS26 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS26 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS26 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS26 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS26 := fieldbyname('BRINDE').AsString;
          recServicos.strParS26 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS26 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS26 := fieldbyname('TECSER').AsString;
          recServicos.strVenS26 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS26 := 'S';
          Next;
        End;

        If RecordCount > 26 Then Begin
          recServicos.strCodS27 := fieldbyname('CODSER').AsString;
          recServicos.strDesS27 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS27 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS27 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS27 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS27 := fieldbyname('BRINDE').AsString;
          recServicos.strParS27 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS27 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS27 := fieldbyname('TECSER').AsString;
          recServicos.strVenS27 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS27 := 'S';
          Next;
        End;

        If RecordCount > 27 Then Begin
          recServicos.strCodS28 := fieldbyname('CODSER').AsString;
          recServicos.strDesS28 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS28 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS28 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS28 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS28 := fieldbyname('BRINDE').AsString;
          recServicos.strParS28 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS28 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS28 := fieldbyname('TECSER').AsString;
          recServicos.strVenS28 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS28 := 'S';
          Next;
        End;

        If RecordCount > 28 Then Begin
          recServicos.strCodS29 := fieldbyname('CODSER').AsString;
          recServicos.strDesS29 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS29 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS29 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS29 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS29 := fieldbyname('BRINDE').AsString;
          recServicos.strParS29 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS29 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS29 := fieldbyname('TECSER').AsString;
          recServicos.strVenS29 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS29 := 'S';
          Next;
        End;

        If RecordCount > 29 Then Begin
          recServicos.strCodS30 := fieldbyname('CODSER').AsString;
          recServicos.strDesS30 := fieldbyname('DESSER').AsString;
          recServicos.fltQtdS30 := fieldbyname('QTDSER').AsFloat;
          recServicos.fltUniS30 := fieldbyname('VALSER').AsFloat / fieldbyname('QTDSER').AsFloat;
          recServicos.fltValS30 := fieldbyname('VALSER').AsFloat;
          recServicos.strBriS30 := fieldbyname('BRINDE').AsString;
          recServicos.strParS30 := fieldbyname('CODPAR').AsString;
          recServicos.strTBrS30 := fieldbyname('TIPBRI').AsString;
          recServicos.strMecS30 := fieldbyname('TECSER').AsString;
          recServicos.strVenS30 := fieldbyname('TECSER').AsString;
          recServicos.strIdeS30 := 'S';
        End;
      End;
    End;
  Finally
    pEnableControls(cdsSerEqu, prcScroll);
  End
end;

procedure TConEqu.pBaixaPedidoBrinde(strNumDoc, strEspDoc, strCodEmp, strMotAju: String);
var
  qryUpdate: TUniQuery;
begin
  qryUpdate := fCriaQuery(Nil);

  try
    qryUpdate.SQL.Add('UPDATE                     ');
    qryUpdate.SQL.Add('  FATGOR                   ');
    qryUpdate.SQL.Add('SET                        ');
    qryUpdate.SQL.Add('  FGO_JAFATU = 1,          ');
    qryUpdate.SQL.Add('  FGO_MOTBAI = :MOTBAI     ');
    qryUpdate.SQL.Add('WHERE                      ');
    qryUpdate.SQL.Add('  FGO_NUMDOC = :NUMDOC AND ');
    qryUpdate.SQL.Add('  FGO_ESPDOC = :ESPDOC AND ');
    qryUpdate.SQL.Add('  FGO_CODEMP = :CODEMP     ');
    qryUpdate.ParamByName('MOTBAI').AsString := strMotAju;
    qryUpdate.ParamByName('NUMDOC').AsString := strNumDoc;
    qryUpdate.ParamByName('ESPDOC').AsString := strEspDoc;
    qryUpdate.ParamByName('CODEMP').AsString := strCodEmp;
    qryUpdate.ExecSQL;

    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add('UPDATE                     ');
    qryUpdate.SQL.Add('  FATDOR                   ');
    qryUpdate.SQL.Add('SET                        ');
    qryUpdate.SQL.Add('  FDO_JAFATU = 1           ');
    qryUpdate.SQL.Add('WHERE                      ');
    qryUpdate.SQL.Add('  FDO_NUMDOC = :NUMDOC AND ');
    qryUpdate.SQL.Add('  FDO_ESPDOC = :ESPDOC AND ');
    qryUpdate.SQL.Add('  FDO_CODEMP = :CODEMP     ');
    qryUpdate.ParamByName('NUMDOC').AsString := strNumDoc;
    qryUpdate.ParamByName('ESPDOC').AsString := strEspDoc;
    qryUpdate.ParamByName('CODEMP').AsString := strCodEmp;
    qryUpdate.ExecSQL;
  finally
    FreeAndNil(qryUpdate);
  end;
end;

procedure TConEqu.pLimparDadosFiscaisTotais;
begin
  FTribEquGer.fltBasSim := 0;
  FTribEquGer.fltBasIpi := 0;
  FTribEquGer.fltAlqIpi := 0;
  FTribEquGer.fltTotIpi := 0;
  FTribEquGer.fltBasIcm := 0;
  FTribEquGer.fltAlqIcm := 0;
  FTribEquGer.fltTotIcm := 0;
  FTribEquGer.fltTotRet := 0;
  FTribEquGer.fltTotCbs := 0;
  FTribEquGer.fltTotIbs := 0;
  FTribEquGer.fltTotIs  := 0;
  FTribEquGer.fltAlqRet := 0;
  FTribEquGer.fltBasRet := 0;
  FTribEquGer.fltPerIss := 0;
  FTribEquGer.fltValIss := 0;
  FTribEquGer.fltBasIss := 0;
  FTribEquGer.fltRedIss := 0;
end;

class function TConEqu.VerificaPedidoComRequisicaoEmAbertoComPedidoDeCompra(strNumDoc, strEspDoc, strCodEmp : String; out strCodRcd, strEmpRcd: String; out blnLiberouTrava: Boolean; blnTravar: Boolean = True; strCodIte: String = ''): Boolean;
var
  LQry: TUniQuery;
  LIdx: Integer;
  LNota: String;
  LNotas: TStrings;
  objLiberacao: TLiberacao;
begin
  strCodRcd := '';
  strEmpRcd := '';
  blnLiberouTrava := False;

  LQry := fCriaQuery();
  LNotas := TStringList.Create();
  objLiberacao := TLiberacao.Create;

  Try
    LQry.SQL.Add('SELECT SQL_NO_CACHE                              ');
    LQry.SQL.Add('  CONCAT(F.FDO_CODCLI, "-", C.CLI_NOMCLI) AS NOMCLI,');
    LQry.SQL.Add('  CONCAT(F.FDO_CODVEN, "-", O.OPE_NOMOPE) AS NOMVEN,');
    LQry.SQL.Add('  CONCAT(F.FDO_NUMDOC, "-", F.FDO_ESPDOC, "-", F.FDO_CODEMP) AS PEDVEN,');
    LQry.SQL.Add('  F.FDO_DTAENT AS DTAENT,                        ');
    LQry.SQL.Add('  CONCAT(F.FDO_CODITE, "-", F.FDO_DESCRI) AS DESITE,');
    LQry.SQL.Add('  U.UNI_SIGUNI AS UNIDAD,                        ');
    LQry.SQL.Add('  F.FDO_QTDITE AS QTDITE,                        ');
    LQry.SQL.Add('  CONCAT(M.RCD_CODIGO, "-", M.RCD_CODEMP) AS NUMREQ,');
    LQry.SQL.Add('  M.RCD_CODIGO, M.RCD_CODEMP,                    ');
    LQry.SQL.Add('  M.RCD_QTDITE AS QTDREQ,                        ');
    LQry.SQL.Add('  (SELECT IFNULL(SUM(BAI_QTDREQ), 0) FROM BAIREQ WHERE BAI_AUTREQ = M.AUTOINCREM) AS QTDBAI,');
    LQry.SQL.Add('  CONCAT(P.PCD_NUMPED, "-", P.PCD_ESPDOC, "-", P.PCD_CODEMP) AS NUMCOM,');
    LQry.SQL.Add('  P.PCD_DTAENT AS DTAENT,                        ');
    LQry.SQL.Add('  (SELECT GROUP_CONCAT(CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP))');
    LQry.SQL.Add('     FROM BAIREQ                                 ');
    LQry.SQL.Add('    INNER JOIN MOVDET D ON D.AUTOINCREM = BAI_AUTDET');
    LQry.SQL.Add('    WHERE BAI_AUTREQ = M.AUTOINCREM) AS NOTAS,   ');
    LQry.SQL.Add('  C.CLI_C_G_C_ ');
    LQry.SQL.Add('   FROM FATDOR F ');

    if fCfgSis('SLTFRC', varBoolean) then
    begin
      LQry.SQL.Add(' JOIN FDOABS A ON F.AUTOINCREM = A.ABS_SEQFDO ');
      LQry.SQL.Add(' JOIN PREPRQ Q ON A.ABS_SEQPRQ = Q.AUTOINCREM ');
    end;

    LQry.SQL.Add('  JOIN CADCLI C ON C.CLI_CODCLI = F.FDO_CODCLI ');
    LQry.SQL.Add('  JOIN MOVRCD M ON F.FDO_NUMDOC = M.RCD_DOCPDV ');
    LQry.SQL.Add('               AND F.FDO_ESPDOC = M.RCD_ESPPDV ');
    LQry.SQL.Add('               AND F.FDO_CODEMP = M.RCD_EMPPDV ');
    LQry.SQL.Add('               AND F.FDO_CODITE = M.RCD_CODITE ');
    LQry.SQL.Add('  LEFT JOIN CADUNI U ON F.FDO_UNIDAD = U.UNI_CODUNI');
    LQry.SQL.Add('  LEFT JOIN CADOPE O ON O.OPE_CODOPE = F.FDO_CODVEN');
    LQry.SQL.Add('  INNER JOIN PCMDET P ON P.AUTOINCREM = RCD_SEQPCD');
    LQry.SQL.Add(' WHERE F.FDO_NUMDOC = :NUMDOC                    ');
    LQry.SQL.Add('   AND F.FDO_ESPDOC = :ESPDOC                    ');
    LQry.SQL.Add('   AND F.FDO_CODEMP = :CODEMP                    ');
    LQry.SQL.Add('   AND IFNULL(PCD_BAIXAD, 0) = 0                 ');
    LQry.SQL.Add('   AND RCD_REQNEG <> "S"                         ');

    if (not fEmptyStr(strCodIte)) then
      LQry.SQL.Add('   AND F.FDO_CODITE = :CODITE                  ');

    LQry.ParamByName('NUMDOC').AsString := strNumDoc;
    LQry.ParamByName('ESPDOC').AsString := strEspDoc;
    LQry.ParamByName('CODEMP').AsString := strCodEmp;

    if (not fEmptyStr(strCodIte)) then
      LQry.ParamByName('CODITE').AsString := strCodIte;

    LQry.Open();

    Result := (Not LQry.IsEmpty);

    If Result and blnTravar Then
    Begin
      strCodRcd := LQry.FieldByName('RCD_CODIGO').AsString;
      strEmpRcd := LQry.FieldByName('RCD_CODEMP').AsString;

      objLiberacao.Clear();
      objLiberacao.strMsgSen := 'LIBERAÇÃO DE PEDIDO VINCULADO A REQUISIÇÃO DE COMPRA COMPRADA POR PEDIDO DE COMPRA';
      objLiberacao.objMsgLibera.pAddTexto(objLiberacao.strMsgSen);

      objLiberacao.objMsgLibera.pAddSeparador(162);
      objLiberacao.objMsgLibera.pAddTextoCaption('Cliente'      , LQry.FieldByName('NOMCLI').AsString, 13);
      objLiberacao.objMsgLibera.pAddTextoCaption('ClCPF/CNPJ:'  , fFormataCpfCgc(LQry.FieldByName('CLI_C_G_C_').AsString, fSetaPais), 13);
      objLiberacao.objMsgLibera.pAddTextoCaption('Vendedor'     , LQry.FieldByName('NOMVEN').AsString, 13);
      objLiberacao.objMsgLibera.pAddSeparador(162);
      objLiberacao.objMsgLibera.pAddTextoCaption('Pedido Venda' , LQry.FieldByName('PEDVEN').AsString, 13);
      objLiberacao.objMsgLibera.pAddSeparador(162);
      objLiberacao.objMsgLibera.pAddTexto(fPadR('PRODUTO', 42) + ' | UN | QTD.PEDIDO | REQUISICAO | QTD.REQUISICAO | QTD.BAIXADA | ' +
                                          fPadR('PED.COMPRA', 20) + ' | DT.ENTREGA | NOTA ENTRADA', alEsquerda, teAmbos, '', 162);
      objLiberacao.objMsgLibera.pAddSeparador(162);

      While (Not LQry.Eof) Do
      Begin
        LNotas.Clear();
        ExtractStrings([','], [' '], pChar(LQry.FieldByName('NOTAS').AsString), LNotas);

        If (LNotas.Count > 0) Then
          LNota := LNotas[0];

        objLiberacao.objMsgLibera.pAddTexto(
          Concat(fPadR(LQry.FieldByName('DESITE').AsString, 42), ' | ',
            LQry.FieldByName('UNIDAD').AsString, ' | ',
            fPadL(FloatToStrF(LQry.FieldByName('QTDITE').AsFloat, ffFixed, 10, 2), 10), ' | ',
            LQry.FieldByName('NUMREQ').AsString, ' | ',
            fPadL(FloatToStrF(LQry.FieldByName('QTDREQ').AsFloat, ffFixed, 13, 2), 14), ' | ',
            fPadL(FloatToStrF(LQry.FieldByName('QTDBAI').AsFloat, ffFixed, 11, 2), 11), ' | ',
            fPadR(LQry.FieldByName('NUMCOM').AsString, 20), ' | ',
            LQry.FieldByName('DTAENT').AsString, ' | ',
            LNota), alEsquerda, teAmbos, '', 162);

        For LIdx := 1 To Pred(LNotas.Count) Do
          objLiberacao.objMsgLibera.pAddTexto(fPadL(LNotas[LIdx], 162), alEsquerda, teAmbos, '', 162);

        LQry.Next();
      End;

      objLiberacao.objMsgLibera.pAddSeparador(162);
      objLiberacao.strDirAce := 'BPRQPC';
      objLiberacao.blnTraTel := True;
      objLiberacao.strSenLib := '';
      objLiberacao.blnMosMen := True;
      objLiberacao.strCodOpe := strLoginUsuarioLogado;
      objLiberacao.strCodDig := '';

      blnLiberouTrava := objLiberacao.fLibera;
    End;
  Finally
    LNotas.Free();
    FreeAndNil(LQry);
    FreeAndNil(objLiberacao);
  End;
End;

class function TConEqu.VerificaPedidoComRequisicaoEmAbertoSemPedidoDeCompra(strNumDoc, strEspDoc, strCodEmp : String; out strCodRcd, strEmpRcd: String; strCodIte: String = ''): Boolean;
var
  LQry: TUniQuery;
begin
  strCodRcd := '';
  strEmpRcd := '';

  LQry := fCriaQuery();

  Try
    LQry.SQL.Add('SELECT SQL_NO_CACHE                              ');
    LQry.SQL.Add('  CONCAT(F.FDO_CODCLI, "-", C.CLI_NOMCLI) AS NOMCLI,');
    LQry.SQL.Add('  CONCAT(F.FDO_CODVEN, "-", O.OPE_NOMOPE) AS NOMVEN,');
    LQry.SQL.Add('  CONCAT(F.FDO_NUMDOC, "-", F.FDO_ESPDOC, "-", F.FDO_CODEMP) AS PEDVEN,');
    LQry.SQL.Add('  F.FDO_DTAENT AS DTAENT,                        ');
    LQry.SQL.Add('  CONCAT(F.FDO_CODITE, "-", F.FDO_DESCRI) AS DESITE,');
    LQry.SQL.Add('  U.UNI_SIGUNI AS UNIDAD,                        ');
    LQry.SQL.Add('  F.FDO_QTDITE AS QTDITE,                        ');
    LQry.SQL.Add('  M.RCD_CODIGO AS NUMREQ,                        ');
    LQry.SQL.Add('  M.RCD_CODIGO, M.RCD_CODEMP,                    ');
    LQry.SQL.Add('  M.RCD_QTDITE AS QTDREQ,                        ');
    LQry.SQL.Add('  (SELECT IFNULL(SUM(BAI_QTDREQ), 0) FROM BAIREQ WHERE BAI_AUTREQ = M.AUTOINCREM) AS QTDBAI,');
    LQry.SQL.Add('  CONCAT(P.PCD_NUMPED, "-", P.PCD_ESPDOC, "-", P.PCD_CODEMP) AS NUMCOM,');
    LQry.SQL.Add('  P.PCD_DTAENT AS DTAENT,                        ');
    LQry.SQL.Add('  (SELECT GROUP_CONCAT(CONCAT(DET_NUMDOC, "-", DET_ESPDOC, "-", DET_CODEMP))');
    LQry.SQL.Add('     FROM BAIREQ                                 ');
    LQry.SQL.Add('    INNER JOIN MOVDET D ON D.AUTOINCREM = BAI_AUTDET');
    LQry.SQL.Add('    WHERE BAI_AUTREQ = M.AUTOINCREM) AS NOTAS    ');
    LQry.SQL.Add('   FROM FATDOR F  ');

    if fCfgSis('SLTFRC', varBoolean) then
    begin
      LQry.SQL.Add(' JOIN FDOABS A ON F.AUTOINCREM = A.ABS_SEQFDO ');
      LQry.SQL.Add(' JOIN PREPRQ Q ON A.ABS_SEQPRQ = Q.AUTOINCREM ');
    end;

    LQry.SQL.Add('  JOIN CADCLI C ON C.CLI_CODCLI = F.FDO_CODCLI   ');
    LQry.SQL.Add('  JOIN MOVRCD M ON F.FDO_NUMDOC = M.RCD_DOCPDV ');
    LQry.SQL.Add('               AND F.FDO_ESPDOC = M.RCD_ESPPDV ');
    LQry.SQL.Add('               AND F.FDO_CODEMP = M.RCD_EMPPDV ');
    LQry.SQL.Add('               AND F.FDO_CODITE = M.RCD_CODITE ');
    LQry.SQL.Add('  LEFT JOIN CADUNI U ON F.FDO_UNIDAD = U.UNI_CODUNI');
    LQry.SQL.Add('  LEFT JOIN CADOPE O ON O.OPE_CODOPE = F.FDO_CODVEN');
    LQry.SQL.Add('  LEFT JOIN PCMDET P ON P.AUTOINCREM = RCD_SEQPCD');
    LQry.SQL.Add(' WHERE F.FDO_NUMDOC = :NUMDOC                    ');
    LQry.SQL.Add('   AND F.FDO_ESPDOC = :ESPDOC                    ');
    LQry.SQL.Add('   AND F.FDO_CODEMP = :CODEMP                    ');
    LQry.SQL.Add('   AND IFNULL(PCD_BAIXAD, 0) = 0                 ');
    LQry.SQL.Add('   AND RCD_REQNEG <> "S" AND P.PCD_NUMPED IS NULL ');

    if (not fEmptyStr(strCodIte)) then
      LQry.SQL.Add('   AND F.FDO_CODITE = :CODITE                  ');

    LQry.ParamByName('NUMDOC').AsString := strNumDoc;
    LQry.ParamByName('ESPDOC').AsString := strEspDoc;
    LQry.ParamByName('CODEMP').AsString := strCodEmp;

    if (not fEmptyStr(strCodIte)) then
      LQry.ParamByName('CODITE').AsString := strCodIte;

    LQry.Open();

    Result := (Not LQry.IsEmpty);

    if Result then
    begin
      strCodRcd := LQry.FieldByName('RCD_CODIGO').AsString;
      strEmpRcd := LQry.FieldByName('RCD_CODEMP').AsString;
    end;
  Finally
    FreeAndNil(LQry);
  End;
End;

function TConEqu.fQtdTotItem: Double;
var
  LCds: TUniClientDataSet;
Begin
  LCds := TUniClientDataSet.Create(Self);
  try
    pCloneDataSet(LCds, cdsIteEqu);
    LCds.First;
    Result := 0;
    While Not LCds.Eof Do
    Begin
      If LCds.FieldByName('CODITE').AsString = cdsIteEqu.fieldbyname('CODITE').AsString Then
        Result := Result + LCds.FieldByName('QTDITE').AsFloat;

      LCds.Next;
    End;
  finally
    FreeAndNil(LCds);
  end;
End;

function TConEqu.fPodeExcluirItemRequsicaoCompra: Boolean;
var
  strSQL: String;
  qryAux: TUniQuery;
  fltQtdTot: Double;
  fltQtdDel: Double;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT                              ';
  strSQL := strSQL + '   RCD_CODIGO,                       ';
  strSQL := strSQL + '   GROUP_CONCAT(                     ';
  strSQL := strSQL + '     COT_NUMCOT                      ';
  strSQL := strSQL + '   ) AS COTACOES,                    ';
  strSQL := strSQL + '   GROUP_CONCAT(                     ';
  strSQL := strSQL + '     CONCAT(                         ';
  strSQL := strSQL + '       PCD_NUMPED,                   ';
  strSQL := strSQL + '       "-",                          ';
  strSQL := strSQL + '       PCD_ESPDOC,                   ';
  strSQL := strSQL + '       "-",                          ';
  strSQL := strSQL + '       PCD_CODEMP                    ';
  strSQL := strSQL + '     )                               ';
  strSQL := strSQL + '   ) AS PEDIDOS,                     ';
  strSQL := strSQL + '   SUM(RCD_QTDITE) AS RCD_QTDITE     ';
  strSQL := strSQL + ' FROM                                ';
  strSQL := strSQL + '   MOVRCD                            ';
  strSQL := strSQL + ' LEFT JOIN PCMDET                    ';
  strSQL := strSQL + '   ON PCMDET.AUTOINCREM = RCD_SEQPCD ';
  strSQL := strSQL + ' LEFT JOIN COTITE                    ';
  strSQL := strSQL + '   ON COTITE.AUTOINCREM = RCD_SEQCOT ';
  strSQL := strSQL + ' LEFT JOIN COTGER                    ';
  strSQL := strSQL + '   ON COTGER.AUTOINCREM = COT_SEQGER ';
  strSQL := strSQL + ' WHERE RCD_DOCPDV = :DOCPDV          ';
  strSQL := strSQL + '   AND RCD_ESPPDV = :ESPPDV          ';
  strSQL := strSQL + '   AND RCD_EMPPDV = :EMPPDV          ';
  strSQL := strSQL + '   AND RCD_CODITE = :CODITE          ';
  strSQL := strSQL + '   AND (                             ';
  strSQL := strSQL + '     (RCD_SEQPCD IS NOT NULL)        ';
  strSQL := strSQL + '     OR (RCD_SEQCOT IS NOT NULL)     ';
  strSQL := strSQL + '   )                                 ';

  Result := True;
  qryAux := fCriaQuery();
  Try
    qryAux.SQL.Text := strSQL;
    qryAux.ParamByName('CODITE').AsString := cdsIteEqu.fieldbyname('CODITE').AsString;
    qryAux.ParamByName('DOCPDV').AsString := FNumPed;
    qryAux.ParamByName('ESPPDV').AsString := 'PD';
    qryAux.ParamByName('EMPPDV').AsString := fCodEmp;
    qryAux.Open;

    If qryAux.FieldByName('RCD_QTDITE').IsNull Then
      Exit;

    fltQtdTot := fQtdTotItem;
    fltQtdDel := cdsIteEqu.fieldbyname('QTDITE').AsFloat;

    if fltQtdTot - fltQtdDel >= qryAux.FieldByName('RCD_QTDITE').AsFloat Then
      Exit;

    objLiberacao.Clear;
    objLiberacao.objMsgLibera.pAddTexto('Exclusão/Alteração de um item de um pedido de venda com requisição de compra');
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Item:', cdsIteEqu.fieldbyname('CODITE').AsString + '-' + cdsIteEqu.fieldbyname('DESITE').AsString);
    objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade total do item no pedido'                                 , FloatToStrF(fltQtdTot, ffFixed, 12, fCfgSis('DECQTD', varInteger))                                , 70, alDireita, teAmbos, '', 10);
    objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade sendo retirada do pedido'                                , FloatToStrF(fltQtdDel, ffFixed, 12, fCfgSis('DECQTD', varInteger))                                , 70, alDireita, teAmbos, '', 10);
    objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade restante no pedido'                                      , FloatToStrF(fltQtdTot - fltQtdDel, ffFixed, 12, fCfgSis('DECQTD', varInteger))                    , 70, alDireita, teAmbos, '', 10);
    objLiberacao.objMsgLibera.pAddTextoCaption('Quantidade total que não pode ser excluída da requisição de compra' , FloatToStrF(qryAux.FieldByName('RCD_QTDITE').AsFloat, ffFixed, 12, fCfgSis('DECQTD', varInteger)) , 70, alDireita, teAmbos, '', 10);
    objLiberacao.objMsgLibera.pAddQuebra;
    objLiberacao.objMsgLibera.pAddTextoCaption('Número da requisição de compra: ',  qryAux.FieldByName('RCD_CODIGO').AsString);

    If Not qryAux.FieldByName('COTACOES').IsNull Then
      objLiberacao.objMsgLibera.pAddTextoCaption('Cotações vinculadas à requisição', qryAux.FieldByName('COTACOES').AsString);
    If Not qryAux.FieldByName('PEDIDOS').IsNull Then
      objLiberacao.objMsgLibera.pAddTextoCaption('Pedidos de compra vinculados à requisição', qryAux.FieldByName('PEDIDOS').AsString);

    objLiberacao.strDirAce := 'EXCITEREQCOM';
    objLiberacao.strMsgSen := 'Exclusão/Alteração de um item de um pedido de venda com requisição de compra';
    objLiberacao.strCodOpe := strCodVen;
    objLiberacao.strCodDig := strCodDig;
    objLiberacao.strCliente := strCodCli + '-' + fRetNomCliente(strCodCli);
    objLiberacao.strCpfCnpj := strCliCgc;

    If (Not objLiberacao.fLibera) Then
      Result := False;
  Finally
    FreeAndNil(qryAux);
  End;
end;

end.
