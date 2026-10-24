unit untComDep;

interface

type
  TComDep = class
  private
    strAutInc: String;
    strCodCom: String;
    strDesCom: String;
    strCodDep: String;
    fltFatIni: Double;
    fltFatFin: Double;
    objComDep: TComDep;

    procedure pPreenche(strCodCom, strDesCom, strCodDep: String; fltFatIni, fltFatFin: Double);
  public
    constructor Create; overload;
    constructor Create(strAutInc, strCodCom, strDesCom, strCodDep: String; fltFatIni, fltFatFin: Double); overload;
    function getInstance(strAutInc, strCodCom, strDesCom, strCodDep: String; fltFatIni, fltFatFin: Double): TComDep;
    function getAutInc: String;
    function getCodCom: String;
    function getDesCom: String;
    function getCodDep: String;
    function getFatIni: Double;
    function getFatFin: Double;
    procedure setAutInc(strAutInc: String);
    procedure setCodCom(strCodCom: String);
    procedure setDesCom(strDesCom: String);
    procedure setCodDep(strCodDep: String);
    procedure setFatIni(fltFatIni: Double);
    procedure setFatFin(fltFatFin: Double);
  end;

implementation

{ TComDep }

constructor TComDep.Create;
begin
  strAutInc := '';
  strCodCom := '';
  strDesCom := '';
  strCodDep := '';
  fltFatIni := 0;
  fltFatFin := 0;
end;

constructor TComDep.Create(strAutInc, strCodCom, strDesCom, strCodDep: String; fltFatIni, fltFatFin: Double);
begin
  Self.strAutInc := strAutInc;
  Self.strCodCom := strCodCom;
  Self.strDesCom := strDesCom;
  Self.strCodDep := strCodDep;
  Self.fltFatIni := fltFatIni;
  Self.fltFatFin := fltFatFin;
  Self.objComDep := Self;
end;

procedure TComDep.pPreenche(strCodCom, strDesCom, strCodDep: String; fltFatIni, fltFatFin: Double);
begin
  objComDep.strCodCom := strCodCom;
  objComDep.strDesCom := strDesCom;
  objComDep.strCodDep := strCodDep;
  objComDep.fltFatIni := fltFatIni;
  objComDep.fltFatFin := fltFatFin;
end;

function TComDep.getInstance(strAutInc, strCodCom, strDesCom, strCodDep: String; fltFatIni, fltFatFin: Double): TComDep;
begin
  If (Self = Nil) Or (Self.objComDep = Nil) Then
    Self := TComDep.Create(strAutInc, strCodCom, strDesCom, strCodDep, fltFatIni, fltFatFin)
  Else
    Self.pPreenche(strCodCom, strDesCom, strCodDep, fltFatIni, fltFatFin);

  Result := Self.objComDep;
end;

function TComDep.getAutInc: String;
begin
  Result := Self.strAutInc;
end;

function TComDep.getCodCom: String;
begin
  Result := Self.strCodCom;
end;

function TComDep.getCodDep: String;
begin
  Result := Self.strCodDep;
end;

function TComDep.getDesCom: String;
begin
  Result := Self.strDesCom;
end;

function TComDep.getFatFin: Double;
begin
  Result := Self.fltFatFin;
end;

function TComDep.getFatIni: Double;
begin
  Result := Self.fltFatIni;
end;

procedure TComDep.setAutInc(strAutInc: String);
begin
  Self.strAutInc := strAutInc;
end;

procedure TComDep.setCodCom(strCodCom: String);
begin
  Self.strCodCom := strCodCom;
end;

procedure TComDep.setCodDep(strCodDep: String);
begin
  Self.strCodDep := strCodDep;
end;

procedure TComDep.setDesCom(strDesCom: String);
begin
  Self.strDesCom := strDesCom;
end;

procedure TComDep.setFatFin(fltFatFin: Double);
begin
  Self.fltFatFin := fltFatFin;
end;

procedure TComDep.setFatIni(fltFatIni: Double);
begin
  Self.fltFatIni := fltFatIni;
end;

end.
