unit untImpressaoJvVidrosIntf;

interface

uses untBaseIntf, untDespesasFaturamento;

type
  IImpressaoJvVidrosIntf = interface(IBaseIntf)
  ['{41D623EF-A8A5-490B-B15A-B6D11A4F8CC9}']
    function GetdtaDtaDoc: TDateTime;
    function GetdtaHorDoc: TDateTime;
    function GetfltPerCom: Double;
    function GetstrCndPgt: String;
    function GetstrCodCli: String;
    function GetstrCodEmp: String;
    function GetstrCodPro: String;
    function GetstrCodVen: String;
    function GetstrCodDig: String;
    function GetstrEntCli: String;
    function GetstrEspDoc: String;
    function GetstrMensag: String;
    function GetstrNumDoc: String;
    function GetfltDesEsp: Double;
    function GetfltDesAce: Double;
    function GetfltTotDoc: Double;
    function GetfltTotFre: Double;
    function GetstrBaiCli: String;
    function GetstrCepCli: String;
    function GetstrCidCli: String;
    function GetstrCpfCgc: String;
    function GetstrEndCli: String;
    function GetstrFonCli: String;
    function GetstrNomCli: String;
    function GetstrRg_Ie_: String;
    function GetstrDesImp: String;
    function GetstrNomFil: String;
    function GetstrTipImp: String;
    function GetstrTipNomEmp: String;
    function GetstrTipExp: String;
    function GetblnComPre: Boolean;
    function GetobjDespes: TDespesasFaturamento;
    procedure SetdtaDtaDoc(const Value: TDateTime);
    procedure SetdtaHorDoc(const Value: TDateTime);
    procedure SetfltPerCom(const Value: Double);
    procedure SetstrCndPgt(const Value: String);
    procedure SetstrCodCli(const Value: String);
    procedure SetstrCodEmp(const Value: String);
    procedure SetstrCodPro(const Value: String);
    procedure SetstrCodVen(const Value: String);
    procedure SetstrCodDig(const Value: String);
    procedure SetstrEntCli(const Value: String);
    procedure SetstrEspDoc(const Value: String);
    procedure SetstrMensag(const Value: String);
    procedure SetstrNumDoc(const Value: String);
    procedure SetfltDesEsp(const Value: Double);
    procedure SetfltDesAce(const Value: Double);
    procedure SetfltTotDoc(const Value: Double);
    procedure SetfltTotFre(const Value: Double);
    procedure SetstrBaiCli(const Value: String);
    procedure SetstrCepCli(const Value: String);
    procedure SetstrCidCli(const Value: String);
    procedure SetstrCpfCgc(const Value: String);
    procedure SetstrEndCli(const Value: String);
    procedure SetstrFonCli(const Value: String);
    procedure SetstrNomCli(const Value: String);
    procedure SetstrRg_Ie_(const Value: String);
    procedure SetstrDesImp(const Value: String);
    procedure SetstrNomFil(const Value: String);
    procedure SetstrTipImp(const Value: String);
    procedure SetstrTipNomEmp(const Value: String);
    procedure SetstrTipExp(const Value: String);
    procedure SetblnComPre(const Value: Boolean);
    procedure SetObjDespes(const Value: TDespesasFaturamento);
    property strNumDoc: String    Read GetstrNumDoc Write SetstrNumDoc;
    property strEspDoc: String    Read GetstrEspDoc Write SetstrEspDoc;
    property strCodEmp: String    Read GetstrCodEmp Write SetstrCodEmp;
    property strCodCli: String    Read GetstrCodCli Write SetstrCodCli;
    property strEntCli: String    Read GetstrEntCli Write SetstrEntCli;
    property strCndPgt: String    Read GetstrCndPgt Write SetstrCndPgt;
    property strCodVen: String    Read GetstrCodVen Write SetstrCodVen;
    property strCodDig: String    Read GetstrCodDig Write SetstrCodDig;
    property strMensag: String    Read GetstrMensag Write SetstrMensag;
    property dtaDtaDoc: TDateTime Read GetdtaDtaDoc Write SetdtaDtaDoc;
    property dtaHorDoc: TDateTime Read GetdtaHorDoc Write SetdtaHorDoc;
    property strCodPro: String    Read GetstrCodPro Write SetstrCodPro;
    property fltPerCom: Double    Read GetfltPerCom Write SetfltPerCom;
    property fltTotFre: Double    Read GetfltTotFre Write SetfltTotFre;
    property fltDesEsp: Double    Read GetfltDesEsp Write SetfltDesEsp;
    property fltDesAce: Double    Read GetfltDesAce Write SetfltDesAce;
    property fltTotDoc: Double    Read GetfltTotDoc Write SetfltTotDoc;
    property strNomCli: String    Read GetstrNomCli Write SetstrNomCli;
    property strEndCli: String    Read GetstrEndCli Write SetstrEndCli;
    property strBaiCli: String    Read GetstrBaiCli Write SetstrBaiCli;
    property strCidCli: String    Read GetstrCidCli Write SetstrCidCli;
    property strCpfCgc: String    Read GetstrCpfCgc Write SetstrCpfCgc;
    property strFonCli: String    Read GetstrFonCli Write SetstrFonCli;
    property strRg_Ie_: String    Read GetstrRg_Ie_ Write SetstrRg_Ie_;
    property strCepCli: String    Read GetstrCepCli Write SetstrCepCli;
    property strDesImp: String    Read GetstrDesImp Write SetstrDesImp;
    property strNomFil: String    Read GetstrNomFil Write SetstrNomFil;
    property strTipImp: String    Read GetstrTipImp Write SetstrTipImp;
    property strTipNomEmp: String Read GetstrTipNomEmp Write SetstrTipNomEmp;
    property strTipExp: String    Read GetstrTipExp Write SetstrTipExp;
    property blnComPre: Boolean   Read GetblnComPre Write SetblnComPre;
    property objDespesas: TDespesasFaturamento  Read GetObjDespes Write SetObjDespes;
  End;

implementation

end.
