unit Contabilidade.Classes.TMenuContabilidade;

interface

uses System.Generics.Collections, Vcl.Menus, System.Classes, System.SysUtils ;

type
  TProcMenuContabil = procedure(Sender: TObject) of object;

  TInfoMenuContabil = class
  strict private
    FNome       : string  ;
    FCaption    : string  ;
    FHint       : string  ;
    FHabilitado : boolean ;
    FProcOnCLick : TProcMenuContabil ;
    FSubmenu : TObjectList<TInfoMenuContabil> ;
  public
    property Nome       : string  read FNome write FNome  ;
    property Caption    : string  read FCaption write FCaption  ;
    property Hint       : string  read FHint write FHint  ;
    property Habilitado : boolean read FHabilitado write FHabilitado  ;
    property ProcOnCLick : TProcMenuContabil read FProcOnCLick write FProcOnCLick  ;
    property Submenu : TObjectList<TInfoMenuContabil> read FSubmenu write FSubmenu  ;
  end;

  TMenuContabil = class
  strict private
    FLstMenuContabil: TObjectList<TInfoMenuContabil> ;
    FRootMenu: TMenuItem ;
    function ProcuraPai(ANome:String; ASubMenu:TObjectList<TInfoMenuContabil>):TInfoMenuContabil ;
    function AdicionaMenu(AInfoMenu: TObjectList<TInfoMenuContabil>; AMenu: TMenuItem; AOwner: TComponent):TMenuItem ;
    procedure LimpaLstMenuContabil(AInfoMenu: TObjectList<TInfoMenuContabil>) ;
  public
    property RootMenu: TMenuItem read FRootMenu write FRootMenu ;
    function AdicionarMenuContabil(const ANome, ACaption, AHint: string; AProcOnClick: TProcMenuContabil = nil; ANomePai: string = ''; AHabilitado: Boolean = True): TInfoMenuContabil ;
    procedure CriarMenu(AOwner: TComponent) ;
    constructor Create ;
    destructor Destroy ; override ;
  end;

implementation

uses untFuncoesSimples ;

{ TMenuContabil }

function TMenuContabil.AdicionaMenu(AInfoMenu: TObjectList<TInfoMenuContabil>; AMenu: TMenuItem; AOwner: TComponent): TMenuItem;
var
  LItem : TInfoMenuContabil ;
  mnuCont : TMenuItem ;
begin
  Result := Nil ;
  if not Assigned(AInfoMenu) then
  begin
    exit ;
  end;

  for LItem in AInfoMenu do
  begin
    mnuCont := TMenuItem.Create(AOwner) ;
    mnuCont.Caption := LItem.Caption ;
    mnuCont.Hint := LItem.Hint ;
    mnuCont.Name := LItem.Nome ;
    mnuCont.Enabled := LItem.Habilitado ;
    mnuCont.OnClick := LItem.ProcOnCLick ;
    AMenu.Add(mnuCont);
    Result := mnuCont ;

    if Assigned(LItem.Submenu) then
    begin
      AdicionaMenu(LItem.Submenu, mnuCont, AOwner) ;
    end;

  end;

end;

function TMenuContabil.AdicionarMenuContabil(const ANome, ACaption,
  AHint: string; AProcOnClick: TProcMenuContabil = nil; ANomePai: string = '';
  AHabilitado: Boolean = True): TInfoMenuContabil;
var
  itemMenu : TInfoMenuContabil ;
  LSubMenu : TInfoMenuContabil ;
  LLstSubMenu : TObjectList<TInfoMenuContabil> ;
begin
  if fEmptyStr(ANomePai) then
  begin
    itemMenu := TInfoMenuContabil.Create ;
    itemMenu.Nome := ANome ;
    itemMenu.Caption := ACaption ;
    itemMenu.Hint := AHint ;
    itemMenu.Habilitado := AHabilitado ;
    itemMenu.ProcOnCLick := AProcOnClick ;

    FLstMenuContabil.Add(itemMenu) ;
    Result := itemMenu ;
  end
  else
  begin
    ////procura o pai
    LSubMenu := ProcuraPai(ANomePai, FLstMenuContabil) ;
    if Assigned(LSubMenu) then
    begin
      LLstSubMenu := LSubMenu.Submenu ;
      if not Assigned(LLstSubMenu) then
      begin
        LLstSubMenu := TObjectList<TInfoMenuContabil>.Create();
        LSubMenu.Submenu := LLstSubMenu ;
      end;

      itemMenu := TInfoMenuContabil.Create ;
      itemMenu.Nome := ANome ;
      itemMenu.Caption := ACaption ;
      itemMenu.Hint := AHint ;
      itemMenu.Habilitado := AHabilitado ;
      itemMenu.ProcOnCLick := AProcOnClick ;

      LLstSubMenu.Add(itemMenu) ;

      Result := itemMenu ;
    end
    else
    begin
      raise Exception.Create('Menu Pai ['+ANomePai+'] não encontrado!');
    end;
  end;

end;

constructor TMenuContabil.Create;
begin
  FLstMenuContabil := TObjectList<TInfoMenuContabil>.Create();
end;

procedure TMenuContabil.CriarMenu(AOwner: TComponent);
begin
  AdicionaMenu(FLstMenuContabil, FRootMenu, AOwner) ;
end;

destructor TMenuContabil.Destroy;
begin
  LimpaLstMenuContabil(FLstMenuContabil) ;
  FreeAndNil(FLstMenuContabil) ;
  inherited;
end;

procedure TMenuContabil.LimpaLstMenuContabil(
  AInfoMenu: TObjectList<TInfoMenuContabil>);
var
  LItem: TInfoMenuContabil ;
begin
  if not Assigned(AInfoMenu) then
  begin
    exit ;
  end;

  for LItem in AInfoMenu do
  begin
    if Assigned(LItem.Submenu) then
    begin
      LimpaLstMenuContabil(LItem.Submenu) ;
      LItem.Submenu.Free ;
      LItem.Submenu := nil ;
    end;
  end;

end;

function TMenuContabil.ProcuraPai(ANome: String; ASubMenu: TObjectList<TInfoMenuContabil>): TInfoMenuContabil ;
var
  Item : TInfoMenuContabil ;
begin
  Result := Nil ;
  if not Assigned(ASubMenu) then
  begin
    exit ;
  end;

  for Item in ASubMenu do
  begin
    if Item.Nome = ANome then
    begin
      result := Item ;
      break ;
    end
    else
    begin
      result := ProcuraPai(ANome, Item.Submenu) ;
    end;
  end;
end;

end.
