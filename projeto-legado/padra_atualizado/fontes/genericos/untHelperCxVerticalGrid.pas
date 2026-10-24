unit untHelperCxVerticalGrid;

interface

uses cxVGrid, cxStyles, untTypesSistema;

type
  THelperCxVerticalGrid = class helper for TcxVerticalGrid
    procedure AddRowBoolean(const AName, ACaption: String; const ADefault: Boolean; const AStyle: TcxStyle; const AEditing : Boolean);
    procedure AddRowInteger(const AName, ACaption: String; const AMin, AMax, ADefault: Integer; const AStyle: TcxStyle; const AEditing : Boolean; const ACategory: TcxCustomRow = Nil);
    procedure AddRowComboBox(const AName, ACaption: String; const AOpcoes: TArrString; const ADefault: Integer; const AStyle: TcxStyle);
    function GetValueRowInteger(const AName: String): Integer;
    function GetValueRowBoolean(const AName: String): Boolean;
    function GetValueRowString(const AName: String): String;
    function GetAbsoluteIndex(const AName: String): Integer;
    function AddCategoryRow(const AName, ACaption: String): TcxCategoryRow;
    procedure AddRowTextEdit(const AName, ACaption: String; AMaxLength : Integer; const ACategory: TcxCustomRow = Nil; const AStyleHeader: TcxStyle = Nil; const AEditing : Boolean = True);
    procedure AddRowDateEdit(const AName, ACaption: String; const ACategory: TcxCustomRow = Nil);
    procedure AddRowDecimal(const AName, ACaption: String; const ADecimalPlaces: Integer; const AMinValue : Integer; const ACategory: TcxCustomRow);
  End;

implementation

uses System.Classes, cxCheckBox, cxSpinEdit, cxDropDownEdit, cxTextEdit,
  System.SysUtils, Vcl.StdCtrls, cxCalendar, cxInplaceContainer, cxCurrencyEdit;

{ THelperCxVerticalGrid }

procedure THelperCxVerticalGrid.AddRowBoolean(const AName, ACaption: String; const ADefault: Boolean; const AStyle: TcxStyle; const AEditing : Boolean);
  Var
    LElemento: TcxEditorRow;
    LAbsoluteIndex : Integer;
begin
  LElemento := TcxEditorRow(Self.Add(TcxEditorRow));
  LElemento.Properties.Options.Editing := AEditing;
  If (Assigned(AStyle)) Then
    LElemento.Styles.Header := AStyle;
  LElemento.Properties.HeaderAlignmentHorz := taRightJustify;
  LAbsoluteIndex := LElemento.AbsoluteIndex;
  Self.Rows.Items[LAbsoluteIndex].Visible := True;
  Self.Rows.Items[LAbsoluteIndex].Name := AName;
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.Caption := ACaption;
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditPropertiesClass := TcxCheckBoxProperties;
  TcxCheckBoxProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).ImmediatePost := True;
  TcxCheckBoxProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).ValueChecked := True;
  TcxCheckBoxProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).ValueUnChecked := False;
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.Value := ADefault;
end;

procedure THelperCxVerticalGrid.AddRowInteger(const AName, ACaption: String; const AMin, AMax, ADefault: Integer; const AStyle: TcxStyle; const AEditing : Boolean; const ACategory: TcxCustomRow = Nil);
  Var
    LElemento: TcxEditorRow;
    LAbsoluteIndex : Integer;
begin
  If Assigned(ACategory) Then
    LElemento := TcxEditorRow(Self.AddChild(ACategory, TcxEditorRow))
  Else
    LElemento := TcxEditorRow(Self.Add(TcxEditorRow));
  LElemento.Properties.Options.Editing := AEditing;
  If (Assigned(AStyle)) Then
    LElemento.Styles.Header := AStyle;
  LElemento.Properties.HeaderAlignmentHorz := taRightJustify;
  LAbsoluteIndex := LElemento.AbsoluteIndex;
  Self.Rows.Items[LAbsoluteIndex].Visible := True;
  Self.Rows.Items[LAbsoluteIndex].Name := AName;
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.Caption := ACaption;
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditPropertiesClass := TcxSpinEditProperties;
  TcxSpinEditProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).Alignment.Horz := taCenter;
  TcxSpinEditProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).MaxValue := AMax;
  TcxSpinEditProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).MinValue := AMin;
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.DataBinding.ValueType := 'Integer';
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.Value := ADefault;
end;

procedure THelperCxVerticalGrid.AddRowComboBox(const AName, ACaption: String; const AOpcoes: TArrString; const ADefault: Integer; const AStyle: TcxStyle);
  Var
    LElemento: TcxEditorRow;
    LAbsoluteIndex : Integer;
    LIndex : Integer;
begin
  LElemento := TcxEditorRow(Self.Add(TcxEditorRow));
  LElemento.Properties.Options.Editing := True;
  If (Assigned(AStyle)) Then
    LElemento.Styles.Header := AStyle;
  LElemento.Properties.HeaderAlignmentHorz := taRightJustify;
  LAbsoluteIndex := LElemento.AbsoluteIndex;
  Self.Rows.Items[LAbsoluteIndex].Visible := True;
  Self.Rows.Items[LAbsoluteIndex].Name := AName;
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.Caption := ACaption;
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditPropertiesClass := TcxComboBoxProperties;
  TcxComboBoxProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).Items.Clear;
  For LIndex := 0 To Pred(Length(AOpcoes)) Do
    TcxComboBoxProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).Items.Add(AOpcoes[LIndex]);
  TcxComboBoxProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).DropDownListStyle := lsFixedList;
  TcxComboBoxProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).ImmediatePost := True;
  TcxComboBoxProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).ImmediateUpdateText := True;
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.Value := AOpcoes[ADefault];
end;

function THelperCxVerticalGrid.GetValueRowBoolean(const AName: String): Boolean;
  Var
    LAbsoluteIndex : Integer;
begin
  Result := False;
  LAbsoluteIndex := GetAbsoluteIndex(AName);
  If (LAbsoluteIndex >= 0) Then
    Result := TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.Value;
end;

function THelperCxVerticalGrid.GetValueRowInteger(const AName: String): Integer;
  Var
    LAbsoluteIndex : Integer;
begin
  Result := -1;
  LAbsoluteIndex := GetAbsoluteIndex(AName);
  If (LAbsoluteIndex >= 0) Then
    Result := TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.Value;
end;

function THelperCxVerticalGrid.GetValueRowString(const AName: String): String;
  Var
    LAbsoluteIndex : Integer;
begin
  Result := EmptyStr;
  LAbsoluteIndex := GetAbsoluteIndex(AName);
  If (LAbsoluteIndex >= 0) Then
    Result := TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.Value;
end;

function THelperCxVerticalGrid.GetAbsoluteIndex(const AName: String): Integer;
  Var
    LCount : Integer;
begin
  Result := -1;
  For LCount := 0 To Pred(Self.Rows.Count) Do
  Begin
    If (Self.Rows[LCount].Name = AName) Then
      Exit(Self.Rows[LCount].AbsoluteIndex);
  End;
end;

function THelperCxVerticalGrid.AddCategoryRow(const AName, ACaption: String) : TcxCategoryRow;
begin
  Result := TcxCategoryRow(Self.Add(TcxCategoryRow));
  Result.Name := AName;
  Result.Properties.Caption := ACaption;
  Result.Properties.HeaderAlignmentHorz := taLeftJustify;
  Result.Options.TabStop := False;
end;

procedure THelperCxVerticalGrid.AddRowTextEdit(const AName, ACaption: String; AMaxLength : Integer; const ACategory: TcxCustomRow = Nil; const AStyleHeader: TcxStyle = Nil; const AEditing : Boolean = True);
  Var
    LElemento: TcxEditorRow;
    LAbsoluteIndex : Integer;
begin
  If Assigned(ACategory) Then
    LElemento := TcxEditorRow(Self.AddChild(ACategory, TcxEditorRow))
  Else
    LElemento := TcxEditorRow(Self.Add(TcxEditorRow));
  LElemento.Properties.Options.Editing := AEditing;
  If (Assigned(AStyleHeader)) Then
    LElemento.Styles.Header := AStyleHeader;
  LElemento.Properties.HeaderAlignmentHorz := taRightJustify;
  LAbsoluteIndex := LElemento.AbsoluteIndex;
  Self.Rows.Items[LAbsoluteIndex].Visible := True;
  Self.Rows.Items[LAbsoluteIndex].Name := AName;
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.Caption := ACaption;
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditPropertiesClass := TcxTextEditProperties;
  TcxTextEditProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).Alignment.Horz := taCenter;
  TcxTextEditProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).CharCase := ecUpperCase;
  TcxTextEditProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).MaxLength := AMaxLength;
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.DataBinding.ValueType := 'String';
end;

procedure THelperCxVerticalGrid.AddRowDateEdit(const AName, ACaption: String; const ACategory: TcxCustomRow = Nil);
  Var
    LElemento: TcxEditorRow;
    LAbsoluteIndex : Integer;
begin
  If Assigned(ACategory) Then
    LElemento := TcxEditorRow(Self.AddChild(ACategory, TcxEditorRow))
  Else
    LElemento := TcxEditorRow(Self.Add(TcxEditorRow));
  LElemento.Properties.HeaderAlignmentHorz := taRightJustify;
  LAbsoluteIndex := LElemento.AbsoluteIndex;
  Self.Rows.Items[LAbsoluteIndex].Visible := True;
  Self.Rows.Items[LAbsoluteIndex].Name := AName;
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.Caption := ACaption;
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditPropertiesClass := TcxDateEditProperties;
  TcxDateEditProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).View := cavClassic;
  TcxDateEditProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).DateButtons := [];
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.Options.ShowEditButtons := TcxEditItemShowEditButtons(2);
  TcxDateEditProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).Alignment.Horz := taCenter;
end;

procedure THelperCxVerticalGrid.AddRowDecimal(const AName, ACaption: String; const ADecimalPlaces: Integer; const AMinValue : Integer; const ACategory: TcxCustomRow);
  Var
    LElemento: TcxEditorRow;
    LAbsoluteIndex : Integer;
begin
  If Assigned(ACategory) Then
    LElemento := TcxEditorRow(Self.AddChild(ACategory, TcxEditorRow))
  Else
    LElemento := TcxEditorRow(Self.Add(TcxEditorRow));
  LElemento.Properties.Options.Editing := true;
  LElemento.Properties.HeaderAlignmentHorz := taRightJustify;
  LAbsoluteIndex := LElemento.AbsoluteIndex;
  Self.Rows.Items[LAbsoluteIndex].Visible := True;
  Self.Rows.Items[LAbsoluteIndex].Name := AName;
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.Caption := ACaption;
  TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditPropertiesClass := TcxCurrencyEditProperties;
  TcxCurrencyEditProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).DecimalPlaces := ADecimalPlaces;
  TcxCurrencyEditProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).DisplayFormat := '0.' + StringOfChar('0', ADecimalPlaces) + ';-0.' + StringOfChar('0', ADecimalPlaces);
  TcxCurrencyEditProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).Alignment.Horz := taCenter;
  TcxCurrencyEditProperties(TcxEditorRow(Self.Rows[LAbsoluteIndex]).Properties.EditProperties).MinValue := AMinValue;
end;

end.
