unit untNexaConsultaEscolha;

interface

uses
  untNexaConsulta, untFuncoesSimples, Uni, SysUtils, untTypesSistema;

type
  TNexaConsultaEscolha = class(TNexaConsulta)
  private
    procedure pGetEscolhas(var escolhas: TStringArray);
    procedure pGetEscolhasSistema(var escolhas: TStringArray; const strTipo: string);
  public
    function fGetSelect(blnTodos: Boolean): String; override;
    function fGetWhere: String; override;
  end;

implementation

{ TNexaConsultaEscolha }

function TNexaConsultaEscolha.fGetWhere: String;
var
  arrEscolhas: TStringArray;
  intEscolha: Integer;
begin
  Result := ' WHERE TRUE ';
  SetLength(arrEscolhas, 0);
  pGetEscolhas(arrEscolhas);
  if Length(arrEscolhas) >= 2 then
  begin
    intEscolha := fGetMenu('ESCOLHA O TIPO', arrEscolhas, 1, True);
    if intEscolha > 0 then
    begin
      Result := Result + ' AND NEX_TIPO__  = ' + QuotedStr(arrEscolhas[intEscolha - 1]);
      pGetEscolhasSistema(arrEscolhas, arrEscolhas[intEscolha - 1]);
      if Length(arrEscolhas) >= 2 then
      begin
        intEscolha := fGetMenu('ESCOLHA O SISTEMA', arrEscolhas, 1, True);
        if intEscolha > 0 then
          Result := Result + ' AND NEX_SISTEM  = ' + QuotedStr(arrEscolhas[intEscolha - 1]);
      end;
    end;
  end;

end;

function TNexaConsultaEscolha.fGetSelect(blnTodos: Boolean): String;
begin
  Result := inherited fGetSelect(blnTodos);
end;

procedure TNexaConsultaEscolha.pGetEscolhas(var escolhas: TStringArray);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT DISTINCT ' +
        '   NEX_TIPO__    ' +
        ' FROM            ' +
        '   NEX_CADNEX    ';
      qryGen.Open;

      SetLength(escolhas, qryGen.RecordCount);
      while not qryGen.Eof do
      begin
        escolhas[qryGen.RecNo - 1] := qryGen.FieldByName('NEX_TIPO__').AsString;
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

procedure TNexaConsultaEscolha.pGetEscolhasSistema(var escolhas: TStringArray; const strTipo: string);
var
  qryGen: TUniQuery;
begin
  qryGen := nil;
  Try
    Try
      qryGen := fCriaQuery();
      qryGen.SQL.Text :=
        ' SELECT DISTINCT          ' +
        '   NEX_SISTEM             ' +
        ' FROM                     ' +
        '   NEX_CADNEX             ' +
        ' WHERE NEX_TIPO__ = :TIPO ';
      qryGen.ParamByName('TIPO').AsString := strTipo;
      qryGen.Open;

      SetLength(escolhas, qryGen.RecordCount);
      while not qryGen.Eof do
      begin
        if not fEmptyStr(qryGen.FieldByName('NEX_SISTEM').AsString) then
          escolhas[qryGen.RecNo - 1] := qryGen.FieldByName('NEX_SISTEM').AsString;
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

end.
