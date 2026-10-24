unit untTCfgCredenciaisSitefExp;

interface

uses
  System.SysUtils, System.Classes, Data.Db,
  Uni, UniClientDataset;

type
  TCfgCredenciaisSitefExp = class
    private
      FCdsCredenciais: TUniClientDataset;

      procedure pCarregarCredenciais;
      function fExportarCredenciais: string;
      function fJaExiste(AUrl, ACod: String; ASeq: Integer = 0): Boolean;

    public
      constructor Create;
      destructor Destroy; override;

      procedure pGravarCredenciais;
      function fGetDataset: TDataset;

      procedure pInserir(AUrl, ACod, AUsr, APwd: String);
      procedure pAlterar(AUrl, ACod, AUsr, APwd: String);
      procedure pExcluir(ASeq: Integer);
  end;

implementation

uses
  System.StrUtils, untFuncoesSimples;

{ TCfgCredenciaisSitefExp }

constructor TCfgCredenciaisSitefExp.Create;
var
  LField: TFieldDef;
begin
  FCdsCredenciais := TUniClientDataset.Create(nil);

  LField := FCdsCredenciais.FieldDefs.AddFieldDef;
  LField.Name := 'SEQCRE';
  LField.DataType := ftInteger;

  LField := FCdsCredenciais.FieldDefs.AddFieldDef;
  LField.Name := 'URLAPI';
  LField.DataType := ftString;
  LField.Size := 150;

  LField := FCdsCredenciais.FieldDefs.AddFieldDef;
  LField.Name := 'CODCLI';
  LField.DataType := ftString;
  LField.Size := 30;

  LField := FCdsCredenciais.FieldDefs.AddFieldDef;
  LField.Name := 'USRAUT';
  LField.DataType := ftString;
  LField.Size := 60;

  LField := FCdsCredenciais.FieldDefs.AddFieldDef;
  LField.Name := 'PWDAUT';
  LField.DataType := ftString;
  LField.Size := 60;

  FCdsCredenciais.CreateDataSet;

  FCdsCredenciais.IndexFieldNames := 'SEQCRE';

  FCdsCredenciais.Open;

  pCarregarCredenciais;
end;

destructor TCfgCredenciaisSitefExp.Destroy;
begin
  FreeAndNil(FCdsCredenciais);
  inherited;
end;

function TCfgCredenciaisSitefExp.fGetDataset: TDataset;
begin
  Result := FCdsCredenciais;
end;

procedure TCfgCredenciaisSitefExp.pInserir(AUrl, ACod, AUsr, APwd: String);
begin
  if AUrl = '' then
    raise Exception.Create('URL deve ser preenchida.');

  if ACod = '' then
    raise Exception.Create('Código Cliente deve ser preenchido.');

  if AUsr = '' then
    raise Exception.Create('Usuário deve ser preenchido.');

  if APwd = '' then
    raise Exception.Create('Senha deve ser preenchida.');

  if fJaExiste(AUrl, ACod) then
    raise Exception.Create('Já existe um registro cadastrado com a mesma URL/Código Cliente');

  FCdsCredenciais.Append;
  FCdsCredenciais.FieldByName('SEQCRE').AsInteger := FCdsCredenciais.RecordCount + 1;
  FCdsCredenciais.FieldByName('URLAPI').AsString := AUrl;
  FCdsCredenciais.FieldByName('CODCLI').AsString := ACod;
  FCdsCredenciais.FieldByName('USRAUT').AsString := AUsr;
  FCdsCredenciais.FieldByName('PWDAUT').AsString := APwd;
  FCdsCredenciais.Post;
end;

function TCfgCredenciaisSitefExp.fJaExiste(AUrl, ACod: String; ASeq: Integer = 0): Boolean;
begin
  Result := False;
  FCdsCredenciais.First;
  while not FCdsCredenciais.Eof do
  begin
    Result := AUrl = FCdsCredenciais.FieldByName('URLAPI').AsString;
    Result := Result and (ACod = FCdsCredenciais.FieldByName('CODCLI').AsString);

    if ASeq > 0 then
      Result := Result and (FCdsCredenciais.FieldByName('SEQCRE').AsInteger <> ASeq);

    if Result then
      Break;

    FCdsCredenciais.Next;
  end;

  if ASeq > 0 then
    FCdsCredenciais.FindKey([ASeq]);
end;

procedure TCfgCredenciaisSitefExp.pExcluir(ASeq: Integer);
begin
  if FCdsCredenciais.FindKey([ASeq]) then
    FCdsCredenciais.Delete;
end;

procedure TCfgCredenciaisSitefExp.pGravarCredenciais;
var
  strSQL: String;
  qryCfg: TUniQuery;
begin
  qryCfg := fCriaQuery(Nil);
  try
    strSQL := '';
    strSQL := strSQL + 'UPDATE   ';
    strSQL := strSQL + '  CFGSIS ';
    strSQL := strSQL + 'SET      ';
    strSQL := strSQL + '  SIS_VALCFG = :VALCFG ';
    strSQL := strSQL + 'WHERE    ';
    strSQL := strSQL + '  SIS_CODCFG = :CODCFG AND ';
    strSQL := strSQL + '  SIS_CODEMP = :CODEMP     ';

    qryCfg.SQL.Add(strSQL);
    qryCfg.ParamByName('VALCFG').AsString := fExportarCredenciais;
    qryCfg.ParamByName('CODCFG').AsString := 'CFG_SE_CRE';
    qryCfg.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCfg.ExecSQL;
  finally
    FreeAndNil(qryCfg);
  end;

end;

function TCfgCredenciaisSitefExp.fExportarCredenciais: string;
begin
  Result := '';
  FCdsCredenciais.First;

  while not FCdsCredenciais.Eof do
  begin
    if Result <> '' then
      Result := Result + ';';

    Result := Result + FCdsCredenciais.FieldByName('URLAPI').AsString;
    Result := Result + '|' + FCdsCredenciais.FieldByName('CODCLI').AsString;
    Result := Result + '|' + FCdsCredenciais.FieldByName('USRAUT').AsString;
    Result := Result + '|' + FCdsCredenciais.FieldByName('PWDAUT').AsString;

    FCdsCredenciais.Next;
  end;

end;

procedure TCfgCredenciaisSitefExp.pAlterar(AUrl, ACod, AUsr, APwd: String);
begin
  if AUrl = '' then
    raise Exception.Create('URL deve ser preenchida.');

  if ACod = '' then
    raise Exception.Create('Código Cliente deve ser preenchido.');

  if AUsr = '' then
    raise Exception.Create('Usuário deve ser preenchido.');

  if APwd = '' then
    raise Exception.Create('Senha deve ser preenchida.');

  if fJaExiste(AUrl, ACod, FCdsCredenciais.FieldByName('SEQCRE').AsInteger) then
    raise Exception.Create('Já existe um registro cadastrado com a mesma URL/Código Cliente');

  FCdsCredenciais.Edit;
  FCdsCredenciais.FieldByName('URLAPI').AsString := AUrl;
  FCdsCredenciais.FieldByName('CODCLI').AsString := ACod;
  FCdsCredenciais.FieldByName('USRAUT').AsString := AUsr;
  FCdsCredenciais.FieldByName('PWDAUT').AsString := APwd;
  FCdsCredenciais.Post;
end;

procedure TCfgCredenciaisSitefExp.pCarregarCredenciais;
var
  LCredenciais, LCredencial: TStringList;
  LLinha: string;
  LSeq: Integer;
begin
  FCdsCredenciais.EmptyDataSet;

  LCredenciais := TStringList.Create;
  LCredencial := TStringList.Create;
  try
    LCredenciais.Delimiter := ';';
    LCredenciais.DelimitedText := fCampoTabela('SIS_VALCFG', 'CFGSIS', ['SIS_CODEMP', 'SIS_CODCFG'], [VS_strCodEmp, 'CFG_SE_CRE']);

    LCredencial.Delimiter := '|';
    LSeq := 0;
    for LLinha in LCredenciais do
    begin
      LCredencial.Clear;
      LCredencial.DelimitedText := LLinha;

      if LCredencial.Count = 0 then
        Continue;

      Inc(LSeq);
      FCdsCredenciais.Append;
      FCdsCredenciais.FieldByName('SEQCRE').AsInteger := LSeq;
      FCdsCredenciais.FieldByName('URLAPI').AsString := LCredencial[0];
      FCdsCredenciais.FieldByName('CODCLI').AsString := LCredencial[1];
      FCdsCredenciais.FieldByName('USRAUT').AsString := LCredencial[2];
      FCdsCredenciais.FieldByName('PWDAUT').AsString := LCredencial[3];
      FCdsCredenciais.Post;
    end;

  finally;
    FreeAndNil(LCredencial);
    FreeAndNil(LCredenciais);
  end;
end;

end.
