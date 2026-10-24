unit Correios.Funcoes;

interface

uses
  System.SysUtils,
  System.StrUtils,
  Uni;

var
  VS_qryAux: TUniQuery;  //query auxiliar, já conectada no banco
  VS_strCodEmp: String;  //código da empresa logada
  VS_strNumCar: String;  //número do cartão de postagem
  VS_strNomUsu: String;  //usuário correios
  VS_strCodAce: String;  //código de acesso api correios
  VS_blnHomolo: Boolean; //em homologação

  function GetCfgSigep(const ACamCfg: String): String;
  function AtuCfgSigep(const ACamCfg, AValCfg: String): Boolean;
  function GetCGCEmpresa(const ACodEmp: String): String;
  function GetCfgSis(const ACodCfg: String; const ACodEmp: String = ''): String;
  procedure StartTransaction;
  procedure Commit;
  procedure Rollback;
  procedure PreencheVariaveisGlobais;

implementation

function GetCfgSigep(const ACamCfg: String): String;
begin
  try
    if not Assigned(VS_qryAux) then
      Exit;

    VS_qryAux.Close;
    VS_qryAux.SQL.Clear;
    VS_qryAux.SQL.Add('SELECT CFG_' + ACamCfg);
    VS_qryAux.SQL.Add('FROM CORCFG');
    VS_qryAux.SQL.Add('WHERE CFG_CODEMP = :CODEMP');
    VS_qryAux.SQL.Add('  AND CFG_STATUS = "A"');

    VS_qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    VS_qryAux.Open;

    Result := VS_qryAux.Fields[0].AsString;

    VS_qryAux.Close;
  except
    raise;
  end;
end;

function AtuCfgSigep(const ACamCfg, AValCfg: String): Boolean;
begin
  Result := False;
  try
    if not Assigned(VS_qryAux) then
      Exit;

    VS_qryAux.Close;
    VS_qryAux.SQL.Clear;
    VS_qryAux.SQL.Add('UPDATE CORCFG');
    VS_qryAux.SQL.Add('SET CFG_' + ACamCfg + ' = :VALCFG');
    VS_qryAux.SQL.Add('WHERE CFG_CODEMP = :CODEMP');
    VS_qryAux.SQL.Add('  AND CFG_STATUS = "A"');

    VS_qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    VS_qryAux.ParamByName('VALCFG').AsString := AValCfg;
    VS_qryAux.ExecSQL;

    VS_qryAux.Close;

    Result := True;
  except
    raise;
  end;
end;

function GetCGCEmpresa(const ACodEmp: String): String;
begin
  try
    if not Assigned(VS_qryAux) then
      Exit;

    VS_qryAux.Close;
    VS_qryAux.SQL.Clear;
    VS_qryAux.SQL.Add('SELECT EMP_C_G_C_');
    VS_qryAux.SQL.Add('FROM CADEMP');
    VS_qryAux.SQL.Add('WHERE EMP_CODEMP = :CODEMP');

    VS_qryAux.ParamByName('CODEMP').AsString := ACodEmp;
    VS_qryAux.Open;

    Result := VS_qryAux.Fields[0].AsString;

    VS_qryAux.Close;
  except
    raise;
  end;
end;

function GetCfgSis(const ACodCfg: String; const ACodEmp: String = ''): String;
begin
  try
    if not Assigned(VS_qryAux) then
      Exit;

    VS_qryAux.Close;
    VS_qryAux.SQL.Clear;
    VS_qryAux.SQL.Add('SELECT SIS_VALCFG');
    VS_qryAux.SQL.Add('FROM CFGSIS');
    VS_qryAux.SQL.Add('WHERE SIS_CODEMP = :CODEMP');
    VS_qryAux.SQL.Add('  AND SIS_CODCFG = :CODCFG');

    VS_qryAux.ParamByName('CODEMP').AsString := IfThen(ACodEmp.IsEmpty, VS_strCodEmp, ACodEmp);
    VS_qryAux.ParamByName('CODCFG').AsString := 'CFG_' + ACodCfg;
    VS_qryAux.Open;

    Result := VS_qryAux.Fields[0].AsString;

    VS_qryAux.Close;
  except
    raise;
  end;
end;

procedure PreencheVariaveisGlobais;
begin
  try
    if not Assigned(VS_qryAux) then
      Exit;

    VS_qryAux.Close;
    VS_qryAux.SQL.Clear;
    VS_qryAux.SQL.Add('SELECT * FROM CORCFG');
    VS_qryAux.SQL.Add('WHERE CFG_CODEMP = :CODEMP');
    VS_qryAux.SQL.Add('  AND CFG_STATUS = "A"');

    VS_qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
    VS_qryAux.Open;

    VS_strNumCar := VS_qryAux.FieldByName('CFG_NUMCAR').AsString;
    VS_strNomUsu := VS_qryAux.FieldByName('CFG_NOMUSU').AsString;
    VS_strCodAce := VS_qryAux.FieldByName('CFG_CODACE').AsString;
    VS_blnHomolo := (VS_qryAux.FieldByName('CFG_HOMOLO').AsString = 'S');

    VS_qryAux.Close;
  except
    raise;
  end;
end;

procedure StartTransaction;
begin
  if not Assigned(VS_qryAux) then
    Exit;

  if not VS_qryAux.Connection.InTransaction then
    VS_qryAux.Connection.StartTransaction;
end;

procedure Commit;
begin
  if not Assigned(VS_qryAux) then
    Exit;

  if VS_qryAux.Connection.InTransaction then
    VS_qryAux.Connection.Commit;
end;

procedure Rollback;
begin
  if not Assigned(VS_qryAux) then
    Exit;

  if VS_qryAux.Connection.InTransaction then
    VS_qryAux.Connection.Rollback;
end;

end.
