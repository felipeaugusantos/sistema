unit untLayXns;

interface


Uses
  Classes,
  SysUtils,
  Controls,
  DB,
  UniClientDataSet,
  Forms,
  Uni,
  untFuncoesSimples,
  untZClient;

Type

  TLayXNS = Class(TZClient)
  Private
    FstrSchema: String;
    FstrSchemaMD5: String;
    function fSQL: String;
  Public
    constructor Create(Owner: TComponent); reintroduce;
    function fSchemaMD5(strSchemaMD5: String): TLayXNS;
    function fSchema(strSchema: String): TLayXNS;
    function fAbrir: TLayXNS;
    function fSalvar: TLayXNS;
    function fConsultar: TLayXNS;
    function fInserir: TLayXNS;
    class function fNovo: TLayXNS;
  End;

implementation

{ TLayXNS }

function TLayXNS.fInserir: TLayXNS;
begin
  Result := Self;
  fConsultar;
  if IsEmpty then
    fSalvar;
end;

constructor TLayXNS.Create(Owner: TComponent);
begin
  Inherited Create(Owner, fSQL);
end;

function TLayXNS.fConsultar: TLayXNS;
begin
  Result := Self;
  Close;
  qryQuery.SQL.Text := 'SELECT SQL_NO_CACHE * FROM LAYXNS WHERE LAY_SCHMD5 = :MD5';
  qryQuery.ParamByName('MD5').AsString := FstrSchemaMD5;
  fAbreClient(True, 'TLayXNS.fConsultar');
end;

function TLayXNS.fSQL: String;
begin
  Result := 'SELECT * FROM LAYXNS WHERE FALSE';
end;

class function TLayXNS.fNovo: TLayXNS;
begin
  Result := TLayXNS.Create(nil);
end;

function TLayXNS.fAbrir: TLayXNS;
begin
  Result := Self;
  fAbreClient(True, 'TLayXNS.fOpen');
end;

function TLayXNS.fSalvar: TLayXNS;
begin
  Result := Self;

  If IsEmpty Then
    Append
  Else
    Edit;

  IF FieldByName('AUTOINCREM').IsNull Then
    FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('LAYXNS', VS_strCodEmp);
  FieldByName('LAY_SCHEMA').AsString := FstrSchema;
  FieldByName('LAY_SCHMD5').AsString := FstrSchemaMD5;

  Try
    fSalva;
  Except
    on E: Exception do
    Begin
      Cancel;
      raise Exception.Create('[TLayXNS.fSalvar]' + E.Message);
    End;
  End;
end;

function TLayXNS.fSchema(strSchema: String): TLayXNS;
begin
  Result := Self;
  FstrSchema := strSchema;
end;

function TLayXNS.fSchemaMD5(strSchemaMD5: String): TLayXNS;
begin
  Result := Self;
  FstrSchemaMD5 := strSchemaMD5;
end;

end.
