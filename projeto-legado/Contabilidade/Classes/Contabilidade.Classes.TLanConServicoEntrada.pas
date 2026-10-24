unit Contabilidade.Classes.TLanConServicoEntrada;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB, UniClientDataSet,
     Contabilidade.Interfaces;

type
  TLanConServicoEntrada = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    FCampoDupAgp_CodEve_Existe : Boolean;
    FCampoDupAgp_PagAnt_Existe : Boolean;
    fltVlrCon : double ;
    fltValIcm : double ;
    fltValPis : double ;
    fltValCof : double ;
    fltVrePis : double ;
    fltVreCof : double ;
    fltRetIss : double ;
    fltReCssl : double ;
    fltReIrrf : double ;
    fltRInssp : double ;
    fltReInss : double ;
    fltLiqEnt : double ;
    fltLiqCon : double ;
    strIncDoc : string ;
    fltRatVlrCon : double ;
    fltRatValIcm : double ;
    fltRatValPis : double ;
    fltRatValCof : double ;
    fltRatVrePis : double ;
    fltRatVreCof : double ;
    fltRatRetIss : double ;
    fltRatReCssl : double ;
    fltRatReIrrf : double ;
    fltRatRInssp : double ;
    fltRatReInss : double ;
    fltRatLiqEnt : double ;
    fltRatLiqCon : double ;

    fltDifVlrCon : double ;
    fltDifValIcm : double ;
    fltDifValPis : double ;
    fltDifValCof : double ;
    fltDifVrePis : double ;
    fltDifVreCof : double ;
    fltDifRetIss : double ;
    fltDifReCssl : double ;
    fltDifReIrrf : double ;
    fltDifRInssp : double ;
    fltDifReInss : double ;
    fltDifLiqEnt : double ;
    fltDifLiqCon : double ;
    FstrCentroCustoDefault : String ;
    FblnFIS_VRECOF: Boolean ;
    FblnFIS_VREPIS: Boolean ;
    FCdsServicoAdt: TUniClientDataset;
    FColunasValorContabil: TSetColunasValorLiquidoContabil ;
    function fFieldMensagemValidacao:string;
    procedure pZerarValores;
    procedure pSomarValores;
    procedure pAlterarValores;
    procedure pCarregaServicoAdt;
    function fPreparaSqlUnions(const AintColuna: integer): string ;
    function fRetornaFiltroDupAgpPagAnt: string ;
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
     Contabilidade.Classes.TEventoContabil, System.Generics.Collections, Contabilidade.Classes.TTrataIncDoc;

{ TLanConServicoEntrada }

constructor TLanConServicoEntrada.Create(strTipLan: String;
  pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  qryDados.CachedUpdates := True;
  qryDados.Options.SetFieldsReadOnly := False;
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Generico.FblnMostraWarningGeracaoMovimento := False;
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  FCampoDupAgp_CodEve_Existe := fCampoExiste('DUPAGP', 'CTP_CODEVE');
  FCampoDupAgp_PagAnt_Existe := fCampoExiste('DUPAGP', 'CTP_PAGANT');
  FstrCentroCustoDefault := fCentroCustoDefaultCntDespRecCus ;
  FblnFIS_VRECOF := fCampoExiste('CADFIS', 'FIS_VRECOF') ;
  FblnFIS_VREPIS := fCampoExiste('CADFIS', 'FIS_VREPIS') ;
  FCdsServicoAdt := Nil;
  FColunasValorContabil := [Low(TColunasValorLiquidoContabil)..High(TColunasValorLiquidoContabil)];
  pVerificaColunasExitemValorContabil(FColunasValorContabil) ;
end;

destructor TLanConServicoEntrada.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  if Assigned(FCdsServicoAdt) then
    FreeAndNil(FCdsServicoAdt);
  inherited;
end;

function TLanConServicoEntrada.fCarregaDados: Boolean;
  Var
    strSQL : String;
    LintCnt : Integer;
    LlstComCfopServico: TList<Integer> ;
begin
  strSQL := '';
  LlstComCfopServico := fColunasComCfopServico(recParCon, 'E') ;
  try
    for LintCnt in LlstComCfopServico do
    begin
      strSQL := strSQL + ifthen(LlstComCfopServico.count = 1, '', '(') ;
      strSQL := strSQL + fPreparaSqlUnions(LintCnt) ;
      strSQL := strSQL + ifthen(LlstComCfopServico.count = 1, '', ')') ;
      if LlstComCfopServico.count > 1 then
        strSQL := strSQL + iif(LintCnt <> LlstComCfopServico.Items[LlstComCfopServico.Count-1], ' UNION ', '') ;
    end ;
  finally
    FreeAndNil(LlstComCfopServico) ;
  end ;

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(strSQL);

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConServicoEntrada.fDeletaLanCon: Boolean;
begin
  Result := True;
end;

function TLanConServicoEntrada.fEfetuaLancamentos: Boolean;
  Var
    strPlaCta : String;
    strCodEve : String;
    strEveNec: string;
    LstrNatCfo: String;
begin
  pgbProgresso.Properties.Max := qryDados.RecordCount;
  strEveNec := fRetornaEventosNaoExportar;
  pCarregaServicoAdt;
  strIncDoc := '' ;
  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    Application.ProcessMessages;

    if FCdsServicoAdt.FindKey([qryDados.FieldByName('FISINC').AsString]) then
    begin
      qryDados.Next;
      Continue;
    end;

    if (not fEmptyStr(strEveNec)) and (not qryDados.FieldByName('CODEVE').IsNull)
       and (Pos(qryDados.FieldByName('CODEVE').AsString, strEveNec) > 0) then
    begin
      Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Evento com o código '+qryDados.FieldByName('CODEVE').AsString+' configurado para não ser exportado na CFG_EVENEC!'), qryDados);
      qryDados.Next;
      Continue;
    end;

    fltVlrCon   := qryDados.FieldByName('VLRCON_TOT').AsFloat ;
    fltValIcm   := qryDados.FieldByName('VALICM_TOT').AsFloat ;
    fltValPis   := qryDados.FieldByName('VALPIS_TOT').AsFloat ;
    fltValCof   := qryDados.FieldByName('VALCOF_TOT').AsFloat ;
    fltVrePis   := qryDados.FieldByName('VREPIS_TOT').AsFloat ;
    fltVreCof   := qryDados.FieldByName('VRECOF_TOT').AsFloat ;
    fltRetIss   := qryDados.FieldByName('RETISS_TOT').AsFloat ;
    fltReCssl   := qryDados.FieldByName('RECSSL_TOT').AsFloat ;
    fltReIrrf   := qryDados.FieldByName('REIRRF_TOT').AsFloat ;
    fltRInssp   := qryDados.FieldByName('RINSSP_TOT').AsFloat ;
    fltReInss   := qryDados.FieldByName('REINSS_TOT').AsFloat ;
    fltLiqEnt   := qryDados.FieldByName('LIQENT_TOT').AsFloat ;
    fltLiqCon   := qryDados.FieldByName('LIQCON_TOT').AsFloat ;

    if qryDados.FieldByName('FISINC').AsString <> strIncDoc then
    begin
      strIncDoc := qryDados.FieldByName('FISINC').AsString;
      pZerarValores;
    end;
    pSomarValores;

    qryDados.Next;
    if (qryDados.FieldByName('FISINC').AsString <> strIncDoc) or (qryDados.Eof) then
    begin
      if not qryDados.Eof then
        qryDados.Prior;

      fltDifVlrCon   := fFormataFloat(fltVlrCon - fltRatVlrCon, 2) ;
      fltDifValIcm   := fFormataFloat(fltValIcm - fltRatValIcm, 2) ;
      fltDifValPis   := fFormataFloat(fltValPis - fltRatValPis, 2) ;
      fltDifValCof   := fFormataFloat(fltValCof - fltRatValCof, 2) ;
      fltDifVrePis   := fFormataFloat(fltVrePis - fltRatVrePis, 2) ;
      fltDifVreCof   := fFormataFloat(fltVreCof - fltRatVreCof, 2) ;
      fltDifRetIss   := fFormataFloat(fltRetIss - fltRatRetIss, 2) ;
      fltDifReCssl   := fFormataFloat(fltReCssl - fltRatReCssl, 2) ;
      fltDifReIrrf   := fFormataFloat(fltReIrrf - fltRatReIrrf, 2) ;
      fltDifRInssp   := fFormataFloat(fltRInssp - fltRatRInssp, 2) ;
      fltDifReInss   := fFormataFloat(fltReInss - fltRatReInss, 2) ;
      fltDifLiqEnt   := fFormataFloat(fltLiqEnt - fltRatLiqEnt, 2) ;
      fltDifLiqCon   := fFormataFloat(fltLiqCon - fltRatLiqCon, 2) ;

      if (fltDifVlrCon <> 0) or
         (fltDifValIcm <> 0) or
         (fltDifValPis <> 0) or
         (fltDifValCof <> 0) or
         (fltDifVrePis <> 0) or
         (fltDifVreCof <> 0) or
         (fltDifRetIss <> 0) or
         (fltDifReCssl <> 0) or
         (fltDifReIrrf <> 0) or
         (fltDifRInssp <> 0) or
         (fltDifReInss <> 0) or
         (fltDifLiqEnt <> 0) or
         (fltDifLiqCon <> 0) then
      begin
        pAlterarValores;
      end;
    end
    else
    begin
      qryDados.Prior;
    end;

    strCodEve := TFactoryEventoContabil.New.fConfiguraEvento(qryDados.FieldByName('CODEVE').AsString, 'ENT', qryDados.FieldByName('CLAFIS').AsString).fConsultaEvento(FstrCentroCustoDefault);
    strPlaCta := qryDados.FieldByName('CTA_PLANCO').AsString;
    LstrNatCfo := qryDados.FieldByName('NATCFO').AsString;

    Generico.pGravaLancto('VLRCON', 'Vr.Contábil', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('VALICM', 'Vr.ICMS', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('VALPIS', 'Vr.PIS', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('VALCOF', 'Vr.COFINS', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('RETISS', 'Vr.ISS', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('REINSS', 'Vr.INSS', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('RECSSL', 'Vr.CSLL', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('REIRRF', 'Vr.IRPJ', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('RINSSP', DES_VALOR_INSS_PATRONAL, strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('LIQENT', DES_VALOR_LIQUIDO_ENTRADA, strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('LIQCON', DES_VALOR_LIQUIDO_CONTABIL, strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('VREPIS', DES_VALOR_RETENCAO_PIS, strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('VRECOF', DES_VALOR_RETENCAO_COFINS, strPlaCta, '', strCodEve, '', '', LstrNatCfo);

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConServicoEntrada.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConServicoEntrada.fFieldMensagemValidacao: string;
var
  strSQL : string ;
begin
  strSQL := '' ;
  strSQL := strSQL + ' ( ' ;
  strSQL := strSQL + ' SELECT IF( ' ;
  strSQL := strSQL + '           ((IF(SUB_P.CTP_DTACAD IS NULL, SUB_DUPAGP.CTP_DTACAD, SUB_P.CTP_DTACAD) <> SUB_CADFIS.FIS_DTAENT) AND (SUB_P.CTP_PAGANT = "N")), ' ;
  strSQL := strSQL + '           CONCAT(CONCAT(CONCAT(CONCAT(CONCAT("Data divergente CADFIS[",DATE_FORMAT(SUB_CADFIS.FIS_DTAENT,"%d/%m/%Y")), "] e "),'+' IF(SUB_P.CTP_DTACAD IS NULL, "DUPAGP[", "CADPAG[")),IF(SUB_P.CTP_DTACAD IS NULL, DATE_FORMAT(SUB_DUPAGP.CTP_DTACAD,"%d/%m/%Y"), DATE_FORMAT(SUB_P.CTP_DTACAD,"%d/%m/%Y"))),"]"), ' ;
  strSQL := strSQL + '           NULL ' ;
  strSQL := strSQL + '           ) AS mensagem ' ;
  strSQL := strSQL + ' FROM CADFIS AS SUB_CADFIS ' ;
  strSQL := strSQL + '    LEFT JOIN DUPAGP AS SUB_DUPAGP ON SUB_DUPAGP.CTP_NUMDUP = SUB_CADFIS.FIS_NUMDOC ' ;
  strSQL := strSQL + '                    AND SUB_DUPAGP.CTP_CODFOR = SUB_CADFIS.FIS_FORCLI ' ;
  strSQL := strSQL + '                    AND SUB_DUPAGP.CTP_CODEMP = SUB_CADFIS.FIS_CODEMP ' ;
  strSQL := strSQL + '                    AND IFNULL(SUB_DUPAGP.CTP_SERIE_,"") = IFNULL(SUB_CADFIS.FIS_SERIE_, "") ' ;
  strSQL := strSQL + '                    AND SUB_DUPAGP.CTP_PARCEL = "A" ' ;
  strSQL := strSQL + '    LEFT JOIN CADPAG SUB_P ON SUB_P.CTP_NUMDUP = SUB_CADFIS.FIS_NUMDOC ' ;
  strSQL := strSQL + '                      AND SUB_P.CTP_CODFOR = SUB_CADFIS.FIS_FORCLI ' ;
  strSQL := strSQL + '                      AND SUB_P.CTP_CODEMP = SUB_CADFIS.FIS_CODEMP ' ;
  strSQL := strSQL + '                      AND IFNULL(SUB_P.CTP_SERIE_,"") = IFNULL(SUB_CADFIS.FIS_SERIE_, "") ' ;
  strSQL := strSQL + '                      AND SUB_P.CTP_SEQBAI = 0 ' ;
  strSQL := strSQL + '                      AND SUB_P.CTP_PARCEL = "A" ' ;
  strSQL := strSQL + '  WHERE SUB_CADFIS.AUTOINCREM = CADFIS.AUTOINCREM ' ;
  strSQL := strSQL + '        AND (SUB_P.CTP_DTACAD IS NOT NULL OR SUB_DUPAGP.CTP_DTACAD IS NOT NULL) ' ;
  strSQL := strSQL + '  ORDER BY IF(SUB_P.CTP_DTACAD IS NULL, SUB_DUPAGP.CTP_DTACAD, SUB_P.CTP_DTACAD) DESC ' ;
  strSQL := strSQL + '  LIMIT 1 ' ;
  strSQL := strSQL + '  ) ' ;
  result := strSQL ;
end;

function TLanConServicoEntrada.fPreparaSqlUnions(
  const AintColuna: integer): string;
var
  LstrSQL: string ;
begin
  LstrSQL := '';
  LstrSQL := LstrSQL + ' SELECT FIS_CLFSC'+ intTostr(AintColuna) +' AS CLAFIS, FIS_DTAENT AS DTAENT, FIS_NUMDOC AS NUMDOC, ';
  LstrSQL := LstrSQL + '        FIS_ESPDOC AS ESPDOC, FIS_CODEMP AS CODEMP, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, ' + fVlrContabilLivro(AintColuna) + ', ROUND(' + fVlrContabilLivro(AintColuna) + '*D.CTP_FATCAL,2)) AS VLRCON, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, ' + fVlrIcmsLivro(AintColuna) + ', ROUND(' + fVlrIcmsLivro(AintColuna) + '*D.CTP_FATCAL,2)) AS VALICM, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_TOTPIS, ROUND(FIS_TOTPIS*D.CTP_FATCAL,2)) AS VALPIS, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_TOTCOF, ROUND(FIS_TOTCOF*D.CTP_FATCAL,2)) AS VALCOF, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, '+ fFieldVREPIS(FblnFIS_VREPIS) +', ROUND('+ fFieldVREPIS(FblnFIS_VREPIS) +'*D.CTP_FATCAL,2)) AS VREPIS, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, '+ fFieldVRECOF(FblnFIS_VRECOF) +', ROUND('+ fFieldVRECOF(FblnFIS_VRECOF) +'*D.CTP_FATCAL,2)) AS VRECOF, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_RETISS, ROUND(FIS_RETISS*D.CTP_FATCAL,2)) AS RETISS, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_RECSSL, ROUND(FIS_RECSSL*D.CTP_FATCAL,2)) AS RECSSL, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_REIRRF, ROUND(FIS_REIRRF*D.CTP_FATCAL,2)) AS REIRRF, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, IFNULL(' + fRetornaCampoInssPatronalCadfis + ',0), ROUND(IFNULL(' + fRetornaCampoInssPatronalCadfis + ',0) * D.CTP_FATCAL,2)) AS RINSSP, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_REINSS, ROUND(FIS_REINSS*D.CTP_FATCAL,2)) AS REINSS, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, ' + fValorLiquidoEntradaLivro(AintColuna) + ', ROUND(' + fValorLiquidoEntradaLivro(AintColuna) + '*D.CTP_FATCAL,2)) AS LIQENT, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, ' + fValorLiquidoContabilLivro(FColunasValorContabil, AintColuna) + ', ROUND(' + fValorLiquidoContabilLivro(FColunasValorContabil, AintColuna) + '*D.CTP_FATCAL,2)) AS LIQCON, ';

  LstrSQL := LstrSQL + '        ' + fVlrContabilLivro(AintColuna) + ' AS VLRCON_TOT, ';
  LstrSQL := LstrSQL + '        ' + fVlrIcmsLivro(AintColuna) + ' AS VALICM_TOT, ';
  LstrSQL := LstrSQL + '        FIS_TOTPIS AS VALPIS_TOT, ';
  LstrSQL := LstrSQL + '        FIS_TOTCOF AS VALCOF_TOT, ';
  LstrSQL := LstrSQL + '        '+ fFieldVREPIS(FblnFIS_VREPIS) +' AS VREPIS_TOT, ';
  LstrSQL := LstrSQL + '        '+ fFieldVRECOF(FblnFIS_VRECOF) +' AS VRECOF_TOT, ';
  LstrSQL := LstrSQL + '        FIS_RETISS AS RETISS_TOT, ';
  LstrSQL := LstrSQL + '        FIS_RECSSL AS RECSSL_TOT, ';
  LstrSQL := LstrSQL + '        FIS_REIRRF AS REIRRF_TOT, ';
  LstrSQL := LstrSQL + '        IFNULL(' + fRetornaCampoInssPatronalCadfis + ',0) AS RINSSP_TOT, ';
  LstrSQL := LstrSQL + '        FIS_REINSS AS REINSS_TOT, ';
  LstrSQL := LstrSQL + '        ' + fValorLiquidoEntradaLivro(AintColuna) + ' AS LIQENT_TOT, ';
  LstrSQL := LstrSQL + '        ' + fValorLiquidoContabilLivro(FColunasValorContabil, AintColuna) + ' AS LIQCON_TOT, ';

  if (FCampoDupAgp_CodEve_Existe) then
    LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, IF(P.CTP_CODEVE IS NULL, DUPAGP.CTP_CODEVE, P.CTP_CODEVE), D.CTP_CODEVE) AS CODEVE, '
  else
    LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, P.CTP_CODEVE, D.CTP_CODEVE) AS CODEVE, ';

  LstrSQL := LstrSQL + '        IF(FIS_TIP_FC = "C", CLI_NOMCLI, FOR_NOMFOR) AS NOME, FIS_SERIE_, ';
  LstrSQL := LstrSQL + '        IF(FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_) AS CNPJ, FIS_FORCLI, ';
  LstrSQL := LstrSQL + '        FIS_TIP_FC AS TIPO_CLIENTE_FORNECEDOR, ';
  LstrSQL := LstrSQL + '        IF(FIS_TIP_FC = "C", IFNULL(NCO_CODCLI, CLI_CODCLI), IFNULL(NCO_CODFOR, FOR_CODFOR)) AS CODIGO_CLIENTE_FORNECEDOR, ';
  LstrSQL := LstrSQL + '        IF(FIS_TIP_FC = "C", IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO), IFNULL(FORNCO.NCO_CODCON, FOR_PLANCO)) AS PLANCO, FIS_TIP_FC, ';
  LstrSQL := LstrSQL + '        IFNULL(CTANCO.NCO_CODCON, CTA_PLANCO) AS CTA_PLANCO, CADFIS.AUTOINCREM AS FISINC, "CADFIS" AS TABELA, ';
  LstrSQL := LstrSQL + '        IFNULL(CTANCO.NCO_CODCTA, CTA_CODCTA) AS CODIGO_PLANO_CONTA, ';

  if fCfgDesMva = 'S' then
  begin
    LstrSQL := LstrSQL + '        D.CTP_CODEMP AS CDE_CODEMP, ';
    LstrSQL := LstrSQL + '        ED.EMP_NOMEMP AS CDE_NOMEMP, ';
    LstrSQL := LstrSQL + '        ED.EMP_C_G_C_ AS CDE_C_G_C_, ';
  end ;
  LstrSQL := LstrSQL + '        D.AUTOINCREM IS NOT NULL AS IS_CTPDET, ';
  LstrSQL := LstrSQL + '        CAST(' + fFieldMensagemValidacao + ' AS CHAR(128)) AS MENSAGEM_VALIDACAO, ';
  LstrSQL := LstrSQL + '        IFNULL(FIS_NATOPE,"") AS NATCFO ';

  LstrSQL := LstrSQL + '   FROM CADFIS ';
  LstrSQL := LstrSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI ';
  LstrSQL := LstrSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI ';

  LstrSQL := LstrSQL + '   LEFT JOIN DUPAGP ON DUPAGP.CTP_NUMDUP = FIS_NUMDOC ';
  LstrSQL := LstrSQL + '                   AND DUPAGP.CTP_CODFOR = FIS_FORCLI ';
  LstrSQL := LstrSQL + '                   AND DUPAGP.CTP_CODEMP = FIS_CODEMP ';
  LstrSQL := LstrSQL + '                   AND IFNULL(DUPAGP.CTP_SERIE_,"") = IFNULL(FIS_SERIE_, "") ';
  LstrSQL := LstrSQL + '                   AND DUPAGP.CTP_PARCEL = "A" ';
  LstrSQL := LstrSQL + fRetornaFiltroDupAgpPagAnt ;

  LstrSQL := LstrSQL + '   LEFT JOIN CADPAG P ON P.CTP_NUMDUP = FIS_NUMDOC ';
  LstrSQL := LstrSQL + '                     AND P.CTP_CODFOR = FIS_FORCLI ';
  LstrSQL := LstrSQL + '                     AND P.CTP_CODEMP = FIS_CODEMP ';
  LstrSQL := LstrSQL + '                     AND IFNULL(P.CTP_SERIE_,"") = IFNULL(FIS_SERIE_, "") ';
  LstrSQL := LstrSQL + '                     AND P.CTP_SEQBAI = 0 ';
  LstrSQL := LstrSQL + '                     AND P.CTP_PARCEL = "A" ';
  LstrSQL := LstrSQL + '                     AND CASE WHEN P.CTP_PAGANT = "N" THEN P.CTP_DTACAD = FIS_DTAENT ELSE TRUE END ';

  LstrSQL := LstrSQL + '   LEFT JOIN CTPDET D ON CASE WHEN DUPAGP.CTP_CODFOR IS NULL THEN P.CTP_CODFOR ELSE DUPAGP.CTP_CODFOR END = D.CTP_CODFOR ';
  LstrSQL := LstrSQL + '     AND CASE WHEN DUPAGP.CTP_NUMDUP IS NULL THEN P.CTP_NUMDUP ELSE DUPAGP.CTP_NUMDUP END = D.CTP_NUMDUP ';
  LstrSQL := LstrSQL + '     AND CASE WHEN DUPAGP.CTP_PARCEL IS NULL THEN P.CTP_PARCEL ELSE DUPAGP.CTP_PARCEL END = D.CTP_PARCEL ';
  LstrSQL := LstrSQL + '     AND CASE WHEN DUPAGP.CTP_CODEMP IS NULL THEN P.CTP_CODEMP ELSE DUPAGP.CTP_CODEMP END = D.CTP_EMPORI ';
  LstrSQL := LstrSQL + '     AND CASE WHEN DUPAGP.CTP_NUMDUP IS NULL THEN TRIM(COALESCE(P.CTP_SERIE_, "")) ELSE TRIM(COALESCE(DUPAGP.CTP_SERIE_, "")) END = TRIM(COALESCE(D.CTP_SERIE_, "")) ';
  LstrSQL := LstrSQL + '   LEFT JOIN CADEMP ED ON D.CTP_CODEMP = ED.EMP_CODEMP  ';

  LstrSQL := LstrSQL + '   LEFT JOIN CADCTA ON CTA_CODCTA = IF(D.CTP_CODCTA IS NULL, IF(DUPAGP.AUTOINCREM IS NULL, P.CTP_CODCTA, DUPAGP.CTP_CODCTA), D.CTP_CODCTA) ';

  LstrSQL := LstrSQL + '   LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  LstrSQL := LstrSQL + '                   AND CLINCO.NCO_CODEMP = FIS_CODEMP ';
  LstrSQL := LstrSQL + '   LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR ';
  LstrSQL := LstrSQL + '                   AND FORNCO.NCO_CODEMP = FIS_CODEMP ';

  LstrSQL := LstrSQL + '   LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = IF(D.CTP_CODCTA IS NULL, IF(DUPAGP.AUTOINCREM IS NULL, P.CTP_CODCTA, DUPAGP.CTP_CODCTA), D.CTP_CODCTA) ';
  LstrSQL := LstrSQL + '                   AND CTANCO.NCO_CODEMP = ' + iif(fCfgDesMva = 'S', 'IF(D.CTP_CODEMP IS NULL, FIS_CODEMP, D.CTP_CODEMP)', 'FIS_CODEMP') ;

  LstrSQL := LstrSQL + '  WHERE FIS_ENTSAI = "E" ';
  LstrSQL := LstrSQL + '    AND RIGHT(FIS_CLFSC'+ intTostr(AintColuna) +', 3) = "933" ';

  If Not fEmptyStr(recParCon.strCodEmp) Then
    LstrSQL := LstrSQL + '  AND FIS_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    LstrSQL := LstrSQL + '  AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  LstrSql := LstrSql + TTrataIncDocContabil
                        .New
                        .fColunaIncDoc('CADFIS.AUTOINCREM')
                        .fIncDoc(recParCon.strIncDoc)
                        .fArrIncDoc(recParCon.arrIncDoc)
                        .fQuerySql(Nil)
                        .fExecute ;

  result := LstrSQL ;
end;

function TLanConServicoEntrada.fRetornaFiltroDupAgpPagAnt: string;
begin
  if FCampoDupAgp_PagAnt_Existe then
    result := '                   AND CASE WHEN DUPAGP.CTP_PAGANT = "N" THEN DUPAGP.CTP_DTACAD = FIS_DTAENT ELSE TRUE END ' ;
end;

function TLanConServicoEntrada.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConServicoEntrada.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConServicoEntrada.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Serviços de Entrada Concluído!', ['&OK']);
end;

procedure TLanConServicoEntrada.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConServicoEntrada.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

procedure TLanConServicoEntrada.pZerarValores;
begin
  fltRatVlrCon := 0 ;
  fltRatValIcm := 0 ;
  fltRatValPis := 0 ;
  fltRatValCof := 0 ;
  fltRatVrePis := 0 ;
  fltRatVreCof := 0 ;
  fltRatRetIss := 0 ;
  fltRatReCssl := 0 ;
  fltRatReIrrf := 0 ;
  fltRatRInssp := 0 ;
  fltRatReInss := 0 ;
  fltRatLiqEnt := 0 ;
  fltRatLiqCon := 0 ;

  fltDifVlrCon := 0 ;
  fltDifValIcm := 0 ;
  fltDifValPis := 0 ;
  fltDifValCof := 0 ;
  fltDifVrePis := 0 ;
  fltDifVreCof := 0 ;
  fltDifRetIss := 0 ;
  fltDifReCssl := 0 ;
  fltDifReIrrf := 0 ;
  fltDifRInssp := 0 ;
  fltDifReInss := 0 ;
  fltDifLiqEnt := 0 ;
  fltDifLiqCon := 0 ;
end;

procedure TLanConServicoEntrada.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConServicoEntrada.pSomarValores;
begin
  fltRatVlrCon := fltRatVlrCon + qryDados.FieldByName('VLRCON').AsFloat;
  fltRatValIcm := fltRatValIcm + qryDados.FieldByName('VALICM').AsFloat;
  fltRatValPis := fltRatValPis + qryDados.FieldByName('VALPIS').AsFloat;
  fltRatValCof := fltRatValCof + qryDados.FieldByName('VALCOF').AsFloat;
  fltRatVrePis := fltRatVrePis + qryDados.FieldByName('VREPIS').AsFloat;
  fltRatVreCof := fltRatVreCof + qryDados.FieldByName('VRECOF').AsFloat;
  fltRatRetIss := fltRatRetIss + qryDados.FieldByName('RETISS').AsFloat;
  fltRatReCssl := fltRatRecSsl + qryDados.FieldByName('RECSSL').AsFloat;
  fltRatReIrrf := fltRatReIrrf + qryDados.FieldByName('REIRRF').AsFloat;
  fltRatRInssp := fltRatRInssp + qryDados.FieldByName('RINSSP').AsFloat;
  fltRatReInss := fltRatReInss + qryDados.FieldByName('REINSS').AsFloat;
  fltRatLiqEnt := fltRatLiqEnt + qryDados.FieldByName('LIQENT').AsFloat;
  fltRatLiqCon := fltRatLiqCon + qryDados.FieldByName('LIQCON').AsFloat;
end;

procedure TLanConServicoEntrada.pAlterarValores;
begin
  qryDados.Edit;
  if fltDifVlrCon <> 0 then
    qryDados.FieldByName('VLRCON').AsFloat := qryDados.FieldByName('VLRCON').AsFloat + fltDifVlrCon ;
  if fltDifValIcm <> 0 then
    qryDados.FieldByName('VALICM').AsFloat := qryDados.FieldByName('VALICM').AsFloat + fltDifVlrCon ;
  if fltDifValPis <> 0 then
    qryDados.FieldByName('VALPIS').AsFloat := qryDados.FieldByName('VALPIS').AsFloat + fltDifValPis ;
  if fltDifValCof <> 0 then
    qryDados.FieldByName('VALCOF').AsFloat := qryDados.FieldByName('VALCOF').AsFloat + fltDifValCof ;
  if fltDifVrePis <> 0 then
    qryDados.FieldByName('VREPIS').AsFloat := qryDados.FieldByName('VREPIS').AsFloat + fltDifVrePis ;
  if fltDifVreCof <> 0 then
    qryDados.FieldByName('VRECOF').AsFloat := qryDados.FieldByName('VRECOF').AsFloat + fltDifVreCof ;
  if fltDifRetIss <> 0 then
    qryDados.FieldByName('RETISS').AsFloat := qryDados.FieldByName('RETISS').AsFloat + fltDifRetIss ;
  if fltDifRecSsl <> 0 then
    qryDados.FieldByName('RECSSL').AsFloat := qryDados.FieldByName('RECSSL').AsFloat + fltDifRecSsl ;
  if fltDifReIrrf <> 0 then
    qryDados.FieldByName('REIRRF').AsFloat := qryDados.FieldByName('REIRRF').AsFloat + fltDifReIrrf ;
  if fltDifRInssp <> 0 then
    qryDados.FieldByName('RINSSP').AsFloat := qryDados.FieldByName('RINSSP').AsFloat + fltDifRInssp ;
  if fltDifLiqEnt <> 0 then
    qryDados.FieldByName('LIQENT').AsFloat := qryDados.FieldByName('LIQENT').AsFloat + fltDifLiqEnt ;
  if fltDifLiqCon <> 0 then
    qryDados.FieldByName('LIQCON').AsFloat := qryDados.FieldByName('LIQCON').AsFloat + fltDifLiqCon ;
  if fltDifReInss <> 0 then
    qryDados.FieldByName('REINSS').AsFloat := qryDados.FieldByName('REINSS').AsFloat + fltDifReInss ;
  qryDados.Post;
end;

procedure TLanConServicoEntrada.pCarregaServicoAdt;
begin
  if Assigned(FCdsServicoAdt) then
    FreeAndNil(FCdsServicoAdt);

  FCdsServicoAdt := fCarregaEntAdtFis(recParCon);
end;

end.
