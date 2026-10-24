unit Contabilidade.Classes.TLanConServicoSaida;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB, UniClientDataSet,
     Contabilidade.Interfaces;

type
  TLanConServicoSaida = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    FstrCentroCustoDefault: String ;
    FblnFIS_VRECOF: Boolean ;
    FblnFIS_VREPIS: Boolean ;
    FColunasValorContabil: TSetColunasValorLiquidoContabil ;
    function fPreparaSqlUnions(const AintColuna: integer): string ;
    function fPreparaSqlPlanoContas(const AstrSql: String): String ;
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

{ TLanConServicoSaida }

constructor TLanConServicoSaida.Create(strTipLan: String;
  pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Generico.FblnMostraWarningGeracaoMovimento := False;
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  FstrCentroCustoDefault := fCentroCustoDefaultCntDespRecCus ;
  FblnFIS_VRECOF := fCampoExiste('CADFIS', 'FIS_VRECOF') ;
  FblnFIS_VREPIS := fCampoExiste('CADFIS', 'FIS_VREPIS') ;
  FColunasValorContabil := [Low(TColunasValorLiquidoContabil)..High(TColunasValorLiquidoContabil)];
  pVerificaColunasExitemValorContabil(FColunasValorContabil) ;
end;

destructor TLanConServicoSaida.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConServicoSaida.fCarregaDados: Boolean;
  Var
    strSQL : String;
    LintCnt : integer;
    LlstComCfopServico: TList<Integer> ;
begin
  strSQL := '';
  LlstComCfopServico := fColunasComCfopServico(recParCon, 'S') ;
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

  strSQL := fPreparaSqlPlanoContas(strSQL) ;

  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(strSQL);

  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConServicoSaida.fDeletaLanCon: Boolean;
begin
  Result := True;
end;

function TLanConServicoSaida.fEfetuaLancamentos: Boolean;
  Var
    strPlaCta : String;
    strCodEve : String;
    strEveNec: string;
    strNatCfo: string;
begin
  pgbProgresso.Properties.Max := qryDados.RecordCount;
  strEveNec := fRetornaEventosNaoExportar;

  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    Application.ProcessMessages;

    strCodEve := '';
    If (qryDados.FieldByName('FIS_TIP_FC').AsString = 'F') Then
      strPlaCta := Generico.fGetCodCta(qryDados.FieldByName('NUMDOC').AsString,
                                       qryDados.FieldByName('CODEMP').AsString,
                                       qryDados.FieldByName('FIS_FORCLI').AsString,
                                       qryDados.FieldByName('FIS_SERIE_').AsString,
                                       strCodEve)
    Else
    begin
      strPlaCta := '';
      if Assigned(qryDados.FindField('CTA_PLANCO')) then
        strPlaCta := qryDados.FieldByName('CTA_PLANCO').AsString ;
    end ;

    if (not fEmptyStr(strEveNec)) and (not fEmptyStr(strCodEve))
       and (Pos(strCodEve, strEveNec) > 0) then
    begin
      Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Evento com o código '+strCodEve+' configurado para não ser exportado na CFG_EVENEC!'), qryDados);
      qryDados.Next; // fazer um teste onde o EOF vai dar um next
      Continue;
    end;

    strCodEve := TFactoryEventoContabil.New.fConfiguraEvento(strCodEve, 'SAI').fConsultaEvento(FstrCentroCustoDefault);
    strNatCfo :=  qryDados.FieldByName('NATCFO').AsString;

    Generico.pGravaLancto('VLRCON', 'Vr.Contábil', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALICM', 'Vr.ICMS', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALPIS', 'Vr.PIS', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALCOF', 'Vr.COFINS', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALISS', 'Vr.ISS', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('REINSS', 'Vr.INSS', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('RECSSL', 'Vr.CSLL', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('REIRRF', 'Vr.IRPJ', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('LIQENT', DES_VALOR_LIQUIDO_SAIDA, strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('LIQENT', DES_VALOR_LIQUIDO_ENTRADA, strPlaCta, '', strCodEve, '', '', strNatCfo); // mantido, caso tenha algum registro da parcon não ajustado
    Generico.pGravaLancto('LIQCON', DES_VALOR_LIQUIDO_CONTABIL, strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALIRF', DES_VALOR_RET_IRRF, strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VREPIS', DES_VALOR_RETENCAO_PIS, strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VRECOF', DES_VALOR_RETENCAO_COFINS, strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VREISS', DES_VALOR_RETENCAO_ISS, strPlaCta, '', strCodEve, '', '', strNatCfo);
    qryDados.Next;
  End;

  Result := True;
end;

function TLanConServicoSaida.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConServicoSaida.fPreparaSqlPlanoContas(
  const AstrSql: String): String;
begin
  result := AstrSql ;
  if (fInformaPlanoContasFaturamento = 'N') or (fAtivaPlanoContasSAI = 'N') then
    Exit ;

  result := '' ;
  result := result + ' SELECT ';
  result := result + '   TMP.CLAFIS, ';
  result := result + '   TMP.NATCFO, ';
  result := result + '   TMP.DTAENT, ';
  result := result + '   TMP.NUMDOC, ';
  result := result + '   TMP.ESPDOC, ';
  result := result + '   TMP.CODEMP, ';
  result := result + '   TMP.VLRCON, ';
  result := result + '   TMP.VALICM, ';
  result := result + '   TMP.VALPIS, ';
  result := result + '   TMP.VALCOF, ';
  result := result + '   TMP.VALISS, ';
  result := result + '   TMP.RECSSL, ';
  result := result + '   TMP.REIRRF, ';
  result := result + '   TMP.REINSS, ';
  result := result + '   TMP.NOME, ';
  result := result + '   TMP.FIS_SERIE_, ';
  result := result + '   TMP.CNPJ, ';
  result := result + '   TMP.FIS_FORCLI, ';
  result := result + '   TMP.TIPO_CLIENTE_FORNECEDOR, ';
  result := result + '   TMP.CODIGO_CLIENTE_FORNECEDOR, ';
  result := result + '   TMP.PLANCO, ';
  result := result + '   TMP.FIS_TIP_FC, ';
  result := result + '   TMP.FISINC, ';
  result := result + '   TMP.NOMEMP, ';
  result := result + '   TMP.DTAREC, ';
  result := result + '   TMP.TABELA, ';
  if fCfgMktPla = 'S' then
    result := result + '   TMP.CODIGO_MARKETPLACE, ' ;
  result := result + '   TMP.LIQENT, ';
  result := result + '   TMP.LIQCON, ';
  result := result + '   TMP.VALIRF, ';
  result := result + '   TMP.VREPIS, ';
  result := result + '   TMP.VRECOF, ';
  result := result + '   TMP.VREISS, ';
  result := result + '   IFNULL(CTANCO_R.NCO_CODCON, CADCTA_R.CTA_PLANCO) AS CTA_PLANCO, ' ;
  result := result + '   IFNULL(CTANCO_R.NCO_CODCTA, CADCTA_R.CTA_CODCTA) AS CODIGO_PLANO_CONTA ' ;
  result := result + ' FROM ( ' ;
  result := result + AstrSql ;
  result := result + ' ) AS  TMP ' ;
  result := result + fMontaJoinSaiPlanoContas([jspcReceber]) ;

end;

function TLanConServicoSaida.fPreparaSqlUnions(
  const AintColuna: integer): string;
var
  LstrSQL: string ;
  LblnColPis: Boolean ;
  LblnColCofins: Boolean ;
begin

  LblnColPis    := fCampoExiste('CADFIS', 'FIS_VREPIS'); ;
  LblnColCofins := fCampoExiste('CADFIS', 'FIS_VRECOF'); ;

  LstrSQL := '';
  LstrSQL := LstrSQL + ' SELECT FIS_CLFSC'+ intTostr(AintColuna) +' AS CLAFIS, FIS_NATOPE AS NATCFO, FIS_DTAENT AS DTAENT, FIS_NUMDOC AS NUMDOC, ';
  LstrSQL := LstrSQL + '        FIS_ESPDOC AS ESPDOC, FIS_CODEMP AS CODEMP, FIS_VLCON'+ intTostr(AintColuna) +' AS VLRCON, ';
  LstrSQL := LstrSQL + '        FIS_VLRIC'+ intTostr(AintColuna) +' AS VALICM, FIS_TOTPIS AS VALPIS, FIS_TOTCOF AS VALCOF, ';
  LstrSQL := LstrSQL + '        FIS_VALISS AS VALISS, FIS_RECSSL AS RECSSL, FIS_REIRRF AS REIRRF, ';
  LstrSQL := LstrSQL + '        FIS_REINSS AS REINSS, FIS_SERIE_ AS SERIE_, FIS_ENTSAI AS ENTSAI, FIS_TIP_FC AS TIP_FC, ';
  LstrSQL := LstrSQL + '        IF(FIS_TIP_FC = "C", CLI_NOMCLI, FOR_NOMFOR) AS NOME, FIS_SERIE_, ';
  LstrSQL := LstrSQL + '        IF(FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_) AS CNPJ, FIS_FORCLI, ';
  LstrSQL := LstrSQL + '        FIS_TIP_FC AS TIPO_CLIENTE_FORNECEDOR, ';
  LstrSQL := LstrSQL + '        IF(FIS_TIP_FC = "C", IFNULL(NCO_CODCLI, CLI_CODCLI), IFNULL(NCO_CODFOR, FOR_CODFOR)) AS CODIGO_CLIENTE_FORNECEDOR, ';
  LstrSQL := LstrSQL + '        IF(FIS_TIP_FC = "C", IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO), IFNULL(FORNCO.NCO_CODCON, FOR_PLANCO)) AS PLANCO, ';
  LstrSQL := LstrSQL + '        FIS_TIP_FC, ';
  LstrSQL := LstrSQL + '        CADFIS.AUTOINCREM AS FISINC, ';
  LstrSQL := LstrSQL + '        CADEMP.EMP_NOMEMP AS NOMEMP, CTR_DTAREC AS DTAREC, "CADFIS" AS TABELA, ';
  LstrSQL := LstrSQL + '      ' + fValorLiquidoEntradaLivro(AintColuna) + ' AS LIQENT, ';
  LstrSQL := LstrSQL + '      ' + fValorLiquidoContabilLivro(FColunasValorContabil, AintColuna) + ' AS LIQCON, ';
  LstrSQL := LstrSQL + '        CADFIS.FIS_REIRRF AS VALIRF, ';
  LstrSQL := LstrSQL + '        ' + ifThen(LblnColPis, 'CADFIS.FIS_VREPIS', '0.00') + ' AS VREPIS, ';
  LstrSQL := LstrSQL + '        ' + ifThen(LblnColCofins, 'CADFIS.FIS_VRECOF', '0.00') + ' AS VRECOF, ';
  LstrSQL := LstrSQL + '        CADFIS.FIS_RETISS AS VREISS  ';
  LstrSQL := LstrSQL + '   FROM CADFIS ';
  LstrSQL := LstrSQL + '   LEFT JOIN CADEMP ON CADFIS.FIS_CODEMP = CADEMP.EMP_CODEMP ';
  LstrSQL := LstrSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI ';
  LstrSQL := LstrSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI ';
  LstrSQL := LstrSQL + '   LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  LstrSQL := LstrSQL + '                   AND CLINCO.NCO_CODEMP = FIS_CODEMP ';
  LstrSQL := LstrSQL + '   LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR ';
  LstrSQL := LstrSQL + '                   AND FORNCO.NCO_CODEMP = FIS_CODEMP ';
  LstrSQL := LstrSQL + '   LEFT JOIN CADREC ON CTR_NUMDUP = FIS_NUMDOC ';
  LstrSQL := LstrSQL + '                   AND CTR_ESPDOC = FIS_ESPDOC ';
  LstrSQL := LstrSQL + '                   AND CTR_CODCLI = FIS_FORCLI ';
  LstrSQL := LstrSQL + '                   AND FIS_TIP_FC = "C" ';
  LstrSQL := LstrSQL + '                   AND CTR_CODEMP = FIS_CODEMP ';
  LstrSQL := LstrSQL + '                   AND CTR_SEQBAI = 0 ';
  LstrSQL := LstrSQL + '                   AND CTR_PARCEL = "A" ';
  LstrSQL := LstrSQL + '  WHERE FIS_ENTSAI = "S" AND COALESCE(FIS_NFCOMP, "N") = "N" ';
  LstrSQL := LstrSQL + '    AND RIGHT(FIS_CLFSC'+ intTostr(AintColuna) +', 3) = "933" ';
  LstrSQL := LstrSQL + '    AND UPPER(IFNULL(FIS_HISTOR, "")) NOT REGEXP "CANCELAD|INUTILIZAD|DENEGAD" ';

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

  LstrSQL := fPreparaSqlMarketPlace(LstrSQL) ;

  Result := LstrSQL ;
end;

function TLanConServicoSaida.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConServicoSaida.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConServicoSaida.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Serviços de Saída Concluído!', ['&OK']);
end;

procedure TLanConServicoSaida.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConServicoSaida.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConServicoSaida.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

end.
