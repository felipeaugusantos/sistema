unit untFuncoesTinta;

interface

  Uses Uni, SysUtils, untConfTinta, untIConfTinta;

  procedure pChecaCadastroUnidade; Stdcall;
  function fGetConfTinta(strIdePro, strCodEmp: String): IConfTinta; Stdcall;
  function fAjustaInicialAutoIncremento(strTabela, strCodEmp: String): Integer; Stdcall;

implementation

uses untFuncoesGen, Data.DB;

function fGetConfTinta(strIdePro, strCodEmp: String): IConfTinta;
Begin
  Result := TConfTinta.Create(strIdePro, strCodEmp);
End;

procedure pChecaCadastroUnidade;
  Var
    qryGen: TUniQuery;
    intCon: Integer;
  const
    arrCodUni: Array [0..2] Of Array [0..1] Of String = (('LA','LATA'),('GL','GALÃO'),('LT','LITRO'));
Begin

  qryGen := fCriaQuery(Nil);

  For intCon := 0 To 2 Do
  Begin

    With qryGen Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM CADUNI WHERE UNI_CODUNI = :CODUNI');
      ParamByName('CODUNI').AsString := arrCodUni[intCon][0];
      Open;

      If IsEmpty Then
      Begin
        Append;
        FieldByName('UNI_CODUNI').AsString := arrCodUni[intCon][0];
        FieldByName('UNI_DESUNI').AsString := arrCodUni[intCon][1];
        FieldByName('UNI_CODEMP').AsString := VS_strCodEmp;
        FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('CADUNI', VS_strCodEmp);
        FieldByName('UNI_PESLIT').AsFloat  := 0;
        FieldByName('UNI_SIGUNI').AsString := arrCodUni[intCon][0];
        Post;
      End;

    End;

  End;

  FreeAndNil(qryGen);

End;

function fAjustaInicialAutoIncremento(strTabela, strCodEmp: String): Integer;
  Var
    qryGen: TUniQuery;

  function fGravaAutoIncrem(strNomeTabela: String; intAutInc: Integer): Boolean;
    Var
      qryGenCod: TUniQuery;
  begin
    qryGenCod := fCriaQuery(Nil);

    Try
      With qryGenCod Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('UPDATE PROINC SET PRO_AUTINC = :AUTINC WHERE PRO_NOMARQ = :NOMARQ');
        ParamByName('AUTINC').AsInteger := intAutInc;
        ParamByName('NOMARQ').AsString  := strNomeTabela;
        ExecSQL;
        Close;
        Result := True;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pErro(E.Message);
      End;
    End;

    FreeAndNil(qryGenCod);
  end;

begin
  qryGen := fCriaQuery(Nil);
  qryGen.SQL.Text := 'SELECT IFNULL(CAST(MAX(LEFT( RIGHT(AUTOINCREM, 17), 11)) AS UNSIGNED INTEGER), 0) + 1 AUTO FROM ' + strTabela + ' WHERE RIGHT(AUTOINCREM, 3) = "' + strCodEmp + '"';
  qryGen.Open;
  Result := qryGen.FieldByName('AUTO').AsInteger;
  fGravaAutoIncrem(strTabela, qryGen.FieldByName('AUTO').AsInteger);
  FreeAndNil(qryGen);
end;

end.
