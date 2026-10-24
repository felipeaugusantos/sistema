//# para uso futuro.
//# usar a classe untTConstantesCfop

unit untTVerificaEnquadramento;

interface

uses System.Classes,
     System.StrUtils,
     System.SysUtils,
     Uni;

type
  TVerificaEnquadramento = class
  private
    FQryAux: TUniQuery;
    function fRetSQLEnquadrameno: string;
    procedure pTodosEnquadrameno;

  public
    function fRetEnquadramentosCfopDuplicado(strCodEnq, strCfopEnq: string): string;

  end;

implementation

uses untFuncoes;


{ TVerificaEnquadramento }

function TVerificaEnquadramento.fRetEnquadramentosCfopDuplicado(strCodEnq, strCfopEnq: string): string;
  var
    i, i1, i2, intPos: Integer;
    blnPassou: boolean;
    stlCfopQuebra, stlCfopEncontrado: TStringList;
    strCfop, strCfopQuebrado, strCfopEncontrado: string;
begin
  Result:='';
  blnPassou := False;
  stlCfopQuebra := TStringList.Create;
  stlCfopEncontrado := TStringList.Create;
  FQryAux := fCriaQuery(nil);
  try
    with FQryAux do
    begin
      pTodosEnquadrameno;

      First;
      while not eof do
      begin

        if fEmptyStr(strCodEnq) then
        begin
          strCfop := FieldByName('ENQ_CLAFIS').AsString;

          //# guarda o Cfop por linha unica SQL para comparação.
          for i1:= 1 to Length(strCfop) do
          begin
            strCfopQuebrado := strCfopQuebrado + Copy(strCfop, i1, 1);
            if (Length(strCfopQuebrado) = 4) then
            begin
              for i2:= 0 to stlCfopQuebra.Count - 1 do
              begin
                if not stlCfopQuebra.Find(strCfopQuebrado + '(' + FieldByName('ENQ_DESENQ').AsString + ')', intPos) then
                begin
                  if (strCfopQuebrado) = (LeftStr(stlCfopQuebra.Strings[i2],4)) then
                  begin
                    strCfopEncontrado := strCfopQuebrado + '(' + FieldByName('ENQ_DESENQ').AsString + ')' + ',';
                    stlCfopEncontrado.Add(strCfopEncontrado);
                    stlCfopEncontrado.Add(stlCfopQuebra.Strings[i2] + ',');
                  end;
                end;
              end;

              stlCfopQuebra.Add(strCfopQuebrado + '(' + FieldByName('ENQ_DESENQ').AsString + ')');
              strCfopQuebrado:= '';
            end;
          end;

        end
        else
        begin

          //# guarda o Cfop selecionado.
          if not (blnPassou) then
          begin
            for i1:= 1 to Length(strCfopEnq) do
            begin
              strCfopQuebrado := strCfopQuebrado + Copy(strCfopEnq, i1, 1);
              if (Length(strCfopQuebrado) = 4) then
              begin
                stlCfopQuebra.Add(strCfopQuebrado);
                strCfopQuebrado:= '';
              end;
            end;
            blnPassou := True;
          end;

          //# guarda o Cfop por linha unica SQL para comparação pelo Cfop selecionado.
          if (strCodEnq) <> (FieldByName('ENQ_CODENQ').AsString) then
          begin
            strCfopQuebrado:= '';
            strCfop := FieldByName('ENQ_CLAFIS').AsString;

            for i2:= 0 to stlCfopQuebra.Count - 1 do
            begin
              for i1:= 1 to Length(strCfop) do
              begin
                strCfopQuebrado := strCfopQuebrado + Copy(strCfop, i1, 1);
                if (Length(strCfopQuebrado) = 4) then
                begin
                  if (strCfopQuebrado) = (stlCfopQuebra.Strings[i2]) then
                  begin
                    strCfopEncontrado := strCfopQuebrado + '(' + FieldByName('ENQ_DESENQ').AsString + ')' + ',';
                    stlCfopEncontrado.Add(strCfopEncontrado);
                  end;
                  strCfopQuebrado:= '';
                end;
              end;
            end;

          end;
        end;

        Next;
      end;

      if (stlCfopEncontrado.Count > 0) then
      begin
        stlCfopEncontrado.Sort;
        for i:= 0 to stlCfopEncontrado.Count - 1 do
        begin
          if Pos(LeftStr(stlCfopEncontrado.Strings[i],7), Result) <= 0 then
            Result := Result + Trim(stlCfopEncontrado.Strings[i]);
        end;
        Result := Copy(Result, 1, Length(Result)-1);
      end
      else
        Result := '';

    end;
  finally
    FQryAux.Free;
  end;

end;

function TVerificaEnquadramento.fRetSQLEnquadrameno: string;
  var
    strSQL: string;
begin
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CAD.ENQ_CODENQ, ';
  strSQL := strSQL + '  LEFT(DES.ENQ_DESENQ, 1) AS ENQ_DESENQ, ';
  strSQL := strSQL + '  CAD.ENQ_CLAFIS, ';
  strSQL := strSQL + '  CAD.ENQ_CODFIS, ';
  strSQL := strSQL + '  CAD.AUTOINCREM ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADENQ CAD';
  strSQL := strSQL + '  LEFT JOIN DESENQ DES';
  strSQL := strSQL + '    ON DES.AUTOINCREM = CAD.ENQ_CODENQ ';
  strSQL := strSQL + ' ORDER BY LEFT(DES.ENQ_DESENQ, 1) ';

  Result := strSQL;
end;

procedure TVerificaEnquadramento.pTodosEnquadrameno;
begin
  FQryAux.Close;
  FQryAux.SQL.Clear;
  FQryAux.SQL.Text := fRetSQLEnquadrameno;
  FQryAux.Open;
end;

end.
