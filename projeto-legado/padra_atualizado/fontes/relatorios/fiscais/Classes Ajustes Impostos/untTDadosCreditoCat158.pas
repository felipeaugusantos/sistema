unit untTDadosCreditoCat158;

interface

uses SysUtils, Uni;

type
  TDadosCreditoCat158 = class
  private
    FConexao: TUniConnection;

    function fRetSQLCredito(strEmpresa: string): string;
  public
    function fRetCreditoPeriodo(dtaIni: TDateTime; strEmpresa: string): Double;

    constructor create(conexao: TUniConnection);
  end;

implementation

{ TDadosCreditoCat158 }

constructor TDadosCreditoCat158.create(conexao: TUniConnection);
begin
  inherited create;
  FConexao := conexao;
end;

function TDadosCreditoCat158.fRetCreditoPeriodo(dtaIni: TDateTime; strEmpresa: string): Double;
  var
    qryAux: TUniQuery;
begin
  qryAux := TUniQuery.Create(nil);
  qryAux.Connection := FConexao;
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := fRetSQLCredito(strEmpresa);
      ParamByName('MESANO').AsString := FormatDateTime('MM/YYYY', dtaIni);

      if strEmpresa <> '' then
          ParamByName('CODEMP').AsString := strEmpresa;

      Open;

      Result := FieldByName('VLR_CRED_ICMS').AsFloat;
    end;
  finally
    qryAux.Free;
  end;
end;

function TDadosCreditoCat158.fRetSQLCredito(strEmpresa: string): string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '  ROUND(SUM(CAT_VALICM) + SUM(CAT_VALRET), 2) AS VLR_CRED_ICMS ';
  Result := Result + 'FROM ';
  Result := Result + '  CAT_158_ENTRADA ';
  Result := Result + 'WHERE CAT_MESANO = :MESANO ';

  if strEmpresa <> '' then
    Result := Result + '  AND LOCATE(CAT_CODEMP, :CODEMP) > 0 ';
end;

end.
