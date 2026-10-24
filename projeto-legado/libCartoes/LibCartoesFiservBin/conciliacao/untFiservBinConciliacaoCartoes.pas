unit untFiservBinConciliacaoCartoes;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, Vcl.Graphics, Vcl.Controls, System.Math,
     System.Generics.Collections,

     Uni, UniClientDataSet, cxProgressBar, frxClass, frxDBSet,

     untLibCartoesInterfacesTipos, untTLockLibCartoes, untTFiservBinFuncoes;

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
    TotalParcelas,
    NomeCliente,
    PlanoContasTransferenciaCredito,
    SituacaoCadastro: String;

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

    DescricaoAjuste,

    ChavePrimaria,

    AutoIncremMovCar: String;

    Conciliado: Integer;

    constructor Create;
  End;

  TListaRegistrosRelatorio = TObjectList<TItensRelatorioCartoes>;

type TConciliacaoCartoes = class
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

  FBaixarAjustes,
  FObrigatorioCentroDeCustos: Boolean;

  FConfiguracaoTaxaAdministrativa: String;

  FFiltrosRelatorio: TFiltrosRelatorioBaixaCartoes;

  procedure pFiltraCartoes;
  procedure pFiltraCartoesBaixados(AApenasNaoValidados: Boolean = False);

  procedure MarcarCartaoEncontradoArquivo(AValorRecebido: Double;
                                          ARegistroAntecipado: Boolean;
                                          var ARegistroRelatorio: TItensRelatorioCartoes;
                                          AChaveConciliacao: String;
                                          ADatasetRegistro: TDataset;
                                          ATaxaDeAntecipacao: Double = 0);

  procedure pAcertaDadosDeBaixaOtimizadaPorEmpresa;

  procedure pCalculaPeriodoFiltro(strCampo: String);
  Function fCartaoBloqueado(qryMovCar: TDataSet): Boolean;

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

  function fDigPeriodo(strDescricaoLabel: String = ''): Boolean;

  function fRetNomBandeira(strNumCar: String;
                           ATipoCartao: String = ''): String;

  function GeraRelatorioConciliacao(ANomCon: String; pgbStatus: TcxProgressBar): Boolean;

  procedure RetornaTotaisValoresQueSeraoBaixados(out AQuantidadeBaixados: Integer;
                                                 out ABrutoBaixados: Double;
                                                 out ALiquidoBaixados: Double);

  procedure FiltrarCancelamentosPeriodo(ACondicaoSQL: String;
                                        ATipoAjustes: String = '';
                                        ACondicaoAjusteCredito: String = '';
                                        ALimitarAutorizacao: Boolean = True);

  function fRetPesqPonVen(intTipo: Integer = 0): String;
  function RetornaListaPVsParaFiltroLocate: String;
  function RetornaCodigosEstabelecimentosLocateIn(ARetornarIn: Boolean = True): String;

  procedure GravarRegistroDeAjusteParaConciliacao(ARegistroRelatorio: TItensRelatorioCartoes;
                                                  AGravaCampoValorBruto: Boolean = False;
                                                  ADatasetNegociacao: TDataset = Nil);

  function fBetween(fltValor, fltMinimo, fltMaximo: Double): Boolean;

  function fRetornaChaveConciliacao(cdsDataset: TDataset): String;

  function PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(AValorBruto: Double;
                                                             ARegistro: TDataSet;
                                                             APercentual: Boolean = True): Boolean;
  function RetornaTaxaParaValidacao:Double;
  function RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa:String;
  function RetornaTextoInconsistenciaAtualizado(ATextoInconsistencia: String): String;

  function fRetornaDadosDeBaixaDosAjustes(strConfiguracao,
                                          strEmpresaConfiguracao: String): String;

  function RetornaValorTolerancia(ACodEmp: String;ADefault: Double = 0): Double ;

  function fExisteEstabelecimentosDuplicados(var AConfiguracao: String): Boolean;

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

    function RetornaInAutorizacaoFiltrar: String;
    function RetornaInNsuFiltrar: String;
  protected
    dtaDtaIni,
    dtaDtaFim,
    dtaDtaPag  : TDate;
    lstDtaCad  : TStringList;
    arrPonVen,
    arrEmpresa: TConsultasArray;
    strRcxTcc,
    strResumo,
    strDtaIni,
    strDtaFim,
    strCondicao: String;

    FAjustesJaConciliados  : Boolean;

    property CartoesConciliar: String read FCartoesConciliar write FCartoesConciliar;

  public
    cdsBaiCar,                    //DATASET PARA MARCAÇÃO DE REGISTROS CONCILIADOS
    cdsBaixad: TUniCLientDataSet; //DATASET PARA BUSCAR SE FOI BAIXADO

    FPossuiInconsistencia: Boolean;
    blnReabre   : Boolean;
    strNomCon   : String;

    FobjLockEstabelecimento: TLock;

    constructor Create;
    destructor Destroy; override;

    function fConciliaCartoes: Boolean; virtual;

    property DataInicialConciliacao: TDate Read  dtaDtaIni;
    property DataFinalConciliacao  : TDate Read  dtaDtaFim;
    property ExibirCartoesPendente : Boolean Read FExibirCartoesPendente;

    property FiltrosRelatorio: TFiltrosRelatorioBaixaCartoes Read FFiltrosRelatorio;
end;

implementation
uses untFiservBinDigPeriodo, untFiservBinFiltroInconsistencias,
     untLibCartoesGravando, untTLibCartoesMovCar, untLibCartoesConstantes;

function TConciliacaoCartoes.ConfiguracoesAjustesEstaoIncompletas(
  ACodigoEmpresa: String): String;
begin
  Result := 'S';

  If ACodigoEmpresa.Trim.IsEmpty Then
    Exit;

  If TFiservBinFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgPortadorAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If TFiservBinFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgPlanoDeContasAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If TFiservBinFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgFornecedorAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If Not FObrigatorioCentroDeCustos Then
    Exit('N');

  If TFiservBinFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.strEventoCancelamentoAjuste, varString, ACodigoEmpresa)) Then
    Exit;

  Result := 'N';
end;

constructor TConciliacaoCartoes.Create;
begin
  blnReabre  := False;

  FListaRegistrosRelatorio := TListaRegistrosRelatorio.Create;

  FAjustesJaConciliados := True;
  blnAutomatica  := False;

  FLancarAjustesACredito := TFiservBinFuncoes.RetornaValorCfg('CFG_AJUCRE').Equals('S');
  FTemAjusteACredito := False;

  FConciliacaoComPixAtivado := False;
  LConciliacaoComBoletoAtivado := False;

  FCartoesConciliar := '';

  FLiberacaoTransferencia := TFiservBinFuncoes.RetornaValorCfg('CFG_USAAUT').Equals('S');

  FFiltrarAutorizacaoNSU := False;

  objConcil.CodigoEmpresaFixaParaBaixa := '';

  FBaixarAjustes := VS_FuncoesExternas.fICfgSis('BAIDEB', varBoolean);
  FObrigatorioCentroDeCustos := VS_FuncoesExternas.fICfgSis('CTPOBE', varBoolean);
  FConfiguracaoTaxaAdministrativa := TFiservBinFuncoes.RetornaValorCfg('CFG_VLDTAX');
end;

destructor TConciliacaoCartoes.Destroy;
begin
  TFiservBinFuncoes.FreeAndNilDatasets(cdsAjustes);
  TFiservBinFuncoes.FreeAndNilDatasets(cdsConCar);
  TFiservBinFuncoes.FreeAndNilDatasets(cdsBaiCar);
  TFiservBinFuncoes.FreeAndNilDatasets(cdsBaixad);

  If Assigned(lstDtaCad) Then
    FreeAndNil(lstDtaCad);

  If Assigned(FRelatorioConciliacao) Then
    FreeAndNil(FRelatorioConciliacao);

  If Assigned(FListaRegistrosRelatorio) Then
    FreeAndNil(FListaRegistrosRelatorio);

  inherited;
end;

function TConciliacaoCartoes.fDigPeriodo(strDescricaoLabel: String = ''): Boolean;
var
  frmFiservBinDigPeriodo: TfrmFiservBinDigPeriodo;
  LConfiguracoesValidadasEstabelecimento: String;

  LContadorItem: Integer;
Begin
  LConfiguracoesValidadasEstabelecimento := objConcil.CfgEstabelecimentos;

  If fExisteEstabelecimentosDuplicados(LConfiguracoesValidadasEstabelecimento) Then
  Begin
    LConfiguracoesValidadasEstabelecimento :=
      LConfiguracoesValidadasEstabelecimento
        .Replace(' ', '')
        .Replace('(', '')
        .Replace(')', '')
        .Replace(',', '/');

    TFiservBinFuncoes.fMensagem('AVISO',
                                  'Existe o mesmo código de estabelecimento da ' +
                                  objConcil.NomeConciliacao + ' configurado para uma ' +
                                  ' ou mais empresas.' + #13 +
                                  'Verifique a(s) configuração(ões) '+
                                  LConfiguracoesValidadasEstabelecimento + '.' + #13 +
                                  'Para empresas que não possuem código de ' +
                                  'estabelecimento, deixe a configuração em branco.' + #13 +
                                  'A operação foi cancelada.', ['&Ok'], 0, False, 1, 220);
    blnReabre := False;
    Result    := False;
    Exit;
  End;

  frmFiservBinDigPeriodo := Nil;
  Result := False;
  While Not Result Do
  Begin
    Try
      TFiservBinFuncoes.pCriarFormularios(TfrmFiservBinDigPeriodo, frmFiservBinDigPeriodo);
      frmFiservBinDigPeriodo.Caption   := 'Conciliação de Cartões';
      frmFiservBinDigPeriodo.objConcil := objConcil;
      If Not strDescricaoLabel.IsEmpty Then
        frmFiservBinDigPeriodo.lblPeriodoConciliacao.Caption := strDescricaoLabel;

      frmFiservBinDigPeriodo.ShowModal;
      If Not frmFiservBinDigPeriodo.blnConfirma Then
      Begin
        frmFiservBinDigPeriodo.objLockEstabelecimento.pDestravarTodos;
        Exit;
      End;

      //Data e array para filtrar os registros de arquivos de conciliação
      dtaDtaIni := StrtoDate(frmFiservBinDigPeriodo.mskDtaIniConcil.Text);
      dtaDtaFim := StrtoDate(frmFiservBinDigPeriodo.mskDtaFinConcil.Text);
      strDtaIni := frmFiservBinDigPeriodo.mskDtaIniConcil.Text;
      strDtaFim := frmFiservBinDigPeriodo.mskDtaFinConcil.Text;

      SetLength(arrEmpresa, Length(frmFiservBinDigPeriodo.arrEmpresa));
      For LContadorItem := 0 To High(frmFiservBinDigPeriodo.arrEmpresa) Do
        arrEmpresa[LContadorItem].strCodigo := frmFiservBinDigPeriodo.arrEmpresa[LContadorItem].strCodigo;

      SetLength(arrPonVen, Length(frmFiservBinDigPeriodo.arrPonVen));
      For LContadorItem := 0 To High(frmFiservBinDigPeriodo.arrPonVen) Do
        arrPonVen[LContadorItem].strCodigo := frmFiservBinDigPeriodo.arrPonVen[LContadorItem].strCodigo;

      FobjLockEstabelecimento := frmFiservBinDigPeriodo.objLockEstabelecimento;
    Finally
      If Assigned(frmFiservBinDigPeriodo) Then
        FreeAndNil(frmFiservBinDigPeriodo);

      VS_FuncoesExternas.pITrimAppMemorySize;
    End;

    If dtaDtaFim - dtaDtaIni > 365 Then
      TFiservBinFuncoes.fMensagem('ATENÇÃO', 'O filtro para conciliação não pode ser maior que 365 dias (1 ano)!', ['&OK'])
    Else
      Result := True;
  End;
End;

function TConciliacaoCartoes.fRetPesqPonVen(intTipo: Integer = 0): String;
  Var
    intCont: Integer;

    LEstabelecimentos: String;
begin
  //intTipo= 0 Conciliacao - =1 Cancelamento
  Result := '';

  If (High(arrEmpresa) < 0) And (High(arrPonVen) < 0) Then
    Exit;

  Result := Result + ' AND (';

  If intTipo = 0 Then
  Begin
    If (High(arrEmpresa) >= 0) Then
    Begin
      Result := Result + ' EMP_CODEMP IN (';
      For intCont := 0 To High(arrEmpresa) Do
        Result := Result + '"' + arrEmpresa[intCont].strCodigo + '",';
      Result := Copy(Result, 1, Length(Result) - 1) + ') ';
    End;
  End
  Else
  Begin
    If (High(arrEmpresa) >= 0) Then
    Begin
      LEstabelecimentos := RetornaCodigosEstabelecimentosLocateIn;

      Result := Result + ' ' + objConcil.CampoEstabelecimento + ' IN (' + LEstabelecimentos + ') ';
    End;
  End;

  If (High(arrPonVen) >= 0) Then
  Begin
    Result := ' AND ( (' + objConcil.CampoEstabelecimento + ' IN (';
    For intCont := 0 To High(arrPonVen) Do
      Result := Result + '"' + arrPonVen[intCont].strCodigo + '",';
    Result := Copy(Result, 1, Length(Result) - 1) + ') ) ';
  End;

  Result := Result + ') ';
end;

procedure TConciliacaoCartoes.GravarRegistroDeAjusteParaConciliacao(
  ARegistroRelatorio: TItensRelatorioCartoes;
  AGravaCampoValorBruto: Boolean = False; ADatasetNegociacao: TDataset = Nil);
begin
  If ARegistroRelatorio.Conciliado = 1 Then
    Exit;

  If Not FBaixarAjustes Then
    Exit;

  cdsBaiCar.Last;
  cdsBaiCar.Append;
  cdsBaiCar.FieldByName('AUTOINC').AsString     := VS_FuncoesExternas.fIRetEmpresaLogada +
                                                   TFiservBinFuncoes.fStrZero(ARegistroRelatorio.CodigoAutorizacao, 10) +
                                                   TFiservBinFuncoes.fRetSomenteNumeros(ARegistroRelatorio.Parcela) +
                                                   VS_FuncoesExternas.fIRetEmpresaLogada;

  cdsBaiCar.FieldByName('NRODUP').AsString      := TFiservBinFuncoes.fStrZero(ARegistroRelatorio.CodigoAutorizacao, 06);
  cdsBaiCar.FieldByName('PARDUP').AsString      := TFiservBinFuncoes.fGetLetraAlfa(StrtoInt(ARegistroRelatorio.Parcela));
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

  cdsBaiCar.FieldByName('MCA_NUMNSU').AsString  := TFiservBinFuncoes.fStrZero(ARegistroRelatorio.NumeroNSU, 14);

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
  cdsBaiCar.FieldByName('FOR_NOMFOR').AsString  := TFiservBinFuncoes.IIF(cdsBaiCar.FieldByName('CAR_FORTAX').AsString.IsEmpty, '', TFiservBinFuncoes.RetornaNomeFornecedor(cdsBaiCar.FieldByName('CAR_FORTAX').AsString));
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
  If ARegistroRelatorio.RegistroNegociacao.Equals('S') Then
  Begin
    cdsBaiCar.FieldByName('NEGOCIACAO').AsString  := 'S';
    cdsBaiCar.FieldByName('NUMEROOPERACAO').AsString := ARegistroRelatorio.NumeroNegociacao;
  End;

  cdsBaiCar.FieldByName('REGISTROTRANSFERENCIA').AsString := 'N';

  If Not TFiservBinFuncoes.fEmptyStr(objConcil.strChavePrimaria) Then
  Begin
    If ARegistroRelatorio.RegistroNegociacao.Equals('S') Then
    Begin
      If Assigned(ADatasetNegociacao) Then
      Begin
        cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString  := fRetornaChaveConciliacao(ADatasetNegociacao);
        cdsBaiCar.FieldByName('VALOR_TAXA_NEGOCIACAO').AsFloat := TFiservBinFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat -
                                                                                cdsBaiCar.FieldByName('MCA_VALORI').AsFloat, 2);
        cdsBaiCar.FieldByName('PLANODECONTASTXNEGOCIACAO').AsString := ARegistroRelatorio.PlanoContasTaxaNegociacao;
      End;
    End
    Else
      cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString  := fRetornaChaveConciliacao(cdsAjustes);
  End;

  cdsBaiCar.Post;

  FAjustesJaConciliados := False;
end;

function TConciliacaoCartoes.GravarRegistrosRelatorio(prgStatus: TcxProgressBar): Boolean;
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

        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_RELINC', FRelatorioConciliacao.AutoIncremRelatorio);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_NOMARQ', LRegistroRelatorio.NomeArquivo);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODEST', LRegistroRelatorio.CodigoEstabelecimento);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODEMP', LRegistroRelatorio.CodigoEmpresa);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESCRI', LRegistroRelatorio.Descricao);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMNSU', LRegistroRelatorio.NumeroNSU);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODAUT', LRegistroRelatorio.CodigoAutorizacao);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_PARCEL', LRegistroRelatorio.Parcela);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_TOTPAR', LRegistroRelatorio.TotalParcelas);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAPAG', LRegistroRelatorio.DataPagamento);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTA_CV', LRegistroRelatorio.DataVenda);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAVEN', LRegistroRelatorio.DataVencimento);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_RESVEN', LRegistroRelatorio.ResumoVenda);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODBAN', LRegistroRelatorio.CodigoBandeira);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESBAN', LRegistroRelatorio.DescricaoBandeira);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_SEQMCA', LRegistroRelatorio.AutoIncremMovCar);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMCAR', LRegistroRelatorio.NumeroCartao);

        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALBRU', LRegistroRelatorio.ValorBruto);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALLIQ', LRegistroRelatorio.ValorLiquido);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALTAX', LRegistroRelatorio.ValorTaxas);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALFRE', LRegistroRelatorio.ValorFrete);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALAJU', LRegistroRelatorio.ValorAjustes);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_PERTAX', LRegistroRelatorio.PercentualTaxa);

        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPCAR', LRegistroRelatorio.TipoCartao);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPREG', LRegistroRelatorio.TipoDoRegistro);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_SOMTOT', LRegistroRelatorio.SomarNoTotal);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_INCOMP', LRegistroRelatorio.RegistroIncompleto);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_PORDEB', LRegistroRelatorio.PortadorDebito);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_PORCRE', LRegistroRelatorio.PortadorCredito);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_REGNEG', LRegistroRelatorio.RegistroNegociacao);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMNEG', LRegistroRelatorio.NumeroNegociacao);
        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESAJU', LRegistroRelatorio.DescricaoAjuste);

        TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_CONCIL', LRegistroRelatorio.Conciliado);

        LInserir.Post;

        If Not FPossuiInconsistencia Then
          FPossuiInconsistencia := MatchStr(LRegistroRelatorio.TipoDoRegistro, ['INCONSISTENCIA', 'AJUSTE']);

        TFiservBinFuncoes.pStepStatusGravacao(prgStatus);
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

procedure TConciliacaoCartoes.MarcarCartaoEncontradoArquivo(AValorRecebido: Double;
  ARegistroAntecipado: Boolean; var ARegistroRelatorio: TItensRelatorioCartoes;
  AChaveConciliacao: String; ADatasetRegistro: TDataset; ATaxaDeAntecipacao: Double = 0);
  Var
    LValorTaxa,
    LValorAjuste: Double;

    LParcelaDivergenteSemTaxa: Boolean;
begin
  If fCartaoBloqueado(cdsBaiCar) Then
  Begin
    ARegistroRelatorio.Descricao := 'Cartões recebidos pelo Caixa e não transferidos';
    ARegistroRelatorio.TipoDoRegistro := 'INCONSISTENCIA';
    ARegistroRelatorio.CodigoAutorizacao := cdsBaiCar.FieldByName('MCA_NUMNSU').AsString;
    ARegistroRelatorio.DataVenda := cdsBaiCar.FieldByName('MCA_DTACAD').AsDateTime;
    ARegistroRelatorio.DataVencimento := cdsBaiCar.FieldByName('MCA_DTAVEN').AsDateTime;
    ARegistroRelatorio.ValorBruto := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
    ARegistroRelatorio.ValorLiquido := cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat;
    ARegistroRelatorio.ValorTaxas := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;
    ARegistroRelatorio.AutoIncremMovCar := cdsBaiCar.FieldByName('AUTOINC').AsString;

    Exit;
  End;

  LValorAjuste := TFiservBinFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat, 2) - TFiservBinFuncoes.fFormataFloat(AValorRecebido, 2);
  LValorTaxa := TFiservBinFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat, 2);

  LParcelaDivergenteSemTaxa := LValorAjuste < 0;
  If LParcelaDivergenteSemTaxa Then
    LParcelaDivergenteSemTaxa := LValorTaxa = 0;

  cdsBaiCar.Edit;

  If Not TFiservBinFuncoes.fEmptyStr(AChaveConciliacao) Then
  Begin
    cdsBaiCar.FieldByName('MCA_ESTABE').AsString := ADatasetRegistro.FieldByName('BIN_CODEST').AsString;
    cdsBaiCar.FieldByName('MCA_CHACON').AsString := AChaveConciliacao;
  End;

  cdsBaiCar.FieldByName('MCA_MARDES').AsString := 'M';
  If LParcelaDivergenteSemTaxa Then
  Begin
    If Not FBaixarAjustes Then
      cdsBaiCar.FieldByName('MCA_MARDES').AsString := 'D';
  End;

  If cdsBaiCar.FieldByName('MCA_MARDES').AsString = 'M' Then
  Begin
    ARegistroRelatorio.Descricao := EmptyStr;
    ARegistroRelatorio.TipoDoRegistro := 'PAGAMENTO';

    cdsBaiCar.FieldByName('MCA_VALREC').AsFloat := TFiservBinFuncoes.IIF(LParcelaDivergenteSemTaxa,
                                                                     TFiservBinFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat,2),
                                                                     TFiservBinFuncoes.fFormataFloat(AValorRecebido, 2));

    cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime := ADatasetRegistro.FieldByName('BIN_DTAPAG').AsDateTime;

    If cdsBaiCar.FieldByName('MCA_DTAREC').IsNull Then
      cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime := cdsBaiCar.FieldByName('MCA_DTAVEN').AsDateTime;

    cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat    := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;

    If (Not LParcelaDivergenteSemTaxa) Then
      cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat  := TFiservBinFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat -
                                                                           TFiservBinFuncoes.fFormataFloat(AValorRecebido, 2), 2);

    cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat    := (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat /
                                                       cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100;
    If ARegistroAntecipado Then
    Begin
      cdsBaiCar.FieldByName('MCA_ANT_SN').AsString := 'S';
      cdsBaiCar.FieldByName('MCA_ANTECI').AsFloat  := AValorRecebido;
      cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat  := TFiservBinFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat -
                                                      AValorRecebido - LValorTaxa, 2);
      If cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat <= 0 Then
        cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat := 0;

      If ATaxaDeAntecipacao > 0 Then
        cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat := ATaxaDeAntecipacao;

      cdsBaiCar.FieldByName('MCA_TAXANT').AsFloat  := TFiservBinFuncoes.fFormataFloat(LValorTaxa, 2);
    End;

    cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := TFiservBinFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat, 2);
    cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat  := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
    cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat  := 1;
    cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat  := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;

    If Not TFiservBinFuncoes.fEmptyStr(objConcil.strChavePrimaria) Then
      cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString := fRetornaChaveConciliacao(ADatasetRegistro);
  End;

  ARegistroRelatorio.AutoIncremMovCar := cdsBaiCar.FieldByName('AUTOINC').AsString;

  cdsBaiCar.Post;

  If LParcelaDivergenteSemTaxa Then
  Begin
    ARegistroRelatorio.Descricao := 'Parcela com divergência de valor';
    ARegistroRelatorio.TipoCartao := 'AJUSTE DE PARCELA';
    ARegistroRelatorio.TipoDoRegistro := 'AJUSTES';
  End;
end;

function TConciliacaoCartoes.fRetNomBandeira(strNumCar: String;
  ATipoCartao: String = ''): String;
begin

  If Not TFiservBinFuncoes.fEmptyStr(FBandeiraCartao) Then
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

function TConciliacaoCartoes.fRetornaChaveConciliacao(cdsDataset: TDataset): String;
  Var
    stlCampos: TStringList;
    strCampo : String;
begin
  Result := '';

  If TFiservBinFuncoes.fEmptyStr(objConcil.strChavePrimaria) Then
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

function TConciliacaoCartoes.fRetornaDadosDeBaixaDosAjustes(strConfiguracao, strEmpresaConfiguracao: String): String;
begin
  Result := '';

  If Not TFiservBinFuncoes.fEmptyStr(strEmpresaConfiguracao) Then
    Result := VS_FuncoesExternas.fICfgSis(strConfiguracao, varString, strEmpresaConfiguracao);
end;

procedure TConciliacaoCartoes.pAcertaDadosDeBaixaOtimizadaPorEmpresa;
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
          cdsBaiCar.FieldByName('FOR_NOMFOR').AsString := TFiservBinFuncoes.RetornaNomeFornecedor(qryConsulta.FieldByName('CON_FORTAX').AsString);

          cdsBaiCar.FieldByName('DESC_EVE_CREDITO').AsString := TFiservBinFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVECRE').AsString);
          cdsBaiCar.FieldByName('DESC_EVE_TAXA').AsString    := TFiservBinFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVETAX').AsString);
          cdsBaiCar.FieldByName('DESC_EVE_DEBITO').AsString  := TFiservBinFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVEDEB').AsString);

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

    TFiservBinFuncoes.FreeAndNilDatasets(qryConsulta);
  End;
end;

procedure TConciliacaoCartoes.pCalculaPeriodoFiltro(strCampo: String);
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

function TConciliacaoCartoes.fBetween(fltValor, fltMinimo,
  fltMaximo: Double): Boolean;
begin
  Result := (fltValor >= fltMinimo) And
            (fltValor <= fltMaximo);
end;

function TConciliacaoCartoes.fBuscaCartao(strNumCCD, strNumNSU, strCodEmp,
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
    Result := TFiservBinFuncoes.IIF((Not TFiservBinFuncoes.fEmptyStr(strNumCCD) And Not TFiservBinFuncoes.fEmptyStr(strNumNSU)),
                  cdsBaiCar.Locate('MCA_NUMCCD;MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_EMPRCX;MCA_MARDES', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup, strCodEmp, 'D']),[]),
                  False);

  If Not Result Then
  Begin
    Result := TFiservBinFuncoes.IIF((Not TFiservBinFuncoes.fEmptyStr(strNumCCD) And Not TFiservBinFuncoes.fEmptyStr(strNumNSU)),
                  cdsBaiCar.Locate('MCA_NUMCCD;MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_MARDES', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup, 'D']),[]),
                  False);

    LChaveCompletaSemEmpresa := Result;
  End;

  If (Not TFiservBinFuncoes.fEmptyStr(strCodEmp)) And (Not LChaveCompletaSemEmpresa) Then
  Begin
    If Not Result Then
      Result := TFiservBinFuncoes.IIF(Not TFiservBinFuncoes.fEmptyStr(strNumCCD),
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
      Result := (Not TFiservBinFuncoes.fEmptyStr(strNumCCD)) And
                (fBuscaCartaoBaixado(strNumCCD, strNumNSU, strCodEmp, strParcel, dtaDtaCup, True));

      If Result Then
      Begin
        Result    := False;
        FTextoInconsistencia := 'Cartão já foi baixado';
        Exit;
      End;
    End;

    If Not Result Then
      Result := TFiservBinFuncoes.IIF(Not TFiservBinFuncoes.fEmptyStr(strNumNSU),
                    cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_EMPRCX;MCA_MARDES', VarArrayOf([UpperCase(strNumNSU),
                    strParcel, dtaDtaCup, strCodEmp, 'D']),[]),
                    False);
  End;

  If (Not Result) Or (LChaveCompletaSemEmpresa) Then
  Begin

    If Not Result Then
      Result := TFiservBinFuncoes.IIF(Not TFiservBinFuncoes.fEmptyStr(strNumCCD),
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
      Result := (Not TFiservBinFuncoes.fEmptyStr(strNumCCD)) And
                (fBuscaCartaoBaixado(strNumCCD, strNumNSU, strCodEmp, strParcel, dtaDtaCup, True));

      If Result Then
      Begin
        Result := False;
        FTextoInconsistencia := 'Cartão já foi baixado';
        Exit;
      End;
    End;

    If Not Result Then
      Result := TFiservBinFuncoes.IIF(Not TFiservBinFuncoes.fEmptyStr(strNumNSU),
                    cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_MARDES', VarArrayOf([UpperCase(strNumNSU),
                    strParcel, dtaDtaCup, 'D']),[]),
                    False);
  End;
end;

function TConciliacaoCartoes.fBuscaCartaoBaixado(strNumCCD, strNumNSU,
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

  If (Not TFiservBinFuncoes.fEmptyStr(strCodEmp)) Then
  Begin
    Result := TFiservBinFuncoes.IIF((Not TFiservBinFuncoes.fEmptyStr(strNumCCD) And Not TFiservBinFuncoes.fEmptyStr(strNumNSU)),
                  cdsBaixad.Locate('MCA_NUMCCD;MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup, strCodEmp]),[]),
                  False);

    if not Result then
      Result := TFiservBinFuncoes.IIF(Not TFiservBinFuncoes.fEmptyStr(strNumCCD),
                    cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(strNumCCD),
                    strParcel, dtaDtaCup, strCodEmp]),[]),
                    False);
    If Not Result Then
      Result := TFiservBinFuncoes.IIF(Not TFiservBinFuncoes.fEmptyStr(strNumNSU),
                    cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(strNumNSU),
                    strParcel, dtaDtaCup, strCodEmp]),[]),
                    False);
  End;

  If Not Result Then
  Begin
    Result := TFiservBinFuncoes.IIF((Not TFiservBinFuncoes.fEmptyStr(strNumCCD) And Not TFiservBinFuncoes.fEmptyStr(strNumNSU)),
                  cdsBaixad.Locate('MCA_NUMCCD;MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup]),[]),
                  False);

  End;

  If Not Result Then
  Begin
    Result := TFiservBinFuncoes.IIF(Not TFiservBinFuncoes.fEmptyStr(strNumCCD),
                  cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP', VarArrayOf([UpperCase(strNumCCD),
                  strParcel, dtaDtaCup]),[]),
                  False);
    If Not Result Then
      Result := TFiservBinFuncoes.IIF(Not TFiservBinFuncoes.fEmptyStr(strNumNSU),
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
                   (Not TFiservBinFuncoes.fEmptyStr(cdsBaixad.FieldbyName('MCA_CHACON').AsString));

  If Result Then
  Begin
    cdsBaixad.Edit;
    cdsBaixad.FieldByName('VALIDADO').AsString := 'S';
    cdsBaixad.Post;
  End;
end;

Function TConciliacaoCartoes.fCartaoBloqueado(qryMovCar: TDataSet): Boolean;
Begin
  Result := TLibCartoesMovCar.CartaoBloqueado(qryMovCar, strRcxTcc);
End;

function TConciliacaoCartoes.fConciliaCartoes: Boolean;
begin
  Result := False;
end;

procedure TConciliacaoCartoes.pFiltraCartoes;
Var
    strSQL   : String;
    strDtaCad: String;
    intCont  : Integer;

    qryBaiCar: TUniQuery;
begin
  strSQL := TLibCartoesMovcar.fGetSQLCartoes(objConcil);

  strDtaCad := '';

  For intCont := 0 To lstDtaCad.Count - 1 Do
    strDtaCad := strDtaCad + '"' + lstDtaCad[intCont] + '",';

  strSQL := strSQL + '  AND MCA_DTACUP IN (' + Copy(strDtaCad, 1, Length(strDtaCad) - 1) + ') ';

  If Not TFiservBinFuncoes.fRetSomenteNumeros(FCartoesConciliar).IsEmpty Then
    strSQL := strSQL + ' AND MCA_CODCAR IN (' + TFiservBinFuncoes.fRetStrToSQLIn(FCartoesConciliar) + ')';

  //Apenas cartões, no caso de Market Place não deve ser utilizado
  If FFiltrarAutorizacaoNSU Then
    strSQL := strSQL + ' AND (MCA_NUMCCD IN (' + RetornaInAutorizacaoFiltrar + ')' +
                       '  OR  MCA_NUMNSU IN (' + RetornaInNsuFiltrar + ')) ';

  strSQL := strSQL + ' ORDER BY MCA_DTAVEN, MCA_NUMDUP, MCA_CODEMP, MCA_NUMCCD, MCA_NUMNSU, MCA_PARCEL) AS TMP ';

  qryBaiCar := Nil;
  Try
    qryBaiCar := VS_FuncoesExternas.fICriaQuery;
    qryBaiCar.SQL.Text := strSQL;
    qryBaiCar.Options.SetFieldsReadOnly := False;
    qryBaiCar.Open;

    If Assigned(cdsBaiCar) Then
      FreeAndNil(cdsBaiCar);

    cdsBaiCar := TFiservBinFuncoes.CriarClientDataSet(qryBaiCar);

    cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;MCA_CODEMP;PARDUP;MCA_DTACUP;MCA_NUMDUP';
  Finally
    TFiservBinFuncoes.FreeAndNilDatasets(qryBaiCar);
  End;
end;

procedure TConciliacaoCartoes.pFiltraCartoesBaixados(AApenasNaoValidados: Boolean = False);
  Var
    strSQL,
    strDtaCad: String;
    qryBaixad: TUniQuery;
    intCont  : Integer;
begin
  strDtaCad := '';
  For intCont := 0 To lstDtaCad.Count - 1 Do
    strDtaCad := strDtaCad + '"' + lstDtaCad[intCont] + '",';

  strSQL := 'SELECT ';

  strSQL := strSQL + '  LPAD(UPPER(MCA_NUMCCD), 6, "0") AS MCA_NUMCCD, ';

  strSQL := strSQL + ' MCA_PARCEL, MCA_DTAREC, MCA_NUMNSU, MCA_NUMDUP, MCA_DTACUP, MCA_NUMPOK,             ';
  strSQL := strSQL + ' MCA_CODEMP, MCA_DTAVEN, MCA_EMPRCX, MCA_CHACON, MCA_VALSTA, ';
  strSQL := strSQL + '  CAST(" " AS CHAR(50)) AS MARKETPLACE,                      ';
  strSQL := strSQL + ' LPAD(RIGHT(MCA_NUMNSU,12),14,"0") AS NSU_B2W,               ';
  strSQL := strSQL + ' "N" AS VALIDADO                                             ';
  strSQL := strSQL + ' FROM MOVCAR                                                 ';
  strSQL := strSQL + ' WHERE MCA_DTACUP IN(' + Copy(strDtaCad, 1, Length(strDtaCad) -1) + ') ';

  strSQL := strSQL + ' AND MCA_DTAREC IS NOT NULL                                  ';
  strSQL := strSQL + ' ORDER BY MCA_NUMCCD, MCA_PARCEL,MCA_CODEMP                  ';

  qryBaixad := Nil;
  Try
    qryBaixad := VS_FuncoesExternas.fICriaQuery;
    qryBaixad.SQL.Add(strSQL);
    qryBaixad.Open;

    cdsBaixad := TFiservBinFuncoes.CriarClientDataSet(qryBaixad);
    cdsBaixad.Open;

    If AApenasNaoValidados Then
    Begin
      cdsBaixad.Filter := 'VALIDADO=''N'' ';
      cdsBaixad.Filtered := True;
    End;

    cdsBaixad.IndexFieldNames := 'MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_CODEMP';
    cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;EMPLOC;MCA_DTACUP;PARDUP';
  Finally
    TFiservBinFuncoes.FreeAndNilDatasets(qryBaixad);
  End;
end;

function TConciliacaoCartoes.GeraRelatorioConciliacao(ANomCon: String; pgbStatus: TcxProgressBar): Boolean;
  Var
    LValorBrutoDiferente,
    LRegistroNaoEncontrado,
    LCaixaNaoTransferidos,
    LCartoesBaixados,
    LValorTaxaDiferente,
    LExibeListaArquivos,
    LExibeTotaisBandeira,
    LExibeTotaisPontoDeVenda: Boolean;
    LOrdenacao: Integer;

    frmFiservBinFiltroInconsistencias: TfrmFiservBinFiltroInconsistencias;

    LNaoExibir: String;
begin
  pgbStatus.Visible := False;
  TForm(pgbStatus.Owner).Visible := True;
  TFiservBinFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Atualizando dados de conciliação.', False);
  pAcertaDadosDeBaixaOtimizadaPorEmpresa;
  TForm(pgbStatus.Owner).Visible := False;
  
  TFiservBinFuncoes.pCriarFormularios(TfrmFiservBinFiltroInconsistencias, frmFiservBinFiltroInconsistencias);
  Try
    frmFiservBinFiltroInconsistencias.Ordenacao := 1;

    frmFiservBinFiltroInconsistencias.ShowModal;

    LValorBrutoDiferente := frmFiservBinFiltroInconsistencias.ValorBrutoDiferente;
    LRegistroNaoEncontrado := frmFiservBinFiltroInconsistencias.RegistroNaoEncontrado;
    LCaixaNaoTransferidos := frmFiservBinFiltroInconsistencias.CaixaNaoTransferidos;
    LCartoesBaixados := frmFiservBinFiltroInconsistencias.CartoesBaixados;
    LExibeListaArquivos := frmFiservBinFiltroInconsistencias.ExibeListaArquivos;
    LOrdenacao := frmFiservBinFiltroInconsistencias.Ordenacao;
    LExibeTotaisBandeira := frmFiservBinFiltroInconsistencias.ExibeTotaisBandeira;
    LExibeTotaisPontoDeVenda := frmFiservBinFiltroInconsistencias.ExibeTotaisPontoDeVenda;
    LValorTaxaDiferente := frmFiservBinFiltroInconsistencias.ValorTaxaDiferente;

    Result := frmFiservBinFiltroInconsistencias.ModalResult = mrOK;
  Finally
    FreeAndNil(frmFiservBinFiltroInconsistencias);
    VS_FuncoesExternas.pITrimAppMemorySize;
  End;

  If Not Result Then
    Exit;

  LNaoExibir := 'NEGOCIAÇÃO DE RECEBÍVEIS_Cancelamentos/Ajustes_TRANSFERÊNCIAS_Devoluções_';

  If Not LValorBrutoDiferente Then
    LNaoExibir := LNaoExibir +
                  'Valor do cartão diferente do registrado no sistema ou Autorização duplicada_';

  If Not LRegistroNaoEncontrado Then
    LNaoExibir := LNaoExibir +
                  'Registro do arquivo não encontrado nos lançamentos do sistema_';

  If Not LCaixaNaoTransferidos Then
    LNaoExibir := LNaoExibir +
                  'Cartões recebidos pelo Caixa e não transferidos_';

  If Not LCartoesBaixados Then
    LNaoExibir := LNaoExibir +
                  'Cartão já foi baixado manualmente_Cartão já foi baixado através de conciliação automática_';

  If Not LValorTaxaDiferente Then
    LNaoExibir := LNaoExibir +
                  RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa + '_';

  FFiltrosRelatorio.AutoIncrem := FRelatorioConciliacao.AutoIncremRelatorio;
  FFiltrosRelatorio.FiltrosDescri := LNaoExibir;
  FFiltrosRelatorio.ExibeGrupoBandeira := LExibeTotaisBandeira;
  FFiltrosRelatorio.ExibeGrupoPontoDeVenda := LExibeTotaisPontoDeVenda;
  FFiltrosRelatorio.ExibeArquivos := LExibeListaArquivos;
  FFiltrosRelatorio.Ordenacao := LOrdenacao;

  VS_FuncoesExternas.prcIExecutaRelatorio(563,
                                           39565,
                                           [],
                                           ['AUTINC',
                                           'DESCRI',
                                           'EXBARQCON',
                                           'EXBREGFAL',
                                           'EXBRESBAN',
                                           'EXBTOTPVE',
                                           'ORDENACAO'],
                                             [
                                             FFiltrosRelatorio.AutoIncrem,
                                             FFiltrosRelatorio.FiltrosDescri,
                                             TFiservBinFuncoes.IIF(FFiltrosRelatorio.ExibeArquivos, 'Sim', 'Não'),
                                             TFiservBinFuncoes.IIF(FFiltrosRelatorio.ExibeFaltantes, 'Sim', 'Não'),
                                             TFiservBinFuncoes.IIF(FFiltrosRelatorio.ExibeGrupoBandeira, 'Sim', 'Não'),
                                             TFiservBinFuncoes.IIF(FFiltrosRelatorio.ExibeGrupoPontoDeVenda, 'Sim', 'Não'),
                                             TFiservBinFuncoes.IIF(FFiltrosRelatorio.Ordenacao = 0, 'Data da Venda',
                                                               TFiservBinFuncoes.IIF(FFiltrosRelatorio.Ordenacao = 1,
                                                                                 'Data de Vencimento', 'Número RV'))
                                             ],
                                             nil,
                                             nil,
                                             True);
end;

function TConciliacaoCartoes.fExisteEstabelecimentosDuplicados(
  var AConfiguracao: String): Boolean;
  Var
    strSQL  : String;
    qryTotal: TUniQuery;
Begin
  strSQL := '';
  strSQL := strSQL + 'SELECT COUNT(SIS_VALCFG) AS TOTAL, ';
  strSQL := strSQL + '   SIS_VALCFG                      ';
  strSQL := strSQL + 'FROM CFGSIS                        ';
  strSQL := strSQL + 'WHERE SIS_CODCFG IN ([CODCFG]) AND ';
  strSQL := strSQL + '  SIS_VALCFG IS NOT NULL AND       ';
  strSQL := strSQL + '  SIS_VALCFG <> ""                 ';
  strSQL := strSQL + 'GROUP BY SIS_VALCFG                ';
  strSQL := strSQL + '   HAVING COUNT(SIS_VALCFG) > 1    ';

  AConfiguracao := '("' + AConfiguracao + '")';

  strSQL := strSQL.Replace('([CODCFG])', AConfiguracao);

  qryTotal := Nil;
  Try
    qryTotal := VS_FuncoesExternas.fICriaQuery;
    qryTotal.SQL.Text := strSQL;

    qryTotal.Open;

    Result := Not qryTotal.IsEmpty;
  Finally
    TFiservBinFuncoes.FreeAndNilDatasets(qryTotal);
  End;
End;

procedure TConciliacaoCartoes.FiltrarCancelamentosPeriodo(ACondicaoSQL,
  ATipoAjustes, ACondicaoAjusteCredito: String; ALimitarAutorizacao: Boolean);
  Var
    LSQL,
    LEmpresaConfiguracao: String;

    LConsulta: TUniQuery;

    LAjusteCredito: Boolean;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  TFiservBinFuncoes.FreeAndNilDatasets(cdsAjustes);

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LSQL := '';
    LSQL := LSQL + 'SELECT DISTINCT A.*, ';

    If Not TFiservBinFuncoes.fEmptyStr(ATipoAjustes) Then
       LSQL := LSQL + ATipoAjustes + ' AS TIPAJU, ';

    If Not TFiservBinFuncoes.fEmptyStr(ACondicaoAjusteCredito) Then
       LSQL := LSQL + ACondicaoAjusteCredito + ' AS AJUCRE, ';

    LSQL := LSQL + '  "S" AS MARCADO, ';

    LSQL := LSQL + '  CAST("" AS CHAR(3)) AS EMPRESA ';
    LSQL := LSQL + ' FROM ' + objConcil.TabelaConciliacao + ' A ';
    LSQL := LSQL + ' WHERE ' + ACondicaoSQL ;

    LConsulta.Close;
    LConsulta.SQL.Text := LSQL;
    LConsulta.Open;

    cdsAjustes := TFiservBinFuncoes.CriarClientDataSet(LConsulta);

    cdsAjustes.First;
    While Not cdsAjustes.Eof Do
    Begin
      LEmpresaConfiguracao := LeftStr(TFiservBinFuncoes.fCfgSisEmp('BINEST', cdsAjustes.FieldByName('BIN_CODEST').AsString, True), 3);

      LRegistroRelatorio := TItensRelatorioCartoes.Create;
      Try
        LAjusteCredito := False;
        If cdsAjustes.FindField('AJUCRE') <> Nil Then
          LAjusteCredito := cdsAjustes.FieldByName('AJUCRE').Value <> 0;

        LRegistroRelatorio.ValorBruto := TFiservBinFuncoes.fFormataFloat(cdsAjustes.FieldByName('BIN_VALBRU').AsFloat, 2);
        LRegistroRelatorio.ValorLiquido := TFiservBinFuncoes.fFormataFloat(cdsAjustes.FieldByName('BIN_VALLIQ').AsFloat, 2);
        If LAjusteCredito Then
        Begin
          LRegistroRelatorio.ValorBruto := Abs(LRegistroRelatorio.ValorBruto);
          LRegistroRelatorio.ValorLiquido := Abs(LRegistroRelatorio.ValorLiquido);
        End;

        LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
        LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
        LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';
        LRegistroRelatorio.DescricaoAjuste := cdsAjustes.FieldByName('TIPAJU').AsString.ToUpperInvariant;

        LRegistroRelatorio.CodigoEmpresa := LEmpresaConfiguracao;
        LRegistroRelatorio.CodigoEstabelecimento := cdsAjustes.FieldByName('BIN_CODEST').AsString;
        LRegistroRelatorio.NumeroNSU := TFiservBinFuncoes.fStrZero(cdsAjustes.FieldByName('BIN_NUMNSU').AsString, 14);
        LRegistroRelatorio.NumeroCartao := cdsAjustes.FieldByName('BIN_NUMCAR').AsString;
        LRegistroRelatorio.Parcela := TFiservBinFuncoes.fStrZero(cdsAjustes.FieldByName('BIN_NUMPAR').AsString, 2);
        LRegistroRelatorio.TotalParcelas := TFiservBinFuncoes.fStrZero(cdsAjustes.FieldByName('BIN_TOTPAR').AsString, 2);
        LRegistroRelatorio.CodigoAutorizacao := TFiservBinFuncoes.fStrZero(Trim(cdsAjustes.FieldByName('BIN_CODAUT').Value), 6);
        If ALimitarAutorizacao Then
          LRegistroRelatorio.CodigoAutorizacao := RightStr(LRegistroRelatorio.CodigoAutorizacao, 6);

        LRegistroRelatorio.ResumoVenda := TFiservBinFuncoes.fStrZero('0', 12);

        LRegistroRelatorio.DataVenda := cdsAjustes.FieldByName('BIN_DTAPAG').Value;

        LRegistroRelatorio.DataPagamento := cdsAjustes.FieldByName('BIN_DTAPAG').Value;

        LRegistroRelatorio.Conciliado := cdsAjustes.FieldByName('BIN_CONCIL').AsInteger;
        LRegistroRelatorio.NomeArquivo := cdsAjustes.FieldByName('BIN_NOMARQ').AsString;

        LRegistroRelatorio.RegistroIncompleto := 'N';
        If FBaixarAjustes Then
        Begin
          LRegistroRelatorio.RegistroIncompleto := ConfiguracoesAjustesEstaoIncompletas(LEmpresaConfiguracao);

          GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio);
        End;
      Except
        FreeAndNil(LRegistroRelatorio);
        Raise;
      End;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      cdsAjustes.Next;
    End;

  Finally
    TFiservBinFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

procedure TConciliacaoCartoes.RemoverRelatorioConciliacao(AUnitRemocao: String);
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

      TFiservBinFuncoes.GravaTabelaDelecao(AUnitRemocao,
                                            'REL_CONCAR',
                                             LConsulta);

      TFiservBinFuncoes.ExecutaSQL('DELETE FROM REL_CONCAR WHERE AUTOINCREM=' + FRelatorioConciliacao.AutoIncremRelatorio);

      VS_FuncoesExternas.fICommit;
    Finally
      TFiservBinFuncoes.FreeAndNilDatasets(LConsulta);
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

function TConciliacaoCartoes.RetornaCodigosEstabelecimentosLocateIn(ARetornarIn: Boolean = True): String;
  Var
    LConsulta: TUniQuery;

    LEmpresas: TStringList;
begin
  Result := EmptyStr;

  If Length(arrEmpresa) <= 0 Then
    Exit;

  LConsulta := Nil;
  LEmpresas := Nil;
  Try
    LEmpresas := TFiservBinFuncoes.ConverterArrayConsultaParaStringList(arrEmpresa);
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := 'SELECT DISTINCT SIS_VALCFG ' +
                          'FROM CFGSIS ' +
                          'WHERE SIS_CODCFG IN ("CFG_BINEST") ' +
                          '  AND COALESCE(SIS_VALCFG, "") <> "" ' +
                          '  AND SIS_CODEMP IN ("' + LEmpresas.CommaText.Replace(',', '","') + '")';
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
    TFiservBinFuncoes.FreeAndNilDatasets(LConsulta);

    If Assigned(LEmpresas) Then
      FreeAndNil(LEmpresas);
  End;
end;

function TConciliacaoCartoes.RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa: String;
begin
  Result := 'Taxa de administração do registro importado difere da taxa cadastrada para a operadora.';

  If FConfiguracaoTaxaAdministrativa.Equals('2') Then
    Result := 'Taxa de administração do registro importado difere da taxa da movimentação do cartão.';
end;

function TConciliacaoCartoes.RetornaFiltrosDigitados: String;
  Var
    LStringList: TStringList;
begin
  Result := 'Data Inicial: ' + strDtaIni + #13 +
            'Data Final: ' + strDtaFim + #13;

  LStringList := Nil;
  Try
    If Length(arrEmpresa) > 0 Then
    Begin
      LStringList := TFiservBinFuncoes.ConverterArrayConsultaParaStringList(arrEmpresa);
      Result := Result + 'Empresas: ' + LStringList.Text;
      FreeAndNil(LStringList);
    End;

    If Length(arrPonVen) > 0 Then
    Begin
      LStringList := TFiservBinFuncoes.ConverterArrayConsultaParaStringList(arrPonVen);
      Result := Result + 'Pontos de Vendas: ' + LStringList.Text;
    End;
  Finally
    If Assigned(LStringList) THen
      FreeAndNil(LStringList);
  End;
end;

function TConciliacaoCartoes.RetornaInAutorizacaoFiltrar: String;
  Var
    LValor: String;
begin

  If Not TFiservBinFuncoes.fEmptyStr(FInAutorizacaoFiltrar) Then
    Exit(FInAutorizacaoFiltrar);

  Result := '""';

  cdsConCar.First;
  While Not cdsConCar.Eof Do
  Begin
    LValor := '"' + TFiservBinFuncoes.fStrZero(cdsConcar.FieldByName(objConcil.CampoCodigoAutorizacao).AsString, 6) + '"';

    If Pos(LValor, Result) > 0 Then
    Begin
      cdsConCar.Next;

      Continue;
    End;

    If Not TFiservBinFuncoes.fEmptyStr(objConcil.CampoIDTransacao) Then
      LValor := LValor + ',"' + cdsConcar.FieldByName(objConcil.CampoIDTransacao).AsString + '"';

    Result := Result + ',' + LValor;

    cdsConCar.Next;
  End;

  cdsConCar.First;
end;

function TConciliacaoCartoes.RetornaInNsuFiltrar: String;
  Var
    LValor: String;
begin

  If Not TFiservBinFuncoes.fEmptyStr(FInNsuFiltrar) Then
    Exit(FInNsuFiltrar);

  Result := '""';

  cdsConCar.First;
  While Not cdsConCar.Eof Do
  Begin
    LValor := '"' + TFiservBinFuncoes.fStrZero(cdsConcar.FieldByName(objConcil.CampoNumeroNSU).AsString, 14) + '"';

    If Pos(LValor, Result) > 0 Then
    Begin
      cdsConCar.Next;

      Continue;
    End;

    If Not TFiservBinFuncoes.fEmptyStr(objConcil.CampoIDTransacao) Then
      LValor := LValor + ',"' + cdsConcar.FieldByName(objConcil.CampoIDTransacao).AsString + '"';

    Result := Result + ',' + LValor;

    cdsConCar.Next;
  End;

  cdsConCar.First;
end;

function TConciliacaoCartoes.RetornaListaPVsParaFiltroLocate: String;
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

function TConciliacaoCartoes.RetornaParcelaCartao(AParcelaAtual,
  ATotalParcelas: String): String;
  Var
    LNumero: Integer;
begin
  If Not TryStrToInt(AParcelaAtual, LNumero) Then
    Exit('01/01');

  Result := TFiservBinFuncoes.fStrZero(LNumero.ToString, 2) + '/';

  If Not TryStrToInt(ATotalParcelas, LNumero) Then
    Exit(Result + LeftStr(Result, 2));

  Result := Result + TFiservBinFuncoes.fStrZero(LNumero.ToString, 2);
end;

function TConciliacaoCartoes.RetornaTaxaParaValidacao: Double;
begin
  Result := cdsBaiCar.FieldByName('CAR_PERDES').AsFloat;

  If FConfiguracaoTaxaAdministrativa.Equals('2') Then
    Result := cdsBaiCar.FieldByName('TAXA_ADM_ORIGINAL').AsFloat;

end;

function TConciliacaoCartoes.RetornaTextoInconsistenciaAtualizado(
  ATextoInconsistencia: String): String;
begin
  Result := ATextoInconsistencia;

  If Result.IsEmpty Then
    Exit;

  If Result.Equals('Cartão já foi baixado') Then
  Begin
    If Not blnAutomatica Then
      Exit(Result + ' manualmente');

    Result := Result + ' através de conciliação automática';
  End;
end;

procedure TConciliacaoCartoes.RetornaTotaisValoresQueSeraoBaixados(
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
    LRegistros := TFiservBinFuncoes.CriarClientDataSet(cdsBaiCar);
    LRegistros.Filter := 'MCA_MARDES=''M'' AND REGISTROTRANSFERENCIA=''N'' ';
    LRegistros.Filtered := True;

    LRegistros.First;
    While Not LRegistros.Eof Do
    Begin
      Inc(AQuantidadeBaixados);

      ABrutoBaixados := ABrutoBaixados + TFiservBinFuncoes.fFormataFloat(LRegistros.FieldByName('MCA_VALSTA').AsFloat, 2);
      ALiquidoBaixados := ALiquidoBaixados + TFiservBinFuncoes.fFormataFloat(LRegistros.FieldByName('MCA_VALREC').AsFloat, 2);

      LRegistros.Next;
    End;
  Finally
    TFiservBinFuncoes.FreeAndNilDatasets(LRegistros);
  End;
end;

function TConciliacaoCartoes.RetornaValorTolerancia(ACodEmp: String;ADefault: Double): Double;
begin
  If TFiservBinFuncoes.fEmptyStr(objConcil.CfgVlrTolerancia) Then
    Exit(ADefault);

  If TFiservBinFuncoes.fEmptyStr(ACodEmp) Then
    ACodEmp :=  VS_FuncoesExternas.fIRetEmpresaLogada;

  Result := VS_FuncoesExternas.fICfgSis(objConcil.CfgVlrTolerancia,varCurrency,ACodEmp);
end;

function TConciliacaoCartoes.PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(AValorBruto: Double;
                                                                               ARegistro: TDataSet;
                                                                               APercentual: Boolean = True): Boolean;
  Var
    LDiferenca: Double;
Begin
  LDiferenca := (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat - cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat);

  if APercentual then
    LDiferenca := LDiferenca -
                  (TFiservBinFuncoes.fFormataFloat(AValorBruto * (RetornaTaxaParaValidacao / 100), 2))
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

    TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_CHAVE_', AOperadora.ToUpperInvariant + '-' +
                                                                     FormatDateTime('yyyymmdd', ADataRelatorio) + '_' +
                                                                     FormatDateTime('hhmmss', AHoraRelatorio) + '-' +
                                                                     ACodigoOperador + '-' + ATipoRelatorio.ToUpperInvariant);
    TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAREL', ADataRelatorio);
    TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_HORREL', AHoraRelatorio);
    TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODOPE', ACodigoOperador);
    TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_OPERAD', AOperadora);
    TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPREL', ATipoRelatorio);
    TFiservBinFuncoes.SetaValorCampoDataset(LInserir, 'REL_FILREL', AFiltrosRelatorio + #13 +
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
    TFiservBinFuncoes.FreeAndNilDatasets(LInserir);
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
  Conciliado := 0;
end;

end.
