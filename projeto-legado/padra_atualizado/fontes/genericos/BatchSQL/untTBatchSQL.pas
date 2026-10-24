unit untTBatchSQL;

interface

uses
  System.Classes, Math, System.SysUtils,System.Generics.Collections, System.Variants,
  Data.DB, Uni, UniProvider,System.TypInfo,System.RegularExpressions;

type
  TBatchSQL = class;

  TBatchErrorEvent = procedure(Sender: TObject; E: Exception;
    const ASQL: string; AItemIndex: Integer) of object;

  TBatchProgressEvent = TProc<TObject, Integer, Integer>;

  EBatchSQLException = class(Exception);

  TBatchParam = record
    Name: string;
    Value: Variant;
    DataType: TFieldType;
    FormattedValue: string;
  end;

  TBatchSQL = class(TComponent)
  private
    FQuery: TUniQuery;
    FOwnsQuery: Boolean;
    FCommands: TStringList;
    FOnError: TBatchErrorEvent;
    FOnProgress: TBatchProgressEvent;
    FBatchSize: Integer;
    FMaxBatchSize: Integer;
    FStopOnError: Boolean;

    FCurrentSQL: string;
    FCurrentParams: TList<TBatchParam>;
    FCurrentTable: string;
    FSetClause: string;
    FWhereClause: string;
    FFieldsClause: string;
    FValuesClause: string;

    procedure FinalizeCurrentCommand;
    procedure ExecuteBatch;
    function fSafeSQLValue(const AValue : String): String;
    function GetCommandCount: Integer;
    function FormatValue(const AValue: Variant; ADataType: TFieldType): string;

    function ExtractSQLFromQuery(AQuery: TUniQuery): string;
    function FormatParamValueForExtraction(AParam: TParam): string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function BeginCommand(const ASQL: string): TBatchSQL;
    function AddParam(const AName: string; const AValue: Variant;
      ADataType: TFieldType = ftUnknown): TBatchSQL;
    function EndCommand: TBatchSQL;

    function BeginUpdate(const ATableName: string): TBatchSQL;
    function SetClause(const AClause: string): TBatchSQL;
    function WhereClause(const AClause: string): TBatchSQL;
    function EndUpdate: TBatchSQL;

    function BeginInsert(const ATableName: string): TBatchSQL;
    function Fields(const AFields: string): TBatchSQL;
    function Values(const AValues: string): TBatchSQL;
    function EndInsert: TBatchSQL;

    function BeginDelete(const ATableName: string): TBatchSQL;
    function EndDelete: TBatchSQL;

    function ExtractExecutableSQL(AQuery: TUniQuery): string;
    function ExtractSQLWithParams(AQuery: TUniQuery): string;
    procedure AddQueryAsCommand(AQuery: TUniQuery);

    function Execute: Boolean; overload;
    function Execute(AQuery: TUniQuery): Boolean; overload;

    procedure Clear;

    property Query: TUniQuery read FQuery write FQuery;
    {Default False: preserva os chamadores que ja liberam o proprio query
     (untCadConcilBancNova.pas, untFuncAutban.pas).}
    property OwnsQuery: Boolean read FOwnsQuery write FOwnsQuery;
    property BatchSize: Integer read FBatchSize write FBatchSize;
    property MaxBatchSize: Integer read FMaxBatchSize write FMaxBatchSize;
    property StopOnError: Boolean read FStopOnError write FStopOnError;
    property CommandCount: Integer read GetCommandCount;

    // Eventos
    property OnError: TBatchErrorEvent read FOnError write FOnError;
    property OnProgress: TBatchProgressEvent read FOnProgress write FOnProgress;
  end;

implementation

{ TBatchSQL }

constructor TBatchSQL.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FCommands := TStringList.Create;
  FCurrentParams := TList<TBatchParam>.Create;
  FBatchSize := 100;
  FMaxBatchSize := 1000;
  FStopOnError := True;
end;

destructor TBatchSQL.Destroy;
begin
  {Condicional: liberar sempre quebraria chamadores que sao donos do
   proprio query - ver property OwnsQuery.}
  If FOwnsQuery Then
    FreeAndNil(FQuery);

  FreeAndNil(FCommands);
  FreeAndNil(FCurrentParams);
  inherited Destroy;
end;

function TBatchSQL.GetCommandCount: Integer;
begin
  Result := FCommands.Count;
end;

procedure TBatchSQL.FinalizeCurrentCommand;
begin
  FCurrentSQL := '';
  FCurrentParams.Clear;
  FCurrentTable := '';
  FSetClause := '';
  FWhereClause := '';
  FFieldsClause := '';
  FValuesClause := '';
end;

function TBatchSQL.FormatValue(const AValue: Variant; ADataType: TFieldType): string;
begin
  if VarIsNull(AValue) or VarIsEmpty(AValue) then
    Result := 'NULL'
  else
  begin
    case ADataType of
      ftString, ftWideString, ftMemo, ftFmtMemo:
        Result := QuotedStr(VarToStr(AValue).Replace('''', ''''''));

      ftDate, ftTime, ftDateTime, ftTimeStamp:
        Result := QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', AValue));

      ftBoolean, ftWord:
        if AValue then Result := '1' else Result := '0';

      ftFloat, ftCurrency, ftBCD, ftFMTBcd:
        Result := StringReplace(FloatToStr(AValue), ',', '.', [rfReplaceAll]);

      else
        Result := VarToStr(AValue);
    end;
  end;
end;

function TBatchSQL.ExtractSQLFromQuery(AQuery: TUniQuery): string;
begin
  if not Assigned(AQuery) then
    raise Exception.Create('Query não atribuída');

  Result := AQuery.SQL.Text.Trim;
end;

function TBatchSQL.FormatParamValueForExtraction(AParam: TParam): string;
begin
  if AParam.IsNull then
    Result := 'NULL'
  else
  begin
    case AParam.DataType of
      ftString, ftWideString, ftMemo, ftFmtMemo:
        Result := QuotedStr(AParam.AsString.Replace('''', ''''''));

      ftDate, ftTime, ftDateTime, ftTimeStamp:
        Result := QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', AParam.AsDateTime));

      ftBoolean:
        if AParam.AsBoolean then Result := '1' else Result := '0';

      ftFloat, ftCurrency, ftBCD, ftFMTBcd:
        Result := StringReplace(AParam.AsString, ',', '.', [rfReplaceAll]);

      ftInteger, ftSmallint, ftWord, ftLargeint:
        Result := AParam.AsString;

      else
        Result := QuotedStr(AParam.AsString);
    end;
  end;
end;

function TBatchSQL.ExtractExecutableSQL(AQuery: TUniQuery): string;
var
  LSQL: string;
  I: Integer;
  LParam: TParam;
  LParamName: string;
  LParamValue: string;
begin
  LSQL := ExtractSQLFromQuery(AQuery);

  for I := AQuery.Params.Count - 1 downto 0 do
  begin
    LParam := AQuery.Params[I];
    LParamName := ':' + LParam.Name;
    LParamValue := FormatParamValueForExtraction(LParam);

    LSQL := StringReplace(LSQL, LParamName, LParamValue, [rfReplaceAll]);
  end;

  Result := LSQL;
end;

function TBatchSQL.ExtractSQLWithParams(AQuery: TUniQuery): string;
var
  LSQL: string;
  I: Integer;
  LParam: TParam;
begin
  LSQL := ExtractSQLFromQuery(AQuery);

  Result := 'SQL: ' + LSQL + sLineBreak + 'Parâmetros:' + sLineBreak;

  for I := 0 to AQuery.Params.Count - 1 do
  begin
    LParam := AQuery.Params[I];
    Result := Result + Format('  :%s = %s (%s)', [
      LParam.Name,
      FormatParamValueForExtraction(LParam),
      GetEnumName(TypeInfo(TFieldType), Integer(LParam.DataType))
    ]) + sLineBreak;
  end;
end;

procedure TBatchSQL.AddQueryAsCommand(AQuery: TUniQuery);
var
  LExecutableSQL: string;
begin
  LExecutableSQL := ExtractExecutableSQL(AQuery);
  FCommands.Add(LExecutableSQL);
end;

function TBatchSQL.BeginCommand(const ASQL: string): TBatchSQL;
begin
  FinalizeCurrentCommand;
  FCurrentSQL := ASQL;
  Result := Self;
end;

function TBatchSQL.AddParam(const AName: string; const AValue: Variant;
  ADataType: TFieldType = ftUnknown): TBatchSQL;
var
  LParam: TBatchParam;
begin
  LParam.Name := AName;
  LParam.Value := AValue;
  LParam.DataType := ADataType;
  LParam.FormattedValue := FormatValue(AValue, ADataType);

  FCurrentSQL := StringReplace(FCurrentSQL, ':' + AName, LParam.FormattedValue, [rfReplaceAll]);

  FCurrentParams.Add(LParam);
  Result := Self;
end;

function TBatchSQL.EndCommand: TBatchSQL;
begin
  if FCurrentSQL <> '' then
  begin
    FCommands.Add(FCurrentSQL);
    FinalizeCurrentCommand;
  end;
  Result := Self;
end;

function TBatchSQL.BeginUpdate(const ATableName: string): TBatchSQL;
begin
  FinalizeCurrentCommand;
  FCurrentTable := ATableName;
  Result := Self;
end;

function TBatchSQL.SetClause(const AClause: string): TBatchSQL;
begin
  FSetClause := AClause;
  Result := Self;
end;

function TBatchSQL.WhereClause(const AClause: string): TBatchSQL;
begin
  FWhereClause := AClause;
  Result := Self;
end;

function TBatchSQL.EndUpdate: TBatchSQL;
begin
  if (FCurrentTable <> '') and (FSetClause <> '') and (FWhereClause <> '') then
  begin
    FCurrentSQL := Format('UPDATE %s SET %s WHERE %s',
      [FCurrentTable, FSetClause, FWhereClause]);

    while FCurrentParams.Count > 0 do
    begin
      FCurrentSQL := StringReplace(FCurrentSQL,
        ':' + FCurrentParams[0].Name,
        FCurrentParams[0].FormattedValue,
        [rfReplaceAll]);
      FCurrentParams.Delete(0);
    end;

    FCommands.Add(FCurrentSQL);
    FinalizeCurrentCommand;
  end;
  Result := Self;
end;

function TBatchSQL.BeginInsert(const ATableName: string): TBatchSQL;
begin
  FinalizeCurrentCommand;
  FCurrentTable := ATableName;
  Result := Self;
end;

function TBatchSQL.Fields(const AFields: string): TBatchSQL;
begin
  FFieldsClause := AFields;
  Result := Self;
end;

function TBatchSQL.Values(const AValues: string): TBatchSQL;
begin
  FValuesClause := AValues;
  Result := Self;
end;

function TBatchSQL.EndInsert: TBatchSQL;
begin
  if (FCurrentTable <> '') and (FFieldsClause <> '') and (FValuesClause <> '') then
  begin
    FCurrentSQL := Format('INSERT INTO %s (%s) VALUES (%s)',
      [FCurrentTable, FFieldsClause, FValuesClause]);

    while FCurrentParams.Count > 0 do
    begin
      FCurrentSQL := StringReplace(FCurrentSQL,
        ':' + FCurrentParams[0].Name,
        FCurrentParams[0].FormattedValue,
        [rfReplaceAll]);
      FCurrentParams.Delete(0);
    end;

    FCommands.Add(FCurrentSQL);
    FinalizeCurrentCommand;
  end;
  Result := Self;
end;

function TBatchSQL.BeginDelete(const ATableName: string): TBatchSQL;
begin
  FinalizeCurrentCommand;
  FCurrentTable := ATableName;
  Result := Self;
end;

function TBatchSQL.EndDelete: TBatchSQL;
begin
  if (FCurrentTable <> '') and (FWhereClause <> '') then
  begin
    FCurrentSQL := Format('DELETE FROM %s WHERE %s',
      [FCurrentTable, FWhereClause]);

    while FCurrentParams.Count > 0 do
    begin
      FCurrentSQL := StringReplace(FCurrentSQL,
        ':' + FCurrentParams[0].Name,
        FCurrentParams[0].FormattedValue,
        [rfReplaceAll]);
      FCurrentParams.Delete(0);
    end;

    FCommands.Add(FCurrentSQL);
    FinalizeCurrentCommand;
  end;
  Result := Self;
end;

procedure TBatchSQL.ExecuteBatch;
var
  LSQLBuilder: TStringBuilder;
  LTotalCommands: Integer;
  I, J, LStartIndex, LEndIndex: Integer;
  LBatchSQL: string;
begin
  if (FCommands.Count = 0) or not Assigned(FQuery) then
    Exit;

  LTotalCommands := FCommands.Count;

  // Processa em lotes
  for I := 0 to (LTotalCommands - 1) div FBatchSize do
  begin
    LStartIndex := I * FBatchSize;
    LEndIndex := Min((I + 1) * FBatchSize, LTotalCommands) - 1;

    LSQLBuilder := TStringBuilder.Create;
    try
      LSQLBuilder.Capacity := (LEndIndex - LStartIndex + 1) * 512;

      for J := LStartIndex to LEndIndex do
      begin
        if J > LStartIndex then
          LSQLBuilder.Append('; ');
        LSQLBuilder.Append(FCommands[J]);
      end;

      // Executa este lote específico
      LBatchSQL := LSQLBuilder.ToString;
      FQuery.SQL.Text := fSafeSQLValue(LBatchSQL);
      FQuery.ExecSQL;

      // Notifica progresso
      if Assigned(FOnProgress) then
        FOnProgress(Self, LEndIndex + 1, LTotalCommands);

    finally
      LSQLBuilder.Free;
    end;
  end;
end;

function TBatchSQL.fSafeSQLValue(const AValue : String): String;
begin
  Result := AValue;
  If (AValue.Contains('\')) Then
  Begin
    // Procura uma barra invertida e coloca outra para não quebrar o SQL
    // Transforma \ em \\
    // Se já estiver \\ não faz nada
    Result := TRegEx.Replace(AValue, '(?<!\\)\\(?!\\)', '\\\\');
  End;
end;

function TBatchSQL.Execute: Boolean;
begin
  Result := False;
  try
    ExecuteBatch;
    Result := True;
  except
    on E: Exception do
    begin
      if Assigned(FOnError) then
        FOnError(Self, E, '', FCommands.Count - 1)
      else if FStopOnError then
        raise;
    end;
  end;
end;

function TBatchSQL.Execute(AQuery: TUniQuery): Boolean;
begin
  FQuery := AQuery;
  Result := Execute;
end;

procedure TBatchSQL.Clear;
begin
  FCommands.Clear;
  FinalizeCurrentCommand;
end;

end.
