unit untFatAltValorFreteSugestaoIntf;

interface

uses untBaseIntf;

type
  IAltValorFreteSugestao = interface(IBaseIntf)
  ['{69547827-86AD-434D-8697-0A5012B2B0D2}']
    function GetAutoIncrem: String;
    function GetdtaDtEmis: TDateTime;
    function GetfltBasIcm: Double;
    function GetfltBasIpi: Double;
    function GetfltBasTri: Double;
    function GetfltDesAce: Double;
    function GetfltTotNf: Double;
    function GetfltValFre: Double;
    function GetfltValFreNew: Double;
    function GetfltValIcm: Double;
    function GetfltValIpi: Double;
    function GetfltValPro: Double;
    function GetfltValTri: Double;
    function GetstrCndPgt: String;
    function GetstrCodCli: String;
    function GetstrCodEmp: String;
    function GetstrCodRep: String;
    function GetstrCodTra: String;
    function GetstrCodTraNew: String;
    function GetstrCodVen: String;
    function GetstrEspDoc: String;
    function GetstrNomCli: String;
    function GetstrNomEmp: String;
    function GetstrNomRep: String;
    function GetstrNomTra: String;
    function GetstrNomVen: String;
    function GetstrNumDoc: String;
    function GetstrNomTab: String;
    function GetfltValFreOld: Double;
    function GetstrTraLot: String;
    function GetstrTraLotNew: String;
    procedure SetAutoIncrem(const Value: String);
    procedure SetdtaDtEmis(const Value: TDateTime);
    procedure SetfltBasIcm(const Value: Double);
    procedure SetfltBasIpi(const Value: Double);
    procedure SetfltBasTri(const Value: Double);
    procedure SetfltDesAce(const Value: Double);
    procedure SetfltTotNf(const Value: Double);
    procedure SetfltValFre(const Value: Double);
    procedure SetfltValFreNew(const Value: Double);
    procedure SetfltValIcm(const Value: Double);
    procedure SetfltValIpi(const Value: Double);
    procedure SetfltValPro(const Value: Double);
    procedure SetfltValTri(const Value: Double);
    procedure SetstrCndPgt(const Value: String);
    procedure SetstrCodCli(const Value: String);
    procedure SetstrCodEmp(const Value: String);
    procedure SetstrCodRep(const Value: String);
    procedure SetstrCodTra(const Value: String);
    procedure SetstrCodTraNew(const Value: String);
    procedure SetstrCodVen(const Value: String);
    procedure SetstrEspDoc(const Value: String);
    procedure SetstrNomCli(const Value: String);
    procedure SetstrNomEmp(const Value: String);
    procedure SetstrNomRep(const Value: String);
    procedure SetstrNomTra(const Value: String);
    procedure SetstrNomVen(const Value: String);
    procedure SetstrNumDoc(const Value: String);
    procedure SetstrNomTab(const Value: String);
    procedure SetfltValFreOld(const Value: Double);
    procedure SetstrTraLot(const Value: String);
    procedure SetstrTraLotNew(const Value: String);
    property strNumDoc   : String    read GetstrNumDoc    write SetstrNumDoc;
    property strEspDoc   : String    read GetstrEspDoc    write SetstrEspDoc;
    property strCodEmp   : String    read GetstrCodEmp    write SetstrCodEmp;
    property strNomEmp   : String    read GetstrNomEmp    write SetstrNomEmp;
    property strCodCli   : String    read GetstrCodCli    write SetstrCodCli;
    property strNomCli   : String    read GetstrNomCli    write SetstrNomCli;
    property dtaDtEmis   : TDateTime read GetdtaDtEmis    write SetdtaDtEmis;
    property strCndPgt   : String    read GetstrCndPgt    write SetstrCndPgt;
    property strCodVen   : String    read GetstrCodVen    write SetstrCodVen;
    property strNomVen   : String    read GetstrNomVen    write SetstrNomVen;
    property strCodRep   : String    read GetstrCodRep    write SetstrCodRep;
    property strNomRep   : String    read GetstrNomRep    write SetstrNomRep;
    property strCodTra   : String    read GetstrCodTra    write SetstrCodTra;
    property strNomTra   : String    read GetstrNomTra    write SetstrNomTra;
    property strTraLot   : String    read GetstrTraLot    write SetstrTraLot;
    property fltBasIcm   : Double    read GetfltBasIcm    write SetfltBasIcm;
    property fltValIcm   : Double    read GetfltValIcm    write SetfltValIcm;
    property fltDesAce   : Double    read GetfltDesAce    write SetfltDesAce;
    property fltBasTri   : Double    read GetfltBasTri    write SetfltBasTri;
    property fltValTri   : Double    read GetfltValTri    write SetfltValTri;
    property fltValFre   : Double    read GetfltValFre    write SetfltValFre;
    property fltValPro   : Double    read GetfltValPro    write SetfltValPro;
    property fltBasIpi   : Double    read GetfltBasIpi    write SetfltBasIpi;
    property fltValIpi   : Double    read GetfltValIpi    write SetfltValIpi;
    property fltTotNf    : Double    read GetfltTotNf     write SetfltTotNf;
    property AutoIncrem  : String    read GetAutoIncrem   write SetAutoIncrem;
    property strNomTab   : String    read GetstrNomTab    write SetstrNomTab;
    property strCodTraNew: String    read GetstrCodTraNew write SetstrCodTraNew;
    property fltValFreNew: Double    read GetfltValFreNew write SetfltValFreNew;
    property fltValFreOld: Double    read GetfltValFreOld write SetfltValFreOld;
    property strTraLotNew: String    read GetstrTraLotNew write SetstrTraLotNew;
  End;

implementation

end.
