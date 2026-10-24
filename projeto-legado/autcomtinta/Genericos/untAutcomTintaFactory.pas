unit untAutcomTintaFactory;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
  Shared.Core,
{$ELSE}
  untFuncoesSimples,
{$ENDIF}
  SysUtils,
  Classes,
  untIAutcomTinta,
  untAbstractAutcomTinta;

type
  TAutcomTintaFactory = class(TInterfacedObject)
  private
    class var stlTintas: TStringList;
    class function GetTintas(): TStringList;
    class var dicTintas: TDicionario;
    class function GetIAutcomTintaInterna(const strIdePro: string): TAbstractAutcomTinta;
    class procedure Limpar;
  public
    class function GetIAutcomTinta(const strIdePro: string): IAutcomTinta;
    class procedure Registrar(const strIdePro: string; const abstractAutcomTinta: TAbstractAutcomTintaClass);
  end;

  TAbstractAutcomTintaClassWrapper = class(TInterfacedObject)
  private
    autcomTinta: TAbstractAutcomTintaClass;
  public
    constructor Create(const autcomTinta: TAbstractAutcomTintaClass);
    property AbstractAutcomTinta: TAbstractAutcomTintaClass read autcomTinta;
  end;

implementation


{ TAutcomTintaFactory }

class function TAutcomTintaFactory.GetIAutcomTinta(const strIdePro: string): IAutcomTinta;
var
  objTinta: TObject;
begin
  Result := nil;
  if not Assigned(dicTintas) then
    dicTintas := TDicionario.Create;

  if not Assigned(dicTintas.RetornaObjeto(strIdePro)) then
  begin
    objTinta := GetIAutcomTintaInterna(strIdePro);

    if not Assigned(objTinta) then
    begin
      if GetTintas.IndexOf(strIdePro) >= 0 then
        objTinta := TAbstractAutcomTintaClassWrapper(GetTintas.Objects[GetTintas.IndexOf(strIdePro)]).AbstractAutcomTinta.Create      
    end;   

    dicTintas.AdicionarObjeto(strIdePro, objTinta);
  end;

  objTinta := dicTintas.RetornaObjeto(strIdePro);

  if Supports(objTinta, IAutcomTinta, Result) then
    Result._AddRef;
end;

class function TAutcomTintaFactory.GetIAutcomTintaInterna(const strIdePro: string): TAbstractAutcomTinta;
begin
  Result := nil;
end;

class function TAutcomTintaFactory.GetTintas: TStringList;
begin
  if not Assigned(stlTintas) then
    stlTintas := TStringList.Create;

  Result := stlTintas; 
end;

class procedure TAutcomTintaFactory.Limpar;
var
  intCont: Integer;
begin
  for intCont := 0 to stlTintas.Count - 1 do
    stlTintas.Objects[intCont].Free;    
end;

class procedure TAutcomTintaFactory.Registrar(const strIdePro: string; const abstractAutcomTinta: TAbstractAutcomTintaClass);
begin
  GetTintas.AddObject(strIdePro, TAbstractAutcomTintaClassWrapper.Create(abstractAutcomTinta));
end;

{ TAbstractAutcomTintaClassWrapper }

constructor TAbstractAutcomTintaClassWrapper.Create(const autcomTinta: TAbstractAutcomTintaClass);
begin
  inherited Create();
  Self.autcomTinta := autcomTinta;
end;

initialization
  TAutcomTintaFactory.dicTintas := nil;
  TAutcomTintaFactory.stlTintas := nil;

finalization
  if Assigned(TAutcomTintaFactory.stlTintas) then
  begin
    TAutcomTintaFactory.Limpar;
    FreeAndNil(TAutcomTintaFactory.stlTintas);
  end;

//  if Assigned(TAutcomTintaFactory.dicTintas) then FreeAndNil(TAutcomTintaFactory.dicTintas);

end.
