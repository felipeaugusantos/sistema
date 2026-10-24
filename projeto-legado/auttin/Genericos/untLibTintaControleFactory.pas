unit untLibTintaControleFactory;

interface

uses
  Controls, untILibTintaControleVisual, Classes, SysUtils, untILibTintaControleFactory;

type
  TLibTintaControleFactoryObjectWrapper = class(TInterfacedObject)
  public
    classeControle: ILibTintaControleFactory;
    constructor Create(const classeControle: ILibTintaControleFactory);
  end;
  
  TLibTintaControleFactory = class(TInterfacedObject)
  private
    class var stlClasses: TStringList;
    class function GetClasses(): TStringList;
    class procedure Limpar;
  public
    class procedure Registrar(const strIdentificador: string; const classeControle: ILibTintaControleFactory);
    class function GetControl(const controle: ILibTintaControleVisual; const parent: TControl;
      const telaCadLibTintas: ITelaCadLibTintas): TControl;
  end;

implementation

{ TLibTintaControleFactory }

class function TLibTintaControleFactory.GetClasses: TStringList;
begin
  if not Assigned(stlClasses) then
  begin
    stlClasses := TStringList.Create;
    stlClasses.Sorted := True;
    stlClasses.Duplicates := dupIgnore;
  end;

  Result := stlClasses;   
end;

class function TLibTintaControleFactory.GetControl(const controle: ILibTintaControleVisual; const parent: TControl;
  const telaCadLibTintas: ITelaCadLibTintas): TControl;
var
  intIndex: Integer;
begin
  intIndex := GetClasses.IndexOf(controle.Classe);
  if intIndex >= 0 then
    Result := TLibTintaControleFactoryObjectWrapper(GetClasses.Objects[intIndex]).classeControle.GetControle(controle, parent, telaCadLibTintas)
  else
    raise Exception.CreateFmt('Não existe classe registrada para criar controles do tipo [%s]', [controle.Classe]);
end;

class procedure TLibTintaControleFactory.Limpar;
var
  intCont: Integer;
begin
  for intCont := 0 to stlClasses.Count - 1 do
  begin
    stlClasses.Objects[intCont].Free;
  end;
end;

class procedure TLibTintaControleFactory.Registrar(const strIdentificador: string; const classeControle: ILibTintaControleFactory);
begin
  GetClasses.AddObject(strIdentificador, TLibTintaControleFactoryObjectWrapper.Create(classeControle));
end;

{ TLibTintaControleFactoryObjectWrapper }

constructor TLibTintaControleFactoryObjectWrapper.Create(const classeControle: ILibTintaControleFactory);
begin
  inherited Create();
  Self.classeControle := classeControle;
end;

initialization
  TLibTintaControleFactory.stlClasses := nil;

finalization
  if Assigned(TLibTintaControleFactory.stlClasses) then
  begin
    TLibTintaControleFactory.Limpar;
    FreeAndNil(TLibTintaControleFactory.stlClasses);
  end;


end.
