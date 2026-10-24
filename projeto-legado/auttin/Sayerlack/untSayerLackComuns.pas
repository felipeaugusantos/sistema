unit untSayerLackComuns;

interface

uses
  SysUtils, Uni;

type
  TSayerLackComuns = class(TInterfacedObject)
  public
    class function GetEmbala(const strDescri: string): Double;
    class function fRetornaDesUni(strCodUni: String): String;
    class function fRetornaEmbala(strDescri: String): Double;
  end;

implementation

uses untFuncoesSimples;

{ TSayerLackComuns }

class function TSayerLackComuns.fRetornaDesUni(strCodUni: String): String;
Var
  qryUni: TUniQuery;
begin
  qryUni := fCriaQuery;
  Try
    qryUni.Close;
    qryUni.SQL.Text := 'SELECT UNI_DESUNI FROM CADUNI WHERE UNI_CODUNI = :CODUNI';
    qryUni.ParamByName('CODUNI').AsString := strCodUni;
    qryUni.Open;
    Result := qryUni.FieldByName('UNI_DESUNI').AsString;
  Finally
    FreeAndNil(qryUni);
  End;
end;

class function TSayerLackComuns.fRetornaEmbala(strDescri: String): Double;
Var
  qryEmb: TUniQuery;
begin
  qryEmb := fCriaQuery;
  Try
    qryEmb.Close;
    qryEmb.SQL.Text := 'SELECT EMB_EMBALA FROM SAY_CADEMB WHERE EMB_DESEMB = :DESEMB';
    qryEmb.ParamByName('DESEMB').AsString := strDescri;
    qryEmb.Open;
    Result := qryEmb.FieldByName('EMB_EMBALA').AsFloat;
  Finally
    FreeAndNil(qryEmb);
  End;
end;

class function TSayerLackComuns.GetEmbala(const strDescri: string): Double;
begin
  if Trim(UpperCase(strDescri)) = 'QT' then
    Result := 0.81
  else if Trim(UpperCase(strDescri)) = 'GL' then
    Result := 3.24
  else if Trim(UpperCase(strDescri)) = 'BH' then
    Result := 18
  else
    Result := 1;
end;

end.
