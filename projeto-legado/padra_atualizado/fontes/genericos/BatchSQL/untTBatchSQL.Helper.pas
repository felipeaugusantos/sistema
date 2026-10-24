unit untTBatchSQL.Helper;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections, System.Variants,
  Data.DB, Uni, untTBatchSQL;

type
  TBatchHelper = class sealed
  public
    // Criação e configuração
    class function CreateBatchSQL(AQuery: TUniQuery = nil;
      AOwnsQuery: Boolean = False): TBatchSQL;

    // Métodos de conveniência para criar comandos rapidamente
    class function QuickUpdate(ABatch: TBatchSQL; const ATableName: string): TBatchSQL;
    class function QuickInsert(ABatch: TBatchSQL; const ATableName: string): TBatchSQL;
    class function QuickDelete(ABatch: TBatchSQL; const ATableName: string): TBatchSQL;

    // Métodos para adicionar parâmetros tipados de forma rápida
    class procedure AddStringParam(ABatch: TBatchSQL; const AName, AValue: string);
    class procedure AddIntegerParam(ABatch: TBatchSQL; const AName: string; AValue: Integer);
    class procedure AddFloatParam(ABatch: TBatchSQL; const AName: string; AValue: Double);
    class procedure AddDateTimeParam(ABatch: TBatchSQL; const AName: string; AValue: TDateTime);
    class procedure AddBooleanParam(ABatch: TBatchSQL; const AName: string; AValue: Boolean);
    class procedure AddNullParam(ABatch: TBatchSQL; const AName: string);

    // Métodos para finalizar comandos rapidamente
    class function FinishUpdate(ABatch: TBatchSQL; const ASetClause, AWhereClause: string): TBatchSQL;
    class function FinishInsert(ABatch: TBatchSQL; const AFields, AValues: string): TBatchSQL;
    class function FinishDelete(ABatch: TBatchSQL; const AWhereClause: string): TBatchSQL;

    // Métodos de conveniência completos (fazem tudo em uma linha)
    class function BatchUpdate(AQuery: TUniQuery; const ATableName, ASetClause, AWhereClause: string): TBatchSQL;
    class function BatchInsert(AQuery: TUniQuery; const ATableName, AFields, AValues: string): TBatchSQL;
    class function BatchDelete(AQuery: TUniQuery; const ATableName, AWhereClause: string): TBatchSQL;

    // Extração de SQL de queries existentes
    class function ExtractSQL(ABatch: TBatchSQL; AQuery: TUniQuery): string;
    class function ExtractSQLWithParams(ABatch: TBatchSQL; AQuery: TUniQuery): string;

    // Adição de queries existentes ao batch
    class procedure AddQueryToBatch(ABatch: TBatchSQL; AQuery: TUniQuery);
    class procedure AddMultipleQueries(ABatch: TBatchSQL; AQueries: TArray<TUniQuery>);

    // Req. 456948 - intercepta o Post de dataset em modo insercao
    class function  fFloatParaSQL(const AValor: Double): String;
    class procedure PostOuAcumula(ADataSet: TUniQuery; const AstrTabela: String;
                                  ABatch: TBatchSQL);

    // Métodos rápidos para criar batch a partir de queries existentes
    class function CreateBatchFromQuery(AQuery: TUniQuery): TBatchSQL; overload;
    class function CreateBatchFromQuery(AQuery: TUniQuery; AExecuteImmediately: Boolean): TBatchSQL; overload;
    class function CreateBatchFromQueries(AQueries: TArray<TUniQuery>): TBatchSQL;

    // Métodos para debug e log
    class function GetQueryDebugInfo(ABatch: TBatchSQL; AQuery: TUniQuery): string;
    class procedure LogQueryToBatch(ABatch: TBatchSQL; AQuery: TUniQuery; const ADescription: string = '');
  end;

implementation

{ TBatchHelper }

{***************************************************************}
{* Req. 456948 - formata Double para SQL com ponto decimal.     *}
{*                                                              *}
{* Mesma mascara de fDoubleToSQL: FormatFloat('0.########').    *}
{* Replicada aqui em vez de importar untFuncoesGenerica, que e  *}
{* enorme e traria dependencia transitiva para esta unit.       *}
{***************************************************************}
class function TBatchHelper.fFloatParaSQL(const AValor: Double): String;
  Var
    recFormato: TFormatSettings;
begin
  recFormato := TFormatSettings.Create;
  recFormato.DecimalSeparator  := '.';
  recFormato.ThousandSeparator := #0;

  Result := FormatFloat('0.########', AValor, recFormato);
end;

{***************************************************************}
{* Req. 456948 - com ABatch = Nil faz Post normal, exatamente o *}
{* comportamento de hoje. Com ABatch atribuido, monta o INSERT  *}
{* a partir dos campos do dataset, acumula no lote e cancela a  *}
{* insercao.                                                    *}
{*                                                              *}
{* Existe porque fGravaMovDet escreve por dataset (Insert /     *}
{* FieldByName / Post), e nao por ExecSQL - entao               *}
{* AddQueryAsCommand nao alcanca.                               *}
{***************************************************************}
class procedure TBatchHelper.PostOuAcumula(ADataSet: TUniQuery;
  const AstrTabela: String; ABatch: TBatchSQL);
  Var
    intIdx: Integer;
    strCampos: String;
    strValores: String;
    objCampo: TField;
begin
  If Not Assigned(ABatch) Then
  Begin
    ADataSet.Post;
    Exit;
  End;

  strCampos  := '';
  strValores := '';

  For intIdx := 0 To ADataSet.FieldCount - 1 Do
  Begin
    objCampo := ADataSet.Fields[intIdx];

    If objCampo.ReadOnly Then
      Continue;

    {Req. 456948 - campo NULL e OMITIDO do INSERT, nao emitido como NULL.
     O Post do UniDAC inclui so os campos MODIFICADOS; coluna nao tocada fica
     de fora e o MySQL aplica o DEFAULT da tabela. Emitir NULL sobrescreveria
     esse default - medido: 11 colunas do MOVDET vinham 0.00 ou "N" e passaram
     a vir NULL em 280 linhas.

     EXCECAO - blob e memo: o Delphi mantem IsNull = True mesmo depois de
     atribuir string vazia, mas o UniDAC grava o campo porque foi MODIFICADO.
     Medido no DET_DESNES (text): a BASE gravava '' e omitir passou a gravar
     NULL em 280 linhas. Por isso blob nunca e omitido.}
    If objCampo.IsNull And
       (Not (objCampo.DataType In [ftMemo, ftFmtMemo, ftWideMemo, ftBlob, ftGraphic])) Then
      Continue;

    If strCampos <> '' Then
    Begin
      strCampos  := strCampos  + ', ';
      strValores := strValores + ', ';
    End;

    strCampos := strCampos + objCampo.FieldName;

  {Campo modificado e IsNull (o Continue acima so pulou o intocado) tem que
     ir como NULL literal, nao como valor default do tipo (ex.: '' de string).}
    If objCampo.IsNull And
       (Not (objCampo.DataType In [ftMemo, ftFmtMemo, ftWideMemo, ftBlob, ftGraphic])) Then
      strValores := strValores + 'NULL'
    Else
    Case objCampo.DataType Of
        ftSmallint, ftInteger, ftWord, ftLargeint, ftAutoInc:
          strValores := strValores + IntToStr(objCampo.AsLargeInt);

        ftFloat, ftCurrency, ftBCD, ftFMTBcd, ftSingle, ftExtended:
          strValores := strValores + fFloatParaSQL(objCampo.AsFloat);

        ftDate:
          strValores := strValores + QuotedStr(FormatDateTime('yyyy-mm-dd', objCampo.AsDateTime));

        ftTime:
          strValores := strValores + QuotedStr(FormatDateTime('hh:nn:ss', objCampo.AsDateTime));

        ftDateTime, ftTimeStamp:
          strValores := strValores + QuotedStr(FormatDateTime('yyyy-mm-dd hh:nn:ss', objCampo.AsDateTime));

        ftBoolean:
          If objCampo.AsBoolean Then
            strValores := strValores + '1'
          Else
            strValores := strValores + '0';
    Else
      strValores := strValores + QuotedStr(objCampo.AsString);
    End;
  End;

  {Nenhum campo preenchido: nao ha INSERT a montar. Volta ao Post normal em
   vez de gerar comando invalido.}
  If strCampos = '' Then
  Begin
    ADataSet.Post;
    Exit;
  End;

  ABatch.BeginInsert(AstrTabela)
        .Fields(strCampos)
        .Values(strValores)
        .EndInsert;

  ADataSet.Cancel;
end;

{AOwnsQuery = False por default, preserva quem ja libera o proprio query.
 True delega a posse - Destroy passa a liberar o query junto.}
class function TBatchHelper.CreateBatchSQL(AQuery: TUniQuery = nil;
  AOwnsQuery: Boolean = False): TBatchSQL;
begin
  Result := TBatchSQL.Create(nil);
  if Assigned(AQuery) then
  Begin
    Result.Query     := AQuery;
    Result.OwnsQuery := AOwnsQuery;
  End;
end;

class function TBatchHelper.QuickUpdate(ABatch: TBatchSQL; const ATableName: string): TBatchSQL;
begin
  Result := ABatch.BeginUpdate(ATableName);
end;

class function TBatchHelper.QuickInsert(ABatch: TBatchSQL; const ATableName: string): TBatchSQL;
begin
  Result := ABatch.BeginInsert(ATableName);
end;

class function TBatchHelper.QuickDelete(ABatch: TBatchSQL; const ATableName: string): TBatchSQL;
begin
  Result := ABatch.BeginDelete(ATableName);
end;

class procedure TBatchHelper.AddStringParam(ABatch: TBatchSQL; const AName, AValue: string);
begin
  ABatch.AddParam(AName, AValue, ftString);
end;

class procedure TBatchHelper.AddIntegerParam(ABatch: TBatchSQL; const AName: string; AValue: Integer);
begin
  ABatch.AddParam(AName, AValue, ftInteger);
end;

class procedure TBatchHelper.AddFloatParam(ABatch: TBatchSQL; const AName: string; AValue: Double);
begin
  ABatch.AddParam(AName, AValue, ftFloat);
end;

class procedure TBatchHelper.AddDateTimeParam(ABatch: TBatchSQL; const AName: string; AValue: TDateTime);
begin
  ABatch.AddParam(AName, AValue, ftDateTime);
end;

class procedure TBatchHelper.AddBooleanParam(ABatch: TBatchSQL; const AName: string; AValue: Boolean);
begin
  ABatch.AddParam(AName, AValue, ftBoolean);
end;

class procedure TBatchHelper.AddNullParam(ABatch: TBatchSQL; const AName: string);
begin
  ABatch.AddParam(AName, Null, ftUnknown);
end;

class function TBatchHelper.FinishUpdate(ABatch: TBatchSQL; const ASetClause, AWhereClause: string): TBatchSQL;
begin
  Result := ABatch
    .SetClause(ASetClause)
    .WhereClause(AWhereClause)
    .EndUpdate;
end;

class function TBatchHelper.FinishInsert(ABatch: TBatchSQL; const AFields, AValues: string): TBatchSQL;
begin
  Result := ABatch
    .Fields(AFields)
    .Values(AValues)
    .EndInsert;
end;

class function TBatchHelper.FinishDelete(ABatch: TBatchSQL; const AWhereClause: string): TBatchSQL;
begin
  Result := ABatch
    .WhereClause(AWhereClause)
    .EndDelete;
end;

class function TBatchHelper.BatchUpdate(AQuery: TUniQuery; const ATableName, ASetClause, AWhereClause: string): TBatchSQL;
begin
  Result := TBatchSQL.Create(nil);
  Result.Query := AQuery;
  Result.BeginUpdate(ATableName)
        .SetClause(ASetClause)
        .WhereClause(AWhereClause)
        .EndUpdate;
end;

class function TBatchHelper.BatchInsert(AQuery: TUniQuery; const ATableName, AFields, AValues: string): TBatchSQL;
begin
  Result := TBatchSQL.Create(nil);
  Result.Query := AQuery;
  Result.BeginInsert(ATableName)
        .Fields(AFields)
        .Values(AValues)
        .EndInsert;
end;

class function TBatchHelper.BatchDelete(AQuery: TUniQuery; const ATableName, AWhereClause: string): TBatchSQL;
begin
  Result := TBatchSQL.Create(nil);
  Result.Query := AQuery;
  Result.BeginDelete(ATableName)
        .WhereClause(AWhereClause)
        .EndDelete;
end;

class function TBatchHelper.ExtractSQL(ABatch: TBatchSQL; AQuery: TUniQuery): string;
begin
  Result := ABatch.ExtractExecutableSQL(AQuery);
end;

class function TBatchHelper.ExtractSQLWithParams(ABatch: TBatchSQL; AQuery: TUniQuery): string;
begin
  Result := ABatch.ExtractSQLWithParams(AQuery);
end;

class procedure TBatchHelper.AddQueryToBatch(ABatch: TBatchSQL; AQuery: TUniQuery);
begin
  ABatch.AddQueryAsCommand(AQuery);
end;

class procedure TBatchHelper.AddMultipleQueries(ABatch: TBatchSQL; AQueries: TArray<TUniQuery>);
var
  LQuery: TUniQuery;
begin
  for LQuery in AQueries do
    ABatch.AddQueryAsCommand(LQuery);
end;

class function TBatchHelper.CreateBatchFromQuery(AQuery: TUniQuery): TBatchSQL;
begin
  Result := CreateBatchSQL(AQuery);
  Result.AddQueryAsCommand(AQuery);
end;

class function TBatchHelper.CreateBatchFromQuery(AQuery: TUniQuery; AExecuteImmediately: Boolean): TBatchSQL;
begin
  Result := CreateBatchFromQuery(AQuery);
  if AExecuteImmediately then
    Result.Execute;
end;

class function TBatchHelper.CreateBatchFromQueries(AQueries: TArray<TUniQuery>): TBatchSQL;
var
  LQuery: TUniQuery;
begin
  if Length(AQueries) = 0 then
    Exit(nil);

  Result := CreateBatchSQL(AQueries[0]);
  for LQuery in AQueries do
    Result.AddQueryAsCommand(LQuery);
end;

class function TBatchHelper.GetQueryDebugInfo(ABatch: TBatchSQL; AQuery: TUniQuery): string;
begin
  Result := '=== DEBUG QUERY ===' + sLineBreak +
            ExtractSQLWithParams(ABatch, AQuery) + sLineBreak +
            '===================';
end;

class procedure TBatchHelper.LogQueryToBatch(ABatch: TBatchSQL; AQuery: TUniQuery; const ADescription: string = '');
var
  LDebugSQL: string;
begin
  LDebugSQL := '/* ';
  if ADescription <> '' then
    LDebugSQL := LDebugSQL + ADescription + ' - ';
  LDebugSQL := LDebugSQL + 'Query Debug */ ' + ExtractSQL(ABatch, AQuery);

  ABatch.BeginCommand(LDebugSQL).EndCommand;
end;

end.
