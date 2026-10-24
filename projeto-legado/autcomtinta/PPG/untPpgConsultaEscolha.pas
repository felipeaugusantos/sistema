unit untPpgConsultaEscolha;

interface

uses
  untPpgConsulta, untFuncoesSimples, Uni, SysUtils, untTypesSistema;

type
  TPpgConsultaEscolha = class(TPpgConsulta)
  private
    procedure pGetEscolhas(var escolhas: TStringArray);
    procedure pGetEscolhasSistema(var escolhas: TStringArray; const strTipo: string);
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetWhere: String; override;
  end;

implementation

{ TPpgConsultaEscolha }

procedure TPpgConsultaEscolha.pGetEscolhas(var escolhas: TStringArray);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT DISTINCT ' +
        '   PPG_TIPO__    ' +
        ' FROM            ' +
        '   PPG_CADPPG    ';
      qryGen.Open;

      SetLength(escolhas, qryGen.RecordCount);
      while not qryGen.Eof do
      begin
        escolhas[qryGen.RecNo - 1] := qryGen.FieldByName('PPG_TIPO__').AsString;
        qryGen.Next;
      end;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;


procedure TPpgConsultaEscolha.pGetEscolhasSistema(var escolhas: TStringArray; const strTipo: string);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT DISTINCT          ' +
        '   PPG_SISTEM             ' +
        ' FROM                     ' +
        '   PPG_CADPPG             ' +
        ' WHERE PPG_TIPO__ = :TIPO ';
      qryGen.ParamByName('TIPO').AsString := strTipo;
      qryGen.Open;

      SetLength(escolhas, qryGen.RecordCount);
      while not qryGen.Eof do
      begin
        if not fEmptyStr(qryGen.FieldByName('PPG_SISTEM').AsString) then
          escolhas[qryGen.RecNo - 1] := qryGen.FieldByName('PPG_SISTEM').AsString;
        qryGen.Next;
      end;

    Except
      on E: Exception do
      begin
        raise;
      end;
    End;
  Finally
    if Assigned(qryGen) then FreeAndNil(qryGen);
  End;
end;

function TPpgConsultaEscolha.fGetWhere: String;
var
  arrEscolhas: TStringArray;
  intEscolha: Integer;
begin
  SetLength(arrEscolhas, 0);
  pGetEscolhas(arrEscolhas);
  if Length(arrEscolhas) >= 2 then
  begin
    intEscolha := fGetMenu('ESCOLHA O TIPO', arrEscolhas, 1, True);
    if intEscolha > 0 then
    begin
      Result := Result + ' AND PPG_TIPO__  = ' + QuotedStr(arrEscolhas[intEscolha - 1]);
      pGetEscolhasSistema(arrEscolhas, arrEscolhas[intEscolha - 1]);
      if Length(arrEscolhas) >= 2 then
      begin
        intEscolha := fGetMenu('ESCOLHA O SISTEMA', arrEscolhas, 1, True);
        if intEscolha > 0 then
          Result := Result + ' AND PPG_SISTEM  = ' + QuotedStr(arrEscolhas[intEscolha - 1]);
      end;
    end;
  end;

end;

function TPpgConsultaEscolha.fGetSelect(blnTodos: Boolean): String;
begin
  Result := inherited fGetSelect(blnTodos) + fGetWhere;
end;

end.
