unit untConciliaRecebiveisMagazineLuiza;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, Vcl.Graphics, System.Generics.Collections,
     System.DateUtils,

     Uni, UniClientDataSet, cxProgressBar,

     untTMagazineLuizaFuncoes, untTLibCartoesMovCar, untLibCartoesInterfacesTipos,
     untMagazineLuizaConciliaRecebiveis, untMagazineLuizaTipos;


type
  TAjusteTransferencia = class
    private

    public
      dtaDataTranferencia: TDateTime;
      fltValorAjuste     : Double;
      intConciliado      : Integer;
  end;

type TConcilaRecebiveisMagazineLuiza = class(TConciliaRecebiveisMkt)
  private
    lstAjusteTransferencia: TObjectList<TAjusteTransferencia>;

    FRegistrosAgrupados,
    FArquivosRetiradas,
    FDatasetMovcarParceladas: TUniCLientDataset;

    FCartoesParaConciliacao,
    FPeriodoFiltro,
    FListaDePedidos,
    FCondicaoAjustes: String;

    FListaRegistrosConciliar,
    FListaRegistrosAjustesAgrupados,
    FListaArquivos: TStringList;

    FPortadorTransferencia,
    FPlanoContasTransferencia,
    FCentroCustosTransferencia,
    FPortadorBaixa,
    FCentroCustosBaixa,
    FPlanoContasBaixa,
    FFornecedorBaixa: String;

    FAutoIncremRelatorio: Integer;

    FListaParcelasCadastrar: TObjectList<TParcelasCadastrar>;

    procedure pFiltraCartoesMLZ;
    procedure pFiltraCartoesBaixadosMLZ;

    function RetornaListaDePedidos: String;

    function fBuscaCartaoMLZ(AAgrupado: Boolean = False): Boolean;
    function fBuscaCartaoBaixadoMLZ: Boolean;
    function BuscaCartaoAgrupadoMLZ: Boolean;

    procedure pFiltraCancelamentosMLZ(var prgStatus: TcxProgressBar);

    function RetornaSQLRegistrosImportados: String;
    function RetornaIDRepassePeriodo: String;

    procedure FiltraRegistrosAgrupados;
    procedure FiltraMovcarRegistrosParcelados;

    function AgruparERemoverRegistgrosDeFretesEAjustes: Boolean;
    procedure CarregaOCampoDoAjusteNaVendaConformeOTipoDoEvento(var ADatasetConciliacao,
                                                                ADatasetAjustes: TUniClientDataset;
                                                                AValorAjuste: Double);

    function RegistroCancelado: Boolean;

    procedure pAdicionaRegistrosDeTransferenciasMagazineLuiza;

    procedure GravaAjusteParaPedidoComErroDeIntegracaoPagoSemMovcar;

    function GravaAjusteParaRegistrosCancelados(pgbStatus: TcxProgressBar): Boolean;
    function GravaAjustesTransferencias(pgbStatus: TcxProgressBar): Boolean;

    function RetornaNomeArquivosConciliacao: String;

    procedure RemoveRegistroListaRelatorio(ADataset: TDataset);

    procedure ValidaSeDeveRealizarOParcelamentoNaBaixa(AAgrupado: Boolean = False;
                                                       AFoiMarcadaParaBaixa: Boolean = True);
    procedure ValidaSeVaiParcelarNaBaixaEDeveSerConciliado(var ASeraConciliado: Boolean);
    procedure RegistraNovaParcelaMovcarBaixada(var AREgistroRelatorio: TItensRelatorioCartoes;
                                               AValorTaxa: Double);

    function ExistemRegistrosImportados: Boolean;

    function ExisteParcelaA: Boolean;
    function JaPossuiMaisDeUmaParcelaComAChaveUniqueMOVCAR: Boolean;

    function fProcessaMLZPag(pgbStatus: TcxProgressBar): Boolean;
    function fConciliaMLZ(prgStatus: TcxProgressBar): Boolean;
  public
    constructor Create; overload;
    Destructor Destroy; override;

    function fConciliaCartoes(prgStatus: TcxProgressBar): Boolean; override;

    function RetornaEmpresaFiltrada: String;

    property ListaRegistrosConciliar: TStringList read FListaRegistrosConciliar;
    property AutoIncremRelatorio: Integer Read FAutoIncremRelatorio;
    property NomeArquivosConciliacao: String Read RetornaNomeArquivosConciliacao;

    property DatasetMovcarParceladas: TUniCLientDataset read FDatasetMovcarParceladas;
    property ListaParcelasCadastrar: TObjectList<TParcelasCadastrar> read FListaParcelasCadastrar;
  protected

  end;

Const
  INICAM = 'MLZ_';
  NOMTAB = 'MLZ_MZPGTO';

implementation

function TConcilaRecebiveisMagazineLuiza.fConciliaMLZ(prgStatus: TcxProgressBar): Boolean;
Begin
  Result         := False;

  FCartoesParaConciliacao := VS_FuncoesExternas.fICfgSis('MLZCAR', varString, RetornaEmpresaFiltrada);

  If FCartoesParaConciliacao.IsEmpty Then
  Begin
    TMagazineLuizaFuncoes.fMensagem('ATENÇÃO', 'Para realizar a baixa de recebíveis, deve selecionar os cartões referentes ' +
                                               'ao Magazine Luiza na configuração CFG_MLZCAR.', ['&Ok']);
    Exit;
  End;

  FRegistrosAgrupados := Nil;
  FArquivosRetiradas := Nil;
  FDatasetMovcarParceladas := Nil;

  FListaRegistrosConciliar:= Nil;
  FListaRegistrosAjustesAgrupados := Nil;

  lstAjusteTransferencia := Nil;
  Try
    Try
      FListaRegistrosConciliar := TStringList.Create;
      FListaRegistrosAjustesAgrupados := TStringList.Create;

      //Para conciliação por Ponto de Venda
      objConcil.TabelaConciliacao := NOMTAB;
      objConcil.CampoEstabelecimento := 'MLZ_CODEMP';
      objConcil.NomeConciliacao := 'MAGAZINE LUIZA';
      objConcil.CfgEstabelecimentos := '';
      objConcil.CampoValorBruto := 'MLZ_VALBRU';
      objConcil.CampoValorLiquido := 'MLZ_VALLIQ';
      objConcil.CampoCodigoAutorizacao := 'MLZ_ID_SEL';
      objConcil.CampoNumeroNSU := 'MLZ_ID_SEL';
      objConcil.CampoDataTransacaoVenda := 'MLZ_DTAPED';
      objConcil.CampoNumeroParcela := 'MLZ_NUMPAR';
      objConcil.CampoTotalParcelas := 'MLZ_TOTPAR';
      objConcil.CampoNumeroCartao := 'MLZ_ID_MLZ';
      objConcil.CampoDataRecebimento := 'MLZ_DTAPAG';
      objConcil.CampoTipoRegistro := 'MLZ_TIPREG';
      objConcil.CampoTipoTransacao := 'MLZ_TIPREG';
      objConcil.CfgPortadorAjustes := 'MLZPOR';
      objConcil.CfgPlanoDeContasAjustes := 'MLZCTA';
      objConcil.CfgFornecedorAjustes := 'MLZFOR';

      objConcil.strEventoCancelamentoAjuste    := 'MLZEVE';
      objConcil.CfgPortadorTransferencia       := 'MLZTRF';
      objConcil.CfgPlanoDeContasTransferencia  := 'MLZCTF';
      objConcil.CfgCentroDeCustosTransferencia := 'MLZETF';

      objConcil.strChavePrimaria := 'MLZ_TIPREG,MLZ_DTAPAG,MLZ_DTAPED,MLZ_ID_MLZ,MLZ_ID_SEL,MLZ_ID_TRA,MLZ_NUMPAR,MLZ_TIPEVE';

      FPortadorTransferencia     := VS_FuncoesExternas.fICfgSis(objConcil.CfgPortadorTransferencia, varString);
      FPlanoContasTransferencia  := VS_FuncoesExternas.fICfgSis(objConcil.CfgPlanoDeContasTransferencia, varString);
      FCentroCustosTransferencia := VS_FuncoesExternas.fICfgSis(objConcil.CfgCentroDeCustosTransferencia, varString);
      FCentroCustosBaixa         := VS_FuncoesExternas.fICfgSis(objConcil.strEventoCancelamentoAjuste, varString);
      FPortadorBaixa             := VS_FuncoesExternas.fICfgSis(objConcil.CfgPortadorAjustes, varString);
      FPlanoContasBaixa          := VS_FuncoesExternas.fICfgSis(objConcil.CfgPlanoDeContasAjustes, varString);
      FFornecedorBaixa           := VS_FuncoesExternas.fICfgSis(objConcil.CfgFornecedorAjustes, varString);

      If Not CarregaFiltrosParaBaixaRecebiveis(DataInicioPeriodo,
                                               DataFinalPeriodo,
                                               EmpresasPeriodo) Then
        Exit(False);

      lstAjusteTransferencia := TObjectList<TAjusteTransferencia>.Create;

      TMagazineLuizaFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Selecionando registros para conciliação (MAGAZINE LUIZA)', False);
      Result := fProcessaMLZPag(prgStatus);

      If Result Then
      Begin
        TMagazineLuizaFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Selecionando registros para conciliação (MAGAZINE LUIZA)', False);
        Result := GravaAjusteParaRegistrosCancelados(prgStatus);
      End;

      If Result Then
      Begin
        TMagazineLuizaFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Selecionando registros para conciliação (MAGAZINE LUIZA)', False);
        Result := GravaAjustesTransferencias(prgStatus);
      End;
    Except
      On E: Exception Do
      Begin
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TfrmBaixaCartoes.fConcilia' + StringReplace(objConcil.NomeConciliacao, ' ', EmptyStr, []) + ']');

        Exit(False);
      End;
    End;

    cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
    cdsBaiCar.Filtered := True;

    PossuiInconsistencia := False;

    If Not TryStrToInt(FRelatorioConciliacao.AutoIncremRelatorio, FAutoIncremRelatorio) Then
      FAutoIncremRelatorio := 0;

    TMagazineLuizaFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Gravando registros dos relatórios (' + objConcil.NomeConciliacao + ').', False);
    GravarRegistrosRelatorio(prgStatus);
  Finally
    If Assigned(FListaRegistrosAjustesAgrupados) Then
      FreeAndNil(FListaRegistrosAjustesAgrupados);

    TMagazineLuizaFuncoes.FreeAndNilDatasets(FArquivosRetiradas);
    TMagazineLuizaFuncoes.FreeAndNilDatasets(FRegistrosAgrupados);

    If Assigned(lstAjusteTransferencia) Then
      FreeAndNil(lstAjusteTransferencia);
  End;
End;

procedure TConcilaRecebiveisMagazineLuiza.FiltraMovcarRegistrosParcelados;
  Var
    LConsulta: TUniQuery;

    LListaPedidos: String;
begin
  cdsConcar.Filter := 'MLZ_TOTPAR<>''01'' ';
  cdsConcar.Filtered := True;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    If cdsConcar.IsEmpty Then
    Begin
      FDatasetMovcarParceladas :=  TMagazineLuizaFuncoes.CriarClientDataSet(
                                     TMagazineLuizaFuncoes.fCriarQuery('SELECT * FROM MOVCAR WHERE FALSE', True));

      Exit;
    End;

    LListaPedidos := EmptyStr;

    cdsConcar.First;
    While Not cdsConcar.Eof Do
    Begin
      If Not LListaPedidos.Contains(cdsConcar.FieldByName('MLZ_ID_SEL').AsString) Then
        LListaPedidos := LListaPedidos + '"' + cdsConcar.FieldByName('MLZ_ID_SEL').AsString + '",' +
                                         '"' + cdsConcar.FieldByName('MLZ_ID_SEL').AsString + '-1",' +
                                         '"' + cdsConcar.FieldByName('MLZ_ID_MLZ').AsString + '",';

      cdsConcar.Next;
    End;

    LListaPedidos := LeftStr(LListaPedidos, LListaPedidos.Length - 1);

    LConsulta.SQL.Text := 'SELECT AUTOINCREM, ' +
                          '       MCA_NUMCCD, ' +
                          '       MCA_NUMNSU, ' +
                          '       MCA_PARCEL, ' +
                          '       MCA_DTAREC, ' +
                          '       MCA_NUMDUP, ' +
                          '       MCA_CODEMP, ' +
                          '       MCA_CODCLI, ' +
                          '       MCA_CODCAR  ' +
                          'FROM MOVCAR ' +
                          'WHERE MCA_CODCAR IN (' + TMagazineLuizaFuncoes.fRetStrToSQLIn(FCartoesParaConciliacao) + ') ' +
                          '  AND (MCA_NUMCCD IN (' + LListaPedidos + ') OR ' +
                          '       MCA_NUMNSU IN (' + LListaPedidos + '))';
    LConsulta.Open;

    FDatasetMovcarParceladas := TMagazineLuizaFuncoes.CriarClientDataSet(LConsulta);
    FDatasetMovcarParceladas.Open;
  Finally
    cdsConcar.Filtered := False;
    cdsConcar.Filter := EmptyStr;
    cdsConCar.IndexFieldNames := '';

    cdsConcar.First;

    TMagazineLuizaFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

procedure TConcilaRecebiveisMagazineLuiza.FiltraRegistrosAgrupados;
  Var
    LRegistros: TUniQuery;
begin
  LRegistros := Nil;
  Try
    LRegistros := VS_FuncoesExternas.fICriaQuery;
    LRegistros.SQL.Text := 'SELECT MLZ_ID_SEL, MLZ_ID_MLZ, MLZ_NUMPAR, MLZ_DTAPAG, SUM(MLZ_VALLIQ) AS MLZ_VALLIQ ' +
                           ' FROM (' + RetornaSQLRegistrosImportados +
                           ' ) A GROUP BY MLZ_ID_MLZ, MLZ_NUMPAR, MLZ_DTAPAG ' +
                           ' HAVING COUNT(MLZ_NUMPAR) > 1';
    LRegistros.Open;

    FRegistrosAgrupados := TMagazineLuizaFuncoes.CriarClientDataSet(LRegistros);
  Finally
    TMagazineLuizaFuncoes.FreeAndNilDatasets(LRegistros);
  End;
end;

function TConcilaRecebiveisMagazineLuiza.fConciliaCartoes(prgStatus: TcxProgressBar): Boolean;
begin
  FPeriodoFiltro := EmptyStr;
  FListaParcelasCadastrar.Clear;

  Result := fConciliaMLZ(prgStatus);
end;

function TConcilaRecebiveisMagazineLuiza.fProcessaMLZPag(pgbStatus: TcxProgressBar): Boolean;
Var
  LBuscaPedido: Boolean;

  LValorBruto,
  LValorLiquido,
  LValorLiquidoAgrupado: Double;

  LSQL,
  LChaveConciliacao,
  LRegistroConciliar: String;

  LValorTaxa,
  LValorFrete,
  LValorCupom: Double;

  LParcelaSeraIncluidaEConciliada: Boolean;

  LConsulta: TUniQuery;

  LRegistroRelatorio: TItensRelatorioCartoes;
begin
  FTipoTransferenciaCaixa := VS_FuncoesExternas.fICfgSis('RCXTCC');
  
  Application.ProcessMessages;

  If Assigned(FListaArquivos) Then
    FreeAndNil(FListaArquivos);

  FListaArquivos := TStringList.Create;

  LSQL := RetornaSQLRegistrosImportados;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SHOW TABLES LIKE "' + NOMTAB + '"';
    LConsulta.Open;
    If LConsulta.IsEmpty Then
    Begin
      TMagazineLuizaFuncoes.fMensagem('ATENÇÃO','Não existem arquivos importados para a conciliação do ' + objConcil.NomeConciliacao + '!',['&OK']);
      Exit(False);
    End;

    LConsulta.Close;
    LConsulta.SQL.Text := LSQL;
    LConsulta.Open;
    cdsConCar := TMagazineLuizaFuncoes.CriarClientDataSet(LConsulta);
  Finally
    TMagazineLuizaFuncoes.FreeAndNilDatasets(LConsulta);
  End;

  FCartoesParaConciliacao := VS_FuncoesExternas.fICfgSis('MLZCAR', varString, RetornaEmpresaFiltrada);

  FiltraRegistrosAgrupados;

  pCalculaPeriodoFiltro(INICAM + 'DTAPED');

  FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                        'MAGAZINE LUIZA',
                                                        'CONCILIACAO',
                                                        RetornaFiltrosdigitados,
                                                        TMagazineLuizaFuncoes.RetornaDataHoraServidor,
                                                        TMagazineLuizaFuncoes.RetornaHoraServidor);

  pgbStatus.Visible := False;
  TMagazineLuizaFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Filtrando registros.', False);
  pFiltraCartoesMLZ;
  FiltraMovcarRegistrosParcelados;

  //Filtrando Cancelamentos/Ajustes
  FCondicaoAjustes := FPeriodoFiltro +
                      ' AND ((MLZ_TIPREG IN ("Estorno", "Evento", "account_balance")  AND MLZ_VALLIQ <> 0) OR ' +
                      '      (MLZ_TIPREG = "Transferência" AND MLZ_OBSERV IS NOT NULL AND MLZ_OBSERV<>"Pedidocomerronãoencontrado")) ';

  pgbStatus.Visible := True;
  pFiltraCancelamentosMLZ(pgbStatus);

  pAdicionaRegistrosDeTransferenciasMagazineLuiza;

  If Not ExistemRegistrosImportados Then
  Begin
    TMagazineLuizaFuncoes.fMensagem('ATENÇÃO','Não existem arquivos importados no período para a conciliação do ' + objConcil.NomeConciliacao + '!',['&OK']);
    Exit(False);
  End;

  Try
    pFiltraCartoesBaixadosMLZ;

    pgbStatus.Visible := True;

    TMagazineLuizaFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Processando lançamentos (' + objConcil.NomeConciliacao + ').', False);
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := cdsConCar.RecordCount;

    cdsConCar.First;
    While Not cdsConCar.EOF do
    Begin
      TMagazineLuizaFuncoes.pStepStatusGravacao(pgbStatus);

      FTextoInconsistencia := EmptyStr;

      LParcelaSeraIncluidaEConciliada := False;

      If FListaArquivos.IndexOf(cdsConCar.FieldByName('MLZ_NOMARQ').AsString) = -1 Then
        FListaArquivos.Add(cdsConCar.FieldByName('MLZ_NOMARQ').AsString);

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LValorBruto  := cdsConCar.FieldByName('VALOR_BRUTO').Value;
      LValorLiquido := cdsConCar.FieldByName(INICAM + 'VALLIQ').Value;
      LValorFrete := TMagazineLuizaFuncoes.fFormataFloat(Abs(cdsConCar.FieldByName('REGISTROFRETE').AsFloat), 2);
      LValorTaxa := Abs(cdsConCar.FieldByName('MLZ_VALCOM').AsFloat) +
                    Abs(cdsConCar.FieldByName('MLZ_FIXPAR').AsFloat);
      LValorCupom := Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);

      If FormatFloat(',0.00', LValorLiquido - LValorBruto).Equals(FormatFloat(',0.00', LValorLiquido)) Then
        LValorBruto := LValorLiquido + LValorTaxa + LValorFrete;

      If LValorLiquido > 0 Then
        LValortaxa := LValorBruto +
                      LValorCupom -
                      Abs(LValorFrete) -
                      Abs(cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat) -
                      LValorLiquido;

      LBuscaPedido := fBuscaCartaoMLZ;
      If LBuscaPedido Then
      Begin
        LChaveConciliacao := INICAM + cdsConCar.FieldByName('MLZ_ID_SEL').AsString + '_' +
                             cdsBaiCar.FieldByName('PARDUP').AsString + '_' +
                             cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                             FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('MLZ_DTAPED').AsDateTime);

        MarcarCartaoEncontradoArquivo(LValorBruto,
                                      LValorLiquido,
                                      LRegistroRelatorio,
                                      LChaveConciliacao,
                                      cdsConCar,
                                      LValorFrete,
                                      Abs(cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat),
                                      Abs(LValorTaxa),
                                      Abs(LValorCupom));

        LRegistroRelatorio.Conciliado := 0;
        If cdsBaiCar.FieldByName('MCA_MARDES').AsString = 'M' Then
        Begin
          If Not FTextoInconsistencia.IsEmpty Then
            LRegistroRelatorio.SomarNoTotal := 'N';

          cdsConCar.Edit;
          cdsConCar.FieldByName('MARCADO').AsString := 'S';
          cdsConCar.Post;

          FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(cdsConCar));

          If LValorLiquido > 0 Then
            ValidaSeDeveRealizarOParcelamentoNaBaixa;
        End;

      End
      Else If BuscaCartaoAgrupadoMLZ Then
      Begin
        LBuscaPedido := fBuscaCartaoMLZ(True);

        If LBuscaPedido Then
        Begin
          LChaveConciliacao := INICAM + cdsConCar.FieldByName('MLZ_ID_SEL').AsString + '_' +
                               cdsBaiCar.FieldByName('PARDUP').AsString + '_' +
                               cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                               FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('MLZ_DTAPED').AsDateTime);

          LValorLiquidoAgrupado := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat + LValorLiquido;

          MarcarCartaoEncontradoArquivo(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat + LValorBruto,
                                        cdsBaiCar.FieldByName('MCA_VALREC').AsFloat + LValorLiquido,
                                        LRegistroRelatorio,
                                        LChaveConciliacao,
                                        cdsConCar,
                                        cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat + LValorFrete,
                                        cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat + Abs(cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat),
                                        cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat + Abs(LValorTaxa),
                                        cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat + Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat));

          FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(cdsConCar));

          cdsConcar.Edit;
          cdsConCar.FieldByName('VALOR_BRUTO').AsFloat := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
          cdsConCar.FieldByName('MLZ_VALLIQ').AsFloat := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;
          cdsConCar.FieldByName('REGISTROFRETE').AsFloat := cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat;
          cdsConCar.FieldByName('MLZ_VALCOM').AsFloat := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;
          cdsConCar.FieldByName('MLZ_FIXPAR').AsFloat := 0;
          cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat := cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat;
          cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat := cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat;

          If LValorLiquidoAgrupado < 0 Then
          Begin
            cdsConCar.FieldByName('MLZ_VALLIQ').AsFloat := LValorLiquidoAgrupado;
            cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat := cdsConCar.FieldByName('VALOR_BRUTO').AsFloat +
                                                               Abs(LValorLiquidoAgrupado);
          End;

          cdsConCar.Post;
        
          LValorBruto := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
          LValorLiquido := cdsConCar.FieldByName('MLZ_VALLIQ').AsFloat;
          LValorTaxa := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;
          LValorFrete := cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat;

          LRegistroRelatorio.Conciliado := 0;

          RemoveRegistroListaRelatorio(cdsConCar);

          If LValorLiquido > 0 Then
            ValidaSeDeveRealizarOParcelamentoNaBaixa(True);
        End;
      End;

      If Not LBuscaPedido Then
      Begin
        If LValorLiquido > 0 Then
          FTextoInconsistencia := 'Vendas não encontradas nos lançamentos do sistema';

        LBuscaPedido := fBuscaCartaoBaixadoMLZ;
        If LBuscaPedido Then
        Begin
          FTextoInconsistencia := 'Vendas já foram baixadas';
          LRegistroRelatorio.InconsistenciaConciliada := 'S';
          LRegistroRelatorio.Conciliado := 1;
          LRegistroRelatorio.AutoIncremMovCar := cdsBaixad.FieldByName('AUTOINCREM').AsString;
        End;
      end;

      If RegistroCancelado Then
      Begin
        cdsConCar.Next;

        FreeAndNil(LRegistroRelatorio);
        Continue;
      End;

      If FTextoInconsistencia.Equals('Vendas não encontradas nos lançamentos do sistema') Then
      Begin
        ValidaSeVaiParcelarNaBaixaEDeveSerConciliado(LParcelaSeraIncluidaEConciliada);
        If LParcelaSeraIncluidaEConciliada Then
        Begin
          RegistraNovaParcelaMovcarBaixada(LRegistroRelatorio, LValortaxa);

          If LRegistroRelatorio.Parcela.Equals(cdsConCar.FieldByName('MLZ_NUMPAR').AsString) Then
            FTextoInconsistencia := EmptyStr;
        End
        Else
        Begin
          ValidaSeDeveRealizarOParcelamentoNaBaixa(False, False);

          ValidaSeVaiParcelarNaBaixaEDeveSerConciliado(LParcelaSeraIncluidaEConciliada);
          If LParcelaSeraIncluidaEConciliada Then
          Begin
            RegistraNovaParcelaMovcarBaixada(LRegistroRelatorio, LValorTaxa);

            If LRegistroRelatorio.Parcela.Equals(cdsConCar.FieldByName('MLZ_NUMPAR').AsString) Then
              FTextoInconsistencia := EmptyStr;
          End;
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
      LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('MLZ_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := cdsConCar.FieldByName('CODEMP').AsString;
      LRegistroRelatorio.CodigoEmpresa := cdsConCar.FieldByName('CODEMP').AsString;
      LRegistroRelatorio.NumeroNSU := cdsConCar.FieldByName('MLZ_ID_MLZ').AsString;
      LRegistroRelatorio.CodigoAutorizacao := cdsConCar.FieldByName('MLZ_ID_SEL').AsString;
      LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('MLZ_ID_TRA').AsString;
      LRegistroRelatorio.NumeroCartao := cdsConCar.FieldByName('MLZ_ID_MLZ').AsString;

      LRegistroRelatorio.TipoCartao := 'CRÉDITO ROTATIVO';

      LRegistroRelatorio.Parcela := TMagazineLuizaFuncoes.fStrZero(cdsConCar.FieldByName('MLZ_NUMPAR').AsString, 2);
      LRegistroRelatorio.TotalParcelas := TMagazineLuizaFuncoes.fStrZero(cdsConCar.FieldByName('MLZ_TOTPAR').AsString, 2);
      LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('MLZ_DTAPAG').Value;
      LRegistroRelatorio.DataVenda := cdsConCar.FieldByName('MLZ_DTAPED').Value;
      LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('MLZ_DTAPAG').Value;

      LRegistroRelatorio.ValorBruto := LValorBruto;

      LRegistroRelatorio.ValorLiquido := LValorLiquido;
      LRegistroRelatorio.ValorTaxas := LValorTaxa;
      LRegistroRelatorio.ValorFrete := Abs(LValorFrete);
      LRegistroRelatorio.ValorAjustes := Abs(cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat);
      LRegistroRelatorio.ValorCupom := Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);
      LRegistroRelatorio.DescricaoBandeira := objConcil.NomeConciliacao;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      cdsConCar.Next;
    End;

    For LRegistroConciliar In FListaRegistrosAjustesAgrupados Do
      FListaRegistrosConciliar.Add(LRegistroConciliar);
  Finally
    TMagazineLuizaFuncoes.FreeAndNilDatasets(cdsBaixad);
  End;

  Result := True;
end;

procedure TConcilaRecebiveisMagazineLuiza.GravaAjusteParaPedidoComErroDeIntegracaoPagoSemMovcar;
  Var
    LRegistroRelatorio: TItensRelatorioCartoes;

    LCodigoEmpresa: String;
begin
  LRegistroRelatorio := TItensRelatorioCartoes.Create;

  LCodigoEmpresa := cdsConCar.FieldByName('CODEMP').Value;

  {Gerando registro do relatório}
  LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
  LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
  LRegistroRelatorio.DescricaoAjuste := cdsConCar.FieldByName('MLZ_OBSERV').AsString + ' - ' + cdsConcar.FieldByName('MLZ_ID_SEL').AsString;
  LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('MLZ_NOMARQ').AsString;
  LRegistroRelatorio.CodigoEstabelecimento := LCodigoEmpresa;
  LRegistroRelatorio.CodigoEmpresa := LCodigoEmpresa;
  LRegistroRelatorio.NumeroNSU := cdsConCar.FieldByName('MLZ_ID_MLZ').AsString;
  LRegistroRelatorio.CodigoAutorizacao := cdsConCar.FieldByName('MLZ_ID_SEL').AsString;
  LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('MLZ_ID_TRA').AsString;
  LRegistroRelatorio.NumeroCartao := 'MAGAZINE LUIZA';

  LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';

  LRegistroRelatorio.Parcela := TMagazineLuizaFuncoes.fStrZero(cdsConCar.FieldByName('MLZ_NUMPAR').AsString, 2);
  LRegistroRelatorio.TotalParcelas := TMagazineLuizaFuncoes.fStrZero(cdsConCar.FieldByName('MLZ_TOTPAR').AsString, 2);
  LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('MLZ_DTAPAG').Value;
  LRegistroRelatorio.DataVenda := cdsConCar.FieldByName('MLZ_DTAPED').Value;
  LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('MLZ_DTAPAG').Value;

  LRegistroRelatorio.ValorBruto := cdsConCar.FieldByName('MLZ_VALLIQ').Value;
  LRegistroRelatorio.ValorLiquido := cdsConCar.FieldByName('MLZ_VALLIQ').Value;

  LRegistroRelatorio.ValorTaxas := 0;
  LRegistroRelatorio.ValorFrete := 0;
  LRegistroRelatorio.ValorAjustes := 0;
  LRegistroRelatorio.ValorCupom := 0;

  LRegistroRelatorio.DescricaoBandeira := objConcil.NomeConciliacao;

  LRegistroRelatorio.Conciliado := cdsConCar.FieldByName('MLZ_CONCIL').AsInteger;

  GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, cdsConCar);

  FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(cdsConCar));

  FListaRegistrosRelatorio.Add(LRegistroRelatorio);
end;

function TConcilaRecebiveisMagazineLuiza.GravaAjusteParaRegistrosCancelados(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    LFiltroAnterior: String;

    LRegistroRelatorio: TItensRelatorioCartoes;

    LCodigoEmpresa: String;
begin
  Result := True;

  LFiltroAnterior := cdsConCar.Filter;

  cdsConCar.Filter := 'MLZ_VALLIQ < 0 ';
  cdsConCar.Filtered := True;

  pgbStatus.Properties.Max := cdsConCar.RecordCount;
  pgbStatus.Position := 0;

  cdsConCar.First;
  While Not cdsConCar.Eof Do
  Begin
    TMagazineLuizaFuncoes.pStepStatusGravacao(pgbStatus);

    LRegistroRelatorio := TItensRelatorioCartoes.Create;

    LCodigoEmpresa := cdsConCar.FieldByName('CODEMP').Value;

    {Gerando registro do relatório}
    LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
    LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
    LRegistroRelatorio.DescricaoAjuste := 'Débito de vendas canceladas - ' + cdsConcar.FieldByName('MLZ_ID_SEL').AsString;
    LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('MLZ_NOMARQ').AsString;
    LRegistroRelatorio.CodigoEstabelecimento := LCodigoEmpresa;
    LRegistroRelatorio.CodigoEmpresa := LCodigoEmpresa;
    LRegistroRelatorio.NumeroNSU := cdsConCar.FieldByName('MLZ_ID_MLZ').AsString;
    LRegistroRelatorio.CodigoAutorizacao := cdsConCar.FieldByName('MLZ_ID_SEL').AsString;
    LRegistroRelatorio.ResumoVenda := cdsConCar.FieldByName('MLZ_ID_TRA').AsString;
    LRegistroRelatorio.NumeroCartao := 'MAGAZINE LUIZA';

    LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';

    LRegistroRelatorio.Parcela := TMagazineLuizaFuncoes.fStrZero(cdsConCar.FieldByName('MLZ_NUMPAR').AsString, 2);
    LRegistroRelatorio.TotalParcelas := TMagazineLuizaFuncoes.fStrZero(cdsConCar.FieldByName('MLZ_TOTPAR').AsString, 2);
    LRegistroRelatorio.DataPagamento := cdsConCar.FieldByName('MLZ_DTAPAG').Value;
    LRegistroRelatorio.DataVenda := cdsConCar.FieldByName('MLZ_DTAPED').Value;
    LRegistroRelatorio.DataVencimento := cdsConCar.FieldByName('MLZ_DTAPAG').Value;

    LRegistroRelatorio.ValorBruto := cdsConCar.FieldByName('MLZ_VALLIQ').Value;
    LRegistroRelatorio.ValorLiquido := cdsConCar.FieldByName('MLZ_VALLIQ').Value;

    If LRegistroRelatorio.ValorLiquido > 0 Then
      LRegistroRelatorio.DescricaoAjuste := cdsConCar.FieldByName('MLZ_OBSERV').AsString;

    LRegistroRelatorio.ValorTaxas := 0;
    LRegistroRelatorio.ValorFrete := 0;
    LRegistroRelatorio.ValorAjustes := 0;
    LRegistroRelatorio.ValorCupom := 0;

    LRegistroRelatorio.DescricaoBandeira := objConcil.NomeConciliacao;

    LRegistroRelatorio.Conciliado := cdsConCar.FieldByName('MLZ_CONCIL').AsInteger;

    GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, cdsConCar);

    FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(cdsConCar));

    FListaRegistrosRelatorio.Add(LRegistroRelatorio);

    cdsConCar.Next;
  End;

  cdsConCar.Filter := LFiltroAnterior;
  cdsConCar.Filtered := Not LFiltroAnterior.IsEmpty;
end;

function TConcilaRecebiveisMagazineLuiza.GravaAjustesTransferencias(
  pgbStatus: TcxProgressBar): Boolean;
  Var
    LRegistroRelatorio: TItensRelatorioCartoes;

    LCodigoEmpresa: String;

    LTransferencia: TAjusteTransferencia;
begin
  Result := True;

  If lstAjusteTransferencia.Count = 0 Then
    Exit;

  pgbStatus.Properties.Max := lstAjusteTransferencia.Count;
  pgbStatus.Position := 0;

  cdsConCar.First;
  For LTransferencia In lstAjusteTransferencia Do
  Begin
    TMagazineLuizaFuncoes.pStepStatusGravacao(pgbStatus);

    LRegistroRelatorio := TItensRelatorioCartoes.Create;

    LCodigoEmpresa := RetornaEmpresaFiltrada;

    {Gerando registro do relatório}
    LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
    LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
    LRegistroRelatorio.DescricaoAjuste := 'Taxa de transferência';
    LRegistroRelatorio.NomeArquivo := cdsConCar.FieldByName('MLZ_NOMARQ').AsString;
    LRegistroRelatorio.CodigoEstabelecimento := LCodigoEmpresa;
    LRegistroRelatorio.CodigoEmpresa := LCodigoEmpresa;
    LRegistroRelatorio.NumeroNSU := '0000000000';
    LRegistroRelatorio.CodigoAutorizacao := '0000000000';
    LRegistroRelatorio.ResumoVenda := '0000000000';
    LRegistroRelatorio.NumeroCartao := 'MAGAZINE LUIZA';

    LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';

    LRegistroRelatorio.Parcela := '01';
    LRegistroRelatorio.TotalParcelas := '01';
    LRegistroRelatorio.DataPagamento := LTransferencia.dtaDataTranferencia;
    LRegistroRelatorio.DataVenda := LTransferencia.dtaDataTranferencia;
    LRegistroRelatorio.DataVencimento := LTransferencia.dtaDataTranferencia;

    LRegistroRelatorio.ValorBruto := Abs(LTransferencia.fltValorAjuste) * -1;
    LRegistroRelatorio.ValorLiquido := Abs(LTransferencia.fltValorAjuste) * -1;

    LRegistroRelatorio.ValorTaxas := 0;
    LRegistroRelatorio.ValorFrete := 0;
    LRegistroRelatorio.ValorAjustes := 0;
    LRegistroRelatorio.ValorCupom := 0;

    LRegistroRelatorio.DescricaoBandeira := objConcil.NomeConciliacao;

    LRegistroRelatorio.Conciliado := LTransferencia.intConciliado;

    GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True);

    FListaRegistrosRelatorio.Add(LRegistroRelatorio);
  End;
end;

function TConcilaRecebiveisMagazineLuiza.JaPossuiMaisDeUmaParcelaComAChaveUniqueMOVCAR: Boolean;
  Var
    LConsulta: TUniQuery;
begin
  If FDatasetMovcarParceladas.IsEmpty Then
    Exit(False);

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT IFNULL(COUNT(MCA_PARCEL), 0) AS PARCELAS ' +
                          'FROM MOVCAR ' +
                          'WHERE MCA_NUMDUP=:NUMDUP ' +
                          '  AND MCA_CODEMP=:CODEMP ' +
                          '  AND MCA_CODCLI=:CODCLI ';

    LConsulta.ParamByName('NUMDUP').AsString := FDatasetMovcarParceladas.FieldByName('MCA_NUMDUP').AsString;
    LConsulta.ParamByName('CODEMP').AsString := FDatasetMovcarParceladas.FieldByName('MCA_CODEMP').AsString;
    LConsulta.ParamByName('CODCLI').AsString := FDatasetMovcarParceladas.FieldByName('MCA_CODCLI').AsString;
    LConsulta.Open;

    Result := LConsulta.FieldByName('PARCELAS').AsInteger > 1;
  Finally
    TMagazineLuizaFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

function TConcilaRecebiveisMagazineLuiza.fBuscaCartaoMLZ(AAgrupado: Boolean = False): Boolean;
 Var
   LParcelaStr,
   LMarcado: String;

   LintParcela: Integer;
begin
  LParcelaStr := TMagazineLuizaFuncoes.fGetLetraAlfa(cdsConCar.FieldByName('MLZ_NUMPAR').AsInteger);

  If cdsConCar.FieldByName('MLZ_TOTPAR').AsInteger > 26 Then
  Begin
    If TryStrToInt(cdsConCar.FieldByName('MLZ_NUMPAR').AsString, LintParcela) Then
      LParcelaStr := TMagazineLuizaFuncoes.fStrZero(cdsConCar.FieldByName(INICAM + 'NUMPAR').AsString, 3);
  End;

  LMarcado := 'D';
  If AAgrupado Then
    LMarcado := 'M';

  Result := cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_MARDES',
                             VarArrayOf([UpperCase(cdsConCar.FieldByName('MLZ_ID_SEL').AsString),
                                         LParcelaStr,
                                         LMarcado]),[]);

  If Not Result Then
    Result := cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_MARDES',
                               VarArrayOf([UpperCase(cdsConCar.FieldByName('MLZ_ID_MLZ').AsString),
                                           LParcelaStr,
                                           LMarcado]),[]);

  If Not Result Then
    Result := cdsBaiCar.Locate('PARDUP;MCA_MARDES;MCA_NUMCCD',
                               VarArrayOf([LParcelaStr,
                                           LMarcado,
                                           UpperCase(cdsConCar.FieldByName('MLZ_ID_MLZ').AsString)]),[loPartialKey]);

  If Not Result Then
    Result := cdsBaiCar.Locate('PARDUP;MCA_MARDES;MCA_NUMCCD',
                               VarArrayOf([LParcelaStr,
                                           LMarcado,
                                           UpperCase(cdsConCar.FieldByName('MLZ_ID_SEL').AsString)]),[loPartialKey]);

  If Not Result Then
    Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                               VarArrayOf([UpperCase(cdsConCar.FieldByName('MLZ_ID_SEL').AsString),
                                           LParcelaStr,
                                           LMarcado]),[]);

  If Not Result Then
    Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                               VarArrayOf([UpperCase(cdsConCar.FieldByName('MLZ_ID_MLZ').AsString),
                                           LParcelaStr,
                                           LMarcado]),[]);

  If Not Result Then
    Result := cdsBaiCar.Locate('PARDUP;MCA_MARDES;MCA_NUMNSU',
                               VarArrayOf([LParcelaStr,
                                           LMarcado,
                                           UpperCase(cdsConCar.FieldByName('MLZ_ID_SEL').AsString)]),[loPartialKey]);
end;

function TConcilaRecebiveisMagazineLuiza.AgruparERemoverRegistgrosDeFretesEAjustes: Boolean;
  Var
    LAjusteCalculado,
    LSomaAjuste,
    LValorBrutoTotal,
    LValorTotalAjuste,
    LValorLiquidoTotal: Double;
begin
  LSomaAjuste := 0;
  LValorTotalAjuste := TMagazineLuizaFuncoes.fFormataFloat(cdsAjustes.FieldByName('MLZ_VALLIQ').AsFloat, 2);

  cdsConCar.Filter := '(MLZ_ID_MLZ=''' + cdsAjustes.FieldByName('MLZ_ID_MLZ').AsString + ''' OR ' +
                      ' MLZ_ID_MLZ=''' + cdsAjustes.FieldByName('MLZ_PEDEVE').AsString + ''') AND ' +
                      ' MLZ_NUMPAR=''' + cdsAjustes.FieldByName('MLZ_NUMPAR').AsString + ''' ';

  cdsConCar.Filtered := True;

  Try
    Result := Not cdsConcar.isEmpty;
    If Result Then
    Begin
       LValorLiquidoTotal := 0;
       LValorBrutoTotal := 0;
       While Not cdsConCar.Eof Do
       Begin
         LValorBrutoTotal := LValorBrutoTotal +
                             TMagazineLuizaFuncoes.fFormataFloat(cdsConCar.FieldByName('VALOR_BRUTO').AsFloat, 2);
         LValorLiquidoTotal := LValorLiquidoTotal +
                               TMagazineLuizaFuncoes.fFormataFloat(cdsConCar.FieldByName('MLZ_VALLIQ').AsFloat, 2);

         cdsConCar.Next;
       End;

      cdsConCar.First;
      While Not cdsConCar.Eof Do
      Begin
        LAjusteCalculado := LValorTotalAjuste;

        If cdsConCar.RecordCount > 1 Then
        Begin
          LAjusteCalculado := TMagazineLuizaFuncoes.fFormataFloat(LValorTotalAjuste * (cdsConCar.FieldByName('VALOR_BRUTO').AsFloat / LValorBrutoTotal), 2);
          LSomaAjuste := LSomaAjuste + LAjusteCalculado;
          If cdsConCar.RecNo = cdsConCar.RecordCount Then
          Begin
            If Not FormatFloat('0.00', LSomaAjuste).Equals(FormatFloat('0.00', LValorTotalAjuste)) Then
              LAjusteCalculado := LAjusteCalculado + TMagazineLuizaFuncoes.fFormataFloat(LValorTotalAjuste - LSomaAjuste, 2);
          End;
        End;

        cdsConCar.Edit;

        CarregaOCampoDoAjusteNaVendaConformeOTipoDoEvento(cdsConCar, cdsAjustes, LAjusteCalculado);

        cdsConCar.Post;

        cdsConCar.Next;
      End;
    End;
  Finally
    cdsConCar.Filter := '';
    cdsConCar.Filtered := False;
  End;

  Result := cdsAjustes.FieldByName('MARCADO').AsString.Equals('S');
end;

function TConcilaRecebiveisMagazineLuiza.BuscaCartaoAgrupadoMLZ: Boolean;
begin
  Result := FRegistrosAgrupados.Locate('MLZ_ID_SEL;MLZ_NUMPAR;MLZ_DTAPAG',
                                        VarArrayOf([UpperCase(cdsConCar.FieldByName('MLZ_ID_SEL').AsString),
                                                    cdsConCar.FieldByName('MLZ_NUMPAR').AsString,
                                                    cdsConCar.FieldByName('MLZ_DTAPAG').Value]),[]);

  If Not Result Then
    Result := FRegistrosAgrupados.Locate('MLZ_ID_MLZ;MLZ_NUMPAR;MLZ_DTAPAG',
                               VarArrayOf([UpperCase(cdsConCar.FieldByName('MLZ_ID_MLZ').AsString),
                                           cdsConCar.FieldByName('MLZ_NUMPAR').AsString,
                                                    cdsConCar.FieldByName('MLZ_DTAPAG').Value]),[]);
End;

procedure TConcilaRecebiveisMagazineLuiza.CarregaOCampoDoAjusteNaVendaConformeOTipoDoEvento(
  var ADatasetConciliacao, ADatasetAjustes: TUniClientDataset; AValorAjuste: Double);
  Var
    LTipoEvento: String;

    LAjusteProcessado: Boolean;
begin
  LTipoEvento := TMagazineLuizaFuncoes.fRemoveAcento(ADatasetAjustes.FieldByName('MLZ_TIPEVE').AsString).ToUpperInvariant;

  If ADatasetAjustes.FieldByName('MLZ_TIPREG').AsString.Equals('Estorno') Then
  Begin
    ADatasetConciliacao.FieldByName('REGISTROAJUSTE').AsFloat := ADatasetConciliacao.FieldByName('REGISTROAJUSTE').AsFloat +
                                                                 Abs(AValorAjuste);
    LAjusteProcessado := True;
  End
  Else
  Begin
    If LTipoEvento.Contains('MAGALUEVENTO:COPARTICIPACAODEFRETE') Then
    Begin
      If AValorAjuste < 0 Then
      Begin
        If ADatasetConciliacao.FieldByName('MLZ_VALLIQ').AsFloat < Abs(AValorAjuste) Then
          Exit;

        ADatasetConciliacao.FieldByName('REGISTROFRETE').AsFloat := ADatasetConciliacao.FieldByName('REGISTROFRETE').AsFloat +
                                                                    Abs(AValorAjuste);
      End
      Else
        ADatasetConciliacao.FieldByName('CUPOMDESCONTO').AsFloat := ADatasetConciliacao.FieldByName('CUPOMDESCONTO').AsFloat +
                                                                    AValorAjuste;

      LAjusteProcessado := True;
    End
    Else If MatchStr(LTipoEvento, ['MAGALUEVENTO:DISPERSAOCUBAGEM',
                                   'MAGALUEVENTO:SUBSIDIOPRECOPROMOCIONALTECH',
                                   'MAGALUEVENTO:REVERSAO:SUBPRECOPROMOCIONAL']) Then
    Begin
      If AValorAjuste < 0 Then
        ADatasetConciliacao.FieldByName('REGISTROAJUSTE').AsFloat := ADatasetConciliacao.FieldByName('REGISTROAJUSTE').AsFloat +
                                                                     Abs(AValorAjuste)
      Else
        ADatasetConciliacao.FieldByName('CUPOMDESCONTO').AsFloat := ADatasetConciliacao.FieldByName('CUPOMDESCONTO').AsFloat +
                                                                    AValorAjuste;

      LAjusteProcessado := True;
    End
    Else
    Begin
      If AValorAjuste < 0 Then
        ADatasetConciliacao.FieldByName('MLZ_VALCOM').AsFloat := ADatasetConciliacao.FieldByName('MLZ_VALCOM').AsFloat +
                                                                 Abs(AValorAjuste)
      Else
        ADatasetConciliacao.FieldByName('CUPOMDESCONTO').AsFloat := ADatasetConciliacao.FieldByName('CUPOMDESCONTO').AsFloat +
                                                                    AValorAjuste;

      LAjusteProcessado := True;
    End;
  End;

  If Not LAjusteProcessado Then
    Exit;

  ADatasetAjustes.Edit;
  ADatasetAjustes.FieldByName('MLZ_VALLIQ').AsFloat := ADatasetAjustes.FieldByName('MLZ_VALLIQ').AsFloat -
                                                       AValorAjuste;

  ADatasetAjustes.FieldByName('MARCADO').AsString := 'N';
  If FormatFloat(',0.00', ADatasetAjustes.FieldByName('MLZ_VALLIQ').AsFloat).Equals('0,00') Then
    ADatasetAjustes.FieldByName('MARCADO').AsString := 'S';
  ADatasetAjustes.Post;

  ADatasetConciliacao.FieldByName('MLZ_VALLIQ').AsFloat := ADatasetConciliacao.FieldByName('MLZ_VALLIQ').AsFloat +
                                                           AValorAjuste;
end;

constructor TConcilaRecebiveisMagazineLuiza.Create;
begin
  inherited;
  FListaArquivos := TStringList.Create;

  FListaParcelasCadastrar := TObjectList<TParcelasCadastrar>.Create;
end;

destructor TConcilaRecebiveisMagazineLuiza.Destroy;
begin
  inherited;
  FreeAndNil(FListaArquivos);
  FreeAndNil(FListaParcelasCadastrar);

  If Assigned(FDatasetMovcarParceladas) Then
    FreeAndNil(FDatasetMovcarParceladas);
end;

function TConcilaRecebiveisMagazineLuiza.ExistemRegistrosImportados: Boolean;
begin
  Result := FListaRegistrosRelatorio.Count > 0;

  If Not Result Then
    Result := Not cdsAjustes.IsEmpty;

  If Not Result Then
    Result := Not cdsConcar.IsEmpty;
end;

function TConcilaRecebiveisMagazineLuiza.ExisteParcelaA: Boolean;
  Var
    LRecNo: Integer;
begin
  If FDatasetMovcarParceladas.IsEmpty Then
    Exit(False);

  LRecNo := FDatasetMovcarParceladas.RecNo;

  Result := FDatasetMovcarParceladas.Locate('MCA_PARCEL', 'A', []);

  FDatasetMovcarParceladas.Recno := LRecNo;
end;

function TConcilaRecebiveisMagazineLuiza.fBuscaCartaoBaixadoMLZ: Boolean;
 Var
     LParcelaStr: String;
     LintParcela: Integer;
begin
  LParcelaStr := TMagazineLuizaFuncoes.fGetLetraAlfa(cdsConCar.FieldByName('MLZ_NUMPAR').AsInteger);

  If cdsConCar.FieldByName('MLZ_TOTPAR').AsInteger > 26 Then
  Begin
    If TryStrToInt(cdsConCar.FieldByName('MLZ_NUMPAR').AsString, LintParcela) Then
      LParcelaStr := TMagazineLuizaFuncoes.fStrZero( cdsConCar.FieldByName('MLZ_NUMPAR').AsString, 3);
  End;

  Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL',
                             VarArrayOf([UpperCase(cdsConCar.FieldByName('MLZ_ID_SEL').AsString),
                                         LParcelaStr]),[]);

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL',
                               VarArrayOf([UpperCase(cdsConCar.FieldByName('MLZ_ID_MLZ').AsString),
                                           LParcelaStr]),[]);                                          

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_PARCEL;MCA_NUMCCD',
                               VarArrayOf([LParcelaStr,
                                           UpperCase(cdsConCar.FieldByName('MLZ_ID_MLZ').AsString)]),[loPartialKey]);

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_PARCEL;MCA_NUMNSU',
                               VarArrayOf([LParcelaStr,
                                           UpperCase(cdsConCar.FieldByName('MLZ_ID_MLZ').AsString)]),[loPartialKey]);

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_PARCEL;MCA_NUMNSU',
                               VarArrayOf([LParcelaStr,
                                           UpperCase(cdsConCar.FieldByName('MLZ_ID_SEL').AsString)]),[loPartialKey]);

  blnAutomatica := (Result) And
                   (Not TMagazineLuizaFuncoes.fEmptyStr(cdsBaixad.FieldByName('MCA_CHACON').AsString));
end;

procedure TConcilaRecebiveisMagazineLuiza.pFiltraCartoesMLZ;
  Var
    LSQL: String;

    LConsulta: TUniQuery;
begin
  LSQL := TLibCartoesMovCar.fGetSQLCartoes(objConcil);

  FListaDePedidos := RetornaListaDePedidos;

  LSQL := LSQL + ' AND MCA_CODCAR IN (' + TMagazineLuizaFuncoes.fRetStrToSQLIn(FCartoesParaConciliacao) + ') ';
  LSQL := LSQL + ' AND (MCA_NUMCCD IN (' + FListaDePedidos + ') OR ';
  LSQL := LSQL + '      MCA_NUMNSU IN (' + FListaDePedidos + ')) ';

  LSQL := LSQL + ' ORDER BY MCA_NUMCCD, MCA_NUMNSU, MCA_PARCEL, MCA_CODEMP) AS TMP ';

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := LSQL;
    LConsulta.Open;

    cdsBaiCar := TMagazineLuizaFuncoes.CriarClientDataSet(LConsulta);
    cdsBaiCar.Open;

    cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;MCA_NUMNSU;MCA_CODEMP;PARDUP;MCA_DTACUP;MCA_NUMDUP';
  Finally
    TMagazineLuizaFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

procedure TConcilaRecebiveisMagazineLuiza.RegistraNovaParcelaMovcarBaixada(
  var AREgistroRelatorio: TItensRelatorioCartoes; AValorTaxa: Double);
  Var
    LConsulta: TUniQuery;

    LCampoAtual: TField;
begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    FDatasetMovcarParceladas.Filter := '(MCA_NUMCCD=''' + cdsConcar.FieldByName('MLZ_ID_SEL').AsString + ''' OR ' +
                                       'MCA_NUMCCD=''' + cdsConcar.FieldByName('MLZ_ID_SEL').AsString + '-1'' OR ' +
                                       'MCA_NUMCCD=''' + cdsConcar.FieldByName('MLZ_ID_MLZ').AsString + ''' OR ' +
                                       'MCA_NUMNSU=''' + cdsConcar.FieldByName('MLZ_ID_SEL').AsString + ''' OR ' +
                                       'MCA_NUMNSU=''' + cdsConcar.FieldByName('MLZ_ID_SEL').AsString + '-1'' OR ' +
                                       'MCA_NUMNSU=''' + cdsConcar.FieldByName('MLZ_ID_MLZ').AsString + ''') AND ' +
                                       'MCA_PARCEL=''A'' ';
    FDatasetMovcarParceladas.Filtered := True;

    If FDatasetMovcarParceladas.IsEmpty Then
      Exit;

    LConsulta.SQL.Text := TLibCartoesMovCar.fGetSQLCartoes(objConcil)
                            .Replace('MCA_DTAREC IS NULL', 'MOVCAR.AUTOINCREM="' + FDatasetMovcarParceladas.FieldByName('AUTOINCREM').AsString + '"') +
                            ') AS TMP';
    LConsulta.Open;

    If LConsulta.IsEmpty Then
      Exit;

    FDatasetMovcarParceladas.Filter := '(MCA_NUMCCD=''' + cdsConcar.FieldByName('MLZ_ID_SEL').AsString + ''' OR ' +
                                       'MCA_NUMCCD=''' + cdsConcar.FieldByName('MLZ_ID_SEL').AsString + '-1'' OR ' +
                                       'MCA_NUMCCD=''' + cdsConcar.FieldByName('MLZ_ID_MLZ').AsString + ''' OR ' +
                                       'MCA_NUMNSU=''' + cdsConcar.FieldByName('MLZ_ID_SEL').AsString + ''' OR ' +
                                       'MCA_NUMNSU=''' + cdsConcar.FieldByName('MLZ_ID_SEL').AsString + '-1'' OR ' +
                                       'MCA_NUMNSU=''' + cdsConcar.FieldByName('MLZ_ID_MLZ').AsString + ''') AND ' +
                                       'MCA_PARCEL=''' + TMagazineLuizaFuncoes.fGetLetraAlfa(cdsConcar.FieldByName('MLZ_NUMPAR').AsInteger) + ''' ';
    FDatasetMovcarParceladas.Filtered := True;

    If Not FDatasetMovcarParceladas.IsEmpty Then
      Exit;

    If cdsBaiCar.Locate('MCA_NUMCCD;MCA_NUMNSU;PARDUP;CADASTRAR_NOVA_PARCELA_MKT',
                        VarArrayOf([FDatasetMovcarParceladas.FieldByName('MCA_NUMCCD').AsString,
                                    FDatasetMovcarParceladas.FieldByName('MCA_NUMNSU').AsString,
                                    TMagazineLuizaFuncoes.fGetLetraAlfa(cdsConcar.FieldByName('MLZ_NUMPAR').AsInteger),
                                    'S']), []) Then
    Begin
      cdsBaiCar.Edit;

      cdsBaiCar.FieldByName('AUTOINC').AsString := EmptyStr;
      cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat +
                                                     cdsConCar.FieldByName('VALOR_BRUTO').AsFloat;

      ARegistroRelatorio.Descricao := EmptyStr;
      ARegistroRelatorio.TipoDoRegistro := 'PAGAMENTO';

      cdsBaiCar.FieldByName('MCA_VALREC').AsFloat := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat +
                                                     cdsConCar.FieldByName('MLZ_VALLIQ').AsFloat;

      cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat    := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;

      cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat +
                                                     Abs(AValorTaxa);

      cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat    := (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat /
                                                         cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100;

      cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := TMagazineLuizaFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat, 2);
      cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat  := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
      cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat  := 1;
      cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat  := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;

      cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat := cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat +
                                                            Abs(cdsConCar.FieldByName('REGISTROFRETE').AsFloat);

      cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat := cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat +
                                                             Abs(cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat);

      cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat := cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat +
                                                            Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);

      cdsBaiCar.FieldByName('MCA_CHACON').AsString := INICAM + cdsConCar.FieldByName('MLZ_ID_SEL').AsString + '_' +
                                                      cdsBaiCar.FieldByName('PARDUP').AsString + '_' +
                                                      cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                                                      FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('MLZ_DTAPED').AsDateTime);

      cdsBaiCar.Post;

      FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(cdsConcar));

      FTextoInconsistencia := EmptyStr;
      ARegistroRelatorio.InconsistenciaConciliada := 'N';
      ARegistroRelatorio.Conciliado := 0;
      ARegistroRelatorio.Parcela := cdsConcar.FieldByName('MLZ_NUMPAR').AsString;
      ARegistroRelatorio.TotalParcelas := cdsConcar.FieldByName('MLZ_TOTPAR').AsString;

      Exit;
    End;

    cdsBaiCar.Last;
    cdsBaiCar.Append;

    For LCampoAtual In LConsulta.Fields Do
      cdsBaiCar.Fields[LCampoAtual.Index].Value := LCampoAtual.Value;
    
    cdsBaiCar.FieldByName('AUTOINC').AsString := EmptyStr;
    cdsBaiCar.FieldByName('PARDUP').AsString := TMagazineLuizaFuncoes.fGetLetraAlfa(cdsConcar.FieldByName('MLZ_NUMPAR').AsInteger);
    cdsBaiCar.FieldByName('CADASTRAR_NOVA_PARCELA_MKT').AsString := 'S';
    cdsBaiCar.FieldByName('AUTOINCREM_BAIXADA_MKT').AsString := ARegistroRelatorio.AutoIncremMovCar;

    cdsBaiCar.FieldByName('MCA_MARDES').AsString := 'M';
    cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat := cdsConCar.FieldByName('VALOR_BRUTO').AsFloat;

    ARegistroRelatorio.Descricao := EmptyStr;
    ARegistroRelatorio.TipoDoRegistro := 'PAGAMENTO';

    cdsBaiCar.FieldByName('MCA_VALREC').AsFloat := cdsConCar.FieldByName('MLZ_VALLIQ').AsFloat;

    cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime := cdsConCar.FieldByName('MLZ_DTAPAG').AsDateTime;
    cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat    := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;

    cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat := Abs(AValorTaxa);

    cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat    := (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat /
                                                       cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100;

    cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := TMagazineLuizaFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat, 2);
    cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat  := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
    cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat  := 1;
    cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat  := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;

    cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString := fRetornaChaveConciliacao(cdsConcar);
    cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat := Abs(cdsConCar.FieldByName('REGISTROFRETE').AsFloat);

    cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat := Abs(cdsConCar.FieldByName('REGISTROAJUSTE').AsFloat);

    cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat := Abs(cdsConCar.FieldByName('CUPOMDESCONTO').AsFloat);

    cdsBaiCar.FieldByName('MCA_CHACON').AsString := INICAM + cdsConCar.FieldByName('MLZ_ID_SEL').AsString + '_' +
                                                    cdsBaiCar.FieldByName('PARDUP').AsString + '_' +
                                                    cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                                                    FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName('MLZ_DTAPED').AsDateTime);

    cdsBaiCar.Post;

    FTextoInconsistencia := EmptyStr;
    ARegistroRelatorio.InconsistenciaConciliada := 'N';
    ARegistroRelatorio.Conciliado := 0;
    ARegistroRelatorio.Parcela := cdsConcar.FieldByName('MLZ_NUMPAR').AsString;
    ARegistroRelatorio.TotalParcelas := cdsConcar.FieldByName('MLZ_TOTPAR').AsString;
  Finally
    TMagazineLuizaFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

function TConcilaRecebiveisMagazineLuiza.RegistroCancelado: Boolean;
begin
  Result := TMagazineLuizaFuncoes.fFormataFloat(cdsConCar.FieldByName('MLZ_VALLIQ').AsFloat, 2) <= 0;

  If Not Result Then
  Begin
    If Not FTextoInconsistencia.Equals('Vendas não encontradas nos lançamentos do sistema') Then
      Exit;

    If TMagazineLuizaFuncoes.fFormataFloat(cdsConCar.FieldByName('MLZ_VALBRU').AsFloat, 2) = 0 Then
    Begin
      Result := Not cdsConCar.FieldByName('MLZ_OBSERV').AsString.IsEmpty;
      If Result Then
        GravaAjusteParaPedidoComErroDeIntegracaoPagoSemMovcar;
    End;

    Exit;
  End;
end;

procedure TConcilaRecebiveisMagazineLuiza.RemoveRegistroListaRelatorio(ADataset: TDataset);
  Var
    LContador: Integer;
begin
  For LContador := 0 To FListaRegistrosRelatorio.Count - 1 Do
  Begin
    If Concat(FListaRegistrosRelatorio[LContador].NumeroNSU,
              FListaRegistrosRelatorio[LContador].CodigoAutorizacao,
              FormatDateTime('dd/mm/yyyy', FListaRegistrosRelatorio[LContador].DataPagamento),
              FListaRegistrosRelatorio[LContador].Parcela)
       .Equals(Concat(ADataset.FieldByName('MLZ_ID_MLZ').AsString,
                      ADataset.FieldByName('MLZ_ID_SEL').AsString,
                      FormatDateTime('dd/mm/yyyy', ADataset.FieldByName('MLZ_DTAPAG').AsDateTime),
                      ADataset.FieldByName('MLZ_NUMPAR').AsString)) Then
    Begin
      FListaRegistrosRelatorio.Delete(LContador);

      Break;
    End;
  End;
end;

function TConcilaRecebiveisMagazineLuiza.RetornaEmpresaFiltrada: String;
begin
  Result := EmpresasPeriodo[0].strCodigo;
end;

function TConcilaRecebiveisMagazineLuiza.RetornaIDRepassePeriodo: String;
  Var
    LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT DISTINCT MLZ_ID_REP ' +
                          'FROM MLZ_MZPGTO ' +
                          'WHERE MLZ_DTAPAG BETWEEN "' + FormatDateTime('yyyy-mm-dd', DataInicioPeriodo) + '" ' +
                          '                 AND "' + FormatDateTime('yyyy-mm-dd', DataFinalPeriodo) + '" ' +
                          '  AND MLZ_CODEMP IN ("' + FiltrosRelatorio.ListaEmpresas + '") ';

    LConsulta.Open;

    Result := EmptyStr;
    While Not LConsulta.Eof Do
    Begin
      Result := Result + '"' + LConsulta.FieldByName('MLZ_ID_REP').AsString + '",';

      LConsulta.Next;
    End;

    If Result.IsEmpty Then
      Result := '"",';

    Result := LeftStr(Result, Result.Length - 1);
  Finally
    TMagazineLuizaFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

function TConcilaRecebiveisMagazineLuiza.RetornaListaDePedidos: String;
  Var
    LSQL: String;

    LConsulta: TUniQuery;
begin
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LSQL := 'SELECT DISTINCT MLZ_ID_SEL, MLZ_ID_MLZ FROM MLZ_MZPGTO WHERE ' + FPeriodoFiltro;

    LConsulta.SQL.Text := LSQL;
    LConsulta.Open;

    Result := EmptyStr;

    While Not LConsulta.Eof Do
    Begin
      If Not LConsulta.FieldByName('MLZ_ID_SEL').AsString.IsEmpty Then
      Begin
        Result := Result + '"' + LConsulta.FieldByName('MLZ_ID_SEL').AsString + '",';
        Result := Result + '"' + LConsulta.FieldByName('MLZ_ID_SEL').AsString + '-1",';
      End;

      If Not LConsulta.FieldByName('MLZ_ID_MLZ').AsString.IsEmpty Then
        Result := Result + '"' + LConsulta.FieldByName('MLZ_ID_MLZ').AsString + '",';

      LConsulta.Next;
    End;

    If Not Result.IsEmpty Then
      Exit(LeftStr(Result, Result.Length - 1));

    Result := '" "';
  Finally
    TMagazineLuizaFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

function TConcilaRecebiveisMagazineLuiza.RetornaNomeArquivosConciliacao: String;
  Var
    LNomeArquivo: String;
begin
  Result := EmptyStr;

  If FListaArquivos.Count = 0 Then
    Exit;

  For LNomeArquivo In FListaArquivos Do
    Result := Result + LNomeArquivo + '_';
end;

function TConcilaRecebiveisMagazineLuiza.RetornaSQLRegistrosImportados: String;
begin
  If FPeriodoFiltro.IsEmpty Then
    FPeriodoFiltro := ' MLZ_CODEMP IN ("' + FiltrosRelatorio.ListaEmpresas + '") ' +
                      ' AND (MLZ_ID_REP IN (' + RetornaIDRepassePeriodo + ') OR ' +
                      '      MLZ_DTAPAG BETWEEN "' + FormatDateTime('yyyy-mm-dd', DataInicioPeriodo) + '" ' +
                      '                     AND "' + FormatDateTime('yyyy-mm-dd', DataFinalPeriodo) + '") ';

  Result := '';
  Result := Result + ' SELECT IF((MLZ_VALBRU <> 0 AND MLZ_VALLIQ > 0) OR MLZ_VALLIQ <= 0, MLZ_VALBRU, MLZ_VALLIQ+ABS(MLZ_VALCOM)+ABS(MLZ_FIXPAR)) AS VALOR_BRUTO, ';
  Result := Result + ' MLZ_MZPGTO.*, MLZ_CODEMP AS CODEMP,                       ';
  Result := Result + ' EMP_NOMEMP, CAST("0000-00-00" AS DATE) AS MLZ_DTARET,     ';
  Result := Result + ' 0.00 AS REGISTROFRETE,                                    ';
  Result := Result + ' 0.00 AS REGISTROAJUSTE,                                   ';
  Result := Result + ' 0.00 AS CUPOMDESCONTO,                                    ';
  Result := Result + ' "N" AS MARCADO                                            ';
  Result := Result + 'FROM MLZ_MZPGTO                                            ';
  Result := Result + '  LEFT JOIN CADEMP ON EMP_CODEMP=MLZ_CODEMP                ';
  Result := Result + ' WHERE                                                     ';

  Result := Result + FPeriodoFiltro +
                     ' AND MLZ_TIPREG NOT IN ("Estorno", "Evento", "Transferência", "account_balance") ' +
                     ' AND MLZ_VALLIQ > 0                                          ' +
                     ' ORDER BY MLZ_DTAPAG, MLZ_ID_SEL, MLZ_NUMPAR, MLZ_TIPREG    ';
end;

procedure TConcilaRecebiveisMagazineLuiza.ValidaSeDeveRealizarOParcelamentoNaBaixa(
  AAgrupado: Boolean = False; AFoiMarcadaParaBaixa: Boolean = True);
  Var
    LParcelasAdicionar: TParcelasCadastrar;

    LDadosParcelaAdicionar: TParcelasModalidades;

    LContador: Integer;
begin
  If cdsConcar.FieldByName('MLZ_TOTPAR').AsString.Equals('01') Then
    Exit;

  FDatasetMovcarParceladas.Filter := 'MCA_NUMCCD=''' + cdsConcar.FieldByName('MLZ_ID_SEL').AsString + ''' OR ' +
                                     'MCA_NUMCCD=''' + cdsConcar.FieldByName('MLZ_ID_SEL').AsString + '-1'' OR ' +
                                     'MCA_NUMCCD=''' + cdsConcar.FieldByName('MLZ_ID_MLZ').AsString + ''' OR ' +
                                     'MCA_NUMNSU=''' + cdsConcar.FieldByName('MLZ_ID_SEL').AsString + ''' OR ' +
                                     'MCA_NUMNSU=''' + cdsConcar.FieldByName('MLZ_ID_SEL').AsString + '-1'' OR ' +
                                     'MCA_NUMNSU=''' + cdsConcar.FieldByName('MLZ_ID_MLZ').AsString + '''';
  FDatasetMovcarParceladas.Filtered := True;

  If FDatasetMovcarParceladas.IsEmpty Then
    Exit;

  If FDatasetMovcarParceladas.RecordCount >= cdsConcar.FieldByName('MLZ_TOTPAR').AsInteger Then
    Exit;

  If Not cdsConcar.FieldByName('MLZ_OBSERV').AsString.IsEmpty Then
  Begin
    If TMagazineLuizaFuncoes.fFormataFloat(cdsConcar.FieldByName('MLZ_VALBRU').AsFloat, 2) = 0 Then
      Exit;
  End;

  If Not ExisteParcelaA Then
    Exit;

  If JaPossuiMaisDeUmaParcelaComAChaveUniqueMOVCAR Then
    Exit;

  LParcelasAdicionar := TParcelasCadastrar.Create;
  LParcelasAdicionar.ChavePrimariaImportacao := fRetornaChaveConciliacao(cdsConCar);
  LParcelasAdicionar.IDSeller := cdsConcar.FieldByName('MLZ_ID_SEL').AsString;
  LParcelasAdicionar.IDPedido := cdsConcar.FieldByName('MLZ_ID_MLZ').AsString;

  If AFoiMarcadaParaBaixa Then
    LParcelasAdicionar.ParcelasConciliadas := cdsConcar.FieldByName('MLZ_NUMPAR').AsString;

  LParcelasAdicionar.AutoIncremMovCar := FDatasetMovcarParceladas.FieldByName('AUTOINCREM').AsString;
  LParcelasAdicionar.TotalParcelas := cdsConcar.FieldByName('MLZ_TOTPAR').AsString;

  LDadosParcelaAdicionar := TParcelasModalidades.Create;
  LDadosParcelaAdicionar.QuatidadeParcelas := cdsConcar.FieldByName('MLZ_TOTPAR').AsInteger;
  LDadosParcelaAdicionar.ValorBruto := TMagazineLuizaFuncoes.fFormataFloat(cdsConcar.FieldByName('MLZ_VALPED').AsFloat / cdsConcar.FieldByName('MLZ_TOTPAR').AsInteger, 2);
  If LDadosParcelaAdicionar.ValorBruto = 0 Then
    LDadosParcelaAdicionar.ValorBruto := cdsConcar.FieldByName('MLZ_VALBRU').AsFloat;

  LDadosParcelaAdicionar.ValorTaxas := Abs(cdsConcar.FieldByName('MLZ_VALCOM').AsFloat) +
                                       Abs(cdsConcar.FieldByName('MLZ_FIXPAR').AsFloat);
  LDadosParcelaAdicionar.ValorFrete := Abs(cdsConcar.FieldByName('REGISTROFRETE').AsFloat);
  LDadosParcelaAdicionar.ValorCupom := Abs(cdsConcar.FieldByName('CUPOMDESCONTO').AsFloat);
  LDadosParcelaAdicionar.ValorLiquido := LDadosParcelaAdicionar.ValorBruto -
                                         LDadosParcelaAdicionar.ValorTaxas -
                                         LDadosParcelaAdicionar.ValorFrete +
                                         LDadosParcelaAdicionar.ValorCupom;

  If AAgrupado Then
  Begin
    For LContador := 0 To FListaParcelasCadastrar.Count - 1 Do
    Begin
      If Not LParcelasAdicionar.AutoIncremMovCar.Equals(cdsBaicar.FieldByName('AUTOINC').AsString) Then
        Continue;

      If StrToInt(FListaParcelasCadastrar[LContador].TotalParcelas) < StrToInt(LParcelasAdicionar.TotalParcelas) Then
      Begin
        LParcelasAdicionar.ParcelasConciliadas := FListaParcelasCadastrar[LContador].ParcelasConciliadas + '_' +
                                                  LParcelasAdicionar.ParcelasConciliadas;

        FListaParcelasCadastrar[LContador].TotalParcelas := LParcelasAdicionar.TotalParcelas;
      End;

      FListaParcelasCadastrar[LContador].ParcelasModalidades.Add(LDadosParcelaAdicionar);

      Exit;
    End;
  End;

  LParcelasAdicionar.ParcelasModalidades.Add(LDadosParcelaAdicionar);
  FListaParcelasCadastrar.Add(LParcelasAdicionar);
end;

procedure TConcilaRecebiveisMagazineLuiza.ValidaSeVaiParcelarNaBaixaEDeveSerConciliado(
  var ASeraConciliado: Boolean);
  Var
    LContador: Integer;
begin
  ASeraConciliado := False;

  If cdsConcar.FieldByName('MLZ_TOTPAR').AsString.Equals('01') Then
    Exit;

  If cdsConcar.FieldByName('MLZ_NUMPAR').AsString.Equals('01') Then
    Exit;

  For LContador := 0 To FListaParcelasCadastrar.Count - 1 Do
  Begin
    If Not FListaParcelasCadastrar[LContador].IDSeller.Equals(cdsConcar.FieldByName('MLZ_ID_SEL').AsString) Then
      Continue;

    If Not FListaParcelasCadastrar[LContador].ParcelasConciliadas.Contains(cdsConcar.FieldByName('MLZ_NUMPAR').AsString) Then
    Begin
      FListaParcelasCadastrar[LContador].ParcelasConciliadas := FListaParcelasCadastrar[LContador].ParcelasConciliadas + '_' +
                                                                cdsConcar.FieldByName('MLZ_NUMPAR').AsString;

      ASeraConciliado := True;
    End;

    Break;
  End;
end;

procedure TConcilaRecebiveisMagazineLuiza.pFiltraCancelamentosMLZ(var prgStatus: TcxProgressBar);
  Var
    LSQL,
    LEmpresaConfiguracao: String;

    LConsultaAjustes: TUniQuery;

    LAjusteCredito,
    LSairWhile: Boolean;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  TMagazineLuizaFuncoes.FreeAndNilDatasets(cdsAjustes);

  LConsultaAjustes := Nil;
  Try
    LConsultaAjustes := VS_FuncoesExternas.fICriaQuery;
    LSQL := 'SELECT *, ';
    LSQL := LSQL + '       MLZ_TIPREG AS TIPAJU, ';
    LSQL := LSQL + '       IF(MLZ_VALLIQ > 0, MLZ_VALLIQ, 0) AS AJUCRE, ';
    LSQL := LSQL + '       "N" AS MARCADO, ';
    LSQL := LSQL + '       MLZ_CODEMP AS EMPRESA ';
    LSQL := LSQL + ' FROM ' + objConcil.TabelaConciliacao + ' A ';
    LSQL := LSQL + ' WHERE ' + FCondicaoAjustes;
    
    LSQL := LSQL + ' ORDER BY MLZ_ID_MLZ, MLZ_NUMPAR, MLZ_TIPREG';

    LConsultaAjustes.SQL.Text := LSQL;
    LConsultaAjustes.Open;

    cdsAjustes := TMagazineLuizaFuncoes.CriarClientDataSet(LConsultaAjustes);
    cdsAjustes.Open;

    TMagazineLuizaFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Filtrando e agrupando ajustes.', False);
    prgStatus.Position := 0;
    prgStatus.Properties.Max := cdsAjustes.RecordCount;

    cdsAjustes.First;
    While Not cdsAjustes.Eof Do
    Begin
      TMagazineLuizaFuncoes.pStepStatusGravacao(prgStatus);

      LSairWhile := cdsAjustes.RecNo = cdsAjustes.RecordCount;
      If AgruparERemoverRegistgrosDeFretesEAjustes Then
      Begin
        FListaRegistrosAjustesAgrupados.Add(fRetornaChaveConciliacao(cdsAjustes));

        cdsAjustes.Delete;

        If LSairWhile Then
          Break;

        Continue;
      End;

      If TMagazineLuizaFuncoes.fFormataFloat(cdsAjustes.FieldByName('MLZ_VALLIQ').AsFloat, 2) = 0.00 Then
      Begin
        cdsAjustes.Next;

        Continue;
      End;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;
      Try
        LAjusteCredito := TMagazineLuizaFuncoes.fFormataFloat(cdsAjustes.FieldByName('AJUCRE').Value, 2) <> 0;

        LEmpresaConfiguracao := cdsAjustes.FieldByName('EMPRESA').AsString;

        LRegistroRelatorio.ValorBruto := TMagazineLuizaFuncoes.fFormataFloat(cdsAjustes.FieldByName(objConcil.CampoValorLiquido).AsFloat, 2);
        LRegistroRelatorio.ValorLiquido := TMagazineLuizaFuncoes.fFormataFloat(cdsAjustes.FieldByName(objConcil.CampoValorLiquido).AsFloat, 2);
        If LAjusteCredito Then
        Begin
          LRegistroRelatorio.ValorBruto := Abs(LRegistroRelatorio.ValorBruto);
          LRegistroRelatorio.ValorLiquido := Abs(LRegistroRelatorio.ValorLiquido);
        End;

        LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
        LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
        LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';

        LRegistroRelatorio.DescricaoAjuste := cdsAjustes.FieldByName('MLZ_OBSERV').AsString;
        If LRegistroRelatorio.DescricaoAjuste.IsEmpty Then
          LRegistroRelatorio.DescricaoAjuste := cdsAjustes.FieldByName('TIPAJU').AsString;

        LRegistroRelatorio.CodigoEmpresa := LEmpresaConfiguracao;
        LRegistroRelatorio.CodigoEstabelecimento := LEmpresaConfiguracao;
        LRegistroRelatorio.NumeroNSU := cdsAjustes.FieldByName(objConcil.CampoNumeroNSU).AsString;
        LRegistroRelatorio.NumeroCartao := cdsAjustes.FieldByName(objConcil.CampoCodigoAutorizacao).AsString;
        LRegistroRelatorio.Parcela := LeftStr(cdsAjustes.FieldByName(objConcil.CampoNumeroParcela).AsString, 2);
        LRegistroRelatorio.TotalParcelas := RightStr(cdsAjustes.FieldByName(objConcil.CampoNumeroParcela).AsString, 2);
        LRegistroRelatorio.CodigoAutorizacao := TMagazineLuizaFuncoes.fStrZero(cdsAjustes.FieldByName(objConcil.CampoCodigoAutorizacao).AsString, 6);

        LRegistroRelatorio.DataVenda := cdsAjustes.FieldByName(objConcil.CampoDataTransacaoVenda).Value;
        LRegistroRelatorio.DataPagamento := cdsAjustes.FieldByName(objConcil.CampoDataRecebimento).Value;

        LRegistroRelatorio.Conciliado := cdsAjustes.FieldByName('MLZ_CONCIL').AsInteger;
        LRegistroRelatorio.NomeArquivo := cdsAjustes.FieldByName('MLZ_NOMARQ').AsString;

        LRegistroRelatorio.RegistroIncompleto := 'N';
        LRegistroRelatorio.RegistroIncompleto := ConfiguracoesAjustesEstaoIncompletas(LEmpresaConfiguracao);

        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);
      Except
        FreeAndNil(LRegistroRelatorio);
        Raise;
      End;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      cdsAjustes.Next;
    End;
  Finally
    TMagazineLuizaFuncoes.FreeAndNilDatasets(LConsultaAjustes);
  End;
end;

procedure TConcilaRecebiveisMagazineLuiza.pFiltraCartoesBaixadosMLZ;
  Var
    strSQL   : String;
    qryBaixad: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT IF(IFNULL(MCA_NUMCCD, "") = "", MCA_NUMNSU, MCA_NUMCCD) AS MCA_NUMCCD, ';
  strSQL := strSQL + '        MCA_PARCEL, MCA_DTAREC, MCA_NUMNSU, MCA_VALREC, ';
  strSQL := strSQL + '        AUTOINCREM, MCA_NUMDUP, MCA_DTACUP, MCA_DTAREC, ';
  strSQL := strSQL + '        IFNULL(MCA_ORDEID, MCA_NUMPOK) AS MCA_ORDEID, ';
  strSQL := strSQL + '        MCA_CODEMP, MCA_DTAVEN, MCA_EMPRCX, MCA_CHACON ';
  strSQL := strSQL + ' FROM MOVCAR ';
  strSQL := strSQL + ' WHERE MCA_CODCAR IN (' + TMagazineLuizaFuncoes.fRetStrToSQLIn(FCartoesParaConciliacao) + ') ';

  strSQL := strSQL + '   AND (MCA_NUMCCD IN (' + FListaDePedidos + ') OR ' +
                     '        MCA_NUMNSU IN (' + FListaDePedidos + '))  ';

  strSQL := strSQL + '   AND MCA_DTAREC IS NOT NULL ';
  strSQL := strSQL + 'ORDER BY MCA_NUMCCD, MCA_PARCEL,MCA_CODEMP ';

  qryBaixad := Nil;
  Try
    qryBaixad := VS_FuncoesExternas.fICriaQuery;
    qryBaixad.SQL.Text := strSQL;
    qryBaixad.Open;
    cdsBaixad := TMagazineLuizaFuncoes.CriarClientDataSet(qryBaixad);
    cdsBaixad.Open;

    cdsBaixad.IndexFieldNames := 'MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_CODEMP';
    cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;PARDUP;EMPLOC;MCA_DTACUP';
  Finally
    TMagazineLuizaFuncoes.FreeAndNilDatasets(qryBaixad);
  End;
end;

procedure TConcilaRecebiveisMagazineLuiza.pAdicionaRegistrosDeTransferenciasMagazineLuiza;
Var
    LConsulta: TUniQuery;

    LRegistroRelatorio: TItensRelatorioCartoes;

    LValidaConfiguracoes: String;

    LConfiguracoesValidas: Boolean;

    LAjusteTransferencia: TAjusteTransferencia;
begin
  If objConcil.CfgPortadorTransferencia.IsEmpty Then
    Exit;

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := Concat('SELECT CONCILIACAO.*, ',
                                 ' CONCILIACAO.MLZ_CODEMP AS EMPRESA, ',
                                 ' POR.SIS_VALCFG AS PORTADOR, ',
                                 ' CTA.SIS_VALCFG AS PLANODECONTAS, ',
                                 ' EVE.SIS_VALCFG AS CENTRODECUSTOS, ',
                                 ' CTD.SIS_VALCFG AS PLANODECONTAS_LANCDEB ',
                                 'FROM ',
                                 objConcil.TabelaConciliacao + ' AS CONCILIACAO ',
                                 'LEFT JOIN CFGSIS AS POR ON POR.SIS_CODEMP=CONCILIACAO.MLZ_CODEMP AND ',
                                 '                           POR.SIS_CODCFG="CFG_' + objConcil.CfgPortadorTransferencia + '" ',
                                 'LEFT JOIN CFGSIS AS CTA ON CTA.SIS_CODEMP=CONCILIACAO.MLZ_CODEMP AND ',
                                 '                           CTA.SIS_CODCFG="CFG_' + objConcil.CfgPlanoDeContasTransferencia + '" ',
                                 'LEFT JOIN CFGSIS AS EVE ON EVE.SIS_CODEMP=CONCILIACAO.MLZ_CODEMP AND ',
                                 '                           EVE.SIS_CODCFG="CFG_' + objConcil.CfgCentroDeCustosTransferencia + '" ',
                                 'LEFT JOIN CFGSIS AS CTD ON CTD.SIS_CODEMP=CONCILIACAO.MLZ_CODEMP AND ',
                                 '                           CTD.SIS_CODCFG="CFG_' + objConcil.CfgPlanoDeContasTransferenciaLancDeb + '" ',
                                 'WHERE ',
                                 FPeriodoFiltro,
                                 '  AND MLZ_TIPREG = "Transferência" ',
                                 '  AND MLZ_VALLIQ < 0 ');
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

      LRegistroRelatorio.ValorBruto := TMagazineLuizaFuncoes.fFormataFloat(LConsulta.FieldByName('MLZ_VALBRU').AsFloat -
                                                                           LConsulta.FieldByName('MLZ_TAXTRF').AsFloat, 2);
      LRegistroRelatorio.ValorLiquido := TMagazineLuizaFuncoes.fFormataFloat(LConsulta.FieldByName('MLZ_VALLIQ').AsFloat -
                                                                             LConsulta.FieldByName('MLZ_TAXTRF').AsFloat, 2);

      LRegistroRelatorio.Descricao := 'TRANSFERÊNCIAS';
      LRegistroRelatorio.TipoDoRegistro := 'TRANSFERÊNCIA';
      LRegistroRelatorio.TipoCartao := 'TRANSFERÊNCIAS';
      LRegistroRelatorio.DescricaoAjuste := 'TRANSFERÊNCIA';

      LRegistroRelatorio.CodigoEmpresa := LConsulta.FieldByName('EMPRESA').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := LConsulta.FieldByName('EMPRESA').AsString;
      LRegistroRelatorio.NumeroNSU := LConsulta.FieldByName(objConcil.CampoNumeroNSU).AsString;
      LRegistroRelatorio.NumeroCartao := '0';
      LRegistroRelatorio.Parcela := LeftStr(LConsulta.FieldByName(objConcil.CampoNumeroParcela).AsString, 2);
      LRegistroRelatorio.TotalParcelas := RightStr(LConsulta.FieldByName(objConcil.CampoNumeroParcela).AsString, 2);
      LRegistroRelatorio.CodigoAutorizacao := LConsulta.FieldByName(objConcil.CampoNumeroNSU).AsString;

      LRegistroRelatorio.DataVenda := LConsulta.FieldByName(objConcil.CampoDataRecebimento).AsDateTime;
      LRegistroRelatorio.DataPagamento := LConsulta.FieldByName(objConcil.CampoDataRecebimento).AsDateTime;

      LRegistroRelatorio.RegistroTransferencia := 'S';
      LRegistroRelatorio.PortadorTransferencia := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPortadorTransferencia, LConsulta.FieldByName('EMPRESA').AsString);
      LRegistroRelatorio.PlanoContasTransferenciaCredito := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPlanoDeContasTransferencia, LConsulta.FieldByName('EMPRESA').AsString);
      LRegistroRelatorio.CentroCustosTransferencia := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgCentroDeCustosTransferencia, LConsulta.FieldByName('EMPRESA').AsString);
      LRegistroRelatorio.PlanoContasTransferenciaDebito := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPlanoDeContasTransferenciaLancDeb, LConsulta.FieldByName('EMPRESA').AsString);

      LRegistroRelatorio.PortadorCredito := LRegistroRelatorio.PortadorTransferencia;
      LRegistroRelatorio.PortadorDebito := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPortadorAjustes, LConsulta.FieldByName('EMPRESA').AsString);

      If LRegistroRelatorio.PlanoContasTransferenciaDebito.IsEmpty Then
        LRegistroRelatorio.PlanoContasTransferenciaDebito := LConsulta.FieldByName('PLANODECONTAS').AsString;

      LRegistroRelatorio.Conciliado := LConsulta.FieldByName('MLZ_CONCIL').AsInteger;
      LRegistroRelatorio.NomeArquivo := LConsulta.FieldByName('MLZ_NOMARQ').AsString;

      LRegistroRelatorio.RegistroIncompleto := 'N';
      If Not LRegistroRelatorio.PortadorTransferencia.IsEmpty Then
      Begin
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, False, LConsulta);
        FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(LConsulta));
      End;

      If Not FormatFloat(',0.00', LConsulta.FieldByName('MLZ_TAXTRF').AsFloat).Equals('0,00') Then
      Begin
        LAjusteTransferencia := TAjusteTransferencia.Create;
        LAjusteTransferencia.dtaDataTranferencia := LConsulta.FieldByName('MLZ_DTAPAG').AsDateTime;
        LAjusteTransferencia.fltValorAjuste := LConsulta.FieldByName('MLZ_TAXTRF').AsFloat;
        LAjusteTransferencia.intConciliado := LConsulta.FieldByName('MLZ_CONCIL').AsInteger;

        lstAjusteTransferencia.Add(LAjusteTransferencia);
      End;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      LConsulta.Next;
    End;
  Finally
    TMagazineLuizaFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

end.
