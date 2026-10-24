unit Contabilidade.Classes.TLanConCRC;

interface

uses Contabilidade.Classes.TGerLanCon, Uni, cxProgressBar, Classes, Data.DB,
  UniClientDataSet, Contabilidade.Interfaces, Vcl.StdCtrls, Contabilidade.SQL;

type
  TLanConCRC = Class(TInterfacedObject, ITipLanCon)
  private
    qryDados : TUniQuery;
    Generico : TLanConGenerico;
    pgbProgresso : TcxProgressBar;
    recParCon: TParametrosConsulta;
    lblGravando : TLabel;
    blnCFG_EXCREP_Existe : Boolean;
    blnContaNaBandeiraExiste : Boolean;
    FblnCtrSbanccExiste: Boolean;
    FblnRcxCtrCCExiste: Boolean;
    FcdsCtrMovBan: TUniClientDataSet;
    FcdsCtrMovBanSeqLan: TUniClientDataSet;
    FcdsCaixaFormasPgto: TUniClientDataSet;
    procedure pSetaTextoProgresso(pgbProgresso: TcxProgressBar; strTexto: String);
    function fEfetuaLancamentosEmLote(intTamanhoDoLote: Integer): boolean;
    function fGetSQLPortadorMovBan(const AUseSeqLanFilter: Boolean): String;
    procedure pAplicaFiltrosPortadorMovBan(const ArecParams: TParamsContasReceber; AQry: TUniQuery);
    procedure pCarregaPortadorMovBan(const ArecParams: TParamsContasReceber);
    procedure pCorrigePortadorCrcComPortadorMovban(var AqryConsulta: TUniQuery) ;
    procedure pCarregaFormasPagamentoDoCaixa(const ArecParams: TParamsContasReceber);
    procedure pRestauraIncDocCadrecQuandoDupagr(const AstrNumDup, AstrParcel, AstrSeqBai, AstrEspDoc, AstrCodCli, AstrCodEmp, AstrTabela: String) ;
    procedure pAdicionaFormasPagamentoDoCaixa(var AqryConsulta: TUniQuery) ;
    function fTemFormaDePagamento: Boolean ;
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
Contabilidade.Classes.TTrataIncDoc;

{ TLanConCRC }

constructor TLanConCRC.Create(strTipLan: String; pgbProgresso: TcxProgressBar;
  recParCon: TParametrosConsulta);
begin
  lblGravando := Nil;
  qryDados := fCriaQuery(Nil);
  qryDados.CachedUpdates := True;
  qryDados.Options.SetFieldsReadOnly := False;
  Generico := TLanConGenerico.Create(qryDados, strTipLan, recParCon);
  Self.pgbProgresso := pgbProgresso;
  Self.recParCon := recParCon;
  blnCFG_EXCREP_Existe := fCampoTabela('COUNT(*)', 'CFGSIS', ['SIS_CODCFG', 'SIS_CODEMP'], ['CFG_EXCREP', VS_strCodEmp], False) > 0;
  blnContaNaBandeiraExiste := fCampoExiste('CADBAN', 'BAN_PLANCO');
  FcdsCtrMovBan := Nil ;
  FcdsCtrMovBanSeqLan := Nil;
  FcdsCaixaFormasPgto := Nil ;
  FblnCtrSbanccExiste := fCampoExiste('CADREC', 'CTR_SBANCC');
  FblnRcxCtrCCExiste := fCampoExiste('CADRCXX', 'RCX_CTR_CC');
end;

destructor TLanConCRC.Destroy;
begin
  lblGravando := Nil;
  FreeAndNil(Generico);
  FreeAndNil(qryDados);
  if Assigned(FcdsCtrMovBan) then
    FreeAndNil(FcdsCtrMovBan) ;
  if Assigned(FcdsCtrMovBanSeqLan) then
    FreeAndNil(FcdsCtrMovBanSeqLan);
  if Assigned(FcdsCaixaFormasPgto) then
    FreeAndNil(FcdsCaixaFormasPgto);
  inherited;
end;

function TLanConCRC.fCarregaDados: Boolean;
Var
  recParams: TParamsContasReceber;
begin
  FillChar(recParams, SizeOf(recParams), #0);
  recParams.strCodEmp := recParCon.strCodEmp;
  recParams.blnContaNaBandeiraExiste := blnContaNaBandeiraExiste;
  recParams.blnCTR_RETBAN_Existe := fCampoExiste('CADREC', 'CTR_RETBAN');
  recParams.dtaDtaIni := recParCon.dtaDtaIni;
  recParams.dtaDtaFin := recParCon.dtaDtaFin;
  recParams.strIncDoc := recParCon.strIncDoc;
  recParams.arrIncDoc := recParCon.arrIncDoc;
  qryDados.Close;
  qryDados.SQL.Clear;
  qryDados.SQL.Add( '(' );
  qryDados.SQL.Add( fGetSQLMovimentoCreditoCliente(recParams, 'CADREC') );
  qryDados.SQL.Add( ') UNION ALL ( ' );
  qryDados.SQL.Add( fGetSQLMovimentoCreditoCliente(recParams, 'DUPAGR') );
  qryDados.SQL.Add( ')' );
  pSetaParametrosGerLanCon(recParCon, qryDados);

  qryDados.Open;

  pCarregaPortadorMovBan(recParams) ;
  pCarregaFormasPagamentoDoCaixa(recParams) ;

  Result := (Not qryDados.IsEmpty);
end;

function TLanConCRC.fDeletaLanCon: Boolean;
begin
  Result := Generico.fDeletaLanCon;
end;

function TLanConCRC.fEfetuaLancamentos: Boolean;
begin
  Result := fEfetuaLancamentosEmLote(fCfgSis('LOTCON', varInteger));
end;

function TLanConCRC.fEfetuaLancamentosEmLote(
  intTamanhoDoLote: Integer): boolean;
  Var
    intRecCount : Integer;
    strPagame : String;
    strPlaCta : String;
    strEveNec: string;
begin
  intRecCount := qryDados.RecordCount;
  pgbProgresso.Properties.Max := intRecCount;
  strEveNec := fRetornaEventosNaoExportar;

  pCorrigePortadorCrcComPortadorMovban(qryDados);
  pAdicionaFormasPagamentoDoCaixa(qryDados);

  qryDados.First;
  While Not qryDados.Eof Do
  Begin
    pgbProgresso.Position := qryDados.RecNo;
    pSetaTextoProgresso(pgbProgresso, IIF(Generico.blnPreValidar, 'Pré-Validando', 'Gerando') + ' Lançamentos: "CRC": ' + IntToStr(qryDados.RecNo) + ' / ' + IntToStr(intRecCount));

    strPagame := qryDados.FieldByName('TIPO_PAGAMENTO').AsString;

    if (strPagame = 'Pagamentos Avulsos') and (qryDados.FieldByName('POR_EXPAUT').AsString = 'N') then
    begin
      Generico.pAdicionarWarning(fNormalizaWarningGenerico(Generico.strTipoLancamento, 'Portador do título com o código '+qryDados.FieldByName('CODIGO_PORTADOR_TIT').AsString+', configurado para não exportar [Exportar pelo Autsi]!'), qryDados);
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

    pRestauraIncDocCadrecQuandoDupagr(qryDados.FieldByName('NUMDOC').AsString,
                                      qryDados.FieldByName('PARCEL').AsString,
                                      qryDados.FieldByName('SEQBAI').AsString,
                                      qryDados.FieldByName('ESPDOC').AsString,
                                      qryDados.FieldByName('CODIGO_CLIENTE_FORNECEDOR').AsString,
                                      qryDados.FieldByName('CODEMP').AsString,
                                      qryDados.FieldByName('TABELA').AsString) ;

    strPlaCta := qryDados.FieldByName('CTA_PLANCO').AsString;

    //VALOR DUPLICATA
    if not fTemFormaDePagamento then
      Generico.pGravaLancto('CTR_VALDUP', DES_VALOR_DUPLICATA, strPlaCta, '', qryDados.FieldByName('CODEVE').AsString, strPagame);

    Generico.pGravaLancto('CTR_DINHEI', DES_VALOR_DUPLICATA, strPlaCta, FPG_DINHEIRO, qryDados.FieldByName('CODEVE').AsString, strPagame);
    Generico.pGravaLancto('CTR_CHQAVI', DES_VALOR_DUPLICATA, strPlaCta, FPG_CHEQUE_VISTA, qryDados.FieldByName('CODEVE').AsString, strPagame);
    Generico.pGravaLancto('CTR_CHQPRE', DES_VALOR_DUPLICATA, strPlaCta, FPG_CHEQUE_PRE, qryDados.FieldByName('CODEVE').AsString, strPagame);
    Generico.pGravaLancto('CTR_CARTAO', DES_VALOR_DUPLICATA, strPlaCta, FPG_CARTAO, qryDados.FieldByName('CODEVE').AsString, strPagame);
    Generico.pGravaLancto('CTR_ORDPAG', DES_VALOR_DUPLICATA, strPlaCta, FPG_ORDPAG, qryDados.FieldByName('CODEVE').AsString, strPagame);

    if qryDados.FieldByName('CTR_ADTCLI').AsString = 'S' then
      Generico.pGravaLancto('CTR_CREDIT', DES_VALOR_DUPLICATA, strPlaCta, FPG_ADIANTAMENTO, qryDados.FieldByName('CODEVE').AsString, strPagame);

    qryDados.Next;
  End;

  Result := True;
end;

function TLanConCRC.fEfetuaLancamentosPreValidacao: Boolean;
begin
  result := Generico.fEfetuaLancamentosPreValidacao(Self) ;
end;

function TLanConCRC.fGetSQLPortadorMovBan(const AUseSeqLanFilter: Boolean): String;
var
  LSql: TStringList;
begin
  LSql := TStringList.Create;
  try
    LSql.Add('SELECT');
    LSql.Add('  CADREC0.AUTOINCREM,');
    LSql.Add('  IFNULL(PORNCO.NCO_CODCON, CADPOR.POR_PLANCO) AS PLAPOR,');
    LSql.Add('  IFNULL(PORNCO.NCO_CODPOR, CADPOR.POR_CODPOR) AS CODIGO_PORTADOR,');
    LSql.Add('  IFNULL(CADPOR.POR_EXPAUT, "S") AS POR_EXPAUT,');
    LSql.Add('  BANCTR0.CTR_CODEMP');
    LSql.Add('FROM CADREC CADREC0');
    LSql.Add('INNER JOIN BANCTR BANCTR0 ON TRUE');
    LSql.Add('  AND CADREC0.CTR_NUMDUP = BANCTR0.CTR_NUMDUP');
    LSql.Add('  AND CADREC0.CTR_CODCLI = BANCTR0.CTR_CODCLI');
    LSql.Add('  AND CADREC0.CTR_PARCEL = BANCTR0.CTR_PARCEL');
    LSql.Add('  AND CADREC0.CTR_CODEMP = BANCTR0.CTR_CODEMP');
    LSql.Add('  AND CADREC0.CTR_SEQBAI = BANCTR0.CTR_SEQBAI');
    LSql.Add('  AND CADREC0.CTR_ESPDOC = BANCTR0.CTR_ESPDOC');
    LSql.Add('INNER JOIN MOVBAN MOVBAN0 ON TRUE');
    LSql.Add('  AND MOVBAN0.CTB_SEQLAN = BANCTR0.CTB_SEQLAN');
    LSql.Add('LEFT JOIN CADPOR ON TRUE');
    LSql.Add('  AND MOVBAN0.CTB_CODPOR = CADPOR.POR_CODPOR');
    LSql.Add('LEFT JOIN PORNCO ON TRUE');
    LSql.Add('  AND PORNCO.NCO_CODPOR = CADPOR.POR_CODPOR');
    LSql.Add('  AND PORNCO.NCO_CODEMP = CADREC0.CTR_CODEMP');
    LSql.Add('WHERE TRUE');
    LSql.Add('  AND CADREC0.CTR_ESPDOC = "CC"');
    LSql.Add('  AND CADREC0.CTR_GRVORI < 0.0');
    LSql.Add('  AND CADREC0.CTR_SEQBAI = 0');
    LSql.Add('  AND MOVBAN0.CTB_CREDEB = "C"');
    LSql.Add('  AND MOVBAN0.CTB_ORIGEM = "CRC"');
    LSql.Add('  AND MOVBAN0.CTB_HIST01 NOT LIKE "ESTORN%"');

    if AUseSeqLanFilter then
    begin
      LSql.Add('  AND IFNULL(CADREC0.CTR_SBANCC, "") <> ""');
      LSql.Add('  AND MOVBAN0.CTB_SEQLAN = CADREC0.CTR_SBANCC');
      LSql.Add('  AND (MOVBAN0.CTB_SEQLAN, STR_TO_DATE(CONCAT(MOVBAN0.CTB_DTALAN, " ", MOVBAN0.CTB_HORLAN), "%Y-%m-%d %H:%i:%s")) IN (');
      LSql.Add('      SELECT MOVBAN1.CTB_SEQLAN, MIN(STR_TO_DATE(CONCAT(MOVBAN1.CTB_DTALAN, " ", MOVBAN1.CTB_HORLAN), "%Y-%m-%d %H:%i:%s"))');
      LSql.Add('      FROM MOVBAN MOVBAN1');
      LSql.Add('      WHERE MOVBAN1.CTB_CREDEB = "C"');
      LSql.Add('        AND MOVBAN1.CTB_ORIGEM = "CRC"');
      LSql.Add('        AND MOVBAN1.CTB_HIST01 NOT LIKE "ESTORN%"');
      LSql.Add('      GROUP BY MOVBAN1.CTB_SEQLAN');
      LSql.Add('  )');
    end
    else
    begin
      LSql.Add('  AND (CADREC0.AUTOINCREM, STR_TO_DATE(CONCAT(MOVBAN0.CTB_DTALAN, " ", MOVBAN0.CTB_HORLAN), "%Y-%m-%d %H:%i:%s")) IN (');
      LSql.Add('      SELECT CADREC1.AUTOINCREM, MIN(STR_TO_DATE(CONCAT(MOVBAN1.CTB_DTALAN, " ", MOVBAN1.CTB_HORLAN), "%Y-%m-%d %H:%i:%s"))');
      LSql.Add('      FROM CADREC CADREC1');
      LSql.Add('      INNER JOIN BANCTR BANCTR1 ON TRUE');
      LSql.Add('        AND CADREC1.CTR_NUMDUP = BANCTR1.CTR_NUMDUP');
      LSql.Add('        AND CADREC1.CTR_CODCLI = BANCTR1.CTR_CODCLI');
      LSql.Add('        AND CADREC1.CTR_PARCEL = BANCTR1.CTR_PARCEL');
      LSql.Add('        AND CADREC1.CTR_CODEMP = BANCTR1.CTR_CODEMP');
      LSql.Add('        AND CADREC1.CTR_SEQBAI = BANCTR1.CTR_SEQBAI');
      LSql.Add('        AND CADREC1.CTR_ESPDOC = BANCTR1.CTR_ESPDOC');
      LSql.Add('      INNER JOIN MOVBAN MOVBAN1 ON TRUE');
      LSql.Add('        AND MOVBAN1.CTB_SEQLAN = BANCTR1.CTB_SEQLAN');
      LSql.Add('      WHERE CADREC1.AUTOINCREM = CADREC0.AUTOINCREM');
      LSql.Add('        AND MOVBAN1.CTB_CREDEB = "C"');
      LSql.Add('        AND MOVBAN1.CTB_ORIGEM = "CRC"');
      LSql.Add('        AND MOVBAN1.CTB_DTALAN = CADREC0.CTR_DTACAD');
      LSql.Add('      GROUP BY CADREC1.AUTOINCREM');
      LSql.Add('  )');
    end;

    Result := LSql.Text;
  finally
    LSql.Free;
  end;
end;

function TLanConCRC.fTemFormaDePagamento: Boolean;
begin
  Result := True ;
  if qryDados.FieldByName('CTR_DINHEI').AsFloat <> 0.00 then
    Exit ;

  if qryDados.FieldByName('CTR_CHQPRE').AsFloat <> 0.00 then
    Exit ;

  if qryDados.FieldByName('CTR_CHQAVI').AsFloat <> 0.00 then
    Exit ;

  if qryDados.FieldByName('CTR_CARTAO').AsFloat <> 0.00 then
    Exit ;

  if qryDados.FieldByName('CTR_ORDPAG').AsFloat <> 0.00 then
    Exit ;

  if (qryDados.FieldByName('CTR_ADTCLI').AsString = 'S') and (qryDados.FieldByName('CTR_CREDIT').AsFloat <> 0.00) then
    Exit ;

  Result := False ;
end;

function TLanConCRC.fTemParametrosConfigurados: Boolean;
begin
  Result := Generico.fTemParametrosConfigurados;
end;

function TLanConCRC.GetListaErros: TUniClientDataSet;
begin
  Result := Generico.listaErros;
end;

procedure TLanConCRC.pAdicionaFormasPagamentoDoCaixa(
  var AqryConsulta: TUniQuery);
begin
  if not Assigned(FcdsCaixaFormasPgto) then
    Exit ;

  AqryConsulta.BeforeScroll := nil ;
  try
    AqryConsulta.First;
    While Not AqryConsulta.Eof Do
    Begin
      if (FcdsCaixaFormasPgto.FindKey([AqryConsulta.FieldByName('CTRINC').AsString])) And ((FcdsCaixaFormasPgto.FieldByName('CTR_DESCRI').AsString = '') or (FcdsCaixaFormasPgto.FieldByName('CTR_NOMFRM').AsString <> 'frmCadCtaReceber')) then
      begin
        AqryConsulta.Edit ;
        AqryConsulta.FieldByName('CTR_DINHEI').AsFloat := FcdsCaixaFormasPgto.FieldByName('RCX_DINREC').AsFloat ;
        AqryConsulta.FieldByName('CTR_CHQPRE').AsFloat := FcdsCaixaFormasPgto.FieldByName('RCX_CHQPRE').AsFloat ;
        AqryConsulta.FieldByName('CTR_CHQAVI').AsFloat := FcdsCaixaFormasPgto.FieldByName('RCX_CHQAVI').AsFloat ;
        AqryConsulta.FieldByName('CTR_CARTAO').AsFloat := FcdsCaixaFormasPgto.FieldByName('RCX_CARREC').AsFloat ;
        AqryConsulta.FieldByName('CTR_ORDPAG').AsFloat := FcdsCaixaFormasPgto.FieldByName('RCX_ORDREC').AsFloat ;
        AqryConsulta.FieldByName('CONTA_BANDEIRA').AsString := FcdsCaixaFormasPgto.FieldByName('CONTA_BANDEIRA').AsString ;
        AqryConsulta.FieldByName('CODIGO_BANDEIRA').AsString := FcdsCaixaFormasPgto.FieldByName('CODIGO_BANDEIRA').AsString ;
        if not ((AqryConsulta.FieldByName('CTR_ADTCLI').AsString = 'N') and (fEmptyStr(FcdsCaixaFormasPgto.FieldByName('CODIGO_BANDEIRA').AsString))) then
          AqryConsulta.FieldByName('CTR_CREDIT').AsFloat := abs(FcdsCaixaFormasPgto.FieldByName('RCX_VALCRE').AsFloat) ;
        AqryConsulta.Post ;
      end ;
      AqryConsulta.Next;
    end ;
  finally
    AqryConsulta.BeforeScroll := Generico.pBeforeScroll ;
  end;
end;

procedure TLanConCRC.pAplicaFiltrosPortadorMovBan(
  const ArecParams: TParamsContasReceber; AQry: TUniQuery);
begin
  TTrataIncDocContabil
    .New
    .fColunaIncDoc('CADREC0.AUTOINCREM')
    .fIncDoc(ArecParams.strIncDoc)
    .fArrIncDoc(ArecParams.arrIncDoc)
    .fQuerySql(AQry)
    .fExecute ;

  if (Not ArecParams.strCodEmp.IsEmpty) then
  begin
    AQry.SQL.Add('  AND CADREC0.CTR_CODEMP = :CODEMP ');
    AQry.ParamByName('CODEMP').AsString := ArecParams.strCodEmp;
  end;

  if (ArecParams.dtaDtaIni > 0) then
  begin
    AQry.SQL.Add('  AND CADREC0.CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ');
    AQry.ParamByName('DTAINI').AsDate := ArecParams.dtaDtaIni;
    AQry.ParamByName('DTAFIN').AsDate := ArecParams.dtaDtaFin;
  end;
end;

procedure TLanConCRC.pRestauraIncDocCadrecQuandoDupagr(
  const AstrNumDup, AstrParcel, AstrSeqBai, AstrEspDoc, AstrCodCli, AstrCodEmp, AstrTabela: String);
var
  LqryConsulta: TUniQuery ;
  LqryDelLan: TUniQuery ;
begin

  if AstrTabela = 'CADREC' then
    Exit ;

  LqryConsulta := fCriaQuery() ;
  LqryDelLan := fCriaQuery() ;
  try
    LqryConsulta.Close;
    LqryConsulta.SQL.Clear;
    LqryConsulta.SQL.Add(' SELECT AUTOINCREM, CTR_NUMDUP, CTR_PARCEL, CTR_SEQBAI, CTR_ESPDOC, CTR_CODCLI, CTR_CODEMP ');
    LqryConsulta.SQL.Add(' FROM DEL_CADREC CTR ');
    LqryConsulta.SQL.Add(' WHERE ');
    LqryConsulta.SQL.Add('    CTR_NUMDUP = :NUMDUP ');
    LqryConsulta.SQL.Add('    AND CTR_PARCEL = :PARCEL ');
    LqryConsulta.SQL.Add('    AND CTR_SEQBAI = :SEQBAI ');
    LqryConsulta.SQL.Add('    AND CTR_ESPDOC = :ESPDOC ');
    LqryConsulta.SQL.Add('    AND CTR_CODCLI = :CODCLI ');
    LqryConsulta.SQL.Add('    AND CTR_CODEMP = :CODEMP ');
    LqryConsulta.SQL.Add(' ORDER BY AUTOINCREM ');
    LqryConsulta.ParamByName('NUMDUP').AsString := AstrNumDup ;
    LqryConsulta.ParamByName('PARCEL').AsString := AstrParcel ;
    LqryConsulta.ParamByName('SEQBAI').AsString := AstrSeqBai ;
    LqryConsulta.ParamByName('ESPDOC').AsString := AstrEspDoc ;
    LqryConsulta.ParamByName('CODCLI').AsString := AstrCodCli ;
    LqryConsulta.ParamByName('CODEMP').AsString := AstrCodEmp ;
    LqryConsulta.Open;

    LqryConsulta.First ;
    while not LqryConsulta.Eof do
    begin
      LqryDelLan.Close;
      LqryDelLan.SQL.Clear;
      LqryDelLan.SQL.Add(' SELECT CON_INCDOC ');
      LqryDelLan.SQL.Add(' FROM DEL_LANCON ');
      LqryDelLan.SQL.Add(' WHERE CON_TIPLAN = :TIPLAN ');
      LqryDelLan.SQL.Add('       AND CON_INCDOC = :INCDOC ');
      LqryDelLan.SQL.Add('       AND CON_TABELA = :TABELA ; ');
      LqryDelLan.ParamByName('TIPLAN').AsString := 'CRC' ;
      LqryDelLan.ParamByName('INCDOC').AsString := LqryConsulta.FieldByName('AUTOINCREM').AsString ;
      LqryDelLan.ParamByName('TABELA').AsString := 'CADREC' ;
      LqryDelLan.Open ;
      if not LqryDelLan.IsEmpty then
      begin
        qryDados.Edit ;
        qryDados.FieldByName('CTRINC').AsString := LqryConsulta.FieldByName('AUTOINCREM').AsString ;
        qryDados.FieldByName('TABELA').AsString := 'CADREC' ;
        qryDados.Post ;
        Exit ;
      end ;

      LqryConsulta.Next ;
    end ;

  finally
    FreeAndNil(LqryConsulta) ;
    FreeAndNil(LqryDelLan) ;
  end ;

end;

procedure TLanConCRC.pCarregaFormasPagamentoDoCaixa(
  const ArecParams: TParamsContasReceber);
var
  LqryConsulta: TUniQuery;
  LblnContaNaBandeiraExiste: Boolean;
  LblnBanNcoExiste: Boolean;
  LstrColunasBandeira: string;

  procedure pAplicaFiltrosCadRec;
  begin
    LqryConsulta.SQL.Add('     AND CADREC.CTR_ESPDOC = "CC" ');
    LqryConsulta.SQL.Add('     AND CADREC.CTR_GRVORI < 0.0 ');
    LqryConsulta.SQL.Add('     AND CADREC.CTR_SEQBAI = 0 ');

    If (Not ArecParams.strCodEmp.IsEmpty) Then
      LqryConsulta.SQL.Add('     AND CADREC.CTR_CODEMP = :CODEMP ');

    If (ArecParams.dtaDtaIni > 0) then
      LqryConsulta.SQL.Add('     AND CADREC.CTR_DTACAD BETWEEN :DTAINI AND :DTAFIN ');
  end;

begin
  if fAtivaFormasPagamentoCaixaCRC = 'N' then
    Exit;

  If Assigned(FcdsCaixaFormasPgto) Then
    FreeAndNil(FcdsCaixaFormasPgto);

  LblnContaNaBandeiraExiste := fCampoExiste('CADBAN', 'BAN_PLANCO');
  LblnBanNcoExiste := fTabelaExiste('BANNCO');

  if LblnContaNaBandeiraExiste then
    LstrColunasBandeira :=
      fSQLContaBandeiraCTR('CADRCXX.RCX_SEQCON', 'CADRCXX.RCX_EMPDUP', LblnBanNcoExiste) + ' AS CONTA_BANDEIRA, ' +
      fSQLCodigoBandeiraCTR('CADRCXX.RCX_SEQCON', 'CADRCXX.RCX_EMPDUP', LblnBanNcoExiste) + ' AS CODIGO_BANDEIRA '
  else
    LstrColunasBandeira := ' CAST("" AS CHAR(1)) AS CONTA_BANDEIRA, CAST("" AS CHAR(1)) AS CODIGO_BANDEIRA ';

  LqryConsulta := fCriaQuery();
  try
    LqryConsulta.Close;
    LqryConsulta.SQL.Clear;

    LqryConsulta.SQL.Add(' SELECT AUTOINCREM, RCX_DINREC, RCX_CHQAVI, RCX_CHQPRE, RCX_CARREC, RCX_ORDREC, RCX_VALCRE, ');
    LqryConsulta.SQL.Add('        CTR_DESCRI, CTR_NOMFRM, CONTA_BANDEIRA, CODIGO_BANDEIRA ');
    LqryConsulta.SQL.Add(' FROM ( ');

    if FblnRcxCtrCCExiste then
    begin
      LqryConsulta.SQL.Add('   SELECT CADREC.AUTOINCREM, RCX_DINREC, RCX_CHQAVI, RCX_CHQPRE, RCX_CARREC, RCX_ORDREC, RCX_VALCRE, ');
      LqryConsulta.SQL.Add('          CAST("" AS CHAR(1)) AS CTR_DESCRI, CAST("" AS CHAR(1)) AS CTR_NOMFRM, ');
      LqryConsulta.SQL.Add('          ' + LstrColunasBandeira + ' ');
      LqryConsulta.SQL.Add('   FROM CADREC ');
      LqryConsulta.SQL.Add('        INNER JOIN CADRCXX ');
      LqryConsulta.SQL.Add('          ON CADRCXX.RCX_CTR_CC = CADREC.AUTOINCREM ');
      LqryConsulta.SQL.Add('   WHERE TRUE ');
      pAplicaFiltrosCadRec;
      LqryConsulta.SQL.Add(' UNION ALL ');
    end;

    LqryConsulta.SQL.Add('   SELECT CADREC.AUTOINCREM, RCX_DINREC, RCX_CHQAVI, RCX_CHQPRE, RCX_CARREC, RCX_ORDREC, RCX_VALCRE, ');
    LqryConsulta.SQL.Add('          LG.CTR_DESCRI, LG.CTR_NOMFRM, ');
    LqryConsulta.SQL.Add('          ' + LstrColunasBandeira + ' ');
    LqryConsulta.SQL.Add('   FROM CADREC ');
    LqryConsulta.SQL.Add('        INNER JOIN CADRCXX ');
    LqryConsulta.SQL.Add('          ON CTR_CODCLI = RCX_CODCLI ');
    LqryConsulta.SQL.Add('          AND CTR_ESPDOC = RCX_ESPDOC ');
    LqryConsulta.SQL.Add('          AND CTR_CODEMP = RCX_CODEMP ');
    LqryConsulta.SQL.Add('          AND CTR_DTACAD = RCX_DTACAD ');
    LqryConsulta.SQL.Add('          AND ABS(CTR_GRVORI) = ABS(RCX_VALDOC) ');
    LqryConsulta.SQL.Add('          AND CTR_SEQBAI = RCX_SEQBAI ');
    LqryConsulta.SQL.Add('        LEFT JOIN LOGCTR LG ');
    LqryConsulta.SQL.Add('          ON  LG.CTR_NUMDUP = CADREC.CTR_NUMDUP ');
    LqryConsulta.SQL.Add('          AND LG.CTR_CODCLI = CADREC.CTR_CODCLI ');
    LqryConsulta.SQL.Add('          AND LG.CTR_DESCRI LIKE "INCLUSÃO%" ');
    LqryConsulta.SQL.Add('          AND LG.CTR_CODEMP = CADREC.CTR_CODEMP ');
    LqryConsulta.SQL.Add('          AND LG.CTR_ESPDOC = CADREC.CTR_ESPDOC ');
    LqryConsulta.SQL.Add('          AND LG.CTR_PARCEL = CADREC.CTR_PARCEL ');
    LqryConsulta.SQL.Add('          AND LG.CTR_DTACAD = CADREC.CTR_DTACAD ');
    LqryConsulta.SQL.Add('          AND LG.CTR_SEQBAI = CADREC.CTR_SEQBAI ');
    LqryConsulta.SQL.Add('   WHERE TRUE ');
    pAplicaFiltrosCadRec;

    if FblnRcxCtrCCExiste then
    begin
      LqryConsulta.SQL.Add('     AND NOT EXISTS ( ');
      LqryConsulta.SQL.Add('       SELECT 1 FROM CADRCXX X ');
      LqryConsulta.SQL.Add('       WHERE X.RCX_CTR_CC = CADREC.AUTOINCREM ');
      LqryConsulta.SQL.Add('     ) ');
    end;

    LqryConsulta.SQL.Add(' ) CADREC ');
    LqryConsulta.SQL.Add(' WHERE TRUE ');

    TTrataIncDocContabil
      .New
      .fColunaIncDoc('CADREC.AUTOINCREM')
      .fIncDoc(ArecParams.strIncDoc)
      .fArrIncDoc(ArecParams.arrIncDoc)
      .fQuerySql(LqryConsulta)
      .fExecute;

    If (Not ArecParams.strCodEmp.IsEmpty) Then
      LqryConsulta.ParamByName('CODEMP').AsString := ArecParams.strCodEmp;

    If (ArecParams.dtaDtaIni > 0) then
    begin
      LqryConsulta.ParamByName('DTAINI').AsDate := ArecParams.dtaDtaIni;
      LqryConsulta.ParamByName('DTAFIN').AsDate := ArecParams.dtaDtaFin;
    end;

    LqryConsulta.Open;

    FcdsCaixaFormasPgto := fCriaClientDatset(LqryConsulta, false);
    FcdsCaixaFormasPgto.IndexFieldNames := 'AUTOINCREM';
    FcdsCaixaFormasPgto.Open;

  finally
    FreeAndNil(LqryConsulta);
  end;
end;

procedure TLanConCRC.pCarregaPortadorMovBan(const ArecParams: TParamsContasReceber);
var
  LqryConsulta: TUniQuery ;
begin
  If Assigned(FcdsCtrMovBan) Then
    FreeAndNil(FcdsCtrMovBan);

  If Assigned(FcdsCtrMovBanSeqLan) Then
    FreeAndNil(FcdsCtrMovBanSeqLan);

  LqryConsulta := fCriaQuery() ;
  try
    if FblnCtrSbanccExiste then
    begin
      LqryConsulta.Close;
      LqryConsulta.SQL.Clear;
      LqryConsulta.SQL.Text := fGetSQLPortadorMovBan(True);

      pAplicaFiltrosPortadorMovBan(ArecParams, LqryConsulta);
      LqryConsulta.Open;

      FcdsCtrMovBanSeqLan := fCriaClientDatset(LqryConsulta, false);
      FcdsCtrMovBanSeqLan.IndexFieldNames := 'AUTOINCREM' ;
      FcdsCtrMovBanSeqLan.Open;
    end;

    LqryConsulta.Close;
    LqryConsulta.SQL.Clear;
    LqryConsulta.SQL.Text := fGetSQLPortadorMovBan(False);
    pAplicaFiltrosPortadorMovBan(ArecParams, LqryConsulta);
    LqryConsulta.Open;

    FcdsCtrMovBan := fCriaClientDatset(LqryConsulta, false);
    FcdsCtrMovBan.IndexFieldNames := 'AUTOINCREM' ;
    FcdsCtrMovBan.Open;
  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end;

procedure TLanConCRC.pCorrigePortadorCrcComPortadorMovban(
  var AqryConsulta: TUniQuery);
begin
  AqryConsulta.BeforeScroll := nil ;
  try
    AqryConsulta.First;
    While Not AqryConsulta.Eof Do
    Begin

      if Assigned(FcdsCtrMovBanSeqLan) and FcdsCtrMovBanSeqLan.FindKey([AqryConsulta.FieldByName('CTRINC').AsString]) then
      begin
        AqryConsulta.Edit ;
        AqryConsulta.FieldByName('PLAPOR').AsString := FcdsCtrMovBanSeqLan.FieldByName('PLAPOR').AsString ;
        AqryConsulta.FieldByName('CODIGO_PORTADOR').AsString := FcdsCtrMovBanSeqLan.FieldByName('CODIGO_PORTADOR').AsString ;
        AqryConsulta.FieldByName('POR_EXPAUT').AsString := FcdsCtrMovBanSeqLan.FieldByName('POR_EXPAUT').AsString ;
        AqryConsulta.Post ;
      end
      else if Assigned(FcdsCtrMovBan) and FcdsCtrMovBan.FindKey([AqryConsulta.FieldByName('CTRINC').AsString]) then
      begin
        AqryConsulta.Edit ;
        AqryConsulta.FieldByName('PLAPOR').AsString := FcdsCtrMovBan.FieldByName('PLAPOR').AsString ;
        AqryConsulta.FieldByName('CODIGO_PORTADOR').AsString := FcdsCtrMovBan.FieldByName('CODIGO_PORTADOR').AsString ;
        AqryConsulta.FieldByName('POR_EXPAUT').AsString := FcdsCtrMovBan.FieldByName('POR_EXPAUT').AsString ;
        AqryConsulta.Post ;
      end;

      AqryConsulta.Next;
    end ;
  finally
    AqryConsulta.BeforeScroll := Generico.pBeforeScroll ;
  end;
end;

procedure TLanConCRC.pMensagemConclusao;
begin
  fMensagem('ATENÇÃO!', 'Crédito de Clientes Concluído!', ['&OK']);
end;

procedure TLanConCRC.pSetaPreValidacao(Value: Boolean;
  objValida: IValidaContaContabil; const AblnLancarEmPreValidar: boolean = False);
begin
  Generico.blnPreValidar := Value;
  Generico.objValida := objValida;
  Generico.LancarEmPreValidar := AblnLancarEmPreValidar ;
end;

procedure TLanConCRC.pSetaPreValidacao(const Value: Boolean);
begin
  Generico.blnPreValidar := Value;
end;

procedure TLanConCRC.pSetaTextoProgresso(pgbProgresso: TcxProgressBar;
  strTexto: String);
begin
  if assigned(lblGravando) then
    lblGravando.Caption := strTexto
  else if Assigned(pgbProgresso) And (Assigned(pgbProgresso.Parent)) and (GetParentForm(pgbProgresso).FindComponent('lblGravando') <> Nil) Then
  Begin
    lblGravando := TLabel(GetParentForm(pgbProgresso).FindComponent('lblGravando'));
    lblGravando.Caption := strTexto;
  End;
  Application.ProcessMessages;
end;

procedure TLanConCRC.pVerificaSeLancouLanCon;
begin
  Generico.pVerificaSeLancouLanCon ;
end;

end.
