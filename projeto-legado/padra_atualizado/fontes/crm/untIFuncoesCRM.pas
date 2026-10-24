unit untIFuncoesCRM;

interface

uses
{$IFDEF LINUX}
  DBClient,
{$ELSE }
  Uni,
  UniClientDataSet,
{$ENDIF LINUX}
  untTypesCRM;

type

  IAtuOcoCrm = interface
    ['{E46FB848-6339-4D7F-8160-A4A8E4E0304C}']
    function getCodOco: String;
    function getDtaInc: TDateTime;
    function getHorInc: TDateTime;
    function getDtaCon: TDateTime;
    function getHorCon: TDateTime;
    function getOpeHis: String;
    function getCodOpe: String;
    function getDescri: String;
    function getInfAdc: String;

    //informacoes usadas pelo faturamento
    function getNumDoc: String;
    function getEspDoc: String;
    function getCodEmp: String;
    function getCodCli: String;
    function getNumOrc: String;
    function getEspOrc: String;
    function getAcaFat: TAcaoFatCRM;
    function getNumRom: String;
    function getCodMot: String;
    function getCodTra: String;
    function getDHBaix: String;
    function getNomRec: String;

    //informacoes usadas pela devolucao de produtos
    function getNumDev: String;
    function getGerCol: String;
    function getSeqGer: String;
    function getCdsDev: {$IFDEF LINUX} TClientDataSet {$ELSE } TUniClientDataSet {$ENDIF LINUX};

    //informacoes impressoes de etiquetas de clientes
    function getCliVen: String;
    function getCodToc: String;
    function getCodCoc: String;
    function getCliPriVen: String;
    function getCodAca: String;


    procedure setCodOco(const Value: String);
    procedure setDtaInc(const Value: TDateTime);
    procedure setHorInc(const Value: TDateTime);
    procedure setDtaCon(const Value: TDateTime);
    procedure setHorCon(const Value: TDateTime);
    procedure setOpeHis(const Value: String);
    procedure setCodOpe(const Value: String);
    procedure setDescri(const Value: String);
    procedure setInfAdc(const Value: String);

    //informacoes usadas pelo faturamento
    procedure setNumDoc(const Value: String);
    procedure setEspDoc(const Value: String);
    procedure setCodEmp(const Value: String);
    procedure setCodCli(const Value: String);
    procedure setNumOrc(const Value: String);
    procedure setEspOrc(const Value: String);
    procedure setAcaFat(const Value: TAcaoFatCRM);
    procedure setNumRom(const Value: String);
    procedure setCodMot(const Value: String);
    procedure setCodTra(const Value: String);
    procedure setDHBaix(const Value: String);
    procedure setNomRec(const Value: String);

    //informacoes usadas pela devolucao de produtos
    procedure setNumDev(const Value: String);
    procedure setGerCol(const Value: String);
    procedure setSeqGer(const Value: String);
    procedure setCdsDev(const Value: {$IFDEF LINUX} TClientDataSet {$ELSE } TUniClientDataSet {$ENDIF LINUX});

    //informacoes impressoes de etiquetas de clientes
    procedure setCliVen(const Value: String);
    procedure setCodToc(const Value: String);
    procedure setCodCoc(const Value: String);
    procedure setCliPriVen(const Value: String);
    procedure setCodAca(const Value: String);

    function getDtaAge: TDateTime;
    function getHorAge: TDateTime;
    procedure setDtaAge(const Value: TDateTime);
    procedure setHorAge(const Value: TDateTime);

    function getEmpFat: String;
    procedure setEmpFat(const Value: String);

    function GetCodSit: String;
    procedure SetCodSit(const Value: String);

    procedure SetTip_Fc(const Value: String);
    function GetTip_Fc: String;
    function GetblnPd_Dsm: Boolean;
    procedure SetblnPd_Dsm(const Value: Boolean);

    property strCodOco: String Read getCodOco Write setCodOco;
    property strDtaInc: TDateTime Read getDtaInc Write setDtaInc;
    property strHorInc: TDateTime Read getHorInc Write setHorInc;
    property strDtaAge: TDateTime Read getDtaAge Write setDtaAge;
    property strHorAge: TDateTime Read getHorAge Write setHorAge;
    property strDtaCon: TDateTime Read getDtaCon Write setDtaCon;
    property strHorCon: TDateTime Read getHorCon Write setHorCon;
    property strOpeHis: String Read getOpeHis Write setOpeHis;
    property strCodOpe: String Read getCodOpe Write setCodOpe;
    property strDescri: String Read getDescri Write setDescri;
    property strInfAdc: String Read getInfAdc Write setInfAdc;
    property strCodSit: String Read GetCodSit Write SetCodSit;
    property strTip_Fc : String Read GetTip_Fc Write SetTip_Fc;

    //informacoes usadas pelo faturamento
    property strNumDoc: String read getNumDoc write SetNumDoc;
    property strEspDoc: String read getEspDoc write SetEspDoc;
    property strCodEmp: String read getCodEmp write SetCodEmp;
    property strCodCli: String read getCodCli write SetCodCli;
    property strNumOrc: String read getNumOrc write SetNumOrc;
    property strEspOrc: String read getEspOrc write SetEspOrc;
    property strEmpFat: String read getEmpFat write setEmpFat;
    property afcAcaFat: TAcaoFatCRM read getAcaFat write setAcaFat;
    property strNumRom: String read getNumRom write setNumRom;
    property strCodMot: String read getCodMot write setCodMot;
    property strCodTra: String read getCodTra write setCodTra;
    property strDHBaix: String read getDHBaix write setDHBaix;
    property strNomRec: String read getNomRec write setNomRec;

    //informacoes usadas pela devolucao de produtos
    property strNumDev: String read getNumDev write setNumDev;
    property strGerCol: String read getGerCol write setGerCol;
    property strSeqGer: String read getSeqGer write setSeqGer;
    property cdsCdsDev: {$IFDEF LINUX} TClientDataSet {$ELSE } TUniClientDataSet {$ENDIF LINUX} read getCdsDev write setCdsDev;

    //informacoes impressoes de etiquetas de clientes
    property strCliVen: String read getCliVen write setCliVen;
    property strCodToc: String read getCodToc write setCodToc;
    property strCodCoc: String read getCodCoc write setCodCoc;
    property strCliPriVen: String read getCliPriVen write setCliPriVen;

    property strCodAca: String read getCodAca write setCodAca;
    property blnPDGeradoDesmembramento: Boolean read GetblnPd_Dsm write SetblnPd_Dsm;

    procedure pInsereHistoricoOcorrencia;
    procedure pAtualizaOcorrencia(ACodCli: String = '');
    procedure pGravarMensagemOperadorOcorrencia(Const tpAcao: TTipoOperacaoOcorrencia; const strCodOco: String; const strCodEmp: String; const strTip_Fc: String);
  end;

  IFuncoesCRM = interface
    ['{14152303-24C0-4AF1-BF56-9AC427E90C59}']
    function fAtualizaInformacoesCRM(strNumDoc_CRM, strEspDoc_CRM,
      strCodEmp_CRM, strCodCli_CRM, strNumOrc_CRM, strEspOrc_CRM,
      strOpeDes_CRM: String; afcAcaFat_CRM: TAcaoFatCRM;
      strEmpFat_CRM: String = ''; strCpfCli_CRM: String = '';
      strCodCliAnt_CRM: String = ''): IAtuOcoCrm;

    function fRetornaCodigoOcorrencia(strNumDoc, strEspDoc, strCodCli,
      strCodEmp, strNumRom: String; strNumOrc: String = '';
      strEspOrc: String = ''): String;
  end;

   IUpdateOccurrenceCRM = Interface
  ['{6D9E4405-FB4B-47D7-A784-CE773814FBAB}']
    function NumDoc(const AValue: String): IUpdateOccurrenceCRM;
    function EspDoc(const AValue: String): IUpdateOccurrenceCRM;
    function CodEmp(const AValue: String): IUpdateOccurrenceCRM;
    function CodCli(const AValue: String): IUpdateOccurrenceCRM;
    function NumOrc(const AValue: String): IUpdateOccurrenceCRM;
    function EspOrc(const AValue: String): IUpdateOccurrenceCRM;
    function EmpFat(const AValue: String): IUpdateOccurrenceCRM;
    function CodOpe(const AValue: String): IUpdateOccurrenceCRM;
    function Descri(const AValue: String): IUpdateOccurrenceCRM;
    function InfAdc(const AValue: String): IUpdateOccurrenceCRM;
    function AcaFat(const AValue: TAcaoFatCRM): IUpdateOccurrenceCRM;
    function Tip_Fc(const AValue: String): IUpdateOccurrenceCRM;
    function NumRom(const AValue: String): IUpdateOccurrenceCRM;
    function CodMot(const AValue: String): IUpdateOccurrenceCRM;
    function CodTra(const AValue: String): IUpdateOccurrenceCRM;
    function NomCli(const AValue: String): IUpdateOccurrenceCRM;
    function CodIte(const AValue: String): IUpdateOccurrenceCRM;
    function DesIte(const AValue: String): IUpdateOccurrenceCRM;
    function QtdIte(const AValue: Double): IUpdateOccurrenceCRM;
    procedure pRun;
    function blnImpSfa(const AValue: Boolean) : IUpdateOccurrenceCRM;
    function strNomFrm(const AValue: String): IUpdateOccurrenceCRM;
  end;

  IInvokerUpdateOcurrenceCRM = Interface
  ['{4F58BE94-5B4D-4F65-B3B6-F459B10FA4E0}']
    procedure pAdd(ACommand: IUpdateOccurrenceCRM);
    procedure pRun;
  end;

  IDeleteOccurrenceCRM = Interface
  ['{57D8910A-E8EC-43B9-8B6B-6B83B1F60D5A}']
    function NumDoc(const AValue: String): IDeleteOccurrenceCRM;
    function EspDoc(const AValue: String): IDeleteOccurrenceCRM;
    function CodEmp(const AValue: String): IDeleteOccurrenceCRM;
    procedure pDelete;
    function NomFrm(const AValue: String): IDeleteOccurrenceCRM;
  end;

  ICategoriaCrm = Interface ['{2D4891F6-473D-4567-BC34-A72F9A9B328E}']
    function strAutInc(const AValue: String): ICategoriaCrm;
    function strCodCat(const AValue: String): ICategoriaCrm;
    function strDescri(const AValue: String): ICategoriaCrm;

    function GetAutInc: String;
    function GetCodCat: String;
    function GetDescri: String;

    procedure SetAutInc(const AValue: String);
    procedure SetCodCat(const AValue: String);
    procedure SetDescri(const AValue: String);

    property AutInc: String read GetAutInc write SetAutInc;
    property CodCat: String read GetCodCat write SetCodCat;
    property Descri: String read GetDescri write SetDescri;

    function fAtualizarCategoriaProspecto(const strCatAtu: String; strCodPro: String): Boolean;
    procedure pAtualizarCadastroProspectoPeloCompl(strCodCoc: String; strCodPro: String);
  End;

  ILogCatProspecto = Interface['{B5F807CD-19A8-4586-981A-1AA4F1AA1582}']
    function strAutInc(const AValue: String): ILogCatProspecto;
    function strSeqPro(const AValue: String): ILogCatProspecto;
    function strDtaAlt(const AValue: TDateTime): ILogCatProspecto;
    function strHraAlt(const AValue: TDateTime): ILogCatProspecto;
    function strOpeAlt(const AValue: String): ILogCatProspecto;
    function strCatAnt(const AValue: String): ILogCatProspecto;
    function strCatAtu(const AValue: String): ILogCatProspecto;
    function strCodMot(const AValue: String): ILogCatProspecto;
    function strStaPro(const AValue: String): ILogCatProspecto;
    function strEmpDoc(const AValue: String): ILogCatProspecto;
    function strEspDoc(const AValue: String): ILogCatProspecto;
    function strNumDoc(const AValue: String): ILogCatProspecto;

    function GetAutInc: String;
    function GetSeqPro: String;
    function GetDtaAlt: TDateTime;
    function GetHraAlt: TDateTime;
    function GetOpeAlt: String;
    function GetCatAnt: String;
    function GetCatAtu: String;
    function GetCodMot: String;
    function GetStaPro: String;
    function GetEmpDoc: String;
    function GetEspDoc: String;
    function GetNumDoc: String;

    procedure SetAutInc(const AValue: String);
    procedure SetSeqPro(const AValue: String);
    procedure SetDtaAlt(const AValue: TDateTime);
    procedure SetHraAlt(const AValue: TDateTime);
    procedure SetOpeAlt(const AValue: String);
    procedure SetCatAnt(const AValue: String);
    procedure SetCatAtu(const AValue: String);
    procedure SetCodMot(const AValue: String);
    procedure SetStaPro(const AValue: String);
    procedure SetEmpDoc(const AValue: String);
    procedure SetEspDoc(const AValue: String);
    procedure SetNumDoc(const AValue: String);

    property AutInc: String read GetAutInc write SetAutInc;
    property SeqPro: String read GetSeqPro write SetSeqPro;
    property DtaAlt: TDateTime read GetDtaAlt write SetDtaAlt;
    property HraAlt: TDateTime read GetHraAlt write SetHraAlt;
    property OpeAlt: String read GetOpeAlt write SetOpeAlt;
    property CatAnt: String read GetCatAnt write SetCatAnt;
    property CatAtu: String read GetCatAtu write SetCatAtu;
    property CodMot: String read GetCodMot write SetCodMot;
    property StaPro: String read GetStaPro write SetStaPro;
    property EmpDoc: String read GetEmpDoc write SetEmpDoc;
    property EspDoc: String read GetEspDoc write SetEspDoc;
    property NumDoc: String read GetNumDoc write SetNumDoc;

    procedure pGravaLogAlteracaoCategoria;
    procedure pRemoverLogCat(const strCatRem: String);
    procedure pRemoverLogCatOportunidade;
    procedure pRemoverLogCatVenda;
  End;

  ILogAltMovOco = Interface ['{70849FA0-EB33-4906-B2EE-CE97CA375456}']
    function GetAutInc: String;
    function GetCodOco: String;
    function GetCliAnt: String;
    function GetCodCli: String;
    function GetDescri: String;
    function GetNomFrm: String;

    procedure pGravarLogAlteracaoCliente;

    function strCodOco(const AValue: String): ILogAltMovOco;
    function strDescri(const AValue: String): ILogAltMovOco;
    function strNomFrm(const AValue: String): ILogAltMovOco;
    function strCodCli(const AValue: String): ILogAltMovOco;
    function strCliAnt(const AValue: String): ILogAltMovOco;

    property AutInc: String read GetAutInc;
    property CodOco: String read GetCodOco;
    property Descri: String read GetDescri;
    property NomFrm: String read GetNomFrm;
    property CodCli: String read GetCodCli;
    property CliAnt: String read GetCliAnt;
  End;


implementation

end.
