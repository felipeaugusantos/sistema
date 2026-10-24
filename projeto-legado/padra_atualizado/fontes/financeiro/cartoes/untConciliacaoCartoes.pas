{***************************************}
{* Classe para Conciliação dos Cartões *}
{* de Crédito                          *}
{************************************AJ*}
unit untConciliacaoCartoes;

interface

Uses Classes, Forms, Uni, UniClientDataSet, untFuncoesSimples, untFuncoes,
     UniDataSetProvider, cxProgressBar, Types, System.Sysutils, StrUtils,
     System.Variants, DB, untTypesSistema, frxClass, frxDBSet, untFuncFat,
     Graphics, Controls,  System.Math;

Type
  TSelCarBaixado = Record
    strNumCar : String;
    strNumNsu : String;
    strParcel : String;
    fltValSta : Double;
    strNum_Pv : String;
    strNum_Rv : String;
    strCodCar : String;
    strTipCar : String;
    dtaDta_Cv : TDateTime;
    dtaDtaVen : TDateTime;
    blnBaixad : Boolean;
    strNumCCD : String;
    strParTot : String;
    fltValLiq : Double;
    strDesEmp : String;
End;

Type
  TTotalRel = Record
    strTipCar : String;
    intQtdCar : Integer;
    fltValCar : Double;
    fltValLiq : Double;

    ValorTaxas,
    ValorFrete,
    ValorAjustes,
    ValorCupom: Double;
End;

Type
  TDescricaoRelatorio = Record
    NomeRelatorio,
    NomeChave1,
    NomeChave2,
    Operadora: String;

    EsconderChave2,
    EsconderCupons: Boolean;
    ExibirEmp:Boolean;
  End;

Type TInconsist = class
  private
    FstrNomArq,
    FstrDescri,
    FstrValori,
    FstrAutori,
    FstrNum_PV,
    FstrNum_RV,
    FstrTipCar,
    FstrDta_CV,
    FstrDtaVen,
    FstrNumCar,
    FstrValRec,
    FstrNomEmp,
    FstrParcel,
    FstrPerTax,
    FstrNumNsu,
    FstrNumCCD,
    FstrDesEmp,
    FStrCodEmp,
    FstrValLiq,
    FstrBandei,
    FstrCodCli,
    FstrNumDup,
    FstrNomCli,
    FstrFonCli,
    FstrDtaRec,
    FstrCodCar,
    FstrDesCar,
    FstrPorBai,
    FstrPorTax,
    FstrPorDeb,
    FstrForTax,
    FstrCtaBai,
    FstrCtaTax,
    FstrCtaDeb,
    FstrEveDeb,
    FstrPagOri,
    FstrChaCon: String;
    FintConcil: Integer;
    FfltValCon: Double;
    FblnTotali: Boolean;

    FstrSituacaoCadastro,
    FstrEventoCancelamentoAjuste,
    FPortadorTransferencia,
    FPlanoDeContasTransferencia,
    FCentroDeCustosTransferencia: String;

    FBrutoMarketPLace,
    FLiquidoMarketPlace,
    FTaxasMarketPlace,
    FFreteMarketPlace,
    FAjustesMarketPlace,
    FCupomMarketPlace: Double;

    FOperadora: String;
    FNegociacaoRecebiveis: String;
    FNumeroOperacaoNegociacao: String;
    FHistoricoBaixa:String;

    FPlanoContasTaxaNegociacao: String;

    FCodigoBandeira: String;
    FPercentualTaxa: Double;
    FstrDtaPag: String;

    FValorCartaoSistema,
    FDiferencaValorBruto: Double;
  public
    property strNomArq: String read FstrNomArq write FstrNomArq;
    property strDescri: String read FstrDescri write FstrDescri;
    property strValori: String read FstrValori write FstrValori;
    property strAutori: String read FstrAutori write FstrAutori;
    property strNum_PV: String read FstrNum_PV write FstrNum_PV;
    property strNum_RV: String read FstrNum_RV write FstrNum_RV;
    property strTipCar: String read FstrTipCar write FstrTipCar;
    property strDta_CV: String read FstrDta_CV write FstrDta_CV;
    property strDtaVen: String read FstrDtaVen write FstrDtaVen;
    property strNumCar: String read FstrNumCar write FstrNumCar;
    property strValRec: String read FstrValRec write FstrValRec;
    property strNomEmp: String read FstrNomEmp write FstrNomEmp;
    property strParcel: String read FstrParcel write FstrParcel;
    property strPerTax: String read FstrPerTax write FstrPerTax;
    property strNumNsu: String read FstrNumNsu write FstrNumNsu;
    property strNumCCD: String read FstrNumCCD write FstrNumCCD;
    property strDesEmp: String read FstrDesEmp write FstrDesEmp;
    property strCodEmp: String Read FstrCodEmp Write FStrCodEmp;
    property strValLiq: String read FstrValLiq write FstrValLiq;
    property intConcil: Integer read FintConcil write FintConcil;
    property fltValCon: Double read FfltValCon write FfltValCon;
    property strBandei: String read FstrBandei write FstrBandei;
    property strCodCli: String read FstrCodCli write FstrCodCli;
    property strNumDup: String read FstrNumDup write FstrNumDup;
    property strCodCar: String read FstrCodCar write FstrCodCar;
    property strDesCar: String read FstrDesCar write FstrDesCar;
    property strPorBai: String read FstrPorBai write FstrPorBai;
    property strPorTax: String read FstrPorTax write FstrPorTax;
    property strPorDeb: String read FstrPorDeb write FstrPorDeb;
    property strForTax: String read FstrForTax write FstrForTax;
    property strCtaBai: String read FstrCtaBai write FstrCtaBai;
    property strCtaTax: String read FstrCtaTax write FstrCtaTax;
    property strCtaDeb: String read FstrCtaDeb write FstrCtaDeb;
    property strEveDeb: String read FstrEveDeb write FstrEveDeb;
    property strNomCli: String read FstrNomCli write FstrNomCli;
    property strFonCli: String read FstrFonCli write FstrFonCli;
    property strDtaRec: String read FstrDtaRec write FstrDtaRec;
    property strPagOri: String read FstrPagOri write FstrPagOri;
    property strChaCon: String read FstrChaCon write FstrChaCon;
    property blnTotali: Boolean read FblnTotali write FblnTotali;
    property strSituacaoCadastro: String read FstrSituacaoCadastro write FstrSituacaoCadastro;
    property strEventoCancelamentoAjuste: String read FstrEventoCancelamentoAjuste write FstrEventoCancelamentoAjuste;
    property PortadorTransferencia: String read FPortadorTransferencia write FPortadorTransferencia;
    property PlanoDeContasTransferencia: String read FPlanoDeContasTransferencia write FPlanoDeContasTransferencia;
    property CentroDeCustosTransferencia: String read FCentroDeCustosTransferencia write FCentroDeCustosTransferencia;
    property Operadora: String read FOperadora write FOperadora;
    property HistoricoBaixa: String read FHistoricoBaixa write FHistoricoBaixa;

    property BrutoMarketPlace: Double read FBrutoMarketPlace write FBrutoMarketPlace;
    property LiquidoMarketPlace: Double read FLiquidoMarketPlace write FLiquidoMarketPlace;
    property TaxasMarketPlace: Double read FTaxasMarketPlace write FTaxasMarketPlace;
    property FreteMarketPlace: Double read FFreteMarketPlace write FFreteMarketPlace;
    property AjustesMarketPlace: Double read FAjustesMarketPlace write FAjustesMarketPlace;
    property CupomMarketPlace: Double read FCupomMarketPlace write FCupomMarketPlace;

    property NegociacaoRecebiveis: String read FNegociacaoRecebiveis write FNegociacaoRecebiveis;
    property NumeroOperacaoNegociacao: String read FNumeroOperacaoNegociacao write FNumeroOperacaoNegociacao;
    property PlanoContasTaxaNegociacao: String read FPlanoContasTaxaNegociacao write FPlanoContasTaxaNegociacao;

    property CodigoBandeira: String read FCodigoBandeira write FCodigoBandeira;
    property PercentualTaxa: Double read FPercentualTaxa write FPercentualTaxa;
    property strDtaPag: String read FstrDtaPag write FstrDtaPag;

    property ValorCartaoSistema: Double read FValorCartaoSistema write FValorCartaoSistema;
    property DiferencaValorBruto: Double read FDiferencaValorBruto write FDiferencaValorBruto;

    constructor Create;
End;

type TConciliacaoCartoes = class
  qryBaiCar: TUniQuery;
  cdsInconsistencia,                     //INCONSISTENCIAS
  cdsConCar,                             //DATASET DOS ARQUIVOS IMPORTADOS (EXCETO REDECARD)
  cdsAjustes,                            //DATASET DOS AJUSTES
  cdsListArq,                            //DATASET DA LISTA DE ARQUIVOS CONCILIADOS
  cdsSemRed,                             //DATASET DA LISTA DE RVS INCONSISTENTES (REDECARD)
  cdsTotBan,                             //DATASET DO TOTAL DAS BANDEIRAS
  cdsResolverAPI,                        //DATASET PARA RESOLUÇÃO DE APIS EXTERNOS E CONCIL DO MERCADO LIVRE
  cdsResolverAPICanc,                    //DATASET DOS CANCELAMENTOS PARA RESOLUÇÃO DE APIS EXTERNOS E CONCIL DO MERCADO LIVRE
  cdsWithdrawal     : TUniClientDataSet; //DATASET DO WITHDRAWAL (MERCADO LIVRE)
  cdsTotalFinal:      TUniClientDataSet;  //DATASET TOTALIZADORES (PAGAR.ME)

  arrTotRel  : Array[0..5] of TTotalRel;
  objTotCan  : TTotalRel;
  strBloqPV  : String; //Ponto de Venda Bloqueado pelo Caixa
  strBloqPa  : String; //Parcela bloqueada pelo Caixa
  strBloqCa  : String; //Cartão Bloqueado pelo Caixa
  FBandeiraCartao: String;
  strBloqRV  : String; //RV/RO/TID Bloqueado pelo Caixa
  strBloqEm  : String; //Descrição da empresa em cartão bloqueado
  objConcil  : TCamposConcil;

  strIDConciliacao: String; //Filtro por ID de Conciliação (Koncilia)

  blnGraAju,
  blnAutomatica,
  blnResolverAPI,
  blnConciliarDataImportacao: Boolean;

  strTmpLog,
  FTextoInconsistencia: String;

  FConciliacaoComPixAtivado: Boolean;
  LConciliacaoComBoletoAtivado: Boolean;

  FDescricaoCampos: TDescricaoRelatorio;

  FLiberacaoTransferencia: Boolean;

  FFiltrarAutorizacaoNSU: Boolean;
  FInAutorizacaoFiltrar: String;
  FInNsuFiltrar: String;

  procedure pCriaClientInconsist;
  procedure pFiltraCartoes;
  procedure pFiltraCartoesBaixados(AApenasNaoValidados: Boolean = False);
  procedure pMarcaCartao(fltValRec: Double;
                         blnAntecip: Boolean;
                         strChaCon: String = '';
                         dtaPagOri: TDate = 0;
                         AFreteMarketPlace: Double = 0;
                         AAjusteMarketPlace: Double = 0;
                         ATaxaMarketPlace: Double = 0;
                         ATaxaDeAntecipacao: Double = 0;
                         ACupomMarketPlace: Double = 0;
                         AFreteMediacao: Double = 0;
                         ATipoCartao: String = '';
                         AHistoricoBaixa: String = '';
                         ADiferencaCupom: Double = 0);

  procedure pAcertaDadosDeBaixaOtimizadaPorEmpresa;

  procedure pCalculaPeriodoFiltro(strCampo: String);
  procedure pGravaTotal(strTipo: String;
                        fltValMar,
                        fltValor: Double;
                        AValorTaxas: Double = 0;
                        AValorFrete: Double = 0;
                        AValorAjustes: Double = 0;
                        AValorCupom: Double = 0;
                        AQuantidade: Integer = 1);

  Function fCartaoBloqueado(qryMovCar: TDataSet): Boolean;

  procedure pGravaInconsistencia(objIncons: TInconsist);
  procedure pGravaTotBan(strEstabe, strNomBan: String; fltValBan, fltLiqBan: Double; intConcil: Integer = 1);

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
  function CartoesValidosParaRealizarAConciliacaoDoMercadoLivre: Boolean;

  function fRetNomBandeira(strNumCar: String;
                           ATipoCartao: String = ''): String;

  procedure pTotalRelInc;
  function fExibeRelatIncons(strNomRel: String;
                              blnMemo96: Boolean = True;
                              strMemo96: String = 'Res. Venda';
                              blnConRed: Boolean = False;
                              ANomCon: String = ''): Boolean;

  function ExibeRelatorioConciliacaoMkt(ADescricaoCampos: TDescricaoRelatorio): Boolean;
  procedure RetornaTotaisValoresQueSeraoBaixados(out AQuantidadeBaixados: Integer;
                                                 out ABrutoBaixados: Double;
                                                 out ALiquidoBaixados: Double);
  procedure EsconderCamposDeCuponsMkt(AEsconder: Boolean);

  procedure pFiltraCancelamentos(strSQLCondicao: String; objCampos: TCamposConcil;
                                 strTipAju: String = ''; strAjuCre: String = '';
                                 blnLimitaAut: Boolean = True);
  procedure pGravaListaArquivo(strNomArq: String; strTipo: String = '0');
  function fRetPesqPonVen(intTipo: Integer = 0): String;
  function RetornaFiltroCodigoConciliacao:String;

  procedure pGravaAjustes(objIncons: TInconsist;
                          AGravaCampoValorBruto: Boolean = False;
                          AAjusteTransferencia: Boolean = False;
                          ADatasetTransferencia: TDataset = Nil;
                          ADatasetNegociacao: TDataset = Nil;
                          AOutrosDatasets: TDataset = Nil);

  function fBetween(fltValor, fltMinimo, fltMaximo: Double): Boolean;

  function fRetornaChaveConciliacao(cdsDataset: TDataset): String;

  function PossuiDivergenciaEntreATaxaPagaPelaTaxaCadastrada(AValorBruto: Double;
                                                             ARegistro: TDataSet;
                                                             APercentual: Boolean = True): Boolean;
  function RetornaTaxaParaValidacao:Double;
  function RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa:String;

  function fRetornaDadosDeBaixaDosAjustes(strConfiguracao,
                                          strEmpresaConfiguracao: String): String;

  function RetornaValorTolerancia(ACodEmp: String;ADefault: Double = 0): Double ;

  procedure AdicionaRegistrosDeTransferencias(AFiltroTransferencia: String;
                                              AFiltroEmpresaCfg: String = '');

  function RetornaSituacaoCadastroAjustesTransferencias(AEmpresa: String): String;

  function RetornaSituacaoCadastroInconsistencias(AInconsistencia: TInconsist): String;

  procedure GravarTotalizador(ARecebedor,
                              AEstabelecimento: String;
                              AValorBruto,
                              ATaxa: Double;
                              AInconsistencia: TInconsist = nil;
                              ATotalizarSomenteTaxa: Boolean = False);

  procedure GerarTotalFinalLiquido;
  private
    FCartoesConciliar: String;
    FExibirCartoesPendente: Boolean;
    FLancarAjustesACredito: Boolean;
    FTemAjusteACredito: Boolean;

    function RetornaInAutorizacaoFiltrar: String;
    function RetornaInNsuFiltrar: String;
    function AgrupaRelatorioMktPorEmpresa: Boolean;
    procedure DeletarValoresLiquidosZerados(ADataset: TUniClientDataset; AFieldName: string);
    function EmpresaConfiguracao(AConfiguracao, AValorConfiguracao: String): String;
  public
    cdsBaiCar,                    //DATASET PARA MARCAÇÃO DE REGISTROS CONCILIADOS
    cdsBaixad: TUniCLientDataSet; //DATASET PARA BUSCAR SE FOI BAIXADO

    frxPagina   : TfrxReport;
    frxRelatorio: TfrxDBDataset;
    frxListArq  : TfrxDBDataset;
    frxSemRed   : TfrxDBDataset;
    frxTotBan   : TfrxDBDataset;
    frxTotalFinal: TfrxDBDataset;
    blnInconsist: Boolean;
    blnReabre   : Boolean;
    strNomCon   : String;

    constructor Create;

    function fConciliaCartoes: Boolean; virtual;
  protected
    dtaDtaIni,
    dtaDtaFim,
    dtaDtaPag  : TDate;
    lstNomArq,
    lstSemArq,
    lstDtaCad  : TStringList;
    intQtdSem  : Integer;
    fltValSem  : Double;
    arrPonVen,
    arrEmpresa,
    arrCodigoConciliacao : TConsultasArray;
    arrSemReg  : Array of TSelCarBaixado;
    strRcxTcc,
    strResumo,
    strDtaIni,
    strDtaFim,
    strCondicao: String;
    blnAjuCon  : Boolean;

    property CartoesConciliar: String read FCartoesConciliar write FCartoesConciliar;

    public
      property DataInicialConciliacao: TDate Read  dtaDtaIni;
      property DataFinalConciliacao  : TDate Read  dtaDtaFim;
      property ExibirCartoesPendente : Boolean Read FExibirCartoesPendente;
end;

implementation
uses untDigPeriodo, untFiltroInconsistencias, untBaixaCartoes, untMovCar,
     untGravando, untFiltroInconsistenciasMkt;

procedure TConciliacaoCartoes.AdicionaRegistrosDeTransferencias(
  AFiltroTransferencia: String; AFiltroEmpresaCfg: String = '');
  Var
    LConsulta: TUniQuery;

    LTransferencia: TInconsist;

    LValidaConfiguracoes: String;

    LConfiguracoesValidas: Boolean;
begin
  If objConcil.CfgPortadorTransferencia.IsEmpty Then
    Exit;

  LConsulta := fCriaQuery;

  Try
    LConsulta.SQL.Text := Concat('SELECT CONCILIACAO.*, ',
                                 ' EST.SIS_CODEMP AS EMPRESA, ',
                                 ' POR.SIS_VALCFG AS PORTADOR, ',
                                 ' CTA.SIS_VALCFG AS PLANODECONTAS, ',
                                 ' EVE.SIS_VALCFG AS CENTRODECUSTOS ',
                                 'FROM ',
                                 objConcil.strTabCon + ' AS CONCILIACAO ',
                                 'LEFT JOIN CFGSIS AS EST ON EST.SIS_CODCFG="' + objConcil.strConfEs + '" AND ',
                                 '                           TRIM(LEADING 0 FROM EST.SIS_VALCFG) = TRIM(LEADING 0 FROM CONCILIACAO.' + objConcil.strCamCon + ') ',
                                 IIF(Not AFiltroEmpresaCfg.IsEmpty, ' AND EST.SIS_CODEMP="' + AFiltroEmpresaCfg + '" ', ' '),
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
      If fCfgSis('CTPOBE', varBoolean) Then
        LConfiguracoesValidas := LValidaConfiguracoes.Length > 12;


      LTransferencia := TInconsist.Create;

      LTransferencia.strDescri := 'TRANSFERÊNCIAS';
      LTransferencia.strNomCli := 'TRANSFERÊNCIA';

      LTransferencia.strNumDup := fStrZero('0', 12);

      LTransferencia.strAutori := LConsulta.FieldByName(objConcil.strNumNSU).AsString;
      LTransferencia.strNumNSU := LConsulta.FieldByName(objConcil.strNumNSU).AsString;
      LTransferencia.strNum_PV := LConsulta.FieldByName(objConcil.strCamCon).AsString;

      if not fEmptyStr(objConcil.strNumCar) then
        LTransferencia.strNumCar := LConsulta.FieldByName(objConcil.strNumCar).AsString;

      LTransferencia.strTipCar := 'TRANSFERÊNCIAS';
      LTransferencia.strDta_CV := FormatDateTime('dd/mm/yyyy', LConsulta.FieldByName(objConcil.strDtaRec).AsDateTime);

      LTransferencia.strParcel := IIF(LConsulta.FieldByName(objConcil.strNumPar).AsInteger = 0, '01', fStrZero(LConsulta.FieldByName(objConcil.strNumPar).AsString, 2)) + '/' +
                                  IIF(LConsulta.FieldByName(objConcil.strTotPar).AsInteger = 0, '01', fStrZero(LConsulta.FieldByName(objConcil.strTotPar).AsString, 2));

      LTransferencia.strNumCCD := fStrZero(RightStr(Trim(LConsulta.FieldByName(objConcil.strCodAut).AsString), 6), 6);

      LTransferencia.strValOri := FormatFloat('#,##0.00', LConsulta.FieldByName(objConcil.strValBru).AsFloat);
      LTransferencia.strValLiq := FormatFloat('#,##0.00', LConsulta.FieldByName(objConcil.strValLiq).AsFloat);
      LTransferencia.strValRec := FormatFloat('#,##0.00', LConsulta.FieldByName(objConcil.strValLiq).AsFloat);

      LTransferencia.strDtaRec := FormatDateTime('dd/mm/yyyy', LConsulta.FieldByName(objConcil.strDtaRec).AsDateTime);

      LTransferencia.strNomEmp := '';
      If Not LConsulta.FieldByName('EMPRESA').AsString.IsEmpty Then
        LTransferencia.strNomEmp := LConsulta.FieldByName('EMPRESA').AsString + '-' + fRetNomeEmpresaSelec(LConsulta.FieldByName('EMPRESA').AsString);

      LTransferencia.strPorBai := fRetornaDadosDeBaixaDosAjustes(objConcil.strConfPr, LConsulta.FieldByName('EMPRESA').AsString);
      LTransferencia.strCtaBai := fRetornaDadosDeBaixaDosAjustes(objConcil.strConfCt, LConsulta.FieldByName('EMPRESA').AsString);
      LTransferencia.strForTax := fRetornaDadosDeBaixaDosAjustes(objConcil.strConfFo, LConsulta.FieldByName('EMPRESA').AsString);
      LTransferencia.strEventoCancelamentoAjuste := fRetornaDadosDeBaixaDosAjustes(objConcil.strEventoCancelamentoAjuste, LConsulta.FieldByName('EMPRESA').AsString);

      LTransferencia.PortadorTransferencia := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPortadorTransferencia, LConsulta.FieldByName('EMPRESA').AsString);
      LTransferencia.PlanoDeContasTransferencia := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgPlanoDeContasTransferencia, LConsulta.FieldByName('EMPRESA').AsString);
      LTransferencia.CentroDeCustosTransferencia := fRetornaDadosDeBaixaDosAjustes(objConcil.CfgCentroDeCustosTransferencia, LConsulta.FieldByName('EMPRESA').AsString);

      LTransferencia.intConcil := LConsulta.FieldByName(LeftStr(objConcil.strCodAut, 4) + 'CONCIL').AsInteger;
      LTransferencia.blnTotali := False;

      LTransferencia.strSituacaoCadastro := RetornaSituacaoCadastroAjustesTransferencias(LConsulta.FieldByName('EMPRESA').AsString);

      If LConfiguracoesValidas Then
      Begin
        If Not LTransferencia.strPorBai.IsEmpty Then
          pGravaAjustes(LTransferencia, False, True, LConsulta);
      End;

      pGravaInconsistencia(LTransferencia);
      FreeAndNil(LTransferencia);

      LConsulta.Next;
    End;
  Finally
    FreeAndNil(LConsulta);
  End;
end;

function TConciliacaoCartoes.AgrupaRelatorioMktPorEmpresa: Boolean;
begin
  Result := False;

  If MatchStr(objConcil.strTabCon, ['MER_MLPGTO']) Then
  Begin
    If fCfgSis('MEREMP',varBoolean) Then
      Exit(True);
  End;
end;

function TConciliacaoCartoes.CartoesValidosParaRealizarAConciliacaoDoMercadoLivre: Boolean;
  Var
    LConsulta: TUniQuery;

    LCartoesMercadoLivre: String;

    LTotalCartoes: Integer;
begin
  Result := Not fCfgSis('BAIDEB', varBoolean);
  If Not Result Then
  Begin
    fMensagem('ATENÇÃO', 'Quando utiliza a configuração CFG_MERANA igual a Sim, ' +
                         'a configuração CFG_BAIDEB deve estar igual a Não.' + #13 +
                         'Entre nas configurações do Autcom, selecione e ajuste os valores das configurações.', ['&Ok']);

    Exit;
  End;

  LConsulta := fCriaQuery;

  Try
    LCartoesMercadoLivre := VarToStr(fCfgSis('MERCAR', varString)).Trim;

    If LCartoesMercadoLivre.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO', 'Quando utiliza a configuração CFG_MERANA igual a Sim, ' +
                           'é obrigatório a empresa possuir selecionado cartões na configuração CFG_MERCAR.' + #13 +
                           'Entre nas configurações do Autcom, selecione a configuração CFG_MERCAR e ' +
                           'selecione os cartões pertencentes ao Mercado Livre.', ['&Ok']);
      Exit(False);
    End;

    LConsulta.SQL.Text := 'SELECT CAR_CODCAR, CAR_CTAAJU, CAR_CTAFRE, CAR_CTATAX, CAR_CTACUP ' +
                          'FROM CADCAR ' +
                          'WHERE CAR_CODCAR IN (' + fRetStrToSQLIn(LCartoesMercadoLivre) + ') ' +
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
                            '  AND CON_CODEMP = "' + VS_strCodEmp + '" ' +
                            '  AND (CON_CTAAJU IS NOT NULL AND CON_CTAFRE IS NOT NULL AND CON_CTATAX IS NOT NULL AND CON_CTACUP IS NOT NULL) ';

      LConsulta.Open;

      Result := LConsulta.RecordCount = LTotalCartoes;

      If Not Result Then
        fMensagem('ATENÇÃO', 'Para continuar com a conciliação, todos os cartões selecionados para o Mercado Livre ' +
                             'devem estar configurados: ' + #13 +
                             '-Plano de Contas de Taxas; ' + #13 +
                             '-Plano de Contas de Cancelamentos/Ajustes; ' + #13 +
                             '-Plano de Contas de Fretes;' + #13 +
                             '-Plano de Contas de Cupons.', ['&Ok']);
    End;
  Finally
    LConsulta.Close;

    FreeAndNil(LConsulta);
  End;
end;

constructor TConciliacaoCartoes.Create;
begin
  blnReabre  := False;
  frxSemRed  := TfrxDBDataset.Create(Application);
  frxListArq := TfrxDBDataset.Create(Application);
  frxTotBan  := TfrxDBDataset.Create(Application);
  frxTotalFinal := TfrxDBDataset.Create(Application);
  lstNomArq  := TStringList.Create;
  lstSemArq  := TStringList.Create;

  arrTotRel[0].strTipCar := 'ANTECIPACAO';
  arrTotRel[0].intQtdCar := 0;
  arrTotRel[0].fltValCar := 0;
  arrTotRel[0].fltValLiq := 0;
  arrTotRel[0].ValorTaxas := 0;
  arrTotRel[0].ValorFrete := 0;
  arrTotRel[0].ValorAjustes := 0;
  arrTotRel[1].strTipCar := 'CREDITO_PARCELADO';
  arrTotRel[1].intQtdCar := 0;
  arrTotRel[1].fltValCar := 0;
  arrTotRel[1].fltValLiq := 0;
  arrTotRel[1].ValorTaxas := 0;
  arrTotRel[1].ValorFrete := 0;
  arrTotRel[1].ValorAjustes := 0;
  arrTotRel[2].strTipCar := 'CREDITO_ROTATIVO';
  arrTotRel[2].intQtdCar := 0;
  arrTotRel[2].fltValCar := 0;
  arrTotRel[2].fltValLiq := 0;
  arrTotRel[2].ValorTaxas := 0;
  arrTotRel[2].ValorFrete := 0;
  arrTotRel[2].ValorAjustes := 0;
  arrTotRel[3].strTipCar := 'DEBITO';
  arrTotRel[3].intQtdCar := 0;
  arrTotRel[3].fltValCar := 0;
  arrTotRel[3].fltValLiq := 0;
  arrTotRel[3].ValorTaxas := 0;
  arrTotRel[3].ValorFrete := 0;
  arrTotRel[3].ValorAjustes := 0;
  arrTotRel[4].strTipCar := 'PIX';
  arrTotRel[4].intQtdCar := 0;
  arrTotRel[4].fltValCar := 0;
  arrTotRel[4].fltValLiq := 0;
  arrTotRel[4].ValorTaxas := 0;
  arrTotRel[4].ValorFrete := 0;
  arrTotRel[4].ValorAjustes := 0;
  arrTotRel[5].strTipCar := 'BOLETO';
  arrTotRel[5].intQtdCar := 0;
  arrTotRel[5].fltValCar := 0;
  arrTotRel[5].fltValLiq := 0;
  arrTotRel[5].ValorTaxas := 0;
  arrTotRel[5].ValorFrete := 0;
  arrTotRel[5].ValorAjustes := 0;

  objTotCan.strTipCar := 'CANCELAMENTO';
  objTotCan.intQtdCar := 0;
  objTotCan.fltValCar := 0;
  objTotCan.fltValLiq := 0;
  objTotCan.ValorTaxas := 0;
  objTotCan.ValorFrete := 0;
  objTotCan.ValorAjustes := 0;

  blnGraAju      := fCfgSis('BAIDEB') = 'S';
  blnAjuCon      := True;
  blnAutomatica  := False;
  blnResolverAPI := False;

  FLancarAjustesACredito := fCfgSis('AJUCRE') = 'S';
  FTemAjusteACredito := False;

  blnConciliarDataImportacao := False;

  FConciliacaoComPixAtivado := False;
  LConciliacaoComBoletoAtivado := False;

  FCartoesConciliar := '';

  FLiberacaoTransferencia := fCfgSis('USAAUT', varBoolean);

  FFiltrarAutorizacaoNSU := False;

  objConcil.CodigoEmpresaFixaParaBaixa := '';
end;

procedure TConciliacaoCartoes.DeletarValoresLiquidosZerados(
  ADataset: TUniClientDataset; AFieldName: string);
begin
  ADataset.First;
  try
    while not ADataset.Eof do
    begin
      if fStrToFloat(ADataset.FieldByName(AFieldName).AsString) = 0 then
        ADataset.Delete
      else
        ADataset.Next;
    end;
  finally
    ADataset.First;
  end;
end;

function TConciliacaoCartoes.fDigPeriodo(strDescricaoLabel: String = ''): Boolean;
var
  frmDigPeriodo: TfrmDigPeriodo;
  LConfiguracoesValidadasEstabelecimento: String;
Begin
  LConfiguracoesValidadasEstabelecimento := objConcil.strConfEs;

  If fExisteEstabelecimentosDuplicados(LConfiguracoesValidadasEstabelecimento) Then
  Begin
    LConfiguracoesValidadasEstabelecimento :=
      LConfiguracoesValidadasEstabelecimento
        .Replace(' ', '')
        .Replace('(', '')
        .Replace(')', '')
        .Replace(',', '/');

    pMensagemOk('Existe o mesmo código de estabelecimento da ' +
                 objConcil.strNomCon + ' configurado para uma ' +
                 ' ou mais empresas.' + #13 +
                 'Verifique a(s) configuração(ões) '+
                 LConfiguracoesValidadasEstabelecimento + '.' + #13 +
                 'Para empresas que não possuem código de ' +
                 'estabelecimento, deixe a configuração em branco.' + #13 +
                 'A operação foi cancelada.', 0, 220);
    blnReabre := False;
    Result    := False;
    Exit;
  End;

  If objConcil.strConfEs.Equals('CFG_MEREST') Then
  Begin
    If fCfgSis('MERANA', varBoolean) Then
    Begin
      Result := CartoesValidosParaRealizarAConciliacaoDoMercadoLivre;

      If Not Result Then
      Begin
        blnReabre := False;
        Exit;
      End;
    End;
  End;

  {**************************************}
  {* PEGANDO O PERÍODO PARA CONCILIAÇÃO *}
  {***********************************AJ*}
  Result := False;
  While Not Result Do
  Begin
    If Assigned(frmDigPeriodo) Then
      FreeAndNil(frmDigPeriodo);
    pCriarFormularios(TfrmDigPeriodo, frmDigPeriodo);
    frmDigPeriodo.Caption   := 'Conciliação de Cartões';
    frmDigPeriodo.blnConcil := True;
    frmDigPeriodo.objConcil := objConcil;
    If Not strDescricaoLabel.IsEmpty Then
      frmDigPeriodo.lblPeriodoConciliacao.Caption := strDescricaoLabel;

    frmDigPeriodo.ShowModal;
    If Not frmDigPeriodo.blnConfirma Then
    Begin
      FreeAndNil(frmDigPeriodo);
      Exit;
    End;

    //Data e array para filtrar os registros de arquivos de conciliação
    dtaDtaIni := StrtoDate(frmDigPeriodo.mskDtaIniConcil.Text);
    dtaDtaFim := StrtoDate(frmDigPeriodo.mskDtaFinConcil.Text);
    strDtaIni := frmDigPeriodo.mskDtaIniConcil.Text;
    strDtaFim := frmDigPeriodo.mskDtaFinConcil.Text;
    arrEmpresa:= frmDigPeriodo.arrEmpresa;
    arrPonVen := frmDigPeriodo.arrPonVen;
    arrCodigoConciliacao := frmDigPeriodo.arrCodigoConciliacao;

    blnConciliarDataImportacao := frmDigPeriodo.chkDataImportacao.Checked;
    strIDConciliacao           := frmDigPeriodo.edtIDConciliacao.Text;

    FreeAndNil(frmDigPeriodo);

    If dtaDtaFim - dtaDtaIni > 365 Then
      fMensagem('ATENÇÃO', 'O filtro para conciliação não pode ser maior que 365 dias (1 ano)!', ['&OK'])
    Else
      Result := True;
  End;
End;

function TConciliacaoCartoes.fRetPesqPonVen(intTipo: Integer = 0): String;
Var
    intCont: Integer;
begin
  //intTipo= 0 Conciliacao - =1 Cancelamento
  Result := '';

  If (High(arrEmpresa) < 0) And (High(arrPonVen) < 0) And (High(arrCodigoConciliacao) < 0) Then
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
      Result := Result + ' ' + objConcil.strCamCon + ' IN (SELECT DISTINCT SIS_VALCFG FROM CFGSIS WHERE ';

      If objConcil.strConfEs = 'CFG_CIEEST' Then
        Result := Result + ' SIS_CODCFG IN ("CFG_CIEEST", "CFG_CIELNK") '
      Else If objConcil.strConfEs = 'CFG_REDEST' Then
        Result := Result + ' SIS_CODCFG IN ("CFG_REDEST", "CFG_REDECO") '
      Else If objConcil.strConfEs = 'CFG_STOEST' Then
        Result := Result + ' SIS_CODCFG IN ("CFG_STOEST", "CFG_STOLNK") '
      Else If objConcil.strConfEs = 'CFG_PAGEST' Then
        Result := Result + ' SIS_CODCFG IN ("CFG_PAGEST", "CFG_PAGLNK") '
      Else If objConcil.strConfEs = 'CFG_GETEST' Then
        Result := Result + ' SIS_CODCFG IN ("CFG_GETEST", "CFG_GETECO") '
      Else
        Result := Result + ' SIS_CODCFG="' + objConcil.strConfEs + '" ';

      Result := Result + ' AND COALESCE(SIS_VALCFG, "") <> "" AND SIS_CODEMP IN (';
      For intCont := 0 To High(arrEmpresa) Do
        Result := Result + '"' + arrEmpresa[intCont].strCodigo + '",';
      Result := Copy(Result, 1, Length(Result) - 1) + ')) ';
    End;
  End;

  If (High(arrPonVen) >= 0) Then
  Begin
    Result := ' AND ( (' + objConcil.strCamCon + ' IN (';
    For intCont := 0 To High(arrPonVen) Do
      Result := Result + '"' + arrPonVen[intCont].strCodigo + '",';
    Result := Copy(Result, 1, Length(Result) - 1) + ') ) ';
  End;

  Result := Result + RetornaFiltroCodigoConciliacao;

  Result := Result + ') ';
end;

procedure TConciliacaoCartoes.GerarTotalFinalLiquido;
begin
  cdsTotalFinal.First;
  while not cdsTotalFinal.EOF do
  begin
    cdsTotalFinal.Edit;

    cdsTotalFinal.FieldByName('TOTSAI').AsFloat := Abs(cdsTotalFinal.FieldByName('TOTSAI').AsFloat);
    cdsTotalFinal.FieldByName('TOTLIQ').AsFloat := RoundTo(
                                                           cdsTotalFinal.FieldByName('TOTLIQ').AsFloat +
                                                           (cdsTotalFinal.FieldByName('TOTENT').AsFloat -
                                                            cdsTotalFinal.FieldByName('TOTSAI').AsFloat -
                                                            (cdsTotalFinal.FieldByName('TOTTAX').AsFloat)), -2);
    cdsTotalFinal.Post;
    cdsTotalFinal.Next;
  end;
end;

procedure TConciliacaoCartoes.GravarTotalizador(ARecebedor,
                                                AEstabelecimento: String;
                                                AValorBruto,
                                                ATaxa: Double;
                                                AInconsistencia: TInconsist = nil;
                                                ATotalizarSomenteTaxa: Boolean = False);
begin
  if (AValorBruto = 0) or (AEstabelecimento.Trim.IsEmpty) then Exit;

  If not cdsTotalFinal.Active Then
      cdsTotalFinal.Open;

  if not cdsTotalFinal.Locate('RECEBE', VarArrayOf([ARecebedor]), []) Then
  begin
    cdsTotalFinal.Append;
    cdsTotalFinal.FieldByName('RECEBE').AsString := ARecebedor;
    cdsTotalFinal.FieldByName('ESTABE').AsString := AEstabelecimento;
  end
  else
    cdsTotalFinal.Edit;
  try
    if ATotalizarSomenteTaxa then
      cdsTotalFinal.FieldByName('TOTTAX').AsFloat := cdsTotalFinal.FieldByName('TOTTAX').AsFloat +
                                                     (ATaxa)
    else
    begin
      if Assigned(AInconsistencia) then
      begin

        if AInconsistencia.strDescri.Equals('TRANSFERÊNCIAS') then
        begin
          cdsTotalFinal.FieldByName('TOTSAI').AsFloat := cdsTotalFinal.FieldByName('TOTSAI').AsFloat -
                                                         (AValorBruto + (ATaxa));
        end
        else
        begin
          if AValorBruto > 0 then
          begin
              cdsTotalFinal.FieldByName('TOTENT').AsFloat := cdsTotalFinal.FieldByName('TOTENT').AsFloat +
                                                             AValorBruto;
          end
          else
          begin
            if not Trim(AInconsistencia.strNomCli).Equals('Contestação') then
              cdsTotalFinal.FieldByName('TOTSAI').AsFloat := cdsTotalFinal.FieldByName('TOTSAI').AsFloat +
                                                             (AValorBruto)
            else
              cdsTotalFinal.FieldByName('TOTENT').AsFloat := cdsTotalFinal.FieldByName('TOTENT').AsFloat +
                                                              AValorBruto;
          end;

          cdsTotalFinal.FieldByName('TOTTAX').AsFloat := cdsTotalFinal.FieldByName('TOTTAX').AsFloat +
                                                          (ATaxa);
        end;

      end
      else
      begin
        cdsTotalFinal.FieldByName('TOTENT').AsFloat := cdsTotalFinal.FieldByName('TOTENT').AsFloat +
                                                       AValorBruto;
      end;

    end;

  finally
    cdsTotalFinal.Post;
  end;
end;

function TConciliacaoCartoes.fRetNomBandeira(strNumCar: String;
  ATipoCartao: String = ''): String;
begin

  If Not fEmptyStr(FBandeiraCartao) Then
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

  If fEmptyStr(objConcil.strChavePrimaria) Then
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

function TConciliacaoCartoes.fRetornaDadosDeBaixaDosAjustes(strConfiguracao, strEmpresaConfiguracao: String): String;
begin
  Result := '';

  If Not fEmptyStr(strEmpresaConfiguracao) Then
    Result := fCfgSis(strConfiguracao, varString, strEmpresaConfiguracao);
end;

procedure TConciliacaoCartoes.pGravaListaArquivo(strNomArq: String; strTipo: String = '0');
Begin
  //Tipo 0 Conciliados (TODOS) Tipo 1 Arquivos Faltando (REDECARD)
  If strTipo = '0' Then
  Begin
    If lstNomArq.IndexOf(strNomArq) < 0 Then
      lstNomArq.Add(strNomArq);
  End
  Else
  Begin
    If lstSemArq.IndexOf(strNomArq) < 0 Then
      lstSemArq.Add(strNomArq);
  End;
End;
procedure TConciliacaoCartoes.pGravaTotal(strTipo: String; fltValMar, fltValor: Double;
  AValorTaxas: Double = 0; AValorFrete: Double = 0; AValorAjustes: Double = 0;
  AValorCupom: Double = 0; AQuantidade: Integer = 1);
  Const
    TIPOS: Array of String = ['ANTECIPAÇÃO', 'CRÉDITO PARCELADO', 'CRÉDITO ROTATIVO', 'DÉBITO', 'PIX','BOLETO'];

  Var
    LIndice: Integer;
Begin
  For LIndice := 0 To Length(TIPOS) - 1 Do
  Begin
    If TIPOS[LIndice] = strTipo Then
    Begin
      arrTotRel[LIndice].intQtdCar := arrTotRel[LIndice].intQtdCar + AQuantidade;
      arrTotRel[LIndice].fltValLiq := arrTotRel[LIndice].fltValLiq + fFormataFloat(fltValMar, 2);
      arrTotRel[LIndice].fltValCar := arrTotRel[LIndice].fltValCar + fFormataFloat(fltValor, 2);
      arrTotRel[LIndice].ValorTaxas := arrTotRel[LIndice].ValorTaxas + fFormataFloat(AValorTaxas, 2);
      arrTotRel[LIndice].ValorFrete := arrTotRel[LIndice].ValorFrete + fFormataFloat(AValorFrete, 2);
      arrTotRel[LIndice].ValorAjustes := arrTotRel[LIndice].ValorAjustes + fFormataFloat(AValorAjustes, 2);
      arrTotRel[LIndice].ValorCupom := arrTotRel[LIndice].ValorCupom + fFormataFloat(AValorCupom, 2);

      Break;
    End;
  End;
End;

procedure TConciliacaoCartoes.pGravaTotBan(strEstabe, strNomBan: String;
  fltValBan, fltLiqBan: Double; intConcil: Integer = 1);
begin
  With cdsTotban Do
  Begin
    If fEmptyStr(strNomBan) Then
      Exit;

    If Not Active Then
      Open;

    If Not Locate('ESTABE;NOMBAN;CONCIL', VarArrayOf([strEstabe, strNomban, intConcil]), []) Then
    Begin
      Append;
      FieldByName('ESTABE').AsString := strEstabe;
      FieldByName('NOMBAN').AsString := strNomban;
      FieldByName('QTDBAN').Value    := 1;
      FieldByName('VALBAN').Value    := fltValBan;
      FieldByName('LIQBAN').Value    := fltLiqBan;
      FieldByName('CONCIL').Value    := intConcil;
    End
    Else
    Begin
      Edit;
      FieldByName('QTDBAN').AsInteger:= FieldByName('QTDBAN').AsInteger + 1;
      FieldByName('VALBAN').Value    := FieldByName('VALBAN').Value + fltValBan;
      FieldByName('LIQBAN').Value    := FieldByName('LIQBAN').Value + fltLiqBan;
    End;
    Post;
  End;
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

  blnCentoDeCustoObrigatorio := fCfgSis('CTPOBE', varBoolean);

  strCodigoCartao := '';

  qryConsulta := fCriarQuery('SELECT * FROM CONPOR WHERE CON_CODCAR=:CODCAR ORDER BY CON_CODEMP');

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
        If objConcil.strTabCon.Equals('RED_APPGTO') and (objConcil.CodigoEmpresaFixaParaBaixa <> '') Then
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
          cdsBaiCar.FieldByName('FOR_NOMFOR').AsString := fRetNomFornecedor(qryConsulta.FieldByName('CON_FORTAX').AsString);

          cdsBaiCar.FieldByName('DESC_EVE_CREDITO').AsString := fRetNomEvento(qryConsulta.FieldByName('CON_EVECRE').AsString);
          cdsBaiCar.FieldByName('DESC_EVE_TAXA').AsString    := fRetNomEvento(qryConsulta.FieldByName('CON_EVETAX').AsString);
          cdsBaiCar.FieldByName('DESC_EVE_DEBITO').AsString  := fRetNomEvento(qryConsulta.FieldByName('CON_EVEDEB').AsString);

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

procedure TConciliacaoCartoes.EsconderCamposDeCuponsMkt(AEsconder: Boolean);
  Const
    LCampos: Array Of String = ['rllDesCupomMarketPlace', 'rllCupomMarketPlace', 'rllDesTotalCuponsMarketPlace', 'rllTotalCuponsMarketPlace',
                                'Memo270', 'Memo269', 'rllValorCuponsConciliados', 'rllPercentualCuponsConciliadosMkt', 'rllValorCuponsZeradosMkt',
                                'rllPercentualCuponsZeradosMkt', 'rllValorCuponsDivergentesMkt', 'rllPercentualCuponsDivergentesMkt',
                                'Memo221', 'rllQuantidadeCuponsDivergentesMkt', 'rllBrutoCuponsDivergentesMkt', 'rllValorTaxasCuponsDivergentesMkt',
                                'rllPercentualTaxasCuponsDivergentesMkt', 'rllValorFreteCuponsDivergentesMkt', 'rllPercentualFreteCuponsDivergentesMkt',
                                'rllValorAjustesCuponsDivergentesMkt', 'rllPercentualAjustesCuponsDivergentesMkt', 'rllValorCupomCuponsDivergentesMkt',
                                'rllPercentualCupomCuponsDivergentesMkt', 'Memo251', 'rllCuponsTotalConciliadosMkt', 'rllPercentualCuponsTotalConciliadosMkt',
                                'Memo250', 'Memo222', 'rllValorCuponsInconsistentesMkt', 'rllPercentualCuponsInconsistentesMkt', 'rllValorCuponsBaixadosConcMkt',
                                'rllPercentualCuponsBaixadosConcMkt', 'rllValorCuponsBaixadosManualMkt', 'rllPercentualCuponsBaixadosManualMkt', 'Memo264',
                                'Memo266', 'Memo257', 'Memo256', 'rllValorCuponsGeralMkt', 'rllPercentualCuponsGeralMkt', 'Memo263', 'Memo261',
                                'rllValorCuponsBaixadosMkt', 'rllPercentualCuponsBaixadosMkt'];

  Var
    LCampoEsconder: String;
begin
  If Not AEsconder Then
    Exit;

  For LCampoEsconder In LCampos Do
    TfrxMemoView(frxPagina.FindObject(LCampoEsconder)).Visible := False;
end;

function TConciliacaoCartoes.ExibeRelatorioConciliacaoMkt(
  ADescricaoCampos: TDescricaoRelatorio): Boolean;
  Var
    LRegistrosNaoEncontrados,
    LRegistrosBaixados,
    LValorBrutoDivergente,
    LRegistrosConciliadosZerados,
    LRegistrosConciliadosInconsistentes,
    LRegistrosConciliadosCupomInconsistente,
    LListaArquivos: Boolean;

    LContador,
    LQuantidadeBaixados: Integer;
    LOrdenacao: Integer;

    LBrutoBaixados,
    LLiquidoBaixados: Double;

    LFiltroInconsistenciasMkt: TfrmFiltroInconsistenciasMkt;
begin
  TfrmGravando.fExecutarModal(pAcertaDadosDeBaixaOtimizadaPorEmpresa, 'Aguarde... Atualizando dados de conciliação.', '');

  pCriarFormularios(TfrmFiltroInconsistenciasMkt, LFiltroInconsistenciasMkt);
  LFiltroInconsistenciasMkt.Operadora := objConcil.strNomCon;
  LFiltroInconsistenciasMkt.ShowModal;

  LRegistrosNaoEncontrados := LFiltroInconsistenciasMkt.chkNaoEncontrados.Checked;
  LRegistrosBaixados := LFiltroInconsistenciasMkt.chkBaixados.Checked;
  LValorBrutoDivergente := LFiltroInconsistenciasMkt.chkValorBrutoDivergente.Checked;
  LRegistrosConciliadosZerados := LFiltroInconsistenciasMkt.chkConciliadosZerado.Checked;
  LRegistrosConciliadosInconsistentes := LFiltroInconsistenciasMkt.chkTaxasFreteInconsistentes.Checked;
  LRegistrosConciliadosCupomInconsistente := LFiltroInconsistenciasMkt.chkCupomInconsistente.Checked;
  LListaArquivos := LFiltroInconsistenciasMkt.chkListaArquivos.Checked;
  LOrdenacao := LFiltroInconsistenciasMkt.rdgOrdenar.ItemIndex;

  Result := LFiltroInconsistenciasMkt.ModalResult = mrOK;

  FreeAndNil(LFiltroInconsistenciasMkt);

  If Not Result Then
    Exit;

  cdsInconsistencia.Filtered := False;
  cdsInconsistencia.Filter   := 'DESCRI <> ' + QuotedStr('');

  If Not LRegistrosNaoEncontrados Then
    cdsInconsistencia.Filter := cdsInconsistencia.Filter + ' AND DESCRI <> ''Registro do arquivo não encontrado nos lançamentos do sistema'' ';

  If Not LRegistrosBaixados Then
    cdsInconsistencia.Filter := cdsInconsistencia.Filter + ' AND DESCRI <> ''Pedido já foi baixado manualmente'' ' +
                                                           ' AND DESCRI <> ''Pedido já foi baixado através de conciliação automática'' ';

  If Not LValorBrutoDivergente Then
    cdsInconsistencia.Filter := cdsInconsistencia.Filter + ' AND DESCRI <> ''Pedidos com valor bruto divergente'' ';

  If Not LRegistrosConciliadosZerados Then
    cdsInconsistencia.Filter := cdsInconsistencia.Filter + ' AND DESCRI <> ''Pedidos cancelados (conciliados)'' ';

  If Not LRegistrosConciliadosInconsistentes Then
    cdsInconsistencia.Filter := cdsInconsistencia.Filter + ' AND DESCRI <> ''Pedidos conciliados com valor de taxas ou frete divergentes'' ';

  If Not LRegistrosConciliadosCupomInconsistente Then
    cdsInconsistencia.Filter := cdsInconsistencia.Filter + ' AND DESCRI <> ''Pedidos conciliados com valor de cupom divergente'' ';

  cdsInconsistencia.Filter := cdsInconsistencia.Filter + ' AND DESCRI <> ''Cancelamentos/Ajustes'' ';
  cdsInconsistencia.Filter := cdsInconsistencia.Filter + ' AND DESCRI <> ''TRANSFERÊNCIAS'' ';
  cdsInconsistencia.Filter := cdsInconsistencia.Filter + ' AND DESCRI <> ''Pedidos em disputa/bloqueados'' ';

  cdsInconsistencia.Filtered := True;

  cdsInconsistencia.Open;

  If LOrdenacao = 0 Then
    cdsInconsistencia.IndexFieldNames := 'DESEMP;DESCRI;TIPCAR;DTAVEN'
  Else If LOrdenacao = 1 Then
  Begin
     cdsInconsistencia.IndexFieldNames := 'DESEMP;DESCRI;TIPCAR;NUMCCD;';

    If MatchStr(objConcil.strNomCon, ['MAGAZINE LUIZA']) Then
      cdsInconsistencia.IndexFieldNames := 'DESEMP;DESCRI;TIPCAR;NUMCCD;PARCEL;DTAVEN';
  End;

  frxPagina.Script.Variables['NOMREL'] := ADescricaoCampos.NomeRelatorio;

  TfrxMemoView(frxPagina.FindObject('rllDesChave1Mkt')).Text := ADescricaoCampos.NomeChave1;
  TfrxMemoView(frxPagina.FindObject('rllDesChave2Mkt')).Text := ADescricaoCampos.NomeChave2;
  TfrxMemoView(frxPagina.FindObject('rllDesChaveCancelamento1Mkt')).Text := ADescricaoCampos.NomeChave1;
  TfrxMemoView(frxPagina.FindObject('rllDesChaveCancelamento2Mkt')).Text := ADescricaoCampos.NomeChave2;

  If ADescricaoCampos.EsconderChave2 Then
  Begin
    TfrxMemoView(frxPagina.FindObject('rllDesChave2Mkt')).Visible := False;
    TfrxMemoView(frxPagina.FindObject('rllDesChaveCancelamento2Mkt')).Visible := False;
    TfrxMemoView(frxPagina.FindObject('rllChave2Mkt')).Visible := False;
    TfrxMemoView(frxPagina.FindObject('rllChaveCancelamento2Mkt')).Visible := False;

    TfrxMemoView(frxPagina.FindObject('rllDesChave1Mkt')).Width := TfrxMemoView(frxPagina.FindObject('rllDesChave1Mkt')).Width +
                                                                   TfrxMemoView(frxPagina.FindObject('rllDesChave2Mkt')).Width;
    TfrxMemoView(frxPagina.FindObject('rllChave1Mkt')).Width := TfrxMemoView(frxPagina.FindObject('rllChave1Mkt')).Width +
                                                                TfrxMemoView(frxPagina.FindObject('rllChave2Mkt')).Width;

    TfrxMemoView(frxPagina.FindObject('rllDesChaveCancelamento1Mkt')).Width := TfrxMemoView(frxPagina.FindObject('rllDesChaveCancelamento1Mkt')).Width +
                                                                               TfrxMemoView(frxPagina.FindObject('rllDesChaveCancelamento2Mkt')).Width;
    TfrxMemoView(frxPagina.FindObject('rllChaveCancelamento1Mkt')).Width := TfrxMemoView(frxPagina.FindObject('rllChaveCancelamento1Mkt')).Width +
                                                                            TfrxMemoView(frxPagina.FindObject('rllChaveCancelamento2Mkt')).Width;
  End;

  If ADescricaoCampos.ExibirEmp Then
  Begin
    TfrxMemoView(frxPagina.FindObject('mmoCodEmp')).Visible := True;
    TfrxMemoView(frxPagina.FindObject('rllCodEmp')).Visible := True;
  End;

  EsconderCamposDeCuponsMkt(ADescricaoCampos.EsconderCupons);

  TfrxGroupHeader(frxPagina.FindObject('GroupHeader_Empresa')).Visible :=  AgrupaRelatorioMktPorEmpresa;
  TfrxGroupFooter(frxPagina.FindObject('GroupFooter_Empresa')).Visible :=  AgrupaRelatorioMktPorEmpresa;

  //Gravando Arquivos conciliados
  If LListaArquivos Then
  Begin
    For LContador := 0 to lstNomArq.Count - 1 Do
    Begin
      cdsListArq.Insert;
      cdsListArq.FieldByName('NOMARQ').AsString := lstNomArq[LContador];
      cdsListArq.FieldByName('DESCRI').AsString := 'ARQUIVOS CONCILIADOS';
      cdsListArq.Post;
    End;

    TfrxMemoView(frxPagina.FindObject('Subreport1')).Visible := True;
    TfrxMemoView(frxPagina.FindObject('Child1')).Visible := True;
    cdsListArq.IndexFieldNames := 'DESCRI;NOMARQ';
    FreeAndNil(lstNomArq);
  End;

  {************************************************}
  {* GERANDO LISTA DE RVs INCONSISTENTES REDECARD *}
  {*********************************************AJ*}
  cdsSemRed := TUniClientDataSet.Create(Application);
  cdsSemRed.FieldDefs := cdsInconsistencia.FieldDefs;
  cdsSemRed.CreateDataSet;

  TfrxMemoView(frxPagina.FindObject('Subreport2')).Visible := False;
  TfrxMemoView(frxPagina.FindObject('Child2')).Visible := False;

  TfrxReportPage(frxPagina.FindObject('qckRedeCard')).Visible := False;
  TfrxReportPage(frxPagina.FindObject('qckMarketPlace')).Visible := True;

  frxRelatorio.DataSet := cdsInconsistencia;
  frxListArq.DataSet   := cdsListArq;
  frxSemRed.DataSet    := cdsSemRed;
  frxTotBan.DataSet    := cdsTotBan;
  frxTotalFinal.DataSet := cdsTotalFinal;

  frxPagina.DotMatrixReport             := False;
  frxPagina.PrintOptions.PrintMode      := pmScale;
  frxPagina.PrintOptions.PrintOnSheet   := 9; //A4
  frxPagina.Script.Variables['NOMEMP']  := fRetNomeEmpresa;
  frxPagina.Script.Variables['PERIODO'] := 'Período de ' + strDtaIni + ' até ' + strDtaFim;

  TfrxReportPage(frxPagina.FindObject('qckRedeCard')).PaperSize := 9;
  TfrxReportPage(frxPagina.FindObject('qckMarketPLace')).PaperSize := 9;

  TfrxBand(frxPagina.FindObject('rlbSumarioMkt')).StartNewPage := cdsInconsistencia.RecordCount > 0;

  frxPagina.Script.Variables['QUANTIDADECONCILIADOSMKT'] := arrTotRel[2].intQtdCar;
  frxPagina.Script.Variables['BRUTOCONCILIADOSMKT'] := arrTotRel[2].fltValCar;
  frxPagina.Script.Variables['LIQUIDOCONCILIADOSMKT'] := arrTotRel[2].fltValLiq;
  frxPagina.Script.Variables['TAXASCONCILIADOSMKT'] := arrTotRel[2].ValorTaxas;
  frxPagina.Script.Variables['FRETECONCILIADOSMKT'] := arrTotRel[2].ValorFrete;
  frxPagina.Script.Variables['AJUSTESCONCILIADOSMKT'] := arrTotRel[2].ValorAjustes;
  frxPagina.Script.Variables['CUPONSCONCILIADOSMKT'] := arrTotRel[2].ValorCupom;

  TfrxMemoView(frxPagina.FindObject('rllQuantidadeCancelamentoMkt')).Text := objTotCan.intQtdCar.ToString;
  frxPagina.Script.Variables['QUANTIDADECANCELADOSMKT'] := objTotCan.intQtdCar;
  frxPagina.Script.Variables['BRUTOCANCELADOSMKT'] := objTotCan.fltValCar;
  frxPagina.Script.Variables['LIQUIDOCANCELADOSMKT'] := objTotCan.fltValLiq;

  RetornaTotaisValoresQueSeraoBaixados(LQuantidadeBaixados,
                                       LBrutoBaixados,
                                       LLiquidoBaixados);

  frxPagina.Script.Variables['QUANTIDADEBAIXADOSMKT'] := LQuantidadeBaixados;
  frxPagina.Script.Variables['BRUTOBAIXADOSMKT'] := LBrutoBaixados;
  frxPagina.Script.Variables['LIQUIDOBAIXADOSMKT'] := LLiquidoBaixados;

  TfrxMemoView(frxPagina.FindObject('rllZebraMkt')).Highlight.Color := fCfgSis('CORZEB');

  TfrxMemoView(frxPagina.FindObject('rlbSomaTotalMkt')).Visible := True;

  TfrxMemoView(frxPagina.FindObject('Subreport11')).Visible := False;
  TfrxMemoView(frxPagina.FindObject('Child9')).Visible := False;

  If (blnGraAju) Then
    TfrxMemoView(frxPagina.FindObject('rllTextoCancelamentoMkt')).Text := IIF(blnAjuCon,
                                                                              '**Lançamentos de Cancelamentos/Ajustes já lançados na Movimentação Bancária. '+
                                                                              ' Verificar a necessidade de lançar novamente manualmente caso estornado.',
                                                                              '**Lançamentos de Cancelamentos/Ajustes serão lançados automaticamente na Movimentação Bancária.');

  pPreviewReport('TConciliacaoCartoes', ADescricaoCampos.NomeRelatorio, frxPagina);
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
    LValorBruto := cdsConCar.FieldByName(objConcil.strValBru).AsFloat;
    If AValorBruto <> 0.00 Then
      LValorBruto := AValorBruto;
  End;

  If intConcil <> 0 Then
  Begin
    If blnPesquisaBaixado Then
    Begin
      If fBuscaCartaoBaixado(strNumCCD, strNumNsu, strCodEmp, strParcel, dtaDtaCup, True) Then
      Begin
        strTmpLog := 'Cartão já foi baixado';
        FTextoInconsistencia := 'Cartão já foi baixado';

        Exit;
      End;
    End;
  End;

  LChaveCompletaSemEmpresa := False;
  LTolerancia := RetornaValorTolerancia(strCodEmp,0.2999999);

  If Not strCodEmp.IsEmpty Then
    Result := IIF((Not fEmptyStr(strNumCCD) And Not fEmptyStr(strNumNSU)),
                  cdsBaiCar.Locate('MCA_NUMCCD;MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_EMPRCX;MCA_MARDES', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup, strCodEmp, 'D']),[]),
                  False);

  If Not Result Then
  Begin
    Result := IIF((Not fEmptyStr(strNumCCD) And Not fEmptyStr(strNumNSU)),
                  cdsBaiCar.Locate('MCA_NUMCCD;MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_MARDES', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup, 'D']),[]),
                  False);

    LChaveCompletaSemEmpresa := Result;
  End;

  If (Not fEmptyStr(strCodEmp)) And (Not LChaveCompletaSemEmpresa) Then
  Begin
    If Not Result Then
      Result := IIF(Not fEmptyStr(strNumCCD),
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
      Result := (Not fEmptyStr(strNumCCD)) And
                (fBuscaCartaoBaixado(strNumCCD, strNumNSU, strCodEmp, strParcel, dtaDtaCup, True));

      If Result Then
      Begin
        Result    := False;
        strTmpLog := 'Cartão já foi baixado';
        FTextoInconsistencia := 'Cartão já foi baixado';
        Exit;
      End;
    End;

    If Not Result Then
      Result := IIF(Not fEmptyStr(strNumNSU),
                    cdsBaiCar.Locate('MCA_NUMNSU;PARDUP;MCA_DTACUP;MCA_EMPRCX;MCA_MARDES', VarArrayOf([UpperCase(strNumNSU),
                    strParcel, dtaDtaCup, strCodEmp, 'D']),[]),
                    False);
  End;

  If (Not Result) Or (LChaveCompletaSemEmpresa) Then
  Begin

    If Not Result Then
      Result := IIF(Not fEmptyStr(strNumCCD),
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
      Result := (Not fEmptyStr(strNumCCD)) And
                (fBuscaCartaoBaixado(strNumCCD, strNumNSU, strCodEmp, strParcel, dtaDtaCup, True));

      If Result Then
      Begin
        Result := False;
        strTmpLog := 'Cartão já foi baixado';
        FTextoInconsistencia := 'Cartão já foi baixado';
        Exit;
      End;
    End;

    If Not Result Then
      Result := IIF(Not fEmptyStr(strNumNSU),
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
      LValorBruto := cdsConCar.FieldByName(objConcil.strValBru).AsFloat;

    If AValorBruto <> 0.00 Then
      LValorBruto := AValorBruto;
  End;

  LTolerancia := RetornaValorTolerancia(strCodEmp,0.02999999);

  If (Not fEmptyStr(strCodEmp)) Then
  Begin
    Result := IIF((Not fEmptyStr(strNumCCD) And Not fEmptyStr(strNumNSU)),
                  cdsBaixad.Locate('MCA_NUMCCD;MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup, strCodEmp]),[]),
                  False);

    if not Result then
      Result := IIF(Not fEmptyStr(strNumCCD),
                    cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(strNumCCD),
                    strParcel, dtaDtaCup, strCodEmp]),[]),
                    False);

    If Not Result Then
      Result := IIF(Not fEmptyStr(strNumNSU),
                    cdsBaixad.Locate('MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP;MCA_EMPRCX', VarArrayOf([UpperCase(strNumNSU),
                    strParcel, dtaDtaCup, strCodEmp]),[]),
                    False);
  End;

  If Not Result Then
  Begin
    Result := IIF((Not fEmptyStr(strNumCCD) And Not fEmptyStr(strNumNSU)),
                  cdsBaixad.Locate('MCA_NUMCCD;MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup]),[]),
                  False);

  End;

  If Not Result Then
  Begin
    Result := IIF((Not fEmptyStr(strNumCCD) And Not fEmptyStr(strNumNSU)),
                  cdsBaixad.Locate('MCA_NUMCCD;MCA_NUMNSU;MCA_PARCEL;MCA_DTACUP', VarArrayOf([UpperCase(strNumCCD),
                  UpperCase(strNumNSU),strParcel, dtaDtaCup]),[]),
                  False);

  End;

  If Not Result Then
  Begin
    Result := IIF(Not fEmptyStr(strNumCCD),
                  cdsBaixad.Locate('MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP', VarArrayOf([UpperCase(strNumCCD),
                  strParcel, dtaDtaCup]),[]),
                  False);
    If Not Result Then
      Result := IIF(Not fEmptyStr(strNumNSU),
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
                   (Not fEmptyStr(cdsBaixad.FieldbyName('MCA_CHACON').AsString));

  If Result Then
  Begin
    cdsBaixad.Edit;
    cdsBaixad.FieldByName('VALIDADO').AsString := 'S';
    cdsBaixad.Post;
  End;
end;

Function TConciliacaoCartoes.fCartaoBloqueado(qryMovCar: TDataSet): Boolean;
Begin
  Result := untMovCar.CartaoBloqueado(qryMovCar, strRcxTcc);
End;

function TConciliacaoCartoes.fConciliaCartoes: Boolean;
begin
  Result := False;
end;

procedure TConciliacaoCartoes.pFiltraCancelamentos(strSQLCondicao: String;
                                                   objCampos: TCamposConcil;
                                                   strTipAju: String = '';
                                                   strAjuCre: String = '';
                                                   blnLimitaAut: Boolean = True);
  Var
    strSQL,
    strConfEm: String;
    qryCanc  : TUniQuery;
    objIncons: TInconsist;
    blnAjuCre: Boolean;
    strCodEmpresa: String;

    LDividePeloTotalDeParcelas: Boolean;
begin
  Try
    //Pega o Total
    strSQL := '';
    strSQL := strSQL + 'SELECT COALESCE(COUNT(*), 0) AS QTDE ';

    strSQL := strSQL + ' FROM ' + objCampos.strTabCon + ' A  ';
    strSQL := strSQL + ' WHERE ' + strSQLCondicao;

    qryCanc := fCriaQuery;

    qryCanc.SQL.Text := strSQL;
    qryCanc.Open;

    //Registos de Cancelamento (gravando nas inconisitências)
    If qryCanc.FieldByName('QTDE').AsInteger > 0 Then
    Begin
      strSQL := '';
      strSQL := strSQL + 'SELECT DISTINCT A.*, ';

      If Not fEmptyStr(strTipAju) Then
         strSQL := strSQL + strTipAju + ' AS TIPAJU, ';

      If Not fEmptyStr(strAjuCre) Then
         strSQL := strSQL + strAjuCre + ' AS AJUCRE, ';

      strSQL := strSQL + '  "S" AS MARCADO, ';

      If objConcil.strTabCon = 'MER_MLPGTO' Then
        strSQL := strSQL + '  CAST("0000-00-00" AS DATE) AS MER_DTARET, ';

      strSQL := strSQL + '  CAST("" AS CHAR(3)) AS EMPRESA ';
      strSQL := strSQL + ' FROM ' + objCampos.strTabCon + ' A ';
      strSQL := strSQL + ' WHERE ' + strSQLCondicao ;

      qryCanc.Close;
      qryCanc.SQL.Text := strSQL;
      qryCanc.Open;

      cdsAjustes := CriarClientDataSet(qryCanc);

      If (blnGraAju) And
         (blnResolverAPI) Then
        cdsResolverAPICanc := CriarClientDataSet(qryCanc);

      cdsAjustes.First;
      While Not cdsAjustes.Eof Do
      Begin
        strCodEmpresa := '';
        If objCampos.strTabCon <> 'KON_KOPGTO' Then
        Begin
          strConfEm := LeftStr(fCfgSisEmp(StringReplace(objCampos.strConfEs, 'CFG_', EmptyStr, []), cdsAjustes.FieldByName(objCampos.strCamCon).Value), 3);

          If objCampos.strTabCon.Equals('CIE_CIPGTO') Then
          Begin
            If strConfEm.Trim.IsEmpty Then
              strConfEm := EmpresaConfiguracao(objCampos.strConfEs.Replace('CFG_', EmptyStr), cdsAjustes.FieldByName(objCampos.strCamCon).Value);

            If strConfEm.Trim.IsEmpty Then
              strConfEm := EmpresaConfiguracao('CIELNK', cdsAjustes.FieldByName(objCampos.strCamCon).Value);
          End;

          If (objCampos.strTabCon = 'RED_EFIR34') And
             (strConfEm.Trim.IsEmpty) Then
            strConfEm := LeftStr(fCfgSisEmp('REDEST', cdsAjustes.FieldByName(objCampos.strCamCon).Value, True), 3);

          If (objCampos.strTabCon = 'STO_STPGTO') And
             (strConfEm.Trim.IsEmpty) Then
            strConfEm := LeftStr(fCfgSisEmp('STOLNK', cdsAjustes.FieldByName(objCampos.strCamCon).Value, True), 3);

          If (objCampos.strTabCon = 'GET_GEPGTO') And
             (strConfEm.Trim.IsEmpty) Then
            strConfEm := LeftStr(fCfgSisEmp('GETECO', cdsAjustes.FieldByName(objCampos.strCamCon).Value, True), 3);

          If MatchStr(objCampos.strTabCon, ['PAG_SEPGTO','PAG_APPGTO']) And
             (strConfEm.Trim.IsEmpty) Then
            strConfEm := LeftStr(fCfgSisEmp('PAGLNK', cdsAjustes.FieldByName(objCampos.strCamCon).Value, True), 3);

          If (objCampos.strTabCon = 'RED_EFIR34') And
             (strConfEm.Trim.IsEmpty) Then
            strConfEm := LeftStr(fCfgSisEmp('REDECO', cdsAjustes.FieldByName(objCampos.strCamCon).Value, True), 3);
        End
        Else
          strConfEm := cdsAjustes.FieldByName(objCampos.strCamCon).AsString;

        objIncons := TInconsist.Create;

        blnAjuCre := (cdsAjustes.FindField('AJUCRE') <> Nil) And
                     (cdsAjustes.FieldByName('AJUCRE').Value <> 0);

        LDividePeloTotalDeParcelas := objCampos.strNomCon = 'PAGSEGURO';
        If LDividePeloTotalDeParcelas Then
          LDividePeloTotalDeParcelas := cdsAjustes.FieldByName(objCampos.strTotPar).AsInteger > 1;

        Inc(objTotCan.intQtdCar);
        If blnAjuCre Then
        Begin
          objTotCan.fltValCar := objTotCan.fltValCar + cdsAjustes.FieldByName('AJUCRE').Value *
                                                       IIF(cdsAjustes.FieldByName('AJUCRE').Value > 0, 1, -1);
          objTotCan.fltValLiq := objTotCan.fltValLiq + cdsAjustes.FieldByName('AJUCRE').Value *
                                                       IIF(cdsAjustes.FieldByName('AJUCRE').Value > 0, 1, -1);

          If (objCampos.strTabCon = 'CIE_CIPGTO') Then
          Begin
            If (cdsAjustes.FieldByName('CIE_TIPREG').AsString = 'B') Then
              objTotCan.fltValCar := objTotCan.fltValCar - (cdsAjustes.FieldByName('AJUCRE').Value *
                                                            IIF(cdsAjustes.FieldByName('AJUCRE').Value > 0, 1, -1)) +
                                                           cdsAjustes.FieldByName('CIE_RO_BRU').AsFloat;
          End;
        End
        Else
        Begin
          If LDividePeloTotalDeParcelas Then
            objTotCan.fltValCar := objTotCan.fltValCar + fFormataFloat(cdsAjustes.FieldByName(objCampos.strValBru).Value /
                                                                       cdsAjustes.FieldByName(objCampos.strTotPar).AsInteger, 2) *
                                                         IIF(cdsAjustes.FieldByName(objCampos.strValBru).Value < 0, 1, -1)
          Else
            objTotCan.fltValCar := objTotCan.fltValCar + fFormataFloat(cdsAjustes.FieldByName(objCampos.strValBru).Value, 2) *
                                                         IIF(cdsAjustes.FieldByName(objCampos.strValBru).Value < 0, 1, -1);

          objTotCan.fltValLiq := objTotCan.fltValLiq + cdsAjustes.FieldByName(objCampos.strValLiq).Value *
                                                       IIF(cdsAjustes.FieldByName(objCampos.strValLiq).Value < 0, 1, -1);
        End;

        objIncons.strDescri := 'Cancelamentos/Ajustes';

        objIncons.strNomCli := '';
        if cdsAjustes.FindField('TIPAJU') <> Nil then
          objIncons.strNomCli := cdsAjustes.FieldByName('TIPAJU').AsString;

        objIncons.strNumDup := fStrZero('0', 12);
        objIncons.strAutori := IIF(cdsAjustes.FieldByName(objCampos.strNumNSU).Value <> '0',
                                   cdsAjustes.FieldByName(objCampos.strNumNSU).Value,
                                   '00000000000000');
        objIncons.strNumNSU := cdsAjustes.FieldByName(objCampos.strNumNSU).Value;
        objIncons.strNum_PV := cdsAjustes.FieldByName(objCampos.strCamCon).Value;

        if not fEmptyStr(objCampos.strNumCar) then
          objIncons.strNumCar := cdsAjustes.FieldByName(objCampos.strNumCar).AsString;

        objIncons.strTipCar := 'CANCELAMENTOS/AJUSTES';
        objIncons.strDta_CV := FormatDateTime('dd/mm/yyyy', IIF(cdsAjustes.FieldByName(objCampos.strDtaTra).IsNull,
                                                                cdsAjustes.FieldByName(objCampos.strDtaRec).Value,
                                                                cdsAjustes.FieldByName(objCampos.strDtaTra).Value));

        If (objCampos.strTabCon <> 'RED_EFIR34') and
           (objCampos.strTabCon <> 'BAN_BSCRED') Then
          objIncons.strParcel := IIF(cdsAjustes.FieldByName(objCampos.strNumPar).AsInteger = 0, '01', fStrZero(cdsAjustes.FieldByName(objCampos.strNumPar).AsString, 2)) + '/' +
                                 IIF(cdsAjustes.FieldByName(objCampos.strTotPar).AsInteger = 0, '01', fStrZero(cdsAjustes.FieldByName(objCampos.strTotPar).AsString, 2))
        else
          objIncons.strParcel := IIF(StrToInt(LeftStr(cdsAjustes.FieldByName(objCampos.strNumPar).AsString, 2)) = 0, '01', fStrZero(LeftStr(cdsAjustes.FieldByName(objCampos.strNumPar).AsString, 2), 2)) + '/' +
                                 IIF(StrToInt(RightStr(cdsAjustes.FieldByName(objCampos.strNumPar).AsString, 2)) = 0, '01', fStrZero(RightStr(cdsAjustes.FieldByName(objCampos.strNumPar).AsString, 2), 2));

        If (objCampos.strTabCon = 'CIE_CIPGTO') Then
        Begin
          If (cdsAjustes.FieldByName('CIE_TIPREG').AsString = '3') Then
            objIncons.strParcel := '01/01';
        End;

        objIncons.strNumCCD := IIF(blnLimitaAut,
                                   fStrZero(RightStr(Trim(cdsAjustes.FieldByName(objCampos.strCodAut).Value), 6), 6),
                                   fStrZero(Trim(cdsAjustes.FieldByName(objCampos.strCodAut).Value), 6));

        If blnAjuCre Then
        Begin
          objIncons.strValOri := FormatFloat('#,##0.00', cdsAjustes.FieldByName('AJUCRE').Value *
                                                         IIF(cdsAjustes.FieldByName('AJUCRE').Value > 0, 1, -1));
          objIncons.strValLiq := FormatFloat('#,##0.00', cdsAjustes.FieldByName('AJUCRE').Value *
                                                         IIF(cdsAjustes.FieldByName('AJUCRE').Value > 0, 1, -1));

          If (objCampos.strTabCon = 'CIE_CIPGTO') Then
          Begin
            If (cdsAjustes.FieldByName('CIE_TIPREG').AsString = 'B') Then
              objIncons.strValOri := FormatFloat('#,##0.00', cdsAjustes.FieldByName('CIE_RO_BRU').AsFloat);
          End;
        End
        Else
        Begin
          If LDividePeloTotalDeParcelas Then
            objIncons.strValori := FormatFloat('#,##0.00', fFormataFloat(cdsAjustes.FieldByName(objCampos.strValBru).Value /
                                                                         cdsAjustes.FieldByName(objCampos.strTotPar).AsInteger, 2) *
                                                           IIF(cdsAjustes.FieldByName(objCampos.strValBru).Value < 0, 1, -1))
          Else
            objIncons.strValori := FormatFloat('#,##0.00', fFormataFloat(cdsAjustes.FieldByName(objCampos.strValBru).Value, 2) *
                                                           IIF(cdsAjustes.FieldByName(objCampos.strValBru).Value < 0, 1, -1));

          objIncons.strValLiq := FormatFloat('#,##0.00', cdsAjustes.FieldByName(objCampos.strValLiq).Value *
                                                         IIF(cdsAjustes.FieldByName(objCampos.strValLiq).Value < 0, 1, -1));
        End;


        If (objCampos.strTabCon = 'CIE_CIPGTO') And cdsAjustes.FieldByName('CIE_TIPNEG').AsString.Equals('CE') Then
          objIncons.strDtaRec := FormatDateTime('dd/mm/yyyy', cdsAjustes.FieldByName('CIE_DTAAPR').Value)
        Else
          objIncons.strDtaRec := FormatDateTime('dd/mm/yyyy', cdsAjustes.FieldByName(objCampos.strDtaRec).Value);

        objIncons.strNomEmp := strConfEm + IIF(fEmptyStr(strConfEm), '', '-' + fRetNomeEmpresaSelec(strConfEm));

        objIncons.strPorBai := fRetornaDadosDeBaixaDosAjustes(objCampos.strConfPr, strConfEm);
        If (objCampos.strTabCon = 'GET_GEPGTO') Then
        Begin
           If (cdsAjustes.FieldByName('TIPAJU').AsString = 'ALUGUEL DE POS') Then
           Begin
             objIncons.strCtaBai := IIF( fEmptyStr(fRetornaDadosDeBaixaDosAjustes(objCampos.strConfCp, strConfEm)),
                                                   fRetornaDadosDeBaixaDosAjustes( objCampos.strConfCt, strConfEm),
                                                   fRetornaDadosDeBaixaDosAjustes(objCampos.strConfCp, strConfEm) );
           End
           Else
             objIncons.strCtaBai := fRetornaDadosDeBaixaDosAjustes( objCampos.strConfCt, strConfEm);
        End
        Else
          objIncons.strCtaBai := fRetornaDadosDeBaixaDosAjustes(objCampos.strConfCt, strConfEm);
        objIncons.strForTax := fRetornaDadosDeBaixaDosAjustes(objCampos.strConfFo, strConfEm);

        objIncons.strEventoCancelamentoAjuste := fRetornaDadosDeBaixaDosAjustes(objCampos.strEventoCancelamentoAjuste, strConfEm);

        objIncons.intConcil := cdsAjustes.FieldByName(LeftStr(objCampos.strCodAut, 4) + 'CONCIL').AsInteger;

        If (fCfgSis('BAIDEB') = 'S') Then
        Begin
          strCodEmpresa := strConfEm;

          objIncons.strSituacaoCadastro :=  'COMPLETO';
          If ((strCodEmpresa.Trim.IsEmpty) Or
              ((fEmptyStr(fCfgSis(objCampos.strConfPr, varString, strCodEmpresa))) Or
               (fEmptyStr(fCfgSis(objCampos.strConfCt, varString, strCodEmpresa))) Or
               (fEmptyStr(fCfgSis(objCampos.strConfFo, varString, strCodEmpresa))) Or
               (fCfgSis('CTPOBE', varBoolean) and
                fEmptyStr(fCfgSis(objCampos.strEventoCancelamentoAjuste, varString, strCodEmpresa))))) Then
            objIncons.strSituacaoCadastro :=  'INCOMPLETO';
        End;

        //Gravando na cdsBaiCar caso seja Ajuste
        If blnGraAju Then
          pGravaAjustes(objIncons, objCampos.strNomCon = 'PAGSEGURO');

        pGravaInconsistencia(objIncons);
        FreeAndNil(objIncons);

        cdsAjustes.Next;
      End;
    End;
  Finally
    FreeAndNil(qryCanc);
  End;
end;

function TConciliacaoCartoes.EmpresaConfiguracao(AConfiguracao, AValorConfiguracao: String): String;
var
  LConsulta: TUniQuery;
begin
  Result := '';
  LConsulta := fCriaQuery;
  try
    if AValorConfiguracao.Trim.IsEmpty then
      Exit;

    try
      LConsulta.Close;
      LConsulta.SQL.Clear;
      LConsulta.SQL.Text := 'SELECT       ' +
                            '  SIS_CODEMP ' +
                            'FROM         ' +
                            '  CFGSIS     ' +
                            'WHERE SIS_CODCFG = :CODCFG ' +
                            '  AND LOCATE(:VALCFG, CONCAT(SIS_VALCFG, ",")) > 0 ';

      LConsulta.ParamByName('CODCFG').AsString := 'CFG_' + AConfiguracao;
      LConsulta.ParamByName('VALCFG').AsString := fRetiraZerosEsquerda(AValorConfiguracao) + ',';
      LConsulta.Open;
      LConsulta.First;
      if not LConsulta.IsEmpty then
        Result := LConsulta.Fields[0].AsString;
    except
      On E:Exception do
        raise Exception.Create('Problemas ao retornar a empresa da configuração. ' + E.Message + ' [TConciliacaoCartoes.EmpresaConfiguracao]');
    end;
  finally
    LConsulta.Close;
    FreeAndNil(LConsulta);
  end;
end;

procedure TConciliacaoCartoes.pFiltraCartoes;
Var
    strSQL   : String;
    strDtaCad: String;
    intCont  : Integer;
begin
  strSQL := fGetSQLCartoes(objConcil);

  strDtaCad := '';

  For intCont := 0 To lstDtaCad.Count - 1 Do
    strDtaCad := strDtaCad + '"' + lstDtaCad[intCont] + '",';

  strSQL := strSQL + '  AND MCA_DTACUP IN (' + Copy(strDtaCad, 1, Length(strDtaCad) - 1) + ') ';

  If Not fRetSomenteNumeros(FCartoesConciliar).IsEmpty Then
    strSQL := strSQL + ' AND MCA_CODCAR IN (' + fRetStrToSQLIn(FCartoesConciliar) + ')';

  //Apenas cartões, no caso de Market Place não deve ser utilizado
  If FFiltrarAutorizacaoNSU Then
    strSQL := strSQL + ' AND (MCA_NUMCCD IN (' + RetornaInAutorizacaoFiltrar + ')' +
                       '  OR  MCA_NUMNSU IN (' + RetornaInNsuFiltrar + ')) ';

  strSQL := strSQL + ' ORDER BY MCA_DTAVEN, MCA_NUMDUP, MCA_CODEMP, MCA_NUMCCD, MCA_NUMNSU, MCA_PARCEL) AS TMP ';

  qryBaiCar := fCriaQuery(Nil);
  With qryBaiCar Do
  Begin
    Close;

    SQL.Clear;
    SQL.Add(strSQL);

    Options.SetFieldsReadOnly := False;

    Open;

  End;

  If Assigned(cdsBaiCar) Then
    FreeAndNil(cdsBaiCar);

  cdsBaiCar := CriarClientDataSet(qryBaiCar);

  cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;MCA_CODEMP;PARDUP;MCA_DTACUP;MCA_NUMDUP';

  FreeAndNil(qryBaiCar);
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

  If Not objConcil.strTabCon.Equals('RED_APPGTO') Then
    strSQL := strSQL + '  IF(IFNULL(MCA_NUMCCD, "") = "", MCA_NUMCCD, UPPER(MCA_NUMCCD)) AS MCA_NUMCCD, '
  Else
    strSQL := strSQL + '  LPAD(UPPER(MCA_NUMCCD), 6, "0") AS MCA_NUMCCD, ';

  strSQL := strSQL + ' MCA_PARCEL, MCA_DTAREC, LPAD(MCA_NUMNSU, 14, "0") AS MCA_NUMNSU, MCA_NUMDUP, MCA_DTACUP, MCA_NUMPOK,             ';
  strSQL := strSQL + ' MCA_CODEMP, MCA_DTAVEN, MCA_EMPRCX, MCA_CHACON, MCA_VALSTA, ';
  strSQL := strSQL + '  CAST(" " AS CHAR(50)) AS MARKETPLACE,                      ';
  strSQL := strSQL + ' LPAD(RIGHT(MCA_NUMNSU,12),14,"0") AS NSU_B2W,               ';
  strSQL := strSQL + ' "N" AS VALIDADO                                             ';
  strSQL := strSQL + ' FROM MOVCAR                                                 ';
  strSQL := strSQL + ' WHERE MCA_DTACUP IN(' + Copy(strDtaCad, 1, Length(strDtaCad) -1) + ') ';

  If Not fRetSomenteNumeros(FCartoesConciliar).IsEmpty Then
    strSQL := strSQL + ' AND MCA_CODCAR IN (' + fRetStrToSQLIn(FCartoesConciliar) + ')';

  //Apenas cartões, no caso de Market Place não deve ser utilizado
  If FFiltrarAutorizacaoNSU Then
    strSQL := strSQL + ' AND (MCA_NUMCCD IN (' + RetornaInAutorizacaoFiltrar + ')' +
                       '  OR  MCA_NUMNSU IN (' + RetornaInNsuFiltrar + ')) ';

  strSQL := strSQL + ' AND MCA_DTAREC IS NOT NULL                                  ';
  strSQL := strSQL + ' ORDER BY MCA_NUMCCD, MCA_PARCEL,MCA_CODEMP                  ';

  qryBaixad := fCriaQuery;

  Try
    qryBaixad.SQL.Add(strSQL);
    qryBaixad.Open;

    cdsBaixad := fCriaClientDatSet(qryBaixad);
    cdsBaixad.Open;

    If AApenasNaoValidados Then
    Begin
      cdsBaixad.Filter := 'VALIDADO=''N'' ';
      cdsBaixad.Filtered := True;
    End;

    cdsBaixad.IndexFieldNames := 'MCA_NUMCCD;MCA_PARCEL;MCA_DTACUP;MCA_CODEMP';
    cdsBaiCar.IndexFieldNames := 'MCA_NUMCCD;EMPLOC;MCA_DTACUP;PARDUP';
  Finally
    qryBaixad.Close;

    FreeAndNil(qryBaixad);
  End;
end;

procedure TConciliacaoCartoes.pCriaClientInconsist;
begin
  cdsInconsistencia := TUniClientDataSet.Create(Application);
  cdsInconsistencia.DisableControls;
  cdsInconsistencia.FetchOnDemand := False;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMARQ';
    DataType := ftString;
    Size := 100;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESCRI';
    DataType := ftString;
    Size := 100;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALORI';
    DataType := ftString;
    Size := 25;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'AUTORI';
    DataType := ftString;
    Size := 40;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUM_PV';
    DataType := ftString;
    Size := 30;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUM_RV';
    DataType := ftString;
    Size := 30;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TIPCAR';
    DataType := ftString;
    Size := 40;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTA_CV';
    DataType := ftDateTime;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTAVEN';
    DataType := ftDateTime;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMCAR';
    DataType := ftString;
    Size := 25;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALREC';
    DataType := ftString;
    Size := 25;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMEMP';
    DataType := ftString;
    Size := 100;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CONCIL';
    DataType := ftInteger;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PARCEL';
    DataType := ftString;
    Size := 7;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PERTAX';
    DataType := ftString;
    Size := 10;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMNSU';
    DataType := ftString;
    Size := 30;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALCON';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMCCD';
    DataType := ftString;
    Size := 25;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALLIQ';
    DataType := ftString;
    Size := 25;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESEMP';
    DataType := ftString;
    Size := 120;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODEMP';
    DataType := ftString;
    Size := 3;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'BANDEI';
    DataType := ftString;
    Size := 50;
  End;
  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODCLI';
    DataType := ftString;
    Size := 8;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMDUP';
    DataType := ftString;
    Size := 12;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMCLI';
    DataType := ftString;
    Size := 150;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'FONCLI';
    DataType := ftString;
    Size := 60;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TOTALI';
    DataType := ftString;
    Size := 1;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'BRUTO_MARKETPLACE';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'LIQUIDO_MARKETPLACE';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'TAXAS_MARKETPLACE';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'FRETE_MARKETPLACE';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'AJUSTES_MARKETPLACE';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CUPOM_MARKETPLACE';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CONCILIADO';
    DataType := ftInteger;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PORTADOR_DEBITO';
    DataType := ftString;
    Size := 100;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PORTADOR_TRANSFERENCIA';
    DataType := ftString;
    Size := 100;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NUMERO_NEGOCIACAO';
    DataType := ftString;
    Size := 50;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CODIGO_BANDEIRA';
    DataType := ftString;
    Size := 3;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'PERCENTUAL_TAXA';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DTAPAG';
    DataType := ftDateTime;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALSIS';
    DataType := ftFloat;
  End;

  With cdsInconsistencia.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALDIF';
    DataType := ftFloat;
  End;

  cdsInconsistencia.CreateDataSet;


  cdsListArq := TUniClientDataSet.Create(Application);
  cdsListArq.DisableControls;
  cdsListArq.FetchOnDemand := False;

  With cdsListArq.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMARQ';
    DataType := ftString;
    Size := 255;
  End;

  With cdsListArq.FieldDefs.AddFieldDef Do
  Begin
    Name := 'DESCRI';
    DataType := ftString;
    Size := 100;
  End;

  cdsListArq.CreateDataSet;

  cdsTotBan := TUniClientDataSet.Create(Application);
  cdsTotBan.DisableControls;
  cdsTotBan.FetchOnDemand := False;

  With cdsTotBan.FieldDefs.AddFieldDef Do
  Begin
    Name := 'ESTABE';
    DataType := ftString;
    Size := 30;
  End;

  With cdsTotBan.FieldDefs.AddFieldDef Do
  Begin
    Name := 'NOMBAN';
    DataType := ftString;
    Size := 50;
  End;

  With cdsTotBan.FieldDefs.AddFieldDef Do
  Begin
    Name := 'QTDBAN';
    DataType := ftInteger;
  End;

  With cdsTotBan.FieldDefs.AddFieldDef Do
  Begin
    Name := 'VALBAN';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsTotBan.FieldDefs.AddFieldDef Do
  Begin
    Name := 'LIQBAN';
    DataType := ftFloat;
    Precision := 2;
  End;

  With cdsTotBan.FieldDefs.AddFieldDef Do
  Begin
    Name := 'CONCIL';
    DataType := ftInteger;
  End;

  cdsTotBan.CreateDataSet;

  cdsTotalFinal := TUniClientDataSet.Create(Application);
  cdsTotalFinal.DisableControls;
  cdsTotalFinal.FetchOnDemand := False;

  with cdsTotalFinal.FieldDefs.AddFieldDef do
  begin
    Name     := 'RECEBE';
    DataType := ftString;
    Size := 100;
  end;

  with cdsTotalFinal.FieldDefs.AddFieldDef do
  begin
    Name     := 'ESTABE';
    DataType := ftString;
    Size := 3;
  end;

  with cdsTotalFinal.FieldDefs.AddFieldDef do
  begin
    Name     := 'TOTSAI';
    DataType := ftFloat;
  end;

  with cdsTotalFinal.FieldDefs.AddFieldDef do
  begin
    Name     := 'TOTENT';
    DataType := ftFloat;
  end;

  with cdsTotalFinal.FieldDefs.AddFieldDef do
  begin
    Name     := 'TOTTAX';
    DataType := ftFloat;
  end;

  with cdsTotalFinal.FieldDefs.AddFieldDef do
  begin
    Name     := 'TOTLIQ';
    DataType := ftFloat;
  end;

  cdsTotalFinal.CreateDataSet;
end;

function TConciliacaoCartoes.fExibeRelatIncons(strNomRel: String;
                                                blnMemo96: Boolean = True;
                                                strMemo96: String = 'Res. Venda';
                                                blnConRed: Boolean = False;
                                                ANomCon: String = ''): Boolean;
  const
    LArrValidaTaxa: Array of String = ['CIELO','STONE','PAGSEGURO','RedeCard API',
                                       'REDECARD','PagSeguroApi','GETNET','AMEX',
                                       'SAFRAPAY','Sicredi', 'Granito'];
  Var
    blnValDif,
    blnValNEn,
    blnValRcx,
    blnValBai,
    blnLisArq,
    blnLisSem,
    blnResBan,
    blnPonVen,
    blnTaxDif,
    bEsconderValoresLiquidosZerados: Boolean;
    intOrdena,
    intContador: Integer;

    frmFiltroInconsistencias: TfrmFiltroInconsistencias;

    LQuantidadeRVs: Integer;

    LValorTotal: Double;
begin
  TfrmGravando.fExecutarModal(pAcertaDadosDeBaixaOtimizadaPorEmpresa, 'Aguarde... Atualizando dados de conciliação.', '');

  pCriarFormularios(TfrmFiltroInconsistencias, frmFiltroInconsistencias);
  frmFiltroInconsistencias.intOrdena := 1;
  frmFiltroInconsistencias.blnConRed := blnConRed;
  frmFiltroInconsistencias.chkTaxDif.Visible := MatchStr(ANomCon, LArrValidaTaxa);

  if ANomCon.Equals('PAGAR.ME') then
    frmFiltroInconsistencias.chkTaxDif.Visible := fCfgSis('PGMREC', varBoolean);

  frmFiltroInconsistencias.chkResBan.Visible := Not MatchStr(ANomCon, ['SHOPEE','ALPE','MADEIRAMADEIRA']);
  frmFiltroInconsistencias.chkPonVen.Visible := Not MatchStr(ANomCon, ['SHOPEE','ALPE','MADEIRAMADEIRA']);
  frmFiltroInconsistencias.chkResBan.Checked := Not MatchStr(ANomCon, ['SHOPEE','ALPE','MADEIRAMADEIRA']);
  frmFiltroInconsistencias.chkPonVen.Checked := Not MatchStr(ANomCon, ['SHOPEE','ALPE','MADEIRAMADEIRA']);
  frmFiltroInconsistencias.chkCarPen.Visible := MatchStr(ANomCon, ['REDECARD','RedeCard API','STONE']);
  frmFiltroInconsistencias.BlnExCarPen    := MatchStr(ANomCon, ['STONE']);
  frmFiltroInconsistencias.chkValZer.Visible := MatchStr(ANomCon, ['RedeCard API']);
  frmFiltroInconsistencias.chkValZer.Checked := True;

  If MatchStr(ANomCon, ['MAGAZINE LUIZA']) Then
  Begin
    frmFiltroInconsistencias.rdgOrdenar.Items.Clear;
    frmFiltroInconsistencias.rdgOrdenar.Items.Add('Pedido/Parcela');
    frmFiltroInconsistencias.rdgOrdenar.Items.Add('Data Vencimento');
    frmFiltroInconsistencias.intOrdena := 0;
  End;

  frmFiltroInconsistencias.ShowModal;
  blnValDif := frmFiltroInconsistencias.blnValDif;
  blnValNEn := frmFiltroInconsistencias.blnValNEn;
  blnValRcx := frmFiltroInconsistencias.blnValRcx;
  blnValBai := frmFiltroInconsistencias.blnValBai;
  blnLisArq := frmFiltroInconsistencias.blnLisArq;
  blnLisSem := frmFiltroInconsistencias.blnLisSem;
  intOrdena := frmFiltroInconsistencias.intOrdena;
  blnResBan := frmFiltroInconsistencias.blnResBan;
  blnPonVen := frmFiltroInconsistencias.blnPonVen;
  blnTaxDif := frmFiltroInconsistencias.blnTaxDif;
  FExibirCartoesPendente := frmFiltroInconsistencias.ExibirCartoesPendente;
  bEsconderValoresLiquidosZerados :=
    MatchStr(ANomCon, ['RedeCard API']) and
    frmFiltroInconsistencias.EsconderCartoesVlrLiqZerado;

  Result := frmFiltroInconsistencias.ModalResult = mrOK;

  FreeAndNil(frmFiltroInconsistencias);

  If Not Result Then
    Exit;

  If (blnValDif) Or (blnValNEn) Or (blnValRcx) Or (blnValBai) Or (blnLisArq) Or (blnTaxDif) Then
  Begin
    if bEsconderValoresLiquidosZerados then
    begin
      DeletarValoresLiquidosZerados(cdsBaiCar, 'MCA_VALTOT');
      DeletarValoresLiquidosZerados(cdsInconsistencia, 'VALLIQ');
    end;

    cdsInconsistencia.Filtered := False;
    cdsInconsistencia.Filter   := 'DESCRI <> ' + QuotedStr('') +
                                  ' AND DESCRI <> ''NEGOCIAÇÃO DE RECEBÍVEIS'' ';

    If Not blnValDif Then
      cdsInconsistencia.Filter := cdsInconsistencia.Filter + ' AND DESCRI <> ' + QuotedStr('Valor do cartão diferente do registrado no sistema ou Autorização duplicada');

    If Not blnValNEn Then
      cdsInconsistencia.Filter := cdsInconsistencia.Filter + ' AND DESCRI <> ' + QuotedStr('Registro do arquivo não encontrado nos lançamentos do sistema');

    If Not blnValRcx Then
      cdsInconsistencia.Filter := cdsInconsistencia.Filter + ' AND DESCRI <> ' + QuotedStr('Cartões recebidos pelo Caixa e não transferidos');

    If Not blnValBai Then
      cdsInconsistencia.Filter := cdsInconsistencia.Filter + ' AND DESCRI <> ' + QuotedStr('Cartão já foi baixado manualmente') +
                                                             ' AND DESCRI <> ' + QuotedStr('Cartão já foi baixado através de conciliação automática');
    If Not blnTaxDif Then
      cdsInconsistencia.Filter := cdsInconsistencia.Filter + ' AND DESCRI <> ' + QuotedStr(RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa);

    cdsInconsistencia.Filter := cdsInconsistencia.Filter + ' AND DESCRI <> ' + QuotedStr('Cancelamentos/Ajustes');
    cdsInconsistencia.Filter := cdsInconsistencia.Filter + ' AND DESCRI <> ''TRANSFERÊNCIAS'' ';
    cdsInconsistencia.Filter := cdsInconsistencia.Filter + ' AND DESCRI <> ''Devoluções'' ';

    cdsInconsistencia.Filtered := True;

    cdsInconsistencia.Open;
    If intOrdena = 0 Then
    Begin
      If MatchStr(ANomCon, ['MAGAZINE LUIZA']) Then
        cdsInconsistencia.IndexFieldNames := 'DESEMP;NUM_PV;DESCRI;AUTORI;PARCEL;DTAVEN'
      Else If MatchStr(ANomCon, ['RedeCard API']) Then
        cdsInconsistencia.IndexFieldNames := 'DTAPAG;DESEMP;NUM_PV;DESCRI;TIPCAR;DTA_CV;DTAVEN'
      Else
        cdsInconsistencia.IndexFieldNames := 'DESEMP;NUM_PV;DESCRI;TIPCAR;DTA_CV;DTAVEN';
    End
    Else If intOrdena = 1 Then
    Begin
      If MatchStr(ANomCon, ['RedeCard API']) Then
        cdsInconsistencia.IndexFieldNames := 'DTAPAG;DESEMP;NUM_PV;DESCRI;TIPCAR;DTAVEN'
      Else
        cdsInconsistencia.IndexFieldNames := 'DESEMP;NUM_PV;DESCRI;TIPCAR;DTAVEN'
    End
    Else
    Begin
      If MatchStr(ANomCon, ['RedeCard API']) Then
        cdsInconsistencia.IndexFieldNames := 'DTAPAG;DESEMP;NUM_PV;DESCRI;TIPCAR;NUM_RV;DTAVEN'
      Else
        cdsInconsistencia.IndexFieldNames := 'DESEMP;NUM_PV;DESCRI;TIPCAR;NUM_RV;DTAVEN';
    End;


    If MatchStr(ANomCon, ['LUCREE']) Then
    Begin
      cdsInconsistencia.IndexFieldNames := 'DESEMP;NUMCAR;NUM_PV;DESCRI;TIPCAR;DTAVEN';
    End;

    If MatchStr(ANomCon, ['PAGAR.ME']) Then
    Begin
      If (fCfgSis('PGMVER', varString) = 'v5') Then
        cdsInconsistencia.IndexFieldNames := 'DESEMP;NUMCAR;NUM_PV;DESCRI;TIPCAR;DTAVEN';
    End;


    If MatchStr(ANomCon, ['KONCILI']) Then
      cdsInconsistencia.IndexFieldNames := cdsInconsistencia.IndexFieldNames + ';NUMCCD;PARCEL' ;

    frxPagina.Script.Variables['NOMREL'] := strNomRel;
    TfrxMemoView(frxPagina.FindObject('Memo96')).Text := strMemo96;

    //Gravando Arquivos conciliados
    If blnLisArq Then
    Begin
      For intContador := 0 to lstNomArq.Count - 1 Do
      Begin
        cdsListArq.Insert;
        cdsListArq.FieldByName('NOMARQ').AsString := lstNomArq[intContador];
        cdsListArq.FieldByName('DESCRI').AsString := 'ARQUIVOS CONCILIADOS';
        cdsListArq.Post;
      End;
      For intContador := 0 to lstSemArq.Count - 1 Do
      Begin
        cdsListArq.Insert;
        cdsListArq.FieldByName('NOMARQ').AsString := lstSemArq[intContador];
        cdsListArq.FieldByName('DESCRI').AsString := 'ARQUIVOS FALTANDO REGISTRO DE VENDAS';
        cdsListArq.Post;
      End;
      TfrxMemoView(frxPagina.FindObject('Subreport1')).Visible := True;
      TfrxMemoView(frxPagina.FindObject('Child1')).Visible := True;
      cdsListArq.IndexFieldNames := 'DESCRI;NOMARQ';
      FreeAndNil(lstNomArq);
      FreeAndNil(lstSemArq);
    End;

    {************************************************}
    {* GERANDO LISTA DE RVs INCONSISTENTES REDECARD *}
    {*********************************************AJ*}
    cdsSemRed := TUniClientDataSet.Create(Application);
    cdsSemRed.FieldDefs := cdsInconsistencia.FieldDefs;
    cdsSemRed.CreateDataSet;
    If (blnLisSem) And (blnConRed) Then
    Begin
      LQuantidadeRVs := 0;
      LValorTotal := 0.00;

      With cdsSemRed Do
      Begin
        Open;
        For intContador := 0 to Length(arrSemReg) - 1 Do
        Begin
          Append;
          FieldByName('NUM_PV').AsString := arrSemReg[intContador].strNum_Pv;
          FieldByName('NUM_RV').AsString := arrSemReg[intContador].strNum_Rv;
          FieldByName('DTA_CV').Value    := arrSemReg[intContador].dtaDta_Cv;
          FieldByName('PARCEL').AsString := arrSemReg[intContador].strParcel;
          FieldByName('VALORI').AsString := FormatFloat('#,##0.00;-#,##0.00', arrSemReg[intContador].fltValSta);
          Post;

          Inc(LQuantidadeRVs);
          LValorTotal := LValorTotal + arrSemReg[intContador].fltValSta;
        End;
        IndexFieldNames := 'NUM_PV;DTA_CV;NUM_RV';
        TfrxMemoView(frxPagina.FindObject('Subreport2')).Visible := True;
        TfrxMemoView(frxPagina.FindObject('Child2')).Visible := True;

        TfrxMemoView(frxPagina.FindObject('rllQtdSem')).Text := LQuantidadeRVs.ToString;
        TfrxMemoView(frxPagina.FindObject('rllTotSem')).Text := FormatFloat('#,##0.00;-#,##0.00', LValorTotal);
      End;
    End
    Else
    Begin
      TfrxMemoView(frxPagina.FindObject('Subreport2')).Visible := False;
      TfrxMemoView(frxPagina.FindObject('Child2')).Visible := False;
    End;

    {***********************}
    {* RESUMO POR BANDEIRA *}
    {********************AJ*}
    cdsTotBan.IndexFieldNames := 'ESTABE;CONCIL;NOMBAN';
    If Not blnResBan Then
    Begin
      TfrxMemoView(frxPagina.FindObject('Subreport3')).Visible := False;
      TfrxMemoView(frxPagina.FindObject('Subreport4')).Visible := False;
    End;

    TfrxMemoView(frxPagina.FindObject('Subreport5')).Visible := (blnPonVen);

    TfrxReportPage(frxPagina.FindObject('qckMarketPlace')).Visible := False;

    cdsTotalFinal.IndexFieldNames := 'ESTABE';
    if not ((cdsTotalFinal.Active) and (cdsTotalFinal.RecordCount > 0)) then
    begin
      TfrxMemoView(frxPagina.FindObject('Subreport11')).Visible := False;
      TfrxMemoView(frxPagina.FindObject('Child9')).Visible := False;
    end
    else
      GerarTotalFinalLiquido;

    //Gera os totais
    pTotalRelInc;

    pPreviewReport('TConciliacaoCartoes', strNomRel, frxPagina);
  End;
end;

procedure TConciliacaoCartoes.pGravaAjustes(objIncons: TInconsist; AGravaCampoValorBruto: Boolean = False;
  AAjusteTransferencia: Boolean = False; ADatasetTransferencia: TDataset = Nil; ADatasetNegociacao: TDataset = Nil;
  AOutrosDatasets: TDataset = Nil);
  Var
    fltValLiq: Double;
begin
  If objIncons.intConcil = 1 Then
    Exit;

  fltValLiq := fStrToFloat(objIncons.strValLiq);
  cdsBaiCar.Last;
  cdsBaiCar.Append;
  cdsBaiCar.FieldByName('AUTOINC').AsString     := VS_strCodEmp + fStrZero(objIncons.strNumCCD, 10) +
                                                   fRetSomenteNumeros(objIncons.strParcel) + VS_strCodEmp;
  cdsBaiCar.FieldByName('NRODUP').AsString      := fStrZero(objIncons.strNumCCD, 06);
  cdsBaiCar.FieldByName('PARDUP').AsString      := fGetLetraAlfa(StrtoInt(LeftStr(objIncons.strParcel, 02)));
  cdsBaiCar.FieldByName('MCA_NUMDUP').AsString  := cdsBaiCar.FieldByName('NRODUP').AsString + cdsBaiCar.FieldByName('PARDUP').AsString;
  cdsBaiCar.FieldByName('EMPLOC').AsString      := LeftStr(objIncons.strNomEmp, 03);
  cdsBaiCar.FieldByName('MCA_CODEMP').AsString  := LeftStr(objIncons.strNomEmp, 03);
  cdsBaiCar.FieldByName('MCA_EMPRCX').AsString  := LeftStr(objIncons.strNomEmp, 03);
  cdsBaiCar.FieldByName('MCA_DTAVEN').AsString  := objIncons.strDtaRec;
  cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat   := fltValLiq;
  cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat   := 0.00;

  If AGravaCampoValorBruto Then
    cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat   := fStrToFloat(objIncons.strValori)
  Else
    cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat   := fltValLiq;

  cdsBaiCar.FieldByName('MCA_VALORI').AsFloat   := fltValLiq;
  cdsBaiCar.FieldByName('MCA_VALDUP').AsFloat   := fltValLiq;
  cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat   := 0.000000;
  cdsBaiCar.FieldByName('MCA_CODCLI').AsString  := fStrZero(objIncons.strCodCli, 08);
  cdsBaiCar.FieldByName('CLI_NOMCLI').AsString  := objIncons.strNomCli;
  cdsBaiCar.FieldByName('MCA_DTACAD').AsString  := objIncons.strDta_CV;
  cdsBaiCar.FieldByName('MCA_NUMCCD').AsString  := objIncons.strNumCCD;
  cdsBaiCar.FieldByName('MCA_RESCAI').AsInteger := 0;
  cdsBaiCar.FieldByName('MCA_CODCAR').AsString  := objIncons.strCodCar;
  cdsBaiCar.FieldByName('CAR_DESCAR').AsString  := objIncons.strDesCar;

  cdsBaiCar.FieldByName('MCA_NUMNSU').AsString  := fStrZero(objIncons.strNumNsu , 14);
  If objIncons.Operadora = 'MERCADOLIVRE' Then
    cdsBaiCar.FieldByName('MCA_NUMNSU').AsString  := objIncons.strNumNsu;

  cdsBaiCar.FieldByName('MCA_DTACUP').AsString  := objIncons.strDta_CV;
  cdsBaiCar.FieldByName('MCA_MARDES').AsString  := 'M';
  cdsBaiCar.FieldByName('MCA_VALREC').AsFloat   := fltValLiq;
  cdsBaiCar.FieldByName('MCA_DTAREC').AsString  := objIncons.strDtaRec;
  cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_AJUTOT').AsFloat   := fltValLiq;
  cdsBaiCar.FieldByName('MCA_AJUSEL').AsFloat   := fltValLiq;
  cdsBaiCar.FieldByName('MCA_ZERATX').AsString  := 'S';
  cdsBaiCar.FieldByName('MCA_ANTECI').AsFloat   := 0.00;
  cdsBaiCar.FieldByName('MCA_SELQTD').AsInteger := 0;
  cdsBaiCar.FieldByName('MCA_AJUSTE').AsString  := 'S';
  cdsBaiCar.FieldByName('MCA_ESTABE').AsString  := objIncons.strNum_PV;
  cdsBaiCar.FieldByName('CAR_PORBAI').AsString  := objIncons.strPorBai;
  cdsBaiCar.FieldByName('CAR_PORTAX').AsString  := objIncons.strPorTax;
  cdsBaiCar.FieldByName('CAR_PORBAD').AsString  := objIncons.strPorDeb;
  cdsBaiCar.FieldByName('CAR_FORTAX').AsString  := objIncons.strForTax;
  cdsBaiCar.FieldByName('FOR_NOMFOR').AsString  := IIF(fEmptyStr(objIncons.strForTax), '', fRetNomFornecedor(objIncons.strForTax));
  cdsBaiCar.FieldByName('CAR_CTABAI').AsString  := objIncons.strCtaBai;
  cdsBaiCar.FieldByName('CAR_CTATAX').AsString  := objIncons.strCtaTax;
  cdsBaiCar.FieldByName('CAR_CTABAD').AsString  := objIncons.strCtaDeb;
  cdsBaiCar.FieldByName('CAR_EVEDEB').AsString  := objIncons.strEveDeb;
  cdsBaiCar.FieldByName('MCA_EVECAN').AsString  := objIncons.strEventoCancelamentoAjuste;
  cdsBaiCar.FieldByName('SIT_CAD').AsString     := objIncons.strSituacaoCadastro;
  cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString     := objIncons.HistoricoBaixa;

  cdsBaiCar.FieldByName('NEGOCIACAO').AsString  := 'N';
  If objIncons.NegociacaoRecebiveis = 'S' Then
  Begin
    cdsBaiCar.FieldByName('NEGOCIACAO').AsString  := 'S';
    cdsBaiCar.FieldByName('NUMEROOPERACAO').AsString := objIncons.NumeroOperacaoNegociacao;
  End;

  If Not fEmptyStr(objConcil.strChavePrimaria) Then
  Begin
    If objIncons.NegociacaoRecebiveis = 'S' Then
    Begin
      If Assigned(ADatasetNegociacao) Then
      Begin
        cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString  := fRetornaChaveConciliacao(ADatasetNegociacao);
        cdsBaiCar.FieldByName('VALOR_TAXA_NEGOCIACAO').AsFloat := fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat -
                                                                                cdsBaiCar.FieldByName('MCA_VALORI').AsFloat, 2);
        cdsBaiCar.FieldByName('PLANODECONTASTXNEGOCIACAO').AsString := objIncons.PlanoContasTaxaNegociacao;
      End;
    End
    Else If AAjusteTransferencia Then
      cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString  := fRetornaChaveConciliacao(ADatasetTransferencia)
    Else If Assigned(AOutrosDatasets) Then
      cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString  := fRetornaChaveConciliacao(AOutrosDatasets)
    Else If Assigned(cdsAjustes) Then
      cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString  := fRetornaChaveConciliacao(cdsAjustes);
  End;

  cdsBaiCar.FieldByName('REGISTROTRANSFERENCIA').AsString := 'N';
  If Not objIncons.PortadorTransferencia.IsEmpty Then
  Begin
    cdsBaiCar.FieldByName('PORTADORTRANSFERENCIA').AsString := objIncons.PortadorTransferencia;
    cdsBaiCar.FieldByName('PLANODECONTASTRANSFERENCIA').AsString := objIncons.PlanoDeContasTransferencia;
    cdsBaiCar.FieldByName('CENTRODECUSTOSTRANSFERENCIA').AsString := objIncons.CentroDeCustosTransferencia;
    cdsBaiCar.FieldByName('REGISTROTRANSFERENCIA').AsString := 'S';
  End;

  cdsBaiCar.Post;

  blnAjuCon := False;
end;

procedure TConciliacaoCartoes.pGravaInconsistencia(objIncons: TInconsist);
Begin
  Try
    cdsInconsistencia.Append;
    cdsInconsistencia.FieldByName('NOMARQ').AsString   := objIncons.strNomArq;
    cdsInconsistencia.FieldByName('DESCRI').AsString   := objIncons.strDescri +
                                                          IIF(objIncons.strDescri <> 'Cartão já foi baixado', '',
                                                              IIF(Not blnAutomatica,
                                                                  ' manualmente',
                                                                  ' através de conciliação automática'));
    cdsInconsistencia.FieldByName('VALORI').AsString   := objIncons.strValori;
    cdsInconsistencia.FieldByName('AUTORI').AsString   := objIncons.strAutori;
    cdsInconsistencia.FieldByName('NUM_PV').AsString   := objIncons.strNum_PV;
    cdsInconsistencia.FieldByName('NUM_RV').AsString   := objIncons.strNum_RV;
    cdsInconsistencia.FieldByName('TIPCAR').AsString   := objIncons.strTipCar;
    cdsInconsistencia.FieldByName('NUMCAR').AsString   := objIncons.strNumCar;
    cdsInconsistencia.FieldByName('PARCEL').AsString   := objIncons.strParcel;
    cdsInconsistencia.FieldByName('DTAVEN').AsString   := objIncons.strDtaVen;
    cdsInconsistencia.FieldByName('DTA_CV').AsString   := objIncons.strDta_CV;
    cdsInconsistencia.FieldByName('DTAPAG').AsString   := objIncons.strDtaPag;
    cdsInconsistencia.FieldByName('TOTALI').AsString   := IIF(objIncons.blnTotali,'S','N');

    cdsInconsistencia.FieldByName('NUMCCD').AsString   := '';
    If objIncons.strNumCCD <>  '000000' Then
      cdsInconsistencia.FieldByName('NUMCCD').AsString   := objIncons.strNumCCD;

    cdsInconsistencia.FieldByName('VALLIQ').AsString   := objIncons.strValLiq;
    cdsInconsistencia.FieldByName('VALREC').AsString   := objIncons.strValRec;
    cdsInconsistencia.FieldByName('NOMEMP').AsString   := objIncons.strNomEmp;
    cdsInconsistencia.FieldByName('CONCIL').AsInteger  := objIncons.intConcil;
    cdsInconsistencia.FieldByName('PERTAX').AsString   := objIncons.strPerTax;
    cdsInconsistencia.FieldByName('NUMNSU').AsString   := objIncons.strNumNsu;
    cdsInconsistencia.FieldByName('VALCON').AsFloat    := objIncons.fltValCon;

    cdsInconsistencia.FieldByName('DESEMP').AsString   := objIncons.strDesEmp;
    cdsInconsistencia.FieldByName('CODEMP').AsString   := objIncons.strCodEmp;
    If objIncons.strDesEmp.IsEmpty Then
      cdsInconsistencia.FieldByName('DESEMP').AsString   := 'NÃO EXISTE EMPRESA VINCULADA';

    cdsInconsistencia.FieldByName('BANDEI').AsString   := objIncons.strBandei;
    cdsInconsistencia.FieldByName('CODCLI').AsString   := objIncons.strCodCli;
    cdsInconsistencia.FieldByName('NOMCLI').AsString   := objIncons.strNomCli;
    cdsInconsistencia.FieldByName('FONCLI').AsString   := objIncons.strFonCli;
    cdsInconsistencia.FieldByName('NUMDUP').AsString   := objIncons.strNumDup;

    cdsInconsistencia.FieldByName('TOTALI').AsString   := IIF(objIncons.blnTotali,'S','N');

    cdsInconsistencia.FieldByName('NUMERO_NEGOCIACAO').AsString   := objIncons.NumeroOperacaoNegociacao;

    cdsInconsistencia.FieldByName('BRUTO_MARKETPLACE').AsFloat := fFormataFloat(objIncons.BrutoMarketPlace, 2);
    cdsInconsistencia.FieldByName('LIQUIDO_MARKETPLACE').AsFloat := fFormataFloat(objIncons.LiquidoMarketPlace, 2);
    cdsInconsistencia.FieldByName('TAXAS_MARKETPLACE').AsFloat := fFormataFloat(objIncons.TaxasMarketPlace, 2);
    cdsInconsistencia.FieldByName('FRETE_MARKETPLACE').AsFloat := fFormataFloat(objIncons.FreteMarketPlace, 2);
    cdsInconsistencia.FieldByName('AJUSTES_MARKETPLACE').AsFloat := fFormataFloat(objIncons.AjustesMarketPlace, 2);
    cdsInconsistencia.FieldByName('CUPOM_MARKETPLACE').AsFloat := fFormataFloat(objIncons.CupomMarketPlace, 2);

    cdsInconsistencia.FieldByName('CONCILIADO').AsInteger := objIncons.intConcil;

    cdsInconsistencia.FieldByName('PORTADOR_DEBITO').AsString := '';
    cdsInconsistencia.FieldByName('PORTADOR_TRANSFERENCIA').AsString := '';
    If Not objIncons.PortadorTransferencia.IsEmpty Then
    Begin
      If Not objIncons.strPorBai.IsEmpty Then
        cdsInconsistencia.FieldByName('PORTADOR_DEBITO').AsString := objIncons.strPorBai + '-' +
                                                                     fRetNomPortador(objIncons.strPorBai);

      cdsInconsistencia.FieldByName('PORTADOR_TRANSFERENCIA').AsString := objIncons.PortadorTransferencia + '-' +
                                                                          fRetNomPortador(objIncons.PortadorTransferencia);
    End;

    cdsInconsistencia.FieldByName('CODIGO_BANDEIRA').Clear;
    cdsInconsistencia.FieldByName('PERCENTUAL_TAXA').AsFloat := 0;
    If Not objIncons.CodigoBandeira.IsEmpty Then
    Begin
      cdsInconsistencia.FieldByName('CODIGO_BANDEIRA').AsString := objIncons.CodigoBandeira;
      cdsInconsistencia.FieldByName('PERCENTUAL_TAXA').AsFloat := objIncons.PercentualTaxa;
    End;

    cdsInconsistencia.FieldByName('VALSIS').AsFloat := objIncons.ValorCartaoSistema;
    cdsInconsistencia.FieldByName('VALDIF').AsFloat := objIncons.DiferencaValorBruto;

    cdsInconsistencia.Post;

    If objIncons.blnTotali Then
      pGravaTotBan(objIncons.strNum_PV, objIncons.strBandei, fStrtoFloat(objIncons.strValori),
                   fStrtoFloat(objIncons.strValLiq), 0);

    If fStrToFloat(objIncons.strValLiq) > 0 Then
      FTemAjusteACredito :=  True;
  Except
    On E: Exception Do
    Begin
       Raise Exception.Create('Erro na conciliação de cartões: ' + E.Message);
    End;
  End;
End;

procedure TConciliacaoCartoes.pMarcaCartao(fltValRec: Double;
                                           blnAntecip: Boolean;
                                           strChaCon: String = '';
                                           dtaPagOri: TDate = 0;
                                           AFreteMarketPlace: Double = 0;
                                           AAjusteMarketPlace: Double = 0;
                                           ATaxaMarketPlace: Double = 0;
                                           ATaxaDeAntecipacao: Double = 0;
                                           ACupomMarketPlace: Double = 0;
                                           AFreteMediacao: Double = 0;
                                           ATipoCartao: String = '';
                                           AHistoricoBaixa: String = '';
                                           ADiferencaCupom: Double = 0);
  Var
    dtaDtaRec: TDateTime;
    objIncons: TInconsist;
    fltValTax,
    fltValAju: Double;

  Function fParcelaSemTaxaComValorDivergente: Boolean;
  Begin
    Result := (fltValAju < 0) And (fltValTax = 0);
  End;

begin
  If fCartaoBloqueado(cdsBaiCar) Then
  Begin
    objIncons := TInconsist.Create;

    objIncons.strDescri := 'Cartões recebidos pelo Caixa e não transferidos';
    objIncons.strValori := FormatFloat('#,##0.00', cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat);
    objIncons.strAutori := cdsBaiCar.FieldByName('MCA_NUMNSU').AsString;
    objIncons.strNum_PV := strBloqPV;
    objIncons.strNum_RV := strBloqRV;
    objIncons.strNumCar := strBloqCa;
    objIncons.strTipCar := 'CRÉDITO/DÉBITO';
    objIncons.strDta_CV := FormatDateTime('dd/mm/yyyy', cdsBaiCar.FieldByName('MCA_DTACAD').Value);
    objIncons.strDtaVen := FormatDateTime('dd/mm/yyyy', cdsBaiCar.FieldByName('MCA_DTAVEN').Value);
    objIncons.strParcel := strBloqPa;
    objIncons.strNumCCD := cdsBaiCar.FieldByName('MCA_NUMCCD').AsString;
    objIncons.strValLiq := FormatFloat('#,##0.00', cdsBaiCar.FieldByName('MCA_VALDUP').Value);

    If Not fEmptyStr(strBloqEm) Then
    Begin
      objIncons.strCodEmp := strBloqEm;
      objIncons.strDesEmp := strBloqEm + ' - ' + fRetNomeEmpresa(strBloqEm);
    End;

    objIncons.strBandei := fRetNomBandeira(strBloqCa);

    pGravaInconsistencia(objIncons);
    FreeAndNil(objIncons);

    Exit;
  End;

  dtaDtaRec   := dtaDtaPag;

  fltValAju := fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat, 2) - fFormataFloat(fltValRec, 2);
  fltValTax := fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat, 2);

  pGravaTotBan(strBloqPV,
               fRetNomBandeira(strBloqCa, ATipoCartao),
               cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat,
               fltValRec, 1);

  cdsBaiCar.Edit;

  If Not fEmptyStr(strChaCon) Then
  Begin
    cdsBaiCar.FieldByName('MCA_ESTABE').AsString := 'EST_' + strBloqPV;
    cdsBaiCar.FieldByName('MCA_CHACON').AsString := strChaCon;
  End;

  cdsBaiCar.FieldByName('MCA_MARDES').AsString := 'M';
  cdsBaiCar.FieldByName('HISTORICO_BAIXA').AsString := AHistoricoBaixa;
  If fParcelaSemTaxaComValorDivergente And (Not blnGraAju) Then
    cdsBaiCar.FieldByName('MCA_MARDES').AsString := 'D';

  If cdsBaiCar.FieldByName('MCA_MARDES').AsString = 'M' Then
  Begin
    If fFormataFloat(ADiferencaCupom, 2) <> 0.00 Then
    Begin
      cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat := fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat + ADiferencaCupom, 2);
      cdsBaiCar.FieldByName('ALTERAR_BRUTO').AsString := 'S';
    End;

    cdsBaiCar.FieldByName('MCA_VALREC').AsFloat    := IIF(fParcelaSemTaxaComValorDivergente,
                                                          fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat,2),
                                                          fFormataFloat(fltValRec, 2));

    cdsBaiCar.FieldByName('MCA_DTAREC').AsDateTime := dtaDtaRec;
    cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat    := cdsBaiCar.FieldByName('MCA_VALREC').AsFloat;

    If (Not fParcelaSemTaxaComValorDivergente) Then
    Begin
      cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat  := fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat -
                                                                    fFormataFloat(fltValRec, 2), 2);

      If ATaxaMarketPlace <> 0 Then
        cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat := fFormataFloat(ATaxaMarketPlace, 2)
      Else If (ATaxaMarketPlace = 0) And (AFreteMarketPlace > 0) Then
        cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat := 0;
    End;


    cdsBaiCar.FieldByName('MCA_PERCAR').AsFloat    := (cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat /
                                                       cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat) * 100;
    If blnAntecip Then
    Begin
      cdsBaiCar.FieldByName('MCA_ANT_SN').AsString := 'S';
      cdsBaiCar.FieldByName('MCA_ANTECI').AsFloat  := fltValRec;
      cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat  := fFormataFloat(cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat -
                                                      fltValRec - fltValTax, 2);
      If cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat <= 0 Then
        cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat := 0;

      If ATaxaDeAntecipacao > 0 Then
        cdsBaiCar.FieldByName('MCA_ANTTAX').AsFloat := ATaxaDeAntecipacao;

      cdsBaiCar.FieldByName('MCA_TAXANT').AsFloat  := fFormataFloat(fltValTax, 2);
    End;

    cdsBaiCar.FieldByName('MCA_SELTOT').AsFloat  := fFormataFloat(cdsBaiCar.FieldByName('MCA_VALTOT').AsFloat, 2);
    cdsBaiCar.FieldByName('MCA_SELSTA').AsFloat  := cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat;
    cdsBaiCar.FieldByName('MCA_SELQTD').AsFloat  := 1;
    cdsBaiCar.FieldByName('MCA_TOTTAX').AsFloat  := cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat;

    If Not fEmptyStr(objConcil.strChavePrimaria) Then
      cdsBaiCar.FieldByName('CHAVECONCILIACAO').AsString := fRetornaChaveConciliacao(cdsConCar);

    If AFreteMarketPlace <> 0 Then
      cdsBaiCar.FieldByName('FRETE_MARKETPLACE').AsFloat := AFreteMarketPlace;

    If AAjusteMarketPlace <> 0 Then
    Begin
      //Dependendo da forma que foi gravado pelo fullfilment, não pode gerar o ajuste
      If cdsBaiCar.FieldByName('MCA_VALSTA').AsFloat > cdsBaiCar.FieldByName('MCA_VALTAX').AsFloat Then
        cdsBaiCar.FieldByName('AJUSTE_MARKETPLACE').AsFloat := AAjusteMarketPlace - AFreteMediacao;
    End;

    If ACupomMarketPlace <> 0 Then
      cdsBaiCar.FieldByName('CUPOM_MARKETPLACE').AsFloat := ACupomMarketPlace;

    If AFreteMediacao <> 0 Then
      cdsBaiCar.FieldByName('SUBTRAIR_FRETE').AsFloat := AFreteMediacao;
  End;

  cdsBaiCar.Post;

  If fParcelaSemTaxaComValorDivergente Then
  Begin
    objIncons := TInconsist.Create;

    objIncons.strDescri := 'Parcela com divergência de valor';
    objIncons.strCodCar := cdsBaiCar.FieldByName('MCA_CODCAR').AsString;
    objIncons.strDesCar := cdsBaiCar.FieldByName('CAR_DESCAR').AsString;
    objIncons.strAutori := cdsBaiCar.FieldByName('MCA_NUMNSU').AsString;
    objIncons.strCodCli := cdsBaiCar.FieldByName('MCA_CODCLI').AsString;
    objIncons.strNomCli := cdsBaiCar.FieldByName('CLI_NOMCLI').AsString;
    objIncons.strNomEmp := cdsBaiCar.FieldByName('MCA_CODEMP').AsString + ' - ' +
                           fRetNomeEmpresaSelec(cdsBaiCar.FieldByName('MCA_CODEMP').AsString);
    objIncons.strNum_PV := cdsBaiCar.FieldByName('MCA_ESTABE').AsString;
    objIncons.strTipCar := 'AJUSTE DE PARCELA';
    objIncons.strDta_CV := FormatDateTime('dd/mm/yyyy', cdsBaiCar.FieldByName('MCA_DTACUP').Value);
    objIncons.strDtaVen := FormatDateTime('dd/mm/yyyy', cdsBaiCar.FieldByName('MCA_DTAVEN').Value);
    objIncons.strDtaRec := objIncons.strDtaVen;
    objIncons.strParcel := strBloqPa;
    objIncons.strNumCar := strBloqCa;
    objIncons.strNumCCD := cdsBaiCar.FieldByName('MCA_NUMCCD').AsString;
    objIncons.strValori := FormatFloat('#,##0.00', fFormataFloat(fltValAju, 2)*-1);
    objIncons.strValLiq := objIncons.strValori;
    objIncons.strNumNsu := cdsBaiCar.FieldByName('MCA_NUMNSU').AsString;
    objIncons.strPorBai := cdsBaiCar.FieldByName('CAR_PORBAI').AsString;
    objIncons.strCtaBai := cdsBaiCar.FieldByName('CAR_CTABAI').AsString;
    objIncons.strForTax := cdsBaiCar.FieldByName('CAR_FORTAX').AsString;
    objIncons.strSituacaoCadastro := cdsBaiCar.FieldByName('SIT_CAD').AsString;

    If blnGraAju Then
      pGravaAjustes(objIncons);

    pGravaInconsistencia(objIncons);
    FreeAndNil(objIncons);

  End;

end;

procedure TConciliacaoCartoes.pTotalRelInc;
begin
  frxRelatorio.DataSet  := cdsInconsistencia;
  frxListArq.DataSet    := cdsListArq;
  frxSemRed.DataSet     := cdsSemRed;
  frxTotBan.DataSet     := cdsTotBan;
  frxTotalFinal.DataSet := cdsTotalFinal;

  frxPagina.DotMatrixReport             := False;
  frxPagina.PrintOptions.PrintMode      := pmScale;
  frxPagina.PrintOptions.PrintOnSheet   := 9; //A4
  frxPagina.Script.Variables['NOMEMP']  := fRetNomeEmpresa;
  frxPagina.Script.Variables['PERIODO'] := 'Período de ' + strDtaIni + ' até ' + strDtaFim;

  TfrxReportPage(frxPagina.FindObject('qckRedeCard')).PaperSize := 9;
  TfrxReportPage(frxPagina.FindObject('qckMarketPLace')).PaperSize := 9;

  TfrxMemoView(frxPagina.FindObject('rllTextoInconsistentePIX')).Visible := FConciliacaoComPixAtivado;
  TfrxMemoView(frxPagina.FindObject('rllQtdInconsistentePIX')).Visible := FConciliacaoComPixAtivado;
  TfrxMemoView(frxPagina.FindObject('rllValorBrutoInconsistentePIX')).Visible := FConciliacaoComPixAtivado;
  TfrxMemoView(frxPagina.FindObject('rllValorLiquidoInconsistentePIX')).Visible := FConciliacaoComPixAtivado;
  TfrxMemoView(frxPagina.FindObject('rllTextoTotalPIX')).Visible := FConciliacaoComPixAtivado;
  TfrxMemoView(frxPagina.FindObject('rllQtdTotalPIX')).Visible := FConciliacaoComPixAtivado;
  TfrxMemoView(frxPagina.FindObject('rllTotalBrutoPIX')).Visible := FConciliacaoComPixAtivado;
  TfrxMemoView(frxPagina.FindObject('rllTotalLiquidoPIX')).Visible := FConciliacaoComPixAtivado;

  TfrxMemoView(frxPagina.FindObject('rllTextoInconsistenteBoleto')).Visible := LConciliacaoComBoletoAtivado;
  TfrxMemoView(frxPagina.FindObject('rllQtdInconsistenteBoleto')).Visible := LConciliacaoComBoletoAtivado;
  TfrxMemoView(frxPagina.FindObject('rllValorBrutoInconsistenteBoleto')).Visible := LConciliacaoComBoletoAtivado;
  TfrxMemoView(frxPagina.FindObject('rllValorLiquidoInconsistenteBoleto')).Visible := LConciliacaoComBoletoAtivado;
  TfrxMemoView(frxPagina.FindObject('rllTextoTotalBoleto')).Visible := LConciliacaoComBoletoAtivado;
  TfrxMemoView(frxPagina.FindObject('rllQtdTotalBoleto')).Visible := LConciliacaoComBoletoAtivado;
  TfrxMemoView(frxPagina.FindObject('rllTotalBrutoBoleto')).Visible := LConciliacaoComBoletoAtivado;
  TfrxMemoView(frxPagina.FindObject('rllTotalLiquidoBoleto')).Visible := LConciliacaoComBoletoAtivado;


  TfrxBand(frxPagina.FindObject('ReportSummary1')).StartNewPage := (cdsInconsistencia.Active) And
                                                                   (cdsInconsistencia.RecordCount > 0);
  TfrxMemoView(frxPagina.FindObject('rllQtdAnt')).Text := InttoStr(arrTotRel[0].intQtdCar);
  TfrxMemoView(frxPagina.FindObject('rllQtdCPa')).Text := InttoStr(arrTotRel[1].intQtdCar);
  TfrxMemoView(frxPagina.FindObject('rllQtdCRo')).Text := InttoStr(arrTotRel[2].intQtdCar);
  TfrxMemoView(frxPagina.FindObject('rllQtdDeb')).Text := InttoStr(arrTotRel[3].intQtdCar);
  TfrxMemoView(frxPagina.FindObject('rllQtdTotalPIX')).Text := InttoStr(arrTotRel[4].intQtdCar);
  TfrxMemoView(frxPagina.FindObject('rllQtdTotalBoleto')).Text := InttoStr(arrTotRel[5].intQtdCar);
  TfrxMemoView(frxPagina.FindObject('rllQtdCan')).Text := InttoStr(objTotCan.intQtdCar);
  TfrxMemoView(frxPagina.FindObject('rllTotAnt')).Text := FormatFloat('#,##0.00;-#,##0.00', arrTotRel[0].fltValCar);
  TfrxMemoView(frxPagina.FindObject('rllTotCPa')).Text := FormatFloat('#,##0.00;-#,##0.00', arrTotRel[1].fltValCar);
  TfrxMemoView(frxPagina.FindObject('rllTotCRo')).Text := FormatFloat('#,##0.00;-#,##0.00', arrTotRel[2].fltValCar);
  TfrxMemoView(frxPagina.FindObject('rllTotDeb')).Text := FormatFloat('#,##0.00;-#,##0.00', arrTotRel[3].fltValCar);
  TfrxMemoView(frxPagina.FindObject('rllTotalBrutoPIX')).Text := FormatFloat('#,##0.00;-#,##0.00', arrTotRel[4].fltValCar);
  TfrxMemoView(frxPagina.FindObject('rllTotalBrutoBoleto')).Text := FormatFloat('#,##0.00;-#,##0.00', arrTotRel[5].fltValCar);
  TfrxMemoView(frxPagina.FindObject('rllLiqAnt')).Text := FormatFloat('#,##0.00;-#,##0.00', arrTotRel[0].fltValLiq);
  TfrxMemoView(frxPagina.FindObject('rllLiqCPa')).Text := FormatFloat('#,##0.00;-#,##0.00', arrTotRel[1].fltValLiq);
  TfrxMemoView(frxPagina.FindObject('rllLiqCRo')).Text := FormatFloat('#,##0.00;-#,##0.00', arrTotRel[2].fltValLiq);
  TfrxMemoView(frxPagina.FindObject('rllLiqDeb')).Text := FormatFloat('#,##0.00;-#,##0.00', arrTotRel[3].fltValLiq);
  TfrxMemoView(frxPagina.FindObject('rllTotalLiquidoPIX')).Text := FormatFloat('#,##0.00;-#,##0.00', arrTotRel[4].fltValLiq);
  TfrxMemoView(frxPagina.FindObject('rllTotalLiquidoBoleto')).Text := FormatFloat('#,##0.00;-#,##0.00', arrTotRel[5].fltValLiq);
  TfrxMemoView(frxPagina.FindObject('rllQtdRes')).Text := InttoStr(arrTotRel[0].intQtdCar + arrTotRel[1].intQtdCar + arrTotRel[2].intQtdCar + arrTotRel[3].intQtdCar + arrTotRel[4].intQtdCar + arrTotRel[5].intQtdCar);
  TfrxMemoView(frxPagina.FindObject('rllTotRes')).Text := FormatFloat('#,##0.00;-#,##0.00', arrTotRel[0].fltValCar + arrTotRel[1].fltValCar + arrTotRel[2].fltValCar + arrTotRel[3].fltValCar + arrTotRel[4].fltValCar + arrTotRel[5].fltValCar);
  TfrxMemoView(frxPagina.FindObject('rllLiqRes')).Text := FormatFloat('#,##0.00;-#,##0.00', arrTotRel[0].fltValLiq + arrTotRel[1].fltValLiq + arrTotRel[2].fltValLiq + arrTotRel[3].fltValLiq + arrTotRel[4].fltValLiq + arrTotRel[5].fltValLiq);
  TfrxMemoView(frxPagina.FindObject('rllBruCan')).Text := FormatFloat('#,##0.00;-#,##0.00', objTotCan.fltValCar);
  TfrxMemoView(frxPagina.FindObject('rllLiqCan')).Text := FormatFloat('#,##0.00;-#,##0.00', objTotCan.fltValLiq);
  TfrxMemoView(frxPagina.FindObject('rllZebra2')).Highlight.Color := fCfgSis('CORZEB');
  TfrxMemoView(frxPagina.FindObject('Child1')).Visible := True;
  TfrxMemoView(frxPagina.FindObject('Child8')).Visible := True;
  TfrxMemoView(frxPagina.FindObject('rllMenAju')).Memo.Clear;
  If (blnGraAju) Then
  Begin
    If blnAjuCon Then
      TfrxMemoView(frxPagina.FindObject('rllMenAju')).Memo.Add(
        '**Lançamentos de Cancelamentos/Ajustes já lançados na Movimentação Bancária. '+
        ' Verificar a necessidade de lançar novamente manualmente caso estornado.')
    Else
      TfrxMemoView(frxPagina.FindObject('rllMenAju')).Memo.Add(
        '**Lançamentos de Cancelamentos/Ajustes serão lançados automaticamente na Movimentação Bancária.');

    If (Not FLancarAjustesACredito) And (FTemAjusteACredito) Then
    begin
      TfrxMemoView(frxPagina.FindObject('rllMenAju')).AllowExpressions := False;
      TfrxMemoView(frxPagina.FindObject('rllMenAju')).Memo.Add(
        '***Registros de "Cancelamentos/Ajustes a crédito" devem ser lançados manualmente, pois a [CFG_AJUCRE] está desabilitada.');
    end;
  End
  Else If (Not FLancarAjustesACredito) And (FTemAjusteACredito) Then
  Begin
    TfrxMemoView(frxPagina.FindObject('rllMenAju')).AllowExpressions := False;
    TfrxMemoView(frxPagina.FindObject('rllMenAju')).Text := '***Registros de "Cancelamentos/Ajustes a crédito" devem ser lançados manualmente, pois a [CFG_AJUCRE] está desabilitada.';
  End;

  TfrxMemoView(frxPagina.FindObject('Child4')).Visible := Not fEmptyStr(strResumo);
  frxPagina.Script.Variables['RESUMO']                 := strResumo;

  TfrxReportPage(frxPagina.Pages[1]).Visible := True;
end;

function TConciliacaoCartoes.RetornaDescricaoDaInconsistenciaNaTaxaAdministrativa: String;
begin
  Result := 'Taxa de administração do registro importado difere da taxa cadastrada para a operadora.';

  If String(fCfgSis('VLDTAX',varString)).Equals('2') Then
    Result := 'Taxa de administração do registro importado difere da taxa da movimentação do cartão.';
end;

function TConciliacaoCartoes.RetornaFiltroCodigoConciliacao: String;
  Var
    I: Integer;
begin
  Result := ' ';

  If (High(arrCodigoConciliacao) < 0) Then
    Exit;

  If ((High(arrEmpresa) >= 0) Or (High(arrPonVen) >= 0)) Then
    Result := ' OR ';

  Result := Result + objConcil.strCodCon + ' IN (';

  For I := 0 To High(arrCodigoConciliacao) Do
  Begin
    Result := Result + '"' + arrCodigoConciliacao[I].strCodigo + '",';
  End;

  Result := Copy(Result, 1, Length(Result) - 1) + ') ';

end;

function TConciliacaoCartoes.RetornaInAutorizacaoFiltrar: String;
  Var
    LValor: String;
begin

  If Not fEmptyStr(FInAutorizacaoFiltrar) Then
    Exit(FInAutorizacaoFiltrar);

  Result := '""';

  cdsConCar.First;
  While Not cdsConCar.Eof Do
  Begin
    LValor := '"' + fStrZero(cdsConcar.FieldByName(objConcil.strCodAut).AsString, 6) + '"';

    If Pos(LValor, Result) > 0 Then
    Begin
      cdsConCar.Next;

      Continue;
    End;

    If Not fEmptyStr(objConcil.strID) Then
      LValor := LValor + ',"' + cdsConcar.FieldByName(objConcil.strID).AsString + '"';

    Result := Result + ',' + LValor;

    cdsConCar.Next;
  End;

  cdsConCar.First;
end;

function TConciliacaoCartoes.RetornaInNsuFiltrar: String;
  Var
    LValor: String;
begin

  If Not fEmptyStr(FInNsuFiltrar) Then
    Exit(FInNsuFiltrar);

  Result := '""';

  cdsConCar.First;
  While Not cdsConCar.Eof Do
  Begin
    LValor := '"' + fStrZero(cdsConcar.FieldByName(objConcil.strNumNsu).AsString, 14) + '"';

    If Pos(LValor, Result) > 0 Then
    Begin
      cdsConCar.Next;

      Continue;
    End;

    If Not fEmptyStr(objConcil.strID) Then
      LValor := LValor + ',"' + cdsConcar.FieldByName(objConcil.strID).AsString + '"';

    Result := Result + ',' + LValor;

    cdsConCar.Next;
  End;

  cdsConCar.First;
end;

function TConciliacaoCartoes.RetornaSituacaoCadastroAjustesTransferencias(
  AEmpresa: String): String;
begin
  Result :=  'INCOMPLETO';

  If (AEmpresa.Trim.IsEmpty) Then
    Exit;

  If fEmptyStr(fCfgSis(objConcil.strConfPr, varString, AEmpresa)) Then
    Exit;

  If fEmptyStr(fCfgSis(objConcil.strConfCt, varString, AEmpresa)) Then
    Exit;

  If fEmptyStr(fCfgSis(objConcil.strConfFo, varString, AEmpresa)) Then
    Exit;

  If fCfgSis('CTPOBE', varBoolean) Then
  Begin
    If fEmptyStr(fCfgSis(objConcil.strEventoCancelamentoAjuste, varString, AEmpresa)) Then
      Exit;
  End;

  Result :=  'COMPLETO';
end;

function TConciliacaoCartoes.RetornaSituacaoCadastroInconsistencias(
  AInconsistencia: TInconsist): String;
begin
  Result := 'INCOMPLETO';

  If (AInconsistencia.strDesEmp.Trim.IsEmpty) Then
    Exit;

  If AInconsistencia.strPorBai.Trim.IsEmpty Then
    Exit;

  If AInconsistencia.strCtaBai.Trim.IsEmpty Then
    Exit;

  If AInconsistencia.strForTax.Trim.IsEmpty Then
    Exit;

  If fCfgSis('CTPOBE', varBoolean) Then
  Begin
    If AInconsistencia.strEventoCancelamentoAjuste.Trim.IsEmpty Then
      Exit;
  End;

  Result := 'COMPLETO';
end;

function TConciliacaoCartoes.RetornaTaxaParaValidacao: Double;
begin
  Result := cdsBaiCar.FieldByName('CAR_PERDES').AsFloat;

  If String(fCfgSis('VLDTAX',varString)).Equals('2') Then
    Result := cdsBaiCar.FieldByName('TAXA_ADM_ORIGINAL').AsFloat;

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

  LRegistros := CriarClientDataSet(cdsBaiCar);

  Try
    LRegistros.Filter := 'MCA_MARDES=''M'' AND REGISTROTRANSFERENCIA=''N'' ';
    LRegistros.Filtered := True;

    LRegistros.First;
    While Not LRegistros.Eof Do
    Begin
      Inc(AQuantidadeBaixados);

      ABrutoBaixados := ABrutoBaixados + fFormataFloat(LRegistros.FieldByName('MCA_VALSTA').AsFloat, 2);
      ALiquidoBaixados := ALiquidoBaixados + fFormataFloat(LRegistros.FieldByName('MCA_VALREC').AsFloat, 2);

      LRegistros.Next;
    End;
  Finally
    FreeAndNil(LRegistros);
  End;
end;

function TConciliacaoCartoes.RetornaValorTolerancia(ACodEmp: String;ADefault: Double): Double;
begin
  If fEmptyStr(objConcil.CfgVlrTolerancia) Then
    Exit(ADefault);

  If fEmptyStr(ACodEmp) Then
    ACodEmp :=  VS_strCodEmp;

  Result := fCfgSis(objConcil.CfgVlrTolerancia,varCurrency,ACodEmp);
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
                  (fFormataFloat(AValorBruto * (RetornaTaxaParaValidacao / 100), 2))
  else
    LDiferenca := LDiferenca - RetornaTaxaParaValidacao;

  Result := Not fBetween(LDiferenca, -0.039999, 0.0399999);
End;

{ TInconsist }

constructor TInconsist.Create;
begin
  FstrNomArq := '';
  FstrDescri := '';
  FstrValori := '';
  FstrAutori := '';
  FstrNum_PV := '';
  FstrNum_RV := '';
  FstrNumCar := '';
  FstrTipCar := '';
  FstrDta_CV := '';
  FstrDtaVen := '';
  FstrValRec := '0,00';
  FstrNomEmp := '';
  FintConcil := 0;
  FstrParcel := '';
  FstrPerTax := '';
  FstrNumNsu := '';
  FstrNumCcd := '';
  FstrValLiq := '0,00';
  FstrBandei := '';
  FstrCodCar := '';
  FstrDesCar := '';
  FblnTotali := True;

  FNegociacaoRecebiveis := 'N';
  FNumeroOperacaoNegociacao := '';

  FBrutoMarketPlace := 0.00;
  FLiquidoMarketPlace := 0.00;
  FTaxasMarketPlace := 0.00;
  FAjustesMarketPlace := 0.00;
  FFreteMarketPlace := 0.00;
  FCupomMarketPlace := 0.00;

  FValorCartaoSistema := 0.00;
  FDiferencaValorBruto := 0.00;
end;

end.
