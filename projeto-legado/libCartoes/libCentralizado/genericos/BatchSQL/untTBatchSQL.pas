unit untTBatchSQL;


interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
{$ENDIF}
  System.Classes, Math, System.SysUtils,System.Generics.Collections, System.Variants,
  Data.DB, Uni, UniProvider, System.TypInfo,System.RegularExpressions;

type
  TBatchSQL = class;

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
    FOwnsQuery: Boolean;   {Req. 456948 - achado 8 do review}
    FCommands: TStringList;
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

    // substituicao de parametro em passada unica sobre o SQL.
    function fSubstituiParametros(const ASQL: string;
      ADicParams: TDictionary<string, string>): string;
    function fResolveComandoAtual(const ASQL: string): string;

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
    function Execute(AQuery: TUniQuery; ALimpar: Boolean = False): Boolean; overload;

    // acesso ao texto ja montado. Usado pelo log de diagnostico do
    // batch que falhou e pelos testes unitarios da substituicao de parametro.
    function CommandText(AIndex: Integer): string;
    function BatchText: string;

    procedure Clear;

    property Query: TUniQuery read FQuery write FQuery;
    {Req. 456948 - achado 8 do review. Default False: preserva os
     chamadores que criam o proprio query e o liberam por conta deles -
     financeiro/gerais/untCadConcilBancNova.pas e
     genericos/untFuncAutban.pas. So quem passar True aqui delega a posse.}
    property OwnsQuery: Boolean read FOwnsQuery write FOwnsQuery;
    property BatchSize: Integer read FBatchSize write FBatchSize;
    property MaxBatchSize: Integer read FMaxBatchSize write FMaxBatchSize;
    property StopOnError: Boolean read FStopOnError write FStopOnError;
    property CommandCount: Integer read GetCommandCount;

    // Eventos
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
  {Req. 456948 - achado 8 do review. Condicional de proposito: liberar
   sempre quebraria os dois chamadores que sao donos do proprio query -
   ver comentario da property OwnsQuery.}
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
      // QuotedStr ja dobra os apostrofos do conteudo; o .Replace que existia
      // aqui dobrava de novo, gravando D''AGUA em vez de D'AGUA.
      ftString, ftWideString, ftMemo, ftFmtMemo:
        Result := QuotedStr(VarToStr(AValue));

      ftDate, ftTime, ftDateTime, ftTimeStamp:
        Result := QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', AValue));

      ftBoolean:
        if AValue then Result := '1' else Result := '0';

      { ftWord ficava junto do ftBoolean e virava '1'/'0': AddParam('NROTAB',
        7, ftWord) gravava 1. FormatParamValueForExtraction sempre tratou
        ftWord como numerico -- as duas metades da classe divergiam. }
      ftInteger, ftSmallint, ftWord, ftLargeint, ftAutoInc:
        Result := VarToStr(AValue);

      ftFloat, ftCurrency, ftBCD, ftFMTBcd:
        Result := StringReplace(FloatToStr(AValue), ',', '.', [rfReplaceAll]);

      else
        Result := VarToStr(AValue);
    end;
  end;
end;

{ Resolve os :parametros do SQL em uma unica passada, da esquerda para a
  direita, escrevendo direto na saida sem reexaminar o que ja foi escrito.
  StringReplace um parametro por vez tem dois defeitos que isso evita: um
  nome que e prefixo de outro corrompe o mais longo (:CAMPO dentro de
  :CAMPO_NOV), e um valor ja substituido pode conter texto parecido com
  :NOME e ser reprocessado pelas passadas seguintes. }
function TBatchSQL.fSubstituiParametros(const ASQL: string;
  ADicParams: TDictionary<string, string>): string;
  Var
    LsbSaida: TStringBuilder;
    intPos, intIni, intTam: Integer;
    strNome, strValor: string;
begin
  LsbSaida := TStringBuilder.Create;
  try
    LsbSaida.Capacity := Length(ASQL) + 256;

    intPos := 1;
    intTam := Length(ASQL);

    while intPos <= intTam do
    begin
      if (ASQL[intPos] = ':') and (intPos < intTam) and
         CharInSet(ASQL[intPos + 1], ['A'..'Z', 'a'..'z', '_']) then
      begin
        intIni := intPos + 1;
        intPos := intIni;

        while (intPos <= intTam) and
              CharInSet(ASQL[intPos], ['A'..'Z', 'a'..'z', '0'..'9', '_']) do
          Inc(intPos);

        strNome := Copy(ASQL, intIni, intPos - intIni);

        if ADicParams.TryGetValue(UpperCase(strNome), strValor) then
          LsbSaida.Append(strValor)
        else
          LsbSaida.Append(':').Append(strNome);
      end
      else
      begin
        LsbSaida.Append(ASQL[intPos]);
        Inc(intPos);
      end;
    end;

    Result := LsbSaida.ToString;
  finally
    LsbSaida.Free;
  end;
end;

function TBatchSQL.fResolveComandoAtual(const ASQL: string): string;
  Var
    dicParams: TDictionary<string, string>;
    intIndice: Integer;
begin
  dicParams := TDictionary<string, string>.Create;
  try
    for intIndice := 0 to FCurrentParams.Count - 1 do
      dicParams.AddOrSetValue(UpperCase(FCurrentParams[intIndice].Name),
                              FCurrentParams[intIndice].FormattedValue);

    Result := fSubstituiParametros(ASQL, dicParams);
  finally
    dicParams.Free;
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
      // Escapa uma vez so -- ver o comentario em FormatValue.
      ftString, ftWideString, ftMemo, ftFmtMemo:
        Result := QuotedStr(AParam.AsString);

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
  Var
    dicParams: TDictionary<string, string>;
    intIndice: Integer;
begin
  dicParams := TDictionary<string, string>.Create;
  try
    for intIndice := 0 to AQuery.Params.Count - 1 do
      dicParams.AddOrSetValue(UpperCase(AQuery.Params[intIndice].Name),
                              FormatParamValueForExtraction(AQuery.Params[intIndice]));

    Result := fSubstituiParametros(ExtractSQLFromQuery(AQuery), dicParams);
  finally
    dicParams.Free;
  end;
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

  // nao substitui aqui. A substituicao imediata tornava o
  // resultado dependente da ordem de chamada do AddParam -- um parametro cujo
  // nome fosse prefixo de outro corrompia o mais longo se entrasse primeiro.
  // Agora quem resolve e o End*, em passada unica sobre o SQL montado.
  FCurrentParams.Add(LParam);
  Result := Self;
end;

function TBatchSQL.EndCommand: TBatchSQL;
begin
  if FCurrentSQL <> '' then
  begin
    FCommands.Add(fResolveComandoAtual(FCurrentSQL));
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
    FCurrentSQL := fResolveComandoAtual(Format('UPDATE %s SET %s WHERE %s',
      [FCurrentTable, FSetClause, FWhereClause]));

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
    FCurrentSQL := fResolveComandoAtual(Format('INSERT INTO %s (%s) VALUES (%s)',
      [FCurrentTable, FFieldsClause, FValuesClause]));

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
    FCurrentSQL := fResolveComandoAtual(Format('DELETE FROM %s WHERE %s',
      [FCurrentTable, FWhereClause]));

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
      if FStopOnError then
        raise;
    end;
  end;
end;

function TBatchSQL.Execute(AQuery: TUniQuery; ALimpar: Boolean = False): Boolean;
begin
  FQuery := AQuery;
  Result := Execute;

  If ALimpar Then
    Self.Clear;
end;

function TBatchSQL.CommandText(AIndex: Integer): string;
begin
  Result := '';
  if (AIndex >= 0) and (AIndex < FCommands.Count) then
    Result := FCommands[AIndex];
end;

function TBatchSQL.BatchText: string;
begin
  Result := FCommands.Text;
end;

procedure TBatchSQL.Clear;
begin
  FCommands.Clear;
  FinalizeCurrentCommand;
end;

end.

