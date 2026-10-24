unit untConciliacaoCielo;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, Vcl.Graphics,  System.Math,

     Uni, UniClientDataSet, cxProgressBar,

     untCieloConciliacaoCartoes, untTCieloFuncoes, untLibCartoesInterfacesTipos;


type TConcilCielo = class(TConciliacaoCartoes)
  private
    FConsiderarGravame: Boolean;
    FConsiderar03Negociacao: Boolean;
    FConsiderarVendasCanceladas : Boolean;

    FTolerancia: Double;

    function RetornaSQLRegistrosConciliacao: String;
    function RetornaSQLRegistrosConciliacaoVersao015: String;

    function RetornaSQLWhereRegistrosAjustes: String;
    function RetornaSQLWhereRegistrosAjustesVersao015: String;

    function RetornaTipoCartao: String;
    function RetornaTipoCartaoV015: String;

    function RetornaSQLDescricaoAjustes: String;
    function RetornaSQLDescricaoAjustesVersao015: String;

    function RetornaBandeiraCielo(ACodigoBandeira: String): String;

    function NenhumRegistroPagamentos: Boolean;

    function RegistroPossuiAMesmaDataELiberacao(ACodigoAutorizacao,
                                                AParcelaLetra: String): Boolean;

    function RegistroPossuiAMesmaAutorizacao(AAutorizacao,
                                             AParcela,
                                             AEmpresa,
                                             ADataCupom: String): Boolean;

    procedure RealizaRemocaoDaContrapartidaDasNegicacoesCielo(var ADatasetNegociacao: TUniClientDataset;
                                                              var ADatasetValidacao: TUniClientDataset);

    {Métodos principais da rotina}
    function fProcessaCieloPag(pgbStatus: TcxProgressBar = Nil): Boolean;
    function ProcessaCieloVersao015(pgbStatus: TcxProgressBar = Nil): Boolean;
    function ProcessaNegociacaoRecebiveis(pgbStatus: TcxProgressBar = Nil): Boolean;
    function ProcessaVendasCanceladas(pgbStatus: TcxProgressBar): Boolean;
    function fConciliaCielo(prgStatus: TcxProgressBar): Boolean;
  public
    function fConciliaCartoes: Boolean; override;

  protected

  end;

implementation
Uses untCieloFiltroInconsistencias;

function TConcilCielo.fConciliaCartoes: Boolean;
begin
  //Para conciliação por Ponto de Venda
  objConcil.TabelaConciliacao := 'CIE_CIPGTO';
  objConcil.CampoEstabelecimento := 'CIE_CODEST';
  objConcil.NomeConciliacao := 'CIELO';
  objConcil.CfgEstabelecimentos := 'CFG_CIEEST';
  objConcil.CampoValorBruto := 'CIE_VALPAR';
  objConcil.CampoValorLiquido := 'CIE_LIQDEB';
  objConcil.CampoCodigoAutorizacao := 'CIE_CODAUT';
  objConcil.CampoNumeroNSU := 'CIE_NUMNSU';
  objConcil.CampoDataTransacaoVenda := 'CIE_DTAVEN';
  objConcil.CampoNumeroParcela := 'CIE_NUMPAR';
  objConcil.CampoTotalParcelas := 'CIE_TOTPAR';
  objConcil.CampoNumeroCartao := 'CIE_NUMCAR';
  objConcil.CampoDataRecebimento := 'CIE_DTAPAG';
  objConcil.CampoTipoRegistro := 'CIE_TIPREG';
  objConcil.CampoTipoTransacao := 'CIE_TIPTRA';
  objConcil.CfgPortadorAjustes := 'CIEPOR';
  objConcil.CfgPlanoDeContasAjustes := 'CIECTA';
  objConcil.CfgFornecedorAjustes := 'CIEFOR';
  objConcil.strEventoCancelamentoAjuste := 'CIEEVE';
  objConcil.CfgVlrTolerancia := 'CIETOL';

  objConcil.strChavePrimaria := 'CIE_TIPREG,CIE_CODEST,CIE_NUM_RO,CIE_DTAPAG,CIE_DTAVEN,CIE_NUMPAR,CIE_CODAUT,' +
                                'CIE_TIPTRA,CIE_STATUS,CIE_NUMNSU,CIE_VALPAR';

  If Not fDigPeriodo Then
    Exit(False);

  Result := TCieloFuncoes.ExecutaAguarde(fConciliaCielo, 'Aguarde... Filtrando registros do período.');
end;

function TConcilCielo.fConciliaCielo(prgStatus: TcxProgressBar): Boolean;
Begin
  Result := False;

  FConciliacaoComPixAtivado := True;
  FConsiderarGravame := VS_FuncoesExternas.fICfgSis('CIEGRA', varBoolean);
  FConsiderar03Negociacao := VS_FuncoesExternas.fICfgSis('CIEDNE', varBoolean);
  FConsiderarVendasCanceladas := Not TCieloFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis('CIECTT', varString));

  Try
    Try
      TCieloFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Selecionando registros para conciliação (CIELO).', False);
      fProcessaCieloPag(prgStatus);

      TCieloFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Selecionando registros para conciliação (CIELO).', False);
      ProcessaCieloVersao015(prgStatus);

      cdsConCar.Filter := '';
      cdsConCar.Filtered := False;

      TCieloFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Processando negociação de recebíveis (CIELO).', False);
      ProcessaNegociacaoRecebiveis(prgStatus);

      cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
      cdsBaiCar.Filtered := True;

      TCieloFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Processando Vendas Canceladas (CIELO).', False);
      ProcessaVendasCanceladas(prgStatus);

      cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
      cdsBaiCar.Filtered := True;

      FPossuiInconsistencia := False;

      TCieloFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Gravando registros do relatório (CIELO).', False);
      GravarRegistrosRelatorio(prgStatus);

      GetParentForm(prgStatus).Hide;

      If FPossuiInconsistencia Then
        TCieloFuncoes.fMensagem('','Foram encontradas inconsistências na importação dos arquivos!',['&OK']);

      If FListaRegistrosRelatorio.Count > 0 Then
        Result := GeraRelatorioConciliacao('CIELO', prgStatus);

      If Assigned(cdsAjustes) Then
      Begin
        cdsAjustes.Filter   := 'CIE_CONCIL=0';
        cdsAjustes.Filtered := True;
      End;

      blnReabre := Not Result;
      If Result Then
      Begin
        cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        cdsBaiCar.Filtered := True;

        Result := Not cdsBaiCar.IsEmpty;
        If Not Result Then
          TCieloFuncoes.fMensagem('ATENÇÃO','Nenhum pagamento foi conciliado no período selecionado!',['&OK'])
        Else
          TCieloFuncoes.fMensagem('AVISO','Conciliação da CIELO realizada com sucesso.',['&OK']);
      End;
    Finally
      TCieloFuncoes.FreeAndNilDatasets(cdsConCar);
      TCieloFuncoes.FreeAndNilDatasets(cdsAjustes);
      TCieloFuncoes.FreeAndNilDatasets(cdsBaixad);
    End;
  Except
    On E: Exception Do
    Begin
      Result := False;
      VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.fConciliaCielo]');
    End;
  End;
End;

function TConcilCielo.fProcessaCieloPag(pgbStatus: TcxProgressBar): Boolean;
Var
  LRegistroAnterior: Integer;

  LBuscaCartao: Boolean;

  LSQL,
  LTipoCartao,
  LParcela,
  LParcelaRelatorio,
  LChaveConciliacao,
  LCondicaoAjustes: String;

  LValorBruto,
  LValorLiquido,
  LValorLiquidoValidacao,
  LDiferenca: Double;

  LConsulta: TUniQuery;

  LCodigoAutorizacao: String;

  prcScroll: TprcScroll;

  LRegistroRelatorio: TItensRelatorioCartoes;
begin
  strRcxTcc := VS_FuncoesExternas.fICfgSis('RCXTCC');

  Application.ProcessMessages;

  LRegistroRelatorio := Nil;

  Try
    LConsulta := Nil;
    Try
      LConsulta := VS_FuncoesExternas.fICriaQuery;
      LConsulta.SQL.Text := 'SHOW TABLES LIKE "CIE_CIPGTO"';
      LConsulta.Open;
      If LConsulta.IsEmpty Then
      Begin
        TCieloFuncoes.fMensagem('ATENÇÃO','Não existem arquivos importados para a conciliação da CIELO!',['&OK']);
        Exit(False);
      End;

      LSQL := 'SELECT * FROM (' +
              RetornaSQLRegistrosConciliacao + ' UNION ALL ' +
              RetornaSQLRegistrosConciliacaoVersao015 +
              ') TMP ' +
              ' ORDER BY CIE_DTAPAG ';

      LConsulta.Close;
      LConsulta.SQL.Text := LSQL;

      LConsulta.ParamByName('DTAIN').AsString  := FormatDateTime('yyyy/MM/dd', dtaDtaIni);
      LConsulta.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy/MM/dd', dtaDtaFim);

      LConsulta.Open;

      cdsConCar := TCieloFuncoes.CriarClientDataSet(LConsulta);
      cdsConCar.Open;
    Finally
      TCieloFuncoes.FreeAndNilDatasets(LConsulta);
    End;

    //Para os Ajustes  - Tem que estar antes para não pegar outros ajustes de outras datas
    LCondicaoAjustes :=  ' (((CIE_TIPNEG IS NULL OR CIE_TIPNEG <> "CE") AND CIE_DTAPAG BETWEEN "' + FormatDateTime('yyyy-mm-dd', dtaDtaIni) + '" AND "' + FormatDateTime('yyyy-mm-dd', dtaDtaFim) + '") OR ' +
                         '  (CIE_TIPNEG = "CE" AND CIE_DTAAPR BETWEEN "' + FormatDateTime('yyyy-mm-dd', dtaDtaIni) + '" AND "' + FormatDateTime('yyyy-mm-dd', dtaDtaFim) + '")) ';

    pCalculaPeriodoFiltro('CIE_DTAVEN');

    //Filtrando Cartões na MOVCAR
    pgbStatus.Visible := False;
    TCieloFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando registros.', False);
    pFiltraCartoes;

    //Filtrando Cancelamentos/Ajustes
    LCondicaoAjustes := LCondicaoAjustes + StringReplace(fRetPesqPonVen(1), objConcil.CampoEstabelecimento, 'A.' + objConcil.CampoEstabelecimento, [rfReplaceAll]);
    LCondicaoAjustes := LCondicaoAjustes + ' AND (A.CIE_VERARQ IS NULL OR A.CIE_VERARQ<>"015") ';
    LCondicaoAjustes := LCondicaoAjustes + RetornaSQLWhereRegistrosAjustes;

    FiltrarCancelamentosPeriodo(LCondicaoAjustes,
                                RetornaSQLDescricaoAjustes,
                                ' IF((CIE_TIPTRA="02" AND CIE_TIPREG<>"3") OR (CIE_TIPREG IN ("3") AND CIE_RO_BRU > 0), '+
                                    'IF((CIE_TIPREG="B") OR (CIE_TIPARQ="03" AND CIE_TIPREG="E" AND CIE_TIPLAN="11"), CIE_LIQDEB, CIE_RO_BRU), 0) ');

    cdsConCar.Filter := 'CIE_VERARQ IS NULL OR CIE_VERARQ<>''015'' ';
    cdsConCar.Filtered := True;

    //Selecionando cartões já baixados/cadastrados no período
    pFiltraCartoesBaixados;

    TCieloFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros para conciliação (CIELO).', False);
    pgbStatus.Visible := True;

    If NenhumRegistroPagamentos Then
      Exit(False);

    CarregaIndicesBusca;

    FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                          'CIELO',
                                                          'CONCILIACAO',
                                                          RetornaFiltrosdigitados,
                                                          TCieloFuncoes.RetornaDataHoraServidor,
                                                          TCieloFuncoes.RetornaHoraServidor);

    TCieloFuncoes.pDisableControls(cdsBaiCar, prcScroll);

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsConCar.RecordCount;

    cdsConCar.First;
    While Not cdsConCar.EOF do
    Begin
      TCieloFuncoes.pStepStatusGravacao(pgbStatus);
      FTextoInconsistencia := EmptyStr;

      If cdsConCar.FieldByName('CIE_STATUS').AsString.Equals('00') Then
      Begin
        cdsConCar.Next;
        Continue;
      End;

      If Not MatchStr(cdsConCar.FieldByName('CIE_TIPREG').AsString, ['1', '6', '8']) Then
      Begin
        cdsConCar.Next;
        Continue;
      End;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LTipoCartao := RetornaTipoCartao;

      LValorLiquidoValidacao := cdsConCar.FieldByName('VALLIQ').AsFloat;

      LValorBruto := cdsConCar.FieldByName('CIE_VALPAR').Value;
      LValorLiquido :=  TCieloFuncoes.IIF(LValorLiquidoValidacao > 0,
                                          LValorLiquidoValidacao,
                                          cdsConCar.FieldByName('CIE_RO_LIQ').Value *
                                              (LValorBruto / (cdsConCar.FieldByName('CIE_RO_BRU').Value -
                                                              cdsConCar.FieldByName('CIE_RO_REJ').Value)));

      LCodigoAutorizacao := cdsConCar.FieldByName('CIE_CODAUT').AsString;
      If Not LTipoCartao.Equals('PIX') Then
        LCodigoAutorizacao := TCieloFuncoes.fStrZero(RightStr(Trim(cdsConCar.FieldByName('CIE_CODAUT').AsString), 6), 6);

      LParcela := TCieloFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName('CIE_NUMPAR').AsString = '00', '1', cdsConCar.FieldByName('CIE_NUMPAR').AsString)));

      LParcelaRelatorio := TCieloFuncoes.IIF(cdsConCar.FieldByName('CIE_NUMPAR').AsInteger = 0, '01', cdsConCar.FieldByName('CIE_NUMPAR').AsString) + '/' +
                           TCieloFuncoes.IIF(cdsConCar.FieldByName('CIE_NUMPAR').AsInteger = 0, '01', cdsConCar.FieldByName('CIE_TOTPAR').AsString);

      LBuscaCartao := fBuscaCartao(LCodigoAutorizacao,
                                   TCieloFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('CIE_NUMNSU').AsString, 14)), 14),
                                   cdsConCar.FieldByName('CODEMP').AsString,
                                   LParcela,
                                   cdsConCar.FieldByName('CIE_DTAVEN').AsDateTime,
                                   0,
                                   True);

      If LBuscaCartao Then
      Begin
        LDiferenca := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto;
        FTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);
        If fBetWeen(LDiferenca, -FTolerancia, FTolerancia) Then
        Begin
          LChaveConciliacao := 'CIE_' + IntToStr(StrtoInt64(cdsConCar.FieldByName('CIE_NUM_RO').AsString)) + '_' +
                               cdsConCar.FieldByName('CIE_CODAUT').AsString + '_' +
                               LParcela + '_' +
                               cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                               FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('CIE_DTAVEN').AsDateTime);

          MarcarCartaoEncontradoArquivo(LValorLiquido,
                                        cdsConCar.FieldByName('CIE_TIPREG').AsString.Equals('6'),
                                        LRegistroRelatorio,
                                        LChaveConciliacao,
                                        cdsConCar);

          If cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
          Begin
            If PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(LValorBruto, cdsBaiCar) Then
              FTextoInconsistencia := RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa;

            If MatchStr(cdsConCar.FieldByName('CIE_TIPFIN').AsString, ['A', 'C']) Then
            Begin
              FTextoInconsistencia := 'Cartão conciliado com valor negociado anteriormente';

              cdsBaiCar.Edit;
              cdsBaiCar.FieldByName('NEGOCIADO_ANTERIORMENTE').AsString := 'S';
              cdsBaiCar.Post;
            End;
          End;
        End
        Else
        Begin
          //Verificando outras liberações com a mesma data
          LRegistroAnterior := cdsBaiCar.RecNo;
          cdsBaiCar.Next;

          While RegistroPossuiAMesmaAutorizacao(LCodigoAutorizacao,
                                                LParcela,
                                                cdsConCar.FieldByName('CODEMP').AsString,
                                                cdsConCar.FieldByName('CIE_DTAVEN').AsString) Do
          Begin
            LDiferenca := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto;
            FTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);
            If fBetween(LDiferenca, -FTolerancia, FTolerancia) Then
            Begin
              LChaveConciliacao := 'CIE_' + IntToStr(StrtoInt64(cdsConCar.FieldByName('CIE_NUM_RO').AsString)) + '_' +
                               cdsConCar.FieldByName('CIE_CODAUT').AsString + '_' +
                               LParcela + '_' +
                               cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                               FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('CIE_DTAVEN').AsDateTime);

              MarcarCartaoEncontradoArquivo(LValorLiquido,
                                            cdsConCar.FieldByName('CIE_TIPREG').AsString.Equals('6'),
                                            LRegistroRelatorio,
                                            LChaveConciliacao,
                                            cdsConCar);

              If cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
              Begin
                If PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(LValorBruto, cdsBaiCar) Then
                  FTextoInconsistencia := RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa;

                If MatchStr(cdsConCar.FieldByName('CIE_TIPFIN').AsString, ['A', 'C']) Then
                Begin
                  FTextoInconsistencia := 'Cartão conciliado com valor negociado anteriormente';

                  cdsBaiCar.Edit;
                  cdsBaiCar.FieldByName('NEGOCIADO_ANTERIORMENTE').AsString := 'S';
                  cdsBaiCar.Post;
                End;
              End;

              Break;
            End;

            cdsBaiCar.Next;

            If cdsBaiCar.Eof Then
              Break;
          End;
          FTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);
          If Not fBetween(LDiferenca, -FTolerancia, FTolerancia) Then
          Begin
            cdsBaiCar.RecNo := LRegistroAnterior;
            FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização duplicada';
          End;
        End;

      End
      Else If TCieloFuncoes.fEmptyStr(FTextoInconsistencia) Then
      Begin
        blnAutomatica := cdsConCar.FieldByName('CIE_CONCIL').AsString.Equals('1');

        cdsBaixad.First;
        LBuscaCartao := fBuscaCartaoBaixado(LCodigoAutorizacao,
                                            TCieloFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('CIE_NUMNSU').AsString, 14)), 14),
                                            cdsConCar.FieldByName('CODEMP').AsString,
                                            LParcela,
                                            cdsConCar.FieldByName('CIE_DTAVEN').AsDateTime,
                                            True);

        FTextoInconsistencia := 'Cartão já foi baixado';
        If Not LBuscaCartao Then
          FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';
      End;

      {Gerando registro do relatório}
      FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
      If Not FTextoInconsistencia.IsEmpty Then
      Begin
        LRegistroRelatorio.Descricao := FTextoInconsistencia;
        LRegistroRelatorio.SomarNoTotal := 'N';

        If Not MatchStr(LRegistroRelatorio.Descricao, [RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa,
                                                       'Cartão conciliado com valor negociado anteriormente']) Then
        Begin
          LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
          LRegistroRelatorio.SomarNoTotal := 'S';
        End;
      End;
      LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('CIE_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName('CIE_CODEST').AsString;
      LRegistroRelatorio.CodigoEmpresa := cdsConCar.FieldByName('CODEMP').AsString;
      LRegistroRelatorio.NumeroNSU := TCieloFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('CIE_NUMNSU').AsString, 14)), 14);
      LRegistroRelatorio.CodigoAutorizacao := LCodigoAutorizacao;
      LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('CIE_NUM_RO').AsString;
      LRegistroRelatorio.NumeroCartao := cdsConCar.FieldByName('CIE_NUMCAR').AsString;

      If LRegistroRelatorio.TipoCartao.IsEmpty Then
        LRegistroRelatorio.TipoCartao := LTipoCartao;

      LRegistroRelatorio.Parcela := LeftStr(LParcelaRelatorio, 2);
      LRegistroRelatorio.TotalParcelas := RightStr(LParcelaRelatorio, 2);

      LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('CIE_DTAPAG').AsDateTime;
      LRegistroRelatorio.DataVenda := cdsConCar.FieldByName('CIE_DTAVEN').AsDateTime;
      LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('CIE_DTAPAG').AsDateTime;
      If Not MatchStr(cdsConCar.FieldByName('CIE_TIPREG').AsString, ['1', '8']) Then
        LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('CIE_DTAANT').AsDateTime;

      LRegistroRelatorio.ValorBruto := LValorBruto;
      LRegistroRelatorio.ValorLiquido := LValorLiquido;

      LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

      cdsConCar.Next;
    End;
  Except
    Raise;
  End;

  Result := True;
end;

function TConcilCielo.NenhumRegistroPagamentos: Boolean;
begin
  Result := cdsConCar.IsEmpty;

  If Result Then
  Begin
    If Assigned(cdsAjustes) Then
      Result := cdsAjustes.IsEmpty;
  End;
end;

function TConcilCielo.ProcessaVendasCanceladas(pgbStatus: TcxProgressBar): Boolean;
  Var
    LConsulta: TUniQuery;
    LSQL: String;
    LRegistroRelatorio: TItensRelatorioCartoes;
    LVendasCanceladas : TUniClientDataset;
begin
  Result := True;

  If not FConsiderarVendasCanceladas Then
    exit;

  LConsulta := nil;
  LVendasCanceladas  := nil;

  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;

    LSQL := '';
    LSQL := LSQL + ' SELECT A.*,                                             ';
    LSQL := LSQL + ' COALESCE(SIS_CODEMP, "") AS CODEMP                      ';
    LSQL := LSQL + ' FROM CIE_CIPGTO A                                       ';
    LSQL := LSQL + ' LEFT JOIN CFGSIS ON SIS_CODCFG IN ("CFG_CIEEST", "CFG_CIELNK") AND ';
    LSQL := LSQL + '                     LOCATE(A.CIE_CODEST, SIS_VALCFG) > 0 ';
    LSQL := LSQL + ' WHERE A.CIE_DTAPAG BETWEEN :DTAIN AND :DTAFIM           ';
    LSQL := LSQL + StringReplace(fRetPesqPonVen(0), objConcil.CampoEstabelecimento, 'A.' + objConcil.CampoEstabelecimento, [rfReplaceAll]);
    LSQL := LSQL + ' AND A.CIE_TIPREG = "E" AND A.CIE_TIPTRA = "00" AND A.CIE_STATUS = "03" AND A.CIE_RO_BRU < 0 ';
    LSQL := LSQL + ' ORDER BY A.CIE_DTAPAG                                    ';

    LConsulta.SQL.Text := LSQL;
    LConsulta.ParamByName('DTAIN').AsDateTime  := StrToDateTime(strDtaIni);
    LConsulta.ParamByName('DTAFIM').AsDateTime := StrToDateTime(strDtaFim);
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    LVendasCanceladas := TCieloFuncoes.CriarClientDataSet(LConsulta);

    If Not Assigned(FRelatorioConciliacao) Then
      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'CIELO', 'CONCILIACAO', RetornaFiltrosdigitados,
                                                            TCieloFuncoes.RetornaDataHoraServidor,
                                                            TCieloFuncoes.RetornaHoraServidor);

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := LConsulta.RecordCount;

    LVendasCanceladas.First;

    While Not LVendasCanceladas.Eof Do
    Begin
      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LRegistroRelatorio.ValorBruto   := TCieloFuncoes.fFormataFloat(Abs(LVendasCanceladas.FieldByName('CIE_RO_BRU').AsFloat) * (-1), 2);
      LRegistroRelatorio.ValorLiquido := TCieloFuncoes.fFormataFloat(Abs(LVendasCanceladas.FieldByName('CIE_RO_LIQ').AsFloat) * (-1), 2);
      LRegistroRelatorio.ValorTaxas   := TCieloFuncoes.fFormataFloat(Max(0, Abs(LRegistroRelatorio.ValorBruto) - Abs(LRegistroRelatorio.ValorLiquido)), 2);

      LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
      LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
      LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';
      LRegistroRelatorio.DescricaoAjuste := 'CANCELAMENTO DE VENDA';

      LRegistroRelatorio.CodigoEmpresa := LVendasCanceladas.FieldByName('CODEMP').AsString;//LEmpresaConfiguracao;
      LRegistroRelatorio.CodigoEstabelecimento := LVendasCanceladas.FieldByName('CIE_CODEST').AsString;
      LRegistroRelatorio.NumeroNSU := TCieloFuncoes.fStrZero(Trim(RightStr(LVendasCanceladas.FieldByName('CIE_NUMNSU').AsString, 14)), 14);
      LRegistroRelatorio.NumeroCartao := LVendasCanceladas.FieldByName('CIE_NUMCAR').AsString;
      LRegistroRelatorio.Parcela := TCieloFuncoes.fStrZero(LVendasCanceladas.FieldByName('CIE_NUMPAR').AsString, 2);
      LRegistroRelatorio.TotalParcelas := TCieloFuncoes.fStrZero(LVendasCanceladas.FieldByName('CIE_TOTPAR').AsString, 2);  //CIE_NUMPAR talvez por ser 1
      LRegistroRelatorio.CodigoAutorizacao := TCieloFuncoes.fStrZero(RightStr(Trim(LVendasCanceladas.FieldByName('CIE_CODAUT').AsString), 6), 6);

      LRegistroRelatorio.ResumoVenda := LVendasCanceladas.FieldByName('CIE_CODTID').AsString;

      LRegistroRelatorio.DataVenda := LVendasCanceladas.FieldByName('CIE_DTAVEN').AsDateTime;
      LRegistroRelatorio.DataVencimento := LVendasCanceladas.FieldByName('CIE_VENORI').AsDateTime;
      LRegistroRelatorio.DataPagamento := LVendasCanceladas.FieldByName('CIE_DTAPAG').AsDateTime;

      LRegistroRelatorio.Conciliado := LVendasCanceladas.FieldByName('CIE_CONCIL').AsInteger;
      LRegistroRelatorio.NomeArquivo := LVendasCanceladas.FieldByName('CIE_NOMARQ').AsString;

      LRegistroRelatorio.RegistroVendaCancelada := 'S';

      LRegistroRelatorio.RegistroIncompleto := 'N';
      LRegistroRelatorio.RegistroIncompleto := ConfiguracoesNegociacaoEstaoIncompletas(LVendasCanceladas.FieldByName('CODEMP').AsString);

      GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, LVendasCanceladas);

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      LVendasCanceladas.Next;
      TCieloFuncoes.pStepStatusGravacao(pgbStatus);
    End;

  Finally
    TCieloFuncoes.FreeAndNilDatasets(LVendasCanceladas);
    TCieloFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;


function TConcilCielo.ProcessaCieloVersao015(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    LValorBruto,
    LDifererenca,
    LValorLiquido,
    LValorMarcado: Double;

    LSQLCondicaoAjustes,
    LCodigoAutorizacao,
    LParcelaLetra,
    LParcelaNumero,
    LTotalParcelas,
    LTipoCartao,
    LChaveConciliacao: String;

    LRegistroAtual: Integer;

    LBuscaCartao: Boolean;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  FTextoInconsistencia := EmptyStr;

  Application.ProcessMessages;

  //Para os Ajustes  - Tem que estar antes para não pegar outros ajustes de outras datas
  LSQLCondicaoAjustes :=  ' CIE_DTAPAG BETWEEN "' + FormatDateTime('yyyy-mm-dd', StrToDateTime(strDtaIni)) + '" AND "' +
                                                    FormatDateTime('yyyy-mm-dd', StrToDateTime(strDtaFim)) + '" ';

  //Filtrando Cancelamentos/Ajustes
  LSQLCondicaoAjustes := LSQLCondicaoAjustes + StringReplace(fRetPesqPonVen(1), objConcil.CampoEstabelecimento, 'A.' + objConcil.CampoEstabelecimento, [rfReplaceAll]);
  LSQLCondicaoAjustes := LSQLCondicaoAjustes + RetornaSQLWhereRegistrosAjustesVersao015;

  Try
    FiltrarCancelamentosPeriodo(LSQLCondicaoAjustes,
                                RetornaSQLDescricaoAjustesVersao015,
                                ' IF(CIE_LIQDEB>0, CIE_LIQDEB, 0) ');

    cdsConCar.Filter := 'CIE_VERARQ=''015'' ';
    cdsConCar.Filtered := True;

    If NenhumRegistroPagamentos Then
      Exit(False);

    CarregaIndicesBusca;

    If Not Assigned(FRelatorioConciliacao) Then
      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'CIELO',
                                                            'CONCILIACAO',
                                                            RetornaFiltrosdigitados,
                                                            TCieloFuncoes.RetornaDataHoraServidor,
                                                            TCieloFuncoes.RetornaHoraServidor);

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsConCar.RecordCount;

    cdsConCar.First;
    While Not cdsConCar.EOF do
    Begin
      TCieloFuncoes.pStepStatusGravacao(pgbStatus);
      FTextoInconsistencia := EmptyStr;

      If Not MatchStr(cdsConCar.FieldByName('CIE_TIPREG').AsString, ['E', '8']) Then
      Begin
        cdsConCar.Next;

        Continue;
      End;

      If cdsConCar.FieldByName('CIE_INDREJ').AsString.Equals('S') Then
      Begin
        cdsConCar.Next;

        Continue;
      End;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LTipoCartao := RetornaTipoCartaoV015;

      LCodigoAutorizacao := cdsConCar.FieldByName('CIE_CODAUT').AsString;
      If Not LTipoCartao.Equals('PIX') Then
        LCodigoAutorizacao := TCieloFuncoes.fStrZero(RightStr(Trim(cdsConCar.FieldByName('CIE_CODAUT').AsString), 6), 6);

      LParcelaLetra := TCieloFuncoes.fGetLetraAlfa(StrtoInt(IfThen(cdsConCar.FieldByName('CIE_NUMPAR').AsString = '00', '1', cdsConCar.FieldByName('CIE_NUMPAR').AsString)));
      LParcelaNumero := TCieloFuncoes.fStrZero(StrtoInt(IfThen(cdsConCar.FieldByName('CIE_NUMPAR').AsString = '00', '1', cdsConCar.FieldByName('CIE_NUMPAR').AsString)).Tostring, 2);
      LTotalParcelas := TCieloFuncoes.fStrZero(StrtoInt(IfThen(cdsConCar.FieldByName('CIE_NUMPAR').AsString = '00', '1', cdsConCar.FieldByName('CIE_TOTPAR').AsString)).Tostring, 2);

      LValorLiquido := TCieloFuncoes.fFormataFloat(cdsConCar.FieldByName('VALLIQ').AsFloat, 2);

      LValorBruto  := TCieloFuncoes.fFormataFloat(cdsConCar.FieldByName('CIE_VALPAR').AsFloat, 2);
      LValorMarcado := TCieloFuncoes.IIF(TCieloFuncoes.fFormataFloat(LValorLiquido, 2) > 0,
                                         LValorLiquido,
                                         TCieloFuncoes.fFormataFloat(cdsConCar.FieldByName('CIE_VALPRO').AsFloat, 2));

      LBuscaCartao := fBuscaCartao(LCodigoAutorizacao,
                                   TCieloFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('CIE_NUMNSU').AsString, 14)), 14),
                                   cdsConCar.FieldByName('CODEMP').AsString,
                                   LParcelaLetra,
                                   cdsConCar.FieldByName('CIE_DTAVEN').AsDateTime,
                                   0,
                                   True);

      If LBuscaCartao Then
      Begin
        LDifererenca := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto;
        FTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);

        If fBetween(LDifererenca, -FTolerancia, FTolerancia) Then
        Begin
          LChaveConciliacao := 'CIE_' + IntToStr(StrtoInt64(cdsConCar.FieldByName('CIE_NUM_RO').AsString)) + '_' +
                               cdsConCar.FieldByName('CIE_CODAUT').AsString + '_' +
                               LParcelaLetra + '_' +
                               cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                               FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('CIE_DTAVEN').AsDateTime);

          MarcarCartaoEncontradoArquivo(LValorMarcado,
                                        LTipoCartao.Equals('ANTECIPAÇÃO'),
                                        LRegistroRelatorio,
                                        LChaveConciliacao,
                                        cdsConCar);

          If cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
          Begin
            If PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(LValorBruto, cdsBaiCar) Then
              FTextoInconsistencia := RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa;

            If cdsConCar.FieldByName('CIE_INDGRA').AsString.Equals('S') Then
            Begin
              FTextoInconsistencia := 'Cartão conciliado com valor negociado anteriormente';

              cdsBaiCar.Edit;
              cdsBaiCar.FieldByName('NEGOCIADO_ANTERIORMENTE').AsString := 'S';
              cdsBaiCar.Post;
            End;
          End;
        End
        Else
        Begin
          //Verificando outras liberações com a mesma data
          LRegistroAtual := cdsBaiCar.RecNo;
          cdsBaiCar.Next;
          While RegistroPossuiAMesmaDataELiberacao(LCodigoAutorizacao, LParcelaLetra) Do
          Begin
            LDifererenca := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto;
            FTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);

            If fBetween(LDifererenca, -FTolerancia, FTolerancia) Then
            Begin
              LChaveConciliacao := 'CIE_' + IntToStr(StrtoInt64(cdsConCar.FieldByName('CIE_NUM_RO').AsString)) + '_' +
                                   cdsConCar.FieldByName('CIE_CODAUT').AsString + '_' +
                                   LParcelaLetra + '_' +
                                   cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                                   FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('CIE_DTAVEN').AsDateTime);

              MarcarCartaoEncontradoArquivo(LValorMarcado,
                                            LTipoCartao.Equals('ANTECIPAÇÃO'),
                                            LRegistroRelatorio,
                                            LChaveConciliacao,
                                            cdsConCar);

              If cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
              Begin
                If PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(LValorBruto, cdsBaiCar) Then
                  FTextoInconsistencia := RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa;

                If MatchStr(cdsConCar.FieldByName('CIE_TIPFIN').AsString, ['A', 'C']) Then
                Begin
                  FTextoInconsistencia := 'Cartão conciliado com valor negociado anteriormente';

                  cdsBaiCar.Edit;
                  cdsBaiCar.FieldByName('NEGOCIADO_ANTERIORMENTE').AsString := 'S';
                  cdsBaiCar.Post;
                End;
              End;

              Break;
            End;

            cdsBaiCar.Next;

            If cdsBaiCar.Eof Then
              Break;
          End;

          FTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);
          If Not fBetween(LDifererenca, -FTolerancia, FTolerancia) Then
          Begin
            cdsBaiCar.RecNo := LRegistroAtual;
            FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização duplicada';
          End;

        End;

      End
      Else If TCieloFuncoes.fEmptyStr(FTextoInconsistencia) Then
      Begin
        blnAutomatica := cdsConCar.FieldByName('CIE_CONCIL').AsString.Equals('1');

        cdsBaixad.First;
        LBuscaCartao := fBuscaCartaoBaixado(LCodigoAutorizacao,
                                            TCieloFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('CIE_NUMNSU').AsString, 14)), 14),
                                            cdsConCar.FieldByName('CODEMP').AsString,
                                            LParcelaLetra,
                                            cdsConCar.FieldByName('CIE_DTAVEN').AsDateTime,
                                            True);

        FTextoInconsistencia := 'Cartão já foi baixado';
        If Not LBuscaCartao Then
          FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';
      End;

      {Gerando registro do relatório}
      FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
      If Not FTextoInconsistencia.IsEmpty Then
      Begin
        LRegistroRelatorio.Descricao := FTextoInconsistencia;
        LRegistroRelatorio.SomarNoTotal := 'N';

        If Not MatchStr(LRegistroRelatorio.Descricao, [RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa,
                                                       'Cartão conciliado com valor negociado anteriormente']) Then
        Begin
          LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
          LRegistroRelatorio.SomarNoTotal := 'S';
        End;
      End;
      LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('CIE_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName('CIE_CODEST').AsString;
      LRegistroRelatorio.CodigoEmpresa := cdsConCar.FieldByName('CODEMP').AsString;
      LRegistroRelatorio.NumeroNSU := TCieloFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('CIE_NUMNSU').AsString, 14)), 14);
      LRegistroRelatorio.CodigoAutorizacao := LCodigoAutorizacao;
      LRegistroRelatorio.ResumoVenda := Copy(cdsConCar.FieldByName('CIE_CHA_UR').AsString, 37, 16);
      LRegistroRelatorio.NumeroCartao := cdsConCar.FieldByName('CIE_NUMCAR').AsString;

      If LRegistroRelatorio.TipoCartao.IsEmpty Then
        LRegistroRelatorio.TipoCartao := LTipoCartao;

      LRegistroRelatorio.Parcela := LParcelaNumero;
      LRegistroRelatorio.TotalParcelas := LTotalParcelas;

      LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('CIE_DTAPAG').AsDateTime;
      LRegistroRelatorio.DataVenda := cdsConCar.FieldByName('CIE_DTAVEN').AsDateTime;
      LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('CIE_DTAPAG').AsDateTime;
      If Not MatchStr(cdsConCar.FieldByName('CIE_TIPREG').AsString, ['E', '8']) Then
        LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('CIE_DTAANT').AsDateTime;

      LRegistroRelatorio.ValorBruto := LValorBruto;
      LRegistroRelatorio.ValorLiquido := LValorLiquido;

      LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

      cdsConCar.Next;
    End;
  Except
    Raise;
  End;

  Result := True;
end;

function TConcilCielo.ProcessaNegociacaoRecebiveis(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    LConsulta: TUniQuery;

    LSQL: String;

    LRegistroRelatorio: TItensRelatorioCartoes;

    LNegociacaoFinal,
    LNegociacaoValidacao: TUniClientDataset;
begin
  Result := True;

  LConsulta := Nil;
  LNegociacaoFinal := Nil;
  LNegociacaoValidacao := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;

    LSQL := '';
    LSQL := LSQL + ' SELECT A.*,                                             ';
    LSQL := LSQL + ' COALESCE(SIS_CODEMP, "") AS CODEMP,                     ';
    LSQL := LSQL + ' COALESCE(EMP_NOMEMP, "") AS EMP_NOMEMP                  ';
    LSQL := LSQL + ' FROM CIE_CIPGTO A                                       ';
    LSQL := LSQL + ' LEFT JOIN CFGSIS ON SIS_CODCFG IN ("CFG_CIEEST", "CFG_CIELNK") AND ';
    LSQL := LSQL + '                     LOCATE(A.CIE_CODEST, SIS_VALCFG) > 0 ';
    LSQL := LSQL + ' LEFT JOIN CADEMP ON SIS_CODEMP=EMP_CODEMP               ';

    LSQL := LSQL + ' WHERE A.CIE_DTAPAG BETWEEN :DTAIN AND :DTAFIM           ';

    LSQL := LSQL + StringReplace(fRetPesqPonVen(0), objConcil.CampoEstabelecimento, 'A.' + objConcil.CampoEstabelecimento, [rfReplaceAll]);

    LSQL := LSQL + ' AND ((A.CIE_TIPREG="B")';

    If FConsiderar03Negociacao Then
      LSQL := LSQL + ' OR (A.CIE_TIPARQ = "03" AND A.CIE_TIPREG="E" AND A.CIE_TIPLAN = "11")';

    LSQL := LSQL + ' )';

    LSQL := LSQL + ' ORDER BY A.CIE_DTAPAG, A.CIE_CODTID                     ';

    LConsulta.SQL.Text := LSQL;

    LConsulta.ParamByName('DTAIN').AsDateTime  := StrToDateTime(strDtaIni);
    LConsulta.ParamByName('DTAFIM').AsDateTime := StrToDateTime(strDtaFim);

    LConsulta.Open;

    If LConsulta.IsEmpty THen
    Begin
      If NenhumRegistroPagamentos Then
      Begin
        TCieloFuncoes.fMensagem('ATENÇÃO','Não existem arquivos importados nesse período de recebimento!',['&OK']);
        cdsConCar.Close;
        Result := False;
        blnReabre := True;
      End;

      Exit;
    End;

    LNegociacaoFinal := TCieloFuncoes.CriarClientDataSet(LConsulta);
    LNegociacaoValidacao := TCieloFuncoes.CriarClientDataset(LConsulta);

    //Página 20 do manual
    (*
       • Antecipações de agenda Cielo demonstradas nos
         registros “B” irão gerar registros de contrapartida
         nos arquivos CIELO03 com o tipo de lançamento
         “11” mantendo o número da negociação de antecipação.
    *)
    RealizaRemocaoDaContrapartidaDasNegicacoesCielo(LNegociacaoFinal,
                                                    LNegociacaoValidacao);

    If Not Assigned(FRelatorioConciliacao) Then
      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'CIELO',
                                                            'CONCILIACAO',
                                                            RetornaFiltrosdigitados,
                                                            TCieloFuncoes.RetornaDataHoraServidor,
                                                            TCieloFuncoes.RetornaHoraServidor);

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := LNegociacaoFinal.RecordCount;

    LNegociacaoFinal.First;
    While Not LNegociacaoFinal.Eof Do
    Begin
      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LRegistroRelatorio.ValorBruto := LNegociacaoFinal.FieldByName('CIE_RO_BRU').AsFloat;
      LRegistroRelatorio.ValorLiquido := LNegociacaoFinal.FieldByName('CIE_RO_LIQ').AsFloat;

      LRegistroRelatorio.Descricao := 'NEGOCIAÇÃO DE RECEBÍVEIS';
      LRegistroRelatorio.TipoDoRegistro := 'NEGOCIAÇÃO';
      LRegistroRelatorio.TipoCartao := 'ANTECIPAÇÃO';
      LRegistroRelatorio.DescricaoAjuste := 'NEGOCIAÇÃO DE RECEBÍVEIS';

      LRegistroRelatorio.CodigoEmpresa := LNegociacaoFinal.FieldByName('CODEMP').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := LNegociacaoFinal.FieldByName('CIE_CODEST').AsString;
      LRegistroRelatorio.NumeroNSU := TCieloFuncoes.fStrZero(Trim(RightStr(LNegociacaoFinal.FieldByName('CIE_NUMNSU').AsString, 14)), 14);
      LRegistroRelatorio.NumeroCartao := LNegociacaoFinal.FieldByName('CIE_CODBAN').AsString;
      LRegistroRelatorio.Parcela := LNegociacaoFinal.FieldByName('CIE_NUMPAR').AsString;
      LRegistroRelatorio.TotalParcelas := LNegociacaoFinal.FieldByName('CIE_NUMPAR').AsString;
      LRegistroRelatorio.CodigoAutorizacao := TCieloFuncoes.fStrZero(RightStr(Trim(LNegociacaoFinal.FieldByName('CIE_CODAUT').AsString), 6), 6);

      LRegistroRelatorio.ResumoVenda := LNegociacaoFinal.FieldByName('CIE_CODTID').AsString;

      LRegistroRelatorio.DataVenda := LNegociacaoFinal.FieldByName('CIE_DTAVEN').AsDateTime;
      LRegistroRelatorio.DataVencimento := LNegociacaoFinal.FieldByName('CIE_VENORI').AsDateTime;
      LRegistroRelatorio.DataPagamento := LNegociacaoFinal.FieldByName('CIE_DTAPAG').AsDateTime;

      LRegistroRelatorio.DescricaoBandeira := RetornaBandeiraCielo(LRegistroRelatorio.NumeroCartao);
      LRegistroRelatorio.Conciliado := LNegociacaoFinal.FieldByName('CIE_CONCIL').AsInteger;
      LRegistroRelatorio.NomeArquivo := LNegociacaoFinal.FieldByName('CIE_NOMARQ').AsString;

      LRegistroRelatorio.NumeroNegociacao := LNegociacaoFinal.FieldByName('CIE_CODTID').AsString;
      LRegistroRelatorio.RegistroNegociacao := 'S';

      LRegistroRelatorio.RegistroIncompleto := 'N';

      LRegistroRelatorio.RegistroIncompleto := ConfiguracoesNegociacaoEstaoIncompletas(LNegociacaoFinal.FieldByName('CODEMP').AsString);

      GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, LNegociacaoFinal);

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      LNegociacaoFinal.Next;

      TCieloFuncoes.pStepStatusGravacao(pgbStatus);
    End;
  Finally
    TCieloFuncoes.FreeAndNilDatasets(LConsulta);
    TCieloFuncoes.FreeAndNilDatasets(LNegociacaoFinal);
    TCieloFuncoes.FreeAndNilDatasets(LNegociacaoValidacao);
  End;
end;

procedure TConcilCielo.RealizaRemocaoDaContrapartidaDasNegicacoesCielo(
  var ADatasetNegociacao, ADatasetValidacao: TUniClientDataset);
  Var
    LAchouRegistroB: Boolean;
begin
  ADatasetValidacao.Filter := 'CIE_TIPREG=''E'' AND CIE_TIPLAN=''11'' ';
  ADatasetValidacao.Filtered := True;

  If ADatasetValidacao.IsEmpty Then
    Exit;

  If ADatasetValidacao.RecordCount = ADatasetNegociacao.RecordCount Then
    Exit;

  ADatasetValidacao.First;
  While Not ADatasetValidacao.Eof Do
  Begin
    LAchouRegistroB := ADatasetNegociacao.Locate('CIE_CHA_UR;CIE_VENORI;CIE_DTAPAG;CIE_CODBAN;CIE_VALTOT;CIE_CODEST;CIE_TIPARQ;CIE_TIPREG',
                                      VarArrayOf([TCieloFuncoes.fStrZero(ADatasetValidacao.FieldByName('CIE_TRACON').AsString, 20),
                                                  ADatasetValidacao.FieldByName('CIE_VENORI').AsDateTime,
                                                  ADatasetValidacao.FieldByName('CIE_DTAPAG').AsDateTime,
                                                  ADatasetValidacao.FieldByName('CIE_CODBAN').AsString,
                                                  Abs(ADatasetValidacao.FieldByName('CIE_VALTOT').AsFloat),
                                                  ADatasetValidacao.FieldByName('CIE_CODEST').AsString,
                                                  '15', 'B']), [loPartialKey]);

    If LAchouRegistroB Then
    Begin
      If ADatasetNegociacao.Locate('CIE_TRACON;CIE_VENORI;CIE_DTAPAG;CIE_CODBAN;CIE_VALTOT;CIE_CODEST;CIE_TIPARQ;CIE_TIPREG',
                       VarArrayOf([ADatasetValidacao.FieldByName('CIE_TRACON').AsString,
                                   ADatasetValidacao.FieldByName('CIE_VENORI').AsDateTime,
                                   ADatasetValidacao.FieldByName('CIE_DTAPAG').AsDateTime,
                                   ADatasetValidacao.FieldByName('CIE_CODBAN').AsString,
                                   ADatasetValidacao.FieldByName('CIE_VALTOT').AsFloat,
                                   ADatasetValidacao.FieldByName('CIE_CODEST').AsString,
                                   ADatasetValidacao.FieldByName('CIE_TIPARQ').AsString,
                                   ADatasetValidacao.FieldByName('CIE_TIPREG').AsString]), []) Then
        ADatasetNegociacao.Delete;
    End;

    ADatasetValidacao.Next;
  End;
end;

function TConcilCielo.RegistroPossuiAMesmaAutorizacao(AAutorizacao, AParcela,
  AEmpresa, ADataCupom: String): Boolean;
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

  Result := cdsBaiCar.FieldByName('MCA_DTACUP').AsString.Equals(ADataCupom);

  If Not Result Then
    Exit;

  Result := cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('D');
end;

function TConcilCielo.RegistroPossuiAMesmaDataELiberacao(
  ACodigoAutorizacao, AParcelaLetra: String): Boolean;
begin
  Result := False;

  If Not cdsBaiCar.FieldByName('MCA_NUMCCD').AsString.Equals(ACodigoAutorizacao)  Then
    Exit;

  If Not cdsBaiCar.FieldByName('PARDUP').AsString.Equals(AParcelaLetra) Then
    Exit;

  If Not cdsConCar.FieldByName('CODEMP').AsString.IsEmpty Then
  Begin
    If Not cdsBaiCar.FieldByName('MCA_EMPRCX').AsString.Equals(cdsConCar.FieldByName('CODEMP').AsString) Then
      Exit;
  End;

  If Not cdsBaiCar.FieldByName('MCA_DTACUP').AsString.Equals(cdsConCar.FieldByName('CIE_DTAVEN').AsString) Then
    Exit;

  If Not cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('D') Then
    Exit;

  Result := True;
end;

function TConcilCielo.RetornaBandeiraCielo(ACodigoBandeira: String): String;
begin
  Result := '';

  If ACodigoBandeira.IsEmpty Then
    Exit;

  Try
    Case StrToInt(ACodigoBandeira) Of
      1: Result := 'VISA';
      2: Result := 'MASTERCARD';
      3: Result := 'AMEX';
      6: Result := 'SOROCRED';
      7: Result := 'ELO';
      9: Result := 'DINERS';
      11: Result := 'AGIPLAN';
      15: Result := 'BANESCARD';
      23: Result := 'CABAL';
      29: Result := 'CREDSYSTEM';
      35: Result := 'ESPLANADA';
      40: Result := 'HIPERCARD';
      60: Result := 'JCB';
      64: Result := 'CREDZ';
      72: Result := 'HIPER';
      75: Result := 'OUROCARD';
      Else Result := 'OUTROS';
    End;
  Except
    Result := 'OUTROS';
  End;
end;

function TConcilCielo.RetornaSQLDescricaoAjustes: String;
begin
  Result := ' IF(CIE_TIPREG IN ("3"), ' +
            '    IF(CIE_VALPAR > 0, "AJUSTE DE CRÉDITO - CESSÃO/GRAVAME", "AJUSTE DE DÉBITO - CESSÃO/GRAVAME"), ' +
            '    IF((CIE_TIPREG="7") OR (CIE_TIPTRA="04"), ' +
            '        "AJUSTE DE DÉBITO/ALUGUEL DE MÁQUINA", '+
            '        IF(CIE_TIPTRA="02", "AJUSTE DE CRÉDITO", '+
            '            IF((CIE_TIPREG="B") OR (CIE_TIPARQ="03" AND CIE_TIPREG="E" AND CIE_TIPLAN="11"), "NEGOCIAÇÃO DE RECEBIVEIS", "CANCELAMENTO DE VENDA")) ' +
            '    )) ';
end;

function TConcilCielo.RetornaSQLDescricaoAjustesVersao015: String;
begin
  Result := 'CASE ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0000","0002","0034","0037","0038","0039","0049","0052","0054","0092","0093","0094","0095","0096","0097","0098","0099","0120",';
  Result := Result + '             "0121","0129","0137","0151","0192","0193","0194","0195","0208","0279","0280","0282","0286","0713","0715","0952","0953","0989","0992") THEN ';
  Result := Result + '             "Venda cancelada pelo estabelecimento comercial ou Reversão de cobrança de venda cancelada pelo estabelecimento comercial" ';
  Result := Result + '  WHEN CIE_CODAJU = "0001" THEN "Pagamento de vendas pendentes de liquidação pela Cielo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0003" THEN "Crédito/débito de transação a prejuízo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0004" THEN "Cobrança de plano Cielo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0005" THEN "Cobrança/Devolução referente ao desconto de taxa administrativa de venda (MDR) efetuada no valor incorreto" ';
  Result := Result + '  WHEN CIE_CODAJU = "0006" THEN "Prejuízo diversos" ';
  Result := Result + '  WHEN CIE_CODAJU = "0007" THEN "Crédito/débito de valores rejeitados" ';
  Result := Result + '  WHEN CIE_CODAJU = "0008" THEN "Pagamento/cobrança de correção de valor sobre vendas liquidadas fora do prazo" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0010","0020","0110","0510") THEN "Valores não processados" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0011","0111") THEN "Valores não reconhecidos" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0012","0512") THEN "Pagamento em conta-corrente divergente" ';
  Result := Result + '  WHEN CIE_CODAJU = "0013" THEN "Duplicidade referente Visa cash" ';
  Result := Result + '  WHEN CIE_CODAJU = "0014" THEN "Reenvio de débito não cumprido pelo banco anteriormente" ';
  Result := Result + '  WHEN CIE_CODAJU = "0015" THEN "Crédito/débito baixado em agenda para EC não financeiro" ';
  Result := Result + '  WHEN CIE_CODAJU = "0016" THEN "Negociação com área de prevenção" ';
  Result := Result + '  WHEN CIE_CODAJU = "0017" THEN "Crédito não cumprido" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0019","0119","0619") THEN "Acertos diversos" ';
  Result := Result + '  WHEN CIE_CODAJU = "0021" THEN "Crédito/débito de acerto ref. Valor debitado em conta-corrente" ';
  Result := Result + '  WHEN CIE_CODAJU = "0022" THEN "Acerto de duplicidade de processamento vale pedágio" ';
  Result := Result + '  WHEN CIE_CODAJU = "0023" THEN "Reenvio de crédito/débito não cumprido pelo banco" ';
  Result := Result + '  WHEN CIE_CODAJU = "0024" THEN "Pagamento/Cobrança referente ao pagamento do serviço de recarga de celular indevido" ';
  Result := Result + '  WHEN CIE_CODAJU = "0025" THEN "Crédito/débito de valor não pago por divergência de dados bancários" ';
  Result := Result + '  WHEN CIE_CODAJU = "0026" THEN "Estorno de valores creditados/debitados indevidamente" ';
  Result := Result + '  WHEN CIE_CODAJU = "0027" THEN "Crédito/débito de transação eléctron não processada" ';
  Result := Result + '  WHEN CIE_CODAJU = "0028" THEN "Ajuste a Crédito/débito para antecipação/repasse" ';
  Result := Result + '  WHEN CIE_CODAJU = "0029" THEN "Acerto sistemas ref. transação não processada" ';
  Result := Result + '  WHEN CIE_CODAJU = "0030" THEN "Ajuste transação crediário/construcard" ';
  Result := Result + '  WHEN CIE_CODAJU = "0031" THEN "Valores negociados" ';
  Result := Result + '  WHEN CIE_CODAJU = "0032" THEN "Estorno de débito/crédito ref. a acerto de duplicidade de crédito" ';
  Result := Result + '  WHEN CIE_CODAJU = "0033" THEN "Pagamento antecipação" ';
  Result := Result + '  WHEN CIE_CODAJU = "0035" THEN "Rejeição antecipação (pré-balcão)" ';
  Result := Result + '  WHEN CIE_CODAJU = "0036" THEN "Crédito/débito de transação eléctron real não processada" ';
  Result := Result + '  WHEN CIE_CODAJU = "0040" THEN "Reprocessamento transação eléctron" ';
  Result := Result + '  WHEN CIE_CODAJU = "0041" THEN "Transação agronegócio-custeio" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0042","0143") THEN "Crédito/débito agro custeio" ';
  Result := Result + '  WHEN CIE_CODAJU = "0043" THEN "Crédito/débito de venda com cartão de débito Bradesco" ';
  Result := Result + '  WHEN CIE_CODAJU = "0044" THEN "Crédito/débito cessão de direito agenda a vista" ';
  Result := Result + '  WHEN CIE_CODAJU = "0045" THEN "Crédito/débito de transação eléctron" ';
  Result := Result + '  WHEN CIE_CODAJU = "0046" THEN "Comprovante(s) não processado(s)" ';
  Result := Result + '  WHEN CIE_CODAJU = "0047" THEN "Regularização de data de crédito" ';
  Result := Result + '  WHEN CIE_CODAJU = "0048" THEN "Reenvio de antecipação rejeitada" ';
  Result := Result + '  WHEN CIE_CODAJU = "0050" THEN "Estorno de reversão pagamento duplicidade - ARV" ';
  Result := Result + '  WHEN CIE_CODAJU = "0051" THEN "Premiação Visa" ';
  Result := Result + '  WHEN CIE_CODAJU = "0053" THEN "Troco fácil" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0055","0138") THEN "Webservice boleto" ';
  Result := Result + '  WHEN CIE_CODAJU = "0056" THEN "Crédito referente parcelas antecipadas (pré-balcão)" ';
  Result := Result + '  WHEN CIE_CODAJU = "0057" THEN "Reembolso de CMPF" ';
  Result := Result + '  WHEN CIE_CODAJU = "0058" THEN "Crédito/débito ref. parcelas antecipadas" ';
  Result := Result + '  WHEN CIE_CODAJU = "0059" THEN "Tarifa extrato papel" ';
  Result := Result + '  WHEN CIE_CODAJU = "0060" THEN "Plano Cielo - terminal inativo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0061" THEN "Cobrança diferença de plano Cielo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0062" THEN "Plano Cielo – Pin Pads" ';
  Result := Result + '  WHEN CIE_CODAJU = "0063" THEN "A 0064 Cobrança/Devolução de cobrança indevida de aluguel de máquina Cielo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0066" THEN "Plano Cielo - correspondente bancário" ';
  Result := Result + '  WHEN CIE_CODAJU = "0067" THEN "Plano Cielo - TEF discado Plano" ';
  Result := Result + '  WHEN CIE_CODAJU = "0068" THEN "Desconto plano Cielo - cobrança direta" ';
  Result := Result + '  WHEN CIE_CODAJU = "0069" THEN "Plano Cielo - TEF IP" ';
  Result := Result + '  WHEN CIE_CODAJU = "0070" THEN "Desconto comercial sobre taxa" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0071","0073") THEN "Tarifa de cadastro" ';
  Result := Result + '  WHEN CIE_CODAJU = "0072" THEN "Aluguel de equipamento" ';
  Result := Result + '  WHEN CIE_CODAJU = "0074" THEN "Crédito/débito promoção paixão por futebol Visa" ';
  Result := Result + '  WHEN CIE_CODAJU = "0075" THEN "Crédito/débito concessionaria" ';
  Result := Result + '  WHEN CIE_CODAJU = "0076" THEN "Crédito/débito arrecadador" ';
  Result := Result + '  WHEN CIE_CODAJU = "0077" THEN "Crédito/débito emissor" ';
  Result := Result + '  WHEN CIE_CODAJU = "0078" THEN "Tarifa de consulta transação AVS" ';
  Result := Result + '  WHEN CIE_CODAJU = "0079" THEN "Repasse de tarifa transação AVS" ';
  Result := Result + '  WHEN CIE_CODAJU = "0080" THEN "Crédito/débito cessão de recebíveis de venda parcelada" ';
  Result := Result + '  WHEN CIE_CODAJU = "0081" THEN "Crédito/débito de tarifa ref. Envio de bobina" ';
  Result := Result + '  WHEN CIE_CODAJU = "0082" THEN "Crédito/débito de tarifa ref. Envio de extrato papel" ';
  Result := Result + '  WHEN CIE_CODAJU = "0083" THEN "Crédito/débito de tarifa ref. Visita de manutenção POS" ';
  Result := Result + '  WHEN CIE_CODAJU = "0084" THEN "Ajuste a crédito/débito transação Flex Car" ';
  Result := Result + '  WHEN CIE_CODAJU = "0085" THEN "Crédito/débito cancelamento Flex Car" ';
  Result := Result + '  WHEN CIE_CODAJU = "0086" THEN "Créditos diversos Flex Car" ';
  Result := Result + '  WHEN CIE_CODAJU = "0087" THEN "Débitos diversos Flex Car" ';
  Result := Result + '  WHEN CIE_CODAJU = "0088" THEN "Webservice antifraude sem BPO" ';
  Result := Result + '  WHEN CIE_CODAJU = "0089" THEN "Webservice antifraude com BPO" ';
  Result := Result + '  WHEN CIE_CODAJU = "0090" THEN "Estorno/reprocessamento transação eléctron troco fácil" ';
  Result := Result + '  WHEN CIE_CODAJU = "0091" THEN "Transação saque troco fácil" ';
  Result := Result + '  WHEN CIE_CODAJU = "0100" THEN "Estorno cancelamento de venda via terminal parcelado loja" ';
  Result := Result + '  WHEN CIE_CODAJU = "0101" THEN "Crédito/débito ref. A erro no cadastramento da moeda" ';
  Result := Result + '  WHEN CIE_CODAJU = "0102" THEN "Regularização de estorno/estorno efetuado indevidamente" ';
  Result := Result + '  WHEN CIE_CODAJU = "0103" THEN "Crédito/débito de valores complementares" ';
  Result := Result + '  WHEN CIE_CODAJU = "0104" THEN "Cobrança/estorno de aluguel de terminais eletrônicos" ';
  Result := Result + '  WHEN CIE_CODAJU = "0105" THEN "Crédito/débito de taxa de comissão" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0106","0127","0128") THEN "Crédito/débito referente a valores contestados pelo portador através do banco emissor" ';
  Result := Result + '  WHEN CIE_CODAJU = "0107" THEN "Débito/crédito por pagamentos de valores rejeitados Visa cash" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0108","0606") THEN "Correção monetária" ';
  Result := Result + '  WHEN CIE_CODAJU = "0109" THEN "Crédito/débito temporário - processo em análise" ';
  Result := Result + '  WHEN CIE_CODAJU = "0112" THEN "Crédito/débito ref. A pagamento em conta-corrente divergente" ';
  Result := Result + '  WHEN CIE_CODAJU = "0113" THEN "Acerto cancelamento" ';
  Result := Result + '  WHEN CIE_CODAJU = "0114" THEN "Débito/estorno não cumprido" ';
  Result := Result + '  WHEN CIE_CODAJU = "0115" THEN "Bloqueio/estorno de valor por ordem judicial" ';
  Result := Result + '  WHEN CIE_CODAJU = "0116" THEN "Tarifa/estorno 2 via extrato papel" ';
  Result := Result + '  WHEN CIE_CODAJU = "0117" THEN "Reenvio de Crédito/estorno não cumprido pelo bco - ARV" ';
  Result := Result + '  WHEN CIE_CODAJU = "0118" THEN "Estorno de débito referente transações Cielo Promo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0125" THEN "Crédito/débito referente produto seguro" ';
  Result := Result + '  WHEN CIE_CODAJU = "0126" THEN "Webservice recorrência inteligente" ';
  Result := Result + '  WHEN CIE_CODAJU = "0130" THEN "Webservice pacote" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0131","0132","0133","0140","0196","0197","0292","0300","0301","0302","0303","0304","0305","0306","0307","0308","0309","0310","0313",';
  Result := Result + '                      "0358","0360","0370","0371","0372","0373","0374","0375","0376","0377","0995","0998") THEN ';
  Result := Result + '                      "Venda contestada pelo portador através do banco emissor ou Reversão de cobrança de venda contestada pelo portador através do banco emissor" ';
  Result := Result + '  WHEN CIE_CODAJU = "0134" THEN "Acerto de recarga dinheiro e parceiros para o M4U" ';
  Result := Result + '  WHEN CIE_CODAJU = "0135" THEN "Cessão de direitos" ';
  Result := Result + '  WHEN CIE_CODAJU = "0136" THEN "Estorno/reenvio de débito não cumprido" ';
  Result := Result + '  WHEN CIE_CODAJU = "0139" THEN "Franquia Cielo controle" ';
  Result := Result + '  WHEN CIE_CODAJU = "0141" THEN "Acerto faturamento" ';
  Result := Result + '  WHEN CIE_CODAJU = "0142" THEN "Transferência de valores em debit balance." ';
  Result := Result + '  WHEN CIE_CODAJU = "0144" THEN "Excedente Cielo controle" ';
  Result := Result + '  WHEN CIE_CODAJU = "0145" THEN "Transferência de valores do dev. banco" ';
  Result := Result + '  WHEN CIE_CODAJU = "0150" THEN "Tarifa aquisição de recebíveis via central" ';
  Result := Result + '  WHEN CIE_CODAJU = "0152" THEN "Transação não processada" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0153","0515") THEN "Acordo jurídico" ';
  Result := Result + '  WHEN CIE_CODAJU = "0154" THEN "Confiança Cielo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0155" THEN "Contrato de caução" ';
  Result := Result + '  WHEN CIE_CODAJU = "0156" THEN "Tarifa programa monitoria chargeback Master Card" ';
  Result := Result + '  WHEN CIE_CODAJU = "0157" THEN "Devolução/Cobrança de aluguel por não atingimento de meta de faturamento (Cielo Livre)" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0158","0209","0210","0211","0212","0213","0214","0215","0216","0217","0218","0342","0971") THEN "Ajuste periódico de comissão" ';
  Result := Result + '  WHEN CIE_CODAJU = "0159" THEN "Ajuste periódico de comissão Amex" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0160","0165") THEN "Cobrança/estorno aluguel de terminais eletrônicos" ';
  Result := Result + '  WHEN CIE_CODAJU = "0161" THEN "Cobrança/estorno aluguel de terminais eletrônicos para férias e eventos" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0162","0163") THEN "Cobrança/estorno aluguel de terminais eletrônicos C.C.C." ';
  Result := Result + '  WHEN CIE_CODAJU = "0164" THEN "Cobrança/estorno aluguel de terminais eletrônicos (leitor de trilha)" ';
  Result := Result + '  WHEN CIE_CODAJU = "0166" THEN "Cobrança indevida" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0167","0168") THEN "Ajuste periódico de comissão hiper" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0169","0618") THEN "POS incentivado" ';
  Result := Result + '  WHEN CIE_CODAJU = "0170" THEN "Estorno/desconto comercial sobre taxa de desconto" ';
  Result := Result + '  WHEN CIE_CODAJU = "0171" THEN "Desconto comercial sobre taxa de desconto eléctron" ';
  Result := Result + '  WHEN CIE_CODAJU = "0172" THEN "Desconto comercial sobre taxa desconto - parcelado" ';
  Result := Result + '  WHEN CIE_CODAJU = "0173" THEN "Pagamento de incentivo emissores faturamento eléctron" ';
  Result := Result + '  WHEN CIE_CODAJU = "0174" THEN "Repasse de multa de bandeira por não conformidade" ';
  Result := Result + '  WHEN CIE_CODAJU = "0175" THEN "Receba rápido" ';
  Result := Result + '  WHEN CIE_CODAJU = "0176" THEN "Ação promocional de Cashback" ';
  Result := Result + '  WHEN CIE_CODAJU = "0177" THEN "Transferência de valores entre estabelecimentos da mesma raiz de CNPJ para compensação de saldo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0178" THEN "Fullcommerce - Velocity" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0179","0205") THEN "Reprocessamento transação carnê" ';
  Result := Result + '  WHEN CIE_CODAJU = "0180" THEN "Fullcommerce - conciliador" ';
  Result := Result + '  WHEN CIE_CODAJU = "0181" THEN "Antifraude automático" ';
  Result := Result + '  WHEN CIE_CODAJU = "0182" THEN "Antifraude Advanced" ';
  Result := Result + '  WHEN CIE_CODAJU = "0183" THEN "Fullcommerce cartão protegido" ';
  Result := Result + '  WHEN CIE_CODAJU = "0184" THEN "Fullcommerce - gateway" ';
  Result := Result + '  WHEN CIE_CODAJU = "0185" THEN "Antifraude - manual" ';
  Result := Result + '  WHEN CIE_CODAJU = "0186" THEN "Antifraude Enterprise" ';
  Result := Result + '  WHEN CIE_CODAJU = "0188" THEN "Cobrança fee Copuneria" ';
  Result := Result + '  WHEN CIE_CODAJU = "0189" THEN "Crédito/débito Copuneria" ';
  Result := Result + '  WHEN CIE_CODAJU = "0190" THEN "Compensação de valores pendentes" ';
  Result := Result + '  WHEN CIE_CODAJU = "0191" THEN "Crédito/débito receba mais enviado c/c" ';
  Result := Result + '  WHEN CIE_CODAJU = "0198" THEN "Receba rápido compensação entre estabelecimentos" ';
  Result := Result + '  WHEN CIE_CODAJU = "0199" THEN "Crédito/débito desenvolvedor Cielo lio" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0200","0720") THEN "Desconto negociação" ';
  Result := Result + '  WHEN CIE_CODAJU = "0201" THEN "Cessão de direito eléctron pré-datado" ';
  Result := Result + '  WHEN CIE_CODAJU = "0202" THEN "Crédito/débito aceleração de Cessão de direito eléctron pré-datado" ';
  Result := Result + '  WHEN CIE_CODAJU = "0203" THEN "Antecipação de cessão" ';
  Result := Result + '  WHEN CIE_CODAJU = "0204" THEN "Transação carnê Bradesco" ';
  Result := Result + '  WHEN CIE_CODAJU = "0206" THEN "Estorno cancelamento venda carnê" ';
  Result := Result + '  WHEN CIE_CODAJU = "0207" THEN "Cancelamento venda carnê" ';
  Result := Result + '  WHEN CIE_CODAJU = "0219" THEN "Anistia dívidas cliente varejo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0222" THEN "Reembolso EC PP" ';
  Result := Result + '  WHEN CIE_CODAJU = "0224" THEN "Compensação entre bandeiras online" ';
  Result := Result + '  WHEN CIE_CODAJU = "0225" THEN "Painel meu negócio" ';
  Result := Result + '  WHEN CIE_CODAJU = "0238" THEN "Reenvio débito não cumprido pelo banco anteriormente" ';
  Result := Result + '  WHEN CIE_CODAJU = "0246" THEN "Crédito/débito referente a Velocity Check" ';
  Result := Result + '  WHEN CIE_CODAJU = "0251" THEN "Tarifa por excesso de retentativas de venda no mesmo cartão aplicada pela bandeira do cartão ou Devolução de tarifa por excesso de retentativas de vendas (programa de monitoria da bandeira)" ';
  Result := Result + '  WHEN CIE_CODAJU = "0252" THEN "Pagamento via TED" ';
  Result := Result + '  WHEN CIE_CODAJU = "0253" THEN "Pagamento via Pix" ';
  Result := Result + '  WHEN CIE_CODAJU = "0254" THEN "Tarifa da bandeira" ';
  Result := Result + '  WHEN CIE_CODAJU = "0255" THEN "Reembolso/cobrança transação garantida" ';
  Result := Result + '  WHEN CIE_CODAJU = "0256" THEN "Acerto taxa Pix" ';
  Result := Result + '  WHEN CIE_CODAJU = "0257" THEN "Regularização pagamento Pix" ';
  Result := Result + '  WHEN CIE_CODAJU = "0258" THEN "Cobrança/Reversão de multa aplicada pela bandeira do cartão por excesso de vendas contestadas" ';
  Result := Result + '  WHEN CIE_CODAJU = "0259" THEN "Divergência do valor da nota fiscal - compra de máquina" ';
  Result := Result + '  WHEN CIE_CODAJU = "0260" THEN "Regularização por exceção" ';
  Result := Result + '  WHEN CIE_CODAJU = "0261" THEN "Parceria eleve" ';
  Result := Result + '  WHEN CIE_CODAJU = "0262" THEN "Estorno boleto comodato Cielo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0264" THEN "Acerto ref. a cancelamento/estorno do pedido de venda de máquina" ';
  Result := Result + '  WHEN CIE_CODAJU = "0267" THEN "Crédito/débito de estorno indevido" ';
  Result := Result + '  WHEN CIE_CODAJU = "0269" THEN "Ajuste referente capturas incorretas" ';
  Result := Result + '  WHEN CIE_CODAJU = "0270" THEN "ARV registrado não liquidado" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0271","0298") THEN "Acerto de valores indevidos" ';
  Result := Result + '  WHEN CIE_CODAJU = "0272" THEN "Cobrança/Devolução sobre saldos utilizados indevidamente em negociações de recebíveis" ';
  Result := Result + '  WHEN CIE_CODAJU = "0274" THEN "Estorno de vendas pagas em duplicidade" ';
  Result := Result + '  WHEN CIE_CODAJU = "0275" THEN "Ressarcimento de terminais_ recuperação de ativos" ';
  Result := Result + '  WHEN CIE_CODAJU = "0276" THEN "Regularização de gravame/cessão não liquidado" ';
  Result := Result + '  WHEN CIE_CODAJU = "0277" THEN "Acerto ref. ao cancel/estorno do pedido de venda máquina" ';
  Result := Result + '  WHEN CIE_CODAJU = "0278" THEN "Acerto correção parc. não liquidadas-migração reg. recebíveis" ';
  Result := Result + '  WHEN CIE_CODAJU = "0281" THEN "Regularização de terminais não recuperados" ';
  Result := Result + '  WHEN CIE_CODAJU = "0283" THEN "Compensação de créditos/débitos" ';
  Result := Result + '  WHEN CIE_CODAJU = "0284" THEN "Compensação de créditos/débitos conta digital" ';
  Result := Result + '  WHEN CIE_CODAJU = "0285" THEN "Ajustes diversos electrón carné intercambio" ';
  Result := Result + '  WHEN CIE_CODAJU = "0287" THEN "Ajuste de aluguel equipamentos inativos" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0288","0700") THEN "Venda contestada pelo portador do cartão através do banco emissor" ';
  Result := Result + '  WHEN CIE_CODAJU = "0289" THEN "De/para número logico" ';
  Result := Result + '  WHEN CIE_CODAJU = "0290" THEN "Alteração de plano" ';
  Result := Result + '  WHEN CIE_CODAJU = "0291" THEN "Regularização referente a estorno indevido" ';
  Result := Result + '  WHEN CIE_CODAJU = "0293" THEN "Ajuste débito/crédito Facebook" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0294","0295") THEN "Ajuste reembolso Facebook" ';
  Result := Result + '  WHEN CIE_CODAJU = "0296" THEN "Crédito voucher - Facebook Donation" ';
  Result := Result + '  WHEN CIE_CODAJU = "0297" THEN "Cobrança/Devolução de valores sobre máquina não devolvida pelo estabelecimento comercial" ';
  Result := Result + '  WHEN CIE_CODAJU = "0299" THEN "Tarifa inconformidade regras bandeira" ';
  Result := Result + '  WHEN CIE_CODAJU = "0311" THEN "Transação acima do limite sem código de autorização" ';
  Result := Result + '  WHEN CIE_CODAJU = "0312" THEN "Transação em duplicidade" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0314","0316") THEN "Transação com número do cartão inexistente" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0315","0366") THEN "Análise de intercambio" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0317","0318") THEN "Estorno de débito efetuado em transação realizada com chip" ';
  Result := Result + '  WHEN CIE_CODAJU = "0320" THEN "Tarifa/estorno de multa programa monitoria chargeback" ';
  Result := Result + '  WHEN CIE_CODAJU = "0321" THEN "Transação acima do limite sem código de autorização" ';
  Result := Result + '  WHEN CIE_CODAJU = "0322" THEN "Venda em duplicidade" ';
  Result := Result + '  WHEN CIE_CODAJU = "0323" THEN "Crédito por envio do comprovante" ';
  Result := Result + '  WHEN CIE_CODAJU = "0324" THEN "Crédito/débito pré-negociado com o estabelecimento/ a vista" ';
  Result := Result + '  WHEN CIE_CODAJU = "0325" THEN "Processo de intercambio especial" ';
  Result := Result + '  WHEN CIE_CODAJU = "0326" THEN "Venda desmembrada em mais de um comprovante" ';
  Result := Result + '  WHEN CIE_CODAJU = "0327" THEN "Assinatura divergente - portador não efetuou compra" ';
  Result := Result + '  WHEN CIE_CODAJU = "0328" THEN "Pré-arbitragem/pré-compliance" ';
  Result := Result + '  WHEN CIE_CODAJU = "0329" THEN "Pré-arbitragem/pré-compliance negociados parcelado" ';
  Result := Result + '  WHEN CIE_CODAJU = "0330" THEN "Tarifa programa de excesso de chargeback Master Card" ';
  Result := Result + '  WHEN CIE_CODAJU = "0331" THEN "Transação acima do limite sem código de autorização" ';
  Result := Result + '  WHEN CIE_CODAJU = "0332" THEN "Venda em duplicidade não comprovada" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0333","0367","0369") THEN "Envio do comprovante pelo estabelecimento" ';
  Result := Result + '  WHEN CIE_CODAJU = "0334"THEN "Venda com número de cartão existente" ';
  Result := Result + '  WHEN CIE_CODAJU = "0335"THEN "Crédito/débito referente análise de intercambio" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0336","0337") THEN "Processos de mediação" ';
  Result := Result + '  WHEN CIE_CODAJU = "0338" THEN "Pagamento duplicado/estorno - reenvio de pagamento rejeitado" ';
  Result := Result + '  WHEN CIE_CODAJU = "0339" THEN "Cobrança/devolução de débito de cancelamento não efetuado na data original" ';
  Result := Result + '  WHEN CIE_CODAJU = "0340" THEN "Correção descasamento de cancelamento e crédito de vendas" ';
  Result := Result + '  WHEN CIE_CODAJU = "0341" THEN "Transação rejeitada" ';
  Result := Result + '  WHEN CIE_CODAJU = "0343" THEN "Regularização Cobrança de valores pagos em confiança" ';
  Result := Result + '  WHEN CIE_CODAJU = "0344" THEN "Reversão/contestação de débito em conta pelo banco" ';
  Result := Result + '  WHEN CIE_CODAJU = "0345" THEN "Estorno/Cobrança serviço renova fácil" ';
  Result := Result + '  WHEN CIE_CODAJU = "0346" THEN "Correção erro de migração de transação cancelada liquidada" ';
  Result := Result + '  WHEN CIE_CODAJU = "0347" THEN "Cobrança/Devolução de venda paga indevidamente ao estabelecimento comercial em antecipações/garantias" ';
  Result := Result + '  WHEN CIE_CODAJU = "0349" THEN "Regularização de débito de intercambio (contestação)" ';
  Result := Result + '  WHEN CIE_CODAJU = "0350" THEN "Estabelecimento Special Handling" ';
  Result := Result + '  WHEN CIE_CODAJU = "0351" THEN "Venda com código de autorização" ';
  Result := Result + '  WHEN CIE_CODAJU = "0352" THEN "Contestação do contrato" ';
  Result := Result + '  WHEN CIE_CODAJU = "0353" THEN "Não envio do comprovante pelo estabelecimento" ';
  Result := Result + '  WHEN CIE_CODAJU = "0354" THEN "Acerto de débito em duplicidade" ';
  Result := Result + '  WHEN CIE_CODAJU = "0356" THEN "Portador não reconhece valor parcial da venda." ';
  Result := Result + '  WHEN CIE_CODAJU = "0357" THEN "Intercambio referente a contestação do portador" ';
  Result := Result + '  WHEN CIE_CODAJU = "0359" THEN "Irregularidade na transação" ';
  Result := Result + '  WHEN CIE_CODAJU = "0361" THEN "Chargeback transação débito - bandeira elo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0362" THEN "Chargeback transação parcelado - bandeira elo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0363" THEN "Crédito/débito referente contestação do portador" ';
  Result := Result + '  WHEN CIE_CODAJU = "0364" THEN "Estorno débito pré-arbitragem - bandeira elo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0365" THEN "Intercambio ref. contestação do portado" ';
  Result := Result + '  WHEN CIE_CODAJU = "0368" THEN "Transação apresentada dentro do prazo contratual (intercambio)" ';
  Result := Result + '  WHEN CIE_CODAJU = "0380" THEN "Crédito/débito crediário Visa" ';
  Result := Result + '  WHEN CIE_CODAJU = "0383" THEN "e 0384 Cobrança/Devolução de venda cobrada indevidamente do estabelecimento comercial em antecipações/garantias" ';
  Result := Result + '  WHEN CIE_CODAJU = "0389" THEN "Crédito/débito referente a reversão de débito por cartão inexistente" ';
  Result := Result + '  WHEN CIE_CODAJU = "0394" THEN "Pré-arbitragem/pré-compliance negociados a vista" ';
  Result := Result + '  WHEN CIE_CODAJU = "0396" THEN "Crédito/débito devido a erro de sistema" ';
  Result := Result + '  WHEN CIE_CODAJU = "0397" THEN "Erro no processamento da venda" ';
  Result := Result + '  WHEN CIE_CODAJU = "0399" THEN "Ajuste a Crédito/débito por comprovante de venda legível/ilegível" ';
  Result := Result + '  WHEN CIE_CODAJU = "0400" THEN "Copia não atendida" ';
  Result := Result + '  WHEN CIE_CODAJU = "0401" THEN "Copia ilegível" ';
  Result := Result + '  WHEN CIE_CODAJU = "0402" THEN "Copia incorreta" ';
  Result := Result + '  WHEN CIE_CODAJU = "0403" THEN "Envio de documentos comprobatórios da venda" ';
  Result := Result + '  WHEN CIE_CODAJU = "0404" THEN "Acerto processamento em duplicidade Visa cash" ';
  Result := Result + '  WHEN CIE_CODAJU = "0409" THEN "Crédito/débito transações parceladas negociadas com a Visanet" ';
  Result := Result + '  WHEN CIE_CODAJU = "0415" THEN "Cobrança/Devolução de vendas realizadas em 30 e 31/01/23 pagas mais de uma vez ao estabelecimento comercial" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0421","0422","0423","0424","0425","0426") THEN "Planos e serviços e-commerce" ';
  Result := Result + '  WHEN CIE_CODAJU = "0428" THEN "Estorno para ajuste de cessão indevido" ';
  Result := Result + '  WHEN CIE_CODAJU = "0450" THEN "Ajuste de multa por atraso" ';
  Result := Result + '  WHEN CIE_CODAJU = "0488" THEN "Cobrança/Devolução de multa aplicada pela bandeira do cartão por perda de disputa de venda contestada" ';
  Result := Result + '  WHEN CIE_CODAJU = "0508" THEN "Juros e correção monetária" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0517","0609") THEN "Reenvio de crédito não cumprido pelo banco anteriormente" ';
  Result := Result + '  WHEN CIE_CODAJU = "0521" THEN "Estorno/débito de reversão de lançamento a débito (baixa forcada)" ';
  Result := Result + '  WHEN CIE_CODAJU = "0522" THEN "Lançamento a crédito baixa forcada" ';
  Result := Result + '  WHEN CIE_CODAJU = "0523" THEN "Lançamento baixa manual" ';
  Result := Result + '  WHEN CIE_CODAJU = "0524" THEN "Lançamento revertido para compensação de saldo em nova data" ';
  Result := Result + '  WHEN CIE_CODAJU = "0528" THEN "Acerto de cobrança" ';
  Result := Result + '  WHEN CIE_CODAJU = "0529" THEN "Pagamento de incentivo ao EC" ';
  Result := Result + '  WHEN CIE_CODAJU = "0530" THEN "Acerto autorizado pela Cielo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0540" THEN "Estorno de reversão de crédito" ';
  Result := Result + '  WHEN CIE_CODAJU = "0541" THEN "Reversão de débito indevido" ';
  Result := Result + '  WHEN CIE_CODAJU = "0542" THEN "Acordo de cobrança" ';
  Result := Result + '  WHEN CIE_CODAJU = "0548" THEN "Valores pendentes" ';
  Result := Result + '  WHEN CIE_CODAJU = "0549" THEN "Reversão de aluguel de POS" ';
  Result := Result + '  WHEN CIE_CODAJU = "0550" THEN "Valores suspensos" ';
  Result := Result + '  WHEN CIE_CODAJU = "0558" THEN "Acerto por tarifa anteriormente cancelada" ';
  Result := Result + '  WHEN CIE_CODAJU = "0560" THEN "Acerto referente a acordo comercial" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0601","0610") THEN "Acerto de valores não processados" ';
  Result := Result + '  WHEN CIE_CODAJU = "0602" THEN "Acerto referente a regularização de data de pagamento" ';
  Result := Result + '  WHEN CIE_CODAJU = "0603" THEN "Acerto de valores complementares" ';
  Result := Result + '  WHEN CIE_CODAJU = "0604" THEN "Acerto de taxa de comissão" ';
  Result := Result + '  WHEN CIE_CODAJU = "0605" THEN "Crédito/débito referente a valores contestados" ';
  Result := Result + '  WHEN CIE_CODAJU = "0607" THEN "Débito/estorno de débito de valores não reconhecidos" ';
  Result := Result + '  WHEN CIE_CODAJU = "0608" THEN "Crédito/débito referente a pagamento em conta-corrente divergente" ';
  Result := Result + '  WHEN CIE_CODAJU = "0611" THEN "Acerto referente acerto de duplicidade" ';
  Result := Result + '  WHEN CIE_CODAJU = "0613" THEN "Estorno cancelamento de venda Alelo refeição" ';
  Result := Result + '  WHEN CIE_CODAJU = "0614" THEN "Crédito/débito de transação Alelo refeição não processada" ';
  Result := Result + '  WHEN CIE_CODAJU = "0615" THEN "Reenvio de antecipação rejeitada (pré-balcão)" ';
  Result := Result + '  WHEN CIE_CODAJU = "0616" THEN "Acerto referente a negociação com a área de prevenção" ';
  Result := Result + '  WHEN CIE_CODAJU = "0617" THEN "Tarifa operacional sobre créditos Alelo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0620" THEN "Estorno/tarifa operacional sobre créditos Alelo" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0621","0991") THEN "Cancelamento de vendas (envio eletrônico)" ';
  Result := Result + '  WHEN CIE_CODAJU = "0622" THEN "Alelo desenvolvedores" ';
  Result := Result + '  WHEN CIE_CODAJU = "0623" THEN "Reversão de lançamento a Crédito/débito baixado manual" ';
  Result := Result + '  WHEN CIE_CODAJU = "0624" THEN "Reenvio tarifa TOR Acerto 81 0625 Reenvio tarifa de manutenção Alelo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0626" THEN "Estorno/cobrança de tarifa de cadastro Alelo" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0627","0628") THEN "Tarifa mensal - Alelo na medida" ';
  Result := Result + '  WHEN CIE_CODAJU = "0629" THEN "Crédito/débito de antecipação rejeitada" ';
  Result := Result + '  WHEN CIE_CODAJU = "0631" THEN "Estorno/reversão de lançamento a débito baixado manual" ';
  Result := Result + '  WHEN CIE_CODAJU = "0632" THEN "Reversão de lançamento a Crédito/débito baixado manualmente" ';
  Result := Result + '  WHEN CIE_CODAJU = "0633" THEN "Acerto ref. acerto de cobrança" ';
  Result := Result + '  WHEN CIE_CODAJU = "0634" THEN "Estorno/cobrança de débito de acordo de cobrança" ';
  Result := Result + '  WHEN CIE_CODAJU = "0635" THEN "Ajuste a Crédito/débito de valores pendentes" ';
  Result := Result + '  WHEN CIE_CODAJU = "0636" THEN "Crédito/débito referente a acerto de valores suspensos" ';
  Result := Result + '  WHEN CIE_CODAJU = "0637" THEN "Crédito/débito assinatura internet delivery Alelo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0638" THEN "Crédito/débito referente a análise de intercambio cartão cultura" ';
  Result := Result + '  WHEN CIE_CODAJU = "0640" THEN "Correção de transação a débito migrada com prazo divergente" ';
  Result := Result + '  WHEN CIE_CODAJU = "0641" THEN "Acerto a débito/crédito referente a negociação com área de prevenção" ';
  Result := Result + '  WHEN CIE_CODAJU = "0645" THEN "Acerto do bloqueio de valor por ordem judicial" ';
  Result := Result + '  WHEN CIE_CODAJU = "0648" THEN "Ajuste a Crédito/débito para valores pendentes" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0649","0652") THEN "Programa Smiles" ';
  Result := Result + '  WHEN CIE_CODAJU = "0650" THEN "Crédito/estorno Smiles referente ao acúmulo de milhas" ';
  Result := Result + '  WHEN CIE_CODAJU = "0651" THEN "Crédito/estorno ao EC referente as milhas Smiles resgatadas" ';
  Result := Result + '  WHEN CIE_CODAJU = "0653" THEN "Pagamento boleto" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0661","0950") THEN "Crédito/débito referente análise de intercambio refeição" ';
  Result := Result + '  WHEN CIE_CODAJU = "0680" THEN "Cobrança mensal e-lynx" ';
  Result := Result + '  WHEN CIE_CODAJU = "0714" THEN "Crédito/débito de transação Alelo alimentação não processadas" ';
  Result := Result + '  WHEN CIE_CODAJU = "0716" THEN "Transação Alelo não processada" ';
  Result := Result + '  WHEN CIE_CODAJU = "0745" THEN "Acerto Hipercard festa de são João" ';
  Result := Result + '  WHEN CIE_CODAJU = "0759" THEN "Cobrança Meliuz" ';
  Result := Result + '  WHEN CIE_CODAJU = "0760" THEN "Estorno Cobrança Meliuz" ';
  Result := Result + '  WHEN CIE_CODAJU = "0761" THEN "Crédito/débito referente a análise de intercambio alimentação" ';
  Result := Result + '  WHEN CIE_CODAJU = "0797" THEN "Cobrança/Devolução de valores por compra de aplicativo no Cielo Store" ';
  Result := Result + '  WHEN CIE_CODAJU = "0798" THEN "Devolução/Repasse ao desenvolvedor sobre a compra de aplicativo no Cielo Store" ';
  Result := Result + '  WHEN CIE_CODAJU = "0799" THEN "Receita/Devolução sobre Cielo Store" ';
  Result := Result + '  WHEN CIE_CODAJU = "0800" THEN "Cobrança/Devolução sobre Cielo Store" ';
  Result := Result + '  WHEN CIE_CODAJU = "0811" THEN "Serviço conciliador" ';
  Result := Result + '  WHEN CIE_CODAJU = "0812" THEN "Serviço gateway" ';
  Result := Result + '  WHEN CIE_CODAJU = "0813" THEN "Serviço cartão protegido" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0814","0815") THEN "Serviço antifraude" ';
  Result := Result + '  WHEN CIE_CODAJU = "0817" THEN "Acerto cancelamento POS Alelo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0819" THEN "Regularização de valores indevidos" ';
  Result := Result + '  WHEN CIE_CODAJU = "0825" THEN "Tarifa de manutenção cadastral" ';
  Result := Result + '  WHEN CIE_CODAJU = "0879" THEN "Desconto Cielo controle" ';
  Result := Result + '  WHEN CIE_CODAJU = "0882" THEN "Devolução/Cobrança de mensalidade do produto Farol" ';
  Result := Result + '  WHEN CIE_CODAJU = "0883" THEN "Alteração de plano farol" ';
  Result := Result + '  WHEN CIE_CODAJU = "0884" THEN "Serviço de big data" ';
  Result := Result + '  WHEN CIE_CODAJU = "0890" THEN "FCO giro via termina" ';
  Result := Result + '  WHEN CIE_CODAJU = "0891" THEN "Ajuste a crédito transação Capital de giro" ';
  Result := Result + '  WHEN CIE_CODAJU = "0892" THEN "Reversão cancelamento Capital de giro" ';
  Result := Result + '  WHEN CIE_CODAJU = "0893" THEN "Reversão/estorno cancelamento capital de giro via terminal" ';
  Result := Result + '  WHEN CIE_CODAJU = "0894" THEN "Ajuste a Crédito/débito trans. Crédito imobiliário" ';
  Result := Result + '  WHEN CIE_CODAJU = "0895" THEN "Reversão cancelamento crédito imobiliário" ';
  Result := Result + '  WHEN CIE_CODAJU = "0896" THEN "Cancelamento/reversão crédito imobiliário via terminal" ';
  Result := Result + '  WHEN CIE_CODAJU = "0898" THEN "Estorno/ cancelamento de venda produto crédito especializado" ';
  Result := Result + '  WHEN CIE_CODAJU = "0899" THEN "Estorno/ cancelamento de venda produto crédito especializado via terminal" ';
  Result := Result + '  WHEN CIE_CODAJU = "0901" THEN "Acerto Amex indevido" ';
  Result := Result + '  WHEN CIE_CODAJU = "0902" THEN "Tarifa de retentativas Master Card" ';
  Result := Result + '  WHEN CIE_CODAJU = "0920" THEN "Comissão emissor internacional" ';
  Result := Result + '  WHEN CIE_CODAJU = "0951" THEN "Débito/crédito referente a análise de intercambio alimentação" ';
  Result := Result + '  WHEN CIE_CODAJU = "0954" THEN "Pagamento/reversão de rebate DCC" ';
  Result := Result + '  WHEN CIE_CODAJU = "0960" THEN "Desconto comercial-pagamento de incentivo" ';
  Result := Result + '  WHEN CIE_CODAJU IN ("0961","0963") THEN "Desconto comercial verba subsidiada pelo banco" ';
  Result := Result + '  WHEN CIE_CODAJU = "0962" THEN "Acerto deposito ref. Cancelamento de venda" ';
  Result := Result + '  WHEN CIE_CODAJU = "0964" THEN "Compensação de valores em debit balance" ';
  Result := Result + '  WHEN CIE_CODAJU = "0965" THEN "Acerto entre bandeiras de valores suspensos" ';
  Result := Result + '  WHEN CIE_CODAJU = "0967" THEN "Taxa ARV" ';
  Result := Result + '  WHEN CIE_CODAJU = "0968" THEN "Acerto serviço de recarga" ';
  Result := Result + '  WHEN CIE_CODAJU = "0972" THEN "Crédito/débito referente a processo de de/para - comercial" ';
  Result := Result + '  WHEN CIE_CODAJU = "0973" THEN "Incentivo serviço Sky" ';
  Result := Result + '  WHEN CIE_CODAJU = "0974" THEN "Tarifa de cadastro Alelo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0976" THEN "Cielo e-commerce" ';
  Result := Result + '  WHEN CIE_CODAJU = "0977" THEN "Desconto aluguel" ';
  Result := Result + '  WHEN CIE_CODAJU = "0979" THEN "Incentivo comercial" ';
  Result := Result + '  WHEN CIE_CODAJU = "0981" THEN "Aluguel máquina mobile chip and pin" ';
  Result := Result + '  WHEN CIE_CODAJU = "0982" THEN "Tarifa de manutenção Alelo" ';
  Result := Result + '  WHEN CIE_CODAJU = "0984" THEN "Cobrança de equipamento sinistro" ';
  Result := Result + '  WHEN CIE_CODAJU = "0985" THEN "Ajuste a Crédito/débito transação FCO investimento" ';
  Result := Result + '  WHEN CIE_CODAJU = "0986" THEN "Reversão/cancelamento de transação FCO investimento" ';
  Result := Result + '  WHEN CIE_CODAJU = "0987" THEN "Reversão/cancelamento de transação FCO investimento via terminal" ';
  Result := Result + '  WHEN CIE_CODAJU = "0988" THEN "Ajuste a Crédito/débito de transação FCO giro" ';
  Result := Result + '  WHEN CIE_CODAJU = "0990" THEN "Crédito/débito contestação bens e serviços refeição" ';
  Result := Result + '  WHEN CIE_CODAJU = "0996" THEN "Contestação de transação parcelada" ';
  Result := Result + '  WHEN CIE_CODAJU = "0997" THEN "Ajustes sobre cartão eléctron intercambio" ';
  Result := Result + '  WHEN CIE_CODAJU = "0999" THEN "Débitos diversos contestação - dólar" ';
  Result := Result + '  ELSE ';
  Result := Result + '    CASE CIE_TIPLAN ';
  Result := Result + '      WHEN "10" THEN "Plano Cielo" ';
  Result := Result + '      WHEN "11" THEN "Débito de cessão" ';
  Result := Result + '      WHEN "13" THEN "Débito de gravame" ';
  Result := Result + '      WHEN "14" THEN "Crédito de gravame" ';
  Result := Result + '      ELSE "OUTROS" ';
  Result := Result + '  END ';
  Result := Result + 'END ';
end;

function TConcilCielo.RetornaSQLRegistrosConciliacao: String;
begin
  //Selecionando a tabela de importação de pagamentos da CIELO
  Result := '';
  Result := Result + ' SELECT A.*,                                             ';
  Result := Result + ' COALESCE(SIS_CODEMP, "") AS CODEMP,                     ';
  Result := Result + ' COALESCE(EMP_NOMEMP, "") AS EMP_NOMEMP,                 ';
  Result := Result + ' IF(B.CIE_TIPREG="7" AND A.CIE_TIPREG<>"6"               ';
  Result := Result + ' , B.CIE_LIQDEB, 0.00) AS VALLIQ                         ';
  Result := Result + ' FROM CIE_CIPGTO A                                       ';
  Result := Result + ' LEFT JOIN CFGSIS ON SIS_CODCFG IN ("CFG_CIEEST", "CFG_CIELNK") AND ';
  Result := Result + '                     LOCATE(A.CIE_CODEST, SIS_VALCFG) > 0 ';
  Result := Result + ' LEFT JOIN CADEMP ON SIS_CODEMP=EMP_CODEMP               ';
  Result := Result + ' LEFT JOIN CIE_CIPGTO B ON B.CIE_CODAUT=A.CIE_CODAUT AND ';
  Result := Result + '     B.CIE_NUMNSU=A.CIE_NUMNSU AND                       ';
  Result := Result + '     B.CIE_DTAVEN=A.CIE_DTAVEN AND                       ';
  Result := Result + '     B.CIE_CODEST=A.CIE_CODEST AND                       ';
  Result := Result + '     B.CIE_NUMPAR=A.CIE_NUMPAR AND                       ';
  Result := Result + '     B.CIE_TOTPAR=A.CIE_TOTPAR AND                       ';
  Result := Result + '     B.CIE_TIPREG="7"                                    ';

  Result := Result + ' WHERE A.CIE_DTAPAG BETWEEN :DTAIN AND :DTAFIM           ';
  Result := Result + '   AND A.CIE_DTAVEN<>"0000-00-00"                        ';

  Result := Result + StringReplace(fRetPesqPonVen(0), objConcil.CampoEstabelecimento, 'A.' + objConcil.CampoEstabelecimento, [rfReplaceAll]);

  Result := Result + ' AND (A.CIE_VERARQ IS NULL OR A.CIE_VERARQ<>"015") ';

  Result := Result + ' AND (A.CIE_TIPTRA="01" AND A.CIE_TIPREG NOT IN ("7", "B") AND      ';
  Result := Result + ' A.CIE_RO_LIQ > 0) AND ((A.CIE_TIPREG="6" AND            ';
  Result := Result + ' (B.CIE_TIPREG<>"7" OR B.CIE_TIPREG IS NULL)) OR         ';
  Result := Result + ' ((A.CIE_TIPREG="1" AND B.CIE_TIPREG="7") OR             ';
  Result := Result + '  (A.CIE_TIPREG="8" AND A.CIE_ORIAJU IS NULL) OR         ';
  Result := Result + ' ((A.CIE_TIPREG="1" AND B.CIE_TIPREG IS NULL))) OR        ';

  Result := Result + ' (A.CIE_TIPREG="6" AND B.CIE_TIPREG="7" AND              ';
  Result := Result + ' (A.CIE_DTAPAG=B.CIE_DTAPAG OR                           ';
  Result := Result + ' (A.CIE_RO_LIQ * (A.CIE_VALPAR / A.CIE_RO_BRU)) >        ';
  Result := Result + '  COALESCE(B.CIE_LIQDEB, 0)))) AND                       ';
  //Não Cancelado
  Result := Result + ' (SELECT COUNT(CIE_CODAUT)                               ';
  Result := Result + '   FROM CIE_CIPGTO                                       ';
  Result := Result + '   WHERE CIE_TIPREG="1"  AND                             ';
  Result := Result + '         CIE_TIPTRA="03" AND                             ';
  Result := Result + '         CIE_STATUS="01" AND                             ';
  Result := Result + '         CIE_CODEST=A.CIE_CODEST AND                     ';
  Result := Result + '         CIE_CODAUT=A.CIE_CODAUT AND                     ';
  Result := Result + '         CIE_NUM_RO=A.CIE_NUM_RO AND                     ';
  Result := Result + '      IF(CIE_NUMPAR <> "00", CIE_NUMPAR = A.CIE_NUMPAR, TRUE) AND  ';
  Result := Result + '         CIE_DTAVEN=A.CIE_DTAVEN AND                     ';
  Result := Result + '      IF(CIE_NUMPAR <> "00", CIE_DTAPAG <= A.CIE_DTAPAG,CIE_DTAPAG = A.CIE_DTAPAG)) = 0  ';
end;

function TConcilCielo.RetornaSQLRegistrosConciliacaoVersao015: String;
begin
  Result := '';
  Result := Result + ' SELECT A.*,                                             ';
  Result := Result + ' COALESCE(SIS_CODEMP, "") AS CODEMP,                     ';
  Result := Result + ' COALESCE(EMP_NOMEMP, "") AS EMP_NOMEMP,                 ';
  Result := Result + '   IF(A.CIE_TIPREG = "8",                 ';
  Result := Result + '     (A.CIE_VALPAR - (A.CIE_VALCOM * - 1)- (IFNULL(A.CIE_TAXADM, 0) * - 1)),                 ';
  Result := Result + '     (A.CIE_VALPAR - (A.CIE_VALCOM * - 1))) AS VALLIQ    ';
  Result := Result + ' FROM CIE_CIPGTO A                                       ';
  Result := Result + ' LEFT JOIN CFGSIS ON SIS_CODCFG IN ("CFG_CIEEST", "CFG_CIELNK") AND ';
  Result := Result + '                     LOCATE(A.CIE_CODEST, SIS_VALCFG) > 0 ';
  Result := Result + ' LEFT JOIN CADEMP ON SIS_CODEMP=EMP_CODEMP                 ';

  Result := Result + ' WHERE A.CIE_DTAPAG BETWEEN :DTAIN AND :DTAFIM           ';
  Result := Result + '   AND A.CIE_DTAVEN<>"0000-00-00"                        ';

  Result := Result + StringReplace(fRetPesqPonVen(0), objConcil.CampoEstabelecimento, 'A.' + objConcil.CampoEstabelecimento, [rfReplaceAll]);

  Result := Result + '   AND A.CIE_VERARQ="015" ';
  Result := Result + '   AND ((A.CIE_TIPREG = "E" ';
  Result := Result + '   AND  A.CIE_TIPLAN IN ("01", "02", "03") ';
  Result := Result + '   AND A.CIE_TIPARQ IN ("04", "16")) ';
  Result := Result + '    OR (A.CIE_TIPREG = "8" ';
  Result := Result + '   AND  A.CIE_TIPTRA = "01" ';
  Result := Result + '   AND  A.CIE_TIPARQ IN ("04", "16")) ) ';
end;

function TConcilCielo.RetornaSQLWhereRegistrosAjustes: String;
begin
  Result := ' AND (';

  If FConsiderarGravame Then
    Result := ' AND ((A.CIE_TIPREG IN ("3") AND A.CIE_VALPAR <> 0) OR ';

  Result :=  Result + ' (A.CIE_TIPREG="8" AND A.CIE_ORIAJU) OR ';

  Result :=  Result + ' ((A.CIE_TIPREG NOT IN ("3", "B") AND A.CIE_TIPTRA IN ("03", "04", "02")) AND (A.CIE_STATUS="01") AND (A.CIE_RO_LIQ<>0) AND ';
  Result :=  Result + ' (NOT (A.CIE_ORIAJU="51" AND A.CIE_CODAUT="000000" AND A.CIE_NUMNSU="000000")) AND ';

  Result := Result + ' (SELECT COUNT(F.CIE_CODAUT)                             ';
  Result := Result + '   FROM CIE_CIPGTO F                                     ';
  Result := Result + '   WHERE F.CIE_TIPTRA NOT IN ("03", "04", "02") AND      ';
  Result := Result + '         CIE_STATUS="01" AND                             ';
  Result := Result + '         CIE_CODEST=A.CIE_CODEST AND                     ';
  Result := Result + '         CIE_CODAUT=A.CIE_CODAUT AND                     ';
  Result := Result + '         CIE_NUM_RO=A.CIE_NUM_RO AND                     ';
  Result := Result + '         IF(A.CIE_NUMPAR<>"00", CIE_NUMPAR=A.CIE_NUMPAR, TRUE) AND ';
  Result := Result + '         CIE_DTAVEN=A.CIE_DTAVEN AND                     ';
  Result := Result + '         CIE_DTAPAG=A.CIE_DTAPAG) = 0))                  ';
                                                                       
  If FConsiderarVendasCanceladas then
    Result := Result + ' AND NOT (A.CIE_TIPREG="E" AND A.CIE_TIPTRA="00" AND A.CIE_STATUS="03" AND A.CIE_RO_BRU < 0) ';

  Result := Result + ' GROUP BY A.CIE_CODEST, A.CIE_TIPREG, A.CIE_TIPTRA, A.CIE_CODAUT, A.CIE_VALPAR, A.CIE_NUMPAR, A.CIE_NUM_RO    ';
end;

function TConcilCielo.RetornaSQLWhereRegistrosAjustesVersao015: String;
begin
  Result := ' AND A.CIE_VERARQ="015" ';
  Result := Result + ' AND A.CIE_LIQDEB<>0 ';
  Result := Result + ' AND ((A.CIE_TIPREG="E" ';
  Result := Result + '       AND A.CIE_TIPLAN NOT IN ("01", "02", "03", "13", "14") ';
  Result := Result + '       AND A.CIE_TIPARQ IN ("04", "16")) ';
  Result := Result + '   OR (A.CIE_TIPREG="8" ';
  Result := Result + '       AND A.CIE_TIPTRA <> "01" ';
  Result := Result + '       AND A.CIE_TIPARQ IN ("04", "16")) ';
  Result := Result + '     ) ';

  If FConsiderarVendasCanceladas Then
    Result := Result + ' AND NOT (A.CIE_TIPREG="E" AND A.CIE_TIPTRA="00" AND A.CIE_STATUS="03" AND A.CIE_RO_BRU < 0) ';

  Result := Result + ' GROUP BY A.CIE_CODEST, A.CIE_TIPREG, A.CIE_TIPTRA, A.CIE_CODAUT, A.CIE_VALPAR, A.CIE_NUMPAR, IFNULL(A.CIE_CHA_UR, ""), IFNULL(A.CIE_VENORI, 0) ';
end;

function TConcilCielo.RetornaTipoCartao: String;
  Var
    LTipoCartao: String;
begin
  If cdsConcar.FieldByname('CIE_TIPREG').AsString = '8' Then
    Exit('PIX');

  LTipoCartao := cdsConcar.FieldByName('CIE_TIPCAR').AsString;
  If LTipoCartao = 'A' Then
    Result := 'ANTECIPAÇÃO'
  Else If cdsConcar.FieldByName('CIE_TOTPAR').AsInteger <= 1 Then
  Begin
    Result := 'CRÉDITO ROTATIVO';
    If LTipoCartao = 'D' Then
      Result := 'DÉBITO';
  End
  Else
    Result := 'CRÉDITO PARCELADO';
end;

function TConcilCielo.RetornaTipoCartaoV015: String;
begin
  Result := 'DÉBITO';

  If cdsConCar.FieldByName('CIE_TIPREG').AsString.Equals('8') Then
    Result := 'PIX'
  Else If MatchStr(cdsConCar.FieldByName('CIE_TIPLAN').AsString, ['99', '11']) Then
    Result := 'ANTECIPAÇÃO'
  Else If cdsConCar.FieldByName('CIE_TIPLAN').AsString.Equals('02') Then
    Result := 'CRÉDITO ROTATIVO'
  Else If cdsConCar.FieldByName('CIE_TIPLAN').AsString.Equals('03') Then
    Result := 'CRÉDITO PARCELADO';
end;

end.
