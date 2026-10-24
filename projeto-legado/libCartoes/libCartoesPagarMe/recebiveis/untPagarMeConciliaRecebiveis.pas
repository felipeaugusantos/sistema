unit untPagarMeConciliaRecebiveis;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, Vcl.Graphics, Vcl.Controls, System.Math,
     System.Generics.Collections,

     Uni, UniClientDataSet, cxProgressBar,

     untLibCartoesInterfacesTipos, untTLockLibCartoes, untTPagarMeFuncoes;

Type
  TRelatorioConciliacao = class
  public
    AutoIncremRelatorio,
    ChaveRelatorio,
    CodigoOperador,
    Operadora,
    TipoRelatorio,
    FiltrosRelatorio: String;

    DataRelatorio,
    HoraRelatorio: TDateTime;

    constructor Create(ACodigoOperador,
                       AOperadora,
                       ATipoRelatorio,
                       AFiltrosRelatorio: String;
                       ADataRelatorio,
                       AHoraRelatorio: TDateTime);
  End;

  TItensRelatorioCartoes = class
  private
  public
    NomeArquivo,
    Descricao,
    CodigoEstabelecimento,
    CodigoEmpresa,
    NumeroNSU,
    CodigoAutorizacao,
    Parcela,
    TotalParcelas: String;

    DataPagamento,
    DataVenda,
    DataVencimento: TDateTime;

    ValorBruto,
    ValorLiquido,
    ValorTaxas,
    ValorFrete,
    ValorAjustes,
    ValorCupom,
    PercentualTaxa: Double;

    ResumoVenda,
    NumeroCartao,
    CodigoBandeira,
    DescricaoBandeira,
    TipoCartao,
    TipoDoRegistro,
    SomarNoTotal,
    RegistroIncompleto,
    PortadorDebito,
    PortadorCredito,

    RegistroNegociacao,
    NumeroNegociacao,
    PlanoContasTaxaNegociacao,

    RegistroTransferencia,
    PortadorTransferencia,
    PlanoContasTransferenciaCredito,
    PlanoContasTransferenciaDebito,
    CentroCustosTransferencia,

    InconsistenciaConciliada,

    DescricaoAjuste,
    NomeRecebedor,

    ChavePrimaria,

    AutoIncremMovCar: String;

    Conciliado: Integer;

    constructor Create;
  End;

  TListaRegistrosRelatorio = TObjectList<TItensRelatorioCartoes>;

type TConciliaRecebiveisMkt = class
  cdsAjustes:  TUniClientDataSet;        //DATASET AJUSTES/CANCELAMENTOS

  FBandeiraCartao: String;
  objConcil  : TCamposConcil;

  blnAutomatica: Boolean;

  FTextoInconsistencia: String;

  FConciliacaoComPixAtivado: Boolean;
  LConciliacaoComBoletoAtivado: Boolean;

  FLiberacaoTransferencia: Boolean;

  FFiltrarAutorizacaoNSU: Boolean;
  FInAutorizacaoFiltrar: String;
  FInNsuFiltrar: String;

  FRelatorioConciliacao: TRelatorioConciliacao;

  FListaRegistrosRelatorio: TListaRegistrosRelatorio;

  FObrigatorioCentroDeCustos: Boolean;

  FConfiguracaoTaxaAdministrativa: String;

  FFiltrosRelatorio: TFiltrosRelatorioBaixaCartoes;

  procedure MarcarCartaoEncontradoAPI(AValorBruto,
                                      AValorRecebido: Double;
                                      ARegistroAntecipado: Boolean;
                                      var ARegistroRelatorio: TItensRelatorioCartoes;
                                      AChaveConciliacao: String;
                                      ADatasetRegistro: TDataset;
                                      ATaxaAntecipacao: Double);

  function CartaoRecebidoPeloCaixaENaoTransferido(ADataset: TDataset): Boolean;

  procedure pAcertaDadosDeBaixaOtimizadaPorEmpresa;

  function CarregaFiltrosParaBaixaRecebiveis(ADataInicial,
                                             ADataFinal: TDateTime;
                                             AArrayEmpresas: TConsultasArray): Boolean;

  function fRetNomBandeira(strNumCar: String;
                           ATipoCartao: String = ''): String;

  procedure RetornaTotaisValoresQueSeraoBaixados(out AQuantidadeBaixados: Integer;
                                                 out ABrutoBaixados: Double;
                                                 out ALiquidoBaixados: Double);

  procedure GravarRegistroDeAjusteParaConciliacao(ARegistroRelatorio: TItensRelatorioCartoes;
                                                  AGravaCampoValorBruto: Boolean = False;
                                                  ADatasetSelecionado: TDataset = Nil);

  function fBetween(fltValor, fltMinimo, fltMaximo: Double): Boolean;

  function fRetornaChaveConciliacao(cdsDataset: TDataset;
                                    ARetornaSemAjustes: Boolean = False): String;

  function PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(AValorBruto: Double;
                                                             ARegistro: TDataSet;
                                                             APercentual: Boolean = True): Boolean;
  function RetornaTaxaParaValidacao:Double;
  function RetornaTextoInconsistenciaAtualizado(ATextoInconsistencia: String): String;

  function fRetornaDadosDeBaixaDosAjustes(strConfiguracao,
                                          strEmpresaConfiguracao: String): String;

  function RetornaValorTolerancia(ACodEmp: String;ADefault: Double = 0): Double ;

  function RetornaParcelaCartao(AParcelaAtual, ATotalParcelas: String): String;

  function ConfiguracoesAjustesEstaoIncompletas(ACodigoEmpresa: String): String;

  function GravarRegistrosRelatorio(prgStatus: TcxProgressBar): Boolean;

  procedure RemoverRelatorioConciliacao(AUnitRemocao: String);

  function RetornaFiltrosDigitados: String;

  private
    FCartoesConciliar: String;
    FExibirCartoesPendente: Boolean;
    FLancarAjustesACredito: Boolean;
    FTemAjusteACredito: Boolean;

    FPossuiInconsistencia: Boolean;

    FDataInicioPeriodo,
    FDataFinalPeriodo: TDateTime;

    FEmpresasPeriodo: TConsultasArray;
  protected
    dtaDtaIni,
    dtaDtaFim,
    dtaDtaPag  : TDate;
    lstDtaCad  : TStringList;
    FTipoTransferenciaCaixa,
    strResumo,
    strDtaIni,
    strDtaFim: String;

    FAjustesJaConciliados  : Boolean;

    property CartoesConciliar: String read FCartoesConciliar write FCartoesConciliar;
  public
    cdsBaiCar,                    //DATASET PARA MARCAÇÃO DE REGISTROS CONCILIADOS
    cdsBaixad: TUniCLientDataSet; //DATASET PARA BUSCAR SE FOI BAIXADO

    blnReabre   : Boolean;
    strNomCon   : String;

    FobjLockEstabelecimento: TLock;

    constructor Create;
    destructor Destroy; override;

    function fConciliaCartoes(prgStatus: TcxProgressBar): Boolean; virtual;

    property PossuiInconsistencia: Boolean read FPossuiInconsistencia write FPossuiInconsistencia Default False;

    property DataInicioPeriodo: TDateTime read FDataInicioPeriodo write FDataInicioPeriodo;
    property DataFinalPeriodo: TDateTime read FDataFinalPeriodo write FDataFinalPeriodo;
    property EmpresasPeriodo: TConsultasArray read FEmpresasPeriodo write FEmpresasPeriodo;

    property DataInicialConciliacao: TDate Read  dtaDtaIni;
    property DataFinalConciliacao  : TDate Read  dtaDtaFim;
    property ExibirCartoesPendente : Boolean Read FExibirCartoesPendente;

    property FiltrosRelatorio: TFiltrosRelatorioBaixaCartoes Read FFiltrosRelatorio;
  end;

implementation
uses untLibCartoesGravando, untTLibCartoesMovCar, untLibCartoesConstantes;

function TConciliaRecebiveisMkt.CarregaFiltrosParaBaixaRecebiveis(ADataInicial,
  ADataFinal: TDateTime; AArrayEmpresas: TConsultasArray): Boolean;
  Var
    LContadorItem: Integer;
begin
  //Data e array para filtrar os registros de arquivos de conciliação
  dtaDtaIni := ADataInicial;
  dtaDtaFim := ADataFinal;
  strDtaIni := DateToStr(ADataInicial);
  strDtaFim := DateToStr(ADataFinal);

  SetLength(FEmpresasPeriodo, Length(AArrayEmpresas));
  FFiltrosRelatorio.ListaEmpresas := '';
  For LContadorItem := 0 To High(AArrayEmpresas) Do
  Begin
    FEmpresasPeriodo[LContadorItem].strCodigo := AArrayEmpresas[LContadorItem].strCodigo;

    FFiltrosRelatorio.ListaEmpresas := FFiltrosRelatorio.ListaEmpresas +
                                       AArrayEmpresas[LContadorItem].strCodigo + ',';
  End;

  If Not FFiltrosRelatorio.ListaEmpresas.IsEmpty Then
  Begin
    FFiltrosRelatorio.ListaEmpresas := LeftStr(FFiltrosRelatorio.ListaEmpresas, FFiltrosRelatorio.ListaEmpresas.Length - 1);

    If Length(AArrayEmpresas) > 1 Then
      FFiltrosRelatorio.ListaEmpresas := '(IN)' + FFiltrosRelatorio.ListaEmpresas;
  End;

  //Para utilização da Baixa de recebíveis
  FDataInicioPeriodo := ADataInicial;
  FDataFinalPeriodo := ADataFinal;
  FEmpresasPeriodo := AArrayEmpresas;

  Result := FDataFinalPeriodo - FDataInicioPeriodo <= 365;

  If Not Result Then
   TPagarMeFuncoes.fMensagem('ATENÇÃO', 'O filtro para conciliação não pode ser maior que 365 dias (1 ano)!', ['&OK'])
end;

function TConciliaRecebiveisMkt.CartaoRecebidoPeloCaixaENaoTransferido(
  ADataset: TDataset): Boolean;
begin
  If FTipoTransferenciaCaixa.Equals('1') Then
    Exit(False);

  If Not ADataset.FieldByName('MCA_RESCAI').AsString.Equals('1') Then
    Exit(False);

  If Not ADataset.FieldByName('MCA_DTATRA').IsNull Then
    Exit(False);

  Result := True;
end;

function TConciliaRecebiveisMkt.ConfiguracoesAjustesEstaoIncompletas(
  ACodigoEmpresa: String): String;
begin
  Result := 'S';

  If ACodigoEmpresa.Trim.IsEmpty Then
    Exit;

  If TPagarMeFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgPortadorAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If TPagarMeFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgPlanoDeContasAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If TPagarMeFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgFornecedorAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If Not FObrigatorioCentroDeCustos Then
    Exit('N');

  If TPagarMeFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.strEventoCancelamentoAjuste, varString, ACodigoEmpresa)) Then
    Exit;

  Result := 'N';
end;

constructor TConciliaRecebiveisMkt.Create;
begin
  blnReabre  := False;
  
  FListaRegistrosRelatorio := TListaRegistrosRelatorio.Create;

  FAjustesJaConciliados := True;
  blnAutomatica  := False;

  FLancarAjustesACredito := TPagarMeFuncoes.RetornaValorCfg('CFG_AJUCRE').Equals('S');
  FTemAjusteACredito := False;

  FConciliacaoComPixAtivado := False;
  LConciliacaoComBoletoAtivado := False;

  FCartoesConciliar := '';

  FLiberacaoTransferencia := TPagarMeFuncoes.RetornaValorCfg('CFG_USAAUT').Equals('S');

  FFiltrarAutorizacaoNSU := False;

  objConcil.CodigoEmpresaFixaParaBaixa := '';

  FDataInicioPeriodo := 0;
  FDataFinalPeriodo := 0;

  SetLength(FEmpresasPeriodo, 0);

  FObrigatorioCentroDeCustos := VS_FuncoesExternas.fICfgSis('CTPOBE', varBoolean);
  FConfiguracaoTaxaAdministrativa := TPagarMeFuncoes.RetornaValorCfg('CFG_VLDTAX')
end;

destructor TConciliaRecebiveisMkt.Destroy;
begin
  If Assigned(FRelatorioConciliacao) Then
  Begin
    If Not FRelatorioConciliacao.AutoIncremRelatorio.IsEmpty Then
      RemoverRelatorioConciliacao('frmPagarMeBaixaRecebiveisMkt');
  End;

  TPagarMeFuncoes.FreeAndNilDatasets(cdsAjustes);
  TPagarMeFuncoes.FreeAndNilDatasets(cdsBaiCar);
  TPagarMeFuncoes.FreeAndNilDatasets(cdsBaixad);

  If Assigned(FRelatorioConciliacao) Then
    FreeAndNil(FRelatorioConciliacao);

  If Assigned(FListaRegistrosRelatorio) Then
    FreeAndNil(FListaRegistrosRelatorio);

  TPagarMeFuncoes.FreeAndNilStringLists(lstDtaCad);

  inherited;
end;

procedure TConciliaRecebiveisMkt.GravarRegistroDeAjusteParaConciliacao(
  ARegistroRelatorio: TItensRelatorioCartoes;
  AGravaCampoValorBruto: Boolean = False; ADatasetSelecionado: TDataset = Nil);
var
  LCtaTaxaTransf : string;
begin
  If ARegistroRelatorio.Conciliado = 1 Then
    Exit;

  cdsBaiCar.Last;
  cdsBaiCar.Append;
  cdsBaiCar.FieldByName('AUTOINC').AsString     := VS_FuncoesExternas.fIRetEmpresaLogada +
                                                   TPagarMeFuncoes.fStrZero(ARegistroRelatorio.CodigoAutorizacao, 10) +
                                                   TPagarMeFuncoes.fRetSomenteNumeros(ARegistroRelatorio.Parcela) +
                                                   VS_FuncoesExternas.fIRetEmpresaLogada;

  cdsBaiCar.FieldByName('NRODUP').AsString      := TPagarMeFuncoes.fStrZero(ARegistroRelatorio.CodigoAutorizacao, 06);
  cdsBaiCar.FieldByName('PARDUP').AsString      := TPagarMeFuncoes.fGetLetraAlfa(StrtoInt(ARegistroRelatorio.Parcela));
  cdsBaiCar.FieldByName('MCA_NUMDUP').AsString  := cdsBaiCar.FieldByName('NRODUP').AsString +
                                                   cdsBaiCar.FieldByName('PARDUP').AsString;
  cdsBaiCar.FieldByName('EMPLOC').AsString      := ARegistroRelatorio.CodigoEmpresa;
  cdsBaiCar.FieldByName('MCA_CODEMP').AsString  := ARegistroRelatorio.CodigoEmpresa;
  cdsBaiCar.FieldByName('MCA_EMPRCX').AsString  := ARegistroRelatorio.CodigoEmpresa;
  cdsBaiCar.FieldByName('MCA_DTAVEN').AsDateTime := ARegistroRelatorio.DataPagamento;
  cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat   := ARegistroRelatorio.ValorLiquido;
  cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat   := 0.00;

  cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat   := ARegistroRelatorio.ValorLiquido;
  If AGravaCampoValorBruto Then
    cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat   := ARegistroRelatorio.ValorBruto;

  cdsBaiCar.FieldByName('MCA_VALORI').AsFloat   := ARegistroRelatorio.ValorLiquido;
  cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat   := ARegistroRelatorio.ValorLiquido;
  cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat   := 0.000000;
  cdsBaiCar.FieldByName('MCA_CODCLI').AsString  := '00000000';
  cdsBaiCar.FieldByName('CLI_NOMCLI').AsString  := ARegistroRelatorio.DescricaoAjuste;
  cdsBaiCar.FieldByName('MCA_DTACAD').AsDateTime := ARegistroRelatorio.DataVenda;
  cdsBaiCar.FieldByName('MCA_NUMCCD').AsString  := ARegistroRelatorio.CodigoAutorizacao;
  cdsBaiCar.FieldByName('MCA_RESCAI').AsInteger := 0;
  cdsBaiCar.FieldByName('MCA_CODCAR').Clear;
  cdsBaiCar.FieldByName('CAR_DESCAR').Clear;

  cdsBaiCar.FieldByName('MCA_NUMNSU').AsString  := ARegistroRelatorio.NumeroNSU;

  cdsBaiCar.FieldByName('MCA_DTACUP').AsDateTime := ARegistroRelatorio.DataVenda;
  cdsBaiCar.FieldByName('MCA_MARDES').AsString  := 'M';
  cdsBaiCar.FieldByName('MCA_VALREC').AsFloat   := ARegistroRelatorio.ValorLiquido;
  cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime := ARegistroRelatorio.DataPagamento;
  cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_AJUTOT').AsFloat   := ARegistroRelatorio.ValorLiquido;
  cdsBaiCar.FieldByName('MCA_AJUSEL').AsFloat   := ARegistroRelatorio.ValorLiquido;
  cdsBaiCar.FieldByName('MCA_ZERATX').AsString  := 'S';
  cdsBaiCar.FieldByName('MCA_ANTECI').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_SELQTD').AsInteger := 0;
  cdsBaiCar.FieldByName('MCA_AJUSTE').AsString  := 'S';
  cdsBaiCar.FieldByName('MCA_ESTABE').AsString  := ARegistroRelatorio.CodigoEstabelecimento;

  cdsBaiCar.FieldByName('CAR_PORBAI').AsString  := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPortadorAjustes, ARegistroRelatorio.CodigoEmpresa);
  
  cdsBaiCar.FieldByName('CAR_PORTAX').Clear;
  cdsBaiCar.FieldByName('CAR_PORBAD').Clear;

  cdsBaiCar.FieldByName('CAR_CTATAX').Clear;
  cdsBaiCar.FieldByName('CAR_CTABAD').Clear;
  cdsBaiCar.FieldByName('CAR_EVEDEB').Clear;

  If ARegistroRelatorio.DescricaoAjuste.Equals(DESCRICAO_TAXA_TRANSFERENCIA_PAGARME) Then
  Begin
    LCtaTaxaTransf := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPlanoDeContasTaxaTransferencia, ARegistroRelatorio.CodigoEmpresa);
    If Not LCtaTaxaTransf.IsEmpty Then
      cdsBaiCar.FieldByName('CAR_CTABAI').AsString := LCtaTaxaTransf
    Else
      cdsBaiCar.FieldByName('CAR_CTABAI').AsString := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPlanoDeContasAjustes, ARegistroRelatorio.CodigoEmpresa);
  End
  Else
    cdsBaiCar.FieldByName('CAR_CTABAI').AsString := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPlanoDeContasAjustes, ARegistroRelatorio.CodigoEmpresa);

  cdsBaiCar.FieldByName('MCA_EVECAN').AsString := fRetornaDadosDeBaixaDosAjustes(objConcil.strEventoCancelamentoAjuste, ARegistroRelatorio.CodigoEmpresa);
  cdsBaiCar.FieldByName('CAR_FORTAX').AsString := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgFornecedorAjustes,       ARegistroRelatorio.CodigoEmpresa);
  cdsBaiCar.FieldByName('FOR_NOMFOR').AsString  := TPagarMeFuncoes.IIF(cdsBaiCar.FieldByName('CAR_FORTAX').AsString.IsEmpty, '', TPagarMeFuncoes.RetornaNomeFornecedor(cdsBaiCar.FieldByName('CAR_FORTAX').AsString));

  cdsBaiCar.FieldByName('SIT_CAD').AsString     := 'COMPLETO';
  If ARegistroRelatorio.RegistroIncompleto.Equals('S') Then
    cdsBaiCar.FieldByName('SIT_CAD').AsString     := 'INCOMPLETO';

  cdsBaiCar.FieldByName('HISTORICO_BAIXA').Clear;

  cdsBaiCar.FieldByName('NEGOCIACAO').AsString  := 'N';

  cdsBaicar.FieldByName('TABELA_UPDATE').AsString := 'PGM_PMTRAN';
  If Assigned(ADatasetSelecionado) Then
  Begin
    cdsBaicar.FieldByName('TABELA_UPDATE').AsString := ADatasetSelecionado.FieldByName('NOME_TABELA').AsString;
    cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString  := fRetornaChaveConciliacao(ADatasetSelecionado);
  End
  Else If Assigned(cdsAjustes) Then
  Begin
    cdsBaicar.FieldByName('TABELA_UPDATE').AsString := cdsAjustes.FieldByName('NOME_TABELA').AsString;
    cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString  := fRetornaChaveConciliacao(cdsAjustes);
  End;

  cdsBaiCar.FieldByName('REGISTROTRANSFERENCIA').AsString := 'N';
  If ARegistroRelatorio.RegistroTransferencia.Equals('S') Then
  Begin
    cdsBaiCar.FieldByName('PORTADORTRANSFERENCIA').AsString := ARegistroRelatorio.PortadorTransferencia;
    cdsBaiCar.FieldByName('PLANODECONTASTRANSFERENCIA').AsString := ARegistroRelatorio.PlanoContasTransferenciaCredito;
    cdsBaiCar.FieldByName('PLANODECONTASTRANSFERENCIALANCDEB').AsString := ARegistroRelatorio.PlanoContasTransferenciaDebito;
    cdsBaiCar.FieldByName('CENTRODECUSTOSTRANSFERENCIA').AsString := ARegistroRelatorio.CentroCustosTransferencia;
    cdsBaiCar.FieldByName('REGISTROTRANSFERENCIA').AsString := 'S';
  End;

  cdsBaiCar.Post;

  FAjustesJaConciliados := False;
end;

function TConciliaRecebiveisMkt.GravarRegistrosRelatorio(prgStatus: TcxProgressBar): Boolean;
  Var
    LInserir: TUniQuery;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  Result := False;

  If FListaRegistrosRelatorio.Count = 0 Then
    Exit(True);

  LInserir := Nil;

  prgStatus.Properties.Max := FListaRegistrosRelatorio.Count;
  prgStatus.Position := 0;

  Try
    VS_FuncoesExternas.fIStartTransaction;
    Try
      LInserir := VS_FuncoesExternas.fICriaQuery;
      LInserir.SQL.Text := 'SELECT * FROM REL_CONITE WHERE FALSE';
      LInserir.Open;

      For LRegistroRelatorio In FListaRegistrosRelatorio Do
      Begin
        LInserir.Append;

        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_RELINC', FRelatorioConciliacao.AutoIncremRelatorio);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_NOMARQ', LRegistroRelatorio.NomeArquivo);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODEST', LRegistroRelatorio.CodigoEstabelecimento);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODEMP', LRegistroRelatorio.CodigoEmpresa);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESCRI', LRegistroRelatorio.Descricao);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMNSU', LRegistroRelatorio.NumeroNSU);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODAUT', LRegistroRelatorio.CodigoAutorizacao);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_PARCEL', LRegistroRelatorio.Parcela);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_TOTPAR', LRegistroRelatorio.TotalParcelas);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAPAG', LRegistroRelatorio.DataPagamento);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTA_CV', LRegistroRelatorio.DataVenda);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAVEN', LRegistroRelatorio.DataVencimento);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_RESVEN', LRegistroRelatorio.ResumoVenda);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODBAN', LRegistroRelatorio.CodigoBandeira);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESBAN', LRegistroRelatorio.DescricaoBandeira);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_SEQMCA', LRegistroRelatorio.AutoIncremMovCar);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMCAR', LRegistroRelatorio.NumeroCartao);

        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALBRU', LRegistroRelatorio.ValorBruto);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALLIQ', LRegistroRelatorio.ValorLiquido);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALTAX', LRegistroRelatorio.ValorTaxas);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALFRE', LRegistroRelatorio.ValorFrete);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALAJU', LRegistroRelatorio.ValorAjustes);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALCUP', LRegistroRelatorio.ValorCupom);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_PERTAX', LRegistroRelatorio.PercentualTaxa);

        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPCAR', LRegistroRelatorio.TipoCartao);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPREG', LRegistroRelatorio.TipoDoRegistro);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_SOMTOT', LRegistroRelatorio.SomarNoTotal);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_INCOMP', LRegistroRelatorio.RegistroIncompleto);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_PORDEB', LRegistroRelatorio.PortadorDebito);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_PORCRE', LRegistroRelatorio.PortadorCredito);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_REGNEG', LRegistroRelatorio.RegistroNegociacao);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMNEG', LRegistroRelatorio.NumeroNegociacao);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESAJU', LRegistroRelatorio.DescricaoAjuste);
        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_NOMREC', LRegistroRelatorio.NomeRecebedor);

        TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_CONCIL', LRegistroRelatorio.Conciliado);

        LInserir.Post;

        If Not FPossuiInconsistencia Then
          FPossuiInconsistencia := MatchStr(LRegistroRelatorio.TipoDoRegistro, ['INCONSISTENCIA', 'AJUSTE']);

        TPagarMeFuncoes.pStepStatusGravacao(prgStatus);
      End;

      VS_FuncoesExternas.fICommit;

      Result := True;
    Except
      On E: Exception Do
      Begin
        VS_FuncoesExternas.fIRollback;

        Raise;
      End;
    End;
  Finally
    TPagarMeFuncoes.FreeAndNilDatasets(LInserir);
  End;
end;

procedure TConciliaRecebiveisMkt.MarcarCartaoEncontradoAPI(AValorBruto, AValorRecebido: Double;
  ARegistroAntecipado: Boolean; var ARegistroRelatorio: TItensRelatorioCartoes; AChaveConciliacao: String;
  ADatasetRegistro: TDataset; ATaxaAntecipacao: Double);
  Var
    LValStaOriginal: Double;

    LBaixaZerada: Boolean;
begin
  If CartaoRecebidoPeloCaixaENaoTransferido(cdsBaiCar) Then
  Begin
    FTextoInconsistencia := 'Registros recebidos pelo Resumo de Caixa não transferidos';
    ARegistroRelatorio.InconsistenciaConciliada := 'N';
    Exit;
  End;

  cdsBaiCar.Edit;

  If Not TPagarMeFuncoes.fEmptyStr(AChaveConciliacao) Then
  Begin
    cdsBaiCar.FieldByName('MCA_ESTABE').AsString := '0';
    cdsBaiCar.FieldByName('MCA_CHACON').AsString := AChaveConciliacao;
  End;

  cdsBaiCar.FieldByName('MCA_MARDES').AsString := 'M';

  LValStaOriginal := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
  If cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat <> AValorBruto Then
  Begin
    cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat := AValorBruto;
    cdsBaiCar.FieldByName('ALTERAR_BRUTO').AsString := 'S';
  End;

  ARegistroRelatorio.Descricao := EmptyStr;
  ARegistroRelatorio.TipoDoRegistro := 'PAGAMENTO';

  cdsBaiCar.FieldByName('MCA_VALREC').AsFloat := TPagarMeFuncoes.fFormataFloat(AValorRecebido, 2);

  cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime := ADatasetRegistro.FieldByName('PGM_DTAPAG').AsDateTime;
  cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat    := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;

  cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat := TPagarMeFuncoes.fFormataFloat(ADatasetRegistro.FieldByName('VALTAX').AsFloat, 2);

  cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat    := (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat /
                                                     cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100;

  If ARegistroAntecipado Then
  Begin
    cdsBaiCar.FieldByName('MCA_ANT_SN').AsString := 'S';
    cdsBaiCar.FieldByName('MCA_ANTECI').AsFloat  := TPagarMeFuncoes.fFormataFloat(AValorRecebido, 2);
    cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat  := ATaxaAntecipacao;
    If cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat <= 0 Then
      cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat := 0;
  End;

  cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := TPagarMeFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat, 2);
  cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat  := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
  cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat  := 1;
  cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat  := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;

  cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString := fRetornaChaveConciliacao(ADatasetRegistro);
  cdsBaicar.FieldByName('TABELA_UPDATE').AsString := 'PGM_PMRECE';

  cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat := 0;

  cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat := 0;

  cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat := 0;

  LBaixaZerada := TPagarMeFuncoes.fFormataFloat(AValorRecebido, 2) <= 0;
 
  If LBaixaZerada Then
  Begin
    cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat := LValStaOriginal;
    cdsBaiCar.FieldByName('MCA_VALREC').AsFloat := AValorRecebido;
    cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat := 0;
    cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat := 0;
    cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
    cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := 0;
    cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat  := 0;
    cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat  := 0;
    cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat  := 0;
    cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat := 0;
    cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat := 0;

    If TPagarMeFuncoes.fFormataFloat(AValorRecebido, 2) <= 0 Then
    Begin
      cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat := 0;
      cdsBaiCar.FieldByName('MCA_VALREC').AsFloat := 0;
    End;
  End;

  ARegistroRelatorio.AutoIncremMovCar := cdsBaiCar.FieldByName('AUTOINC').AsString;
  
  cdsBaiCar.Post;
end;

function TConciliaRecebiveisMkt.fRetNomBandeira(strNumCar: String;
  ATipoCartao: String = ''): String;
begin

  If Not TPagarMeFuncoes.fEmptyStr(FBandeiraCartao) Then
    Exit(FBandeiraCartao);

  //Visa
  If (LeftStr(strNumCar, 1) = '4') And
     (Length(strNumCar) In [13, 16, 19]) Then
    Result := 'VISA'
  Else
  //Master
  If ((Pos(LeftStr(strNumCar, 2), '51_52_53_54_55_') > 0) Or
      (Pos(LeftStr(strNumCar, 4), '2221_2720_2307_') > 0) And
      (Length(strNumCar) = 16)) Or
     (Pos(LeftStr(strNumCar, 4), '6036_') > 0) Then
  Begin
    Result := 'MASTERCARD';

    If ATipoCartao = 'DÉBITO' Then
      Result := 'MAESTRO';
  End
  Else
  //Banricompras
  If (LeftStr(strNumCar, 6) = '639664') Then
    Result := 'BANRICOMPAS'
  Else
  //VerdeCard
  If (LeftStr(strNumCar, 6) = '627894') Then
    Result := 'VERDECARD'
  Else
  //BanriCard
  If (LeftStr(strNumCar, 6) = '608718') Then
    Result := 'BANRICARD'
  else
  //Maestro
  If ((Pos(LeftStr(strNumCar, 2), '50_56_57_58_') > 0) Or (LeftStr(strNumCar, 1) = '6')) And
     (Length(strNumCar) = 16) Then
    Result := 'MAESTRO'
  Else
  //American Express
  If (Pos(LeftStr(strNumCar, 2), '34_37_') > 0) Then
    Result := 'AMERICAN EXPRESS'
  Else
  //Diners
  If (Pos(LeftStr(strNumCar, 3), '300_301_302_303_304_305_309_') > 0) Or
     (Pos(LeftStr(strNumCar, 2), '36_38_39') > 0) And
     (Length(strNumCar) In [14, 16, 17, 18, 19]) Then
    Result := 'DINERS'
  Else
  //Elo
  If (Pos(LeftStr(strNumCar, 4), '4011_4576_5067_') > 0) Or
     (Pos(LeftStr(strNumCar, 6), '636368_438935_504175_451416_636297_506699_') > 0) Then
    Result := 'ELO'
  Else
  //Hipercard
  If (Pos(LeftStr(strNumCar, 4), '3841_6062_') > 0) Then
    Result := 'HIPERCARD'
  Else
  //Aura
  If (LeftStr(strNumCar, 2) = '50') Then
    Result := 'AURA'
  Else
  //BANESCARD
  If (Pos('585988',strNumCar) > 0) Then
    Result := 'BANESCARD'

  //Não conhecido
  Else
  Begin
    Result := 'OUTROS';

    If Pos('PIX', strNumCar) > 0 Then
      Result := 'PIX'
    Else If Pos('BOLETO', strNumCar) > 0 Then
      Result := 'BOLETO';

  End;
end;

function TConciliaRecebiveisMkt.fRetornaChaveConciliacao(cdsDataset: TDataset;
  ARetornaSemAjustes: Boolean = False): String;
  Var
    stlCampos: TStringList;
    strCampo : String;
begin
  Result := '';

  If TPagarMeFuncoes.fEmptyStr(objConcil.strChavePrimaria) Then
    Exit;

  If Not Assigned(cdsDataset) Then
    Exit;

  If cdsDataset.IsEmpty Then
    Exit;

  stlCampos := Nil;
  Try
    stlCampos := TStringList.Create;
    stlCampos.Delimiter     := ',';
    stlCampos.DelimitedText := objConcil.strChavePrimaria;

    For strCampo in stlCampos Do
    Begin
      If ARetornaSemAjustes Then
      Begin
        Result := Result + cdsDataset.FieldByName(strCampo).AsString + '|';

        Continue;
      End;

      If cdsDataset.FieldByName(strCampo).DataType in [ftString, ftBlob, ftMemo] Then
        Result := Result + cdsDataset.FieldByName(strCampo).AsString.QuotedString + '|'
      Else if cdsDataset.FieldByName(strCampo).DataType in [ftDate] Then
        Result := Result + FormatDateTime('yyyy/mm/dd', cdsDataset.FieldByName(strCampo).AsDateTime).QuotedString + '|'
      Else if cdsDataset.FieldByName(strCampo).DataType in [ftDateTime] Then
        Result := Result + FormatDateTime('yyyy/mm/dd hh:mm:ss', cdsDataset.FieldByName(strCampo).AsDateTime).QuotedString + '|'
      Else if cdsDataset.FieldByName(strCampo).DataType in [ftFloat] Then
        Result := Result + StringReplace(StringReplace(cdsDataset.FieldByName(strCampo).AsString, '.', EmptyStr, [rfReplaceAll]), ',', '.', [rfReplaceAll]) + '|'
      Else
        Result := Result + cdsDataset.FieldByName(strCampo).AsString + '|';
    End;

    Result := LeftStr(Result, Result.Length - 1);
  Finally
    TPagarMeFuncoes.FreeAndNilStringLists(stlCampos);
  End;
end;

function TConciliaRecebiveisMkt.fRetornaDadosDeBaixaDosAjustes(strConfiguracao, strEmpresaConfiguracao: String): String;
begin
  Result := '';

  If Not TPagarMeFuncoes.fEmptyStr(strEmpresaConfiguracao) Then
    Result := VS_FuncoesExternas.fICfgSis(strConfiguracao, varString, strEmpresaConfiguracao);
end;

procedure TConciliaRecebiveisMkt.pAcertaDadosDeBaixaOtimizadaPorEmpresa;
  Var
    qryConsulta: TUniQuery;

    strCodigoCartao,
    strIndiceAnterior: String;

    blnIncompleto,
    blnCentoDeCustoObrigatorio,
    LEmpresaLocalizada: Boolean;
begin
  If cdsBaiCar.IsEmpty Then
    Exit;

  blnCentoDeCustoObrigatorio := VS_FuncoesExternas.fICfgSis('CTPOBE', varBoolean);

  strCodigoCartao := '';

  Try
    qryConsulta := VS_FuncoesExternas.fICriaQuery;

    qryConsulta.SQL.Text := 'SELECT * FROM CONPOR WHERE CON_CODCAR=:CODCAR ORDER BY CON_CODEMP';

    strIndiceAnterior := cdsBaiCar.IndexFieldNames;
    cdsBaiCar.IndexFieldNames := 'MCA_CODCAR';

    cdsBaiCar.First;
    While Not cdsBaiCar.Eof Do
    Begin
      Application.ProcessMessages;

      If Not cdsBaicar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
      Begin
        cdsBaicar.Next;
        Continue;
      End;

      If cdsBaicar.FieldByName('MCA_CODCAR').AsString <> strCodigoCartao Then
      Begin
        strCodigoCartao := cdsBaicar.FieldByName('MCA_CODCAR').AsString;

        qryConsulta.Close;
        qryConsulta.ParamByName('CODCAR').AsString := strCodigoCartao;
        qryConsulta.Open;
      End;

      If (Not qryConsulta.IsEmpty) Then
      Begin
        If objConcil.TabelaConciliacao.Equals('RED_APPGTO') and (objConcil.CodigoEmpresaFixaParaBaixa <> '') Then
          LEmpresaLocalizada := qryConsulta.Locate('CON_CODEMP', objConcil.CodigoEmpresaFixaParaBaixa,[])
        Else
          LEmpresaLocalizada := qryConsulta.Locate('CON_CODEMP', cdsBaicar.FieldByName('MCA_CODEMP').AsString,[]);

        If (LEmpresaLocalizada) Then
        Begin
          cdsBaiCar.Edit;

          If Not (Assigned(cdsBaiCar.FindField('PORTADOR_GRAVAME')) And
                  Not cdsBaiCar.FieldByName('PORTADOR_GRAVAME').AsString.IsEmpty) Then
          Begin
            cdsBaiCar.FieldByName('CAR_PORBAI').AsString := qryConsulta.FieldByName('CON_PORCRE').AsString;
            cdsBaiCar.FieldByName('CAR_PORTAX').AsString := qryConsulta.FieldByName('CON_PORTAX').AsString;
          End;

          cdsBaiCar.FieldByName('CAR_PORBAD').AsString := qryConsulta.FieldByName('CON_PORDEB').AsString;
          cdsBaiCar.FieldByName('CAR_CTABAI').AsString := qryConsulta.FieldByName('CON_CTACRE').AsString;
          cdsBaiCar.FieldByName('CAR_CTATAX').AsString := qryConsulta.FieldByName('CON_CTATAX').AsString;
          cdsBaiCar.FieldByName('CAR_CTABAD').AsString := qryConsulta.FieldByName('CON_CTADEB').AsString;
          cdsBaiCar.FieldByName('CAR_CTAANT').AsString := qryConsulta.FieldByName('CON_CTAANT').AsString;
          cdsBaiCar.FieldByName('CAR_EVECRE').AsString := qryConsulta.FieldByName('CON_EVECRE').AsString;
          cdsBaiCar.FieldByName('CAR_EVETAX').AsString := qryConsulta.FieldByName('CON_EVETAX').AsString;
          cdsBaiCar.FieldByName('CAR_EVEDEB').AsString := qryConsulta.FieldByName('CON_EVEDEB').AsString;
          cdsBaiCar.FieldByName('CAR_FORTAX').AsString := qryConsulta.FieldByName('CON_FORTAX').AsString;
          cdsBaiCar.FieldByName('CAR_CTACUP').AsString := qryConsulta.FieldByName('CON_CTACUP').AsString;
          cdsBaiCar.FieldByName('FOR_NOMFOR').AsString := TPagarMeFuncoes.RetornaNomeFornecedor(qryConsulta.FieldByName('CON_FORTAX').AsString);

          cdsBaiCar.FieldByName('DESC_EVE_CREDITO').AsString := TPagarMeFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVECRE').AsString);
          cdsBaiCar.FieldByName('DESC_EVE_TAXA').AsString    := TPagarMeFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVETAX').AsString);
          cdsBaiCar.FieldByName('DESC_EVE_DEBITO').AsString  := TPagarMeFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVEDEB').AsString);

          cdsBaiCAr.FieldByName('SIT_CAD').AsString := 'COMPLETO';
          blnIncompleto := (cdsBaiCAr.FieldByName('CAR_PORBAI').AsString.IsEmpty) OR
                           (cdsBaiCAr.FieldByName('CAR_CTABAI').AsString.IsEmpty) OR
                           (cdsBaiCAr.FieldByName('CAR_PORTAX').AsString.IsEmpty) OR
                           (cdsBaiCAr.FieldByName('CAR_CTATAX').AsString.IsEmpty) OR
                           (cdsBaiCAr.FieldByName('CAR_FORTAX').AsString.IsEmpty);

          If (blnCentoDeCustoObrigatorio) And (Not blnIncompleto)  then
            blnIncompleto :=  (cdsBaiCAr.FieldByName('CAR_EVECRE').AsString.IsEmpty) OR
                              (cdsBaiCAr.FieldByName('CAR_EVETAX').AsString.IsEmpty) OR
                              ((Not cdsBaiCAr.FieldByName('CAR_PORBAD').AsString.IsEmpty) AND
                               (cdsBaiCAr.FieldByName('CAR_EVEDEB').AsString.IsEmpty));

          If blnIncompleto Then
            cdsBaiCAr.FieldByName('SIT_CAD').AsString := 'INCOMPLETO';

          cdsBaicar.Post;
        End;
      End;
      cdsBaiCar.Next;
    End;
  Finally
    cdsBaiCar.IndexFieldNames := strIndiceAnterior;

    TPagarMeFuncoes.FreeAndNilDatasets(qryConsulta);
  End;
end;

function TConciliaRecebiveisMkt.fBetween(fltValor, fltMinimo,
  fltMaximo: Double): Boolean;
begin
  Result := (fltValor >= fltMinimo) And
            (fltValor <= fltMaximo);
end;

function TConciliaRecebiveisMkt.fConciliaCartoes(prgStatus: TcxProgressBar): Boolean;
begin
  Result := False;
end;

procedure TConciliaRecebiveisMkt.RemoverRelatorioConciliacao(AUnitRemocao: String);
  Var
    LConsulta: TUniQuery;
begin
  If Not Assigned(FRelatorioConciliacao) Then
    Exit;

  LConsulta := Nil;

  VS_FuncoesExternas.fIStartTransaction;
  Try
    Try
      LConsulta := VS_FuncoesExternas.fICriaQuery;
      LConsulta.SQL.Text := 'SELECT * FROM REL_CONCAR WHERE AUTOINCREM=' + FRelatorioConciliacao.AutoIncremRelatorio;
      LConsulta.Open;

      TPagarMeFuncoes.GravaTabelaDelecao(AUnitRemocao,
                                            'REL_CONCAR',
                                             LConsulta);

      TPagarMeFuncoes.ExecutaSQL('DELETE FROM REL_CONCAR WHERE AUTOINCREM=' + FRelatorioConciliacao.AutoIncremRelatorio);

      VS_FuncoesExternas.fICommit;
    Finally
      TPagarMeFuncoes.FreeAndNilDatasets(LConsulta);
    End;
  Except
    On E: Exception Do
    Begin
      VS_FuncoesExternas.fIRollBack;

      VS_FuncoesExternas.pIMensagensErro('Ocorreu um erro ao remover o relatório de conciliação' + #13 +
                                         'Erro gerado: ' + E.Message, '[TConciliacaoCartoes.RemoverRelatorioConciliacao]');
    End;
  End;
end;

function TConciliaRecebiveisMkt.RetornaFiltrosDigitados: String;
  Var
    LStringList: TStringList;
begin
  Result := 'Data Inicial: ' + strDtaIni + #13 +
            'Data Final: ' + strDtaFim + #13;

  LStringList := Nil;
  Try
    If Length(FEmpresasPeriodo) > 0 Then
    Begin
      LStringList := TPagarMeFuncoes.ConverterArrayConsultaParaStringList(FEmpresasPeriodo);
      Result := Result + 'Empresas: ' + LStringList.Text;
    End;
  Finally
    TPagarMeFuncoes.FreeAndNilStringLists(LStringList);
  End;
end;

function TConciliaRecebiveisMkt.RetornaParcelaCartao(AParcelaAtual,
  ATotalParcelas: String): String;
  Var
    LNumero: Integer;
begin
  If Not TryStrToInt(AParcelaAtual, LNumero) Then
    Exit('01/01');

  Result := TPagarMeFuncoes.fStrZero(LNumero.ToString, 2) + '/';

  If Not TryStrToInt(ATotalParcelas, LNumero) Then
    Exit(Result + LeftStr(Result, 2));

  Result := Result + TPagarMeFuncoes.fStrZero(LNumero.ToString, 2);
end;

function TConciliaRecebiveisMkt.RetornaTaxaParaValidacao: Double;
begin
  Result := cdsBaiCar.FieldByName('CAR_PERDES').AsFloat;

  If FConfiguracaoTaxaAdministrativa.Equals('2') Then
    Result := cdsBaiCar.FieldByName('TAXA_ADM_ORIGINAL').AsFloat;

end;

function TConciliaRecebiveisMkt.RetornaTextoInconsistenciaAtualizado(
  ATextoInconsistencia: String): String;
begin
  Result := ATextoInconsistencia;

  If Result.IsEmpty Then
    Exit;

  If Result.Equals('Vendas já foram baixadas') Then
  Begin
    If Not blnAutomatica Then
      Exit(Result + ' manualmente');

    Result := Result + ' através da baixa de recebíveis';
  End;
end;

procedure TConciliaRecebiveisMkt.RetornaTotaisValoresQueSeraoBaixados(
  out AQuantidadeBaixados: Integer; out ABrutoBaixados,
  ALiquidoBaixados: Double);
  Var
    LRegistros: TUniCLientDataSet;
begin
  AQuantidadeBaixados := 0;
  ABrutoBaixados := 0.00;
  ALiquidoBaixados := 0.00;

  LRegistros := Nil;
  Try
    LRegistros := TPagarMeFuncoes.CriarClientDataSet(cdsBaiCar);
    LRegistros.Filter := 'MCA_MARDES=''M'' AND REGISTROTRANSFERENCIA=''N'' ';
    LRegistros.Filtered := True;

    LRegistros.First;
    While Not LRegistros.Eof Do
    Begin
      Inc(AQuantidadeBaixados);

      ABrutoBaixados := ABrutoBaixados + TPagarMeFuncoes.fFormataFloat(LRegistros.FieldByName('MCA_VALSTA').AsFloat, 2);
      ALiquidoBaixados := ALiquidoBaixados + TPagarMeFuncoes.fFormataFloat(LRegistros.FieldByName('MCA_VALREC').AsFloat, 2);

      LRegistros.Next;
    End;
  Finally
    TPagarMeFuncoes.FreeAndNilDatasets(LRegistros);
  End;
end;

function TConciliaRecebiveisMkt.RetornaValorTolerancia(ACodEmp: String;ADefault: Double): Double;
begin
  If TPagarMeFuncoes.fEmptyStr(objConcil.CfgVlrTolerancia) Then
    Exit(ADefault);

  If TPagarMeFuncoes.fEmptyStr(ACodEmp) Then
    ACodEmp :=  VS_FuncoesExternas.fIRetEmpresaLogada;

  Result := VS_FuncoesExternas.fICfgSis(objConcil.CfgVlrTolerancia,varCurrency,ACodEmp);
end;

function TConciliaRecebiveisMkt.PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(AValorBruto: Double;
                                                                               ARegistro: TDataSet;
                                                                               APercentual: Boolean = True): Boolean;
  Var
    LDiferenca: Double;
Begin
  LDiferenca := (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat - cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat);

  if APercentual then
    LDiferenca := LDiferenca -
                  (TPagarMeFuncoes.fFormataFloat(AValorBruto * (RetornaTaxaParaValidacao / 100), 2))
  else
    LDiferenca := LDiferenca - RetornaTaxaParaValidacao;

  Result := Not fBetween(LDiferenca, -0.039999, 0.0399999);
End;

{ TRelatorioConciliacao }

constructor TRelatorioConciliacao.Create(ACodigoOperador,
  AOperadora, ATipoRelatorio, AFiltrosRelatorio: String; ADataRelatorio,
  AHoraRelatorio: TDateTime);
  Var
    LInserir: TUniQuery;
begin
  LInserir := Nil;
  Try
    LInserir := VS_FuncoesExternas.fICriaQuery;
    LInserir.SQL.Text := 'SELECT * FROM REL_CONCAR WHERE FALSE';
    LInserir.Open;
    LInserir.Append;

    TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_CHAVE_', AOperadora.ToUpperInvariant + '-' +
                                                                     FormatDateTime('yyyymmdd', ADataRelatorio) + '_' +
                                                                     FormatDateTime('hhmmss', AHoraRelatorio) + '-' +
                                                                     ACodigoOperador + '-' + ATipoRelatorio.ToUpperInvariant);
    TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAREL', ADataRelatorio);
    TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_HORREL', AHoraRelatorio);
    TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODOPE', ACodigoOperador);
    TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_OPERAD', AOperadora);
    TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPREL', ATipoRelatorio);
    TPagarMeFuncoes.SetaValorCampoDataset(LInserir, 'REL_FILREL', AFiltrosRelatorio + #13 +
                                                                  'Versão Lib: ' + VERSAO_LIB + #13 +
                                                                  'Data Commit: ' + DATA_LIB);

    LInserir.Post;

    Self.AutoIncremRelatorio := LInserir.FieldByName('AUTOINCREM').Value;
    Self.ChaveRelatorio := LInserir.FieldByName('REL_CHAVE_').Value;
    Self.DataRelatorio := ADataRelatorio;
    Self.HoraRelatorio := AHoraRelatorio;
    Self.CodigoOperador := ACodigoOperador;
    Self.Operadora := AOperadora;
    Self.TipoRelatorio := ATipoRelatorio;
    Self.FiltrosRelatorio := AFiltrosRelatorio;
  Finally
    TPagarMeFuncoes.FreeAndNilDatasets(LInserir);
  End;
end;

{ TItensRelatorioCartoes }

constructor TItensRelatorioCartoes.Create;
begin
  ValorBruto := 0;
  ValorLiquido := 0;
  ValorTaxas := 0;
  ValorFrete := 0;
  ValorAjustes := 0;
  ValorCupom := 0;

  TipoDoRegistro := 'PAGAMENTO';
  SomarNoTotal := 'S';
  RegistroIncompleto := 'N';
  RegistroNegociacao := 'N';
  InconsistenciaConciliada := 'N';

  Conciliado := 0;
end;

end.
