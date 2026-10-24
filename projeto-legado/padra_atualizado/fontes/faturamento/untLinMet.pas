unit untLinMet;

interface

type
  TLinMet = class
  private
    strAutInc: String;
    strCodLin: String;
    fltVlrMet: Double;
    fltPerFat: Double;
    fltPerMix: Double;
    fltPerMar: Double;
    strComLin: String;
  public
    constructor Create; overload;
    constructor Create(strAutInc, strCodLin, strComLin: String; fltVlrMet, fltPerFat, fltPerMix, fltPerMar: Double); overload;
    function getAutInc: String;
    procedure setAutInc(const Value: String);
    function getCodLin: String;
    procedure setCodLin(const Value: String);
    function getVlrMet: Double;
    procedure setVlrMet(const Value: Double);
    function getPerFat: Double;
    procedure setPerFat(const Value: Double);
    function getPerMix: Double;
    procedure setPerMix(const Value: Double);
    function getPerMar: Double;
    procedure setPerMar(const Value: Double);
    function getComLin: String;
    procedure setComLin(const Value: String);
  end;

implementation

{ TLinMet }

constructor TLinMet.Create;
begin
  strAutInc := '';
  strCodLin := '';
  strComLin := '';
  fltVlrMet := 0;
  fltPerFat := 0;
  fltPerMix := 0;
  fltPerMar := 0;
end;

constructor TLinMet.Create(strAutInc, strCodLin, strComLin: String; fltVlrMet,
  fltPerFat, fltPerMix, fltPerMar: Double);
begin
  Self.strAutInc := strAutInc;
  Self.strCodLin := strCodLin;
  Self.strComLin := strComLin;
  Self.fltVlrMet := fltVlrMet;
  Self.fltPerFat := fltPerFat;
  Self.fltPerMix := fltPerMix;
  Self.fltPerMar := fltPerMar;
end;

function TLinMet.getAutInc: String;
begin
  Result := strAutInc;
end;

procedure TLinMet.setAutInc(const Value: String);
begin
  strAutInc := Value;
end;

function TLinMet.getCodLin: String;
begin
  Result := strCodLin;
end;

procedure TLinMet.setCodLin(const Value: String);
begin
  strCodLin := Value;
end;

function TLinMet.getVlrMet: Double;
begin
  Result := fltVlrMet;
end;

procedure TLinMet.setVlrMet(const Value: Double);
begin
  fltVlrMet := Value;
end;

function TLinMet.getPerFat: Double;
begin
  Result := fltPerFat;
end;

procedure TLinMet.setPerFat(const Value: Double);
begin
  fltPerFat := Value;
end;

function TLinMet.getPerMix: Double;
begin
  Result := fltPerMix;
end;

procedure TLinMet.setPerMix(const Value: Double);
begin
  fltPerMix := Value;
end;

function TLinMet.getPerMar: Double;
begin
  Result := fltPerMar;
end;

procedure TLinMet.setPerMar(const Value: Double);
begin
  fltPerMar := Value;
end;

function TLinMet.getComLin: String;
begin
  Result := strComLin;
end;

procedure TLinMet.setComLin(const Value: String);
begin
  strComLin := Value;
end;

end.
