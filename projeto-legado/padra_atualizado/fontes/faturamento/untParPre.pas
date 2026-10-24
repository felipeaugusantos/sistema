unit untParPre;

interface

Type
  TParPre = class
  private
    strAutInc: String;
    strCodEmp: String;
    fltVlrFat: Double;
    flt1CsAba: Double;
    fltMetAti: Double;
    flt1CsAci: Double;
    flt2CsAci: Double;
  public
    function getAutInc: String;
    function getCodEmp: String;
    function getVlrFat: Double;
    function get1CsAba: Double;
    function getMetAti: Double;
    function get1CsAci: Double;
    function get2CsAci: Double;

    procedure setAutInc(strAutInc: String);
    procedure setCodEmp(strCodEmp: String);
    procedure setVlrFat(fltVlrFat: Double);
    procedure setMetAti(fltMetAti: Double);
    procedure set1CsAba(flt1CsAba: Double);
    procedure set1CsAci(flt1CsAci: Double);
    procedure set2CsAci(flt2CsAci: Double);

    constructor Create(strAutInc, strCodEmp: String; fltVlrFat, fltMetAti, flt1CsAba,
      flt1CsAci, flt2CsAci: Double);
  end;

implementation

{ TParPre }

constructor TParPre.Create(strAutInc, strCodEmp: String; fltVlrFat, fltMetAti,
  flt1CsAba, flt1CsAci, flt2CsAci: Double);
begin
  Self.strAutInc := strAutInc;
  Self.strCodEmp := strCodEmp;
  Self.fltVlrFat := fltVlrFat;
  Self.fltMetAti := fltMetAti;
  Self.flt1CsAba := flt1CsAba;
  Self.flt1CsAci := flt1CsAci;
  Self.flt2CsAci := flt2CsAci;
end;

function TParPre.get1CsAba: Double;
begin
  Result := flt1CsAba;
end;

function TParPre.get1CsAci: Double;
begin
  Result := flt1CsAci;
end;

function TParPre.get2CsAci: Double;
begin
  Result := flt2CsAci;
end;

function TParPre.getAutInc: String;
begin
  Result := strAutInc;
end;

function TParPre.getCodEmp: String;
begin
  Result := strCodEmp;
end;

function TParPre.getMetAti: Double;
begin
  Result := fltMetAti;
end;

function TParPre.getVlrFat: Double;
begin
  Result := fltVlrFat;
end;

procedure TParPre.set1CsAba(flt1CsAba: Double);
begin
  Self.flt1CsAba := flt1CsAba;
end;

procedure TParPre.set1CsAci(flt1CsAci: Double);
begin
  Self.flt1CsAci := flt1CsAci;
end;

procedure TParPre.set2CsAci(flt2CsAci: Double);
begin
  Self.flt2CsAci := flt2CsAci;
end;

procedure TParPre.setAutInc(strAutInc: String);
begin
  Self.strAutInc := strAutInc;
end;

procedure TParPre.setCodEmp(strCodEmp: String);
begin
  Self.strCodEmp := strCodEmp;
end;

procedure TParPre.setMetAti(fltMetAti: Double);
begin
  Self.fltMetAti := fltMetAti;
end;

procedure TParPre.setVlrFat(fltVlrFat: Double);
begin
  Self.fltVlrFat := fltVlrFat;
end;

end.
