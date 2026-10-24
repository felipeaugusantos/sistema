unit untMetMar;

interface

Type
  TMetMar = class
  private
    strAutInc: String;
    strCodEmp: String;
    strMesAno: String;
    strCodVen: String;
    strCodMar: String;
    fltPerMar: Double;

  public
    function getAutInc: String;
    function getCodEmp: String;
    function getCodMar: String;
    function getCodVen: String;
    function getMesAno: String;
    function getPerMar: Double;
    procedure setAutInc(value: String);
    procedure setCodEmp(value: String);
    procedure setCodMar(value: String);
    procedure setCodVen(value: String);
    procedure setMesAno(value: String);
    procedure setPerMar(value: Double);
    constructor Create(strAutInc, strCodEmp, strMesAno, strCodVen, strCodMar: String;
      fltPerMar: Double);
  end;

implementation

constructor TMetMar.Create(strAutInc, strCodEmp, strMesAno, strCodVen, strCodMar: String;
  fltPerMar: Double);
begin
  Self.strAutInc := strAutInc;
  Self.strCodEmp := strCodEmp;
  Self.strMesAno := strMesAno;
  Self.strCodVen := strCodVen;
  Self.strCodMar := strCodMar;
  Self.fltPerMar := fltPerMar;
end;

function TMetMar.getAutInc: String;
begin
  Result := Self.strAutInc;
end;

function TMetMar.getCodEmp: String;
begin
  Result := Self.strCodEmp;
end;

function TMetMar.getMesAno: String;
begin
  Result := Self.strMesAno;
end;

function TMetMar.getCodVen: String;
begin
  Result := Self.strCodVen;
end;

function TMetMar.getCodMar: String;
begin
  Result := Self.strCodMar;
end;

function TMetMar.getPerMar: Double;
begin
  Result := Self.fltPerMar;
end;

procedure TMetMar.setAutInc(value: String);
begin
  Self.strAutInc := value;
end;

procedure TMetMar.setCodEmp(value: String);
begin
  Self.strCodEmp := value;
end;

procedure TMetMar.setMesAno(value: String);
begin
  Self.strMesAno := value;
end;

procedure TMetMar.setCodVen(value: String);
begin
  Self.strCodVen := value;
end;

procedure TMetMar.setCodMar(value: String);
begin
  Self.strCodMar := value;
end;

procedure TMetMar.setPerMar(value: Double);
begin
  Self.fltPerMar := value;
end;

end.
