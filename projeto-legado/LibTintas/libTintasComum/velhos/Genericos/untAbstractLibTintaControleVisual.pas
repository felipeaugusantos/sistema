unit untAbstractLibTintaControleVisual;

interface

uses
  untILibTintaControleVisual, Classes, untILibTintaControleVisualPropriedade;

type
  TAbstractLibTintaControleVisual = class abstract(TInterfacedObject, ILibTintaControleVisual)
  private
    lstControles: IInterfaceList;
    lstPropriedades: IInterfaceList;
    lstEventos: IInterfaceList;
    strNome: string;
    function GetControles(): IInterfaceList;
    function GetPropriedades(): IInterfaceList;
    function GetEventos(): IInterfaceList;
  protected
    strImplementacao: string;
  public
    constructor Create(const strNome: string); overload; virtual;
    function GetClasse: string; virtual; abstract;
    function GetImplementacao(): string;

    function GetControle(const index: Integer): ILibTintaControleVisual; virtual;
    function GetControleNome(const strNome: string): ILibTintaControleVisual; virtual;
    function GetControlesCont: Integer; virtual;
    function GetNome: string; virtual;
    function GetPropriedade(const strNome: string): ILibTintaControleVisualPropriedade; virtual;
    function GetPropriedadeIndex(const index: Integer): ILibTintaControleVisualPropriedade; virtual;
    function GetPropriedadesCont: Integer; virtual;

    function AdicionarControle(const controle: ILibTintaControleVisual): ILibTintaControleVisual;
    function AdicionarPropriedade(const propriedade: ILibTintaControleVisualPropriedade): ILibTintaControleVisual;
    procedure RemoverControle(const controle: ILibTintaControleVisual);
    procedure RemoverControleIndex(const index: Integer);
    procedure RemoverControleNome(const strNome: string);
    procedure RemoverPropriedade(const propriedade: ILibTintaControleVisualPropriedade);
    procedure RemoverPropriedadeIndex(const index: Integer);
    procedure RemoverPropriedadeNome(const strNome: string);

    function AdicionarEvento(const evento: ILibTintaControleVisualEvento): ILibTintaControleVisual;
    procedure RemoverEvento(const evento: ILibTintaControleVisualEvento);
    procedure RemoverEventoIndex(const index: Integer);
    procedure RemoverEventoNome(const strNome: string);
    
    function GetEvento(const strNome: string): ILibTintaControleVisualEvento;
    function GetEventoIndex(const index: Integer): ILibTintaControleVisualEvento;
    function GetEventosCont: Integer;
  end;

implementation

{ TAbstractLibTintaControleVisual }

function TAbstractLibTintaControleVisual.AdicionarControle(const controle: ILibTintaControleVisual): ILibTintaControleVisual;
begin
  GetControles.Add(controle);
  Result := Self;
end;

function TAbstractLibTintaControleVisual.AdicionarEvento(const evento: ILibTintaControleVisualEvento): ILibTintaControleVisual;
begin
  GetEventos.Add(evento);
  Result := Self;
end;

function TAbstractLibTintaControleVisual.AdicionarPropriedade(
  const propriedade: ILibTintaControleVisualPropriedade): ILibTintaControleVisual;
begin
  GetPropriedades.Add(propriedade);
  Result := Self;
end;

constructor TAbstractLibTintaControleVisual.Create(const strNome: string);
begin
  inherited Create();
  Self.strNome := strNome;
end;

function TAbstractLibTintaControleVisual.GetControle(const index: Integer): ILibTintaControleVisual;
begin
  Result := GetControles[index] as ILibTintaControleVisual;
end;

function TAbstractLibTintaControleVisual.GetControleNome(const strNome: string): ILibTintaControleVisual;
var
  intCont: Integer;
begin
  Result := nil;
  for intCont := 0 to GetControles.Count - 1 do
  begin
    if (GetControles[intCont] as ILibTintaControleVisual).Nome = strNome then
    begin
      Result := GetControles[intCont] as ILibTintaControleVisual;
    end;
  end;
end;

function TAbstractLibTintaControleVisual.GetControles: IInterfaceList;
begin
  if not Assigned(lstControles) then
  begin
    lstControles := TInterfaceList.Create;
  end;

  Result := lstControles;  
end;

function TAbstractLibTintaControleVisual.GetControlesCont: Integer;
begin
  Result := GetControles.Count;
end;

function TAbstractLibTintaControleVisual.GetEvento(const strNome: string): ILibTintaControleVisualEvento;
var
  intCont: Integer;
begin
  Result := nil;
  for intCont := 0 to GetEventos.Count - 1 do
  begin
    if (GetEventos[intCont] as ILibTintaControleVisualEvento).Nome = strNome then
    begin
      Result := (GetEventos[intCont] as ILibTintaControleVisualEvento);
      Exit;
    end;
  end;
end;

function TAbstractLibTintaControleVisual.GetEventoIndex(const index: Integer): ILibTintaControleVisualEvento;
begin
  Result := GetEventos[index] as ILibTintaControleVisualEvento;
end;

function TAbstractLibTintaControleVisual.GetEventos: IInterfaceList;
begin
  if not Assigned(lstEventos) then
  begin
    lstEventos := TInterfaceList.Create;
  end;

  Result := lstEventos;  
end;

function TAbstractLibTintaControleVisual.GetEventosCont: Integer;
begin
  Result := GetEventos.Count;
end;

function TAbstractLibTintaControleVisual.GetImplementacao: string;
begin
  Result := strImplementacao;  
end;

function TAbstractLibTintaControleVisual.GetNome: string;
begin
  Result := strNome;
end;

function TAbstractLibTintaControleVisual.GetPropriedade(const strNome: string): ILibTintaControleVisualPropriedade;
var
  intCont: Integer;
begin
  Result := nil;
  for intCont := 0 to GetPropriedades.Count - 1 do
  begin
    if (GetPropriedades[intCont] as ILibTintaControleVisualPropriedade).Nome = strNome then
    begin
      Result := GetPropriedades[intCont] as ILibTintaControleVisualPropriedade;
    end;
  end;
end;

function TAbstractLibTintaControleVisual.GetPropriedadeIndex(const index: Integer): ILibTintaControleVisualPropriedade;
begin
  Result := GetPropriedades[index] as ILibTintaControleVisualPropriedade;
end;

function TAbstractLibTintaControleVisual.GetPropriedades: IInterfaceList;
begin
  if not Assigned(lstPropriedades) then
  begin
    lstPropriedades := TInterfaceList.Create;
  end;

  Result := lstPropriedades;  
end;

function TAbstractLibTintaControleVisual.GetPropriedadesCont: Integer;
begin
  Result := GetPropriedades.Count;
end;

procedure TAbstractLibTintaControleVisual.RemoverControle(const controle: ILibTintaControleVisual);
begin
  GetControles.Remove(controle);
end;

procedure TAbstractLibTintaControleVisual.RemoverControleIndex(const index: Integer);
begin
  GetControles.Delete(index);
end;

procedure TAbstractLibTintaControleVisual.RemoverControleNome(const strNome: string);
var
  intCont: Integer;
  controle: ILibTintaControleVisual;
begin
  for intCont := 0 to GetControles.Count - 1 do
  begin
    controle := GetControles[intCont] as ILibTintaControleVisual;
    if controle.Nome = strNome then
    begin
      GetControles.Remove(controle);
      Exit;
    end;    
  end;
end;

procedure TAbstractLibTintaControleVisual.RemoverEvento(const evento: ILibTintaControleVisualEvento);
begin
  GetEventos.Remove(evento);
end;

procedure TAbstractLibTintaControleVisual.RemoverEventoIndex(const index: Integer);
begin
  GetEventos.Delete(index);
end;

procedure TAbstractLibTintaControleVisual.RemoverEventoNome(const strNome: string);
var
  intCont: Integer;
  evento: ILibTintaControleVisualEvento;
begin
  for intCont := 0 to GetEventos.Count - 1 do
  begin
    evento := GetEventos[intCont] as ILibTintaControleVisualEvento;
    if evento.Nome = strNome then
    begin
      GetEventos.Remove(evento);
      Exit;
    end;    
  end;  
end;

procedure TAbstractLibTintaControleVisual.RemoverPropriedade(const propriedade: ILibTintaControleVisualPropriedade);
begin
  GetPropriedades.Remove(propriedade);
end;

procedure TAbstractLibTintaControleVisual.RemoverPropriedadeIndex(const index: Integer);
begin
  GetPropriedades.Delete(index);
end;

procedure TAbstractLibTintaControleVisual.RemoverPropriedadeNome(const strNome: string);
var
  intCont: Integer;
  propriedade: ILibTintaControleVisualPropriedade;
begin
  for intCont := 0 to GetPropriedades.Count - 1 do
  begin
    propriedade := GetPropriedades[intCont] as ILibTintaControleVisualPropriedade;
    if propriedade.Nome = strNome then
    begin
      GetPropriedades.Remove(propriedade);
      Exit;
    end;
  end;
end;

end.

