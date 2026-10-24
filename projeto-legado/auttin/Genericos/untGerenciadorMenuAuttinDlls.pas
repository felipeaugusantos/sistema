unit untGerenciadorMenuAuttinDlls;

interface

uses
  untIAuttinMenuItem, Classes, SysUtils;

type
  TAuttinMenuItemContainer = class
  strict private
    amiMenu: IAuttinMenuItem;
  public
    constructor Create(const amiMenu: IAuttinMenuItem);
    property Menu: IAuttinMenuItem read amiMenu;
  end;

  TGerenciadorMenuAuttinDlls = class(TInterfacedObject)
  private
    class var stlMenus: TStringList;
    class function GetStlMenus: TStringList;
  public
    class procedure DesRegistrar;
    class procedure Registrar(const strNomeMenu: string; const menu: IAuttinMenuItem);
    class function Get(const strNomeMenu: string): IAuttinMenuItem;
  end;

implementation


{ TGerenciadorMenuAuttinDlls }

class function TGerenciadorMenuAuttinDlls.Get(const strNomeMenu: string): IAuttinMenuItem;
var
  intIndex: Integer;
begin
  Result := nil;
  intIndex := GetStlMenus.IndexOf(strNomeMenu);
  if intIndex >= 0 then
    Result := TAuttinMenuItemContainer(GetStlMenus.Objects[intIndex]).Menu;
end;

class function TGerenciadorMenuAuttinDlls.GetStlMenus: TStringList;
begin
  if not Assigned(stlMenus) then
  begin
    stlMenus := TStringList.Create;
    stlMenus.Sorted := True;
  end;

  Result := stlMenus;
end;

class procedure TGerenciadorMenuAuttinDlls.DesRegistrar;
begin
  if Assigned(stlMenus) then
  begin
    stlMenus.Clear;
  end;
end;

class procedure TGerenciadorMenuAuttinDlls.Registrar(const strNomeMenu: string; const menu: IAuttinMenuItem);
begin
  if GetStlMenus.IndexOf(strNomeMenu) < 0 then
    GetStlMenus.AddObject(strNomeMenu, TAuttinMenuItemContainer.Create(menu));
end;

{ TAuttinMenuItemContainer }

constructor TAuttinMenuItemContainer.Create(const amiMenu: IAuttinMenuItem);
begin
  inherited Create();
  Self.amiMenu := amiMenu;
end;

initialization
  TGerenciadorMenuAuttinDlls.stlMenus := nil;

finalization
  if Assigned(TGerenciadorMenuAuttinDlls.stlMenus) then
    FreeAndNil(TGerenciadorMenuAuttinDlls.stlMenus);

end.
