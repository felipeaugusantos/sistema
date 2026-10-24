unit untFuncoesGenCompartilhada;

interface

Type
  TFuncoesGenCompartilhada = Class
  Public
    class function fSQLBuscaComplementarPorToken(const AIndexFields, AFieldsAlias: TArray<string>; const AFilter: String; var AHavingFilters: string): string; overload;
    class function fSQLBuscaComplementarPorToken(const AIndexFields, AFieldName, AFieldAlias, AFilter: String; var AHavingFilters: string): string; overload;
    Class function fMskDigitos(intDigitos: Integer): String;
    Class function fStrToFloat(strValor: String): Double;
    Class function fFormataFloat(fltNumero: Double; intDecimais: Integer): Double;
  End;

var
  innodb_ft_min_token_size: Integer;

implementation

uses
  System.SysUtils, System.StrUtils, System.Classes;

{ TFuncoesGenCompartilhada }

class function TFuncoesGenCompartilhada.fFormataFloat(fltNumero: Double;
  intDecimais: Integer): Double;
begin
  Result := fStrToFloat(FloatToStrF(fltNumero, ffFixed, 12, intDecimais));
end;

class function TFuncoesGenCompartilhada.fMskDigitos(intDigitos: Integer): String;
Var
  intContador: Integer;
  strMsk1    : String;
  strMsk2    : String;
begin
  strMsk1 := '#,';
  strMsk2 := '0.';

  For intContador := 1 To intDigitos Do
  Begin
    strMsk1 := strMsk1 + '#';
    strMsk2 := strMsk2 + '0';
  End;

  Result := strMsk1 + strMsk2;

end;

class function TFuncoesGenCompartilhada.fSQLBuscaComplementarPorToken(const AIndexFields, AFieldsAlias: TArray<string>; const AFilter: String; var AHavingFilters: string): string;
var
  LSQL: string;
  LIndex: Integer;
  LFilters: TStringList;
  LIndexFields: string;
begin
  Result := EmptyStr;

  if Length(AIndexFields) = 0 then
    raise Exception.Create('fSQLBuscaComplementarPorToken -> Length(AIndexFields) = 0');

  if Length(AIndexFields) = 1 then
  begin
    Result := fSQLBuscaComplementarPorToken(AIndexFields[0], AIndexFields[0], AFieldsAlias[0], AFilter, AHavingFilters);
    Exit;
  end;

  LIndexFields := EmptyStr;

  for LIndex := 0 to Length(AIndexFields)-1 do
  begin
    if not LIndexFields.IsEmpty then
      LIndexFields := LIndexFields + ',';
    LIndexFields := LIndexFields + AIndexFields[LIndex];
  end;

  LFilters := TStringList.Create;
  try
    LFilters.Text := AFilter.Replace('//', '/' + #13 + '/');
    for LIndex := 0 to Length(AIndexFields)-1 do
    begin
      if LIndex > Pred(LFilters.Count) then
        Continue;

      LSQL := fSQLBuscaComplementarPorToken(LIndexFields, AIndexFields[LIndex],
        AFieldsAlias[LIndex], LFilters[LIndex], AHavingFilters);

      if LSQL.IsEmpty then
        Continue;

      if not Result.IsEmpty then
        Result := Result + ' AND ';

      Result := Result + LSQL;
    end;
  finally
    LFilters.Free;
  end;
end;

class function TFuncoesGenCompartilhada.fSQLBuscaComplementarPorToken(const AIndexFields, AFieldName, AFieldAlias, AFilter: String; var AHavingFilters: string): string;
var
  LSL: TStringList;
  LIndex: Integer;
  LFilter: string;
  LTokenSize: Integer;
begin
  Result := '';

  If AFilter.Trim.IsEmpty Then
    Exit;

  LSL := TStringList.Create;
  try
    ExtractStrings([' '], [], PChar(AFilter.Replace('/', '* ')), LSL);
    for LIndex := 0 to LSL.Count-1 do
    begin
      LFilter := LSL[LIndex];

      if LFilter.IsEmpty then
        Continue;

      LFilter := LFilter.Replace('*', '%');

      if LFilter = '%' then
        Continue;

      if LFilter.StartsWith('%') and LFilter.EndsWith('%') then
      begin
        If Result <> '' Then
          Result := Result + ' AND ';
        Result := Result + 'CONCAT(' + AIndexFields + ') LIKE "' + LFilter + '" ';
        Continue;
      end;

      if AHavingFilters <> '' then
        AHavingFilters := AHavingFilters + ' AND ';

      if LFilter.EndsWith('%') then
      begin
        if AFilter.StartsWith(LFilter.Replace('%','') + '/') then
          AHavingFilters := AHavingFilters + AFieldAlias + ' LIKE "' + LFilter + '" '
        else if AFilter.Contains('/' + LFilter.Replace('%','')) then
          AHavingFilters := AHavingFilters + AFieldAlias + ' LIKE "% ' + LFilter + '" '
        else
          AHavingFilters := AHavingFilters + AFieldAlias + ' LIKE "%' + LFilter + '%" ';
      end
      else
        AHavingFilters := AHavingFilters + AFieldAlias + ' LIKE "%' + LFilter + '%" ';

      LFilter := AnsiReplaceStr(LFilter, '-', '_');
      LFilter := AnsiReplaceStr(LFilter, '+', '_');
      LFilter := AnsiReplaceStr(LFilter, '/', '_');
      LFilter := AnsiReplaceStr(LFilter, '\', '_');
      LFilter := AnsiReplaceStr(LFilter, '.', '_');
      LFilter := AnsiReplaceStr(LFilter, ':', '_');
      LFilter := AnsiReplaceStr(LFilter, '(', '_');
      LFilter := AnsiReplaceStr(LFilter, ')', '_');
      LFilter := AnsiReplaceStr(LFilter, '>', '_');
      LFilter := AnsiReplaceStr(LFilter, '<', '_');
      LFilter := AnsiReplaceStr(LFilter, '"', '_');
      LFilter := AnsiReplaceStr(LFilter, '~', '_');

      if LFilter.EndsWith('%') then
      begin
        LFilter := LFilter.Replace('%', '').Trim;
        LTokenSize := Length(LFilter.Trim);
      end
      else
      begin
        LTokenSize := Length(LFilter.Trim);
        LFilter := '| _' + LFilter.Replace('%', '_').Trim + '_ |';
      end;

      if Result <> '' then
        Result := Result + ' AND ';

      if LTokenSize <= innodb_ft_min_token_size then
      begin
        Result := Result + AFieldName + ' LIKE "%' + LFilter + '%" ';
      end
      else
      begin
        Result := Result + ' MATCH (' + AIndexFields + ') AGAINST ( ' + QuotedStr('+' + LFilter + '*') + ' IN BOOLEAN MODE) ';
        AHavingFilters := AHavingFilters + ' AND ' + AFieldAlias + ' LIKE "%' + LFilter + '%" ';
      end;
    end;
  finally
    FreeAndNil(LSL);
  end;
end;

class function TFuncoesGenCompartilhada.fStrToFloat(strValor: String): Double;
begin
  Result := strToFloat(AnsiReplaceStr(strValor,'.',''));
end;

end.
