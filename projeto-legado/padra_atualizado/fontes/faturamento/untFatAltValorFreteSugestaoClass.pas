unit untFatAltValorFreteSugestaoClass;

interface

uses SysUtils, Classes, untBaseClass, untFatAltValorFreteSugestaoIntf;

Type
  TAltValorFreteSugestao = Class(TBaseClass, IAltValorFreteSugestao)
  private
    {***********************}
    {* CABECALHO DO OBJETO *}
    {*********************FC}
    FstrNumDoc   : String;
    FstrEspDoc   : String;
    FstrCodEmp   : String;
    FstrNomEmp   : string;

    FstrCodCli   : String;
    FstrNomCli   : String;
    FdtaDtEmis   : TDateTime;
    FstrCndPgt   : String;
    FstrCodVen   : String;
    FstrNomVen   : String;
    FstrCodRep   : String;
    FstrNomRep   : String;
    FstrCodTra   : String;
    FstrNomTra   : String;
    FstrTraLot   : String;

    FfltBasIcm   : Double;
    FfltValIcm   : Double;
    FfltDesAce   : Double;
    FfltBasTri   : Double;
    FfltValTri   : Double;
    FfltValFre   : Double;
    FfltValPro   : Double;
    FfltBasIpi   : Double;
    FfltValIpi   : Double;
    FfltTotNf    : Double;

    FAutoIncrem  : String;
    FstrNomTab   : String;
    FfltValFreOld: Double;

    {*************************}
    {* DADO A SER ATUALIZADO *}
    {***********************FC}
    FstrCodTraNew: String;
    FfltValFreNew: Double;
    FstrTraLotNew: String;
  protected
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
  public

  published
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
  end;

implementation

uses untFactoryClass;

{ TAltValorFreteSugestao }

function TAltValorFreteSugestao.GetAutoIncrem: String;
begin
  Result := FAutoIncrem;
end;

function TAltValorFreteSugestao.GetdtaDtEmis: TDateTime;
begin
  Result := FdtaDtEmis;
end;

function TAltValorFreteSugestao.GetfltBasIcm: Double;
begin
  Result := FfltBasIcm;
end;

function TAltValorFreteSugestao.GetfltBasIpi: Double;
begin
  Result := FfltBasIpi;
end;

function TAltValorFreteSugestao.GetfltBasTri: Double;
begin
  Result := FfltBasTri;
end;

function TAltValorFreteSugestao.GetfltDesAce: Double;
begin
  Result := FfltDesAce;
end;

function TAltValorFreteSugestao.GetfltTotNf: Double;
begin
  Result := FfltTotNf;
end;

function TAltValorFreteSugestao.GetfltValFre: Double;
begin
  Result := FfltValFre;
end;

function TAltValorFreteSugestao.GetfltValFreNew: Double;
begin
  Result := FfltValFreNew;
end;

function TAltValorFreteSugestao.GetfltValFreOld: Double;
begin
  Result := FfltValFreOld;
end;

function TAltValorFreteSugestao.GetfltValIcm: Double;
begin
  Result := FfltValIcm;
end;

function TAltValorFreteSugestao.GetfltValIpi: Double;
begin
  Result := FfltValIpi;
end;

function TAltValorFreteSugestao.GetfltValPro: Double;
begin
  Result := FfltValPro;
end;

function TAltValorFreteSugestao.GetfltValTri: Double;
begin
  Result := FfltValTri;
end;

function TAltValorFreteSugestao.GetstrCndPgt: String;
begin
  Result := FstrCndPgt;
end;

function TAltValorFreteSugestao.GetstrCodCli: String;
begin
  Result := FstrCodCli;
end;

function TAltValorFreteSugestao.GetstrCodEmp: String;
begin
  Result := FstrCodEmp;
end;

function TAltValorFreteSugestao.GetstrCodRep: String;
begin
  Result := FstrCodRep;
end;

function TAltValorFreteSugestao.GetstrCodTra: String;
begin
  Result := FstrCodTra;
end;

function TAltValorFreteSugestao.GetstrCodTraNew: String;
begin
  Result := FstrCodTraNew;
end;

function TAltValorFreteSugestao.GetstrCodVen: String;
begin
  Result := FstrCodVen;
end;

function TAltValorFreteSugestao.GetstrEspDoc: String;
begin
  Result := FstrEspDoc;
end;

function TAltValorFreteSugestao.GetstrTraLot: String;
begin
  Result := FstrTraLot;
end;

function TAltValorFreteSugestao.GetstrTraLotNew: String;
begin
  Result := FstrTraLotNew;
end;

function TAltValorFreteSugestao.GetstrNomCli: String;
begin
  Result := FstrNomCli;
end;

function TAltValorFreteSugestao.GetstrNomEmp: String;
begin
  Result := FstrNomEmp;

end;

function TAltValorFreteSugestao.GetstrNomRep: String;
begin
  Result := FstrNomRep;
end;

function TAltValorFreteSugestao.GetstrNomTab: String;
begin
  Result := FstrNomTab;
end;

function TAltValorFreteSugestao.GetstrNomTra: String;
begin
  Result := FstrNomTra;
end;

function TAltValorFreteSugestao.GetstrNomVen: String;
begin
  Result := FstrNomVen;
end;

function TAltValorFreteSugestao.GetstrNumDoc: String;
begin
  Result := FstrNumDoc;
end;

procedure TAltValorFreteSugestao.SetAutoIncrem(const Value: String);
begin
  FAutoIncrem := Value;
end;

procedure TAltValorFreteSugestao.SetdtaDtEmis(const Value: TDateTime);
begin
  FdtaDtEmis := Value;
end;

procedure TAltValorFreteSugestao.SetfltBasIcm(const Value: Double);
begin
  FfltBasIcm := Value;
end;

procedure TAltValorFreteSugestao.SetfltBasIpi(const Value: Double);
begin
  FfltBasIpi := Value;
end;

procedure TAltValorFreteSugestao.SetfltBasTri(const Value: Double);
begin
  FfltBasTri := Value;
end;

procedure TAltValorFreteSugestao.SetfltDesAce(const Value: Double);
begin
  FfltDesAce := Value;
end;

procedure TAltValorFreteSugestao.SetfltTotNf(const Value: Double);
begin
  FfltTotNf := Value;
end;

procedure TAltValorFreteSugestao.SetfltValFre(const Value: Double);
begin
  FfltValFre := Value;
end;

procedure TAltValorFreteSugestao.SetfltValFreNew(const Value: Double);
begin
  FfltValFreNew := Value;
end;

procedure TAltValorFreteSugestao.SetfltValFreOld(const Value: Double);
begin
  FfltValFreOld := Value;
end;

procedure TAltValorFreteSugestao.SetfltValIcm(const Value: Double);
begin
  FfltValIcm := Value;
end;

procedure TAltValorFreteSugestao.SetfltValIpi(const Value: Double);
begin
  FfltValIpi := Value;
end;

procedure TAltValorFreteSugestao.SetfltValPro(const Value: Double);
begin
  FfltValPro := Value;
end;

procedure TAltValorFreteSugestao.SetfltValTri(const Value: Double);
begin
  FfltValTri := Value;
end;

procedure TAltValorFreteSugestao.SetstrCndPgt(const Value: String);
begin
  FstrCndPgt := Value;
end;

procedure TAltValorFreteSugestao.SetstrCodCli(const Value: String);
begin
  FstrCodCli := Value;
end;

procedure TAltValorFreteSugestao.SetstrCodEmp(const Value: String);
begin
  FstrCodEmp := Value;
end;

procedure TAltValorFreteSugestao.SetstrCodRep(const Value: String);
begin
  FstrCodRep := Value;
end;

procedure TAltValorFreteSugestao.SetstrCodTra(const Value: String);
begin
  FstrCodTra := Value;
end;

procedure TAltValorFreteSugestao.SetstrCodTraNew(const Value: String);
begin
  FstrCodTraNew := Value;
end;

procedure TAltValorFreteSugestao.SetstrCodVen(const Value: String);
begin
  FstrCodVen := Value;
end;

procedure TAltValorFreteSugestao.SetstrEspDoc(const Value: String);
begin
  FstrEspDoc := Value;
end;

procedure TAltValorFreteSugestao.SetstrTraLot(const Value: String);
begin
  FstrTraLot := Value;
end;

procedure TAltValorFreteSugestao.SetstrTraLotNew(const Value: String);
begin
  FstrTraLotNew := Value;
end;

procedure TAltValorFreteSugestao.SetstrNomCli(const Value: String);
begin
  FstrNomCli := Value;
end;

procedure TAltValorFreteSugestao.SetstrNomEmp(const Value: String);
begin
  FstrNomEmp := Value;
end;

procedure TAltValorFreteSugestao.SetstrNomRep(const Value: String);
begin
  FstrNomRep := Value;
end;

procedure TAltValorFreteSugestao.SetstrNomTab(const Value: String);
begin
  FstrNomTab := Value;
end;

procedure TAltValorFreteSugestao.SetstrNomTra(const Value: String);
begin
  FstrNomTra := Value;
end;

procedure TAltValorFreteSugestao.SetstrNomVen(const Value: String);
begin
  FstrNomVen := Value;
end;

procedure TAltValorFreteSugestao.SetstrNumDoc(const Value: String);
begin
  FstrNumDoc := Value;
end;

initialization
  Factory.RegisterClass(TAltValorFreteSugestao, 'AltValorFreteSugestao');

end.
