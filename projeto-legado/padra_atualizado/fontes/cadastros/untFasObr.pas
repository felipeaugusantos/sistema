unit untFasObr;

interface

uses Classes, DB, untFuncoesSimples, Uni, SysUtils;

Type
  TFasObr = class(TComponent)
  Private
    FCodFas: String;
    FDescri: String;

    procedure setCodFas(const Value: String);
    procedure setDescri(const Value: String);
  Public
    qryTabela: TUniQuery;

    constructor Create(Owner: TComponent); Override;

    property strCodFas: String Read FCodFas Write setCodFas;
    property strDescri: String Read FDescri Write setDescri;
  End;

implementation

{ TFasObr }

uses untConstantes, untTypesSistema;

constructor TFasObr.Create(Owner: TComponent);
begin
  inherited;

  Try
    qryTabela := fCriaQuery(Self);

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM FASOBR WHERE FALSE');
    qryTabela.Open;

    FCodFas := '';
    FDescri := '';
  Except

    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto CadPor!' + #13 + E.Message);

  End;

end;

procedure TFasObr.setCodFas(const Value: String);
begin
  If fEmptyStr(Value) Then
    Raise ExceptionAutcom.Create('O código deve ser preenchido!')
  Else
    FCodFas := Value;
end;

procedure TFasObr.setDescri(const Value: String);
begin
  If fEmptyStr(Value) Then
    Raise ExceptionAutcom.Create('A Descrição deve ser preenchida!')
  Else
    FDescri := Value;
end;

end.
