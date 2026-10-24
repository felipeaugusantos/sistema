unit untQryConIteFactory;

interface

uses
  Uni, SysUtils, UniClientDataSet, DB;

type
  TQryConIteFactory = class(TInterfacedObject)
  private
    class var qryGen: TUniQuery;
    class var cdsConIte: TUniClientDataSet;
  public
    class function GetQryContIte(const qryConIte: TUniQuery; const strCodIte: string; const strCodEmp: string): TDataSet;
  end;

implementation
uses untFuncoesSimples;
{ TQryConIteFactory }

class function TQryConIteFactory.GetQryContIte(const qryConIte: TUniQuery; const strCodIte, strCodEmp: string): TDataSet;
begin
  if not Assigned(qryGen) then
    qryGen := fCriaQuery();

  qryGen.Close;
  if (qryGen.SQL.Text <> qryConIte.SQL.Text) or (fEmptyStr(qryGen.SQL.Text)) then
  begin
    If Assigned(cdsConIte) Then
      FreeAndNil(cdsConIte);

    qryGen.SQL.Clear;
    qryGen.Params.Clear;
    qryGen.SQL.Text := qryConIte.SQL.Text;

    If fEmptyStr(qryGen.SQL.Text) Then
      qryGen.SQL.Text := 'SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP';
  end;

  If Assigned(cdsConIte) Then
  Begin
    cdsConIte.Filtered := False;
    cdsConIte.Filter   := 'ITE_CODITE = ' + QuotedStr(strCodIte) + ' AND ' +
                          'ITE_CODEMP = ' + QuotedStr(strCodEmp);
    cdsConIte.Filtered := True;

    If Not cdsConIte.IsEmpty Then
    Begin
      Result := cdsConIte;
      Exit;
    End;
  End;

  qryGen.ParamByName('CODITE').AsString := strCodIte;
  qryGen.ParamByName('CODEMP').AsString := strCodEmp;
  qryGen.Open;

  If Not Assigned(cdsConIte) Then
    cdsConIte := fCriaClientDatset(qryGen)
  Else
    pCopiaRegistroDataSet(qryGen, cdsConIte);

  Result := cdsConIte;
end;

initialization
  TQryConIteFactory.qryGen := nil;
  TQryConIteFactory.cdsConIte := nil;

finalization
  if Assigned(TQryConIteFactory.qryGen) then FreeAndNil(TQryConIteFactory.qryGen);
  if Assigned(TQryConIteFactory.cdsConIte) then FreeAndNil(TQryConIteFactory.cdsConIte);
end.
