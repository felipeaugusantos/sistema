unit untTRepositorioAjusteIcms;

interface

uses System.Generics.Collections, Uni, SysUtils,
     untTAjusteIcms, untTypesSistema, untTRepositorioAjusteIcmsAbstract;

type
  //repositorio dos ajustes de icms pela tabela "AJUICM" + "AJUSTE"
  TRepositorioAjusteIcms = class(TRepositorioAjusteIcmsAbstract)
  private
    function fRetSQL(dtaDataInicial: TDateTime; strCodEmp: string): string;
  public
    function fRetListaAjusteIcms(dtaIni, dtaFin: TDateTime; strCodEmp: string = ''): TObjectList<TAjusteIcms>; override;
  end;

implementation

{ TRepositorioAjusteIcms }

function TRepositorioAjusteIcms.fRetListaAjusteIcms(dtaIni, dtaFin: TDateTime; strCodEmp: string = ''): TObjectList<TAjusteIcms>;
  var
    ajuste: TAjusteIcms;
    qryAux: TUniQuery;
begin
  Result := FListaAjustes;

  qryAux := TUniQuery.Create(nil);
  qryAux.connection := FConexao;
  try
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := fRetSQL(dtaIni, strCodEmp);
      ParamByName('DTAINI').AsDateTime := dtaIni;
      ParamByName('DTAFIN').AsDateTime := dtaFin;

      if strCodEmp <> '' then
        ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      First;
      while not Eof do
      begin
        ajuste := TAjusteIcms.Create;
        ajuste.strObservacao := FieldByName('OBSERV').AsString;
        ajuste.strTipo := FieldByName('TIPO').AsString;
        ajuste.fltValor := FieldByName('VALOR').AsFloat;

        Result.Add(ajuste);

        Next;
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

function TRepositorioAjusteIcms.fRetSQL(dtaDataInicial: TDateTime; strCodEmp: string): string;
begin
  Result := '';
  Result := Result + 'SELECT ';
  Result := Result + '   A.AJU_VALAJU AS VALOR, ';
  Result := Result + '   A.AJU_OBSERV AS OBSERV, ';
  Result := Result + '   B.AJU_TIPAJU AS TIPO ';
  Result := Result + 'FROM ';
  Result := Result + '  AJUICM A ';

  Result := Result + '  LEFT JOIN AJUSTE B ';
  Result := Result + '    ON B.AJU_CODAJU = A.AJU_CODAJU ';

  Result := Result + 'WHERE CAST(CONCAT(RIGHT(AJU_MESANO, 04), LEFT(AJU_MESANO, 02), "' + FormatDateTime('DD', dtaDataInicial) + '") AS DATE) BETWEEN :DTAINI ';
  Result := Result + '  AND :DTAFIN ';
  Result := Result + '  AND IFNULL(B.AJU_ENVAPU, "N") = "S" ';

  if strCodEmp <> '' then
    Result := Result + '  AND LOCATE(A.AJU_CODEMP, :CODEMP) > 0 ';
end;

end.
