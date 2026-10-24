unit untFatAltTipoAtendimentoIntf;

interface

uses untBaseIntf;

type
  IAltTipoAtendimento = interface(IBaseIntf)
    ['{0533CDEB-F04E-4616-8052-07ECBBB8B0E4}']
    function GetdtaDtEmis: TDateTime;
    function GetfltValDoc: Double;
    function GetstrCndPgt: String;
    function GetstrCodCli: String;
    function GetstrCodRep: String;
    function GetstrCodVen: String;
    function GetstrNomCli: String;
    function GetstrNomRep: String;
    function GetstrNomVen: String;
    function GetstrTipAteAtu: String;
    function GetstrTipAteNew: String;
    function GetstrCodEmp: String;
    function GetstrEspDoc: String;
    function GetstrNomEmp: String;
    function GetstrNumDoc: String;
    function GetAutoIncrem: String;
    function GetstrCodAteAtu: String;
    procedure SetdtaDtEmis(const Value: TDateTime);
    procedure SetfltValDoc(const Value: Double);
    procedure SetstrCndPgt(const Value: String);
    procedure SetstrCodCli(const Value: String);
    procedure SetstrCodRep(const Value: String);
    procedure SetstrCodVen(const Value: String);
    procedure SetstrNomCli(const Value: String);
    procedure SetstrNomRep(const Value: String);
    procedure SetstrNomVen(const Value: String);
    procedure SetstrTipAteAtu(const Value: String);
    procedure SetstrTipAteNew(const Value: String);
    procedure SetstrCodEmp(const Value: String);
    procedure SetstrEspDoc(const Value: String);
    procedure SetstrNomEmp(const Value: String);
    procedure SetstrNumDoc(const Value: String);
    procedure SetAutoIncrem(const Value: String);
    procedure SetstrCodAteAtu(const Value: String);
    property strCodCli   : String    read GetstrCodCli    write SetstrCodCli;
    property strNomCli   : String    read GetstrNomCli    write SetstrNomCli;
    property dtaDtEmis   : TDateTime read GetdtaDtEmis    write SetdtaDtEmis;
    property strCndPgt   : String    read GetstrCndPgt    write SetstrCndPgt;
    property strCodVen   : String    read GetstrCodVen    write SetstrCodVen;
    property strNomVen   : String    read GetstrNomVen    write SetstrNomVen;
    property strCodRep   : String    read GetstrCodRep    write SetstrCodRep;
    property strNomRep   : String    read GetstrNomRep    write SetstrNomRep;
    property fltValDoc   : Double    read GetfltValDoc    write SetfltValDoc;
    property strTipAteAtu: String    read GetstrTipAteAtu write SetstrTipAteAtu;
    property strTipAteNew: String    read GetstrTipAteNew write SetstrTipAteNew;
    property strNumDoc   : String    read GetstrNumDoc    write SetstrNumDoc;
    property strEspDoc   : String    read GetstrEspDoc    write SetstrEspDoc;
    property strCodEmp   : String    read GetstrCodEmp    write SetstrCodEmp;
    property strNomEmp   : String    read GetstrNomEmp    write SetstrNomEmp;
    property AutoIncrem  : String    read GetAutoIncrem   write SetAutoIncrem;
    property strCodAteAtu: String    read GetstrCodAteAtu write SetstrCodAteAtu;
  end;

implementation

end.
