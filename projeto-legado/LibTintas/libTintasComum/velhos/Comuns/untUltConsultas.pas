unit untUltConsultas;

interface

uses
  DB, SysUtils;

type
  TUltConsultas = class(TInterfacedObject)
  private
    arrTabelas: Array Of String;
    arrRegistros: Array Of TBookmark;
    arrSelects: Array Of String;
    arrIndices1: Array Of String;
    arrIndices2: Array Of String;
    arrIndices3: Array Of String;
    arrItemIndex: Array Of Integer;

    FIndiceAtual: Integer;
    FEstado: TDataSetState;

    FTabela: String;
    FRegistro: TBookmark;
    FSelect: String;
    FIndice1: String;
    FIndice2: String;
    FIndice3: String;
    FItemIndex: Integer;
  private
    class var utcRegistros: TUltConsultas;
  private
    procedure pChecarIntegridade;
    procedure SetEstado(dsEstado: TDataSetState);
    procedure SetTabela(strTabela: String);
    procedure SetRegistro(bkmRegistro: TBookmark);
    procedure SetSelect(strSelect: String);
    procedure SetIndice1(strIndice: String);
    procedure SetIndice3(strIndice: String);
    procedure SetItemIndex(intItemIndex: Integer);

    function GetEstado: TDataSetState;
    function GetTabela: String;
    function GetRegistro: TBookmark;
    function GetSelect: String;
    procedure SetIndice2(strIndice: String);
    function GetIndice1: String;
    function GetIndice2: String;
    function GetIndice3: String;
    function GetItemIndex: Integer;
  public
    Constructor Create;
    Destructor Destroy; Override;

    procedure pLimparCampos;
    procedure Novo;
    procedure Grava;
    procedure Limpar(strNomeTabela: String);
    function fRetRegistro(Const strNomeTabela: String; blnAtualizaDados: Boolean = True): Boolean;

    class function GetUltConsultas(): TUltConsultas;

    property Estado: TDataSetState read GetEstado write SetEstado;
    property Tabela: String read GetTabela write SetTabela;
    property Registro: TBookmark read GetRegistro write SetRegistro;
    property Select: String read GetSelect write SetSelect;
    property Indice1: String read GetIndice1 write SetIndice1;
    property Indice2: String read GetIndice2 write SetIndice2;
    property Indice3: String read GetIndice3 write SetIndice3;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
 End;

implementation

uses
  untStrUtils;

{ TUltConsultas }

constructor TUltConsultas.Create;
begin
  inherited Create;
  pLimparCampos;
end;

destructor TUltConsultas.Destroy;
var intContador: Integer;
begin
  pLimparCampos;

  For intContador := 0 To Length(arrRegistros)-1 Do
  Begin
    FreeMem(arrRegistros[intContador]);
//    arrRegistros[intContador] := Nil; estava dando invald point operation
  End;

  SetLength(arrRegistros, 0);

  inherited Destroy;
end;

function TUltConsultas.fRetRegistro(Const strNomeTabela: String;
  blnAtualizaDados: Boolean = True): Boolean;
  Var
    intTamArr: Integer;
    intContador: Integer;
begin
  Result    := False;
  intTamArr := Length(arrRegistros);

  If blnAtualizaDados Then
  Begin
    FTabela   := '';
    FRegistro := Nil;
    FSelect   := '';
    FIndice1  := '';
    FIndice2  := '';
    FIndice3  := '';
  End;

  For intContador := 0 To intTamArr -1 Do
  Begin
    If arrTabelas[intContador] = strNomeTabela Then
    Begin
      Result       := True;
      FIndiceAtual := intContador;

      If blnAtualizaDados Then
      Begin
        FTabela    := strNomeTabela;
        FRegistro  := arrRegistros[FIndiceAtual];
        FSelect    := arrSelects[FIndiceAtual];
        FIndice1   := arrIndices1[FIndiceAtual];
        FIndice2   := arrIndices2[FIndiceAtual];
        FIndice3   := arrIndices3[FIndiceAtual];
        FItemIndex := arrItemIndex[FIndiceAtual];
      End;

      Break;
    End;
  End;

end;

function TUltConsultas.GetEstado: TDataSetState;
begin
  Result := FEstado;
end;

function TUltConsultas.GetIndice1: String;
begin
  Result := FIndice1;
end;

function TUltConsultas.GetIndice2: String;
begin
  Result := FIndice2;
end;

function TUltConsultas.GetIndice3: String;
begin
  Result := FIndice3;
end;

function TUltConsultas.GetItemIndex: Integer;
begin
  Result := FItemIndex;
end;

function TUltConsultas.GetRegistro: TBookmark;
begin
  Result := FRegistro;
end;

function TUltConsultas.GetSelect: String;
begin
  Result := FSelect;
end;

function TUltConsultas.GetTabela: String;
begin
  Result := FTabela;
end;

class function TUltConsultas.GetUltConsultas: TUltConsultas;
begin
  if not Assigned(utcRegistros) then
    utcRegistros := TUltConsultas.Create;

  Result := utcRegistros;
end;

procedure TUltConsultas.Grava;
  Var
    intTamArr: Integer;
begin

  If Not (FEstado In [dsInsert]) Then
  Begin
    Exit;
  End;

  pChecarIntegridade;

  If Not (fRetRegistro(FTabela, False)) Then
  Begin
    intTamArr := Length(arrRegistros);
    SetLength(arrTabelas, intTamArr+1);
    SetLength(arrRegistros, intTamArr+1);
    SetLength(arrSelects, intTamArr+1);
    SetLength(arrIndices1, intTamArr+1);
    SetLength(arrIndices2, intTamArr+1);
    SetLength(arrIndices3, intTamArr+1);
    SetLength(arrItemIndex, intTamArr+1);

    arrTabelas[intTamArr]   := FTabela;
    arrRegistros[intTamArr] := FRegistro;
    arrSelects[intTamArr]   := FSelect;
    arrIndices1[intTamArr]  := FIndice1;
    arrIndices2[intTamArr]  := FIndice2;
    arrIndices3[intTamArr]  := FIndice3;
    arrItemIndex[intTamArr] := FItemIndex;
  End
  Else
  Begin
    arrTabelas[FIndiceAtual]   := FTabela;

//    If Assigned(arrRegistros[FIndiceAtual]) Then
//    Begin
//      FreeMem(arrRegistros[FIndiceAtual]);
//      arrRegistros[FIndiceAtual] := Nil; estava dando invald point operation
//    End;

    arrRegistros[FIndiceAtual] := FRegistro;
    arrSelects[FIndiceAtual]   := FSelect;
    arrIndices1[FIndiceAtual]  := FIndice1;
    arrIndices2[FIndiceAtual]  := FIndice2;
    arrIndices3[FIndiceAtual]  := FIndice3;
    arrItemIndex[FIndiceAtual] := FItemIndex;
  End;

  SetEstado(dsBrowse);

end;

procedure TUltConsultas.Limpar(strNomeTabela: String);
begin

  If fRetRegistro(strNomeTabela, False) Then
  Begin
    arrSelects[FIndiceAtual]   := '';

    If Assigned(arrRegistros[FIndiceAtual]) Then
      FreeMem(arrRegistros[FIndiceAtual]);

    arrRegistros[FIndiceAtual] := Nil;
  End;

end;

procedure TUltConsultas.Novo;
begin
  SetEstado(dsInsert);

  FTabela   := '';
  FRegistro := Nil;
  FSelect   := '';
  FIndice1  := '';
  FIndice2  := '';
  FIndice3  := '';
end;

procedure TUltConsultas.pChecarIntegridade;
begin
  If TStrUtils.fEmptyStr(FTabela) Then
  Begin
    Raise Exception.Create('É necessário preencher a Tabela');
  End;
end;

procedure TUltConsultas.pLimparCampos;
Var intContador: Integer;
begin
  SetLength(arrTabelas, 0);

  For intContador := 0 To Length(arrRegistros)-1 Do
  Begin
    If Assigned(arrRegistros[intContador]) Then
    Begin
      FreeMem(arrRegistros[intContador]);
      arrRegistros[intContador] := Nil
    End;
  End;

  SetLength(arrRegistros, 0);
  SetLength(arrSelects, 0);
  SetLength(arrIndices1, 0);
  SetLength(arrIndices2, 0);
  SetLength(arrIndices3, 0);
  SetLength(arrItemIndex, 0);
end;

procedure TUltConsultas.SetEstado(dsEstado: TDataSetState);
begin
  If (dsEstado In [dsInsert, dsBrowse]) Then
  Begin
    FEstado := dsEstado;
  End;
end;

procedure TUltConsultas.SetIndice1(strIndice: String);
begin
  If (FEstado In [dsInsert]) Then
  Begin
    FIndice1 := strIndice;
  End
end;

procedure TUltConsultas.SetIndice2(strIndice: String);
begin
  If (FEstado In [dsInsert]) Then
  Begin
    FIndice2 := strIndice;
  End
end;

procedure TUltConsultas.SetIndice3(strIndice: String);
begin
  If (FEstado In [dsInsert]) Then
  Begin
    FIndice3 := strIndice;
  End
end;

procedure TUltConsultas.SetItemIndex(intItemIndex: Integer);
begin
  If (FEstado In [dsInsert]) Then
  Begin
    FItemIndex := intItemIndex;
  End
end;

procedure TUltConsultas.SetRegistro(bkmRegistro: TBookmark);
begin
  If (FEstado In [dsInsert]) Then
  Begin
    FRegistro := bkmRegistro;
  End
end;

procedure TUltConsultas.SetSelect(strSelect: String);
begin
  If (FEstado In [dsInsert]) Then
  Begin
    FSelect := strSelect;
  End
end;

procedure TUltConsultas.SetTabela(strTabela: String);
begin
  If (FEstado In [dsInsert]) Then
  Begin
    FTabela := strTabela;
  End
end;


end.
