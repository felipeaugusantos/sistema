unit untConciliaRecebiveisShopeePay;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, Vcl.Graphics, System.DateUtils, System.Math,

     Uni, UniClientDataSet, cxProgressBar,

     untTShopeeFuncoes, untTLibCartoesMovCar, untLibCartoesInterfacesTipos,
     untShopeeConciliaRecebiveis;

type

  TConciliaRecebiveisShopeePay = class(TConciliaRecebiveisMkt)
  private
    FCdsRegistrosPagamento : TUniClientDataSet; //Registros Conciliação Financeira
    FCdsRegistrosPedidos   : TUniClientDataSet; //Registros Lista de Pedidos (Order All)
    FCdsRegistrosAjuste    : TUniClientDataSet; //Registros Ajustes
    FCdsRegistrosTransferencias: TUniClientDataSet; //Registros Transferências

    FListaDePedidos: String;
    FCartaoShopee: String;

    FUtilizaImportacaoPorEmpresa,
    FImportacaoPelaAPI,
    FCampoReembolsoAjustadoDisputa: Boolean;

    FAutoIncremRelatorio: Integer;

    procedure pCriaDataSets;
    function FiltraAjustesShopeePay(pgbStatus: TcxProgressBar): Boolean;
    function AgruparAjustesPedidosNoMesmoDia(pgbStatus: TcxProgressBar): Boolean;
    procedure AgruparAjustesDeReembolsoECancelamentoPedidos;
    function RegistroDeAjusteDeveSerAgrupado(ADatasetAjuste: TDataset): Boolean;

    function RetornaSQLCampoValorNovo(ACampoExiste: Boolean;
                                      ANomeCampo: String): String;

    function RetornaListaDePedidos: String;

    procedure pFiltraCartoesShopeePay;
    function fBuscaCartaoShopeePay: Boolean;

    procedure pFiltraCartoesBaixadosShopeePay;
    function fBuscaCartaoBaixadoShopeePay: Boolean;

    function fEmpresaSQL:String;
    procedure pAdicionaRegistrosDeTransferenciasShopee;
    procedure VerificaSePedidoFoiCancelado(Var AValorBruto,
                                           AValorLiquido,
                                           AValorTaxa,
                                           AValorFrete,
                                           AValorAjuste,
                                           ACupomDesconto: Double);

    procedure VerificaSePedidoFoiAjustadoEInformacoesSaoInconsistentes(Var AValorAjuste: Double);

    procedure GeraRegistroSemPedidoImportado;

    function RetornaValorTaxaAjustadaPedido(AValorLiquidoCalculado,
                                            AValorLiquido,
                                            AValorTaxa: Double): Double;

    procedure TratamentoValorBrutoZerado(var AValorBruto,
                                         ACupomDesconto: Double);

    procedure AvaliaEAjustaValoresQuandoDescontoPixVierComCancelamento(ADatasetPagamento: TDataset;
                                                                       var ADatasetPedido: TUniClientDataset);

    procedure AdicionaRegistrosDeAjusteQuandoEstiverNaTabelaPagamento(ADatasetPagamento: TDataset);

    function fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar): Boolean;
    function fConciliaShopeePay(prgStatus: TcxProgressBar): Boolean;
  public
    constructor Create; overload;

    function fConciliaCartoes(prgStatus: TcxProgressBar): Boolean; override;

    function RetornaEmpresaFiltrada: String;

    property AutoIncremRelatorio: Integer Read FAutoIncremRelatorio;
    property UtilizaImportacaoPorEmpresa: Boolean read FUtilizaImportacaoPorEmpresa;
  end;

implementation

{ TConciliacaoShopeePay }

function TConciliaRecebiveisShopeePay.fConciliaShopeePay(prgStatus: TcxProgressBar): Boolean;
Var strStatus    : String;
    blnVazio     : Boolean;
begin
  Try
    Try
      prgStatus.Visible := False;

      Result       := False;
      PossuiInconsistencia := False;

      FTipoTransferenciaCaixa := VS_FuncoesExternas.fICfgSis('RCXTCC');
      FUtilizaImportacaoPorEmpresa := VS_FuncoesExternas.fICfgSis('SHOEMP',varBoolean);
      FImportacaoPelaAPI := VS_FuncoesExternas.fICfgSis('SHOHUB',varBoolean);

      Application.ProcessMessages;

      strStatus   := '';

      objConcil.TabelaConciliacao := 'SHO_SHPGTO';
      objConcil.CampoEstabelecimento := 'SHO_CODEST';
      objConcil.NomeConciliacao := 'SHOPEE';
      objConcil.CampoValorBruto := 'SHO_VALPAG';
      objConcil.CampoValorLiquido := 'SHO_VALPAG';
      objConcil.CampoCodigoAutorizacao := 'SHO_CODAUT';
      objConcil.CampoDataTransacaoVenda := 'SHO_DTADEC';
      objConcil.CfgPortadorAjustes := 'SHOPOR';
      objConcil.CfgPlanoDeContasAjustes := 'SHOCTA';
      objConcil.CfgFornecedorAjustes := 'SHOFOR';
      objConcil.strEventoCancelamentoAjuste := 'SHOEVE';
      objConcil.CfgEstabelecimentos := 'Shopee';
      objConcil.CfgPortadorTransferencia := 'SHOTRF';
      objConcil.CfgPlanoDeContasTransferencia := 'SHOCTF';
      objConcil.CfgCentroDeCustosTransferencia := 'SHOETF';

      objConcil.strChavePrimaria := 'SHO_DTADEC,SHO_VALPAG,SHO_DESCRI,SHO_CODAUT';
      objConcil.strChavePrimariaAjuste := 'SHO_DTADEC,SHO_VALPAG,SHO_DESCRI,SHO_CODAUT';

      If Not CarregaFiltrosParaBaixaRecebiveis(DataInicioPeriodo,
                                               DataFinalPeriodo,
                                               EmpresasPeriodo) Then
        Exit(False);

      pCriaDataSets;
      blnVazio := (FCdsRegistrosPagamento.RecordCount +
                   FCdsRegistrosAjuste.RecordCount +
                   FCdsRegistrosTransferencias.RecordCount) = 0;

      If blnVazio Then
      Begin
        TShopeeFuncoes.fMensagem('ATENÇÃO', 'Nenhum registro foi importado para o período selecionado.', ['&OK']);
        blnReabre := True;
        Exit(False);
      End;

      FRelatorioConciliacao := TRelatorioConciliacao.Create(VS_FuncoesExternas.fIRetOperadorLogado,
                                                            'SHOPEE',
                                                            'CONCILIACAO',
                                                            RetornaFiltrosdigitados,
                                                            TShopeeFuncoes.RetornaDataHoraServidor,
                                                            TShopeeFuncoes.RetornaHoraServidor);

      TShopeeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Filtrando registros Shopee.', False);
      pFiltraCartoesShopeePay;

      //Selecionando cartões já baixados/cadastrados no período
      TShopeeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Filtrando cartões Shopee baixados.', False);
      pFiltraCartoesBaixadosShopeePay;

      prgStatus.Visible := True;

      cdsBaiCar.Filter   := 'MCA_MARDES <> ' + QuotedStr('M');
      cdsBaiCar.Filtered := True;

      If Not FCdsRegistrosPagamento.IsEmpty Then
      Begin
        TShopeeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Agrupando registros (' + objConcil.NomeConciliacao + ').', False);
        AgruparAjustesPedidosNoMesmoDia(prgStatus);
        AgruparAjustesDeReembolsoECancelamentoPedidos;

        TShopeeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Processando registros (' + objConcil.NomeConciliacao + ').', False);
        fProcessaRegistrosDebitoCredito(prgStatus);
      End;

      TShopeeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Verificando Ajustes (' + objConcil.NomeConciliacao + ').', False);
      FiltraAjustesShopeePay(prgStatus);

      cdsBaiCar.Filter   := 'MCA_MARDES=' + QuotedStr('M');
      cdsBaiCar.Filtered := True;

      PossuiInconsistencia := False;

      If Not TryStrToInt(FRelatorioConciliacao.AutoIncremRelatorio, FAutoIncremRelatorio) Then
        FAutoIncremRelatorio := 0;

      TShopeeFuncoes.pStepStatusGravacao(prgStatus, 'Aguarde... Gravando registros dos relatórios (' + objConcil.NomeConciliacao + ').', False);
      GravarRegistrosRelatorio(prgStatus);
    Except
      On E: Exception Do
      Begin
        Result := False;
        VS_FuncoesExternas.pIMensagensErro(E.Message, '[TConciliacaoShopeePay.fConciliaShopeePay]');
      End;
    End;
  Finally
    TShopeeFuncoes.FreeAndNilDatasets(FCdsRegistrosPagamento);
    TShopeeFuncoes.FreeAndNilDatasets(FCdsRegistrosAjuste);
    TShopeeFuncoes.FreeAndNilDatasets(FCdsRegistrosTransferencias);
    TShopeeFuncoes.FreeAndNilDatasets(FCdsRegistrosPedidos);
  End;
end;

function TConciliaRecebiveisShopeePay.fEmpresaSQL: String;
begin
  Result := Concat('"', VS_FuncoesExternas.fIRetEmpresaLogada, '"');

  If FUtilizaImportacaoPorEmpresa Then
  Begin
    Result := Concat(' IFNULL(SHO_CODEMP,',Result,') ');
  End;
end;

procedure TConciliaRecebiveisShopeePay.AdicionaRegistrosDeAjusteQuandoEstiverNaTabelaPagamento(
  ADatasetPagamento: TDataset);
  Var
    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  If Not ADatasetPagamento.FieldByName('TABELA').AsString.Equals('SHO_SHPGTO') Then
    Exit;

  If Not ADatasetPagamento.FieldByName('SHO_BENEFI').AsString.Equals('Ajuste') Then
    Exit;

  If ADatasetPagamento.FieldByName('SHO_VALPAG').AsFloat <= 0 Then
    Exit;

  LRegistroRelatorio := Nil;
  Try
    LRegistroRelatorio := TItensRelatorioCartoes.Create;

    LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
    LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
    LRegistroRelatorio.DescricaoAjuste := AnsiUpperCase(ADatasetPagamento.FieldByName('SHO_DESCRI').Value);
    LRegistroRelatorio.NomeArquivo := ADatasetPagamento.FieldByName('SHO_NOMARQ').AsString;
    LRegistroRelatorio.CodigoEstabelecimento := ADatasetPagamento.FieldByName('EMP_CODEMP').AsString;
    LRegistroRelatorio.CodigoEmpresa := ADatasetPagamento.FieldByName('EMP_CODEMP').AsString;
    LRegistroRelatorio.NumeroNSU := '00000000000000';
    LRegistroRelatorio.CodigoAutorizacao := '00000000000000';
    LRegistroRelatorio.ResumoVenda := '000000000';
    LRegistroRelatorio.NumeroCartao := '00000000000000000';

    LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';

    LRegistroRelatorio.Parcela := '01';
    LRegistroRelatorio.TotalParcelas := '01';
    LRegistroRelatorio.DataPagamento := ADatasetPagamento.FieldByName('SHO_DTADEC').Value;
    LRegistroRelatorio.DataVenda := ADatasetPagamento.FieldByName('SHO_DTADEC').Value;
    LRegistroRelatorio.DataVencimento := ADatasetPagamento.FieldByName('SHO_DTADEC').Value;

    LRegistroRelatorio.ValorBruto := ADatasetPagamento.FieldByName('SHO_VALPAG').Value;
    LRegistroRelatorio.ValorLiquido := ADatasetPagamento.FieldByName('SHO_VALPAG').Value;

    LRegistroRelatorio.ValorTaxas := 0;
    LRegistroRelatorio.ValorFrete := 0;
    LRegistroRelatorio.ValorAjustes := 0;
    LRegistroRelatorio.ValorCupom := 0;

    LRegistroRelatorio.DescricaoBandeira := 'DIVERSAS';

    LRegistroRelatorio.Conciliado := ADatasetPagamento.FieldByName('SHO_CONCIL').AsInteger;

    GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, ADatasetPagamento);

    FListaRegistrosConciliar.Add(fRetornaChaveConciliacao(ADatasetPagamento));
  Except
    If Assigned(LRegistroRelatorio) Then
      FreeAndNil(LRegistroRelatorio);
    Raise;
  End;
  FListaRegistrosRelatorio.Add(LRegistroRelatorio);
end;

procedure TConciliaRecebiveisShopeePay.AgruparAjustesDeReembolsoECancelamentoPedidos;
  Var
    LDatasetClone: TUniClientDataset;

    LPedidoAnterior: String;
begin
  If FCdsRegistrosPagamento.IsEmpty Then
    Exit;

  LDatasetClone := Nil;
  LPedidoAnterior := EmptyStr;

  Try
    FCdsRegistrosPagamento.Filter := 'SHO_BENEFI=''Ajuste'' AND SHO_CODAUT<>'''' ';
    FCdsRegistrosPagamento.Filtered := True;
    FCdsRegistrosPagamento.IndexFieldNames := 'SHO_CODAUT';

    LDatasetClone := TShopeeFuncoes.CriarClientDataSet(FCdsRegistrosPagamento);

    FCdsRegistrosPagamento.First;
    While Not FCdsRegistrosPagamento.Eof Do
    Begin
      If FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString.Equals(LPedidoAnterior) Then
      Begin
        FCdsRegistrosPagamento.Delete;
        Continue;
      End;

      LPedidoAnterior := FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString;

      LDatasetClone.Close;
      LDatasetClone.Filter := 'SHO_CODAUT=' + QuotedStr(LPedidoAnterior);
      LDatasetClone.Filtered := True;
      LDatasetClone.Open;

      If LDatasetClone.RecordCount <= 1 Then
      Begin
        FCdsRegistrosPagamento.Next;
        Continue;
      End;

      FCdsRegistrosPagamento.Edit;
      FCdsRegistrosPagamento.FieldByName('SHO_VALPAG').AsFloat := 0;

      LDatasetClone.First;
      While Not LDatasetClone.Eof Do
      Begin
        FCdsRegistrosPagamento.FieldByName('SHO_VALPAG').AsFloat := FCdsRegistrosPagamento.FieldByName('SHO_VALPAG').AsFloat +
                                                                    LDatasetClone.FieldByName('SHO_VALPAG').AsFloat;

        FListaRegistrosConciliar.Add(fRetornaChaveConciliacaoAjuste(LDatasetClone));

        If FCdsRegistrosAjuste.Locate('SHO_DTADEC;SHO_CODAUT;SHO_VALPAG',
                                       VarArrayOf([LDatasetClone.FieldByName('SHO_DTADEC').AsDateTime,
                                                   LDatasetClone.FieldByName('SHO_CODAUT').AsString,
                                                   LDatasetClone.FieldByName('SHO_VALPAG').Value]), []) Then
          FCdsRegistrosAjuste.Delete;

        LDatasetClone.Next;
      End;
      FCdsRegistrosPagamento.Post;

      FCdsRegistrosPagamento.Next;
    End;
  Finally
    FCdsRegistrosPagamento.IndexFieldNames := EmptyStr;
    FCdsRegistrosPagamento.Filter := EmptyStr;
    FCdsRegistrosPagamento.Filtered := False;

    TShopeeFuncoes.FreeAndNilDatasets(LDatasetClone);
  End;
end;

function TConciliaRecebiveisShopeePay.AgruparAjustesPedidosNoMesmoDia(
  pgbStatus: TcxProgressBar): Boolean;
begin
  Result := True;

  If FCdsRegistrosAjuste.IsEmpty Then
    Exit;

  pgbStatus.Position := 0;
  pgbStatus.Properties.Max := FCdsRegistrosAjuste.RecordCount;

  FCdsRegistrosPagamento.Filter := 'SHO_BENEFI<>''Ajuste'' ';
  FCdsRegistrosPagamento.Filtered := True;

  Try
    FCdsRegistrosAjuste.First;
    While Not FCdsRegistrosAjuste.Eof Do
    Begin
      If Not RegistroDeAjusteDeveSerAgrupado(FCdsRegistrosAjuste) Then
      Begin
        FCdsRegistrosAjuste.Next;
        TShopeeFuncoes.pStepStatusGravacao(pgbStatus);
        Continue;
      End;

      If FCdsRegistrosPagamento.Locate('SHO_DTADEC;SHO_CODAUT;SHO_BENEFI',
                                       VarArrayOf([FCdsRegistrosAjuste.FieldByName('SHO_DTADEC').AsDateTime,
                                                   FCdsRegistrosAjuste.FieldByName('SHO_CODAUT').AsString,
                                                   'Renda do pedido']), [loCaseInsensitive]) Then
      Begin
        FCdsRegistrosPagamento.Edit;
        FCdsRegistrosPagamento.FieldByName('SHO_VALPAG').AsFloat := FCdsRegistrosPagamento.FieldByName('SHO_VALPAG').AsFloat +
                                                                    FCdsRegistrosAjuste.FieldByName('SHO_VALPAG').AsFloat;
        FCdsRegistrosPagamento.FieldByName('SHO_CONCIL').AsString := FCdsRegistrosAjuste.FieldByName('SHO_CONCIL').AsString;
        FCdsRegistrosPagamento.Post;

        FCdsRegistrosPagamento.Filter := 'SHO_BENEFI=''Ajuste'' AND ' +
                                         'SHO_CODAUT=''' + FCdsRegistrosAjuste.FieldByName('SHO_CODAUT').AsString + ''' AND ' +
                                         'SHO_DTADEC=''' + FormatDateTime('dd/mm/yyyy', FCdsRegistrosAjuste.FieldByName('SHO_DTADEC').AsDateTime) + ''' AND ' +
                                         'SHO_DESCRI=''' + FCdsRegistrosAjuste.FieldByName('SHO_DESCRI').AsString + ''' ';

        If Not FCdsRegistrosPagamento.IsEmpty Then
          FCdsRegistrosPagamento.Delete;

        FCdsRegistrosPagamento.Filter := 'SHO_BENEFI<>''Ajuste'' ';

        FListaRegistrosConciliar.Add(fRetornaChaveConciliacaoAjuste(FCdsRegistrosAjuste));
        FCdsRegistrosAjuste.Delete;
        TShopeeFuncoes.pStepStatusGravacao(pgbStatus);
        Continue;
      End;

      FCdsRegistrosAjuste.Next;
      TShopeeFuncoes.pStepStatusGravacao(pgbStatus);
    End;
  Finally
    FCdsRegistrosPagamento.Filter := EmptyStr;
    FCdsRegistrosPagamento.Filtered := False;
  End;
end;

procedure TConciliaRecebiveisShopeePay.AvaliaEAjustaValoresQuandoDescontoPixVierComCancelamento(
  ADatasetPagamento: TDataset; var ADatasetPedido: TUniClientDataset);
  Var
    LValorLiquidoArquivo,
    LValorLiquidoCalculado,
    LValorDiferenca: Double;
begin
  If FCdsRegistrosPagamento.FieldByName('SHO_VALPAG').AsFloat < 0 Then
    Exit;

  Try
    LValorLiquidoArquivo := FCdsRegistrosPagamento.FieldByName('SHO_VALPAG').AsFloat;
    LValorLiquidoCalculado := ADatasetPedido.FieldByName('VALOR_BRUTO').AsFloat -
                              ADatasetPedido.FieldByName('VALOR_TAXA').AsFloat -
                              Abs(ADatasetPedido.FieldByName('VALOR_DEVOLUCAO').AsFloat) +
                              ADatasetPedido.FieldByName('CUPOM_DESCONTO').AsFloat;
    If Not FCdsRegistrosPedidos.FieldByName('SHO_OPCENV').AsString.Equals('Shopee Entrega Direta') Then
      LValorLiquidoCalculado := LValorLiquidoCalculado - ADatasetPedido.FieldByName('VALOR_FRETE').AsFloat;

    If FormatFloat(',0.00', LValorLiquidoArquivo).Equals(FormatFloat(',0.00', LValorLiquidoCalculado)) Then
      Exit;

    If Abs(ADatasetPedido.FieldByName('VALOR_DEVOLUCAO').AsFloat) = 0 Then
      Exit;

    LValorDiferenca := Abs(TShopeeFuncoes.fFormataFloat(LValorLiquidoArquivo - LValorLiquidoCalculado, 2));

    If Not FormatFloat(',0.00', LValorDiferenca).Equals(FormatFloat(',0.00', ADatasetPedido.FieldByName('SHO_DESPIX').AsFloat)) Then
      Exit;

    ADatasetPedido.Edit;
    ADatasetPedido.FieldByName('VALOR_DEVOLUCAO').AsFloat := Abs(ADatasetPedido.FieldByName('VALOR_DEVOLUCAO').AsFloat) +
                                                             Abs(ADatasetPedido.FieldByName('SHO_DESPIX').AsFloat);
    ADatasetPedido.FieldByName('LIQUIDO_CALCULADO').AsFloat := ADatasetPedido.FieldByName('LIQUIDO_CALCULADO').AsFloat -
                                                               Abs(ADatasetPedido.FieldByName('SHO_DESPIX').AsFloat);
    ADatasetPedido.Post;
  Except
    Raise;
  End;
end;

constructor TConciliaRecebiveisShopeePay.Create;
begin
  Inherited;

  FUtilizaImportacaoPorEmpresa := VS_FuncoesExternas.fICfgSis('SHOEMP',varBoolean);
  FCampoReembolsoAjustadoDisputa := TShopeeFuncoes.CampoExiste('SHO_PDPGTO', 'SHO_DRCREF');
end;

function TConciliaRecebiveisShopeePay.fConciliaCartoes(prgStatus: TcxProgressBar): Boolean;
begin
  Result := fConciliaShopeePay(prgStatus);
end;

function TConciliaRecebiveisShopeePay.fProcessaRegistrosDebitoCredito(pgbStatus: TcxProgressBar) : Boolean;
  Var
    strParcel                : String;
    strNumNsu                : String;
    strCodEmp                : String;
    strNumAut                : String;
    blnBusca                 : Boolean;
    LTipoOperacao            : String;

    LValorBruto,
    LValorTaxa,
    LValorFrete,
    LCupomDesconto,
    LValorLiquido,
    LValorAjuste: Double;

    LChaveConciliacao: String;

    LRegistroRelatorio: TItensRelatorioCartoes;

    LReprocessaTaxas: Boolean;
begin

  Try
    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := FCdsRegistrosPagamento.RecordCount;

    FCdsRegistrosPagamento.First;
    While Not FCdsRegistrosPagamento.Eof Do
    Begin
      TShopeeFuncoes.pStepStatusGravacao(pgbStatus);
      FTextoInconsistencia := '';

      LTipoOperacao := 'CRÉDITO ROTATIVO';

      strParcel := 'A';
      FTextoInconsistencia := '';
      strNumNsu := '00000000000000';
      strNumAut := FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString;
      strCodEmp := FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString;

      If Not FCdsRegistrosPedidos.Locate('SHO_ID_PED', FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString, []) Then
      Begin
        GeraRegistroSemPedidoImportado;

        FCdsRegistrosPagamento.Next;
        Continue;
      End;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      FTextoInconsistencia := '';

      AvaliaEAjustaValoresQuandoDescontoPixVierComCancelamento(FCdsRegistrosPagamento, FCdsRegistrosPedidos);

      LValorLiquido := FCdsRegistrosPagamento.FieldByName('SHO_VALPAG').AsFloat;

      LValorTaxa := FCdsRegistrosPedidos.FieldByName('VALOR_TAXA').AsFloat;

      LValorFrete := FCdsRegistrosPedidos.FieldByName('VALOR_FRETE').AsFloat;
      If FCdsRegistrosPedidos.FieldByName('SHO_OPCENV').AsString.Equals('Shopee Entrega Direta') Then
        LValorFrete := 0;

      LCupomDesconto := FCdsRegistrosPedidos.FieldByName('CUPOM_DESCONTO').AsFloat;

      LValorBruto := FCdsRegistrosPedidos.FieldByName('VALOR_BRUTO').AsFloat;

      LValorAjuste := Abs(FCdsRegistrosPedidos.FieldByName('VALOR_DEVOLUCAO').AsFloat);

      TratamentoValorBrutoZerado(LValorBruto, LCupomDesconto);

      If Not FormatFloat(',0.00', FCdsRegistrosPedidos.FieldByName('LIQUIDO_CALCULADO').AsFloat).Equals(FormatFloat(',0.00', LValorLiquido)) Then
      Begin
        LReprocessaTaxas := Not FImportacaoPelaAPI;
        If (Not LReprocessaTaxas) And FCampoReembolsoAjustadoDisputa Then
          LReprocessaTaxas := FCdsRegistrosPedidos.FieldByName('SHO_DRCREF').AsFloat > 0;

        If LReprocessaTaxas Then
          LValorTaxa := RetornaValorTaxaAjustadaPedido(FCdsRegistrosPedidos.FieldByName('LIQUIDO_CALCULADO').AsFloat,
                                                       LValorLiquido,
                                                       LValorTaxa)
        Else If LValorAjuste <> 0 Then
          VerificaSePedidoFoiAjustadoEInformacoesSaoInconsistentes(LValorAjuste);
      End;

      VerificaSePedidoFoiCancelado(LValorBruto,
                                   LValorLiquido,
                                   LValorTaxa,
                                   LValorFrete,
                                   LValorAjuste,
                                   LCupomDesconto);

      blnBusca := fBuscaCartaoShopeePay;

      If (blnBusca) Then
      Begin
        LChaveConciliacao := 'SHO_' +  FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').Value + '_' +
                             strParcel + '_' +
                             cdsBaiCar.FieldByName('MCA_EMPRCX').AsString + '_' +
                             FormatDateTime('yyyy-mm-dd', FCdsRegistrosPagamento.FieldByName('SHO_DTADEC').Value);

        MarcarCartaoEncontradoArquivo(LValorBruto,
                                      LValorLiquido,
                                      LRegistroRelatorio,
                                      LChaveConciliacao,
                                      FCdsRegistrosPagamento,
                                      LValorFrete,
                                      LValorAjuste,
                                      Abs(LValorTaxa),
                                      Abs(LCupomDesconto));
      End
      Else
      Begin
        //verifica se está cadastrado ou já foi baixado no período
        cdsBaixad.First;
        blnBusca := fBuscaCartaoBaixadoShopeePay;

        FTextoInconsistencia := 'Vendas não encontradas nos lançamentos do sistema';
        If blnBusca Then
        Begin
          FTextoInconsistencia := 'Vendas já foram baixadas';
          LRegistroRelatorio.InconsistenciaConciliada := 'S';
          LRegistroRelatorio.Conciliado := 1;
          LRegistroRelatorio.AutoIncremMovCar := cdsBaixad.FieldByName('AUTOINCREM').AsString;
        End;
      End;

      If FCdsRegistrosPagamento.FieldByName('SHO_BENEFI').AsString.Equals('Ajuste') Then
      Begin
        If FTextoInconsistencia.Equals('Vendas não encontradas nos lançamentos do sistema') Then
        Begin
          AdicionaRegistrosDeAjusteQuandoEstiverNaTabelaPagamento(FCdsRegistrosPagamento);

          FreeAndNil(LRegistroRelatorio);
          FCdsRegistrosPagamento.Next;
          Continue;
        End;

        If FCdsRegistrosAjuste.Locate('SHO_DTADEC;SHO_BENEFI;SHO_CODAUT',
                                      VarArrayOf([FCdsRegistrosPagamento.FieldByName('SHO_DTADEC').AsDateTime,
                                                  FCdsRegistrosPagamento.FieldByName('SHO_BENEFI').AsString,
                                                  FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString]), []) Then
          FCdsRegistrosAjuste.Delete;
      End;

      If LValorLiquido <= 0 Then
      Begin
        FreeAndNil(LRegistroRelatorio);
        FCdsRegistrosPagamento.Next;
        Continue;
      End;

      {Gerando registro do relatório}
      FTextoInconsistencia := RetornaTextoInconsistenciaAtualizado(FTextoInconsistencia);
      If Not FTextoInconsistencia.IsEmpty Then
      Begin
        LRegistroRelatorio.Descricao := FTextoInconsistencia;
        If Not LRegistroRelatorio.InconsistenciaConciliada.Equals('S') Then
          LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
      End;
      LRegistroRelatorio.NomeArquivo := FCdsRegistrosPagamento.FieldByName('SHO_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString;
      LRegistroRelatorio.CodigoEmpresa := FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString;
      LRegistroRelatorio.NumeroNSU := FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString;
      LRegistroRelatorio.CodigoAutorizacao := FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString;
      LRegistroRelatorio.ResumoVenda := '00000000';
      LRegistroRelatorio.NumeroCartao := 'SHOPEE';

      LRegistroRelatorio.TipoCartao := LTipoOperacao;

      LRegistroRelatorio.Parcela := '01';
      LRegistroRelatorio.TotalParcelas := '01';
      LRegistroRelatorio.DataPagamento := FCdsRegistrosPagamento.FieldByName('SHO_DTADEC').Value;
      LRegistroRelatorio.DataVenda := FCdsRegistrosPagamento.FieldByName('SHO_DTADEC').Value;
      LRegistroRelatorio.DataVencimento := FCdsRegistrosPagamento.FieldByName('SHO_DTADEC').Value;

      LRegistroRelatorio.ValorBruto := LValorBruto;

      LRegistroRelatorio.ValorLiquido := LValorLiquido;
      LRegistroRelatorio.ValorTaxas := LValorTaxa;
      LRegistroRelatorio.ValorFrete := LValorFrete;
      LRegistroRelatorio.ValorAjustes := LValorAjuste;
      LRegistroRelatorio.ValorCupom := Abs(LCupomDesconto);

      LRegistroRelatorio.DescricaoBandeira := 'DIVERSAS';

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      FCdsRegistrosPagamento.Next;
    End;

    Result := True;
  Except
    On E: Exception Do
    Begin
      Raise Exception.Create(E.Message);
    End;
  End;

end;

procedure TConciliaRecebiveisShopeePay.pCriaDataSets;
  Var
    LConsulta,
    LPedidos: TUniQuery;

    LCampoDescontoOriginal,
    LCampoDescontoPix,
    LCampoTaxaPublicidade,
    LCampoTaxaProtecao: Boolean;
begin
  LConsulta := VS_FuncoesExternas.fICriaQuery;
  LPedidos := VS_FuncoesExternas.fICriaQuery;

  LCampoDescontoOriginal := TShopeeFuncoes.CampoExiste('SHO_PDPGTO', 'SHO_DESORI');
  LCampoDescontoPix := TShopeeFuncoes.CampoExiste('SHO_PDPGTO', 'SHO_DESPIX');
  LCampoTaxaPublicidade := TShopeeFuncoes.CampoExiste('SHO_PDPGTO', 'SHO_ADSFEE');
  LCampoTaxaProtecao    := TShopeeFuncoes.CampoExiste('SHO_PDPGTO', 'SHO_TXPROT');

  Try
    //CONCILIAÇÃO FINANCEIRA
    LConsulta.SQL.Text := 'SELECT                             '+
                          '  SHO_DTADEC,                      '+
                          '  SHO_HRADEC,                      '+
                          '  SHO_BENEFI,                      '+
                          '  SHO_VALPAG,                      '+
                          '  SHO_DESCRI,                      '+
                          '  SHO_CODAUT,                      '+
                          '  SHO_STATUS,                      '+
                          '  SHO_SALCAR,                      '+
                          '  SHO_NOMARQ,                      '+
                          '  SHO_CONCIL,                      '+
                          '  SHO_CODEMP,                      '+
                          '  EMP_CODEMP,                      '+
                          '  EMP_NOMEMP,                      '+
                          '  "SHO_SHPGTO" AS TABELA           '+
                          'FROM                               '+
                          '  SHO_SHPGTO                       '+
                          'LEFT JOIN CADEMP                   '+
                          '    ON EMP_CODEMP = '+ fEmpresaSQL  +
                          'WHERE SHO_DTADEC BETWEEN :DTAINI   '+
                          '  AND :DTAFIM                      '+
                          fRetPesqPonVen +

                          'UNION ' +

                          'SELECT                             '+
                          '  SHO_DTADEC,                      '+
                          '  SHO_HRADEC,                      '+
                          '  SHO_BENEFI,                      '+
                          '  SHO_VALPAG,                      '+
                          '  SHO_DESCRI,                      '+
                          '  SHO_CODAUT,                      '+
                          '  SHO_STATUS,                      '+
                          '  SHO_SALCAR,                      '+
                          '  SHO_NOMARQ,                      '+
                          '  SHO_CONCIL,                      '+
                          '  SHO_CODEMP,                      '+
                          '  EMP_CODEMP,                      '+
                          '  EMP_NOMEMP,                      '+
                          '  "SHO_SHAJUS" AS TABELA           '+
                          'FROM                               '+
                          '  SHO_SHAJUS                       '+
                          'LEFT JOIN CADEMP                   '+
                          '    ON EMP_CODEMP = '+ fEmpresaSQL  +
                          'WHERE SHO_DTADEC BETWEEN :DTAINI   '+
                          '  AND :DTAFIM                      '+
                          '  AND SHO_BENEFI="Ajuste"          '+
                          '  AND (                            '+
                          '       (SHO_VALPAG>0 AND           '+
                          '        ((SHO_DESCRI LIKE "%pacote extraviado referente%") OR ' +
                          '         (SHO_DESCRI = CONCAT("AJUSTE PARA ", SHO_CODAUT)) OR ' +
                          '         (SHO_DESCRI RLIKE "Return/Refund Compensation"))     ' +
                          '       )                                                      ' +
                          '     OR (SHO_VALPAG<0 AND          '+
                          '         SHO_DESCRI LIKE "D_bito%devido%reembolso%devolu%")' +
                          '      )                                                    ' +
                          fRetPesqPonVen;

    LConsulta.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LConsulta.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);

    LConsulta.Open;
    FCdsRegistrosPagamento := TShopeeFuncoes.CriarClientDataSet(LConsulta);
    LConsulta.Close;
    Application.ProcessMessages;

    //LISTA PEDIDOS (ORDER ALL)
    LPedidos.SQL.Text := 'SELECT           ' +
                         '  PD.*,          ' +
                         '  MAX(IFNULL(PD.SHO_VALTOT, 0)) - ROUND(MAX(IFNULL(PD.SHO_MOESHO, 0)) / 100, 2) - MAX(IFNULL(PD.SHO_CUPVEN, 0)) - MAX(IFNULL(PD.SHO_CUPSHO, 0)) - ' + RetornaSQLCampoValorNovo(LCampoDescontoPix, 'SHO_DESPIX') + ' AS VALOR_BRUTO, ' +
                         '  MAX(IFNULL(PD.SHO_TAXCOM, 0)) + MAX(IFNULL(PD.SHO_TAXSER, 0)) + MAX(IFNULL(PD.SHO_COMAMS, 0)) + MAX(IFNULL(SHO_CASCOI, 0)) + '
                         + RetornaSQLCampoValorNovo(LCampoTaxaPublicidade, 'SHO_ADSFEE') + ' + ' + RetornaSQLCampoValorNovo(LCampoTaxaProtecao, 'SHO_TXPROT') + ' AS VALOR_TAXA, ' +
                         '  IF(IFNULL(PD.SHO_OPCENV, "") = "Shopee Entrega Direta", 0, MAX(IFNULL(PD.SHO_FREEST, 0))) AS VALOR_FRETE, ' +
                         '  ROUND(MAX(IFNULL(PD.SHO_MOESHO, 0)) / 100, 2) + MAX(IFNULL(PD.SHO_DESFRE, 0)) + MAX(IFNULL(PD.SHO_REESHO, 0)) + MAX(IFNULL(PD.SHO_CUPSHO, 0)) ' +
                                   TShopeeFuncoes.IIF(LCampoDescontoOriginal, ' + MAX(IFNULL(PD.SHO_DESORI, 0)) - MAX(IFNULL(PD.SHO_DESSHO, 0))', '') + ' AS CUPOM_DESCONTO, ' +
                         '  MAX(IFNULL(PD.SHO_VALDEV, 0)) + IF(MAX(IFNULL(PD.SHO_TOTREC, 0)) <= 0, 0, ' + RetornaSQLCampoValorNovo(FCampoReembolsoAjustadoDisputa, 'SHO_DRCREF') +  ') AS VALOR_DEVOLUCAO, ' +

                         ' (MAX(IFNULL(PD.SHO_VALTOT, 0)) - ROUND(MAX(IFNULL(PD.SHO_MOESHO, 0)) / 100, 2) - MAX(IFNULL(PD.SHO_CUPVEN, 0)) - MAX(IFNULL(PD.SHO_CUPSHO, 0)) - ' + RetornaSQLCampoValorNovo(LCampoDescontoPix, 'SHO_DESPIX') + ') - ' +
                         '   (MAX(IFNULL(PD.SHO_TAXCOM, 0)) + MAX(IFNULL(PD.SHO_TAXSER, 0)) + MAX(IFNULL(PD.SHO_COMAMS, 0)) + MAX(IFNULL(SHO_CASCOI, 0)) + '
                         + RetornaSQLCampoValorNovo(LCampoTaxaPublicidade, 'SHO_ADSFEE') + ' + ' + RetornaSQLCampoValorNovo(LCampoTaxaProtecao, 'SHO_TXPROT') + ') - ' +
                         '   (IF(IFNULL(PD.SHO_OPCENV, "") = "Shopee Entrega Direta", 0, MAX(IFNULL(PD.SHO_FREEST, 0)))) + ' +
                         '   (ROUND(MAX(IFNULL(PD.SHO_MOESHO, 0)) / 100, 2) + MAX(IFNULL(PD.SHO_DESFRE, 0)) + MAX(IFNULL(PD.SHO_REESHO, 0)) + MAX(IFNULL(PD.SHO_CUPSHO, 0))' +
                                   TShopeeFuncoes.IIF(LCampoDescontoOriginal, ' + MAX(IFNULL(PD.SHO_DESORI, 0)) - MAX(IFNULL(PD.SHO_DESSHO, 0))', '') + ') + ' +
                         '   MAX(IFNULL(PD.SHO_VALDEV, 0)) + IF(MAX(IFNULL(PD.SHO_TOTREC, 0)) <= 0, 0, ' + RetornaSQLCampoValorNovo(FCampoReembolsoAjustadoDisputa, 'SHO_DRCREF') +  ') ' +
                         '      AS LIQUIDO_CALCULADO, ' +

                         '  MAX(IFNULL(PD.SHO_CUPSHO, 0)) AS CUPOM_SHOPEE, ' +
                         '  EMP_CODEMP, EMP_NOMEMP           '+
                         'FROM                               '+
                         '  SHO_PDPGTO PD                    '+
                         'LEFT JOIN CADEMP                   '+
                         '    ON EMP_CODEMP = '+ fEmpresaSQL  +
                         'WHERE PD.SHO_DTAPAG<=:DTAFIM       '+
                         '  AND PD.SHO_ID_PED IN (' + RetornaListaDePedidos + ') ' +
                         fRetPesqPonVen +
                         '  AND IFNULL(PD.SHO_IMPAPI, "N") = "' + TShopeeFuncoes.IIF(FImportacaoPelaAPI, 'S', 'N') + '" ' +
                         ' GROUP BY PD.SHO_ID_PED ' +
                         ' ORDER BY IFNULL(PD.SHO_DTAIMP, CURRENT_TIMESTAMP) DESC ';

    LPedidos.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);

    LPedidos.Open;
    FCdsRegistrosPedidos := TShopeeFuncoes.CriarClientDataSet(LPedidos);
    LPedidos.Close;
    Application.ProcessMessages;

    //AJUSTES
    LConsulta.SQL.Text := 'SELECT                                '+
                          '  SHO_SHAJUS.*,                       '+
                          '  EMP_CODEMP, EMP_NOMEMP              '+
                          'FROM                                  '+
                          '  SHO_SHAJUS                          '+
                          '  LEFT JOIN CADEMP                    '+
                          '    ON EMP_CODEMP = '+ fEmpresaSQL     +
                          'WHERE SHO_DTADEC BETWEEN :DTAINI      '+
                          '  AND :DTAFIM                         '+
                          '  AND SHO_BENEFI IN("Ajuste da Shopee","Adjustment by Shopee","Ajuste","Saldo da Carteira - Pagamento")'+
                           fRetPesqPonVen;

    LConsulta.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LConsulta.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);

    LConsulta.Open;
    FCdsRegistrosAjuste := TShopeeFuncoes.CriarClientDataSet(LConsulta);
    LConsulta.Close;
    Application.ProcessMessages;

    //TRANSFERÊNCIAS
    LConsulta.SQL.Text := Concat('SELECT SHO_SHAJUS.*, ',
                                 ' EMP_CODEMP, ',
                                 ' POR.SIS_VALCFG AS PORTADOR, ',
                                 ' CTA.SIS_VALCFG AS PLANODECONTAS, ',
                                 ' EVE.SIS_VALCFG AS CENTRODECUSTOS ',
                                 'FROM SHO_SHAJUS ',
                                 '  INNER JOIN CADEMP                 ',
                                 '    ON EMP_CODEMP = '+ fEmpresaSQL + ' ',
                                 '  LEFT JOIN CFGSIS AS POR ',
                                 '    ON POR.SIS_CODEMP = EMP_CODEMP AND ',
                                 '       POR.SIS_CODCFG = "CFG_SHOTRF" ',
                                 '  LEFT JOIN CFGSIS AS CTA ',
                                 '    ON CTA.SIS_CODEMP = EMP_CODEMP AND ',
                                 '       CTA.SIS_CODCFG = "CFG_SHOCTF" ',
                                 '  LEFT JOIN CFGSIS AS EVE ',
                                 '    ON EVE.SIS_CODEMP = EMP_CODEMP AND ',
                                 '       EVE.SIS_CODCFG = "CFG_SHOETF" ',
                                 'WHERE SHO_DTADEC BETWEEN :DTAINI AND :DTAFIM ',
                                 'AND SHO_DESCRI IN ("SAQUE", "SAQUE AUTOMÁTICO") ',
                                 'AND SHO_VALPAG <> 0 ',
                                 fRetPesqPonVen);

    LConsulta.ParamByName('DTAINI').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaIni);
    LConsulta.ParamByName('DTAFIM').AsString := FormatDateTime('yyyy-mm-dd', dtaDtaFim);
    LConsulta.Open;

    FCdsRegistrosTransferencias := TShopeeFuncoes.CriarClientDataSet(LConsulta);
    LConsulta.Close;
    Application.ProcessMessages;
  Finally
    FreeAndNil(LConsulta);
    FreeAndNil(LPedidos);

    VS_FuncoesExternas.pITrimAppMemorySize;
  End;
end;

procedure TConciliaRecebiveisShopeePay.VerificaSePedidoFoiAjustadoEInformacoesSaoInconsistentes(
  var AValorAjuste: Double);
begin
  If Not FCdsRegistrosPagamento.FieldByName('SHO_BENEFI').AsString.Equals('Ajuste') Then
    Exit;

  If TShopeeFuncoes.fFormataFloat(FCdsRegistrosPagamento.FieldByName('SHO_VALPAG').AsFloat, 2) <= 0 Then
    Exit;

  AValorAjuste := -AValorAjuste + (FCdsRegistrosPagamento.FieldByName('SHO_VALPAG').AsFloat -
                                   FCdsRegistrosPedidos.FieldByName('LIQUIDO_CALCULADO').AsFloat);

  AValorAjuste := AValorAjuste * (-1);
end;

procedure TConciliaRecebiveisShopeePay.VerificaSePedidoFoiCancelado(Var AValorBruto,
  AValorLiquido, AValorTaxa, AValorFrete, AValorAjuste, ACupomDesconto: Double);
  Var
    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  If (FCdsRegistrosPagamento.FieldByName('SHO_VALPAG').AsFloat <= 0) Then
  Begin
    AValorLiquido := 0;
    AValorTaxa := 0;
    AValorFrete := 0;
    AValorAjuste := AValorBruto;
    ACupomDesconto := 0;

    If FCdsRegistrosPagamento.FieldByName('SHO_VALPAG').AsFloat = 0 Then
      Exit;

    LRegistroRelatorio := TItensRelatorioCartoes.Create;

    {Gerando registro do relatório}
    LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
    LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
    LRegistroRelatorio.DescricaoAjuste := AnsiUpperCase('Pedido ' + FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString +' Cancelado');
    If FCdsRegistrosPagamento.FieldByName('SHO_BENEFI').AsString.Equals('Ajuste') Then
      LRegistroRelatorio.DescricaoAjuste := AnsiUpperCase(FCdsRegistrosPagamento.FieldByName('SHO_DESCRI').AsString);
    LRegistroRelatorio.NomeArquivo := FCdsRegistrosPagamento.FieldByName('SHO_NOMARQ').AsString;
    LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString;
    LRegistroRelatorio.CodigoEmpresa := FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString;
    LRegistroRelatorio.NumeroNSU := FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString;
    LRegistroRelatorio.CodigoAutorizacao := FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString;
    LRegistroRelatorio.ResumoVenda := '000000000';
    LRegistroRelatorio.NumeroCartao := '00000000000000000';

    LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';

    LRegistroRelatorio.Parcela := '01';
    LRegistroRelatorio.TotalParcelas := '01';
    LRegistroRelatorio.DataPagamento := FCdsRegistrosPagamento.FieldByName('SHO_DTADEC').Value;
    LRegistroRelatorio.DataVenda := FCdsRegistrosPagamento.FieldByName('SHO_DTADEC').Value;
    LRegistroRelatorio.DataVencimento := FCdsRegistrosPagamento.FieldByName('SHO_DTADEC').Value;

    LRegistroRelatorio.ValorBruto := FCdsRegistrosPagamento.FieldByName('SHO_VALPAG').AsFloat;
    LRegistroRelatorio.ValorLiquido := FCdsRegistrosPagamento.FieldByName('SHO_VALPAG').AsFloat;

    LRegistroRelatorio.ValorTaxas := 0;
    LRegistroRelatorio.ValorFrete := 0;
    LRegistroRelatorio.ValorAjustes := 0;
    LRegistroRelatorio.ValorCupom := 0;

    LRegistroRelatorio.DescricaoBandeira := 'DIVERSAS';

    LRegistroRelatorio.Conciliado := FCdsRegistrosPagamento.FieldByName('SHO_CONCIL').AsInteger;

    GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, FCdsRegistrosPagamento);

    FListaRegistrosRelatorio.Add(LRegistroRelatorio);

    If FCdsRegistrosPagamento.FieldByName('SHO_BENEFI').AsString.Equals('Ajuste') Then
    Begin
      FListaRegistrosConciliar.Add(fRetornaChaveConciliacaoAjuste(FCdsRegistrosPagamento));

      If FCdsRegistrosAjuste.Locate('SHO_DTADEC;SHO_BENEFI;SHO_CODAUT;SHO_VALPAG',
                                    VarArrayOf([FCdsRegistrosPagamento.FieldByName('SHO_DTADEC').AsDateTime,
                                                FCdsRegistrosPagamento.FieldByName('SHO_BENEFI').AsString,
                                                FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString,
                                                FCdsRegistrosPagamento.FieldByName('SHO_VALPAG').Value]), []) Then
        FCdsRegistrosAjuste.Delete;
    End;
  End;
end;

function TConciliaRecebiveisShopeePay.FiltraAjustesShopeePay(pgbStatus: TcxProgressBar): Boolean;
  Var
    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  Result := True;

  pAdicionaRegistrosDeTransferenciasShopee;

  Try
    FCdsRegistrosAjuste.First;

    pgbStatus.Position := 0;
    pgbStatus.Properties.Max := FCdsRegistrosAjuste.RecordCount;

    While Not FCdsRegistrosAjuste.Eof Do
    Begin
      TShopeeFuncoes.pStepStatusGravacao(pgbStatus);

      If MatchStr(AnsiUpperCase(FCdsRegistrosAjuste.FieldByName('SHO_DESCRI').AsString), ['SAQUE', 'SAQUE AUTOMÁTICO']) Then
      Begin
        FCdsRegistrosAjuste.Delete;
        Continue;
      End;

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      {Gerando registro do relatório}
      LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
      LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
      LRegistroRelatorio.DescricaoAjuste := AnsiUpperCase(FCdsRegistrosAjuste.FieldByName('SHO_DESCRI').Value);
      LRegistroRelatorio.NomeArquivo := FCdsRegistrosAjuste.FieldByName('SHO_NOMARQ').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosAjuste.FieldByName('EMP_CODEMP').AsString;
      LRegistroRelatorio.CodigoEmpresa := FCdsRegistrosAjuste.FieldByName('EMP_CODEMP').AsString;
      LRegistroRelatorio.NumeroNSU := '00000000000000';
      LRegistroRelatorio.CodigoAutorizacao := '00000000000000';
      LRegistroRelatorio.ResumoVenda := '000000000';
      LRegistroRelatorio.NumeroCartao := '00000000000000000';

      LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';

      LRegistroRelatorio.Parcela := '01';
      LRegistroRelatorio.TotalParcelas := '01';
      LRegistroRelatorio.DataPagamento := FCdsRegistrosAjuste.FieldByName('SHO_DTADEC').Value;
      LRegistroRelatorio.DataVenda := FCdsRegistrosAjuste.FieldByName('SHO_DTADEC').Value;
      LRegistroRelatorio.DataVencimento := FCdsRegistrosAjuste.FieldByName('SHO_DTADEC').Value;

      LRegistroRelatorio.ValorBruto := FCdsRegistrosAjuste.FieldByName('SHO_VALPAG').Value;
      LRegistroRelatorio.ValorLiquido := FCdsRegistrosAjuste.FieldByName('SHO_VALPAG').Value;

      LRegistroRelatorio.ValorTaxas := 0;
      LRegistroRelatorio.ValorFrete := 0;
      LRegistroRelatorio.ValorAjustes := 0;
      LRegistroRelatorio.ValorCupom := 0;

      LRegistroRelatorio.DescricaoBandeira := 'DIVERSAS';

      LRegistroRelatorio.Conciliado := FCdsRegistrosAjuste.FieldByName('SHO_CONCIL').AsInteger;

      GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, True, FCdsRegistrosAjuste);

      FListaRegistrosConciliar.Add(fRetornaChaveConciliacaoAjuste(FCdsRegistrosAjuste));

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      FCdsRegistrosAjuste.Next;
    End;

  Except
    On E: Exception Do
      Raise Exception.Create(E.Message);
  End;
end;

procedure TConciliaRecebiveisShopeePay.pFiltraCartoesBaixadosShopeePay;
  Var
    strSQL   : String;
    qryBaixad: TUniQuery;
begin
  strSQL := '';
  strSQL := strSQL + ' SELECT MCA_NUMCCD, MCA_PARCEL, MCA_DTAREC, MCA_NUMNSU, ';
  strSQL := strSQL + ' AUTOINCREM, MCA_NUMDUP, MCA_DTACUP, ';
  strSQL := strSQL + ' MCA_CODEMP, MCA_DTAVEN, MCA_EMPRCX, MCA_CHACON ';
  strSQL := strSQL + ' FROM MOVCAR  ';
  strSQL := strSQL + ' WHERE ';

  If Not FCartaoShopee.IsEmpty Then
    strSQL := strSQL + ' MCA_CODCAR IN (' + TShopeeFuncoes.fRetStrToSQLIn(FCartaoShopee) + ') AND ';

  strSQL := strSQL + ' (MCA_NUMNSU IN (' + FListaDePedidos + ') OR MCA_NUMCCD IN (' + FListaDePedidos + ')) ';
  strSQL := strSQL + ' AND MCA_PARCEL="A" ';
  strSQL := strSQL + ' AND MCA_DTAREC IS NOT NULL ';
  strSQL := strSQL + ' ORDER BY MCA_NUMNSU, MCA_PARCEL,MCA_CODEMP ';

  qryBaixad := VS_FuncoesExternas.fICriaQuery;
  Try
    qryBaixad.SQL.Text := strSQL;
    qryBaixad.Open;
    cdsBaixad := TShopeeFuncoes.CriarClientDataSet(qryBaixad);
    cdsBaixad.Open;

    cdsBaixad.IndexFieldNames := 'MCA_NUMNSU;MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_CODEMP';
  Finally
    qryBaixad.Close;
    FreeAndNil(qryBaixad);
  End;
end;

procedure TConciliaRecebiveisShopeePay.pFiltraCartoesShopeePay;
  Var
    strSQL: String;
begin
  FCartaoShopee := VS_FuncoesExternas.fICfgSis('SHOCAR');

  FListaDePedidos := RetornaListaDePedidos;

  strSQL := TLibCartoesMovCar.fGetSQLCartoes(objConcil);

  If Not FCartaoShopee.IsEmpty Then
    strSQL := strSQL + ' AND MCA_CODCAR IN (' + TShopeeFuncoes.fRetStrToSQLIn(FCartaoShopee) + ') ';

  strSQL := strSQL + ' AND (MCA_NUMCCD IN (' + FListaDePedidos + ') OR MCA_NUMNSU IN (' + FListaDePedidos + ')) ';
  strSQL := strSQL + ' AND MCA_PARCEL="A" ';

  strSQL := strSQL + ' ORDER BY MCA_NUMNSU,MCA_NUMCCD,MCA_CODEMP,PARDUP,MCA_DTACUP,MCA_NUMDUP) AS TMP ';

  qryBaiCar := Nil;
  Try
    qryBaiCar := VS_FuncoesExternas.fICriaQuery;
    qryBaiCar.SQL.Text := strSQL;
    qryBaiCar.Options.SetFieldsReadOnly := False;
    qryBaiCar.Open;

    cdsBaiCar := TShopeeFuncoes.CriarClientDataSet(qryBaiCar);
    cdsBaiCar.IndexFieldNames := 'MCA_NUMNSU;MCA_NUMCCD;MCA_CODEMP;PARDUP;MCA_DTACUP;MCA_NUMDUP';
    cdsBaiCar.Open;
  Finally
    TShopeeFuncoes.FreeAndNilDatasets(qryBaiCar);
  End;
End;

function TConciliaRecebiveisShopeePay.fBuscaCartaoShopeePay: Boolean;
begin
  Result := cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_MARDES',
                              VarArrayOf([AnsiUpperCase(FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString),
                                          'A', 'D']),[]);

  If Not Result Then
     Result := cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_MARDES',
                                 VarArrayOf([UpperCase(FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString),
                                             'A', 'D']),[]);
end;

procedure TConciliaRecebiveisShopeePay.GeraRegistroSemPedidoImportado;
  Var
    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  LRegistroRelatorio := TItensRelatorioCartoes.Create;

  LRegistroRelatorio.NomeArquivo := FCdsRegistrosPagamento.FieldByName('SHO_NOMARQ').AsString;
  LRegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
  LRegistroRelatorio.Descricao := 'Venda faltando registros do pedido';
  LRegistroRelatorio.DescricaoAjuste := 'Venda faltando registros do pedido';
  LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString;
  LRegistroRelatorio.CodigoEmpresa := FCdsRegistrosPagamento.FieldByName('EMP_CODEMP').AsString;
  LRegistroRelatorio.TipoCartao := 'CRÉDITO ROTATIVO';
  LRegistroRelatorio.CodigoAutorizacao := FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString;
  LRegistroRelatorio.NumeroNSU := FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString;
  LRegistroRelatorio.DataVenda := FCdsRegistrosPagamento.FieldByName('SHO_DTADEC').AsDateTime;
  LRegistroRelatorio.DataPagamento := FCdsRegistrosPagamento.FieldByName('SHO_DTADEC').AsDateTime;
  LRegistroRelatorio.ValorLiquido := FCdsRegistrosPagamento.FieldByName('SHO_VALPAG').AsFloat;
  LRegistroRelatorio.ValorBruto := FCdsRegistrosPagamento.FieldByName('SHO_VALPAG').AsFloat;
  LRegistroRelatorio.Parcela := '01';
  LRegistroRelatorio.TotalParcelas := '01';
  LRegistroRelatorio.RegistroIncompleto := 'N';
  LRegistroRelatorio.InconsistenciaConciliada := 'N';

  FListaRegistrosRelatorio.Add(LRegistroRelatorio);
end;

function TConciliaRecebiveisShopeePay.fBuscaCartaoBaixadoShopeePay: Boolean;
begin
  Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL',
                                VarArrayOf([AnsiUpperCase(FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString),
                                            'A']),[]);

  If Not Result Then
    Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL',
                                VarArrayOf([UpperCase(FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString),
                                            'A']),[]);

  If Result Then
  Begin
    If FCdsRegistrosPagamento.FieldByName('SHO_BENEFI').AsString.Equals('Ajuste') Then
    Begin
      Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL;MCA_DTAREC',
                                 VarArrayOf([AnsiUpperCase(FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString),
                                            'A',
                                            FCdsRegistrosPagamento.FieldByName('SHO_DTADEC').AsDateTime]),[]);
      If Not Result Then
        Result := cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL;MCA_DTAREC',
                                   VarArrayOf([AnsiUpperCase(FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString),
                                              'A',
                                              FCdsRegistrosPagamento.FieldByName('SHO_DTADEC').AsDateTime]),[]);
    End;
  End;

  blnAutomatica := (Result) And
                   (Not TShopeeFuncoes.fEmptyStr(cdsBaixad.FieldbyName('MCA_CHACON').AsString));
end;

function TConciliaRecebiveisShopeePay.RegistroDeAjusteDeveSerAgrupado(
  ADatasetAjuste: TDataset): Boolean;
begin
  Result := False;

  If ADatasetAjuste.FieldByName('SHO_VALPAG').AsFloat >= 0 Then
  Begin
    If Not FCampoReembolsoAjustadoDisputa Then
      Exit;

    If Not FCdsRegistrosPagamento.Locate('SHO_DTADEC;SHO_CODAUT;SHO_BENEFI',
                                         VarArrayOf([ADatasetAjuste.FieldByName('SHO_DTADEC').AsDateTime,
                                                     ADatasetAjuste.FieldByName('SHO_CODAUT').AsString,
                                                     'Renda do pedido']), [loCaseInsensitive]) Then
      Exit;

    If Not FCdsRegistrosPedidos.Locate('SHO_ID_PED',
                                       ADatasetAjuste.FieldByName('SHO_CODAUT').AsString, []) Then
      Exit;

    If FCdsRegistrosPedidos.FieldByName('SHO_DRCREF').IsNull Then
      Exit;

    // Mesma condição do VALOR_DEVOLUCAO em pCriaDataSets: com a renda do pedido
    // negativa o SHO_DRCREF fica fora do LIQUIDO_CALCULADO, e somar o ajuste à
    // renda faz a taxa recalculada sair negativa, lançada como débito na baixa.
    If FCdsRegistrosPedidos.FieldByName('SHO_TOTREC').AsFloat <= 0 Then
      Exit;

    Exit(FCdsRegistrosPedidos.FieldByName('SHO_DRCREF').AsFloat > 0);
  End;

  Result := True;
end;

function TConciliaRecebiveisShopeePay.RetornaEmpresaFiltrada: String;
begin
  Result := EmptyStr;

  If Length(arrEmpresa) = 0 Then
    Exit;

  Result := arrEmpresa[0].strCodigo;
end;

function TConciliaRecebiveisShopeePay.RetornaListaDePedidos: String;
begin
  FCdsRegistrosPagamento.First;

  While Not FCdsRegistrosPagamento.Eof Do
  Begin
    Result := Result + '"' + FCdsRegistrosPagamento.FieldByName('SHO_CODAUT').AsString + '",';
    FCdsRegistrosPagamento.Next;
  End;

  FCdsRegistrosPagamento.First;

  If Not Result.IsEmpty Then
    Result := LeftStr(Result, Result.Length - 1)
  Else
    Result := '" "';
end;

function TConciliaRecebiveisShopeePay.RetornaSQLCampoValorNovo(
  ACampoExiste: Boolean; ANomeCampo: String): String;
begin
  If Not ACampoExiste Then
    Exit('0');

  If ANomeCampo.Trim.isEmpty Then
    Exit('0');

  Result := 'MAX(IFNULL(' + ANomeCampo + ',0)) ';
end;

function TConciliaRecebiveisShopeePay.RetornaValorTaxaAjustadaPedido(AValorLiquidoCalculado,
  AValorLiquido, AValorTaxa: Double): Double;
begin
  Result := AValorTaxa;

  If AValorLiquido <= 0 Then
    Exit;

  Result := Result + AValorLiquidoCalculado - AValorLiquido;
end;

procedure TConciliaRecebiveisShopeePay.TratamentoValorBrutoZerado(
  var AValorBruto, ACupomDesconto: Double);
begin
  If Not FormatFloat(',0.00', AValorBruto).Equals('0,00') Then
    Exit;

  If FormatFloat(',0.00', ACupomDesconto).Equals('0,00') Then
    Exit;


  AValorBruto := Abs(FCdsRegistrosPedidos.FieldByName('CUPOM_SHOPEE').AsFloat);

  If AValorBruto <= 0 Then
  Begin
    AValorBruto := ACupomDesconto;
    ACupomDesconto := 0;

    Exit;
  End;

  ACupomDesconto := ACupomDesconto - AValorBruto;
end;

procedure TConciliaRecebiveisShopeePay.pAdicionaRegistrosDeTransferenciasShopee;
var
  LRegistroRelatorio: TItensRelatorioCartoes;
begin
  try
    FCdsRegistrosTransferencias.First;
    while not FCdsRegistrosTransferencias.Eof do
    begin
      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LRegistroRelatorio.ValorBruto := TShopeeFuncoes.fFormataFloat(FCdsRegistrosTransferencias.FieldByName('SHO_VALPAG').AsFloat, 2);
      LRegistroRelatorio.ValorLiquido := TShopeeFuncoes.fFormataFloat(FCdsRegistrosTransferencias.FieldByName('SHO_VALPAG').AsFloat, 2);

      LRegistroRelatorio.Descricao := 'TRANSFERÊNCIAS';
      LRegistroRelatorio.TipoDoRegistro := 'TRANSFERÊNCIA';
      LRegistroRelatorio.TipoCartao := 'TRANSFERÊNCIAS';
      LRegistroRelatorio.DescricaoAjuste := 'TRANSFERÊNCIA';

      LRegistroRelatorio.CodigoEmpresa := FCdsRegistrosTransferencias.FieldByName('EMP_CODEMP').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := FCdsRegistrosTransferencias.FieldByName('EMP_CODEMP').AsString;
      LRegistroRelatorio.NumeroNSU := FCdsRegistrosTransferencias.FieldByName('SHO_CODAUT').AsString;
      LRegistroRelatorio.NumeroCartao := '0';
      LRegistroRelatorio.Parcela := '01';
      LRegistroRelatorio.TotalParcelas := '01';
      LRegistroRelatorio.CodigoAutorizacao := TShopeeFuncoes.fStrZero(RightStr(Trim(FCdsRegistrosTransferencias.FieldByName('SHO_CODAUT').AsString), 6), 6);

      LRegistroRelatorio.DataVenda := FCdsRegistrosTransferencias.FieldByName('SHO_DTADEC').AsDateTime;
      LRegistroRelatorio.DataPagamento := FCdsRegistrosTransferencias.FieldByName('SHO_DTADEC').AsDateTime;

      LRegistroRelatorio.RegistroTransferencia := 'S';
      LRegistroRelatorio.PortadorTransferencia := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPortadorTransferencia, FCdsRegistrosTransferencias.FieldByName('EMP_CODEMP').AsString);
      LRegistroRelatorio.PlanoContasTransferenciaCredito := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPlanoDeContasTransferencia, FCdsRegistrosTransferencias.FieldByName('EMP_CODEMP').AsString);
      LRegistroRelatorio.CentroCustosTransferencia := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgCentroDeCustosTransferencia, FCdsRegistrosTransferencias.FieldByName('EMP_CODEMP').AsString);
      LRegistroRelatorio.PlanoContasTransferenciaDebito := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPlanoDeContasTransferenciaLancDeb, FCdsRegistrosTransferencias.FieldByName('EMP_CODEMP').AsString);

      LRegistroRelatorio.PortadorCredito := LRegistroRelatorio.PortadorTransferencia;
      LRegistroRelatorio.PortadorDebito := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPortadorAjustes, FCdsRegistrosTransferencias.FieldByName('EMP_CODEMP').AsString);

      If LRegistroRelatorio.PlanoContasTransferenciaDebito.IsEmpty Then
        LRegistroRelatorio.PlanoContasTransferenciaDebito := FCdsRegistrosTransferencias.FieldByName('PLANODECONTAS').AsString;

      LRegistroRelatorio.Conciliado := FCdsRegistrosTransferencias.FieldByName('SHO_CONCIL').AsInteger;
      LRegistroRelatorio.NomeArquivo := FCdsRegistrosTransferencias.FieldByName('SHO_NOMARQ').AsString;

      LRegistroRelatorio.RegistroIncompleto := 'N';
      If Not LRegistroRelatorio.PortadorTransferencia.IsEmpty Then
      Begin
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, False, FCdsRegistrosTransferencias);
        FListaRegistrosConciliar.Add(fRetornaChaveConciliacaoAjuste(FCdsRegistrosTransferencias));

        cdsBaiCar.Edit;
        cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString  := fRetornaChaveConciliacaoAjuste(FCdsRegistrosTransferencias);
        cdsBaiCar.Post;
      End;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      FCdsRegistrosTransferencias.Next;
    end;
  Except
    Raise;
  end;
end;

end.

