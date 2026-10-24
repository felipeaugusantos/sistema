unit untDicionarioResultadoQuerySimples;

interface

uses Core.Funcoes, Uni, System.SysUtils, System.Contnrs, Data.DB,
  System.StrUtils, System.Generics.Collections, Variants;

Type
  TCampoTabela = Record
    Nome: String;
    Valor: Variant;
  End;

  TMatrizCamposTabela = Array Of TCampoTabela;

  TObjMatrizCamposTabela = class
  public
    arrMatrizCamposTabela: TMatrizCamposTabela;
  end;

  TObjCampoTabela = class
  public
    Field: TCampoTabela;
  end;

  TDicResultadoQuerySimples = class
  private
    FDicValues: TDictionary<string,variant>;
    FDicObjects: TDictionary<string,TObject>;
    class var Finstance: TDicResultadoQuerySimples;
    class var FMREW: TMultiReadExclusiveWriteSynchronizer;
    constructor Create;
  public
    Destructor Destroy; override;
    class function fGetInstance(): TDicResultadoQuerySimples;
    class procedure Limpar;
    class function fExecQuery(qryExec: TUniQuery): Variant;
    class function fExecQueryCampos(qryExec: TUniQuery): TMatrizCamposTabela;
    function fGetDicValues: TDictionary<string,variant>;
    function fGetDicObjects: TDictionary<string,TObject>;
    procedure SetObject(Index: TUniQuery; const AValue: TObjCampoTabela);
    function GetKey(qry: TUniQuery): String;
    procedure SetValue(Index: TUniQuery; const Value: Variant);
    function GetValue(Index: TUniQuery): Variant;
  end;

implementation

{ TDicResultadoQuerySimples }

constructor TDicResultadoQuerySimples.Create;
begin
  FDicValues := TDictionary<string,variant>.Create;
  FDicObjects := TDictionary<string,TObject>.Create;
end;

destructor TDicResultadoQuerySimples.Destroy;
begin
  FreeAndNil(FDicValues);
  FreeAndNil(FDicObjects);
  inherited;
end;

class function TDicResultadoQuerySimples.fExecQuery(qryExec: TUniQuery): Variant;
Var
  objDic: TDicResultadoQuerySimples;
  LKey: string;
begin
  FMREW.BeginWrite;
  Try
    objDic := fGetInstance();
    LKey := objDic.GetKey(qryExec);

    If objDic.FDicValues.ContainsKey(LKey) Then
    Begin
      Result := objDic.FDicValues[LKey];
    End
    Else
    Begin
      With qryExec Do
      Begin
        Open;
        Result := Fields[0].Value;

        Case Fields[0].DataType Of
          ftString : Result := Fields[0].AsString;
          ftMemo   : Result := Fields[0].AsString;
          ftFloat  : Result := Fields[0].AsFloat;
          ftInteger: Result := Fields[0].AsInteger;
          ftBoolean: Result := Fields[0].AsBoolean;
          ftDate   : Result := Fields[0].AsDateTime;
          ftTime   : Result := Fields[0].AsDateTime;
        End;

        objDic.SetValue(qryExec, Result);
        Close;
      End;
    End;
  Finally
    FMREW.EndWrite;
  End;
end;

class function TDicResultadoQuerySimples.fExecQueryCampos(qryExec: TUniQuery): TMatrizCamposTabela;
Var
  intField: Integer;
  varValue: Variant;
  LKey: string;
  objDic: TDicResultadoQuerySimples;
  objCampos: TObjMatrizCamposTabela;
begin
  FMREW.BeginWrite;
  Try
    objDic := fGetInstance();

    LKey := objDic.GetKey(qryExec);

    If objDic.FDicObjects.ContainsKey(LKey) Then
      Exit(TObjMatrizCamposTabela(objDic.FDicObjects[LKey]).arrMatrizCamposTabela);

    qryExec.Open;

    objCampos := TObjMatrizCamposTabela.Create;

    SetLength(objCampos.arrMatrizCamposTabela, qryExec.FieldCount);

    For intField := 0 To qryExec.Fields.Count -1 Do
    Begin
      varValue := qryExec.Fields[intField].Value;

      Case qryExec.Fields[intField].DataType Of
        ftString : varValue := qryExec.Fields[intField].AsString;
        ftMemo   : varValue := qryExec.Fields[intField].AsString;
        ftFloat  : varValue := qryExec.Fields[intField].AsFloat;
        ftInteger: varValue := qryExec.Fields[intField].AsInteger;
        ftBoolean: varValue := qryExec.Fields[intField].AsBoolean;
        ftDate   : varValue := qryExec.Fields[intField].AsDateTime;
        ftTime   : varValue := qryExec.Fields[intField].AsDateTime;
      End;

      objCampos.arrMatrizCamposTabela[intField].Nome  := qryExec.Fields[intField].FieldName;
      objCampos.arrMatrizCamposTabela[intField].Valor := varValue;
    End;

    objDic.FDicObjects.AddOrSetValue(objDic.GetKey(qryExec), objCampos);

    Result := objCampos.arrMatrizCamposTabela;

    qryExec.Close;
  Finally
    FMREW.EndWrite;
  End;
end;

class function TDicResultadoQuerySimples.fGetInstance: TDicResultadoQuerySimples;
begin
  if Not Assigned(Finstance) Then
    Finstance := TDicResultadoQuerySimples.Create();

  Result := Finstance;
end;

function TDicResultadoQuerySimples.fGetDicValues: TDictionary<string,variant>;
begin
  Result := FDicValues;
end;

function TDicResultadoQuerySimples.fGetDicObjects: TDictionary<string,TObject>;
begin
  Result := FDicObjects;
end;

function TDicResultadoQuerySimples.GetKey(qry: TUniQuery): String;
  Var
    i: Integer;
begin
  Result := qry.SQL.Text;

  For i := 0 To qry.ParamCount -1 Do
    Result := AnsiReplaceStr(Result, ':' + qry.Params[i].Name, qry.Params[i].AsString);

  Result := TCoreFuncoes.GetMD5(Result);
end;

function TDicResultadoQuerySimples.GetValue(Index: TUniQuery): Variant;
begin
  FMREW.BeginRead;
  try
    if FDicValues.ContainsKey(GetKey(Index)) then
      Result := FDicValues[GetKey(Index)]
    else
      Result := Null;
  finally
    FMREW.EndRead;
  end;
end;

class procedure TDicResultadoQuerySimples.Limpar;
var
  LObject: TObject;
begin
  FMREW.BeginWrite;
  try
    for LObject in fGetInstance().FDicObjects.Values do
      if Assigned(LObject) then
        LObject.Free;
    fGetInstance().FDicObjects.Clear;
    fGetInstance().FDicValues.Clear;
  finally
    FMREW.EndWrite;
  end;
end;

procedure TDicResultadoQuerySimples.SetValue(Index: TUniQuery; const Value: Variant);
begin
  FMREW.BeginWrite;
  try
    FDicValues.AddOrSetValue(GetKey(Index), Value);
  finally
    FMREW.EndWrite;
  end;
end;

procedure TDicResultadoQuerySimples.SetObject(Index: TUniQuery; const AValue: TObjCampoTabela);
begin
  FMREW.BeginWrite;
  try
    FDicObjects.AddOrSetValue(GetKey(Index), AValue);
  finally
    FMREW.EndWrite;
  end;
end;

initialization

  TDicResultadoQuerySimples.FMREW := TMultiReadExclusiveWriteSynchronizer.Create;

Finalization
  TDicResultadoQuerySimples.Limpar;
  FreeAndNil(TDicResultadoQuerySimples.Finstance);
  FreeAndNil(TDicResultadoQuerySimples.FMREW);

end.
