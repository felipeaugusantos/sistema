unit Contabilidade.Classes.TLanConSAI;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB,
     UniClientDataSet, Contabilidade.Interfaces, System.Generics.Collections,
     System.Math;

type
  TLanConSAI = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    FUsaCampoNatCfo : boolean;
    FUsaCampoAbfCon : boolean;
    FUsaCampoFcpPro : boolean;
    FUsaCampoProEmb: Boolean;
    FblnCSaCst : Boolean ;
    FstrCentroCustoDefault: String ;
    function fRetornaSQLNaurezaOperacao: string;
    function fPreparaSqlPlanoContas(const AstrSql: String): String ;
    procedure pAjustaValorIRRF;
  public
    function fCarregaDados: Boolean;
    function fEfetuaLancamentos: Boolean;
    procedure pMensagemConclusao;
    function fTemParametrosConfigurados: Boolean;
    function fDeletaLanCon: Boolean;
    function GetListaErros: TUniClientDataSet;
    procedure pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False); overload ;
    procedure pSetaPreValidacao(const Value: Boolean); overload ;
    constructor Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
    destructor Destroy; override;
    procedure pVerificaSeLancouLanCon;
    function fEfetuaLancamentosPreValidacao: Boolean;
  End;

implementation

uses Forms, SysUtils, StrUtils, untFuncoesSimples, Contabilidade.Funcoes,
     Contabilidade.Classes.TEventoContabil, Contabilidade.Classes.TTrataIncDoc;

{ TLanConSAI }

constructor TLanConSAI.Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  qryDados.CachedUpdates := True;
  qryDados.Options.SetFieldsReadOnly := False;
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Generico.FblnMostraWarningGeracaoMovimento := False;
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  FUsaCampoNatCfo := fCampoExiste('AUXMOV', 'AUX_NATCFO');
  FUsaCampoAbfCon := fCampoExiste('CADITE', 'ITE_ABFCON');
  FUsaCampoFcpPro := fCampoExiste('MOVICD', 'ICD_FCPPRO');
  FUsaCampoProEmb := fCampoExiste('MOVDET', 'DET_PROEMB');
  FblnCSaCst := fCfgCSaCst = 'S' ;
  FstrCentroCustoDefault := fCentroCustoDefaultCntDespRecCus ;
end;

destructor TLanConSAI.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConSAI.fCarregaDados: Boolean;
  Var
    strSQL   : String;
    LstrSqlAux : string;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT DET_CLAFIS AS CLAFIS, DET_DTAENT AS DTAENT, DET_NUMDOC AS NUMDOC, DET_ESPDOC AS ESPDOC, DET_CODEMP AS CODEMP, DET_SERIE_ AS SERIE_, FIS_ENTSAI AS ENTSAI, FIS_TIP_FC AS TIP_FC, SUM(DET_VLRCON) AS VLRCON, SUM(DET_VALICM) AS VALICM, ';
  strSQL := strSQL + '        SUM(IFNULL(DET_VALIPI,0)) AS VALIPI, SUM(DET_TOTFRE) AS TOTFRE, SUM(DET_DESACE) AS DESACE, ';
  strSQL := strSQL + '        SUM(IFNULL(DET_VALRET,0)) AS VALRET, SUM(DET_VALPIS) AS VALPIS, SUM(DET_VALCOF) AS VALCOF, ';
  strSQL := strSQL + '        SUM(DET_TOTMED) AS TOTMED, IFNULL(CLI_NOMCLI, FOR_NOMFOR) AS NOME, IF(CLI_NOMCLI IS NULL, FOR_C_G_C_, CLI_C_G_C_) AS CNPJ, ';
  strSQL := strSQL + '        MOVDET.DET_SEQGER AS SEQGER, "MOVGER" AS TABELA, ';
  strSQL := strSQL + '        SUM(DET_VLRCON - IFNULL(DET_VALICM, 0) - IFNULL(DET_VALIPI, 0) - IFNULL(DET_VALPIS, 0) - IFNULL(DET_VALCOF, 0) - IFNULL(DET_VALRET,0)) AS LIQENT, ';

  strSQL := strSQL + fRetornaSQLNaurezaOperacao ;

  strSQL := strSQL + '        SUM(DET_TOTITE-DET_DESESP) AS TOTITE, GER_CODEVE, ';
  strSQL := strSQL + '        SUM(DET_DESESP) AS DESESP, ';
  strSQL := strSQL + '        CADEMP.EMP_NOMEMP AS NOMEMP, CTR_DTAREC AS DTAREC, ';
  strSQL := strSQL + '        IF(CLI_NOMCLI IS NULL, "F", "C") AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IF(CLI_NOMCLI IS NULL, IFNULL(NCO_CODFOR, FOR_CODFOR), IFNULL(NCO_CODCLI, CLI_CODCLI)) AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IF(CLI_NOMCLI IS NULL, IFNULL(FORNCO.NCO_CODCON, FOR_PLANCO), IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO)) AS PLANCO, ';

  strSQL := strSQL + '        SUM(IFNULL(MOVTRI.DET_VFCPST, 0.00)) AS VFCPST, ';
  strSQL := strSQL + '        SUM(IFNULL(IF(' + ifThen(FUsaCampoFcpPro,'MOVICD.ICD_FCPPRO','"S"') + '="S", MOVICD.ICD_VALFCP, 0.00), 0.00)) AS VALFCP  ';

  if (FUsaCampoAbfCon) then
    strSQL := strSQL + '     ,ITE_ABFCON ';

  if fCfgConGru = 'S' then
  begin
    strSQL := strSQL + '  ,ITE_CODGRU ';
  end ;

  strSQL := strSQL + '     ,IF(GER_CONPAG="01000", "À Vista", "À Prazo") AS NATOPE ';
  if fCfgCSaCst = 'S' then
  begin
    strSQL := strSQL + '     , DET_CODFIS AS CODFIS ';
  end;
  strSQL := strSQL + '     , GER_VALIRF ';
  strSQL := strSQL + '     , ROUND((DET_TOTITE / (IFNULL(GER_TOTPRO,0) + IFNULL(GER_TOTSER,0))) * GER_VALIRF, 2) AS VALIRF ';
  strSQL := strSQL + '     , SUM(CASE WHEN DET_PROEMB <> "S" AND COALESCE(GER_ORIDOC, "") = "V" AND COALESCE(GER_TIP_FC, "") = "C" THEN COALESCE(ICD_VALDES,0.00) ELSE 0.00 END) AS VAL_DIFAL ';
  strSQL := strSQL + '   FROM MOVDET ';

  if (FUsaCampoAbfCon) or (fCfgConGru = 'S') then
    strSQL := strSQL + '   JOIN CADITE ON MOVDET.DET_CODITE = CADITE.ITE_CODITE ';

  strSQL := strSQL + '   JOIN CADEMP ON MOVDET.DET_CODEMP = CADEMP.EMP_CODEMP ';
  strSQL := strSQL + '   JOIN MOVTRI ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ';
  strSQL := strSQL + '   JOIN MOVGER ON MOVGER.AUTOINCREM = MOVDET.DET_SEQGER ';

  strSQL := strSQL + '   LEFT JOIN MOVICD ON MOVDET.AUTOINCREM = MOVICD.ICD_SEQGER ';

  if (FUsaCampoNatCfo) then
    strSQL := strSQL + ' LEFT JOIN AUXMOV ON AUX_SEQGER = MOVDET.DET_SEQGER ';

  strSQL := strSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = DET_CODCLI ';
  strSQL := strSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = DET_CODFOR ';
  strSQL := strSQL + '   LEFT JOIN CADREC ON CTR_NUMDUP = DET_NUMDOC ';
  strSQL := strSQL + '                   AND CTR_ESPDOC = DET_ESPDOC ';
  strSQL := strSQL + '                   AND CTR_CODCLI = DET_CODCLI ';
  strSQL := strSQL + '                   AND CTR_CODEMP = DET_CODEMP ';
  strSQL := strSQL + '                   AND CTR_SEQBAI = 0 ';
  strSQL := strSQL + '                   AND CTR_PARCEL = "A" ';
  strSQL := strSQL + '   LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '                   AND CLINCO.NCO_CODEMP = DET_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR ';
  strSQL := strSQL + '                   AND FORNCO.NCO_CODEMP = DET_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN CADFIS ON FIS_NUMDOC = DET_NUMDOC ';
  strSQL := strSQL + '                   AND FIS_ESPDOC = DET_ESPDOC ';
  strSQL := strSQL + '                   AND FIS_CODEMP = DET_CODEMP ';
  strSQL := strSQL + '                   AND FIS_TIP_FC = DET_TIP_FC ';
  strSQL := strSQL + '                   AND FIS_FORCLI = IFNULL(DET_CODCLI, DET_CODFOR) ';
  strSQL := strSQL + '                   AND FIS_ORIDOC = DET_ORIDOC ';
  strSQL := strSQL + '                   AND IFNULL(FIS_SERIE_,"") = IFNULL(DET_SERIE_,"") ';

  strSQL := strSQL + '  WHERE TRUE ';

  If Not fEmptyStr(recParCon.strCodEmp) Then
    strSQL := strSQL + '  AND DET_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND DET_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSql := strSql + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc('MOVDET.DET_SEQGER')
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  strSQL := strSQL + '    AND LEFT(DET_CLAFIS, 1) >= "5" ';
  if FUsaCampoProEmb and fDesconsiderarProEmbNoSAI then
  begin
    strSQL := strSQL + '    AND COALESCE(DET_PROEMB, "") <> "S" ';
  end;
  strSQL := strSQL + '    AND RIGHT(DET_CLAFIS, 3) <> "933" ';
  strSQL := strSQL + '    AND DET_ESPDOC IN ("NF", "NS", "NV", "IF", "IV", "D1", "EL") ';
  strSQL := strSQL + '    AND UPPER(IFNULL(FIS_HISTOR, "")) NOT REGEXP "CANCELAD|INUTILIZAD|DENEGAD" ';
  strSQL := strSQL + '  GROUP BY DET_NUMDOC, DET_ESPDOC, DET_CODEMP, DET_SERIE_, FIS_ENTSAI, FIS_TIP_FC, DET_CODCLI, DET_CODFOR, DET_TIP_FC, DET_ORIDOC, DET_CLAFIS ';

  if (FUsaCampoAbfCon) then
    strSQL := strSQL + '  ,ITE_ABFCON ';

  if fCfgConGru = 'S' then
  begin
    strSQL := strSQL + '  ,ITE_CODGRU ';
  end ;

  if fCfgCSaCst = 'S' then
  begin
    strSQL := strSQL + '  ,DET_CODFIS ';
  end;

  qryDados.Close;
  qryDados.SQL.Clear;

  LstrSqlAux := strSQL ;

  if fEmptyStr(recParCon.strTabela) then
  begin
    LstrSqlAux := LstrSqlAux + ' UNION ALL ' ;
    LstrSqlAux := LstrSqlAux + ' ' + AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER'), 'MOVDET', 'NOTDET'), 'MOVTRI', 'NOTTRI'), 'AUXMOV', 'AUXNOT'), 'MOVICD', 'NOTICD') + ' ' ;
  end
  else if (recParCon.strTabela = 'NOTGER') then
  begin
    LstrSqlAux := AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(AnsiReplaceStr(strSQL, 'MOVGER', 'NOTGER'), 'MOVDET', 'NOTDET'), 'MOVTRI', 'NOTTRI'), 'AUXMOV', 'AUXNOT'), 'MOVICD', 'NOTICD') ;
  end;

  LstrSqlAux := fPreparaSqlMarketPlace(LstrSqlAux) ;

  LstrSqlAux := fPreparaSqlPlanoContas(LstrSqlAux) ;

  qryDados.SQL.Add(LstrSqlAux) ;

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConSAI.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
end;

function TLanConSAI.fEfetuaLancamentos: Boolean;
  var
    strNatCfo : string;
    strEveNec: String;
    strCodEve: string;
    strNatOpe: string;
    strCst: string;
    LstrPlaCta: String;
begin
  pgbProgresso.Properties.Max := qryDados.RecordCount;
  strEveNec := fRetornaEventosNaoExportar;

  pAjustaValorIRRF;

  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    Application.ProcessMessages;

    if (not fEmptyStr(strEveNec)) and (not qryDados.FieldByName('GER_CODEVE').IsNull)
       and (Pos(qryDados.FieldByName('GER_CODEVE').AsString, strEveNec) > 0) then
    begin
      Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Evento com o código '+qryDados.FieldByName('CODEVE').AsString+' configurado para não ser exportado na CFG_EVENEC!'), qryDados);
      qryDados.Next;
      Continue;
    end;

    strNatCfo := '';
    if Assigned(qryDados.FindField('NATCFO')) then
      strNatCfo := qryDados.FieldByName('NATCFO').AsString;

    strCodEve := TFactoryEventoContabil.New.fConfiguraEvento(qryDados.FieldByName('GER_CODEVE').AsString, 'SAI').fConsultaEvento(FstrCentroCustoDefault)  ;

    strNatOpe := qryDados.FieldByName('NATOPE').AsString;

    strCst := '' ;
    if FblnCSaCst then
    begin
      strCst := qryDados.FieldByName('CODFIS').AsString ;
    end;

    LstrPlaCta := '' ;
    if Assigned(qryDados.FindField('CTA_PLANCO')) then
      LstrPlaCta := qryDados.FieldByName('CTA_PLANCO').AsString ;

    Generico.pGravaLancto('VLRCON', 'Vr.Contábil', LstrPlaCta, '', strCodEve, '', '', strNatCfo, strNatOpe, strCst);
    Generico.pGravaLancto('VALICM', 'Vr.ICMS', LstrPlaCta, '', strCodEve, '', '', strNatCfo, strNatOpe, strCst);
    Generico.pGravaLancto('VALIPI', 'Vr.IPI', LstrPlaCta, '', strCodEve, '', '', strNatCfo, strNatOpe, strCst);
    Generico.pGravaLancto('TOTFRE', 'Vr.Frete', LstrPlaCta, '', strCodEve, '', '', strNatCfo, strNatOpe, strCst);
    Generico.pGravaLancto('DESACE', 'Vr.Desp.Acessórias', LstrPlaCta, '', strCodEve, '', '', strNatCfo, strNatOpe, strCst);
    Generico.pGravaLancto('VALRET', 'Vr.Sub.Tributária', LstrPlaCta, '', strCodEve, '', '', strNatCfo, strNatOpe, strCst);
    Generico.pGravaLancto('VALPIS', 'Vr.PIS', LstrPlaCta, '', strCodEve, '', '', strNatCfo, strNatOpe, strCst);
    Generico.pGravaLancto('VALCOF', 'Vr.COFINS', LstrPlaCta, '', strCodEve, '', '', strNatCfo, strNatOpe, strCst);
    Generico.pGravaLancto('TOTMED', DES_VALOR_CMV, LstrPlaCta, '', strCodEve, '', '', strNatCfo, strNatOpe, strCst);
    Generico.pGravaLancto('LIQENT', DES_VALOR_LIQUIDO_SAIDA, LstrPlaCta, '', strCodEve, '', '', strNatCfo, strNatOpe, strCst);
    Generico.pGravaLancto('LIQENT', DES_VALOR_LIQUIDO_ENTRADA, LstrPlaCta, '', strCodEve, '', '', strNatCfo, strNatOpe, strCst); // mantido, caso tenha algum registro da parcon não ajustado
    Generico.pGravaLancto('VFCPST', DES_VALOR_FCP_ST, LstrPlaCta, '', strCodEve, '', '', strNatCfo, strNatOpe, strCst);
    Generico.pGravaLancto('VALFCP', DES_VALOR_FCP, LstrPlaCta, '', strCodEve, '', '', strNatCfo, strNatOpe, strCst);
    Generico.pGravaLancto('VALIRF', DES_VALOR_RET_IRRF, LstrPlaCta, '', strCodEve, '', '', strNatCfo, strNatOpe, strCst);
    Generico.pGravaLancto('VAL_DIFAL', DES_VALOR_DIFAL, LstrPlaCta, '', strCodEve, '', '', strNatCfo, strNatOpe, strCst);
    qryDados.Next;
  End;

  Result := True;
end;

function TLanConSAI.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConSAI.fPreparaSqlPlanoContas(const AstrSql: String): String;
begin
  result := AstrSql ;
  if (fInformaPlanoContasFaturamento = 'N') or (fAtivaPlanoContasSAI = 'N') then
    Exit ;

  result := '' ;
  result := result + ' SELECT ' ;
  result := result + '   TMP.CLAFIS, ' ;
  result := result + '   TMP.DTAENT, ' ;
  result := result + '   TMP.NUMDOC, ' ;
  result := result + '   TMP.ESPDOC, ' ;
  result := result + '   TMP.CODEMP, ' ;
  result := result + '   TMP.SERIE_, ' ;
  result := result + '   TMP.ENTSAI, ' ;
  result := result + '   TMP.TIP_FC, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.VLRCON, ROUND(TMP.VLRCON*D.CTP_FATCAL,2)) AS VLRCON, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.VALICM, ROUND(TMP.VALICM*D.CTP_FATCAL,2)) AS VALICM, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.VALIPI, ROUND(TMP.VALIPI*D.CTP_FATCAL,2)) AS VALIPI, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.TOTFRE, ROUND(TMP.TOTFRE*D.CTP_FATCAL,2)) AS TOTFRE, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.DESACE, ROUND(TMP.DESACE*D.CTP_FATCAL,2)) AS DESACE, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.VALRET, ROUND(TMP.VALRET*D.CTP_FATCAL,2)) AS VALRET, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.VALPIS, ROUND(TMP.VALPIS*D.CTP_FATCAL,2)) AS VALPIS, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.VALCOF, ROUND(TMP.VALCOF*D.CTP_FATCAL,2)) AS VALCOF, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.TOTMED, ROUND(TMP.TOTMED*D.CTP_FATCAL,2)) AS TOTMED, ' ;
  result := result + '   TMP.NOME, ' ;
  result := result + '   TMP.CNPJ, ' ;
  result := result + '   TMP.SEQGER, ' ;
  result := result + '   TMP.TABELA, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.LIQENT, ROUND(TMP.LIQENT*D.CTP_FATCAL,2)) AS LIQENT, ' ;
  if not fEmptyStr(fRetornaSQLNaurezaOperacao) then
    result := result + '   TMP.NATCFO, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.TOTITE, ROUND(TMP.TOTITE*D.CTP_FATCAL,2)) AS TOTITE, ' ;
  result := result + '   TMP.GER_CODEVE, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.DESESP, ROUND(TMP.DESESP*D.CTP_FATCAL,2)) AS DESESP, ' ;
  result := result + '   TMP.NOMEMP, ' ;
  result := result + '   TMP.DTAREC, ' ;
  result := result + '   TMP.TIPO_CLIENTE_FORNECEDOR, ' ;
  result := result + '   TMP.CODIGO_CLIENTE_FORNECEDOR, ' ;
  result := result + '   TMP.PLANCO, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.VFCPST, ROUND(TMP.VFCPST*D.CTP_FATCAL,2)) AS VFCPST, ' ;
  result := result + '   IF(D.CTP_FATCAL IS NULL, TMP.VALFCP, ROUND(TMP.VALFCP*D.CTP_FATCAL,2)) AS VALFCP, ' ;
  if (FUsaCampoAbfCon) then
    result := result + '   TMP.ITE_ABFCON, ' ;
  if fCfgConGru = 'S' then
    result := result + '   TMP.ITE_CODGRU, ' ;
  if fCfgCSaCst = 'S' then
    result := result + '   TMP.CODFIS, ' ;
  if fCfgMktPla = 'S' then
    result := result + '   TMP.CODIGO_MARKETPLACE, ' ;
  result := result + '   TMP.NATOPE, ' ;
  result := result + '   IFNULL(IFNULL(IFNULL(CTANCO_P.NCO_CODCON, CADCTA_P.CTA_PLANCO), CTANCO_R.NCO_CODCON), CADCTA_R.CTA_PLANCO) AS CTA_PLANCO, ' ;
  result := result + '   IFNULL(IFNULL(IFNULL(CTANCO_P.NCO_CODCTA, CADCTA_P.CTA_CODCTA), CTANCO_R.NCO_CODCTA), CADCTA_R.CTA_CODCTA)  AS CODIGO_PLANO_CONTA, ' ;
  result := result + '   TMP.GER_VALIRF, ' ;
  result := result + '   TMP.VALIRF, ' ;
  result := result + '   TMP.VAL_DIFAL ' ;
  result := result + ' FROM ( ' ;
  result := result + AstrSql ;
  result := result + ' ) AS  TMP ' ;
  result := result + fMontaJoinSaiPlanoContas([jspcReceber, jspcPagar]) ;
end;

function TLanConSAI.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConSAI.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConSAI.pAjustaValorIRRF;
  Var
    dicDocs: TDictionary<String,Double>;
    fltTotIrf: Double;
    strIncDoc: String;
begin
  dicDocs := TDictionary<String,Double>.Create;
  Try
    qryDados.Filtered := False;
    qryDados.Filter   := 'GER_VALIRF > 0';
    qryDados.Filtered := True;

    If qryDados.IsEmpty Then
      Exit;

    qryDados.First;
    While Not qryDados.Eof Do
    Begin
      dicDocs.AddOrSetValue(qryDados.FieldByName('SEQGER').AsString,
                            qryDados.FieldByName('GER_VALIRF').AsFloat);
      qryDados.Next;
    End;

    For strIncDoc In dicDocs.Keys Do
    Begin
      qryDados.Filtered := False;
      qryDados.Filter   := 'SEQGER = '+ strIncDoc.QuotedString;
      qryDados.Filtered := True;

      fltTotIrf := 0;

      qryDados.First;
      While Not qryDados.Eof Do
      Begin
        fltTotIrf := fltTotIrf + qryDados.FieldByName('VALIRF').AsFloat;
        qryDados.Next;
      End;

      //ajusta a diferença no último item de cada documento
      If Not SameValue(fltTotIrf, dicDocs[strIncDoc]) Then
      Begin
        qryDados.Edit;
        qryDados.FieldByName('VALIRF').AsFloat := qryDados.FieldByName('VALIRF').AsFloat +
                                                  (dicDocs[strIncDoc] - fltTotIrf);
        qryDados.Post;
      End;
    End;
  Finally
    dicDocs.Free;
    qryDados.Filter := '';
    qryDados.Filtered := False;
  End;
end;

procedure TLanConSAI.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Saída de Mercadoria Concluída!', ['&OK']);
end;

procedure TLanConSAI.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConSAI.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar;
end;

procedure TLanConSAI.pVerificaSeLancouLanCon;
begin
  generico.pVerificaSeLancouLanCon ;
end;

function TLanConSAI.fRetornaSQLNaurezaOperacao: string;
begin
  result := '' ;
  if fCfgNatDsc = 'N' then
  begin
    if (FUsaCampoNatCfo) then
    begin
      result := result + '      AUX_NATCFO AS NATCFO, ';
    end;
  end
  else
  begin
    result := result + '      IFNULL(GER_NATOPE,"") AS NATCFO, ' ;
  end ;
end;

end.
