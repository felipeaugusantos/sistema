unit untTUtilidadeCat42;

interface

uses Uni;


type
  TUtilidadeCat42 = class
  private
  public
    procedure pDeletarPeriodoEmpresa(var blnRet: Boolean; strMesano, strEmpresa: string);
    function fRetAliquotaICMS(strCodEmp, strCodIte: String): double;

  end;

implementation

uses untFuncoes;


{ TUtilidadeCat42 }

function TUtilidadeCat42.fRetAliquotaICMS(strCodEmp, strCodIte: String): double;
  var
    qryAux: TUniQuery;
begin

  qryAux := fCriaQuery(nil);
  try
    Result := 0;

    with qryAux do
    begin
      Close;
      SQL.Clear;

      SQL.Add(' ');
      SQL.Add(' SELECT ');
      SQL.Add('   TB_GER.ITE_CODEMP, ');
      SQL.Add('   TB_GER.ITE_CODITE, ');
      SQL.Add('   ABF_ALQICM_ENT_PEJ_GER, ');
      SQL.Add('   TB_GER.ITE_CODEMP, ');
      SQL.Add('   IFNULL(ABF_ALQICM_ENT_PEJ_GER, 0) AS ABF_ALQICM_ENT_PEJ_GER, ');
      SQL.Add('   IFNULL(ABF_ALQICM_ENT_PEJ_ITE, 0) AS ABF_ALQICM_ENT_PEJ_ITE, ');

      SQL.Add('   CASE WHEN (ABF_ALQICM_ENT_PEJ_ITE > 0) AND (IFNULL(ABF_ALQICM_ENT_PEJ_GER, 0) = 0) THEN ABF_ALQICM_ENT_PEJ_ITE ');
      SQL.Add('        WHEN (ABF_ALQICM_ENT_PEJ_ITE > 0) AND (IFNULL(ABF_ALQICM_ENT_PEJ_GER, 0) > 0) THEN ABF_ALQICM_ENT_PEJ_GER ');
      SQL.Add('        WHEN (ABF_ALQICM_ENT_PEJ_ITE = 0) AND (IFNULL(ABF_ALQICM_ENT_PEJ_GER, 0) > 0) THEN ABF_ALQICM_ENT_PEJ_GER ');
      SQL.Add('     ELSE 0 ');
      SQL.Add('   END ALIQICMS ');

      SQL.Add(' FROM ');
      SQL.Add('   (SELECT ');
      SQL.Add('     "ITEGER" AS HIST, ');
      SQL.Add('     ITE_CODEMP AS ITE_CODEMP, ');
      SQL.Add('     GER.ITE_CODITE AS ITE_CODITE, ');
      SQL.Add('     ABF.ABF_ALQICM_ENT_PEJ AS ABF_ALQICM_ENT_PEJ_GER ');
      SQL.Add('   FROM ');
      SQL.Add('     ITEGER GER ');
      SQL.Add('     LEFT JOIN ABFICM ABF ');
      SQL.Add('       ON ABF.ABF_CODABF = GER.ITE_CODABF ');
      SQL.Add('       AND ABF.ABF_ESTADO = "SP" ');
      SQL.Add('   WHERE ITE_CODEMP =:ITE_CODEMP ');
      SQL.Add('     AND GER.ITE_CODITE =:ITE_CODITE ) TB_GER ');

      SQL.Add('   RIGHT JOIN ( ');
      SQL.Add('       (SELECT ');
      SQL.Add('         "CADITE" AS HIST, ');
      SQL.Add('         ITE_CODEMP AS ITE_CODEMP, ');
      SQL.Add('         ITE.ITE_CODITE AS ITE_CODITE, ');
      SQL.Add('         ABF.ABF_ALQICM_ENT_PEJ AS ABF_ALQICM_ENT_PEJ_ITE ');
      SQL.Add('       FROM ');
      SQL.Add('         CADITE ITE ');
      SQL.Add('         LEFT JOIN ABFICM ABF ');
      SQL.Add('           ON ABF.ABF_CODABF = ITE.ITE_CODABF ');
      SQL.Add('           AND ABF.ABF_ESTADO = "SP" ');
      SQL.Add('       WHERE ITE.ITE_CODITE =:ITE_CODITE ) TB_ITE ');
      SQL.Add('     ) ON TB_ITE.ITE_CODITE = TB_GER.ITE_CODITE ');

      ParamByName('ITE_CODEMP').AsString   := strCodEmp;
      ParamByName('ITE_CODITE').AsString   := strCodIte;
      Open;

      Result := IIF(RecordCount = 0, 18.00, FieldByName('ALIQICMS').AsFloat);

    end;
  finally
    qryAux.Free;
  end;
end;

procedure TUtilidadeCat42.pDeletarPeriodoEmpresa(var blnRet: Boolean; strMesano, strEmpresa: string);
  var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(nil);
  try
    blnRet:= False;
    with qryAux do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'SELECT CAT_MESANO '
                + '     , CAT_CODEMP '
                + '  FROM CAT_42_DADOS '
                + ' WHERE CAT_MESANO = :MESANO '
                + '   AND CAT_CODEMP = :CODEMP '
                + ' LIMIT 1';
      ParamByName('MESANO').AsString := strMesAno;
      ParamByName('CODEMP').AsString := strEmpresa;
      Open;

      if RecordCount > 0 then
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'DELETE '
                  + '  FROM CAT_42_DADOS '
                  + ' WHERE CAT_MESANO = :MESANO '
                  + '   AND CAT_CODEMP = :CODEMP ';
        ParamByName('MESANO').AsString := strMesAno;
        ParamByName('CODEMP').AsString := strEmpresa;
        ExecSQL;

        Close;
        SQL.Clear;
        SQL.Text := 'DELETE '
                  + '  FROM CAT_42_SALDOS '
                  + ' WHERE CAT_MESANO = :MESANO '
                  + '   AND CAT_CODEMP = :CODEMP ';
        ParamByName('MESANO').AsString := strMesAno;
        ParamByName('CODEMP').AsString := strEmpresa;
        ExecSQL;

        blnRet:= True;
      end;
    end;
  finally
    qryAux.Free;
  end;
end;

end.
