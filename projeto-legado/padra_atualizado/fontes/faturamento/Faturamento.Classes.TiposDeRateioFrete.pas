unit Faturamento.Classes.TiposDeRateioFrete;

interface

uses untConnection, System.Generics.Collections, untTypesSistema;

type
  TTiposDeRateioFrete = (trfTodos, trfCif, trfFob, trfTerceiros, trfSemFrete, trfTransporteProprioRemetente, trfTransporteProprioDestinatario);
  TArrTiposDeRateioFrete = Array Of TTiposDeRateioFrete;

  TTiposDeRateioFreteDAO = class
  private
    FConnection : IConnection;
    procedure InserirTiposDeRateioFrete(
  const ACodigoTransportadora: String; const ATipFreArray : TIntArray);
    procedure DeletarTiposDeRateioFrete(const ACodigoTransportadora : String);
  public
    function GetTiposDeRateioFrete(const ACodigoTransportadora : String) : TDictionary<TTiposDeRateioFrete, Integer>;
    procedure GravarTiposDeRateioFrete(const ACodigoTransportadora : String; const ATipFreArray : TIntArray);
    constructor Create(const AConnection : IConnection);
  End;

implementation

uses untQuery, untTipoFreteAtc, untInterfaces;

{ TTiposDeRateioFrete }

constructor TTiposDeRateioFreteDAO.Create(const AConnection: IConnection);
begin
  FConnection := AConnection;
end;

procedure TTiposDeRateioFreteDAO.DeletarTiposDeRateioFrete(
  const ACodigoTransportadora: String);
  Var
    LQuery : IQuery;
begin
  LQuery := FConnection.NewQuery(0);
  LQuery.Close;
  LQuery.SQL.Add(' DELETE ');
  LQuery.SQL.Add('   FROM FRERAO ');
  LQuery.SQL.Add('  WHERE RAO_CODTRA = :CODTRA ');
  LQuery.ParamByName('CODTRA').AsString := ACodigoTransportadora;
  LQuery.ExecSQL;
end;

function TTiposDeRateioFreteDAO.GetTiposDeRateioFrete(
  const ACodigoTransportadora: String): TDictionary<TTiposDeRateioFrete, Integer>;
  Var
    LQuery : IQuery;
    LTipFre : Integer;
begin
  Result := TDictionary<TTiposDeRateioFrete, Integer>.Create;

  LQuery := FConnection.NewQuery(0);
  LQuery.Close;
  LQuery.SQL.Add(' SELECT * ');
  LQuery.SQL.Add('   FROM FRERAO ');
  LQuery.SQL.Add('  WHERE RAO_CODTRA = :CODTRA ');
  LQuery.ParamByName('CODTRA').AsString := ACodigoTransportadora;
  LQuery.Open;

  If (LQuery.IsEmpty) Then
  Begin
    Result.Add(trfTodos, -1);
    Exit;
  End;

  LQuery.First;
  While Not LQuery.Eof Do
  Begin
    If (LQuery.FieldByName('RAO_TIPFRE').AsInteger <= 0) Then
    Begin
      Result.Add(trfTodos, -1);
      Exit;
    End;

    LTipFre := LQuery.FieldByName('RAO_TIPFRE').AsInteger;
    Case TiposFreteNFe[LTipFre] Of
      tfCif: Result.Add(trfCif, LTipFre);
      tfFob: Result.Add(trfFob, LTipFre);
      tfTerceiros: Result.Add(trfTerceiros, LTipFre);
      tfSemFrete: Result.Add(trfSemFrete, LTipFre);
      tfTransporteProprioRemetente: Result.Add(trfTransporteProprioRemetente, LTipFre);
      tfTransporteProprioDestinatario: Result.Add(trfTransporteProprioDestinatario, LTipFre);
    End;

    LQuery.Next;
  End;
end;

procedure TTiposDeRateioFreteDAO.GravarTiposDeRateioFrete(const ACodigoTransportadora : String; const ATipFreArray : TIntArray);
begin
  DeletarTiposDeRateioFrete(ACodigoTransportadora);
  InserirTiposDeRateioFrete(ACodigoTransportadora, ATipFreArray);
end;

procedure TTiposDeRateioFreteDAO.InserirTiposDeRateioFrete(
  const ACodigoTransportadora: String; const ATipFreArray : TIntArray);
  Var
    LQuery : IQuery;
    LTipFre : Integer;
begin
  If Length(ATipFreArray) = 0 Then
    Exit;
  LQuery := FConnection.NewQuery(0);
  LQuery.Close;
  LQuery.SQL.Add(' INSERT INTO FRERAO ( ');
  LQuery.SQL.Add('        RAO_CODTRA ');
  LQuery.SQL.Add('       ,RAO_TIPFRE ');
  LQuery.SQL.Add(' ) ');
  LQuery.SQL.Add(' VALUES ( ');
  LQuery.SQL.Add('        :CODTRA  ');
  LQuery.SQL.Add('       ,:TIPFRE  ');
  LQuery.SQL.Add(' ) ');
  For LTipFre In ATipFreArray Do
  Begin
    LQuery.ParamByName('CODTRA').AsString := ACodigoTransportadora;
    LQuery.ParamByName('TIPFRE').AsInteger := LTipFre;
    LQuery.ExecSQL;
  End;
end;

end.
