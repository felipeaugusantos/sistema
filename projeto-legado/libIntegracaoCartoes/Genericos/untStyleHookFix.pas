unit untStyleHookFix;

interface

uses
  Vcl.Themes, Vcl.StdCtrls, Winapi.Messages, System.Classes, System.SysUtils, Vcl.Buttons,
  Vcl.Controls, Vcl.ComCtrls, Vcl.Forms, System.Types, Winapi.Windows, System.Rtti,
  System.Generics.Collections, Vcl.DBGrids, Vcl.Graphics, System.UITypes, Vcl.DBCtrls,
  Vcl.CheckLst, Vcl.Grids, Vcl.SysStyles;

type
  TWinControlClassHook = class(TWinControl);
  TCustomMemoClassHook = class(TCustomMemo);

  TEditStyleHookFix = class(TEditStyleHook)
  strict private
    procedure WMNCMouseMove(var Message: TWMMouse); message WM_NCMOUSEMOVE;
    procedure WMMouseMove(var Message: TWMMouse); message WM_MOUSEMOVE;
  end;

  TBitBtnStyleHookFix = class(TBitBtnStyleHook)
  strict private
    procedure WMMouseLeave(var Message: TWMMouse); message WM_MOUSELEAVE;
    procedure WMMouseMove(var Message: TWMMouse); message WM_MOUSEMOVE;
    procedure WMNCMouseMove(var Message: TWMMouse); message WM_NCMOUSEMOVE;
  end;

  TFormStyleHookFix = class(TFormStyleHook)
  strict private
    function GetHotButton: Integer;
    procedure SetHotHutton(const Value: Integer);
    procedure WMNCMouseMove(var Message: TWMNCHitMessage); message WM_NCMOUSEMOVE;
  private
    property HotButton: Integer read GetHotButton write SetHotHutton;
  end;

  TScrollingStyleHookFix = class(TScrollingStyleHook)
  strict private
    procedure WMNCMouseMove(var Msg: TWMMouse); message WM_NCMOUSEMOVE;
    procedure WMMouseMove(var Msg: TWMMouse); message WM_MOUSEMOVE;
  end;

  TScrollBoxStyleHookFix = class(TScrollingStyleHookFix)
  strict protected
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AControl: TWinControl); override;
  end;

  TMemoStyleHookFix = class(TScrollingStyleHookFix)
  strict private
    procedure UpdateColors;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
  strict protected
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AControl: TWinControl); override;
  end;

  TListBoxStyleHookFix = class(TScrollingStyleHookFix)
  strict private
    procedure UpdateColors;
  strict protected
    procedure WndProc(var Message: TMessage); override;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
  public
    constructor Create(AControl: TWinControl); override;
  end;

  TTabControlStyleHookFix = class(TTabControlStyleHook)
  strict private
    procedure UpdateTabs(OldHotTab, HotTab: Integer);
    procedure WMMouseMove(var Message: TMessage); message WM_MOUSEMOVE;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  private
    procedure SetMousePosition(const Value: TMouseTrackControlStyleHook.TMousePosition);
    procedure SetHotTabIndex(const Value: Integer);
  end;

  TRadioButtonStyleHookFix = class(TRadioButtonStyleHook)
  strict protected
    procedure WMMouseMove(var Message: TMessage); message WM_MOUSEMOVE;
  end;

  TCheckBoxStyleHookFix = class(TCheckBoxStyleHook)
  strict protected
    procedure WMMouseMove(var Message: TMessage); message WM_MOUSEMOVE;
  end;

  TComboBoxStyleHookFix = class(TComboBoxStyleHook)
  strict protected
    procedure WMMouseMove(var Message: TWMMouse); message WM_MOUSEMOVE;
  end;

  TRttiUtils = class sealed
  public
    class function GetField<T>(AObject: TObject; AField: string): T;
    class procedure SetField<T>(AObject: TObject; AField: string; AValue: T);
    class function ExecuteMethod(AObject: TObject; MethodName: string;
      MethosParams: array of TValue): TValue;
  end;

implementation

procedure RegisterStyleHookDef;
begin
  TCustomStyleEngine.RegisterStyleHook(TCustomEdit, TEditStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TEdit, TEditStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TCustomForm, TFormStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TForm, TFormStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TBitBtn, TBitBtnStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TTabControl, TTabControlStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TCustomTabControl, TTabControlStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TCustomDBGrid, TScrollingStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TDBGrid, TScrollingStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TScrollBox, TScrollBoxStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TCustomGrid, TScrollingStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TCustomDrawGrid, TScrollingStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TStringGrid, TScrollingStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TDrawGrid, TScrollingStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TRadioButton, TRadioButtonStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TCustomCheckBox, TCheckBoxStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TCheckBox, TCheckBoxStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TCustomMemo, TMemoStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TMemo, TMemoStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TDBMemo, TMemoStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TCustomComboBox, TComboBoxStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TComboBox, TComboBoxStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TCustomListBox, TListBoxStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TCheckListBox, TListBoxStyleHook);
  TCustomStyleEngine.RegisterStyleHook(TListBox, TListBoxStyleHook);
  TCustomStyleEngine.RegisterSysStyleHook('#32768', TSysPopupStyleHook);
end;

procedure UnRegisterStyleHookDef;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TCustomEdit, TEditStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TEdit, TEditStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomForm, TFormStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TForm, TFormStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TBitBtn, TBitBtnStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TTabControl, TTabControlStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomTabControl, TTabControlStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomDBGrid, TScrollingStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TDBGrid, TScrollingStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TScrollBox, TScrollBoxStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomGrid, TScrollingStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomDrawGrid, TScrollingStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TStringGrid, TScrollingStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TDrawGrid, TScrollingStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TRadioButton, TRadioButtonStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomCheckBox, TCheckBoxStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TCheckBox, TCheckBoxStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomMemo, TMemoStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TMemo, TMemoStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TDBMemo, TMemoStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomComboBox, TComboBoxStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TComboBox, TComboBoxStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomListBox, TListBoxStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TCheckListBox, TListBoxStyleHook);
  TCustomStyleEngine.UnRegisterStyleHook(TListBox, TListBoxStyleHook);
  TCustomStyleEngine.UnRegisterSysStyleHook('#32768', TSysPopupStyleHook);
end;

procedure RegisterStyleHookFix;
begin
  TCustomStyleEngine.RegisterStyleHook(TCustomEdit, TEditStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TEdit, TEditStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TCustomForm, TFormStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TForm, TFormStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TBitBtn, TBitBtnStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TTabControl, TTabControlStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TCustomTabControl, TTabControlStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TCustomDBGrid, TScrollingStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TDBGrid, TScrollingStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TScrollBox, TScrollBoxStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TCustomGrid, TScrollingStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TCustomDrawGrid, TScrollingStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TStringGrid, TScrollingStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TDrawGrid, TScrollingStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TRadioButton, TRadioButtonStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TCustomCheckBox, TCheckBoxStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TCheckBox, TCheckBoxStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TCustomMemo, TMemoStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TMemo, TMemoStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TDBMemo, TMemoStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TCustomComboBox, TComboBoxStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TComboBox, TComboBoxStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TCustomListBox, TListBoxStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TCheckListBox, TListBoxStyleHookFix);
  TCustomStyleEngine.RegisterStyleHook(TListBox, TListBoxStyleHookFix);
end;

procedure UnRegisterStyleHookFix;
begin
  TCustomStyleEngine.UnRegisterStyleHook(TCustomEdit, TEditStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TEdit, TEditStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomForm, TFormStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TForm, TFormStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TBitBtn, TBitBtnStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TTabControl, TTabControlStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomTabControl, TTabControlStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomDBGrid, TScrollingStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TDBGrid, TScrollingStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TScrollBox, TScrollBoxStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomGrid, TScrollingStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomDrawGrid, TScrollingStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TStringGrid, TScrollingStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TDrawGrid, TScrollingStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TRadioButton, TRadioButtonStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomCheckBox, TCheckBoxStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TCheckBox, TCheckBoxStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomMemo, TMemoStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TMemo, TMemoStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TDBMemo, TMemoStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomComboBox, TComboBoxStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TComboBox, TComboBoxStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TCustomListBox, TListBoxStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TCheckListBox, TListBoxStyleHookFix);
  TCustomStyleEngine.UnRegisterStyleHook(TListBox, TListBoxStyleHookFix);
end;

class function TRttiUtils.ExecuteMethod(AObject: TObject; MethodName: string;
  MethosParams: array of TValue): TValue;
var
  LContext: TRttiContext;
  LType: TRttiType;
  LMethod: TRttiMethod;
begin
  LContext := TRttiContext.Create;
  LType := LContext.GetType(AObject.ClassInfo);
  Result := nil;
  Try
    If Assigned(LType) Then
    Begin
      LMethod := LType.GetMethod(MethodName);
      Try
        If Assigned(LMethod) Then
          Result := LMethod.Invoke(AObject, MethosParams);
      Finally
        LMethod.Free;
      End;
    End;
  Finally
    LType.Free;
    LContext.Free;
  End;
end;

class function TRttiUtils.GetField<T>(AObject: TObject; AField: string): T;
var
  LContext: TRttiContext;
  LType: TRttiType;
  LField: TRttiField;
begin
  LContext := TRttiContext.Create;
  LType := LContext.GetType(AObject.ClassInfo);
  Try
    If Assigned(LType) Then
    Begin
      LField := LType.GetField(AField);
      Try
        If Assigned(LField) Then
          Result := LField.GetValue(AObject).AsType<T>;
      Finally
        LField.Free;
      End;
    End;
  Finally
    LType.Free;
    LContext.Free;
  End;
end;

class procedure TRttiUtils.SetField<T>(AObject: TObject; AField: string; AValue: T);
var
  LContext: TRttiContext;
  LType: TRttiType;
  LField: TRttiField;
begin
  LContext := TRttiContext.Create;
  LType := LContext.GetType(AObject.ClassInfo);
  Try
    If Assigned(LType) Then
    Begin
      LField := LType.GetField(AField);
      Try
        If Assigned(LField) Then
          LField.SetValue(AObject, TValue.From<T>(AValue));
      Finally
        LField.Free;
      End;
    End;
  Finally
    LType.Free;
    LContext.Free;
  End;
end;

{ TEditStyleHookFix }

procedure TEditStyleHookFix.WMMouseMove(var Message: TWMMouse);
begin
  if not MouseInControl then
  begin
    MouseInControl := True;
    MouseEnter;
  end;
end;

procedure TEditStyleHookFix.WMNCMouseMove(var Message: TWMMouse);
begin
  if not MouseInControl then
  begin
    MouseInControl := True;
    MouseEnter;
  end;
end;

{ TFormStyleHookFix }

function TFormStyleHookFix.GetHotButton: Integer;
begin
  Result := TRttiUtils.GetField<Integer>(Self, 'FHotButton');
end;

procedure TFormStyleHookFix.SetHotHutton(const Value: Integer);
begin
  TRttiUtils.SetField<Integer>(Self, 'FHotButton', Value);
end;

procedure TFormStyleHookFix.WMNCMouseMove(var Message: TWMNCHitMessage);
begin
  if (Message.HitTest = HTCLOSE) or (Message.HitTest = HTMAXBUTTON) or
    (Message.HitTest = HTMINBUTTON) or (Message.HitTest = HTHELP) then
  begin
    if Self.HotButton <> Message.HitTest then
    begin
      Self.HotButton := Message.HitTest;
      InvalidateNC;
    end;
    Message.Result := 0;
    Message.Msg := WM_NULL;
    Handled := True;
  end
  else if Self.HotButton <> 0 then
  begin
    Self.HotButton := 0;
    InvalidateNC;
  end;
end;

{ TBitBtnStyleHookFix }

procedure TBitBtnStyleHookFix.WMMouseLeave(var Message: TWMMouse);
begin
  MouseInControl := False;
  MouseLeave;
end;

procedure TBitBtnStyleHookFix.WMMouseMove(var Message: TWMMouse);
begin
  If Control.StyleElements <> [] Then
    Control.StyleElements := [];
end;

procedure TBitBtnStyleHookFix.WMNCMouseMove(var Message: TWMMouse);
begin
  // do nothing
end;

{ TTabControlStyleHookFix }

procedure TTabControlStyleHookFix.CMMouseLeave(var Message: TMessage);
begin
  WMMouseMove(Message);
end;

procedure TTabControlStyleHookFix.SetHotTabIndex(const Value: Integer);
begin
  TRttiUtils.SetField<Integer>(Self, 'FHotTabIndex', Value);
end;

procedure TTabControlStyleHookFix.SetMousePosition
  (const Value: TMouseTrackControlStyleHook.TMousePosition);
begin
  TRttiUtils.SetField<TMouseTrackControlStyleHook.TMousePosition>(Self, 'FMousePosition', Value);
end;

procedure TTabControlStyleHookFix.UpdateTabs(OldHotTab, HotTab: Integer);
var
  R: TRect;
begin
  if (OldHotTab >= 0) and (OldHotTab < TabCount) then
  begin
    R := TabRect[OldHotTab];
    InvalidateRect(Handle, @R, True);
  end;
  if (HotTab >= 0) and (HotTab < TabCount) then
  begin
    R := TabRect[HotTab];
    InvalidateRect(Handle, @R, True);
  end;
end;

procedure TTabControlStyleHookFix.WMMouseMove(var Message: TMessage);
var
  Index, OldIndex: Integer;
begin
  if not MouseInControl then
  begin
    MouseInControl := True;
    MouseEnter;
  end;
  CallDefaultProc(Message);
  SetMousePosition(mpNone);
  Index := IndexOfTabAt(TWMMouseMove(Message).XPos, TWMMouseMove(Message).YPos);
  if Index <> HotTabIndex then
  begin
    OldIndex := HotTabIndex;
    SetHotTabIndex(Index);
    UpdateTabs(OldIndex, Index);
  end;
end;

{ TScrollingStyleHookFix }

procedure TScrollingStyleHookFix.WMMouseMove(var Msg: TWMMouse);
var
  SF: TScrollInfo;
begin
  if not MouseInControl then
  begin
    MouseInControl := True;
    MouseEnter;
  end;

  if VertSliderState = tsThumbBtnVertPressed then
  begin
    SF.fMask := SIF_ALL;
    SF.cbSize := SizeOf(SF);
    GetScrollInfo(Handle, SB_VERT, SF);
    if SF.nPos <> Round(ScrollPos) then
      ScrollPos := SF.nPos;

    ScrollPos := ScrollPos + (SF.nMax - SF.nMin) *
      ((Mouse.CursorPos.Y - PrevScrollPos) / VertTrackRect.Height);
    if ScrollPos < SF.nMin then
      ScrollPos := SF.nMin;
    if ScrollPos > SF.nMax then
      ScrollPos := SF.nMax;
    if SF.nPage <> 0 then
      if Round(ScrollPos) > SF.nMax - Integer(SF.nPage) + 1 then
        ScrollPos := SF.nMax - Integer(SF.nPage) + 1;
    PrevScrollPos := Mouse.CursorPos.Y;
    SF.nPos := Round(ScrollPos);

    SetScrollInfo(Handle, SB_VERT, SF, False);
    PostMessage(Handle, WM_VSCROLL, Integer(SmallPoint(SB_THUMBTRACK, Round(ScrollPos))), 0);

    PaintScroll;
    Handled := True;
    Exit;
  end;

  if HorzSliderState = tsThumbBtnHorzPressed then
  begin
    SF.fMask := SIF_ALL;
    SF.cbSize := SizeOf(SF);
    GetScrollInfo(Handle, SB_HORZ, SF);
    if SF.nPos <> Round(ScrollPos) then
      ScrollPos := SF.nPos;

    ScrollPos := ScrollPos + (SF.nMax - SF.nMin) *
      ((Mouse.CursorPos.X - PrevScrollPos) / HorzTrackRect.Width);
    if ScrollPos < SF.nMin then
      ScrollPos := SF.nMin;
    if ScrollPos > SF.nMax then
      ScrollPos := SF.nMax;
    if SF.nPage <> 0 then
      if Round(ScrollPos) > SF.nMax - Integer(SF.nPage) + 1 then
        ScrollPos := SF.nMax - Integer(SF.nPage) + 1;
    PrevScrollPos := Mouse.CursorPos.X;
    SF.nPos := Round(ScrollPos);

    SetScrollInfo(Handle, SB_HORZ, SF, False);
    PostMessage(Handle, WM_HSCROLL, Integer(SmallPoint(SB_THUMBTRACK, Round(ScrollPos))), 0);

    PaintScroll;
    Handled := True;
    Exit;
  end;

  if (HorzSliderState <> tsThumbBtnHorzPressed) and (HorzSliderState = tsThumbBtnHorzHot) then
  begin
    HorzSliderState := tsThumbBtnHorzNormal;
    PaintScroll;
  end;

  if (VertSliderState <> tsThumbBtnVertPressed) and (VertSliderState = tsThumbBtnVertHot) then
  begin
    VertSliderState := tsThumbBtnVertNormal;
    PaintScroll;
  end;

  if (HorzUpState <> tsArrowBtnLeftPressed) and (HorzUpState = tsArrowBtnLeftHot) then
  begin
    HorzUpState := tsArrowBtnLeftNormal;
    PaintScroll;
  end;

  if (HorzDownState <> tsArrowBtnRightPressed) and (HorzDownState = tsArrowBtnRightHot) then
  begin
    HorzDownState := tsArrowBtnRightNormal;
    PaintScroll;
  end;

  if (VertUpState <> tsArrowBtnUpPressed) and (VertUpState = tsArrowBtnUpHot) then
  begin
    VertUpState := tsArrowBtnUpNormal;
    PaintScroll;
  end;

  if (VertDownState <> tsArrowBtnDownPressed) and (VertDownState = tsArrowBtnDownHot) then
  begin
    VertDownState := tsArrowBtnDownNormal;
    PaintScroll;
  end;

  CallDefaultProc(TMessage(Msg));
  if LeftButtonDown then
    PaintScroll;
  Handled := True;
end;

procedure TScrollingStyleHookFix.WMNCMouseMove(var Msg: TWMMouse);
var
  P: TPoint;
  MustUpdateScroll: Boolean;
begin
  if not MouseInControl then
  begin
    MouseInControl := True;
    MouseEnter;
  end;

  P := Point(Msg.XPos, Msg.YPos);
  ScreenToClient(Handle, P);

  if HasBorder then
    if HasClientEdge then
    begin
      P.X := P.X + 2;
      P.Y := P.Y + 2;
    end
    else
    begin
      P.X := P.X + 1;
      P.Y := P.Y + 1;
    end;

  MustUpdateScroll := False;

  if VertSliderRect.Height > 0 then
    if VertSliderRect.Contains(P) and (VertSliderState = tsThumbBtnVertNormal) then
    begin
      VertSliderState := tsThumbBtnVertHot;
      MustUpdateScroll := True;
    end
    else if not VertSliderRect.Contains(P) and (VertSliderState = tsThumbBtnVertHot) then
    begin
      VertSliderState := tsThumbBtnVertNormal;
      MustUpdateScroll := True;
    end;

  if HorzSliderRect.Width > 0 then
    if HorzSliderRect.Contains(P) and (HorzSliderState = tsThumbBtnHorzNormal) then
    begin
      HorzSliderState := tsThumbBtnHorzHot;
      MustUpdateScroll := True;
    end
    else if not HorzSliderRect.Contains(P) and (HorzSliderState = tsThumbBtnHorzHot) then
    begin
      HorzSliderState := tsThumbBtnHorzNormal;
      MustUpdateScroll := True;
    end;

  if VertSliderRect.Height > 0 then
    if VertDownButtonRect.Contains(P) and (VertDownState = tsArrowBtnDownNormal) then
    begin
      VertDownState := tsArrowBtnDownHot;
      MustUpdateScroll := True;
    end
    else if not VertDownButtonRect.Contains(P) and (VertDownState = tsArrowBtnDownHot) then
    begin
      VertDownState := tsArrowBtnDownNormal;
      MustUpdateScroll := True;
    end;

  if VertSliderRect.Height > 0 then
    if VertUpButtonRect.Contains(P) and (VertUpState = tsArrowBtnUpNormal) then
    begin
      VertUpState := tsArrowBtnUpHot;
      MustUpdateScroll := True;
    end
    else if not VertUpButtonRect.Contains(P) and (VertUpState = tsArrowBtnUpHot) then
    begin
      VertUpState := tsArrowBtnUpNormal;
      MustUpdateScroll := True;
    end;

  if HorzSliderRect.Width > 0 then
    if HorzDownButtonRect.Contains(P) and (HorzDownState = tsArrowBtnRightNormal) then
    begin
      HorzDownState := tsArrowBtnRightHot;
      MustUpdateScroll := True;
    end
    else if not HorzDownButtonRect.Contains(P) and (HorzDownState = tsArrowBtnRightHot) then
    begin
      HorzDownState := tsArrowBtnRightNormal;
      MustUpdateScroll := True;
    end;

  if HorzSliderRect.Width > 0 then
    if HorzUpButtonRect.Contains(P) and (HorzUpState = tsArrowBtnLeftNormal) then
    begin
      HorzUpState := tsArrowBtnLeftHot;
      MustUpdateScroll := True;
    end
    else if not HorzUpButtonRect.Contains(P) and (HorzUpState = tsArrowBtnLeftHot) then
    begin
      HorzUpState := tsArrowBtnLeftNormal;
      MustUpdateScroll := True;
    end;

  if MustUpdateScroll then
    PaintScroll;
end;

{ TScrollBoxStyleHookFix }

constructor TScrollBoxStyleHookFix.Create(AControl: TWinControl);
begin
  inherited;
  OverrideEraseBkgnd := True;
  if seClient in Control.StyleElements then
    Brush.Color := StyleServices.GetStyleColor(scPanel)
  else
    Brush.Color := TWinControlClassHook(Control).Color;
end;

procedure TScrollBoxStyleHookFix.WndProc(var Message: TMessage);
begin
  // Reserved for potential updates
  inherited;
  case Message.Msg of
    WM_VSCROLL, WM_HSCROLL:
      if TWMScroll(Message).ScrollCode = SB_ENDSCROLL then
        SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_FRAMECHANGED or SWP_NOACTIVATE or SWP_NOMOVE or
          SWP_NOSIZE or SWP_NOZORDER);
  end;
end;

{ TRadioButtonStyleHookFix }

procedure TRadioButtonStyleHookFix.WMMouseMove(var Message: TMessage);
begin
  if not MouseInControl then
  begin
    MouseInControl := True;
    MouseEnter;
  end;
end;

{ TCheckBoxStyleHookFix }

procedure TCheckBoxStyleHookFix.WMMouseMove(var Message: TMessage);
begin
  if not MouseInControl then
  begin
    MouseInControl := True;
    MouseEnter;
  end;
end;

{ TMemoStyleHookFix }

constructor TMemoStyleHookFix.Create(AControl: TWinControl);
begin
  inherited;
  OverridePaintNC := True;
  OverrideEraseBkgnd := True;
  UpdateColors;
end;

procedure TMemoStyleHookFix.UpdateColors;
const
  ColorStates: array [Boolean] of TStyleColor = (scEditDisabled, scEdit);
  FontColorStates: array [Boolean] of TStyleFont = (sfEditBoxTextDisabled, sfEditBoxTextNormal);
var
  LStyle: TCustomStyleServices;
begin
  LStyle := StyleServices;
  Brush.Color := LStyle.GetStyleColor(ColorStates[Control.Enabled]);
  if seFont in Control.StyleElements then
    FontColor := LStyle.GetStyleFontColor(FontColorStates[Control.Enabled])
  else
    FontColor := TWinControlClassHook(Control).Font.Color;
end;

procedure TMemoStyleHookFix.WMNCCalcSize(var Message: TWMNCCalcSize);
var
  Params: PNCCalcSizeParams;
begin
  if (Control is TCustomMemo) and (TCustomMemoClassHook(Control).BevelKind <> bkNone) and HasBorder
  then
  begin
    CallDefaultProc(TMessage(Message));
    Params := Message.CalcSize_Params;
    with Params^.rgrc[0] do
    begin
      Dec(Left, 2);
      Dec(Top, 2);
      Inc(Right, 2);
      Inc(Bottom, 2);
    end;
    Handled := True;
  end;
end;

procedure TMemoStyleHookFix.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    CN_CTLCOLORMSGBOX .. CN_CTLCOLORSTATIC:
      begin
        SetTextColor(Message.WParam, ColorToRGB(FontColor));
        SetBkColor(Message.WParam, ColorToRGB(Brush.Color));
        Message.Result := LRESULT(Brush.Handle);
        Handled := True;
      end;
    CM_ENABLEDCHANGED:
      begin
        UpdateColors;
        Handled := False; // Allow control to handle message
      end
  else
    inherited WndProc(Message);
  end;
end;

{ TComboBoxStyleHookFix }

procedure TComboBoxStyleHookFix.WMMouseMove(var Message: TWMMouse);
var
  P: TPoint;
  R: TRect;
  FOldMouseOnButton: Boolean;
begin
  CallDefaultProc(TMessage(Message));

  if not MouseInControl then
  begin
    MouseInControl := True;
    MouseEnter;
  end;

  P := Point(Message.XPos, Message.YPos);
  FOldMouseOnButton := MouseOnButton;
  R := ButtonRect;
  if R.Contains(P) then
    MouseOnButton := True
  else
    MouseOnButton := False;

  if FOldMouseOnButton <> MouseOnButton then
    InvalidateRect(Handle, @R, False);

  Handled := True;
end;

{ TListBoxStyleHookFix }

constructor TListBoxStyleHookFix.Create(AControl: TWinControl);
begin
  inherited;
  OverrideEraseBkgnd := True;
  UpdateColors;
end;

procedure TListBoxStyleHookFix.UpdateColors;
const
  ColorStates: array [Boolean] of TStyleColor = (scListBoxDisabled, scListBox);
  FontColorStates: array [Boolean] of TStyleFont = (sfListItemTextDisabled, sfListItemTextNormal);
var
  LStyle: TCustomStyleServices;
begin
  LStyle := StyleServices;
  Brush.Color := LStyle.GetStyleColor(ColorStates[Control.Enabled]);
  if seFont in Control.StyleElements then
    FontColor := LStyle.GetStyleFontColor(FontColorStates[Control.Enabled])
  else
    FontColor := TWinControlClassHook(Control).Font.Color;
end;

procedure TListBoxStyleHookFix.WMKillFocus(var Message: TMessage);
begin
  inherited;
  CallDefaultProc(Message);
  RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
  Handled := True;
end;

procedure TListBoxStyleHookFix.WMSetFocus(var Message: TMessage);
begin
  inherited;
  CallDefaultProc(Message);
  RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_UPDATENOW);
  Handled := True;
end;

procedure TListBoxStyleHookFix.WndProc(var Message: TMessage);
begin
  case Message.Msg of
    CN_CTLCOLORMSGBOX .. CN_CTLCOLORSTATIC:
      begin
        SetTextColor(Message.WParam, ColorToRGB(FontColor));
        SetBkColor(Message.WParam, ColorToRGB(Brush.Color));
        Message.Result := LRESULT(Brush.Handle);
        Handled := True;
      end;
    CM_ENABLEDCHANGED:
      begin
        UpdateColors;
        Handled := False; // Allow control to handle message
      end
  else
    inherited WndProc(Message);
  end;
end;

initialization

UnRegisterStyleHookDef;
RegisterStyleHookFix;

finalization

  try
    UnRegisterStyleHookFix;
    RegisterStyleHookDef;
  except
    on EInvalidOperation do ; // janelas já destruídas/desabilitadas durante o shutdown
  end;

end.
