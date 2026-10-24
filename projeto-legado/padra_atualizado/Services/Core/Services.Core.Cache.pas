unit Services.Core.Cache;

interface

uses System.Classes, System.SysUtils, System.Generics.Collections,
  System.StrUtils, Services.Core.Connection.Interfaces,
  System.Variants, Data.DB, Services.Core.Utils;

type
  TObjectVariant = Class(TObject)
    varValor: Variant;
  public
    Constructor Create(valor: Variant);
  end;

  TDicionario = class
  private
    lstChaves: TStringList;
    lstValores: TObjectList<TObject>;
  protected
    function BuscaChave(strChave: String): Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Adicionar(strChave: String; valor: Variant);
    procedure AdicionarObjeto(strChave: String; valor: TObject);
    procedure Remove(strChave: String);
    procedure Limpar;
    procedure LimparObjetos;
    function Retorna(strChave: String): Variant;
    function RetornaObjeto(strChave: String): TObject;

    function Chaves: TStringList;

    property Items[Index: String]: Variant read Retorna
      write Adicionar; default;
  end;

type
  TDicResultadoQuerySimples = class
  private
    FResultados: TDicionario;
    class var FMREW: TMultiReadExclusiveWriteSynchronizer;
    class var FInstance: TDicResultadoQuerySimples;
    function GetKey(qry: IQuery): String;
    function GetResult(Index: IQuery): Variant;
    procedure SetResult(Index: IQuery; const Value: Variant);
    constructor Create;
  public
    Destructor Destroy; override;
    class function fGetInstance(): TDicResultadoQuerySimples;
    class procedure Limpar;
    class function fExecQuery(qryExec: IQuery): Variant;
  end;

implementation

{ TDicionario }

procedure TDicionario.Adicionar(strChave: String; valor: Variant);
Var
  intPos: Integer;
begin
  intPos := BuscaChave(strChave);

  If intPos = -1 Then
  Begin
    lstChaves.Add(strChave);
    lstValores.Add(TObjectVariant.Create(valor));
  End
  Else
    lstValores[intPos] := TObjectVariant.Create(valor);
end;

procedure TDicionario.AdicionarObjeto(strChave: String; valor: TObject);
Var
  intPos: Integer;
begin
  intPos := BuscaChave(strChave);

  If intPos = -1 Then
  Begin
    lstChaves.Add(strChave);
    lstValores.Add(valor);
  End
  Else
  Begin
    lstValores[intPos] := valor;
  End;
end;

function TDicionario.BuscaChave(strChave: String): Integer;
Var
  intContador: Integer;
begin

  Result := -1;

  For intContador := 0 To lstChaves.Count - 1 Do
  Begin
    If (lstChaves[intContador] = strChave) Then
    Begin
      Result := intContador;
      Break;
    End;
  End;
end;

constructor TDicionario.Create;
begin
  inherited Create;

  lstChaves := TStringList.Create;
  lstValores := TObjectList<TObject>.Create(False);
end;

destructor TDicionario.Destroy;
begin
  Limpar;

  FreeAndNil(lstChaves);
  FreeAndNil(lstValores);

  inherited;
end;

procedure TDicionario.Limpar;
Var
  intCont: Integer;
  obj: TObject;
begin
  For intCont := 0 To lstValores.Count - 1 Do
  Begin
    If Assigned(lstValores[intCont]) And
      (lstValores[intCont] Is TObjectVariant) Then
    Begin
      obj := lstValores[intCont];
      FreeAndNil(obj);
    End;
  End;

  lstChaves.Clear;
  lstValores.Clear;
end;

procedure TDicionario.LimparObjetos;
Var
  intObj: Integer;
begin
  For intObj := 0 To lstChaves.Count - 1 Do
  Begin
    If Assigned(RetornaObjeto(lstChaves[intObj])) Then
      TObject(RetornaObjeto(lstChaves[intObj])).Free;
    lstValores[intObj] := nil;
  End;
end;

procedure TDicionario.Remove(strChave: String);
Var
  intPos: Integer;
begin

  intPos := BuscaChave(strChave);
  If (intPos > -1) Then
  Begin
    lstChaves.Delete(intPos);
    lstValores.Delete(intPos);
  End;

end;

function TDicionario.Retorna(strChave: String): Variant;
Var
  intPos: Integer;
begin
  Result := Null;
  intPos := BuscaChave(strChave);

  If intPos > -1 Then
    Result := TObjectVariant(lstValores[intPos]).varValor;
end;

function TDicionario.RetornaObjeto(strChave: String): TObject;
Var
  intPos: Integer;
begin

  Result := Nil;
  intPos := BuscaChave(strChave);

  If intPos > -1 Then
  Begin
    Result := lstValores[intPos];
  End;
end;

function TDicionario.Chaves: TStringList;
begin
  Result := lstChaves;
end;

{ TDicResultadoQuerySimples }

constructor TDicResultadoQuerySimples.Create;
begin
  FResultados := TDicionario.Create;
end;

destructor TDicResultadoQuerySimples.Destroy;
begin
  FreeAndNil(FResultados);
  inherited;
end;

class function TDicResultadoQuerySimples.fExecQuery(qryExec: IQuery): Variant;
Var
  objDic: TDicResultadoQuerySimples;
begin
  FMREW.BeginWrite;
  try
    objDic := fGetInstance();

    If objDic.FResultados.Chaves.IndexOf(objDic.GetKey(qryExec)) > -1 Then
    Begin
      Result := objDic.GetResult(qryExec);
    End
    Else
    Begin
      With qryExec Do
      Begin
        Open;
        Result := Fields(0).Value;

        Case Fields(0).DataType Of
          ftString:
            Result := Fields(0).AsString;
          ftMemo:
            Result := Fields(0).AsString;
          ftFloat:
            Result := Fields(0).AsFloat;
          ftInteger:
            Result := Fields(0).AsInteger;
          ftBoolean:
            Result := Fields(0).AsBoolean;
          ftDate:
            Result := Fields(0).AsDateTime;
          ftTime:
            Result := Fields(0).AsDateTime;
        End;

        objDic.SetResult(qryExec, Result);
        Close;
      End;
    End;
  finally
    FMREW.EndWrite;
  end;
end;

class function TDicResultadoQuerySimples.fGetInstance
  : TDicResultadoQuerySimples;
begin
  FMREW.BeginWrite;
  try
    if Not Assigned(FInstance) Then
      FInstance := TDicResultadoQuerySimples.Create();
    Result := FInstance;
  finally
    FMREW.EndWrite;
  end;
end;

function TDicResultadoQuerySimples.GetKey(qry: IQuery): String;
Var
  i: Integer;
begin
  Result := qry.SQL.Text;
  For i := 0 To qry.ParamCount - 1 Do
    Result := AnsiReplaceStr(Result, ':' + qry.Params(i).Name,
      qry.Params(i).AsString);
  Result := GetMD5(Result);
end;

function TDicResultadoQuerySimples.GetResult(Index: IQuery): Variant;
begin
  Result := FResultados[GetKey(Index)];
end;

class procedure TDicResultadoQuerySimples.Limpar;
begin
  FMREW.BeginWrite;
  try
    fGetInstance().FResultados.Limpar;
  finally
    FMREW.EndWrite;
  end;
end;

procedure TDicResultadoQuerySimples.SetResult(Index: IQuery;
  const Value: Variant);
begin
  FResultados[GetKey(Index)] := Value;
end;

{ TObjectVariant }

constructor TObjectVariant.Create(valor: Variant);
begin
  varValor := valor;
end;

initialization

TDicResultadoQuerySimples.FMREW := TMultiReadExclusiveWriteSynchronizer.Create;

finalization

TDicResultadoQuerySimples.FMREW.Free;

end.
