unit untMercadoLivreConciliaRecebiveis;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, Vcl.Graphics, Vcl.Controls, System.Math,
     System.Generics.Collections,

     Uni, UniClientDataSet, cxProgressBar,

     untLibCartoesInterfacesTipos, untTLockLibCartoes, untTMercadoLivreFuncoes;

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
  cdsConCar,                             //DATASET DOS ARQUIVOS IMPORTADOS (EXCETO REDECARD)
  cdsAjustes,                            //DATASET AJUSTES/CANCELAMENTOS
  FDatasetMaquininhas:  TUniClientDataSet;

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

  FDatasetShippingZerado: TUniClientDataSet;

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

  function CarregaFiltrosParaBaixaRecebiveis(ADataInicial,
                                             ADataFinal: TDateTime;
                                             AArrayEmpresas: TConsultasArray): Boolean;

  procedure RetornaTotaisValoresQueSeraoBaixados(out AQuantidadeBaixados: Integer;
                                                 out ABrutoBaixados: Double;
                                                 out ALiquidoBaixados: Double);

  function fRetPesqPonVen: String;
  function RetornaListaPVsParaFiltroLocate: String;
  
  procedure GravarRegistroDeAjusteParaConciliacao(ARegistroRelatorio: TItensRelatorioCartoes;
                                                  AGravaCampoValorBruto: Boolean = False;
                                                  ADatasetSelecionado: TDataset = Nil);

  function fBetween(fltValor, fltMinimo, fltMaximo: Double): Boolean;

  function fRetornaChaveConciliacao(cdsDataset: TDataset): String;

  function PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(AValorBruto: Double;
                                                             ARegistro: TDataSet;
                                                             APercentual: Boolean = True): Boolean;
  function RetornaTaxaParaValidacao:Double;
  function RetornaTextoInconsistenciaAtualizado(ATextoInconsistencia: String): String;
  function RetornaTextoInconsistenciaMaquininhaAtualizado(ATextoInconsistencia: String): String;

  function fRetornaDadosDeBaixaDosAjustes(strConfiguracao,
                                          strEmpresaConfiguracao: String): String;

  function RetornaValorTolerancia(ACodEmp: String;ADefault: Double = 0): Double ;

  function RetornaParcelaCartao(AParcelaAtual, ATotalParcelas: String): String;

  function ConfiguracoesAjustesEstaoIncompletas(ACodigoEmpresa: String): String;

  function GravarRegistrosRelatorio(prgStatus: TcxProgressBar): Boolean;

  procedure RemoverRelatorioConciliacao(AUnitRemocao: String);

  function RetornaFiltrosDigitados: String;

  function SomaDoShippingIDVendaIgualAZero(AShippingID: String): Boolean;

  {*Maquininhas pesquisa cartao comum*}
  function fBuscaCartao(strNumCCD,
                        strNumNSU,
                        strCodEmp,
                        strParcel: String;
                        dtaDtaCup: TDateTime;
                        intConcil: Integer = 0): Boolean;

  function fBuscaCartaoBaixado(strNumCCD,
                               strNumNSU,
                               strCodEmp,
                               strParcel: String;
                               dtaDtaCup: TDateTime): Boolean;

  function fRetNomBandeira(strNumCar: String;
                           ATipoCartao: String = ''): String;

  private
    FExibirCartoesPendente: Boolean;
    FLancarAjustesACredito: Boolean;
    FTemAjusteACredito: Boolean;

    FPossuiInconsistencia: Boolean;

    FDataInicioPeriodo,
    FDataFinalPeriodo: TDateTime;

    FEmpresasPeriodo: TConsultasArray;

    function CartoesValidosParaRealizarAConciliacaoDoMercadoLivre: Boolean;
  public
    cdsBaiCar,                    //DATASET PARA MARCAÇÃO DE REGISTROS CONCILIADOS
    cdsBaixad: TUniCLientDataSet; //DATASET PARA BUSCAR SE FOI BAIXADO

    blnReabre   : Boolean;
    strNomCon   : String;

    FobjLockEstabelecimento: TLock;

    constructor Create;
    destructor Destroy; override;

    function fConciliaCartoes: Boolean; virtual;

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

    public
      property DataInicialConciliacao: TDate Read  dtaDtaIni;
      property DataFinalConciliacao  : TDate Read  dtaDtaFim;
      property ExibirCartoesPendente : Boolean Read FExibirCartoesPendente;

      property FiltrosRelatorio: TFiltrosRelatorioBaixaCartoes Read FFiltrosRelatorio;
end;

implementation
uses untTLibCartoesMovCar, untLibCartoesConstantes;

function TConciliaRecebiveisMkt.CarregaFiltrosParaBaixaRecebiveis(ADataInicial,
  ADataFinal: TDateTime; AArrayEmpresas: TConsultasArray): Boolean;
  Var
    LContadorItem: Integer;
begin
  If VS_FuncoesExternas.fICfgSis('MERANA', varBoolean) Then
  Begin
    Result := CartoesValidosParaRealizarAConciliacaoDoMercadoLivre;

    If Not Result Then
      Exit;
  End;

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
   TMercadoLivreFuncoes.fMensagem('ATENÇÃO', 'O filtro para conciliação não pode ser maior que 365 dias (1 ano)!', ['&OK'])
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

function TConciliaRecebiveisMkt.CartoesValidosParaRealizarAConciliacaoDoMercadoLivre: Boolean;
  Var
    LConsulta: TUniQuery;

    LCartoesMercadoLivre: String;

    LTotalCartoes: Integer;
begin
  LConsulta := Nil;
  Try
    LCartoesMercadoLivre := VarToStr(VS_FuncoesExternas.fICfgSis('MERCAR', varString)).Trim;

    If LCartoesMercadoLivre.IsEmpty Then
    Begin
      TMercadoLivreFuncoes.fMensagem('ATENÇÃO', 'Quando utiliza a configuração CFG_MERANA igual a Sim, ' +
                                                'é obrigatório a empresa possuir selecionado cartões na configuração CFG_MERCAR.' + #13 +
                                                'Entre nas configurações do Autcom, selecione a configuração CFG_MERCAR e ' +
                                                'selecione os cartões pertencentes ao Mercado Livre.', ['&Ok']);
      Exit(False);
    End;

    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT CAR_CODCAR, CAR_CTAAJU, CAR_CTAFRE, CAR_CTATAX, CAR_CTACUP ' +
                          'FROM CADCAR ' +
                          'WHERE CAR_CODCAR IN (' + TMercadoLivreFuncoes.fRetStrToSQLIn(LCartoesMercadoLivre) + ') ' +
                          '  AND (CAR_CTAAJU IS NULL OR CAR_CTAFRE IS NULL OR CAR_CTATAX IS NULL OR CAR_CTACUP IS NULL) ';

    LConsulta.Open;

    Result := LConsulta.IsEmpty;

    If Not Result Then
    Begin
      LCartoesMercadoLivre := EmptyStr;
      LTotalCartoes := LConsulta.RecordCount;

      LConsulta.First;
      While Not LConsulta.Eof Do
      Begin
        LCartoesMercadoLivre := LCartoesMercadoLivre + '"' + LConsulta.FieldByName('CAR_CODCAR').AsString + '",';

        LConsulta.Next;
      End;

      LCartoesMercadoLivre := LeftStr(LCartoesMercadoLivre, LCartoesMercadoLivre.Length - 1);

      LConsulta.Close;
      LConsulta.SQL.Text := 'SELECT CON_CODCAR, CON_CTAAJU, CON_CTAFRE, CON_CTATAX, CON_CTACUP ' +
                            'FROM CONPOR ' +
                            'WHERE CON_CODCAR IN (' + LCartoesMercadoLivre + ') ' +
                            '  AND CON_CODEMP = "' + VS_FuncoesExternas.fIRetEmpresaLogada + '" ' +
                            '  AND (CON_CTAAJU IS NOT NULL AND CON_CTAFRE IS NOT NULL AND CON_CTATAX IS NOT NULL AND CON_CTACUP IS NOT NULL) ';

      LConsulta.Open;

      Result := LConsulta.RecordCount = LTotalCartoes;

      If Not Result Then
       TMercadoLivreFuncoes.fMensagem('ATENÇÃO', 'Para continuar com a conciliação, todos os cartões selecionados para o Mercado Livre ' +
                                                 'devem estar configurados: ' + #13 +
                                                 '-Plano de Contas de Taxas; ' + #13 +
                                                 '-Plano de Contas de Cancelamentos/Ajustes; ' + #13 +
                                                 '-Plano de Contas de Fretes;' + #13 +
                                                 '-Plano de Contas de Cupons.', ['&Ok']);
    End;
  Finally
    TMercadoLivreFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

function TConciliaRecebiveisMkt.ConfiguracoesAjustesEstaoIncompletas(
  ACodigoEmpresa: String): String;
begin
  Result := 'S';

  If ACodigoEmpresa.Trim.IsEmpty Then
    Exit;

  If TMercadoLivreFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgPortadorAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If TMercadoLivreFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgPlanoDeContasAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If TMercadoLivreFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgFornecedorAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If Not FObrigatorioCentroDeCustos Then
    Exit('N');

  If TMercadoLivreFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.strEventoCancelamentoAjuste, varString, ACodigoEmpresa)) Then
    Exit;

  Result := 'N';
end;

constructor TConciliaRecebiveisMkt.Create;
begin
  blnReabre  := False;
  
  FListaRegistrosRelatorio := TListaRegistrosRelatorio.Create;

  FAjustesJaConciliados := True;
  blnAutomatica  := False;

  FLancarAjustesACredito := TMercadoLivreFuncoes.RetornaValorCfg('CFG_AJUCRE').Equals('S');
  FTemAjusteACredito := False;

  FConciliacaoComPixAtivado := False;
  LConciliacaoComBoletoAtivado := False;

  FLiberacaoTransferencia := TMercadoLivreFuncoes.RetornaValorCfg('CFG_USAAUT').Equals('S');

  FFiltrarAutorizacaoNSU := False;

  objConcil.CodigoEmpresaFixaParaBaixa := '';

  FDataInicioPeriodo := 0;
  FDataFinalPeriodo := 0;

  FDatasetShippingZerado := Nil;

  SetLength(FEmpresasPeriodo, 0);

  FObrigatorioCentroDeCustos := VS_FuncoesExternas.fICfgSis('CTPOBE', varBoolean);
end;

destructor TConciliaRecebiveisMkt.Destroy;
begin
  If Assigned(FRelatorioConciliacao) Then
  Begin
    If Not FRelatorioConciliacao.AutoIncremRelatorio.IsEmpty Then
      RemoverRelatorioConciliacao('frmMercadoLivreBaixaRecebiveisMkt');
  End;

  TMercadoLivreFuncoes.FreeAndNilDatasets(cdsAjustes);

  If Assigned(FRelatorioConciliacao) Then
    FreeAndNil(FRelatorioConciliacao);

  If Assigned(FListaRegistrosRelatorio) Then
    FreeAndNil(FListaRegistrosRelatorio);

  If Assigned(lstDtaCad) Then
    FreeAndNil(lstDtaCad);

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
  Var
    LPlanoContasMeliPayments: String;
begin
  If ARegistroRelatorio.Conciliado = 1 Then
    Exit;

  cdsBaiCar.Last;
  cdsBaiCar.Append;
  cdsBaiCar.FieldByName('AUTOINC').AsString     := VS_FuncoesExternas.fIRetEmpresaLogada +
                                                   TMercadoLivreFuncoes.fStrZero(ARegistroRelatorio.CodigoAutorizacao, 10) +
                                                   TMercadoLivreFuncoes.fRetSomenteNumeros(ARegistroRelatorio.Parcela) +
                                                   VS_FuncoesExternas.fIRetEmpresaLogada;

  cdsBaiCar.FieldByName('NRODUP').AsString      := TMercadoLivreFuncoes.fStrZero(ARegistroRelatorio.CodigoAutorizacao, 06);
  cdsBaiCar.FieldByName('PARDUP').AsString      := TMercadoLivreFuncoes.fGetLetraAlfa(StrtoInt(ARegistroRelatorio.Parcela));
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
  cdsBaiCar.FieldByName('CAR_CTABAI').AsString  := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPlanoDeContasAjustes, ARegistroRelatorio.CodigoEmpresa);

  If cdsAjustes.FieldByName('MER_SHP_ID').AsString.ToUpperInvariant.Contains('MELIPAYMENTS') Then
  Begin
    LPlanoContasMeliPayments := VS_FuncoesExternas.fICfgSis('MERPAY', varString, ARegistroRelatorio.CodigoEmpresa);
    If Not LPlanoContasMeliPayments.IsEmpty Then
      cdsBaiCar.FieldByName('CAR_CTABAI').AsString  := LPlanoContasMeliPayments;
  End;

  cdsBaiCar.FieldByName('CAR_PORTAX').Clear;
  cdsBaiCar.FieldByName('CAR_PORBAD').Clear;
  cdsBaiCar.FieldByName('CAR_FORTAX').AsString  := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgFornecedorAjustes, ARegistroRelatorio.CodigoEmpresa);
  cdsBaiCar.FieldByName('FOR_NOMFOR').AsString  := TMercadoLivreFuncoes.IIF(cdsBaiCar.FieldByName('CAR_FORTAX').AsString.IsEmpty, '', TMercadoLivreFuncoes.RetornaNomeFornecedor(cdsBaiCar.FieldByName('CAR_FORTAX').AsString));

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

  prgStatus.Properties.Max := FListaRegistrosRelatorio.Count;
  prgStatus.Position := 0;

  LInserir := Nil;
  Try
    VS_FuncoesExternas.fIStartTransaction;
    Try
      LInserir := VS_FuncoesExternas.fICriaQuery;
      LInserir.SQL.Text := 'SELECT * FROM REL_CONITE WHERE FALSE';
      LInserir.Open;

      For LRegistroRelatorio In FListaRegistrosRelatorio Do
      Begin
        LInserir.Append;

        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_RELINC', FRelatorioConciliacao.AutoIncremRelatorio);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_NOMARQ', LRegistroRelatorio.NomeArquivo);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODEST', LRegistroRelatorio.CodigoEstabelecimento);

        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODEMP', LRegistroRelatorio.CodigoEmpresa);
        If LRegistroRelatorio.CodigoEmpresa.IsEmpty Then
          TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODEMP', VS_FuncoesExternas.fIRetEmpresaLogada);

        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESCRI', LRegistroRelatorio.Descricao);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMNSU', LRegistroRelatorio.NumeroNSU);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODAUT', LRegistroRelatorio.CodigoAutorizacao);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_PARCEL', LRegistroRelatorio.Parcela);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_TOTPAR', LRegistroRelatorio.TotalParcelas);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAPAG', LRegistroRelatorio.DataPagamento);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTA_CV', LRegistroRelatorio.DataVenda);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAVEN', LRegistroRelatorio.DataVencimento);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_RESVEN', LRegistroRelatorio.ResumoVenda);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODBAN', LRegistroRelatorio.CodigoBandeira);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESBAN', LRegistroRelatorio.DescricaoBandeira);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_SEQMCA', LRegistroRelatorio.AutoIncremMovCar);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMCAR', LRegistroRelatorio.NumeroCartao);

        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALBRU', LRegistroRelatorio.ValorBruto);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALLIQ', LRegistroRelatorio.ValorLiquido);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALTAX', LRegistroRelatorio.ValorTaxas);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALFRE', LRegistroRelatorio.ValorFrete);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALAJU', LRegistroRelatorio.ValorAjustes);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALCUP', LRegistroRelatorio.ValorCupom);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_PERTAX', LRegistroRelatorio.PercentualTaxa);

        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPCAR', LRegistroRelatorio.TipoCartao);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPREG', LRegistroRelatorio.TipoDoRegistro);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_SOMTOT', LRegistroRelatorio.SomarNoTotal);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_INCOMP', LRegistroRelatorio.RegistroIncompleto);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_PORDEB', LRegistroRelatorio.PortadorDebito);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_PORCRE', LRegistroRelatorio.PortadorCredito);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_REGNEG', LRegistroRelatorio.RegistroNegociacao);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMNEG', LRegistroRelatorio.NumeroNegociacao);
        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESAJU', LRegistroRelatorio.DescricaoAjuste);

        TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_CONCIL', LRegistroRelatorio.Conciliado);

        LInserir.Post;

        If Not FPossuiInconsistencia Then
          FPossuiInconsistencia := MatchStr(LRegistroRelatorio.TipoDoRegistro, ['INCONSISTENCIA', 'AJUSTE']);

        TMercadoLivreFuncoes.pStepStatusGravacao(prgStatus);
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
    TMercadoLivreFuncoes.FreeAndNilDatasets(LInserir);
  End;
end;

procedure TConciliaRecebiveisMkt.MarcarCartaoEncontradoArquivo(AValorBruto, AValorRecebido: Double;
  var ARegistroRelatorio: TItensRelatorioCartoes; AChaveConciliacao: String;
  ADatasetRegistro: TDataset; AFreteMarketPlace: Double;
  AAjusteMarketPlace: Double; ATaxaMarketPlace: Double; ACupomMarketPlace: Double;
  AFreteMediacao: Double = 0; ADiferencaCupom: Double = 0);
  Var
    LValStaOriginal: Double;

    LBaixaZerada: Boolean;
begin
  If CartaoRecebidoPeloCaixaENaoTransferido(cdsBaiCar) Then
  Begin
    FTextoInconsistencia := 'Vendas recebidas pelo Resumo de Caixa não transferidas';
    ARegistroRelatorio.InconsistenciaConciliada := 'N';
    Exit;
  End;

  cdsBaiCar.Edit;

  If Not TMercadoLivreFuncoes.fEmptyStr(AChaveConciliacao) Then
  Begin
    cdsBaiCar.FieldByName('MCA_ESTABE').AsString := '0';
    cdsBaiCar.FieldByName('MCA_CHACON').AsString := AChaveConciliacao;
  End;

  cdsBaiCar.FieldByName('MCA_MARDES').AsString := 'M';

  LValStaOriginal := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
  If cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat <> (AValorBruto - ACupomMarketPlace) Then
  Begin
    cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat := AValorBruto - ACupomMarketPlace;
    cdsBaiCar.FieldByName('ALTERAR_BRUTO').AsString := 'S';
  End;

  ARegistroRelatorio.Descricao := EmptyStr;
  ARegistroRelatorio.TipoDoRegistro := 'PAGAMENTO';

  cdsBaiCar.FieldByName('MCA_VALREC').AsFloat := TMercadoLivreFuncoes.fFormataFloat(AValorRecebido, 2);

  cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime := ADatasetRegistro.FieldByName('MER_DTAPAG').AsDateTime;
  cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat    := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;

  cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat := TMercadoLivreFuncoes.fFormataFloat(ATaxaMarketPlace, 2);

  cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat    := (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat /
                                                     cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100;

  cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := TMercadoLivreFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat, 2);
  cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat  := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
  cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat  := 1;
  cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat  := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;

  cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString := fRetornaChaveConciliacao(ADatasetRegistro);
  cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat := AFreteMarketPlace;

  cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat := AAjusteMarketPlace;

  cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat := ACupomMarketPlace;

  LBaixaZerada := TMercadoLivreFuncoes.fFormataFloat(AValorRecebido, 2) <= 0;
  If Not LBaixaZerada Then
    LBaixaZerada := (FormatFloat(',0.00', AValorRecebido).Equals(FormatFloat(',0.00', ACupomMarketPlace))) Or
                    (SomaDoShippingIDVendaIgualAZero(cdsConCar.FieldByName('MER_SHP_ID').AsString));

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
    cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat := ACupomMarketPlace;

    If (TMercadoLivreFuncoes.fFormataFloat(AValorRecebido, 2) <= 0) Or
       (SomaDoShippingIDVendaIgualAZero(cdsConCar.FieldByName('MER_SHP_ID').AsString)) Then
    Begin
      cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat := 0;
      cdsBaiCar.FieldByName('MCA_VALREC').AsFloat := 0;
    End;
  End;

  ARegistroRelatorio.AutoIncremMovCar := cdsBaiCar.FieldByName('AUTOINC').AsString;
  
  cdsBaiCar.Post;
end;

function TConciliaRecebiveisMkt.fRetNomBandeira(strNumCar,
  ATipoCartao: String): String;
begin
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

  If TMercadoLivreFuncoes.fEmptyStr(objConcil.strChavePrimaria) Then
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
    If Assigned(stlCampos) Then
      FreeAndNil(stlCampos);
  End;
end;

function TConciliaRecebiveisMkt.fRetornaDadosDeBaixaDosAjustes(strConfiguracao, strEmpresaConfiguracao: String): String;
begin
  Result := '';

  If Not TMercadoLivreFuncoes.fEmptyStr(strEmpresaConfiguracao) Then
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

  qryConsulta := Nil;
  Try
    qryConsulta := VS_FuncoesExternas.fICriaQuery;

    qryConsulta.SQL.Text := 'SELECT * FROM CONPOR WHERE CON_CODCAR=:CODCAR ORDER BY CON_CODEMP';

    strIndiceAnterior := cdsBaiCar.IndexFieldNames;
    cdsBaiCar.IndexFieldNames := 'MCA_CODCAR';

    cdsBaiCar.First;
    While Not cdsBaiCar.Eof Do
    Begin
      If Not cdsBaicar.FieldByName('MCA_MARDES').AsString.Equals('M') Then
      Begin
        cdsBaicar.Next;
        Continue;
      End;

      Application.ProcessMessages;

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
          cdsBaiCar.FieldByName('FOR_NOMFOR').AsString := TMercadoLivreFuncoes.RetornaNomeFornecedor(qryConsulta.FieldByName('CON_FORTAX').AsString);

          cdsBaiCar.FieldByName('DESC_EVE_CREDITO').AsString := TMercadoLivreFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVECRE').AsString);
          cdsBaiCar.FieldByName('DESC_EVE_TAXA').AsString    := TMercadoLivreFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVETAX').AsString);
          cdsBaiCar.FieldByName('DESC_EVE_DEBITO').AsString  := TMercadoLivreFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVEDEB').AsString);

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

    TMercadoLivreFuncoes.FreeAndNilDatasets(qryConsulta);
  End;
end;

function TConciliaRecebiveisMkt.fBetween(fltValor, fltMinimo,
  fltMaximo: Double): Boolean;
begin
  Result := (fltValor >= fltMinimo) And
            (fltValor <= fltMaximo);
end;

function TConciliaRecebiveisMkt.fBuscaCartao(strNumCCD, strNumNSU, strCodEmp,
  strParcel: String; dtaDtaCup: TDateTime; intConcil: Integer): Boolean;
  Var
    LChaveCompletaSemEmpresa: Boolean;
begin
  Result := False;

  LChaveCompletaSemEmpresa := False;

  If Not strCodEmp.IsEmpty Then
    Result := TMercadoLivreFuncoes.IIF((Not TMercadoLivreFuncoes.fEmptyStr(strNumCCD) And Not TMercadoLivreFuncoes.fEmptyStr(strNumNSU)),
                  cdsBaiCar.Locate('MCA_NUMCCD;MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_EMPRCX;MCA_MARDES', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup, strCodEmp, 'D']),[]),
                  False);

  If Not Result Then
  Begin
    Result := TMercadoLivreFuncoes.IIF((Not TMercadoLivreFuncoes.fEmptyStr(strNumCCD) And Not TMercadoLivreFuncoes.fEmptyStr(strNumNSU)),
                  cdsBaiCar.Locate('MCA_NUMCCD;MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_MARDES', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup, 'D']),[]),
                  False);

    LChaveCompletaSemEmpresa := Result;
  End;

  If (Not TMercadoLivreFuncoes.fEmptyStr(strCodEmp)) And (Not LChaveCompletaSemEmpresa) Then
  Begin
    If Not Result Then
      Result := TMercadoLivreFuncoes.IIF(Not TMercadoLivreFuncoes.fEmptyStr(strNumCCD),
                    cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_DTACUP;MCA_EMPRCX;MCA_MARDES', VarArrayOf([UpperCase(strNumCCD),
                    strParcel, dtaDtaCup, strCodEmp, 'D']),[]),
                    False);

    If Not Result Then
      Result := TMercadoLivreFuncoes.IIF(Not TMercadoLivreFuncoes.fEmptyStr(strNumNSU),
                    cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_EMPRCX;MCA_MARDES', VarArrayOf([UpperCase(strNumNSU),
                    strParcel, dtaDtaCup, strCodEmp, 'D']),[]),
                    False);
  End;

  If (Not Result) Or (LChaveCompletaSemEmpresa) Then
  Begin

    If Not Result Then
      Result := TMercadoLivreFuncoes.IIF(Not TMercadoLivreFuncoes.fEmptyStr(strNumCCD),
                    cdsBaiCar.Locate('MCA_NUMCCD;PARDUP;MCA_DTACUP;MCA_MARDES', VarArrayOf([UpperCase(strNumCCD),
                    strParcel, dtaDtaCup, 'D']),[]),
                    False);

    If Not Result Then
      Result := TMercadoLivreFuncoes.IIF(Not TMercadoLivreFuncoes.fEmptyStr(strNumNSU),
                    cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_MARDES', VarArrayOf([UpperCase(strNumNSU),
                    strParcel, dtaDtaCup, 'D']),[]),
                    False);
  End;
end;

function TConciliaRecebiveisMkt.fBuscaCartaoBaixado(strNumCCD, strNumNSU,
  strCodEmp, strParcel: String; dtaDtaCup: TDateTime): Boolean;
begin
  Result := False;

  If (Not TMercadoLivreFuncoes.fEmptyStr(strCodEmp)) Then
  Begin
    Result := TMercadoLivreFuncoes.IIF((Not TMercadoLivreFuncoes.fEmptyStr(strNumCCD) And Not TMercadoLivreFuncoes.fEmptyStr(strNumNSU)),
                  cdsBaixad.Locate('MCA_NUMCCD;MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup, strCodEmp]),[]),
                  False);

    if not Result then
      Result := TMercadoLivreFuncoes.IIF(Not TMercadoLivreFuncoes.fEmptyStr(strNumCCD),
                    cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(strNumCCD),
                    strParcel, dtaDtaCup, strCodEmp]),[]),
                    False);
    If Not Result Then
      Result := TMercadoLivreFuncoes.IIF(Not TMercadoLivreFuncoes.fEmptyStr(strNumNSU),
                    cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(strNumNSU),
                    strParcel, dtaDtaCup, strCodEmp]),[]),
                    False);
  End;

  If Not Result Then
  Begin
    Result := TMercadoLivreFuncoes.IIF((Not TMercadoLivreFuncoes.fEmptyStr(strNumCCD) And Not TMercadoLivreFuncoes.fEmptyStr(strNumNSU)),
                  cdsBaixad.Locate('MCA_NUMCCD;MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup]),[]),
                  False);

  End;

  If Not Result Then
  Begin
    Result := TMercadoLivreFuncoes.IIF(Not TMercadoLivreFuncoes.fEmptyStr(strNumCCD),
                  cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP', VarArrayOf([UpperCase(strNumCCD),
                  strParcel, dtaDtaCup]),[]),
                  False);
    If Not Result Then
      Result := TMercadoLivreFuncoes.IIF(Not TMercadoLivreFuncoes.fEmptyStr(strNumNSU),
                    cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP', VarArrayOf([UpperCase(strNumNSU),
                    strParcel, dtaDtaCup]),[]),
                    False);
  End;

  blnAutomatica := (Result) And
                   (Not TMercadoLivreFuncoes.fEmptyStr(cdsBaixad.FieldbyName('MCA_CHACON').AsString));
end;

function TConciliaRecebiveisMkt.fConciliaCartoes: Boolean;
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

      TMercadoLivreFuncoes.GravaTabelaDelecao(AUnitRemocao,
                                            'REL_CONCAR',
                                             LConsulta);

      TMercadoLivreFuncoes.ExecutaSQL('DELETE FROM REL_CONCAR WHERE AUTOINCREM=' + FRelatorioConciliacao.AutoIncremRelatorio);

      VS_FuncoesExternas.fICommit;
    Finally
      TMercadoLivreFuncoes.FreeAndNilDatasets(LConsulta);
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
    If Length(arrEmpresa) > 0 Then
    Begin
      LStringList := TMercadoLivreFuncoes.ConverterArrayConsultaParaStringList(arrEmpresa);
      Result := Result + 'Empresas: ' + LStringList.Text;
      FreeAndNil(LStringList);
    End;

    If Length(arrPonVen) > 0 Then
    Begin
      LStringList := TMercadoLivreFuncoes.ConverterArrayConsultaParaStringList(arrPonVen);
      Result := Result + 'Pontos de Vendas: ' + LStringList.Text;
    End;
  Finally
    If Assigned(LStringList) Then
      FreeAndNil(LStringList);
  End;
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
end;

function TConciliaRecebiveisMkt.RetornaParcelaCartao(AParcelaAtual,
  ATotalParcelas: String): String;
  Var
    LNumero: Integer;
begin
  If Not TryStrToInt(AParcelaAtual, LNumero) Then
    Exit('01/01');

  Result := TMercadoLivreFuncoes.fStrZero(LNumero.ToString, 2) + '/';

  If Not TryStrToInt(ATotalParcelas, LNumero) Then
    Exit(Result + LeftStr(Result, 2));

  Result := Result + TMercadoLivreFuncoes.fStrZero(LNumero.ToString, 2);
end;

function TConciliaRecebiveisMkt.RetornaTaxaParaValidacao: Double;
begin
  Result := cdsBaiCar.FieldByName('CAR_PERDES').AsFloat;

  If TMercadoLivreFuncoes.RetornaValorCfg('CFG_VLDTAX').Equals('2') Then
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

function TConciliaRecebiveisMkt.RetornaTextoInconsistenciaMaquininhaAtualizado(
  ATextoInconsistencia: String): String;
begin
  Result := ATextoInconsistencia;

  If Result.IsEmpty Then
    Exit;

  If Result.Equals('Cartão já foi baixado') Then
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
    LRegistros := TMercadoLivreFuncoes.CriarClientDataSet(cdsBaiCar);
    LRegistros.Filter := 'MCA_MARDES=''M'' AND REGISTROTRANSFERENCIA=''N'' ';
    LRegistros.Filtered := True;

    LRegistros.First;
    While Not LRegistros.Eof Do
    Begin
      Inc(AQuantidadeBaixados);

      ABrutoBaixados := ABrutoBaixados + TMercadoLivreFuncoes.fFormataFloat(LRegistros.FieldByName('MCA_VALSTA').AsFloat, 2);
      ALiquidoBaixados := ALiquidoBaixados + TMercadoLivreFuncoes.fFormataFloat(LRegistros.FieldByName('MCA_VALREC').AsFloat, 2);

      LRegistros.Next;
    End;
  Finally
    TMercadoLivreFuncoes.FreeAndNilDatasets(LRegistros);
  End;
end;

function TConciliaRecebiveisMkt.RetornaValorTolerancia(ACodEmp: String;ADefault: Double): Double;
begin
  If TMercadoLivreFuncoes.fEmptyStr(objConcil.CfgVlrTolerancia) Then
    Exit(ADefault);

  If TMercadoLivreFuncoes.fEmptyStr(ACodEmp) Then
    ACodEmp :=  VS_FuncoesExternas.fIRetEmpresaLogada;

  Result := VS_FuncoesExternas.fICfgSis(objConcil.CfgVlrTolerancia,varCurrency,ACodEmp);
end;

function TConciliaRecebiveisMkt.SomaDoShippingIDVendaIgualAZero(
  AShippingID: String): Boolean;
begin
  Result := False;
  If AShippingID.Replace('0', EmptyStr).Trim.IsEmpty Then
    Exit;

  If Not Assigned(FDatasetShippingZerado) Then
    Exit;

  If FDatasetShippingZerado.IsEmpty Then
    Exit;

  If Not FDatasetShippingZerado.Locate('MER_SHP_ID', AShippingID, []) Then
    Exit;

  Result := FormatFloat('0.00', FDatasetShippingZerado.FieldByName('LIQUIDO').AsFloat).Equals('0,00');
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
                  (TMercadoLivreFuncoes.fFormataFloat(AValorBruto * (RetornaTaxaParaValidacao / 100), 2))
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

    TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_CHAVE_', AOperadora.ToUpperInvariant + '-' +
                                                                     FormatDateTime('yyyymmdd', ADataRelatorio) + '_' +
                                                                     FormatDateTime('hhmmss', AHoraRelatorio) + '-' +
                                                                     ACodigoOperador + '-' + ATipoRelatorio.ToUpperInvariant);
    TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAREL', ADataRelatorio);
    TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_HORREL', AHoraRelatorio);
    TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODOPE', ACodigoOperador);
    TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_OPERAD', AOperadora);
    TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPREL', ATipoRelatorio);
    TMercadoLivreFuncoes.SetaValorCampoDataset(LInserir, 'REL_FILREL', AFiltrosRelatorio + #13 +
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
