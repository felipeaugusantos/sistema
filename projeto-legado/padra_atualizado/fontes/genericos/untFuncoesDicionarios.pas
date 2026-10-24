unit untFuncoesDicionarios;

interface

uses System.Classes, System.Contnrs, System.SysUtils, Data.DB, System.StrUtils,
  System.Variants;

{*************************************************}
{* CLASSE QUE REPRENTA UM DICIONÁRIO ("HASH").   *}
{* AS CHAVES SÃO STRINGS, E OS VALORES PODEM     *}
{* SER DE QUALQUER TIPO SUPORTADO POR "VARIANT". *}
{* ISSO PERMITE QUE OS VALORES CONTENHAM VALORES *}
{* DE TIPOS VARIADOS. PODE SER FEITO A CHAVE     *}
{* COMO VARIANT (ESTOU COM PRESSA)               *}
{**********************************************MV*}
Type
  {***********************************}
  {* SUPER CLASSE AUXILIAR PARA      *}
  {* LIBERAÇÃO DE MEMÓRIA AUTOMÁTICA *}
  {********************************AF*}
  TObjectVariant = Class(TObject)
    varValor: Variant;
  public
    Constructor Create(valor: Variant);
  End;

  TDicionario = class
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
    procedure LimparObjetos;
    function Retorna(strChave: String): Variant;
    function RetornaObjeto(strChave: String): TObject;

    function Chaves: TStringList;

    property Items[Index: String]: Variant read Retorna write Adicionar; default;
  End;

implementation

{ TObjectVariant }
constructor TObjectVariant.Create(valor: Variant);
begin
  varValor := valor;
end;

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

  lstChaves  := TStringList.Create;
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
    If Assigned(lstValores[intCont]) And
      (lstValores[intCont] Is TObjectVariant) Then
    Begin
      obj := lstValores[intCont];
      FreeAndNil(obj);
    End;
  End;

  lstChaves.Clear;
  lstValores.Clear;
end;

procedure TDicionario.LimparObjetos;
  Var
    intObj: Integer;
begin
  For intObj := 0 To lstChaves.Count -1 Do
  Begin
    If Assigned(RetornaObjeto(lstChaves[intObj])) Then
      TObject(RetornaObjeto(lstChaves[intObj])).Destroy;
    lstValores[intObj] := nil;
  End;
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
