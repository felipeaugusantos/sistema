unit Controller.Faturamento.Interfaces.Cache;

interface

Uses
  {$IFDEF LINUX}
  {$ELSE}
  Vcl.Forms, Dialogs,
  {$ENDIF}
  System.Rtti, System.SysUtils, Classes,
  System.StrUtils, System.Generics.Collections,
  Core.Funcoes;

type
  TControllerFaturamentoInterfacesCache = class sealed
  private
    class var FMREW: TMultiReadExclusiveWriteSynchronizer;
  strict private
    class var FCache: TDictionary<String, IInterface>;
    class function GetValueText(AValue: TValue): String;
    class function GetObjectFields(AValue: TValue): String;
    class function GetRecordFields(AValue: TValue): String;
    class function GetInterfaceKey(ACalcParam: IInterface;
      AMD5: Boolean = True): String;
    class function GetStrongKey(AKey: String): String;
  public
    class function TryGetCache<R: IInterface>(ACalcParam: IInterface;
      out ACalcResult: R): Boolean; overload;
    class function TryGetCache<R: IInterface>(AKey: String; out ACalcResult: R)
      : Boolean; overload;
    class procedure AddOrSetCache(ACalcParam, ACalcResult: IInterface);
      overload;
    class procedure AddOrSetCache(AKey: String;
      ACalcResult: IInterface); overload;
    class procedure ClearCache;
  end;

implementation

uses
  Controller.Faturamento.Interfaces.Impostos.Parametros.Comum;

{ TControllerFaturamentoInterfacesCache }

class procedure TControllerFaturamentoInterfacesCache.AddOrSetCache(ACalcParam,
  ACalcResult: IInterface);
begin
  AddOrSetCache(Self.GetInterfaceKey(ACalcParam), ACalcResult);
end;

class procedure TControllerFaturamentoInterfacesCache.AddOrSetCache
  (AKey: String; ACalcResult: IInterface);
begin
  FMREW.BeginWrite;
  try
    AKey := GetStrongKey(AKey);
    try
      if AKey.IsEmpty then
        Exit;
      if FCache = nil then
        FCache := TDictionary<String, IInterface>.Create;
      FCache.AddOrSetValue(AKey, ACalcResult);
    except
      on E: Exception do
        raise;
    end;
  finally
    FMREW.EndWrite;
  end;
end;

class procedure TControllerFaturamentoInterfacesCache.ClearCache;
begin
  FMREW.BeginWrite;
  try
    FreeAndNil(FCache);
  finally
    FMREW.EndWrite;
  end;
end;

class function TControllerFaturamentoInterfacesCache.GetInterfaceKey
  (ACalcParam: IInterface; AMD5: Boolean = True): String;
const
  IGNORE_METHODS: String = 'new,destroy,newinstance,classtype,gethashcode,' +
    'tostring,classname,classparent,classinfo,instancesize,' +
    'qualifiedclassname,getinterfacetable,unitname,unitscope';
var
  LCTX: TRttiContext;
  LRTT: TRttiType;
  LRTM: TRttiMethod;
  LAux: String;
begin
  Result := EmptyStr;
  if not Assigned(ACalcParam) then
    Exit;
  LCTX := TRttiContext.Create;
  try
    LRTT := LCTX.GetType((ACalcParam as TObject).ClassType);
    for LRTM in LRTT.GetMethods do
    begin
      if (Length(LRTM.GetParameters) <> 0) then
        Continue;

      if Pos(LRTM.Name.ToLower, IGNORE_METHODS) <> 0 then
        Continue;

      if not LRTM.ToString.ToLower.Contains('function') then
        Continue;

      LAux := GetValueText(LRTM.Invoke((ACalcParam as TObject), []));

      if not Result.IsEmpty then
        Result := Result + ',';

      Result := Result + Format('"%s": %s', [LRTM.Name, LAux]);
    end;
    Result := Format('{"%s":{%s}}', [(ACalcParam as TObject).ClassName,
      Result]);
    if AMD5 then
      Result := TCoreFuncoes.GetMD5(Result);
  finally
    LCTX.Free;
  end;
end;

class function TControllerFaturamentoInterfacesCache.GetObjectFields(AValue: TValue): String;
var
  LCTX: TRttiContext;
  LRTT: TRttiType;
  LRTF: TRttiField;
  LAux: String;
begin
  Result := EmptyStr;
  if AValue.IsEmpty then
    Exit;
  if AValue.IsObject then
    Exit();
  LCTX := TRttiContext.Create;
  try
    LRTT := LCTX.GetType(AValue.AsObject.ClassType);
    for LRTF in LRTT.GetFields do
    begin
      LAux := GetValueText(LRTF.GetValue(AValue.AsObject));
      if not Result.IsEmpty then
        Result := Result + ',';
      Result := Result + Format('"%s": %s', [LRTF.Name, LAux]);
    end;
    Result := Format('{"%s":{%s}}', [AValue.AsObject.ClassName, Result]);
  finally
    LCTX.Free;
  end;
end;

class function TControllerFaturamentoInterfacesCache.GetRecordFields(AValue: TValue): String;
var
  LCTX: TRttiContext;
  LRTT: TRttiType;
  LRTF: TRttiField;
  LAux: String;
begin
  Result := EmptyStr;
  if AValue.IsEmpty then
    Exit;
  if AValue.Kind <> tkRecord then
    Exit;
  LCTX := TRttiContext.Create;
  try
    LRTT := LCTX.GetType(AValue.TypeInfo);
    for LRTF in LRTT.GetFields do
    begin
      LAux := GetValueText(LRTF.GetValue(AValue.GetReferenceToRawData));
      if not Result.IsEmpty then
        Result := Result + ',';
      Result := Result + Format('"%s": %s', [LRTF.Name, LAux]);
    end;
    Result := Format('{"%s":{%s}}', [AValue.TypeInfo.Name, Result]);
  finally
    LCTX.Free;
  end;
end;

class function TControllerFaturamentoInterfacesCache.GetStrongKey
  (AKey: String): String;
var
  LParComumKey: String;
  LParComumFcpDifalKey: String;
begin
  LParComumKey := Self.GetInterfaceKey(GetImpostosFatParametrosComum);
  LParComumFcpDifalKey := Self.GetInterfaceKey
    (GetImpostosFatParametrosComumFcpDifal);
  Result := Format('[%s,%s,%s]', [LParComumKey, LParComumFcpDifalKey, AKey]);
end;

class function TControllerFaturamentoInterfacesCache.GetValueText(AValue: TValue): String;
var
  LIndex: Integer;
begin
  if AValue.Kind = tkInterface then
  begin
    if not AValue.IsEmpty then
      Result := TControllerFaturamentoInterfacesCache.GetInterfaceKey
        (AValue.AsInterface, False)
    else
      Result := '"nil"';
  end
  else if AValue.Kind = tkRecord then
  begin
    Result := GetRecordFields(AValue);
  end
  else if AValue.Kind = tkDynArray then
  begin
    Result := '[';
    for LIndex := 0 to AValue.GetArrayLength-1 do
    begin
      if not Result.Equals('[') then
        Result := Result + ', ';
      Result := Result + GetValueText(AValue.GetArrayElement(LIndex));
    end;
    Result := Result + ']';
  end
  else if AValue.IsObject then
  begin
    if not AValue.IsEmpty then
      Result := GetObjectFields(AValue)
    else
      Result := '"nil"';
  end
  else
    Result := '"' + AValue.ToString + '"';
end;

class function TControllerFaturamentoInterfacesCache.TryGetCache<R>
  (AKey: String; out ACalcResult: R): Boolean;
var
  LResult: IInterface;
begin
  FMREW.BeginRead;
  try
    AKey := GetStrongKey(AKey);
    try
      if AKey.IsEmpty then
        Exit(False);
      if FCache = nil then
        FCache := TDictionary<String, IInterface>.Create;
      Result := FCache.TryGetValue(AKey, LResult);
      ACalcResult := nil;
      if Result then
        ACalcResult := R(LResult);
    except
      on E: Exception do
        Result := False;
    end;
  finally
    FMREW.EndRead;
  end;
end;

class function TControllerFaturamentoInterfacesCache.TryGetCache<R>
  (ACalcParam: IInterface; out ACalcResult: R): Boolean;
begin
  Result := TryGetCache(Self.GetInterfaceKey(ACalcParam), ACalcResult);
end;

initialization

TControllerFaturamentoInterfacesCache.FMREW := TMultiReadExclusiveWriteSynchronizer.Create;

finalization

TControllerFaturamentoInterfacesCache.FMREW.Free;

end.
