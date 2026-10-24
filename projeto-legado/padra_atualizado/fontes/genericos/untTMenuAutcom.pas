unit untTMenuAutcom;

interface

uses
  System.SysUtils, Uni, Principal.View.Interfaces, Data.DB, System.StrUtils,
  System.Classes, System.Generics.Collections, AdvMenus, Vcl.Forms,
  Menus, untFramePesquisarMenu;

type
  TObservadorMenuItem = class(TComponent)
  private
    FMenuItem: TMenuItem;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(const AMenuItem: TMenuItem); reintroduce;
    destructor Destroy; override;
    property MenuItem: TMenuItem Read FMenuItem;
  end;

  TItemMenuAutcom = class(TInterfacedObject, IItemMenuAutcom)
  private
    FCaption: String;
    FCaptionOriginal: String;
    FName: String;
    FHint: String;
    FMenuItem: TMenuItem;
    FObservador: TObservadorMenuItem;
    FItems: TList<IItemMenuAutcom>;
    function fRetornaMenuItem: TMenuItem;
  protected
    constructor Create(AItem: TMenuItem; const AObservarDestruicao: Boolean);
  public
    destructor Destroy; override;
    class function New(AItem: TMenuItem; const AObservarDestruicao: Boolean): IItemMenuAutcom;
    function Name: String;
    function Caption: String;
    function SetCaption(AValue: String): IItemMenuAutcom;
    function Hint: String;
    function Visible: Boolean;
    function Favorito: Boolean;
    procedure ExecutarClick();
    procedure EditarPermissoesAcesso();
    function Items: TList<IItemMenuAutcom>;
    function Find(AName: String): IItemMenuAutcom;
    function Enabled: Boolean;
  end;

  TFavoritosAutcom = class(TInterfacedObject, IFavoritosAutcom)
  private
    FItems: TList<IItemMenuAutcom>;
    FMenuFavoritos: TMenuFavoritos;
    procedure LoadItems(APopup: TAdvPopupMenu);
  protected
    constructor Create(APopup: TAdvPopupMenu);
  public
    destructor Destroy; override;
    class function New(APopup: TAdvPopupMenu): IFavoritosAutcom;
    function Items: TList<IItemMenuAutcom>;
    procedure AdicionarFavorito(LMenu, LDescricao: String);
    procedure RemoverFavorito(LMenu, LDescricao: String);
  end;

  TRecentesAutcom = class(TInterfacedObject, IRecentesAutcom)
  private
    FItems: TList<IItemMenuAutcom>;
    procedure LoadItems(APopup: TAdvPopupMenu);
  protected
    constructor Create(APopup: TAdvPopupMenu);
  public
    destructor Destroy; override;
    class function New(APopup: TAdvPopupMenu): IRecentesAutcom;
    function Items: TList<IItemMenuAutcom>;
  end;

  TResultadoPesquisaAutcom = class(TInterfacedObject, IResultadoPesquisaAutcom)
  private
    FItems: TList<IItemMenuAutcom>;
  protected
    constructor Create();
  public
    destructor Destroy; override;
    class function New(): IResultadoPesquisaAutcom;
    function Items: TList<IItemMenuAutcom>;
  end;

  TMenuAutcom = class(TInterfacedObject, IMenuAutcom)
  private
    FItems: TList<IItemMenuAutcom>;
    procedure LoadItems(AItemMenu: TMenuItem; AParent: IItemMenuAutcom); overload;
    procedure LoadItems(AMainMenu: TAdvMainMenu); overload;
    procedure LoadItems(AMainMenu: TAdvPopupMenu); overload;
  protected
    constructor Create(AMainMenu: TAdvMainMenu); overload;
    constructor Create(AMainMenu: TAdvPopupMenu); overload;
  public
    destructor Destroy; override;
    class function New(AMainMenu: TAdvMainMenu): IMenuAutcom;
    class function NewPopup(AMainMenu: TAdvPopupMenu): IMenuAutcom;
    function Items: TList<IItemMenuAutcom>;
    function Find(AName: String): IItemMenuAutcom;
  end;

implementation

uses
  untFuncoesSimples, untPermissaoAcesso;

{ TObservadorMenuItem }

constructor TObservadorMenuItem.Create(const AMenuItem: TMenuItem);
begin
  inherited Create(Nil);
  FMenuItem := AMenuItem;

  If Assigned(FMenuItem) Then
    FMenuItem.FreeNotification(Self);
end;

destructor TObservadorMenuItem.Destroy;
begin
  Try
    If Assigned(FMenuItem) Then
      FMenuItem.RemoveFreeNotification(Self);
  Finally
    inherited;
  End;
end;

procedure TObservadorMenuItem.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;

  If (Operation = opRemove) And (AComponent = FMenuItem) Then
    FMenuItem := Nil;
end;

{ TMenuAutcom }

constructor TMenuAutcom.Create(AMainMenu: TAdvMainMenu);
begin
  LoadItems(AMainMenu);
end;

constructor TMenuAutcom.Create(AMainMenu: TAdvPopupMenu);
begin
  LoadItems(AMainMenu);
end;

destructor TMenuAutcom.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

function TMenuAutcom.Find(AName: String): IItemMenuAutcom;
Var
  LItem: IItemMenuAutcom;
begin
  Result := nil;
  For LItem In FItems Do
  Begin
    Result := LItem.Find(AName);
    If Assigned(Result) Then
      Break;
  End;
end;

function TMenuAutcom.Items: TList<IItemMenuAutcom>;
begin
  Result := FItems;
end;

procedure TMenuAutcom.LoadItems(AMainMenu: TAdvPopupMenu);
Var
  LItem: TMenuItem;
  LParent: IItemMenuAutcom;
begin
  FItems := TList<IItemMenuAutcom>.Create;
  For LItem In AMainMenu.Items Do
  Begin
    LParent := TItemMenuAutcom.New(LItem, False);
    FItems.Add(LParent);
    LoadItems(LItem, LParent);
  End;
end;

procedure TMenuAutcom.LoadItems(AItemMenu: TMenuItem; AParent: IItemMenuAutcom);
Var
  LItem: TMenuItem;
  LChild: IItemMenuAutcom;
begin
  If Not Assigned(AItemMenu) Then
    Exit;

  For LItem In AItemMenu Do
  Begin
    LChild := TItemMenuAutcom.New(LItem, False);

    AParent.Items.Add(LChild);

    LoadItems(LItem, LChild);
  End;
end;

procedure TMenuAutcom.LoadItems(AMainMenu: TAdvMainMenu);
Var
  LItem: TMenuItem;
  LParent: IItemMenuAutcom;
begin
  FItems := TList<IItemMenuAutcom>.Create;
  For LItem In AMainMenu.Items Do
  Begin
    LParent := TItemMenuAutcom.New(LItem, False);
    FItems.Add(LParent);
    LoadItems(LItem, LParent);
  End;
end;

class function TMenuAutcom.New(AMainMenu: TAdvMainMenu): IMenuAutcom;
begin
  Result := Self.Create(AMainMenu);
end;

class function TMenuAutcom.NewPopup(AMainMenu: TAdvPopupMenu): IMenuAutcom;
begin
  Result := Self.Create(AMainMenu);
end;

{ TItemMenuAutcom }

function TItemMenuAutcom.Caption: String;
begin
  If FCaption = '' Then
    Result := FCaptionOriginal
  Else
    Result := FCaption;
end;

constructor TItemMenuAutcom.Create(AItem: TMenuItem; const AObservarDestruicao: Boolean);
begin
  FItems := TList<IItemMenuAutcom>.Create;
  FCaption := '';

  If AObservarDestruicao Then
    FObservador := TObservadorMenuItem.Create(AItem)
  Else
    FMenuItem := AItem;

  If Assigned(AItem) Then
  Begin
    FCaptionOriginal := AItem.Caption;
    FName            := AItem.Name;
    FHint            := AItem.Hint;
  End;
end;

destructor TItemMenuAutcom.Destroy;
begin
  Try
    FreeAndNil(FItems);
    If Assigned(FObservador) Then
      FreeAndNil(FObservador);
  Finally
    inherited;
  End;
end;

function TItemMenuAutcom.fRetornaMenuItem: TMenuItem;
begin
  If Assigned(FObservador) Then
    Result := FObservador.MenuItem
  Else
    Result := FMenuItem;
end;

function TItemMenuAutcom.Favorito: Boolean;
Var
  LCount    : Integer;
  LPathMenu : String;
  LValue    : String;
  LMenuItem : TMenuItem;
begin
  Result    := False;
  LMenuItem := fRetornaMenuItem;

  If Not Assigned(LMenuItem) Then
    Exit;

  LPathMenu := fGetMenuPath(LMenuItem);

  LCount := 0;

  If (Assigned(dicMnuFavoritos)) Then
  Begin
    If (dicMnuFavoritos.TryGetValue(LPathMenu, LValue)) Then
      If (LValue = FName) Then
        LCount := 1;
  End
  Else
  Begin
    LCount := fCampoTabela('COUNT(*) AS QTDE', 'MNUFAV',
                          ['FAV_DESMNU','FAV_NOMMNU'   ,'FAV_CODOPE'          ,'FAV_CODEMP'],
                          [LPathMenu   , FName         , strLoginUsuarioLogado, VS_strCodEmp]);
  End;

  Result := LCount > 0;
end;

function TItemMenuAutcom.Find(AName: String): IItemMenuAutcom;
Var
  LItem: IItemMenuAutcom;
begin
  Result := nil;

  If Self.Name = AName Then
    Exit(Self);

  For LItem In FItems Do
  Begin
    If LItem.Name = AName Then
      Exit(LItem);

    Result := LItem.Find(AName);

    If Assigned(Result) Then
      Break;
  End;
end;

function TItemMenuAutcom.Hint: String;
begin
  Result := FHint;
end;

function TItemMenuAutcom.Items: TList<IItemMenuAutcom>;
begin
  Result := FItems;
end;

function TItemMenuAutcom.Name: String;
begin
  Result := FName;
end;

class function TItemMenuAutcom.New(AItem: TMenuItem; const AObservarDestruicao: Boolean): IItemMenuAutcom;
begin
  Result := Self.Create(AItem, AObservarDestruicao);
end;

function TItemMenuAutcom.SetCaption(AValue: String): IItemMenuAutcom;
begin
  FCaption := AValue;
  Result := Self;
end;

procedure TItemMenuAutcom.ExecutarClick();
Var
  LMenuItem: TMenuItem;
begin
  LMenuItem := fRetornaMenuItem;

  If Not Assigned(LMenuItem) Then
    Exit;

  If LMenuItem.Enabled Then
  Begin
    If Assigned(LMenuItem.OnClick) Then
      LMenuItem.OnClick(LMenuItem);
  End;
end;

procedure TItemMenuAutcom.EditarPermissoesAcesso;
begin
  If FItems.Count = 0 Then
    TfrmPermissaoAcesso.EditarPermissoes(FHint)
  Else
    TfrmPermissaoAcesso.LiberarAcessoSubrotinas(FHint);
end;

function TItemMenuAutcom.Enabled: Boolean;
Var
  LMenuItem: TMenuItem;
begin
  Result    := False;
  LMenuItem := fRetornaMenuItem;

  If Assigned(LMenuItem) Then
    Result := LMenuItem.Enabled;
end;

function TItemMenuAutcom.Visible: Boolean;
Var
  LMenuItem: TMenuItem;
begin
  Result    := False;
  LMenuItem := fRetornaMenuItem;

  If Assigned(LMenuItem) Then
    Result := LMenuItem.Visible;
end;

{ TFavoritosAutcom }

procedure TFavoritosAutcom.AdicionarFavorito(LMenu, LDescricao: String);
begin
  FMenuFavoritos.pAdicionarFavorito(LMenu, LDescricao);
end;

constructor TFavoritosAutcom.Create(APopup: TAdvPopupMenu);
begin
  FMenuFavoritos := TMenuFavoritos.Create;
  LoadItems(APopup);
end;

destructor TFavoritosAutcom.Destroy;
begin
  FreeAndNil(FItems);
  FreeAndNil(FMenuFavoritos);
  inherited;
end;

function TFavoritosAutcom.Items: TList<IItemMenuAutcom>;
begin
  Result := FItems;
end;

procedure TFavoritosAutcom.LoadItems(APopup: TAdvPopupMenu);
Var
  LItem: TMenuItem;
  LItemNew: IItemMenuAutcom;
begin
  FItems := TList<IItemMenuAutcom>.Create;
  For LItem In APopup.Items Do
  Begin
    LItemNew := TItemMenuAutcom.New(LItem, True);
    FItems.Add(LItemNew);
  End;
end;

class function TFavoritosAutcom.New(APopup: TAdvPopupMenu): IFavoritosAutcom;
begin
  Result := Self.Create(APopup);
end;

procedure TFavoritosAutcom.RemoverFavorito(LMenu, LDescricao: String);
begin
  FMenuFavoritos.pRemoverFavorito(LMenu, LDescricao);
end;

{ TRecentesAutcom }

constructor TRecentesAutcom.Create(APopup: TAdvPopupMenu);
begin
  LoadItems(APopup);
end;

destructor TRecentesAutcom.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

function TRecentesAutcom.Items: TList<IItemMenuAutcom>;
begin
  Result := FItems;
end;

procedure TRecentesAutcom.LoadItems(APopup: TAdvPopupMenu);
Var
  LItem: TMenuItem;
  LItemNew: IItemMenuAutcom;
begin
  FItems := TList<IItemMenuAutcom>.Create;
  For LItem In APopup.Items Do
  Begin
    LItemNew := TItemMenuAutcom.New(LItem, True);
    FItems.Add(LItemNew);
  End;
end;

class function TRecentesAutcom.New(APopup: TAdvPopupMenu): IRecentesAutcom;
begin
  Result := Self.Create(APopup);
end;


{ TResultadoPesquisaAutcom }

constructor TResultadoPesquisaAutcom.Create;
begin
  FItems := TList<IItemMenuAutcom>.Create;
end;

destructor TResultadoPesquisaAutcom.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

function TResultadoPesquisaAutcom.Items: TList<IItemMenuAutcom>;
begin
  Result := FItems;
end;

class function TResultadoPesquisaAutcom.New: IResultadoPesquisaAutcom;
begin
  Result := Self.Create;
end;

end.
