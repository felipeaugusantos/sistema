unit untCadMix;

interface

type
  TCadMix = class
  private
    strAutInc: String;
    strCodEmp: String;
    fltPerMet: Double;
    objCadMix: TCadMix;

    procedure pPreenche(strCodEmp: String; fltPerMet: Double);
  public
    constructor Create; overload;
    constructor Create(strAutInc, strCodEmp: String; fltPerMet: Double); overload;
    function getInstance(strAutInc, strCodEmp: String; fltPerMet: Double): TCadMix;
    function getAutInc: String;
    function getCodEmp: String;
    function getPerMet: Double;
    procedure setAutInc(strAutInc: String);
    procedure setCodEmp(strCodEmp: String);
    procedure setPerMet(fltPerMet: Double);
  end;

implementation

{ TCadMix }

constructor TCadMix.Create;
begin
  strAutInc := '';
  strCodEmp := '';
  fltPerMet := 0;
end;

constructor TCadMix.Create(strAutInc, strCodEmp: String; fltPerMet: Double);
begin
  Self.strAutInc := strAutInc;
  Self.strCodEmp := strCodEmp;
  Self.fltPerMet := fltPerMet;
  Self.objCadMix := Self;
end;

procedure TCadMix.pPreenche(strCodEmp: String; fltPerMet: Double);
begin
  objCadMix.strCodEmp := strCodEmp;
  objCadMix.fltPerMet := fltPerMet;
end;

function TCadMix.getInstance(strAutInc, strCodEmp: String; fltPerMet: Double): TCadMix;
begin
  If (Self = Nil) Or (Self.objCadMix = Nil) Then
    Self := TCadMix.Create(strAutInc, strCodEmp, fltPerMet)
  Else
    Self.pPreenche(strCodEmp, fltPerMet);

  Result := Self.objCadMix;
end;

function TCadMix.getAutInc: String;
begin
  Result := Self.strAutInc;
end;

function TCadMix.getCodEmp: String;
begin
  Result := Self.strCodEmp;
end;

function TCadMix.getPerMet: Double;
begin
  Result := Self.fltPerMet;
end;

procedure TCadMix.setAutInc(strAutInc: String);
begin
  Self.strAutInc := strAutInc;
end;

procedure TCadMix.setCodEmp(strCodEmp: String);
begin
  Self.strCodEmp := strCodEmp;
end;

procedure TCadMix.setPerMet(fltPerMet: Double);
begin
  Self.fltPerMet := fltPerMet;
end;

end.


