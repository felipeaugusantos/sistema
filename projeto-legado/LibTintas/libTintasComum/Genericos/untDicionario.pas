unit untDicionario;

interface

uses
  Classes;

type
  TDicionario = class(TObject)
    private
      lstChaves: TStringList;
      lstValores: TObjectList;
    protected
      function BuscaChave(strChave: String): Integer;
    public
      constructor Create;
      destructor Destroy; override;
      procedure Adicionar(strChave: String; Valor: Variant);
      procedure AdicionarObjeto(strChave: String; Valor: TObject);
      procedure Remove(strChave: String);
      procedure Limpar;
      function Retorna(strChave: String): Variant;
      function RetornaObjeto(strChave: String): TObject;

      function Chaves: TStringList;

      property Items[Index: String]: Variant read Retorna write Adicionar; default;
  end;

implementation

{ TDicionario }

procedure TDicionario.Adicionar(strChave: String; Valor: Variant);
  Var
    intPos: Integer;
begin
  intPos := BuscaChave(strChave);

  If intPos = -1 Then
  Begin
    lstChaves.Add(strChave);
    lstValores.Add(TObjectVariant.Create(Valor));
  End
  Else
    lstValores[intPos] := TObjectVariant.Create(Valor);  
end;

procedure TDicionario.AdicionarObjeto(strChave: String; Valor: TObject);
  Var
    intPos: Integer;
begin
  intPos := BuscaChave(strChave);

  If intPos = -1 Then
  Begin
    lstChaves.Add(strChave);
    lstValores.Add(Valor);
  End
  Else
  Begin
    lstValores[intPos] := Valor;
  End;
end;

function TDicionario.BuscaChave(strChave: String): Integer;
  Var
    intContador: Integer;
begin

  Result := -1;

  If Not Assigned(lstChaves) Then
    Exit;  

  For intContador := 0 To lstChaves.Count -1 Do
  Begin
    If (lstChaves[intContador] = strChave) Then
    Begin
      Result := intContador;
      Break;
    End;
  End;
end;

constructor TDicionario.Create;
begin
  inherited Create;

  lstChaves := TStringList.Create;
  lstValores := TObjectList.Create(False);
end;

destructor TDicionario.Destroy;
begin
  Limpar;

  FreeAndNil(lstChaves);
  FreeAndNil(lstValores);  

  inherited;
end;

procedure TDicionario.Limpar;
  Var
    intCont: Integer;
    obj: TObject;
begin

  For intCont := 0 To lstValores.Count -1 Do
  Begin
    If lstValores[intCont] Is TObjectVariant Then
    Begin
      obj := lstValores[intCont];
      FreeAndNil(obj);
    End;
  End;

  lstChaves.Clear;
  lstValores.Clear;

end;

procedure TDicionario.Remove(strChave: String);
  Var
    intPos: Integer;
begin

  intPos := BuscaChave(strChave);
  If (intPos > -1) Then
  Begin
    lstChaves.Delete(intPos);
    lstValores.Delete(intPos);
  End;

end;

function TDicionario.Retorna(strChave: String): Variant;
  Var
    intPos: Integer;
begin
  Result := Null;
  intPos := BuscaChave(strChave);

  If intPos > -1 Then
    Result := TObjectVariant(lstValores[intPos]).varValor;
end;

function TDicionario.RetornaObjeto(strChave: String): TObject;
  Var
    intPos: Integer;
begin
  Result := Nil;
  intPos := BuscaChave(strChave);

  If intPos > -1 Then
  Begin
    Result := lstValores[intPos];
  End;
end;

function TDicionario.Chaves: TStringList;
begin
  Result := lstChaves;
end;

end.
