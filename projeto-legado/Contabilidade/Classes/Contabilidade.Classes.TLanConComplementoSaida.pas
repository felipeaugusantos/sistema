unit Contabilidade.Classes.TLanConComplementoSaida;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB, UniClientDataSet,
     Contabilidade.Interfaces;

type
  TLanConComplementoSaida = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    FCampoDupAgp_CodEve_Existe : Boolean;
    FcdsNfOriginal: TUniClientDataSet ;
    FUsaCampoNatCfo: Boolean ;
    FstrCentroCustoDefault: String ;
    function pNaoExportar(strEveNec : string) : boolean ;
    function fPodeDeletar():boolean ;
    function fCarregaNfOriginal(): TUniClientDataset ;
    function fRetornaNatCfo:String ;
    function fPreparaSqlUnions(const AintColuna: integer): string ;
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
     Contabilidade.Classes.TEventoContabil, Contabilidade.Classes.TTrataIncDoc,
     System.Generics.Collections;

{ TLanConComplementoSaida }

constructor TLanConComplementoSaida.Create(strTipLan: String;
  pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Generico.FblnMostraWarningGeracaoMovimento := False;
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  FCampoDupAgp_CodEve_Existe := fCampoExiste('DUPAGP', 'CTP_CODEVE');
  FUsaCampoNatCfo := fCampoExiste('AUXMOV', 'AUX_NATCFO');
  FcdsNfOriginal := Nil ;
  FstrCentroCustoDefault := fCentroCustoDefaultCntDespRecCus ;
end;

destructor TLanConComplementoSaida.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  if Assigned(FcdsNfOriginal) then
    FreeAndNil(FcdsNfOriginal);
  inherited;
end;

function TLanConComplementoSaida.fCarregaDados: Boolean;
  Var
    strSQL : String;
    LintCnt : integer;
    LlstComCfop: TList<Integer> ;
begin

  strSQL := '';
  LlstComCfop := fColunasComCfopCadfis(recParCon, 'S') ;
  try
    for LintCnt in LlstComCfop do
    begin
      strSQL := strSQL + ifthen(LlstComCfop.count = 1, '', '(') ;
      strSQL := strSQL + fPreparaSqlUnions(LintCnt) ;
      strSQL := strSQL + ifthen(LlstComCfop.count = 1, '', ')') ;
      if LlstComCfop.count > 1 then
        strSQL := strSQL + iif(LintCnt <> LlstComCfop.Items[LlstComCfop.Count-1], ' UNION ', '') ;
    end ;
  finally
    FreeAndNil(LlstComCfop) ;
  end ;

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(strSQL);

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConComplementoSaida.fCarregaNfOriginal: TUniClientDataset;
var
  LqryOriginal: TUniQuery ;
begin
  Result := Nil ;
  if not FUsaCampoNatCfo then
    exit ;

  LqryOriginal := fCriaQuery() ;
  try
    LqryOriginal.Close ;
    LqryOriginal.SQL.Clear ;
    LqryOriginal.SQL.Add(' SELECT DISTINCT AUXMOV.AUX_NATCFO, MOVDET.DET_CLAFIS, FISCOM.AUTOINCREM ') ;
    LqryOriginal.SQL.Add(' FROM CADFIS FISCOM ') ;
    LqryOriginal.SQL.Add('      INNER JOIN NOTCOM ON FISCOM.AUTOINCREM = NOTCOM.GER_SEQGER ') ;
    LqryOriginal.SQL.Add('      INNER JOIN MOVDET ON NOTCOM.GER_DOCORI = DET_NUMDOC ') ;
    LqryOriginal.SQL.Add('                       AND NOTCOM.GER_ESPORI = DET_ESPDOC ') ;
    LqryOriginal.SQL.Add('                       AND NOTCOM.GER_EMPORI = DET_CODEMP ') ;
    LqryOriginal.SQL.Add('                       AND FISCOM.FIS_TIP_FC = DET_TIP_FC ') ;
    LqryOriginal.SQL.Add('                       AND FISCOM.FIS_FORCLI = IFNULL(DET_CODCLI, DET_CODFOR) ') ;
    LqryOriginal.SQL.Add('                       AND FISCOM.FIS_ORIDOC = DET_ORIDOC ') ;
    LqryOriginal.SQL.Add('                       AND IFNULL(NOTCOM.GER_SERORI,"") = IFNULL(DET_SERIE_,"") ') ;
    LqryOriginal.SQL.Add('      INNER JOIN AUXMOV ON AUX_SEQGER = MOVDET.DET_SEQGER ') ;
    LqryOriginal.SQL.Add(' WHERE TRUE ') ;
    LqryOriginal.SQL.Add('       AND FISCOM.FIS_ENTSAI = "S" ') ;
    LqryOriginal.SQL.Add('       AND FISCOM.FIS_NFCOMP = "S" ') ;

    If Not fEmptyStr(recParCon.strCodEmp) Then
      LqryOriginal.SQL.Add('  AND FISCOM.FIS_CODEMP = :CODEMP ') ;

    if (recParCon.dtaDtaIni > 0) then
      LqryOriginal.SQL.Add('  AND FISCOM.FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ') ;

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('FISCOM.AUTOINCREM')
      .fIncDoc(recParCon.strIncDoc)
      .fArrIncDoc(recParCon.arrIncDoc)
      .fQuerySql(LqryOriginal)
      .fExecute ;

    pSetaParametrosGerLanCon(recParCon, LqryOriginal);

    LqryOriginal.Open ;

    Result := fCriaClientDatset(LqryOriginal) ;
    Result.IndexFieldNames := 'AUTOINCREM;DET_CLAFIS' ;
  finally
    FreeAndNil(LqryOriginal) ;
  end ;
end;

function TLanConComplementoSaida.fDeletaLanCon: Boolean;
begin
  if fPodeDeletar then
    Result := Generico.fDeletaLanCon
  else
    Result := True;
end;

function TLanConComplementoSaida.fEfetuaLancamentos: Boolean;
Var
  strPlaCta : String;
  strCodEve : String;
  strEveNec: string;
  LstrNatCfo: String;
begin
  Result := False;
  pgbProgresso.Properties.Max := qryDados.RecordCount;
  strEveNec := fRetornaEventosNaoExportar;

  FcdsNfOriginal := fCarregaNfOriginal ;

  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    Application.ProcessMessages;

    //if (not fEmptyStr(strEveNec)) and (not qryDados.FieldByName('CODEVE').IsNull)
    //   and (Pos(qryDados.FieldByName('CODEVE').AsString, strEveNec) > 0) then
    //begin
    //  qryDados.Next;
    //  Continue;
    //end;

    if pNaoExportar(strEveNec) then
    begin
      Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Evento com o código '+qryDados.FieldByName('CODEVE').AsString+' configurado para não ser exportado na CFG_EVENEC!'), qryDados);
      qryDados.Next;
      exit ;
    end;

    strCodEve := TFactoryEventoContabil.New.fConfiguraEvento(qryDados.FieldByName('CODEVE').AsString, 'SAI').fConsultaEvento(FstrCentroCustoDefault);

    strPlaCta := qryDados.FieldByName('CTA_PLANCO').AsString;

    if fEmptyStr(strPlaCta) then
      strPlaCta := qryDados.FieldByName('PLANCO').AsString;

    LstrNatCfo := fRetornaNatCfo ;

    Generico.pGravaLancto('VLRCON', 'Vr.Contábil', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('VALICM', 'Vr.ICMS', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('VALPIS', 'Vr.PIS', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('VALCOF', 'Vr.COFINS', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('VALISS', 'Vr.ISS', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('REINSS', 'Vr.INSS', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('RECSSL', 'Vr.CSLL', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('REIRRF', 'Vr.IRPJ', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('VALIPI', 'Vr.IPI', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('LIQENT', DES_VALOR_LIQUIDO_SAIDA, strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    Generico.pGravaLancto('LIQENT', DES_VALOR_LIQUIDO_ENTRADA, strPlaCta, '', strCodEve, '', '', LstrNatCfo); // mantido, caso tenha algum registro da parcon não ajustado
    Generico.pGravaLancto('VALRET', 'Vr.Sub.Tributária', strPlaCta, '', strCodEve, '', '', LstrNatCfo);
    qryDados.Next;
  End;

  Result := True;
end;

function TLanConComplementoSaida.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConComplementoSaida.fPodeDeletar: boolean;
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

function TLanConComplementoSaida.fPreparaSqlUnions(
  const AintColuna: integer): string;
var
  LstrSQL: string ;
begin

  LstrSQL := '';

  LstrSQL := LstrSQL + ' SELECT FIS_CLFSC' + intTostr(AintColuna) + ' AS CLAFIS, FIS_DTAENT AS DTAENT, FIS_NUMDOC AS NUMDOC, ';
  LstrSQL := LstrSQL + '        FIS_ESPDOC AS ESPDOC, FIS_CODEMP AS CODEMP, FIS_NATOPE AS NATCFO, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, (IFNULL(FIS_VLCON' + intTostr(AintColuna) + ',0)), ROUND((IFNULL(FIS_VLCON' + intTostr(AintColuna) + ',0))*D.CTP_FATCAL,2)) AS VLRCON, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, (IFNULL(FIS_VLRIC' + intTostr(AintColuna) + ',0)), ROUND((IFNULL(FIS_VLRIC' + intTostr(AintColuna) + ',0))*D.CTP_FATCAL,2)) AS VALICM, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, (IFNULL(FIS_VLRIP' + intTostr(AintColuna) + ',0)), ROUND((IFNULL(FIS_VLRIP' + intTostr(AintColuna) + ',0))*D.CTP_FATCAL,2)) AS VALIPI, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_TOTPIS, ROUND(FIS_TOTPIS*D.CTP_FATCAL,2)) AS VALPIS, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_TOTCOF, ROUND(FIS_TOTCOF*D.CTP_FATCAL,2)) AS VALCOF, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_VALISS, ROUND(FIS_VALISS*D.CTP_FATCAL,2)) AS VALISS, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_RECSSL, ROUND(FIS_RECSSL*D.CTP_FATCAL,2)) AS RECSSL, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_REIRRF, ROUND(FIS_REIRRF*D.CTP_FATCAL,2)) AS REIRRF, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_REINSS, ROUND(FIS_REINSS*D.CTP_FATCAL,2)) AS REINSS, ';
  LstrSQL := LstrSQL + '        IF(D.CTP_FATCAL IS NULL, ' + fValorLiquidoEntradaLivro(AintColuna, True, True) + ', ROUND(' + fValorLiquidoEntradaLivro(AintColuna, True, True) + '*D.CTP_FATCAL,2)) AS LIQENT, ';

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
  if fCfgDesMva = 'S' then
  begin
    LstrSQL := LstrSQL + '        D.CTP_CODEMP AS CDE_CODEMP, ';
    LstrSQL := LstrSQL + '        ED.EMP_NOMEMP AS CDE_NOMEMP, ';
    LstrSQL := LstrSQL + '        ED.EMP_C_G_C_ AS CDE_C_G_C_, ';
  end ;
  LstrSQL := LstrSQL + '        D.AUTOINCREM IS NOT NULL AS IS_CTPDET, ';
  LstrSQL := LstrSQL + '        IFNULL(CTANCO.NCO_CODCTA, CTA_CODCTA) AS CODIGO_PLANO_CONTA, ';
  LstrSQL := LstrSQL + '        FIS_RETID' + intTostr(AintColuna) + ' AS VALRET ';
  LstrSQL := LstrSQL + '   FROM CADFIS ';
  LstrSQL := LstrSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI ';
  LstrSQL := LstrSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI ';

  LstrSQL := LstrSQL + '   LEFT JOIN DUPAGP ON DUPAGP.CTP_NUMDUP = FIS_NUMDOC ';
  LstrSQL := LstrSQL + '                   AND DUPAGP.CTP_CODFOR = FIS_FORCLI ';
  LstrSQL := LstrSQL + '                   AND DUPAGP.CTP_CODEMP = FIS_CODEMP ';
  LstrSQL := LstrSQL + '                   AND IFNULL(DUPAGP.CTP_SERIE_,"") = IFNULL(FIS_SERIE_, "") ';
  LstrSQL := LstrSQL + '                   AND DUPAGP.CTP_PARCEL = "A" ';

  LstrSQL := LstrSQL + '   LEFT JOIN CADPAG P ON P.CTP_NUMDUP = FIS_NUMDOC ';
  LstrSQL := LstrSQL + '                     AND P.CTP_CODFOR = FIS_FORCLI ';
  LstrSQL := LstrSQL + '                     AND P.CTP_CODEMP = FIS_CODEMP ';
  LstrSQL := LstrSQL + '                     AND IFNULL(P.CTP_SERIE_,"") = IFNULL(FIS_SERIE_, "") ';
  LstrSQL := LstrSQL + '                     AND P.CTP_SEQBAI = 0 ';
  LstrSQL := LstrSQL + '                     AND P.CTP_PARCEL = "A" ';

  LstrSQL := LstrSQL + '   LEFT JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ';
  LstrSQL := LstrSQL + '                         P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ';
  LstrSQL := LstrSQL + '                       ((P.CTP_SERIE_ = D.CTP_SERIE_) OR ';
  LstrSQL := LstrSQL + '                       (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = "")))) ';
  LstrSQL := LstrSQL + '   LEFT JOIN CADEMP ED ON D.CTP_CODEMP = ED.EMP_CODEMP  ';
  LstrSQL := LstrSQL + '   LEFT JOIN CADCTA ON CTA_CODCTA = IF(D.CTP_CODCTA IS NULL, IF(P.CTP_CODCTA IS NULL, DUPAGP.CTP_CODCTA, P.CTP_CODCTA), D.CTP_CODCTA) ';

  LstrSQL := LstrSQL + '   LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  LstrSQL := LstrSQL + '                   AND CLINCO.NCO_CODEMP = FIS_CODEMP ';
  LstrSQL := LstrSQL + '   LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR ';
  LstrSQL := LstrSQL + '                   AND FORNCO.NCO_CODEMP = FIS_CODEMP ';

  LstrSQL := LstrSQL + '   LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = IF(D.CTP_CODCTA IS NULL, IF(P.CTP_CODCTA IS NULL, DUPAGP.CTP_CODCTA, P.CTP_CODCTA), D.CTP_CODCTA) ';
  LstrSQL := LstrSQL + '                   AND CTANCO.NCO_CODEMP = ' + iif(fCfgDesMva = 'S', 'IF(D.CTP_CODEMP IS NULL, FIS_CODEMP, D.CTP_CODEMP)', 'FIS_CODEMP') ;

  LstrSQL := LstrSQL + '  WHERE FIS_ENTSAI = "S"  AND FIS_NFCOMP = "S"  ';
  LstrSQL := LstrSQL + '    AND UPPER(IFNULL(FIS_HISTOR, "")) NOT REGEXP "CANCELAD|INUTILIZAD|DENEGAD" ';

  If Not fEmptyStr(recParCon.strCodEmp) Then
    LstrSQL := LstrSQL + '  AND FIS_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    LstrSQL := LstrSQL + '  AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  LstrSQL := LstrSQL + TTrataIncDocContabil
                      .New
                      .fColunaIncDoc('CADFIS.AUTOINCREM')
                      .fIncDoc(recParCon.strIncDoc)
                      .fArrIncDoc(recParCon.arrIncDoc)
                      .fQuerySql(Nil)
                      .fExecute ;

  LstrSQL := fPreparaSqlMarketPlace(LstrSQL) ;
  Result := LstrSQL ;
end;

function TLanConComplementoSaida.fRetornaNatCfo: String;
begin
  result := qryDados.FieldByName('NATCFO').AsString ;

  if not Assigned(FcdsNfOriginal) then
    Exit ;

  if FcdsNfOriginal.FindKey([qryDados.FieldByName('FISINC').AsString, qryDados.FieldByName('CLAFIS').AsString]) then
    result := FcdsNfOriginal.FieldByName('AUX_NATCFO').AsString ;
end;

function TLanConComplementoSaida.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConComplementoSaida.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConComplementoSaida.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Complemento de Saida Concluído!', ['&OK']);
end;

function TLanConComplementoSaida.pNaoExportar(strEveNec: string): boolean;
begin
  result := False ;
  if fEmptyStr(strEveNec) then
  begin
    exit ;
  end;

  if qryDados.FieldByName('CODEVE').IsNull then
  begin
    exit ;
  end;

  if Pos(qryDados.FieldByName('CODEVE').AsString, strEveNec) = 0 then
  begin
    exit ;
  end;

  result := True ;
end;

procedure TLanConComplementoSaida.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConComplementoSaida.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConComplementoSaida.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

end.
