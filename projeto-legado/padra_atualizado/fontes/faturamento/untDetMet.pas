unit untDetMet;

interface

Type
  TDetMet = class
  private
    strAutInc: String;
    strCodEmp: String;
    strMesAno: String;
    strCodVen: String;
    strCodGru: String;
    strDefTip: String;
    fltPerGru: Double;
    fltMarGru: Double;
  public
    function getAutInc: String;
    function getCodEmp: String;
    function getCodGru: String;
    function getCodVen: String;
    function getDefTip: String;
    function getMesAno: String;
    function getPerGru: Double;
    function getMarGru: Double;
    procedure setAutInc(value: String);
    procedure setCodEmp(value: String);
    procedure setCodGru(value: String);
    procedure setCodVen(value: String);
    procedure setDefTip(value: String);
    procedure setMesAno(value: String);
    procedure setPerGru(value: Double);
    procedure setMarGru(value: Double);
    constructor Create(strAutInc, strCodEmp, strMesAno, strCodVen, strCodGru,
      strDefTip: String; fltPerGru, fltMarGru: Double);
  end;

implementation

constructor TDetMet.Create(strAutInc, strCodEmp, strMesAno, strCodVen, strCodGru,
  strDefTip: String; fltPerGru, fltMarGru: Double);
begin
  Self.strAutInc := strAutInc;
  Self.strCodEmp := strCodEmp;
  Self.strMesAno := strMesAno;
  Self.strCodVen := strCodVen;
  Self.strCodGru := strCodGru;
  Self.strDefTip := strDefTip;
  Self.fltPerGru := fltPerGru;
  Self.fltMarGru := fltMarGru;
end;

function TDetMet.getAutInc: String;
begin
  Result := Self.strAutInc;
end;

function TDetMet.getCodEmp: String;
begin
  Result := Self.strCodEmp;
end;

function TDetMet.getMarGru: Double;
begin
  Result := Self.fltMarGru;
end;

function TDetMet.getMesAno: String;
begin
  Result := Self.strMesAno;
end;

function TDetMet.getCodVen: String;
begin
  Result := Self.strCodVen;
end;

function TDetMet.getCodGru: String;
begin
  Result := Self.strCodGru;
end;

function TDetMet.getDefTip: String;
begin
  Result := Self.strDefTip;
end;

function TDetMet.getPerGru: Double;
begin
  Result := Self.fltPerGru;
end;

procedure TDetMet.setAutInc(value: String);
begin
  Self.strAutInc := value;
end;

procedure TDetMet.setCodEmp(value: String);
begin
  Self.strCodEmp := value;
end;

procedure TDetMet.setMarGru(value: Double);
begin
  Self.fltMargru := value;
end;

procedure TDetMet.setMesAno(value: String);
begin
  Self.strMesAno := value;
end;

procedure TDetMet.setCodVen(value: String);
begin
  Self.strCodVen := value;
end;

procedure TDetMet.setCodGru(value: String);
begin
  Self.strCodGru := value;
end;

procedure TDetMet.setDefTip(value: String);
begin
  Self.strDefTip := value;
end;

procedure TDetMet.setPerGru(value: Double);
begin
  Self.fltPerGru := value;
end;

end.
