unit Contabilidade.Classes.TVinculoPlanoContabilRepo;

interface

uses
  Contabilidade.Interfaces.TVinculoPlanoContabilRepo, System.Generics.Collections ;

type
  TVinculoPlanoContabilGenericRepo<T, T2: class> = class(TInterfacedObject, IVinculoPlanoContabilRepo<T, T2>)
  private
    function fListDadosPlancoComPlanre: TObjectList<T>;
    function fSalvarVinculoPlancoComPlanre(const AEntities: TObjectList<T>): Boolean;

    function fListDadosCadctaComPlanco: TObjectList<T>;
    function fSalvarVinculoCadctaComPlanco(const AEntities: TObjectList<T>): Boolean;

    function fListDadosCadporComPlanco: TObjectList<T>;
    function fSalvarVinculoCadporComPlanco(const AEntities: TObjectList<T>): Boolean;

    function fListDadosPlanre: TObjectList<T2>;
    function fListDadosPlanco: TObjectList<T2>;
  public
    function fListDadosT: TObjectList<T>;
    function fListDadosT2: TObjectList<T2>;
    function fSalvarVinculo(const AEntities: TObjectList<T>): Boolean;
  end ;

implementation

uses
  untFuncoesSimples, Data.DB, Uni, System.SysUtils, UniClientDataSet,
  Contabilidade.Classes.TVinculoPlanoContabil ;

{ TVinculoPlanoContabilGenericRepo<T, T2> }

function TVinculoPlanoContabilGenericRepo<T, T2>.fListDadosCadctaComPlanco: TObjectList<T>;
var
  LCadcta: TUniQuery ;
  LCtanco: TUniquery ;
  LcdsCtanco: TUniClientDataSet ;
  LTplAco: String ;
  LItem: TCadCtaComPlanoContabil ;
  LItemNco: TNco ;
begin
  Result := TObjectList<T>.Create ;

  LTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [Vs_strCodEmp], False);

  LCadcta := fCriaQuery() ;
  LCtanco := fCriaQuery() ;
  try
    LCadcta.Close ;
    LCadcta.SQL.Clear ;
    LCadcta.SQL.Add(' SELECT ') ;
    LCadcta.SQL.Add('   CAST("0" AS CHAR(1)) AS SELECIONADO, ') ;
    LCadcta.SQL.Add('   CAST("0" AS CHAR(1)) AS POR_EMPRESA, ') ;
    LCadcta.SQL.Add('   CADCTA.CTA_CODCTA, ') ;
    LCadcta.SQL.Add('   CADCTA.CTA_DESCTA, ') ;
    LCadcta.SQL.Add('   CADCTA.CTA_PLANCO, ') ;
    LCadcta.SQL.Add('   PLANCO.NCO_DESCRI, ') ;
    LCadcta.SQL.Add('   CADCTA.AUTOINCREM ') ;
    LCadcta.SQL.Add(' FROM CADCTA ') ;
    LCadcta.SQL.Add('   LEFT JOIN PLANCO ON CADCTA.CTA_PLANCO = PLANCO.NCO_CODCON ') ;
    LCadcta.SQL.Add('      AND CURRENT_DATE BETWEEN COALESCE(PLANCO.NCO_DTAINI, "2000-01-01") AND COALESCE(PLANCO.NCO_DTAFIN, "2200-01-01") ') ;
    LCadcta.SQL.Add('      AND PLANCO.NCO_TPLACO = :TPLACO ') ;
    LCadcta.ParamByName('TPLACO').AsString := LTplAco ;
    LCadcta.Open ;
    LCadcta.first ;

    LCtanco.Close ;
    LCtanco.SQL.Clear ;
    LCtanco.SQL.Add(' SELECT ') ;
    LCtanco.SQL.Add('   CTANCO.NCO_CODCTA, ') ;
    LCtanco.SQL.Add('   CTANCO.NCO_CODEMP, ') ;
    LCtanco.SQL.Add('   CTANCO.NCO_CODCON, ') ;
    LCtanco.SQL.Add('   PLANCO.NCO_DESCRI ') ;
    LCtanco.SQL.Add(' FROM CTANCO ') ;
    LCtanco.SQL.Add('   LEFT JOIN PLANCO ON CTANCO.NCO_CODCON = PLANCO.NCO_CODCON ') ;
    LCtanco.SQL.Add('      AND CURRENT_DATE BETWEEN COALESCE(PLANCO.NCO_DTAINI, "2000-01-01") AND COALESCE(PLANCO.NCO_DTAFIN, "2200-01-01") ') ;
    LCtanco.SQL.Add('      AND PLANCO.NCO_TPLACO = :TPLACO ') ;
    LCtanco.ParamByName('TPLACO').AsString := LTplAco ;
    LCtanco.Open ;

    LcdsCtanco := fCriaClientDatset(LCtanco) ;
    LcdsCtanco.IndexFieldNames := 'NCO_CODCTA' ;

    while not LCadcta.Eof do
    begin
      LItem := TCadCtaComPlanoContabil.Create ;
      LItem.selecionado := LCadcta.FieldByName('SELECIONADO').AsString ;
      LItem.por_empresa := LCadcta.FieldByName('POR_EMPRESA').AsString ;
      LItem.cta_codcta := LCadcta.FieldByName('CTA_CODCTA').AsString ;
      LItem.cta_descta := LCadcta.FieldByName('CTA_DESCTA').AsString ;
      LItem.cta_planco := LCadcta.FieldByName('CTA_PLANCO').AsString ;
      LItem.nco_descri := LCadcta.FieldByName('NCO_DESCRI').AsString ;
      LItem.autoincrem := LCadcta.FieldByName('AUTOINCREM').AsString ;

      if LcdsCtanco.FindKey([LItem.cta_codcta]) then
      begin
        while (LcdsCtanco.FieldByName('NCO_CODCTA').AsString = LItem.cta_codcta) and (not LcdsCtanco.Eof) do
        begin
          LItemNco := TNco.Create ;
          LItemNco.nco_codnco := LcdsCtanco.FieldByName('NCO_CODCTA').AsString ;
          LItemNco.nco_codemp := LcdsCtanco.FieldByName('NCO_CODEMP').AsString ;
          LItemNco.nco_codcon := LcdsCtanco.FieldByName('NCO_CODCON').AsString ;
          LItemNco.nco_descri := LcdsCtanco.FieldByName('NCO_DESCRI').AsString ;

          LItem.empresas.Add(LItemNco) ;

          LcdsCtanco.Next ;
        end ;
      end ;

      Result.Add(LItem) ;

      LCadcta.Next ;
    end ;

  finally
    FreeAndNil(LCadcta) ;
    FreeAndNil(LCtanco) ;
    FreeAndNil(LcdsCtanco) ;
  end ;

end;

function TVinculoPlanoContabilGenericRepo<T, T2>.fListDadosCadporComPlanco: TObjectList<T>;
var
  LCadpor: TUniQuery ;
  LPornco: TUniquery ;
  LcdsPornco: TUniClientDataSet ;
  LTplAco: String ;
  LItem: TCadPorComPlanoContabil ;
  LItemNco: TNco ;
begin
  Result := TObjectList<T>.Create ;

  LTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [Vs_strCodEmp], False);

  LCadpor := fCriaQuery() ;
  LPornco := fCriaQuery() ;
  try
    LCadpor.Close ;
    LCadpor.SQL.Clear ;
    LCadpor.SQL.Add('  SELECT ') ;
    LCadpor.SQL.Add('    CAST("0" AS CHAR(1)) AS SELECIONADO, ') ;
    LCadpor.SQL.Add('    CAST("0" AS CHAR(1)) AS POR_EMPRESA, ') ;
    LCadpor.SQL.Add('    CADPOR.POR_CODPOR, ') ;
    LCadpor.SQL.Add('    CADPOR.POR_NOMPOR, ') ;
    LCadpor.SQL.Add('    CADPOR.POR_PLANCO, ') ;
    LCadpor.SQL.Add('    PLANCO.NCO_DESCRI, ') ;
    LCadpor.SQL.Add('    CADPOR.AUTOINCREM ') ;
    LCadpor.SQL.Add('  FROM CADPOR ') ;
    LCadpor.SQL.Add('    LEFT JOIN PLANCO ON CADPOR.POR_PLANCO = PLANCO.NCO_CODCON ') ;
    LCadpor.SQL.Add('       AND CURRENT_DATE BETWEEN COALESCE(PLANCO.NCO_DTAINI, "2000-01-01") AND COALESCE(PLANCO.NCO_DTAFIN, "2200-01-01") ') ;
    LCadpor.SQL.Add('       AND PLANCO.NCO_TPLACO = :TPLACO  ') ;
    LCadpor.ParamByName('TPLACO').AsString := LTplAco ;
    LCadpor.Open ;
    LCadpor.first ;

    LPornco.Close ;
    LPornco.SQL.Clear ;
    LPornco.SQL.Add('  SELECT DISTINCT ') ;
    LPornco.SQL.Add('    PORNCO.NCO_CODPOR, ') ;
    LPornco.SQL.Add('    PORNCO.NCO_CODEMP, ') ;
    LPornco.SQL.Add('    PORNCO.NCO_CODCON, ') ;
    LPornco.SQL.Add('    PLANCO.NCO_DESCRI ') ;
    LPornco.SQL.Add('  FROM PORNCO ') ;
    LPornco.SQL.Add('    LEFT JOIN PLANCO ON PORNCO.NCO_CODCON = PLANCO.NCO_CODCON ') ;
    LPornco.SQL.Add('       AND CURRENT_DATE BETWEEN COALESCE(PLANCO.NCO_DTAINI, "2000-01-01") AND COALESCE(PLANCO.NCO_DTAFIN, "2200-01-01") ') ;
    LPornco.SQL.Add('       AND PLANCO.NCO_TPLACO = :TPLACO  ') ;
    LPornco.ParamByName('TPLACO').AsString := LTplAco ;
    LPornco.Open ;

    LcdsPornco := fCriaClientDatset(LPornco) ;
    LcdsPornco.IndexFieldNames := 'NCO_CODPOR' ;

    while not LCadpor.Eof do
    begin
      LItem := TCadPorComPlanoContabil.Create ;
      LItem.selecionado := LCadpor.FieldByName('SELECIONADO').AsString ;
      LItem.por_empresa := LCadpor.FieldByName('POR_EMPRESA').AsString ;
      LItem.por_codpor := LCadpor.FieldByName('POR_CODPOR').AsString ;
      LItem.por_nompor := LCadpor.FieldByName('POR_NOMPOR').AsString ;
      LItem.por_planco := LCadpor.FieldByName('POR_PLANCO').AsString ;
      LItem.nco_descri := LCadpor.FieldByName('NCO_DESCRI').AsString ;
      LItem.autoincrem := LCadpor.FieldByName('AUTOINCREM').AsString ;

      if LcdsPornco.FindKey([LItem.por_codpor]) then
      begin
        while (LcdsPornco.FieldByName('NCO_CODPOR').AsString = LItem.por_codpor) and (not LcdsPornco.Eof) do
        begin
          LItemNco := TNco.Create ;
          LItemNco.nco_codnco := LcdsPornco.FieldByName('NCO_CODPOR').AsString ;
          LItemNco.nco_codemp := LcdsPornco.FieldByName('NCO_CODEMP').AsString ;
          LItemNco.nco_codcon := LcdsPornco.FieldByName('NCO_CODCON').AsString ;
          LItemNco.nco_descri := LcdsPornco.FieldByName('NCO_DESCRI').AsString ;

          LItem.empresas.Add(LItemNco) ;

          LcdsPornco.Next ;
        end ;
      end ;

      Result.Add(LItem) ;

      LCadpor.Next ;
    end ;

  finally
    FreeAndNil(LCadpor) ;
    FreeAndNil(LPornco) ;
    FreeAndNil(LcdsPornco) ;
  end ;

end;

function TVinculoPlanoContabilGenericRepo<T, T2>.fListDadosPlanco: TObjectList<T2>;
var
  LPlanco: TUniQuery ;
  LTplAco: String ;
  LItem: TPlanco ;
begin
  Result := TObjectList<T2>.Create ;

  LTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [Vs_strCodEmp], False);

  LPlanco := fCriaQuery() ;
  try
    LPlanco.Close ;
    LPlanco.SQL.Clear ;
    LPlanco.SQL.Add(' SELECT ') ;
    LPlanco.SQL.Add('   CAST("0" AS CHAR(1)) AS SELECIONADO, ') ;
    LPlanco.SQL.Add('   NCO_CODCON, ') ;
    LPlanco.SQL.Add('   NCO_DESCRI, ') ;
    LPlanco.SQL.Add('   NCO_DTAINI, ') ;
    LPlanco.SQL.Add('   NCO_DTAFIN, ') ;
    LPlanco.SQL.Add('   PLANCO.AUTOINCREM ') ;
    LPlanco.SQL.Add(' FROM PLANCO ') ;
    LPlanco.SQL.Add(' WHERE NCO_TPLACO = :TPLACO AND IFNULL(NCO_NATURE,"A") = "A" ') ;
    LPlanco.SQL.Add(' ORDER BY NCO_CODCON, AUTOINCREM ') ;
    LPlanco.ParamByName('TPLACO').AsString := LTplAco ;
    LPlanco.Open ;
    LPlanco.First ;
    while not LPlanco.Eof do
    begin
      LItem := TPlanco.Create ;
      LItem.selecionado := LPlanco.FieldByName('SELECIONADO').AsString ;
      LItem.nco_codcon := LPlanco.FieldByName('NCO_CODCON').AsString ;
      LItem.nco_descri := LPlanco.FieldByName('NCO_DESCRI').AsString ;
      LItem.nco_dtaini := LPlanco.FieldByName('NCO_DTAINI').AsString ;
      LItem.nco_dtafin := LPlanco.FieldByName('NCO_DTAFIN').AsString ;
      LItem.autoincrem := LPlanco.FieldByName('AUTOINCREM').AsString ;

      Result.Add(LItem) ;

      LPlanco.Next ;
    end ;

  finally
    FreeAndNil(LPlanco) ;
  end ;

end;

function TVinculoPlanoContabilGenericRepo<T, T2>.fListDadosPlancoComPlanre: TObjectList<T>;
var
  LPlanco: TUniQuery ;
  LTplAco: string ;
  LItem: TPlancoComPlanoReferencial ;
begin
  Result := TObjectList<T>.Create ;

  LTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [Vs_strCodEmp], False);

  LPlanco := fCriaQuery() ;
  try
    LPlanco.Close ;
    LPlanco.SQL.Clear ;
    LPlanco.SQL.Add(' SELECT DISTINCT CAST("0" AS CHAR(1)) AS SELECIONADO, PLANCO.AUTOINCREM, PLANCO.NCO_CODCON, PLANCO.NCO_DESCRI, PLANCO.NCO_CTAREF, PLANRE.NRE_DESCRI ') ;
    LPlanco.SQL.Add(' FROM PLANCO LEFT JOIN PLANRE ON PLANCO.NCO_CTAREF = PLANRE.NRE_CODREF ') ;
    LPlanco.SQL.Add(' WHERE PLANCO.NCO_NATURE = "A" ') ;
    LPlanco.SQL.Add(' AND CURRENT_DATE BETWEEN COALESCE(PLANCO.NCO_DTAINI, "2000-01-01") AND COALESCE(PLANCO.NCO_DTAFIN, "2200-01-01") ') ;
    LPlanco.SQL.Add(' AND PLANCO.NCO_TPLACO = :TPLACO ') ;
    LPlanco.SQL.Add(' ORDER BY PLANCO.NCO_CODCON ') ;
    LPlanco.ParamByName('TPLACO').AsString := LTplAco ;
    LPlanco.Open ;

    LPlanco.First ;
    while not LPlanco.Eof do
    begin
      LItem := TPlancoComPlanoReferencial.Create ;
      LItem.selecionado := LPlanco.FieldByName('SELECIONADO').AsString ;
      LItem.autoincrem := LPlanco.FieldByName('AUTOINCREM').AsString ;
      LItem.nco_codcon := LPlanco.FieldByName('NCO_CODCON').AsString ;
      LItem.nco_descri := LPlanco.FieldByName('NCO_DESCRI').AsString ;
      LItem.nco_ctaref := LPlanco.FieldByName('NCO_CTAREF').AsString ;
      LItem.nre_descri := LPlanco.FieldByName('NRE_DESCRI').AsString ;
      Result.Add(LItem) ;
      LPlanco.Next ;
    end ;

  finally
    FreeAndNil(LPlanco) ;
  end;

end;

function TVinculoPlanoContabilGenericRepo<T, T2>.fListDadosPlanre: TObjectList<T2>;
var
  LPlanre: TUniQuery ;
  LItem: TPlanre ;
begin
  Result := TObjectList<T2>.Create ;

  LPlanre := fCriaQuery() ;
  try
    LPlanre.Close ;
    LPlanre.SQL.Clear ;
    LPlanre.SQL.Add(' SELECT DISTINCT CAST("0" AS CHAR(1)) AS SELECIONADO, NRE_CODREF, NRE_DESCRI, NRE_DTAINI, NRE_DTAFIN ') ;
    LPlanre.SQL.Add(' FROM PLANRE ') ;
    LPlanre.SQL.Add(' WHERE NRE_BLCECF IN ("L", "P") ') ;
    LPlanre.SQL.Add('        AND NRE_REGECF IN ("100", "100A", "300", "300A", "150", "150A") ') ;
    LPlanre.SQL.Add('        AND NRE_TIPCTA = "A" ') ;
    LPlanre.SQL.Add(' ORDER BY NRE_CODREF ') ;
    LPlanre.Open ;

    LPlanre.First ;
    while not LPlanre.Eof do
    begin
      LItem := TPlanre.Create ;
      LItem.selecionado := LPlanre.FieldByName('SELECIONADO').AsString ;
      LItem.nre_codref  := LPlanre.FieldByName('NRE_CODREF').AsString ;
      LItem.nre_descri  := LPlanre.FieldByName('NRE_DESCRI').AsString ;
      LItem.nre_dtaini  := LPlanre.FieldByName('NRE_DTAINI').AsString ;
      LItem.nre_dtafin  := LPlanre.FieldByName('NRE_DTAFIN').AsString ;
      Result.Add(LItem) ;
      LPlanre.Next ;
    end ;

  finally
    FreeAndNil(LPlanre) ;
  end;
end;

function TVinculoPlanoContabilGenericRepo<T, T2>.fListDadosT: TObjectList<T>;
begin
  if TClass(T).InheritsFrom(TPlancoComPlanoReferencial) then
    Result := Self.fListDadosPlancoComPlanre
  else if TClass(T).InheritsFrom(TCadCtaComPlanoContabil) then
    Result := Self.fListDadosCadctaComPlanco
  else if TClass(T).InheritsFrom(TCadPorComPlanoContabil) then
    Result := Self.fListDadosCadporComPlanco
  else
    Result := TObjectList<T>.Create ;
end;

function TVinculoPlanoContabilGenericRepo<T, T2>.fListDadosT2: TObjectList<T2>;
begin
  if TClass(T2).InheritsFrom(TPlanre) then
    Result := Self.fListDadosPlanre
  else if TClass(T2).InheritsFrom(TPlanco) then
    Result := Self.fListDadosPlanco
  else
    Result := TObjectList<T2>.Create ;
end;

function TVinculoPlanoContabilGenericRepo<T, T2>.fSalvarVinculo(
  const AEntities: TObjectList<T>): Boolean;
begin
  if TClass(T).InheritsFrom(TPlancoComPlanoReferencial) then
    Result := Self.fSalvarVinculoPlancoComPlanre(AEntities)
  else if TClass(T).InheritsFrom(TCadCtaComPlanoContabil) then
    Result := Self.fSalvarVinculoCadctaComPlanco(AEntities)
  else if TClass(T).InheritsFrom(TCadPorComPlanoContabil) then
    Result := Self.fSalvarVinculoCadporComPlanco(AEntities)
  else
    Result := False ;
end;

function TVinculoPlanoContabilGenericRepo<T, T2>.fSalvarVinculoCadctaComPlanco(
  const AEntities: TObjectList<T>): Boolean;
var
  LCadcta: TUniQuery ;
  LcdsCadcta: TUniClientDataSet ;
  LExec: TUniQuery ;
  LItemGeneric: T ;
  LItem: TCadCtaComPlanoContabil ;
  LitemNco: TNco ;
begin

  LCadcta := fCriaQuery() ;
  LExec := fCriaQuery() ;
  try
    LCadcta.Close ;
    LCadcta.SQL.Clear ;
    LCadcta.SQL.Add('SELECT AUTOINCREM, CTA_PLANCO FROM CADCTA') ;
    LCadcta.Open ;

    LcdsCadcta := fCriaClientDatset(LCadcta) ;
    LcdsCadcta.IndexFieldNames := 'AUTOINCREM' ;

    LExec.Close ;
    LExec.SQL.Clear ;
    LExec.SQL.Add('DELETE FROM CTANCO') ;
    LExec.ExecSQL ;

    for LItemGeneric in AEntities do
    begin
      LItem := LItemGeneric as TCadCtaComPlanoContabil ;
      if LcdsCadcta.FindKey([LItem.autoincrem]) then
      begin
        if LcdsCadcta.FieldByName('CTA_PLANCO').AsString <> LItem.cta_planco then
        begin
          LExec.Close ;
          LExec.SQL.Clear ;
          LExec.SQL.Add('UPDATE CADCTA SET CTA_PLANCO = :PLANCO WHERE AUTOINCREM = :AUTOINCREM') ;
          LExec.ParamByName('AUTOINCREM').AsString := LItem.autoincrem ;
          if fEmptyStr(LItem.cta_planco) then
            LExec.ParamByName('PLANCO').Clear
          else
            LExec.ParamByName('PLANCO').AsString := LItem.cta_planco ;
          LExec.ExecSQL ;
        end ;
      end ;

      if LItem.empresas.Count > 0 then
      begin
        for LitemNco in LItem.empresas do
        begin
          LExec.Close ;
          LExec.SQL.Clear ;
          LExec.SQL.Add('INSERT INTO CTANCO (NCO_CODCTA, NCO_CODEMP, NCO_CODCON) VALUES (:CODCTA, :CODEMP, :CODCON) ;') ;
          LExec.ParamByName('CODCTA').AsString := LitemNco.nco_codnco ;
          LExec.ParamByName('CODEMP').AsString := LitemNco.nco_codemp ;
          LExec.ParamByName('CODCON').AsString := LitemNco.nco_codcon ;
          LExec.ExecSQL ;
        end ;
      end ;

    end ;

  finally
    FreeAndNil(LCadcta) ;
    FreeAndNil(LcdsCadcta) ;
    FreeAndNil(LExec) ;
  end ;

  Result := True ;
end;

function TVinculoPlanoContabilGenericRepo<T, T2>.fSalvarVinculoCadporComPlanco(
  const AEntities: TObjectList<T>): Boolean;
var
  LCadpor: TUniQuery ;
  LcdsCadpor: TUniClientDataSet ;
  LExec: TUniQuery ;
  LItemGeneric: T ;
  LItem: TCadPorComPlanoContabil ;
  LitemNco: TNco ;
begin

  LCadpor := fCriaQuery() ;
  LExec := fCriaQuery() ;
  try
    LCadpor.Close ;
    LCadpor.SQL.Clear ;
    LCadpor.SQL.Add('SELECT AUTOINCREM, POR_PLANCO FROM CADPOR') ;
    LCadpor.Open ;

    LcdsCadpor := fCriaClientDatset(LCadpor) ;
    LcdsCadpor.IndexFieldNames := 'AUTOINCREM' ;

    LExec.Close ;
    LExec.SQL.Clear ;
    LExec.SQL.Add('DELETE FROM PORNCO') ;
    LExec.ExecSQL ;

    for LItemGeneric in AEntities do
    begin
      LItem := LItemGeneric as TCadPorComPlanoContabil ;
      if LcdsCadpor.FindKey([LItem.autoincrem]) then
      begin
        if LcdsCadpor.FieldByName('POR_PLANCO').AsString <> LItem.por_planco then
        begin
          LExec.Close ;
          LExec.SQL.Clear ;
          LExec.SQL.Add('UPDATE CADPOR SET POR_PLANCO = :PLANCO WHERE AUTOINCREM = :AUTOINCREM') ;
          LExec.ParamByName('AUTOINCREM').AsString := LItem.autoincrem ;
          if fEmptyStr(LItem.por_planco) then
            LExec.ParamByName('PLANCO').Clear
          else
            LExec.ParamByName('PLANCO').AsString := LItem.por_planco ;
          LExec.ExecSQL ;
        end ;
      end ;

      if LItem.empresas.Count > 0 then
      begin
        for LitemNco in LItem.empresas do
        begin
          LExec.Close ;
          LExec.SQL.Clear ;
          LExec.SQL.Add('INSERT INTO PORNCO (NCO_CODPOR, NCO_CODEMP, NCO_CODCON) VALUES (:CODPOR, :CODEMP, :CODCON) ;') ;
          LExec.ParamByName('CODPOR').AsString := LitemNco.nco_codnco ;
          LExec.ParamByName('CODEMP').AsString := LitemNco.nco_codemp ;
          LExec.ParamByName('CODCON').AsString := LitemNco.nco_codcon ;
          LExec.ExecSQL ;
        end ;
      end ;

    end ;

  finally
    FreeAndNil(LCadpor) ;
    FreeAndNil(LcdsCadpor) ;
    FreeAndNil(LExec) ;
  end ;

  Result := True ;
end;

function TVinculoPlanoContabilGenericRepo<T, T2>.fSalvarVinculoPlancoComPlanre(
  const AEntities: TObjectList<T>): Boolean;
var
  LPlanco: TUniQuery ;
  LCdsPlanco: TUniClientDataSet ;
  LTplAco: string ;
  LExec: TUniQuery ;
  LItemGeneric: T ;
  LItem: TPlancoComPlanoReferencial ;

begin
  LTplAco := fCampoTabela('EMP_TPLACO', 'CADEMP', ['EMP_CODEMP'], [Vs_strCodEmp], False);

  LPlanco := fCriaQuery() ;
  LExec := fCriaQuery() ;
  try
    LPlanco.Close ;
    LPlanco.SQL.Clear ;
    LPlanco.SQL.Add('SELECT AUTOINCREM, NCO_CODCON, NCO_CTAREF FROM PLANCO WHERE NCO_NATURE = "A" AND CURRENT_DATE BETWEEN COALESCE(NCO_DTAINI, "2000-01-01") AND COALESCE(NCO_DTAFIN, "2200-01-01") AND NCO_TPLACO = :TPLACO') ;
    LPlanco.ParamByName('TPLACO').AsString := LTplAco ;
    LPlanco.Open ;

    LCdsPlanco := fCriaClientDatset(LPlanco) ;
    LCdsPlanco.IndexFieldNames := 'NCO_CODCON' ;

    for LItemGeneric in AEntities do
    begin
      LItem := LItemGeneric as TPlancoComPlanoReferencial ;
      if LCdsPlanco.FindKey([LItem.nco_codcon]) then
      begin
        if LCdsPlanco.FieldByName('NCO_CTAREF').AsString <> LItem.nco_ctaref then
        begin
          LExec.Close ;
          LExec.SQL.Clear ;
          LExec.SQL.Add('UPDATE PLANCO SET NCO_CTAREF = :CTAREF WHERE AUTOINCREM = :AUTOINCREM') ;
          if fEmptyStr(LItem.nco_ctaref) then
          begin
            LExec.ParamByName('CTAREF').Clear ;
          end
          else
          begin
            LExec.ParamByName('CTAREF').AsString := LItem.nco_ctaref ;
          end;
          LExec.ParamByName('AUTOINCREM').AsString := LItem.autoincrem ;
          LExec.ExecSQL ;
        end;
      end;
    end;

  finally
    FreeAndNil(LPlanco) ;
    FreeAndNil(LExec) ;
    FreeAndNil(LCdsPlanco) ;
  end;
  Result := True ;
end;

end.
