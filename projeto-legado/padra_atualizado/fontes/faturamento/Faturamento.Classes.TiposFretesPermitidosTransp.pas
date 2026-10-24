unit Faturamento.Classes.TiposFretesPermitidosTransp;

interface

uses untConnection, System.Generics.Collections, untTypesSistema;

Type
  TTiposDeFretePermitidosDAO = class
  private
    FConnection : IConnection;
    procedure InserirTiposFrete(const ACodTra: String; const ATipFreArray : TIntArray);
    procedure DeletarTiposFrete(const ACodTra : String);
  public
    function GetTiposFrete(const ACodTra : String) : TDictionary<TTiposDeFrete, Integer>;
    procedure GravarTiposDeFrete(const ACodTra : String; const ATipFreArray : TIntArray);
    constructor Create(const AConnection : IConnection);
  End;

implementation

uses untQuery, untTipoFreteAtc, untInterfaces;

{ TTiposDeFretePermitidosDAO }

constructor TTiposDeFretePermitidosDAO.Create(const AConnection: IConnection);
begin
  FConnection := AConnection;
end;

procedure TTiposDeFretePermitidosDAO.DeletarTiposFrete(
  const ACodTra: String);
Var
  LQuery : IQuery;
begin
  LQuery := FConnection.NewQuery(0);
  LQuery.Close;
  LQuery.SQL.Add(' DELETE                      ');
  LQuery.SQL.Add('   FROM FREPRM               ');
  LQuery.SQL.Add('  WHERE FRE_CODTRA = :CODTRA ');
  LQuery.ParamByName('CODTRA').AsString := ACodTra;
  LQuery.ExecSQL;
end;

function TTiposDeFretePermitidosDAO.GetTiposFrete(
  const ACodTra: String): TDictionary<TTiposDeFrete, Integer>;
Var
  LQuery : IQuery;
  LTipFre : Integer;
begin
  Result := TDictionary<TTiposDeFrete, Integer>.Create;

  LQuery := FConnection.NewQuery(0);
  LQuery.Close;
  LQuery.SQL.Add(' SELECT * ');
  LQuery.SQL.Add('   FROM FREPRM ');
  LQuery.SQL.Add('  WHERE FRE_CODTRA = :CODTRA ');
  LQuery.ParamByName('CODTRA').AsString := ACodTra;
  LQuery.Open;

  If (LQuery.IsEmpty) Then
  Begin
    Result.Add(tfpTodos, 0);
    Exit;
  End;

  LQuery.First;
  While Not LQuery.Eof Do
  Begin
    LTipFre := LQuery.FieldByName('FRE_TIPFRE').AsInteger;

    If LTipFre = 0 Then
    Begin
      Result.Add(tfpTodos, LTipFre);
      Break;
    End;

    Case TiposFreteNFe[LTipFre] Of
      tfCif: Result.Add(tfpCif, LTipFre);
      tfFob: Result.Add(tfpFob, LTipFre);
      tfTerceiros: Result.Add(tfpTerceiros, LTipFre);
      tfSemFrete: Result.Add(tfpSemFrete, LTipFre);
      tfTransporteProprioRemetente: Result.Add(tfpTransporteProprioRemetente, LTipFre);
      tfTransporteProprioDestinatario: Result.Add(tfpTransporteProprioDestinatario, LTipFre);
    End;

    LQuery.Next;
  End;
end;

procedure TTiposDeFretePermitidosDAO.GravarTiposDeFrete(
  const ACodTra: String; const ATipFreArray: TIntArray);
begin
  DeletarTiposFrete(ACodTra);
  InserirTiposFrete(ACodTra, ATipFreArray);
end;

procedure TTiposDeFretePermitidosDAO.InserirTiposFrete(const ACodTra: String; const ATipFreArray: TIntArray);
Var
  LQuery : IQuery;
  LTipFre : Integer;
begin
  If Length(ATipFreArray) = 0 Then
    Exit;
  LQuery := FConnection.NewQuery(0);
  LQuery.Close;
  LQuery.SQL.Add(' INSERT INTO FREPRM ( ');
  LQuery.SQL.Add('        FRE_CODTRA ');
  LQuery.SQL.Add('       ,FRE_TIPFRE ');
  LQuery.SQL.Add(' ) ');
  LQuery.SQL.Add(' VALUES ( ');
  LQuery.SQL.Add('        :CODTRA  ');
  LQuery.SQL.Add('       ,:TIPFRE  ');
  LQuery.SQL.Add(' ) ');
  For LTipFre In ATipFreArray Do
  Begin
    LQuery.ParamByName('CODTRA').AsString := ACodTra;
    LQuery.ParamByName('TIPFRE').AsInteger := LTipFre;
    LQuery.ExecSQL;
  End;
end;

end.
