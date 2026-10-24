unit untListaLogErros;

interface

uses SysUtils, Classes, Contnrs;

Type
  TErro = class(TObject)
    private
      FMensagem: String;
      FBugReport: String;
    public
      constructor Create(Msg: String; bug: String);
      property Msg: String Read FMensagem;
      property BugReport: String Read FBugReport;
  End;

  TListaErros = class(TInterfacedObject)
    private
      FLista: TObjectList;
      FHabilitada: Boolean;

      function GetCount: Integer;
      function GetErro(Index: Integer): TErro;

      constructor Create;
    public
      destructor Destroy; override;
      procedure pLimpar;
      procedure pAdicionar(Msg: String; bug: String);

      property Count: Integer Read GetCount;
      property Erro[Index: Integer]: TErro Read GetErro; default;
      property Habilitada: Boolean Read FHabilitada Write FHabilitada;

      class function Erros: TListaErros;
  End;

Var
  VS_Erros__: TListaErros = Nil;

implementation

{ TErro }

constructor TErro.Create(Msg: String; bug: String);
begin
  FMensagem := Msg;
  FBugReport := bug;
end;

{ TListaErros }

constructor TListaErros.Create;
begin
  FLista := TObjectList.Create;
  FHabilitada := False;
end;

destructor TListaErros.Destroy;
begin
  FreeAndNil(FLista);
  inherited;
end;

class function TListaErros.Erros: TListaErros;
begin
  If Not Assigned(VS_Erros__) Then
    VS_Erros__ := TListaErros.Create;

  Result := VS_Erros__;
end;

function TListaErros.GetCount: Integer;
begin
  Result := FLista.Count;
end;

function TListaErros.GetErro(Index: Integer): TErro;
begin
  Result := TErro(FLista[Index]);
end;

procedure TListaErros.pAdicionar(Msg: String; bug: String);
begin
  FLista.Add(TErro.Create(Msg, bug));
end;

procedure TListaErros.pLimpar;
begin
  FLista.Clear;
end;

end.
