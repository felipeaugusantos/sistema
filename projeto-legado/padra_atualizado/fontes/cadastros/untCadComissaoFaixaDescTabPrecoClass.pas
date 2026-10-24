unit untCadComissaoFaixaDescTabPrecoClass;

interface

uses
  untBaseClass, untCadComissaoFaixaDescTabPrecoIntf;

type
  TCadComissaoFaixaDescTabPreco = Class(TBaseClass, ICadComissaoFaixaDescTabPreco)
  private
    FstrTabPre: String;
    FstrTipOpe: String;
    FfltDesIni: Double;
    FfltDesFin: Double;
    FfltComVis: Double;
    FfltComPra: Double;
    FstrCodEmp: String;
  protected
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
  public
  published
    property strTabPre : String read GetTabPre write SetTabPre;
    property strTipOpe : String read GetTipOpe write SetTipOpe;
    property fltDesIni : Double read GetDesIni write SetDesIni;
    property fltDesFin : Double read GetDesFin write SetDesFin;
    property fltComVis : Double read GetComVis write SetComVis;
    property fltComPra : Double read GetComPra write SetComPra;
    property strCodEmp : String read GetComEmp write SetCodEmp;
  end;


implementation

uses untFactoryClass;

{ TCadComissaoFaixaDescTabPreco }

function TCadComissaoFaixaDescTabPreco.GetComEmp: String;
begin
  Result := FstrCodEmp;
end;

function TCadComissaoFaixaDescTabPreco.GetComPra: Double;
begin
  Result := FfltComPra;
end;

function TCadComissaoFaixaDescTabPreco.GetComVis: Double;
begin
  Result := FfltComVis;
end;

function TCadComissaoFaixaDescTabPreco.GetDesFin: Double;
begin
  Result := FfltDesFin;
end;

function TCadComissaoFaixaDescTabPreco.GetDesIni: Double;
begin
  Result := FfltDesIni;
end;

function TCadComissaoFaixaDescTabPreco.GetTabPre: String;
begin
  Result := FstrTabPre;
end;

function TCadComissaoFaixaDescTabPreco.GetTipOpe: String;
begin
  Result := FstrTipOpe;
end;

procedure TCadComissaoFaixaDescTabPreco.SetCodEmp(const Value: String);
begin
  FstrCodEmp := Value;
end;

procedure TCadComissaoFaixaDescTabPreco.SetComPra(const Value: Double);
begin
  FfltComPra := Value;
end;

procedure TCadComissaoFaixaDescTabPreco.SetComVis(const Value: Double);
begin
  FfltComVis := Value;
end;

procedure TCadComissaoFaixaDescTabPreco.SetDesFin(const Value: Double);
begin
  FfltDesFin := Value;
end;

procedure TCadComissaoFaixaDescTabPreco.SetDesIni(const Value: Double);
begin
  FfltDesIni := Value;
end;

procedure TCadComissaoFaixaDescTabPreco.SetTabPre(const Value: String);
begin
  FstrTabPre := Value;
end;

procedure TCadComissaoFaixaDescTabPreco.SetTipOpe(const Value: String);
begin
  FstrTipOpe := Value;
end;

initialization
  Factory.RegisterClass(TCadComissaoFaixaDescTabPreco, 'ComissaoFaixaTabPreco');

end.
