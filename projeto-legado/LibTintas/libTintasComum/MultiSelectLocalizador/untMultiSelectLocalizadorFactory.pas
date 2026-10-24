unit untMultiSelectLocalizadorFactory;

interface

uses
  untMultiSelectLocalizador, Classes, SysUtils, untIMultiSelectLocalizador;

type
  TMultiSelectLocalizadorFactory = class(TInterfacedObject)
  private
    class var stlClasses: TStringList;
    class function GetSqlClasses: TStringList;
  public
    class procedure RegistrarClasse(const strIdentificador: string; const multiSelectLocalizadorClass: TMultiSelectLocalizadorClass);
    class function GetLocalizador(const strIdentificador: string): IMultiSelectLocalizador;
  end;

implementation

type
  TMultiSelectLocalizadorClassWrapper = class(TInterfacedObject)
  private
    multiSelectLocalizadorClass: TMultiSelectLocalizadorClass;
  public
    constructor Create(multiSelectLocalizadorClass: TMultiSelectLocalizadorClass);
    function GetMultiSelectLocalizadorClass: TMultiSelectLocalizadorClass;
  end;

{ TMultiSelectLocalizadorFactory }

class function TMultiSelectLocalizadorFactory.GetLocalizador(const strIdentificador: string): IMultiSelectLocalizador;
var
  intIndex: Integer;
  objResult: TMultiSelectLocalizadorClassWrapper;
begin
  Result := nil;
  intIndex := GetSqlClasses.IndexOf(strIdentificador);
  if intIndex >= 0 then
  begin
    objResult := GetSqlClasses.Objects[intIndex] as TMultiSelectLocalizadorClassWrapper;
    Supports(objResult.GetMultiSelectLocalizadorClass.Create, IMultiSelectLocalizador, Result);
  end;
end;

class function TMultiSelectLocalizadorFactory.GetSqlClasses: TStringList;
begin
  if not Assigned(stlClasses) then
  begin
    stlClasses := TStringList.Create;
  end;

  Result := stlClasses;
end;

class procedure TMultiSelectLocalizadorFactory.RegistrarClasse(const strIdentificador: string;
  const multiSelectLocalizadorClass: TMultiSelectLocalizadorClass);
begin
  GetSqlClasses.AddObject(strIdentificador, TMultiSelectLocalizadorClassWrapper.Create(multiSelectLocalizadorClass));
end;

{ TMultiSelectLocalizadorClassWrapper }

constructor TMultiSelectLocalizadorClassWrapper.Create(multiSelectLocalizadorClass: TMultiSelectLocalizadorClass);
begin
  inherited Create();
  Self.multiSelectLocalizadorClass := multiSelectLocalizadorClass;
end;

function TMultiSelectLocalizadorClassWrapper.GetMultiSelectLocalizadorClass: TMultiSelectLocalizadorClass;
begin
  Result := multiSelectLocalizadorClass;
end;

initialization
  TMultiSelectLocalizadorFactory.stlClasses := nil;

finalization

  if Assigned(TMultiSelectLocalizadorFactory.stlClasses) then FreeAndNil(TMultiSelectLocalizadorFactory.stlClasses);

end.

