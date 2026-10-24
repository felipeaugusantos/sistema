unit untTckEst;

interface

type
  TTckEstModel = class
  private
    strTicket: String;
    dteData: TDateTime;
    tmeHora: TTime;
    strCodCli: String;
    strCodOpeVenda: String;
    strCodOpeLib: String;
  public
    constructor Create;
    function getTicket: String;
    function getData: TDateTime;
    function getHora: TTime;
    function getCodCli: String;
    function getCodOpeVenda: String;
    function getCodOpeLib: String;
    procedure setTicket(strTicket: String);
    procedure setData(dteData: TDateTime);
    procedure setHora(tmeHora: TTime);
    procedure setCodCli(strCodCli: String);
    procedure setCodOpeVenda(strCodOpeVenda: String);
    procedure setCodOpeLib(strCodOpeLib: String);
  end;

implementation

{ TTckEstModel }

constructor TTckEstModel.Create;
begin
  strTicket := '';
  strCodCli := '';
  strCodOpeVenda := '';
  strCodOpeLib := '';
  dteData := 0;
  tmeHora := 0;
end;

function TTckEstModel.getCodCli: String;
begin
  Result := Self.strCodCli;
end;

function TTckEstModel.getCodOpeLib: String;
begin
  Result := Self.strCodOpeLib;
end;

function TTckEstModel.getCodOpeVenda: String;
begin
  Result := Self.strCodOpeVenda;
end;

function TTckEstModel.getData: TDateTime;
begin
  Result := Self.dteData;
end;

function TTckEstModel.getHora: TTime;
begin
  Result := Self.tmeHora;
end;

function TTckEstModel.getTicket: String;
begin
  Result := Self.strTicket;
end;

procedure TTckEstModel.setCodCli(strCodCli: String);
begin
  Self.strCodCli := strCodCli;
end;

procedure TTckEstModel.setCodOpeLib(strCodOpeLib: String);
begin
  Self.strCodOpeLib := strCodOpeLib;
end;

procedure TTckEstModel.setCodOpeVenda(strCodOpeVenda: String);
begin
  Self.strCodOpeVenda := strCodOpeVenda;
end;

procedure TTckEstModel.setData(dteData: TDateTime);
begin
  Self.dteData := dteData;
end;

procedure TTckEstModel.setHora(tmeHora: TTime);
begin
  Self.tmeHora := tmeHora;
end;

procedure TTckEstModel.setTicket(strTicket: String);
begin
  Self.strTicket := strTicket;
end;

end.
