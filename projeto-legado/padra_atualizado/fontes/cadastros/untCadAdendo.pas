unit untCadAdendo;

interface

uses Classes, DB, Uni;

Type
  TCadAdendo = Class (TComponent)
  Private
    FCodAde: String;
    FDescri: String;
    FTexto_: String;
    function GetCodAde: String;
    function GetDescri: String;
    function GetTexto_: String;
    procedure SetCodAde(const Value: String);
    procedure SetDescri(const Value: String);
    procedure SetTexto_(const Value: String);
  Public
    qryTabela: TUniQuery;

    Property strCodAde: String Read GetCodAde Write SetCodAde;
    Property strDescri: String Read GetDescri Write SetDescri;
    Property strTexto_: String Read GetTexto_ Write SetTexto_;

    Constructor Create(Owner: TComponent); Reintroduce;
  end;

implementation

uses SysUtils, StrUtils, untConstantes, untFuncoesSimples;

{ TCadIBPT }

constructor TCadAdendo.Create(Owner: TComponent);
begin
  inherited;

  Try
    qryTabela := fCriaQuery(Self);

    qryTabela.Close;
    qryTabela.SQL.Clear;
    qryTabela.SQL.Add('SELECT * FROM CADADE WHERE FALSE');
    qryTabela.Open;

    FCodAde := '';
    FDescri := '';
    FTexto_ := '';
  Except
    On E: Exception Do
      Raise Exception.Create('Ocorreu um erro ao criar o objeto CadAdendo!' + #13 + E.Message);
  End;
end;

function TCadAdendo.GetCodAde: String;
begin
  Result := FCodAde;
end;

function TCadAdendo.GetDescri: String;
begin
  Result := FDescri;
end;

function TCadAdendo.GetTexto_: String;
begin
  Result := FTexto_;
end;

procedure TCadAdendo.SetCodAde(const Value: String);
begin
  FCodAde := Value;
end;

procedure TCadAdendo.SetDescri(const Value: String);
begin
  FDescri := Value;
end;

procedure TCadAdendo.SetTexto_(const Value: String);
begin
  FTexto_ := Value;
end;

end.
