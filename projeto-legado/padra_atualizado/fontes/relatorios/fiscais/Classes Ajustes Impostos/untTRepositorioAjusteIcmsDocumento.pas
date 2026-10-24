unit untTRepositorioAjusteIcmsDocumento;

interface

uses System.Generics.Collections, Uni, SysUtils,
     untTAjusteIcms, untTypesSistema, untTRepositorioAjusteIcmsAbstract;

type
  //repositorio dos ajustes de icms pela tabela "FISAJU" + "AJUSTE"
  TRepositorioAjusteIcmsDocumento = class(TRepositorioAjusteIcmsAbstract)
  private
    function fRetSQL(strCodEmp: string): string;
  public
    function fRetListaAjusteIcms(dtaIni, dtaFin: TDateTime; strCodEmp: string = ''): TObjectList<TAjusteIcms>; override;
  end;

implementation

{ TRepositorioAjusteIcmsDocumento }

function TRepositorioAjusteIcmsDocumento.fRetListaAjusteIcms(dtaIni, dtaFin: TDateTime; strCodEmp: string = ''): TObjectList<TAjusteIcms>;
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
      SQL.Text := fRetSQL(strCodEmp);
      ParamByName('DTAINI').AsDateTime := dtaIni;
      ParamByName('DTAFIN').AsDateTime := dtaFin;

      if strCodEmp <> '' then
        ParamByName('CODEMP').AsString := strCodEmp;

      Open;

      First;
      while not Eof do
      begin
        ajuste := TAjusteIcms.Create;
        ajuste.strTipo := FieldByName('TIPO').AsString;
        ajuste.fltValor := FieldByName('VALOR').AsFloat;
        ajuste.strObservacao := '';

        Result.Add(ajuste);

        Next;
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

function TRepositorioAjusteIcmsDocumento.fRetSQL(strCodEmp: string): string;
begin
  Result := '';

  Result := Result + 'SELECT ';
  Result := Result + '   A.AJU_VALICM AS VALOR, ';
  Result := Result + '   B.AJU_TIPAJU AS TIPO ';
  Result := Result + 'FROM ';
  Result := Result + '  CADFIS F ';

  Result := Result + '  INNER JOIN FISAJU A ';
  Result := Result + '    ON A.AJU_SEQGER = F.AUTOINCREM ';

  Result := Result + '  INNER JOIN AJUSTE B ';
  Result := Result + '    ON B.AJU_CODAJU = A.AJU_CD_AJU ';

  Result := Result + 'WHERE FIS_DTAENT BETWEEN :DTAINI ';
  Result := Result + '  AND :DTAFIN ';
  Result := Result + '  AND IFNULL(B.AJU_ENVAPU, "N") = "S" ';

  if strCodEmp <> '' then
    Result := Result + '  AND LOCATE(FIS_CODEMP, :CODEMP) > 0 ';
end;

end.
