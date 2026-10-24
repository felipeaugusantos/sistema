unit untTCRMGeracaoGlobal;

interface

uses
  untZClient,
  cxProgressBar,
  System.Classes,
  untTypesSistema,
  Promocao.Classes.CatalogoPromocao,
  Windows;

type
  TParametroCrmGeracaoGlobal = class
  private
    FstrCodGoc: String;
    FstrCodSit: String;
    FstrCodCoc: String;
    FstrCodOpe: String;
    FstrCodToc: String;
    FstrOpeOco: String;
    FdtaDtaAge: TDateTime;
    FhorHorAge: TDateTime;
    FblnOpeCaC: Boolean;
    FstrDescri: String;
    FhorHorInc: TDateTime;
    FdtaDtaInc: TDateTime;
    FdtaDtaCon: TDateTime;
    FhorHorCon: TDateTime;
    FstrTip_FC: String;
    FstrCodEmp: String;
    FstrCodCat: String;
    FstrCodEmpCli: String;
    FBlnEmerge: Boolean;
  public
    property strCodGoc: String    read FstrCodGoc write FstrCodGoc;
    property strCodSit: String    read FstrCodSit write FstrCodSit;
    property strCodToc: String    read FstrCodToc write FstrCodToc;
    property strCodCoc: String    read FstrCodCoc write FStrCodCoc;
    property strCodOpe: String    read FstrCodOpe write FstrCodOpe;
    property strOpeOco: String    read FstrOpeOco write FstrOpeOco;
    property strDescri: String    read FstrDescri write FstrDescri;
    property strTip_Fc: String    read FstrTip_FC write FstrTip_FC;
    property blnOpeCaC: Boolean   read FblnOpeCaC write FblnOpeCaC;
    property dtaDtaAge: TDateTime read FdtaDtaAge write FdtaDtaAge;
    property horHorAge: TDateTime read FhorHorAge write FhorHorAge;
    property dtaDtaInc: TDateTime read FdtaDtaInc write FdtaDtaInc;
    property horHorInc: TDateTime read FhorHorInc write FhorHorInc;
    property dtaDtaCon: TDateTime read FdtaDtaCon write FdtaDtaCon;
    property horHorCon: TDateTime read FhorHorCon write FhorHorCon;
    property strCodEmp: String    read FstrCodEmp write FstrCodEmp;
    property strCodCat: String    read FstrCodCat write FstrCodCat;
    property strCodEmpCli: String read FstrCodEmpCli write FstrCodEmpCli;
    property BlnEmerge: Boolean   read FBlnEmerge write FBlnEmerge;
  end;

  TParametroPrmGeracaoGlobal = Class
  private
    FchkCatProm: Boolean;
    FObjCatalogoPromocao: TCatalogoPromocao;
  public
    constructor Create;
    destructor Destroy; override;

    property chkCatProm: Boolean read FchkCatProm write FchkCatProm;
    property ObjCatalogoPromocao: TCatalogoPromocao read FObjCatalogoPromocao write FObjCatalogoPromocao;
  End;

  TParametroConGeracaoGlobal = class
  private
    FarrEstCiv: TConsultasArray;
    FarrCodReg: TConsultasArray;
    FarrGruAti: TConsultasArray;
    FarrLinGru: TConsultasArray;
    FarrTimFut: TConsultasArray;
    FarrCodRed: TConsultasArray;
    FarrCrmFor: TConsultasArray;
    FarrCodDep: TConsultasArray;
    FarrSubReg: TConsultasArray;
    FarrCodCid: TConsultasArray;
    FarrCanAce: TConsultasArray;
    FarrCrmFre: TConsultasArray;
    FarrCodRep: TConsultasArray;
    FarrCrmPor: TConsultasArray;
    FarrCrmFai: TConsultasArray;
    FarrCodQua: TConsultasArray;
    FarrCodMar: TConsultasArray;
    FarrDepVen: TConsultasArray;
    FarrCodCar: TConsultasArray;
    FarrCodAti: TConsultasArray;
    FarrGosMus: TConsultasArray;
    FarrCodHob: TConsultasArray;
    FarrCodVen: TConsultasArray;
    FarrCodIte: TConsultasArray;
    FarrCodEsc: TConsultasArray;
    FarrCliVen: TConsultasArray;
    FarrVenDup: TConsultasArray;
    FarrPortad: TConsultasArray;
    FarrEvento: TConsultasArray;
    FarrEmpres: TConsultasArray;
    FarrCodEmp: TConsultasArray;
    FarrCodCat: TConsultasArray;
    FarrCodEmpCli:  TConsultasArray;
    FarrCodGoc: TConsultasArray;
    FarrCodToc: TConsultasArray;
    FarrFornec: TConsultasArray;
    FarrUltVnd: TConsultasArray;
    FarrUltDig: TConsultasArray;
    FedtEciCtt: String;
    FedtCodReg: String;
    FedtCodGat: String;
    FedtLinGru: String;
    FedtTfuCtt: String;
    FedtCodRed: String;
    FedtCrmFor: String;
    FedtDptCtt: String;
    FedtCodSub: String;
    FedtCodCid: String;
    FedtCodCac: String;
    FedtCrmFre: String;
    FedtCodRep: String;
    FedtCrmPor: String;
    FedtCrmFai: String;
    FedtCodQua: String;
    FedtCodMar: String;
    FedtDepVen: String;
    FedtCgoCtt: String;
    FedtCodAti: String;
    FedtGmuCtt: String;
    FedtHobCtt: String;
    FedtCodVen: String;
    FedtCodIte: String;
    FedtEscCtt: String;
    FintCbxRev: Integer;
    FintCbxSta: Integer;
    FdtaFinOrc: String;
    FintCbxOrg: Integer;
    FdtaIniCli: String;
    FdtaIniCom: String;
    FintCbxBol: Integer;
    FdtaFinCli: String;
    FdtaFinCom: String;
    FintTipPes: Integer;
    FdtaIniOrc: String;
    FdtaFinCtt: String;
    FintFilPor: Integer;
    FdtaIniCtt: String;
    FdtaIniSeO: String;
    FdtaIniSem: String;
    FdtaFinSeO: String;
    FdtaFinSem: String;
    FedtDiaSeO: String;
    FedtDiaSem: String;
    FintOfeCon: Integer;
    FstrOfeCon: String;
    FedtDesFai: String;
    FedtDesCgo: String;
    FedtDesCac: String;
    FedtDesSub: String;
    FedtDesRep: String;
    FedtNomAti: String;
    FedtDesCPo: String;
    FedtDesFor: String;
    FedtDesVen: String;
    FedtDesFre: String;
    FedtDesReg: String;
    FedtNomCid: String;
    FedtDesRed: String;
    FedtDesGat: String;
    FedtDesEci: String;
    FedtDesDpt: String;
    FedtDesTfu: String;
    FedtDesEsc: String;
    FedtDesGru: String;
    FedtNomFor: String;
    FedtDesHob: String;
    FedtDesGmu: String;
    FedtDesDep: String;
    FedtDesMar: String;
    FedtDesIte: String;
    FdtaIniCCM: String;
    FdtaFinCCM: String;
    FedtDiaCCM: String;
    FchkUtiCSC: Boolean;
    FintCliPor: Integer;
    FedtDiaCli: String;
    FedtDiaCom: String;
    FedtDiaOrc: String;
    FchkUtiFin: Boolean;
    FedtDiaVen: String;
    FedtCodCli: String;
    FedtCodPor: String;
    FdtaIniVen: String;
    FedtCodEve: String;
    FedtVenDup: String;
    FdtaFinVen: String;
    FedtCliVen: String;
    FedtEmpDup: String;
    FedtDesEve: String;
    FedtNomEmpDup: String;
    FedtDVeDup: String;
    FedtNomCli: String;
    FedtDClVen: String;
    FedtDesPor: String;
    FintFinPor: Integer;
    FintEmpDup: Integer;
    FedtCodEmp: String;
    FedtNomEmp: String;
    FintTipEmp: Integer;
    FedtCodCat: String;
    FedtDesCat: String;
    FedtCodEmpCli: String;
    FedtNomEmpCli: String;
    FedtDiaAVe: String;
    FedtDiaVenA: String;
    FedtCodGoc: String;
    FedtDesGoc: String;
    FedtCodToc: String;
    FedtDesToc: String;
    FedtCodFor: String;
    FchkOcoAbe: Boolean;
    FedtUltVnd: String;
    FedtUltDig: String;
    FedtNomUltVnd: String;
    FedtNomUltDig: String;
  public
    property arrCrmFre: TConsultasArray read FarrCrmFre write FarrCrmFre;
    property arrCrmPor: TConsultasArray read FarrCrmPor write FarrCrmPor;
    property arrCrmFai: TConsultasArray read FarrCrmFai write FarrCrmFai;
    property arrCodQua: TConsultasArray read FarrCodQua write FarrCodQua;
    property arrCrmFor: TConsultasArray read FarrCrmFor write FarrCrmFor;
    property arrGruAti: TConsultasArray read FarrGruAti write FarrGruAti;
    property arrCodCid: TConsultasArray read FarrCodCid write FarrCodCid;
    property arrCodAti: TConsultasArray read FarrCodAti write FarrCodAti;
    property arrCodVen: TConsultasArray read FarrCodVen write FarrCodVen;
    property arrCodRep: TConsultasArray read FarrCodRep write FarrCodRep;
    property arrCodReg: TConsultasArray read FarrCodReg write FarrCodReg;
    property arrSubReg: TConsultasArray read FarrSubReg write FarrSubReg;
    property arrCodRed: TConsultasArray read FarrCodRed write FarrCodRed;
    property arrCanAce: TConsultasArray read FarrCanAce write FarrCanAce;
    property arrCodCar: TConsultasArray read FarrCodCar write FarrCodCar;
    property arrCodDep: TConsultasArray read FarrCodDep write FarrCodDep;
    property arrTimFut: TConsultasArray read FarrTimFut write FarrTimFut;
    property arrCodHob: TConsultasArray read FarrCodHob write FarrCodHob;
    property arrCodEsc: TConsultasArray read FarrCodEsc write FarrCodEsc;
    property arrGosMus: TConsultasArray read FarrGosMus write FarrGosMus;
    property arrEstCiv: TConsultasArray read FarrEstCiv write FarrEstCiv;
    property arrDepVen: TConsultasArray read FarrDepVen write FarrDepVen;
    property arrCodMar: TConsultasArray read FarrCodMar write FarrCodMar;
    property arrLinGru: TConsultasArray read FarrLinGru write FarrLinGru;
    property arrCodIte: TConsultasArray read FarrCodIte write FarrCodIte;
    property arrCliVen: TConsultasArray read FarrCliVen write FarrCliVen;
    property arrVenDup: TConsultasArray read FarrVenDup write FarrVenDup;
    property arrPortad: TConsultasArray read FarrPortad write FarrPortad;
    property arrEvento: TConsultasArray read FarrEvento write FarrEvento;
    property arrEmpres: TConsultasArray read FarrEmpres write FarrEmpres;
    property arrCodEmp: TConsultasArray read FarrCodEmp write FarrCodEmp;
    property arrCodCat: TConsultasArray read FarrCodCat write FarrCodCat;
    property arrCodEmpCli: TConsultasArray read FarrCodEmpCli write FarrCodEmpCli;
    property arrCodGoc: TConsultasArray read FarrCodGoc write FarrCodGoc;
    property arrCodToc: TConsultasArray read FarrCodToc write FarrCodToc;
    property arrFornec: TConsultasArray read FarrFornec write FarrFornec;
    property arrUltVnd: TConsultasArray read FarrUltVnd write FarrUltVnd;
    property arrUltDig: TConsultasArray read FarrUltDig write FarrUltDig;

    property edtCrmFre: String          read FedtCrmFre write FedtCrmFre;
    property edtCrmPor: String          read FedtCrmPor write FedtCrmPor;
    property edtCrmFai: String          read FedtCrmFai write FedtCrmFai;
    property edtCodQua: String          read FedtCodQua write FedtCodQua;
    property edtCrmFor: String          read FedtCrmFor write FedtCrmFor;
    property edtCodGat: String          read FedtCodGat write FedtCodGat;
    property edtCodCid: String          read FedtCodCid write FedtCodCid;
    property edtCodAti: String          read FedtCodAti write FedtCodAti;
    property edtCodVen: String          read FedtCodVen write FedtCodVen;
    property edtCodRep: String          read FedtCodRep write FedtCodRep;
    property edtCodReg: String          read FedtCodReg write FedtCodReg;
    property edtCodSub: String          read FedtCodSub write FedtCodSub;
    property edtCodRed: String          read FedtCodRed write FedtCodRed;
    property edtCodCac: String          read FedtCodCac write FedtCodCac;
    property edtCgoCtt: String          read FedtCgoCtt write FedtCgoCtt;
    property edtDepVen: String          read FedtDepVen write FedtDepVen;
    property edtTfuCtt: String          read FedtTfuCtt write FedtTfuCtt;
    property edtHobCtt: String          read FedtHobCtt write FedtHobCtt;
    property edtEscCtt: String          read FedtEscCtt write FedtEscCtt;
    property edtGmuCtt: String          read FedtGmuCtt write FedtGmuCtt;
    property edtEciCtt: String          read FedtEciCtt write FedtEciCtt;
    property edtDptCtt: String          read FedtDptCtt write FedtDptCtt;
    property edtCodMar: String          read FedtCodMar write FedtCodMar;
    property edtLinGru: String          read FedtLinGru write FedtLinGru;
    property edtCodIte: String          read FedtCodIte write FedtCodIte;
    property edtCodCli: String          read FedtCodCli write FedtCodCli;
    property edtCliVen: String          read FedtCliVen write FedtCliVen;
    property edtVenDup: String          read FedtVenDup write FedtVenDup;
    property edtCodPor: String          read FedtCodPor write FedtCodPor;
    property edtCodEve: String          read FedtCodEve write FedtCodEve;
    property edtEmpDup: String          read FedtEmpDup write FedtEmpDup;

    property edtNomCid: String          read FedtNomCid write FedtNomCid;
    property edtDesVen: String          read FedtDesVen write FedtDesVen;
    property edtDesReg: String          read FedtDesReg write FedtDesReg;
    property edtDesRed: String          read FedtDesRed write FedtDesRed;
    property edtDesGat: String          read FedtDesGat write FedtDesGat;
    property edtDesFre: String          read FedtDesFre write FedtDesFre;
    property edtDesFai: String          read FedtDesFai write FedtDesFai;
    property edtNomAti: String          read FedtNomAti write FedtNomAti;
    property edtDesRep: String          read FedtDesRep write FedtDesRep;
    property edtDesSub: String          read FedtDesSub write FedtDesSub;
    property edtDesCac: String          read FedtDesCac write FedtDesCac;
    property edtDesCPo: String          read FedtDesCPo write FedtDesCPo;
    property edtDesFor: String          read FedtDesFor write FedtDesFor;
    property edtDesCgo: String          read FedtDesCgo write FedtDesCgo;
    property edtDesTfu: String          read FedtDesTfu write FedtDesTfu;
    property edtDesEsc: String          read FedtDesEsc write FedtDesEsc;
    property edtDesEci: String          read FedtDesEci write FedtDesEci;
    property edtDesDpt: String          read FedtDesDpt write FedtDesDpt;
    property edtDesHob: String          read FedtDesHob write FedtDesHob;
    property edtDesGmu: String          read FedtDesGmu write FedtDesGmu;
    property edtDesDep: String          read FedtDesDep write FedtDesDep;
    property edtDesGru: String          read FedtDesGru write FedtDesGru;
    property edtNomFor: String          read FedtNomFor write FedtNomFor;
    property edtDesMar: String          read FedtDesMar write FedtDesMar;
    property edtDesIte: String          read FedtDesIte write FedtDesIte;
    property edtNomCli: String          read FedtNomCli write FedtNomCli;
    property edtDClVen: String          read FedtDClVen write FedtDClVen;
    property edtDVeDup: String          read FedtDVeDup write FedtDVeDup;
    property edtDesPor: String          read FedtDesPor write FedtDesPor;
    property edtDesEve: String          read FedtDesEve write FedtDesEve;
    property edtNomEmpDup: String       read FedtNomEmpDup write FedtNomEmpDup;

    property intCbxRev: Integer         read FintCbxRev write FintCbxRev;
    property intCbxBol: Integer         read FintCbxBol write FintCbxBol;
    property intCbxOrg: Integer         read FintCbxOrg write FintCbxOrg;
    property intCbxSta: Integer         read FintCbxSta write FintCbxSta;
    property intTipPes: Integer         read FintTipPes write FintTipPes;
    property intFilPor: Integer         read FintFilPor write FintFilPor;
    property intOfeCon: Integer         read FintOfeCon write FintOfeCon;
    property intCliPor: Integer         read FintCliPor write FintCliPor;
    property intFinPor: Integer         read FintFinPor write FintFinPor;
    property intEmpDup: Integer         read FintEmpDup write FintEmpDup;

    property strOfeCon: String          read FstrOfeCon write FstrOfeCon;

    property dtaIniCli: String          read FdtaIniCli write FdtaIniCli;
    property dtaFinCli: String          read FdtaFinCli write FdtaFinCli;
    property dtaIniCom: String          read FdtaIniCom write FdtaIniCom;
    property dtaFinCom: String          read FdtaFinCom write FdtaFinCom;
    property dtaIniOrc: String          read FdtaIniOrc write FdtaIniOrc;
    property dtaFinOrc: String          read FdtaFinOrc write FdtaFinOrc;
    property dtaIniCtt: String          read FdtaIniCtt write FdtaIniCtt;
    property dtaFinCtt: String          read FdtaFinCtt write FdtaFinCtt;
    property dtaIniSem: String          read FdtaIniSem write FdtaIniSem;
    property dtaFinSem: String          read FdtaFinSem write FdtaFinSem;
    property dtaIniSeO: String          read FdtaIniSeO write FdtaIniSeO;
    property dtaFinSeO: String          read FdtaFinSeO write FdtaFinSeO;
    property dtaIniCCM: String          read FdtaIniCCM write FdtaIniCCM;
    property dtaFinCCM: String          read FdtaFinCCM write FdtaFinCCM;
    property dtaIniVen: String          read FdtaIniVen write FdtaIniVen;
    property dtaFinVen: String          read FdtaFinVen write FdtaFinVen;

    property edtDiaSem: String          read FedtDiaSem write FedtDiaSem;
    property edtDiaSeO: String          read FedtDiaSeO write FedtDiaSeO;
    property edtDiaCCM: String          read FedtDiaCCM write FedtDiaCCM;
    property edtDiaCli: String          read FedtDiaCli write FedtDiaCli;
    property edtDiaCom: String          read FedtDiaCom write FedtDiaCom;
    property edtDiaOrc: String          read FedtDiaOrc write FedtDiaOrc;
    property edtDiaVen: String          Read FedtDiaVen write FedtDiaVen;
    property edtDiaAVe: String          Read FedtDiaAVe write FedtDiaAVe;
    property edtDiaVenA: String         Read FedtDiaVenA write FedtDiaVenA;


    property chkUtiCSC: Boolean         read FchkUtiCSC write FchkUtiCSC;
    property chkUtiFin: Boolean         read FchkUtiFin write FchkUtiFin;
    property edtCodEmp: String          read FedtCodEmp write FedtCodEmp;
    property edtNomEmp: String          read FedtNomEmp write FedtNomEmp;
    property intTipEmp: Integer         read FintTipEmp write FintTipEmp;
    property edtCodCat: String          read FedtCodCat write FedtCodCat;
    property edtDesCat: String          read FedtDesCat write FedtDesCat;
    property edtCodEmpCli: String       read FedtCodEmpCli write FedtCodEmpCli;
    property edtNomEmpCli: String       read FedtNomEmpCli write FedtNomEmpCli;

    property edtCodGoc: String          read FedtCodGoc write FedtCodGoc;
    property edtDesGoc: String          read FedtDesGoc write FedtDesGoc;
    property edtCodToc: String          read FedtCodToc write FedtCodToc;
    property edtDesToc: String          read FedtDesToc write FedtDesToc;
    property chkOcoAbe: Boolean         read FchkOcoAbe write FchkOcoAbe;
    property edtCodFor: String          read FedtCodFor write FedtCodFor;

    property edtUltVnd: String       read FedtUltVnd write FedtUltVnd;
    property edtUltDig: String       read FedtUltDig write FedtUltDig;
    property edtNomUltVnd: String    read FedtNomUltVnd write FedtNomUltVnd;
    property edtNomUltDig: String    read FedtNomUltDig write FedtNomUltDig;
  end;

  TCRMGeracaoGlobal = class
  private
    FcdsDados : TZClient;
    FParamCon : TParametroConGeracaoGlobal;
    FstrCrmFre: String;
    FstrCrmPor: String;
    FstrCrmFai: String;
    FstrCodQua: String;
    FstrCrmFor: String;
    FstrGruAti: String;
    FstrCodCid: String;
    FstrCodAti: String;
    FstrCodVen: String;
    FstrCodRep: String;
    FstrCodReg: String;
    FstrSubReg: String;
    FstrCodRed: String;
    FstrCanAce: String;
    FstrCodCar: String;
    FstrDepVen: String;
    FstrTimFut: String;
    FstrCodHob: String;
    FstrCodEsc: String;
    FstrGosMus: String;
    FstrEstCiv: String;
    FstrCodDep: String;
    FstrCodMar: String;
    FstrLinGru: String;
    FstrCodIte: String;
    FlstMarca : TStringList;
    FParamCRM : TParametroCrmGeracaoGlobal;
    FstrCodAca: String;
    FstrCliVen: String;
    FstrVenDup: String;
    FstrCodPor: String;
    FstrCodEve: String;
    FstrEmpDup: String;
    FstrCodEmp: String;
    FstrCodCat: String;
    FstrCodEmpCli: String;
    FblnExiMsg: Boolean;
    FintQtdSel: Integer;
    FstrCodGoc: String;
    FstrCodToc: String;
    FstrCodFor: String;
    FParamPRM : TParametroPrmGeracaoGlobal;
    FstrNomArqCat: String;
    FstrUltVnd: String;
    FstrUltDig: String;

    function fGetSQL: String;
    function fRetWhereProduto: String;
    function fRetSQLFinanceiro: String;
    function fRetSQLSemOrcamento: String;
    function fRetSQLAcaoAutomatica: String;
    function fFiltrarPeriodoComCompra: Boolean;
    function fFiltrarPeriodoSemCompra: Boolean;
    function fFiltrarPeriodoSemOrcamento: Boolean;
    function fRetSQLCompra(Const blnComComp: Boolean = False): String;
    function fRetSQLTabCompra(Const blnComComp: Boolean = False; blnSemComp: Boolean = False): String;
    function fMontaMensagemRetorno(aNumeroOcorrenciasGeradas, aNumeroOcorrenciasNaoGeradas: Integer): String;


    procedure pSetaParametros;
    function fSQLJoinBase: String;
  public
    property cdsDados: TZClient                   read FcdsDados write FcdsDados;
    property ParamCon: TParametroConGeracaoGlobal read FParamCon write FParamCon;
    property ParamCRM: TParametroCrmGeracaoGlobal read FParamCRM write FParamCRM;
    property ParamPRM: TParametroPrmGeracaoGlobal read FParamPRM write FParamPRM;
    property lstMarca: TStringList                read FlstMarca write FlstMarca;
    property blnExibirMensagem: Boolean           read FblnExiMsg write FblnExiMsg;
    property intQtdSel: Integer                   read FintQtdSel write FintQtdSel;

    constructor Create(Const strCodAca: String = ''; Const strParamCon: String = '';
      Const strParamCRM: String = ''; Const strParamPRM: String = '');
    destructor Destroy; Override;

    function fCarregaDados: Boolean;
    function fJaMarcado(Const strCodCli: String): Boolean;
    function fMarcaTodos(cxProgress : TcxProgressBar = nil): Boolean;
    function fInsereOcorrencias(cxProgress: TcxProgressBar = nil): Boolean;
    function fMarcarClientesAleatoriamente(cxProgress : TcxProgressBar = nil): Boolean;

    procedure pMarcaDesmarca(Const strCodCli: String; blnRemove: Boolean = True);
    procedure pDesmarcaTodos;

    class procedure pProcessarAcoesAutomaticasCRM(const blnExibirMensagem: Boolean = True);
  end;

implementation

uses
  Uni,
  Data.DB,
  Vcl.Forms,
  untFuncoesCRM,
  System.SysUtils,
  System.StrUtils,
  untFuncoesSimples,
  untFuncoesConsulta,
  untAtualizaOcorrenciasCRM,
  Rest.JSON,
  untFuncoesOcorrenciasCRM;

{ TCRMGeracaoGlobal }

constructor TCRMGeracaoGlobal.Create(Const strCodAca: String = '';
  Const strParamCon: String = ''; Const strParamCRM: String = '';
  Const strParamPRM: String = '');
begin
  inherited Create();

  FcdsDados := TZClient.Create(nil);

  If Not fEmptyStr(strParamCon) Then
    FParamCon := TJson.JsonToObject<TParametroConGeracaoGlobal>(strParamCon)
  Else
    FParamCon := TParametroConGeracaoGlobal.Create;

  If Not fEmptyStr(strParamCRM) Then
    FParamCRM := TJson.JsonToObject<TParametroCrmGeracaoGlobal>(strParamCRM)
  Else
    FParamCRM := TParametroCrmGeracaoGlobal.Create;

  If Not fEmptyStr(strParamPRM) Then
    FParamPRM := TJson.JsonToObject<TParametroPrmGeracaoGlobal>(strParamPRM)
  Else
    FParamPRM := TParametroPrmGeracaoGlobal.Create;

  FlstMarca := TStringList.Create;
  FstrCodAca := strCodAca;
  FblnExiMsg := True;
  FintQtdSel := 0;
end;

destructor TCRMGeracaoGlobal.Destroy;
begin
  FreeAndNil(FParamCon);
  FreeAndNil(FParamCRM);
  FreeAndNil(FParamPRM);
  FreeAndNil(FcdsDados);
end;

function TCRMGeracaoGlobal.fCarregaDados: Boolean;
begin
  Try
    FcdsDados.qryQuery.Close;
    FcdsDados.qryQuery.SQL.Clear;
    pDesmarcaTodos();
    FcdsDados.qryQuery.SQL.Add(fGetSQL());
    pSetaParametros();
    FcdsDados.fAbreClient(True, 'TCRMGeracaoGlobal.fCarregaDados()');
    Result := not FcdsDados.IsEmpty;

    TFloatField(FcdsDados.FieldByName('VLRORC')).DisplayFormat := fMskDigitos(fCfgSis('DECUNI', varInteger));
  Except
    On E : Exception Do
    Begin
      Result := False;
      pMensagensErro(e.Message, 'TCRMGeracaoGlobal.fCarregaDados()');
    End;
  End;
end;

function TCRMGeracaoGlobal.fFiltrarPeriodoComCompra: Boolean;
begin
  Result := ((Not fEmptyDate(FParamCon.dtaIniCCM)) And
             (Not fEmptyDate(FParamCon.dtaFinCCM))) Or (Not fEmptyStr(FParamCon.edtDiaCCM));
end;

function TCRMGeracaoGlobal.fFiltrarPeriodoSemCompra: Boolean;
begin
  Result := ((Not fEmptyDate(FParamCon.dtaIniSem)) And
             (Not fEmptyDate(FParamCon.dtaFinSem))) Or (Not fEmptyStr(FParamCon.edtDiaSem));
end;

function TCRMGeracaoGlobal.fFiltrarPeriodoSemOrcamento: Boolean;
begin
  Result := ((Not fEmptyDate(FParamCon.dtaIniSeO)) And
             (Not fEmptyDate(FParamCon.dtaFinSeO))) Or (Not fEmptyStr(FParamCon.edtDiaSeO));
end;

function TCRMGeracaoGlobal.fGetSQL: String;
begin
  Result := '';
  Result := Result + ' SELECT SQL_NO_CACHE                                            ';
  Result := Result + '        C.CLI_CODCLI,                                           ';
  Result := Result + '        CONCAT(C.CLI_CODCLI," - ", CLI_NOMCLI) AS CLI_NOMCLI,   ';
  Result := Result + '        CONCAT(CID_NOMCID," - ", CID_ESTADO) AS CLI_CIDADE,     ';
  Result := Result + '        CLI_STATUS,                                             ';
  Result := Result + '        CONCAT(  ATI_CODATI," - ", ATI_DESATI)   AS ATI_DESATI, ';
  Result := Result + '        CONCAT(V.OPE_CODOPE," - ", V.OPE_NOMOPE) AS NOMVEN,     ';
  Result := Result + '        CONCAT(R.OPE_CODOPE," - ", R.OPE_NOMOPE) AS NOMREP,     ';
  Result := Result + '        CONCAT(  REG_CODREG," - ", REG_DESREG)   AS REG_DESREG, ';
  Result := Result + '        CONCAT(  SUB_CODSUB," - ", SUB_DESSUB)   AS SUB_DESSUB, ';
  Result := Result + '        CONCAT(  RED_CODRED," - ", RED_DESRED)   AS RED_DESRED, ';
  Result := Result + '        CONCAT(  CAC_CODCAC," - ", CAC_NOMCAC)   AS CAC_NOMCAC, ';
  Result := Result + '        CLI_REVIST,                                             ';
  Result := Result + '        CLI_ENVBOL,                                             ';
  Result := Result + '        CLI_EMAIL_,                                             ';
  Result := Result + '        CLI_ORGPUB,                                             ';
  Result := Result + '        DATE_FORMAT(CLI_NASCIM, "%d/%m") AS CLI_NASCIM,         ';
  Result := Result + '        GROUP_CONCAT(CLI_NOMCTT) AS CLI_NOMCTT,                 ';
  Result := Result + '        CONCAT(CGO_CODCGO," - ", CGO_DESCGO) AS CAR_DESCAR,     ';
  Result := Result + '        CONCAT(DPT_CODDPT," - ", DPT_DESDPT) AS DEP_DESCRI,     ';
  Result := Result + '        CONCAT(TFU_CODTFU," - ", TFU_DESTFU) AS TFU_DESTFU,     ';
  Result := Result + '        CONCAT(HOB_CODHOB," - ", HOB_DESHOB) AS HOB_DESHOB,     ';
  Result := Result + '        CONCAT(ESC_CODESC," - ", ESC_DESESC) AS ESC_DESESC,     ';
  Result := Result + '        CONCAT(GMU_CODGMU," - ", GMU_DESGMU) AS GMU_DESGMU,     ';
  Result := Result + '        CONCAT(ECI_CODECI," - ", ECI_DESECI) AS ECI_DESECI,     ';
  Result := Result + '        GROUP_CONCAT(DATE_FORMAT(CLI_NASCTT, "%d/%m")) AS CLI_NASCTT         ';

  If (Not fEmptyDate(FParamCon.dtaIniOrc) ) And
     (Not fEmptyDate(FParamCon.dtaFinOrc))  Or
     (Not fEmptyStr(FParamCon.edtDiaOrc))   Then
  Begin
    Result := Result + ' , FGO_DTAENT AS ULTORC        ';
    Result := Result + ' , FGO_ESPDOC AS ESPORC        ';
    Result := Result + ' , FGO_VLRCON AS VLRORC        ';
  End
  Else
  Begin
    Result := Result + ' , 0.00  AS ULTORC                ';
    Result := Result + ' , " " AS ESPORC                  ';
    Result := Result + ' , 0.00  AS VLRORC                ';
  End;

  If FParamCon.chkOcoAbe Then
  Begin
    Result := Result + ' , GOC_CODGOC AS CODGOC          ';
    Result := Result + ' , OCO_CODTOC AS CODTOC          ';
    Result := Result + ' , (IFNULL(QTDABE, 0)) AS QTDABE ';
  End;

  If FParamCon.chkUtiCSC Then
  Begin
    If fCfgSis('NCPCRM', varBoolean) Then
    Begin
      If fFiltrarPeriodoSemCompra() Then
        Result := Result + ' , IFNULL(SEMCOMPRA.QTD, 0) AS QTDCOM ';

      If fFiltrarPeriodoComCompra() Then
        Result := Result + ' , IFNULL(COMCOMPRA.QTD, 0) AS QTDCCM ';
    End
    Else
    Begin
      If fFiltrarPeriodoSemCompra() Then
        Result := Result + fRetSQLCompra();

      If fFiltrarPeriodoComCompra() Then
        Result := Result + fRetSQLCompra(True);
    End;

    If fFiltrarPeriodoSemOrcamento() Then
      Result := Result + fRetSQLSemOrcamento();

    If fFiltrarPeriodoSemCompra() Or
       fFiltrarPeriodoComCompra() Then
    Begin
      Result := Result + ', NOMULTVND  ';
      Result := Result + ', NOMULTDIG  ';
    End;
  End;

  If FParamCon.chkUtiFin Then
    Result := Result + fRetSQLFinanceiro();

  If Not fEmptyStr(FstrCodAca) Then
    Result := Result + fRetSQLAcaoAutomatica();

  If fCfgSis('NCPCRM', varBoolean) Then
  Begin
    If fFiltrarPeriodoComCompra() Then
    Begin
      If ((Not fEmptyDate(FParamCon.dtaIniCCM) ) And (Not fEmptyDate(FParamCon.dtaFinCCM))) Or (Not fEmptyStr(FParamCon.edtDiaCCM)) Then
      Begin
        Result := Result + ' , ((C.CLI_ULTCOM IS NOT NULL                            ';
        Result := Result + ' 				AND NOT EXISTS (SELECT AUTOINCREM                ';
        Result := Result + ' 												FROM MOVDET                      ';
        Result := Result + ' 												WHERE DET_CODCLI = C.CLI_CODCLI) ';
        If (Not fEmptyDate(FParamCon.dtaIniCCM) ) And (Not fEmptyDate(FParamCon.dtaFinCCM)) Then
          Result := Result + '  AND C.CLI_ULTCOM BETWEEN :INICCM AND :FINCCM         '
        Else
          Result := Result + '  AND DATEDIFF(CURRENT_DATE, C.CLI_ULTCOM) <= :QTDCCM  ';
        Result := Result + ' )) AS TEMULTCOM ';
      End;
    End;
  End;

  Result := Result + ' FROM CADCLI C                                             ';
  Result := Result + '   LEFT JOIN CADCID   ON CID_CODCID = CLI_CODCID           ';
  Result := Result + '   LEFT JOIN CADATI   ON ATI_CODATI = CLI_CODATI           ';
  Result := Result + '   LEFT JOIN CADOPE V ON V.OPE_CODOPE = CLI_CODVEN         ';
  Result := Result + '   LEFT JOIN CADOPE R ON R.OPE_CODOPE = CLI_CODREP         ';
  Result := Result + '   LEFT JOIN CADREG   ON REG_CODREG = CLI_CODREG           ';
  Result := Result + '   LEFT JOIN CADSUB   ON SUB_CODSUB = CLI_CODSUB           ';
  Result := Result + '   LEFT JOIN CADRED   ON RED_CODRED = CLI_CODRED           ';
  Result := Result + '   LEFT JOIN CADCAC   ON CAC_CODCAC = CLI_CODCAC           ';

  Result := Result + '   LEFT JOIN CLICTT T ON T.CLI_CODCLI = C.CLI_CODCLI       ';
  Result := Result + '   LEFT JOIN CADCGO   ON CGO_CODCGO = CLI_CGOCTT           ';
  Result := Result + '   LEFT JOIN CADDPT   ON DPT_CODDPT = CLI_DPTCTT           ';
  Result := Result + '   LEFT JOIN CADTFU   ON TFU_CODTFU = CLI_TFUCTT           ';
  Result := Result + '   LEFT JOIN CADHOB   ON HOB_CODHOB = CLI_HOBCTT           ';
  Result := Result + '   LEFT JOIN CADESC   ON ESC_CODESC = CLI_ESCCTT           ';
  Result := Result + '   LEFT JOIN CADGMU   ON GMU_CODGMU = CLI_GMUCTT           ';
  Result := Result + '   LEFT JOIN CADECI   ON ECI_CODECI = CLI_ECICTT           ';
  Result := Result + '   LEFT JOIN QUACLI L ON L.QUA_CODCLI = C.CLI_CODCLI       ';
  Result := Result + '   LEFT JOIN CADQUA Q ON Q.AUTOINCREM = L.QUA_CODQUA       ';

  If fCfgSis('NCPCRM', varBoolean) Then
  Begin
    If fFiltrarPeriodoSemCompra() Then
      Result := Result + ' LEFT JOIN ( ' + fRetSQLCompra() + ' ) AS SEMCOMPRA ON C.CLI_CODCLI = SEMCOMPRA.CLIDET ';

    If fFiltrarPeriodoComCompra() Then
      Result := Result + ' LEFT JOIN ( ' + fRetSQLCompra(True) + ' ) AS COMCOMPRA ON C.CLI_CODCLI = COMCOMPRA.CLIDET ';
  End;

  If (Not fEmptyDate(FParamCon.dtaIniOrc) ) And (Not fEmptyDate(FParamCon.dtaFinOrc)) Or
     (Not fEmptyStr(FParamCon.edtDiaOrc)) Then
  Begin
    Result := Result + '   LEFT JOIN ( SELECT FGO_ESPDOC,                          ';
    Result := Result + '                      FGO_DTAENT,                          ';
    Result := Result + '                      FGO_VLRCON,                          ';
    Result := Result + '                      FGO_CODCLI                           ';
    Result := Result + '               FROM FATGOR FG                              ';
    Result := Result + '               WHERE                                       ';

    If ( Not fEmptyDate(FParamCon.dtaIniOrc) ) And (not fEmptyDate(FParamCon.dtaFinOrc)) Then
      Result := Result + ' FGO_DTAENT BETWEEN :INIORC AND :FINORC '
    Else
    If (Not fEmptyStr(FParamCon.edtDiaOrc)) Then
      Result := Result + ' DATEDIFF(CURRENT_DATE, FGO_DTAENT) <= :DIAORC ';



    Result := Result + '               AND AUTOINCREM = (SELECT AUTOINCREM       ';
    Result := Result + '                                   FROM FATGOR G           ';
    Result := Result + '                                   WHERE FG.FGO_CODCLI = G.FGO_CODCLI    ';
    Result := Result + '                                   ORDER BY FGO_CODCLI, FGO_DTAENT DESC, AUTOINCREM  DESC';
    Result := Result + '                                   LIMIT 1)         ';
    Result := Result + '               ) F ON FGO_CODCLI = C.CLI_CODCLI    ';
  End;

  If FParamCon.chkOcoAbe Then
  Begin
    Result := Result + '   LEFT JOIN ( SELECT  MAX(GOC_CODGOC) AS GOC_CODGOC,      ';
    Result := Result + '                       MAX(OCO_CODTOC) AS OCO_CODTOC,      ';
    Result := Result + '                       MAX(OCO_CODCLI) AS OCO_CODCLI,      ';
    Result := Result + '                       COUNT(OCO_CODOCO) AS QTDABE         ';
    Result := Result + '               FROM MOVOCO                                 ';
    Result := Result + '               INNER JOIN CADTOC ON TOC_CODTOC = OCO_CODTOC';
    Result := Result + '               INNER JOIN CADGOC ON GOC_CODGOC = TOC_CODGOC';
    Result := Result + '               WHERE (IFNULL(OCO_DTACON, 0)) = 0           ';
    Result := Result + fStrLocate(FParamCon.edtCodGoc, FParamCon.arrCodGoc, 'GOC_CODGOC', 'CODGOC');
    Result := Result + fStrLocate(FParamCon.edtCodToc, FParamCon.arrCodToc, 'OCO_CODTOC', 'CODTOC');
    Result := Result + '               GROUP BY OCO_CODCLI, GOC_CODGOC, OCO_CODTOC ';
    Result := Result + '               ORDER BY OCO_CODCLI, GOC_CODGOC, OCO_CODTOC ';
    Result := Result + '               ) O ON O.OCO_CODCLI =  C.CLI_CODCLI         ';
  End;

  Result := Result + ' LEFT JOIN                               ' +
                     '(                                        ' +
                     ' SELECT CT.CLI_CODCLI AS CLICTT          ' +
                     '       ,MAX(CT.AUTOINCREM) AS SEQCTT     ' +
                     ' FROM  CLICTT CT                         ' +
                     ' GROUP BY CT.CLI_CODCLI                  ' +
                     ' ORDER BY CT.CLI_CODCLI                  ' +
                     ') CTTAUX ON CTTAUX.CLICTT = C.CLI_CODCLI ';


  If FParamCon.chkUtiCSC Then
  Begin
    If fFiltrarPeriodoSemCompra Or
       fFiltrarPeriodoComCompra Then
    Begin
      If fCfgSis('NCPCRM', varBoolean) Then
        Result := Result + ' LEFT JOIN (                               '
      Else
        Result := Result + ' INNER JOIN (                              ';

      Result := Result + fRetSQLTabCompra(fFiltrarPeriodoComCompra, fFiltrarPeriodoSemCompra);

      Result := Result + ' ) CMP ON CMP.DET_PROEMB <> "S" AND       ';
      Result := Result + '          CMP.DET_TIP_FC = "C"  AND       ';
      Result := Result + '          CMP.DET_CODCLI = C.CLI_CODCLI   ';
    End;
  End;

  Result := Result + ' WHERE TRUE                                                ';

  Result := Result + fStrLocate(FParamCon.edtCodCid, FParamCon.arrCodCid, 'CLI_CODCID', 'CODCID');
  Result := Result + fStrLocate(FParamCon.edtCodAti, FParamCon.arrCodAti, 'CLI_CODATI', 'CODATI');
  Result := Result + fStrLocate(FParamCon.edtCodVen, FParamCon.arrCodVen, 'CLI_CODVEN', 'CODVEN');
  Result := Result + fStrLocate(FParamCon.edtCodRep, FParamCon.arrCodRep, 'CLI_CODREP', 'CODREP');
  Result := Result + fStrLocate(FParamCon.edtCodReg, FParamCon.arrCodReg, 'CLI_CODREG', 'CODREG');
  Result := Result + fStrLocate(FParamCon.edtCodSub, FParamCon.arrSubReg, 'CLI_CODSUB', 'CODSUB');
  Result := Result + fStrLocate(FParamCon.edtCodRed, FParamCon.arrCodRed, 'CLI_CODRED', 'CODRED');
  Result := Result + fStrLocate(FParamCon.edtCodCac, FParamCon.arrCanAce, 'CLI_CODCAC', 'CODCAC');
  Result := Result + fStrLocate(FParamCon.edtCodGat, FParamCon.arrGruAti, 'ATI_CODGAT', 'CODGAT');
  Result := Result + fStrLocate(FParamCon.edtCrmFre, FParamCon.arrCrmFre, 'CLI_CRMFRE', 'CRMFRE');
  Result := Result + fStrLocate(FParamCon.edtCrmPor, FParamCon.arrCrmPor, 'CLI_CRMPOR', 'CRMPOR');
  Result := Result + fStrLocate(FParamCon.edtCrmFai, FParamCon.arrCrmFai, 'CLI_CRMFAI', 'CRMFAI');
  Result := Result + fStrLocate(FParamCon.edtCodQua, FParamCon.arrCodQua, 'Q.QUA_CODQUA', 'QUACLI');
  Result := Result + fStrLocate(FParamCon.edtCgoCtt, FParamCon.arrCodCar, 'CLI_CGOCTT', 'CGOCTT');
  Result := Result + fStrLocate(FParamCon.edtDptCtt, FParamCon.arrCodDep, 'CLI_DPTCTT', 'DPTCTT');
  Result := Result + fStrLocate(FParamCon.edtTfuCtt, FParamCon.arrTimFut, 'CLI_TFUCTT', 'TFUCTT');
  Result := Result + fStrLocate(FParamCon.edtHobCtt, FParamCon.arrCodHob, 'CLI_HOBCTT', 'HOBCTT');
  Result := Result + fStrLocate(FParamCon.edtEscCtt, FParamCon.arrCodEsc, 'CLI_ESCCTT', 'ESCCTT');
  Result := Result + fStrLocate(FParamCon.edtGmuCtt, FParamCon.arrGosMus, 'CLI_GMUCTT', 'GMUCTT');
  Result := Result + fStrLocate(FParamCon.edtEciCtt, FParamCon.arrEstCiv, 'CLI_ECICTT', 'ECICTT');
  Result := Result + fStrLocate(FParamCon.edtCodCat, FParamCon.arrCodCat, 'CLI_CRMCAT', 'CRMCAT');
  Result := Result + fStrLocate(FParamCon.edtCodEmpCli, FParamCon.arrCodEmpCli, 'C.CLI_CODEMP', 'CODEMP');

  If (fFiltrarPeriodoSemCompra() Or fFiltrarPeriodoComCompra()) Then
  Begin
    Result := Result + fStrLocate(FParamCon.edtUltVnd, FParamCon.arrUltVnd, 'ULTVND', 'ULTVND');
    Result := Result + fStrLocate(FParamCon.edtUltDig, FParamCon.arrUltDig, 'ULTDIG', 'ULTDIG');
  End;

  Case FParamCon.intCbxRev Of
    0: Result := Result + ' AND CLI_REVIST = "S" ';
    1: Result := Result + ' AND CLI_REVIST = "N" '
  End;

  Case FParamCon.intCbxBol Of
    0: Result := Result + ' AND CLI_ENVBOL = "S" ';
    1: Result := Result + ' AND CLI_ENVBOL = "N" '
  End;

  Case FParamCon.intCbxOrg Of
    0: Result := Result + ' AND CLI_ORGPUB = "S" ';
    1: Result := Result + ' AND CLI_ORGPUB = "N" '
  End;

  Case FParamCon.intCbxSta Of
    0: Result := Result + ' AND CLI_STATUS = "A" ';
    1: Result := Result + ' AND CLI_STATUS = "I" '
  End;

  if (FParamCon.chkUtiFin) and (not fEmptyStr(FParamCon.edtCodCli)) then
    Result := Result + '  AND C.CLI_CODCLI = :CODCLI ';

  If FParamCon.intTipPes > 0 Then
    Result := Result + ' AND CLI_CGCCPF = ' + IntToStr(FParamCon.intTipPes);

  If (Not fEmptyStr(fTiraCaracEspeciais(FParamCon.dtaIniCli))) And
     (Not fEmptyStr(fTiraCaracEspeciais(FParamCon.dtaFinCli))) Then
    Result := Result + ' AND (DATE_FORMAT(CLI_NASCIM, "%m/%d") BETWEEN :ANICLIINI AND :ANICLIFIN) '
  Else
  If (Not fEmptyStr(FParamCon.edtDiaCli)) Then
    Result := Result + ' AND (DATEDIFF(CURRENT_DATE, CONCAT(YEAR(CURRENT_DATE), "-", DATE_FORMAT(CLI_NASCIM, "%m-%d"))) BETWEEN  0 AND :DIACLI) ';

  If (Not fEmptyStr(fTiraCaracEspeciais(FParamCon.dtaIniCtt))) And
     (Not fEmptyStr(fTiraCaracEspeciais(FParamCon.dtaFinCtt))) Then
    Result := Result + ' AND (DATE_FORMAT(CLI_NASCTT, "%m/%d") BETWEEN :ANICTTINI AND :ANICTTFIN) ';

  If (Not fEmptyDate(FParamCon.dtaIniCom) ) And (Not fEmptyDate(FParamCon.dtaFinCom)) Then
    Result := Result + ' AND CLI_ULTCOM BETWEEN :INICOM AND :FINCOM '
  Else
  If Not fEmptyStr(FParamCon.edtDiaCom) Then
    Result := Result + ' AND DATEDIFF(CURRENT_DATE, CLI_ULTCOM) <= :DIACOM ';

  If not fEmptyStr(FParamCon.edtCrmFor) Then
  Begin
    Result := Result + ' AND ( SELECT COUNT(0) FROM CLIFOR WHERE CLF_CODCLI = C.CLI_CODCLI ';
    Result := Result + fStrLocate(FParamCon.edtCrmFor, FParamCon.arrCrmFor, 'CLF_CRMFOR', 'CRMFOR');
    Result := Result + ' ) > 0 ';
  End;

  Result := Result + ' GROUP BY CLI_NOMCLI, CLI_CIDADE, CLI_STATUS, ATI_DESATI, NOMVEN, NOMREP, '+
                              ' REG_DESREG, SUB_DESSUB, RED_DESRED, CAC_NOMCAC, CLI_REVIST, CLI_ENVBOL, '+
                              ' CLI_EMAIL_, CLI_ORGPUB, CLI_NASCIM, CAR_DESCAR, DEP_DESCRI, TFU_DESTFU, '+
                              ' HOB_DESHOB, ESC_DESESC, GMU_DESGMU, ECI_DESECI, CLI_CODCLI, '+
                              ' ULTORC, ESPORC, VLRORC ';

  If FParamCon.chkUtiCSC Then
  Begin
    If fFiltrarPeriodoSemCompra Then
    Begin
      If fCfgSis('NCPCRM', varBoolean) Then
        Result := Result + ' , QTDCOM  '
      Else
        Result := Result + ' , QTDCOM, QTDCOO  ';
    End;

    If fFiltrarPeriodoComCompra Then
    Begin
      If fCfgSis('NCPCRM', varBoolean) Then
        Result := Result + ' , QTDCCM '
      Else
        Result := Result + ' , QTDCCM, QTDCCO ';
    End;
  End;

  If FParamCon.chkUtiCSC Then
    If fFiltrarPeriodoSemOrcamento Then
      Result := Result + ', QTDORC';

  If FParamCon.chkUtiCSC Then
  Begin
    If fFiltrarPeriodoSemCompra() Then
    Begin
      If fCfgSis('NCPCRM', varBoolean) Then
        Result := Result + ' HAVING (QTDCOM = 0)'
      Else
        Result := Result + ' HAVING (QTDCOM = 0 AND QTDCOO = 0)';
    End;

    If fFiltrarPeriodoComCompra() Then
    Begin
      If fCfgSis('NCPCRM', varBoolean) Then
      Begin
        If ((Not fEmptyDate(FParamCon.dtaIniCCM) ) And (Not fEmptyDate(FParamCon.dtaFinCCM))) Or (Not fEmptyStr(FParamCon.edtDiaCCM)) Then
          Result := Result + IIF(Pos('HAVING', Result) > 0, ' AND ', ' HAVING ') + ' ((QTDCCM > 0) OR (TEMULTCOM)) '
        Else
          Result := Result + IIF(Pos('HAVING', Result) > 0, ' AND ', ' HAVING ') + ' (QTDCCM > 0) ';
      End
      Else
        Result := Result + IIF(Pos('HAVING', Result) > 0, ' AND ', ' HAVING ') + ' (QTDCCM > 0 OR QTDCCO > 0) ';
    End;

    If fFiltrarPeriodoSemOrcamento() Then
      Result := Result + IIF(Pos('HAVING', Result) > 0, ' AND ', ' HAVING ') + '    QTDORC = 0 ';

  End;

  If ( Not fEmptyDate(FParamCon.dtaIniOrc) ) And (not fEmptyDate(FParamCon.dtaFinOrc)) Then
    Result := Result + IIF(Pos('HAVING', Result) > 0, ' AND ', ' HAVING ') + ' ULTORC BETWEEN :INIORC AND :FINORC '
  Else
  If (Not fEmptyStr(FParamCon.edtDiaOrc)) Then
    Result := Result + IIF(Pos('HAVING', Result) > 0, ' AND ', ' HAVING ') + ' DATEDIFF(CURRENT_DATE, ULTORC) <= :DIAORC ';

  If FParamCon.chkUtiFin Then
    Result := Result + IIF(Pos('HAVING', Result) > 0, ' AND ', ' HAVING ') + '    QTDDUP > 0 ';

  If Not fEmptyStr(FstrCodAca) Then
    Result := Result + IIF(Pos('HAVING', Result) > 0, ' AND ', ' HAVING ') + '    QTDOCO = 0 ';

  If FParamCon.chkOcoAbe Then
  Begin
    Result := Result + IIF(Pos('HAVING', Result) > 0, ' AND ', ' HAVING ') + ' (QTDABE <= 0 ) ';
  End;

  Result := Result + ' ORDER BY C.CLI_NOMCLI ';
end;

function TCRMGeracaoGlobal.fInsereOcorrencias(
  cxProgress: TcxProgressBar): Boolean;
  Var
    objAtuOcoCrm: TAtuOcoCrm;
    intIndex    : Integer;
    intOcorrencias: Integer;
    strMensagemOco: String;
    intOcorrenciasNaoGeradas: Integer;
    LarrOpeEmer: TStringArray;
begin
  Result := True;
  intOcorrencias := 0;
  intOcorrenciasNaoGeradas := 0;
  fStartTransaction;
  Try
    Try
      If Assigned(cxProgress) Then
        cxProgress.Properties.Max := FlstMarca.Count;

      objAtuOcoCrm := TAtuOcoCrm.Create(nil);

      For intIndex := 0 To FlstMarca.Count - 1 Do
      Begin
        If Not Result Then
          Break;

        objAtuOcoCrm.strCodAca := FstrCodAca;
        objAtuOcoCrm.strCodCli := FlstMarca[intIndex];
        objAtuOcoCrm.strDtaInc := IIF(FParamCRM.dtaDtaInc > 0, FParamCRM.dtaDtaInc, VS_Date);
        objAtuOcoCrm.strHorInc := IIF(FParamCRM.horHorInc > 0, FParamCRM.horHorInc, fRetHoraServidor());
        objAtuOcoCrm.strDtaAge := IIF(FParamCRM.dtaDtaAge > 0, FParamCRM.dtaDtaAge, VS_Date);
        objAtuOcoCrm.strHorAge := IIF(FParamCRM.horHorAge > 0, FParamCRM.horHorAge, objAtuOcoCrm.strHorInc);
        objAtuOcoCrm.strDtaCon := FParamCRM.dtaDtaCon;
        objAtuOcoCrm.strHorCon := FParamCRM.horHorCon;
        objAtuOcoCrm.strOpeHis := FParamCRM.strOpeOco;
        objAtuOcoCrm.strCodOpe := FParamCRM.strCodOpe;
        objAtuOcoCrm.strCodSit := FParamCRM.strCodSit;
        objAtuOcoCrm.strTip_Fc := FParamCRM.strTip_Fc;
        objAtuOcoCrm.BlnEmerge := FParamCRM.BlnEmerge;

        if not FParamCRM.blnOpeCaC Then
        Begin
          objAtuOcoCrm.strDescri := FParamCRM.strDescri + '<<csq>><<csq>>' +
                                    'Operador Origem : ' + fRetNomeOperador(FParamCRM.strOpeOco) + '<<csq>>' +
                                    DateToStr(FParamCRM.dtaDtaInc) + ' ' +
                                    TimeToStr(FParamCRM.horHorInc) + ' - ' +
                                    FParamCRM.strCodOpe + ' - ' +
                                    fRetNomeOperador(FParamCRM.strCodOpe);
        End
        Else
        Begin
          objAtuOcoCrm.strCodOpe := fCampoTabela('CLI_CODVEN', 'CADCLI', ['CLI_CODCLI'], [objAtuOcoCrm.strCodCli] );
          objAtuOcoCrm.strDescri := fGeraTextoHistorico(FParamCRM.dtaDtaInc,
                                                        FParamCRM.horHorInc,
                                                        fRetNomeOperador(objAtuOcoCrm.strCodOpe),
                                                        FParamCRM.strDescri);
        End;

        objAtuOcoCrm.strCodEmp := VS_strCodEmp;
        objAtuOcoCrm.strCodCoc := FParamCRM.strCodCoc;
        objAtuOcoCrm.strCodToc := FParamCRM.strCodToc;

        If Not objAtuOcoCrm.fExisteOcorrenciaEmAbertoParaCliente Then
        Begin
          objAtuOcoCrm.pInsereNovaOcorrencia;
          objAtuOcoCrm.pInsereHistoricoOcorrencia;
          inc(intOcorrencias);

          If FParamPRM.chkCatProm  Then
          Begin
            FParamPRM.ObjCatalogoPromocao.strCodCli := FlstMarca[intIndex];
            FParamPRM.ObjCatalogoPromocao.strDirPDF := fPathArquivosOcoCrm + objAtuOcoCrm.strCodOco + ExtractFileName(FstrNomArqCat);
            FParamPRM.ObjCatalogoPromocao.pGerarArquivo(False, False, True);
            FParamPRM.ObjCatalogoPromocao.cdsDados.Filtered := False;
          End;


          If FParamCRM.BlnEmerge then
          Begin
            SetLength(LarrOpeEmer,1);
            LarrOpeEmer[0] := objAtuOcoCrm.strCodOpe;
            pGravaOcorrenciaEmergencial(objAtuOcoCrm.strCodOco,
                                        objAtuOcoCrm.strCodEmp,
                                        LarrOpeEmer,
                                        'TCRMGeracaoGlobal.fInsereOcorrencias()');

            If fCfgSis('OCOMSG', varBoolean) Then
              pEnviaMensagemEmergencial(False, FParamCRM.strDescri, objAtuOcoCrm, LarrOpeEmer);
          End;

        End
        Else
          inc(intOcorrenciasNaoGeradas);


        If Assigned(cxProgress) Then
          cxProgress.Position := cxProgress.Position + 1;

        Application.ProcessMessages;
      End;

    Except
      On E : Exception Do
      Begin
        Result := False;
        If FblnExiMsg Then
          pMensagensErro(e.message, 'TCRMGeracaoGlobal.fInsereOcorrencias()');
      End;
    End;
  Finally
    If Assigned(objAtuOcoCrm) Then
      FreeAndNil(objAtuOcoCrm);

    If Result Then
    Begin
      fCommit;

      If FblnExiMsg Then
      Begin
        strMensagemOco := fMontaMensagemRetorno(intOcorrencias, intOcorrenciasNaoGeradas);

        fMensagem('ATENÇÃO!', strMensagemOco, ['&O K']);
      End;
    End
    Else
     fRollback;
  End;
end;

function TCRMGeracaoGlobal.fMontaMensagemRetorno(aNumeroOcorrenciasGeradas, aNumeroOcorrenciasNaoGeradas: Integer): String;
Begin
  Result := '';

  Case aNumeroOcorrenciasGeradas of
     0:  Begin
           Result := 'Não foi possível gerar ocorrências para os clientes selecionados, pois existem ocorrências com os parâmetros indicados.';
           Exit;
         End;
     1: Result := 'Foi gerada uma ocorrência com sucesso.';
     Else
        Result := 'Foram geradas '+IntToStr(aNumeroOcorrenciasGeradas)+' ocorrências com sucesso.';
  End;

  Case aNumeroOcorrenciasNaoGeradas of
    0: Exit;
    1: Result := Result + ' Não foi gerada ' +IntToStr(aNumeroOcorrenciasNaoGeradas) + ' ocorrência'+
                          ' porque já existe ocorrência em aberto do mesmo tipo para o cliente selecionado.';
    Else
       Result := Result + ' Não foram geradas ' +IntToStr(aNumeroOcorrenciasNaoGeradas) + ' ocorrências'+
                          ' porque já existem ocorrências em aberto do mesmo tipo para os clientes selecionados.';
  End;
End;

function TCRMGeracaoGlobal.fJaMarcado(const strCodCli: String): Boolean;
begin
  Result := FlstMarca.IndexOf(strCodCli) >= 0;
end;

function TCRMGeracaoGlobal.fRetWhereProduto: String;
begin
  Result := '';
  Result := Result + fStrLocate(FParamCon.edtDepVen, FParamCon.arrDepVen, 'C.ITE_CODDEP', 'DEPVEN');
  Result := Result + fStrLocate(FParamCon.edtCodMar, FParamCon.arrCodMar, 'C.ITE_CODMAR', 'CODMAR');
  Result := Result + fStrLocate(FParamCon.edtLinGru, FParamCon.arrLinGru, 'C.ITE_CODGRU', 'CODGRU');
  Result := Result + fStrLocate(FParamCon.edtCodIte, FParamCon.arrCodIte, 'C.ITE_CODITE', 'CODITE');
  Result := Result + fStrLocate(FParamCon.edtCodFor, FParamCon.arrFornec, 'C.ITE_CODFOR', 'CODFOR');

  If FParamCon.intOfeCon > 0 Then
    Result := Result + '  AND C.ITE_CLACRM = :CLACRM ';
end;

function TCRMGeracaoGlobal.fRetSQLAcaoAutomatica: String;
begin
  Result := Result + ',(SELECT COUNT(0)                                      ';
  Result := Result + '  FROM MOVOCO O                                        ';
  Result := Result + '  WHERE O.OCO_CODCLI = C.CLI_CODCLI                    ';
  Result := Result + '    AND O.OCO_CODACA = :CODACA                         ';
  Result := Result + '  ) AS QTDOCO                                          ';
end;

function TCRMGeracaoGlobal.fRetSQLTabCompra(Const blnComComp: Boolean = False; blnSemComp: Boolean = False): String;
  Var
    strSQLDet: String;
    strWhere: String;
begin
  Result := '';
  strSQLDet := '';
  strWhere := '';

  strSQLDet := 'SELECT MAX(D.DET_DTAENT) AS DTAENT,                           '+
               '       D.DET_CODVEN AS ULTVND,                                '+
               '       D.DET_CODDIG AS ULTDIG,                                '+
               '       CONCAT(D.DET_CODVEN, " - ", O.OPE_NOMOPE) AS NOMULTVND,'+
               '       CONCAT(D.DET_CODDIG, " - ", G.OPE_NOMOPE) AS NOMULTDIG,'+
               '       D.DET_PROEMB,                                          '+
               '       D.DET_TIP_FC,                                          '+
               '       D.DET_CODCLI                                           '+
               '  FROM MOVDET D                                               '+
               '  JOIN CADITE C ON D.DET_CODITE = C.ITE_CODITE                '+
               '  INNER JOIN MOVTRI T ON D.AUTOINCREM = T.DET_SEQGER          '+
               '  INNER JOIN CADOPE O ON O.OPE_CODOPE = D.DET_CODVEN          '+
               '  INNER JOIN CADOPE G ON G.OPE_CODOPE = D.DET_CODDIG          '+
               ' WHERE D.DET_PROEMB <> "S"                                    '+
               '   AND D.DET_TIP_FC = "C"                                     ';

  If Not fEmptyStr(FParamCon.edtCodEmp) Then
  Begin
    Case FParamCon.intTipEmp Of
      0: strWhere := fStrLocate(FParamCon.edtCodEmp, FParamCon.arrCodEmp, 'D.DET_CODEMP', 'CODEMP');
      1: strWhere := fStrLocate(FParamCon.edtCodEmp, FParamCon.arrCodEmp, 'T.DET_EMPORI', 'CODEMP');
    End;
  End
  Else
  Begin
    Case FParamCon.intTipEmp Of
      0: strWhere := ' AND LOCATE(D.DET_CODEMP, :CODEMP) > 0 ';
      1: strWhere := ' AND LOCATE(T.DET_EMPORI, :CODEMP) > 0 ';
    End;
  End;

  strWhere := strWhere + fRetWhereProduto();
  strWhere := strWhere + '    AND (LOCATE(D.DET_CLAFIS, :CLAFIS) > 0)';

  Result := Result + ' ' + strSQLDet + strWhere + ' ' ;
  Result := Result + ' GROUP BY D.DET_CODCLI' ;
end;

function TCRMGeracaoGlobal.fSQLJoinBase: String;
begin
  Result := '';
  Result := Result + ' MOVDET D ';
  Result := Result + '  JOIN MOVGER ON D.DET_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result + '  LEFT JOIN AUXMOV ON AUXMOV.AUX_SEQGER = MOVGER.AUTOINCREM ';
  Result := Result + '  INNER JOIN MOVTRI T ON T.DET_SEQGER = D.AUTOINCREM ';
  Result := Result + '  LEFT JOIN MOVICD ON MOVICD.ICD_SEQGER = D.AUTOINCREM AND MOVICD.ICD_FCPPRO = "S" ';
  Result := Result + '  JOIN CADITE C ON D.DET_CODITE = C.ITE_CODITE ';
end;

function TCRMGeracaoGlobal.fRetSQLCompra(Const blnComComp: Boolean = False): String;
var
  strSQLDet: String;
  strSQLCod: String;
  strWhere: String;
begin
  Result := '';
  strSQLDet := '';
  strSQLCod := '';
  strWhere := '';

  If fCfgSis('NCPCRM', varBoolean) Then
  Begin
    strSQLDet := strSQLDet + 'SELECT D.AUTOINCREM AS INCDET, ';
    strSQLDet := strSQLDet + '       D.DET_CODCLI AS CLIDET  ';
  End
  Else
    strSQLDet := strSQLDet + 'SELECT COUNT(D.AUTOINCREM) AS QTD ';
  strSQLDet := strSQLDet + '  FROM ' + fSQLJoinBase;
  strSQLDet := strSQLDet + ' WHERE D.DET_PROEMB <> "S"                              ';
  strSQLDet := strSQLDet + '   AND D.DET_TIP_FC = "C"                               ';
  If Not fCfgSis('NCPCRM', varBoolean) Then
    strSQLDet := strSQLDet + '   AND D.DET_CODCLI = C.CLI_CODCLI                    ';

  If Not fEmptyStr(FParamCon.edtCodEmp) Then
  Begin
    case FParamCon.intTipEmp of
      0: strSQLDet := strSQLDet + fStrLocate(FParamCon.edtCodEmp, FParamCon.arrCodEmp, 'D.DET_CODEMP', 'CODEMP');
      1: strSQLDet := strSQLDet + fStrLocate(FParamCon.edtCodEmp, FParamCon.arrCodEmp, 'T.DET_EMPORI', 'CODEMP');
    end;
  End
  Else
  Begin
    case FParamCon.intTipEmp of
      0: strSQLDet := strSQLDet +  ' AND LOCATE(D.DET_CODEMP, :CODEMP) > 0 ';
      1: strSQLDet := strSQLDet +  ' AND LOCATE(T.DET_EMPORI, :CODEMP) > 0 ';
    end;
  End;

  strSQLCod := strSQLCod + 'SELECT COUNT(0) AS QTD                            ';
  strSQLCod := strSQLCod + '  FROM NOTCOD D                                   ';
  strSQLCod := strSQLCod + '  JOIN NOTCOG G ON D.DET_SEQGER = G.AUTOINCREM    ';
  strSQLCod := strSQLCod + '  JOIN CADITE C ON D.DET_CODITE = C.ITE_CODITE    ';
  strSQLCod := strSQLCod + ' WHERE G.GER_CODCLI = C.CLI_CODCLI                ';
  strSQLCod := strSQLCod + '   AND G.GER_TIP_FC = "C"                         ';

  If Not fEmptyStr(FParamCon.edtCodEmp) Then
  Begin
    strSQLCod := strSQLCod + fStrLocate(FParamCon.edtCodEmp, FParamCon.arrCodEmp, 'G.GER_CODEMP', 'CODEMP');
  End
  Else
  Begin
    strSQLCod := strSQLCod +  ' AND LOCATE(G.GER_CODEMP,:CODEMP) > 0 AND COALESCE(G.GER_CODEMP, "") <> ""     ';
  End;

  If blnComComp Then
  Begin
    If (Not fEmptyDate(FParamCon.dtaIniCCM) ) And (Not fEmptyDate(FParamCon.dtaFinCCM)) Then
      strWhere := strWhere + '  AND D.DET_DTAENT BETWEEN :INICCM AND :FINCCM '
    Else If (Not fEmptyStr(FParamCon.edtDiaCCM)) Then
      strWhere := strWhere + '  AND DATEDIFF(CURRENT_DATE, D.DET_DTAENT) <= :QTDCCM ';
  End
  Else
  Begin
    If (Not fEmptyDate(FParamCon.dtaIniSem) ) And (Not fEmptyDate(FParamCon.dtaFinSem)) Then
      strWhere := strWhere + '  AND D.DET_DTAENT BETWEEN :DTAINI AND :DTAFIN  '
    Else
    If (Not fEmptyStr(FParamCon.edtDiaSem)) Then
      strWhere := strWhere + '  AND DATEDIFF(CURRENT_DATE, D.DET_DTAENT) <= :QTDSEM ';
  End;

  strWhere := strWhere + fRetWhereProduto();
  If Not fCfgSis('NCPCRM', varBoolean) Then
    strWhere := strWhere + '    AND (LOCATE(D.DET_CLAFIS, :CLAFIS) > 0)';

  If fCfgSis('NCPCRM', varBoolean) Then
    Result := Result + ' SELECT COUNT(INCDET) AS QTD, CLIDET FROM ( ' + fRetornaSQLRegraFaturamento(strSQLDet + strWhere, 'D') + ' ) AS TAB GROUP BY CLIDET '
  Else
  Begin
    Result := Result + ',( ' + strSQLDet + strWhere + ' ) AS ' + IIF(blnComComp, 'QTDCCM ', ' QTDCOM ');
    Result := Result + ',( ' + strSQLCod + strWhere + ' ) AS ' + IIF(blnComComp, 'QTDCCO ', ' QTDCOO ');
  End;
end;

function TCRMGeracaoGlobal.fRetSQLFinanceiro: String;
begin
  Result := Result + ', ( SELECT COUNT(0)                                     ';
  Result := Result + '      FROM CADREC R                                     ';
  Result := Result + '      JOIN CADCLI CLI ON CLI.CLI_CODCLI = R.CTR_CODCLI  ';
  Result := Result + '     WHERE R.CTR_DTAREC IS NULL                         ';
  Result := Result + '       AND R.CTR_VALDUP > 0                             ';

  If fEmptyStr(FParamCon.edtCodCli) Then
    Result := Result + '     AND R.CTR_CODCLI = C.CLI_CODCLI                  '
  Else
    Result := Result + '     AND R.CTR_CODCLI = :CODCLI                       ';

  Result := Result + fStrLocate(FParamCon.edtCliVen, FParamCon.arrCliVen, 'CLI.CLI_CODVEN', 'CLIVEN');
  Result := Result + fStrLocate(FParamCon.edtVenDup, FParamCon.arrVenDup, 'R.CTR_CODVEN'  , 'VENDUP');

  If fEmptyStr(FParamCon.edtCodPor) And fCfgSis('DACPOR', VarBoolean) Then
  Begin
    Result := Result + '     AND (IFNULL(R.CTR_CODPOR, "") = ""               ';
    Result := Result + ' OR LOCATE(R.CTR_CODPOR, ' + QuotedStr(strPortadoresOperador) + ') > 0) ';
  End
  Else
    Result := Result + fStrLocate(FParamCon.edtCodPor, FParamCon.arrPortad, 'R.CTR_CODPOR'  , 'CODPOR');

  Result := Result + fStrLocate(FParamCon.edtCodEve, FParamCon.arrEvento, 'R.CTR_CODEVE'  , 'CODEVE');

  if not fEmptyStr(FParamCon.edtEmpDup)  then
  begin
    case FParamCon.intEmpDup of
      0: Result := Result + fStrLocate(FParamCon.edtEmpDup, FParamCon.arrEmpres, 'R.CTR_CODEMP'  , 'EMPDUP');
      1: Result := Result + fStrLocate(FParamCon.edtEmpDup, FParamCon.arrEmpres, 'R.CTR_EMPORI'  , 'EMPDUP');
    end;
  end;

  If (Not fEmptyDate(FParamCon.dtaIniVen)) And (Not fEmptyDate(FParamCon.dtaFinVen)) Then
    Result := Result + '    AND R.CTR_DTAVEN BETWEEN :INIVEN AND :FINVEN      '
  Else If (Not fEmptyStr(FParamCon.edtDiaVen)) Then
    Result := Result + '    AND DATEDIFF(CURRENT_DATE, R.CTR_DTAVEN) BETWEEN 1 AND :DIAVEN'
  Else If (Not fEmptyStr(FParamCon.edtDiaAVe)) Then
    Result := Result + '    AND R.CTR_DTAVEN BETWEEN CURRENT_DATE AND (DATE_ADD(CURRENT_DATE, INTERVAL :DIAVENC DAY))'
  Else If (Not fEmptyStr(FParamCon.edtDiaVenA)) Then
    Result := Result + '    AND (DATEDIFF(CURRENT_DATE, CTR_DTAVEN) >= :DIAVENAPOS) ';

  Result := Result + ' ) AS QTDDUP                                            ';
end;

function TCRMGeracaoGlobal.fRetSQLSemOrcamento: String;
begin
  Result := Result + ' , ( SELECT COUNT(0)                                    ';
  Result := Result + '       FROM FATDOR D                                    ';
  Result := Result + '     JOIN CADITE C ON D.FDO_CODITE = C.ITE_CODITE       ';
  Result := Result + '     WHERE D.FDO_CODCLI = C.CLI_CODCLI                  ';

  If (Not fEmptyDate(FParamCon.dtaIniSeO)) And (Not fEmptyDate(FParamCon.dtaFinSeO)) Then
    Result := Result + '       AND D.FDO_DTAENT BETWEEN :DTINIO AND :DTFINO   '
  Else
  If (Not fEmptyStr(FParamCon.edtDiaSeO)) Then
    Result := Result + '       AND DATEDIFF(CURRENT_DATE, FDO_DTAENT) <= :QTDSOR';

  If Not fEmptyStr(FParamCon.edtCodEmp) Then
  Begin
    case FParamCon.intTipEmp of
      0: Result := Result + fStrLocate(FParamCon.edtCodEmp, FParamCon.arrCodEmp, 'D.FDO_EMPFAT'  , 'CODEMP');
      1: Result := Result + fStrLocate(FParamCon.edtCodEmp, FParamCon.arrCodEmp, 'D.FDO_CODEMP'  , 'CODEMP');
    End;
  End
  Else
  Begin
    case FParamCon.intTipEmp of
      0: Result := Result + ' AND LOCATE(D.FDO_EMPFAT,:CODEMP) > 0  AND COALESCE(D.FDO_EMPFAT, "") <> "" ';
      1: Result := Result + ' AND LOCATE(D.FDO_CODEMP,:CODEMP) > 0  AND COALESCE(D.FDO_CODEMP, "") <> "" ';
    end;
  End;

  Result := Result + fRetWhereProduto;
  Result := Result + '   ) AS QTDORC                                          ';
end;

procedure TCRMGeracaoGlobal.pDesmarcaTodos;
begin
  FlstMarca.Clear();
end;

procedure TCRMGeracaoGlobal.pMarcaDesmarca(const strCodCli: String; blnRemove: Boolean = True);
var
  intIdx: Integer;
begin
  intIdx := FlstMarca.IndexOf(strCodCli);

  If intIdx < 0 Then
    FlstMarca.Add(strCodCli)
  Else If blnRemove Then
    lstMarca.Delete(intIdx);
end;

class procedure TCRMGeracaoGlobal.pProcessarAcoesAutomaticasCRM(const blnExibirMensagem: Boolean = True);
  Var
    objLocal: TCRMGeracaoGlobal;
    qryGen: TUniQuery;
begin
  If (Not fLock_Unlock('ACAO_AUTOMATICA_CRM', True, False, False, '', False)) Then
    Exit;

  qryGen := fCriaQuery();

  Try
    qryGen.SQL.Add('SELECT ACA_CODACA, ACA_PARCON, ACA_PARCRM');
    qryGen.SQL.Add('  FROM ACACRM                            ');
    qryGen.SQL.Add(' WHERE ACA_ATIVA = "S" AND               ');
    qryGen.SQL.Add('       :CURRENT_DATE BETWEEN ACA_DTAINI  ');
    qryGen.SQL.Add('                         AND ACA_DTAFIN  ');
    qryGen.ParamByName('CURRENT_DATE').AsDateTime := VS_Date;
    qryGen.Open;

    While Not qryGen.Eof Do
    Begin
      Try
        objLocal := TCRMGeracaoGlobal.Create(qryGen.FieldByName('ACA_CODACA').AsString,
                                             qryGen.FieldByName('ACA_PARCON').AsString,
                                             qryGen.FieldByName('ACA_PARCRM').AsString);
        objLocal.blnExibirMensagem := blnExibirMensagem;
        If objLocal.fCarregaDados() Then
        Begin
          If objLocal.fMarcaTodos() Then
            objLocal.fInsereOcorrencias();
        End;
      Finally
        FreeAndNil(objLocal);
      End;

      qryGen.Next();
    End;
  Finally
    fLock_Unlock('ACAO_AUTOMATICA_CRM', False);
    FreeAndNil(qryGen);
  End;
end;

function TCRMGeracaoGlobal.fMarcarClientesAleatoriamente(cxProgress : TcxProgressBar = nil): Boolean;
var
  intQtdMarcados: Integer;
  intTotRegistros: Integer;
  arrItensSelec: Array of Integer;
  intCont: Integer;
  intPosSel: Integer;
  blnEncontrou: Boolean;
  intCnt: Integer;
begin
  Result := True;

  If Assigned(cxProgress) Then
  Begin
    cxProgress.Properties.Max := FcdsDados.RecordCount;
    cxProgress.Position := 0;
    cxProgress.Visible := True;
  End;

  intTotRegistros := FcdsDados.RecordCount;
  SetLength(arrItensSelec, 0);
  repeat
    intPosSel := Random(intTotRegistros);

    blnEncontrou := False;
    For intCnt:=0 to Length(arrItensSelec)-1 Do
      If intPosSel = arrItensSelec[intCnt] Then
      Begin
        blnEncontrou := True;
        break;
      End;

    If Not blnEncontrou Then
    Begin
     SetLength(arrItensSelec, Length(arrItensSelec)+1);
     arrItensSelec[Length(arrItensSelec)-1] := intPosSel;
    End;
  until (Length(arrItensSelec) = FintQtdSel);

  Try
    FcdsDados.First;
    FcdsDados.DisableControls;
    intCont := 0;
    intQtdMarcados := 0;
    While Not FcdsDados.Eof Do
    Begin

      If intQtdMarcados > FintQtdSel Then
        Break;

      blnEncontrou := False;
      For intCnt:=0 to Length(arrItensSelec)-1 Do
        If intCont = arrItensSelec[intCnt] Then
        Begin
          blnEncontrou := True;
          break;
        End;

      If (intQtdMarcados <= FintQtdSel) And (blnEncontrou) Then
      Begin
        pMarcaDesmarca(FcdsDados.FieldByName('CLI_CODCLI').AsString, False);
        inc(intQtdMarcados);
      End;

      inc(intCont);

      FcdsDados.Next;

      If Assigned(cxProgress) Then
        cxProgress.Position := cxProgress.Position + 1;

      If (FcdsDados.RecNo Mod 50) = 0 Then
        Application.ProcessMessages;
    End;

  Finally
    FcdsDados.First;
    FcdsDados.EnableControls;
  End;
end;

function TCRMGeracaoGlobal.fMarcaTodos(cxProgress: TcxProgressBar = nil): Boolean;
begin
  Result := True;

  If Assigned(cxProgress) Then
  Begin
    cxProgress.Properties.Max := FcdsDados.RecordCount;
    cxProgress.Position := 0;
    cxProgress.Visible := True;
  End;

  Try
    FcdsDados.First;
    FcdsDados.DisableControls;

    While Not FcdsDados.Eof Do
    Begin
      pMarcaDesmarca(FcdsDados.FieldByName('CLI_CODCLI').AsString, False);


      FcdsDados.Next;

      If Assigned(cxProgress) Then
        cxProgress.Position := cxProgress.Position + 1;

      If (FcdsDados.RecNo Mod 50) = 0 Then
        Application.ProcessMessages;
    End;

  Finally
    FcdsDados.First;
    FcdsDados.EnableControls;
  End;
end;

procedure TCRMGeracaoGlobal.pSetaParametros;
begin
  pSetaParam(FParamCon.edtCodCid, FParamCon.arrCodCid, FstrCodCid, 'CODCID', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtCodAti, FParamCon.arrCodAti, FstrCodAti, 'CODATI', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtCodVen, FParamCon.arrCodVen, FstrCodVen, 'CODVEN', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtCodRep, FParamCon.arrCodRep, FstrCodRep, 'CODREP', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtCodReg, FParamCon.arrCodReg, FstrCodReg, 'CODREG', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtCodSub, FParamCon.arrSubReg, FstrSubReg, 'CODSUB', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtCodRed, FParamCon.arrCodRed, FstrCodRed, 'CODRED', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtCodCac, FParamCon.arrCanAce, FstrCanAce, 'CODCAC', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtCodGat, FParamCon.arrGruAti, FstrGruAti, 'CODGAT', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtCrmFre, FParamCon.arrCrmFre, FstrCrmFre, 'CRMFRE', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtCrmPor, FParamCon.arrCrmPor, FstrCrmPor, 'CRMPOR', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtCrmFai, FParamCon.arrCrmFai, FstrCrmFai, 'CRMFAI', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtCodQua, FParamCon.arrCodQua, FstrCodQua, 'QUACLI', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtCrmFor, FParamCon.arrCrmFor, FstrCrmFor, 'CRMFOR', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtCgoCtt, FParamCon.arrCodCar, FstrCodCar, 'CGOCTT', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtDptCtt, FParamCon.arrCodDep, FstrCodDep, 'DPTCTT', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtTfuCtt, FParamCon.arrTimFut, FstrTimFut, 'TFUCTT', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtHobCtt, FParamCon.arrCodHob, FstrCodHob, 'HOBCTT', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtEscCtt, FParamCon.arrCodEsc, FstrCodEsc, 'ESCCTT', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtGmuCtt, FParamCon.arrGosMus, FstrGosMus, 'GMUCTT', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtEciCtt, FParamCon.arrEstCiv, FstrEstCiv, 'ECICTT', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtCodCat, FParamCon.arrCodCat, FstrCodCat, 'CRMCAT', FcdsDados.qryQuery);
  pSetaParam(FParamCon.edtCodEmpCli, FParamCon.arrCodEmpCli, FstrCodEmpCli, 'CODEMP', FcdsDados.qryQuery);

  If FParamCon.chkUtiCSC Then
  Begin
    If (fFiltrarPeriodoSemCompra() Or fFiltrarPeriodoSemOrcamento() Or fFiltrarPeriodoComCompra()) Then
    Begin
      pSetaParam(FParamCon.edtDepVen, FParamCon.arrDepVen, FstrDepVen, 'DEPVEN', FcdsDados.qryQuery);
      pSetaParam(FParamCon.edtCodMar, FParamCon.arrCodMar, FstrCodMar, 'CODMAR', FcdsDados.qryQuery);
      pSetaParam(FParamCon.edtLinGru, FParamCon.arrLinGru, FstrLinGru, 'CODGRU', FcdsDados.qryQuery);
      pSetaParam(FParamCon.edtCodIte, FParamCon.arrCodIte, FstrCodIte, 'CODITE', FcdsDados.qryQuery);
      pSetaParam(FParamCon.edtCodFor, FParamCon.arrFornec, FstrCodFor, 'CODFOR', FcdsDados.qryQuery);

      If FParamCon.intOfeCon > 0 Then
        FcdsDados.qryQuery.ParamByName('CLACRM').AsString := FParamCon.strOfeCon;
    End;

    If (fFiltrarPeriodoSemCompra() Or fFiltrarPeriodoComCompra()) Then
    Begin
      pSetaParam(FParamCon.edtUltVnd, FParamCon.arrUltVnd, FstrUltVnd, 'ULTVND', FcdsDados.qryQuery);
      pSetaParam(FParamCon.edtUltDig, FParamCon.arrUltDig, FstrUltDig, 'ULTDIG', FcdsDados.qryQuery);
    End;
  End;

  If FParamCon.chkUtiFin Then
  Begin
    If Not fEmptyStr(FParamCon.edtCodCli) Then
      FcdsDados.qryQuery.ParamByName('CODCLI').AsString := FParamCon.edtCodCli;

    pSetaParam(FParamCon.edtCliVen, FParamCon.arrCliVen, FstrCliVen, 'VENCLI', FcdsDados.qryQuery);
    pSetaParam(FParamCon.edtVenDup, FParamCon.arrVenDup, FstrVenDup, 'VENDUP', FcdsDados.qryQuery);

    If Not fCfgSis('DACPOR', VarBoolean) Then
      pSetaParam(FParamCon.edtCodPor, FParamCon.arrPortad, FstrCodPor, 'CODPOR', FcdsDados.qryQuery);

    pSetaParam(FParamCon.edtCodEve, FParamCon.arrEvento, FstrCodEve, 'CODEVE', FcdsDados.qryQuery);
    pSetaParam(FParamCon.edtEmpDup, FParamCon.arrEmpres, FstrEmpDup, 'EMPDUP', FcdsDados.qryQuery);

    If (Not fEmptyDate(FParamCon.dtaIniVen)) And (Not fEmptyDate(FParamCon.dtaFinVen)) Then
    Begin
      FcdsDados.qryQuery.ParamByName('INIVEN').AsDateTime := StrToDateDef(FParamCon.dtaIniVen,0);
      FcdsDados.qryQuery.ParamByName('FINVEN').AsDateTime := StrToDateDef(FParamCon.dtaFinVen,0);
    End
    Else If (Not fEmptyStr(FParamCon.edtDiaVen)) Then
      FcdsDados.qryQuery.ParamByName('DIAVEN').AsInteger := StrToIntDef(FParamCon.edtDiaVen,0);

    If (Not fEmptyStr(FParamCon.edtDiaAVe)) Then
      FcdsDados.qryQuery.ParamByName('DIAVENC').AsInteger := StrToIntDef(FParamCon.edtDiaAVe,0);

    If (Not fEmptyStr(FParamCon.edtDiaVenA)) Then
      FcdsDados.qryQuery.ParamByName('DIAVENAPOS').AsInteger := StrToIntDef(FParamCon.edtDiaVenA,0);

  End;

  If (Not fEmptyStr(fTiraCaracEspeciais(FParamCon.dtaIniCli))) And
     (Not fEmptyStr(fTiraCaracEspeciais(FParamCon.dtaFinCli))) Then
  Begin
    FcdsDados.qryQuery.ParamByName('ANICLIINI').AsString := RightStr(FParamCon.dtaIniCli, 2) + '/' + LeftStr(FParamCon.dtaIniCli, 2);
    FcdsDados.qryQuery.ParamByName('ANICLIFIN').AsString := RightStr(FParamCon.dtaFinCli, 2) + '/' + LeftStr(FParamCon.dtaFinCli, 2);
  End
  Else If (Not fEmptyStr(FParamCon.edtDiaCli)) Then
    FcdsDados.qryQuery.ParamByName('DIACLI').AsInteger := StrToIntDef(FParamCon.edtDiaCli,0);

  If (Not fEmptyStr(fTiraCaracEspeciais(FParamCon.dtaIniCtt))) And
     (Not fEmptyStr(fTiraCaracEspeciais(FParamCon.dtaFinCtt))) Then
  Begin
    FcdsDados.qryQuery.ParamByName('ANICTTINI').AsString := RightStr(FParamCon.dtaIniCtt, 2) + '/' + LeftStr(FParamCon.dtaIniCtt, 2);
    FcdsDados.qryQuery.ParamByName('ANICTTFIN').AsString := RightStr(FParamCon.dtaFinCtt, 2) + '/' + LeftStr(FParamCon.dtaFinCtt, 2);
  End;

  If (Not fEmptyDate(FParamCon.dtaIniCom)) And (Not fEmptyDate(FParamCon.dtaFinCom)) Then
  Begin
    FcdsDados.qryQuery.ParamByName('INICOM').AsDateTime := StrToDateDef(FParamCon.dtaIniCom,0);
    FcdsDados.qryQuery.ParamByName('FINCOM').AsDateTime := StrToDateDef(FParamCon.dtaFinCom,0);
  End
  Else If (Not fEmptyStr(FParamCon.edtDiaCom)) Then
    FcdsDados.qryQuery.ParamByName('DIACOM').AsInteger := StrToIntDef(FParamCon.edtDiaCom,0);

  If (Not fEmptyDate(FParamCon.dtaIniOrc)) And (Not fEmptyDate(FParamCon.dtaFinOrc)) Then
  Begin
    FcdsDados.qryQuery.ParamByName('INIORC').AsDateTime := StrToDateDef(FParamCon.dtaIniOrc,0);
    FcdsDados.qryQuery.ParamByName('FINORC').AsDateTime := StrToDateDef(FParamCon.dtaFinOrc,0);
  End
  Else If (Not fEmptyStr(FParamCon.edtDiaOrc)) Then
    FcdsDados.qryQuery.ParamByName('DIAORC').AsInteger := StrToIntDef(FParamCon.edtDiaOrc,0);

  If FParamCon.chkUtiCSC Then
  Begin
    If (Not fEmptyDate(FParamCon.dtaIniSem)) And (Not fEmptyDate(FParamCon.dtaFinSem)) Then
    Begin
      if not fEmptyStr(FParamCon.edtCodEmp) then
        pSetaParam(FParamCon.edtCodEmp, FParamCon.arrCodEmp, FstrCodEmp, 'CODEMP', FcdsDados.qryQuery)
      Else
        FcdsDados.qryQuery.ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;
      If Pos(':CLAFIS', FcdsDados.qryQuery.SQL.Text) > 0 Then
        FcdsDados.qryQuery.ParamByName('CLAFIS').AsString   := VS_strClaVen;
      FcdsDados.qryQuery.ParamByName('DTAINI').AsDateTime := StrToDateDef(FParamCon.dtaIniSem,0);
      FcdsDados.qryQuery.ParamByName('DTAFIN').AsDateTime := StrToDateDef(FParamCon.dtaFinSem,0);
    End
    Else
    If (Not fEmptyStr(FParamCon.edtDiaSem)) Then
    Begin
      if not fEmptyStr(FParamCon.edtCodEmp) then
        pSetaParam(FParamCon.edtCodEmp, FParamCon.arrCodEmp, FstrCodEmp, 'CODEMP', FcdsDados.qryQuery)
      Else
        FcdsDados.qryQuery.ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;
      If Pos(':CLAFIS', FcdsDados.qryQuery.SQL.Text) > 0 Then
        FcdsDados.qryQuery.ParamByName('CLAFIS').AsString := VS_strClaVen;
      FcdsDados.qryQuery.ParamByName('QTDSEM').AsInteger:= StrToIntDef(FParamCon.edtDiaSem, 0);
    End;

    If (Not fEmptyDate(FParamCon.dtaIniCCM)) And (Not fEmptyDate(FParamCon.dtaFinCCM)) Then
    Begin
      if not fEmptyStr(FParamCon.edtCodEmp) then
        pSetaParam(FParamCon.edtCodEmp, FParamCon.arrCodEmp, FstrCodEmp, 'CODEMP', FcdsDados.qryQuery)
      Else
        FcdsDados.qryQuery.ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;
      If Pos(':CLAFIS', FcdsDados.qryQuery.SQL.Text) > 0 Then
        FcdsDados.qryQuery.ParamByName('CLAFIS').AsString   := VS_strClaVen;
      FcdsDados.qryQuery.ParamByName('INICCM').AsDateTime := StrToDateDef(FParamCon.dtaIniCCM,0);
      FcdsDados.qryQuery.ParamByName('FINCCM').AsDateTime := StrToDateDef(FParamCon.dtaFinCCM,0);
    End
    Else
    If (Not fEmptyStr(FParamCon.edtDiaCCM)) Then
    Begin
      if not fEmptyStr(FParamCon.edtCodEmp) then
        pSetaParam(FParamCon.edtCodEmp, FParamCon.arrCodEmp, FstrCodEmp, 'CODEMP', FcdsDados.qryQuery)
      Else
        FcdsDados.qryQuery.ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;
      If Pos(':CLAFIS', FcdsDados.qryQuery.SQL.Text) > 0 Then
        FcdsDados.qryQuery.ParamByName('CLAFIS').AsString := VS_strClaVen;
      FcdsDados.qryQuery.ParamByName('QTDCCM').AsInteger:= StrToIntDef(FParamCon.edtDiaCCM, 0);
    End;

    If (Not fEmptyDate(FParamCon.dtaIniSeO)) And (Not fEmptyDate(FParamCon.dtaFinSeO)) Then
    Begin
      if not fEmptyStr(FParamCon.edtCodEmp) then
        pSetaParam(FParamCon.edtCodEmp, FParamCon.arrCodEmp, FstrCodEmp, 'CODEMP', FcdsDados.qryQuery)
      Else
        FcdsDados.qryQuery.ParamByName('CODEMP').AsString := strEmpAcessoUsuarioLogado;
      FcdsDados.qryQuery.ParamByName('DTINIO').AsDateTime := StrToDateDef(FParamCon.dtaIniSeO,0);
      FcdsDados.qryQuery.ParamByName('DTFINO').AsDateTime := StrToDateDef(FParamCon.dtaFinSeO,0);
    End
    Else If (Not fEmptyStr(FParamCon.edtDiaSeO)) Then
      FcdsDados.qryQuery.ParamByName('QTDSOR').AsInteger := StrToIntDef(FParamCon.edtDiaSeO, 0);
  End;

  If Not fEmptyStr(FstrCodAca) Then
    FcdsDados.qryQuery.ParamByName('CODACA').AsString := FstrCodAca;

  If FParamCon.chkOcoAbe  Then
  Begin
    pSetaParam(FParamCon.edtCodGoc, FParamCon.arrCodGoc, FstrCodGoc, 'CODGOC', FcdsDados.qryQuery);
    pSetaParam(FParamCon.edtCodToc, FParamCon.arrCodToc, FstrCodToc, 'CODTOC', FcdsDados.qryQuery);
  End;

end;

{ TParametroPrmGeracaoGlobal }

constructor TParametroPrmGeracaoGlobal.Create;
begin
  FObjCatalogoPromocao := TCatalogoPromocao.Create;
  FchkCatProm := False;
end;

destructor TParametroPrmGeracaoGlobal.Destroy;
begin

  inherited;

  If Assigned(FObjCatalogoPromocao) Then
    FreeAndNil(FObjCatalogoPromocao);
end;

end.
