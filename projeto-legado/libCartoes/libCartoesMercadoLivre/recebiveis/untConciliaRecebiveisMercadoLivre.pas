unit untConciliaRecebiveisMercadoLivre;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, Vcl.Graphics, System.DateUtils,

     Uni, UniClientDataSet, cxProgressBar,

     untTMercadoLivreFuncoes, untTLibCartoesMovCar, untLibCartoesInterfacesTipos,
     untMercadoLivreConciliaRecebiveis;


type TConcilaRecebiveisMercadoLivre = class(TConciliaRecebiveisMkt)
  private
    qryWithDrawal: TUniQuery;

    FPeriodoFiltro,
    FListaDePedidos,
    FCartaoMercadoLivre,
    FCartoesMaquininhas,
    FCondicaoAjustes: String;

    FUtilizaImportacaoPorEmpresa,
    FConciliarPedidosZerados,
    FCadastrarNovaParcela,
    FPossuiCampoCUPEFE,
    FIgnorarPaymentSemVenda,
    FConsiderarValorFinancingFee: Boolean;

    FListaRegistrosConciliar,
    FListaRegistrosAjustesAgrupados,
    FRegistroAgrupadoValidado: TStringList;

    FCloneDatasetBaiCar,
    FCloneDatasetConCar,
    FCloneDatasetMaquininhas: TUniClientDataset;

    FAutoIncremRelatorio: Integer;

    FPossuiRegistroCanceladoQueNecessitaConciliar,
    FPossuiRegistroCanceladoQueForamBaixados,
    FPossuiRegistroCanceladoSemMovcar: Boolean;

    FValorAjusteIgnorado: Double;

    procedure pFiltraCartoesML;
    procedure pFiltraCartoesBaixadosML;

    function ValidaPedidoMLCompleto(var AValorBruto: Double;
                                    var AValorLiquido: Double;
                                    var AValorTaxa: Double;
                                    var ADeveMarcarRegistro: Boolean): Boolean;

    function fBuscaCartaoML: Boolean;
    function BuscaCartaoMLOrderId(var AValorBruto: Double; var AValorTaxa: Double; var AValorLiquido: Double): Boolean;
    function BuscaCartaoMLOrderIdNaAutorizacao(var AValorBruto: Double; var AValorTaxa: Double; var AValorLiquido: Double): Boolean;
    function fBuscaCartaoBaixadoML: Boolean;
    function BuscaCartaoBaixadoMLOrderId: Boolean;
    function ValidaTodosOsRegistrosAgupadosPorShippingIdQueContenhamOrderId(var AValorBruto,
                                                                                AValorLiquido,
                                                                                AValorTaxa: Double): Boolean;

    function ValidaTodosOsRegistrosAgupadosPorShippingIdQueContenhamOrderIdNaAutorizacao(var AValorBruto,
                                                                                             AValorLiquido,
                                                                                             AValorTaxa: Double): Boolean;

    function ValidarApenasUmRegistroMOVCAReVariosImportadosPorShippingID(var AValorBruto,
                                                                             AValorLiquido: Double): Boolean;

    procedure pGravaAjustesDeRetiradas;
    function FiltraCancelamentosML(prgStatus: TcxProgressBar): Boolean;

    function AgruparERemoverRegistgrosDeFretesEAjustes: Boolean;
    function EhRegistroDoTipoRefundPositivoApenasComValorDeFrete: Boolean;
    function EhRegistroDeRefundOuReserveForRefundPositivo: Boolean;
    function EhRefundCompensadoPorAjusteCredito: Boolean;
    function AjustePossuiAMesmaDataDePagamentoDaLiberacaoDaVenda(ADatasetVenda,
                                                                 ADatasetAjuste: TDataset): Boolean;

    function RetornaListaDePedidos: String;

    procedure GravaAjusteParaRegistrosCancelados;

    procedure AdicionaAjustesAgrupadosParaConciliar;

    function ValidaDataDoAjuste(ADataAjuste: TDateTime): Boolean;

    procedure AdicionaRegistrosDeTransferenciasML(AFiltroTransferencia: String);
    function EmpresaSQL:String;
    function RetornaFiltroEmpresa: String;

    function ValidaValorBrutoELiquido(AValorBruto: Double; AValorLiquido: Double; AValidaTodosSeConciliado: Boolean = False): Boolean;

    function GeraRegistroBlockUnblock: Boolean;

    procedure AjustarArredondamentoDeTaxaValorBruto(var AValorTaxa: Double;
                                                    var AValorBruto: Double);

    procedure RegistraNovaParcelaMovcarDeLiberacoesParciais(var ARegistroRelatorio: TItensRelatorioCartoes);

    function RegistroCancelado(ARegistroEncontrado: Boolean): Boolean;
    function RegistroPaymentSemVendaVinculada: Boolean;
    function RegistroVendaComDivergenciaDeFreteSemRegistroMovcar: Boolean;

    function RetornaCondicaoFreteRecebidoComoVenda(const AAliasTabela: String): String;
    function RetornaSQLConciliacao: String;
    function RetornaSQLConciliacaoMaquininhas: String;

    function RetornaValorTaxaRegistro(ADataset: TDataset): Double;

    function RegistroReferenteALancamentoNosCofrinhos(ADataset: TDataset): Boolean;

    procedure GravaRegistroAjusteDeCompraFeitaPeloVendedorEDevolvida(AValorBruto,
                                                                     AValorLiquido: Double);

    procedure AbreDatasetShippingZerado;

    function CartaoMaquininhaDeveMarcarApenasUmaMOVCAR(ADatasetValidar: TDataset): Boolean;

    procedure SelecionaMultiplasParcelasMaquininasMovCar(AValorBruto,
                                                         AValorLiquido,
                                                         AValorTaxa,
                                                         AValorAjuste: Double;
                                                         ARegistroRelatorio: TItensRelatorioCartoes;
                                                         ADatasetMaquininhas: TDataset;
                                                         APrimeiraParcelaBaixada: Boolean);

    function fProcessaMLPag(pgbStatus: TcxProgressBar): Boolean;
    function ProcessaRegistrosMaquininhas(pgbStatus: TcxProgressBar): Boolean;
    function fConciliaML(pgbStatus: TcxProgressBar): Boolean;
  public
    constructor Create; overload;
    destructor Destroy; override;

    function fConciliaCartoes: Boolean; override;

    function RetornaEmpresaFiltrada: String;

    property ListaRegistrosConciliar: TStringList read FListaRegistrosConciliar;
    property UtilizaImportacaoPorEmpresa: Boolean read FUtilizaImportacaoPorEmpresa;

    property AutoIncremRelatorio: Integer read FAutoIncremRelatorio;

    property PossuiRegistroCanceladoQueNecessitaConciliar: Boolean read FPossuiRegistroCanceladoQueNecessitaConciliar Default False;
    property PossuiRegistroCanceladoQueForamBaixados: Boolean read FPossuiRegistroCanceladoQueForamBaixados Default False;
    property PossuiRegistroCanceladoSemMovcar: Boolean read FPossuiRegistroCanceladoSemMovcar Default False;

    property ValorAjusteIgnorado: Double read FValorAjusteIgnorado;
  protected

  end;

Type
  ExceptionAutComClass = Class(Exception);

Const
  INICAM = 'MER_';
  NOMTAB = 'MER_MLPGTO';

implementation

function TConcilaRecebiveisMercadoLivre.fConciliaML(pgbStatus: TcxProgressBar): Boolean;
Begin
  Result         := False;
  PossuiInconsistencia := False;

  cdsConCar := Nil;
  cdsBaixad := Nil;
  FDatasetMaquininhas := Nil;

  FListaRegistrosAjustesAgrupados := Nil;
  FRegistroAgrupadoValidado := Nil;

  qryWithDrawal := Nil;

  FCloneDatasetConCar := Nil;
  FCloneDatasetBaiCar := Nil;
  FDatasetShippingZerado := Nil;
  FCloneDatasetMaquininhas := Nil;
  Try
    Try
      FCartoesMaquininhas := EmptyStr;
      If TMercadoLivreFuncoes.CampoMER_NUMNSUExiste Then
      Begin
        FCartoesMaquininhas := VS_FuncoesExternas.fICfgSis('MERMAQ');

        If Not TMercadoLivreFuncoes.fRetSomenteNumeros(FCartoesMaquininhas).IsEmpty Then
        Begin
          If Trim(VS_FuncoesExternas.fICfgSis('MEREST')).IsEmpty Then
            Raise ExceptionAutComClass.Create('Quando seleciona cartões na CFG_MERMAQ, é obrigatório possuir código de estabelecimento cadastrado na CFG_MEREST.');
        End;
      End;

      FListaRegistrosConciliar := TStringList.Create;
      FListaRegistrosAjustesAgrupados := TStringList.Create;
      FRegistroAgrupadoValidado := TStringList.Create;

      FPossuiRegistroCanceladoQueNecessitaConciliar := False;
      FPossuiRegistroCanceladoQueForamBaixados := False;
      FPossuiRegistroCanceladoSemMovcar := False;

      If Not CarregaFiltrosParaBaixaRecebiveis(DataInicioPeriodo,
                                               DataFinalPeriodo,
                                               EmpresasPeriodo) Then
        Exit(False);

      TMercadoLivreFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Processando lançamentos (' + objConcil.NomeConciliacao + ').');
      fProcessaMLPag(pgbStatus);

      TMercadoLivreFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Processando lançamentos cartões (' + objConcil.NomeConciliacao + ').');
      ProcessaRegistrosMaquininhas(pgbStatus);

      TMercadoLivreFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Processando lançamentos (' + objConcil.NomeConciliacao + ').');
      GravaAjusteParaRegistrosCancelados;

      TForm(pgbStatus.Owner).Visible := False;
    Except
      On E: Exception Do
      Begin
        If E Is ExceptionAutComClass Then
          TMercadoLivreFuncoes.fMensagem('ATENÇÃO', E.Message, ['&Ok'])
        Else
          VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.fConcilia' + StringReplace(objConcil.NomeConciliacao, ' ', EmptyStr, []) + ']');

        Exit(False);
      End;
    End;

    PossuiInconsistencia := False;

    If Not TryStrToInt(FRelatorioConciliacao.AutoIncremRelatorio, FAutoIncremRelatorio) Then
      FAutoIncremRelatorio := 0;

    TForm(pgbStatus.Owner).Visible := True;
    TMercadoLivreFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Gravando registros do relatório (' + objConcil.NomeConciliacao + ').');
    GravarRegistrosRelatorio(pgbStatus);

  Finally
    TMercadoLivreFuncoes.FreeAndNilDatasets(cdsConCar);
    TMercadoLivreFuncoes.FreeAndNilDatasets(FDatasetMaquininhas);
    TMercadoLivreFuncoes.FreeAndNilDatasets(cdsBaixad);

    If Assigned(FListaRegistrosAjustesAgrupados)Then
      FreeAndNil(FListaRegistrosAjustesAgrupados);

    If Assigned(FRegistroAgrupadoValidado)Then
      FreeAndNil(FRegistroAgrupadoValidado);

    TMercadoLivreFuncoes.FreeAndNilDatasets(qryWithDrawal);

    TMercadoLivreFuncoes.FreeAndNilDatasets(FCloneDatasetConCar);
    TMercadoLivreFuncoes.FreeAndNilDatasets(FCloneDatasetBaiCar);
    TMercadoLivreFuncoes.FreeAndNilDatasets(FDatasetShippingZerado);
    TMercadoLivreFuncoes.FreeAndNilDatasets(FCloneDatasetMaquininhas);
  End;
End;

function TConcilaRecebiveisMercadoLivre.fConciliaCartoes: Boolean;
begin
  Result := TMercadoLivreFuncoes.ExecutaAguarde(fConciliaML, 'Aguarde... Iniciando a conciliação.');
end;

function TConcilaRecebiveisMercadoLivre.fProcessaMLPag(pgbStatus: TcxProgressBar): Boolean;
Var
  LValorBruto,
  LValorLiquido: Double;

  LSQL,
  LChaveConciliacao: String;

  blnBusca : Boolean;

  LRegistroRelatorio: TItensRelatorioCartoes;

  LConsulta: TUniQuery;

  LValorTaxa: Double;

  LPossuiRegistros,
  LDeveMarcarPedido: Boolean;

  LFiltroTransferencias: String;
begin
  FTipoTransferenciaCaixa := VS_FuncoesExternas.fICfgSis('RCXTCC');

  FValorAjusteIgnorado := 0;

  Application.ProcessMessages;

  pgbStatus.Visible := False;

  //Determinando retiradas para poder gerar ajustes de retiradas (maneira antiga, manter compatibilidade)
  qryWithDrawal := VS_FuncoesExternas.fICriaQuery;
  qryWithDrawal.SQL.Text := 'SELECT MER_MLPGTO.*, '+ EmpresaSQL + ' AS CODEMP ' +
                            'FROM MER_MLPGTO ' +
                            'WHERE MER_DTAPAG BETWEEN ' + FormatDateTime('yyyy-mm-dd hh:mm:ss', StrToDateTime(strDtaIni + ' 00:00:00')).QuotedString + ' AND ' +
                                                          FormatDateTime('yyyy-mm-dd hh:mm:ss', StrToDateTime(strDtaFim + ' 23:59:59')).QuotedString +
                            '  AND MER_TIPREG="withdrawal" ORDER BY MER_DTAPAG';
  qryWithDrawal.Open;

  LSQL := RetornaSQLConciliacao;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SHOW TABLES LIKE "' + NOMTAB + '"';
    LConsulta.Open;
    If LConsulta.IsEmpty Then
    Begin
      TMercadoLivreFuncoes.fMensagem('ATENÇÃO','Não existem arquivos importados para a conciliação do ' + objConcil.NomeConciliacao + '!',['&OK']);
      Exit(False);
    End;

    LConsulta.Close;
    LConsulta.SQL.Text := LSQL;

    LConsulta.Open;

    cdsConCar := TMercadoLivreFuncoes.CriarClientDataSet(LConsulta);

    AbreDatasetShippingZerado;
  Finally
    TMercadoLivreFuncoes.FreeAndNilDatasets(LConsulta);
  End;

  FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                        'MERCADO LIVRE',
                                                        'CONCILIACAO',
                                                        RetornaFiltrosdigitados,
                                                        TMercadoLivreFuncoes.RetornaDataHoraServidor,
                                                        TMercadoLivreFuncoes.RetornaHoraServidor);

  FCondicaoAjustes := 'MER_DTAPAG ';
  FCondicaoAjustes := FCondicaoAjustes + FPeriodoFiltro;

  TMercadoLivreFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando registros.', False);
  pFiltraCartoesML;

  //Filtrando Cancelamentos/Ajustes
  FCondicaoAjustes := FCondicaoAjustes + RetornaFiltroEmpresa;
  FCondicaoAjustes := FCondicaoAjustes + ' AND ((MER_TIPREG IN ("payment", "fee_for_divergence_in_package_dimensions") AND MER_VALLIQ < 0) OR ' +
                                         '      (MER_TIPREG NOT IN ("payment", "withdrawal", "total", "payout", "withdrawal_cancel", "ajuste_credito", "initial_available_balance", "fee_for_divergence_in_package_dimensions")) OR ' +
                                         '      (MER_CODAUT LIKE "money_transfer%") OR ' +
                                         '      (MER_CODAUT LIKE "POTS_%") OR '+
                                         '      (MER_CODAUT = "Vendapresencial" AND MER_SHP_ID = "Vendapresencial") ';

  If (TMercadoLivreFuncoes.FCampoMER_NUMNSUExiste.Equals('S')) And (FCartoesMaquininhas.Length < 5) Then
    FCondicaoAjustes := FCondicaoAjustes + ' OR (MER_TIPREG="payment" AND MER_NUMNSU IS NOT NULL AND MER_POS_ID IS NOT NULL AND MER_SHP_ID = "Vendapresencial") ';

  FCondicaoAjustes := FCondicaoAjustes + ' ) AND MER_VALLIQ <> 0 AND MER_STATUS IN ("release", "block", "unblock") ' ;

  pgbStatus.Visible := True;
  TMercadoLivreFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Processando e agrupando ajustes.', False);
  FiltraCancelamentosML(pgbStatus);

  pgbStatus.Visible := False;
  LPossuiRegistros := Not cdsConCar.IsEmpty;
  If Not LPossuiRegistros Then
    LPossuiRegistros := Not cdsAjustes.IsEmpty;

  If Not LPossuiRegistros Then
  Begin
    If (Not TMercadoLivreFuncoes.FCampoMER_NUMNSUExiste.Equals('S')) Or (FCartoesMaquininhas.Length < 5) Then
    Begin
      TMercadoLivreFuncoes.fMensagem('ATENÇÃO','Não existem arquivos importados nesse período de recebimento!',['&OK']);
      blnReabre := True;
    End;
    Exit(False);
  End;

  TMercadoLivreFuncoes.FreeAndNilDatasets(FCloneDatasetBaiCar);
  TMercadoLivreFuncoes.FreeAndNilDatasets(FCloneDatasetConCar);
  Try
    FCloneDatasetBaiCar := TMercadoLivreFuncoes.CriarClientDataSet(cdsBaiCar);
    FCloneDatasetBaiCar.IndexFieldNames := 'MCA_NUMNSU;MCA_NUMCCD;MCA_CODEMP;PARDUP;MCA_DTACUP;MCA_NUMDUP';
    FCloneDatasetBaiCar.Open;

    FCloneDatasetConCar := TMercadoLivreFuncoes.CriarClientDataSet(cdsConCar);

    //Transferências
    LFiltroTransferencias := 'MER_DTAPAG ' + FPeriodoFiltro + ' AND ' +
                             ' MER_TIPREG IN ("withdrawal", "payout") AND (MER_VALLIQ <> 0) AND MER_DTASTR IS NOT NULL ';

    LFiltroTransferencias := LFiltroTransferencias + RetornaFiltroEmpresa;
    AdicionaRegistrosDeTransferenciasML(LFiltroTransferencias);

    //Toda retirada gera uma taxa
    pGravaAjustesDeRetiradas;

    //Selecionando cartões já baixados/cadastrados no período
    pFiltraCartoesBaixadosML;

    pgbStatus.Visible := True;
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsConCar.RecordCount;

    cdsConCar.First;
    While Not cdsConCar.EOF do
    Begin
      FCadastrarNovaParcela := False;

      TMercadoLivreFuncoes.pStepStatusGravacao(pgbStatus);

      If MatchStr(cdsConCar.FieldByName('MER_TIPREG').AsString, ['withdrawal', 'payout', 'initial_available_balance']) Then
      Begin
        cdsConCar.Next;
        Continue;
      End;

      If RegistroReferenteALancamentoNosCofrinhos(cdsConCar) Then
      Begin
        cdsConCar.Next;
        Continue;
      End;

      FTextoInconsistencia := EmptyStr;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LValorBruto := cdsConCar.FieldByName('VALOR_BRUTO').Value;
      LValorLiquido := cdsConCar.FieldByName('MER_VALLIQ').Value;
      LValorTaxa := RetornaValorTaxaRegistro(cdsConCar);

      blnBusca := ValidaPedidoMLCompleto(LValorBruto,
                                         LValorLiquido,
                                         LValortaxa,
                                         LDeveMarcarPedido);

      //Frete recebido como venda (RetornaCondicaoFreteRecebidoComoVenda): só o cartão de líquido igual ao frete é a
      //venda. Se a busca parou noutro cartão do mesmo envio, vira "venda não encontrada" em vez de baixar o errado
      If blnBusca And cdsConCar.FieldByName('MER_TIPREG').AsString.Equals('shipping') Then
        blnBusca := FormatFloat(',0.00', cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat).Equals(FormatFloat(',0.00', LValorLiquido));

      If blnBusca Then
      Begin
        LChaveConciliacao := INICAM + cdsConCar.FieldByName('MER_CODAUT').AsString + '_' +
                             cdsBaiCar.FieldByName('PARDUP').AsString + '_' +
                             cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                             FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('MER_DTATRA').Value);

        If LDeveMarcarPedido Then
        Begin
          //Frete recebido como venda (RetornaCondicaoFreteRecebidoComoVenda): o arquivo só traz a parte do
          //frete; bruto, frete e taxa vêm do cartão, que tem a venda inteira
          If cdsConCar.FieldByName('MER_TIPREG').AsString.Equals('shipping') Then
          Begin
            cdsConCar.Edit;
            cdsConCar.FieldByName('VALOR_BRUTO').AsFloat := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
            cdsConCar.FieldByName('MER_VALENV').AsFloat := cdsBaiCar.FieldByName('MCA_FREMKT').AsFloat * (-1);
            cdsConCar.FieldByName('REGISTROFRETE').AsFloat := 0.00;
            cdsConCar.Post;

            LValorBruto := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
            LValorTaxa := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;
          End;

          MarcarCartaoEncontradoArquivo(LValorBruto,
                                        LValorLiquido,
                                        LRegistroRelatorio,
                                        LChaveConciliacao,
                                        cdsConCar,
                                        Abs(cdsConCar.FieldByName('REGISTROFRETE').AsFloat + cdsConCar.FieldByName('MER_VALENV').AsFloat),
                                        Abs(cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat),
                                        Abs(LValorTaxa),
                                        Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat));

          LRegistroRelatorio.Conciliado := 0;

          If cdsBaiCar.FieldByName('MCA_MARDES').AsString = 'M' Then
          Begin
            If Not FTextoInconsistencia.IsEmpty Then
              LRegistroRelatorio.SomarNoTotal := 'N';

            cdsConCar.Edit;
            cdsConCar.FieldByName('MARCADO').AsString := 'S';
            cdsConCar.Post;

            FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(cdsConCar));

            AdicionaAjustesAgrupadosParaConciliar;
          End;
        End
        Else
        Begin
          blnBusca := fBuscaCartaoBaixadoML;
          If blnBusca Then
          Begin
            FTextoInconsistencia := 'Vendas já foram baixadas';
            LRegistroRelatorio.InconsistenciaConciliada := 'S';
            LRegistroRelatorio.Conciliado := 1;
            LRegistroRelatorio.AutoIncremMovCar := cdsBaixad.FieldByName('AUTOINCREM').AsString;
          End;
        End;
      End
      Else
      Begin
        If FRegistroAgrupadoValidado.IndexOf(cdsConCar.FieldByName('MER_SHP_ID').AsString) >= 0 Then
        Begin
          cdsConCar.Edit;
          cdsConCar.FieldByName('MARCADO').AsString := 'S';
          cdsConCar.Post;

          FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(cdsConCar));

          FreeAndNil(LRegistroRelatorio);

          cdsConCar.Next;
          Continue;
        End;

        //verifica se está cadastrado ou já foi baixado no período
        cdsBaixad.First;
        blnBusca := fBuscaCartaoBaixadoML;
        If Not blnBusca Then
        Begin
          If cdsConCar.FieldByName('MER_VALLIQ').AsFloat > 0 Then
            FTextoInconsistencia := 'Vendas não encontradas nos lançamentos do sistema';
        End
        Else
        Begin
          FTextoInconsistencia := 'Vendas já foram baixadas';
          LRegistroRelatorio.InconsistenciaConciliada := 'S';
          LRegistroRelatorio.Conciliado := 1;
          LRegistroRelatorio.AutoIncremMovCar := cdsBaixad.FieldByName('AUTOINCREM').AsString;
        End;
      End;

      If RegistroCancelado(blnBusca) Then
      Begin
        cdsConCar.Next;
        FreeAndNil(LRegistroRelatorio);

        Continue;
      End;

      If RegistroPaymentSemVendaVinculada Then
      Begin
        cdsConCar.Next;
        FreeAndNil(LRegistroRelatorio);

        Continue;
      End;

      If RegistroVendaComDivergenciaDeFreteSemRegistroMovcar Then
      Begin
        cdsConCar.Next;
        FreeAndNil(LRegistroRelatorio);

        Continue;
      End;

      If FCadastrarNovaParcela Then
        RegistraNovaParcelaMovcarDeLiberacoesParciais(LRegistroRelatorio);

      If FormatFloat(',0.00', LValorLiquido).Equals(FormatFloat(',0.00', LValorBruto)) Then
      Begin
        If FTextoInconsistencia.Equals('Vendas não encontradas nos lançamentos do sistema') Then
        Begin
          GravaRegistroAjusteDeCompraFeitaPeloVendedorEDevolvida(LValorBruto, LValorLiquido);

          cdsConCar.Next;

          FreeAndNil(LRegistroRelatorio);

          Continue;
        End;
      End;

      {Gerando registro do relatório}
      FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
      If Not FTextoInconsistencia.IsEmpty Then
      Begin
        LRegistroRelatorio.Descricao := FTextoInconsistencia;
        If Not LRegistroRelatorio.InconsistenciaConciliada.Equals('S') Then
          LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
      End;
      LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('MER_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName('CODEMP').AsString;
      LRegistroRelatorio.CodigoEmpresa := cdsConCar.FieldByName('CODEMP').AsString;
      If LRegistroRelatorio.CodigoEmpresa.IsEmpty Then
      Begin
        LRegistroRelatorio.CodigoEstabelecimento := VS_FuncoesExternas.fIRetEmpresaLogada;
        LRegistroRelatorio.CodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;
      End;

      LRegistroRelatorio.NumeroNSU := cdsConCar.FieldByName('MER_SHP_ID').AsString;
      LRegistroRelatorio.CodigoAutorizacao := cdsConCar.FieldByName('MER_CODAUT').AsString;
      LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('MER_NUMVEN').AsString;
      LRegistroRelatorio.NumeroCartao := 'MERCADO LIVRE';

      LRegistroRelatorio.TipoCartao := 'CRÉDITO ROTATIVO';

      If Not FCadastrarNovaParcela Then
      Begin
        LRegistroRelatorio.Parcela := TMercadoLivreFuncoes.fStrZero(cdsConCar.FieldByName('MER_NUMPAR').AsString, 2);
        LRegistroRelatorio.TotalParcelas := TMercadoLivreFuncoes.fStrZero(cdsConCar.FieldByName('MER_TOTPAR').AsString, 2);
      End;
      LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('MER_DTAPAG').Value;
      LRegistroRelatorio.DataVenda := cdsConCar.FieldByName('MER_DTATRA').Value;
      LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('MER_DTAPAG').Value;

      LRegistroRelatorio.ValorBruto := LValorBruto - Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);

      LRegistroRelatorio.ValorLiquido := LValorLiquido;
      LRegistroRelatorio.ValorTaxas := LValorTaxa;
      LRegistroRelatorio.ValorFrete := Abs(cdsConCar.FieldByName('REGISTROFRETE').AsFloat + cdsConCar.FieldByName('MER_VALENV').AsFloat);
      LRegistroRelatorio.ValorAjustes := Abs(cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat);
      LRegistroRelatorio.ValorCupom := Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);

      LRegistroRelatorio.DescricaoBandeira := objConcil.NomeConciliacao;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, False, cdsConCar);

      cdsConCar.Next;
    End;
  Except
    Raise;
  End;
  Result := True;
end;

function TConcilaRecebiveisMercadoLivre.GeraRegistroBlockUnblock: Boolean;
  Var
    LRegistroRelatorio: TItensRelatorioCartoes;

    LCodigoEmpresa: String;
begin
  Result := MatchStr(cdsAjustes.FieldByName('MER_STATUS').AsString, ['block', 'unblock']);
  If Not Result Then
    Exit;

  LRegistroRelatorio := TItensRelatorioCartoes.Create;

  LCodigoEmpresa := cdsAjustes.FieldByName('EMPRESA').Value;
  If LCodigoEmpresa.IsEmpty Then
    LCodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;

  {Gerando registro do relatório}
  LRegistroRelatorio.TipoDoRegistro := 'BLOCK-UNBLOCK';
  LRegistroRelatorio.Descricao := 'Pedidos em disputa/bloqueados';
  LRegistroRelatorio.DescricaoAjuste := cdsAjustes.FieldByName('MER_TIPREG').AsString;
  LRegistroRelatorio.NomeArquivo := cdsAjustes.FieldByName('MER_NOMARQ').AsString;
  LRegistroRelatorio.CodigoEstabelecimento := LCodigoEmpresa;
  LRegistroRelatorio.CodigoEmpresa := LCodigoEmpresa;
  LRegistroRelatorio.NumeroNSU := cdsAjustes.FieldByName('MER_SHP_ID').AsString;
  LRegistroRelatorio.CodigoAutorizacao := cdsAjustes.FieldByName('MER_CODAUT').AsString;
  LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('MER_NUMVEN').AsString;
  LRegistroRelatorio.NumeroCartao := 'MERCADO LIVRE';

  LRegistroRelatorio.TipoCartao := 'PEDIDOS EM DISPUTA/BLOQUEADOS';

  LRegistroRelatorio.Parcela := TMercadoLivreFuncoes.fStrZero(cdsAjustes.FieldByName('MER_NUMPAR').AsString, 2);
  LRegistroRelatorio.TotalParcelas := TMercadoLivreFuncoes.fStrZero(cdsAjustes.FieldByName('MER_TOTPAR').AsString, 2);
  LRegistroRelatorio.DataPagamento := cdsAjustes.FieldByName('MER_DTAPAG').Value;
  LRegistroRelatorio.DataVenda := cdsAjustes.FieldByName('MER_DTATRA').Value;
  LRegistroRelatorio.DataVencimento := cdsAjustes.FieldByName('MER_DTAPAG').Value;

  LRegistroRelatorio.ValorBruto := cdsAjustes.FieldByName('VALOR_BRUTO').Value;
  LRegistroRelatorio.ValorLiquido := cdsAjustes.FieldByName('MER_VALLIQ').Value;

  LRegistroRelatorio.DescricaoBandeira := objConcil.NomeConciliacao;

  LRegistroRelatorio.Conciliado := cdsAjustes.FieldByName('MER_CONCIL').AsInteger;

  FListaRegistrosRelatorio.Add(LRegistroRelatorio);
end;

procedure TConcilaRecebiveisMercadoLivre.GravaAjusteParaRegistrosCancelados;
  Var
    LFiltroAnterior: String;

    LRegistroRelatorio: TItensRelatorioCartoes;

    LCodigoEmpresa: String;
begin
  LFiltroAnterior := cdsConCar.Filter;

  cdsConCar.Filter := 'MER_VALLIQ < 0 AND ' +
                      'MER_TIPREG<>''withdrawal'' AND ' +
                      'MER_TIPREG<>''payout'' ';
  cdsConCar.Filtered := True;

  Try
    cdsConCar.First;
    While Not cdsConCar.Eof Do
    Begin
      If SomaDoShippingIDVendaIgualAZero(cdsConCar.FieldByName('MER_SHP_ID').AsString) Then
      Begin
        cdsConCar.Next;
        Continue;
      End;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LCodigoEmpresa := cdsConCar.FieldByName('CODEMP').Value;
      If LCodigoEmpresa.IsEmpty Then
        LCodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;

      {Gerando registro do relatório}
      LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
      LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
      LRegistroRelatorio.DescricaoAjuste := 'Débito de vendas canceladas - ' + cdsConcar.FieldByName('MER_CODAUT').AsString;
      LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('MER_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := LCodigoEmpresa;
      LRegistroRelatorio.CodigoEmpresa := LCodigoEmpresa;
      LRegistroRelatorio.NumeroNSU := cdsConCar.FieldByName('MER_SHP_ID').AsString;
      LRegistroRelatorio.CodigoAutorizacao := cdsConCar.FieldByName('MER_CODAUT').AsString;
      LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('MER_NUMVEN').AsString;
      LRegistroRelatorio.NumeroCartao := 'MERCADO LIVRE';

      LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';

      LRegistroRelatorio.Parcela := TMercadoLivreFuncoes.fStrZero(cdsConCar.FieldByName('MER_NUMPAR').AsString, 2);
      LRegistroRelatorio.TotalParcelas := TMercadoLivreFuncoes.fStrZero(cdsConCar.FieldByName('MER_TOTPAR').AsString, 2);
      LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('MER_DTAPAG').Value;
      LRegistroRelatorio.DataVenda := TMercadoLivreFuncoes.IIF(cdsConCar.FieldByName('MER_DTATRA').IsNull,
                                                               cdsConCar.FieldByName('MER_DTAPAG').Value,
                                                               cdsConCar.FieldByName('MER_DTATRA').Value);
      LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('MER_DTAPAG').Value;

      LRegistroRelatorio.ValorBruto := cdsConCar.FieldByName('MER_VALLIQ').Value;
      LRegistroRelatorio.ValorLiquido := cdsConCar.FieldByName('MER_VALLIQ').Value;

      LRegistroRelatorio.ValorTaxas := 0;
      LRegistroRelatorio.ValorFrete := 0;
      LRegistroRelatorio.ValorAjustes := 0;
      LRegistroRelatorio.ValorCupom := 0;

      LRegistroRelatorio.DescricaoBandeira := objConcil.NomeConciliacao;

      LRegistroRelatorio.Conciliado := cdsConCar.FieldByName('MER_CONCIL').AsInteger;

      GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, cdsConCar);

      cdsBaiCar.Edit;
      cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString  := fRetornaChaveConciliacao(cdsConCar);
      cdsBaiCar.Post;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      cdsConCar.Next;
    End;
  Finally
    cdsConCar.Filter := LFiltroAnterior;
    cdsConCar.Filtered := Not LFiltroAnterior.IsEmpty;
  End;
end;

procedure TConcilaRecebiveisMercadoLivre.GravaRegistroAjusteDeCompraFeitaPeloVendedorEDevolvida(
  AValorBruto, AValorLiquido: Double);
  Var
    LRegistroRelatorio: TItensRelatorioCartoes;

    LCodigoEmpresa: String;
begin
  LRegistroRelatorio := TItensRelatorioCartoes.Create;

  LCodigoEmpresa := cdsConCar.FieldByName('CODEMP').Value;
  If LCodigoEmpresa.IsEmpty Then
    LCodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;

  {Gerando registro do relatório}
  LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
  LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
  LRegistroRelatorio.DescricaoAjuste := 'payment';
  LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('MER_NOMARQ').AsString;
  LRegistroRelatorio.CodigoEstabelecimento := LCodigoEmpresa;
  LRegistroRelatorio.CodigoEmpresa := LCodigoEmpresa;
  LRegistroRelatorio.NumeroNSU := cdsConCar.FieldByName('MER_SHP_ID').AsString;
  LRegistroRelatorio.CodigoAutorizacao := cdsConCar.FieldByName('MER_CODAUT').AsString;
  LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('MER_NUMVEN').AsString;
  LRegistroRelatorio.NumeroCartao := 'MERCADO LIVRE';

  LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';

  LRegistroRelatorio.Parcela := TMercadoLivreFuncoes.fStrZero(cdsConCar.FieldByName('MER_NUMPAR').AsString, 2);
  LRegistroRelatorio.TotalParcelas := TMercadoLivreFuncoes.fStrZero(cdsConCar.FieldByName('MER_TOTPAR').AsString, 2);
  LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('MER_DTAPAG').Value;
  LRegistroRelatorio.DataVenda := TMercadoLivreFuncoes.IIF(cdsConCar.FieldByName('MER_DTATRA').IsNull,
                                                           cdsConCar.FieldByName('MER_DTAPAG').Value,
                                                           cdsConCar.FieldByName('MER_DTATRA').Value);
  LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('MER_DTAPAG').Value;

  LRegistroRelatorio.ValorBruto := AValorBruto;
  LRegistroRelatorio.ValorLiquido := AValorLiquido;

  LRegistroRelatorio.ValorTaxas := 0;
  LRegistroRelatorio.ValorFrete := 0;
  LRegistroRelatorio.ValorAjustes := 0;
  LRegistroRelatorio.ValorCupom := 0;

  LRegistroRelatorio.DescricaoBandeira := objConcil.NomeConciliacao;

  LRegistroRelatorio.Conciliado := cdsConCar.FieldByName('MER_CONCIL').AsInteger;

  GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, cdsConCar);

  cdsBaiCar.Edit;
  cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString := fRetornaChaveConciliacao(cdsConCar);
  cdsBaiCar.Post;

  FListaRegistrosRelatorio.Add(LRegistroRelatorio);
end;

function TConcilaRecebiveisMercadoLivre.fBuscaCartaoML: Boolean;
  Var
    LParcelaECommerce: String;
begin
  Result := False;

  Try
    LParcelaECommerce := TMercadoLivreFuncoes.fGetLetraAlfa(cdsConCar.FieldByName('MER_NUMPAR').AsInteger);
  Except
    LParcelaECommerce := 'A';
  End;

  If Not LParcelaECommerce.Equals('A') Then
  Begin
    If Not Result Then
      Result := cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_MARDES',
                                 VarArrayOf([UpperCase(cdsConCar.FieldByName(objConcil.CampoCodigoAutorizacao).AsString),
                                             LParcelaECommerce, 'D']),[]);

    If Not Result Then
      Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                                 VarArrayOf([UpperCase(cdsConCar.FieldByName(objConcil.CampoCodigoAutorizacao).AsString),
                                             LParcelaECommerce, 'D']),[]);

    Exit;
  End;

  If Not cdsConCar.FieldByName('MER_SHP_ID').AsString.IsEmpty Then
  Begin
    If Not Result Then
    Begin
      If Not cdsConCar.FieldByName('MER_ORD_ID').AsString.IsEmpty Then
        Result := cdsBaiCar.Locate('MCA_NUMNSU;MCA_ORDEID;MCA_MARDES',
                                   VarArrayOf([UpperCase(cdsConCar.FieldByName('MER_SHP_ID').AsString),
                                               UpperCase(cdsConCar.FieldByName('MER_ORD_ID').AsString), 'D']),[]);
    End;

    If Not Result Then
      Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                                  VarArrayOf([UpperCase(cdsConCar.FieldByName('MER_SHP_ID').AsString),
                                              'A', 'D']),[]);

    If Not Result Then
      Result := cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_MARDES',
                                 VarArrayOf([UpperCase(cdsConCar.FieldByName('MER_SHP_ID').AsString),
                                             'A', 'D']),[]);

    If Not Result Then
      Result := cdsBaiCar.Locate('MCA_ORDEID;PARDUP;MCA_MARDES',
                                 VarArrayOf([UpperCase(cdsConCar.FieldByName('MER_SHP_ID').AsString),
                                             'A', 'D']),[]);
  End;

  If Not Result Then
    Result := cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_MARDES',
                               VarArrayOf([UpperCase(cdsConCar.FieldByName(objConcil.CampoCodigoAutorizacao).AsString),
                                           'A', 'D']),[]);

  If Not Result Then
    Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                             VarArrayOf([UpperCase(cdsConCar.FieldByName(objConcil.CampoCodigoAutorizacao).AsString),
                                         'A', 'D']),[]);

  If Not Result Then
  Begin
    If Not cdsConCar.FieldByName('MER_CODAUT').AsString.Equals(cdsConCar.FieldByName('MER_SHP_ID').AsString) Then
      Exit;

    Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                               VarArrayOf([UpperCase(cdsConCar.FieldByName('MER_NUMVEN').AsString),
                                             'A', 'D']),[]);

    If Not Result Then
      Result := cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_MARDES',
                                 VarArrayOf([UpperCase(cdsConCar.FieldByName('MER_NUMVEN').AsString),
                                            'A', 'D']),[]);
  End;
end;

function TConcilaRecebiveisMercadoLivre.BuscaCartaoBaixadoMLOrderId: Boolean;
  Var
    LAutoIncremEncontrado: String;
begin
  Result := False;
  If cdsConCar.FieldByName('MER_ORD_ID').AsString.IsEmpty Then
    Exit;

  Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_ORDEID',
                              VarArrayOf([UpperCase(cdsConCar.FieldByName('MER_SHP_ID').AsString),
                                          UpperCase(cdsConCar.FieldByName('MER_ORD_ID').AsString)]),[]);

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_ORDEID',
                               UpperCase(cdsConCar.FieldByName('MER_ORD_ID').AsString),[]);

  If Not Result Then
    Exit;

  If FormatDateTime('dd/mm/yyyy', cdsBaixad.FieldByName('MCA_DTAREC').AsDateTime)
         .Equals(FormatDateTime('dd/mm/yyyy', cdsConCar.FieldByName('MER_DTAPAG').AsDateTime)) Then
    Exit;

  If cdsBaixad.FieldByName('MCA_CHACON').AsString.IsEmpty Then
    Exit;

  LAutoIncremEncontrado := cdsBaixad.FieldByName('AUTOINCREM').AsString;

  Result := cdsBaixad.Locate('MCA_ORDEID;MCA_DTAREC',
                              VarArrayOf([UpperCase(cdsConCar.FieldByName('MER_ORD_ID').AsString),
                                          cdsConCar.FieldByName('MER_DTAPAG').AsDateTime]),[]);

  If Not Result Then
  Begin
    FCadastrarNovaParcela := True;
    cdsBaixad.Locate('AUTOINCREM',
                      LAutoIncremEncontrado,[]);
  End;
end;

function TConcilaRecebiveisMercadoLivre.BuscaCartaoMLOrderId(var AValorBruto: Double;
  var AValorTaxa: Double; var AValorLiquido: Double): Boolean;
begin
  If cdsConCar.FieldByName('MER_ORD_ID').AsString.IsEmpty Then
    Exit(False);

  Result := cdsBaiCar.Locate('MCA_ORDEID;MCA_MARDES',
                              VarArrayOf([UpperCase(cdsConCar.FieldByName('MER_ORD_ID').AsString),
                                          'D']),[]);

  If Not Result Then
  Begin
    Result := cdsBaiCar.Locate('MCA_ORDEID;MCA_MARDES;ALTERAR_BRUTO',
                               VarArrayOf([UpperCase(cdsConCar.FieldByName('MER_ORD_ID').AsString),
                                          'M', 'S']),[]);

    If Not Result Then
      Exit;
  End;

  Result := ValidaValorBrutoELiquido(AValorBruto, AValorLiquido);

  If Not Result Then
    Result := ValidaTodosOsRegistrosAgupadosPorShippingIdQueContenhamOrderId(AValorBruto, AValorLiquido, AValorTaxa);
end;

function TConcilaRecebiveisMercadoLivre.BuscaCartaoMLOrderIdNaAutorizacao(var AValorBruto: Double;
  var AValorTaxa: Double; var AValorLiquido: Double): Boolean;
Begin
  If cdsConCar.FieldByName('MER_ORD_ID').AsString.IsEmpty Then
    Exit(False);

  Result := cdsBaiCar.Locate('MCA_NUMCCD;MCA_MARDES',
                              VarArrayOf([UpperCase(cdsConCar.FieldByName('MER_ORD_ID').AsString),
                                          'D']),[]);

  If Not Result Then
  Begin
    Result := cdsBaiCar.Locate('MCA_NUMCCD;MCA_MARDES;ALTERAR_BRUTO',
                               VarArrayOf([UpperCase(cdsConCar.FieldByName('MER_ORD_ID').AsString),
                                          'M', 'S']),[]);

    If Not Result Then
      Exit;
  End;

  Result := ValidaValorBrutoELiquido(AValorBruto, AValorLiquido);

  If Not Result Then
    Result := ValidaTodosOsRegistrosAgupadosPorShippingIdQueContenhamOrderIdNaAutorizacao(AValorBruto, AValorLiquido,AValorTaxa);
End;

function TConcilaRecebiveisMercadoLivre.CartaoMaquininhaDeveMarcarApenasUmaMOVCAR(ADatasetValidar: TDataset): Boolean;
  Var
    LTotalParcelas: Integer;

    LCampoNumeroDuplicata: String;
begin
  Result := True;

  If Not TryStrToInt(FDatasetMaquininhas.FieldByName('MER_TOTPAR').AsString, LTotalParcelas) Then
    Exit;

  If LTotalParcelas <= 1 Then
    Exit;

  LCampoNumeroDuplicata := 'NRODUP';
  If ADatasetValidar.FindField('NRODUP') = Nil Then
    LCampoNumeroDuplicata := 'MCA_NUMDUP';

  Try
    FCloneDatasetBaiCar.Filter := 'NRODUP=''' + ADatasetValidar.FieldByName(LCampoNumeroDuplicata).AsString + ''' AND ' +
                                  'MCA_CODEMP=''' + ADatasetValidar.FieldByName('MCA_CODEMP').AsString + ''' AND ' +
                                  'MCA_CODCLI=''' + ADatasetValidar.FieldByName('MCA_CODCLI').AsString + ''' AND ' +
                                  'MCA_NUMCCD=''' + ADatasetValidar.FieldByName('MCA_NUMCCD').AsString + ''' ';
    FCloneDatasetBaiCar.Filtered := True;

    If FCloneDatasetBaiCar.RecordCount = LTotalParcelas Then
      Exit(False);

    cdsBaixad.Filter := 'MCA_NUMDUP=''' + ADatasetValidar.FieldByName(LCampoNumeroDuplicata).AsString + ''' AND ' +
                        'MCA_CODEMP=''' + ADatasetValidar.FieldByName('MCA_CODEMP').AsString + ''' AND ' +
                        'MCA_CODCLI=''' + ADatasetValidar.FieldByName('MCA_CODCLI').AsString + ''' AND ' +
                        'MCA_NUMCCD=''' + ADatasetValidar.FieldByName('MCA_NUMCCD').AsString + ''' ';
    cdsBaixad.Filtered := True;

    Result := FCloneDatasetBaiCar.RecordCount + cdsBaixad.RecordCount = 1;
    If Not Result Then
      Result := FCloneDatasetBaiCar.RecordCount + cdsBaixad.RecordCount <> LTotalParcelas;
  Finally
    FCloneDatasetBaiCar.Filtered := False;
    cdsBaixad.Filtered := False;
    FCloneDatasetBaiCar.Filter := EmptyStr;
    cdsBaixad.Filter := EmptyStr;
  End;
end;

constructor TConcilaRecebiveisMercadoLivre.Create;
begin
  inherited;
  FUtilizaImportacaoPorEmpresa := VS_FuncoesExternas.fICfgSis('MEREMP',varBoolean);
  FIgnorarPaymentSemVenda := VS_FuncoesExternas.fICfgSis('MERCRE',varBoolean);
  FConsiderarValorFinancingFee := VS_FuncoesExternas.fICfgSis('MERFIN',varBoolean);

  //Para conciliação por Ponto de Venda
  objConcil.TabelaConciliacao := NOMTAB;
  objConcil.CampoEstabelecimento := 'MER_CODEST';
  objConcil.NomeConciliacao := 'MERCADO LIVRE';
  objConcil.CfgEstabelecimentos := 'CFG_MEREST';
  objConcil.CampoValorBruto := 'MER_VALPRO';
  objConcil.CampoValorLiquido := 'MER_VALLIQ';
  objConcil.CampoCodigoAutorizacao := 'MER_CODAUT';
  objConcil.CampoNumeroNSU := 'MER_SHP_ID';
  objConcil.CampoDataTransacaoVenda := 'MER_DTATRA';
  objConcil.CampoNumeroParcela := 'MER_NUMPAR';
  objConcil.CampoTotalParcelas := 'MER_TOTPAR';
  objConcil.CampoNumeroCartao := 'MER_SHP_ID';
  objConcil.CampoDataRecebimento := 'MER_DTAPAG';
  objConcil.CampoTipoRegistro := 'MER_TIPREG';
  objConcil.CampoTipoTransacao := 'MER_STATUS';
  objConcil.CfgPortadorAjustes := 'MERPOR';
  objConcil.CfgPlanoDeContasAjustes := 'MERCTA';
  objConcil.CfgFornecedorAjustes := 'MERFOR';
  objConcil.strEventoCancelamentoAjuste := 'MEREVE';

  objConcil.CfgPortadorTransferencia := 'MERTRF';
  objConcil.CfgPlanoDeContasTransferencia := 'MERCTF';
  objConcil.CfgCentroDeCustosTransferencia := 'MERETF';
  objConcil.CfgPlanoDeContasTransferenciaLancDeb := 'MERCTD';

  objConcil.strChavePrimaria := 'MER_TIPREG,MER_STATUS,MER_CODAUT,MER_DTATRA,MER_DTAPAG';

  FPossuiCampoCUPEFE := TMercadoLivreFuncoes.CampoExiste('MER_MLPGTO', 'MER_CUPEFE');

  FDatasetMaquininhas := Nil;
end;

destructor TConcilaRecebiveisMercadoLivre.Destroy;
begin
  If Assigned(FListaRegistrosConciliar) Then
    FreeAndNil(FListaRegistrosConciliar);

  TMercadoLivreFuncoes.FreeAndNilDatasets(FDatasetMaquininhas);
  inherited;
end;

function TConcilaRecebiveisMercadoLivre.EhRegistroDoTipoRefundPositivoApenasComValorDeFrete: Boolean;
begin
  If Not cdsAjustes.FieldByName('MER_TIPREG').AsString.Equals('refund') Then
    Exit(False);

  If cdsAjustes.FieldByName('MER_VALLIQ').AsFloat <= 0 Then
    Exit(False);

  If cdsAjustes.FieldByName('MER_VALENV').AsFloat <= 0 Then
    Exit(False);

  If cdsConCar.FieldByName('MER_VALENV').AsFloat >= 0 Then
    Exit(False);

  If cdsAjustes.FieldByName('MER_VALENV').AsFloat > Abs(cdsConCar.FieldByName('MER_VALENV').AsFloat) Then
    Exit(False);

  Result := True;
end;

function TConcilaRecebiveisMercadoLivre.EhRegistroDeRefundOuReserveForRefundPositivo: Boolean;
begin
  Result := False;

  If Not MatchStr(cdsAjustes.FieldByName('MER_TIPREG').AsString, ['reserve_for_refund', 'refund']) Then
    Exit;

  If cdsAjustes.FieldByName('MER_VALPRO').AsFloat <= 0 Then
    Exit;

  If EhRegistroDoTipoRefundPositivoApenasComValorDeFrete Then
    Exit;

  Result := True;
end;

function TConcilaRecebiveisMercadoLivre.EhRefundCompensadoPorAjusteCredito: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  //Pagamento sem pedido e sem tarifa (ex.: parte da compra paga com saldo do Mercado Pago) é gravado como
  //"ajuste_credito" na importação, e esse tipo não entra na conciliação. Cancelado no mesmo dia, o estorno
  //não encontra o "payment" para se compensar em AgruparERemoverRegistgrosDeFretesEAjustes e era lançado
  //sozinho como débito. Com o crédito do mesmo SOURCE_ID no dia somando zero, o par não gera lançamento,
  //como o cancelamento de qualquer outra venda
  Result := False;

  If Not cdsAjustes.FieldByName('MER_TIPREG').AsString.Equals('refund') Then
    Exit;

  If cdsAjustes.FieldByName('MER_VALLIQ').AsFloat >= 0 Then
    Exit;

  If cdsAjustes.FieldByName('MER_SHP_ID').AsString.IsEmpty Then
    Exit;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT IFNULL(SUM(MER_VALLIQ), 0) AS LIQUIDO ' +
                          'FROM ' + objConcil.TabelaConciliacao + ' ' +
                          'WHERE MER_TIPREG = "ajuste_credito" ' +
                          '  AND MER_STATUS = "release" ' +
                          '  AND MER_SHP_ID = :SHP_ID ' +
                          '  AND MER_NUMOPE = :NUMOPE ' +
                          '  AND MER_DTAPAG BETWEEN :DTAINI AND :DTAFIM ' +
                          RetornaFiltroEmpresa;
    LConsulta.ParamByName('SHP_ID').AsString := cdsAjustes.FieldByName('MER_SHP_ID').AsString;
    LConsulta.ParamByName('NUMOPE').AsString := cdsAjustes.FieldByName('MER_NUMOPE').AsString;
    LConsulta.ParamByName('DTAINI').AsDateTime := Trunc(cdsAjustes.FieldByName('MER_DTAPAG').AsDateTime);
    LConsulta.ParamByName('DTAFIM').AsDateTime := Trunc(cdsAjustes.FieldByName('MER_DTAPAG').AsDateTime) + EncodeTime(23, 59, 59, 0);
    LConsulta.Open;

    Result := TMercadoLivreFuncoes.fFormataFloat(LConsulta.FieldByName('LIQUIDO').AsFloat +
                                                 cdsAjustes.FieldByName('MER_VALLIQ').AsFloat, 2) = 0;
  Finally
    TMercadoLivreFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

function TConcilaRecebiveisMercadoLivre.EmpresaSQL: String;
begin
  Result := Concat('"', VS_FuncoesExternas.fIRetEmpresaLogada, '"');

  If FUtilizaImportacaoPorEmpresa Then
    Result := Concat(' IFNULL(MER_CODEMP,"',RetornaEmpresaFiltrada,'") ');
end;

function TConcilaRecebiveisMercadoLivre.fBuscaCartaoBaixadoML: Boolean;
  Var
    LParcelaECommerce: String;
begin
  Result := False;

  Try
    LParcelaECommerce := TMercadoLivreFuncoes.fGetLetraAlfa(cdsConCar.FieldByName('MER_NUMPAR').AsInteger);
  Except
    LParcelaECommerce := 'A';
  End;

  If Not LParcelaECommerce.Equals('A') Then
  Begin
    If Not Result Then
      Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL',
                                  VarArrayOf([UpperCase(cdsConCar.FieldByName(objConcil.CampoCodigoAutorizacao).AsString),
                                              LParcelaECommerce]),[]);

    If Not Result Then
      Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                                 VarArrayOf([UpperCase(cdsConCar.FieldByName(objConcil.CampoCodigoAutorizacao).AsString),
                                             LParcelaECommerce]),[]);

    blnAutomatica := (Result) And
                     (Not TMercadoLivreFuncoes.fEmptyStr(cdsBaixad.FieldbyName('MCA_CHACON').AsString));

    Exit;
  End;

  If Not Result Then
    Result := BuscaCartaoBaixadoMLOrderId;

  If Result Then
  Begin
    FTextoInconsistencia := 'Vendas já foram baixadas';
    blnAutomatica := Not TMercadoLivreFuncoes.fEmptyStr(cdsBaixad.FieldbyName('MCA_CHACON').AsString);
    Exit;
  End;

  If FCadastrarNovaParcela Then
    Exit(True);

  If Not cdsConCar.FieldByName('MER_SHP_ID').AsString.IsEmpty Then
  Begin
    Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                                VarArrayOf([UpperCase(cdsConCar.FieldByName('MER_SHP_ID').AsString),
                                            'A']),[]);

    If Not Result Then
      Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL',
                                 VarArrayOf([UpperCase(cdsConCar.FieldByName('MER_SHP_ID').AsString),
                                            'A']),[]);

    If Not Result Then
      Result := cdsBaixad.Locate('MCA_ORDEID;MCA_PARCEL',
                                 VarArrayOf([UpperCase(cdsConCar.FieldByName('MER_SHP_ID').AsString),
                                             'A', 'D']),[]);
  End;

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL',
                               VarArrayOf([UpperCase(cdsConCar.FieldByName(objConcil.CampoCodigoAutorizacao).AsString),
                                           'A']),[]);

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                             VarArrayOf([UpperCase(cdsConCar.FieldByName(objConcil.CampoCodigoAutorizacao).AsString),
                                         'A']),[]);

  If Not Result Then
  Begin
    If Not cdsConCar.FieldByName('MER_CODAUT').AsString.Equals(cdsConCar.FieldByName('MER_SHP_ID').AsString) Then
      Exit;

    Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                               VarArrayOf([UpperCase(cdsConCar.FieldByName('MER_NUMVEN').AsString),
                                           'A']),[]);

    If Not Result Then
      Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL',
                                 VarArrayOf([UpperCase(cdsConCar.FieldByName('MER_NUMVEN').AsString),
                                            'A']),[]);
  End;

  blnAutomatica := (Result) And
                   (Not TMercadoLivreFuncoes.fEmptyStr(cdsBaixad.FieldbyName('MCA_CHACON').AsString));
end;

procedure TConcilaRecebiveisMercadoLivre.pFiltraCartoesML;
  Var
    strSQL: String;

    qryBaiCar: TUniQuery;
begin
  FCartaoMercadoLivre := VS_FuncoesExternas.fICfgSis('MERCAR');
  If FCartoesMaquininhas.Length >= 5 Then
    FCartaoMercadoLivre := FCartaoMercadoLivre + FCartoesMaquininhas;

  FListaDePedidos := RetornaListaDePedidos;

  strSQL := TLibCartoesMovCar.fGetSQLCartoes(objConcil);

  If Not FCartaoMercadoLivre.IsEmpty Then
    strSQL := strSQL + ' AND MCA_CODCAR IN (' + TMercadoLivreFuncoes.fRetStrToSQLIn(FCartaoMercadoLivre) + ') ';

  strSQL := strSQL + ' AND ('+
                       ' (MCA_NUMNSU IN (' + FListaDePedidos + ')) OR '+
                       ' (MCA_NUMCCD IN (' + FListaDePedidos + ')) OR '+
                       ' (MCA_ORDEID IN (' + FListaDePedidos + ')) '+
                     ') ';

  strSQL := strSQL + ' ORDER BY MCA_NUMNSU,MCA_NUMCCD,MCA_CODEMP,PARDUP,MCA_DTACUP,MCA_NUMDUP) AS TMP ';

  qryBaiCar := Nil;
  Try
    qryBaiCar := VS_FuncoesExternas.fICriaQuery;
    qryBaiCar.SQL.Text := strSQL;
    qryBaiCar.Options.SetFieldsReadOnly := False;
    qryBaiCar.Open;

    cdsBaiCar := TMercadoLivreFuncoes.CriarClientDataSet(qryBaiCar);
    cdsBaiCar.IndexFieldNames := 'MCA_NUMNSU;MCA_NUMCCD;MCA_CODEMP;PARDUP;MCA_DTACUP;MCA_NUMDUP';
    cdsBaiCar.Open;
  Finally
    TMercadoLivreFuncoes.FreeAndNilDatasets(qryBaiCar);
  End;
end;

procedure TConcilaRecebiveisMercadoLivre.pGravaAjustesDeRetiradas;
  Var
    LRegistroRelatorio: TItensRelatorioCartoes;

    LCodigoEmpresa: String;

    LDiasCredito: Integer;
begin
  LDiasCredito := StrToIntDef(VS_FuncoesExternas.fICfgSis('MERDIA', varString), 0);

  qryWithDrawal.Filter   := 'MER_TIPREG=' + 'withdrawal'.QuotedString;
  qryWithDrawal.Filtered := True;
  qryWithDrawal.First;

  While Not qryWithdrawal.Eof Do
  Begin
    If TMercadoLivreFuncoes.fFormataFloat(qryWithDrawal.FieldByName('MER_VALPLA').AsFloat, 2) <> 0 Then
    Begin
      LCodigoEmpresa := qryWithDrawal.FieldByName('CODEMP').Value;
      If LCodigoEmpresa.IsEmpty Then
        LCodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      {Gerando registro do relatório}
      LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
      LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
      LRegistroRelatorio.DescricaoAjuste := 'Taxa de Retirada';
      LRegistroRelatorio.NomeArquivo := qryWithDrawal.FieldByName('MER_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := LCodigoEmpresa;
      LRegistroRelatorio.CodigoEmpresa := LCodigoEmpresa;
      LRegistroRelatorio.NumeroNSU := '00000000000000';
      LRegistroRelatorio.CodigoAutorizacao := '00000000000000';
      LRegistroRelatorio.ResumoVenda := '00000000000000';
      LRegistroRelatorio.NumeroCartao := 'MERCADO LIVRE';

      LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';

      LRegistroRelatorio.Parcela := TMercadoLivreFuncoes.fStrZero(qryWithDrawal.FieldByName('MER_NUMPAR').AsString, 2);
      LRegistroRelatorio.TotalParcelas := TMercadoLivreFuncoes.fStrZero(qryWithDrawal.FieldByName('MER_TOTPAR').AsString, 2);
      LRegistroRelatorio.DataPagamento := VS_FuncoesExternas.fIAcertaDataParaDiaUtil(qryWithDrawal.FieldByName('MER_DTAPAG').Value + LDiasCredito);
      LRegistroRelatorio.DataVenda := TMercadoLivreFuncoes.IIF(qryWithDrawal.FieldByName('MER_DTATRA').IsNull,
                                                               qryWithDrawal.FieldByName('MER_DTAPAG').Value,
                                                               qryWithDrawal.FieldByName('MER_DTATRA').Value);
      LRegistroRelatorio.DataVencimento := qryWithDrawal.FieldByName('MER_DTAPAG').Value;

      LRegistroRelatorio.ValorBruto := qryWithDrawal.FieldByName('MER_VALPLA').Value;
      LRegistroRelatorio.ValorLiquido := qryWithDrawal.FieldByName('MER_VALPLA').Value;

      LRegistroRelatorio.DescricaoBandeira := objConcil.NomeConciliacao;

      LRegistroRelatorio.Conciliado := qryWithDrawal.FieldByName('MER_CONCIL').Value;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      If LRegistroRelatorio.Conciliado = 0 Then
      Begin
        FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(qryWithDrawal));

        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, False, qryWithdrawal);
      End;
    End;

    qryWithdrawal.Next;
  End;
end;

function TConcilaRecebiveisMercadoLivre.ProcessaRegistrosMaquininhas(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    LValorBruto,
    LValorLiquido: Double;

    LChaveConciliacao,
    LCodigoAutorizacao,
    LNumeroNSU,
    LParcela: String;

    LBuscaCartao,
    LPossuiRegistros : Boolean;

    LRegistroRelatorio: TItensRelatorioCartoes;

    LConsulta: TUniQuery;

    LValorTaxa: Double;

    LDataTransacao: TDate;
begin
  If (FCartoesMaquininhas.Length < 5) Or (Not TMercadoLivreFuncoes.FCampoMER_NUMNSUExiste.Equals('S')) Then
    Exit(False);

  FValorAjusteIgnorado := 0;

  Application.ProcessMessages;

  pgbStatus.Visible := False;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := RetornaSQLConciliacaoMaquininhas;

    LConsulta.Open;

    TMercadoLivreFuncoes.FreeAndNilDatasets(FCloneDatasetMaquininhas);
    FDatasetMaquininhas := TMercadoLivreFuncoes.CriarClientDataSet(LConsulta);

    FCloneDatasetMaquininhas := TMercadoLivreFuncoes.CriarClientDataSet(FDatasetMaquininhas);
  Finally
    TMercadoLivreFuncoes.FreeAndNilDatasets(LConsulta);
  End;

  pgbStatus.Visible := False;

  LPossuiRegistros := (FDatasetMaquininhas.RecordCount + cdsConCar.RecordCount + cdsAjustes.Recordcount) > 0;
  If Not LPossuiRegistros Then
  Begin
    TMercadoLivreFuncoes.fMensagem('ATENÇÃO','Não existem arquivos importados nesse período de recebimento!',['&OK']);
    blnReabre := True;
    Exit(False);
  End;

  If Not Assigned(FRelatorioConciliacao) Then
    FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                          'MERCADO LIVRE',
                                                          'CONCILIACAO',
                                                          RetornaFiltrosdigitados,
                                                          TMercadoLivreFuncoes.RetornaDataHoraServidor,
                                                          TMercadoLivreFuncoes.RetornaHoraServidor);

  Try
    pgbStatus.Visible := True;
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := FDatasetMaquininhas.RecordCount;

    FDatasetMaquininhas.First;
    While Not FDatasetMaquininhas.EOF do
    Begin
      FCadastrarNovaParcela := False;

      TMercadoLivreFuncoes.pStepStatusGravacao(pgbStatus);

      FTextoInconsistencia := EmptyStr;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LCodigoAutorizacao := TMercadoLivreFuncoes.fStrZero(Trim(FDatasetMaquininhas.FieldByName('MER_CODAUT').AsString), 6);
      LNumeroNSU := TMercadoLivreFuncoes.fStrZero(Trim(RightStr(FDatasetMaquininhas.FieldByName('MER_NUMNSU').AsString, 14)), 14);
      LValorBruto := FDatasetMaquininhas.FieldByName('VALOR_BRUTO').Value;
      LValorLiquido := FDatasetMaquininhas.FieldByName('MER_VALLIQ').Value;
      LValorTaxa := RetornaValorTaxaRegistro(FDatasetMaquininhas);

      LParcela := 'A';

      LDataTransacao := EncodeDate(StrToInt(FormatDateTime('yyyy', FDatasetMaquininhas.FieldByName('MER_DTATRA').AsDateTime)),
                                   StrToInt(FormatDateTime('mm', FDatasetMaquininhas.FieldByName('MER_DTATRA').AsDateTime)),
                                   StrToInt(FormatDateTime('dd', FDatasetMaquininhas.FieldByName('MER_DTATRA').AsDateTime)));

      LBuscaCartao := fBuscaCartao(LCodigoAutorizacao,
                                   LNumeroNSU,
                                   FDatasetMaquininhas.FieldByName('CODEMP').AsString,
                                   LParcela,
                                   LDataTransacao);

      If LBuscaCartao Then
      Begin
        LChaveConciliacao := INICAM + FDatasetMaquininhas.FieldByName('MER_CODAUT').AsString + '_' +
                             cdsBaiCar.FieldByName('PARDUP').AsString + '_' +
                             cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                             FormatDateTime('yyyy-mm-dd', FDatasetMaquininhas.FieldByName('MER_DTATRA').Value);

        If CartaoMaquininhaDeveMarcarApenasUmaMOVCAR(cdsBaiCar) Then
        Begin
          MarcarCartaoEncontradoArquivo(LValorBruto,
                                        LValorLiquido,
                                        LRegistroRelatorio,
                                        LChaveConciliacao,
                                        FDatasetMaquininhas,
                                        0,
                                        Abs(FDatasetMaquininhas.FieldByName('REGISTROAJUSTE').AsFloat),
                                        Abs(LValorTaxa),
                                        0);

          LRegistroRelatorio.Conciliado := 0;
        End
        Else
        Begin
          SelecionaMultiplasParcelasMaquininasMovCar(LValorBruto,
                                                     LValorLiquido,
                                                     Abs(LValorTaxa),
                                                     Abs(FDatasetMaquininhas.FieldByName('REGISTROAJUSTE').AsFloat),
                                                     LRegistroRelatorio,
                                                     FDatasetMaquininhas,
                                                     False);

          FDatasetMaquininhas.Next;
          Continue;
        End;
      End
      Else
      Begin
        blnAutomatica := FDatasetMaquininhas.FieldByName('MER_CONCIL').AsString.Equals('1');

        cdsBaixad.First;
        LBuscaCartao := fBuscaCartaoBaixado(LCodigoAutorizacao,
                                            LNumeroNSU,
                                            FDatasetMaquininhas.FieldByName('CODEMP').AsString,
                                            LParcela,
                                            LDataTransacao);

        FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';

        If LBuscaCartao Then
        Begin
          If CartaoMaquininhaDeveMarcarApenasUmaMOVCAR(cdsBaixad) Then
          Begin
            FTextoInconsistencia := 'Cartão já foi baixado';
            LRegistroRelatorio.InconsistenciaConciliada := 'S';
            LRegistroRelatorio.Conciliado := 1;
            LRegistroRelatorio.AutoIncremMovCar := cdsBaixad.FieldByName('AUTOINCREM').AsString;
          End
          Else
          Begin
            SelecionaMultiplasParcelasMaquininasMovCar(LValorBruto,
                                                       LValorLiquido,
                                                       Abs(LValorTaxa),
                                                       Abs(FDatasetMaquininhas.FieldByName('REGISTROAJUSTE').AsFloat),
                                                       LRegistroRelatorio,
                                                       FDatasetMaquininhas,
                                                       True);

            FDatasetMaquininhas.Next;
            Continue;
          End;
        End;
      End;

      {Gerando registro do relatório}
      FTextoInconsistencia := RetornaTextoInconsistenciaMaquininhaAtualizado(FTextoInconsistencia);
      If Not FTextoInconsistencia.IsEmpty Then
      Begin
        LRegistroRelatorio.Descricao := FTextoInconsistencia;
        If Not LRegistroRelatorio.InconsistenciaConciliada.Equals('S') Then
          LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
      End;
      LRegistroRelatorio.NomeArquivo := FDatasetMaquininhas.FieldByName('MER_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := FDatasetMaquininhas.FieldByName('CODEMP').AsString;
      LRegistroRelatorio.CodigoEmpresa := FDatasetMaquininhas.FieldByName('CODEMP').AsString;
      If LRegistroRelatorio.CodigoEmpresa.IsEmpty Then
      Begin
        LRegistroRelatorio.CodigoEstabelecimento := VS_FuncoesExternas.fIRetEmpresaLogada;
        LRegistroRelatorio.CodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;
      End;

      LRegistroRelatorio.NumeroNSU := LNumeroNSU;
      LRegistroRelatorio.CodigoAutorizacao := LCodigoAutorizacao;
      LRegistroRelatorio.ResumoVenda := FDatasetMaquininhas.FieldByName('MER_NUMVEN').AsString;
      LRegistroRelatorio.NumeroCartao := FDatasetMaquininhas.FieldByName('MER_NUMCAR').AsString;

      LRegistroRelatorio.TipoCartao := 'CRÉDITO ROTATIVO';

      LRegistroRelatorio.Parcela := TMercadoLivreFuncoes.fStrZero(FDatasetMaquininhas.FieldByName('MER_NUMPAR').AsString, 2);
      LRegistroRelatorio.TotalParcelas := TMercadoLivreFuncoes.fStrZero(FDatasetMaquininhas.FieldByName('MER_NUMPAR').AsString, 2);
      LRegistroRelatorio.DataPagamento := FDatasetMaquininhas.FieldByName('MER_DTAPAG').Value;
      LRegistroRelatorio.DataVenda := FDatasetMaquininhas.FieldByName('MER_DTATRA').Value;
      LRegistroRelatorio.DataVencimento := FDatasetMaquininhas.FieldByName('MER_DTAPAG').Value;

      LRegistroRelatorio.ValorBruto := LValorBruto;

      LRegistroRelatorio.ValorLiquido := LValorLiquido;
      LRegistroRelatorio.ValorTaxas := LValorTaxa;
      LRegistroRelatorio.ValorFrete := 0;
      LRegistroRelatorio.ValorAjustes := Abs(FDatasetMaquininhas.FieldByName('REGISTROAJUSTE').AsFloat);
      LRegistroRelatorio.ValorCupom := 0;

      LRegistroRelatorio.DescricaoBandeira := fRetNomBandeira(LRegistroRelatorio.NumeroCartao);

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      If LRegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, False, FDatasetMaquininhas);

      FDatasetMaquininhas.Next;
    End;
  Except
    Raise;
  End;
  Result := True;
end;

function TConcilaRecebiveisMercadoLivre.FiltraCancelamentosML(prgStatus: TcxProgressBar): Boolean;
  Var
    LSQL,
    LEmpresaConfiguracao: String;

    LConsultaAjustes: TUniQuery;

    LAjusteCredito,
    LSairWhile: Boolean;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  LConsultaAjustes := Nil;
  Try
    LConsultaAjustes := VS_FuncoesExternas.fICriaQuery;
    LSQL := 'SELECT * FROM (';
    LSQL := LSQL + 'SELECT *, ';
    LSQL := LSQL + '       MER_TIPREG AS TIPAJU, ';
    LSQL := LSQL + '       IF(MER_VALLIQ > 0, MER_VALLIQ, 0) AS AJUCRE, ';
    LSQL := LSQL + EmpresaSQL + ' AS EMPRESA ';
    LSQL := LSQL + ' FROM ' + objConcil.TabelaConciliacao + ' A ';
    LSQL := LSQL + ' WHERE ' + FCondicaoAjustes;
    LSQL := LSQL + ' AND MER_DTASTR IS NOT NULL ';

    LSQL := LSQL + ' UNION ';
    LSQL := LSQL + 'SELECT *, ';
    LSQL := LSQL + '       MER_TIPREG AS TIPAJU, ';
    LSQL := LSQL + '       IF(MER_VALLIQ > 0, MER_VALLIQ, 0) AS AJUCRE, ';
    LSQL := LSQL + EmpresaSQL + ' AS EMPRESA ';
    LSQL := LSQL + ' FROM ' + objConcil.TabelaConciliacao + ' A ';
    LSQL := LSQL + ' WHERE MER_SHP_ID IN (' + FListaDePedidos + ') AND MER_CONCIL=0 AND MER_TIPREG<>"PAYMENT" ';
    LSQL := LSQL + ' AND MER_STATUS = "release" ';
    LSQL := LSQL + ' AND MER_DTAPAG<="' + FormatDateTime('yyyy-mm-dd hh:mm:ss', StrToDateTime(strDtaFim + ' 23:59:59')) + '" ';
    LSQL := LSQL + ' AND MER_DTASTR IS NOT NULL ';
    LSQL := LSQL + TMercadoLivreFuncoes.IIF(FUtilizaImportacaoPorEmpresa,' AND ' + FCondicaoAjustes, RetornaFiltroEmpresa);
    LSQL := LSQL + ') AS TMP ';
    LSQL := LSQL + ' WHERE NOT ' + RetornaCondicaoFreteRecebidoComoVenda('TMP');

    LSQL := LSQL + ' ORDER BY MER_SHP_ID, MER_TIPREG, MER_DTAPAG';

    LConsultaAjustes.SQL.Text := LSQL;
    LConsultaAjustes.Open;

    cdsAjustes := TMercadoLivreFuncoes.CriarClientDataSet(LConsultaAjustes);
    cdsAjustes.Open;
  Finally
    TMercadoLivreFuncoes.FreeAndNilDatasets(LConsultaAjustes);
  End;

  prgStatus.Position := 0;
  prgStatus.Properties.Max := cdsAjustes.RecordCount;

  cdsAjustes.First;
  While Not cdsAjustes.Eof Do
  Begin
    TMercadoLivreFuncoes.pStepStatusGravacao(prgStatus);

    If MatchStr(cdsAjustes.FieldByName('MER_TIPREG').AsString.ToUpperInvariant, ['PAYOUT', 'WITHDRAWAL']) Then
    Begin
      cdsAjustes.Delete;
      Continue;
    End;

    LSairWhile := cdsAjustes.RecNo = cdsAjustes.RecordCount;
    If AgruparERemoverRegistgrosDeFretesEAjustes Then
    Begin
      FListaRegistrosAjustesAgrupados.Add(fRetornaChaveConciliacao(cdsAjustes) + '|' + cdsAjustes.FieldByName('MER_SHP_ID').AsString);

      cdsAjustes.Delete;

      If LSairWhile Then
        Break;

      Continue;
    End;

    If EhRefundCompensadoPorAjusteCredito Then
    Begin
      cdsAjustes.Next;

      Continue;
    End;

    If TMercadoLivreFuncoes.fFormataFloat(cdsAjustes.FieldByName('MER_VALLIQ').AsFloat, 2) = 0.00 Then
    Begin
      If FConciliarPedidosZerados Then
      Begin
        cdsAjustes.Next;

        Continue;
      End;
    End;

    If Not ValidaDataDoAjuste(cdsAjustes.FieldByName('MER_DTAPAG').AsDateTime) Then
    Begin
      cdsAjustes.Next;

      Continue;
    End;

    If SomaDoShippingIDVendaIgualAZero(cdsAjustes.FieldByName('MER_SHP_ID').AsString) Then
    Begin
      cdsConCar.Locate('MER_SHP_ID;MER_TIPREG',
                       VarArrayOf([cdsAjustes.FieldByName('MER_SHP_ID').AsString, 'payment']),
                       []);
      If AjustePossuiAMesmaDataDePagamentoDaLiberacaoDaVenda(cdsConcar, cdsAjustes) Then
      Begin
        cdsAjustes.Next;

        Continue;
      End
      Else
        FDatasetShippingZerado.Delete;
    End;

    If GeraRegistroBlockUnblock Then
    Begin
      cdsAjustes.Next;

      Continue;
    End;

    LRegistroRelatorio := TItensRelatorioCartoes.Create;
    LAjusteCredito := TMercadoLivreFuncoes.fFormataFloat(cdsAjustes.FieldByName('AJUCRE').Value, 2) <> 0;

    LEmpresaConfiguracao := cdsAjustes.FieldByName('EMPRESA').AsString;
    If LEmpresaConfiguracao.IsEmpty Then
      LEmpresaConfiguracao := VS_FuncoesExternas.fIRetEmpresaLogada;

    LRegistroRelatorio.ValorBruto := TMercadoLivreFuncoes.fFormataFloat(cdsAjustes.FieldByName(objConcil.CampoValorLiquido).AsFloat, 2);
    LRegistroRelatorio.ValorLiquido := TMercadoLivreFuncoes.fFormataFloat(cdsAjustes.FieldByName(objConcil.CampoValorLiquido).AsFloat, 2);
    If LAjusteCredito Then
    Begin
      LRegistroRelatorio.ValorBruto := Abs(LRegistroRelatorio.ValorBruto);
      LRegistroRelatorio.ValorLiquido := Abs(LRegistroRelatorio.ValorLiquido);
    End;

    LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
    LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
    LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';
    LRegistroRelatorio.DescricaoAjuste := cdsAjustes.FieldByName('TIPAJU').AsString;

    LRegistroRelatorio.CodigoEmpresa := LEmpresaConfiguracao;
    LRegistroRelatorio.CodigoEstabelecimento := LEmpresaConfiguracao;
    LRegistroRelatorio.NumeroNSU := cdsAjustes.FieldByName('MER_SHP_ID').AsString;
    LRegistroRelatorio.NumeroCartao := cdsAjustes.FieldByName(objConcil.CampoCodigoAutorizacao).AsString;
    LRegistroRelatorio.Parcela := LeftStr(cdsAjustes.FieldByName(objConcil.CampoNumeroParcela).AsString, 2);
    LRegistroRelatorio.TotalParcelas := RightStr(cdsAjustes.FieldByName(objConcil.CampoNumeroParcela).AsString, 2);
    LRegistroRelatorio.CodigoAutorizacao := TMercadoLivreFuncoes.IIF(TMercadoLivreFuncoes.fStrZero(cdsAjustes.FieldByName('MER_SHP_ID').AsString, 1) <> '0',
                                                                     cdsAjustes.FieldByName('MER_SHP_ID').AsString,
                                                                     '00000000000000');

    LRegistroRelatorio.DataVenda := cdsAjustes.FieldByName('MER_DTAPAG').Value;
    LRegistroRelatorio.DataPagamento := cdsAjustes.FieldByName('MER_DTAPAG').Value;

    LRegistroRelatorio.Conciliado := cdsAjustes.FieldByName('MER_CONCIL').AsInteger;
    LRegistroRelatorio.NomeArquivo := cdsAjustes.FieldByName('MER_NOMARQ').AsString;

    LRegistroRelatorio.RegistroIncompleto := 'N';
    LRegistroRelatorio.RegistroIncompleto := ConfiguracoesAjustesEstaoIncompletas(LEmpresaConfiguracao);

    GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);

    FListaRegistrosRelatorio.Add(LRegistroRelatorio);

    cdsAjustes.Next;
  End;

  Result := True;
end;

procedure TConcilaRecebiveisMercadoLivre.pFiltraCartoesBaixadosML;
  Var
    strSQL   : String;
    qryBaixad: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT MCA_NUMCCD, MCA_PARCEL, MCA_DTAREC, MCA_NUMNSU, ';
  strSQL := strSQL + '        AUTOINCREM, MCA_NUMDUP, MCA_DTACUP, MCA_DTAREC, ';
  strSQL := strSQL + '        IFNULL(MCA_ORDEID, MCA_NUMPOK) AS MCA_ORDEID, ';
  strSQL := strSQL + '        MCA_CODEMP, MCA_DTAVEN, MCA_EMPRCX, MCA_CHACON, ';
  strSQL := strSQL + '        MCA_CODCLI ';
  strSQL := strSQL + ' FROM MOVCAR ';
  strSQL := strSQL + ' WHERE ';

  If Not FCartaoMercadoLivre.IsEmpty Then
    strSQL := strSQL + ' MCA_CODCAR IN (' + TMercadoLivreFuncoes.fRetStrToSQLIn(FCartaoMercadoLivre) + ') AND ';

  strSQL := strSQL + ' (MCA_NUMNSU IN (' + FListaDePedidos + ') OR '+
                     '  MCA_NUMCCD IN (' + FListaDePedidos + ') OR '+
                     '  MCA_ORDEID IN (' + FListaDePedidos + ')) ';

  strSQL := strSQL + ' AND MCA_DTAREC IS NOT NULL ';
  strSQL := strSQL + ' ORDER BY MCA_NUMNSU, MCA_PARCEL,MCA_CODEMP ';

  qryBaixad := Nil;
  Try
    qryBaixad := VS_FuncoesExternas.fICriaQuery;
    qryBaixad.SQL.Text := strSQL;
    qryBaixad.Open;
    cdsBaixad := TMercadoLivreFuncoes.CriarClientDataSet(qryBaixad);
    cdsBaixad.Open;

    cdsBaixad.IndexFieldNames := 'MCA_NUMNSU;MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_CODEMP';
  Finally
    TMercadoLivreFuncoes.FreeAndNilDatasets(qryBaixad);
  End;
end;

procedure TConcilaRecebiveisMercadoLivre.AbreDatasetShippingZerado;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT MER_SHP_ID, ' +
                          '       SUM(IF(MER_TIPREG="payment", 1, 0)) AS PAYMENTS, ' +
                          '       SUM(MER_VALLIQ) AS LIQUIDO ' +
                          'FROM MER_MLPGTO ' +
                          'WHERE MER_DTAPAG ' + FPeriodoFiltro +
                          '  AND MER_STATUS="release" ' +
                          '  AND (MER_ORD_ID IS NOT NULL AND MER_ORD_ID<>"") ' +
                          RetornaFiltroEmpresa +
                          'GROUP BY MER_SHP_ID ' +
                          'HAVING SUM(IF(MER_TIPREG="payment", 1, 0)) > 0 ' +
                          '   AND SUM(MER_VALLIQ) = 0';

    LConsulta.Open;

    If Assigned(FDatasetShippingZerado) Then
      FreeAndNil(FDatasetShippingZerado);

    FDatasetShippingZerado := TMercadoLivreFuncoes.CriarClientDataSet(LConsulta);
  Finally
    TMercadoLivreFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

procedure TConcilaRecebiveisMercadoLivre.AdicionaAjustesAgrupadosParaConciliar;
  Var
    LAjuste: String;

    LValores,
    LListaRemover: TStringList;

    LIndice: Integer;
begin
  LValores := Nil;
  LListaRemover := Nil;
  Try
    LValores := TStringList.Create;
    LValores.Delimiter := '|';
    LValores.StrictDelimiter := True;

    LListaRemover := TStringList.Create;

    For LAjuste In FListaRegistrosAjustesAgrupados Do
    Begin
      LValores.DelimitedText := LAjuste;

      If cdsConCar.FieldByName('MER_SHP_ID').AsString = LValores[LValores.Count - 1] Then
      Begin
        FListaRegistrosConciliar.Add(LAjuste);

        LListaRemover.Add(LAjuste);
      End;
    End;

    For LAjuste In LListaRemover Do
    Begin
      LIndice := FListaRegistrosAjustesAgrupados.IndexOf(LAjuste);

      FListaRegistrosAjustesAgrupados.Delete(LIndice);
    End;
  Finally
    If Assigned(LListaRemover) Then
      FreeAndNil(LListaRemover);

    If Assigned(LValores) Then
      FreeAndNil(LValores);
  End;
end;

function TConcilaRecebiveisMercadoLivre.AgruparERemoverRegistgrosDeFretesEAjustes: Boolean;
begin
  Result := Not cdsAjustes.FieldByName('MER_SHP_ID').AsString.IsEmpty;

  If Not Result Then
    Exit;

  If MatchStr(cdsAjustes.FieldByName('MER_STATUS').AsString, ['block', 'unblock']) Then
    Exit(False);

  If cdsAjustes.FieldByName('MER_TIPREG').AsString.Equals('reserve_for_debt_payment') Then
    Exit(False);

  Result := cdsConCar.Locate('MER_SHP_ID;MER_ORD_ID;MER_TIPREG',
                              VarArrayOf([cdsAjustes.FieldByName('MER_SHP_ID').AsString,
                                          cdsAjustes.FieldByName('MER_ORD_ID').AsString,
                                          'payment']),
                              []);

  If Not Result Then
    Result := cdsConCar.Locate('MER_SHP_ID;MER_TIPREG',
                                VarArrayOf([cdsAjustes.FieldByName('MER_SHP_ID').AsString,
                                           'payment']),
                                []);

  If Result Then
  Begin

    If cdsAjustes.FieldByName('MER_TIPREG').AsString.Equals('shipping') And
       (TMercadoLivreFuncoes.fFormataFloat(cdsConCar.FieldByName('MER_VALLIQ').AsFloat, 2) = 0) And
       (TMercadoLivreFuncoes.fFormataFloat(cdsAjustes.FieldByName('MER_VALLIQ').Value, 2) > 0) Then
    begin
      Exit(False);
    end;

    If Not AjustePossuiAMesmaDataDePagamentoDaLiberacaoDaVenda(cdsConcar, cdsAjustes) Then
      Exit(False);

    cdsConCar.Edit;

    cdsConCar.FieldByName('MER_VALLIQ').Value := TMercadoLivreFuncoes.fFormataFloat(cdsConCar.FieldByName('MER_VALLIQ').Value +
                                                                                    cdsAjustes.FieldByName('MER_VALLIQ').Value, 2);

    If cdsAjustes.FieldByName('MER_TIPREG').AsString = 'shipping' Then
    Begin
      If cdsAjustes.FieldByName('MER_VALPRO').Value > 0 Then
      Begin
        If cdsAjustes.FieldByName('MER_CODAUT').AsString.ToUpper.Contains('CASHBACK_') Then
        Begin
          cdsConCar.FieldByName('VALOR_BRUTO').Value := TMercadoLivreFuncoes.fFormataFloat(cdsConCar.FieldByName('VALOR_BRUTO').AsFloat +
                                                                                           cdsAjustes.FieldByName('MER_VALPRO').Value, 2);

          cdsConCar.FieldByName('CUPOMDESCONTO').Value := TMercadoLivreFuncoes.fFormataFloat(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat +
                                                                                             cdsAjustes.FieldByName('MER_VALPRO').Value, 2);
          
          cdsConCar.Post;

          Exit(True);
        End;

        cdsConCar.FieldByName('VALOR_BRUTO').Value := TMercadoLivreFuncoes.fFormataFloat(cdsConCar.FieldByName('VALOR_BRUTO').Value +
                                                                                         cdsAjustes.FieldByName('MER_VALPRO').Value, 2);
        cdsConCar.FieldByName('REGISTROFRETE').Value := TMercadoLivreFuncoes.fFormataFloat(cdsConCar.FieldByName('REGISTROFRETE').Value +
                                                                                           (cdsAjustes.FieldByName('MER_VALLIQ').Value -
                                                                                            cdsAjustes.FieldByName('MER_VALPRO').Value), 2);

        //Campos de casos fulfillment
        cdsConCar.FieldByName('REGISTROFRETELIQUIDO').Value := TMercadoLivreFuncoes.fFormataFloat(Abs(cdsAjustes.FieldByName('MER_VALLIQ').Value), 2);
        cdsConCar.FieldByName('SOBRAFRETE').Value := TMercadoLivreFuncoes.fFormataFloat(Abs(cdsAjustes.FieldByName('MER_VALPRO').Value), 2);
      End
      Else
        cdsConCar.FieldByName('REGISTROFRETE').Value := TMercadoLivreFuncoes.fFormataFloat(cdsConCar.FieldByName('REGISTROFRETE').Value +
                                                                                           cdsAjustes.FieldByName('MER_VALLIQ').Value, 2);
    End
    Else If EhRegistroDeRefundOuReserveForRefundPositivo Then
    Begin
      cdsConCar.FieldByName('VALOR_BRUTO').Value := TMercadoLivreFuncoes.fFormataFloat(cdsConCar.FieldByName('VALOR_BRUTO').AsFloat +
                                                                                       cdsAjustes.FieldByName('MER_VALPRO').Value, 2);
    End
    Else
    Begin
      cdsConCar.FieldByName('REGISTROAJUSTE').Value := TMercadoLivreFuncoes.fFormataFloat(cdsConCar.FieldByName('REGISTROAJUSTE').Value +
                                                                                          cdsAjustes.FieldByName('MER_VALLIQ').Value, 2);

      If EhRegistroDoTipoRefundPositivoApenasComValorDeFrete Then
      Begin
        cdsConCar.FieldByName('MER_VALENV').AsFloat := cdsConCar.FieldByName('MER_VALENV').AsFloat +
                                                       cdsAjustes.FieldByName('MER_VALENV').AsFloat;
        cdsConCar.FieldByName('REGISTROAJUSTE').Value := TMercadoLivreFuncoes.fFormataFloat(cdsConCar.FieldByName('REGISTROAJUSTE').Value -
                                                                                            cdsAjustes.FieldByName('MER_VALENV').Value, 2);
      End;
    End;

    cdsConCar.Post;
  End;
end;

procedure TConcilaRecebiveisMercadoLivre.AjustarArredondamentoDeTaxaValorBruto(
  var AValorTaxa: Double; var AValorBruto: Double);
begin
  If TMercadoLivreFuncoes.fFormataFloat(AValorBruto - cdsBaicar.FieldByName('MCA_VALSTA').AsFloat, 2) = 0 Then
    Exit;

  If fBetween(TMercadoLivreFuncoes.fFormataFloat(AValorBruto - cdsBaicar.FieldByName('MCA_VALSTA').AsFloat, 2), -0.50, 0.50) Then
  Begin
    cdsBaicar.Edit;
    cdsBaicar.FieldByName('MCA_VALTAX').AsFloat := cdsBaicar.FieldByName('MCA_VALTAX').AsFloat -
                                                   TMercadoLivreFuncoes.fFormataFloat(AValorBruto - cdsBaicar.FieldByName('MCA_VALSTA').AsFloat, 2);
    cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat := (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat /
                                                    cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100;
    cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;
    cdsBaicar.Post;

    AValorTaxa := cdsBaicar.FieldByName('MCA_VALTAX').AsFloat;
    AValorBruto := AValorBruto - TMercadoLivreFuncoes.fFormataFloat(AValorBruto - cdsBaicar.FieldByName('MCA_VALSTA').AsFloat, 2);
  End;
end;

function TConcilaRecebiveisMercadoLivre.AjustePossuiAMesmaDataDePagamentoDaLiberacaoDaVenda(
  ADatasetVenda, ADatasetAjuste: TDataset): Boolean;
  Var
    LDataPagamentoString,
    LDataAjusteString: String;
begin
  Result := False;

  If ADatasetVenda.IsEmpty Then
    Exit;

  If ADatasetAjuste.IsEmpty Then
    Exit;

  LDataPagamentoString := FormatDateTime('dd/mm/yyyy', ADatasetVenda.FieldByName('MER_DTAPAG').AsDateTime);
  LDataAjusteString := FormatDateTime('dd/mm/yyyy', ADatasetAjuste.FieldByName('MER_DTAPAG').AsDateTime);

  Result := LDataPagamentoString.Equals(LDataAjusteString);
end;

procedure TConcilaRecebiveisMercadoLivre.RegistraNovaParcelaMovcarDeLiberacoesParciais(
  var ARegistroRelatorio: TItensRelatorioCartoes);
  Var
    LConsulta: TUniQuery;

    LTotalParcelas: Integer;

    LCampoAtual: TField;
begin
  If ARegistroRelatorio.AutoIncremMovCar.IsEmpty Then
    Exit;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := TLibCartoesMovCar.fGetSQLCartoes(objConcil)
                            .Replace('MCA_DTAREC IS NULL', 'MOVCAR.AUTOINCREM="' + ARegistroRelatorio.AutoIncremMovCar + '"') +
                            ') AS TMP';
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    LTotalParcelas := VS_FuncoesExternas.fICampoTabela('COUNT(AUTOINCREM)',
                                                       'MOVCAR',
                                                       ['MCA_NUMDUP', 'MCA_CODEMP', 'MCA_CODCLI'],
                                                       [LConsulta.FieldByName('NRODUP').AsString,
                                                        LConsulta.FieldByName('MCA_CODEMP').AsString,
                                                        LConsulta.FieldByName('MCA_CODCLI').AsString]);

    cdsBaiCar.Last;
    cdsBaiCar.Append;

    For LCampoAtual In LConsulta.Fields Do
      cdsBaiCar.Fields[LCampoAtual.Index].Value := LCampoAtual.Value;

    cdsBaiCar.FieldByName('AUTOINC').AsString := EmptyStr;
    cdsBaiCar.FieldByName('PARDUP').AsString := TMercadoLivreFuncoes.fGetLetraAlfa(LTotalParcelas + 1);
    cdsBaiCar.FieldByName('CADASTRAR_NOVA_PARCELA_MKT').AsString := 'S';
    cdsBaiCar.FieldByName('AUTOINCREM_BAIXADA_MKT').AsString := ARegistroRelatorio.AutoIncremMovCar;

    cdsBaiCar.FieldByName('MCA_MARDES').AsString := 'M';
    cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat := cdsConCar.FieldByName('VALOR_BRUTO').AsFloat -
                                                   cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat;

    ARegistroRelatorio.Descricao := EmptyStr;
    ARegistroRelatorio.TipoDoRegistro := 'PAGAMENTO';

    cdsBaiCar.FieldByName('MCA_VALREC').AsFloat := cdsConCar.FieldByName('MER_VALLIQ').AsFloat;

    cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime := cdsConCar.FieldByName('MER_DTAPAG').AsDateTime;
    cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat    := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;

    cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat := cdsConCar.FieldByName('VALOR_BRUTO').AsFloat -
                                                   cdsConCar.FieldByName('MER_VALLIQ').AsFloat -
                                                   Abs(cdsConCar.FieldByName('REGISTROFRETE').AsFloat) -
                                                   Abs(cdsConCar.FieldByName('MER_VALENV').AsFloat) -
                                                   Abs(cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat);

    cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat    := (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat /
                                                       cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100;

    cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := TMercadoLivreFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat, 2);
    cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat  := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
    cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat  := 1;
    cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat  := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;

    cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString := fRetornaChaveConciliacao(cdsConcar);
    cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat := Abs(cdsConCar.FieldByName('REGISTROFRETE').AsFloat + cdsConCar.FieldByName('MER_VALENV').AsFloat);

    cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat := Abs(cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat);

    cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat := Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);
    cdsBaiCar.Post;

    FTextoInconsistencia := EmptyStr;
    ARegistroRelatorio.InconsistenciaConciliada := 'N';
    ARegistroRelatorio.Conciliado := 0;
    ARegistroRelatorio.Parcela := TMercadoLivreFuncoes.fStrZero((LTotalParcelas + 1).ToString, 2);
    ARegistroRelatorio.TotalParcelas := ARegistroRelatorio.Parcela;
  Finally
    TMercadoLivreFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

function TConcilaRecebiveisMercadoLivre.RegistroCancelado(ARegistroEncontrado: Boolean): Boolean;
begin
  Result := TMercadoLivreFuncoes.fFormataFloat(cdsConCar.FieldByName('MER_VALLIQ').AsFloat, 2) <= 0;

  If Not Result Then
    Exit(SomaDoShippingIDVendaIgualAZero(cdsConCar.FieldByName('MER_SHP_ID').AsString));

  If Not FPossuiRegistroCanceladoQueNecessitaConciliar Then
    FPossuiRegistroCanceladoQueNecessitaConciliar := FTextoInconsistencia.IsEmpty And
                                                     cdsConCar.FieldByName('MARCADO').AsString.Equals('S');

  If Not FPossuiRegistroCanceladoQueForamBaixados Then
    FPossuiRegistroCanceladoQueForamBaixados := FTextoInconsistencia.Contains('baixada');

  If Not ARegistroEncontrado Then
  Begin
    If Not FPossuiRegistroCanceladoSemMovcar Then
      FPossuiRegistroCanceladoSemMovcar := (TMercadoLivreFuncoes.fFormataFloat(cdsConCar.FieldByName('MER_VALLIQ').AsFloat, 2) = 0) Or
                                           (SomaDoShippingIDVendaIgualAZero(cdsConCar.FieldByName('MER_SHP_ID').AsString));
  End;
end;

function TConcilaRecebiveisMercadoLivre.RegistroPaymentSemVendaVinculada: Boolean;
  Var
    LRegistroRelatorio: TItensRelatorioCartoes;

    LCodigoEmpresa: String;
begin
  Result := False;

  If Not FTextoInconsistencia.Equals('Vendas não encontradas nos lançamentos do sistema') Then
    Exit;

  If Not cdsConCar.FieldByName('MER_TIPREG').AsString.Equals('payment') Then
    Exit;

  If Not cdsConCar.FieldByName('MER_SHP_ID').AsString.Equals(cdsConCar.FieldByName('MER_ORD_ID').AsString) Then
    Exit;

  If Not cdsConCar.FieldByName('MER_SHP_ID').AsString.Equals(cdsConCar.FieldByName('MER_CODAUT').AsString) Then
    Exit;

  If Not cdsConCar.FieldByName('MER_CODAUT').AsString.Equals(cdsConCar.FieldByName('MER_NUMOPE').AsString) Then
    Exit;

  LRegistroRelatorio := TItensRelatorioCartoes.Create;

  Try
    LCodigoEmpresa := cdsConCar.FieldByName('CODEMP').Value;
    If LCodigoEmpresa.IsEmpty Then
      LCodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;

    {Gerando registro do relatório}
    LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
    LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
    LRegistroRelatorio.DescricaoAjuste := 'payment';
    LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('MER_NOMARQ').AsString;
    LRegistroRelatorio.CodigoEstabelecimento := LCodigoEmpresa;
    LRegistroRelatorio.CodigoEmpresa := LCodigoEmpresa;
    LRegistroRelatorio.NumeroNSU := cdsConCar.FieldByName('MER_SHP_ID').AsString;
    LRegistroRelatorio.CodigoAutorizacao := cdsConCar.FieldByName('MER_CODAUT').AsString;
    LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('MER_NUMVEN').AsString;
    LRegistroRelatorio.NumeroCartao := 'MERCADO LIVRE';

    LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';

    LRegistroRelatorio.Parcela := TMercadoLivreFuncoes.fStrZero(cdsConCar.FieldByName('MER_NUMPAR').AsString, 2);
    LRegistroRelatorio.TotalParcelas := TMercadoLivreFuncoes.fStrZero(cdsConCar.FieldByName('MER_TOTPAR').AsString, 2);
    LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('MER_DTAPAG').Value;
    LRegistroRelatorio.DataVenda := TMercadoLivreFuncoes.IIF(cdsConCar.FieldByName('MER_DTATRA').IsNull,
                                                             cdsConCar.FieldByName('MER_DTAPAG').Value,
                                                             cdsConCar.FieldByName('MER_DTATRA').Value);
    LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('MER_DTAPAG').Value;

    LRegistroRelatorio.ValorBruto := cdsConCar.FieldByName('MER_VALPRO').Value;
    LRegistroRelatorio.ValorLiquido := cdsConCar.FieldByName('MER_VALLIQ').Value;

    LRegistroRelatorio.ValorTaxas := 0;
    LRegistroRelatorio.ValorFrete := 0;
    LRegistroRelatorio.ValorAjustes := 0;
    LRegistroRelatorio.ValorCupom := 0;

    LRegistroRelatorio.DescricaoBandeira := objConcil.NomeConciliacao;

    LRegistroRelatorio.Conciliado := cdsConCar.FieldByName('MER_CONCIL').AsInteger;

    If Not FIgnorarPaymentSemVenda Then
    Begin
      GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, cdsConCar);

      If LRegistroRelatorio.Conciliado <> 1 Then
      Begin
        cdsBaiCar.Edit;
        cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString := fRetornaChaveConciliacao(cdsConCar);
        cdsBaiCar.Post;
      End;
    End
    Else
    Begin
      FValorAjusteIgnorado := FValorAjusteIgnorado + LRegistroRelatorio.ValorLiquido;
      LRegistroRelatorio.Conciliado := -1;
    End;

    FListaRegistrosRelatorio.Add(LRegistroRelatorio);

    Result := True;
  Except
    FreeAndNil(LRegistroRelatorio);
    Raise;
  End;
end;

function TConcilaRecebiveisMercadoLivre.RegistroReferenteALancamentoNosCofrinhos(
  ADataset: TDataset): Boolean;
begin
  Result := False;

  If Not ADataset.FieldByName('MER_TIPREG').AsString.Equals('payment') Then
    Exit;

  Result := LeftStr(ADataset.FieldByName('MER_CODAUT').AsString, 5).Equals('POTS_');
end;

function TConcilaRecebiveisMercadoLivre.RegistroVendaComDivergenciaDeFreteSemRegistroMovcar: Boolean;
  Var
    LRegistroRelatorio: TItensRelatorioCartoes;

    LCodigoEmpresa: String;
begin
  Result := False;

  If Not FTextoInconsistencia.Equals('Vendas não encontradas nos lançamentos do sistema') Then
    Exit;

  If Not cdsConCar.FieldByName('MER_TIPREG').AsString.Equals('fee_for_divergence_in_package_dimensions') Then
    Exit;

  LRegistroRelatorio := TItensRelatorioCartoes.Create;

  Try
    LCodigoEmpresa := cdsConCar.FieldByName('CODEMP').Value;
    If LCodigoEmpresa.IsEmpty Then
      LCodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;

    {Gerando registro do relatório}
    LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
    LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
    LRegistroRelatorio.DescricaoAjuste := 'fee_for_divergence_in_package_dimensions';
    LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('MER_NOMARQ').AsString;
    LRegistroRelatorio.CodigoEstabelecimento := LCodigoEmpresa;
    LRegistroRelatorio.CodigoEmpresa := LCodigoEmpresa;
    LRegistroRelatorio.NumeroNSU := cdsConCar.FieldByName('MER_SHP_ID').AsString;
    LRegistroRelatorio.CodigoAutorizacao := cdsConCar.FieldByName('MER_CODAUT').AsString;
    LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('MER_NUMVEN').AsString;
    LRegistroRelatorio.NumeroCartao := 'MERCADO LIVRE';

    LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';

    LRegistroRelatorio.Parcela := TMercadoLivreFuncoes.fStrZero(cdsConCar.FieldByName('MER_NUMPAR').AsString, 2);
    LRegistroRelatorio.TotalParcelas := TMercadoLivreFuncoes.fStrZero(cdsConCar.FieldByName('MER_TOTPAR').AsString, 2);
    LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('MER_DTAPAG').Value;
    LRegistroRelatorio.DataVenda := TMercadoLivreFuncoes.IIF(cdsConCar.FieldByName('MER_DTATRA').IsNull,
                                                             cdsConCar.FieldByName('MER_DTAPAG').Value,
                                                             cdsConCar.FieldByName('MER_DTATRA').Value);
    LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('MER_DTAPAG').Value;

    LRegistroRelatorio.ValorBruto := cdsConCar.FieldByName('MER_VALPRO').Value;
    LRegistroRelatorio.ValorLiquido := cdsConCar.FieldByName('MER_VALLIQ').Value;

    LRegistroRelatorio.ValorTaxas := 0;
    LRegistroRelatorio.ValorFrete := 0;
    LRegistroRelatorio.ValorAjustes := 0;
    LRegistroRelatorio.ValorCupom := 0;

    LRegistroRelatorio.DescricaoBandeira := objConcil.NomeConciliacao;

    LRegistroRelatorio.Conciliado := cdsConCar.FieldByName('MER_CONCIL').AsInteger;

    GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, cdsConCar);

    If LRegistroRelatorio.Conciliado <> 1 Then
    Begin
      cdsBaiCar.Edit;
      cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString := fRetornaChaveConciliacao(cdsConCar);
      cdsBaiCar.Post;
    End;

    FListaRegistrosRelatorio.Add(LRegistroRelatorio);

    Result := True;
  Except
    FreeAndNil(LRegistroRelatorio);
    Raise;
  End;
end;

function TConcilaRecebiveisMercadoLivre.RetornaCondicaoFreteRecebidoComoVenda(const AAliasTabela: String): String;
  Var
    LCondicaoCartao: String;
begin
  //Venda cujo produto liquidou zero: o Mercado Livre não envia o "payment" e o dinheiro chega só no
  //"shipping", que é a venda quando há cartão do mesmo envio com o mesmo líquido. Já conciliado como
  //ajuste com o cartão em aberto, continua ajuste: baixar o cartão contaria o valor duas vezes
  Result := ' (' + AAliasTabela + '.MER_TIPREG = "shipping" AND ' + AAliasTabela + '.MER_STATUS = "release" AND ' + AAliasTabela + '.MER_VALLIQ > 0 ';
  Result := Result + ' AND NOT EXISTS (SELECT 1 FROM MER_MLPGTO PAG ';
  Result := Result + '                 WHERE PAG.MER_SHP_ID = ' + AAliasTabela + '.MER_SHP_ID AND PAG.MER_TIPREG = "payment") ';

  //Um EXISTS por coluna do envio: com OR entre MCA_NUMCCD e MCA_NUMNSU na mesma subconsulta o MySQL não
  //usa índice e varre a MOVCAR (466823: busca de vendas de um mês passou de 0,1 s para 5,7 s)
  LCondicaoCartao := '   AND CAR.MCA_PARCEL = "A" AND CAR.MCA_VALDUP = ' + AAliasTabela + '.MER_VALLIQ ' +
                     '   AND (' + AAliasTabela + '.MER_CONCIL = 0 OR CAR.MCA_DTAREC IS NOT NULL)) ';

  Result := Result + ' AND (EXISTS (SELECT 1 FROM MOVCAR CAR WHERE CAR.MCA_NUMCCD = ' + AAliasTabela + '.MER_SHP_ID ' + LCondicaoCartao;
  Result := Result + '      OR EXISTS (SELECT 1 FROM MOVCAR CAR WHERE CAR.MCA_NUMNSU = ' + AAliasTabela + '.MER_SHP_ID ' + LCondicaoCartao + ')) ';
end;

function TConcilaRecebiveisMercadoLivre.RetornaEmpresaFiltrada: String;
begin
  Result := EmptyStr;

  If Length(arrEmpresa) = 0 Then
    Exit;

  Result := arrEmpresa[0].strCodigo;
end;

function TConcilaRecebiveisMercadoLivre.RetornaFiltroEmpresa: String;
begin
  Result := ' AND MER_CODEMP IS NULL ';

  If FUtilizaImportacaoPorEmpresa Then
    Result := ' AND MER_CODEMP="' + RetornaEmpresaFiltrada + '" ';
end;

function TConcilaRecebiveisMercadoLivre.RetornaListaDePedidos: String;
  Var
    LSQL: String;

    LConsulta: TUniQuery;

    LStringValidacaoMaquininha: String;
begin
  LStringValidacaoMaquininha := EmptyStr;
  If TMercadoLivreFuncoes.FCampoMER_NUMNSUExiste.Equals('S') Then
    LStringValidacaoMaquininha := ' AND (MER_NUMNSU IS NULL OR MER_POS_ID IS NULL) ';

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LSQL := 'SELECT DISTINCT MER_SHP_ID AS MER_CODAUT FROM MER_MLPGTO WHERE MER_DTAPAG' + FPeriodoFiltro + LStringValidacaoMaquininha  +
            ' UNION ' +
            'SELECT DISTINCT IF(MER_CODAUT<>MER_SHP_ID, MER_CODAUT, COALESCE(MER_NUMVEN, MER_CODAUT))  FROM MER_MLPGTO WHERE MER_DTAPAG' + FPeriodoFiltro + LStringValidacaoMaquininha;

    LConsulta.SQL.Text := LSQL;
    LConsulta.Open;

    Result := EmptyStr;

    While Not LConsulta.Eof Do
    Begin
      Result := Result + '"' + LConsulta.FieldByName('MER_CODAUT').AsString + '",';

      LConsulta.Next;
    End;

    If (FCartoesMaquininhas.Length >= 5) And TMercadoLivreFuncoes.FCampoMER_NUMNSUExiste.Equals('S') Then
    Begin
      LConsulta.Close;
      LSQL := 'SELECT DISTINCT LPAD(MER_CODAUT, 6, "0") AS MER_CODAUT FROM MER_MLPGTO WHERE MER_DTAPAG' + FPeriodoFiltro + ' AND MER_NUMNSU IS NOT NULL AND MER_POS_ID IS NOT NULL ' +
              ' UNION ' +
              'SELECT DISTINCT LPAD(MER_NUMNSU, 14, "0") AS MER_CODAUT FROM MER_MLPGTO WHERE MER_DTAPAG' + FPeriodoFiltro + ' AND MER_NUMNSU IS NOT NULL AND MER_POS_ID IS NOT NULL ';

      LConsulta.SQL.Text := LSQL;
      LConsulta.Open;

      While Not LConsulta.Eof Do
      Begin
        Result := Result + '"' + LConsulta.FieldByName('MER_CODAUT').AsString + '",';

        LConsulta.Next;
      End;
    End;

    If Result.IsEmpty Then
      Exit('" "');

    Result := LeftStr(Result, Result.Length - 1);
  Finally
    TMercadoLivreFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

function TConcilaRecebiveisMercadoLivre.RetornaSQLConciliacao: String;
  Var
    LValorBruto,
    LValorFinancingFee: String;
begin
  LValorBruto := ' IFNULL(MER_VALPRO, 0) - ABS(IFNULL(MER_VALMPG, 0)) ';
  LValorFinancingFee := ' 0.00 AS FINANCING_FEE, ';
  If FConsiderarValorFinancingFee Then
  Begin
    LValorBruto := ' IFNULL(MER_VALPRO, 0) ';
    LValorFinancingFee := ' IFNULL(MER_VALMPG, 0) AS FINANCING_FEE, ';
  End;

  Result := EmptyStr;
  Result := Result + 'SELECT IFNULL(MER_ORD_ID, IF(MER_TIPREG = "payment", MER_CODAUT, MER_ORD_ID)) AS MER_ORD_ID, ';
  Result := Result + ' MER_MLPGTO.*,  '+ EmpresaSQL +'  AS CODEMP, EMP_NOMEMP, ';
  Result := Result + LValorBruto + ' AS VALOR_BRUTO, ';
  Result := Result + ' 0.00 AS REGISTROFRETE,                                    ';
  Result := Result + ' 0.00 AS REGISTROAJUSTE,                                   ';
  Result := Result + ' 0.00 AS REGISTROFRETELIQUIDO,                             ';
  Result := Result + ' 0.00 AS SOBRAFRETE,                                       ';
  Result := Result + ' MER_VALLIQ AS VALOR_LIQUIDO,                              ';
  Result := Result + ' IFNULL(MER_VALCUP, 0.00) AS CUPOMDESCONTO,                ';
  Result := Result + LValorFinancingFee;
  Result := Result + ' "N" AS MARCADO                                            ';
  Result := Result + 'FROM MER_MLPGTO                                            ';
  Result := Result + '  LEFT JOIN CADEMP ON EMP_CODEMP = '+ EmpresaSQL            ;
  Result := Result + ' WHERE MER_DTAPAG                                          ';

  FPeriodoFiltro := ' BETWEEN "' +
                    FormatDateTime('yyyy-mm-dd hh:mm:ss', StrToDateTime(strDtaIni + ' 00:00:00')) + '" AND "'+
                    FormatDateTime('yyyy-mm-dd hh:mm:ss', StrToDateTime(strDtaFim + ' 23:59:59')) + '" ';

  Result := Result + FPeriodoFiltro + ' AND MER_DTASTR IS NOT NULL ';

  If FUtilizaImportacaoPorEmpresa Then
    Result := Result + ' AND MER_CODEMP="' + RetornaEmpresaFiltrada + '" '
  Else
    Result := Result + ' AND MER_CODEMP IS NULL ';

  //Complemento exato do filtro de RetornaSQLConciliacaoMaquininhas (NSU e POS_ID preenchidos). Com AND, a venda
  //do marketplace gravada com NSU e sem POS_ID não entrava em nenhum dos dois grupos e sumia sem inconsistência
  //(arquivos importados antes do Req. 467374 continuam gravados assim, e a reimportação não regrava o NSU)
  If TMercadoLivreFuncoes.FCampoMER_NUMNSUExiste.Equals('S') Then
    Result := Result + ' AND (MER_NUMNSU IS NULL OR MER_POS_ID IS NULL) ';

  Result := Result + ' AND ((MER_TIPREG IN ("payment", "fee_for_divergence_in_package_dimensions") ';
  Result := Result + ' AND MER_STATUS = "release" AND MER_VALLIQ > 0 AND MER_CODAUT NOT LIKE "money_transfer%" ';
  Result := Result + ' AND (MER_CODAUT <> "Vendapresencial" OR MER_SHP_ID <> "Vendapresencial")) OR ';
  Result := Result + ' (MER_TIPREG IN ("withdrawal", "payout") AND MER_STATUS = "release") OR ';
  Result := Result + RetornaCondicaoFreteRecebidoComoVenda('MER_MLPGTO') + ') ';

  Result := Result + fRetPesqPonVen;
  Result := Result + ' ORDER BY IFNULL(MER_ORD_ID, ""), MER_SHP_ID, MER_VALPRO, MER_TIPREG, MER_DTAPAG ';
end;

function TConcilaRecebiveisMercadoLivre.RetornaSQLConciliacaoMaquininhas: String;
  Var
    LValorBruto,
    LValorFinancingFee: String;
begin
  LValorBruto := ' IFNULL(MER_VALPRO, 0) ';
  LValorFinancingFee := ' 0.00 AS FINANCING_FEE, ';

  Result := EmptyStr;
  Result := Result + 'SELECT ';
  Result := Result + ' MER_MLPGTO.*,  '+ EmpresaSQL +'  AS CODEMP, EMP_NOMEMP, ';
  Result := Result + LValorBruto + ' AS VALOR_BRUTO, ';
  Result := Result + ' 0.00 AS REGISTROFRETE,                                    ';
  Result := Result + ' 0.00 AS REGISTROAJUSTE,                                   ';
  Result := Result + ' 0.00 AS REGISTROFRETELIQUIDO,                             ';
  Result := Result + ' 0.00 AS SOBRAFRETE,                                       ';
  Result := Result + ' MER_VALLIQ AS VALOR_LIQUIDO,                              ';
  Result := Result + ' IFNULL(MER_VALCUP, 0.00) AS CUPOMDESCONTO,                ';
  Result := Result + LValorFinancingFee;
  Result := Result + ' "N" AS MARCADO                                            ';
  Result := Result + 'FROM MER_MLPGTO                                            ';
  Result := Result + ' LEFT JOIN CFGSIS ON SIS_CODCFG IN ("CFG_MEREST") AND ';
  Result := Result + '                   LOCATE(MER_CODEST, SIS_VALCFG) > 0 ';
  Result := Result + ' LEFT JOIN CADEMP ON EMP_CODEMP = '+ EmpresaSQL            ;
  Result := Result + ' WHERE MER_DTAPAG                                          ';

  Result := Result + FPeriodoFiltro + ' AND MER_DTASTR IS NOT NULL ';

  Result := Result + ' AND MER_CODEMP="' + RetornaEmpresaFiltrada + '" ';
  Result := Result + ' AND MER_NUMNSU IS NOT NULL AND MER_POS_ID IS NOT NULL ';

  Result := Result + ' AND MER_TIPREG IN ("payment") ';
  Result := Result + ' AND MER_STATUS = "release" AND MER_VALLIQ > 0 ';
  Result := Result + ' AND MER_CODAUT <> "Vendapresencial" AND MER_SHP_ID = "Vendapresencial" ';

  Result := Result + fRetPesqPonVen;
  Result := Result + ' ORDER BY MER_CODAUT, MER_NUMNSU, MER_VALPRO, MER_TIPREG, MER_DTAPAG ';
end;

function TConcilaRecebiveisMercadoLivre.RetornaValorTaxaRegistro(
  ADataset: TDataset): Double;
begin
  Result := TMercadoLivreFuncoes.fFormataFloat(ADataset.FieldByName('VALOR_BRUTO').AsFloat -
                                               ADataset.FieldByName('MER_VALLIQ').AsFloat -
                                               Abs(ADataset.FieldByName('REGISTROFRETE').AsFloat) -
                                               Abs(ADataset.FieldByName('MER_VALENV').AsFloat) -
                                               Abs(ADataset.FieldByName('REGISTROAJUSTE').AsFloat), 2);
end;

procedure TConcilaRecebiveisMercadoLivre.SelecionaMultiplasParcelasMaquininasMovCar(
  AValorBruto, AValorLiquido, AValorTaxa, AValorAjuste: Double;
  ARegistroRelatorio: TItensRelatorioCartoes; ADatasetMaquininhas: TDataset;
  APrimeiraParcelaBaixada: Boolean);
  Var
    LChaveConciliacao,
    LParcelaString,
    LCodigoAutorizacao,
    LNumeroNSU: String;

    LDataTransacao: TDateTime;

    LParcelaBaixada: Boolean;

    LParcelaInteger,
    LTotalParcelas: Integer;

    LValorBrutoLancado,
    LValorLiquidoLancado,
    LValorTaxaLancado,
    LValorAjusteLancado,

    LValorBruto,
    LValorLiquido,
    LValorTaxa,
    LValorAjuste: Double;
begin
  LParcelaBaixada := APrimeiraParcelaBaixada;

  LParcelaInteger := 1;
  LTotalParcelas := StrToInt(ADatasetMaquininhas.FieldByName('MER_TOTPAR').AsString);

  LValorBrutoLancado := 0;
  LValorLiquidoLancado := 0;
  LValorTaxaLancado := 0;
  LValorAjusteLancado := 0;

  Repeat
    FTextoInconsistencia := EmptyStr;

    LCodigoAutorizacao := TMercadoLivreFuncoes.fStrZero(Trim(ADatasetMaquininhas.FieldByName('MER_CODAUT').AsString), 6);
    LNumeroNSU := TMercadoLivreFuncoes.fStrZero(Trim(RightStr(ADatasetMaquininhas.FieldByName('MER_NUMNSU').AsString, 14)), 14);
    LValorBruto := TMercadoLivreFuncoes.fFormataFloat(AValorBruto / LTotalParcelas, 2);
    LValorLiquido := TMercadoLivreFuncoes.fFormataFloat(AValorLiquido / LTotalParcelas, 2);
    LValorTaxa := TMercadoLivreFuncoes.fFormataFloat(AValorTaxa / LTotalParcelas, 2);
    LValorAjuste := TMercadoLivreFuncoes.fFormataFloat(AValorAjuste / LTotalParcelas, 2);

    LValorBrutoLancado := LValorBrutoLancado + LValorBruto;
    LValorLiquidoLancado := LValorLiquidoLancado + LValorLiquido;
    LValorTaxaLancado := LValorTaxaLancado + LValorTaxa;
    LValorAjusteLancado := LValorAjusteLancado + LValorAjuste;

    If LParcelaInteger = LTotalParcelas Then
    Begin
      LValorBruto := LValorBruto + TMercadoLivreFuncoes.fFormataFloat(AValorBruto - LValorBrutoLancado, 2);
      LValorLiquido := LValorLiquido + TMercadoLivreFuncoes.fFormataFloat(AValorLiquido - LValorLiquidoLancado, 2);
      LValorTaxa := LValorTaxa + TMercadoLivreFuncoes.fFormataFloat(AValorTaxa - LValorTaxaLancado, 2);
      LValorAjuste := LValorAjuste + TMercadoLivreFuncoes.fFormataFloat(AValorAjuste - LValorAjusteLancado, 2);
    End;

    LDataTransacao := EncodeDate(StrToInt(FormatDateTime('yyyy', ADatasetMaquininhas.FieldByName('MER_DTATRA').AsDateTime)),
                                 StrToInt(FormatDateTime('mm', ADatasetMaquininhas.FieldByName('MER_DTATRA').AsDateTime)),
                                 StrToInt(FormatDateTime('dd', ADatasetMaquininhas.FieldByName('MER_DTATRA').AsDateTime)));

    LParcelaString := TMercadoLivreFuncoes.fGetLetraAlfa(LParcelaInteger);
    If LParcelaInteger > 1 Then
    Begin
      ARegistroRelatorio := TItensRelatorioCartoes.Create;

      LParcelaBaixada := Not fBuscaCartao(LCodigoAutorizacao,
                                          LNumeroNSU,
                                          FDatasetMaquininhas.FieldByName('CODEMP').AsString,
                                          LParcelaString,
                                          LDataTransacao);
    End;

    If Not LParcelaBaixada Then
    Begin
      LChaveConciliacao := INICAM + ADatasetMaquininhas.FieldByName('MER_CODAUT').AsString + '_' +
                                    LParcelaString + '_' +
                                    cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                                    FormatDateTime('yyyy-mm-dd', ADatasetMaquininhas.FieldByName('MER_DTATRA').Value);

      MarcarCartaoEncontradoArquivo(LValorBruto,
                                    LValorLiquido,
                                    ARegistroRelatorio,
                                    LChaveConciliacao,
                                    FDatasetMaquininhas,
                                    0,
                                    Abs(LValorAjuste),
                                    Abs(LValorTaxa),
                                    0);

      ARegistroRelatorio.Conciliado := 0;
    End
    Else
    Begin
      LParcelaBaixada := fBuscaCartaoBaixado(LCodigoAutorizacao,
                                             LNumeroNSU,
                                             ADatasetMaquininhas.FieldByName('CODEMP').AsString,
                                             LParcelaString,
                                             LDataTransacao);

      FTextoInconsistencia := 'Registro do arquivo não encontrado nos lançamentos do sistema';

      If LParcelaBaixada Then
      Begin
        blnAutomatica := Not cdsBaixad.FieldByName('MCA_CHACON').AsString.isEmpty;

        FTextoInconsistencia := 'Cartão já foi baixado';
        ARegistroRelatorio.InconsistenciaConciliada := 'S';
        ARegistroRelatorio.Conciliado := 1;
        ARegistroRelatorio.AutoIncremMovCar := cdsBaixad.FieldByName('AUTOINCREM').AsString;
      End;
    End;

    {Gerando registro do relatório}
    FTextoInconsistencia := RetornaTextoInconsistenciaMaquininhaAtualizado(FTextoInconsistencia);
    If Not FTextoInconsistencia.IsEmpty Then
    Begin
      ARegistroRelatorio.Descricao := FTextoInconsistencia;
      If Not ARegistroRelatorio.InconsistenciaConciliada.Equals('S') Then
        ARegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
    End;
    ARegistroRelatorio.NomeArquivo := ADatasetMaquininhas.FieldByName('MER_NOMARQ').AsString;
    ARegistroRelatorio.CodigoEstabelecimento := ADatasetMaquininhas.FieldByName('CODEMP').AsString;
    ARegistroRelatorio.CodigoEmpresa := ADatasetMaquininhas.FieldByName('CODEMP').AsString;
    If ARegistroRelatorio.CodigoEmpresa.IsEmpty Then
    Begin
      ARegistroRelatorio.CodigoEstabelecimento := VS_FuncoesExternas.fIRetEmpresaLogada;
      ARegistroRelatorio.CodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;
    End;

    ARegistroRelatorio.NumeroNSU := LNumeroNSU;
    ARegistroRelatorio.CodigoAutorizacao := LCodigoAutorizacao;
    ARegistroRelatorio.ResumoVenda := ADatasetMaquininhas.FieldByName('MER_NUMVEN').AsString;
    ARegistroRelatorio.NumeroCartao := ADatasetMaquininhas.FieldByName('MER_NUMCAR').AsString;

    ARegistroRelatorio.TipoCartao := 'CRÉDITO ROTATIVO';

    ARegistroRelatorio.Parcela := TMercadoLivreFuncoes.fStrZero(LParcelaInteger.ToString, 2);
    ARegistroRelatorio.TotalParcelas := TMercadoLivreFuncoes.fStrZero(LTotalParcelas.ToString, 2);
    ARegistroRelatorio.DataPagamento := ADatasetMaquininhas.FieldByName('MER_DTAPAG').Value;
    ARegistroRelatorio.DataVenda := ADatasetMaquininhas.FieldByName('MER_DTATRA').Value;
    ARegistroRelatorio.DataVencimento := ADatasetMaquininhas.FieldByName('MER_DTAPAG').Value;

    ARegistroRelatorio.ValorBruto := LValorBruto;

    ARegistroRelatorio.ValorLiquido := LValorLiquido;
    ARegistroRelatorio.ValorTaxas := LValorTaxa;
    ARegistroRelatorio.ValorFrete := 0;
    ARegistroRelatorio.ValorAjustes := Abs(LValorAjuste);
    ARegistroRelatorio.ValorCupom := 0;

    ARegistroRelatorio.DescricaoBandeira := fRetNomBandeira(ARegistroRelatorio.NumeroCartao);

    FListaRegistrosRelatorio.Add(ARegistroRelatorio);

    If ARegistroRelatorio.TipoCartao.Equals('AJUSTE DE PARCELA') Then
      GravarRegistroDeAjusteParaConciliacao(ARegistroRelatorio, False, FDatasetMaquininhas);

    Inc(LParcelaInteger);
  Until(LTotalParcelas < LParcelaInteger);

end;

function TConcilaRecebiveisMercadoLivre.ValidaDataDoAjuste(
  ADataAjuste: TDateTime): Boolean;
  Var
    LDataInicial,
    LDataFinal: TDateTime;
begin
  LDataInicial := StrToDateTime(strDtaIni + ' 00:00:00');
  LDataFinal := StrToDateTime(strDtaFim + ' 23:59:59');

  Result := ADataAjuste >= LDataInicial;
  If Result Then
    Result := ADataAjuste <= LDataFinal;
end;

function TConcilaRecebiveisMercadoLivre.ValidaPedidoMLCompleto(var AValorBruto,
  AValorLiquido, AValorTaxa: Double; var ADeveMarcarRegistro: Boolean): Boolean;
  Var
    LBuscaPorOrderId: Boolean;
    LBuscaPorOrderIdNaAutorizacao: Boolean;
begin
  ADeveMarcarRegistro := True;

  Result := fBuscaCartaoML;

  LBuscaPorOrderId := True;
  If Result Then
    LBuscaPorOrderId := Not ValidaValorBrutoELiquido(AValorBruto, AValorLiquido, True);

  If cdsConCar.FieldByName('MER_ORD_ID').AsString.IsEmpty Then
    Exit;

  If Not cdsConCar.FieldByName('MER_TOTPAR').AsString.Equals('01') Then
    Exit;

  If LBuscaPorOrderId Then
  Begin
    LBuscaPorOrderId := BuscaCartaoMLOrderId(AValorBruto, AValorTaxa, AValorLiquido);

    If LBuscaPorOrderId Then
      Exit(True)
    Else
    Begin
      LBuscaPorOrderIdNaAutorizacao := BuscaCartaoMLOrderIdNaAutorizacao(AValorBruto, AValorTaxa, AValorLiquido);
      If LBuscaPorOrderIdNaAutorizacao Then
        Exit(True);
    End;

    If ValidarApenasUmRegistroMOVCAReVariosImportadosPorShippingID(AValorBruto, AValorLiquido) Then
    Begin
      Result := True;
      ADeveMarcarRegistro := False;
    End;
  End;

  If Result Then
  Begin
    If FRegistroAgrupadoValidado.IndexOf(cdsConCar.FieldByName('MER_SHP_ID').AsString) >= 0 Then
      ADeveMarcarRegistro := False;
  End;

  If Not ADeveMarcarRegistro Then
    Exit;

  If Result Then
  Begin
    If Not ValidaValorBrutoELiquido(AValorBruto, AValorLiquido, True) Then
      Result := Not fBuscaCartaoBaixadoML;

    If Not Result Then
    Begin
      If fBuscaCartaoML Then
      Begin
        If Not cdsBaiCar.FieldByName('PARDUP').AsString.Equals('A') Then
          Result := Concat(cdsConCar.FieldByName('MER_SHP_ID').AsString,'-',
                           cdsConCar.FieldByName('MER_ORD_ID').AsString).Equals(
                    Concat(cdsBaiCar.FieldByName('MCA_NUMNSU').AsString,'-',
                           cdsBaiCar.FieldByName('MCA_ORDEID').AsString));
      End;
    End;
  End;
end;

function TConcilaRecebiveisMercadoLivre.ValidarApenasUmRegistroMOVCAReVariosImportadosPorShippingID(
  var AValorBruto, AValorLiquido: Double): Boolean;
  Var
    LValorBrutoConCar,
    LValorLiquidoConCar,
    LValorTaxaConCar,
    LValorFreteConCar,
    LValorCupomConCar,
    LValorAjusteConCar: Double;

    LChaveConciliacao: String;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  LValorBrutoConCar := 0;
  LValorLiquidoConCar := 0;
  LValorTaxaConCar := 0;
  LValorFreteConCar := 0;
  LValorCupomConCar := 0;
  LValorAjusteConCar := 0;

  FCloneDatasetBaiCar.Filter := 'MCA_NUMNSU=''' + cdsConCar.FieldByName('MER_SHP_ID').AsString + ''' OR ' +
                                'MCA_NUMCCD=''' + cdsConCar.FieldByName('MER_SHP_ID').AsString + ''' ';
  FCloneDatasetBaiCar.Filtered := True;

  If FCloneDatasetBaiCar.IsEmpty Then
    Exit(False);

  If FCloneDatasetBaiCar.RecordCount > 1 Then
    Exit(False);


  FCloneDatasetConCar.Filter := 'MER_SHP_ID=''' + cdsConCar.FieldByName('MER_SHP_ID').AsString + ''' ';
  FCloneDatasetConCar.Filtered := True;

  If FCloneDatasetConCar.RecordCount <= 1 Then
    Exit(False);

  FCloneDatasetConCar.First;
  While Not FCloneDatasetConCar.Eof Do
  Begin
    LValorBrutoConCar := LValorBrutoConCar +
                         TMercadoLivreFuncoes.fFormataFloat(FCloneDatasetConCar.FieldByName('VALOR_BRUTO').AsFloat, 2);

    LValorTaxaConCar := LValorTaxaConCar +
                        TMercadoLivreFuncoes.fFormataFloat(Abs(FCloneDatasetConCar.FieldByName('MER_VALPLA').AsFloat), 2);

    If FPossuiCampoCUPEFE Then
    Begin
      If Not FCloneDatasetConCar.FieldByName('MER_CUPEFE').IsNull Then
        LValorTaxaConCar := LValorTaxaConCar +
                            TMercadoLivreFuncoes.fFormataFloat(Abs(FCloneDatasetConCar.FieldByName('MER_CUPEFE').AsFloat), 2);
    End;

    LValorFreteConCar := LValorFreteConCar +
                         TMercadoLivreFuncoes.fFormataFloat(Abs(FCloneDatasetConCar.FieldByName('MER_VALENV').AsFloat) +
                                                            Abs(FCloneDatasetConCar.FieldByName('REGISTROFRETE').AsFloat), 2);

    LValorCupomConCar := LValorCupomConCar +
                        TMercadoLivreFuncoes. fFormataFloat(Abs(FCloneDatasetConCar.FieldByName('MER_VALCUP').AsFloat), 2);

    LValorLiquidoConCar := LValorLiquidoConCar +
                           TMercadoLivreFuncoes.fFormataFloat(FCloneDatasetConCar.FieldByName('MER_VALLIQ').AsFloat, 2);

    LValorAjusteConCar := LValorAjusteConCar +
                          TMercadoLivreFuncoes.fFormataFloat(FCloneDatasetConCar.FieldByName('REGISTROAJUSTE').AsFloat, 2);

    FCloneDatasetConCar.Next;
  End;

  Result := fBetween(FCloneDatasetBaiCar.FieldByName('MCA_VALSTA').AsFloat - LValorBrutoConCar, -0.29999999, 0.29999999);

  If Result Then
  Begin
    cdsBaiCar.Locate('AUTOINC', FCloneDatasetBaiCar.FieldByName('AUTOINC').AsString, []);

    LRegistroRelatorio := TItensRelatorioCartoes.Create;
    Try
      If cdsBaiCar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
        Exit(False);

      AValorBruto := LValorBrutoConCar;
      AValorLiquido := LValorLiquidoConCar;

      LChaveConciliacao := INICAM + cdsConCar.FieldByName('MER_CODAUT').Value + '_' +
                           'A' + '_' + cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                           FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('MER_DTATRA').Value);

      MarcarCartaoEncontradoArquivo(LValorBrutoConCar,
                                    LValorLiquidoConCar,
                                    LRegistroRelatorio,
                                    LChaveConciliacao,
                                    cdsConCar,
                                    LValorFreteConCar,
                                    LValorAjusteConCar,
                                    Abs(LValorTaxaConCar),
                                    LValorCupomConCar);

      AjustarArredondamentoDeTaxaValorBruto(LValorTaxaConCar,
                                            LValorBrutoConCar);

      cdsConCar.Edit;
      cdsConCar.FieldByName('MARCADO').AsString := 'S';
      cdsConCar.Post;

      FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(cdsConCar));

      AdicionaAjustesAgrupadosParaConciliar;

      FRegistroAgrupadoValidado.Add(cdsConCar.FieldByName('MER_SHP_ID').AsString);
    Finally
      LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('MER_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName('CODEMP').AsString;
      LRegistroRelatorio.CodigoEmpresa := cdsConCar.FieldByName('CODEMP').AsString;
      If LRegistroRelatorio.CodigoEmpresa.IsEmpty Then
      Begin
        LRegistroRelatorio.CodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;
        LRegistroRelatorio.CodigoEstabelecimento := VS_FuncoesExternas.fIRetEmpresaLogada;
      End;

      LRegistroRelatorio.NumeroNSU := cdsConCar.FieldByName('MER_SHP_ID').AsString;
      LRegistroRelatorio.CodigoAutorizacao := cdsConCar.FieldByName('MER_CODAUT').AsString;
      LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('MER_NUMVEN').AsString;
      LRegistroRelatorio.NumeroCartao := 'MERCADO LIVRE';

      LRegistroRelatorio.TipoCartao := 'CRÉDITO ROTATIVO';

      LRegistroRelatorio.Parcela := TMercadoLivreFuncoes.fStrZero(cdsConCar.FieldByName('MER_NUMPAR').AsString, 2);
      LRegistroRelatorio.TotalParcelas := TMercadoLivreFuncoes.fStrZero(cdsConCar.FieldByName('MER_TOTPAR').AsString, 2);
      LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('MER_DTAPAG').Value;
      LRegistroRelatorio.DataVenda := cdsConCar.FieldByName('MER_DTATRA').Value;
      LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('MER_DTAPAG').Value;

      LRegistroRelatorio.ValorBruto := cdsConCar.FieldByName('VALOR_BRUTO').AsFloat - Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);
      LRegistroRelatorio.ValorLiquido := cdsConCar.FieldByName('MER_VALLIQ').AsFloat;
      LRegistroRelatorio.ValorTaxas := Abs(FCloneDatasetConCar.FieldByName('MER_VALPLA').AsFloat);
      LRegistroRelatorio.ValorFrete := Abs(cdsConCar.FieldByName('REGISTROFRETE').AsFloat + cdsConCar.FieldByName('MER_VALENV').AsFloat);
      LRegistroRelatorio.ValorAjustes := Abs(cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat);
      LRegistroRelatorio.ValorCupom := Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);

      LRegistroRelatorio.DescricaoBandeira := objConcil.NomeConciliacao;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);
    End;
  End;
end;

function TConcilaRecebiveisMercadoLivre.ValidaTodosOsRegistrosAgupadosPorShippingIdQueContenhamOrderIdNaAutorizacao(
  var AValorBruto, AValorLiquido, AValorTaxa: Double): Boolean;
  Var
    LValorBrutoBaiCar,
    LValorBrutoConCar,

    LValorLiquidoBaiCar,
    LValorLiquidoConCar: Double;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  LValorBrutoBaiCar := 0;
  LValorBrutoConCar := 0;

  LValorLiquidoBaiCar := 0;
  LValorLiquidoConCar := 0;

  FCloneDatasetBaiCar.Filter := 'MCA_NUMNSU=''' + cdsConCar.FieldByName('MER_ORD_ID').AsString + ''' OR ' +
                                'MCA_NUMCCD=''' + cdsConCar.FieldByName('MER_ORD_ID').AsString + ''' ';
  FCloneDatasetBaiCar.Filtered := True;

  FCloneDatasetBaiCar.First;
  While Not FCloneDatasetBaiCar.Eof Do
  Begin
    LValorBrutoBaiCar := LValorBrutoBaiCar +
                         TMercadoLivreFuncoes.fFormataFloat(FCloneDatasetBaiCar.FieldByName('MCA_VALSTA').AsFloat, 2);

    LValorLiquidoBaiCar := LValorLiquidoBaiCar +
                           TMercadoLivreFuncoes.fFormataFloat(FCloneDatasetBaiCar.FieldByName('MCA_VALORI').AsFloat, 2);

    FCloneDatasetBaiCar.Next;
  End;

  FCloneDatasetConCar.Filter := 'MER_SHP_ID=''' + cdsConCar.FieldByName('MER_SHP_ID').AsString + ''' ';
  FCloneDatasetConCar.Filtered := True;

  FCloneDatasetConCar.First;
  While Not FCloneDatasetConCar.Eof Do
  Begin
    LValorBrutoConCar := LValorBrutoConCar +
                         TMercadoLivreFuncoes.fFormataFloat(FCloneDatasetConCar.FieldByName('VALOR_BRUTO').AsFloat, 2);

    LValorLiquidoConCar := LValorLiquidoConCar +
                           TMercadoLivreFuncoes.fFormataFloat(FCloneDatasetConCar.FieldByName('MER_VALLIQ').AsFloat, 2);

    FCloneDatasetConCar.Next;
  End;

  Result := fBetween(LValorBrutoBaiCar - LValorBrutoConCar, -0.29999999, 0.29999999);
  If Not Result Then
    Result := fBetween(LValorLiquidoBaiCar - LValorLiquidoConCar, -0.29999999, 0.29999999);

  If Result Then
  Begin
    Result := FCloneDatasetBaiCar.Locate('MCA_NUMCCD', cdsConCar.FieldByName('MER_ORD_ID').AsString, []);
    If Not Result Then
      Exit;

    cdsBaiCar.Locate('AUTOINC', FCloneDatasetBaiCar.FieldByName('AUTOINC').AsString, []);

    cdsBaiCar.Edit;

    If Not cdsBaiCar.FieldByName('ALTERAR_BRUTO').AsString.Equals('S') Then
    Begin
      cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat := cdsConCar.FieldByName('VALOR_BRUTO').AsFloat -
                                                     Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);
      cdsBaiCar.FieldByName('MCA_FREMKT').AsFloat := Abs(cdsConCar.FieldByName('MER_VALENV').AsFloat) +
                                                     Abs(cdsConCar.FieldByName('REGISTROFRETE').AsFloat);
      cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat := Abs(RetornaValorTaxaRegistro(cdsConCar));
      cdsBaiCar.FieldByName('MCA_CUPMKT').AsFloat := cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat;
      cdsBaiCar.FieldByName('MCA_VALORI').AsFloat := cdsConCar.FieldByName('MER_VALLIQ').AsFloat;
      cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat := cdsConCar.FieldByName('MER_VALLIQ').AsFloat;
      cdsBaiCar.FieldByName('ALTERAR_BRUTO').AsString := 'S';

      cdsBaiCar.FieldByName('MCA_CHACON').AsString := INICAM + cdsConCar.FieldByName('MER_CODAUT').AsString + '_' +
                                                      cdsBaiCar.FieldByName('PARDUP').AsString + '_' +
                                                      cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                                                      FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('MER_DTATRA').Value);

      cdsConCar.Edit;
      cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat := cdsBaiCar.FieldByName('MCA_CUPMKT').AsFloat;
      cdsConCar.Post;

      AValorBruto := cdsConCar.FieldByName('VALOR_BRUTO').AsFloat - Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);
      AValorLiquido := cdsConCar.FieldByName('MER_VALLIQ').AsFloat;
      AValorTaxa := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;
    End
    Else
    Begin
      cdsBaiCar.FieldByName('MCA_FREMKT').AsFloat := cdsBaiCar.FieldByName('MCA_FREMKT').AsFloat +
                                                     Abs(cdsConCar.FieldByName('MER_VALENV').AsFloat) +
                                                     Abs(cdsConCar.FieldByName('REGISTROFRETE').AsFloat);
      cdsBaiCar.FieldByName('MCA_CUPMKT').AsFloat := cdsBaiCar.FieldByName('MCA_CUPMKT').AsFloat +
                                                     cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat;
      cdsBaiCar.FieldByName('MCA_VALORI').AsFloat := cdsBaiCar.FieldByName('MCA_VALORI').AsFloat +
                                                     cdsConCar.FieldByName('MER_VALLIQ').AsFloat;
      cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat := cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat +
                                                     cdsConCar.FieldByName('MER_VALLIQ').AsFloat;

      cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat +
                                                     cdsConCar.FieldByName('VALOR_BRUTO').AsFloat -
                                                     Abs(cdsConCar.FieldByName('MER_VALCUP').AsFloat);

      cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat -
                                                     (cdsBaiCar.FieldByName('MCA_VALORI').AsFloat +
                                                      cdsBaiCar.FieldByName('MCA_FREMKT').AsFloat +
                                                      cdsBaiCar.FieldByName('MCA_CUPMKT').AsFloat);

      cdsConCar.Edit;
      cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat := cdsBaiCar.FieldByName('MCA_CUPMKT').AsFloat;
      cdsConcar.FieldByName('MER_VALPRO').AsFloat := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
      cdsConcar.FieldByName('VALOR_BRUTO').AsFloat := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
      cdsConCar.FieldByName('MER_VALMPG').AsFloat := cdsConCar.FieldByName('FINANCING_FEE').AsFloat;
      cdsConCar.FieldByName('MER_VALLIQ').AsFloat := cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat;
      cdsConCar.FieldByName('MER_VALENV').AsFloat := cdsBaiCar.FieldByName('MCA_FREMKT').AsFloat * (-1);
      cdsConCar.FieldByName('REGISTROFRETE').AsFloat := 0.00;
      cdsConCar.FieldByName('MER_VALCUP').AsFloat := cdsBaiCar.FieldByName('MCA_CUPMKT').AsFloat;
      cdsConCar.FieldByName('MER_VALPLA').AsFloat := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat * (-1);
      cdsConCar.Post;

      AValorBruto := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
      AValorLiquido := cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat;
      AValorTaxa := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;
    End;

    cdsBaiCar.Post;

    For LRegistroRelatorio In FListaRegistrosRelatorio Do
    begin
      If LRegistroRelatorio.AutoIncremMovCar.Equals(cdsBaiCar.FieldByName('AUTOINC').AsString) Then
      Begin
        FListaRegistrosRelatorio.Remove(LRegistroRelatorio);
        Break;
      End;
    End;
  End;
end;

function TConcilaRecebiveisMercadoLivre.ValidaTodosOsRegistrosAgupadosPorShippingIdQueContenhamOrderId(
  var AValorBruto, AValorLiquido, AValorTaxa: Double): Boolean;
  Var
    LValorBrutoBaiCar,
    LValorBrutoConCar,

    LValorLiquidoBaiCar,
    LValorLiquidoConCar: Double;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  LValorBrutoBaiCar := 0;
  LValorBrutoConCar := 0;

  LValorLiquidoBaiCar := 0;
  LValorLiquidoConCar := 0;

  FCloneDatasetBaiCar.Filter := 'MCA_NUMNSU=''' + cdsConCar.FieldByName('MER_SHP_ID').AsString + ''' OR ' +
                                'MCA_NUMCCD=''' + cdsConCar.FieldByName('MER_SHP_ID').AsString + ''' ';
  FCloneDatasetBaiCar.Filtered := True;

  FCloneDatasetBaiCar.First;
  While Not FCloneDatasetBaiCar.Eof Do
  Begin
    LValorBrutoBaiCar := LValorBrutoBaiCar +
                         TMercadoLivreFuncoes.fFormataFloat(FCloneDatasetBaiCar.FieldByName('MCA_VALSTA').AsFloat, 2);

    LValorLiquidoBaiCar := LValorLiquidoBaiCar +
                           TMercadoLivreFuncoes.fFormataFloat(FCloneDatasetBaiCar.FieldByName('MCA_VALORI').AsFloat, 2);

    FCloneDatasetBaiCar.Next;
  End;

  FCloneDatasetConCar.Filter := 'MER_SHP_ID=''' + cdsConCar.FieldByName('MER_SHP_ID').AsString + ''' ';
  FCloneDatasetConCar.Filtered := True;

  FCloneDatasetConCar.First;
  While Not FCloneDatasetConCar.Eof Do
  Begin
    LValorBrutoConCar := LValorBrutoConCar +
                         TMercadoLivreFuncoes.fFormataFloat(FCloneDatasetConCar.FieldByName('VALOR_BRUTO').AsFloat, 2);

    LValorLiquidoConCar := LValorLiquidoConCar +
                           TMercadoLivreFuncoes.fFormataFloat(FCloneDatasetConCar.FieldByName('MER_VALLIQ').AsFloat, 2);

    FCloneDatasetConCar.Next;
  End;

  Result := fBetween(LValorBrutoBaiCar - LValorBrutoConCar, -0.29999999, 0.29999999);
  If Not Result Then
    Result := fBetween(LValorLiquidoBaiCar - LValorLiquidoConCar, -0.29999999, 0.29999999);
  If Not Result Then
  Begin
    If FCloneDatasetBaiCar.recordCount = 1 Then
      Result := LValorBrutoConCar >= LValorBrutoBaiCar;
  End;

  If Result Then
  Begin
    Result := FCloneDatasetBaiCar.Locate('MCA_ORDEID', cdsConCar.FieldByName('MER_ORD_ID').AsString, []);
    If Not Result Then
      Exit;

    cdsBaiCar.Locate('AUTOINC', FCloneDatasetBaiCar.FieldByName('AUTOINC').AsString, []);

    cdsBaiCar.Edit;

    If Not cdsBaiCar.FieldByName('ALTERAR_BRUTO').AsString.Equals('S') Then
    Begin
      cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat := cdsConCar.FieldByName('VALOR_BRUTO').AsFloat -
                                                     Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);
      cdsBaiCar.FieldByName('MCA_FREMKT').AsFloat := Abs(cdsConCar.FieldByName('MER_VALENV').AsFloat) +
                                                     Abs(cdsConCar.FieldByName('REGISTROFRETE').AsFloat);
      cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat := Abs(RetornaValorTaxaRegistro(cdsConCar));
      cdsBaiCar.FieldByName('MCA_CUPMKT').AsFloat := cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat;
      cdsBaiCar.FieldByName('MCA_VALORI').AsFloat := cdsConCar.FieldByName('MER_VALLIQ').AsFloat;
      cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat := cdsConCar.FieldByName('MER_VALLIQ').AsFloat;
      cdsBaiCar.FieldByName('ALTERAR_BRUTO').AsString := 'S';

      cdsBaiCar.FieldByName('MCA_CHACON').AsString := INICAM + cdsConCar.FieldByName('MER_CODAUT').AsString + '_' +
                                                      cdsBaiCar.FieldByName('PARDUP').AsString + '_' +
                                                      cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                                                      FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('MER_DTATRA').Value);

      cdsConCar.Edit;
      cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat := cdsBaiCar.FieldByName('MCA_CUPMKT').AsFloat;
      cdsConCar.Post;

      AValorBruto := cdsConCar.FieldByName('VALOR_BRUTO').AsFloat;
      AValorLiquido := cdsConCar.FieldByName('MER_VALLIQ').AsFloat;
      AValorTaxa := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;
    End
    Else
    Begin
      cdsBaiCar.FieldByName('MCA_FREMKT').AsFloat := cdsBaiCar.FieldByName('MCA_FREMKT').AsFloat +
                                                     Abs(cdsConCar.FieldByName('MER_VALENV').AsFloat) +
                                                     Abs(cdsConCar.FieldByName('REGISTROFRETE').AsFloat);
      cdsBaiCar.FieldByName('MCA_CUPMKT').AsFloat := cdsBaiCar.FieldByName('MCA_CUPMKT').AsFloat +
                                                     cdsConCar.FieldByName('MER_VALCUP').AsFloat;
      cdsBaiCar.FieldByName('MCA_VALORI').AsFloat := cdsBaiCar.FieldByName('MCA_VALORI').AsFloat +
                                                     cdsConCar.FieldByName('MER_VALLIQ').AsFloat;
      cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat := cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat +
                                                     cdsConCar.FieldByName('MER_VALLIQ').AsFloat;

      cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat +
                                                     cdsConCar.FieldByName('VALOR_BRUTO').AsFloat -
                                                     Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);

      cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat -
                                                     (cdsBaiCar.FieldByName('MCA_VALORI').AsFloat +
                                                      cdsBaiCar.FieldByName('MCA_FREMKT').AsFloat +
                                                      cdsBaiCar.FieldByName('MCA_CUPMKT').AsFloat);

      cdsConCar.Edit;
      cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat := cdsBaiCar.FieldByName('MCA_CUPMKT').AsFloat;
      cdsConcar.FieldByName('MER_VALPRO').AsFloat := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
      cdsConcar.FieldByName('VALOR_BRUTO').AsFloat := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
      cdsConCar.FieldByName('MER_VALMPG').AsFloat := cdsConCar.FieldByName('FINANCING_FEE').AsFloat;
      cdsConCar.FieldByName('MER_VALLIQ').AsFloat := cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat;
      cdsConCar.FieldByName('MER_VALENV').AsFloat := cdsBaiCar.FieldByName('MCA_FREMKT').AsFloat * (-1);
      cdsConCar.FieldByName('REGISTROFRETE').AsFloat := 0.00;
      cdsConCar.FieldByName('MER_VALCUP').AsFloat := cdsBaiCar.FieldByName('MCA_CUPMKT').AsFloat;
      cdsConCar.FieldByName('MER_VALPLA').AsFloat := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat * (-1);
      cdsConCar.Post;

      AValorBruto := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
      AValorLiquido := cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat;
      AValorTaxa := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;
    End;

    cdsBaiCar.Post;

    For LRegistroRelatorio In FListaRegistrosRelatorio Do
    begin
      If LRegistroRelatorio.AutoIncremMovCar.Equals(cdsBaiCar.FieldByName('AUTOINC').AsString) Then
      Begin
        FListaRegistrosRelatorio.Remove(LRegistroRelatorio);
        Break;
      End;
    End;
  End;
end;

function TConcilaRecebiveisMercadoLivre.ValidaValorBrutoELiquido(AValorBruto: Double;
  AValorLiquido: Double; AValidaTodosSeConciliado: Boolean = False): Boolean;
begin
  Result := fBetWeen(TMercadoLivreFuncoes.fFormataFloat(AValorBruto - cdsBaicar.FieldByName('MCA_VALSTA').AsFloat, 2), -0.50, 0.50);

  If Not Result Then
    Result := fBetWeen(TMercadoLivreFuncoes.fFormataFloat(AValorLiquido - cdsBaicar.FieldByName('MCA_VALDUP').AsFloat, 2), -0.50, 0.50);

  If Result Then
  Begin
    If Not AValidaTodosSeConciliado Then
      Exit;

    If cdsConCar.FieldByName('MER_CONCIL').AsString.Equals('1') Then
      Result := fBetWeen(TMercadoLivreFuncoes.fFormataFloat(AValorLiquido - cdsBaicar.FieldByName('MCA_VALDUP').AsFloat, 2), -0.50, 0.50);
  End;
end;

procedure TConcilaRecebiveisMercadoLivre.AdicionaRegistrosDeTransferenciasML(
  AFiltroTransferencia: String);
  Var
    LConsulta: TUniQuery;

    LRegistroRelatorio: TItensRelatorioCartoes;

    LValidaConfiguracoes: String;

    LConfiguracoesValidas: Boolean;
begin
  If objConcil.CfgPortadorTransferencia.IsEmpty Then
    Exit;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := Concat('SELECT CONCILIACAO.*, ',
                                 EmpresaSQL + ' AS EMPRESA, ',
                                 ' POR.SIS_VALCFG AS PORTADOR, ',
                                 ' CTA.SIS_VALCFG AS PLANODECONTAS, ',
                                 ' EVE.SIS_VALCFG AS CENTRODECUSTOS, ',
                                 ' CTD.SIS_VALCFG AS PLANODECONTAS_LANCDEB ',
                                 'FROM ',
                                 objConcil.TabelaConciliacao + ' AS CONCILIACAO ',
                                 'LEFT JOIN CFGSIS AS POR ON POR.SIS_CODEMP= ' + EmpresaSQL + ' AND ',
                                 '                           POR.SIS_CODCFG="CFG_' + objConcil.CfgPortadorTransferencia + '" ',
                                 'LEFT JOIN CFGSIS AS CTA ON CTA.SIS_CODEMP=' + EmpresaSQL + ' AND ',
                                 '                           CTA.SIS_CODCFG="CFG_' + objConcil.CfgPlanoDeContasTransferencia + '" ',
                                 'LEFT JOIN CFGSIS AS EVE ON EVE.SIS_CODEMP=' + EmpresaSQL + ' AND ',
                                 '                           EVE.SIS_CODCFG="CFG_' + objConcil.CfgCentroDeCustosTransferencia + '" ',
                                 'LEFT JOIN CFGSIS AS CTD ON CTD.SIS_CODEMP=' + EmpresaSQL + ' AND ',
                                 '                           CTD.SIS_CODCFG="CFG_' + objConcil.CfgPlanoDeContasTransferenciaLancDeb + '" ',
                                 'WHERE ',
                                 AFiltroTransferencia);
    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      LValidaConfiguracoes := Concat(LConsulta.FieldByName('PORTADOR').AsString,
                                     LConsulta.FieldByName('PLANODECONTAS').AsString,
                                     LConsulta.FieldByName('CENTRODECUSTOS').AsString);

      LConfiguracoesValidas := LValidaConfiguracoes.Length >= 12;
      If VS_FuncoesExternas.fICfgSis('CTPOBE', varBoolean) Then
        LConfiguracoesValidas := LValidaConfiguracoes.Length > 12;

      If Not LConfiguracoesValidas Then
      Begin
        LConsulta.Next;
        Continue;
      End;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LRegistroRelatorio.ValorBruto := TMercadoLivreFuncoes.fFormataFloat(LConsulta.FieldByName('MER_VALPRO').AsFloat, 2);
      LRegistroRelatorio.ValorLiquido := TMercadoLivreFuncoes.fFormataFloat(LConsulta.FieldByName('MER_VALLIQ').AsFloat, 2);

      LRegistroRelatorio.Descricao := 'TRANSFERÊNCIAS';
      LRegistroRelatorio.TipoDoRegistro := 'TRANSFERÊNCIA';
      LRegistroRelatorio.TipoCartao := 'TRANSFERÊNCIAS';
      LRegistroRelatorio.DescricaoAjuste := 'TRANSFERÊNCIA';

      LRegistroRelatorio.CodigoEmpresa := LConsulta.FieldByName('EMPRESA').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := LConsulta.FieldByName('EMPRESA').AsString;
      If LRegistroRelatorio.CodigoEmpresa.IsEmpty Then
      Begin
        LRegistroRelatorio.CodigoEmpresa := VS_FuncoesExternas.fIRetEmpresaLogada;
        LRegistroRelatorio.CodigoEstabelecimento := VS_FuncoesExternas.fIRetEmpresaLogada;
      End;

      LRegistroRelatorio.NumeroNSU := LConsulta.FieldByName(objConcil.CampoNumeroNSU).AsString;
      LRegistroRelatorio.NumeroCartao := '0';
      LRegistroRelatorio.Parcela := LeftStr(LConsulta.FieldByName(objConcil.CampoNumeroParcela).AsString, 2);
      LRegistroRelatorio.TotalParcelas := RightStr(LConsulta.FieldByName(objConcil.CampoNumeroParcela).AsString, 2);
      LRegistroRelatorio.CodigoAutorizacao := LConsulta.FieldByName(objConcil.CampoNumeroNSU).AsString;

      LRegistroRelatorio.DataVenda := LConsulta.FieldByName(objConcil.CampoDataRecebimento).AsDateTime;
      LRegistroRelatorio.DataPagamento := LConsulta.FieldByName(objConcil.CampoDataRecebimento).AsDateTime;

      LRegistroRelatorio.RegistroTransferencia := 'S';
      LRegistroRelatorio.PortadorTransferencia := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPortadorTransferencia, LRegistroRelatorio.CodigoEmpresa);
      LRegistroRelatorio.PlanoContasTransferenciaCredito := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPlanoDeContasTransferencia, LRegistroRelatorio.CodigoEmpresa);
      LRegistroRelatorio.CentroCustosTransferencia := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgCentroDeCustosTransferencia, LRegistroRelatorio.CodigoEmpresa);
      LRegistroRelatorio.PlanoContasTransferenciaDebito := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPlanoDeContasTransferenciaLancDeb, LRegistroRelatorio.CodigoEmpresa);

      LRegistroRelatorio.PortadorCredito := LRegistroRelatorio.PortadorTransferencia;
      LRegistroRelatorio.PortadorDebito := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPortadorAjustes, LRegistroRelatorio.CodigoEmpresa);

      If LRegistroRelatorio.PlanoContasTransferenciaDebito.IsEmpty Then
        LRegistroRelatorio.PlanoContasTransferenciaDebito := LConsulta.FieldByName('PLANODECONTAS').AsString;

      LRegistroRelatorio.Conciliado := LConsulta.FieldByName('MER_CONCIL').AsInteger;
      LRegistroRelatorio.NomeArquivo := LConsulta.FieldByName('MER_NOMARQ').AsString;

      LRegistroRelatorio.RegistroIncompleto := 'N';
      If Not LRegistroRelatorio.PortadorTransferencia.IsEmpty Then
      Begin
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, False, LConsulta);
        FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(LConsulta));
      End;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      LConsulta.Next;
    End;
  Finally
    TMercadoLivreFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

end.
