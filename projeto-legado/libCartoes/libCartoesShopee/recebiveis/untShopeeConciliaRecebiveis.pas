unit untShopeeConciliaRecebiveis;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, Vcl.Graphics, Vcl.Controls, System.Math,
     System.Generics.Collections,

     Uni, UniClientDataSet, cxProgressBar,

     untTShopeeFuncoes, untLibCartoesInterfacesTipos, untTLockLibCartoes;

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

    ChavePrimaria,

    AutoIncremMovCar: String;

    Conciliado: Integer;

    constructor Create;
  End;

  TListaRegistrosRelatorio = TObjectList<TItensRelatorioCartoes>;

type TConciliaRecebiveisMkt = class
  qryBaiCar: TUniQuery;
  cdsConCar,                             //DATASET DOS ARQUIVOS IMPORTADOS (EXCETO REDECARD)
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

  FFiltrosRelatorio: TFiltrosRelatorioBaixaCartoes;

  FListaRegistrosConciliar: TStringList;

  procedure MarcarCartaoEncontradoArquivo(AValorBruto,
                                          AValorRecebido: Double;
                                          var ARegistroRelatorio: TItensRelatorioCartoes;
                                          AChaveConciliacao: String;
                                          ADatasetRegistro: TDataset;
                                          AFreteMarketPlace: Double;
                                          AAjusteMarketPlace: Double;
                                          ATaxaMarketPlace: Double;
                                          ACupomMarketPlace: Double;
                                          AFreteMediacao: Double = 0;
                                          ADiferencaCupom: Double = 0);

  function CartaoRecebidoPeloCaixaENaoTransferido(ADataset: TDataset): Boolean;

  procedure pAcertaDadosDeBaixaOtimizadaPorEmpresa;

  procedure pCalculaPeriodoFiltro(strCampo: String);

  function fBuscaCartao(strNumCCD,
                        strNumNSU,
                        strCodEmp,
                        strParcel: String;
                        dtaDtaCup: TDateTime;
                        intConcil: Integer = 0;
                        blnPesquisaBaixado: Boolean = False;
                        AValorBruto: Double = 0.00): Boolean;

  function fBuscaCartaoBaixado(strNumCCD,
                               strNumNSU,
                               strCodEmp,
                               strParcel: String;
                               dtaDtaCup: TDateTime;
                               blnValidaValorBruto: Boolean = False;
                               AValorBruto: Double = 0.00): Boolean;

  function CarregaFiltrosParaBaixaRecebiveis(ADataInicial,
                                             ADataFinal: TDateTime;
                                             AArrayEmpresas: TConsultasArray): Boolean;

  function fRetNomBandeira(strNumCar: String;
                           ATipoCartao: String = ''): String;

  procedure RetornaTotaisValoresQueSeraoBaixados(out AQuantidadeBaixados: Integer;
                                                 out ABrutoBaixados: Double;
                                                 out ALiquidoBaixados: Double);

  function fRetPesqPonVen: String;
  function RetornaListaPVsParaFiltroLocate: String;
  function RetornaCodigosEstabelecimentosLocateIn(ARetornarIn: Boolean = True): String;

  procedure GravarRegistroDeAjusteParaConciliacao(ARegistroRelatorio: TItensRelatorioCartoes;
                                                  AGravaCampoValorBruto: Boolean = False;
                                                  ADatasetSelecionado: TDataset = Nil);

  function fBetween(fltValor, fltMinimo, fltMaximo: Double): Boolean;

  function fRetornaChaveConciliacao(cdsDataset: TDataset): String;
  function fRetornaChaveConciliacaoAjuste(cdsDataset: TDataset): String;

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
  protected
    dtaDtaIni,
    dtaDtaFim,
    dtaDtaPag  : TDate;
    lstDtaCad  : TStringList;
    arrPonVen,
    arrEmpresa: TConsultasArray;
    FTipoTransferenciaCaixa,
    strResumo,
    strDtaIni,
    strDtaFim,
    strCondicao: String;

    FAjustesJaConciliados  : Boolean;

    property CartoesConciliar: String read FCartoesConciliar write FCartoesConciliar;

    public
      property DataInicialConciliacao: TDate Read  dtaDtaIni;
      property DataFinalConciliacao  : TDate Read  dtaDtaFim;
      property ExibirCartoesPendente : Boolean Read FExibirCartoesPendente;

      property ListaRegistrosConciliar: TStringList read FListaRegistrosConciliar;

      property FiltrosRelatorio: TFiltrosRelatorioBaixaCartoes Read FFiltrosRelatorio;
end;

implementation
uses untTLibCartoesMovCar, untLibCartoesConstantes;

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

  SetLength(arrEmpresa, Length(AArrayEmpresas));
  FFiltrosRelatorio.ListaEmpresas := '';
  For LContadorItem := 0 To High(AArrayEmpresas) Do
  Begin
    arrEmpresa[LContadorItem].strCodigo := AArrayEmpresas[LContadorItem].strCodigo;

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
    TShopeeFuncoes.fMensagem('ATENÇÃO', 'O filtro para conciliação não pode ser maior que 365 dias (1 ano)!', ['&OK'])
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

  If TShopeeFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgPortadorAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If TShopeeFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgPlanoDeContasAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If TShopeeFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgFornecedorAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If Not FObrigatorioCentroDeCustos Then
    Exit('N');

  If TShopeeFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.strEventoCancelamentoAjuste, varString, ACodigoEmpresa)) Then
    Exit;

  Result := 'N';
end;

constructor TConciliaRecebiveisMkt.Create;
begin
  blnReabre  := False;

  FListaRegistrosRelatorio := TListaRegistrosRelatorio.Create;

  FAjustesJaConciliados := True;
  blnAutomatica  := False;

  FLancarAjustesACredito := TShopeeFuncoes.RetornaValorCfg('CFG_AJUCRE').Equals('S');
  FTemAjusteACredito := False;

  FConciliacaoComPixAtivado := False;
  LConciliacaoComBoletoAtivado := False;

  FCartoesConciliar := '';

  FLiberacaoTransferencia := TShopeeFuncoes.RetornaValorCfg('CFG_USAAUT').Equals('S');

  FFiltrarAutorizacaoNSU := False;

  objConcil.CodigoEmpresaFixaParaBaixa := '';

  FDataInicioPeriodo := 0;
  FDataFinalPeriodo := 0;

  SetLength(FEmpresasPeriodo, 0);

  FObrigatorioCentroDeCustos := VS_FuncoesExternas.fICfgSis('CTPOBE', varBoolean);

  FListaRegistrosConciliar := TStringList.Create;
end;

destructor TConciliaRecebiveisMkt.Destroy;
begin
  If Assigned(FRelatorioConciliacao) Then
  Begin
    If Not FRelatorioConciliacao.AutoIncremRelatorio.IsEmpty Then
      RemoverRelatorioConciliacao('frmShopeeBaixaRecebiveisMkt');
  End;

  TShopeeFuncoes.FreeAndNilDatasets(cdsAjustes);
  TShopeeFuncoes.FreeAndNilDatasets(cdsBaicar);
  TShopeeFuncoes.FreeAndNilDatasets(cdsBaixad);
  TShopeeFuncoes.FreeAndNilDatasets(cdsConCar);

  If Assigned(FRelatorioConciliacao) Then
    FreeAndNil(FRelatorioConciliacao);

  If Assigned(FListaRegistrosRelatorio) Then
    FreeAndNil(FListaRegistrosRelatorio);

  If Assigned(FListaRegistrosConciliar) Then
    FreeAndNil(FListaRegistrosConciliar);

  If Assigned(FobjLockEstabelecimento) Then
    FreeAndNil(FobjLockEstabelecimento);
  inherited;
end;

function TConciliaRecebiveisMkt.fRetPesqPonVen: String;
  Var
    LContador: Integer;
begin
  Result := '';

  If (High(arrEmpresa) < 0) Then
    Exit;

  Result := Result + ' AND (';

  If (High(arrEmpresa) >= 0) Then
  Begin
    Result := Result + ' EMP_CODEMP IN (';
    For LContador := 0 To High(arrEmpresa) Do
      Result := Result + '"' + arrEmpresa[LContador].strCodigo + '",';
    Result := Copy(Result, 1, Length(Result) - 1) + ') ';
  End;

  Result := Result + ') ';
end;

procedure TConciliaRecebiveisMkt.GravarRegistroDeAjusteParaConciliacao(
  ARegistroRelatorio: TItensRelatorioCartoes;
  AGravaCampoValorBruto: Boolean = False; ADatasetSelecionado: TDataset = Nil);
begin
  If ARegistroRelatorio.Conciliado = 1 Then
    Exit;

  cdsBaiCar.Last;
  cdsBaiCar.Append;
  cdsBaiCar.FieldByName('AUTOINC').AsString     := VS_FuncoesExternas.fIRetEmpresaLogada +
                                                   TShopeeFuncoes.fStrZero(ARegistroRelatorio.CodigoAutorizacao, 10) +
                                                   TShopeeFuncoes.fRetSomenteNumeros(ARegistroRelatorio.Parcela) +
                                                   VS_FuncoesExternas.fIRetEmpresaLogada;

  cdsBaiCar.FieldByName('NRODUP').AsString      := TShopeeFuncoes.fStrZero(ARegistroRelatorio.CodigoAutorizacao, 06);
  cdsBaiCar.FieldByName('PARDUP').AsString      := TShopeeFuncoes.fGetLetraAlfa(StrtoInt(ARegistroRelatorio.Parcela));
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
  cdsBaiCar.FieldByName('CAR_FORTAX').AsString  := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgFornecedorAjustes, ARegistroRelatorio.CodigoEmpresa);
  cdsBaiCar.FieldByName('FOR_NOMFOR').AsString  := TShopeeFuncoes.IIF(cdsBaiCar.FieldByName('CAR_FORTAX').AsString.IsEmpty, '', TShopeeFuncoes.RetornaNomeFornecedor(cdsBaiCar.FieldByName('CAR_FORTAX').AsString));
  cdsBaiCar.FieldByName('CAR_CTABAI').AsString  := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPlanoDeContasAjustes, ARegistroRelatorio.CodigoEmpresa);
  cdsBaiCar.FieldByName('CAR_CTATAX').Clear;
  cdsBaiCar.FieldByName('CAR_CTABAD').Clear;
  cdsBaiCar.FieldByName('CAR_EVEDEB').Clear;
  cdsBaiCar.FieldByName('MCA_EVECAN').AsString  := fRetornaDadosDeBaixaDosAjustes(objConcil.strEventoCancelamentoAjuste, ARegistroRelatorio.CodigoEmpresa);
  cdsBaiCar.FieldByName('SIT_CAD').AsString     := 'COMPLETO';
  If ARegistroRelatorio.RegistroIncompleto.Equals('S') Then
    cdsBaiCar.FieldByName('SIT_CAD').AsString     := 'INCOMPLETO';

  cdsBaiCar.FieldByName('HISTORICO_BAIXA').Clear;

  cdsBaiCar.FieldByName('NEGOCIACAO').AsString  := 'N';

  If Assigned(ADatasetSelecionado) Then
    cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString  := fRetornaChaveConciliacao(ADatasetSelecionado)
  Else If Assigned(cdsAjustes) Then
    cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString  := fRetornaChaveConciliacao(cdsAjustes);

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

  LInserir := VS_FuncoesExternas.fICriaQuery;

  prgStatus.Properties.Max := FListaRegistrosRelatorio.Count;
  prgStatus.Position := 0;

  Try
    VS_FuncoesExternas.fIStartTransaction;
    Try
      LInserir.SQL.Text := 'SELECT * FROM REL_CONITE WHERE FALSE';
      LInserir.Open;

      For LRegistroRelatorio In FListaRegistrosRelatorio Do
      Begin
        LInserir.Append;

        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_RELINC', FRelatorioConciliacao.AutoIncremRelatorio);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_NOMARQ', LRegistroRelatorio.NomeArquivo);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODEST', LRegistroRelatorio.CodigoEstabelecimento);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODEMP', LRegistroRelatorio.CodigoEmpresa);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESCRI', LRegistroRelatorio.Descricao);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMNSU', LRegistroRelatorio.NumeroNSU);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODAUT', LRegistroRelatorio.CodigoAutorizacao);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_PARCEL', LRegistroRelatorio.Parcela);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_TOTPAR', LRegistroRelatorio.TotalParcelas);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAPAG', LRegistroRelatorio.DataPagamento);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTA_CV', LRegistroRelatorio.DataVenda);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAVEN', LRegistroRelatorio.DataVencimento);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_RESVEN', LRegistroRelatorio.ResumoVenda);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODBAN', LRegistroRelatorio.CodigoBandeira);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESBAN', LRegistroRelatorio.DescricaoBandeira);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_SEQMCA', LRegistroRelatorio.AutoIncremMovCar);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMCAR', LRegistroRelatorio.NumeroCartao);

        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALBRU', LRegistroRelatorio.ValorBruto);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALLIQ', LRegistroRelatorio.ValorLiquido);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALTAX', LRegistroRelatorio.ValorTaxas);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALFRE', LRegistroRelatorio.ValorFrete);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALAJU', LRegistroRelatorio.ValorAjustes);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALCUP', LRegistroRelatorio.ValorCupom);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_PERTAX', LRegistroRelatorio.PercentualTaxa);

        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPCAR', LRegistroRelatorio.TipoCartao);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPREG', LRegistroRelatorio.TipoDoRegistro);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_SOMTOT', LRegistroRelatorio.SomarNoTotal);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_INCOMP', LRegistroRelatorio.RegistroIncompleto);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_PORDEB', LRegistroRelatorio.PortadorDebito);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_PORCRE', LRegistroRelatorio.PortadorCredito);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_REGNEG', LRegistroRelatorio.RegistroNegociacao);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMNEG', LRegistroRelatorio.NumeroNegociacao);
        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESAJU', LRegistroRelatorio.DescricaoAjuste);

        TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_CONCIL', LRegistroRelatorio.Conciliado);

        LInserir.Post;

        If Not FPossuiInconsistencia Then
          FPossuiInconsistencia := MatchStr(LRegistroRelatorio.TipoDoRegistro, ['INCONSISTENCIA', 'AJUSTE']);

        TShopeeFuncoes.pStepStatusGravacao(prgStatus);
      End;

      VS_FuncoesExternas.fICommit;

      Result := True;
    Except
      On E: Exception Do
      Begin
        VS_FuncoesExternas.fIRollback;

        Raise E;
      End;
    End;
  Finally
    LInserir.Close;
    FreeAndNil(LInserir);
  End;
end;

procedure TConciliaRecebiveisMkt.MarcarCartaoEncontradoArquivo(AValorBruto, AValorRecebido: Double;
  var ARegistroRelatorio: TItensRelatorioCartoes; AChaveConciliacao: String;
  ADatasetRegistro: TDataset; AFreteMarketPlace: Double;
  AAjusteMarketPlace: Double; ATaxaMarketPlace: Double; ACupomMarketPlace: Double;
  AFreteMediacao: Double = 0; ADiferencaCupom: Double = 0);
  Var
    LValorBrutoOriginal: Double;
begin
  If CartaoRecebidoPeloCaixaENaoTransferido(cdsBaiCar) Then
  Begin
    FTextoInconsistencia := 'Vendas recebidas pelo Resumo de Caixa não transferidas';
    ARegistroRelatorio.InconsistenciaConciliada := 'N';
    Exit;
  End;

  cdsBaiCar.Edit;

  LValorBrutoOriginal := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;

  If Not TShopeeFuncoes.fEmptyStr(AChaveConciliacao) Then
  Begin
    cdsBaiCar.FieldByName('MCA_ESTABE').AsString := '0';
    cdsBaiCar.FieldByName('MCA_CHACON').AsString := AChaveConciliacao;
  End;

  cdsBaiCar.FieldByName('MCA_MARDES').AsString := 'M';

  If cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat <> AValorBruto Then
  Begin
    cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat := AValorBruto;
    cdsBaiCar.FieldByName('ALTERAR_BRUTO').AsString := 'S';
  End;

  ARegistroRelatorio.Descricao := EmptyStr;
  ARegistroRelatorio.TipoDoRegistro := 'PAGAMENTO';

  cdsBaiCar.FieldByName('MCA_VALREC').AsFloat := TShopeeFuncoes.fFormataFloat(AValorRecebido, 2);

  cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime := ADatasetRegistro.FieldByName('SHO_DTADEC').AsDateTime;
  cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat    := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;

  cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat := TShopeeFuncoes.fFormataFloat(ATaxaMarketPlace, 2);

  cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat    := (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat /
                                                     cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100;

  cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := TShopeeFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat, 2);
  cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat  := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
  cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat  := 1;
  cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat  := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;

  cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString := fRetornaChaveConciliacao(ADatasetRegistro);
  cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat := AFreteMarketPlace;

  cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat := AAjusteMarketPlace;

  cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat := ACupomMarketPlace;

  If TShopeeFuncoes.fFormataFloat(AValorRecebido, 2) <= 0 Then
  Begin
    cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat := LValorBrutoOriginal;
    cdsBaiCar.FieldByName('MCA_VALREC').AsFloat := 0;
    cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat := 0;
    cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat := 0;
    cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
    cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := 0;
    cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat  := 0;
    cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat  := 0;
    cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat  := 0;
    cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat := 0;
    cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat := 0;
  End;

  cdsBaicar.FieldByName('TABELA_UPDATE').AsString := 'SHO_SHPGTO';
  If ADatasetRegistro.FieldByName('SHO_BENEFI').AsString.Equals('Ajuste') Then
  Begin
    cdsBaicar.FieldByName('TABELA_UPDATE').AsString := 'SHO_SHAJUS';
    cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString := fRetornaChaveConciliacaoAjuste(ADatasetRegistro);
  End;

  ARegistroRelatorio.AutoIncremMovCar := cdsBaiCar.FieldByName('AUTOINC').AsString;
  
  cdsBaiCar.Post;
end;

function TConciliaRecebiveisMkt.fRetNomBandeira(strNumCar: String;
  ATipoCartao: String = ''): String;
begin

  If Not TShopeeFuncoes.fEmptyStr(FBandeiraCartao) Then
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

function TConciliaRecebiveisMkt.fRetornaChaveConciliacao(cdsDataset: TDataset): String;
  Var
    stlCampos: TStringList;
    strCampo : String;
begin
  Result := '';

  If TShopeeFuncoes.fEmptyStr(objConcil.strChavePrimaria) Then
    Exit;

  If Not Assigned(cdsDataset) Then
    Exit;

  If cdsDataset.IsEmpty Then
    Exit;

  stlCampos := TStringList.Create;
  stlCampos.Delimiter     := ',';
  stlCampos.DelimitedText := objConcil.strChavePrimaria;

  For strCampo in stlCampos Do
  Begin
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
end;

function TConciliaRecebiveisMkt.fRetornaChaveConciliacaoAjuste(
  cdsDataset: TDataset): String;
  Var
    stlCampos: TStringList;
    strCampo : String;
begin
  Result := '';

  If TShopeeFuncoes.fEmptyStr(objConcil.strChavePrimariaAjuste) Then
    Exit;

  If Not Assigned(cdsDataset) Then
    Exit;

  If cdsDataset.IsEmpty Then
    Exit;

  stlCampos := TStringList.Create;
  stlCampos.Delimiter     := ',';
  stlCampos.DelimitedText := objConcil.strChavePrimariaAjuste;

  For strCampo in stlCampos Do
  Begin
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
end;

function TConciliaRecebiveisMkt.fRetornaDadosDeBaixaDosAjustes(strConfiguracao, strEmpresaConfiguracao: String): String;
begin
  Result := '';

  If Not TShopeeFuncoes.fEmptyStr(strEmpresaConfiguracao) Then
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

  qryConsulta := VS_FuncoesExternas.fICriaQuery;

  qryConsulta.SQL.Text := 'SELECT * FROM CONPOR WHERE CON_CODCAR=:CODCAR ORDER BY CON_CODEMP';

  strIndiceAnterior := cdsBaiCar.IndexFieldNames;
  cdsBaiCar.IndexFieldNames := 'MCA_CODCAR';

  Try
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
          cdsBaiCar.FieldByName('FOR_NOMFOR').AsString := TShopeeFuncoes.RetornaNomeFornecedor(qryConsulta.FieldByName('CON_FORTAX').AsString);

          cdsBaiCar.FieldByName('DESC_EVE_CREDITO').AsString := TShopeeFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVECRE').AsString);
          cdsBaiCar.FieldByName('DESC_EVE_TAXA').AsString    := TShopeeFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVETAX').AsString);
          cdsBaiCar.FieldByName('DESC_EVE_DEBITO').AsString  := TShopeeFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVEDEB').AsString);

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

    FreeAndNil(qryConsulta);
  End;
end;

procedure TConciliaRecebiveisMkt.pCalculaPeriodoFiltro(strCampo: String);
begin
  If Assigned(lstDtaCad) Then
    FreeAndNil(lstDtaCad);
  lstDtaCad := TStringList.Create;

  If (cdsConCar.IsEmpty) Then
  Begin
    lstDtaCad.Add(FormatDateTime('yyyy-mm-dd', dtaDtaIni));
    Exit;
  End;

  cdsConCar.IndexFieldNames := strCampo;
  cdsConCar.First;
  If dtaDtaIni > cdsConCar.FieldByName(strCampo).Value Then
    dtaDtaIni := cdsConCar.FieldByName(strCampo).Value;

  While Not cdsConCar.Eof Do
  Begin
    If lstDtaCad.IndexOf(FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName(strCampo).Value)) < 0 Then
      lstDtaCad.Add(FormatDateTime('yyyy-mm-dd', cdsConCar.FieldByName(strCampo).Value));
    cdsConCar.Next;
  End;
  cdsConCar.Last;
  If dtaDtaFim < cdsConCar.FieldByName(strCampo).Value Then
    dtaDtaFim := cdsConCar.FieldByName(strCampo).Value;
end;

function TConciliaRecebiveisMkt.fBetween(fltValor, fltMinimo,
  fltMaximo: Double): Boolean;
begin
  Result := (fltValor >= fltMinimo) And
            (fltValor <= fltMaximo);
end;

function TConciliaRecebiveisMkt.fBuscaCartao(strNumCCD, strNumNSU, strCodEmp,
  strParcel: String; dtaDtaCup: TDateTime; intConcil: Integer = 0;
  blnPesquisaBaixado: Boolean = False; AValorBruto: Double = 0.00): Boolean;
  Var
    LChaveCompletaSemEmpresa: Boolean;
    LTolerancia : Double;

    LValorBruto: Double;
begin
  Result := False;

  LValorBruto := 0.00;
  If blnPesquisaBaixado Then
  Begin
    LValorBruto := cdsConCar.FieldByName(objConcil.CampoValorBruto).AsFloat;
    If AValorBruto <> 0.00 Then
      LValorBruto := AValorBruto;
  End;

  If intConcil <> 0 Then
  Begin
    If blnPesquisaBaixado Then
    Begin
      If fBuscaCartaoBaixado(strNumCCD, strNumNsu, strCodEmp, strParcel, dtaDtaCup, True) Then
      Begin
        FTextoInconsistencia := 'Cartão já foi baixado';

        Exit;
      End;
    End;
  End;

  LChaveCompletaSemEmpresa := False;
  LTolerancia := RetornaValorTolerancia(strCodEmp,0.2999999);

  If Not strCodEmp.IsEmpty Then
    Result := TShopeeFuncoes.IIF((Not TShopeeFuncoes.fEmptyStr(strNumCCD) And Not TShopeeFuncoes.fEmptyStr(strNumNSU)),
                  cdsBaiCar.Locate('MCA_NUMCCD;MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_EMPRCX;MCA_MARDES', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup, strCodEmp, 'D']),[]),
                  False);

  If Not Result Then
  Begin
    Result := TShopeeFuncoes.IIF((Not TShopeeFuncoes.fEmptyStr(strNumCCD) And Not TShopeeFuncoes.fEmptyStr(strNumNSU)),
                  cdsBaiCar.Locate('MCA_NUMCCD;MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_MARDES', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup, 'D']),[]),
                  False);

    LChaveCompletaSemEmpresa := Result;
  End;

  If (Not TShopeeFuncoes.fEmptyStr(strCodEmp)) And (Not LChaveCompletaSemEmpresa) Then
  Begin
    If Not Result Then
      Result := TShopeeFuncoes.IIF(Not TShopeeFuncoes.fEmptyStr(strNumCCD),
                    cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_DTACUP;MCA_EMPRCX;MCA_MARDES', VarArrayOf([UpperCase(strNumCCD),
                    strParcel, dtaDtaCup, strCodEmp, 'D']),[]),
                    False);

    {********************************************}
    {* ALGUMAS OPERADORAS UTILIZAM O MESMO NSU  *}
    {* MUITAS VEZES. ENTÃO, ANTES DE PESQUISAR  *}
    {* PELO NSU, VERIFICA SE A AUTORIZAÇÃO ESTÁ *}
    {* BAIXADA.                                 *}
    {*****************************************AJ*}
    If (blnPesquisaBaixado) And (intConcil = 0) And
       ((Not Result) Or ((Result) And (Not fBetween(cdsBaicar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto, -LTolerancia, LTolerancia)))) Then
    Begin
      Result := (Not TShopeeFuncoes.fEmptyStr(strNumCCD)) And
                (fBuscaCartaoBaixado(strNumCCD, strNumNSU, strCodEmp, strParcel, dtaDtaCup, True));

      If Result Then
      Begin
        Result    := False;
        FTextoInconsistencia := 'Cartão já foi baixado';
        Exit;
      End;
    End;

    If Not Result Then
      Result := TShopeeFuncoes.IIF(Not TShopeeFuncoes.fEmptyStr(strNumNSU),
                    cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_EMPRCX;MCA_MARDES', VarArrayOf([UpperCase(strNumNSU),
                    strParcel, dtaDtaCup, strCodEmp, 'D']),[]),
                    False);
  End;

  If (Not Result) Or (LChaveCompletaSemEmpresa) Then
  Begin

    If Not Result Then
      Result := TShopeeFuncoes.IIF(Not TShopeeFuncoes.fEmptyStr(strNumCCD),
                    cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_DTACUP;MCA_MARDES', VarArrayOf([UpperCase(strNumCCD),
                    strParcel, dtaDtaCup, 'D']),[]),
                    False);

    {********************************************}
    {* ALGUMAS OPERADORAS UTILIZAM O MESMO NSU  *}
    {* MUITAS VEZES. ENTÃO, ANTES DE PESQUISAR  *}
    {* PELO NSU, VERIFICA SE A AUTORIZAÇÃO ESTÁ *}
    {* BAIXADA.                                 *}
    {*****************************************AJ*}
    If (blnPesquisaBaixado) And (intConcil = 0) And
       ((Not Result) Or ((Result) And (Not fBetween(cdsBaicar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto, -LTolerancia, LTolerancia)))) Then
    Begin
      Result := (Not TShopeeFuncoes.fEmptyStr(strNumCCD)) And
                (fBuscaCartaoBaixado(strNumCCD, strNumNSU, strCodEmp, strParcel, dtaDtaCup, True));

      If Result Then
      Begin
        Result := False;
        FTextoInconsistencia := 'Cartão já foi baixado';
        Exit;
      End;
    End;

    If Not Result Then
      Result := TShopeeFuncoes.IIF(Not TShopeeFuncoes.fEmptyStr(strNumNSU),
                    cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_MARDES', VarArrayOf([UpperCase(strNumNSU),
                    strParcel, dtaDtaCup, 'D']),[]),
                    False);
  End;
end;

function TConciliaRecebiveisMkt.fBuscaCartaoBaixado(strNumCCD, strNumNSU,
  strCodEmp, strParcel: String; dtaDtaCup: TDateTime;
  blnValidaValorBruto: Boolean = False; AValorBruto: Double = 0.00): Boolean;
  Var
    LTolerancia : Double;

    LValorBruto: Double;
begin
  Result := False;

  LValorBruto := 0.00;
  If blnValidaValorBruto Then
  Begin
    If Assigned(cdsConCar) Then
      LValorBruto := cdsConCar.FieldByName(objConcil.CampoValorBruto).AsFloat;

    If AValorBruto <> 0.00 Then
      LValorBruto := AValorBruto;
  End;

  LTolerancia := RetornaValorTolerancia(strCodEmp,0.02999999);

  If (Not TShopeeFuncoes.fEmptyStr(strCodEmp)) Then
  Begin
    Result := TShopeeFuncoes.IIF((Not TShopeeFuncoes.fEmptyStr(strNumCCD) And Not TShopeeFuncoes.fEmptyStr(strNumNSU)),
                  cdsBaixad.Locate('MCA_NUMCCD;MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup, strCodEmp]),[]),
                  False);

    if not Result then
      Result := TShopeeFuncoes.IIF(Not TShopeeFuncoes.fEmptyStr(strNumCCD),
                    cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(strNumCCD),
                    strParcel, dtaDtaCup, strCodEmp]),[]),
                    False);
    If Not Result Then
      Result := TShopeeFuncoes.IIF(Not TShopeeFuncoes.fEmptyStr(strNumNSU),
                    cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(strNumNSU),
                    strParcel, dtaDtaCup, strCodEmp]),[]),
                    False);
  End;

  If Not Result Then
  Begin
    Result := TShopeeFuncoes.IIF((Not TShopeeFuncoes.fEmptyStr(strNumCCD) And Not TShopeeFuncoes.fEmptyStr(strNumNSU)),
                  cdsBaixad.Locate('MCA_NUMCCD;MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup]),[]),
                  False);

  End;

  If Not Result Then
  Begin
    Result := TShopeeFuncoes.IIF(Not TShopeeFuncoes.fEmptyStr(strNumCCD),
                  cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP', VarArrayOf([UpperCase(strNumCCD),
                  strParcel, dtaDtaCup]),[]),
                  False);
    If Not Result Then
      Result := TShopeeFuncoes.IIF(Not TShopeeFuncoes.fEmptyStr(strNumNSU),
                    cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP', VarArrayOf([UpperCase(strNumNSU),
                    strParcel, dtaDtaCup]),[]),
                    False);
  End;

  If blnValidaValorBruto Then
  Begin
    If Result Then
    Begin
      Result := fBetween(LValorBruto - cdsBaixad.FieldByName('MCA_VALSTA').AsFloat,
                         -LTolerancia, LTolerancia);

      If Not Result Then
      Begin
        If Not strCodEmp.IsEmpty Then
          Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX',
                                     VarArrayOf([UpperCase(strNumCCD),
                                                 UpperCase(strNumNSU),
                                                 strParcel,
                                                 dtaDtaCup,
                                                 strCodEmp]),[]);

        If Not Result Then
          Result := cdsBaixad.Locate('MCA_NUMCCD;MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP',
                                     VarArrayOf([UpperCase(strNumCCD),
                                                 UpperCase(strNumNSU),
                                                 strParcel,
                                                 dtaDtaCup]),[]);

        If Result Then
          Result := fBetween(LValorBruto - cdsBaixad.FieldByName('MCA_VALSTA').AsFloat,
                             -LTolerancia, LTolerancia);
      End;
    End;
  End;

  blnAutomatica := (Result) And
                   (Not TShopeeFuncoes.fEmptyStr(cdsBaixad.FieldbyName('MCA_CHACON').AsString));

  If Result Then
  Begin
    cdsBaixad.Edit;
    cdsBaixad.FieldByName('VALIDADO').AsString := 'S';
    cdsBaixad.Post;
  End;
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

  LConsulta := VS_FuncoesExternas.fICriaQuery;

  VS_FuncoesExternas.fIStartTransaction;
  Try
    Try
      LConsulta.SQL.Text := 'SELECT * FROM REL_CONCAR WHERE AUTOINCREM=' + FRelatorioConciliacao.AutoIncremRelatorio;
      LConsulta.Open;

      TShopeeFuncoes.GravaTabelaDelecao(AUnitRemocao,
                                            'REL_CONCAR',
                                             LConsulta);

      TShopeeFuncoes.ExecutaSQL('DELETE FROM REL_CONCAR WHERE AUTOINCREM=' + FRelatorioConciliacao.AutoIncremRelatorio);

      VS_FuncoesExternas.fICommit;
    Finally
      LConsulta.Close;
      FreeAndNil(LConsulta);
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

function TConciliaRecebiveisMkt.RetornaCodigosEstabelecimentosLocateIn(ARetornarIn: Boolean = True): String;
  Var
    LConsulta: TUniQuery;
begin
  Result := EmptyStr;

  If Length(arrEmpresa) <= 0 Then
    Exit;

  LConsulta := VS_FuncoesExternas.fICriaQuery;

  Try
    LConsulta.SQL.Text := 'SELECT DISTINCT SIS_VALCFG ' +
                          'FROM CFGSIS ' +
                          'WHERE SIS_CODCFG IN ("CFG_REDEST", "CFG_REDECO") ' +
                          '  AND COALESCE(SIS_VALCFG, "") <> "" ' +
                          '  AND SIS_CODEMP IN ("' + TShopeeFuncoes.ConverterArrayConsultaParaStringList(arrEmpresa).CommaText.Replace(',', '","') + '")';
    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      Result := Result + LConsulta.FieldByName('SIS_VALCFG').AsString + ',';

      LConsulta.Next;
    End;

    Result := Result.Replace(',,', ',');

    If Not ARetornarIn Then
      Exit(Result.Replace(',', '_'));

    Result := '"' + LeftStr(Result, Result.Length - 1).Replace(',', '","') + '"';
  Finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  End;
end;

function TConciliaRecebiveisMkt.RetornaFiltrosDigitados: String;
begin
  Result := 'Data Inicial: ' + strDtaIni + #13 +
            'Data Final: ' + strDtaFim + #13;

  If Length(arrEmpresa) > 0 Then
    Result := Result + 'Empresas: ' + TShopeeFuncoes.ConverterArrayConsultaParaStringList(arrEmpresa).Text;

  If Length(arrPonVen) > 0 Then
    Result := Result + 'Pontos de Vendas: ' + TShopeeFuncoes.ConverterArrayConsultaParaStringList(arrPonVen).Text;
end;

function TConciliaRecebiveisMkt.RetornaListaPVsParaFiltroLocate: String;
  Var
    LItemArray: TConsultas;
begin
  Result := EmptyStr;

  If Length(arrPonVen) > 0 Then
  Begin
    For LItemArray In arrPonVen Do
      Result := Result + LItemArray.strCodigo + '_';
  End;

  If Length(arrEmpresa) = 0 Then
    Exit;

  Result := Result +
            RetornaCodigosEstabelecimentosLocateIn(False);
end;

function TConciliaRecebiveisMkt.RetornaParcelaCartao(AParcelaAtual,
  ATotalParcelas: String): String;
  Var
    LNumero: Integer;
begin
  If Not TryStrToInt(AParcelaAtual, LNumero) Then
    Exit('01/01');

  Result := TShopeeFuncoes.fStrZero(LNumero.ToString, 2) + '/';

  If Not TryStrToInt(ATotalParcelas, LNumero) Then
    Exit(Result + LeftStr(Result, 2));

  Result := Result + TShopeeFuncoes.fStrZero(LNumero.ToString, 2);
end;

function TConciliaRecebiveisMkt.RetornaTaxaParaValidacao: Double;
begin
  Result := cdsBaiCar.FieldByName('CAR_PERDES').AsFloat;

  If TShopeeFuncoes.RetornaValorCfg('CFG_VLDTAX').Equals('2') Then
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

  LRegistros := TShopeeFuncoes.CriarClientDataSet(cdsBaiCar);

  Try
    LRegistros.Filter := 'MCA_MARDES=''M'' AND REGISTROTRANSFERENCIA=''N'' ';
    LRegistros.Filtered := True;

    LRegistros.First;
    While Not LRegistros.Eof Do
    Begin
      Inc(AQuantidadeBaixados);

      ABrutoBaixados := ABrutoBaixados + TShopeeFuncoes.fFormataFloat(LRegistros.FieldByName('MCA_VALSTA').AsFloat, 2);
      ALiquidoBaixados := ALiquidoBaixados + TShopeeFuncoes.fFormataFloat(LRegistros.FieldByName('MCA_VALREC').AsFloat, 2);

      LRegistros.Next;
    End;
  Finally
    FreeAndNil(LRegistros);
  End;
end;

function TConciliaRecebiveisMkt.RetornaValorTolerancia(ACodEmp: String;ADefault: Double): Double;
begin
  If TShopeeFuncoes.fEmptyStr(objConcil.CfgVlrTolerancia) Then
    Exit(ADefault);

  If TShopeeFuncoes.fEmptyStr(ACodEmp) Then
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
                  (TShopeeFuncoes.fFormataFloat(AValorBruto * (RetornaTaxaParaValidacao / 100), 2))
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
  LInserir := VS_FuncoesExternas.fICriaQuery;

  Try
    LInserir.SQL.Text := 'SELECT * FROM REL_CONCAR WHERE FALSE';
    LInserir.Open;
    LInserir.Append;

    TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_CHAVE_', AOperadora.ToUpperInvariant + '-' +
                                                                     FormatDateTime('yyyymmdd', ADataRelatorio) + '_' +
                                                                     FormatDateTime('hhmmss', AHoraRelatorio) + '-' +
                                                                     ACodigoOperador + '-' + ATipoRelatorio.ToUpperInvariant);
    TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAREL', ADataRelatorio);
    TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_HORREL', AHoraRelatorio);
    TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODOPE', ACodigoOperador);
    TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_OPERAD', AOperadora);
    TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPREL', ATipoRelatorio);
    TShopeeFuncoes.SetaValorCampoDataset(LInserir, 'REL_FILREL', AFiltrosRelatorio + #13 +
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
    LInserir.Close;
    FreeAndNil(LInserir);
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
