unit Contabilidade.Classes.TTrataIncDoc;

interface

uses
  Contabilidade.Interfaces, Uni, Classes ;

type
   TTrataIncDocContabil = class(TInterfacedObject, ITrataIncDocContabil)
   private
     FstrColunaIncDoc: String ;
     FstrIncDoc: String ;
     FvetIncDoc: TArrIncDoc ;
     FqryConsulta: TUniQuery ;
   public
     function fColunaIncDoc(const AstrValue: String): ITrataIncDocContabil; overload ;
     function fColunaIncDoc: String; overload ;
     function fQuerySql(AqryValue: TUniQuery): ITrataIncDocContabil;
     function fIncDoc(const AstrValue: String): ITrataIncDocContabil; overload ;
     function fIncDoc: String; overload ;
     function fArrIncDoc(const AValue: TArrIncDoc): ITrataIncDocContabil; overload ;
     function fArrIncDoc: TArrIncDoc; overload ;
     function fExecute: String ;
     constructor Create ;
     class function New: ITrataIncDocContabil ;
   end ;

   TTrataConLog = class(TInterfacedObject, ITrataConLog)
   private
     FListProcessado: TStringList ;
     FstrIncDoc: String ;
     FarrayIncDoc: TArrIncDoc ;
     FstrTipLan: String ;
     FqryConsulta: TUniQuery ;
   public
     function fIncDoc(const AstrValue: String): ITrataConLog;
     function fArrIncDoc(const AValue: TArrIncDoc): ITrataConLog;
     function fLstProcessado(var AValue: TStringList): ITrataConLog;
     function fTipLan(const AstrValue: String): ITrataConLog;
     function fQuerySql(AqryValue: TUniQuery): ITrataConLog;
     function fRetornaAutoIncConLog: Int64 ;

     constructor Create ;
     class function New: ITrataConLog ;
   end ;

  function fArrIncDocToString(const AarrIncDoc: TArrIncDoc): String ;

implementation

uses
  SysUtils ;

function fArrIncDocToString(const AarrIncDoc: TArrIncDoc): String ;
var
  LintCnt: Integer ;
begin
  Result := '' ;
  for LintCnt := Low(AarrIncDoc) to High(AarrIncDoc) do
  begin
    if Trim(Result) = '' then
      Result := QuotedStr(AarrIncDoc[LintCnt].IncDoc)
    else
      Result := Result + ',' + QuotedStr(AarrIncDoc[LintCnt].IncDoc) ;
  end ;
end ;

{ TTrataIncDocContabil }

constructor TTrataIncDocContabil.Create;
begin
  FstrColunaIncDoc := '' ;
  FstrIncDoc := '' ;
  SetLength(FvetIncDoc, 0) ;
  FqryConsulta := Nil ;
end;

function TTrataIncDocContabil.fArrIncDoc(
  const AValue: TArrIncDoc): ITrataIncDocContabil;
begin
  Result := Self ;
  FvetIncDoc := AValue ;
end;

function TTrataIncDocContabil.fArrIncDoc: TArrIncDoc;
begin
  Result := FvetIncDoc ;
end;

function TTrataIncDocContabil.fColunaIncDoc(
  const AstrValue: String): ITrataIncDocContabil;
begin
  Result := Self ;
  FstrColunaIncDoc := AstrValue ;
end;

function TTrataIncDocContabil.fColunaIncDoc: String;
begin
  Result := FstrColunaIncDoc ;
end;

function TTrataIncDocContabil.fIncDoc(
  const AstrValue: String): ITrataIncDocContabil;
begin
  Result := Self ;
  FstrIncDoc := AstrValue ;
end;

function TTrataIncDocContabil.fIncDoc: String;
begin
  Result := FstrIncDoc ;
end;

function TTrataIncDocContabil.fQuerySql(
  AqryValue: TUniQuery): ITrataIncDocContabil;
begin
  Result := Self ;
  FqryConsulta := AqryValue ;
end;

class function TTrataIncDocContabil.New: ITrataIncDocContabil;
begin
  Result := Self.Create ;
end;

function TTrataIncDocContabil.fExecute: String;
begin
  Result := '' ;

  if Length(FvetIncDoc) > 0 then
  begin
    Result := '   AND ' + FstrColunaIncDoc + ' IN (' + fArrIncDocToString(FvetIncDoc) + ') ' ;
    if Assigned(FqryConsulta) then
      FqryConsulta.SQL.Add(Result) ;
  end
  else
  begin
    if trim(FstrIncDoc) <> '' then
    begin
      Result := '   AND ' + FstrColunaIncDoc + ' = :INCDOC ' ;
      if Assigned(FqryConsulta) then
      begin
        FqryConsulta.SQL.Add(Result) ;
        FqryConsulta.ParamByName('INCDOC').AsString := FstrIncDoc ;
      end ;
    end ;
  end ;

end;

{ TTrataConLog }

constructor TTrataConLog.Create;
begin
  FListProcessado := Nil ;
  FstrIncDoc := '' ;
  FstrTipLan := '' ;
  FqryConsulta := Nil ;
  SetLength(FarrayIncDoc,0) ;
end;

function TTrataConLog.fArrIncDoc(const AValue: TArrIncDoc): ITrataConLog;
begin
  Result := Self ;
  FarrayIncDoc := AValue ;
end;

function TTrataConLog.fIncDoc(const AstrValue: String): ITrataConLog;
begin
  Result := Self ;
  FstrIncDoc := AstrValue ;
end;

function TTrataConLog.fLstProcessado(var AValue: TStringList): ITrataConLog;
begin
  Result := Self ;
  FListProcessado := AValue ;
end;

function TTrataConLog.fQuerySql(AqryValue: TUniQuery): ITrataConLog;
begin
  Result := Self ;
  FqryConsulta := AqryValue ;
end;

function TTrataConLog.fRetornaAutoIncConLog: Int64;
var
  LintCnt: Integer ;
  LstrIncDoc: String ;
  LstrNumDoc: String ;
  LstrEspDoc: String ;
  LstrCodEmp: String ;
begin
  Result := 0 ;

  if FstrTipLan = 'ADT' then
  begin
    if Assigned(FqryConsulta) then
    begin
      LstrNumDoc := Copy(FstrIncDoc, 1, 12) ;
      LstrEspDoc := Copy(FstrIncDoc, 13, 2) ;
      LstrCodEmp := Copy(FstrIncDoc, 15, 3) ;

      FqryConsulta.Close ;
      FqryConsulta.SQL.Clear ;
      FqryConsulta.SQL.Add(' SELECT AUTOINCREM FROM ADTCLI ') ;
      FqryConsulta.SQL.Add(' WHERE ADT_NUMDOC = :NUMDOC ') ;
      FqryConsulta.SQL.Add(' AND ADT_ESPDOC = :ESPDOC ') ;
      FqryConsulta.SQL.Add(' AND ADT_CODEMP = :CODEMP ') ;
      FqryConsulta.ParamByName('NUMDOC').AsString := LstrNumDoc ;
      FqryConsulta.ParamByName('ESPDOC').AsString := LstrEspDoc ;
      FqryConsulta.ParamByName('CODEMP').AsString := LstrCodEmp ;
      FqryConsulta.Open ;
      LstrIncDoc := FqryConsulta.FieldByName('AUTOINCREM').AsString ;
    end
    else
      LstrIncDoc := FstrIncDoc ;
  end
  else
    LstrIncDoc := FstrIncDoc ;

  for LintCnt := Low(FarrayIncDoc) to High(FarrayIncDoc) do
  begin
    if FarrayIncDoc[LintCnt].IncDoc = LstrIncDoc then
    begin
      Result := FarrayIncDoc[LintCnt].ConLog ;
      Break ;
    end ;
  end ;

  if Assigned(FListProcessado) then
    FListProcessado.Add(IntToStr(Result)) ;

end;

function TTrataConLog.fTipLan(const AstrValue: String): ITrataConLog;
begin
  Result := Self ;
  FstrTipLan := AstrValue ;
end;

class function TTrataConLog.New: ITrataConLog;
begin
  Result := Self.Create ;
end;

end.
