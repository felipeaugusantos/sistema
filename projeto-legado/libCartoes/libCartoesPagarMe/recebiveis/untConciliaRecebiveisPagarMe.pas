unit untConciliaRecebiveisPagarMe;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, Vcl.Graphics, System.DateUtils, System.Math,

     Uni, UniClientDataSet, cxProgressBar,

     untTPagarMeFuncoes, untTLibCartoesMovCar, untLibCartoesInterfacesTipos,
     untPagarMeConciliaRecebiveis;

type

  TConciliacaoPagarMeRecebiveis = class(TConciliaRecebiveisMkt)
  private
    FCdsRegistrosPagamento : TUniClientDataSet; //Registros Conciliação Financeira
    FCdsRegistrosAjuste    : TUniClientDataSet; //Registros Ajustes
    FCdsPedidosComMaisDeUmCartao: TUniClientDataSet;
    FCdsVendasCanceladas:    TUniClientDataSet;

    FModeloAtualizado: Boolean;

    FCartoesPagarMe,
    FListaDePedidos: String;

    FValidaTaxaPercentual: Boolean;

    FAutoIncremRelatorio: Integer;

    procedure pCriaDataSets;

    function RetornaListaDePedidos: String;

    procedure pFiltraCartoesPagarMe;
    function fBuscaCartaoPagarMe: Boolean;

    procedure pFiltraCartoesBaixadosPagarMe;
    function fBuscaCartaoBaixadoPagarMe: Boolean;

    function fGetTipoDeOperacao(ACodigoModalidade : String; ATotalParcelas : Integer): String;
    function RetornoNumeroDoCartao: String;
    function RetornaConsultaConciliacao: String;
    function RetornaDescricaoDoAjuste(ATipoRecebimento: String): String;
    function RetornaTipoPagamento: String;
    procedure AdicionaRegistrosDeTransferencias;
    procedure PedidosPagosComMaisDeUmCartao;
    function Parcela(ANumNsu: String; AParcela: Integer;
      AConverterParaLetra: Boolean = True): String;
    procedure VendasCanceladas;
    function GerarAjusteDeVendaCancelada: Boolean;
    function GerarAjusteVendasPeloSite: boolean;
    function GerarVendaNaoEncontrada: boolean;
    procedure GerarCancelamentoAjusteDoPagamento(ADescricaoAjuste: String);

    function RetornaIDsEmpresaConciliacao: String;

    function RetornaNomeRecebedor(ACodigoRecebedor,
                                  ACfgRecebedor: String): String;

    function fProcessaRegistrosAjuste(pgbStatus: TcxProgressBar): Boolean;

    function fConciliaPagarMe(prgStatus: TcxProgressBar): Boolean;
    function fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar): Boolean;
  public
    constructor Create; overload;
    destructor Destroy; override;

    property AutoIncremRelatorio: Integer read FAutoIncremRelatorio;

    function fConciliaCartoes(prgStatus: TcxProgressBar): Boolean; override;

    function RetornaEmpresaFiltrada: String;
  end;

implementation

{ TConciliacaoPagarMe }

function TConciliacaoPagarMeRecebiveis.fConciliaPagarMe(prgStatus: TcxProgressBar): Boolean;
Var strStatus    : String;
begin
  Try
    Try
      Result       := False;

      FModeloAtualizado := VS_FuncoesExternas.fICfgSis('PGMVER', varString) = C_PGM_VERSAO_ATUALIZADA;
      FTipoTransferenciaCaixa := VS_FuncoesExternas.fICfgSis('RCXTCC');
      FValidaTaxaPercentual := VS_FuncoesExternas.fICfgSis('VLDTAX') = 1;
      FConciliacaoComPixAtivado := True;
      LConciliacaoComBoletoAtivado := True;

      Application.ProcessMessages;

      strStatus   := '';

      objConcil.TabelaConciliacao := 'PGM_PMRECE';
      objConcil.CampoEstabelecimento := 'PGM_ID_COB';
      objConcil.NomeConciliacao := 'PAGAR.ME';
      objConcil.CfgEstabelecimentos := 'CFG_PGMREI';
      objConcil.CampoValorBruto := 'PGM_VALPAR';
      objConcil.CampoValorLiquido := 'PGM_VALPAG';
      objConcil.CampoCodigoAutorizacao := 'PGM_CODAUT';
      objConcil.CampoDataTransacaoVenda := 'PGM_DTACAD';
      objConcil.CampoDataRecebimento := 'PGM_DTAPAG';
      objConcil.CfgPortadorAjustes := 'PGMPOR';
      objConcil.CfgPlanoDeContasAjustes := 'PGMCTA';
      objConcil.CfgFornecedorAjustes := 'PGMFOR';
      objConcil.strEventoCancelamentoAjuste := 'PGMEVE';
      objConcil.CfgVlrTolerancia            := 'PGMTOL';
      objConcil.CfgPortadorTransferencia    := 'PGMTRF';
      objConcil.CfgPlanoDeContasTransferencia := 'PGMCTF';
      objConcil.CfgCentroDeCustosTransferencia := 'PGMETF';
      objConcil.CfgPlanoDeContasTaxaTransferencia := 'PGMPTT';

      objConcil.strChavePrimaria := 'PGM_ID_REC,PGM_KEYAPI';
      objConcil.strChavePrimariaAjuste := 'PGM_ID_TRF,PGM_KEYAPI';

      TPagarMeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Filtrando registros para conciliação.', False);
      pCriaDataSets;

      If FCdsRegistrosPagamento.IsEmpty Then
      Begin
        If FCdsRegistrosAjuste.IsEmpty Then
        Begin
          TPagarMeFuncoes.fMensagem('ATENÇÃO', 'Nenhum registro foi importado para o período selecionado.', ['&Ok']);
          Exit;
        End;
      End;

      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'PAGAR.ME',
                                                            'CONCILIACAO',
                                                            RetornaFiltrosdigitados,
                                                            TPagarMeFuncoes.RetornaDataHoraServidor,
                                                            TPagarMeFuncoes.RetornaHoraServidor);

      TPagarMeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Filtrando cartões Pagar.Me.', False);
      PedidosPagosComMaisDeUmCartao;

      TPagarMeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Filtrando Vendas Canceladas Pagar.Me.', False);
      VendasCanceladas;

      TPagarMeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Filtrando cartões Pagar.Me.', False);
      pFiltraCartoesPagarMe;

      TPagarMeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Filtrando cartões Pagar.Me baixados.', False);
      pFiltraCartoesBaixadosPagarMe;

      AdicionaRegistrosDeTransferencias;

      cdsBaiCar.Filter   := 'MCA_MARDES <> ' + QuotedStr('M');
      cdsBaiCar.Filtered := True;

      If Not FCdsRegistrosAjuste.IsEmpty Then
      Begin
        TPagarMeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Selecionando registros para ajustes (' + objConcil.NomeConciliacao + ').', False);
        fProcessaRegistrosAjuste(prgStatus);
      End;

      If Not FCdsRegistrosPagamento.IsEmpty Then
      Begin
        TPagarMeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Selecionando registros para conciliação (' + objConcil.NomeConciliacao + ').', False);
        fProcessaRegistrosDebitoCredito(prgStatus);
      End;

      cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
      cdsBaiCar.Filtered := True;

      If Not TryStrToInt(FRelatorioConciliacao.AutoIncremRelatorio, FAutoIncremRelatorio) Then
        FAutoIncremRelatorio := 0;

      TPagarMeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Gravando registros dos relatórios (' + objConcil.NomeConciliacao + ').', False);
      GravarRegistrosRelatorio(prgStatus);
    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TConciliaRecebiveisPagarMe.fConciliaPagarMe]');
      End;
    End;
  Finally
    TPagarMeFuncoes.FreeAndNilDatasets(FCdsRegistrosPagamento);
    TPagarMeFuncoes.FreeAndNilDatasets(FCdsRegistrosAjuste);
    TPagarMeFuncoes.FreeAndNilDatasets(FCdsPedidosComMaisDeUmCartao);
    TPagarMeFuncoes.FreeAndNilDatasets(FCdsVendasCanceladas);
  End;
end;

procedure TConciliacaoPagarMeRecebiveis.AdicionaRegistrosDeTransferencias;
var
  LConsulta: TUniQuery;

  LRegistroRelatorio: TItensRelatorioCartoes;

  LStatusFiltro: String;
begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;

     If FModeloAtualizado Then
      LStatusFiltro := '"success", "available"'
    Else
      LStatusFiltro := '"available"';

    LConsulta.SQL.Text := 'SELECT PGM_PMTRAN.*,                               ' +
                          '  EST.SIS_CODEMP AS EMPRESA,                       ' +
                          '  POR.SIS_VALCFG AS PORTADOR,                      ' +
                          '  CTA.SIS_VALCFG AS PLANODECONTAS,                 ' +
                          '  EVE.SIS_VALCFG AS CENTRODECUSTOS,                ' +
                          '  PGM_TIPREG AS TIPREG,                            ' +
                          '  PGM_SOURCE AS PGM_RECEBE,                        ' +
                          '  EST.SIS_VALCFG AS RECEBEDORES,                   ' +
                          '  PGM_ID_TRF AS PGM_ID_REC,                        ' +
                          '  "PGM_PMTRAN" AS NOME_TABELA                      ' +
                          'FROM                                               ' +
                          '  PGM_PMTRAN                                       ' +
                          '  LEFT JOIN CFGSIS EST                             ' +
                          '    ON SIS_CODCFG = "CFG_PGMREI"       AND         ' +
                          'EST.SIS_CODEMP = "' + RetornaEmpresaFiltrada + '" AND ' +
                          '       IFNULL(SIS_VALCFG, "") <> ""    AND         ' +
                          '       IFNULL(PGM_SOURCE, "") <> "" AND            ' +
                          '       LOCATE(PGM_SOURCE, EST.SIS_VALCFG) > 0      ' +
                          '  LEFT JOIN CADEMP                                 ' +
                          '    ON EMP_CODEMP = EST.SIS_CODEMP                 ' +
                          '  LEFT JOIN CFGSIS AS POR                          ' +
                          '    ON POR.SIS_CODEMP = EMP_CODEMP AND             ' +
                          '       POR.SIS_CODCFG = "CFG_PGMTRF"               ' +
                          '  LEFT JOIN CFGSIS AS CTA                          ' +
                          '     ON CTA.SIS_CODEMP = EMP_CODEMP AND            ' +
                          '        CTA.SIS_CODCFG = "CFG_PGMCTF"              ' +
                          '  LEFT JOIN CFGSIS AS EVE                          ' +
                          '     ON EVE.SIS_CODEMP = EST.SIS_CODEMP AND        ' +
                          '        EVE.SIS_CODCFG = "CFG_PGMETF"              ' +
                          'WHERE                                              ' +
                          '  (PGM_TIPREG = "transfer" AND PGM_STATUS IN (' + LStatusFiltro + ')) AND ' +
                          '  PGM_DTATRF BETWEEN "' + FormatDateTime('yyyy-mm-dd', DataInicioPeriodo) + '" AND "' + FormatDateTime('yyyy-mm-dd', DataFinalPeriodo) + '" AND ' +
                          '  PGM_SOURCE IN (' + TPagarMeFuncoes.fRetStrToSQLIn(RetornaIDsEmpresaConciliacao, ',') + ') ' +
                          'GROUP BY PGM_ID_TRF';
    LConsulta.Open;

    while not LConsulta.Eof Do
    Begin
      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LRegistroRelatorio.ValorBruto   := TPagarMeFuncoes.fFormataFloat(Abs(LConsulta.FieldByName('PGM_VALTRF').AsFloat) +
                                                                        LConsulta.FieldByName('PGM_TAXTRF').AsFloat, 2);
      LRegistroRelatorio.ValorLiquido := TPagarMeFuncoes.fFormataFloat(Abs(LConsulta.FieldByName('PGM_VALTRF').AsFloat) +
                                                                        LConsulta.FieldByName('PGM_TAXTRF').AsFloat, 2);

      LRegistroRelatorio.Descricao := 'TRANSFERÊNCIAS';
      LRegistroRelatorio.TipoDoRegistro := 'TRANSFERÊNCIA';
      LRegistroRelatorio.TipoCartao := 'TRANSFERÊNCIAS';
      LRegistroRelatorio.DescricaoAjuste := 'TRANSFERÊNCIA';

      LRegistroRelatorio.CodigoEmpresa := LConsulta.FieldByName('EMPRESA').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := LConsulta.FieldByName('PGM_RECEBE').AsString;
      LRegistroRelatorio.NumeroNSU := LConsulta.FieldByName('PGM_ID_TRF').AsString;
      LRegistroRelatorio.NumeroCartao := '0';
      LRegistroRelatorio.Parcela := '01';
      LRegistroRelatorio.TotalParcelas := '01';
      LRegistroRelatorio.CodigoAutorizacao := LConsulta.FieldByName('PGM_ID_TRF').AsString;

      LRegistroRelatorio.DataVenda := LConsulta.FieldByName('PGM_DTATRF').AsDateTime;
      LRegistroRelatorio.DataPagamento := LConsulta.FieldByName('PGM_DTATRF').AsDateTime;

      LRegistroRelatorio.RegistroTransferencia := 'S';
      LRegistroRelatorio.PortadorTransferencia := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPortadorTransferencia, LConsulta.FieldByName('EMPRESA').AsString);
      LRegistroRelatorio.PlanoContasTransferenciaCredito := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPlanoDeContasTransferencia, LConsulta.FieldByName('EMPRESA').AsString);
      LRegistroRelatorio.CentroCustosTransferencia := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgCentroDeCustosTransferencia, LConsulta.FieldByName('EMPRESA').AsString);
      LRegistroRelatorio.PlanoContasTransferenciaDebito := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPlanoDeContasTransferenciaLancDeb, LConsulta.FieldByName('EMPRESA').AsString);

      LRegistroRelatorio.PortadorCredito := LRegistroRelatorio.PortadorTransferencia;
      LRegistroRelatorio.PortadorDebito := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPortadorAjustes, LConsulta.FieldByName('EMPRESA').AsString);

      If LRegistroRelatorio.PlanoContasTransferenciaDebito.IsEmpty Then
        LRegistroRelatorio.PlanoContasTransferenciaDebito := LConsulta.FieldByName('PLANODECONTAS').AsString;

      LRegistroRelatorio.Conciliado := LConsulta.FieldByName('PGM_CONCIL').AsInteger;
      LRegistroRelatorio.NomeArquivo := '';

      LRegistroRelatorio.NomeRecebedor := RetornaNomeRecebedor(LRegistroRelatorio.CodigoEstabelecimento,
                                                               LConsulta.FieldByName('RECEBEDORES').AsString);

      LRegistroRelatorio.RegistroIncompleto := 'N';
      If Not LRegistroRelatorio.PortadorTransferencia.IsEmpty Then
      Begin
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, False, LConsulta);

        cdsBaiCar.Edit;
        cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString  := fRetornaChaveConciliacao(LConsulta);
        cdsBaiCar.Post;
      End;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      LConsulta.Next;
    End;
  Finally
    TPagarMeFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

function TConciliacaoPagarMeRecebiveis.fGetTipoDeOperacao(ACodigoModalidade: String;
  ATotalParcelas: Integer): String;
begin
  Result := '';
  If (ACodigoModalidade = 'debit_card') Then
    Result := 'DÉBITO'
  Else If (ACodigoModalidade = 'pix') Then
    Result := 'PIX'
  Else If (ACodigoModalidade = 'boleto') Then
    Result := 'BOLETO'
  Else If (ACodigoModalidade = 'credit_card')Then
    Result := TPagarMeFuncoes.IIF(ATotalParcelas > 1, 'CRÉDITO PARCELADO', 'CRÉDITO ROTATIVO')
  Else If (ACodigoModalidade = 'ANT')  Then
    Result := 'ANTECIPAÇÃO';
end;

constructor TConciliacaoPagarMeRecebiveis.Create;
begin
  FCdsRegistrosPagamento := Nil;
  FCdsRegistrosAjuste := Nil;
  FCdsPedidosComMaisDeUmCartao := Nil;
  FCdsVendasCanceladas := Nil;

  inherited;
end;

destructor TConciliacaoPagarMeRecebiveis.Destroy;
begin
  TPagarMeFuncoes.FreeAndNilDatasets(FCdsRegistrosPagamento);
  TPagarMeFuncoes.FreeAndNilDatasets(FCdsRegistrosAjuste);
  TPagarMeFuncoes.FreeAndNilDatasets(FCdsPedidosComMaisDeUmCartao);
  TPagarMeFuncoes.FreeAndNilDatasets(FCdsVendasCanceladas);
  inherited;
end;

function TConciliacaoPagarMeRecebiveis.fConciliaCartoes(prgStatus: TcxProgressBar): Boolean;
begin
  Result := fConciliaPagarMe(prgStatus);
end;

function TConciliacaoPagarMeRecebiveis.fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar) : Boolean;
  Var
    LParcelaRegistro,
    LNumeroNSU,
    LCodigoEmpresa,
    LNumPok,
    LCodigoAutorizacao,
    LTipoOperacao,
    LDivergenciaCartao,
    LDataImportacao,
    LChaveConciliacao: String;

    LRegistroRelatorio: TItensRelatorioCartoes;

    blnBusca: Boolean;

    LValorBruto,
    LValorLiquido: Double;
begin
  Result := False;
  cdsBaiCar.Filter := 'MCA_AJUSTE = ''N'' AND REGISTROTRANSFERENCIA=''N''';
  cdsBaiCar.Filtered := True;
  try
    Try
      pgbStatus.Position := 0;
      pgbStatus.Properties.Max := FCdsRegistrosPagamento.RecordCount;

      FCdsRegistrosPagamento.First;
      While Not FCdsRegistrosPagamento.Eof Do
      Begin
        TPagarMeFuncoes.pStepStatusGravacao(pgbStatus);

        FTextoInconsistencia := '';
        LDivergenciaCartao := '';

        LRegistroRelatorio := TItensRelatorioCartoes.Create;

        LDataImportacao := FormatDateTime('dd/mm/yyyy', FCdsRegistrosPagamento.FieldByName('PGM_DTAIMP').AsDateTime);

        LTipoOperacao := fGetTipoDeOperacao(RetornaTipoPagamento,
                                            FCdsRegistrosPagamento.FieldByName('PGM_TOTPAR').AsInteger);

        LNumPok := FCdsRegistrosPagamento.FieldByName('PGM_NUMPOK').AsString;

        LNumeroNSU :=  TPagarMeFuncoes.IIF(TPagarMeFuncoes.fEmptyStr(FCdsRegistrosPagamento.FieldByName('PGM_NUMNSU').AsString),
                                           TPagarMeFuncoes.fStrZero(LNumPok, 14),
                                           FCdsRegistrosPagamento.FieldByName('PGM_NUMNSU').AsString);

        LParcelaRegistro := Parcela(LNumeroNSU, FCdsRegistrosPagamento.FieldByName('PGM_NUMPAR').AsInteger);

        LCodigoAutorizacao := TPagarMeFuncoes.IIF(TPagarMeFuncoes.fEmptyStr(FCdsRegistrosPagamento.FieldByName('PGM_CODAUT').AsString),
                                                  TPagarMeFuncoes.fStrZero(LNumPok, 6),
                                                  TPagarMeFuncoes.fStrZero(FCdsRegistrosPagamento.FieldByName('PGM_CODAUT').AsString, 6));

        LCodigoEmpresa := FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString;

        LValorBruto := FCdsRegistrosPagamento.FieldByName('VALBRU').AsFloat;
        LValorLiquido := FCdsRegistrosPagamento.FieldByName('VALPAG').AsFloat;

        blnBusca := fBuscaCartaoPagarMe;
        If blnBusca Then
        Begin
          cdsBaiCar.Edit;
          cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat := FCdsRegistrosPagamento.FieldByName('VALTAX').AsFloat;
          cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat := FCdsRegistrosPagamento.FieldByName('PGM_TAXANT').AsFloat;
          cdsBaiCar.Post;

          LChaveConciliacao := 'PGM_' + LCodigoAutorizacao + '_' +
                                LNumeroNSU + '_' +
                                LParcelaRegistro + '_' +
                                cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                                FormatDateTime('yyyy-mm-dd', FCdsRegistrosPagamento.FieldByName('PGM_DTAPAG').Value);

          MarcarCartaoEncontradoAPI(LValorBruto,
                                    LValorLiquido,
                                    RetornaTipoPagamento.Equals('ANT'),
                                    LRegistroRelatorio,
                                    LChaveConciliacao,
                                    FCdsRegistrosPagamento,
                                    FCdsRegistrosPagamento.FieldByName('PGM_TAXANT').AsFloat);
        End
        else
        begin
          //verifica se está cadastrado ou já foi baixado no período
          cdsBaixad.First;
          blnBusca := fBuscaCartaoBaixadoPagarMe;

          FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';
          If blnBusca Then
          Begin
            FTextoInconsistencia := 'Cartão já foi baixado';
            LRegistroRelatorio.InconsistenciaConciliada := 'S';
            LRegistroRelatorio.Conciliado := 1;
            LRegistroRelatorio.AutoIncremMovCar := cdsBaixad.FieldByName('AUTOINCREM').AsString;
          End;
        end;

        //Grava inconsistência se houver
        FTextoInconsistencia := TPagarMeFuncoes.IIF(TPagarMeFuncoes.fEmptyStr(LDivergenciaCartao),FTextoInconsistencia,LDivergenciaCartao);

        if (not blnBusca) and
           FTextoInconsistencia.Equals('Registro do arquivo não encontrado nos lançamentos do sistema') then
        begin
          if GerarVendaNaoEncontrada then
          Begin
            FreeAndNil(LRegistroRelatorio);
            FCdsRegistrosPagamento.Next;
            Continue;
          End;

          if GerarAjusteDeVendaCancelada or GerarAjusteVendasPeloSite then
          Begin
            FreeAndNil(LRegistroRelatorio);
            FTextoInconsistencia := '';
            FCdsRegistrosPagamento.Next;
            Continue;
          End;
        end;

        {Gerando registro do relatório}
        FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
        If Not FTextoInconsistencia.IsEmpty Then
        Begin
          LRegistroRelatorio.Descricao := FTextoInconsistencia;
          If Not LRegistroRelatorio.InconsistenciaConciliada.Equals('S') Then
            LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
        End;
        LRegistroRelatorio.NomeArquivo := '[Pagar.Me] - Data de Importação: ' + LDataImportacao;
        LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosPagamento.FieldByName('PGM_RECEBE').AsString;
        LRegistroRelatorio.CodigoEmpresa := FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString;
        LRegistroRelatorio.NumeroNSU := LNumeroNSU;
        LRegistroRelatorio.CodigoAutorizacao := LCodigoAutorizacao;
        LRegistroRelatorio.ResumoVenda := FCdsRegistrosPagamento.FieldByName('PGM_ORDINT').AsString;
        LRegistroRelatorio.NumeroCartao := RetornoNumeroDoCartao;

        LRegistroRelatorio.TipoCartao := LTipoOperacao;

        LRegistroRelatorio.Parcela := TPagarMeFuncoes.fStrZero(FCdsRegistrosPagamento.FieldByName('PGM_NUMPAR').AsString, 2);
        LRegistroRelatorio.TotalParcelas := TPagarMeFuncoes.fStrZero(FCdsRegistrosPagamento.FieldByName('PGM_TOTPAR').AsString, 2);

        LRegistroRelatorio.DataPagamento := FCdsRegistrosPagamento.FieldByName('PGM_DTAPAG').Value;
        LRegistroRelatorio.DataVenda := TPagarMeFuncoes.IIF(Not FCdsRegistrosPagamento.FieldByName('PGM_DTACAD').IsNull,
                                                            FCdsRegistrosPagamento.FieldByName('PGM_DTACAD').Value,
                                                            FCdsRegistrosPagamento.FieldByName('PGM_DTAPAG').Value);
        LRegistroRelatorio.DataVencimento := FCdsRegistrosPagamento.FieldByName('PGM_DTAVEN').Value;

        LRegistroRelatorio.ValorBruto := LValorBruto;

        LRegistroRelatorio.ValorLiquido := LValorLiquido;
        LRegistroRelatorio.ValorTaxas := FCdsRegistrosPagamento.FieldByName('VALTAX').AsFloat;
        If FCdsRegistrosPagamento.FieldByName('PGM_TAXANT').AsFloat <> 0 Then
          LRegistroRelatorio.ValorTaxas := LRegistroRelatorio.ValorTaxas +
                                           Abs(FCdsRegistrosPagamento.FieldByName('PGM_TAXANT').AsFloat);
        LRegistroRelatorio.ValorFrete := 0.00;
        LRegistroRelatorio.ValorAjustes := 0.00;
        LRegistroRelatorio.ValorCupom := 0.00;

        LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

        LRegistroRelatorio.NomeRecebedor := RetornaNomeRecebedor(LRegistroRelatorio.CodigoEstabelecimento,
                                                                 FCdsRegistrosPagamento.FieldByName('RECEBEDORES').AsString);

        FListaRegistrosRelatorio.Add(LRegistroRelatorio);

        FCdsRegistrosPagamento.Next;
      End;

      Result := True;

    Except
      Raise;
    End;
  finally
    cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
    cdsBaiCar.Filtered := True;
  end;

end;

function TConciliacaoPagarMeRecebiveis.GerarAjusteVendasPeloSite: boolean;
begin
  {
   Vendas realizadas diretamente pelo site da PAGAR.ME devem ser consideradas como
   cancelamento/ajuste, porque o cartão não é importado para MOVCAR.
  }
  Result := False;
  if not FCdsRegistrosPagamento.FieldByName('PGM_ORIGEM').AsString.Equals('site') then
    Exit;

  GerarCancelamentoAjusteDoPagamento('Venda pelo site');
  Result := True;
end;

function TConciliacaoPagarMeRecebiveis.GerarAjusteDeVendaCancelada: Boolean;
var
  LNsu: String;
  LEncontrou: Boolean;
begin
  Result := False;
  if not (
          Assigned(FCdsVendasCanceladas) and
          (FCdsVendasCanceladas.RecordCount > 0)
         ) then
    Exit;

  LNsu := FCdsRegistrosPagamento.FieldByName('PGM_NUMNSU').AsString;

  if LNsu.Trim.IsEmpty then Exit;

  LEncontrou := FCdsVendasCanceladas.Locate('NUMNSU;AJUSTE_GERADO', VarArrayOf([UpperCase(LNsu), 'N']),[]);

  if not LEncontrou then Exit;

  GerarCancelamentoAjusteDoPagamento('Venda cancelada');
  FCdsVendasCanceladas.Edit;
  FCdsVendasCanceladas.FieldByName('AJUSTE_GERADO').AsString := 'S';
  FCdsVendasCanceladas.Post;
  Result := True;
end;


procedure TConciliacaoPagarMeRecebiveis.GerarCancelamentoAjusteDoPagamento(ADescricaoAjuste: String);
var
  LCodigoEmpresa: String;
  LValorBruto,
  LValorLiquido: Double;

  LRegistroRelatorio: TItensRelatorioCartoes;
begin
  LRegistroRelatorio := TItensRelatorioCartoes.Create;

  Try
    LCodigoEmpresa := FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString;
    LValorBruto    := FCdsRegistrosPagamento.FieldByName('VALBRU').Value;
    LValorLiquido  := FCdsRegistrosPagamento.FieldByName('VALPAG').Value;

    {Gerando registro do relatório}
    LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
    LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
    LRegistroRelatorio.DescricaoAjuste := ADescricaoAjuste;
    LRegistroRelatorio.NomeArquivo := '';
    LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosPagamento.FieldByName('PGM_RECEBE').AsString;
    LRegistroRelatorio.CodigoEmpresa := LCodigoEmpresa;
    LRegistroRelatorio.NumeroNSU := TPagarMeFuncoes.fStrZero(Trim(RightStr(FCdsRegistrosPagamento.FieldByName('PGM_NUMNSU').AsString, 14)), 14);
    LRegistroRelatorio.CodigoAutorizacao := TPagarMeFuncoes.fStrZero(FCdsRegistrosPagamento.FieldByName('PGM_CODAUT').AsString, 6);
    LRegistroRelatorio.ResumoVenda := FCdsRegistrosPagamento.FieldByName('PGM_TIPTRF').AsString;
    LRegistroRelatorio.NumeroCartao := FCdsRegistrosPagamento.FieldByName('PGM_NUMCAR').AsString;

    LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';

    LRegistroRelatorio.Parcela := TPagarMeFuncoes.fStrZero(FCdsRegistrosPagamento.FieldByName('PGM_NUMPAR').AsString, 2);
    LRegistroRelatorio.TotalParcelas := TPagarMeFuncoes.fStrZero(FCdsRegistrosPagamento.FieldByName('PGM_TOTPAR').AsString, 2);
    If LRegistroRelatorio.TotalParcelas.IsEmpty Then
      LRegistroRelatorio.TotalParcelas := LRegistroRelatorio.Parcela;

    LRegistroRelatorio.DataPagamento := FCdsRegistrosPagamento.FieldByName('PGM_DTAPAG').AsDateTime;
    LRegistroRelatorio.DataVenda := TPagarMeFuncoes.IIF(Not FCdsRegistrosPagamento.FieldByName('PGM_DTACAD').IsNull,
                                                        FCdsRegistrosPagamento.FieldByName('PGM_DTACAD').AsDateTime,
                                                        FCdsRegistrosPagamento.FieldByName('PGM_DTAPAG').AsDateTime);
    LRegistroRelatorio.DataVencimento := FCdsRegistrosPagamento.FieldByName('PGM_DTAVEN').AsDateTime;

    LRegistroRelatorio.ValorBruto := LValorBruto;
    LRegistroRelatorio.ValorLiquido := LValorLiquido;

    LRegistroRelatorio.ValorTaxas := 0;
    LRegistroRelatorio.ValorFrete := 0;
    LRegistroRelatorio.ValorAjustes := 0;
    LRegistroRelatorio.ValorCupom := 0;

    LRegistroRelatorio.DescricaoBandeira := 'DIVERSAS';

    LRegistroRelatorio.Conciliado := FCdsRegistrosPagamento.FieldByName('PGM_CONCIL').AsInteger;

    LRegistroRelatorio.NomeRecebedor := RetornaNomeRecebedor(LRegistroRelatorio.CodigoEstabelecimento,
                                                             FCdsRegistrosPagamento.FieldByName('RECEBEDORES').AsString);

    GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, FCdsRegistrosPagamento);
  Except
    FreeAndNil(LRegistroRelatorio);
    Raise;
  End;
  FListaRegistrosRelatorio.Add(LRegistroRelatorio);
end;

function TConciliacaoPagarMeRecebiveis.GerarVendaNaoEncontrada: Boolean;
var
  LRegistroRelatorio: TItensRelatorioCartoes;
  LCodigoEmpresa: String;
  LValorBruto,
  LValorLiquido: Double;
begin
  Result := False;

  if FCdsRegistrosPagamento.FieldByName('PGM_TIPREC').AsString <> 'credit' then
    Exit;

  if Assigned(FCdsVendasCanceladas) and
     (FCdsVendasCanceladas.RecordCount > 0) then
  begin
    if FCdsVendasCanceladas.Locate('NUMNSU;AJUSTE_GERADO',
       VarArrayOf([UpperCase(FCdsRegistrosPagamento.FieldByName('PGM_NUMNSU').AsString), 'N']),
       []) then
      Exit;
  end;

  LRegistroRelatorio := TItensRelatorioCartoes.Create;

  try
    LCodigoEmpresa := FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString;
    LValorBruto    := FCdsRegistrosPagamento.FieldByName('VALBRU').Value;
    LValorLiquido  := FCdsRegistrosPagamento.FieldByName('VALPAG').Value;

    LRegistroRelatorio.TipoDoRegistro   := 'INCONSISTENCIA';
    LRegistroRelatorio.Descricao        := 'Venda não encontrada';
    LRegistroRelatorio.DescricaoAjuste  := 'Venda não encontrada na movimentação de cartões';
    LRegistroRelatorio.NomeArquivo      := '';
    LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosPagamento.FieldByName('PGM_RECEBE').AsString;
    LRegistroRelatorio.CodigoEmpresa    := LCodigoEmpresa;
    LRegistroRelatorio.NumeroNSU        := TPagarMeFuncoes.fStrZero(Trim(RightStr(FCdsRegistrosPagamento.FieldByName('PGM_NUMNSU').AsString, 14)), 14);
    LRegistroRelatorio.CodigoAutorizacao := TPagarMeFuncoes.fStrZero(FCdsRegistrosPagamento.FieldByName('PGM_CODAUT').AsString, 6);
    LRegistroRelatorio.ResumoVenda      := FCdsRegistrosPagamento.FieldByName('PGM_ORDINT').AsString;
    LRegistroRelatorio.NumeroCartao     := FCdsRegistrosPagamento.FieldByName('PGM_NUMCAR').AsString;
    LRegistroRelatorio.TipoCartao       := 'VENDA NÃO ENCONTRADA';
    LRegistroRelatorio.Parcela          := TPagarMeFuncoes.fStrZero(FCdsRegistrosPagamento.FieldByName('PGM_NUMPAR').AsString, 2);
    LRegistroRelatorio.TotalParcelas    := TPagarMeFuncoes.fStrZero(FCdsRegistrosPagamento.FieldByName('PGM_TOTPAR').AsString, 2);
    If LRegistroRelatorio.TotalParcelas.IsEmpty Then
      LRegistroRelatorio.TotalParcelas  := LRegistroRelatorio.Parcela;
    LRegistroRelatorio.DataPagamento    := FCdsRegistrosPagamento.FieldByName('PGM_DTAPAG').AsDateTime;
    LRegistroRelatorio.DataVenda        := TPagarMeFuncoes.IIF(Not FCdsRegistrosPagamento.FieldByName('PGM_DTACAD').IsNull,
                                                               FCdsRegistrosPagamento.FieldByName('PGM_DTACAD').AsDateTime,
                                                               FCdsRegistrosPagamento.FieldByName('PGM_DTAPAG').AsDateTime);
    LRegistroRelatorio.DataVencimento   := FCdsRegistrosPagamento.FieldByName('PGM_DTAVEN').AsDateTime;
    LRegistroRelatorio.ValorBruto       := LValorBruto;
    LRegistroRelatorio.ValorLiquido     := LValorLiquido;
    LRegistroRelatorio.ValorTaxas       := TPagarMeFuncoes.fFormataFloat(LValorBruto - LValorLiquido, 2);
    LRegistroRelatorio.ValorFrete       := 0;
    LRegistroRelatorio.ValorAjustes     := 0;
    LRegistroRelatorio.ValorCupom       := 0;
    LRegistroRelatorio.DescricaoBandeira := 'DIVERSAS';
    LRegistroRelatorio.Conciliado       := 0;
    LRegistroRelatorio.NomeRecebedor    := RetornaNomeRecebedor(
                                            LRegistroRelatorio.CodigoEstabelecimento,
                                            FCdsRegistrosPagamento.FieldByName('RECEBEDORES').AsString);
  Except
    On E: Exception Do
    Begin
      FreeAndNil(LRegistroRelatorio);
      Raise;
    End;
  end;

  PossuiInconsistencia := True;
  FListaRegistrosRelatorio.Add(LRegistroRelatorio);

  Result := True;
end;

function TConciliacaoPagarMeRecebiveis.fProcessaRegistrosAjuste(pgbStatus: TcxProgressBar): Boolean;
  Var
    LRegistroRelatorio: TItensRelatorioCartoes;

    LValorBruto,
    LValorLiquido: Double;
    LTaxaCancelamentoBoleto: Boolean;
begin
  Result := True;
  Try
    FCdsRegistrosAjuste.First;
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := FCdsRegistrosAjuste.RecordCount;

    While Not FCdsRegistrosAjuste.Eof Do
    Begin
      TPagarMeFuncoes.pStepStatusGravacao(pgbStatus);

      LTaxaCancelamentoBoleto := Concat(FCdsRegistrosAjuste.FieldByName('PGM_TIPREC').AsString,
                                        FCdsRegistrosAjuste.FieldByName('PGM_TIPTRF').AsString).Equals('refundboleto');

      LValorBruto   := FCdsRegistrosAjuste.FieldByName('VALBRU').AsFloat;
      LValorLiquido := FCdsRegistrosAjuste.FieldByName('VALPAG').AsFloat;
      if LTaxaCancelamentoBoleto then
      begin
        LValorBruto   := - FCdsRegistrosAjuste.FieldByName('VALTAX').AsFloat;
        LValorLiquido := - FCdsRegistrosAjuste.FieldByName('VALTAX').AsFloat;
      end;

      If FormatFloat(',0.00', LValorLiquido).Equals('0,00') Then
      Begin
        FCdsRegistrosAjuste.Next;
        Continue;
      End;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      {Gerando registro do relatório}
      LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
      LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
      LRegistroRelatorio.DescricaoAjuste := RetornaDescricaoDoAjuste(FCdsRegistrosAjuste.FieldByName('PGM_TIPREC').AsString);
      LRegistroRelatorio.NomeArquivo := '';
      LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosAjuste.FieldByName('PGM_RECEBE').AsString;
      LRegistroRelatorio.CodigoEmpresa := FCdsRegistrosAjuste.FieldByName('EMP_CODEMP').AsString;
      LRegistroRelatorio.NumeroNSU := TPagarMeFuncoes.fStrZero(Trim(RightStr(FCdsRegistrosAjuste.FieldByName('PGM_NUMNSU').AsString, 14)), 14);
      LRegistroRelatorio.CodigoAutorizacao := TPagarMeFuncoes.fStrZero(FCdsRegistrosAjuste.FieldByName('PGM_CODAUT').AsString, 6);
      LRegistroRelatorio.ResumoVenda := FCdsRegistrosAjuste.FieldByName('PGM_TIPTRF').AsString;
      LRegistroRelatorio.NumeroCartao := FCdsRegistrosAjuste.FieldByName('PGM_NUMCAR').AsString;

      LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';

      LRegistroRelatorio.Parcela := FCdsRegistrosAjuste.FieldByName('PGM_NUMPAR').AsString;
      LRegistroRelatorio.TotalParcelas := FCdsRegistrosAjuste.FieldByName('PGM_TOTPAR').AsString;
      If LRegistroRelatorio.TotalParcelas.IsEmpty Then
        LRegistroRelatorio.TotalParcelas := LRegistroRelatorio.Parcela;

      LRegistroRelatorio.DataPagamento := FCdsRegistrosAjuste.FieldByName('PGM_DTAPAG').AsDateTime;
      LRegistroRelatorio.DataVenda := TPagarMeFuncoes.IIF(Not FCdsRegistrosAjuste.FieldByName('PGM_DTACAD').IsNull,
                                                          FCdsRegistrosAjuste.FieldByName('PGM_DTACAD').AsDateTime,
                                                          FCdsRegistrosAjuste.FieldByName('PGM_DTAPAG').AsDateTime);
      LRegistroRelatorio.DataVencimento := FCdsRegistrosAjuste.FieldByName('PGM_DTAVEN').AsDateTime;

      LRegistroRelatorio.ValorBruto := LValorBruto;
      LRegistroRelatorio.ValorLiquido := LValorLiquido;

      LRegistroRelatorio.ValorTaxas := 0;
      LRegistroRelatorio.ValorFrete := 0;
      LRegistroRelatorio.ValorAjustes := 0;
      LRegistroRelatorio.ValorCupom := 0;

      LRegistroRelatorio.NomeRecebedor := RetornaNomeRecebedor(LRegistroRelatorio.CodigoEstabelecimento,
                                                               FCdsRegistrosAjuste.FieldByName('RECEBEDORES').AsString);

      LRegistroRelatorio.DescricaoBandeira := 'DIVERSAS';

      LRegistroRelatorio.Conciliado := FCdsRegistrosAjuste.FieldByName('PGM_CONCIL').AsInteger;

      GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, FCdsRegistrosAjuste);

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      FCdsRegistrosAjuste.Next;
    End;
  Except
    Raise;
  End;
end;

procedure TConciliacaoPagarMeRecebiveis.pCriaDataSets;
  Var
    LQueryPagamento,
    LQueryAjustes: TUniQuery;
    LStatusFiltro: String;
begin
  LQueryPagamento := Nil;
  LQueryAjustes := Nil;
  Try
    LQueryPagamento := VS_FuncoesExternas.fICriaQuery;
    LQueryAjustes := VS_FuncoesExternas.fICriaQuery;
    //CONCILIAÇÃO FINANCEIRA
    LQueryPagamento.SQL.Text := RetornaConsultaConciliacao +
                               'WHERE RE.PGM_TIPREC = "credit"                     ' +
                               '  AND RE.PGM_STATUS = "paid"                       ' +
                               '  AND RE.PGM_DTAPAG BETWEEN :DTAINI AND :DTAFIN    ' +
                               '  AND RE.PGM_RECEBE IN (' + TPagarMeFuncoes.fRetStrToSQLIn(RetornaIDsEmpresaConciliacao, ',') + ') ' +
                               'GROUP BY RE.PGM_ID_REC ' +
                               'ORDER BY RE.PGM_DTAPAG, RE.PGM_ID_COB, RE.PGM_NUMPAR';
      If FModeloAtualizado Then
        LStatusFiltro := '"success", "available"'
      Else
        LStatusFiltro := '"available"';

    LQueryPagamento.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', DataInicioPeriodo);
    LQueryPagamento.ParamByName('DTAFIN').AsString := FormatDateTime('yyyy-mm-dd', DataFinalPeriodo);

    LQueryPagamento.Open;
    FCdsRegistrosPagamento := TPagarMeFuncoes.CriarClientDataSet(LQueryPagamento);
    Application.ProcessMessages;

    //AJUSTES/CANCELAMENTO
    LQueryAjustes.Close;
    LQueryAjustes.SQL.Text := RetornaConsultaConciliacao +
                          'WHERE RE.PGM_TIPREC IN (                 ' +
                          '          "refund",                      ' +
                          '          "chargeback",                  ' +
                          '          "refund_reversal",             ' +
                          '          "chargeback_refund"            ' +
                          '        )                                ' +
                          '  AND RE.PGM_STATUS = "paid"             ' +
                          '  AND RE.PGM_DTAPAG BETWEEN :DTAINI      ' +
                          '  AND :DTAFIN                            ' +
                          '  AND RE.PGM_RECEBE IN (' + TPagarMeFuncoes.fRetStrToSQLIn(RetornaIDsEmpresaConciliacao, ',') + ') ' +
                          ' GROUP BY RE.PGM_ID_REC                  ' +
                          'UNION                                    ' +
                          'SELECT                                   ' +
                          '  PGM_DTAIMP,                            ' +
                          '  PGM_TIPREG,                            ' +
                          '  "1" AS PGM_TOTPAR,                     ' +
                          '  "1" AS PGM_NUMPAR,                     ' +
                          '  "" AS PGM_NUMNSU,                      ' +
                          '  "" AS PGM_CODAUT,                      ' +
                          '  "" AS PGM_NUMPOK,                      ' +
                          '  PGM_DTATRF AS PGM_DTACAD,              ' +
                          '  IF(PGM_TIPREG = "transfer", -PGM_TAXTRF, PGM_VALTRF) AS VALBRU, ' +
                          '  IF(PGM_TIPREG = "transfer", 0.00, PGM_TAXTRF) AS VALTAX, ' +
                          '  IF(PGM_TIPREG = "transfer", -PGM_TAXTRF, (PGM_VALTRF - PGM_TAXTRF)) AS VALPAG, ' +
                          '  IF(PGM_TIPREG = "transfer", 0.00, PGM_TAXTRF) AS PGM_TAXPAR, ' +
                          '  0.00 AS PGM_TAXANT,                    ' +
                          '  0.00 AS PGM_TAXFRA,                    ' +
                          '  "" AS PGM_NUMCAR,                      ' +
                          '  PGM_ID_TRF AS PGM_ID_COB,              ' +
                          '  "" AS PGM_BANDEI,                      ' +
                          '  PGM_DTATRF AS PGM_DTAVEN,              ' +
                          '  PGM_DTATRF AS PGM_DTAPAG,              ' +
                          '  PGM_ID_TRF AS PGM_ID_REC,              ' +
                          '  PGM_KEYAPI AS PGM_KEYAPI,              ' +
                          '  PGM_CONCIL AS PGM_CONCIL,              ' +
                          '  CAST("" AS CHAR(60)) AS PGM_ORDINT,    ' +
                          '  CAST("" AS CHAR(60)) AS NSU_ORIGINAL,  ' +
                          '  CAST("" AS CHAR(60)) AS PGM_ORD_ID,    ' +
                          '  CAST("" AS CHAR(60)) AS PGM_CUS_ID,    ' +
                          '  PGM_TARGET AS PGM_METPAG,              ' +
                          '  "" AS PGM_ORIGEM,                      ' +
                          '  PGM_TIPTRF AS PGM_TIPTRF,              ' +
                          '  PGM_SOURCE AS PGM_RECEBE,              ' +
                          '  SIS_VALCFG AS RECEBEDORES,             ' +
                          '  EMP_CODEMP,                            ' +
                          '  EMP_NOMEMP,                            ' +
                          '  "PGM_PMTRAN" AS NOME_TABELA            ' +
                          'FROM                                     ' +
                          '  PGM_PMTRAN                             ' +
                          '  LEFT JOIN CFGSIS                       ' +
                          '    ON SIS_CODCFG = "CFG_PGMREI"    AND  ' +
                          'SIS_CODEMP = "' + RetornaEmpresaFiltrada + '" AND ' +
                          '       IFNULL(SIS_VALCFG, "") <> "" AND  ' +
                          '       IFNULL(PGM_SOURCE, "") <> "" AND  ' +
                          '       LOCATE(PGM_SOURCE, SIS_VALCFG) > 0 ' +
                          '  LEFT JOIN CADEMP                       ' +
                          '    ON EMP_CODEMP = SIS_CODEMP           ' +
                          'WHERE                                    ' +
                          '  PGM_TIPREG IN ("refund","fee_collection","transfer") ' +
                          '  AND PGM_STATUS IN (' + LStatusFiltro + ') ' +
                          '  AND PGM_DTATRF BETWEEN :DTAINI AND :DTAFIN ' +
                          '  AND PGM_SOURCE IN (' + TPagarMeFuncoes.fRetStrToSQLIn(RetornaIDsEmpresaConciliacao, ',') + ') ' +
                          'GROUP BY PGM_ID_TRF                      ' +
                          'ORDER BY                                 ' +
                          '  PGM_DTAPAG,                            ' +
                          '  PGM_ID_COB,                            ' +
                          '  PGM_NUMPAR                             ';

    LQueryAjustes.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', DataInicioPeriodo);
    LQueryAjustes.ParamByName('DTAFIN').AsString := FormatDateTime('yyyy-mm-dd', DataFinalPeriodo);

    LQueryAjustes.Open;
    FCdsRegistrosAjuste := TPagarMeFuncoes.CriarClientDataSet(LQueryAjustes);
    Application.ProcessMessages;
  Finally
    TPagarMeFuncoes.FreeAndNilDatasets(LQueryPagamento);
    TPagarMeFuncoes.FreeAndNilDatasets(LQueryAjustes);
  End;
end;

procedure TConciliacaoPagarMeRecebiveis.pFiltraCartoesBaixadosPagarMe;
  Var
    strSQL   : String;
    qryBaixad: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT MCA_NUMCCD, MCA_PARCEL, MCA_DTAREC,  TRIM(LEADING "0" FROM MCA_NUMNSU) AS MCA_NUMNSU, ';
  strSQL := strSQL + ' MCA_NUMDUP, MCA_DTACUP, LEFT(RIGHT(MCA_NUMPOK,9),6) AS POKPGM, AUTOINCREM, MCA_CHACON, ';
  strSQL := strSQL + ' MCA_CODEMP, MCA_DTAVEN, MCA_EMPRCX, MCA_CHACON,MCA_VALSTA, ';
  strSQL := strSQL + ' MCA_NUMNSU AS NSU_ORIGINAL ';
  strSQL := strSQL + ' FROM MOVCAR                                ';
  strSQL := strSQL + ' WHERE ';

  If Not FCartoesPagarMe.isEMpty Then
    strSQL := strSQL + ' MCA_CODCAR IN (' + TPagarMeFuncoes.fRetStrToSQLIn(FCartoesPagarMe) + ') AND ';

  strSQL := strSQL + ' MCA_DTAREC IS NOT NULL ';

  strSQL := strSQL + ' AND (                                                   ' +
                     ' (TRIM(LEADING "0" FROM MCA_NUMNSU) IN (' + FListaDePedidos + ') AND         ' +
                     '     IFNULL(MCA_NUMNSU, "") <> "")                       ' +
                     ' OR (MCA_NUMCCD IN (' + FListaDePedidos + ') AND         ' +
                     '     IFNULL(MCA_NUMCCD, "") <> "")                       ' +
                     ' OR (LEFT(RIGHT(MCA_NUMPOK, 9), 6) IN (' + FListaDePedidos + ') AND ' +
                     '     IFNULL(MCA_NUMPOK, "") <> "")                       ' +
                     ')                                                        ';
  strSQL := strSQL + ' ORDER BY MCA_NUMNSU, MCA_PARCEL,MCA_CODEMP ';

  qryBaixad := Nil;
  Try
    qryBaixad := VS_FuncoesExternas.fICriaQuery;
    qryBaixad.SQL.Text := strSQL;
    qryBaixad.Open;
    cdsBaixad := TPagarMeFuncoes.CriarClientDataSet(qryBaixad);
    cdsBaixad.Open;

    cdsBaixad.IndexFieldNames := 'MCA_NUMNSU;MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_CODEMP';
  Finally
    TPagarMeFuncoes.FreeAndNilDatasets(qryBaixad);
  End;
end;

procedure TConciliacaoPagarMeRecebiveis.pFiltraCartoesPagarMe;
  Var
    strSQL: String;

    qryBaiCar: TUniQuery;
begin
  FCartoesPagarMe := VS_FuncoesExternas.fICfgSis('PGMCAR');

  FListaDePedidos := RetornaListaDePedidos;

  strSQL := TLibCartoesMovCar.fGetSQLCartoes(objConcil);

  If Not FCartoesPagarMe.IsEmpty Then
    strSQL := strSQL + ' AND MCA_CODCAR IN (' + TPagarMeFuncoes.fRetStrToSQLIn(FCartoesPagarMe) + ') ';

  strSQL := strSQL + ' AND (                                                            ' +
                     '    (TRIM(LEADING "0" FROM MCA_NUMNSU) IN (' + FListaDePedidos + ') AND  ' +
                     '     IFNULL(MCA_NUMNSU, "") <> "")                                ' +
                     ' OR (MCA_NUMCCD IN (' + FListaDePedidos + ') AND   ' +
                     '     IFNULL(MCA_NUMCCD, "") <> "")                                ' +
                     ' OR (LEFT(RIGHT(MCA_NUMPOK, 9), 6) IN (' + FListaDePedidos + ') ' +
                     '     AND IFNULL(MCA_NUMPOK, "") <> "")                            ' +
                     ')                                                                 ';

  strSQL := strSQL + ' ORDER BY MCA_NUMNSU,MCA_NUMCCD,MCA_CODEMP,PARDUP,MCA_DTACUP,MCA_NUMDUP) AS TMP ';

  qryBaiCar := Nil;
  Try
    qryBaiCar := VS_FuncoesExternas.fICriaQuery;
    qryBaiCar.SQL.Text := strSQL;
    qryBaiCar.Options.SetFieldsReadOnly := False;
    qryBaiCar.Open;

    cdsBaiCar := TPagarMeFuncoes.CriarClientDataSet(qryBaiCar);
    cdsBaiCar.IndexFieldNames := 'MCA_NUMNSU;MCA_NUMCCD;MCA_CODEMP;PARDUP;MCA_DTACUP;MCA_NUMDUP';
    cdsBaiCar.Open;
  Finally
    TPagarMeFuncoes.FreeAndNilDatasets(qryBaiCar);
  End;
End;

function TConciliacaoPagarMeRecebiveis.Parcela(ANumNsu: String; AParcela: Integer;
  AConverterParaLetra: Boolean = True): String;
var
  LSomatoriaParcelasCartoesAnteriores: Integer;
  LNsuCartaoAnterior: String;
  LEncontrou: Boolean;
begin
  Result := TPagarMeFuncoes.IIF(AConverterParaLetra,
                                TPagarMeFuncoes.fGetLetraAlfa(TPagarMeFuncoes.IIF(AParcela = 0, 1, AParcela)),
                                IntToStr(AParcela));

  if ANumNsu.Trim.IsEmpty then
    Exit;

  try
    if not ((Assigned(FCdsPedidosComMaisDeUmCartao)) and
            (FCdsPedidosComMaisDeUmCartao.RecordCount > 0)) then
      Exit;

    LEncontrou := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(ANumNsu),
                                      FCdsPedidosComMaisDeUmCartao.Locate('NUMNSU', VarArrayOf([UpperCase(ANumNsu)]),[]),
                                      False);

    if not LEncontrou then
      Exit;

    try
      FCdsPedidosComMaisDeUmCartao.Filter := 'NUMPOK=' + QuotedStr(FCdsPedidosComMaisDeUmCartao.FieldByName('NUMPOK').AsString);
      FCdsPedidosComMaisDeUmCartao.Filtered := True;
      FCdsPedidosComMaisDeUmCartao.First;
      LSomatoriaParcelasCartoesAnteriores := 0;
      LNsuCartaoAnterior := '';
      while not FCdsPedidosComMaisDeUmCartao.EOF do
      begin
        if FCdsPedidosComMaisDeUmCartao.FieldByName('NUMNSU').AsString.Equals(UpperCase(ANumNsu)) then
          break;

        if FCdsPedidosComMaisDeUmCartao.FieldByName('NUMNSU').AsString.Equals(LNsuCartaoAnterior) then
        begin
          FCdsPedidosComMaisDeUmCartao.Next;
          Continue;
        end;

        LSomatoriaParcelasCartoesAnteriores := LSomatoriaParcelasCartoesAnteriores +
                                               FCdsPedidosComMaisDeUmCartao.FieldByName('TOTPAR').AsInteger;

        LNsuCartaoAnterior := FCdsPedidosComMaisDeUmCartao.FieldByName('NUMNSU').AsString;

        FCdsPedidosComMaisDeUmCartao.Next;
      end;

      if LSomatoriaParcelasCartoesAnteriores > 0 then
        Result := TPagarMeFuncoes.IIF(AConverterParaLetra,
                                      TPagarMeFuncoes.fGetLetraAlfa(AParcela + LSomatoriaParcelasCartoesAnteriores),
                                      IntToStr(AParcela + LSomatoriaParcelasCartoesAnteriores));
    finally
      FCdsPedidosComMaisDeUmCartao.Filter := '';
      FCdsPedidosComMaisDeUmCartao.Filtered := False;
    end;
  except
    On E:Exception do
      raise Exception.Create('Problemas ao verificar se o nsu faz parte do pagamento de um pedido com mais de um cartão. ' + E.Message);
  end;
end;

function TConciliacaoPagarMeRecebiveis.fBuscaCartaoPagarMe: Boolean;
  Var
    LParcel : String;
    LNumNsu : String;
    LNumAut : String;
    LDtaCad, LDtaVen : TDateTime;
    LCodEmp : String;
    LNumPok : String;
    LintParcela: Integer;
    LValorParcela: String;
    LMetodoPagamento: String;

    LOrderInterna,
    LOrderId,
    LCustomerId,
    LNsuOriginal: String;
begin
  Result := False;

  Try
    LMetodoPagamento := FCdsRegistrosPagamento.FieldByName('PGM_METPAG').AsString;

    LNumPok  := FCdsRegistrosPagamento.FieldByName('PGM_NUMPOK').AsString;

    LNumAut := TPagarMeFuncoes.IIF(TPagarMeFuncoes.fEmptyStr(FCdsRegistrosPagamento.FieldByName('PGM_CODAUT').AsString) and
                                                                (not MatchStr(LMetodoPagamento, ['pix','boleto'])),
                                   TPagarMeFuncoes.IIF(LNumPok.IsEmpty, '', TPagarMeFuncoes.fStrZero(LNumPok,6)),
                                   FCdsRegistrosPagamento.FieldByName('PGM_CODAUT').AsString);

    LNumNsu := TPagarMeFuncoes.IIF(TPagarMeFuncoes.fEmptyStr(FCdsRegistrosPagamento.FieldByName('PGM_NUMNSU').AsString),
                                   TPagarMeFuncoes.IIF(LNumPok.IsEmpty, '', TPagarMeFuncoes.fStrZero(LNumPok,14)),
                                   FCdsRegistrosPagamento.FieldByName('PGM_NUMNSU').AsString);

    LOrderInterna := FCdsRegistrosPagamento.FieldByName('PGM_ORDINT').AsString;
    LOrderId := FCdsRegistrosPagamento.FieldByName('PGM_ORD_ID').AsString.ToUpperInvariant;

    LNsuOriginal := EmptyStr;
    If Not FCdsRegistrosPagamento.FieldByName('NSU_ORIGINAL').AsString.IsEmpty Then
      LNsuOriginal := TPagarMeFuncoes.fPadL(FCdsRegistrosPagamento.FieldByName('NSU_ORIGINAL').AsString, 14, '0');

    //Sim, a integração grava em alguns registros o CUSTOMER_ID como chave
    LCustomerId := FCdsRegistrosPagamento.FieldByName('PGM_CUS_ID').AsString.ToUpperInvariant;

    If ( (StrToIntDef(LeftStr(FCdsRegistrosPagamento.FieldByName('PGM_TOTPAR').AsString , 2), 0) > 26) and
          TryStrToInt( LeftStr(FCdsRegistrosPagamento.FieldByName('PGM_NUMPAR').AsString,2) , LintParcela)) Then
    Begin
      LParcel := Parcela(LNumNsu, FCdsRegistrosPagamento.FieldByName('PGM_NUMPAR').AsInteger, False);
    End
    Else
      LParcel := Parcela(LNumNsu, FCdsRegistrosPagamento.FieldByName('PGM_NUMPAR').AsInteger);

    LDtaCad := TPagarMeFuncoes.IIF(Not FCdsRegistrosPagamento.FieldByName('PGM_DTACAD').IsNull,
                                   FCdsRegistrosPagamento.FieldByName('PGM_DTACAD').Value,
                                   FCdsRegistrosPagamento.FieldByName('PGM_DTAVEN').Value);
    LDtaVen := FCdsRegistrosPagamento.FieldByName('PGM_DTAVEN').Value;
    LCodEmp := FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString;
    LValorParcela := FCdsRegistrosPagamento.FieldByName('VALBRU').AsString;

    if MatchStr(LMetodoPagamento, ['pix','boleto']) and
       (Not TPagarMeFuncoes.fEmptyStr(LCodEmp)) then
    begin
      if LNumAut.Trim.IsEmpty then
        LNumAut := LNumNsu;

      Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumPok),
                                    cdsBaiCar.Locate('POKPGM;PARDUP;MCA_VALSTA;MCA_EMPRCX;MCA_DTACUP', VarArrayOf([UpperCase(LNumPok),
                                                      LParcel, LValorParcela, LCodEmp, LDtaCad]),[]),
                                    False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumPok),
                                      cdsBaiCar.Locate('POKPGM;PARDUP;MCA_VALSTA;MCA_EMPRCX', VarArrayOf([UpperCase(LNumPok),
                                                        LParcel, LValorParcela, LCodEmp]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumNsu),
                                      cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_VALSTA;MCA_EMPRCX', VarArrayOf([UpperCase(LNumNsu),
                                                       LParcel, LValorParcela, LCodEmp]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumAut),
                                      cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_VALSTA;MCA_EMPRCX', VarArrayOf([UpperCase(LNumAut),
                                                       LParcel, LValorParcela, LCodEmp]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LOrderInterna),
                                      cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_VALSTA;MCA_EMPRCX', VarArrayOf([UpperCase(LOrderInterna),
                                                       LParcel, LValorParcela, LCodEmp]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LOrderInterna),
                                      cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_VALSTA;MCA_EMPRCX', VarArrayOf([UpperCase(LOrderInterna),
                                                       LParcel, LValorParcela, LCodEmp]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LCustomerId),
                                      cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_EMPRCX', VarArrayOf([UpperCase(LCustomerId),
                                                       LParcel, LCodEmp]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LOrderId),
                                      cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_EMPRCX', VarArrayOf([UpperCase(LOrderId),
                                                       LParcel, LCodEmp]),[]),
                                      False);
    end;


    If (Not TPagarMeFuncoes.fEmptyStr(LCodEmp)) Then
    Begin
      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumAut),
                                      cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(LNumAut),
                                                       LParcel, LDtaCad, LCodEmp]),[]),
                                      False);
      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumNsu),
                                      cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(LNumNsu),
                                                       LParcel, LDtaCad, LCodEmp]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LOrderInterna),
                                      cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(LOrderInterna),
                                                       LParcel, LDtaCad, LCodEmp]),[]),
                                      False);
      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LOrderInterna),
                                      cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(LOrderInterna),
                                                       LParcel, LDtaCad, LCodEmp]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LCustomerId),
                                      cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_EMPRCX', VarArrayOf([UpperCase(LCustomerId),
                                                       LParcel, LCodEmp]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LOrderId),
                                      cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_EMPRCX', VarArrayOf([UpperCase(LOrderId),
                                                       LParcel, LCodEmp]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LOrderInterna),
                                      cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_EMPRCX', VarArrayOf([UpperCase(LOrderInterna),
                                                       LParcel, LCodEmp]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNsuOriginal),
                                      cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_EMPRCX', VarArrayOf([UpperCase(LNsuOriginal),
                                                       LParcel, LCodEmp]),[]),
                                      False);
    End;

    If Not Result Then
    Begin
      Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumAut),
                                    cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_DTACUP', VarArrayOf([UpperCase(LNumAut),
                                                     LParcel, LDtaCad]),[]),
                                    False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumNsu),
                                      cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_DTACUP', VarArrayOf([UpperCase(LNumNsu),
                                                       LParcel, LDtaCad]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumPok),
                                      cdsBaiCar.Locate('POKPGM;PARDUP;MCA_DTACUP', VarArrayOf([UpperCase(LNumPok),
                                                       LParcel, LDtaCad]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumNsu),
                                      cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_DTAVEN;MCA_VALSTA', VarArrayOf([UpperCase(LNumNsu),
                                                       LParcel, LDtaVen, LValorParcela]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not MatchStr('', [LNumNsu,LNumAut]),
                                      cdsBaiCar.Locate('MCA_NUMNSU;MCA_NUMCCD;PARDUP;MCA_VALSTA', VarArrayOf([UpperCase(LNumNsu),
                                                       UpperCase(LNumAut), LParcel, LValorParcela]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not MatchStr('', [LNumNsu, LCodEmp]),
                                      cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_EMPRCX', VarArrayOf([UpperCase(LNumNsu),
                                                       LParcel, LCodEmp]),[]),
                                      False);
    End;
  Except
    Raise;
  End;

end;

function TConciliacaoPagarMeRecebiveis.fBuscaCartaoBaixadoPagarMe: Boolean;
  Var
    LParcel : String;
    LNumNsu : String;
    LNumAut : String;
    LDtaCad, LDtaVen : TDateTime;
    LCodEmp : String;
    LNumPok : String;
    LintParcela: Integer;
    LValorParcela: String;
    LMetodoPagamento: String;

    LOrderInterna,
    LOrderId,
    LCustomerId,
    LNsuOriginal: String;
begin
  Result := False;

  LMetodoPagamento := FCdsRegistrosPagamento.FieldByName('PGM_METPAG').AsString;

  LNumPok  := FCdsRegistrosPagamento.FieldByName('PGM_NUMPOK').AsString;

  LNumAut := TPagarMeFuncoes.IIF(TPagarMeFuncoes.fEmptyStr(FCdsRegistrosPagamento.FieldByName('PGM_CODAUT').AsString) and
                                                 (not MatchStr(LMetodoPagamento, ['pix','boleto'])),
                                 TPagarMeFuncoes.IIF( LNumPok.IsEmpty, '', TPagarMeFuncoes.fStrZero(LNumPok,6) ),
                                 FCdsRegistrosPagamento.FieldByName('PGM_CODAUT').AsString);

  LNumNsu := TPagarMeFuncoes.IIF(TPagarMeFuncoes.fEmptyStr(FCdsRegistrosPagamento.FieldByName('PGM_NUMNSU').AsString),
                                 TPagarMeFuncoes.IIF( LNumPok.IsEmpty, '', TPagarMeFuncoes.fStrZero(LNumPok,14) ),
                                 FCdsRegistrosPagamento.FieldByName('PGM_NUMNSU').AsString);

  LOrderInterna := FCdsRegistrosPagamento.FieldByName('PGM_ORDINT').AsString;
  LOrderId := FCdsRegistrosPagamento.FieldByName('PGM_ORD_ID').AsString.ToUpperInvariant;
  LCustomerId := FCdsRegistrosPagamento.FieldByName('PGM_CUS_ID').AsString.ToUpperInvariant;

  LNsuOriginal := EmptyStr;
  If Not FCdsRegistrosPagamento.FieldByName('NSU_ORIGINAL').AsString.IsEmpty Then
    LNsuOriginal := TPagarMeFuncoes.fPadL(FCdsRegistrosPagamento.FieldByName('NSU_ORIGINAL').AsString, 14, '0');

  If ( (StrToIntDef(LeftStr(FCdsRegistrosPagamento.FieldByName('PGM_TOTPAR').AsString , 2), 0) > 26) and
          TryStrToInt( LeftStr(FCdsRegistrosPagamento.FieldByName('PGM_NUMPAR').AsString,2) , LintParcela)) Then
  Begin
    LParcel := Parcela(LNumNsu, FCdsRegistrosPagamento.FieldByName('PGM_NUMPAR').AsInteger, False);
  End
  Else
    LParcel := Parcela(LNumNsu, FCdsRegistrosPagamento.FieldByName('PGM_NUMPAR').AsInteger);

  LDtaCad := TPagarMeFuncoes.IIF(Not FCdsRegistrosPagamento.FieldByName('PGM_DTACAD').IsNull,
                                   FCdsRegistrosPagamento.FieldByName('PGM_DTACAD').Value,
                                   FCdsRegistrosPagamento.FieldByName('PGM_DTAVEN').Value);
  LDtaVen := FCdsRegistrosPagamento.FieldByName('PGM_DTAVEN').Value;
  LCodEmp := FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString;

  LValorParcela := FCdsRegistrosPagamento.FieldByName('VALBRU').AsString;

  if MatchStr(LMetodoPagamento, ['pix','boleto']) and
     (Not TPagarMeFuncoes.fEmptyStr(LCodEmp)) then
  begin
    if LNumAut.Trim.IsEmpty then
      LNumAut := LNumNsu;

    Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumPok),
                                  cdsBaixad.Locate('POKPGM;MCA_PARCEL;MCA_VALSTA;MCA_EMPRCX;MCA_DTACUP', VarArrayOf([UpperCase(LNumPok),
                                                   LParcel, LValorParcela, LCodEmp, LDtaCad]),[]),
                                  False);
    If Not Result Then
      Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumPok),
                                    cdsBaixad.Locate('POKPGM;MCA_PARCEL;MCA_VALSTA;MCA_EMPRCX', VarArrayOf([UpperCase(LNumPok),
                                                     LParcel, LValorParcela, LCodEmp]),[]),
                                    False);

    If Not Result Then
      Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumNsu),
                                    cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL;MCA_VALSTA;MCA_EMPRCX', VarArrayOf([UpperCase(LNumNsu),
                                                     LParcel, LValorParcela, LCodEmp]),[]),
                                    False);

    If Not Result Then
      Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumAut),
                                    cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL;MCA_VALSTA;MCA_EMPRCX', VarArrayOf([UpperCase(LNumAut),
                                                     LParcel, LValorParcela, LCodEmp]),[]),
                                    False);
  end;


  If (Not TPagarMeFuncoes.fEmptyStr(LCodEmp)) Then
  Begin
    If Not Result Then
      Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumAut),
                                    cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(LNumAut),
                                                     LParcel, LDtaCad, LCodEmp]),[]),
                                    False);
    If Not Result Then
      Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumNsu),
                                    cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(LNumNsu),
                                                     LParcel, LDtaCad, LCodEmp]),[]),
                                    False);

    If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LOrderInterna),
                                      cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(LOrderInterna),
                                                       LParcel, LDtaCad, LCodEmp]),[]),
                                      False);
      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LOrderInterna),
                                      cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(LOrderInterna),
                                                       LParcel, LDtaCad, LCodEmp]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LCustomerId),
                                      cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL;MCA_EMPRCX', VarArrayOf([UpperCase(LCustomerId),
                                                       LParcel, LCodEmp]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LOrderId),
                                      cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL;MCA_EMPRCX', VarArrayOf([UpperCase(LOrderId),
                                                       LParcel, LCodEmp]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LOrderInterna),
                                      cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL;MCA_EMPRCX', VarArrayOf([UpperCase(LOrderInterna),
                                                       LParcel, LCodEmp]),[]),
                                      False);

      If Not Result Then
        Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNsuOriginal),
                                      cdsBaixad.Locate('NSU_ORIGINAL;MCA_PARCEL;MCA_EMPRCX', VarArrayOf([UpperCase(LNsuOriginal),
                                                       LParcel, LCodEmp]),[]),
                                      False);
  End;

  If Not Result Then
  Begin
    Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumAut),
                                  cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP', VarArrayOf([UpperCase(LNumAut),
                                                   LParcel, LDtaCad]),[]),
                                  False);

    If Not Result Then
      Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumNsu),
                                    cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP', VarArrayOf([UpperCase(LNumNsu),
                                                     LParcel, LDtaCad]),[]),
                                    False);

    If Not Result Then
      Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumPok),
                                    cdsBaixad.Locate('POKPGM;MCA_PARCEL;MCA_DTACUP', VarArrayOf([UpperCase(LNumPok),
                                                     LParcel, LDtaCad]),[]),
                                    False);

    If Not Result Then
      Result := TPagarMeFuncoes.IIF(Not TPagarMeFuncoes.fEmptyStr(LNumNsu),
                                    cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL;MCA_DTAVEN;MCA_VALSTA', VarArrayOf([UpperCase(LNumNsu),
                                                     LParcel, LDtaVen, LValorParcela]),[]),
                                    False);

    If Not Result Then
      Result := TPagarMeFuncoes.IIF(Not MatchStr('', [LNumNsu,LNumAut]),
                                    cdsBaixad.Locate('MCA_NUMNSU;MCA_NUMCCD;MCA_PARCEL;MCA_VALSTA', VarArrayOf([UpperCase(LNumNsu),
                                                     UpperCase(LNumAut), LParcel, LValorParcela]),[]),
                                    False);
  End;

  blnAutomatica := (Result) And
                   (Not TPagarMeFuncoes.fEmptyStr(cdsBaixad.FieldbyName('MCA_CHACON').AsString));
end;

procedure TConciliacaoPagarMeRecebiveis.VendasCanceladas;
var
  LConsulta: TUniQuery;
  LFiltro: String;
begin
  LConsulta := Nil;

    try
      If FModeloAtualizado Then
        LFiltro := '((IFNULL(B.PGM_ID_COB, "") <> "" AND                    ' +
                  '    IFNULL(R.PGM_ID_COB, "") <> "" AND                   ' +
                  '    B.PGM_ID_COB = R.PGM_ID_COB)                         ' +
                  '   OR B.PGM_GATWAY = R.PGM_GATWAY)                       '
      Else
        LFiltro := 'B.PGM_GATWAY = R.PGM_GATWAY';

    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT                                          ' +
                          '  A.PGM_GATWAY AS NUMNSU,                       ' +
                          '  EMP_CODEMP,                                   ' +
                          '  "N" AS AJUSTE_GERADO                          ' +
                          'FROM                                            ' +
                          '  PGM_PMRECE A                                  ' +
                          'INNER JOIN PGM_PMCOBR C                         ' +
                          ' ON C.PGM_ID_COB = A.PGM_ID_COB                 ' +
                          ' AND C.PGM_KEYAPI = A.PGM_KEYAPI                ' +
                          ' AND C.PGM_NUMPAR = A.PGM_NUMPAR                ' +
                          ' AND IFNULL(C.PGM_ID_COB,"") <> ""              ' +
                          ' AND C.PGM_STATUS = "canceled"                  ' +
                          'LEFT JOIN CFGSIS                                ' +
                          ' ON SIS_CODCFG = "CFG_PGMREI"       AND         ' +
                          'SIS_CODEMP = "' + RetornaEmpresaFiltrada + '" AND ' +
                          '    IFNULL(SIS_VALCFG, "") <> ""    AND         ' +
                          '    IFNULL(A.PGM_RECEBE, "") <> ""  AND         ' +
                          '    LOCATE(A.PGM_RECEBE, SIS_VALCFG) > 0        ' +
                          'LEFT JOIN CADEMP                                ' +
                          '  ON EMP_CODEMP = SIS_CODEMP                    ' +
                          'WHERE A.PGM_DTAPAG BETWEEN :DTAINI AND :DTAFIN  ' +
                          '  AND A.PGM_STATUS = "paid"                     ' +
                          '  AND A.PGM_TIPREC = "credit"                   ' +
                          '  AND A.PGM_CONCIL = 0                          ' +
                          '  AND A.PGM_RECEBE IN (' + TPagarMeFuncoes.fRetStrToSQLIn(RetornaIDsEmpresaConciliacao, ',') + ') ' +
                          ' GROUP BY A.PGM_ID_REC                          ' +
                          'UNION                                           ' +
                          'SELECT                                          ' +
                          '  R.PGM_GATWAY AS NUMNSU,                       ' +
                          '  EMP_CODEMP,                                   ' +
                          '  "N" AS AJUSTE_GERADO                          ' +
                          'FROM                                            ' +
                          '  PGM_PMRECE R                                  ' +
                          'INNER JOIN PGM_PMRECE B                         ' +
                          ' ON  ' + LFiltro + '                         ' +
                          ' AND B.PGM_KEYAPI = R.PGM_KEYAPI                ' +
                          ' AND B.PGM_NUMPAR = R.PGM_NUMPAR                ' +
                          ' AND B.PGM_STATUS = R.PGM_STATUS                ' +
                          ' AND B.PGM_TIPREC <> R.PGM_TIPREC               ' +
                          'LEFT JOIN CFGSIS                                ' +
                          ' ON SIS_CODCFG = "CFG_PGMREI"       AND         ' +
                          '    IFNULL(SIS_VALCFG, "") <> ""    AND         ' +
                          '    IFNULL(R.PGM_RECEBE, "") <> ""  AND         ' +
                          '    LOCATE(R.PGM_RECEBE, SIS_VALCFG) > 0        ' +
                          'LEFT JOIN CADEMP                                ' +
                          '  ON EMP_CODEMP = SIS_CODEMP                    ' +
                          'WHERE R.PGM_DTAPAG BETWEEN :DTAINI AND :DTAFIN  ' +
                          '  AND R.PGM_STATUS = "paid"                     ' +
                          '  AND R.PGM_TIPREC = "credit"                   ' +
                          '  AND R.PGM_CONCIL = 0                          ' +
                          '  AND R.PGM_RECEBE IN (' + TPagarMeFuncoes.fRetStrToSQLIn(RetornaIDsEmpresaConciliacao, ',') + ') ' +
                          ' GROUP BY R.PGM_ID_REC                          ' ;

    LConsulta.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', DataInicioPeriodo);
    LConsulta.ParamByName('DTAFIN').AsString := FormatDateTime('yyyy-mm-dd', DataFinalPeriodo);
    LConsulta.Options.SetFieldsReadOnly := False;
    LConsulta.Open;

    FCdsVendasCanceladas := TPagarMeFuncoes.CriarClientDataSet(LConsulta);
  finally
    TPagarMeFuncoes.FreeAndNilDatasets(LConsulta);
  end;
end;

procedure TConciliacaoPagarMeRecebiveis.PedidosPagosComMaisDeUmCartao();
var
  LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT                                          ' +
                          '  CO1.PGM_NUMPOK AS NUMPOK,                     ' +
                          '  CO1.PGM_NUMNSU AS NUMNSU,                     ' +
                          '  CO1.PGM_TOTPAR AS TOTPAR,                     ' +
                          '  EMP_CODEMP                                    ' +
                          'FROM                                            ' +
                          '  PGM_PMRECE AS RE                              ' +
                          '  INNER JOIN PGM_PMCOBR AS CO1                  ' +
                          '    ON (                                        ' +
                          '      RE.PGM_ID_COB = CO1.PGM_ID_COB            ' +
                          '      AND RE.PGM_NUMPAR = CO1.PGM_NUMPAR        ' +
                          '      AND RE.PGM_KEYAPI = CO1.PGM_KEYAPI        ' +
                          '      AND IFNULL(RE.PGM_ID_COB, "") <> ""       ' +
                          '    )                                           ' +
                          '  JOIN PGM_PMCOBR AS CO2                        ' +
                          '    ON (                                        ' +
                          '      CO2.PGM_NUMPAR = CO1.PGM_NUMPAR           ' +
                          '      AND CO2.PGM_KEYAPI = CO1.PGM_KEYAPI       ' +
                          '    )                                           ' +
                          '    AND (                                       ' +
                          '      CO2.PGM_NUMPOK = CO1.PGM_NUMPOK           ' +
                          '      AND CO2.PGM_NUMNSU <> CO1.PGM_NUMNSU      ' +
                          '    )                                           ' +
                          '  LEFT JOIN CFGSIS                              ' +
                          '    ON SIS_CODCFG = "CFG_PGMREI"        AND     ' +
                          'SIS_CODEMP = "' + RetornaEmpresaFiltrada + '" AND ' +
                          '       IFNULL(SIS_VALCFG, "") <> ""     AND     ' +
                          '       IFNULL(RE.PGM_RECEBE, "") <> ""  AND     ' +
                          '       LOCATE(RE.PGM_RECEBE, SIS_VALCFG) > 0    ' +
                          '  LEFT JOIN CADEMP                              ' +
                          '    ON EMP_CODEMP = SIS_CODEMP                  ' +
                          '  JOIN MOVCAR A                                 ' +
                          '    ON (                                        ' +
                          '        LEFT(RIGHT(A.MCA_NUMPOK,9),6) = CO1.PGM_NUMPOK ' +
                          '        AND A.MCA_NUMNSU = CO1.PGM_NUMNSU       ' +
                          '    )                                           ' +
                          '  JOIN MOVCAR B                                 ' +
                          '    ON (                                        ' +
                          '        B.MCA_NUMPOK = A.MCA_NUMPOK             ' +
                          '        AND B.MCA_NUMNSU <> A.MCA_NUMNSU        ' +
                          '        AND B.MCA_NUMDUP = A.MCA_NUMDUP         ' +
                          '    )                                           ' +
                          'WHERE RE.PGM_TIPREC = "credit"                  ' +
                          '  AND RE.PGM_STATUS = "paid"                    ' +
                          '  AND RE.PGM_CONCIL = 0                         ' +
                          '  AND LEFT(A.MCA_NUMPOK, 2) = "WS"              ' +
                          '  AND CO1.PGM_METPAG = "credit_card"            ' +
                          '  AND RE.PGM_DTAPAG BETWEEN :DTAINI AND :DTAFIN ' +
                          '  AND RE.PGM_RECEBE IN (' + TPagarMeFuncoes.fRetStrToSQLIn(RetornaIDsEmpresaConciliacao, ',') + ') ' +
                          ' GROUP BY CO1.PGM_NUMPOK, CO1.PGM_NUMNSU         ' +
                          ' ORDER BY CO1.PGM_NUMPOK, CO1.PGM_NUMNSU         ';

    LConsulta.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', DataInicioPeriodo);
    LConsulta.ParamByName('DTAFIN').AsString := FormatDateTime('yyyy-mm-dd', DataFinalPeriodo);
    LConsulta.Open;

    FCdsPedidosComMaisDeUmCartao := TPagarMeFuncoes.CriarClientDataSet(LConsulta);
  finally
    TPagarMeFuncoes.FreeAndNilDatasets(LConsulta);
  end;
end;

function TConciliacaoPagarMeRecebiveis.RetornaConsultaConciliacao: String;
begin
  Result := 'SELECT                                             ' +
            '  RE.PGM_DTAIMP AS PGM_DTAIMP,                     ' +
            '  RE.PGM_TIPREC AS PGM_TIPREC,                     ' +
            '  CO.PGM_TOTPAR AS PGM_TOTPAR,                     ' +
            '  RE.PGM_NUMPAR AS PGM_NUMPAR,                     ' +
            '  IF(IFNULL(CO.PGM_NUMNSU,"") = "", RE.PGM_GATWAY, CO.PGM_NUMNSU) AS PGM_NUMNSU, ' +
            '  CO.PGM_CODAUT AS PGM_CODAUT,                     ' +
            '  CO.PGM_NUMPOK AS PGM_NUMPOK,                                   ' +
            '  IF(CO.PGM_DTACRE IS NULL, RE.PGM_DTACAD, CO.PGM_DTACRE) AS PGM_DTACAD, ' +
            '  RE.PGM_VALPAR AS VALBRU,                         ' +
            '  (RE.PGM_TAXPAR + RE.PGM_TAXFRA) AS VALTAX,       ' +
            '  (RE.PGM_VALPAR - RE.PGM_TAXPAR - RE.PGM_TAXANT   ' +
            '   - RE.PGM_TAXFRA) AS VALPAG,                     ' +
            '  RE.PGM_TAXPAR AS PGM_TAXPAR,                     ' +
            '  RE.PGM_TAXANT AS PGM_TAXANT,                     ' +
            '  RE.PGM_TAXFRA AS PGM_TAXFRA,                     ' +
            '  CO.PGM_NUMCAR AS PGM_NUMCAR,                     ' +
            '  CO.PGM_ID_COB AS PGM_ID_COB,                     ' +
            '  CO.PGM_BANDEI AS PGM_BANDEI,                     ' +
            '  RE.PGM_DTAVEN AS PGM_DTAVEN,                     ' +
            '  RE.PGM_DTAPAG AS PGM_DTAPAG,                     ' +
            '  RE.PGM_ID_REC AS PGM_ID_REC,                     ' +
            '  RE.PGM_KEYAPI AS PGM_KEYAPI,                     ' +
            '  RE.PGM_CONCIL AS PGM_CONCIL,                     ' +
            '  CO.PGM_ORDINT AS PGM_ORDINT,                     ' +
            '  CO.PGM_NUMNSU AS NSU_ORIGINAL,                   ' +
            '  UPPER(CO.PGM_ORD_ID) AS PGM_ORD_ID,              ' +
            '  UPPER(CO.PGM_CUS_ID) AS PGM_CUS_ID,              ' +
            '  IF(IFNULL(CO.PGM_METPAG,"") = "", RE.PGM_METPAG, CO.PGM_METPAG) AS PGM_METPAG, ' +
            '  CO.PGM_ORIGEM AS PGM_ORIGEM,                     ' +
            '  "" AS PGM_TIPTRF,                                ' +
            '  RE.PGM_RECEBE AS PGM_RECEBE,                     ' +
            '  SIS_VALCFG AS RECEBEDORES,                       ' +
            '  EMP_CODEMP,                                      ' +
            '  EMP_NOMEMP,                                      ' +
            '  "PGM_PMRECE" AS NOME_TABELA                      ' +
            'FROM                                               ' +
            '  PGM_PMRECE RE                                    ' +
            '  LEFT JOIN PGM_PMCOBR AS CO                       ' +
            '    ON (RE.PGM_ID_COB = CO.PGM_ID_COB              ' +
            '        AND RE.PGM_NUMPAR = CO.PGM_NUMPAR          ' +
            '        AND IFNULL(RE.PGM_ID_COB, "") <> ""        ' +
            '        AND RE.PGM_KEYAPI = CO.PGM_KEYAPI)         ' +
            '   LEFT JOIN CFGSIS                                ' +
            '   ON SIS_CODCFG = "CFG_PGMREI" AND                ' +
            ' SIS_CODEMP = "' + RetornaEmpresaFiltrada + '" AND ' +
            '   IFNULL(SIS_VALCFG, "") <> "" AND                ' +
            '   IFNULL(RE.PGM_RECEBE, "") <> "" AND             ' +
            '   LOCATE(RE.PGM_RECEBE, SIS_VALCFG) > 0           ' +
            '  LEFT JOIN CADEMP                                 ' +
            '    ON EMP_CODEMP = SIS_CODEMP                     ' ;
end;

function TConciliacaoPagarMeRecebiveis.RetornaDescricaoDoAjuste(
  ATipoRecebimento: String): String;
const
  REEMBOLSO = 'refund';
  REEMBOLSO_CANCELADO = 'refund_reversal';
  CONTESTACAO = 'chargeback';
  CONTESTACAO_CANCELADA = 'chargeback_refund';
  SERVICO_PAGARME = 'fee_collection';
  LIQUIDACAO_EXTERNA = 'external_settlement';
  TAXA_TRANSFERENCIA = 'transfer';
begin
  if ATipoRecebimento.Equals(REEMBOLSO_CANCELADO) then
    Result := 'Reembolso Cancelado'
  else if ATipoRecebimento.Equals(CONTESTACAO) then
    Result := 'Contestação'
  else if ATipoRecebimento.Equals(CONTESTACAO_CANCELADA) then
    Result := 'Contestação cancelada'
  else if ATipoRecebimento.Equals(SERVICO_PAGARME) then
    Result := 'Serviços Pagar.ME'
  else if ATipoRecebimento.Equals(LIQUIDACAO_EXTERNA) then
    Result := 'Liquidação externa'
  else if ATipoRecebimento.Equals(TAXA_TRANSFERENCIA) then
    Result := DESCRICAO_TAXA_TRANSFERENCIA_PAGARME
  else if ATipoRecebimento.Equals(REEMBOLSO) and
          FCdsRegistrosAjuste.FieldByName('PGM_TIPTRF').AsString.Equals('boleto') then
    Result := 'Taxa de estorno de boleto'
  else if ATipoRecebimento.Equals(REEMBOLSO) then
    Result := 'Reembolso';
end;

function TConciliacaoPagarMeRecebiveis.RetornaEmpresaFiltrada: String;
begin
  Result := EmptyStr;
  If Length(EmpresasPeriodo) = 0 Then
    Exit;
  Result := EmpresasPeriodo[0].strCodigo;
end;

function TConciliacaoPagarMeRecebiveis.RetornaIDsEmpresaConciliacao: String;
  Var
    LEstabelecimento,
    LValorCfg: String;
begin
   Result := VS_FuncoesExternas.fICampoTabela('SIS_VALCFG',
                                              'CFGSIS',
                                              ['SIS_CODCFG', 'SIS_CODEMP'],
                                              ['CFG_PGMREI', RetornaEmpresaFiltrada]);

   If Result.IsEmpty Then
     Exit;

   LValorCfg := Result;

   Result := EmptyStr;
   For LEstabelecimento In LValorCfg.Split([',']) Do
     Result := Result + LEstabelecimento.Split(['|'])[0] + ',';

   Result := LeftStr(Result, Result.Length - 1);
end;

function TConciliacaoPagarMeRecebiveis.RetornaListaDePedidos: String;
  Var
    LRecNo : Integer;
begin
  LRecNo := FCdsRegistrosPagamento.RecNo;
  FCdsRegistrosPagamento.First;

  While Not FCdsRegistrosPagamento.Eof Do
  Begin
    Result := Result + '"' + FCdsRegistrosPagamento.FieldByName('PGM_CODAUT').AsString + '",' +
                       '"' + FCdsRegistrosPagamento.FieldByName('PGM_NUMNSU').AsString + '",' +
                       '"' + FCdsRegistrosPagamento.FieldByName('PGM_NUMPOK').AsString + '",' ;

    If Not FCdsRegistrosPagamento.FieldByName('PGM_ORDINT').AsString.IsEmpty Then
      Result := Result + '"' + FCdsRegistrosPagamento.FieldByName('PGM_ORDINT').AsString + '",';

    If Not FCdsRegistrosPagamento.FieldByName('PGM_ORD_ID').AsString.IsEmpty Then
      Result := Result + '"' + FCdsRegistrosPagamento.FieldByName('PGM_ORD_ID').AsString.ToUpperInvariant + '",';

    If Not FCdsRegistrosPagamento.FieldByName('PGM_CUS_ID').AsString.IsEmpty Then
      Result := Result + '"' + FCdsRegistrosPagamento.FieldByName('PGM_CUS_ID').AsString.ToUpperInvariant + '",';

    If Not FCdsRegistrosPagamento.FieldByName('NSU_ORIGINAL').AsString.IsEmpty Then
      Result := Result + '"' + TPagarMeFuncoes.fPadL(FCdsRegistrosPagamento.FieldByName('NSU_ORIGINAL').AsString.ToUpperInvariant, 14, '0') + '",';

    FCdsRegistrosPagamento.Next;
  End;

  FCdsRegistrosPagamento.RecNo := LRecNo;

  // AJUSTES
  LRecNo := FCdsRegistrosAjuste.RecNo;
  FCdsRegistrosAjuste.First;

  While Not FCdsRegistrosAjuste.Eof Do
  Begin
    Result := Result + '"' + FCdsRegistrosAjuste.FieldByName('PGM_CODAUT').AsString + '",' +
                       '"' + FCdsRegistrosAjuste.FieldByName('PGM_NUMNSU').AsString + '",';
    FCdsRegistrosAjuste.Next;
  End;

  FCdsRegistrosAjuste.RecNo := LRecNo;

  If Result.IsEmpty Then
    Exit('" "');

  Result := LeftStr(Result, Result.Length - 1);

  Result := Result.Replace(',""', EmptyStr);
  Result := Result.Replace('"",', EmptyStr);
end;

function TConciliacaoPagarMeRecebiveis.RetornaNomeRecebedor(ACodigoRecebedor,
  ACfgRecebedor: String): String;
  Var
    LValorCfg: String;
begin
  Result := EmptyStr;

  If ACfgRecebedor.IsEmpty Then
    Exit;

  For LValorCfg In ACfgRecebedor.Split([',']) Do
  Begin
    If Not LValorCfg.Contains(ACodigoRecebedor) Then
      Continue;

    If Length(LValorCfg.Split(['|'])) > 1 Then
      Result := LValorCfg.Split(['|'])[1];

    Exit;
  End;
end;

function TConciliacaoPagarMeRecebiveis.RetornaTipoPagamento: String;
begin
  Result := FCdsRegistrosPagamento.FieldByName('PGM_METPAG').AsString;

  if FCdsRegistrosPagamento.FieldByName('PGM_TAXANT').AsFloat > 0 then
    Result := 'ANT';
end;

function TConciliacaoPagarMeRecebiveis.RetornoNumeroDoCartao: String;
const
  CREDITO = 'credit_card';
  DEBITO  = 'debit_card';
begin
  Result := FCdsRegistrosPagamento.FieldByName('PGM_NUMCAR').AsString;

  if not MatchStr(FCdsRegistrosPagamento.FieldByName('PGM_METPAG').AsString,
                 [CREDITO, DEBITO]) then
    Result := FCdsRegistrosPagamento.FieldByName('PGM_METPAG').AsString.ToUpper;
end;

end.
