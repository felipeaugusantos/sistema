unit untPgtOnlineESiTef;

interface

uses
  Data.DB, MemDS, DBAccess, Uni, System.SysUtils;

type
  TPgOnESiTef = class
    private
      FstrEspDoc: String;
      FstrNumDoc: String;
      FstrTipRec: String;
      FstrCodEmp: String;
      FstrCodCli: String;
      FstrOrigem: String;
      FstrAutIncs: String;

      procedure SetstrCodEmp(const Value: String);
      procedure SetstrEspDoc(const Value: String);
      procedure SetstrNumDoc(const Value: String);
      procedure SetstrTipRec(const Value: String);
      procedure SetstrCodCli(const Value: String);

      function fGetSeqFgoPedidos(strNumNit, strMercId : String) : String;
      function fImpCupom(AstrViaCli, AstrViaLoj: String): Boolean;
      procedure pImprimirCliente(AstrViaCli, AstrViaLoj : String);
      procedure pImprimirLojista(AstrViaCli, AstrViaLoj : String);
      procedure pProcessarEstorno(const AfltValCar: Double; const AstrNumCCD: String) ;
      procedure pGravarAdtCliCartao(const AfltValCar: Double; const AintSeqConRcx: Integer);
      procedure pExcluirMovCar(const AstrNumCCD: String) ;
      class function fRetornaStatusPedidoESiTef(const AstrNumDoc, AstrEspDoc, AstrCodEmp: string): string ;
    public
      property strTipRec: String read FstrTipRec write SetstrTipRec;
      property strNumDoc: String read FstrNumDoc write SetstrNumDoc;
      property strEspDoc: String read FstrEspDoc write SetstrEspDoc;
      property strCodEmp: String read FstrCodEmp write SetstrCodEmp;
      property strCodCli: String read FstrCodCli write SetstrCodCli;
      property strOrigem: String read FstrOrigem write FstrOrigem;
      property strAutIncs: String read FstrAutIncs write FstrAutIncs;

      procedure pCarregaPedidoPgOnESiTef(strNumDoc, strEspDoc, strCodEmp: string);
      class function fProcessaCancelamento(const AstrNumDoc, AstrEspDoc, AstrCodEmp: string): Boolean ;
      class function fDocumentoPgOnEsiTef(strNumDoc, strEspDoc, strCodEmp, strCodCli, strOrigem: string): Boolean;
      class function fPossuiAdiantamentoPgOnESiTef(strNumDoc, strEspDoc, strCodEmp: string): Boolean;
      function fVerificaEstrutura: Boolean;
      function fGeraNovoLinkPagamento(strNumNitOld, strMercIdOld, strCodEmpOld,
        strCodOpe, strTipTra : String; intQtdPar, intTpParc : Integer; fltValCar : Double;
        var strNewNit, AstrRetornoMsgErro : String) : Boolean;
      function fCancelaLinkPagamento(const AstrNsu, AstrNit, AstrNumCCD, AstrNumeroCartao, AstrVencCartao, AstrOrigem: String; var AstrMsgErro: String): Boolean ;
      function fDesvinculaLinkPagamentoPedido: Boolean;
      function fImprimiLinkCancelamento(const AstrNsu, AstrNit: String): Boolean ;
  end;

  TParChavesLinkPagamento = class
  public
    class procedure pCarregarChaves(var AstrChavePrivada, AstrChavePublica: String) ;
    class function fSalvarChaves(const AstrChavePrivada, AstrChavePublica: String): Boolean ;
  end ;

implementation

uses
  untFuncoesSimples, untAdiantamentoCliente, untTypesSistema,
  untPgtOnlineESiTefModel, untPgtOnlineESiTefEnvio, untPgtOnlineESiTefStatus,
  untPgtOnlineESiTefRepositorio, untLibJWTUtil, Json, untQckFatImpNFCe,
  untAdiantamentoClienteGenerico, untFuncoes, untPgtoOnlineESiTefManutencao,
  System.StrUtils;

{ TPgOnESiTef }

function TPgOnESiTef.fGetSeqFgoPedidos(strNumNit, strMercId : String): String;
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

function TPgOnESiTef.fImpCupom(AstrViaCli, AstrViaLoj: String): Boolean;
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

function TPgOnESiTef.fImprimiLinkCancelamento(const AstrNsu,
  AstrNit: String): Boolean;
var
  LstrComprovanteLoja, LstrComprovanteCliente: String ;
begin
  LstrComprovanteLoja := TPgtOnlineESiTefRepositorio.fGetComprovanteCancLoja(AstrNsu, AstrNit) ;
  LstrComprovanteCliente := TPgtOnlineESiTefRepositorio.fGetComprovanteCancCliente(AstrNsu, AstrNit) ;

  Result := fImpCupom(LstrComprovanteCliente, LstrComprovanteLoja) ;
end;

class function TPgOnESiTef.fDocumentoPgOnEsiTef(strNumDoc, strEspDoc,
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
      '   AND EG.FGO_TIPREC = "ESIT" ';
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
      qryAux.SQL.Add('       AND SITDOC.DOC_TIPREC = "ESIT" ') ;
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

class function TPgOnESiTef.fPossuiAdiantamentoPgOnESiTef(strNumDoc, strEspDoc,
  strCodEmp: string): Boolean;
var
  recTotaisAdiantamento: TTotaisAdiantamento;
begin
  Result := False;

  if TPgOnESiTef.fDocumentoPgOnEsiTef(strNumDoc, strEspDoc, strCodEmp, '', 'PD') then
  begin
    recTotaisAdiantamento := TAdiantamento.fGetTotaisAdiantamento(strNumDoc,
                                                                  strEspDoc,
                                                                  VS_strCodEmp);

    if (recTotaisAdiantamento.blnExiAdt) then
    begin
      if (recTotaisAdiantamento.fltValLan > 0) Then
      begin
        fMensagem('ATENÇÃO!', 'O pedido '+strNumDoc+'-'+strEspDoc+
                              ' já possui adiantamento gerado pelo Pagamento Online da ESiTef. Sendo assim, sua alteração não é permitida. '+
                              'Se for necessário, cancele o pedido e refaça o processo.', ['&OK']);

        Result := True;
      end;
    end;
  end;
end;

class function TPgOnESiTef.fProcessaCancelamento(const AstrNumDoc, AstrEspDoc,
  AstrCodEmp: string): Boolean;
var
  LfrmPgtoOnlineESiTefManutencao : TfrmPgtoOnlineESiTefManutencao;
  LfrmStatusTransacao: String ;
begin
  Result := False ;

  LfrmStatusTransacao := fRetornaStatusPedidoESiTef(AstrNumDoc, AstrEspDoc, AstrCodEmp) ;

  if LfrmStatusTransacao = stAguardandoUsuario then
  begin
    fMensagem('ATENÇÃO!', 'Documento (' + AstrNumDoc + ') com link de pagamento em Aguardando Usuário!'+#13+#10+'Aguarde o link expirar para cancelar o pedido!', ['&OK']);
    Exit ;
  end ;

  if (MatchStr(LfrmStatusTransacao, [stTransacaoRecente, stTransacaoRecenteEmailNaoEnviado])) then
  begin
    fMensagem('ATENÇÃO!', 'Documento (' + AstrNumDoc + ') com link de pagamento em Transação Recente!'+#13+#10+'Aguarde o link expirar para cancelar o pedido!', ['&OK']);
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

class function TPgOnESiTef.fRetornaStatusPedidoESiTef(const AstrNumDoc,
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

function TPgOnESiTef.fVerificaEstrutura: Boolean;
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

procedure TPgOnESiTef.pCarregaPedidoPgOnESiTef(strNumDoc, strEspDoc, strCodEmp: string);
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

procedure TPgOnESiTef.pExcluirMovCar(const AstrNumCCD: String);
var
  LqryExec: TUniQuery ;
begin
  LqryExec := fCriaQuery() ;
  try
    LqryExec.SQL.Clear ;
    LqryExec.SQL.Add(' SELECT * FROM MOVCAR ') ;
    LqryExec.SQL.Add('     WHERE MCA_CODEMP = :CODEMP AND ') ;
    LqryExec.SQL.Add('           MCA_NUMCCD = :NUMCCD AND ') ;
    LqryExec.SQL.Add('           MCA_CODCLI = :CODCLI AND ') ;
    LqryExec.SQL.Add('           MCA_CODCAR = :CODCAR ') ;
    LqryExec.ParamByName('CODEMP').AsString := FstrCodEmp ;
    LqryExec.ParamByName('NUMCCD').AsString := AstrNumCCD ;
    LqryExec.ParamByName('CODCLI').AsString := FstrCodCli ;
    LqryExec.ParamByName('CODCAR').AsString := fCfgSis('CARSIT', varString) ;
    LqryExec.Open ;
    fVerificaIntegridade('untPgtOnlineESiTef', 'MOVCAR', LqryExec, True);
    LqryExec.Delete ;
  finally
    FreeAndNil(LqryExec) ;
  end ;
end;

procedure TPgOnESiTef.pGravarAdtCliCartao(const AfltValCar: Double;
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
  dadosAdiantamento.strDescri := 'ESTORNO VIA LINK DE PAGAMENTO ESITEF ADIANTAMENTO PEDIDO: ' + FstrNumDoc + '-' + FstrEspDoc;
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

procedure TPgOnESiTef.pImprimirCliente(AstrViaCli, AstrViaLoj: String);
begin
  if not fEmptyStr(AstrViaCli) then
    pImprimirTef(AstrViaCli, '')
  else
    pImprimirTef(AstrViaLoj, '');
end;

procedure TPgOnESiTef.pImprimirLojista(AstrViaCli, AstrViaLoj: String);
begin
  if not fEmptyStr(AstrViaLoj) then
    pImprimirTef(AstrViaLoj, '')
  else
    pImprimirTef(AstrViaCli, '');
end;

procedure TPgOnESiTef.pProcessarEstorno(const AfltValCar: Double; const AstrNumCCD: String);
begin
  pExcluirMovCar(AstrNumCCD) ;
  pGravarAdtCliCartao(AfltValCar, StrToInt(fRetRcxCon(FstrCodEmp))) ;
end;

function TPgOnESiTef.fCancelaLinkPagamento(const AstrNsu,
  AstrNit, AstrNumCCD, AstrNumeroCartao, AstrVencCartao, AstrOrigem: String;
  var AstrMsgErro: String): Boolean;
var
  LobjPgtOnESiTefEnvio : TPgtOnESiTefEnvio;
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
  LobjPgtOnESiTefEnvio := TPgtOnESiTefEnvio.Create;
  try
    LjsonCriaCancel := LobjPgtOnESiTefEnvio.fCriarCancelamento(AstrNsu, AstrNit, LstrJSONRet, LstrJSONReq) ;
    if Assigned(LjsonCriaCancel) then
    begin
      AstrMsgErro := LjsonCriaCancel.GetValue<String>('message') ;
      if LjsonCriaCancel.GetValue<Integer>('code') = 0 then
      begin
        LjsonNit := LjsonCriaCancel.GetValue<TJSONObject>('cancellation') ;
        LjsonEfetivaCancel := LobjPgtOnESiTefEnvio.fEfetuarCancelamento(LjsonNit.GetValue<String>('nit'), AstrNumeroCartao, AstrVencCartao, LstrJSONRetCanc, LstrJSONReqCanc) ;
        if Assigned(LjsonEfetivaCancel) then
        begin
          AstrMsgErro := LjsonEfetivaCancel.GetValue<String>('message') ;
          if LjsonEfetivaCancel.GetValue<Integer>('code') = 0 then
          begin
            LjsonNit := LjsonEfetivaCancel.GetValue<TJSONObject>('cancellation') ;
            try
              fStartTransaction ;
              Result := TPgtOnESiTefModel.fEstornaTrasacao(
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
              fCommit;
            Except
              On E: Exception Do
              Begin
                Result := False;
                AstrMsgErro := e.Message ;
                fRollBack;
              End;
            End;
          end ;
        end ;
      end ;
    end ;

    if not Result then
    begin
      TPgtOnESiTefModel.fEstornaTrasacao(
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
    FreeAndNil(LobjPgtOnESiTefEnvio) ;
    if Assigned(LjsonCriaCancel) then
      FreeAndNil(LjsonCriaCancel) ;
    if Assigned(LjsonEfetivaCancel) then
      FreeAndNil(LjsonEfetivaCancel) ;
  end ;
end;

function TPgOnESiTef.fDesvinculaLinkPagamentoPedido: Boolean;
begin
  fStartTransaction;
  try
    Result := TPgtOnESiTefModel.fDesvinculaPedido(Self.FstrNumDoc, Self.FstrEspDoc, Self.FstrCodEmp, Self.FstrCodCli, Self.FstrOrigem) ;

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

function TPgOnESiTef.fGeraNovoLinkPagamento(strNumNitOld, strMercIdOld, strCodEmpOld,
  strCodOpe, strTipTra : String; intQtdPar, intTpParc : Integer; fltValCar : Double;
  var strNewNit, AstrRetornoMsgErro : String) : Boolean;
  var
    objPgtOnESiTefEnvio : TPgtOnESiTefEnvio;
    objPgtOnESiTefResposta : TPgtOnESiTefResposta;
begin
  Result := False;

  Try
    fStartTransaction;

    objPgtOnESiTefEnvio := TPgtOnESiTefEnvio.Create;
    try
      objPgtOnESiTefResposta := objPgtOnESiTefEnvio.fGerarLinkPagamento(strTipTra, intQtdPar,
        IntToStr(intTpParc), fltValCar, AstrRetornoMsgErro);

      strNewNit := objPgtOnESiTefResposta.nit;

      if Assigned(objPgtOnESiTefResposta) then
      begin
        Result := TPgtOnESiTefModel.fNovaTransacao(strCodEmp,
                                                   objPgtOnESiTefResposta.url,
                                                   objPgtOnESiTefResposta.nit,
                                                   objPgtOnESiTefResposta.nsuesitef,
                                                   strCodOpe,
                                                   Date,
                                                   fTime(),
                                                   stTransacaoRecente,
                                                   TPgtOnlineESiTefRepositorio.fGetMerchantId,
                                                   fltValCar,
                                                   fGetSeqFgoPedidos(strNumNitOld, strMercIdOld),
                                                   objPgtOnESiTefEnvio.strJSONRequest,
                                                   objPgtOnESiTefEnvio.strJSONResponse,
                                                   intQtdPar, self.FstrOrigem, self.FstrAutIncs); 

        TPgtOnESiTefModel.pRemoveTransacao(strNumNitOld, strMercIdOld, strCodEmpOld);

        if Result then
        begin
          fCommit;
        end
        else
          fRollBack;
      end;
    finally
      FreeAndNil(objPgtOnESiTefEnvio);
    end;
  Except
    On E: Exception Do
    Begin
      Result := False;
      fRollBack;
    End;
  End;
end;

procedure TPgOnESiTef.SetstrCodCli(const Value: String);
begin
  FstrCodCli := Value;
end;

procedure TPgOnESiTef.SetstrCodEmp(const Value: String);
begin
  FstrCodEmp := Value;
end;

procedure TPgOnESiTef.SetstrEspDoc(const Value: String);
begin
  FstrEspDoc := Value;
end;

procedure TPgOnESiTef.SetstrNumDoc(const Value: String);
begin
  FstrNumDoc := Value;
end;

procedure TPgOnESiTef.SetstrTipRec(const Value: String);
begin
  FstrTipRec := Value;
end;

{ TParChavesLinkPagamento }

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


end.
