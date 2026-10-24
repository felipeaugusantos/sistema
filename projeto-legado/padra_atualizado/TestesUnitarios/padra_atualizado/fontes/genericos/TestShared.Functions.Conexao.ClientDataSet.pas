unit TestShared.Functions.Conexao.ClientDataSet;

interface

uses Data.DB, Uni, System.Classes, System.SysUtils, Shared.Functions.DataSet,
  Faturamento.Interfaces.Conexao, UniClientDataSet, System.Contnrs,
  System.Variants;

type
  TUniDacField = Class(TInterfacedObject, IMyField)
  strict private
    FField: TField;
    function GetAsString: String;
    procedure SetAsString(const AValue: String);
    function GetAsFloat: Double;
    procedure SetAsFloat(const AValue: Double);
    function GetAsInteger: Integer;
    procedure SetAsInteger(const AValue: Integer);
    function GetAsDate: TDate;
    procedure SetAsDate(const AValue: TDate);
    function GetAsValue: Variant;
    procedure SetAsValue(const AValue: Variant);
    function getAsAnsiString: AnsiString;
    procedure setAsAnsiString(const AValue: AnsiString);
  public
    property AsString: String read GetAsString write SetAsString;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsDate: TDate read GetAsDate write SetAsDate;
    property Value: Variant read GetAsValue write SetAsValue;
    property AsAnsiString: AnsiString read getAsAnsiString write setAsAnsiString;
    constructor Create(const AField: TField);
  end;

type
  TUniDacParam = Class(TInterfacedObject, IMyParam)
  strict private
    FParam: String;
    function getAsBoolean: Boolean;
    procedure setAsBoolean(const AValue: Boolean);
    function getAsInteger: Integer;
    procedure setAsInteger(const AValue: Integer);
    function getAsString: String;
    procedure setAsString(const AValue: String);
    function getAsDate: TDate;
    procedure setAsDate(const AValue: TDate);
    function getAsFloat: Double;
    procedure setAsFloat(const AValue: Double);
    function getAsDateTime: TDateTime;
    procedure setAsDateTime(const AValue: TDateTime);
    function getValue: Variant;
    procedure setValue(const AValue: Variant);
    function getAsAnsiString: AnsiString;
    procedure setAsAnsiString(const AValue: AnsiString);
  public
    property AsBoolean: Boolean read getAsBoolean write setAsBoolean;
    property AsInteger: Integer read getAsInteger write setAsInteger;
    property AsString: String read getAsString write setAsString;
    property AsDate: TDate read getAsDate write setAsDate;
    property AsFloat: Double read getAsFloat write setAsFloat;
    property Value: Variant read getValue write setValue;
    property AsAnsiString: AnsiString read getAsAnsiString write setAsAnsiString;
    constructor Create(const AParam: String; const AQuery: TUniClientDataSet);
  End;

type
  TUniDacQuery = Class(TInterfacedObject, IMyQuery)
  strict private
//    function GetFields: TFields;
//    function getDataSet: TDataSet;
  public
    function ExecSQL: Integer;
    procedure SetConnection(AConnection: TObject);

    function GetSQL: TStrings;

    procedure SetSQL(AValue: TStrings);

    procedure Close;
    procedure Open;
    function RecordCount: Integer;
    procedure First;
    procedure Last;
    procedure Next;
    function Eof: Boolean;
    function FindField(const AFieldName: String): IMyField;
    function FieldByName(const AFieldName: String): IMyField;
    function ParamByName(const AParam: String): IMyParam;
    function FindParam(const AParam: String): IMyParam;
    function Active: Boolean;
    function IsEmpty: Boolean;
    procedure DisableControls;
    procedure EnableControls;
    procedure Append;
    procedure Post;
    property SQL: TStrings read GetSQL write SetSQL;
    function FieldExists(const AFieldName : String) : Boolean;
//    property Fields: TFields read GetFields;
//    property DataSet: TDataSet read getDataSet;
    constructor Create;
    destructor Destroy; override;
  End;

type
  TConnectionUniDac = Class(TInterfacedObject, IMyConnection)
  public
    function CreateQuery: IMyQuery;
    function GetConObj: TObject;
  End;

Type
  TObjectVariant = Class(TObject)
  private
    FValor: Variant;
  public
    Constructor Create(AValor: Variant);
  End;

type
  TMyCampoTabela = class(TInterfacedObject, IMyCampoTabela, IMyCampoTabelaAdd)
  private
    FChaves: TStringList;
    FValores: TObjectList;

    function BuscaChave(const AFieldName: String): Integer;
  public
    function FieldByName(const AFieldName: String): TMyCampoTabelaValue;
    function Fields(const AFieldIndex: Integer): TMyCampoTabelaValue;
    procedure Add(AName: string; AValue: Variant);
    function Count: TMyCampoTabelaValue;
    function HasField(const AFieldName: String): Boolean;

    constructor Create;
    destructor Destroy; override;
  End;


  Var
    FUQuery: TUniClientDataSet;




implementation

{ TUniDacParam }

constructor TUniDacParam.Create(const AParam: String; const AQuery: TUniClientDataSet);
begin
  FParam := AParam;
  FUQuery := AQuery;
end;

function TUniDacParam.getAsAnsiString: AnsiString;
begin
  Result := FUQuery.Params.ParamByName(FParam).AsAnsiString;
end;

function TUniDacParam.getAsBoolean: Boolean;
begin
  Result := FUQuery.Params.ParamByName(FParam).AsBoolean;
end;

function TUniDacParam.getAsDate: TDate;
begin
  Result := FUQuery.Params.ParamByName(FParam).AsDate;
end;

function TUniDacParam.getAsDateTime: TDateTime;
begin
  Result := FUQuery.Params.ParamByName(FParam).AsDateTime;
end;

function TUniDacParam.getAsFloat: Double;
begin
  Result := FUQuery.Params.ParamByName(FParam).AsFloat;
end;

function TUniDacParam.getAsInteger: Integer;
begin
  Result := FUQuery.Params.ParamByName(FParam).AsInteger;
end;

function TUniDacParam.getAsString: String;
begin
  Result := FUQuery.Params.ParamByName(FParam).AsString;
end;

function TUniDacParam.getValue: Variant;
begin
  Result := FUQuery.Params.ParamByName(FParam).Value;
end;

procedure TUniDacParam.setAsAnsiString(const AValue: AnsiString);
begin
  FUQuery.Params.ParamByName(FParam).AsAnsiString := AValue;
end;

procedure TUniDacParam.setAsBoolean(const AValue: Boolean);
begin
  FUQuery.Params.ParamByName(FParam).AsBoolean := AValue;
end;

procedure TUniDacParam.setAsDate(const AValue: TDate);
begin
  FUQuery.Params.ParamByName(FParam).AsDate := AValue;
end;

procedure TUniDacParam.setAsDateTime(const AValue: TDateTime);
begin
  FUQuery.Params.ParamByName(FParam).AsDateTime := AValue;
end;

procedure TUniDacParam.setAsFloat(const AValue: Double);
begin
  FUQuery.Params.ParamByName(FParam).AsFloat := AValue;
end;

procedure TUniDacParam.setAsInteger(const AValue: Integer);
begin
  FUQuery.Params.ParamByName(FParam).AsInteger := AValue;
end;

procedure TUniDacParam.setAsString(const AValue: String);
begin
  FUQuery.Params.ParamByName(FParam).AsString := AValue;
end;

procedure TUniDacParam.setValue(const AValue: Variant);
begin
  FUQuery.Params.ParamByName(FParam).Value := AValue;
end;

{ TUniDacQuery }

function TUniDacQuery.Active: Boolean;
begin
  Result := FUQuery.Active;
end;

procedure TUniDacQuery.Append;
begin
  FUQuery.Append;
end;

procedure TUniDacQuery.Close;
begin
  FUQuery.Close;
end;

constructor TUniDacQuery.Create;
begin
//   FUQuery := TUniClientDataSet.Create(Nil);
//   FUQuery := AClientDataSet;
end;

destructor TUniDacQuery.Destroy;
begin
  FUQuery.Close;
//  FreeAndNil(FUQuery);
  inherited;
end;

procedure TUniDacQuery.DisableControls;
begin
  FUQuery.DisableControls;
end;

procedure TUniDacQuery.EnableControls;
begin
  FUQuery.EnableControls;
end;

function TUniDacQuery.Eof: Boolean;
begin
  Result := FUQuery.Eof;
end;

function TUniDacQuery.ExecSQL: Integer;
begin
  //FUQuery.ExecSQL;
  Result := 0;
end;

function TUniDacQuery.FieldByName(const AFieldName: String): IMyField;
begin
  Result := TUniDacField.Create(FUQuery.FieldByName(AFieldName));
end;

function TUniDacQuery.FieldExists(const AFieldName: String): Boolean;
begin
  Result := Assigned(FUQuery.FindField(AFieldName));
end;

function TUniDacQuery.FindField(const AFieldName: String): IMyField;
begin
  Result := FUQuery.FindField(AFieldName) as IMyField;
end;

function TUniDacQuery.FindParam(const AParam: String): IMyParam;
begin
  Result := Nil;
  If Assigned(FUQuery.Params.FindParam(AParam)) Then
    Result := TUniDacParam.Create(AParam, FUQuery);
end;

procedure TUniDacQuery.First;
begin
  FUQuery.First;
end;

procedure TUniDacQuery.Last;
begin
  FUQuery.Last;
end;


//function TUniDacQuery.getDataSet: TDataSet;
//begin
//  Result := FUQuery;
//end;

//function TUniDacQuery.GetFields: TFields;
//begin
//  Result := FUQuery.Fields;
//end;


function TUniDacQuery.IsEmpty: Boolean;
begin
  Result := FUQuery.IsEmpty;
end;

procedure TUniDacQuery.Next;
begin
  FUQuery.Next;
end;

procedure TUniDacQuery.Open;
begin

end;

function TUniDacQuery.ParamByName(const AParam: String): IMyParam;
begin
  Result := TUniDacParam.Create(AParam, FUQuery);
end;

procedure TUniDacQuery.Post;
begin
  FUQuery.Post;
end;

function TUniDacQuery.RecordCount: Integer;
begin
  Result := FUQuery.RecordCount;
end;

procedure TUniDacQuery.SetConnection(AConnection: TObject);
begin
  // FUQuery.Connection := TUniConnection(AConnection);
end;

function TUniDacQuery.GetSQL: TStrings;
Var
  stl : TStrings;
begin
  stl := TStringList.Create;
  stl.Add('');

  Result := stl;
end;

procedure TUniDacQuery.SetSQL(AValue: TStrings);
begin
  FUQuery.CommandText := '';
end;

{ TConnectionUniDac }

function TConnectionUniDac.CreateQuery: IMyQuery;
begin
  Result := TUniDacQuery.Create;
end;

function TConnectionUniDac.GetConObj: TObject;
begin
  Result := objConexao.Conexao;
end;

{ TUniDacField }

constructor TUniDacField.Create(const AField: TField);
begin
  inherited Create();
  Self.FField := AField;
end;

function TUniDacField.getAsAnsiString: AnsiString;
begin
  Result := FField.AsAnsiString;
end;

function TUniDacField.GetAsDate: TDate;
begin
  Result := FField.AsDateTime;
end;

function TUniDacField.GetAsFloat: Double;
begin
  Result := FField.AsFloat;
end;

function TUniDacField.GetAsInteger: Integer;
begin
  Result := FField.AsInteger;
end;

function TUniDacField.GetAsString: String;
begin
  Result := FField.AsString;
end;

function TUniDacField.GetAsValue: Variant;
begin
  Result := FField.AsVariant;
end;

procedure TUniDacField.setAsAnsiString(const AValue: AnsiString);
begin
  FField.AsAnsiString := AValue;
end;

procedure TUniDacField.SetAsDate(const AValue: TDate);
begin
  FField.AsDateTime := AValue;
end;

procedure TUniDacField.SetAsFloat(const AValue: Double);
begin
  FField.AsFloat := AValue;
end;

procedure TUniDacField.SetAsInteger(const AValue: Integer);
begin
  FField.AsInteger := AValue;
end;

procedure TUniDacField.SetAsString(const AValue: String);
begin
  FField.AsString := AValue;
end;

procedure TUniDacField.SetAsValue(const AValue: Variant);
begin
  FField.AsVariant := AValue;
end;

{ TMyCampoTabela }

procedure TMyCampoTabela.Add(AName: string; AValue: Variant);
begin
  FChaves.Add(AName);
  FValores.Add(TObjectVariant.Create(AValue));
end;

function TMyCampoTabela.BuscaChave(const AFieldName: String): Integer;
  Var
    intContador: Integer;
begin
  Result := -1;

  For intContador := 0 To FChaves.Count -1 Do
  Begin
    If (FChaves[intContador] = AFieldName) Then
    Begin
      Result := intContador;
      Break;
    End;
  End;
end;

function TMyCampoTabela.Count: TMyCampoTabelaValue;
begin
  Result := FChaves.Count;
end;

constructor TMyCampoTabela.Create;
begin
  inherited Create;

  FChaves  := TStringList.Create;
  FValores := TObjectList.Create(False);
end;

destructor TMyCampoTabela.Destroy;
  Var
    intCont: Integer;
    obj: TObject;
begin
  For intCont := 0 To FValores.Count -1 Do
  Begin
    If Assigned(FValores[intCont]) And
      (FValores[intCont] Is TObjectVariant) Then
    Begin
      obj := FValores[intCont];
      FreeAndNil(obj);
    End;
  End;

  FChaves.Clear;
  FValores.Clear;
  FreeAndNil(FChaves);
  FreeAndNil(FValores);

  inherited;
end;

function TMyCampoTabela.FieldByName(const AFieldName: String): TMyCampoTabelaValue;
  Var
    intPos: Integer;
begin
  Result := Null;
  intPos := BuscaChave(AFieldName);

  If intPos > -1 Then
    Result := TObjectVariant(FValores[intPos]).FValor;
end;

function TMyCampoTabela.Fields(const AFieldIndex: Integer): TMyCampoTabelaValue;
begin
  Result := TObjectVariant(FValores[AFieldIndex]).FValor;
end;

function TMyCampoTabela.HasField(const AFieldName: String): Boolean;
begin
  Result := BuscaChave(AFieldName) <> -1;
end;

{ TObjectVariant }

constructor TObjectVariant.Create(AValor: Variant);
begin
  FValor := AValor;
end;

initialization

SetObjDataSet(TConnectionUniDac.Create);

end.
