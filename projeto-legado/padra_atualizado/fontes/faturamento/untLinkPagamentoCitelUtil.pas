unit untLinkPagamentoCitelUtil;

interface

uses
  Data.DB, MemDS, DBAccess, Uni, System.SysUtils,
  untInterfaceLinkPagamentoCitel;

type
  TLinkPagamentoCitelClass = class
    private
      FstrEspDoc: String;
      FstrNumDoc: String;
      FstrTipRec: String;
      FstrCodEmp: String;
      FstrCodCli: String;
      FstrOrigem: String;
      FstrAutIncs: String;
      FstrNumNit: String;

      procedure SetstrCodEmp(const Value: String);
      procedure SetstrEspDoc(const Value: String);
      procedure SetstrNumDoc(const Value: String);
      procedure SetstrTipRec(const Value: String);
      procedure SetstrCodCli(const Value: String);

      function fGetSeqFgoPedidos(strNumNit, strMercId : String) : String;
      function fGetAutoIncSitDoc(const AstrNumNit, AstrMercId : String; var AstrTipLan: String): String;
      function fImpCupom(AstrViaCli, AstrViaLoj: String): Boolean;
      procedure pImprimirCliente(AstrViaCli, AstrViaLoj : String);
      procedure pImprimirLojista(AstrViaCli, AstrViaLoj : String);
      procedure pProcessarEstorno(const AfltValCar: Double; const AstrNumCCD: String) ;
      procedure pGravarAdtCliCartao(const AfltValCar: Double; const AintSeqConRcx: Integer);
      procedure pExcluirMovCar(const AstrNumCCD: String) ;
      class function fRetornaStatusPedidoLinkPagamentoCitel(const AstrNumDoc, AstrEspDoc, AstrCodEmp: string): string ;
      procedure pClassificaTipoDocumento(var ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel;
                                         const AstrNumNit, AstrMercId : String) ;
      function fCancelaLinkPagamentoSitef(const AstrNsu, AstrNit, AstrNumCCD, AstrNumeroCartao, AstrVencCartao, AstrOrigem: String;
                                           var AstrMsgErro: String): Boolean ;
      function fCancelaLinkPagamentoCielo(const AstrNit, AstrOrigem: String; var AstrMsgErro: String; const AstrNumCCD: String): Boolean ;
      function fCancelaLinkPagamentoCredPay(const AstrNit, AstrOrigem: String; var AstrMsgErro: String; const AstrNumCCD: String): Boolean ;
      function fCancelaLinkPagamentoIpag(const AstrNit, AstrOrigem: String; var AstrMsgErro: String; const AstrNumCCD: String): Boolean ;
      class function fGetTotaisAdiantamento(const AstrNumDoc, AstrEspDoc, AstrCodEmp: string): Double ;
      function fCodigoRetornoCancelamentoValido(const AintCodigo: Integer): Boolean ;
    public
      property strTipRec: String read FstrTipRec write SetstrTipRec;
      property strNumDoc: String read FstrNumDoc write SetstrNumDoc;
      property strEspDoc: String read FstrEspDoc write SetstrEspDoc;
      property strCodEmp: String read FstrCodEmp write SetstrCodEmp;
      property strCodCli: String read FstrCodCli write SetstrCodCli;
      property strOrigem: String read FstrOrigem write FstrOrigem;
      property strAutIncs: String read FstrAutIncs write FstrAutIncs;
      property strNumNit: String read FstrNumNit write FstrNumNit;

      procedure pCarregaPedidoLinkPagamentoCitel(strNumDoc, strEspDoc, strCodEmp: string);
      class function fDocumentoLinkPagamentoCitel(strNumDoc, strEspDoc, strCodEmp, strCodCli, strOrigem: string): Boolean;
     {$IFNDEF LINUX}
      class function fProcessaCancelamento(const AstrNumDoc, AstrEspDoc, AstrCodEmp: string): Boolean ;
      class function fPossuiAdiantamentoLinkPagamentoCitel(strNumDoc, strEspDoc, strCodEmp: string): Boolean;
     {$ENDIF}
      class function fTemSaldoSuficienteAdtCli(const AstrNumDoc, AstrEspDoc, AstrCodEmp: string): Boolean;
      class function fTemAdcliTransformadoEmCC(const AstrNumDoc, AstrEspDoc, AstrCodEmp: string): Boolean;
      function fVerificaEstrutura: Boolean;
      function fGeraNovoLinkPagamento(strNumNitOld, strMercIdOld, strCodEmpOld,
        strCodOpe, strTipTra : String; intQtdPar, intTpParc : Integer; fltValCar : Double;
        var strNewNit, AstrRetornoMsgErro : String) : Boolean;
      function fCancelaLinkPagamento(const AstrNsu, AstrNit, AstrNumCCD, AstrNumeroCartao, AstrVencCartao, AstrOrigem: String; var AstrMsgErro: String): Boolean ;
      function fDesvinculaLinkPagamentoPedido: Boolean;
      function fImprimiLinkCancelamento(const AstrNsu, AstrNit: String): Boolean ;
      function fExpiraLinkPagamento(const AstrNit: String): Boolean ;
  end;

{$IFNDEF LINUX}
  TParChavesLinkPagamento = class
  public
    class procedure pCarregarChaves(var AstrChavePrivada, AstrChavePublica: String) ;
    class function fSalvarChaves(const AstrChavePrivada, AstrChavePublica: String): Boolean ;
  end ;
{$ENDIF}

implementation

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'}, Shared.Core,
{$ELSE}
  untAdiantamentoCliente, untFuncoesSimples, untLibJWTUtil, untFuncoes, untQckFatImpNFCe,
  untPgtoOnlineESiTefManutencao,
{$ENDIF}
  untTypesSistema, untLinkPagamentoCitelModel, untLinkPagamentoCitelEnvio,
  untLinkPagamentoCitelStatus, untLinkPagamentoCitelRepositorio, Json,
  untAdiantamentoClienteGenerico, System.StrUtils,
  untClassesComumLinkPagamentoCitel, DateUtils, untFactoryLinkPagamentoCitel;

{ TLinkPagamentoCitelClass }

function TLinkPagamentoCitelClass.fGetAutoIncSitDoc(const AstrNumNit, AstrMercId : String;
                                                    var AstrTipLan: String): String;
var
  qryAux : TUniQuery;
begin
  Result := '';
  AstrTipLan := '';

  qryAux := fCriaQuery;
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT ');
    qryAux.SQL.Add('   DOC_NUMDOC, DOC_TIPLAN ');
    qryAux.SQL.Add(' FROM ');
    qryAux.SQL.Add('  SITDOC ');
    qryAux.SQL.Add(' WHERE DOC_NUMNIT = :NUMNIT ');
    qryAux.SQL.Add('   AND DOC_MERCID = :MERCID ');

    qryAux.ParamByName('NUMNIT').AsString := AstrNumNit;
    qryAux.ParamByName('MERCID').AsString := AstrMercId;
    qryAux.Open;

    qryAux.First;
    while not qryAux.Eof do
    begin
      if fEmptyStr(Result) then
        Result := PChar(qryAux.FieldByName('DOC_NUMDOC').AsString)
      else
        Result := Result +', '+ PChar(qryAux.FieldByName('DOC_NUMDOC').AsString);

      AstrTipLan := qryAux.FieldByName('DOC_TIPLAN').AsString ;
      qryAux.Next;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

function TLinkPagamentoCitelClass.fGetSeqFgoPedidos(strNumNit, strMercId : String): String;
  var
    qryAux : TUniQuery;
begin
  Result := '';

  qryAux := fCriaQuery;
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add(' SELECT ');
    qryAux.SQL.Add('   FGO_SEQFGO ');
    qryAux.SQL.Add(' FROM ');
    qryAux.SQL.Add('  EXTGOR ');
    qryAux.SQL.Add(' WHERE FGO_SITNIT = :NUMNIT ');
    qryAux.SQL.Add('   AND FGO_SITMID = :MERCID ');

    qryAux.ParamByName('NUMNIT').AsString := strNumNit;
    qryAux.ParamByName('MERCID').AsString := strMercId;
    qryAux.Open;

    qryAux.First;
    while not qryAux.Eof do
    begin
      if fEmptyStr(Result) then
        Result := PChar(qryAux.FieldByName('FGO_SEQFGO').AsString)
      else
        Result := Result +', '+ PChar(qryAux.FieldByName('FGO_SEQFGO').AsString);

      qryAux.Next;
    end;
  finally
    FreeAndNil(qryAux);
  end;
end;

class function TLinkPagamentoCitelClass.fGetTotaisAdiantamento(const AstrNumDoc,
  AstrEspDoc, AstrCodEmp: string): Double;
var
  LqrySaldoCartaoAdtCli : TUniQuery ;
begin
  LqrySaldoCartaoAdtCli := fCriaQuery(nil);
  try
    LqrySaldoCartaoAdtCli.Close;
    LqrySaldoCartaoAdtCli.SQL.Clear;
    LqrySaldoCartaoAdtCli.SQL.Add('SELECT SQL_NO_CACHE ');
    LqrySaldoCartaoAdtCli.SQL.Add('SUM(IF(ADT_TIPLAN = "C", ADT_VALCAR, -ADT_VALCAR)) AS VALCAR ');
    LqrySaldoCartaoAdtCli.SQL.Add('FROM ADTCLI ');
    LqrySaldoCartaoAdtCli.SQL.Add('WHERE TRUE ');
    LqrySaldoCartaoAdtCli.SQL.Add('  AND ADT_NUMDOC = :NUMDOC ');
    LqrySaldoCartaoAdtCli.SQL.Add('  AND ADT_ESPDOC = :ESPDOC ');
    LqrySaldoCartaoAdtCli.SQL.Add('  AND ADT_CODEMP = :CODEMP ');
    LqrySaldoCartaoAdtCli.ParamByName('NUMDOC').AsString := AstrNumDoc;
    LqrySaldoCartaoAdtCli.ParamByName('ESPDOC').AsString := AstrEspDoc;
    LqrySaldoCartaoAdtCli.ParamByName('CODEMP').AsString := AstrCodEmp;
    LqrySaldoCartaoAdtCli.Open;

    Result := LqrySaldoCartaoAdtCli.FieldByName('VALCAR').AsFloat ;

  finally
    FreeandNil(LqrySaldoCartaoAdtCli);
  end;
end;

function TLinkPagamentoCitelClass.fImpCupom(AstrViaCli, AstrViaLoj: String): Boolean;
var
  LintQtdVias, LintContVias : Integer;
begin
  Result := False;

  LintQtdVias := 1;
  if not fEmptyStr(fCfgSisL('QTDVIA')) then
    LintQtdVias := StrToInt(fCfgSisL('QTDVIA'));

  for LintContVias := 1 to LintQtdVias do
  begin
    if fCfgSisL('TIPVIA') = 'A' then
    begin
      pImprimirCliente(AstrViaCli, AstrViaLoj);
      pImprimirLojista(AstrViaCli, AstrViaLoj);
      Result := True;
    end;

    if fCfgSisL('TIPVIA') = 'C' then
    begin
      pImprimirCliente(AstrViaCli, AstrViaLoj);
      Result := True;
    end;

    if fCfgSisL('TIPVIA') = 'E' then
    begin
      pImprimirLojista(AstrViaCli, AstrViaLoj);
      Result := True;
    end;
  end;

  if LintQtdVias = 0 then
    Result := True;
end;

function TLinkPagamentoCitelClass.fImprimiLinkCancelamento(const AstrNsu,
  AstrNit: String): Boolean;
var
  LstrComprovanteLoja, LstrComprovanteCliente: String ;
begin
  LstrComprovanteLoja := TLinkPagamentoCitelRepositorio.fGetComprovanteCancLoja(AstrNsu, AstrNit) ;
  LstrComprovanteCliente := TLinkPagamentoCitelRepositorio.fGetComprovanteCancCliente(AstrNsu, AstrNit) ;

  Result := fImpCupom(LstrComprovanteCliente, LstrComprovanteLoja) ;
end;

class function TLinkPagamentoCitelClass.fDocumentoLinkPagamentoCitel(strNumDoc, strEspDoc,
  strCodEmp, strCodCli, strOrigem: string): Boolean;
var
  qryAux: TUniQuery;
begin
  Result := False;

  qryAux := fCriaQuery;
  try
    if strOrigem = 'PD' then
    begin
      qryAux.Close;
      qryAux.SQL.Text :=
      ' SELECT '+
      '   EG.* '+
      ' FROM '+
      '   EXTGOR EG '+
      '   INNER JOIN FATGOR FG '+
      '     ON (FG.AUTOINCREM = EG.FGO_SEQFGO) '+
      ' WHERE FG.FGO_NUMDOC = :NUMDOC '+
      '   AND FG.FGO_ESPDOC = :ESPDOC '+
      '   AND FG.FGO_CODEMP = :CODEMP '+
      '   AND EG.FGO_TIPREC IN (' + TLinkPagamentoCitelFornecedores.fParamSqlLinkPagamentoCitel + ') ';
      qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.Open;

      if not qryAux.IsEmpty then
        Result := True;
    end
    else if strOrigem = 'AGR' then
    begin
      qryAux.Close ;
      qryAux.SQL.Clear ;
      qryAux.SQL.Add(' SELECT CADREC.AUTOINCREM ') ;
      qryAux.SQL.Add(' FROM CADREC INNER JOIN SITDOC ON CADREC.AUTOINCREM = SITDOC.DOC_NUMDOC ') ;
      qryAux.SQL.Add(' WHERE SITDOC.DOC_TIPLAN = :TIPLAN ') ;
      qryAux.SQL.Add('       AND CADREC.CTR_NUMDUP = :NUMDUP ') ;
      qryAux.SQL.Add('       AND CADREC.CTR_ESPDOC = :ESPDOC ') ;
      qryAux.SQL.Add('       AND CADREC.CTR_CODCLI = :CODCLI ') ;
      qryAux.SQL.Add('       AND CADREC.CTR_CODEMP = :CODEMP ') ;
      qryAux.SQL.Add('       AND SITDOC.DOC_TIPREC IN (' + TLinkPagamentoCitelFornecedores.fParamSqlLinkPagamentoCitel + ') ') ;
      qryAux.ParamByName('NUMDUP').AsString := strNumDoc;
      qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
      qryAux.ParamByName('CODEMP').AsString := strCodEmp;
      qryAux.ParamByName('CODCLI').AsString := strCodCli;
      qryAux.ParamByName('TIPLAN').AsString := strOrigem;
      qryAux.Open;

      if not qryAux.IsEmpty then
        Result := True;
    end ;

  finally
    qryAux.Free;
  end;
end;

function TLinkPagamentoCitelClass.fExpiraLinkPagamento(
  const AstrNit: String): Boolean;
var
  LObjLink: ILinkPagamentoCitel ;
begin
  try
    LObjLink := fCriarLinkPagamentoCitel ;
    Result := LObjLink.fExpirarLinkPagamento(AstrNit) ;
  except
    Result := False;
  end;
end;

{$IFNDEF LINUX}
class function TLinkPagamentoCitelClass.fPossuiAdiantamentoLinkPagamentoCitel(strNumDoc, strEspDoc,
  strCodEmp: string): Boolean;
var
  recTotaisAdiantamento: TTotaisAdiantamento;
begin
  Result := False;

  if TLinkPagamentoCitelClass.fDocumentoLinkPagamentoCitel(strNumDoc, strEspDoc, strCodEmp, '', 'PD') then
  begin
    recTotaisAdiantamento := TAdiantamento.fGetTotaisAdiantamento(strNumDoc,
                                                                  strEspDoc,
                                                                  VS_strCodEmp);

    if (recTotaisAdiantamento.blnExiAdt) then
    begin
      if (recTotaisAdiantamento.fltValLan > 0) Then
      begin
        fMensagem('ATENÇÃO!', 'O pedido '+strNumDoc+'-'+strEspDoc+
                              ' já possui adiantamento gerado pelo Link Pagamentos Citel. Sendo assim, sua alteração não é permitida. '+
                              'Se for necessário, cancele o pedido e refaça o processo.', ['&OK']);

        Result := True;
      end;
    end;
  end;
end;
{$ENDIF}

{$IFNDEF LINUX}
class function TLinkPagamentoCitelClass.fProcessaCancelamento(const AstrNumDoc, AstrEspDoc,
  AstrCodEmp: string): Boolean;
var
  LfrmPgtoOnlineESiTefManutencao : TfrmPgtoOnlineESiTefManutencao;
  LfrmStatusTransacao: String ;
begin
  Result := False ;

  LfrmStatusTransacao := fRetornaStatusPedidoLinkPagamentoCitel(AstrNumDoc, AstrEspDoc, AstrCodEmp) ;

  if LfrmStatusTransacao = stAguardandoUsuario then
  begin
    fMensagem('ATENÇÃO!', 'Documento (' + AstrNumDoc + ') com link de pagamento em Aguardando Usuário!'+#13+#10+'Aguarde o link expirar ou desvicule-o para cancelar o pedido!', ['&OK']);
    Exit ;
  end ;

  if (MatchStr(LfrmStatusTransacao, [stTransacaoRecente, stTransacaoRecenteEmailNaoEnviado])) then
  begin
    fMensagem('ATENÇÃO!', 'Documento (' + AstrNumDoc + ') com link de pagamento em Transação Recente!'+#13+#10+'Aguarde o link expirar ou desvicule-o para cancelar o pedido!', ['&OK']);
    Exit ;
  end ;

  if LfrmStatusTransacao <> stTransacaoEfetuada then
    Exit(True) ;

  if fMensagem('', 'Documento (' + AstrNumDoc + ') com Link de Pagamento Quitado '+#13+#10'Deseja Cancelar o Pagamento?', ['&Sim', '&Não'], 2) = 2 then
      exit ;

  pCriarFormularios(TfrmPgtoOnlineESiTefManutencao, LfrmPgtoOnlineESiTefManutencao);
  Try
    LfrmPgtoOnlineESiTefManutencao.NumDoc := AstrNumDoc ;
    LfrmPgtoOnlineESiTefManutencao.EspDoc := AstrEspDoc ;
    LfrmPgtoOnlineESiTefManutencao.CodEmp := AstrCodEmp ;
    LfrmPgtoOnlineESiTefManutencao.ShowModal;

    Result := LfrmPgtoOnlineESiTefManutencao.Confirmado ;

  Finally
    pFreeAndNil(LfrmPgtoOnlineESiTefManutencao);
  End;
end;
{$ENDIF}

class function TLinkPagamentoCitelClass.fRetornaStatusPedidoLinkPagamentoCitel(const AstrNumDoc,
  AstrEspDoc, AstrCodEmp: string): string;
var
  LqryAux: TUniQuery;
begin
  Result := '';

  LqryAux := fCriaQuery;
  try
    LqryAux.Close;
    LqryAux.SQL.Clear ;
    LqryAux.SQL.Add(' SELECT ') ;
    LqryAux.SQL.Add('   S.SIT_STATUS ') ;
    LqryAux.SQL.Add(' FROM SITCOB S ') ;
    LqryAux.SQL.Add('      INNER JOIN EXTGOR EG ON S.SIT_NUMNIT = EG.FGO_SITNIT AND S.SIT_MERCID = EG.FGO_SITMID ') ;
    LqryAux.SQL.Add('      INNER JOIN FATGOR F  ON F.AUTOINCREM = EG.FGO_SEQFGO ') ;
    LqryAux.SQL.Add(' WHERE F.FGO_NUMDOC = :NUMDOC AND F.FGO_ESPDOC = :ESPDOC AND F.FGO_CODEMP = :CODEMP ') ;
    LqryAux.ParamByName('NUMDOC').AsString := AstrNumDoc;
    LqryAux.ParamByName('ESPDOC').AsString := AstrEspDoc;
    LqryAux.ParamByName('CODEMP').AsString := AstrCodEmp;
    LqryAux.Open;

    if not LqryAux.IsEmpty then
      Result := LqryAux.FieldByName('SIT_STATUS').AsString ;

  finally
    FreeAndNil(LqryAux);
  end;
end;

class function TLinkPagamentoCitelClass.fTemAdcliTransformadoEmCC(
  const AstrNumDoc, AstrEspDoc, AstrCodEmp: string): Boolean;
var
  LfltSaldoCartaoAdtCli: Double;
  LqryCC: TUniQuery ;
begin
  Result := False ;

  if fRetornaStatusPedidoLinkPagamentoCitel(AstrNumDoc, AstrEspDoc, AstrCodEmp) <> stTransacaoEfetuada then
    Exit;

  LfltSaldoCartaoAdtCli := TLinkPagamentoCitelClass.fGetTotaisAdiantamento(AstrNumDoc, AstrEspDoc, AstrCodEmp);

  if fFormataFloat(LfltSaldoCartaoAdtCli, 0) <> 0.00 then
    Exit ;

  LqryCC := fCriaQuery() ;
  try
    LqryCC.Close ;
    LqryCC.SQL.Clear ;
    LqryCC.SQL.Add(' SELECT LOGCTR.CTR_NUMDUP, LOGCTR.CTR_CODCLI, LOGCTR.CTR_CODEMP ') ;
    LqryCC.SQL.Add(' FROM LOGCTR INNER JOIN ADTCLI ON ADTCLI.ADT_TIPLAN = "D" AND ADTCLI.ADT_SEQCON = LOGCTR.CTR_SEQCON AND ADTCLI.ADT_DTALAN = LOGCTR.CTR_DTACAD ') ;
    LqryCC.SQL.Add(' WHERE LOGCTR.CTR_ESPDOC = "CC" AND ') ;
    LqryCC.SQL.Add('       LOGCTR.CTR_DESCRI = "INCLUSÃO" AND ') ;
    LqryCC.SQL.Add('       ADTCLI.ADT_NUMDOC = :NUMDOC AND ') ;
    LqryCC.SQL.Add('       ADTCLI.ADT_CODEMP = :CODEMP AND ') ;
    LqryCC.SQL.Add('       ADTCLI.ADT_ESPDOC = :ESPDOC ') ;
    LqryCC.ParamByName('NUMDOC').AsString := AstrNumDoc ;
    LqryCC.ParamByName('CODEMP').AsString := AstrCodEmp ;
    LqryCC.ParamByName('ESPDOC').AsString := AstrEspDoc ;
    LqryCC.Open ;

    Result := (not LqryCC.IsEmpty) ;

  finally
    FreeAndNil(LqryCC) ;
  end ;

end;

class function TLinkPagamentoCitelClass.fTemSaldoSuficienteAdtCli(
  const AstrNumDoc, AstrEspDoc, AstrCodEmp: string): Boolean;
var
  LfltSaldoCartaoAdtCli: Double;
  LqryPedido: TUniQuery ;
  LstrMensagem: String ;
begin
  if fRetornaStatusPedidoLinkPagamentoCitel(AstrNumDoc, AstrEspDoc, AstrCodEmp) <> stTransacaoEfetuada then
  begin
    Result := True;
    Exit;
  end;

  Result := False;

  LqryPedido := fCriaQuery(nil);
  try
    LfltSaldoCartaoAdtCli := TLinkPagamentoCitelClass.fGetTotaisAdiantamento(AstrNumDoc, AstrEspDoc, AstrCodEmp);

    LqryPedido.Close ;
    LqryPedido.SQL.Clear ;
    LqryPedido.SQL.Add('SELECT FGO_VLRCON FROM FATGOR WHERE FGO_NUMDOC = :NUMDOC AND FGO_ESPDOC = :ESPDOC AND FGO_CODEMP = :CODEMP');
    LqryPedido.ParamByName('NUMDOC').AsString := AstrNumDoc;
    LqryPedido.ParamByName('ESPDOC').AsString := AstrEspDoc;
    LqryPedido.ParamByName('CODEMP').AsString := AstrCodEmp;
    LqryPedido.Open;

    if LfltSaldoCartaoAdtCli < LqryPedido.FieldByName('FGO_VLRCON').AsFloat then
    begin
      LstrMensagem := 'Documento ('+AstrNumDoc+') com Link de Pagamento quitado sem saldo de adiantamento.'+#13+#10 ;
      LstrMensagem := LstrMensagem + 'Favor acessar a rotina:'+#13+#10 ;
      LstrMensagem := LstrMensagem + '"> Principal > Controle Financeiro > Contas a Receber > Consultar Adiantamentos de Cliente"'+#13+#10 ;
      LstrMensagem := LstrMensagem + 'Verifique o motivo do pedido não conter saldo de adiantamento.' ;

      fMensagem('ATENÇÃO!',LstrMensagem, ['&O K']);
      exit;
    end;

    Result := True;
  finally
    FreeAndNil(LqryPedido) ;
  end;
end;

function TLinkPagamentoCitelClass.fVerificaEstrutura: Boolean;
  var
    qryAux: TUniQuery;
begin
  Result := False;

  qryAux := fCriaQuery;
  try
    qryAux.Close;
    qryAux.SQL.Text :=
    ' SELECT '+
    '   * '+
    ' FROM FATGOR F '+
    '   INNER JOIN ADTCLI A '+
    '     ON  F.FGO_NUMDOC = A.ADT_NUMDOC '+
    '     AND F.FGO_ESPDOC = A.ADT_ESPDOC '+
    '     AND F.FGO_CODEMP = A.ADT_CODEMP '+
    ' WHERE '+
    '   F.FGO_NUMDOC = :NUMDOC AND '+
    '   F.FGO_ESPDOC = :ESPDOC AND '+
    '   F.FGO_CODEMP = :CODEMP     ';

    qryAux.ParamByName('NUMDOC').AsString := Self.strNumDoc;
    qryAux.ParamByName('ESPDOC').AsString := Self.strEspDoc;
    qryAux.ParamByName('CODEMP').AsString := Self.strCodEmp;

    qryAux.Open;

    if not qryAux.IsEmpty then
      Result := True;

  finally
    FreeAndNil(qryAux);
  end;
end;

function TLinkPagamentoCitelClass.fCancelaLinkPagamentoCielo(
  const AstrNit, AstrOrigem: String; var AstrMsgErro: String;
  const AstrNumCCD: String): Boolean;
var
  LobjLinkPagamentoCitelEnvio : TLinkPagamentoCitelEnvio;
  LstrJSONRetCanc, LstrJSONReqCanc : String ;
  LjsonEfetivaCancel: TJSONObject ;
  LintCodigoRetorno: Integer ;
begin
  Result := False ;

  LobjLinkPagamentoCitelEnvio := TLinkPagamentoCitelEnvio.Create;
  try
    LjsonEfetivaCancel := LobjLinkPagamentoCitelEnvio.fEfetuarCancelamento(AstrNit, '', '', LstrJSONRetCanc, LstrJSONReqCanc) ;
    if Assigned(LjsonEfetivaCancel) then
    begin
      try
        AstrMsgErro := LjsonEfetivaCancel.GetValue<String>('message') ;
        LintCodigoRetorno := LjsonEfetivaCancel.GetValue<Integer>('code') ;
        if (LintCodigoRetorno = 0) or (LintCodigoRetorno = 3) then
        begin
          try
            Result := TLinkPagamentoCitelModel.fEstornaTrasacao(
              AstrNit,
              '',
              '',
              LstrJSONReqCanc,
              LstrJSONRetCanc,
              AstrNit,
              '',
              '',
              '',
              AstrOrigem
            ) ;

            if Result then //estorna o adtcli e movcar
            begin
              if AstrOrigem = 'PD' then
                pProcessarEstorno(LjsonEfetivaCancel.GetValue<double>('amount')/100, AstrNumCCD) ;
            end ;
          except
            Result := False;
            AstrMsgErro := 'Erro ao gravar cancelamento do link de pagamento.' + #13#10 + 'Entre em contato com o Suporte Citel!' ;
          end;

        end ;
      finally
        FreeAndNil(LjsonEfetivaCancel) ;
      end ;
    end ;
  finally
    FreeAndNil(LobjLinkPagamentoCitelEnvio) ;
  end ;
end;

function TLinkPagamentoCitelClass.fCancelaLinkPagamentoCredPay(const AstrNit,
  AstrOrigem: String; var AstrMsgErro: String;
  const AstrNumCCD: String): Boolean;
var
  LobjLinkPagamentoCitelEnvio : TLinkPagamentoCitelEnvio;
  LstrJSONRetCanc, LstrJSONReqCanc : String ;
  LjsonEfetivaCancel: TJSONObject ;
  LintCodigoRetorno: Integer ;
  LfltValor: Double ;
begin
  Result := False ;

  LobjLinkPagamentoCitelEnvio := TLinkPagamentoCitelEnvio.Create;
  try
    LjsonEfetivaCancel := LobjLinkPagamentoCitelEnvio.fEfetuarCancelamento(AstrNit, '', '', LstrJSONRetCanc, LstrJSONReqCanc) ;
    if Assigned(LjsonEfetivaCancel) then
    begin
      try
        AstrMsgErro := LjsonEfetivaCancel.GetValue<String>('message') ;
        LintCodigoRetorno := LjsonEfetivaCancel.GetValue<Integer>('code') ;
        if fCodigoRetornoCancelamentoValido(LintCodigoRetorno) then
        begin
          try
            Result := TLinkPagamentoCitelModel.fEstornaTrasacao(
              AstrNit,
              '',
              '',
              LstrJSONReqCanc,
              LstrJSONRetCanc,
              AstrNit,
              '',
              '',
              '',
              AstrOrigem
            ) ;

            if Result then //estorna o adtcli e movcar
            begin
              if (AstrOrigem = 'PD') then
              begin
                LfltValor := fStrToFloat(LjsonEfetivaCancel.GetValue<string>('amount')) ;
                pProcessarEstorno(LfltValor/100, AstrNumCCD);
              end ;
            end ;
          except
            Result := False;
            AstrMsgErro := 'Erro ao gravar cancelamento do link de pagamento.' + #13#10 + 'Entre em contato com o Suporte Citel!' ;
          end;

        end ;
      finally
        FreeAndNil(LjsonEfetivaCancel) ;
      end ;
    end ;
  finally
    FreeAndNil(LobjLinkPagamentoCitelEnvio) ;
  end ;
end;

function TLinkPagamentoCitelClass.fCancelaLinkPagamentoIpag(const AstrNit,
  AstrOrigem: String; var AstrMsgErro: String;
  const AstrNumCCD: String): Boolean;
var
  LobjLinkPagamentoCitelEnvio : TLinkPagamentoCitelEnvio;
  LstrJSONRetCanc, LstrJSONReqCanc : String ;
  LjsonEfetivaCancel: TJSONObject ;
  LfltValor: Double ;
begin
  Result := False ;

  LobjLinkPagamentoCitelEnvio := TLinkPagamentoCitelEnvio.Create;
  try
    LjsonEfetivaCancel := LobjLinkPagamentoCitelEnvio.fEfetuarCancelamento(AstrNit, '', '', LstrJSONRetCanc, LstrJSONReqCanc) ;
    if Assigned(LjsonEfetivaCancel) then
    begin
      try
        AstrMsgErro := LjsonEfetivaCancel.GetValue<String>('message') ;
        try
          Result := TLinkPagamentoCitelModel.fEstornaTrasacao(
            AstrNit,
            '',
            '',
            LstrJSONReqCanc,
            LstrJSONRetCanc,
            AstrNit,
            '',
            '',
            '',
            AstrOrigem);

          if Result then //estorna o adtcli e movcar
          begin
            if (AstrOrigem = 'PD') then
            begin
              LfltValor := fStrToFloat(LjsonEfetivaCancel.GetValue<string>('amount')) ;
              pProcessarEstorno(LfltValor/100,
                                AstrNumCCD);
            end ;
          end ;
        except
          Result := False;
          AstrMsgErro := 'Erro ao gravar cancelamento do link de pagamento.' + #13#10 + 'Entre em contato com o Suporte Citel!' ;
        end;
      finally
        FreeAndNil(LjsonEfetivaCancel) ;
      end ;
    end ;
  finally
    FreeAndNil(LobjLinkPagamentoCitelEnvio) ;
  end ;
end;

function TLinkPagamentoCitelClass.fCancelaLinkPagamentoSitef(const AstrNsu,
  AstrNit, AstrNumCCD, AstrNumeroCartao, AstrVencCartao, AstrOrigem: String;
  var AstrMsgErro: String): Boolean ;
var
  LobjLinkPagamentoCitelEnvio : TLinkPagamentoCitelEnvio;
  LstrJSONRet, LstrJSONReq : String ;
  LjsonCriaCancel, LjsonEfetivaCancel: TJSONObject ;
  LjsonNit: TJSONObject ;
  LstrJSONRetCanc, LstrJSONReqCanc : String ;
begin
  Result := False ;
  LjsonCriaCancel := Nil ;
  LjsonEfetivaCancel := Nil ;
  LstrJSONRet := '' ;
  LstrJSONReq := '' ;
  LstrJSONRetCanc := '' ;
  LstrJSONReqCanc := '' ;
  // inicia o processo de cancelamento
  LobjLinkPagamentoCitelEnvio := TLinkPagamentoCitelEnvio.Create;
  try
    LjsonCriaCancel := LobjLinkPagamentoCitelEnvio.fCriarCancelamento(AstrNsu, AstrNit, LstrJSONRet, LstrJSONReq) ;
    if Assigned(LjsonCriaCancel) then
    begin
      AstrMsgErro := LjsonCriaCancel.GetValue<String>('message') ;
      if LjsonCriaCancel.GetValue<Integer>('code') = 0 then
      begin
        LjsonNit := LjsonCriaCancel.GetValue<TJSONObject>('cancellation') ;
        LjsonEfetivaCancel := LobjLinkPagamentoCitelEnvio.fEfetuarCancelamento(LjsonNit.GetValue<String>('nit'), AstrNumeroCartao, AstrVencCartao, LstrJSONRetCanc, LstrJSONReqCanc) ;
        if Assigned(LjsonEfetivaCancel) then
        begin
          AstrMsgErro := LjsonEfetivaCancel.GetValue<String>('message') ;
          if LjsonEfetivaCancel.GetValue<Integer>('code') = 0 then
          begin
            LjsonNit := LjsonEfetivaCancel.GetValue<TJSONObject>('cancellation') ;
            try
              Result := TLinkPagamentoCitelModel.fEstornaTrasacao(
                AstrNit,
                LstrJSONReq,
                LstrJSONRet,
                LstrJSONReqCanc,
                LstrJSONRetCanc,
                LjsonNit.GetValue<String>('nit'),
                LjsonNit.GetValue<String>('esitef_usn'),
                LjsonNit.GetValue<String>('merchant_receipt'),
                LjsonNit.GetValue<String>('customer_receipt'),
                AstrOrigem) ;
              if Result then //estorna o adtcli e movcar
              begin
                if AstrOrigem = 'PD' then
                  pProcessarEstorno(LjsonNit.GetValue<double>('amount')/100, AstrNumCCD) ;
              end ;
            Except
              On E: Exception Do
              Begin
                Result := False;
                AstrMsgErro := e.Message ;
              End;
            End;
          end ;
        end ;
      end ;
    end ;

    if not Result then
    begin
      TLinkPagamentoCitelModel.fEstornaTrasacao(
            AstrNit,
            LstrJSONReq,
            LstrJSONRet,
            LstrJSONReqCanc,
            LstrJSONRetCanc,
            '',
            '',
            '',
            '',
            AstrOrigem) ;
    end ;

  finally
    FreeAndNil(LobjLinkPagamentoCitelEnvio) ;
    if Assigned(LjsonCriaCancel) then
      FreeAndNil(LjsonCriaCancel) ;
    if Assigned(LjsonEfetivaCancel) then
      FreeAndNil(LjsonEfetivaCancel) ;
  end ;
end;

function TLinkPagamentoCitelClass.fCodigoRetornoCancelamentoValido(
  const AintCodigo: Integer): Boolean;
begin
  Result := True ;
  if AintCodigo = 0 then
    Exit ;

  if AintCodigo = 3 then
    Exit ;

  if AintCodigo = CODIGO_CANCELAMENTO_TRANSACAO_VINDI_AGUARDANDO then
    Exit ;

  Result := False ;
end;

procedure TLinkPagamentoCitelClass.pCarregaPedidoLinkPagamentoCitel(strNumDoc, strEspDoc, strCodEmp: string);
var
  qryAux: TUniQuery;
begin
  Self.strTipRec := '';
  Self.strNumDoc := '';
  Self.strEspDoc := '';
  Self.strCodEmp := '';

  qryAux := fCriaQuery;
   try
     qryAux.Close;
     qryAux.SQL.Text :=
     ' SELECT '+
     '   E.FGO_TIPREC, F.FGO_NUMDOC, F.FGO_ESPDOC, F.FGO_CODEMP, F.FGO_CODCLI '+
     ' FROM FATGOR F '+
     '   INNER JOIN EXTGOR E '+
     '     ON F.AUTOINCREM = E.FGO_SEQFGO '+
     ' WHERE '+
     ' ( FGO_NUMDOC = :NUMDOC AND '+
     '   FGO_ESPDOC = :ESPDOC AND'+
     '   FGO_CODEMP = :CODEMP ) ';

     qryAux.ParamByName('NUMDOC').AsString := strNumDoc;
     qryAux.ParamByName('ESPDOC').AsString := strEspDoc;
     qryAux.ParamByName('CODEMP').AsString := strCodEmp;

     qryAux.Open;

     if not qryAux.IsEmpty then
     begin
       Self.strTipRec := qryAux.FieldByName('FGO_TIPREC').AsString;
       Self.strNumDoc := qryAux.FieldByName('FGO_NUMDOC').AsString;
       Self.strEspDoc := qryAux.FieldByName('FGO_ESPDOC').AsString;
       Self.strCodEmp := qryAux.FieldByName('FGO_CODEMP').AsString;
       Self.strCodCli := qryAux.FieldByName('FGO_CODCLI').AsString;
     end;
   finally
     FreeAndNil(qryAux);
   end;

end;

procedure TLinkPagamentoCitelClass.pClassificaTipoDocumento(
  var ArecInfoDoc: TInfoDocumentoLinkPagamentoCitel;
  const AstrNumNit, AstrMercId : String);
var
  LstrDocumentos: String ;
  LstrTipLan: String ;
begin
  FillChar(ArecInfoDoc, SizeOf(ArecInfoDoc), #0);
  //pedidos
  LstrDocumentos := fGetSeqFgoPedidos(AstrNumNit, AstrMercId) ;
  if not fEmptyStr(LstrDocumentos) then
  begin
    ArecInfoDoc.Tipo := 'PD' ;
    ArecInfoDoc.Documentos := LstrDocumentos ;
    Exit ;
  end ;
  //SitDoc
  LstrDocumentos := fGetAutoIncSitDoc(AstrNumNit, AstrMercId, LstrTipLan) ;
  if not fEmptyStr(LstrDocumentos) then
  begin
    ArecInfoDoc.Tipo := LstrTipLan ;
    ArecInfoDoc.Documentos := LstrDocumentos ;
    Exit ;
  end ;
end;

procedure TLinkPagamentoCitelClass.pExcluirMovCar(const AstrNumCCD: String);
var
  LqryExec: TUniQuery ;
  LqryDelMovBan: TUniQuery ;
begin
  LqryExec := fCriaQuery() ;
  LqryDelMovBan := fCriaQuery;
  try
    LqryExec.SQL.Clear ;
    LqryExec.SQL.Add(' SELECT * FROM MOVCAR ') ;
    LqryExec.SQL.Add('     WHERE MCA_CODEMP = :CODEMP AND ') ;
    LqryExec.SQL.Add('           MCA_NUMCCD = :NUMCCD AND ') ;
    LqryExec.SQL.Add('           MCA_CODCLI = :CODCLI ') ;
    if fCfgSis('LINKPG') = '2' then
    begin
      LqryExec.SQL.Add('           AND MCA_CODCAR = :CODCAR ') ;
      LqryExec.ParamByName('CODCAR').AsString := fCfgSis('CARSIT', varString) ;
    end ;
    LqryExec.ParamByName('CODEMP').AsString := FstrCodEmp ;
    LqryExec.ParamByName('NUMCCD').AsString := AstrNumCCD ;
    LqryExec.ParamByName('CODCLI').AsString := FstrCodCli ;
    LqryExec.Open ;
    LqryExec.First ;
    while not LqryExec.Eof do
    begin
      LqryDelMovBan.Close ;
      LqryDelMovBan.SQL.Clear ;
      LqryDelMovBan.SQL.Add('SELECT * FROM MOVBAN WHERE CTB_SEQTRF = :SEQTRF AND CTB_ORIGEM = :ORIGEM AND CTB_CODEMP = :CODEMP') ;
      LqryDelMovBan.ParamByName('CODEMP').AsString := FstrCodEmp ;
      LqryDelMovBan.ParamByName('ORIGEM').AsString := 'TRF' ;
      LqryDelMovBan.ParamByName('SEQTRF').AsString := LqryExec.FieldByName('MCA_SEQCON').AsString ;
      LqryDelMovBan.Open ;
      if not LqryDelMovBan.IsEmpty then
      begin
        fVerificaIntegridade('LINK PAGAMENTO', 'MOVBAN', LqryDelMovBan, True);
        LqryDelMovBan.Delete ;
      end ;

      fVerificaIntegridade('LINK PAGAMENTO', 'MOVCAR', LqryExec, True);
      LqryExec.Delete ;
    end ;
  finally
    FreeAndNil(LqryExec) ;
    FreeAndNil(LqryDelMovBan) ;
  end ;
end;

procedure TLinkPagamentoCitelClass.pGravarAdtCliCartao(const AfltValCar: Double;
  const AintSeqConRcx: Integer);
Var
  documento: TDocAdiantamento;
  dadosAdiantamento: TDadosAdiantamento;
  totModalidades: TTotaisAdiantamento;
begin
  FillChar(dadosAdiantamento, SizeOf(dadosAdiantamento), #0);
  FillChar(totModalidades, SizeOf(totModalidades), #0);

  documento.strNumDoc := FstrNumDoc;
  documento.strEspDoc := FstrEspDoc;
  documento.strCodEmp := FstrCodEmp;
  documento.strCodCli := FstrCodCli;
  documento.fltValLan := AfltValCar;

  dadosAdiantamento.AddDocumento(documento);

  dadosAdiantamento.strTipLan := 'D';
  dadosAdiantamento.dtaDtaLan := VS_Date;
  dadosAdiantamento.horHorLan := fTime();
  dadosAdiantamento.strOpeLan := '999';
  dadosAdiantamento.strEmpLan := FstrCodEmp;
  dadosAdiantamento.intSeqCon := AintSeqConRcx;
  dadosAdiantamento.strDescri := 'ESTORNO VIA LINK DE PAGAMENTO ' + UpperCase(TLinkPagamentoCitelFornecedores.fDescricao) + ' ADIANTAMENTO PEDIDO: ' + FstrNumDoc + '-' + FstrEspDoc;
  dadosAdiantamento.fltValDin := 0.00;
  dadosAdiantamento.fltValChV := 0.00;
  dadosAdiantamento.fltValChP := 0.00;
  dadosAdiantamento.fltValOrd := 0.00;
  dadosAdiantamento.fltValFin := 0.00;
  dadosAdiantamento.fltValCre := 0.00;
  dadosAdiantamento.fltValCar := AfltValCar;
  dadosAdiantamento.fltValLan := AfltValCar;

  TAdiantamentoGenerico.fGravaAdiantamentoCliente(dadosAdiantamento);

end;

procedure TLinkPagamentoCitelClass.pImprimirCliente(AstrViaCli, AstrViaLoj: String);
begin
{$IFNDEF LINUX}
  if not fEmptyStr(AstrViaCli) then
    pImprimirTef(AstrViaCli, '')
  else
    pImprimirTef(AstrViaLoj, '');
{$ENDIF}
end;

procedure TLinkPagamentoCitelClass.pImprimirLojista(AstrViaCli, AstrViaLoj: String);
begin
{$IFNDEF LINUX}
  if not fEmptyStr(AstrViaLoj) then
    pImprimirTef(AstrViaLoj, '')
  else
    pImprimirTef(AstrViaCli, '');
{$ENDIF}
end;

procedure TLinkPagamentoCitelClass.pProcessarEstorno(const AfltValCar: Double; const AstrNumCCD: String);
begin
  pExcluirMovCar(AstrNumCCD) ;
  pGravarAdtCliCartao(AfltValCar, StrToInt(fRetRcxCon(FstrCodEmp))) ;
end;

function TLinkPagamentoCitelClass.fCancelaLinkPagamento(const AstrNsu,
  AstrNit, AstrNumCCD, AstrNumeroCartao, AstrVencCartao, AstrOrigem: String;
  var AstrMsgErro: String): Boolean;
begin
  Result := False ;
  fStartTransaction;
  try
    if fCfgSis('LINKPG') = '2' then
      Result := fCancelaLinkPagamentoSitef(AstrNsu, AstrNit, AstrNumCCD, AstrNumeroCartao, AstrVencCartao, AstrOrigem, AstrMsgErro)
    else if fCfgSis('LINKPG') = '3' then
      Result := fCancelaLinkPagamentoCielo(AstrNit, AstrOrigem, AstrMsgErro, AstrNumCCD)
    else if fCfgSis('LINKPG') = '5' then
      Result := fCancelaLinkPagamentoCredPay(AstrNit, AstrOrigem, AstrMsgErro, AstrNumCCD)
    else if fCfgSis('LINKPG') = '7' then
      Result := fCancelaLinkPagamentoIpag(AstrNit, AstrOrigem, AstrMsgErro, AstrNumCCD) ;

    if Result then
    begin
      TLinkPagamentoCitelModel.fDesvinculaPedido(Self.FstrNumDoc, Self.FstrEspDoc, Self.FstrCodEmp, Self.FstrCodCli, Self.FstrOrigem, Self.FstrNumNit, False) ;
      fCommit ;
    end
    else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack;
    End;
  End;
end;

function TLinkPagamentoCitelClass.fDesvinculaLinkPagamentoPedido: Boolean;
begin
  fStartTransaction;
  try
    Result := TLinkPagamentoCitelModel.fDesvinculaPedido(Self.FstrNumDoc, Self.FstrEspDoc, Self.FstrCodEmp, Self.FstrCodCli, Self.FstrOrigem, Self.FstrNumNit) ;

    if Result then
      fCommit
    else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
    End;
  End;
end;

function TLinkPagamentoCitelClass.fGeraNovoLinkPagamento(strNumNitOld, strMercIdOld, strCodEmpOld,
  strCodOpe, strTipTra : String; intQtdPar, intTpParc : Integer; fltValCar : Double;
  var strNewNit, AstrRetornoMsgErro : String) : Boolean;
  var
    objPgtOnESiTefEnvio : TLinkPagamentoCitelEnvio;
    LobjResposta: TGerarLinkPagamentoResposta;
    LrecInfoDoc: TInfoDocumentoLinkPagamentoCitel ;
    LdtaExpiracao: TDateTime ;
begin
  Result := False;

  pClassificaTipoDocumento(LrecInfoDoc, strNumNitOld, strMercIdOld) ;
  LdtaExpiracao := IncDay(fNow) ;

  objPgtOnESiTefEnvio := TLinkPagamentoCitelEnvio.Create;
  try
    LobjResposta := objPgtOnESiTefEnvio.fGerarLinkPagamento(strTipTra, intQtdPar,
      IntToStr(intTpParc), fltValCar, AstrRetornoMsgErro, LrecInfoDoc, LdtaExpiracao);

    if not Assigned(LobjResposta) then
      Exit;

    try
      try
        fStartTransaction;

        strNewNit := LobjResposta.IdLink ;

        Result := TLinkPagamentoCitelModel.fNovaTransacao(strCodEmp,
                                                   LobjResposta.Url,
                                                   LobjResposta.IdLink,
                                                   LobjResposta.Nsu,
                                                   strCodOpe,
                                                   Date,
                                                   fTime(),
                                                   TLinkPagamentoCitelRepositorio.fGetMerchantId,
                                                   fltValCar,
                                                   fGetSeqFgoPedidos(strNumNitOld, strMercIdOld),
                                                   objPgtOnESiTefEnvio.strJSONRequest,
                                                   objPgtOnESiTefEnvio.strJSONResponse,
                                                   intQtdPar, self.FstrOrigem, self.FstrAutIncs,
                                                   LdtaExpiracao);

        TLinkPagamentoCitelModel.pRemoveTransacao(strNumNitOld, strMercIdOld, strCodEmpOld);

        if not Result then
          raise Exception.Create('Erro na gravação');

        fCommit;
      except
        Result := False;
        AstrRetornoMsgErro := 'Erro na gravação do link de pagamento.' + #13#10 + 'Entre em contato com o Suporte Citel!';
        fRollback;
      end;
    finally
      FreeAndNil(LobjResposta);
    end;
  finally
    FreeAndNil(objPgtOnESiTefEnvio);
  end;
end;

procedure TLinkPagamentoCitelClass.SetstrCodCli(const Value: String);
begin
  FstrCodCli := Value;
end;

procedure TLinkPagamentoCitelClass.SetstrCodEmp(const Value: String);
begin
  FstrCodEmp := Value;
end;

procedure TLinkPagamentoCitelClass.SetstrEspDoc(const Value: String);
begin
  FstrEspDoc := Value;
end;

procedure TLinkPagamentoCitelClass.SetstrNumDoc(const Value: String);
begin
  FstrNumDoc := Value;
end;

procedure TLinkPagamentoCitelClass.SetstrTipRec(const Value: String);
begin
  FstrTipRec := Value;
end;

{ TParChavesLinkPagamento }

{$IFNDEF LINUX}
class procedure TParChavesLinkPagamento.pCarregarChaves(var AstrChavePrivada,
  AstrChavePublica: String);
var
  LqryConsulta: TUniQuery ;
begin
  AstrChavePrivada := '' ;
  AstrChavePublica := '' ;
  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close();
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add('SELECT RSA_CODEMP, RSA_CHVPRV, RSA_CHVPUB FROM LNKRSA WHERE RSA_CODEMP = :CODEMP ') ;
    LqryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp ;
    LqryConsulta.Open ;
    if LqryConsulta.IsEmpty then
    begin
      LqryConsulta.Append ;
      LqryConsulta.FieldByName('RSA_CODEMP').AsString := VS_strCodEmp ;
      LqryConsulta.Post ;
      Exit ;
    end ;

    AstrChavePrivada := fDescriptografarAes256(LqryConsulta.FieldByName('RSA_CHVPRV').AsString) ;
    AstrChavePublica := LqryConsulta.FieldByName('RSA_CHVPUB').AsString ;

  finally
    FreeAndNil(LqryConsulta) ;
  end ;
end;
{$ENDIF}

{$IFNDEF LINUX}
class function TParChavesLinkPagamento.fSalvarChaves(const AstrChavePrivada,
  AstrChavePublica: String): Boolean;
var
  LqryConsulta: TUniQuery ;
begin
  LqryConsulta := fCriaQuery() ;
  try
    LqryConsulta.Close();
    LqryConsulta.SQL.Clear ;
    LqryConsulta.SQL.Add('SELECT RSA_CODEMP, RSA_CHVPRV, RSA_CHVPUB FROM LNKRSA WHERE RSA_CODEMP = :CODEMP ') ;
    LqryConsulta.ParamByName('CODEMP').AsString := VS_strCodEmp ;
    LqryConsulta.Open ;
    if LqryConsulta.IsEmpty then
    begin
      LqryConsulta.Append ;
      LqryConsulta.FieldByName('RSA_CODEMP').AsString := VS_strCodEmp ;
      LqryConsulta.Post ;
    end ;
    LqryConsulta.Edit ;
    LqryConsulta.FieldByName('RSA_CHVPRV').AsString := fCriptografarAes256(AstrChavePrivada) ;
    LqryConsulta.FieldByName('RSA_CHVPUB').AsString := AstrChavePublica ;
    LqryConsulta.Post ;
  finally
    FreeAndNil(LqryConsulta) ;
  end ;
  Result := True ;
end;
{$ENDIF}

end.
