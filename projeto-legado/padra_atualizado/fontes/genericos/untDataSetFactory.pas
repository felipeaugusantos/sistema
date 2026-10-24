unit untDataSetFactory;

interface

uses
  untAbstractDataSetFactory, DB, Classes, SysUtils, untIDataSetFactory;

type
  TAbstractDataSetFactoryClass = class of TAbstractDataSetFactory;

  TDataSetFactory = class(TInterfacedObject)
  private
    class var stlClasses: TStringList;
    class function GetStlClasses(): TStringList;
    class procedure Limpar;

    type
      TAbstractDataSetFactoryClassWrapper = class(TInterfacedObject)
      public
        dataSetFactoryClass: TAbstractDataSetFactoryClass;
        constructor Create(dataSetFactoryClass: TAbstractDataSetFactoryClass); 
      end;
  public
    class function GetIDataSet(const strIdentificador: string): IDataSetFactory;
    class procedure Registrar(const strIdentificador: string; const dataSetFactoryClass: TAbstractDataSetFactoryClass);
    class procedure DesRegistrar(const strIdentificador: string);
  end;

implementation

{ TDataSetFactory }

class procedure TDataSetFactory.DesRegistrar(const strIdentificador: string);
var
  intIndex: Integer;
begin
  intIndex := GetStlClasses.IndexOf(strIdentificador);
  if intIndex >= 0 then
  begin
    GetStlClasses.Objects[intIndex].Free;
    GetStlClasses.Delete(intIndex);
  end;
end;

class function TDataSetFactory.GetIDataSet(const strIdentificador: string): IDataSetFactory;
var
  intIndex: Integer;
begin
  Result := nil;
  intIndex := GetStlClasses.IndexOf(strIdentificador);
  if intIndex >= 0 then
  begin
    Result := ((GetStlClasses.Objects[intIndex] as TAbstractDataSetFactoryClassWrapper).dataSetFactoryClass.Create) as IDataSetFactory;
  end;
end;

class function TDataSetFactory.GetStlClasses: TStringList;
begin
  if not Assigned(stlClasses) then
  begin
    stlClasses := TStringList.Create;
    stlClasses.Sorted := True;
    stlClasses.Duplicates := dupIgnore;
  end;

  Result := stlClasses;
end;

class procedure TDataSetFactory.Limpar;
var
  intIndex: Integer;
begin
  for intIndex := GetStlClasses.Count - 1 downto 0 do
  begin
    GetStlClasses.Objects[intIndex].Free;
  end;  
    
end;

class procedure TDataSetFactory.Registrar(const strIdentificador: string; const dataSetFactoryClass: TAbstractDataSetFactoryClass);
begin  
  GetStlClasses.AddObject(strIdentificador, TAbstractDataSetFactoryClassWrapper.Create(dataSetFactoryClass));
end;

{ TDataSetFactory.TAbstractDataSetFactoryClassWrapper }

constructor TDataSetFactory.TAbstractDataSetFactoryClassWrapper.Create(dataSetFactoryClass: TAbstractDataSetFactoryClass);
begin
  inherited Create();
  Self.dataSetFactoryClass := dataSetFactoryClass;
end;

initialization
  TDataSetFactory.stlClasses := nil;

finalization
  if Assigned(TDataSetFactory.stlClasses) then
  begin
    TDataSetFactory.Limpar;
    FreeAndNil(TDataSetFactory.stlClasses);
  end;

end.

