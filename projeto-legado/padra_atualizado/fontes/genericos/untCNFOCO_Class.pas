unit untCNFOCO_Class;

interface

Uses Classes, DateUtils, StrUtils, SysUtils;

type
  TCnfOco = class
  private
    FCartei: Integer;
    FCodBco: String;
    FCodCta: String;
    FCodEmp: String;
    FCodFor: String;
    FCodOco: String;
    FMotOco: String;
    FTipDes: Integer;
    FCodPor: String;
    FDesoco: String;
    FEspeci: String;
    FGerPag: Boolean;
    FNumPos: String;
    FTipLay: String;
    FAutInc: String;
    FCusCar: Boolean;
    FUsaDia: Boolean;
    FGerRec: Boolean;

    function getCartei: Integer;
    function getCodBco: String;
    function getMotOco: String;
    function getTipDes: Integer;
    function getCodCta: String;
    function getCodEmp: String;
    function getCodFor: String;
    function getCodOco: String;
    function getCodPor: String;
    function getDesoco: String;
    function getEspeci: String;
    function getGerPag: Boolean;
    function getNumPos: String;
    function getTipLay: String;
    function getAutInc: String;
    function getCusCar: Boolean;
    function getGerRec: Boolean;

    procedure setCartei(const Value: Integer);
    procedure setCodBco(const Value: String);
    procedure setMotOco(const Value: String);
    procedure setTipDes(const Value: Integer);
    procedure setCodCta(const Value: String);
    procedure setCodEmp(const Value: String);
    procedure setCodFor(const Value: String);
    procedure setCodOco(const Value: String);
    procedure setCodPor(const Value: String);
    procedure setDesOco(const Value: String);
    procedure setEspeci(const Value: String);
    procedure setGerPag(const Value: Boolean);
    procedure setNumPos(const Value: String);
    procedure setTipLay(const Value: String);
    procedure setAutInc(const Value: String);
    procedure setCusCar(const Value: Boolean);
    procedure setGerRec(const Value: Boolean);

  public
    property strCodBco: String  read getCodBco write setCodBco;
    property intCartei: Integer read getCartei write setCartei;
    property strTipLay: String  read getTipLay write setTipLay;
    property strNumPos: String  read getNumPos write setNumPos;
    property strEspeci: String  read getEspeci write setEspeci;
    property strCodEmp: String  read getCodEmp write setCodEmp;
    property strCodOco: String  read getCodOco write setCodOco;
    property strMotOco: String  read getMotOco write setMotOco;
    property intTipDes: Integer read getTipDes write setTipDes;
    property strDesOco: String  read getDesoco write setDesOco;
    property strCodPor: String  read getCodPor write setCodPor;
    property strCodFor: String  read getCodFor write setCodFor;
    property strCodCta: String  read getCodCta write setCodCta;
    property blnGerpag: Boolean read getGerPag write setGerPag;
    property blnGerrec: Boolean read getGerRec write setGerRec;
    property strAutInc: String  read getAutInc write setAutInc;
    property blnCusCar: Boolean read getCusCar write setCusCar;
    property blnUsaDia: Boolean read FUsaDia   write FUsaDia;
  end;


implementation

{ TCnfOco }

function TCnfOco.getAutInc: String;
begin
  Result := FAutInc;
end;

function TCnfOco.getCartei: Integer;
begin
  Result := FCartei;
end;

function TCnfOco.getCodBco: String;
begin
  Result := FCodBco;
end;

function TCnfOco.getCodCta: String;
begin
  Result := FCodCta;
end;

function TCnfOco.getCodEmp: String;
begin
  Result := FCodEmp;
end;

function TCnfOco.getCodFor: String;
begin
  Result := FCodFor;
end;

function TCnfOco.getCodOco: String;
begin
  Result := FCodOco;
end;

function TCnfOco.getMotOco: String;
begin
  Result := FMotOco;
end;

function TCnfOco.getTipDes: Integer;
begin
  Result := FTipDes;
end;

function TCnfOco.getCodPor: String;
begin
  Result := FCodPor;
end;

function TCnfOco.getCusCar: Boolean;
begin
  Result := FCusCar;
end;

function TCnfOco.getDesoco: String;
begin
  Result := FDesOco;
end;

function TCnfOco.getEspeci: String;
begin
  Result := FEspeci;
end;

function TCnfOco.getGerPag: Boolean;
begin
  Result := FGerPag
end;

function TCnfOco.getNumPos: String;
begin
  Result := FNumPos;
end;

function TCnfOco.getTipLay: String;
begin
  Result := FTipLay;
end;

procedure TCnfOco.setAutInc(const Value: String);
begin
  FAutInc := Value;
end;

procedure TCnfOco.setCartei(const Value: Integer);
begin
  FCartei := Value;
end;

procedure TCnfOco.setCodBco(const Value: String);
begin
  FCodBco := Value;
end;

procedure TCnfOco.setCodCta(const Value: String);
begin
  FCodCta := Value;
end;

procedure TCnfOco.setCodEmp(const Value: String);
begin
  FCodEmp := Value;
end;

procedure TCnfOco.setCodFor(const Value: String);
begin
  FCodFor := Value;
end;

procedure TCnfOco.setCodOco(const Value: String);
begin
  FCodOco := Value;
end;

procedure TCnfOco.setMotOco(const Value: String);
begin
  FMotOco := Value;
end;

procedure TCnfOco.setTipDes(const Value: Integer);
begin
  FTipDes := Value;
end;

procedure TCnfOco.setCodPor(const Value: String);
begin
  FCodPor := Value;
end;

procedure TCnfOco.setCusCar(const Value: Boolean);
begin
  FCusCar := Value;
end;

procedure TCnfOco.setDesOco(const Value: String);
begin
  FDesOco := Value;
end;

procedure TCnfOco.setEspeci(const Value: String);
begin
  FEspeci := Value;
end;

procedure TCnfOco.setGerPag(const Value: Boolean);
begin
  FGerPag := Value;
end;

procedure TCnfOco.setNumPos(const Value: String);
begin
  FNumPos := Value;
end;

procedure TCnfOco.setTipLay(const Value: String);
begin
  FTipLay := Value;
end;

procedure TCnfOco.setGerRec(const Value: Boolean);
begin
  FGerRec := Value;
end;

function TCnfOco.getGerRec: Boolean;
begin
  Result := FGerRec
end;

end.
