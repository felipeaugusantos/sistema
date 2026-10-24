unit untPagSeguroConciliacaoCartoes;

interface

Uses System.Classes, Vcl.Forms, System.Types, System.Sysutils, System.StrUtils,
     System.Variants, Data.DB, Vcl.Graphics, Vcl.Controls, System.Math,
     System.Generics.Collections,

     Uni, UniClientDataSet, cxProgressBar, frxClass, frxDBSet,

     untLibCartoesInterfacesTipos, untTLockLibCartoes, untTPagSeguroFuncoes,
     untTIndiceBuscaCartao;

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

    DescricaoAjuste,

    ChavePrimaria,

    AutoIncremMovCar: String;

    Conciliado: Integer;

    constructor Create;
  End;

  TListaRegistrosRelatorio = TObjectList<TItensRelatorioCartoes>;

type TConciliacaoCartoes = class
  cdsConCar,                             //DATASET DOS ARQUIVOS IMPORTADOS (EXCETO PagSeguro)
  cdsAjustes:  TUniClientDataSet;        //DATASET AJUSTES/CANCELAMENTOS

  FBandeiraCartao: String;
  objConcil  : TCamposConcil;

  blnAutomatica: Boolean;

  FTextoInconsistencia: String;

  FLiberacaoTransferencia: Boolean;

  FFiltrarAutorizacaoNSU: Boolean;
  FInAutorizacaoFiltrar: String;
  FInNsuFiltrar: String;

  FRelatorioConciliacao: TRelatorioConciliacao;

  FListaRegistrosRelatorio: TListaRegistrosRelatorio;

  FPossuiInconsistencia: Boolean;

  FBaixarAjustes,
  FObrigatorioCentroDeCustos: Boolean;

  FConfiguracaoTaxaAdministrativa: String;

  FFiltrosRelatorio: TFiltrosRelatorioBaixaCartoes;

  procedure pFiltraCartoes;
  procedure pFiltraCartoesBaixados;

  procedure MarcarCartaoEncontradoArquivo(AValorRecebido: Double;
                                          ARegistroAntecipado: Boolean;
                                          var ARegistroRelatorio: TItensRelatorioCartoes;
                                          AChaveConciliacao: String;
                                          ADatasetRegistro: TDataset;
                                          ATaxaDeAntecipacao: Double = 0);

  procedure MarcarCartaoEncontradoAPI(AValorRecebido: Double;
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

  function BuscaCartaoPorIDTransacao(AIDTransacao,
                                     ACodigoEmpresa,
                                     AParcela: String;
                                     ADataTransacao: TDateTime): Boolean;

  function BuscaCartaoBaixadoPorIDTransacao(AIDTransacao,
                                            ACodigoEmpresa,
                                            AParcela: String;
                                            ADataTransacao: TDateTime): Boolean;

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
                                                  ADatasetSelecionado: TDataset = Nil);

  procedure GravarRegistroDePixParaConciliacao(ARegistroRelatorio: TItensRelatorioCartoes);

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

  procedure AdicionaRegistrosDeTransferencias(AFiltroTransferencia: String;
                                              AFiltroEmpresaCfg: String = '');

  //Req: 445076 - buscas via TIndiceBuscaCartao (ver untTIndiceBuscaCartao)
  procedure CarregaIndicesBusca;

  procedure DestroiDicionariosBusca;

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

    FIdxBaiCarComEmpresa,
    FIdxBaiCarSemEmpresa,
    FIdxBaiCarCCDComEmpresa,
    FIdxBaiCarNSUComEmpresa,
    FIdxBaiCarCCDSemEmpresa,
    FIdxBaiCarNSUSemEmpresa,

    FIdxBaixadComEmpresa,
    FIdxBaixadCCDComEmpresa,
    FIdxBaixadNSUComEmpresa,
    FIdxBaixadSemEmpresa,
    FIdxBaixadCCDSemEmpresa,
    FIdxBaixadNSUSemEmpresa: TIndiceBuscaCartao;

    property CartoesConciliar: String read FCartoesConciliar write FCartoesConciliar;

  public
    cdsBaiCar,                    //DATASET PARA MARCAÇÃO DE REGISTROS CONCILIADOS
    cdsBaixad: TUniClientDataSet; //DATASET PARA BUSCAR SE FOI BAIXADO

    blnInconsist: Boolean;
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
uses untPagSeguroDigPeriodo, untPagSeguroFiltroInconsistencias,
     untLibCartoesGravando, untTLibCartoesMovCar, untLibCartoesConstantes;

function TConciliacaoCartoes.BuscaCartaoBaixadoPorIDTransacao(AIDTransacao,
  ACodigoEmpresa, AParcela: String; ADataTransacao: TDateTime): Boolean;
  Var
    LDtaCupFormatado: String;
begin
  Result := False;

  LDtaCupFormatado := TIndiceBuscaCartao.FormataData(ADataTransacao);

  If Not ACodigoEmpresa.IsEmpty Then
  Begin
    Result := FIdxBaixadCCDComEmpresa.Localizar([UpperCase(AIDTransacao), AParcela, LDtaCupFormatado, ACodigoEmpresa]);

    If Not Result Then
      Result := FIdxBaixadNSUComEmpresa.Localizar([UpperCase(AIDTransacao), AParcela, LDtaCupFormatado, ACodigoEmpresa]);
  End;

  If Not Result Then
  Begin
    Result := FIdxBaixadCCDSemEmpresa.Localizar([UpperCase(AIDTransacao), AParcela, LDtaCupFormatado]);

    If Not Result Then
      Result := FIdxBaixadNSUSemEmpresa.Localizar([UpperCase(AIDTransacao), AParcela, LDtaCupFormatado]);
  End;

  If Result Then
    blnAutomatica := Not cdsBaixad.FieldByName('MCA_CHACON').AsString.IsEmpty;
end;

function TConciliacaoCartoes.BuscaCartaoPorIDTransacao(AIDTransacao,
  ACodigoEmpresa, AParcela: String; ADataTransacao: TDateTime): Boolean;
  Var
    LDtaCupFormatado: String;
begin
  Result := False;

  LDtaCupFormatado := TIndiceBuscaCartao.FormataData(ADataTransacao);

  If Not ACodigoEmpresa.IsEmpty Then
  Begin
    Result := FIdxBaiCarCCDComEmpresa.Localizar([UpperCase(AIDTransacao), AParcela, LDtaCupFormatado, ACodigoEmpresa, 'D']);

    If Not Result Then
      Result := FIdxBaiCarNSUComEmpresa.Localizar([UpperCase(AIDTransacao), AParcela, LDtaCupFormatado, ACodigoEmpresa, 'D']);
  End;

  If Not Result Then
  Begin
    Result := FIdxBaiCarCCDSemEmpresa.Localizar([UpperCase(AIDTransacao), AParcela, LDtaCupFormatado, 'D']);

    If Not Result Then
      Result := FIdxBaiCarNSUSemEmpresa.Localizar([UpperCase(AIDTransacao), AParcela, LDtaCupFormatado, 'D']);
  End;
end;

procedure TConciliacaoCartoes.CarregaIndicesBusca;
begin
  DestroiDicionariosBusca;

  FIdxBaiCarComEmpresa    := TIndiceBuscaCartao.Create(cdsBaiCar, 'AUTOINC', ['MCA_NUMCCD', 'MCA_NUMNSU', 'PARDUP', 'MCA_DTACUP', 'MCA_EMPRCX', 'MCA_MARDES']);
  FIdxBaiCarSemEmpresa    := TIndiceBuscaCartao.Create(cdsBaiCar, 'AUTOINC', ['MCA_NUMCCD', 'MCA_NUMNSU', 'PARDUP', 'MCA_DTACUP', 'MCA_MARDES']);
  FIdxBaiCarCCDComEmpresa := TIndiceBuscaCartao.Create(cdsBaiCar, 'AUTOINC', ['MCA_NUMCCD', 'PARDUP', 'MCA_DTACUP', 'MCA_EMPRCX', 'MCA_MARDES']);
  FIdxBaiCarNSUComEmpresa := TIndiceBuscaCartao.Create(cdsBaiCar, 'AUTOINC', ['MCA_NUMNSU', 'PARDUP', 'MCA_DTACUP', 'MCA_EMPRCX', 'MCA_MARDES']);
  FIdxBaiCarCCDSemEmpresa := TIndiceBuscaCartao.Create(cdsBaiCar, 'AUTOINC', ['MCA_NUMCCD', 'PARDUP', 'MCA_DTACUP', 'MCA_MARDES']);
  FIdxBaiCarNSUSemEmpresa := TIndiceBuscaCartao.Create(cdsBaiCar, 'AUTOINC', ['MCA_NUMNSU', 'PARDUP', 'MCA_DTACUP', 'MCA_MARDES']);

  //VALIDADO fora da chave: o Locate original nao o considerava
  FIdxBaixadComEmpresa    := TIndiceBuscaCartao.Create(cdsBaixad, 'AUTOINC', ['MCA_NUMCCD', 'MCA_NUMNSU', 'MCA_PARCEL', 'MCA_DTACUP', 'MCA_EMPRCX']);
  FIdxBaixadCCDComEmpresa := TIndiceBuscaCartao.Create(cdsBaixad, 'AUTOINC', ['MCA_NUMCCD', 'MCA_PARCEL', 'MCA_DTACUP', 'MCA_EMPRCX']);
  FIdxBaixadNSUComEmpresa := TIndiceBuscaCartao.Create(cdsBaixad, 'AUTOINC', ['MCA_NUMNSU', 'MCA_PARCEL', 'MCA_DTACUP', 'MCA_EMPRCX']);
  FIdxBaixadSemEmpresa    := TIndiceBuscaCartao.Create(cdsBaixad, 'AUTOINC', ['MCA_NUMCCD', 'MCA_NUMNSU', 'MCA_PARCEL', 'MCA_DTACUP']);
  FIdxBaixadCCDSemEmpresa := TIndiceBuscaCartao.Create(cdsBaixad, 'AUTOINC', ['MCA_NUMCCD', 'MCA_PARCEL', 'MCA_DTACUP']);
  FIdxBaixadNSUSemEmpresa := TIndiceBuscaCartao.Create(cdsBaixad, 'AUTOINC', ['MCA_NUMNSU', 'MCA_PARCEL', 'MCA_DTACUP']);
end;

function TConciliacaoCartoes.ConfiguracoesAjustesEstaoIncompletas(
  ACodigoEmpresa: String): String;
begin
  Result := 'S';

  If ACodigoEmpresa.Trim.IsEmpty Then
    Exit;

  If TPagSeguroFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgPortadorAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If TPagSeguroFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgPlanoDeContasAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If TPagSeguroFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.CfgFornecedorAjustes, varString, ACodigoEmpresa)) Then
    Exit;

  If Not FObrigatorioCentroDeCustos Then
    Exit('N');

  If TPagSeguroFuncoes.fEmptyStr(VS_FuncoesExternas.fICfgSis(objConcil.strEventoCancelamentoAjuste, varString, ACodigoEmpresa)) Then
    Exit;

  Result := 'N';
end;

constructor TConciliacaoCartoes.Create;
begin
  blnReabre  := False;

  FListaRegistrosRelatorio := TListaRegistrosRelatorio.Create;

  FAjustesJaConciliados := True;
  blnAutomatica  := False;

  FLancarAjustesACredito := TPagSeguroFuncoes.RetornaValorCfg('CFG_AJUCRE').Equals('S');
  FTemAjusteACredito := False;

  FCartoesConciliar := '';

  FLiberacaoTransferencia := TPagSeguroFuncoes.RetornaValorCfg('CFG_USAAUT').Equals('S');

  FFiltrarAutorizacaoNSU := False;

  objConcil.CodigoEmpresaFixaParaBaixa := '';

  FBaixarAjustes := VS_FuncoesExternas.fICfgSis('BAIDEB', varBoolean);
  FObrigatorioCentroDeCustos := VS_FuncoesExternas.fICfgSis('CTPOBE', varBoolean);

  FConfiguracaoTaxaAdministrativa := TPagSeguroFuncoes.RetornaValorCfg('CFG_VLDTAX');

  FIdxBaiCarComEmpresa := Nil;
  FIdxBaiCarSemEmpresa := Nil;
  FIdxBaiCarCCDComEmpresa := Nil;
  FIdxBaiCarNSUComEmpresa := Nil;
  FIdxBaiCarCCDSemEmpresa := Nil;
  FIdxBaiCarNSUSemEmpresa := Nil;

  FIdxBaixadComEmpresa := Nil;
  FIdxBaixadCCDComEmpresa := Nil;
  FIdxBaixadNSUComEmpresa := Nil;
  FIdxBaixadSemEmpresa := Nil;
  FIdxBaixadCCDSemEmpresa := Nil;
  FIdxBaixadNSUSemEmpresa := Nil;
end;

procedure TConciliacaoCartoes.DestroiDicionariosBusca;
begin
  TPagSeguroFuncoes.FreeAndNilObjeto(FIdxBaiCarComEmpresa);
  TPagSeguroFuncoes.FreeAndNilObjeto(FIdxBaiCarSemEmpresa);
  TPagSeguroFuncoes.FreeAndNilObjeto(FIdxBaiCarCCDComEmpresa);
  TPagSeguroFuncoes.FreeAndNilObjeto(FIdxBaiCarNSUComEmpresa);
  TPagSeguroFuncoes.FreeAndNilObjeto(FIdxBaiCarCCDSemEmpresa);
  TPagSeguroFuncoes.FreeAndNilObjeto(FIdxBaiCarNSUSemEmpresa);

  TPagSeguroFuncoes.FreeAndNilObjeto(FIdxBaixadComEmpresa);
  TPagSeguroFuncoes.FreeAndNilObjeto(FIdxBaixadCCDComEmpresa);
  TPagSeguroFuncoes.FreeAndNilObjeto(FIdxBaixadNSUComEmpresa);
  TPagSeguroFuncoes.FreeAndNilObjeto(FIdxBaixadSemEmpresa);
  TPagSeguroFuncoes.FreeAndNilObjeto(FIdxBaixadCCDSemEmpresa);
  TPagSeguroFuncoes.FreeAndNilObjeto(FIdxBaixadNSUSemEmpresa);
end;

destructor TConciliacaoCartoes.Destroy;
begin
  TPagSeguroFuncoes.FreeAndNilDatasets(cdsAjustes);
  TPagSeguroFuncoes.FreeAndNilDatasets(cdsConCar);
  TPagSeguroFuncoes.FreeAndNilDatasets(cdsBaiCar);
  TPagSeguroFuncoes.FreeAndNilDatasets(cdsBaixad);

  If Assigned(lstDtaCad) Then
    FreeAndNil(lstDtaCad);

  If Assigned(FRelatorioConciliacao) Then
    FreeAndNil(FRelatorioConciliacao);

  If Assigned(FListaRegistrosRelatorio) Then
    FreeAndNil(FListaRegistrosRelatorio);

  DestroiDicionariosBusca;

  inherited;
end;

function TConciliacaoCartoes.fDigPeriodo(strDescricaoLabel: String = ''): Boolean;
var
  frmPagSeguroDigPeriodo: TfrmPagSeguroDigPeriodo;
  LConfiguracoesValidadasEstabelecimento: String;

  LContadorItem: Integer;
Begin
  LConfiguracoesValidadasEstabelecimento := '"CFG_PAGEST","CFG_PAGLNK"';

  If fExisteEstabelecimentosDuplicados(LConfiguracoesValidadasEstabelecimento) Then
  Begin
    LConfiguracoesValidadasEstabelecimento :=
      LConfiguracoesValidadasEstabelecimento
        .Replace(' ', '')
        .Replace('(', '')
        .Replace(')', '')
        .Replace(',', '/');

    TPagSeguroFuncoes.fMensagem('AVISO',
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

  frmPagSeguroDigPeriodo := Nil;
  Result := False;
  While Not Result Do
  Begin
    Try
      TPagSeguroFuncoes.pCriarFormularios(TfrmPagSeguroDigPeriodo, frmPagSeguroDigPeriodo);
      frmPagSeguroDigPeriodo.Caption   := 'Conciliação de Cartões';
      frmPagSeguroDigPeriodo.objConcil := objConcil;
      If Not strDescricaoLabel.IsEmpty Then
        frmPagSeguroDigPeriodo.lblPeriodoConciliacao.Caption := strDescricaoLabel;

      frmPagSeguroDigPeriodo.ShowModal;
      If Not frmPagSeguroDigPeriodo.blnConfirma Then
      Begin
        frmPagSeguroDigPeriodo.objLockEstabelecimento.pDestravarTodos;
        Exit;
      End;

      //Data e array para filtrar os registros de arquivos de conciliação
      dtaDtaIni := StrtoDate(frmPagSeguroDigPeriodo.mskDtaIniConcil.Text);
      dtaDtaFim := StrtoDate(frmPagSeguroDigPeriodo.mskDtaFinConcil.Text);
      strDtaIni := frmPagSeguroDigPeriodo.mskDtaIniConcil.Text;
      strDtaFim := frmPagSeguroDigPeriodo.mskDtaFinConcil.Text;

      SetLength(arrEmpresa, Length(frmPagSeguroDigPeriodo.arrEmpresa));
      For LContadorItem := 0 To High(frmPagSeguroDigPeriodo.arrEmpresa) Do
        arrEmpresa[LContadorItem].strCodigo := frmPagSeguroDigPeriodo.arrEmpresa[LContadorItem].strCodigo;

      SetLength(arrPonVen, Length(frmPagSeguroDigPeriodo.arrPonVen));
      For LContadorItem := 0 To High(frmPagSeguroDigPeriodo.arrPonVen) Do
        arrPonVen[LContadorItem].strCodigo := frmPagSeguroDigPeriodo.arrPonVen[LContadorItem].strCodigo;

      FobjLockEstabelecimento := frmPagSeguroDigPeriodo.objLockEstabelecimento;
    Finally
      If Assigned(frmPagSeguroDigPeriodo) Then
        FreeAndNil(frmPagSeguroDigPeriodo);

      VS_FuncoesExternas.pITrimAppMemorySize;
    End;

    If dtaDtaFim - dtaDtaIni > 365 Then
      TPagSeguroFuncoes.fMensagem('ATENÇÃO', 'O filtro para conciliação não pode ser maior que 365 dias (1 ano)!', ['&OK'])
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

      Result := Result + ' TRIM(LEADING 0 FROM ' + objConcil.CampoEstabelecimento + ') IN (' + LEstabelecimentos + ') ';
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
  AGravaCampoValorBruto: Boolean = False; ADatasetSelecionado: TDataset = Nil);
begin
  If ARegistroRelatorio.Conciliado = 1 Then
    Exit;

  If Not FBaixarAjustes Then
    Exit;

  cdsBaiCar.Last;
  cdsBaiCar.Append;
  cdsBaiCar.FieldByName('AUTOINC').AsString     := VS_FuncoesExternas.fIRetEmpresaLogada +
                                                   TPagSeguroFuncoes.fStrZero(ARegistroRelatorio.CodigoAutorizacao, 10) +
                                                   TPagSeguroFuncoes.fRetSomenteNumeros(ARegistroRelatorio.Parcela) +
                                                   VS_FuncoesExternas.fIRetEmpresaLogada;

  cdsBaiCar.FieldByName('NRODUP').AsString      := TPagSeguroFuncoes.fStrZero(ARegistroRelatorio.CodigoAutorizacao, 06);
  cdsBaiCar.FieldByName('PARDUP').AsString      := TPagSeguroFuncoes.fGetLetraAlfa(StrtoInt(ARegistroRelatorio.Parcela));
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

  cdsBaiCar.FieldByName('MCA_NUMNSU').AsString  := TPagSeguroFuncoes.fStrZero(ARegistroRelatorio.NumeroNSU, 14);

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
  cdsBaiCar.FieldByName('FOR_NOMFOR').AsString  := TPagSeguroFuncoes.IIF(cdsBaiCar.FieldByName('CAR_FORTAX').AsString.IsEmpty, '', TPagSeguroFuncoes.RetornaNomeFornecedor(cdsBaiCar.FieldByName('CAR_FORTAX').AsString));
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

  If Assigned(ADatasetSelecionado) Then
    cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString  := fRetornaChaveConciliacao(ADatasetSelecionado)
  Else If Assigned(cdsAjustes) Then
    cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString  := fRetornaChaveConciliacao(cdsAjustes);

  cdsBaiCar.FieldByName('REGISTROTRANSFERENCIA').AsString := 'N';
  cdsBaiCar.FieldByName('REGISTROPIXCARTAO').AsString     := 'N';

  If ARegistroRelatorio.RegistroTransferencia.Equals('S') Then
  Begin
    cdsBaiCar.FieldByName('PORTADORTRANSFERENCIA').AsString := ARegistroRelatorio.PortadorTransferencia;
    cdsBaiCar.FieldByName('PLANODECONTASTRANSFERENCIA').AsString := ARegistroRelatorio.PlanoContasTransferenciaCredito;
    cdsBaiCar.FieldByName('CENTRODECUSTOSTRANSFERENCIA').AsString := ARegistroRelatorio.CentroCustosTransferencia;
    cdsBaiCar.FieldByName('REGISTROTRANSFERENCIA').AsString := 'S';
  End;

  cdsBaiCar.Post;

  FAjustesJaConciliados := False;
end;

procedure TConciliacaoCartoes.GravarRegistroDePixParaConciliacao(
  ARegistroRelatorio: TItensRelatorioCartoes);
begin
  If ARegistroRelatorio.Conciliado = 1 Then
    Exit;

  cdsBaiCar.Last;
  cdsBaiCar.Append;
  cdsBaiCar.FieldByName('AUTOINC').AsString     := VS_FuncoesExternas.fIRetEmpresaLogada +
                                                   RightStr(ARegistroRelatorio.CodigoAutorizacao, 17);

  cdsBaiCar.FieldByName('NRODUP').AsString      := LeftStr(ARegistroRelatorio.CodigoAutorizacao, 06);
  cdsBaiCar.FieldByName('PARDUP').AsString      := TPagSeguroFuncoes.fGetLetraAlfa(StrtoInt(ARegistroRelatorio.Parcela));
  cdsBaiCar.FieldByName('MCA_NUMDUP').AsString  := cdsBaiCar.FieldByName('NRODUP').AsString +
                                                   cdsBaiCar.FieldByName('PARDUP').AsString;
  cdsBaiCar.FieldByName('EMPLOC').AsString      := ARegistroRelatorio.CodigoEmpresa;
  cdsBaiCar.FieldByName('MCA_CODEMP').AsString  := ARegistroRelatorio.CodigoEmpresa;
  cdsBaiCar.FieldByName('MCA_EMPRCX').AsString  := ARegistroRelatorio.CodigoEmpresa;
  cdsBaiCar.FieldByName('MCA_DTAVEN').AsDateTime := ARegistroRelatorio.DataPagamento;
  cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat   := ARegistroRelatorio.ValorBruto;
  cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat   := 0.00;

  cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat   := ARegistroRelatorio.ValorBruto;

  cdsBaiCar.FieldByName('MCA_VALORI').AsFloat   := ARegistroRelatorio.ValorBruto;
  cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat   := ARegistroRelatorio.ValorBruto;
  cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat   := 0.000000;
  cdsBaiCar.FieldByName('MCA_CODCLI').AsString  := '00000000';
  cdsBaiCar.FieldByName('CLI_NOMCLI').AsString  := 'PIX RECEBIDO VIA QRCODE';
  cdsBaiCar.FieldByName('MCA_DTACAD').AsDateTime := ARegistroRelatorio.DataVenda;
  cdsBaiCar.FieldByName('MCA_NUMCCD').AsString  := ARegistroRelatorio.CodigoAutorizacao;
  cdsBaiCar.FieldByName('MCA_RESCAI').AsInteger := 0;
  cdsBaiCar.FieldByName('MCA_CODCAR').Clear;
  cdsBaiCar.FieldByName('CAR_DESCAR').Clear;

  cdsBaiCar.FieldByName('MCA_NUMNSU').AsString  := ARegistroRelatorio.NumeroNSU;

  cdsBaiCar.FieldByName('MCA_DTACUP').AsDateTime := ARegistroRelatorio.DataVenda;
  cdsBaiCar.FieldByName('MCA_MARDES').AsString  := 'M';
  cdsBaiCar.FieldByName('MCA_VALREC').AsFloat   := ARegistroRelatorio.ValorBruto;

  cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime := ARegistroRelatorio.DataPagamento;
  cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_AJUTOT').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_AJUSEL').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_ZERATX').AsString  := 'S';
  cdsBaiCar.FieldByName('MCA_ANTECI').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_SELQTD').AsInteger := 0;
  cdsBaiCar.FieldByName('MCA_AJUSTE').AsString  := 'N';
  cdsBaiCar.FieldByName('MCA_ESTABE').AsString  := ARegistroRelatorio.CodigoEstabelecimento;

  cdsBaiCar.FieldByName('CAR_PORBAI').Clear;
  cdsBaiCar.FieldByName('CAR_PORTAX').Clear;
  cdsBaiCar.FieldByName('CAR_PORBAD').Clear;
  cdsBaiCar.FieldByName('CAR_FORTAX').Clear;
  cdsBaiCar.FieldByName('FOR_NOMFOR').Clear;
  cdsBaiCar.FieldByName('CAR_CTABAI').Clear;
  cdsBaiCar.FieldByName('CAR_CTATAX').Clear;
  cdsBaiCar.FieldByName('CAR_CTABAD').Clear;
  cdsBaiCar.FieldByName('CAR_EVEDEB').Clear;
  cdsBaiCar.FieldByName('MCA_EVECAN').Clear;
  cdsBaiCar.FieldByName('SIT_CAD').AsString     := 'COMPLETO';

  cdsBaiCar.FieldByName('HISTORICO_BAIXA').Clear;

  cdsBaiCar.FieldByName('NEGOCIACAO').AsString  := 'N';

  cdsBaiCar.FieldByName('REGISTROTRANSFERENCIA').AsString := 'N';
  cdsBaiCar.FieldByName('REGISTROPIXCARTAO').AsString     := 'S';

  cdsBaiCar.Post;
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

        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_RELINC', FRelatorioConciliacao.AutoIncremRelatorio);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_NOMARQ', LRegistroRelatorio.NomeArquivo);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODEST', LRegistroRelatorio.CodigoEstabelecimento);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODEMP', LRegistroRelatorio.CodigoEmpresa);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESCRI', LRegistroRelatorio.Descricao);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMNSU', LRegistroRelatorio.NumeroNSU);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODAUT', LRegistroRelatorio.CodigoAutorizacao);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_PARCEL', LRegistroRelatorio.Parcela);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_TOTPAR', LRegistroRelatorio.TotalParcelas);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAPAG', LRegistroRelatorio.DataPagamento);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTA_CV', LRegistroRelatorio.DataVenda);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAVEN', LRegistroRelatorio.DataVencimento);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_RESVEN', LRegistroRelatorio.ResumoVenda);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODBAN', LRegistroRelatorio.CodigoBandeira);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESBAN', LRegistroRelatorio.DescricaoBandeira);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_SEQMCA', LRegistroRelatorio.AutoIncremMovCar);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMCAR', LRegistroRelatorio.NumeroCartao);

        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALBRU', LRegistroRelatorio.ValorBruto);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALLIQ', LRegistroRelatorio.ValorLiquido);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALTAX', LRegistroRelatorio.ValorTaxas);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALFRE', LRegistroRelatorio.ValorFrete);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_VALAJU', LRegistroRelatorio.ValorAjustes);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_PERTAX', LRegistroRelatorio.PercentualTaxa);

        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPCAR', LRegistroRelatorio.TipoCartao);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPREG', LRegistroRelatorio.TipoDoRegistro);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_SOMTOT', LRegistroRelatorio.SomarNoTotal);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_INCOMP', LRegistroRelatorio.RegistroIncompleto);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_PORDEB', LRegistroRelatorio.PortadorDebito);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_PORCRE', LRegistroRelatorio.PortadorCredito);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_REGNEG', LRegistroRelatorio.RegistroNegociacao);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_NUMNEG', LRegistroRelatorio.NumeroNegociacao);
        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_DESAJU', LRegistroRelatorio.DescricaoAjuste);

        TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_CONCIL', LRegistroRelatorio.Conciliado);

        LInserir.Post;

        If Not blnInconsist Then
          blnInconsist := MatchStr(LRegistroRelatorio.TipoDoRegistro, ['INCONSISTENCIA', 'AJUSTE']);

        TPagSeguroFuncoes.pStepStatusGravacao(prgStatus);
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

procedure TConciliacaoCartoes.MarcarCartaoEncontradoAPI(AValorRecebido: Double;
  ARegistroAntecipado: Boolean; var ARegistroRelatorio: TItensRelatorioCartoes;
  AChaveConciliacao: String; ADatasetRegistro: TDataset;
  ATaxaDeAntecipacao: Double);
begin
  //Nesse caso, as regras e campos da API são idênticas aos arquivos
  MarcarCartaoEncontradoArquivo(AValorRecebido,
                                ARegistroAntecipado,
                                ARegistroRelatorio,
                                AChaveConciliacao,
                                ADatasetRegistro,
                                ATaxaDeAntecipacao);
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

  LValorAjuste := TPagSeguroFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat, 2) - TPagSeguroFuncoes.fFormataFloat(AValorRecebido, 2);
  LValorTaxa := TPagSeguroFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat, 2);

  LParcelaDivergenteSemTaxa := LValorAjuste < 0;
  If LParcelaDivergenteSemTaxa Then
    LParcelaDivergenteSemTaxa := LValorTaxa = 0;

  cdsBaiCar.Edit;

  If Not TPagSeguroFuncoes.fEmptyStr(AChaveConciliacao) Then
  Begin
    cdsBaiCar.FieldByName('MCA_ESTABE').AsString := ADatasetRegistro.FieldByName('PAG_CODEST').AsString;
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

    cdsBaiCar.FieldByName('MCA_VALREC').AsFloat := TPagSeguroFuncoes.IIF(LParcelaDivergenteSemTaxa,
                                                                          TPagSeguroFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat,2),
                                                                          TPagSeguroFuncoes.fFormataFloat(AValorRecebido, 2));

    cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime := ADatasetRegistro.FieldByName('PAG_DTAPAG').AsDateTime;

    cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat    := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;

    If (Not LParcelaDivergenteSemTaxa) Then
      cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat  := TPagSeguroFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat -
                                                                           TPagSeguroFuncoes.fFormataFloat(AValorRecebido, 2), 2);

    cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat    := (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat /
                                                       cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100;
    If ARegistroAntecipado Then
    Begin
      cdsBaiCar.FieldByName('MCA_ANT_SN').AsString := 'S';
      cdsBaiCar.FieldByName('MCA_ANTECI').AsFloat  := AValorRecebido;
      cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat  := TPagSeguroFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat -
                                                      AValorRecebido - LValorTaxa, 2);
      If cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat <= 0 Then
        cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat := 0;

      If ATaxaDeAntecipacao > 0 Then
        cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat := ATaxaDeAntecipacao;

      cdsBaiCar.FieldByName('MCA_TAXANT').AsFloat  := TPagSeguroFuncoes.fFormataFloat(LValorTaxa, 2);
    End;

    cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := TPagSeguroFuncoes.fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat, 2);
    cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat  := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
    cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat  := 1;
    cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat  := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;

    If Not TPagSeguroFuncoes.fEmptyStr(objConcil.strChavePrimaria) Then
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

  If Not TPagSeguroFuncoes.fEmptyStr(FBandeiraCartao) Then
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

  If TPagSeguroFuncoes.fEmptyStr(objConcil.strChavePrimaria) Then
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

  If Not TPagSeguroFuncoes.fEmptyStr(strEmpresaConfiguracao) Then
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
      TPagSeguroFuncoes.pProcessMessages;

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
          cdsBaiCar.FieldByName('FOR_NOMFOR').AsString := TPagSeguroFuncoes.RetornaNomeFornecedor(qryConsulta.FieldByName('CON_FORTAX').AsString);

          cdsBaiCar.FieldByName('DESC_EVE_CREDITO').AsString := TPagSeguroFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVECRE').AsString);
          cdsBaiCar.FieldByName('DESC_EVE_TAXA').AsString    := TPagSeguroFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVETAX').AsString);
          cdsBaiCar.FieldByName('DESC_EVE_DEBITO').AsString  := TPagSeguroFuncoes.RetornaNomeCentroDeCustos(qryConsulta.FieldByName('CON_EVEDEB').AsString);

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

    TPagSeguroFuncoes.FreeAndNilDatasets(qryConsulta);
  End;
end;

procedure TConciliacaoCartoes.pCalculaPeriodoFiltro(strCampo: String);
begin
  If Assigned(lstDtaCad) Then
    FreeAndNil(lstDtaCad);
  lstDtaCad := TStringList.Create;
  lstDtaCad.Sorted := True;
  lstDtaCad.Duplicates := dupIgnore;

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

    LDtaCupFormatado: String;
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

  LDtaCupFormatado := FormatDateTime('yyyymmdd', dtaDtaCup);

  If (Not strCodEmp.IsEmpty) And (Not TPagSeguroFuncoes.fEmptyStr(strNumCCD)) And (Not TPagSeguroFuncoes.fEmptyStr(strNumNSU)) Then
  Begin
    If FIdxBaiCarComEmpresa.Localizar([UpperCase(strNumCCD), UpperCase(strNumNSU), strParcel, LDtaCupFormatado, strCodEmp, 'D']) Then
      Result := True;
  End;

  If Not Result Then
  Begin
    If (Not TPagSeguroFuncoes.fEmptyStr(strNumCCD)) And (Not TPagSeguroFuncoes.fEmptyStr(strNumNSU)) Then
    Begin
      If FIdxBaiCarSemEmpresa.Localizar([UpperCase(strNumCCD), UpperCase(strNumNSU), strParcel, LDtaCupFormatado, 'D']) Then
        Result := True;

      LChaveCompletaSemEmpresa := Result;
    End;
  End;

  If (Not TPagSeguroFuncoes.fEmptyStr(strCodEmp)) And (Not LChaveCompletaSemEmpresa) Then
  Begin
    If (Not Result) And (Not TPagSeguroFuncoes.fEmptyStr(strNumCCD))  Then
    Begin
      If FIdxBaiCarCCDComEmpresa.Localizar([UpperCase(strNumCCD), strParcel, LDtaCupFormatado, strCodEmp, 'D']) Then
        Result := True;
    End;

    {********************************************}
    {* ALGUMAS OPERADORAS UTILIZAM O MESMO NSU  *}
    {* MUITAS VEZES. ENTÃO, ANTES DE PESQUISAR  *}
    {* PELO NSU, VERIFICA SE A AUTORIZAÇÃO ESTÁ *}
    {* BAIXADA.                                 *}
    {*****************************************AJ*}
    If (blnPesquisaBaixado) And (intConcil = 0) And
       ((Not Result) Or ((Result) And (Not fBetween(cdsBaicar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto, -LTolerancia, LTolerancia)))) Then
    Begin
      Result := (Not TPagSeguroFuncoes.fEmptyStr(strNumCCD)) And
                (fBuscaCartaoBaixado(strNumCCD, strNumNSU, strCodEmp, strParcel, dtaDtaCup, True));

      If Result Then
      Begin
        Result    := False;
        FTextoInconsistencia := 'Cartão já foi baixado';
        Exit;
      End;
    End;

    If (Not Result) And (Not TPagSeguroFuncoes.fEmptyStr(strNumNSU))  Then
    Begin
      If FIdxBaiCarNSUComEmpresa.Localizar([UpperCase(strNumNSU), strParcel, LDtaCupFormatado, strCodEmp, 'D']) Then
        Result := True;
    End;
  End;

  If (Not Result) Or (LChaveCompletaSemEmpresa) Then
  Begin

    If (Not Result) And (Not TPagSeguroFuncoes.fEmptyStr(strNumCCD))  Then
    Begin
      If FIdxBaiCarCCDSemEmpresa.Localizar([UpperCase(strNumCCD), strParcel, LDtaCupFormatado, 'D']) Then
        Result := True;
    End;

    {********************************************}
    {* ALGUMAS OPERADORAS UTILIZAM O MESMO NSU  *}
    {* MUITAS VEZES. ENTÃO, ANTES DE PESQUISAR  *}
    {* PELO NSU, VERIFICA SE A AUTORIZAÇÃO ESTÁ *}
    {* BAIXADA.                                 *}
    {*****************************************AJ*}
    If (blnPesquisaBaixado) And (intConcil = 0) And
       ((Not Result) Or ((Result) And (Not fBetween(cdsBaicar.FieldByName('MCA_VALSTA').AsFloat - LValorBruto, -LTolerancia, LTolerancia)))) Then
    Begin
      Result := (Not TPagSeguroFuncoes.fEmptyStr(strNumCCD)) And
                (fBuscaCartaoBaixado(strNumCCD, strNumNSU, strCodEmp, strParcel, dtaDtaCup, True));

      If Result Then
      Begin
        Result := False;
        FTextoInconsistencia := 'Cartão já foi baixado';
        Exit;
      End;
    End;

    If (Not Result) And (Not TPagSeguroFuncoes.fEmptyStr(strNumCCD))  Then
    Begin
      If FIdxBaiCarCCDSemEmpresa.Localizar([UpperCase(strNumCCD), strParcel, LDtaCupFormatado, 'D']) Then
        Result := True;
    End;
  End;
end;

function TConciliacaoCartoes.fBuscaCartaoBaixado(strNumCCD, strNumNSU,
  strCodEmp, strParcel: String; dtaDtaCup: TDateTime;
  blnValidaValorBruto: Boolean = False; AValorBruto: Double = 0.00): Boolean;
  Var
    LTolerancia,
    LValorBruto: Double;

    LDtaCupFormatado: String;
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

  LDtaCupFormatado := FormatDateTime('yyyymmdd', dtaDtaCup);

  If (Not TPagSeguroFuncoes.fEmptyStr(strCodEmp)) Then
  Begin
    If (Not TPagSeguroFuncoes.fEmptyStr(strNumCCD)) And (Not TPagSeguroFuncoes.fEmptyStr(strNumNSU)) Then
    Begin
      If FIdxBaixadComEmpresa.Localizar([UpperCase(strNumCCD), UpperCase(strNumNSU), strParcel, LDtaCupFormatado, strCodEmp]) Then
        Result := True;
    End;

    If (not Result) And (Not TPagSeguroFuncoes.fEmptyStr(strNumCCD)) Then
    Begin
      If FIdxBaixadCCDComEmpresa.Localizar([UpperCase(strNumCCD), strParcel, LDtaCupFormatado, strCodEmp]) Then
        Result := True;
    End;

    If (not Result) And (Not TPagSeguroFuncoes.fEmptyStr(strNumNSU)) Then
    Begin
      If FIdxBaixadNSUComEmpresa.Localizar([UpperCase(strNumNSU), strParcel, LDtaCupFormatado, strCodEmp]) Then
        Result := True;
    End;
  End;

  If Not Result Then
  Begin
    If (Not TPagSeguroFuncoes.fEmptyStr(strNumCCD)) And (Not TPagSeguroFuncoes.fEmptyStr(strNumNSU)) Then
    Begin
      If FIdxBaixadSemEmpresa.Localizar([UpperCase(strNumCCD), UpperCase(strNumNSU), strParcel, LDtaCupFormatado]) Then
        Result := True;
    End;

    If (not Result) And (Not TPagSeguroFuncoes.fEmptyStr(strNumCCD)) Then
    Begin
      If FIdxBaixadCCDSemEmpresa.Localizar([UpperCase(strNumCCD), strParcel, LDtaCupFormatado]) Then
        Result := True;
    End;

    If (not Result) And (Not TPagSeguroFuncoes.fEmptyStr(strNumNSU)) Then
    Begin
      If FIdxBaixadNSUSemEmpresa.Localizar([UpperCase(strNumNSU), strParcel, LDtaCupFormatado]) Then
        Result := True;
    End;
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
        Begin
          If FIdxBaixadComEmpresa.Localizar([UpperCase(strNumCCD), UpperCase(strNumNSU), strParcel, LDtaCupFormatado, strCodEmp]) Then
            Result := True;
        End;

        If Not Result Then
        Begin
          If FIdxBaixadSemEmpresa.Localizar([UpperCase(strNumCCD), UpperCase(strNumNSU), strParcel, LDtaCupFormatado]) Then
            Result := True;
        End;

        If Result Then
          Result := fBetween(LValorBruto - cdsBaixad.FieldByName('MCA_VALSTA').AsFloat,
                             -LTolerancia, LTolerancia);
      End;
    End;
  End;

  blnAutomatica := (Result) And
                   (Not TPagSeguroFuncoes.fEmptyStr(cdsBaixad.FieldbyName('MCA_CHACON').AsString));

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

  If Not TPagSeguroFuncoes.fRetSomenteNumeros(FCartoesConciliar).IsEmpty Then
    strSQL := strSQL + ' AND MCA_CODCAR IN (' + TPagSeguroFuncoes.fRetStrToSQLIn(FCartoesConciliar) + ')';

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

    cdsBaiCar := TPagSeguroFuncoes.CriarClientDataSet(qryBaiCar);
    cdsBaiCar.Open;

    cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;MCA_CODEMP;PARDUP;MCA_DTACUP;MCA_NUMDUP';
  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(qryBaiCar);
  End;
end;

procedure TConciliacaoCartoes.pFiltraCartoesBaixados;
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
  strSQL := strSQL + '  IF(IFNULL(MCA_NUMCCD, "") = "", MCA_NUMCCD, UPPER(MCA_NUMCCD)) AS MCA_NUMCCD, ';
  strSQL := strSQL + ' MCA_PARCEL, MCA_DTAREC, MCA_NUMNSU, MCA_NUMDUP, MCA_DTACUP, MCA_NUMPOK,             ';
  strSQL := strSQL + ' MCA_CODEMP, MCA_DTAVEN, MCA_EMPRCX, MCA_CHACON, MCA_VALSTA, ';
  strSQL := strSQL + ' MOVCAR.AUTOINCREM AS AUTOINC,                             ';
  strSQL := strSQL + '  CAST(" " AS CHAR(50)) AS MARKETPLACE,                      ';
  strSQL := strSQL + ' LPAD(RIGHT(MCA_NUMNSU,12),14,"0") AS NSU_B2W,               ';
  strSQL := strSQL + ' "N" AS VALIDADO                                             ';
  strSQL := strSQL + ' FROM MOVCAR                                                 ';
  strSQL := strSQL + ' WHERE MCA_DTACUP IN(' + Copy(strDtaCad, 1, Length(strDtaCad) -1) + ') ';

  If Not TPagSeguroFuncoes.fRetSomenteNumeros(FCartoesConciliar).IsEmpty Then
    strSQL := strSQL + ' AND MCA_CODCAR IN (' + TPagSeguroFuncoes.fRetStrToSQLIn(FCartoesConciliar) + ')';

  If FFiltrarAutorizacaoNSU Then
    strSQL := strSQL + ' AND (MCA_NUMCCD IN (' + RetornaInAutorizacaoFiltrar + ')' +
                       '  OR  MCA_NUMNSU IN (' + RetornaInNsuFiltrar + ')) ';

  strSQL := strSQL + ' AND MCA_DTAREC IS NOT NULL                                  ';
  strSQL := strSQL + ' ORDER BY MCA_NUMCCD, MCA_PARCEL,MCA_CODEMP                  ';

  qryBaixad := Nil;
  Try
    qryBaixad := VS_FuncoesExternas.fICriaQuery;
    qryBaixad.SQL.Add(strSQL);
    qryBaixad.Open;

    cdsBaixad := TPagSeguroFuncoes.CriarClientDataSet(qryBaixad);
    cdsBaixad.Open;

    cdsBaixad.IndexFieldNames := 'MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_CODEMP';
    cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;EMPLOC;MCA_DTACUP;PARDUP';
  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(qryBaixad);
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

    frmPagSeguroFiltroInconsistencias: TfrmPagSeguroFiltroInconsistencias;

    LNaoExibir: String;
begin
  pgbStatus.Visible := False;
  TForm(pgbStatus.Owner).Visible := True;
  TPagSeguroFuncoes.pStepStatusGravacao(pgbStatus, 'Aguarde... Atualizando dados de conciliação.', False);
  pAcertaDadosDeBaixaOtimizadaPorEmpresa;
  TForm(pgbStatus.Owner).Visible := False;

  TPagSeguroFuncoes.pCriarFormularios(TfrmPagSeguroFiltroInconsistencias, frmPagSeguroFiltroInconsistencias);
  Try
    frmPagSeguroFiltroInconsistencias.chkLisArq.Checked := Not strNomCon.ToUpperInvariant.Contains('API');
    frmPagSeguroFiltroInconsistencias.Ordenacao := 1;

    frmPagSeguroFiltroInconsistencias.ShowModal;

    LValorBrutoDiferente := frmPagSeguroFiltroInconsistencias.ValorBrutoDiferente;
    LRegistroNaoEncontrado := frmPagSeguroFiltroInconsistencias.RegistroNaoEncontrado;
    LCaixaNaoTransferidos := frmPagSeguroFiltroInconsistencias.CaixaNaoTransferidos;
    LCartoesBaixados := frmPagSeguroFiltroInconsistencias.CartoesBaixados;
    LExibeListaArquivos := frmPagSeguroFiltroInconsistencias.ExibeListaArquivos;
    LOrdenacao := frmPagSeguroFiltroInconsistencias.Ordenacao;
    LExibeTotaisBandeira := frmPagSeguroFiltroInconsistencias.ExibeTotaisBandeira;
    LExibeTotaisPontoDeVenda := frmPagSeguroFiltroInconsistencias.ExibeTotaisPontoDeVenda;
    LValorTaxaDiferente := frmPagSeguroFiltroInconsistencias.ValorTaxaDiferente;

    Result := frmPagSeguroFiltroInconsistencias.ModalResult = mrOK;
  Finally
    FreeAndNil(frmPagSeguroFiltroInconsistencias);
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

  VS_FuncoesExternas.prcIExecutaRelatorio(529,
                                          36343,
                                          [],
                                          ['AUTINC',
                                          'DESCRI',
                                          'EXBARQCON',
                                          'EXBRESBAN',
                                          'EXBTOTPVE',
                                          'ORDENACAO'],
                                          [
                                           FFiltrosRelatorio.AutoIncrem,
                                           FFiltrosRelatorio.FiltrosDescri,
                                           TPagSeguroFuncoes.IIF(FFiltrosRelatorio.ExibeArquivos, 'Sim', 'Não'),
                                           TPagSeguroFuncoes.IIF(FFiltrosRelatorio.ExibeGrupoBandeira, 'Sim', 'Não'),
                                           TPagSeguroFuncoes.IIF(FFiltrosRelatorio.ExibeGrupoPontoDeVenda, 'Sim', 'Não'),
                                           TPagSeguroFuncoes.IIF(FFiltrosRelatorio.Ordenacao = 1, 'Data de Vencimento',
                                                                 TPagSeguroFuncoes.IIF(FFiltrosRelatorio.Ordenacao = 2, 'Número RV',
                                                                                       'Data da Venda'))
                                          ],
                                          nil,
                                          nil,
                                          True);
end;

function TConciliacaoCartoes.fExisteEstabelecimentosDuplicados(
  var AConfiguracao: String): Boolean;
  Var
    LSQL,
    LEstabelecimento,
    LCodigoEmpresaLista: String;

    LConsulta: TUniQuery;

    LListaEstabelecimentos: TDictionary<String, String>;
Begin
  LSQL := '';
  LSQL := LSQL + 'SELECT SIS_CODEMP, ';
  LSQL := LSQL + '       SIS_VALCFG  ';
  LSQL := LSQL + 'FROM CFGSIS                        ';
  LSQL := LSQL + 'WHERE SIS_CODCFG IN ([CODCFG]) AND ';
  LSQL := LSQL + '  SIS_VALCFG IS NOT NULL AND       ';
  LSQL := LSQL + '  SIS_VALCFG <> ""                 ';

  AConfiguracao := '(' + AConfiguracao + ')';

  LSQL := LSQL.Replace('([CODCFG])', AConfiguracao);

  Result := False;

  LListaEstabelecimentos := TDictionary<String, String>.Create;
  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LConsulta.SQL.Text := LSQL;

    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      For LEstabelecimento In LConsulta.FieldByName('SIS_VALCFG').AsString.Trim.Split([',']) Do
      Begin
        If TPagSeguroFuncoes.RetiraZerosEsquerda(LEstabelecimento).IsEmpty Then
          Continue;

        If Not LListaEstabelecimentos.TryGetValue(TPagSeguroFuncoes.RetiraZerosEsquerda(LEstabelecimento), LCodigoEmpresaLista) Then
        Begin
          LListaEstabelecimentos.Add(TPagSeguroFuncoes.RetiraZerosEsquerda(LEstabelecimento), LConsulta.FieldByName('SIS_CODEMP').AsString);

          Continue;
        End;

        Exit(True);
      End;

      LConsulta.Next;
    End;
  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(LConsulta);
    FreeAndNil(LListaEstabelecimentos);
  End;
End;

procedure TConciliacaoCartoes.AdicionaRegistrosDeTransferencias(
  AFiltroTransferencia: String; AFiltroEmpresaCfg: String = '');
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
                                 ' EST.SIS_CODEMP AS EMPRESA, ',
                                 ' POR.SIS_VALCFG AS PORTADOR, ',
                                 ' CTA.SIS_VALCFG AS PLANODECONTAS, ',
                                 ' EVE.SIS_VALCFG AS CENTRODECUSTOS ',
                                 'FROM ',
                                 objConcil.TabelaConciliacao + ' AS CONCILIACAO ',
                                 'LEFT JOIN CFGSIS AS EST ON EST.SIS_CODCFG IN ("CFG_PAGEST", "CFG_PAGLNK") AND ',
                                 '                           TRIM(LEADING 0 FROM EST.SIS_VALCFG) = TRIM(LEADING 0 FROM CONCILIACAO.' + objConcil.CampoEstabelecimento + ') ',
                                 TPagSeguroFuncoes.IIF(Not AFiltroEmpresaCfg.IsEmpty, ' AND EST.SIS_CODEMP="' + AFiltroEmpresaCfg + '" ', ' '),
                                 'LEFT JOIN CFGSIS AS POR ON POR.SIS_CODEMP=EST.SIS_CODEMP AND ',
                                 '                           POR.SIS_CODCFG="CFG_' + objConcil.CfgPortadorTransferencia + '" ',
                                 'LEFT JOIN CFGSIS AS CTA ON CTA.SIS_CODEMP=EST.SIS_CODEMP AND ',
                                 '                           CTA.SIS_CODCFG="CFG_' + objConcil.CfgPlanoDeContasTransferencia + '" ',
                                 'LEFT JOIN CFGSIS AS EVE ON EVE.SIS_CODEMP=EST.SIS_CODEMP AND ',
                                 '                           EVE.SIS_CODCFG="CFG_' + objConcil.CfgCentroDeCustosTransferencia + '" ',
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

      LRegistroRelatorio := TItensRelatorioCartoes.Create;

      LRegistroRelatorio.ValorBruto := TPagSeguroFuncoes.fFormataFloat(LConsulta.FieldByName(objConcil.CampoValorBruto).AsFloat, 2);
      LRegistroRelatorio.ValorLiquido := TPagSeguroFuncoes.fFormataFloat(LConsulta.FieldByName(objConcil.CampoValorLiquido).AsFloat, 2);

      LRegistroRelatorio.Descricao := 'TRANSFERÊNCIAS';
      LRegistroRelatorio.TipoDoRegistro := 'TRANSFERÊNCIA';
      LRegistroRelatorio.TipoCartao := 'TRANSFERÊNCIAS';
      LRegistroRelatorio.DescricaoAjuste := 'TRANSFERÊNCIA';

      LRegistroRelatorio.CodigoEmpresa := LConsulta.FieldByName('EMPRESA').AsString;
      LRegistroRelatorio.CodigoEstabelecimento := LConsulta.FieldByName(objConcil.CampoEstabelecimento).AsString;
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

      LRegistroRelatorio.Conciliado := LConsulta.FieldByName('PAG_CONCIL').AsInteger;
      LRegistroRelatorio.NomeArquivo := LConsulta.FieldByName('PAG_NOMARQ').AsString;

      LRegistroRelatorio.RegistroIncompleto := 'S';
      If LConfiguracoesValidas Then
      Begin
        LRegistroRelatorio.RegistroIncompleto := 'N';
        GravarRegistroDeAjusteParaConciliacao(LRegistroRelatorio, False, LConsulta);
      End;

      FListaRegistrosRelatorio.Add(LRegistroRelatorio);

      LConsulta.Next;
    End;
  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(LConsulta);
  End;
end;

procedure TConciliacaoCartoes.FiltrarCancelamentosPeriodo(ACondicaoSQL,
  ATipoAjustes, ACondicaoAjusteCredito: String; ALimitarAutorizacao: Boolean);
  Var
    LSQL,
    LEmpresaConfiguracao: String;

    LConsulta: TUniQuery;

    LAjusteCredito,
    LDividePeloTotalDeParcelas: Boolean;

    LRegistroRelatorio: TItensRelatorioCartoes;
begin
  TPagSeguroFuncoes.FreeAndNilDatasets(cdsAjustes);

  LConsulta := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LSQL := '';
    LSQL := LSQL + 'SELECT DISTINCT A.*, ';

    If Not TPagSeguroFuncoes.fEmptyStr(ATipoAjustes) Then
       LSQL := LSQL + ATipoAjustes + ' AS TIPAJU, ';

    If Not TPagSeguroFuncoes.fEmptyStr(ACondicaoAjusteCredito) Then
       LSQL := LSQL + ACondicaoAjusteCredito + ' AS AJUCRE, ';

    LSQL := LSQL + '  "S" AS MARCADO, ';

    LSQL := LSQL + '  CAST("" AS CHAR(3)) AS EMPRESA ';
    LSQL := LSQL + ' FROM ' + objConcil.TabelaConciliacao + ' A ';
    LSQL := LSQL + ' WHERE ' + ACondicaoSQL ;

    LConsulta.Close;
    LConsulta.SQL.Text := LSQL;
    LConsulta.Open;

    cdsAjustes := TPagSeguroFuncoes.CriarClientDataSet(LConsulta);
  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(LConsulta);
  End;

  cdsAjustes.First;
  While Not cdsAjustes.Eof Do
  Begin
    LEmpresaConfiguracao := LeftStr(TPagSeguroFuncoes.fCfgSisEmp('PAGEST', cdsAjustes.FieldByName(objConcil.CampoEstabelecimento).AsString), 3);

    If LEmpresaConfiguracao.Trim.IsEmpty Then
      LEmpresaConfiguracao := LeftStr(TPagSeguroFuncoes.fCfgSisEmp('PAGLNK', cdsAjustes.FieldByName(objConcil.CampoEstabelecimento).AsString, True), 3);

    LRegistroRelatorio := TItensRelatorioCartoes.Create;
    Try
      LAjusteCredito := Not FormatFloat(',0.00', cdsAjustes.FieldByName('AJUCRE').AsFloat).Equals('0,00');

      LDividePeloTotalDeParcelas := objConcil.NomeConciliacao.Equals('PAGSEGURO');
      If LDividePeloTotalDeParcelas Then
        LDividePeloTotalDeParcelas := cdsAjustes.FieldByName(objConcil.CampoTotalParcelas).AsInteger > 1;

      LRegistroRelatorio.ValorBruto := TPagSeguroFuncoes.fFormataFloat(cdsAjustes.FieldByName(objConcil.CampoValorBruto).AsFloat, 2);
      If LDividePeloTotalDeParcelas Then
      Begin
        cdsAjustes.Edit;
        cdsAjustes.FieldByName(objConcil.CampoValorBruto).AsFloat := TPagSeguroFuncoes.fFormataFloat(cdsAjustes.FieldByName(objConcil.CampoValorBruto).Value /
                                                                                                     cdsAjustes.FieldByName(objConcil.CampoTotalParcelas).AsInteger, 2);
        cdsAjustes.Post;
      End;

      LRegistroRelatorio.ValorLiquido := TPagSeguroFuncoes.fFormataFloat(cdsAjustes.FieldByName(objConcil.CampoValorBruto).AsFloat, 2);

      LRegistroRelatorio.ValorBruto := Abs(LRegistroRelatorio.ValorBruto);
      LRegistroRelatorio.ValorLiquido := Abs(LRegistroRelatorio.ValorLiquido);
      If Not LAjusteCredito Then
      Begin
        LRegistroRelatorio.ValorBruto := LRegistroRelatorio.ValorBruto * (-1);
        LRegistroRelatorio.ValorLiquido := LRegistroRelatorio.ValorLiquido * (-1);
      End;

      LRegistroRelatorio.Descricao := 'Cancelamentos/Ajustes';
      LRegistroRelatorio.TipoDoRegistro := 'AJUSTES';
      LRegistroRelatorio.TipoCartao := 'CANCELAMENTOS/AJUSTES';
      LRegistroRelatorio.DescricaoAjuste := cdsAjustes.FieldByName('TIPAJU').AsString;

      LRegistroRelatorio.CodigoEmpresa := LEmpresaConfiguracao;
      LRegistroRelatorio.CodigoEstabelecimento := cdsAjustes.FieldByName(objConcil.CampoEstabelecimento).AsString;
      LRegistroRelatorio.NumeroNSU := TPagSeguroFuncoes.fStrZero(cdsAjustes.FieldByName(objConcil.CampoNumeroNSU).AsString, 14);
      LRegistroRelatorio.NumeroCartao := cdsAjustes.FieldByName(objConcil.CampoNumeroCartao).AsString;
      LRegistroRelatorio.Parcela := LeftStr(cdsAjustes.FieldByName(objConcil.CampoTotalParcelas).AsString, 2);
      LRegistroRelatorio.TotalParcelas := RightStr(cdsAjustes.FieldByName(objConcil.CampoNumeroParcela).AsString, 2);
      LRegistroRelatorio.CodigoAutorizacao := TPagSeguroFuncoes.fStrZero(Trim(cdsAjustes.FieldByName(objConcil.CampoCodigoAutorizacao).Value), 6);
      If ALimitarAutorizacao Then
        LRegistroRelatorio.CodigoAutorizacao := RightStr(LRegistroRelatorio.CodigoAutorizacao, 6);

      LRegistroRelatorio.ResumoVenda := TPagSeguroFuncoes.fStrZero('0', 12);

      LRegistroRelatorio.DataVenda := cdsAjustes.FieldByName(objConcil.CampoDataRecebimento).Value;

      LRegistroRelatorio.DataPagamento := cdsAjustes.FieldByName(objConcil.CampoDataRecebimento).Value;

      LRegistroRelatorio.Conciliado := cdsAjustes.FieldByName('PAG_CONCIL').AsInteger;
      LRegistroRelatorio.NomeArquivo := cdsAjustes.FieldByName('PAG_NOMARQ').AsString;

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

      TPagSeguroFuncoes.GravaTabelaDelecao(AUnitRemocao,
                                            'REL_CONCAR',
                                             LConsulta);

      TPagSeguroFuncoes.ExecutaSQL('DELETE FROM REL_CONCAR WHERE AUTOINCREM=' + FRelatorioConciliacao.AutoIncremRelatorio);

      VS_FuncoesExternas.fICommit;
    Finally
      TPagSeguroFuncoes.FreeAndNilDatasets(LConsulta);
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

    LEstabelecimento,
    LEstabelecimentoCorrigido: string;

    LListaEstabelecimentos,
    LEmpresas: TStringList;
begin
  Result := EmptyStr;

  If Length(arrEmpresa) <= 0 Then
    Exit;

  LConsulta := Nil;
  LListaEstabelecimentos := Nil;
  LEmpresas := Nil;
  Try
    LConsulta := VS_FuncoesExternas.fICriaQuery;
    LListaEstabelecimentos := TStringList.Create;
    LListaEstabelecimentos.Delimiter := ',';
    LListaEstabelecimentos.StrictDelimiter := True;

    LEmpresas := TPagSeguroFuncoes.ConverterArrayConsultaParaStringList(arrEmpresa);

    LConsulta.SQL.Text := 'SELECT DISTINCT SIS_VALCFG ' +
                          'FROM CFGSIS ' +
                          'WHERE SIS_CODCFG IN ("CFG_PAGEST", "CFG_PAGLNK") ' +
                          '  AND COALESCE(SIS_VALCFG, "") <> "" ' +
                          '  AND SIS_CODEMP IN ("' + LEmpresas.CommaText.Replace(',', '","') + '")';
    LConsulta.Open;

    While Not LConsulta.Eof Do
    Begin
      LListaEstabelecimentos.DelimitedText := LConsulta.FieldByName('SIS_VALCFG').AsString;

      If Not LListaEstabelecimentos.DelimitedText.IsEmpty Then
      Begin
        For LEstabelecimento In LListaEstabelecimentos Do
        Begin
          LEstabelecimentoCorrigido :=  LEstabelecimento;

          While (Length(LEstabelecimentoCorrigido) > 0) and (LEstabelecimentoCorrigido[1] = '0') do
            Delete(LEstabelecimentoCorrigido,1,1);

          Result := Result + LEstabelecimentoCorrigido + ',';
        End;
      End;

      LConsulta.Next;
    End;

    Result := Result.Replace(',,', ',');

    If Not ARetornarIn Then
      Exit(Result.Replace(',', '_'));

    Result := '"' + LeftStr(Result, Result.Length - 1).Replace(',', '","') + '"';
  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(LConsulta);

    If Assigned(LEmpresas) Then
      FreeAndNil(LEmpresas);

    If Assigned(LListaEstabelecimentos) Then
      FreeAndNil(LListaEstabelecimentos);
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
      LStringList := TPagSeguroFuncoes.ConverterArrayConsultaParaStringList(arrEmpresa);
      Result := Result + 'Empresas: ' + LStringList.Text;
      FreeAndNil(LStringList);
    End;

    If Length(arrPonVen) > 0 Then
    Begin
      LStringList := TPagSeguroFuncoes.ConverterArrayConsultaParaStringList(arrPonVen);
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

  If Not TPagSeguroFuncoes.fEmptyStr(FInAutorizacaoFiltrar) Then
    Exit(FInAutorizacaoFiltrar);

  Result := '""';

  cdsConCar.First;
  While Not cdsConCar.Eof Do
  Begin
    LValor := '"' + TPagSeguroFuncoes.fStrZero(cdsConcar.FieldByName(objConcil.CampoCodigoAutorizacao).AsString, 6) + '"';

    If Pos(LValor, Result) > 0 Then
    Begin
      cdsConCar.Next;

      Continue;
    End;

    If Not TPagSeguroFuncoes.fEmptyStr(objConcil.CampoIDTransacao) Then
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

  If Not TPagSeguroFuncoes.fEmptyStr(FInNsuFiltrar) Then
    Exit(FInNsuFiltrar);

  Result := '""';

  cdsConCar.First;
  While Not cdsConCar.Eof Do
  Begin
    LValor := '"' + TPagSeguroFuncoes.fStrZero(cdsConcar.FieldByName(objConcil.CampoNumeroNSU).AsString, 14) + '"';

    If Pos(LValor, Result) > 0 Then
    Begin
      cdsConCar.Next;

      Continue;
    End;

    If Not TPagSeguroFuncoes.fEmptyStr(objConcil.CampoIDTransacao) Then
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

  Result := TPagSeguroFuncoes.fStrZero(LNumero.ToString, 2) + '/';

  If Not TryStrToInt(ATotalParcelas, LNumero) Then
    Exit(Result + LeftStr(Result, 2));

  Result := Result + TPagSeguroFuncoes.fStrZero(LNumero.ToString, 2);
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
    LRegistros := TPagSeguroFuncoes.CriarClientDataSet(cdsBaiCar);
    LRegistros.Filter := 'MCA_MARDES=''M'' AND REGISTROTRANSFERENCIA=''N'' ';
    LRegistros.Filtered := True;

    LRegistros.First;
    While Not LRegistros.Eof Do
    Begin
      Inc(AQuantidadeBaixados);

      ABrutoBaixados := ABrutoBaixados + TPagSeguroFuncoes.fFormataFloat(LRegistros.FieldByName('MCA_VALSTA').AsFloat, 2);
      ALiquidoBaixados := ALiquidoBaixados + TPagSeguroFuncoes.fFormataFloat(LRegistros.FieldByName('MCA_VALREC').AsFloat, 2);

      LRegistros.Next;
    End;
  Finally
    TPagSeguroFuncoes.FreeAndNilDatasets(LRegistros);
  End;
end;

function TConciliacaoCartoes.RetornaValorTolerancia(ACodEmp: String;ADefault: Double): Double;
begin
  If TPagSeguroFuncoes.fEmptyStr(objConcil.CfgVlrTolerancia) Then
    Exit(ADefault);

  If TPagSeguroFuncoes.fEmptyStr(ACodEmp) Then
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
                  (TPagSeguroFuncoes.fFormataFloat(AValorBruto * (RetornaTaxaParaValidacao / 100), 2))
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

    TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_CHAVE_', AOperadora.ToUpperInvariant + '-' +
                                                                     FormatDateTime('yyyymmdd', ADataRelatorio) + '_' +
                                                                     FormatDateTime('hhmmss', AHoraRelatorio) + '-' +
                                                                     ACodigoOperador + '-' + ATipoRelatorio.ToUpperInvariant);
    TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_DTAREL', ADataRelatorio);
    TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_HORREL', AHoraRelatorio);
    TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_CODOPE', ACodigoOperador);
    TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_OPERAD', AOperadora);
    TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_TIPREL', ATipoRelatorio);
    TPagSeguroFuncoes.SetaValorCampoDataset(LInserir, 'REL_FILREL', AFiltrosRelatorio + #13 +
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
    TPagSeguroFuncoes.FreeAndNilDatasets(LInserir);
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
