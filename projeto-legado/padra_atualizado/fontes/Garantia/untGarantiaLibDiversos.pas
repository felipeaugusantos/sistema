unit untGarantiaLibDiversos;

interface

function fConcatenar(ArrString: array of String; chrSeparador: Char = #0): String;
function fObterNumDuplicata: String;

function fSqlObterFornecedorFilial: String;
function fObterFornecedorFilial(const strCodEmp: String): String;
function fGetCFOPReposicaoPD(strEstCli: String): String;

implementation
uses
  System.StrUtils, System.SysUtils, untFuncoesSimples, uni,  untFatDigDadosGarantia, Vcl.Controls;

function fConcatenar(ArrString: array of String; chrSeparador: Char = #0): String;
Var
  intIdx: integer;
  blnTemSeparador: Boolean;
begin
  blnTemSeparador := chrSeparador <> #0;
  Result := EmptyStr;
  for intIdx := 0 to length(ArrString) -1 do
  begin
    Result := Result + ArrString[intIdx];

    if blnTemSeparador then
    begin
      if intIdx < (length(arrString)-1) then
        Result := Result + '-';
    end;
  end;
end;

function fObterNumDuplicata: String;
begin
  Result := fRetSequencial('PROCCO', VS_strCodEmp, fTamDocCadRec);
end;

function fSqlObterFornecedorFilial: String;
begin
 Result := ' SELECT EMP_FORFIL FROM CADEMP  WHERE EMP_CODEMP = :CODEMP ';
end;

function fObterFornecedorFilial(const strCodEmp: String): String;
Var
  Qry: TUniQuery;
begin
  Result := EmptyStr;
  Qry := Nil;
  Try
    Qry := fCriaQuery;
    Qry.Close;
    Qry.Sql.Add(fSqlObterFornecedorFilial);
    Qry.ParamByName('CODEMP').AsString := strCodEmp;
    Qry.Open;
    if Not Qry.IsEmpty then
    begin
     Result := Qry.FieldByName('EMP_FORFIL').AsString;
    end;
  Finally
    if Assigned(Qry) then
      Qry.Free;
  End;
end;

function fGetCFOPReposicaoPD(strEstCli: String): String;
 Var
  blnOperacaoInterEstadual: Boolean;
begin
  blnOperacaoInterEstadual :=  SameText(strEstCli, fCadEmp('ESTADO')) = False;
  If blnOperacaoInterEstadual  Then
    Result := '6'
  Else
    Result := '5';

  Result := Result + '949';

end;

end.
