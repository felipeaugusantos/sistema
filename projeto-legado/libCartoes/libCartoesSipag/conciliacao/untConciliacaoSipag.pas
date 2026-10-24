{****************************************}
{* Nova forma de Conciliação de Cartões *}
{* SIPAG                                *}
{*************************************AJ*}
unit untConciliacaoSipag;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, System.Math,

     Uni, UniClientDataSet, cxProgressBar,

     untSipagConciliacaoCartoes, untLibCartoesInterfacesTipos, untTSipagFuncoes;


type TConcilSipag = class(TConciliacaoCartoes)
  private
    function RegistroPossuiAMesmaAutorizacao(AAutorizacao,
                                             AParcela,
                                             AEmpresa,
                                             ADataTransacao: String): Boolean;

    function fProcessaSipag(pgbStatus: TcxProgressBar = Nil): Boolean;

    function fConciliaSipag(pgbStatus: TcxProgressBar): Boolean;
  public
    function fConciliaCartoes: Boolean; override;
  end;

implementation
Uses untSipagDigPeriodo;

function TConcilSipag.fConciliaCartoes: Boolean;
begin
  Result := TSipagFuncoes.ExecutaAguarde(fConciliaSipag, 'Aguarde... Iniciando a conciliação.');
end;

function TConcilSipag.fConciliaSipag(pgbStatus: TcxProgressBar): Boolean;
  Var
    prcScroll: TprcScroll;
Begin
  TForm(pgbStatus.Owner).Visible := False;

  Result       := False;
  FPossuiInconsistencia := False;
  Try
    Try
      //Para conciliação por Ponto de Venda
      objConcil.TabelaConciliacao := 'SIP_SIPGTO';
      objConcil.CampoEstabelecimento := 'SIP_CODEST';
      objConcil.NomeConciliacao := 'SIPAG';
      objConcil.CfgEstabelecimentos := 'CFG_SIPEST';
      objConcil.CampoValorBruto := 'SIP_VALBRU';
      objConcil.CampoValorLiquido := 'SIP_VALLIQ';
      objConcil.CampoCodigoAutorizacao := 'SIP_CODAUT';
      objConcil.CampoNumeroNSU := 'SIP_NUMNSU';
      objConcil.CampoDataTransacaoVenda := 'SIP_DTATRA';
      objConcil.CampoNumeroParcela := 'SIP_NUMPAR';
      objConcil.CampoTotalParcelas := 'SIP_TOTPAR';
      objConcil.CampoNumeroCartao := 'SIP_NUMCAR';
      objConcil.CampoDataRecebimento := 'SIP_DTAPAG';
      objConcil.CampoTipoRegistro := 'SIP_TIPREG';
      objConcil.CampoTipoTransacao := 'SIP_TIPOPE';
      objConcil.CfgPortadorAjustes := 'SIPPOR';
      objConcil.CfgPlanoDeContasAjustes := 'SIPCTA';
      objConcil.CfgPortadorAjustes := 'SIPFOR';
      objConcil.strEventoCancelamentoAjuste := 'SIPEVE';

      objConcil.strChavePrimaria := 'SIP_CODEST,SIP_DTAPAG,SIP_TIPREG,SIP_DTATRA,SIP_NUMNSU,SIP_CODAUT,SIP_NUMPAR';

      If Assigned(FListaRegistrosRelatorio) Then
        FListaRegistrosRelatorio.Clear;

      If Not fDigPeriodo Then
        Exit;

      TForm(pgbStatus.Owner).Visible := True;
      pgbStatus.Visible := False;

      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'SIPAG',
                                                            'CONCILIACAO',
                                                            RetornaFiltrosdigitados,
                                                            TSipagFuncoes.RetornaDataHoraServidor,
                                                            TSipagFuncoes.RetornaHoraServidor);

      TSipagFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros para conciliação (' + objConcil.NomeConciliacao + ').', False);
      If Not fProcessaSipag(pgbStatus) Then
        Exit;
    Except
      On E: Exception Do
      Begin
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.fConciliaSipag]');
        Exit(False);
      End;
    End;

    cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
    cdsBaiCar.Filtered := True;

    FPossuiInconsistencia := False;

    TSipagFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Gravando registros do relatório (' + objConcil.NomeConciliacao + ').', False);
    GravarRegistrosRelatorio(pgbStatus);

    If FPossuiInconsistencia Then
      TSipagFuncoes.fMensagem('','Foram encontradas inconsistências na importação dos arquivos!',['&OK']);

    If FListaRegistrosRelatorio.Count > 0 Then
      Result := GeraRelatorioConciliacao('SIPAG', pgbStatus);

    If Assigned(cdsAjustes) Then
    Begin
      cdsAjustes.Filter   := 'SIP_CONCIL=0';
      cdsAjustes.Filtered := True;
    End;

    blnReabre := Not Result;
    If Result Then
    Begin
      cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
      cdsBaiCar.Filtered := True;

      Result := Not cdsBaiCar.IsEmpty;
      If Not Result Then
        TSipagFuncoes.fMensagem('ATENÇÃO','Nenhum pagamento foi conciliado no período selecionado!',['&OK'])
      Else
        TSipagFuncoes.fMensagem('AVISO','Conciliação da SIPAG realizada com sucesso.',['&OK']);
    End;
  Finally
    TSipagFuncoes.pEnableControls(cdsBaiCar, prcScroll);

    TSipagFuncoes.FreeAndNilDatasets(cdsConCar);
    TSipagFuncoes.FreeAndNilDatasets(cdsAjustes);
  End;
End;

function TConcilSipag.fProcessaSipag(pgbStatus: TcxProgressBar): Boolean;
Var
  fltDifere  : Double;
  strSQL     : String;
  strIndAnt  : String;
  qryConCar  : TUniQuery;
  intRecNo   : Integer;
  blnBusca   : Boolean;
  strTipo    : String;

  LValorBruto,
  LValorLiquido: Double;

  LRegistroRelatorio: TItensRelatorioCartoes;

  LParcela,
  LChaveConciliacao: String;
begin
  strRcxTcc   := VS_FuncoesExternas.fICfgSis('RCXTCC');

  Application.ProcessMessages;

  //Selecionando a tabela de importação de pagamentos da SIPAG
  strSQL := '';
  strSQL := strSQL + 'SELECT A.*, COALESCE(SIS_CODEMP, "") AS CODEMP, EMP_NOMEMP ';
  strSQL := strSQL + 'FROM SIP_SIPGTO A                                          ';
  strSQL := strSQL + '  LEFT JOIN CFGSIS ON SIS_CODCFG="CFG_SIPEST"              ';
  strSQL := strSQL + '                  AND LOCATE(A.SIP_CODEST, SIS_VALCFG) > 0 ';
  strSQL := strSQL + '  LEFT JOIN CADEMP ON SIS_CODEMP=EMP_CODEMP                ';
  strSQL := strSQL + 'WHERE A.SIP_DTAPAG BETWEEN :DTAIN AND :DTAFIM              ';
  strSQL := strSQL + '  AND A.SIP_TIPREG <> "030" AND A.SIP_STATUS = 0 AND       ';
  strSQL := strSQL + ' (SELECT COUNT(*) FROM SIP_SIPGTO B                        ';
  strSQL := strSQL + '  WHERE SIP_DTAPAG < :DTAIN AND SIP_TIPREG="030"           ';
  strSQL := strSQL + '    AND B.SIP_CODEST = A.SIP_CODEST                        ';
  strSQL := strSQL + '    AND B.SIP_CODAUT = A.SIP_CODAUT                        ';
  strSQL := strSQL + '    AND B.SIP_NUMNSU = A.SIP_NUMNSU                        ';
  strSQL := strSQL + '    AND B.SIP_DTATRA = A.SIP_DTATRA                        ';
  strSQL := strSQL + '    AND B.SIP_NUMPAR = A.SIP_NUMPAR)=0                     ';
  strSQL := strSQL + fRetPesqPonVen(0);
  strSQL := strSQL + 'ORDER BY SIP_TIPREG, SIP_DTAPAG                            ';

  qryConCar := Nil;
  Try
    qryConCar   := VS_FuncoesExternas.fICriaQuery;
    qryConCar.SQL.Text := 'SHOW TABLES LIKE "SIP_SIPGTO"';
    qryConCar.Open;
    If qryConCar.IsEmpty Then
    Begin
      TSipagFuncoes.fMensagem('','Não existem arquivos importados para a conciliação da SIPAG!',['&OK']);
      Exit(False);
    End;

    qryConCar.Close;
    qryConCar.SQL.Text := strSQL;

    qryConCar.ParamByName('DTAIN').AsString  := FormatDateTime('yyyy/MM/dd', dtaDtaIni);
    qryConCar.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy/MM/dd', dtaDtaFim);

    qryConCar.Open;

    If qryConCar.IsEmpty Then
    Begin
      TSipagFuncoes.fMensagem('','Não existem arquivos importados nesse período de recebimento!',['&OK']);
      blnReabre := True;
      Exit(False);
    End;

    cdsConCar := TSipagFuncoes.CriarClientDataSet(qryConCar);
  Finally
    TSipagFuncoes.FreeAndNilDatasets(qryConCar);
  End;

  //Para os Ajustes  - Tem que estar antes para não pegar outros ajustes de outras datas
  strCondicao :=  'SIP_DTAPAG BETWEEN "' + FormatDateTime('yyyy-mm-dd', dtaDtaIni) + '" AND "' + FormatDateTime('yyyy-mm-dd', dtaDtaFim) + '" ';

  pCalculaPeriodoFiltro('SIP_DTATRA');

  TSipagFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando registros.', False);
  pFiltraCartoes;

  //Filtrando Cancelamentos/Ajustes
  strCondicao := strCondicao + StringReplace(fRetPesqPonVen(1), objConcil.CampoEstabelecimento, 'A.' + objConcil.CampoEstabelecimento, [rfReplaceAll]);
  strCondicao := strCondicao + ' AND (SIP_TIPREG = "030") AND (SIP_VALLIQ<>0)        ';
  FiltrarCancelamentosPeriodo(strCondicao,
                              ' SIP_DESAJU ',
                              '');
  cdsBaixad := Nil;
  Try
    //Selecionando cartões já baixados/cadastrados no período
    pFiltraCartoesBaixados;

    pgbStatus.Visible := True;

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsConCar.RecordCount;

    cdsConCar.First;
    While Not cdsConCar.EOF do
    Begin
      TSipagFuncoes.pStepStatusGravacao(pgbStatus);

      FTextoInconsistencia := EmptyStr;

      If Not cdsConCar.FieldByName('SIP_TIPREG').AsInteger in [21, 23, 26] Then
      Begin
        cdsConCar.Next;
        Continue;
      End;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      strTipo := 'ANTECIPAÇÃO';
      If cdsConCar.FieldByName('SIP_TIPCRE').AsInteger <> 2 Then
      Begin
        Case cdsConCar.FieldByName('SIP_TIPREG').AsInteger Of
          21: strTipo := 'DÉBITO';
          26: strTipo := 'CRÉDITO PARCELADO';
          Else strTipo := 'CRÉDITO ROTATIVO';
        End;
      End;

      LValorBruto := cdsConCar.FieldByName('SIP_VALBRU').Value;

      LValorLiquido := LValorBruto *
                       (cdsConCar.FieldByName('SIP_RV_LIQ').Value / cdsConCar.FieldByName('SIP_RV_BRU').Value);

      LParcela := TSipagFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName('SIP_NUMPAR').AsString = '00',
                                              '1',
                                              cdsConCar.FieldByName('SIP_NUMPAR').AsString)));

      blnBusca := fBuscaCartao(cdsConCar.FieldByName('SIP_CODAUT').Value,
                               TSipagFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('SIP_NUMNSU').Value, 14)), 14),
                               cdsConCar.FieldByName('CODEMP').AsString,
                               LParcela,
                               cdsConCar.FieldByName('SIP_DTATRA').Value);

      If blnBusca Then
      Begin
        fltDifere := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto;
        If fBetween(fltDifere, -0.0299999, 0.029999) Then
        Begin
          LChaveConciliacao := 'SIP_' + cdsConCar.FieldByName('SIP_NUM_RV').AsString + '_' +
                               cdsConCar.FieldByName('SIP_CODAUT').AsString + '_' +
                               LParcela + '_' + cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                               FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('SIP_DTATRA').AsDateTime);

          MarcarCartaoEncontradoArquivo(LValorLiquido,
                                        cdsConCar.FieldByName('SIP_TIPCRE').AsInteger = 2,
                                        LRegistroRelatorio,
                                        LChaveConciliacao,
                                        cdsConCar);
        End
        Else
        Begin
          FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização duplicada';

          intRecNo := cdsBaiCar.RecNo;
          cdsBaiCar.Next;
          While RegistroPossuiAMesmaAutorizacao(cdsConCar.FieldByName('SIP_CODAUT').AsString,
                                                LParcela,
                                                cdsConCar.FieldByName('CODEMP').AsString,
                                                cdsConCar.FieldByName('SIP_DTATRA').AsString) Do
          Begin
            fltDifere := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto;
            If fBetWeen(fltDifere, -0.0299999, 0.029999) Then
            Begin
              FTextoInconsistencia := EmptyStr;
              LChaveConciliacao := 'SIP_' + cdsConCar.FieldByName('SIP_NUM_RV').AsString + '_' +
                               cdsConCar.FieldByName('SIP_CODAUT').AsString + '_' +
                               LParcela + '_' + cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                               FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('SIP_DTATRA').AsDateTime);

              MarcarCartaoEncontradoArquivo(LValorLiquido,
                                            cdsConCar.FieldByName('SIP_TIPCRE').AsInteger = 2,
                                            LRegistroRelatorio,
                                            LChaveConciliacao,
                                            cdsConCar);

              Break;
            End;

            cdsBaiCar.Next;

            If cdsBaiCar.Eof Then
              Break;
          End;

          If Not fBetWeen(fltDifere, -0.0299999, 0.029999) Then
            cdsBaiCar.RecNo := intRecNo;
        End;
      End
      Else
      Begin
        blnAutomatica := cdsConCar.FieldByName('SIP_CONCIL').Value = '1';
        cdsBaixad.First;
        blnBusca := fBuscaCartaoBaixado(cdsConCar.FieldByName('SIP_CODAUT').AsString,
                                        TSipagFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('SIP_NUMNSU').Value, 14)), 14),
                                        cdsConCar.FieldByName('CODEMP').AsString,
                                        LParcela,
                                        cdsConCar.FieldByName('SIP_DTATRA').Value);

        FTextoInconsistencia := 'Cartão já foi baixado';
        If Not blnBusca Then
          FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';
      End;

      {Gerando registro do relatório}
      FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
      If Not FTextoInconsistencia.IsEmpty Then
      Begin
        LRegistroRelatorio.Descricao := FTextoInconsistencia;
        LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
      End;
      LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('SIP_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName('SIP_CODEST').AsString;
      LRegistroRelatorio.CodigoEmpresa := cdsConCar.FieldByName('CODEMP').AsString;
      LRegistroRelatorio.NumeroNSU := TSipagFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('SIP_NUMNSU').AsString, 14)), 14);
      LRegistroRelatorio.CodigoAutorizacao := TSipagFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('SIP_CODAUT').Value, 6)), 6);
      LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('SIP_NUM_RV').AsString;
      LRegistroRelatorio.NumeroCartao := cdsConCar.FieldByName('SIP_NUMCAR').AsString;

      If LRegistroRelatorio.TipoCartao.IsEmpty Then
        LRegistroRelatorio.TipoCartao := strTipo;

      LRegistroRelatorio.Parcela := TSipagFuncoes.fStrZero(cdsConCar.FieldByName('SIP_NUMPAR').AsString, 2);
      LRegistroRelatorio.TotalParcelas := TSipagFuncoes.fStrZero(cdsConCar.FieldByName('SIP_TOTPAR').AsString, 2);
      LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('SIP_DTAPAG').AsDateTime;
      LRegistroRelatorio.DataVenda := cdsConCar.FieldByName('SIP_DTATRA').AsDateTime;
      LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('SIP_DTAPAG').AsDateTime;

      LRegistroRelatorio.ValorBruto := LValorBruto;
      LRegistroRelatorio.ValorLiquido := LValorLiquido;

      LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

      cdsConCar.Next;
    End;
  Finally
    TSipagFuncoes.FreeAndNilDatasets(cdsBaixad);
    cdsBaiCar.IndexFieldNames := strIndAnt;
    Result := True;
  End;
end;

function TConcilSipag.RegistroPossuiAMesmaAutorizacao(AAutorizacao,
  AParcela, AEmpresa, ADataTransacao: String): Boolean;
begin
  Result := cdsBaiCar.FieldByName('MCA_NUMCCD').AsString.Equals(AAutorizacao);

  If Not Result Then
    Exit;

  Result := cdsBaiCar.FieldByName('PARDUP').AsString.Equals(AParcela);

  If Not Result Then
    Exit;

  If Not cdsConCar.FieldByName('CODEMP').AsString.IsEmpty Then
  Begin
    Result := cdsBaiCar.FieldByName('MCA_EMPRCX').AsString.Equals(AEmpresa);

    If Not Result Then
      Exit;
  End;

  Result := cdsBaiCar.FieldByName('MCA_DTACUP').AsString.Equals(ADataTransacao);

  If Not Result Then
    Exit;

  Result := cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('D');
end;

end.
