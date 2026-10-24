unit Contabilidade.Classes.TLanConComplementoEntrada;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB, UniClientDataSet,
     Contabilidade.Interfaces;

type
  TLanConComplementoEntrada = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    FCampoDupAgp_CodEve_Existe : Boolean;
    FstrCentroCustoDefault: String ;
    function pNaoExportar(strEveNec : string) : boolean ;
    function fPodeDeletar: boolean;
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

{ TLanConComplementoEntrada }

constructor TLanConComplementoEntrada.Create(strTipLan: String;
  pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Generico.FblnMostraWarningGeracaoMovimento := False;
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  FCampoDupAgp_CodEve_Existe := fCampoExiste('DUPAGP', 'CTP_CODEVE');
  FstrCentroCustoDefault := fCentroCustoDefaultCntDespRecCus ;
end;

destructor TLanConComplementoEntrada.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  inherited;
end;

function TLanConComplementoEntrada.fCarregaDados: Boolean;
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT FIS_CLFSC1 AS CLAFIS, FIS_DTAENT AS DTAENT, FIS_NUMDOC AS NUMDOC, ';
  strSQL := strSQL + '        FIS_ESPDOC AS ESPDOC, FIS_CODEMP AS CODEMP, FIS_NATOPE AS NATCFO, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, (IFNULL(FIS_VLCON1,0)), ROUND((IFNULL(FIS_VLCON1,0))*D.CTP_FATCAL,2)) AS VLRCON, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, (IFNULL(FIS_VLRIC1,0)), ROUND((IFNULL(FIS_VLRIC1,0))*D.CTP_FATCAL,2)) AS VALICM, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, (IFNULL(FIS_VLRIP1,0)), ROUND((IFNULL(FIS_VLRIP1,0))*D.CTP_FATCAL,2)) AS VALIPI, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_TOTPIS, ROUND(FIS_TOTPIS*D.CTP_FATCAL,2)) AS VALPIS, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_TOTCOF, ROUND(FIS_TOTCOF*D.CTP_FATCAL,2)) AS VALCOF, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_VALISS, ROUND(FIS_VALISS*D.CTP_FATCAL,2)) AS VALISS, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_RECSSL, ROUND(FIS_RECSSL*D.CTP_FATCAL,2)) AS RECSSL, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_REIRRF, ROUND(FIS_REIRRF*D.CTP_FATCAL,2)) AS REIRRF, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, IFNULL(' + fRetornaCampoInssPatronalCadfis + ',0), ROUND(IFNULL(' + fRetornaCampoInssPatronalCadfis + ',0) * D.CTP_FATCAL,2)) AS RINSSP, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_REINSS, ROUND(FIS_REINSS*D.CTP_FATCAL,2)) AS REINSS, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, FIS_RETID1, ROUND(FIS_RETID1*D.CTP_FATCAL,2)) AS VLICSB, ';
  strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, ' + fValorLiquidoEntradaLivro + ', ROUND(' + fValorLiquidoEntradaLivro + '*D.CTP_FATCAL,2)) AS LIQENT, ';

  if (FCampoDupAgp_CodEve_Existe) then
    strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, IF(P.CTP_CODEVE IS NULL, DUPAGP.CTP_CODEVE, P.CTP_CODEVE), D.CTP_CODEVE) AS CODEVE, '
  else
    strSQL := strSQL + '        IF(D.CTP_FATCAL IS NULL, P.CTP_CODEVE, D.CTP_CODEVE) AS CODEVE, ';

  strSQL := strSQL + '        IF(FIS_TIP_FC = "C", CLI_NOMCLI, FOR_NOMFOR) AS NOME, FIS_SERIE_, ';
  strSQL := strSQL + '        IF(FIS_TIP_FC = "C", CLI_C_G_C_, FOR_C_G_C_) AS CNPJ, FIS_FORCLI, ';
  strSQL := strSQL + '        FIS_TIP_FC AS TIPO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IF(FIS_TIP_FC = "C", IFNULL(NCO_CODCLI, CLI_CODCLI), IFNULL(NCO_CODFOR, FOR_CODFOR)) AS CODIGO_CLIENTE_FORNECEDOR, ';
  strSQL := strSQL + '        IF(FIS_TIP_FC = "C", IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO), IFNULL(FORNCO.NCO_CODCON, FOR_PLANCO)) AS PLANCO, FIS_TIP_FC, ';
  strSQL := strSQL + '        IFNULL(CTANCO.NCO_CODCON, CTA_PLANCO) AS CTA_PLANCO, CADFIS.AUTOINCREM AS FISINC, "CADFIS" AS TABELA, ';
  if fCfgDesMva = 'S' then
  begin
    strSQL := strSQL + '        D.CTP_CODEMP AS CDE_CODEMP, ';
    strSQL := strSQL + '        ED.EMP_NOMEMP AS CDE_NOMEMP, ';
    strSQL := strSQL + '        ED.EMP_C_G_C_ AS CDE_C_G_C_, ';
  end ;
  strSQL := strSQL + '        D.AUTOINCREM IS NOT NULL AS IS_CTPDET, ';
  strSQL := strSQL + '        IFNULL(CTANCO.NCO_CODCTA, CTA_CODCTA) AS CODIGO_PLANO_CONTA ';
  strSQL := strSQL + '   FROM CADFIS ';
  strSQL := strSQL + '   LEFT JOIN CADCLI ON CLI_CODCLI = FIS_FORCLI ';
  strSQL := strSQL + '   LEFT JOIN CADFOR ON FOR_CODFOR = FIS_FORCLI ';

  strSQL := strSQL + '   LEFT JOIN DUPAGP ON DUPAGP.CTP_NUMDUP = FIS_NUMDOC ';
  strSQL := strSQL + '                   AND DUPAGP.CTP_CODFOR = FIS_FORCLI ';
  strSQL := strSQL + '                   AND DUPAGP.CTP_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '                   AND IFNULL(DUPAGP.CTP_SERIE_,"") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '                   AND DUPAGP.CTP_PARCEL = "A" ';

  strSQL := strSQL + '   LEFT JOIN CADPAG P ON P.CTP_NUMDUP = FIS_NUMDOC ';
  strSQL := strSQL + '                     AND P.CTP_CODFOR = FIS_FORCLI ';
  strSQL := strSQL + '                     AND P.CTP_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '                     AND IFNULL(P.CTP_SERIE_,"") = IFNULL(FIS_SERIE_, "") ';
  strSQL := strSQL + '                     AND P.CTP_SEQBAI = 0 ';
  strSQL := strSQL + '                     AND P.CTP_PARCEL = "A" ';

  strSQL := strSQL + '   LEFT JOIN CTPDET D ON P.CTP_CODFOR = D.CTP_CODFOR AND P.CTP_NUMDUP = D.CTP_NUMDUP AND ';
  strSQL := strSQL + '                         P.CTP_PARCEL = D.CTP_PARCEL AND P.CTP_CODEMP = D.CTP_EMPORI AND ';
  strSQL := strSQL + '                       ((P.CTP_SERIE_ = D.CTP_SERIE_) OR ';
  strSQL := strSQL + '                       (((P.CTP_SERIE_ IS NULL) OR (P.CTP_SERIE_ = "")) AND ((D.CTP_SERIE_ IS NULL) OR (D.CTP_SERIE_ = "")))) ';
  strSQL := strSQL + '   LEFT JOIN CADEMP ED ON D.CTP_CODEMP = ED.EMP_CODEMP  ';
  strSQL := strSQL + '   LEFT JOIN CADCTA ON CTA_CODCTA = IF(D.CTP_CODCTA IS NULL, IF(DUPAGP.AUTOINCREM IS NULL, P.CTP_CODCTA, DUPAGP.CTP_CODCTA), D.CTP_CODCTA) ';

  strSQL := strSQL + '   LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '                   AND CLINCO.NCO_CODEMP = FIS_CODEMP ';
  strSQL := strSQL + '   LEFT JOIN FORNCO ON FORNCO.NCO_CODFOR = FOR_CODFOR ';
  strSQL := strSQL + '                   AND FORNCO.NCO_CODEMP = FIS_CODEMP ';

  strSQL := strSQL + '   LEFT JOIN CTANCO ON CTANCO.NCO_CODCTA = IF(D.CTP_CODCTA IS NULL, IF(DUPAGP.AUTOINCREM IS NULL, P.CTP_CODCTA, DUPAGP.CTP_CODCTA), D.CTP_CODCTA) ';
  strSQL := strSQL + '                   AND CTANCO.NCO_CODEMP = ' + iif(fCfgDesMva = 'S', 'IF(D.CTP_CODEMP IS NULL, FIS_CODEMP, D.CTP_CODEMP)', 'FIS_CODEMP') ;

  strSQL := strSQL + '  WHERE FIS_ENTSAI = "E"  AND FIS_NFCOMP = "S"  ';

  If Not fEmptyStr(recParCon.strCodEmp) Then
    strSQL := strSQL + '  AND FIS_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    strSQL := strSQL + '  AND FIS_DTAENT BETWEEN :DTAINI AND :DTAFIN ';

  strSql := strSql + TTrataIncDocContabil
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

function TLanConComplementoEntrada.fDeletaLanCon: Boolean;
begin
  if fPodeDeletar then
    Result := Generico.fDeletaLanCon
  else
    Result := True;
end;

function TLanConComplementoEntrada.fEfetuaLancamentos: Boolean;
Var
  strPlaCta : String;
  strCodEve : String;
  strEveNec: string;
  strNatCfo: string;
begin
  Result := False ;
  pgbProgresso.Properties.Max := qryDados.RecordCount;
  strEveNec := fRetornaEventosNaoExportar;

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

    strCodEve := TFactoryEventoContabil.New.fConfiguraEvento(qryDados.FieldByName('CODEVE').AsString, 'ENT', qryDados.FieldByName('CLAFIS').AsString).fConsultaEvento(FstrCentroCustoDefault);

    strPlaCta := qryDados.FieldByName('CTA_PLANCO').AsString;

    if fEmptyStr(strPlaCta) then
      strPlaCta := qryDados.FieldByName('PLANCO').AsString;

    strNatCfo := qryDados.FieldByName('NATCFO').AsString;

    Generico.pGravaLancto('VLRCON', 'Vr.Contábil', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALICM', 'Vr.ICMS', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VLICSB', DES_VALOR_ICMS_ST, strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALPIS', 'Vr.PIS', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALCOF', 'Vr.COFINS', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALISS', 'Vr.ISS', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('REINSS', 'Vr.INSS', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('RECSSL', 'Vr.CSLL', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('REIRRF', 'Vr.IRPJ', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('VALIPI', 'Vr.IPI', strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('RINSSP', DES_VALOR_INSS_PATRONAL, strPlaCta, '', strCodEve, '', '', strNatCfo);
    Generico.pGravaLancto('LIQENT', DES_VALOR_LIQUIDO_ENTRADA, strPlaCta, '', strCodEve, '', '', strNatCfo);

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConComplementoEntrada.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConComplementoEntrada.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConComplementoEntrada.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConComplementoEntrada.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Complemento de Entrada Concluído!', ['&OK']);
end;

procedure TLanConComplementoEntrada.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConComplementoEntrada.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

function TLanConComplementoEntrada.pNaoExportar(strEveNec: string): boolean;
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

procedure TLanConComplementoEntrada.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

function TLanConComplementoEntrada.fPodeDeletar: boolean;
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

end.
