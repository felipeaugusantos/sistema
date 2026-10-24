unit Contabilidade.Classes.CheckListImportacao;

interface

uses System.Types, UniClientDataSet, Contabilidade.Interfaces ;

const
  CLASSIFICACAO_ANUAL = 300 ;
  CLASSIFICACAO_TRIMESTRAL = 80 ;
  MENSAGEM_CHECKLIST_INVALIDO = 'Check list inválido!' ;

type
  TDateDynArray = array of TDateTime;

  TinfoInsertCheckList = record
    DtaLan: TDateTime ;
    CodEmp: String ;
  end ;

  TarrInfoInsertCheckList = array of TinfoInsertCheckList ;

  TProcessaCheckList = class
  private
    class var FblnCampoReprocessoVerificado: Boolean;
    class var FblnCampoReprocessoExiste: Boolean;
    class function fRetornaEmpresas(const AstrEmpresa: string):TStringDynArray ;
    class function fInValuesEmpresas(const AarrEmpresas: TStringDynArray): string ;
    class function fPersisteEstornar(const AstrEmpresas, AstrTipLan: String; const AdtaIni, AdtaFin: TDateTime):boolean ;
    class function fPersisteLancar(const AstrTipLan: String; const AarrInfo: TarrInfoInsertCheckList): boolean ;
    class function fPersisteEstornarPorExcecao(const AstrEmpresas, AstrTipLan: String; const AdtaIni, AdtaFin: TDateTime):boolean ;
  public
    class function fRetornaDatas(const AdtaIni, AdtaFin: TDateTime; const ATipoCheckList: TTipoCheckList; const AstrCodEmp: String):TDateDynArray ;
    class function fLancar(const AstrTipLan: String; const AstrEmpresa: string; const AdtaIni, AdtaFin: TDateTime; const ATipoCheckList: TTipoCheckList = tclGeracaoLancamentoContabil): boolean ;
    class function fEstornar(const AstrTipLan: String; const AstrEmpresa: string; const AdtaIni, AdtaFin: TDateTime): boolean ;
    class function fSelecionar(const AstrEmpresa: string; const AdtaIni, AdtaFin: TDateTime; const ATipoCheckList: TTipoCheckList):TUniClientDataSet ;
    class function fEstornarPorExcecao(const AstrTipLan: String; const AstrEmpresa: string; const AdtaIni, AdtaFin: TDateTime): boolean ;
    class function fClassificaFechamentoContabil(const AdtaIni, AdtaFin: TDateTime): TEncerramentoContabil ;
    class function fTemCampoReprocesso: Boolean;
    class procedure pMarcarReprocesso(const AstrTipLan, AstrEmpresa: String; const AarrDatas: TDateDynArray);
  end ;

implementation

uses Uni, Data.DB, untFuncoesSimples, SysUtils, DateUtils ;

{ TProcessaCheckList }

class function TProcessaCheckList.fClassificaFechamentoContabil(const AdtaIni,
  AdtaFin: TDateTime): TEncerramentoContabil;
var
  LintDiffDias: integer ;
begin
  LintDiffDias := DaysBetween(AdtaIni, AdtaFin) ;
  if LintDiffDias > CLASSIFICACAO_ANUAL then
    result := ecAnual
  else if LintDiffDias > CLASSIFICACAO_TRIMESTRAL then
    result := ecTrimestral
  else
    result := ecMensal ;
end;

class function TProcessaCheckList.fEstornar(const AstrTipLan: String;
  const AstrEmpresa: string; const AdtaIni, AdtaFin: TDateTime): boolean;
var
  LlstEmpresas: TStringDynArray ;
  LstrEmpresas: String ;
begin
  LlstEmpresas := fRetornaEmpresas(AstrEmpresa) ;
  LstrEmpresas := fInValuesEmpresas(LlstEmpresas) ;
  result := fPersisteEstornar(LstrEmpresas, AstrTipLan, AdtaIni, AdtaFin) ;
end;

class function TProcessaCheckList.fPersisteEstornarPorExcecao(const AstrEmpresas,
  AstrTipLan: String; const AdtaIni, AdtaFin: TDateTime): boolean;
var
  LqryExec: TUniQuery ;
begin
  LqryExec := fCriaQuery() ;
  try
    LqryExec.Close ;
    LqryExec.SQL.Clear ;

    LqryExec.SQL.Add(' DELETE ') ;
    LqryExec.SQL.Add(' FROM CONCHK ') ;
    LqryExec.SQL.Add(' WHERE CHK_DTALAN BETWEEN :DTAINI AND :DTAFIN AND CHK_TIPLAN = :TIPLAN AND NOT EXISTS ( ') ;
    LqryExec.SQL.Add('  SELECT DISTINCT CON_EMPLAN, CON_DTALAN, CON_TIPLAN ') ;
    LqryExec.SQL.Add('  FROM LANCON ') ;
    LqryExec.SQL.Add('  WHERE CON_DTALAN BETWEEN :DTAINI AND :DTAFIN AND ') ;
    LqryExec.SQL.Add('       CON_AUTOMA = 1 AND ') ;
    LqryExec.SQL.Add('       CON_TIPLAN = :TIPLAN AND ') ;
    LqryExec.SQL.Add('       CON_EMPLAN = CHK_CODEMP AND ') ;
    LqryExec.SQL.Add('       CON_DTALAN = CHK_DTALAN AND ') ;
    LqryExec.SQL.Add('       CON_TIPLAN = CHK_TIPLAN ') ;
    LqryExec.SQL.Add('  ) ; ') ;
    LqryExec.ParamByName('TIPLAN').AsString := AstrTipLan ;
    LqryExec.ParamByName('DTAINI').AsDateTime := AdtaIni ;
    LqryExec.ParamByName('DTAFIN').AsDateTime := AdtaFin ;
    LqryExec.ExecSQL ;

  finally
    FreeAndNil(LqryExec) ;
  end ;
  result := True ;
end;

class function TProcessaCheckList.fEstornarPorExcecao(const AstrTipLan,
  AstrEmpresa: string; const AdtaIni, AdtaFin: TDateTime): boolean;
var
  LlstEmpresas: TStringDynArray ;
  LstrEmpresas: String ;
begin
  LlstEmpresas := fRetornaEmpresas(AstrEmpresa) ;
  LstrEmpresas := fInValuesEmpresas(LlstEmpresas) ;
  result := fPersisteEstornarPorExcecao(LstrEmpresas, AstrTipLan, AdtaIni, AdtaFin) ;
end;

class function TProcessaCheckList.fInValuesEmpresas(
  const AarrEmpresas: TStringDynArray): string;
var
  LstrEmpresa: string ;
begin
  result := '' ;
  for LstrEmpresa in AarrEmpresas do
  begin
    if fEmptyStr(result) then
    begin
      result := QuotedStr(LstrEmpresa) ;
    end
    else
    begin
      result := result + ',' + QuotedStr(LstrEmpresa) ;
    end ;
  end ;
end;

class function TProcessaCheckList.fLancar(const AstrTipLan: String;
  const AstrEmpresa: string; const AdtaIni, AdtaFin: TDateTime; const ATipoCheckList: TTipoCheckList = tclGeracaoLancamentoContabil): boolean;
var
  LstrEmpresa: String ;
  LlstEmpresas: TStringDynArray ;
  LlstDias: TDateDynArray ;
  LdtaDia: TDateTime ;
  LrecInfo: TinfoInsertCheckList ;
  LarrInfo: TarrInfoInsertCheckList ;
begin
  LlstEmpresas := fRetornaEmpresas(AstrEmpresa) ;
  LlstDias := fRetornaDatas(AdtaIni, AdtaFin, ATipoCheckList, AstrEmpresa) ;
  SetLength(LarrInfo, 0);
  for LstrEmpresa in LlstEmpresas do
  begin
    for LdtaDia in LlstDias do
    begin
      FillChar(LrecInfo, SizeOf(LrecInfo), #0);
      LrecInfo.DtaLan := LdtaDia ;
      LrecInfo.CodEmp := LstrEmpresa ;

      SetLength(LarrInfo, Length(LarrInfo)+1);
      LarrInfo[High(LarrInfo)] := LrecInfo ;

    end ;
  end ;
  result := fPersisteLancar(AstrTipLan, LarrInfo) ;
end;

class function TProcessaCheckList.fPersisteEstornar(const AstrEmpresas,
  AstrTipLan: String; const AdtaIni, AdtaFin: TDateTime): boolean;
var
  LqryExec: TUniQuery ;
begin
  LqryExec := fCriaQuery() ;
  try
    LqryExec.Close ;
    LqryExec.SQL.Clear ;
    LqryExec.SQL.Add('SELECT * FROM CONCHK WHERE CHK_TIPLAN = :TIPLAN ') ;
    LqryExec.SQL.Add('                   AND CHK_DTALAN BETWEEN :DTAINI AND :DTAFIN ') ;
    LqryExec.SQL.Add('                   AND CHK_CODEMP IN (' + AstrEmpresas +  ') ') ;
    LqryExec.ParamByName('TIPLAN').AsString := AstrTipLan ;
    LqryExec.ParamByName('DTAINI').AsDateTime := AdtaIni ;
    LqryExec.ParamByName('DTAFIN').AsDateTime := AdtaFin ;
    LqryExec.Open ;
    if not LqryExec.IsEmpty then
    begin
      LqryExec.First ;
      while not LqryExec.Eof do
      begin
        fVerificaIntegridade('TProcessaCheckList.fPersisteEstornar', 'CONCHK', LqryExec) ;
        LqryExec.Delete ;
       end ;
    end ;

  finally
    FreeAndNil(LqryExec) ;
  end ;
  result := True ;
end;

class function TProcessaCheckList.fPersisteLancar(const AstrTipLan: String;
  const AarrInfo: TarrInfoInsertCheckList): boolean;
var
  LrecInfo: TinfoInsertCheckList ;
  LqryExec: TUniQuery ;
  LstrSql: String ;
  LblnFlag: Boolean ;
begin
  LqryExec := fCriaQuery() ;
  try
    LstrSql := 'INSERT INTO CONCHK (CHK_CODOPE, CHK_CODEMP, CHK_DTALAN, CHK_TIPLAN) VALUES ' ;
    LblnFlag := False ;
    for LrecInfo in AarrInfo do
    begin
      if not LblnFlag then
      begin
        LstrSql := LstrSql + '('+quotedstr(strLoginUsuarioLogado)+', '+quotedstr(LrecInfo.CodEmp)+', '+quotedstr(fStrZero(YearOf(LrecInfo.DtaLan),4)+'-'+fStrZero(MonthOf(LrecInfo.DtaLan),2)+'-'+fStrZero(DayOf(LrecInfo.DtaLan),2))+', '+quotedstr(AstrTipLan)+')' ;
      end
      else
      begin
        LstrSql := LstrSql + ',('+quotedstr(strLoginUsuarioLogado)+', '+quotedstr(LrecInfo.CodEmp)+', '+quotedstr(fStrZero(YearOf(LrecInfo.DtaLan),4)+'-'+fStrZero(MonthOf(LrecInfo.DtaLan),2)+'-'+fStrZero(DayOf(LrecInfo.DtaLan),2))+', '+quotedstr(AstrTipLan)+')' ;
      end ;
      LblnFlag := True ;
    end ;
    if LblnFlag then
    begin
      LqryExec.Close ;
      LqryExec.SQL.Clear ;
      LqryExec.SQL.Add(LstrSql) ;
      LqryExec.ExecSQL ;
    end ;
  finally
    FreeAndNil(LqryExec) ;
  end ;
  result := True ;
end;

class function TProcessaCheckList.fRetornaDatas(const AdtaIni,
  AdtaFin: TDateTime; const ATipoCheckList: TTipoCheckList;
  const AstrCodEmp: String): TDateDynArray;
var
  LdtaDia: TDateTime ;
  LqryFec: TUniQuery ;
  LintPularMeses: Integer ;
  LecFechamento: TEncerramentoContabil ;
begin
  SetLength(result, 0);
  case ATipoCheckList of
    tclGeracaoLancamentoContabil:
    begin
      LdtaDia := AdtaIni ;
      repeat

        SetLength(result, Length(result)+1);
        result[High(result)] := LdtaDia ;

        LdtaDia := DateUtils.IncDay( LdtaDia, 1 );

      until LdtaDia > AdtaFin ;
    end;
    tclFechamentoContabil:
    begin
      LqryFec := fCriaQuery() ;
      try
        LqryFec.Close ;
        LqryFec.SQL.Clear ;
        LqryFec.SQL.Add(' SELECT CON_FECFIN, CON_FECINI ') ;
        LqryFec.SQL.Add(' FROM FECCON ') ;
        LqryFec.SQL.Add(' WHERE CON_CODEMP = :CODEMP ') ;
        LqryFec.SQL.Add('       AND CON_FECINI BETWEEN :DTAINI AND :DTAFIN ') ;
        LqryFec.SQL.Add(' ORDER BY CON_FECINI ') ;
        LqryFec.ParamByName('CODEMP').AsString := AstrCodEmp ;
        LqryFec.ParamByName('DTAINI').AsDateTime := AdtaIni ;
        LqryFec.ParamByName('DTAFIN').AsDateTime := AdtaFin ;
        LqryFec.Open ;
        if not LqryFec.IsEmpty then
        begin
          LecFechamento := fClassificaFechamentoContabil(LqryFec.FieldByName('CON_FECINI').AsDateTime, LqryFec.FieldByName('CON_FECFIN').AsDateTime) ;
          if LecFechamento = ecAnual then
          begin
            SetLength(result, Length(result)+1);
            result[High(result)] := LqryFec.FieldByName('CON_FECINI').AsDateTime ;
            exit ;
          end
          else if LecFechamento = ecTrimestral then
          begin
            LintPularMeses := 3 ;
          end
          else // mensal
          begin
            LintPularMeses := 1 ;
          end ;
        end
        else
        begin
          LintPularMeses := 1 ;
        end ;

        LdtaDia := AdtaIni ;
        repeat

          SetLength(result, Length(result)+1);
          result[High(result)] := LdtaDia ;

          LdtaDia := SysUtils.IncMonth( LdtaDia, LintPularMeses );

        until LdtaDia > AdtaFin ;

      finally
        FreeAndNil(LqryFec) ;
      end ;
    end;
    tclFechamentoContabilMes:
    begin
      LdtaDia := AdtaIni ;
      repeat

        SetLength(result, Length(result)+1);
        result[High(result)] := LdtaDia ;

        LdtaDia := SysUtils.IncMonth( LdtaDia, 1 );

      until LdtaDia > AdtaFin ;
    end
    else
    begin
      raise Exception.Create(MENSAGEM_CHECKLIST_INVALIDO);
    end ;
  end ;
end;

class function TProcessaCheckList.fRetornaEmpresas(
  const AstrEmpresa: string): TStringDynArray;
var
  LqryEmp: TUniQuery ;
begin
  SetLength(result, 0);
  if fEmptyStr(AstrEmpresa) then
  begin
    LqryEmp := fCriaQuery() ;
    try
      LqryEmp.Close ;
      LqryEmp.SQL.Clear ;
      LqryEmp.SQL.Add('SELECT EMP_CODEMP FROM CADEMP ORDER BY EMP_CODEMP') ;
      LqryEmp.Open ;
      LqryEmp.First ;
      while not LqryEmp.Eof do
      begin
        SetLength(result, Length(result)+1);
        result[High(result)] := LqryEmp.FieldByName('EMP_CODEMP').AsString ;
        LqryEmp.Next ;
      end ;
    finally
      FreeAndNil(LqryEmp) ;
    end ;
  end
  else
  begin
    SetLength(result, Length(result)+1);
    result[High(result)] := AstrEmpresa ;
  end ;
end;

class function TProcessaCheckList.fTemCampoReprocesso: Boolean;
begin
  // Verificado uma vez por execucao: o fCampoExiste com cache nao existe em todas as versoes que usam o modulo.
  if not FblnCampoReprocessoVerificado then
  begin
    FblnCampoReprocessoExiste := fCampoExiste('CONCHK', 'CHK_REPROC');
    FblnCampoReprocessoVerificado := True;
  end;
  Result := FblnCampoReprocessoExiste;
end;

class procedure TProcessaCheckList.pMarcarReprocesso(const AstrTipLan, AstrEmpresa: String;
  const AarrDatas: TDateDynArray);
var
  LqryCheck: TUniQuery;
  LdtaDia: TDateTime;
  LdtaGer: TDateTime;
begin
  // Req. 470760: o reprocesso de documentos com erro nao refaz o check list do periodo; so marca os dias.
  // Uma geracao normal posterior apaga e recria as linhas, e a marca volta ao default 'N'.
  if not fTemCampoReprocesso then
    Exit;

  LdtaGer := fNow;
  LqryCheck := fCriaQuery();
  try
    for LdtaDia in AarrDatas do
    begin
      LqryCheck.Close;
      LqryCheck.SQL.Clear;
      LqryCheck.SQL.Add(' SELECT COUNT(*) AS QTD FROM CONCHK ');
      LqryCheck.SQL.Add('  WHERE CHK_CODEMP = :CODEMP AND CHK_TIPLAN = :TIPLAN AND CHK_DTALAN = :DTALAN ');
      LqryCheck.ParamByName('CODEMP').AsString := AstrEmpresa;
      LqryCheck.ParamByName('TIPLAN').AsString := AstrTipLan;
      LqryCheck.ParamByName('DTALAN').AsDate := LdtaDia;
      LqryCheck.Open;

      if LqryCheck.FieldByName('QTD').AsInteger > 0 then
      begin
        LqryCheck.Close;
        LqryCheck.SQL.Clear;
        LqryCheck.SQL.Add(' UPDATE CONCHK SET CHK_REPROC = ''S'', CHK_DTAGER = :DTAGER, CHK_CODOPE = :CODOPE ');
        LqryCheck.SQL.Add('  WHERE CHK_CODEMP = :CODEMP AND CHK_TIPLAN = :TIPLAN AND CHK_DTALAN = :DTALAN ');
      end
      else
      begin
        LqryCheck.Close;
        LqryCheck.SQL.Clear;
        LqryCheck.SQL.Add(' INSERT INTO CONCHK (CHK_CODOPE, CHK_CODEMP, CHK_DTALAN, CHK_TIPLAN, CHK_DTAGER, CHK_REPROC) ');
        LqryCheck.SQL.Add(' VALUES (:CODOPE, :CODEMP, :DTALAN, :TIPLAN, :DTAGER, ''S'') ');
      end;

      LqryCheck.ParamByName('CODOPE').AsString := strLoginUsuarioLogado;
      LqryCheck.ParamByName('CODEMP').AsString := AstrEmpresa;
      LqryCheck.ParamByName('TIPLAN').AsString := AstrTipLan;
      LqryCheck.ParamByName('DTALAN').AsDate := LdtaDia;
      LqryCheck.ParamByName('DTAGER').AsDateTime := LdtaGer;
      LqryCheck.ExecSQL;
    end;
  finally
    FreeAndNil(LqryCheck);
  end;
end;

class function TProcessaCheckList.fSelecionar(const AstrEmpresa: string;
  const AdtaIni, AdtaFin: TDateTime; const ATipoCheckList: TTipoCheckList): TUniClientDataSet;
var
  LqryCheck: TUniQuery ;
begin
  Result := nil ;
  LqryCheck := fCriaQuery() ;
  try
    LqryCheck.Close ;
    LqryCheck.SQL.Clear ;
    if ATipoCheckList = tclGeracaoLancamentoContabil then
    begin
      if fTemCampoReprocesso then
        LqryCheck.SQL.Add(' SELECT DISTINCT CHK_DTALAN, CHK_TIPLAN, CHK_DTAGER, CHK_CODOPE, CHK_REPROC ')
      else
        LqryCheck.SQL.Add(' SELECT DISTINCT CHK_DTALAN, CHK_TIPLAN, CHK_DTAGER, CHK_CODOPE ') ;
      LqryCheck.SQL.Add(' FROM CONCHK ') ;
      LqryCheck.SQL.Add(' WHERE CHK_DTALAN BETWEEN :INI AND :FIN ') ;
      LqryCheck.SQL.Add('       AND CHK_CODEMP = :CODEMP ') ;
      LqryCheck.ParamByName('CODEMP').AsString := AstrEmpresa ;
      LqryCheck.ParamByName('INI').AsDateTime := AdtaIni ;
      LqryCheck.ParamByName('FIN').AsDateTime := AdtaFin ;
    end
    else if ATipoCheckList = tclFechamentoContabil then
    begin
      LqryCheck.SQL.Add(' SELECT DISTINCT CON_FECINI AS CHK_DTALAN, CAST("FEC" AS CHAR(3)) AS CHK_TIPLAN ') ;
      LqryCheck.SQL.Add(' FROM FECCON ') ;
      LqryCheck.SQL.Add(' WHERE CON_FECINI BETWEEN :INI AND :FIN ') ;
      LqryCheck.SQL.Add('       AND CON_CODEMP = :CODEMP ') ;
      LqryCheck.ParamByName('CODEMP').AsString := AstrEmpresa ;
      LqryCheck.ParamByName('INI').AsDateTime := AdtaIni ;
      LqryCheck.ParamByName('FIN').AsDateTime := AdtaFin ;
      LqryCheck.SQL.Add(' ORDER BY CON_FECINI ') ;
    end
    else if ATipoCheckList = tclFechamentoContabilMes then
    begin
      LqryCheck.SQL.Add(' SELECT DISTINCT DATE_ADD(MES_MESDTA, INTERVAL -DAY(MES_MESDTA)+1 DAY) AS CHK_DTALAN, CAST("FEC" AS CHAR(3)) AS CHK_TIPLAN ') ;
      LqryCheck.SQL.Add(' FROM FECMES ') ;
      LqryCheck.SQL.Add(' WHERE MES_MESDTA BETWEEN :INI AND :FIN ') ;
      LqryCheck.SQL.Add('       AND MES_CODEMP = :CODEMP ') ;
      LqryCheck.ParamByName('CODEMP').AsString := AstrEmpresa ;
      LqryCheck.ParamByName('INI').AsDateTime := AdtaIni ;
      LqryCheck.ParamByName('FIN').AsDateTime := AdtaFin ;
      LqryCheck.SQL.Add(' ORDER BY MES_MESDTA ') ;
    end
    else
    begin
      raise Exception.Create(MENSAGEM_CHECKLIST_INVALIDO);
    end ;
    LqryCheck.Open ;

    Result := fCriaClientDatset(LqryCheck) ;
    Result.IndexFieldNames := 'CHK_DTALAN;CHK_TIPLAN' ;
  finally
    FreeAndNil(LqryCheck) ;
  end ;
end;

end.
