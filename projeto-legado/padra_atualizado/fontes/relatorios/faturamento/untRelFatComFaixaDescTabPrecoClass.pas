unit untRelFatComFaixaDescTabPrecoClass;

interface

uses untBaseClass, untRelFatComFaixaDescTabPrecoIntf, EditFocus, untTypesSistema;

type
  TRelFatComFaixaDescTabPrecoClass = Class(TBaseClass, IRelFatComFaixaDescTabPreco)
  private
    FdtaDtaIni: TDateTime;
    FdtaDtaFin: TDateTime;
    FintOpcVen: Integer; // 0-Vendedor 1  1-Vendedor 2          2-Digitador                 3-Representante
    FintTipVen: Integer; // 0-Interno     1-Rep. Externo Loja   2-Rep.Externo Distribuidor  3-Todos
    FarrCodVen: TConsultasArray;
    FarrCodEmp: TConsultasArray;
    FarrDepVen: TConsultasArray;
    FarrDepIte: TConsultasArray;
    FintTipRel: Integer; // 0-Video       1-Impressora
    FstrDesRel: String;
    FstrTipImp: String;
    FstrNomFrm: String;

    FedtCodVen,
    FedtNomVen,
    FedtCodEmp,
    FedtDesEmp,
    FedtCodDep,
    FedtDesDep,
    FedtCodDepIte,
    FedtDesDepIte: TEditFocus;

    FstrVendedor,
    FstrDepProduto,
    FstrDepVendedor,
    FstrEmpresa: String;
    FarrTipOpe : TarrTipOpe;
  protected
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
    function GetArrTipOpe: TarrTipOpe;
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
    procedure SetArrTipOpe(const Value: TarrTipOpe);

    function GetEdtCodDep: TEditFocus;
    function GetEdtCodEmp: TEditFocus;
    function GetEdtCodVen: TEditFocus;
    function GetEdtDesDep: TEditFocus;
    function GetEdtDesDepIte: TEditFocus;
    function GetEdtDesEmp: TEditFocus;
    function GetEdtNomVen: TEditFocus;
    function GetEdtCodDepIte: TEditFocus;
    procedure SetEdtCodDep(const Value: TEditFocus);
    procedure SetEdtCodDepIte(const Value: TEditFocus);
    procedure SetEdtCodEmp(const Value: TEditFocus);
    procedure SetEdtCodVen(const Value: TEditFocus);
    procedure SetEdtDesDep(const Value: TEditFocus);
    procedure SetEdtDesDepIte(const Value: TEditFocus);
    procedure SetEdtDesEmp(const Value: TEditFocus);
    procedure SetEdtNomVen(const Value: TEditFocus);

    function GetDepProduto: String;
    function GetDepVendedor: String;
    function GetEmpresa: String;
    function GetVendedor: String;
    procedure SetDepProduto(const Value: String);
    procedure SetDepVendedor(const Value: String);
    procedure SetEmpresa(const Value: String);
    procedure SetVendedor(const Value: String);
  public
  published
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

uses untFactoryClass;

{ TRelFatComFaixaDescTabPrecoClass }

function TRelFatComFaixaDescTabPrecoClass.GetArrTipOpe: TarrTipOpe;
begin
  Result := FarrTipOpe;
end;

function TRelFatComFaixaDescTabPrecoClass.GetCodVen: TConsultasArray;
begin
  Result := FarrCodVen;
end;

function TRelFatComFaixaDescTabPrecoClass.GetComEmp: TConsultasArray;
begin
  Result := FarrCodEmp;
end;

function TRelFatComFaixaDescTabPrecoClass.GetDepIte: TConsultasArray;
begin
  Result := FarrDepIte;
end;

function TRelFatComFaixaDescTabPrecoClass.GetDepProduto: String;
begin
  Result := FstrDepProduto;
end;

function TRelFatComFaixaDescTabPrecoClass.GetDepVen: TConsultasArray;
begin
  Result := FarrDepVen;
end;

function TRelFatComFaixaDescTabPrecoClass.GetDepVendedor: String;
begin
  Result := FstrDepVendedor;
end;

function TRelFatComFaixaDescTabPrecoClass.GetDesRel: String;
begin
  Result := FstrDesRel;
end;

function TRelFatComFaixaDescTabPrecoClass.GetDtaFin: TDateTime;
begin
  Result := FdtaDtaFin;
end;

function TRelFatComFaixaDescTabPrecoClass.GetDtaIni: TDateTime;
begin
  Result := FdtaDtaIni;
end;

function TRelFatComFaixaDescTabPrecoClass.GetEdtCodDep: TEditFocus;
begin
  Result := FedtCodDep;
end;

function TRelFatComFaixaDescTabPrecoClass.GetEdtCodEmp: TEditFocus;
begin
  Result := FedtCodEmp;
end;

function TRelFatComFaixaDescTabPrecoClass.GetEdtCodVen: TEditFocus;
begin
  Result := FedtCodVen;
end;

function TRelFatComFaixaDescTabPrecoClass.GetEdtDesDep: TEditFocus;
begin
  Result := FedtDesDep;
end;

function TRelFatComFaixaDescTabPrecoClass.GetEdtDesDepIte: TEditFocus;
begin
  Result := FedtDesDepIte;
end;

function TRelFatComFaixaDescTabPrecoClass.GetEdtDesEmp: TEditFocus;
begin
  Result := FedtDesEmp;
end;

function TRelFatComFaixaDescTabPrecoClass.GetEdtNomVen: TEditFocus;
begin
  Result := FedtNomVen;
end;

function TRelFatComFaixaDescTabPrecoClass.GetEdtCodDepIte: TEditFocus;
begin
  Result := FedtCodDepIte;
end;

function TRelFatComFaixaDescTabPrecoClass.GetEmpresa: String;
begin
  Result := FstrEmpresa;
end;

function TRelFatComFaixaDescTabPrecoClass.GetNomFrm: String;
begin
  Result := FstrNomFrm;
end;

function TRelFatComFaixaDescTabPrecoClass.GetOpcVen: Integer;
begin
  Result := FintOpcVen;
end;

function TRelFatComFaixaDescTabPrecoClass.GetTipImp: String;
begin
  Result := FstrTipImp;
end;

function TRelFatComFaixaDescTabPrecoClass.GetTipRel: Integer;
begin
  Result := FintTipRel;
end;

function TRelFatComFaixaDescTabPrecoClass.GetTipVen: Integer;
begin
  Result := FintTipVen;
end;

function TRelFatComFaixaDescTabPrecoClass.GetVendedor: String;
begin
  Result := FstrVendedor;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetArrTipOpe(
  const Value: TarrTipOpe);
begin
  FarrTipOpe := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetCodVen(const Value: TConsultasArray);
begin
  FarrCodVen := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetComEmp(const Value: TConsultasArray);
begin
  FarrCodEmp := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetDepIte(const Value: TConsultasArray);
begin
  FarrDepIte := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetDepProduto(const Value: String);
begin
  FstrDepProduto := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetDepVen(const Value: TConsultasArray);
begin
  FarrDepVen := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetDepVendedor(const Value: String);
begin
  FstrDepVendedor := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetDesRel(const Value: String);
begin
  FstrDesRel := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetDtaFin(const Value: TDateTime);
begin
  FdtaDtaFin := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetDtaIni(const Value: TDateTime);
begin
  FdtaDtaIni := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetEdtCodDep(
  const Value: TEditFocus);
begin
  FedtCodDep := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetEdtCodDepIte(
  const Value: TEditFocus);
begin
  FedtCodDepIte := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetEdtCodEmp(
  const Value: TEditFocus);
begin
  FedtCodEmp := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetEdtCodVen(
  const Value: TEditFocus);
begin
  FedtCodVen := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetEdtDesDep(
  const Value: TEditFocus);
begin
  FedtDesDep := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetEdtDesDepIte(
  const Value: TEditFocus);
begin
  FedtDesDepIte := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetEdtDesEmp(
  const Value: TEditFocus);
begin
  FedtDesEmp := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetEdtNomVen(
  const Value: TEditFocus);
begin
  FedtNomVen := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetEmpresa(const Value: String);
begin
  FstrEmpresa := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetNomFrm(const Value: String);
begin
  FstrNomFrm := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetOpcVen(const Value: Integer);
begin
  FintOpcVen := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetTipImp(const Value: String);
begin
  FstrTipImp := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetTipRel(const Value: Integer);
begin
  FintTipRel := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetTipVen(const Value: Integer);
begin
  FintTipVen := Value;
end;

procedure TRelFatComFaixaDescTabPrecoClass.SetVendedor(const Value: String);
begin
  FstrVendedor := Value;
end;

initialization
  Factory.RegisterClass(TRelFatComFaixaDescTabPrecoClass, 'RelComissaoFaixaDescTabPreco');

end.
