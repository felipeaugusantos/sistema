unit untCadMotVenPer;

interface

uses Classes, DB, Uni, untFuncoesSimples;

Type TCadMotVenPer = Class (TComponent)

  Private
    FCodMot: String;
    FDesMot: String;
    FCodEmp: String;
    FAutInc: String;

    procedure setCodMot(const Value: String);
    procedure setDesMot(const Value: String);

  Public

    qryTabela: TUniQuery;
    arrDefCam: TArrDefCam;

    Property strCodMot: String Read FCodMot   Write setCodMot;
    Property strDesMot: String Read FDesMot   Write setDesMot;

    Constructor Create(Owner: TComponent); Reintroduce;

  End;

implementation

{ TCadMotVenPer }

uses SysUtils;

constructor TCadMotVenPer.Create(Owner: TComponent);
begin
  qryTabela := fCriaQuery(Self);

  qryTabela.Close;
  qryTabela.SQL.Clear;
  qryTabela.SQL.Add('SELECT * FROM MOTVPD WHERE FALSE');
  qryTabela.Open;

  FCodMot := '';
  FDesMot := '';
  FCodEmp := '';
  FAutInc := '';
end;

procedure TCadMotVenPer.setCodMot(const Value: String);
begin
  If fEmptyStr (Value) Then
    Raise Exception.Create('O Código do Motivo deve ser preenchido!')
  Else
    FCodMot := Value;
end;

procedure TCadMotVenPer.setDesMot(const Value: String);
begin
  If Not fEmptyStr(Value) Then
    FDesMot := Value
  Else
    Raise Exception.Create('A Descrição do Motivo deve ser preenchida!');
end;

end.
