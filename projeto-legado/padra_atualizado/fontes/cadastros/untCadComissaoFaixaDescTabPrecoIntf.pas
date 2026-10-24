unit untCadComissaoFaixaDescTabPrecoIntf;

interface

uses
  untBaseIntf;

type
  ICadComissaoFaixaDescTabPreco = interface(IBaseIntf)
  ['{DA60C4DC-9960-4244-B9FA-4C3BC222B83E}']
    function GetComEmp: String;
    function GetComPra: Double;
    function GetComVis: Double;
    function GetDesFin: Double;
    function GetDesIni: Double;
    function GetTabPre: String;
    function GetTipOpe: String;
    procedure SetCodEmp(const Value: String);
    procedure SetComPra(const Value: Double);
    procedure SetComVis(const Value: Double);
    procedure SetDesFin(const Value: Double);
    procedure SetDesIni(const Value: Double);
    procedure SetTabPre(const Value: String);
    procedure SetTipOpe(const Value: String);
    property strTabPre : String read GetTabPre write SetTabPre;
    property strTipOpe : String read GetTipOpe write SetTipOpe;
    property fltDesIni : Double read GetDesIni write SetDesIni;
    property fltDesFin : Double read GetDesFin write SetDesFin;
    property fltComVis : Double read GetComVis write SetComVis;
    property fltComPra : Double read GetComPra write SetComPra;
    property strCodEmp : String read GetComEmp write SetCodEmp;
  end;

implementation

end.
