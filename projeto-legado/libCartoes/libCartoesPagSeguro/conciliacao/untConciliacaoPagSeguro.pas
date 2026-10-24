unit untConciliacaoPagSeguro;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, Vcl.Graphics,

     Uni, UniClientDataSet, cxProgressBar,

     untTPagSeguroFuncoes, untPagSeguroConciliacaoCartoes,
     untLibCartoesInterfacesTipos;

type TConcilPagSeguro = class(TConciliacaoCartoes)
  private
    FTolerancia: Double;

    procedure ConciliacaoDeParceladosComPagamentoUnico;

    function fRetornaSQLMotivoAjuste: String;

    function RetornaTipoDoCartao: String;
    function RetornaParcela(AParcela: String): String;
    function CalculaValorBrutoUltimaParcela(AValorParcela: Double; out AValorUltimaParcela: Double): Boolean;

    function RetornaValorLiquidoDoCartao: Double;
    function RetornaValorBrutoDoCartao: Double;
    function RetornaTaxaDeAntecipacao: Double;

    procedure AcertaDataDeRecebimentoParaOProximoDiaUtil(cdsRegistros: TDataset);

    function RegistroPossuiAMesmaAutorizacao(AAutorizacao,
                                             AParcela,
                                             AEmpresa,
                                             ADataCupom: String): Boolean;

    function RetornoNumeroDoCartao: String;

    function RetornaSQLConciliacao: String;

    function fProcessaPagSeguroPag(pgbStatus: TcxProgressBar): Boolean;
    function fConciliaPagSeguro(pgbStatus: TcxProgressBar): Boolean;
  public
    function fConciliaCartoes: Boolean; override;

  protected

  end;

Const
  INICAM = 'PAG_';
  NOMTAB = 'PAG_SEPGTO';

implementation
Uses untPagSeguroDigPeriodo;

function TConcilPagSeguro.fConciliaPagSeguro(pgbStatus: TcxProgressBar): Boolean;
Begin
  Result := False;
  
  FFiltrarAutorizacaoNSU := True;

  TForm(pgbStatus.Owner).Visible := False;
  Try
    Try
      objConcil.TabelaConciliacao := NOMTAB;
      objConcil.CampoEstabelecimento := INICAM + 'CODEST';
      objConcil.NomeConciliacao := 'PAGSEGURO';
      objConcil.CfgEstabelecimentos := 'CFG_PAGEST';
      objConcil.CampoValorBruto := INICAM + 'VALBRU';
      objConcil.CampoValorLiquido := INICAM + 'VALPAR';
      objConcil.CampoCodigoAutorizacao := INICAM + 'CODAUT';
      objConcil.CampoIDTransacao := INICAM + 'CODTRA';
      objConcil.CampoNumeroNSU := INICAM + 'NUMNSU';
      objConcil.CampoDataTransacaoVenda := INICAM + 'DTATRA';
      objConcil.CampoNumeroParcela := INICAM + 'NUMPAR';
      objConcil.CampoTotalParcelas := INICAM + 'TOTPAR';
      objConcil.CampoNumeroCartao := INICAM + 'NUMCAR';
      objConcil.CampoDataRecebimento := INICAM + 'DTAPAG';
      objConcil.CampoTipoRegistro := INICAM + 'TIPREG';
      objConcil.CampoTipoTransacao := INICAM + 'TIPLAN';
      objConcil.CfgPortadorAjustes := 'PAGPOR';
      objConcil.CfgPlanoDeContasAjustes := 'PAGCTA';
      objConcil.CfgFornecedorAjustes := 'PAGFOR';
      objConcil.strEventoCancelamentoAjuste := 'PAGEVE';
      objConcil.CfgPortadorTransferencia := 'PAGTRF';
      objConcil.CfgPlanoDeContasTransferencia := 'PAGCTF';
      objConcil.CfgCentroDeCustosTransferencia := 'PAGETF';
      objConcil.CfgVlrTolerancia := 'PAGTOL';

      objConcil.strChavePrimaria := 'PAG_CODEST,PAG_TIPREG,PAG_DTAPAG,PAG_TIPEVE,PAG_DTATRA,PAG_CODAUT,PAG_NUMPAR,PAG_NUMNSU';

      If Not fDigPeriodo Then
        Exit;

      TForm(pgbStatus.Owner).Visible := True;
      pgbStatus.Visible := False;

      TPagSeguroFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros para conciliação (PAGSEGURO).', False);
      If Not fProcessaPagSeguroPag(pgbStatus) Then
        Exit;

      cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
      cdsBaiCar.Filtered := True;

      FPossuiInconsistencia := False;

      TPagSeguroFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Gravando registros do relatório (' + objConcil.NomeConciliacao + ').', False);
      GravarRegistrosRelatorio(pgbStatus);

      If FPossuiInconsistencia Then
        TPagSeguroFuncoes.fMensagem('','Foram encontradas inconsistências na importação dos arquivos!',['&OK']);

      If FListaRegistrosRelatorio.Count > 0 Then
        Result := GeraRelatorioConciliacao('PAGSEGURO', pgbStatus);

      If Assigned(cdsAjustes) Then
      Begin
        cdsAjustes.Filter   := 'PAG_CONCIL=0';
        cdsAjustes.Filtered := True;
      End;

      blnReabre := Not Result;
      If Result Then
      Begin
        cdsBaiCar.Filter := 'MCA_MARDES=''M'' ';
        cdsBaiCar.Filtered := True;

        Result := Not cdsBaiCar.IsEmpty;
        If Not Result Then
          TPagSeguroFuncoes.fMensagem('ATENÇÃO','Nenhum pagamento foi conciliado no período selecionado!',['&OK'])
        Else
          TPagSeguroFuncoes.fMensagem('AVISO','Conciliação da PAGSEGURO realizada com sucesso.',['&OK']);
      End;
    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[untConciliacaoPagSeguro.fConciliaPagSeguro]');
      End;
    End;
  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(cdsConCar);
    TPagSeguroFuncoes.FreeAndNilDatasets(cdsAjustes);
  End;
End;

procedure TConcilPagSeguro.AcertaDataDeRecebimentoParaOProximoDiaUtil(
  cdsRegistros: TDataset);
begin
  If cdsRegistros.FieldByName('MCA_DTAREC').AsDateTime = VS_FuncoesExternas.fIAcertaDataParaDiaUtil(cdsRegistros.FieldByName('MCA_DTAREC').AsDateTime) Then
    Exit;

  cdsRegistros.Edit;
  cdsRegistros.FieldByName('MCA_DTAREC').AsDateTime := VS_FuncoesExternas.fIAcertaDataParaDiaUtil(cdsRegistros.FieldByName('MCA_DTAREC').AsDateTime);
  cdsRegistros.Post;
end;

procedure TConcilPagSeguro.ConciliacaoDeParceladosComPagamentoUnico;
  Var
    LParcela,
    LTipoCartao,
    LChaveConciliacao: String;

    LValorBruto,
    LValorLiquido,
    LTaxaDeAntecipacao: Double;

    LContadorParcelas,
    LRegistroValorInvalido: Integer;

    LBuscaCartao: Boolean;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  If cdsConCar.FieldByName(INICAM + 'TOTPAR').AsInteger <= 1 Then
    Exit;

  LTipoCartao := RetornaTipoDoCartao;

  LValorBruto := RetornaValorBrutoDoCartao;

  LValorLiquido := RetornaValorLiquidoDoCartao;

  LTaxaDeAntecipacao := RetornaTaxaDeAntecipacao;

  For LContadorParcelas := 2 To cdsConCar.FieldByName(INICAM + 'TOTPAR').AsInteger Do
  Begin
    LRegistroRelatorio := TItensRelatorioCartoes.Create;

    FTextoInconsistencia := '';

    LParcela := RetornaParcela(LContadorParcelas.ToString);

    LBuscaCartao := fBuscaCartao(cdsConCar.FieldByName(INICAM + 'CODAUT').Value,
                                 TPagSeguroFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName(INICAM + 'NUMNSU').Value, 14)), 14),
                                 cdsConCar.FieldByName('CODEMP').AsString,
                                 LParcela,
                                 cdsConCar.FieldByName(INICAM + 'DTATRA').Value,
                                 0,
                                 True,
                                 LValorBruto);

    If LBuscaCartao Then
    Begin
      If fBetween(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto, -0.10999999, 0.10999999) Then
      Begin
        LChaveConciliacao := 'PAG_' + cdsConCar.FieldByName('PAG_CODAUT').AsString + '_' +
                             LParcela + '_' +
                             cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                             FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('PAG_DTATRA').AsDateTime);

        MarcarCartaoEncontradoArquivo(LValorLiquido,
                                      LTipoCartao.Equals('ANTECIPAÇÃO'),
                                      LRegistroRelatorio,
                                      LChaveConciliacao,
                                      cdsConCar,
                                      LTaxaDeAntecipacao);

        If cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
          AcertaDataDeRecebimentoParaOProximoDiaUtil(cdsBaiCar);
      End
      Else
      Begin
        //Verificando outras liberações com a mesma data
        LRegistroValorInvalido := cdsBaiCar.RecNo;
        cdsBaiCar.Next;

        While RegistroPossuiAMesmaAutorizacao(cdsConCar.FieldByName('PAG_CODAUT').Value,
                                              LParcela,
                                              cdsConCar.FieldByName('CODEMP').AsString,
                                              cdsConCar.FieldByName('PAG_DTATRA').AsString) Do
        Begin
          If fBetween(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto, -0.10999999, 0.10999999) Then
          Begin
            LChaveConciliacao := 'PAG_' + cdsConCar.FieldByName('PAG_CODAUT').AsString + '_' +
                             LParcela + '_' +
                             cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                             FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('PAG_DTATRA').AsDateTime);

            MarcarCartaoEncontradoArquivo(LValorLiquido,
                                          LTipoCartao.Equals('ANTECIPAÇÃO'),
                                          LRegistroRelatorio,
                                          LChaveConciliacao,
                                          cdsConCar,
                                          LTaxaDeAntecipacao);

            If cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
              AcertaDataDeRecebimentoParaOProximoDiaUtil(cdsBaiCar);

            Break;
          End;

          cdsBaiCar.Next;

          If cdsBaiCar.Eof Then
            Break;
        End;

        If Not (fBetween(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto, -0.10999999, 0.10999999)) Then
        Begin
          cdsBaiCar.RecNo := LRegistroValorInvalido;
          FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização duplicada';
        End;
      End;
    End
    Else If FTextoInconsistencia.IsEmpty Then
    Begin
      blnAutomatica := cdsConCar.FieldByName('PAG_CONCIL').AsString.Equals('1');

      FTextoInconsistencia := 'Cartão já foi baixado';

      cdsBaixad.First;
      LBuscaCartao := fBuscaCartaoBaixado(cdsConCar.FieldByName('PAG_CODAUT').AsString,
                                          TPagSeguroFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('PAG_NUMNSU').AsString, 14)), 14),
                                          cdsConCar.FieldByName('CODEMP').AsString,
                                          LParcela,
                                          cdsConCar.FieldByName('PAG_DTATRA').AsDateTime);

      If Not LBuscaCartao Then
        FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';
    End;

    If FTextoInconsistencia.IsEmpty Then
    Begin
      If PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(LValorBruto, cdsBaiCar) Then
        FTextoInconsistencia := RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa;
    End;

    {Gerando registro do relatório}
    FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
    If Not FTextoInconsistencia.IsEmpty Then
    Begin
      LRegistroRelatorio.Descricao := FTextoInconsistencia;
      LRegistroRelatorio.SomarNoTotal := 'N';

      If Not LRegistroRelatorio.Descricao.Equals(RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa) Then
      Begin
        LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
        LRegistroRelatorio.SomarNoTotal := 'S';
      End;
    End;
    LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('PAG_NOMARQ').AsString;
    LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName('PAG_CODEST').AsString;
    LRegistroRelatorio.CodigoEmpresa := cdsConCar.FieldByName('CODEMP').AsString;
    LRegistroRelatorio.NumeroNSU := TPagSeguroFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('PAG_NUMNSU').AsString, 14)), 14);
    LRegistroRelatorio.CodigoAutorizacao := TPagSeguroFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('PAG_CODAUT').Value, 6)), 6);
    LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('PAG_CODVEN').AsString;
    LRegistroRelatorio.NumeroCartao := RetornoNumeroDoCartao;

    If LRegistroRelatorio.TipoCartao.IsEmpty Then
      LRegistroRelatorio.TipoCartao := LTipoCartao;

    LRegistroRelatorio.Parcela := TPagSeguroFuncoes.fStrZero(LContadorParcelas.ToString, 2);
    LRegistroRelatorio.TotalParcelas := TPagSeguroFuncoes.fStrZero(cdsConCar.FieldByName('PAG_TOTPAR').AsString, 2);
    LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('PAG_DTAPAG').AsDateTime;
    LRegistroRelatorio.DataVenda := cdsConCar.FieldByName('PAG_DTATRA').AsDateTime;
    LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('PAG_DTAPAG').AsDateTime;

    LRegistroRelatorio.ValorBruto := LValorBruto;
    LRegistroRelatorio.ValorLiquido := LValorLiquido;

    LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

    FListaRegistrosRelatorio.Add(LRegistroRelatorio);

    If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
      GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);
  End;
end;

function TConcilPagSeguro.CalculaValorBrutoUltimaParcela(AValorParcela: Double; out AValorUltimaParcela: Double): Boolean;
var
  LDiferencaRateio: Double;
  LSaldoTotal: Double;
begin
  Result := False;
  AValorUltimaParcela := AValorParcela;

  If cdsConCar.FieldByName(INICAM + 'TOTPAR').AsInteger < 2 Then
    Exit;

  If cdsConCar.FieldByName(INICAM + 'NUMPAR').AsInteger < cdsConCar.FieldByName(INICAM + 'TOTPAR').AsInteger Then
    Exit;

  LSaldoTotal  := TPagSeguroFuncoes.fFormataFloat(AValorParcela * cdsConCar.FieldByName(INICAM + 'TOTPAR').AsInteger, 2);
  LDiferencaRateio := TPagSeguroFuncoes.fFormataFloat(cdsConCar.FieldByName(INICAM + 'VALBRU').AsFloat - LSaldoTotal, 2);
  Result := LDiferencaRateio <> 0;

  If Result Then
    AValorUltimaParcela := TPagSeguroFuncoes.fFormataFloat(AValorParcela + LDiferencaRateio, 2);
end;

function TConcilPagSeguro.fConciliaCartoes: Boolean;
begin
  Result := TPagSeguroFuncoes.ExecutaAguarde(fConciliaPagSeguro, 'Aguarde... Iniciando a conciliação.');
end;

function TConcilPagSeguro.fProcessaPagSeguroPag(pgbStatus: TcxProgressBar): Boolean;
  Var
    LRegistroRelatorio: TItensRelatorioCartoes;

    LValorBruto,
    LValorLiquido,
    LTaxaDeAntecipacao: Double;

    LParcela,
    LTipoCartao,
    LChaveConciliacao,
    LFiltroTransferencias,
    LCondicaoAjustes,
    LParcelaRelatorio: String;

    LBuscaCartao,
    LPagamentoUnico: Boolean;

    LRegistroAtual: Integer;

    LConsulta: TUniQuery;

    prcScroll: TprcScroll;
begin
  strRcxTcc := VS_FuncoesExternas.fICfgSis('RCXTCC');
  Application.ProcessMessages;

  LConsulta := Nil;
  Try
    Try
      LConsulta := VS_FuncoesExternas.fICriaQuery;
      LConsulta.SQL.Text := 'SHOW TABLES LIKE "' + NOMTAB + '"';
      LConsulta.Open;
      If LConsulta.IsEmpty Then
      Begin
        TPagSeguroFuncoes.fMensagem('','Não existem arquivos importados para a conciliação da PAGSEGURO!',['&OK']);
        Exit(False);
      End;

      LConsulta.Close;
      LConsulta.SQL.Text := RetornaSQLConciliacao;

      LConsulta.ParamByName('DTAIN').AsString  := FormatDateTime('yyyy/MM/dd', dtaDtaIni);
      LConsulta.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy/MM/dd', dtaDtaFim);

      LConsulta.Open;

      If LConsulta.IsEmpty Then
      Begin
        TPagSeguroFuncoes.fMensagem('','Não existem arquivos importados nesse período de recebimento!',['&OK']);
        blnReabre := True;
        Exit(False);
      End;

      cdsConCar := TPagSeguroFuncoes.CriarClientDataSet(LConsulta);
    Finally
      TPagSeguroFuncoes.FreeAndNilDatasets(LConsulta);
    End;

    LCondicaoAjustes :=  'PAG_DTAPAG BETWEEN "' + FormatDateTime('yyyy-mm-dd', dtaDtaIni) + '" AND "' + FormatDateTime('yyyy-mm-dd', dtaDtaFim) + '" ';

    LFiltroTransferencias := 'PAG_DTAPAG BETWEEN "' + FormatDateTime('yyyy-mm-dd', dtaDtaIni) + '" AND "' + FormatDateTime('yyyy-mm-dd', dtaDtaFim) + '" ' +
                             fRetPesqPonVen(1) + ' AND ' +
                             ' (PAG_TIPREG = "TF") AND (PAG_VALPAR <> 0)';

    pCalculaPeriodoFiltro(INICAM + 'DTATRA');

    TPagSeguroFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando registros.', False);
    pFiltraCartoes;

    //Filtrando Cancelamentos/Ajustes
    LCondicaoAjustes := LCondicaoAjustes + StringReplace(fRetPesqPonVen(1), objConcil.CampoEstabelecimento, 'A.' + objConcil.CampoEstabelecimento, [rfReplaceAll]);
    LCondicaoAjustes := LCondicaoAjustes + ' AND (PAG_TIPREG = "AJ") AND (PAG_VALPAR <> 0) AND PAG_TIPEVE NOT IN ("07", "08") ';
    FiltrarCancelamentosPeriodo(LCondicaoAjustes,
                                fRetornaSQLMotivoAjuste,
                                ' IF(PAG_TIPEVE IN ("01", "02", "10", "12"), PAG_VALPAR, 0) ');

    If cdsConCar.RecordCount + cdsAjustes.RecordCount = 0 Then
    Begin
      TPagSeguroFuncoes.fMensagem('ATENÇÃO','Não existem arquivos importados nesse período de recebimento!',['&OK']);
      cdsConCar.Close;
      blnReabre := True;
      Exit(False);
    End;

    FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                          'PAGSEGURO',
                                                          'CONCILIACAO',
                                                          RetornaFiltrosdigitados,
                                                          TPagSeguroFuncoes.RetornaDataHoraServidor,
                                                          TPagSeguroFuncoes.RetornaHoraServidor);

    TPagSeguroFuncoes.pDisableControls(cdsBaiCar, prcScroll);

    AdicionaRegistrosDeTransferencias(LFiltroTransferencias);

    TPagSeguroFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando registros.', False);
    pFiltraCartoesBaixados;

    TPagSeguroFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Selecionando registros para conciliação (PAGSEGURO).', False);
    pgbStatus.Visible := True;
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsConCar.RecordCount;

    CarregaIndicesBusca;

    cdsConCar.First;
    While Not cdsConCar.EOF do
    Begin
      TPagSeguroFuncoes.pStepStatusGravacao(pgbStatus);
      FTextoInconsistencia := EmptyStr;

      If cdsConCar.FieldByName(INICAM + 'TIPREG').AsString = 'TF' Then
      Begin
        cdsConCar.Next;
        Continue;
      End;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      If cdsConCar.FieldByName(INICAM + 'STAPAG').AsInteger In [2, 3, 4] Then
      Begin
        LPagamentoUnico := (cdsConCar.FieldByName(INICAM + 'PAGPRA').AsString = 'U') Or
                           ((cdsConCar.FieldByName(INICAM + 'PAGPRA').AsString = 'M') And
                            (cdsConCar.FieldByName(INICAM + 'TOTPAR').AsInteger > 1) And
                            (cdsConCar.FieldByName(INICAM + 'PLANO_').AsString = '1'));

        LTipoCartao := RetornaTipoDoCartao;

        LValorBruto := RetornaValorBrutoDoCartao;

        LValorLiquido := RetornaValorLiquidoDoCartao;

        //Arrumando erro que veio no arquivo da PAGSEGURO
        //Valor da parcela com valor líquido da venda em pagamento Multiplo
        If LTipoCartao.Equals('CRÉDITO PARCELADO') Then
        Begin
          If LValorBruto < LValorLiquido Then
            LValorLiquido := TPagSeguroFuncoes.fFormataFloat(LValorLiquido /
                                                             cdsConCar.FieldByName('PAG_TOTPAR').AsInteger, 2);
        End;

        LTaxaDeAntecipacao := RetornaTaxaDeAntecipacao;

        LParcelaRelatorio := TPagSeguroFuncoes.IIF(cdsConCar.FieldByName('PAG_NUMPAR').AsInteger = 0, '01', TPagSeguroFuncoes.fStrZero(cdsConCar.FieldByName('PAG_NUMPAR').AsString, 2)) + '/' +
                             TPagSeguroFuncoes.IIF(cdsConCar.FieldByName('PAG_TOTPAR').AsInteger = 0, '01', TPagSeguroFuncoes.fStrZero(cdsConCar.FieldByName('PAG_TOTPAR').AsString, 2));

        If Not TPagSeguroFuncoes.fStrZero(cdsConCar.FieldByName('PAG_NUMPAR').AsString, 2).Equals('00') Then
        Begin
          LParcela := RetornaParcela(cdsConCar.FieldByName('PAG_NUMPAR').AsString);

          LBuscaCartao := fBuscaCartao(cdsConCar.FieldByName('PAG_CODAUT').AsString,
                                       TPagSeguroFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('PAG_NUMNSU').AsString, 14)), 14),
                                       cdsConCar.FieldByName('CODEMP').AsString,
                                       LParcela,
                                       cdsConCar.FieldByName('PAG_DTATRA').AsDateTime,
                                       0,
                                       True,
                                       LValorBruto);

          If Not LBuscaCartao Then
          Begin
            If MatchStr(LTipoCartao,['PIX','BOLETO']) Then
              LBuscaCartao := BuscaCartaoPorIDTransacao(cdsConCar.FieldByName('PAG_CODTRA').AsString,
                                                        cdsConCar.FieldByName('CODEMP').AsString,
                                                        LParcela,
                                                        cdsConCar.FieldByName('PAG_DTATRA').AsDateTime);
          End;

          If LBuscaCartao Then
          Begin
            FTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);
            If fBetween(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto, -FTolerancia, FTolerancia) Then
            Begin
              LChaveConciliacao := 'PAG_' + cdsConCar.FieldByName('PAG_CODAUT').AsString + '_' +
                                   LParcela + '_' +
                                   cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                                   FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('PAG_DTATRA').AsDateTime);

              MarcarCartaoEncontradoArquivo(LValorLiquido,
                                            LTipoCartao.Equals('ANTECIPAÇÃO'),
                                            LRegistroRelatorio,
                                            LChaveConciliacao,
                                            cdsConCar,
                                            LTaxaDeAntecipacao);

              If cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
                AcertaDataDeRecebimentoParaOProximoDiaUtil(cdsBaiCar);
            End
            Else
            Begin
              //Verificando outras liberações com a mesma data
              LRegistroAtual := cdsBaiCar.RecNo;
              cdsBaiCar.Next;
              While RegistroPossuiAMesmaAutorizacao(cdsConCar.FieldByName('PAG_CODAUT').Value,
                                                    LParcela,
                                                    cdsConCar.FieldByName('CODEMP').AsString,
                                                    cdsConCar.FieldByName('PAG_DTATRA').AsString) Do
              Begin
                FTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);
                If fBetween(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto, -FTolerancia, FTolerancia) Then
                Begin
                  LChaveConciliacao := 'PAG_' + cdsConCar.FieldByName('PAG_CODAUT').AsString + '_' +
                                       LParcela + '_' +
                                       cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                                       FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('PAG_DTATRA').AsDateTime);

                  MarcarCartaoEncontradoArquivo(LValorLiquido,
                                                LTipoCartao.Equals('ANTECIPAÇÃO'),
                                                LRegistroRelatorio,
                                                LChaveConciliacao,
                                                cdsConCar,
                                                LTaxaDeAntecipacao);

                  If cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
                    AcertaDataDeRecebimentoParaOProximoDiaUtil(cdsBaiCar);

                  Break;
                End;

                cdsBaiCar.Next;

                If cdsBaiCar.Eof Then
                  Break;
              End;

              FTolerancia := RetornaValorTolerancia(cdsConCar.FieldByName('CODEMP').AsString);
              If Not fBetween(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto, -FTolerancia, FTolerancia) Then
              Begin
                cdsBaiCar.RecNo := LRegistroAtual;
                FTextoInconsistencia := 'Valor do cartão diferente do registrado no sistema ou Autorização duplicada';
              End;
            End;
          End
          Else If TPagSeguroFuncoes.fEmptyStr(FTextoInconsistencia) Then
          Begin
            blnAutomatica := cdsConCar.FieldByName('PAG_CONCIL').AsString.Equals('1');

            FTextoInconsistencia := 'Cartão já foi baixado';

            cdsBaixad.First;
            LBuscaCartao := fBuscaCartaoBaixado(cdsConCar.FieldByName('PAG_CODAUT').AsString,
                                                TPagSeguroFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('PAG_NUMNSU').AsString, 14)), 14),
                                                cdsConCar.FieldByName('CODEMP').AsString,
                                                LParcela,
                                                cdsConCar.FieldByName('PAG_DTATRA').AsDateTime);
            If Not LBuscaCartao Then
            Begin
              If MatchStr(LTipoCartao, ['PIX','BOLETO']) Then
                LBuscaCartao := BuscaCartaoBaixadoPorIDTransacao(cdsConCar.FieldByName('PAG_CODTRA').AsString,
                                                                 cdsConCar.FieldByName('CODEMP').AsString,
                                                                 LParcela,
                                                                 cdsConCar.FieldByName('PAG_DTATRA').AsDateTime);
            End;

            If Not LBuscaCartao Then
              FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';
          End;
        End
        Else
        Begin
          FTextoInconsistencia := 'Registro inconsistente com o layout.';

          LParcelaRelatorio := TPagSeguroFuncoes.fStrZero(cdsConCar.FieldByName(INICAM + 'NUMPAR').AsString, 2) + '/' +
                               TPagSeguroFuncoes.fStrZero(cdsConCar.FieldByName(INICAM + 'TOTPAR').AsString, 2);
        End;

        If TPagSeguroFuncoes.fEmptyStr(FTextoInconsistencia) Then
        Begin
          If PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(LValorBruto, cdsBaiCar) Then
            FTextoInconsistencia := RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa;
        End;

        {Gerando registro do relatório}
        FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
        If Not FTextoInconsistencia.IsEmpty Then
        Begin
          LRegistroRelatorio.Descricao := FTextoInconsistencia;
          LRegistroRelatorio.SomarNoTotal := 'N';

          If Not LRegistroRelatorio.Descricao.Equals(RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa) Then
          Begin
            LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
            LRegistroRelatorio.SomarNoTotal := 'S';
          End;
        End;
        LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('PAG_NOMARQ').AsString;
        LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName('PAG_CODEST').AsString;
        LRegistroRelatorio.CodigoEmpresa := cdsConCar.FieldByName('CODEMP').AsString;
        LRegistroRelatorio.NumeroNSU := TPagSeguroFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('PAG_NUMNSU').AsString, 14)), 14);
        LRegistroRelatorio.CodigoAutorizacao := TPagSeguroFuncoes.fStrZero(Trim(RightStr(cdsConCar.FieldByName('PAG_CODAUT').Value, 6)), 6);
        LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('PAG_CODVEN').AsString;
        LRegistroRelatorio.NumeroCartao := RetornoNumeroDoCartao;

        If LRegistroRelatorio.TipoCartao.IsEmpty Then
          LRegistroRelatorio.TipoCartao := LTipoCartao;

        LRegistroRelatorio.Parcela := LeftStr(LParcelaRelatorio, 2);
        LRegistroRelatorio.TotalParcelas := RightStr(LParcelaRelatorio, 2);
        LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('PAG_DTAPAG').AsDateTime;
        LRegistroRelatorio.DataVenda := cdsConCar.FieldByName('PAG_DTATRA').AsDateTime;
        LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('PAG_DTAPAG').AsDateTime;

        LRegistroRelatorio.ValorBruto := LValorBruto;
        LRegistroRelatorio.ValorLiquido := LValorLiquido;

        If MatchStr(LTipoCartao, ['PIX','BOLETO'] )Then
          LRegistroRelatorio.CodigoAutorizacao := cdsConCar.FieldByName('PAG_CODTRA').AsString;

        LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

        FListaRegistrosRelatorio.Add(LRegistroRelatorio);

        If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
          GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

        If LPagamentoUnico Then
          ConciliacaoDeParceladosComPagamentoUnico;
      End;

      cdsConCar.Next;
    End;
  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(cdsBaixad);
  End;

  Result := True;
end;

function TConcilPagSeguro.fRetornaSQLMotivoAjuste: String;
begin
  Result := '';
  Result := Result + 'CASE A.PAG_TIPEVE                            ';
  Result := Result + ' WHEN "01" THEN "Venda ou Pagamento"         ';
  Result := Result + ' WHEN "02" THEN "Ajuste a Crédito"           ';
  Result := Result + ' WHEN "03" THEN "Ajuste a Débito"            ';
  Result := Result + ' WHEN "04" THEN "Operação conta PagSeguro"   ';
  Result := Result + ' WHEN "05" THEN "Chargeback"                 ';
  Result := Result + ' WHEN "06" THEN "Cancelamento"               ';
  Result := Result + ' WHEN "09" THEN "Abertura Disputa"           ';
  Result := Result + ' WHEN "10" THEN "Encerramento Disputa"       ';
  Result := Result + ' WHEN "11" THEN "Abertura Pré Chargeback"    ';
  Result := Result + ' WHEN "12" THEN "Encerramento Pré Chargeback"';
  Result := Result + ' ELSE CONCAT(A.PAG_TIPEVE, " - Outros") END  ';
end;

function TConcilPagSeguro.RegistroPossuiAMesmaAutorizacao(AAutorizacao,
  AParcela, AEmpresa, ADataCupom: String): Boolean;
begin
  Result := cdsBaiCar.FieldByName('MCA_NUMCCD').AsString = AAutorizacao;

  If Not Result Then
    Exit;

  Result := cdsBaiCar.FieldByName('PARDUP').AsString = AParcela;

  If Not Result Then
    Exit;

  If Not cdsConCar.FieldByName('CODEMP').AsString.IsEmpty Then
  Begin
    Result := cdsBaiCar.FieldByName('MCA_EMPRCX').AsString = AEmpresa;

    If Not Result Then
      Exit;
  End;

  Result := cdsBaiCar.FieldByName('MCA_DTACUP').AsString = ADataCupom;

  If Not Result Then
    Exit;

  Result := cdsBaiCar.FieldByName('MCA_MARDES').AsString = 'D';
end;

function TConcilPagSeguro.RetornaParcela(AParcela: String): String;
begin
  Result := TPagSeguroFuncoes.fStrZero(AParcela, 2);

  Result := TPagSeguroFuncoes.fGetLetraAlfa(StrToInt(Result));
end;

function TConcilPagSeguro.RetornaSQLConciliacao: String;
begin
  Result := '';
  Result := Result + ' SELECT *,                                             ';
  Result := Result + ' COALESCE(SIS_CODEMP, "") AS CODEMP,                   ';
  Result := Result + ' COALESCE(EMP_NOMEMP, "") AS EMP_NOMEMP,               ';
  Result := Result + ' EMP_NOMEMP FROM ' + NOMTAB + '                        ';
  Result := Result + ' LEFT JOIN CFGSIS ON SIS_CODCFG IN ("CFG_PAGEST", "CFG_PAGLNK") ';
  Result := Result + '                 AND (TRIM(LEADING 0 FROM SIS_VALCFG) = TRIM(LEADING 0 FROM PAG_CODEST) ';
  Result := Result + '                  OR LOCATE(PAG_CODEST, SIS_VALCFG) > 0) ';
  Result := Result + ' LEFT JOIN CADEMP ON SIS_CODEMP=EMP_CODEMP             ';
  Result := Result + ' WHERE PAG_DTAPAG BETWEEN :DTAIN AND :DTAFIM           ';
  Result := Result + ' AND ((PAG_TIPREG IN ("PG", "AP") AND PAG_MEIPAG IN ("03", "04", "08", "11","02","14","15") ';
  Result := Result + ' AND PAG_TIPEVE NOT IN ("07", "08"))                   ';
  Result := Result + ' OR (PAG_TIPREG="TF"))                                 ';
  Result := Result + fRetPesqPonVen(0);
  Result := Result + ' ORDER BY PAG_TIPREG, PAG_DTAPAG                       ';
end;

function TConcilPagSeguro.RetornaTaxaDeAntecipacao: Double;
begin
  Result := cdsConCar.FieldByName(INICAM + 'TAXPAR').AsFloat;
  If cdsConCar.FieldByName(INICAM + 'TOTPAR').AsInteger > 1 Then
  Begin
    If cdsConCar.FieldByName(INICAM + 'PAGPRA').AsString = 'U' Then
      Result := Result / cdsConCar.FieldByName(INICAM + 'TOTPAR').AsInteger;
  End;

  Result := TPagSeguroFuncoes.fFormataFloat(Result, 2);
end;

function TConcilPagSeguro.RetornaTipoDoCartao: String;
begin
  Result := 'CRÉDITO ROTATIVO';

  If (cdsConCar.FieldByName(INICAM + 'TIPREG').Value = 'AP') Then
    Result := 'ANTECIPAÇÃO'
  Else If cdsConCar.FieldByName(INICAM + 'MEIPAG').AsString = '08' Then
    Result := 'DÉBITO'
  Else If cdsConCar.FieldByName(INICAM + 'MEIPAG').AsString = '11' Then
    Result := 'PIX'
  Else If cdsConCar.FieldByName(INICAM + 'MEIPAG').AsString.Equals('02') Then
    Result := 'BOLETO'
  Else If cdsConCar.FieldByName(INICAM + 'TOTPAR').AsInteger > 1 Then
  Begin
    Result := 'CRÉDITO PARCELADO';

    If cdsConCar.FieldByName(INICAM + 'PAGPRA').AsString = 'U' Then
      Result := 'ANTECIPAÇÃO';
  End;
end;

function TConcilPagSeguro.RetornaValorBrutoDoCartao: Double;
var
  LValorUltimaParcela: Double;
begin
  Result := TPagSeguroFuncoes.fFormataFloat(cdsConCar.FieldByName(INICAM + 'VALBRU').AsFloat, 2);

  If cdsConCar.FieldByName(INICAM + 'MEIPAG').AsString = '08' Then
    Exit;

  If cdsConCar.FieldByName(INICAM + 'TOTPAR').AsInteger = 0 Then
    Exit;

  If cdsConCar.FieldByName(INICAM + 'TIPREG').AsString = 'AT' Then
    Exit;

  Result := TPagSeguroFuncoes.fFormataFloat(cdsConCar.FieldByName(INICAM + 'VALBRU').AsFloat / cdsConCar.FieldByName(INICAM + 'TOTPAR').AsInteger, 2);

  If CalculaValorBrutoUltimaParcela(Result, LValorUltimaParcela) Then
    Result := LValorUltimaParcela;
end;

function TConcilPagSeguro.RetornaValorLiquidoDoCartao: Double;
begin
  Result := TPagSeguroFuncoes.fFormataFloat(cdsConCar.FieldByName(INICAM + 'VALLIQ').AsFloat, 2);

  If cdsConCar.FieldByName(INICAM + 'TIPREG').Value = 'AP' Then
    Exit;

  Result := cdsConCar.FieldByName(INICAM + 'VALPAR').AsFloat;
  If cdsConCar.FieldByName(INICAM + 'TOTPAR').AsInteger > 1 Then
  Begin
    If cdsConCar.FieldByName(INICAM + 'PAGPRA').AsString = 'U' Then
      Result := Result / cdsConCar.FieldByName(INICAM + 'TOTPAR').AsInteger
    Else If cdsConCar.FieldByName(INICAM + 'PAGPRA').AsString = 'M' Then
    Begin
      If cdsConCar.FieldByName(INICAM + 'PLANO_').AsString = '1' Then
        Result := Result / cdsConCar.FieldByName(INICAM + 'TOTPAR').AsInteger;
    End;
  End;

  Result := TPagSeguroFuncoes.fFormataFloat(Result, 2);
end;

function TConcilPagSeguro.RetornoNumeroDoCartao: String;
begin
  Result := cdsConCar.FieldByName(INICAM + 'NUMCAR').AsString;
  If cdsConCar.FieldByName(INICAM + 'MEIPAG').AsString.Equals('02') Then
    Result := 'BOLETO';
end;

end.
