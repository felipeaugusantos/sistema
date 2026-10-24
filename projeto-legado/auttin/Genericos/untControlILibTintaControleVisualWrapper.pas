{********************************************************************************************}
{* TControlILibTintaControleVisualWrapper: Classe responsavel por converter um controle     *}
{* visual que em um objeto do tipo ILibTintaControleVisual, assim outros projetos pode ter  *}
{* acesso ao controle tendo apenas conhecimento da interface ILibTintaControleVisual        *}
{****************************************************************************************PH**}
unit untControlILibTintaControleVisualWrapper;

interface

uses
  untILibTintaControleVisual, Controls, TypInfo, untILibTintaControleVisualPropriedade, Variants,
  ObjAuto, SysUtils;

type
  TControlILibTintaControleVisualWrapper = class(TInterfacedObject, ILibTintaControleVisual)
  private
    control: TControl;
    tela: ITelaCadLibTintas;
  public
    constructor Create(const control: TControl; const tela: ITelaCadLibTintas);
    function AdicionarControle(const controle: ILibTintaControleVisual): ILibTintaControleVisual;
    function AdicionarEvento(const evento: ILibTintaControleVisualEvento): ILibTintaControleVisual;
    function AdicionarPropriedade(const propriedade: ILibTintaControleVisualPropriedade): ILibTintaControleVisual;
    function GetClasse: string;
    function GetControle(const index: Integer): ILibTintaControleVisual;
    function GetControleNome(const strNome: string): ILibTintaControleVisual;
    function GetControlesCont: Integer;
    function GetEvento(const strNome: string): ILibTintaControleVisualEvento;
    function GetEventoIndex(const index: Integer): ILibTintaControleVisualEvento;
    function GetEventosCont: Integer;
    function GetNome: string;
    function GetPropriedade(const strNome: string): ILibTintaControleVisualPropriedade;
    function GetPropriedadeIndex(const index: Integer): ILibTintaControleVisualPropriedade;
    function GetPropriedadesCont: Integer;
    procedure RemoverControle(const controle: ILibTintaControleVisual);
    procedure RemoverControleIndex(const index: Integer);
    procedure RemoverControleNome(const strNome: string);
    procedure RemoverEvento(const evento: ILibTintaControleVisualEvento);
    procedure RemoverEventoIndex(const index: Integer);
    procedure RemoverEventoNome(const strNome: string);
    procedure RemoverPropriedade(const propriedade: ILibTintaControleVisualPropriedade);
    procedure RemoverPropriedadeIndex(const index: Integer);
    procedure RemoverPropriedadeNome(const strNome: string);
    function GetImplementacao: string;
  end;

  TControlLibTintaControleVisualEventoWrapper = class(TInterfacedObject, ILibTintaControleVisualEvento)
  private
    control: TControl;
    strNome: string;
    controleVisual: ILibTintaControleVisual;
    tela: ITelaCadLibTintas;
  public
    constructor Create(const control: TControl; const strNome: string);
    function GetNome: string;
    function GetMethodAddress: Pointer;

    function GetLibTintaControleVisual: ILibTintaControleVisual;
    function GetTelaCadLibTintas: ITelaCadLibTintas;
    procedure SetLibTintaControleVisual(const value: ILibTintaControleVisual);
    procedure SetTelaCadLibTintas(const value: ITelaCadLibTintas); 
  end;

  TControlLibTintaControleVisualPropriedadeWrapper = class(TInterfacedObject, ILibTintaControleVisualPropriedade)
  private
    control: TControl;
    strNome: string;
  public
    constructor Create(const control: TControl; const strNome: string);
    function GetNome: string;
    function GetValue: Variant;
    procedure SetValue(const value: Variant);
  end;

implementation

uses
  untLibTintaControleFactory, untLibTintaControleVisualEventosFactory, 
  untComponentFactory;

{ TControlILibTintaControleVisualWrapper }

function TControlILibTintaControleVisualWrapper.AdicionarControle(const controle: ILibTintaControleVisual): ILibTintaControleVisual;
begin
  TLibTintaControleFactory.GetControl(controle, control, tela);  
end;

function TControlILibTintaControleVisualWrapper.AdicionarEvento(const evento: ILibTintaControleVisualEvento): ILibTintaControleVisual;
begin
  TLibTintaControleVisualEventosFactory.RegistrarEvento(
    evento,
    Self,
    tela,
    control
  );
end;

function TControlILibTintaControleVisualWrapper.AdicionarPropriedade(
  const propriedade: ILibTintaControleVisualPropriedade): ILibTintaControleVisual;
begin
  // já existe as propriedades  
end;

constructor TControlILibTintaControleVisualWrapper.Create(const control: TControl; const tela: ITelaCadLibTintas);
begin
  inherited Create();
  Self.control := control;
  Self.tela := tela;
end;

function TControlILibTintaControleVisualWrapper.GetClasse: string;
begin
  Result := control.ClassName;
end;

function TControlILibTintaControleVisualWrapper.GetControle(const index: Integer): ILibTintaControleVisual;
var
  intCont: Integer;
  intContReal: Integer;
begin
  Result := nil;
  intContReal := -1;
  for intCont := 0 to control.ComponentCount - 1 do
  begin
    if control.Components[intCont] is TControl then
      intContReal := intContReal + 1;

    if intContReal = index then
    begin
      Result := TControlILibTintaControleVisualWrapper.Create(control.Components[intCont] as TControl,
        tela);
      Exit;
    end;
  end;
end;

function TControlILibTintaControleVisualWrapper.GetControleNome(const strNome: string): ILibTintaControleVisual;
var
  intCont: Integer;
begin
  Result := nil;
  for intCont := 0 to control.ComponentCount - 1 do
  begin
    if control.Components[intCont] is TControl then
    begin
      Result := TControlILibTintaControleVisualWrapper.Create(control.Components[intCont] as TControl,
        tela);
      Exit;
    end;
  end;
end;

function TControlILibTintaControleVisualWrapper.GetControlesCont: Integer;
var
  intCont: Integer;
begin
  Result := -1;
  for intCont := 0 to control.ComponentCount - 1 do
  begin
    if control.Components[intCont] is TControl then
      Result := Result + 1;
  end;
end;

function TControlILibTintaControleVisualWrapper.GetEvento(const strNome: string): ILibTintaControleVisualEvento;
begin
  Result := TControlLibTintaControleVisualEventoWrapper.Create(control, strNome);  
end;

function TControlILibTintaControleVisualWrapper.GetEventoIndex(const index: Integer): ILibTintaControleVisualEvento;
var
  lstProp: PPropList;
  info: PPropInfo;
  intCont: Integer;
  intContReal: Integer;
  
  function valida(const propInfo: PPropInfo): Boolean;
  begin
    Try
      Result := (Assigned(propInfo.PropType))
        and (propInfo.PropType^.Name <> '')
        and (propInfo.PropType^.Kind = tkMethod);
    Except
      Result := False;
    End;
  end;
begin
  Result := nil;
  intContReal := -1;
  GetPropList(control, lstProp);
  for intCont := 0 to Length(lstProp^) - 1 do
  begin
    info := lstProp^[intCont];
    if not Assigned(info) then
      Exit;

    if valida(info) then
      intContReal := intContReal + 1
    else
      Continue;

    if intContReal = index then
      Result := TControlLibTintaControleVisualEventoWrapper.Create(control, GetPropName(info)); //info.Name
  end;    
end;

function TControlILibTintaControleVisualWrapper.GetEventosCont: Integer;
var
  lstProp: PPropList;
  info: PPropInfo;
  intCont: Integer;
  
  function valida(const propInfo: PPropInfo): Boolean;
  begin
    Try
      Result := (Assigned(propInfo.PropType))
        and (propInfo.PropType^.Name <> '')
        and (propInfo.PropType^.Kind = tkMethod);
    Except
      Result := False;
    End;
  end;
begin
  Result := 0;
  GetPropList(control, lstProp);
  for intCont := 0 to Length(lstProp^) - 1 do
  begin
    info := lstProp^[intCont];
    if not Assigned(info) then
      Exit;

    if valida(info) then
      Result := Result + 1
    else
      Continue;
  end;
end;

function TControlILibTintaControleVisualWrapper.GetImplementacao: string;
begin
  Result := TComponentFactory.ComponentToString(control);
end;

function TControlILibTintaControleVisualWrapper.GetNome: string;
begin
  Result := control.Name;
end;

function TControlILibTintaControleVisualWrapper.GetPropriedade(const strNome: string): ILibTintaControleVisualPropriedade;
begin
  Result := TControlLibTintaControleVisualPropriedadeWrapper.Create(control, strNome);
end;

function TControlILibTintaControleVisualWrapper.GetPropriedadeIndex(const index: Integer): ILibTintaControleVisualPropriedade;
var
  lstProp: PPropList;
  info: PPropInfo;
  intCont: Integer;
  intContReal: Integer;

  function valida(const propInfo: PPropInfo): Boolean;
  begin
    Try
      Result := (Assigned(propInfo.PropType))
        and (propInfo.PropType^.Name <> '')
        and (propInfo.PropType^.Kind <> tkMethod);
    Except
      Result := False;
    End;
  end;
begin
  Result := nil;
  intContReal := -1;
  GetPropList(control, lstProp);
  for intCont := 0 to Length(lstProp^) - 1 do
  begin
    info := lstProp^[intCont];
    if not Assigned(info) then
      Exit;
      
    if valida(info) then
      intContReal := intContReal + 1
    else
      Continue;

    if intContReal = index then
    begin
      Result := TControlLibTintaControleVisualPropriedadeWrapper.Create(control, GetPropName(info)); //info.Name
      Exit;
    end;
  end;
end;

function TControlILibTintaControleVisualWrapper.GetPropriedadesCont: Integer;
var
  lstProp: PPropList;
  info: PPropInfo;
  intCont: Integer;

  function valida(const propInfo: PPropInfo): Boolean;
  begin
    Try
      Result := (Assigned(propInfo.PropType))
        and (propInfo.PropType^.Name <> '')
        and (propInfo.PropType^.Kind <> tkMethod);
    Except
      Result := False;
    End;
  end;
begin
  Result := 0;
  GetPropList(control, lstProp);
  for intCont := 0 to Length(lstProp^) - 1 do
  begin
    info := lstProp^[intCont];

    if not Assigned(info) then
      Exit;

    if valida(info) then
      Result := Result + 1
    else
      Continue;
  end;
end;

procedure TControlILibTintaControleVisualWrapper.RemoverControle(const controle: ILibTintaControleVisual);
begin
  control.RemoveComponent(control.FindComponent(controle.Nome));
end;

procedure TControlILibTintaControleVisualWrapper.RemoverControleIndex(const index: Integer);
begin
  RemoverControle(GetControle(index));
end;

procedure TControlILibTintaControleVisualWrapper.RemoverControleNome(const strNome: string);
begin
  RemoverControle(GetControleNome(strNome));
end;

procedure TControlILibTintaControleVisualWrapper.RemoverEvento(const evento: ILibTintaControleVisualEvento);
begin
  // nao se remove
end;

procedure TControlILibTintaControleVisualWrapper.RemoverEventoIndex(const index: Integer);
begin
  // nao se remove
end;

procedure TControlILibTintaControleVisualWrapper.RemoverEventoNome(const strNome: string);
begin
  // nao se remove
end;

procedure TControlILibTintaControleVisualWrapper.RemoverPropriedade(const propriedade: ILibTintaControleVisualPropriedade);
begin
  // nao se remove
end;

procedure TControlILibTintaControleVisualWrapper.RemoverPropriedadeIndex(const index: Integer);
begin
  // nao se remove
end;

procedure TControlILibTintaControleVisualWrapper.RemoverPropriedadeNome(const strNome: string);
begin
  // nao se remove
end;

{ TControlLibTintaControleVisualEventoWrapper }

constructor TControlLibTintaControleVisualEventoWrapper.Create(const control: TControl; const strNome: string);
begin
  inherited Create();
  Self.control := control;
  Self.strNome := strNome;
end;

function TControlLibTintaControleVisualEventoWrapper.GetLibTintaControleVisual: ILibTintaControleVisual;
begin
  Result := controleVisual;
end;

function TControlLibTintaControleVisualEventoWrapper.GetMethodAddress: Pointer;
begin
  Result := Self.MethodAddress(strNome);
end;

function TControlLibTintaControleVisualEventoWrapper.GetNome: string;
begin
  Result := strNome;
end;

function TControlLibTintaControleVisualEventoWrapper.GetTelaCadLibTintas: ITelaCadLibTintas;
begin
  Result := tela;
end;

procedure TControlLibTintaControleVisualEventoWrapper.SetLibTintaControleVisual(
  const value: ILibTintaControleVisual);
begin
  controleVisual := value;
end;

procedure TControlLibTintaControleVisualEventoWrapper.SetTelaCadLibTintas(
  const value: ITelaCadLibTintas);
begin
  tela := value;
end;

{ TControlLibTintaControleVisualPropriedadeWrapper }

constructor TControlLibTintaControleVisualPropriedadeWrapper.Create(const control: TControl; const strNome: string);
begin
  inherited Create();
  Self.control := control;
  Self.strNome := strNome;
end;

function TControlLibTintaControleVisualPropriedadeWrapper.GetNome: string;
begin
  Result := strNome;
end;

function TControlLibTintaControleVisualPropriedadeWrapper.GetValue: Variant;
begin
  Try
    Try
      Result := GetPropValue(control, strNome);
    Except
      on E: Exception do
      begin
        raise Exception.CreateFmt('[%s] %s: %s', [control.ClassName, e.ClassName, E.Message]);
      end;
    End;
  Finally
  End;
end;

procedure TControlLibTintaControleVisualPropriedadeWrapper.SetValue(
  const value: Variant);
begin
  SetPropValue(control, strNome, value);
end;

end.
