unit Contabilidade.Classes.TLanConCHQ;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB, UniClientDataSet,
     Contabilidade.Interfaces;

type
  TLanConCHQ = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    blnParametrizouDevDefinitiva : boolean;
    dtaOco: Variant ;
    FlstControle : TStringList ;
    FblnCHQ_DTABA1_Existe: Boolean ;
    FblnCHQ_DTABA2_Existe: Boolean ;
    FblnCHQ_CTADEP_Existe: Boolean ;
    FblnCHQ_HIST01_Existe: Boolean ;
    FblnCHQ_HIST02_Existe: Boolean ;
    FRepasseParametrizado: Boolean ;
    function fSQLChq(strCampoChave, strTipo: String): String;
    function fRetornaChaveControleDevDef:string;
    function fTipoChequeControle:boolean;
    function fPodeControleChequeDevolvido:boolean;
    function fIgnoraChequeDevolvido:boolean;
    function fRetornaDataOcorrencia: Variant ;
    function fCampoDeposito: String ;
    function fCampoReDeposito: String ;
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

uses Forms, SysUtils, StrUtils, untFuncoesSimples, Contabilidade.Funcoes, System.Variants,
Contabilidade.Classes.TTrataIncDoc;

{ TLanConCHQ }

constructor TLanConCHQ.Create(strTipLan: String; pgbProgresso: TcxProgressBar; recParCon: TParametrosConsulta);
begin
  qryDados := fCriaQuery(Nil);
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  blnParametrizouDevDefinitiva := fCampoTabelaParcon('COUNT(*)', ['CON_TIPLAN', 'CON_DESVAL'], ['CHQ', 'Vr.Cheque Dev.Definitiva']) > 0;
  FlstControle := TStringList.Create ;
  FlstControle.Sorted := True ;
  self.dtaoco := Null ;
  if Length(self.recParCon.arrIncDoc) > 0 then
    self.dtaoco := fRetornaDataOcorrencia ;

  FblnCHQ_DTABA1_Existe := fCampoExiste('CADCHQ', 'CHQ_DTABA1') ;
  FblnCHQ_DTABA2_Existe := fCampoExiste('CADCHQ', 'CHQ_DTABA2') ;
  FblnCHQ_CTADEP_Existe := fCampoExiste('CADCHQ', 'CHQ_CTADEP') ;
  FblnCHQ_HIST01_Existe := fCampoExiste('CADCHQ', 'CHQ_HIST01') ;
  FblnCHQ_HIST02_Existe := fCampoExiste('CADCHQ', 'CHQ_HIST02') ;

  FRepasseParametrizado := FblnCHQ_CTADEP_Existe and
                           (fCampoTabelaParcon('COUNT(*)', ['CON_TIPLAN', 'CON_DESVAL'], ['CHQ', DES_VALOR_CHEQUE_VALOR_REPASSE]) > 0) ;
end;

destructor TLanConCHQ.Destroy;
begin
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  FreeAndNil(FlstControle);
  inherited;
end;

function TLanConCHQ.fSQLChq(strCampoChave, strTipo: String): String;
var
  LstrFiltroAutoInc: String ;
begin
  Result := '';
  Result := Result + ' SELECT "" AS CLAFIS, ' + strCampoChave + ' AS DTAENT, ';
  Result := Result + '        CHQ_NUMCHQ AS NUMDOC, "CHQ" AS ESPDOC, ';
  Result := Result + '        CHQ_CODEMP AS CODEMP, ';
  Result := Result + '        CHQ_VALCHQ AS VALCHQ, IFNULL(PORNCO.NCO_CODCON, CADPOR.POR_PLANCO) AS PLAPOR, ';
  Result := Result + '        IFNULL(PORNCO.NCO_CODPOR, CADPOR.POR_CODPOR) AS CODIGO_PORTADOR, ';
  if (FblnCHQ_HIST01_Existe and FblnCHQ_HIST02_Existe) then
    Result := Result + '   CONCAT( COALESCE(CHQ_HIST01,""), IF(CHQ_HIST02 IS NULL, "", " "), COALESCE(CHQ_HIST02,"") ) AS HISBAI, '
  else
  begin
    if FblnCHQ_HIST01_Existe then
      Result := Result + '    CHQ_HIST01 AS HISBAI, '
    else if FblnCHQ_HIST02_Existe then
      Result := Result + '    CHQ_HIST02 AS HISBAI, '
    else
      Result := Result + '    "" AS HISBAI, '
  end;

  if FRepasseParametrizado and (strTipo = 'REP') then
  begin
    Result := Result + '        IFNULL(PORNCO_REPASSE_CREDITO.NCO_CODCON, CADPOR_REPASSE_CREDITO.POR_PLANCO) AS PLAPOR_REPASSE_CREDITO, ';
    Result := Result + '        IFNULL(PORNCO_REPASSE_CREDITO.NCO_CODPOR, CADPOR_REPASSE_CREDITO.POR_CODPOR) AS CODIGO_PORTADOR_REPASSE_CREDITO, ';
    Result := Result + '        IFNULL(PORNCO_REPASSE_DEBITO.NCO_CODCON, CADPOR_REPASSE_DEBITO.POR_PLANCO) AS PLAPOR_REPASSE_DEBITO, ';
    Result := Result + '        IFNULL(PORNCO_REPASSE_DEBITO.NCO_CODPOR, CADPOR_REPASSE_DEBITO.POR_CODPOR) AS CODIGO_PORTADOR_REPASSE_DEBITO, ';
  end
  else
  begin
    Result := Result + '        CAST(NULL AS CHAR(1)) AS PLAPOR_REPASSE_CREDITO, ';
    Result := Result + '        CAST(NULL AS CHAR(1)) AS CODIGO_PORTADOR_REPASSE_CREDITO, ';
    Result := Result + '        CAST(NULL AS CHAR(1)) AS PLAPOR_REPASSE_DEBITO, ';
    Result := Result + '        CAST(NULL AS CHAR(1)) AS CODIGO_PORTADOR_REPASSE_DEBITO, ';
  end ;
  Result := Result + '        CLI_NOMCLI AS NOME, CLI_C_G_C_ AS CNPJ, ';
  Result := Result + '        "C" AS TIPO_CLIENTE_FORNECEDOR, ';
  Result := Result + '        IFNULL(NCO_CODCLI, CLI_CODCLI) AS CODIGO_CLIENTE_FORNECEDOR, ';
  Result := Result + '        IFNULL(CLINCO.NCO_CODCON, CLI_PLANCO) AS PLANCO, "' + strTipo + '" AS TIPCHQ, ';
  Result := Result + '        CADCHQ.AUTOINCREM AS CHQINC, "CADCHQ" AS TABELA, ';
  Result := Result + '        CHQ_DEVDEF AS VER_DEVDEF, ';
  Result := Result + '        CHQ_DTADEV AS VER_DTADEV, ';
  Result := Result + '        CHQ_DTADV2 AS VER_DTADV2, ';
  Result := Result + '        CHQ_DTADP2 AS VER_DTADP2, ';
  Result := Result + '        CADPOR.POR_EXPAUT, ';
  Result := Result + '        CAST(CASE WHEN CHQ_DTACAD=CHQ_DTAVEN THEN "'+FPG_CHEQUE_VISTA+'" ELSE "'+FPG_CHEQUE_PRE+'" END AS CHAR(20)) AS CHQ_FORPGO ';
  Result := Result + '   FROM CADCHQ ';
  Result := Result + '   LEFT JOIN CADCLI ON CLI_CODCLI = CHQ_CODCLI ';
  Result := Result + '   LEFT JOIN CADPOR ON CADPOR.POR_CODPOR = CHQ_CODPOR ';
  Result := Result + '   LEFT JOIN CLINCO ON CLINCO.NCO_CODCLI = CLI_CODCLI ';
  Result := Result + '                   AND CLINCO.NCO_CODEMP = CHQ_CODEMP ';
  Result := Result + '   LEFT JOIN PORNCO ON PORNCO.NCO_CODPOR = CADPOR.POR_CODPOR ';
  Result := Result + '                   AND PORNCO.NCO_CODEMP = CHQ_CODEMP ';
  if FRepasseParametrizado and (strTipo = 'REP') then
  begin
    Result := Result + '   LEFT JOIN CADPOR AS CADPOR_REPASSE_CREDITO ON CADPOR_REPASSE_CREDITO.POR_CODPOR = CHQ_PORCRE ';
    Result := Result + '   LEFT JOIN PORNCO AS PORNCO_REPASSE_CREDITO ON PORNCO_REPASSE_CREDITO.NCO_CODPOR = CADPOR_REPASSE_CREDITO.POR_CODPOR ';
    Result := Result + '                                             AND PORNCO_REPASSE_CREDITO.NCO_CODEMP = CHQ_CODEMP ';

    Result := Result + '   LEFT JOIN CADPOR AS CADPOR_REPASSE_DEBITO ON CADPOR_REPASSE_DEBITO.POR_CODPOR = CHQ_PORDEB ';
    Result := Result + '   LEFT JOIN PORNCO AS PORNCO_REPASSE_DEBITO ON PORNCO_REPASSE_DEBITO.NCO_CODPOR = CADPOR_REPASSE_DEBITO.POR_CODPOR ';
    Result := Result + '                                             AND PORNCO_REPASSE_DEBITO.NCO_CODEMP = CHQ_CODEMP ';
  end ;
  Result := Result + '  WHERE TRUE ';

  LstrFiltroAutoInc := TTrataIncDocContabil
                         .New
                         .fColunaIncDoc('CADCHQ.AUTOINCREM')
                         .fIncDoc(recParCon.strIncDoc)
                         .fArrIncDoc(recParCon.arrIncDoc)
                         .fQuerySql(Nil)
                         .fExecute ;

  if (not fEmptyStr(LstrFiltroAutoInc)) then
    Result := Result + LstrFiltroAutoInc + ' AND ' + strCampoChave + ' IS NOT NULL ';

  If Not fEmptyStr(recParCon.strCodEmp) Then
    Result := Result + '  AND CHQ_CODEMP = :CODEMP ';

  if (recParCon.dtaDtaIni > 0) then
    Result := Result + '    AND ' + strCampoChave + ' BETWEEN :DTAINI AND :DTAFIN ';

  if strTipo = 'CTR' then
    Result := Result + '    AND CHQ_INCCTR = "S" AND CHQ_DUPDEP IS NOT NULL ';

  if (blnParametrizouDevDefinitiva) and (strTipo <> 'CTR') then
  begin
    if (strTipo = 'DEF') then
      Result := Result + '  AND IFNULL(CHQ_DEVDEF,0) = 1 '
    else if (strTipo = 'DEV') then
      Result := Result + ' AND (CHQ_DTADP2 IS NOT NULL OR IFNULL(CHQ_DEVDEF, 0) = 0) ';
  end;

  if FRepasseParametrizado and (strTipo = 'DEP') then
    Result := Result + '  AND IFNULL(CADCHQ.CHQ_CTADEP,"") <> "REPASSE" ' ;

  if FRepasseParametrizado and (strTipo = 'REP') then
    Result := Result + '  AND IFNULL(CADCHQ.CHQ_CTADEP,"") = "REPASSE" ' ;

end;

function TLanConCHQ.fCampoDeposito: String;
begin
  Result := 'CHQ_DTADEP' ;
  if FblnCHQ_DTABA1_Existe then
    Result := 'IFNULL(CHQ_DTABA1, CHQ_DTADEP)' ;
end;

function TLanConCHQ.fCampoReDeposito: String;
begin
  Result := 'CHQ_DTADP2' ;
  if FblnCHQ_DTABA2_Existe then
    Result := 'IFNULL(CHQ_DTABA2, CHQ_DTADP2)' ;
end;

function TLanConCHQ.fCarregaDados: Boolean;
  Var
    strSQL : String;
begin
  strSQL := '';
  strSQL := strSQL + fSQLChq(fCampoDeposito, 'DEP');
  strSQL := strSQL + ' UNION ALL ';
  strSQL := strSQL + fSQLChq(fCampoReDeposito, 'RDE');
  if (blnParametrizouDevDefinitiva) then
  begin
    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + fSQLChq('CHQ_DTADEV', 'DEV');
    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + fSQLChq('CHQ_DTADV2', 'DEF');
  end
  else
  begin
    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + fSQLChq('CHQ_DTADEV', 'DEV');
    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + fSQLChq('CHQ_DTADV2', 'DEV');
  end;
  strSQL := strSQL + ' UNION ALL ';
  strSQL := strSQL + fSQLChq('CHQ_DTATRA', 'CTR');
  if FRepasseParametrizado then
  begin
    strSQL := strSQL + ' UNION ALL ';
    strSQL := strSQL + fSQLChq(fCampoDeposito, 'REP');
  end ;
  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add(strSQL);

  pSetaParametrosGerLanCon(recParCon, qryDados);
  qryDados.Open;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConCHQ.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
end;

function TLanConCHQ.fTipoChequeControle: boolean;
begin
  result := True ;
  if qryDados.FieldByName('TIPCHQ').AsString = 'DEV' then
  begin
    exit ;
  end;
  if qryDados.FieldByName('TIPCHQ').AsString = 'DEF' then
  begin
    exit ;
  end;
  result := False ;
end;

function TLanConCHQ.fEfetuaLancamentos: Boolean;
var
  LstrForPgo: string ;
begin
  pgbProgresso.Properties.Max := qryDados.RecordCount;

  FlstControle.Clear ;
  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    Application.ProcessMessages;

    if fIgnoraChequeDevolvido then
    begin
      qryDados.Next ;
      continue ;
    end;

    if not VarIsNull(self.dtaoco) then
    begin
      if qryDados.FieldByName('DTAENT').AsDateTime > StrToDateTime(self.dtaoco) then
      begin
        qryDados.Next ;
        continue ;
      end;
    end;

    if qryDados.FieldByName('POR_EXPAUT').AsString = 'N' then
    begin
      Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Portador do título com o código '+qryDados.FieldByName('CODIGO_PORTADOR').AsString+', configurado para não exportar [Exportar pelo Autsi]!'), qryDados);
      qryDados.Next;
      Continue;
    end;

    LstrForPgo := qryDados.FieldByName('CHQ_FORPGO').AsString ;

    If (qryDados.FieldByName('TIPCHQ').AsString = 'RDE') Then
      Generico.pGravaLancto('VALCHQ', 'Vr.Cheque Redepositado', '', LstrForPgo)
    Else If (qryDados.FieldByName('TIPCHQ').AsString = 'DEP') Then
      Generico.pGravaLancto('VALCHQ', 'Vr.Cheque Depositado', '', LstrForPgo)
    Else If (qryDados.FieldByName('TIPCHQ').AsString = 'DEV') Then
      Generico.pGravaLancto('VALCHQ', 'Vr.Cheque Devolvido', '', LstrForPgo)
    Else If (qryDados.FieldByName('TIPCHQ').AsString = 'DEF') Then
      Generico.pGravaLancto('VALCHQ', 'Vr.Cheque Dev.Definitiva', '', LstrForPgo)
    Else If (qryDados.FieldByName('TIPCHQ').AsString = 'CTR') Then
      Generico.pGravaLancto('VALCHQ', DES_VALOR_CHEQUE_TRANSF_CTR, '', LstrForPgo)
    Else If (qryDados.FieldByName('TIPCHQ').AsString = 'REP') Then
      Generico.pGravaLancto('VALCHQ', DES_VALOR_CHEQUE_VALOR_REPASSE, '', LstrForPgo) ;

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConCHQ.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConCHQ.fIgnoraChequeDevolvido: boolean;
var
  strControle : string ;
begin
  Result := False ;
  if not fTipoChequeControle then
  begin
    exit ;
  end;

  if not fPodeControleChequeDevolvido then
  begin
    exit ;
  end;

  strControle := fRetornaChaveControleDevDef ;
  if FlstControle.IndexOf(strControle) = -1 then
  begin
    FlstControle.Add(strControle) ;
    exit ;
  end;

  Result := True ;
end;

function TLanConCHQ.fPodeControleChequeDevolvido: boolean;
begin
  result := False ;
  if qryDados.FieldByName('VER_DEVDEF').AsInteger <> 1 then
  begin
    exit ;
  end;

  if fEmptyStr(qryDados.FieldByName('VER_DTADEV').AsString) then
  begin
    exit ;
  end;
  if fEmptyStr(qryDados.FieldByName('VER_DTADV2').AsString) then
  begin
    exit ;
  end;
  if qryDados.FieldByName('VER_DTADEV').AsDateTime <> qryDados.FieldByName('VER_DTADV2').AsDateTime then
  begin
    exit ;
  end;

  if not qryDados.FieldByName('VER_DTADP2').IsNull then
  begin
    exit ;
  end;
  result := True ;
end;

function TLanConCHQ.fRetornaChaveControleDevDef: string;
begin
  result := qryDados.FieldByName('CHQINC').AsString ;
end;

function TLanConCHQ.fRetornaDataOcorrencia: Variant;
var
  LintCnt: Integer ;
  LstrAutoIncs: String ;
  LqryConsulta: TUniQuery ;
begin
  LstrAutoIncs := '' ;
  Result := Null ;
  for LintCnt := Low(self.recParCon.arrIncDoc) to High(self.recParCon.arrIncDoc) do
  begin
    if fEmptyStr(LstrAutoIncs) then
      LstrAutoIncs := IntToStr(self.recParCon.arrIncDoc[LintCnt].ConLog)
    else
      LstrAutoIncs := LstrAutoIncs + ',' + IntToStr(self.recParCon.arrIncDoc[LintCnt].ConLog) ;
  end ;

  if not fEmptyStr(LstrAutoIncs) then
  begin
    LqryConsulta := fCriaQuery() ;
    try
      LqryConsulta.Close ;
      LqryConsulta.SQL.Clear ;
      LqryConsulta.SQL.Add('SELECT MIN(LOG_DTAOCO) AS LOG_DTAOCO FROM CONLOG WHERE AUTOINCREM IN (' + LstrAutoIncs + ') ') ;
      LqryConsulta.Open ;
      if not LqryConsulta.Fields.Fields[0].IsNull then
        Result := LqryConsulta.Fields.Fields[0].AsDateTime ;
    finally
      FreeAndNil(LqryConsulta) ;
    end ;
  end ;

end;

function TLanConCHQ.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConCHQ.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConCHQ.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Movimentação de Cheques Concluído!', ['&OK']);
end;

procedure TLanConCHQ.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConCHQ.pSetaPreValidacao(Value: Boolean; objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConCHQ.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon;
end;

end.
