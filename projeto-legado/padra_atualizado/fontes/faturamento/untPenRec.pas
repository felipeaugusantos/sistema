unit untPenRec;

interface

type
  TPenRec = class
  private
    strAutInc: String;
    dteDtaEnt: TDateTime;
    dteHorEnt: TDateTime;
    strNumDoc: String;
    strEspDoc: String;
    strCodEmp: String;
    strCodCli: String;
    strCodIte: String;
    fltTotIte: Double;
    strStatus: String;
    strDocRec: String;
    strEspRec: String;
    strEmpRec: String;
    fltQtdIte: Double;

  public
    function getAutInc: String;
    procedure setAutInc(const strAutInc: String);

    function getDtaEnt: TDateTime;
    procedure setDtaEnt(const dteDtaEnt: TDateTime);

    function getHorEnt: TDateTime;
    procedure setHorEnt(const dteHorEnt: TDateTime);

    function getNumDoc: String;
    procedure setNumDoc(const strNumDoc: String);

    function getEspDoc: String;
    procedure setEspDoc(const strEspDoc: String);

    function getCodEmp: String;
    procedure setCodEmp(const strCodEmp: String);

    function getCodCli: String;
    procedure setCodCli(const strCodCli: String);

    function getCodIte: String;
    procedure setCodIte(const strCodIte: String);

    function getTotIte: Double;
    procedure setTotIte(const fltTotIte: Double);

    function getStatus: String;
    procedure setStatus(const strStatus: String);

    function getDocRec: String;
    procedure setDocRec(const strDocRec: String);

    function getEspRec: String;
    procedure setEspRec(const strEspRec: String);

    function getEmpRec: String;
    procedure setEmpRec(const strEmpRec: String);

    function getQtdIte: Double;
    procedure setQtdIte(const fltQtdIte: Double);

    Constructor Create(strAutInc, strNumDoc, strEspDoc, strCodEmp,
      strCodCli, strCodIte, strStatus, strDocRec, strEspRec, strEmpRec: String;
      fltTotIte: Double; dteDtaEnt, dteHorEnt: TDateTime; fltQtdIte: Double);

  end;

implementation

constructor TPenRec.Create(strAutInc, strNumDoc, strEspDoc,
  strCodEmp, strCodCli, strCodIte, strStatus, strDocRec, strEspRec,
  strEmpRec: String; fltTotIte: Double; dteDtaEnt, dteHorEnt: TDateTime; fltQtdIte: Double);
begin
  Self.strAutInc := strAutInc;
  Self.dteDtaEnt := dteDtaEnt;
  Self.dteHorEnt := dteHorEnt;
  Self.strNumDoc := strNumDoc;
  Self.strEspDoc := strEspDoc;
  Self.strCodEmp := strCodEmp;
  Self.strCodCli := strCodCli;
  Self.strCodIte := strCodIte;
  Self.fltTotIte := fltTotIte;
  Self.strStatus := strStatus;
  Self.strDocRec := strDocRec;
  Self.strEspRec := strEspRec;
  Self.strEmpRec := strEmpRec;
  Self.fltQtdIte := fltQtdIte;
end;

function TPenRec.getAutInc: String;
begin
  Result := strAutInc;
end;

procedure TPenRec.setAutInc(const strAutInc: String);
begin
  Self.strAutInc := strAutInc;
end;

function TPenRec.getDtaEnt: TDateTime;
begin
  Result := dteDtaEnt;
end;

procedure TPenRec.setDtaEnt(const dteDtaEnt: TDateTime);
begin
  Self.dteDtaEnt := dteDtaEnt;
end;

function TPenRec.getHorEnt: TDateTime;
begin
  Result := dteHorEnt;
end;

procedure TPenRec.setHorEnt(const dteHorEnt: TDateTime);
begin
  Self.dteHorEnt := dteHorEnt;
end;

function TPenRec.getNumDoc: String;
begin
  Result := strNumDoc;
end;

function TPenRec.getQtdIte: Double;
begin
  Result := fltQtdIte;
end;

procedure TPenRec.setNumDoc(const strNumDoc: String);
begin
  Self.strNumDoc := strNumDoc;
end;

procedure TPenRec.setQtdIte(const fltQtdIte: Double);
begin
  Self.fltQtdIte := fltQtdIte;
end;

function TPenRec.getEspDoc: String;
begin
  Result := strEspDoc;
end;

procedure TPenRec.setEspDoc(const strEspDoc: String);
begin
  Self.strEspDoc := strEspDoc;
end;

function TPenRec.getCodEmp: String;
begin
  Result := strCodEmp;
end;

procedure TPenRec.setCodEmp(const strCodEmp: String);
begin
  Self.strCodEmp := strCodEmp;
end;

function TPenRec.getCodCli: String;
begin
  Result := strCodCli;
end;

procedure TPenRec.setCodCli(const strCodCli: String);
begin
  Self.strCodCli := strCodCli;
end;

function TPenRec.getCodIte: String;
begin
  Result := strCodIte;
end;

procedure TPenRec.setCodIte(const strCodIte: String);
begin
  Self.strCodIte := strCodIte;
end;

function TPenRec.getTotIte: Double;
begin
  Result := fltTotIte;
end;

procedure TPenRec.setTotIte(const fltTotIte: Double);
begin
  Self.fltTotIte := fltTotIte;
end;

function TPenRec.getStatus: String;
begin
  Result := strStatus;
end;

procedure TPenRec.setStatus(const strStatus: String);
begin
  Self.strStatus := strStatus;
end;

function TPenRec.getDocRec: String;
begin
  Result := strDocRec;
end;

procedure TPenRec.setDocRec(const strDocRec: String);
begin
  Self.strDocRec := strDocRec;
end;

function TPenRec.getEspRec: String;
begin
  Result := strEspRec;
end;

procedure TPenRec.setEspRec(const strEspRec: String);
begin
  Self.strEspRec := strEspRec;
end;

function TPenRec.getEmpRec: String;
begin
  Result := strEmpRec;
end;

procedure TPenRec.setEmpRec(const strEmpRec: String);
begin
  Self.strEmpRec := strEmpRec;
end;

end.
