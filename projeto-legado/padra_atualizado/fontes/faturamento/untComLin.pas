unit untComLin;

interface

type
  TComLin = class
  private
    strCodEmp: String;
    strCodVen: String;
    strAutInc: String;
    objComLin: TComLin;
    procedure pPreenche(strCodEmp, strCodVen: String);
  public
    constructor Create; overload;
    constructor Create(strAutInc, strCodEmp, strCodVen: String); overload;
    function getInstance(strAutInc, strCodEmp, strCodVen: String): TComLin;
    function getCodEmp: String;
    function getCodVen: String;
    function getAutInc: String;
    procedure setCodEmp(strCodEmp: String);
    procedure setCodVen(strCodVen: String);
    procedure setAutInc(strAutInc: String);
  end;

implementation

{ TComLin }

constructor TComLin.Create;
begin
  Self.strAutInc := '';
  Self.strCodEmp := '';
  Self.strCodVen := '';
end;

constructor TComLin.Create(strAutInc, strCodEmp, strCodVen: String);
begin
  Self.strAutInc := strAutInc;
  Self.strCodEmp := strCodEmp;
  Self.strCodVen := strCodVen;
  Self.objComLin := Self;
end;

procedure TComLin.pPreenche(strCodEmp, strCodVen: String);
begin
  objComLin.strCodEmp := strCodEmp;
  objComLin.strCodVen := strCodVen;
end;

function TComLin.getInstance(strAutInc, strCodEmp, strCodVen: String): TComLin;
begin
  If (Self = Nil) Or (Self.objComLin = Nil) Then
    Self := TComLin.Create(strAutInc, strCodEmp, strCodVen)
  Else
    Self.pPreenche(strCodEmp, strCodVen);

  Result := Self.objComLin;
end;

function TComLin.getAutInc: String;
begin
  Result := Self.strAutInc;
end;

function TComLin.getCodEmp: String;
begin
  Result := Self.strCodEmp;
end;

function TComLin.getCodVen: String;
begin
  Result := Self.strCodVen;
end;

procedure TComLin.setAutInc(strAutInc: String);
begin
  Self.strAutInc := strAutInc;
end;

procedure TComLin.setCodEmp(strCodEmp: String);
begin
  Self.strCodEmp := strCodEmp;
end;

procedure TComLin.setCodVen(strCodVen: String);
begin
  Self.strCodVen := strCodVen;
end;

end.
