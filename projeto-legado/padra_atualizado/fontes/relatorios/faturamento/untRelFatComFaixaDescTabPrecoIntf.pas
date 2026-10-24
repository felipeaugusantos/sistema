unit untRelFatComFaixaDescTabPrecoIntf;

interface

uses untBaseIntf, EditFocus, untTypesSistema;

type
  IRelFatComFaixaDescTabPreco = interface(IBaseIntf)
  ['{B3D5E45D-C23A-448A-A5D6-BD61E7E787BD}']
    function GetCodVen: TConsultasArray;
    function GetComEmp: TConsultasArray;
    function GetDepIte: TConsultasArray;
    function GetDepVen: TConsultasArray;
    function GetDesRel: String;
    function GetDtaFin: TDateTime;
    function GetDtaIni: TDateTime;
    function GetOpcVen: Integer;
    function GetTipRel: Integer;
    function GetTipVen: Integer;
    procedure SetCodVen(const Value: TConsultasArray);
    procedure SetComEmp(const Value: TConsultasArray);
    procedure SetDepIte(const Value: TConsultasArray);
    procedure SetDepVen(const Value: TConsultasArray);
    procedure SetDesRel(const Value: String);
    procedure SetDtaFin(const Value: TDateTime);
    procedure SetDtaIni(const Value: TDateTime);
    procedure SetOpcVen(const Value: Integer);
    procedure SetTipRel(const Value: Integer);
    procedure SetTipVen(const Value: Integer);
    function GetTipImp: String;
    procedure SetTipImp(const Value: String);
    function GetNomFrm: String;
    procedure SetNomFrm(const Value: String);

    function GetEdtCodDep: TEditFocus;
    function GetEdtCodEmp: TEditFocus;
    function GetEdtCodVen: TEditFocus;
    function GetEdtDesDep: TEditFocus;
    function GetEdtDesDepIte: TEditFocus;
    function GetEdtDesEmp: TEditFocus;
    function GetEdtNomVen: TEditFocus;
    function GetEdtCodDepIte: TEditFocus;
    function GetArrTipOpe: TarrTipOpe;
    procedure SetEdtCodDep(const Value: TEditFocus);
    procedure SetEdtCodDepIte(const Value: TEditFocus);
    procedure SetEdtCodEmp(const Value: TEditFocus);
    procedure SetEdtCodVen(const Value: TEditFocus);
    procedure SetEdtDesDep(const Value: TEditFocus);
    procedure SetEdtDesDepIte(const Value: TEditFocus);
    procedure SetEdtDesEmp(const Value: TEditFocus);
    procedure SetEdtNomVen(const Value: TEditFocus);
    procedure SetArrTipOpe(const Value: TarrTipOpe);

    function GetDepProduto: String;
    function GetDepVendedor: String;
    function GetEmpresa: String;
    function GetVendedor: String;
    procedure SetDepProduto(const Value: String);
    procedure SetDepVendedor(const Value: String);
    procedure SetEmpresa(const Value: String);
    procedure SetVendedor(const Value: String);

    property dtaDtaIni : TDateTime       read GetDtaIni write SetDtaIni;
    property dtaDtaFin : TDateTime       read GetDtaFin write SetDtaFin;
    property intOpcVen : Integer         read GetOpcVen write SetOpcVen;
    property intTipVen : Integer         read GetTipVen write SetTipVen;
    property arrCodVen : TConsultasArray read GetCodVen write SetCodVen;
    property arrCodEmp : TConsultasArray read GetComEmp write SetComEmp;
    property arrDepVen : TConsultasArray read GetDepVen write SetDepVen;
    property arrDepIte : TConsultasArray read GetDepIte write SetDepIte;
    property intTipRel : Integer         read GetTipRel write SetTipRel;
    property strDesRel : String          read GetDesRel write SetDesRel;
    property strTipImp : String          read GetTipImp write SetTipImp;
    property strNomFrm : String          read GetNomFrm write SetNomFrm;

    property edtCodVen    : TEditFocus read GetEdtCodVen    write SetEdtCodVen;
    property edtNomVen    : TEditFocus read GetEdtNomVen    write SetEdtNomVen;
    property edtCodEmp    : TEditFocus read GetEdtCodEmp    write SetEdtCodEmp;
    property edtDesEmp    : TEditFocus read GetEdtDesEmp    write SetEdtDesEmp;
    property edtCodDep    : TEditFocus read GetEdtCodDep    write SetEdtCodDep;
    property edtDesDep    : TEditFocus read GetEdtDesDep    write SetEdtDesDep;
    property edtCodDepIte : TEditFocus read GetEdtCodDepIte write SetEdtCodDepIte;
    property edtDesDepIte : TEditFocus read GetEdtDesDepIte write SetEdtDesDepIte;

    property strVendedor    : String read GetVendedor    write SetVendedor;
    property strDepProduto  : String read GetDepProduto  write SetDepProduto;
    property strDepVendedor : String read GetDepVendedor write SetDepVendedor;
    property strEmpresa     : String read GetEmpresa     write SetEmpresa;
    property arrTipOpe      : TarrTipOpe read GetArrTipOpe write SetArrTipOpe;
  end;

implementation

end.
