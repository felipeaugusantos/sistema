unit untCadMet;

interface

Type
  TCadMet = class
  private
    strAutInc: String;
    strCodEmp: String;
    strMesAno: String;
    strCodVen: String;
    fltTotMet: Double;
    fltMargem: Double;
    fltTotFre: Double;
    fltAteDia: Double;
    fltTicMed: Double;
    fltIteDoc: Double;
  public
    function getAutInc: String;
    function getCodEmp: String;
    function getMesAno: String;
    function getCodVen: String;
    function getTotMet: Double;
    function getMargem: Double;
    function getTotFre: Double;
    function getAteDia: Double;
    function getTicMed: Double;
    function getIteDoc: Double;
    procedure setAutInc(value: String);
    procedure setCodEmp(value: String);
    procedure setMesAno(value: String);
    procedure setCodVen(value: String);
    procedure setTotMet(value: Double);
    procedure setMargem(value: Double);
    procedure setTotFre(value: Double);
    procedure setAteDia(value: Double);
    procedure setTicMed(value: Double);
    procedure setIteDoc(value: Double);
    constructor Create(strAutInc, strCodEmp, strMesAno, strCodVen: String;
      fltTotMet: Double = 0; fltMargem: Double = 0; fltTotFre: Double = 0;
      fltAteDia: Double = 0; fltTicMed: Double = 0; fltIteDoc: Double = 0);
  end;

implementation

{ TCadMet }

constructor TCadMet.Create(strAutInc, strCodEmp, strMesAno, strCodVen: String;
  fltTotMet: Double = 0; fltMargem: Double = 0; fltTotFre: Double = 0;
  fltAteDia: Double = 0; fltTicMed: Double = 0; fltIteDoc: Double = 0);
begin
  Self.strAutInc := strAutInc;
  Self.strCodEmp := strCodEmp;
  Self.strMesAno := strMesAno;
  Self.strCodVen := strCodVen;
  Self.fltTotMet := fltTotMet;
  Self.fltMargem := fltMargem;
  Self.fltTotFre := fltTotFre;
  Self.fltAteDia := fltAteDia;
  Self.fltTicMed := fltTicMed;
  Self.fltIteDoc := fltIteDoc;
end;

function TCadMet.getAteDia: Double;
begin
  Result := Self.fltAteDia;
end;

function TCadMet.getAutInc: String;
begin
  Result := Self.strAutInc;
end;

function TCadMet.getCodEmp: String;
begin
  Result := Self.strCodEmp;
end;

function TCadMet.getCodVen: String;
begin
  Result := Self.strCodVen;
end;

function TCadMet.getIteDoc: Double;
begin
  Result := Self.fltIteDoc;
end;

function TCadMet.getMargem: Double;
begin
  Result := Self.fltMargem;
end;

function TCadMet.getMesAno: String;
begin
  Result := Self.strMesAno;
end;

function TCadMet.getTicMed: Double;
begin
  Result := Self.fltTicMed;
end;

function TCadMet.getTotFre: Double;
begin
  Result := Self.fltTotFre;
end;

function TCadMet.getTotMet: Double;
begin
  Result := Self.fltTotMet;
end;

procedure TCadMet.setAteDia(value: Double);
begin
  Self.fltAteDia := value;
end;

procedure TCadMet.setAutInc(value: String);
begin
  Self.strAutInc := value;
end;

procedure TCadMet.setCodEmp(value: String);
begin
  Self.strCodEmp := value;
end;

procedure TCadMet.setCodVen(value: String);
begin
  Self.strCodVen := value;
end;

procedure TCadMet.setIteDoc(value: Double);
begin
  Self.fltIteDoc := value;
end;

procedure TCadMet.setMargem(value: Double);
begin
  Self.fltMargem := value;
end;

procedure TCadMet.setMesAno(value: String);
begin
  Self.strMesAno := value;
end;

procedure TCadMet.setTicMed(value: Double);
begin
  Self.fltTicMed := value;
end;

procedure TCadMet.setTotFre(value: Double);
begin
  Self.fltTotFre := value;
end;

procedure TCadMet.setTotMet(value: Double);
begin
  Self.fltTotMet := value;
end;

end.
