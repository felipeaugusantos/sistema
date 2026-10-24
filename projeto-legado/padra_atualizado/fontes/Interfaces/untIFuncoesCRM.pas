unit untIFuncoesCRM;

interface

uses
  untTypesCRM, UniClientDataSet;

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
    function getCdsDev: TUniClientDataSet;

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
    procedure setCdsDev(const Value: TUniClientDataSet);

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
    property cdsCdsDev: TUniClientDataSet read getCdsDev write setCdsDev;

    //informacoes impressoes de etiquetas de clientes
    property strCliVen: String read getCliVen write setCliVen;
    property strCodToc: String read getCodToc write setCodToc;
    property strCodCoc: String read getCodCoc write setCodCoc;
    property strCliPriVen: String read getCliPriVen write setCliPriVen;

    property strCodAca: String read getCodAca write setCodAca;

    procedure pInsereHistoricoOcorrencia;
    procedure pAtualizaOcorrencia;
  end;

  IFuncoesCRM = interface
    ['{14152303-24C0-4AF1-BF56-9AC427E90C59}']
    function fAtualizaInformacoesCRM(strNumDoc_CRM, strEspDoc_CRM,
      strCodEmp_CRM, strCodCli_CRM, strNumOrc_CRM, strEspOrc_CRM,
      strOpeDes_CRM: String; afcAcaFat_CRM: TAcaoFatCRM;
      strEmpFat_CRM: String = ''): IAtuOcoCrm;

    function fRetornaCodigoOcorrencia(strNumDoc, strEspDoc, strCodCli,
      strCodEmp, strNumRom: String; strNumOrc: String = '';
      strEspOrc: String = ''): String;
  end;

implementation

end.
