unit untRelFatMetasVendedorFreteIntf;

interface

uses untBaseIntf, untRelFatMetasVendedorFreteTypes, frxClass, UniClientDataSet;

type
  IMetasVendedorFrete = interface(IBaseIntf)
  ['{76127E92-F3FE-42F2-AAEB-1F34A1FBB64C}']
    function GetcmsCodDep: TConsultaMultiSelecao;
    function GetcmsCodEmp: TConsultaMultiSelecao;
    function GetcmsCodVen: TConsultaMultiSelecao;
    function GetintDiaFat: Integer;
    function GetstrMesFin: String;
    function GetstrMesIni: String;
    function GettdrDestino: TDestinoRelatorio;
    function GetteoEmpOri: TEmpresaOrigem;
    function GettorOpcao: TOpcaoRelatorio;
    function GetttvTipVen: TTipoVendedor;
    function GetfrxRel: TfrxReport;
    function GetstrNomFrm: String;
    function GetstrTipImp: String;
    function GetstrNomImp: String;
    function GetcdsRelatorio: TUniClientDataSet;
    procedure SetcmsCodDep(const Value: TConsultaMultiSelecao);
    procedure SetcmsCodEmp(const Value: TConsultaMultiSelecao);
    procedure SetcmsCodVen(const Value: TConsultaMultiSelecao);
    procedure SetintDiaFat(const Value: Integer);
    procedure SetstrMesFin(const Value: String);
    procedure SetstrMesIni(const Value: String);
    procedure SettdrDestino(const Value: TDestinoRelatorio);
    procedure SetteoEmpOri(const Value: TEmpresaOrigem);
    procedure SettorOpcao(const Value: TOpcaoRelatorio);
    procedure SetttvTipVen(const Value: TTipoVendedor);
    procedure SetfrxRel(const Value: TfrxReport);
    procedure SetstrNomFrm(const Value: String);
    procedure SetstrTipImp(const Value: String);
    procedure SetstrNomImp(const Value: String);
    procedure SetcdsRelatorio(const Value: TUniClientDataSet);
    property strMesIni: String                Read GetstrMesIni    Write SetstrMesIni;
    property strMesFin: String                Read GetstrMesFin    Write SetstrMesFin;
    property intDiaFat: Integer               Read GetintDiaFat    Write SetintDiaFat;
    property cmsCodVen: TConsultaMultiSelecao Read GetcmsCodVen    Write SetcmsCodVen;
    property cmsCodEmp: TConsultaMultiSelecao Read GetcmsCodEmp    Write SetcmsCodEmp;
    property cmsCodDep: TConsultaMultiSelecao Read GetcmsCodDep    Write SetcmsCodDep;
    property teoEmpOri: TEmpresaOrigem        Read GetteoEmpOri    Write SetteoEmpOri;
    property ttvTipVen: TTipoVendedor         Read GetttvTipVen    Write SetttvTipVen;
    property torOpcao : TOpcaoRelatorio       Read GettorOpcao     Write SettorOpcao;
    property tdrDestino: TDestinoRelatorio    Read GettdrDestino   Write SettdrDestino;
    property frxRel    : TfrxReport           Read GetfrxRel       Write SetfrxRel;
    property strNomFrm : String               Read GetstrNomFrm    Write SetstrNomFrm;
    property strTipImp : String               Read GetstrTipImp    Write SetstrTipImp;
    property strNomImp : String               Read GetstrNomImp    Write SetstrNomImp;
    property cdsRelatorio: TUniClientDataSet  Read GetcdsRelatorio Write SetcdsRelatorio;
  End;

implementation

end.
