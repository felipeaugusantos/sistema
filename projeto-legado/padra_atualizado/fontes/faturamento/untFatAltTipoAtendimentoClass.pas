unit untFatAltTipoAtendimentoClass;

interface

uses SysUtils, Classes, untBaseClass, untFatAltTipoAtendimentoIntf;

type
  TAltTipoAtendimento = Class(TBaseClass, IAltTipoAtendimento)
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
    FfltValDoc   : Double;
    FstrTipAteAtu: String;
    FAutoIncrem  : String;
    FstrCodAteAtu: String;

    {*************************}
    {* DADO A SER ATUALIZADO *}
    {***********************FC}
    FstrTipAteNew: String;
  protected
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
  public
  published
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

uses untFactoryClass;

{ TAltTipoAtendimento }

function TAltTipoAtendimento.GetAutoIncrem: String;
begin
  Result := FAutoIncrem;
end;

function TAltTipoAtendimento.GetdtaDtEmis: TDateTime;
begin
  Result := FdtaDtEmis;
end;

function TAltTipoAtendimento.GetfltValDoc: Double;
begin
  Result := FfltValDoc;
end;

function TAltTipoAtendimento.GetstrCndPgt: String;
begin
  Result := FstrCndPgt;
end;

function TAltTipoAtendimento.GetstrCodAteAtu: String;
begin
  Result := FstrCodAteAtu;
end;

function TAltTipoAtendimento.GetstrCodCli: String;
begin
  Result := FstrCodCli;
end;

function TAltTipoAtendimento.GetstrCodEmp: String;
begin
  Result := FstrCodEmp;
end;

function TAltTipoAtendimento.GetstrCodRep: String;
begin
  Result := FstrCodRep;
end;

function TAltTipoAtendimento.GetstrCodVen: String;
begin
  Result := FstrCodVen;
end;

function TAltTipoAtendimento.GetstrEspDoc: String;
begin
  Result := FstrEspDoc;
end;

function TAltTipoAtendimento.GetstrNomCli: String;
begin
  Result := FstrNomCli;
end;

function TAltTipoAtendimento.GetstrNomEmp: String;
begin
  Result := FstrNomEmp;
end;

function TAltTipoAtendimento.GetstrNomRep: String;
begin
  Result := FstrNomRep;
end;

function TAltTipoAtendimento.GetstrNomVen: String;
begin
  Result := FstrNomVen;
end;

function TAltTipoAtendimento.GetstrNumDoc: String;
begin
  Result := FstrNumDoc;
end;

function TAltTipoAtendimento.GetstrTipAteAtu: String;
begin
  Result := FstrTipAteAtu;
end;

function TAltTipoAtendimento.GetstrTipAteNew: String;
begin
  Result := FstrTipAteNew;
end;

procedure TAltTipoAtendimento.SetAutoIncrem(const Value: String);
begin
  FAutoIncrem := Value;
end;

procedure TAltTipoAtendimento.SetdtaDtEmis(const Value: TDateTime);
begin
  FdtaDtEmis := Value;
end;

procedure TAltTipoAtendimento.SetfltValDoc(const Value: Double);
begin
  FfltValDoc := Value;
end;

procedure TAltTipoAtendimento.SetstrCndPgt(const Value: String);
begin
  FstrCndPgt := Value;
end;

procedure TAltTipoAtendimento.SetstrCodAteAtu(const Value: String);
begin
  FstrCodAteAtu := Value;
end;

procedure TAltTipoAtendimento.SetstrCodCli(const Value: String);
begin
  FstrCodCli := Value;
end;

procedure TAltTipoAtendimento.SetstrCodEmp(const Value: String);
begin
  FstrCodEmp := Value;
end;

procedure TAltTipoAtendimento.SetstrCodRep(const Value: String);
begin
  FstrCodRep := Value;
end;

procedure TAltTipoAtendimento.SetstrCodVen(const Value: String);
begin
  FstrCodVen := Value;
end;

procedure TAltTipoAtendimento.SetstrEspDoc(const Value: String);
begin
  FstrEspDoc := Value;
end;

procedure TAltTipoAtendimento.SetstrNomCli(const Value: String);
begin
  FstrNomCli := Value;
end;

procedure TAltTipoAtendimento.SetstrNomEmp(const Value: String);
begin
  FstrNomEmp := Value;
end;

procedure TAltTipoAtendimento.SetstrNomRep(const Value: String);
begin
  FstrNomRep := Value;
end;

procedure TAltTipoAtendimento.SetstrNomVen(const Value: String);
begin
  FstrNomVen := Value;
end;

procedure TAltTipoAtendimento.SetstrNumDoc(const Value: String);
begin
  FstrNumDoc := Value;
end;

procedure TAltTipoAtendimento.SetstrTipAteAtu(const Value: String);
begin
  FstrTipAteAtu := Value;
end;

procedure TAltTipoAtendimento.SetstrTipAteNew(const Value: String);
begin
  FstrTipAteNew := Value;
end;

initialization
  Factory.RegisterClass(TAltTipoAtendimento, 'AltTipoAtendimento');

end.
