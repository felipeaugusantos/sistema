unit untTSatSes;

interface

type
  iModelSatSes = interface
    ['{A0E02705-85F7-4487-9322-9DC6DB041DAF}']
    function NumDoc: string; overload;
    function NumDoc(const Value: string): iModelSatSes; overload;
    function EspDoc: string; overload;
    function EspDoc(const Value: string): iModelSatSes; overload;
    function CodEmp: string; overload;
    function CodEmp(const Value: string): iModelSatSes; overload;
    function CodCli: string; overload;
    function CodCli(const Value: string): iModelSatSes; overload;
    function Serie: string; overload;
    function Serie(const Value: string): iModelSatSes; overload;
    function Sessao: Integer; overload;
    function Sessao(Value: Integer): iModelSatSes; overload;
  end;

  iGravaSatSes = interface
    ['{64194938-473A-4665-8DF8-0D1859DED5D3}']
    function GravaSatSes(SatSes: iModelSatSes): iGravaSatSes;
  end;

  TSatSes = class(TInterfacedObject, iModelSatSes)
  private
    FNumDoc : String;
    FEspDoc : String;
    FCodEmp : String;
    FCodCli : String;
    FSerie  : String;
    FSessao : Integer;
  public
    function NumDoc: string; overload;
    function NumDoc(const Value: string): iModelSatSes; overload;
    function EspDoc: string; overload;
    function EspDoc(const Value: string): iModelSatSes; overload;
    function CodEmp: string; overload;
    function CodEmp(const Value: string): iModelSatSes; overload;
    function CodCli: string; overload;
    function CodCli(const Value: string): iModelSatSes; overload;
    function Serie: string; overload;
    function Serie(const Value: string): iModelSatSes; overload;
    function Sessao: Integer; overload;
    function Sessao(Value: Integer): iModelSatSes; overload;
    constructor Create;
    destructor Destroy; override;
    class function New: iModelSatSes;
  end;

  TGravaSatSes = class(TInterfacedObject, iGravaSatSes)
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iGravaSatSes;
    function GravaSatSes(SatSes: iModelSatSes): iGravaSatSes;
  end;

implementation

uses Uni, SysUtils, untFuncoesSimples;

{ TGravaSatSes }

constructor TGravaSatSes.Create;
begin
end;

destructor TGravaSatSes.Destroy;
begin
  inherited;
end;

function TGravaSatSes.GravaSatSes(SatSes: iModelSatSes): iGravaSatSes;
  var
    qrySatSes : TUniQuery;
begin
  qrySatSes := fCriaQuery(nil);
  try
    qrySatSes.SQL.Text := 'SELECT * FROM SATSES WHERE FALSE';
    qrySatSes.Open;
    qrySatSes.Insert;
    qrySatSes.FieldByName('SES_NUMDOC').AsString := SatSes.NumDoc;
    qrySatSes.FieldByName('SES_ESPDOC').AsString := SatSes.EspDoc;
    qrySatSes.FieldByName('SES_CODEMP').AsString := SatSes.CodEmp;
    qrySatSes.FieldByName('SES_CODCLI').AsString := SatSes.CodCli;
    qrySatSes.FieldByName('SES_SERIE_').AsString := SatSes.Serie;
    qrySatSes.FieldByName('SES_SESSAO').AsInteger := SatSes.Sessao;
    qrySatSes.Post;
    qrySatSes.Close;
  finally
    FreeAndNil(qrySatSes);
  end;
end;

class function TGravaSatSes.New: iGravaSatSes;
begin
  Result := Self.Create;
end;

{ TSatSes }

function TSatSes.CodCli(const Value: string): iModelSatSes;
begin
  Result := Self;
  FCodCli := Value;
end;

function TSatSes.CodCli: string;
begin
  Result := FCodCli;
end;

function TSatSes.CodEmp: string;
begin
  Result := FCodEmp;
end;

function TSatSes.CodEmp(const Value: string): iModelSatSes;
begin
  Result := Self;
  FCodEmp := Value;
end;

constructor TSatSes.Create;
begin
end;

destructor TSatSes.Destroy;
begin
  inherited;
end;

function TSatSes.EspDoc(const Value: string): iModelSatSes;
begin
  Result := Self;
  FEspDoc := Value;
end;

function TSatSes.EspDoc: string;
begin
  Result := FEspDoc;
end;

class function TSatSes.New: iModelSatSes;
begin
  Result := Self.Create;
end;

function TSatSes.NumDoc(const Value: string): iModelSatSes;
begin
  Result := Self;
  FNumDoc := Value;
end;

function TSatSes.NumDoc: string;
begin
  Result := FNumDoc;
end;

function TSatSes.Serie: string;
begin
  Result := FSerie;
end;

function TSatSes.Serie(const Value: string): iModelSatSes;
begin
  Result := Self;
  FSerie := Value;
end;

function TSatSes.Sessao: Integer;
begin
  Result := FSessao;
end;

function TSatSes.Sessao(Value: Integer): iModelSatSes;
begin
  Result := Self;
  FSessao := Value;
end;

end.
