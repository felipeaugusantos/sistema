unit AgrupamentoDeOndaDeSeparacao.Classes.InsertsInBatch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Uni,
  UniClientDataSet, Data.DB, System.StrUtils, untFuncoesSimples;

type

  {Exemplo insert em batch: INSERT INTO tbl_name (a,b,c) VALUES (1,2,3), (4,5,6), (7,8,9)}

  TInsertsInBatch = class
  private
    FCommand : TUniQuery;
    FRows    : TArray<String>;
    FFields  : TArray<String>;
    function GetValue(AField: TField): String;
    function HeadInsertInto: String; virtual; abstract;
    procedure AddCommand;
  public
    procedure ParseFields(ADataSet: TDataSet); virtual; abstract;
    procedure AddValue(AValue: String);
    function ExecSQL: Boolean;
    constructor New;
    destructor Destroy; override;
  end;

  TInsertsInBatchLOTDOR = class(TInsertsInBatch)
  public
    function HeadInsertInto: String; override;
    procedure ParseFields(ADataSet: TDataSet); override;
  end;

  TInsertsInBatchONDSEP = class(TInsertsInBatch)
  public
    function HeadInsertInto: String; override;
    procedure ParseFields(ADataSet: TDataSet); override;
  end;

implementation

{ TInsertsInBatch }

procedure TInsertsInBatch.AddCommand;
  Var
    LCommand: String;
begin
  LCommand := String.Join(',', FFields);

  SetLength(FRows, Length(FRows) +1);
  FRows[High(FRows)] := '('+ LCommand +')';

  SetLength(FFields, 0);
end;

procedure TInsertsInBatch.AddValue(AValue: String);
begin
  SetLength(FFields, Length(FFields) +1);
  FFields[High(FFields)] := AValue;
end;

destructor TInsertsInBatch.Destroy;
begin
  FreeAndNil(FCommand);
  inherited;
end;

function TInsertsInBatch.ExecSQL: Boolean;
  var
    LCommand: String;
begin
  try
    LCommand := String.Join(',', FRows);

    FCommand.SQL.Add(LCommand);
    FCommand.ExecSQL;

    Result := True;
  except
    Raise;
  end;
end;

function TInsertsInBatch.GetValue(AField: TField): String;
  Const
    STR_NULL = 'NULL';
begin
  if AField.IsNull then
    Exit(STR_NULL);

  case AField.DataType of
    ftDate:
    begin
      if (FormatDateTime('YYYY-MM-DD', AField.Value) = '1899-12-30') or
         (FormatDateTime('YYYY-MM-DD', AField.Value) = '0000-00-00') then
        Result := STR_NULL
      else
        Result := QuotedStr(FormatDateTime('YYYY-MM-DD', AField.Value));
    end;

    ftTime:
    begin
      if (FormatDateTime('hh:nn:ss', AField.Value) = '00:00:00') then
        Result := STR_NULL
      else
        Result := QuotedStr(FormatDateTime('hh:nn:ss', AField.Value));
    end;

    ftDateTime:
    begin
      if (FormatDateTime('YYYY-MM-DD hh:nn:ss', AField.Value) = '1899-12-30 00:00:00') or
         (FormatDateTime('YYYY-MM-DD hh:nn:ss', AField.Value) = '0000-00-00 00:00:00') then
        Result := STR_NULL
      else
        Result := QuotedStr(FormatDateTime('YYYY-MM-DD hh:nn:ss', AField.Value));
    end;

    ftFloat,
    ftCurrency: Result := ReplaceStr(AField.Value, ',', '.');

    ftInteger,
    ftSmallInt,
    ftLargeInt: Result := AField.Value;
  else
    Result := IIF(fEmptyStr(AField.Value), STR_NULL, QuotedStr(AField.Value));
  end;
end;

constructor TInsertsInBatch.New;
begin
  SetLength(FRows, 0);
  SetLength(FFields, 0);
  FCommand := fCriaQuery;
  FCommand.SQL.Add(HeadInsertInto);
end;

{ TInsertsInBatchLOTDOR }

function TInsertsInBatchLOTDOR.HeadInsertInto: String;
begin
  inherited;
  Result := 'INSERT INTO LOTDOR( ';
  Result := Result + 'AUTOINCREM, ';
  Result := Result + 'LDO_SEQFDO, ';
  Result := Result + 'LDO_NUMLOT, ';
  Result := Result + 'LDO_QTDITE, ';
  Result := Result + 'LDO_SALCAL, ';
  Result := Result + 'LDO_MOVENT, ';
  Result := Result + 'LDO_MOVSAI, ';
  Result := Result + 'LDO_CODSEP) ';
  Result := Result + ' VALUES ';
end;

procedure TInsertsInBatchLOTDOR.ParseFields(ADataSet: TDataSet);
begin
  inherited;
  AddValue(GetValue(ADataSet.FieldByName('LDO_SEQFDO')));
  AddValue(GetValue(ADataSet.FieldByName('LDO_NUMLOT')));
  AddValue(GetValue(ADataSet.FieldByName('LDO_QTDITE')));
  AddValue(GetValue(ADataSet.FieldByName('LDO_SALCAL')));
  AddValue(GetValue(ADataSet.FieldByName('LDO_MOVENT')));
  AddValue(GetValue(ADataSet.FieldByName('LDO_MOVSAI')));
  AddValue(GetValue(ADataSet.FieldByName('LDO_CODSEP')));

  AddCommand;
end;

{ TInsertsInBatchONDSEP }

function TInsertsInBatchONDSEP.HeadInsertInto: String;
begin
  inherited;
  Result := 'INSERT INTO ONDSEP( ';
  Result := Result + 'AUTOINCREM, ';
  Result := Result + 'OND_SEQOND, ';
  Result := Result + 'OND_CODITE, ';
  Result := Result + 'OND_QTDITE, ';
  Result := Result + 'OND_LOCFIS, ';
  Result := Result + 'OND_STATUS) ';
  Result := Result + ' VALUES ';
end;

procedure TInsertsInBatchONDSEP.ParseFields(ADataSet: TDataSet);
begin
  inherited;
  AddValue(GetValue(ADataSet.FieldByName('SEQOND')));
  AddValue(GetValue(ADataSet.FieldByName('CODITE')));
  AddValue(GetValue(ADataSet.FieldByName('QTDITE')));
  AddValue(GetValue(ADataSet.FieldByName('LOCFIS')));
  AddValue(GetValue(ADataSet.FieldByName('STATUS')));

  AddCommand;
end;

end.
