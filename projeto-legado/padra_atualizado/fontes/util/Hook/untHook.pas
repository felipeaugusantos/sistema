unit untHook;

interface

uses cxGridBandedTableView;

type
  THook = record
  private
    type
      THookMethod = record
      strict private
        type
          pHookEvent = ^THookEvent;
          THookEvent = packed record
            Jump: Byte;
            Offset: Integer;
          end;
        var
          HookedMethod, OriginalMethod: THookEvent;
          HookPositionMethod: pHookEvent;
      public
        constructor Create(const aSource, aDestination: Pointer);
        procedure Restore;
        procedure Hack;
      end;

      TcxGridBandedTableView = class(cxGridBandedTableView.TcxGridBandedTableView)
      protected
        procedure DoBandPosChangedEx(ABand: TcxGridBand);
      end;

    class var HookMethodTcxGridBandedTableView: THook.THookMethod;
  end;

implementation

uses Winapi.Windows, System.SysUtils;

constructor THook.THookMethod.Create(const aSource, aDestination: Pointer);
var
  OldProtect: Cardinal;
begin
  HookPositionMethod := pHookEvent(aSource);
  OriginalMethod := HookPositionMethod^;
  HookedMethod.Jump := $E9;
  HookedMethod.Offset := PByte(aDestination) - PByte(HookPositionMethod) - SizeOf(THookEvent);
  if not VirtualProtect(HookPositionMethod, SizeOf(THookEvent), PAGE_EXECUTE_READWRITE, OldProtect) then
    RaiseLastOSError;
  Hack;
end;

procedure THook.THookMethod.Hack;
begin
  HookPositionMethod^ := HookedMethod;
end;

procedure THook.THookMethod.Restore;
begin
  HookPositionMethod^ := OriginalMethod;
end;

procedure THook.TcxGridBandedTableView.DoBandPosChangedEx(ABand: TcxGridBand);
begin
  THook.HookMethodTcxGridBandedTableView.Restore;
  try
    DoBandPosChanged(ABand);
  except
  end;
  THook.HookMethodTcxGridBandedTableView.Hack;
end;

initialization
  THook.HookMethodTcxGridBandedTableView := THook.THookMethod.Create(@THook.TcxGridBandedTableView.DoBandPosChanged,
                                                                     @THook.TcxGridBandedTableView.DoBandPosChangedEx);
finalization
  THook.HookMethodTcxGridBandedTableView.Restore;

end.
