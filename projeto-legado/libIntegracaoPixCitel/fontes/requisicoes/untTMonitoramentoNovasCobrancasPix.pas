unit untTMonitoramentoNovasCobrancasPix;

interface

Uses System.Classes, System.SysUtils, System.StrUtils, untTiposPix, untIDataset;

Type
  TMonitoramentoNovasCobrancasPix = class
  private
    class var FNaoExecutar: String;
    class var FVerificado: String;

    class function ValidaSeDeveGravarOMonitoramento: Boolean;

    class function RetornaDadosNovaCobranca(ADataset: IDataset): TNovaCobrancaPix;

    class procedure GravarTabelaDel(ADataset: IDataset);

    class function DeveExecutarOMonitoramento(ANovaCobranca: TNovaCobrancaPix): Boolean;
    class function RetornouMensagemDeErroNasRequisicoes(ANovaCobranca: TNovaCobrancaPix): Boolean;
  public
    class procedure GravarMonPix_Log(var ANovaCobranca: TNovaCobrancaPix);
    class procedure RemoverMonPix_Log(var ANovaCobranca: TNovaCobrancaPix);
  end;

implementation
Uses untFuncoesSimples, untTFuncoesAuxiliaresPix;

{ TMonitoramentoNovasCobrancasPix }

class function TMonitoramentoNovasCobrancasPix.DeveExecutarOMonitoramento(ANovaCobranca: TNovaCobrancaPix): Boolean;
begin
  Result := True;

  //Essas duas validações existem pois a lib pode ser recompilada para versões anteriores
  If FNaoExecutar = 'S' Then
    Exit(False);

  If FVerificado <> 'S' Then
  Begin
    If Not ValidaSeDeveGravarOMonitoramento Then
      Exit(False);
  End;

  //Caso tenha retornado mensagens de erro
  If RetornouMensagemDeErroNasRequisicoes(ANovaCobranca) Then
    Exit(False);
end;

class procedure TMonitoramentoNovasCobrancasPix.GravarMonPix_Log(
  var ANovaCobranca: TNovaCobrancaPix);
  Var
    LDataset: IDataSet;

    LDeveRealizarCommit: Boolean;

    LDadosJson: TDadosRetornoPixConsulta;

    LDadosJsonShipay: TDadosRetornoPixAVista;
begin
  LDadosJson := Nil;
  LDadosJsonShipay := Nil;

  LDeveRealizarCommit := False;

  If Not DeveExecutarOMonitoramento(ANovaCobranca) Then
    Exit;

  Try
    LDataset := VS_FuncoesExternas.fGetDataSet;

    LDataset.SQL := 'SELECT * FROM MONPIX_LOG WHERE AUTOINCREM="' + ANovaCobranca.AutoIncrem + '"';
    LDataset.Open;

    LDeveRealizarCommit := VS_FuncoesExternas.fIStartTransaction;

    If LDataset.IsEmpty Then
    Begin
      If Not ANovaCobranca.UtilizaShipay Then
        LDadosJson := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(ANovaCobranca.JsonRecebidoCriacao,
                                                                   ANovaCobranca.JsonEnviado)
      Else
        LDadosJsonShipay := TFuncoesPix.RetornaDadosDoRetornoPixAVistaShipay(ANovaCobranca.JsonEnviado,
                                                                             ANovaCobranca.JsonRecebidoCriacao,
                                                                             ANovaCobranca.AutoIncremChavePix);

      LDataset.Insert;
      LDataset.FieldByName('AUTOINCREM').AsString := VS_FuncoesExternas.fIRetAutoIncrem('MONPIX_LOG', VS_FuncoesExternas.fGetEmpresaLogada);
      LDataset.FieldByName('LOG_DTACAD').AsFloat := untFuncoesSimples.RetornaCurrentTimeStampServidorDataHora;
      LDataset.FieldByName('LOG_DTACON').AsFloat := LDataset.FieldByName('LOG_DTACAD').AsFloat;

      If LDataset.FindField('LOG_CODCLI') <> Nil Then
        LDataset.FieldByName('LOG_CODCLI').AsString := ANovaCobranca.CodigoCliente;

      If LDataset.FindField('LOG_CHADOC') <> Nil Then
      Begin
        LDataset.FieldByName('LOG_CHADOC').AsString := ANovaCobranca.ChaveDocumento;
        LDataset.FieldByName('LOG_QTDITE').AsString := '001';
        If Length(ANovaCobranca.ChaveDocumento.Split(['|'])) = 3 Then
        Begin
          LDataset.FieldByName('LOG_CHADOC').AsString := ANovaCobranca.ChaveDocumento.Split(['|'])[0];

          LDataset.FieldByName('LOG_QTDITE').AsString := ANovaCobranca.ChaveDocumento.Split(['|'])[1];
          LDataset.FieldByName('LOG_NOMTEL').AsString := ANovaCobranca.ChaveDocumento.Split(['|'])[2];
        End;
        LDataset.FieldByName('LOG_VALDOC').AsFloat := ANovaCobranca.ValorDocumento;
      End;
    End
    Else
    Begin
      LDataset.Edit;

      LDadosJson := TFuncoesPix.RetornaDadosDoRetornoPixConsulta(ANovaCobranca.JsonRecebidoConsulta,
                                                                 ANovaCobranca.JsonRecebidoCriacao);

      LDataset.FieldByName('LOG_DTACON').AsFloat := untFuncoesSimples.RetornaCurrentTimeStampServidorDataHora;
    End;

    If Assigned(LDadosJsonShipay) Then
    Begin
      LDataset.FieldByName('LOG_TX_ID_').AsString := LDadosJsonShipay.Txid;
      LDataset.FieldByName('LOG_STATUS').AsString := LDadosJsonShipay.Status;
      LDataset.FieldByName('LOG_LNKCIT').AsString := LDadosJsonShipay.LinkCitel;
      LDataset.FieldByName('LOG_EXPIRA').AsString := LDadosJsonShipay.Expiracao;
      LDataset.FieldByName('LOG_QRCODE').AsString := LDadosJsonShipay.TextoQrCode;
    End
    Else
    Begin
      LDataset.FieldByName('LOG_TX_ID_').AsString := LDadosJson.Txid;
      LDataset.FieldByName('LOG_STATUS').AsString := LDadosJson.Status;
      LDataset.FieldByName('LOG_LNKCIT').AsString := LDadosJson.LinkCitel;
      LDataset.FieldByName('LOG_EXPIRA').AsString := LDadosJson.Expiracao;

      If LDataset.FieldByName('LOG_EXPIRA').AsString.IsEmpty Then
        LDataset.FieldByName('LOG_EXPIRA').AsInteger := 86400;

      LDataset.FieldByName('LOG_QRCODE').AsString := LDadosJson.TextoQrCode;

      If LDadosJson.DataPagamento > 0 Then
      Begin
        LDataset.FieldByName('LOG_DTAREC').AsFloat := LDadosJson.DataPagamento;
        LDataset.FieldByName('LOG_END_ID').AsString := LDadosJson.EndToEndId;
      End;
    End;

    LDataset.FieldByName('LOG_CODEMP').AsString := VS_FuncoesExternas.fGetEmpresaLogada;
    LDataset.FieldByName('LOG_JSOENV').AsString := ANovaCobranca.JsonEnviado;
    LDataset.FieldByName('LOG_JSOREC').AsString := ANovaCobranca.JsonRecebidoCriacao;
    LDataset.FieldByName('LOG_JSOCON').AsString := ANovaCobranca.JsonRecebidoConsulta;
    LDataset.FieldByName('LOG_SEQPIX').AsString := ANovaCobranca.AutoIncremChavePix;
    LDataset.FieldByName('LOG_EMPFIS').AsString := untFuncoesSimples.fRetEmpresaFisica;
    LDataset.FieldByName('LOG_CODOPE').AsString := VS_FuncoesExternas.fIRetOperadorLogado;
    
    LDataset.Post;

    If LDeveRealizarCommit Then
      VS_FuncoesExternas.fICommit;

    ANovaCobranca := RetornaDadosNovaCobranca(LDataset);
  Except
    If LDeveRealizarCommit Then
      VS_FuncoesExternas.fIRollBack;
  End;
end;

class procedure TMonitoramentoNovasCobrancasPix.GravarTabelaDel(
  ADataset: IDataset);
  Var
    LDatasetDel: IDataset;

    LDataDelete: TDateTime;
begin
  If ADataset.IsEmpty Then
    Exit;

  If ADataset.FieldByName('AUTOINCREM').AsString.IsEmpty Then
    Exit;

  LDatasetDel := VS_FuncoesExternas.fGetDataSet;
  LDatasetDel.SQL := 'SELECT * FROM DEL_MONPIX_LOG WHERE AUTOINCREM="' + ADataset.FieldByName('AUTOINCREM').AsString + '"';
  LDatasetDel.Open;

  If Not LDatasetDel.IsEmpty Then
    LDatasetDel.Delete;

  LDatasetDel.Insert;
  LDatasetDel.FieldByName('AUTOINCREM').AsString := ADataset.FieldByName('AUTOINCREM').AsString;
  LDatasetDel.FieldByName('LOG_DTACAD').AsFloat := ADataset.FieldByName('LOG_DTACAD').AsFloat;
  LDatasetDel.FieldByName('LOG_DTACON').AsFloat := ADataset.FieldByName('LOG_DTACON').AsFloat;
  LDatasetDel.FieldByName('LOG_TX_ID_').AsString := ADataset.FieldByName('LOG_TX_ID_').AsString;
  LDatasetDel.FieldByName('LOG_CODEMP').AsString := ADataset.FieldByName('LOG_CODEMP').AsString;
  LDatasetDel.FieldByName('LOG_JSOENV').AsString := ADataset.FieldByName('LOG_JSOENV').AsString;
  LDatasetDel.FieldByName('LOG_JSOREC').AsString := ADataset.FieldByName('LOG_JSOREC').AsString;
  LDatasetDel.FieldByName('LOG_JSOCON').AsString := ADataset.FieldByName('LOG_JSOCON').AsString;
  LDatasetDel.FieldByName('LOG_STATUS').AsString := ADataset.FieldByName('LOG_STATUS').AsString;
  LDatasetDel.FieldByName('LOG_SEQPIX').AsString := ADataset.FieldByName('LOG_SEQPIX').AsString;
  LDatasetDel.FieldByName('LOG_EMPFIS').AsString := ADataset.FieldByName('LOG_EMPFIS').AsString;
  LDatasetDel.FieldByName('LOG_CODOPE').AsString := ADataset.FieldByName('LOG_CODOPE').AsString;
  LDatasetDel.FieldByName('LOG_LNKCIT').AsString := ADataset.FieldByName('LOG_LNKCIT').AsString;

  LDatasetDel.FieldByName('LOG_EXPIRA').AsString := ADataset.FieldByName('LOG_EXPIRA').AsString;

  LDatasetDel.FieldByName('LOG_DTAREC').AsFloat := ADataset.FieldByName('LOG_DTAREC').AsFloat;
  LDatasetDel.FieldByName('LOG_END_ID').AsString := ADataset.FieldByName('LOG_END_ID').AsString;
  LDatasetDel.FieldByName('LOG_QRCODE').AsString := ADataset.FieldByName('LOG_QRCODE').AsString;

  If LDatasetDel.FindField('LOG_CODCLI') <> Nil Then
    LDatasetDel.FieldByName('LOG_CODCLI').AsString := ADataset.FieldByName('LOG_CODCLI').AsString;

  If LDatasetDel.FindField('LOG_CHADOC') <> Nil Then
  Begin
    LDatasetDel.FieldByName('LOG_CHADOC').AsString := ADataset.FieldByName('LOG_CHADOC').AsString;
    LDatasetDel.FieldByName('LOG_QTDITE').AsString := ADataset.FieldByName('LOG_QTDITE').AsString;
    LDatasetDel.FieldByName('LOG_NOMTEL').AsString := ADataset.FieldByName('LOG_NOMTEL').AsString;
    LDatasetDel.FieldByName('LOG_VALDOC').AsFloat := ADataset.FieldByName('LOG_VALDOC').AsFloat;
  End;

  LDataDelete := untFuncoesSimples.RetornaCurrentTimeStampServidorDataHora;

  LDatasetDel.FieldByName('OPEDEL').AsString := VS_FuncoesExternas.fIRetOperadorLogado;
  LDatasetDel.FieldByName('DTADEL').AsFloat := LDataDelete;
  LDatasetDel.FieldByName('HORDEL').AsString := FormatDateTime('HH:MM:SS', LDataDelete);

  LDatasetDel.FieldByName('MOTDEL').AsString := 'REMOVIDO PELO OPERADOR OU EXPIRADO';
  If MatchStr(LDatasetDel.FieldByName('LOG_STATUS').AsString, STATUS_PIX_PAGO) Then
    LDatasetDel.FieldByName('MOTDEL').AsString := 'REMOVIDO POR ESTAR PAGO';

  LDatasetDel.Post;
end;

class procedure TMonitoramentoNovasCobrancasPix.RemoverMonPix_Log(
  var ANovaCobranca: TNovaCobrancaPix);
  Var
    LDataset: IDataSet;

    LDeveRealizarCommit: Boolean;

    LConsultaEmBranco: TNovaCobrancaPix;
begin
  //Essas duas validações existem pois a lib pode ser recompilada para versões anteriores
  If FNaoExecutar = 'S' Then
    Exit;

  If FVerificado <> 'S' Then
  Begin
    If Not ValidaSeDeveGravarOMonitoramento Then
      Exit;
  End;

  LDataset := VS_FuncoesExternas.fGetDataSet;

  LDataset.SQL := 'SELECT * FROM MONPIX_LOG WHERE AUTOINCREM="' + ANovaCobranca.AutoIncrem + '"';
  LDataset.Open;

  LDeveRealizarCommit := False;

  Try
    If Not LDataset.IsEmpty Then
    Begin
      LDeveRealizarCommit := VS_FuncoesExternas.fIStartTransaction;

      GravarTabelaDel(LDataset);

      LDataset.Delete;

      If LDeveRealizarCommit Then
        VS_FuncoesExternas.fICommit;
    End;
  Except
    If LDeveRealizarCommit Then
      VS_FuncoesExternas.fIRollBack;
  End;

  ANovaCobranca := LConsultaEmBranco;
end;

class function TMonitoramentoNovasCobrancasPix.RetornaDadosNovaCobranca(
  ADataset: IDataset): TNovaCobrancaPix;
begin
  Result.AutoIncrem := ADataset.FieldByName('AUTOINCREM').AsString;
  Result.TxIdPix := ADataset.FieldByName('LOG_TX_ID_').AsString;
  Result.CodigoEmpresa := ADataset.FieldByName('LOG_CODEMP').AsString;
  Result.JsonEnviado := ADataset.FieldByName('LOG_JSOENV').AsString;
  Result.JsonRecebidoCriacao := ADataset.FieldByName('LOG_JSOREC').AsString;
  Result.JsonRecebidoConsulta := ADataset.FieldByName('LOG_JSOCON').AsString;
  Result.Status := ADataset.FieldByName('LOG_STATUS').AsString;
  Result.AutoIncremChavePix := ADataset.FieldByName('LOG_SEQPIX').AsString;
  Result.Expiracao := ADataset.FieldByName('LOG_EXPIRA').AsInteger;
  Result.DataLocalCriacao := ADataset.FieldByName('LOG_DTACAD').AsFloat;

  If Not ADataset.FieldByName('LOG_DTACON').AsString.IsEmpty Then
    Result.DataUltimaConsulta := ADataset.FieldByName('LOG_DTACON').AsFloat;

  If Not ADataset.FieldByName('LOG_DTAREC').AsString.IsEmpty Then
    Result.DataLocalPagamento := ADataset.FieldByName('LOG_DTAREC').AsFloat;
end;

class function TMonitoramentoNovasCobrancasPix.RetornouMensagemDeErroNasRequisicoes(
  ANovaCobranca: TNovaCobrancaPix): Boolean;
begin
  Result := False;

  If Not TFuncoesPix.RetornaMensagemErroRequisicao(ANovaCobranca.JsonRecebidoCriacao).IsEmpty Then
    Exit(True);

  If Not TFuncoesPix.RetornaMensagemErroRequisicao(ANovaCobranca.JsonRecebidoConsulta).IsEmpty Then
    Exit(True);
end;

class function TMonitoramentoNovasCobrancasPix.ValidaSeDeveGravarOMonitoramento: Boolean;
  Var
    LConsulta: IDataset;
begin
  Result := False;
  Try
    Try
      Result := VS_FuncoesExternas.fIAtualizadoMonitoramento;
    Except
      Result := False;
    End;

    If Result Then
    Begin
      LConsulta := VS_FuncoesExternas.fGetDataSet;
      LConsulta.SQL := 'SHOW TABLES LIKE "MONPIX_LOG"';
      LConsulta.Open;

      Result := Not LConsulta.IsEmpty;
    End;
  Finally
    FVerificado := 'S';

    FNaoExecutar := 'S';
    If Result Then
      FNaoExecutar := 'N';
  End;
end;

end.
