unit untImpressaoDelLamaIntf;

interface

uses untBaseIntf;

type
  IImpressaoDelLamaIntf = interface(IBaseIntf)
  ['{6FD083E0-C7FD-4FFC-8F27-0C74A7FBC1E4}']
    function GetdtaDtaDoc: TDateTime;
    function GetstrBaiCli: String;
    function GetstrCepCli: String;
    function GetstrCpfCgc: String;
    function GetstrCidCli: String;
    function GetstrConCli: String;
    function GetstrEndCli: String;
    function GetstrFaxCli: String;
    function GetstrFonCli: String;
    function GetstrNomCli: String;
    function GetstrNumDoc: String;
    function GetstrRg_Ie_: String;
    procedure SetdtaDtaDoc(const Value: TDateTime);
    procedure SetstrBaiCli(const Value: String);
    procedure SetstrCepCli(const Value: String);
    procedure SetstrCpfCgc(const Value: String);
    procedure SetstrCidCli(const Value: String);
    procedure SetstrConCli(const Value: String);
    procedure SetstrEndCli(const Value: String);
    procedure SetstrFaxCli(const Value: String);
    procedure SetstrFonCli(const Value: String);
    procedure SetstrNomCli(const Value: String);
    procedure SetstrNumDoc(const Value: String);
    procedure SetstrRg_Ie_(const Value: String);
    function GetstrCodEmp: String;
    procedure SetstrCodEmp(const Value: String);
    function GetdtaDtaPre: TDateTime;
    function GetdtaDtaPro: TDateTime;
    function GetfltTotFre: Double;
    function GetstrCodFpg: String;
    function GetstrCodCnd: String;
    function GetstrEndEnt: String;
    function GetstrMen001: String;
    function GetstrMen002: String;
    procedure SetdtaDtaPre(const Value: TDateTime);
    procedure SetdtaDtaPro(const Value: TDateTime);
    procedure SetfltTotFre(const Value: Double);
    procedure SetstrCodFpg(const Value: String);
    procedure SetstrCodCnd(const Value: String);
    procedure SetstrEndEnt(const Value: String);
    procedure SetstrMen001(const Value: String);
    procedure SetstrMen002(const Value: String);
    function GetstrEspDoc: String;
    procedure SetstrEspDoc(const Value: String);
    function GetstrDesImp: String;
    function GetstrNomFil: String;
    procedure SetstrDesImp(const Value: String);
    procedure SetstrNomFil(const Value: String);
    function GetstrNomPro: String;
    procedure SetstrNomPro(const Value: String);
    function GetblnEntFut: Boolean;
    procedure SetblnEntFut(const Value: Boolean);
    function GetstrMenDoc: String;
    procedure SetstrMenDoc(const Value: String);
    property strNumDoc: String     read GetstrNumDoc Write SetstrNumDoc;
    property dtaDtaDoc: TDateTime  read GetdtaDtaDoc Write SetdtaDtaDoc;
    property strNomCli: String     read GetstrNomCli Write SetstrNomCli;
    property strConCli: String     read GetstrConCli Write SetstrConCli;
    property strCpfCgc: String     read GetstrCpfCgc Write SetstrCpfCgc;
    property strRg_Ie_: String     read GetstrRg_Ie_ Write SetstrRg_Ie_;
    property strEndCli: String     read GetstrEndCli Write SetstrEndCli;
    property strBaiCli: String     read GetstrBaiCli Write SetstrBaiCli;
    property strCidCli: String     read GetstrCidCli Write SetstrCidCli;
    property strCepCli: String     read GetstrCepCli Write SetstrCepCli;
    property strFonCli: String     read GetstrFonCli Write SetstrFonCli;
    property strFaxCli: String     read GetstrFaxCli Write SetstrFaxCli;
    property strCodEmp: String     read GetstrCodEmp Write SetstrCodEmp;
    property dtaDtaPro: TDateTime  read GetdtaDtaPro Write SetdtaDtaPro;
    property fltTotFre: Double     read GetfltTotFre Write SetfltTotFre;
    property strCodFpg: String     read GetstrCodFpg Write SetstrCodFpg;
    property strCodCnd: String     read GetstrCodCnd Write SetstrCodCnd;
    property dtaDtaPre: TDateTime  read GetdtaDtaPre Write SetdtaDtaPre;
    property strEndEnt: String     read GetstrEndEnt Write SetstrEndEnt;
    property strMen001: String     read GetstrMen001 Write SetstrMen001;
    property strMen002: String     read GetstrMen002 Write SetstrMen002;
    property strEspDoc: String     read GetstrEspDoc Write SetstrEspDoc;
    property strDesImp: String     read GetstrDesImp Write SetstrDesImp;
    property strNomFil: String     read GetstrNomFil Write SetstrNomFil;
    property strNomPro: String     read GetstrNomPro Write SetstrNomPro;
    property blnEntFut: Boolean    read GetblnEntFut Write SetblnEntFut;
    property strMenDoc: String    read GetstrMenDoc Write SetstrMenDoc;
  End;

implementation

end.
