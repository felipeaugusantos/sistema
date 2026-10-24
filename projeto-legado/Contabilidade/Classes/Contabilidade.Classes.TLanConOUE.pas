unit Contabilidade.Classes.TLanConOUE;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB, UniClientDataSet,
     Contabilidade.Interfaces;

type
  TLanConOUE = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    FblnUsaCampoNatCfo : boolean;
    FblnUsaCampoNatOpeMovTri: boolean;
    fltVlrCon : double ;
    fltValIcm : double ;
    fltValIpi : double ;
    fltDesAce : double ;
    fltValRet : double ;
    fltValPis : double ;
    fltValCof : double ;
    fltLiqEnt : double ;
    fltReIrrf : double ;
    fltRInssp : double ;
    fltReCssl : double ;
    fltReInss : double ;
    fltValIss : double ;
    strIncDoc : string ;
    fltDifVlrCon : double ;
    fltDifValIcm : double ;
    fltDifValIpi : double ;
    fltDifDesAce : double ;
    fltDifValRet : double ;
    fltDifValPis : double ;
    fltDifValCof : double ;
    fltDifLiqEnt : double ;
    fltDifReIrrf : double ;
    fltDifRInssp : double ;
    fltDifReCssl : double ;
    fltDifReInss : double ;
    fltDifValIss : double ;

    fltRatVlrCon : double ;
    fltRatValIcm : double ;
    fltRatValIpi : double ;
    fltRatDesAce : double ;
    fltRatValRet : double ;
    fltRatValPis : double ;
    fltRatValCof : double ;
    fltRatLiqEnt : double ;
    fltRatReIrrf : double ;
    fltRatRInssp : double ;
    fltRatReCssl : double ;
    fltRatReInss : double ;
    fltRatValIss : double ;
    function fPodeDeletar: boolean;
    procedure pAlterarValores;
    procedure pSomarValores;
    procedure pZerarValores;
    function fRetornaSQLNaurezaOperacao: string ;
  public
    function fCarregaDados: Boolean;
    function fEfetuaLancamentos: Boolean;
    procedure pMensagemConclusao;
    function fTemParametrosConfigurados: Boolean;
    function fDeletaLanCon: Boolean;
    function GetListaErros: TUniClientDataSet;
    procedure pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False); overload;
    procedure pSetaPreValidacao(const Value: Boolean); overload;
    constructor Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
    destructor Destroy; override;
    procedure pVerificaSeLancouLanCon;
    function fEfetuaLancamentosPreValidacao: Boolean;
  End;

implementation

uses Forms, SysUtils, StrUtils, untFuncoesSimples, Contabilidade.Funcoes,
Contabilidade.Classes.TTrataIncDoc;

{ TLanConOUE }

constructor TLanConOUE.Create(strTipLan: String; pgbProgresso: TcxProgressBar;
  recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  qryDados.CachedUpdates := True;
  qryDados.Options.SetFieldsReadOnly := False;
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Generico.FblnMostraWarningGeracaoMovimento := False;
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  FblnUsaCampoNatCfo := fCampoExiste('AUXMOV', 'AUX_NATCFO');
  FblnUsaCampoNatOpeMovTri := fUsarNaturezaOperacaoDoItemNoEnt ;
end;

destructor TLanConOUE.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConOUE.fCarregaDados: Boolean;
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT DISTINCT '+ ifthen(not FblnUsaCampoNatOpeMovTri, 'FIS_CLFSC1', 'CASE WHEN MOVDET.AUTOINCREM IS NULL THEN FIS_CLFSC1 ELSE DET_CLAFIS END') + ' AS CLAFIS, FIS_DTAENT AS DTAENT, ';
  strSQL := strSQL + '        FIS_ESPDOC AS ESPDOC, FIS_CODEMP AS CODEMP, ';
  strSQL := strSQL + '        FIS_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '        FOR_NOMFOR AS NOME, FIS_SERIE_, ';
  strSQL := strSQL + '        FOR_C_G_C_ AS CNPJ, FIS_FORCLI, ';
  strSQL := strSQL + '        FIS_TIP_FC AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        FOR_CODFOR AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IFNULL(FORNCO.NCO_CODCON, CADFOR.FOR_PLANCO) AS PLANCO, FIS_TIP_FC, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, ' + fVlrContabilLivro + ', ROUND(' + fVlrContabilLivro + '*D.CTP_FATCAL,2)) AS VLRCON, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, ' + fVlrIcmsLivro     + ', ROUND(' + fVlrIcmsLivro + '*D.CTP_FATCAL,2))     AS VALICM, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, ' + fVlrIpiLivro     + ', ROUND(' + fVlrIpiLivro     + '*D.CTP_FATCAL,2)) AS VALIPI, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, IFNULL(FIS_DACES1,0), ROUND(IFNULL(FIS_DACES1,0)*D.CTP_FATCAL,2)) AS DESACE, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, IFNULL(FIS_RETID1,0), ROUND(IFNULL(FIS_RETID1,0)*D.CTP_FATCAL,2)) AS VALRET, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_TOTPIS,           ROUND(FIS_TOTPIS*D.CTP_FATCAL,2))           AS VALPIS, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_TOTCOF,           ROUND(FIS_TOTCOF*D.CTP_FATCAL,2))           AS VALCOF, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, ' + fValorLiquidoEntradaLivro(1, True) + ', ROUND(' + fValorLiquidoEntradaLivro(1, True) + '*D.CTP_FATCAL,2)) AS LIQENT, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, IFNULL(FIS_REIRRF,0), ROUND(IFNULL(FIS_REIRRF,0)*D.CTP_FATCAL,2)) AS REIRRF, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, IFNULL(' + fRetornaCampoInssPatronalCadfis + ',0), ROUND(IFNULL(' + fRetornaCampoInssPatronalCadfis + ',0)*D.CTP_FATCAL,2)) AS RINSSP, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, IFNULL(FIS_RECSSL,0), ROUND(IFNULL(FIS_RECSSL,0)*D.CTP_FATCAL,2)) AS RECSSL, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, IFNULL(FIS_REINSS,0), ROUND(IFNULL(FIS_REINSS,0)*D.CTP_FATCAL,2)) AS REINSS, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, IFNULL(FIS_VALISS,0), ROUND(IFNULL(FIS_VALISS,0)*D.CTP_FATCAL,2)) AS VALISS, ';

  strSQL := strSQL + '        ' + fVlrContabilLivro + ' AS VLRCON_TOT, ';
  strSQL := strSQL + '        ' + fVlrIcmsLivro     + ' AS VALICM_TOT, ';
  strSQL := strSQL + '        ' + fVlrIpiLivro     + ' AS VALIPI_TOT, ';
  strSQL := strSQL + '        IFNULL(FIS_DACES1,0) AS DESACE_TOT, ';
  strSQL := strSQL + '        IFNULL(FIS_RETID1,0) AS VALRET_TOT, ';
  strSQL := strSQL + '        FIS_TOTPIS AS VALPIS_TOT, ';
  strSQL := strSQL + '        FIS_TOTCOF AS VALCOF_TOT, ';
  strSQL := strSQL + '        ' + fValorLiquidoEntradaLivro(1, True) + ' AS LIQENT_TOT, ';
  strSQL := strSQL + '        IFNULL(FIS_REIRRF,0) AS REIRRF_TOT, ';
  strSQL := strSQL + '        IFNULL(' + fRetornaCampoInssPatronalCadfis + ',0) AS RINSSP_TOT, ';
  strSQL := strSQL + '        IFNULL(FIS_RECSSL,0) AS RECSSL_TOT, ';
  strSQL := strSQL + '        IFNULL(FIS_REINSS,0) AS REINSS_TOT, ';
  strSQL := strSQL + '        IFNULL(FIS_VALISS,0) AS VALISS_TOT, ';

  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, P.CTP_CODEVE,         D.CTP_CODEVE)                               AS CODEVE, ';
  strSQL := strSQL + '        IFNULL(CTANCO.NCO_CODCON, CTA_PLANCO) AS CTA_PLANCO, CADFIS.AUTOINCREM AS FISINC, ';
  strSQL := strSQL + '        IFNULL(CTANCO.NCO_CODCTA, CTA_CODCTA) AS CODIGO_PLANO_CONTA, ';
  if fCfgDesMva = 'S' then
  begin
    strSQL := strSQL + '        D.CTP_CODEMP AS CDE_CODEMP, ';
    strSQL := strSQL + '        ED.EMP_NOMEMP AS CDE_NOMEMP, ';
    strSQL := strSQL + '        ED.EMP_C_G_C_ AS CDE_C_G_C_, ';
  end ;
  strSQL := strSQL + '        D.AUTOINCREM IS NOT NULL AS IS_CTPDET, ';

  strSQL := strSQL + fRetornaSQLNaurezaOperacao;

  strSQL := strSQL + '        "CADFIS" AS TABELA ';
  strSQL := strSQL + '   FROM CADFIS ';

  strSQL := strSQL + '   LEFT JOIN MOVDET ';
  strSQL := strSQL + '       ON FIS_NUMDOC = DET_NUMDOC ';
  strSQL := strSQL + '       AND FIS_ESPDOC = DET_ESPDOC ';
  strSQL := strSQL + '       AND FIS_CODEMP = DET_CODEMP ';
  strSQL := strSQL + '       AND FIS_TIP_FC = DET_TIP_FC ';
  strSQL := strSQL + '       AND FIS_FORCLI = IFNULL(DET_CODCLI, DET_CODFOR) ';
  strSQL := strSQL + '       AND FIS_ORIDOC = DET_ORIDOC ';
  strSQL := strSQL + '       AND IFNULL(FIS_SERIE_, "") = IFNULL(DET_SERIE_, "") ';

  if FblnUsaCampoNatOpeMovTri then
  begin
    strSQL := strSQL + '   LEFT JOIN MOVTRI ';
    strSQL := strSQL + '       ON MOVDET.AUTOINCREM = MOVTRI.DET_SEQGER ';
  end
  else if FblnUsaCampoNatCfo then
  begin
    strSQL := strSQL + '   LEFT JOIN AUXMOV ';
    strSQL := strSQL + '       ON AUX_SEQGER = MOVDET.DET_SEQGER ';
  end;

  strSQL := strSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI ';

  strSQL := strSQL + '   LEFT JOIN FORNCO ';
  strSQL := strSQL + '       ON FORNCO.NCO_CODFOR = CADFOR.FOR_CODFOR ';
  strSQL := strSQL + '       AND FORNCO.NCO_CODEMP = FIS_CODEMP ';

  strSQL := strSQL + '   LEFT JOIN DUPAGP AGP ON AGP.CTP_NUMDUP = FIS_NUMDOC ';
  strSQL := strSQL + '                       AND AGP.CTP_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '                       AND AGP.CTP_CODFOR = FIS_FORCLI ';
  strSQL := strSQL + '                       AND AGP.CTP_PARCEL = "A" ';

  strSQL := strSQL + '   LEFT JOIN CADPAG P ON P.CTP_NUMDUP = IF(AGP.CTP_NUMAGR IS NULL, FIS_NUMDOC, AGP.CTP_NUMAGR) ';
  strSQL := strSQL + '                     AND P.CTP_CODFOR = FIS_FORCLI ';
  strSQL := strSQL + '                     AND P.CTP_CODEMP = IF(AGP.CTP_NUMAGR IS NULL, FIS_CODEMP, AGP.CTP_EMPAGR) ';
  strSQL := strSQL + '                     AND IFNULL(P.CTP_SERIE_,"") = IFNULL(IF(AGP.CTP_NUMAGR IS NULL, FIS_SERIE_, P.CTP_SERIE_), "") ';
  strSQL := strSQL + '                     AND P.CTP_SEQBAI = 0 ';
  strSQL := strSQL + '                     AND P.CTP_PARCEL = "A" ';

  strSQL := strSQL + '   LEFT JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ';
  strSQL := strSQL + '                         P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ';
  strSQL := strSQL + '                       ((P.CTP_SERIE_ = D.CTP_SERIE_) OR ';
  strSQL := strSQL + '                       (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = "")))) ';
  strSQL := strSQL + '   LEFT JOIN CADEMP ED ON D.CTP_CODEMP = ED.EMP_CODEMP  ';
  strSQL := strSQL + '   LEFT JOIN CADCTA ON CTA_CODCTA = IF(D.CTP_CODCTA IS NULL, IF(AGP.AUTOINCREM IS NULL, P.CTP_CODCTA, AGP.CTP_CODCTA), D.CTP_CODCTA) ';

  strSQL := strSQL + '   LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = IF(D.CTP_CODCTA IS NULL, IF(AGP.AUTOINCREM IS NULL, P.CTP_CODCTA, AGP.CTP_CODCTA), D.CTP_CODCTA) ';
  strSQL := strSQL + '                   AND CTANCO.NCO_CODEMP = ' + iif(fCfgDesMva = 'S', 'IF(D.CTP_CODEMP IS NULL, FIS_CODEMP, D.CTP_CODEMP)', 'FIS_CODEMP') ;

  strSQL := strSQL + '  WHERE FIS_TIP_FC = "F" ';
  strSQL := strSQL + '    AND RIGHT(FIS_CLFSC1, 3) IN (' + fListaCfopsOutrasEntradas + ') ';

  strSQL := strSQL + '    AND IFNULL(FIS_NFCOMP, "N") <> "S" ';

  If Not fEmptyStr(recParCon.strCodEmp) Then
    strSQL := strSQL + '  AND FIS_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';


  strSQL := strSQL + TTrataIncDocContabil
                       .New
                       .fColunaIncDoc('CADFIS.AUTOINCREM')
                       .fIncDoc(recParCon.strIncDoc)
                       .fArrIncDoc(recParCon.arrIncDoc)
                       .fQuerySql(Nil)
                       .fExecute ;

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(strSQL);

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConOUE.fDeletaLanCon: Boolean;
begin
  if fPodeDeletar then
    Result := Generico.fDeletaLanCon
  else
    Result := True;
end;

function TLanConOUE.fEfetuaLancamentos: Boolean;
  Var
    strPlaCta : String;
    strCodEve : String;
    strEveNec: string;
    strNatCfo: String ;
begin
  pgbProgresso.Properties.Max := qryDados.RecordCount;
  strEveNec := fRetornaEventosNaoExportar;
  strIncDoc := '' ;
  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    Application.ProcessMessages;

    if (not fEmptyStr(strEveNec)) and (not qryDados.FieldByName('CODEVE').IsNull)
       and (Pos(qryDados.FieldByName('CODEVE').AsString, strEveNec) > 0) then
    begin
      Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Evento com o código '+qryDados.FieldByName('CODEVE').AsString+' configurado para não ser exportado na CFG_EVENEC!'), qryDados);
      qryDados.Next;
      Continue;
    end;

    fltVlrCon := qryDados.FieldByName('VLRCON_TOT').AsFloat;
    fltValIcm := qryDados.FieldByName('VALICM_TOT').AsFloat;
    fltValIpi := qryDados.FieldByName('VALIPI_TOT').AsFloat;
    fltDesAce := qryDados.FieldByName('DESACE_TOT').AsFloat;
    fltValRet := qryDados.FieldByName('VALRET_TOT').AsFloat;
    fltValPis := qryDados.FieldByName('VALPIS_TOT').AsFloat;
    fltValCof := qryDados.FieldByName('VALCOF_TOT').AsFloat;
    fltLiqEnt := qryDados.FieldByName('LIQENT_TOT').AsFloat;
    fltReIrrf := qryDados.FieldByName('REIRRF_TOT').AsFloat;
    fltRInssp := qryDados.FieldByName('RINSSP_TOT').AsFloat;
    fltReCssl := qryDados.FieldByName('RECSSL_TOT').AsFloat;
    fltReInss := qryDados.FieldByName('REINSS_TOT').AsFloat;
    fltValIss := qryDados.FieldByName('VALISS_TOT').AsFloat;

    if qryDados.FieldByName('FISINC').AsString+qryDados.FieldByName('CLAFIS').AsString <> strIncDoc then
    begin
      strIncDoc := qryDados.FieldByName('FISINC').AsString+qryDados.FieldByName('CLAFIS').AsString;
      pZerarValores;
    end;
    pSomarValores;

    qryDados.Next;
    if (qryDados.FieldByName('FISINC').AsString+qryDados.FieldByName('CLAFIS').AsString <> strIncDoc) or (qryDados.Eof) then
    begin
      if not qryDados.Eof then
        qryDados.Prior;

      fltDifVlrCon := fFormataFloat(fltVlrCon - fltRatVlrCon, 2) ;
      fltDifValIcm := fFormataFloat(fltValIcm - fltRatValIcm, 2) ;
      fltDifValIpi := fFormataFloat(fltValIpi - fltRatValIpi, 2) ;
      fltDifDesAce := fFormataFloat(fltDesAce - fltRatDesAce, 2) ;
      fltDifValRet := fFormataFloat(fltValRet - fltRatValRet, 2) ;
      fltDifValPis := fFormataFloat(fltValPis - fltRatValPis, 2) ;
      fltDifValCof := fFormataFloat(fltValCof - fltRatValCof, 2) ;
      fltDifLiqEnt := fFormataFloat(fltLiqEnt - fltRatLiqEnt, 2) ;
      fltDifReIrrf := fFormataFloat(fltReIrrf - fltRatReIrrf, 2) ;
      fltDifRInssp := fFormataFloat(fltRInssp - fltRatRInssp, 2) ;
      fltDifReCssl := fFormataFloat(fltReCssl - fltRatReCssl, 2) ;
      fltDifReInss := fFormataFloat(fltReInss - fltRatReInss, 2) ;
      fltDifValIss := fFormataFloat(fltValIss - fltRatValIss, 2) ;

      if (fltDifVlrCon <> 0) or
         (fltDifValIcm <> 0) or
         (fltDifValIpi <> 0) or
         (fltDifDesAce <> 0) or
         (fltDifValRet <> 0) or
         (fltDifValPis <> 0) or
         (fltDifValCof <> 0) or
         (fltDifLiqEnt <> 0) or
         (fltDifReIrrf <> 0) or
         (fltDifRInssp <> 0) or
         (fltDifReCssl <> 0) or
         (fltDifReInss <> 0) or
         (fltDifValIss <> 0) then
      begin
        pAlterarValores;
      end;
    end
    else
    begin
      qryDados.Prior;
    end;

    strPlaCta := qryDados.FieldByName('CTA_PLANCO').AsString;
    strCodEve := qryDados.FieldByName('CODEVE').AsString;
    strNatCfo := qryDados.FieldByName('NATCFO').AsString;

    Generico.pGravaLancto('VLRCON', 'Vr.Contábil', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALICM', 'Vr.ICMS', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALIPI', 'Vr.IPI', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('DESACE', 'Vr.Desp.Acessórias', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALRET', 'Vr.Sub.Tributária', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALPIS', 'Vr.PIS', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALCOF', 'Vr.COFINS', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('REIRRF', 'Vr.IRPJ', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('RINSSP', DES_VALOR_INSS_PATRONAL, strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('RECSSL', 'Vr.CSLL', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('REINSS', 'Vr.INSS', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALISS', 'Vr.ISS', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('LIQENT', DES_VALOR_LIQUIDO_ENTRADA, strPlaCta, '', strCodEve, '', '', strNatCfo);

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConOUE.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConOUE.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConOUE.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConOUE.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Outras Entradas Concluído!', ['&OK']);
end;

procedure TLanConOUE.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConOUE.pVerificaSeLancouLanCon;
begin
  generico.pVerificaSeLancouLanCon;
end;

function TLanConOUE.fPodeDeletar: boolean;
begin
  result := False ;
  if not recParCon.blnModoRobo then
  begin
    exit ;
  end;

  if recParCon.intModoLancto <> MODO_ROBO_1_INCLUSAO then
  begin
    exit;
  end;
  result := True ;
end;

function TLanConOUE.fRetornaSQLNaurezaOperacao: string;
begin
  if FblnUsaCampoNatOpeMovTri then
    result := '      IFNULL(MOVTRI.DET_NATOPE,"") AS NATCFO, '
  else if FblnUsaCampoNatCfo then
    result := '        IFNULL(AUX_NATCFO, "") AS NATCFO, '
  else
    result := '        CAST("" AS CHAR(20)) AS NATCFO, ';
end;

procedure TLanConOUE.pZerarValores;
begin
  fltRatVlrCon := 0 ;
  fltRatValIcm := 0 ;
  fltRatValIpi := 0 ;
  fltRatDesAce := 0 ;
  fltRatValRet := 0 ;
  fltRatValPis := 0 ;
  fltRatValCof := 0 ;
  fltRatLiqEnt := 0 ;
  fltRatReIrrf := 0 ;
  fltRatRInssp := 0 ;
  fltRatReCssl := 0 ;
  fltRatReInss := 0 ;
  fltRatValIss := 0 ;

  fltDifVlrCon := 0 ;
  fltDifValIcm := 0 ;
  fltDifValIpi := 0 ;
  fltDifDesAce := 0 ;
  fltDifValRet := 0 ;
  fltDifValPis := 0 ;
  fltDifValCof := 0 ;
  fltDifLiqEnt := 0 ;
  fltDifReIrrf := 0 ;
  fltDifRInssp := 0 ;
  fltDifReCssl := 0 ;
  fltDifReInss := 0 ;
  fltDifValIss := 0 ;
end;

procedure TLanConOUE.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConOUE.pSomarValores;
begin
  fltRatVlrCon := fltRatVlrCon + qryDados.FieldByName('VLRCON').AsFloat;
  fltRatValIcm := fltRatValIcm + qryDados.FieldByName('VALICM').AsFloat;
  fltRatValPis := fltRatValPis + qryDados.FieldByName('VALPIS').AsFloat;
  fltRatValCof := fltRatValCof + qryDados.FieldByName('VALCOF').AsFloat;
  fltRatReInss := fltRatReInss + qryDados.FieldByName('REINSS').AsFloat;
  fltRatReCssl := fltRatRecSsl + qryDados.FieldByName('RECSSL').AsFloat;
  fltRatReIrrf := fltRatReIrrf + qryDados.FieldByName('REIRRF').AsFloat;
  fltRatRInssp := fltRatRInssp + qryDados.FieldByName('RINSSP').AsFloat;
  fltRatValIss := fltRatValIss + qryDados.FieldByName('VALISS').AsFloat;
  fltRatLiqEnt := fltRatLiqEnt + qryDados.FieldByName('LIQENT').AsFloat;

  fltRatValIpi := fltRatValIpi + qryDados.FieldByName('VALIPI').AsFloat;
  fltRatDesAce := fltRatDesAce + qryDados.FieldByName('DESACE').AsFloat;
  fltRatValRet := fltRatValRet + qryDados.FieldByName('VALRET').AsFloat;
end;

procedure TLanConOUE.pAlterarValores;
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
  if fltDifReInss <> 0 then
    qryDados.FieldByName('REINSS').AsFloat := qryDados.FieldByName('REINSS').AsFloat + fltDifReInss ;
  if fltDifRecSsl <> 0 then
    qryDados.FieldByName('RECSSL').AsFloat := qryDados.FieldByName('RECSSL').AsFloat + fltDifRecSsl ;
  if fltDifReIrrf <> 0 then
    qryDados.FieldByName('REIRRF').AsFloat := qryDados.FieldByName('REIRRF').AsFloat + fltDifReIrrf ;
  if fltDifRInssp <> 0 then
    qryDados.FieldByName('RINSSP').AsFloat := qryDados.FieldByName('RINSSP').AsFloat + fltDifRInssp ;
  if fltDifLiqEnt <> 0 then
    qryDados.FieldByName('LIQENT').AsFloat := qryDados.FieldByName('LIQENT').AsFloat + fltDifLiqEnt ;
  if fltDifValIss <> 0 then
    qryDados.FieldByName('VALISS').AsFloat := qryDados.FieldByName('VALISS').AsFloat + fltDifValIss ;
  if fltDifValIpi <> 0 then
    qryDados.FieldByName('VALIPI').AsFloat := qryDados.FieldByName('VALIPI').AsFloat + fltDifValIpi ;
  if fltDifDesAce <> 0 then
    qryDados.FieldByName('DESACE').AsFloat := qryDados.FieldByName('DESACE').AsFloat + fltDifDesAce ;
  if fltDifValRet <> 0 then
    qryDados.FieldByName('VALRET').AsFloat := qryDados.FieldByName('VALRET').AsFloat + fltDifValRet ;
  qryDados.Post;
end;

end.
