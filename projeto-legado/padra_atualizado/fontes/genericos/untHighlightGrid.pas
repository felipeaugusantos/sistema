unit untHighlightGrid;

interface

uses
  System.UITypes, System.Math, Vcl.Graphics, cxGraphics, cxGridCustomTableView,
  WinApi.Windows, System.Classes, System.StrUtils, System.AnsiStrings,
  System.SysUtils, cxGridDBDataDefinitions;

  procedure pHighlightCxGrid(ACanvas: TcxCanvas;
                             AViewInfo: TcxGridTableDataCellViewInfo;
                             AWords: TArray<String>);

  procedure HighlightCellText(ACanvas: TCanvas;
                              const ARect: TRect;
                              ADisplayText,
                              AFilterText: string;
                              AAlignment: TAlignment;
                              ABkColor,
                              AfnColor: TColor);

implementation

procedure HighlightCellText(ACanvas: TCanvas; const ARect: TRect;
  ADisplayText, AFilterText: string; AAlignment: TAlignment; ABkColor, AfnColor: TColor);
  var
    LHlRect : TRect;
    LStart : Integer;
    LPosition : Integer;
    LHlText: string;

  function RemoveAccentuation(AStr:String): String;
    Const
      LWith = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹"¥';
      LWithout = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';
    Var
      X : Integer;
  Begin
    For X := 1 to Length(AStr) do
      If Pos(AStr[X], LWith)<> 0 Then
        AStr[X] := LWithout[Pos(AStr[X], LWith)];
    Result := AStr;
  end;

  function FindText(ASubText, AText: String; AStart: Integer = 0): Integer;
  begin
    Result := 0;

    AText    := RemoveAccentuation(AText);
    ASubText := RemoveAccentuation(ASubText);

    AText := Copy(AText, AStart, Length(AText));

    If Pos(ASubText, AText) > 0 Then
      Result := AStart + Pos(ASubText, AText);
  end;

begin
  LStart := 1;
  while True do
  begin
    LPosition := FindText(AnsiLowerCase(AFilterText), AnsiLowerCase(ADisplayText), LStart) - 1;
    LStart := LPosition + Length(AFilterText);

    if LPosition <= 0 then
      Break;

    case AAlignment of
      TAlignment.taLeftJustify:
        LHlRect.Left := ARect.Left + ACanvas.TextWidth(Copy(ADisplayText, 1, LPosition - 1)) + 1;

      TAlignment.taRightJustify:
        LHlRect.Left := ARect.Right - ACanvas.TextWidth(ADisplayText) +
          ACanvas.TextWidth(Copy(ADisplayText, 1, LPosition - 1)) - 3;

      TAlignment.taCenter:
        LHlRect.Left := ARect.Left + ((ARect.Right - ARect.Left) div 2) -
          (ACanvas.TextWidth(ADisplayText) div 2) +
            ACanvas.TextWidth(Copy(ADisplayText, 1, LPosition - 1)) - 1;
    end;

    LHlText := Copy(ADisplayText, LPosition, Length(AFilterText));

    LHlRect.Top := ARect.Top + 2;
    LHlRect.Right := LHlRect.Left + ACanvas.TextWidth(Copy(ADisplayText, LPosition, Length(AFilterText))) + 1;
    LHlRect.Bottom := LHlRect.Top + Acanvas.TextHeight(LHlText);

    if LHlRect.Right > ARect.Right then
      LHlRect.Right := ARect.Right;

    ACanvas.Brush.Color := ABkColor;
    ACanvas.FillRect(LHlRect);

    ACanvas.Font.Color := AfnColor;
    ACanvas.TextRect(LHlRect, LHlRect.Left + 1, LHlRect.Top, LHlText);
  end;
end;

procedure _pHighlightGrid(ACanvas: TcxCanvas; ARect: TRect; AText: String;
  AAlignment: TAlignment; ASelected: Boolean; AWords: TArray<String>);
  var
    LLeft: Integer;
    LWord: String;
begin
  Case AAlignment Of
    TAlignment.taLeftJustify:
      LLeft := ARect.Left + 2;

    TAlignment.taRightJustify:
      LLeft := ARect.Right - ACanvas.TextWidth(AText) - 2;

    TAlignment.taCenter:
      LLeft := ARect.Left + ((ARect.Right - ARect.Left) div 2) - (ACanvas.TextWidth(AText) div 2);

    Else
      LLeft := 0;
  End;

  ACanvas.TextOut(LLeft, ARect.Top + 2, AText);

  For LWord In AWords Do
    If Not LWord.Trim.IsEmpty Then
      HighlightCellText(ACanvas.Canvas,
                        ARect,
                        AText,
                        LWord,
                        AAlignment,
                        IfThen(ASelected, $0B86B8, clYellow),
                        IfThen(ASelected, clWhite, clBlack));
end;

procedure pHighlightCxGrid(ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo; AWords: TArray<String>);
  Var
    I: Integer;
    LText : String;
    LLine : Integer;
    LWords: TArray<String>;
    LRect : TRect;
    LAlignment: TAlignment;

  procedure pDrawText;
    Var
      LfnColor: TColor;
      LBkColor: TColor;
  begin
    LfnColor := ACanvas.Font.Color;
    LBkColor := ACanvas.Brush.Color;
    Try
      LRect := AViewInfo.Bounds;
      LRect.Top := LRect.Top + (ACanvas.TextHeight(LText) * LLine);
      _pHighlightGrid(ACanvas, LRect, LText, LAlignment, AViewInfo.Selected, AWords);
      Inc(LLine);
      LText := '';
    Finally
      ACanvas.Font.Color  := LfnColor;
      ACanvas.Brush.Color := LBkColor;
    End;
  end;

begin
  LLine  := 0;
  LText  := '';
  LWords := AViewInfo.Text.Split([' ']);
  LAlignment := TcxGridItemDBDataBinding(AViewInfo.Item.DataBinding).Field.Alignment;

  ACanvas.FillRect(AViewInfo.Bounds, ACanvas.Brush.Color);

  For I := Low(LWords) To High(LWords) Do
  Begin
    If ACanvas.TextWidth(LText + ' ' + LWords[I]) > AViewInfo.Bounds.Width Then
      pDrawText;

    LText := LText + ' ' + LWords[I];

    If Not LText.Trim.IsEmpty And (I = High(LWords)) Then
      pDrawText;
  End;
end;

end.
