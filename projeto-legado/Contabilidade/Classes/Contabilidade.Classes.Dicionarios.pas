unit Contabilidade.Classes.Dicionarios;

interface

uses untFuncoesSimples, Data.DB, Uni ;

type
  TDicResultadoQuerySimplesContabilidade = class
    private
      FResultados: TDicionario;
      function GetKey(qry: TUniQuery): String;
      function GetResult(Index: TUniQuery): Variant;
      procedure SetResult(Index: TUniQuery; const Value: Variant);
    public
      constructor Create;
      Destructor Destroy; override;

      procedure Limpar;

      property Items[Index: TUniQuery]: Variant read GetResult write SetResult; default;
  end;

implementation

uses SysUtils, StrUtils, Variants ;

{ TDicResultadoQuerySimplesContabilidade }

constructor TDicResultadoQuerySimplesContabilidade.Create;
begin
  FResultados := TDicionario.Create;
end;

destructor TDicResultadoQuerySimplesContabilidade.Destroy;
begin
  FreeAndNil(FResultados);
  inherited;
end;

function TDicResultadoQuerySimplesContabilidade.GetKey(qry: TUniQuery): String;
Var
  i: Integer;
begin
  Result := qry.SQL.Text;
  For i := 0 To qry.ParamCount -1 Do
    Result := AnsiReplaceStr(Result, ':' + qry.Params[i].Name, qry.Params[i].AsString);
  Result := GetMD5(Result);
end;

function TDicResultadoQuerySimplesContabilidade.GetResult(
  Index: TUniQuery): Variant;
begin
  Result := FResultados[GetKey(Index)];
end;

procedure TDicResultadoQuerySimplesContabilidade.Limpar;
begin
  FResultados.Limpar;
end;

procedure TDicResultadoQuerySimplesContabilidade.SetResult(Index: TUniQuery;
  const Value: Variant);
begin
  FResultados[GetKey(Index)] := Value;
end;


end.
