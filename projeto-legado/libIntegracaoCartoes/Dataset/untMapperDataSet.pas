unit untMapperDataSet;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  cxProgressBar, Vcl.Forms,
{$ENDIF}
  Uni, Data.DB, System.Generics.Collections, untTypesSistema;

type
  TFunctionProcessValue = reference to function(Value: Variant): Variant;

  TMapperFields = class
  private
    FDictionary : TDictionary<String, String>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const Key, Value: String);
    function GetValue(const Key: String): String;
  end;

  TMapperProcessValue = class
  private
    FDictionary : TDictionary<String, TFunctionProcessValue>;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(const Key: String; const Value: TFunctionProcessValue);
    function GetValue(const Key: String): TFunctionProcessValue;
  end;

  TCopyDataSet = class
  private
    FSequence : Integer;
    FSequenceFields: TArrString;
    function ProcessValue(const Value: Variant; const Key: String; const AMapperProcessValue: TMapperProcessValue): Variant;
    function IsSequenceField(const FieldName: String): Boolean;
  public
    procedure CopyData(const AOrigem: TDataSet; const ADestino: TDataSet; const AMapperFields: TMapperFields; const AMapperProcessValue : TMapperProcessValue; const AFilter: String; AProgressBar: TcxProgressBar = Nil);
    procedure AddSequenceFields(const AFieldName: String);
    property Sequence: Integer read FSequence write FSequence;
    constructor Create;
  End;

implementation

uses SysUtils, DateUtils;

var
  FLastProcessMessages: TDateTime;

procedure TCopyDataSet.AddSequenceFields(const AFieldName: String);
begin
  SetLength(FSequenceFields, Length(FSequenceFields) + 1);
  FSequenceFields[Length(FSequenceFields)-1] := AFieldName;
end;

Procedure pDisableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll);
Begin
  With dtsDataSet Do
  Begin
    prcScroll := AfterScroll;
    AfterScroll := Nil;
    DisableControls;
  End;
End;

Procedure pEnableControls(dtsDataSet: TDataSet; Var prcScroll: TprcScroll; blnRefresh: Boolean = False);
Begin
  With dtsDataSet Do
  Begin
    EnableControls;
    AfterScroll := prcScroll;
    If blnRefresh then
      AfterScroll(dtsDataSet)
  End;
End;

procedure pProcessMessages(ANow: Boolean = False);
begin
  If ANow Or (MilliSecondsBetween(Now(), FLastProcessMessages) >= 500) Then
  Begin
    Application.ProcessMessages;
    FLastProcessMessages := Now();
  End;
end;

procedure pProgresso(intProgresso: Integer; intMaximo: Integer; pgbStatus: TcxProgressBar);
begin
  If Assigned(pgbStatus) Then
  Begin
    pgbStatus.Visible  := (intProgresso + intMaximo) > 0;
    pgbStatus.Position := intProgresso;
    pgbStatus.properties.Max := intMaximo;
    pProcessMessages;
  End;
end;

procedure TCopyDataSet.CopyData(const AOrigem: TDataSet; const ADestino: TDataSet; const AMapperFields: TMapperFields; const AMapperProcessValue : TMapperProcessValue; const AFilter: String; AProgressBar: TcxProgressBar = Nil);
  var
    LCont : Integer;
    LField : TField;
    LValue : String;
    LFilter : String;
    LFiltered : Boolean;
    LScrollOrigem: TprcScroll;
    LScrollDestino: TprcScroll;
begin
  pDisableControls(AOrigem, LScrollOrigem);
  pDisableControls(ADestino, LScrollDestino);
  LFilter := AOrigem.Filter;
  LFiltered := AOrigem.Filtered;
  Try
    AOrigem.Filtered := False;
    AOrigem.Filter := AFilter;
    AOrigem.Filtered := True;
    AOrigem.First;
    While Not AOrigem.Eof Do
    Begin
      pProgresso(AOrigem.RecNo, AOrigem.RecordCount, AProgressBar);
      ADestino.Append;
      Inc(FSequence);
      For LCont := 0 To Pred(AOrigem.Fields.Count) Do
      Begin
        LValue := AMapperFields.GetValue(AOrigem.Fields[LCont].FieldName);
        If (LValue.IsEmpty) Then
          Continue;
        LField := ADestino.FindField(LValue);
        If (LField = Nil) Then
          Continue;
        If (IsSequenceField(AOrigem.Fields[LCont].FieldName)) Then
          LField.Value := FSequence
        Else
          LField.Value := ProcessValue(AOrigem.Fields[LCont].Value, AOrigem.Fields[LCont].FieldName, AMapperProcessValue);
      End;
      ADestino.Post;
      AOrigem.Next;
    End;
  Finally
    AOrigem.Filtered := LFiltered;
    AOrigem.Filter := LFilter;
    pEnableControls(AOrigem, LScrollOrigem);
    pEnableControls(ADestino, LScrollDestino);
  End;
end;

{ TMapper }

procedure TMapperFields.Add(const Key, Value: String);
begin
  FDictionary.Add(Key, Value);
end;

constructor TMapperFields.Create;
begin
  FDictionary := TDictionary<String, String>.Create;
end;

destructor TMapperFields.Destroy;
begin
  FreeAndNil(FDictionary);
  inherited;
end;

function TMapperFields.GetValue(const Key: String): String;
begin
  Result := '';

  If Not FDictionary.ContainsKey(Key) Then
    Exit;

  Result := FDictionary.Items[Key];
end;

{ TMapperProcessValue }

procedure TMapperProcessValue.Add(const Key: String;
  const Value: TFunctionProcessValue);
begin
  FDictionary.Add(Key, Value);
end;

constructor TMapperProcessValue.Create;
begin
  FDictionary := TDictionary<String, TFunctionProcessValue>.Create;
end;

destructor TMapperProcessValue.Destroy;
begin
  FreeAndNil(FDictionary);
  inherited;
end;

function TMapperProcessValue.GetValue(const Key: String): TFunctionProcessValue;
begin
  Result := nil;

  If Not FDictionary.ContainsKey(Key) Then
    Exit;

  Result := FDictionary.Items[Key];
end;

constructor TCopyDataSet.Create;
begin
  FSequence := 0;
  FSequenceFields := [];
end;

function TCopyDataSet.IsSequenceField(const FieldName: String): Boolean;
  Var
    LCount : Integer;
begin
  Result := False;

  If (Length(FSequenceFields) = 0) Then
    Exit;

  For LCount := Low(FSequenceFields) To High(FSequenceFields) Do
  Begin
    If (FSequenceFields[LCount] = FieldName) Then
      Exit(True);
  End;
end;

function TCopyDataSet.ProcessValue(const Value: Variant; const Key: String; const AMapperProcessValue: TMapperProcessValue): Variant;
  var
    LProcessValue : TFunctionProcessValue;
begin
  LProcessValue := AMapperProcessValue.GetValue(Key);

  If Not Assigned(LProcessValue) Then
    Result := Value
  Else
    Result := LProcessValue(Value);
end;

initialization
  FLastProcessMessages := Now();

end.
